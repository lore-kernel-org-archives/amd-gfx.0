Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837B0C282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 13:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CDCF10E9ED;
	Fri, 14 Mar 2025 13:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uvvZ3sbq";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D413310E9ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 13:47:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9TdVdLFQuCWAgktcSmPvEy18VUkx4KOxm+L13c99vmc+Yum9BUA/I4oqFf70m/a+nICDzjoWQbGs2eSXnkx9udeBZeh14mrZqPnntsvArLNaoeusDmNr1LqmJO1gkhP2RDBBYunYeKwf+GO5ThjUF7f6aLsAnkxf1kHHqxWxNazgC54HdYvnw2dIPrjFH3hq/qUQ3l34eTFMBJl6n5S1aRl2NsS0faC1bt9d0cKh/YpY6X8kkrTh3LNIMMbNmBKaTkllFsabZ7us6I+I5kti15JszR5OlNY/yD4scMug66ta9HJ5it9lLoPixOLsAQPAGKhNMM7ZeTlXU+becM7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAUZJNnsWnVI376YWZyT4eT9zx7dmW+0C1tss+jv0u0=;
 b=s+P9oujnR7T8i+MVLwlfbqt0SUSoAfKGwMM2Kfbm0VAU6QboOJBQMVffNDgYDqdHAXN1myy+GIGUyu4ZGn5qAHChweQHVrwN+UyPkhpyqviDdIPActAu60qT5ZHQFfsKLBrlOjYUn8uaBcXBXawkHtS9bSqZ/DFbzYp3MZHxvdpUNeeF6sEh+nqg/ZgD8CayReocXNRDhVR5c8oezIlN/OYMFu1J+jVagRfEoSZBA7gjrOxBC8pVCD+wQcd1njtLJRPzkHtPoXtC8mNodfGWurFpyYY+mW/TK3VCJ+O3M8/0Qyv4Fp43URpSes7JT7tW1JPN/4bBcDwmSEytFSwWDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAUZJNnsWnVI376YWZyT4eT9zx7dmW+0C1tss+jv0u0=;
 b=uvvZ3sbqw8b+xMcHJAhdbU3Ok/dpS4FKNDlPZA2vOMKkrXALdW1aCu18L+ChUbaC7/YHqTuF0+EYS9mGh75Y86BG99knB6YM4AQBta3XBdAfYELRZUgtNFcIDgO6kj+Q4LiP5rTXbIAuWu0wF0ITJ1MvP1IttpS3DMm6buSEtGM=
Received: from PH0PR07CA0104.namprd07.prod.outlook.com (2603:10b6:510:4::19)
 by CY5PR12MB6300.namprd12.prod.outlook.com (2603:10b6:930:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 13:47:23 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:510:4:cafe::37) by PH0PR07CA0104.outlook.office365.com
 (2603:10b6:510:4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Fri,
 14 Mar 2025 13:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Fri, 14 Mar 2025 13:47:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 08:47:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/gfx: adjust workload profile handling
Date: Fri, 14 Mar 2025 09:47:06 -0400
Message-ID: <20250314134707.3012124-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1801f2-1657-4ceb-6350-08dd62febee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QAQTUdguJyDj/E7y8BKuMI53PPU/597r9YnmAzXpu6zPwce4n6wR9niRdqmp?=
 =?us-ascii?Q?rqwITKEaqQBog1lX/SOIxAhwCTkXFtHQASQ/UkrqqszqnH3GsTN7lnyHXDqP?=
 =?us-ascii?Q?HXX19e5dOp7XWOyDbzKqU/TxC53ZTT3jwvINVEFUsMjEeV1TT9+rCiyyQpLL?=
 =?us-ascii?Q?NrNcx72iPXndfXJEM90GrLnlEzfQffSwilGXgM/fMb3efk85Ah7MPSSX9osk?=
 =?us-ascii?Q?wElk2DOAcUKpTCFEpkxxu/rqNrvfOARe/X0t63tOhRq1GecJkiqnWhnKOTrC?=
 =?us-ascii?Q?zr10NkNH5jVhViHtqL2+PBqIf6Ypl63jHYNiY25uUdkjMKX4cV0bO5gM/YEQ?=
 =?us-ascii?Q?qf52qkt5dmvKzeg68SevQNfR2nqUaLDZnMC/hDFTnVNH9q09RxpVat+7xbrD?=
 =?us-ascii?Q?Jpbf5I0Cv/EB8NsXClXUV2af59mr4IRFL0R9zLb3oaVq1p0c6m1nWe3UU2rI?=
 =?us-ascii?Q?hQ2cgS2cO/ZzrMazqnT6egfd+1u+OqqPM+kmA5tr+z1WqhE4jvRErYjC/ZeZ?=
 =?us-ascii?Q?G+Q/B5iO3H7nS+R71eVjEmva8btuXXt9txQSlcR4TZdCpg4OSyzu/HATjdVF?=
 =?us-ascii?Q?PsuNLAVBwxvvAwdyfkankZhST07mM0RHeeTrwfy/v2010pn5ISRzGQL96FqP?=
 =?us-ascii?Q?vlM9Ho656Tw1lIw32Jph71UD8/86D8go8lXakRQ/jCQieeOhPSILS/tBGoJL?=
 =?us-ascii?Q?fOvRYsAAcUG7hdwGia3SkBtU5xuniViLUg4UEgSl7SLyYzMIrAErSIyvPytS?=
 =?us-ascii?Q?uiTOAGIBZTG8NuPSAk1Wi/iISpl/Mj/j8rH/dz1DFJJ/9kGtCPfEYbk9E0Fk?=
 =?us-ascii?Q?R3MorFYpXrO8kWNc21bGHrq/Y9Yg/iq34Z5Dq/4YKYgwdAVfjcvXO4R9s1mB?=
 =?us-ascii?Q?lzkrDcgjadCTXObcexoIBz+n+niLbj9/4qCyPPY73rcFHuu8y+FDQEyWsK/B?=
 =?us-ascii?Q?3KL59EoDfg473bpKRVSsGHnZsUvXvxbW9ENG6yUFI/mCXzRNHrN0H3couJM1?=
 =?us-ascii?Q?gp69gdzGsGuns1RvR8Ls6DcO7a5/vDve9/NVeGcqVfdEPp+X/rmA8l8DxlcS?=
 =?us-ascii?Q?F9ZPFVkF6NMv7b3qq0AuKxI7dL0Dc0sE9QYS44jjp0QHBDRbi1sOt+HF1DfF?=
 =?us-ascii?Q?iLSCKYbxgerbLon4dTstl5qSC3R4bacHTVoDfqArK1bp5tRr1nuLRkC+7gvl?=
 =?us-ascii?Q?Rkdq2Es9do+wcUftr2hsUDhobKCgkA9xwrFkqZP29iwvqE1YVStqOJcP7bpL?=
 =?us-ascii?Q?+Ff4ZfXiljRgIYN15DVbTE3iPffHwOOcaxUBh1INZCPARg7MX5XykBk8/4zp?=
 =?us-ascii?Q?NjfgAVnniq5ki42VFEYoT6lEeFFwAmJy9QN8LyYaHjxlXTSvgkVo79eTzzMH?=
 =?us-ascii?Q?y2H/FlYZK4wSNnB32VrSK07JvwZs5qpoad/bCNYu5y/sQbpu5o9r93+Rqv3O?=
 =?us-ascii?Q?yJ5XI9HXNGplC0pIdAElC1DZMps6U+gh6D5tQgk/yqkrfhC0jorCTZTWvkzg?=
 =?us-ascii?Q?sGY7jHeITJPlV1M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 13:47:21.8417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1801f2-1657-4ceb-6350-08dd62febee1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300
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

No need to make the workload profile setup dependent
on the results of cancelling the delayed work thread.
We have all of the necessary checking in place for the
workload profile reference counting, so separate the
two.  As it is now, we can theoretically end up with
the call from begin_use happening while the worker
thread is executing which would result in the profile
not getting set for that submission.  It should not
affect the reference counting.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 099329d15b9ff..20424f8c4925f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2188,18 +2188,18 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
 
 	atomic_inc(&adev->gfx.total_submission_cnt);
 
-	if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
-		mutex_lock(&adev->gfx.workload_profile_mutex);
-		if (!adev->gfx.workload_profile_active) {
-			r = amdgpu_dpm_switch_power_profile(adev, profile, true);
-			if (r)
-				dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
-					 profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
-					 "fullscreen 3D" : "compute");
-			adev->gfx.workload_profile_active = true;
-		}
-		mutex_unlock(&adev->gfx.workload_profile_mutex);
+	cancel_delayed_work_sync(&adev->gfx.idle_work);
+
+	mutex_lock(&adev->gfx.workload_profile_mutex);
+	if (!adev->gfx.workload_profile_active) {
+		r = amdgpu_dpm_switch_power_profile(adev, profile, true);
+		if (r)
+			dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
+				 profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
+				 "fullscreen 3D" : "compute");
+		adev->gfx.workload_profile_active = true;
 	}
+	mutex_unlock(&adev->gfx.workload_profile_mutex);
 }
 
 void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)
-- 
2.48.1

