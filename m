Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761FDC3DA70
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 07:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB89810E1D5;
	Wed, 24 Jul 2024 07:09:07 +0000 (UTC)
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Wed, 24 Jul 2024 07:09:04 UTC
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [207.211.30.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B051710E1D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 07:09:04 +0000 (UTC)
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-N3AixW39MGWjIj9d4kWSnQ-1; Wed,
 24 Jul 2024 03:02:08 -0400
X-MC-Unique: N3AixW39MGWjIj9d4kWSnQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD6061955D4B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 07:02:07 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.64.136.40])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66A951955D44
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 07:02:06 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amdgpu: allow setting contiguous on non-kernel bos for
 placement
Date: Wed, 24 Jul 2024 17:02:04 +1000
Message-ID: <20240724070204.1862904-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

This is a partial revert of drm/amdgpu: Modify the contiguous flags behavio=
ur.

This broke VCN AV1 decoding on radv video on GFX11.

On VCN4 only the first VCN block has AV1 decode support, so the kernel has
a hacky heurisitic to work out from the submitted IB if it's AV1.
YOU COULD HAVE PUT A FLAG ON THE BO SUBMISSION YOU KNOW!.

Now in order to access the submitted IB, it has to mark it as contiguous,
so the ioremap can work on it so the kernel can access the contents.

However this buffer isn't a kernel buffer, so the new check introduced
in the above commit, breaks the whole show. I'm not sure why vaapi
manages to avoid this fate, but it does somehow. Anyways this restores
the behaviour from before.

Fixes: 143c51da8dba ("drm/amdgpu: Modify the contiguous flags behaviour")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 706345ea1430..b3ee952f68d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -153,8 +153,7 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *=
abo, u32 domain)
 =09=09else
 =09=09=09places[c].flags |=3D TTM_PL_FLAG_TOPDOWN;
=20
-=09=09if (abo->tbo.type =3D=3D ttm_bo_type_kernel &&
-=09=09    flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
+=09=09if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
 =09=09=09places[c].flags |=3D TTM_PL_FLAG_CONTIGUOUS;
=20
 =09=09c++;
--=20
2.45.2

