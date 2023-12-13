Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551FFC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 21:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8DBB10E83F;
	Wed, 13 Dec 2023 21:16:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1FBB10E83F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 21:16:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrdPaknkqN2pACr8EYNljaAhiLbSCmuBj0ryO1gs1TxebfNWzlIgNaahMfsfRHLoFXw6wxyRHbwqi2yQNgSH7uZHBTkU+tJ/fZ9hm0dn/9zKHlt7PCqupvFowzlz55jjxP6tUztzjLJIIliSizy9a8dg1TLkvpWoJ4YWJbsVpJ6rarn6R97vcg7mQOJuU+vZ4RpbgTQ9hKo8d6AlI0na6JJjWfzOKe5i/DMTmFheHz2hPKY0zc8/6yABvCiSgE/N/UHyf+6duALg1cSIom99LrWTQc0+EbJL/SNz6GYPSLbtd2YVeJcEKyEISburX5LsjUUEKXoSUa0hUdxXZ7JP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QjXUpUaDx5V0cKDt7Myc+ukLPxlQd/AVHaY9jfhvQk=;
 b=bQD+0ENXq780iMdN3qDUGWEHPrbuQX6GsKxQnCjg8xXdJ89k7WJEvoJWWc+zgUjUN4QBcO3HsjgXtFYyRU7ZsgQ0/T3WtTigQv9XOk1tacyQ/QZUFKTSQoBfq6OT8kHu4eizz+9ExqorwZ2lIwY3i7tPgGVGH7IuCoXC3Py3wM2kuYi0XTT7t8DaIDUL5oaQKL7p3s6ImlxTC9f1Z+GzaGnZiuCl7lqmVTKXENXEW/Sr4J5FCOMzb+dgqZtthY6+58i9m3buTvyDjmCTuNZV0d0sC/domfxK1HaTua9uYNWg1fxGqbSK8DvEZPkXqWmD9Tcl0kLduobEegGQHpFMdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QjXUpUaDx5V0cKDt7Myc+ukLPxlQd/AVHaY9jfhvQk=;
 b=EXbng8mT7hy32dIs5ER8NH1yJRCnnZd1D2ZsrbQ6x3GV8I/iu0BDamLOICj/9eeJrC41HvhZ6oWg+CrcQ7VvXswwdyFRmlC1xNh+iMMpHlCMUu0EJk4ug6lOymppZZ0ZS/Nfad4Q23FrxH3b6uj10FzYK+cbHDXosVtnV0SJ0DY=
Received: from MN2PR06CA0027.namprd06.prod.outlook.com (2603:10b6:208:23d::32)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Wed, 13 Dec
 2023 21:15:56 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::cc) by MN2PR06CA0027.outlook.office365.com
 (2603:10b6:208:23d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 21:15:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 21:15:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 15:15:55 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/debugfs: check if pcie register callbacks are valid
Date: Wed, 13 Dec 2023 16:15:38 -0500
Message-ID: <20231213211539.1964915-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: fe702295-05a8-4551-5442-08dbfc20b26e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GLBw4DgfZfxXnCF1IL3ufpCuW+TJ4KwWzSj36rlS3L03vUg4hSrGhOD0xDM9iT6TjdyWgGLAk7NkRmkgxKoE/nTvvyzF0PKdOAkprv3FtzMCtswfzZ0KRETT7Ce924VOTtkK9DQD1QMgtl1ZnXD7wKq6+rBJ1/5nFY3t10MV0SY0vmkFdTiPoHTlXdhKgXoAkACYR84iPxzQgtOqEbxDO9mlH9dsagASs1pqIaRjah61mCNZSkPQRKXqLJrntkW1aeL0cRKC9j3fmi8g4wuVOH+C7NbXCbzYefeyf9kxxVclvIa3//06t74ooDMNSCBm1mjQIXIKTrO6b35WlvlDMydFj4hwPM6OyfyxcAgLhQkEPnq6NoKe4uJZAE68Fou3B9SnnCbGQGUurFz8ec6sJ7Q2V441xJQ4QnLz6eyto2gDNK33kVOqdnIrFZtFW2OLGxJ17NQbMG3Xz97ATsF6UwWgaNKNDxRpZWTRhAL3ApsCsiBA/CTgn9nrrpC1Dh5dGGtCo+XUU6EJUxvTK5N4JLqrd5nJWG42co/yAKGuhvfB2z9EuJVW4dXwpQ0bSArHEBRh1TBccFhdlWDCGPS+lnwsPyxQrr/do09EEaIFa0wBbEC+bCKYm3S7rf8nG5EtLNbmcu+gC3FvA0uBo/rih3MtuFTu0wSXU4OXPZp5tB6gYyCITRx+gZMScVNHcN7wWH6F/0TqEN4Wqkmfaa+zTbtCGhRcMJcOiaJYK4SnW/DGE5TglTc3BbNtTNgh8UscytSHBqhltkkXtJ2gc79IJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(36840700001)(40470700004)(46966006)(83380400001)(356005)(82740400003)(1076003)(41300700001)(36756003)(2616005)(26005)(426003)(336012)(16526019)(36860700001)(47076005)(6666004)(40480700001)(5660300002)(8936002)(8676002)(4326008)(86362001)(2906002)(478600001)(70206006)(6916009)(70586007)(81166007)(316002)(7696005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:15:56.5472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe702295-05a8-4551-5442-08dbfc20b26e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Before trying to use them in the debugfs register access functions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 2cebf2145d9a..16e2c34fc18f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -525,6 +525,9 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	if (!adev->pcie_rreg)
+		return -EOPNOTSUPP;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -581,6 +584,9 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	if (!adev->pcie_wreg)
+		return -EOPNOTSUPP;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-- 
2.42.0

