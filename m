Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96773C433FE
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Oct 2022 16:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F01710E303;
	Sat,  8 Oct 2022 16:34:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE0010E303
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Oct 2022 16:34:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpNu5Zd+3HBx8bV9lMFEfy3clLPgKlkUYy1CbiGJWFVO+b97Kqr4GhsW4Ak4WUQd90kp3KjXi55c7pFpq+gpbol1ZQk2F0yRTDy+gwJ4+EqUGNdI4HOf3WM6V5v4efdg1T5tE0Ds299OUkYQjQNODWavHUIHM1lxiO8PJF9YlWv8JJVgGrwuWg+39l3nSZaLi9hqc1ZPWTvQn8jM5F8n4T2p7doyv67anHVyWgGS2vb09jMk5SZbaFNGki5B3AukY7jbpP2Vo3iftpLegXET1TOhvcyNJ/GyTl/0eJAbabg+gkXBrDr8sZnmkY5Q6Zg6O7FuCl9vD4+Y5GSF8JcSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KPDolL5PQSG2IRVywxYrshGQVfEOQIUFN8OP4GfgMs=;
 b=kUbr2WpDewsX9agAv1iOT7fdo3FPmrGA55PbOPU1FS4OAIXZ/ZGx7kGmylvt4QVE5Um591t1hwhJyUzL7gySdKYINAmAF2woHkV6A61PbA40OsH2uQHxmYsrkdBsQSFODhs5ZGR7ZerZpFJsqbSv895M/PzxHTnkd+7DK6H9xweQWe0SwGYuF3AhqXJwdoKgoUAsqcqb+4BT1DJzZ+O26oe8lqoS4FiKrOssH7jOscwleLD0NKZszAojh0Z3ofQDDT+bFjcj9RCUAllUTL99RErJ0N2PiH4MeBUiAIC1/srMJ6cBouoCSzekJEQjGTeHIKTVLMBv2KsSvx70zOrluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KPDolL5PQSG2IRVywxYrshGQVfEOQIUFN8OP4GfgMs=;
 b=KkssGvAROmIr2UQnNFKjxRBcPYQ+jv9XpWrUBgJKFekuqJrl+DYxVqmdkTKjuO6N+Fa9qyNvsfGMDrx2MGTcOs8xgxIb97ZeVu1NHhFSeEeIwTWqQlONwNIOgsgxv7XICpcM6LAfUZlDxEOO4DTVXdolsEacP9T5B71USYXilrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Sat, 8 Oct
 2022 16:34:15 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f9a4:8620:8238:20e8]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f9a4:8620:8238:20e8%4]) with mapi id 15.20.5709.015; Sat, 8 Oct 2022
 16:34:15 +0000
Message-ID: <7e7bcddb-f49f-d157-3f58-24d6910036c3@amd.com>
Date: Sat, 8 Oct 2022 12:34:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdkfd: Fix the warning of array-index-out-of-bounds
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
References: <20221008055612.505160-1-Jun.Ma2@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221008055612.505160-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa1a7f8-6d31-48a4-d57e-08daa94af04e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2j8KY+5ZgbSfZrF5YVq78rBTqruAC2mNcBr68ETBoSZ6Ao7XaSiur7HUPnoNN8sCXwleHEEGstJzFQFQeMQx8FRz3VHPJamSJVQhZ+Ebk1syi+ptUPesonjBeTUMUOsRTcVg0CCMf5Ole10vTCItTEdgkYd7Us1soc8fUQr1ef556NVOPLCiIfy+eTA+F0REiAH233x1l2UTpxPPaug7eUQmnrwdMCGVxZBhroP/8iPBjyO6vnHjJFLwqQ9VKbG6FUmvWNg0rSgy3wofBCx8ziduvHOHbqLBWDnMUiPVWUufsMKs0MY/ymYOYi28f0dZToxFeIQjegynQqFLkU9yXPaFIY6e27HLBqP1GvEzFuv7LN36caZbN/XpcELCgbccNHYXB0MK63N8GBEUEErfOrqkd26trJs0kl7MSo7svwWkHPQy6+IFNFTupKvTdMMszNo3pYP4JV+v3UQtI3K6eT5rFNoP08lj1oCGedY+xEeC0FPTYndoWZrVfc8Vgm6uPpAZ5UkUAit0lUx382OKcgiL2l9dH9KXx94cBsI3a15G7tvR7eae/Se994rEMrySUYPQ2jjNoo7BgUsDnWvCgopcZ2paua13902e35ysjDGkjV+v7pe5p7CbIhFakZC8KuAvdfeEA/A4G4r4XeawW37G7ja0OzYPnIkI+fiTY5BbFYv7bJIaU9osuIJKl9zbgUQLP5HTbX/OBs7SCv7EsZtwkLPKMagmwcoFseHD13ITNt11TVIITojiSmrV8hxFOx1Z76qDGewGF5M06IqMHiKIlCqhCNf5ScEc2wjWjcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199015)(316002)(66556008)(66946007)(38100700002)(8676002)(4326008)(83380400001)(478600001)(2616005)(6512007)(6506007)(6636002)(86362001)(36756003)(26005)(186003)(8936002)(31696002)(66476007)(31686004)(5660300002)(44832011)(6486002)(2906002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEdjSXFsUFhQQ3pqN1dPdGNnMkRrTUhUNFgwdFdpV2FHcWZRajNrQ1RBVWtQ?=
 =?utf-8?B?WStMMEJaeVBuUHdZOVVlSDdQT0ZHNDFOMnpRYVlQVUJ5SVB5TmZySHpmMStt?=
 =?utf-8?B?ZlB5Tng3UDhOSmdXNFBwaEdJajBJaThrTkpIamdEMnRlSmliMkJQQndLQVhl?=
 =?utf-8?B?dGE3bjhNeTBrWDZHRDk0MG8rZXVuQjJqNStXcC9HdnplLzBydkEwTURWTm9u?=
 =?utf-8?B?cEJaanhJTGVIRGs4V2xWaHU4ck1MWjVzdkhhYnRJS09DVXJLS0wrTDFTTC9M?=
 =?utf-8?B?SmowdUxDQW56dGxZRW9yekFkMzFOdlQyN0YxWHFPRmhQUGhyaFdHWkUyRXN6?=
 =?utf-8?B?d05SckVUc05tL3Y4bDY3ZlppTmhKOTZ1K1RnLzFzbVdBOUdvWjcxV2ZmZjFF?=
 =?utf-8?B?TmpFNzRvS0pwc1k0Q1pmRjAxUDkvZzdZbzJpWC9tWUhpbjhJUWk5SXZFRVB1?=
 =?utf-8?B?WkNRL1V6OWU5VzgwOEFPQjFUMVZ5Wk02N0lGOWdiaU9Ncld6MmlzNURTWmhN?=
 =?utf-8?B?c1MvcWxCOEZ4MmNVUjJtVFBMNTBKOUNHVkJCRGxLSGxrbVdIQ3Joa0h6RjlK?=
 =?utf-8?B?Nk9rWk5jazZiWUdjMWtCMlNkVjhKZ3RHU2ZOdG1hbnRjOGIvZUtJV3pZT2RU?=
 =?utf-8?B?Vzl4b0h6eEVtMWRXSFJLYVM5M05BTXBHaVZqV2hxQmJ1ZUtDZUxZNEdMYzVT?=
 =?utf-8?B?UGNKSCs1LzVHeXgvcHF1eWYycEFOL0xlV3h6blJ1R1BPWlBtS0ZrQmdTV0FG?=
 =?utf-8?B?VmZYTzhSd0NGR2Fobk5BV0hldURoS0ROUzVsWUlLVjZ1N0NBbGhkU2luNTZk?=
 =?utf-8?B?VldOT1ZxSnRtV1kyczlCYzZkVktUOFEwdisrSmNEb1hRRk1Md0lSdkdkS2ta?=
 =?utf-8?B?UHFjdEp5RjB5OE1CZ3M3U2x2aE5vUXJWVVM4aENGa3BMQWNNSjJBN0ZrLytl?=
 =?utf-8?B?RlRkTldvdUMyeE1kaDE2S0Y0T1p0K04zQlVVNTdYZTRXMFBEajZNV1lXVGJ3?=
 =?utf-8?B?dnBXU2tZV3oycjNDOFAvcXhmcGZLekNOd1hucGdCMjg2K3VoemxGN1ZCanJa?=
 =?utf-8?B?bVFwRmZLRE5RR2dNQnh4QWdMbXdDUzdjc3dDQXRyRGZXY3VvWXJwMXJEVGI0?=
 =?utf-8?B?bU1SQlNhQVdXWkFpbnJlbDRFdFdXS3U0T2NZU1lkQy9sSE1hVDNMWVBEQmpm?=
 =?utf-8?B?RXdTQWI0R3U3UVlITklZU2QrMCtLYjVyK2dDSHhrK3hINHphcTd6bTFjUEpB?=
 =?utf-8?B?OUwvS0JyKzZHeUJPd24rWkFCSjV4UkkwaUhkN0RIZWUvZm14NU5UdG9hSm9Q?=
 =?utf-8?B?bUZQWU90Q280cmlrTzdNOFBjN29OWWpGckR5Uy9OV2ViQUdleFVWOW4rM3gw?=
 =?utf-8?B?UndOL1ZYSzd4Ym9pelhUTDZ2cGFIbyswZG9kd0p3OVJqNFRQMFh5cWI4eTdC?=
 =?utf-8?B?ZmpteURLRzJ3K3NhOFZXeUZ0Yzh6U05YYTdaWUJudGpLaVFYZXFraWZQTWZr?=
 =?utf-8?B?STcyeC9jWnlQZjc1Qk1wdnAvU1IzTjdQVzZSMzA5YjMxL01ocVJ4b2RaeGNX?=
 =?utf-8?B?Y2ZNNHJhOFdyS1htK1RENG1RN0lpdEJSNzhkdTdCVlMvcVhoN2p6L01mWk1X?=
 =?utf-8?B?Y0I0NmlMcUNrY0dPNXlEQlhManlacTFDVVZWb21PTnk4a1dXRTV1V29aTU1L?=
 =?utf-8?B?ZE1KWU9RNEVBbFBZVU5TU09WaEdFamllZnBUaVM3YWRQM3JkVjVSMFNrYWM4?=
 =?utf-8?B?VEFOdm4rT05wcmIwUUlqdlBJa2JUL0xhWkJ1Wnh6VTJsci9SNk9jZzV5NnFT?=
 =?utf-8?B?R1lLUUZ0RlptTDlNSUxvNFZHUzNQelRQL1lrdHNBdlFHbldGc3J4YVBpVEh3?=
 =?utf-8?B?T2lRSXBvLzUyT2lIZ3pXRFgvMTVNYm5YeXBMWVVoN3hEUWtUMWE0THJFSDhm?=
 =?utf-8?B?cmxtWHlsNUp2Rk5sYmF0OXF1WGxQOHRPcXd0S0tLZzQwdzZsZ2xDNlVlZGVT?=
 =?utf-8?B?QmJNSUxBOXdLN3FWVWkzTkE2QzRtY3VSVUVwMzhsOHF4L2xJTm00THJMWDdt?=
 =?utf-8?B?UUVpdjFDWkVPT2UrOG1ka3M2eWNDb0NvcUNZbnJKSTJkaXNLQmJ5NVN2UjFI?=
 =?utf-8?Q?tBsvNZ2dm2kmbWbyY1CvLZ+Ln?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa1a7f8-6d31-48a4-d57e-08daa94af04e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2022 16:34:15.1811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egmubdMPH+wMuMGI1V0Zfyyz/JfJPjT0ifHPsWvFCB1FhdnGHH2p/A1vX0AzWkFELT/RBEpgzGo2lVfwgRSIPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This breaks the CRAT table ABI, which will break APUs that use an actual 
CRAT table from ACPI.

I think to fix this, you'll need to populate 
kfd_cache_properties.sibling_map without using a VCRAT to support GPUs 
that have more CUs than fit into the CRAT sibling map. In other words, 
don't populate the sibling map in fill_in_*_pcache. Instead move this 
code into kfd_topology.c and populate the 
kfd_cache_properties.sibling_map in a new function called from 
kfd_topology_add_device. E.g. kfd_topology_fill_cache_non_crat_info. 
Maybe conditionally only when using a VCRAT.

In the long run, I think we should get rid of the VCRAT stuff entirely 
and fill in the topology for GPUs without a CRAT without the 
intermediate step of creating a CRAT table.

Regards,
   Felix


Am 2022-10-08 um 01:56 schrieb Ma Jun:
> Increasing the simbling array size to fix the warning of
> array-index-out-of-bounds. The VCRAT_SIZE_FOR_GPU is also
> increased accrordingly.
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 477a30981c1b..3ec425c3737d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1683,7 +1683,7 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>    * expected to cover all known conditions. But to be safe additional check
>    * is put in the code to ensure we don't overwrite.
>    */
> -#define VCRAT_SIZE_FOR_GPU	(4 * PAGE_SIZE)
> +#define VCRAT_SIZE_FOR_GPU	(6 * PAGE_SIZE)
>   
>   /* kfd_fill_cu_for_cpu - Fill in Compute info for the given CPU NUMA node
>    *
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
> index fbb5f6c32ef5..31a4bbc9f9cb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
> @@ -80,7 +80,7 @@ struct crat_header {
>   #define CRAT_SUBTYPE_IOLINK_AFFINITY		5
>   #define CRAT_SUBTYPE_MAX			6
>   
> -#define CRAT_SIBLINGMAP_SIZE	32
> +#define CRAT_SIBLINGMAP_SIZE	64
>   
>   /*
>    * ComputeUnit Affinity structure and definitions
