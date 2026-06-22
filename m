Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4B3CDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E067B10E48E;
	Mon, 22 Jun 2026 04:43:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YvJhxp4z";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012003.outbound.protection.outlook.com
 [40.93.195.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F81310E491
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:43:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mI1lyKTLcjrUh+5Hq2MC5qgPaBOsKD5Pnngohk7dwJYklX8qv277eHFbFB4wL37kR8xM0Q3gF0ohcdMNiekobJ7n7dI7RMBJfg3I14yYVOmg687mZ9WaiGr/7DxRt0xUCYHvDcU6/rQ4VNM1y7k/YVGK/V06FTFHWjiHkQHbAIdqOjfQzGBAcyr0osOxqayl16ObDY6XmQod+HvRdILLVHQE95aalXzv0htGwj1j7M9IGp+FwawrXpwJ/JGOGP4wdTsijGg/bMNM4bXYKGx7DFqvRJ6m+DXPBWMcE6DZ2+ocbyagTBVGGLxx/TdHG4+RrDnuGvD/zuVCMYPrsYzceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5qqz1+kflxFfXBUYbuOBbG8a7/1NDWka+M646PgGho=;
 b=P3scaX5doWyRr/B2jSRISGUDK9TB0QUufu+TkURc5FNtgdwy0fS+rOmcef7THG2olcYNNwqGI8j5J1v34gZctq1OxfmWu4iyFFX1oI6zZbx5rT6XuF0O+U7UcdI90Ga/wjWXDZ9qF1NgISjgkvHeC6IyL4gy4mWglW4vSmTvGw4iFAAj/PZqvsOV3375vhE5BQEvwmuuVRiP39S/hzJdZiQCTIVKkIb6J4PQN2lXG2Ca/+W/2+g6X2wv7eEA7CNCtI2qGOy6d9RH8emRAgI/yROpg8xm5PrkmOX89p171ddnTmJdXUT/jrQ/kqB6Ce+zpAlijY9SFovESmvj3xBtsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5qqz1+kflxFfXBUYbuOBbG8a7/1NDWka+M646PgGho=;
 b=YvJhxp4zIWsOKMtO+Agu3ceFZ43RQ+eOZPNW+DN48IBYWwtlMTqCOrRNp4evnvmf5eYDQlzkcatLcBmF8QsJFhTX3enJlEX5rJOuRTONfCRe+iOhLkYvot8f3zTOuaTCGBPgw873mDXBdQ/OWoIJw5YhDCeFz/Kn9M88VjXpn1M=
Received: from CH2PR20CA0029.namprd20.prod.outlook.com (2603:10b6:610:58::39)
 by PH7PR12MB7115.namprd12.prod.outlook.com (2603:10b6:510:1ee::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Mon, 22 Jun
 2026 04:43:32 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::8f) by CH2PR20CA0029.outlook.office365.com
 (2603:10b6:610:58::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 04:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:43:31 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:43:28 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 48/48] drm/amd/pm: retire legacy MCMP1_* macros
Date: Mon, 22 Jun 2026 12:40:37 +0800
Message-ID: <13e43cf250ef3d8895f39fc09f0393cc14dd445a.1782103074.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|PH7PR12MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6dbfe8-a5c7-40f7-2161-08ded018cfe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 3BRC6umxVxvJ8XISo294exMlg+VBFFH/omjWCanUsmcRTEooCPxt2IXs1CqYL2gskFp7e9CLizv6JGEQtr0p4VG9a8WuWWxvG/vNP0qYu9Ge747rG+TLVErn4uFXkv7jVenS1xHA0t/HNfEB87aVJgnKxkuwYZQqLsVHUtWlZ3cs+DXhrZJccZIygyj4D1ZqNs7P22pwik4itEtAlOWSbUColJ5f38oWDUTuewHhkNLnHlh5tKqNYdneFz92oa53nn7ggNz5rcxPJdvTcyGhi4Z9V/si45VPkeXCX5TqcIqn78MRkL01Vd7yIHNCyvY4uaJmpoTC4DX4THHELw9/D1MCbqdZeeXBtxEgNp/cbXr4j5/c7mbROyenq4uyTvkZ0i7c5dz+qftld63c83t9jEhQqaUEQP4iWTvvgDHhJ6Xb7bAGXSwdUHwL4qgpceUthLn3BZOhCgGz3HMykNWKoFJSUoVe7Llcn9sMRq62mZsDdCXSwPnC7+8QEE8e+4x6QT1ze8PeHuRb5yQRjviSPHrIjnoNmzl7UU9ezBa2TDRaY/7DLxJzzWm4NdwNNmG4rWOSDVDHU4ISfWXmGXZektUwk5OGWRX4mYt53s7GuqKWRq6+nXfJLWZWJX6YgtRdDdR844RttVvBPz/asOQzl7srAWwcAQPBQwiecdRdmiKkKve1JJz01Mmj0pB0w9jckwZf67FVDXM4OH3gwAB2hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(22082099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aE9WDLhggeRilOTpKbKqQkqWEP7zwkUb6iChwc5yhIiI2HLzHEExD/ys9iD3ZIOdtAixjL7ZLn8axblMzHd5P9o4EXdakczo4bUZW/i/WMv068s5NfG3Xq9EZEr1K+BuaSXMfQyYsPPWF7kSN8M15V0GEOvDjHCHRT5inctghzkrcubomIcEK2x954dNpkIZILHewm626Fearrc5T+/o2+fyEm1YVMM3clgRHnA+sFxo1eSsBJ12/g7ZLK81PyeRMQ0DJi46H1iYU1qkPPikcGufvYXuP2e99LCh7oLhQm+hI0yvTeZwcMemZPm2yuFxoE/nqaHCfR1P1SiYgBDzcHOqOJlAK5P8t1C0rxXBzrP0YayercV3P/HvlbeGRJXFrmgTBnzqFVvb0iD5QRJeS0es7TUIJHa6yRuiAcTykQH7mq/CL6573TH1dO1mdBFw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:43:31.8200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6dbfe8-a5c7-40f7-2161-08ded018cfe3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7115
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

Remove legacy MCMP1_* macros

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../include/asic_reg/mp/mp_13_0_6_sh_mask.h   | 29 -------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_6_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_6_sh_mask.h
index 2684e396f548..9d237924a59c 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_6_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_6_sh_mask.h
@@ -670,33 +670,4 @@
 #define MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK                                                           0x00000001L
 #define MP1_FIRMWARE_FLAGS__RESERVED_MASK                                                                     0xFFFFFFFEL
 
-//MCMP1_IPIDT0
-#define MCMP1_IPIDT0__InstanceIdLo__SHIFT                                                                     0x0
-#define MCMP1_IPIDT0__HardwareID__SHIFT                                                                       0x20
-#define MCMP1_IPIDT0__InstanceIdHi__SHIFT                                                                     0x2c
-#define MCMP1_IPIDT0__McaType__SHIFT                                                                          0x30
-
-#define MCMP1_IPIDT0__InstanceIdLo_MASK                                                                       0x00000000FFFFFFFFL
-#define MCMP1_IPIDT0__HardwareID_MASK                                                                         0x00000FFF00000000L
-#define MCMP1_IPIDT0__InstanceIdHi_MASK                                                                       0x0000F00000000000L
-#define MCMP1_IPIDT0__McaType_MASK                                                                            0xFFFF000000000000L
-
-//MCMP1_STATUST0
-#define MCMP1_STATUST0__ErrorCode__SHIFT                                                                      0x0
-#define MCMP1_STATUST0__ErrorCodeExt__SHIFT                                                                   0x10
-#define MCMP1_STATUST0__PCC__SHIFT                                                                            0x39
-#define MCMP1_STATUST0__UC__SHIFT                                                                             0x3d
-#define MCMP1_STATUST0__Val__SHIFT                                                                            0x3f
-
-#define MCMP1_STATUST0__ErrorCode_MASK                                                                        0x000000000000FFFFL
-#define MCMP1_STATUST0__ErrorCodeExt_MASK                                                                     0x00000000003F0000L
-#define MCMP1_STATUST0__PCC_MASK                                                                              0x0200000000000000L
-#define MCMP1_STATUST0__UC_MASK                                                                               0x2000000000000000L
-#define MCMP1_STATUST0__Val_MASK                                                                              0x8000000000000000L
-
-//MCMP1_MISC0T0
-#define MCMP1_MISC0T0__ErrCnt__SHIFT                                                                          0x20
-
-#define MCMP1_MISC0T0__ErrCnt_MASK                                                                            0x00000FFF00000000L
-
 #endif
-- 
2.34.1

