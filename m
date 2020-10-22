Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03C5C2D0A3
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B8D208C3
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MsOuhHwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B8D208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D25A56E088;
	Thu, 22 Oct 2020 03:04:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34DAC6E088
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 03:04:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYRn9x8eqy8FybWc4DDwbCXPCNogq0AZ8XDHrCLvaDRB9/4CSc0B6zkHRCBHcXthMpVnWRseiECdLXAupBQugxtQ0JebCJr0h/3jjalcNVNtQZmxBiQ3NowDqVURKkeuA5tRcBwadMUqBGuDhTWbAAlVBKJQJqAoBVq6BbauHISkMprKIy5WUuumo9HKA4zutXbO0I9vtA4FsM/lCd0LTt6bOZ+1CDGhoQ1pH5RqVZ3WmHFGOY7G+Fv6LRkCq+/o8DjEcTW0CnWk3uRepqyNIJV/2+QyVqb9WnlTOGEWw3y0rR9Q7ywJWTjGYV6t2UTbFrdhgLvK6OFTi8qurYWzNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SI2DalKiMD4HZlhSzb8RHlEY+014X0FvvNGnjJA+Fc=;
 b=ArEMMtReOAn8oMYNk2U0Lbe88bzs5heJyFPhNPDiKk7kfYBNLo/1o74JiWFq6zJi/6NSL47hknMuu+C3Uo6t5rDZpSiar7s8Arv11S1iwzdPHlIKjhR0u5pvn/8R8FiaHM5NG3Lkg2EVcF069Zh8Z7zHImu8T+eYrnkpZ8acEqI6nay0amR3Rm/wGYBYO0p/oWdh9KapB/zMNfAMUNl9/sgNwqpPAy3Mfl4Zvs6Xw6Ze34sSw7gcoDZi+JS45jUId7igIvHSgp30HMgnyzRJs8HfX1qG2/V68icrej2tK0FOw36KhU5BIvp3yFRI0cv02iUqFItVL3Rkel8WKDxrNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SI2DalKiMD4HZlhSzb8RHlEY+014X0FvvNGnjJA+Fc=;
 b=MsOuhHwurrpcot396nq4WXf3YuzluHI/f3TA7UdWXX4Gl5QxyV+Nv4FQ5+s7E+2ccxno/6GK6sHeEVdT9iyAJwnMUY7WsVNaAcNIy0I4C2C84p8KJkZYZnLWoRQM4FlNLjUTDzxYwIvhHONskFHJWHhxth6OtZ8WvzxpC29xlDY=
Received: from MWHPR2201CA0054.namprd22.prod.outlook.com
 (2603:10b6:301:16::28) by CH2PR12MB4840.namprd12.prod.outlook.com
 (2603:10b6:610:c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Thu, 22 Oct
 2020 03:04:41 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::ad) by MWHPR2201CA0054.outlook.office365.com
 (2603:10b6:301:16::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Thu, 22 Oct 2020 03:04:41 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 03:04:40 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 22:04:39 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 22:04:37 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: disable DCN for navi10 blockchain SKU
Date: Thu, 22 Oct 2020 11:04:31 +0800
Message-ID: <20201022030432.4011-2-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022030432.4011-1-tianci.yin@amd.com>
References: <20201022030432.4011-1-tianci.yin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1688f702-d702-4a51-57b5-08d876373818
X-MS-TrafficTypeDiagnostic: CH2PR12MB4840:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4840F93500EBE5A158B4BD8C951D0@CH2PR12MB4840.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: guXUNoNWKcYv7IoHPYTt+gzVqj0BwAvmrzFdu1iAawo5ZAzrJoDZ+i1323s9Rh7/CwTT9ROv1ETMznsfpwO20oVuZcL/O2rIpksY5jpvWsBtmBpZTcm0DuXz3X5CCoDFXNtsYDZ36PNShVluaVErSSB+ZMa99V+I0psMD8C3RqsVKNtIImAllrLL/pS+NF+fmbI79tawFixqQGM7lbtnSnUvMClegb0FymWCqfbdKnQVX2QRJSKrjcagc1iFKjGTVUmhCOymjqEfwR6HxbbsNN2VwaOODSCE7ZTbBCDbg0pKL2zEKO4ib05kSlpIszjSTgLe//yKdNBlrE9c5lC1XhJOqWcy2yppbIw78mr4K+Wv77T7yh6Vrigs4elbGwlOIIHQSPVIMvayEHDh9P5/NA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966005)(70586007)(82740400003)(6666004)(4326008)(336012)(70206006)(316002)(54906003)(26005)(7696005)(44832011)(82310400003)(5660300002)(426003)(83380400001)(2906002)(8676002)(8936002)(6916009)(81166007)(186003)(36756003)(2616005)(1076003)(478600001)(86362001)(47076004)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 03:04:40.7704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1688f702-d702-4a51-57b5-08d876373818
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4840
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
Cc: Long Gang <Gang.Long@amd.com>, Guchun
 Chen <guchun.chen@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Tianci Yin <tianci.yin@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

The blockchain SKU has no display support, remove it.

Change-Id: Ia83bef1499708dfd0113fe2dbb3eb4143452c1cd
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 28 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  2 +-
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f8f3e375c93e..3c63fb8904de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1051,7 +1051,8 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
 				   u32 pcie_index, u32 pcie_data,
 				   u32 reg_addr, u64 reg_data);
 
-bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
+bool amdgpu_device_asic_is_blockchain_sku(struct pci_dev *pdev);
+bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, struct pci_dev *pdev);
 bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
 
 int emu_soc_asic_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c567f20b9d1f..5dd05e72ed9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2954,15 +2954,32 @@ static void amdgpu_device_detect_sriov_bios(struct amdgpu_device *adev)
 	}
 }
 
+/**
+ * amdgpu_device_asic_is_blockchain_sku - determine if the asic is blockchain
+ * SKU
+ *
+ * @pdev: pointer to pci_dev instance
+ *
+ * returns true if the asic is blockchain SKU, false if not.
+ */
+bool amdgpu_device_asic_is_blockchain_sku(struct pci_dev *pdev)
+{
+	if (pdev->device == 0x731E &&
+	    (pdev->revision == 0xC6 || pdev->revision == 0xC7))
+		return true;
+	return false;
+}
+
 /**
  * amdgpu_device_asic_has_dc_support - determine if DC supports the asic
  *
  * @asic_type: AMD asic type
+ * @pdev: pointer to pci_dev instance
  *
  * Check if there is DC (new modesetting infrastructre) support for an asic.
  * returns true if DC has support, false if not.
  */
-bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
+bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, struct pci_dev *pdev)
 {
 	switch (asic_type) {
 #if defined(CONFIG_DRM_AMD_DC)
@@ -2999,6 +3016,13 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	case CHIP_RAVEN:
 	case CHIP_NAVI10:
+		if (amdgpu_device_asic_is_blockchain_sku(pdev)) {
+			DRM_INFO("(%s 0x%04X:0x%04X 0x%04X:0x%04X 0x%02X) has no dc support.\n",
+				 amdgpu_asic_name[asic_type], pdev->vendor, pdev->device,
+				 pdev->subsystem_vendor, pdev->subsystem_device, pdev->revision);
+			return false;
+		}
+		return amdgpu_dc != 0;
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
 	case CHIP_RENOIR:
@@ -3031,7 +3055,7 @@ bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev) || adev->enable_virtual_display)
 		return false;
 
-	return amdgpu_device_asic_has_dc_support(adev->asic_type);
+	return amdgpu_device_asic_has_dc_support(adev->asic_type, adev->pdev);
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 9e92d2a070ac..97014458d7de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -516,7 +516,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 	 */
 	if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
 	    amdgpu_bo_support_uswc(bo_flags) &&
-	    amdgpu_device_asic_has_dc_support(adev->asic_type)) {
+	    amdgpu_device_asic_has_dc_support(adev->asic_type, adev->pdev)) {
 		switch (adev->asic_type) {
 		case CHIP_CARRIZO:
 		case CHIP_STONEY:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 13723914fa9f..97fda825e0d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1109,7 +1109,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	bool supports_atomic = false;
 
 	if (!amdgpu_virtual_display &&
-	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
+	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK, pdev))
 		supports_atomic = true;
 
 	if ((flags & AMD_EXP_HW_SUPPORT) && !amdgpu_exp_hw_support) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
