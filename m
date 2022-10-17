Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883A5C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Oct 2022 09:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8427910ED11;
	Mon, 17 Oct 2022 09:21:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90C5A10ED06
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Oct 2022 09:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHprC7Bw0QzczsOqyXbq9AZNbD9lkjFRZgMekDzmxhE+7gX6tnmNgqDWzb78+FtdFT7Nhp66FF9xLprA1e/zi7+Af23NDdlrolCP8kS8QVJgroibBfynmBursEN0sTuQTU1RgV6eDxw38o+5gTQUjph3HxBThCkIgQgxVQy+x0/M6xbY9cQDPdYyO+uvA2cWR1ysI0eJU2EfVwaAVAQzestjUNlgRtLLOILkBGhQC93Z2aElrVo45WXnrT0tRhzR4g4hsBg/rUkD20LWTV4pvMvy0JovNEX5jtJqRbhO5Kouiz5K+SECRU7ggALZsYwjmN5u3kBkkbT3AV+OThZUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pc7mE1psXLfjctdJVPXygfNvb+MWaLE/Mxf7W+e6PwU=;
 b=WeytMih/wie2EbNDbCTy/AUDDtRqMxdLn9G+PaSyHk1kgNimBfMYVp6UbDxoTeDoT/PFBqGHyUmsSDnloVmE9C7uVfS4eB9XLopNI311kgVteI5hiQogDz7GLd9mKp544XgJ7knOfZsFtwRpaEqcZngvboOKUpRLAkWEv8C0m3oUJvy2vKQlK02BxC8ZWRV6TnShXh7kYBoy2/PjHgj+6tkChZ3g4PbYWWdMc0AjnJIZNq6pNzDepdRp2HXPnbnomgGMgAADlbOeXOGM42UvpOFjx3IFiSxh4Cg9XNBibbGqg1E4xCp0fLKHQqat1PuZgvQ4Oy1lg9IhWCsNUlVW3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pc7mE1psXLfjctdJVPXygfNvb+MWaLE/Mxf7W+e6PwU=;
 b=oo5a5eEHIM/LL7eTn95v2pbptPeygBuho5U0GMK7OrOnFIdXLps4CDbzBYP1YfGUnXwcPntLDsCBWX4T6kxo27WOH4nLxzX005Kj8goBJWy1TW1jeDNC5sjeki1QgpQvb/g3c7MlEgVAAQyhl6QRmh5ogTNaVbdJSubkNPVw7NQ=
Received: from DM6PR11CA0063.namprd11.prod.outlook.com (2603:10b6:5:14c::40)
 by SJ0PR12MB5424.namprd12.prod.outlook.com (2603:10b6:a03:300::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 09:21:33 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::3c) by DM6PR11CA0063.outlook.office365.com
 (2603:10b6:5:14c::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Mon, 17 Oct 2022 09:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 09:21:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 04:21:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 04:21:31 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Mon, 17 Oct 2022 04:21:30 -0500
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Program GC registers through RLCG interface in
 gfx_v11/gmc_v11
Date: Mon, 17 Oct 2022 17:21:00 +0800
Message-ID: <20221017092059.68674-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT059:EE_|SJ0PR12MB5424:EE_
X-MS-Office365-Filtering-Correlation-Id: 452aa9aa-314c-45fc-f89f-08dab020fb31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: COmlawfJREIwKNkrvXjdTUmsSQrErKU3mIM8zvPTDvPYub5qdNkrlwZ3Y1OF3DXibC5H+4J+Si7ZZWpn0oydL7gISEmqOwiHLsI9dwcdylph4uzZNQX3SMhPZn9adbBETL3QeiTATlH4LUXPK2Ojxtx48mpltnbvzCrzQpXiLPNILI6Tif8ofgt8UbFYxZM+VA8KS4hTuZqNvfExFufc5RyJvmQlZwWLgknHAyAXAa3JO9I+fY9EJn/aSKX1H3LWQRNLc0JnatDFamOnsGWsGPAqm6ufYiMeVefWFqK2qP23YLfbX/xXYOsDlnkUzpmd+5Db/iC6Dmo6TI/YguHbK5i1Ka2UXIBWJLHK+LonxZOpW/8eBtDhrzT27rIAyCzmQC3BVFVjD+5tWcvJXuJpVsBWp0begAkAwSzdRUk0Bq+4oJe8VLo6iJBu1kYbQ5AJXBPr6R2I71XEOXimNxlBA/dfJDA2zHQYwAmUbw4OD3YI3ISXU0dypFl6nwfpQBAi+1i2jo+P+KS+W7tJgDoaAnqJLeY7IGIxFOCHqg0/1HtXBhV6DDtG+LVe+5XkwwKaiEIorEsNlr3yLbkEHKGGdNHlXwYGZVMlb6r6riLPqEyhLJoDGQbMqryB98XN6mkwb/WjAbM3Fg1Vqetz5DZfU1jcll2wOlT733jcHyPCotgZ0uO4W1VGV185XOOyz3BnbNJpdDocaweHr2k1oUPHiplkIRU70GCzSPNVcABwbhc8OIW/DJOqVohABi/DSmv0MSY126u/pPDmkGcacRC0AXcnu+Ou2BrsyoImySpbhdRVI/cEr0ov0N3vNE3QMQGUc1x0gY+fsaYQlxtw1xFIzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(41300700001)(8936002)(4326008)(5660300002)(82740400003)(54906003)(6636002)(316002)(426003)(336012)(1076003)(82310400005)(478600001)(36756003)(70586007)(70206006)(186003)(26005)(2616005)(6666004)(47076005)(86362001)(8676002)(2906002)(36860700001)(83380400001)(110136005)(40480700001)(81166007)(40460700003)(356005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 09:21:32.5363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 452aa9aa-314c-45fc-f89f-08dab020fb31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5424
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
Cc: Horace.Chen@amd.com, haijun.chang@amd.com, Yifan Zha <Yifan.Zha@amd.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
L1 blocks most of GC registers accessing by MMIO.

[How]
Use RLCG interface to program GC registers under SRIOV VF in full access time.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c         | 18 +++++++++++-------
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index 0b0a72ca5695..7e80caa05060 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -111,7 +111,7 @@ static int init_interrupts_v11(struct amdgpu_device *adev, uint32_t pipe_id)
 
 	lock_srbm(adev, mec, pipe, 0, 0);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, regCPC_INT_CNTL),
+	WREG32_SOC15(GC, 0, regCPC_INT_CNTL,
 		CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
 		CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 73106f53246d..e3842dc100d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1571,7 +1571,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
 		WREG32_SOC15(GC, 0, regSH_MEM_BASES, sh_mem_bases);
 
 		/* Enable trap for each kfd vmid. */
-		data = RREG32(SOC15_REG_OFFSET(GC, 0, regSPI_GDBG_PER_VMID_CNTL));
+		data = RREG32_SOC15(GC, 0, regSPI_GDBG_PER_VMID_CNTL);
 		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
 	}
 	soc21_grbm_select(adev, 0, 0, 0, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 846ccb6cf07d..66dfb574cc7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -186,6 +186,10 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	/* Use register 17 for GART */
 	const unsigned eng = 17;
 	unsigned int i;
+	unsigned char hub_ip = 0;
+
+	hub_ip = (vmhub == AMDGPU_GFXHUB_0) ?
+		   GC_HWIP : MMHUB_HWIP;
 
 	spin_lock(&adev->gmc.invalidate_lock);
 	/*
@@ -199,8 +203,8 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	if (use_semaphore) {
 		for (i = 0; i < adev->usec_timeout; i++) {
 			/* a read return value of 1 means semaphore acuqire */
-			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_sem +
-					    hub->eng_distance * eng);
+			tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
+					    hub->eng_distance * eng, hub_ip);
 			if (tmp & 0x1)
 				break;
 			udelay(1);
@@ -210,12 +214,12 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
 	}
 
-	WREG32_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
+	WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req, hub_ip);
 
 	/* Wait for ACK with a delay.*/
 	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_ack +
-				    hub->eng_distance * eng);
+		tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_ack +
+				    hub->eng_distance * eng, hub_ip);
 		tmp &= 1 << vmid;
 		if (tmp)
 			break;
@@ -229,8 +233,8 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 		 * add semaphore release after invalidation,
 		 * write with 0 means semaphore release
 		 */
-		WREG32_NO_KIQ(hub->vm_inv_eng0_sem +
-			      hub->eng_distance * eng, 0);
+		WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
+			      hub->eng_distance * eng, 0, hub_ip);
 
 	/* Issue additional private vm invalidation to MMHUB */
 	if ((vmhub != AMDGPU_GFXHUB_0) &&
-- 
2.25.1

