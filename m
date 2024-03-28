Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C214DCD11DD
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FBAC10E588;
	Thu, 28 Mar 2024 19:51:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CKRYhyeB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 928B510F775
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8ER1qt219RgeiVktzfTWwa07n19yMQvHGwwcFS5qFzYu4UGe/oyxBr7whs1jeP/o53QqZQDnkDzGUZWHmcn3hEg+qcAJHjJDne0rKOdmzyz7Z669fAZCcJVy5mzLife3R/q5+YGt2rybfWO33S+71pcqOPt3n/BQd9SwSqYp8dpcrmgp59rX59dHZ2mB4Ea+49upGWpzPiyWe9cgLgrBWfkVzscM2mdRNNiWps0jDSPMfHggLWfCzeZVJFyvrCLvys43awW1+tLUHJusmVNyFdKuisBrwvxodKM1ri319rspicsXAwpx/pgWhhRygxhru0nPKOYPi54FwF20WsW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6OyMdvFcb3pZBgB+94HnE7xPUIDSQwCq7e9kNyo+24=;
 b=eRblqAlZA3N74GrIU0MTO0YU8b5+Q7foUn5t/tId3lzWo/dEfPxfWhJ+uVIUDkPL2KU9in0k6FtYjFomJvU5f0TbZoLPcFryDnQ6Kn5/7FGYPJxdB0Rbb5AqMYJYq1ZJwQW3GkF6VfdNv1+PYCxUrQMbAwjCrKWk7dPb+zvwVqvNspmIDZ+8VrQA8V/eTtwy9YbP7zxaaJPQkLLVsoN0iGAA2rkCUKfOXFG2lTSn4+4DcEVfyDCs82YnWY6cntqMvNDlD2kmkoPo8ib5BkdI2PNjlyvSGpWYDP5SHI74oz7lDvhPceiR6vpzGdEOG4IDfVceSpfCvMabOr/6AX5Omg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6OyMdvFcb3pZBgB+94HnE7xPUIDSQwCq7e9kNyo+24=;
 b=CKRYhyeBYXTpmUzh3f0fPwaMJZDR92X5KHTO/yZq7mUoAgdyWIY/HmUa3C1kaeDDC85ykafzFEfOe603ujsz7rFkqLSXPMIM26z9qoqxGYRESzkBy5Y1KrD4PEs9EDtUwazPnEVFs+Aab5EqNtzrjTy2NrTe1ZC17OX6+25uUzA=
Received: from SJ0PR03CA0355.namprd03.prod.outlook.com (2603:10b6:a03:39c::30)
 by CY5PR12MB6647.namprd12.prod.outlook.com (2603:10b6:930:40::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 19:51:52 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::be) by SJ0PR03CA0355.outlook.office365.com
 (2603:10b6:a03:39c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:50 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:50 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:39 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Alex Hung
 <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Rodrigo
 Siqueira" <rodrigo.siqueira@amd.com>
Subject: [PATCH 16/43] drm/amd/display: Skip on writeback when it's not
 applicable
Date: Thu, 28 Mar 2024 15:50:20 -0400
Message-ID: <20240328195047.2843715-17-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CY5PR12MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a1db6a1-4f8e-4bf6-bb2f-08dc4f608367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qd+zIqkUbD+bFE0jnfCEggWYWRH3w352LVQyyr7vKepTOY2VHem1Ovtw7hnLcCjUwVpbbX22dVRml7tH9hqK0mFubEle2UYPwk5ugavNO2KVvsZL4XVZOkRtbtzPu6RlQYLjM4CYmZC9LCo20z15ZI3nfc43N7/pLPjQbe0Xg6Kd3aLQm5QCpJoy9p5tSZLYLTKNzdIfudR3xF11ma1UE2ol0detgCVe8UP1RiYr8t8V2ebxyeH72u2Y5DtPmyzW6Qd+iLHr1dtPd39T1OTrIDwDyyEdCh3lpfQa5BGbFOQLsxPaj87Ae/hvHFpcSw2cM6b46F6IKkRpBRIvgh/7cdq3/p+Zc1dToLFKg8o/DuZ71+C9j/IXjB1XF+bvnYJkl9ISxMfRFgOkxq9PC1wKoZH0/lmArN9GyHW/cmyT/JUrg/8jFzyPHjuW3NQT9g/WMUFTZ/gTq6DlRtt8everfNidnKhW33AE4EVI+6kuio4XPdGyUbh6dJr1C2kZdsnmLQlRQG9I2B51+NY9u2gdtEmMt1r5vlnnJYBWV0SHe/Ga1q6rqdu+ya8m/grL1lp71u86+IhsrYE6SZscC7VQsp26gyiS4bKr95PePlzl8NLLYldNddKGHVs5lD6w/X9K+aiJZNNYSUKWqiEjm1qXKLzVzLsXsSTR+cnlVkEWyP0pxmsCvGIOI7aMiSV41W+n6+VukLtTzJ7GrKfgvt3iQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:51.7492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1db6a1-4f8e-4bf6-bb2f-08dc4f608367
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6647
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[WHY]
dynamic memory safety error detector (KASAN) catches and generates error
messages "BUG: KASAN: slab-out-of-bounds" as writeback connector does not
support certain features which are not initialized.

[HOW]
Skip them when connector type is DRM_MODE_CONNECTOR_WRITEBACK.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3199

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d98632f37c0d..08ca842af727 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3047,6 +3047,10 @@ static int dm_resume(void *handle)
 	/* Do mst topology probing after resuming cached state*/
 	drm_connector_list_iter_begin(ddev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (aconnector->dc_link->type != dc_connection_mst_branch ||
 		    aconnector->mst_root)
@@ -5926,6 +5930,9 @@ get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
 		&aconnector->base.probed_modes :
 		&aconnector->base.modes;
 
+	if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+		return NULL;
+
 	if (aconnector->freesync_vid_base.clock != 0)
 		return &aconnector->freesync_vid_base;
 
@@ -8768,10 +8775,10 @@ static void amdgpu_dm_commit_audio(struct drm_device *dev,
 		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
 			continue;
 
+notify:
 		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
 			continue;
 
-notify:
 		aconnector = to_amdgpu_dm_connector(connector);
 
 		mutex_lock(&adev->dm.audio_lock);
-- 
2.34.1

