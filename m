Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7438CA0FE9
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 21:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 549D810E588;
	Mon, 25 Aug 2025 21:56:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WBt8/hiX";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7119410E590
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 21:56:39 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-45a1b00f23eso28186315e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756158998; x=1756763798; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31qEYxPgy9n98QIoff944uwxuxfCsmB0FwR4TgYXmZ0=;
 b=WBt8/hiXHY8YJ6+3KyAVDmiPqYKdB4MI5wHNYRNtCROs+Epez9pp1i6gilIbimKnF7
 VsP0MdPPODpEVOe5JXzCACAMwhOVeZeUfOTDc/u8rgeoWGW6YLZrhl02lbU3qqRNcsKF
 QSvT5hbGmjeFSaK/I3vkOpl8fCZn/a7mpKa2T+SyF7zXIentCGTjtFBMr/A3djJDIvy+
 B0zFuw6NBW0QHfFcWaesMEGUWH8ighNE3JDAxknCNcyQhGj5kYbFhKSYEQJ8fdvBWMp7
 L2hZ4jv3wZJR3ZAfgECSt2JfGlWFsowjNkQx34iOKeUScdpCE+VsAA2orErb7+kpW7Vv
 GImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756158998; x=1756763798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=31qEYxPgy9n98QIoff944uwxuxfCsmB0FwR4TgYXmZ0=;
 b=n7JB72RCqloxjtcPhZcEmsHU4tzRDglrrjH/RqpO+mBnM1wYYlAfwepQpo31gejs7t
 Q4+ZC2/YPtl61zm0Cao+4WaLdRjy+z0F6Uj00jDLqG8uKEqY21Ta2mv6+hlSa5D6neBx
 dNnJNeoop9PR8RbBVF0Dx3zBpUpJ1Zhp3aDw7KxOrQFylKlSF2twj2NBLz7kOnJ9HyvA
 y9YEfFBkJgTOhC3lvTyHOAschZJ6wGuP3p8iOchhgHr7/hA5fXnkgUQsqNnpbah/j8le
 PPIbJmrWu1mj+ZPy3GsBxc6JjkV7aVnGZOtpJQQQM9W5j/HAmSGLFkd07jqUqHkbmtFy
 Ztmg==
X-Gm-Message-State: AOJu0YxmwLx9ON5hychxLyKp08EHbzT5oN2eTt8plQn5PYsmVOnEYjYm
 TBPdMcjfpxVDoXddmLMm4Y5RaQld6hfjATuy6QDicvUzm5Pa94ogwt7VenK8ZQ==
X-Gm-Gg: ASbGncskgWmhRgkPeJI+TLPM+AfzyOvK/j0/F0HB840Be26LhNCpIGosZ44GWUQ3+Bt
 SUvRA+LvsxfC0mRv9c0vLZsJRkrIRd2yrDrwJjxhhWVyf0clYYeGouc2SSBy7i4uEYnOX+OZ8MF
 WzIkCJGDvig82xatvu7tWlac4goV1YJstABaT7ub7fEDU7GqB+5rfArzZPJ3zy4sR6L/SsqoE2S
 IiZ8PyCi+nCVDTNBm8zwh7C+/m4sdRCU8m1R0963qRzoZT1Rzh+OieZ094EhEbHB/NfH1tNUXdQ
 BeDNUe5/js668Bcf6oB4vGcAizBrCAtvGlQE0oxhJdKRh22bGqLT+MHXLzxqNmMWUtUEAIZU1/k
 TBgXC8fggYveiB4NLBzsr71vJG0FdrJZPlqtYmXUC3+4AFzOWnbD8e0RQJbp6E2TK5Ukn95l0+O
 Zij7kYOpJZXVncsjdUgbQDaYABhg==
X-Google-Smtp-Source: AGHT+IHPm/6ntYzmrzNZoZKorXcRpb+l8y86lwh9Iyy7gBvcaBaelwrTeyECyG63x1jwkxg5tr1dWA==
X-Received: by 2002:a05:600c:4f03:b0:45b:5efb:2224 with SMTP id
 5b1f17b1804b1-45b60fb301emr38765625e9.23.1756158997855; 
 Mon, 25 Aug 2025 14:56:37 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57499143sm121827575e9.26.2025.08.25.14.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 14:56:37 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 3/4] drm/amd/display: Disable VRR on DCE 6
Date: Mon, 25 Aug 2025 23:56:30 +0200
Message-ID: <20250825215631.628949-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825215631.628949-1-timur.kristof@gmail.com>
References: <20250825215631.628949-1-timur.kristof@gmail.com>
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

DCE 6 was not advertised as being able to support VRR,
so let's mark it as unsupported for now.

The VRR implementation in amdgpu_dm depends on the VUPDATE
interrupt which is not registered for DCE 6.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
 drivers/gpu/drm/amd/display/dc/dc_helper.c        | 5 +++++
 drivers/gpu/drm/amd/display/dc/dm_services.h      | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b944abea306d..80a221b7b701 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10763,6 +10763,8 @@ static void get_freesync_config_for_crtc(
 		} else {
 			config.state = VRR_STATE_INACTIVE;
 		}
+	} else {
+		config.state = VRR_STATE_UNSUPPORTED;
 	}
 out:
 	new_crtc_state->freesync_config = config;
@@ -12664,7 +12666,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 
 	dm_con_state = to_dm_connector_state(connector->state);
 
-	if (!adev->dm.freesync_module)
+	if (!adev->dm.freesync_module || !dc_supports_vrr(sink->ctx->dce_version))
 		goto update;
 
 	edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index 51e41aed7316..5a365bd19933 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -755,3 +755,8 @@ char *dce_version_to_string(const int version)
 		return "Unknown";
 	}
 }
+
+bool dc_supports_vrr(const enum dce_version v)
+{
+	return v >= DCE_VERSION_8_0;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services.h b/drivers/gpu/drm/amd/display/dc/dm_services.h
index 7b9c22c45453..7b398d4f4439 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services.h
@@ -311,4 +311,6 @@ void dm_dtn_log_end(struct dc_context *ctx,
 
 char *dce_version_to_string(const int version);
 
+bool dc_supports_vrr(const enum dce_version v);
+
 #endif /* __DM_SERVICES_H__ */
-- 
2.50.1

