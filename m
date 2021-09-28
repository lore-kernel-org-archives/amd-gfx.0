Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D01C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C022F6101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C022F6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FEB16E8E5;
	Tue, 28 Sep 2021 16:46:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36D296E8E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTCTlWEEaViWRDUsUxroHDjqhI8EEhbMztwV1+loYwXeM8uPgD9rpteQvPSXCTP8kKnGOeEGNsH5TH5JYRzVTFbyl6weT/qJxBnFcH2pVrtuWJgA2i3wWUBHuprPZkdH3eEXaD6HInDDT4+pXbE8GxAEZLxxx3D4IvXM5P4UwaXVMLvt9aPqLZ246y7qUz6mGYda1nTxnxWQeIheSk1Vc4zT6RVMU2AAph2F8RSVlD1wpZAr1EVgPljb/OI8ReAjzKtjE9R1MPQuiUKI0wUFSrVJUXZZjpB8G/kLLCNQf+G3E5Nv1hCcV3rADFRvGDJ852bGL4JfAIJAtNfRZkUr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=qb5VKDCdp6HT2gpuD1rEEpIckF0KJ0yKhBap+5kES+c=;
 b=an77vGGw0gz7AyUfDnt6JF1NVq0y4JAKVlboXJJBA9cEsPuFnxCttTEhKcgLIsR1QVO1PUxV33ab5OzFE4C9shwgrfk3nRRxYOrw/t9Vygb0djOILg97xFZTdmU6bZOOvcHVhIH0vNeI/lplkYZklzFPUnc7jl01mAIjPxRl6yeYhbcKq6DPFINu9cMkZoRKarkE0d1/Wjw+7l/Qlvptc1Im7E0S4ioc837WrIOKMgHUrHZpLsTlEnyVLNb1GNx7QRGKqZWl0ry9KdDwKDwZ03UpJ143Wke5BsWcofu6p5uDxb2qbCoRmK/2nC/Pmuv9Bb5wIYvKqmTgzEEz/EdoZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb5VKDCdp6HT2gpuD1rEEpIckF0KJ0yKhBap+5kES+c=;
 b=FADiXwecw6nb8US3ECNoA3PxyoZ7ljCR79aN6PvsKIZaIYMSSrL6gfyHp1kFleJLBTFPOBEbeldSTS9aPYq1Q1TYxggZQHQ1qp32Go6eWCIUC0ni0KNTcOhjZCM1Q9UP6S2ePCPPRLtbcUNlFlvNA1ty8Rpo9dZGFGPs4/01jXM=
Received: from DM5PR12CA0009.namprd12.prod.outlook.com (2603:10b6:4:1::19) by
 MWHPR1201MB2495.namprd12.prod.outlook.com (2603:10b6:300:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Tue, 28 Sep
 2021 16:46:11 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::11) by DM5PR12CA0009.outlook.office365.com
 (2603:10b6:4:1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:46:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:46:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 53/64] drm/amdgpu/sdma: remove manual instance setting
Date: Tue, 28 Sep 2021 12:42:26 -0400
Message-ID: <20210928164237.833132-54-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c59f6e53-f297-46a4-0055-08d9829f7a35
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2495:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2495748AE6F676A1E9E6B751F7A89@MWHPR1201MB2495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iegx+iZnLFphCOiUsCgsMDyK+53/JHUxAxQ4DZ0Ua1qv1PiIEPSY5LDAhouw5uCYKnyhj1VHPrxWkC37v6siENBTLtMxSyWLtFee0wPlfTzDfnLQ5qYTMPTnztLXFGoZ77KDtiJs9WSSXatR7WWmAWv2BuLndC4mKe/dhKEaLjdgQ3qty2t+JhNWNdeUePqJnow5wpy3nThx+GdWJGfd2qg5bmwKQYExdcqDXnYfOcXBu6yRzQuz9+Fcv8ZasJ2YZhHr1DgLov9bmI5+/BYiP/Btg+N6YDbDFF3fAna3qyaLfmvRDjaEMGiIgpgqLD/h/g1mRnwPxhgz85mze+j1Dtc7tD5DvABnwDIv6OQ6j4rF1hB5X5lRlpinx28QDkBb7Z03zIGY+gLUmpg94SA1Fh8GcRYhfcTY/owmtfS1QRYKvRtJjNmU4WR7jJ89YyEIXsr0QYTi4dRxBeIC8uRNi+xaxwmHTh8INc1f+1Bnm6ZEN/EI5jrnMxE52vNJNgsOVtN5MUOPWyNyda6WtFLotIvZqaN8sA3B6ijBUUJRCY6DC09wFwe173bkw404TPEq9SzkJ75joPAha/MDhJehdiU7WfaWGYhIOAQfUUnBAThEbxDAc27fyXF+IuXgkOEC92Yviyuu4LmBPWGtF4WguJLZKKzhXRzpmGXHncbdfoDwUlED3eVKMgBePAbkaRLQRIaeEv7brzY/MNesAHdciz3AGQKf4QculvSCdo3+JL4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(86362001)(336012)(4326008)(6916009)(7696005)(5660300002)(186003)(16526019)(8676002)(356005)(316002)(2906002)(81166007)(6666004)(508600001)(36756003)(2616005)(36860700001)(47076005)(26005)(83380400001)(82310400003)(1076003)(54906003)(426003)(70206006)(70586007)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:46:11.0531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c59f6e53-f297-46a4-0055-08d9829f7a35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2495
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

Handled by IP discovery now.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 17 -----------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c |  2 --
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 17 -----------------
 3 files changed, 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 3219dca3e44f..cb74f8c35d0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1856,23 +1856,6 @@ static int sdma_v4_0_early_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
-	switch (adev->ip_versions[SDMA0_HWIP]) {
-	case IP_VERSION(4, 1, 0):
-	case IP_VERSION(4, 1, 1):
-	case IP_VERSION(4, 1, 2):
-		adev->sdma.num_instances = 1;
-		break;
-	case IP_VERSION(4, 2, 2):
-		adev->sdma.num_instances = 8;
-		break;
-	case IP_VERSION(4, 4, 0):
-		adev->sdma.num_instances = 5;
-		break;
-	default:
-		adev->sdma.num_instances = 2;
-		break;
-	}
-
 	r = sdma_v4_0_init_microcode(adev);
 	if (r) {
 		DRM_ERROR("Failed to load sdma firmware!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 2ab670c58520..d3b01d2977c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1295,8 +1295,6 @@ static int sdma_v5_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	adev->sdma.num_instances = 2;
-
 	sdma_v5_0_set_ring_funcs(adev);
 	sdma_v5_0_set_buffer_funcs(adev);
 	sdma_v5_0_set_vm_pte_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index c5252f12eee9..92f29beda3b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1209,23 +1209,6 @@ static int sdma_v5_2_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	switch (adev->ip_versions[SDMA0_HWIP]) {
-	case IP_VERSION(5, 2, 0):
-		adev->sdma.num_instances = 4;
-		break;
-	case IP_VERSION(5, 2, 2):
-	case IP_VERSION(5, 2, 4):
-		adev->sdma.num_instances = 2;
-		break;
-	case IP_VERSION(5, 2, 1):
-	case IP_VERSION(5, 2, 5):
-	case IP_VERSION(5, 2, 3):
-		adev->sdma.num_instances = 1;
-		break;
-	default:
-		break;
-	}
-
 	sdma_v5_2_set_ring_funcs(adev);
 	sdma_v5_2_set_buffer_funcs(adev);
 	sdma_v5_2_set_vm_pte_funcs(adev);
-- 
2.31.1

