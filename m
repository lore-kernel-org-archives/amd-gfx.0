Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD1AF9EDF3
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 14:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C032210E9FF;
	Wed, 22 Apr 2026 14:57:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=m1k.cloud header.i=@m1k.cloud header.b="Y53GpBYu";
	dkim-atps=neutral
Received: from mail.m1k.cloud (mail.m1k.cloud [195.231.66.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A7510E9FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 14:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m1k.cloud; s=mail;
 t=1776869845; bh=RsYctNpsC4nxMdaj9ikRZqGuVJbd4ptvSoDsD2AxxiE=;
 h=Subject:To:Cc:References:From:In-Reply-To;
 b=Y53GpBYuymew0wwuI+U97+tacP7RMgwdcWKMv78UuU9ueRMDWaU008sVT8J9Qz4HE
 EfKOrUkLCommfSps99Xj9aC2jQAdUji6omr0PouoU6mLdMv+GHW0Q5rA5LoYQlXIAa
 Z6+Na75YDOmS1W9wwq5IIsoql1KsXo8Zt+WNbvhxgBsmVPEZcBYh6SdP3rR3snUQPB
 +/9GxwenRL/IaXzSoM2W2RSTNABBYaV3OnO/JpE1E73/VmLA5U3w2n19rtUvWpgUeX
 PDs6QuggC0Ha3qSwCm4m8sPn1wYrQ9FQGOtZQ61o9vU//0qEgPNQnyu/QNVnzkw1xg
 XtqP4UhN9UPNw==
Message-ID: <0cfcfbd8-7d6d-40a4-9481-8e808046ce39@m1k.cloud>
Date: Wed, 22 Apr 2026 16:57:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Leo Li <sunpeng.li@amd.com>, Shengyu Qu <wiagn233@outlook.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, siqueira@igalia.com,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <TY4PR01MB14432450DA5BDEFA272476A2F987FA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <49434297-d6e8-4eaf-b4c7-ce14134d7869@amd.com>
 <96f4df42-2675-4bda-b0f2-753b09f7a80d@m1k.cloud>
 <ca869a77-4bdc-47b7-a8f3-788224be48be@amd.com>
 <fdb2d4ad-10e5-43ca-92db-f1dad48b7890@amd.com>
 <c4cae811-e3a4-4aae-8501-6de0977566a5@m1k.cloud>
 <6e1f5a30-82c3-4872-add3-7d46a266c37c@m1k.cloud>
 <6ac9fc7f-0493-446f-97e8-760a54e209d8@amd.com>
 <7fdc3c4f-c321-48f5-93f9-17a1a8ded9f8@m1k.cloud>
 <1356e93b-af76-47f3-afc5-29535a9518bb@amd.com>
 <aa3891fb-ed89-48e6-bfb8-86e704447a2e@m1k.cloud>
 <51219a7b-eeec-43f2-a335-06710809415c@m1k.cloud>
 <7a148774-3364-4ce2-9f55-2e77889bfb53@amd.com>
 <a8a3d8d1-ee55-4fc0-ac98-45d70ad0bd6a@amd.com>
 <deb792f8-70a5-41f9-bcf8-1425994aad14@m1k.cloud>
 <4e48ec7b-ac73-4637-9e42-9c328067ed72@amd.com>
 <TY4PR01MB144321DF5415AC90AC7C4E34898212@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <426dc28a-5351-4a15-a80c-ed6dea9c910e@amd.com>
Content-Language: en-US
From: Michele Palazzi <sysdadmin@m1k.cloud>
In-Reply-To: <426dc28a-5351-4a15-a80c-ed6dea9c910e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 4/22/26 16:31, Leo Li wrote:
> Hi Shengyu, Michele
> 
> I vaguely recall that restoring the old 5s vblank off delay helped alleviate this by allowing idle less frequently.
> That may be a better bandaid for now.
> 
> Let me know if the below patch helps, we'll merge it if it does.
> 
> Thanks,
> Leo
> ---
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3fa4dbda4517c..ce5063928413c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9511,9 +9511,21 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
>   	if (acrtc_state) {
>   		timing = &acrtc_state->stream->timing;
>   
> -		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
> -			   IP_VERSION(3, 5, 0) ||
> -			   !(adev->flags & AMD_IS_APU)) {
> +		if (amdgpu_ip_version(adev, DCE_HWIP, 0) >=
> +		      IP_VERSION(3, 2, 0) &&
> +		      !(adev->flags & AMD_IS_APU)) {
> +			/*
> +			 * DGPUs NV3x and newer that support idle optimizations
> +			 * experience intermittent flip-done timeouts on cursor
> +			 * updates. Restore 5s offdelay behavior for now.
> +			 *
> +			 * Discussion on the issue:
> +			 * https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
> +			 */
> +			config.offdelay_ms = 5000;
> +			config.disable_immediate = false;
> +		} else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
> +			     IP_VERSION(3, 5, 0)) {
>   			/*
>   			 * Older HW and DGPU have issues with instant off;
>   			 * use a 2 frame offdelay.

Hi Leo, Shengyu

Yes, this is effectively one of the possible workarounds I've already 
validated and tested earlier without incurring in any flip timeout.

You can safely add Tested-by if you want.

Tested-by: Michele Palazzi <sysdadmin@m1k.cloud>


