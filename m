Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C3AC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 03:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B0F61164
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 03:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B0F61164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C5BF6E431;
	Wed, 14 Apr 2021 03:04:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723B26E431
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 03:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwDXngeRQGFkrr03XiQ3VYYn40FS43x4LBNOggxRcsRUi/mNdvAkJuTkhNStICcRaBRLJ4Wc1r3JKOoK433WKGx2Tcr5SsCLSxUxG2L+z2dnVLNGU75AQI0B3s2ZxqnRsOblAUOvtcdJ4c/uPzXf0ajEuDOnqHbUzX/0o07r0CExH7xF8fNmZ/W4vGYECz3iux23qB80DdoY+Hc+DLe3+Ph4ozPeOF5Zao4WewsKah58Fr5Y7zSQ1KLHu0+SK0cJO/qYYhqX/+Hqd0Xgcsa3igcMy6WvOxziaQ9hRsWzLAR09pOuMCwFO9WAig0zqSOcQ6wC/7jpLb7/95pAgVuTpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq22l5tp2fDFZ6cRm3dlrWx0J+P/XxjRf3GCZgbmkcE=;
 b=iV+VZgyaBx4PDNsJPS0Ng3qfhh3C+d+iT0FxdAx02Wz7zs8498cJFVmtkvfYv+0gnzJlEMUv4O300IvCaScIbEADQv4I9sWHT/r3hlEttnBq8QINHK1muvK7tmW3V0H0SanMFHWbusVnW3EdFGuBptN45KafPJIXBDUoy6Zx55g5T/0a8UoqRmlT5K8+g2Anb1A55zHH5n2pOAMwgsjRdVcYamkRaVZt6uPsP4C5LcdfONMKunH7cb5bpQZVi9O5KrJPXdcdcY229gIxUWeJPf6sVGuf/b0QT6TovZZeGI+a3BQBoDp6J9z+QzaX7V0LYTZGdfbJKnyQpMCdWWaoSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq22l5tp2fDFZ6cRm3dlrWx0J+P/XxjRf3GCZgbmkcE=;
 b=YYuRGWf5RTJcKlFXe3fLWjlZhRd1ck+XhQnEb5aYtLm4fNUuZwg2Mwe8oRbVNKzPI/LNtnbRBe0gd97/Ng87Gx0QkLcN3Nw3cxia6l0YyTxO+/AsQXqRxLp18WLKdnzvS8IqpsV8cl7bc0iGmkdFhT3hTiVUzq64ApTu2IFZFNc=
Received: from BN6PR16CA0039.namprd16.prod.outlook.com (2603:10b6:405:14::25)
 by BN6PR1201MB2464.namprd12.prod.outlook.com (2603:10b6:404:ae::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Wed, 14 Apr
 2021 03:04:09 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::dd) by BN6PR16CA0039.outlook.office365.com
 (2603:10b6:405:14::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Wed, 14 Apr 2021 03:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Wed, 14 Apr 2021 03:04:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 13 Apr
 2021 22:03:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 13 Apr
 2021 22:03:47 -0500
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Tue, 13 Apr 2021 22:03:46 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/amdgpu: enable ASPM on navi1x and vega
Date: Wed, 14 Apr 2021 11:03:46 +0800
Message-ID: <20210414030347.23655-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36aff5a9-5f92-4dfe-2b19-08d8fef1f8f7
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2464:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2464ACC3E26AED509196B45E8E4E9@BN6PR1201MB2464.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:381;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U4Prux/erqGJLfhtdj6gUkqF+5FidlJ5SjI2cuFNzNQnkRxuoouYpiB3+ay8T/d5Z/5k9qIJTePQgfjT9PwHsemlrf0YHLJnEBSoZj8aH0/PuVU/az9KdyFPpmW1Q4JvZNM0maIufm7pOWZ2af28+6Z5UkHD4lOFYcrahyIo4Zfq2PuUOOkTUXFkTPom3g+QVUkY1+KmRRu/+RjBMB3IoQB1MYQDWelpTkBbdKTPJ69JTdy9YKEa1/NT3YxgLwyrpP/BFMn1hsN8vY4ZLVcCXYrn10kGLr543PubNuXqhpWWHv/0K52rdZQ8fqcrEGhcYB5TdQDoUxmOqRSRwJLiJ2885E2pClAEwoLYAphhlKEYkfxTgrtUWZ7FaGjMNRDyUoY8OwGZEZBFnV/i4LSp32hk0v7VxSqE9knx8lHmfuZij95h4T56pbyFcXV8cOFe1/2yPaRnLtrsg/2UxgdKFziiHIyJuF6ynca2yVH24thNKrYgpkQr+KRXhf+naTns3nK3hfo+QjduALXEeKQJqGKXC8eGL7pV//2vpMZ9nSOleYa2m1XqhKBp/LbZaxu5xmZgHUe9og1bTAj22YhitEdDN4QE8BhfjezgW5jJl9ed75C80aHtDvqtdVm+WTxE8RKxWimfqqFYSaoUl3vXwK3H5Z63GTvdHhmeCrjf6Z4AxtrhH+fD+mUPiESyKQ+Dhg5p76b/5owGMRJa+JIt9OUPHtiy1TUW0eP0Spthyuw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966006)(36840700001)(8676002)(6916009)(47076005)(82310400003)(2906002)(336012)(8936002)(426003)(356005)(186003)(30864003)(82740400003)(36860700001)(86362001)(83380400001)(26005)(316002)(81166007)(36756003)(1076003)(4326008)(70206006)(5660300002)(44832011)(7696005)(70586007)(2616005)(478600001)(32563001)(36900700001)(357404004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 03:04:08.9996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36aff5a9-5f92-4dfe-2b19-08d8fef1f8f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2464
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

enable ASPM on navi1x and vega series

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c | 128 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 125 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c     |   7 +-
 4 files changed, 259 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
index 83ea063388fd..0d2d629e2d6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
@@ -31,6 +31,28 @@
 #include "vega10_enum.h"
 #include <uapi/linux/kfd_ioctl.h>
 
+#define smnPCIE_LC_CNTL		0x11140280
+#define smnPCIE_LC_CNTL3	0x111402d4
+#define smnPCIE_LC_CNTL6	0x111402ec
+#define smnPCIE_LC_CNTL7	0x111402f0
+#define smnNBIF_MGCG_CTRL_LCLK	0x1013a05c
+#define NBIF_MGCG_CTRL_LCLK__NBIF_MGCG_REG_DIS_LCLK_MASK	0x00001000L
+#define RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER_MASK	0x0000FFFFL
+#define RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER_MASK	0xFFFF0000L
+#define smnRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL	0x10123530
+#define smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2	0x1014008c
+#define smnBIF_CFG_DEV0_EPF0_PCIE_LTR_CAP	0x10140324
+#define smnPSWUSP0_PCIE_LC_CNTL2		0x111402c4
+#define smnRCC_BIF_STRAP2	0x10123488
+#define smnRCC_BIF_STRAP3	0x1012348c
+#define smnRCC_BIF_STRAP5	0x10123494
+#define BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK			0x0400L
+#define RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER_MASK	0x0000FFFFL
+#define RCC_BIF_STRAP2__STRAP_LTR_IN_ASPML1_DIS_MASK	0x00004000L
+#define RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER__SHIFT	0x0
+#define RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER__SHIFT	0x10
+#define RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER__SHIFT	0x0
+
 static void nbio_v6_1_remap_hdp_registers(struct amdgpu_device *adev)
 {
 	WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
@@ -256,6 +278,111 @@ static void nbio_v6_1_init_registers(struct amdgpu_device *adev)
 		WREG32_PCIE(smnPCIE_CI_CNTL, data);
 }
 
+static void nbio_v6_1_program_ltr(struct amdgpu_device *adev)
+{
+	uint32_t def, data;
+
+	WREG32_PCIE(smnRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL, 0x75EB);
+
+	def = data = RREG32_PCIE(smnRCC_BIF_STRAP2);
+	data &= ~RCC_BIF_STRAP2__STRAP_LTR_IN_ASPML1_DIS_MASK;
+	if (def != data)
+		WREG32_PCIE(smnRCC_BIF_STRAP2, data);
+
+	def = data = RREG32_PCIE(smnRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL);
+	data &= ~EP_PCIE_TX_LTR_CNTL__LTR_PRIV_MSG_DIS_IN_PM_NON_D0_MASK;
+	if (def != data)
+		WREG32_PCIE(smnRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL, data);
+
+	def = data = RREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2);
+	data |= BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
+	if (def != data)
+		WREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, data);
+}
+
+static void nbio_v6_1_program_aspm(struct amdgpu_device *adev)
+{
+	uint32_t def, data;
+
+	def = data = RREG32_PCIE(smnPCIE_LC_CNTL);
+	data &= ~PCIE_LC_CNTL__LC_L1_INACTIVITY_MASK;
+	data &= ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
+	data |= PCIE_LC_CNTL__LC_PMI_TO_L1_DIS_MASK;
+	if (def != data)
+		WREG32_PCIE(smnPCIE_LC_CNTL, data);
+
+	def = data = RREG32_PCIE(smnPCIE_LC_CNTL7);
+	data |= PCIE_LC_CNTL7__LC_NBIF_ASPM_INPUT_EN_MASK;
+	if (def != data)
+		WREG32_PCIE(smnPCIE_LC_CNTL7, data);
+
+	def = data = RREG32_PCIE(smnNBIF_MGCG_CTRL_LCLK);
+	data |= NBIF_MGCG_CTRL_LCLK__NBIF_MGCG_REG_DIS_LCLK_MASK;
+	if (def != data)
+		WREG32_PCIE(smnNBIF_MGCG_CTRL_LCLK, data);
+
+	def = data = RREG32_PCIE(smnPCIE_LC_CNTL3);
+	data |= PCIE_LC_CNTL3__LC_DSC_DONT_ENTER_L23_AFTER_PME_ACK_MASK;
+	if (def != data)
+		WREG32_PCIE(smnPCIE_LC_CNTL3, data);
+
+	def = data = RREG32_PCIE(smnRCC_BIF_STRAP3);
+	data &= ~RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER_MASK;
+	data &= ~RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER_MASK;
+	if (def != data)
+		WREG32_PCIE(smnRCC_BIF_STRAP3, data);
+
+	def = data = RREG32_PCIE(smnRCC_BIF_STRAP5);
+	data &= ~RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER_MASK;
+	if (def != data)
+		WREG32_PCIE(smnRCC_BIF_STRAP5, data);
+
+	def = data = RREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2);
+	data &= ~BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
+	if (def != data)
+		WREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, data);
+
+	WREG32_PCIE(smnBIF_CFG_DEV0_EPF0_PCIE_LTR_CAP, 0x10011001);
+
+	def = data = RREG32_PCIE(smnPSWUSP0_PCIE_LC_CNTL2);
+	data |= PSWUSP0_PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L1_MASK |
+		PSWUSP0_PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L23_MASK;
+	data &= ~PSWUSP0_PCIE_LC_CNTL2__LC_RCV_L0_TO_RCV_L0S_DIS_MASK;
+	if (def != data)
+		WREG32_PCIE(smnPSWUSP0_PCIE_LC_CNTL2, data);
+
+	def = data = RREG32_PCIE(smnPCIE_LC_CNTL6);
+	data |= PCIE_LC_CNTL6__LC_L1_POWERDOWN_MASK |
+		PCIE_LC_CNTL6__LC_RX_L0S_STANDBY_EN_MASK;
+	if (def != data)
+		WREG32_PCIE(smnPCIE_LC_CNTL6, data);
+
+	nbio_v6_1_program_ltr(adev);
+
+	def = data = RREG32_PCIE(smnRCC_BIF_STRAP3);
+	data |= 0x5DE0 << RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER__SHIFT;
+	data |= 0x0010 << RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER__SHIFT;
+	if (def != data)
+		WREG32_PCIE(smnRCC_BIF_STRAP3, data);
+
+	def = data = RREG32_PCIE(smnRCC_BIF_STRAP5);
+	data |= 0x0010 << RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER__SHIFT;
+	if (def != data)
+		WREG32_PCIE(smnRCC_BIF_STRAP5, data);
+
+	def = data = RREG32_PCIE(smnPCIE_LC_CNTL);
+	data &= ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
+	data |= 0x9 << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
+	data |= 0x1 << PCIE_LC_CNTL__LC_PMI_TO_L1_DIS__SHIFT;
+	if (def != data)
+		WREG32_PCIE(smnPCIE_LC_CNTL, data);
+
+	def = data = RREG32_PCIE(smnPCIE_LC_CNTL3);
+	data &= ~PCIE_LC_CNTL3__LC_DSC_DONT_ENTER_L23_AFTER_PME_ACK_MASK;
+	if (def != data)
+		WREG32_PCIE(smnPCIE_LC_CNTL3, data);
+}
+
 const struct amdgpu_nbio_funcs nbio_v6_1_funcs = {
 	.get_hdp_flush_req_offset = nbio_v6_1_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v6_1_get_hdp_flush_done_offset,
@@ -274,4 +401,5 @@ const struct amdgpu_nbio_funcs nbio_v6_1_funcs = {
 	.ih_control = nbio_v6_1_ih_control,
 	.init_registers = nbio_v6_1_init_registers,
 	.remap_hdp_registers = nbio_v6_1_remap_hdp_registers,
+	.program_aspm =  nbio_v6_1_program_aspm,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index af44aad78171..cef929746739 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -31,7 +31,26 @@
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include <uapi/linux/kfd_ioctl.h>
 
+#define smnPCIE_LC_CNTL		0x11140280
+#define smnPCIE_LC_CNTL3	0x111402d4
+#define smnPCIE_LC_CNTL6	0x111402ec
+#define smnPCIE_LC_CNTL7	0x111402f0
 #define smnNBIF_MGCG_CTRL_LCLK	0x1013a21c
+#define smnRCC_BIF_STRAP3	0x1012348c
+#define RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER_MASK	0x0000FFFFL
+#define RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER_MASK	0xFFFF0000L
+#define smnRCC_BIF_STRAP5	0x10123494
+#define RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER_MASK	0x0000FFFFL
+#define smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2	0x1014008c
+#define BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK			0x0400L
+#define smnBIF_CFG_DEV0_EPF0_PCIE_LTR_CAP	0x10140324
+#define smnPSWUSP0_PCIE_LC_CNTL2		0x111402c4
+#define smnRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL	0x10123538
+#define smnRCC_BIF_STRAP2	0x10123488
+#define RCC_BIF_STRAP2__STRAP_LTR_IN_ASPML1_DIS_MASK	0x00004000L
+#define RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER__SHIFT	0x0
+#define RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER__SHIFT	0x10
+#define RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER__SHIFT	0x0
 
 /*
  * These are nbio v7_4_1 registers mask. Temporarily define these here since
@@ -567,6 +586,111 @@ const struct amdgpu_nbio_ras_funcs nbio_v7_4_ras_funcs = {
 	.ras_fini = amdgpu_nbio_ras_fini,
 };
 
+static void nbio_v7_4_program_ltr(struct amdgpu_device *adev)
+{
+	uint32_t def, data;
+
+	WREG32_PCIE(smnRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL, 0x75EB);
+
+	def = data = RREG32_PCIE(smnRCC_BIF_STRAP2);
+	data &= ~RCC_BIF_STRAP2__STRAP_LTR_IN_ASPML1_DIS_MASK;
+	if (def != data)
+		WREG32_PCIE(smnRCC_BIF_STRAP2, data);
+
+	def = data = RREG32_PCIE(smnRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL);
+	data &= ~EP_PCIE_TX_LTR_CNTL__LTR_PRIV_MSG_DIS_IN_PM_NON_D0_MASK;
+	if (def != data)
+		WREG32_PCIE(smnRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL, data);
+
+	def = data = RREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2);
+	data |= BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
+	if (def != data)
+		WREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, data);
+}
+
+static void nbio_v7_4_program_aspm(struct amdgpu_device *adev)
+{
+	uint32_t def, data;
+
+	def = data = RREG32_PCIE(smnPCIE_LC_CNTL);
+	data &= ~PCIE_LC_CNTL__LC_L1_INACTIVITY_MASK;
+	data &= ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
+	data |= PCIE_LC_CNTL__LC_PMI_TO_L1_DIS_MASK;
+	if (def != data)
+		WREG32_PCIE(smnPCIE_LC_CNTL, data);
+
+	def = data = RREG32_PCIE(smnPCIE_LC_CNTL7);
+	data |= PCIE_LC_CNTL7__LC_NBIF_ASPM_INPUT_EN_MASK;
+	if (def != data)
+		WREG32_PCIE(smnPCIE_LC_CNTL7, data);
+
+	def = data = RREG32_PCIE(smnNBIF_MGCG_CTRL_LCLK);
+	data |= NBIF_MGCG_CTRL_LCLK__NBIF_MGCG_REG_DIS_LCLK_MASK;
+	if (def != data)
+		WREG32_PCIE(smnNBIF_MGCG_CTRL_LCLK, data);
+
+	def = data = RREG32_PCIE(smnPCIE_LC_CNTL3);
+	data |= PCIE_LC_CNTL3__LC_DSC_DONT_ENTER_L23_AFTER_PME_ACK_MASK;
+	if (def != data)
+		WREG32_PCIE(smnPCIE_LC_CNTL3, data);
+
+	def = data = RREG32_PCIE(smnRCC_BIF_STRAP3);
+	data &= ~RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER_MASK;
+	data &= ~RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER_MASK;
+	if (def != data)
+		WREG32_PCIE(smnRCC_BIF_STRAP3, data);
+
+	def = data = RREG32_PCIE(smnRCC_BIF_STRAP5);
+	data &= ~RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER_MASK;
+	if (def != data)
+		WREG32_PCIE(smnRCC_BIF_STRAP5, data);
+
+	def = data = RREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2);
+	data &= ~BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
+	if (def != data)
+		WREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, data);
+
+	WREG32_PCIE(smnBIF_CFG_DEV0_EPF0_PCIE_LTR_CAP, 0x10011001);
+
+	def = data = RREG32_PCIE(smnPSWUSP0_PCIE_LC_CNTL2);
+	data |= PSWUSP0_PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L1_MASK |
+		PSWUSP0_PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L23_MASK;
+	data &= ~PSWUSP0_PCIE_LC_CNTL2__LC_RCV_L0_TO_RCV_L0S_DIS_MASK;
+	if (def != data)
+		WREG32_PCIE(smnPSWUSP0_PCIE_LC_CNTL2, data);
+
+	def = data = RREG32_PCIE(smnPCIE_LC_CNTL6);
+	data |= PCIE_LC_CNTL6__LC_L1_POWERDOWN_MASK |
+		PCIE_LC_CNTL6__LC_RX_L0S_STANDBY_EN_MASK;
+	if (def != data)
+		WREG32_PCIE(smnPCIE_LC_CNTL6, data);
+
+	nbio_v7_4_program_ltr(adev);
+
+	def = data = RREG32_PCIE(smnRCC_BIF_STRAP3);
+	data |= 0x5DE0 << RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER__SHIFT;
+	data |= 0x0010 << RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER__SHIFT;
+	if (def != data)
+		WREG32_PCIE(smnRCC_BIF_STRAP3, data);
+
+	def = data = RREG32_PCIE(smnRCC_BIF_STRAP5);
+	data |= 0x0010 << RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER__SHIFT;
+	if (def != data)
+		WREG32_PCIE(smnRCC_BIF_STRAP5, data);
+
+	def = data = RREG32_PCIE(smnPCIE_LC_CNTL);
+	data &= ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
+	data |= 0x9 << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
+	data |= 0x1 << PCIE_LC_CNTL__LC_PMI_TO_L1_DIS__SHIFT;
+	if (def != data)
+		WREG32_PCIE(smnPCIE_LC_CNTL, data);
+
+	def = data = RREG32_PCIE(smnPCIE_LC_CNTL3);
+	data &= ~PCIE_LC_CNTL3__LC_DSC_DONT_ENTER_L23_AFTER_PME_ACK_MASK;
+	if (def != data)
+		WREG32_PCIE(smnPCIE_LC_CNTL3, data);
+}
+
 const struct amdgpu_nbio_funcs nbio_v7_4_funcs = {
 	.get_hdp_flush_req_offset = nbio_v7_4_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v7_4_get_hdp_flush_done_offset,
@@ -587,4 +711,5 @@ const struct amdgpu_nbio_funcs nbio_v7_4_funcs = {
 	.ih_control = nbio_v7_4_ih_control,
 	.init_registers = nbio_v7_4_init_registers,
 	.remap_hdp_registers = nbio_v7_4_remap_hdp_registers,
+	.program_aspm =  nbio_v7_4_program_aspm,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 46d4bbabce75..d54af7f8801b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -601,8 +601,7 @@ static void nv_program_aspm(struct amdgpu_device *adev)
 	if (amdgpu_aspm != 1)
 		return;
 
-	if ((adev->asic_type >= CHIP_SIENNA_CICHLID) &&
-	    !(adev->flags & AMD_IS_APU) &&
+	if (!(adev->flags & AMD_IS_APU) &&
 	    (adev->nbio.funcs->program_aspm))
 		adev->nbio.funcs->program_aspm(adev);
 
@@ -934,12 +933,7 @@ static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
 	if (adev->gfx.funcs->update_perfmon_mgcg)
 		adev->gfx.funcs->update_perfmon_mgcg(adev, !enter);
 
-	/*
-	 * The ASPM function is not fully enabled and verified on
-	 * Navi yet. Temporarily skip this until ASPM enabled.
-	 */
-	if ((adev->asic_type >= CHIP_SIENNA_CICHLID) &&
-	    !(adev->flags & AMD_IS_APU) &&
+	if (!(adev->flags & AMD_IS_APU) &&
 	    (adev->nbio.funcs->enable_aspm))
 		adev->nbio.funcs->enable_aspm(adev, !enter);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 5c5eb3aed1b3..d80e12b80c7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -816,11 +816,12 @@ static void soc15_pcie_gen3_enable(struct amdgpu_device *adev)
 
 static void soc15_program_aspm(struct amdgpu_device *adev)
 {
-
-	if (amdgpu_aspm == 0)
+	if (amdgpu_aspm != 1)
 		return;
 
-	/* todo */
+	if (!(adev->flags & AMD_IS_APU) &&
+	    (adev->nbio.funcs->program_aspm))
+		adev->nbio.funcs->program_aspm(adev);
 }
 
 static void soc15_enable_doorbell_aperture(struct amdgpu_device *adev,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
