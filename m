Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0852C7115D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A1A10E4A5;
	Tue, 17 Jun 2025 03:09:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="myPhH4CS";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8203810E47F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4U1urv6we4URGdspc0fODZXOYd08MiFJJEx/dT+qJthEBafJGL2NQ/Repb0FJOG6vwIPc2jeK0P6ySORQxGYNVSzPa76HYXN1y0HxS2blYi/3GJAjocFuBDBsFQgKV2WqEIR4DMTmxk/eguAjVYFcAPKxv/HU+DkicKZoB2MMycYzL6Aa3achLxitVWHt4VSKgb9FFTWQqYArR4IoF03SCSsZXAE4JT+dsPAQR/21aaJ1xowi2GNHtoKb/rS4zQeFnnmE8cM1sdcMB2flDnA9WDXVLkw7NWF6hHCBukc6YUlyN8ZihibCvTExndatYlQRbKWMqRhZmHlRAJCAkNwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8n7nexDMUWH+iQIUNK3IojsIWHNFW1dv+XKsSrGJIcQ=;
 b=w99+dBgXw7lNc2fyWAeJoqQTPq3tCWXtdiiEWIvq9TC2oIQiYZwirbo9wXA817FpSpod34bjo4HlE4jAgTZXqO2AOpyKpajDtwIp4DgQ7PgVrwlbCz3uCiD0cpsgVAyPvcM2jguBCHYKuqPHPN3uQYyW1nwajPJMy7+sGJtKDAyqEOPwk9OIf5aweFaBeiNAa0d7AkxEON5LAYvIgPUKnmGmQW/t+vObOAmgyUgPXakyMUvYvmGFGDNK7GT34ZSR99oAQpm90qIkNqYgX0q0vvXUaDH1EJ420xRXUEmrkgyr/sMtjy8T0jeSi93CflZowiwdZ4AnIkkyHBkpMGe7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8n7nexDMUWH+iQIUNK3IojsIWHNFW1dv+XKsSrGJIcQ=;
 b=myPhH4CSQSxWBWYQJl4mBl1eAT0APxY3QiSsJM2C4JV4r9Dc467yvAd+0x1hwxTDJgdq4/zzOkLBp/Qqt6MhHg6Ru7jMor/TmRL9RITOhXhDQTPhdRIfNOsasqvHQo9pCTRbN20s4S9GWjHFgipzViTcsewF3L3knFwyyHnEDNk=
Received: from MW4PR03CA0024.namprd03.prod.outlook.com (2603:10b6:303:8f::29)
 by BN5PR12MB9464.namprd12.prod.outlook.com (2603:10b6:408:2ab::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 03:08:47 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::df) by MW4PR03CA0024.outlook.office365.com
 (2603:10b6:303:8f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.34 via Frontend Transport; Tue,
 17 Jun 2025 03:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 24/36] drm/amdgpu/jpeg4: re-emit unprocessed state on ring
 reset
Date: Mon, 16 Jun 2025 23:08:03 -0400
Message-ID: <20250617030815.5785-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|BN5PR12MB9464:EE_
X-MS-Office365-Filtering-Correlation-Id: 844f0e2e-8983-4db4-52e1-08ddad4c46be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FnS2B3+cwP49xiU/2OiDlfsr5HihVAfTbQY62okJVOqfveaa7TjnBU1vNHrd?=
 =?us-ascii?Q?hloC35CGRDhmH8hNevwep5PrDx48YQoLLTmFwFyEAba+M2+ESUUqhSCdfNSv?=
 =?us-ascii?Q?kddr0X8EHuHjgncWysfCTvpxSaHs2tSvA2lqrvLOcWd/yBNYHDWNaR8Oef3u?=
 =?us-ascii?Q?JHYGsotbxCY3sdLsa+4M9M/J54xcEV2TUqX5/dUsFRJ2Tkg8BK4EBcmunlHF?=
 =?us-ascii?Q?l7TzNdkUjp+GGikmwErMWwX+q+wybSkJAw7cv2MwiF9V5zH78usu0DXcIFke?=
 =?us-ascii?Q?LN1J8kiobrZw6DXSkrauqJucENi5G/jYFgR/lW1JPea65ukqEYYuhEwIbTwb?=
 =?us-ascii?Q?tbicMRtIWABi78vNR6PQyX8Br8KMBBh7ngrif3RVnMxBJFiy3ey2cFppEJTT?=
 =?us-ascii?Q?2npAnd3XLm0wLHNjzlyfNesHJFdmFkmX64JI3h3AUo6ffWNAUaZdCFXv2if7?=
 =?us-ascii?Q?uuY92rUMx82ExHIOJDpmUBPveid1/cjC3RU+bTVlEGiQbYfI9nKOoBIg6WNy?=
 =?us-ascii?Q?WnPGLzcwD0FZMIEnwjLymbLVQCykFn0qWW3M0FNvXG6/a8vH7aNZQtq5Nodq?=
 =?us-ascii?Q?UIB4ukvv2gvP4sFUiJOMKSDYAoeb1ayLcJbEI+1pTWA868FXoUMAypcOlv7d?=
 =?us-ascii?Q?DEvmDhyRjVTWwFkbU5vTm/0RLi/GRx8h4zDl6nxbFjxT5ZucQXw0E48eM0YR?=
 =?us-ascii?Q?Epz1UNyYSQcK1nrFIJhrVvbDPxu9Asg0v33xzwGpSJ+A7mLb4jpYK7OyafUL?=
 =?us-ascii?Q?CKlWXdaXK5y//0QJyjrO0kP2UY6pQUEgmz0zQ/B/Qa1TUrzVVuonq9Mgx8ob?=
 =?us-ascii?Q?eViSBmLb+2IgMzsvzTLosf8Mor9Te9qt+/QQyEm0qxenB0B5QT5GoqPMUSxs?=
 =?us-ascii?Q?XvKLE9OLH9GnhqOWszRl5ocHWrZYSRutL60d/My6mTT7E+E0kwKJWvPlUlod?=
 =?us-ascii?Q?4j46jAM4521eHVeqG+zxt3v3vmnvuVZGcrNKK2FB9el1qizct3rpsK2x7SAC?=
 =?us-ascii?Q?t06tSbiHESp32+ESTX59sQtXgPTckq5VmJ3vIaXsklEKed8gQCOS96MniMdi?=
 =?us-ascii?Q?YTSHqHsbxjawatInw3X9GCZcJwID+dHenLQFsGi+YK/3VNI+s6uuQHUiGz5q?=
 =?us-ascii?Q?87fEuuRHbEJcyPW8hzVr+s7myUmJqMTgBaEcS77CsL9T7ceD9SNK9CwMPh83?=
 =?us-ascii?Q?YQicyefC0rFWJgYeMadHsdMj3KBxgS3fIbJIgpdl9WCJs0YID2Qgk/B4iX+M?=
 =?us-ascii?Q?vtO/gjoR8j0SLTqb4ci+l7+Ypbj3eCA7L1Rjznbcav7v5jr0gi5kfCZqS2GF?=
 =?us-ascii?Q?f4fJUwYD9ETAMnI+6tEXNFA3RFAkOMLJ+YGSgtO3kYdg2vawIAPpCRimrPzz?=
 =?us-ascii?Q?G0ewIqsZE1wrOhgMN1S79AoKsg/ABSQWZx11aSO5/NO8A3LWz+3xNZSeY7uX?=
 =?us-ascii?Q?5ugc3iNAuLX4mmm8oCnap1M9+mSgLvPYjOCVJvmgsIMUMqtvHKK/wUI5oUfR?=
 =?us-ascii?Q?RfEj1ub2GqIgHl4oC155AV1lzJ+Zh3IwuSV1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:47.1075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 844f0e2e-8983-4db4-52e1-08ddad4c46be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9464
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index fad64d5cccd1f..6ca8a3ae4549c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -724,20 +724,13 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *guilty_fence)
 {
-	int r;
-
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, guilty_fence);
 	jpeg_v4_0_stop(ring->adev);
 	jpeg_v4_0_start(ring->adev);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, guilty_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
-- 
2.49.0

