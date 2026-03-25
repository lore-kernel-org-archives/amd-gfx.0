Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FBBFEA83E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 09:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EC1210E541;
	Wed, 25 Mar 2026 09:58:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="049hKtOZ";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011058.outbound.protection.outlook.com
 [40.93.194.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B45CA10E541
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 09:58:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gn/8e9RXstddKf7ucPWh+PpoK8jyiTqKHsV1i5A3mzKUHgmCHgpNbUyQTpTjiarB3KbEsToJdnRulkrd3suALGicaHUtq9UVzcsgkHookomU6bRpR6ESKYJLn1t4rg6Hhc6MzQkAtChKPjKr9lq4GJNYE/w/egXDVbMqzz+sDbM79EI0X3BYvS2vfGLHPsNmDwC2Prha4W0r2uK1fYj7HIJ69IOuLjERME347G1Qobc444yeQi7x2Lw1PizL3D4SK0MsVlNPEE+Out5kglypKwX8hK8KekOkLEV7OHry9ODsXDMSG9B3cGK42PUcDtryc+TdJx5SnWw149Jh4ZIInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MU2E3SDuTCOvn2WZKkXC6dVzKgXCyFEWAO/aElvjigE=;
 b=OFK7Ps8aZsyei6wJ4vglWs69iKGFAOA+WsFXeujNz5BNL1Jt2GSC2VlrW5l5dpwGuRdvmb15zPppp5Xx9haS2zW7nmZvBNbFYYW6m/P7iYrnIAfN9K2aDJXL5ueMlNo6r7T0y09XB4Dr2oSTOQW7nCUd3Nenpi6b0Kqv9Wy5otSgZdUQNgH5LEMtlf9xY2MdSljV+kA8dMcghNrIAt/pBdMEs/k5ToZ5YdMImIVXaoBSp0C7GWEDqzUHjlFdb0hiAwxQLP+cBrx4x0hVEOjB4PzEIPGzpqd62/fbFNF3dIcjmcjysUSIrVmYIy/TloNovXg1hZ16IkR/qjZ2g6oM7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MU2E3SDuTCOvn2WZKkXC6dVzKgXCyFEWAO/aElvjigE=;
 b=049hKtOZyPorftfPf7JTmflmaIqT2mf0QC9DjRNzm3jytVn6E6e2usVqk4DIKZFNm8fXxVwCVKRz6vZhgGyum1KjzANnnD9xq8Zc0kgOu/eAj7IUvp06oA76GWdTsORlFUpr6sYJ3ak1a+NDVOcF2zSBC9KLVqcKAkQ5qVAPnxY=
Received: from MW4PR04CA0216.namprd04.prod.outlook.com (2603:10b6:303:87::11)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 09:58:35 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::58) by MW4PR04CA0216.outlook.office365.com
 (2603:10b6:303:87::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 09:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 09:58:34 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 04:58:32 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amd/pm: Use str_enabled_disabled in amdgpu_pm sysfs
Date: Wed, 25 Mar 2026 17:58:13 +0800
Message-ID: <20260325095813.3374163-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: eee47f10-49a3-4c39-9d1a-08de8a551454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: uwQgChV/swuNG6QygeW4XxWsAMtWnrKq/XNK4/cGpqFcKYDF1rVdECC0dedR/UfpSU4DY2qh/BwOjJL04/SKUK4BXCV94X4N3sJsZJvOYPiyZ2h399IEXfq5g76Cr3y9Mv+DVJ7cMDrHJg95bs9XtLlGq/RH7ElhTgQwGsv1pwMHD9uK7XtAK5eYSd2orr0qevwOWFfA2q0CQv9BS6SjCbGwttcmFlg+sI6qE8Bv2yXGLlZ2hTNYGekEzmCUAnsWO+LQnb5VdvOSIga1CmVqLJNUByjvSTsg26M5/FuKrdgU0WnFvBhf8cOZaFDBAe9rZm3RHRbSF1KtvLU5Q/idWeiVq+EEsGgCJJZZvYVtnvQi2VlnrOu+3SEsVjaIP+ujuOnWtOaiFr7XqQNDTUj5ucUuNZNf7WXONSrBf/1+7+FhaM2pd24l4+pO6H6GZZrwSwrBMm4/B3Qxn9urN+B0x7Ep2/1R0IZ4n0WMNL0ScwXNvCTNM05wvHiF1TAVmSMCO3Jb5/9bj4gLzTEWdJyM3aDMxDBB9I1Ne15+1R6a+0cjp2v3UyJ39fJrMjtuw5sCXmC5JnSr5IRqeGlNms6J5l47eTfByj36JXudu8Fct75aCGoufP8lsi2v3EUWc4vR4QHHuGx7JkwHCRxnERoOegKIzECpZvpxLnSxrPirfHuPjEgqvKi6TqCEYTLnkurafsWHIefI9mXMBNRe8XyWiwEr/d7cV0k1N9hnuKzPgOt1Gl2Gc2VFeMFZjcJdTEYquJZEu2Y1MqILgtfcDQK9gA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Kmx+MgU8CSqCKajMCDQHdQDlzQQC6+g6Llv618CiZ02Icg+6KlzXcKMg8NGBYN9ESMcASJlXDffeStz0QLDDNTbiWClP6eY799+HcfIhGPAX/PNl7qI1oLx0lb9s9eFy/WPFIA07KfpO8BFZDfY++9oAyVrPtN0zaf1ydC42GeMU/9oprTnH6NoAfDWq7SKTRy1cLA14GrXSTpNjwnIhdCtebKWoPlkFHr7GQZ+HJMWEuOnPU9Tfz4+jfsuctI4cZt8Z4juyX86SpVV+XgoQICYPMGJALGVqWwPMrTOy8nNGPY2W7W1QGrPBaovPj0Twkn0jBABVgqGKE+zx7OxwdQGEZgRUm7onzNLYuI9tVkvfrFbRKz0UxJFLpobaLShN2agz1CSsNPVzumtGwbssBH4VUX4lkKG0ccVRcyQLyTnX9w8e/PaNNdPYxex6ueC2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:58:34.9724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eee47f10-49a3-4c39-9d1a-08de8a551454
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
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

Coccinelle flags hand-rolled "enabled"/"disabled" strings; use the shared
str_enabled_disabled() helper from string_choices.h for npm_status and
thermal throttling logging sysfs text.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603251434.zIN2QYWn-lkp@intel.com/

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 6565cc3e35f2..a4d8e667eafb 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -33,6 +33,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/nospec.h>
 #include <linux/pm_runtime.h>
+#include <linux/string_choices.h>
 #include <asm/processor.h>
 
 #define MAX_NUM_OF_FEATURES_PER_SUBSET		8
@@ -1592,7 +1593,7 @@ static ssize_t amdgpu_get_thermal_throttling_logging(struct device *dev,
 
 	return sysfs_emit(buf, "%s: thermal throttling logging %s, with interval %d seconds\n",
 			  adev_to_drm(adev)->unique,
-			  atomic_read(&adev->throttling_logging_enabled) ? "enabled" : "disabled",
+			  str_enabled_disabled(atomic_read(&adev->throttling_logging_enabled)),
 			  adev->throttling_logging_rs.interval / HZ + 1);
 }
 
@@ -2235,7 +2236,7 @@ static ssize_t amdgpu_show_npm_status(struct device *dev,
 	if (r)
 		return r;
 
-	return sysfs_emit(buf, "%s\n", npower ? "enabled" : "disabled");
+	return sysfs_emit(buf, "%s\n", str_enabled_disabled(npower));
 }
 
 /**
-- 
2.46.0

