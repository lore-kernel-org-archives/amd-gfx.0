Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0035ECD1283
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41AC811253A;
	Thu, 28 Mar 2024 19:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wtDIOJ4r";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC6F011253D
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtM6qMRE48CEce23EF9A+dvLHw+rzdMGRgs6GTfzrOrTIAPzArmYZRb6zTWhiBAFLgyzPCyq5YXFyFx00xhorzzb9MggqOCrfQ34luTJVyFsbtk7aC59o2lYK/Wf/Liypc4q3nIlmoSl4LY0tI69gy92wvENKgkV0gpUb0Vln6AvbbjduHtJsCX95KsdlzZf2NMolfAm2ZSj/pgvikLCH7Qq9l9T8SHRiFlQqhqjPvqSc7fnSqJaSx2YPD/L3DA5KwxHVHRdVaqQdXQ311sOcsYAFR9915B2KvXve7ZYx/5AS7yQhGWy0+k/ZO84Bn5dyHLuxpKK2iNaDjOA3fi0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MD9NaV7bh4GYQI3lM7dxBwDSn9HtvMYK7IuPl7T+8g=;
 b=aj3X8m8Qk82rkMKcYzTtZlR6P1YHktBwRP8s34tcXn77h5mQFUsch0pp81VZIwOkZiN5RRkTbPcJIw+XdKvsAlbzWEIPxXpzbIgqcEEwdVZk/L3+d4uie27sv5mjqrv5eQ5rBxhTEDKFKpM8zmaMEfxEmCodqMuRBEWFuaqpkBVQzL85Njp2CPLp6K+Y++FXzbX4yOywVGWzy5V9SeY7xFRPztAdzaUF/pn0sIuD0XBg+F4R5vgqYZN2HlJVquGVfuLnDKuq4Zi0Xgzj9Nay9rFvA6CNJ8pRNTC/udyreTQa1IE3boyvN/u0mi18dJhmAaF/RAoK9Xkul3W/N5pdjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MD9NaV7bh4GYQI3lM7dxBwDSn9HtvMYK7IuPl7T+8g=;
 b=wtDIOJ4rM7WRCp5Y0mm5oLXmgTuRWtaraeqs1hULen+U5f7vK6d1OUOnptEjS57TFkojvv9PAA8DnFNB+9m7NGTYuI2lgmWcCuAMxAnr9vLNdj9PioVMtlQPfttkYaFfie+unYATrJDUVoWtc+eBm51uy8lz9x7FhSPmHyZx8eo=
Received: from SJ0PR03CA0343.namprd03.prod.outlook.com (2603:10b6:a03:39c::18)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 19:51:55 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::6a) by SJ0PR03CA0343.outlook.office365.com
 (2603:10b6:a03:39c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:53 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:52 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, "Xi (Alex) Liu"
 <xi.liu@amd.com>, Daniel Miess <daniel.miess@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 20/43] drm/amd/display: add root clock control function
 pointer to fix display corruption
Date: Thu, 28 Mar 2024 15:50:24 -0400
Message-ID: <20240328195047.2843715-21-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ebb6fd9-aff7-4d97-e227-08dc4f608514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5BZvOwwW4N9fKDK3W47z0m+tJv9MXKE9h7pSGKxpOEcdhgBQbmrwH6q/COLbFCdr0qRAUtivkqRnuQzN18w65a/x6toUVaccQ5l/q2k3vIunR1JdfZWAJLHoLSFPmwv3/IfDIjHlKiqMEchWOUwUBRcuz9X55h8u3qrcbJh21LdHPkPwW0rc+qaIsjVMJ5y/XHrkyVe9nvLwenJA6cWN3YXn0iIPOUVMvkSSqzImxWNUEvdW1M+Z2eoX4UTnmfI0+j81ErDvsw+EIH5Sn0SfTZqLMPgBlUM0dfrBOHubn/T+gKR/So1kp4VTVr5j0pKSVKUJsLwaTAZJVZW0oSz+SuTXYQ9EJ8VS28B+qkEadh6mlk6D/OP4M35/VCztTruVXtbdPiaSpcYLi+hMFtkR0Je+nJCw/iAE1cc/SnCj3f1HJqAYhbna8g1pIvbmNefknQl8l5Tei9vdIwtTIWsJ5kgkijsDTHMlEQ2swVb+EYErH1PQbITiOabpKum4fCIBELiAsYYncozbId+TZy8GlFqgt6rFqaEPqJjhxiR1PmbrBt42zihBUX0qvDhs/j/emu+SqGh141TsARAnODzrmYk3BvYMw58P+SnPCpPNvh6rn8FspdmqCg0m5f8eYa89FN8PAjzOXGry8/8cVwuPJgrG3S5cM4leuiGAecJuSdcWUMu03Y0IHbb0SDPEVHFv5KbxW6OZUSj5Ukrg3HnKvCssUZrEkn0b97nnCzxEZblSKBcoxHYgNkkADG+c6zom
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:54.5617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebb6fd9-aff7-4d97-e227-08dc4f608514
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
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

From: "Xi (Alex) Liu" <xi.liu@amd.com>

[Why and how]

External display has corruption because no root clock control function. Add the function pointer to fix the issue.

Reviewed-by: Daniel Miess <daniel.miess@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Xi (Alex) Liu <xi.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index b5f4bae16177..c54f3518c947 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -145,6 +145,7 @@ static const struct hwseq_private_funcs dcn351_private_funcs = {
 	//.hubp_pg_control = dcn35_hubp_pg_control,
 	.enable_power_gating_plane = dcn35_enable_power_gating_plane,
 	.dpp_root_clock_control = dcn35_dpp_root_clock_control,
+	.dpstream_root_clock_control = dcn35_dpstream_root_clock_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn35_update_odm,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
-- 
2.34.1

