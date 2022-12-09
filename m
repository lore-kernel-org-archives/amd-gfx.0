Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA321C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:38:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E983810E578;
	Fri,  9 Dec 2022 16:38:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E32710E565
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cb6HQH1zQ1wNq44GqbdS1Lmqz4nB+xijHijujcHhZftcnXVAO55jNRoUGLpuOKYZbPjOcE3JZp3TO6KM58r+pHImD/B4aATONLRBuIP8n+orvs15brtjgWdtbBWgQ3sZkSRfc1MEOEaLLQOdwD00v0MN77MBVfFMLFhsZg59ogj69teVjTcqGFrV0yki1Ycfo+fpcO1Ap7383cvrKD82BFA3MWU3KDuWQdmQQK9UgWlhDqOa1BIP5O5HLdF+1Ic4EXC94L7zoHVsGVnCOJNbYNFHDx3PLHIWcngie1RMeUIElYkxfOnDR+HY9BfeVOPsCDyfoYT+de4TrudwZcuJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1BMzENslg5tUThbA58GD/z4g5E8hfzoYg1jZHgvdhM=;
 b=cs6X6G/+q27gOyxVNfBj0kaTb6XxlC/ZS7ry3vWIGpTXUZ/KjESp57OxlcudWm2KvSlfBkOKVSA/X9PBIUf+DIzumy1+kc9vMNRMfiP6V5qex2DSB8jhOZpEbYbySEOvelm9UNXkyTRQgrk5Yd2IIE3c0Laxu2jzPFzG3Z9LMvPxPptkLtSPDgN6H/v1iRTXVsuyr48OzC1G0IipjYxHtACpGCM2jK05aX3sbI6LBPDUPG5iZ3oQQ1XjCuJZrVj/q21PDFC3FLHzp7TNY0vVjDHP4U5P1BeNnUGjj191rfm2T+sLAfDU4bNs5zlENbs/xLo6ZcryvIh4ZIl2pJbpZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1BMzENslg5tUThbA58GD/z4g5E8hfzoYg1jZHgvdhM=;
 b=CeraJnuK/9sGKhdP+JswgVDkeZAWDmOzKtl+ZdGF/1dPkDY89HWAbnpt6ArMchzEzxPrJO5COCOLJk+SbqFJq1Z4ubdNhYmHybFtzkpE/OYzGC8Sgm4yWZ48H17zGu1qZ7VBNRIaMGPA/kKkSpLWtNfG8X589680l3ohPHUugeA=
Received: from MW4PR04CA0353.namprd04.prod.outlook.com (2603:10b6:303:8a::28)
 by SA1PR12MB6776.namprd12.prod.outlook.com (2603:10b6:806:25b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 16:37:29 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::28) by MW4PR04CA0353.outlook.office365.com
 (2603:10b6:303:8a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 16:37:29 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:26 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/23] drm/amd/display: Check for PSR in no memory request case
Date: Fri, 9 Dec 2022 11:36:35 -0500
Message-ID: <20221209163647.25704-12-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|SA1PR12MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: 2abf4bec-3533-4d78-a205-08dada03a9a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ldsfrLiY4+5OZQWUkLNvOEg22y3yhZzvZOaryIPSp94DZKkieehlfv+LkaR7Hxg3hpQQb6yUaxSyg02x2qO0gpIMw/I2eXnL6F8UCJItaxKqmQ7jzEwOcGcUbn9nIKZhaVtwIClY4nDs8lcBmlGjDHKqLvEKeWBZ1wSZDkT1UKCsrl74JQVkG5Pne1fhDOCZ1cVYwdyQH1dxQ0SlXSx26Wqy4LxkG/4JVYH450fRrebwoDqaoTauka43Beyd/lqrOEbH23WEmICtPTkrMXQKTgR1YEjJpjWT7F81p01nnmpM2cfIJFriIttTplz2FUFZPAWf5ieogexHl9LlhoPlticqYE1RL8ZjrL1nyOj8y0fXGn265rxFwlKtPA0gMp1C/msJsPQmkcVlMFmghQ0bimmRyTGMKc9kYyv+wwHvhtKqP3HqMEReFoP1fU1pzh1n4g5MxhxiezXDPLgo7JPAPi0jz49oDznPOmdgtwiHKAa5EIdTQ/LhYswZo/zdcpc9teB55mgTE/dblD6ml9infjyMEx7S2nBvZzgAb8wlXNpuzWiVsA7Zkc20RGoB8U2lMb73MTLSKUqHEqEkVX7PnF2zg5puCBQEvxoXfBer4WaLnnX5NH+1qp+7UWteKsrDNBDUG5mOJDEHDhVdPCpF5WZ3qujk+KMntEVR37WcYK0MK8iZGnyl/84yyTOleeD+RGfxIpxW72F4HSDSsxcOV2TOXxStMp3YeSWjqhlLQw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(83380400001)(186003)(47076005)(336012)(40480700001)(16526019)(2616005)(1076003)(40460700003)(6666004)(26005)(426003)(8676002)(8936002)(5660300002)(36756003)(54906003)(70206006)(70586007)(41300700001)(356005)(82740400003)(82310400005)(478600001)(81166007)(4326008)(2906002)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:29.0417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abf4bec-3533-4d78-a205-08dada03a9a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6776
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Samson Tam <Samson.Tam@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

[Why]
When we have a PSR display, we will not be requesting data from memory anymore.
So we report back true for no memory request case.

[How]
Check for PSR by checking PSR version in link settings

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 9 +--------
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 3 ++-
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dc23801de071..6a6e4c844316 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8359,10 +8359,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
 			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
 		}
-<<<<<<< HEAD
-=======
-
->>>>>>> 667f52144b9a (drm/amd/display: phase3 mst hdcp for multiple displays)
+		
 		if (old_crtc_state)
 			pr_debug("old crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
 			old_crtc_state->enable,
@@ -8425,10 +8422,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 				DRM_MODE_CONTENT_PROTECTION_DESIRED)
 				enable_encryption = true;
 
-<<<<<<< HEAD
-
-=======
->>>>>>> 667f52144b9a (drm/amd/display: phase3 mst hdcp for multiple displays)
 			if (aconnector->dc_link && aconnector->dc_sink &&
 				aconnector->dc_link->type == dc_connection_mst_branch) {
 				struct hdcp_workqueue *hdcp_work = adev->dm.hdcp_workqueue;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index b8767be1e4c5..2f0ebe1f6c45 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -188,7 +188,8 @@ static bool dcn32_check_no_memory_request_for_cab(struct dc *dc)
 
     /* First, check no-memory-request case */
 	for (i = 0; i < dc->current_state->stream_count; i++) {
-		if (dc->current_state->stream_status[i].plane_count)
+		if ((dc->current_state->stream_status[i].plane_count) &&
+			(dc->current_state->streams[i]->link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED))
 			/* Fail eligibility on a visible stream */
 			break;
 	}
-- 
2.34.1

