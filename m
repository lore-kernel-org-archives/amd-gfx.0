Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A47C369D7
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 18:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4F1710E33C;
	Fri, 25 Apr 2025 18:39:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c7RuHAaG";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C37110E33C
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 18:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCCm8wToPNY/vaxVK4BNqSMHs1XDrgn4gp9linBmxjgJ78+RRBio5nK/gTyHh4AQvNRI79p1y7o1JBzO7PATw746CTGVWeBGL51mKGvf6oJxZnuMGtYya5h5ci1rPQCGHbEvbtyKnb/7fSqv7Iq8LmTa/Cr/NZF4KTjwWIdcKepCHX/sFAv3YAzXOQ5RZM9ptTTan1j12bLIdHuMoz8pg/EuRGAIOHR090+FBmpZkNEyNwBgiKRj6Z8IxFgKrxgFDVQD7r2Fb31hcheiNQlriUAW8YO+sHumIHCgX55xx8OvbHRc5WOAPwKEju0k3/D5biljncGfpa7oyr7gVYWANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTT6IaKzWSVIpVgPFaTCvhAvAC8uYbq3MRm5N9SQDng=;
 b=Lz24ChT0eKo4lUWv3V/ZVrMhr0NrwxMb5b5jD7cku4BDzYBaLLXzlPlbBaSg9Sml1aRS1oEe44//6TZRTVpGqqAPHoh9KX/oK64teXKG6VkolRN7Kd397UXHROqhG2GI/JTbCvy4p2PfN/qbTAFKKl2Zr1WHU3Lx2EuzzZjpZQMzF+2mHeReauv8rcJBWkmPhH/ikPby+h90mFJvlgNCmLC2ytDqq+K7wkMrh6asIcBCaBGHciT58IyAARoJol38ioAGCIyFkIga1k5h9I2piVQws21UgAmF0LwXWUZkgLG4q4FGJFcaBvhkEAPkltsxXGG+91kPmP+VS9OdqpOaKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTT6IaKzWSVIpVgPFaTCvhAvAC8uYbq3MRm5N9SQDng=;
 b=c7RuHAaGmb/sRDrNr+Hn1ZqpySQc87ywTUvvJwFzNzRPKSOoWRkJFcrY+jUPPtuFEZJ8o2WawNUzDcVK2H6Q07XXfDf4KdHIXVtE2mRJjDAh01eQkho1/dlGIMCPr5xkCs3SMh1JNymgsa1GvqvXcl4OVtA8H6lCrAlzM8c0sqo=
Received: from DS7PR03CA0330.namprd03.prod.outlook.com (2603:10b6:8:2b::22) by
 DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.27; Fri, 25 Apr 2025 18:39:10 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::7c) by DS7PR03CA0330.outlook.office365.com
 (2603:10b6:8:2b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Fri,
 25 Apr 2025 18:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 18:39:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 13:39:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/9] drm/amdgpu: add mes userq reset callback
Date: Fri, 25 Apr 2025 14:38:51 -0400
Message-ID: <20250425183855.165199-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425183855.165199-1-alexander.deucher@amd.com>
References: <20250425183855.165199-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9d4d2e-69d7-4166-0bcc-08dd84287834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RV1+IRMbilTgw2AtWKSkuqO8KSOoxOT3olIZ1ip7ajhpcbwseiTMWzFwVeoS?=
 =?us-ascii?Q?3TL/sSByzSb+MWIzCOdTHi/uEjbjwz4wn/llXUAQF7zMwT2YaijFb93iTXgG?=
 =?us-ascii?Q?T36RyM19oKcDPQm457ItzfunzPG/Mll68XgAYgNRsPxRdFxYDOVxroE2pa6V?=
 =?us-ascii?Q?qEnUHX86PpI7kQjs3MhcmCpNHZXjxxISDX/EE1sLG9A7aAJLPvWb5EPWdzDe?=
 =?us-ascii?Q?xPmYic7ulnmzNfXkNDYDsGwKMhmQFglUwg971rFwFFdAyBzfRkhHFJSkZkZR?=
 =?us-ascii?Q?29CY5jXC+gskubWxC7N7ul1uuL8KRH/K1GGSmaoMKriuLXgrhr306yVwC3Jq?=
 =?us-ascii?Q?GTmNY6dOVbzwB0C8WY38PzjPuSdzlAarzIxm4h0nJDhxULUIiZfezNlLQe45?=
 =?us-ascii?Q?l5ZtIbmJLOUr3WpRyVKJO2QhdrSQBWWvbbEAFTL4dwD+9EM5d0As9sIjw9ho?=
 =?us-ascii?Q?IL4AKYcBAEFriTDzppORkR9khGPgXzCUdJ88HKLcINcdcXqvAUL6HzEQVd9R?=
 =?us-ascii?Q?mXUUI7rziRx2TQ5TMO7dZPP4960p9l6DIAgoZcFpRjVLoMOSDo4cNmiRzVC1?=
 =?us-ascii?Q?6VItNCBIvw8CpGzrvqEA8z/LHVu9Zm2MSnZKvzhAaCHNlEcK3vYF/2IJI9q5?=
 =?us-ascii?Q?Cuck1xVPDMcqCDhuNSlXYdUiu9wdQfJNcdEWk3Lwq/Krsob60MVy3w+AkSfB?=
 =?us-ascii?Q?djFR7WPXnUtapb7KvI0fUDgDrNbpaPPy7yTeb/9GKbyRSkYnpEjUBTYvZXc9?=
 =?us-ascii?Q?ht1ff2YLwPziO5L/AYtCNi8glNS/Vg8TL3aDBrxxwuSJMSe1P4pH37Tt0m8V?=
 =?us-ascii?Q?w3wOohyDsTzi56hKViTqTbr2EOb65TEtW2PScNfM9ePsJQAqN+VKPNKmJzP0?=
 =?us-ascii?Q?nJgjzlWdDIleHfXuBlhqIINIh/okdxhUeewavmdtAbuiXhH2xdSTV3VUQ4wv?=
 =?us-ascii?Q?TqVsFWe5DzC6vZzz0K0m+K5iYh2ql9Toh8wsS6EJ9GIwmqfXbax1RK/CBhHn?=
 =?us-ascii?Q?sfOxYX2O4ebYklroXyQylmUM4jgzj3YOqogM2sT0quwqdEfb2hqMP7zPdjiz?=
 =?us-ascii?Q?k4JmD8hk7zpde4mUG0FENqKMHlIOY/rSXFWPibSPOn6JKoMRt6i7TRpFC1aq?=
 =?us-ascii?Q?I7Jd0EJJQcFLL+DzLzWscXXp/+rhQyB9z+LYmLZQOOnrbGBTC/pISC+xpTNL?=
 =?us-ascii?Q?TXasBQjBUV53rRF+oJsTTbs0666d+L2JDP+qhgtxCMLEBny60E91ISdAPCqr?=
 =?us-ascii?Q?PJ4SaPyRgaPpeSpLGtO2LtIjvoYWq7j2yZqvDCMFQklrCms2LpbiYwqXZ7JD?=
 =?us-ascii?Q?Io/FZXJf4sDwo3dFzzp/Zcp7PX2GrS2Lm0n8g0wF9hWpNfylfqm3242l7TlN?=
 =?us-ascii?Q?48KPFX/YKC818bUj7PHvD5N0QDPuR4sSfLJ5glSqAq3zi3THoJ6wsqq0Rrju?=
 =?us-ascii?Q?MCQrClxEymAK+Pdq2Tn1CMzzMv7Eu3PV+xj+kXf2Ie7iZ+V/aptsmx//cvUE?=
 =?us-ascii?Q?ZK8BqmfiJYukzZAFyC67Oe6szP/BHSsUZMJm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:39:10.5307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9d4d2e-69d7-4166-0bcc-08dd84287834
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765
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

Used to reset a hung queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d6f50b13e2ba0..650fdb68db127 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -347,9 +347,30 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
 
+static int mes_userq_reset(struct amdgpu_userq_mgr *uq_mgr,
+			   struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_reset_queue_input queue_input;
+	int r;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_reset_queue_input));
+
+	queue_input.doorbell_offset = queue->doorbell_index;
+	queue_input.queue_type = queue->queue_type;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "Failed to reset queue, err (%d)\n", r);
+	return r;
+}
+
 const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_create = mes_userq_mqd_create,
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
+	.reset = mes_userq_reset,
 };
-- 
2.49.0

