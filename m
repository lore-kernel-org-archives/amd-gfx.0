Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA6CD35660
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 01:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A6E110E5E5;
	Wed, 28 Jan 2026 01:59:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4pZMLCR/";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59CE010E5E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 01:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vx3GKFUD3b9igszZgoZpnyWZZkEBwtigPogslZ/afvCCVd0LXfB1GnBe4y3wN8nHQpnHqkRYlOmy4eOcg3LNyuSayN259/EsaisFRSpUH7cHGD3PXRA+veKZha1wtMAeXRwIQWoS5HDIsIhR/5xgNJdJMS/RSH82hsJ27jaZPaGGhZqAe5e5CAUkrQcN9ujXMYDk1DmTCIchz856w1nfxmz1oxGAGm4XCDPdl/FUKfX34eDou8cM+7yYwS2Xhi5hMuxOottD4osyawUTkTrYiWx58TrKZpEvh6JmCaqPuAaS9lCaN8ymSiHQcc3LHoBWCBOOLDH7bQ5spO5mTvQenw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nbtqyive9BmYGmGof58bynHPZFs5z/3Nz2Tcg9vdHjg=;
 b=Xd7WALDYBxfU/MtO7LG+trSN8gnJyRLfa7TmE2bMk3SuZoEyFyvC80u3J9plZjQr1lHAuQM8VXiKS8ZDIgY7Gj/1MS8/ayHegbIcRRB3w9/5IS78A4rX7N6WBfVeF1fXZTCgG0OJvDIWej+I+GqistyjcXZa4xyqCbNz6Y4BdVETsuE1nhHiweTUCQtGnK0jkEbGb2Tranyhqax/k9usxnVWJwr8PYH/VFD+O9tm/jCQLpvD5r0WZYxRlM8KDESbdemOvrXemCnxV5In/tGx3eDzkC1c3wITp2Ul+y4kPX9kxWZXyy0xk8nX62ZyQK1Nm27ju4ix21GpWWs5webmmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nbtqyive9BmYGmGof58bynHPZFs5z/3Nz2Tcg9vdHjg=;
 b=4pZMLCR/WapaH0KmEIzGmvrjaT4mIo3afvCUL4JH+lRTLJB52MAoIkXd2KWpwLyaZ6Yiqkr2B8iqmO/07UfUPOO3waF4HRyHXW26IF7rj+T0sxixYZ/gTep5VeAGVAJLWmPQYZep4kNbu1iKbtg0tfPc6rIKpEDeKIE3YxJ0JA8=
Received: from BL1PR13CA0203.namprd13.prod.outlook.com (2603:10b6:208:2be::28)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 01:59:35 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::fc) by BL1PR13CA0203.outlook.office365.com
 (2603:10b6:208:2be::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 01:58:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 01:59:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 27 Jan
 2026 19:59:35 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Jan
 2026 19:59:34 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 19:59:32 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 07/21] drm/amd/display: Fix writeback on DCN 3.2+
Date: Wed, 28 Jan 2026 09:51:32 +0800
Message-ID: <20260128015538.568712-8-Wayne.Lin@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 0425dfaa-3208-498a-7f6f-08de5e10e329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S/Wey1xRjLqIEuJOwFuSKf6GuqcDYmeuUGSitU7vMRGdrK5DpQJHh1ougkWY?=
 =?us-ascii?Q?nI8V0c7chqQEzyw04jYz1EzpuM3N2lXC3xwXFMQIa1gi5RZjxzHk+Apnfus6?=
 =?us-ascii?Q?VUjboPawGSyuFWIIsTptGzCkOuBaay9JnbIhIOuf7Nwd/fNsb/dSzPoGVylD?=
 =?us-ascii?Q?cEJ94DzHi44RUF44QvhMd4vMk1sWaLNOITEv/R1KCxU6KwzU3wK5dVEL0x+M?=
 =?us-ascii?Q?pv/Cgb9XDvtgReYCka7bcKKHucMC+8BM85Oc2kIq9PfcSQXBdKOjvA+Z7s95?=
 =?us-ascii?Q?azCbVd/jsv7Ww0N5Ree/IpTtvoJ7iN8TDPckq5Xq/GaJDOi+3niMUgz/+kaP?=
 =?us-ascii?Q?NNd6dV/AAKUoDp7tqbTqc2G7EtiX3IoHWfIjQPf3Vphz50KieE73ZnB1LZ15?=
 =?us-ascii?Q?6VX8DK2CUAg9x+O+9eWgHCxJau50NlO1H7RLKPJFgSC3hIeQI6twjhAlFqoO?=
 =?us-ascii?Q?ip1c3t6iXbhHthDtS7zFqkzaVY7h82u/ZeWUSc9SZ7gkVCT+R5CC3TVLXMTd?=
 =?us-ascii?Q?ZL91FhXmb7M73k9EcjkEz6cokZrSYEMW1teSMO5vwcLKT5Gzia67X+GalZ+m?=
 =?us-ascii?Q?U5dUMSIMvBR11dKUKDU72JzZx+Dpskb9MLNQJp6IcBIhHSN2bb5ACxiTN3Uv?=
 =?us-ascii?Q?YkSw1y/dF6kMt8WhWeeFNY1xnBAu8JXrk6TAO/oMQ4w7cZbQo4Fig6EnnVX1?=
 =?us-ascii?Q?WhMdzpkjxl6q9lRhL659CvIz1laFLo+Fz6HiKCyO0EIonK9JJ0XIr6Sy081A?=
 =?us-ascii?Q?cfytrCiQcf+gz3V9vlta/al7Hp3dk+ajamMtv+5ufj9RhvYTQjk3XdoTNR/g?=
 =?us-ascii?Q?2RzE4wsrMZ+fZyiQl6WPwCCeqT7azu2HHqvQVDwhv7A4g5DVrhJpTPVQhsWr?=
 =?us-ascii?Q?OER6jMtu7nA4w2vEwbP3TaR4KlonX3XRkDmwzjDshR4pvUK5VYsuMVPMIUv3?=
 =?us-ascii?Q?4w6B+D78PP4CQbc7vyI66IK2W4aOKVNaW0zyWB4OBVe2+KSrEREshnzOZuxY?=
 =?us-ascii?Q?Hte62d5iUlOiLvJVbOzPOehogObEY2Lh+BaoLks6IEjppZ5Z+256Z6sxNLpP?=
 =?us-ascii?Q?3imnxIV52VjHqZQGty6rcPW/2N+f96WtyFZD/jcFYfdL9tke0dFEGUZNBXCJ?=
 =?us-ascii?Q?iOiMIZllwLKf0LEh97umGIooqV4rweDe6Vxsac5k7GJn7hYqXJD9uBqMxJyo?=
 =?us-ascii?Q?Po0bMJke7wZ/i1HIKDNBxfIwcCEtIlGP68X95XgmIdRRgOVI60UZC2PxaqRI?=
 =?us-ascii?Q?XrBWa0DSy/M5QqQNSKQK2jxIi2fWfM9PGmNYCyNQe40okb4Nvm8evuYBrboJ?=
 =?us-ascii?Q?nSDdB1qCmyeOOMrZY7XRryiX2QlZBfUhe/ANahK1I8DLp5z1fcGuNNVJvJEk?=
 =?us-ascii?Q?z9mGiFuV05/Ykg+IuMOljb5B2JtFiPIrup+XRYVBmyK712Wl7ewFrXaXkIA/?=
 =?us-ascii?Q?z8RJ1iJ+OL41kj7a/bc+HNMHd7iITuxEN0OtTBxFMFYO5f9LoxhckLgzZu4l?=
 =?us-ascii?Q?m/Zcp96JkED2tDma8uraUmL5U0++zN/FYFrRoElmQmYyaBCT6OMX+hvvD9dF?=
 =?us-ascii?Q?GxmSZ302Q5E2jbrwhYAx5l+YKpB6EfdaV88SzI/bnOpa01nRH7M9LE9V9A1R?=
 =?us-ascii?Q?P06dUrVkIi/D6srmbmOPTOOsM3WupqhJHLQNFv0pRjjWgIWb6P5E/OEHIqWa?=
 =?us-ascii?Q?L0UrFg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 01:59:35.6476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0425dfaa-3208-498a-7f6f-08de5e10e329
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237
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

[WHAT]
1. Set no scaling for writeback as they are hardcoded in DCN3.2+.
2. Set no fast plane update for writeback commits.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d8fac7e69181..572998eadb78 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10658,10 +10658,10 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 
 	wb_info->dwb_params.capture_rate = dwb_capture_rate_0;
 
-	wb_info->dwb_params.scaler_taps.h_taps = 4;
-	wb_info->dwb_params.scaler_taps.v_taps = 4;
-	wb_info->dwb_params.scaler_taps.h_taps_c = 2;
-	wb_info->dwb_params.scaler_taps.v_taps_c = 2;
+	wb_info->dwb_params.scaler_taps.h_taps = 1;
+	wb_info->dwb_params.scaler_taps.v_taps = 1;
+	wb_info->dwb_params.scaler_taps.h_taps_c = 1;
+	wb_info->dwb_params.scaler_taps.v_taps_c = 1;
 	wb_info->dwb_params.subsample_position = DWB_INTERSTITIAL_SUBSAMPLING;
 
 	wb_info->mcif_buf_params.luma_pitch = afb->base.pitches[0];
@@ -11677,6 +11677,8 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
 	struct dm_crtc_state *old_dm_crtc_state, *new_dm_crtc_state;
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
+	struct drm_connector_state *new_con_state;
+	struct drm_connector *connector;
 	int i;
 
 	/*
@@ -11687,6 +11689,15 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	    state->allow_modeset)
 		return true;
 
+	/* Check for writeback commit */
+	for_each_new_connector_in_state(state, connector, new_con_state, i) {
+		if (connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
+		if (new_con_state->writeback_job)
+			return true;
+	}
+
 	if (amdgpu_in_reset(adev) && state->allow_modeset)
 		return true;
 
-- 
2.43.0

