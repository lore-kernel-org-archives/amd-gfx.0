Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD15C531C9
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 16:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3317710E498;
	Mon, 27 Jul 2026 16:11:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=improbability.net header.i=@improbability.net header.b="ME9lUMSm";
	dkim-atps=neutral
X-Greylist: delayed 306 seconds by postgrey-1.36 at gabe;
 Mon, 27 Jul 2026 16:11:46 UTC
Received: from mail-139-mta238.mxyeet.net (mail-139-mta238.mxyeet.net
 [23.172.139.238])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B7A510E474
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 16:11:46 +0000 (UTC)
Received: from uk-shared01.cpanelplatform.com ([162.244.95.12]
 uk-shared01.cpanelplatform.com)
 (Authenticated sender: relay@mxyeet.net)
 by mail-139-mta238.mxyeet.net (MailFilter Outbound) with ESMTPSA id
 19fa4540ddd0007739.001 for <amd-gfx@lists.freedesktop.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 27 Jul 2026 16:06:39 +0000
X-Originating-IP: [162.244.95.12]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=improbability.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R2saVkJ8P4r2NedzRD8r7ugieS1FvlZcB8VY6Z0VHfA=; b=ME9lUMSmHQdtHgXRnKb6ug6G4/
 0B0xdqkiBZdub/XSBbuwllTKAgvswAhmH0Kuif5AUckWUFLVzjO2LBaqC2ORsK0OvoqKldFpxka1j
 f92hmej+18xNHhVyJNhIOtyldlEaLFD+sJYskbarUarcByHeNfm2Y4F4JClGHxPWRr9Ja82rU93H1
 i1ktp4Yvh6GalZf34S3lOkPSZ1ycPEOlSuLC+1s6N9Ibw6gLsGre434ISHmBn2+2jdozzJppyzdFB
 j4uOqrFe+CqTnU9MuSygR2ioXxiOj8rHoYf8dchBpiUB3FW2T5KKQC2wEWKWHBXHTS9n2lbbmwPH6
 VNhImMdA==;
Received: from slartibartfast.improbability.net ([51.155.134.81]:41492)
 by uk-shared01.cpanelplatform.com with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (Exim 4.99.4)
 (envelope-from <reiver@improbability.net>) id 1woNqh-0000000BXh5-08Rr
 for amd-gfx@lists.freedesktop.org; Mon, 27 Jul 2026 16:06:38 +0000
Received: from trillian.improbability.net (trillian.improbability.net
 [192.168.1.20])
 by slartibartfast.improbability.net (Postfix) with ESMTPSA id A6C623FC34;
 Mon, 27 Jul 2026 17:01:32 +0100 (BST)
From: Alan Swanson <reiver@improbability.net>
To: amd-gfx@lists.freedesktop.org
Cc: Alan Swanson <reiver@improbability.net>
Subject: [PATCH] drm/amd/display: Silence link_dpms I2C retimer failures
Date: Mon, 27 Jul 2026 17:01:26 +0100
Message-ID: <20260727160126.9758-1-reiver@improbability.net>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-From-Rewrite: unmodified,
 there is a forwarder that points to the actual sender.
X-AuthUser: alan@improbability.net
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

Commit a4f01bf729b2 ("drm/amd/display: Refactor and fix link_dpms I2C")
had also changed the "Set retimer failed" messages from DC_LOG_DEBUG()
to DC_LOG_ERROR(). This unfortunately can create log spam.

Change those back to DC_LOG_DEBUG() only.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5520
Signed-off-by: Alan Swanson <reiver@improbability.net>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 335ae952ef..1f7060ed49 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -384,7 +384,7 @@ static bool write_i2c_retimer_vga(
 
 	for (size_t i = 0; i < ARRAY_SIZE(vga_data); i++) {
 		if (!write_i2c_retimer_offset_value(link, address, vga_data[i][0], vga_data[i][1])) {
-			DC_LOG_ERROR("Set retimer failed, vga index: %zu\n", i);
+			DC_LOG_DEBUG("Set retimer failed, vga index: %zu\n", i);
 			return false;
 		}
 	}
@@ -405,7 +405,7 @@ static bool write_i2c_retimer_byte(
 		return true;
 
 	if (!write_i2c_retimer_offset_value(link, address, index, value)) {
-		DC_LOG_ERROR("Set retimer failed, 3g index: 0x%x, value: 0x%x\n", index, value);
+		DC_LOG_DEBUG("Set retimer failed, 3g index: 0x%x, value: 0x%x\n", index, value);
 		return false;
 	}
 
@@ -421,14 +421,14 @@ static bool write_i2c_retimer_byte(
 			if (!link_query_ddc_data(
 					link->ddc, address, &offset, 1, &value, 1
 			)) {
-				DC_LOG_ERROR("Set retimer failed, link_query_ddc_data\n");
+				DC_LOG_DEBUG("Set retimer failed, link_query_ddc_data\n");
 				return false;
 			}
 		}
 
 		value |= apply_rx_tx_change;
 		if (!write_i2c_retimer_offset_value(link, address, offset, value)) {
-			DC_LOG_ERROR("Set retimer failed, 3g offset: 0x%x, value: 0x%x\n", offset, value);
+			DC_LOG_DEBUG("Set retimer failed, 3g offset: 0x%x, value: 0x%x\n", offset, value);
 			return false;
 		}
 	}
@@ -449,7 +449,7 @@ static bool write_i2c_retimer_setting(
 		uint8_t value = settings->reg_settings[i].i2c_reg_val;
 
 		if (!write_i2c_retimer_byte(link, address, index, value)) {
-			DC_LOG_ERROR("Set retimer failed, index: %zu\n", i);
+			DC_LOG_DEBUG("Set retimer failed, index: %zu\n", i);
 			return false;
 		}
 	}
@@ -460,7 +460,7 @@ static bool write_i2c_retimer_setting(
 			uint8_t value = settings->reg_settings_6g[i].i2c_reg_val;
 
 			if (!write_i2c_retimer_byte(link, address, index, value)) {
-				DC_LOG_ERROR("Set retimer failed, 6g index: %zu\n", i);
+				DC_LOG_DEBUG("Set retimer failed, 6g index: %zu\n", i);
 				return false;
 			}
 		}
@@ -492,7 +492,7 @@ static bool write_i2c_default_retimer_setting(
 
 	for (size_t i = 0; i < ARRAY_SIZE(data); i++) {
 		if (!write_i2c_retimer_offset_value(link, address, data[i][0], data[i][1])) {
-			DC_LOG_ERROR("Set default retimer failed, index: %zu\n", i);
+			DC_LOG_DEBUG("Set default retimer failed, index: %zu\n", i);
 			return false;
 		}
 	}
@@ -524,7 +524,7 @@ static bool write_i2c_redriver_setting(
 	);
 
 	if (!success)
-		DC_LOG_ERROR("Set redriver failed");
+		DC_LOG_DEBUG("Set redriver failed");
 	return success;
 }
 
-- 
2.54.0

