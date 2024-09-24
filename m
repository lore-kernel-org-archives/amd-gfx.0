Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4959ECF9C71
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 05:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7A3210E4CF;
	Tue, 24 Sep 2024 05:57:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wQXxF1ue";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 377ED10E4CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 05:57:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5sSgH1+LxqYO8lPtWFTkGRwNN+GfST3iaoUxjvOq8s+CahwpdMb8DoHuwZMvcUf1P0f9eawqbk0vERcHpQ9yDv6cJu1kFv5Dxzg2+KQIJv1dLEu4XFQSJyJGb9Bm9M4SF7YVq3/9o+xdO8ldzg2F4fkkm5uvGNKVwMh2oBM6wRJPt4lBr0ckiJ65EPqjANvOr9hAXeTOhCH8ZliVMm6DeK2o/X+1eYBFJExPYilnN1ubkddapFCrMMYhlMDmbKPkO7dXJibRqhA7NiJUv1UDv/5Uu5u04Pu1E8t8qvSRluqJZSTgUJCMGRtjYfUOFbJOWeVeedz3e6jM9LOPiUF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0CZnfpbBeQg1KXK9gZfYQcjbpXJLeFBHQt0zDtQIaM=;
 b=n9Cw4tdm3ydvQqUgXTblpb7TQ0mVzgBrkbgFU4Y5RML1Ja/JqntwR7FD+dslVXdqooAiPIsHhZpIsdiwa2c0pI3U4XZUhOOsc4IIBSWyUu6Zmmn3b9VMMoob8gjlhBfKKa+8MjjiiPEzICRpgQasMhP5r01WHXSzCktHUV1hI6pA88aLgASVf6FeoQ7OGIUAcyQLwOVEU9F1X3gCEY2gYeAUOyNDOfwRK4wOstRN7zCHcLk3BXqoR6tv3KiNnYlqqar8Sldthejiqk+fEayK11BhEp5uxUXs2KiUCkuhejClZZzCN5UUYmfwszxSnAjIyuFUopxqp+3nuVvX36gKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0CZnfpbBeQg1KXK9gZfYQcjbpXJLeFBHQt0zDtQIaM=;
 b=wQXxF1uepqAs5JAstuTbV4RpV2t3dIAUxuqn29/oeV3O/0abrzRcc3e5r51wUsruSDF0bMFcoCOeHKg0hjRhTf+2fY+x9QElN4WA6DZVqTGJOKfr6T/wTmyJB4JPuvGLQ5nl7v+vYYpxBrSQYRZsTZhtprvGT65GuMgYp7h+tvM=
Received: from DM6PR13CA0021.namprd13.prod.outlook.com (2603:10b6:5:bc::34) by
 SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Tue, 24 Sep
 2024 05:57:25 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::fb) by DM6PR13CA0021.outlook.office365.com
 (2603:10b6:5:bc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.14 via Frontend
 Transport; Tue, 24 Sep 2024 05:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 05:57:24 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 00:57:22 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <rajneesh.bhardwaj@amd.com>,
 <Ramesh.Errabolu@amd.com>
Subject: [PATCH 5/7] drm/amdgpu: Place NPS mode request on unload
Date: Tue, 24 Sep 2024 11:26:50 +0530
Message-ID: <20240924055652.2678433-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240924055652.2678433-1-lijo.lazar@amd.com>
References: <20240924055652.2678433-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|SA1PR12MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fdaaf00-b5d1-46e5-f493-08dcdc5dc392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iBrUmppto5EmwBTNCZg4FJMcnS5WkhWR1jpRzGNyNP7QFAn2rEKhqS+aAzs+?=
 =?us-ascii?Q?ls71sI7AjqmpGJRatBUCA7xkYUhtApMj+tQNivemuIMwVPy3GpqcZDRzZ15o?=
 =?us-ascii?Q?9qkeAWlwObc+Bwx6sJ8CC79U01x3ceJUH5pSuL7wVRwjB7lEdv/MST1QKCz0?=
 =?us-ascii?Q?jLYKsMP+4S34e75CTOCKLYJSj4vvKWD7alBNhKwUi6/9KvVxbIVqNSgqzap/?=
 =?us-ascii?Q?BesXKlrd1rL7AHBmR7a51Ul0yF3dffQL+W/iwouUroLqhGY1A/j2GyuyfOPJ?=
 =?us-ascii?Q?Vycir/GHPPTvT47oEWHqFJw+zUatGJwJ4+Zzuvldb5K5vn5uUwS2yB7YjDDd?=
 =?us-ascii?Q?u0/yy0Z8uh7thYs7M5wCjYdRFYPAe93TyEIc/sZHSx5ji+NX9MN9AZbcxX01?=
 =?us-ascii?Q?71r6fdPqd7r6Qc4R9makhQBZ57auhBquW2/4qsXCBACR0JxabEI8cLm6jQFX?=
 =?us-ascii?Q?rFnNinWZQ5Ysq2mc8vZVb1OgdKfbNy9lb0IdPWnYmH1fzfp5fWcDL8yS0wJu?=
 =?us-ascii?Q?jZQ657nniWbLTSj3nsZDafw0SfxlO31I9Yz3uRxzw0rySWL6aKLD16GxxlwR?=
 =?us-ascii?Q?KGkeEOGNwM+p5k5jxDj8u5k9TdBOXPQ1YbMifPYrciBtJqMhmu32tgS/a9GB?=
 =?us-ascii?Q?iLbCW8ZeAQPD3NYh28M+VAW7ONdRPHqT7xZJpGGhTNSot1pRxtX2rLiz3Odd?=
 =?us-ascii?Q?B2I+sCa0i4myM5qJ4ShhVp3hj+uGXywl2z4E1HLbdNXki73tUMymRQqMyeSL?=
 =?us-ascii?Q?YcBOi3MEtCenc4U0xJtFC7gj6CfrQPYw2BF6QOJIjxgY/GfR2fvgDwyxY9jt?=
 =?us-ascii?Q?12dMAOU2T2sOacV23a3UY/MDfWi9QQZLx+r9VNEOsWP495UxkoiPXGHQtfHL?=
 =?us-ascii?Q?TbO9+EQwNasuMyXTwSiR/7uS0CKQg1x5hUTmRXK5OKBsEQGiJupW6kSQnFtQ?=
 =?us-ascii?Q?v185zfTmiOvu7oKgt3/R+1p8vxe0xAMByQ9yVk3/ZhppCP7dj6SwtXb0+RNo?=
 =?us-ascii?Q?+TZs26qt00aoqE0Ll8lsvym9rd7e1MkiLQlaWnblMiSkhTnZOAtc74ZlKRir?=
 =?us-ascii?Q?cWrjyumgx9AgCH+1LeNiNa88QhKGAGzcyTxrwNZWm2a44rJbZHCvT6igcNKr?=
 =?us-ascii?Q?G8U5QkyW+A7Wum5Rpmsf+dPJB30Ih2jaPGlPUDoP78c7pLeLhGzysap66lDi?=
 =?us-ascii?Q?HDLy6Y4QUgrSUouUFhJgkb8vW9Q0AcKq/vk8MxzinMd+HYhACGOFlUcYZjbo?=
 =?us-ascii?Q?zPT3AO4MwtAK6xQ+CMnO8loBw2ECAIrWrhS3PDTQAUMqKsyE7a6coCnIBvWA?=
 =?us-ascii?Q?S3kBEcjQ3jEtsW04TTkl4tbXcJuF8jtRUDPQfI/9YITmmNN8xfyr4Rtt27rN?=
 =?us-ascii?Q?EokEKsU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 05:57:24.9931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdaaf00-b5d1-46e5-f493-08dcdc5dc392
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096
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

