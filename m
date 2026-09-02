Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D842EC61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 07:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ECCB10F022;
	Wed,  2 Sep 2026 07:07:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X9JwfTKO";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A05D10F022
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 07:07:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NufidSne/5PHUZ4uz9JFcwPuZXi9dJ91vGhaC0on9Z6suDR/noYoPDs21lQTKBtOS4ODTutH2MKDGDsxM7dDB3FxWSHoL0ZUQc+xoXXhXNdDjE1rNs4LVc8l2+SRHocGaJJxQb2KKrUofqN4SQQ3QKJw/+EbmH4ryJnxhkAtNnb8JqKgdHJOBaaAy2GxMdZFK0iRLI0spHYLt2KtOuagn7PBoVO/2q/DNMNpieHt5DNM4yzTWRkY6gj5DJ9Q2Nlws9Y6wRNpquWM2fJXSqF6PAXRL1ePQxZz8sJY6jKMV9iWkNJoJGsi64+lUQJbupoadc+81TzcM84T9VixC0MneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmH7t1EQicSGI4TERnzAvW4DOjpphV8cZbWiZDzTJCo=;
 b=ygx3E/v16UlvuOfHLjHMEe/I/uujzv5FWTPyQTZI7b/XlfUTpfQ94FT0a16b1w3jsr7GpnZijDeM0dfQAp88r9lATOTbu+oO8oLrVd0DjF+MgYkDKPlyFAg9eUpvstP9B5sOZbN2EYVEaodxHgNeyNv1GjWNUJ0aLz3LA/1ENd/JLvpmpKuZhdFGiNXUH1+YmAgY0aRrukznGCLNL2bvP4SvAIOHiBeGKw3nW4uO/FD2ea2SbftMbOg7/ePZsp+NHXDUk3fZ7Tf8T1MlrmGUPsxGA8sY8UCE5zaGoVQEY4i2n/mPBqvq0N8B7b8m5SxMHCrbrTRK6VV2PGjnfKVotw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmH7t1EQicSGI4TERnzAvW4DOjpphV8cZbWiZDzTJCo=;
 b=X9JwfTKOvznyrfSW6uC16tQi9gw9PC3hjMTLhKQoU+CN2JlwAe/gwSN/Alf///IEn3jG81AwPvhtnpz0qJ5wHk9YwPZiU46ST0TbmvOK4Y4o+iyIH7Ec4KdXLyHac6fvgOyEhwof5KDkxRD1yPnay9fnWNlGQi3fjiAEyZgp+Fc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 07:07:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 2 Sep 2026
 07:07:41 +0000
Message-ID: <05e8a019-903c-4249-9c82-11dce0403aea@amd.com>
Date: Wed, 2 Sep 2026 09:07:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/31] Rework GPU TLB invalidation
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0021.namprd22.prod.outlook.com
 (2603:10b6:208:238::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 446d1827-08e1-41fb-0dfb-08df08c0e158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: xDFjAS0QVrrnjp9ewGXt62eH1RbI0o0VKX/XfXBiNWyBrgFutgvrW5rG7j5e7ntK8d2EeRQbS9uXVlPkb90g5GRFDpsJYeitaNTNC+f+mHmahT1hzHWeQ8P9vF9c5pRtus/INQbZdZYiHj6Q6a5RoITLnQ3/urjMB56MHSZbHu2xNLUXBldjWiWJzRfrINJuzbrwD5vy7vMS2HH1eSszBpuqR7wcpkE6xapunXncSE4thv5EjtZ2wq66NFxjrWfNLvDzGlSvR3Xox6fV3sgvl/6baMDh0LFQNTJ9k9Akgi4OOsHHX9/8WxdlZw+4nVjM944ZJYXb2xJiac2pl/CtONvpaTCFGUZJ+5mmLdoxu2uAkeMXnzn2NzMkSMhVnl5Ym21Zye/BTps5pL9kBuszhHNIlcXeGvjttlxfmM9fcWWpPxIJW4l1Ov31YqJGhPmulH/KuGGPw/x+lPXkL/pE/YEiEEKbRe3W3QRi+WM6xztvjf1lZWXRBkMMotf9oLnb9l8w7pzVwCM6uv3gIx87G0iPxfz93mFkq8DtyQjxuqb/5yN5e1upbi8DjyeuDTwV+OT7tiQu4T26v9CTEcb4PJkj5UdaowpRG0+nGynRYie21w1PvQPmQBcIm9P9FLmU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elg4aWVkWU50aENPM0p0WmRvV0tVQ1BUbC9yVThpaUF2N1NFYXB5VWhQa3B2?=
 =?utf-8?B?MXBVU1cwOXoyQTZlV3JUSSs0L2x0Q1A1ZWdzMFE3N2piN1F3NzVFZnVvVEtI?=
 =?utf-8?B?d0pPOGtMOW5WTGJ1SVVucG5Tak9udHZEMkUxa3lhdTZtZHBMTTVvbkRNOC9v?=
 =?utf-8?B?WkNIL29CajQ5ZGFSbEJ5QzJIWlMwNDRVbWdDak5US1lCLzI0cmJHaTNja0tF?=
 =?utf-8?B?bUZBam9obVg5eG4rL2tDTUlXVHZFUGRyczgydFZnSzdRd0JDSzdqZXlxYVpY?=
 =?utf-8?B?dm9pV3haVEJhcXdmQzBVZThCVlBYUGZJbTNIWnVWdysxQWRKY21yQnZPSVRV?=
 =?utf-8?B?NWY0UGJRZmp3M2N6STZVS2EwMUVVcm9TWVE5dmNSc0Q1OHRrQlp6ZHhWTUJ6?=
 =?utf-8?B?WEZ6cFlGL1h1ckY1ZzhYRkw2NHQ4NW1FQ01ZRXJuVkMrTnJ6dUcyNXhtV0Fu?=
 =?utf-8?B?M1hRbHZKS2FRK3hQNXI2T2ZEdVdIVFZpV0hDeDRUTTFzTFo3enQrSVgyYmJD?=
 =?utf-8?B?S2lMTzhyUjFnRDRUbTgzMkZOUCt4eWF3Q3l5YmMzTmRqMXlySmM3VTMwcXZQ?=
 =?utf-8?B?ZXg1ZzVjNnE1anptcDdNeEZYSTlTcWJtOEFySEdqWnNHWFpocTI4UjlINkNQ?=
 =?utf-8?B?S1BqZFUyMlRTQTh2WlJ0N2xiL3lFd1M1b2NSL3BUdUxOZ2h2L3pxZURmQ2dS?=
 =?utf-8?B?S00wenpiZHBQbmp4V2pwL2hsMGVOMkRpaHRoM29NVWRDL0tYVHN1VUc2anMx?=
 =?utf-8?B?MExibWxRaVN4UzlxOHJOSldXRUJ6MkVJM0lpY055ejJyb0FGaFVEZEJlZ1ky?=
 =?utf-8?B?MlgyNTZMKzdERlVTaGgyMEFHNm55bGRvYmN1Z21wWlJndEZISFpQQWUzUXZQ?=
 =?utf-8?B?RXUyNDBIcXRINGhxZnUyaTAxd0ZUWU9IOEVNc0NVb0h3TXloOWdtazVtZDVP?=
 =?utf-8?B?cUZuZDFkMWsxVEJUVzR0Slc4TUwxamxXODU1Uko2M0MxWXZNMFJLTE11MW1B?=
 =?utf-8?B?eng4WEIyd0ZCRVFjZHRiL2hrdmtrNkljVlkzYUVXUkpldjlTYTVpNjZCbzhG?=
 =?utf-8?B?MDFtbDVOblNyNFhIL0MwQ3FGY2lRQUF3UUZtcVl1OXJpenJ0M3JiR285OTVx?=
 =?utf-8?B?VTIza2VidXBVNUxJYkdoYWZzRDZvbzNnaC9qaitvOEZINGxtZXJRSFp0UWp5?=
 =?utf-8?B?bjdnR29PU0RtaXlBb01MRXl1ODdNT2lCYmRiUCtDYjhqTm1QTWpnYTB6OVdl?=
 =?utf-8?B?bnhuVEMvZWkrdlQvZWV6aEdXVDFUQkpBd0NiOGVLWHBWUEpvQ1JnRzN2d0p5?=
 =?utf-8?B?NmorWitBUlFBQ1EyZTRVdDJLVHdwZkUvNE1iZHhNSUtZK0JZMDlVcGpzTFRK?=
 =?utf-8?B?dmR5RTgzaG5oWVhFWlVtTXU3VnYrakRjdXNpNTlVWTREWTdSbXRMdjVaTnVl?=
 =?utf-8?B?U2xBUEdHTVEzaEJvamx2UWkrSHZXL1BDWDFvTkVSa0JtN3ZjYUxIaTBIY1Av?=
 =?utf-8?B?cGE1Tm16WGcrMmFaMGZrYXlPbWdsV1gremh4c2tnREJWcXV5dWVTdU9BRkF3?=
 =?utf-8?B?R2prOFBlOE0rZnVvYmFyMVJhTXQ1RHY1Y0R3bURvT2dxM1NuY01qUk5uRjZk?=
 =?utf-8?B?UkU2Y2szMXF1NjdCQ3hmcGgxbG44STlLN05vRERaNGxNSHN2RjEwZXBscTZB?=
 =?utf-8?B?NjZSdFd3ZWhPS2c4ZitwZ0RvMGJYUXhBVXhXWXNPR1lBeHFNc1FMWnAzeksr?=
 =?utf-8?B?Qk9aWmV5KzNPTGJXa0g0eXl5dHArWUZwc3daQzFmRGgrdXJndy9SWEU4NE8v?=
 =?utf-8?B?ZFZQWHF6aHZSMlI0dG1COCt4NDJCdDg2V0lYd3NjWmJPNVI5emVJaHpXTTF2?=
 =?utf-8?B?dU9Cb052MXhrb1ZxT1lVSE5yY0tNRldaQnJTSGxyNlBkT0ZadkNzdzAvSDZR?=
 =?utf-8?B?Q1BpOWZrQnBjeVp1QnBZSEhiWXZMUFM5VFNDelhmYXlobFlwYktoZnJzcTVT?=
 =?utf-8?B?WXNPWEdTeWV3aU4rVEJUWW5Db3dVbXZHdGdVT0NXMSttWHJZQnVrTjMxc1la?=
 =?utf-8?B?RzVTRnNrTUdnckRGMGlXR2tDOWI3QlVVbEg4Q2wwbytJYi9hMjArTkRBRlJu?=
 =?utf-8?B?cE1MRmx1V25WQzZkbDk0Q1FLWUpidGtuNTFmQkY0UGpjRWhCTzVLN3ovWmFV?=
 =?utf-8?B?QWhnOUtZdGpmbm5xT3dkTG9BNjdvQ3RPN3ZCdzdNQXBaeURMemJaNTdyTWpX?=
 =?utf-8?B?Y1VMU0hSMTF0dXpTT05uNExhOUJPUlpseVdjVENQdGFRU2U5MCtqMTZGdDBM?=
 =?utf-8?Q?nZlxBjPyo9o0oPrVnN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446d1827-08e1-41fb-0dfb-08df08c0e158
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:07:41.8998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEM7XjJXlRnqPatAx9twBbI06EOs8XQSaC4mTMqREwkjMWK2WVrC8seU7mqmBrIS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302
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

On 9/1/26 22:10, Alex Deucher wrote:
> GMC 9-12 use KIQ or MES for TLB invalidations to avoid using MMIO which would
> require disallowing GFXOFF.  KIQ and MES are management queues however and if
> they hang, they cannot be recovered by a queue reset since they are the
> mechanisms which handle queue resets.  Since using KIQ or MES will exit GFXOFF
> anyway, explicitly disallow it on the MMIO path and use that. Next, switch to
> using SDMA for TLB invalidations.  SDMA 4.4.x and newer have special packets
> specifically for this purpose.

That packet was just introduced to work around SRIOV issues and proved to cause stability issues as well.

Since Arun now found that on basically all Navi generations the SDMA can hang while doing a TLB invalidation I have to clearly NAK this approach.

In the long run we should do the TLB invalidations on newer HW completely with the MES, the SDMA was always just a workaround we should not push forward.

Regards,
Christian.

> If SDMA hangs while doing the invalidation for
> some reason, it's easier to reset the SDMA queue than KIQ or MES.  Finally,
> most of the TLB invalidation code between GMC 9 through 12 was identical, so
> move it to common GMC helpers and remove the IP specific code.  If the SMDA
> and MMIO pathes prove to be stable, the KIQ pathes can be removed in the future
> to further simplify things. SDMA 4.x could also be updated to support PASID
> invalidation via SDMA using either the new packet (SDMA 4.4.x) or via
> REG_WRITE/REG_WAIT packets (SDMA 4.0.x).
> 
> Code is available on this branch as well:
> https://gitlab.freedesktop.org/agd5f/linux/-/commits/tlb_inv_rework?ref_type=heads
> 
> V2:
> - Add missing hub callbacks in gmc9 hubs
> 
> Alex Deucher (31):
>   drm/amdgpu/gmc9: disallow gfxoff around TLB flushes
>   drm/amdgpu/gmc10: disallow gfxoff around TLB flushes
>   drm/amdgpu/gmc11: disallow gfxoff around TLB flushes
>   drm/amdgpu/gmc12: disallow gfxoff around TLB flushes
>   drm/amdgpu/gmc9: set vmhub funcs for gfxhub and mmhub
>   drm/amdgpu: add a gmc flag for using MMIO for TLB flush
>   drm/amdgpu/gmc9: use MMIO for TLB flushes
>   drm/amdgpu/gmc10: use MMIO for TLB flushes
>   drm/amdgpu/gmc11: use MMIO for TLB flushes
>   drm/amdgpu/gmc12: use MMIO for TLB flushes
>   drm/amdgpu: add a buffer funcs callback for TLB invalidation
>   drm/amdgpu/sdma5.0: add tlb invalidation buffer func callback
>   drm/amdgpu/sdma5.2: add tlb invalidation buffer func callback
>   drm/amdgpu/sdma6: add tlb invalidation buffer func callback
>   drm/amdgpu/sdma7: add tlb invalidation buffer func callback
>   drm/amdgpu: simplify amdgpu_gmc_flush_gpu_tlb()
>   drm/amdgpu: add tlb invalidation method enum
>   drm/amdgpu: plumb tlb inv method in amdgpu_gmc_flush_gpu_tlb_gart()
>   drm/amdgpu: uplevel reset check in amdgpu_gmc_flush_gpu_tlb_gart()
>   drm/amdgpu/gmc: add new callback to lookup vmid to pasid mapping
>   drm/amdgpu: add a gmc callback for the inv semaphore
>   drm/amdgpu/gmc: rework pasid flushing
>   drm/amdgpu/gmc9: use SDMA for gart TLB invalidation
>   drm/amdgpu/gmc10: use SDMA for gart TLB invalidation
>   drm/amdgpu/gmc11: use SDMA for gart TLB invalidation
>   drm/amdgpu/gmc12: use SDMA for gart TLB invalidation
>   drm/amdgpu/gmc10: use SDMA for pasid TLB invalidation
>   drm/amdgpu/gmc11: use SDMA for pasid TLB invalidation
>   drm/amdgpu/gmc12: use MES or SDMA for pasid TLB invalidation
>   drm/amdgpu/gmc12: drop MES tlb inv in gmc callbacks
>   drm/amdgpu/gmc: add helpers for various tlb inv functions
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 486 +++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  33 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  18 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |   2 +
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c |  33 ++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  33 ++
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 202 +---------
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   | 207 +---------
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   | 250 ++----------
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c   | 225 +----------
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 135 ++-----
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   |   4 +
>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c   |   4 +
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  |  33 ++
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  |  32 ++
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  32 ++
>  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  |  32 ++
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  49 +++
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  49 +++
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  49 +++
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  48 +++
>  22 files changed, 943 insertions(+), 1015 deletions(-)
> 

