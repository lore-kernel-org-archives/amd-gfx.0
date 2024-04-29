Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C76AC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B18D910FF19;
	Mon, 29 Apr 2024 14:34:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HKe9ov8k";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C055410E37F
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ceuly61QewSeibZwSSIE8DoB7Qzy0aoFgIXgD+vfFu03V/sqslKTmmwFsP/j9WnCbTz0WSUrZMmLIcjG5jAdoQykF29Wy0hqPYrJSgeJ/6sSmeGP1rbez+XQegfm5t7LZr3KVtVCPdoQoTtdoJT2C6nW2OJgcZDnTe9dyKZUuE9T4DEdhYgzDTDmezdjGSTSXLeQRSlu9nMFWSHxoyLI0hkmT8qQCR8kI6npVf3IpymyUc9VIUo5hFQF7vadpYO6X6QzkDmoD17UQJdKNHI4zPia2hCAsIgVPHhxPsX3grtuQf3M1NmhLx/lhwQl2z6U4zzFHKgzLbZCpZATcgaugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lHB5w8HpQByvptYynQLthUPVkYgs8uhrlM+0Glvqfg=;
 b=GOFXeS3zdAgE+6AdAiWoqgo7Ceqnj6V1nUsX+YvZuXTtDP3exhemwv7oxQEqeUAHKwiQiCGBnQWYDQLQRUvsAYVtiuS5jI28GjfclVkDZpFSGpvSuIUxp3L3iRs39JxyqHmyYwaJijGficIKeGSiilAUCgcwwb2IFloPM2GvAc+erJ3zDE7NG0B48dDcS9JyWtoldElII8Lz/VSYOag20o9rFBrSTwAcH6/gexyQ6XMBUdjORUr4RzRYgPwBd0zZtW/1i/ZTtvqbRH7s0E5Yh3483SndjaJK6JsiFyjPuuqlEsNoNEakeaT01smf8ERszgdf9Brz307E39yEEGc7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lHB5w8HpQByvptYynQLthUPVkYgs8uhrlM+0Glvqfg=;
 b=HKe9ov8kB8RkVPu6n6sWOzzF2xWAYy3sIe77x9HMqB5IR4UULjWbCX2LW8Iq0U/+O49QNr3mU5G1mz9P1J2svjojVCmQ2g1KRaNyM+yxBERRiOTh9AcsrKDTJ53jp6MOdLQdZKHYUKnj0qLMhOsHA0dd6TKo8FsBQhXhYePR15U=
Received: from SJ0PR03CA0350.namprd03.prod.outlook.com (2603:10b6:a03:39c::25)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:34:03 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::d7) by SJ0PR03CA0350.outlook.office365.com
 (2603:10b6:a03:39c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 03/31] drm/amdgpu: add gfx12 clearstate header
Date: Mon, 29 Apr 2024 10:33:11 -0400
Message-ID: <20240429143339.3450256-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: d487eb58-59fd-40b2-fb2d-08dc68596a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f3VbkU/RfUhYGdlykT1PM35xNL+GU4zVz7i34M+2lk16r1jPZc8qyhbTMWJH?=
 =?us-ascii?Q?2nQRpF8/41FflnkaraCb+3Hw++diyM5r/0y407XEySv2qfPPoZDHn1HrWMW2?=
 =?us-ascii?Q?tu1jt/8YP5FFQfOPKNE6afUFdCqXtjA3TPZI0jXJTutXApHXhDbNRT7hS5+G?=
 =?us-ascii?Q?+lZuNcACHaKdDrS7xSaJenxTWGFtNXs/BVOwqxNYFDoAxrwgFRL2kjxn3WdK?=
 =?us-ascii?Q?kzyDiDaSrb2JKWH/qnfhTmYcB4TyzRODdaiGD6KdlumbuZ2aBOysGMm1yFC4?=
 =?us-ascii?Q?dZka8MYlx/3u0bjEIu0+xaWVPu6+FlzFmTRBLDR3DjC6pFefcMNdELyCsVwQ?=
 =?us-ascii?Q?SWhiEEMLfw5qcBeaDhOIJa9zBUUYz7mRPoJozCWQQOmKegqrxJjxnRtpHz34?=
 =?us-ascii?Q?rn5hoD1qZSAgQCGcxS7NB4XvXTQy8Tkrtr+1SUOP7zPWHYLDa8ZJd0I4Hybe?=
 =?us-ascii?Q?8wLSq2P1t3E9fet7BjrJb+IiAyqWuOzUc+UOKc6IOVQ6aVYP6W2rDTtfmHR0?=
 =?us-ascii?Q?JCRqHffM88AheqaMXYMHERtSoQevR9v0Qb/iM/HQZIo1Md7vI1dwzSwtmGB5?=
 =?us-ascii?Q?nyV81FvV5wAnJhlFyqcL7dfdoZl4VZf0SnZvPwKXkzuvnSA06lWzEqrlA1Y5?=
 =?us-ascii?Q?Z6GcB9xVfp5uTu2HX5lW9Hi8xwaQ/ycBvicyj4/xXz5WxX5dBxybzrHPQGOv?=
 =?us-ascii?Q?5l3DT0CSROIlUFpkH/rRy7LFisVLfu/1X81ei+LukLqM2huDzL1Iq5U65riM?=
 =?us-ascii?Q?8AVQ1g+dodimXJwCLrknET6AFIfTaJ0LZsFcWJftknyhbXUQ8tyxPHBA9Q14?=
 =?us-ascii?Q?2vCrbCTXEfhJw/RzifJBddknSejs3y3UxpkYWX0SlLEs1GFwTzeKZJn+VAOu?=
 =?us-ascii?Q?jCeyB95Gww+LKui1vL57Dg+nlFEDeNySuzv4BSvQI2PkkON+qUbE+VNkL+gx?=
 =?us-ascii?Q?KGcp1xX9jg7lLhncrMEq0utf7i7jSlYsF5m2IgYvqnnKOT4P5Ovba2ok1zQW?=
 =?us-ascii?Q?DUoY4rzHWmR20LNR9jpDz5OGdv7aRPZ6neXlnUVA582Fvqnrk75Y6a0uid3o?=
 =?us-ascii?Q?q6B0JgtGDVrFfX+y0tPbrnzLYFtXHLHbRnI7ma+FRVwYxoS/pvnBHEfbKUgz?=
 =?us-ascii?Q?txk1lhv9MDSD0qhTTbv3Vf0PUOvqQjCkPs+ImFU49W21dNxHtiX32wTlggzp?=
 =?us-ascii?Q?F6bOI1VuPWzCBjO82vv/6F/DtawNGThUePitClv+PfSakQWVIsLWBi67AmgJ?=
 =?us-ascii?Q?4GNzDdJ+CgbSC1B2U9dycNzX2OzNfjpwdVZu1WamGCYKwu71jKUK+VBKdpzX?=
 =?us-ascii?Q?F3FFUFl7JarNi6W1P2RMguSjhTvft+2CKNQipdPl6bIfbTzVSbbewVH7qlh9?=
 =?us-ascii?Q?nVZrSenQTYHdU60zzCqiFfGgQrc1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:02.6995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d487eb58-59fd-40b2-fb2d-08dc68596a84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
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

From: Likun Gao <Likun.Gao@amd.com>

Add gfx12 clearstate register arrays.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/clearstate_gfx12.h | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/clearstate_gfx12.h

diff --git a/drivers/gpu/drm/amd/amdgpu/clearstate_gfx12.h b/drivers/gpu/drm/amd/amdgpu/clearstate_gfx12.h
new file mode 100644
index 0000000000000..2f6c9d11d5aef
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/clearstate_gfx12.h
@@ -0,0 +1,121 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+ *
+ */
+#ifndef __CLEARSTATE_GFX12_H_
+#define __CLEARSTATE_GFX12_H_
+
+static const unsigned int gfx12_SECT_CONTEXT_def_1[] = {
+0x00000000, //mmSC_MEM_TEMPORAL
+0x00000000, //mmSC_MEM_SPEC_READ
+0x00000000, //mmPA_SC_VPORT_0_TL
+0x00000000, //mmPA_SC_VPORT_0_BR
+0x00000000, //mmPA_SC_VPORT_1_TL
+0x00000000, //mmPA_SC_VPORT_1_BR
+0x00000000, //mmPA_SC_VPORT_2_TL
+0x00000000, //mmPA_SC_VPORT_2_BR
+0x00000000, //mmPA_SC_VPORT_3_TL
+0x00000000, //mmPA_SC_VPORT_3_BR
+0x00000000, //mmPA_SC_VPORT_4_TL
+0x00000000, //mmPA_SC_VPORT_4_BR
+0x00000000, //mmPA_SC_VPORT_5_TL
+0x00000000, //mmPA_SC_VPORT_5_BR
+0x00000000, //mmPA_SC_VPORT_6_TL
+0x00000000, //mmPA_SC_VPORT_6_BR
+0x00000000, //mmPA_SC_VPORT_7_TL
+0x00000000, //mmPA_SC_VPORT_7_BR
+0x00000000, //mmPA_SC_VPORT_8_TL
+0x00000000, //mmPA_SC_VPORT_8_BR
+0x00000000, //mmPA_SC_VPORT_9_TL
+0x00000000, //mmPA_SC_VPORT_9_BR
+0x00000000, //mmPA_SC_VPORT_10_TL
+0x00000000, //mmPA_SC_VPORT_10_BR
+0x00000000, //mmPA_SC_VPORT_11_TL
+0x00000000, //mmPA_SC_VPORT_11_BR
+0x00000000, //mmPA_SC_VPORT_12_TL
+0x00000000, //mmPA_SC_VPORT_12_BR
+0x00000000, //mmPA_SC_VPORT_13_TL
+0x00000000, //mmPA_SC_VPORT_13_BR
+0x00000000, //mmPA_SC_VPORT_14_TL
+0x00000000, //mmPA_SC_VPORT_14_BR
+0x00000000, //mmPA_SC_VPORT_15_TL
+0x00000000, //mmPA_SC_VPORT_15_BR
+};
+
+static const unsigned int gfx12_SECT_CONTEXT_def_2[] = {
+0x00000000, //mmPA_CL_PROG_NEAR_CLIP_Z
+0x00000000, //mmPA_RATE_CNTL
+};
+
+static const unsigned int gfx12_SECT_CONTEXT_def_3[] = {
+0x00000000, //mmCP_PERFMON_CNTX_CNTL
+};
+
+static const unsigned int gfx12_SECT_CONTEXT_def_4[] = {
+0x00000000, //mmCONTEXT_RESERVED_REG0
+0x00000000, //mmCONTEXT_RESERVED_REG1
+0x00000000, //mmPA_SC_CLIPRECT_0_EXT
+0x00000000, //mmPA_SC_CLIPRECT_1_EXT
+0x00000000, //mmPA_SC_CLIPRECT_2_EXT
+0x00000000, //mmPA_SC_CLIPRECT_3_EXT
+};
+
+static const unsigned int gfx12_SECT_CONTEXT_def_5[] = {
+0x00000000, //mmPA_SC_HIZ_INFO
+0x00000000, //mmPA_SC_HIS_INFO
+0x00000000, //mmPA_SC_HIZ_BASE
+0x00000000, //mmPA_SC_HIZ_BASE_EXT
+0x00000000, //mmPA_SC_HIZ_SIZE_XY
+0x00000000, //mmPA_SC_HIS_BASE
+0x00000000, //mmPA_SC_HIS_BASE_EXT
+0x00000000, //mmPA_SC_HIS_SIZE_XY
+0x00000000, //mmPA_SC_BINNER_OUTPUT_TIMEOUT_CNTL
+0x00000000, //mmPA_SC_BINNER_DYNAMIC_BATCH_LIMIT
+0x00000000, //mmPA_SC_HISZ_CONTROL
+};
+
+static const unsigned int gfx12_SECT_CONTEXT_def_6[] = {
+0x00000000, //mmCB_MEM0_INFO
+0x00000000, //mmCB_MEM1_INFO
+0x00000000, //mmCB_MEM2_INFO
+0x00000000, //mmCB_MEM3_INFO
+0x00000000, //mmCB_MEM4_INFO
+0x00000000, //mmCB_MEM5_INFO
+0x00000000, //mmCB_MEM6_INFO
+0x00000000, //mmCB_MEM7_INFO
+};
+
+static const struct cs_extent_def gfx12_SECT_CONTEXT_defs[] = {
+    {gfx12_SECT_CONTEXT_def_1, 0x0000a03e, 34 },
+    {gfx12_SECT_CONTEXT_def_2, 0x0000a0cc, 2 },
+    {gfx12_SECT_CONTEXT_def_3, 0x0000a0d8, 1 },
+    {gfx12_SECT_CONTEXT_def_4, 0x0000a0db, 6 },
+    {gfx12_SECT_CONTEXT_def_5, 0x0000a2e5, 11 },
+    {gfx12_SECT_CONTEXT_def_6, 0x0000a3c0, 8 },
+    { 0, 0, 0 }
+};
+
+static const struct cs_section_def gfx12_cs_data[] = {
+    { gfx12_SECT_CONTEXT_defs, SECT_CONTEXT },
+    { 0, SECT_NONE }
+};
+
+#endif /* __CLEARSTATE_GFX12_H_ */
-- 
2.44.0

