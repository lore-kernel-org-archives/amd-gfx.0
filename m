Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF89C3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C45D10E2B7;
	Wed, 10 Jul 2024 19:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mPDBUJtc";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CDB010E2BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:37:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQqkH8JimeWPvnn/GRirE9bGuPna7wo6Lr3oLZeb3qtPJas4u1RJJLzV254DCQ8jDpUNwdh0E3mukdlcLrDGwm5gEtHezKZo81vznr4MuGHBhbTv0Z5cVVsSa6ZjUcYWAlpOAsZlunb5IysyMkI8k6gWlzIRwN82/OWYJ/GMxG5KWNblIFFCop5/bDV1GViTVwbEDESardq2lo5Ur6SGWh3G1NmMjsMcXmh7m1DETOOGO+djoXPutEHm+WucYPUcz9rpcmwRtoClns/UZnuw/gmEOuIuJQYDWwAc8R44zRcZp3ydBgJx8Ie0/O5zpVnBrtbWpGl53j/1wt6Lu+BT2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHtmyB9B6eWpxuh7uqrEvgS3x29bopFtDfUecz35D0s=;
 b=LEaaTq8rKTptf0DUDGCSiycq1kwLId0GzhAEXgQPLdQTDFwgISGL+0NbnOocayseQF0WoHATwiH60KaOap1SMR4q4ohemJC1FKlUO85u1D05fIssVF6Du2tftHZqaE74THFROtqPfZzglNOscjmUDDB9huZV8L18JDfWrSSrvc/nBC0AyaWcS43qlb4zXI4CZLRdiDZYBLQhMsZ0/XM10zA+iKOVD+g39GxsZcJY/b1K9YmLfMMtiVty4XgDN9yWluD8EyjNeKAImUpwOJESr/sxl5Ki9dkRnhYrPqeYx9Nwqfg+g7FtSpZ+6n9zELkIWYQ0VyVkOCFCcELy0ZhwVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHtmyB9B6eWpxuh7uqrEvgS3x29bopFtDfUecz35D0s=;
 b=mPDBUJtcv941AWb7ppVRxumQalYcv9KI92pw2er5cdkL2ROddeXMqSwlXBZnPB1hWB9EbLAS2soujWEDM4iJJdqSlNJK6ZzTdJpk/UQgO4w21uhrPW80Hm8LvOVOzr+0mmKkyYQXOuDXyMca/1OkhD3WJIO9o2YdMDddYBH11ws=
Received: from BL1P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::16)
 by CY8PR12MB7363.namprd12.prod.outlook.com (2603:10b6:930:51::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21; Wed, 10 Jul
 2024 19:37:26 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::c5) by BL1P221CA0022.outlook.office365.com
 (2603:10b6:208:2c5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 19:37:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:37:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:37:24 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:37:23 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>
Subject: [PATCH 01/50] drm/amd/display: Disable replay if VRR capability is
 false
Date: Wed, 10 Jul 2024 15:36:18 -0400
Message-ID: <20240710193707.43754-2-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|CY8PR12MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: c47d1592-8058-4223-4183-08dca117ba08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ii2FIOisxdKl0ukkBNLY+HA76lJWOomCw25NjY9jyTV8vKu0ZZOOMjeKbJom?=
 =?us-ascii?Q?uNuVvL0N0SBYlELo5MkMiXT6HZ4/RPMKfietrcTbn8B27EBNBhEcq0eMd1Vr?=
 =?us-ascii?Q?aR04Vm9MKYg1o0TJ9UIsbXWliDPYR6B03BisgZnNmrX03yYLf6qDYi6oYnhl?=
 =?us-ascii?Q?J5/2rxYtG336Nx7aEiMvgNiMjyzapCMBJAHFUthMsOCS0BmV56YEQrmw0M9A?=
 =?us-ascii?Q?I2WvyPdT46DbuDXb0KVXz4/7jXelH1ZJQ+l4My/qut8k1VKkZrvTlgNusBTn?=
 =?us-ascii?Q?n/DLSrfd0XlEMxNBG0wqXb6YVeIshtDtdWX8VEtU7VXDWZfhe7Mrwo5M8qTV?=
 =?us-ascii?Q?rB4uSR5jEAEiHtbiucxeaC0sze6sFM5PzDxxzvg0Rpg+z0NVDRJk7oYHOCuq?=
 =?us-ascii?Q?yPOPbLDzNCzaI0Bz7ZljNzVrCkOoUx6tpPvPEXwjJDWopxFyZcaJWJja4VY8?=
 =?us-ascii?Q?M7m5s7KGY3NI2s+n76r/PrtCafbc0sOpuC6Y4iG52XMxHoCvknnUcVgHVCud?=
 =?us-ascii?Q?FU7Dc0Zh+8Ka5thX1se1fDmlHsWTi6njMv1PQ90K7i7i1bfFRKZaHGh1xcCs?=
 =?us-ascii?Q?eZXShAWKwzS0Rel4FhEQrD4Fe2dN94bOip+BZ/QgjkEUEMYzZ+0xnN0nU49K?=
 =?us-ascii?Q?hnTWK1kE4aYOKm2sV6++yKwY0I7l3AGLbRiYJQCTPUdgYt6iHwQjxNusXr79?=
 =?us-ascii?Q?jsfkTOBPfkjctk0P0G025Zmgscfg3jzowuAnDCeqhzf1N1FFFPhiwM+D0yDK?=
 =?us-ascii?Q?j7FTMXFiIrEtgClFRO5wbjShym19t0C8Wrgys3ycuQekHOo3gct9JBgt342o?=
 =?us-ascii?Q?+1IEYxJr7n4Rrx1nLvlaXJwEGRkyYbtIpEY0SYwkqqMPvepCz8p1DF02Eqig?=
 =?us-ascii?Q?/5ksIP1s/IV/cvwkGn9FJrKem9QCZoFqtWzCfc64PkT7UCr8khO5xhKla+2w?=
 =?us-ascii?Q?vuBMEn099Z5mbbykZTXAGhVOg33Y0lqh+ixbWAvhd0r2wd3+k04KjeWQThI+?=
 =?us-ascii?Q?y9GSnuH9HafJJJEzQNBzRr9mx5eDcUV1ANCybVpgWPDDE0Kw78Dp7oOcA1gP?=
 =?us-ascii?Q?R921/k+TwoKFsBzSFdaTUP+QPxu58CBbGr38jq3qGVSfrBr4ISVcZSAzpazu?=
 =?us-ascii?Q?yiahF6XJ3uihTRhj8zU29jw0bSCZ390rkxidzyfgoLbfpRdxVkfuHD0QK9I8?=
 =?us-ascii?Q?d7uO8Alyg13rxo7DV1GTTP7zOGLniNtv9C9lCVsomp2zjPP5FwM/srMjANBo?=
 =?us-ascii?Q?Uplz+kNnPVMV4Rm7oXcyzA7G3JWkc7H9t3cYbVrC5ucB9rN19bPgmoZ+RFOd?=
 =?us-ascii?Q?sQCbRrye+ls8Odxi5HBfScP3wBwrfhWd1NW+khP2HiXUVux44PF/39LQkacJ?=
 =?us-ascii?Q?BhyBH37giJrBXU56nwN+RrXRwkfEMRMvrfRNpihBTW0A7I+7EtYNqp85oJ42?=
 =?us-ascii?Q?c8OFBWul6lZScKM6tBnaFAafUZ21TCft?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:37:25.5315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c47d1592-8058-4223-4183-08dca117ba08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7363
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

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
The VRR need to be supported for panel replay feature.
If VRR capability is false, panel replay capability also
need to be disabled.

[How]
After update the vrr capability, the panel replay capability
also need to be check if need.

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d1527c2e46a1..44a80766380f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12146,6 +12146,12 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (dm_con_state)
 		dm_con_state->freesync_capable = freesync_capable;
 
+	if (connector->state && amdgpu_dm_connector->dc_link && !freesync_capable &&
+	    amdgpu_dm_connector->dc_link->replay_settings.config.replay_supported) {
+		amdgpu_dm_connector->dc_link->replay_settings.config.replay_supported = false;
+		amdgpu_dm_connector->dc_link->replay_settings.replay_feature_enabled = false;
+	}
+
 	if (connector->vrr_capable_property)
 		drm_connector_set_vrr_capable_property(connector,
 						       freesync_capable);
-- 
2.34.1

