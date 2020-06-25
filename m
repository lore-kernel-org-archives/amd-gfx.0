Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F3BC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 13:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66149207E8
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 13:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3j0N9Nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66149207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B4A56E297;
	Thu, 25 Jun 2020 13:46:13 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A5386E297
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 13:46:11 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id l17so5639688wmj.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 06:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zEgMAp6myGwQkUqnq3IaNX6fNoW6SxioSan/hVSGruc=;
 b=S3j0N9NmnhSJYc3yUoMc95isBzfyQaMQii7eMkzcb87+stxDucMPp9ZV27sEXg0q/7
 33trVxTxYnohGSnWg5eYQk4Jd40pz2pjeskpGldQAIjMJ/f8RfHUGCorZw9ek5lvEhBd
 KiP8n7nrV1JXkNlWStJ5Q+xhqArZXTN9sOAhykL7Z9MlsHAdqsZzklbd0HExFbH4vw1v
 969lTebpXcqESxnyvA/e2CGg+F9eoXMchimQhyw3DMDdlAvAuqPLKiriTuTTm1fAxal8
 QDWjgYWKc+OZEmBmZNF8/RvJSce7b6U6LaonZ52PZPsH4vB4v9NJWztxw/U4LLwLhbv0
 bA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zEgMAp6myGwQkUqnq3IaNX6fNoW6SxioSan/hVSGruc=;
 b=RL8Yt90Miouswc+ns12ihBD/y9BV5wA6o0chmGCi6i27iubBwitaUHQ2En8C+DWUcL
 i8Sf178ZoGqWEel2qOK15G93+9nuGQPvfeoII/47CUkuaTPvv+A2O416k7bmW6purrR4
 zJ921klQ8T94BQA+eZ643rxMhyuWtTJm53yaYibRSiEJmrx1pw+zwTotuBQYksR+IXZA
 wriJUflBX+pN7PbxYE1iS4elvIOQ1c3E8z3TUyQkAWdJVTIZbfh6VdSlIwBySkixNv8v
 ygmlds06q4HgpJmpwu6TI+GT/0vZ/y/uQGIxpPA13wjO7o99wUfuhmcVlkFnJhtEdp37
 k4aw==
X-Gm-Message-State: AOAM533LFL3Shl1Y7rVS9QNHEZf0W2po+zdt65M70aUGKPCeqXc+oYxN
 L2F0RrrM70i/3gXuFxIxsJ2FeOEVn+TcN8RkfKbSG5by
X-Google-Smtp-Source: ABdhPJyocp3N+0sAGKSgLGm53/CniLFSRQ9NADYp/7BuEpqBeDnczdYwmxRM2SzNfQu5CnASSFAexJCNTKZmzNEWnA0=
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr3439732wmk.39.1593092770511;
 Thu, 25 Jun 2020 06:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200624190519.2378793-1-alexander.deucher@amd.com>
 <93a8f0b2-ea36-b6b7-e613-8d8cc69b24d8@amd.com>
In-Reply-To: <93a8f0b2-ea36-b6b7-e613-8d8cc69b24d8@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Jun 2020 09:45:59 -0400
Message-ID: <CADnq5_NasehMWvoJqC-xLAr=qibrBBVH_VHCEAksJGrcAdxJ-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: rework runtime pm enablement for BACO
To: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 24, 2020 at 8:17 PM Bhardwaj, Rajneesh
<rajneesh.bhardwaj@amd.com> wrote:
>
>
> On 6/24/2020 3:05 PM, Alex Deucher wrote:
> > [CAUTION: External Email]
> >
> > Add a switch statement to simplify asic checks.  Note
> > that BACO is not supported on APUs, so there is no
> > need to check them.
>
> why not base this on smu_context to really query the
> SMU_FEATURE_BACO_BIT and then base the below flow on that instead of
> nested logic vs case? I am not sure if there was any issue with
> smu_context earlier?

We already check whether the asic supports BACO in
amdgpu_device_supports_baco().  The additional logic is just there so
selectively disable runtime pm on certain asics.  E.g., Arcturus and
vega20 support BACO, but had issues with ROCm IIRC (although, maybe it
is worth double checking those asics with noretry=0).  This is mostly
just prep work for patch 2/2 which adds a special case for vega10.

Alex

>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 34 ++++++++++++++++---------
> >   1 file changed, 22 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > index 4ec544783a45..0fec39eed164 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -167,19 +167,29 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
> >          }
> >
> >          if (amdgpu_device_supports_boco(dev) &&
> > -           (amdgpu_runtime_pm != 0)) /* enable runpm by default for boco */
> > -               adev->runpm = true;
> > -       else if (amdgpu_device_supports_baco(dev) &&
> > -                (amdgpu_runtime_pm != 0) &&
> > -                (adev->asic_type >= CHIP_TOPAZ) &&
> > -                (adev->asic_type != CHIP_VEGA10) &&
> > -                (adev->asic_type != CHIP_VEGA20) &&
> > -                (adev->asic_type != CHIP_SIENNA_CICHLID) &&
> > -                (adev->asic_type != CHIP_ARCTURUS)) /* enable runpm on VI+ */
> > -               adev->runpm = true;
> > -       else if (amdgpu_device_supports_baco(dev) &&
> > -                (amdgpu_runtime_pm > 0))  /* enable runpm if runpm=1 on CI */
> > +           (amdgpu_runtime_pm != 0)) { /* enable runpm by default for boco */
> >                  adev->runpm = true;
> > +       } else if (amdgpu_device_supports_baco(dev) &&
> > +                  (amdgpu_runtime_pm != 0)) {
> > +               switch (adev->asic_type) {
> > +#ifdef CONFIG_DRM_AMDGPU_CIK
> > +               case CHIP_BONAIRE:
> > +               case CHIP_HAWAII:
> > +#endif
> > +               case CHIP_VEGA10:
> > +               case CHIP_VEGA20:
> > +               case CHIP_ARCTURUS:
> > +               case CHIP_SIENNA_CICHLID:
> > +                       /* enable runpm if runpm=1 */
> > +                       if (amdgpu_runtime_pm > 0)
> > +                               adev->runpm = true;
> > +                       break;
> > +               default:
> > +                       /* enable runpm on VI+ */
> > +                       adev->runpm = true;
> > +                       break;
> > +               }
> > +       }
> >
> >          /* Call ACPI methods: require modeset init
> >           * but failure is not fatal
> > --
> > 2.25.4
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Crajneesh.bhardwaj%40amd.com%7Cd5d794bda2c44e0c902008d818719558%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637286223410087832&amp;sdata=yErSk5DyDDXPX8Y1cXp14QxX9pgwRlIj6%2FuIhNKYN%2Bk%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
