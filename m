Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A990C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 08:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A26810E13F;
	Wed,  1 Nov 2023 08:46:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20DEC10E0D3
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 08:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ug8vNEcs+2fwF7IRAEDSLD6iqhVxnvpIP2sMXV4WJ3ODgRYzJMk8thE941a7GvToRnN8rszNn51VsiIE0zDn7HiSZ1RApSG/yGMjTnpUqUsU1dg3XLHpiMwQ3R98JzFCwx2fVJlyax60o/TEyjzu8VRrJUZuzQEz1wPNZgeUX0OTl3xgHona0FOZ2CRm1dMuJOFhWSXDVvSYjO52DElO25NdqAObVfxtjeumQGUlqm+NeHCqumM1WAFuHTIsYOkTCXMszwD/BUHDWc3zoRG55DxSmi3lkU+BFWcyOwMHgj3DpAi/xooQF9SNu/ZGhz+e7po4qZvJMltSo0JcGN8CmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HASm0ngao1zh1ZYLi8K7cAbQ+ND8E5pFZ9RWcpsn44Q=;
 b=fqMyDmB/gGfjhfd84s2BqYHFGkRQNAyXTFr3oE9pRL4lj/xcQov8OM+IGbINHhNXEVWA8vLcWRX4LrLeyiStDy0MFwJ/TG5GrL475GGN/jRJRMfl/FJx9DgCInAJISBXKIS2014qgoEap97dX7358UbzokaZ2WkKCc4Yqt16MbJ1cx8qfs8wrH2gj1mrUYM9sEBGM3Q8GKZ+oNlsuB0VUQ9HTp2Bo92p6oHEFkAG+Oz2FBg4Yrfbvb9P7RsVict4DpIB4XlsBIUiBl9lElcs12qhy5F7otnfZlaaMcPiLKTnL5MknlVZsomuTspudnVFH5pArb5xDWVNg0EuAkABoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HASm0ngao1zh1ZYLi8K7cAbQ+ND8E5pFZ9RWcpsn44Q=;
 b=VbjWMZZZVus8lQqfEXPmdZjSN1nrvOpJ4VjXPBFV8JKSDGVu99JQlkLNkz/RfwfjEOvV3ORz9+8vSoyfb7eq531kxT84/QKwnxeRwmnDbWV4Umsw3i6yNCK3kFF44lFX7fckphmq3sjGJrMPQbWkMZn/SdI7JLhb6N9A8cctOG4=
Received: from PH7PR13CA0022.namprd13.prod.outlook.com (2603:10b6:510:174::24)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Wed, 1 Nov
 2023 08:46:34 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::86) by PH7PR13CA0022.outlook.office365.com
 (2603:10b6:510:174::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 08:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 08:46:33 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 03:46:31 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix GRBM read timeout when do mes_self_test
Date: Wed, 1 Nov 2023 16:45:47 +0800
Message-ID: <20231101084547.608432-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: dbaea9f6-9477-4837-77ba-08dbdab70d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvXZBSsBc70n/uqocGfx9WciNKwbZrFHlbthJ/ctEg54ZNB6uiBRmdHbZ0PAQqVZlJJnfBgeFUSst/d50jDBLdj2cbzhuPOfxtw1wFRDnIbji98O204wWA2J3m9Oc/k+GBJ4EveMosDl4rjiUwEtmF8hrsytvClZD6f7X7lb1v7sPjFuXY1Nw4FNa0r/X/p1J8Dvsa8yqu4GA86kzRuPmzxwfBmCRUXgQadcPnI6REztfugu0ooNJ8gxG7wiAJJeHoIhVGSU4r+XagMTxfaiZHeKOWNYq7luHbYT3meOhCOoS0o3xLUG1Y/UWQXKSsx2U5TN4Btx8CCmc1SRve71m3/71JoJAc94SbzwIsL+jYwNdB5y6mBPJEF1SnS5XauvgZoSIyGIXyaJIKqCMXpzKf9m1HWzOjwKeucdtS4+AQUS5WACpg5u8H4Qyq3Xt4Bg3HNztsMfh1vpFSyIeORkBhff6zK4l2resXcQotfzEaOOTzK2yueFZsYDTFNxQRPoEBSORhVYPEGUymiiGpvL95yyHgZaNnKGESHn6F3BSl9ZwW/JL9gXi9mDgZMt1Z0KwxZ5GiDY6Ot5DHZdlC9yh5+R+esj1PMN10Dq+IUr9OHWutL9od73PfDepdlInviWJAn227047oI/xfT30Rw+Y2suG8PtRDRW7eSi3OaOZN8ZlBF3yM4+lF/1TqBdpQdv33fzeMzZ9hYtOh1dAtaTEVSHsJAF3HLtS+9x3LlSTebzGgAcamW3rZNmrEdjidT56ukHWT+TgCGQ+gMOvXB7xw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(82310400011)(186009)(36840700001)(40470700004)(46966006)(2906002)(86362001)(41300700001)(40460700003)(8676002)(4326008)(8936002)(5660300002)(36756003)(478600001)(40480700001)(47076005)(7696005)(6666004)(70586007)(1076003)(81166007)(54906003)(6916009)(316002)(26005)(426003)(16526019)(70206006)(36860700001)(336012)(82740400003)(83380400001)(2616005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 08:46:33.8893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbaea9f6-9477-4837-77ba-08dbdab70d44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Jack.Xiao@amd.com,
 Tim Huang <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use a proper MEID to make sure the CP_HQD_* and CP_GFX_HQD_* registers
can be touched when initialize the compute and gfx mqd in mes_self_test.
Otherwise, we expect no response from CP and an GRBM eventual timeout.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 70fe3b39c004..5ff76163ea27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -556,8 +556,20 @@ static void amdgpu_mes_queue_init_mqd(struct amdgpu_device *adev,
 	mqd_prop.hqd_queue_priority = p->hqd_queue_priority;
 	mqd_prop.hqd_active = false;
 
+	if (p->queue_type == AMDGPU_RING_TYPE_GFX ||
+	    p->queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+		mutex_lock(&adev->srbm_mutex);
+		amdgpu_gfx_select_me_pipe_q(adev, p->ring->me, p->ring->pipe, 0, 0, 0);
+	}
+
 	mqd_mgr->init_mqd(adev, q->mqd_cpu_ptr, &mqd_prop);
 
+	if (p->queue_type == AMDGPU_RING_TYPE_GFX ||
+	    p->queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+		mutex_unlock(&adev->srbm_mutex);
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+	}
+
 	amdgpu_bo_unreserve(q->mqd_obj);
 }
 
@@ -993,9 +1005,13 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 	switch (queue_type) {
 	case AMDGPU_RING_TYPE_GFX:
 		ring->funcs = adev->gfx.gfx_ring[0].funcs;
+		ring->me = adev->gfx.gfx_ring[0].me;
+		ring->pipe = adev->gfx.gfx_ring[0].pipe;
 		break;
 	case AMDGPU_RING_TYPE_COMPUTE:
 		ring->funcs = adev->gfx.compute_ring[0].funcs;
+		ring->me = adev->gfx.compute_ring[0].me;
+		ring->pipe = adev->gfx.compute_ring[0].pipe;
 		break;
 	case AMDGPU_RING_TYPE_SDMA:
 		ring->funcs = adev->sdma.instance[0].ring.funcs;
-- 
2.39.2

