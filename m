Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759B4C48291
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Feb 2024 15:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7F9B10E800;
	Fri,  2 Feb 2024 15:36:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vcTn/+O9";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EF8910E800
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Feb 2024 15:36:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hk/wqY43+r3y7R8fYYGhLeSQVnwBkiZpitJQlygOw3Be3+wjG5CaypWSNAkfBFHrMnu1WFTHvMV4eCzCf+mbP8othyPqAsVSoIAtSAxDvBPmUQkTdufGlEKsxN0FBHJ+HddgFeGxHXpfxaomQ0Zrju4jjkT3AFPH/SYITmuS7UtXhl+/nY1rQ36ya6urWkt+GDAPrtEE7c+YPbzD1JyzgHgYPdPxrwtqpTsx9dGFyk+ZTZXnKI3ir1MkOv49+OT/hEHj+2RzlMQSQ4Vy6NOQ9WAorwHj54OLNl9WNkGxLPubi2Ko7vF1nszXRdVo6DHthEia/xX0UuJSyt3xw0vChw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozj5WS8Hfj2XMX4fcsb4GJzz2MCftpYMDso1WqF/KUY=;
 b=FfmeXDPry8S2S7lzlNw8E1yuYJq99Log1XTrbwa++RGkpZ09NSOVMx1g2aF6/JEzg1o1V2kFYdc32DmHlzgNobcKquVcK9sj87+/JXz6Z7/bKI54drvuwwMIUHsVdcXFA54mKibqJPgjJkdnyHJNUBZdYa26AIxNdOHE24d3rxmP8KWVyPQV6NXL0ZT9kn4g6MrVte/xu6cHxl9G+3tQVm4/i3Wz21JFCGCT2HbjkTEPpD1eIeWKeOmugggcvDdwkMMe9cq7Ybbd5WlbD6eJFBMB+czwfpkrmNxGtQM8lWMsY/qvegywUA7KE5fJylp4r/N99lWDKVqirE2t3LRsMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozj5WS8Hfj2XMX4fcsb4GJzz2MCftpYMDso1WqF/KUY=;
 b=vcTn/+O9skU0tie81ifO3XegW8PZN0DSHljaPIonYzb5N8owL+2DLwRuujxUvjAIVPfCRV31do9UgIpiHFwb6nxrwg0KHJyQTs7Ndq0O2KCQ+wLADAQXDN2jSWIMdNLX85MAW3IQxd+pqxSSmypw1dHYL6lw2a6IqgpQyYohii0=
Received: from DM6PR07CA0044.namprd07.prod.outlook.com (2603:10b6:5:74::21) by
 CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.13; Fri, 2 Feb 2024 15:36:06 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:74:cafe::45) by DM6PR07CA0044.outlook.office365.com
 (2603:10b6:5:74::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Fri, 2 Feb 2024 15:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 2 Feb 2024 15:36:06 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 2 Feb
 2024 09:36:04 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Avoid fetching VRAM vendor info
Date: Fri, 2 Feb 2024 21:05:47 +0530
Message-ID: <20240202153547.274367-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f44f340-d51b-4e13-9ccf-08dc2404ac31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QaUtFlqR8ORkTC3H2BQqMkCv3CIA+GWWVQ9MOLqUGU3B0lR8cSJKCaXpNiIHE+J1H2sZ6JhMGtvu1vWBnvAjDNB8IbkX54l75F6bVB+syodvD8r931UuRLa+Qm5U2WcnjPO6kizoKkOkg2wGkRkXNzdYqaCqmDrE1gVGPJbQb41ZHim8pTW7ZxJF6mFBcssVW9eKTak1BrLUJmUzlgZPbSMiGQgOCZvhmo8cAXYA5Q1uMfg5XVn6HDlUjuw1F97ZfTc4MDkt38qaPvXREiRldjp88GjtNZfE8eC/mDRMwsz1d59ylm0jX+70KaYLFHTveNZIylT3GhNp16n5vbW/+IGDkFYZgPmHWYcInGacRwlpD8LUCFSd3i6MnAnqggsBmLi6IGC/iiBs8z6qCjeheBrWrg80rbCcU3HrVu5Hb8PtXNuxE9QLE4Brh25gvk7qq90b75Ph1LR4Gn/kCknB2feJSr1KaZrQ5WiPwNOYKDFxr3A4lvG5j1mbgmIk39HrzLs/oOZgOwI3urqXQfEKKf5MVcp+EUfPSKGiX0rcHicf8Mgwg0RdgVznHR6puwOOAT1YTr26lH2k9rJar7bXs8ctRQ99IZwR5ONh2/5OBaOIVgpKdTbrAXoR0HdBpcTTkNDH9xNNDsm0v9TUZSPo57jQ691qpDQB3JqmNLQJMtgQytJBfVRpC9s56ZUMkU9gLsI4bq0sLbrwMXgV1WVVF0ZiWedqrCaRyKOnVZKairxhTfB0f7jhucbpElaKUk7vYijJPGz3wgKVhkTZRYJMqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(36840700001)(40470700004)(46966006)(41300700001)(44832011)(8936002)(4326008)(2906002)(4744005)(8676002)(86362001)(5660300002)(70206006)(70586007)(6916009)(54906003)(316002)(36756003)(47076005)(356005)(36860700001)(82740400003)(81166007)(7696005)(478600001)(6666004)(83380400001)(16526019)(1076003)(2616005)(426003)(336012)(26005)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:36:06.6388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f44f340-d51b-4e13-9ccf-08dc2404ac31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
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

The present way to fetch VRAM vendor information turns out to be not
reliable on GFX 9.4.3 dGPUs as well. Avoid using the data.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index a3a11538207b..c1161f465b37 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1949,14 +1949,6 @@ static int gmc_v9_0_init_mem_ranges(struct amdgpu_device *adev)
 
 static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
 {
-	static const u32 regBIF_BIOS_SCRATCH_4 = 0x50;
-	u32 vram_info;
-
-	/* Only for dGPU, vendor informaton is reliable */
-	if (!amdgpu_sriov_vf(adev) && !(adev->flags & AMD_IS_APU)) {
-		vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
-		adev->gmc.vram_vendor = vram_info & 0xF;
-	}
 	adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
 	adev->gmc.vram_width = 128 * 64;
 }
-- 
2.25.1

