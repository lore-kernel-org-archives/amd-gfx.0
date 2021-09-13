Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2166C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 09:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AF26101A
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 09:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89AF26101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 093DC89D5E;
	Mon, 13 Sep 2021 09:06:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75B8E89D5E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 09:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdl+iRIqY4TTUzOgAhEmdAnzgA0wBx5Isy5hxnR+eFXdetekRsgT1tgVgQLvxxJ3xyhHkTnPEU5zzc7fFyKLJvOHzvRB4PWNAED3CLqsMwYViPhI7YQHZRRV/aOzOgzHj8egdDDvzWYLa+6HlGTup0QYpigbMiNlEnoS5vGspijTJLQmcp49MxJHF6O3L1cDN5Xmh0TXoXJUBaZ6dxPLT+RxkQ/Dd7Uh493fMJEGS3e15BdDoNBVdNXAWGtc8D19twjBsOQtSn8yvPH8lkaq2N29WrX1OohBmV1+wMaSnj/qhub5GAZ3bCEQq14cpZxO8nfl5nF0+F26hVrKquMGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=yqe4Drs/coQrYYyvcJ+wEQ/avqY25RGBi7lyZ0W0YNU=;
 b=oOP+TuP53OQGudUi4M/+/dhgFTuKN+e3hUBS3bx9Hkq8NoRLt0S/gMwqJnJedHQG4rv8BXKPU7zzxTYxRB6kyEPPvcyVuj3rOoShpwr0Q/vZbEWywYXnFGfxmn7uVObGSo7QBU8EUnQDjKYRkUB28gWAgHrgJ2oaUHbYh+xjgYfnJQCVee5M0kQeTDzYknuFDzonaki0fRTcM8tU+AmcdZaz5wMh3NOtp1h9a1+6Q/W5WA7wLcJA6laa2eVToS6rsw+Wn3kK0tHvifD+1UU7sieSkOFCvwqLVcsItGEg/1/2m8BFw9CHHTN91Cq1PpJw/B9WUXCEUvlTvUdP4x01EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqe4Drs/coQrYYyvcJ+wEQ/avqY25RGBi7lyZ0W0YNU=;
 b=yvvGNnlaxfQ6GclPeDpKJE7kWV2m4Zctu86RPLVtuVVX6mw9qY1jhV70ekHFsIf4RTzMipFX2P8eM5sazKZWSuE5kMuNH4zvDrZTNpSoP44HcRJTiEtGkoO+Icyg38/ssmt7KwvG4A8ptzNv/PMFdRqapIHh+W6PpcKkgca8Vq8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BYAPR12MB3221.namprd12.prod.outlook.com (2603:10b6:a03:135::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Mon, 13 Sep
 2021 09:06:10 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::1d09:e72:91fd:ef05]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::1d09:e72:91fd:ef05%7]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 09:06:10 +0000
Subject: Re: [PATCH v4 3/3] drm/amdgpu: VCN avoid memory allocation during IB
 test
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, leo.liu@amd.com, James.Zhu@amd.com
References: <20210913084253.241955-1-xinhui.pan@amd.com>
 <20210913084253.241955-3-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <829fbf36-6642-5b93-5629-685f97a0297b@amd.com>
Date: Mon, 13 Sep 2021 11:06:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210913084253.241955-3-xinhui.pan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0077.eurprd07.prod.outlook.com
 (2603:10a6:207:6::11) To BY5PR12MB3764.namprd12.prod.outlook.com
 (2603:10b6:a03:1ac::17)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM3PR07CA0077.eurprd07.prod.outlook.com (2603:10a6:207:6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.9 via Frontend Transport; Mon, 13 Sep 2021 09:06:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdc0c7b3-f0f2-4fda-acb6-08d97695ba6d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3221A670E91B5D861CDC694283D99@BYAPR12MB3221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:181;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USVjSqpdvhZ8uFw0gKxaWIPSJJ2jGxqDqDwrZEqSVT3N2BrssgZzENBFbv0F+y58V1PcnrLeFnXrj0OpEN1TsPpf+iYmbIfLa0aJg+BdSs+ScoRX4KlrRFMam5RW75n4QTKnS6TX3bU6mvYPPEYzRBEcp/772XblaPK5XGxydsfVvOKmsi43WRzMNzrGHkJjnLu0pwuGOx6d9nuWOGg4QDX5A8yHrEFqL8wBxikR0T2QdB57q73lhGbBJX8HKkIhEQIQopaoxmZ0uJR1ykCqS68Y6jV8QbwiXAAundjftlXTBA9Eq45dF7Z/DmCmz2rcoy+6Ofb5aRUE+bwT3vsBu9WTnNtR17sTFY2tAr+jOscizoBW2Cbc6V2WcmTYR15jxut3Qs6Cw+fONZ6axUy+x+XlLoABQUDHAKUkQyQVpgz9IAYAnoO4rFzaRUIA2I+6xSN7Sk7UY5RV+ppdOJi6vdiXKgCggweAbLv5Cwrw+StP1i7goRqRW6MnRl7qDuVTlQXqLE8zgb8VUiS6D1Cy+TBVKFBe9tSW6ug9JCskPOZPgmlfHecEW9W3svB9FGmu1NPL7foeAbDc/z8RPBUHE20BSSwEgyJK2/+bftYgj6eXFZ9QhrJwPRI8Qycpfmw318DLTb1ZXwEC/XUqxkoRW/OtF3DRhx3lTPdyi2qS6skXyGivOkEDSwG9bREIru7nhNJE0v+K+jDMsWdCIIqsfePXHh4s2QcUO4u38O7W92xCA3giv9c7jI/0VYTkE0JL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(66556008)(66476007)(66946007)(5660300002)(6666004)(316002)(6486002)(38100700002)(8676002)(31696002)(86362001)(2906002)(83380400001)(2616005)(956004)(31686004)(478600001)(26005)(36756003)(186003)(8936002)(4326008)(16576012)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWFienMrS0szWnVRREtodVRoWHdaTmV6Q2xHc2kvc24vVzJZNkt5eU9teStm?=
 =?utf-8?B?eVVhb0taZU5teThYWDByS0l6enVvY0dCZUdpWHB2WEI3R2JwNERPUUM5bU5D?=
 =?utf-8?B?UkxFSmNQcXZkMFc2V3dTQTM2aDRHQStWRmFrTHYyZUxpdmtBVnhlbzJ4WGJP?=
 =?utf-8?B?ZWZrOVNJNC9VczY4YU4vVFR3ZTEzWDFRV3FjMDN5WXlzTWlQZks3T0xKTHpG?=
 =?utf-8?B?RU5MYktkT3FSczQ0NFdDd3NTbzNLZ2tmRmRCdlBVWnlhbE0xR3hGcWROZmxR?=
 =?utf-8?B?WDdEODg1TXZzVUx2WnFZenNrWmw1R255OGI5OGoxTnpKOVFJbDBXWGdMa0hu?=
 =?utf-8?B?SDFrWWNQOEN6bkJaa1lIK3RwNTZQMFZtOGNSOTVWaXFPMzZqUGlUL2s1V0lp?=
 =?utf-8?B?UVlkUmR6NTlDc2g3dHNtdTBBUHZaekxSY05lKzBYVXBjQ21SWFBHUGFOZUUw?=
 =?utf-8?B?amE3Nzh5eWRWMEpoUXY1L2tHb0xoNzVMdXp3dXpaNE5JQTZENklTTEEvRHl2?=
 =?utf-8?B?Z01nSE0vanR3WTlHSEdxYmVaM0Fudmp4b1JNRk9zWmdiRUo3RnQyTDkwLzYw?=
 =?utf-8?B?TTFsVW82cy82eXRnWDNJSFQvTGd0VXA1bUgyM1RJaXBNZzR1QnlPc21iSm52?=
 =?utf-8?B?VWlmd0FWSE5wbk0rNVNwVGh5R2V6dGNFazkzK25HVXVqSXl4OEwxMkQ4bk5o?=
 =?utf-8?B?ZUk4SlgxNjgwV1N6Mzc5R1VUMHczdTdrVnZRdlNIVXVyN2dFOFFlazd1Kzc5?=
 =?utf-8?B?RS9mdTVhNTNkTENTR2k5ZzdTbjFQZjFrWi9jcW5aVDdISWVjckRJQWVTblZn?=
 =?utf-8?B?R0NoSnZPY0daRlRodmU3aXdQOWQzSjZERXVlTWU0Ryt3VnN3WXpNcUFEN2lQ?=
 =?utf-8?B?Ync4c1M0Nnh0UUN1WlBibmU1K0w2RDF3RmtQUml4NjVLWncxSVh2YjBCOWxY?=
 =?utf-8?B?ZjhHemkrVjNha28vdTRWUE5RaWNXSlVEREd2U044VmNIaW9CYmMxdlI4MXhl?=
 =?utf-8?B?NzduYVVuM0p1eEpiSXpPN2ZpNWNqdytUVUVMVW4zNzUxN0ZJakkrOXRaa2F3?=
 =?utf-8?B?YW5rY0ZSOHlFYUswU0taTUxxWXl4UEl0Tm5USjBFNHVuZE9SeXVRY2JXTmRE?=
 =?utf-8?B?dC91Wm9rVWhaUVUrdWVhMHRsTEtrQWM0emYrbmpBTmt4SnJ0T0s2UkthRlI5?=
 =?utf-8?B?SE1nb3V2MFRiRFpkQ2tGRHBtY1hsMDFmQ0hVcCt4d0dsR0NSRmlJRmR0ekhN?=
 =?utf-8?B?cVIwR3ZIQUwvYS9iZEQzb1A5NXJiTmNlck5vRkF6THBteTEzY044WnBzeExL?=
 =?utf-8?B?dkd6cHZacjhKQVI5ZnVLRkg0aExYcFZ5L0hTRkxWSDVlZU9xeVUvYlFNbTlH?=
 =?utf-8?B?WTU5L1U2YVVNSzF0SEVhOGhod1JrMmo2emRWbDRWZ2s4Mmg2cFRSaXJHTnRm?=
 =?utf-8?B?elpnWGlTczU1QVUxdWVKSmFzYnI4N01zOUR0b1pTTERPM3lMQVBiM0JCdG5B?=
 =?utf-8?B?aG9wUURvOWZmN05aTmdnVDFzcHBDUWM4bUlFWVdsRmsyWllMWm5oSnJMdlZz?=
 =?utf-8?B?MFQ0em9KMDdvYXVqcnFqbU9XeHNVRjRCT0dIRGJJdTVYdEdXRlR4M3kzVkE4?=
 =?utf-8?B?K0E5UzVGU1lXRUNSa0xCeEJ3WnpwVEQvREdvNEFGcE0yelVEcTdyVHNPeVRS?=
 =?utf-8?B?WVNraTJuejBHOVNVRzhFeU1lMDZhdFZxL2FHSmVxZTQyOVg2QXU5WGtlalZG?=
 =?utf-8?Q?IBONBPSWs6hzEVNWIQeVlKGCTXHta/Wzbau8dSd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc0c7b3-f0f2-4fda-acb6-08d97695ba6d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 09:06:10.1269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cifhlNLr9KWWqlByQeS1xdsBLy9Rch7Xf2SaQNWCF3YCV28KGf1lMMTU9oQ7GOkv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3221
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

Am 13.09.21 um 10:42 schrieb xinhui pan:
> alloc extra msg from direct IB pool.
>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> change from v1:
> msg is aligned to gpu page boundary
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 97 +++++++++++--------------
>   1 file changed, 44 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 561296a85b43..b60b8fe5bf67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -541,15 +541,14 @@ int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring)
>   }
>   
>   static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
> -				   struct amdgpu_bo *bo,
> +				   struct amdgpu_ib *ib_msg,
>   				   struct dma_fence **fence)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	struct dma_fence *f = NULL;
>   	struct amdgpu_job *job;
>   	struct amdgpu_ib *ib;
> -	uint64_t addr;
> -	void *msg = NULL;
> +	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>   	int i, r;
>   
>   	r = amdgpu_job_alloc_with_ib(adev, 64,
> @@ -558,8 +557,6 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>   		goto err;
>   
>   	ib = &job->ibs[0];
> -	addr = amdgpu_bo_gpu_offset(bo);
> -	msg = amdgpu_bo_kptr(bo);
>   	ib->ptr[0] = PACKET0(adev->vcn.internal.data0, 0);
>   	ib->ptr[1] = addr;
>   	ib->ptr[2] = PACKET0(adev->vcn.internal.data1, 0);
> @@ -576,9 +573,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>   	if (r)
>   		goto err_free;
>   
> -	amdgpu_bo_fence(bo, f, false);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
> +	amdgpu_ib_free(adev, ib_msg, f);
>   
>   	if (fence)
>   		*fence = dma_fence_get(f);
> @@ -588,27 +583,26 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>   
>   err_free:
>   	amdgpu_job_free(job);
> -
>   err:
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
> +	amdgpu_ib_free(adev, ib_msg, f);
>   	return r;
>   }
>   
>   static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -					 struct amdgpu_bo **bo)
> +		struct amdgpu_ib *ib)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	uint32_t *msg;
>   	int r, i;
>   
> -	*bo = NULL;
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      bo, NULL, (void **)&msg);
> +	memset(ib, 0, sizeof(*ib));
> +	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
> +			AMDGPU_IB_POOL_DIRECT,
> +			ib);
>   	if (r)
>   		return r;
>   
> +	msg = (uint32_t *)AMDGPU_GPU_PAGE_ALIGN((unsigned long)ib->ptr);
>   	msg[0] = cpu_to_le32(0x00000028);
>   	msg[1] = cpu_to_le32(0x00000038);
>   	msg[2] = cpu_to_le32(0x00000001);
> @@ -630,19 +624,20 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   }
>   
>   static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
> -					  struct amdgpu_bo **bo)
> +					  struct amdgpu_ib *ib)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	uint32_t *msg;
>   	int r, i;
>   
> -	*bo = NULL;
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      bo, NULL, (void **)&msg);
> +	memset(ib, 0, sizeof(*ib));
> +	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
> +			AMDGPU_IB_POOL_DIRECT,
> +			ib);
>   	if (r)
>   		return r;
>   
> +	msg = (uint32_t *)AMDGPU_GPU_PAGE_ALIGN((unsigned long)ib->ptr);
>   	msg[0] = cpu_to_le32(0x00000028);
>   	msg[1] = cpu_to_le32(0x00000018);
>   	msg[2] = cpu_to_le32(0x00000000);
> @@ -658,21 +653,21 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
>   	struct dma_fence *fence = NULL;
> -	struct amdgpu_bo *bo;
> +	struct amdgpu_ib ib;
>   	long r;
>   
> -	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
> +	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &ib);
>   	if (r)
>   		goto error;
>   
> -	r = amdgpu_vcn_dec_send_msg(ring, bo, NULL);
> +	r = amdgpu_vcn_dec_send_msg(ring, &ib, NULL);
>   	if (r)
>   		goto error;
> -	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &bo);
> +	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &ib);
>   	if (r)
>   		goto error;
>   
> -	r = amdgpu_vcn_dec_send_msg(ring, bo, &fence);
> +	r = amdgpu_vcn_dec_send_msg(ring, &ib, &fence);
>   	if (r)
>   		goto error;
>   
> @@ -688,8 +683,8 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   }
>   
>   static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
> -				   struct amdgpu_bo *bo,
> -				   struct dma_fence **fence)
> +				      struct amdgpu_ib *ib_msg,
> +				      struct dma_fence **fence)
>   {
>   	struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
>   	const unsigned int ib_size_dw = 64;
> @@ -697,7 +692,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   	struct dma_fence *f = NULL;
>   	struct amdgpu_job *job;
>   	struct amdgpu_ib *ib;
> -	uint64_t addr;
> +	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>   	int i, r;
>   
>   	r = amdgpu_job_alloc_with_ib(adev, ib_size_dw * 4,
> @@ -706,7 +701,6 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   		goto err;
>   
>   	ib = &job->ibs[0];
> -	addr = amdgpu_bo_gpu_offset(bo);
>   	ib->length_dw = 0;
>   
>   	ib->ptr[ib->length_dw++] = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
> @@ -726,9 +720,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   	if (r)
>   		goto err_free;
>   
> -	amdgpu_bo_fence(bo, f, false);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> +	amdgpu_ib_free(adev, ib_msg, f);
>   
>   	if (fence)
>   		*fence = dma_fence_get(f);
> @@ -738,31 +730,29 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   
>   err_free:
>   	amdgpu_job_free(job);
> -
>   err:
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> +	amdgpu_ib_free(adev, ib_msg, f);
>   	return r;
>   }
>   
>   int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
>   	struct dma_fence *fence = NULL;
> -	struct amdgpu_bo *bo;
> +	struct amdgpu_ib ib;
>   	long r;
>   
> -	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
> +	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &ib);
>   	if (r)
>   		goto error;
>   
> -	r = amdgpu_vcn_dec_sw_send_msg(ring, bo, NULL);
> +	r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, NULL);
>   	if (r)
>   		goto error;
> -	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &bo);
> +	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &ib);
>   	if (r)
>   		goto error;
>   
> -	r = amdgpu_vcn_dec_sw_send_msg(ring, bo, &fence);
> +	r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, &fence);
>   	if (r)
>   		goto error;
>   
> @@ -809,7 +799,7 @@ int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring)
>   }
>   
>   static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -					 struct amdgpu_bo *bo,
> +					 struct amdgpu_ib *ib_msg,
>   					 struct dma_fence **fence)
>   {
>   	const unsigned ib_size_dw = 16;
> @@ -825,7 +815,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   		return r;
>   
>   	ib = &job->ibs[0];
> -	addr = amdgpu_bo_gpu_offset(bo);
> +	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>   
>   	ib->length_dw = 0;
>   	ib->ptr[ib->length_dw++] = 0x00000018;
> @@ -863,7 +853,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   }
>   
>   static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
> -					  struct amdgpu_bo *bo,
> +					  struct amdgpu_ib *ib_msg,
>   					  struct dma_fence **fence)
>   {
>   	const unsigned ib_size_dw = 16;
> @@ -879,7 +869,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   		return r;
>   
>   	ib = &job->ibs[0];
> -	addr = amdgpu_bo_gpu_offset(bo);
> +	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>   
>   	ib->length_dw = 0;
>   	ib->ptr[ib->length_dw++] = 0x00000018;
> @@ -918,21 +908,23 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   
>   int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
> +	struct amdgpu_device *adev = ring->adev;
>   	struct dma_fence *fence = NULL;
> -	struct amdgpu_bo *bo = NULL;
> +	struct amdgpu_ib ib;
>   	long r;
>   
> -	r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &bo, NULL, NULL);
> +	memset(&ib, 0, sizeof(ib));
> +	r = amdgpu_ib_get(adev, NULL, (128 << 10) + AMDGPU_GPU_PAGE_SIZE,
> +			AMDGPU_IB_POOL_DIRECT,
> +			&ib);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_enc_get_create_msg(ring, 1, bo, NULL);
> +	r = amdgpu_vcn_enc_get_create_msg(ring, 1, &ib, NULL);
>   	if (r)
>   		goto error;
>   
> -	r = amdgpu_vcn_enc_get_destroy_msg(ring, 1, bo, &fence);
> +	r = amdgpu_vcn_enc_get_destroy_msg(ring, 1, &ib, &fence);
>   	if (r)
>   		goto error;
>   
> @@ -943,9 +935,8 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   		r = 0;
>   
>   error:
> +	amdgpu_ib_free(adev, &ib, fence);
>   	dma_fence_put(fence);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_free_kernel(&bo, NULL, NULL);
>   
>   	return r;
>   }

