Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D199EC282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 20:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F9A10E5ED;
	Tue, 11 Mar 2025 20:45:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n/GEGAeZ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70FBD10E62D
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 20:45:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nX59IhMpw3PQSmSBcDGdmvG7f56s3OI3b4173vgCLexgH6HXgwbWvhvYINje9ymLn950vI2ktBpkR/GJWTztjvUHbbQBD1GTOsfmrlkLam1ggR7xzletKEvcv+Z7IP7XeV3B4aUzk8xP5spzzCwb1VePIPCsu8K5bpXT74LgDsJWTTSMCo7dHeDJ64bAW5ne8WhmN5vlff/h6OPzmyb3vDqRC0H887VF0noC8zFHdol3TQWA4axPmVWcHwG6Zezx2irP5uIckQ0UbnpaQSLDi+V14ZLU2kZFl7sOGEY26whY+IaFbi+aNymNPVhDrEQdXcKui2jx3FIPG0TqQ3u6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jO4KrJFJolKdNPhfALvT191ml7lQo5l4ars9p35w/0=;
 b=bXXkkM5hA5ypcMbYmERGInYLGfzbNXsNoQhiazC+oLVkk2+a7wZSydZm1ng1IE9JDmAlVjTe/ZPXuKqGaQbHP71bGeM4SXDS0JwysZvhVnde3ZA1qtemCBsMlKZmDdlhupo1a2Cw0kSjIyjYR2dPT2cec32v8U8S4MihDM3r4zVBEskpSCTRQU+dGHpjHydO3o3IxRcF4lgqpaTzIUH2yMaiJte2FVe0iTqSaprpwIThgbp8B9eS1gSWmPuwmWX+49eCxwQrLefarWezZUexOo5CFWixRnUZ4WV6tTxfrEOSc2JsNLBUrnv0365liC/EH8g/5x7RyS3xHuPOEhoKww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jO4KrJFJolKdNPhfALvT191ml7lQo5l4ars9p35w/0=;
 b=n/GEGAeZjWFd1NWd8vmhoc6/16/XEMHNRRbRTWz9cBpPh8g4oX1XPTiyqnmwfhSmEzc6CX+OJ/jt5I2OHt2BIBt1LqOBeYbnCSrJ/aTJYsEK38VxYwhSdebbI0knkenrIvKJVlvsy5sTuhDuVyq66Ceo5fR9Or9JqVtK08rAlq8=
Received: from SN6PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:805:106::39) by MN0PR12MB6103.namprd12.prod.outlook.com
 (2603:10b6:208:3c9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:45:13 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::ad) by SN6PR2101CA0029.outlook.office365.com
 (2603:10b6:805:106::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.3 via Frontend Transport; Tue,
 11 Mar 2025 20:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:45:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:45:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/6] drm/amdgpu/pm: add VCN activity for SMU 14.0.2
Date: Tue, 11 Mar 2025 16:44:56 -0400
Message-ID: <20250311204459.23864-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311204459.23864-1-alexander.deucher@amd.com>
References: <20250311204459.23864-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f4585b-2031-4b52-e45c-08dd60dd9f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ka3EmipCWbLcQNiTxJDVr0UgD5NroEitSbJZZB+L2pAs6nXkwN3cvZSA68b9?=
 =?us-ascii?Q?kiVKaCo4x/w4Wmnwm6xrScjFhBQ35/4q7DZSuUu1X8dLUnVc1DpbhKzByGXO?=
 =?us-ascii?Q?2QkLvFYrAOplmzHC9gw36jfQdGBoh7R+FI2fNQVTy6c+d88RtPdls7XNQJI+?=
 =?us-ascii?Q?DshA03/MmusbnhpWTlsUYOgm/MmbZb2ef4CQonoRIIyNrUv/g5oOmajHf9+y?=
 =?us-ascii?Q?Q2ji1OILIYosYi4TC21qyhs5qu2NdAS+Ip03rHceIAARvTGmsdB24weU10vB?=
 =?us-ascii?Q?anuErC62t7PxOObUW1WsufenfKeS0uhpkASqr4K/0jKjqZmskiy+E5EZbMzp?=
 =?us-ascii?Q?VPQXwqMIcCfRHis0W2yVVKL9yCypC1wIixIxlLC6LbwaDgycxiqHzFhE89ag?=
 =?us-ascii?Q?o/sKkOXuLltS/pYbOR6pnzxVLpdsK/gN6A5HnOpI11r7X/KTSpTLxXafqGf0?=
 =?us-ascii?Q?Y9JQz834JSXh/W+7eFAhoz0WUQE6HiRRmXRZiv+G1yBq8ZlZUd+/rKNizddv?=
 =?us-ascii?Q?flQNjFzZaUQ0QAfkF0fSHnOrRcOONa+VgIvI2Ppv2bgNBWkPEwjMJjMYx8h/?=
 =?us-ascii?Q?Fh8FGLoy3yuvpWWjZflEV9zxfwEpC2pMIEIm6CNSQtEehFl7aRKQXdpFs8fO?=
 =?us-ascii?Q?rHxqVpYG0gSki916i/fx9y/ks45nUxG/4sUWj9+DBLubqymMpN9ZPuCJHWXE?=
 =?us-ascii?Q?KqeP9mnL4ICXTuzjs7SzYXmq2siZudXFcj+FzY/Uji1va+gF5iYfwVraOAkU?=
 =?us-ascii?Q?WxYku8E33OvpiUGFS5CgEVJbmYE5942VewWkX4kTf23EImtxerkGlvW42/zH?=
 =?us-ascii?Q?Q38i42ZqXuhRAkVaf6PneuHdMbIEse915ZXcNEMzT7k5fdXuDmnM2V/D58Qu?=
 =?us-ascii?Q?gbv9uQwZ8/gZzHnW9g9wNyQvGHd9nkPuNx0i2NBwtf9MvMeY0ISO9QOobg5D?=
 =?us-ascii?Q?k0IG08oCNz8RcXG8zwh5aSFQ4vjLhNmS4hlFZnjE2w+CZvX5z/XXlYFM0dFP?=
 =?us-ascii?Q?GCDXZ0TAcNVAcmg5VR77Zhxdry5ABatrcNx4+W0Ot2CGkKDpN68XDs4ofC0l?=
 =?us-ascii?Q?B1T3G0urmMNJE3lpyAtjQt7EW69cTbBN9mJg9rcsGfksZzU6ocpppZiCXCCt?=
 =?us-ascii?Q?HgwezGr0oFfZXHbuLg5J1fkKn4BVhAR195Qu/OUuTdQ3JNnlOKPeoNEv1rom?=
 =?us-ascii?Q?kENmXYDhRhxgaJ3xMyv6C0+qgkO0iksaDCmYOWlus4RT8bc2CTOjMf9JZf+l?=
 =?us-ascii?Q?3g7QudI5fwDy+PgdgWaKqk6aPa8TOkn+rNBmt8//x6v88o41pBoIAN4TLKOM?=
 =?us-ascii?Q?thzwW0OTYWmEp/RGRxj2Mv+Bt4neR5yERO3DrjpS1/5BmMc+/+nHUfPCmoW5?=
 =?us-ascii?Q?NurxYPbn2KMjGu5yzAn2ic1hn0RJSJWDEMNMqwQ2yTYjgkx7USFpSN6Dhh35?=
 =?us-ascii?Q?LNjdpFeFbZPM0rs/mMhHgidpqwXitr90pZLcjsy7T6pOxk1MXucPSO2FVKV6?=
 =?us-ascii?Q?dt9yknhbpuvqql0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:45:13.4948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f4585b-2031-4b52-e45c-08dd60dd9f76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
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
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index e4089fd58711c..21d1b34ada053 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -756,6 +756,10 @@ static int smu_v14_0_2_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_AVERAGE_MEMACTIVITY:
 		*value = metrics->AverageUclkActivity;
 		break;
+	case METRICS_AVERAGE_VCNACTIVITY:
+		*value = max(metrics->AverageVcn0ActivityPercentage,
+			     metrics->Vcn1ActivityPercentage);
+		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
 		*value = metrics->AverageSocketPower << 8;
 		break;
@@ -882,6 +886,12 @@ static int smu_v14_0_2_read_sensor(struct smu_context *smu,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_VCN_LOAD:
+		ret = smu_v14_0_2_get_smu_metrics_data(smu,
+						       METRICS_AVERAGE_VCNACTIVITY,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 		ret = smu_v14_0_2_get_smu_metrics_data(smu,
 						       METRICS_AVERAGE_SOCKETPOWER,
-- 
2.48.1

