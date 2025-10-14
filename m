Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBD3CCD190
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 19:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0241710E6AC;
	Tue, 14 Oct 2025 19:31:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="upW4Uh9D";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48FB710E6A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 19:31:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSFj4s593XrgdQEDQsQpGwIjQ+t5q+6qQ3OLdXy9O0ELAIMNJm9NBWLfM8Tziee8UUGkOpcAcQ0eUw/JLOtVFvAmDo6eBDgxslclKySKERXAciwFRm2/+okSyyqqJcC+Eh/bE7uAyIsVcFOkGpuB8BKVb0GgF45lWOR47gwb/dbp5uPV0Wq2icjut/iuWEZfkph6Ff3dbu6YTBXJ7MjLMt4LYf4drELsBLsWjCW7ncBVvDpB2PlwDTaolvRzareS1PLKVPeLG0S3Rp7xfw86q+BJey8b1e80VXhI4KBtWv9d7d+N9pwopSDANCKOJJBSUFqS23CCRqnQgR2VyjrXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bdl18CHd8BqbOUpsIUyvv6+7j8M8XrYcTNqQQFqHHA=;
 b=j456nlEsPHxTVDhaI/p+bBOZwwP9fab9MnqjJSFcPj68c5DREoAuuvjiuCbG4fHaW93Yj+XbulCrM+IcQ2rNGAy4dPCDfz+5vN6X6ZkWWnx5gvvJAETnQAmXx5kEC8DqikMRSxUkJbG6dy6pwS66/IabpOeC4xGwIPOLxykAYQso2r6zrca/0OEyWAw3E0gl1Z9zbaLDxcF2YD0X+mT0yx6fNghK3dCK1J1TzqfOZTcsAHceCLixfmvGYTS1mVreZE/yoK4EL/eWIJuqzSB4RmZ97xK3BnVS/mdqQ0lozJgpsFq0xE2PG4WDvCwl8B1nlmVWoEbIx96Ietde8thEwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bdl18CHd8BqbOUpsIUyvv6+7j8M8XrYcTNqQQFqHHA=;
 b=upW4Uh9D8d8G8Q2gIRoj8wMRrrCiWOJwyBzKZxWrfwMf/NqCXpG0rqJSNeNLc7hzR8NwN57qGiQV9gs9Ovvll5Xy0qwg3cTOHZlukbq45ttNbDQd3By/qtSi98kFfBpB/UrHXgQfsrjt+8eN2Bz8rgwnqyohFjqKnRu0Vq/orLE=
Received: from BN9PR03CA0939.namprd03.prod.outlook.com (2603:10b6:408:108::14)
 by PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 19:30:54 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::c0) by BN9PR03CA0939.outlook.office365.com
 (2603:10b6:408:108::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.14 via Frontend Transport; Tue,
 14 Oct 2025 19:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 19:30:53 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Oct 2025 12:30:51 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v2 1/2] drm/amd: Add a helper to tell whether an IP block HW
 is enabled
Date: Tue, 14 Oct 2025 14:30:35 -0500
Message-ID: <20251014193036.595453-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|PH7PR12MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: 49850f81-c2ba-4259-145a-08de0b5830b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VGVzha3wsmcvJIikGrJlT4F33pp2lzqUwhB+LGB0LyGR5TihKIf2nOC8euRy?=
 =?us-ascii?Q?a5S3WSokbUZv7BKlK0CCT7D00MuciP9Uv/hfiePU085JhcxomdEGGCb1zFNE?=
 =?us-ascii?Q?p0AzZjYc545/S0upl3s/uWHBELnn2nvHKbjyNZHPx/0KAeK0q4HovpY8+Sym?=
 =?us-ascii?Q?ed7W8ZLKYOWCDglXnaW/8/rwp/RCOKXB3mKfQWp/G+L7Cdo5khYh9NU/6b56?=
 =?us-ascii?Q?FUiPE69pVQ+Hja5gT5rCs+35g1w7V1Bp3FoyY374QcWnVDUKI+ZvGaJKAql1?=
 =?us-ascii?Q?tYXNypBf7P+CIQf8AR9iNxc3pSarY1x/eh6bSw2Tk7wnAed/qvsnRgxnWAgi?=
 =?us-ascii?Q?j9//FPiX6ifKpg2PQiMI3omnqhYWpYZqx3xdJ6lhYK7se4UkK6pljTOpwe5J?=
 =?us-ascii?Q?D+uWPiWin6ndPahGjIdiMTta2xhQkyxzRdkxZasDcQCXYZcvpRL0WzLfxA5+?=
 =?us-ascii?Q?oFQ/SJjtjJ+LJBIz8SkPdPfIFTaw8ccjzRVH8a3BtJqamLWRSj4JAPtItnm2?=
 =?us-ascii?Q?mKn17vp+Al84AegqswHWEL0QQHljCsTue7fSZkCezD+HOGUHE8zdIVCB98Ho?=
 =?us-ascii?Q?F9bdRJwWJzf52NsZOfwyH+nSGu2EL1EvJJ5ray1vWA8R4v0ltl4uOoSX5K4b?=
 =?us-ascii?Q?B1TowZy7KknrUmt2xYIH2JfDW1T4iqBt7Jz6Q3f6+nU/rKNYJtAmu1ShadJv?=
 =?us-ascii?Q?5y084NkyXat9CmZKGGtU3n29QeOM+XLd/702NinJqiMeLSbdcbQdS9lh+5s3?=
 =?us-ascii?Q?IPD2P4hI58Ip1uyO51p8eVMsrCC33f7IfKnA5DOP9hv5B5dzaxxF6WyLGkSD?=
 =?us-ascii?Q?VOuHVFWi2+ENY5WXvRdRVfBJyo8p48So39xmjH7oLkjyu80DmfGK9Y8G+o6q?=
 =?us-ascii?Q?Bg3+4BweZmMzNHv50Cun9C/4gCb/nI+4cYuMMqnMjV71CnmFFJYCsJq4DUpP?=
 =?us-ascii?Q?AMlrv1EWvJg+jW6hN9uFG0+KUWen3FvlteFHUJO7i9r+1UnjvzBC1WDHe24Z?=
 =?us-ascii?Q?Ft30SENHTLNOs0D68N6+phVPhb3IP62J3ThJv/Un3HI4YzK7vl3LkTl97R//?=
 =?us-ascii?Q?7Zaczbfl7Fk5Savn/DvkeAX2BikNif9x6fwQP1HjsEkwlziBq8v8ojmjTp+0?=
 =?us-ascii?Q?xq9Q3tflf/9qMlG3518MTWXYrsL0ZsImxpBIzA3tUJEQwSiOtkF8JKPxzvpp?=
 =?us-ascii?Q?wAHvm9vcbfacd7rhfzwff0TjitkuETySj3BxQobxqhjrt/s3WlznDYiUT7CI?=
 =?us-ascii?Q?FJKVgrEA7aOgW15cJl2qh/GYB3vlHnMeyHTRGsmpwHjzM5Uqm+vpkaTLlS5I?=
 =?us-ascii?Q?6t34b7Bdq9jEJyra6JPg99/3rs9VU6BPy30nnksbWD1yU70a0wKlXXjZLt8Y?=
 =?us-ascii?Q?UobdBY/Sy0Ci2+U3PEH0o+Ci9fKBTJ5wMr5VOxHxm8+NkZxwCyRMY+a0XQum?=
 =?us-ascii?Q?yHVmnakckjK8+AK3UXoJwYpatFnMdEEVyXustUyG9QBYZOuj/8hyFtob0+Kq?=
 =?us-ascii?Q?CDeB0VUEeSVkx0QqI+tzLY6J7uOUDz+l0BFhEI9Avp+8I8gFg7E0GKCvGjyT?=
 =?us-ascii?Q?3ZIhoNHnkUr7A27fdCg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 19:30:53.4897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49850f81-c2ba-4259-145a-08de0b5830b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7988
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

There is already a helper for telling if a block is valid, but if
IP handling wants to check if it's HW is enabled no such helper
exists.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Harry Wentland <harry.wentland@amd.com>
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23 +++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d8bb339d4ebd..17b3f00af756 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -372,6 +372,8 @@ void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
 					    u64 *flags);
 int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 				   enum amd_ip_block_type block_type);
+bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
+			    enum amd_ip_block_type block_type);
 bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
 			      enum amd_ip_block_type block_type);
 int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c7c999ae2a28..a431ddeb540a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2387,7 +2387,7 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 }
 
 /**
- * amdgpu_device_ip_is_valid - is the hardware IP enabled
+ * amdgpu_device_ip_is_hw - is the hardware IP enabled
  *
  * @adev: amdgpu_device pointer
  * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
@@ -2395,6 +2395,27 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
  * Check if the hardware IP is enable or not.
  * Returns true if it the IP is enable, false if not.
  */
+bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
+			    enum amd_ip_block_type block_type)
+{
+	int i;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (adev->ip_blocks[i].version->type == block_type)
+			return adev->ip_blocks[i].status.hw;
+	}
+	return false;
+}
+
+/**
+ * amdgpu_device_ip_is_valid - is the hardware IP valid
+ *
+ * @adev: amdgpu_device pointer
+ * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
+ *
+ * Check if the hardware IP is valid or not.
+ * Returns true if it the IP is valid, false if not.
+ */
 bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
 			       enum amd_ip_block_type block_type)
 {
-- 
2.49.0

