Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FDACAC598
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 09:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F9C610E742;
	Tue, 16 Sep 2025 09:05:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="omoGdzXN";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36CF810E742
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 09:05:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOcb/MtZE6f4zLVQpbXQtqZmIP7ekcWXnjl80y91rWztBVhIUK74XmU+bGdXZMDhibXHXjxj/Axc+hKLK4uPT4QvVnNav/RIm23mqA/BnN2ZIAjDdbiJJ0dAwX98eArnjClwaJzA/YVNxyEkRwS/ujDEgt5J4klT+4LPFb7VR23OpPqMrwSG8+krcG/f2Q8pgSeYHi9YFSmxN5S5BgCh+vdEs+jEgK0ZRDsLpu6hmP5WLhT6CL8IzcAEQ7LazG3MO6lJ2GTrXgR3EfqQ+91gnWPC0VAt4Yy6xy2bKZD/UlxH9VVe6lIyrjvwnoqQBLxoyhbrP6YIEEGUKSLdaEW/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgkXwGAerq8B4tJOFbEQyfwFjyC5/I9OvR6SxzYtqyg=;
 b=IvLPWAijZDrpPRn1ofcokjsYJM4vKn3Qjrx4bM714oSUnuuNGtcdBfryXob8CuVjIKleN7zBgR+X/z02OTtsdEvQrKkOmU4GxINSVgI32mB69C7mVrBk6+vp52Li4CCMTrvLjelujSHzTmjxFXA2ebgc9E2j/jBiZcNGAs3pD00ksN+eUdINQNXpuM39K85MuKpUctovehKexoEVYT0KiPp4cH8DCZ8E25owGTAugCaD6enaOtXJ5DjdyebNrpAWxSz/aIbKhWlHb5LM+4XttnnYuxem6mAgdmYVmtM5RQTuEvDGqRJTIB1Ymuq4Sx7zQLqu0e8LI5I8ug0FSMTwtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgkXwGAerq8B4tJOFbEQyfwFjyC5/I9OvR6SxzYtqyg=;
 b=omoGdzXNPRRxay8fShNWk+09YZKX5ZjEVT+lTz1yhhiLKh2npnFsJLBfh6XzL+4B+iDzXY0HbqS3Noo2b1f5eomMx0K0nKYK6v+9lRv9Hc5LIHG1/+wpM9H9MOAljfn1YNI/sLdsKJNCFmR7exkFqiIalpy8+qwbmQKKIwBPvtM=
Received: from CY5PR15CA0020.namprd15.prod.outlook.com (2603:10b6:930:14::27)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 09:05:52 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:14:cafe::fe) by CY5PR15CA0020.outlook.office365.com
 (2603:10b6:930:14::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 09:05:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 09:05:52 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 02:05:45 -0700
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v3 3/6] drm/amd/pm: Allow system metrics table in 1vf mode
Date: Tue, 16 Sep 2025 17:05:24 +0800
Message-ID: <20250916090527.2727930-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250916090527.2727930-1-asad.kamal@amd.com>
References: <20250916090527.2727930-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: 543bb8f1-aeb2-423f-d871-08ddf5003cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sVKboBna6wfnF4q5u84lBOUI1wTOaxzbnIT8dkMRxc0r/oNHIkPQqKNGAt6C?=
 =?us-ascii?Q?S28p6u+6h766NZRT833Ro/vPPUz9I5VzXQloaXQD3lapsI8FV92Zg12QXdgz?=
 =?us-ascii?Q?p3EzErEx83hEbc7JmoOvv/T+aq0Szip5/rRxSCAL4JpG/xR98gN5OePGCFmJ?=
 =?us-ascii?Q?LGmOrBZBdOE3FPVXpFVUtLPohq0a10AlFVhRk4xYsZB6mXDVNGNTHojBV44P?=
 =?us-ascii?Q?mNT4Jd/xSOP8CwSTcA7Ko1J0CjIdJIJOVBgDzI64ouWKcIbPG39jsKSxJ9+4?=
 =?us-ascii?Q?OPApRFq5K9604VG59dT0OWS8yRUFc1WkuCVVXX9U19pydlWRKCu2n3URvBQK?=
 =?us-ascii?Q?H+pfCskz4Iw0tw6VBRuILeBZd+gtZ30bFYQdwj5ZIPeeOpmr2blNO4UD0d6v?=
 =?us-ascii?Q?Sb2dHRsoV3PUefR7JVup746m1InY6puoHKvg4BHOXyvk7Yl8f2EINiHzKeWX?=
 =?us-ascii?Q?jpD9et/2oBkJLscs8gWksm0GyfFrbVBDIgL/NkoxU3xtb3tNKCRC1k9cRx2T?=
 =?us-ascii?Q?4ZKTRajHD9uoi1vcIf0yR+GP5WINu2bzdLC7ybjLq+KYTB1vbUarCJ0/Ghf7?=
 =?us-ascii?Q?52z2HJ0PU131600uWsjx+pRPf/gtx0LTjNjpYoA+XVyi+pGIWPFfyrogwtHs?=
 =?us-ascii?Q?EGI/SAx9qUH5rL4dJ/+GwfHrIy65Vjn3wJPhzxa7g78Z3JJgfJeffCqy+pHB?=
 =?us-ascii?Q?wqNCMjA/QFtaqXS040yiuL1TBTHXIi4UjA7eEfBUcU1g3Xtjtb5oR2HdlA1E?=
 =?us-ascii?Q?3/3BDFqsts3rXXXw6w1wCmK7PZB6Ibwex5mmy+eC4qCJnEaMrm88g+qWInaz?=
 =?us-ascii?Q?FzwjQ+k8kWEUB+v1H5TSrFcpoKP071QeyEC9T9RTRLHPrdjhyUfL3qfxBLKj?=
 =?us-ascii?Q?8J6ykDUOyLiXpNmQqg1amI4e01ftKLhQ9oUTIuTCX0WueRB4yp3h2a0CiC2C?=
 =?us-ascii?Q?8VngSNV1Z8Vqau5/rBPgRt5bXO8uBpGra2uEf0G9SKGC8qoQmynZtgGOhkGT?=
 =?us-ascii?Q?v/tMJ95Nt9MJ4v11MAvJ6oiIsmKyrCPuBPtVWA2zZjRlnXNRvCZUxUBD6GAR?=
 =?us-ascii?Q?SW3nA3hIy9E/OvK9g9xIN6IzNaRMcjFn1wrvnQVAfmUrT55yB4xY9s4u4wud?=
 =?us-ascii?Q?lvmuPshv4suGYE2P5XZ+qUA/+Agc8XJ01rXXcw/bwenbM/FBvoydfEkNnIg1?=
 =?us-ascii?Q?Lssh49xdLy2htUaJg2kAjpzy4u7o2kLPVnRr8w4yu9AHqPLLjx6806ho6nN3?=
 =?us-ascii?Q?oBMUqUcoxBObqe6klZMUVuk3NmA3VaswaUgNiRyL1flUbqb2PPjwDRiJ/qeX?=
 =?us-ascii?Q?TUWMnL+p85rmhMmdUOwnfKcOl1YmagjbT7z6GiOj5n5gK8vdr4TC6Q+IbXHz?=
 =?us-ascii?Q?YP/ro+qgdzvObGbBpUS02xmzP6AqJqJlz31yS+2EpDiYeeWyrrfklCOCne2D?=
 =?us-ascii?Q?uQF1WJDI6QeIUtb7qECEKzfYdZeOxmhCgcJLd4cy+Txk87wTqRkpRBpyRpQG?=
 =?us-ascii?Q?CWRw812S+6i5tvDzPiOEP86ldD9D7jejLCMy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:05:52.2702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 543bb8f1-aeb2-423f-d871-08ddf5003cb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098
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

Allow fetching system metrics table in 1VF mode

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 0bec12b348ce..f10228de416c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -137,7 +137,7 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlingPolicy,             0),
 	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
 	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           1),
-	MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemMetricsTable,           0),
+	MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemMetricsTable,           1),
 };
 
 int smu_v13_0_12_tables_init(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index bcd6525ca5e9..85c0777d6e3e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -356,6 +356,8 @@ static void smu_v13_0_12_init_caps(struct smu_context *smu)
 	if (fw_ver >= 0x04560700) {
 		if (!amdgpu_sriov_vf(smu->adev))
 			smu_v13_0_6_cap_set(smu, SMU_CAP(TEMP_METRICS));
+		else if (fw_ver >= 0x04560900)
+			smu_v13_0_6_cap_set(smu, SMU_CAP(TEMP_METRICS));
 	} else {
 		smu_v13_0_12_tables_fini(smu);
 	}
-- 
2.46.0

