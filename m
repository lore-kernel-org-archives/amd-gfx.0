Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E849C07E96
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 15:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC966023F
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 15:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC966023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 219D56E0E4;
	Tue, 13 Jul 2021 15:30:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 802EC6E0DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 15:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSC4SSePgJHgh3YuhqpYpBGFijLpWGDfAnx0HVkwqj/rJOuvqWYU1cgJbbwEfnVCzGXjT4ihSyGwGs6zrdlcACO46j47Hl4aE6XjME4ExE/JH/DqJpMDcREQHh7GWq0VR4Kz4KYZjWybY1n2KH52QQ8EGbOGWlZylxIIDHNa3oEFvGP6CqGNvnsI7dbX61vX0LhBG/msKVYCulg0gqXphsmMwzhB3PUEV8aRycZx6FZC4n8Ntq2VbdUSzqy6CXhMVyCQVLUMmtdHvZStkIRppdmZzvhNsh9FD7ruuzxWzSMWS+FNZFKjyKTw/7V21OW6+BKhUfRv7go5XjsZRe9jfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9/zGTQzcVRc0AGFV9PX1L3vnm3nJrSVG1J9AZ4/a48=;
 b=ahEKDwN2sZAxJenH9cO0eYVtdJ4Psoq/vJBiifooguTpOXneu66apKyNvGzZZBhe9gUxbOX/Ta2pB/iArC4QIAs0TMo+IqdsIueVkK1+ZFut+lKLMlcBVTrmhCn2ek8zrA5lLK0o0c/50P4qgaxOraOm5+GxGo64mwIs7RzjzTLJlfn04zdKIziVtbbGM0ibMVvGyB3N5kpq+wCaAcp8KV8wls0BCdLGgGyxb/B/EaPnJJHPKMKiM/gwCVowVCl3kg4VnV1XNzZtow6HBTo+/s0LvFZgD80PrVDfLPHEbCGdyDL6uJ18yC+vFYuYXfBiAN9tX97WSSyOqyBgHhSkmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9/zGTQzcVRc0AGFV9PX1L3vnm3nJrSVG1J9AZ4/a48=;
 b=aIsYsI3y+5QhgQ37IsNwoXEFmjrqZbxYlK8BEsRC1PUHG8J7czjTZUSflfNkVTL916xqwRSJQhk9p/KLSG4zW/dct13bBlbVy7kBfrWigcgkCTjSmkkf7u+TB9xVqSJnkbJFuOWZxnr5CjiAihg2fIyTnxjtcUtbRRsJuqnwTc8=
Received: from BN6PR11CA0064.namprd11.prod.outlook.com (2603:10b6:404:f7::26)
 by BL1PR12MB5095.namprd12.prod.outlook.com (2603:10b6:208:31b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Tue, 13 Jul
 2021 15:30:16 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::5b) by BN6PR11CA0064.outlook.office365.com
 (2603:10b6:404:f7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 13 Jul 2021 15:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 15:30:15 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 13 Jul 2021 10:30:14 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: Switch to LBF for USPC PD FW in psp v11
Date: Tue, 13 Jul 2021 11:29:55 -0400
Message-ID: <20210713152956.280078-2-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713152956.280078-1-andrey.grodzovsky@amd.com>
References: <20210713152956.280078-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c1aacd7-4114-463c-2bee-08d946131d45
X-MS-TrafficTypeDiagnostic: BL1PR12MB5095:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5095682AC4AAD01B283C8D0AEA149@BL1PR12MB5095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HBAUsWhcWkx1C1jTOCfCywjkC0Y7DRz32J8ZLvpCS0NW8ESkSVP4uh66GPXrKMeyC3gQYr2X0CR9v8DWIpDLg92Na7+b8CnN1TMrYjD3QF8Y5kdpwp31JkFcpuyjjs8VgYKL7dSWzRnMIUyapUZqFsCm+2KusxPEKc0gmKiOYwesmcoX7SS6E9x1rkJ8LiCQpdNGb2HTYUjAi3JTNAI+03URt11n5v/BTzgmOiNG1uic6XZ8mKqoM1AutzDtV/r92FuH54EDFaCHaObh3m477bd+SdaNVKMa0mmXQCZGiePYNz53c7/h9bAnDul0vbybOF4uc7+Vru2exIey+fVLHpS9pTY5mLlRdMcry5xbbNbyIfr8tnn8Cixq7mS5RrIBt4Piql2aU5c+WbD/a/KuCBMurEWSm606AYDY7Wi1rP8YQCD/x3gctS0bqouny/q93n16fM+LRh7mnjdOhq4jWmO2xX7eDSiG7EwSxjaKy8LxI3Y71aveAHp1vgA7p5tuJ8odeER5VCtPgu5+fjJfb2vwHRx0v+cQZ+/bWXDN/QsV528M0JWRiTxqSh59Xdjr1I7aEPZ2/IUDO+INdqOslav0X3hjCBMoMwGljUa3ht+LI9TQYCq05DvF0udZW+jsjDEOXgOeA21mwK2O/EiNHAf0Huxq7+FM8ZE4IUDVRy92JQAcYBn/wlB70Qi2UHpPZEyx3P9MJO7+NCRZsCUR8pZ87sCyYKw+6MkHiX0R2eY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966006)(36840700001)(16526019)(26005)(70586007)(186003)(82740400003)(356005)(82310400003)(7696005)(8676002)(4326008)(83380400001)(2906002)(70206006)(86362001)(6666004)(6916009)(81166007)(8936002)(1076003)(426003)(2616005)(478600001)(44832011)(336012)(5660300002)(54906003)(36860700001)(36756003)(47076005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 15:30:15.8461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1aacd7-4114-463c-2bee-08d946131d45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5095
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
Cc: Alexander.Deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Mugunthanvenkatachari.Nagarajan@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update callback signature and update  implementation.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  6 ++--
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 41 ++++++++-----------------
 2 files changed, 16 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index e5dcc6713861..200d19139e73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -106,7 +106,7 @@ struct psp_funcs
 	int (*mem_training)(struct psp_context *psp, uint32_t ops);
 	uint32_t (*ring_get_wptr)(struct psp_context *psp);
 	void (*ring_set_wptr)(struct psp_context *psp, uint32_t value);
-	int (*load_usbc_pd_fw)(struct psp_context *psp, dma_addr_t dma_addr);
+	int (*load_usbc_pd_fw)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
 	int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver);
 };
 
@@ -414,9 +414,9 @@ struct amdgpu_psp_funcs {
 #define psp_ring_get_wptr(psp) (psp)->funcs->ring_get_wptr((psp))
 #define psp_ring_set_wptr(psp, value) (psp)->funcs->ring_set_wptr((psp), (value))
 
-#define psp_load_usbc_pd_fw(psp, dma_addr) \
+#define psp_load_usbc_pd_fw(psp, fw_pri_mc_addr) \
 	((psp)->funcs->load_usbc_pd_fw ? \
-	(psp)->funcs->load_usbc_pd_fw((psp), (dma_addr)) : -EINVAL)
+	(psp)->funcs->load_usbc_pd_fw((psp), (fw_pri_mc_addr)) : -EINVAL)
 
 #define psp_read_usbc_pd_fw(psp, fw_ver) \
 	((psp)->funcs->read_usbc_pd_fw ? \
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 3e6218799a0c..21b8b6d48d8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -79,6 +79,9 @@ MODULE_FIRMWARE("amdgpu/beige_goby_ta.bin");
 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
 
+/* Read USB-PD from LFB */
+#define GFX_CMD_USB_PD_USE_LFB 0x480
+
 static int psp_v11_0_init_microcode(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
@@ -753,44 +756,26 @@ static void psp_v11_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);
 }
 
-static int psp_v11_0_load_usbc_pd_fw(struct psp_context *psp, dma_addr_t dma_addr)
+static int psp_v11_0_load_usbc_pd_fw(struct psp_context *psp, uint64_t fw_pri_mc_addr)
 {
 	struct amdgpu_device *adev = psp->adev;
 	uint32_t reg_status;
 	int ret, i = 0;
 
-	/* Write lower 32-bit address of the PD Controller FW */
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, lower_32_bits(dma_addr));
-	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
-			     0x80000000, 0x80000000, false);
-	if (ret)
-		return ret;
-
-	/* Fireup interrupt so PSP can pick up the lower address */
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x800000);
-	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
-			     0x80000000, 0x80000000, false);
-	if (ret)
-		return ret;
-
-	reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
-
-	if ((reg_status & 0xFFFF) != 0) {
-		DRM_ERROR("Lower address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %02x...\n",
-				reg_status & 0xFFFF);
-		return -EIO;
-	}
-
-	/* Write upper 32-bit address of the PD Controller FW */
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, upper_32_bits(dma_addr));
+	/*
+	 * LFB address which is aligned to 1MB address and has to be
+	 * right-shifted by 20 so that LFB address can be passed on a 32-bit C2P
+	 * register
+	 */
+	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, (fw_pri_mc_addr >> 20));
 
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
 			     0x80000000, 0x80000000, false);
 	if (ret)
 		return ret;
 
-	/* Fireup interrupt so PSP can pick up the upper address */
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x4000000);
+	/* Fireup interrupt so PSP can pick up the address */
+	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, (GFX_CMD_USB_PD_USE_LFB << 16));
 
 	/* FW load takes very long time */
 	do {
@@ -806,7 +791,7 @@ static int psp_v11_0_load_usbc_pd_fw(struct psp_context *psp, dma_addr_t dma_add
 done:
 
 	if ((reg_status & 0xFFFF) != 0) {
-		DRM_ERROR("Upper address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = x%04x\n",
+		DRM_ERROR("Address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = 0x%04x\n",
 				reg_status & 0xFFFF);
 		return -EIO;
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
