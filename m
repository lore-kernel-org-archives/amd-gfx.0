Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163C2C021BC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCF8B10E373;
	Tue, 25 Feb 2025 06:46:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GHtd1DVi";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ACFD10E373
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLOneQoV9PZVSVcd7X9Sfj6FlQeqJuysmY6cOXsz5YrN7SKmmLE9qv5jaoShHDGffH1EEtrbM+41Xh2OgXQAhLi8lqT8P3/KVWCiAQIOcJCNJEc7nDVeYY8OXn3C/1bOxkLbe+/pCFAMz2Sm7/zIprqQT3Z+N8CGD6a5Z2mOherpRYcViSneVbW6+oICbEDy+nILDK9sncMpCdeU1OQSjqgJur0a6z/jqFWTp5YvM6yfni0Ond1nlqQHZqg1QMXx3gz7hZ55vGCzYZVl1IZgywU2nkvZwOWOIHGp6JiWUNRkd5VMInF1eyfCu/VF7coeYy9z/9qnEO1xityzVLy+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trVymXefW/JRaQckx+DXLiE7Z7o7xfNkRC5+7lKK5To=;
 b=e/yimDUyrDE07KXLWPDzuR6TMIdoiy6w1zY12KqIMsTlRRRtM5KgkdX9GuFwLs5TKGWb2iZSyNRGdrq53zenlaqppIBml1yakxXGiTVS5kkAwhpIW9K3Ik4WcJCnFUynG1w/0tUodK9wPtC9rSNs8Rq7Oh1T1laztxHrOa4htDHFmWccx7Ovay15ltpmAvxBQHzms65Ex5809vwZy66gEDOMf+sglUm/tXmWfWbmQzsXVx7DD4l5/ITcz4u2ZzUqS8djQlmgDcIIC26CPPOXXSEE4ntsU3ldKCVIYdF1Wnj1qThV8NnjBzIOY6/eniwfzT9VUORzTEOE2Y38FypeHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trVymXefW/JRaQckx+DXLiE7Z7o7xfNkRC5+7lKK5To=;
 b=GHtd1DViZAnmWRA8uYqO7tBVWKrwPU/WkSUJ+SU4Y9FakIRrbD0JRYIgpkfOr4L7PSJgnZ2/GIfXO/429M2QZFz7v5BCk5HHk0AvVCAoGvwxvu1c9dZiPHA9kaaxKpS0bvNCFcAHW+MYJlp5DZYe2oKopU1bhKi2KSFDZ0Par0I=
Received: from BYAPR08CA0059.namprd08.prod.outlook.com (2603:10b6:a03:117::36)
 by SA1PR12MB8644.namprd12.prod.outlook.com (2603:10b6:806:384::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 06:45:57 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::2f) by BYAPR08CA0059.outlook.office365.com
 (2603:10b6:a03:117::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Tue,
 25 Feb 2025 06:45:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:45:56 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:45:54 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Jonathan.Kim@amd.com>
Subject: [PATCH v3 2/4] drm/amdgpu: Add xgmi speed/width related info
Date: Tue, 25 Feb 2025 12:15:34 +0530
Message-ID: <20250225064536.118278-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225064536.118278-1-lijo.lazar@amd.com>
References: <20250225064536.118278-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|SA1PR12MB8644:EE_
X-MS-Office365-Filtering-Correlation-Id: ca5b7e8f-1b2d-4aba-98ff-08dd55680eb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4kz6t3tivn/w6EWyKTP/cw1zej3trfe3KfREpS2xQoBb2iWJv5YHE32oUnDP?=
 =?us-ascii?Q?02Uswf6aXhJUE3/53JcSwLghyPoyjzE34dHZKpoX5fLnNRuE9F7/ihgMWmwi?=
 =?us-ascii?Q?SxBeIwtTap713zJAeyc2HzzCkug2zsqw7GG88cNhLKyGjk2lKUA1+dtCLBLV?=
 =?us-ascii?Q?iAkohc7bMIFJabxTFm1lvDqAV6802y+ShcIGgs9jjhe6+NUPRqR6EoZ7pZF7?=
 =?us-ascii?Q?52CzbsH8PhKYyxyMu1uJL5f9Af+6tlutJatvbpdF6fk1ty21q/ihN6dhs1op?=
 =?us-ascii?Q?/yFsrH9phaOy4akhTAks0PzgbySDwaZB0F6H/Udbc3yCfNkdkqG946X8uYpB?=
 =?us-ascii?Q?h2XTwTUW19aJFXXHSEUSJGTHmjxbqQP/+dXXjqOZzPGkdIAGB3H5JjcJ/bkN?=
 =?us-ascii?Q?Z24N4+Tl9IQ5fT1dEYcnVhOieFSKvbn8InX7+6ITKgPjBs8S0ESaxfj/FK7A?=
 =?us-ascii?Q?/bN+Oiuk6G9aADGv6U+4eqiZys/UvicVpTzL++T/ZGCMo/Pkip2UNaEwJZLa?=
 =?us-ascii?Q?fLi8L64plQHNB1pjqlEyjm0BPVFSh9Z70fo+M4rwsU3RTO4v8KC4dUAIBEtD?=
 =?us-ascii?Q?93a0jPlj62OEWnAYN0FRvtwi9/1K4c2OKO5yW2Pz30Gbw62T6Vf1rRRsSHhb?=
 =?us-ascii?Q?zg8P7myztNIe4scnm60zYnKU+Od/wHcXqZNVG1etYA9xUAoxdI2REMZTbrIn?=
 =?us-ascii?Q?9i1vYgtJKVKBXP4JdJm1OYHcA/8BCUX/vZIBiHI7vPA5m/MdLSGfbDJFj2B+?=
 =?us-ascii?Q?ycBy5mgkuDtWBtKcerZCzEuieB/Vqt+7Ip09rb1XH4b+f9pCRGjNKA+asQAR?=
 =?us-ascii?Q?lW50KnMJ/joX0SeVWHNcsh5xVluo6kuOK7MU1fkZpQJmgwWOLQupYg+q0Mpe?=
 =?us-ascii?Q?C8wZvEXEA5tsA2EITnjghAee55ajxniqdYx4WYDast3xtboT/7KgNxcsfsH2?=
 =?us-ascii?Q?Ga2C9dTEeqU4jn4de1cdK9vDGfLn6A/y5dfXQeGWkjFtw79iPpayT2Gdl1Yn?=
 =?us-ascii?Q?93zN46bZP7USdtcdWLR5HeyY7FBE3TLbTC5rIfxqnDe+ZxLgzOCfvhbDb0O6?=
 =?us-ascii?Q?97uLvHZurRag7rQjjCdxQ/fjCwdquEpv/z2tlrh0zofUT8ILoN2dEZbh39cd?=
 =?us-ascii?Q?sMpndaeovTjYA7KgoB2PVm5+eqSz2IQxfA4vgHQhggj5ayeMAsl+d/+hXKY1?=
 =?us-ascii?Q?pVMyhuyhp2wqkb/4Vg9UijysQMoIiyr0jLeYXDEQJxLq1D7Rkd2nC04Sk+HU?=
 =?us-ascii?Q?8041JWsmPE11es9eQbe/7o3/ryD8RXaj/ZWEUFYdc/i1+DtDVDmGcnWBanCh?=
 =?us-ascii?Q?FZM8b6IG+vjAhQ1oxz69l30ZklUkYjAxDT7LK8HU2nQQCBLxc9S2lpQekKMe?=
 =?us-ascii?Q?0yTT3nDARVdwN0DbM8/x1YpqCLV9bZ3OOYL0aVnnSdalOnh0L6TNIPD+z5jx?=
 =?us-ascii?Q?uKcgk33PHG+njO3VEbDnAVh68kqO9ZTfNGtjvFb17LBnzXMuo1z9+MpPud/X?=
 =?us-ascii?Q?Vo49oBe8NK2HGqM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:45:56.6239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5b7e8f-1b2d-4aba-98ff-08dd55680eb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8644
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

Add APIs to initialize XGMI speed, width details and get to max
bandwidth supported. It is assumed that a device only supports same
generation of XGMI links with uniform width.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
v2:
	Use GC versions as XGMI version is not populated for all SOCs (Hawking)
	Rename xgmi_init_info to early_init
	Denote speeds in MT instead of GT, rename enums accordingly. Don't
associate enum with protocol version as speed is dependent on PHY.

v3:
	Keep speed enums as GT
	Rebase on top of drm/amdgpu: simplify xgmi peer info calls

 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h | 11 +++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index bd1444cdfb40..45566c320615 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1722,3 +1722,26 @@ bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
 		adev->gmc.xgmi.hive_id &&
 		adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id);
 }
+
+void amdgpu_xgmi_early_init(struct amdgpu_device *adev)
+{
+	if (!adev->gmc.xgmi.supported)
+		return;
+
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 0):
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 4, 2):
+		adev->gmc.xgmi.max_speed = XGMI_SPEED_25GT;
+		adev->gmc.xgmi.max_width = 16;
+		break;
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
+		adev->gmc.xgmi.max_speed = XGMI_SPEED_32GT;
+		adev->gmc.xgmi.max_width = 16;
+		break;
+	default:
+		break;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 1d4e822652a1..32dabba4062f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -25,6 +25,12 @@
 #include <drm/task_barrier.h>
 #include "amdgpu_ras.h"
 
+enum amdgpu_xgmi_link_speed {
+	XGMI_SPEED_16GT = 16,
+	XGMI_SPEED_25GT = 25,
+	XGMI_SPEED_32GT = 32
+};
+
 struct amdgpu_hive_info {
 	struct kobject kobj;
 	uint64_t hive_id;
@@ -91,6 +97,8 @@ struct amdgpu_xgmi {
 	struct ras_common_if *ras_if;
 	bool connected_to_cpu;
 	struct amdgpu_xgmi_ras *ras;
+	enum amdgpu_xgmi_link_speed max_speed;
+	uint8_t max_width;
 };
 
 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev);
@@ -118,4 +126,7 @@ int amdgpu_xgmi_request_nps_change(struct amdgpu_device *adev,
 int amdgpu_get_xgmi_link_status(struct amdgpu_device *adev,
 				int global_link_num);
 
+void amdgpu_xgmi_early_init(struct amdgpu_device *adev);
+uint32_t amdgpu_xgmi_get_max_bandwidth(struct amdgpu_device *adev);
+
 #endif
-- 
2.25.1

