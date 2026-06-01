Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6ACCD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 14:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C15F311346F;
	Mon,  1 Jun 2026 14:58:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WDQp/77R";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A60811346D
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 14:58:39 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-13776b5636dso90151c88.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2026 07:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780325919; cv=none;
 d=google.com; s=arc-20240605;
 b=M61+l65LGWHgAf/UNRLNZjGIjOjf0KI/+1+QjFgAFHmiibX/EEl0QmPt1PGb9m3Onj
 Ca5jcoT1rdhcB6DOmuWWFqqIt4j4mPsZlOCt+GCR71EY4rFoPnxUTvSriDxcvqFfmpP/
 QnZmJ7qLRFKXZ7Z6rwWVFVq40qFpBFyI9DBlFgsWymSyjyLYsU5mcYr5HCGFnXTkTRq0
 yAiuole0z3SKJ9fNIoUNm11vFoPFhtIB7zIuFRJMoZn/obmiROjkPuXsF/8JgVehnZ27
 hO6Rz+nXvTOqrtSHHgJ8y6nvQUvg5j3K5CkdRpCb88OJzolUrTwBM0KRdOAT0vbMLiS1
 9BGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Q4X3mAFxA5/9YmKpD/CVwbEWKGMcHO+vH+D2A2UCN4k=;
 fh=/jXuF6kkEzGc76I89MWDwYajZhHhstOH8SMMdzCQivY=;
 b=eSnSP/JDk2lY+ABVZPIvpEB5Wcr2xov5RRToMN+6nEq4As3OOJBdJGXk19MCwoWKg9
 lSLJqJ4X80ap6fqId9+UBw4JNa0Km9elLQsZ/axzIorC/BzVfwr3jgZsmhED1cZ8bnEJ
 atYYZXnwZgkBlKbFKjHV3IATPabKITWuoGqtANbxNqyEeHlwkhE90AzJtdPBe9syoMv0
 EkBUHG0lJwkRHPVopVJeAKrwFxZmo5XupHdm4TWFcxsFZ3sIrUpTYVhSd/BN08eWOp+d
 QpjsTkCJ7M2GeFi0uM4G1mD5Npu4wY0VTP9PA6Gh6wJeXQTdgK0tHNog3vWCXp28tCBW
 f+Ag==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780325919; x=1780930719; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q4X3mAFxA5/9YmKpD/CVwbEWKGMcHO+vH+D2A2UCN4k=;
 b=WDQp/77RieQumA7XoKC/AW+WGBHQUrCh99KfEzbvTPE/szV4GNkJxmGcSvo40ub8Ia
 Je6o+0UoJMcJOory9xJqxHucq3didat5YGxQLjFJlyjLvQ+hQehfKdISUJSiL3HKbVBY
 jAks1BP5C44evctxjyN1gC4EA+BrqKW+6MUctNUYs41A/e60CSTSEeOxl4QkezVnWpFo
 A/7rRzaTMLzJ5xwsYa6XKTGsW11tMS4kgFv+4bILCcwgjn/XIzJQPXRT0tWnokn2g7uO
 Grvtus99YHw/EqEGrlqPKWTU/mfU9gdgto3y4zxWFnh70aelvgcbyRVIxY791tbC0d89
 1THw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780325919; x=1780930719;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q4X3mAFxA5/9YmKpD/CVwbEWKGMcHO+vH+D2A2UCN4k=;
 b=K5xqXHjLegMdBqCjOr7nAqzjAbiKwKUyL1+nw7JYPfCGyDEiRFVy2xlFWFbf8OM8jT
 A3NDQZyi5Imw2MnXQ+8lHimYGoCDgFkJjSAvu5INBR3xB+ahHjs8ZBslIqfwpeu7GEnj
 DZ1j1+OYE5KtatQeBKUnTJbw9QN+NGdGIAZHRcNysSkNJgV+ZCJSUt/94QQPW68Lvu+z
 Rujl/8+e1dGJ8G0eygaeOIXb7iIiHoBRjNkCk/B0756Yfe5deFs1F0U72vSgIUCcopmS
 4eEw00Xm8GKF7elaKBOvaO6uW2yTcywd+Ru4WbD5SOJpYME0DM/DjFICCYxo+cErvLLT
 qZKw==
X-Gm-Message-State: AOJu0Yyg/sObe/PmYBL59QSrXvVIDI8rkXnWjvfLP9Bck6sdgzGciqfp
 Xca3b5YixbfsjOwxcH+FNUugk8LLbSheQ9f1L/IRKPQkrifah0vc7JpbCnf9vYonE/XyaP9yByq
 Rozyt5iPhllLMRQorX0MiIcbNpyigE/0=
X-Gm-Gg: Acq92OFktjUjDK0JUBHpCo9DpUx28/UnYgAdG6EhQ4bfOF8QRF5qs1amhYyOcQQwU1y
 7ABgUmrDxpcgDx1lib6xm681ZaQ+ROTftah+oEAIQ1OGclL3lAev9aLNIPHLPAvpWSy8tHQqSGg
 +af6eunvRCkMkF+6V3lSy+46xgGo/6UfpdF2lFxvaHDrMFAyKc7/7tnEqMiFubUDIaAAymSL0MJ
 CIptDPiK0+5QH0v0wYFK66sOPRpQDSE7gpyeG89zZ08ANKf+DKPAGyYe5R8dqwqsBESQ1IrZX9X
 3fPza8E0KAeqVqJJwZUsi2K3Cpppx8cxBDZCtADGBbpVYRQT8nRil+lFrXBRayEPtR+zI6PQOXO
 Vmd1X
X-Received: by 2002:a05:7022:385:b0:136:bbe5:3979 with SMTP id
 a92af1059eb24-137d426a906mr2210802c88.4.1780325918771; Mon, 01 Jun 2026
 07:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260530075541.29661-1-mario.limonciello@amd.com>
In-Reply-To: <20260530075541.29661-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Jun 2026 10:58:27 -0400
X-Gm-Features: AVHnY4L2T1jBJRDWWxgj0Sy3Dw6OCbjb6nDtluyZXTJFRwEMhzyetmlQsjWLF2k
Message-ID: <CADnq5_PNc8YCRkeGZw2yZX5AeRP8Qe59VbaeB2TkkVPhy3o3Gg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix amdgpu_device_find_parent()
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Sat, May 30, 2026 at 4:34=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit e4300be450453 ("drm/amd: Add dedicated helper for
> amdgpu_device_find_parent()") created a dedicated helper to find
> the parent device outside of the dGPU but it had a logic error
> that caused it to walk all the way up the topology and return
> the wrong device.
>
> Break out of the loop when the device is found.
>
> Fixes: e4300be450453 ("drm/amd: Add dedicated helper for amdgpu_device_fi=
nd_parent()")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 5ff224163bab5..b82c6ef589557 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1921,6 +1921,7 @@ static struct pci_dev *amdgpu_device_find_parent(st=
ruct amdgpu_device *adev)
>         while ((parent =3D pci_upstream_bridge(parent))) {
>                 if (parent->vendor =3D=3D PCI_VENDOR_ID_ATI)
>                         continue;
> +               break;
>         }
>
>         return parent;
> --
> 2.43.0
>
