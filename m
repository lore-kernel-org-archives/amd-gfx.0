Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AB2E8B364
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 03:07:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E153C10E360;
	Wed,  4 Feb 2026 03:07:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ywj6bMF+";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26E9E10E34D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 03:07:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWu7/lQAkx4INK7hkCi9sa6U6YQTGn8qenYRS17Mw6YMGbIagqlPm2d/MYhXiW4dmUCoBxTMrphUni4c+l7ezYOqpLryuzF/lVQ+CptxhZE/yJjq9dUzcPZ/FEQRX9DZMybZ1Mio/SVqC3uGqVBSYK/z+vdheOzFAiUi1RqpTaCjXWdD/i4DUs8GsPn5EZMhNN6hdCxdDLuckkH7Gr510GIIGcjbeOoE9CW44GBe8ucKEnweeU9KcfQ6BW9nUwa5O4ne2i86Jg8M2HFM3d61eEZQ+ldjEY10CvqwzqNunnu14ttFfq/qihzth3FaC0405HUGwd73Z5srSa+Ca5oYfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LB9C63j85QFrS5+b/F8tzH0O9Bbdvglbd41mr4fip1w=;
 b=Cy0LGdMoti1xsbabVBvWFKRnhbmtalhZGjVNyMB6rhhcK43SBIQ6bOSgR+erolMs+3W2IpBAnBG1VYB20p0MDJwVmV5GFlOWyVuqjQ1TKPOmvs52IdKF6C4BQBjcGALwnu91CnaVVyH5KUUQ2GB8F20Nyt2V0xpDg7cqiWtHDBpJiJ4ZD+t07gwcoOflkEq3nyUemohTCIgzHjcEUdvA5/dVzteDZ1QZmNireiM6RcMxSIfC/lsUKgh1O0pZg4x/D1m44bHp6htKqix2N9nSXu40DLrhz85TuuR39qdpn5EF04ISeBYySuin3s5DePRHTHgH0VJ8I7MH/eRMCtCBpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LB9C63j85QFrS5+b/F8tzH0O9Bbdvglbd41mr4fip1w=;
 b=ywj6bMF+F6YQn2gxm7pNFRgxSUej/pLlmo69H5LZ9h5QBAJy8rPNdZcypw/6FCBmWJcSBVQQuvfm6iKSjKRxK3as9dCxnVAN0p6b9ZL4vwBohiQcO/i64oySOcFG5G3WwnihPvz6mmWavWVsPvfNwQOQF5KS+J9BvXgvuiw3h60=
Received: from CH2PR18CA0004.namprd18.prod.outlook.com (2603:10b6:610:4f::14)
 by SA1PR12MB999086.namprd12.prod.outlook.com (2603:10b6:806:49f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 03:06:57 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::fd) by CH2PR18CA0004.outlook.office365.com
 (2603:10b6:610:4f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 03:06:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 03:06:57 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 21:06:55 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 08/13] drm/amdgpu: Fix is_dpm_running
Date: Wed, 4 Feb 2026 03:06:15 +0000
Message-ID: <20260204030621.33369-8-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
References: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SA1PR12MB999086:EE_
X-MS-Office365-Filtering-Correlation-Id: 531ae863-1a3c-4135-dd2a-08de639a752a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c4IUVRNVIJ5aIIaYMcgaEcK5OF4bnneBTpSL2kyondBUvrwSiOusRKviKgIS?=
 =?us-ascii?Q?9z2H9YNMDgVVeBgxo8tPDlq57JTTnW848LJgBqajiIQzY1goUXSHZHYXv67T?=
 =?us-ascii?Q?obuzKJPLqWh8kBHbnUoBrngnHK8ltnskZk5VdvCf4GIejL4wxCd4U+se/lJf?=
 =?us-ascii?Q?l9ZTS9MxSzjN2gfM8JXZnPAVEV6W8giCNVtG1UfZgoLYNH461LAD5qJY9gHQ?=
 =?us-ascii?Q?KSBB23voYuQ+1NzDn5UZPLeBe13GCkqoJMpoc7tO/Ucj1bAXK0J4hdWK8hlQ?=
 =?us-ascii?Q?xY6e/p4N34bVDGtZDTzRwbkNBETyhmMC+gGeY5faxbg0kWR2lnzkskoWLCRN?=
 =?us-ascii?Q?1pX+SQDto/n97pZvm2tI5e3pF/DWUj/+KrUTRO37DPtnFpU/Ad0TsW+nvZ/R?=
 =?us-ascii?Q?BPvrGFCHVYw7Kx1sfaf6qV6bujbej3o0veZbFge3EhdpULwBSTyOwNlknw3E?=
 =?us-ascii?Q?En6J2ByqjzTdNPXxfUbqRK0hLZdmndJC6CjV5nbjXscTwi2d9Y7GE9xpB+PN?=
 =?us-ascii?Q?qbMTP3IudJpuZHokBTf6gREaENWghveYAv3AW5CNNJWPyrg2IqwhRD/qg39Y?=
 =?us-ascii?Q?fkrWbHZ5gHZR/bWXSb0np4xvTeMVHJL9RNiSSUP4vj4n4PeQPbmQ+Ecedkyr?=
 =?us-ascii?Q?7zVgp/4hqd7ecIVNgA/dJ76jg3P6WOr/jPvR1XZHxgyFQ5MulpVngPKszAIx?=
 =?us-ascii?Q?/KW05O7K+xTbw6CiytOV8Vymmdim99BgTUfw1qx5lD/qVRW5iniYWUv75K3A?=
 =?us-ascii?Q?EjVbvSESgRxsmnxna5vcNfNvqMe1alRa1CZTLKoJR2kNYsyYbITFKwwVUKfF?=
 =?us-ascii?Q?w0dHdVn5QkXiBgCX0FGg5p64VQRhuhBQ6FRdQpJP0do8a9J4eA2kOaGHaV0N?=
 =?us-ascii?Q?CR2raDCmemkfDKMsuSoctL+BqGDfuuR8VXMse1/aVtEqDOBk56/7b5PCLhmc?=
 =?us-ascii?Q?NoJkOuG961bdvgJgfPoOwGh93j4tEchGkm3Jerb8x0cXAsWP8MT8q7P3F3Xy?=
 =?us-ascii?Q?VH8SO6ZCkPfh1MeT9veabQ+x7GDQy1F2TatEhRddK3tcwIkEWAjqx6DwG2tz?=
 =?us-ascii?Q?jU4hhSRFhqB/7D4LR3/UnF6J2ssMle01+g+CAfenwQspIG9lPwCMEfNShHbc?=
 =?us-ascii?Q?UDA3Q8h6M+SrEYh8O5P4izRavanKDetC8wA7RNplvKTWPIKbUR24REKaMCzD?=
 =?us-ascii?Q?IkQfCDRtEbh+r9VpFQd1bOc6rZveCSsg5ROyvkRT8+ez78PapoYFSoU7U97s?=
 =?us-ascii?Q?HS5eVzyRMhessm2DfIyAB2JXEnThGnX2VXU1yuxdM0gt9JtzYxF1ygO2BEbV?=
 =?us-ascii?Q?CczgbEPkFtJpPNLIBL0pnWuBKM2mX2Icfa49Axuw4gZHe30Ynv0GwZOh0ycD?=
 =?us-ascii?Q?S6FMPjFsIjqfT5Ojo15fqgB8iqr5BQAq4tFCrcZSrzrKLQWqW5CUVcxxodJo?=
 =?us-ascii?Q?QK8CD54J9tdaAFC2+eTdIfO7OH4HbVL5jg/vO5RPjgHcxLkA7MsJIY50Jrlh?=
 =?us-ascii?Q?xlVJ/gbfyrQBeTdZZBrKXF/Zf2wcILsuzlqx+QeUdqA1sA6w3Gz70xsX/F6k?=
 =?us-ascii?Q?dExdGPY1C1QlZHdnRFbONUcfDnrph8vfAhyYUzVRlpH+mwMLmsKp7CYgHjRe?=
 =?us-ascii?Q?UBySt+2CfVWdI56VY5XFxShtnGRZcB+W0Xwwl+QFf8TnqvOczpX7YNFyFZcM?=
 =?us-ascii?Q?hitGCw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K8Qokp96VYYcXoN2jLBI4Zc7XEDZHoYZscx0IAI0nV80YDSX38b1HtD5CA31IR8MCLZ9MlMqa24hOMYJMORXXYfzNwnMG9I/b8AfufHzJtVWxrJ0ge5Hx6elBjFAYSp8GOyK5MI7f2Go8kZN6DT2hepM7K5zV1jpSSGgt+ixy29QlzDgIgpNK2edGjtiUQOL26t5DzMx1UzJb1Bfe3cgGacDE8vVgqDJ5XJtCCGZ0D3V9UiO2k+4znxhu2xacH2iNOwzUlQ/AOZixHJULrLwtYd5yL+9xrorH7GDa4KBTX1E/HsC+PxnIiXHomlA0YTG1WYxvh/15OeG8fkIQjT+Ojc8/t2ej+aFeE879MQSvi+fic6VvD9xt26iXdY/J7ullo6K3HwI2iTNvEPF5MOwKl5ax2r57CM6XCZSyt0os8i9+kEkLAFtYJka3Vz2/OyC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:06:57.4510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 531ae863-1a3c-4135-dd2a-08de639a752a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999086
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

Use multi args for get_enabled_mask to fix is_dpm_running

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 2987ff1b13e4..53c96b80f782 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -479,12 +479,38 @@ static int smu_v15_0_0_read_sensor(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v15_0_0_get_enabled_mask(struct smu_context *smu,
+					uint64_t *feature_mask)
+{
+	uint32_t *feature_mask_high;
+	uint32_t *feature_mask_low;
+	int ret = 0;
+	uint32_t read_arg[2] = {};
+
+	if (!feature_mask)
+		return -EINVAL;
+
+	feature_mask_low = &((uint32_t *)feature_mask)[0];
+	feature_mask_high = &((uint32_t *)feature_mask)[1];
+
+	ret = smu_cmn_send_smc_msg_with_multi_param(smu,
+				SMU_MSG_GetEnabledSmuFeatures,
+				NULL, read_arg, 0, 2);
+	if (ret)
+		return ret;
+
+	*feature_mask_low = read_arg[0];
+	*feature_mask_high = read_arg[1];
+
+	return ret;
+}
+
 static bool smu_v15_0_0_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	struct smu_feature_bits feature_enabled;
 
-	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
+	ret = smu_v15_0_0_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
@@ -1356,7 +1382,7 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
 	.is_dpm_running = smu_v15_0_0_is_dpm_running,
 	.set_watermarks_table = smu_v15_0_0_set_watermarks_table,
 	.get_gpu_metrics = smu_v15_0_0_get_gpu_metrics,
-	.get_enabled_mask = smu_cmn_get_enabled_mask,
+	.get_enabled_mask = smu_v15_0_0_get_enabled_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location = smu_v15_0_set_driver_table_location,
 	.gfx_off_control = smu_v15_0_gfx_off_control,
-- 
2.43.0

