Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37B6E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 22:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D26F10E7BD;
	Tue,  7 Jan 2025 22:17:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="odkMCwmb";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F45910E7BD
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 22:17:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDrh5vmRZR/psTTJxlTlzGJQ31N1j0jGC/YY5l/9M7svgX4QwCdgbTWzL9n84QRWUUUSETSEiInL49jymA7gXGfpY4+XOLClzpGuuelcn+IRrMS9w8KMQBsGwSIcxbAD3tHzM3WZZO3YVMoHpez8fitwmli5Dk6Yx2yJfZhTVjTM0aH1MRYdU3ohKYR+RCeUEA3D5YbYQHaZMjyoUJmtVIcJNrXsxSR6/4qBjUpggyovj+wEfy3a4bK2qYoImzTcbz0lt8YC8uSJg/CeS7gsPTi+YKfSf3fvuhPrmnyYQKXn7yPJPR571ADSUL0+0G9Gr62LDWfTHDxGU7WP8NtI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rt2lbnAygbXD42v7P5iuo460tGTZO13+096miQFgmx4=;
 b=N2IUBstDlLRcSbJ7G5N4A8G49/ASsJhIBCs70IR7BZIdDhu0xnNAHNgVS7IEa7JQZNen9clbwMjxLFXy31MhmV1+RUa87wRY0feGnYmkdJMpCJkXYAmLizBsZVAM/789s7B52P6Fb/GHXyEVIv3T/Y0LjErlsNspb1pQ33H8rexMv6HL4hLVKAkuq7k7HMedaJpA5lyfQY0aSgtHYPDSGwaY0iE9ZqbCV5GbdF5QAMk2S/exgQX0ampaFApRPX4bpHp7sox13dDZAVNXnMaaOUFuwn5BjCTdLZ7KV/fYyG4XN2rxtFORvWxAf7uYjh6fW8QMNhOt/u2ovnZSC9Z/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rt2lbnAygbXD42v7P5iuo460tGTZO13+096miQFgmx4=;
 b=odkMCwmb9JeBjJOQ+hydBcHkRExZ9crQkM3+I7FuJCUgKIt2I3QjrrkQQVyjfL2UhDrX3fdh/zklaUjnbI7mbeYszG52k6b37wwY5Bffp8j1W4+Gho4vmYJiWrpn4yGxZvk1tHJE3UyKuOVHbGHPkCQ0BGM7YiHqNUQ0jVX8SZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ1PR12MB6049.namprd12.prod.outlook.com (2603:10b6:a03:48c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 22:17:15 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 22:17:15 +0000
Message-ID: <07aa735f-54a6-42cf-8367-5fbdd3648eb9@amd.com>
Date: Tue, 7 Jan 2025 17:17:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: mark a bunch of module parameters unsafe
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, sima@ffwll.ch
References: <20250107145308.53467-1-christian.koenig@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250107145308.53467-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ1PR12MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d45f7b-f970-49a3-35c1-08dd2f690a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHZvNzVodTJsWHVSNVkvYkYxcE5uZnhDZGtPd0xEYWEzaFR0UjZUaHUvZitN?=
 =?utf-8?B?MzlVTXdtdDRweng4VVM0M1ZhTFQvU1lKZXRTMVJlUHJnVVhPaVBiem1zQnMr?=
 =?utf-8?B?Q25YWUJGNlJoTEZCSzJHUVVMeGxHK0F3cGtVZTk3VGVHSnhINXNmT1dpZXFj?=
 =?utf-8?B?TTh5QVdRZFNZTGNmcEFIeTZTYVA1a09TWm1HdjFVa3dMLzR0N3VQTkFHQUZG?=
 =?utf-8?B?KzBhazdQQWhMbFdwTHZHaDg2ZHFVMUxKY1FaNGkzdmhheTdiSmtnS0pNYnVN?=
 =?utf-8?B?K1B5SmU0ZVFyQmZ5Zkl6b0VzV0JZRnZXN243cGlzQnNtcWhIZHBRRWI1U0k3?=
 =?utf-8?B?OGN0VVp6U213cTZsY2lPbnI0YjhjNkdQeG4vM0pXeUJ4OEYrMHZ2RDFpcXdN?=
 =?utf-8?B?U2dpN01FZk9FQ3ExYmo3SU1DYTc1b1ZOWHFyS1RiYzVQdGgyYnR3OThSbkhV?=
 =?utf-8?B?aVRvakMyOW11WTlxTFFkSUFRcDNQWlJlOHArUk5PSUtVUUFrZEc1RlJCcUJW?=
 =?utf-8?B?RWtjeGUrdWE2SFduZC9zQTV4ZWxCMkxtdkhKTnhteThCOUUwMDRrQ0E0M1lJ?=
 =?utf-8?B?M0xGNEUyQ2xQeElmMEpWMmtLcFhjNEVZakd0a0Rna0RlZDNLek9hOTBpY3ly?=
 =?utf-8?B?ci9pUTEvME10TTNvdDgwSzZuOG1KWTFIQlIyZUdxbmlrTUNJckV6NWRYSzN0?=
 =?utf-8?B?enNBOTg3QmJGMmVoTGxiQmlFSzM2a1hWQ1BZQlhxZzhVWXowZGNqRVNLZkVu?=
 =?utf-8?B?ZnpZYUM2NTNMR2JHVlQrajl3N254eUJ6Y2drWm8yYi93cFB0LzVFZjZJSDJI?=
 =?utf-8?B?YlN6bHo5YkdOTTdMMVVJK2hUYmJqK3YvblhWcnVIMUYwMHRuQk9ld2FmRzNa?=
 =?utf-8?B?YjJWUXVhVjJidjZGRGJYR29rdmZudlZCUmkrNzFwRkx5R1NvRWhUL3A0Y2Ry?=
 =?utf-8?B?UytaMkdCSVl3STk0aGhOeVNpejUwa2c4MnhITWZBUFo2Q2NOUTlhejJ0c3pB?=
 =?utf-8?B?RmVxdVlUaU5mcko1eTZueEc2QldIakVKeWl0SDFsczNtZFNKcHVVMDRWR3I4?=
 =?utf-8?B?Y0NuemJQbng4VTRCR3gzRERQLzh0MXhOVGtGbVlGTmVCd3BFRHV6cTJjUFZ5?=
 =?utf-8?B?b2ZodjdiYWRka3ZxMFY2TmNKTFRSdGdrb0Z6bmFNRVFFaUJ1Wk5ndkV6c29H?=
 =?utf-8?B?LzFSb3k4L3dWR1YrdUJsaE9YVkRaQnZGY3dmWXgwSm5RZGw1UmFPTURaTlZG?=
 =?utf-8?B?VVdzK3lmSHVRYnR6NkZsVGlaa0Y3dnQzNGUwcFlXL2RtalZWbklWWjR4RDVS?=
 =?utf-8?B?amxyL1BGY2p2Ynp2TndKTEVUb0l0TzJLVjdRZnFnK0hjOGlkblVaZTdxYjUz?=
 =?utf-8?B?aWY1bVE4Snd4ejl0Vlh3bVlDaEJpWTAyMlk3UWQ5WWdJT2xwUW94TVNiTG41?=
 =?utf-8?B?Wkh2Z1Fzak1tQitlMi9qajRjTXNzSDl4WXQwZEVuMVJEYTlUenRRdVZwdnlS?=
 =?utf-8?B?eHlSb2tUbk16YXhTczF4RUlreDJMay9aRHUvZExtMWhBSGUxR0hEaWxSSHlt?=
 =?utf-8?B?RTZDdy92QlI5bGhkY2tYYXp2eXAvWHF4aGoxMFBSV3cvSG9uUWdzTU5RQXlZ?=
 =?utf-8?B?VFFKejdTOU9qSHVaVHVENjlNbkdJZ1ljeCtUc1ZPRUpuZjlTRXZaeG9ZdjNC?=
 =?utf-8?B?cERMMGVxZVptaTF2YTlhUHVGNm1zd0lnTVdOS01nRDdaNnI3TFNSSi9DNE1m?=
 =?utf-8?B?UXdmZEhQVms5VnA4Y3FzQmNSYzhNaHBORHJ2K1dXUHdNRDMxZys2NnR6M0Na?=
 =?utf-8?B?WmVzb3F3LzVxQ1UyMEMydzk5Mk1ZTXFJS0V1c2pSRS81K1ZzSVBsRDFmemZ1?=
 =?utf-8?Q?JZMM73EUg14FV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFBIRmttME4xZlBtcDl5T2xFUGpTS1FQb3Zqbjc1L2JaVzhaeThJY3h2OTl5?=
 =?utf-8?B?NWxCT2YzWkhQYTFjUnc2aU1wREt1SWZ6ejVocGdWL1hMWGRtckthN1VWbHhr?=
 =?utf-8?B?OG5WVGtuZEFacGxPdE5BM2R1ekhsRGFzeUtKcVh0bkQ3MHp2a2poRk8rTFhR?=
 =?utf-8?B?cmtkU1cvM3diZEZKMTd1aUJlVzNZemZoTEIrcTZ6VHlaUXlKQUJLVCtwaGVp?=
 =?utf-8?B?Q3VVVUd1Z1Rtbk41aDFxemFucHJLWm9VSEdwdkZWb09CSnByNVlDaEExelMy?=
 =?utf-8?B?QzhiWGFWdmErVVBXL2Nsdi83bS9yL1hnWnp5MlE5ODFidzVqekROZCtQd3px?=
 =?utf-8?B?djJrd2dydEpTZTJVbGFQSGhSK0UrTHVYSnNrdnFLb2JKZXc2ckhPcCsrcWNO?=
 =?utf-8?B?QVhoUFRFdHl4WGpUdnZpclZuWVRNYTdybkY3dzFQNTJSWDc5RTBhU0ZTS1JF?=
 =?utf-8?B?aVFld1hGbGRDOWFOMHEzaGsxSnRKdmZWS0JIamppY3dlajlQL05FV2o0VEJR?=
 =?utf-8?B?bmRsU2JHVGE5MzNBajk3c1U5QUh6NG9hejZFNC9sY0ZoeFRIV0IyR3RQbmpD?=
 =?utf-8?B?MU9KNWZGOCtIbUwyaWI3WGlVUlVzd2o1TFhFUTFLOXNDcEg0ZnBtYlp3QXN5?=
 =?utf-8?B?VU9OOWtTOUVQOENlUDBwRUpPT3AvWkNLYVBobkYzTXh0OW5Ib05VSDFUVjQ3?=
 =?utf-8?B?aC84NSt6cU9WS3phY2VsRmxsSWVYbmFEdlU0Y2cyS3hsbDhFb0RSSWUyYmMv?=
 =?utf-8?B?YldtQnVXcU5aNEE0bmRLM0o0SHJjSUxBMXZCSWhHL01GaFFqVXp0UE1JT09Q?=
 =?utf-8?B?ajcwdXVLNU9ZSVNxYUUvRkVTeXlzRkVtdys0UnVYdE02dHpUUHU5bklUaDRl?=
 =?utf-8?B?MWF1Y1ZQNGF5a2swWC9KekpVYThpampuUXArY1g4STRod2FXSFNIYUFYYXI3?=
 =?utf-8?B?R3BQM3RFMDJzbHFOUzBxWTgrRXhsWEJzam5tYnVzYzZySFV0WmNhWnZQY2Yz?=
 =?utf-8?B?cXhhbk1lUXlYRTIxZ0ZxN0c4NGVrU2JuZS9LZ2lCOXVKaVhoU1M3TWMrZ0cv?=
 =?utf-8?B?d1FvOTJEc0RFUS8vaTlYdXpPSlRNdCtGUjk0L05mSFJjNWpLRlMwWTM0UzUy?=
 =?utf-8?B?cXBvc2R1Sml0aUF4bFBGR0ZuU0R2NnNnSDVRbXk2dzlIZk5UU1FCeWpJUU1L?=
 =?utf-8?B?UEFKekJmUjBNTzRUb05RNDJJNC9kYjBISW1wa3h0NE9zYmg2TFRSUGl6RVUy?=
 =?utf-8?B?QUVPb3BJWmg2WElsVHhMQ1dVQmNtS2VmQ2dZQnE1RUlaVkxJZHlOU3JhaCto?=
 =?utf-8?B?ZlROL29IVHRPQWVBaTlnT2dTcGFOWU9jckM3anY2Q1Y3eW93ME9TR2dRZjJX?=
 =?utf-8?B?S0dZMGFPdTlJMXI0RFNrcCtxY0VCaldxQThVdVg3Ky9nVGZGK1kzblBSNlhl?=
 =?utf-8?B?VTJYSTM2U1ZNZ09YZ09Fc0lNeGlCTDdHdmovZ0swb3NNNzYxaXNPUC9Xbk93?=
 =?utf-8?B?MFMyLzY5YUJodW02bExFc0FaQzhaclRhbzBSUGZyRVoyODZ2NUo1LzdVdHBp?=
 =?utf-8?B?OVpxdXFkVnFCdmZTZkdYN1lkVytCNmdXeEVHS3pQelBFYVJKTEV3MzFpZ0Qr?=
 =?utf-8?B?cVdyWHFiVkFUMks5dmR5NVhFLzNwUU0xeFMvNE1jUmQxOXU1ckJ4MlFiRGZh?=
 =?utf-8?B?VTZFb3c5UmhVNm1GWjh3NkYrN25UQWhrS3pNQlgyRm93OGhkeFArUGNVMGFR?=
 =?utf-8?B?ZVlKVnVCd09GNXgwSWlSY1NIbUNuUkJBdG5MZEpONzUvVGNjOWpWNkgvN1F1?=
 =?utf-8?B?K0w1WStMUEZyVHViTnVWMWhhWVZlbm5XNGlIaEVQcDUwZmJsZmdwZ1BBL0xV?=
 =?utf-8?B?NEdpZXNsYjkzR2N0bWlIb3VOZlBabTY1WVVYRHRmdVM0V204QlBpMURzS21G?=
 =?utf-8?B?bjBJTi8yQUpCSUM2K29lTXFXZjdPbi9RV29DUEdBTDRsbEpTbG9pNm1NVGlo?=
 =?utf-8?B?bDJQZnQ2UDg4SkEralRLR2hxLzhoR0l5RUJaNE9tKzZpcjRyQXVoV3Q1U09j?=
 =?utf-8?B?d1M1c240Rll4Z0xXZnRZTGppOGdYN0l1YTNYdWwrZGVxTnRpUitRTWd0R01X?=
 =?utf-8?Q?JlkKLKnTPXMamzaQJN3saLNkm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d45f7b-f970-49a3-35c1-08dd2f690a90
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:17:15.3726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iESowImkDznymXGYVCDr/qBBACy3/OxVQVmS4JogV8/k6aUHENAuMP6wrBNJq1kbsKQomJV152kMF+KzahK1ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6049
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


On 2025-01-07 09:53, Christian König wrote:
> We sometimes have people trying to use debugging options in production
> environments.
>
> Mark options only meant to be used for debugging as unsafe so that the
> kernel is tainted when they are used.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>

Acked-by: Felix Kuehling <felix.kuehling@amd.com>

FWIW, we could do the same with some KFD-specific debug options: 
sched_policy, cwsr_enable, halt_if_hws_hang, hws_gws_support, 
no_queue_eviction_on_vm_fault, mtype_local.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index acb9dc3705ac..9ddfdb02a6a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -401,7 +401,7 @@ module_param_named(runpm, amdgpu_runtime_pm, int, 0444);
>    * the kernel log for the list of IPs on the asic. The default is 0xffffffff (enable all blocks on a device).
>    */
>   MODULE_PARM_DESC(ip_block_mask, "IP Block Mask (all blocks enabled (default))");
> -module_param_named(ip_block_mask, amdgpu_ip_block_mask, uint, 0444);
> +module_param_named_unsafe(ip_block_mask, amdgpu_ip_block_mask, uint, 0444);
>   
>   /**
>    * DOC: bapm (int)
> @@ -459,7 +459,7 @@ module_param_named(vm_update_mode, amdgpu_vm_update_mode, int, 0444);
>    * Enable experimental hw support (1 = enable). The default is 0 (disabled).
>    */
>   MODULE_PARM_DESC(exp_hw_support, "experimental hw support (1 = enable, 0 = disable (default))");
> -module_param_named(exp_hw_support, amdgpu_exp_hw_support, int, 0444);
> +module_param_named_unsafe(exp_hw_support, amdgpu_exp_hw_support, int, 0444);
>   
>   /**
>    * DOC: dc (int)
> @@ -570,14 +570,14 @@ module_param_named(compute_multipipe, amdgpu_compute_multipipe, int, 0444);
>    * Set to enable GPU recovery mechanism (1 = enable, 0 = disable). The default is -1 (auto, disabled except SRIOV).
>    */
>   MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 = enable, 0 = disable, -1 = auto)");
> -module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
> +module_param_named_unsafe(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
>   
>   /**
>    * DOC: emu_mode (int)
>    * Set value 1 to enable emulation mode. This is only needed when running on an emulator. The default is 0 (disabled).
>    */
>   MODULE_PARM_DESC(emu_mode, "Emulation mode, (1 = enable, 0 = disable)");
> -module_param_named(emu_mode, amdgpu_emu_mode, int, 0444);
> +module_param_named_unsafe(emu_mode, amdgpu_emu_mode, int, 0444);
>   
>   /**
>    * DOC: ras_enable (int)
> @@ -732,7 +732,7 @@ module_param_named(noretry, amdgpu_noretry, int, 0644);
>    */
>   MODULE_PARM_DESC(force_asic_type,
>   	"A non negative value used to specify the asic type for all supported GPUs");
> -module_param_named(force_asic_type, amdgpu_force_asic_type, int, 0444);
> +module_param_named_unsafe(force_asic_type, amdgpu_force_asic_type, int, 0444);
>   
>   /**
>    * DOC: use_xgmi_p2p (int)
> @@ -955,7 +955,7 @@ module_param_named(freesync_video, amdgpu_freesync_vid_mode, uint, 0444);
>    * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
>    */
>   MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco/bamaco)");
> -module_param_named(reset_method, amdgpu_reset_method, int, 0644);
> +module_param_named_unsafe(reset_method, amdgpu_reset_method, int, 0644);
>   
>   /**
>    * DOC: bad_page_threshold (int) Bad page threshold is specifies the
> @@ -1051,7 +1051,7 @@ module_param_named(seamless, amdgpu_seamless, int, 0444);
>    * - 0x4: Disable GPU soft recovery, always do a full reset
>    */
>   MODULE_PARM_DESC(debug_mask, "debug options for amdgpu, disabled by default");
> -module_param_named(debug_mask, amdgpu_debug_mask, uint, 0444);
> +module_param_named_unsafe(debug_mask, amdgpu_debug_mask, uint, 0444);
>   
>   /**
>    * DOC: agp (int)
