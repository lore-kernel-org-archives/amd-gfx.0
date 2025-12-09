Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6D3D3B7EA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 08:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F08D510E4CD;
	Tue,  9 Dec 2025 08:57:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hA7NdBWg";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B10510E4CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 08:57:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gA46WZ2lz+tx/XBrKUUxlAPrt8D7CCZCII7ciesVTsmtx8gGx80UQ9x9hk2wA2eprQk7TYHm4p9lS9vD2fHLp7VGDesZOh/yMkwctGQglDiK6eddLJjBJM7cRYnv3+mtkEgj7/t9PxL+OV7cH97VpstTZek5HC3b9OOWylMlj/6MCPGDkOPS6PqAHRYEVD59i5haR505iYWMuCDWTaWB7C+00EUXBpuFxDYlxKklAs3xkdeOJFl7IHmTz7dPsHJkAfPEu3nEKA6oH1HpYvS/S0S8+ouEZn2Tcuwb1EAClIH8J66xDj7v8q/OJToRADleDqyDhckqvqmoJi5uhRyrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUMXpkNit5LEZMwAyKuiSm+ZkQiZySH5bpKjjHvQt4s=;
 b=SYj9mXeS07yICROCh4MiBW0xHd3jrlLUy5dYZd2sE79vbnIOAEHNKk+CkNX41b8MaOGTyn3rEEWVT5jDo/A6GWvajbF/sU0KfM3Ax7FuqgYM57J8578xWhoK2it/a1RFaYjY3hj74gWAsQZ3X1z5sdYH/UCMH2TQVJHtdm58j8hPkcK8IKC+isW1s2cYNkZ+d8JUy8BO0w1/WfNqu6v4DAAXvky/WyM1dCLAJETFf3h7lh6L+EZY0OBrDzMBa/+DPAiP8CjUhZN8c0XG4lIIpe3Pbz+wUbAIBKXmFIa9R7X3sHRsL9WbsGBy8PhjXehrE8Eztk2GRxMkov4X5F6Avw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUMXpkNit5LEZMwAyKuiSm+ZkQiZySH5bpKjjHvQt4s=;
 b=hA7NdBWgInNi6mq9cj4IWExxOnZk9J0IWBGy37cGvCkE8cHn0ooQslqTD9vLlA2sVLPHG1KCkfi7D76uO7QATIynrtTNPtbIQnfLPoeYVM3vWGt6hcE2XIq3G4hUVUDWJG3oWQgQvbP5ig2AcDctF/MbEJR4SAKmgvCiwooqBxk=
Received: from SJ0PR03CA0061.namprd03.prod.outlook.com (2603:10b6:a03:331::6)
 by CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 08:57:52 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::42) by SJ0PR03CA0061.outlook.office365.com
 (2603:10b6:a03:331::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 08:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 08:57:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 02:57:51 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 00:57:51 -0800
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Dec 2025 00:57:48 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Oleh Kuzhylnyi <okuzhyln@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 05/15] drm/amd/display: Add use_max_lsw parameter
Date: Tue, 9 Dec 2025 16:55:08 +0800
Message-ID: <20251209085702.293682-6-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209085702.293682-1-chen-yu.chen@amd.com>
References: <20251209085702.293682-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 1812c975-4e24-4bcf-f811-08de37010947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JcTZ1Cd8iDTkI/DB/BQX49EaqqR1gEfddjnsSrDJ25ttaUwKyuRjocsimxcH?=
 =?us-ascii?Q?uY2bxaaHytiCblkkaaYFkcTGbWhvFKej51GtNvCtOkBPDdAr1yzC2/XsjHEi?=
 =?us-ascii?Q?9J1hXANHsPtYe3WmAjtwhDjZ6RrzjHmGgRQUx2SY8mDKc71MKqyt+hAZEcL5?=
 =?us-ascii?Q?zX59drm9E83YK4FCgX5BfwoJtaI909qC8f2tIwv3Qp/9iRZyREi9qo0Dg6IA?=
 =?us-ascii?Q?0Otsj1FaslztC5tvAl2+4rK76COZukeTw93CabOyxzc8J1aJRRy4/pQYDAlc?=
 =?us-ascii?Q?eiXiWf1SNLVTTwB5kcLS3klYd2K933tzOfc1uCLiGyMBDELtD+fUk+GZ1UV2?=
 =?us-ascii?Q?EDX29EgbTZLeYzX9cZjTIRQibUESR9jv51yBeShEu7yehf+e73eiajBVygIZ?=
 =?us-ascii?Q?RgC97lK78MOW0/m9d8rPxwBvDKywEEArS435d2ol6c8RgD7yX3bCJM/oauq/?=
 =?us-ascii?Q?MsPHC6tYC6SVVmJcEDl3b4ppiQ+UIlyz5XvSLweVlFflPCUqJIAlJWcnG1aX?=
 =?us-ascii?Q?QoGy1sV2tdJz8o5OA2PmM3VI3WL/NYre7C0jlsx0oK1b0+cjRBidThHIO52g?=
 =?us-ascii?Q?EzM2Ziv9ks8Djy3Z/T9AIz8goXmfMuyux2tPpuejmnyGxiszPgijnFW51Wg1?=
 =?us-ascii?Q?RrUy+5LhC3QzZxYNA4R2kKyMhgOxYbVk9qvN1JrRiD3XEw5Y+1M7t4mDzZgA?=
 =?us-ascii?Q?p0dQ/vWKBWWuxg/spMy91YxELMDAjQNcoMe2C+wVlBS1MZ00mL6YC3bZ4okD?=
 =?us-ascii?Q?aMykDXnTbu63jYHIOaBaosQ1Yc62GTqBEaFrnXDnoPZ9TSvbaJxBhSMC6ABk?=
 =?us-ascii?Q?bIbM4gDp8YJ3HNBt0McbLC8gUUy4x+7JNryS2QMsdZNxVnM5FgixCj7uHjGC?=
 =?us-ascii?Q?Xi/5LsQzg4mmzoYwAXJz/wo/51lUR0k6xFbnAXEFEtCSaZMI8/M1pJx+2FKo?=
 =?us-ascii?Q?335Oh7psT5R3lVX7OogMr2ROwEwsUYBjCIEqMl8LQIsZR7czqWpPFiRllTHp?=
 =?us-ascii?Q?gohwqiSb+M/SXBoLebUJt7ojL/oy9UDQkFt2dOh8eEGxFB+Zucehb95dpwA6?=
 =?us-ascii?Q?K0SKL+d7yw3uBxDemoblrz31IqIiS2JpZS+o6xUZSKzjuRt7fKZQA8tjl+hf?=
 =?us-ascii?Q?lq7Sg+h6ahCoS2yZIUCEZnK1vwxHaywf/+iH+15wfZSJzWPwU6W8nhm2E4re?=
 =?us-ascii?Q?sAQ6I7+hzZa1pqtHflK8YPnBrRwyOEwPcHKh5hMBzi4LWcqfS033P5Gj0awJ?=
 =?us-ascii?Q?qqm/01gn8Fs8lu1VTT/TJbnoulkqu4SqRdJwNbYNdY7RaGEbzxyhbjHAK0O1?=
 =?us-ascii?Q?boNF4rrLrC39MjG8UKZLRdULabgLfUzz/rK71W6daqjDm8vyJnvxO5PoJHcj?=
 =?us-ascii?Q?YCdkD0ck0r/jWxdEQ9/RttNQTv44lKwrrnJb4sF/tJzyEdroM1JsXIpmiPLB?=
 =?us-ascii?Q?dWBcSp33TLg18Xe3TV8VitSFQyL6cSAyohGnkowV0cG5oWXeSc6uiOT/nR1y?=
 =?us-ascii?Q?mevtNeJEEB9TqWsC/65PSG+UsVSsOSCOXs6qmVYamlJV5SSlUCcDLH1Z3gzG?=
 =?us-ascii?Q?HmONqU7z64qMY/hF1y4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:57:52.2055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1812c975-4e24-4bcf-f811-08de37010947
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353
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

From: Oleh Kuzhylnyi <okuzhyln@amd.com>

[WHY&HOW]
Add use_max_lsw parameter to make prefetch for linear surfaces similar to
tiled.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Oleh Kuzhylnyi <okuzhyln@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h  | 1 +
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
index 35aa954248cd..b44762e21550 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
@@ -407,6 +407,7 @@ struct dml2_plane_parameters {
 		unsigned int hostvm_min_page_size_kbytes;
 
 		enum dml2_svp_mode_override legacy_svp_config; //TODO remove in favor of svp_config
+		bool use_max_lsw;
 
 		struct {
 			// HW specific overrides, there's almost no reason to mess with these
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
index 1087a8c926ff..953f40fde1e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -1950,6 +1950,7 @@ struct dml2_core_calcs_CalculatePrefetchSchedule_params {
 	double Ttrip;
 	double Turg;
 	bool setup_for_tdlut;
+	bool use_max_lsw;
 	unsigned int tdlut_pte_bytes_per_frame;
 	unsigned int tdlut_bytes_per_frame;
 	double tdlut_opt_time;
-- 
2.43.0

