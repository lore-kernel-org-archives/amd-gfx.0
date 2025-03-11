Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E349EC282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 14:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8372E10E252;
	Tue, 11 Mar 2025 14:17:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4PzZXmi5";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7E3D10E200
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 14:17:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fu/XXS5SKt1P7vFS5lZdi36GLR48Cwm72MTZvC3mRPaoP95h6c7M3oFj2zivN9PwBYAaZXDVpZnrtM3JtrYdQmuuTiekUIMU9tr4+bJWu3UQX3U7dma0ccdaJcfyjK7rcsES23X//1wX+TyAsGDVC25BeqnExRLAU46HGRrq3BRruzEN9+8V1KQadj4QcSz9nZSH+2IUSi1HJLG4IC2avhPVseCThANRTIXxcAxjdIuPEkTzPk5XXdTLFMnIQG62wviRpPrXUyZu68Rw4nvT8V7cgM9a9dKakz+OhAocfif7IJ/YQMIAYuB43jqVrpSovP1YTUDic0Jn6d3/7bo/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQ8I4clkdfMZyGil80qXuHj59REG6rhGyDkEm+VByf4=;
 b=GHmBnDxTjuUSgy9uVmAqw7yb7jnKHuu1r/r98JIA9g6FlHjqpI7rmv9i4+O9yyq4npbwvINny/xzHvBUwKKOwUGM+qPg50FocawpLWw49ZERmixOk79DUocq9zWeM9nOj+IrTRnwP7EUV3o+d6ALCDTWzHZbvkAxFDwxg/p60G2NzdZWAysjGEUsNZeH2TYi8SmPhpc3IwAMxkkvBIKWttSLI3X9lU4IEKhnjHrOU30OoAZ4ld6On5LIlJ5HL6dgRb9tbiVPo3v+U6rLkR6tjHRFfkiub84Fl3dILjYav20s5PjJ3AypxB79Ba3iLRhwed95LlWY8/NXATZmSTyAzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQ8I4clkdfMZyGil80qXuHj59REG6rhGyDkEm+VByf4=;
 b=4PzZXmi5D/IL4JVgaB2WpGSb6Cc2WP6CuLb1dJR/97xJsfjV3Hmz6IwJ+K2wYVvKJajasuvLNvH6k3zgvi0ggXCefsa1nC/kJWKfhagDTvFDTJw7oYiKyFsPYqpqC4HiEFym2cFmzChHrswfQGAz8oaZBaPVPD85zpMZktUj1m4=
Received: from MW4PR04CA0177.namprd04.prod.outlook.com (2603:10b6:303:85::32)
 by CY8PR12MB7169.namprd12.prod.outlook.com (2603:10b6:930:5e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 14:17:30 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:303:85:cafe::bd) by MW4PR04CA0177.outlook.office365.com
 (2603:10b6:303:85::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 14:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 14:17:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 09:17:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/vcn2.5: fix ref counting for ring based
 profile handling
Date: Tue, 11 Mar 2025 10:17:11 -0400
Message-ID: <20250311141711.1911564-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311141711.1911564-1-alexander.deucher@amd.com>
References: <20250311141711.1911564-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CY8PR12MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c463ed9-1622-4d5e-4f86-08dd60a77556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2tDa1hJOWViQzJucVdPMEtVSk5CQlNYTnp6Z1UxbVNaNE5CQklhd3NsQXhi?=
 =?utf-8?B?M2p6LzVOVFdqN0ZHWHZwVVR1dVJEcjROSlZGeDE3ei8rZTZrdHhNMDd2akNN?=
 =?utf-8?B?TUJCSk96eWVWRFlaa3o5Wkd6WUduS3ZRWFp1NUltQ1NMbWZqUnB5aGhXdmZw?=
 =?utf-8?B?bTJYekJCNUlydnFxbDBOeXorcCtvbmswZGI3RWxrMnBFQVIzcThoODY3elZE?=
 =?utf-8?B?SGdZcVllOTNvNlVNeEc3Z0ZiQzFLY3Z0d3dUamxmMVNVbjdsWmFObXk5U2Jy?=
 =?utf-8?B?QUhKeUZWbmQycFp2RmJ1VWJmenlYV3Zxb3N6WnlZMkoyWkRwSnJKSm5Za1NB?=
 =?utf-8?B?TS9EWm9YeERIb1hoZVZuOVVERm5TSEMwVGZCWUJlYzlHeGtSUDNMUk9pdFRF?=
 =?utf-8?B?S29wUWFST2tVdGtRMGxlSWZNcDM1elNlTEFFN3hJV0ZFN1RQZmlQSmgyNjg3?=
 =?utf-8?B?bHZ6aUdSRmFBZlpZS0JEYk93YW01Yko0WVpEdnFwUGNLYUtuVHJzeS9pelcw?=
 =?utf-8?B?R1dyRHN2ckVWZEExMHRXSHB4RzNyZmlrUENvL2s3M0p4VXI1YlZpY0JXMExm?=
 =?utf-8?B?YmFWM1VnbUdGbFpHWURYVWRDSkgvQktLcCtlbWljb0YwZTQ5ZlpOYkh2UU5H?=
 =?utf-8?B?V01aZ1F0cjlYdkNLT1F5MkRLc1g5YzczSjgveHNXVTg2aHFzMERPZ0JicU50?=
 =?utf-8?B?QjhiNEhVRVBKTTNpb3Uzdk9pK0dtUUQ2T2ZKd3U3TVhxb04rOGpEYUtiNkVp?=
 =?utf-8?B?UE9qRkVveGVLRHIycXpuNDFHQTQrVVp5YTRBV0xMR0FlQlZsa0xPZGFiTUtX?=
 =?utf-8?B?ZEJhb3NQUVlPc2owbXNlSStqemNFemsyYm9PbERCUU41Mjl4eVpmSDRFOXZC?=
 =?utf-8?B?U1hBMHlpMkVzeHJRT3E5aGJRUUtQNGNXblQ1YzBZRzdYNzNsOFFxRktRaUpX?=
 =?utf-8?B?aXcwSXdYdlQ1UkxxZlRGUmdlTk5TRUExY2NhVXFkTUgwT284NVpsekpRVFpj?=
 =?utf-8?B?Z09lNmRXNDNwclM4Wk1DK0ttU1dIS0NvOWd1N3VEQnhIYkVzc0hSMjJwQlZ4?=
 =?utf-8?B?bzRDL1V1aldYMDg5Rm03TGsyWWxBM0ZUWFN1WGd1b216TVhNbEZEeFRNMmh6?=
 =?utf-8?B?TlhaV0pJaEZ2ejBPK3pmTFJtQjRNR25jVTZCeVlXQm90Z1J1L0RVWEdnRUZU?=
 =?utf-8?B?UlNYc0VKOE9ZZ1dBSUVYaUhRWk5yVWpOWmhQYTdvRHNvSUVxekZ6NVZ0dGQr?=
 =?utf-8?B?OFA1M08xdmFFcDFQUXZuZStHMEpVbHJkRVNxMk4wYWwwVDZFSHE0RWh4eFNv?=
 =?utf-8?B?MmdYeFBKS1p1VXExOEFEUnRKRWQyVms3K0NhaXEzRkFGUHp1bjZRMmp6TU0w?=
 =?utf-8?B?aTN0UWJ2Y2xvNzhoNnBHemRMaFl1ek1obG5mR3poVWVVWjNjM1N1RTVQN0Zv?=
 =?utf-8?B?ZUxFZVlUOVh2L0VsdGV0K001U1NuV3ZlU1gwQytjTUo4VzU3Mnh1a3JLQjZQ?=
 =?utf-8?B?cWJobkJTYkk5eHJETFNwSk0xbmQxQVcrbFFZMXArYnpacWMwOTgzYXpSL2FI?=
 =?utf-8?B?dnNsbEh3b0M3dzMrd0o0dHUyWkRINHlSOWZkenN2N1M0UzlMUzBjeDl4bzBo?=
 =?utf-8?B?SFJDcW1VOGw3V3UrcnRWZnI3ejNyR04xUktKelJDZ1B3MEdoRTg1cTJqZkp2?=
 =?utf-8?B?cVljWFNIVkt0YWN3cTBxS0o3NnZVcTlraUJMNWtsZUx6aXQ0cm9KMDNqNkQ3?=
 =?utf-8?B?ZFlxcnlGaVdnU1JrVEtPNUtPcFJuNzBDbmpLaVhDTGxFZXlYRVJsWTBYeVZr?=
 =?utf-8?B?b0U1L2pvOXNTZWZwRVZCd3RTNEJHS1I2Rk1xYnRmMS94SnBaQ0Z2cGFqbXVX?=
 =?utf-8?B?SkxMUkljNWhyUk10elJXNUtXeitUdXpPcnVla3N2NEVKWXZ6TTNpWWlaMDBH?=
 =?utf-8?B?TDd5TktSaHk3elNCOWt1RDZacTU2MmF0NFNWTTBTYVYwZkdZdVplMVZ6Y1Jr?=
 =?utf-8?Q?/PJNaOk0ICucL7X4ehBd39CCueNMrk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 14:17:29.9155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c463ed9-1622-4d5e-4f86-08dd60a77556
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7169
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

Only increment the power profile on the first submission.
Since the decrement may end up being pushed out as new
submissions come in, we only need to increment it once.

Fixes: 1443dd3c67f6 ("drm/amd/pm: fix and simplify workload handling”)
Cc: Yang Wang <kevinyang.wang@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index ff03436698a4f..2248c4400b459 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -160,17 +160,31 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *v = &adev->vcn.inst[ring->me];
+	unsigned int fences = 0;
+	unsigned int i, j;
 	int r = 0;
 
-	atomic_inc(&adev->vcn.inst[0].total_submission_cnt);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
+
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		for (j = 0; j < v->num_enc_rings; ++j)
+			fences += amdgpu_fence_count_emitted(&v->ring_enc[j]);
+		fences += amdgpu_fence_count_emitted(&v->ring_dec);
+	}
 
-	if (!cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work)) {
+	if (!cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work) && !fences &&
+	    !atomic_read(&adev->vcn.inst[0].total_submission_cnt)) {
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 						    true);
 		if (r)
 			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
 	}
 
+	atomic_inc(&adev->vcn.inst[0].total_submission_cnt);
+
 	mutex_lock(&adev->vcn.inst[0].vcn_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 					       AMD_PG_STATE_UNGATE);
-- 
2.48.1

