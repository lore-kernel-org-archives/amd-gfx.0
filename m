Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679A9D35660
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 02:00:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01EA310E603;
	Wed, 28 Jan 2026 02:00:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D8LT3zwB";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013046.outbound.protection.outlook.com
 [40.93.196.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7061710E604
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 02:00:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yn6DH5Knx+fjA2XOmLWRoFPAZfvmFEPfiRkuEdzhf73BVRQYDSvZVc4oOS7VB2gKElnq71Q4W8ns0Iu50tClWTjovFTRvAth0mb/GMRPtOV0f9SuV7jCwQebWBF97EfS6HWfasAJOsMoRCaWWiEevAa4jeYOn6aIkS9Z1kDDC4ZQRqx6xxKKEmpyGxbn+YDjif3zwlJYYxUAPxGNKrg6TmQVSzN6AC8qNrs55oJKs2RUIOzSDE2icXpXElRnjZF6Kw8u87gfYylHE3ZtEU2IYj27pxOeLi9K8FJMZnU+0gs8NLyXW8GdFnqpNDV9d+HOnAA1K8kiXXQctdNE4yyJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNpcUAYDCUvV8zH0BJLknt7v4qzw6PEcx2l9bC4nnSg=;
 b=NHL5ZW/T4EePcf59uNATNDc/rm2mNqVGBrN0U1VVXqUTNnVAd5RFcgr6bplZ4iD7CP5hjh/HwsbWkRrdG/wN0NoTB0ZJw7Km/fXYBpZ0gMpyhGOw7JtaAH+mnmgKYsNiz5e3q3RSkf3kNw3TZJxWVdyoH97S3rdKohFf0JeLHiLt86BKjnIy9L4NwxvyRFoz8BtAuP9ECfZ6mggJA5bLLLC4mpYsiwTm3Ijhp+/PemY/q5tFstbr87nJBSXIeeWABpx4mBuvunapej4cG1EbhK6J4M13ppG9UVwzg0MqCPQn8raKuXA4pcC7JJYij+HVvAB2OYz504Qz9WYCtUGtKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNpcUAYDCUvV8zH0BJLknt7v4qzw6PEcx2l9bC4nnSg=;
 b=D8LT3zwBFZZlqWpa8RpzDNMYdt5WDRH6eSmlF6ORhuR6HTAswREQ0CZe52/8SqE+Q8IHfRTdDNT7DG1XQYXUb3RJ7PN9yRAEzGz3O1HdKdbzb3tsNuRvpAaB0UTf0bnyBJB1DTUnY4R6v839Cqq9irlx9eEEAKF3TkpwUAVMlmU=
Received: from BYAPR07CA0049.namprd07.prod.outlook.com (2603:10b6:a03:60::26)
 by SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 02:00:49 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::b7) by BYAPR07CA0049.outlook.office365.com
 (2603:10b6:a03:60::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 02:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 02:00:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 27 Jan
 2026 20:00:35 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Jan
 2026 20:00:34 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 20:00:31 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 20/21] drm/amd/display: [FW Promotion] Release 0.1.45.0
Date: Wed, 28 Jan 2026 09:51:45 +0800
Message-ID: <20260128015538.568712-21-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128015538.568712-1-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SA1PR12MB9545:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6dcb53-7795-4640-27c2-08de5e110ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V9XqNMgdU58ixH7JZUAtiZL/BktLmUV4dPB9cwwAFycKinr1cH4SYJwb8w+B?=
 =?us-ascii?Q?dFeudwUDnMdSq8O3DXtGiMAiT8RoocaM9N7yndKuoIX9sGhPd7RM6HOZWKLq?=
 =?us-ascii?Q?7OHrLMMfbpvzAKArVsMtLnO5qU62vPhtA3kBOM7L96Q7tkw+TgSakiJ/1ny7?=
 =?us-ascii?Q?OQu/DcMj9sn8u3rYURu7VtGPhvWZo5SkbBm6BqvI1B4DZhQvYUs26Fjgmi9j?=
 =?us-ascii?Q?jcPWPqDczTGN3rj8uoW5py3JnpF1Kvk0B2UMWpCG0s2bf9gpaasysXxWUMFi?=
 =?us-ascii?Q?smm90kfTcLuunW8NLhRNy1VhzEhC01NYnw7Ub2ZnN8QYq3FjE0SHLqchGyke?=
 =?us-ascii?Q?PH3UlRKXvQM7uhw83BvpIactfC7P4hPb5E5jSb54mWXXv/9iCe57BcS7Zh7A?=
 =?us-ascii?Q?Uxi4odRHTffiLBbG5CaXldVMe81+zO6aeMcHBuMV8ZzB6HLD/oXfMOUGNId7?=
 =?us-ascii?Q?mFwp0UVu/HDXfZ3IM8PyZHcQnVwhqLXjABpt8Q/ZSAokMPjUT8BvP6OnYRqd?=
 =?us-ascii?Q?E66Pe4sCZPc8sFCManHC25lwOwxgS4T3xbecVaqEZar/0Dha6l0aqQLJVLZF?=
 =?us-ascii?Q?AoJ1sdb6flU25fl3NQVD0lwKEYVbo0xS6uv+qtPeNBhhvLStm+89EP7hEvJK?=
 =?us-ascii?Q?YVA+5ym0e8MVHFRnfYiQFBGrrZgrQrbR7mKEGPK/VzSJJaS22LHYTF2rNpii?=
 =?us-ascii?Q?jmRSvs6CbXG63tLG5+guOP2BoakdqFUAbhcgJS4wYehVBLtWcaWfI8iLVvZR?=
 =?us-ascii?Q?o0s7AlZB/iHDyS+uUtTnspjrnm9pAD2DCEUcqnmHocCgsKhAhz8Yks73IFZ+?=
 =?us-ascii?Q?OSNJ10UMuv79LF3U1ZM/IgiFuVUslzgau+7v0THdFCGl5lSyZT8ZtrRuWRG4?=
 =?us-ascii?Q?WhXBZzAckkLu77F0KLeituAU0dbYXEPN2/WYw8yfWhSGaAEYvruTXweJZHFo?=
 =?us-ascii?Q?NFiGjLPYAOxigT1Sr0LAOTOWidMNI6wAZHXbpI/PgN9v1W11dvAwXMVYoE7/?=
 =?us-ascii?Q?Myfw7I2mx7eFTPgMLeIkuFmdTwJvdQCQmyr+q6bzcD81vDIoE4wKc7hvlJnN?=
 =?us-ascii?Q?DZtetJq91PFwT4wyDpc6yAAE8zJWMiMMcLtENa30hPT9oiQcBF4g+zopIfkw?=
 =?us-ascii?Q?3GxbzJBnW8eNA4RFiLXPOVgSshtzAKl4S0jhR+EIScfkMw3kP/Gdjnun0aQ/?=
 =?us-ascii?Q?BW96evAgN0ZtSIq6L9NbX9SAySN0jabDlJpBJIwpWgBZxEAVulxUKTa0y3YL?=
 =?us-ascii?Q?pq0A1I05wrseCda2QLdprbG8qboQzJTvNjVoEBf7gu11SSu2m1mGclhty04u?=
 =?us-ascii?Q?1GnQlY9uZa5Sxx8ezhTBsbYyC83ILHTj/xP3dbQjaekqUVYnGym6hhEGGcrQ?=
 =?us-ascii?Q?kshdZ+eeIe2GrQ7Pk9AR6DTiOgXIZ2ZKgPB4DpBvGcLxPUnBQWFXQF8XO9Bj?=
 =?us-ascii?Q?VNl2a7zTUWu8kObk0xpvrGMbGFyaClE+AO24uXEWUWw92TmJ5Nbht+vNN/Fe?=
 =?us-ascii?Q?CI2Imdxs9czc4IQ0yfUxavM9glkszlq/zcq0t7Fygz2S3BU0r0gaa4OS4/XJ?=
 =?us-ascii?Q?4NYJQ2g6868dMrFfB0FofLTYU9nEdquTofoAjwjiK3cAZfN12jxhfnP7uX85?=
 =?us-ascii?Q?bp8YA5VeUaweEPnsbj0ezGP/DmUB0Ae3VVYZzBzB18CVzE4C2cUwgHg8YUjk?=
 =?us-ascii?Q?3SHDbQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 02:00:48.6114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6dcb53-7795-4640-27c2-08de5e110ead
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Add new enum definition for panel replay ml activity options.

Acked-by: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 18e0bdfd6ff4..3b4f5e990ec5 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -736,6 +736,16 @@ union pr_hw_flags {
 	uint32_t u32All;
 };
 
+/**
+ * Definition of Panel Replay ML Activity Options
+ */
+enum pr_ml_activity_option {
+	OPTION_DEFAULT	= 0x00, // VESA Option Default (1C)
+	OPTION_1A		= 0x01, // VESA Option 1A
+	OPTION_1B		= 0x02, // VESA Option 1B
+	OPTION_1C		= 0x03, // VESA Option 1C
+};
+
 union fw_assisted_mclk_switch_version {
 	struct {
 		uint8_t minor : 5;
-- 
2.43.0

