Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765DBC001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 22:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FC2E10E5FD;
	Fri, 20 Oct 2023 22:06:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF75710E5FC
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 22:06:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8+9rAfEWr13QCeNCudtCBe/6q2IozqgIxZaBf6pk2Yn5fXMxqUoyTTFSsTD215424jtB4UyjmLQ7xCHukSMHZl8wsQLpEulsM1Me/1qjr3zJnLNVFOYJjTy/AbgnUQsDr9Yy9FukiuVcM65fQF9lD01KOCbKi3SpOgZ70boOCT61DAjcxk0wfRWH7jhj3ts6E5tnc4p6bHG8+g0K8uzvRUXYufvVwty/ED69isB/TbxHzF6RVF3tjb78TdoxRek6DRggJ+GnIY0S14IxDlDmj4wBQrx5LHGD6q7nLij78abppzFuAtUmsiaBocbhRiSO6v0bJ32XEfUfE6poZD70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzjSgDDOGkdpsE9ADRD9mGnM3MgK5oW723Dx5SRye4Y=;
 b=IzbmfZ5RTKNoWRnUM08zc2GHPniqoCJOl2tLc+sAquOrOPZKJBY/IwA5flpjJPD4C5Z47CfDA16WLP17W+fdMfFJyaldjv6o4q76434RdDHzf67QpEGcjjujCIPFfDyDR6OX596kVZy/NSPxGAczk8wfxEwRE3IONNkq2TvssyCM6GZAtHKL9Zcx7uQRsjr3Pt71Nu1sQZYovEpixqggocVc8NfvgqLLpQNo2RQhRDe0qrop7xuFgEtUBrlHUrLFKntZ98X0Zy8jW85smBfvOOQLcm9KtU2N+HCWUHExQOjyLzhXWRZVZvFLqmYgUYrYIBK/yqRn1QeNCNGDyW6s6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzjSgDDOGkdpsE9ADRD9mGnM3MgK5oW723Dx5SRye4Y=;
 b=IZ0cXCWJmVMpfum1qauSMwbGupE3Jw7JoF8KlPBM87aXTwFLCrhJJqk8f+ZMb1FfQrug6iEklGjiuRLb72LnPUlxBVI1V572+VcmqZkNhm4uyGOlFBtrJlw+WgfHFVlE3fDRwsg2piTP9ZL1AC2eV3e/krg2MocYKlSti7/bPJc=
Received: from MN2PR17CA0020.namprd17.prod.outlook.com (2603:10b6:208:15e::33)
 by MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Fri, 20 Oct
 2023 22:06:30 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:15e:cafe::bf) by MN2PR17CA0020.outlook.office365.com
 (2603:10b6:208:15e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 22:06:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 22:06:30 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 17:06:29 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 3/8] Documentation/gpu: Add kernel doc entry for DPP
Date: Fri, 20 Oct 2023 16:05:16 -0600
Message-ID: <20231020220549.493808-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020220549.493808-1-Rodrigo.Siqueira@amd.com>
References: <20231020220549.493808-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 9981e79b-b526-4e48-9f45-08dbd1b8d065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1/xrJUPvT9gHVnBrgkQbUF1E203ITpqaDqkIIux1XyZURNcksJ51/cRUrd47zI1e2+52OeDMOVAbNQH9fkkReGno7jt0FXE4c8crVoY2jTC40wEdIiFd11zGdzPhYxP/o0ORv8Cbl4xVrqvwJYNeEwo84lUgjMAQp6wekOi7uHQ+CU944ozrZouCkoFq9ZYoQGelij8FzX7zttg54vuunauwl5kQUYsujgVUIwAlBPDSobQ82HPZOV5uYS3nu8vFWLjLrEztXAqxpSSlD/fBk+jUIJUHD6sZo6irWjiSgMxDy+oxbcwzobsnY+2wCWG9ce8nuoR+Ct5Nw4OXB7Y2gz6mHfWYlEeauS3aMQF32mhVLI00H1srEbYqyNK8RRIY7akqbMbawq+YwI4UV9ljfwFPEtOxV/o0/talQg61xHQUdiWxOWZkBwPWfulGZ12EeW5Lv2ETCPQ/FQGGSfpjv+t2iR60dMu63u7JFRqS+dbLFj3KezHuqc9GQdKi3oNXTSfUk4rKSErDeAsAlmuWunmusKPJ2mI7B3vuEv4bSkVmg56WDAQAhwZAQ9vj6ws5N8Z/XQl/N1VD6/pqiHobR2ZnLCIeXCeKnREgbIbOUQxIfCJuN0OUjmSbhrwRUYuUKxRxc+XvA7MWdiPub2tmoLRg7oHkRgn4Tlhu1C9GgSY5RzF5ygFNVtCe/shi8tTuBNR0Chxs1tGKmVfDNyYaeLQDJWlsFt1Q8HH8PV/vAaexfdMMI9u64OTRZ9n7KH71x4ZxEXY7BYr71aFsIxbB7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(36756003)(40480700001)(40460700003)(81166007)(110136005)(70586007)(54906003)(70206006)(316002)(86362001)(2616005)(1076003)(356005)(82740400003)(16526019)(5660300002)(83380400001)(426003)(336012)(26005)(36860700001)(6666004)(478600001)(2906002)(8936002)(47076005)(41300700001)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 22:06:30.3096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9981e79b-b526-4e48-9f45-08dbd1b8d065
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry
 Wentland <Harry.Wentland@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This commit introduces basic DPP information and the struct scan for
code documentation.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/amdgpu/display/dcn-blocks.rst         | 12 +++++++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   | 26 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/Documentation/gpu/amdgpu/display/dcn-blocks.rst b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
index e4e0a4ddca4e..83fc4a03113e 100644
--- a/Documentation/gpu/amdgpu/display/dcn-blocks.rst
+++ b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
@@ -28,3 +28,15 @@ HUBP
 
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
    :internal:
+
+DPP
+---
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+   :doc: overview
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+   :export:
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+   :internal:
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
index f4aa76e02518..2c40e253b14e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -27,6 +27,32 @@
 #ifndef __DAL_DPP_H__
 #define __DAL_DPP_H__
 
+/**
+ * DOC: overview
+ *
+ * The DPP (Display Pipe and Plane) block is the unified display data
+ * processing engine in DCN for processing graphic or video data on per DPP
+ * rectangle base. This rectangle can be a part of SLS (Single Large Surface),
+ * or a layer to be blended with other DPP, or a rectangle associated with a
+ * display tile.
+ *
+ * It provides various functions including:
+ * - graphic color keyer
+ * - graphic cursor compositing
+ * - graphic or video image source to destination scaling
+ * - image sharping
+ * - video format conversion from 4:2:0 or 4:2:2 to 4:4:4
+ * - Color Space Conversion
+ * - Host LUT gamma adjustment
+ * - Color Gamut Remap
+ * - brightness and contrast adjustment.
+ *
+ * DPP pipe consists of Converter and Cursor (CNVC), Scaler (DSCL), Color
+ * Management (CM), Output Buffer (OBUF) and Digital Bypass (DPB) module
+ * connected in a video/graphics pipeline.
+ */
+
+
 #include "transform.h"
 #include "cursor_reg_cache.h"
 
-- 
2.42.0

