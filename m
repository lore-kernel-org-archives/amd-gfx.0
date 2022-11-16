Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2CAC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 16:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C84F10E4D9;
	Wed, 16 Nov 2022 16:40:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 291AB10E4D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 16:40:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nxx0QDkquDuUVpg0TsHnjfh5K9tdchDHio0/uHtXIkfPpjjA2Xs3e9au5eiqk88ZSetTwLeqNomDDwj1/zKZCCroG43kYrPyT1Sdo5O2L8mvZBXgXE0AkRYEhK0noJzvQvkzXufZj5QTFZ12/aYdmCh0ebwloCRL/fWsZAKRP41p2h7Dl0Uo5Sh9P8XppGaa62RSJQsH1ZqxN+3g1o5bQmpdzs4ScRoZu0B01XeA7TojefNoef0piTnSFEaSg1VL6AezD3Nxrg66m+aQaa4J3bUdtB7z52ttMnd8l2YWPB6YRr4XNkmtcfyA46Y/9lJwwEdWPwNNGl/TLa3EF+wxZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGA1pIB1p/e4vcLnWggTScq5l76zOHywKscwuAxpdfA=;
 b=lgIKXtcvMj2a3reOkIWfTtRfnvJUAudS5PUHpR1y0/JS8rQ+ZXNYAKOQK1E9DcENPeZgH2KhJSdMwJ6vQuyCRC9jtcEIJeMOdHpY9jKxtwirM0ASYdyD2UHnFEH0GFplNAPVHa1kojdKGNr5r9XlNNBrXVEZMf6ZpcSSg+Ldp5Oki3LlMPc6BnRKsfp4kRC8mXp20NdHWDNxYRxm5iketnBB4S7uG8TSyGht24y4HBTj8qJqgTMtRCmwLNiXGHMHlvgszVwrXBWeWGDHYfdnOOhKtKZKAZNjYUl+Gxrp5POi6NPbWmL1h7wXXNxTp29C/iKvGnjFJ2zGfIrRuBGOVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGA1pIB1p/e4vcLnWggTScq5l76zOHywKscwuAxpdfA=;
 b=q3dCw58wNXPQT9QkwyWMYuMum6PFaITXIK1PMxe1DYKpCZKnsjZsQ0ttEx++yvO8og7Aa2bGIU6sAfbOOI/aiLz1Gyz3UZzt/qzNRwXHa9dbUMiuEjb+oW7CWvdpNeGttgZd7ehKRdf1EpfxWpGSsU6shdDgR2xgxpRsFy3ebtU=
Received: from BL0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:91::34)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 16:40:22 +0000
Received: from BL02EPF0000EE3D.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::cf) by BL0PR05CA0024.outlook.office365.com
 (2603:10b6:208:91::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Wed, 16 Nov 2022 16:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3D.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Wed, 16 Nov 2022 16:40:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 10:40:20 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/psp: don't free PSP buffers on suspend
Date: Wed, 16 Nov 2022 11:40:06 -0500
Message-ID: <20221116164006.2830029-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3D:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: cfef69b9-ffcd-47c6-d405-08dac7f14125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LY7sd3wu3ldOSRCizpCQVJ04yoW7VfsO0bD8ge7e4mGdcbYSXNAaEjc6GAELaogI2wWAOiGI6FOFlBHlud2p+3tbMyi6QCKWMT9chBkQF2GBz/mHaAQDwdol4lOBR78cGe2PecyvyG+tdZqARXiW0ZzzClMULtEsISKbMzsfR56GDmRQ3XezWEOHefOo94U1DJtoVtBHMJumliBnuH5prsq47+Bv1Um8bZSQklwP0YIRTVg5nGfmMtcQhai3NeqT06q42NNRZa1TmYnll2J4GMv9YrpTQF64GYzk1Mk7Qk1Vx+LgRitaUQgDCszD0dfL+3VlpK3TGeQLBwQkiKsQ9eB4bKXkvhlI35KxtSv2nYAXFFW5FtW4fRn0VJifPQmEaQS8fPdLGRpBPXrMu6YiTnVyCUPRp6/4q+4S12TvuG4WgRljE7Q+ewfyzbP9X4yIZ79B5agiA8kcAntojZg/r6/g+4V8utGv0Y5+476tuX21MYVGgU7B46Qr4g/punFTsxG69SU7NeU9G6Sy9BB3kOBdnb0Gn44rXtNH+SGsM0KJdmjv7QHyjId8EdatlhJD0+rwhJLtxDervMvxk4GkTkbMJp+J7udlYzYRGU8EN+81DCQQCSYDmrbn+o7gCOAaxtyXCssnbWAqZX/n5Ylg96VKZgRl+dxZvPaYFvp5YglppIavBAfSfugx6EEctCuxkYkwZJeh2CaGiyr3cVapAZrwz3Zm4JB29h7u8M389BP6sSayFT41Uym10luRoxBsRRYad6OQmx2OC/+kgbzcfVUNMlg7yndsYrNYI0mNsnj3N9JEaJjkuypWty9BlIC3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(26005)(36860700001)(86362001)(81166007)(82740400003)(82310400005)(8936002)(356005)(1076003)(336012)(2616005)(40460700003)(47076005)(2906002)(426003)(83380400001)(186003)(16526019)(478600001)(7696005)(5660300002)(40480700001)(6666004)(41300700001)(6916009)(4326008)(70586007)(70206006)(8676002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 16:40:21.9921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfef69b9-ffcd-47c6-d405-08dac7f14125
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630
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

We can reuse the same buffers on resume.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 56 +++++++++++++------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0a8c30475dda..d9cb4c4b8289 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -172,6 +172,7 @@ void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx)
 {
 	amdgpu_bo_free_kernel(&mem_ctx->shared_bo, &mem_ctx->shared_mc_addr,
 			      &mem_ctx->shared_buf);
+	mem_ctx->shared_bo = NULL;
 }
 
 static void psp_free_shared_bufs(struct psp_context *psp)
@@ -182,6 +183,7 @@ static void psp_free_shared_bufs(struct psp_context *psp)
 	/* free TMR memory buffer */
 	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
 	amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, pptr);
+	psp->tmr_bo = NULL;
 
 	/* free xgmi shared memory */
 	psp_ta_free_shared_buf(&psp->xgmi_context.context.mem_context);
@@ -743,37 +745,39 @@ static int psp_load_toc(struct psp_context *psp,
 /* Set up Trusted Memory Region */
 static int psp_tmr_init(struct psp_context *psp)
 {
-	int ret;
+	int ret = 0;
 	int tmr_size;
 	void *tmr_buf;
 	void **pptr;
 
-	/*
-	 * According to HW engineer, they prefer the TMR address be "naturally
-	 * aligned" , e.g. the start address be an integer divide of TMR size.
-	 *
-	 * Note: this memory need be reserved till the driver
-	 * uninitializes.
-	 */
-	tmr_size = PSP_TMR_SIZE(psp->adev);
-
-	/* For ASICs support RLC autoload, psp will parse the toc
-	 * and calculate the total size of TMR needed */
-	if (!amdgpu_sriov_vf(psp->adev) &&
-	    psp->toc.start_addr &&
-	    psp->toc.size_bytes &&
-	    psp->fw_pri_buf) {
-		ret = psp_load_toc(psp, &tmr_size);
-		if (ret) {
-			DRM_ERROR("Failed to load toc\n");
-			return ret;
+	if (!psp->tmr_bo) {
+		/*
+		 * According to HW engineer, they prefer the TMR address be "naturally
+		 * aligned" , e.g. the start address be an integer divide of TMR size.
+		 *
+		 * Note: this memory need be reserved till the driver
+		 * uninitializes.
+		 */
+		tmr_size = PSP_TMR_SIZE(psp->adev);
+
+		/* For ASICs support RLC autoload, psp will parse the toc
+		 * and calculate the total size of TMR needed */
+		if (!amdgpu_sriov_vf(psp->adev) &&
+		    psp->toc.start_addr &&
+		    psp->toc.size_bytes &&
+		    psp->fw_pri_buf) {
+			ret = psp_load_toc(psp, &tmr_size);
+			if (ret) {
+				DRM_ERROR("Failed to load toc\n");
+				return ret;
+			}
 		}
-	}
 
-	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-	ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_ALIGNMENT,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
+		pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
+		ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_ALIGNMENT,
+					      AMDGPU_GEM_DOMAIN_VRAM,
+					      &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
+	}
 
 	return ret;
 }
@@ -2701,8 +2705,6 @@ static int psp_suspend(void *handle)
 	}
 
 out:
-	psp_free_shared_bufs(psp);
-
 	return ret;
 }
 
-- 
2.38.1

