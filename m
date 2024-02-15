Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99571C48BEB
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 09:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E401510E423;
	Thu, 15 Feb 2024 09:03:46 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com
 [209.85.219.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5436A10E130
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 02:35:03 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id
 3f1490d57ef6-dc6d9a8815fso365029276.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yonsei.ac.kr; s=google; t=1707964502; x=1708569302;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ADIAZLg5NyPcjgvQblup/JkjHZ5QIpm5enZ4VNREUZo=;
 b=l8dLmB3rTGNUm6oQ2XScZwrxxW4NHqdIcDdBgzW2opTjLz0HChUojRJ1DnryJDwx1n
 zKY2LG2P/GPjJgSKTfZJTrEpqOTnnoifqVzZQSd9s+/kgQYFSJjlTdVQUJ7ESpOr5qeO
 Dqa3XWalY+Ha/+XhnORM8ljVRzIDLq9v30X93CJ6O5DSW/+BpgNcJY1ZsqHAcGumRpJa
 Af/ccqJVWQNl8ICFxSY0MKD3xBCl+kf9lp1eEAAr3IIws6N01HhzWPdmMH0UUcZ0pe1j
 bci2Unc26DR0Vr9OAOU0gaTmf3Fvvng7GYeeZtoRyOqSM1+HeOd39SAtZYrKKx1WYHQt
 rC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707964502; x=1708569302;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ADIAZLg5NyPcjgvQblup/JkjHZ5QIpm5enZ4VNREUZo=;
 b=ABw7yq6+25Ec1BpJNTkKx3mTnHVBdrKnk3wzbpN1u+t02GUUMQzXL1AAY2p7oCKlfa
 zXjyGQ63L/D0tsMkUcH/Js4qciguyPfTH18fds8g2nnmYqCU867/HxKkd/7/Rs56q5Q8
 nDqxC0YwmNgGKq4pjqWKY/OOzLFT9CHs0TptH9Xj7/LyJpRuKgoN0LVmOwcPekB73QEk
 QA6BYjN42onaI6ouBmrpyWNCyvYfX/NcVQvHK+ESmksz5W+YmeS890D8k4dSR8TVzyyX
 hSMC+XFTnqsGGouyKsY6ONwwoTatPJHzfR/12fHB+czS1sH30MbwtLo6BSRcbqBgr8Fl
 4VjQ==
X-Gm-Message-State: AOJu0Yzy3XW+ZHGybZRi7NFr5txTXBfF3n6GvrTLLmuj0ISZDR0m/uds
 Jg4XVxuSwAAHcOUWXzqpBxMGwYTBm0FrVbiGELunkdEHs4xH8lUdMFIfynGdegfmGDbS3CkKdtn
 VIAMC1ByUgMBP0mVWg5isESM+FAChLWtHT1UtYQ==
X-Google-Smtp-Source: AGHT+IEXuuF4ErTszfIvKd7vhUm+3tUrYG1fc/pQgUs5vvilzQ9SQdl1wduR4CyBGK6bOVTxALV+51WG4Q4sJIqP2BM=
X-Received: by 2002:a5b:e88:0:b0:dcb:e462:6e10 with SMTP id
 z8-20020a5b0e88000000b00dcbe4626e10mr453284ybr.58.1707964502234; Wed, 14 Feb
 2024 18:35:02 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?7KCV7KSA6rWQ?= <joonkyoj@yonsei.ac.kr>
Date: Thu, 15 Feb 2024 11:34:51 +0900
Message-ID: <CAKc8oVXOjNZLcJWh0+a8E7ttYxoH8sGNcu-Z4YAyey2CnuTyQQ@mail.gmail.com>
Subject: Reporting a use-after-free in amdgpu
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com
Cc: amd-gfx@lists.freedesktop.org, Dokyung Song <dokyungs@yonsei.ac.kr>, 
 jisoo.jang@yonsei.ac.kr, yw9865@yonsei.ac.kr
Content-Type: multipart/alternative; boundary="00000000000071f602061162794c"
X-Mailman-Approved-At: Thu, 15 Feb 2024 09:03:41 +0000
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

--00000000000071f602061162794c
Content-Type: text/plain; charset="UTF-8"

Hello,

We would like to report a use-after-free bug in the AMDGPU DRM driver in
the linux kernel 6.2 that we found with our customized Syzkaller.
The bug can be triggered by sending a single amdgpu_gem_userptr_ioctl to
the AMDGPU DRM driver, with invalid addr and size.
We have tested that this bug can still be triggered in the latest RC
kernel, v6.8-rc4.

Steps to reproduce are as below.

struct drm_amdgpu_gem_userptr *arg;
arg = malloc(sizeof(struct drm_amdgpu_gem_userptr));
arg->addr = 0xffffffffffff0000;
arg->size = 0x80000000;
arg->flags = 0x7;
ioctl(AMDGPU_renderD128_DEVICE_FILE, 0xc1186451, arg);

The KASAN report is as follows:
==================================================================
BUG: KASAN: use-after-free in switch_mm_irqs_off+0x89d/0xb70
Read of size 8 at addr ffff88801f17bc00 by task syz-executor/386
Call Trace:
<TASK>
switch_mm_irqs_off+0x89d/0xb70
__schedule+0xa62/0x2630
preempt_schedule_common+0x45/0xd0
vfree+0x4d/0x60
ttm_tt_fini+0xdf/0x1c0
amdgpu_ttm_backend_destroy+0x9f/0xe0
ttm_bo_cleanup_memtype_use+0x142/0x1f0
ttm_bo_release+0x67d/0xc00
ttm_bo_put+0x7c/0xa0
amdgpu_bo_unref+0x3b/0x80
amdgpu_gem_object_free+0x7f/0xc0
drm_gem_object_free+0x5d/0x90
amdgpu_gem_userptr_ioctl+0x452/0x7e0
drm_ioctl_kernel+0x284/0x500
drm_ioctl+0x55e/0xa50
amdgpu_drm_ioctl+0xe3/0x1d0
</TASK>

Allocated by task 385:
kmem_cache_alloc+0x174/0x300
copy_process+0x32d1/0x6640
kernel_clone+0xcd/0x690

Freed by task 386:
kmem_cache_free+0x13b/0x550
mmu_interval_notifier_remove+0x4c8/0x610
amdgpu_hmm_unregister+0x47/0x90
amdgpu_gem_object_free+0x75/0xc0
drm_gem_object_free+0x5d/0x90
amdgpu_gem_userptr_ioctl+0x452/0x7e0
drm_ioctl_kernel+0x284/0x500
drm_ioctl+0x55e/0xa50
amdgpu_drm_ioctl+0xe3/0x1d0

The buggy address belongs to the object at ffff88801f17bb80
which belongs to the cache mm_struct of size 2016
The buggy address is located 128 bytes inside of
2016-byte region [ffff88801f17bb80, ffff88801f17c360)

The buggy address belongs to the physical page:
page:000000002c2a61bd refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x1f178
head:000000002c2a61bd order:3 compound_mapcount:0 subpages_mapcount:0
compound_pincount:0
memcg:ffff8880141aa301
flags: 0x100000000010200(slab|head|node=0|zone=1)
raw: 0100000000010200 ffff88800a44fc80 ffffea00006ca400 dead000000000004
raw: 0000000000000000 00000000800f000f 00000001ffffffff ffff8880141aa301
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff88801f17bb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88801f17bb80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801f17bc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff88801f17bc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff88801f17bd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

--00000000000071f602061162794c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>We would like to report a use-after-free bug=
 in the AMDGPU DRM driver in the linux kernel 6.2 that we found with our cu=
stomized Syzkaller.<br>The bug can be triggered by sending a single amdgpu_=
gem_userptr_ioctl to the AMDGPU DRM driver, with invalid addr and size. <br=
>We have tested that this bug can still be triggered in the latest RC kerne=
l, v6.8-rc4.<br><br>Steps to reproduce are as below.<br><br>struct drm_amdg=
pu_gem_userptr *arg;<br>arg =3D malloc(sizeof(struct drm_amdgpu_gem_userptr=
));<br>arg-&gt;addr =3D 0xffffffffffff0000;<br>arg-&gt;size =3D 0x80000000;=
<br>arg-&gt;flags =3D 0x7;<br>ioctl(AMDGPU_renderD128_DEVICE_FILE, 0xc11864=
51, arg);<br><br>The KASAN report is as follows:<br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>BUG: KASAN: use-after-free in switch_mm_irqs=
_off+0x89d/0xb70<br>Read of size 8 at addr ffff88801f17bc00 by task syz-exe=
cutor/386<br>Call Trace:<br>&lt;TASK&gt;<br>switch_mm_irqs_off+0x89d/0xb70<=
br>__schedule+0xa62/0x2630<br>preempt_schedule_common+0x45/0xd0<br>vfree+0x=
4d/0x60<br>ttm_tt_fini+0xdf/0x1c0<br>amdgpu_ttm_backend_destroy+0x9f/0xe0<b=
r>ttm_bo_cleanup_memtype_use+0x142/0x1f0<br>ttm_bo_release+0x67d/0xc00<br>t=
tm_bo_put+0x7c/0xa0<br>amdgpu_bo_unref+0x3b/0x80<br>amdgpu_gem_object_free+=
0x7f/0xc0<br>drm_gem_object_free+0x5d/0x90<br>amdgpu_gem_userptr_ioctl+0x45=
2/0x7e0<br>drm_ioctl_kernel+0x284/0x500<br>drm_ioctl+0x55e/0xa50<br>amdgpu_=
drm_ioctl+0xe3/0x1d0<br>&lt;/TASK&gt;<br><br>Allocated by task 385:<br>kmem=
_cache_alloc+0x174/0x300<br>copy_process+0x32d1/0x6640<br>kernel_clone+0xcd=
/0x690<br><br>Freed by task 386:<br>kmem_cache_free+0x13b/0x550<br>mmu_inte=
rval_notifier_remove+0x4c8/0x610<br>amdgpu_hmm_unregister+0x47/0x90<br>amdg=
pu_gem_object_free+0x75/0xc0<br>drm_gem_object_free+0x5d/0x90<br>amdgpu_gem=
_userptr_ioctl+0x452/0x7e0<br>drm_ioctl_kernel+0x284/0x500<br>drm_ioctl+0x5=
5e/0xa50<br>amdgpu_drm_ioctl+0xe3/0x1d0<br><br>The buggy address belongs to=
 the object at ffff88801f17bb80<br>which belongs to the cache mm_struct of =
size 2016<br>The buggy address is located 128 bytes inside of<br>2016-byte =
region [ffff88801f17bb80, ffff88801f17c360)<br><br>The buggy address belong=
s to the physical page:<br>page:000000002c2a61bd refcount:1 mapcount:0 mapp=
ing:0000000000000000 index:0x0 pfn:0x1f178<br>head:000000002c2a61bd order:3=
 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0<br>memcg:ffff8=
880141aa301<br>flags: 0x100000000010200(slab|head|node=3D0|zone=3D1)<br>raw=
: 0100000000010200 ffff88800a44fc80 ffffea00006ca400 dead000000000004<br>ra=
w: 0000000000000000 00000000800f000f 00000001ffffffff ffff8880141aa301<br>p=
age dumped because: kasan: bad access detected<br><br>Memory state around t=
he buggy address:<br>ffff88801f17bb00: fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc<br>ffff88801f17bb80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb<br>&gt;ffff88801f17bc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb<br>^<br>ffff88801f17bc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb<br>ffff88801f17bd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb<br>=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>

--00000000000071f602061162794c--
