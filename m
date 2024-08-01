Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2243EC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 05:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A465210E891;
	Thu,  1 Aug 2024 05:54:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z3D3B21h";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EFC210E891
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 05:54:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVo3sI+i/2ylkX2B1lrHOSJPLGFgyoGBL3DQCnUKJCKYQPGBi8W0PxJZ7qaV9kVub4z37VSVEEguHET4fAfocmj9JrKYMb4xzQbiTKO4xWvUj2PlLC9LWdawDsZh0arAKGPS/2RMYt/V/5UNvvCeB1l4UJ74FHbcwC29F/QiqFwwAsE9yLoeQqjbCIaCri5wnRkDW1812EED0MYm9zUnMzJwzfNRn8DAYhzy8zY40R3eDR0PC11YMKxDazpxD6Sa6ZaAOs35YrrbQdcsL3bxS27X/8sl+VB0QBdJ/57BrJhYUQMouW0xPBvrvdOLFENvE+RaktAbqvDeuHCGhhMoYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lotw4Aet/oYt+BNXKYQ9Ag88B6FXSprsHpsEQcIIis=;
 b=C/OtowwDgCIo20842MU7F33H1LiGnGAtLIm+M7jkb9zs8aDPHp9ONNSHo8p+ztNVvqzWGTOE8Cn3e/rH78Q1qy7q0fKRIP9fPaIF+GRUefSYUGRXNM2Vm+/P9krzGINXG7VN/QMsUCXvVbZ5DjF1p0ZqlKl0KFG8PvY8sO2dkA6AZIJfP5u18YWYs+5E4u+deCmUgQZt7dACXGdj75LMKiTm6P1IMc4AngZmspfXCpYs4Aj+t8wvPEgOmZATxB/I1Oq1+egHn+joOJiu3I9YsmbKdIa9/QAooEY/KuODKoso9+j27s5Yshx90eWDSuhCNJTbRfbdsTY8rwK6Gw1A1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lotw4Aet/oYt+BNXKYQ9Ag88B6FXSprsHpsEQcIIis=;
 b=Z3D3B21h19FjapYX1v5+hSwFxoqaR5rqJ+/c9ByU4iLLIB5BSeNHo00KnZqcVNutUKO3fgPQPS/tp7uR2tS6obQL0ptVDArMf1DhE44b2cCmUnKxBU+uAlTrTCKjVNYnicXVkeIKBhMxu25Wn75o5aPlQ9jMl5OYH4owduSum9E=
Received: from SN7PR18CA0005.namprd18.prod.outlook.com (2603:10b6:806:f3::24)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 05:54:41 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::5a) by SN7PR18CA0005.outlook.office365.com
 (2603:10b6:806:f3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Thu, 1 Aug 2024 05:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 05:54:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 00:54:39 -0500
Received: from hawzhang-dGPU-Simulation.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 1 Aug 2024 00:54:38 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <Tao.Zhou1@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Add more types for boot time error reporting
Date: Thu, 1 Aug 2024 13:54:36 +0800
Message-ID: <20240801055436.31616-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Hawking.Zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|LV3PR12MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: b531faeb-cea9-45da-f34e-08dcb1ee6f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H7T4bO7wVd9LKyOyPRs9UpuBmVkYbiT2uO6kySl5AcDq8A8FpKqT0TmLgMid?=
 =?us-ascii?Q?MQ6nxZ8q/3OzO5b+xeXBoWyGoK8KoSuoWjH8zwooC7Uz9vkQFHuY6B4louVo?=
 =?us-ascii?Q?TN2EV+Ky4qH76VnLBaLCBayPBMYAosWFIfMo/ELB6CGRsGOnA8//Lqy0Qr2u?=
 =?us-ascii?Q?S1Ju2/e+xYICz/ElSSeNrvN7GH9A3TFW16u8SoC28QkFsV8rhS7ZCyx2O/z6?=
 =?us-ascii?Q?G2CvPJmHte84P8o1sqqjFilNpZG0bcrUPPL4rvlgw+3qX5k2uoJSzZoEXgGb?=
 =?us-ascii?Q?wafiEOI2sb44NCE3KLWddiPnDC/0zUy4uFfIPTTXcs4+5BmMOTcIjTNS1w0y?=
 =?us-ascii?Q?GI+tZf2l3Tj4fdrxeXHM8YaHrBHCjr/PRDOv+5aKUnxHRUBQAEmFn9gBCXuQ?=
 =?us-ascii?Q?xIsn/VIKLf4+RcuxPTxK7AngEg3J7ytPCWAt2v6H2/YuR1Ez0/306t8da50o?=
 =?us-ascii?Q?L5Ji4+aCRUoweN67PLyi9Fs6/E/dMcdVvDpPZKKrzzDY4mxMGARrNEyTh4NY?=
 =?us-ascii?Q?Cvqsf03peqcCYJpGHvrtMMEeeyqLSK05/V5Fz5aFylsucu+KTYwytp6fQ5Bp?=
 =?us-ascii?Q?aPm0t0NXix52Imqrbrg1mU90r3s2RTDJVRT0R2ORdElfyJ/f9MlwtTUhAVK0?=
 =?us-ascii?Q?2N1ly9OcRqTaHeVzHgnthzaD/jT50bgq0QC0rbkXkSJxERYpWboRcFdjZiy0?=
 =?us-ascii?Q?QGZWEa5OqFcUzRt0Gz5Otj5nGp6jWUKzJ0tLFU3SgZIc+o/voWx7AV7ujcwB?=
 =?us-ascii?Q?eiZacbX0O4T8Nppl1ax+ULb4dhT5UvrzriBwLSNSi+qeCtQQMpUUupi8cz2T?=
 =?us-ascii?Q?H5FXBZ5C7uVVgg7KCHRGhzatq09G/tHe5h/fc0oThPbf7pZuPPRkiLUqkuOH?=
 =?us-ascii?Q?uK9AAct4Swr5g6McqHz0HR3p9ZAGu0RBmR5TdW8kwQJ2VXd8zws30tn5uS7D?=
 =?us-ascii?Q?G3NLLRLpEuWehGNkTXGq0mTrWFWIs0WZH6KEu9IhrTU7jbPD0Elg1y8K8KSf?=
 =?us-ascii?Q?EZxgIO+/WGSHJauwJIT0DzxQ01LHb2OCgKEr8g0e4QgE1KyOiooZtjamTMgA?=
 =?us-ascii?Q?Js0Ifh/iwTDzdDtcsWwYt6gHpnEh1d5l8FRh1uBC55p/L8iI1hAtK6P1z9c0?=
 =?us-ascii?Q?q2SHWsbEmcZIJ3TGbf3E23W0a/aYK2Do94le4Dmmk7lzhYQN02FNxd4slnud?=
 =?us-ascii?Q?ZFIS6ttCK2P0+cqGvBcFs2VDHic7YwfzCAwk8NEKPiDGFH3+JzUZ9OmEmG7l?=
 =?us-ascii?Q?U+nbqLTMw4u1gt78BNJ3lSbaqLp4ig+aJllJ3pLqQs9T3t+pUf4q4Ntc5yw3?=
 =?us-ascii?Q?E/vbOc9bZyplGSuBmrvpcbg0VDXGAnsfsIAawXQLwfXrNttGEXhZ2wCUyarX?=
 =?us-ascii?Q?JEmvMGsmI/NcoBIhT7XjgGZgoj90Tj0Ve9AQv4pUbmEt27HwAGTs50MQs/++?=
 =?us-ascii?Q?1soJrn5eEJI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 05:54:40.4642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b531faeb-cea9-45da-f34e-08dcb1ee6f30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117
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

Data abort exception and unknown errors are supported.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 12ab48f26bd5..7aff6150898b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4769,6 +4769,16 @@ static void amdgpu_ras_boot_time_error_reporting(struct amdgpu_device *adev,
 		dev_info(adev->dev,
 			 "socket: %d, aid: %d, hbm: %d, fw_status: 0x%x, hbm bist test failed\n",
 			 socket_id, aid_id, hbm_id, fw_status);
+
+	if (AMDGPU_RAS_GPU_ERR_DATA_ABORT(boot_error))
+		dev_info(adev->dev,
+			 "socket: %d, aid: %d, fw_status: 0x%x, data abort exception\n",
+			 socket_id, aid_id, fw_status);
+
+	if (AMDGPU_RAS_GPU_ERR_UNKNOWN(boot_error))
+		dev_info(adev->dev,
+			 "socket: %d, aid: %d, fw_status: 0x%x, unknown boot time errors\n",
+			 socket_id, aid_id, fw_status);
 }
 
 static bool amdgpu_ras_boot_error_detected(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 7ddd13d5c06b..0d49b74bfe5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -46,6 +46,8 @@ struct amdgpu_iv_entry;
 #define AMDGPU_RAS_GPU_ERR_SOCKET_ID(x)			AMDGPU_GET_REG_FIELD(x, 10, 8)
 #define AMDGPU_RAS_GPU_ERR_AID_ID(x)			AMDGPU_GET_REG_FIELD(x, 12, 11)
 #define AMDGPU_RAS_GPU_ERR_HBM_ID(x)			AMDGPU_GET_REG_FIELD(x, 14, 13)
+#define AMDGPU_RAS_GPU_ERR_DATA_ABORT(x)		AMDGPU_GET_REG_FIELD(x, 29, 29)
+#define AMDGPU_RAS_GPU_ERR_UNKNOWN(x)			AMDGPU_GET_REG_FIELD(x, 30, 30)
 
 #define AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT	100
 #define AMDGPU_RAS_BOOT_STEADY_STATUS		0xBA
-- 
2.17.1

