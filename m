Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D8AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 07:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A3AF11321F;
	Wed,  1 Jun 2022 07:27:54 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2084.outbound.protection.outlook.com [40.107.101.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8715411320B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 07:27:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJo7lllLrsQAeQQnyfr9K8kNe23suyc4dTqJnsEEBtlW4MqM9CFAQdOxXeYQ29bie47LX/YogicYcGTu7q4oj3CPjT3AQREmDhVurKKKEDaRthOpLLyHGKfjtS1OGIenpF50z/vUgPmJ6kGn/kywmsPNKEZKw87egEWzfClnNchw9q1uaEtXgwLmoiIToKne/NIJi/X4njKxs0ibsRDydBVc8Ov3fJOLO9yUDXRT9NDEbDK1vuWtQelQxd9LRxbce89tzgqrOAq1KTG2b4rlpLrbyN0yekKQDgwzaWcTFXeq5Sdo5qI4wBbvrixNiihnXy8G88rg49H2uT+yeOraAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOnNEV+/kls/wLdSbUlWENChPzhCXLtB4/JT8Jt29k4=;
 b=D27VoPmkdXafcR1/SoEEesUAuk9xRHvx2hc0lXNSdJ0bBZ1mHvwspt2vX1nDFU23910V6TFr3yWsgWf/yztrgjRxlvTMjg2tUtpLZxl4+yfZyMpnR1W+R2eU8fcATxEmre1cpeOr/dZqLzF4s1WkGRbLML/UqZZVl9Yj4I+UXJ+Aum0A+UJ7sT+/DHhLOPR1CMo2yL/6P1TpCt6ZFe/ZpyGPNZeULXgqmQxwe5cM9SrwsRLmIXoiO56pKTH7f8VOzCx2Fhe2KykBMsHEnfw7QQP/Td+fdSOumuHGkywADRQ8729LXXHLlWXxKMdOkDcy2mCPs55jcqTCVw6+9THkrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOnNEV+/kls/wLdSbUlWENChPzhCXLtB4/JT8Jt29k4=;
 b=Zd8p/OP7p9xUpBevgoDJMLpKvbg0xdY/EHouHN69YPtNFtQoL24iSzauZHCG/kAsi+9U9/GyRCmCVgatwLug/LINFE1E3GjkNpvaKDluN6boC+UoZhSl1oK5yJNfpP4cVR2UVTBXsergv9RWRT5b9C3iUUSQqeB60lz6xUVSuCE=
Received: from DM5PR13CA0007.namprd13.prod.outlook.com (2603:10b6:3:23::17) by
 DM6PR12MB3483.namprd12.prod.outlook.com (2603:10b6:5:11f::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.15; Wed, 1 Jun 2022 07:27:50 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::47) by DM5PR13CA0007.outlook.office365.com
 (2603:10b6:3:23::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.6 via Frontend
 Transport; Wed, 1 Jun 2022 07:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 07:27:50 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 1 Jun
 2022 02:27:48 -0500
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix scratch register access method in SRIOV
Date: Wed, 1 Jun 2022 15:27:32 +0800
Message-ID: <20220601072732.2773139-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bebbba3-6e32-45a0-ca5b-08da43a03c05
X-MS-TrafficTypeDiagnostic: DM6PR12MB3483:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB34836AEDD24B23C919B318FCE9DF9@DM6PR12MB3483.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9dBVvxBtRNhyZYn7b86zfnb71y4sSKsI/z0NpP5Hzdgpo1sjNkRsz6m6X1t6XiWJk/ZzE+0bZdr8vSno2xMjmyuke/8rFgS0mlxxERKOgKeEDalp7F03vUz+mW0Byn24vSZ/cFgW/POSS9BpnlippMezpMnkgvjWujtw9NEfW7g5R3+JFy824O/afuI+NX/VVQIy7bAbBmSWmDdUdEqMk4/gfQPyylJR4aElmO7cmyNVkB/Z+e0UAgQFXKoRFQ9w56xKCEcIPql0zf9MTrFxQrRcsjUB5W3jBewv2cOA3UiqyR0fod33gFvCBbguGrLLCh8fWua100Vg9HeQO7M64hs1xwutb54LGpl6ua8aMXX9Md7VN0xDIn06mK1HC3ISPFMUhCZAcEmM6UFw7ehgwYVg+ddwsNTTiY+TBDb9QgFAlziG9ytPRCPhiaTDPR36DH4nUlfl+LOE43g73/L2miJUIEN7z1pkwCJjaLHT2hiTe1FAQgJYh9mmLoMdciTw0nCGI/EKhI5uZJib2hVUqdjGKk5iwX6+Iehvg1goj0vi9WO6vCp31DMZBiIlSU8Gy99TPMYs1HWEw8ymVy+qVaIGIveTjzCLxW/6UPDyPucRsnFMV1Q5jAyEMtuo8rn23UbpODbtEunSZB0mdr3Cuue5GT5rsq2gb1KP/q14kU6+K+cZ1kpHAfgMAwjk5ggklA3mbgDxbh/SfTPUg2Rbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(356005)(2616005)(26005)(1076003)(81166007)(82310400005)(6666004)(8936002)(36756003)(36860700001)(426003)(336012)(16526019)(70586007)(7696005)(186003)(70206006)(316002)(5660300002)(83380400001)(47076005)(4326008)(8676002)(54906003)(6916009)(508600001)(86362001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 07:27:50.6249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bebbba3-6e32-45a0-ca5b-08da43a03c05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3483
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
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index c5f46d264b23..8331e0c5e18e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3784,7 +3784,7 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
 	unsigned i;
 	int r;
 
-	WREG32_SOC15(GC, 0, mmSCRATCH_REG0, 0xCAFEDEAD);
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0), 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 3);
 	if (r) {
 		DRM_ERROR("amdgpu: cp failed to lock ring %d (%d).\n",
@@ -3799,7 +3799,7 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
 	amdgpu_ring_commit(ring);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = RREG32_SOC15(GC, 0, mmSCRATCH_REG0);
+		tmp = RREG32(SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0));
 		if (tmp == 0xDEADBEEF)
 			break;
 		if (amdgpu_emu_mode == 1)
-- 
2.35.1

