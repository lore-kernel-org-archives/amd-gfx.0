Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C0BCFC274
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 08:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9CF810E53D;
	Tue, 15 Oct 2024 08:17:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mNr5A8f0";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B7A10E53D
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 08:17:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXedy2CkkxHgk10Tf6X57zbXxlwoE9FDUBjKANl9LgWKfPi5sYmRHiX29EI3jqWmYfVZTidDpCqCTqNFa6xap1JbXDeXFu8V76Ba35PL5w97Mtowzc+BxEZwjNYWIA6bXKPEO+hDov7uXjgN/8XjlaANukoxsgKB9r8GOq+yzwQA0iZx8lYlhuV1/4jKeTUwb9mYaiL/ejFn9VbU3tK/Z/DLhdsnE5gNQ7ZnO3zb4fu6EzcbcS06FXHvH2ekZT5EhWP3s1uGpamfP0Bvm2er1uSR3+NpDVCEGrlUGTJhTHxLFqAAIwZUbZCbJFxWcxHMjigF23Unj9lVlO7tEzmTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRzILsq7QDBAryUgrnN90PIX0gsBdQstwrflsL4F5Lc=;
 b=OjtGBz03EzYUDS4/SN53FqYxrQ2GJ+LTJ/rT/b53JMD9VsZQ7y9aVU+8hkDmxWo2EPqYMBqu4gighYKORHPeHfoQtW4+7Oz7yhwADELYs1cWk97xXxD20YQEIiL6ObysnMlVjLZXd723sf1RFjJxdL0h3yn3dBT9iLhkV3EIk/J58ldctqctFnv5tCfuogGNS1/wg3BKtVts1k3w9imsesF2mHvMeg1TkI1425bakrKWTnz7UvZKLI7Q8rMZfvMAezTo6jXijI6VjE4dARcVie/zGbPhof/RWd3c3DCvRTW30Ym0bC/euA8DN2nKXl2qYmyPAktQbYDAvcuUuR/CPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRzILsq7QDBAryUgrnN90PIX0gsBdQstwrflsL4F5Lc=;
 b=mNr5A8f0ayROUvvbxu1+3mTFLGbjPOSVrkOdl7oCUm+LTKZUo7Fk5uhTEeU0smnsgqcAeFoAy4YtQV6u8jRgh4galTSdO3A45oRAetIW5Ofc9F/a6fUGrde+bTFg29TJOyDSLQiyxfHvVWKR4nJxWNud6wR1uFcxOF9yuxF2vfE=
Received: from CYZPR14CA0015.namprd14.prod.outlook.com (2603:10b6:930:8f::9)
 by DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 08:17:50 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::b) by CYZPR14CA0015.outlook.office365.com
 (2603:10b6:930:8f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Tue, 15 Oct 2024 08:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 08:17:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 03:17:49 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 15 Oct 2024 03:17:44 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Yihan Zhu <Yihan.Zhu@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 02/10] drm/amd/display: w/a to program DISPCLK_R_GATE_DISABLE
 DCN35
Date: Tue, 15 Oct 2024 16:17:05 +0800
Message-ID: <20241015081713.3042665-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20241015081713.3042665-1-Wayne.Lin@amd.com>
References: <20241015081713.3042665-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DM4PR12MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e7b7f3-adb8-4c4d-568f-08dcecf1dc2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UUXEUS5LVdbP5a3qfKDmWaJSua/MFfat9faicJKHKSK78Z0Bmyd5Zn7cE8U4?=
 =?us-ascii?Q?EwdKdr1XY+kyYT8dW8st0zItX347lnQlpMS2CBrA4c7nSebwNvpQKQ7Ljk5E?=
 =?us-ascii?Q?WO4ABnr0k0EWg9M7D98ke/YtF6TGEqf4h1wDXoXCXB6e3tEK6AQefQVdd5Qm?=
 =?us-ascii?Q?jcoLR8zXijf2KG2RrHgteA6XJopnSkBufINN2/RKmGCPgF3a45t19qwNJN5b?=
 =?us-ascii?Q?86an+P8OSquTI5PMEGNVkmf3ng66vBTrkpksvKH7EVCzZgqXkkGWzmjd2qC5?=
 =?us-ascii?Q?pu6g3Gp3o3k2tno+r57oHhP0xkJbZhFZyHKm32NyhOPoIiLeUXmPRcv01F2p?=
 =?us-ascii?Q?kOCfjAAHQUm7xsRNNG7xe3pTmqyfRg1CBr+MTFMUaZaDgenpTWgu2lJwThAF?=
 =?us-ascii?Q?a5a53dHIg3khESGl/ngMhBESxR/VKJKQLg5J4PFL/cLUxzqDizoWU3QM+hVc?=
 =?us-ascii?Q?jKmKFlS9pWO3lhNeR09FSsQiILc6q9BTqpdKBHr8oNTMIHsEbmBaeoMtr2AT?=
 =?us-ascii?Q?9PNA+SaD6gdhf2aSRb13dIpmHyKbkYHs9fX7bsyLJrpKi484/xTfyqYvee8+?=
 =?us-ascii?Q?UEoFPjwtA7fvkCcb65vWVIuSuUn+bubmOD34nemuRy4I2C+MMY+kGFGELjk0?=
 =?us-ascii?Q?g85ZWVIsBDLLWG7y2gJeagPovLEoHAv/c9CIBfFPQxOHUS7+e4TxYA4x7T4T?=
 =?us-ascii?Q?5knONEwm/XUd24OCwNwynTa38vC6Pj/jNp6asxUujMNPh400KteuPpho2e+m?=
 =?us-ascii?Q?wJNuwD12LisTcvYid5Pw9HzfQ+yY0aTOMFOzSFGE6D1GjyhpJWXBcfa3u396?=
 =?us-ascii?Q?+Z3tf1GY0CShtFTdezN5YRTnpE0yLY7m4uob/BkgrBCAAcNNWeP85gd5pHbw?=
 =?us-ascii?Q?xHtLZVblhHwRdvAs6ubcNvHwmRm22KG2mIMeCQllme6K5yI30ApjIoiqbPpt?=
 =?us-ascii?Q?56G2pfuLQWyPebshI7wgwgslhlQDcmGuhccVZ6BYwYDOeUUuEvDW4izWhe7C?=
 =?us-ascii?Q?KwIYaHZHQJbVDog3lF50Y36nYC3hUlT9kAVQqSw4hNyqyN2ko2ALdkEbuAzx?=
 =?us-ascii?Q?tr05rYNAvK+qfgaKSZlzFtezY4/g6OkakgLhavQeuAd/QPytc+k2P2RxDCZO?=
 =?us-ascii?Q?E3U/kAM2K8oKIY0eQ39t9zA3CcZz3qT2wOl1I3qtUpE0VO4N5jRpaXZJqzdX?=
 =?us-ascii?Q?Yk3Gzzpwu6UIsWd4aqlX9jH/DW3ZQxBdEXT6ae6mIMa6e3kpM19CqpBh13XV?=
 =?us-ascii?Q?yR8qEQRQAhVoQtc7WZGsSKTPdRbT5NyzQFI79wQSLLPkQbYso+MH2vzQfaMd?=
 =?us-ascii?Q?9LsRx9Kwj7khHgN6YKgUp/sIpi64A2Zo0dSF2bG9Y0Paep5LdKG+O53rMEaD?=
 =?us-ascii?Q?AZEI5I6f7ORFPOH89iC/Y3+jybD5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 08:17:50.3346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e7b7f3-adb8-4c4d-568f-08dcecf1dc2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639
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

From: Yihan Zhu <Yihan.Zhu@amd.com>

[WHY & HOW]
Cursor corruption observed on USBC display with specific system setup with a
reboot. Cursor memory might still in the lightsleep state due to voltage
issue, we need program DISPCLK_R_GATE_DISABLE to avoid this issue only on
DCN35.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Yihan Zhu <Yihan.Zhu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h  |  1 +
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h  |  1 +
 .../drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c  | 22 +++++++++++++++----
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h
index cd1706d301e7..f09cba8e29cc 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h
@@ -690,6 +690,7 @@ struct dcn20_dpp {
 	int lb_memory_size;
 	int lb_bits_per_entry;
 	bool is_write_to_ram_a_safe;
+	bool dispclk_r_gate_disable;
 	struct scaler_data scl_data;
 	struct pwl_params pwl_data;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
index b110f35ef66b..f236824126e9 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
@@ -572,6 +572,7 @@ struct dcn3_dpp {
 	int lb_memory_size;
 	int lb_bits_per_entry;
 	bool is_write_to_ram_a_safe;
+	bool dispclk_r_gate_disable;
 	struct scaler_data scl_data;
 	struct pwl_params pwl_data;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c
index 9f885a03eec6..62b7012cda43 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c
@@ -50,11 +50,21 @@ void dpp35_dppclk_control(
 				DPPCLK_RATE_CONTROL, dppclk_div,
 				DPP_CLOCK_ENABLE, 1);
 		else
-			REG_UPDATE(DPP_CONTROL,
-					DPP_CLOCK_ENABLE, 1);
+			if (dpp->dispclk_r_gate_disable)
+				REG_UPDATE_2(DPP_CONTROL,
+					DPP_CLOCK_ENABLE, 1,
+					DISPCLK_R_GATE_DISABLE, 1);
+			else
+				REG_UPDATE(DPP_CONTROL,
+						DPP_CLOCK_ENABLE, 1);
 	} else
-		REG_UPDATE(DPP_CONTROL,
-				DPP_CLOCK_ENABLE, 0);
+		if (dpp->dispclk_r_gate_disable)
+			REG_UPDATE_2(DPP_CONTROL,
+				DPP_CLOCK_ENABLE, 0,
+				DISPCLK_R_GATE_DISABLE, 0);
+		else
+			REG_UPDATE(DPP_CONTROL,
+					DPP_CLOCK_ENABLE, 0);
 }
 
 void dpp35_program_bias_and_scale_fcnv(
@@ -126,6 +136,10 @@ bool dpp35_construct(
 			      (const struct dcn3_dpp_mask *)(tf_mask));
 
 	dpp->base.funcs = &dcn35_dpp_funcs;
+
+	// w/a for cursor memory stuck in LS by programming DISPCLK_R_GATE_DISABLE, limit w/a to some ASIC revs
+	if (dpp->base.ctx->asic_id.hw_internal_rev <= 0x10)
+		dpp->dispclk_r_gate_disable = true;
 	return ret;
 }
 
-- 
2.37.3

