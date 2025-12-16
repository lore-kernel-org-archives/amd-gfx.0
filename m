Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933F0D5E374
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8ED210E88E;
	Tue, 16 Dec 2025 21:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KO0zhQd1";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010038.outbound.protection.outlook.com
 [52.101.193.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12A5210E897
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UReiPpIx6BPmazym4AnD4dgzFpyR/y1B+OQd3LsXcvnuwwKNWiG4Mm2JqZk5TfQcxWUKJdsJOeX8wLrw/aepyLaWQAUxmxCh5AL5Ond+tJ7lrWIjI60TyKiXPRvOdcNXwTnl+N4UftDOJ4TFNsbFT3vJv4hxNFLduwygJWgm40nw4PLgT8xYFE/WcCtkrW4SKC4oPWDdm9rk3DywKMN1ho3Ns8nLa5V7DRAOkNZ4RC6IEiG4NQS1Os8PCEtT3X7r3EugmVXkPt3iCbPdKaGs30xSlZvuWqK+mbRLpa4sNHMPnr4U5QxvhiGjMr9QldQIDjvbI2GIwhdi81LfZmFsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfit8teyCFeANe4Od2VhgktTmXWYgUnfPzaCDO4TZVI=;
 b=eucIzxa91MBLC2Om+RfHdz2MncR+p24nIpjCdSvBRc3k4nZ6LLvPECukm1q62B91LjkS+zRJj1Rg0NeZhDjGFzoTP40eXrqx6Xs3/FQsOdbdMyxF7Zq7YsEBhyfbnUGhljh/Klpd2Zt+6Oo/3srJnX8t24ppv+ziF/Fs41AcuHug5XUtMqmX8du1zl2F1Yv3T2i3w2fOx8PTXUJ5uvue4cwx2HTK8O4NsJPIZsn5B8tIxzz8iGH64AIdvMR3RZpPa1AKF+tCM6mIJh4zkroxfrAs8ddGk1Sic5rrjgBZJAB27HBVJwBegq6Sso6qWX0ORrg/B20H96sDEAS0Czhlng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfit8teyCFeANe4Od2VhgktTmXWYgUnfPzaCDO4TZVI=;
 b=KO0zhQd1OFZEgtFCOPPCDqXdNZQLD19QZG96ikZWiRxw1CG8d2SfLi35UeOCwGmoRAx2xkIaE4+i2X1lgeyeWoo6n+rZA6JdjjErjP4Ne0rUU41rq2Ohky2oGn2r2es2S0LjLsZV7lT2rgqcrXfyhAed2+X8KBvW6xfU1SjmofQ=
Received: from BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::16)
 by SA1PR12MB8722.namprd12.prod.outlook.com (2603:10b6:806:373::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 21:04:15 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::5f) by BL1P223CA0011.outlook.office365.com
 (2603:10b6:208:2c4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 21:04:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:15 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Bokun Zhang <bokun.zhang@amd.com>, Bokun Zhang <Bokun.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: RLC-G VF Register Access Interface
Date: Tue, 16 Dec 2025 16:03:48 -0500
Message-ID: <20251216210349.1963466-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SA1PR12MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: e37cb765-64e9-46d0-3e95-08de3ce6abd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KKY8dAad6OIrCxKrcqEvu/hEhDNl1WnCXGg2Ye5pMIaeZnFTF/Ipi6TLACzT?=
 =?us-ascii?Q?2uSg+fHaaXBTF0sj46/zmu9Gxs6yHBok9Esoxg1uOYhrADe4nGUdJhc37jCo?=
 =?us-ascii?Q?u7h9iRNdyR0hcIagt21+4YJTEABtOV7VB5mcxk2GA4rFFQOJf7vjuilTOMZh?=
 =?us-ascii?Q?XMI50r5DBpO2tuA2sRLIw4Bob0LbZn8bAyGtsNPjd17gxSypIw4eAvg+XIPu?=
 =?us-ascii?Q?QHUlpK7j3EI4iBXqGUKDtEMJtPFJKGsOp/KqwA4oGFYO+5gbxr3f/VwZNG7w?=
 =?us-ascii?Q?4pOcnV3U/PAfYRaYPpJ5SE8akayRA6SzgAzJda8U6AMC6PNyr8Wj8eY9uU6F?=
 =?us-ascii?Q?sbD6Vjw6l5HmRG/7ZAPubm0Xa8urKFrGHnOKZGbjNOSZwu/3n5S1txFYoHfk?=
 =?us-ascii?Q?TC23Z/LwnanPc8xe2wJ0EgP2LCbTDWxIPxsxCH2Xyod1B4t7xxJeWkeUcNdl?=
 =?us-ascii?Q?pCsDaMIRXpCZ+QwG7/G7JdQjKGBmWsyXl7dG/KV2qHqeK5n+0vLuQrBja/QS?=
 =?us-ascii?Q?tiyBQ83MpGv4VhRoFEfabMKm5Jk3zQbHyfaM6B4xvqTvJU3QCNbHuki14thC?=
 =?us-ascii?Q?eTv0nrFRRU1EwQ27WH44GHJO9oxCgLy8Dtgx5ZpXYs3co/IhA20JnpiP76n5?=
 =?us-ascii?Q?bbWqWa5XikmL60Gahg3Q/i3GpN9qY2tA9QaY06RU9zeNXxGvdaiWWowZjibo?=
 =?us-ascii?Q?Oa97ZWVWtQ/D0bb8PVtFdai+SXhn2YyObnG4c+GWOSg/Z/Di2F+fKcHeygUK?=
 =?us-ascii?Q?P5RzPU1ee3gY1f97wjiW5K4UseQ4VeitrMRU4qzHNstWNzF0OpOl/ye+tBSy?=
 =?us-ascii?Q?m8j6kviykyFR7vYoOuXFcxUUjC33HDZzdAhJeyMvXW5t8AP/EekV/cqsEeDC?=
 =?us-ascii?Q?JxdhRcF/UIWFpEhDhzEEAAHCTTX/JkWlBtt8Mudg2vE8briVw5OBLiHSFlaX?=
 =?us-ascii?Q?5z1mPrva2EBoEDhHuWyTsZZMqoT0t6FnGy0sKYKX8xRQyJFb2/vRLz4EaWNm?=
 =?us-ascii?Q?d8H3xmsHzv3IeDkn2XkEKevH4TEMcciE8NN6x68NbDo4j563HKPVofViOu/0?=
 =?us-ascii?Q?Z0xzn9f4ZJq5XANEUMhy+GduhkK+Hdo6EhZFMAJYncXhkQEgSBB9WOFvoi+Y?=
 =?us-ascii?Q?m9hyX54oyA6neXxHkIG19ETP/3ZRpZNCgjrYqFoMLYFx1AaJMftzDmnvgI4H?=
 =?us-ascii?Q?ib4TcbpniQ81HmJXv7N+jxYy+dKaOJkeWO7lta+UamCkXct3ymyiJdsNGnfl?=
 =?us-ascii?Q?5sJNvM4ez5Yo9pni8HoPrNES50jYSA3kvrjfMyzTRXd2fW9gWtwkemXtxunm?=
 =?us-ascii?Q?gVe95VZgp33jZ2Ml9bC57mf2YmCRwzPik/bbsHqegWTiCVxrTBJ5tfZUpsR5?=
 =?us-ascii?Q?SCy2ACpQzgHZsr/OkvSj/mL60KMg0hwhgy5Q9P4OPuArnOGleb1eA5VyNCxn?=
 =?us-ascii?Q?XDB/ndu1k6fVlIwYdrVDUyxTeeQpemO/CkvZJOlufJiPuM1jZs+H9yvlaawA?=
 =?us-ascii?Q?2YimTkyHTjwNPdFntn1hmTYIMMcz6r0Px1LXST/TXnM1ScMSJEPMDyq0VSW7?=
 =?us-ascii?Q?gf08mAhJ8K9/DVMAsOo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:15.5516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e37cb765-64e9-46d0-3e95-08de3ce6abd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8722
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bokun Zhang <bokun.zhang@amd.com>

- Implement Gfx v12.1 VFi interface under SRIOV
- Redirect all RLCG interface access to new function after
  Gfx v12.1

v2: squash in register updates

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h       |   9 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 130 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |   9 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        |  26 ++--
 .../include/asic_reg/gc/gc_12_1_0_offset.h    |  13 +-
 .../include/asic_reg/gc/gc_12_1_0_sh_mask.h   |  18 +++
 6 files changed, 194 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 32408574548dd..e535534237a1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -270,6 +270,15 @@ struct amdgpu_rlcg_reg_access_ctrl {
 	uint32_t grbm_cntl;
 	uint32_t grbm_idx;
 	uint32_t spare_int;
+
+	uint32_t vfi_cmd;
+	uint32_t vfi_stat;
+	uint32_t vfi_addr;
+	uint32_t vfi_data;
+	uint32_t vfi_grbm_cntl;
+	uint32_t vfi_grbm_idx;
+	uint32_t vfi_grbm_cntl_data;
+	uint32_t vfi_grbm_idx_data;
 };
 
 struct amdgpu_rlc {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 759f3c642331d..f8eac92a2b36c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1338,6 +1338,133 @@ bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
 	return ret;
 }
 
+static u32 amdgpu_virt_rlcg_vfi_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag, u32 xcc_id)
+{
+	uint32_t timeout = 100;
+	uint32_t i;
+
+	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
+	void *vfi_cmd;
+	void *vfi_stat;
+	void *vfi_addr;
+	void *vfi_data;
+	void *vfi_grbm_cntl;
+	void *vfi_grbm_idx;
+	uint32_t cmd;
+	uint32_t stat;
+	uint32_t addr = offset;
+	uint32_t data;
+	uint32_t grbm_cntl_data;
+	uint32_t grbm_idx_data;
+
+	unsigned long flags;
+	bool is_err = true;
+
+	if (!adev->gfx.rlc.rlcg_reg_access_supported) {
+		dev_err(adev->dev, "VFi interface is not available\n");
+		return 0;
+	}
+
+	if (adev->gfx.xcc_mask && (((1 << xcc_id) & adev->gfx.xcc_mask) == 0)) {
+		dev_err(adev->dev, "VFi invalid XCC, xcc_id=0x%x\n", xcc_id);
+		return 0;
+	}
+
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
+	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[xcc_id];
+	vfi_cmd  = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->vfi_cmd;
+	vfi_stat = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->vfi_stat;
+	vfi_addr = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->vfi_addr;
+	vfi_data = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->vfi_data;
+	vfi_grbm_cntl = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->vfi_grbm_cntl;
+	vfi_grbm_idx  = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->vfi_grbm_idx;
+	grbm_cntl_data = reg_access_ctrl->vfi_grbm_cntl_data;
+	grbm_idx_data  = reg_access_ctrl->vfi_grbm_idx_data;
+
+	if (flag == AMDGPU_RLCG_GC_WRITE) {
+		data = v;
+		cmd = AMDGPU_RLCG_VFI_CMD__WR;
+
+		// the GRBM_GFX_CNTL and GRBM_GFX_INDEX are protected by mutex outside this call
+		if (addr == reg_access_ctrl->grbm_cntl) {
+			reg_access_ctrl->vfi_grbm_cntl_data = data;
+			return 0;
+		} else if (addr == reg_access_ctrl->grbm_idx) {
+			reg_access_ctrl->vfi_grbm_idx_data = data;
+			return 0;
+		}
+
+	} else if (flag == AMDGPU_RLCG_GC_READ) {
+		data = 0;
+		cmd = AMDGPU_RLCG_VFI_CMD__RD;
+
+		// the GRBM_GFX_CNTL and GRBM_GFX_INDEX are protected by mutex outside this call
+		if (addr == reg_access_ctrl->grbm_cntl)
+			return grbm_cntl_data;
+		else if (addr == reg_access_ctrl->grbm_idx)
+			return grbm_idx_data;
+
+	} else {
+		dev_err(adev->dev, "VFi invalid access, flag=0x%x\n", flag);
+		return 0;
+	}
+
+	spin_lock_irqsave(&adev->virt.rlcg_reg_lock, flags);
+
+	writel(addr, vfi_addr);
+	writel(data, vfi_data);
+	writel(grbm_cntl_data, vfi_grbm_cntl);
+	writel(grbm_idx_data,  vfi_grbm_idx);
+
+	writel(AMDGPU_RLCG_VFI_STAT__BUSY, vfi_stat);
+	writel(cmd, vfi_cmd);
+
+	for (i = 0; i < timeout; i++) {
+		stat = readl(vfi_stat);
+		if (stat != AMDGPU_RLCG_VFI_STAT__BUSY)
+			break;
+		udelay(10);
+	}
+
+	switch (stat) {
+	case AMDGPU_RLCG_VFI_STAT__DONE:
+		is_err = false;
+		if (cmd == AMDGPU_RLCG_VFI_CMD__RD)
+			data = readl(vfi_data);
+		break;
+	case AMDGPU_RLCG_VFI_STAT__BUSY:
+		dev_err(adev->dev, "VFi access timeout\n");
+		break;
+	case AMDGPU_RLCG_VFI_STAT__INV_CMD:
+		dev_err(adev->dev, "VFi invalid command\n");
+		break;
+	case AMDGPU_RLCG_VFI_STAT__INV_ADDR:
+		dev_err(adev->dev, "VFi invalid address\n");
+		break;
+	case AMDGPU_RLCG_VFI_STAT__ERR:
+		dev_err(adev->dev, "VFi unknown error\n");
+		break;
+	default:
+		dev_err(adev->dev, "VFi unknown status code\n");
+		break;
+	}
+
+	spin_unlock_irqrestore(&adev->virt.rlcg_reg_lock, flags);
+
+	if (is_err)
+		dev_err(adev->dev, "VFi: [grbm_cntl=0x%x grbm_idx=0x%x] addr=0x%x (byte addr 0x%x), data=0x%x, cmd=0x%x\n",
+			grbm_cntl_data, grbm_idx_data,
+			addr, addr * 4, data, cmd);
+	else
+		dev_dbg(adev->dev, "VFi: [grbm_cntl=0x%x grbm_idx=0x%x] addr=0x%x (byte addr 0x%x), data=0x%x, cmd=0x%x\n",
+			grbm_cntl_data, grbm_idx_data,
+			addr, addr * 4, data, cmd);
+
+	return data;
+}
+
 u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag, u32 xcc_id)
 {
 	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
@@ -1351,6 +1478,9 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 	void *spare_int;
 	unsigned long flags;
 
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 1, 0))
+		return amdgpu_virt_rlcg_vfi_reg_rw(adev, offset, v, flag, xcc_id);
+
 	if (!adev->gfx.rlc.rlcg_reg_access_supported) {
 		dev_err(adev->dev,
 			"indirect registers access through rlcg is not available\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 608d966701a48..886fbce0bfd1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -47,6 +47,15 @@
 #define AMDGPU_RLCG_SCRATCH1_ADDRESS_MASK	0xFFFFF
 #define AMDGPU_RLCG_SCRATCH1_ERROR_MASK	0xF000000
 
+#define AMDGPU_RLCG_VFI_CMD__WR 0x0
+#define AMDGPU_RLCG_VFI_CMD__RD 0x1
+
+#define AMDGPU_RLCG_VFI_STAT__BUSY     0x0
+#define AMDGPU_RLCG_VFI_STAT__DONE     0x1
+#define AMDGPU_RLCG_VFI_STAT__INV_CMD  0x2
+#define AMDGPU_RLCG_VFI_STAT__INV_ADDR 0x3
+#define AMDGPU_RLCG_VFI_STAT__ERR      0xFF
+
 /* all asic after AI use this offset */
 #define mmRCC_IOV_FUNC_IDENTIFIER 0xDE5
 /* tonga/fiji use this offset */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 943be8ce17395..9205be1fc196e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -526,20 +526,26 @@ static void gfx_v12_1_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
 		reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[GET_INST(GC, xcc_id)];
-		reg_access_ctrl->scratch_reg0 =
-			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regSCRATCH_REG0);
-		reg_access_ctrl->scratch_reg1 =
-			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regSCRATCH_REG1);
-		reg_access_ctrl->scratch_reg2 =
-			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regSCRATCH_REG2);
-		reg_access_ctrl->scratch_reg3 =
-			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regSCRATCH_REG3);
+
 		reg_access_ctrl->grbm_cntl =
 			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regGRBM_GFX_CNTL);
 		reg_access_ctrl->grbm_idx =
 			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regGRBM_GFX_INDEX);
-		reg_access_ctrl->spare_int =
-			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPARE_INT_0);
+
+		reg_access_ctrl->vfi_cmd =
+			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_VFI_CMD);
+		reg_access_ctrl->vfi_stat =
+			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_VFI_STAT);
+		reg_access_ctrl->vfi_addr =
+			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_VFI_ADDR);
+		reg_access_ctrl->vfi_data =
+			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_VFI_DATA);
+		reg_access_ctrl->vfi_grbm_cntl =
+			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_VFI_GRBM_GFX_CNTL);
+		reg_access_ctrl->vfi_grbm_idx =
+			SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_VFI_GRBM_GFX_INDEX);
+		reg_access_ctrl->vfi_grbm_cntl_data = 0;
+		reg_access_ctrl->vfi_grbm_idx_data = 0;
 	}
 	adev->gfx.rlc.rlcg_reg_access_supported = true;
 }
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h
index 69731dcc324a4..d6a2839b4682a 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h
@@ -6917,7 +6917,18 @@
 #define regRLC_SPARE_INT_2_BASE_IDX                                                                     1
 #define regRLC_RLCV_SPARE_INT_1                                                                         0x0992
 #define regRLC_RLCV_SPARE_INT_1_BASE_IDX                                                                1
-
+#define regRLC_VFI_CMD                                                                                  0x099a
+#define regRLC_VFI_CMD_BASE_IDX                                                                         1
+#define regRLC_VFI_STAT                                                                                 0x099b
+#define regRLC_VFI_STAT_BASE_IDX                                                                        1
+#define regRLC_VFI_GRBM_GFX_INDEX                                                                       0x099c
+#define regRLC_VFI_GRBM_GFX_INDEX_BASE_IDX                                                              1
+#define regRLC_VFI_GRBM_GFX_CNTL                                                                        0x099d
+#define regRLC_VFI_GRBM_GFX_CNTL_BASE_IDX                                                               1
+#define regRLC_VFI_ADDR                                                                                 0x099e
+#define regRLC_VFI_ADDR_BASE_IDX                                                                        1
+#define regRLC_VFI_DATA                                                                                 0x099f
+#define regRLC_VFI_DATA_BASE_IDX                                                                        1
 
 // addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_cpwd_pwrdec
 // base address: 0x3c000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h
index 4db680044a831..f606c5cd03c59 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h
@@ -21945,6 +21945,24 @@
 #define RLC_RLCV_SPARE_INT_1__RESERVED__SHIFT                                                                 0x1
 #define RLC_RLCV_SPARE_INT_1__INTERRUPT_MASK                                                                  0x00000001L
 #define RLC_RLCV_SPARE_INT_1__RESERVED_MASK                                                                   0xFFFFFFFEL
+//RLC_VFI_CMD
+#define RLC_VFI_CMD__VFI_CMD__SHIFT                                                                           0x0
+#define RLC_VFI_CMD__VFI_CMD_MASK                                                                             0xFFFFFFFFL
+//RLC_VFI_STAT
+#define RLC_VFI_STAT__VFI_STATUS__SHIFT                                                                       0x0
+#define RLC_VFI_STAT__VFI_STATUS_MASK                                                                         0xFFFFFFFFL
+//RLC_VFI_GRBM_GFX_INDEX
+#define RLC_VFI_GRBM_GFX_INDEX__VFI_GRBM_GFX_INDEX__SHIFT                                                     0x0
+#define RLC_VFI_GRBM_GFX_INDEX__VFI_GRBM_GFX_INDEX_MASK                                                       0xFFFFFFFFL
+//RLC_VFI_GRBM_GFX_CNTL
+#define RLC_VFI_GRBM_GFX_CNTL__VFI_GRBM_GFX_CNTL__SHIFT                                                       0x0
+#define RLC_VFI_GRBM_GFX_CNTL__VFI_GRBM_GFX_CNTL_MASK                                                         0xFFFFFFFFL
+//RLC_VFI_ADDR
+#define RLC_VFI_ADDR__VFI_ADDR__SHIFT                                                                         0x0
+#define RLC_VFI_ADDR__VFI_ADDR_MASK                                                                           0xFFFFFFFFL
+//RLC_VFI_DATA
+#define RLC_VFI_DATA__VFI_DATA__SHIFT                                                                         0x0
+#define RLC_VFI_DATA__VFI_DATA_MASK                                                                           0xFFFFFFFFL
 
 
 // addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_cpwd_pwrdec
-- 
2.52.0

