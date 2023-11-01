Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3BAC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 11:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 409E810E06B;
	Wed,  1 Nov 2023 11:22:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3408D10E06B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 11:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScOU07cwGZlv5vVMkrOMQtpMVQ87LUwW7Rdxw3CiEn7xmWqx+yBMi522MRfaitirFeVDQRzhXVzL5NtgCx/duPfcs3nxcxhK4/zz6B9NFpriwI42YF7aga0zZHSQ+rPeW176Q/bD3KQGLHu1UZLGQyItjq1evQNyIRkbDh5tL9XhFh6hKY9k9Dqot0/tu0Q05418NXa+l5QMVRsT0k/J8nQlXvEz7BZiWq6nPJN7f5wAu2jn4/ejjCno4irqNbE1H3k/omNR5L6S0WqifzMQqkghzCk9tS872eLqbZmdsXY93sN5XznaK2rZ1HVZ9wLcwfA/nyHDlonXHY1BvgAvlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDBR8m8YuktLbC9MYlOxIoZ+GOm7vsIRc9nHpbypJWY=;
 b=nzY0hAqAmCj04IE65yU6QyGvGvtPTSAWbPmbkD2u5PP2jZ8+cpDu2kz9+PcdrbK8EbJtFXQZjvNI4rLcK1eRNEAkIkvZM48dR7dg3rL6841xvRREuxZ/INPQyttXuOiucRMIS9eZW3UdsjjsjriFwhNQ4gCFZqwdhwidWC+e/RHgq9hCAM8RAyx61IbsKJ1jfhBk2feihmRsrTdN/kEtJSWkj2rHcL1umSOMrgtSfqR3zy/+FuQwXnM7wQ8MjuSKb3W6H/Y40b4yhUqswFzz9aCqMY5DV55x4m3L24WjcMzpVvd6PqXpbIckj3qyZ0wqtP0pmb+Lceeo3G7Wu9nhuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDBR8m8YuktLbC9MYlOxIoZ+GOm7vsIRc9nHpbypJWY=;
 b=MIIYLeXy65QViqO9m+rQmz297QS9A5tc+SYQ85Z82heprkPoNAr5EZTUx/mkIJPsxnNJwBkxjocixbCG2vyTyMiSyA+rNbFl46G2U5JYc1y9hFriEZJB+Ltne5VhO56Dh4bjzeW0sRfEM+Asd5Lx3oONZmYXQoX92FBv3Q7Duic=
Received: from MW4PR03CA0163.namprd03.prod.outlook.com (2603:10b6:303:8d::18)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 11:22:31 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::c6) by MW4PR03CA0163.outlook.office365.com
 (2603:10b6:303:8d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 11:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 11:22:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 06:22:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 06:22:30 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.32 via Frontend Transport; Wed, 1 Nov 2023 06:22:29 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Add C2PMSG_109/126 reg field shift/masks
Date: Wed, 1 Nov 2023 19:22:23 +0800
Message-ID: <20231101112225.5731-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2cdb31-2ecc-47c8-52e1-08dbdaccd6b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0MONPlixbS/2P6Ki5R9iGd1hmC2WGf/TPoPCvvPXvv9zo4GMLiGGwrYQPM5yATt5BGXk4U+blZZD8biQHWSouU7IFqy2EBrGuIlWWI7TfeejEJq2vZKYKWV2szGTmc5yNssykY5W5tfwt8aO8rkj8sW9c3F5DFVbrq3nPSB0Zhqf/W3grBksmEFsgK7v9KaXJoxJiZCRTX0v6rDUXrdsjXEkNGt86DVdyl9UzSL8tJVzNWKQPhy3kHI/k3orKtVDGsHYinib995975Khm0hEFW7bTpVxMEsDUNIHx07TgMOaSt/U2we+erhvrx8BNvxO+t7nyZfQ3asR1wORacvFQ85WgSoJXEvQjxYdM5D3QgGpbz+W3pPvSrYDgxn7hOptznhRGUpt09X74SRUboT8s44cRRUgLLVer/XqlqoUidUwDOqRWDfeK7z/ZQtfV/nsKgmBN5baPN4Ccuy8wY54Q1KBZAD3TOD0sJb1K/SLTtAKVsZIKGRYLyr5NhtExKqveBnTJltPB9BG1zUANLl0IW00X1kDAYgmGbik2OwwLF56G+vkJY4olO3/Dc/XorTnPMVIdf6FXAVOOAw7XyGlg8la3/wqX/UjLCizgAp6ZQFSXaq61gwWddMMo/7p3ELdreysu40DxQnNDVZHmkBgj3ugGxU2bGIHT/Cq4Jf8XfMAKmB4i63t9nSHh3Vo/iAQesl6RDvo6bRnNRIVz03oIS6W6fs3B4+MvFKN/+KXfaJ4LEzNVEdSF5++LRU3AoSW7Pp+HBTZIGT/VlPhRX6t4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(1076003)(2616005)(7696005)(40460700003)(26005)(81166007)(82740400003)(47076005)(356005)(36756003)(86362001)(36860700001)(336012)(426003)(8676002)(4326008)(8936002)(2906002)(5660300002)(316002)(6916009)(70586007)(40480700001)(478600001)(70206006)(6666004)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 11:22:31.1663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2cdb31-2ecc-47c8-52e1-08dbdaccd6b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add MP0_C2PMSG_109/126 register field shift/masks
that are used to identify boot status by driver.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
---
 .../include/asic_reg/mp/mp_13_0_2_sh_mask.h   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_2_sh_mask.h
index 6e29a185de51..765d9ca2316f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_2_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_2_sh_mask.h
@@ -242,6 +242,34 @@
 //MP0_SMN_C2PMSG_103
 #define MP0_SMN_C2PMSG_103__CONTENT__SHIFT                                                                    0x0
 #define MP0_SMN_C2PMSG_103__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP0_SMN_C2PMSG_109
+#define MP0_SMN_C2PMSG_109__CONTENT__SHIFT                                                                    0x0
+#define MP0_SMN_C2PMSG_109__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP0_SMN_C2PMSG_126
+#define MP0_SMN_C2PMSG_126__GPU_ERR_MEM_TRAINING__SHIFT                                                       0x0
+#define MP0_SMN_C2PMSG_126__GPU_ERR_FW_LOAD__SHIFT                                                            0x1
+#define MP0_SMN_C2PMSG_126__GPU_ERR_WAFL_LINK_TRAINING__SHIFT                                                 0x2
+#define MP0_SMN_C2PMSG_126__GPU_ERR_XGMI_LINK_TRAINING__SHIFT                                                 0x3
+#define MP0_SMN_C2PMSG_126__GPU_ERR_USR_CP_LINK_TRAINING__SHIFT                                               0x4
+#define MP0_SMN_C2PMSG_126__GPU_ERR_USR_DP_LINK_TRAINING__SHIFT                                               0x5
+#define MP0_SMN_C2PMSG_126__GPU_ERR_HBM_MEM_TEST__SHIFT                                                       0x6
+#define MP0_SMN_C2PMSG_126__GPU_ERR_HBM_BIST_TEST__SHIFT                                                      0x7
+#define MP0_SMN_C2PMSG_126__SOCKET_ID__SHIFT                                                                  0x8
+#define MP0_SMN_C2PMSG_126__AID_ID__SHIFT                                                                     0xb
+#define MP0_SMN_C2PMSG_126__HBM_ID__SHIFT                                                                     0xd
+#define MP0_SMN_C2PMSG_126__BOOT_STATUS__SHIFT                                                                0x1f
+#define MP0_SMN_C2PMSG_126__GPU_ERR_MEM_TRAINING_MASK                                                         0x00000001L
+#define MP0_SMN_C2PMSG_126__GPU_ERR_FW_LOAD_MASK                                                              0x00000002L
+#define MP0_SMN_C2PMSG_126__GPU_ERR_WAFL_LINK_TRAINING_MASK                                                   0x00000004L
+#define MP0_SMN_C2PMSG_126__GPU_ERR_XGMI_LINK_TRAINING_MASK                                                   0x00000008L
+#define MP0_SMN_C2PMSG_126__GPU_ERR_USR_CP_LINK_TRAINING_MASK                                                 0x00000010L
+#define MP0_SMN_C2PMSG_126__GPU_ERR_USR_DP_LINK_TRAINING_MASK                                                 0x00000020L
+#define MP0_SMN_C2PMSG_126__GPU_ERR_HBM_MEM_TEST_MASK                                                         0x00000040L
+#define MP0_SMN_C2PMSG_126__GPU_ERR_HBM_BIST_TEST_MASK                                                        0x00000080L
+#define MP0_SMN_C2PMSG_126__SOCKET_ID_MASK                                                                    0x00000700L
+#define MP0_SMN_C2PMSG_126__AID_ID_MASK                                                                       0x00001800L
+#define MP0_SMN_C2PMSG_126__HBM_ID_MASK                                                                       0x00002000L
+#define MP0_SMN_C2PMSG_126__BOOT_STATUS_MASK                                                                  0x80000000L
 //MP0_SMN_IH_CREDIT
 #define MP0_SMN_IH_CREDIT__CREDIT_VALUE__SHIFT                                                                0x0
 #define MP0_SMN_IH_CREDIT__CLIENT_ID__SHIFT                                                                   0x10
-- 
2.17.1

