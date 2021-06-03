Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AD7C47096
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 10:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1089613B8
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 10:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1089613B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E106E111;
	Thu,  3 Jun 2021 10:42:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04F8F6E111
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 10:42:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgogHd9ggwyv/thUNrQ/DnbiF00weKsnOWYKbng5q8MbGbgNuDUvNJE0FEKJw+I9rmcUJmy4l5ohWr6bJ9ZaxtA3GTwwnlf8FK+bbc2RPpTFKV2xUIEFsz6Oo7EEdcDfoHsnEK9lID9YIxIoX2RTQJiKpQvwaXhl0oV8kFEHKf24S5QyHjadNO60a30wDy2zlVc5owiU5WlIvrlVIkMNf1VFfsbTxJOzhdz9eOd/V75lcXV6xa7dzinjARb2StqrR52bBVVZKknUCHVGRCcCwfYnXuTbHmU2FkR4yC7adCagkekNsk/998nvigO+6Q3xq3KUeZtk8TFuWiKNsYB2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XllMOzpXOcyOdu6WH1yhcpNgnP5ImWl5+HqQnDgc06o=;
 b=WgA1W049gzHNy8HDNOHl0nEr9dSRnfJF3WNbMDtDn2tg5pyA931ZMoS4FNulS+uXPmvj+o0Dw/q6piN/H0eVNJ/TQkgJHRd6luSXEyEHWVb57WJUlmx+GxM5vOioAk6CeP8FoicCZhxnLT2iBH/qvZVVLPzaM5Q3YtlH9xwgWdH8HmjktTVs6zrqqXfrqkY7IRNMu45NR5KnMNliCdVC7wtS1XF7Yab7vgj5rDGPEMRNHh0shuvGujwdDPNo06Ja0fXZwkII/ag+7vQJfj8HIbTD2yAVaqHz+FfGlUzi4anBGiRUleFCrgvtpL/2to/nx6ucbbtQyBsW77MMriDUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XllMOzpXOcyOdu6WH1yhcpNgnP5ImWl5+HqQnDgc06o=;
 b=ckZrZkaR8i45m1iRwkGGiMU8wVdruRQYL7ejBi2eRVUSDuxzEDI4xq8aLzfMGXWEegiv8Y5TSQPIYT14if1AA0Qy/KwPC7r6TgtpVxJBiamwQlXkXN36v9DQwyaakNAF27lJMr8SmLkSNiIpGEc9z1VwfJnkWWJfLX/pvsrjnEo=
Received: from BN0PR04CA0193.namprd04.prod.outlook.com (2603:10b6:408:e9::18)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Thu, 3 Jun
 2021 10:42:18 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::d8) by BN0PR04CA0193.outlook.office365.com
 (2603:10b6:408:e9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Thu, 3 Jun 2021 10:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 10:42:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 3 Jun 2021
 05:42:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 3 Jun 2021
 05:42:16 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 3 Jun 2021 05:42:15 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/amdgpu: Use IP discovery data to determine VCN
 enablement instead of MMSCH
Date: Thu, 3 Jun 2021 18:42:07 +0800
Message-ID: <20210603104208.5725-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46e9e566-c5af-4da5-f4c0-08d9267c4216
X-MS-TrafficTypeDiagnostic: CH2PR12MB4294:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4294870BF7496811BF346414F83C9@CH2PR12MB4294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VaLQTVr0Ej/jWhZLJCWQ9O2r1qMGgJpE7iOUEQJigZMksMBEu+UYz5gywXsGkQTIivkN2xSdBxzbTn5nKZdTiMI6jsdet9DdAMLBeZ7uNFAjxlwfYr3M6XvMrme7PC9/99uhuUvMnL5g4ekubkIyfjr6WogWINoA4TuXPKNKibSVghdI49nP0mranxD1WEOgW5T8gz1T2E96y0BZOQ/ZQN3+0IAg3136DtXBeR3oPsZr5blSC9ovYrw2g/yiReOMwy+tt8uOzEYp7UO4e5/PKw9oiC0ljSdBWWr4AzrS+xX4+OgR0ICPrk2pOQt0NATnzffrvO4WX3/Du+HATZ9wObMKU+pb9BYAeI8OqLKrwL7eTk64qXc4WLcDkAE/xjHERQe0q4/El+clubNZyJam3jRExKoNvMxlwYFzhSm3GtJLTeOjWKs9ZDoz3+usu9UNFv3MJC9GDDJ0wcsJ10lUkRU8icJxNsCzbM4WgKyT7DHeAOAxSkrqqiHbJgXzTd5/ALgFkbT778TQ13d3wqJqp1gGINHRHBpDqoigPga4+FT5ACcn3VKn8sVj2zn1deu6JZDG8YshMtyzObeKa/+O77hxE0Ir1+IL4+ZSwwpdFkQEDNuEWstvrZoyiIMuTuyR8Rd1QgcQRzH85GJo+uXCeub6Wrd1PF28kJfiiosgyNiIs0pz0lYeuTGBlfaKwVp3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(36840700001)(46966006)(7696005)(86362001)(83380400001)(6916009)(82310400003)(426003)(356005)(336012)(186003)(82740400003)(26005)(2616005)(36860700001)(81166007)(8936002)(478600001)(5660300002)(4326008)(2906002)(47076005)(36756003)(6666004)(1076003)(70586007)(70206006)(54906003)(8676002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 10:42:17.5812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e9e566-c5af-4da5-f4c0-08d9267c4216
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
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
Cc: Bokun Zhang <Bokun.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bokun Zhang <Bokun.Zhang@amd.com>

In the past, we use MMSCH to determine whether a VCN is enabled or not.
This is not reliable since after a FLR, MMSCH may report junk data.

It is better to use IP discovery data.

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 73 +++++++++++++++++----------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index ce3c794c176f..92f88ea69035 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -27,6 +27,7 @@
 #include "amdgpu_pm.h"
 #include "soc15.h"
 #include "soc15d.h"
+#include "soc15_hw_ip.h"
 #include "vcn_v2_0.h"
 #include "mmsch_v3_0.h"
 
@@ -63,6 +64,17 @@ static int amdgpu_ucode_id_vcns[] = {
 	AMDGPU_UCODE_ID_VCN1
 };
 
+#define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
+#define VCN_BLOCK_DECODE_DISABLE_MASK 0x40
+#define VCN_BLOCK_QUEUE_DISABLE_MASK 0xC0
+
+enum vcn_ring_type {
+	VCN_ENCODE_RING,
+	VCN_DECODE_RING,
+	VCN_UNIFIED_RING,
+};
+
+static bool vcn_v3_0_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance);
 static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
@@ -324,18 +336,26 @@ static int vcn_v3_0_hw_init(void *handle)
 				continue;
 
 			ring = &adev->vcn.inst[i].ring_dec;
-			if (ring->sched.ready) {
+			if (vcn_v3_0_is_disabled_vcn(adev, VCN_DECODE_RING, i)) {
+				ring->sched.ready = false;
+				dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
+			} else {
 				ring->wptr = 0;
 				ring->wptr_old = 0;
 				vcn_v3_0_dec_ring_set_wptr(ring);
+				ring->sched.ready = true;
 			}
 
 			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
 				ring = &adev->vcn.inst[i].ring_enc[j];
-				if (ring->sched.ready) {
+				if (vcn_v3_0_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
+					ring->sched.ready = false;
+					dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
+				} else {
 					ring->wptr = 0;
 					ring->wptr_old = 0;
 					vcn_v3_0_enc_ring_set_wptr(ring);
+					ring->sched.ready = true;
 				}
 			}
 		}
@@ -1286,6 +1306,29 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 	return 0;
 }
 
+static bool vcn_v3_0_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
+{
+	bool ret = false;
+
+	int major;
+	int minor;
+	int revision;
+
+	/* if cannot find IP data, then this VCN does not exist */
+	if (amdgpu_discovery_get_ip_version(adev, VCN_HWID, vcn_instance, &major, &minor, &revision) != 0)
+		return true;
+
+	if ((type == VCN_ENCODE_RING) && (revision & VCN_BLOCK_ENCODE_DISABLE_MASK)) {
+		ret = true;
+	} else if ((type == VCN_DECODE_RING) && (revision & VCN_BLOCK_DECODE_DISABLE_MASK)) {
+		ret = true;
+	} else if ((type == VCN_UNIFIED_RING) && (revision & VCN_BLOCK_QUEUE_DISABLE_MASK)) {
+		ret = true;
+	}
+
+	return ret;
+}
+
 static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 {
 	int i, j;
@@ -1303,8 +1346,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 	uint32_t table_size;
 	uint32_t size, size_dw;
 
-	bool is_vcn_ready;
-
 	struct mmsch_v3_0_cmd_direct_write
 		direct_wt = { {0} };
 	struct mmsch_v3_0_cmd_direct_read_modify_write
@@ -1496,30 +1537,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 		}
 	}
 
-	/* 6, check each VCN's init_status
-	 * if it remains as 0, then this VCN is not assigned to current VF
-	 * do not start ring for this VCN
-	 */
-	size = sizeof(struct mmsch_v3_0_init_header);
-	table_loc = (uint32_t *)table->cpu_addr;
-	memcpy(&header, (void *)table_loc, size);
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-
-		is_vcn_ready = (header.inst[i].init_status == 1);
-		if (!is_vcn_ready)
-			DRM_INFO("VCN(%d) engine is disabled by hypervisor\n", i);
-
-		ring = &adev->vcn.inst[i].ring_dec;
-		ring->sched.ready = is_vcn_ready;
-		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
-			ring = &adev->vcn.inst[i].ring_enc[j];
-			ring->sched.ready = is_vcn_ready;
-		}
-	}
-
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
