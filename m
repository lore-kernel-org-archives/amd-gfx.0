Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254A5C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:26:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A637C10F332;
	Tue,  3 May 2022 20:26:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D79010F332
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:26:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WM5Tpmw6FptJ8cqgree3R+z23MYAOkIJhCjRVe3vtqWcIGPfytPP+XWxURIzPgOLGfL9KVx3IImZt26AYdNy8bKw7OM73O2wzDx5NJ4+QZ5mnQPCxUG3pUPKZdYmHcl4OhSiJ6rL36IYz89IIEneSiipsNa6OW+Uygy0qOfWK4p2r43hQWZ5CW0BDAYO4s288yjcGjn1Ym8UjGnNtmSFtFynFESIfn48FMkD5mQFb/g7A8YeuhM1L8PHvduU1XP/zAyXzta9k4IVXkh2WYxrH4YQecnk8NagO+b/kyO7Ub5OUrFNlK6HgyvT6RBetktLDvkq67OVxw1i+0KSotwuKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMt/YFS2bTZb81hye/hMn5l09hN6Nyi2ICmtpBDd8Es=;
 b=EN0ePoQC8sRq8CKr9fYYjlP02mQ5TGP/dCcnv6N4aMSdAmDMq8KFSwmhhJVfZEQcZd4nThL63rPir4O7DKS7sy1YESYmeiRb77HnvCUI1rHB9P7EzzdytHZd5XDzv435g/1jHCbqSojoqu3Qp51/ngomBKyWDGMimYkzQ7CswX+teayn7H5wbddPGU2uyf2oUWYrj+eEehZK6Z1wocy/31mhbp5iTNhfZoOlfIUOg12as7nNleeWEd2vYgBUbDQwoU/k9wmeeNs0yt8HZ9q/s8NUPO6mJgulgtqoXad2nB9D3X7azRFG8mj1pjWmC6u5vz/dZm6PisbFSx83oD9TGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMt/YFS2bTZb81hye/hMn5l09hN6Nyi2ICmtpBDd8Es=;
 b=donJ+dYq9Yyws1IA5usBNQWNlcGwDdU4V8U+N9arS3BIfFPye3ZgafeSyAQ90kxrCrQdQJdjItqqWMZZeuUOEVgzLwbwhh38UehzqSVwD0ZCaIb1Kx2Ig+T8TWnDKVcJofD3sWVXG4uXvEpX7FhmHgKoruyuGQ//g+t6eFsbRWo=
Received: from BN0PR04CA0132.namprd04.prod.outlook.com (2603:10b6:408:ed::17)
 by CY4PR12MB1365.namprd12.prod.outlook.com (2603:10b6:903:43::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23; Tue, 3 May
 2022 20:26:41 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::84) by BN0PR04CA0132.outlook.office365.com
 (2603:10b6:408:ed::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Tue, 3 May 2022 20:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:26:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:26:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: split mmhub v3_0_2 callbacks from mmhub v3_0
Date: Tue, 3 May 2022 16:26:27 -0400
Message-ID: <20220503202627.1210404-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202627.1210404-1-alexander.deucher@amd.com>
References: <20220503202627.1210404-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86ded017-3330-4d0e-f9e8-08da2d433b76
X-MS-TrafficTypeDiagnostic: CY4PR12MB1365:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1365E4D14E61356BB9293173F7C09@CY4PR12MB1365.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eD1pdshf62njmxD8Y+9aNJ79zXfodR11Fp+qLVaxWWCURN/yPF5ICWdhn94LCKZWCnf0Eocxs9GVvZa6Iqn+SsvFOHV00eGtZfjBig6szh7vCFOu9dyr5zquUVqr8SjFB5eu2U4Al23OEcSt42gf5nEd7DrMQ59zT+o2cNzLuTjq6dk21M4PTxvmZSR9fvBOFWJSmTpAAxdPGl2RGyohjruuX0VqXBFwA8aSB6byNByNJ/sQ0uAWPEvxbQG04n7ncxloNug9Te18G+W3OBWMknjYFzVXa8ZDHmpgR8CyEVCkCi2tXPnvo6ZUg5xRovAMp+nN99y0qhnhsujFFeFCE6sjIwoTuzjX9FQjusKF5YC1Kl1XYXbeNfgVCB2ka2kdFt6ijGWg+RMI2c/yLkkWL87V6trJnAHUWKZ77CJlhcAc0DgvFrayQSeaTYic0nyylaSmmkZiPCBKPL0KrGITntAyZKYKGo0ajx1ZJksp5ruRCxsmv7Uh4Ps2oXnmhICXf8j2jn8OOwjB862YhG0BOgZ20oEjSdZkfF1QBCNoirQuZ3TanV34s6g3wHQyDR70WHkh9xLget60P+K4G+pppSvrUhRTJAKBWkVtQFYTloUy+A1RFJsO1tIAV3jzruFwzAofy14Bj/Neshw3ul9nSzLwLVPygAhg3cSu/pi8R2aVn2mvHUEOkcIjpsZVPrkB99dVRkOYkwQkabC+cQLy+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(2616005)(1076003)(40460700003)(86362001)(26005)(186003)(70586007)(70206006)(36756003)(54906003)(4326008)(82310400005)(47076005)(426003)(336012)(16526019)(8676002)(356005)(6916009)(7696005)(6666004)(81166007)(2906002)(83380400001)(5660300002)(8936002)(498600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:26:40.9277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ded017-3330-4d0e-f9e8-08da2d433b76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1365
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

So we don't need to add ip version check in every callback
when there is atc related programming that is only
available in mmhub v3_0

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 032414d7429d..ab9f8b7e0aa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -37,6 +37,7 @@
 #include "nbio_v4_3.h"
 #include "gfxhub_v3_0.h"
 #include "mmhub_v3_0.h"
+#include "mmhub_v3_0_2.h"
 #include "athub_v3_0.h"
 
 
@@ -599,7 +600,14 @@ static void gmc_v11_0_set_umc_funcs(struct amdgpu_device *adev)
 
 static void gmc_v11_0_set_mmhub_funcs(struct amdgpu_device *adev)
 {
-	adev->mmhub.funcs = &mmhub_v3_0_funcs;
+	switch (adev->ip_versions[MMHUB_HWIP][0]) {
+	case IP_VERSION(3, 0, 2):
+		adev->mmhub.funcs = &mmhub_v3_0_2_funcs;
+		break;
+	default:
+		adev->mmhub.funcs = &mmhub_v3_0_funcs;
+		break;
+	}
 }
 
 static void gmc_v11_0_set_gfxhub_funcs(struct amdgpu_device *adev)
-- 
2.35.1

