Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426B1ECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 18:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5266110E3A3;
	Tue, 30 Aug 2022 18:40:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 294E510E374
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 18:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWkkV1A0bL/+MVF5Q0CI6eYvgzcilLoX1FUJuo4X0HXerNP0oYYNmcJQJT71wrlegy/uadjz78Aelk+TqNFcC+NpmXaIx3ghHSpdTd7+WQgpOTIwC3tY7EEkFWbBtaHXp8EAjkz990m/Jhfr5dUfjgavweKu+lUFTxFa3cHPnTAQsntlAy2xGa8JlPim7qM/1yGdjOPEHykEJ8rzDwxRtjngeU+XUv6WUDqwB2pSsGKO/mYUtXqrIL4l8ES8U9zW86KwIgdeBgmWy40uF3YV3Gx77O34XV65W5rPNhvEBOYmxEUFllUfLwYAZJ0fR1VZWV/3Tpb8IjOWe01DP7ivrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5ECT+z14V3FK3HROiAw+I6rVL4ZH6VrVZX4gW42Wpg=;
 b=hTKJzsdPlwRynE+EIaOnY38jdw7xvDU+nYUfpmfbtbHCfBo+7gxbjC0ixgMGlyxb1lLkIwWiRgRvSITMuOx2iealnuExLH5NarBnuCWTJQw5SWgNDmXEuJkT5DJ0i3UeDrffUKuIt/Zi8zppdjCDmBg+fxpxy4FFn0WbNpO88+TdIbBR/uGrmaCaDxgkz3gE6BwwYzJB0Fpa76SXtWT7U7VBShvGw+ReCBibZjjfs+UUv0ReaBuQU+EFin0+rmMmGmPDDWx7m8Bo/oEnoxlgkh+YJiVpr4KMJFH6qp0PKX4hRY0rf2vxXkeFJ611G2biepcbEzGutZsVVY4YsDKbcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5ECT+z14V3FK3HROiAw+I6rVL4ZH6VrVZX4gW42Wpg=;
 b=adAnZYDK1KnX5KwAgHpTKPmQZ+vZN2Ji3Shxf3MSBG5h9bjKlMvnE3VwvMvFF5+AP0jRa76y1KthjqoCrvqpnsYbla+nfcsGj3m9Q/WiS5wpTJarn3fInQ1aXWdFAvVdWFcjr8DA/15dsr4XKGhMhuY6i69L40Mj1ZtloAiaogE=
Received: from DM6PR02CA0040.namprd02.prod.outlook.com (2603:10b6:5:177::17)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 18:40:36 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::c) by DM6PR02CA0040.outlook.office365.com
 (2603:10b6:5:177::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Tue, 30 Aug 2022 18:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 30 Aug 2022 18:40:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 13:40:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/19] drm/amdgpu: Skip program SDMA0_SEM_WAIT_FAIL_TIMER_CNTL
 under SRIOV VF
Date: Tue, 30 Aug 2022 14:40:05 -0400
Message-ID: <20220830184012.1825313-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830184012.1825313-1-alexander.deucher@amd.com>
References: <20220830184012.1825313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ada30760-de30-4edb-a10f-08da8ab720ce
X-MS-TrafficTypeDiagnostic: CH3PR12MB7642:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRWG5+aSJFkEbBLg4lWikAzkzcKQII1LUbxQNlqHfyWMwJl8cicvm8WmidkqUnR4h17QvyWUGwHcCmRXCHfnzBXmpyWpHkdJUckQFs8sV5D7hffexDoKsDdk8RmzHz6a6YWdMNgIHYQ1XvYbz0TfomdJgnU84i6ozdwOyvb5x9WKBW6+ewpGIrCvWb695cbx2vaWHZGlGPJFhZNcWUg1is692oRgRVlBial7TMCEEWtw+tX9MhYMDVRwXeCOGlZu+FXi7JA8Guf+KnRDJ+xM7OhwDfFbYLIQXXKSez+qP4XCpG82HhZXK/QYrQJ7GZaMj7VLZIdwIBwQftevXIsb1rGG0srsmF5H6DGu1uiNpYDRotYkjJQJ/VpkDiHlB8UYmpSipldiGt1WvlNbBee58L0hoyvBbuy423J8ETwu0kVKD4B11hUZmReyfSFMnWOYZkEUhnjCEglLv+kf7YqkJu6rHCQNylP0td5NuIOm5q6QrJKIRR/QwC7mG6ABTNLLDE375l5eGFjj+ErGZ5jTImk2eSnMLE93BQCmKBmgR3nMLw2NcpxixUetI6nYnh0d6XHekaq4GFrVegjX8uh1UuHnJAh2Gs9hDmK9/+XY8fMfNH/yIdA8Z8uY94ooxlcIQU/KN9NFA6/2bxBcdP00AVNLK3vnd7wYYbnie2n0lDjEtwvTdCFFd4aRcx0q3n+I9io+vE904Y9HZxozUEN1QKOf3TmaKY7a7KH0WWrAAWTWkxlfqBHBjtr4/8mvVUMy6wYZ7YdRF8VwjvLHKjOfsgUhjWD+7p5WvdVQpFWge1KPNm+70sKnOlLOJ2pi+Knp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(40470700004)(36840700001)(46966006)(6666004)(70586007)(70206006)(2906002)(7696005)(8676002)(40480700001)(8936002)(40460700003)(4326008)(41300700001)(426003)(336012)(16526019)(5660300002)(2616005)(86362001)(186003)(36860700001)(83380400001)(47076005)(478600001)(356005)(1076003)(81166007)(6916009)(26005)(82310400005)(316002)(82740400003)(54906003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:40:35.8844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ada30760-de30-4edb-a10f-08da8ab720ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yifan Zha <Yifan.Zha@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zha <Yifan.Zha@amd.com>

[Why]
As SDMA0_SEM_WAIT_FAIL_TIMER_CNTL is a PF-only register,
L1 would block this register for VF access.

[How]
VF do not program it.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index fb31dc911cd7..7ae572a08cb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -560,7 +560,8 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
 
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
+		if (!amdgpu_sriov_vf(adev))
+			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
 
 		/* Set ring buffer size in dwords */
 		rb_bufsz = order_base_2(ring->ring_size / 4);
-- 
2.37.1

