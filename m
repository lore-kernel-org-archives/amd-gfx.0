Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C55C38159
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 02:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79C5510E226;
	Thu, 19 Jan 2023 02:04:09 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD30B10E226
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 02:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9DIRatdHg6F6GtnmG9Y5rXfswTpOkOdAO0HSLz9m7ndGt4mh02gKe29GGgekznvlfxhtVN4CvV67xSNZtCQImnosL0Gc+Foh4UW9hy1A0+M2mi4giUO5rq+DSypRoAP8er1GtFX5++pfm0LU940E/uAyPVhovh8nm4zeUxqs5kSK9Z+F/Krhd2L1eOg1AeNFmq1D3o1ZRMtKYGDKNNX2FtGugH2j/2zok09yGCiNKoqcGCDzBmSylRtQ382bgD80sxG0wB+Z96AJearN4zlSQ9LMb9XSuNioSOMzEtCPfpFhm8Vam0uhuPub1s8y32TM3sFoULFt7lvKKeK7lP07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnqg7uo1JvSyLYw8O0fTqe3fuo5hmeOlHjrsbFVCMYg=;
 b=L6uouOwOtOQZZJjH4/dhU6fCDsRgPIjPVRs7nRO6Cd3g6ZM2STlgI41TVUzTl5AOisnDsVml2SV5nH5EMAsV4retGXWpVoJWSk64qbW+ic4ZG2QrYyaj2bAHGOPwWBH3lT7kfrJGKJzT4tnAtUuAwj2UTju60D1oK36uChIe+HiIkeAOFvjlMo63U7qrrrRA9QFd6bPnaovdAdMW0QovZQLHUcbh0diSVtlODRJqDYU1OXAXEBbXsP1MWsUqexpDUtIpJIcBhPsjZK77UupoSTd0hps5/ZpMPtLv+DW+t32bG+jK5EQfzKxIayCnS/zwUofDN3g47EL+Wop+DeXJsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnqg7uo1JvSyLYw8O0fTqe3fuo5hmeOlHjrsbFVCMYg=;
 b=f6s5/TB4VlBdKHO98fwdhKA1Fj3AhW1daxecaCesd0UnjxV5GI7Q9NoAj1sV4Bv1+ViXpwutQopH3syyT5BlBRS9ZoOOFWrlzQ//Iq5PcqC2hw5/56bwI2R/KXSNYCLtH9YMcxl01hbOkmy1fP/vvLMSo0lzacHiyyys/iW6XZk=
Received: from BN0PR04CA0077.namprd04.prod.outlook.com (2603:10b6:408:ea::22)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 02:04:06 +0000
Received: from BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::55) by BN0PR04CA0077.outlook.office365.com
 (2603:10b6:408:ea::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Thu, 19 Jan 2023 02:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT087.mail.protection.outlook.com (10.13.177.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.24 via Frontend Transport; Thu, 19 Jan 2023 02:04:05 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 20:04:00 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Don't look for SRAT on systems without NUMA
Date: Wed, 18 Jan 2023 20:03:21 -0600
Message-ID: <20230119020321.7542-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT087:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c69269-1529-4d0c-7cca-08daf9c171c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4PXqhdZD20jLkh0cfbeFvIJ+dlylvU+EXU9FfPcV0aram5Avup8CCAitI4OGCGrHN83783Pu6AfeI48PQ0GbczzQc9l37vtrHoJmB0vYaKjwqZx4jy2CKYDOKhXXbXveTAAON7jGYXJYLXFFwFKa1nzsUg2bCwNxVRe2iMaPlu0H47YNaXcJv3qT+dKh0Ox2W6b4CYlIvUzoOT8QBQH8ODQm5YuRtFEYfuvnA5kuPA3oMxrj6BPN3iefDT92YaTN8NPSXImXfnTohcKIFPRziqDcv/3TmHeAQZ7zwOt9kDeaGlpUP8eGt5EXpRt0bOLwt9vXvaCpKow1vYk3DGkXSv/ObMqNY9BjRe0Rk7fj712SD/65cyZTmV2rAce4UhI7n8wKzIzreubMzfMuo91n42QMc0zl/q8/MPwYypFZ317pVw5ZT1KSch0DtwAnabNSSKtEE/on3YionFjWOj0BhePz8l22CNg/8HrOs1ODD0Y2ylmpPZOogdNEECmBsW5yjgqPi2WLxNjNBaBryowJZFfQLMTqxoBis/R87Oq4HGaxvyP5UUdhTFhPtyB9ldo/E335HNMBoI4mfisPSzNJiNB73VTr3D3D/bQsriQiVWXLlqUVy+E8QtMQCnM3Wu7vuSjlPX5JSSprTIm698XnFdW7FNAH5qnHjt4qsuvyhH6ksedCHW3uyDGQsaBbyjpKCQDp8Z46HQ3w0lHjIXlYfvpt+oGsAiAa+GZM2SWAQBQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(82310400005)(86362001)(83380400001)(8676002)(426003)(36860700001)(4326008)(2616005)(6916009)(41300700001)(70586007)(16526019)(26005)(186003)(47076005)(70206006)(478600001)(6666004)(7696005)(54906003)(81166007)(4744005)(2906002)(40460700003)(44832011)(356005)(82740400003)(5660300002)(336012)(8936002)(1076003)(316002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 02:04:05.8715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c69269-1529-4d0c-7cca-08daf9c171c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Laptops that have NUMA won't have an SRAT.  Only look for SRAT
when it should be there.

Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 3251f4783ba10..e303122a9a944 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2028,7 +2028,8 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 	sub_type_hdr->proximity_domain_from = proximity_domain;
 
 #ifdef CONFIG_ACPI_NUMA
-	if (kdev->adev->pdev->dev.numa_node == NUMA_NO_NODE)
+	if (kdev->adev->pdev->dev.numa_node == NUMA_NO_NODE &&
+	    num_possible_nodes() > 1)
 		kfd_find_numa_node_in_srat(kdev);
 #endif
 #ifdef CONFIG_NUMA
-- 
2.34.1

