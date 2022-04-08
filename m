Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D3DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 13:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0AC310F18F;
	Fri,  8 Apr 2022 13:21:49 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E44210F18C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 13:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gThVuupuiThANZiVwPVn+jUdn1ntXIjJIeKZwWRQO6Y+rg9tnnffDdLrsIyObvc/KqXitWI+NjniGxgropZN8etHzvOXj+V2XIcWVj1K/QEWT1Z22dR2rJEDd7ymoTZ6lZHqdD/OPrwlOPYUeGHE/SSQz1gGTQkP5qONxB72BGk2vKDpGMpDgwSEN4r1XjjJi51ikiQiTCCko+4vQjvBj5t7EdRVSgRlxajmEaDDwv5PD50N/cGjjy1shRM7DDQpz2wrbGc/SV4TGHoh3ckPn+4RwTjvbLN2iNT+4RqpjRX8Y5p5i60hJ1lKxfzr1EenNdMF2vs6N9JfO8OnwfAWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnCGNY65/E1YV/bJirPOCbonc9Kpb2S7UFmBdj//8Dc=;
 b=XvLvszBiY80+SrrTp53glc3ikTRg67EI3xMpKkFl0FJko0f9TkRgv2Kr8MwWPqBUeUq5V6Ol5TXUhgYubsHRyE2yDydCgpeVMF4gZw85ggpS3nGvHrcr52NGg/eatA12OW41muv5UF98OntUlQc7pEOXPCKFWCKbed5QCGenbK5zesMc3qbycoSvQupDW1BSguomcDf57C4DQrUc4z4MIwKHOltmAfRL1fUXyMK15vkNU0r8vqneteQl5yAceY6uDWUdfvG0DGuKb+LKWgMk/gVdhBthPgGJ1TONX3gTlITpVk8GfOUvPHc9bh3EY4nvAiNeadVi03ZctTFi14vy6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnCGNY65/E1YV/bJirPOCbonc9Kpb2S7UFmBdj//8Dc=;
 b=XhyenlgOzHmEpzrIWXc6vc5mmC4/FkICjaRku0L8TgmO/S3JExBvKR1BPTajkqotaykzVZrQpET8i5ENCjtjE6fle4G9Bo7ohPtL4iZylJfSbOtD7wQk9DmPddWKRyR27mViPrzVF+PqOqsl8Szam/H//DOiy+BoBXaWuBM5xMc=
Received: from BN0PR02CA0045.namprd02.prod.outlook.com (2603:10b6:408:e5::20)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.22; Fri, 8 Apr 2022 13:21:46 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::c9) by BN0PR02CA0045.outlook.office365.com
 (2603:10b6:408:e5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.25 via Frontend
 Transport; Fri, 8 Apr 2022 13:21:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 13:21:46 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 08:21:45 -0500
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Update debugfs GCA data
Date: Fri, 8 Apr 2022 09:21:33 -0400
Message-ID: <20220408132133.511808-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8cf6dbc-f9d1-49a0-c0e6-08da1962bb19
X-MS-TrafficTypeDiagnostic: DS7PR12MB5910:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5910489F658607BF7110053FF7E99@DS7PR12MB5910.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 75BlDlHbiH8SYG7drQl0zclhOPoV1yaRWahNj3rfH4NgBdWrkr0wtR6XLTXvM40dx8pNUxkZDZHdoYmXtmsmvUBooBAlwjoKiF6hZcF84vTdY+HSrErk06zhEEXRFqbFeyZo1EwlCakDX1Aj+R+Wim4W7IAx4Gtmhfb9C414UCKUOoOEHVicbgHpEuIrbf8wMVHfEkZZAGx/qTNjTWRZ5YCZmNftX7bbo4gZfZIYtnLu/stmBauBwI2U1C52wydID65IdkMU4ktIOB5yz1zt5LZ1pAK9/nG+C3VX+D2/o3cwD3aMaL5DDKJdF+Isg4EXNGS2mOQlv7u34pi+Hn/CnowhNH0UGrGkBxIM57wsOHqhZJIROplTPZNi1zwWkZggkQ7tS5TH2g9noTiyfq1m/3bbo0Rm1qSIsVlnQAB2O1v3dDICEEqbzfpcIqikKjTRTE4YTjsdFdnAd05rdJriI4KIr2cij6W+8dzKhqJdm3IwMyS6YtvR2VGL2C1NAEET7mjC9aQX63RWXfIKsFJ7W8ny5YYGDU6Oqu9fAN0rxNDCNG7RZ7AbIoiNah6NazQdpjP2KTr6AZiukFI/Zp+pjq3Q1y8Lrykc1bp57uyTiR5axKEa/zDsWYX0unrRbLr8LDeMQv4IegH3Wq0py3JTosKh0J4zbrzedn7+XgQk7tnYZpGFngXujJBquWakNHTBCo9Tx+T7tr6X411VYi4o3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8676002)(26005)(186003)(70586007)(70206006)(6916009)(2616005)(6666004)(356005)(86362001)(316002)(81166007)(36860700001)(83380400001)(4326008)(5660300002)(16526019)(1076003)(8936002)(40460700003)(36756003)(2906002)(426003)(82310400005)(336012)(47076005)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 13:21:46.2238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cf6dbc-f9d1-49a0-c0e6-08da1962bb19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The revision was not changed to 5 from 4.  Also since
this was missed I took the opportunity to add future
upper 64-bits of PG flags as well so we don't need to
bump it again when that comes.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 1db48dc58ae9..13e4d8f9b874 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -730,7 +730,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
 		return -ENOMEM;
 
 	/* version, increment each time something is added */
-	config[no_regs++] = 4;
+	config[no_regs++] = 5;
 	config[no_regs++] = adev->gfx.config.max_shader_engines;
 	config[no_regs++] = adev->gfx.config.max_tile_pipes;
 	config[no_regs++] = adev->gfx.config.max_cu_per_sh;
@@ -757,7 +757,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
 
 	/* rev==1 */
 	config[no_regs++] = adev->rev_id;
-	config[no_regs++] = adev->pg_flags;
+	config[no_regs++] = lower_32_bits(adev->pg_flags);
 	config[no_regs++] = lower_32_bits(adev->cg_flags);
 
 	/* rev==2 */
@@ -773,7 +773,8 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
 	/* rev==4 APU flag */
 	config[no_regs++] = adev->flags & AMD_IS_APU ? 1 : 0;
 
-	/* rev==5 CG flag upper 32bit */
+	/* rev==5 PG/CG flag upper 32bit */
+	config[no_regs++] = upper_32_bits(adev->pg_flags);
 	config[no_regs++] = upper_32_bits(adev->cg_flags);
 
 	while (size && (*pos < no_regs * 4)) {
-- 
2.32.0

