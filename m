Return-Path: <SRS0=K0ja=OR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D2EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 13:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F6460EE0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 13:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A4F6460EE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA42A6E84C;
	Mon, 27 Sep 2021 13:07:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2074.outbound.protection.outlook.com [40.107.96.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91D106E84B
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 13:07:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpDOQ7KqRdFLWKyArE1WE1FkkQdvzTON6P4zoG80KVZwVQlNSzpEuB1/YfPwPkooObkuw+OqbZsZ26u+fUJe41Nb04QvPQry26DIoR2xCXwEbU6vW5xAMgGLLIxYBfnoXzoVRTxcpNFxjRCUx+rws2PH8NuFqLjFd/JZOEvf20EGQ215po4J4VOZs9HQAb017LJethDSz5E+ygEIfhCH3W37I7rQwfPqS0YIFP0CJX/1UzVyCv/OFuf5KSZRNU87gGQ+K1E07bwGbJehsA5V6vvAbuly4h1nBT0fIi9D0xgErPjm6dkLzWV6X0mcLDj8jz4emszgmjBpgg/t+E+ZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=1Yd2llK7bz9kLK/yrIqF88LrjJdneWJEPeY+tZN3cAo=;
 b=UvwopQsOYmhhyXQTaVoo+mX9S3xRYEuE8+X8D19UF9o+uAnMYck3T+OQ67xFqa4OVvoD2KDgwioYNZVCXjnxyQTS2L7R14HIidGgVZdU/HsQZLp0fmhxP3DeFF8/oaNtO5PzH5iKbJ4em/GrkiL0r5yQqoNnQzL6Ca6YDTjZ2/+j5p2DejGUXIRb8N0VFqxLYQ7ZeblwwQEbgeZcUVYI6Imc9qLDm2lMB7bg6nrGn93suCEWxD8Lp/KpAYRtd9hs3D4jGbeAY1p6hAXkXfsOJxJEaDgjHKNfGJXsZtMrplD70yUz3ZWTqImJP17IuawI0YbLtgLevNDRh4mHo5svMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Yd2llK7bz9kLK/yrIqF88LrjJdneWJEPeY+tZN3cAo=;
 b=ayYNC5ix0j/DeQWm7DDstcsPW7Ks2LejhoEkBXCYxji1XdqpDclJ8OVpoFoBqsEb7vD1os96vHT1DoF0l9lwjE1VVxW9Z05XukM8h2iD1QRRvPBBnupIGWg0mlae44jjRsDsr5ZkdiBsX0xzOHyScHMAV1f2mmj+Go10WIYGl9U=
Received: from DM5PR06CA0031.namprd06.prod.outlook.com (2603:10b6:3:5d::17) by
 DM5PR12MB1674.namprd12.prod.outlook.com (2603:10b6:4:11::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Mon, 27 Sep 2021 13:07:23 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::e6) by DM5PR06CA0031.outlook.office365.com
 (2603:10b6:3:5d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Mon, 27 Sep 2021 13:07:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 13:07:22 +0000
Received: from ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 27 Sep
 2021 08:07:11 -0500
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add missing mp_11_0_8_sh_mask.h header
Date: Mon, 27 Sep 2021 09:07:00 -0400
Message-ID: <20210927130700.350389-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 589186c5-e684-40bc-3b90-08d981b7be7d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1674:
X-Microsoft-Antispam-PRVS: <DM5PR12MB16747BAD76CC69869020D7DCF7A79@DM5PR12MB1674.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xi+q82KkOn/oqIipI0CLlaUfsB+0W2NEVU06cVHxo838EoflYmGObF3I1WGDDcuqN2/1PR4NrvayVPlwgy+n7ciSJ17E3+YHq5Up9kyVyOBQqyjEifvqcU5aaQoROYh0w4U7NjqCKovXf7hPSDZWVJF8r03wyzSsoEkkzLh07G58EwRmAHV+zNreF5EbY8+JfG1HmzBCljY+1edosjd862A1LjUlpVbdFbdkkL1/R93xOLVM8Ee1aqQgO7PrWvdsnKcGdbd5KiDVQ3OI0ASEawfWrQNZBuwpL3UJdNUUwk+ZOjMZ1HHfTLaq+guXXTCYXQ/mYETXjk2LBzixfqR6ZJXu0Kxn/hPDz91kO378BGLq/NtvU4Id/+kyMGybDnEo3LTH9DOM1XqCU8ozORS+AARdZejQGEkFbqZzi/ltCUefv5C8llKs+//NqfsO22MT7+Rl4nj6cem6lYcTmx/QbyY4O/R7+8Xu7wqBnXCsLDdaxcrPoytr2HknZ7HKjvdHmI3+7bzqTsTtr/qCz5u5NYBlN9eRmsnxRZ842xHxJ69mkctNGS+V3fV8pHE3FIS3Mw1xUIOpyMnX/pq/dT1AoBxZB8HPP6RGNmWWWLZgCqSm9Y2Dfv71E2Kr9mJhZM44dqS/myyKgmzSvlZZi+hisAlPhAQFTPDC3ERf9vBrCnIpKxC6J8oXigtTFuJawZjqmfiQnCyCIpAtJ+vZA4a2Fy6ilxHsdVZaidoEa1Jo1/Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(186003)(36860700001)(26005)(36756003)(47076005)(6666004)(30864003)(1076003)(7696005)(16526019)(83380400001)(6916009)(426003)(4326008)(356005)(316002)(2906002)(86362001)(508600001)(70586007)(2616005)(8676002)(82310400003)(336012)(81166007)(5660300002)(8936002)(70206006)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 13:07:22.3203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 589186c5-e684-40bc-3b90-08d981b7be7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1674
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

The commit 9b716ef1501b2e62181073493dc1c7a17140bd21 added the offset
header but didn't add the masks.  This adds the masks based on what
was selected for the offsets.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 .../include/asic_reg/mp/mp_11_0_8_sh_mask.h   | 355 ++++++++++++++++++
 1 file changed, 355 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_0_8_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_0_8_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_0_8_sh_mask.h
new file mode 100644
index 000000000000..b7d3d0df3260
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_0_8_sh_mask.h
@@ -0,0 +1,355 @@
+/*
+ * Copyright (C) 2021  Advanced Micro Devices, Inc.
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
+#ifndef _mp_11_0_8_SH_MASK_HEADER
+#define _mp_11_0_8_SH_MASK_HEADER
+
+#define MP0_SMN_C2PMSG_100__CONTENT_MASK                                                                      0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_100__CONTENT__SHIFT                                                                    0x0
+#define MP0_SMN_C2PMSG_101__CONTENT_MASK                                                                      0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_101__CONTENT__SHIFT                                                                    0x0
+#define MP0_SMN_C2PMSG_102__CONTENT_MASK                                                                      0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_102__CONTENT__SHIFT                                                                    0x0
+#define MP0_SMN_C2PMSG_103__CONTENT_MASK                                                                      0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_103__CONTENT__SHIFT                                                                    0x0
+#define MP0_SMN_C2PMSG_32__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_32__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_33__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_33__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_34__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_34__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_35__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_35__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_36__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_36__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_37__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_37__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_38__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_38__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_39__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_39__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_40__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_40__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_41__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_41__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_42__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_42__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_43__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_43__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_44__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_44__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_45__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_45__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_46__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_46__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_47__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_47__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_48__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_48__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_49__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_49__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_50__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_50__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_51__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_51__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_52__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_52__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_53__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_53__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_54__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_54__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_55__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_55__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_56__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_56__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_57__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_57__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_58__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_58__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_59__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_59__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_60__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_60__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_61__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_61__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_62__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_62__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_63__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_63__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_64__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_64__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_65__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_65__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_66__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_66__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_67__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_67__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_68__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_68__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_69__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_69__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_70__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_70__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_71__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_71__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_72__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_72__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_73__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_73__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_74__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_74__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_75__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_75__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_76__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_76__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_77__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_77__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_78__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_78__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_79__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_79__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_80__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_80__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_81__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_81__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_82__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_82__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_83__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_83__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_84__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_84__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_85__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_85__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_86__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_86__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_87__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_87__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_88__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_88__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_89__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_89__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_90__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_90__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_91__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_91__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_92__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_92__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_93__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_93__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_94__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_94__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_95__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_95__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_96__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_96__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_97__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_97__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_98__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_98__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_99__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP0_SMN_C2PMSG_99__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_IH_CREDIT__CLIENT_ID_MASK                                                                     0x00FF0000L
+#define MP0_SMN_IH_CREDIT__CLIENT_ID__SHIFT                                                                   0x10
+#define MP0_SMN_IH_CREDIT__CREDIT_VALUE_MASK                                                                  0x00000003L
+#define MP0_SMN_IH_CREDIT__CREDIT_VALUE__SHIFT                                                                0x0
+#define MP0_SMN_IH_SW_INT_CTRL__INT_ACK_MASK                                                                  0x00000100L
+#define MP0_SMN_IH_SW_INT_CTRL__INT_ACK__SHIFT                                                                0x8
+#define MP0_SMN_IH_SW_INT_CTRL__INT_MASK_MASK                                                                 0x00000001L
+#define MP0_SMN_IH_SW_INT_CTRL__INT_MASK__SHIFT                                                               0x0
+#define MP0_SMN_IH_SW_INT__ID_MASK                                                                            0x000000FFL
+#define MP0_SMN_IH_SW_INT__ID__SHIFT                                                                          0x0
+#define MP0_SMN_IH_SW_INT__VALID_MASK                                                                         0x00000100L
+#define MP0_SMN_IH_SW_INT__VALID__SHIFT                                                                       0x8
+#define MP1_SMN_C2PMSG_100__CONTENT_MASK                                                                      0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_100__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_101__CONTENT_MASK                                                                      0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_101__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_102__CONTENT_MASK                                                                      0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_102__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_103__CONTENT_MASK                                                                      0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_103__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_32__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_32__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_33__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_33__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_34__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_34__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_35__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_35__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_36__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_36__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_37__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_37__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_38__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_38__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_39__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_39__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_40__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_40__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_41__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_41__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_42__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_42__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_43__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_43__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_44__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_44__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_45__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_45__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_46__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_46__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_47__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_47__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_48__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_48__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_49__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_49__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_50__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_50__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_51__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_51__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_52__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_52__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_53__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_53__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_54__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_54__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_55__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_55__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_56__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_56__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_57__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_57__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_58__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_58__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_59__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_59__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_60__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_60__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_61__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_61__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_62__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_62__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_63__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_63__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_64__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_64__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_65__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_65__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_66__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_66__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_67__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_67__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_68__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_68__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_69__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_69__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_70__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_70__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_71__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_71__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_72__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_72__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_73__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_73__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_74__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_74__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_75__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_75__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_76__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_76__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_77__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_77__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_78__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_78__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_79__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_79__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_80__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_80__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_81__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_81__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_82__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_82__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_83__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_83__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_84__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_84__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_85__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_85__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_86__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_86__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_87__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_87__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_88__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_88__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_89__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_89__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_90__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_90__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_91__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_91__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_92__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_92__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_93__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_93__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_94__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_94__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_95__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_95__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_96__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_96__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_97__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_97__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_98__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_98__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_99__CONTENT_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_C2PMSG_99__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH0__DATA_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_EXT_SCRATCH0__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH1__DATA_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_EXT_SCRATCH1__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH2__DATA_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_EXT_SCRATCH2__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH3__DATA_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_EXT_SCRATCH3__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH4__DATA_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_EXT_SCRATCH4__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH5__DATA_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_EXT_SCRATCH5__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH6__DATA_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_EXT_SCRATCH6__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH7__DATA_MASK                                                                       0xFFFFFFFFL
+#define MP1_SMN_EXT_SCRATCH7__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_FPS_CNT__COUNT_MASK                                                                           0xFFFFFFFFL
+#define MP1_SMN_FPS_CNT__COUNT__SHIFT                                                                         0x0
+#define MP1_SMN_IH_CREDIT__CLIENT_ID_MASK                                                                     0x00FF0000L
+#define MP1_SMN_IH_CREDIT__CLIENT_ID__SHIFT                                                                   0x10
+#define MP1_SMN_IH_CREDIT__CREDIT_VALUE_MASK                                                                  0x00000003L
+#define MP1_SMN_IH_CREDIT__CREDIT_VALUE__SHIFT                                                                0x0
+#define MP1_SMN_IH_SW_INT_CTRL__INT_ACK_MASK                                                                  0x00000100L
+#define MP1_SMN_IH_SW_INT_CTRL__INT_ACK__SHIFT                                                                0x8
+#define MP1_SMN_IH_SW_INT_CTRL__INT_MASK_MASK                                                                 0x00000001L
+#define MP1_SMN_IH_SW_INT_CTRL__INT_MASK__SHIFT                                                               0x0
+#define MP1_SMN_IH_SW_INT__ID_MASK                                                                            0x000000FFL
+#define MP1_SMN_IH_SW_INT__ID__SHIFT                                                                          0x0
+#define MP1_SMN_IH_SW_INT__VALID_MASK                                                                         0x00000100L
+#define MP1_SMN_IH_SW_INT__VALID__SHIFT                                                                       0x8
+
+#endif
-- 
2.31.1

