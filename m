Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B395CD6E49
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 03:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B19B110E055;
	Fri, 29 May 2026 03:50:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uQD/rc0S";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEF1F10E055
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 03:50:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxwwe5iST8NozMUzgb19EeTcxWcMW9knmZUWYa5rjt1w6rGCz8ubecAllw4aAOtRNEf+8v7cd5Lr9kP4ziOJDYmr+3llMro0pWZFML4YMfWfaG6D680xozibDQa58/djJiIgTDG+2QQI2gAfa8tUvAbVSaEzvgfKLCuZmQJoo47nmtnBIb4YleYOpkWxSylVpBDOIU9OYCPnyoUCmaUD/bqkatLe6y1lt7Y/iMjl/KvtK5YALS3mjdBty9e8OW1BNAu0PGlU6mIwQMhE9t5/NoFz4BFFedk5TIRifGoxridH4kkumSB5J/T9j0GlVnh3LKRpt/7rcpDcTsCzyz4X5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSkun+W8QcwlB4AUyUXDniqxJi9/TGG72t0i7n7E8SM=;
 b=exmHB3BhiCNWZOv5Zy2ME0e/SHb+yRWW+EyCo9Ug+0LVsgCEQLHh0x094btBucXcO1f4cIqehCdpmD5jVNjRsk3bwCTkNVO8bRFOeAtcPDDys5oCQcm6dKv7CLL+YSomgGGRd6mvfS+Q2yodbRfx4uauCDPAc9fSutJgjEP/plJTzRygAwSL5qjvYZyKqgMxGwiCtST0WVv7qaPc+yBSIJcD+PQ8Myw1HYE1Btto6UA3OJDzs7CIeH+aGot6w2cXH81yeRnoRd3Z67b0yVIg+T8eYwT8+yyKDLrSzikSuv+wh2q2aDYy+duR5Zr0fCCBYif45jWytfNqnvxegBkrnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSkun+W8QcwlB4AUyUXDniqxJi9/TGG72t0i7n7E8SM=;
 b=uQD/rc0SJzbnQ+ZVBYFwAnBD8u6lIZlqavImtDVN0Wa51nuCkoa0HhHxwGDsLA+6EXPSUjOuGgT4rACRHEiKKLiZcDNhndYizq8pae5vFgWQzJezh2gW5DZarsMHvSaEWsOLeURDGXtJyqm6kBGwGw4U5+MzAtfCIFDxoyIFF3A=
Received: from SJ0PR03CA0096.namprd03.prod.outlook.com (2603:10b6:a03:333::11)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 03:50:27 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:333:cafe::24) by SJ0PR03CA0096.outlook.office365.com
 (2603:10b6:a03:333::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 03:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Fri, 29 May 2026 03:50:26 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 22:50:23 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: set energy_accumulator to UINT_MAX for smu 14.0.2
Date: Fri, 29 May 2026 11:50:13 +0800
Message-ID: <20260529035013.1389055-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: d205ed10-b712-49c0-c4e1-08debd356ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: nE1oMzP8vNpwV2FCys63qIl862Xd85D4Rb0m40mDFaOql41enNIyXflDVoHFX81FRN8LSJLTUFRsMmK4qUqNKpYtuepRuXxbRmirAWLmO9q3A64u2ExcREeoJrTUYffsRTSq8XQ2DJa9hLajYUlq98MGHkUamU1J/ddKPbXVYNX15eN6uvo9cADyE1kbzQxYUOf7p8h9Q2zR1cY5X+/UiJCDRA05wIo8/axrWzYRLf9puspzR4YMpsG/fK2ff4GujnoviRM3vtNYuhZWDA/PLBBgbclv7kaNYCf4k3yWmueRA5j9jx0dlcsREMHH318zfeG61DYhxc+toDDbPd4KeHK9a81GeGLHeccORUN6yKAJO3QK5UlmoJd6N+Lw+wKsbt5+btwUFoz/m0+Uyg7R5IFnnCUEEpN500ZlbFOsepnj2h1ea7otsxIjKllUOhl7DnImrJRmYYlEoX7geloN7QiUwW6uxoInxiLY/qT1iR+uT5XWfKZnhM0diQpOvEN5bVxmCDzA4eFY3lD8Kh5MnV3OmK6eDQ/tf+B1qYxF/ZznVKm/FzhOOdgqQZ34IK2koB/d7i2Q++bP3xS4I/Ewgy6rbOZrJGHluCKVKHy+Fw+7R18gkT6dyfiW1opMMUxmvP+CQHDSca+iAUWO/NtyfrZfZG1nT6esd1OwFDgGcPqsM00YljBJbyuvnRkbrSe0LKlHdbKoN2OPpw0k6RYr+P2qbdn3DDIhnkvFvKQdjFQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l9Qlx+KxxYEE3bKJuvkmgpSmQsxNVJN6Ef3y57UBlED3ziRwBQLv+Q5Ybro8hpF0/Yz9DN4cc9Bta+EPAlJWumtAMCA+f04yZ2TZGv32b5m+s2TxN98ttLKEZbDQn+97kpVsLLKyLiYsydrCoMGz6+HmXE/CrEx8lWJLSL7JEA/7y1xj6mZMXhvh1ullRXkV1FMEeLz23QMFLa3W6LsR4Ty3MMVh3U76li5YMS6p9nU3RYI2PhCcgH5Wr3a6V1ovTyP7nFdacYFJbxHos1qaHijvAaAOv3hakjb4mD4/UGsGtlScR1DDdpLWPaCQ0w6eMYgg/IGcgHBMBGklBEfQH28wUoaJO1Es50wAUag3D06vhRuR0q1maao6t8+uUvRxVDCiFQxJYUyA2d6VwtwilhVgTa7hn96XTlD3Cr4pDZlIrBOOHaFMGTwdPKfLI6PH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:50:26.8815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d205ed10-b712-49c0-c4e1-08debd356ba4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753
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

EnergyAccumulator is unsupported on SMU 14.0.2, mark it invalid.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 6b5aa4e514fd..f98b8e045db2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2153,7 +2153,7 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
 					       metrics->Vcn1ActivityPercentage);
 
 	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
-	gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
+	gpu_metrics->energy_accumulator = UINT_MAX;
 
 	if (metrics->AverageGfxActivity <= SMU_14_0_2_BUSY_THRESHOLD)
 		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPostDs;
-- 
2.47.3

