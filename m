Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AE8CD4F3D
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDCE010EEE8;
	Wed, 13 May 2026 14:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g5hoDLRd";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012063.outbound.protection.outlook.com
 [40.107.200.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A0B10EEE1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHNsDCcUwjkp6TZHywA08o+gocRxdz6/J6+iyAG01Lb4Ix3VN9f/Bj/GALpUqTIbxxBtk/olg2SYvqCkmKTlSUFQkMprSkpnP95zPCCtQJ6VYjovFGJEVBH8ec4v4eY23NGrQo8wo0B4qnfRC9qktxBLg3dwqIzgOjIk99g8ZsGfLMVyKkux8vBYILqnVPqgMGXmhGmtEHeof4BrJMxSDKUdM7RWzuMOzu77YZ3bEVuV3092FkkSPMpldXaYke13kTnDRmhXvV5oKoiDq4Azu98y+b808vNOfD6PrcBvbihgJ7cWHQKth9wGvrLqGO0zji8V82vDmGos+25tMaeh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bC7pUqZ/I3IEtdJR3nbOXf3Ihtb+bvgvfCTXvYb41xg=;
 b=rB7/LjWrSWAaZEZGBAIuRJrvZvmfjhGrVEEDOpI+FxJTY9JZUgS85PsHReccts0iM8wB05e2sl4/qv2B0vXxqI001ce2MILN5alSy0EPEdjehclnUT9i4zTqRaQvSAtdk8/LDZSMzDgxCZvL6PCAz6egEaNQqsoNpjwdk6nW02+LFShZJ6Ndl1M96ZWf4HjoabJOvZe/2R2DpW+fJag643l8kXebsl3m7rw+cL2IDmQID1A5h7y8Z4h+dF9+60OyDQuIiO3Pcy+34IqDqiaw0FBrnKUGJpYZdaCEifvZO3SlqcIrhGshiQrVY2Vsm/DFXXQaF88OClAOnLGkuAHm7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC7pUqZ/I3IEtdJR3nbOXf3Ihtb+bvgvfCTXvYb41xg=;
 b=g5hoDLRdyS7HSXuVphCiB1djCyTg2Hipw9MV118XxIYCijPwJagxKbjgrLIXIM2AJdv5QgFwcRa9TsTA4hcbNhHdisg7bGEdsrvAOjqyvtpKTl579pqvj6e4gNmqvXDFmrWqxWM1+h8G1SWnwltaoOGTd/Mne0aI8BtBF1xi2wc=
Received: from CH0PR13CA0056.namprd13.prod.outlook.com (2603:10b6:610:b2::31)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:33:48 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::74) by CH0PR13CA0056.outlook.office365.com
 (2603:10b6:610:b2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 14:33:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 13 May
 2026 09:33:42 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 May
 2026 09:33:41 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:41 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 26/28] drm/amd/display: Validate payload length and link_index
 in dc_process_dmub_aux_transfer_async
Date: Wed, 13 May 2026 10:29:48 -0400
Message-ID: <20260513143213.1852892-28-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf46241-0eb2-45d0-5fb7-08deb0fca554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|56012099003|11063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: x0GhStvRmsODOlsiZh+DklpMA2IS1J3ArZRKX9DN+1pcRzfRbCz+yeTaqA2Ql5TvswQZLLe/H2Z7VN6a9KfEdPX7VQJImeRtGeZp657ZtFjw/FitSFXNWlTszSWJzVQu7isZzsvvpZgH9IJ8FMRlxBVeH5kinXe47VABuD/LQTcbFFKp+S8AYWiuGRcHK2+9hXxfSlCMOO+Ci1EYmC1RmnGrly4MgBzKyLlAOYtFewgxh2zX2R6j6GNXbf03EhNelG9obqbBlG3+V1bfk7eytoY5FMsAE0+lMrTdKtXQCL+56zNSE0ZqpUvcii/heH9ObMv8ds3UBYEB9JOzAgFjQnZNooe8KhPOUbNyjdFKKf9PCko0gjP3iB7SRZh+aZcWMj2gIA9QKDegUsSNWsxn1SHp3uCbgpQS7hgAZR2yRTwWk7oo9RKixQzbsPlxRAzC0IwKtuPq4lpED1Up5Zp5Rx9yxsXXpHAFDt3KU7vbVdQlDbZNIuUnnjL6YsY9q4Bn6zGw3mvTDtILli9hnqdQUDFr4X1t9nJy0E9C3sBrLjPheP8W4CPMmLu6AjSn3a4X5yuovvEP1o+xNdGkyMSj5PjDOYMMDkSVp4G0bBRfNQ5/YNtXsGnso73q4w8An/fYO/0gjhyT7+OBGwjh/IeRBH4GGm+/BL0yIWtPjdO+U/orSKdamKxckiEB5FAwegrZElP5HbozrlRkNhXVc8Weq/HSNSgUlXIYaEm1g1/W5Ik=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(56012099003)(11063799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aPEUihs4jL2iqex2B17tj+du/kxINFeaox593mbw6lvGqs9wOnife9vAC668Z9Zo1FwAy5wCB4AJHBJ9os8a14xXRNcJ9mA7DM2Lery/3HtIiS9fUQdQteTlpwZVa9fqUrHQGYSTN+MFkQcIc1nbiniG4/VBGsShTKuxQH8+VL5FXG/lRShqNpV5tAciYj+GndYOKgC6Hp6XCWePWoLWED6a7d27K/W3RZXx6GVTMsOR4rwmyvaw4LP5gnM0t5VTlnoQsCK5sNNHd2YH8+5GZ4dQM3PlDyBAGH8kwZzbdIfqChv9mvXc6z9y+HyPMa3DJTubN7dOL5srHttbg9YCkfBe3Fhld57/1VaJzWJNTj8wXUHbMUKscApybqzFm2FOG6C855MBHIdCHDFizACE4U57YzOyDY8lHB7Rvmw7STHYYuiudly9/RDX/gXRPZaf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:48.4662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf46241-0eb2-45d0-5fb7-08deb0fca554
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
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

[Why&How]
dc_process_dmub_aux_transfer_async() copies payload->length bytes into a
16-byte stack buffer (dpaux.data[16]) guarded only by an ASSERT(), which
is a no-op in release builds. If a caller ever passes length > 16 this
results in a stack buffer overflow via memcpy.

Additionally, link_index is used to dereference dc->links[] without
bounds checking against dc->link_count, risking an out-of-bounds access.

Replace the ASSERT with a hard runtime check that returns false when
payload->length exceeds the destination buffer size, and add a bounds
check for link_index before it is used.

Cc: stable@vger.kernel.org

Assisted-by: GitHub Copilot:Claude claude-4-opus

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 48d32adb9eb3..0f37209c8330 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6615,7 +6615,11 @@ bool dc_process_dmub_aux_transfer_async(struct dc *dc,
 	uint8_t action;
 	union dmub_rb_cmd cmd = {0};
 
-	ASSERT(payload->length <= 16);
+	if (link_index >= dc->link_count || !dc->links[link_index])
+		return false;
+
+	if (payload->length > sizeof(cmd.dp_aux_access.aux_control.dpaux.data))
+		return false;
 
 	cmd.dp_aux_access.header.type = DMUB_CMD__DP_AUX_ACCESS;
 	cmd.dp_aux_access.header.payload_bytes = 0;
-- 
2.43.0

