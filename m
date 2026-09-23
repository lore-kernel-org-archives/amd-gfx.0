Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4B9C98317
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 12:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1961F10E92E;
	Thu, 24 Sep 2026 12:46:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RvJuHdxS";
	dkim-atps=neutral
Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com
 [74.125.230.234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A45B68961D
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 08:07:30 +0000 (UTC)
Received: by mail-qk2-f42.google.com with SMTP id
 d75a77b69052e-530c602630bso9133611cf.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 01:07:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790150849; cv=none;
 d=google.com; s=arc-20260327;
 b=VpCmg9Ux12xORFFavwi3GgkSgn8I9ZxDh83jpvcFcifENNsgvw80w5xx4VWfUq38rm
 m7eb8Yp4KO4ScL6Wqmgg80BUjm5ra3kE0QEBNFaAc42lHIVXyXsetyEd0APCYIa5wIVJ
 NQdkExLilym1AxX2Osqf771cCcmvXeT1PVBZOGN9nXhpWkGeSK1iVVsYCzxCs1uPULWC
 JKD7MY/TYSgcIkwQimJudBS3vHZJYXu258n4OOh8kVwQQE+bTFI4gXTG7BkmkVepYwJb
 rnZiYUVpYFT8pRbiF/CMm9BoyLu+dwEo15XsWz9JgC0QHJe5E9ZhIeNBipG9da1oxaUJ
 lr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=X6tfoxJ5bpmB6e0WP97I+GLmoZutAadx7RSvw4hqVZ0=;
 fh=7O9Qq7Y34uDIC4klfWfz2LwXtL4VQYU5NXj3woMcNco=;
 b=N9IV/N0KemdpYuVzHtKqfRS3K+M5jbyTEshQNPqMDSWdUhDju8grhnLwYOXv/P1/+8
 w5udlI9aaivKfxf6RLRnYqIxbfC4pt6EAGDoXM4YDIAQ2X5l6xAdnkd6B4S7FRkO+on9
 hzW7w7WbWI/5Pnokheryzf+A9Ik33JNQpzeP+IRknhCpGp+wzQQlgtPiYrhGQ41Bg/Ut
 iFVRdJJsMNmHdfvXXtA1xVkI9n4tXSKRgnVgy8QJQyePyN0MaZL02AlgGK/niC4XtIql
 LQb7meKGNb49XWIleShUeOvi5XiYDChMLKdSYnQBjL9VraAQsDJc6urcRy0hzsu7RMQW
 QgNQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790150849; x=1790755649; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=X6tfoxJ5bpmB6e0WP97I+GLmoZutAadx7RSvw4hqVZ0=;
 b=RvJuHdxS4DzPLW74CvaE3ZUuO+Mi05YFW5wrE0Di1VXmFX3yKiAIaluwbrDcBqNJLk
 qdfeVaeqLw60CLx5XiI1x/+3Bj/Rjs2FIIet/tNKq4PBs4Z4rX7YBRRMIC7isk/YYfv3
 YsBt1dTi1pMthGIHjpYezy0TYnYzzypg7gNm+ZYMTCPRVXpfUXWDaRX4bDjRtu2SHP1u
 Ea9YL/y6pyMNU4yDovDtDPYfBBUfehja6cfUpfaAIoNRR0PNIq8PvVX00zxC1bkYagtq
 VOOckLOoiU8XuL6n514ZmJoJBKcBj+orG2QSSdd6AjRWMK+7zAtYvGc2J3B7lirxjoyi
 c6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790150849; x=1790755649;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=X6tfoxJ5bpmB6e0WP97I+GLmoZutAadx7RSvw4hqVZ0=;
 b=E9IB9bApf5cgmE6GCbZ8UCGqMaVloSdPPhmk56FhCmtbkHOKufwb1kYDRHnyYJplAG
 2VGMsYm6KERo6gIT7NCEfh8DF6rU5H53ckin37amXgn2gVFzfltAHUDwR+5shlRHGO0c
 xqjuftOazRQzxzKuXzqP/6NeWrQALfowEScQaIU7rd5pzgpVuE+8bdKtowjFd7pEHQp2
 HerJZZZIITKWMGVUjfpr4g3D8x5h1A+wolHvHmzKqBK0svEc4ryqVNOI/47quHtl1ZnR
 xuegxmjKkZPROlW4wk3NyaH2Ze++fVzIrukpw216dOrljKloJFAdqLeuMfqjZ6GyXBc8
 W8Cg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwHb2onqahyPjHcWeOrm6+h8ok2AQecBFi/amgqBpE4o5wecoana6F8gqBAOQFFncGDlQ1bHum@lists.freedesktop.org
X-Gm-Message-State: AFuF++moC8xP7knefTwdhFsWIPsGYrK2ny6/GgVx1cUTHyrg2lu1eM02
 4IgZ3r9cQRk2CSPb/qBTtH0g94xh4akNdZUgrqYGM3heTsRMCuT+//EP448Bau3PENpzxpDlx+n
 Yg6hYX4GRvppgVSbsPtQgour1/wxNzlE=
X-Gm-Gg: AYBFou0pmQt+XQFfr9sDwV5dsrdmdG10+ZV4/r/2U/SiLIa8EJ3pFEPs0RMzpytuwra
 dCgyuV+jsCDj6RygWbwKxYGA/ZvMLppeXiAQ1o6i9dvPalYa5Jht7JgwGjCqywUFbAuLQXVzfMk
 IXOUgV5mzrZWwFaweJ4Iz4K3MCAlswq/S7w4d/UIDV1OcmkIhxSpKIHpyzlt+NhzMQXFNo9HXjZ
 Ex4A/Rt+ThoUrhHC4iTJ5g58rI3lUrup8fcZbqShQulOcO2k7XjbUgUGVR0LZo+GBXLIsAubFnS
 4wnCJllFCA0uX5MhlsoLfYxwTC3wv1801zJdVBq0XfGwjKXDNw3LZLfIY7Vw53LRAFEbT+CyP8C
 8zBeTDn1jcA==
X-Received: by 2002:a05:6214:4886:b0:90e:8be9:c384 with SMTP id
 6a1803df08f44-9140c4244d5mr29354756d6.27.1790150849428; Wed, 23 Sep 2026
 01:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <CAFOAJEfgXY7cfLvizuxbS75CJd7mF5tewxp+PH=EhTtpy+aZXg@mail.gmail.com>
 <32f96551-358b-4874-8fd1-a685b02853e1@amd.com> <arJwOSq6-oSywTK6@houat>
 <08e47991-0d72-471f-9955-0b4ebbcffcdf@suse.de> <arJ0huW356NjqpGR@houat>
In-Reply-To: <arJ0huW356NjqpGR@houat>
From: Xaver Hugl <xaver.hugl@gmail.com>
Date: Wed, 23 Sep 2026 10:07:16 +0200
X-Gm-Features: AclHuK8xgDnVa7N6ARRpfcYEwFozCo04IqFUVuiW8m2XtM8bq-AsJWi-i2VQJfk
Message-ID: <CAFZQkGz9O8dZfmxEC5Fcpa2mRHXde+FFwu4JVz3fvKTzHT49LQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/14] Add support for a DRM backlight capability
To: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Mario Limonciello <mario.limonciello@amd.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, dri-devel@lists.freedesktop.org,
 harry.wentland@amd.com, Simona Vetter <simona@ffwll.ch>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, amd-gfx@lists.freedesktop.org, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 24 Sep 2026 12:46:10 +0000
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

> Couldn't we make a sysfs write trigger an atomic commit then? That way,
it would always go through the atomic commit path, no matter whether
you're on a "legacy" compositor or not.
That could cause stutter.

> It probably would, but it would create a precedent I'm not really
> familiar with. Hotplug events are kind of separate because it really is
> a hardware event most of the time: you get an interrupt, and report it
> to userspace. And it's largely outside of the properties space (except
> maybe for things like edid).
If there's any property changes, userspace does need to be notified
about it. Whether the change is caused by hardware or software doesn't
matter.

> If we start having the argument that a property changing must trigger a
> uevent, then it means that we can expect *any* property to do so
For anything modified outside of the compositor's control, yes.
The client cap avoids needing uevents for the luminance property
though, since backlight control is exclusive to DRM if the compositor
supports it.

> "the compositor needs to be in control of it" can apply to many, like
> color formats, positions, tiling, etc.
If there were other APIs that desktops relied on for controlling color
formats and similar, we would indeed also need a client cap for those
things, until definitely all software is ported away from the old API.

- Xaver
