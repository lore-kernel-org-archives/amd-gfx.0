Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056C4C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 15:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3954D10EB72;
	Thu, 27 Apr 2023 15:27:46 +0000 (UTC)
Received: from outbound.mail.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34B8B10E353
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 15:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NT1xgNOGEf2RvLNe+H80mh/sPMQtG6wUtmgLss5IundRzqBCbd+fJlpqNYo4nPZDWyeKz+yasKlGPi06mDLJZ71gH8TA5jE7f9uWnrj8Y/cxOWPPkalGrj1Q/RgNNW6FEhYN87Qcn2Vht7ES5e46OGcQHveC5uUHDfXWcFDYhHIgxHzS0c7wrsq/zlIOI46hftbY1CH0Qk9Errj3C1okJqu7BywrQhWnFKOw+i2zYXPT4qMSMuIwAmf38WlrJd7DYMZTMzjIJZywiHGdTgjQCskRTXDkGENVZ/ycNeGwPGDOEnptPqhOq05km1isrMItuGB03k7w+DCdeksBZp/OUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZXfF9d1z6a6uhJue73xZPaFfyAfX5WLl3VFLARfNsY=;
 b=gNkuoMBTnociLallY/R2m4ZTJFrSCj5IXlHt32tfLKGUmGM1y1Qpn8//UMtESdIh/ylC/+2i+JL/bThnnzGkCe/a4hzpvLSth0QZ9ddf+kblMQgHnv6krAEJFU/W9PS4I+G+yAUJC9TSbzNDoA9eGHQIpSeIEEaLS6oAigeEdnSpeYHLM5zQPzLnDgVi++cSGN+uxQr1Odbm6NEBeOyQjiX5bGQop+WJREvoVoVKP3ssFMWNFr36gf/18AngD8N5m1Il95opeQtxQfDsiPVE/MGMHSfXgvycNSPZJBTcRlnk1cYwmX/ItPj9J/0nhV0L2iQj8Gwcks2LBnpDU4jNFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZXfF9d1z6a6uhJue73xZPaFfyAfX5WLl3VFLARfNsY=;
 b=hDitzUOh5WGJF7qe8Cuc3NxtJpBzdYSs+oI/tnt2yXiPVKLABqwcXuj8xahmyezuh+D+VyxlYVYYsV365l6prFMQOw8/LWFWHs8JdtSOd5ydx37JzUo+IkQJTCA8G3M9QapjWZ2VxaUJn0oC0ap+57MKrgVEOpesRBJhE4XTm4I=
Received: from BL1P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::26)
 by PH0PR12MB5434.namprd12.prod.outlook.com (2603:10b6:510:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 15:27:40 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::a4) by BL1P221CA0014.outlook.office365.com
 (2603:10b6:208:2c5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 15:27:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.16 via Frontend Transport; Thu, 27 Apr 2023 15:27:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 10:27:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/12] drm/amdgpu: put MQDs in VRAM
Date: Thu, 27 Apr 2023 11:27:09 -0400
Message-ID: <20230427152709.7612-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427152709.7612-1-alexander.deucher@amd.com>
References: <20230427152709.7612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|PH0PR12MB5434:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e18b35-c55b-49af-36b3-08db4733f066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGmDK6W9JTUMt+d/ptit/vKjLirScRE6Yi0q3FDWQlAGVd1V7TfB9N8oGCC57ZSWfGOu0A5A3kON9/HaGwpvDF/XXoqPNU5PvJa4Dd96USGyVOOZPsn46cXFviTz8AMDJCoZhUWeDWrIDcuX2FCW8f6JwGlplekQLqDBxLmlBzch+4BPmujQj/KlChtpCR90jqQOFygsjO1b16jS0RFdLIsO2NP8O/csNZdQEQLO2gy/mcmX2QrlLuVMzf7RSh04evhK6rzu7BSMOH/duBj5VkjiIsCX7pwLPk9ivmnAqI9jhleUCb5h6xT7p063/VbjvO/cezeDOsZMPqQ+xoHKTYz6wDCt8vwZejVQ9IYk70LoOcQZwgV1TJ9T0jtOupFZCCeQytUOPoCbBSkcY3NacJywILOkdJ0KCdLNS9VIxsWxo2Nu8UipyB6fofznwyzxrOeFQsT/Yz+5sTm7DeayeE76QEtQCYfdqfbzb/5i4Ov/ZF/m9KNhmu4cIG8LH1tTAB6odbrDstC1qDuT+cd69U/mnkYdy6rFyEIWN8j2WgiWFpCW9EOKcS1/KaB/7+1oQRBQnKpW5WjcYIagsjtpYeeG+f3GR4IsMjJWurBGQFAZhi0Q7x40mFeXAzo3CrrcLmfdfblRs+mBopnhOiPuKHC6Bm1fbjQDX6Ja7rGWw90VHJadAykmnt1OfIKQEex0pRVGpMsGOpdhI9mS5ArH3B/WURT6wgIUhnO7ZegozRA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(86362001)(82310400005)(36756003)(2906002)(40460700003)(40480700001)(6666004)(7696005)(36860700001)(2616005)(47076005)(336012)(186003)(16526019)(426003)(26005)(1076003)(6916009)(4326008)(70206006)(70586007)(478600001)(356005)(316002)(82740400003)(5660300002)(41300700001)(81166007)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:27:40.4723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e18b35-c55b-49af-36b3-08db4733f066
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5434
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reduces preemption latency.

v2: move MES MQDs into VRAM as well (YuBiao)
v3: enable on gfx10, 11 only (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 0560568b3925..92c5f0ce8bbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -382,6 +382,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 	int r, i;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *ring = &kiq->ring;
+	u32 domain_vram = adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 0, 0) ?
+		AMDGPU_GEM_DOMAIN_VRAM : 0;
 
 	/* create MQD for KIQ */
 	if (!adev->enable_mes_kiq && !ring->mqd_obj) {
@@ -413,6 +415,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 			ring = &adev->gfx.gfx_ring[i];
 			if (!ring->mqd_obj) {
 				r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+							    domain_vram |
 							    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
 							    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 				if (r) {
@@ -434,6 +437,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		ring = &adev->gfx.compute_ring[i + xcc_id * adev->gfx.num_compute_rings];
 		if (!ring->mqd_obj) {
 			r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+						    domain_vram |
 						    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
 						    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 			if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 0599f8a6813e..4560476c7c31 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -901,6 +901,7 @@ static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev,
 		return 0;
 
 	r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_VRAM |
 				    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
 				    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index e853bcb892fc..3adb450eec07 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -999,6 +999,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
 		return 0;
 
 	r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_VRAM |
 				    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
 				    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 	if (r) {
-- 
2.40.0

