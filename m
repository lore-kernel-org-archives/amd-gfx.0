Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEC6EE49B6
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA8810E447;
	Wed, 23 Aug 2023 15:51:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA5610E443
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZq8VZiVXMCyizb68vS++nas5Yn5DN4AAMuz/FuLv5m1DppkRrAwt18Xz8HmoO39qhudizAri61NXvFfEzYEnJ8ucoAQjPmUuLGrYmFkGB9FmosAaVlV/pMaFvPMPf+Sr+/mqLiQiY5+rorWeLoZ35uw9ksA4Ya4c6fVVdvWJ7dVN50SGHcFteRtI9ppzD5adpZtSjWWJ0EWj9OW5A9kFyia7wgEHIpo9S4fc+r5USlFVn35aOMdgJcZvl8kfVyCR0i3oNSKK0GVhvPjVfJFoe04M26sKyJIbAZzovyDxbJ7HVXXNOjdG+YYWge77nQ4M5RQiwLCou0xvNcyuytaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKTWHqSauEVMNGSKyqqZklKoy15oMCQy95us93dsBhQ=;
 b=JwgRZtrJgt2SQrWDJOW9hZhoFpkD+ul7CMtu7DGqz3Rb+To/mV3JuVBAUZ0fOe+EJVsbMt4pK5Z8Hn6ZKpmF1Qo2a+tHbAZ2UoGQXuvKV884Yd0ZgB0DHSaCTO787eJk29ByqrTHiExiImPj0HN8xIm9j2T0xcEKIvEUpTCmsclXlLF3G/vdFR2Y6XzaZpZ1XzSBnOxhDbBzg6GjjzbbNmsmevQB4Br2HpiGZ+TJEiLUMvbd6TYjEWMruty8/Q549g7WAHuGfd2z9Af2oN/qcykz9mGpC1nlB3+t6MdVNRD2TG15DF9f4Jm2bw9ep+IkT4BZWRYoO4IM9bGz/43s5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKTWHqSauEVMNGSKyqqZklKoy15oMCQy95us93dsBhQ=;
 b=frmtje9MSYd/LgNr83+6qloh5wgnRh7JDiqBS59n2Hz0vVF7WEIu91opzIKETfuqbA4XKX3h+iSs7u042BBdbJ6b2D9+eRm9L1BR2wniJUavnjGX/lgA/g9+iZjV3mTaPWzuq1ubXKcm+eQUjWqHh8tbyJeFiRR7ce0/bQTzqYo=
Received: from CY5PR18CA0038.namprd18.prod.outlook.com (2603:10b6:930:13::27)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 15:51:18 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::43) by CY5PR18CA0038.outlook.office365.com
 (2603:10b6:930:13::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/35] drm/amd/display: Add DCN35 DPP
Date: Wed, 23 Aug 2023 11:50:32 -0400
Message-ID: <20230823155048.2526343-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c22be87-c31d-4c5a-95e6-08dba3f0c9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0KGdl6VxjTtB+sN3Q1E2xw9qr6WA3TPXw+1YwOLrz9LY9vSWO05dwLghrbGqxTSX22v+breQim+No0Vmvt2fFMGr1GdgaWOw/ShEydNU5aYVVWU55AQVyXO5JUB19iVU7wpvwxdMyVeRZS3ebjX/52F3BRUe6wpsHxByNEm47E7AnnJa9PffR9zC5LrzJ3KC+T9PRn8Q01pA2640EH7YMotvPjeqsM/fPP9J5MCJZTYJ0q2Oi8pqk/CMqJUc63REhSosjteWpdzicgKbBLVmwbp6wCcStCoiKbvbX7Zr2+ij7v2qRmSuJzZwnp6CVnZwGDD7ofVCz1x5SQ4rHIZVCAUXCnM+W0LGhOCzNmMJgMJsog0wP/ua/WoSX49M4BYI9YDZHmATRkAp2JVoF0nsAih+0js41WN4Jcl3kNLmIrgqoh3QW6UxdE32PrWrPV+PrOWGVkVcKaWLGXTEzSAweheuUs5Tn9hW8p/Pn+R4jOHpsDAL082ADm3HYV/EfpazN1oXhPQbcPiQyUslQrlj3IUhJt4Pe1Wu5xo4p+FZxl6znjmlmOsFkNywYYmKizXVg/K1uNZWA+k7TSV66+WtrJ02HzcZgelbQLLdZXIF/DYwI9KvD5FncVvN9N+PTE6qBelrvXGmsDEY9iFpGr6dUdPpa6EJ71ocOBMvYTYaKJ4Ab3rbaTQ4WO/ecf62hzMgrgJNeB+GiV/sltK1n96DIEc8d1fXi92qAJJrpI6Soqgc+QsEY3MCp+4otqG4gteje0PI/epnfqdYeJ1aE5kyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(41300700001)(7696005)(66899024)(36756003)(426003)(336012)(16526019)(26005)(86362001)(83380400001)(2906002)(5660300002)(1076003)(2616005)(82740400003)(356005)(81166007)(36860700001)(47076005)(40480700001)(8936002)(8676002)(4326008)(6666004)(70586007)(70206006)(54906003)(316002)(6916009)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:17.7101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c22be87-c31d-4c5a-95e6-08dba3f0c9eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Add DPP handling for DCN35.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dpp.c  | 51 +++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dpp.h  | 55 +++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.c
new file mode 100644
index 000000000000..84a9afb7098a
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.c
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: MIT */
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
+
+#include "core_types.h"
+#include "dcn35_dpp.h"
+#include "reg_helper.h"
+
+#define REG(reg) dpp->tf_regs->reg
+
+#define CTX dpp->base.ctx
+
+#undef FN
+#define FN(reg_name, field_name)                                       \
+	((const struct dcn35_dpp_shift *)(dpp->tf_shift))->field_name, \
+	((const struct dcn35_dpp_mask *)(dpp->tf_mask))->field_name
+
+bool dpp35_construct(struct dcn3_dpp *dpp, struct dc_context *ctx,
+		     uint32_t inst, const struct dcn3_dpp_registers *tf_regs,
+		     const struct dcn35_dpp_shift *tf_shift,
+		     const struct dcn35_dpp_mask *tf_mask)
+{
+	return dpp32_construct(dpp, ctx, inst, tf_regs,
+			      (const struct dcn3_dpp_shift *)(tf_shift),
+			      (const struct dcn3_dpp_mask *)(tf_mask));
+}
+
+void dpp35_set_fgcg(struct dcn3_dpp *dpp, bool enable)
+{
+	REG_UPDATE(DPP_CONTROL, DPP_FGCG_REP_DIS, !enable);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.h
new file mode 100644
index 000000000000..17f5344994f0
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: MIT */
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
+
+#ifndef __DCN35_DPP_H__
+#define __DCN35_DPP_H__
+
+#include "dcn32/dcn32_dpp.h"
+
+#define DPP_REG_LIST_SH_MASK_DCN35(mask_sh)  \
+	DPP_REG_LIST_SH_MASK_DCN30_COMMON(mask_sh), \
+		TF_SF(DPP_TOP0_DPP_CONTROL, DPP_FGCG_REP_DIS, mask_sh)
+
+#define DPP_REG_FIELD_LIST_DCN35(type)         \
+	struct {                               \
+		DPP_REG_FIELD_LIST_DCN3(type); \
+		type DPP_FGCG_REP_DIS;         \
+	}
+
+struct dcn35_dpp_shift {
+	DPP_REG_FIELD_LIST_DCN35(uint8_t);
+};
+
+struct dcn35_dpp_mask {
+	DPP_REG_FIELD_LIST_DCN35(uint32_t);
+};
+
+bool dpp35_construct(struct dcn3_dpp *dpp3, struct dc_context *ctx,
+		     uint32_t inst, const struct dcn3_dpp_registers *tf_regs,
+		     const struct dcn35_dpp_shift *tf_shift,
+		     const struct dcn35_dpp_mask *tf_mask);
+
+void dpp35_set_fgcg(struct dcn3_dpp *dpp, bool enable);
+
+#endif // __DCN35_DPP_H
-- 
2.41.0

