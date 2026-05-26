Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E005CCD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E79410E4E2;
	Tue, 26 May 2026 14:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QO1uikcD";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFFED10E4E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:40:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYmu1fK5LIBCPM1ED+pvK/pBYbdLLtt1LeoEbXCEJljhkNE/h39A/UjXtZ7EpKBeUxkBd6SlZ0YRd7vP6P5gC+YK7nTvoE0DhkDZrsgOPb0LjEQJQQ8jb9GwaPmuI5efI3/dCK9BXhNrURcsMMPyqw/PpWY/i8v9QNrq/Cc/VKbbXQBA6H1fn9pfpvA4lXDu9SQrQdndJJgnRiqkV7jeB6Uf4paap65YFadDzqxgF+ZnDcel/hfVxnC4bWU2pLgg6sHTsGwdlm2hOQ/yEjozjbwIBoi1tFvZ1D1Mmboka31o5USRVqvwmjsQk/j10Iz4f8otvOpkywUVTPPDKJdb/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFX4GbH9oariKOwin09ECJENLaQzfxjSi3/MIYfMhwM=;
 b=jf668syhKiSswIzdXKFORyALgoPwioWvTZwJUdzNiaX4QT8VAMFQOJ0vBphphwjaCRftXgv2cPYX1d8FGFHPTgk3A/3mh/InHTjrsEBJRp0LGH1OIkGUHVTpS3ttLXvlSLxWUQ8hSszn36QvBGjsqRQCboHb52zUHoxY5ojV+bPMJtJ234lArO5q1P3yTsRv+8roc3aWQWti4/woe1Zul7ccOEbb1tRtMnDtxZqyxvk0lM9R6G4mKiKctKtqYd0Qv2/YrjjEgqBO5yihULlv9qCMuGdxdxV1ZzCB8s+UFLc96fMdsfIY7hJrsa2iHiknWfhqy2B54fVL1wO3NoJv4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFX4GbH9oariKOwin09ECJENLaQzfxjSi3/MIYfMhwM=;
 b=QO1uikcDZSgfZAzQ6yupv84nFpWpRtMlNgQAcxBOqf3ODmY6QANsMTOa/xJuMhFYL8Kva6HZzKsNfgDrbMMDBBPcVcA/UyFofFcDAOzx4zG3YESAkGKVQk3F1f2OUtKvoT3QqPHIP4LGnqYaBBOdfTwE8rdvSRiiuq+WgsXs814=
Received: from MN2PR22CA0019.namprd22.prod.outlook.com (2603:10b6:208:238::24)
 by SA1PR12MB8965.namprd12.prod.outlook.com (2603:10b6:806:38d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 14:40:09 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::9) by MN2PR22CA0019.outlook.office365.com
 (2603:10b6:208:238::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 14:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 14:40:08 +0000
Received: from caden-arch.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 09:40:00 -0500
From: Caden Chien <chih-wei.chien@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: <Solomon.Chiu@amd.com>, <Peyton.Lee@amd.com>, <HaoPing.Liu@amd.com>,
 <Yu.Wang4@amd.com>, Caden Chien <chih-wei.chien@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/nbio: remove doorbell entry5 for vcn on v7.11.5
Date: Tue, 26 May 2026 22:32:17 +0800
Message-ID: <20260526143219.609033-2-chih-wei.chien@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526143219.609033-1-chih-wei.chien@amd.com>
References: <20260526143219.609033-1-chih-wei.chien@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|SA1PR12MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: 2481b193-623c-4d6a-5ae0-08debb34af7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YRn57KvWt1dobd6kNxNDSlumgAfA2p944/diT7WZr8D/K0KOLMZcbWOSLzzhWSyfbG9stPvnbiVOojnv+9ttfSmUniLjD09LkrRqAGsNYaLlSr4UQFOoLth/5reQSfHH652VeEvcoo04FclkxdpeoyKiTqeW/HfI8ISffnDsEQRwDil0JXMuSZGy67/YbGnszQ+iRvNfPmQU+MnrEQfxqaY6dfEg2Hu/EWzvgrx8WVrxgcySgQB05FF62+Zr5IrlH/VnmR+By0n6+I1qPne3VyWW7aU0pI0Ybipf8mMMLZwuAW55OeqqZF6HywHU66MS8Gp9ck60n7Ss/WSLk6KD+MHXyT7KCRbg2OK98BcLC+w/K7ZJeRcQ3NtW8Een96CwSa9V5LFOWdQlLbXYaC0JdgtWx4PbtFNloLQXIsFFNlp7onovrG2N3M3Jrj9pwc9iGK8NCEbYvD1P6/pWoxl0yMrtblfkXb5tkpbhUDRcy2J1U3+CsRlnZKOJuH/dDwMXpZQXNlATFgzL3w37qdUKKc2F+7M+vMm0SySZupV5zY/Iob/FcY4WssaO3/em0hmKXatKY3518Y9mxOpq6xxv3giZsn6oC1Lxx23JQvyQz2ARtQbejMaEqwHKlCzzNlJmgT539xSmlq++3mIZIjynJf2kT8LjTOBEEsy9S8V+9E1gJ7QC3DKJOiHIneGBlrn0UL6cwzqNTkHzZiAZmKLBVLUYCcksY0avZLXB2uSlFUw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9OORSMVVLrBSc4KlUEmnaQ9xXW9iga5pVM6GcHaQ530EFFliab9NU9EkWRbzdc2lMWQsDYaN1mQuJXyeCUMeRk0Al6C8aISwdI9BTd76zoXHdhiPvenn12SwDhdChwWDSvo9sifQpmUA3kwrttV/gCjSyhRyuOnJzml3JplWKbytN6SnR5p3whR1k9IC1t64k3QJxASvrrPph6F34WHTFZSmA54krVdXr/rjIZDp4NRORLFPYDgrUSQpNK8LfR5q1+dMqtDjLBH1vKbpCItqQxRb4Bu+etqFIeYtWUq7GZ37S7J1VgDEZyDxO3wASHO61v0mup+lZ9zdtKjqM2yP7362tktK0PAir4fAK3TakbMyvumnuIJH37BL4zD7M8KHufUL14rQ8GRIyfDuLZchIdfqRN5SZcyN7MCGA+kHBx7Lbajc/hqM96BYhJBfRraw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:40:08.9701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2481b193-623c-4d6a-5ae0-08debb34af7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8965
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

S2A doorbell entry 5 on nbio v7.11.5 is used by vpe v2.2

Signed-off-by: Caden Chien <chih-wei.chien@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
index 28a99b52f59f..872ebb4b3820 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -145,7 +145,8 @@ static void nbif_v6_3_1_vcn_doorbell_range(struct amdgpu_device *adev,
 	u32 doorbell_range;
 
 	if (instance) {
-		if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
+		if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4) ||
+			amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
 			return;
 		doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL);
 	} else {
@@ -179,7 +180,8 @@ static void nbif_v6_3_1_vcn_doorbell_range(struct amdgpu_device *adev,
 					       S2A_DOORBELL_PORT4_RANGE_SIZE,
 					       0);
 
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4)) {
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4) ||
+		amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5)) {
 		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10, doorbell_range);
 	} else {
 		if (instance)
-- 
2.53.0

