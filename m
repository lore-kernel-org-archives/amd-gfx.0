Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4B6C71145
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8654710E5C6;
	Thu, 24 Aug 2023 21:32:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E989810E153
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuyubMCNnh4gXyURWs6WU8Yz+6I07pjDIt8S0KLgaVqVUTnKEaMWvYve7HA7ycEok+5LnNac5OYf1DJThNmg2CPbs5+EON4e8RkGK2dyUL04DnSBg4Bpt27d0a09kVAo0zs5s1gnkxOYfb2VanCsqk6gOalcT1QfurPglsKvo5obwYYnKYJvXTznA+0Gjd+TR4Dga/fi47zXPUvG7thlckO2BYy1oT4tGoAryloeM/G3r6eeawVBb/nQRzI8AQJrhLDw83nvSTNbYb1PlIxyJJqht7YCcSYuKCt9tTYyh1ck9eoBenNg3cekZM9b55PD+SbSGwoW2iboBLOsP00+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pc3ETFFxncHWrJ03n/lXAaQam4uNveBbZKhb1kiTGYI=;
 b=ieF73PLbT65hdTIi1DKECzEJRne7JdHW6jdVEbBwN96OOfJt5Z96DqKdblgD4DPqkG6b8YeuxL7pC8J3bM2OUCwIQiJGoELYpgwk7+yTH0UrRk1q2KdkS9To5HsYCLc53afQDAxz2baARp9TKbcLQlTKgWIul+svSKwbHkO6oHbXJ6cI8uiRHgOSVrdtTiHoywY29cG55VnwXmo62vkwN+zEUiX+6y1ib0+fn8Zq75ZGEqKbBH/BeRhdtPsKzaLPC/MW4AM18E+JPmeDa5RfkxqmTlJHsR/fFWWqyk7Rxgwn8s9q+inMTTx/yfJjH13rqoPbA2yszXJILabeCS9iXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pc3ETFFxncHWrJ03n/lXAaQam4uNveBbZKhb1kiTGYI=;
 b=Z1Ir7CBbfpYFsua2a8iO40Zbvor1eY3/ZElYQLz85so3ajhonbK2cs5s/boCNaiHkCtOisJ1HJSzGQEQtPefTqsY0wxATFhis5sV7ODpzpvyKFA7Wx4pZ4YPig6OClsqAYldjMefGAJE0dOwARh11x9Y0CnTM1KdB9T4/fG8JIU=
Received: from SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::24)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:31:50 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::da) by SJ0P220CA0012.outlook.office365.com
 (2603:10b6:a03:41b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/21] drm/amdgpu: add irq src id definitions for VPE
Date: Thu, 24 Aug 2023 17:31:16 -0400
Message-ID: <20230824213127.2725850-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824213127.2725850-1-alexander.deucher@amd.com>
References: <20230824213127.2725850-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CH2PR12MB4328:EE_
X-MS-Office365-Filtering-Correlation-Id: a8cbbac6-41f1-44ee-06a9-08dba4e9873a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OCzaK9YkodOl6mA+gb613FiLOJSpOVkhCY/JZMMy4mneTtHGLhbC9o/uOSRPRTQvM8xcyqiy8e1XAZZtALjRkW8aUy8u+0+WRm8QSerzPP3pB0+WUWHEc+p18Np/mmxfu8PTGMy4iQgs18y30zig2sWoBbdXfoMKiZNuU9ixdA2e3mBCtXa9G/EPi/jZEAFTkEbq6UKs7j87Qf4FkchggPaZ8GA38xhKXymHGBJA2xuZir6fmugFBRVp++a3x/4YPLK4TYs9l79m3JzdVbmHj3OyBWkuBH8daAG49Uek6W3oAXqsSeOzb0Fs9G6gg0KucCg0OEYIXqvl0F1+g5IeIv1Ffb19LybXS3TS4soTeSW6ZpQH/tKPTdVi8Oh7RqrGikR0gXC4H175Cq6Zhaa2sjb8bgmBQQhbyJQ6jvo7GsQoLVPo7wd2YbOnjHmMT1RjxOqu7eV0EU6dOATT5J0a4nnFctF04RRWlTlHb46GAJmU5RbEAoHuii7TnNwfxFv3uyMYGtuB6gmOt5SwZ3duA+SvG+5y3COqq0IwReHC6G7LbD5cRHXRiuJP+4UGQpbf/w/GTHal1vJi+AdkyovKztEqLwyszhtFXCGcMogX7OdGu8php/gK5pN3bzfZt53ya08BWKKzW9xha5T5Vq/6sURcX+bcZck2/3wp1xdF/OTqFIJXiWvsXOELlzALhsGFb38jpyzLp1oNlhHIwBSzVTjgtl5fuRQkxBEEpepcQ51xFdR+vjaiLnhdC5ttYBH8iaH/bICs8bKACB1aapFvaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199024)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(54906003)(70206006)(70586007)(316002)(6916009)(478600001)(26005)(36860700001)(356005)(6666004)(16526019)(40480700001)(82740400003)(81166007)(41300700001)(7696005)(86362001)(2906002)(8936002)(8676002)(4326008)(66899024)(1076003)(40460700003)(2616005)(5660300002)(83380400001)(36756003)(336012)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:50.4556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cbbac6-41f1-44ee-06a9-08dba4e9873a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

The irq src id is used to route interrupts to
the corresponding handlers.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/include/ivsrcid/vpe/irqsrcs_vpe_6_1.h | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/vpe/irqsrcs_vpe_6_1.h

diff --git a/drivers/gpu/drm/amd/include/ivsrcid/vpe/irqsrcs_vpe_6_1.h b/drivers/gpu/drm/amd/include/ivsrcid/vpe/irqsrcs_vpe_6_1.h
new file mode 100644
index 000000000000..084c92ed126c
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/ivsrcid/vpe/irqsrcs_vpe_6_1.h
@@ -0,0 +1,40 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef __IRQSRCS_VPE_6_1_H__
+#define __IRQSRCS_VPE_6_1_H__
+
+#define VPE_6_1_SRCID__VPE_ATOMIC_RTN_DONE              0               // 0x0 VPE atomic*_rtn ops complete
+#define VPE_6_1_SRCID__VPE_TRAP                         1               // 0x1 Trap
+#define VPE_6_1_SRCID__VPE_SRBMWRITE                    2               // 0x2 SRBM write protection
+#define VPE_6_1_SRCID__VPE_CTXEMPTY                     3               // 0x3 Context Empty
+#define VPE_6_1_SRCID__VPE_PREEMPT                      4               // 0x4 Preemption
+#define VPE_6_1_SRCID__VPE_QUEUE_HANG                   5               // 0x5 Queue hang or Command timeout
+#define VPE_6_1_SRCID__VPE_ATOMIC_TIMEOUT               6               // 0x6 Atomic CMPSWAP loop timeout
+#define VPE_6_1_SRCID__VPE_POLL_TIMEOUT                 7               // 0x7 SRBM read poll timeout
+#define VPE_6_1_SRCID__VPE_VM_HOLE                      8               // 0x8 Address in VM hole
+#define VPE_6_1_SRCID__VPE_NACK_GEN_ERR                 9               // 0x9 MMHUB return general error (nack = 3)
+#define VPE_6_1_SRCID__VPE_NACK_PRT                     10              // 0xA MMHUB return PRT (nack = 2)
+#define VPE_6_1_SRCID__VPE_DOORBELL_INVALID             11              // 0xB Doorbell BE invalid
+#define VPE_6_1_SRCID__VPE_IB_PREEMPT                   12              // 0xC IB preemption
+
+#endif
-- 
2.41.0

