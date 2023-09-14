Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9894CEEAA59
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 17:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3802A10E13D;
	Thu, 14 Sep 2023 17:09:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3DF010E13D
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 17:09:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFOJciLHLwTmOWGmmXgHuAWG0TivSh9srtPuLjy8sdwbfuZdvJv6kWe1McaqgqAT/q3zUV/B0fpwn4txKIhLktChxtNjrXvFNW2YvcKC8/nLwZvxd4hmPfTKWNLnNL1RuhtrGXtGA+hREyhsy57dU5zD6wofSKY94Ydr/pJj8z67pORG9kE/ck4ukk2ZmwaCv5Gq5zYUX5HnlF6vnK/2RMAwmdU5rCzdoD2q2h5rOQbvVbtcUO/jnA8mO6+hsvOmPfZyGILPnsf3aAn7xtUpif10zynOC8O6xn7cKkCzZG10h+M+gn0kHAHarD7Lj8ctBJIrMLDNredhF2e6enmq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrZAQSt94z8uwUFK5Usy1jgjSvy+hn2ElcJbf1AzlZU=;
 b=oe5g70wJIz1zstT+4FZa0P0XslN8N5ZFBoBLw5GbGvQYCnuRss+wDgLEOS2Z3keVtvxsQIebsoC5xyKKlRD3CvXe0fRCj0f9mt2jVNbg7OubKbcIZBrEKwTLVhaIyZbxKude2pGuNa2q2UuoYl0lNGErJ35jqUfUtWzfGLBRF9JpN8EZ+NoNjqaE9tdZoG3Uz+ZdVk6eocVWw+x973qb3kIHNc0auZNaeob1J1/HzmGamSN8VrBJS8j3jeu0TrODJ2DnOBGJ+qqToDgxYo78V4IKBKvPHJe2zUqGDSHaujfbYMgosMdyoSeJQXQ96gosschsGoy+TxibuW9UcrDZuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrZAQSt94z8uwUFK5Usy1jgjSvy+hn2ElcJbf1AzlZU=;
 b=rB40RSYlCNv9nZECUltnrhBT+I7mH7op35eRDaOZIVhmIG1XdFDrgeyAuKt89/GkHSq6KeiKUtLMz5tkFza+1nLB41v9apThEXFbwGQYnipJD8dZEoMbXujYKzZX/IjrsKl+o2suQukQ3NxCtKxRZ5qV9rNFbMxlcaO4xuDxQPE=
Received: from MW4PR03CA0100.namprd03.prod.outlook.com (2603:10b6:303:b7::15)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 17:09:20 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::b7) by MW4PR03CA0100.outlook.office365.com
 (2603:10b6:303:b7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 17:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 17:09:20 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 12:09:19 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Align unique_id format to match amdgpu
Date: Thu, 14 Sep 2023 13:09:06 -0400
Message-ID: <20230914170906.88487-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 72427be6-ce48-43cf-c93f-08dbb54555e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lx+XTVubpbrLH99nMRD7VtVQBRlkIlfguL5hAgnL2AJ2ivDG9oAkooPGXrJzUg6dnyzdkQD5K+dsiyWmnmusa2PubPqCabz58GXmz7louemL23lBhSPl3jGpsN9V4zxSBNtouaza8xaHcgxoAEgUqOxkOLuMbfhhMYqHn05e/grcq5y7YyZIl/BcdmHX5FpoILEoHmG5KxG0SblBbSk8wcRyt7ziCE9fgcQ9dK0222oPFDBpj320ncJWDMv7J0sD9nGFeYvVySaBKlWyO4pgLy0zdGTsaIVpIVo6MiYELJXYcNB/xOH53NysSZ+60LJJ27R049ObVBOcnyBBUg1c+C+15bbSgyqbtxU8doe7tUGHYUQ8d/R3yjywWwOLAniLmAZUxPeNEZ11jxWXV8/V/OXimDjOBTE3487y+QwDSvoEYa6DpCfJfzqeZhidTB1bmsFtixIVajFQyUs17XCwNRLEqAbG6BuM6dfVtVNxOuqxazYpRxe1lR5xC0Gp+eZTltThRsVh1uLiztorOYx5khITOpR6wDgVVBzfMzpL4VENwaihfDPBfmdAl4hFXzWKVyNArXL+6uz1EN4zcQo5FFy7RPAJyxPC47PoogKoebkSJ5UK4IxGLE7hRbzI22ZtrSfovv+pTbTbyka2Udfv7zPsJpCHNlcSEnEFL4C/+DhNxNZ0l7St3WoENZzAGc+TkrkSdDGUAfFgJr116MkDqBRvcya8/BIMvsLOMm4QkxcGun+SMc3NgmAavurBO6+/ejbvxPAnwjGdccsqkbUmDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(82310400011)(1800799009)(186009)(451199024)(40470700004)(36840700001)(46966006)(83380400001)(36860700001)(41300700001)(6916009)(47076005)(40480700001)(316002)(6666004)(426003)(7696005)(478600001)(336012)(26005)(16526019)(70586007)(1076003)(2616005)(70206006)(5660300002)(2906002)(44832011)(8936002)(86362001)(82740400003)(356005)(8676002)(81166007)(40460700003)(4326008)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 17:09:20.0406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72427be6-ce48-43cf-c93f-08dbb54555e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
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
Cc: Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

unique_id is printed as %016llx in amdgpu, but %llu in KFD. Call the
sysfs_show_gen_prop function directly and use the %016llx format, to
align with amdgpu. Don't need to add a new macro since this is a one-off.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index c8c75ff7cea8..4dac29cdab20 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -538,7 +538,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 				      dev->node_props.debug_prop);
 		sysfs_show_32bit_prop(buffer, offs, "sdma_fw_version",
 				      dev->gpu->kfd->sdma_fw_version);
-		sysfs_show_64bit_prop(buffer, offs, "unique_id",
+		sysfs_show_gen_prop(buffer, offs, "%s %016llx\n", "unique_id",
 				      dev->gpu->adev->unique_id);
 		sysfs_show_32bit_prop(buffer, offs, "num_xcc",
 				      NUM_XCC(dev->gpu->xcc_mask));
-- 
2.34.1

