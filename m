Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E57CC369A2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 17:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D0510E0AD;
	Fri, 11 Apr 2025 17:19:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tg1pdXdq";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 468E210E0AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 17:19:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rec9EpzIwllck877lYpN9pfQw29/0BHcR6kCfYx5c8qyEdKgG7t14AystsdrDiMi8x8c7t9UpCnuVuxlbVWzxr8kHVkq3aUd4smbyNHux/Hns/8I/c0cYW9hKFaQtLg2P1szz8fmFvdd5c6/35ZtOBN7ZS5ZYySTW8LrFWBH0uQfTnlXJ9n2W4GEGXhIV4nw3Fk+V8bQcfRMdEGxrskhbIep7PZEM65vyTqcOsgbEY9z4mMOhpoPNVZxZrcai49Lq8euu6b+Tniex6VCcaA12RNuOBGzoi4u6yhNcqHC5mwSoYX5Q++k1VuyFNeDgY9eXfFq+K5rfPyBqDWgHrM8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIVsjLCnTiMrIX5J4m9KaxJAjpSMOo+LRkXCh44QR38=;
 b=lm0s2kB3SllokVDsaJnKqNohH/wz9HpygKtqwepVdm1KL21atgSrYPpGPMb5PWWvZ8HAANPe7OBGlPIgb6GehKK+6Xamzg4s3JJ46tGULI6Md7ndP6uv6mZ4Y/1sbdyGFaRO0vJR9FUskvm+6UkcK93OnNP+bI/H+A9+isuMM/FSNKY2K09nWBLk10y3VVzrG31FPrVPDQO8yk0wxjS42y1P3DX8szEnrdxe6JTD+XQgBuA17aVdCVRbDfKHBoJvQ18zfT8PXSrb3hE94SCncwTaQc28ZMkt2biKnQjwyVan6iYf1QH+5qM5ZmwBcAvfjz2T7x7IhdUjmHggLnvE5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIVsjLCnTiMrIX5J4m9KaxJAjpSMOo+LRkXCh44QR38=;
 b=tg1pdXdqqOgtAFCJCXZT29igJzXcTPVVSwA5bL5oo1A0eQFvUAmkEakQ3oxKV3xn0kv2sxT2IIjYDzKeWrA2QUBfhp6AnZZseRxAH4HCZy0xaKHuh29lcpspF/x3wk13nLgKTfc3sAe/sHQ1WnGmNuyta0TwpNClokFIuHAHXS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 17:19:47 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec%3]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 17:19:47 +0000
Message-ID: <d63b04b8-7910-416c-a340-fc6ad162f5c7@amd.com>
Date: Fri, 11 Apr 2025 22:49:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] drm/amdgpu/userq: enable support for secure queues
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
 <20250410185402.2352109-13-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410185402.2352109-13-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0072.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:267::12) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c06ae0-6a6d-4429-34d8-08dd791d0f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkMrcHZqNWFtTGVTWXMvdUJReVllOFBFWU1hL0xuSGs1U2NucFE1d0xNbmM5?=
 =?utf-8?B?M0E2Uk03MURLaXdTOGMwdzQxM25Nd3pWSVdjZ1crS0ZrQTBaYmlPbEZRVGhn?=
 =?utf-8?B?Wm9ENWlHZGFEOGZ1OG1Ua1A1eUxIWi8zNnpaVCtEZi9qNVFwRjZFdmNwUHo0?=
 =?utf-8?B?dElwVkl4c1lxOXUrUUtGYzBGMkk0WS9DWm56ak1ZSTJickF1K0I4Wlp6NC9E?=
 =?utf-8?B?N2R3SWo5bE4xc2hVbkZIaVcrc0hkekV3RjBnQWRoQ0N0cXBVbTNucEhtTlpl?=
 =?utf-8?B?Ym0vMFYvNVFVNHBDSlVGZGFnNEJBdlJ3WkFuRzRnN2k2SktaWTdTejhSZmpP?=
 =?utf-8?B?RXBPMXBUdnhmSnZjQnZkbWVvdk9MZC9wZnl6TVdabHdPalZ1R200a2Y1MkEz?=
 =?utf-8?B?UmlnQjJEOUNFWHQvK1Y5bm4xWG1ORHVwdDI4aGx3R0FtSEliRjhvYVY1OGFU?=
 =?utf-8?B?ZnpYQWJCakNUR3BiTEtGS2xzK2R1STk5QnU2eG1ibWlPNWhUQzhlU25VU1dw?=
 =?utf-8?B?NmljYWFmYTlzRE9lQUtXS1RzaDloNUVseTZQVjJWV3R1czNMRXlnbm84S3hJ?=
 =?utf-8?B?VWEyTXN5Ym83RDBWM2lhT0FJRUhzMnc1UXV6aThxMFJzSVJYWkVaY1FRcWhu?=
 =?utf-8?B?RWdjdXdCeDF1UFRFWlNEdFdMbmlsRk01K3ZvWFkvdkhSNEtZandKQXVVcW5B?=
 =?utf-8?B?czlrYVZnUm1reHZ1aVNKZmd4SXZMa2FURTAxdTdXWGQxdUV3U2NrMmlFZzhh?=
 =?utf-8?B?TEUzdkFLcHNhRGkzc2d6dGlqRnV2ZnNaZ1pLM3lpclFNd3hyS1ZwSC9VUzBR?=
 =?utf-8?B?TXNOdlNKVU85cjRLbUpQOVF4cFdoeTdtcWpJVnllaCtic1FBay84ODRscVJp?=
 =?utf-8?B?ajVOWCtkZWZXaTlacDRoVmIwY1VaL0Z0WFFLNXkyaE50dStYRnhQVnEvMHFK?=
 =?utf-8?B?QmMyVS9CVE5YTkJ0ZFI5RkUwK1lDQXpYVnphVHlvbXJ3akZYN0RVRzZSUklH?=
 =?utf-8?B?YStiT2NhaGpDVUhaY2hXaTdSaDk1TEdkQURQZm01Vlpkb1RYSzJMdXBreWgx?=
 =?utf-8?B?dTBRSXFJUmFQaElFeUNwSjlzeXhiaGFCS3JFN1RPaWdodmpkTkJFSkhPbStj?=
 =?utf-8?B?TUdUcUxSWVpLQ05DSVdWeCtPMDRPNVViQllWRnhIRjN0SUtJbm8zODdsUitM?=
 =?utf-8?B?Y0hqVW9KYTQ3S213YUNiREpmOUx5WnNybEgzbU43VTFudlZTdFpIZjBSM1NW?=
 =?utf-8?B?Z2JYUGlKSU8xcnFsOHEyZkRxNjgvLzliRkxCeGx4R1FESUoveDdHWDFzSm5r?=
 =?utf-8?B?QjdZdlpoanZ1YVVkRjlKR0FUSlNxOENJUEl3V29rYVpDMVBoSFg2eEVrbkpR?=
 =?utf-8?B?SGZuNG03RXRGN3pYTysrV1RzRjNEV1EwN1VubVorWHlMVzRoZXpHM2QybFhm?=
 =?utf-8?B?U0VGU3M5V01kU0dybWYwUmZLRHFXSktDN2syQm1za3dxQ2p5dTV0Q3FQTEFq?=
 =?utf-8?B?dWFLQ2VwSndKZzRSMENHait0aXZpN2dmRTdxSG9nR092a1RoaUZ1UWw5QnJS?=
 =?utf-8?B?dUx6UjAxL3VrQ1ZOdFJFalN5REdoTlhDVUMvOHFDczBta1BhSHpnY29Ick0y?=
 =?utf-8?B?SFpwdVhMMWdRVkczeStZU3FPenVLZWtDU0VBQXdrVVo5OW9KZytSWDNIQzMr?=
 =?utf-8?B?WHRLSnR6TEtLajdSREJHK2F4VW1hUWZ2alRiVS80QkVuQ0hReUVCQmJoWFlh?=
 =?utf-8?B?VjNEQXlDWi9IRVhFWC8vQk5yelBLVmIzRm13cUpqdFFCQkNGSm9ZakcvTWVM?=
 =?utf-8?B?YkJNRzNIUURRSTBCekNPZUlGL3VUc2UwWm94RFI1QkVvZEtWekpTZ01oV2Vk?=
 =?utf-8?B?RmdPbUErOEFPSS91eHBieUJpOGdhbVJuL0V6K1lXOUdIS2tJemxNNjdaUWRt?=
 =?utf-8?Q?o3dpjW51m7I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0hrUmJGTGo4Mnl2a1FnRytmeVc1akhRYlAwVU5mdWhYM3pWc1lpdkpMbVA4?=
 =?utf-8?B?dmFhTGtzOUQwV2M0SG9tNWZ4a0VkbHNUSVhoTHd4WW4vbE41VTFiODh0N0pz?=
 =?utf-8?B?dTdVbklXaVd0VVRBSWkwaFpvcWdjTlZTVmpXcWp2aXlSU2dOMnJCYWNrdDVJ?=
 =?utf-8?B?cGZTaldzdFJaVWFpZ2I5NGxHekg3bEdmM2wyTG9XampZNDdkZGtYNllDR2Vx?=
 =?utf-8?B?Q3ZSamdHZVVCdDdQMm5IWmcyNnR1KzZrU0pTNHpIK1I4d2RnVzhRSk5PRlNE?=
 =?utf-8?B?NHBvOTFLTEMzNTR0YkQzL1pCQzJYdjJrcFNRNDVoTEF3cmdIeG15dTRPN2dr?=
 =?utf-8?B?WkN4U3dlS3Q2aXMyU2c5T3FEckJHZ05uMFFsTFRBVmZka1RpZk95QmlocVg0?=
 =?utf-8?B?QW9NTThSdDdFNGV5V2VXYkxPMUZjN3YyUmw2YngvLy9HNEYwaW55MjlmSTBl?=
 =?utf-8?B?dDdFTzZhTUhDbjdsUjl5Q1NzYWQ0Q0k0emsyL3k5c0hXZXV2RS9GdmpYUTFE?=
 =?utf-8?B?amVhYmFBajZmMWZlVnE3dnNTWHV6bGs4cWJQQjg1cXgzWmR4ZEFzMnFPaG1B?=
 =?utf-8?B?eENEQjRCbEZMSERDa25kaWhhTVA2L3hSR3hqWEJINUszZXh5MXl6empaRlpF?=
 =?utf-8?B?eHZ3ZVFhTzRXWFMzY2p2bWphWCtPcm5Ma3dicHZOUVVIbVJ5S05XbmRRM1RK?=
 =?utf-8?B?M1lZSFJsUC91aEN6ZFRnZHZwb201NVNBSWtGNTJxWXkzeU9CZ2QrT1RPOHV6?=
 =?utf-8?B?VjM4L1BzUkZBcTkzTnNScWpiTGFqOU5abGxrcW9UejlRTDRFZXM2ZitBUFJ5?=
 =?utf-8?B?cWxMbXUxTlZNSzU2WWZ3NkRrNGNzQ1hWWUtOUG1BSVV0Rkx4TThYT20xL09a?=
 =?utf-8?B?NjkrL1NiNC9iQ0ErTHdWc0QrdTA5YzJjZEhTeENEMkxBbDUyc2N6ajZkQ253?=
 =?utf-8?B?NzVDdE1Vb3hxU1MySkJIYVRCQno2Q2dZdW9tVTNNWUxRV3d1NWhBZDBSK3o1?=
 =?utf-8?B?dU5YKzhCWjhqSWNUN3FZejVtVldnM09iTG5qM3ZQeUtsZ3U4UklwOVlpKzl5?=
 =?utf-8?B?RjdoQ1N3NUhuNnJES1pxeWs5SHJydkZJckl4azFlQWZ4K3UxLytVZDl3Y1Nj?=
 =?utf-8?B?OGxTZFhONkgxUVptUkdGY1dJSjN6aTZqYUtyQmx5eFViVk5abXJxaUxlVzg0?=
 =?utf-8?B?MHFrY29TU0FacENyTUh1UzMwQ3ZlVkd1S21sRTZYMmJlcmNzRXRoS2hycFc3?=
 =?utf-8?B?U0t3Uk1NS0JPMGNaWHZhLzV1bE5JT3hiUTdTa3FZeUZQTUQyZDdrOXNTTnRE?=
 =?utf-8?B?eDBWQi9IWWdOcFNKRUJVWERoYXFyOGE3WlNsQjBUUVM0MFhvUTU4SStCSDRa?=
 =?utf-8?B?RFpySVFHcVVCd1NkL1FYd0xMVk4ycHY0Z2hoNCs3ZzcwalNwUGFINUZaRU92?=
 =?utf-8?B?R1dPRzdqMkIrTmZpRFNwc0VreUcrRXF5U1d3UGFOK3UzWEh2SmZSd1RGMitx?=
 =?utf-8?B?MWoxY2lWZVlPYndVWEUyL2JyMHpvczdPVkVPeVBhbW9rMmFwdFBTYTcvUzZO?=
 =?utf-8?B?cXdvRUdlWGhkQmF5cDRVMGVicUNaMFVvL05GU2VPTjZnR1V4Wm14b093cDVz?=
 =?utf-8?B?dVRaUE5HT2pRcys3N3FmeGNrZVFkTWFWUHBYQ3FTOE5SVm1UcFUzR0NsT2I3?=
 =?utf-8?B?SmtUdTQrR2dRek1vaXdyUUpJTDB5UkxwREhIU0FuY0NXKzQ0REkzaktZUDZC?=
 =?utf-8?B?SFJCSEdwcGszclUxTmdyajNjcE9iTm9ma0hicjlYL1BmaUk2ZEh4cXN3REx0?=
 =?utf-8?B?QnBnMWRLNXdEWDdGQmFZZThIN0xhN1gxV2FXakFPalRqaUQvdm4xUGFkVmla?=
 =?utf-8?B?UWx3MEFDL2RXL3U4Slp1Mm40d285ZGZ3MDlmbjFlSDhrdnBrMXNMeDdMbnkv?=
 =?utf-8?B?WWI5NWIrbU0xRzJ4ZTVFMEpwUk04SHFhcGIvaDVZc3RCaUdQQm1Raytyb2RG?=
 =?utf-8?B?L0U5aHhBZXdTUTZZc2xwdWpVQVlyTmZXYi9BZW5oYUgzb3paaVgrbUhHcXZo?=
 =?utf-8?B?dWFJNjZzTzRRSFkzcVZnMVphZHJZblVwY1BDRjl5VG5xNE03T1NaV1ZTTkRI?=
 =?utf-8?Q?v17I9+B7YHFSGHPqlFXtdP43K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c06ae0-6a6d-4429-34d8-08dd791d0f42
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 17:19:47.6656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8tl89zRULa2qemAzMQWDyY1JMKk1bD7ytEuBs2G8B27hvpJ6PjZxnvDZy+5jHK2Zq93uVFitkfJ8mx9l+yccA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/11/2025 12:24 AM, Alex Deucher wrote:
> Enable users to create secure GFX/compute queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index b8b13b6ab4631..cd279f8164158 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -303,6 +303,14 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	if (r)
>   		return r;
>   
> +	if ((args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE) &&
> +	    (args->in.ip_type != AMDGPU_HW_IP_GFX) &&
> +	    (args->in.ip_type != AMDGPU_HW_IP_COMPUTE) &&
> +	    !amdgpu_is_tmz(adev)) {
> +		drm_err(adev_to_drm(adev), "Secure only supported on GFX/Compute queues\n");
> +		return -EINVAL;
> +	}
> +
>   	/*
>   	 * There could be a situation that we are creating a new queue while
>   	 * the other queues under this UQ_mgr are suspended. So if there is any
> @@ -401,7 +409,8 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   
>   	switch (args->in.op) {
>   	case AMDGPU_USERQ_OP_CREATE:
> -		if (args->in.flags & ~AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK)
> +		if (args->in.flags & ~(AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK |
> +				       AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE))
>   			return -EINVAL;
>   		r = amdgpu_userqueue_create(filp, args);
>   		if (r)
