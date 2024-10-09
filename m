Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E6CCEE342
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 19:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5654B10E7DA;
	Wed,  9 Oct 2024 19:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1b0YZa8O";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4BEC10E7D9
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 19:25:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y618G9XarUparNzYw2O8w4CPMbnRMYQcZ7uX0fyvlapxsaPNe7wbtIT7RX8MbN6K9Vc5b8Ft6uxEojxqWTF4GA3iQlmulDo69PskVGkkiU0wq6J23UxbBIJhCo2DpDju4aGuY3Pxwlb/E5LvaMXjUf43FAFTQJyNRYD3aPhTqSFOsG6CE21Mw2ihOs56p16xJiOE3P+6T2GfeHegHxQuzwZxDTSOAtcCNK93edYlmVZU4KuEfj9C+pPHyBc+BheLkoLEU6fBmqZezgtGg0CzCwiNKHAozozhDPVeOGWKezUTyTANqRzsbsfEfYd7CAehxVTAaRIrzByUkotUcF3cag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lh11zNEXMmdJ4z3g/Y+OISeh29AJuNtuPBqnHZ9qyBw=;
 b=r0wrLL8Oqu6ZTLSFXfOTK9mkpw5pUIdMlCgucGNjXuM38XNj0k3GGRwCYlGnfjkENng5WvYj8SZItgjJUGX+NRoCBMeZab7QS8KZkzUFTDQf0zRg/dRAm1pJO47mUuTVgo26gZPsSmD1fnMxuRt3mqsK1yuhonM9gDU8LYJTv6HXJ0mUIPITya+P7AD9W9ttM3eSIf+slORM9VQRlrGPthKVExcsPEmZnIVw6h+TfrJeiBEPJW8HhLxCQxjLoxYvARhWcGvrURZy+Rw+N96oUAvhZCSBJyNCJ11WcKY74dCvs9dt2T9TOIeVmh0zmgi59iUW7QjA15sWxBeYirxOgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lh11zNEXMmdJ4z3g/Y+OISeh29AJuNtuPBqnHZ9qyBw=;
 b=1b0YZa8OandRm4khOhopXTk8W+lUqaMhx1PqpCY+rphbrpW4GGnL3x8NBzyBSHvuCXiiIooMmvp74XjsSKHA4hBHyh2F2sdJbjhRNS9t1hXMaEXccjRYWUUYSbZF3gt8O/zgsPFruaMjfWeF3mbrGeYBt0XvJmGUrymQMQk5vdg=
Received: from BL1PR13CA0267.namprd13.prod.outlook.com (2603:10b6:208:2ba::32)
 by DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 19:25:49 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::ac) by BL1PR13CA0267.outlook.office365.com
 (2603:10b6:208:2ba::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 19:25:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 19:25:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:25:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:25:48 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 14:25:47 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 02/16] drm/amd/display: Check status from
 dpcd_get_tunneling_device_data
Date: Wed, 9 Oct 2024 15:23:30 -0400
Message-ID: <20241009192344.650118-3-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009192344.650118-1-Roman.Li@amd.com>
References: <20241009192344.650118-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|DM6PR12MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: eaedbc90-e568-469d-87b3-08dce8982e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jEJ3desBSwncTm6V7HKbqnfgEplQWgr6WN6BPG94cVgd8+TSZ+jhrbFK7BXn?=
 =?us-ascii?Q?bDNwUJw8/Fpz4PAnIFbFnEtz/gp4Lz2U0MlKSixETA8RvrgMK+e5xVL6HIuU?=
 =?us-ascii?Q?ZIY5Om98PIlFmLltMLmMC1LgcFDNR4mZgFMTskKYfShiFPMjz8/JwcMgHtMg?=
 =?us-ascii?Q?3E0erru0HDLfZGkLHgfN2ZPq5FQxeoMxJbjBPrr/0Nf5GnWMVx5kW7fvBSHK?=
 =?us-ascii?Q?pps2mmm0kQLQp4YyPz4F/A8PAqS4Wx7mezLgv9rmAuu1rOPcqaqT5CwN2lqt?=
 =?us-ascii?Q?C/9k1KMWsfhit9wNZ2+4yvp0/aySpL1fdLcMYwErpGsNUc0UH71s8fwLW3oq?=
 =?us-ascii?Q?pfRsDcF6BxevW10accsDHOAo8XDqnzXX95mdP06738ciLWY6KtGESgc6I/pj?=
 =?us-ascii?Q?1fvHPfdrYemj5BaGMlXd74Jezj/7J1Tt8mH4NFeQtvUskEZjMVS4iOP6zo96?=
 =?us-ascii?Q?TkMhiVAcGxDFtcSVeHISRTZUQaCLuwsDkaSEyoa+q3bVxt/zAmEGCBkKTIlR?=
 =?us-ascii?Q?KSUjhUsELUqomwtCjnMeM6cJQW0iAUpqH6++3h6c+72WxCEmuiOY9uhN+mqp?=
 =?us-ascii?Q?Y98OAjpnjNK/leIcTvv+diTFyGF75MLDMj9zpMWC9JkKZpojwkxuFhP8nQa4?=
 =?us-ascii?Q?LjEcBPo/Z1krwSqf80xIwNEQMj5y/2U1p8MhrNaPYOhdyFCjTAeY1kML+NAO?=
 =?us-ascii?Q?vNsNREqgp+Sqhq+NaataKmag4NF2HwcMVdCrzYJcEuqWlfn/FvNZWaOMqDmU?=
 =?us-ascii?Q?cj2DhLv+l48zWe9EJMwAW5DQof2nEl161KfxCeT44VpMxyb+KjcCQC4WxskG?=
 =?us-ascii?Q?RVwTpkHY+oeeldTsFpmIUG38lr5nIIis2E9ZzMsOziSSFlj+ymp9P0OjJ9OS?=
 =?us-ascii?Q?6VKWirlOdHcss+V+UIwi+/SjPeyK755GiNnZ1DPXA6Axv4tDkZgKXV+eq31L?=
 =?us-ascii?Q?bjrx92OktAtb+fY2wjQln84GSmlny3PcIMq8XD9PK2yyhP8I3BzdR9Fg/UJQ?=
 =?us-ascii?Q?pN+tGRNEZzMxq42Vr1Z0KBpnkzFT3Eb2X9Sw1FhqkTsGrUHOA6W6Cq9WUwnU?=
 =?us-ascii?Q?V7scz1KpCw7yyztxEMz/rgt+r9S2vloWwTljBF0RKu3p4vxhmfAzrjZtu5Co?=
 =?us-ascii?Q?ryABA38xk87rhP7z3GIv4Eqpt6iluuTl4Hhvjiv4yDHnqqjNP51sQS3en/7q?=
 =?us-ascii?Q?QowNQccVRKM7pONC+/xRO/4jJtJUGCxG7t8R1nr3EQDVetMkZJhaIIx3IRgU?=
 =?us-ascii?Q?Ih9cvQlE2L6Z5axkh7XilDjNj/gV/h6wXBpexshttPUb8mbYZzWnE8F2WpLL?=
 =?us-ascii?Q?ID7XHM7iSRNYrFcFrn18y3sKEeQ1kp+qF31cvwPEU/bqyGKQneA7VOxeP+Vd?=
 =?us-ascii?Q?WIAj7ks=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 19:25:48.9893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaedbc90-e568-469d-87b3-08dce8982e60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
dpcd_get_tunneling_device_data calls core_link_read_dpcd which can
fail. The status from core_link_read_dpcd should be checked and error
messages is printed in case of failures.

This fixes 1 UNUSED_VALUE issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c | 2 ++
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c   | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 286841456157..2ec968f239f7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1636,6 +1636,8 @@ static bool retrieve_link_cap(struct dc_link *link)
 
 	/* Read DP tunneling information. */
 	status = dpcd_get_tunneling_device_data(link);
+	if (status != DC_OK)
+		dm_error("%s: Read tunndeling device data failed.\n", __func__);
 
 	dpcd_set_source_specific_data(link);
 	/* Sink may need to configure internals based on vendor, so allow some
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
index 6af42ba9885c..0d123e647652 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
@@ -59,12 +59,18 @@ enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link)
 			dpcd_dp_tun_data,
 			sizeof(dpcd_dp_tun_data));
 
+	if (status != DC_OK)
+		goto err;
+
 	status = core_link_read_dpcd(
 			link,
 			DP_USB4_ROUTER_TOPOLOGY_ID,
 			dpcd_topology_data,
 			sizeof(dpcd_topology_data));
 
+	if (status != DC_OK)
+		goto err;
+
 	link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.raw =
 			dpcd_dp_tun_data[DP_TUNNELING_CAPABILITIES_SUPPORT - DP_TUNNELING_CAPABILITIES_SUPPORT];
 	link->dpcd_caps.usb4_dp_tun_info.dpia_info.raw =
@@ -75,6 +81,7 @@ enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link)
 	for (i = 0; i < DPCD_USB4_TOPOLOGY_ID_LEN; i++)
 		link->dpcd_caps.usb4_dp_tun_info.usb4_topology_id[i] = dpcd_topology_data[i];
 
+err:
 	return status;
 }
 
-- 
2.34.1

