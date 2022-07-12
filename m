Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AB4C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9771F9514F;
	Tue, 12 Jul 2022 15:59:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C439508D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:59:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuhNYCGHvtrdlLxzSehij7x5FxIwZToRNKHPk1am1DUdkGn4+GraO1uGmu5/gdb2FLwSnX/0LN4lPyZ/65SnhFEqNxTqHcZd15pefVMEv2lejiUxAgkS07q2AtlKv7yCgI+MAw258w+XzVJZLvBMsXA/pqLEaJQbpg31i8U3vzVDZwfP50tmjQ/lj1PINE+Xsflgyns6c0RSp+uQXXqir8HuMgW+XxTG6a44ln+nSjS1tN/X1tW9KIBgwBa4q1xoR+cmh9hQBvKX3h59eV+YJkQoSLVst2/QVjXYqGxuJqi5gFIUlj0YAR24x0htjt5+df9099Y6dgq0CXAhsZ0yBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E44rLG0BvMrUjWt7nK8McQfK48UWTTlKx4x/ap74erQ=;
 b=Sf75lwLbhmLQ/agnOggSOSVujM1bf1QJvLXQSaGabJcqtwl+TmPxgxHnzwCL4lG4Dem2K2DfJBlXU7VpIPGSWd2cfJ2qiyYTqhMaXeJHtmS4aDvK9fZ0ssitIpejMOtq4BP0STPxUPeLXHJeOpIbaac4Qvu4cVENDZ8udltDnDRVWUsbgUsT/Yld38fSEWT6Og8SWiRAxfBwnNAju9qNCg5wqxos4fUJ7HI2BJiJsc/yJL8e5wbMwyZKNP1x/ferXVz3gbUUq+gq1vHev0RMM1ZRd6d5WTevBMYYTFL5kpP2Y2qpWSczdajB4mzWQSxYA8WeyeaH0VEH/KjTvk6ZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E44rLG0BvMrUjWt7nK8McQfK48UWTTlKx4x/ap74erQ=;
 b=wvmT/l+eq5uJrs0BE9nQB2GRqM4hdbxgWVXwKujmVsEmR1B6Ze5imJXVhSJo6L9F3/ZFBBhPa2dmF9FkbRKOadMH9l7rjfakV6dh5njpmb6+eFdOhX70BpwbY7qE9qfFsa7unscw0YJQG1HDvGyyZslV7sSZhV/MXEKDVjKvQrs=
Received: from DS7PR03CA0359.namprd03.prod.outlook.com (2603:10b6:8:55::35) by
 BL0PR12MB2515.namprd12.prod.outlook.com (2603:10b6:207:40::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.25; Tue, 12 Jul 2022 15:59:51 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::a7) by DS7PR03CA0359.outlook.office365.com
 (2603:10b6:8:55::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Tue, 12 Jul 2022 15:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:59:51 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:59:50 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Add a proper DMI match for Precision devices
Date: Tue, 12 Jul 2022 11:59:36 -0400
Message-ID: <20220712155936.1700339-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02ac92c2-f491-43d8-1392-08da641f8de0
X-MS-TrafficTypeDiagnostic: BL0PR12MB2515:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECEiqnpWlpyjeUfyy+dlpX1aEcgig5r2JElsN6F2lB61cSC7loKpbc5UZvDJZXsHauNOdH9n0asWLwN2Ndnsqpb+M2sZzbAsm/+04UzSa91P9lGapMFfCAm7qvsnQDLX4xrSCaqSf/GpkCBUUNF+JisDODwiD4y2ahYU5wF95yAVKzbBQyyViEL85RhpUHeqeUArmUBjUcEgX7kyzRFpHo0iUzyX+/v5Dw/bvEuKpLPAuikqBBPZitNtdYSGAEua/E7125x1G4gz/9WjFnS1phncW03C0C9coXSkakcfLW9dl9vYvb+UddDlifae+BFEiCFZC83MPXQtQ3WNO6nmEl1uT0YmomtFSxXbhBFE93QCuzcNCEXw7ry2XpHt83a464yz5SpiCoLTdNhu0iWYUKCOzxgXs6kHQsOzhwFSsny6hFlZXeqUVUekjtVZUw+O3Lj+ZMEatUwgYoUadTMhJo6ZnhCHL1y9dr34SA2TqTktQiwXMbAL9Aw2po6+lqv/yQV3cDdXrulRnMNtQ1aga4GlBgTzW3w7Hn0rEGy0aL4O/V8VK704zWqBKSUKY7387lWy2MRJn3gOezPvPVB/OG/ps7FgzIokgGUGY+umgqVQefgFNgds1AZcG+vdnGLdqVtTc5PxlEcwBRh1O+yd5mStdXWaD3TkbTeNTh6sVIGZ/P1/89Xt0FC8vbWHqkaIfcvmKPVmyvtzFiGyYlmPZnePmLtAorm+JZTXlTT9JTzcVX6Pwz7jORjcuwDIShDSHPbpIejDVKRqCcCipeLGmvJyGvT4x9kkwnCNY2DkzuRmua0hRMzuZ5CQVMeDYwbwg3BoCeXYa7Sf8DJ43L1dAVTiEql6GYIk/3jb87P7xRk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(40470700004)(36840700001)(82740400003)(16526019)(83380400001)(40480700001)(36756003)(8676002)(54906003)(336012)(70586007)(186003)(81166007)(70206006)(316002)(426003)(6916009)(4326008)(356005)(47076005)(36860700001)(82310400005)(478600001)(1076003)(86362001)(26005)(7696005)(6666004)(2906002)(41300700001)(40460700003)(5660300002)(2616005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:59:51.2289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ac92c2-f491-43d8-1392-08da641f8de0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2515
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
Cc: Qian Fu <Qian.Fu@dell.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jerry Zuo <Jerry.Zuo@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We had an MST fix for some DELL devices that got merged, but we missed
other products. This commit adds the other missing Precision devices.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Jerry Zuo <Jerry.Zuo@amd.com>
Cc: Qian Fu <Qian.Fu@dell.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Fixes: 9fcd8af669d7 ("drm/amd/display: Ignore First MST Sideband Message Return Error")
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e203d75834de..96a0be8508ce 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1408,6 +1408,18 @@ static const struct dmi_system_id hpd_disconnect_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3660"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3260"),
+	},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3460"),
+		},
+	},
 	{}
 };
 
-- 
2.25.1

