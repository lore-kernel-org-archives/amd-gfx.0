Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE698D6AAF7
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 18:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6255910F2E1;
	Thu,  2 Apr 2026 18:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UiszR0hh";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2ABB10F1BD
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 18:34:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BteNiiAr+C5YuxluSZUM3+03rQnun4Iv19NvwqVhH/TZ9I5TIxcgVw6n9PFjaSXPrDxrCyqnEE6ozMnKjq2Lji2I8BJUKf3dwn0TrmqscyK9C+VNmSqo96A9Hkjnb93qZwRyh9k5pCkl4O+foNNXrr2EtmrouwNDxInYOQfEpptydS5xfTsikunj/Plp4J/iypOgpHBsn1OzCeox/LwJkxiGfoFy3YkaBnm6FO3XeKt1a9ECdYAYgnnizrolik0QTeFv0Ck9SOE+B1P3f78OVnp0iiAL+RNKr44A79Pd56G9LrN9rkpXBvFT2ApYKoGq+8Md5wNlqcEkRBmSgYgs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErmKh5E00Z1uMuO7g42HoBnPE6wZLtaKldmhOWtsmKU=;
 b=uUAKh7Qt0wTwqMaGS+An99w1X5W0IPg6LB/ajGED78Ko6clAe/Qxa/Q8a+WTs4wUDBDd431B9oOluphfg6aGGHqkXiB2ZgNreSFX5/tC9L3lJBR825Wm7eDucFSeWsQWUQVFj9+6GKCVaoVX9ddg9uxlWbfsfbqFMc1aheywvXTPb7I0kRs2en5dpJmmFzFZKFYxU8ErEYx5t3Zs7DtfWc8Bhxb3ZpSy+ydtu6AjuTpWsSO2z3jzS5kIldH0EqkRXDqGpXXTyF3VAfFQu8Vppg82Qkdugf7kgdugJrRpwicc8raH2SzuiAQRezv8NOAd+R3IunEDZtIHheiGr3aIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErmKh5E00Z1uMuO7g42HoBnPE6wZLtaKldmhOWtsmKU=;
 b=UiszR0hhQh1Xa3xkC5kZQBizXBZwRQpn/x0LAeW1li2WJxYmaPE4I9m9L3p1zac91IaK8QxjEUo/k6lSNqrCX7Or1SNvO59yGCZGrbrYEL5s+iWmPTVMeKgu42mNU9J/WXMBrzTgA6JgM0+BuOa/fOk/JH2Y8RbqarDctH4IlYI=
Received: from DM6PR02CA0136.namprd02.prod.outlook.com (2603:10b6:5:1b4::38)
 by IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 2 Apr
 2026 18:34:05 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::c2) by DM6PR02CA0136.outlook.office365.com
 (2603:10b6:5:1b4::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 18:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:34:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:34:00 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:33:54 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 09/22] drm/amd/display: Enable sink freesync via MCCS
Date: Thu, 2 Apr 2026 14:33:01 -0400
Message-ID: <20260402183314.1388755-10-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402183314.1388755-1-Roman.Li@amd.com>
References: <20260402183314.1388755-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|IA1PR12MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 976dcacd-544f-4a1b-1a68-08de90e66af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KeM7EmLwmwSrlNYGCwXAaLLYFTI5ZTKGaZIS9IG9gnk8YH6fA1h7Vyj4P+EJmDtYxmdYjmZhx707cTcaC8LLaN6KGwxQhzyz9IkdbNIEk2fH0GgSu0HWCkyEuW9kuHZY8iNBVq7JQsghZUS/q3aLQAYFcvlu1n5SY3zErC+MIYuZIlzaHQyvR+Gwdl3g9WvFbgCkIMlmeYSqyCFyy+ieTfrwgbDo/GoDFlIn+MAZ1aCyOn8x/BJzJXfcOZX0L1W6JewxTIzSxK+zikc9eYdSTDZMdVjnbyIm7z6lBdMAPC2ZC5Q7aV4xPH9qcuYYtkwPOv4J4N4++HoDgIvAVjHqVdEu1E7pkPrpruCuTZVwgjuMxRs+tpWTAh5J1IdX3JioDpjPd1oQWYGM51ouO8SCwM1TYGOcWBLZp83u1yaf0Q8+XAnz1sGHqaQWPLiG5tFEp8kgUOCCxuzxc7zg1htLgcr7mQtyvkd2TfbjqCIRIS8I3jUpUzE85WeSocNd3hZffl51cgnElXbe7nWGlOQlUyWMf6d6rYFlJYYA1qtv2Zv2X5fCYTjZm5hVf27CazqijVn5netYuo4z4d4JYM0tQlOfNiW2iih2tI8y5l1eX9JOJxxWjjeEdHOaK5Cr0LFfYl6O3jJDHqgDYu0dyk8n6o1trfQEC0rav3NDe1Rm3L7R2gAD6u/B3H5OJ9AMfKs97aDdUew/XiblBiNlVDNAX+B4XTyuz0gmWWBxYVBakeWSgj+i5kRgAy0znIGbNnJcOkSJi2hOt2cxq+2Q/DTblA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /7gANr7peMNH0GQ8GkhJCh+0559p8gY5he37xmPPPT1TMrIh9TSM/8XjqRnIFrBAYOCxIgLJC9ec9PMiHCv6AiOLPb7hhOjQPZGnQ8ufd5ZrGQzRZuk0muNQgRNhojx9hG5uqrqNFxgn0F2DhH3nGy8C214jZS1eMdM7A2WCcTpMtME7VnT9VQfSX0jRkr8qa+k10h1jp8E/52egqSqVQZUly6ow3nqXrBJZXrR8txNhQhM7Hepdwv5Xqm+r2LftYoQ4eVeBRyUIchwVh8nB3iFOAIDguE/DIUJRfT9ZRuTDIXP3rq07259N5lLwQ/hfHnAVBQ+4AvThGFKCGXNlpCZyL6aZikTXfD/FGOcw0MRd15Wevr0BTNSvGDnSP+tznUloMBftNFpIXV0qmDC4oWRqb3Rv6s87ZsfMZvn53u65wb0yYw/khfTvq5G1vmoI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:34:04.4448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 976dcacd-544f-4a1b-1a68-08de90e66af9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063
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

From: Wayne Lin <Wayne.Lin@amd.com>

If sink like HDMI indicates supporting freesync via MCCS,
explicitly to send vcp set command on sink to enable freesync.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 74 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  5 ++
 3 files changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ceef9b6e1599..07612463455a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13379,6 +13379,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		(!sink->edid_caps.freesync_vcp_code ||
 		(sink->edid_caps.freesync_vcp_code && !sink->mccs_caps.freesync_supported)))
 		freesync_capable = false;
+	if (sink->mccs_caps.freesync_supported && freesync_capable)
+		dm_helpers_mccs_vcp_set(adev->dm.dc->ctx, amdgpu_dm_connector->dc_link, sink);
 
 update:
 	if (dm_con_state)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 0146e894a15a..c53230cdfdc5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1606,3 +1606,77 @@ void dm_helpers_read_mccs_caps(struct dc_context *ctx, struct dc_link *link,
 	}
 }
 
+static int mccs_operation_vcp_set(unsigned int vcp_code, struct dc_link *link, uint16_t value)
+{
+	const unsigned char retry_interval_ms = 40;
+	unsigned char retry = 5;
+	struct amdgpu_dm_connector *aconnector = link->priv;
+	struct i2c_adapter *ddc;
+	struct i2c_msg msg = {0};
+	int ret = 0;
+	int idx;
+
+	unsigned char wr_data[MCCS_OP_BUFF_SIZE_WR_VCP_SET] = {
+		MCCS_SRC_ADDR,				/* Byte0 - Src Addr */
+		MCCS_LENGTH_OFFSET + 4,		/* Byte1 - Length */
+		MCCS_OP_CODE_VCP_SET,		/* Byte2 - MCCS Command */
+		(unsigned char)vcp_code,	/* Byte3 - VCP Code */
+		(unsigned char)(value >> 8),	/* Byte4 - Value High Byte */
+		(unsigned char)(value & 0xFF),	/* Byte5 - Value Low Byte */
+		MCCS_DEST_ADDR << 1		/* Byte6 - CheckSum */
+	};
+
+	/* calculate checksum */
+	for (idx = 0; idx < (MCCS_OP_BUFF_SIZE_WR_VCP_SET - 1); idx++)
+		wr_data[MCCS_OP_BUFF_SIZE_WR_VCP_SET - 1] ^= wr_data[idx];
+
+	if (link->aux_mode)
+		ddc = &aconnector->dm_dp_aux.aux.ddc;
+	else
+		ddc = &aconnector->i2c->base;
+
+	do {
+		msg.addr = MCCS_DEST_ADDR;
+		msg.flags = 0;
+		msg.len = MCCS_OP_BUFF_SIZE_WR_VCP_SET;
+		msg.buf = wr_data;
+
+		ret = i2c_transfer(ddc, &msg, 1);
+		if (ret == 1)
+			break;
+
+		retry--;
+		msleep(retry_interval_ms);
+	} while (retry);
+
+	if (!retry)
+		return -EIO;
+
+	return 0;
+}
+
+void dm_helpers_mccs_vcp_set(struct dc_context *ctx, struct dc_link *link,
+		struct dc_sink *sink)
+{
+	struct drm_device *dev;
+	const uint16_t enable = 0x0101;
+
+	if (!ctx)
+		return;
+	dev = adev_to_drm(ctx->driver_context);
+
+	if (!link || !sink) {
+		drm_dbg_driver(dev, "%s: link or sink is NULL", __func__);
+		return;
+	}
+
+	if (!sink->mccs_caps.freesync_supported) {
+		drm_dbg_driver(dev, "%s: MCCS freesync not supported on this sink", __func__);
+		return;
+	}
+
+	if (mccs_operation_vcp_set(sink->edid_caps.freesync_vcp_code, link, enable))
+		drm_dbg_driver(dev, "%s: Failed to set VCP code %d", __func__,
+				sink->edid_caps.freesync_vcp_code);
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 3aa2b11f559b..107aec6a1265 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -186,6 +186,11 @@ void dm_helpers_read_mccs_caps(
 		struct dc_link *link,
 		struct dc_sink *sink);
 
+void dm_helpers_mccs_vcp_set(
+		struct dc_context *ctx,
+		struct dc_link *link,
+		struct dc_sink *sink);
+
 bool dm_helpers_dp_handle_test_pattern_request(
 		struct dc_context *ctx,
 		const struct dc_link *link,
-- 
2.34.1

