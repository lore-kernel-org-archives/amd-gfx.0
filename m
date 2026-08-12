Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992FFC5AD5A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 19:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9306710F0FC;
	Wed, 12 Aug 2026 19:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sA6Zjstz";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50D3A10E460
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 19:41:43 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3deso272737a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 12:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786563703; cv=none;
 d=google.com; s=arc-20260327;
 b=JBGthcTJioHqAONDVwW/UTSBypBeJONnbr+MWJeSkKw/Zaz6jGiTESWPrlgn87U2Zd
 7s40X/uDvbEM5b73JyKjbE0GGqxbOs/nDH8smSYgOnUVKUV8HpuTDWgf/pjZl3bi/fEI
 3V1uGXmnXyUNhmbKHqiGQHN1saqiniOfRNaL3Zh4kPP2hJPjljAjllNcZRK7brkag004
 rqHnUY7OfNMaAx75NXp+wNhAvThQopXn+bVo5wytgauZE6/bmeqp3yC8mIFe+HELlVnA
 mkThmQMs9Ij4sFsu0LgVJEFm+1AWe1biTmVcQOtHpyHpw1yaAZQ1qc/XtL/XctJmsOqY
 tjGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mks4PzP7z/JjESfLTgfrdXVg51XLNmx3p3liUgg7Kog=;
 fh=IY9rtBg8afogMkqnXqgCA6FuR5ITT0THSG3We/Ye79U=;
 b=Arc/UNPleFJNw9SEJTagLVbjAeZM1Sjy+x3uMcUmpRSA4St+qcA5XXl8IoJSnRL/NP
 8pXLp0OJVWn7gW1cGzASEauvh1sBbYxOhn//A06A/bqNSTDzz3o86UVXA8zW3q3bp0ZN
 Fj46eHZFb+2703B/aVyUC7rQcUzdOV3/c1UEQdC1fYXoS3tZr9eML81V3repZarkdWYJ
 YDteWP0jzWDczI5O6eq4OLRBozBodT91eqITIPNdqOY9gIqpUMwqLFKDrid7K3MdfT39
 Y8FHgHUCV6v9bX1qKW4CPjIQ4eQ1dGy0zXCD9iOveBHV2VSR6zuQ8tv8kIHn/cdEBUc5
 Jtyw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786563703; x=1787168503; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mks4PzP7z/JjESfLTgfrdXVg51XLNmx3p3liUgg7Kog=;
 b=sA6ZjstzlmH05AL9nWct5x99VPWzIzZUy2kcqlbvph99HQV7RIJot8x63roLAGt461
 3S9kxPcO5e5UzaEpduBCmnaDzKtzVMRLNiu7v1YCamQbowngUtqWYLddtjIwDcWf8Hj7
 /3SvS5dvJYk3TBzbk48sf9cVxSER/l7COYoZCpSX29ptTDxwqk1C3d42pjQWX+jxsf/9
 hDQCOXxhag1q0H4wkxwjwprJORtYcBbO8bdmZWjJd0VIOUXPdJxen4JRj4mteEJX8rD1
 4/mCMBmjBNV8b96JXoGNL3Tgq/UI4O+bd7IxA458Zh3w82ksCTTABmSKZgO7ahICenWG
 TEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786563703; x=1787168503;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mks4PzP7z/JjESfLTgfrdXVg51XLNmx3p3liUgg7Kog=;
 b=VLo6ADua82rYZidKVlAQZIAlKrh909nIAj2SP4aZg3s2OD9Jc5DjujFjiPcGemGw6g
 VK5Gtvv5yoo3VKPhDcxmDjQcKmpZr/ZpNKrZFd8YN8sEXHETjE8dis4VAqZohr4bCmGl
 56913CgD3ykTsXQDbZjzMW4e1fnl9MyKrEsufWgY9jqvxrFH6zgD0D0iTyM5MlWLndmm
 aV9nYMYdLGZ6kfHz5B36glvpGe6d2g3VDqH70qbr+4KGg8HINHcNLpbvPuEZ7ARcnxf/
 giXHsIz8VgA7K7c3orCeKYrdh+7LM0tAMuwmnMB9tfzDfcRs/Ox+IIBYG2bvFi4n8ApU
 vDhg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNDnQv7rfEppnlXi6KdZCIm4l94N47jYGSePIh61AJesWetfkaomHgd1h4prknnmodNlvpHMk/@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1wb3UmUIwHQcbbyVTxTJy05Paxvmfi5LC4qjb+TrBhHYK0NjC
 h/gSU85Ob2JARgMVKuLHmUmho+SeQBlvxOZHxN8clakzDseMbB4rgX3UuCq8OEvaKk9SM/xC74V
 9OILvl2EkdwAmxzuZIaqMryEXDko5APU=
X-Gm-Gg: AR+sD12ZEQeALgSS+SLxAt1Ib0nadMiMQWWoRcnNQsIqnkbs3Tbl3dXWtmYj6GH6uBR
 P5eUxv+iPHxXeMkIFLe96/d0KpXF353+kt05xKn1nT8LLFb52cRRv2ESTq8L8qMyNp5mTtMXXC9
 1++iSjpPsPgbzjXM4fr1jP7E1xA9JWTLtiYPxng+oVC3cvoNaD+02IVa18pctz7YbqIF/6hkd6X
 YODJpphR1jG4v3LvlVCSD2XGEySM7RKLo6TDxrlBXS7cGjhRxmEl8+GuLh7r3MH0LH0ivX5LY4S
 KZRombXopxjC22PEO8phX1kHOlr4o51/2IFCKN9PGhN3Souf3BfgB3f66onu5tKpnwUrjE1F161
 FGg4qE8wdwYq7k8VUn+PuSXSCGP+03HLTAxJ0DDmiQg==
X-Received: by 2002:a17:90b:4a0a:b0:381:77cd:38ca with SMTP id
 98e67ed59e1d1-3931e305cbdmr422812a91.4.1786563702713; Wed, 12 Aug 2026
 12:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260808120934.2813010-1-lgs201920130244@gmail.com>
 <a5b4bb17-db2e-4bea-ae45-7bb3c5dfdf5a@kernel.org>
In-Reply-To: <a5b4bb17-db2e-4bea-ae45-7bb3c5dfdf5a@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Aug 2026 15:41:31 -0400
X-Gm-Features: AUfX_mwe2SLWRO9VELEw_R4SIZIRE_5qbm3M11P1fljWz8oDoEOEenfY1vc_vKw
Message-ID: <CADnq5_N0MVecwbKSJa9d4UFzagNzQJ4=qxGvVGFfvzDBOSMaMg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix autosuspend cleanup during removal
To: Mario Limonciello <superm1@kernel.org>
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, "Jesse.Zhang" <Jesse.Zhang@amd.com>, 
 Jammy Zhou <Jammy.Zhou@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
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

Did this ever land?  I don't see it in ASDN.

Alex

On Mon, Aug 10, 2026 at 10:35=E2=80=AFAM Mario Limonciello <superm1@kernel.=
org> wrote:
>
> On 8/8/26 07:09, Guangshuo Li wrote:
> > amdgpu_pci_probe() calls pm_runtime_use_autosuspend(), but
> > amdgpu_pci_remove() does not call the matching
> > pm_runtime_dont_use_autosuspend().
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > The documentation for pm_runtime_use_autosuspend() also notes that it
> > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > driver exit time, unless runtime PM was initially enabled with
> > devm_pm_runtime_enable().
> >
> > Add the missing pm_runtime_dont_use_autosuspend() call to the remove
> > path.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>
> Also applied to amd-staging-drm-next.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index 1aed121f4ddb..e814701bc8fd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -2548,6 +2548,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
> >       if (adev->pm.rpm_mode !=3D AMDGPU_RUNPM_NONE) {
> >               pm_runtime_get_sync(dev->dev);
> >               pm_runtime_forbid(dev->dev);
> > +             pm_runtime_dont_use_autosuspend(dev->dev);
> >       }
> >
> >       amdgpu_driver_unload_kms(dev);
>
