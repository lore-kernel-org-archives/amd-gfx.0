Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3B3C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41F7710E370;
	Tue, 22 Nov 2022 05:46:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91D8110E370
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:46:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGz8cNU10+mT33XuhiS9bcsWNC7monJsqOaMWPY55DacfLKmgYHgwXs1r/dVH99sIlMgEEyktnYgtOzcWzxfeE7kOEQhahTEdNtYKVTJZltKu09Xp1hT3AlL8aK/ICUXNqfEGPGC6ok5toPXQpwVGtEU8m9+3teDbamOsDT2fH/+7LiHGM70Vbgc2Mg2J+c+DNqDsFPN16fpaLsMLP5+3SFxwlar3nEE5PABwsIOoEYF3fBchvncV7mvozNxRmL4SJ27i0rhZ9ODmfxHlDoRQIAu3aTvI+r/tNAhV8QSorqo7XmhWVdC2YVcC/VPkj5dRCI2x4k9X1oY5iCEYHswcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy+yoWV/V/mRYv5eKggGE099VUL+S0FqiY6sEghf260=;
 b=bcLSlqACQiWVhdooFiHJfftx1bOHVVCoIb/O5cbo8YeE/7Qy/BrneNuAmXSKH5TkCv1XzqBNAf+EVE1TNx+fnTaeNjWm7/1IkYQTi96KjQi9haPUuxdjQaK3XEy8jWoDLZH6tnBW59RWjvF9e/arwwj2MkLTmgb5iUlgx3+fagMA22Ue3rJ7j7vGxnlefY0FKGY5LKI3AwywmRTNrlR2Jkc+iAYpLotin+Zr5/XJCW113KzMGBdqawel8huBPD3r2I0+bF2Goe51GolvwHfnzcFEsaktTG2L+HLxEC2dcn17zre7RzWrQUPSBJnLdBy/r+hBWabPinA/w5cGAGcXWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jy+yoWV/V/mRYv5eKggGE099VUL+S0FqiY6sEghf260=;
 b=5OXzckVagiGGGQkVOjgDAw6jffQ5sUMbIPnbRtTx43kNF7vmYVD8KO5KlnjXQEnNwkxZuMmbQVWeuzWBC0/UVdOIQ6vT92qcr8MxZDG+AJC+okPbeB3yw+wq9azzCafIbfKbPPovjvPDjBt1JOvFNJZ+4KHSggAhICfxmuRunho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:46:02 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5834.009; Tue, 22 Nov 2022
 05:46:02 +0000
Message-ID: <507df9df-52a9-f653-c9d6-55b560f7e3b9@amd.com>
Date: Tue, 22 Nov 2022 00:46:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 3/5] drm/amdgpu: Modify unmap_queue format for gfx9 (v4)
Content-Language: en-CA
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20221018090815.2662321-1-jiadong.zhu@amd.com>
 <20221018090815.2662321-3-jiadong.zhu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20221018090815.2662321-3-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::10) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d5bdda-c44c-4e35-1710-08dacc4cd736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m6X2dQUQVFR8gDd+/YRWuPtM9X391KQZzohIDCsZoqxMFDLhYNXcGsQh7hBHjnQApClLfn8M3OFfnQQb+Hy+FvlMoW2PtZVUTLsGhnTxS4xrCvjNITKinGCavNDBTIm3dX9J/IS7E+6JaeS4ekOUtTeBKihoJvv5ZPkphFdSdqGOOkEIgke4fK9K0t46YcvfaTqqPIDz7OYApdlRrsOXga0hF45XlHRGR8bemSKkPFJtdUtSj01JSMsZZvjsCGyV4+a4LhcWbWwd4k3KcbQTGw3mHwk8xyXY1G1E+qF4PmjkZrNE2AEgoLqpU0tsxU8DVNf/HScIAm68/mspf6tqghScajgU2AWxQzMEF5JV9Br1/dRsP5AoF1ZaCaenui8Xg0sqJSFkirFhIf6YUSdI/1J3q8OrDzj8ugbBHe57vfgDtpoKWscLLXCWmhAF2cJqRvz8v8Mzz67PdSRHzD2aob0KGnfSSMaZvNbeEGcGDJJzu6NmHZEL5WA5BLu7EpQEPP+T99S40umJ3FvVpL2K2xaKMmjdL8V9Sxi1REIcLunCy0ebbQF0XjcPjC1wH0WFmDCCy8nZhgUCj+4NYb0c9BXBrYAI+MCFN+/4aNL1EBXnPT+LsjwHJNlrepvFFUH5V6+pxTXlBhrtvNmCbby1H6ihgVBuDMLEodbg3WIh44A59q8GiFcSVilxWujKHJkYST2aUdjqYjDNHUx/0Z8N380a5NHTuzYDUD0TZeQUeJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199015)(36756003)(31686004)(31696002)(86362001)(6506007)(44832011)(30864003)(5660300002)(478600001)(6486002)(8936002)(38100700002)(6512007)(53546011)(2616005)(26005)(66574015)(186003)(2906002)(4001150100001)(54906003)(4326008)(66476007)(66556008)(8676002)(66946007)(41300700001)(83380400001)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0pNbmE2OFNHd3I2K0g1c3h0NnBNZjRMQUdqTmdoVzdPeXk2TVJhd1NKeU9I?=
 =?utf-8?B?MmdxdFJVZUwrMmx4UjZIbGpCQ3FIaGxLNzdRMjJDUDNVRE5NVEd0Q2lHUVJL?=
 =?utf-8?B?RlhtOGNnd05EZFJXZkhuMkpqTWFaS2M5TlgrWmc0ZmZCZmIzQVVWNmZqeXF6?=
 =?utf-8?B?UThFWjBiV29yemJiWUNnbmVvZU9SNUZmaXFGNmx0T0prcmtYS095aERpYUdE?=
 =?utf-8?B?VmFZL3dKUk5sYzl2ZlpHOE9pTzNDUWtUckkwMDViRzZOOXJHUWhhc2M1anFk?=
 =?utf-8?B?SnpYRitmVVcvb0N5MVFKZExwRHJ6dEcxa2Z4Qm9hdWl0SHdvRnIvT2lOQjNM?=
 =?utf-8?B?UDJiSGxyWlNsNS9rWkNCSHVpaThiNnkvSFUvNzFVTTFrQlR1QmYzbHgybjU5?=
 =?utf-8?B?ZmV3c1Nsay9KQUZIMVBIUWRuUHdqRDdxZk9qdk13Q3huczR6MW9IVjVOK1NG?=
 =?utf-8?B?NVpCYU1OcmJia1o5djFGNmhmMVVtMGJrTDFTYzFHT3pKRHZrVVdNMlB3a2Vh?=
 =?utf-8?B?UklIbzYvRG9vRVdBRGZtYjZxQ3BTdHRnOU82YWJmMGI1djdlTUVBcGJ5ckx2?=
 =?utf-8?B?cE5pWUM5KzdLejdFNDN1V0swQ0N6eWhBaG9ScGtkSno1dHROMDFGdEl3UjRO?=
 =?utf-8?B?NFpTS1d5OHQ0YVVNb1JpL1o5cE5VaWFvSzZ6c1dlMFZRR2xVNGg2eGJ4dDY5?=
 =?utf-8?B?UEZtalVpdDJTakI0NTl0SFBtTzUybWdwNDJRMWlQQ1hnMUxBdmtVMmN3dDVK?=
 =?utf-8?B?LzhSSG03NHhpQ2UyU2dubkdZd29CTnpqR0hvbTdndW5XdGFFRzdYYVlXMUZr?=
 =?utf-8?B?b2hSZnY4eWZZTkxKTTJ2ZVRHb050YmIyRFZzN1ZhSWFXQTEySFRrZFdmazJp?=
 =?utf-8?B?Z3h6ZWJ2dzRjNFRIRmsvb3VNM1RacWFwWXJUV0swa0RKcGtTbEl5VnFjU2hw?=
 =?utf-8?B?QUhmc295OXlXSS85MWtta3AyazhyazdIVGNyL0xRZTViaHdMSnRXS0Q0ZGh2?=
 =?utf-8?B?UFdGZGNBREJUUDJzVytwRkIzVzF2VGhTV2dIckRkcXdLL3pqcVg0UlFHcWJi?=
 =?utf-8?B?Z0kwcjkvSDJqYks0b3hWWlV3RTJMYTVYOHljV0dEb05zMXZiRW9GZGd6SjFa?=
 =?utf-8?B?MlFmVHBacFd5NlBIS04zRkxxbFd1am05aEU4SmVaVzZBK2FTalkzRjBrc3pI?=
 =?utf-8?B?MVMzRFZyY1VYMDZtR01tRVdPdHNvMmJSbzZSYVQrSHppTlY1aVYzRFo3SER4?=
 =?utf-8?B?S1B3K0pwZjVBSHd6WDRaQVRDbFdhQXNOempjVGpKN3MyNVhEdjd3S0JSa084?=
 =?utf-8?B?dW1FQUJIZTVLb2JiNjRackc5cllUWWdtNjR0eXByTjhORlM5SFlHUk4wWGVF?=
 =?utf-8?B?R0REaXhGY3A5S2dvODhOTGdDeEExVCtKQkNobUIyUm95OGc4enFIZTZTaVpD?=
 =?utf-8?B?R1lMMGQ4L1M4Z0FncElVZnU4MlFkT2h2QzJyM09aUGpRYWxpdzBHb2ZPejlm?=
 =?utf-8?B?TEhOTXpRWWkzajVodDBTN0ZuVVp5NWRHNXBUeTE4TXk1QUFOMklZeW9nay9o?=
 =?utf-8?B?VmNVNTdVaXlDcHU1MlVkbDMyb1dRa0dleS9SbXhLRTRsbnEzSkI5c240ZURT?=
 =?utf-8?B?dGt5YTI5Y3Azb1I3cHFpS29KRDVOZndCQzNnM2pqOVdGY3R0empwbEVnYXFW?=
 =?utf-8?B?NnRTVUlmM2tndjB1UjRmZHNKK1IyS0V5TnRCekJqdUFMQlJKWmd2Mkk3QjRs?=
 =?utf-8?B?RC9yUkhqR0FuWnlZdUNESVI5c2xZVDlYT0M1ZW84WHV3UGVCSHVISVR4T3pC?=
 =?utf-8?B?ZmEvcnNGQU9OK3BoTFE3Nkk2TEhSTTU5MHJCcWhheGVJQ0dxdFhoTkN6aU93?=
 =?utf-8?B?SDhRU3dYZlFRa0hMdVF0YnZLa2JkNDNZUkNKQ3VzemRXUDdzemZ2REZPMFZV?=
 =?utf-8?B?R2pYV2E2cVlUNlRpZWY1NUR5ZEJkNjdlWGZxbnNQR0pTbGpYeWtlNXVPdzdX?=
 =?utf-8?B?emJPazFkaWRDVjZhWFhtY0o3QmhWZEZyS3dqQ1g5dTVkakdMNzNGeHNnZ0Q4?=
 =?utf-8?B?MUl6bnpNRVIwWFUrcWtNcTNncSs4YWZqWUJCcXJxN0JiUHV1OTFJc210ckx3?=
 =?utf-8?Q?2UBNnwgKhXpI7y3X5DdqRW540?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d5bdda-c44c-4e35-1710-08dacc4cd736
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:46:02.7667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvZDhGTRrs0/SqMU5TRK4pHV51fyQoqHkB3QmGUiPotuUAivPVDE9gMp4E1cxNrN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359
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
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-10-18 05:08, jiadong.zhu@amd.com wrote:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
> 
> 1. Modify the unmap_queue package on gfx9. Add trailing fence to track the
>    preemption done.
> 2. Modify emit_ce_meta emit_de_meta functions for the resumed ibs.
> 
> v2: Restyle code not to use ternary operator.
> v3: Modify code format.
> v4: Enable Mid-Command Buffer Preemption for gfx9 by default.
> 
> Cc: Christian Koenig <Christian.Koenig@amd.com>
> Cc: Michel Dänzer <michel@daenzer.net>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 181 +++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/soc15d.h      |   2 +
>  3 files changed, 155 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index f08ee1ac281c..e90d327a589e 100644
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
> index 8d4fbc9e3fc0..01ec0551d26a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -753,7 +753,7 @@ static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
>  static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
>  				struct amdgpu_cu_info *cu_info);
>  static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
> -static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
> +static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume);
>  static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
>  static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
>  					  void *ras_error_status);
> @@ -826,9 +826,10 @@ static void gfx_v9_0_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
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
> @@ -5369,11 +5370,17 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
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
> @@ -5428,17 +5435,23 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
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
> +		dw2 = EOP_TC_WB_ACTION_EN | EOP_TC_NC_ACTION_EN;
> +	} else {
> +		dw2 = EOP_TCL1_ACTION_EN | EOP_TC_ACTION_EN |
> +				EOP_TC_WB_ACTION_EN | EOP_TC_MD_ACTION_EN;
> +	}
> +	dw2 |= EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) | EVENT_INDEX(5);

You can pull out EOP_TC_WB_ACTION_EN, as it appears in either conditional, to look
something like this:

	if (writeback) {
		dw2 = EOP_TC_NC_ACTION_EN;
	} else {
		dw2 = EOP_TCL1_ACTION_EN |
		      EOP_TC_ACTION_EN |
		      EOP_TC_MD_ACTION_EN;
	}
	dw2 |= EOP_TC_WB_ACTION_EN | EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) | EVENT_INDEX(5);

Regards,
Luben

> +	if (exec)
> +		dw2 |= EOP_EXEC;
> +
> +	amdgpu_ring_write(ring, dw2);
>  	amdgpu_ring_write(ring, DATA_SEL(write64bit ? 2 : 1) | INT_SEL(int_sel ? 2 : 0));
>  
>  	/*
> @@ -5543,33 +5556,135 @@ static void gfx_v9_ring_emit_sb(struct amdgpu_ring *ring)
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
> +		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
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
> @@ -5579,9 +5694,15 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
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
> @@ -5597,8 +5718,9 @@ static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
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
> @@ -6925,6 +7047,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
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
