Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FB8CA1009
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 08:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D8F710E46A;
	Wed,  3 Sep 2025 08:13:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hGzOlvjA";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4579010E47A
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 08:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwOe+Bz8j7A6zbTNVEL+mpx6L54gsO3oRXZEHDxYjvGGDFKxNHo45tpiJpgMo+nPvfajywCe+1OMtoMHXct/g8MPqs9iFfjirDzzUQ8XpF38hTOEKIVo2xbLzpt4lTmqvJhdUYqxW+pYsAvu0ZjnqOk2i9Bzwu57msiRADVx2zJPFHcenWsXAF4vYlzQC2S8fLQt+HPwBN8OIjrOpK2ijm3VxyWdz+Qus+nOIkJXHMkGnKLS2Wv3bsT8S14hQcs8P4MUkuWZuQTZExpZVSVzGgzwn+MRoI1MOIlWSg0WU+JJGSnnAYlyG6jQSR8/ws3A7GH+AD8bt8DSDVD+QZzShg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jByrvHpKGli8kKw1U5fmRrCKCNAa2biqeLRM2iGn2yM=;
 b=nobf9J3h1jc8o8BnkvVtV+UwvbollLK1nhm7qaOdX8crOd5eOoaMprN3ImXWm693nXWPuzdIqaFmYAhvcrmUGncEKbvfADZTp/1StHOsWpkuNY6aLxNctVLJXuEkG78Jqse5LT+dfMSgi55lajOjFRuxeOB/b6dwwj/Jaony4UoyCyYMr1+k4V3DTqoC9Iyv5Xfn/l/q0HNkOg1G6vYpCFZ4GKqngA1aEBfyTZh2K0ApERZIaT0D666Ia+ufIdi+dNKBHx0DJkv+Qv8lHc2354ms6eawoE3Tde61nUrcywLm4WCL9LsrN1AEm5ikGgG4oRJX9TkU/yZMZJp0RIYUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jByrvHpKGli8kKw1U5fmRrCKCNAa2biqeLRM2iGn2yM=;
 b=hGzOlvjAo30TrZDfSPHtY1H7DUZ6cHvZo6X/azlKuPKYKKE7bNNkHkWLv35Or0/K9tNmYAWy8yU5jRmJu+J3WB5/VSetO3t1Pht73bBmpZYCf5XPuz4qDLh9tTNJIWD8S1iW8P4f6Y0cPKPJSUOoiesFFWDyGZqDPn047GTkV5k=
Received: from BN9PR03CA0442.namprd03.prod.outlook.com (2603:10b6:408:113::27)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 08:13:44 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:113:cafe::92) by BN9PR03CA0442.outlook.office365.com
 (2603:10b6:408:113::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Wed,
 3 Sep 2025 08:13:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.0 via Frontend Transport; Wed, 3 Sep 2025 08:13:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 03:13:42 -0500
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 01:13:41 -0700
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH v2] drm/amd/pm: refine amdgpu pm sysfs node error code
Date: Wed, 3 Sep 2025 16:13:31 +0800
Message-ID: <20250903081331.1359048-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: ee04d589-39a7-4649-0ac8-08ddeac1cc2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W1A2YVvurH7fGRCjq1d8d//yGF2fLkuKefZHN4I7toZXMUmQ9SCnAZwheMZt?=
 =?us-ascii?Q?3X5UQ5j2aX7EqnvSUbZ0wJnsaCOSmw7HvWjhNaXERhzvfCBtcnksgMeZhKbI?=
 =?us-ascii?Q?+CyPC73IT6zvwMKTuB+BSd8Srl2gJvY1x8NHxgCLTyIDCywH48PqrVkFg7eN?=
 =?us-ascii?Q?bOatiQ4RCJg8+xpu0S51U4W+HE1t9dYqoFLcf8t/0nluwcBjZzXZYitMrlZu?=
 =?us-ascii?Q?jCgZWbQNLE0ypl0wt3Byft2jhjBkuu2pQPxE2WFJ0+l5QHG6hM6g2pLT0yBL?=
 =?us-ascii?Q?gqxP1HxplSwD/cbJLJk21CShneoh38TIlU9u6wHPDtDh9fI1FBF56afHUM5U?=
 =?us-ascii?Q?mirrqN85c96VKJAk2Iv9nNn6vNhbxLk8p9VPU7kLEJk8r+f77wCmKs40R7K7?=
 =?us-ascii?Q?h5YO2Xnfgzaf+FiCV7COK+tyYuxC7j1ymPFsg0sPIrUgGAL779opWWZMN9P/?=
 =?us-ascii?Q?fDjmPerKO+UUADWvIEJKznorIcGNaPRniabxvEaKsT+qieAYVWKknKrPJpCF?=
 =?us-ascii?Q?htqogQwgGfIazIIGtpXcmyaRudv32aIuag+nj0nvGYgo0+T/euOhwDYV8Nj0?=
 =?us-ascii?Q?RffgiuCPIiLEe5GJWx2J9s7zFaoylmjA8HjYhJ3h7sb/6yDGiCXVrXUhtknD?=
 =?us-ascii?Q?VbRAsCn65SPnJuKtxFwUjifbR0whNOz7eEEqvNXNLPwGh19i+Mlise4ZaGGP?=
 =?us-ascii?Q?bSaUGGrFb/FeizWRweE6ra/hvjQCIMUQnQognDE4DGpf1qvbSmc3N0m1GITm?=
 =?us-ascii?Q?1dumVHXjOv/wPn/rGp3Bcy6NL8AW9JGk8ccSFBm31Q6MI/votJDeb+q8s+bc?=
 =?us-ascii?Q?lcJXR9CgKL9gennUNu3D57+lyQW/FUzqsQCG88MRRQNO0ojyeVyB5DLMVUmi?=
 =?us-ascii?Q?34zVE5z+mBYFLUHdQqJAlZKza61iujh7+Jjhw+wsZPF9gj2D66847qOh6K6f?=
 =?us-ascii?Q?bO1VGyjmX9QCWb5tl8OMhveVT1DhArw6KHiXm2fOdtFbwMYEs5f2t21k41qH?=
 =?us-ascii?Q?m5toFAQve2owmXgRKWT6E0sJc44g9s2b8ULH4/kE4BcUqYUgNtNNKDN1cllA?=
 =?us-ascii?Q?0vIS+IZGZtRTF2qHqkJmBwarFO+H4rPNlv7PLnEvHT+R9shYD6q4V1RdNjj7?=
 =?us-ascii?Q?6a2yhb99QZSmy/gf2L1fnn0cQvimTLzXSzUYDZsOryDNULfeaq0Et7vlHIos?=
 =?us-ascii?Q?rxH+zcaFtvIwHPHO/bdGmW1/ZptKD+OAW8QYAymFKam9YxEZLGH9bDqT7PSt?=
 =?us-ascii?Q?uTX+KtRWdMIQsJ+a+/2Mv0e6/KZmb3wtz1oyaHUePagb7GkvaYmaXPmAMxFO?=
 =?us-ascii?Q?l5u0CSp7TB0e860n5b/ocrvATKjXR1j8AtQOebVpW7YqBYXaajyVYBUSjiec?=
 =?us-ascii?Q?eKvz81cdFmVmDFnZXYluY8E0PdP5p3yNFAEGK7yZhMFncUr2KgHTfoPBePuW?=
 =?us-ascii?Q?OrwMsH0cIrLT5h16rGILUGxU4Li1G0zED+Eh0ef/Ig3EJEOHEmbztX0ltyOX?=
 =?us-ascii?Q?sWeBk9AysWhbhhKGtJmJcX5jYdB91NYZhQWt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:13:43.1139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee04d589-39a7-4649-0ac8-08ddeac1cc2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670
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

v1:
Returns different error codes based on the scenario to help the user app understand
the AMDGPU device status when an exception occurs.

v2:
change -NODEV to -EBUSY.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 0906bff864cb..c2095fce694f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -110,9 +110,10 @@ static int amdgpu_pm_dev_state_check(struct amdgpu_device *adev, bool runpm)
 	bool runpm_check = runpm ? adev->in_runpm : false;
 
 	if (amdgpu_in_reset(adev))
-		return -EPERM;
+		return -EBUSY;
+
 	if (adev->in_suspend && !runpm_check)
-		return -EPERM;
+		return -EBUSY;
 
 	return 0;
 }
-- 
2.34.1

