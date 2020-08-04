Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC35C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 03:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 896DA206D4
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 03:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="udvF79BE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896DA206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20B046E419;
	Tue,  4 Aug 2020 03:32:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C5E6E419
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 03:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaGhHCvoH8+bShne/nzq6mT3Cex6MwIcMp/wSokayCL/rlS4AppTnhDM811bT3GKT5h/+RtZNbo1+MEU2DV5ll99wvEcn/fsMAn5ykug9EbXwagiGOQy4lv667AGHQd9oog1NXTCNBKJNGgkXLLuuhjzmAgU33fXKHYAaoo3aUpRG1t5Ak4KB5CaucHiFqSnfjTpOF1qL6wRns3+vC8X8D3P2+8Kb1NX4T/DezfJ+s4+KPhZOLGq79cHtK74tZ6AgGZgCieArU6StPdPCzfjNtDCZCK9CTfVMR50oQ6kdBoTjGzvWIwZ1h1P7IC7BBghbeMOAL7zA82q0cMUVmWslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17PCS59Nk9txhTWIkqK9PtWeUMPCn0ENGTMnbqYBXV8=;
 b=Ki53jnkDZMS9+zRpPeKhrtwC1WaLssQgm5plWklU0wSMwbHL1aurI1S5qCToZSzf/xSzcmJiDn0/nQ4ths/+BYbZ+AoQoQcTIh1B81S4K0aTZ2gqqL4/HpBidOqDGDjtp3kKIyrfI4H3oBW5r0PQfAQ2NgV1bm/QyyQ8nLzM9GO7L/8Lz62K04q/P0zk31cn/+Omr07oknjgCn2ycqJbFOHRtf5I3T0PvsmW4SPgjzHNXWBsoRF7akQ92WNuCdGAL3HXrgDUz/vM2jVoVDYmUWewxkeaG8qM3Q48ye01OztTiWJdC4ZzftoFH3+2MP1eGENRmd5VkVU9Xv9bHmbKyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17PCS59Nk9txhTWIkqK9PtWeUMPCn0ENGTMnbqYBXV8=;
 b=udvF79BE15Svc7YWf8GDEfaS96LRbOrrA8ZFq3HfWbYQoeMo6WdtimqFZNFu7m1E4j5VwFJyVe9p2vh3LjdHVzKd6eUlBDs+nT1MKgkLXwCTeuaOMhFmdNGQc1Pxx2ubPdqD53oyEH4jPbwQhoRbdiuPBoo14FVNAm5HHHM3lVk=
Received: from BN6PR1201CA0024.namprd12.prod.outlook.com
 (2603:10b6:405:4c::34) by DM5PR1201MB2488.namprd12.prod.outlook.com
 (2603:10b6:3:e1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Tue, 4 Aug
 2020 03:32:12 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::cf) by BN6PR1201CA0024.outlook.office365.com
 (2603:10b6:405:4c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Tue, 4 Aug 2020 03:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.17 via Frontend Transport; Tue, 4 Aug 2020 03:32:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 3 Aug 2020
 22:32:11 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 3 Aug 2020
 22:32:11 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 3 Aug 2020 22:32:09 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/mst: clean DP main link status only when unplug mst
 1st link
Date: Tue, 4 Aug 2020 11:29:27 +0800
Message-ID: <20200804032927.32274-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87f0f329-f74b-4e7e-8884-08d83826f9bf
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2488:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2488FBEE5684B6667DC1767BFC4A0@DM5PR1201MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:328;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0EuqO2MwLyz0FYITCktwFa1DLCZJHLNXGP0Zp5niTkW+wXkq1Xbn01m2anizZC/nc+APgLkg/YSu0SokcJFNncmKvwJWowQkEvYurCH8lHxymyTkVWyvWrBpGSA4fSBTtVSeOCib9Gm7R+SeUTka82i1Sbqx1NQHAM6dEihmfqiMtA3LYHklsV7m91BcUxYN7sqzzuX2r1A/7jQZ2K8qV5w6+DpFOF07NxvL2zH0b9kMd9jNLP2B5zc5uwMbCcM/+vtnPw53eIHGe7U4bx7Zf/rpW7XaIMjRYpL7VG5hMQuBy0uEZXYuInpzagZ59vXj3dXP7qKOIBAT+qo40HzKBx7bVmCif9bT8Ah+X0bFCFZsrwaqZ2WwpYNwuKsuqODDKqsXSnobx/4z+Ezg65Za7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966005)(6666004)(1076003)(82740400003)(81166007)(478600001)(356005)(4326008)(47076004)(5660300002)(2906002)(316002)(82310400002)(8676002)(54906003)(6916009)(70206006)(86362001)(83380400001)(70586007)(2616005)(186003)(336012)(36756003)(7696005)(26005)(8936002)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 03:32:12.2467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f0f329-f74b-4e7e-8884-08d83826f9bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2488
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
Cc: Rodrigo.Siqueira@amd.com, jerry.zuo@amd.com, hersenxs.wu@amd.com,
 Wayne Lin <Wayne.Lin@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas.Kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Under DP daisy chain scenario as below:

	Src - Monitor_1 - Monitor_2

If unplug 2nd Monitor_2 and plug in again, observe that Monitor_1
doesn't light up.

When unplug 2nd monitor, we clear the
dc_link->cur_link_settings.lane_count in dm_dp_destroy_mst_connector().
However this link status is a shared data structure by all connected mst
monitors. Although the 2nd monitor is gone, this link status should
still be retained for other connected mst monitors. Otherwise, when we
plug the 2nd monitor in again, we find out that main link is not trained
and do link training again. Payload ID Table for Monitor_1 is ruined and
we don't reallocate it.

[How]
In dm_dp_destroy_mst_connector(), only clean the cur_link_settings when
we no longer do mst mode.

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 2c10352fa514..526f29598403 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -415,7 +415,10 @@ static void dm_dp_destroy_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 					   aconnector->dc_sink);
 		dc_sink_release(aconnector->dc_sink);
 		aconnector->dc_sink = NULL;
-		aconnector->dc_link->cur_link_settings.lane_count = 0;
+		mutex_lock(&mgr->lock);
+		if (!mgr->mst_state)
+			aconnector->dc_link->cur_link_settings.lane_count = 0;
+		mutex_unlock(&mgr->lock);
 	}
 
 	drm_connector_unregister(connector);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
