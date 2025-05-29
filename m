Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EBEC5AD49
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 08:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 048DB10E23C;
	Thu, 29 May 2025 08:30:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QuIMWRCB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 409B210E23C
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 08:30:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qB6RhvwwwGCp7CPN6llaBfZvQAInzd7/Ic4e/lYzx7qKw5NjSy1fF6NrGWYFMv09S0Pg7EhiV2MfVi888seghlKCedh4cJ4W5CE+Qp0uyAzclAO1BOtoYm+QkbKBAjkC73Xc0H0IqVOrDW2PJt25NDSdOua6vaqYJVzrTvrFhsbT+za89M8oy6tlCsFwFCA2JpnlTeD7e6jyIU5VA+RGaz+qp9VsR12p5u25TCcXIrIY5uUXz3yjJgO4zUiwwhoeF9i4kvpulYBT5Mey+TBItKgProjAPixy1wyu1wH4VZwK/Glnb6sKN/YivRI6RcCxsuVwa+Ig8R2T4FwDIUDEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deWzeoALfvtHokCkjmqWnQFEElQ1VxRc0kbNAOrnp/w=;
 b=VCx9RxiNe8WxBpFQqupoWwz6xQBpRnRf4nylJcBFODBjVDu/Zea0HCTlS7om7hdyylVJ5IgAT05K8RblT7wkzdzy3TAgEEhNQ3YXI0o/FAsELSeCglCzCfSbS8KcVNv1VVJkh0AMZVWs9LDCI1xwBZwSiJB3bilG+ZMvg4jTgVb9o9Yy4LVjJvduMaAV6OJGlbd87WsUW3QC6fSOA/L22vDiCnG/h3X/JHb9LIhln6cWst1aS0muXB2d/nnyiqYpHyC5p+qw2kas8bZnhWdErD0Y6XF9tfKCnmvcMhvkwa/n3jzrz5+aQtOa4whiRkDnaLp9DNdlg04zDXmSMbXibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deWzeoALfvtHokCkjmqWnQFEElQ1VxRc0kbNAOrnp/w=;
 b=QuIMWRCBUXEiJo4x8rln/BOThmRjBX4WdaAgwAoVv9lRkG8+5wKssxrzZfpszrkrNH1XVq+A6EBop/k71lFTM2v8oUeghRbHQc03CtgxLUNlx8F3RbOepDYvmi/uA1S4vtNq8eg7gMqXbZjCCcDZqDCRcdYrHP6ZEp1sTTxpjQE=
Received: from CH2PR14CA0022.namprd14.prod.outlook.com (2603:10b6:610:60::32)
 by PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 08:30:33 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::8e) by CH2PR14CA0022.outlook.office365.com
 (2603:10b6:610:60::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.22 via Frontend Transport; Thu,
 29 May 2025 08:30:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 08:30:32 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 03:30:30 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Mangesh.Gadre@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Check pcie replays reporting support
Date: Thu, 29 May 2025 14:00:14 +0530
Message-ID: <20250529083015.589652-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|PH7PR12MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ffef5f-f270-4b0c-5f05-08dd9e8b13ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w0dhbfs3PKKtcg6XTnb6mjqsdyGBhCiKGdg1m1QfUVn9FPu7CeIVLFO3WLiT?=
 =?us-ascii?Q?SsgFQ4r/hLiOloWvWkcgx8qEhHR/ZGFLCeew+m86iXam5jggVS6+EdyOytb6?=
 =?us-ascii?Q?v0/OTUYitKm/VgrUj9Zgp2RFoSnGGUmDuKbf5jG0+N1pGQXVxJ0Sd8N0cbRV?=
 =?us-ascii?Q?tw9jb5HL11DnJKrzoR9PiPR12UmRGETVnH+ZexhmL7JjRqTXk4Z8YlSztyzx?=
 =?us-ascii?Q?zZmulgc+eRRKrX5Z5c4xXekV2tNFgKgH74Zbb4BSAecUYxZXzTi5FqCYP7C3?=
 =?us-ascii?Q?wVPCz9I3YF7Uh0yBdB2dG7Z/YVtM+2OhQXcOnw/4qBLJNjvnYooKfiS/32IO?=
 =?us-ascii?Q?k7+bvr/B5P5pdACMVXuGGCCT+ajqZuJUZPWcOlKKPJ6T69ggSM/4/kPeAghz?=
 =?us-ascii?Q?Wh9I8wwin1GZRLsWIiIeF2w+N31pSa5nmjBBG7sgq5YJpoaJDRGpZjIjViOU?=
 =?us-ascii?Q?WOaBMPQJ2v63traYAJDNnP0yhVOtmtWAdMjVUpLSbuEm83jzNwJPaBfxL4ux?=
 =?us-ascii?Q?b+op294uH/8bpKQ8ssWJytuLkzJBk/lhJeMyC9WcRP5aQKtknNX6ho726dv7?=
 =?us-ascii?Q?DYAxNHyTkt0KwKtM9UQF3BchpO+aAD1qe3m4/PPgx30amiUYCxGgyrEM8FOs?=
 =?us-ascii?Q?QYaKov11LvMrKwD1SNS+EA5DoTu+RpMs5GWGjcirS5vLhX3HXAlfofRmv+C7?=
 =?us-ascii?Q?hXrR5+3tYGhnnDkrOR1hsNOhzZz86Y5wchSbA72YXLj4a7dv4+NDqlrQz+iB?=
 =?us-ascii?Q?5YsJyGb8YIZebnInRUZbdCxoncPSBq53TqpkETntJ6RozJm3+lDUyG23Hive?=
 =?us-ascii?Q?Oy8+lhKOd/Ch+gSHT+JCA/0Sot7IHRvtg0JAdzCp0xkv+Ml7U0B7pARrKw+Y?=
 =?us-ascii?Q?0gHgJ3yi1V7Ja6ZLlNBLBHUFSlGkSkn5uuyeCjnaIclvTHQwsDcKW8Kiar5Y?=
 =?us-ascii?Q?ZvhrW+VIclw6wUOtfBXKP0Dil1zaSX9H1yDuBba9E6MEG2IQQcmVKG+LkQ1W?=
 =?us-ascii?Q?Tz2G6Ol47sNT0N9cc6suDEWFf9fxYxfzZXHzwsNSU4WAsSkLq95lXEtuVM+M?=
 =?us-ascii?Q?5dFzauAWK7VUEg37C9GGN/5WdARAlwGzYzm2tKQTapi8MoFX3/4YYLqoSkuY?=
 =?us-ascii?Q?Ke/OqyB7xd2BBe9XILX1BnQ+4zJiZJd7yPDKKHZaym1drnEwUX/8LcJTn8gF?=
 =?us-ascii?Q?rBYrfeQf5Zn2NN/xL023Op7sV5CP0T/aVq+575Vawh4SO2Fp93HRlQ51om4K?=
 =?us-ascii?Q?kjxELBi9DOPiojJIz/NJrU/K3uHBzljymm4PM+zIsOR+OZCopN9ZQ0APZ55y?=
 =?us-ascii?Q?db3wKETIntOPPQlSbSYGch2Bxhv+PJfbbr8+aOZIef54v5fGWAHp91ZDOqmt?=
 =?us-ascii?Q?YuEasF4PRjoqTbePCsA34fLZqrWvd4z0ADTW7vEP5nidBR+W5fVkaxVKxvGW?=
 =?us-ascii?Q?CipcJHS2d3cMSoU1vKQwEr5OZ7b4/+szSrpZViMzTNbx3HYiHuuEoopMCOnf?=
 =?us-ascii?Q?2tVhyiFo1UVi41BOLs+PZ5YwbSajpFyfJlFw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 08:30:32.9090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ffef5f-f270-4b0c-5f05-08dd9e8b13ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7914
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

Check if pcie replay count reporting is supported before creating sysfs
attribute.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c   | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h   | 2 ++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 72e41781afb0..9eaee8dacea7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -232,7 +232,7 @@ static int amdgpu_device_attr_sysfs_init(struct amdgpu_device *adev)
 {
 	int ret = 0;
 
-	if (!amdgpu_sriov_vf(adev))
+	if (amdgpu_nbio_is_replay_cnt_supported(adev))
 		ret = sysfs_create_file(&adev->dev->kobj,
 					&dev_attr_pcie_replay_count.attr);
 
@@ -241,7 +241,7 @@ static int amdgpu_device_attr_sysfs_init(struct amdgpu_device *adev)
 
 static void amdgpu_device_attr_sysfs_fini(struct amdgpu_device *adev)
 {
-	if (!amdgpu_sriov_vf(adev))
+	if (amdgpu_nbio_is_replay_cnt_supported(adev))
 		sysfs_remove_file(&adev->dev->kobj,
 				  &dev_attr_pcie_replay_count.attr);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index d085687a47ea..e56ba93a8df6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -53,6 +53,15 @@ u64 amdgpu_nbio_get_pcie_replay_count(struct amdgpu_device *adev)
 	return 0;
 }
 
+bool amdgpu_nbio_is_replay_cnt_supported(struct amdgpu_device *adev)
+{
+	if (amdgpu_sriov_vf(adev) || !adev->asic_funcs->get_pcie_replay_count ||
+	    (!adev->nbio.funcs || !adev->nbio.funcs->get_pcie_replay_count))
+		return false;
+
+	return true;
+}
+
 int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 79c2f807b9fe..b528de6a01f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -119,4 +119,6 @@ int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 u64 amdgpu_nbio_get_pcie_replay_count(struct amdgpu_device *adev);
 
+bool amdgpu_nbio_is_replay_cnt_supported(struct amdgpu_device *adev);
+
 #endif
-- 
2.25.1

