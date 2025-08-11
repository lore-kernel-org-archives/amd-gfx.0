Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE8EC88CB9
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 10:00:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25F8410E407;
	Mon, 11 Aug 2025 10:00:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cEvvl9ut";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A44C610E405
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 10:00:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0k+QLw63z/C9fneqckG6If7pha4LS8VznSxJSaCKBoNA2LBry81YQCRzlpzVTK3+hjA+yA7rw5RJIKV7sC/ypyzc2nmsysi+/rQF4Os4Wiqt/C/H4S8yGchWsv7zJ6PKz3mF+EKAnLX0uvIMWQbgg87fLzKKSX7WPHQrlbfmgRyEGvOw5FgrAER888glLr+4aRJ41WqvxeK89ZAqXD4kndXS+bbLcSfNyKV9GIE7XJnQZvHV7C7vYlh2u3NBPG8OzmlGuiCd15nb3NFfXhhI57P7VsmSFJuawuID51FB6zMHUVSfAQpZ0NAp7iwwYhMn4VyWNWADxsQgwef2UbPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdTlMrdQ63wOTWZG0i8a1tsZL2cS2BSA7Qs4lT99uYY=;
 b=dGNc/roOUPJWLbOGeXYiMoyoA7iIjehUseCJGxKUHZGatrVwoEdQTZGgOYn1UatxOLU3D98jCbbJy3ooL+Mgp932REgPrU1AtjCKbJ/a3ZkLWLYDVXAqfOXE5uVT6ZXLgCvTIudqwm9OQxya/Fj34mFTKfStHGRIHWOyXypTBlCpePm4MgifJ/5HJCPoSmPUVD109qvv6TowelN84j329ASVvOvhxloY24UWGj7pe0NxSUS8WaignpkFDj+n8FPi3mP+sCAoJUPaV4w1hVkBzwZjPjbkBa4KrAjmHEsYsDkIB592hIWHG+0d98Ttw/77P6IhpDmu0llv8iW5RJF3Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdTlMrdQ63wOTWZG0i8a1tsZL2cS2BSA7Qs4lT99uYY=;
 b=cEvvl9uthM9rpyv3XrXzffv8z2Aq/jtoxrLtwd/d+GMR6+uw0hiTOZjZqFNQhutRkLEDU5WDee1aVGtgdj97PxvJzByZ48jTR/6Oxwh04pex1+D96Xe3HslXkepcom5CdEpAGx6Ul0ffjP/OXnHaz5M3foKBKJn28AZ7pr6HfPA=
Received: from CH2PR14CA0026.namprd14.prod.outlook.com (2603:10b6:610:60::36)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 09:59:59 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::58) by CH2PR14CA0026.outlook.office365.com
 (2603:10b6:610:60::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 09:59:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 09:59:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 04:59:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 04:59:58 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 11 Aug 2025 04:59:52 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v8 03/11] drm/amd/amdgpu: Implement MES suspend/resume gang
 functionality for v12
Date: Mon, 11 Aug 2025 17:56:50 +0800
Message-ID: <20250811095937.1978747-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
References: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbca068-7226-4a97-b858-08ddd8bdd523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dyE9K32mWHU6Bag7sfcZxE1+uy/R4hA+LCUO/irlQTOzAuPfmuOuc6r1KY5p?=
 =?us-ascii?Q?8rEJlgzeSLZIf7zVTAfzkSJiO+nxWXJY3wFo8WGgNsY+Y0ifCY4idPK4RIhi?=
 =?us-ascii?Q?823B0KwdW36bxPCS2C7tHePOkjYgt+K/Cef3QL4c49zyOeuUatJT5RoMbQ9I?=
 =?us-ascii?Q?s/S46wJeJaZrOOsHmlGxIsPCBQhRkF3Xih3gzpjXKlmi4oebb4EhgR666EuR?=
 =?us-ascii?Q?sNlJQBRy4pznmD698FAC0zB3s59F4AsVq8TKFDNYtSj2RUElNpqNLUuLkFtn?=
 =?us-ascii?Q?y5OSTgnO5K8UlXJoGoib/SniGdAl3Z8TjFguXmAraCR7zDe/t/LfPA/m4qeR?=
 =?us-ascii?Q?hFVrCxbpA5luRlcdJhxnURQI4oiLU1f4DRKQr+zIC8R4xh/YL863I0rXeV4H?=
 =?us-ascii?Q?In1Qbe/DC5MOPkVmbNNnl5GU+rq27a9O/pOjdtDjBp/Kw1YtcSA7InUA43Bj?=
 =?us-ascii?Q?Gw6AEZ7TuYeao5aDfT6c3o5W+kiDcuapxDYxN2kM5h0hqN3mBmPmSuwH1ZRT?=
 =?us-ascii?Q?94UhofFLaFi0HwW4qiN5fr3r79nn12wS6hnjx0w2tMx7k3eK64X77jkrPNQR?=
 =?us-ascii?Q?QkwxUw4RgZ4Wuk9hKcS0MewarydKJDrym4f2eO3FhHycidF1zl1RPBi+9mT5?=
 =?us-ascii?Q?4IbKtNTKqr/59IE5U5d1WINYzSlmS5HglRDgJCdsSgDIJNSJFG2fVOP2gjos?=
 =?us-ascii?Q?UycpgGKeUDt4J377v1F7auqXCMdaLgEbV4eajs3LoIBzxQ6ywiCK0tSAMZut?=
 =?us-ascii?Q?5L63oauowDE18EvRlLNkwQX19vLZMTtUy5t1xMHVwFXmIs4Kr6naJAJEt0ki?=
 =?us-ascii?Q?fIYVQl34ISHF1v9V4/Mm5ABirt+Hv1c6kaUOUPYcsSCY5436YPPgFcpY6Ps+?=
 =?us-ascii?Q?Ddimnrd538b57z/ERjr/jIDFSRw62IeWXRiqFHVGba9qvFgRctGuF09pdztu?=
 =?us-ascii?Q?6MBbXn2FkVd1tJ5yyZEjxLalVFH9fcXJs/85PHkqR82nM6VXyxq2QA17Tz4A?=
 =?us-ascii?Q?T2uMA7xioZsiTJgDaXBEhE/2eL21WFK8yUWvAb+5dgO43xtWahLB09VGL0Re?=
 =?us-ascii?Q?3XaCabyo/cjeG1kmlGa+sNwqJAMGt3V3eT8Mz62PxV2jQ5xCGHz6Yc5Ygwyt?=
 =?us-ascii?Q?ZKoz5krHQPSPbTD+qVgSftVog59sKuSSPGuQf5giIQgfMzvH3ymZAkzcGpYY?=
 =?us-ascii?Q?WuwzmJays3qgiGGYe1VFOIrJwLoWjo3lOY3J/goUjq7vlDNub1xNxdY1uTJ4?=
 =?us-ascii?Q?n5dv7c18ggzYChj4zHl7IARSPYWZLzKgbo4UzCT1k+wh42hXLEmX33kkXxIN?=
 =?us-ascii?Q?LnE5V8g0EclJO1ALSD7UNKKLk/C6rmHwg9b0itYM5BrqAyd+bt+Q0fpCVge9?=
 =?us-ascii?Q?+N2+LvzsEFA/NubXaFfYh+eORnAziRJcgIrTsYHi8tWcYLEK6lM6YQCfnls9?=
 =?us-ascii?Q?eD3QYRFGh83ew5MDPa6mEDtpz03JigDi68YCCZXLowF9T/vEIfWiZln/H5io?=
 =?us-ascii?Q?hago6EMFBzpDjuR4Wxt4Q0t1Wc7O2TPnF1C4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 09:59:59.2238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbca068-7226-4a97-b858-08ddd8bdd523
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302
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

This commit implements the actual MES (Micro Engine Scheduler) suspend
and resume gang operations for version 12 hardware. Previously these
functions were just stubs returning success.

v2: Always use AMDGPU_MES_SCHED_PIPE

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 32 ++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 6b222630f3fa..24c61239b25d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -567,13 +567,41 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 static int mes_v12_0_suspend_gang(struct amdgpu_mes *mes,
 				  struct mes_suspend_gang_input *input)
 {
-	return 0;
+	union MESAPI__SUSPEND mes_suspend_gang_pkt;
+
+	memset(&mes_suspend_gang_pkt, 0, sizeof(mes_suspend_gang_pkt));
+
+	mes_suspend_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_suspend_gang_pkt.header.opcode = MES_SCH_API_SUSPEND;
+	mes_suspend_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_suspend_gang_pkt.suspend_all_gangs = input->suspend_all_gangs;
+	mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
+	mes_suspend_gang_pkt.suspend_fence_addr = input->suspend_fence_addr;
+	mes_suspend_gang_pkt.suspend_fence_value = input->suspend_fence_value;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
+			&mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pkt),
+			offsetof(union MESAPI__SUSPEND, api_status));
 }
 
 static int mes_v12_0_resume_gang(struct amdgpu_mes *mes,
 				 struct mes_resume_gang_input *input)
 {
-	return 0;
+	union MESAPI__RESUME mes_resume_gang_pkt;
+
+	memset(&mes_resume_gang_pkt, 0, sizeof(mes_resume_gang_pkt));
+
+	mes_resume_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_resume_gang_pkt.header.opcode = MES_SCH_API_RESUME;
+	mes_resume_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_resume_gang_pkt.resume_all_gangs = input->resume_all_gangs;
+	mes_resume_gang_pkt.gang_context_addr = input->gang_context_addr;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
+			&mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt),
+			offsetof(union MESAPI__RESUME, api_status));
 }
 
 static int mes_v12_0_query_sched_status(struct amdgpu_mes *mes, int pipe)
-- 
2.49.0

