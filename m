Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FB4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 22:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E2A10E374;
	Fri, 25 Mar 2022 22:58:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B79C10E374
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 22:58:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPgvHI779esoUASCxDBDo76KPEv08SvjLTcFI0pISIoc3eR7elHs17hOOEx5ReY9G3rAlViPfKdvbw1Tn3Rwj96OlFwuVWziEX4DPV/VJLbSS9Zespbcyp6PMOVJk8MgUAxOQsXDT4IZpoeEBkBSbuif58haU0xa+1uBwW2AASy0Whc6O2AXnP2Ujx1HPMGC4BUNf7OXN+r9U7+TAP36dr1SIdtya8sMZHUx0M+CD1moHveOyjW9j1EYjqCx/8QVpt6z2edj7Hs+SCHV7frqLHgmYgh0TtnYUmuWDejtgZ1Aa+4oCFpMmdgPUvEBUIe/iLvkkfALjiPB+kGDqDqEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNrNfasvIcid42uARUs0qpzAA5wNdXqSHosSXCklr5s=;
 b=dS1jlLBprLqn2hmixAwVgHdlmRncmmgwk10wBOahqOtMEiq5GPdf7gsUM5Lsq8t7rBTOPISpYcuQ3TCLf/Xj6sxrTKn4FvX8bJn1KKqGcGKpxOhbBHeusXzY+uWi1B07Yvx7JYpi3w/Tdg1VDeS5AkIwxWlc5IZmmqsXJTXyg+DohqN6THpLZ/RgMbHAVRGiv0hf70zRjv4c8Wve/6nlDZDXgI4kvToNGqI4uIHrh4Mh91g9BjgVUJOuud/KTBs3Cqz7H0GG6K2y8ofueBAtu73GRSa2vDHtuw3ymfLO8S2lKziMUWTg5R2D+XzdXFjw2pf2B5WRkBM+l5dwDIUtwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNrNfasvIcid42uARUs0qpzAA5wNdXqSHosSXCklr5s=;
 b=C3cDS7Y0whWy683fjijc5UL4FIy6K1c0RHhKZNBBXgf7/NEhwf6wTGDhx39Pxp7/PdSxB/A5N2g/HBwI/yj5uRpj2ingewm7L4YAE/EaIVIu854wmde7VTaOdDuXPlPrjSZ7H4RbgVM4oZbRjmK1zUof1+mQXD/9APBqYjajVlg=
Received: from MW4PR03CA0317.namprd03.prod.outlook.com (2603:10b6:303:dd::22)
 by MWHPR12MB1888.namprd12.prod.outlook.com (2603:10b6:300:112::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Fri, 25 Mar
 2022 22:58:23 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::53) by MW4PR03CA0317.outlook.office365.com
 (2603:10b6:303:dd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Fri, 25 Mar 2022 22:58:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 22:58:22 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 17:58:19 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/16] drm/amd/display: Fix allocate_mst_payload assert on
 resume
Date: Fri, 25 Mar 2022 16:54:02 -0600
Message-ID: <20220325225402.469841-17-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325225402.469841-1-alex.hung@amd.com>
References: <20220325225402.469841-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5335a10-e4db-4eb0-77f5-08da0eb2f68b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1888:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB188856F03608CE5E2557E0CBF71A9@MWHPR12MB1888.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89Sd8UDqDgWAdnDkDG9YMMSR0ITO/gFqiNvRle1XPiobUyOygK8tXe9j4SO7L804DUjajYEB6uUpsMe3hMedVyMJWrRCOw0fFSyr915AI6+s9OM7+4XGc5o4HXbyeW1MIgcwJHY39i0VX/hR3WHAPUXWpgs1SqNztp45jaTgRNGvyfJZg4gkI9r3Wgj39BgNVO5+O4BkzkifbCyhAGklhczoT1aAqylvMKt0nlKR7mBWOKZmaSfXWtqUyw+cyE7vjzfHconc9zJxcLPpIZpO/vNAS71dfTpL+hSs6kziHpqlPSVfD4gCPEsLgx9YKPmlJWY1IQDjubqJgMLF2D1mDuNX3WCGkP20iOXccczjxcbtJ6QRHV1YJuBaK1JDdJ6Ug4h+FWk9Tg9Ei8ct5eON0CLarC7xFclImqShr0REtDulO8iIqRFUb2v9vWKo0rFbbemwwZuM4wlXlODC+Y0IfrAquVpvulY10H6RSEMaQt6NpWjKcN2FsSB0AexB/TjNku6oeWZjPclTjYN5YZmCXB+dUu4+8ON83AIJTHVeBGBEigxMn6FpouEIG5xdbiKFrymB3zgeXoNFRCBaFiaGzaHTHafs8kSsh1A0PrEgB06VUIfj9npJbEeDUq1yi+QG+CGXwdKNnxEFUs197ueHFUugjCyYtstVS4czJJImzRr3spoXAXcwUr9FnlAcgSUk9b0wr9Egtn5h5aaftYiLlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(5660300002)(508600001)(44832011)(6666004)(54906003)(6916009)(8936002)(26005)(186003)(316002)(16526019)(2616005)(82310400004)(4326008)(36756003)(2906002)(8676002)(70586007)(70206006)(40460700003)(356005)(1076003)(47076005)(81166007)(36860700001)(336012)(83380400001)(426003)(7696005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 22:58:22.7774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5335a10-e4db-4eb0-77f5-08da0eb2f68b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1888
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

[Why]
On resume we do link detection for all non-MST connectors.
MST is handled separately. However the condition for telling
if connector is on mst branch is not enough for mst hub case.
Link detection for mst branch link leads to mst topology reset.
That causes assert in dc_link_allocate_mst_payload()

[How]
Use link type as indicator for mst link.

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6633df7682ce..cbeb9db1014b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2714,7 +2714,8 @@ static int dm_resume(void *handle)
 		 * this is the case when traversing through already created
 		 * MST connectors, should be skipped
 		 */
-		if (aconnector->mst_port)
+		if (aconnector->dc_link &&
+		    aconnector->dc_link->type == dc_connection_mst_branch)
 			continue;
 
 		mutex_lock(&aconnector->hpd_lock);
-- 
2.35.1

