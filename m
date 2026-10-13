Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6286CA9EC5
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 01:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 460BD10E1DE;
	Tue, 13 Oct 2026 01:34:05 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013032.outbound.protection.outlook.com
 [40.107.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F7AE10E1DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 01:33:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i88kyAJeTltG6yx2ZNXP7d0RYuWJXzoQiFmbc6TXNrUDeyviHyVnQPBYlqngmaZ/SAzJaKz+FrmYXmCZJLzkhRequF2GyisP1lMlGr5YVQuVarBUinEahZghNakLr59/ZvAMYnDFSQ1Ztfx6B945281apafHQTBb0zNmdVVD3AYrYBm6xRoSexIN3nG2FKc0YU8uj7yolF229leeWWHFlPkENqzdRs6ZEZzkPDL2i2y9GheZt6ERd8aZrQOE7vE/CpZLI7bjCrW3DHxL2LyKlXWnQM2dMRb2fRPKLNVuejLdHcF9JRkqabiXfNQzBEmIYZ58bUZHxEQ58Pq502by9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wWTET6UgcAmWbbC/0R4K9+3CEPPjA03NZXFZCZ8cxk=;
 b=B2rOrXAZkhOXMLKzNRwm4LEMQyi3Jkgb3ud0ToSbycCA8tPTDO/6y2nmhWGBKbGm6BB5lhRYk0Vei0ga3l5GPulSrhKHM1D0rTE+wlLdlfpCR70fJMl4A0o/1Kgq6WSIeV/EUWtkZaEFR1U37xKX9YlJDRS5zn8Yzw2SaW1xfX1/VdLoci/Lfu4kNqZuGha5MPZirUX1lWYig+qc7N9VDdTRiMSW/Q6IGHTvliD4E2OS1X+NV98uWjnjgxu8nspcHJQQU1V5DIXW+sDLOZOvo2zBIdblP8NUI06Jkc2a9jzNQ72qA/Pe/vwDVhbepbQOBSJl1kYB8I4Dgo3HX6gF+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wWTET6UgcAmWbbC/0R4K9+3CEPPjA03NZXFZCZ8cxk=;
 b=WTV+cMMsYDlYWMI9kluVLzLcqbkptBcIBgZzD6RUNeIpdcM4Tr2wt/GmBEa09mWQin+HxO2A49Lg50BP5bP1/3DzHk8WsHE77YiZjiIOsXkE7KK9Kif2ac4oXfeV6DkBZCYsbUnt6zQEfa8Yk7qlT7Cy38ZTR2YfPE7XcsT8BZs=
Received: from PH7PR10CA0019.namprd10.prod.outlook.com (2603:10b6:510:23d::27)
 by SA1PR12MB6703.namprd12.prod.outlook.com (2603:10b6:806:253::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Tue, 13 Oct
 2026 01:33:55 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::a0) by PH7PR10CA0019.outlook.office365.com
 (2603:10b6:510:23d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 01:33:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 01:33:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 20:33:49 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 20:33:47 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, <sukhatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu: undo the halted activities when the HW
 reset is skipped
Date: Tue, 13 Oct 2026 09:33:35 +0800
Message-ID: <20261013013347.2015715-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|SA1PR12MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: 795d2718-33db-416c-b31c-08df28ca0b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|261009223027099003|56012099006|11063799006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: gMjcGDktT7n3D/N+hFDJDJ8ev4p0QdJc3vuQjX4V1WDh8JnnSfgv8wJO0+sxfsMYuTyVVyzX7/inxsfHJg/M9iS6bbsHj/xynu6waLIrvPb3KvH9so6ei/TaQQVl8TEbBJ4pLtgenKhfe/bcraVxRx/E727wPghZ5EiSYDaZWR/TlMU5kxj0wb9KWqE9VEuLXwtVPeYSpN0RYzxRzoFMuWYiLJEBfI9h0YqAoV1xiqPAeuYoFrRcfMqTuinuNlUvgSCrw46KLUohgLwE+4Uyqn9Pv2VF6Y0E0+Pyu2jsriYDYHAGlvVxRqA/ooorHwL3UyvyUqTlHfYPhihbrY1eyzRSK1IQ5Pb6Tom5ExkWcViqf3kZhh+ihzf/wL0EjMKIChe8jDpnJ5mg6lc9kEuzm/8nR+6govFAI4pejBHJBBMViI/YOVP+zS0qCrNoDc8UWg4dDEWcmxrPVH3gE5J9EWZra+U/v6zwK4/QBizK/QzfdyaWIcfNutRnK4yt7q/FcG8dJ6dNcZDd4EU+Nf+9Cf5ZIuYdRl4GkcUf6bzHTdJr+gnz9K/VROtKm0P2JmQqgmAWmcXtWEfsopXqHBE0UeTKOb4Upj73jwpC7Dc32l6F3ipMVww7jplU7cPE4i6/cFQ4ynLe9rhFsCYGug/F4YmyPhzhE2PqGQJf6A9VIP60fyVuLcvHQOkJgDmVIu7QiOAbrIWXxUsQZzo3zR6BWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(261009223027099003)(56012099006)(11063799006)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 15XBG+xLDtSvEwAds4BKeVxWv2VHGARvfM+0j/4iW8TFPlWqpjFyjDAZPmx8NuhjXxvQCLhnIugeT11XAaJMkL3kVRDGCxkCnlK6PBgawdX1HZrfvMBcnqXs+9oi4zcwJfTmVf2UiXZ0FStDs+9tt7gab9JoVe/kBOlMVYcakghNVlHXp+egKNOVI4yoBVyphhDJPj35cX8eI6J9hwMtea8pmNk+MpMuxwWZWCB0ZOpMYQd7euMegpuaUGL+kjBkL+hnAWaBUiTKLxDnsxkRtgYLO+uhZxR/Hsvg3Jrf6yW36b7V5GZhIXCcTlH9Xs+FSI+xPHKfkGGbxkklyKUxUvGnFfwCFBXLfV+KNr2oMvTXpYShPoSeIAXeNtJnZqjBFGXkZ7RKvOJ+ftLJKromVZKEK+JqW0Qsswp43IwdI9Ro7kaNAyTNMMbYJTh5l5St
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 01:33:55.1610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 795d2718-33db-416c-b31c-08df28ca0b93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703
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

When the guilty job has already signaled, amdgpu_device_gpu_recover()
jumps to skip_hw_reset after amdgpu_device_halt_activities(). The
following parts of the halt are only undone in
amdgpu_device_reinit_after_reset(), so they stay in effect after this
"successful" recovery:

- amdgpu_userq_pre_reset() unmapped all user queues and marked them
  HUNG; they are never mapped again.
- drm_client_dev_suspend() suspended fbdev; the console stops updating.
- amdgpu_ras_suspend() disabled RAS on all IPs.
- amdgpu_unregister_gpu_instance() dropped the device from mgpu_info.

Seen on navi31 with ring and soft reset disabled and a GFX job that
completes right after its timeout:

  amdgpu: ring gfx_0.0.0 timeout, signaled seq=3, emitted seq=4
  amdgpu: GPU reset begin!. Source:  1
  amdgpu: Guilty job already signaled, skipping HW reset

where tracing shows userq_pre_reset, drm_client_dev_suspend,
ras_suspend and unregister_gpu_instance without their counterparts.

Undo them on the skip path the same way the reinit path does.

Fixes: fdafb3597a2c ("drm/amdgpu: fix MGPU fan boost enablement for XGMI reset")
Fixes: f1c1314be429 ("drm/amdgpu: Disable ras features on all IPs before gpu reset")
Fixes: 565d19415577 ("drm/amdgpu: add fbdev suspend/resume on gpu reset")
Fixes: 290f46cf5726 ("drm/amdgpu: Implement user queue reset functionality")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e0014611f039..753df841be15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5565,6 +5565,25 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 	}
 }
 
+/*
+ * Undo the parts of amdgpu_device_halt_activities() that are otherwise only
+ * undone by amdgpu_device_reinit_after_reset(), for a recovery that skips
+ * the HW reset.
+ */
+static void amdgpu_device_resume_activities(struct amdgpu_device *adev,
+					    struct list_head *device_list)
+{
+	struct amdgpu_device *tmp_adev = NULL;
+
+	list_for_each_entry(tmp_adev, device_list, reset_list) {
+		amdgpu_register_gpu_instance(tmp_adev);
+		amdgpu_userq_post_reset(tmp_adev, false);
+		drm_client_dev_resume(adev_to_drm(tmp_adev));
+		if (!amdgpu_reset_in_dpc(adev))
+			amdgpu_ras_resume(tmp_adev);
+	}
+}
+
 static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
 			      struct list_head *device_list,
 			      struct amdgpu_reset_context *reset_context)
@@ -5806,6 +5825,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (job && (dma_fence_get_status(&job->hw_fence->base) > 0)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
+		amdgpu_device_resume_activities(adev, &device_list);
 		goto skip_hw_reset;
 	}
 
-- 
2.50.1

