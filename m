Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E642C48260
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Feb 2024 15:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BF3510EA13;
	Fri, 16 Feb 2024 15:13:58 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com
 [209.85.219.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDA6A10E4FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 09:22:57 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id
 3f1490d57ef6-dcbf82cdf05so2026590276.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 01:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yonsei.ac.kr; s=google; t=1708075377; x=1708680177;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QK7RSGhRGhAYluYLZRc4m+UH8KdSTmnyn3tYH7tcnXs=;
 b=PNCbZHNA9kbyhWboNoVEtFg7Q+rXS4VpBYdhs0FRvwd2D6hDAXSeD7U71omSzs+Lcr
 H8beXCPK8seCE19BWTCtZ5ebkm9RNjITzE5Cm2Z18xsST9a5Rhtb5FRvwM/dvOjRq4AB
 aGbDxBnue78Zqx3hUafNdBWX1/x0WY3WJiRaG8F+vIwvH3ySklTMm94RprlYBUZJ8xGw
 fQU30FMrUeGRXy7d0wXKNFP7alF74NRfkEtFxUFUK8nKulqBzddv/J8rP2/bs24rPzDT
 CBtVfDtd+hkCEqF8hTacrpZCK6trpopn9bYylfndjdHhHLecRRfp/WUspVdLy9T57k43
 qSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708075377; x=1708680177;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QK7RSGhRGhAYluYLZRc4m+UH8KdSTmnyn3tYH7tcnXs=;
 b=RijUbnErvzIFaGtmVUtkB4lRmBnL5OYIu0Ma/SPYex7KX2dFYr5l5fF6kbZyRynYr2
 gLgDMTWxeDRrWhTCqTHbANJKFUfwjD5Asxd/bxJ2n0hrmecaIl9+B37W/nDD3M4XB8nj
 q8mj5LOmXSE+aRnewYuweuPEoohYPcWNbc34g/7afHdapYk+E9xBkzuBVjUEJ6MBE+i6
 ufCja7USU1dlN4vuwTI3ly1V547MYljZ8nW3nMP9azUv8ttvKrbs/YhPNZ5xE/lQo/wV
 60qjbwmGnZ7ok1eMFiqNlLZLYn+ZKCJTSwY58Tk3SJtolFTGEEcHfYsEa0zZQp6njhgY
 iXSQ==
X-Gm-Message-State: AOJu0YxB3guVgEP8H6HqMZ2gtZTw13YPuywr6IzJfXyhlmdLz8z53zpF
 aoL9frODTh1N0UL9OScaawgjr/YDnP3wHwQG0xpWrfj+iL7WnM4nm/T91bQ4VDVdYQn3GtLDdQa
 LpvLQh3oEVeECNYCFky6y/ReINa8Rs04qUwJkZaJOFIpr81YoIl9diw==
X-Google-Smtp-Source: AGHT+IGEpzEju1nI+8+xLJcvwNld7cAlkrvMlSOLyi4j+/EeVuQKZx5OYOTVeC9vGjJ7qoNYQjleHHKYjBjR/yzjvJg=
X-Received: by 2002:a25:dc47:0:b0:dcc:9dcc:a433 with SMTP id
 y68-20020a25dc47000000b00dcc9dcca433mr4016768ybe.54.1708075376978; Fri, 16
 Feb 2024 01:22:56 -0800 (PST)
MIME-Version: 1.0
From: Joonkyo Jung <joonkyoj@yonsei.ac.kr>
Date: Fri, 16 Feb 2024 18:22:46 +0900
Message-ID: <CAKc8oVUXUHUYQSDYDZ3XqpfwcmOwoxii5+SkyteXoZSPRwshfQ@mail.gmail.com>
Subject: Reporting a slab-use-after-free in amdgpu
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com
Cc: amd-gfx@lists.freedesktop.org, Dokyung Song <dokyungs@yonsei.ac.kr>, 
 jisoo.jang@yonsei.ac.kr, yw9865@yonsei.ac.kr
Content-Type: multipart/alternative; boundary="000000000000183f7406117c4acf"
X-Mailman-Approved-At: Fri, 16 Feb 2024 15:13:57 +0000
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

--000000000000183f7406117c4acf
Content-Type: text/plain; charset="UTF-8"

Hello,

We would like to report a slab-use-after-free bug in the AMDGPU DRM driver
in the linux kernel v6.8-rc4 that we found with our customized Syzkaller.
The bug can be triggered by sending two ioctls to the AMDGPU DRM driver in
succession.

In amdgpu_bo_move, struct ttm_resource *old_mem = bo->resource is assigned.
As you can see on the alloc & free stack calls, on the same function
amdgpu_bo_move,
amdgpu_move_blit in the end frees bo->resource at ttm_bo_move_accel_cleanup
with ttm_bo_wait_free_node(bo, man->use_tt).
But amdgpu_bo_move continues after that, reaching trace_amdgpu_bo_move(abo,
new_mem->mem_type, old_mem->mem_type) at the end, causing the
use-after-free bug.

Steps to reproduce are as below.
union drm_amdgpu_gem_create *arg1;

arg1 = malloc(sizeof(union drm_amdgpu_gem_create));
arg1->in.bo_size = 0x8;
arg1->in.alignment = 0x0;
arg1->in.domains = 0x4;
arg1->in.domain_flags = 0x9;
ioctl(fd, 0xc0206440, arg1);

arg1->in.bo_size = 0x7fffffff;
arg1->in.alignment = 0x0;
arg1->in.domains = 0x4;
arg1->in.domain_flags = 0x9;
ioctl(fd, 0xc0206440, arg1);

The KASAN report is as follows:
==================================================================
BUG: KASAN: slab-use-after-free in amdgpu_bo_move+0x1479/0x1550
Read of size 4 at addr ffff88800f5bee80 by task syz-executor/219
Call Trace:
 <TASK>
 amdgpu_bo_move+0x1479/0x1550
 ttm_bo_handle_move_mem+0x4d0/0x700
 ttm_mem_evict_first+0x945/0x1230
 ttm_bo_mem_space+0x6c7/0x940
 ttm_bo_validate+0x286/0x650
 ttm_bo_init_reserved+0x34c/0x490
 amdgpu_bo_create+0x94b/0x1610
 amdgpu_bo_create_user+0xa3/0x130
 amdgpu_gem_create_ioctl+0x4bc/0xc10
 drm_ioctl_kernel+0x300/0x410
 drm_ioctl+0x648/0xb30
 amdgpu_drm_ioctl+0xc8/0x160
 </TASK>

Allocated by task 219:
 kmalloc_trace+0x211/0x390
 amdgpu_vram_mgr_new+0x1d6/0xbe0
 ttm_resource_alloc+0xfd/0x1e0
 ttm_bo_mem_space+0x255/0x940
 ttm_bo_validate+0x286/0x650
 ttm_bo_init_reserved+0x34c/0x490
 amdgpu_bo_create+0x94b/0x1610
 amdgpu_bo_create_user+0xa3/0x130
 amdgpu_gem_create_ioctl+0x4bc/0xc10
 drm_ioctl_kernel+0x300/0x410
 drm_ioctl+0x648/0xb30
 amdgpu_drm_ioctl+0xc8/0x160

Freed by task 219:
 kfree+0x111/0x2d0
 ttm_resource_free+0x17e/0x1e0
 ttm_bo_move_accel_cleanup+0x77e/0x9b0
 amdgpu_move_blit+0x3db/0x670
 amdgpu_bo_move+0xfa2/0x1550
 ttm_bo_handle_move_mem+0x4d0/0x700
 ttm_mem_evict_first+0x945/0x1230
 ttm_bo_mem_space+0x6c7/0x940
 ttm_bo_validate+0x286/0x650
 ttm_bo_init_reserved+0x34c/0x490
 amdgpu_bo_create+0x94b/0x1610
 amdgpu_bo_create_user+0xa3/0x130
 amdgpu_gem_create_ioctl+0x4bc/0xc10
 drm_ioctl_kernel+0x300/0x410
 drm_ioctl+0x648/0xb30
 amdgpu_drm_ioctl+0xc8/0x160

The buggy address belongs to the object at ffff88800f5bee70
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 16 bytes inside of
 freed 96-byte region [ffff88800f5bee70, ffff88800f5beed0)

Should you need any more information, please do not hesitate to contact us.

Best regards,
Joonkyo Jung

--000000000000183f7406117c4acf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>We would like to report a slab-use-after-fre=
e bug in the AMDGPU DRM driver in the linux kernel v6.8-rc4 that we found w=
ith our customized Syzkaller.<br>The bug can be triggered by sending two io=
ctls to the AMDGPU DRM driver in succession.<br><br>In amdgpu_bo_move, stru=
ct ttm_resource *old_mem =3D bo-&gt;resource is assigned.<br>As you can see=
 on the alloc &amp; free stack calls, on the same function amdgpu_bo_move,<=
br>amdgpu_move_blit in the end frees bo-&gt;resource at ttm_bo_move_accel_c=
leanup with ttm_bo_wait_free_node(bo, man-&gt;use_tt).<br>But amdgpu_bo_mov=
e continues after that, reaching trace_amdgpu_bo_move(abo, new_mem-&gt;mem_=
type, old_mem-&gt;mem_type) at the end, causing the use-after-free bug.<br>=
<br>Steps to reproduce are as below.<br>union drm_amdgpu_gem_create *arg1;<=
br><br>arg1 =3D malloc(sizeof(union drm_amdgpu_gem_create));<br>arg1-&gt;in=
.bo_size =3D 0x8;<br>arg1-&gt;in.alignment =3D 0x0;<br>arg1-&gt;in.domains =
=3D 0x4;<br>arg1-&gt;in.domain_flags =3D 0x9;<br>ioctl(fd, 0xc0206440, arg1=
);<br><br>arg1-&gt;in.bo_size =3D 0x7fffffff;<br>arg1-&gt;in.alignment =3D =
0x0;<br>arg1-&gt;in.domains =3D 0x4;<br>arg1-&gt;in.domain_flags =3D 0x9;<b=
r>ioctl(fd, 0xc0206440, arg1);<br><br>The KASAN report is as follows:<br>=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>BUG: KASAN: slab-use-af=
ter-free in amdgpu_bo_move+0x1479/0x1550<br>Read of size 4 at addr ffff8880=
0f5bee80 by task syz-executor/219<br>Call Trace:<br>=C2=A0&lt;TASK&gt;<br>=
=C2=A0amdgpu_bo_move+0x1479/0x1550<br>=C2=A0ttm_bo_handle_move_mem+0x4d0/0x=
700<br>=C2=A0ttm_mem_evict_first+0x945/0x1230<br>=C2=A0ttm_bo_mem_space+0x6=
c7/0x940<br>=C2=A0ttm_bo_validate+0x286/0x650<br>=C2=A0ttm_bo_init_reserved=
+0x34c/0x490<br>=C2=A0amdgpu_bo_create+0x94b/0x1610<br>=C2=A0amdgpu_bo_crea=
te_user+0xa3/0x130<br>=C2=A0amdgpu_gem_create_ioctl+0x4bc/0xc10<br>=C2=A0dr=
m_ioctl_kernel+0x300/0x410<br>=C2=A0drm_ioctl+0x648/0xb30<br>=C2=A0amdgpu_d=
rm_ioctl+0xc8/0x160<br>=C2=A0&lt;/TASK&gt;<br><br>Allocated by task 219:<br=
>=C2=A0kmalloc_trace+0x211/0x390<br>=C2=A0amdgpu_vram_mgr_new+0x1d6/0xbe0<b=
r>=C2=A0ttm_resource_alloc+0xfd/0x1e0<br>=C2=A0ttm_bo_mem_space+0x255/0x940=
<br>=C2=A0ttm_bo_validate+0x286/0x650<br>=C2=A0ttm_bo_init_reserved+0x34c/0=
x490<br>=C2=A0amdgpu_bo_create+0x94b/0x1610<br>=C2=A0amdgpu_bo_create_user+=
0xa3/0x130<br>=C2=A0amdgpu_gem_create_ioctl+0x4bc/0xc10<br>=C2=A0drm_ioctl_=
kernel+0x300/0x410<br>=C2=A0drm_ioctl+0x648/0xb30<br>=C2=A0amdgpu_drm_ioctl=
+0xc8/0x160<br><br>Freed by task 219:<br>=C2=A0kfree+0x111/0x2d0<br>=C2=A0t=
tm_resource_free+0x17e/0x1e0<br>=C2=A0ttm_bo_move_accel_cleanup+0x77e/0x9b0=
<br>=C2=A0amdgpu_move_blit+0x3db/0x670<br>=C2=A0amdgpu_bo_move+0xfa2/0x1550=
<br>=C2=A0ttm_bo_handle_move_mem+0x4d0/0x700<br>=C2=A0ttm_mem_evict_first+0=
x945/0x1230<br>=C2=A0ttm_bo_mem_space+0x6c7/0x940<br>=C2=A0ttm_bo_validate+=
0x286/0x650<br>=C2=A0ttm_bo_init_reserved+0x34c/0x490<br>=C2=A0amdgpu_bo_cr=
eate+0x94b/0x1610<br>=C2=A0amdgpu_bo_create_user+0xa3/0x130<br>=C2=A0amdgpu=
_gem_create_ioctl+0x4bc/0xc10<br>=C2=A0drm_ioctl_kernel+0x300/0x410<br>=C2=
=A0drm_ioctl+0x648/0xb30<br>=C2=A0amdgpu_drm_ioctl+0xc8/0x160<br><br>The bu=
ggy address belongs to the object at ffff88800f5bee70<br>=C2=A0which belong=
s to the cache kmalloc-96 of size 96<br>The buggy address is located 16 byt=
es inside of<br>=C2=A0freed 96-byte region [ffff88800f5bee70, ffff88800f5be=
ed0)<br><br>Should you need any more information, please do not hesitate to=
 contact us.<br><br>Best regards,<br>Joonkyo Jung<br></div>

--000000000000183f7406117c4acf--
