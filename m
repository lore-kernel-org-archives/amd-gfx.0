Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14F0D7308A
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 04:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3954F10E028;
	Fri,  3 Apr 2026 04:52:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YZjTUFXv";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88A1710E028
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 04:51:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cxqxtc7VILWf0xX5yv29CzCFK4edOwV3htrZfizFb4w63ATrTQ3jfeKpXWTdY6HsSS5ZLomALrxvqOT/mvw9MqVCAVe4C6Pj4kxMtwPmc12xc3P49h0SfP9nZx/rDw5hemfaiYHZ80p9AoscUL3Z+E4ZQTxhkaeZ7dpvXVxg+U78eVWvSkrlykhEHDDg91kAKhpWUnfC7hSn+zv4RG0Lb3bK8ABXQskRHb2ZmOoQlhXSPVCetKlgmCgHOz2wpoJH74w2zSxvdtzu551PnLbti+Q2yNmQtzVAylJ/mGcB4Vg8Ew3TKToJ1ApIokGIRAXojVL6aQ5JIIsX3pTi4sdcrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hbn4aitEe+f7T9V0ixqRq7UTGzWJvue0szHLw9Vnow=;
 b=AURlZ9vpeoU6iXMg5onv25krM8551LGNhFc13t6nlHNHNNfQH1KQYT40E/h//PBco0dDH+giEUknOpYfMgu8K4Qv4+CMndzGDRXfXOLC90maKh4TzyoO0fuxN4ir2ot1ARI2Xk6EtrZu2A6qVASckKEPNLPJ1L2+Y6frS/qw3H5GryxbnJU2byRnmCDztfo5RxKT/3ZlbWKl7p8FLtECDmrhtQSiFwCiOqaZ/dKdEwp50D/WGlvcNvQn+Iq893cdJZZRuO06RI3LGWlU4Q0Q2PWhFBvQxcqMhDLGeIYgo8ue9NmaanxJeH7p6xvnuwsao1zQmvzRg6tBdx36IqFi6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hbn4aitEe+f7T9V0ixqRq7UTGzWJvue0szHLw9Vnow=;
 b=YZjTUFXv0UJPxlNVYZYBji8d39ZUz71d0J6VsLQ1xoiPmxtFi5aXoytq091E1M20elYj6mRdEGFysPRzU25h0QUv9TDhd9j1AzZQkvxFN0KSwRGL4E2mtAR5JYEpPVqisP1+uzEEl+LjYhTj0IhPZs8i/KLD3NbJJ33LKlIBVng=
Received: from SJ0PR03CA0115.namprd03.prod.outlook.com (2603:10b6:a03:333::30)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 04:51:56 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::64) by SJ0PR03CA0115.outlook.office365.com
 (2603:10b6:a03:333::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Fri,
 3 Apr 2026 04:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 04:51:56 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 23:51:40 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: add od table upload failure message parsing
 for smu v14.0.x
Date: Fri, 3 Apr 2026 00:51:28 -0400
Message-ID: <20260403045128.1977879-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403045128.1977879-1-kevinyang.wang@amd.com>
References: <20260403045128.1977879-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: e16ed3bb-2544-4059-a244-08de913cbb8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: kfaYiaAQqCKBUm8BkBzR+CAjVZAlx/7cW0BBkCalsRE+vYmU5/YEgxl2gGTqWs9D/8KZDImilN1QUMdLxdAOgNt5RtStPHW0/GFpaCXqP3ndSLQAHe7hE+fQf0AuHLo6rK8j8giu7GhkZYXgmoj+lNpItcr+kB7m7BclgTvUY1HA68gsU2q42ELgkx4cUn42Gie0ZrYPBYZQMp8xxzAyBYrk0OiKEofWYrp0YTGh6/G5sPmq+HBR2YcKeNUm1YRTUYtiT2YJq6G0KcA6iiN7D51LFfxVZ+8zvGq4kOQbp5+eoIt429y/wokKFU8RLrD6QzxVnmkeSAkrwyuAlGjVcG/N1ZtC396+HdnmfbWZFAvrqw0TeqTMkpIPHCyencv1wHQWbxjvsgG5EuXpQjO8ZnbLl+B5NIfF9Fv4rGG1i01owrGt0ZzBiUSmHtQq+RYLn00TCj9Wu1K6AXyKMm0fXQmhp0Wy8r/SKHMrjW8ZuuxEBgoG8QvuX6i+A1NPfL+xMvThtXVCdt08nhdmPPuMZFDT1EtZK558IYKVqe4U+rLo+C01EcVr59VUcD9ofjOU/vOkVV3rKE+V+izyrDuizc/zi3oSt6iJ0lAX7NLuYm5upJy81fLVpE+4kKhWeNCckNp9TviCAf5dLmU4TxZ9TXBzb+5FfaNUdZsVfqJ1kGXJeuxxkSyF0WyekWBPV+HKUEOH9IyRCpsHIT5PD8Ja3UgC4XenLgLsrWgy2g/LW1pVSACX6Ad8eReTNRRNLOd18727XK38pX9FmUwJZCf20g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YKQPtjb3OXNGYdXzQsdTnAKmLQjN//BSZy4x4MhUJCs0zxcIrH8ljTBIOsJeiavqwsogXbkQxMPIeKMQYTIB5w5H05uoOO58IwULAxTr/uo+79rXNIFiySpWw5qD+JbtOrL+34A3VxgHNqFdHE9O78GmKoTWWCRjrZkEzt5IWqWmYxFm5Ou6x/acXs3zuXnSYwt0xjnP/GYedNsNdOQjsz9Ru+YT+Md/uCSo5BI8581qpjQH1GZmvo045rhMxkkuRMpbwckK1o4cvoEWy4ZN2zI+fT+N2+D8GWubEch0L12Yx/jDXrK7PGOUnHK8AWGysaPW5wTzgvR0NgOxrkW057tYpP60TJAClsXHJK4RV9Uyuf0OBpdDIJSr9lX0YvL2sZLWx26UTLqeVtQ7ORQdYdliH5SvQkupLAgcnNQXxkMjYhcgma3FXifeXzf7Omrv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 04:51:56.2823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e16ed3bb-2544-4059-a244-08de913cbb8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199
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

parse and print detailed reasons for od table upload failures to
help users understand error causes.

example:
$ echo "0 30 40" | sudo tee fan_curve
$ echo "1 40 30" | sudo tee fan_curve
$ echo "c" | sudo tee fan_curve

kernel log:
[   75.040174] amdgpu 0000:0a:00.0: Failed to upload overdrive table, ret:-5
[   75.040178] amdgpu 0000:0a:00.0: Invalid overdrive table content: OD_FAN_CURVE_PWM_ERROR (13)
[   75.040181] amdgpu 0000:0a:00.0: Failed to upload overdrive table!

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 60 ++++++++++++++++---
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 0bad56a44f5c..4fbcb9de7117 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2230,17 +2230,61 @@ static void smu_v14_0_2_dump_od_table(struct smu_context *smu,
 		 od_table->OverDriveTable.FanMode);
 }
 
+#define OD_FAIL_MSG_MAP(msg) \
+	[msg] = #msg
+
+static const char *od_failed_message[] = {
+	OD_FAIL_MSG_MAP(OD_REQUEST_ADVANCED_NOT_SUPPORTED),
+	OD_FAIL_MSG_MAP(OD_UNSUPPORTED_FEATURE),
+	OD_FAIL_MSG_MAP(OD_INVALID_FEATURE_COMBO_ERROR),
+	OD_FAIL_MSG_MAP(OD_GFXCLK_VF_CURVE_OFFSET_ERROR),
+	OD_FAIL_MSG_MAP(OD_VDD_GFX_VMAX_ERROR),
+	OD_FAIL_MSG_MAP(OD_VDD_SOC_VMAX_ERROR),
+	OD_FAIL_MSG_MAP(OD_PPT_ERROR),
+	OD_FAIL_MSG_MAP(OD_FAN_MIN_PWM_ERROR),
+	OD_FAIL_MSG_MAP(OD_FAN_ACOUSTIC_TARGET_ERROR),
+	OD_FAIL_MSG_MAP(OD_FAN_ACOUSTIC_LIMIT_ERROR),
+	OD_FAIL_MSG_MAP(OD_FAN_TARGET_TEMP_ERROR),
+	OD_FAIL_MSG_MAP(OD_FAN_ZERO_RPM_STOP_TEMP_ERROR),
+	OD_FAIL_MSG_MAP(OD_FAN_CURVE_PWM_ERROR),
+	OD_FAIL_MSG_MAP(OD_FAN_CURVE_TEMP_ERROR),
+	OD_FAIL_MSG_MAP(OD_FULL_CTRL_GFXCLK_ERROR),
+	OD_FAIL_MSG_MAP(OD_FULL_CTRL_UCLK_ERROR),
+	OD_FAIL_MSG_MAP(OD_FULL_CTRL_FCLK_ERROR),
+	OD_FAIL_MSG_MAP(OD_FULL_CTRL_VDD_GFX_ERROR),
+	OD_FAIL_MSG_MAP(OD_FULL_CTRL_VDD_SOC_ERROR),
+	OD_FAIL_MSG_MAP(OD_TDC_ERROR),
+	OD_FAIL_MSG_MAP(OD_GFXCLK_ERROR),
+	OD_FAIL_MSG_MAP(OD_UCLK_ERROR),
+	OD_FAIL_MSG_MAP(OD_FCLK_ERROR),
+	OD_FAIL_MSG_MAP(OD_OP_TEMP_ERROR),
+	OD_FAIL_MSG_MAP(OD_OP_GFX_EDC_ERROR),
+	OD_FAIL_MSG_MAP(OD_OP_GFX_PCC_ERROR),
+	OD_FAIL_MSG_MAP(OD_POWER_FEATURE_CTRL_ERROR),
+};
+
 static int smu_v14_0_2_upload_overdrive_table(struct smu_context *smu,
 					      OverDriveTableExternal_t *od_table)
 {
-	int ret;
-	ret = smu_cmn_update_table(smu,
-				   SMU_TABLE_OVERDRIVE,
-				   0,
-				   (void *)od_table,
-				   true);
-	if (ret)
-		dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
+	uint32_t read_arg = 0;
+	int ret, od_faile_type;
+
+	ret = smu_cmn_update_table_read_arg(smu,
+					    SMU_TABLE_OVERDRIVE,
+					    0,
+					    (void *)od_table,
+					    &read_arg,
+					    true);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to upload overdrive table, ret:%d\n", ret);
+		if ((read_arg & 0xff) == TABLE_TRANSFER_FAILED) {
+			od_faile_type = read_arg >> 16;
+			dev_err(smu->adev->dev, "Invalid overdrive table content: %s (%d)\n",
+				od_faile_type < ARRAY_SIZE(od_failed_message) ?
+				od_failed_message[od_faile_type] : "unknown",
+				od_faile_type);
+		}
+	}
 
 	return ret;
 }
-- 
2.47.3

