Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB12C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 07:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28CC889FEA;
	Tue, 15 Mar 2022 07:20:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8326189FEA
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 07:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US9Bpo2hs5WsRCykPQzkwALmwTjM/KM9eU/tjlBnVPzt3+riKecTutqwF6AT7WGF+DjbsCWE1588fHoUTK5HrTcpc9w7ByGB7v8s1Ck4u4p3wo8XkO8gVSL9YX6bdBD+lkXUJIy78g7I9usX4bSH8x3rijNclS4g8eN3M7MIztsv33UCTdTmxEGL8bpC09JIDRNd5PGwy2R1jHlEEhLZ5dwIQjsBOnSCZ66GAell9jlS93OT86pe9cb9rB2fHDSkq70SyEv3wUpgiTIt0XzKaH/0Cke3xy7+XmW+zQnQEZizPctEbnkmh/FIA5TcBXEejf87WqAB3niD/5XD91CK/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJ90rA0Jn7qrg5K7CH5Ftys+gnecM/Nr0587UNXQKOs=;
 b=fV2wFBaIOUUtMuWpiP/ui+kA5y9dO4eElIej6u+SH8yzv+eenSRwITlCUupotYJRcGCCxkNROK5ymkRlc82lU8bAswROic6BOyocTBKsi7ryaddKZ2+2bi6mqR2+j61khBs4cVdE9E2DsDAyqte7d0iYx7x+X2EeN6mNVmxgtUG/BLHQYvqzSYj9gMNrUO8JqUHNPFmteiBCNUolQD3iAQI1w5ZqkcatmLswPIxZ7wxPSdxfcBCLpKuLFf5lb3IeXyx2g1Lz0+nBiX/4cQCG3Mur60VEFYu4Mo45BEb9hM/MkjNXw03ThUFK0C2VLu0TIevsXaPVMnoCMblJcWw43w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJ90rA0Jn7qrg5K7CH5Ftys+gnecM/Nr0587UNXQKOs=;
 b=2RwEizMojALvHKCmYwW7xuPdhIxn/Sj9VfQToekxnnBuc8FMv8aeS7ksC2cen22YecFL+UnvYGKcjT9e1gDPabWFGWmB+3IwEyKLztkdrfzUnsI6QELIW36AFIMizAHWMsmTunfEnvPUQLZREKd1q1XW8f6jvDCrlINQ6WduhEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 07:20:18 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 07:20:18 +0000
Message-ID: <38c172ef-8aa7-86c7-4784-ade9de1cffbc@amd.com>
Date: Tue, 15 Mar 2022 08:20:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: only allow secure submission on rings which
 support that
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220315054518.2374124-1-Lang.Yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220315054518.2374124-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR07CA0009.eurprd07.prod.outlook.com
 (2603:10a6:20b:451::33) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 297b19c8-4ddf-4cd0-6f70-08da065441c9
X-MS-TrafficTypeDiagnostic: BY5PR12MB4146:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB414689639881E9C0B2FB034883109@BY5PR12MB4146.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLmo5jiK8i+3E71lvTomJDqM4NlEnbF+WSL90TIwyhEy0wY6jC0YW+r3S+uqypUlO6VT0Rf9gbR1Z77cUmmDa5TYI83yDIAJaxOaJcvo6H3dN4unDUiTU2h3QuZ3zD+dFwL9wYCN2KdygTOn0y+h0z5J7VMziThaZXJ4l3R6TujTLRoPmtfjUshRW/x9+gifL3csZc3IzopnUCnvsdZX3PoKzutLc+1a0cS0o1WamZ/kLy7tyfuRnLpfWbMZU9g+S3IcrKIT4MlxUu1g3jrWu/SqpaZMhNssyRl11FEG1zWpH5WGw5ORcSjme/FS5ks0A9A+cgAb0G+f1PrplGFFvFGiSRHSWdW2/O9lA/n+qRd4yk0L09xav/jNPxWyyoh+403LMarA48YONQ2W+WlKP5jpg1nUClaWpIMuFutiKnqs/aCwlHRyzpLoSAU0IYK0CagWAdwqJxG6WvRxsdq1ZNRN4ig2I5qZbcVcO27EHpoyquAnlYfoOnVo0Wp3bjiUy/k93X+JV6O9pDwYjDtFGnD3wqK39MhFfUBAB2KlSSTWCmbfO5bgiip35NhjwIUeIFIxFbEFDEHA7N+GdrU/poFJlPYnAxFJ8xUNrrDQ3+4+UFtv3oRh4eCFuoosRFRcPGbpzAJIrHfSAF1TuPK6n2Lsw3buUUPEBPinnXA3Zp8gQV1jCpIq+Adw+tP3ZYS2kWB1AEPQgY9tFqNH6ifydFoAZKu3BkDO/267sHFa4T8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(83380400001)(8676002)(36756003)(508600001)(4326008)(54906003)(66946007)(31686004)(66556008)(66476007)(316002)(6486002)(6506007)(38100700002)(30864003)(5660300002)(8936002)(2906002)(2616005)(86362001)(31696002)(6666004)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnY2OUxiejhEeHFVRUM0UGZ6NlBpTmN6TDlhT1RSemhBQWdLTDBTbmxTN1Nh?=
 =?utf-8?B?Mm95OVViQmJkeGVMb2w2UkhBUFRGNHpzcWM5YW9VSm84clNsYlVvdng3ME9F?=
 =?utf-8?B?cEltSkpyMVRiOXJVYWN1c1dNQnIyK1JDYzRTeHhtUHRnVVhqOW1TMVNSZkhN?=
 =?utf-8?B?QVpxQ08yMnZHOHVTMk5QSGN5bndIVW9abDNoM01kSU1pYXdnVVo3ZXovQkJm?=
 =?utf-8?B?VkNIRE03a29sQjEvUExZUVl4d25OdWx3UEFyQkx2VG43NXFKZHlQQ296bVNU?=
 =?utf-8?B?cDFsRnNHTzN5WUlKT1JhRW1JeWRlZUV2YkRkTUtFVDNrWWpwNC9GZFlYVlJz?=
 =?utf-8?B?UmxFUzRIVUtBTGRhV3hlS0kvTUhPd1VRcU1tRlQyVCt1Ly9zdkQ4azJIUW9F?=
 =?utf-8?B?Tmt5cmVIMW4yZGl0MGtPdlpXc2lJanNKdnRjcDRNNzFYSnJvK0dQWlhZK1o4?=
 =?utf-8?B?YXBhak91ZzFoQmNMNE1KVkxnQlpTY200cHVvUmJOTUNDUVZscG53c24yaUpS?=
 =?utf-8?B?K2lmRmpqYUhraXRvWmRkVDRTNjhrZnIzem9kVzgyQjBFYk5XdGlYakdlL3Bt?=
 =?utf-8?B?d01qbUdCZ1hwcE1TcDlzeHVaaUZ6K1cyMCt1MDZPc1ljR3dJQVFNckNmMnJl?=
 =?utf-8?B?MDd1L0NZR3JUNDQyakdCcC9uL3BTOVZWYUNNMWc0YytKbjEyRXFBL2taYXJy?=
 =?utf-8?B?RGVBdUZ3RHZKMHc5Z2JjdExYR0FBdE1FdElGaHVCUmlmVWJjZC8vUS9tWkFS?=
 =?utf-8?B?YnE1UlAzdGF3SHAzZlZxd2NwbjJVNVJiamJEajl3RXNybnNqK2lsTEsva2Fs?=
 =?utf-8?B?bzMxQW5VUUJjNjNEY1ltYkNieklNQXpvQUE0SzJubm5kNkxBYnJ4Y0xaQURm?=
 =?utf-8?B?SXZKQlB0aEgzSEgzemNOTmNNY1ZLOU5COHFyN2Jmams2N0M1K0pEdm5QVE5C?=
 =?utf-8?B?eCthOUhPcmRxcmhpYStRL0VldHNFWmc4NDJmSnZDWlBBWmZlblZTNE1TNzF6?=
 =?utf-8?B?amZqY1JwT1Y3MzJjUTlRZ2tKOGhHdUYvZjc5bW5qZ2pIU2kwNzhoSGhLRXps?=
 =?utf-8?B?YlpNNWRMdEc1TzRNTzVLQVZMZXBpVzR0YXNYUk0vTHNqWWF1Z1Bpengrb3U2?=
 =?utf-8?B?WlNBckhia3NpZ1U5NXhBTFZyT0tsbXc1S1FUbExDdXp3WnFpaGJqU21rRmxn?=
 =?utf-8?B?eC95VEc5anRhUjNVVWM3bzVpN3VJdm9IaUpBdzZDK1B0bTZsYytWNXZKbjJt?=
 =?utf-8?B?d3MxcGRjY1p0UWdrK1ZYaWRPOW9RY1pQbHFrZzVXZHlRcDNhajNDT01iSUky?=
 =?utf-8?B?RmF5MUp4UTNXOGVwc1FhUktwU1JLdkttMzBtNVBNUU9peW5uMmJiU09XOUox?=
 =?utf-8?B?aG4vbnlYbzFoa1Z2RUZKMitQbGl0UWpiSllERkk2TllGMlhjcTlwbkltT2l3?=
 =?utf-8?B?WlBEK2ZlNnRwMndvTDZvaUxEemZ5Z280aXVBczMzRTlDK2dRSzBSRXBmanl2?=
 =?utf-8?B?NDVnUDhFemFzY25TOFZhRFk1eUdSL2ZKMDhFWmJ1bTkwWjUxVGhjYWQxS0kw?=
 =?utf-8?B?WnpUSTBESGJON3M4OWx2RjVzR0pBQUllaW1VdVVjcjBkYUc0V2dkTVUrREFP?=
 =?utf-8?B?N3hsUFZaRXhXLzhFOTRmSVljWGFxdTM1bHdxSk9OdjJqR2RlaFY4SDRrakVu?=
 =?utf-8?B?ZEpYY3JXdGxGUlgrU1MrNUo3RHpoQzFZaGN6Y09UVWdGSndlVW1xUS8rdk50?=
 =?utf-8?B?VlJ5SWcweWFBc0VSc1MxMDhFeUIveEpzUlFoeFI5MzN4ME5RbTdyWFM3YjdU?=
 =?utf-8?B?Uk9ITkZvMWVhMWJGazFrSmVWMkNNZi9jcWRHRzZqN25OZnVPZTNnSVdKM0h0?=
 =?utf-8?B?cE14WStVVE9UOXU4MHZUNEVYNnFOZzFBRm5CakY5U09IcG5jMm5FTEw0WnlL?=
 =?utf-8?Q?dZAG4o8WxPWEhH7rSFhSMDCIkMuTRxKv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297b19c8-4ddf-4cd0-6f70-08da065441c9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 07:20:17.8804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWTAPM+/wlDmNkyNPtTEAQLDcvYYuilKGiZjQ+Xqn2JbTN6gYS5PH8ifwpxZs4jH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.03.22 um 06:45 schrieb Lang Yu:
> Only GFX ring, SDMA ring and VCN decode ring support secure submission
> at the moment.
>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Good work, patch is Reviewed-by: Christian König <christian.koenig@amd.com>.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 1 +
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 1 +
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 1 +
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 1 +
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 1 +
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 1 +
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    | 1 +
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 2 ++
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 2 ++
>   13 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index bc1297dcdf97..d583766ea392 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -166,8 +166,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	}
>   
>   	if ((ib->flags & AMDGPU_IB_FLAGS_SECURE) &&
> -	    (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)) {
> -		dev_err(adev->dev, "secure submissions not supported on compute rings\n");
> +	    (!ring->funcs->secure_submission_supported)) {
> +		dev_err(adev->dev, "secure submissions not supported on ring <%s>\n", ring->name);
>   		return -EINVAL;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index a8bed1b47899..5320bb0883d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -155,6 +155,7 @@ struct amdgpu_ring_funcs {
>   	u32			nop;
>   	bool			support_64bit_ptrs;
>   	bool			no_user_fence;
> +	bool			secure_submission_supported;
>   	unsigned		vmhub;
>   	unsigned		extra_dw;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 713d39d89e30..f4c6accd3226 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9377,6 +9377,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>   	.align_mask = 0xff,
>   	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
>   	.support_64bit_ptrs = true,
> +	.secure_submission_supported = true,
>   	.vmhub = AMDGPU_GFXHUB_0,
>   	.get_rptr = gfx_v10_0_ring_get_rptr_gfx,
>   	.get_wptr = gfx_v10_0_ring_get_wptr_gfx,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 8def7f630d4c..46d4bf27ebbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -6865,6 +6865,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>   	.align_mask = 0xff,
>   	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
>   	.support_64bit_ptrs = true,
> +	.secure_submission_supported = true,
>   	.vmhub = AMDGPU_GFXHUB_0,
>   	.get_rptr = gfx_v9_0_ring_get_rptr_gfx,
>   	.get_wptr = gfx_v9_0_ring_get_wptr_gfx,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> index 4509bd4cce2d..1d8bbcbd7a37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -1142,6 +1142,7 @@ static const struct amdgpu_ring_funcs sdma_v2_4_ring_funcs = {
>   	.align_mask = 0xf,
>   	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>   	.support_64bit_ptrs = false,
> +	.secure_submission_supported = true,
>   	.get_rptr = sdma_v2_4_ring_get_rptr,
>   	.get_wptr = sdma_v2_4_ring_get_wptr,
>   	.set_wptr = sdma_v2_4_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index 135727b59c41..4ef4feff5649 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -1580,6 +1580,7 @@ static const struct amdgpu_ring_funcs sdma_v3_0_ring_funcs = {
>   	.align_mask = 0xf,
>   	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>   	.support_64bit_ptrs = false,
> +	.secure_submission_supported = true,
>   	.get_rptr = sdma_v3_0_ring_get_rptr,
>   	.get_wptr = sdma_v3_0_ring_get_wptr,
>   	.set_wptr = sdma_v3_0_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 01b385568c14..d7e8f7232364 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2414,6 +2414,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs = {
>   	.align_mask = 0xf,
>   	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>   	.support_64bit_ptrs = true,
> +	.secure_submission_supported = true,
>   	.vmhub = AMDGPU_MMHUB_0,
>   	.get_rptr = sdma_v4_0_ring_get_rptr,
>   	.get_wptr = sdma_v4_0_ring_get_wptr,
> @@ -2450,6 +2451,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs_2nd_mmhub = {
>   	.align_mask = 0xf,
>   	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>   	.support_64bit_ptrs = true,
> +	.secure_submission_supported = true,
>   	.vmhub = AMDGPU_MMHUB_1,
>   	.get_rptr = sdma_v4_0_ring_get_rptr,
>   	.get_wptr = sdma_v4_0_ring_get_wptr,
> @@ -2482,6 +2484,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_page_ring_funcs = {
>   	.align_mask = 0xf,
>   	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>   	.support_64bit_ptrs = true,
> +	.secure_submission_supported = true,
>   	.vmhub = AMDGPU_MMHUB_0,
>   	.get_rptr = sdma_v4_0_ring_get_rptr,
>   	.get_wptr = sdma_v4_0_page_ring_get_wptr,
> @@ -2514,6 +2517,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_page_ring_funcs_2nd_mmhub = {
>   	.align_mask = 0xf,
>   	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>   	.support_64bit_ptrs = true,
> +	.secure_submission_supported = true,
>   	.vmhub = AMDGPU_MMHUB_1,
>   	.get_rptr = sdma_v4_0_ring_get_rptr,
>   	.get_wptr = sdma_v4_0_page_ring_get_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 53a8df4b030e..a8d49c005f73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1690,6 +1690,7 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
>   	.align_mask = 0xf,
>   	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>   	.support_64bit_ptrs = true,
> +	.secure_submission_supported = true,
>   	.vmhub = AMDGPU_GFXHUB_0,
>   	.get_rptr = sdma_v5_0_ring_get_rptr,
>   	.get_wptr = sdma_v5_0_ring_get_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index dcc622e18d45..824eace69884 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1687,6 +1687,7 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
>   	.align_mask = 0xf,
>   	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>   	.support_64bit_ptrs = true,
> +	.secure_submission_supported = true,
>   	.vmhub = AMDGPU_GFXHUB_0,
>   	.get_rptr = sdma_v5_2_ring_get_rptr,
>   	.get_wptr = sdma_v5_2_ring_get_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 7bbb9ba6b80b..6c9d5cde61c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -1910,6 +1910,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
>   	.align_mask = 0xf,
>   	.support_64bit_ptrs = false,
>   	.no_user_fence = true,
> +	.secure_submission_supported = true,
>   	.vmhub = AMDGPU_MMHUB_0,
>   	.get_rptr = vcn_v1_0_dec_ring_get_rptr,
>   	.get_wptr = vcn_v1_0_dec_ring_get_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 319ac8ea434b..8cb2124405f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -2007,6 +2007,7 @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
>   static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_DEC,
>   	.align_mask = 0xf,
> +	.secure_submission_supported = true,
>   	.vmhub = AMDGPU_MMHUB_0,
>   	.get_rptr = vcn_v2_0_dec_ring_get_rptr,
>   	.get_wptr = vcn_v2_0_dec_ring_get_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 1869bae4104b..1bf672966a62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1515,6 +1515,7 @@ static void vcn_v2_5_dec_ring_set_wptr(struct amdgpu_ring *ring)
>   static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_DEC,
>   	.align_mask = 0xf,
> +	.secure_submission_supported = true,
>   	.vmhub = AMDGPU_MMHUB_1,
>   	.get_rptr = vcn_v2_5_dec_ring_get_rptr,
>   	.get_wptr = vcn_v2_5_dec_ring_get_wptr,
> @@ -1545,6 +1546,7 @@ static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
>   static const struct amdgpu_ring_funcs vcn_v2_6_dec_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_DEC,
>   	.align_mask = 0xf,
> +	.secure_submission_supported = true,
>   	.vmhub = AMDGPU_MMHUB_0,
>   	.get_rptr = vcn_v2_5_dec_ring_get_rptr,
>   	.get_wptr = vcn_v2_5_dec_ring_get_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 5dbf5ba7d62d..c87263ed20ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1786,6 +1786,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_DEC,
>   	.align_mask = 0x3f,
>   	.nop = VCN_DEC_SW_CMD_NO_OP,
> +	.secure_submission_supported = true,
>   	.vmhub = AMDGPU_MMHUB_0,
>   	.get_rptr = vcn_v3_0_dec_ring_get_rptr,
>   	.get_wptr = vcn_v3_0_dec_ring_get_wptr,
> @@ -1944,6 +1945,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>   static const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_DEC,
>   	.align_mask = 0xf,
> +	.secure_submission_supported = true,
>   	.vmhub = AMDGPU_MMHUB_0,
>   	.get_rptr = vcn_v3_0_dec_ring_get_rptr,
>   	.get_wptr = vcn_v3_0_dec_ring_get_wptr,

