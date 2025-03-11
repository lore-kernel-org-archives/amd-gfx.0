Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE00C28B30
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 14:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93FDC10E5B5;
	Tue, 11 Mar 2025 14:39:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wst8cTPB";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B9B810E5B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 14:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+0xgYnRvfU9Mcsabi9My1urqKyFWlGJ26s22lAq+jQqLcz3hmNwX/zKDySu02hv1FTqBA7+Grj9iEgPfTCgsOHGb8h0GwmO7dj4czl5R5LjrDboQ3CYqAVVOP6H+YvXu0h81fZeDWUHmn/WolK4S4XycNK8xUpCMAYfhSfKNKJpYr2U4xpvYwuGKMQPuP6vdCQd0UzJN3sfqyqS72j0hOuVzm4C7jCxKd6M+Cu836ylMB+JSFZGYEuDdEfiFzwhCJuvRrk+f/1dih4G/YvHn23uITPltK3BerxYyB0vFNL6ZvFI6AD+gyqVBcRtDvoNbXVIGwikodjj+7uIRjgbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAt913EqajmNiZk6Q4EMo4vssWtcDo4vNd4TpxKw9cU=;
 b=cn2uyOkTfUGmS5Vt6oBfRSI7+vxO1aQCYcDim8WGOh84VYiZXUwNYLsmZ+pkMspJi3FnGxEqR7Wrr2L62Jh9zijdnfKHrsKhQRhHMcAd45vqs2Thtfx10jelM6b5HbKQeRgFJYx2KPMo/u0byJXd2v3EkDh750kMTv9sEPhgDAdZMpfmy3vDPRRLv+BtxOby5hj5wm68rtes9Yekoje/4LQO92RGyJP6ehlJqyzqR1lyXvBVgkXXz4kjaLd+k1IYad/xUR3CgHuuyYAj3bTWsttuQSQLH2Z+BRlay/QtFhlru9AxyUnPrmcPsfd+Sx/sGDZZasvKm8ujjYhGvxd6xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAt913EqajmNiZk6Q4EMo4vssWtcDo4vNd4TpxKw9cU=;
 b=Wst8cTPBaA2gfSxeXxHwMHEYVGPwt6NlrWcvb+zfaYh13e87G0+E0iqF6DaSRZ6PTLmsbr+dbhktzLAPOZa9v4/OKGiZD5uf5RUhoRBJPS34ZSrEmdiRlnbwC+G91A3z+yIHf05ljOIhoac/QWXuDHss54qI7+IWLSHacfZyKUY=
Received: from MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::6)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 14:39:06 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::3) by MW4P222CA0001.outlook.office365.com
 (2603:10b6:303:114::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Tue,
 11 Mar 2025 14:39:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Tue, 11 Mar 2025 14:39:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 09:39:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/pm: wire up hwmon fan speed for smu 14.0.2
Date: Tue, 11 Mar 2025 10:38:51 -0400
Message-ID: <20250311143851.1931589-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7ee4a9-1335-4f7d-371a-08dd60aa7a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5CCK+TQkwqsC3zIKhAZZy7Z1GmFaU80qzdsmyjzwwvl3aCI6D6G9rNuyt8HU?=
 =?us-ascii?Q?culVcxqqhM3vMhfW23e45D8+KpUaNiWBJqAOGQ5xGflgWkuHQhpr8DGg7sYS?=
 =?us-ascii?Q?bLYAmSdb827NxewQwTsnVJ/efNOooIRubok/hGfhafre9zY6wyhKoViXFmSV?=
 =?us-ascii?Q?Q4G20xWw+F6Vl+6fWk2znhlWbAtbvQQoy60e2QFjNGDw2nUl+ZK/xZxP0tsT?=
 =?us-ascii?Q?s4X6zCjuYevu2UeaLqbWWVMC9tnd+GJe89k9p6205p5tPRzlq8hIHpcHDoAk?=
 =?us-ascii?Q?jOqPodxRK69Tezo5sr6v5JGPFC6Tj800pjGVh/kBkVH2uknGS9rTC6jfiLS+?=
 =?us-ascii?Q?4nH8GEcNN+xFFUoJ+7dfYCYRPcsXiM+X2lg1WCAcpqOHUKq64byI96JviksJ?=
 =?us-ascii?Q?BiSg7+CI2yaUbzG5YYQsEyrEpF6RiHar91v51YLeUnz4V802gbnD7OLr/kEg?=
 =?us-ascii?Q?a73AaegCZxCfJZBJnObl3m+90SW9m+sn+Z52lZTp+H+nvFSoQyd/Jo6ETDGy?=
 =?us-ascii?Q?UIhy7YVBx3iqyMj0G9KYQoHblTPRuGAPqYIRujeNjnivSKynnCjpwAqc34XO?=
 =?us-ascii?Q?Y3gU29jJMWrNDRpnhvakymX2bpLoWj2+D1QMgpqqmGIFDOFze7ki9edq7zxU?=
 =?us-ascii?Q?Piu+h4nTW4ELEXW0mmCy6i1od1thG5/HMwy03bUBbW5Z+Qh7ErjRbdh9Tt1y?=
 =?us-ascii?Q?A2C55+ZOnVoyyXH2WTJL2BHsufu7W3Ie59rAxTZgiOg5Psf4m2sOL9pgfWcc?=
 =?us-ascii?Q?M+W+5kF9f/JgEIcQ+19KtsktT8wx6KinHt7DFtyfR7ABr7nv4yg4u3N9L7Cu?=
 =?us-ascii?Q?8NPAkRmycWFFd+j0TBYwAnuJNCoOWMcAhTnGavAJBUy01g51UwYvZ9FgFXiE?=
 =?us-ascii?Q?Dz56pUJEARogBCQroqklUxyoRrRK90AyyKp5GCbasq46l2YXL9R6tD7KUwGY?=
 =?us-ascii?Q?MpJ+X6hGNdnHKjjaseG1aGXiy1i9RRwIQazYqfd1voXQzxGmOJnvbpaWW9TJ?=
 =?us-ascii?Q?FAfRhG/wGuW+RIKYBEaKh43Yk31IMK0s7FOVkClBp0PM3owIRRXjKWyIEQIY?=
 =?us-ascii?Q?uUuh8FiLlHzU72NCwT27ZF8jFuty8U5V4EN9y6YiGMDpu9XyimyuLAO82ocu?=
 =?us-ascii?Q?VE3I3VstKiK4yJCivWVosknsER/Ng26RX82QbER5/Xx+ua3h4N55sSPtEsa+?=
 =?us-ascii?Q?C4neaYlfkqH3HErjlG+j+7vl/53eGiicxbC4RM0XfQjg4XVJib1Rz35up7UO?=
 =?us-ascii?Q?ITCs10VL/4op+ke36yJWvEMPIAJY+8cSnopyuMdtEa6JmNgoTaa/N0CeXT/F?=
 =?us-ascii?Q?C7c8LiQUAEBbFsnMDCYhS7B+2T7IWLoXr6+ECEh/6dD1geUHZC0TsBRzYvvf?=
 =?us-ascii?Q?bXdfwl99AHM5m9LCYfxySA+kKpC21hQ5bG6YE6zHx/U01jwulieV6VToVuhK?=
 =?us-ascii?Q?VnO6gbNbhjA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 14:39:06.3939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7ee4a9-1335-4f7d-371a-08dd60aa7a19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730
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

Add callbacks for fan speed fetching.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4034
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 5cad09c5f2ff2..e4089fd58711c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1627,6 +1627,39 @@ static void smu_v14_0_2_get_unique_id(struct smu_context *smu)
 	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
 }
 
+static int smu_v14_0_2_get_fan_speed_pwm(struct smu_context *smu,
+					 uint32_t *speed)
+{
+	int ret;
+
+	if (!speed)
+		return -EINVAL;
+
+	ret = smu_v14_0_2_get_smu_metrics_data(smu,
+					       METRICS_CURR_FANPWM,
+					       speed);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to get fan speed(PWM)!");
+		return ret;
+	}
+
+	/* Convert the PMFW output which is in percent to pwm(255) based */
+	*speed = min(*speed * 255 / 100, (uint32_t)255);
+
+	return 0;
+}
+
+static int smu_v14_0_2_get_fan_speed_rpm(struct smu_context *smu,
+					 uint32_t *speed)
+{
+	if (!speed)
+		return -EINVAL;
+
+	return smu_v14_0_2_get_smu_metrics_data(smu,
+						METRICS_CURR_FANSPEED,
+						speed);
+}
+
 static int smu_v14_0_2_get_power_limit(struct smu_context *smu,
 				       uint32_t *current_power_limit,
 				       uint32_t *default_power_limit,
@@ -2804,6 +2837,8 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 	.set_performance_level = smu_v14_0_set_performance_level,
 	.gfx_off_control = smu_v14_0_gfx_off_control,
 	.get_unique_id = smu_v14_0_2_get_unique_id,
+	.get_fan_speed_pwm = smu_v14_0_2_get_fan_speed_pwm,
+	.get_fan_speed_rpm = smu_v14_0_2_get_fan_speed_rpm,
 	.get_power_limit = smu_v14_0_2_get_power_limit,
 	.set_power_limit = smu_v14_0_2_set_power_limit,
 	.get_power_profile_mode = smu_v14_0_2_get_power_profile_mode,
-- 
2.48.1

