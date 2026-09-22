Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C20C98302
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 22:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01B5410E055;
	Tue, 22 Sep 2026 22:27:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IW959a9S";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B7A010E055
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 22:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbyR1dagWvamg0fXneBvgqozZaCAwqY4SXCfMV55E1GExbdPydZnhynNkVm6pvf9leb8XXAPx2cJ5ummKKjBfoJdEn87ysmolaecbneeQ4QEBJ6OZj21mX0pj3uheG8D/MtVTUfdfk2OfqNt5pMA7GP1vi0Xnu1MbYCpuFjXRIaKMeERsoW+XI3yuPGYWDzQQUIZ8hpgpMUGPgPG2A8PHevpIoe+EduaOmh0C2iBDM3sTrbLle0eyHAsU2n0WNueqUBIHV8BaEL8F9g8aPQxriQJRq4oR14x6r0UG3dMmrsZbZPk59tyJOQzIFFZIQl5Ue0zNTPuuZcZK2/v3XV0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khzBC8VbiqBqgJ2bo8343+wGCRS/deoC6pSNLhcG0nE=;
 b=Pw0LD3tprUoJAwJBjVofm7oaTlSQ+eHOV6sId+hGVfGpEJh3xCWzEnHHXcAEkNW6arCg6jdxlU30VSzEZpfftLaqoRgNkryZO/A15nqfu7AVOLpxpS5PrHasRwZBhVvWyoMQPRWALe9/llzJfOtSLGWJItdT/8G6hPvn9GW2yB55cisRgPrUiwSd+/pyNSKH2q1eyKrNo+102qvkOJ7Bzifj8TqnNqqc/Cv8iRWCNF44U47MR4naTREtZaUFzh+2wXsgi7YZ7/oNs547n8f6vToS6lxzvgqD9pUrkuk9w2wiBMt93nT51zRduDgeJfhiUbK9nYtEWzwTx2jC6aqWUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khzBC8VbiqBqgJ2bo8343+wGCRS/deoC6pSNLhcG0nE=;
 b=IW959a9SMCB9En9bW5Vsj+J/OYc7XBK0+4ud9rwxj9bke4otD19o7XjncoDWF/okOueytv1i3mWtMnFT9jfN3DJZ9EtuygmEiePOPp92wcOFbnRuBD23sjnKCGtkkFjga2IBATZ6dshLaM1aSpOBTpnWrQ9YyDvA4BYbqtcjEDs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by IA1PR12MB6649.namprd12.prod.outlook.com
 (2603:10b6:208:3a2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 22:27:21 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 22:27:21 +0000
Content-Type: multipart/alternative;
 boundary="------------P5lc4Ko048d3X0Ij1lh60M9q"
Message-ID: <020ac50e-e60c-4c1a-9a3b-ad7952cb1944@amd.com>
Date: Tue, 22 Sep 2026 18:27:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Fix BO reference leak in UALink export
 error path
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20260922145653.1207241-1-mukul.joshi@amd.com>
 <20260922145653.1207241-2-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260922145653.1207241-2-mukul.joshi@amd.com>
X-ClientProxiedBy: YQ1P288CA0003.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::25) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d92c510-7ec7-4479-8dc9-08df18f8ab0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|4143699003|56012099006|8096899003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cQbckHnUm4LLminUtKroG5A6V6NZrM8m7OjS2rTAbUeHOqb3lJ2WpKGCEfA/76mKCRnRgYz3MAW/5N9YJEWZbv1fXVvE7t1bI93kOL5W/Xd/Nr3oZLqkyf1uaxaEwzzmd6Q58YmhrDhTmlwhbwVEozm3rSCgW2iGAvFBI7HQWEXKeWDHRjZu1706BzqFNwE7b9reMeW6fg8ot6uCur4i/knhpTfuHYPtdl54imOWYm3eSLMsST8F3of+eFJFa04s3X+AUhC5e7jPMSX2XrHHHWavoQwPgHawqAvM3vivuWxTbO6H0U+BuLZeJ+YTHWdNDoomnH4eDGrw5jvWckhV8FQdBxTawycC11NQ7rCY35pmAFC4+6lpxNhXgOBd3Jzn7hAmLytbZm8+5mHWGQKx0UGwvUR9mf3TXNMABWOLGwhD22bA7KkUvaBu+AwLZfyzKhYvDufP3qWOHqR1s0Kh4syrjY5in4R59pNCDwTgu4iXFBCnSUIKf+Rul7VNtErezFMcEP4SuCOwL5a9DF2VKm51KZShHXguJ6u6nbdWxzCP6CnxS+iEKsL9KVqzvexGQTu69aKM8Y7Lq+mByS2m7+323pwvaInA91ug0cePztrCrnd8CXuCyu9hWTMr9kr8n0tHmqotiUJ/ZlI2a3E3Dp0T8N3cU84LbGIiO2wOGLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(4143699003)(56012099006)(8096899003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vng2RHBzVHRpS2xxNWppR0EvUUJUQ3pwVndMdkk3WThnNFdIdW1MTjZSeTMw?=
 =?utf-8?B?RlBIYUQ2RGtOWDloWkJZam0ycUs0V01lK3hETEo2TEUvSkIzc1dvcUFoZXBF?=
 =?utf-8?B?T3p5ZmZ0eTg4cnF2SDlxWno5VHg1U3VZNDMwLzRHV2VKNXFldkFPWXl1a2tl?=
 =?utf-8?B?YVZ0S0ZCWlU1T21GWjJUWU9JL1lUYkNkQmpTZi9nek5aQWdEZlFVbWRFcUsw?=
 =?utf-8?B?RHNVZUdhYThVYk8zRVJzQ2tkdEp3ckRzQklMSmw0WU1UbWRYTFlkM09oa3Fy?=
 =?utf-8?B?SEErcmlUcnBFdllpVlhScEN0RGN0R3BsTnNlVFlMK0txcE9iU1ZvR1VyK3J4?=
 =?utf-8?B?N2tmSWhyV1k5RWlWMUZMcEQ2K0tCNTV6YUdhOXQxdk83VlhXZURVQTBSNXRM?=
 =?utf-8?B?MXFUeE5raUFQdVRFcVFvVkdzb1VobTl2RFIvVWVxdkxOYTl0UDdaUFJMc3ZI?=
 =?utf-8?B?UFRmRlM1Z2RYZ2RaZnJUQ1o1cmpxU2JiQkxCQnJWMkVSMHVXbXluNEdobWhS?=
 =?utf-8?B?Y2RUQXpMTGNUUHJRY1JWeHBlWk5ZbTNrZTQrV0xHc3VmVVVyNXpORnFoOHFv?=
 =?utf-8?B?Z1BOS2orOUhFMjZ3NHdDcFQzVzdURG5sVDFqTHpaU281Vnd5MXhVeHJwV1lG?=
 =?utf-8?B?R002eE1YL3FiMFJjS3hWLzByeDJsVnNDdlhSajA3cWxKeXFvUXIxSHJVZFRx?=
 =?utf-8?B?K2JFWVBZbldldmZkUm1QWUVSczRoTkd1UFRwZHM3czdvWXc0NVppcGpNeUZu?=
 =?utf-8?B?VnlFeGdlbTdsWXNrM3ZDd3VDdW9ZWU9Vc08xbU9Xd2VGalJDNVY4Z1JlekhR?=
 =?utf-8?B?UlF6ZENraWEwcTIrNHRsRGp6WnlZY0JUUzRpME5mWlhVM01HWFVXZHZia1RT?=
 =?utf-8?B?eGIzdHlKWXZ6blNMT3Q4Q2JCdFBxOHZBSmQ3MDU5U2FvK2hwU0t1Zjk5NXdN?=
 =?utf-8?B?QmhNZzdXRFpqa2k1Z1NpZmRFWEtQbk13aUZPSlU0ZmRGZkEvbzB2eUhYRHow?=
 =?utf-8?B?ajhGQi9oZWlGNjJkR28wQTZGR0VQOSs1aGRxZEZpL0l4NDRYTkJmNmdmd2Y4?=
 =?utf-8?B?YzlBamx6VEQvMTEvcFNROTUyazh1OWV0MERKY2dzSFZrcDY2K3VjSG1PbkRI?=
 =?utf-8?B?Sllrd1JwRmZCVXZpZnN6TTlqVGNWUzl4RkozYjVsM2VKODVsZDRNNWQxaG40?=
 =?utf-8?B?bDhsK1k3T0x3VnYwbzZTV2hkdGJXNHR3Z2szbDFUQVBJWlhaSGk1c1g3R25B?=
 =?utf-8?B?LzJKSTQwUm41OGxxcTFjTm0rS3FEcm03T09qM0NVMjg2eWxwV2pVM3MxajVw?=
 =?utf-8?B?byszRklTVVZGK1JDTVhKcUUzdEhXck5wMW1aY0dlbTQvc0dzS21tRzA5aUhC?=
 =?utf-8?B?a21KUjUySXZyZE5ZSGdLa2l2UUgyaG92bkZ6VXU2QlhsRFU2Sm8zZWRnU3RT?=
 =?utf-8?B?bDZpVmdwcjJJOFNONmRnTmROTVVEdGZ0WWJ5K3I4M2IvdjQ5OHMxdVlSY0hZ?=
 =?utf-8?B?ZzluQWdVOTNyTDVDd0JIRjgwZHBGekZFb21DT3gxNzkrOFE4L0dqaVRXTVh3?=
 =?utf-8?B?cFVPMmpwWExBT2V2eWJyczBNcXpiY2dQTVFvb0tKTzY1RGswWmZHNnhpSTRk?=
 =?utf-8?B?U01PSktMQlBlekpPYndZejNnMTg3UnljMFZoSVgvQ2ErN0hkQ2ExQWlYdGxj?=
 =?utf-8?B?UjRocnI2eDJWSjZBemgxV0txMkRyeDZoTDJjME5hRk8wRitHVDZwZHlkZnBr?=
 =?utf-8?B?VFZhZFc5eHRKYzI5UnZPeGtlZnRqSmd5cldraCtQVlNNM09STUl6NFNyeTNm?=
 =?utf-8?B?NUxocHdxd0NxMnRKV0JWdm5kUGk0WW1FRWFsWHJqcDFVOThlOENyeHpHNFdp?=
 =?utf-8?B?Q2RlWE5hTFdjWWx6eGlKZ0NaaEhQcWMwT0QrTDY4ZWJrQ29lN3ZzR1BrTlpq?=
 =?utf-8?B?bnVhbkY5UFNMQW9hZXlKaksxM1BIYmpzaHBRdnVPLzJudk5CRzA4NHpsYmxr?=
 =?utf-8?B?NHJBTUJ2a1A1d20yKzJUcDFMemxyUFNiR2pvNzlydVV5N1JXaFRuZEJhR1VJ?=
 =?utf-8?B?S1pQNFhXR0pMTVdXaXhNTFkrNTArZGk4WHRTR0xxaUlHMzhHNFNtWlduVll0?=
 =?utf-8?B?Y3RuTklUMjhUNkI4bFFMN1ZrZ3RoNVFPMWVLMmsvdHFSaEYyakpRRHZjZjZB?=
 =?utf-8?B?cDBIMjBBZjNaUTQ1akhaUFkyR0gvNGtJRm9hQUZ5MHk4M1V2RWhDQk5UQ1RB?=
 =?utf-8?B?a3VQcG40a2ptdmNkdUw3ajZFYVpSVjdXU1F3Z1dRa0duVWFSUWVzajI3VGMr?=
 =?utf-8?B?Zlg2WmxJVXMrbmJ5QWxrRDh3WXdaTVE0azlqSmRPM1hMaTBIc0lDUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d92c510-7ec7-4479-8dc9-08df18f8ab0c
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 22:27:21.2601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1h7/hfklkUQcld7KyRgXKCHJ4kG4laMhx84c0YYU8wyPegrD1DkKqqmy2HCBPQcTAeBW2aYwWW4k7G5oPClyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649
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

--------------P5lc4Ko048d3X0Ij1lh60M9q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-22 10:56, Mukul Joshi wrote:
> amdgpu_ualink_export_handle() takes an explicit amdgpu_bo_ref() before
> building the exporter node, and the out: label only drops the reference
> from drm_gem_object_lookup(). The xarray insert failure path unrefs the
> BO, but the drm_gem_prime_handle_to_dmabuf() failure path does not.
>
> Userspace can hit that path at will, for example by exhausting its file
> descriptor table so the dmabuf export returns -EMFILE, leaking a BO
> reference and its pinned VRAM on every attempt.
>
> Fixes: 6b1a5ad90778 ("drm/amdgpu: Implement UALink handle export")
> Reported-by: Sashiko-bot<sashiko-bot@kernel.org>
> Signed-off-by: Mukul Joshi<mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 3d84f5a7a34d..a7ae9ffde1b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -4023,6 +4023,7 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
>   		if (IS_ERR(exp_xa_node->dmabuf)) {
>   			r = PTR_ERR(exp_xa_node->dmabuf);
>   			dev_err(adev->dev, "Failed to generate DMABuf for the BO\n");
> +			amdgpu_bo_unref(&robj);

This would be clearer if you wrote it as

	amdgpu_bo_unref(&exp_xa_node->bo);

Because that's the field that the reference got assigned to and where it 
would get leaked from when you kfree(exp_xa_node). With that fixed, the 
patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>   			kfree(exp_xa_node);
>   			goto out;
>   		}
--------------P5lc4Ko048d3X0Ij1lh60M9q
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2026-09-22 10:56, Mukul Joshi wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260922145653.1207241-2-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">amdgpu_ualink_export_handle() takes an explicit amdgpu_bo_ref() before
building the exporter node, and the out: label only drops the reference
from drm_gem_object_lookup(). The xarray insert failure path unrefs the
BO, but the drm_gem_prime_handle_to_dmabuf() failure path does not.

Userspace can hit that path at will, for example by exhausting its file
descriptor table so the dmabuf export returns -EMFILE, leaking a BO
reference and its pinned VRAM on every attempt.

Fixes: 6b1a5ad90778 (&quot;drm/amdgpu: Implement UALink handle export&quot;)
Reported-by: Sashiko-bot <a class="moz-txt-link-rfc2396E" href="mailto:sashiko-bot@kernel.org">&lt;sashiko-bot@kernel.org&gt;</a>
Signed-off-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 3d84f5a7a34d..a7ae9ffde1b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -4023,6 +4023,7 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 		if (IS_ERR(exp_xa_node-&gt;dmabuf)) {
 			r = PTR_ERR(exp_xa_node-&gt;dmabuf);
 			dev_err(adev-&gt;dev, &quot;Failed to generate DMABuf for the BO\n&quot;);
+			amdgpu_bo_unref(&amp;robj);</pre>
    </blockquote>
    <p>This would be clearer if you wrote it as</p>
    <pre>	amdgpu_bo_unref(&amp;exp_xa_node-&gt;bo);
</pre>
    <p>Because that's the field that the reference got assigned to and
      where it would get leaked from when you kfree(exp_xa_node). With
      that fixed, the patch is</p>
    <p>Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260922145653.1207241-2-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">
 			kfree(exp_xa_node);
 			goto out;
 		}
</pre>
    </blockquote>
  </body>
</html>

--------------P5lc4Ko048d3X0Ij1lh60M9q--
