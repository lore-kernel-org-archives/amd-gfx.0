Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03077C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 08:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C6C10E0D3;
	Wed,  1 Nov 2023 08:55:05 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4840C10E0D3
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 08:55:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YF6kgT2fNwaUyfUrOWoMeHWv1G+YP7haWIMBbHlv9GOrylLvUg11HI2zH6ubvX/cvJJCBpU3Qpn10sTd/dYA8rtS/unn2p2FQA4WK0X2Jtak1eHKYYJ2EZHggb7uyawZMgmhOoJ90z2LEoNDtVogYV3ophOZA1ufUnBWd5BbtCjYBnRTwwj7sQIAdgQJRb5mnXvibSZ45S3b9ym6lIwi0jJydIelzYagQjoKj3xQbQttGlkvuGzyR6av8ey0aF2F35rgH29NgtFYLEOkr+6o8F9xpeBvnal84aJvoXLDxGPumiq4PNjoXKjXW3VuH8nbC2GKSlYvj/ISu6fp+zr1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tsv0VO+aFXecMSi9kROOJfigv7C/uXvt3c+54rNLoyA=;
 b=F5o2DaqToEoFvwV2NvXXDmjqxde+vsHLisgp2UIOsSu9uuo19EzdqBI2rfjrBWI5YlwAUmy+kmVHJLzMrKAJrzj9h1UzeF8CnXVx1j6deXyoot7SX1mvg8U39epx1yZHXVCTKwgx8MTt9WL2P3M8ok/v+qhCv+xZZr/9k+Z5NxDSncSvJSrYK16JruhNs7uf4jYJQbO8gjmGiEptdrOPAV5nSZL7xuuCmCD9BJLGHB2Hj5zkEUecI0B1VztyE1WISb2B7KO+49qYhK9pkaSBxYM3ottVhWGhpex7MHiXBPndcojlNxCaBxcgVmUBU+GTafzmeEdLK6KiyeIc3Gqf+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tsv0VO+aFXecMSi9kROOJfigv7C/uXvt3c+54rNLoyA=;
 b=Sg3UIbG0p/h2NrgBNOZjn/R7Mvwe61wzlpBJREwY75xz8VijgXujDuY+IXT95opR5Ee5VcjKnWsZqSrpSXoaQXNCwim71OUfyOG6tvW6kHZoIfuu2CQHG2vNefR84nA8FuGi1BT95mA/7B3y61VQ22cxb1o9/9zlJ/U1hx0Hy8c=
Received: from SA0PR11CA0164.namprd11.prod.outlook.com (2603:10b6:806:1bb::19)
 by DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 08:54:59 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:1bb:cafe::78) by SA0PR11CA0164.outlook.office365.com
 (2603:10b6:806:1bb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 08:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 08:54:58 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 03:54:20 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: fix GRBM read timeout when do mes_self_test
Date: Wed, 1 Nov 2023 16:53:17 +0800
Message-ID: <20231101085317.609080-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DM8PR12MB5400:EE_
X-MS-Office365-Filtering-Correlation-Id: 156aab2a-d8f8-46d1-8f97-08dbdab83a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oiBhaM2wvrPje3Se9CDv6x+/BCFZLsqFtA1sZbGWkodGHHxfrvuwk5/Tv+TpSj97HmYF9mXMSVhT2lCH9ggHvo4au4DF31z+hqyHsWZyMG1ZSMnwU7dURmfRbqt+22guEMcrk83x/PYt5ovR05X3IP1Q3gw+zCbzWTdt/6iK92i53N/L44p/qKZNOn7lfghpCMb4z22iUFvJI8vOe2cExtvKFmxNLb9Hcqi5xL8Gs0kcfK+QKtkejeJXxpQKnKCFPxF0xtpQl2u6tMUIhRTsikeHKsITgfaty26bgk5SskwDXyjb3Gnon1DAve6OJmHGsVYvQzFEukx3IVYKJkEOZNZAYEHjCTCAedVmfqgVIM3eQ/S7gdZsW6zAREqGvVTs7bIyiYHTvzGZlCpq5K5wXvy9UD+q0P2QcSmMJmY15pSRlyis3VhemQIPQP6GFyoySHA7NEWRthpNrs53SGsWXBfNpEU0Yykb0HXFb/AdosNpRU111Lk3U7PiyGlJsQ2By3wO0hGPMYyUOcSxziqzVpoupES1WhWBhd758Qr4pwYgcjLAPjdeV/tlw4wvxpGxOZp6o8X6XSap9nUAuTT3GndtmAK2LHh3/Xw6dOffH/sqiKaGTbtXmouxxfhj2yib7+ygIYPhyr6TsL0UFU+nBCVRL64AAol7BuwpEPwl8T7dPaMd+Eq7IkixtruGDHl7bgz4jZ6BYvxGqQW1SS98tPdWnXWjwJpSgrtN41Kmvi2v8+Jnn1X0Rbd1n84RSMKE/fakxnSH/EAVDST+Zu8MdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(451199024)(1800799009)(82310400011)(64100799003)(186009)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(6916009)(70206006)(54906003)(70586007)(316002)(7696005)(6666004)(26005)(1076003)(426003)(336012)(16526019)(2616005)(82740400003)(356005)(36756003)(83380400001)(47076005)(81166007)(36860700001)(86362001)(478600001)(8676002)(8936002)(5660300002)(4326008)(41300700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 08:54:58.8866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 156aab2a-d8f8-46d1-8f97-08dbdab83a42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5400
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
index 70fe3b39c004..45280fb0e00c 100644
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
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
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

