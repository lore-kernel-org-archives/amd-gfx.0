Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7CDC7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA64610E6CE;
	Fri,  3 Mar 2023 15:45:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF4710E6CE
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:45:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdLDJ2jhCC2ceHDHycFCbciqfI8o4qcIPdu2DR24GZLsKKI+sG3I7d2EVnht8BRJGGzHmJFas79VZJEnRgicUDAzGIKL8dJV6QIZwcLko0D/kO2vh8jtjKljktMZsSP17poVM5cYBoVwzQuxTs5Q8GN3dsfstXARo8U94owgG1Mbe1CldXEqhXLGE2JIxV89IqPG2uVMr2yqSHl+LDcUB1Gm5B3bfDusUN9ApmqzjsEpNTwpd8M56Yd/Mt0qmQ6ysQU34W4xYnBycLoWGOomQqIA4NUKqJfR0kvnUdMdKBo+iZEwvjc7BAASwrqXE5raFOWm4kChEgDuPzUzTEP27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twmQZbVI9hlWX6ICQIcfiBgZ3BGHg3fxBJlkcp6b6yQ=;
 b=WD4owU0l7F0o2AQ1wWOioYtAVbQQL2NV4sSYdOk6KbJ76WzXF+zsWnLaFiRADz5rvr/8gHTttJMwQjttMrGHVGz8xAs0Owcgv8UebwCMLCKxmygPyW21D0+SEJLMOitOLFvozl1RFl6uWF9ujzKOEzLKapVR9IuN4cW9n1FR+xfWrAU3dnJzp8wmRBb0O/2aeG7KpEw9Q5AcxIkLhQa99hz1Fzq7XPxvatLwQUstdpPTQ86xynqKAKQAfH9eIi4BA79c0JgVwkp7vYNkYK02WOMKLD6iuhmHjYsO/zzy0/ehqZCVSBXDMI6PyIgkqYmM5UYCo5CP6ghtvr6vJ6CXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twmQZbVI9hlWX6ICQIcfiBgZ3BGHg3fxBJlkcp6b6yQ=;
 b=GhFqA/jZ1suNOALMHqdaTrLEnI1jCfNWb152E8B+PX5Pr8TznYTaP8BW3KYJ3lu+9M5yAeA/xHft9MlKb0tZ6EnkMz1f+LV+feYgLYBwCN6ZkGiReXl2SOuALh6En7U4KNHWtcJJikpgwZlvJ+2eXRbtADu2fI8l10dei9vbtzI=
Received: from MW4PR04CA0225.namprd04.prod.outlook.com (2603:10b6:303:87::20)
 by DS0PR12MB7777.namprd12.prod.outlook.com (2603:10b6:8:153::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Fri, 3 Mar
 2023 15:45:44 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::1c) by MW4PR04CA0225.outlook.office365.com
 (2603:10b6:303:87::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21 via Frontend
 Transport; Fri, 3 Mar 2023 15:45:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.22 via Frontend Transport; Fri, 3 Mar 2023 15:45:44 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:45:24 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/33] drm/amd/display: Update minimum stutter residency for
 DCN314 Z8
Date: Fri, 3 Mar 2023 10:39:55 -0500
Message-ID: <20230303154022.2667-7-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|DS0PR12MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: f21510a6-0bc4-4754-bac6-08db1bfe59c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fEP7kzlLULu2X9p60qqpTYL4oXg/C5jQuahdtK6eMBeBEWbwAqu9kt0tarUooq2+nBSUdIqQkMOog/Gz4Hp9+81+XeU17Mdtp7rrR8rTh0kre0xS7h7yoMzroRBCs3SBoDYnZSa0QckooQh1kWaTYBS9l3mO6yzT/ulQk5O3Ffc2HLMcMJNdMGkF4YkLYEN767jFXNBow2/BWo3pyavElftko/IVe0zdXplJUojeB4jN94YwqjXkb1xEyrRzB99m1gfhVyuHPex16BGRBFeT54m1/5/vf0sKbpMHerSB+7hXCnU6G+80PvVBpzHI3Ww7CmMgwW3UK9mHWOvsPCd7h8fMV9SjZoDftK1uQGGh1Kl8z5YlE5iATUio2z5Qrgmg18GvnQ0ft8hsNhS3Wn/K5j/S0apjlCUe8oxT2G8TBtrveJKLWMiiN0HOxFoSmpo2CAKa/S1RZoOz0pqYiol9flHi1qHViDSoPPSb+/zkgusJ4b2I3Dr1MJ9epGotsKFOE1wpB216TgW7qi2VVi9tECgODKgeEQz7K3xDdy9o7AxipaG+3Uq+QtuL26xFY4gtXnTnESME+hrL2+qbyYp+XoQz4AUVWmTorxThVFs7MBHbucJrUSHHepfdzGqV6w1q7defvZC46WoSongFAvRUQclp2P2P5BVnvSb7JjE6EapUcnzW8+9/1MalP0o1KyjWx+hLVCiYV19F7PPILPWvROZA10mUti/DtCYdFP1VWhQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199018)(36840700001)(46966006)(40470700004)(15650500001)(2616005)(426003)(5660300002)(8936002)(83380400001)(44832011)(41300700001)(47076005)(336012)(186003)(16526019)(1076003)(36860700001)(70206006)(4326008)(8676002)(6916009)(82310400005)(26005)(82740400003)(70586007)(6666004)(81166007)(2906002)(36756003)(356005)(316002)(40460700003)(40480700001)(54906003)(86362001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:45:44.3202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f21510a6-0bc4-4754-bac6-08db1bfe59c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7777
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Block periods that are too short as they have the potential to
currently cause hangs in other firmware components on the system.

[How]
Update the threshold, mostly targeting a block of 4k and downscaling.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 8fc89aeb86d4..f9dfbc7407ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -887,7 +887,7 @@ static const struct dc_plane_cap plane_cap = {
 static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = false,
 	.enable_z9_disable_interface = true,
-	.minimum_z8_residency_time = 1000,
+	.minimum_z8_residency_time = 3080,
 	.psr_skip_crtc_disable = true,
 	.disable_dmcu = true,
 	.force_abm_enable = false,
-- 
2.34.1

