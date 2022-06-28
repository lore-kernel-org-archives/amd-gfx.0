Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A67EC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 21:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDA2E11A25E;
	Tue, 28 Jun 2022 21:26:42 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA4E111A25E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 21:26:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0nY8togUAF9hqYLa71VVeWqt2pdHY4jXAbvpuaMJHeZmXt0nzj8qdGif5YkRP51xyDDgYAHXVtZIbg90PMxgfjPLTjUhWdlCJJBiPbbgDSuYqtb2zvI/Oxoc5vu9qoGHkCrRMbXME6T3dgqKKg++v2yriH/HxJ3p7NovGUJyr6XU1sYMggPyW9aZv/Y1JG3dW8dLS07MRSndoVb5yYKdIn3HLe8p0RSQYt5+4JFITvZ8hijS9CC4ZAjdZoCJKnRzb0cigOI8NcHgq5Lu+hl1WqTII3ZS51Ntc0wx6D72nvzXE0/sUaPh0OLHHffLdtzrKiqZ7gVENhyeJ70pIpFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vglv4JGT6tthakavq/+78qYBeBJiAdEkPHI+fF8xXlA=;
 b=ffsdJ7AdyDxgdIXd3bY0jdj7wqilM/AKPmIVSfV8g+z1KcKHmJz/dRQszr+r/6mIKJ54JNP/8kWZHdBNwh2uFwEFRXYLpKGq9EDAI3WsKZSXx6d8tlZsfljBZ01HnfutOWGBTzhBGSs7IZHVfmAjurX0r1kXh0u0mgZghmVG01FvthcG7Oo0n7nVdNrKDEdfdDKSuqtEOV0t1qQ9R5NX5JO1nlC1nAKLQQveT5SXQ1+VSAB1vj5lvReT2XXCQAoPPzvMWIIB+TRr3i9aj29YJRuosTmInF9K1TjncQcQdyDToXPS/KFwUpQvZO5oRe8Is1JxsHZ6G6bvKrWLpQN0Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vglv4JGT6tthakavq/+78qYBeBJiAdEkPHI+fF8xXlA=;
 b=QQCkp7NfPYW3AYtqgf7WD+8TAj7gfUS8sxagxUIdU+34it2IY8Jb93m31vdGzPl4B0kFNckKkt+qtpEghtDqjDM8HL8EQfMJUWhtnR6OqFyKfqE4ZThJfb4FdVHbU2xtIq40eev/Ogq6ZOLI+ztuITZzNdw2BHiP44Ofi9yOOj0=
Received: from DS7PR03CA0354.namprd03.prod.outlook.com (2603:10b6:8:55::12) by
 BL0PR12MB4674.namprd12.prod.outlook.com (2603:10b6:207:38::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.20; Tue, 28 Jun 2022 21:26:37 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::c5) by DS7PR03CA0354.outlook.office365.com
 (2603:10b6:8:55::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Tue, 28 Jun 2022 21:26:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 21:26:37 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 16:26:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 14:26:36 -0700
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Tue, 28 Jun 2022 16:26:35 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <alexdeucher@gmail.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Add debug mask for subviewport mclk switch
Date: Tue, 28 Jun 2022 17:26:35 -0400
Message-ID: <20220628212635.2263706-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa50668a-d715-4414-69cd-08da594ce24b
X-MS-TrafficTypeDiagnostic: BL0PR12MB4674:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gl+/So9nomdFEpDZLF8tgwuXvrkoxv/eZDhqgj6k5weBff34TeMHcFiRfdeecDuMCBMdyVgvI91DwWXErbwaeekPH+oMhOQCrB229hG4RDh1LiEN8cw/4JVAyoPX7L/C/JQzFUnciA0o11SZATietVWUI5wpR8vvNaguI/zLw47IFQFT04p2W8DUmP6WXbSTlstHMoSuNs7HZt1Jj0RnqN+zIAcRWomQadBNfsF4rIG480Ta0boGyyU6JVPXX6YmyFEskpmS37WRfXmXHHLKqxzDWxu4eFYAhXkDwjR7g1ht7slaT6plKfq03+aqrYBkVykNC/MFPmNfHO95t19hZLhSAulpHP9tbhTUR0bkQQXut5j7djZ0L1LKOUjrIkhQlvDPqaI3pgKBsx8e3cf5o0ybcOa+/1WsLNi4TUXq+vi6Cd3vgHA8xxxXBWcjWo7dSTFkPx97GUlIpQazk+eqWFaWO9o4hnm1K3nlamqWTigSltwNZPn+IfzZscVvliXaEILbKF83bk/cgfRd1yKrIRhil5ZdGSDLf7xquveQDCG7rGvlkQTSDN3gFqC7oDRcswDuHNPc7m50JTUajo1u/yBxowcwtYPu3sbTrn7JEGYQmRDxqDqCB2oeIGK0gYwne3WQWxJzMi/4WRBCoTsXd/6it8sBxUt4wm9kvfsRDum2T8Z7iaWkdWWUSuO/qfxf8pzs5IafDDkSVM9LB47eS+XLHJUfH0nnro/06u5Driqs69MjKbDQXLWLtu87ZsHreNDlPsIMc5VdM+/Xw4uOrkqf9IDlP3jcN49VFueTmz8zKMrrRpAdRrYnDAhnNpumh3laGf+tDJ1JRvEEV8bvY+WZtpfVYKHsr2LYLpr+xmI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(36840700001)(40470700004)(46966006)(47076005)(86362001)(70206006)(316002)(8676002)(4326008)(426003)(7696005)(478600001)(186003)(82310400005)(41300700001)(26005)(2616005)(36860700001)(83380400001)(1076003)(40460700003)(44832011)(54906003)(2906002)(40480700001)(336012)(8936002)(356005)(36756003)(81166007)(5660300002)(110136005)(82740400003)(70586007)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 21:26:37.3451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa50668a-d715-4414-69cd-08da594ce24b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4674
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
Cc: aurabindo.pillai@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Expose a new debugfs enum to force a subviewport memory clock switch
to facilitate easy testing.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 drivers/gpu/drm/amd/include/amd_shared.h          | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c9145864ed2b..7a034ca95be2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1559,6 +1559,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_debug_mask & DC_DISABLE_CLOCK_GATING)
 		adev->dm.dc->debug.disable_clock_gate = true;
 
+	if (amdgpu_dc_debug_mask & DC_FORCE_SUBVP_MCLK_SWITCH)
+		adev->dm.dc->debug.force_subvp_mclk_switch = true;
+
 	r = dm_dmub_hw_init(adev);
 	if (r) {
 		DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index bcdf7453a403..b1c55dd7b498 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -247,6 +247,7 @@ enum DC_DEBUG_MASK {
 	DC_DISABLE_DSC = 0x4,
 	DC_DISABLE_CLOCK_GATING = 0x8,
 	DC_DISABLE_PSR = 0x10,
+	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
 };
 
 enum amd_dpm_forced_level;
-- 
2.36.1

