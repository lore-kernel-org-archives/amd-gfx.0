Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC04C3600C
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 15:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE0C510E5AB;
	Tue, 25 Mar 2025 15:36:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jsKzsOU+";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CB5610E5A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 15:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aE2b6MyV2bcfo8m5V6IlBapGZt60K83zlV5n6MLer0ChuPuWArjTRxgXjk17PiilAy+m37TXGtmMxEX1/x1+eua8Gg7pso6wu3xjW0nw8uynjGmtio1Z1yZ8d6XzQJrL68GAa5KEnBcc2R/e83vJRVq0szdC4N0KIE3tn17pwgZZWB1Gau/LoDzlzwx8G3yuHoPoWAsCxE0tNNn8IyXZh+Zuk+BBI0gbyJFzj7i5bl4rXck0m3E/gswsWu7EbUnc5Z+UwoV7cReL9eI8UmCisPq8Xw7JglIMx+MuUj4YAt6z4rHMkfvYZWRXsG3oRhFIeISlkgC2NmEDA2V6Ce9nxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KbDDqGEcxuKNxF+R95wIkodYih1iGJBzfBgImUMhs4=;
 b=wkvcFE+1OdqVNdskcR3+DuIN9TqizhMXKRyEIG2jBLoMrzwzOGEdMSHpYc0ANY/jx8kp9maOGxqFlgmqZ4pIHeAKrU2fJ6SZwWJUtIxVX6tnwJ+3ESAHcAZPyXvhZK4okitKPw3NZK7bvUb2P3zTVDzp/aer5zhslqE/wDWjZtT7O6Jmm6324iIGOL44LAfyj5U6SBYgJeRYOKmIbWuFxicMI7uDobDor2Qv5xSzjUpPq5Z1lqdeZkthJ8qV8N1eKwq56J3juCs+GGeU5ee4pLk2zy1Pz7pcLC7o6dS8ohmc+lXkN2Ii1H8xYnDEFkAfSkKkNPvPuI2wcBcb6hLrkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KbDDqGEcxuKNxF+R95wIkodYih1iGJBzfBgImUMhs4=;
 b=jsKzsOU+0gQJu7srqvUJY2OUr5MGmnNZGYto9G52qYJpUsbashK06PH2CIcZtB7I1ODXqt/Omv3ydNP+mn/ilFoYZQq8F/pdvmkK/O57XpOBf/H4SRwBjyeM4aQHaq2CqgxSjVB6tXV+3oNqbQQhyiNV8CcZ1R444jgDPhm1W9o=
Received: from BN9PR03CA0434.namprd03.prod.outlook.com (2603:10b6:408:113::19)
 by SN7PR12MB6671.namprd12.prod.outlook.com (2603:10b6:806:26d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 15:36:48 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::3a) by BN9PR03CA0434.outlook.office365.com
 (2603:10b6:408:113::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Tue,
 25 Mar 2025 15:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 15:36:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 10:36:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V2 2/2] drm/amdgpu/userq: prevent runtime pm when userqs are
 active
Date: Tue, 25 Mar 2025 11:36:32 -0400
Message-ID: <20250325153632.478700-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325153632.478700-1-alexander.deucher@amd.com>
References: <20250325153632.478700-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SN7PR12MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: f344ea35-e994-4f56-43d3-08dd6bb2daf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cHQuCdHrvRiK58qgP2EYsQAF0ruccQFosbkO7seVC9gJF6lAYSdPqqLaLwGL?=
 =?us-ascii?Q?JR79hzhze8f1GIRMCXL4oNNGRBzl0aHTbBzQlgmKcTZ5LAZModrz0bUYHawD?=
 =?us-ascii?Q?KqtVWrNxwNK39gP5+0VRSb3bVKJhYAvhpuMO2CQyQQ1cT38Vam/5P+sWT8Ko?=
 =?us-ascii?Q?HXvA4DgNc/Yh9jsDB2aTQ3Ov8Kmin2gsnRn2a1tihIy1ebbknMu1nO5YrdBg?=
 =?us-ascii?Q?EojYpWGAeOHTkzvoeGiAegu5mqI/Q6c+S6ZPsjvPo4WfqPoHgmyz3CwJLLyh?=
 =?us-ascii?Q?TLjb/WeMOOQjp13rQF/h2LgpemC3ljOwQ902yCieQpENq3hSKIsx35+lI6mV?=
 =?us-ascii?Q?6Z4jHgNJu05LQMn6Wk/T5phVlQ6rpdCrNe4fXp2WWLvLKhFz231jyXb1mvL1?=
 =?us-ascii?Q?QT0DmtnSJrjukqUFG2XbCO0MUSAvrLviYy7llxFrnUis17loC1wrJsOFJHH5?=
 =?us-ascii?Q?3eoMhBIdMikEv09mxDdjKaOysaupwmIiHBf0kcJUX35wZZbyXdtU9HHZ3iCH?=
 =?us-ascii?Q?10NL0GJ+LU3e9zlxJhtZJE5ZR4oalgytZkFt2tEneyg39pu2jyi3/F1uSV3X?=
 =?us-ascii?Q?Fa18VPORFFaWlY7G6M2ig36Lv9SfkSZiQIWj2rBaiSPEsFtk3aAdL5yjFx41?=
 =?us-ascii?Q?Z/DHqVJtRlWWMXRlAx3Ue483NFGvqS/W9+ltnpjYLxgUvrXrrHx+KH3PTt/H?=
 =?us-ascii?Q?C4Q5GefzuhA1vTfeX/vDEfDNuXWvOGmGz+vr5zn0zVRDqHNMht513wqGPmm8?=
 =?us-ascii?Q?1Z5f+4o+QPGi6j3TkjCa5LFq3Kmm7SkzFwfNsCjyp00u/139ziZFpylCc73F?=
 =?us-ascii?Q?x3okHGBPiwVwd2l1xxL14/LdD5udCkZK9vks1+YRk9bMjDEUdh+w3PcBa7vZ?=
 =?us-ascii?Q?u0mRQwB/o0ay0zU08nw6TdzaBah/N3qVHX6Zph2DI0xpOnk5i67+rW6dK5HH?=
 =?us-ascii?Q?t3/iYfCtcWreS8MJ4pD0M2CR8wfCnkPRiW/T0SHwWWyNKaSaDts1mXCP1WlL?=
 =?us-ascii?Q?IUsOj0kqptTUa7VphlogoFkEOxggGuDTdjvGtNU+MuCv2tUuhz8Pj57B9JqM?=
 =?us-ascii?Q?1ipq2tOf1ufbTPrimP+F0P+Ksf6GquLeHWF/ZjwcrFjvHcmmBE1iNtR8mmdk?=
 =?us-ascii?Q?D+Ik5F3XqxgjyPj21FUb0IaXhZpsoZk/p1Gb3Qj1CFFI/M6uTNGLmHPB5iOm?=
 =?us-ascii?Q?8zoPrcts6ZT5MH4cyCk/EHJdAvOXklhQ61qhwVwybGakSYZO3BMIiMkRmiOa?=
 =?us-ascii?Q?US16V1efu2iqBujFitV8bqpsf0AZChH2/egeLHZGd2VXHWi1GflQkW+mVlMx?=
 =?us-ascii?Q?RVBQtrATtVknIC1TR/zZhEi0Wh/t04H0u4qjxgWfNnKqNBb5lDd4Tcc4UN1a?=
 =?us-ascii?Q?Fc/R10zf2orHZ+kaj6b2shrGSqsA/UPikt91g3XyMonDkIV6EQB02ULMgpgX?=
 =?us-ascii?Q?bYRQ0lQp0WqPlMhVRaFpBPC17v7MsqvsfUzpYXfDF4EHGs3K6WKL4w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 15:36:47.7826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f344ea35-e994-4f56-43d3-08dd6bb2daf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6671
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

Similar to KFD, prevent runtime pm while user queues are active.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7d49a0bede1e2..4ff2e423c50cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2705,6 +2705,29 @@ static int amdgpu_runtime_idle_check_display(struct device *dev)
 	return 0;
 }
 
+static int amdgpu_runtime_idle_check_userq(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+	int ret = 0;
+
+	mutex_lock(&adev->userq_mutex);
+	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+			ret = -EBUSY;
+			goto done;
+		}
+	}
+done:
+	mutex_unlock(&adev->userq_mutex);
+
+	return ret;
+}
+
 static int amdgpu_pmops_runtime_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -2718,6 +2741,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	}
 
 	ret = amdgpu_runtime_idle_check_display(dev);
+	if (ret)
+		return ret;
+	ret = amdgpu_runtime_idle_check_userq(dev);
 	if (ret)
 		return ret;
 
@@ -2841,7 +2867,11 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
 	}
 
 	ret = amdgpu_runtime_idle_check_display(dev);
+	if (ret)
+		goto done;
 
+	ret = amdgpu_runtime_idle_check_userq(dev);
+done:
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_autosuspend(dev);
 	return ret;
-- 
2.49.0

