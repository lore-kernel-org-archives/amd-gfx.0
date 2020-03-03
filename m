Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F5BC3F2D7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 21:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BACC920870
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 21:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rhbG5o2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACC920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88EDC6E964;
	Tue,  3 Mar 2020 21:54:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C383B6E95F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 21:54:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A27GuDaNqpyHfud67YEn6C8Ol3fBGr4WwptxuOVXKeoQKhX4NED7y1IYKYNF9vB1a1btSIQLPRQYcFMBkBer1RU7bbj1DpgzGyU294LyC1XsjX6V6nsU2xHKhNKPcRPzYuvkSLOJUYhzKDNA76mzz0nZMcCi69CUqvYOzwksTlxh6dEb21ZzQdiyLRtBn0t9WD6KU3fmJr79qHH0fFbWPIt9RxxLK0kvDCOMtxIUuQK3m219Ah/MO6YdcuEeUsM0Ho1RhsOP8ZlzF+oiG4x4l5Xc0J/StIIQX1zxbybPp8FIrWLn7vCGTb8zEO5UB/FWnGKIzjxeP+BIR8/Ve67uVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFTiZuMOKeB1rQiBOO6s8vh6LUhmgYpVOdt4ZX/d+g0=;
 b=INxfVk15CjraNIS1jARJ6/mfTA0EAVQzSQUuO4hCbi/ncZPVJ1O2n29sy4AXLc1qDNEUDqjvUQsRTBhw1EjSjzbI5s6vPBZUrVDePchkSDVEkC6g03B7FxaHUmE28QWXigX3mXuW5+0708BwxqTet/5xRBgxSakzefISjnmn2h+9i8HCOQUULP8f36bB/o3H790yNPgaLcNPQBxH8//X6ieaLbtSlUj7HSPpyajtlLALrJws3RDAi3LmoQkf5AHNbsHlUExQVI3sEvgKlaUGY5JtlzPqQg326DJoPOLJqjZ0FdyjQAvRZsVGCIARtxP2wF1vvyQZORHJPWMk9nEBmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFTiZuMOKeB1rQiBOO6s8vh6LUhmgYpVOdt4ZX/d+g0=;
 b=rhbG5o2nDRKAMrrjl1WCR0xRQW/eEyKHhKHyW+5LkTW23mqhhx2k4+xlFyteLpjBXsDZp9DPJVYi4osParh29r4PB9huoUc8kIB5SDrC7hvXht9AvqnSq/l7yVKcKQ7MNx+QeEf7V0KH0EX2KC6aVVSmxeoj60GmQ/fasw/Ap/A=
Received: from MWHPR14CA0054.namprd14.prod.outlook.com (2603:10b6:300:81::16)
 by BN6PR12MB1251.namprd12.prod.outlook.com (2603:10b6:404:1a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 21:54:34 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::7e) by MWHPR14CA0054.outlook.office365.com
 (2603:10b6:300:81::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Tue, 3 Mar 2020 21:54:34 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Tue, 3 Mar 2020 21:54:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 3 Mar 2020
 15:54:32 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 3 Mar 2020
 15:54:32 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 3 Mar 2020 15:54:31 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/3] drm/amdgpu: Add USBC PD FW load to PSP 11
Date: Tue, 3 Mar 2020 16:54:26 -0500
Message-ID: <1583272467-25895-3-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583272467-25895-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1583272467-25895-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(428003)(189003)(199004)(426003)(26005)(4326008)(81166006)(54906003)(36756003)(81156014)(44832011)(5660300002)(2616005)(316002)(336012)(8936002)(6916009)(186003)(6666004)(8676002)(356004)(86362001)(478600001)(2906002)(70586007)(70206006)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1251; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d85d8244-7915-40fe-90c5-08d7bfbd756b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1251:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1251B4847FB779E36381C1CCEAE40@BN6PR12MB1251.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 03319F6FEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Wf0QXLGVeMyJsxvk8QZcn98fKJZ97hU8qjdAC95FaOWUX2KnfBHPlEsIGvOgVtLU26GOhfqHIEjAV2/E4Rt7tCw6ymGlKGRjcwSkiWY1NdC7HeEn1FYR9ugOIEHJvGBk5Nkof5FKP1Hw5pUnV9Nf1RZGHgSgoYl9wIgbpacMH/oA4HvHQSbFomXFkoUxAms0iKXeGB+3ECyZM1vXmMdiTT12+0PHIjdL8WfJwIh79ENtiA1L3XJBHfIPCJ5gSTzY1hgz7UWvg+uLb58S5kEBqJsa/VmRf3/J1jJkeGiCqILKrqyP7uf1WQu2vuzApGi5ZDhijW8Hqnw0AEBkiwyTTmqdNf6IS8elHCsz97iqZkt65WuZqFWEfyUtaE42RjlTr35RyUTd4BC4GxNXjiDXarB5CRkYZbUl+PiirLr0KjmBlarGeyx1Kv7dZhdyMgp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 21:54:33.4293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d85d8244-7915-40fe-90c5-08d7bfbd756b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1251
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
index 8ab3bf3..2ff5f2f 100644
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
+	} while(i < USBC_PD_POLLING_LIMIT_S);
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
