Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80216C5DF81
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 09:28:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E065710EF88;
	Thu, 20 Aug 2026 09:28:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AtrvW8U5";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3232410EF88
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 09:28:46 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so20827265e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787218124; x=1787822924; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FidK3aISQ8Cp/K2K6nkzmkNF3r3LcnckiLa+0JjVopU=;
 b=AtrvW8U5LIB59voq1my6Ilg12p7GsAhYPRkcYxe4ZWLQ1SANY9JHj82aFnjJrUO7Nn
 X+O9Fn08NzdyLSjLOkOK6GIFRs+x7v/kvSfzrbKpYjYLSKIAfXeLlda0RmPzkVYceX9c
 4aq9MVIQF31zalcrYo/mZgQdW2Nt5DiDNEN/9wAeSLXw5WcutBaOlxbHlv4AWfFf2Wu2
 OsXrExEor3RtWRWdLoHomkMZp+zrumAMIuObd9hPEBujcqIfXwkUSdkocLwKZozkopqM
 U/aeE8nVF9Zowbz5tgTiQFlCEhUgAomrR9E5EumJ0lJkbmL5JgnHBOyxu89pWYRT/QGu
 Qlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787218124; x=1787822924;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FidK3aISQ8Cp/K2K6nkzmkNF3r3LcnckiLa+0JjVopU=;
 b=FRroNd4v9dx2adGdHVTiyC9oga0QDuwXcupWbH3R6ABOk+LLfr8HP1EzWwYlHQomt3
 /Hj+K670awoSJFcNxkiz5hD7Zv/b6GkL8O+iY6yZE8OP2+c59CJ9IvSCXmq8MV9PORWx
 cAbDlevHx8a0yWJCLb7Pphqcx9aAFWM7jN6NPODb0EX+4n6/annaCfdc181nwKiinX7X
 VzqZeNEBp1CPlo4/dGHH31+snX+IK6Cyyo76k/nUTetH9+GUoCeIJzcdpK/PVtld3+hc
 e6Yq+3Wx/PIey472Hq/C2yxzlzg/QDIM4/1NT4mgvJY4CkrceuVLPQ+yc0n3lcMW1yA6
 bWBQ==
X-Gm-Message-State: AOJu0Yx5HP7Hya/osKmjzjaHXmZ+/Fjo2d3x3gjPbyyRu9x5Bn/Dn99C
 1b1XIMIHVZJASO2XehWajgJWj9lPKT4mBs/064p1wtzFodWWviKRee7w
X-Gm-Gg: AR+sD13LFOzOtrMwKVdzhU50h42X7oYwXftL4B46TGyy9eyJ03GU6AkjekfNoR3AdG/
 /Q+LMEiGpwOwXjgJOEGTqq7mWgjyl+y9a0dKs1d1dybed8Ht2FgY5OzmuhDjOzpQGcYKbjtCb+c
 BrNozGdZpWyIyZbtVkNBQSzhNQGnSKy6a9x7e0AvVl+RT5wijIK2XaqaDxpDlBxI9Jhri/JkbCe
 mj/tQV/ftS3iyElM5NaLakm6ul7BeM0rZdJrljOkzvYg+4YM2LKuMqFVUIyAOYbg9RpVZgS9Kj4
 HqTektdw5DEcjGN4notA3hEZBkgvA0ULAFQ3YlZZQB+J00bwAJxEyFl0O2ydcYIZRymQkJ6NN+F
 6XXKyz/EYpScjnZraTBB+ovpYePZhyDVAIl+rhDiHREQTYfPLw8ddGlRR90zeQ87mS+IIgB4DVe
 PoMlgyV1p53Rd9iNOp8tXDQQs7K/YGTOo4tY1pAiHdKEhjo1FIMhz4q8+mmdGsz/+UykWUeDmpI
 fMq3BLyxXFI+C0cDrO4SvjT4loRxErhUqTBWNxECwjWNaRFryU=
X-Received: by 2002:a05:600c:628d:b0:499:8ae1:b900 with SMTP id
 5b1f17b1804b1-499aa1c9610mr210285705e9.12.1787218124407; 
 Thu, 20 Aug 2026 02:28:44 -0700 (PDT)
Received: from timur-max.localnet (161.red-79-154-233.dynamicip.rima-tde.net.
 [79.154.233.161]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1450fb9sm11550301f8f.14.2026.08.20.02.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 02:28:43 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Lancelot Six <lancelot.six@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 James Zhu <james.zhu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>
Subject: Re: [RFC PATCH 0/3] drm/amdgpu: Render-node second-level trap handler
Date: Thu, 20 Aug 2026 11:28:42 +0200
Message-ID: <fVqQkdSNQqGMlqwq2rRIgQ@gmail.com>
In-Reply-To: <20260820070143.3916329-1-srinivasan.shanmugam@amd.com>
References: <20260820070143.3916329-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. augusztus 20., cs=C3=BCt=C3=B6rt=C3=B6k 9:01:40 k=C3=B6z=C3=A9p-eu=
r=C3=B3pai ny=C3=A1ri id=C5=91 Srinivasan=20
Shanmugam wrote:
> When a GPU shader hits an error or exception, the hardware calls a trap
> handler. AMD GPUs support two levels: a first-level handler that runs
> inside the kernel (via CWSR), and an optional second-level handler that
> runs in userspace. The second-level handler lets a runtime or debugger
> catch shader exceptions without any kernel changes.
>=20
> KFD already provides this for compute workloads. Render-node user queues
> use the same first-level CWSR trap infrastructure but had no way to
> install a second-level handler. This series adds that support.

Hello Srini,

Thank you for working on this.
I notice that you mention user queues here. Does that mean that the new tra=
p=20
handler will only work with user queues? We would like to see it working wi=
th=20
kernel queues as well because:

1. User queues are not supported on GFX9, GFX10, GFX10.3
2. User queues are not enabled by default yet in the kernel=20
3. RADV currently can't use user queues on an GPU

Thanks & best regards,
Timur


>=20
> The second-level handler is a per-process (per-VM) setting. All shader
> queues belonging to the same process share the same hardware VMID, so
> one SET_L2_TRAP call covers every GFX and compute queue for that
> process. This setting belongs in the VM ioctl (DRM_AMDGPU_VM), not in
> the CWSR ioctl, because it is not specific to the first-level handler
> mechanism.
>=20
> UAPI backward compatibility
> ---------------------------
> The drm_amdgpu_vm_in struct gains a 32-byte union for the new op data.
> Existing ops (RESERVE/UNRESERVE_VMID) only use the first 8 bytes and
> are unaffected. The DRM framework automatically zero-fills the new fields
> for older userspace programs. No existing Mesa or ROCr code is broken.
>=20
> Implementation
> --------------
> On discrete GPUs the CWSR scratch buffer (TMA) may live in VRAM, which
> is accessed through MMIO on some CPU platforms. Direct CPU pointer writes
> are unsafe there. The driver uses struct iosys_map for all TMA writes,
> which picks the right accessor automatically (regular memory or MMIO).
>=20
> Installing a new TBA/TMA requires two separate memory writes, which
> creates a race: a shader that traps between the two writes would see a
> mismatched TBA/TMA pair and could crash. To prevent this, the driver
> stops all user queues, flushes the GPU TLB, writes both values, then
> restarts the queues.
>=20
> GEM_VA UNMAP and CLEAR operations must always succeed =E2=80=94 they cann=
ot
> return an error. If userspace removes a TBA or TMA buffer without first
> calling CLEAR_L2_TRAP, the driver detects the overlap, runs the same
> stop-flush-clear sequence, and lets the unmap proceed silently. Queues
> that lose their trap handler this way are marked invalid and not
> restarted =E2=80=94 a queue cannot safely run without a valid trap handle=
r.
>=20
> TTMP register layout
> --------------------
> When a shader wave enters the second-level trap handler, these hardware
> registers carry the relevant state:
>=20
>   ttmp0/1    faulting shader PC (set by hardware)
>   ttmp14/15  second-level TMA address (set by first-level handler)
>   ttmp2/3    free for the handler to use as temporaries
>   ttmp6[30]  wave stopped flag (set by second-level handler/debugger)
>   ttmp6[29]  saved halt flag (set by second-level handler/debugger)
>   ttmp11[23] debug mode enabled (set by first-level handler)
>=20
> Only compilation tested.
>=20
> Based on: amd-unified-interface branch
> Base commit: 0f354d789fdc ("drm/amdgpu: Drop vm_manager PASID to VM
>              mapping")
>=20
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: James Zhu <james.zhu@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Cc: Samuel Pitoiset <hakzsam@gmail.com>
> Cc: Natalie Vock <natalie.vock@gmx.de>
>=20
> Srinivasan Shanmugam (3):
>   drm/amdgpu/uapi: Add second-level trap handler ops to VM ioctl
>   drm/amdgpu: Add VM ioctl handlers for second-level trap handler
>   drm/amdgpu: Disable L2 trap handler when its VA range is unmapped
>=20
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c  | 341 ++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h  |  54 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c   |  24 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |   5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  15 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  26 ++
>  include/uapi/drm/amdgpu_drm.h             |  80 ++++-
>  8 files changed, 469 insertions(+), 77 deletions(-)
>=20
>=20
> base-commit: 0f354d789fdcd03147eb77ab2e3ecdd5a67a1fad




