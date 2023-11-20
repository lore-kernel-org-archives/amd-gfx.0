Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533FBC197A0
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Nov 2023 17:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84DE10E0E0;
	Mon, 20 Nov 2023 17:42:14 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D2CF10E0E0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 17:42:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekMWBiPowtXl4mNX36+pPNmU5BtYtbBQnmNVtvq0UIiySG0wJKBJhv8r94pJrq8aPZg8StHQVmMAikgXLlRiibMIn5iqc91jLCfj7KEkjc5GR1j8nIkUVlingyqdjTMa3U9CV8v0TW1lQEZxeeszG7DEq5AIQ/SUOBlyN+b06R/YRv9WmMzvpMPmNIhk7eaY5i8bTWtJap0/jSnyxIQBvKnFHTzlkuhYxzY353+/lV2l5k/4Fh9CEjd2vnpcmoIfl+wnzHvpGJtkkfal6NZrNclpvx/UwbuvXoQMrigzXwFAA5RTbwkikzC7KenPeyAfz3E6aAMl4KFh1rT+YbNl1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E54fFfWUppH6YNTIjPUqc8A57Cv46kYwG4F1N4rxeYI=;
 b=X/qwxnCpTFipkXqsLpjkCk7j+8caWBGMyIHeqCmedDB2yTy9nXE4Q6SnxX564Hl2SUJtKwD4tovYTRCDxZT6Kc6OgJA6y7clLzRRx2ZFvKyGwcEA6rImPqUR4RvN74f1MuWBlhRvBoef+/NiU141jOyHyivxJzjG55LEMivu8vzvquEVbzs3+hYVdcU0rfZnG/lPb1W5lzX712XM7Ed0Upy0U+DF6x9kJd2K4nP0zr42LeWGafciRAWUcuRyL1GTwQQ+PGGFeSLmNjCmu5K84CXg5/OusY9uDHpKvXdIFZ00IRtHQu94/N7PJDkkKSIon/hO1zeJzS5QfAcY0SpfXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E54fFfWUppH6YNTIjPUqc8A57Cv46kYwG4F1N4rxeYI=;
 b=CXzSiD0a1OH3aDLGWf71VMXyaaGeixXck8gcPR5idOKoN8UpCSqXmPRa0Cb3n0lXyqB+moyOqJ89oiiAPNxTrX4s4JqE8MukdUSzIxejEt3DpaxIYNaXVhTfvyBhWyqD5GJefxL04mStoNGYgE3c6FV+0UeMUstvkiZi8vpeVKc=
Received: from CY5PR15CA0059.namprd15.prod.outlook.com (2603:10b6:930:1b::28)
 by CH3PR12MB9122.namprd12.prod.outlook.com (2603:10b6:610:196::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 17:42:11 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:1b:cafe::dd) by CY5PR15CA0059.outlook.office365.com
 (2603:10b6:930:1b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 17:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 17:42:11 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 20 Nov
 2023 11:42:10 -0600
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Force order between a read and write to the same
 address
Date: Mon, 20 Nov 2023 11:41:59 -0600
Message-ID: <20231120174159.22491-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CH3PR12MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: acec818e-122b-49dd-1667-08dbe9f0065c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZ8Wfv9Q9g069civYE1DjGzFU4sOgujCmmhemEy3SVpNG7mV2j6l7dZBzf51sLXUApFX8GeaK/lGDedepgn2p963gWXYq2BFoTfPQg3GmTzhf1/CtNntLjJXsxJuI55S9z3kxiV1RrLimTqyiE/WvmqZo8bHyQmgg/55/+eHe5Q0LB3icBquau2YbIoGhq2HQDVTvNBDQhTeQ1EPO5R3nxLaDrG0OPM5gTTbpxH8n/pcg4ma+oVpt0l7P47DWpIvAX2rR/EME7kBMoBXuNqhcczLKVpzwU4FW5TXLDSLf/xgY2riblZ2hKAH3TJcuZE11wLSK2QYufAVt3YJoh3kkrLezN6OAWLYxwKKaT30lex7seLvy7f0S38e1twyzmilBrdSmOZViuiuDRG+QEVS35u6gZpF/EuYNQEVURASEyYRuT5fDINQf6omUfliN9ds+hC9UNbUWTVLd2kQm/ZqwiBEG6LZZyETTDL5m2m5MeALb2uYAMXDihlp/ZG0D1Dfa24XzUx7Ns7kri43VDIaFk1V/S2aQSaX2q1ac7WbzIQC22EOgm1g5xMP4o7/jpJTj/XqiJ/q7CrohOHk6nYedoYOhLOP/1l0KpSmIT9GOppfVz5JW+oCq+4oRSxI4FOS7IerQSjP+JrCwds1hBZbS1SwkEIevc/wK9+mOQSw8BNrTe5pG1Z4JMYWPg9jQsw/PnNcmIlHj4mmlrAyz/zT52jBlww6tVyrL9KZx0UUNFHt+kVLnjqhATJ19LB1D5BgLsP4MHFfkxvZPbaUL5msGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(70206006)(70586007)(6916009)(54906003)(316002)(36756003)(7696005)(6666004)(426003)(336012)(2616005)(1076003)(16526019)(478600001)(26005)(82740400003)(81166007)(356005)(83380400001)(36860700001)(86362001)(47076005)(44832011)(40480700001)(2906002)(5660300002)(4326008)(8676002)(8936002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 17:42:11.0240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acec818e-122b-49dd-1667-08dbe9f0065c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9122
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
Cc: Alex Sierra <alex.sierra@amd.com>, Felix.Kuehling@amd.com,
 joseph.greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Setting register to force ordering to prevent read/write or write/read
hazards for un-cached modes.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                    | 8 ++++++++
 .../gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h    | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0c6133cc5e57..40ce12323164 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -89,6 +89,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_0_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_0_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_0_rlc.bin");
 
+static const struct soc15_reg_golden golden_settings_gc_11_0[] = {
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL, 0x20000000, 0x20000000)
+};
+
 static const struct soc15_reg_golden golden_settings_gc_11_0_1[] =
 {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regCGTT_GS_NGG_CLK_CTRL, 0x9fff8fff, 0x00000010),
@@ -304,6 +308,10 @@ static void gfx_v11_0_init_golden_registers(struct amdgpu_device *adev)
 	default:
 		break;
 	}
+	soc15_program_register_sequence(adev,
+					golden_settings_gc_11_0,
+					(const u32)ARRAY_SIZE(golden_settings_gc_11_0));
+
 }
 
 static void gfx_v11_0_write_data_to_reg(struct amdgpu_ring *ring, int eng_sel,
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
index c92c4b83253f..4bff1ef8a9a6 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
@@ -6369,6 +6369,8 @@
 #define regTCP_INVALIDATE_BASE_IDX                                                                      1
 #define regTCP_STATUS                                                                                   0x19a1
 #define regTCP_STATUS_BASE_IDX                                                                          1
+#define regTCP_CNTL                                                                                     0x19a2
+#define regTCP_CNTL_BASE_IDX                                                                            1
 #define regTCP_CNTL2                                                                                    0x19a3
 #define regTCP_CNTL2_BASE_IDX                                                                           1
 #define regTCP_DEBUG_INDEX                                                                              0x19a5
-- 
2.32.0

