Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AFFC52D7C
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 16:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C743A10EB61;
	Thu, 22 Aug 2024 16:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E32m+zub";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E39010EB61
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 16:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqnIfS2fv7fKv2AxW81h7nWdu5UaipM1W5cgRrQux6SipeW1InR6w4sVMVT55PV9vjlkHG8GCcHoVVdUNSecSoO+MTTdZIJJRCX/BS2dN0FL9r83ol2zCNuXwLnRkgK8UE88zbeZi0vXDhUWoDUQPdjT5UetGVpffb8BvJu416KR1UHa6mE9ub5trfLbjAj6hczs6ReAT1AGHhlbBK1TLgGelI413hab/mDP61QQBio0b36UtsJhmStAKYOxE3wXqC/+JnmJCu/SheOC4TdNHnPPADCdZayCBjAk8ZOKyQaxU8aySS8vM7nc9SgHwWwFPB7MBA+vBVcWgwSrACxQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjqclc9oVbFh+Cm7nSdcAjmCW7cdoE92xl2F9gqWOHw=;
 b=r9C+zk6QOLzJzJHgF1U6k3O+3loU4HD3rjSt916tBbULHVMvDb2H+BDObzX29ustuUWLm0ufKsMSIRrM+a0Lu8NhlpjlY/CsZmdHG7Xn+C97brVCaL3kdhQYXF6b/gqml5N61LQfcDASGqrvC6FZ6qa70F9RvCYxS5hW4Ro9ZQdfbUiRx1KO1K/XKBcd260VelfcYjZOg4aBm4cBAplo6SRghPcaXRCsAjeQay2LUkBqYKteGkEH7mR+1dBVHC5Z1nMOzFXvAWVlw5ERffWoTFCjcMuQ0ZAr5GX1XXuHH2gEUuw+VdUPWzF6+XysOxnNiDv0uicelJR5uanzOfqIMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjqclc9oVbFh+Cm7nSdcAjmCW7cdoE92xl2F9gqWOHw=;
 b=E32m+zubuWLPsSXEcY4pmRkWiW+Cieo5Qp3JK0vLwO4H9GX49GMEv7sIBz9aOuSGUU4Qb7e2tGMaV3FfJPjvKWv4hVvH+3bwrFC/NQqP4ELqGQgcnOBaGA3j8BZN8BDdUrIgFVKECj0a2QQFp1+CxnsrAh2EuJ8kyefOdbt6OUQ=
Received: from BY5PR04CA0008.namprd04.prod.outlook.com (2603:10b6:a03:1d0::18)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 16:19:20 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::bc) by BY5PR04CA0008.outlook.office365.com
 (2603:10b6:a03:1d0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Thu, 22 Aug 2024 16:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 16:19:20 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 11:19:18 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH v4 3/3] drm/amd/display: use a more lax vblank enable policy
 for older ASICs
Date: Thu, 22 Aug 2024 11:58:22 -0400
Message-ID: <20240822161856.174600-4-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822161856.174600-1-hamza.mahfooz@amd.com>
References: <20240822161856.174600-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 5faf9bb8-64e5-44ff-42b2-08dcc2c62d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gkw5HyjRizVOTbTYVSqw+8ayk4F48387P6YlpwXhY1+2B19xVzwnqEIbl9eh?=
 =?us-ascii?Q?zimq2qQpiGTeAGX35K1j/qEHTOsXNnU7VIL6RAf7Qr7XC+b5j72t+60xebMM?=
 =?us-ascii?Q?UvEBx6giIlLe96mm6OaIIVGy+uUAb2qN/d8RyzeNFpAvk4Y2eX8yCiX1vppy?=
 =?us-ascii?Q?ZM0vBt1niehzAkMqMxlnObwY2oogiOL6TEecZVkd9ar3l46sdEmkWMaLnkQJ?=
 =?us-ascii?Q?CHG7cMjQVC+WP2LfZo+D1FRH7lxwoZ3jqKPZoYptbT9RLukNOPihE/8JXsmc?=
 =?us-ascii?Q?2NVHM/WKxhCAN1txnsQ6p6vfYf26wuK6Qry0kEUKqom+cEM6+2uVts95pEdZ?=
 =?us-ascii?Q?qnwaf3Ot0lwWD4xFONuFMXwUw/RB+RKxUtWIw/Hybqw+oM1/BOh//JpzYbBF?=
 =?us-ascii?Q?3HjjoW3FGMAUJ9mgw1kXNlSVcvMTZsh3T+Q387eoirTm/Jx+t8P4EfQcOepS?=
 =?us-ascii?Q?hyoPXetnkp8alNcOAOG4nBkd55TzqkOpf6m+YMu4iICH6RpFIBIRLNl1HwlZ?=
 =?us-ascii?Q?dvNkuD2WgDoteHmMqMgH6LVCdSY3WldzXVKrNozXzviIN8c57hlzKVERQeXu?=
 =?us-ascii?Q?Y4z+s6xpo868DMDU3uyoeC7brK6IrVx/wfga4ERI/3CPPhfXZ+gM6BqisqvV?=
 =?us-ascii?Q?dYv16KLPmROzkBf+iH0F3XfOpCv8uKCRmgwT6BwZbbmf6cB1YLejK1Q+/RDH?=
 =?us-ascii?Q?8WigpvSQt8JeoCUxJYz1swhfWKrdULKev2eXQyIncwhLR35eBoLO9sVsIrlz?=
 =?us-ascii?Q?fSJL4Lm0Q4Qn6ANxovPQ3R4MbN+mwqDy8Ssjo0MbpOAJZG7wO+cI18+a9sbv?=
 =?us-ascii?Q?0pCrlBEjmaZVVItjzUJI4Cb4IlsWgkUYwacxOlPouMp2ugDuEfMKEAbkS0au?=
 =?us-ascii?Q?Qk7G2S3bPEUMvVOXqLT4KQ6NPhEhBCpJkzeLcD9BZLIzfz9iiIYrqgif9+fW?=
 =?us-ascii?Q?QF9X6CIbwXDFc9vLdSlmO1V087vhcnQiliq7tWoALp1Ozt3HDTxo5wy1QIVy?=
 =?us-ascii?Q?ru/JV7A5r9U9TaK/ElZd1KOLP94EYd+Dd6cZ0pRmjodhkGr0OEpu4v5B+wDY?=
 =?us-ascii?Q?3OPkeV1nqKx2M1iuXgUafF4F8o0LxQQeqDoK3hiotMTNzubyX9pp4U6Qe8uD?=
 =?us-ascii?Q?12yC5L2GpDv7UxHy2/m35ChlzU5808kXN1vbxCgxhoGVb96PD+ucCuLnIiIM?=
 =?us-ascii?Q?0GZ/WASU4aSNwtshl3aQiF0/wQG8AoHkOeoIxtFWmVw96VU2NIkoOGVcN+9b?=
 =?us-ascii?Q?ZeYWVexghHvcCDKCgOg/9aWMYx5SKF0Rj7mVMOxDWNHzgplYC9eEUHHLhjyA?=
 =?us-ascii?Q?1hK8q9lqAR19xv3B6+V59/LsXiLaBv8CCl1M7eumU2nnwMvgm2URuGiriNLc?=
 =?us-ascii?Q?Kv1vTqkw1G8VkiTr25Nl/z9RtReEW9S0GbzZMExOl7al2kZwaxXSBzvHK6AZ?=
 =?us-ascii?Q?m+MfHx1drADdVEZ8rz+rZcKDOc7GFEjG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 16:19:20.2159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5faf9bb8-64e5-44ff-42b2-08dcc2c62d98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771
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

Ideally, we want to drop the legacy vblank enable for older ASICs. This
should be possible now, since we can now specify how many frames we need
to wait before disabling vblanking instead of being forced to either
choose between no delay (which can still be buggy) and
drm_vblank_offdelay (which is much longer by default than is required on
AMD hardware).

Suggested-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 68442cb857fc..8c34a7756c58 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8244,10 +8244,9 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 
 	if (acrtc_state) {
 		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
-		    IP_VERSION(3, 5, 0)) {
-			drm_crtc_vblank_on(&acrtc->base);
-		} else if (acrtc_state->stream->link->psr_settings.psr_version <
-			   DC_PSR_VERSION_UNSUPPORTED) {
+		    IP_VERSION(3, 5, 0) ||
+		    acrtc_state->stream->link->psr_settings.psr_version <
+		    DC_PSR_VERSION_UNSUPPORTED) {
 			timing = &acrtc_state->stream->timing;
 
 			/* at least 2 frames */
@@ -8257,14 +8256,13 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 						      timing->pix_clk_100hz);
 
 			config.offdelay_ms = offdelay ?: 30;
-			drm_crtc_vblank_on_config(&acrtc->base,
-						  &config);
 		} else {
 			config.disable_immediate = true;
-			drm_crtc_vblank_on_config(&acrtc->base,
-						  &config);
 		}
 
+		drm_crtc_vblank_on_config(&acrtc->base,
+					  &config);
+
 		amdgpu_irq_get(
 			adev,
 			&adev->pageflip_irq,
-- 
2.46.0

