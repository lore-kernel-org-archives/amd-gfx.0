Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4742EC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 11:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 462CC1121AB;
	Tue, 26 Jul 2022 11:15:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F47714A9ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 11:15:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdsSJEd90bSQNrWnHV4QoMjBXNBcE4D5rJhRzpyUDt1+gpg1vZS+nlDvgX19aznmBSUaJE6U2BPnF/Oknpy25rOV/LFftiCL3HP6kMiiMVNdK/dpJ0ImEmac6wUbXteoRpL/BgbTlf3D4JaKZx/yJS30fZrB6eGGfLd2DogRHFETtclfcXA9A/+uuJAqi4XRagwZUx7bUcBPBo1TbUk5jEUeVjHagzAvRy0bZYQAWqDIKcS6PLIgoSDsPlx2MF1VbZarwjUVlq/mxJMxEODuzg+sY6r5MQKHvMbkrneEuLDmdUsupHf2K4mc24NsfQsDYlAFq8oRVj1yM/jRdHDDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLFOhwWg08WdXS3d7oL4M4b/evRbin0C8Za2kTJ0+Oo=;
 b=mw+Hg1JbE7hmGVm7gWFM2xpWZEazeAKphQpgJ8soKlgGSvYY9F2zDNDuXcTQ9h+GggewXz1BNUpULiSXLSyc4mt0rShBOV4UhJk71B2MZ3UeHt5OPRpMp7IH5ej/RYwP0RZS33ztCZuDUGnMg/tz/4s9sQQ5vzt/kyiM9p5SBxF4ZEoPLWNm/H7AJ02SuCtXoHetJBw4ECKxmKvZcvDjmNjlW0gWkKEobanjldwWF1gMcgaf6lc4A57YEF87olPxLY4TMGH/lzhP0tN0ZUjS50rdU2qs/AyjNJ4AzE8++Y74CawupiSS6fMzOAwU2vqHfUqCEHirx5+iFTwphsDkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLFOhwWg08WdXS3d7oL4M4b/evRbin0C8Za2kTJ0+Oo=;
 b=i9RkYa8Wy/rhs9RYUJ8Hmw/LAAGSyJN2NgF4SGH1aoHB6rob6Clg7njZOWVwXgAQEC66wKn2RUTTRCE6K2EqRYGKaSoVwaX1qOgdizMA4mq1iRYj09Q8C5gux47SpszAmPtanCS9bht4AA2ej6SuYBalNsH4IO4IjoCLbAgLmRw=
Received: from DM5PR08CA0031.namprd08.prod.outlook.com (2603:10b6:4:60::20) by
 BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23; Tue, 26 Jul
 2022 11:15:32 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::fb) by DM5PR08CA0031.outlook.office365.com
 (2603:10b6:4:60::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.22 via Frontend
 Transport; Tue, 26 Jul 2022 11:15:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Tue, 26 Jul 2022 11:15:31 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 26 Jul
 2022 06:15:26 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix kgd_mem memory leak when importing dmabuf
Date: Tue, 26 Jul 2022 19:15:13 +0800
Message-ID: <20220726111513.2215655-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 931384cc-cddb-41a2-2c32-08da6ef8278c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5924:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5hJ411zSVG6ciuKl0S6HR8TE6wU9/Lq+fZkF/cLlSsrf5/x05CEQrhrrP2sG1E8IRazc/ZPffeGAvoWmt3eqGUCl4cvF2JCypG1vbOHwYaAqBw/h9xU8QFF93D2T+ZZAinVVmk1oITWR8iq8OKErJMp6auBUI6VmQ6SnK0PO87IvnfkMuszHJ4YV2WS6fE6u1JLSoaC6BzeeN19cR7JWUYn1fyqHyHQkMFCdNqq7r8OtpVwBVUv7Utje5U4Qs/uh00mbnwSz5XvcAsHsbhgFme5enia3FZyvhiGKZBCJ970FaM2WH2AMnBgOO0n9kDASrSxKsYsQGgf9CT9NHEna20gcYmKZJfoSs42Sr6IKPNxQEfk1cCBrwsC09dC7/j7w3XrFRu2sOfnRRZ9t+VzC7rbvpsjzInYJHCoAfb0gvQjVLE4WC3yLJe0rt+NViuRg922io/S22zGSsChMZW8UpHPumKsCC9amXVOpC6rjDVKg/o/U3vO9BbIjeSG8sqxO+syNuSTs+SDGE8kRXEUsLDyxutPpFF7Q8KmlDW5LKV/TG4Wr8aUBQa67suN8+uEqlCDJdYgwiYQki/yqh1CM+boJh2NdYcRakimbwFipdIqlUBZozk/rPjXFrZg00XR1obezve9hhB0xvTVUk7SIQ064A5nXD54s1xG4EIufnQRcuRRnADyqfc/m4nqj5Bo46Tzg2iJnlTYI21CAZ8IdIyJptB2LNwvFIQpD2Wb2jZM4ErKJ1U5qvAh2t4IOgeMLLoXjv/ZLvfDo0vow2fgjseQklj/XDWwKFukUfrw5Sw9/Suz/GVtGXyuD3WBOAJ3T+fRhJGeFosh4LiR3MA5Jbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966006)(36840700001)(40470700004)(86362001)(36860700001)(36756003)(356005)(47076005)(70206006)(1076003)(426003)(186003)(8936002)(16526019)(336012)(81166007)(82740400003)(26005)(7696005)(478600001)(82310400005)(316002)(54906003)(6916009)(6666004)(40480700001)(5660300002)(4326008)(8676002)(2616005)(70586007)(2906002)(41300700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 11:15:31.9539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 931384cc-cddb-41a2-2c32-08da6ef8278c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The kgd_mem memory allocated in amdgpu_amdkfd_gpuvm_import_dmabuf()
is not freed properly.

Explicitly free it in amdgpu_amdkfd_gpuvm_free_memory_of_gpu()
under condition "mem->bo->kfd_bo != mem".

Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 6bba6961eee7..086bed40cf34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1803,6 +1803,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 		uint64_t *size)
 {
 	struct amdkfd_process_info *process_info = mem->process_info;
+	struct kgd_mem *tmp_mem = mem->bo->kfd_bo;
 	unsigned long bo_size = mem->bo->tbo.base.size;
 	struct kfd_mem_attachment *entry, *tmp;
 	struct bo_vm_reservation_context ctx;
@@ -1895,6 +1896,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	 */
 	drm_gem_object_put(&mem->bo->tbo.base);
 
+	/*
+	 * For kgd_mem allocated in amdgpu_amdkfd_gpuvm_import_dmabuf(),
+	 * explicitly free it here.
+	 */
+	if (mem != tmp_mem)
+		kfree(mem);
+
 	return ret;
 }
 
-- 
2.25.1

