Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01C4C83F2C
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Sep 2023 07:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 080BA10E0A0;
	Mon,  4 Sep 2023 07:19:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1090A10E0A0
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Sep 2023 07:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbMjE4Yw7Nhk5qMLott2QxvPW+HpJ4LZD7tc1SugJDUtl/BiC/hAglvreLBNpsRgmuPwGbfIciA0+0S5mIiAo0GPsE1fYS27XVp4IocNLT52aLk/hDi7+5dp8vffATZhyGuaSj3HYcrmkTJ53W+o0wov7wUxKxuNSHSKLAIbEp0TIKB5Ra6Fkh/lRaYu2e/KrPHciIcH+KfyqP0lHeXqqM7G1ogJKxDUSo5Y42J3TFmqdAHCyqLzT6Jx8aF8NypwnkC61YnZN5UOXuYtD9DOxzBU07dvEGeyXamHNJVk6SOuyOzo6tZzOjw1tnnW011q+pBspWbcu7SLFvZchDdKkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cz/zOSZEehmIp4NNQ5XvdUD771jmqW37Ei2BqEVfiBc=;
 b=hWaVn3jkySD4xHgZyrjc5NStZZIpIcYzIAugmDdx0yhVavqiVhgvC/yRK1nJ1NQZQxM+O1ozctR7lPrkC0H/mQmnVlYuD7sp88i4S1Pj/uVUsVp6TCQa4vTUP7waf7ljnUVRui8YrvmjehYmwfxR4yK1VYNKN+wwbVjNXkxbYBmUW2tpuxulxGJLSD3tGgZFl9rQX44ZtW5j6if1CqU7zG2ByqliLq3fgETwfXKPxiBu7k5CkZ55PbHpTxc9snN+tIpZiyPOPF0VEl5+7AyQGXVYvIhwkcvW0k+a5MmsPZOLVl/PTPlCPdSFrExO8r18PbSiDShcgbZS+eDweA+fXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz/zOSZEehmIp4NNQ5XvdUD771jmqW37Ei2BqEVfiBc=;
 b=NXIgn5DscjQWDnjklwJY88Rgm7M0OC6SJCTUDDKy3vey6rmLDw3ce5jKLz9d/7o23jGTPenoy+3Y3CHBkz4J39jGyeWlIaanra+V3yUDqF3efd03u0uepj+8XDICp/HWHFAgAz9eb6cbuTaVCdjJCX/EB2PtqIVIz1Q/95KT1Vw=
Received: from CYZPR17CA0022.namprd17.prod.outlook.com (2603:10b6:930:8c::6)
 by SJ0PR12MB8137.namprd12.prod.outlook.com (2603:10b6:a03:4e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 07:19:35 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:8c:cafe::40) by CYZPR17CA0022.outlook.office365.com
 (2603:10b6:930:8c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Mon, 4 Sep 2023 07:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Mon, 4 Sep 2023 07:19:35 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 02:19:28 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Add RREG64_PCIE_EXT/WREG64_PCIE_EXT functions
Date: Mon, 4 Sep 2023 15:18:32 +0800
Message-ID: <20230904071832.58979-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SJ0PR12MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3f0f5a-ffbb-4c7a-f926-08dbad174b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hW3ZosGdAhooypPqWqIS6IqsieCb5RL2lgyKbr/DL7jed0za6Suz/NFbX5/opNFaAv2Dh2UEKvjA9W5K3nliMkjYax+NtKd1vfq5LH8HQx4dOK1AS1gA5josUp8EHb98+uhg/x0AyrWoZYAnDla2iuHkFRKxJcJlKukVqcKpvW17SuXq/cJKdx0FsVWqbOa0m0nEnFnhvlRRCP4ZYHyQ5VtV5Y7yRr/WL+N+n44A7/Iwk1RYa8wzAjfaThHhjfwQ2EN+so+tyD5pPG7ksNbqLVuDpdsraySCZulDQwYa22pe4huyzJfEZucKGJPlPm8w1LccUOx+FXVMzVLjSfSAwd+Hfo9UjmebtUo6hnIDxYx7wc/ZCVtlUsbEHjp2lM54OTlmZUinuHJcloozcLYQOnXKEyt8pirUxIHZDKjX/iXYFjopXykQKvfjJNgk6RCUooOQ9/4jXgo34OQbS2H7S3Kvi4LPWd47WqDoU3fnartcVPaRpRPLlnF86KnwAYzIi2yJUScsRxywW0cdr1nNa0n6DpChp9tJKVVLCIQ6fp1TL4g6mOCIoSlGc+7K3aNmdSVGN91o6iZnEZAX+L1RZOGCDUfqrskiRcDWA1TDkhgzPCeTVCr1BxYZrqNROulFFirnctfZRT6NIQFlCpRmgqoeQdqYE5aj3JD/qebLLaY2uOtIhwHpJS7XuN0DyPhJ5jlHXhnBsiNtmp4ShYUNK7o7Zknj8N5Nm8IXzb3PjJbK3gPh6vRf96h395MlB2ToL/ROURQdwAiMdJ5ua7EEiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(316002)(2906002)(70586007)(54906003)(36756003)(86362001)(70206006)(6916009)(40480700001)(5660300002)(8936002)(44832011)(8676002)(4326008)(41300700001)(40460700003)(1076003)(36860700001)(2616005)(83380400001)(336012)(426003)(26005)(16526019)(47076005)(478600001)(81166007)(356005)(82740400003)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 07:19:35.6988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3f0f5a-ffbb-4c7a-f926-08dbad174b16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. Add 64bits register access support on register whose address
is greater than 32bits.
2. Update RREG32_PCIE_EXT/WREG32_PCIE_EXT.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  11 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 119 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/soc15.c         |   2 +
 3 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 45e5db95496906..6ff4289b255bbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -653,6 +653,9 @@ typedef void (*amdgpu_wreg_ext_t)(struct amdgpu_device*, uint64_t, uint32_t);
 typedef uint64_t (*amdgpu_rreg64_t)(struct amdgpu_device*, uint32_t);
 typedef void (*amdgpu_wreg64_t)(struct amdgpu_device*, uint32_t, uint64_t);
 
+typedef uint64_t (*amdgpu_rreg64_ext_t)(struct amdgpu_device*, uint64_t);
+typedef void (*amdgpu_wreg64_ext_t)(struct amdgpu_device*, uint64_t, uint64_t);
+
 typedef uint32_t (*amdgpu_block_rreg_t)(struct amdgpu_device*, uint32_t, uint32_t);
 typedef void (*amdgpu_block_wreg_t)(struct amdgpu_device*, uint32_t, uint32_t, uint32_t);
 
@@ -867,6 +870,8 @@ struct amdgpu_device {
 	amdgpu_wreg_ext_t		pcie_wreg_ext;
 	amdgpu_rreg64_t			pcie_rreg64;
 	amdgpu_wreg64_t			pcie_wreg64;
+	amdgpu_rreg64_ext_t			pcie_rreg64_ext;
+	amdgpu_wreg64_ext_t			pcie_wreg64_ext;
 	/* protects concurrent UVD register access */
 	spinlock_t uvd_ctx_idx_lock;
 	amdgpu_rreg_t			uvd_ctx_rreg;
@@ -1178,10 +1183,14 @@ u32 amdgpu_device_indirect_rreg(struct amdgpu_device *adev,
 				u32 reg_addr);
 u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev,
 				  u32 reg_addr);
+u64 amdgpu_device_indirect_rreg64_ext(struct amdgpu_device *adev,
+				  u64 reg_addr);
 void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
 				 u32 reg_addr, u32 reg_data);
 void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
 				   u32 reg_addr, u64 reg_data);
+void amdgpu_device_indirect_wreg64_ext(struct amdgpu_device *adev,
+				   u64 reg_addr, u64 reg_data);
 u32 amdgpu_device_get_rev_id(struct amdgpu_device *adev);
 bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
 bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
@@ -1224,6 +1233,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define WREG32_PCIE_EXT(reg, v) adev->pcie_wreg_ext(adev, (reg), (v))
 #define RREG64_PCIE(reg) adev->pcie_rreg64(adev, (reg))
 #define WREG64_PCIE(reg, v) adev->pcie_wreg64(adev, (reg), (v))
+#define RREG64_PCIE_EXT(reg) adev->pcie_rreg64_ext(adev, (reg))
+#define WREG64_PCIE_EXT(reg, v) adev->pcie_wreg64_ext(adev, (reg), (v))
 #define RREG32_SMC(reg) adev->smc_rreg(adev, (reg))
 #define WREG32_SMC(reg, v) adev->smc_wreg(adev, (reg), (v))
 #define RREG32_UVD_CTX(reg) adev->uvd_ctx_rreg(adev, (reg))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index de9223b5e6fd76..57b24053e1e320 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -574,7 +574,7 @@ u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev,
 
 	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
 	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
-	if (adev->nbio.funcs->get_pcie_index_hi_offset)
+	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
 		pcie_index_hi = adev->nbio.funcs->get_pcie_index_hi_offset(adev);
 	else
 		pcie_index_hi = 0;
@@ -641,6 +641,56 @@ u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev,
 	return r;
 }
 
+u64 amdgpu_device_indirect_rreg64_ext(struct amdgpu_device *adev,
+				  u64 reg_addr)
+{
+	unsigned long flags, pcie_index, pcie_data;
+	unsigned long pcie_index_hi = 0;
+	void __iomem *pcie_index_offset;
+	void __iomem *pcie_index_hi_offset;
+	void __iomem *pcie_data_offset;
+	u64 r;
+
+	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
+	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
+	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
+		pcie_index_hi = adev->nbio.funcs->get_pcie_index_hi_offset(adev);
+
+	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
+	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
+	if (pcie_index_hi != 0)
+		pcie_index_hi_offset = (void __iomem *)adev->rmmio +
+			pcie_index_hi * 4;
+
+	/* read low 32 bits */
+	writel(reg_addr, pcie_index_offset);
+	readl(pcie_index_offset);
+	if (pcie_index_hi != 0) {
+		writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
+		readl(pcie_index_hi_offset);
+	}
+	r = readl(pcie_data_offset);
+	/* read high 32 bits */
+	writel(reg_addr + 4, pcie_index_offset);
+	readl(pcie_index_offset);
+	if (pcie_index_hi != 0) {
+		writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
+		readl(pcie_index_hi_offset);
+	}
+	r |= ((u64)readl(pcie_data_offset) << 32);
+
+	/* clear the high bits */
+	if (pcie_index_hi != 0) {
+		writel(0, pcie_index_hi_offset);
+		readl(pcie_index_hi_offset);
+	}
+
+	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+
+	return r;
+}
+
 /**
  * amdgpu_device_indirect_wreg - write an indirect register address
  *
@@ -680,7 +730,7 @@ void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev,
 
 	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
 	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
-	if (adev->nbio.funcs->get_pcie_index_hi_offset)
+	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
 		pcie_index_hi = adev->nbio.funcs->get_pcie_index_hi_offset(adev);
 	else
 		pcie_index_hi = 0;
@@ -745,6 +795,55 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
 	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
 }
 
+void amdgpu_device_indirect_wreg64_ext(struct amdgpu_device *adev,
+				   u64 reg_addr, u64 reg_data)
+{
+	unsigned long flags, pcie_index, pcie_data;
+	unsigned long pcie_index_hi = 0;
+	void __iomem *pcie_index_offset;
+	void __iomem *pcie_index_hi_offset;
+	void __iomem *pcie_data_offset;
+
+	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
+	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
+	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
+		pcie_index_hi = adev->nbio.funcs->get_pcie_index_hi_offset(adev);
+
+	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
+	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
+	if (pcie_index_hi != 0)
+		pcie_index_hi_offset = (void __iomem *)adev->rmmio +
+				pcie_index_hi * 4;
+
+	/* write low 32 bits */
+	writel(reg_addr, pcie_index_offset);
+	readl(pcie_index_offset);
+	if (pcie_index_hi != 0) {
+		writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
+		readl(pcie_index_hi_offset);
+	}
+	writel((u32)(reg_data & 0xffffffffULL), pcie_data_offset);
+	readl(pcie_data_offset);
+	/* write high 32 bits */
+	writel(reg_addr + 4, pcie_index_offset);
+	readl(pcie_index_offset);
+	if (pcie_index_hi != 0) {
+		writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
+		readl(pcie_index_hi_offset);
+	}
+	writel((u32)(reg_data >> 32), pcie_data_offset);
+	readl(pcie_data_offset);
+
+	/* clear the high bits */
+	if (pcie_index_hi != 0) {
+		writel(0, pcie_index_hi_offset);
+		readl(pcie_index_hi_offset);
+	}
+
+	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+}
+
 /**
  * amdgpu_device_get_rev_id - query device rev_id
  *
@@ -822,6 +921,13 @@ static uint64_t amdgpu_invalid_rreg64(struct amdgpu_device *adev, uint32_t reg)
 	return 0;
 }
 
+static uint64_t amdgpu_invalid_rreg64_ext(struct amdgpu_device *adev, uint64_t reg)
+{
+	DRM_ERROR("Invalid callback to read register 0x%llX\n", reg);
+	BUG();
+	return 0;
+}
+
 /**
  * amdgpu_invalid_wreg64 - dummy reg write function
  *
@@ -839,6 +945,13 @@ static void amdgpu_invalid_wreg64(struct amdgpu_device *adev, uint32_t reg, uint
 	BUG();
 }
 
+static void amdgpu_invalid_wreg64_ext(struct amdgpu_device *adev, uint64_t reg, uint64_t v)
+{
+	DRM_ERROR("Invalid callback to write 64 bit register 0x%llX with 0x%08llX\n",
+		  reg, v);
+	BUG();
+}
+
 /**
  * amdgpu_block_invalid_rreg - dummy reg read function
  *
@@ -3583,6 +3696,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	adev->pciep_wreg = &amdgpu_invalid_wreg;
 	adev->pcie_rreg64 = &amdgpu_invalid_rreg64;
 	adev->pcie_wreg64 = &amdgpu_invalid_wreg64;
+	adev->pcie_rreg64_ext = &amdgpu_invalid_rreg64_ext;
+	adev->pcie_wreg64_ext = &amdgpu_invalid_wreg64_ext;
 	adev->uvd_ctx_rreg = &amdgpu_invalid_rreg;
 	adev->uvd_ctx_wreg = &amdgpu_invalid_wreg;
 	adev->didt_rreg = &amdgpu_invalid_rreg;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index c45721ca916e40..63dadd72d2ecf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -919,6 +919,8 @@ static int soc15_common_early_init(void *handle)
 	adev->pcie_wreg_ext = &amdgpu_device_indirect_wreg_ext;
 	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
 	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
+	adev->pcie_rreg64_ext = &amdgpu_device_indirect_rreg64_ext;
+	adev->pcie_wreg64_ext = &amdgpu_device_indirect_wreg64_ext;
 	adev->uvd_ctx_rreg = &soc15_uvd_ctx_rreg;
 	adev->uvd_ctx_wreg = &soc15_uvd_ctx_wreg;
 	adev->didt_rreg = &soc15_didt_rreg;
-- 
2.25.1

