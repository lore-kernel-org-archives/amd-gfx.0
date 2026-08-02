Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8035EC55177
	for <amd-gfx@archiver.kernel.org>; Sun,  2 Aug 2026 14:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FC6510E427;
	Sun,  2 Aug 2026 14:35:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RK2s/yHK";
	dkim-atps=neutral
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61FFC10E425
 for <amd-gfx@lists.freedesktop.org>; Sun,  2 Aug 2026 14:35:33 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id
 5614622812f47-4a45b3f0becso1473048b6e.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 02 Aug 2026 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785681332; x=1786286132; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R9/ZBBWwxbo/L0scHa1+0PKeDSXAJU8I4FcEXNAE4v4=;
 b=RK2s/yHKmxL6X5usBd9XCco13JM4FzrQxtH0vH+im0nVvGo9EIf0wLYuoNUm+9igrz
 PB0oi4m0gVWCMNR/aNhwDvEyys8AJ5Rh+aBHVkSp36arO+WWgrpdMOO/VsPVLL5hnThU
 gYYy/w6V+K/ya8DYIKIR2LPhq7mkeau7JmCJATAVDtC3+ae01TqbtXowuUTZ4t5zIMZr
 1S/a98c/9V9Xs10DM5fRVqDFv98/BEO8ERDU4Q/NpQhEitL9IwWvi6NKS6DHid38uHOQ
 3ciSb6yG1qx7KWNDf0w/5B+a9193JK6+sVx0wvdxjJrjjHwry23G3UqFI+URVBjtJPG6
 Q6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785681332; x=1786286132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R9/ZBBWwxbo/L0scHa1+0PKeDSXAJU8I4FcEXNAE4v4=;
 b=bLuqoCOLMDheQXhXKe56JZV8uJsFGRn2TPfsfweloMiA1Ejl//UtOKz3/a+Lxj7e5u
 3OFjhbxjpb8Uu1sCIcUq9qVBlOCBF22VcJRQv9tBUcJgcVVe7R+uGq4FA7qVSHA7khKz
 q0eJY6tMoe2/ysU3nefA2NNlhn3iejfeBUgmd4MpLT3n6f0levnFnV7eBnPQckQtsRTY
 jtNiI+rRh5Q8CLantMcIQoqycG0KmyV1gO0K1uN/5qrUfbYu+LULjWNbZryID7xgQTb/
 kGbfMjNyBhHKZvLXU6pwThKVs330t9zToLaXn5D96X7oyPflwqSBcWUKpBBOkhLpGIHj
 YCRQ==
X-Gm-Message-State: AOJu0YyFh9aunFCYsnenzyarcsB1ksYhNFCzGUWeyVY/y0DCy6CHkz6R
 uK4dPpo+888pAYodJt2pozaJB1YOc0CPMxNH/mefvryTqFoBETQRFhlP5GVaTBffsWU=
X-Gm-Gg: AR+sD10OdsH8J10grvj/2o7kXG9g4ChT42Barfqdlq2R/O2z8mBkKAL/msXOm8rqpFk
 Y6Ypsl/Ktybcivd7d8/MStWG5NynSFheJJxUDRAHoRsi973yFqD8dH8DGjkd/SKbTi05XQZiSfW
 WOen8fajOGPL5QmbK3K5Voh/raAX/HNdrJHo7VN/6cmuZMZL2JF9QbRLK482IK6j+t01Q3nnzwh
 J1vEG9AkTjmYy36I14SzZL5ByL1PuZ4Ml4fPHLpAMJf7ygdxnZJGNKP7B+eBFkVUMgqVu3ybSlG
 ToE+kN3CrsvnibGQBcVEjEjvxL6ncwEljoSrHNUxm0htvDuAw1kL6ld6pOAHyhxDTvkVpK8O+H4
 yvI4SkhvmkXsBwylpqYYmB1l5RN8S2h0AeqvXaPa6FoPDG3yuPrDsWIlePcoajjexc2JtlrMfx0
 zdjJs66OxG68KqBExgAMS+dhOIebJrjMXMSLyQi4IYRG0gIJeZtYgkHBsKemLRJdPQXH/Hm8PMS
 LKF5Nh/BDWBdfKDXohfBPzUIlYJoK0L0aYYaa0HwbvI
X-Received: by 2002:a05:6808:bcd:b0:497:8f1:df07 with SMTP id
 5614622812f47-4af5e0583c4mr12361035b6e.7.1785681332450; 
 Sun, 02 Aug 2026 07:35:32 -0700 (PDT)
Received: from natebox2.jabitha.com (46-110-104-162.wmnscoaa.metronetinc.net.
 [46.110.104.162]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4af58e9551dsm4778877b6e.11.2026.08.02.07.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 07:35:32 -0700 (PDT)
From: Nathan Lucas <nlucasgit@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, joshua@froggi.es, mwen@igalia.com,
 leorize+oss@disroot.org, alex.hung@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/amd/display: fix BT.2020 YCbCr output CSC matrices
 for DCE
Date: Sun,  2 Aug 2026 08:35:24 -0600
Message-ID: <15b28cafab1b55f3e4cad9bb542847d22e776bda.1785616749.git.nlucasgit@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785616749.git.nlucasgit@gmail.com>
References: <cover.1785616749.git.nlucasgit@gmail.com>
MIME-Version: 1.0
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

The commit cited by the Fixes tag added separate limited and full-range
BT.2020 YCbCr entries to the DCE output CSC tables, but populated both
entries with the same matrix copied from the common DC table. That
matrix combined full-range scaling with limited-range luma offset and was
incorrect for both limited and full-range output.

Replace the coefficients in both entries in the DCE paths with those from
the new COLOR_SPACE_YCBCR2020_LIMITED_TYPE
and COLOR_SPACE_YCBCR2020_FULL_TYPE entries in the preceding commit
("drm/amd/display: fix BT.2020 YCbCr limited output CSC matrix").

Fixes: 51e6668ab4ba ("drm/amd/display: add missing CSC entries for BT.2020 for DCE IPs")
Assisted-by: OpenAI-Codex:GPT-5.6-Sol
Signed-off-by: Nathan Lucas <nlucasgit@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c       | 7 ++++---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index 864491bfd7f7..83f819890020 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -115,10 +115,11 @@ static const struct out_csc_color_matrix global_color_matrix[] = {
 	{ 0x2000, 0, 0, 0, 0, 0x2000, 0, 0, 0, 0, 0x2000, 0} },
 { COLOR_SPACE_2020_RGB_LIMITEDRANGE,
 	{ 0x1B67, 0, 0, 0x201, 0, 0x1B67, 0, 0x201, 0, 0, 0x1B67, 0x201} },
-{ COLOR_SPACE_2020_YCBCR_LIMITED, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868,
-	0x15B2, 0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} },
+/* COLOR_SPACE_2020_YCBCR_* values corrected. Not included in the TODO above. */
+{ COLOR_SPACE_2020_YCBCR_LIMITED, { 0x0E04, 0xF31D, 0xFEDF, 0x1004, 0x0733,
+	0x1294, 0x01A0, 0x201, 0xFC16, 0xF5E6, 0x0E04, 0x1004} },
 { COLOR_SPACE_2020_YCBCR_FULL, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868, 0x15B2,
-	0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} }
+	0x01E6, 0, 0xFB88, 0xF478, 0x1000, 0x1004} }
 };
 
 static bool setup_scaling_configuration(
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
index 1ed018aaa4bb..f5f8cd2d47a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
@@ -93,10 +93,11 @@ static const struct out_csc_color_matrix global_color_matrix[] = {
 	{ 0x2000, 0, 0, 0, 0, 0x2000, 0, 0, 0, 0, 0x2000, 0} },
 { COLOR_SPACE_2020_RGB_LIMITEDRANGE,
 	{ 0x1B67, 0, 0, 0x201, 0, 0x1B67, 0, 0x201, 0, 0, 0x1B67, 0x201} },
-{ COLOR_SPACE_2020_YCBCR_LIMITED, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868,
-	0x15B2, 0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} },
+/* COLOR_SPACE_2020_YCBCR_* values corrected. Not included in the TODO above. */
+{ COLOR_SPACE_2020_YCBCR_LIMITED, { 0x0E04, 0xF31D, 0xFEDF, 0x1004, 0x0733,
+	0x1294, 0x01A0, 0x201, 0xFC16, 0xF5E6, 0x0E04, 0x1004} },
 { COLOR_SPACE_2020_YCBCR_FULL, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868, 0x15B2,
-	0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} }
+	0x01E6, 0, 0xFB88, 0xF478, 0x1000, 0x1004} }
 };
 
 enum csc_color_mode {
-- 
2.55.0

