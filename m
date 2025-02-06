Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBB7C02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 09:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A3F110E1DD;
	Thu,  6 Feb 2025 09:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pVrARxl7";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FE7F10E1DD
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 09:41:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZ9xnUiqQIGxVmOHyxw2omxH6Q3BJMkd4fnPE3Ak/hNAQApuIYeaxt3Uo7qtAIlrUvjULKWxQGcl5rO+SnIvPHRHgBhaZOzGP8E0xCTHAAdxepkk2W0Hg3jnjBXYtSf02OWZ6d1BPMi46SXmhsdjLXRFdkgchKX1/EMUeyQhVpXrhz4zLpLUWC0RpgQztxVddiLVeRJS2uULh8slS7CqyMkoXPY7zvVh3uA2rDODWvqzYnLGzVh/l2/idDRizzVpJMHLvN45oMH7+dLRLx4x6CPtxmpB/26cY6NH2pD6YedVFtMmQ3m6Ts2Uz9P+AIRHIQFm+mls3pimbssS5W3YeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXLJcuQ0s2/T1f6zhVpIqD1avXIHIcd1OMdRlIM9sJY=;
 b=xSlHbdijAxEHLOnaFeCN7NbThJoPHeUhIL6SeoXgNw/iorbBLQGNwJvhnZk/ZhDuKrBiEcrVFxdO3SbAbE3gQyUW2VrNFM2nWxw++CKyBfcLR6hXuU+tjKGNo1PPz1DYf1dx0WxTXSoomkRYMu+j90DXjI3itl43fDsjZ62bZlvgun3prmkmXjnQ/G0Jn4MtSw4DNRWNbRD30kHv8e1IwdWreB7H7kvvH8BCO9dMzDlrtjgBSBkUcnwVI0UUodg0PthCHyoJYlZhfGtseiwEZmdZcnO4GnxcdZeesheaCKy3hPWTSmLfQr4zHg2RkDyNRWNh9hSKZjGHzy2fjagalg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXLJcuQ0s2/T1f6zhVpIqD1avXIHIcd1OMdRlIM9sJY=;
 b=pVrARxl7CyDd6UWNaJiPuj4tQwcbbgPKLRkuphlfidfsONE8CzUWWuIxCVwPLaVJEX9n7XKYOnk6K+WMpQi/7kbr0F5wfxA/EThS7zvDEUNQebpRu7K5wqAVrpKVPhclY3BwlPuwCsOx3Jqy5SjRgSmmberXpE8wZO+GUhw9ljI=
Received: from PH7P221CA0073.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::30)
 by CH2PR12MB9496.namprd12.prod.outlook.com (2603:10b6:610:27e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 09:41:12 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:510:328:cafe::78) by PH7P221CA0073.outlook.office365.com
 (2603:10b6:510:328::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Thu,
 6 Feb 2025 09:41:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.2 via Frontend Transport; Thu, 6 Feb 2025 09:41:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 03:41:09 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 6 Feb 2025 03:41:08 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v2] drm/amdgpu: set CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_MODE
 to 1 for sriov multiple vf.
Date: Thu, 6 Feb 2025 17:41:06 +0800
Message-ID: <20250206094106.1562194-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|CH2PR12MB9496:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a74ae7-0a1b-418b-82cb-08dd4692645a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HNL9SfRztinvqK4EWJXJBW7XlYmKmEKABwNPW91nT391mNTFP9UKH0kJCsqw?=
 =?us-ascii?Q?KLWRDbOHL3G2jTQjh0E4J3VnkZqQFve2vmrwTVozYQc9fJeysU2sxtI1wtTG?=
 =?us-ascii?Q?gVc8ZOhRUe5a9BvHqv5K4NqlB8BewUCf45L32WOfsOMJZ4ZIWwhsg/RaAIcI?=
 =?us-ascii?Q?w/yq9ABcBAHzGr80i+yeFc3jIgEcF9JzPMIg8q9x7seN50oFGKkMfJMO9YUD?=
 =?us-ascii?Q?qhYknl2Yt4V4Bc0xi/InP+1zzBqT69tVc9jVMgGsW/4WNE0FQwRGQm5pquqU?=
 =?us-ascii?Q?La8q+i67ODhqBZRDzgPwsw39sHHgroZvG8bYLXaC0UTCnqR0Sm4oS0YaKuNN?=
 =?us-ascii?Q?qEaDUBMCuo4eAFR2xMYjHOopwfh+pa5/n8hpXjdbMjd882OxzyEk7+d04sEd?=
 =?us-ascii?Q?qkY3TMy7JfVlBlNrebOHsKsNIOUov6j8xvmHqnhAWDZK6dXnLTFxLiNR2jMS?=
 =?us-ascii?Q?tukpJDjHvE+2bAOMRonMMEbGQ3+c64jpJVC6+nSxMwGOoQ5wOzafzgSLW9tW?=
 =?us-ascii?Q?/8P1PMF7D6IAw2i9w+oxqI+e6h/t+rIV8oP61filebqnPKiP1zS6hKNxWo6f?=
 =?us-ascii?Q?IX+s7oZrpspccYQkZrEdAG7/H0ilpnzpNmEePefGLFFu0tEsX7eYT8hxLX8v?=
 =?us-ascii?Q?IRm7sqRx9P62OhzZj8fO2JbJRX+XUoYgSfCgpXmNACLzKztNGsBPz2TlT1jk?=
 =?us-ascii?Q?WKKy+dRKu0ZFIGzfFWBb+EUwkdbAQLSd3T3Nb0FFKtWbSJRYrkXEIZcrbGnf?=
 =?us-ascii?Q?wlSS5ks+BD5WW3IfiuoRJ+F3IByhZh/QYjfdFVW2ZxF/gmsc+AC18D/1MNO5?=
 =?us-ascii?Q?pPhOz5GOCovJb3kF4T92TBYuXycIe87uwBXCViI3GtSU3mjbLIH+ri4qf7hV?=
 =?us-ascii?Q?GS6l8P3AnGHhhd+rTNftkUMUhyCBFIUrnXcEoN2ODdZooq2nYl3m5JDV9wpZ?=
 =?us-ascii?Q?YFoPuh35bzmVKZjjvhmQDIj5emYQAzWMbZ/lzJQl2gp3wCwombhXwwp5J8tP?=
 =?us-ascii?Q?Z3/yUmUg3NH0vOwEFNtjmwFTYJqJdGGsNa7OFnZdzUDvDNAQR+PfrswdgwvV?=
 =?us-ascii?Q?wbKOu7VMC62cyEXYtlMmz5BP2zbZsT+UcpRme4BQJASpxFDcI9pGDrZ0ewc2?=
 =?us-ascii?Q?xubWzyagdmS8ixk2MdT9R7QHSk+CrbGDjWpWcDdEYL8SXxjJAZ9f9ZUzp10a?=
 =?us-ascii?Q?uwYeotYL+fz+OPw1XsIfSx4Gnxl1QMWNgjFzp6qIJ9tmPoKDgEu8ePcxbQoQ?=
 =?us-ascii?Q?TSY4S8U2LDfSnbgi4Tk9xCYTxZ0BhtczU1XDMklBDSp9UXRccK4rUysjbCgb?=
 =?us-ascii?Q?LHSfWUj/xkdMgqb6mUpPXKdwNPLJr/El7UuNr2GT2BRsJn4wb9Js/HHGrz7O?=
 =?us-ascii?Q?GHWBs2JzoMIyv356cnWx2xmDH2B9t7c4WHoc32Q+nuqpX2tRaZaykk0cfF2f?=
 =?us-ascii?Q?vGb4VRyA9UDqQnnGIRmHZHOEyrpBOf9FrUOfxioICVxGclxEf6tX280K10ay?=
 =?us-ascii?Q?RtdxAwoEWlef+ro=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 09:41:11.7582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a74ae7-0a1b-418b-82cb-08dd4692645a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9496
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

In sriov multiple vf, Set CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_MODE to 1 to read WPTR from MQD.

v2: Add amdgpu_sriov_multi_vf_mode
Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 23 +++++++++++++++++--
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  4 ++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  8 +++----
 6 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 49ca8c814455..a1450f13d963 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1990,7 +1990,7 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
 	uint32_t max_freq, min_freq;
 	struct amdgpu_device *adev = (struct amdgpu_device *)data;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+	if (amdgpu_sriov_multi_vf_mode(adev))
 		return -EINVAL;
 
 	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 5381b8d596e6..b28082084b3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -352,6 +352,8 @@ static inline bool is_virtual_machine(void)
 
 #define amdgpu_sriov_is_pp_one_vf(adev) \
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_PP_ONE_VF)
+#define amdgpu_sriov_multi_vf_mode(adev) \
+	(amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 #define amdgpu_sriov_is_debug(adev) \
 	((!amdgpu_in_reset(adev)) && adev->virt.tdr_debug)
 #define amdgpu_sriov_is_normal(adev) \
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 2ba185875baa..42251f2b9741 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1857,7 +1857,7 @@ static int gfx_v9_4_3_xcc_mqd_init(struct amdgpu_ring *ring, int xcc_id)
 				    DOORBELL_SOURCE, 0);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				    DOORBELL_HIT, 0);
-		if (amdgpu_sriov_vf(adev))
+		if (amdgpu_sriov_multi_vf_mode(adev))
 			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 					    DOORBELL_MODE, 1);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index ff417d5361c4..9e08bcfa37d3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -551,7 +551,7 @@ static void init_mqd_hiq_v9_4_3(struct mqd_manager *mm, void **mqd,
 		m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
 					1 << CP_HQD_PQ_CONTROL__PRIV_STATE__SHIFT |
 					1 << CP_HQD_PQ_CONTROL__KMD_QUEUE__SHIFT;
-		if (amdgpu_sriov_vf(mm->dev->adev))
+		if (amdgpu_sriov_multi_vf_mode(mm->dev->adev))
 			m->cp_hqd_pq_doorbell_control |= 1 <<
 				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
 		m->cp_mqd_stride_size = kfd_hiq_mqd_stride(mm->dev);
@@ -724,6 +724,9 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 		m = get_mqd(mqd + size * xcc);
 		update_mqd(mm, m, q, minfo);
 
+		if (amdgpu_sriov_multi_vf_mode(mm->dev->adev))
+				m->cp_hqd_pq_doorbell_control |= 1 <<
+					CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
 		update_cu_mask(mm, m, minfo, xcc);
 
 		if (q->format == KFD_QUEUE_FORMAT_AQL) {
@@ -746,6 +749,21 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 	}
 }
 
+static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
+			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			struct queue_properties *qp,
+			const void *mqd_src,
+			const void *ctl_stack_src, u32 ctl_stack_size)
+{
+	restore_mqd(mm, mqd, mqd_mem_obj, gart_addr, qp, mqd_src, ctl_stack_src, ctl_stack_size);
+	if (amdgpu_sriov_multi_vf_mode(mm->dev->adev)) {
+		struct v9_mqd *m;
+
+		m = (struct v9_mqd *) mqd_mem_obj->cpu_ptr;
+		m->cp_hqd_pq_doorbell_control |= 1 <<
+				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
+	}
+}
 static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 		   enum kfd_preempt_type type, unsigned int timeout,
 		   uint32_t pipe_id, uint32_t queue_id)
@@ -880,7 +898,6 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->get_checkpoint_info = get_checkpoint_info;
 		mqd->checkpoint_mqd = checkpoint_mqd;
-		mqd->restore_mqd = restore_mqd;
 		mqd->mqd_size = sizeof(struct v9_mqd);
 		mqd->mqd_stride = mqd_stride_v9;
 #if defined(CONFIG_DEBUG_FS)
@@ -892,12 +909,14 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 			mqd->init_mqd = init_mqd_v9_4_3;
 			mqd->load_mqd = load_mqd_v9_4_3;
 			mqd->update_mqd = update_mqd_v9_4_3;
+			mqd->restore_mqd = restore_mqd_v9_4_3;
 			mqd->destroy_mqd = destroy_mqd_v9_4_3;
 			mqd->get_wave_state = get_wave_state_v9_4_3;
 		} else {
 			mqd->init_mqd = init_mqd;
 			mqd->load_mqd = load_mqd;
 			mqd->update_mqd = update_mqd;
+			mqd->restore_mqd = restore_mqd;
 			mqd->destroy_mqd = kfd_destroy_mqd_cp;
 			mqd->get_wave_state = get_wave_state;
 		}
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index e8ae7681bf0a..9d8119d91f1f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2009,7 +2009,7 @@ static int pp_od_clk_voltage_attr_update(struct amdgpu_device *adev, struct amdg
 	/* Enable pp_od_clk_voltage node for gc 9.4.3 SRIOV/BM support */
 	if (gc_ver == IP_VERSION(9, 4, 3) ||
 	    gc_ver == IP_VERSION(9, 4, 4)) {
-		if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		if (amdgpu_sriov_multi_vf_mode(adev))
 			*states = ATTR_STATE_UNSUPPORTED;
 		return 0;
 	}
@@ -2044,7 +2044,7 @@ static int pp_dpm_dcefclk_attr_update(struct amdgpu_device *adev, struct amdgpu_
 	 * setting should not be allowed from VF if not in one VF mode.
 	 */
 	if (gc_ver >= IP_VERSION(10, 0, 0) ||
-	    (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))) {
+	    (amdgpu_sriov_multi_vf_mode(adev))) {
 		dev_attr->attr.mode &= ~S_IWUGO;
 		dev_attr->store = NULL;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8ca793c222ff..b4bdad79221e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1825,7 +1825,7 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
+	if (amdgpu_sriov_multi_vf_mode(adev)) {
 		smu->pm_enabled = false;
 		return 0;
 	}
@@ -2048,7 +2048,7 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	int i, ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+	if (amdgpu_sriov_multi_vf_mode(adev))
 		return 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
@@ -2116,7 +2116,7 @@ static int smu_suspend(struct amdgpu_ip_block *ip_block)
 	int ret;
 	uint64_t count;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+	if (amdgpu_sriov_multi_vf_mode(adev))
 		return 0;
 
 	if (!smu->pm_enabled)
@@ -2152,7 +2152,7 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
-	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
+	if (amdgpu_sriov_multi_vf_mode(adev))
 		return 0;
 
 	if (!smu->pm_enabled)
-- 
2.34.1

