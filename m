Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3293CD33990
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 14:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2A9410E4D2;
	Mon, 28 Oct 2024 14:53:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ay7KKvI6";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62DA510E4D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 14:52:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iw45ZMXPkn6pH7XCQf4IH0CR68Kuj2u0oGEOerj3dCQbWdsPtcyv4VZslPI8tNYnE5gHufN78biYewW22iawXQ6UNqgiZBWlNNSlM2b9AfhdHUjxodYBks0wDiZpR1Qyr943yyRygQ2s3RFKQPBjhd8KbzEpsThtvP13GIm1W57YazoNwJhcaSt/JFNfilaH/ifshEbRHEP2o5dOLEIG0qb62U9ppwG766XTzKVvnlkclqP1zxMVfT0vYt5riJtRSRegb4S4UGriCOOP83bRXtdDgNNLvcmE7Kg67gpd+VzHlR193hQUZzbdZ3WL3VhsnikmIbpY5OVdmIVol4w/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qts229iPH8q48aiYARGlFKu2fwo+2syhMVOwWVjco9k=;
 b=JeHQ9OdDtzL8HuhMA9xTAyqovqRBNSWU7QD/p6Djwa7b8qE+zMozW4StZy9VK0EBl9Y0H0gt4M9olrQ6NHZfPgHy3JCcrXNQMupwiIX86iC3xslhGPHKKHF7rHRKp6oFhO/6HIZnOsdj3b2TTp9s2EragB6hy0wskAatxODAZki+ugpK889L8AeavoyPy1cViUvVjYL+ccCERNDNJmxA6ySTXuu6Awrw5KLB75f08/srLUwvbcDV99UNoE3VvZAN62S1crvkyrwGTPj92RsN/qKBFEyUAHT7aSLMIhX1YxVwMibYVWWRH+WktXxnHPdGCUGGs7keJKLWHy5kWm782Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qts229iPH8q48aiYARGlFKu2fwo+2syhMVOwWVjco9k=;
 b=ay7KKvI65yUbTdc9+KVNPE7k0kmsQl7TLrtsIdq1qtG9H5d/1QVM6J4qn1CKbsSylYsyE+fFnP/oP8tZTwGGYGJ+Qh5g7Om9OQaO1PajzyLhSLwM1NiPPYA3pXVhjVNQaGWFHHhmxzv1m1HS4bCxcjAwmC5y/qidoatfz3T1+Lg=
Received: from DM6PR02CA0162.namprd02.prod.outlook.com (2603:10b6:5:332::29)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 14:52:55 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:332:cafe::f8) by DM6PR02CA0162.outlook.office365.com
 (2603:10b6:5:332::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 14:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 14:52:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 09:52:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: add an interface to query whether is KFD is
 active
Date: Mon, 28 Oct 2024 10:52:41 -0400
Message-ID: <20241028145242.3672515-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d042081-2540-4d69-ca43-08dcf76034e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8pSahCaJMqFE/5gHeqZgWUOBouCCldUZep2gkb+6o5cCe3FheeSTMzWcBYi6?=
 =?us-ascii?Q?asFrbUhGM2ePtNk/P8zrhqbuzhgFrT674VuVN9zhDiTdEXAXb+2yO1Ro2+Vs?=
 =?us-ascii?Q?vaQ14VchMRnVXKqOfMeeSxmNzHDVDqdLogzOq26mNodQBCjHmKHRWqQovoEx?=
 =?us-ascii?Q?CnJewLxpRHk1fMJgmfU+sfu+1TnT3ysM5PbHMmK0/MV6QJ5XFKNhP99CQOvN?=
 =?us-ascii?Q?mR+i2cOrHEGJGpTGjxnVOv6LM0PWwIyZHKXnunCxc+EZoc+ESxB+aD+wQAru?=
 =?us-ascii?Q?6Ua7dzFUS42zApNd3XglfcPYq5AvbbrXmV0nmwu2wMNsqPCbHY/aTwKtbuGu?=
 =?us-ascii?Q?ARPQrU2y+/ncsExktBVA8XXJkaQKQzKAxNEd/9xhJpccDOtwfycCYdbnLvWI?=
 =?us-ascii?Q?StglFhTzkqOZg6ZCxbkFX1tU9GHTeV2TcVp7S/4TsUFSOYy4lbpswEAK7eLL?=
 =?us-ascii?Q?1xK6+14WTAXqKGAJX+VWw0WJd4YHbDiZ6am7O1kUkWmWxc7lsc5OlayBftM3?=
 =?us-ascii?Q?XwDYE8xDgbfJiEgDau2RcJsommA0U/35oJ4Yq40Bx2XjkjG2gWQeyR69UjMu?=
 =?us-ascii?Q?ryaEq65vUxGxNikGlGlP8HgAxX0uPDfsUj+madLsfcF2WCWtkekFceMOBoUf?=
 =?us-ascii?Q?wWCddWEmzLtNX/3uWa15y0D8LNbLvQgitvB+JAwJmuyKS0aLzvuB0r8XNU3b?=
 =?us-ascii?Q?tXEZrHbeu0VkX67QQU3dqRZcOB2srSwkV98DyV5Mq3BFQTH+ZeNoEwVi4qTt?=
 =?us-ascii?Q?sS4aRnfyRK+f9+PafpN9mXbPwXOjc3unExe3HSGZHH5F/cb/hIgb5dAL5wZ9?=
 =?us-ascii?Q?Dgra78VHsD1Z9DLWc35qTe2diMJ5V4H2Lg98ctmSn/cEAPwNsmRcD0TFWouO?=
 =?us-ascii?Q?VgwEPQzqn9yz1+ElkXRLPnG+afqaxg9ETlWfSgGqYkmcnHyzGyZM+KGHogCQ?=
 =?us-ascii?Q?vhEu61R+rVz9UO9sNoz/SKY7fsDFjbx9xT6pQGho8o6l3sV0g7QrkvZTPz+u?=
 =?us-ascii?Q?xAlSC3lokTFUmd8NkypfMcMSKS8P7dnxBl2nT+GLmYTaFHQw7pgy0qTgCsvk?=
 =?us-ascii?Q?/naGiYhnInog7PSHbZmpKaQlgsGgIMLGswV82g1bEA2LvH2s0tgCbrug9bPI?=
 =?us-ascii?Q?IDKi9cTVkCs385Qrm3Oga7EbRe6zOOXJvjYNRBUOrveCH5T0nnkKivEu3vdc?=
 =?us-ascii?Q?jBh9t9pCf7lBku9Wy7Yt9pqXwgzvqqO8HDElFKF2fWvCL45Eg0thkJEhIuCJ?=
 =?us-ascii?Q?ZOxJbw9UZhoyWRKqNefV75J9esGnfji1qWbeJeZgkYxIirfkWvAZLZ4Iytlt?=
 =?us-ascii?Q?ZrLkt1darw8MlCcIRczsEJrscykxZ8AFBPH0wnCbnQyKJbSFcsdBUMuSCzw4?=
 =?us-ascii?Q?ga/yWTU7uMnTIFOj/rGiuJMrJX4BWV+UYSCG1mZ3mDv1j5ilJg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:52:55.4742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d042081-2540-4d69-ca43-08dcf76034e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520
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

Add an interface to query whether KFD has any active queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  9 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  7 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 25 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
 4 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index b545940e512b..82f1c6a19d79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -890,6 +890,15 @@ int amdgpu_amdkfd_start_sched(struct amdgpu_device *adev, uint32_t node_id)
 	return kgd2kfd_start_sched(adev->kfd.dev, node_id);
 }
 
+/* check if there are KFD queues active */
+bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, uint32_t node_id)
+{
+	if (!adev->kfd.init_complete)
+		return 0;
+
+	return kgd2kfd_compute_active(adev->kfd.dev, node_id);
+}
+
 /* Config CGTT_SQ_CLK_CTRL */
 int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
 	bool core_override_enable, bool reg_override_enable, bool perfmon_override_enable)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 7e0a22072536..f47f4555437b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -268,6 +268,7 @@ int amdgpu_amdkfd_start_sched(struct amdgpu_device *adev, uint32_t node_id);
 int amdgpu_amdkfd_stop_sched(struct amdgpu_device *adev, uint32_t node_id);
 int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
 	bool core_override_enable, bool reg_override_enable, bool perfmon_override_enable);
+bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, uint32_t node_id);
 
 
 /* Read user wptr from a specified user address space with page fault
@@ -431,6 +432,7 @@ int kgd2kfd_check_and_lock_kfd(void);
 void kgd2kfd_unlock_kfd(void);
 int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id);
 int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id);
+bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id);
 #else
 static inline int kgd2kfd_init(void)
 {
@@ -511,5 +513,10 @@ static inline int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
 {
 	return 0;
 }
+
+bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id)
+{
+	return false;
+}
 #endif
 #endif /* AMDGPU_AMDKFD_H_INCLUDED */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b1ce73c7a9ab..9d8bdead6e65 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1404,6 +1404,13 @@ void kfd_dec_compute_active(struct kfd_node *node)
 	WARN_ONCE(count < 0, "Compute profile ref. count error");
 }
 
+bool kfd_compute_active(struct kfd_node *node)
+{
+	if (atomic_read(&node->kfd->compute_profile))
+		return true;
+	return false;
+}
+
 void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask)
 {
 	/*
@@ -1497,6 +1504,24 @@ int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
 	return node->dqm->ops.halt(node->dqm);
 }
 
+bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id)
+{
+	struct kfd_node *node;
+
+	if (!kfd->init_complete)
+		return false;
+
+	if (node_id >= kfd->num_nodes) {
+		dev_warn(kfd->adev->dev, "Invalid node ID: %u exceeds %u\n",
+			 node_id, kfd->num_nodes - 1);
+		return false;
+	}
+
+	node = kfd->nodes[node_id];
+
+	return kfd_compute_active(node);
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 /* This function will send a package to HIQ to hang the HWS
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 9e5ca0b93b2a..f9140fdb8132 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1518,6 +1518,7 @@ bool kfd_is_locked(void);
 /* Compute profile */
 void kfd_inc_compute_active(struct kfd_node *dev);
 void kfd_dec_compute_active(struct kfd_node *dev);
+bool kfd_compute_active(struct kfd_node *dev);
 
 /* Cgroup Support */
 /* Check with device cgroup if @kfd device is accessible */
-- 
2.47.0

