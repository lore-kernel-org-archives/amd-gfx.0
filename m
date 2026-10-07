Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FBCCA600A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 13:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E5B510F5AB;
	Wed,  7 Oct 2026 13:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i1KEddqY";
	dkim-atps=neutral
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0663310E5D8
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 13:13:28 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id
 38308e7fff4ca-3a76ac0bdafso16683411fa.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2026 06:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791378806; x=1791983606; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YHXWb/yE7fhA7aF15l/F01Ze1XYkmrkzVKkvR/gzDUc=;
 b=i1KEddqYPfaCeVRDCnm3T7dPPg+iwWyMM07HLERnP5wlUJibnI9YNsP5OC3G4XNpA3
 NzRyOcbcGwAqfmYVyu8RNpUTTmWdrdKhKNqPcpT4sGk5tnGkocFQq52CKWb4PpFIlL0S
 H6hymAXYrd8GmaCnLsl08ofhwuLUyUwRN/Q+p/lKSeJtVwg4jI9v0rytAuvzZXOYEw1M
 8z01m8vVRVdZTeafUX0VmPEQBaZP9lPA7Q0oEIQ6Af8JOARvhG5NEps9lNhTCP5Lt6yX
 pSkB1+PnHDYlbZ8JZFAchhWykkgYwrbns01oTEalTJZi3WMhIbySuUsYQtXMSJm1Zcht
 mM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791378806; x=1791983606;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YHXWb/yE7fhA7aF15l/F01Ze1XYkmrkzVKkvR/gzDUc=;
 b=QeRVMMjzcRcr/E17ZwwUEcBy4iYPBZvU6c6Fz3RQExthVYsDIlfHlqeUVUJsU+7P7Y
 6d3w1y5Ybs4XXNzS161vEfSaJ8Ro7k3jCq/SYexYMWbVcjxkRpewpZ8NyHRR50Co7INA
 LOywrtcJ/e9sabnejKm9LZtkgw0HKPwo6QWU/Q1UY59JvQibwu16M36UIq6OEaynoJNg
 FCpwHRTxlmZo6O+vHmPzABwxhSoArLvv0WThS5TdHZE0rik1ioR8jmQ3UqttW0OF8W5W
 Gm6M2mRVWDlQ6tBXJHRz0O+WwMAeFaEIeHbR4moRBAYoYWQVMl62ijcOdy8Mf4HxJaIS
 pN4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+U5hFdpcee0K2k4EY+EbX1xQuDMn6d73UfD9fazIJUjuVP2yFOg+WRMdHzHBJ7Gi+i1ioMR/x@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIBvI4uepbeogoRcUo+Z7iyDR3trgwq0Vq9k9tHGUuBOFwchQjk
 +/Et63dwCHpi8r3R3Ri12q3cCHSTCyFZ84M/iiCgASeXOxP1eEhu8+MM
X-Gm-Gg: AYBFou2/CESo+xQSmNj8oTrOhBCDIiAhkYrU6PcdVCipLkzRTpdDT/AtHzZAmKwtfka
 3j8119z5+fqzip+ekDhkz4/Dk4VNzmobFrxsnYIspsVRBUVW2VL+n78M8jK02Uhj0lbk1rFFQ+x
 ZabeBkFShNctnyxMsoFkL0uNAY23SfzIh1dDYOdqOBOTyBjqargr4UdwxD0Gv1rs/NQ9DFFIGVN
 2LunZkW8yUFCxFDWna+Nm11rsNeIA2TKMgQ9QclpBHGLzABNN9hvftOoBu84lXOXVDIthxy+Iu9
 fdptw1i2jpxFqK6pX/U13S9mX5d6EFe0FHyhGDGwqqfOzsP/09Z0goZgPxBQzq9I4Z4EM4Dnmku
 MrFajSkb1/6i0QO/Ovmv7c9gXBp9QE/8B7cQK02gmVVHBQfe7VKOR3yy216glKPijoiIbx1TV/g
 W+HYLsi0wS9JRQx6TNqHfAfReWePovwuiQxyqKUh9l7SuE5VTpmWy5WBMNloIad6yvY6iKDb3MB
 AlecH7taKh6Fyz0
X-Received: by 2002:a05:651c:1547:b0:3a7:7cb7:6fc1 with SMTP id
 38308e7fff4ca-3a99432d1c2mr14198961fa.18.1791378805693; 
 Wed, 07 Oct 2026 06:13:25 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9a1d32eb1sm6158821fa.8.2026.10.07.06.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 06:13:25 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Ray Wu <ray.wu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 5.10/5.15] drm/amd/display: Fix out-of-bounds read in
 dp_get_eq_aux_rd_interval()
Date: Wed,  7 Oct 2026 16:13:12 +0300
Message-ID: <20261007131314.120362-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 07 Oct 2026 13:22:26 +0000
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

From: Harry Wentland <harry.wentland@amd.com>

commit e8b4d37eba05141ee01794fc6b7f2da808cee83b upstream.

[Why & How]
The aux_rd_interval array in struct dc_lttpr_caps is declared with
MAX_REPEATER_CNT - 1 (7) elements, indexed 0..6. However, the offset
parameter passed to dp_get_eq_aux_rd_interval() can be as large as
MAX_REPEATER_CNT (8) when a sink reports 8 LTTPR repeaters via DPCD.
This leads to an out-of-bounds read of aux_rd_interval[7] when offset
is 8.

Fix this by growing aux_rd_interval to MAX_REPEATER_CNT elements to
accommodate the full range of valid repeater counts defined by the DP
spec.

Assisted-by: GitHub Copilot:Claude claude-4-opus
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit a55a458a8df37a65ffda5cf721d554a8f74f6b04)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-53330

 drivers/gpu/drm/amd/display/dc/dc_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index c8c2ba7e7b05..6cce8dd64bff 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -433,7 +433,7 @@ struct dc_lttpr_caps {
 	uint8_t max_link_rate;
 	uint8_t phy_repeater_cnt;
 	uint8_t max_ext_timeout;
-	uint8_t aux_rd_interval[MAX_REPEATER_CNT - 1];
+	uint8_t aux_rd_interval[MAX_REPEATER_CNT];
 };
 
 struct dc_dongle_caps {
-- 
2.53.0

