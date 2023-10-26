Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D1AC25B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 22:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4E6510E8C9;
	Thu, 26 Oct 2023 22:43:09 +0000 (UTC)
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch
 [185.70.41.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A753610E8C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 22:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1698357960; x=1698617160;
 bh=iDHvr1obDqtrBvl3wQmr+KfyB7cWQHyCMr+f/ySgMaE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=RW3aEA++COOJvLG7XEDesYOZIy8uk8d2UwLW4kMKmuEa3oInMF3+3acUSiF5g2xDU
 GgcunAUMp7Neg/lf8l0aYqA9calVvwV0cDhCCDRgY1ZaGrktDakVL5IiY9p1TF0g4W
 8Ybe0A3y2GAzkgNiPPaCnOcFdMX1KeMrUeVubCZQzjAgrht3YzzfgiehLummWGE44s
 JWWG3Za9MmSMhkyUniJKiLHXfuXF2ydltxC0pt8WpqX2iW1MNKHliIMk5oU7ReZG7r
 U/3j7ETUPb1c0SHB85c1v3qWXsvIABg/flWbNlps5zKKXUdid8AC7X3Yh/TrWhnZZ4
 Ya7PEHkU442fg==
Date: Thu, 26 Oct 2023 22:05:57 +0000
To: neil.armstrong@linaro.org
From: Umio Yasuno <coelacanth_dream@protonmail.com>
Subject: [PATCH 2/2] drm/amdgpu: Remove unused variables from
 amdgpu_show_fdinfo
Message-ID: <20231026220525.23682-2-coelacanth_dream@protonmail.com>
In-Reply-To: <20231026220525.23682-1-coelacanth_dream@protonmail.com>
References: <20231026220525.23682-1-coelacanth_dream@protonmail.com>
Feedback-ID: 19510729:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 26 Oct 2023 22:43:05 +0000
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
Cc: robdclark@chromium.org, shashank.sharma@amd.com,
 amd-gfx@lists.freedesktop.org, robdclark@gmail.com, alexander.deucher@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove unused variables from amdgpu_show_fdinfo

Signed-off-by: Umio Yasuno <coelacanth_dream@protonmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_fdinfo.c
index e9b5d1903..b960ca7ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -55,21 +55,15 @@ static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] =3D=
 {
=20
 void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 {
-=09struct amdgpu_device *adev =3D drm_to_adev(file->minor->dev);
 =09struct amdgpu_fpriv *fpriv =3D file->driver_priv;
 =09struct amdgpu_vm *vm =3D &fpriv->vm;
=20
 =09struct amdgpu_mem_stats stats;
 =09ktime_t usage[AMDGPU_HW_IP_NUM];
-=09uint32_t bus, dev, fn, domain;
 =09unsigned int hw_ip;
 =09int ret;
=20
 =09memset(&stats, 0, sizeof(stats));
-=09bus =3D adev->pdev->bus->number;
-=09domain =3D pci_domain_nr(adev->pdev->bus);
-=09dev =3D PCI_SLOT(adev->pdev->devfn);
-=09fn =3D PCI_FUNC(adev->pdev->devfn);
=20
 =09ret =3D amdgpu_bo_reserve(vm->root.bo, false);
 =09if (ret)
--=20
2.42.0


