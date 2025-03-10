Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6E8C35FF1
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 18:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DE7510E4B1;
	Mon, 10 Mar 2025 18:05:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="RJT1vggF";
	dkim-atps=neutral
X-Greylist: delayed 308 seconds by postgrey-1.36 at gabe;
 Mon, 10 Mar 2025 17:14:00 UTC
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB21289854
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 17:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1741626839; x=1742231639; i=natalie.vock@gmx.de;
 bh=NLdUb3J3hUdjeoKHQenx8Vv2g2Jqhn3G5DlBASNBmEU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=RJT1vggFnFZ9tA6fWM4qtCdANJ8Sx5eIfAYh52iGfEEHNmXIOn8TdkLGEaeuUmlq
 mNlC/nSMFsrJrF+qK4UM5zuYUdwtLJoDDrURRWF6OohYn6wbZPhBwC+Av0B8SEupg
 U8fsZVf0Kr0SU3RYlVEOxXFfBKajEL4wZZp0hpsimz5tQwKPCd4EkVVdVYbeJgYEE
 mxW1Pacism5m477GMltkc6s9ep8XMDQefcp5FtaeAXiPL6UGZT/CkOdWtOwwSJTVy
 VoljY9dwO553CPSotHq6wDtwDmc4ZLiXcMGZun5ql0/eLp5Qh8+wfj8YKgXtEPQY6
 yJZxJmYLTBC4gGpUyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([109.91.201.165]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MlNp7-1tNsBR0fOv-00hCKq; Mon, 10 Mar 2025 18:08:40 +0100
From: Natalie Vock <natalie.vock@gmx.de>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
Subject: [PATCH] drm/amdgpu: NULL-check BO's backing store when determining
 GFX12 PTE flags
Date: Mon, 10 Mar 2025 18:08:05 +0100
Message-ID: <20250310170805.37536-1-natalie.vock@gmx.de>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RQ2FeHjj5xCFAy4SwxljmQNAnCsDEELlQiXVxXDzjAN3MaI2BIB
 Qa1P1QWSu/DTzai61n/+sMBuIJxB8e05IL8ZEV0ktQtw8yFrY5gDMTffU3py2zmA331MyNF
 9dNiK3+SmdOqyXkUoHHAlyBe95bE4woo/0rufL1j2PR/jF3jZHsI17TLjvq6O/FcgoQ3A/e
 XxevBehOK/3XLwgEA9MEQ==
UI-OutboundReport: notjunk:1;M01:P0:zK9Dhi7YI7I=;MiCFA1xJfDK2+G5E+YX561rKVrx
 GozGAsrtgltGNFta8Jog14CNRMvdsMxO/lKo/v1z237KaJHZ8m1b5YBPPy7nIblXTLKvpKLH+
 g+MNEZ1mscxc7sgd1CH78K+MAKiY/BNXbVBa/LjBYbrOwwsBp9Jvj3I3hCaM7eLr0yTtdSGFo
 aUpS1v4d4PgLnEbf+iRA1CCLCBTR8YmeMMCiRn9+RhQMl0htSGeD5YvqZpSfjrT5EkJXI1h3c
 Vm0P/umMNZtv3p59VGuor+7T9UWRXkEgbPLRjvryJ16BKKHQW6y9l6iiFDZS8RghI4rekRSSu
 T53sAhUBgRDTnHg6VHR9hAQuKjTIsnvPdh6XUh08azKET37OmQbZEV7M8UzCOiMkul7fdCaB2
 qcnfrjm4DvDWGrP0M4/T7d6J12TFqnCSnKQeNBkIyGubffLQn32FnwVEdwMEWRSB72/W5q3eN
 RJJkWGP5MWUQnctq4g3wYqvAy2bmKpO6e6GUyQQWJZmoHMldqVn9hmr4fyqeyzfD68/B9UZc3
 hld83Bxc1BW3D5jp9dQhqXMSBS3Ecd6YgLFhQ55otmvnO/ip7G7LZmCTgz36RsgKMtCM2cgDF
 9m9eGV4vmt9nhjf8HAyUvY14IHVetL+1YHlgL2xVQMjod1HHufyfv3NFFrnYNoceXI2YTOmHC
 7m2FF6Uz0vl82r8YP0+mLAeXLOfaLJsD7JMb5mDkh2U9CDKxCjib4CiaGpb2H7joIN94r05AI
 0cekmsZ0OPlZe7Nsg7lFoLHTHowDAZ0PQLa/VctT3GoaqbgIh3dYHfrnMe3I5KY3fxicO9iA+
 mldwOR0pe/YPSwmFKIK/s8EF3yl/NGeTKWRtk60fUKUsCnvnqJZOOuiW+HFfUIo+ZCU1c9TpU
 LLTAk/TZaIMsirlf9f2yyie8/MNdE3x6gh1/sFisQrrXwg2Bhvgmnx+AKu+I7k/TkRWkCosnA
 W7ThF1JFNNmM36HlEzeJC4PBVgZaDhbepg7NwGygvB1MDxP8L+qACWWnnKFcKVsLs2UhJsR2K
 /FQmPxUuP6sTI+M5aIcZUXb/LqM9o3OP+NEsbjxUVyKVbarq6khzyf+ZeweIvXrfi2JTdiRkH
 9DYbHVG3q/d6fzCCoxlHTWbe7g3Vl7Ij7wFyYDZHPc74vp4TX2sGomcZ5rl8EgT25zCyPQu5J
 mSS2tASb5L12284KkwzbuikEZYKHi4SW7FoS9TAMOs7FAVlgHTtnMGt/UUrpU8uvOOmCU+EEw
 mp/s+eY49mCT0O6a3q3itls27oGDeENhLPVmxWmYs7qycsGolvpO6J3OD4Wi7ONyp2Ar9miKj
 Ur7OdAjbUTTk5k4JVMzWywRRPDo8HbIeUG6GIxJzhvt4v+F4ZTrP41Rmuozdj2NeQ3QXfP2cA
 3EzaQFBobavxVOLszu4PDoS/H87VMIZIeoffVQN1JnPdPKbVEjMzic3j2S
X-Mailman-Approved-At: Mon, 10 Mar 2025 18:05:36 +0000
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

PRT BOs may not have any backing store, so bo->tbo.resource will be
NULL. Check for that before dereferencing.

Fixes: 0cce5f285d9ae8 ("drm/amdkfd: Check correct memory types for is_syst=
em variable")
Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v12_0.c
index ea7c32d8380ba..bf8d01da88154 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -528,8 +528,9 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device =
*adev,

 	bo_adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
 	coherent =3D bo->flags & AMDGPU_GEM_CREATE_COHERENT;
-	is_system =3D (bo->tbo.resource->mem_type =3D=3D TTM_PL_TT) ||
-		(bo->tbo.resource->mem_type =3D=3D AMDGPU_PL_PREEMPT);
+	is_system =3D bo->tbo.resource &&
+		(bo->tbo.resource->mem_type =3D=3D TTM_PL_TT ||
+		 bo->tbo.resource->mem_type =3D=3D AMDGPU_PL_PREEMPT);

 	if (bo && bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
 		*flags |=3D AMDGPU_PTE_DCC;
=2D-
2.48.1

