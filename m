Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD6CC0218A
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 02:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A5E910E72A;
	Wed, 29 Jan 2025 02:57:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zn2CbGLc";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84DF010E72D
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 02:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SULFHGVzaBt7itp27lj5qWVHdDwAgzT0AIxNUDU8JS4tyQ99Wo2kaU6JiKhwF9paBT1bwe87xBG0+YcImEW1J6hSzz83fWgEVoeaIvb8Svp0OPlS2nwNsjsw5K5sQF4FnVuF7/ANhfLDTR9fhNIQqSHsx41YgWdD/ypim5mWcDiHQ+Ayg6n+/N/l1fQznT5u4RFixVs018Cvymz8pysAZaUeWvTWQ33ipkQAgzqPR6MiNMr1QYw/+vKH4C3Hgu4r8Csz4MVhLVb2SdaG8ykaq0+4Gy/rk2Sn3N/CKMiAHAn/1wP22Jwf69pBqrT8G2C8FDNkmeca9F5xdugFzm+x7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILx0b3izQYeAk7DzQ76hVhTbIYBZ71lbkGPkLZGVcZw=;
 b=Ctkc8VtisZW1+Osw78VklRcWPyH4srfcknG7gURxsGdIpQ36/S8HHCF5BlEraSkB2DndywKPBYklo+OuFM5OoT3dXOGjBWT3F3Sg2/jvUKYXdHLAi+Fhq4iH3VOaOh4c6tM42mUPfGc4wd8rfDLDra6dX2wbK/w+td9VxS53fqcAIDGMJ1l8+RzD1KCm0VGYVES9/+nl+IC29r+YZi5Gm6CZwqMW3LtttxsY6Lnh6RxvqLjYqX5wxyfE0lopUjdKZLbncuqOlYqfWKA27jNnk+jGOypO2cnokXFds1H1gfZrzP1GbCg7aialbwIE+i6AQvVHGSexWAFfDhX1TIz0fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILx0b3izQYeAk7DzQ76hVhTbIYBZ71lbkGPkLZGVcZw=;
 b=zn2CbGLclJrtAN6Ojkj+zLHQOhYsW1UsG+PcZoUQaFCpGvJOsNGGjOZJknnBBVLCO0gO3wvUZKmn/VdcVu8qHh1uIX8iXzwJQpCl3HiuDdoBpFeJmJyc/88Kdg0iIQBtY0IjT0UkI1Q1gWxH/dF0QSYup2jx5rAJeyxWKMbF36U=
Received: from BYAPR02CA0053.namprd02.prod.outlook.com (2603:10b6:a03:54::30)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 02:57:36 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::d4) by BYAPR02CA0053.outlook.office365.com
 (2603:10b6:a03:54::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Wed,
 29 Jan 2025 02:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 02:57:36 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 20:57:08 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Martin Tsai
 <Martin.Tsai@amd.com>, Anthony Koo <anthony.koo@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 04/10] drm/amd/display: Support multiple options during psr
 entry.
Date: Tue, 28 Jan 2025 19:53:48 -0700
Message-ID: <20250129025458.2120268-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129025458.2120268-1-alex.hung@amd.com>
References: <20250129025458.2120268-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: ad36e1b7-f622-4058-f706-08dd4010af6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XoetJVzHQ1i2V+g2X3pm+EAhfnUTrJz/3NAgpmNZl9clvAuoxaUkm/i51YDi?=
 =?us-ascii?Q?/J5RQTnI2FEw6FuqUfPsMTZ/KrAkud7vApbfNIc15/GsQeU8ATcW0zZ+x7oQ?=
 =?us-ascii?Q?oPsBFpIhU3wxo6Mv/+5mEGWoreXN0eQmvCPKq2wfBQxRL7pdDcchXwO8PghO?=
 =?us-ascii?Q?xBAaDWQrgbmfm2as2t3JmnU/CtRt/X75NDrbctaAkJ4vTTqJgb8R8SPM11BM?=
 =?us-ascii?Q?SOQvpshRKcrT1xnxs8cB1TxDM8mzXEN9j1rWzsKMyWw3/XQ24iXSqypy0qmJ?=
 =?us-ascii?Q?DF/AgaMPBxokev4URBX/l20g5ebcULrw7eiTVFNhFDAf1rvBTSQxrDYI3j17?=
 =?us-ascii?Q?M+LPQWqaW6vslZ8KQtxAUzrxFaoeeFofvQm0CMjCgUPsJbzGl6yhXZwqlllv?=
 =?us-ascii?Q?kWHux9nIshAXZ5eilJzcTEgRThNU/O2RQFhgPpNycy2RQCS+YKkUAlk185ps?=
 =?us-ascii?Q?NxsI1o/YR/Zk21ESM9sdScTWYqsMvSLe3aS5VX8QTpKSV5hhOHAcpyZD/EHI?=
 =?us-ascii?Q?ukXTUA2AlTSZMXQlPnrhKrRuxbvlmmh2qzdbh/5SGiGKyp6uG8+EfhLPxurT?=
 =?us-ascii?Q?UK2uBhdkJx/JO8ZEANd0fGWY27eNW8M31ctEWl82J4IogF0rhawnHZwFeWCU?=
 =?us-ascii?Q?fsOylV7Zkhmz4ikqKWolMqYNkSJy53oEmfTKbxMSdtHM574wSe6CDJX6BuKi?=
 =?us-ascii?Q?lLQ/FXT9nPo1FwJ+//rxo6Ug2JyHqpT/C4sERRLBQx1xpJBdsMGi4zzfmro6?=
 =?us-ascii?Q?EUawT2RBJACjkX0L7wLIEztFltlMhwjlnGL1jDrhSyiA/nKDOjx09EyDAxs4?=
 =?us-ascii?Q?iJDsM1B9enb2xSa495yqP7fkVw8aDfI2NhCeLWcG0lL+CL9E0x7N2DEYzBDw?=
 =?us-ascii?Q?TwWfFmZFgDc+XfPnGUrHXmJ3XkAT1jyrrNacLLVrl+oIcqq93tebmilgzuxF?=
 =?us-ascii?Q?vO8LkOi0u2OHTZqvpqWlDBS8Y+h+nN8ww4ma3rxEm6FsHNp3d2zNZtQu+n22?=
 =?us-ascii?Q?C57IaLt/GsieDWJY8bcJcjlDHKaxgAOmYPgp0REaqrdj86Erb8AQuOS8Mf2j?=
 =?us-ascii?Q?6yAX8BvJ4+oGWgKSq9+lYuq2bRFQXwIPafLMoxFisG4hliyHIgFWNNtXwYHx?=
 =?us-ascii?Q?soO3N7eZXjxgmUNoPHMoskUTs162V5K8sDUV04jJJcdYgbksDX4nqWKL2GLg?=
 =?us-ascii?Q?aTNQrcoT8VMxP/I9wxpIHNtuM7K4PZ2zSa/YvTbzxdXwQDK3JwVqu7M+gOfy?=
 =?us-ascii?Q?Z+e4ht7DGtqLU4P8X2dxDTBlp2vKNBlDoUpL+ztm5odSBGyKa2w/D+tH5uhY?=
 =?us-ascii?Q?sdCJ5Nx86SXEeG2EfRCmSRIpnaMeEha0MSAgEKyA5I1OBEQuR06X5Lufqnpv?=
 =?us-ascii?Q?7VjNDgkkMwkYCiQnqXVxG3IwIZzbLn01LPINJ8aCZLoqA/lV+UZg1F44fEdB?=
 =?us-ascii?Q?g5WCgDDGnhqM76a/gW17SipZtlOxHzXTlTJkIeZuZUrG2ctonEsZljxVH1Ds?=
 =?us-ascii?Q?YJEHCuom5m2jvRM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 02:57:36.1568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad36e1b7-f622-4058-f706-08dd4010af6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508
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

From: Martin Tsai <Martin.Tsai@amd.com>

[WHY]
Some panels may not handle idle pattern properly during PSR entry.

[HOW]
Add a condition to allow multiple options on power down
sequence during PSR1 entry.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Signed-off-by: Martin Tsai <Martin.Tsai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h       | 7 +++++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c   | 4 ++++
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 6 ++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 0c2aa91f0a11..e60898c2df01 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1033,6 +1033,13 @@ struct psr_settings {
 	unsigned int psr_sdp_transmit_line_num_deadline;
 	uint8_t force_ffu_mode;
 	unsigned int psr_power_opt;
+
+	/**
+	 * Some panels cannot handle idle pattern during PSR entry.
+	 * To power down phy before disable stream to avoid sending
+	 * idle pattern.
+	 */
+	uint8_t power_down_phy_before_disable_stream;
 };
 
 enum replay_coasting_vtotal_type {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 88c75c243bf8..ff3b8244ba3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -418,6 +418,10 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->relock_delay_frame_cnt = 0;
 	if (link->dpcd_caps.sink_dev_id == DP_BRANCH_DEVICE_ID_001CF8)
 		copy_settings_data->relock_delay_frame_cnt = 2;
+
+	copy_settings_data->power_down_phy_before_disable_stream =
+		link->psr_settings.power_down_phy_before_disable_stream;
+
 	copy_settings_data->dsc_slice_height = psr_context->dsc_slice_height;
 
 	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index d0fe324cb537..8cf89aed024b 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3118,6 +3118,12 @@ struct dmub_cmd_psr_copy_settings_data {
 	 * Some panels request main link off before xth vertical line
 	 */
 	uint16_t poweroff_before_vertical_line;
+	/**
+	 * Some panels cannot handle idle pattern during PSR entry.
+	 * To power down phy before disable stream to avoid sending
+	 * idle pattern.
+	 */
+	uint8_t power_down_phy_before_disable_stream;
 };
 
 /**
-- 
2.43.0

