Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D6FC5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0359010F748;
	Fri, 14 Aug 2026 21:04:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FBfPJur+";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011039.outbound.protection.outlook.com
 [40.93.194.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C435A10F73A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:04:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmLEOrO2IrIcM4xyvM7ghuAk7L9TCsofDqXWme/YyJ0FI8OI4MunomPasG1YFMG9dSGTbNeRFOL3hHvLmB7Qw89GqnsBktl1zxy6mv9uU2jtbLJUgbtwqb3J7OuhqId3KUaYQIjYJhIf8aocsCzpSNW1UpturL6G/a7nWwGe6O5zPIL+KQBGyz5gMVlKzhdDKkK56jel4+77lGhfGZSOtghK6X1+arG+SII4N7z4AiSQcJNxcYyLYqXfcC57XZjMJ5dbn4v4FXWypfHzslleME+7Zq4bNhDoQqXMI7dz0Kbn17bXkWJrVa6kNBeVQ27ALDlOBVEDkpHYWsultu1hvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H31B4QVgUZBiU9eUpH0Lm/gY/U51sX9e64gLwIyj54o=;
 b=nKj2Y5ZVOou8EAEx7bZyosxo79LTzLv6djNY1bl+48RWSY+k46Sx+oL8ZJvoYX6oDiFiqdWFpHx/byrdFMhVYLsMFYav9RZJ1teP3TSqyR/3urXdE01wJRIfB9uqOHTccMzTgGRrK5hJ9/tKYbZQmJRqETHGaJHrtJeXSlhDgP5RoLziYOhsAva/O7sVHtjozPyY4iC3HiBERmTYF9jnO+kV1DS7kyEn9WNrx5eYbanOK7WuIVTTHk+Q5/UUIU7X/i2avmcoQK+T//k3B1i3yrJkfw9rqBZ2rElUbi5pdyMZUlEqVmM+RtBUxbcvRCmDbrnh+DDeBDwLZSrSlgG+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H31B4QVgUZBiU9eUpH0Lm/gY/U51sX9e64gLwIyj54o=;
 b=FBfPJur+IxqNlV2+C2S1rI5lS//FIqjAtYsEEq2WLDKvfiUlexHUz8q5Zb/EBzTq730KHApMadjB01VojNw0vT9+cGXKFRASqXyfBEGgkTQse3F0iXTxH9C1U5beW6uElslPqsjAK4AF8m+4EcixmBYXWURIx/JrnUNV9Fuvzyg=
Received: from BN9PR03CA0573.namprd03.prod.outlook.com (2603:10b6:408:10d::8)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:04:01 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::74) by BN9PR03CA0573.outlook.office365.com
 (2603:10b6:408:10d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:04:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:04:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:57 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 100/109] drm/amd/ras: classify ACA v5 MCE status
Date: Fri, 14 Aug 2026 17:02:37 -0400
Message-ID: <20260814210246.3067612-101-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c59e01-ae08-4f02-3cd8-08defa47906f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eHEQ6ZKKxSOukBCZSESwn3JXU/xyE+eVU9lZEgk5xd27MsQ1lhl7xXNY6+o1QUau2zoQbhaHPxnoTTi/TbFM/BsAsSBiQuDahQHSE71M2GTC1V3IH9z1Sw1eOei5N4KyM7AymvyT4nCO+u2XXY3wjV1DZ2vZcVvak3b+RauRlfhgkrinDCncBSjYG5OLcRcFU99ua5D8SBo+ay+LrO5uQabycI99bu97VFRyjswbk4ngjK1KZKXSI99fDSHP9bAO/wsu4i8Fd8VUjY5mqCXYuAPTmLgniQeCPhRVGVUt8KpZtGXV3M2Q1sC5OJISu9qBuTu/AErRvlELH167AByWK+/U4ePyl9rf7v304RZDtzpVrrTZ9wU3jcHUOl1aeZ2yiYD5slkwxc0jwtPZo5vxaFjGEIiQ4ZAXIaBfaQueMNw/RYX3xGTlgg2OkrA430lzbB+M6Quc2q+5x1YdqIkkZnRV0sSaja/edfexqlq/ULJdiq51nYwgxP2p7feQ1rNJj2fTLnV+oCPqtEgkr77nq5ALc9tdclAKJPINMhuazx9tU4Lh0MYC27xi4yHdbqGV7EGY7GupBaqfT9rXCk/rVUJ3JntaHJovJj58eHee248cQ6Z99H/zJqvv6gN9h6p7r3cz3OMB7Tgt/dE/V1QWQFddyxmzzB5hFSN1h4k4geviaUW6I4axoGo5OXJmfAC6T7dE5r8bcB6hGpM7tm8Igw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CsnStGIvByZwApuE70YaAc0+7FWdm0SHPKZ9zJQD0pHy+KGwegm+TPhRezH6wxx3/9NJU7YQSTBQ5fHCMil6h9AYwqzLWasUKNiW6JzH3cTj0s0gUGlwLNExLOw2JWwOd748eRuW3EmpDkuKQXA5plX68MOeNbeg0zeOBOLyQlAqldLRNeSOPMhIo+mmEKARPXdaB2l3lKfQWf7rgvN4BmZTNc5Gp29p8GzyAsQEiTrUdQSy2F6Zo3byOY0dB7Z6k5IJ/9Kz6PplG3RIaj6fjRAuYO7/+K73xSOr1RbM5AZpLN8MBMtXmGc4B8okmgVLl7EnNWWWgcDUEb1xhKo8yAYJzfsp6zk0pPvdPamm+BS26rtNZgFFysfr1xGupXMPWTWfdmwNTAO3F7wVWOpKQRt9CsyLTJzEvUNzsGmi+Vv2IwPSQHez8hMjHHkpnICa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:04:00.5628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c59e01-ae08-4f02-3cd8-08defa47906f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840
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

From: Xiang Liu <xiang.liu@amd.com>

Machine-check records may not carry the hardware-maintained UMC error
count expected by the normal polling path. As a result, valid deferred,
uncorrected, and corrected MCE status values can remain unclassified.

For MCE-originated banks, classify the error directly from the MCA
status bits when normal UMC decoding does not produce an error count.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c b/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
index e35f96c3ac350..fe3942f54afc5 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
@@ -174,6 +174,11 @@ static int aca_parse_umc_bank(struct ras_core_context *ras_core,
 
 	ext_error_code = ACA_V5_REG_STATUS_ERRORCODEEXT(status);
 	misc0_errcnt = ACA_V5_REG_MISC0_ERRCNT(bank->regs[ACA_REG_IDX__MISC0]);
+	if (bank->ecc_type == RAS_ERR_TYPE__MCE &&
+	    ACA_V5_REG_STATUS_DEFERRED(status)) {
+		err->de_count = 1;
+		return 0;
+	}
 
 	if (aca_check_umc_de(ras_core, status))
 		err->de_count = misc0_errcnt ? misc0_errcnt : 1;
@@ -182,6 +187,18 @@ static int aca_parse_umc_bank(struct ras_core_context *ras_core,
 	else if (aca_check_umc_ce(ras_core, status))
 		err->ce_count = ext_error_code ? 1 : misc0_errcnt;
 
+	if (bank->ecc_type != RAS_ERR_TYPE__MCE || err->de_count ||
+	    err->ue_count || err->ce_count)
+		return 0;
+
+	if (ACA_V5_REG_STATUS_DEFERRED(status))
+		err->de_count = 1;
+	else if (ACA_V5_REG_STATUS_UC(status) || ACA_V5_REG_STATUS_PCC(status) ||
+		 ACA_V5_REG_STATUS_TCC(status))
+		err->ue_count = 1;
+	else if (ACA_V5_REG_STATUS_CECC(status) || ACA_V5_REG_STATUS_UECC(status))
+		err->ce_count = 1;
+
 	return 0;
 }
 
-- 
2.55.0

