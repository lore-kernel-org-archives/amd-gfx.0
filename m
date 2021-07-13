Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AA2C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 15:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8358B61175
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 15:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8358B61175
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 513586E0E5;
	Tue, 13 Jul 2021 15:30:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18EF36E0E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 15:30:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRQC2JoQnzEZ1Fn+oQrsWR5ZOGA+CPj5N3vcXPokHrslBVgSnNO5PQd/CIdzn6Eg5oX+XqEriwtD3yuVxknNFPqmBSaLiSzfps+RQgSQXKyc73OWpM8bs176n+KEmeBejx2AxiScUStlTC3CymVA/0ujt7hMvbq6LW+00ndC4g5c6yzhp2Fs1Dxy+2hTtQpWLyPqlb4CpsjBOaXCQ4XwMVJHtBC2AaoJhVWw6fiUH4Gnf64Dh3mz0DwjlxAMBQYlU/ydFekntUdSP7ZswEGqYdp186mDVPkgZ2tl5UDkbGK6lnWluCmpnWvO83ExgpY0DauNZjfZ7IYhonzjUCw5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FJnXoRnPVNEcRumz5gicG80VPegfMDak2EYs5e7uyw=;
 b=PQ9diQbh22pE7RKf4C+SsBfq2jEJXs2ZZAxKm7w7qIA209WiJ+QK/3UEfbBOqWtM9HxhcwnB9RfOCsjYSRdX/0IYAMNHUVgC9img5wia4bmZr2SX8t+8IR+SZDnznmbw7pXx/PiJs5bQeBjzMJoNdZMow/Hrcbkp6bt/ntxO9iq80OVaCHpkbezrTf7/rklLEp9cp7eOpFTHLd4JVWgCHCxQb+/Es9CnHiIVpzoqA6Jov2dcbs5LKuWzEQHwnz3+/yO7e02TyKZvCdxZ0Nkgpvl0+Lj/uzaUKgW/wtrgtymgTL7VH7BmICwSDnSZ1ckC4CLGMHh8QQtc77n+0OqO+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FJnXoRnPVNEcRumz5gicG80VPegfMDak2EYs5e7uyw=;
 b=2ufUD7yi4l9Ivvwfs9gMPF+L4vW96Bsn3v44NxQac8qd0gnqBx5jUpoQRC4uW1ZCmJcLLSuw4XGdgH3U4bbXj4MKNmZtCeMPZtVsshb3e60Q48ORpgKObSGzfCOwXPiGqhn4TfQxFAyRt5l0S1xagUTdKzJJdDSm9bSIlFt7c+E=
Received: from DM6PR02CA0168.namprd02.prod.outlook.com (2603:10b6:5:332::35)
 by DM6PR12MB3770.namprd12.prod.outlook.com (2603:10b6:5:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 13 Jul
 2021 15:30:20 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::10) by DM6PR02CA0168.outlook.office365.com
 (2603:10b6:5:332::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Tue, 13 Jul 2021 15:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 15:30:20 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 13 Jul 2021 10:30:15 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: Switch to LBF for USPC PD FW in psp v13
Date: Tue, 13 Jul 2021 11:29:56 -0400
Message-ID: <20210713152956.280078-3-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713152956.280078-1-andrey.grodzovsky@amd.com>
References: <20210713152956.280078-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85914928-ad9e-4aa6-0c3e-08d946131ff7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3770:
X-Microsoft-Antispam-PRVS: <DM6PR12MB377039046728A211249FE0C4EA149@DM6PR12MB3770.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cx/M+zoiuzbkKQF2n9b8aSqYZh95gSpbCYXUczoREYO8y01ETYdEQsqTq+2OLhUqkeM3A6PZhpM/U0kacjoGWqXb4uqeJ+9QmDmaYW0tRqdQAP7fNIhvcBFQ26IfghHa5aS6SN0hl6S5fp1W6RO1hwSVuhpTHEXsG5k2RKOWvO7UTwt4QrJdGZHvTgLtEnI72Zm832UbeARP8CzQkzuoP9ca1QS/zqyfWihMjePNgc8GvQTVMjkj4ZIrs5ozOuRhUc78z0+TLrz94Ho95+PUhHvKW8S/ldI4y8Ys8yH1dzXXis48zk9M0+UDe6kn2WaAJoV3/v9EBDc6ThG/Ntas7PHIx1xQiCP2CDzDY13ipo+3woOKpooUPn6Lme3oNssx15VVAHcu5thhAvQKQR+Q1i9tFbfJcsokRXzjhtv6buvRE20pQedpBYZAZUj6zZmpr2DafyLs4O5GsqDN/fELDDLnYPuQNaeOVtpDOqu2G2MdKkhgtoDGw/yxd5AxImFJC4ULm2Up5MQcRgz/ZXq+U79OxwlGZ2mH1MPP2lNg2khZuspaVZ0U+P04bIV+b7y4CajNY7NCeFZ8WFu6VGjl8s/FkXFjk7pz8CSaEFnLVBiLtK7rrXXz2o8eLXQiUM9hHlsBSfjumw4n0pC51dyXeMQRqwsp2VDiRpDIi+6xMi7h2WRU9wAQHJ98MSk5vPIf7H/t6iq7nq468F1ADMETpSQe4X+A99GsT95MiwzRGDo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966006)(36840700001)(8936002)(82740400003)(83380400001)(70206006)(5660300002)(356005)(336012)(26005)(2906002)(44832011)(6666004)(426003)(36756003)(1076003)(36860700001)(4326008)(8676002)(86362001)(2616005)(316002)(82310400003)(81166007)(7696005)(478600001)(186003)(6916009)(54906003)(16526019)(70586007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 15:30:20.3103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85914928-ad9e-4aa6-0c3e-08d946131ff7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3770
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

Add USBC PD FW implementation here to be used with relevant ASICs.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 66 ++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index c8949add88f3..e1046bb3bab0 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -35,6 +35,12 @@ MODULE_FIRMWARE("amdgpu/yellow_carp_asd.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_toc.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_ta.bin");
 
+/* For large FW files the time to complete can be very long */
+#define USBC_PD_POLLING_LIMIT_S 240
+
+/* Read USB-PD from LFB */
+#define GFX_CMD_USB_PD_USE_LFB 0x480
+
 static int psp_v13_0_init_microcode(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
@@ -382,6 +388,64 @@ static void psp_v13_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
 		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_67, value);
 }
 
+static int psp_v13_0_load_usbc_pd_fw(struct psp_context *psp, uint64_t fw_pri_mc_addr)
+{
+	struct amdgpu_device *adev = psp->adev;
+	uint32_t reg_status;
+	int ret, i = 0;
+
+	/*
+	 * LFB address which is aligned to 1MB address and has to be
+	 * right-shifted by 20 so that LFB address can be passed on a 32-bit C2P
+	 * register
+	 */
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36, (fw_pri_mc_addr >> 20));
+
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
+			     0x80000000, 0x80000000, false);
+	if (ret)
+		return ret;
+
+	/* Fireup interrupt so PSP can pick up the address */
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_35, (GFX_CMD_USB_PD_USE_LFB << 16));
+
+	/* FW load takes very long time */
+	do {
+		msleep(1000);
+		reg_status = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_35);
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
+		DRM_ERROR("Address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %04x\n",
+				reg_status & 0xFFFF);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int psp_v13_0_read_usbc_pd_fw(struct psp_context *psp, uint32_t *fw_ver)
+{
+	struct amdgpu_device *adev = psp->adev;
+	int ret;
+
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_FW_VER);
+
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
+				     0x80000000, 0x80000000, false);
+	if (!ret)
+		*fw_ver = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36);
+
+	return ret;
+}
+
 static const struct psp_funcs psp_v13_0_funcs = {
 	.init_microcode = psp_v13_0_init_microcode,
 	.bootloader_load_kdb = psp_v13_0_bootloader_load_kdb,
@@ -393,6 +457,8 @@ static const struct psp_funcs psp_v13_0_funcs = {
 	.ring_destroy = psp_v13_0_ring_destroy,
 	.ring_get_wptr = psp_v13_0_ring_get_wptr,
 	.ring_set_wptr = psp_v13_0_ring_set_wptr,
+	.load_usbc_pd_fw = psp_v13_0_load_usbc_pd_fw,
+	.read_usbc_pd_fw = psp_v13_0_read_usbc_pd_fw
 };
 
 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
