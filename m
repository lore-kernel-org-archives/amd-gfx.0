Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84127EF070B
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 04:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D69910E274;
	Mon,  9 Feb 2026 04:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yCyt5heH";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E581E10E274
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 04:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWm3YaOl1u1opQKOEQxbcMzffznHW0o9ZkZxTQIGuXXw0+8amtig+Ch7HxsxDaDZz5L7lLBT6+n3NFyyai7iji3MC0SXImvAxm+IdMNuXiqviPzkLAZS8Tx9v+iFlUvNfZQThotOm5hbFyuqPufA3AvSo2ZAFDI+XijS6s1Eg4Qva1JUMESn7+JtNUEmPM+ug/IQwzM5AQidDrYHQdEUvKkhBWG/kdo/uVf89dlaTpmKz5P8nLdK83MdR9Rjrtoy/4f8M7TUx+rpLYzk1EKiy0FTXDddd1WWZABC/0DZL3N0GLULJCDAdqn+Udq6kjLjoDAmsXXAdh7Mh9a9v9aStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRBAmpbuZsQd8zgY7BNR2XyVsTbzsA76fmqeilYz+yc=;
 b=JahfxPRbea8PyDUknDS7ut5l7Q3yQbnm25hT3O04vYg92kNcMQFaXmyhzfL7RntHkKt1AR7R9UElcqHlSltdjE0T0WgeCLCY1wcIOpiT9or+Wu7NVfth6qafXVOR3956uMd7pCK4dME9DvZwYWslNQLYevDY1IcE9D6+e8E+YbW7aI+H/oP1psTguIYG6C3RvGd2nhYbJEFerleHWn2WtdD42DasJVtj6ZgYyLo54ELe7+aKEv64w4VgIbuObFWT3Emm3XCD8btFd25X4KNW6r250G/c0eCIzmOsftP6vvhuIfO+daDxTtlFeD9KHn8bTb/1fUFpxNPvq6nPsSCFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRBAmpbuZsQd8zgY7BNR2XyVsTbzsA76fmqeilYz+yc=;
 b=yCyt5heHrp4ZKGAUFDS5LaHWbb0i8+puWmPdpy3IjkQf8nnF2DACcSq+hkr/d/R7oDbXZbdVYwLx0nS7PtMSaatS/Hvyf1KhPYBWHCu2TSQA/2ozKEFh13m+/zPUvapk5LEZPcWZjFswT91iDpXR/Zt9cI8DDYwFXZF1bHkSeNk=
Received: from CH0P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::18)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Mon, 9 Feb
 2026 04:57:16 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::45) by CH0P221CA0016.outlook.office365.com
 (2603:10b6:610:11c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend
 Transport; Mon, 9 Feb 2026 04:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 04:57:16 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 8 Feb
 2026 22:57:11 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v6 04/11] drm/admgpu: Update metrics_table for SMU15
Date: Mon, 9 Feb 2026 04:56:42 +0000
Message-ID: <20260209045649.59979-4-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
References: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: f88800f0-cacf-482f-cc97-08de6797b22f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5V75mYGhp9ry+zlFKgZzw8La4S3jgPKv9WobmXvYL4P8DtA/EaMpfZ37cQz4?=
 =?us-ascii?Q?XOs5nfOqncbtGTiZTACEsNDAbGdHELQd/c4h51xhIY29sU9f7uaYLoxTpshX?=
 =?us-ascii?Q?xJ+HrvNi2mi5jPaumO9hPGKc6EExSHy9x0c+h7M1FiCIF5nvF9wsE/3h5yD2?=
 =?us-ascii?Q?XoCFRFuQnTrz+24OHG5uZ6TZtsyg9PLK3Ae9usudT0aoeRCJYaMQUOLS4aYs?=
 =?us-ascii?Q?G99OuUeSfy4EoqKEhq0CtY53wdOwi4uzfA3DdfabS/rscX/fvVgbZh2xrcly?=
 =?us-ascii?Q?9gkM3oeyGPHOFdCOnMsFk4eH9gK2jjzEbwi2VIlM9Ma2+O6QvMYyjfhRje4F?=
 =?us-ascii?Q?zjg5a/fwzJic1OHCQchHssBIquSHty9u0lpNW3Zo4CiaWwkDN7PfltLBJgQi?=
 =?us-ascii?Q?EdMrQU12sAUOHhu2fxeK06wC+WHt295Dsx8J1i+pk2HEEkFib/YkV3aE3SEF?=
 =?us-ascii?Q?wvB8HbtHaNTHRaTdqxqmRqTT324JnX6qLxY8b5J1yJbLO3BId/8g8hVmNcen?=
 =?us-ascii?Q?fLuV8AOlAhXrHfxcQ5wdASKWZkNlVk836DJsrilvOZ4ejqwitPzS5XFiySWi?=
 =?us-ascii?Q?x6eEBC0l6ka3L1/a3G5vMRKNMU9pb52gebGH59u281qxRE5lT4PlJNZRZ21P?=
 =?us-ascii?Q?YoFRZLAUJ/opFeESgltNoG9UkKEnpUDt+F4bJ4ZnEs6XecqW9fI5WtJkthbf?=
 =?us-ascii?Q?N+yhimn0igwRIgzSEFB6k5n7/3HKjOyOjW/LVQ/sZjQ9To6Z9zyfEybQNdsB?=
 =?us-ascii?Q?X0lfhmjqlWXcssn1bZarsTxDKNwuE7D3AXt2YrugbEZ3sO2y72mHaCy3kPaa?=
 =?us-ascii?Q?x6dNIszq4y+S2KpiiJ/EBr25nubUE7KTMdXAq6SBrhw+G5CTlv1fFCfsw7sD?=
 =?us-ascii?Q?n2BV+2NAhQG/INdyzZvb1OXuvgueoxPcMgPWlnbItLgXG1GafU8vGAghc9qx?=
 =?us-ascii?Q?0iIvpZ6bAf4OZ+bV0R6mgavCJ1llTuZiwMNMKq86IYws5Yp6CXCr8DFJElY5?=
 =?us-ascii?Q?K3mjCd66TrCOIhv76UbCuimKLTByoQM801ghQDLI9hkSeFIBh+wgxOALu4EP?=
 =?us-ascii?Q?XJdA8GAcagYfcc7XutjyXk2Bo1XL+bn0NWnv3HnoywGfEK3MX7gNrFBRo7Oy?=
 =?us-ascii?Q?KQueFY98NDJKJEEIClgtI9+FOJc9duugjfoggX5n2+Nppa+LM5qJ3n0wcpJO?=
 =?us-ascii?Q?8ZsWOjQn6D51nkEK2QkepZiZoFVFQXx5O67llEuij1qBynaYmIpgz9n3bF7k?=
 =?us-ascii?Q?FxtAB2FgeoqkLTNt0H62q3VCBNxllEE3ofkGaixCEFOnadnyFK24tEnroxsb?=
 =?us-ascii?Q?YlHLIcbpCidfRNnVw/kVwfKROeGakRRqWZCDm593Bm3n0SknsbHHTt3P7ilS?=
 =?us-ascii?Q?JvMO74+k4tNm0ml2AvX8Fp1urxcQ67HumrnBQ/tb05co4XU2lEDByvmay88d?=
 =?us-ascii?Q?UTZNbOp2Ky0zWDbvRu7VzUtdCyvyueIM+2TnQ5aKxljROBAat5MmPzqGnKBi?=
 =?us-ascii?Q?14JTTOto9VfskqrW6yx3HhB3KUeD1qmGZBS1LBtvCCHrIHSTWE0lnfOkVC0x?=
 =?us-ascii?Q?EMm6QvofLv5wqthwvWWi1/n87zcXeFt5jznS58U2PBRoSKOjXh2+Arpw82yv?=
 =?us-ascii?Q?wO1NUyNJfhFcHsEKr89RKj5G/YxO16C20GVRnUiKNKfXPTAkjN2dn8Ocicbx?=
 =?us-ascii?Q?JTh/mQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YwPZPAkchEjaAzDaXp6fbKoTQHSgnGklsw3c5GYzYgG8haHBW/XVnVyfW6Jgi0EK+OFUWci9SmBSyM2KQzPer6XOtyUUO1rILZ0MjBK6jESILDKmqMBjTTo48d6ibS13UD1g0o86PLPHmnlFtU52bNLai4iCOrrB3zF0FqQtuQwf549xXHkfUNlEMeVEFdXD0PIQuoB9ZotTffS/X2+jbE/iQjfO6OhlA16ErkvDmdBDsFYjAoYpo3VdoIE2OmFN/nuD4LRnEPqxSUbqZmWj73u/UxY7i0ioQOpovdMNW+RaVYqVnMkHZW861HDKDlK06XWArNvmqySppZwQQ36KqAgqxC2FCc2vpfMOM6qu2JILOx4nH258fXjkgD9CWSiqlWOZGF+OsQLcVaiS2hfx63htbztAp0Px6KAmlk81bJ19BwiMpeA7p11YagaNasoV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 04:57:16.0074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f88800f0-cacf-482f-cc97-08de6797b22f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978
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

Use multi param based get op for metrics_table

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 34 +++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index d58b0bc2bf78..b42d56f7e621 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -246,6 +246,36 @@ static int smu_v15_0_0_system_features_control(struct smu_context *smu, bool en)
 	return ret;
 }
 
+static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
+							void *metrics_table,
+							bool bypass_cache)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	uint32_t table_size =
+			smu_table->tables[SMU_TABLE_SMU_METRICS].size;
+	int ret;
+
+	if (bypass_cache ||
+		!smu_table->metrics_time ||
+		time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
+		ret = smu_v15_0_0_update_table(smu,
+						SMU_TABLE_SMU_METRICS,
+						0,
+						smu_table->metrics_table,
+						false);
+		if (ret) {
+			dev_info(smu->adev->dev, "Failed to export SMU15_0_0 metrics table!\n");
+			return ret;
+		}
+		smu_table->metrics_time = jiffies;
+	}
+
+	if (metrics_table)
+		memcpy(metrics_table, smu_table->metrics_table, table_size);
+
+	return 0;
+}
+
 static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 					    MetricsMember_t member,
 					    uint32_t *value)
@@ -255,7 +285,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
 
-	ret = smu_cmn_get_metrics_table(smu, NULL, false);
+	ret = smu_v15_0_0_get_metrics_table(smu, NULL, false);
 	if (ret)
 		return ret;
 
@@ -530,7 +560,7 @@ static ssize_t smu_v15_0_0_get_gpu_metrics(struct smu_context *smu,
 	SmuMetrics_t metrics;
 	int ret = 0;
 
-	ret = smu_cmn_get_metrics_table(smu, &metrics, true);
+	ret = smu_v15_0_0_get_metrics_table(smu, &metrics, false);
 	if (ret)
 		return ret;
 
-- 
2.43.0

