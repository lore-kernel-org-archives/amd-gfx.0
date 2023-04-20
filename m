Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3673C77B72
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 15:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026A210E960;
	Thu, 20 Apr 2023 15:59:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B8E10E960
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 15:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0bkArh0Ovo7CCXAZCzz7CcEVK23Us8ouBA/tFZ6iaHgC6lt66Gz0mQi3KjnQFPJD04zxIVK37j7XeqXlS+gUIvhnM5znDjCoWw8OPBd84IXGXPLVVAFcD2JQzN681ArobJTNbYJLkTZq98eKZvRbxU77rnAU4gWO648lR/RV0oY577YM6g4eK1QYX7AMf5OdgCvtrQ2eCFf3FQgixb4cEitdU72uGdnb7rq99j5Z5tRXmf0/+JSoZA8rxsx9XMnOn6vjwco8U6OnuQOWm0GxYcnaeJl4EVB3POcbuVoDXQs/8TEBcIpbBlVCUdHkgllIXl1bvcr4PExfXkOIyD8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MEGCXLCy2ye1ka8NLwdbOQlMP8AQ9y7aTUFSO2bnSk=;
 b=em26gBPabrOr3Tz2G2bLp2KRBxAuuZySDTkEWi85K7q8T2eqNe+fgjWD/GnOuTLEtbv4IUq79KGiHcGTFv6oL5eiKb1H/fwaq//KlVQAb7YbyG11u/dAVl0Ese/SYJFArY8tlmwCfPuy6lf1OQXFVn927dIQUUcSGl3ERyB5PrZAPibyy15tHDtN8ex765E8tlMtL4cjHR3urVWi8PGG7Z3zZyMCLss/IxCmnjkOk2OXNGpHAl7Ad9trcibTp7gu0zXlTBZYsTRDN8bc058OsNT/I8u+4qDjAVKevwuxbvGCqHzeKvUyl7J1CNSpjcvoVyk1ATXcA0eMrJyRKPQIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MEGCXLCy2ye1ka8NLwdbOQlMP8AQ9y7aTUFSO2bnSk=;
 b=p/2tCv4Vglab1vfBtA+DJwrkPTSeuL2Vik/JGaCBZC29/4Yh0/sbQtBYV7kTfPTft4aCVt8hT+wryO3Pi2wMywSk9MRMI8N+1HyMgWgjO5UlH0Hzbjj3vI04zb76ZjkrzRJjWEh1CzM5imcCYX5bbCjqoS3AJPoON/M0YvDIRlo=
Received: from DM6PR13CA0032.namprd13.prod.outlook.com (2603:10b6:5:bc::45) by
 BL0PR12MB4881.namprd12.prod.outlook.com (2603:10b6:208:1c7::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.45; Thu, 20 Apr 2023 15:58:55 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::29) by DM6PR13CA0032.outlook.office365.com
 (2603:10b6:5:bc::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11 via Frontend
 Transport; Thu, 20 Apr 2023 15:58:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.24 via Frontend Transport; Thu, 20 Apr 2023 15:58:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 10:58:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: put MQDs in VRAM
Date: Thu, 20 Apr 2023 11:58:39 -0400
Message-ID: <20230420155839.634172-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|BL0PR12MB4881:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a78598c-d2e2-4032-b892-08db41b8250b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3V3Fvu7pYgyy93Efb7svyYFIKtfLAz75KHWKH7Damps2sBqQ/onwB/Uo+fmdeTB/elASEWOzZh5Moqf/zw4qL6sqiFTfbFJ9oSjCNaKckzwmQq6jv+gDdfeDwIwEQbI9XWLouQF8NbK1NE7ZuCwE1e8CEuvPM+57J5dp2CsjtAo/PN/mUeWJrTZRuThEeZhcTjp25HZOTBP5leVkXgqA51NOwTVFZAZoGH2QdpjMG7DqREeG4wQd0uQkq769yTEVhCPQ0Q8DF+Cj8eLv9GOio1LE/VRajbzBJqtD0nnqCmSqfWfxt6VSq8Vj2IKFkfLC7vDTL5eT+bEFqX5ocYnd0KJEnKgoNZn4DhubdS8DaHweoJjy2g22qSC8lj4J4fmZ4p/lAcfPlclBtXT/xxuYscEA9enfzGDizNjWNjCIDqUdupIsTD0luouGbBBSaYg/jnvINTAFZzNQqt3ODK2ID++jdM/IstBGqG8gt/mgDBJFWx0NDYee/gaiWyhz0eG3r807+li5btLUXLG72UkeN6lGWuS8I+jOpxSngKn3Z+UM+jkM+VUDEAp4BZ0uKdV/uAtzVPHxF7CEB8lXT6ELLzYYqVHVEqfrl7mrt9pVVwWKLymsdgwHZEYNGC50GLHyRQPHF2Su85+Ywqd/w+xWDX/PYf4sZlnloXndk6tyXqRY/FDB42z8HHmHzYn92ZKTmaHjTxVvu8KTFihaGGdpYmSehwQ6zaL9sRrt9QQ19qs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(4326008)(5660300002)(86362001)(426003)(82310400005)(2616005)(336012)(47076005)(82740400003)(186003)(81166007)(1076003)(26005)(356005)(40480700001)(36860700001)(16526019)(8676002)(8936002)(478600001)(6666004)(316002)(7696005)(41300700001)(36756003)(40460700003)(70206006)(6916009)(70586007)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 15:58:55.3589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a78598c-d2e2-4032-b892-08db41b8250b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4881
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reduces preemption latency.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 60bb4bba1994..f52feee1d64d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -413,6 +413,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 			ring = &adev->gfx.gfx_ring[i];
 			if (!ring->mqd_obj) {
 				r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+							    AMDGPU_GEM_DOMAIN_VRAM |
 							    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
 							    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 				if (r) {
@@ -434,6 +435,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		ring = &adev->gfx.compute_ring[i + xcc_id * adev->gfx.num_compute_rings];
 		if (!ring->mqd_obj) {
 			r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+						    AMDGPU_GEM_DOMAIN_VRAM |
 						    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
 						    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 			if (r) {
-- 
2.40.0

