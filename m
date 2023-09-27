Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD722E80A8E
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 05:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 266CF10E46A;
	Wed, 27 Sep 2023 05:42:36 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E84B10E46A
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 05:42:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLq3CKrX2hzbys+H034jNgn/0DO41xbsBd4m+1jwTVWB6Vnxom8tj4Mnzls/PBfQdQk71plsAcTvLFOzgK4O35xlFvdzbMqE0FJadMNjT4eQClJyernofllGYtI2LBBhbaAlc5+PuPMbLmy8kSnYp8THzo0O0f3nomBbm2GAUgq67r3va6fjnXRYoaU/L7EsYXvRjAO98zjLdpRWqXqMu+Po6iJQIaxol57UP0KNszr0+QKCH3l2ceXsqdpBQOnixasQ8Fah5pN6xWkoNnfaOs02emeMtCa74bOOsQXl9loXh8Yeju5Q2cojOJddeLw9zs3jtEZip+xxbpX2Q+IshQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cOMct6Wi5IDq4E/qJv8xESRgNcjHenYAbTqkcWeeLU=;
 b=DRDJeZel1YHVFbEa0atLSjjjTQT9QXEOflGmoPWRu10KYjKQ5cAqCrIgRlY7eaUGvs6ogBbGZTkjT1PnkWrgdOKuSZaqSC9YZEvnKPR2rN/+FOrlYj26WcDfRdJn+b7tVtgiUXtrIv5LPWBjk4es08Vf8Th+elCJl5dDgIkxn74Bsyah0G92Npqo2TTeALGOn8/eALquDjjaE0xGdvRlTSavSLyTSHgPOdN2j9LYyQUCcgVlupJQHuOrIPxgnWsl84IniQ/0k0xBO+GaRAAQW21FWNyG65WmeU7jBbWEPIBkJc48hxkNKqeldxHzvYJfATXn57RjXM1GI2ctyOw4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cOMct6Wi5IDq4E/qJv8xESRgNcjHenYAbTqkcWeeLU=;
 b=Vz8E7h2UgvH2wGnfGLf7pJuZtuHIhcGzCnOyPeOuV6i2zJxMAT8HbcgzzOBa9rStJ4+3PKuTf39CooodCuPe1K5RhDmwM/nXy51qrtkQOrSGGfYL39z77Z6UCFu1w6WKWx//EQ5VzHPsG8iT6hwp4Ll5G0q1kUxtG4iGUVmEnxk=
Received: from DM6PR02CA0068.namprd02.prod.outlook.com (2603:10b6:5:177::45)
 by IA0PR12MB8645.namprd12.prod.outlook.com (2603:10b6:208:48f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 27 Sep
 2023 05:42:31 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:177:cafe::9d) by DM6PR02CA0068.outlook.office365.com
 (2603:10b6:5:177::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 05:42:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 05:42:30 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 00:42:27 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: enable S/G display for for recent APUs by
 default
Date: Wed, 27 Sep 2023 13:41:43 +0800
Message-ID: <20230927054143.2169903-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|IA0PR12MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: 034455d1-c28a-4899-387e-08dbbf1c8abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sSpiriT4tvQh8PRgbp6qi0cOFCgzK7nobYoJKWzN3Ek0SEFBFgsYWEE8KI+WVrs6QX0W9CgchjmqbvHR2kZ58/9Z3fuoxAQx/UU1D3Jpu3DrX8JFgvlSz9Aov9GW6B6rRaGkn9Y1Bi2A+LcFLdYVtZpZN19Au2e9IHujFZijL+z4yiiT/HScMEa8Q4f1hkkUgW3DUPeED+OVc10YZ60zxBqW69UGlIFO2Arg4kovHUBwhyoH2mKvDup7nfOz6w+nkQdqZ3c/6epl/Q3eNY0/M4yLa0qhw7szK1tjjmDyGVh/srpYBJwgb0tBcyyEZG2YVnUnyIMRF+5ZXcCIhvd+aOyVqxFZhqvfDT/5J2FJmkVdDYmxLwd5VNsZ4lnafW9zx94FOkzStvwOC3PKsvVucsRHvnoJ3SqlqZfZEcNHQEwYXkZsolzJQL20GLdT2HU522w9QeltQwj1l14aQYC6/v65pqC1lR15DIXNPvaRYA9FHwlsAFFpzdpA8ZyWNiOtKx/entsGFyZTywzOXMEpqRuO03cK5w8gHjBjeWXlRYFT6AHcqbs7SaiuDegmpgS/cUrZ5E10ym/ox4OqHMBGKt1Hib6jOKf663GjlxpNWrvO6Bdk999OdmJTirE5bKuZJnNPs0e60s0tgZKEaQR2gb1IHxY5XrszwVTdjd0XlZjSnOnjVohgvzRB5YKcRIOWSBdFMkKbreisW5xAhLFaRNJD7gt5R1UNoQn4vzhqhuESiI+8dgI6MlrCpNABZ0awwtA1jmz9VVdNVQzMN7smOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(8936002)(8676002)(86362001)(70206006)(4326008)(5660300002)(70586007)(36860700001)(6916009)(54906003)(36756003)(41300700001)(316002)(2906002)(47076005)(83380400001)(478600001)(336012)(426003)(40480700001)(26005)(356005)(1076003)(7696005)(40460700003)(2616005)(16526019)(82740400003)(6666004)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 05:42:30.9790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 034455d1-c28a-4899-387e-08dbbf1c8abb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8645
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Harry.Wentland@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With S/G display becomes stable, enable S/G display for recent APUs
by default rather than white list.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 43 +++++--------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7e6a693d6369..241fd8defdee 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1626,41 +1626,18 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		break;
 	}
 
-	switch (adev->asic_type) {
-	case CHIP_CARRIZO:
-	case CHIP_STONEY:
+	if ((adev->asic_type == CHIP_CARRIZO ||
+		adev->asic_type == CHIP_STONEY ||
+		((adev->flags & AMD_IS_APU) &&
+		amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(1, 0, 0) &&
+		!(adev->apu_flags & AMD_APU_IS_RAVEN))) &&
+		amdgpu_sg_display != 0) {
 		init_data.flags.gpu_vm_support = true;
-		break;
-	default:
-		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
-		case IP_VERSION(1, 0, 0):
-		case IP_VERSION(1, 0, 1):
-			/* enable S/G on PCO and RV2 */
-			if ((adev->apu_flags & AMD_APU_IS_RAVEN2) ||
-			    (adev->apu_flags & AMD_APU_IS_PICASSO))
-				init_data.flags.gpu_vm_support = true;
-			break;
-		case IP_VERSION(2, 1, 0):
-		case IP_VERSION(3, 0, 1):
-		case IP_VERSION(3, 1, 2):
-		case IP_VERSION(3, 1, 3):
-		case IP_VERSION(3, 1, 4):
-		case IP_VERSION(3, 1, 5):
-		case IP_VERSION(3, 1, 6):
-		case IP_VERSION(3, 5, 0):
-			init_data.flags.gpu_vm_support = true;
-			break;
-		default:
-			break;
-		}
-		break;
-	}
-	if (init_data.flags.gpu_vm_support &&
-	    (amdgpu_sg_display == 0))
-		init_data.flags.gpu_vm_support = false;
-
-	if (init_data.flags.gpu_vm_support)
 		adev->mode_info.gpu_vm_support = true;
+	} else {
+		init_data.flags.gpu_vm_support = false;
+		adev->mode_info.gpu_vm_support = false;
+	}
 
 	if (amdgpu_dc_feature_mask & DC_FBC_MASK)
 		init_data.flags.fbc_support = true;
-- 
2.37.3

