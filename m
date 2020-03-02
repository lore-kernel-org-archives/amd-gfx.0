Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CCCC3F2D7
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 19:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB48B2173E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 19:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iFpVLQyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB48B2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CBC96E44E;
	Mon,  2 Mar 2020 19:24:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87EAF89D9B
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 19:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cm8Fc/ouNf/vEuedIzoi3jdm4O3riUGPd+7TSrAqHcKgKeStEhOTCHyQQMzKTCFobKIq9y1HLebFdXYJTcMro74t3+VFInOyAJRNfzd94myuhCzTdIUAIZEX8f6yd+byx/eX9djRmZaZTpXC/jevhyORiHgLQwikic3bWxPlsJIV2aZWGAF6n2Fd9c9DqF2RGGfzyzwrrM1QN1ZbBIdcI7GqfQR2nV/tmPoYW3u2sPi4IrX57OOLooucXsZ3PSD9afs6E/f7arya2SfxIrWukQljzpzjn4a+psvDyZBwj1To5r8TJPvYEdQOx+OxC3oPOQ3TcYPfW+GIqKxbED/AMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWKGUUAGV3zKlKZivzHDU3OLy5h7T26GptQRMPC13cA=;
 b=hyd4v7L5GwramQnCdt5U+BidUWEH+g662A84HtIUgH/3wOaZ2XFclw/Ku7XZvtXa66NJWcKkR7HbZ7zME+u3ftoanoiIpWQYyGqkkvW0UeeoD3UYSufDvitIQrye9oiwQGkSGjKeW6LDwt1c1G6JLkf85dQWX14a5CsCypJG5EdeAUMT2ylADzfzxGt1y7NNCquF8J1S5eUP5ywQs+48U2R37nuIBQ6s6Aho3xNT5foFFVoINwxYgoyq1qJGBgoc5elurfREgA7FJxAhHbbG246OQky7vmIGa+dqiTO7j1sTAlYRpUX5KXQSGQh8PnfTxReYJ6t+TS8w7Iyk0ol0rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWKGUUAGV3zKlKZivzHDU3OLy5h7T26GptQRMPC13cA=;
 b=iFpVLQyUHnHL+F0RHlamxJxLZXHwOy1nfqjUsE2Aplm4abYhelxtpb9j3U/0lx2JYlZ/O7G4YJ6S88FCk643fNZNWtbegeGuNf0rhcZ/TWt4qXTjIDuS0TPUjRczIs75CnYrkW1f9qI/UfxRhvGAlBsnZIbxUzk8pGqSICU7Gco=
Received: from MW2PR16CA0061.namprd16.prod.outlook.com (2603:10b6:907:1::38)
 by BN6PR1201MB0132.namprd12.prod.outlook.com (2603:10b6:405:4d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 19:24:30 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::8) by MW2PR16CA0061.outlook.office365.com
 (2603:10b6:907:1::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend
 Transport; Mon, 2 Mar 2020 19:24:30 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 19:24:29 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Mar 2020
 13:24:28 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 13:24:28 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: Add USBC PD FW load to PSP 11
Date: Mon, 2 Mar 2020 14:24:20 -0500
Message-ID: <1583177061-3115-3-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583177061-3115-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1583177061-3115-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(428003)(189003)(199004)(2906002)(316002)(54906003)(4326008)(44832011)(5660300002)(26005)(86362001)(356004)(6666004)(426003)(36756003)(336012)(81156014)(8936002)(8676002)(6916009)(70586007)(81166006)(186003)(2616005)(478600001)(70206006)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB0132; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e5758c3-52ce-4246-f8bc-08d7bedf5456
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0132:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0132B69F7208A7155A1B0356EAE70@BN6PR1201MB0132.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RdBgQGCXpQHe+KIPXIloi1Vsxw3kxzdA/bhtPFCCaZ475MHUN0dX9dmQsbS5wzfE5TGp8bgAy61/JMmcTbXK5oNCodH4NPciH7y2KBkZGE8FhSMpFAVpGfAEfYle6ixRqgZp7ZCGcSQSGdA8igQwfn4xL/IC8Gwpq3gXtva9d6wrb9x5B017mtdAy0iP1E1jsYoHOi87RtsYGeeGyu/8QW9TWn9PzG9b4tEi9xhj1ycPAenMf2BSe+khx/EzVOMdkKZgAUgkIrL2QvI4DdgKz+crDBz4/BXE4mIs41YrYEX4jf9OkigtHxhAk3vLB6cWoAERL90CczpYu0WYDHiajV1KCQp4sgETDtFNlpSc5PCyye6UNsOTTnW1Lw4zks0izteSF+BgypO6+f8a3VohtJBNJMaf07ldyu1h4jO1MKupTSxxIFP6uSib7c63O2qc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 19:24:29.6595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5758c3-52ce-4246-f8bc-08d7bedf5456
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0132
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
Cc: Alexander.Deucher@amd.com, Slava.Abramov@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the programming sequence.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 76 ++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 8ab3bf3..621b99c 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -65,6 +65,9 @@ MODULE_FIRMWARE("amdgpu/arcturus_ta.bin");
 /* memory training timeout define */
 #define MEM_TRAIN_SEND_MSG_TIMEOUT_US	3000000
 
+/* USBC PD FW version retrieval command */
+#define C2PMSG_CMD_GFX_USB_PD_FW_VER 0x2000000
+
 static int psp_v11_0_init_microcode(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
@@ -1109,6 +1112,77 @@ static void psp_v11_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);
 }
 
+static int psp_v11_0_load_usbc_pd_fw(struct psp_context *psp, dma_addr_t dma_addr)
+{
+	struct amdgpu_device *adev = psp->adev;
+	uint32_t reg_status;
+	int ret;
+
+	/* Write lower 32-bit address of the PD Controller FW */
+	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, lower_32_bits(dma_addr));
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
+			     0x80000000, 0x80000000, false);
+	if (ret)
+		return ret;
+
+	 // Fireup interrupt so PSP can pick up the lower address
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
+
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
+			     0x80000000, 0x80000000, false);
+	if (ret)
+		return ret;
+
+	 // Fireup interrupt so PSP can pick up the upper address
+	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x4000000);
+
+	/* FW load takes long time */
+	while(psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
+					     0x80000000, 0x80000000, false))
+		msleep(1000);
+
+	reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
+
+	if ((reg_status & 0xFFFF) != 0) {
+		DRM_ERROR("Upper address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %02x...\n",
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
+
+	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_FW_VER);
+
+	while(psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
+				     0x80000000, 0x80000000, false))
+		msleep(1);
+
+	*fw_ver = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36);
+
+	return 0;
+}
+
 static const struct psp_funcs psp_v11_0_funcs = {
 	.init_microcode = psp_v11_0_init_microcode,
 	.bootloader_load_kdb = psp_v11_0_bootloader_load_kdb,
@@ -1133,6 +1207,8 @@ static const struct psp_funcs psp_v11_0_funcs = {
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
