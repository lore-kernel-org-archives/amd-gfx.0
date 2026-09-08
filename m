Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B06C79FAE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F8CA10EB7F;
	Tue,  8 Sep 2026 11:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="msR4ojWa";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011047.outbound.protection.outlook.com
 [40.93.194.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DD0C10EB7D
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zev9NZDBgpaIqb3BGfPMuAkmlr0NpfHd8uNID2FlPzLT984s1PAxM3W+7kiqD82k+SlfKN2OAq2+4BvsedbUfwpjXq9Fh055DwFChxBfMlbYnBNdajFS6Yd9s/8bb7m8M5kJxjg7b9M2zntGiGtMVctxBIJPWj4r6Q6woCXVWjuCSRbrYsAjihGJqyABYWATJvN4ypEcbCLi4wrIbi92t2VdqhtHm4JDcbVk8rm1EnSPirV9OzzyYbI0hhCVn/X17w4WD9iCCm8HwfeblDDEfaLf8YMlQ4xCbbN4W7ludGJtIAr6t1uCbdkO5tZ7nc4ojI8VSPUp4Kz+uR6foA2JmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaHRkkyMq4jG3g1IKLpBW9Rea+173YC7+lZR8IhN+o0=;
 b=N5OKJzcJrR++JXOZZ6xmcldpeKcAbjJrNkqjveWg5jmG2mzgOcjk5g/idSgPulCQ0r5kY1VTeJ1B0uauFKog+AEq5wycziI8Tb7jOQc+EmL19zCBExkAwkobN31v96d36fXe/cjNlG0fgua0K+/zGzzNbRNRZB+O3CNE9W0eJm2kman4TzvhoQhE+NpQfVZ9CJ/bVQkY9sw3+hjO8msso+cMU+yNaR3iBg5YawfVLjZpNpx3S/GYUtSUeS8kAAupHUDr3/jjCkswlqS975cfKjteVl3GgzdHifuhl9Y/geWxc0vL1Ygdf2js+FlNcYD2VkDZDv3QkGF9971qNKqpbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaHRkkyMq4jG3g1IKLpBW9Rea+173YC7+lZR8IhN+o0=;
 b=msR4ojWaHD9XDkCoXBVJ4TxyIi+pTYrbpLuSi6z07eX2tDFkKQt/MCYxRyjN7TV4HjLNiQsS8BvqoPIFQp5vuKvXjOeNFeKkfHONP83GfCLwVsTFaXeqAElInh641YB0gtyZkCMou/QO66Je2fy4LWuJHFCfeWY4154g/K1t3rw=
Received: from BN0PR04CA0145.namprd04.prod.outlook.com (2603:10b6:408:ed::30)
 by CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Tue, 8 Sep
 2026 11:44:20 +0000
Received: from BN7PEPF0000009E.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::57) by BN0PR04CA0145.outlook.office365.com
 (2603:10b6:408:ed::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009E.mail.protection.outlook.com (10.167.248.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:44:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:44:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:44:09 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:44:00 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 65/66] drm/amd/display: Use unsigned types for FRL cap check
 params and HPO read_state
Date: Tue, 8 Sep 2026 19:31:58 +0800
Message-ID: <20260908113338.2433445-66-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009E:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: 47399bed-9f34-4f0a-c6a0-08df0d9e8514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1GGXSyoePOz9JY5/k/3BNvUYwPZF2JnsSLpZlidKJCMKxlnndAzRjV2woX8CN/6v/rKaFWRGi7jFXLyEqUNB/1NbvPUhCq55Q+NYC+0MPBvnFfO1XTjWwvbQd/Z48nnjEF2tiFtbJNDgbYEGLFk0aNhCWgXi6oIHe5p3GEO9bJeVV6+BLtaXnfJGJa9m0K0Qqu3FXs1QEGRSrMQz8HpSpl8RKxfgJVjN7AeWZtVJ9UkhK8JAdB8L799rt2bMPBYoiEwix44sPxEoaul1ElIUUupnZ1nSwsjt37bqRrHbrGODy/E+lBh8LaI4g9SwGDNRf0EaMF5qcxjq7FZT7f+ST4T0vGgc9DPf3dTeAZm3+zBBvLEKVDOKi7Xjpc8I7cNxgtKCaY623lf/yXl5G2bMhTw0Afzn5fQzaQMMCrXEBHN3KH/H+kpc7UmBn76qToUaM58mKIGGYP1T661iCsBXlLJcTfKAJRV3vXaInsb4siUqzlu2bW383V8J3uWryWSTOnipvVult53S8Zi+vmwFBzKL/9BxWU8nAgD+B75Cu5ZCD9mNCCCOiPILOb+2uj/W1i5wnlO5Og3LvLNuh/TdqmXlEqCcniszitpGzHY+tMv+LHgwOZlTSFQ6Us419E/fZ0L9PQe+WGFoSRfAPyWWoqo0jWCdIXG6dK6JvyczCR7aW/21mh+wz0vIfUzj2s6C4nF7zY+IaXRXu37G2xJuEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ruzh9Af7a5RFhyua9z3bWUu554Cx//NwMFSE2RZIqtRryXAEvmJKDiuWdbrI4GeFJLbkPiBP7LrmT+1UP1BzSDyScUrgDw33wdg6XmFrp0kQjJibbsIIXMtwu9JoDqYdwgeQ9956m+KgI4l+DIR8lAdw2iIcsYpgnvH5uOw7tsKpnKZwBa4xsCpfMdjtu4HgFNZPSTrru59qKGCVT/i20ZTeRUQHpyi6FcOW9MaPWX/rIk9XZ3wCZukGWMJCgIVsM1OIZPiwKUpF7RGpAdA/quH1/AvaxDMXPjqP2buMdNtN5XL1F5jW5jWg8jAGOAXkjumUjcAQw/pcJlPlIq7nMACn2silQpvuZA+pywz9yX1gnCbX870BFF4d6d73XvbPhzFBPfvRE7ztK6XrseyWyTp/NvnxNvBum5l2pDFZFb64hbfNaI8dwFp68W7Jfit6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:44:19.8230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47399bed-9f34-4f0a-c6a0-08df0d9e8514
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297
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

[Why]
Commit c3fb1fb9e65f ("drm/amd/display: Fix warnings") aligned the
signedness of a large number of DC values, but two hunks of the original
change were not carried over:

- struct frl_cap_chk_params_fixed31_32 still declares audio_packet_type,
  h_active and h_blank as int. All three only ever hold non-negative
  values: h_active and h_blank are HDMI timing quantities counted in
  pixels, and audio_packet_type is only compared against the positive
  HDMI audio packet type constants 0x02, 0x07, 0x08, 0x09 and 0x0e in
  frl_capacity_computations_common().

- hpo_enc3_read_state() still declares pixel_encoding, color_depth and
  odm_combine as int and passes their addresses to REG_GET_2()/REG_GET(),
  whose generic_reg_get*() backends take uint32_t *. The mismatch is only
  hidden by the explicit (uint32_t *) cast inside the REG_GET macros. The
  DCN401 equivalent, hpo_enc401_read_state(), already uses uint32_t.

[How]
Widen the three struct fields to unsigned int/uint32_t and the three
locals to uint32_t so the types match how the values are produced and
consumed. No computed value changes.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                         | 6 +++---
 .../amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 634c0b7686bb..b6c71ebb7ea7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -112,10 +112,10 @@ struct frl_cap_chk_params_fixed31_32 {
 	int      lanes;
 	struct fixed31_32   f_pixel_clock_nominal;   /* Pixel Clock rate (Hz)  */
 	struct fixed31_32   r_bit_nominal;           /* FRL bitrate (bps) */
-	int      audio_packet_type;
+	unsigned int audio_packet_type;
 	struct fixed31_32   f_audio;                 /* Audio rate (Hz) */
-	int      h_active;                /* Active pixels per line */
-	int      h_blank;                 /* Blanking pixels per line */
+	uint32_t h_active;                /* Active pixels per line */
+	uint32_t h_blank;                 /* Blanking pixels per line */
 	int      bpc;                     /* Bits per component */
 	int      vic;                     /* Video Identification Code */
 
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
index cff5c95a771c..f4c21998d845 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
@@ -921,9 +921,9 @@ void hpo_enc3_read_state(
 	struct hpo_frl_stream_encoder *enc,
 	struct hpo_frl_stream_encoder_state *state)
 {
-	int pixel_encoding;
-	int color_depth;
-	int odm_combine;
+	uint32_t pixel_encoding;
+	uint32_t color_depth;
+	uint32_t odm_combine;
 	struct dcn30_hpo_frl_stream_encoder *enc3 = DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
 
 	ASSERT(state);
-- 
2.43.0

