Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0869C83F0B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD7D010E63B;
	Tue,  1 Jul 2025 18:45:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HGLC6n2y";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C30510E639
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kxefn+zCTsooiWu6GZ6G245yZxXT2Bd4Rtxcci0NiDv5V/s9NTaJkRSvS3/GxznC+uMpIBLfbSC2eUZRxYzJrzylnSB1wrlK1DcGire2+F/XPHCaF3l++mBHbsLbbAYBiHSPNLEvyJzG1YhnTGWWX/s43UFGhut/mLICCLAp9YfTitdV8j3rc2aL5s4FmWS43PqeOjw7LX1E7agQ3Co9CT5DAfqrCVdFjVlT0aE27tJ73+zvDlLSv1M4GbwUdLBZ+v64OIJMzPZXDTk5qm8NvSGpSeVSQXGu/Kmqhf9fFUZasKqQUMM/kyzSeWlQ4HL3lUmcA0OQ/gbT71ZO/+uOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqklPXV9ZwwFOEi8iGogzjUC6dcnIRffEL7tLVPHshU=;
 b=midslADAAQY13Eja5NSiWLnH1dFhoxF+eUs3Pycv+jSTAn5zqANy5ulAP3R0ujm6rGZyYIXj7VHjh24VBaZSpzj/D796b5C1d3Fm3SImlemBp4f9dTUjrxffq3vkxLeG4yXFwY2rId6KyONKqAOWq6Wla6VWAKF2504iYVTk9GJOsYKXQ5Mo4H0YHFW3B5y3uHToP1r10sCuhyqs8IfDZ6BPOogZyrosXWtvghVi0tQGstJooq682EQfwtdZTUkN6GhtXfPhelkNqx/pAxMPB0FrUfq3IHBlgIBK5PD+h+lv+/O1I9BAQq2yOGFo+pNYGPayUD791FRuNziGoMdDgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqklPXV9ZwwFOEi8iGogzjUC6dcnIRffEL7tLVPHshU=;
 b=HGLC6n2y28qBNw3l8UbUjC488dJHw6gBzjDN2h91pSWN7ZfMsgigeAtCrsdOCxbopOyazgGeCUyqPZriZgYS5+JDFgHNieICDFnuxHSTtwYAOJD9iib+Ptvdu2ON23tgTAtEh6MesbpsypEHjEzYeeaUdghQu5ax9qdS19hjyZw=
Received: from SN7PR04CA0023.namprd04.prod.outlook.com (2603:10b6:806:f2::28)
 by CY8PR12MB7314.namprd12.prod.outlook.com (2603:10b6:930:52::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Tue, 1 Jul
 2025 18:45:21 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::a5) by SN7PR04CA0023.outlook.office365.com
 (2603:10b6:806:f2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 18:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 25/28] drm/amdgpu/vcn: add a helper framework for engine resets
Date: Tue, 1 Jul 2025 14:44:48 -0400
Message-ID: <20250701184451.11868-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|CY8PR12MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: f8df38b5-0bf8-4e9d-0c00-08ddb8cf6eb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fRltyYofnmrwmL9gu2sM5yoRJjWMIdYdkI8mIFHT1J1xwylP4RApwA4oMsN/?=
 =?us-ascii?Q?k0dSdRUC9q5ZKrTLQEWfWI/oWEnjh2V2HzVNk1+r3JBZ76AosDXXFOOtzrKw?=
 =?us-ascii?Q?aZvi3vCzbjrmigQDfJ+DfPGgbbB3qKMfu8oUjQZvrGOTIdd6cjlOdiP7457K?=
 =?us-ascii?Q?0G9qTrcioDfbXE3ygyTny/1yt8O3L0bts74DirTtPmFLXqNGFosMrLBV/vfj?=
 =?us-ascii?Q?GQt61getc2h8wSzf4kiFM8yTvb9eDv64j8VSeWm415jhTaXKAUPdK5OAncjC?=
 =?us-ascii?Q?Jir0S636K97VyZbjV/vMgdzUYRPMowPWpim1lz0054MWS2MGVFPR0k09OjWl?=
 =?us-ascii?Q?OCcWrmmyieDBKFo3unJYw9B7y0OzPzVdlItVbTQypukHMNquag023t9LiI60?=
 =?us-ascii?Q?BmbfkweRB2flJX6gq7i0101pJc7jN1KgUn3VeWMmqn2w5p74r50VYIh38JkW?=
 =?us-ascii?Q?Xvv4G32BELtfi9LtiwezSR3WdkmjVKU5uWhK8O1foVozvMoBeHfKeFQHVyGX?=
 =?us-ascii?Q?8SYFTtZKOxvQNZjtylGYPlFtnVytrMiR4W+Lxxx2pXFMMfhjngP4CFu2YjHE?=
 =?us-ascii?Q?IYI4SBzLW3LgCSbe+XLA+MM04I/o5r0Cqp7l+WBjOrmwltefVNjXYfkQcuZo?=
 =?us-ascii?Q?yf3mhmjtBJgKdQeed4N30SKiXOCK7+Mfs/xT0PK1mrhlNa2aRO0m+0vko/P3?=
 =?us-ascii?Q?XieAgw8jfkqMPoj94wjXXtHsY3W4APeI7753RYo+v9vlD21nIhlc+O3NyIb3?=
 =?us-ascii?Q?Y8VunYCEc+NZXKEOz1elyyS3C541yaeGUlpTJ5vRCnV0BwqDjThZUq5q/69g?=
 =?us-ascii?Q?FZ9s5a1N8yvLNGYKbyXsPMKRCXdncoLL1ud43IVUrKgtcJuNUqqfUx4RnLnJ?=
 =?us-ascii?Q?0g82bPCrlEeHFGINPZI49Zaj0eBwbYI/n5IwoMdYOkhaPegmTPvu9E2Sw0rU?=
 =?us-ascii?Q?C5edhI7GkSl8S6kcaEQjc113xc5wlH1jLIWC7WJuu+bIjT9/4BPKlqau+627?=
 =?us-ascii?Q?6aEEFEWxUJB4ZKc2JPCRqoFYW9wCk0AbiYtJmz23Wyxj+H+eutJoJwI6Ln+C?=
 =?us-ascii?Q?bVmB73C1LrHOTIfpus7yQK/O3m4UfPab5Tff8K21qnXpOG2CgjU+Ulo1pFHP?=
 =?us-ascii?Q?9A9bi4zjoZ4T0juAJlhsufoIVjdzDLPWCop4BSjdznyulx2R8ItcdfcT0mXX?=
 =?us-ascii?Q?kfhzx2JKqJjNqoqZ4KegrzY00bk/i3rFDVubMvKbFhOsbvyHhwUEQ2uLe8/n?=
 =?us-ascii?Q?e5666enKsmrFgEyIs8itmMPhsaV/L24ScnQEm5QMBoLB0QzJuM5wPuZjGTMv?=
 =?us-ascii?Q?rgPZGsNM8d7lYTBVCVzlCXRzhPjJCKLoiN1DYsqu8cymeIHhAaEQ6i2IdHwz?=
 =?us-ascii?Q?7/NV/oigBAEFucHRcPX+6M4kXX6t9VQnRDNBskUKaHas/WuiL89XVRoNR6KO?=
 =?us-ascii?Q?llDv0ayho+3u0bf6kA2m3hodtfcURtv32zxZD6gAJNBfjNUS3bH1VB8GTL0m?=
 =?us-ascii?Q?NS0vhgYWpIolb4oPAg1TdaL8ybngVlz1MitR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:21.0670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8df38b5-0bf8-4e9d-0c00-08ddb8cf6eb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7314
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

With engine resets we reset all queues on the engine rather
than just a single queue.  Add a framework to handle this
similar to SDMA.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 76 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  6 +-
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index c8885c3d54b33..f1f67521c29ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -134,6 +134,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
 
 	mutex_init(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
 	mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
+	mutex_init(&adev->vcn.inst[i].engine_reset_mutex);
 	atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
 	INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
 	atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
@@ -1451,3 +1452,78 @@ int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
 
 	return ret;
 }
+
+/**
+ * amdgpu_vcn_reset_engine - Reset a specific VCN engine
+ * @adev: Pointer to the AMDGPU device
+ * @instance_id: VCN engine instance to reset
+ *
+ * Returns: 0 on success, or a negative error code on failure.
+ */
+static int amdgpu_vcn_reset_engine(struct amdgpu_device *adev,
+				   uint32_t instance_id)
+{
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[instance_id];
+	int r, i;
+
+	mutex_lock(&vinst->engine_reset_mutex);
+	/* Stop the scheduler's work queue for the dec and enc rings if they are running.
+	 * This ensures that no new tasks are submitted to the queues while
+	 * the reset is in progress.
+	 */
+	drm_sched_wqueue_stop(&vinst->ring_dec.sched);
+	for (i = 0; i < vinst->num_enc_rings; i++)
+		drm_sched_wqueue_stop(&vinst->ring_enc[i].sched);
+
+	/* Perform the VCN reset for the specified instance */
+	r = vinst->reset(vinst);
+	if (r)
+		goto unlock;
+	r = amdgpu_ring_test_ring(&vinst->ring_dec);
+	if (r)
+		goto unlock;
+	for (i = 0; i < vinst->num_enc_rings; i++) {
+		r = amdgpu_ring_test_ring(&vinst->ring_enc[i]);
+		if (r)
+			goto unlock;
+	}
+	amdgpu_fence_driver_force_completion(&vinst->ring_dec);
+	for (i = 0; i < vinst->num_enc_rings; i++)
+		amdgpu_fence_driver_force_completion(&vinst->ring_enc[i]);
+
+	/* Restart the scheduler's work queue for the dec and enc rings
+	 * if they were stopped by this function. This allows new tasks
+	 * to be submitted to the queues after the reset is complete.
+	 */
+	drm_sched_wqueue_start(&vinst->ring_dec.sched);
+	for (i = 0; i < vinst->num_enc_rings; i++)
+		drm_sched_wqueue_start(&vinst->ring_enc[i].sched);
+
+unlock:
+	mutex_unlock(&vinst->engine_reset_mutex);
+
+	return r;
+}
+
+/**
+ * amdgpu_vcn_ring_reset - Reset a VCN ring
+ * @ring: ring to reset
+ * @vmid: vmid of guilty job
+ * @timedout_fence: fence of timed out job
+ *
+ * This helper is for VCN blocks without unified queues because
+ * resetting the engine resets all queues in that case.  With
+ * unified queues we have one queue per engine.
+ * Returns: 0 on success, or a negative error code on failure.
+ */
+int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
+			  unsigned int vmid,
+			  struct amdgpu_fence *timedout_fence)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (adev->vcn.inst[ring->me].using_unified_queue)
+		return -EINVAL;
+
+	return amdgpu_vcn_reset_engine(adev, ring->me);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 83adf81defc71..0bc0a94d7cf0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -330,7 +330,9 @@ struct amdgpu_vcn_inst {
 			      struct dpg_pause_state *new_state);
 	int (*set_pg_state)(struct amdgpu_vcn_inst *vinst,
 			    enum amd_powergating_state state);
+	int (*reset)(struct amdgpu_vcn_inst *vinst);
 	bool using_unified_queue;
+	struct mutex		engine_reset_mutex;
 };
 
 struct amdgpu_vcn_ras {
@@ -552,5 +554,7 @@ void amdgpu_debugfs_vcn_sched_mask_init(struct amdgpu_device *adev);
 
 int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
 			      enum amd_powergating_state state);
-
+int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
+			  unsigned int vmid,
+			  struct amdgpu_fence *guilty_fence);
 #endif
-- 
2.50.0

