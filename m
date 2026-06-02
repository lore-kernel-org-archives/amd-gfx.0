Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7B6C5DF71
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 08:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 310E711395C;
	Tue,  2 Jun 2026 08:41:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O7xxk9k3";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9217A11395C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 08:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O52UZW8H9YQkq6ZT3WPNzZwRZs0PT0Gb+ZjNGYReaP1132bBLB+7z1qY0hlEuI8BgPb3bCLUGqtOoIaYkPE2K5mn/BRYnjsxrEfTCp+KCdr2BvnSJPEQN+ldaID692dBo/EEpHsceB0bu6Z99L6EAiGcA40uEvctxeCZJ9HrIJJJGCAFsqlDnbEt96UKOk17elr0k7iH5YACqHeNCSMvH4tAMvCMVfjFFtuyUmgTBu1OLJQaQyIT72PTVpZdbVmGBqOBzd68u3HSA1u1DB2CC/GOJHwlrPwgSLrGwl9+NF64KYMWosdO3h8kfomp74pBSHurrOpkYQjXWBNrFj0GnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFWN1wjt6sjz/UQXE1rFWI5jYegnp5o68IkGjCgetrA=;
 b=gt+3LE4O5tv5pK4NLfKyzd/nAOnJGO7XOu0//y/TnbVgAxTW9SFnH5hhdbw9wRzqdXZp2YSacb9uXKSCa8H9okCS3Uo0YcFgLnFZSGmS7maG9qv7wp2Ka5tOjkUCqpKw+FtmhA9w92iaPZGoTcvTpIP9HPTEJ5X5NM6rfv5yPEB+0AAMAVi67yCP9RxektkuCaUBU9TwL8oXWFmTDqAL6wJuucLrar1cXz8EMlNjw/r/pWXyDjuDCRtAoB1yuAL8BdLeds+JL6mR22/sBufUMvAMbxETo95PF1xqAgsr/56cfyvylz2TgUYJ+HUgHH/cYRtt5YOewI6mx1H+lIe7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFWN1wjt6sjz/UQXE1rFWI5jYegnp5o68IkGjCgetrA=;
 b=O7xxk9k3Jb5EQUJ0lHGbyRIctn0A8+acrkk7isN37h6uZefeBR4STbtX9Vv1vtdBRAfCgOXzKP/+u3Ez7Wx2afTN39Z9X2CUFPbp2AbSeTyMs3/UuGzRuM9dSFK+o9qmpL+Wr+gU6mu+f6IP19xw/d48cDrH5udBnU7GpZnhnZ8=
Received: from BN9PR03CA0680.namprd03.prod.outlook.com (2603:10b6:408:10e::25)
 by DS0PR12MB8365.namprd12.prod.outlook.com (2603:10b6:8:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 08:41:41 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:10e:cafe::13) by BN9PR03CA0680.outlook.office365.com
 (2603:10b6:408:10e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 08:41:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Tue, 2 Jun 2026 08:41:40 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 03:41:38 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Xiang.Liu@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v1 1/3] drm/amdgpu/ras: Parse all deferred errors with UMC aca
 handle
Date: Tue, 2 Jun 2026 16:41:30 +0800
Message-ID: <413871402481719122157663b7ed94d26d53cccb.1780389586.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1780389586.git.cesun102@amd.com>
References: <cover.1780389586.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|DS0PR12MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e8b345-ece2-46fa-bfe8-08dec082c487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9XkcmChGPYnsJk6EZw9FgvSdrl4JFkJnS50kCVSgyudeKiI2KLkqSwDbWAP1e+qMHhuXiBMKXRfrd6dld6Su7xYBWbTOkw7Uxun0THAVILrzPiUWTiyKr/PD8gQ31tBPi7gFD15DTCy2NmfkV4r4NXLDgekS85FrW6VHROCEhwt2oBOuqNlJIxXZvck6gy6XmcMHnxRTUBnjua0SxnjwzCsNCehedopseWx+Ibsprd5wiwNuWuq1j/zmkaCocIrdJtAEVWZOgvUR32Tv1YIkilIWo3KKWPAdUNG1XZkVHtqzYREn2JZvjzQUM8cI7NYlBPuk3B/4/NfsctPB6SnFYpf5gQSqONCGC/5kJpM3H+cXSJtIhq13pk+qcKMdocBypZNf9sq9OHkEjNP5C7CVmKsU6RMvXmHl3wkRFu26CLG25Uczl43WiiFKDPjgZHxcugBF8SBkzO5mUn1VAel5+lKZ7XgS1cUWHpmOjDZ0mIBN1yfLSWf8cOJ2gqjqY1LUEdy62VpPFiZ0lsRnKxXXZCI1z6Gg3WpDL9ddl8mQAuQjB7T6U0ZYa+ZZ/zZJ+PugoaVmw2ut6VfdY1KrlBunAzsJztD/5pxfr7v3YE4B72ZeGZRjI2IkMjsni7msssnn0dvdz/7yEtsbriMl4FYClaZpX4/POxiFpYTXrrNwWhoqOLCe8wBVolVJLn/M1fyBFOBWedpMo5dH32B1gH4ZkiCB74w3mMbO40NkEuYqh6M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HPjr3LCfTvYw/RIPNzvMbA40A4i9Gt7XMca40v69BlXjqCgCffwFYMJv6sKxJBT6m60OoWKaTJ0/W/ptwFnLZkMjGKW7dFA38N6DRPAMjrbsGDyTMp6INn6qhuCPJVjq4ccoAPSH4DfI/y13+AOXjpv0LPcR5YfKT66anTHgro6rd+pJW+HV4bBg1JBLLryVmMPjl4DSaooF0Cw3q5ITE/+Ey67JFGpfuEhp5X3kp0NzaZyN09TsbbVhH1VVmjeOfTA6lS6J637yPGTWhM+pkZq9Y5uUho18MgomNoibypJS6G6SJ0/6GGNIWb+dX4/J+bcVJH6Awz5XMU5db+a6Ev7S7rybO2dRCSAv8C/kdeRX9CTu8MLVK+P4y40LOQzXlmdvp8vukq70Mq2FAhWTig7J6Rau5D/i3U5lk4Hw+qULPzkBm87JaXxogPRz2wWf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 08:41:40.8291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e8b345-ece2-46fa-bfe8-08dec082c487
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8365
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

We should only increase the deferred errors in UMC block

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c | 7 ++++++-
 drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
index 210fbd8851a6..31ac5cda9cb5 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
@@ -77,6 +77,10 @@ static bool aca_check_bank_hwip(struct aca_bank_reg *bank, enum aca_ecc_hwip typ
 	if (!hwip->hwid)
 		return false;
 
+	/* Parse all deferred errors with UMC aca handle */
+	if (ACA_BANK_ERR_IS_DEFFERED(bank))
+		return type == ACA_ECC_HWIP__UMC;
+
 	ipid = bank->regs[ACA_REG_IDX__IPID];
 	hwid = ACA_REG_IPID_HARDWAREID(ipid);
 	mcatype = ACA_REG_IPID_MCATYPE(ipid);
@@ -178,7 +182,8 @@ static bool aca_check_umc_de(struct ras_core_context *ras_core, uint64_t mc_umc_
 {
 	return (ras_core->poison_supported &&
 		    ACA_REG_STATUS_VAL(mc_umc_status) &&
-		    ACA_REG_STATUS_DEFERRED(mc_umc_status));
+		    (ACA_REG_STATUS_DEFERRED(mc_umc_status) ||
+		    ACA_REG_STATUS_POISON(mc_umc_status)));
 }
 
 static bool aca_check_umc_ue(struct ras_core_context *ras_core, uint64_t mc_umc_status)
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h
index 40e5d94b037f..c4c136d4c3f3 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h
@@ -67,5 +67,9 @@
 #define mmSMNXCD_XCD0_MCA_SMU 0x40430400	/* SMN XCD XCD0 */
 #define mmSMNAID_AID0_MCA_SMU 0x03b30400	/* SMN AID AID0 */
 
+#define ACA_BANK_ERR_IS_DEFFERED(bank)                                \
+	(ACA_REG_STATUS_POISON((bank)->regs[ACA_REG_IDX_STATUS]) || \
+	 ACA_REG_STATUS_DEFERRED((bank)->regs[ACA_REG_IDX_STATUS]))
+
 extern const struct ras_aca_ip_func ras_aca_func_v1_0;
 #endif
-- 
2.34.1

