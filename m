Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168E3C2BBCA
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jun 2024 09:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EEA810E3A5;
	Fri, 28 Jun 2024 09:04:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kF5AbVbN";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 257CF10E3A5
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jun 2024 09:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6E3nBc+gPVZYquuWMIzuTNLhY+uI2H2RZbwhuewdJgXsR6XCE1eZzWxK28rxF5J0HsstK34AoVBHFp2pBs8KVRtFI0xArbn64QpGkW6qh8H2c+qzzqxTaeof5q3bSzRuNNLopOWnqlpoMGT2LKOprRowTuLNrwQasF1gk33jXAK8aIlGw+hheNcswSkAGaPts94rKYsNru9coCmbRo0xfqMGS2Rbl1Lb2EcwONN/PtrDdh9QdUyN0CW1lVVAYad+YD4XqKT97EXa/pSXd+P1ZLwr0fPvH1/SZ4sU99/B6OhWjmeULRlMkBxUn+jb2V0y05NTjiB+YzX20ENgaywdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zRsekGUPDvDquZLFIGo/wUe65HoZ8Pyizx+HyYF75s=;
 b=LoH+HE2rqTtxu7mG2AvUbf3DgD/bsVWtlUBmHAZ188zr2mhhpSKpAr8v1m0oU+YYYBfyuRyrb6FyN4r1Etjgqfw7R5zjQwwnyvQe3pJ/8+xBlC1OJnQskeNXBqI0QbATfoJ1eR03ZM3I9dY75oJhfaZODAr6RMK2H0/0wvDxkj/D7P/sZ/fyNPkapuY3JNtWffD4OClI1QLla57lh1tesItx28OQ9E/8wOY0gzdbS4EaCrDgOZDs1CvbxWFdgcrxhAqfPAC7mHGmLz8cRk9JPV1n6rFYX9B6+aujYM9VUUkD8vOE3TQGndde7V5FKtNmaWH/G6FXgnCPVbIFxMQ2ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zRsekGUPDvDquZLFIGo/wUe65HoZ8Pyizx+HyYF75s=;
 b=kF5AbVbNuswCMn3ZnHFR3UdA/gPCjbast3ijAUjtKot/mH/xZpeFLGVukuoUeNh9fn5gn2Va/Sl+M6UtdQMsl9XqVDyIaOvVY8qSble440r84GVTFSZdKUo1+hWxzYOliIjKWqBHd9l9KVLcDpsdIDiUYKNqIS2nP1OWIHAHd/c=
Received: from MW4PR04CA0260.namprd04.prod.outlook.com (2603:10b6:303:88::25)
 by MW4PR12MB7119.namprd12.prod.outlook.com (2603:10b6:303:220::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 09:04:30 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::81) by MW4PR04CA0260.outlook.office365.com
 (2603:10b6:303:88::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Fri, 28 Jun 2024 09:04:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 28 Jun 2024 09:04:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Jun
 2024 04:04:28 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 04:04:27
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <Tao.Zhou1@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix hbm stack id in boot error report
Date: Fri, 28 Jun 2024 17:04:25 +0800
Message-ID: <20240628090425.9536-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Hawking.Zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|MW4PR12MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c95e236-809e-4644-628d-08dc975151ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZOlqKp3kokc7u+Elw3AQ9IEnR21/Hef4+kWjYr1xAOxSY+CDww/c/EvnAnqh?=
 =?us-ascii?Q?cC+e5GTKCx33gsEx5OI+RFCDpWmb5kObyoloJZUMU/Hfv1msinsMdFw1Cddj?=
 =?us-ascii?Q?BYWyY2m6gpypLsahb/Ne31d17AQVrh7n+sHk1O7jczwB5UT1X80m8d+LyLHR?=
 =?us-ascii?Q?MkBQyNQ0c4dwE76asb49Hlv/VCjhgI82F2xBmb0dL1RIDQEoJXUnQr9TNo6K?=
 =?us-ascii?Q?pYwfinWlDBeVoItuKwYU5JjL88fGSkyQi6mOKJcZ6QFl2KUqoZuk83BYvUlg?=
 =?us-ascii?Q?zuNTGDa3D63YvUkd2UHp2t2Ar2zqLjH/BgTrw2hX6Tg/Incv1ZmYHC47REfJ?=
 =?us-ascii?Q?T2ooEjyu+bfUhRKuCgtiOYfoUPwGipfRT6X6RQ/F4APYuGt9BCxofX6src8I?=
 =?us-ascii?Q?t/Y7TM+eWf3zC7n+ghhrCnT9zb9/k2uI8pLMU1F2SxGUzKECau9cH3xGxHfd?=
 =?us-ascii?Q?tqidwPckoCd8CuRgEsRyNKzHodco8s16hDqaemiyrZoMuSBpf0fZMAnesB9/?=
 =?us-ascii?Q?dxeY/8SS9HS4W0OwBjM2sZbL70cQnVWMz1X/dIR9rQzRr5/jKrsR7yztequk?=
 =?us-ascii?Q?GJkv8Y6Fo2GK+8igEBd2QOihZsliob9ZGmKwVdGqEBBHFi/e4EgzXnZSNzo5?=
 =?us-ascii?Q?1Wb/1mBMG+F9RBK4aNDGQnZ0opC/k7NOyaikzSw7doOjs1tLkVyaf7U6r0VZ?=
 =?us-ascii?Q?2QQqB9lCPP7CFsOxPwCpn/kOe924OVcpmNm4YUfUgpOshq9SbQG6JP1LdEjX?=
 =?us-ascii?Q?XFIsfP50tMQh+b6mUiAYZ3lL9BAwywp6L8aWIyfuuBE8XlZCVoo8+Dk+2gUi?=
 =?us-ascii?Q?68PjttGxqUO7jv7PTpRfK+igFMXK1ZJHQGgCP65LsPh96zfvd4JGSZbm/X/2?=
 =?us-ascii?Q?GBOUgZ5REo8Mj/791j/u2+D87Y/FUA/N8+X7lOMW3bg9NEpY17XXFkob5wqf?=
 =?us-ascii?Q?GR9BXPYF3+LRWtUEogluDukkKSCxPuHjjXAXGajxogonTnfbRP/TnAqor5VC?=
 =?us-ascii?Q?kwT29eVQFmBF3SK6Tj25OZHmZNSuijz6DQqndBjsOD0vHawL5jUEXJ+nyCDH?=
 =?us-ascii?Q?wZjLGwblwulKbbqLfsVdcBpihSzUWDxnflf4Z62UkNqczZoBK6WzHbCozgFl?=
 =?us-ascii?Q?41OT03FEUC4GtDD1sFZ2OPl/t8CPFYHZh5sQTirxbkhcfewsQKgWHe2+tHxk?=
 =?us-ascii?Q?y9DFVXBJwq5HDN85G6jADaBzhUKeskFKBzPTMhqfHs31Lis2QyHHtwt/h1pc?=
 =?us-ascii?Q?rnq9k0DOr8gGUxkr/MXqPbFVxMIqlIGhbcrZ/TFwTUhn1FYrEvG1Z2UXeERI?=
 =?us-ascii?Q?TrSjne2je+MwOcHeWrkvVJbV07A4VjaRAvpN3LwStsECy+iln9vKWJSo+UyA?=
 =?us-ascii?Q?Ht06J/0CWgj/gXQQfOH7vUZY7P69XW7Nv6JJ0I1yc9kxtzF02uVV5Ggj2Bm+?=
 =?us-ascii?Q?ARJRFsukJERdcnYlmwcr1xaC+RVvpVmt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 09:04:29.5886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c95e236-809e-4644-628d-08dc975151ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7119
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

To align with firmware, hbm id field 0x1 refers to
hbm stack 0, 0x2 refers to hbm statck 1.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4edd8e333d36..6d1f974e2987 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4565,7 +4565,7 @@ static void amdgpu_ras_boot_time_error_reporting(struct amdgpu_device *adev,
 
 	socket_id = AMDGPU_RAS_GPU_ERR_SOCKET_ID(boot_error);
 	aid_id = AMDGPU_RAS_GPU_ERR_AID_ID(boot_error);
-	hbm_id = AMDGPU_RAS_GPU_ERR_HBM_ID(boot_error);
+	hbm_id = ((1 == AMDGPU_RAS_GPU_ERR_HBM_ID(boot_error)) ? 0 : 1);
 
 	if (AMDGPU_RAS_GPU_ERR_MEM_TRAINING(boot_error))
 		dev_info(adev->dev,
-- 
2.17.1

