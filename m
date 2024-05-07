Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198E0C04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 07:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 592B011347C;
	Wed,  8 May 2024 07:56:51 +0000 (UTC)
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Tue, 07 May 2024 16:44:12 UTC
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9D3510F831
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 16:44:12 +0000 (UTC)
Received: from beast.localdomain ([208.68.93.230]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MFvO4-1rrl3S0aVa-00EuaU; 
 Tue, 07 May 2024 18:39:08 +0200
Date: Tue, 7 May 2024 12:39:07 -0400
From: Jeremy Day <jsday@noreason.ca>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
Subject: [patch] problems with "fix visible VRAM handling during faults"
Message-Id: <20240507123907.3a39163546b4643c5d834522@noreason.ca>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1w5DeFGQTRf65MLHkZszy5ifC4Jd+37NF12FFUqaazSxpC3aALU
 RXbvGLo/fGtYJ+GT3iYHQWMnomvW4Zftew4ErmGW0CyG60BRYIVfBjNUW+Np/V75ceRDzj0
 QO5Z73H9t2JB5NtC1we1HUbxMN2x5d1veo9OEW3T9ao4CmC+/nJEVWzLaxqdihjKtoChhXL
 9tjjZuuNphKk3n5gttIvw==
UI-OutboundReport: notjunk:1;M01:P0:20gJ2u+7tKY=;MahfPrzGcnm13ZHyrcTniq8DbY5
 ounzSQMnZiY+A69zPNojYHbR2C1ZOl9aNP/ZfCTd4BWj/L02dexF6qQT2acvTqVcSNVUsxNfI
 EbiDkb3KQje7a7VjuG3kK9n5dOvvK7hqu1Lxj8ETIGto+FK6wYob5fZergjeoKX3KemHhRjrb
 zypwBIuC+1p5IV7ySxj0PhfEm6jmO89Mm5+04eX1rMq6Cu4lyeiF4gwHazaR4rxJOqubHR80+
 YgCXhH77OYM+ux6kadYw5gzksRSGhwOMRU8aHZLa/AzkhMIjgkukZzfWoC3W0xjr3JCztUp0G
 oYZzkmplUws5zledIMJQhTYgf1E4NO0zAdKgiB9v/vdDfAt9H+j0QQbkIEuFNKR9gsDNztGNc
 jNlWsoR9w7jaI5NSNkekwtfLtcsRVq9+83798tkKnp8OWasYN0RFlXNcKgjqvZi/uOaP96pq8
 QlLAlACyNoWOq7O2AKhkGHnBDfbgqLQpM2ln8ur9jDA86tQm11YuXhCxSTQBwkcFhHq81RsiY
 jwwjuKiGDTKs5SUi6z9NzhxpKMrqkj1xdLZliC6tPygHPul+OHLZDbaP1ZOm+g4IOUByGBBST
 FFJPOffE5ifJPlZQ6pf1Re3FNzugccvrlDvoC6fWQl0PWnr7DsNOCIl/N4w5QTP/TM/98XkSh
 6H0Ke3nZLZxCnrYa/wNwNJgl0NWGH/rBRPCop43h14Tvqh/eTzrf4hhBdKvO4zpiY47otXIvr
 batNH0dw6GzDfP+gwXCfEAKRTHFMT4oMSS/lsfNDrlyz5qw63VHFaE=
X-Mailman-Approved-At: Wed, 08 May 2024 07:56:50 +0000
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

This is just to report that I've had usually well-behaved applications
sometimes having problems with memory access violations since kernel
version 6.9-rc5.  This past weekend I stumbled across a way to reliably
reproduce the problem in the form of a Skyrim save file which causes a
crash shortly after loading the game on affected kernels.

Things go back to running smoothly only if I revert one of the changes
in 5th April's "[PATCH] drm/amdgpu: fix visible VRAM handling during
faults" as follows.

Patch is against v6.9-rc7.=A0 It restores the check for partially
visible-to-cpu memory in amdgpu_bo_fault_reserve_notify.=A0 Things
seem stable again with this change.

--
=A0drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |=A0 5 ++++-
=A0drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 22 ++++++++++++++++++++++
=A02 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index f6d503432a9e..a6874aea7820 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1396,7 +1396,10 @@ vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm=
_buffer_object *bo)
=A0=A0=A0=A0 /* Remember that this BO was accessed by the CPU */
=A0=A0=A0=A0 abo->flags |=3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
=A0
-=A0=A0=A0 if (amdgpu_res_cpu_visible(adev, bo->resource))
+=A0=A0=A0 if (bo->resource->mem_type !=3D TTM_PL_VRAM)
+=A0=A0=A0 =A0=A0=A0 return 0;
+
+=A0=A0=A0 if (amdgpu_bo_in_cpu_visible_vram(abo))
=A0=A0=A0=A0 =A0=A0=A0 return 0;
=A0
=A0=A0=A0=A0 /* Can't move a pinned BO to visible VRAM */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.h
index bc42ccbde659..0503af75dc26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -250,6 +250,28 @@ static inline u64 amdgpu_bo_mmap_offset(struct amdgpu_=
bo *bo)
=A0=A0=A0=A0 return drm_vma_node_offset_addr(&bo->tbo.base.vma_node);
=A0}
=A0
+/**
+ * amdgpu_bo_in_cpu_visible_vram - check if BO is (partly) in visible VRAM
+ */
+static inline bool amdgpu_bo_in_cpu_visible_vram(struct amdgpu_bo *bo)
+{
+=A0=A0=A0 struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
+=A0=A0=A0 struct amdgpu_res_cursor cursor;
+
+=A0=A0=A0 if (!bo->tbo.resource || bo->tbo.resource->mem_type !=3D TTM_PL_=
VRAM)
+=A0=A0=A0 =A0=A0=A0 return false;
+
+=A0=A0=A0 amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &curso=
r);
+=A0=A0=A0 while (cursor.remaining) {
+=A0=A0=A0 =A0=A0=A0 if (cursor.start < adev->gmc.visible_vram_size)
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return true;
+
+=A0=A0=A0 =A0=A0=A0 amdgpu_res_next(&cursor, cursor.size);
+=A0=A0=A0 }
+
+=A0=A0=A0 return false;
+}
+
=A0/**
=A0 * amdgpu_bo_explicit_sync - return whether the bo is explicitly synced
=A0 */
