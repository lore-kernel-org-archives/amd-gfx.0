Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28D2C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 18:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC62113EB5;
	Thu, 18 Apr 2024 18:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5e/dPyS9";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A17D113EB4
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 18:07:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dx9aQ8uMhh6RQyF5R1Cs8nycKg0QgnrQa9Sd/mPVkGrMVtOyH25Ob+q1jxtSMKZFnc5xd6ThQuYqke2KC7uDZJPER8g0BuptB2TiYVV3yo0pyMwL9KCm/P09ZK3mVUbfYbOeHh6Zps9nok6TGaTNIKKvyiRr3suQfvlRsMqe+HFyS7geEKRR3tXVtvGYoiL/Vu8a10QyQoQE+BoDO/YfPjQK40/eLsGIo4F/JUyCLfs7Afspx/QI3mI7yA++jwGOzxXrczKSDd62OsekahALyJ2psSaKVy4E+svDoLCUVHglF4xKHk6Ie4XwrFQmmJ1c9TmDV5MWMTP6juAUAbXcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0asEqP1z3cxkuP6JYoy9GYpgoiWu45n8Sx4kl1by/RE=;
 b=NLZPO17xElPnDyHVVolAkfcqrsgTlavIS2wtu943AHXOd6mYYrBm4dbdKLRTenu/hfBFqkZtGl7a1QZp9Ov4iKFw6EGw4IxejwEx6jpZfYC20EIzYwNHWppoeiw1vkXAAfnGLNPYElLfmIVC+evdIKzgJbeuukOfjJ459rTouds+5CVeiOJNtQXfDxozaMH+6wtDa+CVK8A5NnJ09q2HrzF+eDp1kdCnatnhdpGvnrBiFb9q56gQBrpBjRyPeC1XCk369p6RMqXpNJPJifnIlx3CUIU+yxJU4kovTPT/kzzBsMBRvYOOviRzBFPusFoGMA1DKldpo3nqcVCPLmLP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0asEqP1z3cxkuP6JYoy9GYpgoiWu45n8Sx4kl1by/RE=;
 b=5e/dPyS9h3I2PrZoKLdireJNB11qSGtkm95xPrAr/1KA20/up8BMwx8ue7vZgBcUFhBJOg6gc5X6xwfjEHDSY5ySSme8ud42frv6BvLg1gaUCxcot0M2KQcDuP9N1/Bd1jIAxgO37cMJ5D88YWIm6jH49mXD0Y79gh3zq9ThANc=
Received: from BL1PR13CA0018.namprd13.prod.outlook.com (2603:10b6:208:256::23)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 18:07:10 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::84) by BL1PR13CA0018.outlook.office365.com
 (2603:10b6:208:256::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.23 via Frontend
 Transport; Thu, 18 Apr 2024 18:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 18:07:10 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 13:07:09 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <mukul.joshi@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Update BO eviction priorities
Date: Thu, 18 Apr 2024 14:06:48 -0400
Message-ID: <20240418180648.2934147-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 3feb2f57-6ec9-4ebf-107b-08dc5fd25e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJaYBMZr3U6VEi98oDYqyvhrytE+c4ONap2jmoysFPaxJKez4h5a7NWgr36HrcH64EhZ6uFantTUtkmPNeiSZQMtxCSPSxZH7OvyrOpRFWhBbxe+pwCSuC14OnsUwYok2z9PEmP+JWG/vrc5uh5c5rRQjVlrkcaMo84s69b4za9J41FR7Eub4UK9bZ+VzryfLP0anOakJsO/dBfj3QlMJkRAV+3bdYUx9iU0fhbim0xYVC1Stj8JdgYGGIgDiN4cfQtoveyIt2TsCI1eTNlgrl/wyegR97tM5O3hkOaru8Y3s4xejuqSt3Fx/rhHctuNbNoo/wcIKejPGerS0QjIyWNEulbYLVLMyLMyrzIRfBtFI+7kLeLp8fVbvzVpTcZ6XMisogNwUyoikiBK0A7PeZhR1iLNPWG1YRC2oNZDf0EwlPCxCeNRN2kaI3m7QTwcIyuc+yxdL9fkB/3yNbz5xyjAyfb0m1xS4vN1hnp7mFN1p3Cm9oskBj4rUHH9SQs70wd72sT0Ou4XpiagNMuvLnP9i7Q0wgoDDr7ZWuEv+u39qcIFOdNLCab9d/4Wufnkr/b+YVStWo4Kf5pITnqip8NyltYxFru2ex5ftxxcjna5zgR0OHKmEpMRFhgHRk0Oaevk9B88vh1NfuUy1qS3AOSIcslRCoLScDMj2exJaxZDa8UQEFEasKEkgBkaX9MN6DeI/iAGOXW34GfYnL0/HYERNxV2C3Yx5cvxcQURLJGeGgqXTrblHUfdrA1ThbkL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 18:07:10.4853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3feb2f57-6ec9-4ebf-107b-08dc5fd25e0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330
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

Make SVM BOs more likely to get evicted than other BOs. These BOs
opportunistically use available VRAM, but can fall back relatively
seamlessly to system memory. It also avoids SVM migrations evicting
other, more important BOs as they will evict other SVM allocations
first.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index cd2dd3ed7153..d80671535ab3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -608,6 +608,8 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	else
 		amdgpu_bo_placement_from_domain(bo, bp->domain);
 	if (bp->type == ttm_bo_type_kernel)
+		bo->tbo.priority = 2;
+	else if (!(bp->flags & AMDGPU_GEM_CREATE_DISCARDABLE))
 		bo->tbo.priority = 1;
 
 	if (!bp->destroy)
-- 
2.34.1

