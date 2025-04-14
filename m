Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70391C369B5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 11:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E34810E41E;
	Mon, 14 Apr 2025 11:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iv1I8eut";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FCE910E41E
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 11:33:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjMJKGZEsEZ/AdG3Oo/eOhtwj0Is/ZhaaxvJF/Uu1voPp2vLdNM2wrRrvcb7KGICeEsY/QcRDKh9f7ZoaVKaKaCQfqaldlGzLWdk+w5k329B3EJIAYh2/96VRIbjzM8YjawUFEvowr6hvd8JtrDPUmKv1Big/IidyamQ/sdURKyRrsNxyrxFjSJYNm02mofbcK0QXm4bMVKz2D4sECFIryHiNYQSEGJcNpkPcwal0PW6DlfamnnG8CfaeEpUnBqJ6uRuNkRIrVqoGhjrg0uwOUEKJD+0xkHO3ux02EakmlRPdfabRV4vQewnG/8jparFSgdaU+MyXC2SVz8FrCNN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aG756LBxGGK5+z0Kc9BLOPu0CCnKZXV6+ihgz2SfaEY=;
 b=s32cu0HI4RvDJv/1JJezNlamhZJvt2Xmb9k74lUA0pu8YYnkLFooDLu2u6wgVhZLcVbUi0+izhUDuLajkTCDRy20D3cZl6yvUrFy1zQUqpLD/7nltiRymiLdMqZcjHw0CbBwX3q7CZnSoDZdoEsdHzmFJH0MKWtRkNb4xAsFaGDZDA+OUr2HuLtmdsK450LdSsYYXMueKhViTBFuzn7vBp7QEbqAwM5YODIon1Hwdapo56PTydHuxlyeIIQXleMfp4KmUD/QEde8VIUa1750te6J7VgNyQ7k51kTub2yWRXBXmVQDuU9eHh9CXGpcnXhXN5m5sFDm3p24BkL+tjs+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aG756LBxGGK5+z0Kc9BLOPu0CCnKZXV6+ihgz2SfaEY=;
 b=iv1I8eutzTdXW77+/fNb9ohCUEbDz6QcteWIrnz3lV9DO/DUiJLvvwGlliGXGsUfAp4yeWwZBUAhJeAgvA/Z4nXt4qF0eqdXK3/trsfjn8FjTpGofAo2wf901u15MnhJABcP6Q8mmEIFHSjud+sj2rphXiUntMBNZFCL5yXaw3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 11:32:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 11:32:59 +0000
Message-ID: <56dc90ff-afbb-4159-8a7f-fb4923537736@amd.com>
Date: Mon, 14 Apr 2025 13:32:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Add queue id support to the user queue
 wait IOCTL
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, marek.olsak@amd.com
References: <20250412080327.2687-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250412080327.2687-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ced95e5-2737-4c82-740b-08dd7b481bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFJ0UjBIVWZmaFpEcUtBU2F2TU1qTXVoR0xsNnRwMCsrSnFqdTVaYnFBUHMw?=
 =?utf-8?B?czR4WnBmbVpwN01SdmFnTHp5Y1dZZ2dUY3l1TnVtbGliVlVtQ2RXYXkzRks0?=
 =?utf-8?B?RW5wTGovUDlwZEwrbktZNGFFaDE4NElycEVlLzNvY3kyazFQTlJ1WG9US09x?=
 =?utf-8?B?SEx6VmVvY2FaaDBDQ1lld3RVNWRJRGt3ZHM4WDI4ZURWcEJjdTFhUjFLTDJk?=
 =?utf-8?B?SzVkL1JOajlSMjZyYVVnMEEwVStoQStBU1lsM2hKNCtpVE5OZnRvTVFuMDE3?=
 =?utf-8?B?MWUvcEtzb2twY0lqY2Q1QVg3bzluWHA1WTdiYWZrbkt2RTNkOTZUVmpieCtG?=
 =?utf-8?B?clBWN2RhaDlmQ0Z6Y1pjM1p1U3pYVEt3RS85cW9hSENXd1o0WEhmT2FORDds?=
 =?utf-8?B?L1ZMYjg4bXYxSEU1ODZpdDJscVVhQVQ0cEsyOHo4TDhZSDhYemRTRWhkUHdG?=
 =?utf-8?B?aUQ1SHY5bFBid1lWMjNNakdhM0JWQlk5TGdDUy9qUG53cC9VajlBbzF1VlRK?=
 =?utf-8?B?L2tjcXNBbEVTc01DSWVFVVk3aU11bEZpblNVT1M3YjRVNHlzcWxDU05EeXlh?=
 =?utf-8?B?bXdudE0zclc3bFltU2ZiOTIxdG1DczlNdit4OXl2V2RrU0lCQ2pQM2VTNnJF?=
 =?utf-8?B?cXkrZUUwTGpMaWQxbERvRDN5OElPVmRzdlE5NEY5dmhxMUVXaWpmTDlVelp1?=
 =?utf-8?B?eGR6ZGpuVys5RjBDWUZPVGt2Ni95MVkyenNNcEhPR0VudldYam5FK3ptRGFH?=
 =?utf-8?B?Z0NuQWI0aGZxZFdsWWM2elNTLzFNOXIzc0I3MjhOK1F0TGZkRHM2ZW5PVUsr?=
 =?utf-8?B?SHdHM2tuSzFFSldiRWdLUFh6UE4wZDlDUU54OFU5TjNZZnpkaFRNaXNJWFNv?=
 =?utf-8?B?VVVrSkRYeDdDZFRGT2ovazJnU3VMZWVBS25iQ1c4TEZZWmhVeDNqRmZZdi9r?=
 =?utf-8?B?eWpSems5Z2h6MDhZbm9OV3ZPT0M1eVpESU1ZYm43dlRvenFibFYzaTZoU1pt?=
 =?utf-8?B?MXk5NTUxWEQxYWEyVnZmdWwwaGZQQnhQSHpRVk4ycTQ5SG9CZ21jamcyS2xh?=
 =?utf-8?B?cWNMQlJ2MWI2YmJYYWFwNmU5dE5rY2FQaE45cjdNTm9BbkdZMndwN3BaRVRR?=
 =?utf-8?B?Z090ZGtyY3NFZVNyR2xwcFFQdU05SnJGSm8xZ2VzUnRmVFFoenpEdXMwcHJK?=
 =?utf-8?B?Ni9SbUNEWklJQ2hHZFdGWld6d2hybnR6VWFKUmZ3U0dsaXFBSDRuZTJNUjR2?=
 =?utf-8?B?RWptVlZUMVp3aU0xd0V6VmdCakJmOVNWUk5TeXUvVEVoVDFZQVROdUF1QUg1?=
 =?utf-8?B?U3FOS3hpb2FxVThrazZUUmdnU1o1Vm9aTEd4NW9XRmkrL2xjR1U2ajJ6TDlh?=
 =?utf-8?B?UW9VNkJxait4S2h3cHRheVRXSHJkN0hkeUVxZTJpaFNXRklQb1QzcGIyeUxJ?=
 =?utf-8?B?V3V5TFk1dTY1aTRURGpoQ2s5eTJ6Q0k5UDhsTnhaNDROdHdScWhBK05UdDkx?=
 =?utf-8?B?QXd3bmdSK3B0Vis1cVlacHo1Sk93cERSeUcwZktUeE82OEpxWWFkUm93d3Ru?=
 =?utf-8?B?Qml6UGxOWTduUytESGpvOUgxV1V1MFlQalN4cnVIcE1rUzhlVFpERGVEbDI2?=
 =?utf-8?B?c0NPRGdZMWdJSVc5UUwvaXhrdm5BSXlvcmhuM1FEWC9OUFk1aGUxTHdKOFp4?=
 =?utf-8?B?RXQxVDZzeUlUcUUyK0lXdXFVSG5tcjBBb2ZHa1F1OVdxdHJMZFU0OGtkK1Yx?=
 =?utf-8?B?WUpMNUFnTENTZlVCU3JjVFhUQmR2RTM5b1oxMW9ON25KemQrSVczYjdKNGFE?=
 =?utf-8?Q?IujKRFPRXK+zxdrLCknF2Fhk/hN8ekkHWMSDo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGVHNmdjMjJQY3ZFQ0dUUTBHdjR2YXBNUy9kOGJPUldBclRoTzM2aG5SaWxn?=
 =?utf-8?B?eUVRYjc3M08zaEhwMlQzVGpLQnAxOUhtQnBWdzd6Tkl2WjRxL1V2YTlTRFVz?=
 =?utf-8?B?L0xOL2s2NHI3WGFIR2ZZdkFXRkk3SE9KRE5YbW5BV3FRNGZucHpTdFFtdDJk?=
 =?utf-8?B?M2JvZVJTQWVTMUpJZkhVaWlYMW4vVXBEM1BLZmhMUEFMa2JSbkQ0bFhkcE9m?=
 =?utf-8?B?WEpBMENIRUxFQ201ZkduT0RkUUd5eVp2ZldONkdTOTg3NThtQnFwRllodlly?=
 =?utf-8?B?eTgxLzFyZDFrMEFURnhDQlM5RjVLQnY0WjF1cy8xUmRPeVlXY1VGblhjRXNJ?=
 =?utf-8?B?VjRmSE9SeVlvejJ4dmtWMlZzbTUzUUhUZGppUlJUZHFuU1dtSDhpalFNQlVi?=
 =?utf-8?B?NHBQbkh4QXI3K3Nmclg0VEI3MFlVN3NFeHZNRFdBNmdGVFIzalZjRGJWM0NO?=
 =?utf-8?B?c3RMRjZiTGtvaWpoaTYyS204djlDOGl2ZVljVm1pYzNCOC9GUmtGc3RKejI4?=
 =?utf-8?B?SWRwMGxmYlcyQlV4MkNLbmFmVTM0bkdiVDhOb0d2Nnlnbms0dWExd2FxbjlM?=
 =?utf-8?B?NC9OaFY2Z3Z6TWh6UDFZSkVjQmpudEE1Q2Y3d2hqdjZpdHRud1laK25GVEt5?=
 =?utf-8?B?amw5SUdkU2xxbmtDSTdiVy9EUXJzZmpVbHY3QUxlVnplZVJtWWNrUDFZNThm?=
 =?utf-8?B?YjVXNXFUbHMvdU9FSXZ3RGlUb1hpMzV5UWgrKzd4N0ExKzU2eUhBdTNmUDRI?=
 =?utf-8?B?cFVmUFNOQ1hoS0pyaUE0a0dZK29mRHQzWWxUdHA4OEVkVTRiei9QNit4N1U3?=
 =?utf-8?B?c0YzNk80ZWREM2VHc1dsc0p5NEdFS2RKR1doT1N5R2RuSEs5c0xSazkyb0FY?=
 =?utf-8?B?Q1ZvRFdTZUpLWDdVWVY4T2VRNVZ6c3BIdVRQQzV2V2lCQXl2MGphMkJGblVH?=
 =?utf-8?B?UmhvK05rK1JrOCtUUjJkUDhRdy81TG1JVC84SCtaaVJtMXovWWNhWWtENnMy?=
 =?utf-8?B?bkFhMWNoZjFzTU5kaW00WTEwN1FSbFRvZHh0MUtYQTRHeFV6b2dsMUExcFIz?=
 =?utf-8?B?c1Bob3JjMlc2TksxeUhkazVuU013M2hOMlNkanZMaGhKazFCbTRDajJzNUpY?=
 =?utf-8?B?Z2xhQ1RmeFRmYlB4SXFQOFRqYm1iNitscXlaVHFGRGl6SXBESHNDMUJtN0Fx?=
 =?utf-8?B?SnhKK0xrbWFzQ0RpOHhmdFV3OVFMM2FNVzFmK3RyOXVYaEFucTZSUmJtaStt?=
 =?utf-8?B?VG9OL1QxTk4zM1IxR2EvZzdvcWRCN0R6eTZkb3YvdzZNYWxGSXFobmZGRnNI?=
 =?utf-8?B?dlBESlNKQXR5VUZxTmZodk1rVVFhRDExWlFhakVjaURySFlnODJIT01jbFFN?=
 =?utf-8?B?VmdVaXlqYk16eEhuZU1Ka3VjTktlQ014eXVZTkVxdHVpTkZXWTZzVHEzMFEy?=
 =?utf-8?B?ZHNjUmxVR3FXenk0dnJZS0dKd2RMc1oxSUl4Z295YnJRWXM2c3R2d1dCcnlv?=
 =?utf-8?B?UXhkN01FQUpjNklYT1d6V0dKeDFZcVNjTU1xNHQzSXoxNm13azJMOFl0OHgv?=
 =?utf-8?B?OFRuQTd1RWJSRkJKRmFMS21rYjkzQ29KWTdFQTloSjFYNWx3dUFvM1Y5cHF2?=
 =?utf-8?B?Zit6MWtQeTdBdmpUUEZFbnJYZmx2cWVBb1Ftdzh5Ym00UkpNUUkyUng3M2hr?=
 =?utf-8?B?NVZwVUtvemFUOTRSUXZwdksvb1BMc2Y5dUN4d0h5cE5qUXBSREt6OGdoM3Bm?=
 =?utf-8?B?Uk85bXBVM3kvOG4zTDhObUN6bTY3MjlWYUE0bnpkbTl0UU1uSG56RzhKNHNq?=
 =?utf-8?B?akM5WEFXVGlKMWllOTVha043TXlqQVJJZmc0RGZKZnNwckFFODYwK0pLQVZ1?=
 =?utf-8?B?aXFxYWw4TThCUjd1ck9XdlBPbjhMYjRFQ0k1TG1ubzRGOU5QajV6QktpU3M0?=
 =?utf-8?B?dXFQWGo1a2RCQVpwTkJZZmppeWhvUGhDQVJNT1ZSVHFKb0lIdWIzVDR0RzFY?=
 =?utf-8?B?ZE9VOHlJakcwa1FxaDh1K2xNS3YxQjJ6NEZ3MEdGaGtra0krV003VzR2YXpu?=
 =?utf-8?B?bHJxR254TUV2ejlRVzBDU2R0T0NwbWc4RktsRG9tZjRqREtFeWlPSE1iNVdV?=
 =?utf-8?Q?8yC0UwZojzcqXcDlOICyrt/Aj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ced95e5-2737-4c82-740b-08dd7b481bb2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 11:32:59.0773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uJQiDyX95HNsaDAwDSMWFtczwjssq6rDdfnVnwRgcksr33VEhjPVy5CpqMHTc3n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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

Am 12.04.25 um 10:03 schrieb Arunpravin Paneer Selvam:
> Add queue id support to the user queue wait IOCTL
> drm_amdgpu_userq_wait structure.
>
> This is required to retrieve the wait user queue and maintain
> the fence driver references in it so that the user queue in
> the same context releases their reference to the fence drivers
> at some point before queue destruction.
>
> Otherwise, we would gather those references until we
> don't have any more space left and crash.
>
> v2: Modify the UAPI comment as per the mesa and libdrm UAPI comment.
>
> Libdrm MR: https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/408
> Mesa MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/34493
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 20 +++++++++++--------
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  1 -
>  include/uapi/drm/amdgpu_drm.h                 |  6 ++++++
>  4 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index a4953d668972..83bb2737c92e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -97,7 +97,6 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>  	spin_lock_init(&fence_drv->fence_list_lock);
>  
>  	fence_drv->adev = adev;
> -	fence_drv->fence_drv_xa_ptr = &userq->fence_drv_xa;
>  	fence_drv->context = dma_fence_context_alloc(1);
>  	get_task_comm(fence_drv->timeline_name, current);
>  
> @@ -591,6 +590,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  	u32 num_syncobj, num_read_bo_handles, num_write_bo_handles;
>  	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>  	struct drm_amdgpu_userq_wait *wait_info = data;
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
> +	struct amdgpu_usermode_queue *waitq;
>  	struct drm_gem_object **gobj_write;
>  	struct drm_gem_object **gobj_read;
>  	struct dma_fence **fences = NULL;
> @@ -840,6 +842,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  			fences[num_fences++] = fence;
>  		}
>  
> +		waitq = idr_find(&userq_mgr->userq_idr, wait_info->waitq_id);
> +		if (!waitq)
> +			goto free_fences;
> +
>  		for (i = 0, cnt = 0; i < num_fences; i++) {
>  			struct amdgpu_userq_fence_driver *fence_drv;
>  			struct amdgpu_userq_fence *userq_fence;
> @@ -868,14 +874,12 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  			 * Otherwise, we would gather those references until we don't
>  			 * have any more space left and crash.
>  			 */
> -			if (fence_drv->fence_drv_xa_ptr) {
> -				r = xa_alloc(fence_drv->fence_drv_xa_ptr, &index, fence_drv,
> -					     xa_limit_32b, GFP_KERNEL);
> -				if (r)
> -					goto free_fences;
> +			r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
> +				     xa_limit_32b, GFP_KERNEL);
> +			if (r)
> +				goto free_fences;
>  
> -				amdgpu_userq_fence_driver_get(fence_drv);
> -			}
> +			amdgpu_userq_fence_driver_get(fence_drv);
>  
>  			/* Store drm syncobj's gpu va address and value */
>  			fence_info[cnt].va = fence_drv->va;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> index f0a91cc02880..d5090a6bcdde 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> @@ -55,7 +55,6 @@ struct amdgpu_userq_fence_driver {
>  	spinlock_t fence_list_lock;
>  	struct list_head fences;
>  	struct amdgpu_device *adev;
> -	struct xarray *fence_drv_xa_ptr;
>  	char timeline_name[TASK_COMM_LEN];
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index ecd49cf15b2a..7c754ba56cff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -73,7 +73,6 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>  	}
>  
>  	uq_funcs->mqd_destroy(uq_mgr, queue);
> -	queue->fence_drv->fence_drv_xa_ptr = NULL;
>  	amdgpu_userq_fence_driver_free(queue);
>  	idr_remove(&uq_mgr->userq_idr, queue_id);
>  	kfree(queue);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index ef97c0d78b8a..2195810ae42d 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -501,6 +501,12 @@ struct drm_amdgpu_userq_fence_info {
>  };
>  
>  struct drm_amdgpu_userq_wait {
> +	/**
> +	 * @waitq_id: Queue handle used by the userq wait IOCTL to retrieve the
> +	 * wait queue and maintain the fence driver references in it.
> +	 */
> +	__u32	waitq_id;
> +	__u32	pad;
>  	/**
>  	 * @syncobj_handles: The list of syncobj handles submitted by the user queue
>  	 * job to get the va/value pairs.

