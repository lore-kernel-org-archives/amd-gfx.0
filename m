Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A981EC61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 04:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DD0E10F233;
	Fri, 28 Aug 2026 04:16:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xwn1hoBK";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010065.outbound.protection.outlook.com
 [40.93.198.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A755910F232
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:15:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtcykU8jlVVlfIK5fTv0RfKXzPp704jO7m0AwmHabr6tvJeLmcnVAbxi5eTD13zM9g3JU0jOEIO7CFsqPctO9NsRZYpAMMQvyuaT2+WT/ro2ThaBn66Ka/c743+ecC4gJEVFBKy3UVwZBMAuwI9mH7lnbb9E3DC7i8wuwFeZMbvyz+ViOePUVeEiH6EeliT38EddAdd530Q2aXuQ63hJr2WKGYG9r8gNxrt8qyvvwMPI7/FUZN9zgrva0bG0fBR0pOQpXYq5/9GbpNS/TRIjCmnYu0N1IsXfTCUw1wwSjW8gLIIjhaPR8XnckkreMyoXzVhw7M6HS/2H06Tdw9OZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RR3h4p0XNb1Yl4rQ37B92gFyar7XoLbzQOU5bJnjp+U=;
 b=JbIX1CxIpFxbhxFZZuhwC5jHgvYgH6z7GQ4OEcP6o2vUC4Nu2tgUyTThrTTklbjBRoubFnGSZhWseX78ACA1/d5ZpEeeF8iCCxJa1/ONjQHboUpPi5w6SCVizotaZqPjIlRqLOMzR0Izy3u6DeUzZ93RqGSv87Q3sEJnKOC+HobewiXhkjI3UP+93nQMyQl48Oo54Onl83CuyPUHlSTP4hJOeCUODTS6faM1sT0tJaxEmrsXJcvuKuYhJpq36ohsRSM2Aob/YSie48q4ZoK/r/Y/kZs7IchabRMdTZVPM3G9xuHraSLbMyAgNvJBXyYjJyhkgre2zp9ZsNdDTqJtWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR3h4p0XNb1Yl4rQ37B92gFyar7XoLbzQOU5bJnjp+U=;
 b=Xwn1hoBK+Hhs2Di7nenkeR9TB+rrpCD3Wfq/zkjd9RSA/Gk5WmOpFosE0Ssdtzr6lRlehDgD09oU83HGgoh9JtBQn8ga7806XHQHdAH+ziBOZLpV6bie8MOyTxUIRb7wPcbYvMS+PAp425M12F25C3CoyIq0J6sbr2f2Ttma8g4=
Received: from MW4PR04CA0388.namprd04.prod.outlook.com (2603:10b6:303:81::33)
 by LV8PR12MB9642.namprd12.prod.outlook.com (2603:10b6:408:295::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 04:15:48 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::7d) by MW4PR04CA0388.outlook.office365.com
 (2603:10b6:303:81::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Fri,
 28 Aug 2026 04:15:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 04:15:48 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:15:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:15:47 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 27 Aug 2026 23:15:46 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 03/10] drm/amdgpu/gfx11: implement compute and GFX
 update_mqd
Date: Fri, 28 Aug 2026 12:15:09 +0800
Message-ID: <20260828041537.3464782-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
References: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|LV8PR12MB9642:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1a35e1-c792-4d21-eb60-08df04bb0a0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: N1+gzOvAn9FB/Jds3sFEWRJ5keAHEuI6n8pP7munFmiAJWTtWeRNvxz7wAr2TjDoyaCOnL+JkhNnN3gaph6kV1llitSrZmfA0C3qxaWHZw+aCm/MAFVZzjDqQlJwt7WNv6Ym4fK2jm+Y8yNOibRySp/04qnNULAPUI5HgXERUWch+Z74GoJ0wbQIwbnDZJTV30x4DcBPOBAFhGBP3JMWhhmVOpICtvtuimml83jHyjsK5aJIDtQJrb/IDJaC3ZUyijHaq5t/K0gL6GQ/4M+F3zjIeSvy2tSniM5HRqAf2I2/I61idxVztrm8qmDKYUkJsu3LmLiK40lr9pzbN3VW+bC2hXkuduKZ/Xi4yLFrR0SWiBHPnw64UR/9fi4RXuNMf0DDuizl1idG+uGLMcXA3W5t0U2JZslqUYNvC3rU22DFATAJ4paHsAIe2UIuq+W54CdlHMUSdrFg7g4PK8lz8FcNrhFmrLaWJaAsyvaHXqnFqs9LWP+eJaAWP8DqOK7ehz/88neBQuWiLuPnQukgrNQpaniG7HPCGHl3Qm3v2L+C++hTjJjHbOlZEmEMraItT21o8YrijOF0WgAupToKqv3S6tc97MsoHX8z2pPGVbWtR3mbDkT8FdoOcqevTc+kLX8GT9+G1bNTiPS+dlE4uPa3fLXe7JR3AaMave3pULJ2lipphYJk9SiBVD0LwfZq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EQR6Qt86VVYPf83TbFb0uCo0clehg9nCKeil4e5shsKHbW5D/96xeI25SbOVKinoWR8QwbRCkiOe7PL3c1fcpH9+UOMNaCfi/lJkA3yS6cqq98BwcF9YgOxTcDSkoq8WiY1oE7yevOovXvhcyrPJkuV7M/MQWn95pX0SB4hPS/z+piGmpQ66O58IY8IsiO6v50lsd9oJOzSTxerZDRDOha46zLbxGUVcRMFr3g5JKpRtgmkb7N21azUUDPs9IA8Izxn0jH8/rkPQnE5UmZD3D9+LS5Z1RaCUTqjO618fr+vt+GmFyTRbBeGz8zYUjKJlB7dVgsI82OUMAKTzuod7fKIXXfIrhRxfOIsIFlc1wbA40kBoX7OrP1tq0RWBx4M2W2fTabc44XO9s0Jr3DqS/aO1jXGt235DMrxAhli9TCIGi+rZPaUVnohiBUr+rfnI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 04:15:48.2601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1a35e1-c792-4d21-eb60-08df04bb0a0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9642
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

Implement the update_mqd callback for gfx11 compute and GFX user queues.
Save the read pointer, re-run init_mqd to rebuild the HQD, then restore
the saved read pointer and forward the write pointer to the user wptr, so
a re-enabled queue resumes at the first un-consumed packet rather than
replaying the ring from 0.

v2: rebuild the HQD via init_mqd and save/restore the rptr, matching the
    SDMA update_mqd style, instead of patching individual MQD fields in
    place. Keeps all update_mqd callbacks consistent.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a447562977ab..1feb7c9ee5c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4256,6 +4256,26 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
+/*
+ * GFX update_mqd: init_mqd resets the ring rptr/wptr, so re-run it to rebuild
+ * the HQD, then restore the saved rptr and forward the user wptr.
+ */
+static int gfx_v11_0_gfx_mqd_update(struct amdgpu_device *adev, void *m,
+				    struct amdgpu_mqd_prop *prop,
+				    u64 user_wptr)
+{
+	struct v11_gfx_mqd *mqd = m;
+	u32 saved_rptr = mqd->cp_gfx_hqd_rptr;
+
+	gfx_v11_0_gfx_mqd_init(adev, mqd, prop);
+
+	mqd->cp_gfx_hqd_rptr = saved_rptr;
+	mqd->cp_gfx_hqd_wptr = lower_32_bits(user_wptr);
+	mqd->cp_gfx_hqd_wptr_hi = upper_32_bits(user_wptr);
+
+	return 0;
+}
+
 static int gfx_v11_0_kgq_init_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -4477,6 +4497,26 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
+/*
+ * Compute update_mqd: init_mqd resets the ring rptr/wptr, so re-run it to
+ * rebuild the HQD, then restore the saved rptr and forward the user wptr.
+ */
+static int gfx_v11_0_compute_mqd_update(struct amdgpu_device *adev, void *m,
+					struct amdgpu_mqd_prop *prop,
+					u64 user_wptr)
+{
+	struct v11_compute_mqd *mqd = m;
+	u32 saved_rptr = mqd->cp_hqd_pq_rptr;
+
+	gfx_v11_0_compute_mqd_init(adev, mqd, prop);
+
+	mqd->cp_hqd_pq_rptr = saved_rptr;
+	mqd->cp_hqd_pq_wptr_lo = lower_32_bits(user_wptr);
+	mqd->cp_hqd_pq_wptr_hi = upper_32_bits(user_wptr);
+
+	return 0;
+}
+
 static int gfx_v11_0_kiq_init_register(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -7271,11 +7311,15 @@ static void gfx_v11_0_set_mqd_funcs(struct amdgpu_device *adev)
 		sizeof(struct v11_gfx_mqd);
 	adev->mqds[AMDGPU_HW_IP_GFX].init_mqd =
 		gfx_v11_0_gfx_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_GFX].update_mqd =
+		gfx_v11_0_gfx_mqd_update;
 	/* set compute eng mqd */
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size =
 		sizeof(struct v11_compute_mqd);
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =
 		gfx_v11_0_compute_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_COMPUTE].update_mqd =
+		gfx_v11_0_compute_mqd_update;
 }
 
 static void gfx_v11_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *adev,
-- 
2.49.0

