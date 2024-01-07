Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AAFC47073
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Jan 2024 15:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A10DA10E042;
	Sun,  7 Jan 2024 15:41:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED67C10E042
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Jan 2024 15:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5MWWCzxWEQBOtfD/dYHaa3H9bihWILvXVzhLVreE7xmbYX2qAT+lNDbekcbVtfKRYQVNnX1Qh1eDyPmqiegm2EGKb0cg1kS5WhE94OiFnPpR0kE1f2xKpRgxFSuzfOCz0mlPyZxFiUdD+uGxfkwigyWc837GT3LXyF5H5ET4HiT9apvDzYTKLK7T+NzHwWHjl2fEVwfP72kI4Rv00j69vm99p4YNqp95jSKNq4FSR5txf/z9Dxr9dudRzq2anDj2+Ft+thtfr3jM1qD7cl+lsZ00vav1RUlvIrGzbNQ3UyfphSpOcxh+60RpMq7j6S0AK7bsarlJKtR+mqTu5InLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7t15InTnGFchvbIWQfAVWZ1fsi+L5nG5E9xemr4AzjI=;
 b=N8lDu/L+GEyjea6tokOWLp9XFmI3KN75wsl0tRx76Z4ikLuBnrVwMczmq5/X8hU/eSoXQ+TCCew7nLywjerwoA81lOauX/jp8EpqOp6xWpWhRO7gyDt9jdYo9bJ1PjX3+8Uu4NDSh3VtVJpZvDS+mYUKXbC2Vdqp18GqNgXn9YuJ5wHl4RBxq0Ieu/tG108Cu5BCze3Lkjzo11K8TtY5AtcT5ie0wjeB8FETRF3nU1EPUeEhsg3KGB0Yj7LNNF365gsbCBUYbpOCJC3R7ZZOMKzkAHRbhqm+hDT8t8HwJDg9UHkp8Mh9ylFyVT6X3EzuXhLW0jTPRMaeUwQi787SAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7t15InTnGFchvbIWQfAVWZ1fsi+L5nG5E9xemr4AzjI=;
 b=iyQSTUv+VbQPoXKuwuBs9l95dXtj5rrqhZzuoIQ1l+FSWltE4IwhwmSftqrSt/AFtmf4J0BaC02YoTGYeWyATURuERApCijVY9NQKLCBvLKZT16go6ItILphhBXcRa2MS2Hti6U8II/PWRfTrP6eLtmh8oLjzOr1zZvalvaT9h4=
Received: from DM6PR03CA0003.namprd03.prod.outlook.com (2603:10b6:5:40::16) by
 MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.20; Sun, 7 Jan
 2024 15:40:56 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::a6) by DM6PR03CA0003.outlook.office365.com
 (2603:10b6:5:40::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.20 via Frontend
 Transport; Sun, 7 Jan 2024 15:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Sun, 7 Jan 2024 15:40:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 7 Jan
 2024 09:40:55 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Sun, 7 Jan 2024 09:40:53 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH v2 v2 2/5] drm/amdgpu: Init pcie_index/data address as
 fallback (v2)
Date: Sun, 7 Jan 2024 23:40:08 +0800
Message-ID: <20240107154011.12927-7-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240107154011.12927-1-Hawking.Zhang@amd.com>
References: <20240107154011.12927-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a3023b-41e9-4bda-c4c5-08dc0f970a31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKOi3On4QOZYNCYgjiiq59OgEIMXj9PwNDQNnhanc75AJYJQIn04QQ22Zafyc0T2XdV5NMFKljoPvpKOcTOUSWUPo7jc0prHLZyw445KnvROv6RtQkLZSn17JuCGVlGGXKPd2+TTk9KOta/AVrtR6HRaSR6CYEjG682T3xJ7yIXx2U0xm3OYOkkrMAzVdw/aPeYB1eEz0ZGtU5MJKhswscnUnvdOU3ODyhbkRbgLH8BDfJugks+dxjuRKNms8/i6gSo0Dvw+XZQsYgpd+X0Cl74SHw6lonAXLPiK68efNx/oDjkJCUXscsmNuw9/NHmYLV/0mddKMRosgLsd9V+ALYg56mldLz01CPQjPoAXT5PKsXiY9FU1R9Kn1Irr3G5tLKkz2+BKfDMJ+XTtPfnM2QIvpxZGKJs84vn8Dv18603crrkqkdpTzZvSa7VfVmVo6sNDswGeWMS8bhj4jSObEEEn3UfYujqnqk77bAIxV0sxtlw+O4h6QtxNhDApXnQGnbnhRcgYzapiVHKg+qwf8RVHIxRxbc/GCERgNQvEhqCvsdet6VULm7PXtfx0blVtXO/E0oprLfZMo3VD0UPUpjVThWa4l9a7yi3N1rsRbVHBz2iGhjqr0bThzrxwE9XF3FFTO9MmcyMgmjoh91flhWJr1ufKRMkaDFghB7pM6XV5tijUIrYf0Zyc6BOzvm5+AdO6XQvBiWZsNzTqxTaauzg4KfQOkTE3OY9x0SwH3+dxNv09WE8B93nEBwYOoRcWUQjQtPD3cy+eieaO0yBKRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(40470700004)(46966006)(36840700001)(82740400003)(81166007)(356005)(36756003)(8676002)(8936002)(110136005)(54906003)(316002)(6636002)(336012)(426003)(5660300002)(4326008)(83380400001)(478600001)(7696005)(6666004)(1076003)(26005)(70586007)(70206006)(2616005)(41300700001)(2906002)(47076005)(36860700001)(40460700003)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2024 15:40:56.4498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a3023b-41e9-4bda-c4c5-08dc0f970a31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To allow using this helper for indirect access when
nbio funcs is not available. For instance, in ip
discovery phase.

v2: define macro for pcie_index/data/index_hi fallback.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23 +++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index abad5773714c..05d7cdcf28b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -96,6 +96,9 @@ MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
 #define AMDGPU_RESUME_MS		2000
 #define AMDGPU_MAX_RETRY_LIMIT		2
 #define AMDGPU_RETRY_SRIOV_RESET(r) ((r) == -EBUSY || (r) == -ETIMEDOUT || (r) == -EINVAL)
+#define AMDGPU_PCIE_INDEX_FALLBACK (0x38 >> 2)
+#define AMDGPU_PCIE_INDEX_HI_FALLBACK (0x44 >> 2)
+#define AMDGPU_PCIE_DATA_FALLBACK (0x3C >> 2)
 
 static const struct drm_driver amdgpu_kms_driver;
 
@@ -781,12 +784,22 @@ u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev,
 	void __iomem *pcie_index_hi_offset;
 	void __iomem *pcie_data_offset;
 
-	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
-	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
-	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
-		pcie_index_hi = adev->nbio.funcs->get_pcie_index_hi_offset(adev);
-	else
+	if (unlikely(!adev->nbio.funcs)) {
+		pcie_index = AMDGPU_PCIE_INDEX_FALLBACK;
+		pcie_data = AMDGPU_PCIE_DATA_FALLBACK;
+	} else {
+		pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
+		pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
+	}
+
+	if (reg_addr >> 32) {
+		if (unlikely(!adev->nbio.funcs))
+			pcie_index_hi = AMDGPU_PCIE_INDEX_HI_FALLBACK;
+		else
+			pcie_index_hi = adev->nbio.funcs->get_pcie_index_hi_offset(adev);
+	} else {
 		pcie_index_hi = 0;
+	}
 
 	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
 	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
-- 
2.17.1

