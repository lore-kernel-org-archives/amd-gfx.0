Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66822C4451C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 12:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E288510E46C;
	Fri, 17 Jul 2026 12:57:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="cFW2i29Z";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E98B710F35F
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 15:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1784215775; x=1784820575; i=spasswolf@web.de;
 bh=1rrZbpfSwCPI7v7lO6BE14DEuFmvQoXffFaZKGt5Yfw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=cFW2i29ZSsLYbmt6q0fVbj5uplXb4LWrXiQ3ADgRm6lOaGvy2k9ev9DiypJcJqsX
 VJTEGSkKhGZBpqQB/APnkp4C2F/T7C1k93V1e9g3P6/Yqc7hM9T4xUnF9kSLvUcSL
 UlWMLS5WS+OUHHR5jFPy5hRjLV5mH4ZJLZIBsdUHNnt2c1NqvgdFl7BwP0ZN0t51x
 fy/gbo+0I2cLQCA6xgPTNmItyRlWYc0NXRdD+hP/MgFY073ZG3XOVr6u4r6Tp6HNP
 z9pRpetzu+2fmGoBi6EloohX6k+nn5J6Yv69e6Z3vLL1frkAjSbxSu6hlxNty9W2u
 sMzS5h2/QeeVPDRx+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSIJ0-1wZH8R0caO-00ILCm; Thu, 16
 Jul 2026 17:29:35 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-next@vger.kernel.org, Jesse Zhang <jesse.zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: warnings from validate_blend_mode_for_alpha_formats() in next-20260715
Date: Thu, 16 Jul 2026 17:29:32 +0200
Message-ID: <20260716152933.6744-1-spasswolf@web.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LmItngSJEVU6JglhCCMAXmHoFf5ask6YwQHW8TbS9FjzMq1VMMm
 TK+cf+z2WQvRSU/Sd5r0py/649qXlLTBj7sAILW0bXIxrVYbYjUkllLfNoXusg+p+L/R0jF
 0ma3FjE8Y7FQYK7ak7t/HrHL12IRg0KA2vkOAqcu4OgwBzDQ61nzHP0NRlhp4UIdTw8UqoX
 2N4VtpVjC4g/6DKF5ysug==
UI-OutboundReport: notjunk:1;M01:P0:lCpfGVqZKjk=;mQvtPOvowaFmWjHv+uUKDcghszF
 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
X-Mailman-Approved-At: Fri, 17 Jul 2026 12:57:14 +0000
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

commit 860e748bddcc ("drm: ensure blend mode supported if pixel format wit=
h alpha exposed")
introduces validate_blend_mode_for_alpha_formats() which prints warnings f=
or amdpgu as=20
amdgpu only set blend_mode_property for planes of type DRM_PLANE_TYPE_OVER=
LAY. I tried to fix
this by removing he (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY) check in a=
mdgpu_dm_plane_init():

	printk(KERN_INFO "%s: plane=3D%px plane->type=3D0x%x plane_cap=3D%px\n", =
__func__, plane, plane->type, plane_cap);
	if (plane_cap)
		printk(KERN_INFO "%s: per_pixel_alpha =3D%u\n", __func__, plane_cap->per=
_pixel_alpha);
	if (plane_cap && plane_cap->per_pixel_alpha) {
		unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE) |
					  BIT(DRM_MODE_BLEND_PREMULTI) |
					  BIT(DRM_MODE_BLEND_COVERAGE);

		printk(KERN_INFO "%s: creating alpha and blend mode properties for plane=
 %px\n", __func__, plane);
		drm_plane_create_alpha_property(plane);
		drm_plane_create_blend_mode_property(plane, blend_caps);
	}

But this does not completely silence the warnings becuase for planes of ty=
pe DRM_PLANE_TYPE_CURSOR plane_cap is NULL.
Is this a problem that should be fixed in amdgpu or is should validate_ble=
nd_mode_for_alpha_formats() only be called
for planes of certain types?

Bert Karwatzki
  =20
