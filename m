Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6689AC98315
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 04:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D346B10E002;
	Mon, 19 Jan 2026 04:47:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C+fvHP6G";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2998F10E002
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 04:47:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3739rb5ROvd5UhTqTZp4C09Q5H7bwLvf/pNlM2yiFFBUs5j50ZICDrHGLgscS9OmaBkvY366Z/2QBmCvzKYPESSluYd3myjXg5ermfa23/rWkqelRLayOzUjpBPHtyWUiIEaGdyIROv3KoSynf1ppF4AuwpcgDOAlbHpojiBvqofHtLMX/y87vmEK+t2cvILVabbSIH1NSW3J8tg2bSzna9XESIahDOsYcxPa5k7JTJHgaFTFsiBoSYTuXLjsiOD8/BKHej+TuaJeS847fkZeRyuMB32PrAlLl0JaIc8PzwQ/3GHed2AdoLO7lgkgr7t9F5JT36bgR57MvAvUxZTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTwe6ty7N2T5aHrcrF98fyuWwlxjcCio8fgx28dDbAg=;
 b=NBmniMIatrYsEWAqouKRHaW+NFINKLAbHDoIDLo2+gaV9wd247Br8tdC6EwCugsdSR+zwu8RkibZb3X8kIG4pWMoySGJ+c64npsLbJ2Nvzk629AMnZbcCMZPoRvajnYgALte+TJhcBJYuoxX6Trm4g1KwJMYrsEJSq+fs0AkC9xojVh1zwREqcsjhalBjLmqrr5OQCiDKc1Rznbu32e/HTYjzirbV1DN/3Am8IJXCwjVVpdPFn+8DuiUSKhQy1T8yjRejVNHl+yMfeaXK9OsGUK4Dp+BKfaQ4dFcYTkjSOXMb/+9EOhfs0HdwrA3rSSk5llTUIwxu+dttY06KaHm8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTwe6ty7N2T5aHrcrF98fyuWwlxjcCio8fgx28dDbAg=;
 b=C+fvHP6G4ME3GnE2sq6Ug9aY0yIUPDeQC/2XbCpTbV+hWEJevkc4zdRHDnC/DDgIIEO84KnGa/sM5ozIlqv/nqKfKQvhcKVkvPgC8KcGvxBCyqlIPa1mqGoV8c7eOoToHqv8OhLgZvF9uWBJiExConXdXJ6HyEOmzmkofhKhBjo=
Received: from MW4PR03CA0141.namprd03.prod.outlook.com (2603:10b6:303:8c::26)
 by SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 04:47:23 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::e8) by MW4PR03CA0141.outlook.office365.com
 (2603:10b6:303:8c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 04:47:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 04:47:22 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 18 Jan
 2026 22:47:19 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, kernel test robot
 <lkp@intel.com>
Subject: [PATCH] drm/amd/pm: Fix unneeded semicolon warning
Date: Mon, 19 Jan 2026 10:17:00 +0530
Message-ID: <20260119044701.1026057-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: 080fe32b-1f74-4b97-5e1a-08de5715d601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gLFh1euRM9A75+kTpI5BXf9ar3RC7NhuQKjY7ZgUkJrbvgO6x3bdy8mW0ATF?=
 =?us-ascii?Q?cYiz3Py9jG/DUJWVukWsawr0+kfwM2KxFxWg/wpFiZHdex75irU7/zBh6op2?=
 =?us-ascii?Q?gv9M32wfGuKo9cm6zxZIaoj7MER+ScdFsKK01A+Evi+gCfUZvmv1zJyNJFb9?=
 =?us-ascii?Q?KoP+YQLwHT7WVv3P5UWV+czriddD7edWdHKa5JXOE42hop0pwQ+3+ZaghmqD?=
 =?us-ascii?Q?tYC9m3zX+QZCP3G1WTJlz2gPKodsHDF3xViIpPViEaVS8WSjdk0rtupk6GFs?=
 =?us-ascii?Q?C57eOEy0hZ8p0HUwbb6BToYynu2n0WvMtwC/DyMcACZluMJTZSPkgdxcYVK9?=
 =?us-ascii?Q?epkMqGwBXgpNxxptpmIjueOa44bzH7Xx47rCEzqPnVTYIBblvozRYaOoXufz?=
 =?us-ascii?Q?s+v35Fab5KKrzUdtQ+JUJvEd5w1oulc/Fp5P1NBOfls9EPWNr1n3h6/yDT4H?=
 =?us-ascii?Q?jjokBI40H+GmCvwHqPdfSEYMD2e4hMGIRvHUVMVMmDbYKqLLNlj9kB7Zg69B?=
 =?us-ascii?Q?SSVSeZsknPVwAixisKuh6nuYUM5KDRq8vnfCs+uqzrN7XkCR/C9z6F9ACyHn?=
 =?us-ascii?Q?FhxSAdKhFQ3YtSdw3SP7xzdHZLmNf0fVKBv+Rb7gu9IqpsxTH+KzjO7bBvlW?=
 =?us-ascii?Q?bvA52ubs6YINOBhwqBaZdKMVfszIy0ZV2Xv99KDszufZd47D/N92mO2Pggiw?=
 =?us-ascii?Q?DvNOmg1VZhmOMhXl3tpFLVz0CjC8VR0K8KBPytQUPfADnU8J0lFDhXsiR491?=
 =?us-ascii?Q?a6PWGtFE67y6H/hPGvc+LuR1RkAUBe4zRLo8VP5i7AqpQcT1tlGxDyvJPO3S?=
 =?us-ascii?Q?ncv+3Qc4QSYRUBQEikonHe63FD1M40x65FDGGnnlO3ndY0Z9KZpV/enZcc7X?=
 =?us-ascii?Q?XbzWoR2xcYkjJJge84MfBwtedtlaslFDsYwbZhR5kWN82LFcn4MN0K0wAg4a?=
 =?us-ascii?Q?JlsKudyGBIf4ukXSFYjMug/j2Ff1uh093s2vWJjMEPxuIQfDsztdBiDREAxv?=
 =?us-ascii?Q?KaQdWCgmeUBD0BR1XC9SQ/kYwvDjARxm0WUmtilfxONo0aVpxNqxaswjYJ+I?=
 =?us-ascii?Q?NuXM1QBZ9p8E4mDfREFvdJqoEs2eoHhj3xGucPyI+GIeqx/DoGWrx0ewUMNm?=
 =?us-ascii?Q?HCbb8KMNO/dceQB337BaK3j/kHpa3oUnztW/dpI3X5sNJdSrAZsxsGky9bai?=
 =?us-ascii?Q?9eeyQEPHOusgLgmDoeCgvoPYtNY7crEYoANTPYgnCtIZuZaO/u5YCYwnArKE?=
 =?us-ascii?Q?wP6KA+kaK3aODcVQjdVYxK1ZIi+B+xy1tf7Mihge/l+xsZXQtU1frumyUVwP?=
 =?us-ascii?Q?9+PzAccQoXK1ZoY2H3BZWRQ5ijuFVl6GyZ7dxxm5jpYBzupOKs9EpQfD2rHI?=
 =?us-ascii?Q?Jfe5lbR7AKeDZCY42IL0qldCMNiTMyXgp3XLj6tx/TZSIdSnECzQtkBN4F93?=
 =?us-ascii?Q?Z9Jj1ds/vBLKAJKHCB8E3dBSlnDwszVG9wEgN9xUUbc+XkvypdcTi9tYD+kV?=
 =?us-ascii?Q?QMP8Z8o/Qn+jYs+UTHQUEMes2JeIMEBa1ufDRZgDpSYZVyEyFmMRx/Q/CDue?=
 =?us-ascii?Q?sOseFhw1I8+mR5sBCPLTwz33/3N8ieGxJJaIaD5oCqis61EJRGBCGj79oMcu?=
 =?us-ascii?Q?8tUWiFrVYx2wBtF7jt5/Y7vAD8hTSnlrlIslp03ulLdKt8Hz/2Pw7hepsFzn?=
 =?us-ascii?Q?Dvk+Mw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 04:47:22.8190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 080fe32b-1f74-4b97-5e1a-08de5715d601
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106
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

Fix the warning reported.
drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c:909:3-4: Unneeded semicolon

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601182157.r1AfndME-lkp@intel.com/
Fixes: b480f573a8ab ("drm/amd/pm: Use gpu metrics 1.9 for SMUv13.0.12")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 44d5f134a87a..9a34e5460b35 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -956,7 +956,7 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
 			gpu_metrics->gfx_below_host_limit_total_acc
 				[i] = SMUQ10_ROUND(
 				metrics->GfxclkBelowHostLimitTotalAcc[inst]);
-		};
+		}
 	}
 
 	gpu_metrics->xgmi_link_width = metrics->XgmiWidth;
-- 
2.49.0

