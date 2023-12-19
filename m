Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84021C41535
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Dec 2023 07:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ADD910E193;
	Tue, 19 Dec 2023 07:02:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8335910E15D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Dec 2023 07:02:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFjTzJusfz7kXLJjgFtgLMmNAOrZj4Ea7JnqDTzJBFPAfCJePPEw6o9hm1SdeC3XPwkcNXZlQz/+ipewwSDe5myKUKCZOnLn/Ht18mJiayY8ZT9FM4q5jz4vit4DuBSm+aGFjcSXsnkKZxDmzQAnx5hoUrsn9tMWqQ62D/4vW9z7cD8LAH2PV5vrdy73j7fMGR5p/Pw/aODNV94mcvNZPdvoqpnS1FoHBLvdm+lGjhY1CtyGBmUPOo+C33XTdRHXpOIpGPxJZ2LzlkpJ7/2JgdPdAZS/N+YKOaZEIO/AVix9ukbHnh/tELJ+6/VEn3TJL7PyrRSZnDHnomkN8itBPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t26smQ99EfTwV/fIGhei0S558zACqH9st9EMk2VfYM0=;
 b=OEfvu76+gmWoQLnExrn8TPat7J9Q4vDssrDOJ69mBGHc83cpt35Hlc8C2v+Q8QW8Bgl/3mFpC2MkXXrEZXNjIycrjhjU980MfnLZavje7786UN3CGgOeQzmk+wk8pFsuP11YufFDPmc+ZTXby3umEU3+KyyUoufOErHYweI70D0KoiaT3/9hrrAWVqqLdutRBZK8mMpAfq6If8KwiLNLDfTf6FJqNCmUQzGl3jSHcu32eaX1aOQqfEm3N0tsXZfD8iVKIzENNxtFWjKeMVtq4M/p8rWMctObzoMS5yLOEAO/CtPTteVJqco2OUWfXujRLyXwzWzKkZFIWYQ/Op5j3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t26smQ99EfTwV/fIGhei0S558zACqH9st9EMk2VfYM0=;
 b=Zj7tfgwPUrDEAlGsTn4gZWJmOluCLAcPy71JfhP5cVGOy5mFlQhLIotShXpYVQU1NiJzg9VR3rsFp1ovRpxnO6x8jHMYD7e6Pp3JolcbbB0w/b/7BM46QZqGU1AkkN7etBWnT0WBS578WmeUsgjWxWfmZkG+Tcqzm7Fdz2K4hYg=
Received: from DS7PR03CA0122.namprd03.prod.outlook.com (2603:10b6:5:3b4::7) by
 MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 07:02:28 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::9) by DS7PR03CA0122.outlook.office365.com
 (2603:10b6:5:3b4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 07:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 07:02:28 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 19 Dec 2023 01:02:21 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Address function parameter 'context' not
 described in 'dc_state_rem_all_planes_for_stream' &
 'populate_subvp_cmd_drr_info'
Date: Tue, 19 Dec 2023 12:31:54 +0530
Message-ID: <20231219070154.110759-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec35e0b-91ec-45b6-48ac-08dc0060766c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jQQE9HXkhz/GVOosqORS/ldKhL9fTbdGK0QXKubzfpvIJY0dMx46dJIhevN06DnbaS6pwxiKy+dgWilkqxoF8xtWzkQkZl3EhKk1+BiC5vUh6g2guJOeubfm0m8tR90EHjiqsUlHe2YQrtfCZT/Y4xFetPUZ9mnfxlUcDhS7EuQJC3GpChrqpoF4U5MLG8ajJuMXh3NOSIZhAHvD8GCSfGl0ngLpf0HBMikFvSXB5eyEuJ+BmOJliGnJce7SCWyxMt91U3rZH40u6aJmZj2lHUgAeKcjVTcw3DMsZXLD/pxNCFcYtQ3Z0KtQ6yXBicqUbei05g/0ryxmZ1JIZ7dbI8w0LgVw0F4DrMPrLdG2M3JYBa/VSuk5uFytv77B7GN0A4YRUtsC+jO82sJAFPvy23kTjypjAld8jmQXPM0eNWb0qEI5XNJifvsH4vgsLkECdW7tqbpwAhgSGXLDGtSJ4bDlvCFHx8Rt5zQIHycEffqYYze8TMIYJtUce29zLBP3y9TkLWyfD72jYxCLnOfG4OnzFBImV+j7XmwXJ/h87qSYJ1XBDLgF7citC+qBeQOyhaO5YMQiT2zwjyYqrxVlA9sKgOKXDquB2GWE5ZuwEznRh+caPdkYR1lwgZRYW3gk1PIvvEnC6RH1iwUbme2QUFoOeyI5t4oFnaIy/aDdxS8GvcHAR8fX3hpxlVJsZdKpzZW0p29s4PB/+kDPDBCN6/3RWJMO2AQKEBLQCPa1avIbim2bnWt1cddRHVgqtajJKC6lCv46n6YltEyXHstqmGQqo7lA0ti8PtJOeN55VCDeBxPHeUOOr+Hzp6tgTBG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(36756003)(6636002)(316002)(83380400001)(426003)(336012)(70586007)(70206006)(110136005)(54906003)(40480700001)(2906002)(8676002)(47076005)(44832011)(4326008)(8936002)(5660300002)(36860700001)(7696005)(6666004)(26005)(16526019)(1076003)(2616005)(86362001)(41300700001)(82740400003)(81166007)(478600001)(40460700003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 07:02:28.2654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec35e0b-91ec-45b6-48ac-08dc0060766c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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
Cc: Dillon Varone <dillon.varone@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org, Hamza Mahfooz <hamza.mahfooz@amd.com>, Jun
 Lei <jun.lei@amd.com>, Srinath Rao <srinath.rao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following gcc with W=1:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_state.c:524: warning: Function parameter or member 'state' not described in 'dc_state_rem_all_planes_for_stream'
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_state.c:524: warning: Excess function parameter 'context' description in 'dc_state_rem_all_planes_for_stream'
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:540: warning: Function parameter or member 'context' not described in 'populate_subvp_cmd_drr_info'

Cc: Dillon Varone <dillon.varone@amd.com>
Cc: Jun Lei <jun.lei@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Srinath Rao <srinath.rao@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c   | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index dd52cab7ecdf..88be042d3998 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -511,7 +511,7 @@ bool dc_state_remove_plane(
  *
  * @dc: Current dc state.
  * @stream: Target stream, which we want to remove the attached plans.
- * @context: New context.
+ * @state: New DC state to be programmed.
  *
  * Return:
  * Return true if DC was able to remove all planes from the target
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 1d315f7cdce3..d714144f99df 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -523,6 +523,7 @@ void dc_dmub_srv_get_visual_confirm_color_cmd(struct dc *dc, struct pipe_ctx *pi
  * @subvp_pipe: [in] pipe_ctx for the SubVP pipe
  * @vblank_pipe: [in] pipe_ctx for the DRR pipe
  * @pipe_data: [in] Pipe data which stores the VBLANK/DRR info
+ * @context: [in] New DC state to be programmed
  *
  * Populate the DMCUB SubVP command with DRR pipe info. All the information
  * required for calculating the SubVP + DRR microschedule is populated here.
-- 
2.34.1

