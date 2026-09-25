Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56B9C9830E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 12:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2784210FA51;
	Fri, 25 Sep 2026 12:55:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UWttT2gq";
	dkim-atps=neutral
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com
 [74.125.230.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6AE410FA4A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 12:52:47 +0000 (UTC)
Received: by mail-qk2-f12.google.com with SMTP id
 af79cd13be357-939109f067cso80189785a.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 05:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790340767; cv=none;
 d=google.com; s=arc-20260327;
 b=EcRB3KUVGqWUUb7Iw+54/TB6NDsSa06SIEL7VK2vSh6ZrJND0vJKO5bFqaVHmdQH57
 iR5Yy6hzmQB+n2aInBuRlwgJUNaf3CcqdaKy9Yd+8B8SX+DPsG88py8P1PaBWJKmRiYd
 tvWfENILctyX7AugXal6PPQ21TQrFy2Ls6PTb3k/BGnaLUC8+2dimi1m70Z9p4Or2qtA
 WiYSWrGPXJcsJOlji+TlKb/cJw8e+11eyMAhQxQfJeP/NlPDAy70TNySaHlMEvRadLuB
 4QP4XRoBRjrC0PcfKS/vtWYIqQwLJRzwtF7KTqJ43rRhrrT/N+acHpZHfp5U/wVSGGbA
 mTrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9LWDCzcn0ysfmdsUdgkxA//1tZg5vvX+0Vm1HrB/0WM=;
 fh=qzkmBmcqQujEjdrl/f7k4EDyHDwoD068DF9u9TaPec8=;
 b=LDR8h7tDZkjvzgE1lRsjoiMeC6wQk2LoNnSHbKd7BAduA7dKvWEaOZs42x3E0Uhsqx
 omPJyx6Cl7ZUPn/2xSW729Dw7PwTL0Sjs6LEyT9veqEf1XDwXTjMEl9i2SRgINzzaMo1
 Ipt8KvRhqxuD7SUKHaONr4R3KgMXAKaYMn7yPxUMz6GIedfPt92lHtLNYrGioEWXnfmx
 5iC5gcI168eDMJkGRzFE/Iaky8a0WTIZ/E4yXaAa643ghAEVuersOUsnt+eJJ2pf+vbF
 FXAMnXCrEk5e32mU+rln8Bcn3oSFgSxUEk+u5X7m8q+T8KYfnD+7uORaR2G2oYhY6exA
 KzAg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790340767; x=1790945567; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9LWDCzcn0ysfmdsUdgkxA//1tZg5vvX+0Vm1HrB/0WM=;
 b=UWttT2gqZVLPbAc3FiQ6UUGZWc71HKtC/B9fYuDd5qL85uSR+/wc9OtTujQ9mTJw0W
 UO7LxC4yuGDfZ7UcyjXLpjhi4WO407347tRmvp8U8YJHROJ82XEugNWIy44v/suliVg3
 isYdQHw3bbfMqgLWvrwNMuPhuv6dmwWOUxfMrguj7ZpSeijQAK/w5BUQxEkoHvTKPhcx
 4zD/CxDAJBPgk1NydMPyLO344UYulyWFzYtET5Ub5pxal42wOLsn+W83zwZL+zqgEudx
 SQqG3A+NNqNNTT33p9INoEh4yc3DklM22rw6iR/P93G2drzEtFJ9N8vXBPZl+QLjF2On
 1mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790340767; x=1790945567;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9LWDCzcn0ysfmdsUdgkxA//1tZg5vvX+0Vm1HrB/0WM=;
 b=R9VGTOo5Wy0/IHSHXL5QS8DztqX9PdHP1MDKSsngJllT/Co9mdf9Is0iHVIg0CE2zP
 3RfsWHHm3T1dXQh9NgrkVIkocQcdbop8aeszDaMaVYZjfhwtjwve9Lya3zLCHLL53sph
 Vvy0tZbUKhEhjNd5mf0uMojMwZ71DJr9Sv9OgVfiPAhBVjcmI8uP2XmdJK2P3BQiyqh2
 SSjTOoZ8jaGCOXDAWNUQQ2LokHIZvJd6jEB7/Tn8qmKtSNPP6IBOqnKis8zlsH7dBMOv
 5IL0RQMVveMJJ9QisScFB550RgoKAxMhq3JKoHhKLGduD2K7cLonZRs+iSvhUbGrqsgT
 mKkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBybpZVKVU+IOzvjzxtkML/Blhay/DwcPZdZlALqd9ZtfKYDg5LIo/b56Ae+KoCT9lBTyMKuff4F@lists.freedesktop.org
X-Gm-Message-State: AFuF++lCQsOdjvDZpAbLiWmMkfsCd4DzwM9f/K5QwfniimTnnFi9UMtH
 IcsBIV0JOR7H8Pui6Ebd4yynZNDaiMc1e96nRUAmXCb+gF+go//8840qgfSqjt9KbL42zxGkAxu
 Um1toQ2Qw/Vfm/smPI2Wl6txnFO1oxQI=
X-Gm-Gg: AYBFou3YILqKNuh0krBXBOngqBe+4iPXCoHLmahlJ0UXepniORjxw3Oce4MN3a176eN
 axOiNODs0rSqXTClF1VtJ9qXjVDfcRyT87EoKyQYj+EWWnyAPiIuIv+39BPWYk7bBx1JMh7LOY0
 BTYjv161wmsE4XCY2kpQYoP20c+0D3nslopVdFK2GiDKS0xwtTPSgc4oInoTW98a1RLyDFjJj7w
 9Q5lu/UJ8nNo4jiImxiU698eya8QTi+S7JwKVCtFtS7RhvZPFnKrehnNg8oIHIOwnnNwCWBWTuJ
 rp1+LJnOx4qWNby5clgMXRpQeGgZETa7YKY1sxdoKMdlv8SzNEsd+rN+4w==
X-Received: by 2002:a05:620a:8389:b0:93a:3d22:3122 with SMTP id
 af79cd13be357-93c43cc7043mr442767385a.3.1790340766713; Fri, 25 Sep 2026
 05:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-3-mario.limonciello@amd.com>
 <0fb724cc-ac12-4502-b338-1c4f310f043a@suse.de>
 <CAFOAJEdFPrwHZV5y1E_u_Wd6oE_viPsPztxYW6PRZHJ-zdPFMQ@mail.gmail.com>
 <ff86caeb-4388-4660-b3c0-ddc42bc274e3@amd.com>
 <b60d3430-ca99-40b6-aaa0-7b8d481ebda6@suse.de>
In-Reply-To: <b60d3430-ca99-40b6-aaa0-7b8d481ebda6@suse.de>
From: Xaver Hugl <xaver.hugl@gmail.com>
Date: Fri, 25 Sep 2026 14:52:34 +0200
X-Gm-Features: AclHuK_7Zf-6pQcm6muMqKFw6mcOuy1gYopDSlUKmT8vyhgjq4Te-A38Cn1BR-c
Message-ID: <CAFZQkGzUuOh2tGa_otw7yDUd9rSne2PG5Vdte-hwhLZEDf24dA@mail.gmail.com>
Subject: Re: [PATCH v8 02/14] backlight: add kernel-internal backlight API
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, dri-devel@lists.freedesktop.org,
 harry.wentland@amd.com, Simona Vetter <simona@ffwll.ch>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, amd-gfx@lists.freedesktop.org, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>, 
 David Herrmann <dh.herrmann@gmail.com>,
 Marta Lofstedt <marta.lofstedt@intel.com>, 
 Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 25 Sep 2026 12:55:24 +0000
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

Am Di., 22. Sept. 2026 um 14:05 Uhr schrieb Thomas Zimmermann
<tzimmermann@suse.de>:
> > The whole design here is to put the compositor in control.  For
> > example if compositor wants to enforce brightness to be a certain
> > value when certain content is being displayed.
>
> And as I mentioned, it might not be that easy. Sysfs has been the entry
> point to backlight brightness so far AFAIU.
Yes, but this doesn't remove or break the sysfs API for old userspace,
it just allows new userspace to handle things more properly.

> Did you consider treating this similar to display hotplugging?  When the
> user plug a display in or out, the DRM driver sends a message to the
> compositor in user space. [1]  I think it might be possible to do a
> similar thing for changes to brightness.
Notifying the compositor after the fact would not be ok. All the other
display properties are under exclusive control of the process that
holds drm master, backlight being different is one of the problems
fixed by this new API.

- Xaver
