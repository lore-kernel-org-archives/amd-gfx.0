Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D1BC87FDA
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Aug 2025 16:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A164910E0FA;
	Sat,  2 Aug 2025 16:06:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GXp3rEu3";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95ACC10E05E
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 Aug 2025 16:06:08 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-458bc3ce3beso3265465e9.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 02 Aug 2025 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754150767; x=1754755567; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WGUdDrG4u4G11IhyLJAeGTzpaXW3V7jNcpVJw1BIoqY=;
 b=GXp3rEu3W029ZzPRqFyWPZFenXEhu1Pj0Q0n5KESekIg8r2/CtT4fL6urFHyHGFp+2
 S1qQpDicjzDzeN//sgWeezwthAGOHK2hFvN7kucXD/CF6vFbwf6CR/uB29pQLMYGtIcl
 F33ZvTbeRCIRI4/CFRelFsamWfzt5KhQf7Dlo+ReXNHGcJJR/qP5harnlng7GbnALSm5
 NwvBOc+mNi9K/arnOdKUfa3AxjsLMQWBZ6wvnUaR3FHxJ51K4shf4NfHi9Q6XHUB4CS7
 VDqRi4rpRddTRCdGPupZ3qm77ryODP0aibANtTYe3AX6fyW6mLuHmqS22EWYe6BBPv30
 WmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754150767; x=1754755567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WGUdDrG4u4G11IhyLJAeGTzpaXW3V7jNcpVJw1BIoqY=;
 b=eX4nTU2Nf7ojgY3GI5V43D8cYJbuGWWzwN+fKZQlAr8zFhcokC3Myb+mbZkdOP0L24
 +cvOKnUvSsCVqTe4OrHgXXpuwEjhTHnBjdBchLV5iRTENjDXyNo8YhR7Yqj89yJfna+n
 CMj4zPHcriECbw5aVQUZX1Z14atyvIMwlqdXP97RMHVuVVLD42FvpVYY20dWlH4j3OT9
 MIOggYRdFgKtt+HgwF62IiQTgLl9KlWiZyfA27YgWZFwUg4h0EIcPC62blgGnyXAdis3
 Af60KKqM0l8Dj9EUkbhEK2WNBGeFTVrvyjdwwO3136lgOnO9BHVgLSraXI4BnVGw7MNm
 Gx3g==
X-Gm-Message-State: AOJu0Ywk043ksr72jTTkN2r9Oti+hZWBkyKgulfeiCL0D//tIFd/oJYc
 OE3RaOVV+s+EiRmGqSlndgP+KDDlCr9aQhOMzCLcmuebtJJWfdH8ZUHg91DIIA==
X-Gm-Gg: ASbGnctNvJ2JPdbxqDebvEpX2aY+KldSA212crB/719arIQ5Qk2nrwVqk5o+5hp6sFN
 KW9tlERO54EPQ89jShGsIBbM50qOfDo+Nzdt8VMu+VzOsctgS+H9LReyjSBLR7YXmBpjep3i5ro
 qDIMrBgvdozd9nONh8S3hFjCjLkeC+xJ1MfoxmLqOOcES+QRmxd0bYdITaSUjCuO8FOKKJwqIVx
 /mW0XOIS0arFzQzezlDVsz31eD/99KbH7xrIqhuaTMBjVOwOlBZAIUZyKQRTfTcMlzZJxFQ6K2D
 Zq9G7E+pM9Qu2VdrJidpSG2kXmLKtRtkJzPOrwHh+tpfA6syi+L0iFf0MpzdSR/z8F3ir6FqrTD
 cpoSvOs3bf5M0ZcEXKEBOVJj9nCSoyyNIPfOOgjJTIUznfanJ9ykR0SeRoO5K4LThzBRWEut89e
 bP8u8sT3XWAlAduw1o90c=
X-Google-Smtp-Source: AGHT+IFN7KoTnpPzukEtpte/FZpc3wmYcj4VTagG9scW22LZUfFyd3hthN4a/iIrEYhgs+iU071O9Q==
X-Received: by 2002:a05:600c:4683:b0:43c:f8fc:f697 with SMTP id
 5b1f17b1804b1-458b69df312mr28080955e9.9.1754150767037; 
 Sat, 02 Aug 2025 09:06:07 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24DDB700267C66B850A0E369.dsl.pool.telekom.hu.
 [2001:4c4e:24dd:b700:267c:66b8:50a0:e369])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953cfcc1sm151164245e9.17.2025.08.02.09.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 09:06:06 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/3] drm/amd/display: Disable VRR on DCE 6
Date: Sat,  2 Aug 2025 18:06:01 +0200
Message-ID: <20250802160602.12698-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250802160602.12698-1-timur.kristof@gmail.com>
References: <20250802160602.12698-1-timur.kristof@gmail.com>
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
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
 drivers/gpu/drm/amd/display/dc/dc_helper.c        | 5 +++++
 drivers/gpu/drm/amd/display/dc/dm_services.h      | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c71167ffdb76..470f831a17f7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10689,6 +10689,8 @@ static void get_freesync_config_for_crtc(
 		} else {
 			config.state = VRR_STATE_INACTIVE;
 		}
+	} else {
+		config.state = VRR_STATE_UNSUPPORTED;
 	}
 out:
 	new_crtc_state->freesync_config = config;
@@ -12590,7 +12592,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 
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

