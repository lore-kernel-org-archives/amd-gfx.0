Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08A3D1951A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 21:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2910010E4A1;
	Mon, 26 Jan 2026 21:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EoJMiyML";
	dkim-atps=neutral
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F1810E4A1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 21:08:47 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so3205295f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 13:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769461726; x=1770066526; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPaHIMlZ4Vr2/mvggxBULuZsCAjIcIpBQk70WmOJdwA=;
 b=EoJMiyMLFGofcEZsYBikBXJdmoH056gYUwB8LM1wuLweg1iJ0cFWrvmiznWQdzRbKA
 R88pngIzi9ix0agM+HsolTmbdccDAQkgSqXbCPiNwGPsi0qAmLztPgUdUEq5r4YKhPb3
 caHB9xB3iBOP8dTKIw1yoU2JrmJ5IkCYTo+XV5c1yLw8e3rFssafUBauEAS9Eq7uAshL
 hccGtHAPKE8rU4j+T7waO82rfZ4Y8LpX7O2dkeLpCqzAYKqp2VYZEcLbur1PkeUDfdIp
 p+/kaDxWOPMvycWg/fVJ/G8sutMTpaw1NhFRW0lAdX1oztqoS4w2C4imfd6Hu1G5bpq6
 0EHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461726; x=1770066526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bPaHIMlZ4Vr2/mvggxBULuZsCAjIcIpBQk70WmOJdwA=;
 b=IpemNiPT6iZDqD3IhQx6252MzlZFYNo2xiDp9g6ngw922wrMYBONQHIlC/Pgmg7MN3
 8y3GvZl1n2Ei4S+aRjFEvThDoj3V3MnRaUEx8zaT3eqWk+tZLTT4ING/gjQu3xwUmJMh
 kzuRBGjhGVmamsF+Qm5TdQREynMSMB3uVMy9B8yC35G18nx8p9JgRc/BMyDquojesS34
 PGf/iftKwqwqJhiEOOmKAWdkSRo/X9fCVBYXf9JM6HNGSiy8lauQjbeITeAQiS+xtt0W
 zQAYYGZmT2kWUlCg3SF28FOYF/UJpU88TsTr4Hezf1fuaAbBWZ+NXhR//SZ7lwPz3F1L
 pHiQ==
X-Gm-Message-State: AOJu0YxX2WWPyHc/mBwipmS/gSKWK1cCRAdshQdATqSYCAJpY33xA/8f
 Z4MxX4Kk16t/rig3ekOn+YWTo1jMjXdlir7mZZsZ/30D+GLKbhVwrG7ByhzcJHuE
X-Gm-Gg: AZuq6aLOsz4wF8QQ+PY+lob98/wLlsqwSNVAlUPiduxcVrP6Cu82lq6Hnmpk7E6KbcK
 zx0YDhq+b0MU+ivuNgQmBZ4UIJFqW5dd9VDAJ2sD2YgJPhMs8IOCV4AaxnW2g46/e4PRzEi23sg
 wbAupfG+XjzevcR5jb6RrTHJdh82ZSX2/8EY40l1wcwlEhUP0q1boJJ5GctAWv/7VMREZxuNpm+
 2dfQXHLesiNuxzQLmTbQOUU8DNxWckzh4UbnADuLr0oTlw2DMgkkPQwFDLruSf7Qeui9Ub3yaHj
 bM/ICamD1p7VNIhtHSvjFkvP0l1/hk1QM0RFx/RV+Ui7K0NulbpOjVSqSaWeSP82MMCLnl7Upbq
 1j/VICKR07TTdeBUV/jwB4l8nrA0kgAm0z3AH+bD+FnpyzXR1bX4C9z/wkwopujchztJI1zEH4I
 e1bUq3nGzr49PYgzl/zLSVntFxXWVNLAmlD00vjjmYMId0JDGBbQPz
X-Received: by 2002:a05:6000:22c1:b0:435:960c:5286 with SMTP id
 ffacd0b85a97d-435ca1ae448mr9041940f8f.58.1769461726171; 
 Mon, 26 Jan 2026 13:08:46 -0800 (PST)
Received: from Timur-Hyperion.home (54001FF2.dsl.pool.telekom.hu.
 [84.0.31.242]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24acdsm33940275f8f.13.2026.01.26.13.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:08:45 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 07/14] drm/amd/display: Implement DDC probe over AUX channel
Date: Mon, 26 Jan 2026 22:08:30 +0100
Message-ID: <20260126210837.21885-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126210837.21885-1-timur.kristof@gmail.com>
References: <20260126210837.21885-1-timur.kristof@gmail.com>
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

DDC probe means that we use the DDC (Display Data Channel) to
verify whether a display is connected or not.

This was written with mainly analog connectors in mind, so it
didn't work over the AUX channel. However, in order to support
external DP bridge encoders found in CIK APUs, it needs to work
over the AUX channel too.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 1585cce65b0e..e1d568905581 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -903,11 +903,18 @@ static bool link_detect_evaluate_edid_header(uint8_t edid_header[8])
  */
 static bool link_detect_ddc_probe(struct dc_link *link)
 {
+	enum signal_type signal = link_detect_sink_signal_type(link, DETECT_REASON_HPD);
+	enum ddc_transaction_type transaction_type = get_ddc_transaction_type(signal);
+
 	if (!link->ddc)
 		return false;
 
+	set_ddc_transaction_type(link->ddc, transaction_type);
+
 	uint8_t edid_header[8] = {0};
-	bool ddc_probed = i2c_read(link->ddc, 0x50, edid_header, sizeof(edid_header));
+	uint8_t zero = 0;
+	bool ddc_probed =
+		link_query_ddc_data(link->ddc, 0x50, &zero, 1, edid_header, sizeof(edid_header));
 
 	if (!ddc_probed)
 		return false;
-- 
2.52.0

