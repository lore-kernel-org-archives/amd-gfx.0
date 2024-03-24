Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29084CD11BF
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Mar 2024 10:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9087310E0D3;
	Sun, 24 Mar 2024 10:16:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b="ZTfbJXAC";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 861D010E0D3
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Mar 2024 10:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711275406; x=1711880206; i=friedrich.vock@gmx.de;
 bh=Uv2xrSKLBWumOo0xmtFmjYxfCZKunA5KsNLFy+qRAU8=;
 h=X-UI-Sender-Class:Date:From:Subject:To:References:In-Reply-To;
 b=ZTfbJXACVXZCxxCshJ8UKNvAUfQ1b+xrG4zDRtxSF1s5CCQ7VlBFGJd2tstEMcOj
 X/YL8YVmwXeeUFhpI92IDYI52TdcAX2Wz0vwDYJOfVfhz05SJJtE3ymV0gjIBsbJq
 4ulS6uVcRK+qGB23I+rbNPoiaOrY5lyR+C2Cf5cFQ9/x9RtdZgjlBL67rQpUZ6gBV
 0mGsqrwCsteoNyNantHeIX1Vl8fErUr8pVY/0KV3BU9gfR3DnK0Uz6YByEeFw6O+C
 NLMyPmJ1YlBLA1RP9vw03LgXbMyOlXY6GP0pFiyoBVIa9xuHWVigzi0oZtb5mavnQ
 2IhTZwhTyeWfkTkJ4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.177.3] ([213.152.118.97]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBDnI-1rbdrc2ph8-00CfL2; Sun, 24
 Mar 2024 11:16:46 +0100
Message-ID: <7eefc428-16b7-4f88-a99b-510203a244f9@gmx.de>
Date: Sun, 24 Mar 2024 11:16:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Friedrich Vock <friedrich.vock@gmx.de>
Subject: Re: [PATCH] drm/amdgpu: always force full reset for SOC21
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240324005220.2649840-1-alexander.deucher@amd.com>
Content-Language: en-US
Autocrypt: addr=friedrich.vock@gmx.de; keydata=
 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
 f7+xmX0X3AMtWz/15Y+7cPO2
In-Reply-To: <20240324005220.2649840-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4iqelcZzFFmOLavcE4bMr4uHAhpmowq3A/qGggG/Bf3aUY9o93U
 5k49nlQTZjBu8KL88FSgQXRZsaRnfgC5DCHUzSinaq+v1kAyr25z5bbJ672PiAMtnboKbae
 zHy/gXRS1yrAVpNuO9huEH6fEX8C0Lqey+WX16J/4aiHoCcVRgALbVpx8EqUyvoNaf4hrYx
 PWiG/NFFmg4pbZO2Dk2bg==
UI-OutboundReport: notjunk:1;M01:P0:1r0UFarRzM0=;p9h98voZcDIpfoG96GtgsWqjITN
 vosKXNT/6ConNRbKDSk6dBukJZ3wNFJpucFKlSBq3zwFsh7HhvCX4viCnjFOauj89biD7XMiu
 iT3web2hpvDeuL4QnHnVV/APvRAyuZ/Fj472ANuI2H13ev2T7B2irM8GdVi5leR9U4im+vS6i
 vKqkpV4CJHh6pHikq5Vh71+cYqq5MSR6Ni/qguzdw9C4afH9A+bjfHSuLKCA4uAHq3FjJ0UZE
 5naG7A7ncwXXBQ0oH/2eV2ckBMSDJLHYp/jAPM0wDR2d8VCKfvscuZp7g2FVmZjlsSy0z6hTC
 HBNRXCjVNxdykOLIan+9LvgXWnZo/4ylapspz0WanJWjYfNVltIWCKa1BSOoqhp0wn6hNhEJ1
 QO9HumMnkP1ak0epMc8GB5uVk5fHHcw2ARna8FZnOm09wTk+NGjtXuwGX5qaX8JgbeJEPClpa
 b2apOfIpsbk+X1LipEIF5zAFMOSq675MLyMVnLITzWjIzNH8l7Kfna/KwlHU6PihtAbsQJ818
 8LLrsKPLd4bccqF0rCH62o9bn4wkdpMh1arCpUQOVxzceFBLnLMLjwXaNHeQHS2flhrwwMy7C
 9vfyBN2c6c6dBBiN72CEdW59QhCImpufoQ4XSboSoTDQCgd+cmmoCrfQLbSu/woFze9CHIS8o
 aN2nf3oks1AV2j1sqtpvOdf80xtQKyADSvmi15iuuhZTLSPmARzdrMQ/owFjJvYx0KMU/z1S0
 J7Rgm/5nh6cgbyAg7SsBQsIb9d+2q0n8aCMhgF028raipXU/rzAy12Ud5ac6Li9AJokqP8Qqr
 kRbXlqq7f0Sa8mps4Cl3c3Ht0fy9dccWWJoDdjlSUbaBI=
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

On 24.03.24 01:52, Alex Deucher wrote:
> There are cases where soft reset seems to succeed, but
> does not, so always use mode1/2 for now.

Does "for now" mean that a proper fix is being worked on/will appear later=
?

Immediately falling back to full resets is a really bad experience, and
it's especially catastrophic when only MODE1 is available.

Of course, soft resets succeeding but leaving the GPU in a faulty state
isn't acceptable either, but I think it's pretty important to keep the
ability to do soft resets if at all possible.

If it's not possible to wait with this until the proper fix is
available, I hope that at least it can be reverted soon.

Thanks,
Friedrich

> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/soc21.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/am=
dgpu/soc21.c
> index 581a3bd11481..8526282f4da1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -457,10 +457,8 @@ static bool soc21_need_full_reset(struct amdgpu_dev=
ice *adev)
>   {
>   	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>   	case IP_VERSION(11, 0, 0):
> -		return amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC);
>   	case IP_VERSION(11, 0, 2):
>   	case IP_VERSION(11, 0, 3):
> -		return false;
>   	default:
>   		return true;
>   	}
