Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7A4C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 18:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2964F89C17;
	Mon, 14 Mar 2022 18:54:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578D389F85
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 18:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAq8qV9Y9jZsQipGcYSz7m6am/QY9pdPPlQ0dKbInnTKzcaGRaRw7DeCAzieqMKsCg/izdogN8mOwbrS0EnilSLNf/U4/455I8GVNOA6cfejMBLcRo1TPi1fOTu2Eg0aGCaZMAdizkQigfzc45Rf8bM/prWpUPu85NLR9p0JgJ/SbL/jMMnIkdxCOyJVgkYB/cOXhOA0uGSNCO1ClLAP/k3iCJcc6J6Jp7F1kAgprKa8T/Q7IBbjQ5YWonW4ipeopmTAaKkPHE+y33y3e4/+BUH6s27TtZCv5MzHMemfqnCacOANgjW10NmhSDnpnInARvFPwsKEc23OKvpUSAnqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAxYz55QJO9VK1t15MumiFHBS5jTNKo+PEyyExXVaAk=;
 b=oD8yKzShGK70Y/kypOPA0qOfXCPuU33vCl+wVJN+47IGJR9PYgE7TWGCjSGJNW2KHLCXz9z/BgAOsEP6IEHvCSrn5MmEyLWMCFLvB9IIwFANdPXgWZFFgBl5TPuJrcFVAHZsC7AxnAv46RsPp2LMq5zqu2O0VH79f0kgJTfv/L2tSKbHIweU8KafzPg9Ib+MwjuwqXoKusb7IH85m3V1X8XC2WuQ+nTlZLtPy4Q9YEPeh/wh7bn9UzqRHtFVyViC2xLkw8OfzXzgXLhIKATaRpavaQ9+3Ekdx3b0fAupcUFbAL8Ew1ZkxM3HAJSKXO0VHJmGHL2xoB4pEPhkmZBDNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAxYz55QJO9VK1t15MumiFHBS5jTNKo+PEyyExXVaAk=;
 b=k/nljua2QkfsMi14HOOf/AJ7HWxXS0DUhwgrCgm+80clTb+65UvMeFWL5pH7DL3st/mucggR5O6idfom77Eoy5zkB0E1NA7s6OUM7t6eD6J8zOuHNVnvTs1KbEte3uxpls5mECf/i6aMIMrju4xYzZP1e156ONnyzEQjRSSkgWk=
Received: from DS7PR03CA0157.namprd03.prod.outlook.com (2603:10b6:5:3b2::12)
 by BN6PR1201MB2531.namprd12.prod.outlook.com (2603:10b6:404:b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 14 Mar
 2022 18:54:22 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::b0) by DS7PR03CA0157.outlook.office365.com
 (2603:10b6:5:3b2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Mon, 14 Mar 2022 18:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 18:54:21 +0000
Received: from yonsun-linux-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 14 Mar
 2022 13:54:20 -0500
From: Yongqiang Sun <yongqiang.sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Use fw vram offset when allocating stolen vga
 memory.
Date: Mon, 14 Mar 2022 14:54:02 -0400
Message-ID: <20220314185403.137623-1-yongqiang.sun@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2af5603-fec0-4a4b-5d9f-08da05ec0cfb
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2531:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB25310B6744B50EE27E44E277F40F9@BN6PR1201MB2531.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R342Pe15Ok3Qm3auK+ydWMrWB9UdHoQiNixxqe8sSWYwW2gBBMN+kLO2S9DJANKQwhOsYciPfSPanOpg26RpTVlr5O99sj6O6DWqqX8/noM6cxkEBOYy/rOD1DCZhkvJoFEwtnQolFBomVBYRv+o0f4Lu++gNAvZ26JXOFkq98miGOLY8vw0pdAbEFJAQ7H5auyMRLV22/qvNDAl4fJCW0JkFT80SU1oNNPwMzeYEXIZVUYiFWsI7ViI9fPTnhqUSXOfNCmPPT8Yq3GWwq/3XKDyN+yZ28fLUVglGJJAleFyDBOv6Fp3mF1BWWsmdD6Cs23ijB9KvhEn7jFFwDjmer9EWaBGN5IUoaBqAvMHxskymHU/O01xonAqtLC9h1gZ1xi2dnCwMwsVA/FYmg9z2vkolBbf3OFRaH4Gtl1ZfCr/FYupvWLa4dOsqgKzf/laOCPJIBwd/WURt+BSamDrju2feb+6N+A7pYoAvxvb/oHNCMIdz0TJcPVoOY/RMnlSB6FTB2B1B/bi6ztjoq0H/ZhdVfawLWK6/TQYNRgalZilcCYBfxlZWhyJXA95jYxmGnfxyIeL2lMzVeWxcYTD5KAHJgCjD8S0za4I6tF5Pbx8WBYqACjRiscrzgK4Z6AaPYpSq6hLBOYrSzEuHh9/tyIOO2dTGhXWGwCsYvyJ6a2r6VmVjris3vFzy6KjGucR0IJegjrgGnJJK6z51sSLoI5lZxHGAUY7fcZNPOfeeoRQhEHt5WnElB8N7QnYyO/Xpq2NuWd20kfzZ/L7fguvNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(44832011)(40460700003)(1076003)(16526019)(6916009)(54906003)(2616005)(7696005)(6666004)(8936002)(26005)(426003)(336012)(186003)(81166007)(36860700001)(508600001)(316002)(2906002)(86362001)(5660300002)(36756003)(356005)(82310400004)(47076005)(4326008)(8676002)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 18:54:21.3473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2af5603-fec0-4a4b-5d9f-08da05ec0cfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2531
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
Cc: alexander.deucher@amd.com, nikola.veljkovic@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Memory access violation will happen in case of allocate stolen vga
memory with size isn't 0.

[How]
when allocating stolen vga memory, use fw vram offset as the start point
instead of hard code value 0.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Change-Id: I7c555a6c1fb4b3fa8685753b4bdcbe215f89ea1e
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 31 +++++++++++++++++++------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 41d6f604813d..1f635fdb0395 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1708,6 +1708,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	uint64_t gtt_size;
 	int r;
 	u64 vis_vram_limit;
+	u64 memory_offset = adev->mman.fw_vram_usage_start_offset + adev->mman.fw_vram_usage_size;
 
 	mutex_init(&adev->mman.gtt_window_lock);
 
@@ -1774,24 +1775,40 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 * This is used for VGA emulation and pre-OS scanout buffers to
 	 * avoid display artifacts while transitioning between pre-OS
 	 * and driver.  */
-	r = amdgpu_bo_create_kernel_at(adev, 0, adev->mman.stolen_vga_size,
+	r = amdgpu_bo_create_kernel_at(adev,
+					   memory_offset,
+			           adev->mman.stolen_vga_size,
 				       AMDGPU_GEM_DOMAIN_VRAM,
 				       &adev->mman.stolen_vga_memory,
 				       NULL);
 	if (r)
 		return r;
-	r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size,
+
+	memory_offset += adev->mman.stolen_vga_size;
+
+	r = amdgpu_bo_create_kernel_at(adev,
+					   memory_offset,
 				       adev->mman.stolen_extended_size,
 				       AMDGPU_GEM_DOMAIN_VRAM,
 				       &adev->mman.stolen_extended_memory,
 				       NULL);
 	if (r)
 		return r;
-	r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_reserved_offset,
-				       adev->mman.stolen_reserved_size,
-				       AMDGPU_GEM_DOMAIN_VRAM,
-				       &adev->mman.stolen_reserved_memory,
-				       NULL);
+
+	memory_offset += adev->mman.stolen_extended_size;
+
+	if (adev->mman.stolen_reserved_offset > memory_offset)
+		r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_reserved_offset,
+						   adev->mman.stolen_reserved_size,
+						   AMDGPU_GEM_DOMAIN_VRAM,
+						   &adev->mman.stolen_reserved_memory,
+						   NULL);
+	else if (adev->mman.stolen_reserved_offset + adev->mman.stolen_reserved_size > memory_offset)
+		r = amdgpu_bo_create_kernel_at(adev, memory_offset,
+						adev->mman.stolen_reserved_offset + adev->mman.stolen_reserved_size - memory_offset,
+						   AMDGPU_GEM_DOMAIN_VRAM,
+						   &adev->mman.stolen_reserved_memory,
+						   NULL);
 	if (r)
 		return r;
 
-- 
2.25.1

