Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA756C0218A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 19:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4045F10E6E9;
	Tue, 28 Jan 2025 19:17:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bGKY6x3M";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B375410E6E9
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 19:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKB2M7TfxxTe57R+NFxuTf2llfs6uiR9HrARfBNKv3AffqJOGy1yePSVzLPVz7ZpN/Z3yyFVHZs7xRzFQ5gTOKZo+HvVwd5Wu19FZeQP1g078PLTbArRtxCV5nASPx47YoCz3ggGENHHtvilQWE+9OwW328oXZspFEz/MJuT8tv2HZxcHDzIINg32mtmaEB++yNGv0ebTI/hPALCpD1gM4O3VqAYcGXWtT/3dbzxkEupSBBgtAgw0I7JFBCqLaMkvW9OMH97NUr+YV7V8wYjJP8xuIuMOeJyHWAfNk+NFHnRmjiUi6R8Dh7TyW3YN53aM1L/YS6mb3BD8h/eSCvHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFXzzLXpBI9mnuiJXDjAQmyRTZMHyS0Z+ZD5gPjIGwI=;
 b=Kdi/zERQVEs/WXUkRj/lSALLWfczEyAvWpfrByRozY1h0vKB3ncjNbHso1JDY/8qhFHKoiJQA1m3a0K9Trj7ijRiDYtFLDKYEDXXwNmW/U4ICLQ1x5QDlnvk1VpJpbpF4Dc8G9fMF001Hn28x+No2uND0sPEC4VEDsbmVonZuA5WiwKvB6PqdfGSVPs5M9gmuyCA9QbotQ5nXJ0dJ9xDwhVhwH1zRhSh+5HSW55gOn2pcC0MXZGItBb3rTU8mZ+DAva+zZi9CU+iclfqvqyT6WItEtNbLKovHb8OcL9THwx1pmsTT6G4jW9MZxY52MFgTRClV2mkUQsYc4hObqofWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFXzzLXpBI9mnuiJXDjAQmyRTZMHyS0Z+ZD5gPjIGwI=;
 b=bGKY6x3MlG3NGkLNeO/97eiI39Pt1c2VSJPL+VcjuAWSRcAsVOc6udmvtXeFwitdyYJjpgxm+TP2TPIdRtKzBHYZPCIAQ3eoOB4bTcGsvuIPPh1eMp7gF0yjMEkaze7l11MFzpCc3f+KrZ35W1aNb8P2AOqkFbhR4rQ/+gAZRj0=
Received: from BN9PR03CA0104.namprd03.prod.outlook.com (2603:10b6:408:fd::19)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 19:17:39 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::e0) by BN9PR03CA0104.outlook.office365.com
 (2603:10b6:408:fd::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Tue,
 28 Jan 2025 19:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 19:17:38 +0000
Received: from khazad-dum.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 13:17:37 -0600
From: Lancelot SIX <lancelot.six@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Lancelot SIX <lancelot.six@amd.com>
Subject: [PATCH] drm/amdkfd: Ensure consistent barrier state saved in gfx12
 trap handler
Date: Tue, 28 Jan 2025 19:16:49 +0000
Message-ID: <20250128191650.598150-1-lancelot.six@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|DS0PR12MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8c1dc0-e9f6-4a9f-dddf-08dd3fd06dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HTPGyWuGh/cECvPEXJbXnk54PE1v1TcIUQBKgu1QTM5HVPapFJLYEFlzYdxz?=
 =?us-ascii?Q?FG49GjAjW1EoV6CrzdAtcf+nIlcQSjVXPnPe8yxHXj/vu9Gro6Da23AC6ems?=
 =?us-ascii?Q?wMlAQvWUS/xfgvqrBBRLVkWzQWsBJlNDSXH+xK2ANtKJNF5b7Mb8irBXpcuW?=
 =?us-ascii?Q?N+Np+iS2UYjVxq6UsogSk3cjNYdybIL78aRsCiyoAARoBj38zupwKV795+Fo?=
 =?us-ascii?Q?P8ANYX1hodg+pL8rm4k6ELaPdhBhYj9CV7gj+MH5+NFQ66bgEV51cl+DAmA0?=
 =?us-ascii?Q?zzycx1PjdZN5hNRZtmAlw8MvmRs/EXj53eTC8nX6FEpbU2M55TSmhws1IKqH?=
 =?us-ascii?Q?1PViLb+b6Cnha4SuTpldWKCF81P7glski918WcAEfr6qPF7hNBc+4h2buBnH?=
 =?us-ascii?Q?8esbpf8gefE9rEohvtmPMBRX9JCIVDKTD5AvBDD9hlwZvpYAH5C2+Abjakd1?=
 =?us-ascii?Q?uraFfPyxrTWxQen6YZkKGsUw1vGOVuo1agk/dSXkwZfUgQFh7LsMGK0/WnSv?=
 =?us-ascii?Q?9XCyyLuVQvo4TyYHVjCnTL39jNtU7tWYp7wThMzkPLKw4auzGZdSicYNI0Wn?=
 =?us-ascii?Q?DAqPq8C4U9qCqKZyFKxSB7xFJrNSVrTrYkOX5p2Pul88KR4SbyW8wAs79pc6?=
 =?us-ascii?Q?G/h2b0kDsiXlAbiIoqx69Nq4vdcq9rNrUcPj2MMwIWuBDAvU+2CYMGWPwqhC?=
 =?us-ascii?Q?xuwSI21VggKkAU8KCRRe8+iDb5dOzTJdX86CIjcELS8HTjmblhts30NBgP6P?=
 =?us-ascii?Q?m69fgFLC4ox0NbHNNQugy86QM+iCAK7ttbsDdo3y53FLz7y22cfOgVPhH31+?=
 =?us-ascii?Q?EuBDrlQAUuapluZHUwxxdegCAZj4zQ5FelG5o2gILMd0wLu4F5lRr6axVA6m?=
 =?us-ascii?Q?hqGDXq8KRfQOP39L2UBBcer+ZQx49ZReHYQUliJr95vsV4GcWjMSTgg+diDp?=
 =?us-ascii?Q?hEk3TeK2kRjJAsnm2H/ui/OM6GNshOD8yJiaWAB3lVZcfNUnfbgFhMwEus0F?=
 =?us-ascii?Q?6A6OKHCCX4eRLIw76/jCJxHFWpXuxe/Ndwplve/Rlc2KFaq0QFe2hpUUGwOX?=
 =?us-ascii?Q?PY0s8gMdjvvBRhStwLGPVdh1s0me4ngDbgTNDaKAlo1jN28Me3UqAAvFRWSB?=
 =?us-ascii?Q?14MlcjehPOBt5SSgdBIsmTl1PJa3vYfjEEcwvu4Az8c49uwUDhgWQsRrqfPj?=
 =?us-ascii?Q?hOBS6cLcLi+GDc8SsZ019vVgcJds2m0dKoG639YJWhwOpxckMg0rm3qbeJx9?=
 =?us-ascii?Q?QB/1bnHaIpWSWtX6dD2oZ012qvwQIkfHkS15FKJIoQfBeBvXwaNV601xd2UB?=
 =?us-ascii?Q?y+xpp3O+Y2nKI4XrTSYxAgEw3OmVuhVotzLoTzVO5L5YJJlLKoaH1MghQjdt?=
 =?us-ascii?Q?1tzdwL5m7b9441EiUZqUu8VwB6CFGkaYngYWHAb5Hr3tM8Q0Ka+8Z+HvnazW?=
 =?us-ascii?Q?S8yBlnCeb3QVzaHX3RCXdYsb6N2nDbS/JycedhTqdTjk2cXoOqonsbQbH8FZ?=
 =?us-ascii?Q?YaQrcnfuf4JKxn4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 19:17:38.4464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8c1dc0-e9f6-4a9f-dddf-08dd3fd06dd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511
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

It is possible for some waves in a workgroup to finish their save
sequence before the group leader has had time to capture the workgroup
barrier state.  When this happens, having those waves exit do impact the
barrier state.  As a consequence, the state captured by the group leader
is invalid, and is eventually incorrectly restored.

This patch proposes to have all waves in a workgroup wait for each other
at the end of their save sequence (just before calling s_endpgm_saved).

Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h         | 3 ++-
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 984f0e7050788..651660958e5b1 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -4121,7 +4121,8 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x0000ffff, 0x8bfe7e7e,
 	0x8bea6a6a, 0xb97af804,
 	0xbe804ec2, 0xbf94fffe,
-	0xbe804a6c, 0xbfb10000,
+	0xbe804a6c, 0xbe804ec2,
+	0xbf94fffe, 0xbfb10000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0x00000000,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index 1740e98c6719d..7b9d36e5fa437 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -1049,6 +1049,10 @@ L_SKIP_BARRIER_RESTORE:
 	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
 
 L_END_PGM:
+	// Make sure that no wave of the workgroup can exit the trap handler
+	// before the workgroup barrier state is saved.
+	s_barrier_signal	-2
+	s_barrier_wait	-2
 	s_endpgm_saved
 end
 

base-commit: 5bb7cf8ad45fe218929c0fd78ae8adef1616a5fa
-- 
2.43.0

