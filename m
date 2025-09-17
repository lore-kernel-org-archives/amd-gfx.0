Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79849CAC59A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 16:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E2DB10E54A;
	Wed, 17 Sep 2025 16:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XlxMJdkg";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 839A010E54A
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 16:42:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLpM+Q7bb/VyCDr5jdYUCVGZmFRcdFnugw2w6z743Hvdyt6HH37GPUYHRlry2PkpGqUWIYl92Cq5g7ctdHs8qNPqh91LywJRwpjzOQmDrelfvUOiasyeB9DyBqSjFIVtPCqE5nHG+iHUIGw3X/uFSkrYOetPTJyCmnSiB9aifpXoUwTpEgyoATCNXIivZQEvD1TqGuTqnsyU5FJ6vAedavtkwweYpXh5uZz+JzL6igtuK84w7vP04+GmP1wjVZXwmDlJS8jmIhiNmno2Xo2OLgYYZUgmq4yj7zzzafkFJC6WVcLMgSGZHBLKkUWrBDqgFWAHE+GJdkcTlZuLBRvy8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHDdgh+MjSTD2uf3ym426tsE703WhxsIip52yY3JMWE=;
 b=TkC5ycAarY5g6hH5jvMyZxPdPNTVO6DAvnJ/ZaiHGWyg1a8iBS3Xtw43LD/TqLwIPXyNpkcwAm1lUcv5L/5/1nJqFc8sf2xTrVug/cq2eApR3Bw48V8m1y8v9zXm7k9gEGJe5ml+bjrlnj7svRxFDUS8MK7XeCj7KiJHWEYUp7XCyeoYi2ZPe9S1hlR31s7Ox+g0AFaNjRckj+afjwt04kdz6XKwwuqV1GMZE/8VKHoMm8cGqA7GBv06vQRLg7Iau7SPFM98JB6V5adY1JXxrWYXPOzpkP1FjTrozu7IJf+c571xcFiAmjjwe2EfCKLvJI5SutfsBQIOwsj7infcog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHDdgh+MjSTD2uf3ym426tsE703WhxsIip52yY3JMWE=;
 b=XlxMJdkggf1oDvgCeEz1JsNHVhCmqVVZCIVX1Pnw3KRBFPhCp8k0kzf9xnIE8CRURDHrhjpFA9597BY1EHN2GfuNFmi0uWkyFBt4injmlg7Czu6rHWS0dGbZWsZGnvDuxRMxoTClZwvI4RpdZYeGsxU5Vsnw1XlrmttoprBBUU4=
Received: from CH0PR03CA0423.namprd03.prod.outlook.com (2603:10b6:610:10e::6)
 by CYYPR12MB8890.namprd12.prod.outlook.com (2603:10b6:930:c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 17 Sep
 2025 16:42:29 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::30) by CH0PR03CA0423.outlook.office365.com
 (2603:10b6:610:10e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Wed,
 17 Sep 2025 16:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 16:42:29 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 09:42:26 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <mario.limonciello@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdkfd: add proper handling for S0ix
Date: Wed, 17 Sep 2025 12:42:09 -0400
Message-ID: <20250917164211.1761304-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|CYYPR12MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: e39f998e-7f8c-4dbb-0b4e-08ddf60930f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h6G7Da4GJlCnYCT3DTrqJaljP7HtETbhyLe/kPwr+WXrUzhiLG19Q1IW6twx?=
 =?us-ascii?Q?fe40agn3X5ULorfn3+ueq6NERfiFkWSeSxh/OSPYEIXnvj74HbfKPK8IqqMe?=
 =?us-ascii?Q?JXSRMk848nO07HVdJOn6e0o7kppMQseTXJEioH5jSILQ8Kwt0IdNJ1VnMX+0?=
 =?us-ascii?Q?hiwLpbEXNBUotedi14/PkbanjK9py6r/MQhoZFjuiYFW1kBpAWE6t874rYVU?=
 =?us-ascii?Q?oMfn309Mo3YgOc3Snfrof2e+FGotgUmwK5hwTYG1PN8HE2+081tIm0GQHtRK?=
 =?us-ascii?Q?8CN2b90TTa8bXhWOGsYCIThUPQihiJdiKEx1ZwODHvUP+cX5Yhz18HjJInlw?=
 =?us-ascii?Q?mTE2StQke3XaZ0B3DMz8hLYYtZnHjd/ZCjvwkB+d4x8wxtLguSpwFKDikSaJ?=
 =?us-ascii?Q?zxjdDL8XPfUk3aX8H5ueofgSyqSWkcTyd2zsLtOSFkte5jbCUGeDm//Sy4Od?=
 =?us-ascii?Q?N6CZx+i8W7mSYLhLywcrl0eWditUKK8MMkKDWY4El0J8PnBUFYToVJ38eBRh?=
 =?us-ascii?Q?fQrosCV5Hc1xro0Cic3WD9Y9BjFpZBgAguIbeAVX52hpTBctY8vzO5wZsoIf?=
 =?us-ascii?Q?SwylL/pHH786TxGHCs9OQPLoSugeROh9eGFNv/xW04BsnMs47ggf6ZG1qrXK?=
 =?us-ascii?Q?cpuzBg/MlXCE3PDf1dVl7tOv/BlKvqfoZIy2P/8okkacUc2vieUPcAt2erTd?=
 =?us-ascii?Q?YCSPZsi1xqDhp0/Sr85QU6h57yvFbyryJA+71nyCybVgiRMl67pQ43PfI1tb?=
 =?us-ascii?Q?7VKrammUmXHtU5RxEAkvBIVQfXIUyoUHRvJjnVsYje6w4o4+vnji72SPWEv7?=
 =?us-ascii?Q?8j6GoSYAbt6POcVxcDA31eZoHGnBnffbFrAXARWDXSU6LsKZuAfAcReo5aDL?=
 =?us-ascii?Q?HAiPW+M0o8D1fDLOc8tEi3ij2/nLDFE9s70srMxhzTNVWNqwLFUM7Bz0TevJ?=
 =?us-ascii?Q?QddHN9QSNKpAbgDyMT1dQv1JrK1SDaTV5y2VdAnShpT6ZIpFVPM5qAKijCl0?=
 =?us-ascii?Q?Y9fhz9Omisc3D3AjQQ9ZgSs83w00m8dnlW6rw0Wv32zmKUaw7Cogcb+KPuEA?=
 =?us-ascii?Q?wd6uvd4bZxEotbmhKKdFuvXgT1gWvtwoT5QetrGBimYhBFs94EHCygzFquRO?=
 =?us-ascii?Q?L1ko+zqyzJ6X28VgR145PwUirS7ZM8zOhqYGHDBTw5BWyDcVj2IRePV7HEOL?=
 =?us-ascii?Q?a6tQ6hgp6nvapCJlnDZcpnecaz1kO+VmfbujP4VhqS63eENDIw5wYROSDdNl?=
 =?us-ascii?Q?g6Hwo3+YKozcZZd7gJhuPMQ6PRKRlRglBdPhB25MSISxVStyT/K98ioWFBr8?=
 =?us-ascii?Q?xBzCKba5rncrcClW+Kr/mcQ6BzsdIQPpVmI9DO/MzO7OeuUeOrdk4TVN9U8L?=
 =?us-ascii?Q?HxwgHIyH8LssdHpWVVwnwN14mF7Fuy6/xhg9YcDlCEMK6h59ACsdp466FP+5?=
 =?us-ascii?Q?qnh2acweKKFksEmYiVta5SmdNRVQkrMo7m1r1IFqgdhgf81BagV7ogAVf+Nd?=
 =?us-ascii?Q?LId4dvWcH0PAMANXChj4Ku2fDEiL6T0B8en4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 16:42:29.2372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e39f998e-7f8c-4dbb-0b4e-08ddf60930f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8890
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

When in S0i3, the GFX state is retained, so all we need to do
is stop the runlist so GFX can enter gfxoff.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 16 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 12 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 36 ++++++++++++++++++++++
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index fbe7616555c83..a2879d2b7c8ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -250,16 +250,24 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 
 void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool suspend_proc)
 {
-	if (adev->kfd.dev)
-		kgd2kfd_suspend(adev->kfd.dev, suspend_proc);
+	if (adev->kfd.dev) {
+		if (adev->in_s0ix)
+			kgd2kfd_stop_sched_all_nodes(adev->kfd.dev);
+		else
+			kgd2kfd_suspend(adev->kfd.dev, suspend_proc);
+	}
 }
 
 int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool resume_proc)
 {
 	int r = 0;
 
-	if (adev->kfd.dev)
-		r = kgd2kfd_resume(adev->kfd.dev, resume_proc);
+	if (adev->kfd.dev) {
+		if (adev->in_s0ix)
+			r = kgd2kfd_start_sched_all_nodes(adev->kfd.dev);
+		else
+			r = kgd2kfd_resume(adev->kfd.dev, resume_proc);
+	}
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 127927b16ee29..9e120c934cc17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -428,7 +428,9 @@ void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask);
 int kgd2kfd_check_and_lock_kfd(struct kfd_dev *kfd);
 void kgd2kfd_unlock_kfd(struct kfd_dev *kfd);
 int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id);
+int kgd2kfd_start_sched_all_nodes(struct kfd_dev *kfd);
 int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id);
+int kgd2kfd_stop_sched_all_nodes(struct kfd_dev *kfd);
 bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id);
 bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu_iv_entry *entry,
 			       bool retry_fault);
@@ -518,11 +520,21 @@ static inline int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id)
 	return 0;
 }
 
+static inline int kgd2kfd_start_sched_all_nodes(struct kfd_dev *kfd)
+{
+	return 0;
+}
+
 static inline int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
 {
 	return 0;
 }
 
+static inline int kgd2kfd_stop_sched_all_nodes(struct kfd_dev *kfd)
+{
+	return 0;
+}
+
 static inline bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id)
 {
 	return false;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 7e749f9b6d69d..349c351e242b5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1550,6 +1550,25 @@ int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id)
 	return ret;
 }
 
+int kgd2kfd_start_sched_all_nodes(struct kfd_dev *kfd)
+{
+	struct kfd_node *node;
+	int i, r;
+
+	if (!kfd->init_complete)
+		return 0;
+
+	for (i = 0; i < kfd->num_nodes; i++) {
+		node = kfd->nodes[i];
+		r = node->dqm->ops.unhalt(node->dqm);
+		if (r) {
+			dev_err(kfd_device, "Error in starting scheduler\n");
+			return r;
+		}
+	}
+	return 0;
+}
+
 int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
 {
 	struct kfd_node *node;
@@ -1567,6 +1586,23 @@ int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
 	return node->dqm->ops.halt(node->dqm);
 }
 
+int kgd2kfd_stop_sched_all_nodes(struct kfd_dev *kfd)
+{
+	struct kfd_node *node;
+	int i, r;
+
+	if (!kfd->init_complete)
+		return 0;
+
+	for (i = 0; i < kfd->num_nodes; i++) {
+		node = kfd->nodes[i];
+		r = node->dqm->ops.halt(node->dqm);
+		if (r)
+			return r;
+	}
+	return 0;
+}
+
 bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id)
 {
 	struct kfd_node *node;
-- 
2.51.0

