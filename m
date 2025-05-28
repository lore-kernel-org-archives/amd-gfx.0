Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689B3C5AD49
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 20:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE04210E6C2;
	Wed, 28 May 2025 20:54:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cKqjz/tA";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E922E10E6C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 20:54:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaQKHqUDW98Yo47l0EMzM6cfttLWAE9j6QEI59ccz1CAJXb07OhBeOCsGscplpJWs1L1X8rIb7qBS7cFLRai8wHz5snqpXafNuYCj3eiFymbpz2bVvOsnQfO/baVbW1EUYCN8bvsS57tvC9Rrs/6lDIyLuuTIajjWy2GG61DBezJvHeY+H9W6NdRHLywlqEjJxdy+t387xnkaEfeRc+SqkiR0oXfKdyUg5tlSC+PjWpK0hHtPkqFUcvsI79Kdyh+ywEVByNsNOSfUZRux6dGJiFbnNV4mF3JyEVsIFJPnrvKe0iduuJirxwznfJK2mrUBCTcWiZDSZgNyuZCSiIjbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15oKjml1SSwzr1eH3Qs5/6qdra0slPU+opnxnqSzQL0=;
 b=gqgJEniAcFCrtPZyveLTqZli3JPfSWoAO4lXP7qlyoNQ9Uan6jQy1HCxpvFlk5C+5qqE6p4Im6P8y4LfMkuEHNrsrp3UJDgFfuI9wu9Y7LDt+bd1/RLOhChS84XHLHljCa15ux7vMdWfByDNtNVs/Z80husM8ILMO8l4vze5h8yzLea/E+J+etD2X3p9apPDcSozfQvgh4yX9CCsxqZrcv5XHFPHAKiZUxfgBqFZQpoE77HPy4qCt3SJ1GYTZagoZjGip9EAQJ4NqwBOunhr8TdIx0MyIlnsDWC0IcI6nUM3YLo688moQp1pHuPt6CnScYdKP82uN3UQjJO9G+P+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15oKjml1SSwzr1eH3Qs5/6qdra0slPU+opnxnqSzQL0=;
 b=cKqjz/tAqlVNb+Cm+Zij8oHi37bhUU6TvEK74x6CtZeM5+JGa/FIi+tzZyQWDNsDje44s+s3iGDRR1evkbVxVy1UVhyrcAmuRBVSLxdk4WcfseAdqBXbY0vaNQPPWV/UV3ftsq+3LCs5D8beAW1pDBRpxoEB38e64nuGWvQy6a8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Wed, 28 May
 2025 20:54:07 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%6]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 20:54:07 +0000
Message-ID: <942215f5-9f11-f38b-f287-e0ea5ee23533@amd.com>
Date: Wed, 28 May 2025 16:54:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] drm/amdkfd: remove unused code
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 philip.yang@amd.com
Cc: Felix.kuehling@amd.com, christian.koenig@amd.com, jamesz@amd.com
References: <20250528171908.82639-1-James.Zhu@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250528171908.82639-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0310.namprd03.prod.outlook.com (2603:10b6:8:2b::9)
 To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 746c10bc-4df6-42cc-0f53-08dd9e29c968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGlvOGYzN1E4clFRd2F4T0h1VVJjSUxENGtCSFJaR29QK2NZQStTMU9nOEZa?=
 =?utf-8?B?c2ZuQ2R1REp2dkZ1Q2FNWDFhMnRwNUZHdkNJM0JjWkZhd3dqMTRyNTNra1Ix?=
 =?utf-8?B?Y29kTEpnT1hOZDkrRGd0UGwrbWpGYnZFMGtoN2w0MllCWXB6MEdIc21MTWN0?=
 =?utf-8?B?ZEVDYXpJUjFPMGlUWExTeFlZOG83S0g3V0hpcDlDZFNDZ1RaT1pvMjVXZ0Yr?=
 =?utf-8?B?Mm0vTFBKSldoQTlXSnJBQXAwdEpuNGRoTktWdFlGSW1paUhnK1YwakxUQUpZ?=
 =?utf-8?B?ZDhwZUVHM0dQRlFvRmxjMjliZ1VTZUNtZ2ZXcmNIS3E4bloxNFNlTTRRYzlk?=
 =?utf-8?B?SmpKUUFNQWt6RUQ3NU44WkdWK2dKR0JwWWlPN3dmSGlQZXEzZ1g1VHlOalRW?=
 =?utf-8?B?TVRpeGZncUJFVVk0RGRRL1M2RU1MeGgzNFFQZVZQTlpCMUJ5bEdnd1pjc25E?=
 =?utf-8?B?QzcxYmVjTXozSndGR250NnJQZGdOUzV6QWVYazJ6dFhIdjRIdm1TcmsvdFFK?=
 =?utf-8?B?eWZsK3gzYVdPYllOMm5kVmNUNUN6V1FOTFlHQUlIbnlxZWlJM1RJdUZUaU9Z?=
 =?utf-8?B?WEZSd1RTdzN5RnV6TGJWZ3NVV0o1ZXNCdUVFY1lpVGkvOWNobnlJdGZrakxR?=
 =?utf-8?B?VWZpRjBGZXB1bVFNYlpGNlpQTlJscTZzOGJKays5cFhNRkVvSWNSdjl1b0NR?=
 =?utf-8?B?VUp0OVA2cFRPTjVEV0FRNDJzVXRXTEU2SUZrRkpyZ2UxSUcvblRSR0hrYk4v?=
 =?utf-8?B?TnYycVVIQUpqL3ZMTENFdmdob2cvWWNYelN1K2l4R284ZGY2QktqY0g0cElT?=
 =?utf-8?B?MlRwY3FkRGVacEovRktJMEkvcXdyeVFXTWVtSlVHMGJBNVlNV05JNitJRmpM?=
 =?utf-8?B?L3Z4cE1NUUxGc1FZcnVoaFcxRDdra2FZV2p5TkhacVRNaXNoVmhNamtOaFpK?=
 =?utf-8?B?cS93ckppU0pMV2xpZFBKdW5XYXFtZ1ZCRFc1ZTdBbmRTa002VjE1eXdKZWpK?=
 =?utf-8?B?RVJMTWdRUWg5VXVtTWRGWUczQkxyWVNRQkpnU2FRaTZ3ZTJPM0dyem4veEpM?=
 =?utf-8?B?VTJMMGJhNjRheWFoOTY2dzI0N0x4REhzVkRpdDMrMS9idTBLeGJFbG9GNCtw?=
 =?utf-8?B?VmRNait4ZzNuVlBIWHMrWEpucXVvdytGbzVua0dWZFFVOTJreG8vUVpXTVJ5?=
 =?utf-8?B?d3pYdE5MOXhLQ2ZJeHNlYVRRb0V2YlJIQW00SkZLQnVrOURmeFg1L1F1Qk45?=
 =?utf-8?B?TW1jN2xwUGp5YU9GS25aTGcxbnNpVkFhVVIzblZXdjlPVWZTNWtMQ0hiNVda?=
 =?utf-8?B?WWtvVjA1WTV0KzhVUlVTK2lUNmxYNW9SZGQ5ekt3c05Vc3h1UTRIYnhKZ3l3?=
 =?utf-8?B?QUt0aTFHSC84UFhRSTE1N0YvNUdtWnY3ZTFjVm5EdjFML3l5bHRGWHp2UGlp?=
 =?utf-8?B?d0QxZUY1ZUxBUEZYV1JIUUE0b2lYeFU3RkJwRTR2bCtjekJCZXBaVEFqMHd3?=
 =?utf-8?B?bmxIb3d4bkVrNXZ2NUhBMndWaUNON3NrQ0hTRFh6bHJ4MXVZRzdONWdZakZr?=
 =?utf-8?B?eEliR0krYzdLNmZkYmVKVE1IQndPcWk3UTJDT2Nic1pUVndhNkF2NFBiWjVU?=
 =?utf-8?B?ZjlwV3NoNVVSMW4zUHI2RXZobnRTVjVsSXZhSndtUXdseE1oUGJVSFA2QnYy?=
 =?utf-8?B?Mkc4K2cvTVMwcmJJaGpIYmdKV0M1eEg2Z1lFZEZFdCtxaGdMbW14MllteDFa?=
 =?utf-8?B?MXRORHcxZWxxdXBtUVpsYVhzclYyaEZodTI3QUtaaVZFQWlQUEtxWEdmU2Vm?=
 =?utf-8?B?ZWhqbS9tTmJZK0hvQ0Z0SFRlaC9kUjhnRGxkYVErMzJJYThKVUNEeUpjck9y?=
 =?utf-8?B?ZGhUU1czd09ZZ01hQ0hUY2wzTmRjNk9MV1B2VitRa2VJU21pY0RmdWkzTk5o?=
 =?utf-8?Q?DJFZ2zSGYMY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTZsZjhVZjBYeVUvYy9IVTdrWGFhaUpyTHNSRjFOMzVMNUQvR1FsNWN2OUNq?=
 =?utf-8?B?dVJrS0EyM1dQSncwNnZUYk15WlFqcmlkTVpzdk1QdnVmeGRHdXA4eFUwNGZ6?=
 =?utf-8?B?ZEtNenArMFVRd3JPbmdzaUhSaWFvTUhaVWc0T3kwZkF2WlpVc0RNZHRsTWl1?=
 =?utf-8?B?TDNwcjFJS3FOd0ZYVm40dkpkTFVJbDlEU0s2aFQzVjMxSHBCa2F5WjdYTFFr?=
 =?utf-8?B?WmhyOTcyZHZrR1hIU3N3K1o5V2JiTmdlRzlwcFNuYmpBSHkwYXBiWjZpZlc2?=
 =?utf-8?B?VWdYR0RXWWJpNFU4R1dqL3Mvb1hOWG9lNHZ2OXMvZEU5RDUzNThtQ216VTZB?=
 =?utf-8?B?MUZDR1RQMWRuNUo4cEJPYTkvNmM0RnJNS1hLdno1eG1GOWxvbkh3TzF1aHFW?=
 =?utf-8?B?VFlXd3ZOVmtMVVdFZDlEWTJCRnluREZwQjVwU0VvSVl6U1VHQmtGVWRlUXNv?=
 =?utf-8?B?RHRCM2ZuTEFjcld1ZFNYY1Q4ZTVEeUJxZFp6R2dhQ0NnYTJKM3JKQXBRcWZn?=
 =?utf-8?B?SDN6czZmTXFkTWkvU21uTG81cE1uayt4ejkydVVYbFp6M1VrWHZwVEJFTjFY?=
 =?utf-8?B?STJaZlh4bUhpQlFCWCtLbGc2aDRmRnhRay9nanpTYmRiZG84dm5xbTNGZTRo?=
 =?utf-8?B?MWV5ejVOL2s3QnpyOFRET3BvTXRjVzFseGppNWczZXZBeW9GQ2V0bkNaN1pT?=
 =?utf-8?B?UXNROXd4VGN2SVBOdGJHeTRTUkpqS041ZmVLWlV5UENDYU1pQmhnWXU1aVA3?=
 =?utf-8?B?ZHV5YTRhLy9CNCtvT0s0ZUVBMFZtSFdxc1NEMWE2U3Y5dFkwZERQNUR6elYv?=
 =?utf-8?B?eXFFQnBnUVVsK2ZLeG5FeENybVNvajZFSVc1U0Z6QWV2c1EzbkdhK24wUFV5?=
 =?utf-8?B?T0ZtdzBFdUo1ZkVlS3hzakt3Tml0cHZTelhTbWhlSFRCSjhFbkRUN3BweDhu?=
 =?utf-8?B?QzczMENQeXRsZmdrbThSTjYrcjhpM204WHRJaHRvL08xa0xubVl6SDBzYjZ6?=
 =?utf-8?B?aDI1Y21FUFdJZnB3dDJCY3QxUzQvNERuWVBqVURrNmoveklabGcvNEErQ2wv?=
 =?utf-8?B?SnNpVWFiSG5xZ1NBb2tjWStzdXQ3QjRidk9oSUlaaHVKWlRVRzBudnd5RnEz?=
 =?utf-8?B?TkhCbmk5eU9tcWdCcG4zWEsxSUtkb05CK0ZjTmhvcFpJUTgwN3lOeUxLTUpa?=
 =?utf-8?B?K0x4STU2YjN4Ly9FY0NZeW1WUDZ1dE8vd0o5VHlNTWtnZDBYQlAwS25WSmxv?=
 =?utf-8?B?WDNKa3NhSHVuV0cxbUpRM0dZN3dMRnFTVkZKSE43aGZKbDR4QmJjWW9rQ0g5?=
 =?utf-8?B?T3FOSDkyYjBPWUlyZ2JIOE1kU09BMUg1am9zdjlrOU5scEg2K2RBOE5VVWlv?=
 =?utf-8?B?TUd6cVV5cHEreG5mZzJHZW13YW5TelVHMjM4eEticms5alBQbWJDVnZVU0JX?=
 =?utf-8?B?cFc0aUdhZUw3dHJNQzBSUmk0UVA5UE9RbGdHKzVFZ09Rd2Yvb3hIU084MENy?=
 =?utf-8?B?Kyt3bDhabyt2aEprdkhCNlVWazJZcHBKV09uOEtUc1JaNThwbFMvU2h2bG93?=
 =?utf-8?B?SnR3czNMRkExRnNrR2dZUmpUMGVVc0ZIOEdUOUp2bXRGWkNNYUdGLzJHOG10?=
 =?utf-8?B?cGNYVTl6SjRFdVVZQUZsTjdBcG15K2NFVEdmWE9kRE1teTYvM3M1bWNmMVg2?=
 =?utf-8?B?SXZTTEZ1bmNsaG9XYlo3OXI4VnFLanVlS2drYUpaeGQ2Z29QTHhTbEZOMmVM?=
 =?utf-8?B?Mkg3cWY4d1ovRVBmdm5GMVdRcGxKakx2cVRYaGxmRjNxSVUvbUYrTEVZcjVU?=
 =?utf-8?B?eFEycmdLVzkvYXU2TXQvMW5KWk40YkhXM2hhZDhMMVN6SHNBK3kybUFQeWV1?=
 =?utf-8?B?T1ZZY3FDUDRnUUVra1RWMEo4WHhmZU9aenE5U3VmVXc1SnBGVE8zcTVjTUhp?=
 =?utf-8?B?WnBWc3p5M1RWajZmcFdUV3EwYnM4bzlEbkplR0syQk1aTHlmRWRrNElRMmhy?=
 =?utf-8?B?NU85RitmMU5QS2dDTkhrTXp1dUFlN3dNRGlOQ25FZE5KUGtTVnBXUm55ajBS?=
 =?utf-8?B?WEdoc2FldHNkdnhWZWIwTDEycjZIb3h4NHlydXRlQlNReFlOTnNZbGtSOE45?=
 =?utf-8?Q?+eW0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 746c10bc-4df6-42cc-0f53-08dd9e29c968
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 20:54:06.9389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7FGvWndZXUZCWPEEDiguBjhyn9Tsuugkt45GSY4/2yfbuFgiuno2/kuovKRCOXA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2025-05-28 13:19, James Zhu wrote:
> upages is assigned under cpages = 0, so it isn't really used in this function.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Philip.Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 79251f22b702..f0b690d4bb46 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -736,7 +736,6 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   	if (!cpages) {
>   		pr_debug("failed collect migrate device pages [0x%lx 0x%lx]\n",
>   			 prange->start, prange->last);
> -		upages = svm_migrate_unsuccessful_pages(&migrate);
>   		goto out_free;
>   	}
>   	if (cpages != npages)
