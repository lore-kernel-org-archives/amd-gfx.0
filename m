Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04659CEBF77
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 04:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A220610EC12;
	Fri, 27 Sep 2024 04:58:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YVFvXLUC";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B0B10EC11
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 04:58:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmVDnkJaypOtwlcuh5h9Sfk5z8aTvhOfVpZUSNs/epZxIfjXlFHPMEYhj9Pn0gi8nZMQQqMtNycXC5m2ssyQNIlgxM2gTm2A+U2eA3LQe7QgszHG0Xope94ODclUijqZuSq/INmyGNdZlIak8VysqDWZNOcN9u9APQ8FMIo0DeqzTj6ULoG14NqRmlCXmOmLWMUVNI4ypA+KIHJ8SsJrbP737rFRZ82+Vs2U9lyMua3UTV6vsMLhRjTcJSfRVLy0t68f9Bu+iPvjbXBhC/UjrMvRcMy0dM0X989GPXnYesFb0Clb/7c8SNJNIzQy1upEoxpNW8GYZH/4Bfk5o0gR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYRGY0f33cSx79y0nTrCAywK7Pv0jtR/qhIi7SKS+mQ=;
 b=O0j2jT9ItNQfWJ8kuM6PYDkZBwPMRn7M97q2yDt5uotnAtOr/VFgxzIUC95tmTrdYS3xBdqFkNYDKdCm6eiHJEYKm6LjtV8EGWJY2A2RDyozDuay8EycBNbtxRkGLTNWFD/wz9creQSMUgXPvdsmCPKhuirY5q9j6OweEzEcP6Kuj/0LDMdBos4JaPbcD4O7D9UlIDj73RNyr6wRYaRPTxa4niBUGkiYMLfoOzQChLr0C8wKkzJKaF22tD81qWaYsuAWT/n8Y/uRF207G8Bi7DID0I3jaLvjcZcUQnpRPJIeNmphxK7/lpaPaguQ7PPA7IlULVgzxIkWKvElAxS5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYRGY0f33cSx79y0nTrCAywK7Pv0jtR/qhIi7SKS+mQ=;
 b=YVFvXLUCOOUSHlPh2m4rBPKudn/vtkK9MRQd+RB53/YitKcqtcG6rr+m8AqHqHAPhcm7al0awKZXd1Posem4vsSkknEzqK6kqPKKTP+i1E+xUapVhZ2b2Lx/EZ3V2uzxGynA+9w5hnwCF39fK70If+umW2ykJZ3ljVWShsJ9qq8=
Received: from BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::13)
 by SN7PR12MB8060.namprd12.prod.outlook.com (2603:10b6:806:343::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.29; Fri, 27 Sep
 2024 04:58:15 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::d5) by BY1P220CA0007.outlook.office365.com
 (2603:10b6:a03:59d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.23 via Frontend
 Transport; Fri, 27 Sep 2024 04:58:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 04:58:15 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Sep
 2024 23:58:11 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <rajneesh.bhardwaj@amd.com>, <Ramesh.Errabolu@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH v2 5/7] drm/amdgpu: Place NPS mode request on unload
Date: Fri, 27 Sep 2024 10:27:41 +0530
Message-ID: <20240927045743.2718949-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240927045743.2718949-1-lijo.lazar@amd.com>
References: <20240927045743.2718949-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|SN7PR12MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef63a09-e499-420a-e87f-08dcdeb0ff1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Myj2MXc0JHgSerjIyM5rmIq2pA+enjqCaCuGdiSY1Eaj7nw1yIQERH1BwaIJ?=
 =?us-ascii?Q?o1oHKPqcezxFHX7HsQ1z/eyBTeXKj41rU1oUSeZaITKXgo+9+XNrB3YkzikT?=
 =?us-ascii?Q?9EvO3zN7Rst3RPo+3mN50U+o061n1bTanI8zDbSdMMkcop7+RNxTjosMJVZy?=
 =?us-ascii?Q?l36GAfWj9sEpAbFvaVFctgHio2VfW6eHy+7q5mM0Ge1SmKip8FH6c4ZUPOZs?=
 =?us-ascii?Q?Hy+St5zD39hf7hFsBYi800AjY/mrQEDzpvJx4nJiOG+jEuKgCK4gu0OEG75j?=
 =?us-ascii?Q?/NTnN7CgjFy7ynSBQKXuMiYYj9XCXxnIUPuzAsqpSm8R7NRqd0diKxXJt3jX?=
 =?us-ascii?Q?n76UBIXW4l+MpfHmW0F8c9fd7QqGgzHPsTn8qlYUIPsRbvuaKeUviCoizfyN?=
 =?us-ascii?Q?Q6cvS+NZpGp3mF36MS3TV34YlotW0Dq5IvytRTSCAJzatoTKPVoSnfz/BL89?=
 =?us-ascii?Q?xgA5c3dd7N0btIPVd7fFGAFmgSVzs+Hpvd/EwZ7wU860pbfmvoFJNeq6C8Qc?=
 =?us-ascii?Q?nNMUuuDYK0PPcpf++VSKpliYf05VkahhuNqC5++zb0ozdFW1d9b2Y5V7P/zB?=
 =?us-ascii?Q?qIxWXEdzqIDOxPqe8DcC8pTCYgT6r3uaxU58a4JTCP20Wuh2gLeb1pnI51VX?=
 =?us-ascii?Q?s8t2rWEpYHvhFF+W/m3OeUYQpiM3kdounWoUk46/R2nGh+egt443CgFMi3Fi?=
 =?us-ascii?Q?iujV2KgEa5a6ZAp3OYZGpnhNS7TWqHBRlBvpbLmsrkEKlnOeX6hia6SOPV2m?=
 =?us-ascii?Q?zLzxqBcj9nk27suNWZEVs4MtWSGZ7TztsJTEKry4TvKt+PcCopj9fHpf4/vF?=
 =?us-ascii?Q?nrodivcZaElqORHlE+vrrE5JojsLdJ15gv6YKWg0XgURAScuLTdWVlfJ/MXT?=
 =?us-ascii?Q?g5eUgzA3WshxTcD95xpuebfy6AR1ApGVmwD+2wBiN6H/SLo7JscIes0a++T+?=
 =?us-ascii?Q?hg6c0wqE/JLtSNEQGDnyePVNJ+V6t4I2iHNO5qNFIBQ471RdE+KrM3mTQr+b?=
 =?us-ascii?Q?ksIyp6C1RTQxjD7JhOSCypk/H52ffd4FkQSsEm96kjiok/2UE2SoPTZNhKNm?=
 =?us-ascii?Q?FiypV3pwuMo7Kj4Eaz2gDPbDH0DykhHIy4ei3KdLJh/WlSMzQRpgvero+5up?=
 =?us-ascii?Q?C97VDTmz68y/YlNUfEUSQhdF9PKsqa9tVqBrSy+FdAy1iGnDMmfucBhScY8D?=
 =?us-ascii?Q?btflXLU4/u3nJWSAO7Cd6NwqAXqMzIXuTJ0Zljxm+b/uBwTYVnYBC4LQHWAO?=
 =?us-ascii?Q?3wXhu/kEK9HvVVKhHIKl91+Z8hzmhpRwGc4k6JO4aQ5byVRbrApEpIHQ8mQ5?=
 =?us-ascii?Q?3AgZL/2GxQNGrf4vTfO9tx9BuEI/vR5buRF7TaDYHC5nj6SpL0gKYssMVkMF?=
 =?us-ascii?Q?IF0X9KOietsLZiE9EPPAjMQ7YDY5NnU2BwmYzndswT4PymXBCLe0vrjuctzV?=
 =?us-ascii?Q?xrUWXKdDJR9UVDOx4geyUPI6ss1ZTFV7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 04:58:15.3991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef63a09-e499-420a-e87f-08dcdeb0ff1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8060
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

If a user has requested NPS mode switch, place the request through PSP
during unload of the driver. For devices which are part of a hive, all
requests are placed together. If one of them fails, revert back to the
current NPS mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 47 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 38 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  4 ++
 5 files changed, 92 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 95331294509c..d16cdcdb2114 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2428,6 +2428,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
 	amdgpu_xcp_dev_unplug(adev);
+	amdgpu_gmc_prepare_nps_mode_change(adev);
 	drm_dev_unplug(dev);
 
 	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 24a1f931d9ed..21f1e65c9dc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1345,3 +1345,50 @@ int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
 
 	return psp_memory_partition(&adev->psp, nps_mode);
 }
+
+static inline bool amdgpu_gmc_need_nps_switch_req(struct amdgpu_device *adev,
+						  int req_nps_mode,
+						  int cur_nps_mode)
+{
+	return (((BIT(req_nps_mode) & adev->gmc.supported_nps_modes) ==
+			BIT(req_nps_mode)) &&
+		req_nps_mode != cur_nps_mode);
+}
+
+void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev)
+{
+	int req_nps_mode, cur_nps_mode, r;
+	struct amdgpu_hive_info *hive;
+
+	if (amdgpu_sriov_vf(adev) || !adev->gmc.supported_nps_modes ||
+	    !adev->gmc.gmc_funcs->request_mem_partition_mode)
+		return;
+
+	cur_nps_mode = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
+	hive = amdgpu_get_xgmi_hive(adev);
+	if (hive) {
+		req_nps_mode = atomic_read(&hive->requested_nps_mode);
+		if (!amdgpu_gmc_need_nps_switch_req(adev, req_nps_mode,
+						    cur_nps_mode)) {
+			amdgpu_put_xgmi_hive(hive);
+			return;
+		}
+		r = amdgpu_xgmi_request_nps_change(adev, hive, req_nps_mode);
+		amdgpu_put_xgmi_hive(hive);
+		goto out;
+	}
+
+	req_nps_mode = adev->gmc.requested_nps_mode;
+	if (!amdgpu_gmc_need_nps_switch_req(adev, req_nps_mode, cur_nps_mode))
+		return;
+
+	/* even if this fails, we should let driver unload w/o blocking */
+	r = adev->gmc.gmc_funcs->request_mem_partition_mode(adev, req_nps_mode);
+out:
+	if (r)
+		dev_err(adev->dev, "NPS mode change request failed\n");
+	else
+		dev_info(
+			adev->dev,
+			"NPS mode change request done, reload driver to complete the change\n");
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 1a50639a003a..b13d6adb5efd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -467,4 +467,6 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 
 int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
 					int nps_mode);
+void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 5d721ccb9dfd..db2c1b11b813 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1564,3 +1564,41 @@ int amdgpu_xgmi_reset_on_init(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+int amdgpu_xgmi_request_nps_change(struct amdgpu_device *adev,
+				   struct amdgpu_hive_info *hive,
+				   int req_nps_mode)
+{
+	struct amdgpu_device *tmp_adev;
+	int cur_nps_mode, r;
+
+	/* This is expected to be called only during unload of driver. The
+	 * request needs to be placed only once for all devices in the hive. If
+	 * one of them fail, revert the request for previous successful devices.
+	 * After placing the request, make hive mode as UNKNOWN so that other
+	 * devices don't request anymore.
+	 */
+	mutex_lock(&hive->hive_lock);
+	list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
+		r = adev->gmc.gmc_funcs->request_mem_partition_mode(
+			tmp_adev, req_nps_mode);
+		if (r)
+			goto err;
+	}
+	/* Set to UNKNOWN so that other devices don't request anymore */
+	atomic_set(&hive->requested_nps_mode, UNKNOWN_MEMORY_PARTITION_MODE);
+
+	mutex_unlock(&hive->hive_lock);
+
+	return 0;
+err:
+	/* Request back current mode if one of the requests failed */
+	cur_nps_mode = adev->gmc.gmc_funcs->query_mem_partition_mode(tmp_adev);
+	list_for_each_entry_continue_reverse(tmp_adev, &hive->device_list,
+					     gmc.xgmi.head)
+		adev->gmc.gmc_funcs->request_mem_partition_mode(tmp_adev,
+								cur_nps_mode);
+	mutex_lock(&hive->hive_lock);
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 67abadb4f298..41d5f97fc77a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -79,4 +79,8 @@ static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
 int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_xgmi_reset_on_init(struct amdgpu_device *adev);
 
+int amdgpu_xgmi_request_nps_change(struct amdgpu_device *adev,
+				   struct amdgpu_hive_info *hive,
+				   int req_nps_mode);
+
 #endif
-- 
2.25.1

