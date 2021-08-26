Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E8AC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 07:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B2026109E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 07:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7B2026109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BA836E52D;
	Thu, 26 Aug 2021 07:27:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC2796E52D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 07:27:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcaO+1J/0c4qQUm3fLhhgTbyjvt9H9aXRfCKM3Gbr7nJRL4mUC0nw4iI1IJK1xoCg5Wf+qSr2SPGAZMpIgW/ZSgSsLkPDG/6TQtqXVOHyajKRr63OVdfOX+xd2+K6u3KxfsfNsJB/0xPMrERGzimcZeY+zpqFEoQ0uz3K/bonSow/dNimiZoA4c5K00VtoSeq+Unw/Nr1ogLa+6L6xfYL9AqNEzImmkA/F+3kJYG4pfyILwPQelUuomtlWoxDBhXuZABSU4ZBq6/G5MVQ+YiHaDtJEOmY/+wOAo2S7v9JhSMqSC36Sc26skT0UW/odSY0xFV5uH9vKFpvQsJDVqkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzdRjXA5bOMLQZfDUkRGzafF6RYfQkv3rpOTuWpTiL4=;
 b=Fv2NtdwRvWeRl17X+64Ji4Q51SW8FyHSi3zrkdYATA7smpcA/+BTKOICyz8QF6A5pRK6LY7WvHFJEz7YwXWCofcP2XgsYR2KrJq6T/jgeIGUXjM4WnfQYfU0Qxdh4bSa150mzNj8kagit0GfgO2JL3dYnJorWmbOMFc4OacRbthrmIrF1I7w0XBPmv8DegCJds2SGk6M+2iDxdLuwU/p6mQ4cxrY5DVdUTsQWa1Hrvd1GAZrG6qayDHH73Ndn7zIx2ui/eVv3N1znzkAyDdq6q0Jjaz0hwLvFXOx/HTlWKzyfaDRm1+vnxFqv6qfc1Tr8ykKqTURFUmK9B5vdTPQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzdRjXA5bOMLQZfDUkRGzafF6RYfQkv3rpOTuWpTiL4=;
 b=3OmjzF3h2z1PtCR0h4C5vv0OBN2W1WXUs+YnwACN2h9flvDYtGL+1F3RdFEctfdNCowLctrzJgsqnBg3cNPxERnKl2fTGmAcDxfQsbs5712sraL0nvnnD15DZbZQPvRyGKLJdPafKvai92YIIiLxk/iCUVDLsADJvH9iiJkgC0Q=
Received: from MW4PR03CA0297.namprd03.prod.outlook.com (2603:10b6:303:b5::32)
 by BYAPR12MB4615.namprd12.prod.outlook.com (2603:10b6:a03:96::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Thu, 26 Aug
 2021 07:13:38 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::39) by MW4PR03CA0297.outlook.office365.com
 (2603:10b6:303:b5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend
 Transport; Thu, 26 Aug 2021 07:13:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Thu, 26 Aug 2021 07:13:38 +0000
Received: from amd-Celadon-CZN.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 26 Aug
 2021 02:13:34 -0500
From: Satyajit Sahu <satyajit.sahu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <shashank.sharma@amd.com>, <nirmoy.das@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>
Subject: [PATCH 3/5] drm/amdgpu/vce:set ring priorities
Date: Thu, 26 Aug 2021 12:43:05 +0530
Message-ID: <20210826071307.136010-3-satyajit.sahu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210826071307.136010-1-satyajit.sahu@amd.com>
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7aba41a1-e5b2-4eaa-0a02-08d9686106c9
X-MS-TrafficTypeDiagnostic: BYAPR12MB4615:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4615BA91CFFEEC1D806E5F58F5C79@BYAPR12MB4615.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YrLj8me8TbF3x31mTo9/O9bHgM1iPeVmmcvNowPcNSJqz05qkygjI9jBNWjB3JcYxCq2tRWpXpODICFDxGROg7axI1Ebo6peMWSQIGX4k82HHPwerfgjD22oUBevxVa/DXY9uUCsM4Zpm+8jtz/P8gjvdpe6MXuobY/gsHP0Lh5emsPM8UgTgMVqNvseM8T4AGXUUnzOLaRo5bDma4avEXrflE0Y5uSxdEIsVITfkG0mitk79Rh/EpDjQY+ve3XDa/nb4It2YJGWtdW3D0d/tq72qZ+ODBwJXYfY1t0Yj6yJyXsYhoLg6m6hNKGEj3FzZP5+bCL0YI7O+50M1jUW01vLzmkA1YN/4ql6weSL8XRVD4BpPm1NClRfCV3MZcYVNqgFdsW18LQmtPZTlK+kLcyciU+7ct9aMl7K7bCs8pi5hGL5XHzaNyT1YkrijoOHYATrmXJN1YjSkjmFa5ibr/Zl229956cHWV+wQUjP6jakaFx/Xv2zqsfGRnLTXylPoigVNNKJudTGLRtTG20XIeGsnL3ldRIwDCMbTXQ02hoO/CHj1IyLI3CdO91Zp9HdmCtNRvlcnZqkDgePeYHoKy3K1yHLIOkdW/78yI+W1Ty8rZvSF3rHLVZxTRW2Eubo4tSm94bn8rp8Y76Pe595uC+OQf6lhswL22Bl/sZ2Nz8PsxSJsM7lXP7WU7+0Dvd3o6CyCi7uRi0zaeCuOi1Hk6JCfOLg+reWKQOw8dZ1qXY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(36840700001)(46966006)(70586007)(81166007)(1076003)(70206006)(356005)(36860700001)(54906003)(82740400003)(16526019)(186003)(36756003)(316002)(7696005)(47076005)(5660300002)(2616005)(83380400001)(86362001)(336012)(6916009)(4326008)(44832011)(26005)(426003)(2906002)(8676002)(6666004)(82310400003)(8936002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 07:13:38.2983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aba41a1-e5b2-4eaa-0a02-08d9686106c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4615
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

Set proper ring priority while initializing the ring.

Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index c7d28c169be5..8ce37e2d5ffd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -431,10 +431,12 @@ static int vce_v2_0_sw_init(void *handle)
 		return r;
 
 	for (i = 0; i < adev->vce.num_rings; i++) {
+		unsigned int hw_prio = amdgpu_vce_get_ring_prio(i);
+
 		ring = &adev->vce.ring[i];
 		sprintf(ring->name, "vce%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+				     hw_prio, NULL);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 3b82fb289ef6..e0bc42e1e2b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -440,10 +440,12 @@ static int vce_v3_0_sw_init(void *handle)
 		return r;
 
 	for (i = 0; i < adev->vce.num_rings; i++) {
+		unsigned int hw_prio = amdgpu_vce_get_ring_prio(i);
+
 		ring = &adev->vce.ring[i];
 		sprintf(ring->name, "vce%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+				     hw_prio, NULL);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 90910d19db12..931d3ae09c65 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -463,6 +463,8 @@ static int vce_v4_0_sw_init(void *handle)
 	}
 
 	for (i = 0; i < adev->vce.num_rings; i++) {
+		unsigned int hw_prio = amdgpu_vce_get_ring_prio(i);
+
 		ring = &adev->vce.ring[i];
 		sprintf(ring->name, "vce%d", i);
 		if (amdgpu_sriov_vf(adev)) {
@@ -478,7 +480,7 @@ static int vce_v4_0_sw_init(void *handle)
 				ring->doorbell_index = adev->doorbell_index.uvd_vce.vce_ring2_3 * 2 + 1;
 		}
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+				     hw_prio, NULL);
 		if (r)
 			return r;
 	}
-- 
2.25.1

