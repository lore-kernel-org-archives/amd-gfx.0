Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E38C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 02:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64D7310FBC9;
	Mon,  6 Jun 2022 02:39:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47DAA10FBC9
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 02:39:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqdfAEHI+NkX04MdLtSeMmIRQdhXwW5s2q27DZHuW79KUIxYS8Xp8suVJvkQ1vy8XjESo6gH1RkfEnnmuQxVIvmETPzKFQtiQfCKpsksn9iFdyUaWKEa74WdhKe1vRm7brHN3X5bLkajC8/1mG+wHkvRW/fTAAnd9BH1Ulc6LBjpqmIiAPjXIOeVDao80d5SP9RqB0kzwJhgQnq7xwKDUTqLsgchWLQW5P8pNIUxWRQ3COY95z1Xgu2BOj7NtYDdI1FSMMYB8CxyDMamvx8WtB3bCX3pWX/g42D0vHpcW0rp14dL0qg26zTimf0OidauV49z4Us2qB0SzDD7prMkLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jakJfHbWVE0EO9AkVaD0Bnqu6+Z3n3aXNj2SaU099BU=;
 b=e8k0e1GCf8PTI7Bd2Vfeb9kbU1TnjvIBb05AiCwk2i0JWDrFfcUer/fxrTkyXNn3MLfxBqSWz5FAO79Pxr0mW1KIdWMuXJcpA6+zthj+1skHHlOh/QYQ7s/f1kCp2BetQh0u4lNGCuxX8l8ZO39jth9qF/7KjjNkP08nIGx5RbwSPIvNc6gxQd6H1m5hULD+k9tOirEUNHKzKJ2/2cHDTvtvaUUuLOUiKnu643UFZaNLZ6UTbpdhQvXcCa49fUxHFgviwpIeq+pnilpUOgXw3uYoFooNnQPDij5BaDX4An0A/aTTsfk1rOfTrHsZZIDlteyf7fyjvsXPgFzpCnAiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jakJfHbWVE0EO9AkVaD0Bnqu6+Z3n3aXNj2SaU099BU=;
 b=bGNRD2qF04E6M0jk8FdeB1vRBOiifv4w77iaVnPTX/D+65n4WB2jb+mcwNTko8ZYTKZ9HaVBgTKNgJw1vxe7yGqbJNZvrVp3n67Z94zja2gfs0viD8ZLzu1xxHyg25pmRuviu9qWhXUvU8zpbA7SDGlQM0MqQ84bvxg9RJaMY8g=
Received: from MW2PR16CA0068.namprd16.prod.outlook.com (2603:10b6:907:1::45)
 by DM5PR12MB1388.namprd12.prod.outlook.com (2603:10b6:3:78::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.15; Mon, 6 Jun 2022 02:38:58 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::83) by MW2PR16CA0068.outlook.office365.com
 (2603:10b6:907:1::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19 via Frontend
 Transport; Mon, 6 Jun 2022 02:38:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 02:38:57 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 5 Jun
 2022 21:38:56 -0500
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: fix scratch register access method in SRIOV
Date: Mon, 6 Jun 2022 10:38:45 +0800
Message-ID: <20220606023845.3439931-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1454cdd9-909c-44ca-519f-08da4765b4cd
X-MS-TrafficTypeDiagnostic: DM5PR12MB1388:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB13881406859456E7F316DFE0E9A29@DM5PR12MB1388.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /JxtiDBRdWXKyaMu3JBAV8XackR9XOConMrtA/66+uPiPBNRZJM7pjO9+qz4bgLQItGMgpvWmkbfeMMOAWaZvGrB9KqqJtF1gTx7W/4C2a+rreSSNbLv9QbBAaXe4rxmy3xeLKt5xwmX0LkFtryrxH6BkjB61CsCREifuydgcej+f8EouIgP17Pm5YcxxzF1fmErWmJuTmgYzrOCg/6o6uvN/FaSOZNsEFxa8FUnyoZT8WM9g5Yc9A/x6g8a7iYI1wXTttsn9H63VFr5P8E1ii/KLWxC4nWYnKUw6v5O5AwzVdfPlWUO609y4RAFg+rZdTlbhDbPK0eFrEfHu3LHcl/BZbNbX0sVwlO3yQ/DSOVGKk0+Y1zXzQ/BcxukCNcGueEaKaa8c3jhTT8qu0t6IBJ6PzA1wHKvJImTccVSyLTRmOAnjo3fho4bD/CniUmtiDvLi5wIQkHKsQrqAaMUxpIoFiOC6uI0GCqa0yXdJd6PeagRVdYNlXUmyNOF7fYzON9OCcHkrLatX92+97NZetCSBKr/5jHWHhxLNI1rLmoOsTd0MTnhGUvwAiZFsXjgZmlUhmltFhsPGblgqyZbFcwEPmD9SI/HIP0xbVNkIQw1ZOJTUUlTeOkAt2M+4f/7kJosKgZimSPJvVAU6ncpz6qlhTLPiWcCNUUE7KPU2NBc+q3KIT7gD5MjbVPlfhA7XbXGIsWYVgghxufYwEg0zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(2616005)(81166007)(186003)(336012)(86362001)(426003)(47076005)(4326008)(1076003)(7696005)(6666004)(316002)(82310400005)(36756003)(70206006)(70586007)(8676002)(26005)(54906003)(6916009)(83380400001)(40460700003)(36860700001)(356005)(508600001)(5660300002)(8936002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 02:38:57.5095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1454cdd9-909c-44ca-519f-08da4765b4cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1388
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
Cc: ZhenGuo Yin <zhenguo.yin@amd.com>, jingwen.chen2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The scratch register should be accessed through MMIO instead of RLCG
in SRIOV, since it being used in RLCG register access function.

Fixes: 0e1314781b9c("drm/amdgpu: nuke dynamic gfx scratch reg allocation")
Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index c5f46d264b23..ecbaf92759b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3780,11 +3780,12 @@ static void gfx_v10_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
+	uint32_t scratch = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0);
 	uint32_t tmp = 0;
 	unsigned i;
 	int r;
 
-	WREG32_SOC15(GC, 0, mmSCRATCH_REG0, 0xCAFEDEAD);
+	WREG32(scratch, 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 3);
 	if (r) {
 		DRM_ERROR("amdgpu: cp failed to lock ring %d (%d).\n",
@@ -3793,13 +3794,13 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
 	}
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
-	amdgpu_ring_write(ring, SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0) -
+	amdgpu_ring_write(ring, scratch -
 			  PACKET3_SET_UCONFIG_REG_START);
 	amdgpu_ring_write(ring, 0xDEADBEEF);
 	amdgpu_ring_commit(ring);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = RREG32_SOC15(GC, 0, mmSCRATCH_REG0);
+		tmp = RREG32(scratch);
 		if (tmp == 0xDEADBEEF)
 			break;
 		if (amdgpu_emu_mode == 1)
-- 
2.35.1

