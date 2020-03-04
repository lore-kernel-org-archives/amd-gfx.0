Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D819CC3F2CE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 16:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA75A2146E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 16:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ebaXOy3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA75A2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D6C6E081;
	Wed,  4 Mar 2020 16:23:54 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700058.outbound.protection.outlook.com [40.107.70.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C486E081
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 16:23:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLQ1Ko9foShx5uRB7H/hmqEW7qqI3muL6IDJZjUvWvHO/xehuIjth+nKpwqwRCVfGEKL9ild96PDZ4KbcR4YIH/WMSLm5X74i90UHZDD8MNH+8GK0cMtWqCK1D57mutnOu/oS/YlJe+PIBEeU7o+mCtK0RbdfyISL3qOTgy+rFzHEWG6omXQPNXkiU7jwfraK8/rhcMCDOSJlvGdjpQsnM16uiPNf8aIDfDzxtx8hSNPeZLFBomooJlNVJA+zAfc2DqFLtSDwBMITqD5obNAGDNUY0/2pSVPlASeZSg69AwbTHPOJd6I18+dx6/3fNCz6ANLIpMBR8oLut+kVhSSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZatrMGEjYvCjKzF3mcEFZH7JbLciavIFMfm+nBPnVmA=;
 b=W8U6hVX7/i8XdKQLVjmDdt054JXuUbwE4aRVWMiY0kOSRaXQyB0fxu2SiZVmkFTR706vqkjQqI99J6QRnFRlhCfZ+6aGOF/KH01lLxtrrXgDyxT3UjCk7tfV4DYYsVQk0bk0VF49VjPvGS9SIyy5aQ2GZDwhfuF4nYScBTszABKAlq7KatBPb9hZC2BXaM1jRNgKRnA9SxdgqO6rCSWg7UF2sTMik8d7CVUl/VQG2+qpYXROaTpV1rySZoTr41jmY5oGYniw373NrBv5q6pZl04r53hELN8ao4AMzMbj91bZIHEHa7oA30Ad3pjMnMScFv4CO/kC0pYxICoDuhyNog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZatrMGEjYvCjKzF3mcEFZH7JbLciavIFMfm+nBPnVmA=;
 b=ebaXOy3v4BX+o9EKojDhA6HCFoi6ljeKRQYK5MWKVvVilgx86zdQQRvvSmJEZOqgOllAkvrp9qCRfOCRh7KDN10QAAOvoO8jW5s2lgS1BvHDAuJfyiTmJvds3iYCpK+MiYPQ8lxOgqbrN99OIbhin/RaODShGgzUMByVaUhP3iY=
Received: from MN2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:208:1a0::13)
 by MWHPR12MB1133.namprd12.prod.outlook.com (2603:10b6:300:d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 16:23:46 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:1a0:cafe::63) by MN2PR07CA0003.outlook.office365.com
 (2603:10b6:208:1a0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend
 Transport; Wed, 4 Mar 2020 16:23:46 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 16:23:46 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 4 Mar 2020
 10:23:45 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 4 Mar 2020 10:23:44 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 2/3] drm/amdgpu: Add USBC PD FW load to PSP 11
Date: Wed, 4 Mar 2020 11:23:40 -0500
Message-ID: <1583339021-12298-3-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583339021-12298-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1583339021-12298-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(428003)(189003)(199004)(2906002)(6666004)(8676002)(81166006)(81156014)(426003)(356004)(54906003)(36756003)(8936002)(6916009)(7696005)(5660300002)(70586007)(186003)(26005)(44832011)(86362001)(498600001)(70206006)(2616005)(4326008)(336012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1133; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f97b024c-a0a1-42e4-929d-08d7c05869ef
X-MS-TrafficTypeDiagnostic: MWHPR12MB1133:
X-Microsoft-Antispam-PRVS: <MWHPR12MB11339EAB302293724D54BDCFEAE50@MWHPR12MB1133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0332AACBC3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYEtQHb5HOSdm9pJ2ACz1gNTcrkTd/7i5jtp6abjwuIgwDrSzu5nvHlFc4WSSP5IbEYMPqrj63U7mdrUMiRMzfXXut7nyQLmv3Ap1I5aluvn6yWOj9rzBsCcVpH2uk1VKBDYQGmQBPEE8sNVZ+5fSzQVaTEWTwiRuS6Z6tp2dCVlfKiYtIlUqV/hiRPIUFFYfczAZTMHuhuAPTzJWqRKRSbkr/M/B9Fh1TAME0A85SpRzvhgaIC7EYVxRGxbcpYNRRqLx8fnbprX8K2pbZjwuY1Yx6G1FtMCFv3sfSyJXqQ6AsvATpBMy7IJ31q1hL0d5z7mVm9TKsXz2WKjRtAzC3onfToXw9cJ7+n3+JNVeSHoFEaJB7MvhmCo1HXBZEZuJv1OH1YQ1gw1SKIooOlLGIXQ7e0YxtssM+ao8nuXTYMJ5CPCstqjbO9Bkrduvwsp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 16:23:46.2748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f97b024c-a0a1-42e4-929d-08d7c05869ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1133
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

v4: Remove superflous status reg read

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 81 +++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

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
index 8ab3bf3..67dd9d2 100644
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
@@ -1109,6 +1112,82 @@ static void psp_v11_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
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
+	} while (++i < USBC_PD_POLLING_LIMIT_S);
+
+	return -ETIME;
+done:
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
@@ -1133,6 +1212,8 @@ static const struct psp_funcs psp_v11_0_funcs = {
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
