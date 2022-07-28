Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD42C04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 07:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCE8B18A757;
	Thu, 28 Jul 2022 07:05:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB2D918A5E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 07:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Np+r567jz0ZnacuAq7XMp+tWUfNhrxibn2olSscTqmgAz4YxoXZ7Inc4DA0x/0LyjYEtNEvZCggyRsYmNzd34JStOHVe9icQiFOuozWEcY0TtQNGN/SMHABBiHCsMNNruaaCG+86cfkDbuyTYewfMdEMqSyu7zzmoyAe8G7K2SKNQx9SOE+kQYpiPuNfLNLwoxeKLVDuRlS4XKXFktlTQJfzrOX5YftTGV5BxQPs1UImuIgx1h9kP1OW4LwG/cpWRglyRKarT+ZLzqAVdrv+tGIUdXp0LkYsbYuh1f47lpaSwmszhZECSCjyziMccFg9q2oDPWwLvMFF+8CJJp0+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MN9b3D5Y5TI/ycY5uswDbAwmePV/KZjjuJK2PSE49NY=;
 b=FLhJyVokM9LBlDzNqQALJyRa2at3gLNGRlw3H8pigK320q8YsnvL+jO8f+WTUJ/2hMOhoLrSF19GAhFYVZ/mJVyQkieZKGP4oB6WYPtRf3XbVwzDPLMs8ZpnHVtkpGu3Se5VpoY+/AYAi4Z+VjbUT0FbLxaLqDIe5X08oLgeiW2Mr0GNj348Xr4GhS9epNUqX+/QV/YoZzBBJTvfjVU3x6o70lmX3jG8WGvySPofGuIyuugjPL3J7oapygQTAySVJTdBveCtO7N/DCG4xfz3IMPuSMG0dX0bu4BAn5LQ+eDIusoK6oJyfILUE/kjc1T8LxAwAvMqkluY9JvSyN1hCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MN9b3D5Y5TI/ycY5uswDbAwmePV/KZjjuJK2PSE49NY=;
 b=JKjFVCpkiS+U4XT2gIRlEL9MKwT3eexKOj7j2hOiOw8c4zOi1Fa+V/Cl1/OX02XmT0+X0lGKTetkSA53FKjnrntzUsMeCUE3/81m2NrMxYcGgJebTQko4aatHLU+aQyZcuq1RpZzQRSgbo/MqWeGDOWiF1wk8+hWYey6xZrUBUM=
Received: from BN9PR03CA0712.namprd03.prod.outlook.com (2603:10b6:408:ef::27)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Thu, 28 Jul
 2022 07:05:17 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::2b) by BN9PR03CA0712.outlook.office365.com
 (2603:10b6:408:ef::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Thu, 28 Jul 2022 07:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Thu, 28 Jul 2022 07:05:17 +0000
Received: from jenkins-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 02:05:12 -0500
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu: add header files for MP 13.0.4
Date: Thu, 28 Jul 2022 15:04:17 +0800
Message-ID: <20220728070419.2485384-3-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728070419.2485384-1-Xiaojian.Du@amd.com>
References: <20220728070419.2485384-1-Xiaojian.Du@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad7d3777-111f-48da-973c-08da706786f4
X-MS-TrafficTypeDiagnostic: DS7PR12MB5909:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XkAQoiFan4GukQuwDu9mi/9KE+CKYakVD3uigRs+awZT22GEEieAf61htICTGBFvLjzPy9UcR7hNcSFKj6bZGHOt9nZIGtfv4nWGtLpSmF1iHTO6Zk6ozAE+BRWf7xG+HwQFnTqoy47JkBNNJiXyfAvxy1zWYOnkMtB1KaEplUJBbdyecvoLs00GEK9Puud6nUQCeNplGp5polr6YAWGAHy2nHmZ7Ie41SMryeqGNP50IcwBTaQjpvE1m/kVr/3y57wXF4HuHMYv0I38MOJStHUoCXow5Zu5nwx/gPvIMfVOo4UaYjDKxiD329k/2FbKTTAxiXHiXnZe+RJVoaUTyeUbXGzbxfm6gzdt0CfA5ISe7VaYic4iV6hdzl2m4RHGPe8DH7FUlqfqmYlC44mD/7+3beHBEjvrJ+EbFvlfjMa7txD6RMmI/eDtQl+c4Wbuw7rROEpbmEsi6jcnXVuD+M9yscnr5E1y4bcS58vRKwPP6FgAegLcGsQ9K16MO7V9qJmAW/oVqHtbTKNAQiXg4oKjvQz9icLgT9XggfouZiQm9GlnHrwEwbklN2jlqxWfYqstprpKT6G4q5K6K1sAjjwhQxfqQfGKuw6sgpXoRuxL7YP8g2y5vTeO0rcF1CA2NvkLvZhPASyxBKc/oXXlHSKiQp1zPjp5aJgcfjLV+EheMXB+YRctCd2+WuwHkmDZrQkoL1rWmE38achVQwvdf/4HjaJ3rSCvBbBxG1l4HYbgc2R18I03guP7D6HnFcwCXyXUKuayfIPkWg7Y6LeSAamfxjs/RC+DZKVXK1U9AITS+O6Y6xUei3c1oPDGlfWB8FwqCACbs0o5wSBv5lU2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(40470700004)(46966006)(36840700001)(54906003)(5660300002)(2616005)(356005)(16526019)(336012)(82310400005)(8936002)(4326008)(426003)(1076003)(8676002)(70206006)(40480700001)(36756003)(70586007)(26005)(478600001)(186003)(86362001)(36860700001)(82740400003)(6916009)(2906002)(316002)(7696005)(41300700001)(81166007)(83380400001)(40460700003)(30864003)(47076005)(36900700001)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 07:05:17.3684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7d3777-111f-48da-973c-08da706786f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909
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
Cc: Alexander.Deucher@amd.com, tim.huang@amd.com,
 Xiaojian Du <Xiaojian.Du@amd.com>, Yifan1.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch will add header files for MP 13.0.4.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 .../include/asic_reg/mp/mp_13_0_4_offset.h    | 402 ++++++++++++
 .../include/asic_reg/mp/mp_13_0_4_sh_mask.h   | 595 ++++++++++++++++++
 2 files changed, 997 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_4_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_4_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_4_offset.h b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_4_offset.h
new file mode 100644
index 000000000000..82312ecc0216
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_4_offset.h
@@ -0,0 +1,402 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+ *
+ */
+#ifndef _mp_13_0_4_OFFSET_HEADER
+#define _mp_13_0_4_OFFSET_HEADER
+
+
+
+// addressBlock: mp_SmuMp0_SmnDec
+// base address: 0x0
+#define regMP0_SMN_C2PMSG_32                                                                            0x0060
+#define regMP0_SMN_C2PMSG_32_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_33                                                                            0x0061
+#define regMP0_SMN_C2PMSG_33_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_34                                                                            0x0062
+#define regMP0_SMN_C2PMSG_34_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_35                                                                            0x0063
+#define regMP0_SMN_C2PMSG_35_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_36                                                                            0x0064
+#define regMP0_SMN_C2PMSG_36_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_37                                                                            0x0065
+#define regMP0_SMN_C2PMSG_37_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_38                                                                            0x0066
+#define regMP0_SMN_C2PMSG_38_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_39                                                                            0x0067
+#define regMP0_SMN_C2PMSG_39_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_40                                                                            0x0068
+#define regMP0_SMN_C2PMSG_40_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_41                                                                            0x0069
+#define regMP0_SMN_C2PMSG_41_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_42                                                                            0x006a
+#define regMP0_SMN_C2PMSG_42_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_43                                                                            0x006b
+#define regMP0_SMN_C2PMSG_43_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_44                                                                            0x006c
+#define regMP0_SMN_C2PMSG_44_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_45                                                                            0x006d
+#define regMP0_SMN_C2PMSG_45_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_46                                                                            0x006e
+#define regMP0_SMN_C2PMSG_46_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_47                                                                            0x006f
+#define regMP0_SMN_C2PMSG_47_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_48                                                                            0x0070
+#define regMP0_SMN_C2PMSG_48_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_49                                                                            0x0071
+#define regMP0_SMN_C2PMSG_49_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_50                                                                            0x0072
+#define regMP0_SMN_C2PMSG_50_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_51                                                                            0x0073
+#define regMP0_SMN_C2PMSG_51_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_52                                                                            0x0074
+#define regMP0_SMN_C2PMSG_52_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_53                                                                            0x0075
+#define regMP0_SMN_C2PMSG_53_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_54                                                                            0x0076
+#define regMP0_SMN_C2PMSG_54_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_55                                                                            0x0077
+#define regMP0_SMN_C2PMSG_55_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_56                                                                            0x0078
+#define regMP0_SMN_C2PMSG_56_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_57                                                                            0x0079
+#define regMP0_SMN_C2PMSG_57_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_58                                                                            0x007a
+#define regMP0_SMN_C2PMSG_58_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_59                                                                            0x007b
+#define regMP0_SMN_C2PMSG_59_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_60                                                                            0x007c
+#define regMP0_SMN_C2PMSG_60_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_61                                                                            0x007d
+#define regMP0_SMN_C2PMSG_61_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_62                                                                            0x007e
+#define regMP0_SMN_C2PMSG_62_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_63                                                                            0x007f
+#define regMP0_SMN_C2PMSG_63_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_64                                                                            0x0080
+#define regMP0_SMN_C2PMSG_64_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_65                                                                            0x0081
+#define regMP0_SMN_C2PMSG_65_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_66                                                                            0x0082
+#define regMP0_SMN_C2PMSG_66_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_67                                                                            0x0083
+#define regMP0_SMN_C2PMSG_67_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_68                                                                            0x0084
+#define regMP0_SMN_C2PMSG_68_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_69                                                                            0x0085
+#define regMP0_SMN_C2PMSG_69_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_70                                                                            0x0086
+#define regMP0_SMN_C2PMSG_70_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_71                                                                            0x0087
+#define regMP0_SMN_C2PMSG_71_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_72                                                                            0x0088
+#define regMP0_SMN_C2PMSG_72_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_73                                                                            0x0089
+#define regMP0_SMN_C2PMSG_73_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_74                                                                            0x008a
+#define regMP0_SMN_C2PMSG_74_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_75                                                                            0x008b
+#define regMP0_SMN_C2PMSG_75_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_76                                                                            0x008c
+#define regMP0_SMN_C2PMSG_76_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_77                                                                            0x008d
+#define regMP0_SMN_C2PMSG_77_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_78                                                                            0x008e
+#define regMP0_SMN_C2PMSG_78_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_79                                                                            0x008f
+#define regMP0_SMN_C2PMSG_79_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_80                                                                            0x0090
+#define regMP0_SMN_C2PMSG_80_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_81                                                                            0x0091
+#define regMP0_SMN_C2PMSG_81_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_82                                                                            0x0092
+#define regMP0_SMN_C2PMSG_82_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_83                                                                            0x0093
+#define regMP0_SMN_C2PMSG_83_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_84                                                                            0x0094
+#define regMP0_SMN_C2PMSG_84_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_85                                                                            0x0095
+#define regMP0_SMN_C2PMSG_85_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_86                                                                            0x0096
+#define regMP0_SMN_C2PMSG_86_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_87                                                                            0x0097
+#define regMP0_SMN_C2PMSG_87_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_88                                                                            0x0098
+#define regMP0_SMN_C2PMSG_88_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_89                                                                            0x0099
+#define regMP0_SMN_C2PMSG_89_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_90                                                                            0x009a
+#define regMP0_SMN_C2PMSG_90_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_91                                                                            0x009b
+#define regMP0_SMN_C2PMSG_91_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_92                                                                            0x009c
+#define regMP0_SMN_C2PMSG_92_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_93                                                                            0x009d
+#define regMP0_SMN_C2PMSG_93_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_94                                                                            0x009e
+#define regMP0_SMN_C2PMSG_94_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_95                                                                            0x009f
+#define regMP0_SMN_C2PMSG_95_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_96                                                                            0x00a0
+#define regMP0_SMN_C2PMSG_96_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_97                                                                            0x00a1
+#define regMP0_SMN_C2PMSG_97_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_98                                                                            0x00a2
+#define regMP0_SMN_C2PMSG_98_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_99                                                                            0x00a3
+#define regMP0_SMN_C2PMSG_99_BASE_IDX                                                                   1
+#define regMP0_SMN_C2PMSG_100                                                                           0x00a4
+#define regMP0_SMN_C2PMSG_100_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_101                                                                           0x00a5
+#define regMP0_SMN_C2PMSG_101_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_102                                                                           0x00a6
+#define regMP0_SMN_C2PMSG_102_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_103                                                                           0x00a7
+#define regMP0_SMN_C2PMSG_103_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_104                                                                           0x00a8
+#define regMP0_SMN_C2PMSG_104_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_105                                                                           0x00a9
+#define regMP0_SMN_C2PMSG_105_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_106                                                                           0x00aa
+#define regMP0_SMN_C2PMSG_106_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_107                                                                           0x00ab
+#define regMP0_SMN_C2PMSG_107_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_108                                                                           0x00ac
+#define regMP0_SMN_C2PMSG_108_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_109                                                                           0x00ad
+#define regMP0_SMN_C2PMSG_109_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_110                                                                           0x00ae
+#define regMP0_SMN_C2PMSG_110_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_111                                                                           0x00af
+#define regMP0_SMN_C2PMSG_111_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_112                                                                           0x00b0
+#define regMP0_SMN_C2PMSG_112_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_113                                                                           0x00b1
+#define regMP0_SMN_C2PMSG_113_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_114                                                                           0x00b2
+#define regMP0_SMN_C2PMSG_114_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_115                                                                           0x00b3
+#define regMP0_SMN_C2PMSG_115_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_116                                                                           0x00b4
+#define regMP0_SMN_C2PMSG_116_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_117                                                                           0x00b5
+#define regMP0_SMN_C2PMSG_117_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_118                                                                           0x00b6
+#define regMP0_SMN_C2PMSG_118_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_119                                                                           0x00b7
+#define regMP0_SMN_C2PMSG_119_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_120                                                                           0x00b8
+#define regMP0_SMN_C2PMSG_120_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_121                                                                           0x00b9
+#define regMP0_SMN_C2PMSG_121_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_122                                                                           0x00ba
+#define regMP0_SMN_C2PMSG_122_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_123                                                                           0x00bb
+#define regMP0_SMN_C2PMSG_123_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_124                                                                           0x00bc
+#define regMP0_SMN_C2PMSG_124_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_125                                                                           0x00bd
+#define regMP0_SMN_C2PMSG_125_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_126                                                                           0x00be
+#define regMP0_SMN_C2PMSG_126_BASE_IDX                                                                  1
+#define regMP0_SMN_C2PMSG_127                                                                           0x00bf
+#define regMP0_SMN_C2PMSG_127_BASE_IDX                                                                  1
+#define regMP0_SMN_IH_CREDIT                                                                            0x00c1
+#define regMP0_SMN_IH_CREDIT_BASE_IDX                                                                   1
+#define regMP0_SMN_IH_SW_INT                                                                            0x00c2
+#define regMP0_SMN_IH_SW_INT_BASE_IDX                                                                   1
+#define regMP0_SMN_IH_SW_INT_CTRL                                                                       0x00c3
+#define regMP0_SMN_IH_SW_INT_CTRL_BASE_IDX                                                              1
+
+// addressBlock: mp_SmuMp1_SmnDec
+// base address: 0x0
+#define regMP1_SMN_C2PMSG_32                                                                            0x0260
+#define regMP1_SMN_C2PMSG_32_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_33                                                                            0x0261
+#define regMP1_SMN_C2PMSG_33_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_34                                                                            0x0262
+#define regMP1_SMN_C2PMSG_34_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_35                                                                            0x0263
+#define regMP1_SMN_C2PMSG_35_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_36                                                                            0x0264
+#define regMP1_SMN_C2PMSG_36_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_37                                                                            0x0265
+#define regMP1_SMN_C2PMSG_37_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_38                                                                            0x0266
+#define regMP1_SMN_C2PMSG_38_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_39                                                                            0x0267
+#define regMP1_SMN_C2PMSG_39_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_40                                                                            0x0268
+#define regMP1_SMN_C2PMSG_40_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_41                                                                            0x0269
+#define regMP1_SMN_C2PMSG_41_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_42                                                                            0x026a
+#define regMP1_SMN_C2PMSG_42_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_43                                                                            0x026b
+#define regMP1_SMN_C2PMSG_43_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_44                                                                            0x026c
+#define regMP1_SMN_C2PMSG_44_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_45                                                                            0x026d
+#define regMP1_SMN_C2PMSG_45_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_46                                                                            0x026e
+#define regMP1_SMN_C2PMSG_46_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_47                                                                            0x026f
+#define regMP1_SMN_C2PMSG_47_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_48                                                                            0x0270
+#define regMP1_SMN_C2PMSG_48_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_49                                                                            0x0271
+#define regMP1_SMN_C2PMSG_49_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_50                                                                            0x0272
+#define regMP1_SMN_C2PMSG_50_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_51                                                                            0x0273
+#define regMP1_SMN_C2PMSG_51_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_52                                                                            0x0274
+#define regMP1_SMN_C2PMSG_52_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_53                                                                            0x0275
+#define regMP1_SMN_C2PMSG_53_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_54                                                                            0x0276
+#define regMP1_SMN_C2PMSG_54_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_55                                                                            0x0277
+#define regMP1_SMN_C2PMSG_55_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_56                                                                            0x0278
+#define regMP1_SMN_C2PMSG_56_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_57                                                                            0x0279
+#define regMP1_SMN_C2PMSG_57_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_58                                                                            0x027a
+#define regMP1_SMN_C2PMSG_58_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_59                                                                            0x027b
+#define regMP1_SMN_C2PMSG_59_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_60                                                                            0x027c
+#define regMP1_SMN_C2PMSG_60_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_61                                                                            0x027d
+#define regMP1_SMN_C2PMSG_61_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_62                                                                            0x027e
+#define regMP1_SMN_C2PMSG_62_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_63                                                                            0x027f
+#define regMP1_SMN_C2PMSG_63_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_64                                                                            0x0280
+#define regMP1_SMN_C2PMSG_64_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_65                                                                            0x0281
+#define regMP1_SMN_C2PMSG_65_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_66                                                                            0x0282
+#define regMP1_SMN_C2PMSG_66_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_67                                                                            0x0283
+#define regMP1_SMN_C2PMSG_67_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_68                                                                            0x0284
+#define regMP1_SMN_C2PMSG_68_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_69                                                                            0x0285
+#define regMP1_SMN_C2PMSG_69_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_70                                                                            0x0286
+#define regMP1_SMN_C2PMSG_70_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_71                                                                            0x0287
+#define regMP1_SMN_C2PMSG_71_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_72                                                                            0x0288
+#define regMP1_SMN_C2PMSG_72_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_73                                                                            0x0289
+#define regMP1_SMN_C2PMSG_73_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_74                                                                            0x028a
+#define regMP1_SMN_C2PMSG_74_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_75                                                                            0x028b
+#define regMP1_SMN_C2PMSG_75_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_76                                                                            0x028c
+#define regMP1_SMN_C2PMSG_76_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_77                                                                            0x028d
+#define regMP1_SMN_C2PMSG_77_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_78                                                                            0x028e
+#define regMP1_SMN_C2PMSG_78_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_79                                                                            0x028f
+#define regMP1_SMN_C2PMSG_79_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_80                                                                            0x0290
+#define regMP1_SMN_C2PMSG_80_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_81                                                                            0x0291
+#define regMP1_SMN_C2PMSG_81_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_82                                                                            0x0292
+#define regMP1_SMN_C2PMSG_82_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_83                                                                            0x0293
+#define regMP1_SMN_C2PMSG_83_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_84                                                                            0x0294
+#define regMP1_SMN_C2PMSG_84_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_85                                                                            0x0295
+#define regMP1_SMN_C2PMSG_85_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_86                                                                            0x0296
+#define regMP1_SMN_C2PMSG_86_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_87                                                                            0x0297
+#define regMP1_SMN_C2PMSG_87_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_88                                                                            0x0298
+#define regMP1_SMN_C2PMSG_88_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_89                                                                            0x0299
+#define regMP1_SMN_C2PMSG_89_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_90                                                                            0x029a
+#define regMP1_SMN_C2PMSG_90_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_91                                                                            0x029b
+#define regMP1_SMN_C2PMSG_91_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_92                                                                            0x029c
+#define regMP1_SMN_C2PMSG_92_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_93                                                                            0x029d
+#define regMP1_SMN_C2PMSG_93_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_94                                                                            0x029e
+#define regMP1_SMN_C2PMSG_94_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_95                                                                            0x029f
+#define regMP1_SMN_C2PMSG_95_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_96                                                                            0x02a0
+#define regMP1_SMN_C2PMSG_96_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_97                                                                            0x02a1
+#define regMP1_SMN_C2PMSG_97_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_98                                                                            0x02a2
+#define regMP1_SMN_C2PMSG_98_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_99                                                                            0x02a3
+#define regMP1_SMN_C2PMSG_99_BASE_IDX                                                                   1
+#define regMP1_SMN_C2PMSG_100                                                                           0x02a4
+#define regMP1_SMN_C2PMSG_100_BASE_IDX                                                                  1
+#define regMP1_SMN_C2PMSG_101                                                                           0x02a5
+#define regMP1_SMN_C2PMSG_101_BASE_IDX                                                                  1
+#define regMP1_SMN_C2PMSG_102                                                                           0x02a6
+#define regMP1_SMN_C2PMSG_102_BASE_IDX                                                                  1
+#define regMP1_SMN_C2PMSG_103                                                                           0x02a7
+#define regMP1_SMN_C2PMSG_103_BASE_IDX                                                                  1
+#define regMP1_SMN_IH_CREDIT                                                                            0x02c1
+#define regMP1_SMN_IH_CREDIT_BASE_IDX                                                                   1
+#define regMP1_SMN_IH_SW_INT                                                                            0x02c2
+#define regMP1_SMN_IH_SW_INT_BASE_IDX                                                                   1
+#define regMP1_SMN_IH_SW_INT_CTRL                                                                       0x02c3
+#define regMP1_SMN_IH_SW_INT_CTRL_BASE_IDX                                                              1
+#define regMP1_SMN_FPS_CNT                                                                              0x02c4
+#define regMP1_SMN_FPS_CNT_BASE_IDX                                                                     1
+#define regMP1_SMN_EXT_SCRATCH0                                                                         0x0340
+#define regMP1_SMN_EXT_SCRATCH0_BASE_IDX                                                                1
+#define regMP1_SMN_EXT_SCRATCH1                                                                         0x0341
+#define regMP1_SMN_EXT_SCRATCH1_BASE_IDX                                                                1
+#define regMP1_SMN_EXT_SCRATCH2                                                                         0x0342
+#define regMP1_SMN_EXT_SCRATCH2_BASE_IDX                                                                1
+#define regMP1_SMN_EXT_SCRATCH3                                                                         0x0343
+#define regMP1_SMN_EXT_SCRATCH3_BASE_IDX                                                                1
+#define regMP1_SMN_EXT_SCRATCH4                                                                         0x0344
+#define regMP1_SMN_EXT_SCRATCH4_BASE_IDX                                                                1
+#define regMP1_SMN_EXT_SCRATCH5                                                                         0x0345
+#define regMP1_SMN_EXT_SCRATCH5_BASE_IDX                                                                1
+#define regMP1_SMN_EXT_SCRATCH6                                                                         0x0346
+#define regMP1_SMN_EXT_SCRATCH6_BASE_IDX                                                                1
+#define regMP1_SMN_EXT_SCRATCH7                                                                         0x0347
+#define regMP1_SMN_EXT_SCRATCH7_BASE_IDX                                                                1
+
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_4_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_4_sh_mask.h
new file mode 100644
index 000000000000..b0153b335951
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_4_sh_mask.h
@@ -0,0 +1,595 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+ *
+ */
+#ifndef _mp_13_0_4_SH_MASK_HEADER
+#define _mp_13_0_4_SH_MASK_HEADER
+
+
+// addressBlock: mp_SmuMp0_SmnDec
+//MP0_SMN_C2PMSG_32
+#define MP0_SMN_C2PMSG_32__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_32__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_33
+#define MP0_SMN_C2PMSG_33__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_33__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_34
+#define MP0_SMN_C2PMSG_34__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_34__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_35
+#define MP0_SMN_C2PMSG_35__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_35__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_36
+#define MP0_SMN_C2PMSG_36__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_36__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_37
+#define MP0_SMN_C2PMSG_37__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_37__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_38
+#define MP0_SMN_C2PMSG_38__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_38__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_39
+#define MP0_SMN_C2PMSG_39__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_39__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_40
+#define MP0_SMN_C2PMSG_40__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_40__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_41
+#define MP0_SMN_C2PMSG_41__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_41__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_42
+#define MP0_SMN_C2PMSG_42__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_42__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_43
+#define MP0_SMN_C2PMSG_43__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_43__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_44
+#define MP0_SMN_C2PMSG_44__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_44__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_45
+#define MP0_SMN_C2PMSG_45__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_45__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_46
+#define MP0_SMN_C2PMSG_46__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_46__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_47
+#define MP0_SMN_C2PMSG_47__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_47__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_48
+#define MP0_SMN_C2PMSG_48__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_48__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_49
+#define MP0_SMN_C2PMSG_49__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_49__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_50
+#define MP0_SMN_C2PMSG_50__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_50__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_51
+#define MP0_SMN_C2PMSG_51__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_51__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_52
+#define MP0_SMN_C2PMSG_52__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_52__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_53
+#define MP0_SMN_C2PMSG_53__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_53__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_54
+#define MP0_SMN_C2PMSG_54__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_54__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_55
+#define MP0_SMN_C2PMSG_55__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_55__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_56
+#define MP0_SMN_C2PMSG_56__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_56__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_57
+#define MP0_SMN_C2PMSG_57__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_57__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_58
+#define MP0_SMN_C2PMSG_58__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_58__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_59
+#define MP0_SMN_C2PMSG_59__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_59__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_60
+#define MP0_SMN_C2PMSG_60__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_60__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_61
+#define MP0_SMN_C2PMSG_61__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_61__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_62
+#define MP0_SMN_C2PMSG_62__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_62__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_63
+#define MP0_SMN_C2PMSG_63__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_63__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_64
+#define MP0_SMN_C2PMSG_64__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_64__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_65
+#define MP0_SMN_C2PMSG_65__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_65__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_66
+#define MP0_SMN_C2PMSG_66__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_66__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_67
+#define MP0_SMN_C2PMSG_67__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_67__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_68
+#define MP0_SMN_C2PMSG_68__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_68__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_69
+#define MP0_SMN_C2PMSG_69__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_69__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_70
+#define MP0_SMN_C2PMSG_70__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_70__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_71
+#define MP0_SMN_C2PMSG_71__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_71__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_72
+#define MP0_SMN_C2PMSG_72__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_72__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_73
+#define MP0_SMN_C2PMSG_73__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_73__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_74
+#define MP0_SMN_C2PMSG_74__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_74__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_75
+#define MP0_SMN_C2PMSG_75__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_75__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_76
+#define MP0_SMN_C2PMSG_76__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_76__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_77
+#define MP0_SMN_C2PMSG_77__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_77__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_78
+#define MP0_SMN_C2PMSG_78__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_78__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_79
+#define MP0_SMN_C2PMSG_79__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_79__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_80
+#define MP0_SMN_C2PMSG_80__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_80__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_81
+#define MP0_SMN_C2PMSG_81__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_81__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_82
+#define MP0_SMN_C2PMSG_82__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_82__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_83
+#define MP0_SMN_C2PMSG_83__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_83__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_84
+#define MP0_SMN_C2PMSG_84__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_84__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_85
+#define MP0_SMN_C2PMSG_85__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_85__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_86
+#define MP0_SMN_C2PMSG_86__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_86__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_87
+#define MP0_SMN_C2PMSG_87__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_87__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_88
+#define MP0_SMN_C2PMSG_88__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_88__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_89
+#define MP0_SMN_C2PMSG_89__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_89__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_90
+#define MP0_SMN_C2PMSG_90__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_90__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_91
+#define MP0_SMN_C2PMSG_91__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_91__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_92
+#define MP0_SMN_C2PMSG_92__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_92__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_93
+#define MP0_SMN_C2PMSG_93__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_93__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_94
+#define MP0_SMN_C2PMSG_94__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_94__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_95
+#define MP0_SMN_C2PMSG_95__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_95__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_96
+#define MP0_SMN_C2PMSG_96__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_96__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_97
+#define MP0_SMN_C2PMSG_97__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_97__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_98
+#define MP0_SMN_C2PMSG_98__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_98__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_99
+#define MP0_SMN_C2PMSG_99__CONTENT__SHIFT                                                                     0x0
+#define MP0_SMN_C2PMSG_99__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP0_SMN_C2PMSG_100
+#define MP0_SMN_C2PMSG_100__CONTENT__SHIFT                                                                    0x0
+#define MP0_SMN_C2PMSG_100__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP0_SMN_C2PMSG_101
+#define MP0_SMN_C2PMSG_101__CONTENT__SHIFT                                                                    0x0
+#define MP0_SMN_C2PMSG_101__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP0_SMN_C2PMSG_102
+#define MP0_SMN_C2PMSG_102__CONTENT__SHIFT                                                                    0x0
+#define MP0_SMN_C2PMSG_102__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP0_SMN_C2PMSG_103
+#define MP0_SMN_C2PMSG_103__CONTENT__SHIFT                                                                    0x0
+#define MP0_SMN_C2PMSG_103__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP0_SMN_IH_CREDIT
+#define MP0_SMN_IH_CREDIT__CREDIT_VALUE__SHIFT                                                                0x0
+#define MP0_SMN_IH_CREDIT__CLIENT_ID__SHIFT                                                                   0x10
+#define MP0_SMN_IH_CREDIT__CREDIT_VALUE_MASK                                                                  0x00000003L
+#define MP0_SMN_IH_CREDIT__CLIENT_ID_MASK                                                                     0x00FF0000L
+//MP0_SMN_IH_SW_INT
+#define MP0_SMN_IH_SW_INT__ID__SHIFT                                                                          0x0
+#define MP0_SMN_IH_SW_INT__VALID__SHIFT                                                                       0x8
+#define MP0_SMN_IH_SW_INT__ID_MASK                                                                            0x000000FFL
+#define MP0_SMN_IH_SW_INT__VALID_MASK                                                                         0x00000100L
+//MP0_SMN_IH_SW_INT_CTRL
+#define MP0_SMN_IH_SW_INT_CTRL__INT_MASK__SHIFT                                                               0x0
+#define MP0_SMN_IH_SW_INT_CTRL__INT_ACK__SHIFT                                                                0x8
+#define MP0_SMN_IH_SW_INT_CTRL__INT_MASK_MASK                                                                 0x00000001L
+#define MP0_SMN_IH_SW_INT_CTRL__INT_ACK_MASK                                                                  0x00000100L
+
+
+// addressBlock: mp_SmuMp1_SmnDec
+//MP1_SMN_C2PMSG_32
+#define MP1_SMN_C2PMSG_32__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_32__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_33
+#define MP1_SMN_C2PMSG_33__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_33__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_34
+#define MP1_SMN_C2PMSG_34__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_34__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_35
+#define MP1_SMN_C2PMSG_35__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_35__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_36
+#define MP1_SMN_C2PMSG_36__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_36__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_37
+#define MP1_SMN_C2PMSG_37__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_37__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_38
+#define MP1_SMN_C2PMSG_38__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_38__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_39
+#define MP1_SMN_C2PMSG_39__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_39__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_40
+#define MP1_SMN_C2PMSG_40__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_40__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_41
+#define MP1_SMN_C2PMSG_41__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_41__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_42
+#define MP1_SMN_C2PMSG_42__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_42__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_43
+#define MP1_SMN_C2PMSG_43__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_43__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_44
+#define MP1_SMN_C2PMSG_44__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_44__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_45
+#define MP1_SMN_C2PMSG_45__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_45__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_46
+#define MP1_SMN_C2PMSG_46__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_46__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_47
+#define MP1_SMN_C2PMSG_47__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_47__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_48
+#define MP1_SMN_C2PMSG_48__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_48__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_49
+#define MP1_SMN_C2PMSG_49__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_49__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_50
+#define MP1_SMN_C2PMSG_50__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_50__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_51
+#define MP1_SMN_C2PMSG_51__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_51__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_52
+#define MP1_SMN_C2PMSG_52__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_52__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_53
+#define MP1_SMN_C2PMSG_53__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_53__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_54
+#define MP1_SMN_C2PMSG_54__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_54__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_55
+#define MP1_SMN_C2PMSG_55__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_55__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_56
+#define MP1_SMN_C2PMSG_56__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_56__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_57
+#define MP1_SMN_C2PMSG_57__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_57__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_58
+#define MP1_SMN_C2PMSG_58__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_58__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_59
+#define MP1_SMN_C2PMSG_59__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_59__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_60
+#define MP1_SMN_C2PMSG_60__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_60__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_61
+#define MP1_SMN_C2PMSG_61__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_61__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_62
+#define MP1_SMN_C2PMSG_62__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_62__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_63
+#define MP1_SMN_C2PMSG_63__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_63__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_64
+#define MP1_SMN_C2PMSG_64__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_64__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_65
+#define MP1_SMN_C2PMSG_65__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_65__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_66
+#define MP1_SMN_C2PMSG_66__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_66__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_67
+#define MP1_SMN_C2PMSG_67__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_67__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_68
+#define MP1_SMN_C2PMSG_68__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_68__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_69
+#define MP1_SMN_C2PMSG_69__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_69__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_70
+#define MP1_SMN_C2PMSG_70__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_70__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_71
+#define MP1_SMN_C2PMSG_71__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_71__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_72
+#define MP1_SMN_C2PMSG_72__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_72__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_73
+#define MP1_SMN_C2PMSG_73__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_73__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_74
+#define MP1_SMN_C2PMSG_74__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_74__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_75
+#define MP1_SMN_C2PMSG_75__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_75__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_76
+#define MP1_SMN_C2PMSG_76__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_76__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_77
+#define MP1_SMN_C2PMSG_77__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_77__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_78
+#define MP1_SMN_C2PMSG_78__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_78__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_79
+#define MP1_SMN_C2PMSG_79__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_79__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_80
+#define MP1_SMN_C2PMSG_80__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_80__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_81
+#define MP1_SMN_C2PMSG_81__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_81__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_82
+#define MP1_SMN_C2PMSG_82__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_82__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_83
+#define MP1_SMN_C2PMSG_83__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_83__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_84
+#define MP1_SMN_C2PMSG_84__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_84__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_85
+#define MP1_SMN_C2PMSG_85__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_85__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_86
+#define MP1_SMN_C2PMSG_86__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_86__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_87
+#define MP1_SMN_C2PMSG_87__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_87__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_88
+#define MP1_SMN_C2PMSG_88__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_88__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_89
+#define MP1_SMN_C2PMSG_89__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_89__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_90
+#define MP1_SMN_C2PMSG_90__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_90__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_91
+#define MP1_SMN_C2PMSG_91__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_91__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_92
+#define MP1_SMN_C2PMSG_92__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_92__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_93
+#define MP1_SMN_C2PMSG_93__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_93__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_94
+#define MP1_SMN_C2PMSG_94__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_94__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_95
+#define MP1_SMN_C2PMSG_95__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_95__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_96
+#define MP1_SMN_C2PMSG_96__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_96__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_97
+#define MP1_SMN_C2PMSG_97__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_97__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_98
+#define MP1_SMN_C2PMSG_98__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_98__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_99
+#define MP1_SMN_C2PMSG_99__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_99__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_100
+#define MP1_SMN_C2PMSG_100__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_100__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_101
+#define MP1_SMN_C2PMSG_101__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_101__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_102
+#define MP1_SMN_C2PMSG_102__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_102__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_103
+#define MP1_SMN_C2PMSG_103__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_103__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_104
+#define MP1_SMN_C2PMSG_104__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_104__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_105
+#define MP1_SMN_C2PMSG_105__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_105__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_106
+#define MP1_SMN_C2PMSG_106__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_106__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_107
+#define MP1_SMN_C2PMSG_107__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_107__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_108
+#define MP1_SMN_C2PMSG_108__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_108__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_109
+#define MP1_SMN_C2PMSG_109__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_109__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_110
+#define MP1_SMN_C2PMSG_110__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_110__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_111
+#define MP1_SMN_C2PMSG_111__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_111__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_112
+#define MP1_SMN_C2PMSG_112__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_112__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_113
+#define MP1_SMN_C2PMSG_113__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_113__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_114
+#define MP1_SMN_C2PMSG_114__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_114__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_115
+#define MP1_SMN_C2PMSG_115__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_115__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_116
+#define MP1_SMN_C2PMSG_116__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_116__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_117
+#define MP1_SMN_C2PMSG_117__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_117__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_118
+#define MP1_SMN_C2PMSG_118__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_118__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_119
+#define MP1_SMN_C2PMSG_119__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_119__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_120
+#define MP1_SMN_C2PMSG_120__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_120__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_121
+#define MP1_SMN_C2PMSG_121__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_121__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_122
+#define MP1_SMN_C2PMSG_122__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_122__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_123
+#define MP1_SMN_C2PMSG_123__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_123__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_124
+#define MP1_SMN_C2PMSG_124__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_124__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_125
+#define MP1_SMN_C2PMSG_125__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_125__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_126
+#define MP1_SMN_C2PMSG_126__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_126__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_127
+#define MP1_SMN_C2PMSG_127__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_127__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_IH_CREDIT
+#define MP1_SMN_IH_CREDIT__CREDIT_VALUE__SHIFT                                                                0x0
+#define MP1_SMN_IH_CREDIT__CLIENT_ID__SHIFT                                                                   0x10
+#define MP1_SMN_IH_CREDIT__CREDIT_VALUE_MASK                                                                  0x00000003L
+#define MP1_SMN_IH_CREDIT__CLIENT_ID_MASK                                                                     0x00FF0000L
+//MP1_SMN_IH_SW_INT
+#define MP1_SMN_IH_SW_INT__ID__SHIFT                                                                          0x0
+#define MP1_SMN_IH_SW_INT__VALID__SHIFT                                                                       0x8
+#define MP1_SMN_IH_SW_INT__ID_MASK                                                                            0x000000FFL
+#define MP1_SMN_IH_SW_INT__VALID_MASK                                                                         0x00000100L
+//MP1_SMN_IH_SW_INT_CTRL
+#define MP1_SMN_IH_SW_INT_CTRL__INT_MASK__SHIFT                                                               0x0
+#define MP1_SMN_IH_SW_INT_CTRL__INT_ACK__SHIFT                                                                0x8
+#define MP1_SMN_IH_SW_INT_CTRL__INT_MASK_MASK                                                                 0x00000001L
+#define MP1_SMN_IH_SW_INT_CTRL__INT_ACK_MASK                                                                  0x00000100L
+//MP1_SMN_FPS_CNT
+#define MP1_SMN_FPS_CNT__COUNT__SHIFT                                                                         0x0
+#define MP1_SMN_FPS_CNT__COUNT_MASK                                                                           0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH0
+#define MP1_SMN_EXT_SCRATCH0__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH0__DATA_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH1
+#define MP1_SMN_EXT_SCRATCH1__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH1__DATA_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH2
+#define MP1_SMN_EXT_SCRATCH2__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH2__DATA_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH3
+#define MP1_SMN_EXT_SCRATCH3__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH3__DATA_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH4
+#define MP1_SMN_EXT_SCRATCH4__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH4__DATA_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH5
+#define MP1_SMN_EXT_SCRATCH5__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH5__DATA_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH6
+#define MP1_SMN_EXT_SCRATCH6__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH6__DATA_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH7
+#define MP1_SMN_EXT_SCRATCH7__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH7__DATA_MASK                                                                       0xFFFFFFFFL
+
+
+#endif
-- 
2.25.1

