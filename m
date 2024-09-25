Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8CBC369AB
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 07:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38E9A10E7B2;
	Wed, 25 Sep 2024 07:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E2pYSlM8";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C86A10E7AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 07:57:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvlEaaD6+A4BWJ9EbPkCX6pTKGL9H8xi1Wdm+rm8Ln+FS4vA27lVB4SxBOsHwfLuzE+R94mdEsy/dyAk+XuzPAq+b24Fu4G0maFQUwFYoUPt16F32fLiMphllW8mEV6Vfwnkv1hCjc6Mjg42nMk0fOoiArMzP/y5/nYLOL5LMI0u5U6NiHUQ0sZFLYd3qvlHVhEUKhcJMipDDvs7mCQLC4+UMt/sfmRUVejPMs5awmgY7Bqc5c2Yj1w0FoVeDmFDpaT67RrJREHD8PG7ALzrRGocnyAZ94b7N8MnmEXioSfXUxceJ8CzSbZsI1/Y6Rgr9RyuZSB4djvBYLHy7DFB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifsgvZlFkpicPhsKO/rzXbrKJejETI9miIXAhAczBeE=;
 b=MMxwMvKga93RKCuSaqNxZBtwW0ms14t+g6AIA22B+Xln8ykO66P+vxCnI+nQLmqNJ1KJAKz8D2mP/QPSFUhCl5paJ+YN1q9GMTSGFrOIa01inw1nrVnWTwVc31q3+snQftGHy4lIRhk+aJWxB8WW2L4WSs8PXDXFUEDXinadSr7gIj1odKZ724UiKJXJuqLD8mpCVWSLf7Am1SzXUESDwAFt4uq/vN9rjFWeV+LR0zMyapcQp9XJD1ZbPySKBeeUvKr6Z2GiAdnFqglXIo1vhims5cPQvwmAtMACiKzyy5W5uhRjd3tyY7gTco4HvQOTGngrwM02/wi4Uzt8lZE3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifsgvZlFkpicPhsKO/rzXbrKJejETI9miIXAhAczBeE=;
 b=E2pYSlM8+i9zfwZ863XyD4q+pZivlsJCoZqAuI00QIf+Eq0C5PeXZH66NySYsepJiw1I5QPQRJDpF9T+mG8suuLXy9kFw188g1cRde9fXYhdrgTVA0ak4zYiK9vVpqt7gOKuK1FuvM4HbKLTrwElpH0E335CipCYoe3HBqhxBsQ=
Received: from BYAPR08CA0046.namprd08.prod.outlook.com (2603:10b6:a03:117::23)
 by MN0PR12MB5809.namprd12.prod.outlook.com (2603:10b6:208:375::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Wed, 25 Sep
 2024 07:56:59 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::ac) by BYAPR08CA0046.outlook.office365.com
 (2603:10b6:a03:117::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30 via Frontend
 Transport; Wed, 25 Sep 2024 07:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 07:56:59 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 02:56:55 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <kenneth.feng@amd.com>, <mario.limonciello@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v1 3/9] drm/amd/pm: use pm_runtime_resume_and_get
Date: Wed, 25 Sep 2024 09:54:27 +0200
Message-ID: <20240925075607.23929-4-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
References: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|MN0PR12MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ff2c71-aeda-4f4e-3e8d-08dcdd37a216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0UGiMEaNioBjR1vG4oxAwSwGN1zLbWPujJlzZ2ksXoXodEQAe3+2Vmf2+LNi?=
 =?us-ascii?Q?LA7SekVWsPWUW+4CauT+DBbwqa4TtUU7cAemHZa24J5+sumTPFnIYD5LpVy9?=
 =?us-ascii?Q?LVgrNjKtrM2cD4RnGlRTZomvriBEoFt2dul2Y0w26+C5J8iE8TUaBu3vmu0A?=
 =?us-ascii?Q?IzhiDtWsbFpdcnJJDpHc+o3HfBB7A4SiVi5zG0cesCqrpxdusdAv4napaYJa?=
 =?us-ascii?Q?l6AhoNywIDQXXbV3GkWOclzmXtXJ1HdeZSEjwx7nhVqWI+EswJymiTBBdv7C?=
 =?us-ascii?Q?IcIItSeXEZ5NZ8MltV7BTtJ/mQCt+n/9JnQIo+X1J8KVWsufO/OjU1ro/Uwo?=
 =?us-ascii?Q?x183dqgXfc51c9c9o0NjgJUSmegMAw/6BSLyQI+DaC264UPfMVldv0NmWNe/?=
 =?us-ascii?Q?v+vvyN/Rdn92IMsNquDNoBir2e6TymXUbo2fCkwW7KrNaqxAlsxugPRLYair?=
 =?us-ascii?Q?xAoUS+jr9cZHfw7a6r+yhpOKy+VU5/GuBGK3T5tfAbPMvNUIM+60BQjuY5Fj?=
 =?us-ascii?Q?upMrnz3c9KvfRkpYh1nDth6I7BhN94+xreTSz6mShqvBgjGTn/N3LORkZuSB?=
 =?us-ascii?Q?2IT/wZJNwtDygCL/3IIpmD95xET1P5cV37AFdWmn1zgypjvVuLGhVG4/qDBa?=
 =?us-ascii?Q?yGPeCZy01+5pEqw3dSCeHXqWDpMW6HSgLShLvuCEzp+IvG20eVEL0sxW1WIb?=
 =?us-ascii?Q?TfSQyVfRQzW9fk86UT/v+2Y9sU6zVlAYz6aC1bN+qsBFKgBm+q9YId9N7QDn?=
 =?us-ascii?Q?l141mbTl2hlqykjALRlqN/888gejNC7DJ4+ntkHfw181hHoCErPHmpTMo5Iw?=
 =?us-ascii?Q?UiEo5Jjo10mdkMzYuGwZeIZRrwzY22WJRRUDQmQVYrGiGM78ymNrJzbcGz+1?=
 =?us-ascii?Q?rT3IsY4bwzDl3GxHlIiHdpCekM8wpcfuKDXDFtdzc6nkE5tRB8PMoWqOZJ+F?=
 =?us-ascii?Q?QOcrd/1iSXgW3vVEpPZxkq+1k2B8c8zl+w47Lt9dm8sgxVVwB+ds0oBpafNs?=
 =?us-ascii?Q?S9zpZclsAD0zNUJXiM5PcnH/O56r+fjwkgejeQXnIDCFzkAHxn4ZWmANgnqD?=
 =?us-ascii?Q?lS5iAkbPIn/yJ2GWg6k+IBFteiFMKwov4tlhGGJzxM/i/PonS+VI9p5Aeg17?=
 =?us-ascii?Q?GT8Qz9agrjGbJkXrVORQRplXlTeetGGDZVtj6A2fzT2FBdoMoFXUB8wfkUTH?=
 =?us-ascii?Q?LuzC9VKKifvC0bPpY9Lyh0b917vrLw6p3YrbkSADzy6/0kC5jX1Kxd6mr/uW?=
 =?us-ascii?Q?sLwjExNNY5qV8tewgwG9tuSLyMi+fPAznHBM7N+iJ6QMKqC3gL9cfTmJ/l63?=
 =?us-ascii?Q?/BIzTlqZbKAgyt6EZj6Hwouter3CQth5HX+e9col7wVE4AQvZhcJHgz6KVPg?=
 =?us-ascii?Q?87WDtkmJUHk/f5TXwHtg8Nj43sQs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 07:56:59.0668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ff2c71-aeda-4f4e-3e8d-08dcdd37a216
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5809
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

Using pm_runtime_resume_and_get over pm_runtime_get_sync is recommended.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 263 ++++++++++-------------------
 1 file changed, 89 insertions(+), 174 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 485672f3d6c5..042a4dd1bd6a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -145,11 +145,9 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	amdgpu_dpm_get_current_power_state(adev, &pm);
 
@@ -185,11 +183,9 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 	else
 		return -EINVAL;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	amdgpu_dpm_set_power_state(adev, state);
 
@@ -273,11 +269,9 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	level = amdgpu_dpm_get_performance_level(adev);
 
@@ -336,11 +330,9 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 		return -EINVAL;
 	}
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	mutex_lock(&adev->pm.stable_pstate_ctx_lock);
 	if (amdgpu_dpm_force_performance_level(adev, level)) {
@@ -374,11 +366,9 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	if (amdgpu_dpm_get_pp_num_states(adev, &data))
 		memset(&data, 0, sizeof(data));
@@ -412,11 +402,9 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	amdgpu_dpm_get_current_power_state(adev, &pm);
 
@@ -485,11 +473,9 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 
 	idx = array_index_nospec(idx, ARRAY_SIZE(data.states));
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = amdgpu_dpm_get_pp_num_states(adev, &data);
 	if (ret)
@@ -544,11 +530,9 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	size = amdgpu_dpm_get_pp_table(adev, &table);
 
@@ -580,11 +564,9 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = amdgpu_dpm_set_pp_table(adev, buf, count);
 
@@ -808,11 +790,9 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 			tmp_str++;
 	}
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	if (amdgpu_dpm_set_fine_grain_clk_vol(adev,
 					      type,
@@ -865,11 +845,9 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	for (clk_index = 0 ; clk_index < 6 ; clk_index++) {
 		ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
@@ -929,11 +907,9 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 	if (ret)
 		return -EINVAL;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = amdgpu_dpm_set_ppfeature_status(adev, featuremask);
 
@@ -960,11 +936,9 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	size = amdgpu_dpm_get_ppfeature_status(adev, buf);
 	if (size <= 0)
@@ -1029,11 +1003,9 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
 	if (ret == -ENOENT)
@@ -1102,11 +1074,9 @@ static ssize_t amdgpu_set_pp_dpm_clock(struct device *dev,
 	if (ret)
 		return ret;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = amdgpu_dpm_force_clock_level(adev, type, mask);
 
@@ -1283,11 +1253,9 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	value = amdgpu_dpm_get_sclk_od(adev);
 
@@ -1317,11 +1285,9 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
 	if (ret)
 		return -EINVAL;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);
 
@@ -1345,11 +1311,9 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	value = amdgpu_dpm_get_mclk_od(adev);
 
@@ -1379,11 +1343,9 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
 	if (ret)
 		return -EINVAL;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
 
@@ -1427,11 +1389,9 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	size = amdgpu_dpm_get_power_profile_mode(adev, buf);
 	if (size <= 0)
@@ -1492,11 +1452,9 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	}
 	parameter[parameter_size] = profile_mode;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = amdgpu_dpm_set_power_profile_mode(adev, parameter, parameter_size);
 
@@ -1520,11 +1478,9 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	r = pm_runtime_resume_and_get(adev->dev);
+	if (r < 0)
 		return r;
-	}
 
 	/* get the sensor value */
 	r = amdgpu_dpm_read_sensor(adev, sensor, query, &size);
@@ -1639,11 +1595,9 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 	if (!adev->asic_funcs->get_pcie_usage)
 		return -ENODATA;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	amdgpu_asic_get_pcie_usage(adev, &count0, &count1);
 
@@ -1770,11 +1724,9 @@ static ssize_t amdgpu_get_apu_thermal_cap(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = amdgpu_dpm_get_apu_thermal_limit(adev, &limit);
 	if (!ret)
@@ -1807,11 +1759,9 @@ static ssize_t amdgpu_set_apu_thermal_cap(struct device *dev,
 		return -EINVAL;
 	}
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = amdgpu_dpm_set_apu_thermal_limit(adev, value);
 	if (ret) {
@@ -1851,11 +1801,9 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	size = amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);
 
@@ -1892,11 +1840,9 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
 	if (size <= 0)
@@ -2010,11 +1956,9 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	r = pm_runtime_get_sync(ddev->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	r = pm_runtime_resume_and_get(ddev->dev);
+	if (r < 0)
 		return r;
-	}
 
 	r = kstrtoint(buf, 10, &bias);
 	if (r)
@@ -2337,11 +2281,9 @@ static ssize_t amdgpu_set_pm_policy_attr(struct device *dev,
 	policy_attr =
 		container_of(attr, struct amdgpu_pm_policy_attr, dev_attr);
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	ret = pm_runtime_resume_and_get(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = amdgpu_dpm_set_pm_policy(adev, policy_attr->id, val);
 
@@ -2774,11 +2716,9 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	ret = pm_runtime_resume_and_get(adev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
 
@@ -2819,11 +2759,9 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
 	else
 		return -EINVAL;
 
-	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	ret = pm_runtime_resume_and_get(adev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
 
@@ -2868,11 +2806,9 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
 	if (err)
 		return err;
 
-	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (err < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	err = pm_runtime_resume_and_get(adev->dev);
+	if (err < 0)
 		return err;
-	}
 
 	err = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
 	if (err)
@@ -2909,11 +2845,9 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (err < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	err = pm_runtime_resume_and_get(adev->dev);
+	if (err < 0)
 		return err;
-	}
 
 	err = amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
 
@@ -2939,11 +2873,9 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (err < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	err = pm_runtime_resume_and_get(adev->dev);
+	if (err < 0)
 		return err;
-	}
 
 	err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
 
@@ -3003,11 +2935,9 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (err < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	err = pm_runtime_resume_and_get(adev->dev);
+	if (err < 0)
 		return err;
-	}
 
 	err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
 
@@ -3038,11 +2968,9 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
 	if (err)
 		return err;
 
-	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (err < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	err = pm_runtime_resume_and_get(adev->dev);
+	if (err < 0)
 		return err;
-	}
 
 	err = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
 	if (err)
@@ -3078,11 +3006,9 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	ret = pm_runtime_resume_and_get(adev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
 
@@ -3121,11 +3047,9 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
 	else
 		return -EINVAL;
 
-	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (err < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	err = pm_runtime_resume_and_get(adev->dev);
+	if (err < 0)
 		return err;
-	}
 
 	err = amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
 
@@ -3250,11 +3174,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	r = pm_runtime_resume_and_get(adev->dev);
+	if (r < 0)
 		return r;
-	}
 
 	r = amdgpu_dpm_get_power_limit(adev, &limit,
 				      pp_limit_level, power_type);
@@ -3341,11 +3263,9 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 	value = value / 1000000; /* convert to Watt */
 	value |= limit_type << 24;
 
-	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (err < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	err = pm_runtime_resume_and_get(adev->dev);
+	if (err < 0)
 		return err;
-	}
 
 	err = amdgpu_dpm_set_power_limit(adev, value);
 
@@ -3789,11 +3709,9 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_sync(adev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(adev->dev);
+	ret = pm_runtime_resume_and_get(adev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	size = amdgpu_dpm_print_clock_levels(adev, od_type, buf);
 	if (size == 0)
@@ -3881,23 +3799,23 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
 	if (ret)
 		return ret;
 
-	ret = pm_runtime_get_sync(adev->dev);
+	ret = pm_runtime_resume_and_get(adev->dev);
 	if (ret < 0)
-		goto err_out0;
+		return ret;
 
 	ret = amdgpu_dpm_odn_edit_dpm_table(adev,
 					    cmd_type,
 					    parameter,
 					    parameter_size);
 	if (ret)
-		goto err_out1;
+		goto err_out;
 
 	if (cmd_type == PP_OD_COMMIT_DPM_TABLE) {
 		ret = amdgpu_dpm_dispatch_task(adev,
 					       AMD_PP_TASK_READJUST_POWER_STATE,
 					       NULL);
 		if (ret)
-			goto err_out1;
+			goto err_out;
 	}
 
 	pm_runtime_mark_last_busy(adev->dev);
@@ -3905,9 +3823,8 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
 
 	return count;
 
-err_out1:
+err_out:
 	pm_runtime_mark_last_busy(adev->dev);
-err_out0:
 	pm_runtime_put_autosuspend(adev->dev);
 
 	return ret;
@@ -4760,11 +4677,9 @@ static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(dev->dev);
+	r = pm_runtime_resume_and_get(dev->dev);
+	if (r < 0)
 		return r;
-	}
 
 	if (amdgpu_dpm_debugfs_print_current_performance_level(adev, m)) {
 		r = amdgpu_debugfs_pm_info_pp(m, adev);
-- 
2.40.1

