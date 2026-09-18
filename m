Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03043C982D8
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 13:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BB2B10E0DF;
	Fri, 18 Sep 2026 13:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3WnUZlLr";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013070.outbound.protection.outlook.com
 [40.93.196.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DBF510E0DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 13:08:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2tqIfUO/0/BKXVqx47nK/55tkmSBNwK3lTnjRTOxwunao81/VZOnL1KFRVcXfQoDvKnDKPw+oaFMA6ht0mhVlJFq4rcp0zrrNINamqGS19InWlu27Sey3nvYNNqn5iO4V7RdNI8+8D2tjhcwXGs1/ZCFlhnehd3jfHg1FPH0jX3vsL77Q0dGXXPSsh4VrIyifACPzp5+wculNBDnH+Drn9JNBUThhIbrWj4SULX1IQDnAbA1HBGllrRuVM3QL+fD51L0v3pj62gevXw3Obj8W3VlcfYhjXuy+mNGfjmKPkZULdVABkRZuB1Hewo9RhpAkYvsRhJniN8OmwHhRsXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8L5FF+KU6ST6Z9HBdpd09o/66NeUwGKc2Uy7ZQdSzfg=;
 b=DZCQFT3aIN2Dc+e/AGii4ul348/sBrH8V3vRPRXioOiGCwFtB4rVLHjun7Cc5+03qBfJJmvFskzR1DUJueftPTWf3UADv3UewankJi2fcVo2X4uYO+lGe+zdfB2AkIYwkklsXCXT4fHvDc3ccwxzUBpAk+4mpnZEkJUqYqkjjHRvl2UygDh6iWN5Zp3+l+nvjuHT3klQ8v1eiSKSQyzOsNJtaUEUWhYUPPlbwolRQ4yxI6Jfjh5GxOO5ft42pFEDhv5z3Tk/EK47GSWpn1Au3Lxs1Wk+ybKzwqOo05k3HqT5Bm1TVNw3KZyqXU7pV83CN14KWVML9Hof2ZjRdgawtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8L5FF+KU6ST6Z9HBdpd09o/66NeUwGKc2Uy7ZQdSzfg=;
 b=3WnUZlLrRd3lbNH1JFlm0/ueO3OpaIhE9rfSubr4oDZAsaPMTdaibY9q89k/YBvsehFR4qfTjI393+azHma3HEwk0vhR6C3tS+Oyw6/BDb4J8eTxnsQ1s3ey8l4XFdw01qwy/oxrJemvjC/zXpQMOuFUjyuB/vIPGyctQJUPu9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 13:08:39 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 13:08:39 +0000
Message-ID: <474139b2-c3c2-4d2b-81d7-e209231870f2@amd.com>
Date: Fri, 18 Sep 2026 18:38:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] drm/amdgpu: More compact VCN IB emission
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
References: <20260918120518.96922-1-tvrtko.ursulin@igalia.com>
 <20260918120518.96922-2-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260918120518.96922-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0047.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH2PR12MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: 3daab986-b6d6-4ccb-ba74-08df1585f4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|56012099006|4143699003|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: cGcG3oz72YGXiB373xwQqO+h1nvmkdLAd8OQj1HpwoKLuhW0vbzYvGrWTCpa0LNQQ4eBkSg1awRahSuqhcqEY7UBxaSnXGr/fBsh7/LQMJAqt/27diIeiqXNmp9LJU0CcKPHr24kjFvmFFqHFFQD48wPpwT4cwedmYRu4pIBMKnRgNkYwMlmhd0/Mb74u44+A16Fr+8Val1KlyNPaiUQPPL3BvEUM2OXFxgXBUkHCdue+QxpB9OR//iZPmU4x8DD2m7jWbVYec1UdbJMH8Xu4ivTf4KFJmQue19xnZLVejxzgzojU0ABVQ7sd6qtgw9WnLtmaKIYnpF3LQaOaSEmmc1+5VsM1Mc9Qz7/r7+iUJcsjVYks6tagSS2HukpTLrqlSJd/wSxHvpc6G9BESGR/Pz58qdVwXzb/BAKfkfC08pzyY9b0yrKmyMk4RbP9+JXywWdBSokSmbVBtfs4FrN0KuwxphkQy96s6Rd/B6J/I3PsUG1jDZtolm2QJyycL71K1tmqeheZW5m4N0nc17rbJZ7CoqysGf2cJrRn3pTbsQLRCJjCclYz9mYnvIIz5gPCJlu1z4cTmcnEFjkw7QVnPLmwSMHfSyPjs+mvDQ7u/KhSg+Pdc+5ngVxcIrPt2Oe/DNmV4uDQz/8VNyNd6Hr9wSqlaBaHB4/UKM8I5+XAg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVg1aFNrZm11UHdNV2d5MnNXUllVbDlxS2pBTnpHaFlPUlJtejlNeWpvMEZv?=
 =?utf-8?B?YllBT1h5UkVnMGxxRDRHZGM2NHBvR09lZVB6cGxPb3dYUitlNDJld0FTY0x1?=
 =?utf-8?B?STM2R0tnenRZSlo3dCtJdmdZQXh4R29NNG1xdjdPWHoyeFk2VlZ2T2Y1N0Ru?=
 =?utf-8?B?R1E4YTZJSkpESnRqbkFKMjY0MmFvWmJTT1l0czJ1TkhaS01ZSCs0QmdnOGdm?=
 =?utf-8?B?NTNnY0ZJcnV5RHFBTGVVTXVwS21IZWMxdTR6b0oxcFRLQ3dTaVgvYVoyNlNO?=
 =?utf-8?B?clg1VVFQVTh3c09uQ0ZaVUVEMVhjaG1NbDJwblVwWmw2czJIb1JyOGsrY3hs?=
 =?utf-8?B?aVRhMmpWbXgwWi9oWHVhNVdUeDBmYVJtMWdGQUR3UDUwZmdGWlplc3Z1Snc2?=
 =?utf-8?B?c1JZWlF3Y0o3U0xqVmtNUW5raTVacjIwNjFGbThwYjFySUR3K0VGY0JGVmRa?=
 =?utf-8?B?OXgyR3pmNkR5bnhOVzYrVUNSemVoUFN0K0xGQnlyMXBWU0VZalYvZ3ZwYlNq?=
 =?utf-8?B?U0tIMU04ZGtuM0JTcFF3dmZiTlZwcGUwajExS0F4YUtIelE0RUFqd2JTV1E4?=
 =?utf-8?B?cHdxRkRoQm45NC9XOFJIY0R2STdnK0JKZ2lzcHhTYlhZWDNBQXQ4bkk4dnFM?=
 =?utf-8?B?enFYMnpORkkyaWhySldmR0pjYWV0TUNCNTNuTUwrb0FsdWFyS2xoaWhNOEho?=
 =?utf-8?B?ZVNxMFpwbWdTZmZqb2g2UjdDdXJzR1JVTkFmajgrMm9MT1lpM1RtaHBQQytq?=
 =?utf-8?B?MU5hQUY3ZU1tTXNLZWVTSVRZT2xzQXdPRFNPb3dERkZMalpaekRsMjRlUmta?=
 =?utf-8?B?dGxTb3NXR2NJZks2SmdVQ2hZN1BUL21SMGlFUGQvdnJDaWxCYVJRRGphempF?=
 =?utf-8?B?eTZ4d1Y3dXdmYk9CbStDZnMzemJMVnBYRzVDa2xnb2xVckx1QVpSYXBXUk5o?=
 =?utf-8?B?b0VUVWNGVzdYNVZKWjgya0Z0aHFncnk0dEwxeDI1ZEhyNWlBVjZ6Tm9tUlg4?=
 =?utf-8?B?QmtNY2lxdGJOQ2pzU1RQMEtiT3BzNC83c0syY0V5SnZkREdoN21USHAvQmlC?=
 =?utf-8?B?RWcwZUlWdVN5NTFka2t4WndYTzFISk4yclVLZjhzYytpMWJqVjlZUGtiZ0tn?=
 =?utf-8?B?cysyaFR1cHAzTi82YVVGL0crb3RhZEVCMVpib3owcXRoQndDWmJhWEdpZG96?=
 =?utf-8?B?SEJqeE8rY3dqL1N5UFR2a3JXOERIbDZ6Sm5IejlPK3NuZHpNNkFTdzVFbGlO?=
 =?utf-8?B?WVQ0UURFRFUrQW5LbkdzTlpYVGpsRzdadUJ6ZXM4cC9NUVdiNzV3cHRuakZN?=
 =?utf-8?B?TTBEVTVmQThnOGFaOUZ5Y24yUlZuS2EzVGYwc3BUcm5TOFBMQ3NHRFJyUC81?=
 =?utf-8?B?Z3J5aFJjWTFsQVM1aHkwaGxyZ3cvcDRmZk01bHhuLzV6S3lIZ0JqTFZDaE1W?=
 =?utf-8?B?LzRqcDNZN3krR3NBVlIzU2hjOURTUUVpcmIxUkh6RU02SVBFbkpuUjUvOVVK?=
 =?utf-8?B?T053QllSdkkva1p5ajVnbGtKNVU1aWxjR1ZOZW1welJSY2UwRElLQXVQV3NK?=
 =?utf-8?B?VkYrNFRsTzRBR0htZTJiNWxsNDVRVFJFbTlpdUMyNStUMDVzSjNLcEhjZVhz?=
 =?utf-8?B?SDRNSE9oaXAwRVZjRTNxTnMwR0dvSG9UYXlVUUt5ZjZDemJNZ05Rb2Fwa0NW?=
 =?utf-8?B?eEo1UEc5Zk5pakl5eEJPck1sekp3V2p4c2VKR2RKTXp3MVdZTzA0VUpUR3Z5?=
 =?utf-8?B?dzg5SUV2Z0tWQ3gvYXZPckxRYXFRQ1RmL24xZ0NvbnVvaFVxek5YU3pkSmZ2?=
 =?utf-8?B?UnlmRk9QQ0xudkhvMnh2cUdMaGpNVnNhVmYzV2R5SFVGRXBVTzRXK0VvYzUx?=
 =?utf-8?B?MjVJaXUydHU4MEV2NlVVaVlyR00rb1IyeVBJSGQ1TFRONnNjSE5xZXBxYUF4?=
 =?utf-8?B?MGZFcHNhSkxaVmtVZE9ZRGJaQTM4VUtRRDlOaUVpUVJzcnhPeEpWeXJyb1dE?=
 =?utf-8?B?V2Y3TGtMRFdueVdyaDIwcGwweERteG1zd2hQaVFzb0ozNFhXbW5wYWpsWkRo?=
 =?utf-8?B?a0ZXVkNFdWV1YXZON1hpQlNHZTJBRGNrK3JlWDRId0NGMks3eEZNaE85aXg4?=
 =?utf-8?B?WFVQeDRITTNSSVBpS2ZKL0F1TXVUUU5kWXFQdkhROXJuQ0kwSnV1cHJmd1ov?=
 =?utf-8?B?YlRCaEJvcWxNamVCSEZzUjZWVFQvM1VDK3MwMzN0NHpzSjNiNS9COXliZ3lh?=
 =?utf-8?B?dTJ3MnhlSTVjL3AvZGY5M0pGTUY2YnBIK0tHTHI4UTdHSm0rS3RRd09RbEhX?=
 =?utf-8?Q?WBC+93vNp1B36UwsK3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3daab986-b6d6-4ccb-ba74-08df1585f4c5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:08:39.2757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wP8NhDm1u3NX9CQaKgZkBYZpNm/+K/0NLdns2yOHEyLzhYMkjL0frSziv5ImeYG+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
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



On 18-Sep-26 5:35 PM, Tvrtko Ursulin wrote:
> Avoid constant register reloads while emitting IBs by using a local write
> pointer and only updating the size at the end of each helper.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> ---
> v2:
>   *  Fix decode buffer overwrite

Overall for this series, below type of calculation  -

	ib->length_dw = ptr - ib->ptr;

is not anticipating a case like below.

         r = amdgpu_vcn_enc_get_create_msg(ring, 1, &ib, NULL);
         if (r)
                 goto error;

         r = amdgpu_vcn_enc_get_destroy_msg(ring, 1, &ib, &fence);
         if (r)
                 goto error;

Thanks,
Lijo.
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 134 +++++++++++++-----------
>   1 file changed, 75 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 17db7264269e..2c367ee6e182 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -622,9 +622,12 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>   {
>   	u64 addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>   	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_vcn_reg *internal = &adev->vcn.inst[ring->me].internal;
> +	uint32_t nop = PACKET0(internal->nop, 0);
>   	struct dma_fence *f = NULL;
>   	struct amdgpu_job *job;
>   	struct amdgpu_ib *ib;
> +	uint32_t *ptr;
>   	int i, r;
>   
>   	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
> @@ -635,15 +638,16 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>   		goto err;
>   
>   	ib = &job->ibs[0];
> -	ib->ptr[0] = PACKET0(adev->vcn.inst[ring->me].internal.data0, 0);
> -	ib->ptr[1] = addr;
> -	ib->ptr[2] = PACKET0(adev->vcn.inst[ring->me].internal.data1, 0);
> -	ib->ptr[3] = addr >> 32;
> -	ib->ptr[4] = PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0);
> -	ib->ptr[5] = 0;
> +	ptr = ib->ptr;
> +	*ptr++ = PACKET0(internal->data0, 0);
> +	*ptr++ = addr;
> +	*ptr++ = PACKET0(internal->data1, 0);
> +	*ptr++ = addr >> 32;
> +	*ptr++ = PACKET0(internal->cmd, 0);
> +	*ptr++ = 0;
>   	for (i = 6; i < 16; i += 2) {
> -		ib->ptr[i] = PACKET0(adev->vcn.inst[ring->me].internal.nop, 0);
> -		ib->ptr[i+1] = 0;
> +		*ptr++ = nop;
> +		*ptr++ = 0;
>   	}
>   	ib->length_dw = 16;
>   
> @@ -763,17 +767,20 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   static uint32_t *amdgpu_vcn_unified_ring_ib_header(struct amdgpu_ib *ib,
>   						uint32_t ib_pack_in_dw, bool enc)
>   {
> +	u32 *ptr = &ib->ptr[ib->length_dw];
>   	uint32_t *ib_checksum;
>   
> -	ib->ptr[ib->length_dw++] = 0x00000010; /* single queue checksum */
> -	ib->ptr[ib->length_dw++] = 0x30000002;
> -	ib_checksum = &ib->ptr[ib->length_dw++];
> -	ib->ptr[ib->length_dw++] = ib_pack_in_dw;
> +	*ptr++ = 0x00000010; /* single queue checksum */
> +	*ptr++ = 0x30000002;
> +	ib_checksum = ptr++;
> +	*ptr++ = ib_pack_in_dw;
>   
> -	ib->ptr[ib->length_dw++] = 0x00000010; /* engine info */
> -	ib->ptr[ib->length_dw++] = 0x30000001;
> -	ib->ptr[ib->length_dw++] = enc ? 0x2 : 0x3;
> -	ib->ptr[ib->length_dw++] = ib_pack_in_dw * sizeof(uint32_t);
> +	*ptr++ = 0x00000010; /* engine info */
> +	*ptr++ = 0x30000001;
> +	*ptr++ = enc ? 0x2 : 0x3;
> +	*ptr++ = ib_pack_in_dw * sizeof(uint32_t);
> +
> +	ib->length_dw = ptr - ib->ptr;
>   
>   	return ib_checksum;
>   }
> @@ -803,7 +810,8 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>   	uint32_t *ib_checksum;
>   	uint32_t ib_pack_in_dw;
> -	int i, r;
> +	u32 *ptr;
> +	int r;
>   
>   	if (adev->vcn.inst[ring->me].using_unified_queue)
>   		ib_size_dw += 8;
> @@ -825,18 +833,20 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, ib_pack_in_dw, false);
>   	}
>   
> -	ib->ptr[ib->length_dw++] = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
> -	ib->ptr[ib->length_dw++] = cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
> -	decode_buffer = (struct amdgpu_vcn_decode_buffer *)&(ib->ptr[ib->length_dw]);
> -	ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
> +	ptr = &ib->ptr[ib->length_dw];
> +
> +	*ptr++ = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
> +	*ptr++ = cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
> +	decode_buffer = (struct amdgpu_vcn_decode_buffer *)ptr;
> +	ptr += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
> +	ib->length_dw = ptr - ib->ptr;
>   	memset(decode_buffer, 0, sizeof(struct amdgpu_vcn_decode_buffer));
>   
>   	decode_buffer->valid_buf_flag |= cpu_to_le32(AMDGPU_VCN_CMD_FLAG_MSG_BUFFER);
>   	decode_buffer->msg_buffer_address_hi = cpu_to_le32(addr >> 32);
>   	decode_buffer->msg_buffer_address_lo = cpu_to_le32(addr);
>   
> -	for (i = ib->length_dw; i < ib_size_dw; ++i)
> -		ib->ptr[i] = 0x0;
> +	memset32(ptr, 0, ib_size_dw - ib->length_dw);
>   
>   	if (adev->vcn.inst[ring->me].using_unified_queue)
>   		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, ib_pack_in_dw);
> @@ -934,7 +944,8 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   	struct dma_fence *f = NULL;
>   	uint32_t *ib_checksum = NULL;
>   	uint64_t addr;
> -	int i, r;
> +	u32 *ptr;
> +	int r;
>   
>   	if (adev->vcn.inst[ring->me].using_unified_queue)
>   		ib_size_dw += 8;
> @@ -947,31 +958,33 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   		return r;
>   
>   	ib = &job->ibs[0];
> -	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
> -
>   	ib->length_dw = 0;
> +	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>   
>   	if (adev->vcn.inst[ring->me].using_unified_queue)
>   		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
>   
> -	ib->ptr[ib->length_dw++] = 0x00000018;
> -	ib->ptr[ib->length_dw++] = 0x00000001; /* session info */
> -	ib->ptr[ib->length_dw++] = handle;
> -	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
> -	ib->ptr[ib->length_dw++] = addr;
> -	ib->ptr[ib->length_dw++] = 0x00000000;
> +	ptr = &ib->ptr[ib->length_dw];
>   
> -	ib->ptr[ib->length_dw++] = 0x00000014;
> -	ib->ptr[ib->length_dw++] = 0x00000002; /* task info */
> -	ib->ptr[ib->length_dw++] = 0x0000001c;
> -	ib->ptr[ib->length_dw++] = 0x00000000;
> -	ib->ptr[ib->length_dw++] = 0x00000000;
> +	*ptr++ = 0x00000018;
> +	*ptr++ = 0x00000001; /* session info */
> +	*ptr++ = handle;
> +	*ptr++ = upper_32_bits(addr);
> +	*ptr++ = addr;
> +	*ptr++ = 0x00000000;
>   
> -	ib->ptr[ib->length_dw++] = 0x00000008;
> -	ib->ptr[ib->length_dw++] = 0x08000001; /* op initialize */
> +	*ptr++ = 0x00000014;
> +	*ptr++ = 0x00000002; /* task info */
> +	*ptr++ = 0x0000001c;
> +	*ptr++ = 0x00000000;
> +	*ptr++ = 0x00000000;
>   
> -	for (i = ib->length_dw; i < ib_size_dw; ++i)
> -		ib->ptr[i] = 0x0;
> +	*ptr++ = 0x00000008;
> +	*ptr++ = 0x08000001; /* op initialize */
> +
> +	ib->length_dw = ptr - ib->ptr;
> +
> +	memset32(ptr, 0, ib_size_dw - ib->length_dw);
>   
>   	if (adev->vcn.inst[ring->me].using_unified_queue)
>   		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
> @@ -1002,7 +1015,8 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   	struct dma_fence *f = NULL;
>   	uint32_t *ib_checksum = NULL;
>   	uint64_t addr;
> -	int i, r;
> +	u32 *ptr;
> +	int r;
>   
>   	if (adev->vcn.inst[ring->me].using_unified_queue)
>   		ib_size_dw += 8;
> @@ -1015,31 +1029,33 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   		return r;
>   
>   	ib = &job->ibs[0];
> -	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
> -
>   	ib->length_dw = 0;
> +	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>   
>   	if (adev->vcn.inst[ring->me].using_unified_queue)
>   		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
>   
> -	ib->ptr[ib->length_dw++] = 0x00000018;
> -	ib->ptr[ib->length_dw++] = 0x00000001;
> -	ib->ptr[ib->length_dw++] = handle;
> -	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
> -	ib->ptr[ib->length_dw++] = addr;
> -	ib->ptr[ib->length_dw++] = 0x00000000;
> +	ptr = &ib->ptr[ib->length_dw];
>   
> -	ib->ptr[ib->length_dw++] = 0x00000014;
> -	ib->ptr[ib->length_dw++] = 0x00000002;
> -	ib->ptr[ib->length_dw++] = 0x0000001c;
> -	ib->ptr[ib->length_dw++] = 0x00000000;
> -	ib->ptr[ib->length_dw++] = 0x00000000;
> +	*ptr++ = 0x00000018;
> +	*ptr++ = 0x00000001;
> +	*ptr++ = handle;
> +	*ptr++ = upper_32_bits(addr);
> +	*ptr++ = addr;
> +	*ptr++ = 0x00000000;
>   
> -	ib->ptr[ib->length_dw++] = 0x00000008;
> -	ib->ptr[ib->length_dw++] = 0x08000002; /* op close session */
> +	*ptr++ = 0x00000014;
> +	*ptr++ = 0x00000002;
> +	*ptr++ = 0x0000001c;
> +	*ptr++ = 0x00000000;
> +	*ptr++ = 0x00000000;
>   
> -	for (i = ib->length_dw; i < ib_size_dw; ++i)
> -		ib->ptr[i] = 0x0;
> +	*ptr++ = 0x00000008;
> +	*ptr++ = 0x08000002; /* op close session */
> +
> +	ib->length_dw = ptr - ib->ptr;
> +
> +	memset32(ptr, 0, ib_size_dw - ib->length_dw);
>   
>   	if (adev->vcn.inst[ring->me].using_unified_queue)
>   		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);

