Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA17C4321E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Dec 2022 21:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E7E410E17E;
	Thu,  1 Dec 2022 21:42:18 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E36EE10E17E
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Dec 2022 21:42:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIToQDXOZXuDpFrj52Wr8u0uXBm1pLQnrkbw0KpZVNFQvt62+ePupwDjRVd0spqWluK9fb3VKT04iXiExa+Og1R1qEkwpUdEFBGdNlIyqtVHpGsWBgLsELFEtT549Drn1CxFKe3onUyqkXZms5ZGOfA8TxlmmKnoHpGivm1aPHlfXCugJdomckFwh7SSdAUYa4W4Rz+9jR+8vwae4EIS46XLcUeCKXX3zWRTzvMQv+HzRaaDYVOmargSIhin/2vEWIo0KB/3EFeXXXul5lVkkakHxtjU/fSCwVwyuGxP/gwkqQ0Voa3TRDinP9EMy+vU78gQBDAJHdsEAbDI6Z7Wmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enA6ClLqCbKtT5foAP2fxFqUCNyENB432HGpOGDubbw=;
 b=my4P4FzXeZnvEWYlAl/6eQgMhTDsK5/00qEOBgrbcxXp1IXS98NfYMn4833zjLau1wp3Vg5HH1U4DpXLZFG0AHytBHjx7yhXRQJPa7yLjFMGmGNkVjx2QVPcLc7EccmKZVnvuQuRi59hHxmuD+vWj9ApIyE8Y9Uk27DMWQPfCbZkB8Ssh0oMOm31j36+xHokq2bWyszPVeGQI3+DPKydJkZvUpDC9Ul+2BRJTwJgknlwni9JbPLP24ipZzJNMECqgE2QP8XKd2YybF1AAAtx1G6hm0WSd73KFQ+jrXws+LK3bqx7Fgrv9KQ2cVYdcRpriv+Ss5KoiL/BIFGMGlKUHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enA6ClLqCbKtT5foAP2fxFqUCNyENB432HGpOGDubbw=;
 b=uPmfIWIPOtLGpHSx3T4g7GyBOnGhrVNQLKWzV++ZoEInJPRorIugCEgKLjzSOYtqueV5ZeTbtyF0y94oTEZRqsb78Q62NoCBgnB7ByEy/60LMjUX/aRFWIvzLHtGyO7KjhMnllQlTvt8RJLwyg0rgsucSmQ1mRKTTooHoqoFvAc=
Received: from MWH0EPF00056D08.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:8) by MW4PR12MB6949.namprd12.prod.outlook.com
 (2603:10b6:303:208::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 21:42:11 +0000
Received: from CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::209) by MWH0EPF00056D08.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.3 via Frontend
 Transport; Thu, 1 Dec 2022 21:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT107.mail.protection.outlook.com (10.13.175.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Thu, 1 Dec 2022 21:42:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 15:42:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: expand on GPUVM documentation
Date: Thu, 1 Dec 2022 16:41:53 -0500
Message-ID: <20221201214153.8453-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201214153.8453-1-alexander.deucher@amd.com>
References: <20221201214153.8453-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT107:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: aca86571-dd03-4ad7-6aa1-08dad3e4e78e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Dbg26i65VQCogiEBNTpw/3XF+Guv+3YsTQ0x9GY8J2VxOjYbHfFPv/JCPHTz+rT8+LH78WJHmTc5EfE4Hl3DrPaMaICjmx2zCRYhanL/L/ZFv2H+vdHwpHBKwVL1yotfcjz3Hh2C5G1Uoc3/RLlR+qfPwRRDfGgd5yP7PcBdlxwgv2mWau4sjAyPkdouHwKwrYS0uABT4nfWe+21sWUrUUllo0u1v4Q6awgfyWhVW4oWVdliq4o1uG4AWHXIWWUkXRt2/BoXoYWchwFT0tAHmHD/k1Q3sFrGTBHVJNgaYU1sabI2aeyXOJaPi7WCufHrhMswZf2NBXGuUxCJVHYeMv309k5tfGKzv5Mchp+9+nZsYiQhiAc8gFbRsWSUk6l0ILoQv/+AMXvFBzwbO5ejhUfJTdPT9Df/XPKEUEOdX74Amj+mHzPuI23Q4z1+XvY2gMhZm0Zvcqbz+AMJNw4PX+NnJkxKOvHACHrW37lvIPZTp61iLfkWaQIOg/BGvtLdPiT6sIGEp7jw22kd2lE6041v+zk6bl8WEa1CDNDiOjCX9GudHBDMskzx8+yd8EpG9SiMBQ1CQQwhXM8fOqH0lkc5hL/Yvf/4RX4LtSkkcQhuDfALU52o0XHL4z1xBlp4FgdU+v+NlxKSQz1IZmY5wa7+8KnpMKLEzyTksUhIq5Cv50UMrfDOcwPS4S89RPHrwtWIqBeaCdNL5BcuNc6qlB2XNP2XUKZRGxlQEeavyI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(54906003)(1076003)(2616005)(16526019)(336012)(40460700003)(6916009)(316002)(40480700001)(36756003)(81166007)(356005)(86362001)(82740400003)(36860700001)(6666004)(83380400001)(82310400005)(7696005)(426003)(186003)(47076005)(2906002)(26005)(5660300002)(8936002)(41300700001)(478600001)(70206006)(4326008)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 21:42:11.5658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aca86571-dd03-4ad7-6aa1-08dad3e4e78e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949
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
Cc: Alex Deucher <alexander.deucher@amd.com>, luben.tuikov@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Expand the GPUVM documentation to better describe the
hardware functionality and use cases it serves.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 41 +++++++++++++++++++-------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 003aa9e47085..cb57a7bf5e2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -45,22 +45,43 @@
 /**
  * DOC: GPUVM
  *
- * GPUVM is similar to the legacy gart on older asics, however
- * rather than there being a single global gart table
- * for the entire GPU, there are multiple VM page tables active
- * at any given time.  The VM page tables can contain a mix
- * vram pages and system memory pages and system memory pages
+ * GPUVM is the MMU functionality provided on the GPU.
+ * GPUVM is similar to the legacy GART on older asics, however
+ * rather than there being a single global GART table
+ * for the entire GPU, there can be multiple GPUVM page tables active
+ * at any given time.  The GPUVM page tables can contain a mix
+ * VRAM pages and system pages (both memory and MMIO) and system pages
  * can be mapped as snooped (cached system pages) or unsnooped
  * (uncached system pages).
- * Each VM has an ID associated with it and there is a page table
- * associated with each VMID.  When executing a command buffer,
- * the kernel tells the ring what VMID to use for that command
+ *
+ * Each active GPUVM has an ID associated with it and there is a page table
+ * linked with each VMID.  When executing a command buffer,
+ * the kernel tells the engine what VMID to use for that command
  * buffer.  VMIDs are allocated dynamically as commands are submitted.
  * The userspace drivers maintain their own address space and the kernel
  * sets up their pages tables accordingly when they submit their
  * command buffers and a VMID is assigned.
- * Cayman/Trinity support up to 8 active VMs at any given time;
- * SI supports 16.
+ * The hardware supports up to 16 active GPUVMs at any given time.
+ *
+ * Each GPUVM is represented by a 1-2 or 1-5 level page table, depending
+ * on the ASIC family.  GPUVM supports RWX attibutes on each page as well
+ * as other features such as encryption and caching attributes.
+ *
+ * VMID 0 is special.  It is the GPUVM used for the kernel driver.  In
+ * addition to an aperture managed by a page table, VMID 0 also has
+ * several other apertures.  There is an aperture for direct access to VRAM
+ * and there is a legacy AGP aperture which just forwards accesses directly
+ * to the matching system physical addresses (or IOVAs when an IOMMU is
+ * present).  These apertures provide direct access to these memories without
+ * incurring the overhead of a page table.  VMID 0 is used by the kernel
+ * driver for tasks like memory management.
+ *
+ * GPU clients (i.e., engines on the GPU) use GPUVM VMIDs to access memory.
+ * For user applications, each application can have their own unqiue GPUVM
+ * address space.  The application manages the address space and the kernel
+ * driver manages the GPUVM page tables for each process.  If an GPU client
+ * accesses an invalid page, it will generate a GPU page fault, similar to
+ * accessing an invalid page on a CPU.
  */
 
 #define START(node) ((node)->start)
-- 
2.38.1

