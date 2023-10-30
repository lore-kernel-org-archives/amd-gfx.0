Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC65C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 12:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6721810E2A2;
	Mon, 30 Oct 2023 12:22:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BE6F10E2A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 12:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJ7CNA2tOhLBBXFTQsQXlm4Lcz0qaRqUAaqyOPwluOHHt6mdebR6KX4iSzA6MmwIruZavAhk2FtbthxIXbokz9QNePmTLqf0jMxshQTwvZVoNNVa4mFpkJ/hitEUNlLqCzaH+ujEmJzREj7GuHqxEiUnVSc53zW4G15XjBXwFt3r4hTOa3Jbeja+EWUVdg5bojmOLENU1fnQwHhX8VqeaC6PPAkjg4DqkWocw0shuwTL5OmFrakad2eUpT7aGplHZHTQWgPdMXTBd5yBSOj21jwplRJFIKEU1xiS/MHEERjw44r4iMYsufDvXzcKi1Aq2cU5MbPdQh+jRMZC3cRrig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUyImgLoktByRUf29p7vyz587tgiAOEV/dh0JabzXus=;
 b=EK2kqyq9++gDiSYPhrhgZWTVUgANHQToiiNbgntrT4K7r+d++9M1ZpsKGFDguWAJINqOOVqNAIEBy10z2i6dxvrWPtKu67cZLafkau5BGFye03QdY8IvyK5bCsHzNmwgV9X29Q8G//fvimlCq6EZ/obi9nsBfVJGzMhd2GK+1bUtOQ9+N0uf6MB+tjSou4Mugj9q/jTcbDmP1sRbYWSbfz8dsX18Y+Hcu535+2LM9OEcwS4IM5OiMzoMshFq48rX8KzoCrpO8K0C+iLckJ58TyRAgA91WAN8VsF0PVr+GxMsanFpW38MdTV4vqRtJ6LWyeUYLLUq+4e5shEwE8QMyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUyImgLoktByRUf29p7vyz587tgiAOEV/dh0JabzXus=;
 b=MMOgBw8Yve8EsXu/RL7Z75zgZ898eLxfN+yN2OHMM67Zi9x1qTbW5QFO6gEaYtwPXDpn/VV0rvcZh8flzx8g/OZkRPzgYctKa0HkJNy3ab386Od/1tVYPOoawQLb7KXPLPrqJSyfTbmfOCk+H58qkCUt35v/PR9DwdYC661hl8g=
Received: from MN2PR15CA0020.namprd15.prod.outlook.com (2603:10b6:208:1b4::33)
 by MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 12:22:24 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:1b4:cafe::49) by MN2PR15CA0020.outlook.office365.com
 (2603:10b6:208:1b4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27 via Frontend
 Transport; Mon, 30 Oct 2023 12:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 30 Oct 2023 12:22:24 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 30 Oct 2023 07:22:21 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix the vram base start address
Date: Mon, 30 Oct 2023 05:22:05 -0700
Message-ID: <20231030122205.24805-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|MW6PR12MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e443a07-f8a8-4758-aa15-08dbd942df69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7bngntZDGUvWqcZWM6NQD/5rQRBWyFf5Jz+HoiDAEGXDg+DIrCOfvtyvQVfojQiE1FFT7IDN+ZO6lLvMoGyJEBZRV5hk33qDYAKh/isAUkznv4AHYmwrFjKqiEhn9x2EEodnvLoYN3F1bTBlaY9Go2RMGGdaq5/6XL/2P0lpu4NoXwFBTjE2GeTl3ndXEWK6fXCFodYYaMqpFPq2/fP8nlk9nvjMRfpp2DoKDdOusEKEaAf8lpWwuTM+54zhzPSzcLdrxcjC0MhjVF3c3kxYUgJXyMfBJ2RPmzQHl+m1D6eY69PXtNIrXrMRfYiNiNZ9MhOWzap+RJgtOsqyBsUSZTGxC4yHVjQ6SVSBNpzC07S9603N/iBlYAl9yiUA6sMDX4NxMAZQqAmM3uLMEcVbjMVQEc/WvQ01kFikKvium3mrb1eG4EtsAPzqNB7vO50KFRH+UFCha3y6TphwjTmKbSCr7pe13DlNnFx/ndS2FJpvLpBOnU8NkR9vTCpXjMOHHzaeg04q7U4hE9xG7/No6mkwV3M3wcGLQvI85vhDG/sKchEx8OSHMpyv7qGIuE6gk06lKMyz2ANfFNsHS0KHsNl7fsnYNH/39H7Tsd5ZdoPiJLgsk403+PKwXexllRME41AwTuu/YdnroWAAOtvHViTIwIjgdG8HVwbbRaRfpbX6v7VdbBnxT3aN6zdp55bDJyfu1ytYa6WfT0NS4dnDLcK8/IaYltA3uVbu9kmHVMtdrmlzRUz7CeKUPYiiZ2mtvaf3cWdZ66Y5AtI2JTD3Tyi35zla9+wE4NBOaR2wZiA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(40380700020)(82310400011)(186009)(46966006)(36840700001)(40470700004)(40460700003)(83380400001)(16526019)(2616005)(26005)(47076005)(1076003)(356005)(81166007)(36860700001)(336012)(70206006)(316002)(6916009)(70586007)(426003)(54906003)(5660300002)(4326008)(8936002)(8676002)(6666004)(7696005)(2906002)(966005)(478600001)(41300700001)(82740400003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 12:22:24.1901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e443a07-f8a8-4758-aa15-08dbd942df69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arunpravin
 Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the size returned by drm buddy allocator is higher than
the required size, we take the higher size to calculate
the buffer start address. This is required if we couldn't
trim the buffer to the requested size. This will fix the
display corruption issue on APU's which has limited VRAM
size.

gitlab issue link: https://gitlab.freedesktop.org/drm/amd/-/issues/2859
JIRA ticket link: https://ontrack-internal.amd.com/browse/SWDEV-425461

Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 18f58efc9dc7..08916538a615 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -77,7 +77,16 @@ static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct list_head *head)
 	return true;
 }
 
+static inline u64 amdgpu_vram_mgr_blocks_size(struct list_head *head)
+{
+	struct drm_buddy_block *block;
+	u64 size = 0;
 
+	list_for_each_entry(block, head, link)
+		size += amdgpu_vram_mgr_block_size(block);
+
+	return size;
+}
 
 /**
  * DOC: mem_info_vram_total
@@ -516,6 +525,8 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	mutex_unlock(&mgr->lock);
 
 	vres->base.start = 0;
+	size = max_t(u64, amdgpu_vram_mgr_blocks_size(&vres->blocks),
+		     vres->base.size);
 	list_for_each_entry(block, &vres->blocks, link) {
 		unsigned long start;
 
@@ -523,8 +534,8 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 			amdgpu_vram_mgr_block_size(block);
 		start >>= PAGE_SHIFT;
 
-		if (start > PFN_UP(vres->base.size))
-			start -= PFN_UP(vres->base.size);
+		if (start > PFN_UP(size))
+			start -= PFN_UP(size);
 		else
 			start = 0;
 		vres->base.start = max(vres->base.start, start);
-- 
2.25.1

