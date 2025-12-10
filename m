Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B42D3C526
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D844B10E67D;
	Wed, 10 Dec 2025 07:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k2z9ZVD1";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE1210E67A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efDZOb8X02NgdeDNAqkt2mktmNenwxW3Jv9CIcZ+BPABQGlGr0xAsaR879wUgMr58vDosBf0GJAEqw0dW26/hfucTs7aek6tG+hzTU8urDZ7cg7uk7FK2yYBnYMouwDWiNcskyx7meRhINHLeYSFEmnpQo7o4vwjUtlMwObvbGnxqDbHKRGVu27b+MCwrZXnTCR5dcnezfTIgomaPZP25jhPUy8oIYOwFGEK11fzUcm6uRlg+b5DT8HbLaHhNeZoSnP/TOq+LD6siyP96QlIePZhG+M6fgiYgNUlGeZEBDh82TCEUNj9/jdU7e7bb+A0s/rb6my5pBOFajXBxE/r1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTJtJfzdN/3UNOdCqvvh4NtZl9ZkmaJpEveqELOyMg4=;
 b=qjandsc6uA5SVmxAy4vAHeLlo6JklBNgXbTRD3DLaXpPKcKgPkI8MHJm815S7KRUWgA2ZhXr2fzmd31Fi1sBNytikCL7j1IvM2YSL66Vq2Lp+qZgRJhX3HAR1XGidGNEhUpOz0GB5/AC/uhpA4ouYwvw7zweKbJqYXMUdvGvqPAovBcUxPP0By+goUCXv9hdeYBD4OmLUumTWj8xhRy96YuQPUIaIhOUcYw0ni1OBL0L+Jp3f34kw0Wq22nMcvophP3eYXbmCzPDtjEyDOFuWKtCZ8AsqGgUIANZYTGjSAZ3c3TXSeuY6VatHm6ZYEQQL4PE+spaf/mkV4NlMxgBww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTJtJfzdN/3UNOdCqvvh4NtZl9ZkmaJpEveqELOyMg4=;
 b=k2z9ZVD1ypLvQd+w9tO4v3DrV0dUomami7AuMvr5Lb3h8eq1d/kSmDXlnpQQhLaHCh/uwjvFyZQ249HaASkRheeHokTNnahc8kHl348YkoUF1M52h8Urv/23VCdjYyqfX7eY/DtGV7EAXkOdbwjYwSpM/qOCgneeaj64b1vOWVA=
Received: from SA9PR13CA0035.namprd13.prod.outlook.com (2603:10b6:806:22::10)
 by SA1PR12MB8886.namprd12.prod.outlook.com (2603:10b6:806:375::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 07:14:29 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::c4) by SA9PR13CA0035.outlook.office365.com
 (2603:10b6:806:22::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.4 via Frontend Transport; Wed,
 10 Dec 2025 07:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:14:28 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:14:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add soc v1_0 ih client id table
Date: Wed, 10 Dec 2025 02:13:56 -0500
Message-ID: <20251210071415.19983-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210071415.19983-1-alexander.deucher@amd.com>
References: <20251210071415.19983-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SA1PR12MB8886:EE_
X-MS-Office365-Filtering-Correlation-Id: 742404c4-bdcc-4936-57f6-08de37bbc218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vOah8XZJc6o7DJ5aIdBsNaBNQvCXwLaUnLpbMCMkKwX5p6z3VUB3L/dZKFbJ?=
 =?us-ascii?Q?+4+nfONZqkED0PQPnTNEVh6BQYB8mQ82fqeHG2lDzcPFYbIhRCR2JV3Oq/Ov?=
 =?us-ascii?Q?ocLsewyUp18aZcU0DYJmVr2PnkCE/shIxYXN86TcXtgJJgoVK+o6M7hOeWMx?=
 =?us-ascii?Q?7Yyq4CrzWhZEp8Zss9Umm2SfXHsPpgFqJ7BK4nwat+iDvX5HIb1v1Zj1ZiOu?=
 =?us-ascii?Q?J0YzY3sDSBnfPUrvXQ2hMM5bI6I7xvkdAAn94JpIaxufPlhCTrR54t2P4Sb9?=
 =?us-ascii?Q?hXq85PAJMqwefWJ5H4L7Ah0jzrRY6Ee2SCeuJ/NYgvUmz9StHRTI/XT1Aqv2?=
 =?us-ascii?Q?GcXhw8cXzBhTo3hIeXLh5dmx399SZbJMwSNw8CzF4xI3p1XyK9wB9GF/whLZ?=
 =?us-ascii?Q?PinYtBQHm85BaH+o3Dsb7nOUSKVcGd+HrETrsLvHre/IIrKj0RacVMqpBLaZ?=
 =?us-ascii?Q?J7arrw4UB12NaEAH16FUC8CBCX/mffK8VgFdiLLE8V9xuyZKcfSHJyO8Eju6?=
 =?us-ascii?Q?fb1Jt292jKlUqIif2JjWu65KwhCev3XMKhXRyM/TEXEDNH64pesVHzPxXHra?=
 =?us-ascii?Q?9rGmwzUPMXZmE4zQC2LkyRgjlmZ6GoIoe72eBBcF1O0U3gZjqeNE5ELXrFAc?=
 =?us-ascii?Q?kJExasrM1lYKjyU3JGvrYzIFZaBlx8I9eGqWsKUh0KVEh+OtHhxeAaUrsXYG?=
 =?us-ascii?Q?Jg+89Gic78B4TAFI2cpaeVjzM9nlasnwEHTJoF9kkWaG0AqZtVNaZeXTBhZo?=
 =?us-ascii?Q?cneoX6k4zmINwismHN4zNgq1pN2Omrnv2ObxDFVINrRgAcrSN7T3aQclkRqd?=
 =?us-ascii?Q?FbiLz9yli869HVZBDHHJKWmJ78MfOia6mH6WzTptU7C5iQoeau5IxyhwjId5?=
 =?us-ascii?Q?Rmdprj8CwS1Hsuvic4wZgSYSl3R+tR5YiuJStJ1DwPNZ2zTHkwmOXuxxeqyL?=
 =?us-ascii?Q?wkKDeGyNNVlRZaDyQYCWN0qhizV5cIfUSVkHhm3OBA2L70zz+hCKJ39oxaIj?=
 =?us-ascii?Q?EUjnAIWO9ym0SsLJAgH6Sz7NP3SjpH2veGqJqYa1hpJGI462DVslbr2HkSwR?=
 =?us-ascii?Q?2pS8mZvMOR7eBcWPfZiimgosQyUaCE1DrjEJN21I5vI71mcmrDqkizrIQmtu?=
 =?us-ascii?Q?jE6sWqPqGwDvPMlwDNnBeocKT4GeHailqPPpcr7fo173funFoTmgUp3T78bW?=
 =?us-ascii?Q?BJKF8UCLAKKMTUEHKsplJVQ7ghmr++usdK4RtCD542toqO2OeOh+L+HOezkO?=
 =?us-ascii?Q?LLvdOIUJDUpTBuSbuC7ud0jH3YMU4BWfObfe3r4MgTdqePs7mf8bvIhXMW4H?=
 =?us-ascii?Q?WR6IpKBVItX0vUtHzeEizzik8KkPokcbFB99mV296s2XdYDqUNYPhlWK0Myo?=
 =?us-ascii?Q?8nGWOpyT88pNuKo/bYmbdG1OT8kNkWJUxe1R94DPgOuFW3hDIGRHXoRRjHKp?=
 =?us-ascii?Q?wxLK7yd2PTJasxsCip7mAhdLvNq5oVj5Wt8LNk588IFUtP81pCbnW/7WQ16M?=
 =?us-ascii?Q?8hUQXYZrqxNDrELOy3pjNfGoYZO4eOFMuekxJDW7CansBPW0uoRZOK79/e6X?=
 =?us-ascii?Q?75DjR/0xuV4hJCp9n0c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:14:28.7324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 742404c4-bdcc-4936-57f6-08de37bbc218
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8886
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

To acommandate the specific ih client for soc v1_0

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       | 35 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        |  6 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c        |  6 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c        |  4 +-
 .../drm/amd/include/soc_v1_0_ih_clientid.h    | 52 +++++++++++++++++++
 6 files changed, 96 insertions(+), 8 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/include/soc_v1_0_ih_clientid.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 8112ffc85995e..0a1bf61a11320 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -99,6 +99,41 @@ const char *soc15_ih_clientid_name[] = {
 	"MP1"
 };
 
+const char *soc_v1_0_ih_clientid_name[] = {
+	"IH",
+	"Reserved",
+	"ATHUB",
+	"BIF",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"RLC",
+	"Reserved",
+	"Reserved",
+	"GFX",
+	"IMU",
+	"Reserved",
+	"Reserved",
+	"VCN1 or UVD1",
+	"THM",
+	"VCN or UVD",
+	"Reserved",
+	"VMC",
+	"Reserved",
+	"GRBM_CP",
+	"GC_AID",
+	"ROM_SMUIO",
+	"DF",
+	"Reserved",
+	"PWR",
+	"LSDMA",
+	"GC_UTCL2",
+	"nHT",
+	"Reserved",
+	"MP0",
+	"MP1",
+};
+
 const int node_id_to_phys_map[NODEID_MAX] = {
 	[AID0_NODEID] = 0,
 	[XCD0_NODEID] = 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
index 9f0417456abda..af72405a72262 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -26,6 +26,7 @@
 
 #include <linux/irqdomain.h>
 #include "soc15_ih_clientid.h"
+#include "soc_v1_0_ih_clientid.h"
 #include "amdgpu_ih.h"
 
 #define AMDGPU_MAX_IRQ_SRC_ID		0x100
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index a30fac3d57609..a8f020a375c92 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1140,21 +1140,21 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
 	/* EOP Event */
-	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
+	r = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_GRBM_CP,
 			      GFX_11_0_0__SRCID__CP_EOP_INTERRUPT,
 			      &adev->gfx.eop_irq);
 	if (r)
 		return r;
 
 	/* Privileged reg */
-	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
+	r = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_GRBM_CP,
 			      GFX_11_0_0__SRCID__CP_PRIV_REG_FAULT,
 			      &adev->gfx.priv_reg_irq);
 	if (r)
 		return r;
 
 	/* Privileged inst */
-	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
+	r = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_GRBM_CP,
 			      GFX_11_0_0__SRCID__CP_PRIV_INSTR_FAULT,
 			      &adev->gfx.priv_inst_irq);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index fa46b0089e8dd..19cd38ce57c94 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -124,7 +124,7 @@ static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
 		write_fault = !!(entry->src_data[1] & 0x200000);
 	}
 
-	if (entry->client_id == SOC21_IH_CLIENTID_VMC) {
+	if (entry->client_id == SOC_V1_0_IH_CLIENTID_VMC) {
 		hub_name = "mmhub0";
 		vmhub = AMDGPU_MMHUB0(node_id / 4);
 	} else {
@@ -198,8 +198,8 @@ static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
 		amdgpu_vm_put_task_info(task_info);
 	}
 
-	dev_err(adev->dev, "  in page starting at address 0x%016llx from IH client %d\n",
-		addr, entry->client_id);
+	dev_err(adev->dev, "  in page starting at address 0x%016llx from IH client %d (%s)\n",
+		addr, entry->client_id, soc_v1_0_ih_clientid_name[entry->client_id]);
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 753512276e373..446b7527f5c62 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -1277,7 +1277,7 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_block *ip_block)
 	u32 xcc_id;
 
 	/* SDMA trap event */
-	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GFX,
+	r = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_GFX,
 			      GFX_11_0_0__SRCID__SDMA_TRAP,
 			      &adev->sdma.trap_irq);
 	if (r)
@@ -1526,7 +1526,7 @@ static int sdma_v7_1_process_trap_irq(struct amdgpu_device *adev,
 	}
 
 	switch (entry->client_id) {
-	case SOC21_IH_CLIENTID_GFX:
+	case SOC_V1_0_IH_CLIENTID_GFX:
 		switch (queue) {
 		case 0:
 			amdgpu_fence_process(&adev->sdma.instance[instances].ring);
diff --git a/drivers/gpu/drm/amd/include/soc_v1_0_ih_clientid.h b/drivers/gpu/drm/amd/include/soc_v1_0_ih_clientid.h
new file mode 100644
index 0000000000000..11ab4b7d61e10
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/soc_v1_0_ih_clientid.h
@@ -0,0 +1,52 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#ifndef __SOC_V1_0_IH_CLIENTID_H__
+#define __SOC_V1_0_IH_CLIENTID_H__
+
+extern const char *soc_v1_0_ih_clientid_name[];
+
+enum soc_v1_0_ih_clientid {
+	SOC_V1_0_IH_CLIENTID_IH			= 0x00,
+	SOC_V1_0_IH_CLIENTID_ATHUB		= 0x02,
+	SOC_V1_0_IH_CLIENTID_BIF		= 0x03,
+	SOC_V1_0_IH_CLIENTID_RLC		= 0x07,
+	SOC_V1_0_IH_CLIENTID_GFX		= 0x0a,
+	SOC_V1_0_IH_CLIENTID_IMU		= 0x0b,
+	SOC_V1_0_IH_CLIENTID_VCN1		= 0x0e,
+	SOC_V1_0_IH_CLIENTID_THM		= 0x0f,
+	SOC_V1_0_IH_CLIENTID_VCN		= 0x10,
+	SOC_V1_0_IH_CLIENTID_VMC		= 0x12,
+	SOC_V1_0_IH_CLIENTID_GRBM_CP		= 0x14,
+	SOC_V1_0_IH_CLIENTID_GC_AID		= 0x15,
+	SOC_V1_0_IH_CLIENTID_ROM_SMUIO		= 0x16,
+	SOC_V1_0_IH_CLIENTID_DF			= 0x17,
+	SOC_V1_0_IH_CLIENTID_PWR		= 0x19,
+	SOC_V1_0_IH_CLIENTID_LSDMA		= 0x1a,
+	SOC_V1_0_IH_CLIENTID_GC_UTCL2		= 0x1b,
+	SOC_V1_0_IH_CLIENTID_nHT		= 0X1c,
+	SOC_V1_0_IH_CLIENTID_MP0		= 0x1e,
+	SOC_V1_0_IH_CLIENTID_MP1		= 0x1f,
+	SOC_V1_0_IH_CLIENTID_MAX,
+};
+
+#endif
-- 
2.52.0

