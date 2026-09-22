Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1686C982FF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 08:50:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2425D10EBFC;
	Tue, 22 Sep 2026 08:50:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="S0QhfK1i";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 381F310E42C
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 08:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790067012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E6yt8HPyksGEz/v/VIt69U9kjpWwNRnopqqhP0gILys=;
 b=S0QhfK1ib0BGpJLmuylVz9FobRrGlF+U44CH9EGlREvj39yeUoVMnH/8Ie6X/7EC79yrpm
 9oS/Xq7tXHvYeicrMylZTZF7YzSdD8izHTiekxfXuKg0CsKfypXULdS+StmNza2n0ao5X9
 R4cAYaGFCk2CyzdERTbLOCy+nBVExBw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-nGzb1vhpPZ6KKLkXZKlhzw-1; Tue, 22 Sep 2026 04:50:10 -0400
X-MC-Unique: nGzb1vhpPZ6KKLkXZKlhzw-1
X-Mimecast-MFC-AGG-ID: nGzb1vhpPZ6KKLkXZKlhzw_1790067009
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d6fb956002so53444795ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 01:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790067009; x=1790671809;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E6yt8HPyksGEz/v/VIt69U9kjpWwNRnopqqhP0gILys=;
 b=1ySECQQeDmkMWAOF49uvT5MxDDsWwNSLGo414tClesfSVRC0hni0GYgXFEAZdSTNl/
 rZzIC2b1B605Zk+FrgpK86OSPAXEyPNjZbeHONBSopikiMImbeUSYSAOJWX3xra3xHff
 wW4JJKsQqtrkU+JNbA3Ha/Euynfnvinvhbm2t4ek9n6FEKiRYFpFc6OiC3dcge7QpPQK
 Lk7z+RgVvLTABwNebkiO6Ha43cqeFrpge2N6R95rxe8NhgUuIUl/ztvKr7eTYLjDMxnE
 PrZ+jP6X5Fn/olcPORQ8D/ReKEEmo0meN+z2iuMG0814mPI01uMzdvEFBA7XYXIWWKcT
 wDbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8cgJ1hhdE31W5rnyJdigx/0HfDmm8mhkOyeec9vFg5hvNlnPT0rdqrnBOw+BLVirnHe1wQY/h@lists.freedesktop.org
X-Gm-Message-State: AFuF++mrlOhPc4IlRyUQ9L0ArjNQXMDu5AxCT4qz018g5Qna8xkKFru9
 M36BPubIbYk0nAEIc2/oOud9SoZ53cyMXhsVMum0JzklZI5p5gFxoUNmMTj47bxdWUaxAoUfQjg
 pLH3XpY1dJRMB94vQunjYFJRTZSNwA3vY3FluawsSXZO82I3JGMwsuCat1GRf//cfOhg8VhnnGs
 vqi+sUtSTS72fn6oH0huP/vY7+HHVdXBGuyliKk2PEiA==
X-Gm-Gg: AYBFou0H+mPq+84AFtU+AOqyBoHdNXMGrqHB59xml6LlgxVmfX2cEBsbY8OsnYM3nHz
 v3kklvHpmuvnzqRQgtvLxYJlybTqABZmd1ssNHm9/tHu5yo3/DK5w7AS9fjv2ZtFvV2zMx5X4P1
 89fW8vATYLKj5wEsldzrlhlb3skvzAUqdNYjc32MMT5PZGiSkYY7O5U0TB
X-Received: by 2002:a17:902:d4d1:b0:2dd:3ddf:b876 with SMTP id
 d9443c01a7336-2df6087db56mr5516485ad.0.1790067009072; 
 Tue, 22 Sep 2026 01:50:09 -0700 (PDT)
X-Received: by 2002:a17:902:d4d1:b0:2dd:3ddf:b876 with SMTP id
 d9443c01a7336-2df6087db56mr5516135ad.0.1790067008659; Tue, 22 Sep 2026
 01:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-3-mario.limonciello@amd.com>
 <0fb724cc-ac12-4502-b338-1c4f310f043a@suse.de>
In-Reply-To: <0fb724cc-ac12-4502-b338-1c4f310f043a@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Tue, 22 Sep 2026 10:49:55 +0200
X-Gm-Features: AcwNN1WukuNNSk2ai1J1udE9KGrF1By_6QZnzs1WKDgfz3h81hw6hXJu7g_SbpQ
Message-ID: <CAFOAJEdFPrwHZV5y1E_u_Wd6oE_viPsPztxYW6PRZHJ-zdPFMQ@mail.gmail.com>
Subject: Re: [PATCH v8 02/14] backlight: add kernel-internal backlight API
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, 
 harry.wentland@amd.com, Simona Vetter <simona@ffwll.ch>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 amd-gfx@lists.freedesktop.org, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>, 
 David Herrmann <dh.herrmann@gmail.com>,
 Marta Lofstedt <marta.lofstedt@intel.com>, 
 Mario Limonciello <superm1@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Lvj6fCPSMyChbmkKj2i-FVg7Z6O03u2bgu_rKqeYdI0_1790067009
X-Mimecast-Originator: redhat.com
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

On Tue, Sep 22, 2026 at 10:24=E2=80=AFAM Thomas Zimmermann <tzimmermann@sus=
e.de> wrote:
>
> Hi Mario
>
> Am 08.09.26 um 06:40 schrieb Mario Limonciello:
> > So far backlights have only been controlled via sysfs. However, sysfs i=
s
> > not a proper user-space API for runtime modifications, and never was
> > intended to provide such. The DRM drivers are now prepared to provide
> > such a backlight link so user-space can control backlight via DRM
> > connector properties. This allows us to employ the same access-manageme=
nt
> > we use for mode-setting.
> >
> > This patch adds a few kernel-internal backlight helpers so we can modif=
y
> > backlights from within DRM, a brightness-changed notification, and a
> > per-device takeover count so that legacy sysfs writes can be inhibited
> > (-EBUSY) while a luminance-aware DRM client is in control.
> >
> > Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> >

[...]

> > @@ -150,6 +153,13 @@ static ssize_t bl_power_store(struct device *dev, =
struct device_attribute *attr,
> >       struct backlight_device *bd =3D to_backlight_device(dev);
> >       unsigned long power, old_power;
> >
> > +     /* A luminance-aware DRM client has taken over this backlight; th=
e
> > +      * legacy sysfs interface is disabled until the last such client
> > +      * goes away.
> > +      */
> > +     if (atomic_read(&bd->drm_takeover) > 0)
> > +             return -EBUSY;
> > +
> >       rc =3D kstrtoul(buf, 0, &power);
> >       if (rc)
> >               return rc;
> > @@ -214,6 +224,13 @@ static ssize_t brightness_store(struct device *dev=
,
> >       struct backlight_device *bd =3D to_backlight_device(dev);
> >       unsigned long brightness;
> >
> > +     /* A luminance-aware DRM client has taken over this backlight; th=
e
> > +      * legacy sysfs interface is disabled until the last such client
> > +      * goes away.
> > +      */
> > +     if (atomic_read(&bd->drm_takeover) > 0)
> > +             return -EBUSY;
>
> Can you really do that?  AFAIU sysfs is now a de-facto uapi for backlight=
s.

And regardless if this can be done or not, I belive that would be
better if this is something that drivers decide to do and just return
-EBUSY from their struct backlight_ops..update_status.

Ideally the sysfs interface should continue to be work as Thomas said
and a write could trigger a mode set for example, but I don't know if
that is feasible to do due locking.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

