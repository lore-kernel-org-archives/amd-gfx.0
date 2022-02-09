Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593E8C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 21:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F7C10E48D;
	Wed,  9 Feb 2022 21:26:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 403E410E48D
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 21:26:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FN/I9b3IQ23jeQw1bUTtIZlA7APvA+Ek84yY+QE8+pB3qAvSc9f0Et0e/rQV0A/+z6z1VhYwZLRKgptJ3luzjyGMCLFdurdMKJc7uuu0H3Nsqp1xXpouGsr8Asat/n/LfzI2db5tDs82Cr68X3qfeJm9DrAZrQjFUA+4uK9moiPLJQucrrLXyu3pMHYEfRGzPOBXzQm5bwVYKVho77kAptca3zeVqSPCjuXT9oGbXtnQctc2JpLXlpaIHp6T1SdU6x6nf8e6jfOpu31wZD0moZycf9e7rSeceHBS3af2+XTWuWMXuB9wR/39D93N+2asWQurlzDKe3mNgzndJ9fmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D79Gfu6tCbIhTTBOA1vlVwX9UK9m/FskOltZNEwQ+GE=;
 b=iRxA0etg0mIPJhultcTWA2ZIpPQU7TrON5Cdzxyf0OKF+HE7pzshhlYpaLRJ0YaEsZfpWphoj+wBtNPytTQUd/n23qurtRN5Fi8T7GgWuek6Uyan/AlQIThm9/MplrXBbTfIaF1ski6uTHL6TRXV5udodV9jUb/CNANoHFTRv3WkZ4oRZqsENGSm6WX8o4Jo7nnMc7r6E9bHDEB3BiL2AgC1vTsUaXXjzZXu4yE/mvl33s1o5+tsgC+Ldx3veH3TXIXKqMTHqQkc+nIs2N0J+moIDuMyaNo2QjDpRn71bbmkW6nmTR7lO72eHg5TeiLhy6p4BmkDHzX/GgYu0UeDgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D79Gfu6tCbIhTTBOA1vlVwX9UK9m/FskOltZNEwQ+GE=;
 b=Oyib6e37Hsa7KOWrZQYOCaqtRn2ZrpFP1vcTPrK+HFN8UysgPwU6x8dL00bASCb8C9PrAjEK06zZ72C/i5AZwRAxdSncn/DusuKuLbWM4VYPbUH7UyVCDVHhlyAboxbrNlwDws4e71Jmsiid1H3AI2d2CPCxkDmC0nnBDW0mN74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by MN2PR12MB3168.namprd12.prod.outlook.com (2603:10b6:208:af::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 21:26:24 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::f071:728c:3813:3376]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::f071:728c:3813:3376%9]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 21:26:24 +0000
Message-ID: <f29dbb45-5308-1ab6-481f-6ba9695703cc@amd.com>
Date: Wed, 9 Feb 2022 16:26:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdkfd: map sdma queues onto extended engines for
 navi2x
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220209161149.347529-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220209161149.347529-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0047.namprd15.prod.outlook.com
 (2603:10b6:208:237::16) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb1e7fcb-b2da-4418-aeee-08d9ec12d318
X-MS-TrafficTypeDiagnostic: MN2PR12MB3168:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3168C99DBF2EE918288B62DF922E9@MN2PR12MB3168.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oH0UMrmMbzYvFJZbBEXXl1CwAixW1UgM6Qbc7jvsZfkbGG2cjkQEy1Xpqs8l01rbnYj9QTZLbSYqPu0lQkim9ZE+HXrnSq2IeZRNiNCLxdB9jQ6kDTPq4cJv4qGqM46io8J1dQHFcf7KhiolOUjD6QxWl+ZF/QL5jJwp1l4WR4f6pGpvFCnTvCgJ31ZQGICLT5Vzt4phItUeBeMpi1dkgmfblWME5sCkP/gspbWQLU7NSj7YFxVTuwboiSPCmp9zw2xeFdiCVlSRb6CsyQHxT8DybgZgUezpVYTeOmkXRi6qJiPDF7EwkdApt6H8hwesr2ikNkS9JqeLGCqq0I0m+UTYLAu226GRpJbth2M3n16Ey+iOi3bnkcu22Zpw4hBhvLzZWO3rrFzXd8X2NM0U9yaVEAA05/KOEfRWf4tnkVRXzpzjMDZA2tGXwBCeYbPqzMX66N7rq8zrk++7/tj2WoGCw7VB+T+qJslXn8cyRwkUaf6J2AcI1SoWltmqO/fU6bLO5pw1RBwin6QoxFJ9Zn8DzB3cHUHri6jQJhXbZlqqSIwgftyTknIwQtXomRtO3QUVJLX3MfC16SQaXn98zdQxIUNzs27Ejvo8W8XmUnFtD+446LEd5JsHCpxojg9De8SWuUxzcPd0XDpLBFadpVqSxhTdrFdHI9gh4Biia5u58cHy/sfJsrMMDEN/53yTNRcwtvKj9KgC4MnKeM8mbA0C7Tao5GBQMNLgz0ButRfWncOnl4Q5TXQ1prZTSuOd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(31686004)(38100700002)(2906002)(36756003)(6486002)(36916002)(2616005)(66946007)(186003)(86362001)(26005)(31696002)(66556008)(66476007)(8936002)(44832011)(5660300002)(8676002)(316002)(53546011)(508600001)(6506007)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmlTS2x1dG1XcDhzSVhjT1NuQWUyZU1vSGVla0JJeVM4YngzMG5aaFFES2pM?=
 =?utf-8?B?TkFDVVdxaW5DMzhjYUljdm5FMm5PQklnMzExTlUwK2t2NXBvdHRPb3J4aGtj?=
 =?utf-8?B?SUlQcGZLR01tT1pwWC84RExsU1VHdU5oRjNWUVhmY1RNRVZ2dmN6Y0p6cGRY?=
 =?utf-8?B?WnJDQVJadFFGU3FkMFdLaCtra1dXczZraG1obnlmVDY3VE9ESFA0UWdaakVv?=
 =?utf-8?B?R0M5Yk45elN1NmxkbERaUTJmSEFRK3FsRVVOL1NUbnBZd0ZUc01Ic1ZBNm1q?=
 =?utf-8?B?Nk5UanBtMEZITy8zcVFnNFJIOHJQdWNxdUdKdXp2bDhZMEh2RTlDbUNLWGla?=
 =?utf-8?B?a2JCVCszK004QkhSZmNla2RFVjkrZWMrOUdPdDc3d3YyUHEzbGZUYWtIQWtW?=
 =?utf-8?B?a0JMRXBTNWhBZjgzTmpleDFzWjBPM08xTXhkeDJETGFXdjhLY0V4UFRvNHFI?=
 =?utf-8?B?Qmcyc1ZvNkZ0SGxBYlZ5UUUyMTFKeWtDbG9FelBxM0JPaTYweWU1V1Z4cGZX?=
 =?utf-8?B?eEFVTTdnaTFJd1pxa1ZpVWdndTBSY05UekljZlVUTlBWYm00cUhnMysvSjdO?=
 =?utf-8?B?dXBua0RzMVBLVXR6MHRPNGlHd0xOZlFQRm9VelA0Y1QyVHlUQzlZS3FjVE9x?=
 =?utf-8?B?djV2M3M3SGVtalFaNXJJMDZQWEJuZ1RIWU9WUnBCVjlUQS90dEI0VDZFT2Fn?=
 =?utf-8?B?cUFrUlBSVlkvcVpUekhCZHMreE5RMXYrRS9FeklXTXpMVW1NNkVKVGUvaUJG?=
 =?utf-8?B?WWJOZDJnUXFNbXh0RFFKRFlLMGl1V0hoTVkxbnRXMTVubDNCVkpPaDJienRB?=
 =?utf-8?B?TGFjV1BObVZsY2lUY1hnclIzYjNvMGx5MGxZa0c1MTgrUG5RQThDWVZESSt3?=
 =?utf-8?B?bHNXN1c5YVQ4TGhDeXNvUXNscXJEYVZVMGh6c0l3djZkRWRpTDN3Q3VTYWVB?=
 =?utf-8?B?dUJDTm5OWDRzMlFNc3Z2NUZiOTE1NXRNN0p1Q2V3SG1KODhHbGVIcVJzaXdl?=
 =?utf-8?B?YVZaV3U2dytDSTN3dERLWENDQktXcVRFNHUyd0hSTFd4SFd6VlB2OVRONk00?=
 =?utf-8?B?dGw3NzlEeC9peTIwVUFyT3VwSVN3TDY1RDhiRVVjMFkzdlNRS2RjRGl3dEhV?=
 =?utf-8?B?QTRiOXo5clo0dTF5MnY3SktCT0E2aGw3VVpXcTVIUndCTHF0RGVrRDFEYytW?=
 =?utf-8?B?aktSdVRiUTNvUVEzRW5KUnpkTjhYTDFMWlpBZ0RBTG9kK1RnMk8xV2tjZjVP?=
 =?utf-8?B?UmJicTMxVC9vWU5zbFp3SlMweTdsRHo4UlBxVU5NNlpEWXNkZE9mUEdUTzBG?=
 =?utf-8?B?UlpuTjRWTWZnYTZYWXFuRkVTcVhGR244STFhZzZtb3I0M3c1MzBhN2xQYWg3?=
 =?utf-8?B?SkRhVnFKbjJOK2lpVFdoaEFDWWtkNURzTTU0WUhJUTNtbEYzZUU2WUxDQlJY?=
 =?utf-8?B?MGVLS1h3U285N3VySUxNT1VxdFdpNlJsdnJoZWFVUkZmcWx5Vmt6bXBGR0pC?=
 =?utf-8?B?TmxvWTVJUGp3VXhmcDdFYlZPcWVBV0RLZmwzajQvMDh4ckFuTWFWMHJYbnZs?=
 =?utf-8?B?NWszL2ZUbkdXU1phYzZNQWNLWDhvelZnMzhWdnhER29NY0tVRmVod2MydDR2?=
 =?utf-8?B?WE1sYVF1Y0FuNS9sVzJIQXZIMmsrVzYyVFZiTi8raGtjQ2lQb0ZaTnIwUWpS?=
 =?utf-8?B?YnJGcFpWbGlnY2xyN3cxZkJuNndYb3ExRGhhNDZmaW1BcFR5alByVTFzem1m?=
 =?utf-8?B?RjlpQlBreFFMOXhUR2VIeGY5b0hWeWZVOU5BQXd6VWdGY3Q3UlVCNVJBeW9m?=
 =?utf-8?B?Q2lIeXdkTFc3aGpwWi9jb1Z1NUdjeUM2SHdKSHhIVW4zdGhmaG5lNjBIQk45?=
 =?utf-8?B?UTk5UG5wOUlqY05rNzV5VFI2Y0FsaGNzZ1hZL3JxSGVnekJ2SUxLMTdPcmxY?=
 =?utf-8?B?UHdpYVcySmFQeGdGeVhJSjEyWnBRTFc2OXN2TEJwLzZJRGxhWml4N0JEL2JG?=
 =?utf-8?B?UkpUTElLZ2xhSlBmSXBOcHNmUzNmek1nZTErY3g0SUF2aXBsZGFrNnpvRHBt?=
 =?utf-8?B?NitFSHB2NmFjalFadW1oSVI5dTlZSEZxNThjdDBFYkM2STNpYTEvZFAwdnpJ?=
 =?utf-8?B?cnJzSGloNFZtRm5UdzdTMTRPU0tkUmdDa2prZjJoY0FmOHp3d1I0aTNCWkZi?=
 =?utf-8?Q?93UDQoaaIeJMWYgTm27SXGM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1e7fcb-b2da-4418-aeee-08d9ec12d318
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 21:26:24.5749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhRWaIdVt/RFUi3rflcxSi/nkMSI0ouvMxNViRjOvsU16zF/TaxZ6bTLrv4pzRZGIynNcCSjm2G2dmV0MIXoug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3168
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


On 2022-02-09 11:11, Jonathan Kim wrote:
> The hardware scheduler requires that all SDMA 5.2.x queues are put on the
> RUN_LIST through the extended engines.
>
> Make extended engine unmap available as well.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c       | 5 +++--
>   drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c    | 8 +++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c    | 3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 5 +++--
>   5 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 7f6f1a842b0b..f12e32335eb3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1555,7 +1555,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   		return retval;
>   
>   	retval = pm_send_unmap_queue(&dqm->packet_mgr, KFD_QUEUE_TYPE_COMPUTE,
> -			filter, filter_param, reset, 0);
> +			filter, filter_param, reset, 0, false);

Does this still work correctly? We currently rely on HWS unmapping SDMA 
queues when we request unmapping of compute queues. Is that still the 
case with extended queue selection in map_queues?

How would the caller know to set this to "true"? For mapping, this 
detail is hidden in the packet-manager implementation. But for unmapping 
the caller needs to know? That doesn't make sense. But we could probably 
remove the SDMA filtering functionality from pm_send_unmap_queue 
completely. I don't see any calls where we try to unmap specific SDMA 
queues. Since we always have to replace the entire runlist anyway, there 
is not use case for it.

Regards,
   Felix


>   	if (retval)
>   		return retval;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index 1439420925a0..8694cfcd57d1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -371,7 +371,8 @@ int pm_send_query_status(struct packet_manager *pm, uint64_t fence_address,
>   int pm_send_unmap_queue(struct packet_manager *pm, enum kfd_queue_type type,
>   			enum kfd_unmap_queues_filter filter,
>   			uint32_t filter_param, bool reset,
> -			unsigned int sdma_engine)
> +			unsigned int sdma_engine,
> +			bool is_sdma_ext)
>   {
>   	uint32_t *buffer, size;
>   	int retval = 0;
> @@ -387,7 +388,7 @@ int pm_send_unmap_queue(struct packet_manager *pm, enum kfd_queue_type type,
>   	}
>   
>   	retval = pm->pmf->unmap_queues(pm, buffer, type, filter, filter_param,
> -				       reset, sdma_engine);
> +				       reset, sdma_engine, is_sdma_ext);
>   	if (!retval)
>   		kq_submit_packet(pm->priv_queue);
>   	else
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 7ea3f671b325..08f736080b7e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -183,6 +183,7 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>   {
>   	struct pm4_mes_map_queues *packet;
>   	bool use_static = is_static;
> +	bool is_sdma_ext = q->device->adev->ip_versions[SDMA0_HWIP][0] >= IP_VERSION(5, 2, 0);
>   
>   	packet = (struct pm4_mes_map_queues *)buffer;
>   	memset(buffer, 0, sizeof(struct pm4_mes_map_queues));
> @@ -214,7 +215,7 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>   	case KFD_QUEUE_TYPE_SDMA:
>   	case KFD_QUEUE_TYPE_SDMA_XGMI:
>   		use_static = false; /* no static queues under SDMA */
> -		if (q->properties.sdma_engine_id < 2)
> +		if (q->properties.sdma_engine_id < 2 && !is_sdma_ext)
>   			packet->bitfields2.engine_sel = q->properties.sdma_engine_id +
>   				engine_sel__mes_map_queues__sdma0_vi;
>   		else {
> @@ -249,7 +250,8 @@ static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>   			enum kfd_queue_type type,
>   			enum kfd_unmap_queues_filter filter,
>   			uint32_t filter_param, bool reset,
> -			unsigned int sdma_engine)
> +			unsigned int sdma_engine,
> +			bool is_sdma_ext)
>   {
>   	struct pm4_mes_unmap_queues *packet;
>   
> @@ -268,7 +270,7 @@ static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>   		break;
>   	case KFD_QUEUE_TYPE_SDMA:
>   	case KFD_QUEUE_TYPE_SDMA_XGMI:
> -		if (sdma_engine < 2) {
> +		if (sdma_engine < 2 && !is_sdma_ext) {
>   			packet->bitfields2.extended_engine_sel =
>   				extended_engine_sel__mes_unmap_queues__legacy_engine_sel;
>   			packet->bitfields2.engine_sel =
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> index 3c0658e32e93..a83aa94972e7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> @@ -200,7 +200,8 @@ static int pm_unmap_queues_vi(struct packet_manager *pm, uint32_t *buffer,
>   			enum kfd_queue_type type,
>   			enum kfd_unmap_queues_filter filter,
>   			uint32_t filter_param, bool reset,
> -			unsigned int sdma_engine)
> +			unsigned int sdma_engine,
> +			bool is_sdma_ext)
>   {
>   	struct pm4_mes_unmap_queues *packet;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index b6790a637f5c..b157ba0216f0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1249,7 +1249,8 @@ struct packet_manager_funcs {
>   			enum kfd_queue_type type,
>   			enum kfd_unmap_queues_filter mode,
>   			uint32_t filter_param, bool reset,
> -			unsigned int sdma_engine);
> +			unsigned int sdma_engine,
> +			bool is_sdma_ext);
>   	int (*query_status)(struct packet_manager *pm, uint32_t *buffer,
>   			uint64_t fence_address,	uint64_t fence_value);
>   	int (*release_mem)(uint64_t gpu_addr, uint32_t *buffer);
> @@ -1279,7 +1280,7 @@ int pm_send_query_status(struct packet_manager *pm, uint64_t fence_address,
>   int pm_send_unmap_queue(struct packet_manager *pm, enum kfd_queue_type type,
>   			enum kfd_unmap_queues_filter mode,
>   			uint32_t filter_param, bool reset,
> -			unsigned int sdma_engine);
> +			unsigned int sdma_engine, bool is_sdma_ext);
>   
>   void pm_release_ib(struct packet_manager *pm);
>   
