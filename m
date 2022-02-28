Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A472C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Feb 2022 18:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8CD010E3E8;
	Mon, 28 Feb 2022 18:25:29 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2066.outbound.protection.outlook.com [40.107.102.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C179910E3E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Feb 2022 18:25:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIEcVSn7dKcasiTfYpeJQcB0vDkOqsEu2+BTlO7PBwWMI8UED2xcuSMqWlM3kZitVEkA9bp41YgqmtKhaT7vO/Lg1SEfXYyVNO5enWn9pzui1GJ7Szed9AXWT42YumrcKRnxc+XbzkICJ9woRDka8qHGLMQKaLr20sOjNf0LNxWmQHutn1qh6SHKZpHGiJ2MKcx9m3hSMIT4bjHj9StdoMh60idakpl8Wofkn6lpE3IxFhV/Iqa4cIZcR4Rp1GxJhBTKSVEDkvZN+dW7kvbH3q7mjdr86S0xYbnymzg68b5+/IKhQZBFo8RQaUjCuFztYyBC9P+rHeH5PsXTCNC7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFAep0jQxNS2X39DIcV1bsd81l/xN5RChfEFEcqd+rw=;
 b=WexroPk1KIe8JWzASmw9HL+MnnPqLUlYTtpa0qwtuY43DANljdqDbj8qaDFIvBdFYns9qIIXOtpNijwX4uy2z7PWApqsFZ95BwUaocacjujMTJE9t9XcIOnPnot8CUCEFMs/D+wIkmVVXstLZ7XfwiTw87VZ9DMXRND5YpKIWmoIyu14Y3DuzHQSxFC/TeNaok4GL6BnbNZhTEhbGnXLX361ZgsO7iBwGyW+P9C+7TutHWzzj7+tHvURVQTasppkQGhwAEes6+HnXgWZ4h35xKUTmVo8HfE2552Z7yun+iUSPUjGPpDdiX7qBQadSRUPrJisR1U2FLLq2GXlcRV7sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFAep0jQxNS2X39DIcV1bsd81l/xN5RChfEFEcqd+rw=;
 b=kgxHt8Aw4vxNsINSJQUAJaP/jClE6bjZcXxmJCRfaoYiye8ixDrL5cbXELl5MiVywjf7AR+I2nMFLpCZQkCeE9+V2G6edcyAlhTudUyS/ADG/ThgCLEG+TyFXTU428UXspcJ5jibOArW4LTAgJOqjnpT4iq9Mq6jMewf3es45X8=
Received: from BN1PR10CA0016.namprd10.prod.outlook.com (2603:10b6:408:e0::21)
 by MW3PR12MB4507.namprd12.prod.outlook.com (2603:10b6:303:2c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Mon, 28 Feb
 2022 18:25:26 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::ae) by BN1PR10CA0016.outlook.office365.com
 (2603:10b6:408:e0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Mon, 28 Feb 2022 18:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 18:25:25 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 28 Feb 2022 12:25:24 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Set correct DMA mask for aldebaran
Date: Mon, 28 Feb 2022 13:25:08 -0500
Message-ID: <20220228182508.464871-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be029cb0-70a4-4de5-8632-08d9fae7b073
X-MS-TrafficTypeDiagnostic: MW3PR12MB4507:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB450734D67CE7F0AE378233D58C019@MW3PR12MB4507.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P7Rt7A1c2iQvmH8rSXobjDUZFjQf0sOmhLSc5SEYOwOSS2RxECX+inne3PonXwBPrKmk9zkkEup2umgcSVtIPHWo5JBdNRdxoSJGUXK5qcb1nuMkqA0uJpWnbhQ85PVBdzKD1QwLwb1L2Jlhye2MDCT1XHNGCNEvQczpF80OGr3Y5t1VOlEfxmiMkNDS1YfNejkELPz01oop/klbXk/YJEIAYuGWIC5XEPNqozlVMYcwNBhXvtKXnM/RBhf2ESU1+Nry7AbFPpcznWLuhUgcNjwfreHX4wdiBt+0cc5NOU6NYQfEXpKf5Yqt3wIo45rJqYo1H59gHHUtxyIPyjSvj7iPhGHOfQ5E7opgNDeRDk99kxzZIUEi6GlHWhX7+KhaLit4cZTLRF4k51p/FyQ6ebdDKNuvesb9Jl7iHfg88pO8sxVg4+Dyu9ZVLJwiHRuJRueZrlvXLBapDhSztVJDB6tDYheyHovaOnMsrOs8Fj3wwJq+GMrOQAW81kYD5wwZFRUwdgucS16jJf65Juyk/u9QnKNeeXRyhB4dwYLFZFpZ7x6dud+wQ839J7ugZuzFM+Q+kap/NjN+AkqL0MaN7dpZp8TYbYmjj5tP4zgyEc6z2Itd8zbOXOemTqBu1GM6kWlNdD8pBWeql+ejDAkLKGikzcw4ci2wZZO9oNRo6SW4uN/5ySC10/6ubca5K/BMvNzIXzAL46/ll2kJWFWPVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(356005)(2906002)(81166007)(1076003)(83380400001)(70206006)(70586007)(336012)(4326008)(426003)(47076005)(5660300002)(36860700001)(16526019)(8936002)(7696005)(8676002)(186003)(82310400004)(26005)(6666004)(40460700003)(508600001)(36756003)(86362001)(316002)(2616005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 18:25:25.3605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be029cb0-70a4-4de5-8632-08d9fae7b073
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4507
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
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Aldebaran has 48-bit physical address support

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 412e44af1608..0765c163b355 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1675,12 +1675,17 @@ static int gmc_v9_0_sw_init(void *handle)
 	 */
 	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
 
-	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2)) {
+		r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(48));
+		adev->need_swiotlb = drm_need_swiotlb(48);
+	} else {
+		r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
+		adev->need_swiotlb = drm_need_swiotlb(44);
+	}
 	if (r) {
 		printk(KERN_WARNING "amdgpu: No suitable DMA available.\n");
 		return r;
 	}
-	adev->need_swiotlb = drm_need_swiotlb(44);
 
 	r = gmc_v9_0_mc_init(adev);
 	if (r)
-- 
2.25.1

