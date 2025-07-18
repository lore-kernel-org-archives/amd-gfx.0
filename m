Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804DCC83F34
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 22:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A01F10EA4C;
	Fri, 18 Jul 2025 22:09:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EZa8T+pr";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 287AA10EA4C
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 22:09:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoAKq68JjlIH4YWQaxRFTB5Gf1T9rdBBMpCcLaSrKzvxGKgxAYh70on6pJj+FW8OAatVh3G5zAf/RjxbMKgRt4aci7n8VUDOXdr3dm0rpdM/DfFNWJUXcNx4aVDUjllS36ic2cmjwhIvue19D75NS/kv8wQb7JmBqK5j6I5qNQ2qMsgA67VMAzlQdMeHncpT2Z5wO5rgBLlE3yryzP9t1f0OJgxwQEqq2WrlDtaYgkd9UU6S3l2R06bpD27bPTZrLJ6bi7EcUuRvDRl11+wo8RHsr1Hlls4y+mWQM+4gIDQUjk5ovsiHTD4jyQMvBF0qnkH9Epv1RM5s0qQ7kEPccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b48x4RTV0IeqNgYuLQrHB+zruGl+vrR1VZTlqsnUP88=;
 b=g0Z4hSxMP6tgXhv2OxKHYAPTr8lix99QZ0OcOwIlla5cYAJjt7Yglx4X7gfXFq8nXeUVikFsptpLy+IS2oo8SSre8zEBgtZt29vFz6HCdrDWlIxAHCSPgCC2d00sNqK4ROB7u+Ql9uxhTt50A3E5MGFO/s2PEUP6O4wu5arO8NA1Fc/QFIW22VCfJgfHA/5XZ0c+9/W4dRdVdw9epPMlE47vXrvvCDSpMKbmyfvgduAQLNO2RwWJEVWWei/OYyxYHcVkWPz/b3mUyhNIVNp6QEl2Prqck4N985wStzGR/uX5WQCZ+KYvdP7Xu8nSH7nNoSXoncgTWxSFw+LUL0nlTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b48x4RTV0IeqNgYuLQrHB+zruGl+vrR1VZTlqsnUP88=;
 b=EZa8T+pr3h7tiQX9neKVTM7cv3ivPkq6jtP+K7WSUEg9VD/FMBLGlRZQ4XlIkUBCEVqzd5oih5wwFW1lYZtbb9PavvzMKWJYVrFs2601HbW2N2i4tmadvCkvEYRE++RozS5oZ5UFqnqR/RR89ykZjurdi30LFp1IxjKxXSaw+p4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 22:09:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 22:09:31 +0000
Message-ID: <2eeb8cfd-20b4-4e6f-92a4-a6a4a2430e8f@amd.com>
Date: Fri, 18 Jul 2025 18:09:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdkfd: return migration pages from copy
 function
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 philip.yang@amd.com
Cc: christian.koenig@amd.com, jamesz@amd.com
References: <20250528171908.82639-2-James.Zhu@amd.com>
 <20250714124634.98951-1-James.Zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250714124634.98951-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0161.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 791819f8-bc90-469e-ad14-08ddc647c377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEtpbWIxVEhPdjQ1bXhJdmludzFDZ09hM1JSNHJXVW0wYVJUQ29jWEhiUWFP?=
 =?utf-8?B?WnhtanowQWdobjBVall2SVBpUUhsOEQ2T2JMVHUvYWdJS2JJMjJoakJ0Y0h1?=
 =?utf-8?B?ZCtVYkcwOFVIWWNsb0xxdHpkZHFaVFZBaWgzSmE2cTJjSDNtbDRGVjZHRXVt?=
 =?utf-8?B?SU5VcW1DWlRtVUZqZkkxNElHZWxzVmd0NXBOUTh3ZkJBMGhEQzZ1aTMrY1pK?=
 =?utf-8?B?bzFBRkhNb2IxNWk1aUV2OForRFRTamg0a0NJdWgzRjFkaDlpYnllcDR4cWhU?=
 =?utf-8?B?QWcvbkF1WExRNzEwUlhoMkc3eGdrN2s3Sm1RYWVpcnA2b3h5bmpHWnpyYkVp?=
 =?utf-8?B?eURxTUdCNmpNcVozajFQUFNxT3FXSVU4T1o5Y29Ldk5CZ0RBUGxRN1ZmQnpm?=
 =?utf-8?B?UmtoMndoT0lwdGFFYitKV2IvQUdPRytwcDFDMFFTbkxUYWg4Q011TnpGK3BF?=
 =?utf-8?B?SEYwQTJVZ3NtVmlsdmVoZGJXR1FWRmllN3RCOXU3TnYzcXRMY3VwYXR3RFE5?=
 =?utf-8?B?OUcyN1h6ZHpIVk04d0FrUmpqdTlNMzEreWJ0UDRjWkN3Rk1JSHNKQnV3cXVO?=
 =?utf-8?B?NTlweUhkaGNCaDUwT3RLaDR5aTJaamorNHdObFpGUTA0UkEvUmgrOW8raGt0?=
 =?utf-8?B?N3hiREJnTWtKcXJnem01bGFDU0NvZzhDemZnUjZVNkY1SjVZa05OSG9Udms5?=
 =?utf-8?B?dmN5bFlPZmhoVFRhNzZpOVgycUVScmNhcUtYMmZLajhETWpUWHg2RnFaMlVV?=
 =?utf-8?B?SVplWmN5Ym03dW9rdXlzRCtBY1NnNHZwNVlVcGxlZVJTMDBYUG1maVo1dENI?=
 =?utf-8?B?aVZsemRVNGtTc3k3ZGhpRjEwemhYNGpsajFKU3dLeDN6d25zZ0ZIRlIwditz?=
 =?utf-8?B?THdGMXNuWWZqdnZRaVZRTU41cWk2bWpPU0dHbjQ3YjFxS1JOWGxVVVJUemFm?=
 =?utf-8?B?b3I2bVp4QzZnaFgvR0JrR2JTU2ZKREpqdUZrWUtmV0V4d3Z3Tjc4UHdQUVhO?=
 =?utf-8?B?RlU3RytJWlRnL2RtaUFQYm1JNmp0RVJ3UDRaNDdwRlpoeHh6ZTVIWTJUNTBE?=
 =?utf-8?B?d2VlUEhnZlBOblhaWExEcVpUVzFmWTdRQmdia05ZM0JNcjNPdWVwM0Eyckti?=
 =?utf-8?B?RFBnV2QwSlRmaWR6TUFKR0lESU5kcDZzZy94ZzRhU1didnNPMzc1WWc5V1RY?=
 =?utf-8?B?Ty93UVJwYmtuNFYzYXBHRVpqbjJyZmdSWDJmR3Z5c1VLU0gxV3lZVWhZZWhq?=
 =?utf-8?B?WExkTU1uYzlBZFpuN1BCclMxTFNXM2J0eE5tZHdHSjMvL2NDZG91L09xTXdK?=
 =?utf-8?B?U0QzQW83VlZFM09FbE1IdHk0cTBvVHk2UDEyczQ5L0pYUkdXU241dVBEdFNF?=
 =?utf-8?B?YkRGTjhxMkFuMDJnRFRGVVUvRUhGMFVRQU04LzdGdnVzUmhXV0xDVFZIRWJw?=
 =?utf-8?B?cVR5SEhkR3BGWmdmNDBwOWlVVEwwRXB2NDhUMzE1RnhzdUphdTlRbTl4ZEZt?=
 =?utf-8?B?NWtscmhRYmxyUFI3eWhxY2tuQjBkRmpjZ0FTZUJaSk9pUngxbnRFQUlhdkZH?=
 =?utf-8?B?VGQxdHhxOWhZZW9KYldoQm5uMVVSVEV2NXBVTXVTN2NNS0MwT2JQVWFCNmk1?=
 =?utf-8?B?Si9iVGtVcWszd3g5RndpMXpMYVcrc1dCTGY1OFdJbW1jSFYrQW5xaG1HOVlK?=
 =?utf-8?B?bkQ4c1F5cmw3SUZHRXNVdHVDNFErVzc5bjQ3dGphcEsxdVNIZXg2UkJJK3Qw?=
 =?utf-8?B?R2lUUm51U0kwM1loYWN1U2NxV2ZuTG5GMnYvNG9XWUFmVDRobjI1aTJWSUVU?=
 =?utf-8?B?NHBCVC9KTFRraWFoY1ZodHEwUVJTZkNhNmRIbE90Yld4WlJmaWtldis4RXdT?=
 =?utf-8?B?V2ZtZk9ncUNRdGY3UFdYSXhiazlkSnNqcFI5N0I4V0swRFdRZHJBbHNJOGZR?=
 =?utf-8?Q?hrpUDRi03rs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0Y0S3ZqYUtOMllNeUo0M3Z1T0xtRzE1UTFlVndiRXpGNnlFU3UxYXRaNnho?=
 =?utf-8?B?L2ZnWjhiaXUrVUdob25sT0xKVi9iYlR4dDU4Z3NrcVd4MFlNM3FOMTMxOXNM?=
 =?utf-8?B?c1ZNOFl4RXBhQk5VdUhOM0VBaEVmU0dEWkI1M09XdEtXb3BaZ0s4M0pkZllW?=
 =?utf-8?B?UzFjRWpjK3lLcE56Q1NZMXVtdlo4dlNEdHF4R1VwdGpJY25qUzRSOWVua2tj?=
 =?utf-8?B?TkJzV1NoRVRlc3BUbG1rQU9LMnY1aEtqMVZFYURWdEdxZGxNR0JjMTB1LzV0?=
 =?utf-8?B?SEFWWWlsd0NLWGpmQjJ3VXBoQTlXaUNib1hzMW96cXBSaE1Dd3hnT1d1d2FD?=
 =?utf-8?B?ejV6R0p2ckg3eHVhNEtGRm5PWm1zclpiZUpFcmRpZ2VwcUY4emYxenJDU1RZ?=
 =?utf-8?B?YTV6SXRhc0o1ZllTVkp2M2RSZUd2TE9paUlaTEZ0ZnM2dmNLdThNWTkzcXU1?=
 =?utf-8?B?S3NXNE8xZVV2dlZ0ZG93eWh3VWMrTlhRa28wNW5KYmZvbXJXWDdvaWtMb3M5?=
 =?utf-8?B?TUx6dnFFMUZFdUFsY1B1UXBWbXpzNjZRVnNwYXp5eU9VMzh0Tkd1bXhBUVFM?=
 =?utf-8?B?dVdGd0pDMGwxRGtiQjVaenZucVlmVUt6WSsvV1hKeFBxSVpKWCtLeVlSMStV?=
 =?utf-8?B?N2plWDMyNUY1bERYeGhNSFZ4am0ycjZNWkd4WmtuT1RrMGZ2dU50WlpZaTEz?=
 =?utf-8?B?TTBReGpDdTZsYVNDbkFrc2FFRnNvVEZxQTZrb2tGU3JFdEl4SU5XWEdvYnhS?=
 =?utf-8?B?MjloZ01TOGFBTWhJZkxDQW9pbEduSUp1Zis2Q1lxMkRIWGtOTnJYY01pSW1x?=
 =?utf-8?B?L2owV2Zyd29VVFlhaXcydVM3Z3lGMVV0SlN5ZXVFR2hBK1A0S2JaZk85NE1D?=
 =?utf-8?B?ZVk5dE9UZFpDUFdpRWNESkZwRkVBTkVJN0drWThSN1A4MjhSTUptc0MwRWE5?=
 =?utf-8?B?Q0VhS0R3NllMQURxeEY0TGRqZ1h5YWI2ekNMbzVaS1NrenRWeENPbElabDNT?=
 =?utf-8?B?UWF5MitUbnp4YklDSzBnbXJ6UTI0c2h1emJNZStGcU4rbUtzRzdodzh3akFy?=
 =?utf-8?B?VDZtalhCZE9iUDhlOGROU2NYYVA1QjR3VkFwZk5ZK1hoYkwvWlVLOVBPRkVn?=
 =?utf-8?B?RGtwRWlIRDNHU24rMEZENFlmTlRMUGE2ZlpOdzJTeFNyZkFZd1hweFNuUFpw?=
 =?utf-8?B?WjAyMm1TdDQxSllRQUFDUU9vZ3RHR3lyOCtOcEhMZ2hUN2t3ZWZpZ29uM1V2?=
 =?utf-8?B?bzVsemJ5U01RZVpPWWozSjdBQW9qUnc2TkNoSFlORE5Dei9JVlR1UGNkenFx?=
 =?utf-8?B?eFhzR3c1aVJ0NVNEUytSS3Y0ZGc2QjBPRC9rbzZGL2ozVlg2UDhpako2bFVJ?=
 =?utf-8?B?L3RYQlpDa1Y0UjM5YlVBekxScjZURGc0Nk0zc2grdUpER0tiMFRWZ0FBOC90?=
 =?utf-8?B?WDJjdzhBditpSVk1QytNbFMwOS9yMG9tWms2UU1qYko2RHZzcnp3VTNBSlpJ?=
 =?utf-8?B?YjZhVGUwbmVlL1I3emRNWW1WNmRSdGcwei9Takc2UnZ6Sk83TE9wdE5GWnFv?=
 =?utf-8?B?MEJ5b3J2Z3RYOVFKbllTdzMrOFFMeTJLaW5Wcml5SkRWMzhGbEpsZlMvZkV5?=
 =?utf-8?B?OS9YM2xDL3RrWXo0QlRwQTlSM2RIOVJVeVNxT1RSYTJqeGFjNmlsV1IrRmpo?=
 =?utf-8?B?R3ZHcnVaQkF2WGtRalYxVEdGS3M3ZWQrU2VMWHpYNE1VOEhMVUlCQllxbk8w?=
 =?utf-8?B?aTVwL0F5SXNRREJRZVo5QjVBeVJQblBTOXM0K2JJY1lTTURLVHBvWjNYR0F0?=
 =?utf-8?B?dkdqRC9wQlYvTWNwdXF1ZmdZS0RpeWtRRWIrYWdVb1FqbXVkdTFWT3FlQmJj?=
 =?utf-8?B?S1h4eWI3QlJxUGpmUjlzL2tCTUhsZXBrOFdSY2U2QVFpSG5LVmtVUG40U1Az?=
 =?utf-8?B?K1VYYjdvbTc5TWlwbCtTbDFrV1dROVVRNnVLeGt1SGJPTUllK0ZnUUlnZEJm?=
 =?utf-8?B?RUNPaWdsby9zNmlzNjhiUTU2MnRoUEkrYUdZd2tCejVCTmdwak8ycDNkelVQ?=
 =?utf-8?B?clYyNXV1MmVPT0RFc3NoN1dsL1ltOW1wVFltYnMrWHBRUlFtQUVUamhlMWhn?=
 =?utf-8?Q?B/A9z7GTbFqIsKnXxECayY8UU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791819f8-bc90-469e-ad14-08ddc647c377
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 22:09:31.4936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJxEoAImpJMZ2BQt7sOf16ohEaIakLxMC1wnIGdcp4NVaTYEFlxq6bjg8Mry6PvopdeOlMoW5LWSPvuyRWOs+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131
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

On 2025-07-14 08:46, James Zhu wrote:
> dst MIGRATE_PFN_VALID bit and src MIGRATE_PFN_MIGRATE bit
> should always be set when migration success. cpage includes
> src MIGRATE_PFN_MIGRATE bit set and MIGRATE_PFN_VALID bit
> unset pages for both ram and vram when memory is only allocated
> without access before migration, those pages should be count as
> migrate_unsuccessful_pages.

I think the patch is correct but I'm not sure I agree with the 
explanation. Pages that were never accessed (and are not populated in 
system memory) should be counted as successfully migrated. It seems they 
were counted as unsuccessful by the old code.

Some more suggestions inline.


>
> -v2 use dst to check MIGRATE_PFN_VALID bit(suggested-by philip)
> -v3 add warning when vram pages is less than migration pages
>      return migration pages directly from copy function
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 44 +++++++++---------------
>   1 file changed, 16 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index f0b690d4bb46..aad1346bde79 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -260,29 +260,15 @@ static void svm_migrate_put_sys_page(unsigned long addr)
>   	put_page(page);
>   }
>   
> -static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
> -{
> -	unsigned long upages = 0;
> -	unsigned long i;
> -
> -	for (i = 0; i < migrate->npages; i++) {
> -		if (migrate->src[i] & MIGRATE_PFN_VALID &&
> -		    !(migrate->src[i] & MIGRATE_PFN_MIGRATE))
> -			upages++;
> -	}
> -	return upages;
> -}
> -
>   static int
>   svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   			 struct migrate_vma *migrate, struct dma_fence **mfence,
> -			 dma_addr_t *scratch, uint64_t ttm_res_offset)
> +			 dma_addr_t *scratch, uint64_t ttm_res_offset, unsigned long *mpages)

You could return mpages as the return value. That would match the 
convention of svm_migrate_vma_to_vram.


>   {
>   	uint64_t npages = migrate->npages;
>   	struct amdgpu_device *adev = node->adev;
>   	struct device *dev = adev->dev;
>   	struct amdgpu_res_cursor cursor;
> -	uint64_t mpages = 0;
>   	dma_addr_t *src;
>   	uint64_t *dst;
>   	uint64_t i, j;
> @@ -296,7 +282,8 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   
>   	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>   			 npages << PAGE_SHIFT, &cursor);
> -	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
> +	*mpages = 0;
> +	for (i = j = 0; (i < npages) && (*mpages < migrate->cpages); i++) {
>   		struct page *spage;
>   
>   		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
> @@ -304,7 +291,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>   			svm_migrate_get_vram_page(prange, migrate->dst[i]);
>   			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
> -			mpages++;
> +			(*mpages)++;
>   		}
>   		spage = migrate_pfn_to_page(migrate->src[i]);
>   		if (spage && !is_zone_device_page(spage)) {
> @@ -356,12 +343,12 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   out_free_vram_pages:
>   	if (r) {
>   		pr_debug("failed %d to copy memory to vram\n", r);
> -		for (i = 0; i < npages && mpages; i++) {
> +		for (i = 0; i < npages && *mpages; i++) {
>   			if (!dst[i])
>   				continue;
>   			svm_migrate_put_vram_page(adev, dst[i]);
>   			migrate->dst[i] = 0;
> -			mpages--;
> +			(*mpages)--;
>   		}
>   	}
>   
> @@ -441,13 +428,12 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	else
>   		pr_debug("0x%lx pages collected\n", cpages);
>   
> -	r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
> +	r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset, &mpages);
>   	migrate_vma_pages(&migrate);
>   
>   	svm_migrate_copy_done(adev, mfence);
>   	migrate_vma_finalize(&migrate);
>   
> -	mpages = cpages - svm_migrate_unsuccessful_pages(&migrate);
>   	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
>   			 mpages, cpages, migrate.npages);

Maybe change "successful/cpages/npages" to 
"migrated/collected/requested". I think that would be a better 
explanation of what these numbers actually mean.


>   
> @@ -580,7 +566,7 @@ static void svm_migrate_page_free(struct page *page)
>   static int
>   svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			struct migrate_vma *migrate, struct dma_fence **mfence,
> -			dma_addr_t *scratch, uint64_t npages)
> +			dma_addr_t *scratch, uint64_t npages, unsigned long *mpages)

You could return mpages as the return value. That would match the 
convention of svm_migrate_vma_to_ram.


>   {
>   	struct device *dev = adev->dev;
>   	uint64_t *src;
> @@ -598,6 +584,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   	src = (uint64_t *)(scratch + npages);
>   	dst = scratch;
>   
> +	*mpages = 0;
>   	for (i = 0, j = 0; i < npages; i++, addr += PAGE_SIZE) {
>   		struct page *spage;
>   
> @@ -646,6 +633,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
>   
>   		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
> +		(*mpages)++;
>   		j++;
>   	}
>   
> @@ -688,7 +676,6 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   {
>   	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
>   	uint64_t npages = (end - start) >> PAGE_SHIFT;
> -	unsigned long upages = npages;
>   	unsigned long cpages = 0;
>   	unsigned long mpages = 0;
>   	struct amdgpu_device *adev = node->adev;
> @@ -745,12 +732,11 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   		pr_debug("0x%lx pages collected\n", cpages);
>   
>   	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
> -				    scratch, npages);
> +				    scratch, npages, &mpages);
>   	migrate_vma_pages(&migrate);
>   
> -	upages = svm_migrate_unsuccessful_pages(&migrate);
> -	pr_debug("unsuccessful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
> -		 upages, cpages, migrate.npages);
> +	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
> +		 mpages, cpages, migrate.npages);

Maybe change "successful/cpages/npages" to 
"migrated/collected/requested". I think that would be a better 
explanation of what these numbers actually mean.

Regards,
   Felix


>   
>   	svm_migrate_copy_done(adev, mfence);
>   	migrate_vma_finalize(&migrate);
> @@ -764,7 +750,6 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   				    node->id, 0, trigger, r);
>   out:
>   	if (!r && cpages) {
> -		mpages = cpages - upages;
>   		pdd = svm_range_get_pdd_by_node(prange, node);
>   		if (pdd)
>   			WRITE_ONCE(pdd->page_out, pdd->page_out + mpages);
> @@ -847,6 +832,9 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   	}
>   
>   	if (r >= 0) {
> +		WARN_ONCE(prange->vram_pages < mpages,
> +			"Recorded vram pages(0x%llx) should not be less than migration pages(0x%lx).",
> +			prange->vram_pages, mpages);
>   		prange->vram_pages -= mpages;
>   
>   		/* prange does not have vram page set its actual_loc to system
