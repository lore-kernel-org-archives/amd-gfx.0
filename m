Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D25C3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 06:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A6CF10E4C8;
	Tue, 20 Aug 2024 06:31:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z75TZ3by";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6031A10E4C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 06:31:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsAy2F8wI7Pvjy4ut7/Q0l5zRVlOeZPTIUkPEOxmgSVzYnyE2PFJyPMxMrCsxzgSD0BUN/BxsMEyw+MChXwxk1amTZG78YCM/AxFOSwiaNz/0iG5N9SDetPBwS7aoXWPoApj/7GdRpolgf0j8mRMlhnjaBSVMpzH1GJdpJko68hz7a/FX0X3c3Iu85hbez3FJCXygURs3NPnuHvY5s3NNkosa2ZLCsnkHoOqYPTjdrRz2gxq6w3LantLgK+VvEvxjRVHA6QmtTm5OJXVNP5YJeAs4l6c73p78NaoXGp0s9x1x0ugEBEJLepZvRwjxpeEisOhmk1Q77rvvMJCQEqGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqyJvvwBoNXM1+bmNSC9oahPch4w7PZAG3s1jMgywc4=;
 b=BZeYWyzxhZkNIAxBDQLwy1dRI2WJJR3DbSFIr5GRpLu0Ephc2HLDh/2Lcv6EBiJZ0qMGD3/GGHxzK287uFkd7iKL1jSqdcd9qOumCveeHRIC0d9Woc4K+6dH2sFwb+UAePeRKAPjTDv0RG+4iPSgA+zQVA/Jn9+7vNHfrjdvse2XBWe2RYewU9NYF64lpQh6ZcJqb73T6RdOQ4pWrDdoZfDsUfCIKc6Gs0f9nO6f6b/arSuCZ/JAARPkN1ZQN51g9brEmj4zLR4YrgL3SNN1p/GwxcWih0084WvuttLT0NFbxrhbFzInOzhpvG63LqJ9Ddj3mc3rlxxJ3FOnJTIiHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqyJvvwBoNXM1+bmNSC9oahPch4w7PZAG3s1jMgywc4=;
 b=Z75TZ3byzpyB/SYV6301XifWF3R+WXxOnut9vkc8Sa9oCvWV0yOx2llTdVsfAFHP749Ixr2euAIzWi4Hv3JqfI96GC7rvT8sdCyYLUhjBkytbB5exR26rG+sLdTnWmJWNxephrFhhS+WPhm67dGhWovRKsoDpdES5NIPnnKHf7Q=
Received: from BL1PR13CA0277.namprd13.prod.outlook.com (2603:10b6:208:2bc::12)
 by CH3PR12MB9097.namprd12.prod.outlook.com (2603:10b6:610:1a6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 06:31:00 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:2bc:cafe::5) by BL1PR13CA0277.outlook.office365.com
 (2603:10b6:208:2bc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13 via Frontend
 Transport; Tue, 20 Aug 2024 06:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Tue, 20 Aug 2024 06:31:00 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 01:30:58 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Yang Wang <kevinyang.wang@amd.com>,
 Kenneth Feng <Kenneth.Feng@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: Do not support swSMU if SMU IP is disabled
Date: Tue, 20 Aug 2024 14:30:41 +0800
Message-ID: <20240820063041.6786-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|CH3PR12MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: e62b6ada-f2a7-4a56-2e37-08dcc0e1a869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MgX16KUIEk2IFvYAsLWYV9fTVwOJm6g0bkeAfFzYzxCgJkCEVjnXQQQGY3bq?=
 =?us-ascii?Q?IMGdDG/NW1N15iigqogEq9/Bev72mz38KNyWoDwdNv3S/oRPAw8s9fTXnG3a?=
 =?us-ascii?Q?cxalv/4hKjUDJtm8Osyrdry+nFJGRbmLBs1xwZ0NVNWd62eme6y5AbzcfvDw?=
 =?us-ascii?Q?HnHGDsGmS5FhCnnzI9KkGSIBqolAFUxe760hdMkbzDBohVMqEaP95n7yTtw/?=
 =?us-ascii?Q?6Zq1P1xjJAWcXUMZpx0QCrFmNOChzrmG1JDUWCNLCOUO7YO7sSJmJkXxqrpI?=
 =?us-ascii?Q?CzFCOEcq295+ajOEXz5f7Vp2+pBF8WtBHrb7W3ff4BWI0W1cAGnlwARjlyV4?=
 =?us-ascii?Q?UEf5peMP4Ah6Si0hwZmnm3LVhVCBntJKg21KN2Zm9jG0dRluwwBc40f2nND9?=
 =?us-ascii?Q?+c0zx6xb1K2aF+nG+hDYBtgYmk2D/2nO1i2g/4JO1NtahnhYDiNx7KINZn0p?=
 =?us-ascii?Q?BgYsIVLEYKAi4yQCshE2ycY/XJ5BK/X+JIYSwMf0FzDiCtL9fgx/DtHROAwd?=
 =?us-ascii?Q?40Hjsf22w73MxmXfcns3Gm+uNTzOo3q+3aMO3d0dH2N1cNDhieegcJRyM1oo?=
 =?us-ascii?Q?+4IwMJ79x8UNf4Svp45p+QqLsvumEeUyYtPqQOC3dgVRTqNc9ZdLz3pwtjpa?=
 =?us-ascii?Q?UR4qpH0M3Ms5A9FvTFew8W1X/OMa3N6zGsdBt14QFiiK7sO2FZzM1Aj3lmuw?=
 =?us-ascii?Q?Bz4P23dpVugoUULFyjRxK/6YtfZlgvRt2u5S4RX+1tcU/k7RRlzmFWakNIXX?=
 =?us-ascii?Q?ZG3Cs72Db3bXSsfQdeF6P/HCy2csW2t101VipSf38FhHsKYt+G3d2/QrFjn+?=
 =?us-ascii?Q?nQSvbwcoVCl6qVZpJd1QtBbe5dinHsyYN8DENfCOQS2YEMQJXgvHNYnr18xb?=
 =?us-ascii?Q?UT/h0KnOdpRyVdxD1Am0NN87fBle+hrBbaecxpsKZqs4XcHGxtoV/aeJWIo4?=
 =?us-ascii?Q?2aoTnMefIcrLKDOszjbQsOP0b16or+e9bLCUA/Pb1oTYWGmsz/Gy2h9xIjun?=
 =?us-ascii?Q?MViWBH/TEAxk3tnYLPSFbeLMMGmUzwNF5DIBm/d2xdUuSMnNR0pVMAxHnmGK?=
 =?us-ascii?Q?iuux720XGAzbSp9i9lo66b/4ZTEgpA6wGp30uNMSxpTmGmYvUu+0KconsTFm?=
 =?us-ascii?Q?zde2opTVSPpOFEeU4bpPPDH9dIU2QKBH87JIg/IYSNEwLc1hdXJPmaTwVnzN?=
 =?us-ascii?Q?3UC+78r59dRn7NWPIGCm9Q79uCbRLd8nTVfE4+3SZeuc1jRIUKMfAPHtC0WN?=
 =?us-ascii?Q?w7z0SuOrJ+Fo1QSXYvqJyrc06cf7mLnZNTdp7qNbs9LqSJK0y4wT5lRYhCh4?=
 =?us-ascii?Q?su3fMRAYvNT8jSyyq2O08ViQ7Yn7kGO06zF+bJcAwGsiHTLQoYcAucC7AJD9?=
 =?us-ascii?Q?H1bKIS9i39scOgexX4ngdyw3fK/EEZ2pc6yYMbBJ77PZkdMfw4LSnhYw16Rt?=
 =?us-ascii?Q?ray4FbKnXL9G1QrLF2cX5XRQBYDZZrBd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 06:31:00.4782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e62b6ada-f2a7-4a56-2e37-08dcc0e1a869
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9097
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

When SMU IP is disabled by ip_block_mask, driver
should not refer to any dpm/swSMU callback. Instead,
any driver call into swSMU/dpm callback needs to
return error code EOPNOTSUPP.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c803c903e47f..31943b4db276 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -549,7 +549,8 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
 	if (adev->asic_type == CHIP_VEGA20)
 		return false;
 
-	if (amdgpu_ip_version(adev, MP1_HWIP, 0) >= IP_VERSION(11, 0, 0))
+	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) >= IP_VERSION(11, 0, 0)) &&
+	    amdgpu_device_ip_is_valid(adev, AMD_IP_BLOCK_TYPE_SMC))
 		return true;
 
 	return false;
-- 
2.17.1

