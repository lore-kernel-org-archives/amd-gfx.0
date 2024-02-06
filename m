Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF84FC48297
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2CE110F6DC;
	Tue,  6 Feb 2024 15:59:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZNwN5f/Q";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10C1010F6DC
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qo4idSjvFk+ToiP4R80fRURar+pcmZBUHF8z8WAt6rzf28dvKEEecgu4RFpKN0R0bajJfNI907fEPltMtlXW1Y+AAQQIt+895MQzbZWQyz00ODe3gn+WM/uGaSYUKmQzzrBhjuke6/BxOkEzeua05sP6Mh0QyWN4GdnJomphZnOTiw58Dy4GBbUnNlTbWtomoy1WKPxQfxYhh7EI+TaFFkUKJsllyEywfQ1HNuNWuclUGQ95JLvMgHc3oogQpBtsy6PTpuy1QvAitlyX0vdgpFLyU4FS12ctAjQKhTH6JmyisAdj/cH/AP2k0yG7qD3CtKnr+MzgBV6XKFFEpiyqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k8usYKW5iClkSKO2ineHPgnkROdu9PqYreKe3Bxwv4=;
 b=Up5sGYBFMI0WAehQrONsX22PDcoN/y7Udhu78D081rlB10fS8s0NXUES3S+ZWb31IbbCxlk89L6XMe1O14q6DKZ5azG+X1JsF5rfsHZ4tvqZhwTpwrQ2Md1izbMkH9epRUM+YqR77/rXR8f/tF/B9rAoLu6FdYVuDXlj9p3T5DrzpSnXFrmmhbfozfI3uemw4IJ91B4+HG4xQoAvtKzMjD43PrC69P8ES6ojRvlxUzkSzFrA6r42r/crHpDEebPqpjeSNi8Yuv8XCZ+9TDfostpz9nVjeztnftE1PwS2HFuUNJCq0R6jlTkxpeRRb/LpV26tacEtUX3oaaVcfPZI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0k8usYKW5iClkSKO2ineHPgnkROdu9PqYreKe3Bxwv4=;
 b=ZNwN5f/Qii92elfkxcCiLbJXxl0vkMAicfGHhBLsoyr916/NjVLq9E4G9zOeHWiMvOLDygcf/z4xr8ljVFQ5Zxgxu3a4nmrcq/9xmYz4vmRwrsd89yLtPYnplgORzdAbokdOZCxTVY6e0Es581cI9LcSwLRSjQ37fWUYVM7uRSU=
Received: from SJ0PR03CA0225.namprd03.prod.outlook.com (2603:10b6:a03:39f::20)
 by BL0PR12MB4899.namprd12.prod.outlook.com (2603:10b6:208:1cf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Tue, 6 Feb
 2024 15:59:36 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::1a) by SJ0PR03CA0225.outlook.office365.com
 (2603:10b6:a03:39f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:35 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:33 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 03/24] drm/amdkfd: enable pc sampling query
Date: Tue, 6 Feb 2024 10:58:59 -0500
Message-ID: <20240206155920.3171418-4-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|BL0PR12MB4899:EE_
X-MS-Office365-Filtering-Correlation-Id: 97431a72-b2ba-48e5-94f5-08dc272c9d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nyRuE4hSMJz1BLzlsXEusoMyRJuTuI0MJXXTf7h3XkbaF8Lscjrdf+JeqbBYFlgpub7+c/544tna90R9b0zKgH0Nl8vA5pRWMw+ViBvzJtje35BDaFLx2uj23N1C60K9quwgpaQ1VLWaCfwhxOXwDuSRaSj9g9DHcGZ7dTA0JEVXDJKLV4JS5G92+ftXSL0DFgdxQIkUhqhTeKmTpjKTlz12AYC6AgN4xF6wB64i+TwLP4kaodF78CiGW+HK8cKtyzoWB+fNUVMXXG49N/ZU182c83S5hFiNceEAN1NBoswqAF/63T/oaJnsyMzkXWPSIhJs2hxxR/UBFxUCIa3oqhhgTKJGNVvZ1JbH+wxDf9dxBbJa4QApgqpONLpMQjoVZoCyPToyHCADyIDeypkEmP4qWyEsGtH+Xv342r3EAb6C/VvSPeMMzfeiMf1e6PZXgDQWxnIvMdWMcgr67tlJJ34uCZAEpiTF82hmPiaKFBPFu6w/DYEz3gwYnb2gyFnDK0Xf+llwMgdfvVK5KOlRNdHHzcM+AhFZwkCSu1KexnJkVaOqaWFIiMU2cr0zgojytOVFoAbMR+RcdBzYGTiWT51sR6t+A+Avh++6Exl5I5HVvHYM7DFQjkaKru7DK8/OFIr5dewOb8OmOoZcw0kmFW37pF/BAa9vz15DfRAIN4DKfk3rebUtPewtsSd4I6ODQJyyx0lVy9TPXgyfT1P11gqkyzeiferSumEPxKt4YhizZrjZZMmJulAAnHSLKTVdvcJQkgQW+bWt0ozDUazEbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(2616005)(70586007)(6916009)(70206006)(54906003)(83380400001)(1076003)(316002)(426003)(336012)(16526019)(26005)(478600001)(86362001)(7696005)(41300700001)(6666004)(5660300002)(40480700001)(40460700003)(4326008)(36756003)(8936002)(36860700001)(2906002)(81166007)(8676002)(47076005)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:35.3011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97431a72-b2ba-48e5-94f5-08dc272c9d80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4899
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

From: David Yat Sin <david.yatsin@amd.com>

Enable pc sampling to query system capability.

Co-developed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 65 +++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index a7e78ff42d07..e9277c9beec7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -25,10 +25,73 @@
 #include "amdgpu_amdkfd.h"
 #include "kfd_pc_sampling.h"
 
+struct supported_pc_sample_info {
+	uint32_t ip_version;
+	const struct kfd_pc_sample_info *sample_info;
+};
+
+const struct kfd_pc_sample_info sample_info_hosttrap_9_0_0 = {
+	0, 1, ~0ULL, 0, KFD_IOCTL_PCS_METHOD_HOSTTRAP, KFD_IOCTL_PCS_TYPE_TIME_US };
+
+struct supported_pc_sample_info supported_formats[] = {
+	{ IP_VERSION(9, 4, 1), &sample_info_hosttrap_9_0_0 },
+	{ IP_VERSION(9, 4, 2), &sample_info_hosttrap_9_0_0 },
+};
+
 static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *user_args)
 {
-	return -EINVAL;
+	uint64_t sample_offset;
+	int num_method = 0;
+	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(supported_formats); i++)
+		if (KFD_GC_VERSION(pdd->dev) == supported_formats[i].ip_version)
+			num_method++;
+
+	if (!num_method) {
+		pr_debug("PC Sampling not supported on GC_HWIP:0x%x.",
+			pdd->dev->adev->ip_versions[GC_HWIP][0]);
+		return -EOPNOTSUPP;
+	}
+
+	ret = 0;
+	mutex_lock(&pdd->dev->pcs_data.mutex);
+	if (user_args->flags != KFD_IOCTL_PCS_QUERY_TYPE_FULL &&
+			pdd->dev->pcs_data.hosttrap_entry.base.use_count) {
+		/* If we already have a session, restrict returned list to current method  */
+		user_args->num_sample_info = 1;
+
+		if (user_args->sample_info_ptr)
+			ret = copy_to_user((void __user *) user_args->sample_info_ptr,
+				&pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info,
+				sizeof(struct kfd_pc_sample_info));
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+		return ret ? -EFAULT : 0;
+	}
+	mutex_unlock(&pdd->dev->pcs_data.mutex);
+
+	if (!user_args->sample_info_ptr || user_args->num_sample_info < num_method) {
+		user_args->num_sample_info = num_method;
+		pr_debug("ASIC requires space for %d kfd_pc_sample_info entries.", num_method);
+		return -ENOSPC;
+	}
+
+	sample_offset = user_args->sample_info_ptr;
+	for (i = 0; i < ARRAY_SIZE(supported_formats); i++) {
+		if (KFD_GC_VERSION(pdd->dev) == supported_formats[i].ip_version) {
+			ret = copy_to_user((void __user *) sample_offset,
+				supported_formats[i].sample_info, sizeof(struct kfd_pc_sample_info));
+			if (ret) {
+				pr_debug("Failed to copy PC sampling info to user.");
+				return -EFAULT;
+			}
+			sample_offset += sizeof(struct kfd_pc_sample_info);
+		}
+	}
+
+	return 0;
 }
 
 static int kfd_pc_sample_start(struct kfd_process_device *pdd)
-- 
2.25.1

