Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00818C54EE9
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 13:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 335A810EB10;
	Thu, 22 Sep 2022 13:19:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1232C10EB10
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 13:19:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVayTxgpznAJ/MZPlEx2jlb/UF3Ig6mbawe+b3nnXbMXv3zdAtrDP9iwuAoiRrgikv/CVu/kiIVVKf4vSIIWPGD1kWpsJOhJZzKUbAkEjMkb25niSnv2f96FR5VpiTYjJZWvYqdXGYVZfXHHOv+445hg6iT9cxc/cBtltGEU20cCFyDVJRm+88m6xcIWdM50kPLBT42OKKhnGzlBKc6aKapCrvdLdePo7x7IdN/amL0FJ2U2sCNJNNUi2g6qlsHBJOvX+oJKqPEkAYKUfty+nCtoOd1TCiPV39jiNuiAbSSn3RbhQlCFehZIBS6aaeYF2LKJRi1nOUuNi1BZbIkoow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4+3kUbhWUtsA7FYakJ/DZCnRxFycpMEkU0BpjdvZqM=;
 b=XbGiGzVbL8GFqIqrRQTDzESrce7T15CPi8rCxe3K0fphkH/TP5TZM2T+uHZyF2z1xZfihI2aGs1lHYjplJ+973pS5O8QZzrxbRkM0bvwL+La5YRTl0ir3TpGesbDJjMuXNl2diuI417pOCPahGncpZEp5nHMoeTjAR9DPLPPTAUWJ2l0j5f54qOmn9UCubFlZiLz4l60cJl58gfOLyaWpXvW/S27ovWxYF93yb3nYqPM8h3GMMivACCFK9M/t922hcfd5Sz8j+gscXsArv2IYA6uGiiBzADQX8NxcDKcQbvKGTb0wNF5hqQsGWzo/oXGQ/RFLOL9kmFTpPxYcarpXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4+3kUbhWUtsA7FYakJ/DZCnRxFycpMEkU0BpjdvZqM=;
 b=cDBijo1bQpKsMaWy7UGfo7HlJfpcNkgRsCaZ3jBM5EtfShh6MhqlguKTXRAuTcGQEnOuggU73MfD5CniP1UpDHae7UJgIZkY/BwRI47iwk1saW3uMr+GZUbnd95sMuZoHtuMM/nZNXqzfSnS9wm06DfA0fwyPg2MEeT/oZvhkG0=
Received: from MW4PR04CA0221.namprd04.prod.outlook.com (2603:10b6:303:87::16)
 by PH7PR12MB7162.namprd12.prod.outlook.com (2603:10b6:510:201::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 13:19:34 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::cd) by MW4PR04CA0221.outlook.office365.com
 (2603:10b6:303:87::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18 via Frontend
 Transport; Thu, 22 Sep 2022 13:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 13:19:34 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 22 Sep 2022 08:19:29 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix VRAM BO swap issue
Date: Thu, 22 Sep 2022 06:18:59 -0700
Message-ID: <20220922131859.131544-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|PH7PR12MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba724c8-e482-4913-f161-08da9c9d1764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fA7+zuQUd46OWzHJ3N7Uk0C+/pQRRBLKjeIS0nJWeu1hVfL+71mrwTR0pGYM0RmFbQI8ZE/3MIpvKUmiBlvxGR1XZjbbfvpat7KXyyiIJ6qUQBi9zJLtIgbIBXj3X0yIC8Yu95sFk0QdvKPUO1eKRedRfaLR7E6B8kPlRfmIiPOJC2AIR80UzjNny1/7pB2a0auAvGkZfGxU+g9aG0dZq7Vo48D/9b/xWnTU1/QHNK67RKy2mJvPljI/08THg6BVmzF/wex8KH/BpnQCTR4ceqonwhvm6bAJAUrDgtvxRibHIeAm1amImZue3ZP1JTMB6KWesMGvodKX4rwCrjfm4XMtczDMMbrLF+UHR/1kYm821keLMBt/FAC5DWaJR3HWQrzgSkvG+UO/CQ2I3mC5yChilDdZ4N6gxmT+/uw4feVLyP6ykvYeDm+lGPh7JtDSRdatdhkeMyyMjSNdd3sZNt9BugZQ6Xk6r2BXUusEmp5i9t7q3gCKGr82mPibN8/fjSQiOeB8/pJAYHfhWA6rjc3jBpT368V2XOtwxFbaeKHo6VHJGxF+opilcUNv9iJLii2l48GHr3g3FSxAE4iMBwVWP3ZqMp/Yjv9rtd8jVZrElYNIaS/6cDWnv1J0pHaYqgW/ndwtFeRiIb/mDPdEQKAug55Q+h5szbors5l4JjI+8ofpEyxZ6Vb8HQsyJ+vDd6OvgPuJWb/bVj0H5vEfnaxNRnHoKI8ROqypUtP5gdN6W6yOh5Td48R3jGKQekprelJVN7v4QwHRorXWIXe5cSIMdnSTDgjEfArOtUhfFUyWzvsKTqQTXNO9ACbBDJvP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(70586007)(8676002)(6666004)(4326008)(70206006)(316002)(8936002)(478600001)(26005)(5660300002)(40460700003)(41300700001)(36756003)(2906002)(7696005)(356005)(36860700001)(82740400003)(81166007)(82310400005)(40480700001)(186003)(47076005)(426003)(2616005)(16526019)(336012)(86362001)(1076003)(83380400001)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 13:19:34.0917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba724c8-e482-4913-f161-08da9c9d1764
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7162
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
Cc: alexander.deucher@amd.com, Jun.Ma2@amd.com, christian.koenig@amd.com,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DRM buddy manager allocates the contiguous memory requests in
a single block or multiple blocks. So for the ttm move operation
(incase of low vram memory) we should consider all the blocks to
compute the total memory size which compared with the struct
ttm_resource num_pages in order to verify that the blocks are
contiguous for the eviction process.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index b1c455329023..b1223c8e30c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -426,6 +426,7 @@ static bool amdgpu_mem_visible(struct amdgpu_device *adev,
 {
 	uint64_t mem_size = (u64)mem->num_pages << PAGE_SHIFT;
 	struct amdgpu_res_cursor cursor;
+	u64 start, size, total_size = 0;
 
 	if (mem->mem_type == TTM_PL_SYSTEM ||
 	    mem->mem_type == TTM_PL_TT)
@@ -435,8 +436,23 @@ static bool amdgpu_mem_visible(struct amdgpu_device *adev,
 
 	amdgpu_res_first(mem, 0, mem_size, &cursor);
 
-	/* ttm_resource_ioremap only supports contiguous memory */
-	if (cursor.size != mem_size)
+	do {
+		start = cursor.start;
+		size = cursor.size;
+
+		total_size += size;
+
+		amdgpu_res_next(&cursor, cursor.size);
+
+		if (!cursor.remaining)
+			break;
+
+		/* ttm_resource_ioremap only supports contiguous memory */
+		if (start + size != cursor.start)
+			return false;
+	} while (1);
+
+	if (total_size != mem_size)
 		return false;
 
 	return cursor.start + cursor.size <= adev->gmc.visible_vram_size;
-- 
2.25.1

