Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B70DC87FCB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 14:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E01310E080;
	Wed,  6 Aug 2025 14:17:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RauhtO0z";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C3210E080
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 14:17:25 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b42850af516so124664a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Aug 2025 07:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754489845; x=1755094645; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3gWPWBxA9QtZbdV4wY/c9stHrYE94EHU595+CLltUk=;
 b=RauhtO0zLQTQ1gxrzvI9KYq89VI/t+sSHPP4n8OmSqYgXj5nMJNVn2BNhM3BcH9q2l
 b+3rmgW1AbaHGfp+aNyUSH+arQRrewRSz465QzH0dLIjHbZOrqU/K42U71ejbX3O8U6d
 8tCYPvLa2H0PtyUadolB0A3aQP3EAF6sHzNDbtLV8PYbXZu51Te/tSt44wVcohDvi2Rg
 FQJFbHLREUOL9bZuxMG1CZxCiquNaFPS3iOphkcMkbgL9pshGJkDo4pD3/SHdFF/g0qh
 jJMVRUr60nXj72CNb207IoHHWyt1lR0BwquN6ChJ30sQdXW9/24QDjB6/LH+tWukaqpD
 uo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754489845; x=1755094645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f3gWPWBxA9QtZbdV4wY/c9stHrYE94EHU595+CLltUk=;
 b=TyTofEwrQCzdG/wS92k+3ZTxHBO5TLwIhzkc7LKJvK6s2Lth5y0+FFjayL34mzmR5O
 zRZyeV8B9893hvdtwLHWsJMk0sUA5yUWnWdmbdI2Zxp8lY8Hp9Hripyh3/0J2A8EuViV
 8y3XTjsZfgNM4aRtI/hjix34EL0o44WgJwz15SEvSuUL4PlfFI/iFvPqMHuI7QYlp2bU
 /gEz89TJzFTvk1H+Ktw0Jer1g0VhGvITpmAv7QRb308it6yAzZ/HhF5oxHW/ArKo6xH2
 LweEraqr0mNpTOQYMLW7BKiJvUwzF3NwiLibLeLG1VHhjO8J7Uvf0D32GICucah+a+zs
 JTNg==
X-Gm-Message-State: AOJu0YyZ0Ldq9e04RS2Z3BonMVCcN/6SYviLugkgbxmCYKSugYi4aq4y
 zRMkySyZowCRdTfSc1aAjolymlanmCZ8P88CLBzcQGb+yGThQ5GKhl/bVZqli+57Gk9xeFUc1wg
 jZ+r5Io217DO3Wqp7bHQEkY5pgKv3TZZJrw==
X-Gm-Gg: ASbGnct/joHrEpdztkaSoCwj2UL7DphMmP6LQnjWMznPXbnQ4VeaY2TBqPUu1fdwvt2
 vb+vRGVblneMdepTX+7Gj+rncYPxpcsLhSEdSoBHopYrmShSxLNrp2zY2hZ0mXe/+A2DQ62sX00
 WBqU4f/5o6rUIBcQ41rOuZoKmiRAZnPX2O6hi0fjPC/Q239fWPt7NNj/MBG1Xv5mO+MTaVwpS0l
 totseQi
X-Google-Smtp-Source: AGHT+IGAHwIff9H7tWAcms2XvCDqETBv3Jo+lLz+b1rmFe6LJSmOqW85uyhHrl+G4sD1xVgraEhsEWQOpOV+RH9ZJKs=
X-Received: by 2002:a17:902:ce84:b0:235:737:7a8 with SMTP id
 d9443c01a7336-2429f42fd78mr18987055ad.3.1754489845124; Wed, 06 Aug 2025
 07:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250804154308.1173304-1-alexander.deucher@amd.com>
In-Reply-To: <20250804154308.1173304-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Aug 2025 10:17:13 -0400
X-Gm-Features: Ac12FXwuqbQIEAT2nkqkNtgHQHtVrsJ4cSE_2DhJo0z3rM6DRIzcgxKb8SAvnRc
Message-ID: <CADnq5_M_O+M6oSCeBsT4=ROUsA1Zy9Cv=+cmrgAHhec1hUYx=g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add missing vram lost check for LEGACY RESET
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping?

On Mon, Aug 4, 2025 at 11:43=E2=80=AFAM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Legacy resets reset the memory controllers so VRAM contents
> may be unreliable after reset.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 3fb41c42cc051..6119302aa0661 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3274,6 +3274,7 @@ static bool amdgpu_device_check_vram_lost(struct am=
dgpu_device *adev)
>          * always assumed to be lost.
>          */
>         switch (amdgpu_asic_reset_method(adev)) {
> +       case AMD_RESET_METHOD_LEGACY:
>         case AMD_RESET_METHOD_LINK:
>         case AMD_RESET_METHOD_BACO:
>         case AMD_RESET_METHOD_MODE1:
> --
> 2.50.1
>
