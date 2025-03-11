Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF40C28B2F
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 20:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4A8910E690;
	Tue, 11 Mar 2025 20:45:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yq1DdWrS";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CFD810E5ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 20:45:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvFIJ0x2jKQVl25GmITabF2RyvokmBxZaMhn8LianPRqxyipgYPaF7FMZjg6tE8DYYsKJ/QBqshF22pPSLo9jczzZMm0uhI/vnks+SX1WuUoRj41WmGpTSci/rQLvRprhh8mDVv2oj9VSpWs67gzCykQ2ApLdqOt/d5Rymb99jm8T/MSlrMsBnirHhP8eZl3qkqnXE/AbYAEF1dK/LwmeB8a+nN15K3ROLp+4OevkVCwIHcNh8uVapfim5R47SQf2ZJbTEi1qr4nRLioYbbW6ASL+EKvJEUFSrvB/DMJF/XNk4tlMHWcfYhtHL0yua8mABE/QnmZfSGOikZ6WepWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eg13TTFc7inL7Vx8JTPAqtIGwBa730QI5Xt/3wuRTXQ=;
 b=GVEoT5+nEMT/dsJfBfNIHmcbA61WU5rlBVuqGZvtnKjjSn6Z+7whonT3StiSMIsf9SHgWKK4s3duZeCFaK/WY0xyRE9YgGHt5uO6Z5M9SJValc2FnEfqH80lVOv4zrgtpVZMowLujPa4BZqkXcyA+P8rFtDDeGz61xwqG0BDDmA8Oa87+f6r4FsmNSIJkaF63sXuXDZo2O+nqSD9/ckU7nA86hLEk+hmUJh1m/8CA/Osn0OOVNGmV/Jt9EuxYuwf5mq+y8eIRWVPVu5namEyZOjxUXEwebyAyXeq5CNzKrjzBd3CeEqdA7FdsLNg7bzo/+vPkJTkwY3dMAX8maewoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg13TTFc7inL7Vx8JTPAqtIGwBa730QI5Xt/3wuRTXQ=;
 b=Yq1DdWrS2Hk40RO2lZ5PVReK1kkIkxyzcdwAUeFOp5J7qjRswvuHQJC3rk59hSJip6xZ/EVtP6fXKSRuXZJMYrCmyj5kj2wc+mJrNMQbZNRdG38FQND//3McK5Bom4VsNpwrVWoEB1SVgtRNt43UexjXvjzk8bHu1qSjG4HB2Us=
Received: from BN9PR03CA0168.namprd03.prod.outlook.com (2603:10b6:408:f4::23)
 by DS5PPFDF2DDE6CD.namprd12.prod.outlook.com (2603:10b6:f:fc00::665)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:45:15 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:f4:cafe::fb) by BN9PR03CA0168.outlook.office365.com
 (2603:10b6:408:f4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Tue,
 11 Mar 2025 20:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Tue, 11 Mar 2025 20:45:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:45:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/6] drm/amdgpu/pm: add VCN activity for renoir
Date: Tue, 11 Mar 2025 16:44:54 -0400
Message-ID: <20250311204459.23864-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|DS5PPFDF2DDE6CD:EE_
X-MS-Office365-Filtering-Correlation-Id: 671761ad-52bc-412a-e7ca-08dd60dd9f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gG1sUFHB0ku5MzlR9VMFQ1RYA0rIa3twViMG7aclmGmqlOw5m6Z+x3FtKtB0?=
 =?us-ascii?Q?NzyxRf8tDnoYdPfXE2FYsUuNpwgBVngSUlPNHnw3CLz7r6MtD4/Qiu24IDyV?=
 =?us-ascii?Q?DAMBXZ6V1Ycsj40KMDu7/q335FkUC5UBzWwhsh0JDJ5S3MUBLEp9P1lb/aCr?=
 =?us-ascii?Q?A/5UVsRJC4Z15ryf/px2jEZMUW43MQMOC+5qme7RUpDTPxctq9t35iZPmm27?=
 =?us-ascii?Q?xAbhUwkJL5NiAuU+Cgq92SJNZT1ElqNBw7FyJ/aAcXHzFjNMKDKr+pXvA5pr?=
 =?us-ascii?Q?ghd6X/UpWdCemxXGMR937fFryMqB3PstWWriSTspNcu/sYAV+adNlgkcINe6?=
 =?us-ascii?Q?4gHlkyDJYM3d7+NnQu2zNyu4fCV90O9d1wAI20I8uq1oCUJQYJ+Q83d+O3bS?=
 =?us-ascii?Q?nNFAMIxRSQBprna1LbalRYSGAu7uBgzM7+qdQ73Y/IPtbzpc9el/moUoJ1F0?=
 =?us-ascii?Q?NPYbWvSigxAkFv/AA/AmDpvBYWBUpuDBi7EKOhniA1ajAsH628KGkno+f4hC?=
 =?us-ascii?Q?KVVeK8xrUsE+AWZ9BHnwH4Kbyt8lueDiTnij9QYeUy2jC+fJCDxCu3wpl51C?=
 =?us-ascii?Q?eWfF9ZqK0XAxAmOdSRdpOzk/gJGx+6NlUTeokxTqn6YiaJ14xkQWlr36dpp+?=
 =?us-ascii?Q?SZ7hsAkDjB7xBMe5JEQu44lmA/d9SU3hWOp3pWRXZp4gRA6RZjSRZUqVe43m?=
 =?us-ascii?Q?TeozgAiCm2MAlEFkpS+1mgGNDnhhN78qbOCNjukHA66PBlpyJKunnotVzydk?=
 =?us-ascii?Q?WZ7wg0lPnFD+fET+Hhtb+T+1xHv0y2Z3CMn9J9fzgXv6DkNxfGkHGmjjhGcf?=
 =?us-ascii?Q?QDoEwRIYG0dRjUddUKjYXc4RU3HcgPLNFZ7uxIKWO+soRG21Cm7sY7j+gMkk?=
 =?us-ascii?Q?21qRK8BQ7qHclYSPmzTdVqodTw4k9L4/CXjSjfxq0W2H3xJ5Nzjof4KUrVwQ?=
 =?us-ascii?Q?FdLfRPWD3nG4kQ3ogsFYn6ZJ/FIeOl8IB8YJBGSY9zlb3gLC9tm/Xf35rEI3?=
 =?us-ascii?Q?/Ycgq29BJGpdipW0scAxXtygudQ63zqy6LEqj2WINZ0tYyxujbK1RpaObRjO?=
 =?us-ascii?Q?dy7mGlws1vKuCpgcvgzN+DswVsPNMx4pAL/ngynDSAXnchbKBgNk7Eu8Lgfw?=
 =?us-ascii?Q?4j3sQEQJ0uMagJHoFAbKUhIvb7Z95ewHAn4P3NQ6A42SKQE/y2fnCP38uLSO?=
 =?us-ascii?Q?mpBgOuI60/JVryC4HonrBsbdrHuIaJ3pcNhPVDJxdvsJ94smF5I9E0S6zh7Q?=
 =?us-ascii?Q?ePHTfELi60JvOiU1xewf2NN3LRo03lfXOnuFraes5l3Onn+5jm3MSd7U35Ia?=
 =?us-ascii?Q?J9AsQ9Q2Hlx981TuSQorAz5+BaKs8mrjRYSYEMEJHN6JF0qRqykt6c2vThpI?=
 =?us-ascii?Q?xPt8aY65esmkYOF62G+cgeETQEjDnSphq6WMfbYevd3xmhHjmUp7WkKf7Jwv?=
 =?us-ascii?Q?ECpN+z3mbvVy/vOlfTvRfYYVVIDXJfXUdk+uRDZKsh/hdWoX9Zoju40Pytsg?=
 =?us-ascii?Q?3ZiqTcr9BccelUI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:45:13.6679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 671761ad-52bc-412a-e7ca-08dd60dd9f8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDF2DDE6CD
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

Wire up the query.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 37d82a71a2d7c..9481f897432d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1285,6 +1285,12 @@ static int renoir_read_sensor(struct smu_context *smu,
 						  (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_VCN_LOAD:
+		ret = renoir_get_smu_metrics_data(smu,
+						  METRICS_AVERAGE_VCNACTIVITY,
+						  (uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_EDGE_TEMP:
 		ret = renoir_get_smu_metrics_data(smu,
 						  METRICS_TEMPERATURE_EDGE,
-- 
2.48.1

