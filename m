Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FABC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 23:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A749210E46B;
	Tue, 15 Feb 2022 23:47:14 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7615B10E5B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 23:47:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJVulo3bqM46eB71cPJli0MKhBoYB7M3ugG7ITdJv4OUupkZ2fAQumpvTDc3at3yxNWK2I9+nvFZNbMngEYnZEJXdeF8TgcAtbaNFdcZOPhfBMC3rayoA3CERl5DyArMz+hyWj5l7lCqyw1yI/OUyuZFPvXQJ7bjzN6QB1AyXG5jpgFcLUBWOCi2zuVSx9uhnXnqVCNWimGuEg3mdvImI29MmXy/g6DDX0Uync4+kGf7kBuhhuxsPQ+ta049uGlhY36c8NxVYbE8iMv3v0DHhsRh4K7QLncDkIldtwK1ku9pQsyMm06QzAEGg4+go7UoOl4vE6SFTI7GlvZ7+4lNyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QY/HJcH2Gar0vLEv8AnrRErs0HzLn7+bp5hd6h+3Ve0=;
 b=TrT80UjDnAu2YrtRmWLYFjUy0/hBadCoAgOxQN++nGHHcyeqLQqQGoq6ZWth5HeVfYvGm72Hw+G2PrMjhtbR3LQP2oJ2qjBacsXK6NxHIlfklK0D9QOV9MT8byl/TH/aN0YaUYf0x/SlQQNadnQW8BBbC5z9w2Uj7mSmmd449FxKCrDOJArtJ2ml1kuojruXB5qnudck2GgkVpZra/+Y9hxXyTzUW9HgY1oGl/DddAYdNJk1Npxh+aXvudCPkXzH+uZF4RwfqndCZKmY0LIOczCIa82N0Jf5W8KoSC+1+Tw++NRHLhP8kkVVtgodBdZkwmr5DEwrrV30yKGK/rQzBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY/HJcH2Gar0vLEv8AnrRErs0HzLn7+bp5hd6h+3Ve0=;
 b=2erj9eueWPqH86q2LUGd6qfz52A/JHbj9fCMAUXOE5BCiObQwjqY1XLTTU1ofKGqMUuRnNGC5zTRhDdhMptlZFcqctYzVuGnvGpAs13fZQb4aBIO+LqEUsYZOny3Clgzh8sIKOphpEotFsuTnaCvY1pUFdACCdIfH6CY2+LsEes=
Received: from BN9PR03CA0276.namprd03.prod.outlook.com (2603:10b6:408:f5::11)
 by DM6PR12MB5006.namprd12.prod.outlook.com (2603:10b6:5:1b8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Tue, 15 Feb
 2022 23:47:10 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::d7) by BN9PR03CA0276.outlook.office365.com
 (2603:10b6:408:f5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18 via Frontend
 Transport; Tue, 15 Feb 2022 23:47:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 23:47:10 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 17:47:09 -0600
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Add APU flag to gca_config debugfs data (v2)
Date: Tue, 15 Feb 2022 18:47:01 -0500
Message-ID: <20220215234701.1560356-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8764208c-5672-4d8f-422e-08d9f0dd7bad
X-MS-TrafficTypeDiagnostic: DM6PR12MB5006:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB5006E9457A9732F5A7F9DB5FF7349@DM6PR12MB5006.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7BTwxVAQI7qrE25bU1+o8xMXeTAGDQ7DgFj3tcZ302ynDMKIrWh0XMMZMyxxwIA412MFMUv3w7eSDkmbgFobqiN0S1mqW9AWwmkUH/RIhs0R0TWFVF6Ze6swm2qJmk9+afUITyEyAJ0onuXd2+hlss6XMz2R0DHr5Z9JoQ3dXPv4SsPmDx/ZtvX6azMKFbSFaWLmCNmVCA+HmuSgBSaVhcULmSXu0TStIzF8NHJ73w++Fz4PhuCfxK/BDezUfW/QWbgH/C5vo7ilzZmizhEHA4t6A4iaSQRq7ntOvpIz7Dfez3F2bGwWZs50xC7gpO3W6IjqbZCW2UF+WUAKw/QNWlwqai2r5WNTg+G3fwpP75Ek+x7RxzZiMgO0rw5+Lny3y1ZKgUiTF6PS4vkyFz3UEz2vI0el6bifv+mFO9QKdLOa9yPzZlhuAyE+6hqsH4c3scV3fV0Zq96MzIsQw5B4ukLKU6AnrDWNOgTMGYBtR9OapZ6ENxTWIgK991MWR9AIQgz0t2o2MJ+zd9UcdAtGt/HKmNFh4Za3blujeWEXYJ4vLyzRN98rHoqMi5pWjMOh7ZV6WYuEtvYsVp9gzkuZaJNi/rbEoc2VDPGjQH0eFVskAp7FYIsziRtWKqJyM5aEvK9RP8QOpY1Wk1OYdtiDN6xvpmxLrf+kuxhxKxyK6hpOKqAJyncpF9iJ9Xjhip+eX/JYH4EPBw81ykDyL6qZQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(36756003)(6666004)(508600001)(2906002)(36860700001)(8936002)(70206006)(16526019)(6916009)(26005)(316002)(47076005)(336012)(40460700003)(356005)(1076003)(426003)(82310400004)(83380400001)(2616005)(70586007)(81166007)(86362001)(4326008)(8676002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 23:47:10.2558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8764208c-5672-4d8f-422e-08d9f0dd7bad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5006
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Needed by umr to detect if ip discovered ASIC is an APU or not.

(v2): Remove asic type from packet it's not strictly needed

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 4b950de9bf66..8f0ca71862b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -728,7 +728,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
 		return -ENOMEM;
 
 	/* version, increment each time something is added */
-	config[no_regs++] = 3;
+	config[no_regs++] = 4;
 	config[no_regs++] = adev->gfx.config.max_shader_engines;
 	config[no_regs++] = adev->gfx.config.max_tile_pipes;
 	config[no_regs++] = adev->gfx.config.max_cu_per_sh;
@@ -768,6 +768,9 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
 	config[no_regs++] = adev->pdev->subsystem_device;
 	config[no_regs++] = adev->pdev->subsystem_vendor;
 
+	/* rev==4 asic_type and APU flag */
+	config[no_regs++] = adev->flags & AMD_IS_APU ? 1 : 0;
+
 	while (size && (*pos < no_regs * 4)) {
 		uint32_t value;
 
-- 
2.32.0

