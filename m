Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA73C001DB
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Aug 2023 13:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5584C10E6F9;
	Fri,  4 Aug 2023 13:03:37 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF94210E6F9
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Aug 2023 13:03:34 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-522a9e0e6e9so563178a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Aug 2023 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1691154213; x=1691759013;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UxwSpue8VcAl4rE+L12cx6ELVuEpMdkrFAwiPdnoGX8=;
 b=U/pzLmSSesV857mBeI0TU4dda7CF1a53EmSDTCN5EXDBpHwAhnQdZYYDjRFBK7DHut
 wFpW1JgdQGXS+FiE+B4dM0RiRZIqsz0VOUhMms4n3ikoNUEcNpr6trv6Bkd78d2Is0Gu
 T4NrzbcM10n0APMABvxNnLufUODd7ew9gdA7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691154213; x=1691759013;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UxwSpue8VcAl4rE+L12cx6ELVuEpMdkrFAwiPdnoGX8=;
 b=Q97l2CCfg/6Z0HAk+tWopai5ow9oFqtxfEc3Zl7MZuksDrNySosZ33yhZvtk0Im4hZ
 8VA944PI69KuZIjKzYrcWct1jr5rS9+zYAZbklBPZx3EWKenas9YVuF/hhfyZDhKPpbo
 dIeHRWQQ8iSldPQgvyaz5sWRoKXNQNC3/ue/I+KX2G+dM6YsTvRc8yBzBOR1IRZwfBaC
 pAlVR4aA/aM+/tAp4qQdXQ6Vq6GTP7CrR1BTJOwADoK6ewnVZEDEtkDk6s+fwsoKDDby
 uvNPftdZld6rrwcr4TGV7etqij2U/QwJ59HofZyoqeM+Iqm0WaQNrbOpuryQZ3Ld9njS
 GvIw==
X-Gm-Message-State: ABy/qLZpD3G4IvDadVPZ7kuGOdt6TRkVbwknpqcALMSp7tGEjJ6Sa29F
 3g04J9RvECoSD7HBHpfqRlQzWQ==
X-Google-Smtp-Source: APBJJlFlOCcJwTgxssVeh0x3dNinWRfduyp0bspmJezvbNPSgW6Gd9/PiTQBd6YeAKu1zIJmVFmQdQ==
X-Received: by 2002:a05:6402:270b:b0:522:582f:9194 with SMTP id
 y11-20020a056402270b00b00522582f9194mr17071722edd.4.1691154213096; 
 Fri, 04 Aug 2023 06:03:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 d12-20020aa7ce0c000000b005230724b2b1sm1232776edv.45.2023.08.04.06.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 06:03:31 -0700 (PDT)
Date: Fri, 4 Aug 2023 15:03:29 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH v5 1/1] drm/doc: Document DRM device reset expectations
Message-ID: <ZMz3IXIzXS5gNK3G@phenom.ffwll.local>
Mail-Followup-To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 pierre-eric.pelloux-prayer@amd.com, Simon Ser <contact@emersion.fr>,
 Rob Clark <robdclark@gmail.com>,
 Pekka Paalanen <ppaalanen@gmail.com>,
 Daniel Stone <daniel@fooishbar.org>,
 'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
 Dave Airlie <airlied@gmail.com>,
 Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
 Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Randy Dunlap <rdunlap@infradead.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20230627132323.115440-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230627132323.115440-1-andrealmeid@igalia.com>
X-Operating-System: Linux phenom 6.3.0-2-amd64 
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>, Pekka Paalanen <ppaalanen@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
 Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
 Simon Ser <contact@emersion.fr>,
 Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 alexander.deucher@amd.com, Pekka Paalanen <pekka.paalanen@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>, Dave Airlie <airlied@gmail.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 27, 2023 at 10:23:23AM -0300, André Almeida wrote:
> Create a section that specifies how to deal with DRM device resets for
> kernel and userspace drivers.
> 
> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> 
> v4: https://lore.kernel.org/lkml/20230626183347.55118-1-andrealmeid@igalia.com/
> 
> Changes:
>  - Grammar fixes (Randy)
> 
>  Documentation/gpu/drm-uapi.rst | 68 ++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> index 65fb3036a580..3cbffa25ed93 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -285,6 +285,74 @@ for GPU1 and GPU2 from different vendors, and a third handler for
>  mmapped regular files. Threads cause additional pain with signal
>  handling as well.
>  
> +Device reset
> +============
> +
> +The GPU stack is really complex and is prone to errors, from hardware bugs,
> +faulty applications and everything in between the many layers. Some errors
> +require resetting the device in order to make the device usable again. This
> +sections describes the expectations for DRM and usermode drivers when a
> +device resets and how to propagate the reset status.
> +
> +Kernel Mode Driver
> +------------------
> +
> +The KMD is responsible for checking if the device needs a reset, and to perform
> +it as needed. Usually a hang is detected when a job gets stuck executing. KMD
> +should keep track of resets, because userspace can query any time about the
> +reset stats for an specific context. This is needed to propagate to the rest of
> +the stack that a reset has happened. Currently, this is implemented by each
> +driver separately, with no common DRM interface.
> +
> +User Mode Driver
> +----------------
> +
> +The UMD should check before submitting new commands to the KMD if the device has
> +been reset, and this can be checked more often if the UMD requires it. After
> +detecting a reset, UMD will then proceed to report it to the application using
> +the appropriate API error code, as explained in the section below about
> +robustness.
> +
> +Robustness
> +----------
> +
> +The only way to try to keep an application working after a reset is if it
> +complies with the robustness aspects of the graphical API that it is using.
> +
> +Graphical APIs provide ways to applications to deal with device resets. However,
> +there is no guarantee that the app will use such features correctly, and the
> +UMD can implement policies to close the app if it is a repeating offender,

Not sure whether this one here is due to my input, but s/UMD/KMD. Repeat
offender killing is more a policy where the kernel enforces policy, and no
longer up to userspace to dtrt (because very clearly userspace is not
really doing the right thing anymore when it's just hanging the gpu in an
endless loop). Also maybe tune it down further to something like "the
kernel driver may implemnent ..."

In my opinion the umd shouldn't implement these kind of magic guesses, the
entire point of robustness apis is to delegate responsibility for
correctly recovering to the application. And the kernel is left with
enforcing fair resource usage policies (which eventually might be a
cgroups limit on how much gpu time you're allowed to waste with gpu
resets).

> +likely in a broken loop. This is done to ensure that it does not keep blocking
> +the user interface from being correctly displayed. This should be done even if
> +the app is correct but happens to trigger some bug in the hardware/driver.
> +
> +OpenGL
> +~~~~~~
> +
> +Apps using OpenGL should use the available robust interfaces, like the
> +extension ``GL_ARB_robustness`` (or ``GL_EXT_robustness`` for OpenGL ES). This
> +interface tells if a reset has happened, and if so, all the context state is
> +considered lost and the app proceeds by creating new ones. If it is possible to
> +determine that robustness is not in use, the UMD will terminate the app when a
> +reset is detected, giving that the contexts are lost and the app won't be able
> +to figure this out and recreate the contexts.
> +
> +Vulkan
> +~~~~~~
> +
> +Apps using Vulkan should check for ``VK_ERROR_DEVICE_LOST`` for submissions.
> +This error code means, among other things, that a device reset has happened and
> +it needs to recreate the contexts to keep going.
> +
> +Reporting causes of resets
> +--------------------------
> +
> +Apart from propagating the reset through the stack so apps can recover, it's
> +really useful for driver developers to learn more about what caused the reset in
> +first place. DRM devices should make use of devcoredump to store relevant
> +information about the reset, so this information can be added to user bug
> +reports.

Since we do not seem to have a solid consensus in the community about
non-robust userspace, maybe we could just document that lack of consensus
to unblock this patch? Something like this:

Non-Robust Userspace
--------------------

Userspace that doesn't support robust interfaces (like an non-robust
OpenGL context or API without any robustness support like libva) leave the
robustness handling entirely to the userspace driver. There is no strong
community consensus on what the userspace driver should do in that case,
since all reasonable approaches have some clear downsides.

With the s/UMD/KMD/ further up and maybe something added to record the
non-robustness non-consensus:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Daniel



> +
>  .. _drm_driver_ioctl:
>  
>  IOCTL Support on Device Nodes
> -- 
> 2.41.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
