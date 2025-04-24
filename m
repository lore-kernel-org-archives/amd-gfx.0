Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70C6C369D7
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 11:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D969D10E7D5;
	Thu, 24 Apr 2025 11:40:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="37ilqWpj";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADC5510E309
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 11:39:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUqRiLgahUnp2AKalYwOnWkN7HfbSmhnGzj6j9lrgxzc8qQeXD2MHkibxxQkK6BVjUsre+Xgjx3c1LW3xvDtkqDS5Ix2kle27VmsVat41EcXog5DlsnECfwcLsoOqCW+gdfe6qyT0ZRiakfI/8ZEfm27uIqLWEQiJCqdBn5kByxAcUPwmQU2HgZWbQrzG8Ja4VGHqociLW2N8g8I1XdIRXGn1qkvTyG0pADavfTuFJgNuZqqpq5xpw4yt0JMXleo3SbDHZo2CQUJ5PuNgORIVlMAc3z9jf7VpMtGNnJ/idw3gYNHwHKCzQgk6hZXCR4Dj4OlgL9ieGTwE7do7E8KPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2Q7eAle1ATyqkuWoFx9zqDKiyOEBWnXG4KEaTmk6NA=;
 b=HQcTdc6ibquUpk/UUb8a0YNaBqeiWvXaZQCsB/mstU5axewL5nuk2Zo1go4a+fmeYvf6SKOrLGBd2nBy5jAA0bk2yU3xwoqtBMjg2wqG5c465QWOQrow96aCYdi0KSUuGZTWjxQ8JqP62Vd45f0GVAIMf6tFmPTJ//bQTldojlUDcjkPwrTqjUR4gFZCaqVRGg+bVw7drzj1vZMBBw4E1xmCd3jpqAyN+vnlVNw3kmYSeh6bKNPJhkXsnduMLTYgp0pDMs0WXM/KCTOOdCzfd6O8kQLtAk0eICH3ErtHrqSKBMHw30t6jSf2cw6ughRfUPrUGAteYe7cagOQ3trRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2Q7eAle1ATyqkuWoFx9zqDKiyOEBWnXG4KEaTmk6NA=;
 b=37ilqWpjDqUpbbC+shCxVrwEI/A0hby/ZXz8LokecDbROrrB4MORF62iLJZBbn9f3Ewb9EdGSs/urqLOlvVI7eS3eDMK/6YSplHLhmqxuRhsBpfum3kKydIq4aw7ns1IUw4QOHXBITGSkwU4hRj01mO7be31QGfFKnzEFeXFWjk=
Received: from BN9P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::22)
 by SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 11:39:54 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:408:13e:cafe::e6) by BN9P220CA0017.outlook.office365.com
 (2603:10b6:408:13e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Thu,
 24 Apr 2025 11:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 11:39:53 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 06:39:50 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.co>
Subject: [PATCH v3 3/7] drm/amd/pn: Fetch static metrics table
Date: Thu, 24 Apr 2025 19:39:26 +0800
Message-ID: <20250424113930.464303-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250424113930.464303-1-asad.kamal@amd.com>
References: <20250424113930.464303-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|SJ0PR12MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5dd5a6-e0ca-40ae-1b8b-08dd8324bac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3bbCReaiwG3Q+rTapqO5/ygjsyRvYU+byk1Zb/+CYNaxyxWOJ8hEvwX0bXjr?=
 =?us-ascii?Q?xDJ1RyrSlzvE8MTsw8bAAhkekr+jXmrgWExsKoOthreFKgXKZf+1L+PxFWx7?=
 =?us-ascii?Q?8cj5XaAt/wqJeIW1UPXImctfiMCX0tFkOOa9LY+setdB3EF7uGdbPibyvbXC?=
 =?us-ascii?Q?vEPiBytRquuQFg+orsCOgoZg8nLhUz8Hq66XCOeChL7R61akhyZ7Ib8wvuoe?=
 =?us-ascii?Q?CzGIg6zDBYZ64LrqgM2BqsQ/QhbBQKrJarczil6Lqcy/BdruYh36q9CCyO1S?=
 =?us-ascii?Q?98GHqNIN9nD7cmDKFex8h+NBIemwECoTBXNycJBQ979OjsxzLA//IbRQaqR7?=
 =?us-ascii?Q?8dCeq/WEXK1ZLqYWwYA1RzVEPtZhW0YHjcEltHWVvdKW4rdPHdWKJMjP1FFJ?=
 =?us-ascii?Q?0Rhk/1VC52yQtBVNu3x4CRahYnXHFGpzGS0GWmCN2vaZAVVJuJKFZ2vCmiuK?=
 =?us-ascii?Q?AfnEege6+64CFbcXM7URRkxEjf5zjR1iquVK86yhHTFHIE+1QRpg3Bj2V7aN?=
 =?us-ascii?Q?4N1r7FR+JGPYG3IrjjQqOTJp6cfsuTXNfHEyf2F5n70JW6SnjfH2K+qzbcTa?=
 =?us-ascii?Q?mhLPVdhLToynsjfSW7SDBYRbrP7fkeFgT1mbScde8B7x+PX6QOgjdl6rYhaU?=
 =?us-ascii?Q?ADKUPAP+iptVNAlJt2Qyb9TiiNe1YMjnEdInBKcoWP2bawJcsUomrAR/2AW5?=
 =?us-ascii?Q?cTnCHUYIGpg0wXZsDiDFcZoDR5hWItk1uxlP6hWVojV6AhzXL+SAzJL7RyT9?=
 =?us-ascii?Q?Ag/a6AjZDW0dHXV7TYhU/1mOCByh9OuCpg69KuOxUYragXyIuBIK3INd81N4?=
 =?us-ascii?Q?PrQIP0CchEQeXLI0HS+afvf7t8kaTh7p9JqC3ZyM6DnALHJT+ZND/7L7Zv/Z?=
 =?us-ascii?Q?ihUT4v+/cibUufCuW0Y8pmoIierTyfdkcKFH3Dh8K9dFpUtWS5kIwdqOabqd?=
 =?us-ascii?Q?ZIUo6ZRpeAuY9J3VZBqb1/MogQetJ7MxbwutIX4C9VPbrMZEVvcp+OsdhMyH?=
 =?us-ascii?Q?+KtD5Cge2eSg1xYWhlC+sVzEo4C3vkQhRzyY6Ieu6b+BSJtbwmOFNc/aGaxR?=
 =?us-ascii?Q?rdkrGR2/fspB9SgP7EnLm1yBGVSaMTl+qm9tjAUX3ADm3WqySVnge9/LRdPM?=
 =?us-ascii?Q?BXm7OHeJ1fC067ENBC+vqoAiu9kE4i+0Sd84/zZvChi9uMa9ZSuEQ0Ml1vq5?=
 =?us-ascii?Q?Sk0oLwhBry8uxe70aBU3IyGhtJukDwW1BIQ+JCljTK3jjUOk3H1r0JWLoQ8l?=
 =?us-ascii?Q?eH2lQ9LahQCB8Fl9RsbUZGaNzJU866Dn269uz5NKzfQ8YjWCokOjorreKHm1?=
 =?us-ascii?Q?7+N2q3HtRV1hPfzBno1V2okOHsfMA9FVToIPMxPSTAo6Tog6fEPz3EhFltry?=
 =?us-ascii?Q?h+cSpKNXpThGTbAZBy9/PlaOMNR85yNULFUKTvPfAFkg7tUcGHQpnqSjTlc4?=
 =?us-ascii?Q?wC6UJqNwRf7d8K1sjcthYpywH07wPM7pI7U8aQU9aeLe3TTOEpXMLEoi5t7b?=
 =?us-ascii?Q?4fRJP7XtUA43Dh8VTh1e2MXdobne8eoXyxu5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 11:39:53.1258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5dd5a6-e0ca-40ae-1b8b-08dd8324bac0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782
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

Fetch static metrics table for smu_v13_0_6

v2: Add static metrics caps check to fetch static metrics table

v3: Update version having all fixes for static metrics support

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 96fb6c111ea5..1a16b92c97c1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -177,6 +177,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlingPolicy,             0),
 	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
 	MSG_MAP(ResetVCN,                            PPSMC_MSG_ResetVCN,                       0),
+	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           0),
 };
 
 // clang-format on
@@ -391,6 +392,8 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 		if ((pgm == 7 && fw_ver >= 0x7550E00) ||
 		    (pgm == 0 && fw_ver >= 0x00557E00))
 			smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
+		if (fw_ver >= 0x00557F01)
+			smu_v13_0_6_cap_set(smu, SMU_CAP(STATIC_METRICS));
 	}
 	if (((pgm == 7) && (fw_ver >= 0x7550700)) ||
 	    ((pgm == 0) && (fw_ver >= 0x00557900)) ||
@@ -736,6 +739,26 @@ static ssize_t smu_v13_0_6_get_pm_metrics(struct smu_context *smu,
 	return pm_metrics->common_header.structure_size;
 }
 
+static int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
+	struct smu_table *table = &smu_table->driver_table;
+	int ret;
+
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetStaticMetricsTable, NULL);
+	if (ret) {
+		dev_info(smu->adev->dev,
+				"Failed to export static metrics table!\n");
+		return ret;
+	}
+
+	amdgpu_asic_invalidate_hdp(smu->adev, NULL);
+	memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
+
+	return 0;
+}
+
 static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -803,6 +826,11 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 			GET_METRIC_FIELD(PublicSerialNumber_AID, version)[0];
 
 		pptable->Init = true;
+		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS))) {
+			ret = smu_v13_0_6_get_static_metrics_table(smu);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return 0;
-- 
2.46.0

