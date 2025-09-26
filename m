Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2DFCAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1646310EAB1;
	Fri, 26 Sep 2025 18:02:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OfxEYLpD";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2EE110EAB1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:02:21 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-24457f581aeso25525205ad.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909741; x=1759514541; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jq9EkizHbueee6bQjcWIkh2x0VT+LH+7aCNELhm5gZM=;
 b=OfxEYLpDQrC/OMNeisGLohl/R8N96YNE+2CJjgYHboWPLTy/9yLW3sS1TioLUDtKiN
 WeifwzbFYIJ42JB3HIzyZAZRtWxk4ymad+TuHaPlUzA8N/9IfU6Zm9vqcxf+Bk+Y2Tva
 FZba4bjpLuthdMZFOip7dEJTbfIHbdLAQIOok+f28XoTfy8qxsxPqnDGulZFLxzUHg0C
 B5w628/Va3Axs2+ErN2BB9ogvGmJM+ehQWr/WqL+1bRKKal9j7ibQi5behLoQQVtoYQb
 MtJqkGRnoBpaLrhx1B8Mhy4sRiMLaJZeiFiKANJW4i8TCc61RC0tBT3/7dabpe35DXqh
 ouoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909741; x=1759514541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jq9EkizHbueee6bQjcWIkh2x0VT+LH+7aCNELhm5gZM=;
 b=MuOrvawlW4xjFRVjBvoralhP4tiv/wOFhsUJcRFVMsl46oMGSPtBQfj6rS8kfYVnZn
 4GvJqRx49hGo76nwvPySpYzgdcjkJNSuN3uuDrkQsAexKkywfdziQanDXG/2RsNPxkME
 +k7je7EDE0JEle49u3xMvAfTbGZvFH1SySkH8Kpm/+z5BihHqUkqaGpIhC61F3qo8LMm
 NbBmJtIRVwX4BAALYFJIHY6w3/r7l0sGzqJ3eWY1NuFLDmwUu8DB48HXr6mwrvr9B+DL
 Z91zWDr8QhUUNhhIgMjwoE8IxBulU3ixK3yr1CUUWIJ6cAIDgccJbpaaDdkPtD6NAhKN
 H80A==
X-Gm-Message-State: AOJu0YyuShPvd10lbT8uVw/sfEDbA1co2OQclNd2ud24Zihb/VIdLp7i
 Bm3dW6vQTNxpnagg4yr4DubjI+XUk/RoIOVIFukfK9MY7KKDpp92sDSpIQ334w==
X-Gm-Gg: ASbGncuTDfDvyI1CoCSkKp/XrbCjoLJPjS+j21n09nFURKSlYTze4ebPJFdWtjpjvWJ
 8JTBJCLxPbGST6bchbl29tzWtopQvvXyMK5FZ8gC4fSF+wE/aBlJikujx2Ubudqe6okaGKRkJ7T
 z0ys4uCsnFLBEjguZtJj55SgyZgl8IH70++HtrKQ432BFDRepc88YGlP+Os74EPCHKkiVDvyDml
 evkGSJ5RqQ9xnxBG3jrLfnL/I6LcjGEn2vuR940FYdDSoSoy6l6ktjtu+GgT7k9wuL1Fe0y6oSD
 l27aB8YQEzfua43NwDhQ9RD5Me8lJlqkTx+5SDJCusNAdGlzjf3+HQkej9aSC4LFuItSm1XCjBN
 OwdWy+OUM5Rz/Hid9Cbs1Hrv92GVcGpvVQrFx5BShmbfqYZqxTquYoHmNWBlXvm2n5OPgPTui8n
 y5/xcALfqQfKkkdX65CMnnuwPdVRsCRQ==
X-Google-Smtp-Source: AGHT+IEZdhcq80445yHOv63ltelc2vSXEJz++1Ki5tl65+4UcAUOFtP4wqlxApR5Ae/8k79U8etJAQ==
X-Received: by 2002:a17:902:dac9:b0:252:1743:de67 with SMTP id
 d9443c01a7336-27ed4ac4cdamr81517355ad.44.1758909740953; 
 Fri, 26 Sep 2025 11:02:20 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:02:20 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 01/23] drm/amd/display: Determine DVI-I connector type (v2)
Date: Fri, 26 Sep 2025 20:01:41 +0200
Message-ID: <20250926180203.16690-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926180203.16690-1-timur.kristof@gmail.com>
References: <20250926180203.16690-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

DC determines the DRM connector type based on the
signal type, which becomes problematic when a connector may
support different signal types, such as DVI-I.
With this patch, it is now determined according to the actual
connector type for DVI-D and DVI-I connectors.

Also set the HPD (hotplug detection) flag for DVI-I connectors
to prevent regressing their digital functionality, which has
been already working.

A subsequent commit will also implement polling for DVI-I.

v2:
Only use connector type for DVI to prevent regressions
for other signal types.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 20ab9fd1b82a..4a9109818672 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8133,7 +8133,7 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
 	return 0;
 }
 
-static int to_drm_connector_type(enum signal_type st)
+static int to_drm_connector_type(enum signal_type st, uint32_t connector_id)
 {
 	switch (st) {
 	case SIGNAL_TYPE_HDMI_TYPE_A:
@@ -8149,6 +8149,10 @@ static int to_drm_connector_type(enum signal_type st)
 		return DRM_MODE_CONNECTOR_DisplayPort;
 	case SIGNAL_TYPE_DVI_DUAL_LINK:
 	case SIGNAL_TYPE_DVI_SINGLE_LINK:
+		if (connector_id == CONNECTOR_ID_SINGLE_LINK_DVII ||
+			connector_id == CONNECTOR_ID_DUAL_LINK_DVII)
+			return DRM_MODE_CONNECTOR_DVII;
+
 		return DRM_MODE_CONNECTOR_DVID;
 	case SIGNAL_TYPE_VIRTUAL:
 		return DRM_MODE_CONNECTOR_VIRTUAL;
@@ -8538,6 +8542,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 			link->link_enc->features.dp_ycbcr420_supported ? true : false;
 		break;
 	case DRM_MODE_CONNECTOR_DVID:
+	case DRM_MODE_CONNECTOR_DVII:
 		aconnector->base.polled = DRM_CONNECTOR_POLL_HPD;
 		break;
 	default:
@@ -8741,7 +8746,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 		goto out_free;
 	}
 
-	connector_type = to_drm_connector_type(link->connector_signal);
+	connector_type = to_drm_connector_type(link->connector_signal, link->link_id.id);
 
 	res = drm_connector_init_with_ddc(
 			dm->ddev,
-- 
2.51.0

