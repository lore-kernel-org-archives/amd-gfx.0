Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3229E7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 08:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72D2810E835;
	Tue, 10 Dec 2024 08:55:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ddM9FejX";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 856FE10E833
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 08:55:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoBvVWwoJlyOby7GI96wE/gY5f1W3CHumb3a2z1EG/hZobNuoETEOEo7nd/BltyX4qg+jCnNtyij4B8XNgbBfm+SLuvtoR5wnXA5B/Pxc/c0k+AxS6BsdxtclH/y6dEy6zkSpPt7cjXYbdUp+FiLT5RD7OLHctHgrLQVJW3cD8GV3DTIu7qcO75Ezup+fFj+63TvgGicTbcCan8i32qj2bTBWZvhrQnM1ovzN3QegqJlT0DcJVtG/GSXHO7zh3AmJdXWSVAqUK1h8jAERXhYZAtNYe5Qb5C+/bbz8uW58w3FgfC9HkiD3p2pLV4nCb79ctChpaxXAyLGcz0gujSvMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7D8EQoJwmGIol3MaTJIjPOEpFA022zX+zh1+3hYSBFk=;
 b=ZxQqjRgOrwLiJcO0UMUpuMJMgafWJGUrx8lxzvvsy8JzUKu8+Sslq1PmyMk0QBrMDrSvBtp9Y1u2COhl0eFkQpWkOsjUDUIE7iuCgA80SZpz3p0QrStpYoksbGoS/+JIhjqFySDuXd8LOrd8VjDUswYK5WionM5cJvhkF5Pk6qUJWPh8rJgPhsf4JyScJ1gjInwyYSxGaEhjTMjY+gS1i1Axom511vISnmLbi/uR+gGo75mU7G2ufhdqXUSQGwqT4ngNDLrYgOCH45DjQKtFDJfzvuknUEo3xs6SLnGFbql9LBrPmsH9rjkujEZm0ilB0PYI2DqFWAEvnfrOTX4e+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D8EQoJwmGIol3MaTJIjPOEpFA022zX+zh1+3hYSBFk=;
 b=ddM9FejXj0tXw2e7Z18bpLrXTyvvHzcFfLhxgJIqXUQySVqMWa5nKkEU7m8tUfb2PVL8+HemU5wqdtt5YsbJQUabUqysPwQ+v1VIQPgbM0bzwqSR8iDyUMhwMmG67XsqC5EeHU72ss53haFBuK8/8WYT/kUSl7cg+a6u83XRUfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6842.namprd12.prod.outlook.com (2603:10b6:510:1c9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 08:55:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 08:55:48 +0000
Message-ID: <6a68de4e-cd34-4a43-8abb-58ef4b9cc0a8@amd.com>
Date: Tue, 10 Dec 2024 09:55:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Update VM flush condition for
 'enforce_isolation'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241210085022.64465-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241210085022.64465-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: 7345d220-9b21-4812-37bb-08dd18f87114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N09yZG1Ud2tETnVzN1NHdXEyRE5hUVhqbmRQNzVuZThJTy9QcC82SzdURHZP?=
 =?utf-8?B?OS9sTXNpa0h0SENLOTg3UFNXL3pWL0JvZlY5d3FhVmY0UUZpYysrQjRNVUkw?=
 =?utf-8?B?K1cxMzBQckZHeUJJN050djV1SWdNaUcvci9HZ3ZyNDJlY050T3JFV0RUYzkz?=
 =?utf-8?B?VjR0THJYRUlrWEtmcW9vWGVDalZpUmZwZ0xmSHlvNXJjdmNYd1duYktUOVlB?=
 =?utf-8?B?SGErUVRFU1RmVS9ybG9qZ0ZVU2dISS9mclRBY3N0cFJGY2I1VDJkbEhhUHVD?=
 =?utf-8?B?SlMxdktMSHNxRzh4RDFJb2l2cFlGa09mUzRJZStHanhEUDZUNFB2Ukp3NEZP?=
 =?utf-8?B?d2VFOW5CMm5NQTVhaTZUbnFTSER3cWJyMWM1L0pac25uL3dYY1VyaTNnbUkw?=
 =?utf-8?B?c2k4ZlE5Qk1CaWY1YjB5U2x2S3U0aDRJM200ZDB4T0J5ci9zRC92enNseXMx?=
 =?utf-8?B?RmZGR1hLWTNaV3Z6aVJ3U29TemV0c0Y3OVBDYzZiY2Z6SDg5TFo0VXV5NzFn?=
 =?utf-8?B?T0JZaW9HQmNNYmUrdWl6czgzOTQwaU4yV0VtMG5tWFJoWnVTWUg0byttaHF6?=
 =?utf-8?B?UTk0VWtFSTJ2WkFLNVM0YzMwVjZNS0NFZUd4dm1vRVdVdG5vRmNMdC91dEd6?=
 =?utf-8?B?T0VtS1FNNXhJbWkyVEtjTHNuOC9mdkVSbzFRaWc2ejZZVDJrbHJHOTFSR3Rl?=
 =?utf-8?B?eThCa3AyZ1ByQVJyMkl6WEtpZDRoMTM3TCt6YjZYYmRwdThld2FsUzZRYzJF?=
 =?utf-8?B?V0JOa21YaUttbFlFZm5zTGpDblJqNk40TkYveFllR1Y3VUtKOE9ET3VTVENr?=
 =?utf-8?B?bmtuWXZYb2hJTTVmTzJRalFpdTFiU1R1N0dSOHJqSmc2eC95VzVJUHBGS01Q?=
 =?utf-8?B?TEY5NGZseFk3dWtIelc0cHcvY21zV2I1VjhQK3hZcjAyc1pxa3BuczBUcTho?=
 =?utf-8?B?UVlueGlaMDJSTHBBRVRBRnNHM3ljelBHT2I0M1NlY3YyRDNMbGlaOVVaSnpn?=
 =?utf-8?B?Q1B0ZHU5MlE3YWs3RTFlbDZSd3Vmam1HOGhXRWY0NTNoL040MW1HejN2SGtN?=
 =?utf-8?B?RWZ6QkppT0JQdmh6TXhnUFZnN280QjZRcTUyVkVIOWlFenRhdkEwdEQwOVY0?=
 =?utf-8?B?Nk11cGRMSEI2QktMdHVtdmtDVFNlMTVDVm1kNi9JYmU0QmFWbElDSWVVZUpk?=
 =?utf-8?B?YmZKTzZCQWhIbjB3S3BnNitNdWlENXRySTh1N01yQUgrV2RsN01EcUZvbWpN?=
 =?utf-8?B?NEgzemV1NTZ3bkUrdGppTkxiYXFqK1l3WHZUczErQk1sQk1JNHFHSC9DSjRH?=
 =?utf-8?B?WVRYZXVlbFg5dG5kUnBkRHUxOVJDOE1rRWR2MWlJMkpod1dWQXZBanZDY3lq?=
 =?utf-8?B?NGYrQlY3YmdRc1ZVaTFMUWlNTktpQ1Z0Y3JMQkwrcG0xSmk1dDlUNU5ORHRG?=
 =?utf-8?B?R2FEaTArU2g5TjcyZWd1cWlDMXVqWEhQbEpacm1CMFBNS2ZwMDA2TkdqWVpJ?=
 =?utf-8?B?c2MxWkZGVkYrQlRHRG5tbUVpdjUxaTNEbVl2S0t0VDhYaTZUWnlOTGJGRlow?=
 =?utf-8?B?SXlJclh1ZnpWK1Mxb0Y1VmRFMEpxODBFQ0RoTCs1YmxTNy9pUFlFT01lRUMv?=
 =?utf-8?B?U3JKeGZkN284dStGMHdPNVQ0alNjbGJQRGFmV1BCMExrbVdYWi93S21lVEU5?=
 =?utf-8?B?bmxFeDE4WWVaOElJanpRZzQxdDkrYXcyOUNsQVh2T2hPdmFsUXZkRFMyRkMr?=
 =?utf-8?B?VHZFSFlRb2NyOTJ0eGh4VVdDV0k5elJxVnVFdVBwT1pBbXd3am9xMEpZUElr?=
 =?utf-8?Q?p7fYHGewG8tmQQCqcmVf5kAZ0UxL5ZJsJ7zxo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODA3WEt5ZXdMcnJBdHVOazBwRW5EUjg4S0RNVWN2YUlsTUF2NXpLK0pQejZR?=
 =?utf-8?B?Z1k1ZWEvUS83cER5YjlRK24wYzJPZ2dNdUdIdDN5OUZzd05RWkRaUEw0QTZ1?=
 =?utf-8?B?dytLcEcxZ01TL0RVem1XTStRV016RXRxQzJ4OFV2cU9pZFVtaVJUZ3hPcWhP?=
 =?utf-8?B?WWdjSG4wY2xLTGNXSkQyRmlTSUhOcllJTFhKMjF5NzN1aE02UjZmV01DQnBj?=
 =?utf-8?B?WFBrUlBDMy92OXdWTXpPOEdDVTdYWGFacXhnRmEwUXlXRno5a3h4TmxmN25K?=
 =?utf-8?B?THF6WWJhN0grUjJMZWVlUUVrTFc0QVlkVFZMRFgrd0JZNXEycUg2MzVEZnB6?=
 =?utf-8?B?emlnYlRXUzdUc1pkdm85VzlneThVdkV2blVXaUFTR09YRC96NENYZEsxMUNv?=
 =?utf-8?B?NEdqRzlpVlF5TnRZUjR3MW9RcHpSMlcrOWltYVZ4VjVVZXMxcnQzWGpHMGNz?=
 =?utf-8?B?ZFpSMFJSYXg1WDY5b25qWmVTVXNZMko0UkVSSWpuV1FmWTNaeXBVYTd0dGZw?=
 =?utf-8?B?R0k1cEVoYU9yNUZsWXY4K29HRUtqalBvelg4SVhDTFF4NHVvdWNVcmNTbWVt?=
 =?utf-8?B?MU9sVUR0dktuTVJXOWl3NUxYK2hJeHZwOThDUUFBdHZodFZqMUJyeGZIdmpr?=
 =?utf-8?B?SjdjbUdsZjVydnhodVllOUZqb1dkWjNMRFZWRUV4UmFETVI0YVJDaERHa2hY?=
 =?utf-8?B?dlB4VzY3SENFZWFrRVRndDlHejdoUWhxNUdaRmpOYk5hQ3RYZk5xZ05HVmNz?=
 =?utf-8?B?bTRsWEI2UTRKVHdSaGUrQ0RacDJrNVZFQkpZU1QzSENkSis1N3h0TEVUVmNk?=
 =?utf-8?B?MTJIZWZwUXBUenF5SmFwWUt5ZTNrazZnNEhadGpVMFk4MVQ1TFpVeUEwVWxw?=
 =?utf-8?B?eHp6Si80eFZ3QVpsWVk0amhSOFRCdVFNMXhtVktQWUVESGhwYUZseUNMdW9L?=
 =?utf-8?B?dkJObEllUE9XVUVOZHhlb2FERytvSTJtLzd5TEFsMlIraFI0a3RwZE04Unox?=
 =?utf-8?B?anhPeHUxVUx4aitDVGtJTUtmdGJoUHYzUWVtTTh4d2c1NktrOHJwaXlleGJB?=
 =?utf-8?B?QWNvRU9MazhXSGxpOUlaSVB2YjNWZXc5dUZSekpveDgzSGpSTlR0d2NYYzBl?=
 =?utf-8?B?R2pHT3VPcGxKbDlRbWM5RmNIVUw3SVhrZ2hnZnhvb2FjVmhlWVZJdUJhSUlw?=
 =?utf-8?B?Y2NkUTF0WmpVMUt4UjdXaVBOeEJaeWN0V0Z4WExDMnllYlVCcEZNcVpIOTBJ?=
 =?utf-8?B?RkxHVFU5TXlabGRuZFpMWG82cUJQV0ZSWm5aUDRxQ0xsRnlSY1gzZm1GZDhK?=
 =?utf-8?B?SDI2WU1XSy92M2VHNm53ejNqU09DT0ZPUkQ0bUJ1bVJmNWVsbm1Ca2dNSXB3?=
 =?utf-8?B?UnhBYndBYXBSSnVGSERDV3MzSlI4eCs4akhFU29raG0yQnhyRHRaSHgySG1p?=
 =?utf-8?B?TCtucUtOT2p1S2g0S1l6dW1uTStnNFYzd0poa0F1S1JZWlBjdmNGS3lmbTBy?=
 =?utf-8?B?bFZUOTFDeTFPaTJTOWlmbFFYc0FRREpXd29iVzB3WFVHemZBeEZkcTFYQzdt?=
 =?utf-8?B?a25lbmM1Tmo1VjliYmc2UHJwbFJKVjRQekhFaklLajFIa3RxQ3pxaitZZjBy?=
 =?utf-8?B?bEFqdlczR3NWWmYwZHpremZjN1l3cTdjUmpRdm1KMnBtdXV2dm5uTTZCMFBi?=
 =?utf-8?B?MVBzMWtNR0hGNkdzbW1IREsva3pzMHhzUU5acjB2ajFIL21DTnJ2UG1sU1JI?=
 =?utf-8?B?MVBUNGhhd05GbDhncTJTZ3FkQ1E1ZnQxd2VpWUlQdytGZEVQM2F2NlY0OCts?=
 =?utf-8?B?bzdvb0FOZUQyaHVXL1B2NGh4alpvc0hLc1Z5OFFYOWNGeUFoT3ZHeDBsVnVx?=
 =?utf-8?B?THozclZhZXpxeXNvOWNOZFd2MUlpaEZUZFplUGh0ek5qcVhhdFJMTlEzVEtF?=
 =?utf-8?B?c25YMVpoVHJvMldNZDBSb01PTmpGaUJXWUhhV3RYVUJpSWV0RTkwblJidFRK?=
 =?utf-8?B?OWwvNytpU0Y1VHlIZkNFT3UwSGxYYUlFNnBEYlJOcE8zeURoemdUdDBQM0NC?=
 =?utf-8?B?NzBvMFk0dkc1emdGM1Q3VFhteVFCMktPaTVKWkFhSkJwZ1JVWnlablNNRDRB?=
 =?utf-8?Q?k+FUBNoJIiZucDeS07bYyLfur?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7345d220-9b21-4812-37bb-08dd18f87114
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 08:55:48.8457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgHF2XKB2bNxlKnn2507tz5EBIYmdIm4yOjITYUqbOmf4Ss6pnKkCoVUYgZtiPD3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6842
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

Am 10.12.24 um 09:50 schrieb Srinivasan Shanmugam:
> This patch updates the `amdgpu_vm_flush` function to ensure the cleaner
> shader is emitted when `enforce_isolation` is true and `vmid` is not set
> (ie., when job does not have a specific, unique memory space assigned to
> it. Instead, it uses a shared or common memory space that is accessible
> to multiple jobs or processes). Previously, the cleaner shader could be
> skipped if no VM flush, GDS switch, or pipe sync was needed, causing
> issues when manually triggering the cleaner shader.
>
> The new condition includes a check for `!(job->enforce_isolation &&
> !job->vmid)`, ensuring the cleaner shader is emitted when necessary in
> scenarios requiring enforced isolation.
>
> Fixes: 2feee98e6f2c ("drm/amdgpu: Update VM flush condition for 'enforce_isolation'")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index db913d533898..77af9c389eae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -674,7 +674,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
>   		ring->funcs->emit_wreg;
>   
> -	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync)
> +	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
> +	    !(job->enforce_isolation && !job->vmid))
>   		return 0;
>   
>   	amdgpu_ring_ib_begin(ring);

