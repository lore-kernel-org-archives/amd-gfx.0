Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE0DC7113B
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB46010E5EB;
	Thu, 24 Aug 2023 21:59:14 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1139010E5E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUhHhCUiYfqxj8qnhqDr9dih7Lc4zFNNxEFPCcdNewJS0+0boqO1uU34JCkMnl0O3ZlhUqpxWh5bjwbc2ndz9xMdUN7k2mCT/nDbp2KVtf0QY0hQaiFnP3kFJjMIpYWPb1yT4muUBRlRdieMwz9NCveqg2kdSh7weoC5hyK69CVuFolIUrYz4PWtT7uYfzNzt+nkhDCexxq1bmKc4G/OW3f4QRHoaFhUPZP6He6P8M3vXupD5p437ApFWdWuU8o+w6mAO4W8VzN9G9sl2nfRsJnQUhVC9U1ag9mywMQrc7S4yy5SqEAVowI25cd3rZyVT9EkR7XWjFKZuq7P4Cv7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srRZ02RomDICdcnjyG8s3eLFU3762APuk+BELVXgq6A=;
 b=FND+GfoKdRhcfOQQ8siu9ifDvhw5AMhh6tMTwYDN16IGy9ibaFTxAunswAQj3zRf3REwFxzAqcizWk+k9PapSjsmxilv6rPlsR6WhHQ/4rzx/P7/Z69ZucCImBYkDkLI7IXscLJdcJGBkgYx27U+9shK31JNYnLIMPvDVNpbqKNwk60akkNLqkSdgVof7wqDgU2m+ZgjtbWL2DA4qStRtyGIvk97S/3oqPQA/MT1FBIxs9J3HRuiyTKUBcovyXNG8lY7lxFD/76fMM5xXD/L/+cIzWlVm19z2l8Q5Zx0i+tG/H0PLvht6mZsrjR4PVJ9j7ss8bQXVx33nHv2iogqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srRZ02RomDICdcnjyG8s3eLFU3762APuk+BELVXgq6A=;
 b=rS4SLqQrzizKeUUaJvs0x0aSDqQDd8q6D6LSe44NUs7Ztal1sCGQRzvGjarFZedaM+6eChX2qj2+TCCvKng4tnEKiCwduplanv/0sQvhSAFzJFPLLLWz+4qjEhZP9tJhHtMHZmNA5UoHbLjXimbMHHxZcdqTSFfUFLehLYPt9hM=
Received: from DS0PR17CA0008.namprd17.prod.outlook.com (2603:10b6:8:191::15)
 by LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:58:55 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::2d) by DS0PR17CA0008.outlook.office365.com
 (2603:10b6:8:191::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:58:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:58:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:58:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/14] drm/amdgpu: reserve mmhub engine 3 for UMSCH FW
Date: Thu, 24 Aug 2023 17:58:31 -0400
Message-ID: <20230824215835.2740115-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824215835.2740115-1-alexander.deucher@amd.com>
References: <20230824215835.2740115-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: 83559564-a083-4ceb-df64-08dba4ed4fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f842jA5MY8a2Om8O/kcLyB3mhFsJBvl3/HnG8azMIKi27tqtp9DVd5F7PbtY7rOvxnMbUdZNrT8QvxHIDA8DIarJtkUnbIBp2fIYYDNFtok755DqgcAcDL6xpwNJ/8l7hUyaoqI8UrBEruAPxiGc2COlKQZ9sbGoo4v1WPWY8c8Vttp3gyyXphOMGXcBBmNvtZ3GlxOIaBoJ/VBLGpSpycBk9FMWAabPWtny26Zf+I/ztFUzsPdYful8bQeiBfasF+mOyDbBj1xn0EqAXttL1f9P5ALyXGXtwDMfvxcX+2mc2mJL0yEH+x2jVkv3aJsvy3JdQ6K/ev/VDPiYhgdT27Te171O/QfDianRFTrYUtl9XHh1CeH2ij6Cf8YeT2ETDmryB1gIsnVJFqFe+3V2dwqZpOHc6dDb1Cz0+p8fGoxlF2L0pA8LZ0x8ZKXfF4aR4vOQLAV2zA60pDWsa+cuzOmxDb9SD/jwbdoWduzyUWTniqT3z7FsMqB1lg5d1XZ7F24sxGlEbeTYme+SuG/HlaOnGmWsayJYPPe3OefiT1VzoJdzSs5xDM5ToLnnkEer7arpYaiP6kiXkxgF68ciSUuPbdd0JCycrTwHYop2vuN+YdxAwt+N613zUCi+FPrRw2OSK9SX8IBmjm6Y155y4w4cwAkbCZA9ECoUAnxCmfi7dkgv3ONX7t8RXzg4VDAIEOOPK0UFjHjJZkZOvgQhYjmYlwZ2Sk4YZ8Coo+v/Spn5okt8clUJ3Ysf2sJzDF10VXkC8UU1VBcI6wEZRetdfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199024)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(54906003)(70206006)(70586007)(316002)(6916009)(478600001)(26005)(36860700001)(356005)(6666004)(16526019)(40480700001)(82740400003)(81166007)(41300700001)(7696005)(86362001)(2906002)(8936002)(8676002)(4326008)(1076003)(40460700003)(2616005)(5660300002)(83380400001)(36756003)(336012)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:58:55.3618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83559564-a083-4ceb-df64-08dba4ed4fb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Veerabadhran
 Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

UMSCH FW uses mmhub engine 3 for invalidation.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Acked-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d78bd9732543..5f7641d9f346 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -549,13 +549,17 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 		/* reserve engine 5 for firmware */
 		if (adev->enable_mes)
 			vm_inv_engs[i] &= ~(1 << 5);
+		/* reserve mmhub engine 3 for firmware */
+		if (adev->enable_umsch_mm)
+			vm_inv_engs[i] &= ~(1 << 3);
 	}
 
 	for (i = 0; i < adev->num_rings; ++i) {
 		ring = adev->rings[i];
 		vmhub = ring->vm_hub;
 
-		if (ring == &adev->mes.ring)
+		if (ring == &adev->mes.ring ||
+		    ring == &adev->umsch_mm.ring)
 			continue;
 
 		inv_eng = ffs(vm_inv_engs[vmhub]);
-- 
2.41.0

