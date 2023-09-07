Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAC0EC8735
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 14:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1AF010E7DE;
	Thu,  7 Sep 2023 14:41:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A6B310E7DE
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 14:41:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FL3IcNfSbYsvXbmL0fSfdmUYB2y3nsbKDQTpY8VzZaeWFZHKkEjvOg7Ri8X2mCggAZuruLCigUIhF71POWUgHiDiIhRWnbQYhBXM8FcBuv4LyOeyeyD41/Nno0VlR1UowHfUsC3tfh8uAfDmkHVhp6w6pQeIbHAWChEeHOAl8oIVMK9TZpxHRrXUaKHLdb6xnoP9Nucl1GJisy5cGGg7urUD5a3/aKeaotkwC6PoQIQzfZ7/SUOshdShWKcQDBEkvCREUuG/23HH+NpzkICE2OeD8L7Zr5jBDsOlJbevWWR2DfXIzH53ASzjLBCx20TeIQfWPSMEwQhpaM8Z8eItbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbMNQ6li6bI5WuF+XTnNEwyziCEWsONB4Mv+9sTn2P0=;
 b=SiBuPeYMnvuGwH087FwvuQe3pguaxNW+8VMsc2WueDiO7+FrZYtvQ3+Xnaj2wUIkhP4d4jOrj9gRwnuQLz68rlJpwHtsQ8hPRiCx8/Qk6G3juAic51kPJyAgSR8fuFQG5p27vWBT9k0y7hpeXpu9mkXQQL9SLnXiVIyKAMJjWXPzYZIbGawKiqoMvItMegOZ8Ny5gwaEo+Q1Vw+gic+lIttQYFyUk7pQY9wJIYTKA7g9g7MO+kMnjPVrO4oXwDb2pfdjp6IF19Td4nO5CanNsY2HdKgApE9Ht+tSiR8dRo3fDbThz2x1BS/GtVUNq7HAdd4hY4PgyQjVvh7Z/sKF7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbMNQ6li6bI5WuF+XTnNEwyziCEWsONB4Mv+9sTn2P0=;
 b=LwQmqWrqIN/fsDVFUzo8Dvfb9HVzQEssYABLGMirrB5kFCRZFOkrVutgMOA++106WUCS+yEJRlQlDAs6mhp1guAdUU9eQwsz3yH5LSd/wAZeYrDOuNdbLlbP84RiuVOIg3xb8QsqpyjyM1sTD543UN4fBMCPGW1GY2xnTPnSpPA=
Received: from CH0P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::26)
 by CYYPR12MB8923.namprd12.prod.outlook.com (2603:10b6:930:bc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Thu, 7 Sep
 2023 14:41:14 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::c) by CH0P221CA0017.outlook.office365.com
 (2603:10b6:610:11c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 14:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 14:41:13 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 09:41:12 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdxcp: fix amdxcp unloads incompletely
Date: Thu, 7 Sep 2023 10:41:00 -0400
Message-ID: <20230907144100.81325-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|CYYPR12MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d019d0-dc70-4c8d-6a37-08dbafb07c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsojRbS5YJ8whD9y4NsAOnT8nx/L5sHzuZzDMraNWBIbNqafiBJdhZBRmvLKjKYhxBVjC/cayh1wOp+A94lxvvveIduUkw8+5NIBK+NOfwxCDmCbFCrcnB+HX//OuPHFSsdb88bhib+c1vvAPm0vRzgr2+4ze0S4e5ecuf1/3fS2Z/Xb/AfuMVhvdiAGltRlKxLxiJEAByVxwLCU3P2ilmBBoB07gOWSrkoFUUPmb54yUbx4PGd5CCpdtb32SMd1epck0uha8d5YIOisTJmKjUm0ybPx6MIeDPW/cy0IKFWWUWWsAzgVyAk174lH8JncBpo8CiTQfwyjTTNW/xquHZpJchdtqHfsNLrM8Pj8fogu2M0MDo+HsLSHMkspbr1wV2WXqDjh0WBxvrVaxZ5odCL9K7Kug2m7XXXQc6xC91XcvMWKDiEVE2Dr4LCzzD7u/9pQtdcQI0bZge+XCsGHn3dXyZPRoAFJK4Xeod7pgFk2oU3jWyiUjBCra2kZoh9l0RPqNhZ2Ki/rcqozhsxJ7yi47ghHv5x/OrYQZ6hS83hwzf8upe5Ev80uzc/qxAQQOgFfKX1N/q2tm/dlJWBuJWT6kUZofHDbGlsZY5//IuqaMHKbEffWnT8tf6gQaOt+wPBdgZUqqyF/cc+bUJsYU8xsZWeDMHA89QpsDEWt/WOqeNiWpskXMpNj3BV7qDFOCi6XCUJW0BkwpJ3KO9qDA4VLnTd3BYkieFwmLXGZ7DAdmg2tQq+cVQ2roJwPPJsK7L3Bu+CcD/oSwJW3EcSIJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(82310400011)(186009)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(36756003)(356005)(1076003)(40460700003)(40480700001)(41300700001)(83380400001)(8676002)(5660300002)(26005)(4326008)(8936002)(426003)(6666004)(16526019)(336012)(7696005)(36860700001)(2616005)(47076005)(82740400003)(2906002)(316002)(86362001)(478600001)(6916009)(70206006)(54906003)(70586007)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 14:41:13.7892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d019d0-dc70-4c8d-6a37-08dbafb07c62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8923
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
Cc: Amber.Lin@amd.com, jamesz@amd.com, asad.kamal@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdxcp unloads incompletely, and below error will be seen during load/unload,
sysfs: cannot create duplicate filename '/devices/platform/amdgpu_xcp.0'

devres_release_group will free xcp device at first, platform device will be
unregistered later in platform_device_unregister.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
index 353597fc908d..90ddd8371176 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -89,9 +89,10 @@ EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
 void amdgpu_xcp_drv_release(void)
 {
 	for (--pdev_num; pdev_num >= 0; --pdev_num) {
-		devres_release_group(&xcp_dev[pdev_num]->pdev->dev, NULL);
-		platform_device_unregister(xcp_dev[pdev_num]->pdev);
-		xcp_dev[pdev_num]->pdev = NULL;
+		struct platform_device *pdev = xcp_dev[pdev_num]->pdev;
+
+		devres_release_group(&pdev->dev, NULL);
+		platform_device_unregister(pdev);
 		xcp_dev[pdev_num] = NULL;
 	}
 	pdev_num = 0;
-- 
2.34.1

