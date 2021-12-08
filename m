Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E67C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 03:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D58936E2B8;
	Wed,  8 Dec 2021 03:16:43 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BC406E22F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 01:32:47 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4J7zys51Y5zF4jS;
 Tue,  7 Dec 2021 17:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1638926789; bh=4wjioRyW3r+LOWxqSou972meOigDouk1tF80QrRy8nk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JyqVTIDJdiGTMWvqxFbALiUmdEVg3LTavZhaDMKc8mUCH7qh0H2YoT2mwii49hkVu
 7V/XdDNns2v4X7ttn/pfjUxDU9efXOJUa27oMzkLFQbaveSwVzd35G0BC1fUyduD2T
 5n1KVhnlAlFdpJ2LQxtVpG4MyysZTRy0gsWNkMKE=
X-Riseup-User-ID: DCEAEE24D4891B94813A37C355B45D58543A1AE3623A999559F706442D03A3B7
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4J7zyq2pblz5vkY;
 Tue,  7 Dec 2021 17:26:27 -0800 (PST)
From: Isabella Basso <isabbasso@riseup.net>
To: alexander.deucher@amd.com, christian.koenig@amd.com, daniel@ffwll.ch,
 harry.wentland@amd.com, Rodrigo.Siqueira@amd.com, Felix.Kuehling@amd.com
Subject: [PATCH 04/10] drm/amdgpu: fix function scopes
Date: Tue,  7 Dec 2021 22:25:23 -0300
Message-Id: <20211208012529.372478-5-isabbasso@riseup.net>
In-Reply-To: <20211208012529.372478-1-isabbasso@riseup.net>
References: <20211208012529.372478-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Dec 2021 03:16:41 +0000
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
Cc: ~lkcamp/patches@lists.sr.ht, Isabella Basso <isabbasso@riseup.net>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This turns previously global functions into static, thus removing
compile-time warnings such as:

 warning: no previous prototype for 'release_psp_cmd_buf' [-Wmissing-prototypes]
 521 | void release_psp_cmd_buf(struct psp_context *psp)
     |      ^~~~~~~~~~~~~~~~~~~
 ...
 warning: no previous prototype for 'amdgpu_vkms_output_init' [-Wmissing-prototypes]
 399 | int amdgpu_vkms_output_init(struct drm_device *dev,
     |     ^~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index af3a2f8c12b4..96895cccf9e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -411,8 +411,8 @@ static struct drm_plane *amdgpu_vkms_plane_init(struct drm_device *dev,
 	return plane;
 }
 
-int amdgpu_vkms_output_init(struct drm_device *dev,
-			    struct amdgpu_vkms_output *output, int index)
+static int amdgpu_vkms_output_init(struct drm_device *dev, struct
+				   amdgpu_vkms_output *output, int index)
 {
 	struct drm_connector *connector = &output->connector;
 	struct drm_encoder *encoder = &output->encoder;
-- 
2.34.1

