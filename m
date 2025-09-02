Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD2DCA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 08:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9272010E5C4;
	Tue,  2 Sep 2025 08:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uT2oAX4u";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8FDB10E5C4
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 08:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1GwXczA8vLGblzQWUr0nAcQzfyLCrO7bsbxJwUXBzNNzshHGNgHOfCo6cqp0zb0ppj8K0MReNmHMPe+A3MekzOWjIu7iqsE/OrKWEqU/WSoWVXK8zoeTEKIcQ21IsnK4ExTtQ/dXE9p0psDTuNHmHDLyHbFFks3UIK0IGPxXq0BQ5DDeZMGBapB+p3Ry5JY2kZYp/Q0O32qVGtCurgNnfvAWmMi4V7hEqF1GNcfAOw0X4dVeq7n1o45Eiwf9mqVdsCsuO1xK5KGuHNHrMdnYtnKy/bdoFQxLlWHlcLIp70J1T+Xr7JORMrq4XTyJ3KIm9o/6huaB84IVtqgDDsUmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdTlMrdQ63wOTWZG0i8a1tsZL2cS2BSA7Qs4lT99uYY=;
 b=hIgqHUp4bMKs3vLHEvK5F6dBoDaD0StVSijdzEwy9TsNEK3WboqMRVv6+V3Z6g95aAhgT8MxXEiY9oJIO19iUnfsSkD7sQrydn+S4W7TnMlsDI9LXrOQoTCkMIZgdjYwsKOVhmhv3ktlPtSDXVx+uXB7FUdv7WdbyUr0T6TETY9//z1AGgkn9JyJs4ZTUGZGsL1EJLhdsvU83+NuQ3I5toiXC7r1oGd419/QhcJFd7LcvYx5tMKp1uaQC8Loo1OGNFnAgJMD9q00fAOogsarIfl8lNNrTsexzWjM8gDrXorLv010cZg/jUHBfaoye+1It02P4zMqIZdoym2cWBxYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdTlMrdQ63wOTWZG0i8a1tsZL2cS2BSA7Qs4lT99uYY=;
 b=uT2oAX4uaHI9cPkYCGn3Pl4soGLPLSvAvFHH6YsF+RYB+NiiZHP4SAbfmTIhTLs4XbGie5tpS+iwSjT/zRbkBKVjBFbzaawk9hoVJSzQT5qPpfTGIjb4CNsdAu2rkWFDkNGOTyfvK6OAB7Df888/fqGeNN56pkT2tiM+Bk8qvF8=
Received: from MN2PR18CA0022.namprd18.prod.outlook.com (2603:10b6:208:23c::27)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:07:35 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::94) by MN2PR18CA0022.outlook.office365.com
 (2603:10b6:208:23c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 08:07:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:07:34 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:07:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:07:33 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 2 Sep 2025 03:07:26 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v13 03/11] drm/amd/amdgpu: Implement MES suspend/resume gang
 functionality for v12
Date: Tue, 2 Sep 2025 16:04:04 +0800
Message-ID: <20250902080712.2515811-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250902080712.2515811-1-Jesse.Zhang@amd.com>
References: <20250902080712.2515811-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|MN2PR12MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: 23bc78a5-5458-4492-d3c9-08dde9f7c602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HuDhxReV07yJIANaQOedjXqqABnPQKdM3O1I9xdSlQdaLYeaSQWdecoCU143?=
 =?us-ascii?Q?bz1/tfgmcdJVWYxzl0D2lL9XCj13hNWaYYZ9i0ZERW0FraaBv1w4e81OvY/G?=
 =?us-ascii?Q?rifTzzquVcAflHYhyDO8Ge7VmpyCRbJLdXQqt+X8YdDacsZE5P7wyc7ioS1k?=
 =?us-ascii?Q?4ubQpEUyO75lfxWmdrZjFvLqCiYqiuYJWUP0Hf11q4nt6pd6NU+4VBLw20z8?=
 =?us-ascii?Q?eeW6ktkzcYryyjGWYGxVhXFUpECoa75vydPpShXjG24H4QfMyU9GFIzgm6MF?=
 =?us-ascii?Q?guigCKxRVEc0DG+YZDx73XPKegt3kB3oLxxm5N/TFPnf27Lf3QyYKZNYHODW?=
 =?us-ascii?Q?fgpkHtzArEvJ68jZU3hxHr4pgGD9HDxKvraWZdpjR44AxZ1bXnPcQbqdDR/H?=
 =?us-ascii?Q?gkNMyiNLXLplQx5nZrVOx//sAM28eUpwvxCpp5X6nTpfVYkUY3ohWYeTGd2F?=
 =?us-ascii?Q?j7JHEkNsGC8OvnB52GdBLQuICLnuxwFhLdWkPy/GVK/51BcbLRXHZFUbha36?=
 =?us-ascii?Q?G+Mi6/kGgoFNcMjwUMsUsVB2sWzp+L5GtLC8biNoB6E1LKWBR+r3iXis7lhc?=
 =?us-ascii?Q?vKaS6s2W33YsaDzk2n0ZOx5LtroYz+C4YAvFV7QKIX/eRm8tQHYWtocs1OJu?=
 =?us-ascii?Q?uC2DHZOvYv/+VD6sg9IlvqkoUTe+0yI2IfNaQke8XhXzytwgRmT6TfSkyVNh?=
 =?us-ascii?Q?CWzeSxiUd7X3nbIloLuIZ9sPvw3cfA/ISwvVEUk6LwpL9/x0Ub+Ex2TBw9gP?=
 =?us-ascii?Q?SJl/Z6P1z7crqx4SvVzr4+y3CS7KPL0PXLtyjnUMW3cvcLQTXPJyWXaOqTBz?=
 =?us-ascii?Q?fbFVCKmZQ3NcECe1v8YyHNT4gF0vU6qbtKnaFjbRYiJoRZShLMSoV6CsftDm?=
 =?us-ascii?Q?71cXgyrnOIs7ApaB/xF73x15xW0chD00yQkBf46ZrehSofIXvviFsDjePyJ+?=
 =?us-ascii?Q?MTcDCgZlkfu57sRFCmgq5mhydCbdV2xLkYhF3v0dlXQQjuBvu9lJgv7dhgl/?=
 =?us-ascii?Q?eipEQ2hZ9pFU1Ho+k6UAxq+Z9NzhJtD88w+/pFi2eF9LcU+QUbezU8CmKlLY?=
 =?us-ascii?Q?ODetCHye0+7fYg2gKDXRSIWdJrzEepnuNseuq6B2UnDbEB1djc7vd8Yw7FoO?=
 =?us-ascii?Q?2yJ7HXJm47sSPOgMtBeEyLimnJLyI/gBubgsyuVdrANukpuT2HcCkrJof1Pe?=
 =?us-ascii?Q?ff2VD4NBA/BpiyFGefyIBUf0cexdZZ6nZD3vLpfuDKYiC3/1R7XHQuKTyL7z?=
 =?us-ascii?Q?SaMyEbvoAeEJWc7wJS1qplOMvilgLiv0tk5lH8ehuE/tuaTAdbRJ/+UoOK98?=
 =?us-ascii?Q?WmKghyMSTDVeqgL4OwKv17hl7ll2cehh13QPYwahB9xnOyKmrt8eVWXtLc7K?=
 =?us-ascii?Q?PHE12vG/3zqCvKv/vABMzdUiB/MzNuTaZDnGLgixGgPm7ZqFkKKDD6uRC9C4?=
 =?us-ascii?Q?fIzkjP4Z3wupEraheWpizJ+E0QK/7f0ha2VbsfmmYw7G6StemTrwyCftR8lv?=
 =?us-ascii?Q?Y2eTQ7HCzj6dq2qRcdgJUHf9D3dB8FpgRuLC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:07:34.4316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bc78a5-5458-4492-d3c9-08dde9f7c602
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
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

