Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBA9C43217
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Dec 2022 08:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8748A10E113;
	Thu,  1 Dec 2022 08:26:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C11710E113
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Dec 2022 08:26:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpF21i6K4qT6nmStQ6imd3lgiCaiKQSohlCd/5K4XyxvacYdkEe5QLxjANCIuI91aeIfh/u50UT8ac5pJyqF9Yg/VI0pMpkD2ECJpvu72ggOVOMpm5m6MzTtfkwhtanIpo9I6QXggRZG0z6skw/1GG23jOREhv/xo0T+MCv8+wjUVI3L6X7DQ+aPFGP97D7gWmxRBu7IJDEAixUMpBpv4YVDAJmdeAiBC5bBGrKELy11rfCDblx7KSj+G0Ak5WxDDWLthnY49qy0H9nS5cSduHxFQEAVdLtfpOBTDmCo0ge17N2hxEhkW/qOOHO3tjaiGWloENbSlYJjdI6vnKgemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7i5PzmUmWcQ2raSfwWW8v1b/3W65pPuat3AAPqpVz5I=;
 b=UntC7pVJ7sTDeT2WaaW+geU4liSgzGgCWPiEJxOQyhBe1aZ8+HTYhzjdg1FYZHHF+onx2JigI20e6WikxClfkuSQMhMdAtPDcB1VW2P6ybYw5BWgEZfY1K7kpdYcDjplhQgA/FVLQ2N57nNE6nYBqVXfEKQlyQgrV1ck/0G28m9pHYSzXQ23COqaMWHElP6w2QnEj0Ti8CtBlX69NM19wVY5/c9jju/dLGaAk8xXo/PsNTe2cMlm5IuJgFX/uv2pJbOMBVzhrqynBCTneSQdqaUxfHz0tc95pklYPJyagL0bofcTxwy4PWpHbG0WreHs9TBkJeWAmjt+vhYZRiMMZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i5PzmUmWcQ2raSfwWW8v1b/3W65pPuat3AAPqpVz5I=;
 b=a7jYMkb4EJxzpyvqSO64kPKtr2o4FsFZcUAJydCENRpv/eltvVZ+M+SG9U9oHVT2V0uWcg1i0GhoS8ptsj4FU4KYQrqev3IKKK+bZLv1u+yq9VSD4AhpHfm+o02uXYC6yzPjriC01te57JSPERLERfViCzpyfmzTCMNQMedhZJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MN2PR12MB4581.namprd12.prod.outlook.com (2603:10b6:208:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 08:25:57 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 08:25:57 +0000
Message-ID: <f5478d14-e5b6-7be8-9646-d86999ee5a2b@amd.com>
Date: Thu, 1 Dec 2022 03:25:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 3/4] drm/amdgpu: Modify unmap_queue format for gfx9 (v6)
Content-Language: en-CA
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20221129071037.531124-1-jiadong.zhu@amd.com>
 <20221129071037.531124-3-jiadong.zhu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20221129071037.531124-3-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1P288CA0032.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::45)
 To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MN2PR12MB4581:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ed82e4-a68e-4062-2609-08dad375abd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mv2VQnM3du3Dcw/KHe2W/KlYW1Qbvp3xN77JXrA6ymAEwYU6p0udBHJfODbU+i+n1PVJF4zWIZiuTUhpPTo3We8SHEgA5g0EZuYuh93/Uzfk8AFe46kC43UiQSCjb2EJ3l7021Wa3zA/GvlhRoEUfZFPi9z3tO3xdXM1zVdv4eOrBEZvihu22YaC1oCWu2FZ/OewaL7vVgYRgJnYPsVDMfdYzENnQdQNjYdQwLvYcBQQT39kC0bFW/9wpC3OE5zcp8W1ckJTD5yqbc5+To/keabws7RkFCUbrYBPvPayegekvKjX90S7nSWfvE+wtQUOdLN8rpDlM00ie/Uzzb7+dmd1JvJT5K9oqpkUtp8hnSXKDOthnazgF4a8H8Xy4OvH6IBOtOwmks8xwiOFggz/Cm62VzQszkm+icW4sihAlDIhwtyH71lUoGh69aCz45POBu7DRa+wMZXvESGyCWkSJgNxeOCXNSrF7gC0S02fHgcKy+wwm7H6JXaPjRdt6LbJIkv2zZJ54BxfHlI2JZolxzkfzcGYTHHTK77extBLrbg66/+IW6z+ETmpVOzOEfWmVUmmYPKjoroYdKKmS/rKN8UvVjRtS2cFMboxWVbz3kBXlRrAjaub7pxGahG9QVGRy2xm9mjyAB16VzadL43t9A0FYg/X2dVlQGAuoLHqJ8ZctBWhO1Z3U1kZR0eQRtjigBS7B42DpZK1kHdrLeDB+T1PeLFzaVSHecNFChw1eEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(6486002)(6666004)(31696002)(66574015)(6506007)(31686004)(478600001)(4326008)(41300700001)(186003)(2616005)(36756003)(8676002)(53546011)(66556008)(66476007)(6512007)(316002)(30864003)(5660300002)(26005)(54906003)(44832011)(2906002)(4001150100001)(86362001)(83380400001)(66946007)(8936002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGNHdXR2UTdpeVZaVHBKWUx6djdKa0poVHRZaVR3c1NJNWEyTHd1RzlSUlRr?=
 =?utf-8?B?dENVSzFqMDMwRVRiK3MxN09uUC9wQ1FrYW1OSHdvZDNkdzlMWmRnWHA2c2V1?=
 =?utf-8?B?NTU0bDI4dS9naVlnTVJDQ0J1TDhIUnB1VWRSSVcyQy9pdUxEeWErQWZ6M1V0?=
 =?utf-8?B?eDVxaUJsV1d5OUdJN0cxYkJQYWs0cHhlNE5mVEVsYW91dFJpSE9GZUZiT3Zw?=
 =?utf-8?B?STFSb2J0SStkS2IxUm1uSWVwUTI5TWJVQkRTRmw3bkNJRzc4Vit2OFgxMGI0?=
 =?utf-8?B?bU5iOGlyY0tRWHZqU2twb0dZNjdGcmxialVlWTdPQlZ1MHcwaWljcTF6blpK?=
 =?utf-8?B?bDVhcEpPRmRXdVR4MHpUK3VuSUNPUmUvY0UrQXFURlJUYjJkQzZqRVl5RkZ5?=
 =?utf-8?B?WlZxODJ3cHB2bXhKemwyR09yeFMzdzM0bVNIMGRqTEMvbCtiTHZZTlVCbXdZ?=
 =?utf-8?B?TWpMUjFIMU9ud3ZWdGhsWVZadUYzdjVnQjRYWmtvQWpTU0RSb3RSUDN3akMr?=
 =?utf-8?B?YVlBM3owY0F2NDRKa1dnVWNPZk4yRG9iWlBYVWNFYkdialJ1aWNNanZPQ3VB?=
 =?utf-8?B?b2RUYlFpdnJLcFRuVUpUbzNVeTFoNWNURzd4Q0pYbG41YW4wcitINmxJSUdm?=
 =?utf-8?B?RFJ6VWxBQ0NxVWc5ajBJaVBLMk9Sb2dpK0VQVTNlWHVnZXN6U3JYTjhBT0FB?=
 =?utf-8?B?TW5mTENRVXkyZDZyWWJ6TTg2aUp4VWZhSFNlb0taTVo5R3JtUVZBdXdrVmZC?=
 =?utf-8?B?eThxdWUvWUFmMXNPMDlrRnRXa0J2UGhCalBvWDhBQ2JhaTMyS2ZGOVY3OFox?=
 =?utf-8?B?QWNoamZzUFZWdTJyWXdHeG1XNVJDWDY3WHh1THlOc01mMVUzbzVaVTBkdGVR?=
 =?utf-8?B?djM4RnU2QTEzL3lmRFV1cjFQYUVsU2hTYWNHK21vbGIwbW5yaWJOQmtqQmVT?=
 =?utf-8?B?dXBBdWN6RmREN1hxWW1SMjF3a1h5SXRVYU14ek55aHF6R0QvamIvd3dESWZa?=
 =?utf-8?B?T1ZZWVRmMXFZT3RFMmVEeENKTS9tNFRURXo1cW9VN254a1NzTk43ancrODhB?=
 =?utf-8?B?NlZMeEc1di9CQ3JIMGk0R3Nvd3lVSG9BdUlsdzFrRjRqUzZSK0hwWUNSbStR?=
 =?utf-8?B?OVlvbHRnZmY1VmFZb0NWRzRIeTdBWkZuWUJFTHZiVk5DeXNkTVlaOXhRTFp5?=
 =?utf-8?B?cFE5bDZvb1Rpb3UycTV3a0JTSm1XK2dGUW1hM3lPL3hJMGlUNk1ObU9xQ3RK?=
 =?utf-8?B?dlVaOGo4NXBaRFVmdlk5NzM3Z283OWFUaFViMmlsREZnbldkWVdNaGVCalJp?=
 =?utf-8?B?OTdpYjgybitMOFpjNTc3S0dkWXlqYVRpdDZPaFJRbzNrV28zV0s4VXVSM1hE?=
 =?utf-8?B?czdQWjZUSXBtdlF3U3N4c1hra2NMajZtUzdLYkpDT1k1c1pKUWV0M2lTOGZW?=
 =?utf-8?B?UVZ3SktvY09uaXkrZlowQlRPa3BSK250MTVBUlFobnZUYktacVFsdEVuZC83?=
 =?utf-8?B?Ym9vamhXaHFvODNnTlFaeTk5MWp5S0Ura0lzMjJuWUdSaEZsc0dacXJnMUtW?=
 =?utf-8?B?UHdvblhwdEhKdjYzaUdmbzNCNFN2Vk5NWmlET1gydllPa0paVXhsQVdNaTQ0?=
 =?utf-8?B?eHdHNTNQZEQxZ3F4a3pEN0cxZXVEUXhYWDdpU0pLb01SSzlmSFZ3Y0R3Qitz?=
 =?utf-8?B?K1pHNEtRS0N6cklyc3JGWW9FSnRQaDBXemd4endHR2FPU01XcjIxMGdhOGNH?=
 =?utf-8?B?VXY2UHFCTS96YUJ1bW0yMStYaTdLSzRxSVkrNUlWdldrUzYzZlJFWVNPM1ll?=
 =?utf-8?B?SEhGR3BGQmdwUVhmNmxXYmdlYnBYOEJrMDlMMDQ5SVc3N3BtNlNKMWNwMFdr?=
 =?utf-8?B?VDdwWkJ3QURSenA3WFdoYjZNMWJNakhacnArbzVYbHBtZTk5aDlEOGNCSkth?=
 =?utf-8?B?Ukc0V3gzQ08wb01rMnFjaHVyMmIySzEvejFQci82ZWhpMmdzN0JVa1lWT1Vo?=
 =?utf-8?B?RE80RFp4M1FrZHhhUGZlQTMxYk4zR2Uyd3dXbDIxWFVwOWw1UVZFcjJ6VW03?=
 =?utf-8?B?M1I4RGpheU9PelUwVXVNTHVVeW85dkFVQzd0VzltbE1jV0gxQXRIUFhFRUZr?=
 =?utf-8?Q?tpwkmJy1V6VU8YZlPe8WW1hrq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ed82e4-a68e-4062-2609-08dad375abd4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 08:25:57.5975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpWkeUdUaezOKJZ0nLNfLXuibTE6LaggOZZf0oVNmLvdnRvI2k2IpeTXIDCtRhme
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4581
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
Cc: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Huang Rui <ray.huang@amd.com>, Christian Koenig <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The flags have been refactored--good.

Acked-by: Luben Tuikov <luben.tuikov@amd.com>

On 2022-11-29 02:10, jiadong.zhu@amd.com wrote:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
> 
> 1. Modify the unmap_queue package on gfx9. Add trailing fence to track the
>    preemption done.
> 2. Modify emit_ce_meta emit_de_meta functions for the resumed ibs.
> 
> v2: Restyle code not to use ternary operator.
> v3: Modify code format.
> v4: Enable Mid-Command Buffer Preemption for gfx9 by default.
> v5: Optimize the flag bit set for emit_fence.
> v6: Modify log message for preemption timeout.
> 
> Cc: Christian Koenig <Christian.Koenig@amd.com>
> Cc: Michel Dänzer <michel@daenzer.net>
> Cc: Luben Tuikov <Luben.Tuikov@amd.com>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 182 +++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/soc15d.h      |   2 +
>  3 files changed, 156 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index a744aa9bac95..073e767c057f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -60,6 +60,7 @@ enum amdgpu_ring_priority_level {
>  #define AMDGPU_FENCE_FLAG_64BIT         (1 << 0)
>  #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
>  #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
> +#define AMDGPU_FENCE_FLAG_EXEC          (1 << 3)
>  
>  #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index ec80047b1b41..ec528b1d82e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -755,7 +755,7 @@ static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
>  static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
>  				struct amdgpu_cu_info *cu_info);
>  static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
> -static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
> +static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume);
>  static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
>  static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
>  					  void *ras_error_status);
> @@ -828,9 +828,10 @@ static void gfx_v9_0_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
>  			PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(ring->doorbell_index));
>  
>  	if (action == PREEMPT_QUEUES_NO_UNMAP) {
> -		amdgpu_ring_write(kiq_ring, lower_32_bits(gpu_addr));
> -		amdgpu_ring_write(kiq_ring, upper_32_bits(gpu_addr));
> -		amdgpu_ring_write(kiq_ring, seq);
> +		amdgpu_ring_write(kiq_ring, lower_32_bits(ring->wptr & ring->buf_mask));
> +		amdgpu_ring_write(kiq_ring, 0);
> +		amdgpu_ring_write(kiq_ring, 0);
> +
>  	} else {
>  		amdgpu_ring_write(kiq_ring, 0);
>  		amdgpu_ring_write(kiq_ring, 0);
> @@ -5326,11 +5327,17 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>  
>  	control |= ib->length_dw | (vmid << 24);
>  
> -	if (amdgpu_sriov_vf(ring->adev) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
> +	if (ib->flags & AMDGPU_IB_FLAG_PREEMPT) {
>  		control |= INDIRECT_BUFFER_PRE_ENB(1);
>  
> +		if (flags & AMDGPU_IB_PREEMPTED)
> +			control |= INDIRECT_BUFFER_PRE_RESUME(1);
> +
>  		if (!(ib->flags & AMDGPU_IB_FLAG_CE) && vmid)
> -			gfx_v9_0_ring_emit_de_meta(ring);
> +			gfx_v9_0_ring_emit_de_meta(ring,
> +						   (!amdgpu_sriov_vf(ring->adev) &&
> +						   flags & AMDGPU_IB_PREEMPTED) ?
> +						   true : false);
>  	}
>  
>  	amdgpu_ring_write(ring, header);
> @@ -5385,17 +5392,24 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>  	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
>  	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
>  	bool writeback = flags & AMDGPU_FENCE_FLAG_TC_WB_ONLY;
> +	bool exec = flags & AMDGPU_FENCE_FLAG_EXEC;
> +	uint32_t dw2 = 0;
>  
>  	/* RELEASE_MEM - flush caches, send int */
>  	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
> -	amdgpu_ring_write(ring, ((writeback ? (EOP_TC_WB_ACTION_EN |
> -					       EOP_TC_NC_ACTION_EN) :
> -					      (EOP_TCL1_ACTION_EN |
> -					       EOP_TC_ACTION_EN |
> -					       EOP_TC_WB_ACTION_EN |
> -					       EOP_TC_MD_ACTION_EN)) |
> -				 EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
> -				 EVENT_INDEX(5)));
> +
> +	if (writeback) {
> +		dw2 = EOP_TC_NC_ACTION_EN;
> +	} else {
> +		dw2 = EOP_TCL1_ACTION_EN | EOP_TC_ACTION_EN |
> +				EOP_TC_MD_ACTION_EN;
> +	}
> +	dw2 |= EOP_TC_WB_ACTION_EN | EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
> +				EVENT_INDEX(5);
> +	if (exec)
> +		dw2 |= EOP_EXEC;
> +
> +	amdgpu_ring_write(ring, dw2);
>  	amdgpu_ring_write(ring, DATA_SEL(write64bit ? 2 : 1) | INT_SEL(int_sel ? 2 : 0));
>  
>  	/*
> @@ -5500,33 +5514,135 @@ static void gfx_v9_ring_emit_sb(struct amdgpu_ring *ring)
>  	amdgpu_ring_write(ring, 0);
>  }
>  
> -static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring)
> +static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume)
>  {
> +	struct amdgpu_device *adev = ring->adev;
>  	struct v9_ce_ib_state ce_payload = {0};
> -	uint64_t csa_addr;
> +	uint64_t offset, ce_payload_gpu_addr;
> +	void *ce_payload_cpu_addr;
>  	int cnt;
>  
>  	cnt = (sizeof(ce_payload) >> 2) + 4 - 2;
> -	csa_addr = amdgpu_csa_vaddr(ring->adev);
> +
> +	if (ring->is_mes_queue) {
> +		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
> +				  gfx[0].gfx_meta_data) +
> +			offsetof(struct v9_gfx_meta_data, ce_payload);
> +		ce_payload_gpu_addr =
> +			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +		ce_payload_cpu_addr =
> +			amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +	} else {
> +		offset = offsetof(struct v9_gfx_meta_data, ce_payload);
> +		ce_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
> +		ce_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
> +	}
>  
>  	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, cnt));
>  	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(2) |
>  				 WRITE_DATA_DST_SEL(8) |
>  				 WR_CONFIRM) |
>  				 WRITE_DATA_CACHE_POLICY(0));
> -	amdgpu_ring_write(ring, lower_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, ce_payload)));
> -	amdgpu_ring_write(ring, upper_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, ce_payload)));
> -	amdgpu_ring_write_multiple(ring, (void *)&ce_payload, sizeof(ce_payload) >> 2);
> +	amdgpu_ring_write(ring, lower_32_bits(ce_payload_gpu_addr));
> +	amdgpu_ring_write(ring, upper_32_bits(ce_payload_gpu_addr));
> +
> +	if (resume)
> +		amdgpu_ring_write_multiple(ring, ce_payload_cpu_addr,
> +					   sizeof(ce_payload) >> 2);
> +	else
> +		amdgpu_ring_write_multiple(ring, (void *)&ce_payload,
> +					   sizeof(ce_payload) >> 2);
> +}
> +
> +static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ring *ring)
> +{
> +	int i, r = 0;
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> +	struct amdgpu_ring *kiq_ring = &kiq->ring;
> +	unsigned long flags;
> +
> +	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&kiq->ring_lock, flags);
> +
> +	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +		return -ENOMEM;
> +	}
> +
> +	/* assert preemption condition */
> +	amdgpu_ring_set_preempt_cond_exec(ring, false);
> +
> +	ring->trail_seq += 1;
> +	amdgpu_ring_alloc(ring, 13);
> +	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
> +				 ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC);
> +	/*reset the CP_VMID_PREEMPT after trailing fence*/
> +	amdgpu_ring_emit_wreg(ring,
> +			      SOC15_REG_OFFSET(GC, 0, mmCP_VMID_PREEMPT),
> +			      0x0);
> +
> +	/* assert IB preemption, emit the trailing fence */
> +	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
> +				   ring->trail_fence_gpu_addr,
> +				   ring->trail_seq);
> +
> +	amdgpu_ring_commit(kiq_ring);
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +
> +	/* poll the trailing fence */
> +	for (i = 0; i < adev->usec_timeout; i++) {
> +		if (ring->trail_seq ==
> +			le32_to_cpu(*ring->trail_fence_cpu_addr))
> +			break;
> +		udelay(1);
> +	}
> +
> +	if (i >= adev->usec_timeout) {
> +		r = -EINVAL;
> +		DRM_WARN("ring %d timeout to preempt ib\n", ring->idx);
> +	}
> +
> +	amdgpu_ring_commit(ring);
> +
> +	/* deassert preemption condition */
> +	amdgpu_ring_set_preempt_cond_exec(ring, true);
> +	return r;
>  }
>  
> -static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
> +static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
>  {
> +	struct amdgpu_device *adev = ring->adev;
>  	struct v9_de_ib_state de_payload = {0};
> -	uint64_t csa_addr, gds_addr;
> +	uint64_t offset, gds_addr, de_payload_gpu_addr;
> +	void *de_payload_cpu_addr;
>  	int cnt;
>  
> -	csa_addr = amdgpu_csa_vaddr(ring->adev);
> -	gds_addr = csa_addr + 4096;
> +	if (ring->is_mes_queue) {
> +		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
> +				  gfx[0].gfx_meta_data) +
> +			offsetof(struct v9_gfx_meta_data, de_payload);
> +		de_payload_gpu_addr =
> +			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +		de_payload_cpu_addr =
> +			amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +
> +		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
> +				  gfx[0].gds_backup) +
> +			offsetof(struct v9_gfx_meta_data, de_payload);
> +		gds_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +	} else {
> +		offset = offsetof(struct v9_gfx_meta_data, de_payload);
> +		de_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
> +		de_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
> +
> +		gds_addr = ALIGN(amdgpu_csa_vaddr(ring->adev) +
> +				 AMDGPU_CSA_SIZE - adev->gds.gds_size,
> +				 PAGE_SIZE);
> +	}
> +
>  	de_payload.gds_backup_addrlo = lower_32_bits(gds_addr);
>  	de_payload.gds_backup_addrhi = upper_32_bits(gds_addr);
>  
> @@ -5536,9 +5652,15 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
>  				 WRITE_DATA_DST_SEL(8) |
>  				 WR_CONFIRM) |
>  				 WRITE_DATA_CACHE_POLICY(0));
> -	amdgpu_ring_write(ring, lower_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, de_payload)));
> -	amdgpu_ring_write(ring, upper_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, de_payload)));
> -	amdgpu_ring_write_multiple(ring, (void *)&de_payload, sizeof(de_payload) >> 2);
> +	amdgpu_ring_write(ring, lower_32_bits(de_payload_gpu_addr));
> +	amdgpu_ring_write(ring, upper_32_bits(de_payload_gpu_addr));
> +
> +	if (resume)
> +		amdgpu_ring_write_multiple(ring, de_payload_cpu_addr,
> +					   sizeof(de_payload) >> 2);
> +	else
> +		amdgpu_ring_write_multiple(ring, (void *)&de_payload,
> +					   sizeof(de_payload) >> 2);
>  }
>  
>  static void gfx_v9_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
> @@ -5554,8 +5676,9 @@ static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
>  {
>  	uint32_t dw2 = 0;
>  
> -	if (amdgpu_sriov_vf(ring->adev))
> -		gfx_v9_0_ring_emit_ce_meta(ring);
> +	gfx_v9_0_ring_emit_ce_meta(ring,
> +				   (!amdgpu_sriov_vf(ring->adev) &&
> +				   flags & AMDGPU_IB_PREEMPTED) ? true : false);
>  
>  	dw2 |= 0x80000000; /* set load_enable otherwise this package is just NOPs */
>  	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
> @@ -6908,6 +7031,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>  	.emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
>  	.init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
>  	.patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
> +	.preempt_ib = gfx_v9_0_ring_preempt_ib,
>  	.emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
>  	.emit_wreg = gfx_v9_0_ring_emit_wreg,
>  	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> index 799925d22fc8..2357ff39323f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> @@ -162,6 +162,7 @@
>  		 * 2 - Bypass
>  		 */
>  #define     INDIRECT_BUFFER_PRE_ENB(x)		 ((x) << 21)
> +#define     INDIRECT_BUFFER_PRE_RESUME(x)               ((x) << 30)
>  #define	PACKET3_COPY_DATA				0x40
>  #define	PACKET3_PFP_SYNC_ME				0x42
>  #define	PACKET3_COND_WRITE				0x45
> @@ -184,6 +185,7 @@
>  #define		EOP_TC_ACTION_EN                        (1 << 17) /* L2 */
>  #define		EOP_TC_NC_ACTION_EN			(1 << 19)
>  #define		EOP_TC_MD_ACTION_EN			(1 << 21) /* L2 metadata */
> +#define		EOP_EXEC				(1 << 28) /* For Trailing Fence */
>  
>  #define		DATA_SEL(x)                             ((x) << 29)
>  		/* 0 - discard

