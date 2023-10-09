Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775E0E95A8E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 14:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC7E10E276;
	Mon,  9 Oct 2023 14:53:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF40810E136
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 14:53:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzCwrp6kKbPrs9ory+4VVRXbKn81V1lETKACBSz442e68rqlNipYQ9lEA4jPiya2Fweenfw06CWyM18qAE5dWFi+xCIDquGDuols9xZmfWpnNWk4ysOVG7C7R+bGdiFw4+R7F0RamfFFrPeO+hq00F8gysAKsP1mqMu+evbnUlqdKUi7JvSqpK0GitXOO+VHj7ngaoU2kIbzJ/pxzd50GQNfROC2LPi3YEfwHWVCTEJ/T/n7bzGOCNo7QpIDRFueOC+IlJW8fVNJ/nUFQRoAZvps9on01lfId6FZoEqA+np8rBoCLrj/yguIgUL/XuDpqVH7n5rUQxVQcnCGHvKSPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEe6mqbaEReP5rUWhGS5se/gB1Ov/eXswvQt2PichpI=;
 b=LKDIn3Nfj44Q3zTgCZJbHQYNKQE8dwvEbb6kLT8gS0eT4DZzZAaA/ExC6dYpWBFaYerGQm+8Uxre2fcnP9h0WRAk0cjeMrM83Cv1BWozIA79bMl4TaFc5d5uKveAYB473vUpfYPy/5/0BjeYCaW6JMD6SBr1kuvlox4FcGVKvCPoT+Dau+uOeOq8Ckh5vXCFa1VR//JRWVJeJPHp8eLL0y48t4JapJNQjg7CBa9rDcBTZTEiyKQejBPOwwYuS3OVsDemogoCfkXMJqQdQednwOj2V6PPNoy03ESQZTOcnVY/3Dl3UxMl1QEcc58dsYea4R4+1++7kmuw1abYWyLQsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEe6mqbaEReP5rUWhGS5se/gB1Ov/eXswvQt2PichpI=;
 b=VrF7mAQVseSrIyMwArenw4rOavyJgFzxo9HT+0i5wxknxd5uivXEPJ/KW0ae/0+fHhV7wnRwLOKHlWkL+Oelgrjs6jHrG02NG0z84Gx40/gBouYK9nA2XB9Z/IOB2RjWkK+5bpQUpezcbgNeYn9SNktm5OHl2H7NUDtTguc9tB4=
Received: from BL1PR13CA0405.namprd13.prod.outlook.com (2603:10b6:208:2c2::20)
 by CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Mon, 9 Oct
 2023 14:53:31 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::18) by BL1PR13CA0405.outlook.office365.com
 (2603:10b6:208:2c2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.20 via Frontend
 Transport; Mon, 9 Oct 2023 14:53:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 14:53:30 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 09:53:29 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/3] drm/amd/pm: Update metric table for smu v13_0_6
Date: Mon, 9 Oct 2023 22:53:13 +0800
Message-ID: <20231009145315.597629-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: b136b0b0-7e86-4dd3-bd9a-08dbc8d780ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OYGoBBR/qko2eTA0O2+Fza3mRbhjaKQdmU+iQ+yTPgIE9FDsi0UE52RueMVNTyIlHvGdikVQ/QAHnDVBmpPERMvtNK6VfiEfOctbWDfQb5B4NoQl+nG/d/YKXBWvqqyZ4/5PzAlPalqNXn45EIvQk8YJPDRk+g0Y2fX/D1TUQPTgya5WXv35ulgnSOtRLK9PXolbyqdB8IUDkdExxLUxq6E2DvC4GIsuUclUTLw+Wryz9TxMJqJGG6+gxGVgUjKNLMDebSP3h050AQF55+4M/HoBDlWabBhhi60PBFvCFMYMiT3JEhK+qiFjKCKhu0+ZaY3pxGWX9PfMdeI8DhSrWiq8L27RQRaTXfUbIiiEAt5KBUIfuwzzQHPabLT0BYm/0VOjTwZy5DaRZNFd5P4uY+yjaeMRmzIaPh2chBUvzzytLzLrsyhcqsW6uhQ1hbxISCz8wyiIAftpDU0nBn1kp43nwJzPGXmRS1RPwPOHqfZf4YgdeKCiMzXdAEOkqVZJ6XSV8vgeiXW4zwGZglvLhLgwzE3ey04gdkYpht+s+ogYF9a62hS300v5G/TQcKuTM87Z5itq0YxpNhLmeu3rvPk+nWce9Ny5W8XiH9jXJ049wZ1a949K5qx6BLtDmS0QV8C6fns6DphN2JWlyYVHr3J3AFOaAJm2lS3r9Gzm4jDElYof6J98HGQqa/ljT44vwcoEiHMq8zK2xBAH9kIZaXpEFTNNkoZLvPi8g5e6teb/x2OsYmJgsqtl0Fey1MDS5tDnizRKZMOb42q8fUK84w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(83380400001)(16526019)(1076003)(40460700003)(40480700001)(6666004)(7696005)(478600001)(426003)(47076005)(36860700001)(86362001)(82740400003)(356005)(81166007)(26005)(316002)(336012)(8936002)(2616005)(70586007)(15650500001)(70206006)(6916009)(36756003)(5660300002)(8676002)(4326008)(2906002)(44832011)(54906003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:53:30.9307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b136b0b0-7e86-4dd3-bd9a-08dbc8d780ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236
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
Cc: le.ma@amd.com, Lijo.Lazar@amd.com, asad.kamal@amd.com, shiwu.zhang@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update pmfw metric table to include xgmi transfer
data and pci instantaneous bandwidth for smu v13_0_6

v2:
Updated metric table version

v3: Removed inst pcie bw with alignment to metrics table
version 8

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h    | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index 9be4051c0865..66edd839c7ec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -123,7 +123,7 @@ typedef enum {
   VOLTAGE_GUARDBAND_COUNT
 } GFX_GUARDBAND_e;
 
-#define SMU_METRICS_TABLE_VERSION 0x7
+#define SMU_METRICS_TABLE_VERSION 0x8
 
 typedef struct __attribute__((packed, aligned(4))) {
   uint32_t AccumulationCounter;
@@ -207,6 +207,11 @@ typedef struct __attribute__((packed, aligned(4))) {
   uint64_t PublicSerialNumber_AID[4];
   uint64_t PublicSerialNumber_XCD[8];
   uint64_t PublicSerialNumber_CCD[12];
+
+  //XGMI Data tranfser size
+  uint64_t XgmiReadDataSizeAcc[8];//in KByte
+  uint64_t XgmiWriteDataSizeAcc[8];//in KByte
+
 } MetricsTable_t;
 
 #define SMU_VF_METRICS_TABLE_VERSION 0x3
-- 
2.42.0

