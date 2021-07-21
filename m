Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937A9C07E9B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 03:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3D661029
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 03:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3D661029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 109CA6E41A;
	Wed, 21 Jul 2021 03:02:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD3536E41A
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 03:02:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fhlzle332cD06pTN7Z8iE+3T9B54sGIXpJeVXtpm6WN2VXi4jace20NiHOmaHt57jaRCtQbuKpmnxcYYH0f1+YXu3wXkrN4zaLgFJswT56LAYrLaH1eMrA/29FcmKE08BnxdLPLOgr1oAwp8lMffS1x7YkiKys2a3FUpzY43gDN/Wjl+QzggQz5XXpB2T9bgc8/8gEbh06VIhrEW87b0IMi4kSalgLXSZuPghOYofxtMEYqnejfYwp9YlhOL9CLyB8kKEjgTxGL7m1a6UGE3g8Qlw6Tql3z/FQzPxakHGJ+1PQz1Fjg+7wpmRg0c/4COsCzUlkOjGBVpoGc6T2xrjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71wlyvauxw7q4vv3RgUK8fk+B9NcjDsBVg9QeKYZqdA=;
 b=F8N7L8AohswI3JzKcBOYDaMJcYMWtMxW3sdEnwT6ZcdRKm/Dc0/eQDUgFJuYp7zu4DLxGL+TK3QqErz6JMP2Kr80dQRiStdj4data+gbZZmc+gf1Iq+GVCfFasrZbV9oC9B6c6wXGu90e9uHzZAQf49QbXEqD1hh74RtQ39+4+hKkgwnGYrJMnJYxwalc2PORNUZkkYbmwIHlik9Kbt4UBGPawaudDoNZ3UhN0C1GK/JF8QfDKqob4Iybjz3cgWAdrwMmcewGr0z124J9+AnDbboz49pVtv8uYhA3d1YX0EYjnKjPqu3y9mAEM4ZSxE2EmVjmgzWWHN14evb0bBjAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71wlyvauxw7q4vv3RgUK8fk+B9NcjDsBVg9QeKYZqdA=;
 b=vLTSx5RaDbRICByZBd+zaKboV4aq+qQkHflJPf/FbCy7lPa6btM4AT+sPpRDZNo/i/G1l7Z63teyP6o2Et6AwdMGMr9lRxCcDk5sgKNqOQCMRBv1Hs+PxSXBVzg7ibed6fHrIjUXOFe/M7wufCzfnQvMFLqcKiO6O/RNHbiy9IE=
Received: from MWHPR13CA0041.namprd13.prod.outlook.com (2603:10b6:300:95::27)
 by CY4PR1201MB0037.namprd12.prod.outlook.com (2603:10b6:910:1c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Wed, 21 Jul
 2021 03:02:18 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::be) by MWHPR13CA0041.outlook.office365.com
 (2603:10b6:300:95::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.10 via Frontend
 Transport; Wed, 21 Jul 2021 03:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 03:02:17 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 22:02:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 20:02:16 -0700
Received: from chengzhe-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 20 Jul 2021 22:02:14 -0500
From: Chengzhe Liu <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Clear doorbell interrupt status for Sienna Cichlid
Date: Wed, 21 Jul 2021 11:02:11 +0800
Message-ID: <20210721030211.1611320-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f83ff01e-6323-47ed-0112-08d94bf3f30c
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0037:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0037FDDCCE7EB6E49060315293E39@CY4PR1201MB0037.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pb4efHSPmD/W++l/Ahh08AgCOH1fQn5vRJ2GFhfU1y4e08oY7LChWWkI75lgjBCay6hq3rgY2qRXCkpKxnxajSl+tzmSCRnNoFPAndNwY8j627QgIWtLmx2iDwP9ERDl1Nni9rHXp9DkrGwkQTdrl4Ec4bJ8rU+9szRn4EgDxPYHHwfrCl67pd8b0j9GU0ZbqeXTaFAvORWjWozrE8XoL4mXMOt/O9dl8l6EQm6SnbZImQlhNYzg4xCUxjag+f6oHPSeuqeGyickoqDt7ctaQutP8U67yD8I1/UO8tfQaLzPuXemnajmqe8qkrp/uYsWedM+o68Cr7hce3AllRmv360svrf+Mw18LinvIVQqDuSABHTAzHi+57NWgVKhiI26LkLOAKtif6mTqoyASlu3VdI6iQfCl0OduvcsVpE3pFtRACvUHdBSHyE6vmjt8SdMI8sLM0DJagR/CxUSEM0vTTAGfQYy4jlwka37PAmTzhD4pXOxUoUayF4gazHxpzSRWtVfAHnM6exRluFrwYA6JckO7bwpmWdSuTQQbpJRw8ICg5K9FmXximl5rlW0RewIqINTRUobLznJn0eC0Hppws7DGLYmDxiutHlAiM3dmn5eg6C96QkQ99coCt72Fj5xrqG0Tx9/1lcuoBGwFuzL9xpDd0/DH2IHvrPQUFqCt1vPcdMWdTO/T+IXpE+S/RR8tZ7fgTRhunw/G13raf73cq4zYF0thdq5zYOUPbWKwRw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966006)(36840700001)(426003)(70586007)(2616005)(70206006)(336012)(7696005)(8676002)(8936002)(186003)(478600001)(82310400003)(54906003)(4326008)(6666004)(81166007)(36860700001)(316002)(36756003)(26005)(5660300002)(83380400001)(1076003)(2906002)(86362001)(6916009)(82740400003)(47076005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 03:02:17.4623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f83ff01e-6323-47ed-0112-08d94bf3f30c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0037
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Chengzhe Liu <ChengZhe.Liu@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sienna Cichlid, in pass-through mode, if we unload the driver in BACO
mode(RTPM), then the kernel would receive thousands of interrupts.
That's because there is doorbell monitor interrupt on BIF, so KVM keeps
injecting interrupts to the guest VM. So we should clear the doorbell
interrupt status after BACO exit.

v2: Modify coding style and commit message

Signed-off-by: Chengzhe Liu <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c     | 21 +++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 37fa199be8b3..92f73d2bbfc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5265,6 +5265,10 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 	    adev->nbio.funcs->enable_doorbell_interrupt)
 		adev->nbio.funcs->enable_doorbell_interrupt(adev, true);
 
+	if (amdgpu_passthrough(adev) &&
+	    adev->nbio.funcs->clear_doorbell_interrupt)
+		adev->nbio.funcs->clear_doorbell_interrupt(adev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 45295dce5c3e..843052205bd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -95,6 +95,7 @@ struct amdgpu_nbio_funcs {
 	void (*program_aspm)(struct amdgpu_device *adev);
 	void (*apply_lc_spc_mode_wa)(struct amdgpu_device *adev);
 	void (*apply_l1_link_width_reconfig_wa)(struct amdgpu_device *adev);
+	void (*clear_doorbell_interrupt)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_nbio {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 7b79eeaa88aa..b184b656b9b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -508,6 +508,26 @@ static void nbio_v2_3_apply_l1_link_width_reconfig_wa(struct amdgpu_device *adev
 	WREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL, reg_data);
 }
 
+static void nbio_v2_3_clear_doorbell_interrupt(struct amdgpu_device *adev)
+{
+	uint32_t reg, reg_data;
+
+	if (adev->asic_type != CHIP_SIENNA_CICHLID)
+		return;
+
+	reg = RREG32_SOC15(NBIO, 0, mmBIF_RB_CNTL);
+
+	/* Clear Interrupt Status
+	 */
+	if ((reg & BIF_RB_CNTL__RB_ENABLE_MASK) == 0) {
+		reg = RREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL);
+		if (reg & BIF_DOORBELL_INT_CNTL__DOORBELL_INTERRUPT_STATUS_MASK) {
+			reg_data = 1 << BIF_DOORBELL_INT_CNTL__DOORBELL_INTERRUPT_CLEAR__SHIFT;
+			WREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL, reg_data);
+		}
+	}
+}
+
 const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
 	.get_hdp_flush_req_offset = nbio_v2_3_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v2_3_get_hdp_flush_done_offset,
@@ -531,4 +551,5 @@ const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
 	.program_aspm =  nbio_v2_3_program_aspm,
 	.apply_lc_spc_mode_wa = nbio_v2_3_apply_lc_spc_mode_wa,
 	.apply_l1_link_width_reconfig_wa = nbio_v2_3_apply_l1_link_width_reconfig_wa,
+	.clear_doorbell_interrupt = nbio_v2_3_clear_doorbell_interrupt,
 };
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
