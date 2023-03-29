Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11901C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:14:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A97C10EC32;
	Wed, 29 Mar 2023 20:14:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64FEB10EC32
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:14:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCuf6pd1cNEAE+LQttTmkwi5010taEpLVxjAkzCKRHQ/T7JcfmQWlohsprVScC00bgSVwEv8otFRscxLCvqdX9tbFnsl1Y0A+GgyEkmJLuFJ31vZgEoFb5R4pumXioT8Fun0y4maYLlmUPVJvzvYsheHB+yNnVkEUGjtAfOM/5euA7QqiBMcZD7KbDl64FN1cOk3cFTVqEvMcNM2piI/gn8R2/IjqPxKdWhCoEwIf+HCYDzl5Fu0f+wkZx61UbxH5gfRFTfYwXzVW58YmRivgR5PyNjO97v2oHTQwPuUFsmjkDS25yL87vT/Tdlyi0xHwod57kHJ8/1xI9BiWugPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VknztsVwaBgP8iOeHDmkcHa63w6ecUnmF1D1fYroGYo=;
 b=ObQkkCxupjveYe+nmkIxGTms8EiVvqsZOja60pBPmS/o3kbc6+U422sCrVH1uGRwawCtPAusTjRUdXG/LxyE4fYx1yc1TKhRtQx+8CweCDjVDzhoqebQ9lPEmoq8dKY8fE+1D9wcSQ6DrDOsALhNJk+Yw8qHnra8sDjnWIJfvdz0jTAq7cW1WeBl9n0n1PA04Jf7dJu4Lzorde2jsrpdnUqZVmXcO3ZnPfry24qcZxEvUInNab36PO8XVNA5e3sU0MWY1smCcPJd+1RV/hXlxJ0LA2mdnpupEFm45GCMRCznUB+i63w8vM9mjCx3aIplmuDuotw4fUzpn9cRacVDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VknztsVwaBgP8iOeHDmkcHa63w6ecUnmF1D1fYroGYo=;
 b=hShfCfZjyVvvkMSmZEXfJZFK9Zio8LXCjFiiMIOj06tgGkgDDUpQBvTCsjOFknr/P1jHNzQHYi4ZemoTy/jk/bRU2Z9PVK6FSSIQBUE9iOzmgV+w5wN6DFv8lnSYm6txWjwaf0rMK1ipLnk+3OCQ1KFSPD1UhqJa7bD9UTBG8ds=
Received: from MW4PR02CA0028.namprd02.prod.outlook.com (2603:10b6:303:16d::7)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:14:44 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::6) by MW4PR02CA0028.outlook.office365.com
 (2603:10b6:303:16d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Wed, 29 Mar 2023 20:14:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:14:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/14] drm/amdgpu: Conform to SET_UCONFIG_REG spec
Date: Wed, 29 Mar 2023 16:14:13 -0400
Message-ID: <20230329201426.1982669-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b658148-6d2d-4cce-f498-08db30923c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9SJY5dy3sz4PIp08lRpY22nYtkrsKL8qYcN3ZB6kR06cgFX+lmJgciy8gKUuy7cJyqNtfrZZqRMckiSnk7yBWzBizYl5+91WQCkLUqpnkxbE9hwgN5Ody63RuF65JzZT/HP5JjTohrx0HQDKBmK1KgZZZr1qZWEE+DQBTUUt8+y2DF+C+9etm+eDzjWZ+FZjYqqlksd/a2yrHMaNA8AlmElHleO8Jj/HCh0P/H+PwqhVsHwrUVBmp1BVIk37IOPNW9AVVgsk/UVRhWotY36hTyAVz+BE5/ZwPbtvG6Gm/vgUbCp01uOt8MDcD9BbLY2DAhVKT2zdXyHUB71FdxPcdy35ecSkmniRH11OgGlWnAz/05fh82muljqD1leskJ8I42PsbpiNrPGsLI6gqojJxEyxe0uZBUN0tMhTog6DIHtULgLagBXC90bWXPIzVL/AAMGzcU37DjtqxWmKWai7L2VeeqBtI8DkkVbQJzBFxXvA9DcoVeiT7dn5SBPj8OLZmlK6oz88C1QUjgXxOAWPzjRVShDx8ZjmigrYSfsG6K4XnWpmRoxQRfd9C/nb5RY99WnRXBvtKIfKMvVdDfm1JyIW5x5LWkG+34fWQidKGaMxaYuoTwERCdm8PxPDIsQ3qxJ+A4dZnAVWUxMJsyXbv7kJz0HHDA74fuf+8uEGzJof71V5/kMJ29nAMJmKY4r2bIJU/I0rcOlotUdXpop8LFIObw91lRy46YYySnLHaw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(7696005)(4326008)(70586007)(8676002)(6916009)(70206006)(41300700001)(356005)(81166007)(36756003)(2906002)(36860700001)(5660300002)(86362001)(8936002)(478600001)(40480700001)(82310400005)(82740400003)(316002)(1076003)(26005)(6666004)(16526019)(54906003)(186003)(2616005)(83380400001)(47076005)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:14:44.1928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b658148-6d2d-4cce-f498-08db30923c9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

The packet expects only 16 bits register offset. Hence pass register
offset which is local to each XCC.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 451a7e58375e..2766e6ab5b1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -237,13 +237,14 @@ static void gfx_v9_4_3_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 
 static int gfx_v9_4_3_ring_test_ring(struct amdgpu_ring *ring)
 {
+	uint32_t scratch_reg0_offset, xcc_offset;
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t tmp = 0;
 	unsigned i;
 	int r;
-	/* scratch_reg0_offset is 32bit even with full XCD config */
-	uint32_t scratch_reg0_offset;
 
+	/* Use register offset which is local to XCC in the packet */
+	xcc_offset = SOC15_REG_OFFSET(GC, 0, regSCRATCH_REG0);
 	scratch_reg0_offset = SOC15_REG_OFFSET(GC, GET_INST(GC, ring->xcc_id), regSCRATCH_REG0);
 	WREG32(scratch_reg0_offset, 0xCAFEDEAD);
 
@@ -252,7 +253,7 @@ static int gfx_v9_4_3_ring_test_ring(struct amdgpu_ring *ring)
 		return r;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
-	amdgpu_ring_write(ring, scratch_reg0_offset - PACKET3_SET_UCONFIG_REG_START);
+	amdgpu_ring_write(ring, xcc_offset - PACKET3_SET_UCONFIG_REG_START);
 	amdgpu_ring_write(ring, 0xDEADBEEF);
 	amdgpu_ring_commit(ring);
 
-- 
2.39.2

