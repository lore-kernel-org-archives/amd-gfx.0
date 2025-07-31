Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9F2C87FCA
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 06:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6095510E706;
	Thu, 31 Jul 2025 06:14:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DVHkOJFE";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD8CC10E706
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 06:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s23zTkjbWdK3mIP8Jir4lfeM+kv/XKaCV8NYh/Q8nwafLOjRHrqA6PK9lZJFaU4MPxU/x1vApF98AaMVceFaDSiVEOrJMueHLM9I/Om8HYxupDHKlrmI+9qFSA/8TWHR3BWNNq7CA4A7QvpeaeNVEI4wq2fU8I7bxy1qPcxdTN8d2Fce66Buwbv2OK2kjsuAD9CFovRtKOJ8nKczCdkvrGHoDcRjXoaSHZsIozrFf6WG6AgHocLHeRDZwJ89Vl5UCCHUub4argFDLAjwEVONcLwemeaYDtRgPL7h+Xj7Jrla+OXfyUEAzlAgx5CvXkTDv7JvheJY1ZCrM6y7wK1yPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84+1G9vLy60weYuhADbql2Z+tXNTbozynlhYvq08IlI=;
 b=nej616aEXp2RTSIwiPbv86qau6hxBYwJOh/J24wkCR/1K101IcmkWjINvsVNKgQ8vyj6djiM0AK4eycG8907080ejPsuUSLTBBs9VeWwIpI0n3ECl3Hz8lnQby7vBHx1P2J3MToJs9sorHk5Doe+rqU8a6bvPIrHhN4KrNl9VgBcPMPq46Jk3P4hpvx/cb8YDRJfisOwVs8Dir1dzPKDjdqZ7LrSuIppCfzYb1Ay/rPuD8g9UfIvbvGEIM0PxUmMFupBY/dKRM3oHTJoQM3pAtZJbw2j5w8TyJun0mxJYu3eF5iIQlrIo1xH8xbusK3gkjaGf3w6jNfvsdv0t7o63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84+1G9vLy60weYuhADbql2Z+tXNTbozynlhYvq08IlI=;
 b=DVHkOJFEyNHkhWrxmTCch6Yk5C2Y4Lv3xR3F/TYSFbVoUmAgsr9j/0Mqj4EmYRkBwf2LTLvWiIStxWxy/ACw5gytPv+tvUcPCQ4xbUhO3UMfZ0/+WOKZDQ8JdJZtPAkp/H11loHBf1QUTebq5DhN71Z5DWC0+zE2ohFrgmx0a6Q=
Received: from BN9PR03CA0489.namprd03.prod.outlook.com (2603:10b6:408:130::14)
 by IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Thu, 31 Jul
 2025 06:14:29 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:130:cafe::31) by BN9PR03CA0489.outlook.office365.com
 (2603:10b6:408:130::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Thu,
 31 Jul 2025 06:14:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.0 via Frontend Transport; Thu, 31 Jul 2025 06:14:29 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Jul
 2025 01:14:27 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Ce.Sun@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Prevent hardware access in dpc state
Date: Thu, 31 Jul 2025 11:44:07 +0530
Message-ID: <20250731061408.1699369-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250731061408.1699369-1-lijo.lazar@amd.com>
References: <20250731061408.1699369-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|IA1PR12MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e98cb7-155a-4faf-0a4d-08ddcff98217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QGWINJQpalptab1WzX5exV6vmqgkDQQ4AkuGJ+5aAWekbV6r6kJCJDjhY7m2?=
 =?us-ascii?Q?cFMkqaPbe8F/0tn08O72YjdEA33/2TepjuPsk9XMwCfv3cMX4sAoULPQBuZo?=
 =?us-ascii?Q?L+TY3wl8/i6aKI5NfWMjveNe7VX4h3VOavfHE2bvH4Nc0SyvU5M1Rr3ZFDMS?=
 =?us-ascii?Q?y7Fl5z36w+SrUIWT6n85CBTBZ877RPaNjyP/AYY6qqkte7rAmkLxSV/dyrYs?=
 =?us-ascii?Q?p9Q1/Bl6pcbGXiItpU5+0Klzxt/ZxfJgakmHFf6iyRIRl2qHLr92pStttKMe?=
 =?us-ascii?Q?BdZjO85BOKDM8bhe6yRe3PUZPPWyuuAa7umdeVVoOXPIIivlBBbVT2v4BZ3H?=
 =?us-ascii?Q?bm4OyRBbew7i1rb4mewVU3VTWNvPUxKEhASEt6GREZu0nMNp6Q6zBZVtCJqX?=
 =?us-ascii?Q?/G0AKMzpxlfbiarqZu+BYvMqHY3+2CZomzPj51ttfe8aXty9gJI7Y2CTuGKS?=
 =?us-ascii?Q?4WHcjnj/pgaUL6ykUqh8FI52yU2ScWgzouUUB4HmiZkJNymU0y2j/BNCSPQC?=
 =?us-ascii?Q?rj3QUZs/QK7vhgUha4r+SnAUefhLY5xuL/E7awQDf0iPPMbUtlCIuapGHcYY?=
 =?us-ascii?Q?0qhQUZAYC2Ph/FV81tNm1ZSRUZ4jB377NyVes7x/Dc67flYiFnB9H+qQ7rYL?=
 =?us-ascii?Q?4s4tKLikEN6NhlyDG7UePtu59TyCJj8jDSI+ebpHapGs8vgJhiqwBuHsN463?=
 =?us-ascii?Q?53VB9ArWKSkGxqA2BA8DXW4T0NgOWI+0uB0wDbSM1v70xo4vhrumJj8+nbnY?=
 =?us-ascii?Q?1uSPBNZ7REyHK7v7c5nEJfngdZw8EgoFCp4PoJ5WL1CpUrkXvP3n9dJZtNXh?=
 =?us-ascii?Q?6HhySgKjANmyaW84PwRE2sajumaiQEhWOcG3yVuy+dN07UX4mowrIfocw1Wq?=
 =?us-ascii?Q?MV9zrxsSZ0gVrltPX6wrptS8ntYrKXexjxfMt2Qyn4gXCKMVidJ04EwKE9sB?=
 =?us-ascii?Q?MPktMtpU6Y4B9zEtNTquox6LZ/oTD5HuwhUuH8Wkrak+Oa+bEV+qCJuApkKE?=
 =?us-ascii?Q?4GSZCnlSqbN8G/2CPcGazuLriqnXMgcmzjfd0VXB9AMe+12ImKsn9RUygXkh?=
 =?us-ascii?Q?HV5W4rcFyABiB+6HFectqbgFSSCta7eaw1Ehk5GabpcDz/5kIWN6aN5ZDFRQ?=
 =?us-ascii?Q?eZZb/7mZxjQgc7qSZP8UoqLTHjxKIFD3BvRGAmFv2r9uaw7xiyRvjhJyQmC6?=
 =?us-ascii?Q?ZRuoK37FeHDS577cEw+lb7kE2pMlVL/H7ogFKazeCb/5Mk9XBhCvxJ2FyNVR?=
 =?us-ascii?Q?xi+9qMj9dOPigqCxwvQ+S68qJedAzAEJGrRRrJc49xYYB7TY9DjBG44p9ddX?=
 =?us-ascii?Q?W1Ffd7CzkIkUMhehZxJPggZtOfj+vxWVwbUbH6m5kVnhtyPdRyS+kxig0Jjr?=
 =?us-ascii?Q?XiEP86PUcP1L+oT1kkjIvc1uZ/n0ce5ig7TC1cJQ62XvwxsFSJra1V5bd3Sf?=
 =?us-ascii?Q?bY2Q84AUwhO2YIC0fqttC2i8rGJaiuYh1wSnmn/Zado3fqRnIUplOzZnu6Tw?=
 =?us-ascii?Q?YQSteJQn5yOK9EKY78eElLOLpOxr5WllzLYv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 06:14:29.2375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e98cb7-155a-4faf-0a4d-08ddcff98217
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639
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

Don't allow hardware access while in dpc state.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 1 +
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 076ad472a95e..cfd72faec16e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6264,11 +6264,7 @@ static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
 
 retry:	/* Rest of adevs pre asic reset from XGMI hive. */
 	list_for_each_entry(tmp_adev, device_list, reset_list) {
-		if (amdgpu_reset_in_dpc(adev))
-			tmp_adev->no_hw_access = true;
 		r = amdgpu_device_pre_asic_reset(tmp_adev, reset_context);
-		if (amdgpu_reset_in_dpc(adev))
-			tmp_adev->no_hw_access = false;
 		/*TODO Should we stop ?*/
 		if (r) {
 			dev_err(tmp_adev->dev, "GPU pre asic reset failed with err, %d for drm dev, %s ",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 3a806953338f..2f92b3be40f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -164,6 +164,7 @@ static inline void amdgpu_reset_set_dpc_status(struct amdgpu_device *adev,
 					       bool status)
 {
 	adev->pcie_reset_ctx.occurs_dpc = status;
+	adev->no_hw_access = status;
 }
 
 static inline bool amdgpu_reset_in_dpc(struct amdgpu_device *adev)
-- 
2.49.0

