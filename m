Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15BF1067023
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 14:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E6E10EA18;
	Thu, 12 Mar 2026 14:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BEfIc+nT";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011060.outbound.protection.outlook.com
 [40.93.194.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F12310EA18
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 14:03:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9t++ub0ByTK2vDLk/DL1oUqy3556Rlm9mow5ebmLdMfvewEm6kXBnGIh8rxsvR3BdSNJwZreLC6e3wV7/+wZ1iCwKEnufJdZLtfKqvvF4J3JOweuogyl3tCxtDl/YtV9vk43wxPszKG+ctsTE2g/CKDCGsu5WVNVmzKGy8/jP48m+ohepxRVm9ztHtiRoSd3/d9rtNd3omnlZrRCoaFn4AqhLdKsgxAGwx7jNrnxUwDonzE9YHNRB0dsBzTEnNchizCADl67wCpEGCh5pvBSLfAxLXAqtikrny8fyfLYjZ4d1jwGSUiXra4ThXsfqdJnkn3rG+KR1nhIBZbxh2UOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnLwHQ9sWAO14PTFnvUju6VJ6JBf5DPPsSK9aebZMHM=;
 b=TGaviitZazH7RLix2Sa4U8xsTXRKJoJlXhVKePhUJzp//9Z+Q0axM261zqjCvlkYhscd1BB4tdzza7Wp+6bznPJagSDQYOYeFV8AuqjfohzLaYEqD1aRgmx0wDlqEd0VzK3rbrcTXwP5mQS+/Hplc2HL4L/udbwsB321669LwMM4eY5IuEDVhhmTHslep0zIlzHiT6F2Br3s8xmziN7d+saxEcBN+jzBRZJtwSPjXnpH1BFgE4CbvKwg8OGYZQCHq2ZuWidMu5rwiXv87WwOOpM4uahAHbW07txlNlBG/S8ZFeJc7LMk8xxf+rzLJHmiOoQIQCC/srCzsV+v6HZsfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnLwHQ9sWAO14PTFnvUju6VJ6JBf5DPPsSK9aebZMHM=;
 b=BEfIc+nTL2IO6mJaLbJwq3ePDK+TBk58dZAMyl6MeViWqk/mu+nQERHTZdYOGVV/2wT2lV1hc5qWlnOlGbN37Z73fsN8TTkCixa/B8dh3dqnBw4HW0V5U43UbxslVe4zAtgENLaf/b4lY04TDgA62a5s52JOfDyWfKKru6EqI0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB9737.namprd12.prod.outlook.com (2603:10b6:208:465::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 14:03:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 14:03:42 +0000
Message-ID: <a10eead2-24a4-4974-950c-a9cbf2f1b135@amd.com>
Date: Thu, 12 Mar 2026 15:03:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Make amdgpu_dma_buf_attach() return paths
 consistent
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20260312134415.1839742-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260312134415.1839742-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:408:ee::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB9737:EE_
X-MS-Office365-Filtering-Correlation-Id: fecae8c5-e42e-49d7-6386-08de80402adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: tjlst5ckxxtUM9CXYHT4NEWE8cwvWQ3UlcKwU1qR7ftPdgk1zqEnXifUWh+vaD7FCniQZ+Qxhgw+6ppI0ZbpvtD8oZuHggSdfGyo2gIGRCUmxssB3rOjBbcuZCoIy0qFzqe8lNpdyloi5CKwVxl4VtCuqd/N5Y4TZ11twfL9yvvLzi7TTjyNRIdzYbdhY0wd2TcHkBKRwvzmMHau1tw6x7owAb/SjoqtDBryKbj+eoUbbMf1ApP40kWweIFsHgpKitrw+bdgk90xp+cWeq73tOB4xF3btYT2t//2mPGymACH+4O+MVHqGmCRZMZNdnRkQqhyXGtHR0ZAsSdb7UwyhQguKAf7oQsZryRt5CLqjYE9Wn3zc2pZTY9B/t5TUzLHQRPVicWe+n3D4avzxa5OvIHZrVghwl3ZFYibrDSFWu67pTKlHVPwx2SiGQuFyi0QD80mPZLiNX5J4bBDJv94kZM9aB4Sh2GEp9m0nzDh2nQiBQxUSM4guCGUtbR5a3tuFB3Mu7SMx9V5PxJ3SF03Nv69lX8fLE9Q0IuZJo1KdjPUjbV7fWXcNhgsj+4fuD+4YWMtPeJaNIIzrYgfZLq9XM8vtC4FD1PzbjIuypZ0PijZPMegPkjmTf7wHzL9u20mfeysdTO/UFM6juOCvAmlR9aiqj/aLXG99cUKLRDpdcDWYW8SbsGZJkwLLb8hkGZc0juHKiV1ifhZ2j+s0je5iyrXqqtNWvSEFlRiVtD0vQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmdpdEErV2tSRmdwWlBnU2g5Y3Q0bWxHcHBobEdEakl3VmlPeWpCYW1jakVO?=
 =?utf-8?B?L3EwOGlmamlFZDdrMGZ3eWxuMWR2MVZmcGVubU1CRVU5TVNCUDNMOUJnb1Y3?=
 =?utf-8?B?WXdsV2V6UGtUL2xITGx5dWdCM1lmdjFLZTNXSkJ1cDNzNTFPUVMxM0V6K3d6?=
 =?utf-8?B?RlpkOW9XZThkOUs1blRQZmtXeHM1dTFjZ1pyTkpUWGlqMHllYWN1a2xkL0Nj?=
 =?utf-8?B?N29vclYxTUFVK1NaL0F2YnhsdGtRTUNwUWd1eU8rM3J0a2tSZ09Jb29PKy8v?=
 =?utf-8?B?bVdSc3BpOXQvcjVKcnEveFhZNmdHVzJiL2k4Uk43MFhPWHV4TEtGczFDSnFx?=
 =?utf-8?B?MlFhQlo1TVpCTXpPcFVsb1MwRnRpQ3FwUDlrZTMxa1h4Y2VWTzBhV0l6QW0w?=
 =?utf-8?B?VVRzNU9BbGN6RGFOaVVXM2RIdHprWHJQR3loQlJsUW85cXBobjBsRnZmSHUv?=
 =?utf-8?B?Q2QvWjBmRU4wOU9RYkJhNmRKRklVTEhKYUkzMFgzdENvMEFMenV0N1FEUm1m?=
 =?utf-8?B?YjFBSFp5M2NXR291Z1RJZXFnNVE0ckd2b1A5cXh3UGsvOXF1SXFwQ3htd2Y0?=
 =?utf-8?B?QnpDdERnZ0xwczkxN3VVUlFxK3A3Wkp4Z3VlcU94M05TY01TeE5rWnZHNUJY?=
 =?utf-8?B?cCtScWdsSlJSU0dPdkkwTHZCRGtvS01hZjEzTGwwZ2xTY3JaTEVCdVViTUM0?=
 =?utf-8?B?RFBKQldnVmdtZkFDQjRKazdxYU92Y25mMzF5a1NwckYvSGVlMUlPZFdFak5z?=
 =?utf-8?B?SXpNaC8raDVUZUQvcGdVRXdySTUvK2YvN3dYeCt6Vi9aYzFYR1lKUVd0c28w?=
 =?utf-8?B?NGZmS2h5S0I4UmNRWDlaeWlJSFpQNFZRZm5uWnBGb2dMMyt3Tll1Sml5NDBu?=
 =?utf-8?B?aUxxcCtPZGRXZVBrWENidzJ1Um1sQnRFMWY1MmlTTmludFJnbmxjSDNDek9W?=
 =?utf-8?B?cFJONTRXZTF2UGtTVWRadnYvRWNBUkIxQUlEMXA0dDJlSW50Qk5VbXdrVEkw?=
 =?utf-8?B?REU4cEJSbnY3Vm5yMk1lOG1ROEp4eW5OdUdxM0ZTNUVrMmpob3NEZ3BraWlz?=
 =?utf-8?B?eWlsOVNDYXc0dkpvYnNKL252MU5BWnpTbENLUHBUbC8yV21mUFZJSkZVNlV1?=
 =?utf-8?B?K1daMTJacXBIUXQvODJlSWM3UmtuczJ0dFF1TzBoMXBvU2xrYXNxWFcvSkl6?=
 =?utf-8?B?YWhMaHdmbjR2bkhMNUw1VVprcXREODZsK0tPT3VZbTlIdjdSRXZqR2tUeFZK?=
 =?utf-8?B?YnFtWmJJakIyRXJYN2J5VGU2eHpuSWlsU3o3OTIyQU9qdVp2RE9QOW01WWRu?=
 =?utf-8?B?WGpzNmRVYWVSdTNwQ05yemhPVHY3Ky9rcnVLY1k1WFN0VWZCdnVxYmNaVG5U?=
 =?utf-8?B?WDZDcVJRUENGWlZTcEV4M3A5bzBYSWtXM0k2V2d6UHhYODlnSlFnaXlXWEpm?=
 =?utf-8?B?UVRQMndiSU80SFUvZFNneDhodzlmOVBEelZrMXhTZWhUM2F4VzFwTmxqRG15?=
 =?utf-8?B?QTR2MnZaOUNvT1BzVnBkWmRIRFlpQjdsS1VSL0JUbTJMc1VjWG1ZT1RNOXBG?=
 =?utf-8?B?TmVZdW5sNFZ6QnJBSnc4NmZPUDZVVUN4V1J0b3ZxbzRCbjBmT0V6Tjhjajh5?=
 =?utf-8?B?OEtjcEQrYWFaVEppNlZDcmNIS0RnekRyWXpkOHBXNExYWHRBSE82ZWxiTjlS?=
 =?utf-8?B?R0t2dzdYeFhqcjJSdUdRemhsUGpwT1N1dmVoemVWOVcwQ2k2eUw3YXgvbjlD?=
 =?utf-8?B?YldEZDlrR3BMZXpaSC9ESGl2cTZSdnVXclR3d1M1cFlJcWlPMDR4N08xcmph?=
 =?utf-8?B?Tk91ZUlsa1lEcm85YWRaWERFZU4vRFJ6VnFXZkVHRXVoOVptNktkdW90NFVS?=
 =?utf-8?B?Uk9VL3h3MHIzRFh5bjBwVW81RXdTS1ZheFQvS0VHU3IzeE1idlNDbFBNd0Jh?=
 =?utf-8?B?SUh6S1hSMEd4Z3hHWDJjYzdaNTNVbEk1VlVaUi81aXlva3VIK3Z6ajZnczJU?=
 =?utf-8?B?ODU4QVFyVVVMRjBJK2dHVTlDbkhkNTdKV25LN1h3UXpFYW5RYWV5TDRVc3ZC?=
 =?utf-8?B?ZkRkdFpaQjlIZ3JVVTF0REs1aXgxYSs0V0ViMU56bTRwVjY0ZjZkenZaSUFi?=
 =?utf-8?B?L3BwM1VRU2p6QUxrcUtqNTM2TFZsNXY1RlM3NmRsVHlxTUgzS2F2RGZpMWox?=
 =?utf-8?B?RzY4UURBRnFqejljVXN5YnNTSU1UY0drdEU4Qm9RT3ZDUmo3KzIxZElNSkpl?=
 =?utf-8?B?UTluNkVpcDFMZ0REc0FOODdCS0k5SGJyNG5DUTcraFNyZEZxeFpMbVVFdDkw?=
 =?utf-8?Q?XCl0SpplmNJBbIR8jY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fecae8c5-e42e-49d7-6386-08de80402adf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:03:42.0624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQ+8qt1l6ievARh/vxCVxkwlH38u32IjjV7XChVkJJcivniW0b01dIUWusZWlTmi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9737
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

On 3/12/26 14:44, Srinivasan Shanmugam wrote:
> amdgpu_dma_buf_attach() locks bo->tbo.base.resv before updating the BO
> sharing state and unlocks it before returning.
> 
> Return the local status variable after the unlock so the function has a
> single consistent success return path, which avoids the Smatch warning
> about inconsistent reservation lock handling.

Mhm, that doesn't looks correct to me.

> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:111 amdgpu_dma_buf_attach() warn: inconsistent returns 'bo->tbo.base.resv'.

As far as I can see neither that warning nor the fact that returning the error (which is always 0 at that point) would fix it makes sense to me.

What exactly is going on here?

Regards,
Christian.

> 
> Fixes: 6e6db2722c28 ("drm/amdgpu: add independent DMA-buf export v8")
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 656c267dbe58..9cf240ad5471 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -108,7 +108,7 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
>  
>  	dma_resv_unlock(bo->tbo.base.resv);
>  
> -	return 0;
> +	return r;
>  }
>  
>  /**

