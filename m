Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62845C98318
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 21:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBBD810F7C6;
	Thu, 24 Sep 2026 21:54:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BcBKEbTm";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F32FB10F7C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 21:54:54 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-33e61b947d0so2640eec.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 14:54:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790286894; cv=none;
 d=google.com; s=arc-20260327;
 b=E4P2jiLsqltgT/qBhEOZQ/Jtgk+Q0NZRuVrgbdJvkrWhYXi3DyDZonLdVy8/jHRyTP
 1E4Ka+3535mKWQpb3g7SLSK5FBaXQIdPoeYbZspRNzhLdhXFgOLLdTHt9tqU7RjPWDEY
 XioEAi/BMSg190OKLGicmUu+IrbFfBZLEnrS9DhONCinrNXNdY8aMPUgsOsgJzsReA1g
 ayyEhjv4fEVjmD09xYoHvVVZhw4G/Wof7us3U2nJVed7R7oiAUAbW/76RVi6lo+JrcDX
 eaD2aJ/g/OhXB/dBLW8gRBUjcqtqdd8fHAXp7wlLeqC6kzq8SNw2XzLYVX4b/qbpOykB
 8Jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1oE7svzhEf022G5qCXjn73Iy6aMVX182hm8bk8JwbE4=;
 fh=bO6jBY0Cza84izgABXv+3/ubBnAD67+tMLFu2zVc4iE=;
 b=noLTmQXOqmSicRXVfa+uWEnppXcOq0OrZ0Liulqb0KEu2EmsYLcBaDg/6JZ1EdYnCy
 NVOZCYA/RFfo4lX/f/zhdB26CQq8ct8dHsqFslsq8p1Ld87+gnxIgWCBIneYA/AbH3ix
 aoiOGbzIgnrUuN6xJv3a+Q3ed6+ETgcamM7cj8N9upT8/E9W16NdRkEHMqKkoOpxuQau
 gtio8H5AJXw9pPvVW4fvFXne4d9pzNW9RqhpeY5jkQyQEG0QaghfHro0g/CYSv07ltmW
 VrvFde/vKB5YYCwfCNsAvpynTRd6EPo58kW4E3l0do4GdxxgMtlA4xAVHoJkQfFPC3+k
 Kf3g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790286894; x=1790891694; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1oE7svzhEf022G5qCXjn73Iy6aMVX182hm8bk8JwbE4=;
 b=BcBKEbTm+/R05vMqgI7miRUDd7rPFIf4p4eJpUPnT/W0kfsi+2fov1amGgcDmOXzrt
 ctPoDA9iweHRztVHze7ZptIbN+N+coxLzIvwkx4+sARsWDPzFgXSNvpYgQSLWOuoo/y4
 egeBW2usUysGcmxilJO9MCvn9Lm37Pp4MdHnhc/rPyBHSNEayOVYn7Ywm+2SDZh83W4W
 QTxZ1IBWnZRBIqgCtFiSyF3FeXNXMm+xYtqf8YRyLldf4TYafftcfA9AWvF/sMvDbOCR
 uhyrOtIkGLoFXL0Xgc83xKOOKK8iJRnkZJzXL6DyENgnRlOa3TgT5fqw/giyctgoRFzA
 J//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790286894; x=1790891694;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1oE7svzhEf022G5qCXjn73Iy6aMVX182hm8bk8JwbE4=;
 b=H96FEkZ3prQaf/IrCANxRGMw0DANucbCAZy4T/tKLqyd73HS1sy/ipus4Rw8qRAvFm
 qrmGJET6jNakHLiyAj5JY8L5cul2aA7LR45rLz8DSJnjXUy9RHcqEnsNXxTPOf2Bo4Rs
 eyK31QyGqZMpLvUpOrCxkP6d0m2M+ZPWdOuGEokQHO2dT7imrt3I1BqIQ2ih/o97WRNR
 zfjdwJ1kvOU8PeiBzhoQ8/LTl5/UIsArZcAjDuYCyfjCCfgz4GOnPgvRNlyOx11OCCB2
 OkjyGVAekU6yty6sfX/lqpsx5Xs/kern0itRxnlVGqsU5rE7bXWuDGzbcIRBeeKASIW6
 KbWg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiDpzMc5QaP9drsPSN571SbQymB01bTvFS444SEgJEVVqBcu12xlPCzZWJjCNuB7UuzQFYjESs@lists.freedesktop.org
X-Gm-Message-State: AFuF++nrYHHhQnvgTqteEG1hcJqJW2109E+FSb8ZKjTKdr2spAG/tV+M
 L5O8KTIox2wHyQaJQ/jLH6mse+9ZhzHsJ6q9zrIS30Gz0wKGIQSDyOFlqGwJVwDLRkFIWJeAFM2
 g8ATXzCvWFlGG0WEDZ7zZEUI9JiXrdkc=
X-Gm-Gg: AYBFou1pEoKPmcYJR1GjmRNGd/zoxfrpuALXqDJxysSAZcJZzgNjaaFhSeQtfa78V81
 zGFhiqddTHGIDr+FbTQVl8Mx2By8X0o2GRiA/ASZ6LDHQhuU0L9plf/Bsf4mAGE+n1yE2GNqN8X
 xAm1nUBIsPTbGfmbkpevGAA0pMI5qu56mwaAUbyjKwiVfLfV7oKgpdm1hHOWpf8fzyGk5oVPx0c
 TFDep0DNTrY1StqJ2M6Ro0ULHBlf94MMFMZYAC2FylP6dKxcngMeD2fF+BW/NqJfkqEZTEkDjkv
 hKo1REc2PMwpGBdwbnqSKkq2bkw2bGu06bMsJWsmEetocKKH/R19XAcVIRsLjdkoRT19droiG3U
 cyhrXIkOFv5DdNF9WNlDuoWp1EE3CiZyewoWd6KlfcqDXxQkdYqao
X-Received: by 2002:a05:701b:4287:20b0:139:81c6:67a1 with SMTP id
 a92af1059eb24-145a619c425mr1306344c88.1.1790286894158; Thu, 24 Sep 2026
 14:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_PsKKiOXPuH9c8n0u8viyg0u3rTeDnPoeDBk11MP4V_hg@mail.gmail.com>
 <20260924210523.13214-1-fbeltranmillalen@gmail.com>
In-Reply-To: <20260924210523.13214-1-fbeltranmillalen@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Sep 2026 17:54:42 -0400
X-Gm-Features: AclHuK-ygzQGsSs9ter1Q0JQvd72HzE4_8XQf238sK-jHrHnBZECxiZxUctAWQc
Message-ID: <CADnq5_MAs45uU91Px+6R8MQnkUEgf0s_x-NZexm_KZP6iNTH1Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: reset VI ASIC on MacBookPro14,3
To: =?UTF-8?Q?Francisco_Beltr=C3=A1n_Millal=C3=A9n?=
 <fbeltranmillalen@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
 amd-gfx@lists.freedesktop.org, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Applied.  Thanks!

Alex

On Thu, Sep 24, 2026 at 5:05=E2=80=AFPM Francisco Beltr=C3=A1n Millal=C3=A9=
n
<fbeltranmillalen@gmail.com> wrote:
>
> On a MacBookPro14,3 with a Radeon Pro 555 (Polaris11), the framebuffer
> is at MC address 0 when amdgpu loads after a cold boot, as the firmware
> leaves it (MC_VM_FB_LOCATION =3D 0x007f0000), while the VBIOS ASIC_Init
> table places it at 0xF4_0000_0000 (0xf47ff400).  amdgpu reads the
> location once, at init, so after a re-POST (S3 resume or GPU reset)
> the framebuffer has moved and the driver keeps programming the old
> one: the SMU is handed a table that was never written and the GPU
> does not come back, which leaves the internal panel black.
>
> Resetting the ASIC on load makes ASIC_Init run before the driver reads
> the location, so the driver uses the VBIOS placement from the start and
> every later re-POST puts the framebuffer back where it already is.
>
> Add the Radeon Pro 555 used in this machine to the existing VI reset
> quirk table.
>
> Tested on a MacBookPro14,3 on 6.18.49 with the quirk table backported
> (the kernel also carries unrelated local PCI and ACPI patches for this
> machine).  The framebuffer is at 0x000000F400000000 after both cold and
> warm boot, and the GPU survived 9 S3 cycles (lid close and rtcwake, one
> of them with the lid closed for about 7.5 minutes and a USB-C disk
> attached), each followed by a few minutes of 3D load; no ring timeouts
> or VM faults were reported.  The reset adds about 0.23 s to amdgpu init.
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Link: https://lore.kernel.org/all/20260924132952.25054-1-fbeltranmillalen=
@gmail.com/
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Francisco Beltr=C3=A1n Millal=C3=A9n <fbeltranmillalen@gma=
il.com>
> ---
> v2: new approach, as suggested by Christian and Alex: instead of
>     rewriting MC_VM_FB_LOCATION after every re-POST in gmc_v8_0
>     (v1, withdrawn), reset the ASIC on load through the existing
>     vi_reset_quirks table.
> v1: https://lore.kernel.org/all/20260924132952.25054-1-fbeltranmillalen@g=
mail.com/
>
>  drivers/gpu/drm/amd/amdgpu/vi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu=
/vi.c
> index 2cd6d7d77..a0435fd55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -1397,6 +1397,7 @@ struct vi_reset_quirk {
>  static const struct vi_reset_quirk vi_reset_quirks[] =3D {
>         { 0x67ef, PCI_VENDOR_ID_APPLE, 0x0190, 0xe3 }, /* Radeon Pro 555X=
 */
>         { 0x67ef, PCI_VENDOR_ID_APPLE, 0x018f, 0xc2 }, /* Radeon Pro 560X=
 */
> +       { 0x67ef, PCI_VENDOR_ID_APPLE, 0x017a, 0xc7 }, /* Radeon Pro 555 =
*/
>  };
>
>  static bool vi_need_reset_on_init(struct amdgpu_device *adev)
> --
> 2.55.0
