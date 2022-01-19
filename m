Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D16C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 08:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF4AA10E817;
	Wed, 19 Jan 2022 08:40:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0790610E817
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 08:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0qtJo/dbQj9Wx/Yv//TXGPq16PxUakF9tDjjfcAg06S16XI+lCidROCpaFgNcy0kdM86SULWpI3h5xjUvxSDxhd3WL+0n2m8JosBdPj0T3A8+ghIWaVCHDa7fxLR8EEOSYdOnuSXnsv7UdDU1BjJaENlkdlOmTWalFFSPe1YSmgM45THh1L1VRmU1KSOcVbHUXxq3mzP7fKmRzMf49luzHF9COMJopEGIywxyFvryFC0MLHfa2wSEpIUYZIxHJwnAsYoFMWT21ZUEQ25q71oSx7U3cQLfLr/05WiJdcDxwoeJwT49mMx31MIlr3YdygX6I8rmX6o765nUySVcTV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7vvvVEiQ5OHPwoFUY67y/AKv7Tw60fwUGCA30dQoX8=;
 b=Bj0grxJxjtSzfUIMqmOtPJ3uQaC8oGtWe63f7mSHiwXIn97fHvtUl8BP/8xsPgzBn4iSJdaHpVEi8QaqXsmyo3fYKCM6UXYpJOVCFiL5urXlDv9UXeaeYjgdHihc0dy52o3nydiPRqGG12zSfDVQYwASRYO3OOvh7nOqzT4BCPlL7mDpViXnMXq7ptHMKVzZQN8WXmWkeBSGeWWSIx4sVHofoYJF45uz0bBTKFjr9S141xiNVrPcwNSvCiXnohR1vlExhf6Et53bvc9jStNHCNeZV9kQ4DZMtB85k0lljPleYeJnY2YKiFN38z2r8rC99FtxZ6nQdHecpXzCSa77ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7vvvVEiQ5OHPwoFUY67y/AKv7Tw60fwUGCA30dQoX8=;
 b=Z/VczvMwD5UPMFw16xzX6fOTktE2mDHinryA3PWLsY1bRPJiY3MFOpn6LPa7+bgKKL3srFtAWQlz2EyTy/VIs1ET034ILH6BHGX1N6tZfhnZm8V/oK72uGTZYm+5vPobDyPv++/oD6yOi4/g6NbAZqHJJXMy3+B0e2ruHCQ3Jd4=
Received: from MW4P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::21)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 08:25:46 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::93) by MW4P222CA0016.outlook.office365.com
 (2603:10b6:303:114::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Wed, 19 Jan 2022 08:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 08:25:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 02:25:44 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 02:25:44 -0600
Received: from wayne-Celadon-CZN.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18
 via Frontend Transport; Wed, 19 Jan 2022 02:25:35 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] drm/amd/display: Don't update drm connector when read
 local EDID
Date: Wed, 19 Jan 2022 16:24:43 +0800
Message-ID: <20220119082443.1046810-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119082443.1046810-1-Wayne.Lin@amd.com>
References: <20220119082443.1046810-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 823783f4-7031-4e72-c325-08d9db254a80
X-MS-TrafficTypeDiagnostic: DM6PR12MB4404:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4404795397986046D3CDF125FC599@DM6PR12MB4404.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tSwsm3mPxzCIS2NG+GCSBFBFlQDtc/o+dst0p1YImiKSW/IS2G+dGRVvXu185crsXk+y+nbU95MORkGlNMwbg0+qbPxNMF01F3158pYoQ3WvWMr76IrvGJIEP7BM0lc5/xnrEiXp6MKCVvUo1S0aCTRCVyCp09QbSMeLzpnB9BugE63MJ5Cs0pEuL35ya9Skxrsb3sV5Mp7uFEGkizCWGuTgEWIJrhzcqhEYdr3/DBuxzd6GJOScV/OOZ6K4rPdbWOw+1vrs/qdVq3Ll0azECFZJwUUiWtCCUdz2kiYHbgZHkdN3gJ2j0rKqsaWQZMKG6pfCWb3DijqkCFTPCao+hFj/P4xR8sy2/kP5NMKLDqk5iC94XllNaT9at+UPfVaP0ubRIkhNsGIDJohkGhvC2YcfkK5RrKSLuDsxyT8GAzFOzQ/QAZXEunMQkAwK17pHGHXj5AeAOXM6Ob21o/QVaLRFBGn2WBbArTyfjZ24l3s4IXWhdDxivnn4nAz4hKo10Ly1fvgui42d/dTPK1qLW/e8Z9iymRSBjGbuH8QYkmfH/GfgwSzTKH9VC2Zp0+ExOM8G2d1TlPcjV3WXG/nj6pzAoUfx0MVX3+i2IGAtPBT5Fgorp+vu2LGueBWb3GIWkmqp20dpJPsmAwisONefX+kfBjueeHw+qb1pp9lueEuA6rr3qTBkBfsuDngYYB57fav5D/XjUi9oN//RC7yxECWlgoCl4l8arj5lD+MWfAOgN+jNWw+Linto0MF/HRMNyZFaU3SMx0yYrT3fUuKvbSk0IBTdzYsQFaiJ72QHKXc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(7696005)(4326008)(336012)(8936002)(426003)(2616005)(316002)(54906003)(8676002)(81166007)(83380400001)(1076003)(47076005)(356005)(6666004)(70206006)(40460700001)(82310400004)(86362001)(36860700001)(2906002)(186003)(36756003)(508600001)(26005)(70586007)(6916009)(15650500001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 08:25:45.8142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 823783f4-7031-4e72-c325-08d9db254a80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Currently, when we're tentatively detecting link configuration under mst
case, we will wrongly notify a none existing stream sink to drm layer.

It's due to we'll call amdgpu_dm_update_connector_after_detect() within
dm_helpers_read_local_edid() to update connector when we're still under
tentative detection procedure.

[How]
dm_helpers_read_local_edid() was designed to do "read" only. Don't update
drm connector status when we're still under detection process.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index d6b8a360c33f..03a04b1e37f2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -648,14 +648,6 @@ enum dc_edid_status dm_helpers_read_local_edid(
 		/* We don't need the original edid anymore */
 		kfree(edid);
 
-		/* connector->display_info is parsed from EDID and saved
-		 * into drm_connector->display_info
-		 *
-		 * drm_connector->display_info will be used by amdgpu_dm funcs,
-		 * like fill_stream_properties_from_drm_display_mode
-		 */
-		amdgpu_dm_update_connector_after_detect(aconnector);
-
 		edid_status = dm_helpers_parse_edid_caps(
 						link,
 						&sink->dc_edid,
-- 
2.25.1

