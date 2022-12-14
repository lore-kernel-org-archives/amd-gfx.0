Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E62C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 13:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0884210E3FF;
	Wed, 14 Dec 2022 13:06:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45AEE10E3FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 13:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwnrNivxjaYXfPcssk/+wN/ioUs7h5Eern/iKiu2tfvbFZvlrcsJSUSjBQALwy2DWIfraJWD2N4Z80dU3aQPBVSQmvT8wisN7VpetqGPFUFyr/qcc2I5NILbnpUJl4H/vvcKSuu+G/81XVht3MReONyNCnF2DzFDIMadJzGqsQjCq8YW79jdak+5lM+33Tj5SHlhTgKOgFqcytLDF1yOiZVnVNR4Krt13sOSbQq3AMIjaaw41zFZeB2Mhu+A5KZf0hPnOFVzoIixIjbtv0pPLYxzssBaP99PTjkPispK0Qf7/5BWgHqEIsgSzpyyqSr2kZtTR6xCC8Ezqq56o6yR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BxqcbCNZs/P1y+hfFo4lXJWOH85q9VI2smEBi9IwDU=;
 b=No27A+qVVgqMs+OB55+wliMaJ3GJt/uDq18J2sQdrtKvYMia9xl40ZGXUvYdeLzq6wej2SiXX+aPw1o8U0/MO0Od11VPyO13XM8zHnsRhdqo9K6q0WFUc+avBk/EVsIXjsNVWJ6261jv64NV9XONLPlYzyEfOrzpvOuea5W8W4A1G+iwmGM4dHpJlZ/aqapWw3n3S7xVx5BKx+ykdVzoguLsMBWcm6KgFY4mL550QRgo5/F0yMfnTqwGoGU7KkVSWDzCgdls/yZA8yfdN3S/KsLBw0B9lL/EUO+Y2kfO+xjuXpUYsFp0sZCBcbZVtuTDjfBgFtbsRP/fYK4rym1AiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BxqcbCNZs/P1y+hfFo4lXJWOH85q9VI2smEBi9IwDU=;
 b=ygRd090kAzYvHf1l9cXW1RHHb/uS3gAiA+2WfU7LZ1Wx8uvZA/p2KQ7UdlEK+RHy1avqPgNpnh54yIWwgWF/4iXRjeuS7Eg3vtV77bk19EBRHnB9LKC50nGpW5Awd/qIjN7jRdEig2W+gHubYlH8KLAB6Iqsx4q3ijcCGF2YbQc=
Received: from MW4PR04CA0363.namprd04.prod.outlook.com (2603:10b6:303:81::8)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 13:06:14 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::cc) by MW4PR04CA0363.outlook.office365.com
 (2603:10b6:303:81::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 13:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 13:06:13 +0000
Received: from candice-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 07:05:48 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Add df v4_3 headers
Date: Wed, 14 Dec 2022 21:05:36 +0800
Message-ID: <20221214130536.1027479-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: adf80fa3-c064-45a7-8079-08daddd3fa8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gerh3vztctSwHUJcLxRZP6r76yQiQFytG55LkMqpMoW9FmBC+t/+JlULSZnkkhZ+wRXi8ucHWbanwdwiBuWeYZTkQL8kenqEXS77QfbRf5ZkYkzQql7JXsaoUIh4shREyBZdrsEgy/1LiJyD84Jcilho7z8NDOxpXd+WqrpfMmuN6Lg1LhtxXiubeVNyJz240OtSUc6Mf6WPpcgny/+DkBOQsn3eRX9hX6WPv6MKSlDvvOaa73v9gHNP6lu4BD2/HoHtNBsxSTJQH4oMjPU5anxjRXM6fA3bPmlS4wdtkOVh4z3mB2cPYX95HsPyDQPNgpC/SBNwvDL2K3IgTxuaYGget8rHVDDaq2PMkpeNMtiZmqBcvCK0dVxs4lsuXLcuJBlvuwJjMSJ1Tt2zv14mOq+eYDct8swpRDBkJfFjnidqRr6DFw2yWRrjxlblLTEAW2sovJ5Bs+uKSO+QuGaBzPT+IDOZv8kHx/YW5sko0DyhKSOisCtubT6AmN5bdIf7V4flGdzs7aEe/tc20RZ5ewU4tF54wvHgrwb8LEPsuju8ODB2XnSEBB8KatL2xnYarXHINlQmIRoSwm35jTaHLXNQvbDPuVaj3QVplhEEDtWGXc1bgOAnBaxRxn2GWEW0PTNTYtTWOif+rSpOB7cBqDL1N4rqVh573O9P3ZAtyYsE03fJ36AIfqU7kISBp01ju38G7kHr1i4zIvXaPRJNQEmBJKXxcEJuVLIbqEpO8oQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199015)(46966006)(36840700001)(40470700004)(66899015)(2906002)(44832011)(30864003)(316002)(8676002)(5660300002)(6916009)(19627235002)(54906003)(36860700001)(36756003)(186003)(40460700003)(4326008)(70586007)(70206006)(16526019)(41300700001)(1076003)(2616005)(7696005)(478600001)(26005)(86362001)(336012)(47076005)(8936002)(40480700001)(426003)(82310400005)(81166007)(83380400001)(6666004)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 13:06:13.6330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adf80fa3-c064-45a7-8079-08daddd3fa8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
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
Cc: Candice Li <candice.li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add df v4_3 header files.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../amd/include/asic_reg/df/df_4_3_offset.h   |  30 ++++
 .../amd/include/asic_reg/df/df_4_3_sh_mask.h  | 157 ++++++++++++++++++
 2 files changed, 187 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/df/df_4_3_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/df/df_4_3_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/df/df_4_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/df/df_4_3_offset.h
new file mode 100644
index 00000000000000..fbb18e44ec5226
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/df/df_4_3_offset.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2022  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef _df_4_3_OFFSET_HEADER
+#define _df_4_3_OFFSET_HEADER
+
+#define regDF_CS_UMC_AON0_HardwareAssertMaskLow                     0x0e3e
+#define regDF_CS_UMC_AON0_HardwareAssertMaskLow_BASE_IDX            4
+#define regDF_NCS_PG0_HardwareAssertMaskHigh                        0x0e3f
+#define regDF_NCS_PG0_HardwareAssertMaskHigh_BASE_IDX               4
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/df/df_4_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/df/df_4_3_sh_mask.h
new file mode 100644
index 00000000000000..9c8f19ded4ebd6
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/df/df_4_3_sh_mask.h
@@ -0,0 +1,157 @@
+/*
+ * Copyright (C) 2022  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef _df_4_3_SH_MASK_HEADER
+#define _df_4_3_SH_MASK_HEADER
+
+//DF_CS_UMC_AON0_HardwareAssertMaskLow
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk0__SHIFT              0x0
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk1__SHIFT              0x1
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk2__SHIFT              0x2
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk3__SHIFT              0x3
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk4__SHIFT              0x4
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk5__SHIFT              0x5
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk6__SHIFT              0x6
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk7__SHIFT              0x7
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk8__SHIFT              0x8
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk9__SHIFT              0x9
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk10__SHIFT             0xa
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk11__SHIFT             0xb
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk12__SHIFT             0xc
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk13__SHIFT             0xd
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk14__SHIFT             0xe
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk15__SHIFT             0xf
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk16__SHIFT             0x10
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk17__SHIFT             0x11
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk18__SHIFT             0x12
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk19__SHIFT             0x13
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk20__SHIFT             0x14
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk21__SHIFT             0x15
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk22__SHIFT             0x16
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk23__SHIFT             0x17
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk24__SHIFT             0x18
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk25__SHIFT             0x19
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk26__SHIFT             0x1a
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk27__SHIFT             0x1b
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk28__SHIFT             0x1c
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk29__SHIFT             0x1d
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk30__SHIFT             0x1e
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk31__SHIFT             0x1f
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk0_MASK                0x00000001L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk1_MASK                0x00000002L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk2_MASK                0x00000004L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk3_MASK                0x00000008L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk4_MASK                0x00000010L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk5_MASK                0x00000020L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk6_MASK                0x00000040L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk7_MASK                0x00000080L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk8_MASK                0x00000100L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk9_MASK                0x00000200L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk10_MASK               0x00000400L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk11_MASK               0x00000800L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk12_MASK               0x00001000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk13_MASK               0x00002000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk14_MASK               0x00004000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk15_MASK               0x00008000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk16_MASK               0x00010000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk17_MASK               0x00020000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk18_MASK               0x00040000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk19_MASK               0x00080000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk20_MASK               0x00100000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk21_MASK               0x00200000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk22_MASK               0x00400000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk23_MASK               0x00800000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk24_MASK               0x01000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk25_MASK               0x02000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk26_MASK               0x04000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk27_MASK               0x08000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk28_MASK               0x10000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk29_MASK               0x20000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk30_MASK               0x40000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk31_MASK               0x80000000L
+
+//DF_NCS_PG0_HardwareAssertMaskHigh
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk0__SHIFT                 0x0
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk1__SHIFT                 0x1
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk2__SHIFT                 0x2
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk3__SHIFT                 0x3
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk4__SHIFT                 0x4
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk5__SHIFT                 0x5
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk6__SHIFT                 0x6
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk7__SHIFT                 0x7
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk8__SHIFT                 0x8
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk9__SHIFT                 0x9
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk10__SHIFT                0xa
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk11__SHIFT                0xb
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk12__SHIFT                0xc
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk13__SHIFT                0xd
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk14__SHIFT                0xe
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk15__SHIFT                0xf
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk16__SHIFT                0x10
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk17__SHIFT                0x11
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk18__SHIFT                0x12
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk19__SHIFT                0x13
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk20__SHIFT                0x14
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk21__SHIFT                0x15
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk22__SHIFT                0x16
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk23__SHIFT                0x17
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk24__SHIFT                0x18
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk25__SHIFT                0x19
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk26__SHIFT                0x1a
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk27__SHIFT                0x1b
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk28__SHIFT                0x1c
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk29__SHIFT                0x1d
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk30__SHIFT                0x1e
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk31__SHIFT                0x1f
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk0_MASK                   0x00000001L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk1_MASK                   0x00000002L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk2_MASK                   0x00000004L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk3_MASK                   0x00000008L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk4_MASK                   0x00000010L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk5_MASK                   0x00000020L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk6_MASK                   0x00000040L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk7_MASK                   0x00000080L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk8_MASK                   0x00000100L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk9_MASK                   0x00000200L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk10_MASK                  0x00000400L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk11_MASK                  0x00000800L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk12_MASK                  0x00001000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk13_MASK                  0x00002000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk14_MASK                  0x00004000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk15_MASK                  0x00008000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk16_MASK                  0x00010000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk17_MASK                  0x00020000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk18_MASK                  0x00040000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk19_MASK                  0x00080000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk20_MASK                  0x00100000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk21_MASK                  0x00200000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk22_MASK                  0x00400000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk23_MASK                  0x00800000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk24_MASK                  0x01000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk25_MASK                  0x02000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk26_MASK                  0x04000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk27_MASK                  0x08000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk28_MASK                  0x10000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk29_MASK                  0x20000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk30_MASK                  0x40000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk31_MASK                  0x80000000L
+
+#endif
-- 
2.25.1

