Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B477CCD98CE
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 05:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B3CC10E946;
	Fri, 12 Jun 2026 05:53:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o9Xa5Rqz";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012068.outbound.protection.outlook.com
 [40.93.195.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DB9310E946
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 05:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGeokac7SlVx4KbaqRR70MDbL+9IEnG92layfAf6sAW99zb5/mDmz7SJTAfWfcUxvyEGUcL7JTQEATJqt74yh+B41idz7z4z5nb8HyYun566eXgYAu6C+PFZx5ea0rHHFGuYr4s6fFCPl3OgJKEbEXxhjGjRlgHnIl5fbmZh4gNHJD3/on67hP5oaqG2y9Bma3mqIsC5+98KhCUkgDRelDyNKAOZQevcuSVLK5ykBD+jWj7lWhSp99ylSTjNhqpRQv8tflE8AZ2sPbtgUv5AYdnGBMASbBvwbMLeB+pdl/ZXDeJEP/ou7XA7CiWhEMoU+KpKgPrzb8/qQbYuUSexlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeQNEDMC6AHMjtz3PiJ02FJw9TGmMNzIUKSHIYI9jCQ=;
 b=o5fZ+xWkqy+OclXUD8/CvYaHzKi/zH2upyjC1MvIJiw9DEMPsS0OdK66YpGI9mVIBvzDrVfDSmzA7sVqAVdcx9i5j4lR3yNlK/3R9sz/WPw2JwhNzlskmHdUSgxiknMtVMfpq172p4Ds6WAHFJW2bDVo+EGktjIcutLMXdyDZDSsfBcF42GWBOg7kFIdufwCRFouCpyhdfCOiIaDIeaPZb2AUQ93gqoLFIBApOn13W563K+VE0sqkqb2ryfC2BCDe0StBQub9X3Fkx4tvc7SbWfSMo/9sty6i9rBtVwxY05R2QTB2vD/qrsYfS1BvIb/EZOYWp7FJEqzna+cAZ5YVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeQNEDMC6AHMjtz3PiJ02FJw9TGmMNzIUKSHIYI9jCQ=;
 b=o9Xa5Rqza7enO67NSVJqKnMx61UE6bo6uEsy6l/fcAVbegidUDjK7f2xwHwz4fPNpSGW4+tWP8g6UcQteN1TzyO4Nhv5oyXvbzccCWfEW3YoBxUR7mdFsVrY4esqpOmU3Tc3m/rl5MTUoen8eptXkmiywV5g0Bagv/ZDzWmjPRE=
Received: from BY3PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:39a::16)
 by DS7PR12MB9503.namprd12.prod.outlook.com (2603:10b6:8:251::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Fri, 12 Jun
 2026 05:53:04 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:39a:cafe::60) by BY3PR03CA0011.outlook.office365.com
 (2603:10b6:a03:39a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 05:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Fri, 12 Jun 2026 05:53:03 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 12 Jun 2026 00:53:00 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/gmc11: Signal MEMORY_EXCEPTION EVENTFD
 notifications
Date: Fri, 12 Jun 2026 11:22:25 +0530
Message-ID: <20260612055226.2879270-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
References: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|DS7PR12MB9503:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a647ae-aedd-4742-eed1-08dec846de8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: wTun7uVyvtPC57ra4Ujku4/AKNNkK2NbxPSotFtXUrT1nlxzTMhXLAxrhT9YIv0VzU1WLYQyI9qk8TKsNC2C1ku+wxF1slm369k0N7eipTQMUxA558shb7DBVGzkveFl1BV4HU6tRfHFzNWfK5g1kf+jrK/LLSPAFMzZrqij5+5ZKU8u/sbMC21Mj/xKyn4CGLdgvfiNlilmT5tWY/jnzRTewiRle9LEy5Az5Xc7RPEKhuXFBPU1EI/C95PIw1eMh7FavO/s1EkY0tliSwwfpYDKD7trJNwXlDiX8UkeuS63JX59zGOJlauhUaijdYYU0GX+Z4Sa0IT45B8fG0FYCXlseaqIUzuT046avvq0Np0+FiF9vvLnyDICUaVYiQcr87DwUsyUcr2dI/vMi/crwcsumsizvAUMC/qBalcKLSrkZzHvvJ/rc8l+IoaX9WG2grtd78mnqKOhqtbqWF3A4pE+aHz0G8qIFNkpvdS5UKoeAS/tnrEUG6MzaUw+AOrmaanyEGr9QxZ2CYjRsnNtqyU6pYXMf3RMchP2svn66YIH4xbGJgE6cQ3mJ9zX5tCLVztTwXVqSzH3DJB9Lpoy4pl0lrELxCGfz+OhV5MJ7DHIGLO16qsim/4ATxycOT/dKf668ty11gON3m/aFO5xf4dtEseJAfqd+nIyhPM19DfmKUM7EKp8xlEumWDtIpBka+MQ7DaE/g5zPY46ARSCnRu4F0LLA8xzOozc7LcFciQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HkP7Eoj6L0Q4aHKxvZdftexx4uDnZxyt/ozXQi+PsJHeQJdjua5085bLKfxCMYzGSuZUSYUJlzbIkdoVKWCPGJrrDtkxdEthcsoK9vFItPJeZsZyLUdZDGPpZq9vDoXQivJTLtHPfifhCD1Y0rBanoPseyub7GkknNwV3D3GhMEWuUAxKF41ZvG3uLFAcjvOyloXnu+KIiXYSoS2NGe87daQatU8L9WhhzDFpeCCZaQBO0RLGJFtieACIQ/vL29B/YE5ApxgTzovQ8pdieC5xqqcjke7FsbBkMgCirIeNA6efjc9KhlEa67jqZIPR8eav2qwjhudaxuTaufN/hjO0DwPyEk1MM+JiweH9VdQmZoDzDvL/FfgSobTF17pbJPGjnkyJmWZ5K3ffIHPIWOgXUv4g/Ws1TOoqKc7B24srCQXzLMQbrmT6Vk6JEWo8oAs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 05:53:03.8857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a647ae-aedd-4742-eed1-08dec846de8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9503
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

Signal MEMORY_EXCEPTION EVENTFD subscriptions from the VM fault
interrupt path.

The VM fault path already detects GPU memory exceptions by decoding the
fault address and status. Use that point to wake up matching EVENTFD
subscribers.

MEMORY_EXCEPTION is GPU-scoped, so no queue object is used.

EVENTFD remains notification-only.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 8eb9847d9e1e..2635fd308324 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -122,6 +122,9 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 	}
 
 	if (!amdgpu_sriov_vf(adev)) {
+		struct drm_device *ddev = adev_to_drm(adev);
+		struct drm_file *file;
+
 		/*
 		 * Issue a dummy read to wait for the status register to
 		 * be updated to avoid reading an incorrect value due to
@@ -135,6 +138,17 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 
 		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
 					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
+
+		mutex_lock(&ddev->filelist_mutex);
+		list_for_each_entry(file, &ddev->filelist, lhead) {
+			struct amdgpu_fpriv *fpriv = file->driver_priv;
+
+			if (fpriv)
+				amdgpu_eventfd_signal(&fpriv->eventfd_mgr,
+						      DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION,
+						      NULL);
+		}
+		mutex_unlock(&ddev->filelist_mutex);
 	}
 
 	if (printk_ratelimit()) {
-- 
2.34.1

