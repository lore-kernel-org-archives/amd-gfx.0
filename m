Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EB9C3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 22:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ACE720870
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 22:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AMq9ivzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACE720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F216E964;
	Tue,  3 Mar 2020 22:02:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C77B6E964
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 22:02:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zxrzdna9X5Tv2SDoLxyECP+Ck9RozXNJZl8ITOyKk0Akb75OxDpHCogzw7sNGPDi1AvY0fLXi9/ZeOvk8I0JRNj352oNrseHwDddXGitcEuKpry5MqA+v6oLidgO5tyXhOoOO8M43BjavREso0/T8JetJtIPHDpkNkFiCaewqklzPPIFEaYSVsBrgG+gvAGf03JrIA639kWp+fAo5XuOZdwOiCgUkGZJsUv9Vfcp078dh2GOzmLmc+lpHpwkerJD19qYn4NxYtGRqlA3Sxu/XKeStDGHo1bbNgWJBZbvcS/Re7oYahzsNJ+wzZDSjaXFNJ60EQmoWl+TNYxqPh4f7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aqnp8/DeZU+XfQItFIJ5yF6c9ofy3Mt6NJomF6QXyo=;
 b=FLQYCNggqGu8mmxoiYKSEaRAhLd96aOXeHsGBc13h6WzpXfYNWNpxfRmjjjn+WAydcLw6nMlkpmFqFPO52mnCysNow598dZJFvMRrmpU/rxARFFG4JjM5SnQx7UKQZqHPw1nggGimAq2wGd++e46Rvpl0hdWCrYd7AZjmuEknSuizDbjw+5qR4LZoRwlMBVZMMowqKEAPKI9bzFbSD3DkPl93+VIT2W2YTielt5iff+/BIWUuwOH+GIEkL1Sr8ErAwJ4pf/U22qyKbrFjwuUaRPqRwS4BCbi/r+s+ydXjUHlQAKSIpUrtREbW5tPWueyKk+QBOkP+syc6OYXeH/Upg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aqnp8/DeZU+XfQItFIJ5yF6c9ofy3Mt6NJomF6QXyo=;
 b=AMq9ivzENxEv7QHyb0+ZZWB+hkMeJ5PqnM64T3fszL7BoGC4yvqomHHnUplByG8gnkwQUyFsthwmj828BuBcL0h5YONudgUig4VolYQf1uZNAYi9dIrdFEUhYJ1tbJigg0CAuc9zRTWpRJnCL5CpCr75Gdj8+0n3iIF8qc9G/LU=
Received: from BN6PR18CA0016.namprd18.prod.outlook.com (2603:10b6:404:121::26)
 by BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Tue, 3 Mar
 2020 22:02:14 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::fc) by BN6PR18CA0016.outlook.office365.com
 (2603:10b6:404:121::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Tue, 3 Mar 2020 22:02:14 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Tue, 3 Mar 2020 22:02:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 3 Mar 2020
 16:02:13 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 3 Mar 2020
 16:02:13 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 3 Mar 2020 16:02:12 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/3] drm/amdgpu: Add USBC PD FW load to PSP 11
Date: Tue, 3 Mar 2020 17:02:08 -0500
Message-ID: <1583272929-1038-3-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583272929-1038-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1583272929-1038-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(346002)(428003)(199004)(189003)(186003)(336012)(36756003)(426003)(2616005)(478600001)(8676002)(70206006)(81156014)(81166006)(70586007)(8936002)(6916009)(7696005)(86362001)(44832011)(54906003)(316002)(6666004)(5660300002)(356004)(26005)(4326008)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB4179; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16215380-808e-444d-21e5-08d7bfbe87c8
X-MS-TrafficTypeDiagnostic: BY5PR12MB4179:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4179ABD62671421101E50FFEEAE40@BY5PR12MB4179.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 03319F6FEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8jig8IC7f5QaFgXSFEeq4bm3GHtobFKIzLGZIc88ybXevx2TACSzYk3sDjBncr7RK2NPJTf+zaeC8zL/e/eu8xQrGUlYrKwPJEfJ6yqSY8tQakg2QAPHj+mhZvpekR7MxTQjdZK4HIqT/r6+zsztVrebfTdLVYN3cGf8Ub8jOiAJ1PY9q/XjYkmOWNyAcXXhteGrn5gIgyjM6haotuezUl2JX1o8h+WqOEtWFb0bnKr6s2tRBHmBlcze3LgaFvVU1XkMnQ3bg/HWu0yflIa3yWEXsqcx0Rje0qyuJorvJTNkrKPxFHCYOndroNnKI07fn5Da1mNj8qlX90gLsUPV9Ct4kVbZhEEJ3BDzn5bI5Err4C6iCcf7I1WF0MMDwbEHCl1aCBq406B8iE/xhl1JawstTmO5MV2Gv2986gjMzWQLKxepyZ/qaYm+klCs3qr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 22:02:13.8526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16215380-808e-444d-21e5-08d7bfbe87c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4179
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
Cc: Alexander.Deucher@amd.com, Slava.Abramov@amd.com, luben.tuikov@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the programming sequence.

v2:
Change donwload wait loop to more efficient.
Move C2PMSG_CMD_GFX_USB_PD_FW_VER defintion

v3: Fix lack of loop counter increment typo

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 82 +++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 36b6579..a44fd60 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -31,6 +31,9 @@
 #define GFX_CMD_RESERVED_MASK       0x7FF00000
 #define GFX_CMD_RESPONSE_MASK       0x80000000
 
+/* USBC PD FW version retrieval command */
+#define C2PMSG_CMD_GFX_USB_PD_FW_VER 0x2000000
+
 /* TEE Gfx Command IDs for the register interface.
 *  Command ID must be between 0x00010000 and 0x000F0000.
 */
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 8ab3bf3..3db1c0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -65,6 +65,9 @@ MODULE_FIRMWARE("amdgpu/arcturus_ta.bin");
 /* memory training timeout define */
 #define MEM_TRAIN_SEND_MSG_TIMEOUT_US	3000000
 
+/* For large FW files the time to complete can be very long */
+#define USBC_PD_POLLING_LIMIT_S 240
+
 static int psp_v11_0_init_microcode(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
@@ -1109,6 +1112,83 @@ static void psp_v11_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);
 }
 
+static int psp_v11_0_load_usbc_pd_fw(struct psp_context *psp, dma_addr_t dma_addr)
+{
+	struct amdgpu_device *adev = psp->adev;
+	uint32_t reg_status;
+	int ret, i = 0;
+
+	/* Write lower 32-bit address of the PD Controller FW */
+	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, lower_32_bits(dma_addr));
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
+			     0x80000000, 0x80000000, false);
+	if (ret)
+		return ret;
+
+	/* Fireup interrupt so PSP can pick up the lower address */
+	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x800000);
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
+			     0x80000000, 0x80000000, false);
+	if (ret)
+		return ret;
+
+	reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
+
+	if ((reg_status & 0xFFFF) != 0) {
+		DRM_ERROR("Lower address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %02x...\n",
+				reg_status & 0xFFFF);
+		return -EIO;
+	}
+
+	/* Write upper 32-bit address of the PD Controller FW */
+	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, upper_32_bits(dma_addr));
+
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
+			     0x80000000, 0x80000000, false);
+	if (ret)
+		return ret;
+
+	/* Fireup interrupt so PSP can pick up the upper address */
+	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x4000000);
+
+	/* FW load takes very long time */
+	do {
+		msleep(1000);
+		reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
+
+		if (reg_status & 0x80000000)
+			goto done;
+
+	} while(i++ < USBC_PD_POLLING_LIMIT_S);
+
+	return -ETIME;
+done:
+	reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
+
+	if ((reg_status & 0xFFFF) != 0) {
+		DRM_ERROR("Upper address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = x%04x\n",
+				reg_status & 0xFFFF);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int psp_v11_0_read_usbc_pd_fw(struct psp_context *psp, uint32_t *fw_ver)
+{
+	struct amdgpu_device *adev = psp->adev;
+	int ret;
+
+	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_FW_VER);
+
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
+				     0x80000000, 0x80000000, false);
+	if (!ret)
+		*fw_ver = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36);
+
+	return ret;
+}
+
 static const struct psp_funcs psp_v11_0_funcs = {
 	.init_microcode = psp_v11_0_init_microcode,
 	.bootloader_load_kdb = psp_v11_0_bootloader_load_kdb,
@@ -1133,6 +1213,8 @@ static const struct psp_funcs psp_v11_0_funcs = {
 	.mem_training = psp_v11_0_memory_training,
 	.ring_get_wptr = psp_v11_0_ring_get_wptr,
 	.ring_set_wptr = psp_v11_0_ring_set_wptr,
+	.load_usbc_pd_fw = psp_v11_0_load_usbc_pd_fw,
+	.read_usbc_pd_fw = psp_v11_0_read_usbc_pd_fw
 };
 
 void psp_v11_0_set_psp_funcs(struct psp_context *psp)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
