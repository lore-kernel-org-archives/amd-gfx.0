Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5315AE77173
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 08:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F403410F018;
	Fri,  6 Dec 2024 08:17:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="aEUH2iQZ";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4F0010E03D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 04:14:18 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-21589aa7913so2764185ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Dec 2024 20:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1733458458; x=1734063258;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0IU9gPKZ0cYpxiTpLI8JVzoAjrjZPxFqYWDg1qG91HQ=;
 b=aEUH2iQZiSmWSzUdjMu3rMkdow9FClLhAFQB4R+qjq5OEnMLFJw+CM8KtQi0gzVu5Q
 3FRMP/uNw8KOtt/qYgT09mBArRtqcshkvyw9W6rUh2fybDP+AK26zLgfLtmyKtRXCNHJ
 FXDbK3L9Pf1xQ1Ap56+K7QLmYKZ49KcRCcOZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733458458; x=1734063258;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0IU9gPKZ0cYpxiTpLI8JVzoAjrjZPxFqYWDg1qG91HQ=;
 b=s3UxPKP7wb9GFoMNe4oOgI/n4u4rp9C+GGqlm4Lpt5tAHJDw/N0Fd8HrMPoJaT0yDP
 4Wi6eEnN98iSSTESFDrOGlvIdOUi38uZM17F0auHRRSj6zQxfRSpopl8XhQq1xPaxe25
 /f2I+WwWqZJ6GIzY6eAehSJacUwzV5FRYzDyVwTJdzmz5ldoZJcHznqnSlQ39/e04xtz
 SMfiJMYqcBl+RuxDASlsJH+JcSXTuMibz1ddo5nlTygxsPkp5HNcPyo/jkTTCHkkTLjv
 z3IniUgBpYDHGdNrlxBFr/KeDhd4CeJURMzMIub/9bZT8Ve0kwA2LNFEl4HJom+0o7SZ
 MsNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8WL6HRZjBQD5izMKIjgLEJolvkNTQqRPdOgqBYymWE3on2+UOPM/PJfyMy1g5x8MY+9euipoh@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/QRtK7UNEw7maMj2SHvV8YM/mK7TZCp1y111nWAcN/3FAEpbm
 ETabVifcLtOlLgwrXaBtPFr38QTTc/Pp1NA/oWlNzePJMUqajVlEX0DwZPxPIg==
X-Gm-Gg: ASbGncud4Q0SEOaJgFW6m357ahvDiSRXPzAdB8qyTd1K0GW9yq1ulG1F2RFODG1gSEu
 FGySsfRzqnf0cjP9QWlJBRMmUN39LY8nwCJc0xaHadxjIEipYBA3tjhMyQtx5iqlumNF+gHaP7t
 1LqGHIOkZcHeEI57z8h3SbfgmjiNvfuVORtL6dqafo1YP86tJDeHzY5VZsL5wJIKe94XKhgZHja
 0HsJ4MpLn/TvY73VBREHoDH+2QPvaWpcFbJK6hxEBxYXNjfT4sDkT9dgenGOF7yJEiRsuPj9nHV
 WZoXOxwZLNmJCFblSqCt+Q==
X-Google-Smtp-Source: AGHT+IGLQ1YPW/GMhrOQCuIQu21lc9n4+a2xgkTaktnhXR5veCtx5oSsXukViRHArRUmvP9dHaYNNg==
X-Received: by 2002:a17:902:e88f:b0:215:9a73:6c4f with SMTP id
 d9443c01a7336-21614d5365fmr7802885ad.6.1733458458137; 
 Thu, 05 Dec 2024 20:14:18 -0800 (PST)
Received: from kk-ph5.. ([192.19.161.250]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8e3e8afsm20079925ad.18.2024.12.05.20.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 20:14:17 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, alex.hung@amd.com,
 hamza.mahfooz@amd.com, dillon.varone@amd.com, hersenxs.wu@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
 Sasha Levin <sashal@kernel.org>,
 Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10-v6.1] drm/amd/display: Check BIOS images before it is
 used
Date: Fri,  6 Dec 2024 04:14:14 +0000
Message-Id: <20241206041414.4013356-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.39.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Dec 2024 08:17:05 +0000
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

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 8b0ddf19cca2a352b2a7e01d99d3ba949a99c84c ]

BIOS images may fail to load and null checks are added before they are
used.

This fixes 6 NULL_RETURNS issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 9b8ea6e9a..0f686e363 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -664,6 +664,9 @@ static enum bp_result get_ss_info_v3_1(
 
 	ss_table_header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V3,
 		DATA_TABLES(ASIC_InternalSS_Info));
+	if (!ss_table_header_include)
+		return BP_RESULT_UNSUPPORTED;
+
 	table_size =
 		(le16_to_cpu(ss_table_header_include->sHeader.usStructureSize)
 				- sizeof(ATOM_COMMON_TABLE_HEADER))
@@ -1031,6 +1034,8 @@ static enum bp_result get_ss_info_from_internal_ss_info_tbl_V2_1(
 
 	header = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V2,
 		DATA_TABLES(ASIC_InternalSS_Info));
+	if (!header)
+		return result;
 
 	memset(info, 0, sizeof(struct spread_spectrum_info));
 
@@ -1104,6 +1109,8 @@ static enum bp_result get_ss_info_from_ss_info_table(
 	get_atom_data_table_revision(header, &revision);
 
 	tbl = GET_IMAGE(ATOM_SPREAD_SPECTRUM_INFO, DATA_TABLES(SS_Info));
+	if (!tbl)
+		return result;
 
 	if (1 != revision.major || 2 > revision.minor)
 		return result;
@@ -1631,6 +1638,8 @@ static uint32_t get_ss_entry_number_from_ss_info_tbl(
 
 	tbl = GET_IMAGE(ATOM_SPREAD_SPECTRUM_INFO,
 			DATA_TABLES(SS_Info));
+	if (!tbl)
+		return number;
 
 	if (1 != revision.major || 2 > revision.minor)
 		return number;
@@ -1711,6 +1720,8 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_v2_1(
 
 	header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V2,
 			DATA_TABLES(ASIC_InternalSS_Info));
+	if (!header_include)
+		return 0;
 
 	size = (le16_to_cpu(header_include->sHeader.usStructureSize)
 			- sizeof(ATOM_COMMON_TABLE_HEADER))
@@ -1748,6 +1759,9 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_V3_1(
 
 	header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V3,
 			DATA_TABLES(ASIC_InternalSS_Info));
+	if (!header_include)
+		return number;
+
 	size = (le16_to_cpu(header_include->sHeader.usStructureSize) -
 			sizeof(ATOM_COMMON_TABLE_HEADER)) /
 					sizeof(ATOM_ASIC_SS_ASSIGNMENT_V3);
-- 
2.39.4

