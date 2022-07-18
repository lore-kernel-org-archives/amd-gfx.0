Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699DEC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 19:33:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7B4810E11F;
	Mon, 18 Jul 2022 19:33:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B92510E11F
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 19:33:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPreft0B/8QchisMVrDX1Xu4YOdjcgZOBdwLIy1r0iW3IkMHsvplJzJjboZLpgBPdRbcpxJCJIDutPJMntPt2IrmqED4Vv5F/rp9IA6QFIsm1d//FJSdPvvpJUx0GQLZJI/MHBz7xzAYVYt1UaOKCfxpPZt/zTFlzxhJjNgCW+7aGBQaurVZOl+EFpN5Qg+DomV1hzm7ZGeuDA9Wg2jzxVnun5Z35Z/2OBh8RIPfVPcvBxCabEtlau02dsf0T2G7YkdHkYyGCeIwUm7YphnIvhOJqqO/zaYgtWVNHdOnmDNuQ9WvZgT5qnQhMYl/5VcrbC4w9sF9iWUbw2XP8FWklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7cCEoqaFCts0LCvuRM3vAnd64KILj7iIavDvsEyguo=;
 b=EkU032oqnc4EjaBAY/K3fqi6kL2S6OM7OFmEpX+eRD8bWbAVY3pfe/N5LyzuQaU11HeStbiJQoKF32Fsq8ItDINv2qRUXGsXqxdlqBj7eOLwJt2NjcfJJAInMXb0diQL+cYVgdtdmb19Opq24TBQsj6Cl4NJ2D751O8xrBUCK275U4jstojLKtI7eck7VOYFBNAzQ7qonBzllt+mGjUZZpUwe27BsHdoaVw5cwXhCXycCU/gj7o7e5lrSGRCzeIVvCY2GL9bTTRci/VVumyoUCT2KmPSyjwpwHk9RRpt2jXU1Gmv3gdg2Qev7jI7bGd0PEB0CEs+RTiBv/XQVFKPfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7cCEoqaFCts0LCvuRM3vAnd64KILj7iIavDvsEyguo=;
 b=q0hBDO8U8H3wl+6Y8sDEc49vTk6e11y8gus+4oT6MkbCAodRC1MKB9R4xFJuBFWrMQc+kqnT+tPX/zMTRUlDODoWNywcLNZits9lg12bbqyA0oacSYsLvsG3uDMJbW9dpiVJCyp9sSqHL9yQ1Ge9gttVH/yJE5IkfSieL2k6Pys=
Received: from DS7PR05CA0081.namprd05.prod.outlook.com (2603:10b6:8:57::6) by
 BYAPR12MB2710.namprd12.prod.outlook.com (2603:10b6:a03:68::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.17; Mon, 18 Jul 2022 19:33:00 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::f0) by DS7PR05CA0081.outlook.office365.com
 (2603:10b6:8:57::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.7 via Frontend
 Transport; Mon, 18 Jul 2022 19:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Mon, 18 Jul 2022 19:33:00 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 18 Jul
 2022 14:32:59 -0500
From: Gavin Wan <Gavin.Wan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix scratch register access method in SRIOV
Date: Mon, 18 Jul 2022 15:32:29 -0400
Message-ID: <20220718193229.142120-1-Gavin.Wan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 786d6dac-1d7c-4da0-3e46-08da68f45325
X-MS-TrafficTypeDiagnostic: BYAPR12MB2710:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M3nDdH/7MlU2oT1RlR27w9K0j7BwU0ZniB6E3qGUyqqAH1Z4aPZyhgmHeRWxw0ZgAz5Nl2oXxOsT7CqR3R1Ipy/eDA4Y4EuiyX80IEaGUAHDL2aKP1D/dcSysQzkeqRFCQ/fpiOosmSp4SKbBgj5ZxqXS9OJl5RW9um0uks2ofqIxQA+Wt+lZ1ZF1cEuu71ijY6NmgoV0Nsvg0gDoyUqwuTb2Y1dRQDULPCOqRvNEahYLRIffyN3lV97eIC075SoaXZEx1H/k4E9DAAY9Lwip02z/9f4JaczFhO0/5gR3PVYtL9nmssuZWvDb3qzHjR+ZDyOdAju8f3HbdsEGurbmP0WuWqGmaPhCVbbMn6r8QuQ+Q5QuAIXGA6a4t7v+L3kLoup2Tch2nAtNY1GqrcoejDhNGQk9GCnSj7udur7LTIKx54UIJB0v0HHToUehIRkBMJhY47GUXqQ5uBBQgZ4eUgC1vOdpCgslHbSxfSnjCiac0gWiilvFXN4wa90Fytg4hp3FFbe/37pRL7C/2zMQrnpGEzEXPOUDLMqqD/K1kjK5RNLqqiTFeD6aKsEqlihAxVt2fHdHSG9RaZvD47Od1jrPI6douxXQaHymruBNm0a/YSSxd9uYcgBPaMRDhZx37ROw3IbgUToKV3ahIvP1ZS1GVxbaP1LIoj/yVFsyt7bQegythcfTyc7G/2JZltwLD73bkT2iGE/laZFZgsUJEuNMeWQ6ZB90DJvs6fTIlFETKg/FPYZGTT6cQ7zdSjEAN9/Et0zyMzHBIxTHW7i9jaFsSA8UtEDYpaGC7WN7THZjX6+cFpQ3crg5uJyHjcSz+JgXcOXWRdb2NToCb0icQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966006)(40470700004)(36840700001)(478600001)(41300700001)(8676002)(4326008)(86362001)(70206006)(70586007)(40480700001)(316002)(6916009)(82310400005)(83380400001)(47076005)(40460700003)(426003)(336012)(36860700001)(26005)(81166007)(16526019)(6666004)(7696005)(356005)(1076003)(186003)(82740400003)(2906002)(36756003)(2616005)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 19:33:00.1511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 786d6dac-1d7c-4da0-3e46-08da68f45325
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2710
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
Cc: Gavin Wan <Gavin.Wan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The scratch register should be accessed through MMIO instead of RLCG
in SRIOV, since it being used in RLCG register access function.

Fixes: 0e1314781b9c("drm/amdgpu: nuke dynamic gfx scratch reg allocation")

Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
Change-Id: I888cb3b96856583e764b35a098bcf8bff01ad90c
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5349ca4d19e3..c6e0f9313a7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -987,23 +987,23 @@ static void gfx_v9_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 static int gfx_v9_0_ring_test_ring(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
+	uint32_t scratch = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0);
 	uint32_t tmp = 0;
 	unsigned i;
 	int r;
 
-	WREG32_SOC15(GC, 0, mmSCRATCH_REG0, 0xCAFEDEAD);
+	WREG32(scratch, 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 3);
 	if (r)
 		return r;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
-	amdgpu_ring_write(ring, SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0) -
-			  PACKET3_SET_UCONFIG_REG_START);
+	amdgpu_ring_write(ring, scratch - PACKET3_SET_UCONFIG_REG_START);
 	amdgpu_ring_write(ring, 0xDEADBEEF);
 	amdgpu_ring_commit(ring);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = RREG32_SOC15(GC, 0, mmSCRATCH_REG0);
+		tmp = RREG32(scratch);
 		if (tmp == 0xDEADBEEF)
 			break;
 		udelay(1);
-- 
2.34.1

