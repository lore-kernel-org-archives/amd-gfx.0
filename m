Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11203EB64DD
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 19:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C71A10E3F6;
	Tue, 25 Jul 2023 19:23:54 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABABD10E3F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 19:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arWbmcAa5hk2sLdHuzooZ+FLGWYZDnWutV3ZJYbYcset7HQIFVoJP+msjWe+OPDSK5c7u5YV995CK1S1hY2SMT8DYfKHA8PSoQbHAT/Vu3wPSkWOUXEFnTACyZxJIETKC30/mDYGwLpt2VECX6IZUHojqYzbQZqRPZpB+jVegiQhNutZ+fPqgB1xPpDS9qcfi1BRNTuEjhJ0Hvmb1OJMkcwE5QmPIFJ2/kRZVxFTaXheETKwowLNkyvijjl2l90/EwKGouXKTtjg4gyBX8wltjkRiSwrYl6yRCU8VI8eKtk291gmHqpB/n6MNhUp3qrHUXtKD4+5s6Bi/aSKnz49bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSnFSrCqqP5G3LNSjQ6DGGWjcLu2MmaH24UiJuV3t+o=;
 b=lJtddfOImX7D/PDBeNI5w9E02bdpNcs8Qn9KejJBjSNys1i3IZUMxZx+iGxaoVqGUpUdrfODODwjBduHTm4MvZhLqihaQoAhEzBbxf+mxRLSd+Wwj0qYlptn8QDTKO9iRqvggnS4BYV04KLeY8iJX9zFG4WbWcbBVJ4RwP6DaURXQZRFPj1OjvEOMcmyHv6RFtdl5hOEk7ZT50nJRj/ErX2l5nOIGv7GXRYffqBE72AID0Xa6fMLGcvzs1XUQWSP5+BkWglVgjqIf7a0VYQrpr+wuhkTDdGsn0aLRe2H2TT0BU+dhh1S5xHwpiuosM/gI2kE7+L94VUA7NWKWAy/CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSnFSrCqqP5G3LNSjQ6DGGWjcLu2MmaH24UiJuV3t+o=;
 b=n6MALf7nsI5Uw/buYGxRf9f0fV2haDK+gxhBgqUjMdFen+UgcL9/2g2NWEgneiecK74y11tNdlaZrzWZGIh8lsZ7teNoiuk9iGFJdZzIcdbHOV9wTrpQzN3CX5V6dyIiXsOUClw18WyLIxN2cjT60JtLsO16ABpVh4PA9sVWzPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by MW4PR12MB8612.namprd12.prod.outlook.com (2603:10b6:303:1ec::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 19:23:50 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::4d2a:6792:2239:9e72]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::4d2a:6792:2239:9e72%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 19:23:50 +0000
Message-ID: <1716c2e2-494c-21c3-7858-6ec22a3eb805@amd.com>
Date: Tue, 25 Jul 2023 15:23:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: fix and enable ttmp setup for gfx11
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230724190159.3544879-1-jonathan.kim@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20230724190159.3544879-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:408:e6::13) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|MW4PR12MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a6ca5f-75a7-4a12-6497-08db8d44ad0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3UabwQcV7gg7rXmIBEkZ5iO1Ux5Ppsrq2MZYVwAUDNFFscoE/HKs2jRss9pw9gkyco460Vf6vtwiS2vdc1GbjFv3/+c5FuIVkfh1JQY0LmvdeOf04PL2WS+qZMmLxkS+D8QUsc9nHrsXeeQW0t5XdXq8QZqxUbhBYihP0z6ppJkL3crcKADP297lgEo2VNT1673gt1lGRTT6/JibQzsASI+ah++v1B13uvw9G9S12/q4CQO2M+sv78Z/9f0ESiEG2Wvb+umB02snFldImQBXBei+TOKvklbb8J6RpW5TAql4j+fX40JYDO45P+Lq2S6y/KwNecIqut2GMlXWsGHfIg8jGbsQ3zdxw5zNcnhfpu6xseuoThZS7uhiZHmo8Pjfyk2FydvwtMCDC/OQLNy+tsCgsF5dYcOMDt4KnQS/xyK5Xf1WXaZUj8RxbTsD3ViltONzZU4LfaGfGyKhdwekSwfkVOzvMU/Wk1g4olTnp9JZSOc1txJI4IhoFs1srUngEUr4UNPPaljVpl0OuElh+PIU20uDAG2za3+lTTKArv88UcHXZzOBHFj6QumUaozuG33u9mpCZXtFxMpiYxFazRjFvjo55IokIOxhBE+DexwUBk5N18WT0OpCyF18f67Xi6gv9M/yaNyPvX5loQtmAz1V7ruG6GbBJWU59zriImw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199021)(6506007)(6666004)(478600001)(6486002)(6512007)(186003)(26005)(53546011)(8936002)(66556008)(66476007)(5660300002)(8676002)(2906002)(38100700002)(36756003)(4326008)(41300700001)(86362001)(31696002)(316002)(2616005)(66946007)(83380400001)(31686004)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3BrUWVWZU81ZlQ2aC8xNCtmcDdiRmh4QzNuQ29wL0JOajQwM0FsVkJLbGtO?=
 =?utf-8?B?Ymx3ekx1ZTlCcTI4clN5bVBnNmRSUkNZT0RJeWhhcDhLbDNMYW14RkdWY0p3?=
 =?utf-8?B?WnBIeGxRR2hPZXNSM3pxN1EyNG5OdktKQjNtWEZvTzhJSG9YdFhxRGF4dWth?=
 =?utf-8?B?c0FjWmRENjllWTJFMDFPV3U5cEVPUGJzRm5NMENtNGFralFlQ3hLV1d4Unha?=
 =?utf-8?B?WlVwY0NWTU11ditjV2F4WGtJQXgyZEZGc2tMTFFkZCtYSUFaTTlrMWhUQW44?=
 =?utf-8?B?cnZScFIyNmQvdFA4QUFvVEExdER1UEc2TjBSRXNVdHo4WTBqSEk2V0M0bFRP?=
 =?utf-8?B?aWtYOGk2WUh6UU5zdXptOHRKQW45aWx0WEdEd3g1VHNOQm1NYUR0cGVKTlJk?=
 =?utf-8?B?dTlIK0QxUGRmc1VUa1pCY2xEa3dqOWtwSTFaUHIrU1c3cW5kdnh0Yndvb3p2?=
 =?utf-8?B?RUMxWkZnVjZ0WDQwRlZ6NkFmVXl4MlcxOWRYeDlNblNTMlUrdTJHdk1EbWY3?=
 =?utf-8?B?T2VrN25SWEJHR0hOdzBKbkZlalhJWktrNHZRbmk2T0ZRSWpVaktBRGIyNit1?=
 =?utf-8?B?T0dqdlZqNXM0dXFyQlJkbmFRWVA2NDl2alE5OVhLK1h1Rldnb2hkbWE4dGs2?=
 =?utf-8?B?ZFZEQmV6dG1LTzQ4TEpyMm5qRXRxemt0QWtRcnR3dGVlUExVMldDU1E3M0RT?=
 =?utf-8?B?ejBCYTMzZzN4enlTWWR2N0VxU29CcHhTenF0dXpSWjluTjBBK25NaGp0NG9l?=
 =?utf-8?B?UEcvakxqZnk0bGlyNjRpd3hENWxPU0xWV2gxQ2dLdFlXMTVKbG9UaWoxaGxE?=
 =?utf-8?B?MHVGZ2t3R1YzS3dWWFBuY2U3cnNnUmEzWjZBK1ViRlRyYm95SXR2aU4xcnVM?=
 =?utf-8?B?aStYYnI1dGR2VUlKWkg4blREd3pZVERMcS81U0tLdWRPZ0ZSRVdaMFJzS3Bn?=
 =?utf-8?B?QjhtWnM4RFQ0NjBxV1dERDJIak1obFdOSHorYkVVdlNTU3FodHg2WjM2MVRY?=
 =?utf-8?B?aHYyRXJjWUZZbmt4SnZRMWN2d1VONVZCQ2VlNzRNSTZwWW83QzhxSk9rbFhs?=
 =?utf-8?B?cy9vSU05Z0t3bEhBWDNlRGtUcHJtdVRCNzB5TEt2QWdTNnZyMHlKVk42VldR?=
 =?utf-8?B?dTBBZFVTbGdQTHBBNWsrL2JUblhLZHo3NGRCTmF4OVRteWYxT2R2TlEzSWxM?=
 =?utf-8?B?Q2JuTDVrQzJteG1iVTV5WTAyZkRDTHAzMS8yUWRtOXpFUmpXU0NWMElWd0FQ?=
 =?utf-8?B?RmhQcDFTTE42MFoycFlFRmlmR2RxY1pseThXRW5KZUZnckh1N1Q0dFo1c1NV?=
 =?utf-8?B?RkdoSi90MVJCRlhLZ2ZBc0FGaGdnWStsWUp6b0ZldEZIR1ZrZTBMK3lCUFRm?=
 =?utf-8?B?ZUQvaU9mS3dMZ1JVK1FjYXdXRTNxZFBhRkZqRFBLUGwvazREWWZKTDNlOXo1?=
 =?utf-8?B?V3hTS0tCQnh3V2hGeWZXVGw5ZXkrSUc2YlIwaHVHZkd1SGtacUR6TnBaY0JC?=
 =?utf-8?B?azcxSEZabWZlNi9RNjh0Y1hLZ3VZWTEwRFR1U09uTWlaZ1JuNE95OGlYd0FB?=
 =?utf-8?B?eDI2V2hFSklLN01nMWQ0RXl6MTNLZ2dKdWk3WFE0VHBsZ0R4Tk1iN3J4ZTcx?=
 =?utf-8?B?QkUreFdNVlkrS3EzRXROWFQzWXhYaE9sTEZpdnp4UW9YL2RIYjFObzJFaUhi?=
 =?utf-8?B?UExtMWYyRTFoRGlHOTNyYXRYUTJjL2g4MkRzcHVrZzJwZjMwaEh0bWNMUEpu?=
 =?utf-8?B?b2lIUktKV0VTU3hJZk4vZ2txR09FTk5OOS82Y1pPdkRFbWgvOHMrekxuemZw?=
 =?utf-8?B?Tzd3N3pXaWtzMXNFek5TSTRiWE8wdlBidWRpRTl5Q091ZVFmdzJ1SHZrY2h2?=
 =?utf-8?B?U0RhdmVZTXIvbVoycEtsRGFKbWJMb0FvQkZFVUJvWS91RzdmT1J0K0tYUzZN?=
 =?utf-8?B?bzN3YklydVJ0aWV2Zmpwd0lveVZLWE1rdmVYQ2lQcmxYdVJPSzhLTW83YmtL?=
 =?utf-8?B?UnBDeUxLS1BlZDlmbTJUNnRacUg2bFBScFkzVzlwTmhJNEtvbTl3bmJhb3lD?=
 =?utf-8?B?VEphUUlIeDZaNTE3aDBTaUNjM1hMblI3cnJpNmpEZDFrbFNBOGdQMzBKMmt6?=
 =?utf-8?Q?ArALu23dTMfSVck1Ixz9Knt8H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a6ca5f-75a7-4a12-6497-08db8d44ad0b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 19:23:50.5685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+e1cLEG8t9KyW313v6bQvVbpPp9MUdl/Vrf2qBNrSGWnRCm+zLEhjnwXCXHBTmNe2dCEv+i22VMjKZe0rn7/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8612
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-07-24 15:01, Jonathan Kim wrote:
> The MES cached process context must be cleared on adding any queue for
> the first time.
>
> For proper debug support, the MES will clear it's cached process context
> on the first call to SET_SHADER_DEBUGGER.
>
> This allows TTMPs to be pesistently enabled in a safe manner.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Eric Huang <jinhuieric.huang@amd.com>

Regards,
Eric
> ---
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 13 ++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 19 +++++++++----------
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h        | 11 ++++++++++-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 12 +++++-------
>   6 files changed, 39 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> index 77ca5cbfb601..d67d003bada2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> @@ -637,7 +637,7 @@ static uint32_t kgd_gfx_v11_disable_debug_trap(struct amdgpu_device *adev,
>   {
>   	uint32_t data = 0;
>   
> -	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, keep_trap_enabled);
> +	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
>   	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, 0);
>   	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, 0);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index e0f9cf6dd8fd..42df972357e9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2755,6 +2755,16 @@ static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
>   
>   		if (pdd->qpd.queue_count)
>   			return -EEXIST;
> +
> +		/*
> +		 * Setup TTMPs by default.
> +		 * Note that this call must remain here for MES ADD QUEUE to
> +		 * skip_process_ctx_clear unconditionally as the first call to
> +		 * SET_SHADER_DEBUGGER clears any stale process context data
> +		 * saved in MES.
> +		 */
> +		if (pdd->dev->kfd->shared_resources.enable_mes)
> +			kfd_dbg_set_mes_debug_mode(pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
>   	}
>   
>   	p->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;
> @@ -2848,7 +2858,8 @@ static int runtime_disable(struct kfd_process *p)
>   			if (!pdd->dev->kfd->shared_resources.enable_mes)
>   				debug_refresh_runlist(pdd->dev->dqm);
>   			else
> -				kfd_dbg_set_mes_debug_mode(pdd);
> +				kfd_dbg_set_mes_debug_mode(pdd,
> +							   !kfd_dbg_has_cwsr_workaround(pdd->dev));
>   		}
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 1f82caea59ba..9ec750666382 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -344,11 +344,10 @@ static int kfd_dbg_set_workaround(struct kfd_process *target, bool enable)
>   	return r;
>   }
>   
> -int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd)
> +int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd, bool sq_trap_en)
>   {
>   	uint32_t spi_dbg_cntl = pdd->spi_dbg_override | pdd->spi_dbg_launch_mode;
>   	uint32_t flags = pdd->process->dbg_flags;
> -	bool sq_trap_en = !!spi_dbg_cntl || !kfd_dbg_has_cwsr_workaround(pdd->dev);
>   
>   	if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
>   		return 0;
> @@ -432,7 +431,7 @@ int kfd_dbg_trap_clear_dev_address_watch(struct kfd_process_device *pdd,
>   	if (!pdd->dev->kfd->shared_resources.enable_mes)
>   		r = debug_map_and_unlock(pdd->dev->dqm);
>   	else
> -		r = kfd_dbg_set_mes_debug_mode(pdd);
> +		r = kfd_dbg_set_mes_debug_mode(pdd, true);
>   
>   	kfd_dbg_clear_dev_watch_id(pdd, watch_id);
>   
> @@ -474,7 +473,7 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
>   	if (!pdd->dev->kfd->shared_resources.enable_mes)
>   		r = debug_map_and_unlock(pdd->dev->dqm);
>   	else
> -		r = kfd_dbg_set_mes_debug_mode(pdd);
> +		r = kfd_dbg_set_mes_debug_mode(pdd, true);
>   
>   	/* HWS is broken so no point in HW rollback but release the watchpoint anyways */
>   	if (r)
> @@ -516,7 +515,7 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
>   		if (!pdd->dev->kfd->shared_resources.enable_mes)
>   			r = debug_refresh_runlist(pdd->dev->dqm);
>   		else
> -			r = kfd_dbg_set_mes_debug_mode(pdd);
> +			r = kfd_dbg_set_mes_debug_mode(pdd, true);
>   
>   		if (r) {
>   			target->dbg_flags = prev_flags;
> @@ -539,7 +538,7 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
>   			if (!pdd->dev->kfd->shared_resources.enable_mes)
>   				debug_refresh_runlist(pdd->dev->dqm);
>   			else
> -				kfd_dbg_set_mes_debug_mode(pdd);
> +				kfd_dbg_set_mes_debug_mode(pdd, true);
>   		}
>   	}
>   
> @@ -601,7 +600,7 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
>   		if (!pdd->dev->kfd->shared_resources.enable_mes)
>   			debug_refresh_runlist(pdd->dev->dqm);
>   		else
> -			kfd_dbg_set_mes_debug_mode(pdd);
> +			kfd_dbg_set_mes_debug_mode(pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
>   	}
>   
>   	kfd_dbg_set_workaround(target, false);
> @@ -717,7 +716,7 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
>   		if (!pdd->dev->kfd->shared_resources.enable_mes)
>   			r = debug_refresh_runlist(pdd->dev->dqm);
>   		else
> -			r = kfd_dbg_set_mes_debug_mode(pdd);
> +			r = kfd_dbg_set_mes_debug_mode(pdd, true);
>   
>   		if (r) {
>   			target->runtime_info.runtime_state =
> @@ -851,7 +850,7 @@ int kfd_dbg_trap_set_wave_launch_override(struct kfd_process *target,
>   		if (!pdd->dev->kfd->shared_resources.enable_mes)
>   			r = debug_refresh_runlist(pdd->dev->dqm);
>   		else
> -			r = kfd_dbg_set_mes_debug_mode(pdd);
> +			r = kfd_dbg_set_mes_debug_mode(pdd, true);
>   
>   		if (r)
>   			break;
> @@ -883,7 +882,7 @@ int kfd_dbg_trap_set_wave_launch_mode(struct kfd_process *target,
>   		if (!pdd->dev->kfd->shared_resources.enable_mes)
>   			r = debug_refresh_runlist(pdd->dev->dqm);
>   		else
> -			r = kfd_dbg_set_mes_debug_mode(pdd);
> +			r = kfd_dbg_set_mes_debug_mode(pdd, true);
>   
>   		if (r)
>   			break;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index 586d7f886712..fd0ff64d4184 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -126,5 +126,14 @@ static inline bool kfd_dbg_has_gws_support(struct kfd_node *dev)
>   	return true;
>   }
>   
> -int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd);
> +int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd, bool sq_trap_en);
> +
> +static inline bool kfd_dbg_has_ttmps_always_setup(struct kfd_node *dev)
> +{
> +	return (KFD_GC_VERSION(dev) < IP_VERSION(11, 0, 0) &&
> +			KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 2)) ||
> +	       (KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0) &&
> +			KFD_GC_VERSION(dev) < IP_VERSION(12, 0, 0) &&
> +			(dev->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 70);
> +}
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 71b7f16c0173..ccaf85fc12c2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -228,6 +228,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	queue_input.tma_addr = qpd->tma_addr;
>   	queue_input.trap_en = !kfd_dbg_has_cwsr_workaround(q->device);
>   	queue_input.skip_process_ctx_clear = qpd->pqm->process->debug_trap_enabled;
> +	queue_input.skip_process_ctx_clear = qpd->pqm->process->debug_trap_enabled ||
> +					     kfd_dbg_has_ttmps_always_setup(q->device);
>   
>   	queue_type = convert_to_mes_queue_type(q->properties.type);
>   	if (queue_type < 0) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index eeedc3ddffeb..3b0749390388 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -38,6 +38,7 @@
>   #include "kfd_device_queue_manager.h"
>   #include "kfd_iommu.h"
>   #include "kfd_svm.h"
> +#include "kfd_debug.h"
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu_ras.h"
>   #include "amdgpu.h"
> @@ -1931,6 +1932,9 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
>   			HSA_CAP_TRAP_DEBUG_WAVE_LAUNCH_TRAP_OVERRIDE_SUPPORTED |
>   			HSA_CAP_TRAP_DEBUG_WAVE_LAUNCH_MODE_SUPPORTED;
>   
> +	if (kfd_dbg_has_ttmps_always_setup(dev->gpu))
> +		dev->node_props.debug_prop |= HSA_DBG_DISPATCH_INFO_ALWAYS_VALID;
> +
>   	if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0)) {
>   		if (KFD_GC_VERSION(dev->gpu) == IP_VERSION(9, 4, 3))
>   			dev->node_props.debug_prop |=
> @@ -1941,10 +1945,6 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
>   				HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9 |
>   				HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
>   
> -		if (KFD_GC_VERSION(dev->gpu) != IP_VERSION(9, 4, 2))
> -			dev->node_props.debug_prop |=
> -				HSA_DBG_DISPATCH_INFO_ALWAYS_VALID;
> -
>   		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(9, 4, 2))
>   			dev->node_props.capability |=
>   				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
> @@ -1952,9 +1952,7 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
>   		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
>   					HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
>   
> -		if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(11, 0, 0))
> -			dev->node_props.debug_prop |= HSA_DBG_DISPATCH_INFO_ALWAYS_VALID;
> -		else
> +		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(11, 0, 0))
>   			dev->node_props.capability |=
>   				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
>   	}

