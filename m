Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0306C369BA
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 19:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2B6710E23E;
	Mon, 14 Apr 2025 19:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Iv3icxgU";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB2B10E26A
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 19:20:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QINaWmVUS6GbybsDFlxWwZJ2XiIA3g2eCBGejMF2Ln4Aig4AsVk5/qbG9EG3gg1c4lESdzbc+VojWNqSGBsl50Wx/9s0MLMqICVd3VoWbp/O506gdkxo+v36PHsTSHoAb0npPjdpgMpDDUqkk+3umLYfn8ZxGWE8pj2QGr2K5ocPBdeJzc9V2tM2KsLNZhvCk5l6iDOTKl3T1/Y1zJxq1BTsqRLLhNTdzL20C4L8KlbmQ2p03C0Jj/2NmGLpOyoXniOnuwWS/b7vJwAs2Jt6IQhdKC0/PwjMTa+FaLsQE+nwL65NuA+34FI9TF+HJLYPWqiGCTxROmfhMXGD/N99tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJvO8BPXvzsvLihDNwiOzuSzvEPj0IIc9qLbRG30TTA=;
 b=pV00PMsx4sejv7uJ5dHkG2Qmp+s1UylEbpVYv47EJrp1HzZgpKc6LgGXbQPGUqU7eKTGkrH8Y2STrLWnqfL0Lv4nbhVk4bHP6ksHrU2UcgKyHg9+OVJ4YBIDEVE8M9XrxIzDGDoHeT1vdr9LNM892go+NOADu3sV2pwekrnM0tqGhYqgQPbiwnqSCCxYqlWXJe9zJuTZ0SSgdTeLH8hFGKE/mIOWZZhLGkXLPSRSv+GN6O+agzlYK+R/DgB43oMesJSe+R9JeOgzP8s61XTkTNI+nQ4Uix+53yqKF++ZIuRsvtUZw4/huOHnorICroGjcjRN96XG91XPM8Pr2e6YWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJvO8BPXvzsvLihDNwiOzuSzvEPj0IIc9qLbRG30TTA=;
 b=Iv3icxgUTmKrXm1cq7jMpNII5A17EbkzSmxVxV116nY42s+qnUBgVTq6dhCDjLqG36AtSzAcuMpguCUkCv/EXtm9cua8eGtv9fC2xQSvl3N0COHML38KS+5GIf1z1raTOyN6OlEFQlyRTJmBoGKag1+6BV42tcx8RpEH08cVu20=
Received: from CH2PR15CA0029.namprd15.prod.outlook.com (2603:10b6:610:51::39)
 by SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Mon, 14 Apr
 2025 19:20:46 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::3) by CH2PR15CA0029.outlook.office365.com
 (2603:10b6:610:51::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Mon,
 14 Apr 2025 19:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 19:20:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 14:20:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V3 4/4] drm/amdgpu/userq: integrate with enforce isolation
Date: Mon, 14 Apr 2025 15:20:28 -0400
Message-ID: <20250414192028.3113100-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414192028.3113100-1-alexander.deucher@amd.com>
References: <20250414192028.3113100-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aee2f18-135b-4da9-7a7d-08dd7b8974eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9IlcpCpLQ5Ow/t8EcvcNp2xMP6w3AjmY03iwySph7+3ekqzEYUhqdCVW4LOS?=
 =?us-ascii?Q?z3MPJ1ALGXlSbiu7ZO1QP/V69qYNmoDMCmC5O/A9rOMP6WnmKHyoXGIxDM2I?=
 =?us-ascii?Q?08N89Ajwi+qGsiwbW0kvdq7Nc76+Z2pI/5QyZn/3OterXpRVKVETEWMv37CX?=
 =?us-ascii?Q?W7ul3J/j92f4l/47UlpYV2YC6XNNQ254c04bhBiza2zeh0uY+WH6Fr+lnwOV?=
 =?us-ascii?Q?mrumqlalqaRdu+cTcjN2mngT82spPMAe1KeKXlwOqBZiSaPph8+8ZaGq6vA4?=
 =?us-ascii?Q?vcTQ/ofGZGG6o3CJQr1PW7g37jMuB5XfMQC67zluhFQNgL0465L6Ncpbbeir?=
 =?us-ascii?Q?Jc7rn8ItW1anrlQ+5LfsnluYbZoVFenBdf/1uTJa+O53eM+ioFgKoXrhRz5E?=
 =?us-ascii?Q?ZUEpHkWvTVgugZN4W7JFPawSbPLKjsmteUEs/WHKclmbQQdO2N0q11Qjp//6?=
 =?us-ascii?Q?U4qYlfzZiL7kx6KzCHrRFoFDDRwe8oNW+ZsB5FLPP8NhIYeWkOofDvJ/Cuy/?=
 =?us-ascii?Q?5om6dccHooyL8lNKMRI2RM2iw69/4OZMrXJ1PwRgn6OLiO5aQzMArqHkf+Fj?=
 =?us-ascii?Q?j53dDtqgp/SjYpzkcDSyhwUIxjDWUtzKSqlmVm6ERXaVzu3nsokcG7C+qx90?=
 =?us-ascii?Q?y6OjkcvzJkprsC5mOBN4TkMiaackgAkmrsCurEzZXaBdpTmoeFMd8o9okCko?=
 =?us-ascii?Q?YenLEafeLcj6YKDOEILCpjKxyRyCi5n4JGLFBZ9SGIBwWNTg88/92OFLey7t?=
 =?us-ascii?Q?SRsRnSoEOj3HDqQn8UL1mViXPragyExVIt4j3g8C/lQ7CR0/HNUZ/nR3eruN?=
 =?us-ascii?Q?ACOOT6M0r8yLhubEA93h6B19WJrMgkORyKmCDNddCel3B32JLQtHa/jemj9Y?=
 =?us-ascii?Q?m7RzLIdbhaE4Y81HLFRt9uvo+On3jPmqITdModFly963jaPYYCFI1Jg+i3qD?=
 =?us-ascii?Q?gv6TdrzbRXAdu+oZqkUrriUY3ngT46N6WMdJj0+f1chBWTVla3BcfHEp+Q9l?=
 =?us-ascii?Q?RhjUT6vwbinw6tkmCMNkWyL85C5tHkuHwPsRCxDLaGdZ6EHNpWT5p38lK0Bb?=
 =?us-ascii?Q?E/p1YUa3krMQjGta2CjcVwfzhbAWz/RholrOMsDpr/4CzrWCCZgciuWXOGA3?=
 =?us-ascii?Q?GehdA3AcfzOLnVpvMnehAeumZ9XJNrqpYzu0XVDBVHCUKoglX9HvV+WSzK/a?=
 =?us-ascii?Q?DeAIgzHQIIxh9MueufYZtG5g9C0uqbv0gjPCsminAHPQPsZQmwxcCMT+BkHu?=
 =?us-ascii?Q?vHbuS0s+obBN4eXRHAPkB8ZlTRWUdIf0MDvgfrCEFSx+6M9lhEquWGyaPqAv?=
 =?us-ascii?Q?xcCryQNdRJTaHyQtbpB9t+AMW8QlHIMdENxW+tDay9BoAy+bXelp6INh+NSC?=
 =?us-ascii?Q?j4ofMPVJloQE7Dvfzh1Okt2ijLFDgQ/j7zMHygLGyen8ZHg0eZsP9gCkMvfe?=
 =?us-ascii?Q?tRlUbiiaMkl4KvxahiGhNw4A3emyvNsAAUYt2V6UfpvtCnExlyiLT6VwXkuY?=
 =?us-ascii?Q?ME0Gr8pL9iUsD9BpuNsySV8B2061DV8+dgAa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 19:20:45.8022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aee2f18-135b-4da9-7a7d-08dd7b8974eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
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

Enforce isolation serializes access to the GFX IP.  User
queues are isolated in the MES scheduler, but we still
need to serialize between kernel queues and user queues.
For enforce isolation, group KGD user queues with KFD user
queues.

v2: split out variable renaming, add config guards
v3: use new function names

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c58d32983c45e..e1dca45a152b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1970,6 +1970,9 @@ static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_device *adev, u32 idx,
 		if (adev->gfx.userq_sch_req_count[idx] == 0) {
 			cancel_delayed_work_sync(&adev->gfx.enforce_isolation[idx].work);
 			if (!adev->gfx.userq_sch_inactive[idx]) {
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+				amdgpu_userq_stop_sched_for_enforce_isolation(adev, idx);
+#endif
 				if (adev->kfd.init_complete)
 					amdgpu_amdkfd_stop_sched(adev, idx);
 				adev->gfx.userq_sch_inactive[idx] = true;
@@ -2027,6 +2030,9 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
 		/* Tell KFD to resume the runqueue */
 		WARN_ON_ONCE(!adev->gfx.userq_sch_inactive[idx]);
 		WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx]);
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+		amdgpu_userq_start_sched_for_enforce_isolation(adev, idx);
+#endif
 		if (adev->kfd.init_complete)
 			amdgpu_amdkfd_start_sched(adev, idx);
 		adev->gfx.userq_sch_inactive[idx] = false;
-- 
2.49.0

