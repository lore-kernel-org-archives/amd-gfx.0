Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8D7C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 23 May 2022 00:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D7A10EB4F;
	Mon, 23 May 2022 00:32:03 +0000 (UTC)
X-Greylist: delayed 351 seconds by postgrey-1.36 at gabe;
 Mon, 23 May 2022 00:32:02 UTC
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [207.211.30.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2716310EB4F
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 May 2022 00:32:02 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-w8l-Wa5EN2aFFVUoeLc7IA-1; Sun, 22 May 2022 20:24:21 -0400
X-MC-Unique: w8l-Wa5EN2aFFVUoeLc7IA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B39A08032E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 May 2022 00:24:20 +0000 (UTC)
Received: from dreadlord-bne-redhat-com.bne.redhat.com
 (fdacunha.bne.redhat.com [10.64.0.157])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF88A1410DD5
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 May 2022 00:24:19 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/cs: make commands with 0 chunks illegal behaviour.
Date: Mon, 23 May 2022 10:24:18 +1000
Message-Id: <20220523002418.3652481-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
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

From: Dave Airlie <airlied@redhat.com>

Submitting a cs with 0 chunks, causes an oops later, found trying
to execute the wrong userspace driver.

MESA_LOADER_DRIVER_OVERRIDE=3Dv3d glxinfo

[172536.665184] BUG: kernel NULL pointer dereference, address: 000000000000=
01d8
[172536.665188] #PF: supervisor read access in kernel mode
[172536.665189] #PF: error_code(0x0000) - not-present page
[172536.665191] PGD 6712a0067 P4D 6712a0067 PUD 5af9ff067 PMD 0
[172536.665195] Oops: 0000 [#1] SMP NOPTI
[172536.665197] CPU: 7 PID: 2769838 Comm: glxinfo Tainted: P           O   =
   5.10.81 #1-NixOS
[172536.665199] Hardware name: To be filled by O.E.M. To be filled by O.E.M=
./CROSSHAIR V FORMULA-Z, BIOS 2201 03/23/2015
[172536.665272] RIP: 0010:amdgpu_cs_ioctl+0x96/0x1ce0 [amdgpu]
[172536.665274] Code: 75 18 00 00 4c 8b b2 88 00 00 00 8b 46 08 48 89 54 24=
 68 49 89 f7 4c 89 5c 24 60 31 d2 4c 89 74 24 30 85 c0 0f 85 c0 01 00 00 <4=
8> 83 ba d8 01 00 00 00 48 8b b4 24 90 00 00 00 74 16 48 8b 46 10
[172536.665276] RSP: 0018:ffffb47c0e81bbe0 EFLAGS: 00010246
[172536.665277] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000=
000000
[172536.665278] RDX: 0000000000000000 RSI: ffffb47c0e81be28 RDI: ffffb47c0e=
81bd68
[172536.665279] RBP: ffff936524080010 R08: 0000000000000000 R09: ffffb47c0e=
81be38
[172536.665281] R10: ffff936524080010 R11: ffff936524080000 R12: ffffb47c0e=
81bc40
[172536.665282] R13: ffffb47c0e81be28 R14: ffff9367bc410000 R15: ffffb47c0e=
81be28
[172536.665283] FS:  00007fe35e05d740(0000) GS:ffff936c1edc0000(0000) knlGS=
:0000000000000000
[172536.665284] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[172536.665286] CR2: 00000000000001d8 CR3: 0000000532e46000 CR4: 0000000000=
0406e0
[172536.665287] Call Trace:
[172536.665322]  ? amdgpu_cs_find_mapping+0x110/0x110 [amdgpu]
[172536.665332]  drm_ioctl_kernel+0xaa/0xf0 [drm]
[172536.665338]  drm_ioctl+0x201/0x3b0 [drm]
[172536.665369]  ? amdgpu_cs_find_mapping+0x110/0x110 [amdgpu]
[172536.665372]  ? selinux_file_ioctl+0x135/0x230
[172536.665399]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
[172536.665403]  __x64_sys_ioctl+0x83/0xb0
[172536.665406]  do_syscall_64+0x33/0x40
[172536.665409]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2018
Reported-by: Michael Bishop
Signed-off-by: Dave Airlie <airlied@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_cs.c
index d0d0ea565e3d..2019622191b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -116,7 +116,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parse=
r *p, union drm_amdgpu_cs
 =09int ret;
=20
 =09if (cs->in.num_chunks =3D=3D 0)
-=09=09return 0;
+=09=09return -EINVAL;
=20
 =09chunk_array =3D kvmalloc_array(cs->in.num_chunks, sizeof(uint64_t), GFP=
_KERNEL);
 =09if (!chunk_array)
--=20
2.35.3

