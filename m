Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5A5C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Mar 2022 08:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD22710E27E;
	Mon, 21 Mar 2022 08:26:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB5CD10E27E
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Mar 2022 08:26:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lq/s6Wjy3SWOT25+zngiwlCj/AZ9exouC6iiLlY6uXJfVygWw7eSgoGnlwCRp4ve7Jkxrf2vJQXnBzbmdYdMRfr8hmf7sEQS5j55dhUOnj0UUKc+/AAtCZSo4ZN1/enJwso/bhnd08LrzhHVrVzKp8c7wmQmL3qG3OHyvEPjCdSxWVXSpTS8AeSe9+v/VIjqRAtEVet7rprEaOL0J5FL4hL3rzhOB4a1CjzNACugQsDvxvarIqPy9m+2jINdE4JPbgd8UnCrx/SQd/JPJkqjC2zRldEaD0194Gz+KDPx1gInR7mjKofWLlKiJtf0B8QZ2hVfUGcz8jSspmFyVb714Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYmaSNVlHxCBognkVf3MgU9vLx2LwwQhU4wh/6U0XT0=;
 b=dhof0gwuVI2adtAz9G5zlX4lBXf2RReErUH/r4Mb343mg9HyhiI/3OgWwYpUVpMIsdHT0Qt0rirVSYM/boQ7Kr04ksCtzDLhndvbO05ZbdT71FoO72JqECQ2ktvznsmMjqfHYjSYo5EIYNBQmeB4CrgeND8sdglRaM3Kw09Yah5inqPdyENkApjI01hfkAZj9xMSI0MiDlrnJDh0OzYlW+F6u7TPeMT7LJ4kNsLj8pELo04h9SpmzCsmdEVNU2uyyFXxPtn6GyzYMigNM696um1ZWFkwD41ATr4g46Yteiclm6vsFMvpLXEIesHI9YgK8hao1OXHfZ53a++BZuvFeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYmaSNVlHxCBognkVf3MgU9vLx2LwwQhU4wh/6U0XT0=;
 b=tHfYg+4b8Njk4x4Ys3U34orBXMJy4RakGd5Knb5jWZv6LmogoMJwVPDSS3hMtKFJm05Y6ALxrlsahWhOS7ez7b9OYhAy7vrjTxqNyf4DSX4CWw+vfBa8+OU//KCTWVBzsVaKaN/CvH5OtCZ8wvas6dXAQliAH5eBRGuLlCLgU28=
Received: from MWHPR1401CA0013.namprd14.prod.outlook.com
 (2603:10b6:301:4b::23) by MWHPR12MB1487.namprd12.prod.outlook.com
 (2603:10b6:301:3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Mon, 21 Mar
 2022 08:26:44 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::3) by MWHPR1401CA0013.outlook.office365.com
 (2603:10b6:301:4b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.13 via Frontend
 Transport; Mon, 21 Mar 2022 08:26:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Mon, 21 Mar 2022 08:26:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 21 Mar
 2022 03:26:42 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Mon, 21 Mar 2022 03:26:41 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/vcn: Correct the register setting for vcn1
Date: Mon, 21 Mar 2022 16:26:36 +0800
Message-ID: <20220321082636.4993-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31291449-b9e2-4e07-6e07-08da0b148820
X-MS-TrafficTypeDiagnostic: MWHPR12MB1487:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1487BD2743B8C195608B89528F169@MWHPR12MB1487.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ik/OPquU9/n8xjxPnh4kSNpzXCbiwCOfv8kCJMASpjzN9phJGxXPw0qfptpGAnhr4xfLGR5UwQzDXN/NgB1FKb6N4XcoIz81kTA1L4Vdu20P+oeQuU7XoDFqAWVcAw5piJ9gArknUW1kPGeQnfzr8aOtTq086GrhQQw26a+qbBoYNVXC6lbyM6rGL4qd89HIAjSs8ylbXMiP+MsZc4UFMsmWnj8C+qP+kbt3QkkbXHeKMOupBUhkQnEjy6ESOx7Xp9Zh2lCyG7vzDLLxmIUdU2eDA9/BR7u14du7/p77eZ9kT1ukhg0FY+VSnUt2b1Gi0ZiBqY/VgrCknm8Bdze7jAC0OjDdP7RrBRx5LuZsxTuSI8El0MUuGDVkekc7Jgvcx7EU7NYNaxjm17ZmIG5P0atT/G9y181isQKT/2IdDEbIQBPhzCm89vdMCJ3USDWpMmk5Fd2jA7nZuQ/66p8OeII4g5o+jZ33dGSgAKpWpAVaPuYeR6s8wsqcbTuw7logTp0pw5uVyzdQ48fN06u4QJusWaHPBWXJ6qYmImCSfOZZ7TGLpdXF+nBRwh+ZH5AviuS9L/EeNphs85x4oBNHZAONeIsmI7yuHdhFvxnr6hD4Ld4LYdK8vWmY7q1YQ7wd100DIRFpMD+/YhQA3V7Tw53d6AMBkxwXzBAdbP+Sjg2H7jsqz3uRZgKQ/vrxOC1oP7EDCKeJSpb2kf8xTmnCKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(47076005)(8936002)(5660300002)(6666004)(70206006)(70586007)(4326008)(82310400004)(86362001)(2616005)(40460700003)(336012)(426003)(83380400001)(26005)(1076003)(186003)(36860700001)(7696005)(2906002)(81166007)(356005)(36756003)(316002)(8676002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 08:26:43.5549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31291449-b9e2-4e07-6e07-08da0b148820
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1487
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
Cc: Emily Deng <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct the code error for setting register UVD_GFX10_ADDR_CONFIG.
Need to use inst_idx, or it only will set VCN0.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c87263ed20ec..b16c56aa2d22 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -575,8 +575,8 @@ static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)), 0, indirect);
 
 	/* VCN global tiling registers */
-	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
-		UVD, 0, mmUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
+		UVD, inst_idx, mmUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
 }
 
 static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
-- 
2.34.1

