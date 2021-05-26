Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA70C2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9861E613CC
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9861E613CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 536F36ECC3;
	Wed, 26 May 2021 12:02:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBED36ECC3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 12:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJNMoTULkXYsBfZ6x4cASonW5c2XOs9s/gneh7ZLWJORrGGYYuktjTaWmypCn4JLP+hXDNu6wRJdYB/VGTxFaUE7X7TVnSrrl73r9azC/Dyp7DU92IF8x1yEeK7yj4iGdlPYIdeUAnSehKJ+h+oWKqOmbWG++ce83/shIHx2nF/kNjPAT1E/oNl7KB0MKpiCCZVV7DSTul3f2Jy2cndllBLq/RUCyotW7xySNvUK/Q8MTRsBfNMyqYXJd0Ti+HlgDdBduh690ce1E6ikMvIhFglO6G1oK2T6TxiJTaFBRDXjkmS3Z7Ju40ClotcbQIOAE+M7i/f8WriH+nqa5d7HhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKFX8hobXmcTPMMvOTBHpN4Cl3qqOIsOcrrycG6RLas=;
 b=mz9JGXvBi/Pfx52NpPqCVr5J/uWoI6DmP9nlqPvfKRGtiXHcd1LB2TgmTE7QR0Ewaw99ssS+m1to8TDziIdBRZ1dPs0sHRSWzBe3anE6VK9NycGZZYIX3Iyza9agnfBQlHxOZiTOfxeAu6FdlgCQ7hx5Wl3TTi3uv9Tlr/qh+nPm+0zhQfl0X2vMni1/ty1bM8PebpdOhnu8JI+t4lunV7RKLqqOJPd5pHaUMu8IisN5yQDK+FmNzZXe364PUvlHQyMmw/RUZVmFHF3uJEzhddPj+YboMqDNypFzdeNij9EjVN8p7JVbo/yC1pLE0A2D+WNE+HXqkfcaWGhA3S0qJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKFX8hobXmcTPMMvOTBHpN4Cl3qqOIsOcrrycG6RLas=;
 b=Tv8UavjlfGXI09qKp8M7e64T/rCHNge8RhNXB8wzEvqR1OTNRDJCGUt8IQJA91RekeP2dOVtEcGoWnhtiTvXS3hgqCUKvg1tflIVEIjU+1GttCxLVjIHl1ztXsPT9VQ/Q+b5a6tGXckx79vz+5h2RjJkjfbPDDQzL2XIHbxs5M4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4639.namprd12.prod.outlook.com (2603:10b6:208:a4::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Wed, 26 May
 2021 12:02:42 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 12:02:42 +0000
Subject: Re: [PATCH 2/7] drm/amdgpu: move shadow bo validation to VM code
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210526101027.14936-1-nirmoy.das@amd.com>
 <20210526101027.14936-2-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b166ff2f-1b6f-6d51-db9e-50b15cdaac8a@amd.com>
Date: Wed, 26 May 2021 14:02:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210526101027.14936-2-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:3ecd:562c:67c6:4afe]
X-ClientProxiedBy: PR0P264CA0282.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::30) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:3ecd:562c:67c6:4afe]
 (2a02:908:1252:fb60:3ecd:562c:67c6:4afe) by
 PR0P264CA0282.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 12:02:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbe0d4d7-dfa1-42f4-661e-08d9203e2a56
X-MS-TrafficTypeDiagnostic: MN2PR12MB4639:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4639457C232868B878FCCA6E83249@MN2PR12MB4639.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GcZPxtO3lI4nnSU/tiXb/3bn+bsu+4vyu8sJZTrWDFlAeNBbhT/5azUjsmnmZ8etS0BSR2RdEfNOR2CLk1iHv6vh7ErZ5zSdT9RMZNwgkx1BcqW+ZvjkjG5wdi0OKVgOd9xQSK8M5V7o2L4ak1gt6/wW6SFNoEol3nWMURHLxKaY1G/BTBMk689xrp+SXwHIKPCUS6Ad7GghPeomqdRXVgQkXi6Respj2yKgNfBUNORgWvN0gttKS+gxc00b95nts5VSURLVERg7T+3qkWLDT76O+NdJVx+kHEIpewoV03YlI5wUb/T2sAQoExT6gfe/lAayI/q48UwKZZ0qwoGM831U6hrfANVdOwRgp/0cZTqXDD//AT6WZz+5005SvNA9u+qkGaGoIVHF/yaA12rhN07BeXZCdGJCqYJUl90ssXM9CX+obsIfuAtM8/LzxEU7/2VAjw08y+RqJvmUwar+zxjZ/3fKxRgvJmuPyY1+xv2Hb3/pyWzbbUt02ApfWPKwUR6S3K/AJHec79LYq+w4YCrE7shK2kli2Kl0ZgT7wdMFTEAElWrNB2asmWvVNJ/VMtswtIz5M8ORqvMIv8mfe0+VxL8j/7EF6cLtIBTYccfoW1MWm9efLLumNzhV489iLLbMFV0earizE7aTSzaNrkAD4Ty4C78IMNyDuAamPJVPgJWYkLXM0g6C566tw7Yk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(83380400001)(316002)(478600001)(8676002)(4326008)(31686004)(31696002)(186003)(2616005)(66946007)(8936002)(36756003)(38100700002)(52116002)(16526019)(86362001)(5660300002)(2906002)(6486002)(66476007)(66556008)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dkxHdzRCZ0N1Z2p4ZFdKY0lFdHY0cE5SaHNySmloN3l1TGM2VWNWSk0ycjBa?=
 =?utf-8?B?OGJLUU9IazVWVERHZm9MZEVTVVdlUHF3cmRBY0ovN2JERUE2aE5vSC9SKzFD?=
 =?utf-8?B?a3RaWEFUNnNlM2JYWGlsQUl5dkdvdzNjR2JXNEFCc3l2Z0pVM0dHclZCajVN?=
 =?utf-8?B?Y3kybmpCMDVMVVJUQ2M4TVJHWmpnKy9WdzdxSUdWVjhleUNqSmV3UHF5S0hy?=
 =?utf-8?B?c0ZteDBQY3Z1TVk3YzNrbENmWjY2KzF4S0h6dktUbWJ3SHBOWmpZU3NNZ3VS?=
 =?utf-8?B?VllWQXV1NlB6eVQ5dzhGVzBtWE9yVGZjRXZnUmIrZE9iZmhBdTllcThZaDlL?=
 =?utf-8?B?VCtrTjUybHovTjR2WFh5K2paUFl5M3orRi9CQmRyUVlDd2xmTDF3cUNqWU5Z?=
 =?utf-8?B?ckpwL1FyVHZoVHdzY0RzZGM2aGdTUHdsK2NPRUhqMVBCOFVuRlBaQTBnQlc4?=
 =?utf-8?B?UDlQSGxTSWN3S0dKT3hUNVlqWUNydlJUcEd3UHVLU3A4SXNSSDc0Qk0yaWho?=
 =?utf-8?B?OExCZzlPTWp2aUdlYW5WZmdvUjhKQnE1N0F3QnRTTFNGZm93R093K0w4QXFJ?=
 =?utf-8?B?SVIwd0tXMWIyL0ZZdkZWbE0wRGJKbnovaklQYU56MGVFZ0ZmTDhiSzFIOWk3?=
 =?utf-8?B?MnMzYnJTc3l5VC9OTUM1Slc5UitFUFkrZGdXamxBZGRZZ1pySEI2YnF6VWpn?=
 =?utf-8?B?b3lDTDRVdTlNL0lmcU1LVm5QRW9xUjFDUk1FVDZrSHpJTDhMV21Md1JDdjA4?=
 =?utf-8?B?aDFEbkZHRkZ1Vy9CQUU1eG5RNjhOc2QrYUQzQk1hS29hblZlczBGQkNVWkkv?=
 =?utf-8?B?bXJQS2NPYmZMbzlTam5xVkVsRUlaM2lqdjF3TDVKbGhzK1lRajFub3hsaXJH?=
 =?utf-8?B?NzkvMnEyOEtZRDBpMWkxNG1SZlNpa2VtVGFBWUNMLzlOUHZkVkpRRXBnbVpy?=
 =?utf-8?B?ODZ1Mm1sWU0yZE1vNmpMeHFYWTAxNTRPSXYzOUc3Y1NrUkhZZGp1Z0xzeUtW?=
 =?utf-8?B?U1ZLTllkelNPNG1CckdqcUs5d3JDWjN4UnNsaG1LTFdDTDNUYWVqS2ppQnJt?=
 =?utf-8?B?TGlMWXI3N0V6VFMvRDNMaVBnRHkydTNxc2Z3djhWZytyREoyV2JFcG9FQnll?=
 =?utf-8?B?SkUwdld6M1VwOS9tY3JFRmd0RXJnOXBseno4UFZKckd1UjBzY1VlTE1rWGp0?=
 =?utf-8?B?TExKV1NLSXgyVUFJNk1XWFVZMGlrMHJ2VVBJQXdhekFLWVd4MmR3YXVLVnE5?=
 =?utf-8?B?Ym5WbFNuSzJ6ZEkwOEowcHJhOEUvcDQ2RXJ6cWtXczdDWVB6ODdJU0RFbkVo?=
 =?utf-8?B?dWdJandtM3pjQjJpZTVUaDFyNTZzZjVzUmtuclY5UHYwTkU5ckIzcjBodGxz?=
 =?utf-8?B?czA5WHVuSFlIZ3hHVTdRcllFeEJJV2RWVzVkVkRJV053Yk95YTErMUp6WGYy?=
 =?utf-8?B?QXNjMmhzZWI3a0ZPYmdGL2RiMTNkaEllQmprQy9VTVlja1p3NFZpaVdzTUgr?=
 =?utf-8?B?VWhXbmtyMW5NR0VYWW11NklhenBBdkxKOVZkZHBFTkNhRmJlM3ZnbWR0bnRo?=
 =?utf-8?B?Yzd4RmoxNnc2OHZXSkRXSHl6ZTczZTNPQ0xBaUo4dlRxRTBPNG9TRzlNS05z?=
 =?utf-8?B?NkdmMFFjd1hmdHE2Z21tYkExMXNRZmVMMGdBSTZZSjNpWllnb1BFV2xUS1N1?=
 =?utf-8?B?MUN3dWlXQnJWNDRrdHovTlR0djFsY2JsQ05uNTNqZWNCcURVTUc0YXVXVzM0?=
 =?utf-8?B?ZkRUb3BYK0cxRVBNSGJiam55U3ZGS1krNlVhbklxaUZCeHMwajFTcVJTRHI4?=
 =?utf-8?B?ZEswd3VoVWFWSjNVMENVM1Zhbm0xaWk1K05EVGwzZmk0K3ZhY29MSU4wdGVZ?=
 =?utf-8?Q?pe1AXC06tr0DB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe0d4d7-dfa1-42f4-661e-08d9203e2a56
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 12:02:42.2031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPE8afTbnOVmCxrqkms3V08Mup2DEu+vVRiVcidnEafqZCZ4xnaAlGUe6YdbKZ3S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4639
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.05.21 um 12:10 schrieb Nirmoy Das:
> Do the shadow bo validation in the VM code as
> VM code knows/owns shadow BOs.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 23 ++++-------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  5 +++++
>   2 files changed, 9 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 90136f9dedd6..f6a8f0c5a52f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -396,10 +396,10 @@ void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_bytes,
>   	spin_unlock(&adev->mm_stats.lock);
>   }
>   
> -static int amdgpu_cs_bo_validate(struct amdgpu_cs_parser *p,
> -				 struct amdgpu_bo *bo)
> +static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +	struct amdgpu_cs_parser *p = param;
>   	struct ttm_operation_ctx ctx = {
>   		.interruptible = true,
>   		.no_wait_gpu = false,
> @@ -451,21 +451,6 @@ static int amdgpu_cs_bo_validate(struct amdgpu_cs_parser *p,
>   	return r;
>   }
>   
> -static int amdgpu_cs_validate(void *param, struct amdgpu_bo *bo)
> -{
> -	struct amdgpu_cs_parser *p = param;
> -	int r;
> -
> -	r = amdgpu_cs_bo_validate(p, bo);
> -	if (r)
> -		return r;
> -
> -	if (bo->shadow)
> -		r = amdgpu_cs_bo_validate(p, bo->shadow);
> -
> -	return r;
> -}
> -
>   static int amdgpu_cs_list_validate(struct amdgpu_cs_parser *p,
>   			    struct list_head *validated)
>   {
> @@ -493,7 +478,7 @@ static int amdgpu_cs_list_validate(struct amdgpu_cs_parser *p,
>   						     lobj->user_pages);
>   		}
>   
> -		r = amdgpu_cs_validate(p, bo);
> +		r = amdgpu_cs_bo_validate(p, bo);
>   		if (r)
>   			return r;
>   
> @@ -593,7 +578,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	p->bytes_moved_vis = 0;
>   
>   	r = amdgpu_vm_validate_pt_bos(p->adev, &fpriv->vm,
> -				      amdgpu_cs_validate, p);
> +				      amdgpu_cs_bo_validate, p);
>   	if (r) {
>   		DRM_ERROR("amdgpu_vm_validate_pt_bos() failed.\n");
>   		goto error_validate;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index da155c276c51..f474f15ba344 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -696,6 +696,11 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		r = validate(param, bo);
>   		if (r)
>   			return r;
> +		if (bo->shadow) {
> +			r = validate(param, bo);

This needs to be "validate(param, bo->shadow)".

Apart from that looks good to me.

Christian.

> +			if (r)
> +				return r;
> +		}
>   
>   		if (bo->tbo.type != ttm_bo_type_kernel) {
>   			amdgpu_vm_bo_moved(bo_base);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
