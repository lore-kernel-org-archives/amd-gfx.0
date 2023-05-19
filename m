Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD49C77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 05:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B224710E5C7;
	Fri, 19 May 2023 05:51:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDED710E5C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 05:51:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjZVMzgwa9SE9gg1bXq061dF+niclhZthv0MOT+VMuwD+sHa7Lx/16hWgUkqg1WMs6xxFm2sDC1/Gt2DYXPEWcHyKQ1cBnI84a24ceiWn7+9oTaP/nqqh7nhqOHAPu2IdMOq7tK9bHDkqwZhrg1NRjlyEZ2eC2Xo8xZGRYNOsu3ZRneajC3HD1IykuEm1mH9P8C6OPSBONdFqcCySGVGDeIZNm0Q2XneWeGPZyzVlyx73eUMlEgkifO5zUEIHhFWK97DUvAunXhQom/65GpzgMd+SE9nn3Xr9WxjC/CBPn1DzLk2DKnGPOB+a/A2mcLfbkINyAZ3+/dFYXTq8c7bfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCSTz6/P3bgZShXaezm23XfmX/dYr2HHp8aBgjEL9uM=;
 b=ADM8XBcqAI13/dyrDUlGkt0X9AauVTV0iUX1aTUDUk+Do7f11fjiF27v374gmy0NsjKNLlTnLBAZoMMo8ycNCs699XBQCOqHFeGI+JdMlUR1tor3w/jWkwy/V3ZjEnE410Bnxunnld1w/vKMSGhXPwgXhXEBUE3oy5f1RoU/OD6XjgF6LoS3RvkNIiyqMyf1cPFxu1rQ0KSgjr+PYqYrhNdOVxlwlu6m5OpY09cFfO+Hv8B1WXdi+8Ep6ZjVnmPKqzPct3jgdRVMAJbPxfRs8muzRs51BscaXA1gU2+jFUrN5ecOZWA/Yw6hux9X999hMjD2qF33awlG6YRZi5DfYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCSTz6/P3bgZShXaezm23XfmX/dYr2HHp8aBgjEL9uM=;
 b=zPau2w14VPaJ0+qc626PEmOpw0JE22lT+nQFE2VS+S8vL8FU7foWr8BWUxO/iw0gWp/tH1BdgUkAcHjN82wcMnl/DJGSIYJMLenAp6Y3XzH47KWGhrKZQyoUzZa1YwI5/2boR/prJQny7YhGhMBFc7p/h8IeQ4gMLY+CBEpV33Q=
Received: from YT4PR01CA0417.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:10b::21)
 by MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 05:51:37 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:b01:10b:cafe::34) by YT4PR01CA0417.outlook.office365.com
 (2603:10b6:b01:10b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Fri, 19 May 2023 05:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 05:51:36 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 00:51:33 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Luben Tuikov <luben.tuikov@amd.com>
Subject: [PATCH] drm/amdgpu: Fix uninitialized variable in gfx_v9_4_3_cp_resume
Date: Fri, 19 May 2023 11:21:16 +0530
Message-ID: <20230519055116.96673-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT025:EE_|MN2PR12MB4549:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb54fd9-e625-4140-86db-08db582d1baa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mHYG/X4K7veUdcT7sF7Ns5Mpzn6hx3NadWJUdoNHJIQFWfF9mTCG7byAxtk/kmiTh2pvIaVOKUbAI8eR5uu9BQLDchiNFL2h9I0FPMRoaI8XI1W3vq0+VDUstHGsRnSRmS3pZvIwpdgp9welJMEr5BuU8rTPbDPZG0pzZKJ/0uOEev/lX+NeZ4J2cBnnw6iJy00CqdyCFb4vGh3cE6am1i45nzdRpk3qMNMLtqxV6y7irtwhJ4dUMg5jOHI/V97CHmnLdZ5Y3Sbzo+QvaEQK0jy/BUGws+QFGo08+zsFZIU8WPxSBSAI51b/2yyji4CXt1ltPm1BOMwTktc65jBGbFmQSUp4BlVpMLBmDH5OAeAHtljPljOpH3ldYDZ6lEw7hs21RyiuukNe3tAsD7HCy72q3lo937Xhd9xAC5kA6yiEsoWGi+Up2o/SKda24M/SbjVaEKw17A5EhtmUN+xpPCJGQ3eUbWs7QB+/HLHq0mrJRCiu06bop6q45mOFNifaBz+B6EtCme8Mbabinbd3gLTr0Bj4TBBcSUHWvj+Y6NTNHXENew6APJ2lO95T3XKgskjEPIJk8I5oubr5UbG2mLm5NNuEnXQkAL3dzLCweG/Eovw6811Li9yr8xlz9SsmUvV292pEKfAPFLiGYmZfC8OSuEF1R+DbPhFnb6UzoZQKHzf2A0i3DuX9q/fmcQKYNXyGFyrmNinxkSgDepZPYLMDCUUP05QEDJDXPrqjxX+7If38zdWDg6A0Rky79QyDYF5YWLWPRcE+iyCB0ky4bQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(1076003)(26005)(47076005)(36860700001)(36756003)(2616005)(66574015)(426003)(336012)(83380400001)(40480700001)(81166007)(86362001)(82310400005)(82740400003)(356005)(16526019)(186003)(54906003)(110136005)(44832011)(2906002)(8676002)(8936002)(316002)(41300700001)(478600001)(5660300002)(70586007)(6636002)(70206006)(4326008)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 05:51:36.2271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb54fd9-e625-4140-86db-08db582d1baa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4549
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1925:6: error: variable 'r' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
        if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1931:6: note: uninitialized use occurs here
        if (r)
            ^
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1925:2: note: remove the 'if' if its condition is always true
        if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1923:7: note: initialize the variable 'r' to silence this warning
        int r, i, num_xcc;
             ^
              = 0
1 error generated.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index e5cfb3adb3b3..d4c9b156474e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1920,22 +1920,24 @@ static int gfx_v9_4_3_xcc_cp_resume(struct amdgpu_device *adev, int xcc_id)
 
 static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 {
-	int r, i, num_xcc;
+	int i, num_xcc;
 
 	if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
 					    AMDGPU_XCP_FL_NONE) ==
 	    AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
-		r = amdgpu_xcp_switch_partition_mode(adev->xcp_mgr,
-						     amdgpu_user_partt_mode);
+		amdgpu_xcp_switch_partition_mode(adev->xcp_mgr,
+						 amdgpu_user_partt_mode);
 
-	if (r)
-		return r;
+	if (amdgpu_xcp_switch_partition_mode(adev->xcp_mgr,
+					     amdgpu_user_partt_mode))
+		return amdgpu_xcp_switch_partition_mode(adev->xcp_mgr,
+							amdgpu_user_partt_mode);
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
-		r = gfx_v9_4_3_xcc_cp_resume(adev, i);
-		if (r)
-			return r;
+		gfx_v9_4_3_xcc_cp_resume(adev, i);
+		if (gfx_v9_4_3_xcc_cp_resume(adev, i))
+			return gfx_v9_4_3_xcc_cp_resume(adev, i);
 	}
 
 	return 0;
-- 
2.25.1

