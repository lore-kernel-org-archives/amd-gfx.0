Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09502C35274
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 16:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75EE310E0F6;
	Thu, 21 Dec 2023 16:29:16 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC83A10E0F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 16:29:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5FlWycYkPqWVx+z2bzLcMqWjl8XfQbT4v4hLoFvQqAj/6rrO+apNGecmcnNlcXv4448bkwGi1n4Fkv3dtNzfqfKSa37EB9Dp5NNvRWUirn+ayuzkTf3uQm6Ng9DXIK9KLo00cDVVOgoF3Eucx44WEAanizYnzKSRAXbSb2bqFnUQtkecOjAspO+D6orGiEOeNEAKc+7mr8u4RbKJXfokxmV90AV7WtE7HMIxSkVxchHBkmDmCXpJyNbPeVNB4VewBNY2amz/XK/ioOskYKPXWyklSPPYt6r/+/03RTMVI3LWwax9jRv8usVRRDeLEey6yKM6Ac4csP4tCa6SJ3xOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5lhp/pTCvf3mQuOQ9o9XsYzlWVH73/AI9v12lEnNnA=;
 b=Wp1XROsgZ2MmAuCNALXFYruN8UsGYyIZCSb4p918Vpgvt7IpeAvHA6GcVVX2nfZ64bv6ShTc7STNgMTBc+xmU0WFpk8zDniFX+toezanRpRwX/RiBj5BP8qa00KOA81l11WN3fdcWNy21PpnvVzJld5sA8CxoN1+1sD5zSeOvB6YasRpcxD6bLDVUcx2sZ4HyC6hmCxX6KVqHpd6qOBt6hNGnVdhm2klSh2OL3aXBqfOUij8qCQz9lsgi0fWOapKca4wdksCDGRzVAhAQdj5hePG5tM9PNqpqYrLy84BpdM8Sbu6HxJA8OkPVd+O5ceLiYx/CGIiRh2F7NAXyeRh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5lhp/pTCvf3mQuOQ9o9XsYzlWVH73/AI9v12lEnNnA=;
 b=DgqK1pCn9VIhz2vwl/4VAGZwBfWwco/m8rcdPzUhaFbcfoRz5GFIGaJTsYAEWknCK0//mWUtfmdEmqq1JDaJBzHkzhlO7vsSnqDvLyQW8Il9hyMq9k8Ws7ZGv94mA8ZfNCE81/hVCysa1annOgD8IFTIMz1iXUXPZPi6RlSlcc0=
Received: from BY5PR03CA0016.namprd03.prod.outlook.com (2603:10b6:a03:1e0::26)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 16:29:10 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::1c) by BY5PR03CA0016.outlook.office365.com
 (2603:10b6:a03:1e0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Thu, 21 Dec 2023 16:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 16:29:09 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 21 Dec 2023 10:29:05 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH v2] drm/amd/display: Address function parameter 'context' not
 described in 'dc_state_rem_all_planes_for_stream' &
 'populate_subvp_cmd_drr_info'
Date: Thu, 21 Dec 2023 21:58:41 +0530
Message-ID: <20231221162841.1382315-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219070154.110759-1-srinivasan.shanmugam@amd.com>
References: <20231219070154.110759-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: ffdd3bf0-d5ca-47d6-5e44-08dc0241f59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CpRCwK9lwW3QbfGN88g91gefede3DwpJAo/qUBVc7oTc6sdI8R/0ZVMwxC84PsnlIETamQCZcdiIa6U12nQDlFq6UhXgAhoHWJsyXTBHYYZVhv6U+1GSRneYgSOr8Yblzk2DIqfFK11h/qd4yHmK9471Qv1C9vuEI6INrrJsCreFrp84m6Bw+axPeI5AO5YQInQwq4NxCHsd6cuxOI7hUBm9b0qDpv4WaE+tVvnz62ZLVYrRwkApszwTXkGa4f70VPaPIguPDDqpkCj+Cl1Tqirra5loa+2J+KbkGsJ3iLAEe3B2mUL4KSxjLu58jMq/gZRoUw9OU7vvbq6hz0SWAWKVd7eL51LzjWZnyzWR51R4iZm2GupeOZlbIUVHu9RpiUq1I3KcWFrak9xCdpxIn4yuZrscQApZ22Oo3sq3STdRtnZoGGSZwikVrYkJATWcAjZTSSAHLMfwNuvTW4HGePoaT41s5V9Vsvyisd3KFoFsNRrj6/1wKZ7BK0tSSGXlFnvRO3b3jHzoSYxmWzFEMfq7t8JKa/gtjzgwRgNrKnUcWMCqyaJRmAmR3ycmgUdeBI/Xw9ff7N/jKdjfPuQ7Dob4FnjuanB0B1f8665rk6xiAxUEaq9WJMlevC1GRImjOX+2FZz9c555lvXKZYKn6mzOcV8S5S2glaMDIR9EBY0lpVAcrFacDficiMMwciigQ2t1W1beqc41+K7YfeBPQIw9A+mEqWO8dzHxolQg+/gifpCVawuwC60AJ0ZoBCFXgkSCF+rv64y4cbrvQZd0lspZ609qE4gP6rBn/elrmOa+pBRVY2nRY21MZI6fndS3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230273577357003)(230922051799003)(230173577357003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(6666004)(478600001)(54906003)(110136005)(316002)(6636002)(8676002)(8936002)(70206006)(70586007)(83380400001)(36860700001)(47076005)(7696005)(1076003)(16526019)(336012)(26005)(426003)(2616005)(41300700001)(2906002)(4326008)(5660300002)(44832011)(40480700001)(86362001)(36756003)(82740400003)(356005)(81166007)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 16:29:09.5338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdd3bf0-d5ca-47d6-5e44-08dc0241f59a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258
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
 amd-gfx@lists.freedesktop.org, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jun
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
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Srinath Rao <srinath.rao@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c   | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index dd52cab7ecdf..460a8010c79f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -511,7 +511,7 @@ bool dc_state_remove_plane(
  *
  * @dc: Current dc state.
  * @stream: Target stream, which we want to remove the attached plans.
- * @context: New context.
+ * @state: context from which the planes are to be removed.
  *
  * Return:
  * Return true if DC was able to remove all planes from the target
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 1d315f7cdce3..a59b982e99bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -519,10 +519,11 @@ void dc_dmub_srv_get_visual_confirm_color_cmd(struct dc *dc, struct pipe_ctx *pi
 /**
  * populate_subvp_cmd_drr_info - Helper to populate DRR pipe info for the DMCUB subvp command
  *
- * @dc: [in] current dc state
+ * @dc: [in] pointer to dc object
  * @subvp_pipe: [in] pipe_ctx for the SubVP pipe
  * @vblank_pipe: [in] pipe_ctx for the DRR pipe
  * @pipe_data: [in] Pipe data which stores the VBLANK/DRR info
+ * @context: [in] DC state for access to phantom stream
  *
  * Populate the DMCUB SubVP command with DRR pipe info. All the information
  * required for calculating the SubVP + DRR microschedule is populated here.
-- 
2.34.1

