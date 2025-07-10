Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A69C83F20
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 21:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A3C10E967;
	Thu, 10 Jul 2025 21:30:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GTJc+ue8";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0B4110E965
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 21:30:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSh/QUrb2MCY/ibXKi4hxnskXfH+3D1wn+gPavBxShKtSpvEW2YAh8sK2Gq240pKo/gJa4quMu5x2oMmTd2GHKzpFJ9EnYk1EUBX+5vzpvos7dltkkYE89rkp6OwmfkLifU7RUSgdA+kBtr4Zycy1kzmRqpWkN3olzOB5ZBCDe4LlTUPXEcqFs6yHe82umZIzLNfKW4S35POHdffDEMM+8MRTPsPwGKq/f1GR2zUAejftsjXVD5WJvv9iC2I0d4ZP9UY1YILjDNyUdkUZSILQKgpJTAyTdXLN8XBlU48sZ3h6Src/ki1IIRj7R6eH5YkRY1fruZgbZxomfLtCNRgAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fg+X7FCgoRyB3MKbuBIdkCsV1jN0bQ9NVd/0dCWOiJA=;
 b=LGPZ4nKZV3GQZJ+y5YCR8WpT4S7VN86GJaJIQYyy1EXqEr5cDxU/NY5OouRoJWrQ1ExYpoohcY7zXDWVw159s14mmbXOCMyE/DJu0Bc8aX8beLCqSRUdysxeAFfhAVJrGJWmR6RhVereStt9TUB1jCn0QtHmbK2veA3RTrJ2I69Zq8niiO8KXle13JlnS+3ENWqnoDwuTPszJ5v60VAxnZtKP32Y0xVH0hj2QGvFD69nKc8IhG/syle11zF6+BGdygc6nGpk7bMgg9RVSY/HnzpypCI+ojKqnyInetkV2pcf1ey2PiJtZsfbcg80L7ekfxB/lV6x3V/E4QFRHNy2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fg+X7FCgoRyB3MKbuBIdkCsV1jN0bQ9NVd/0dCWOiJA=;
 b=GTJc+ue81nER24hcss1UstXIb7XY6hEsRCdbXJAPsWsT2nRn4W/Ite7eSXvCJRbLTlYvmmTXSIk8hvhZq73rsmFgS9fpCvVMNqebh8bhJv21M66MfKZBIgFzuPph/fLeCIteoCqCQpMWgEF1XeoAY8tg0bnZZBFp5wzjszLA4Wg=
Received: from SJ0PR13CA0186.namprd13.prod.outlook.com (2603:10b6:a03:2c3::11)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 21:30:49 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::a5) by SJ0PR13CA0186.outlook.office365.com
 (2603:10b6:a03:2c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.7 via Frontend Transport; Thu,
 10 Jul 2025 21:30:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 21:30:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:30:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:30:45 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 16:30:44 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Fudongwang
 <Fudong.Wang@amd.com>, Charlene Liu <charlene.liu@amd.com>, Jun Lei
 <jun.lei@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 05/18] drm/amd/display: Monitor patch to ignore EDID audio SAB
 check
Date: Thu, 10 Jul 2025 17:25:38 -0400
Message-ID: <20250710212941.630259-6-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b77312-2591-4e9e-f3ae-08ddbff909d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qePI+dsRfRYxQkmoNnAj2YPbFmMWl+EyZjdGQs1EfC03vFKll7qZmjTQcnqc?=
 =?us-ascii?Q?VYC+TJ65olSzdr4VhkNeP7vsqFH2bDYd7EtkrbAfdS+b4sNgy5OHAQ+EJC2x?=
 =?us-ascii?Q?fyisgruPhDvTOFEZeAG5SQSp/wiAZUKhgLTgBx1lTAvhoj2PGbH8rC51ohK8?=
 =?us-ascii?Q?McAnhKeUp34P1XcVrOsFhou5+sFoA38O6tJWszYbHuUeHHENLK7tCtOsufJ2?=
 =?us-ascii?Q?It9O/fTWmXdPCk5vTL9VlGC7Qt63y8ftmYopxXxlEGXDnH14lgopAnJGdeyN?=
 =?us-ascii?Q?G97yEByRd+0NTPw6pxRBUPIirWHcCn6C5rAN84/cvasrZm2qHRik02Mpwq94?=
 =?us-ascii?Q?of4j0ZYX6pf0wE9G8c/Dqm2SakaC6/0rBbl0Ls/pyu1YKpyKGhtB+QnlhWNM?=
 =?us-ascii?Q?mb2qnI66JUw/i0ZmCco8Xr1wgdJ5EMlzMydx+ZvGtBAGm7V1MnUsTcWfRKix?=
 =?us-ascii?Q?Ek3qj8XjYmCnMW81Nl5Pu8JbKNvb4XQ3FaMeh8ZlbEVXfU+MqMpfEVqmU17m?=
 =?us-ascii?Q?M3UL9MCT/I+nKxs6CuJ3/YOswOo2PFOrBw+EfNmG7JuiysYtdGu5O3FcdLP3?=
 =?us-ascii?Q?ZrwfNP8i1xV+SekeJVIlC9iu+QL84+qA9HqTUB+cSpsVahHUDzM01YWJat3N?=
 =?us-ascii?Q?nZ1TN1BeNaGZ5sEd9GhyQilPjd2JFw3to8ECHnPNzH1N2vFcm2wW0cY2VlxV?=
 =?us-ascii?Q?suOITWOYcM4dAwrWfDxxNT9KiCnq6YIce7WmaXDxwvo0Y6Yh2ajDLWn80PYJ?=
 =?us-ascii?Q?fPVVMxrppFhkhULs+j2o36fr+tbOWJ7amOAnSfWrVeIzZIvrBYBLAGLMOdAZ?=
 =?us-ascii?Q?EcaQlndvbAJWR8SvzMbERx1TdBxHZ5f28cZ4hgUvruM2wtKQsQDX/rA8nVZ5?=
 =?us-ascii?Q?MUvkIC+cGw89CA7dMMtBryxMQZtp+9FLds8mS2KoY1dMBo3fgKgbsXHjBTDi?=
 =?us-ascii?Q?CG1KuLaYqGb6OLPYmvk3W1vEUipEoyU6N4phw/Q12OReN9Fm7SA9ECe9kgnC?=
 =?us-ascii?Q?26C2jE3jLJeHkactmNWNBHlx9jkAtEDEVxq6h291PDudHIWRNmAxqVyMRH5J?=
 =?us-ascii?Q?UZogW1IFQKHamay+54JVVNeDxhF7v5Gz4PaaPIceMXi/N3qQLQvO8mzWmRS9?=
 =?us-ascii?Q?nE23Co7NUk9NA/8OTlvnaUOyDZKtrQ0KNA0nVz1L6Gmr4DLV75i8x1FBmpGI?=
 =?us-ascii?Q?Qpgv7TOo6kebFV0lDX35oif8NWWBjODOqMsiHtVqTBm0W/LzdgmpX25cyRat?=
 =?us-ascii?Q?1mLa+loDck8ru0eqGs7MnEaak3igVEGI51m+SquCiQIKVXtWSZmtsZ9aoEMW?=
 =?us-ascii?Q?oy1Olq4/EZHdedsoqr3y4b2jYA3sMIwW6GvJcNQD3cEMUgEy2oE7VjsHIN6S?=
 =?us-ascii?Q?Nm6xDSx5QjoNlg+L+2aOT529yT73ckZ+bimMZvMxi90epTTYSQsIHi+T7xLI?=
 =?us-ascii?Q?C7jPPrkjoNTBfT1YldPNUadPQHJzsDw7g73hCFErbdyMjWQSyWwGzPdy/KK5?=
 =?us-ascii?Q?kxGQ87tkoPbUO/OvYbChGyYpspP7zGmD7tvI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:30:48.7958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b77312-2591-4e9e-f3ae-08ddbff909d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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

From: Fudongwang <Fudong.Wang@amd.com>

[Why & How]
Some monitor have audio output but SAB data is zero. Skip
check this in this case.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Fudongwang <Fudong.Wang@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 +++-
 drivers/gpu/drm/amd/display/dc/dc_types.h         | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 854fc51f159c..4d6181e7c612 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3940,7 +3940,9 @@ enum dc_status resource_map_pool_resources(
 	/* TODO: Add check if ASIC support and EDID audio */
 	if (!stream->converter_disable_audio &&
 	    dc_is_audio_capable_signal(pipe_ctx->stream->signal) &&
-	    stream->audio_info.mode_count && stream->audio_info.flags.all) {
+	    stream->audio_info.mode_count &&
+		(stream->audio_info.flags.all ||
+		(stream->sink && stream->sink->edid_caps.panel_patch.skip_audio_sab_check))) {
 		pipe_ctx->stream_res.audio = find_first_free_audio(
 		&context->res_ctx, pool, pipe_ctx->stream_res.stream_enc->id, dc_ctx->dce_version);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 229a754b7b6e..375ca2f13b7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -175,6 +175,7 @@ struct dc_panel_patch {
 	unsigned int embedded_tiled_slave;
 	unsigned int disable_fams;
 	unsigned int skip_avmute;
+	unsigned int skip_audio_sab_check;
 	unsigned int mst_start_top_delay;
 	unsigned int remove_sink_ext_caps;
 	unsigned int disable_colorimetry;
-- 
2.43.0

