Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C78BC001DB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 03:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A1A410E146;
	Tue, 15 Aug 2023 03:50:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2FE810E146
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 03:50:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWLbuc7S6VyvrGqmsDuSNofPdre7qzvTTPaKYGkl4g+3c5xu5fgoPO1QB1qTRDTS5NcCAeE6y0KFh2ZukKi/RDD6dZRmsosPsEpwQixDgUnKE6ZaMfrzgfyfsquMMvPrgIfIOjoCqaRFjz7cpGmIws0z7TxgDvF9cisq6Mt4rojBVEYe6tPj37xqnm9+eIRDPyMF8gmhOcSfq3TodTqFgfXA4vEB1Pn9xZ1m1Z5LnFV8jxKkA/3V0Er0zCeuyG1NUyz5QZ7O9+pLHMbXquSs+udZMT31gpvitg9lr3oRSt3qy9Ds/GLDqZ+kdut+HfF9hgyJFoQuWO10KFKuFKx+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNiBJc6OXbIhWMVD3P4Q4aTLNYy8rZedPY+SRXa0UD0=;
 b=Z7v/4P88DEWZysXaKd8mOElVFcy/qcwMOU0Iwk4lfdaCD89C2ca4Ox38aGsYNNA1mICWcEqulQrak/dGb7VDj86Fnd4mAsWbk4hZUjLna6y4a3wJsIfFm0U8KadVyVd/fNOdn4Vjw8/pdHOoyzkIT9K+GdOn5bd0TxJ7Su7INgqXB2Lz6KYpShEnpifDjsoWQ4+jytCtfWMDkNzaP82Gi28gSP+0KVpVSB78RQBtSystkTaLIQng5COolljuLbwQQhhpvyEeCO8l4Ad62DmqxG+/eKpQn78X9ACiP0LtWWCRS690SNW6dcl1+YV+Cxyi11YzLllAgGIMRW2sC7Jh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNiBJc6OXbIhWMVD3P4Q4aTLNYy8rZedPY+SRXa0UD0=;
 b=Yc6FHu1P7aSszZXDBERJYVCMV3W1d4D+I+Dq7eEH7Enw14SCWjnLlcZCOf/B4SB5yqI+lM+sPn9Km7lMpvKB2weqXA7QucDcqPRInRDiRjUZYoAoDWU87ZohzbqsGF6/vBCuhFV7Q/lg2ZkPMltC/g6Eu4Ec8B5O2ilbHzOBYCY=
Received: from DM6PR13CA0053.namprd13.prod.outlook.com (2603:10b6:5:134::30)
 by BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 03:50:33 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::2e) by DM6PR13CA0053.outlook.office365.com
 (2603:10b6:5:134::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.13 via Frontend
 Transport; Tue, 15 Aug 2023 03:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 03:50:32 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 22:50:26 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd: flush any delayed gfxoff on suspend entry
Date: Tue, 15 Aug 2023 11:47:10 +0800
Message-ID: <20230815034710.3865829-2-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815034710.3865829-1-Tim.Huang@amd.com>
References: <20230815034710.3865829-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT066:EE_|BN9PR12MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: eccebb9b-9fe9-4e8c-5d22-08db9d42c686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DGJCfn617vACH1KQa3eHtuoEY7shVzwP8sf0H6Aj+ItFWK/CiFAfw25PyMGIaxUagI1aPWgJrIQsLZmLO9UwlxCVGP4PmST5/aIU/yK171YJCgcoZE10u1WNNe8GF3KGaKJd5v0Ek2mDeVFMEWn1Kjxp2AdwbRMoe/qTbipMbeqHLMHVMSWrXOee3fgCdl8tJWXUp9TUoUWWcEXu8eRE+5WZ+WAIVPEGHkxuCIRBahsrGri+k8Y+h2zddt/vl4t0PUTE1U4Fk2qLwYoomRfnLlg5ABMgxFy3kbmpfv6Bww/w8DFZbx+L+YtntgSop7Y1YQG+2p+CG9CREe26NnFoM4rVqgAcvZWUtMsO+5BiVRaxiXjYWRy2ey4DsQqTcST8hAr4muarXVaHLLxvJH5qxz+qR8NE2d/xkuejaIRjT122sLlx68NIC3sRUp0IpzsKwCQj9bczgAeUbzo3Pak97HJ5F3uflfhNs8J/UXGspZPh6jSns/kY0MT578nb5bfp7GIq15L8Lx2l6W7ZiZ5sNQ+TIe5EpymjzQx4ZPkxAn19TAUKutP6ezzPAOLFGvqIHcLY4sTRptOuYvkAPMQDJmgJCA5oS0VswU5rUWizwbEMmqvUz3MhNw2kiUUuxhuO0TJSHdqgfdhkGO7CyR2XWYv51mF7yYCqm9TpcA0M0OI8ZQCuBH/iC8Z//bZZRI9xlGfhzUd7ZDkKEuTKnSUEaM1ThVFVGwv8LDGZ00j2pAcmX/5dG/dAvBDYbl72sCtuZcffdS5BpNNAu4A5B7a00w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(82310400008)(451199021)(1800799006)(186006)(36840700001)(40470700004)(46966006)(40480700001)(54906003)(7696005)(6666004)(478600001)(40460700003)(81166007)(356005)(82740400003)(2906002)(5660300002)(36756003)(15650500001)(86362001)(4326008)(6916009)(70586007)(70206006)(41300700001)(336012)(8936002)(8676002)(316002)(16526019)(1076003)(26005)(36860700001)(83380400001)(47076005)(426003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 03:50:32.6372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eccebb9b-9fe9-4e8c-5d22-08db9d42c686
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5259
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, lijo.lazar@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>, Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mario Limonciello <mario.limonciello@amd.com>

DCN 3.1.4 is reported to hang on s2idle entry if graphics activity
is happening during entry.  This is because GFXOFF was scheduled as
delayed but RLC gets disabled in s2idle entry sequence which will
hang GFX IP if not already in GFXOFF.

To help this problem, flush any delayed work for GFXOFF early in
s2idle entry sequence to ensure that it's off when RLC is changed.

commit 3964b0c2e843 ("drm/amdgpu: complete gfxoff allow signal during
suspend without delay") modified power gating flow so that if called
in s0ix that it ensured that GFXOFF wasn't put in work queue but
instead processed immediately.

This is dead code due to commit 5d70a549d00d ("drm/amdgpu: skip
CG/PG for gfx during S0ix") because GFXOFF will now not be explicitly
called as part of the suspend entry code.  Remove that dead code.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 9 +--------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1b3bd77d82da..e77f048c99d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4160,6 +4160,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, true);
 
 	cancel_delayed_work_sync(&adev->delayed_init_work);
+	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
 
 	amdgpu_ras_suspend(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c76b6bfc4dab..2382921710ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -700,15 +700,8 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 
 		if (adev->gfx.gfx_off_req_count == 0 &&
 		    !adev->gfx.gfx_off_state) {
-			/* If going to s2idle, no need to wait */
-			if (adev->in_s0ix) {
-				if (!amdgpu_dpm_set_powergating_by_smu(adev,
-						AMD_IP_BLOCK_TYPE_GFX, true))
-					adev->gfx.gfx_off_state = true;
-			} else {
-				schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
+			schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
 					      delay);
-			}
 		}
 	} else {
 		if (adev->gfx.gfx_off_req_count == 0) {
-- 
2.34.1

