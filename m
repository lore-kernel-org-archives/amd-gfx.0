Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB31E1094471
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Mar 2026 09:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 448FC10E385;
	Sat, 21 Mar 2026 09:47:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LgDltKzq";
	dkim-atps=neutral
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C381310EAFB
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 21:58:16 +0000 (UTC)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-64eb7def21dso227631d50.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 14:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774043896; cv=none;
 d=google.com; s=arc-20240605;
 b=c1TnshdVrnktMwZ+j89/KLvjr/gS93eWHEBHdpLJiQcLq96n7ukWpOD7ws+5Nlg1zH
 2gPtpySxwkoZ4NQThf/D40jQdHZ4R/KHGp4pmUmdIKEQ0i+0Xx/f6Cu+ZR1DgRNLQdvZ
 mm91wmy8j8NKWS7KZCdknM8mMzjSyYhHYOxd3mInJEHRtWxWTvtQgrMTgu/OcrfiViOy
 3lx7bfqBFzE/JDYpzk2IPxZOpIAgsRSKQvz7RTYwGYpaQ5wvePGfmEURkUx2vtDHw+Qi
 TFfK7JktfL9Yy1ppmCptYsA2QNbG2im2NQeFcy881MIuFW6812+V8gVHzUkNHiLzv8k2
 6wNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Wqd+go642a+TWwe7PKtBfdSDa2EC78pSofkTaJD/gQ4=;
 fh=aLXBT3rHuawrQvKY8PxWFHcCuCqgxDMLiJyiMvQak6s=;
 b=EnhgMCtfn754hXdqiPAT8LRzSjJlm4j2o28WPhLJg8CMk0yJnIlJIybbhE9q43mKLI
 UIYemcDFZG085drhn9Hou9BvdCNk8X4oM8vQi9KZj968PWPJDLNFQ9ciyOfvaAaw3R3o
 d386AZXDXhCrrSQh4YuDMS8DQsnUDNZIhyj64WRnPcC04+J62d0OcLv+C/XyTQTDw2bO
 tu5al75tDkf6c/47OPMai+U9jo+pmffSWAZHUntCYvMqQqNYe+c8txbqmo+Va48Mdqt1
 hSpU6XHLRZ7vhl+9JrL8j46/oaH6RgyN3S1e7i7Eq3H/aGua17PKUr5Z8pOcPZsDYxBQ
 ypZw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774043896; x=1774648696; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wqd+go642a+TWwe7PKtBfdSDa2EC78pSofkTaJD/gQ4=;
 b=LgDltKzqnH9RGSfNFpFbAMsxOSjiIL5HojGOJfKMZh5Ft9qiXTsMlL4yXpgOIT+o8c
 NXSvszqQ1qG1bhuvOrHdOZKJgvh+4HwpmU9DVm+fOMe/jWPiH/hkdovdSVJ0lSOFpzJG
 a3/9HWWsizE2OpORKD1cID3EihwQiU5Nme1HnRhs9HfY1UsHbTeonlHIg7Bg421IiXxU
 h9+GfSwdALiWVS/fjFkcI7N92jcr8G1JxbWqzEqY2h0CmH5VfDkBOQi4/AjxTN+VfAt4
 sz2ZkoR+XJ+oOlbjOfbzDrXSbtYZt58YyI7pXT/qEVT0BsK+aBxb7OTTBtXu3ZdbJdNi
 nX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774043896; x=1774648696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wqd+go642a+TWwe7PKtBfdSDa2EC78pSofkTaJD/gQ4=;
 b=fpjQuLuWHCFH9KPt7ptMz43tUp9JK9NeVw45xCD6aPd4Jsh4yZIP/ojEJLZnkGNOx+
 2ydP4cTZ6aVXwWOaNqaNk/5ygGHa+J3kG/uoKDxQ+32qNaZT6na6LHBC5kjZAWiwddgG
 lTfx4F9yiEMqVY8SxCUTIOCaUNd3DyJvHVHvtgceS4GKzruVql6feNwYQ4ByOlRTTi1m
 +6hXBxWlVmA6MJDd2KWJSa1Yd8WmDMkywedDAHeY5ACV4qTX+pGC9H64WSmTfwAzI5XN
 YiOgloejhariLUVXQYf6L7OPA9R9wAlyY9CSODGIOwTjaDxjPEKh29cAm32OEKCG19rQ
 1kXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUod8xaLberh6PFp8L6Kbt1gVPtqiIHIGAaR6+egzbvQao0p7ddJvVzlYxShkuHRqTZtWH2Cedr@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyeMb5ROkRWG6v/MtHd0mk9Htay1rtynqrV3ZCrpEk7FEND1nkf
 KA63f/Ch0+q8r28cWo8br1xjOXALSrkW9aWYtpsBfvUOrETRGZIm7US7U/Q4IRhM6w3liaLdkCp
 ZzSKtD+nysIs/Ri+iVFssKua55SVwBm8=
X-Gm-Gg: ATEYQzxxR8dGenKxkDppYa8lbt7NcRe9qD1Dh7A2hGuaBNxiitHdHZfcQpG04HmfrF3
 Ocq6ZNdB2gAgbED/i6W2AhornntA4u6KD7KS8MzoScK2ly9nEHedUPXv3TDDR8WAs1cedQiI5Ef
 aklIHBYdzLUb2UKJPM1bamgMmOzYHxv2ZJPj14ps3crQp0EB9bBy65gEofD23ALjbUnc1S0h0W5
 sQgrLXFagShUjHg7r0XcfRC72JoCVRZdhhPuIwjnkPX5RrMr/sqlkvKzT8ucfij9bAXSPJwiwmY
 8inZ
X-Received: by 2002:a05:690e:449f:b0:64e:8d62:9f33 with SMTP id
 956f58d0204a3-64eaa6dd45dmr4024453d50.30.1774043895560; Fri, 20 Mar 2026
 14:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <177402491424.6181.2389443184024817919.b4-review@b4>
In-Reply-To: <177402491424.6181.2389443184024817919.b4-review@b4>
From: jim.cromie@gmail.com
Date: Fri, 20 Mar 2026 15:57:49 -0600
X-Gm-Features: AaiRm51cb3dCqAyrsJA38fQfr2R4JXFEq57xAGqK5lcZWHyVmE6QB8o4PW3zixg
Message-ID: <CAJfuBxxXAU7UivRQbTgDoKcqiD2BVOWpMBP4YLq_wAkEN=3W8Q@mail.gmail.com>
Subject: Re: [PATCH v11 00/65] Fix DRM_USE_DYNAMIC_DEBUG=y
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org, mripard@kernel.org, tzimmermann@suse.de, 
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com, 
 ville.syrjala@linux.intel.com, christian.koenig@amd.com, 
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 21 Mar 2026 09:47:17 +0000
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

On Fri, Mar 20, 2026 at 10:41=E2=80=AFAM Louis Chauvet
<louis.chauvet@bootlin.com> wrote:
>
> Hi Jim,
>
> Thanks for this new iteration, the whole series is in good shape, and I a=
m
> also interested in the "future work", you can count on me for
> tests/reviews.
>
> This series is very long, but early patches are trivials or tiny fixes
> (4..11), can you apply them to reduce the overall size?
>

lib/ "belongs" to GregKH, so its his call.
IIRC, he has applied low-risk things case-by-case up until rc3,
I dont know his criteria for doing so, or his assessment of
how low-risk the initial patches are, but we're past that milepost,
so its a more-than-usual ask.


> I will add this series on my kernel to test it on "everyday life", I will
> report issues if I have.

yay. that should be helpful

> In addition, can you move the accel and class offset implementation after
> the rest? I think the "basic" part is good and could be merged soon (my
> comments are minor). This way Lukas can start to work on a stable basis.
>

They are already quite late in the stack, do you mean _USE_ after all
the drm patches ?

Im testing v12 now, it has a few noteworthy changes:
(I will work your feedback in soon).

1- Ive found a way to address this TODO-ish item:

    drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN

    Time for some thorough CI.

    Also, the previous 18 patches could perhaps be replaced by a single
    invocation of DYNDBG_CLASSMAP_USE, from a C-file linked into all drm
    drivers & helpers.  I didn't find such a file, nor a drm-client
    linkage item in the Makefile.

+subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)  +=3D
-DDYNAMIC_DEBUG_MODULE -include
$(srctree)/drivers/gpu/drm/drm_dyndbg_classmap_mgr.h

injects that new file into every compilation unit,
the file has a single call: DYNAMIC_DEBUG_CLASSMAP_USE(drm_debug_classes)
with a few #ifdefs.

the approach has the advantages of:
a- no 18 1-liner patches needed
b- no need for future drivers to call the macro explicitly (since its injec=
ted)

disadvantages:
c- redundant class-user records (1 per object), 315 extras in i915
d- mysterious, action-at-a-distance

a- is fixable, by introducing a MODULE_MAIN, added once per driver/helper
but thats not much different than adding the DRM_CLASSMAP_USE() itself.

2- Ive split up patch 1, the BOUNDED_SECTION_* patch
a- split BOUNDED_* macros to include/asm-generic/bounded_sections.lds.h
b- include it from vmlinux.lds.h
c- imitate include/asm-generic/codetag.lds.h --> dyndbg.lds.h
d- scripts/module.lds.S includes c), calls MOD_DYNDBG_SECTIONS()

this addresses some lost sections in DRM-drivers, the problem was exposed b=
y 1

> Thanks,
> Louis Chauvet
>
> --
> Louis Chauvet <louis.chauvet@bootlin.com>
