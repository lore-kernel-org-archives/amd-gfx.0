Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF22CC19F2D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 04:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8632A113B;
	Thu, 11 Aug 2022 04:59:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E7E3A1120
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 04:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJ9wemRptQXq6adOpoThluAquC5WA0kBBgt4Ols4yjxC2LQzxd6Aet2dc48sjrMZQjv32XUXeJBZ+H1IA5oE9Vt/vhcs4f9XzChUUjD1wLDB1n4Zz7U7uaFtGxYWgDZQc5g187Lgg/TZ9OTtcpHAwNgDqol74TmJ24SjVJKvsEQEgz49t9VN018p0BIneCKngL/T67Nfo4X0xchILE4LAE7wOQY/kTZL2KBQUlyp60f0z1RxGLI2VS8n3ZhRdhb1Tmuw+nENM+Dd5j4dVDSHQ/7EORNxhbdY/o8uAaF2Q3N7yvcCZ2ysZL4GOlffNMSB1oA0hMbG95ZETLAIW2Yh7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=verDi9XOSKc94exYVseR9GNrBKJIo45cBPIV2cR8zy8=;
 b=RXn+wkEpCnsPX928EGVe5bkTngrpBgH+fpe70ZQpKgbzPz64H8RL/3d7Qt+ySi19QNAeq7wdAJT/Vy6cbEzAuQ9Z5N0h4Z8Ju5FyvNETrV1qke1a+XqnRjSpFTbt94lYMBW7kYQbf5ThZ4oyFEeZ8OEl3FoAHmi04Kf70V7fBdmr2TQw+N75t72S/5Lo9PYAajO0Ayki10g32KsiABzqRHxpEA+sVoxDR5cvIU5aj5Kr37wtdSIM9KKgqErBFIuUzUWlAxFy23oc7dCpXjTYtBMJqvP6UPb05isZMQlX6twHhDk/vsfDkL7AdQqs7z231L9sz8zBOS0OmwtvJeSTpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=verDi9XOSKc94exYVseR9GNrBKJIo45cBPIV2cR8zy8=;
 b=oxtDdAef/IC8LwXrfyTFkATIBEjw8KIL7ZUMiFZkPI57cpXtiOgtU49YkBCRL/59224KCPqqZtRxxwFhGlTCtJS6Bz9k2PLD/hHO94y5hUJGIQox5y80D/Gur7Eh0EnpO6shnlXykRmSd9NQ90Qf4TkLPmjbiWXMuUGUC5R4qTk=
Received: from MW4PR03CA0354.namprd03.prod.outlook.com (2603:10b6:303:dc::29)
 by BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Thu, 11 Aug
 2022 04:58:48 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::52) by MW4PR03CA0354.outlook.office365.com
 (2603:10b6:303:dc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Thu, 11 Aug 2022 04:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 04:58:47 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 10 Aug
 2022 23:58:45 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amdgpu: enable MMHUB IP v3.0.1 Clock Gating
Date: Thu, 11 Aug 2022 12:58:02 +0800
Message-ID: <20220811045804.3750344-5-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811045804.3750344-1-tim.huang@amd.com>
References: <20220811045804.3750344-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07128701-b677-4632-1924-08da7b562d16
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0W7GUH3kguKqXKdXSxP0QXCDdXSkbuO4MakFv9RKxIZ5L+4ahr8uzIbFXYQD5tjTaObPHodVlQLY8l8pIA1zBNtpMAtLhBXOa9AHHm4gc5a73l39EVCwvtWDBLc5l6WqQG3xWSsGed5YIq/qf0df2dzGLz8mZUNZ8ZNsbJI8MnfFZQVfOcMNQtL8zZRci7goLbCKAvjgsMB8l65iuoyMJU8jodqHQLtk/KjmMop5xTq6nO6O/qplEo3PVHlfL8QsZ9wIskf4zaRmvz6bt/q2bnCM8rMMFDKVMcvxNoE0a0X4hwOZbQmRrdLA4O8buwXo8pnpuLm9Abr4geY2qpO0p8LDgdZXtFqgZykENR3hbf7g503izXdMAjz8R+XXO8uJYoOc3z6iE5BYN23WFrWQbLFaBkhXin3L9+JGSEYbkUgAQEGnoSsD/RQZwMHmxXg2UXAopfN+IMcD5XnjI8mh8kEZwqhcq/LbNhYM9Ic7u1fVhWnqL3xev2zTyNy67oLVIU5TnqMeBK2XdRI9JMKSgGAt7wuur4L/XjuuM8p0O1CvKYxpqxC+jF7z3Z4YZcAHBTuPYfG5Q7441dEpSAfwUCDacREJrey5snJ25KD977KzxBsl4sMU05jhskFdsZBSdDWnUAsC8kYBDbV11e2KTbFwuU/X1NlvPeaURCDgnm22e+MHHZnK/vuAR55obQC63DeJC6pw0npsJfh3QGM3UC3xd4go5cGarvGjaPHizx7k7Nr4P1WOi7G1qArJn5NaymQbVH30YmyboMpqY1aMIQE7Al6tJ6XD6H07Iz41NYwtD008vNVH9VFM49UGxH1ZjFU9S/fCccCG/vzHhad0Rg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966006)(40470700004)(36840700001)(4326008)(6916009)(356005)(8936002)(4744005)(81166007)(70586007)(70206006)(316002)(82740400003)(36756003)(54906003)(47076005)(5660300002)(44832011)(8676002)(36860700001)(40480700001)(426003)(82310400005)(16526019)(186003)(26005)(478600001)(6666004)(86362001)(1076003)(40460700003)(2616005)(2906002)(7696005)(41300700001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 04:58:47.8298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07128701-b677-4632-1924-08da7b562d16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2743
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable AMD_CG_SUPPORT_MC_MGCG and AMD_CG_SUPPORT_MC_LS support.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 71e184ca6004..543cf40adf8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -596,6 +596,8 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_FGCG |
 			AMD_CG_SUPPORT_REPEATER_FGCG |
 			AMD_CG_SUPPORT_GFX_PERF_CLK |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
-- 
2.25.1

