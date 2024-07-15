Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2BDC3DA59
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 20:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CA8810E520;
	Mon, 15 Jul 2024 20:57:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UYwTV0xv";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D1110E51C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 20:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5viYgbrZhZNbWyZml84OXLk+ixl+TiY3xQhhzWWcDTehlq45fOnvftihM8RQdh2ujN77xdT4f0jPtBAON8S+2Dn3BOi4rKmKhh7J5hxF5PvJyRFrx0gQy3L4S6x/R2qLFstavVvBB+o8BJ6WXGll8MK4ZsV6IHNk1Yj7DmlLH0RGTPJVlzx43GfI9blc9z/9oB0BkV+W8MMfo5ZpshvkKqTfgXUT+R7O896SCwWb1CJGZEfKTP4+Vjw/WpJRmIvFcSGSSfzqWn1cBhekpNkiXDrZVAogcpAoo9NmdN6eys04bjqkLBS77Y8wxZySX8qvE3K/ukndB2/Z7z7fxWlNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnbfhLqnC5qakH4kvIprr4HvWt4dz/mssmtRy5bgxU4=;
 b=si7TYxPSI2vE29c3zIZ5bjr8PUxPIc/jy6BCjdkHV5C6TimuVEvbwDX5C1OA3u3IihK/FHNQr2+l/00Zx8EuLl9ng4pnwO5HlQhsrcFroK2ZpzP+Vruxb6OVkwvdE348z8ukMWC12AgF/n1wpaQLhzJZZEAbG5pG0xujw94oP87WeLzBydzRPMbaiO4xk1ptTLe9t+ysFTVw6FNcMGTetCJK7zTd5fvplhQP9SfnUMBEoN/gdOdL2ebl3vewEmxMhR3uW68ES0ulD2u/S18njMBbw2N7CYgdyf0xUa0JxaDx/1R5eGoqo2lGOW0/SjmOByZ6mQ+GLs3e50JJ2Lfftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnbfhLqnC5qakH4kvIprr4HvWt4dz/mssmtRy5bgxU4=;
 b=UYwTV0xv0fqAG2gaz7gQnlrdO8P57eFXDpU039WU7Gb19GgGfiwDR64/AKfMvylAImrON/qj1+60XlQ9ea1y0L4fS2TRGWMt7ttXXVr0i4oAd962UkxX4lcwZCa4hLlUckQXVPE7c7qyMnyiozJ/j8R19RrMU82DpW6CQAqagBY=
Received: from BYAPR08CA0006.namprd08.prod.outlook.com (2603:10b6:a03:100::19)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.25; Mon, 15 Jul
 2024 20:57:45 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::eb) by BYAPR08CA0006.outlook.office365.com
 (2603:10b6:a03:100::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Mon, 15 Jul 2024 20:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 20:57:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 15:57:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 15:57:44 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 15 Jul 2024 15:57:43 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <Alex.Hung@amd.com>
CC: <Harry.Wentland@amd.com--dry-run>, Roman Li <Roman.Li@amd.com>, "Stephen
 Rothwell" <sfr@canb.auug.org.au>
Subject: [PATCH] drm/amd/display: Add function banner for idle_workqueue
Date: Mon, 15 Jul 2024 16:57:15 -0400
Message-ID: <20240715205715.358444-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b8dcd3-5127-4b87-0478-08dca510c68d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OanITJoFlgBInLcTzlxGIXOqZ5Pi9iHa8U/lF746a6Mvvptym7hV2Gniq86a?=
 =?us-ascii?Q?aLMYA1Mbdj+gsVP74k9NRFMskZkXu9iwUpOoYsXRoqhpo8kZGfgF2eIJyTW6?=
 =?us-ascii?Q?OcCF/HwpWST9/qom+Kpo2bypOQhEHGkMtFC8TL/zdgVMKveYDC+iaz8h2vFX?=
 =?us-ascii?Q?Lp14dpfA0QOX3d9cqBHjTBezM46eE6bN+ggHAN3DQT+7lQGYUIqLf6kSiDjE?=
 =?us-ascii?Q?LcDrOwTisXUPuaInROXJq5Ie7HoLm5A/nRmI1x6oShNyG2DcD3NRv+T+SgQa?=
 =?us-ascii?Q?gcDg9s6MFeepPpgBf+S/PMDcu5bt4EEXkkEpZSzDx5fuUB9XzueFQVFrOC8l?=
 =?us-ascii?Q?MSqk7nvk3aia5MeFfCBDksub/qSoptc6QWhoWs3XX8lwG9GKG/t9zcetdsFF?=
 =?us-ascii?Q?RNxZpStVvLhK6M9Upcc7PAYYpXhR9xhtWbqDCvmQBRqtT6Czx56LEDfjIgZ2?=
 =?us-ascii?Q?7cfyVSNt0I0EDCFapk08SBjuxkMm784PfPVll6YGhXWyK2VTyV4IEkyieRyv?=
 =?us-ascii?Q?ipJoWicwyryWLWu/AZ+26ijDLWpFEijZuCndVTZBpZabglGQ+QxF97WvCv7c?=
 =?us-ascii?Q?L4l0AR8Pcrl95IzAPkHgZetuiZicKpzuPBjFhVtR7MI8NDj6BED6jYa5AvqB?=
 =?us-ascii?Q?PEzazYWimw0T9Sp42LZZ5J+SN/yQ4KsoNqfq+aXVcqJSfieqZki8TuXouV3x?=
 =?us-ascii?Q?IzTvaMPjL88rrLE1WMiLdwAL4YHpyjpUXFSM8FxWT7DwTAOHcIQvGNQ5aSXz?=
 =?us-ascii?Q?PUhMsH70DoB8+IEHDJZBckBELzBOpL+gBqs/2lo4uEc/T3KRPwfQPWFDSYcv?=
 =?us-ascii?Q?hh0ZvTFT9b0829hFXcI9fVsAPdCSUSaHDRbYjelXivn/vTX8QSIJkRvzFtsn?=
 =?us-ascii?Q?ynA9HqQ6XTg5RixJUfRojrwNGPCAyS2PSRxVAcvedvnEvSCWArOx+MAxIdJH?=
 =?us-ascii?Q?0T1YEdZ3/Z0bv+b3b8SiEUdig6zSQ45hdT4xJA6CDlNm0Zauur0bASF17lxr?=
 =?us-ascii?Q?/3xxYksKXGikZR65+QDwtxevEBn40RZBR44RfBvhuZ0RPJ6avQvEmbeRA71Q?=
 =?us-ascii?Q?eb0WOcqSRVGZYa7sr1xEqgmLp0JSqNTy8SlTQnj0fnFjtZh3QnP+U44jfIP1?=
 =?us-ascii?Q?8Qyx5rFojN4A0R+vv9ptMRYpJSPQKpBJnpuXnhR0kdiUzOZROC5Qos7zyNik?=
 =?us-ascii?Q?DeDEI4dqIBKnxjxgdF93JWQzg6aB+mbvzbmEmzBpVWBBzqTNlVNWdbHaeGPG?=
 =?us-ascii?Q?Bvggc4mHvj2CRltxJc0dxuklEbSscr0Mt+G0XBdcxOSWkXl/AJZDysBlK3Yh?=
 =?us-ascii?Q?t1SVNanBjJkwnUvY3GquD1+2i5xGr4/kts91NqR/eRcKU4UR6BziXgTipXoN?=
 =?us-ascii?Q?6KQ5o+37ujjgVMpsuVaVb7oDpcWBmg6wNku4e4jKkiDJNrdD8g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 20:57:44.7551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b8dcd3-5127-4b87-0478-08dca510c68d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844
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

From: Roman Li <Roman.Li@amd.com>

[Why]
htmldocs warning:
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h: warning:
Function parameter or struct member 'idle_workqueue' not described in
'amdgpu_display_manager'.

[How]
Add comment section for idle_workqueue with param description.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/dri-devel/20240715090211.736a9b4d@canb.auug.org.au/
Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 369159c29bbe..2d7755e2b6c3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -137,6 +137,13 @@ struct vblank_control_work {
 	bool enable;
 };
 
+/**
+ * struct idle_workqueue - Work data for periodic action in idle
+ * @work: Kernel work data for the work event
+ * @dm: amdgpu display manager device
+ * @enable: true if idle worker is enabled
+ * @running: true if idle worker is running
+ */
 struct idle_workqueue {
 	struct work_struct work;
 	struct amdgpu_display_manager *dm;
@@ -502,6 +509,12 @@ struct amdgpu_display_manager {
 	 * Deferred work for vblank control events.
 	 */
 	struct workqueue_struct *vblank_control_workqueue;
+
+	/**
+	 * @idle_workqueue:
+	 *
+	 * Periodic work for idle events.
+	 */
 	struct idle_workqueue *idle_workqueue;
 
 	struct drm_atomic_state *cached_state;
-- 
2.34.1

