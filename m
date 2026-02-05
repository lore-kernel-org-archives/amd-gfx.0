Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511B5E9126C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2E4C10E7D0;
	Thu,  5 Feb 2026 06:52:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nigfy3Rd";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E10710E260
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:52:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7UF/sTOnIBNRs8htNYXDux+6drKY9Oml2SqgfjvQTZZ8U9cQcWWqiXCyvI0mGgQQPaCvEV0vMRp8EU9jrwKG+k7/1DG5ZvSnGZlDho125GBSSLlAn/Y/bMI3WkP0JQUpgLD7dIRTdNI426Y1kPfRxjm8zcJwSncK/csD0jLSeNwERkMGOnvA46JuE6VDErNjZvIF5zyWCp+g/iP3nOcO5C0OtRE4I3Gs5RbMR9N7Vykd8qMSci4NeiGxzddl8EbdADxghR2dCtRZm3A2ouQtbqAcVOOwSRNshG9O5DyqC4dJCRxAYyPkALL+2UiXAXV+DwRAmGTalrtztd3h8ZqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9peTTWEqqHIBDTiHeUYyEMwBxLlxlwJpYxqmvr9TlOY=;
 b=c4iQJZJhLMldxiH6KtrID/NQIQPnfM64OftvcwRGN+4CoOaMP5g0ICZzKlgvODXxi5moZFacf3ylzFpitNC3Dvzw6cjK4A3Skxev7KABwLNOat3l9qriV8MEmXQsuU5E5QLsvK54uFY2ypL2yBrweEaZV553LJsI9dHVoEOnu0B7d7iBCSdJMMTcHiL/lFI7uN+mF4rXHPlKQlJbj33eA+xPGw8yd7a8fLcLKao0ZLO7+gdOhYXjzmq/bX9k3HzoJrkBcoRsuhr1hgbmvVKH8ScfAmkzyx9TR+Gdbphe+pe+sxAd3gkB+tHe8zwe13b7e3CHNqMrP0B0M9FxHOyURw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9peTTWEqqHIBDTiHeUYyEMwBxLlxlwJpYxqmvr9TlOY=;
 b=nigfy3Rd1mZRyB6geG7P4RBFQpN3HCkkvm6BQ7kaG87rHp9OtkHeBGNY2klQ1WYifafn4uk3vwWUhOnJPB5gkBZtcch0GOobj/cU0lD4xDlSKBLUG7Rz0YbLJHopRbmT5MKmTXfQoIBExTXeeqFyIQlYZ1cgRSZ7rVm27gplIwo=
Received: from PH7P221CA0045.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::17)
 by DS0PR12MB6462.namprd12.prod.outlook.com (2603:10b6:8:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 06:51:58 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::8d) by PH7P221CA0045.outlook.office365.com
 (2603:10b6:510:33c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Thu,
 5 Feb 2026 06:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:51:58 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:51:56 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 13/22] drm/amdkfd: Refactor PTL control and add HW support
 check
Date: Thu, 5 Feb 2026 14:51:21 +0800
Message-ID: <20260205065130.654921-13-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205065130.654921-1-perry.yuan@amd.com>
References: <20260205065130.654921-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DS0PR12MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb228c3-e182-43e8-2eea-08de64830e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D8mWEWOantm05P9qA208dpnTE8PGNnS9yu+fZrx5n1IFz9vP2xZH4b/uGIBX?=
 =?us-ascii?Q?aQ0gZNnE/3o0GHsKsQfOib1DMXB1LDSF+n302OE+i9LXS/oEXRSa5HDwx76z?=
 =?us-ascii?Q?MUVz+O/Q7HyEUF631CH2tKni+gM2QRZ3qZh0KUhRHGDMJL3IEmZXnDACDInT?=
 =?us-ascii?Q?H+Z8ErjcT2gHn4Z51YlCYzXjnom6dY/pWAtLtLPodxbRraQ2d492CZA7zIqb?=
 =?us-ascii?Q?AXltBbTUSBw1PfKHiZXLayV3ENCHiwH1Ow93KKJFAO2mn3QptYlGVe10rNRd?=
 =?us-ascii?Q?OCGuWGL681hI0z3hv2rj2KeD0fzJotWhL2cbv2kHHNXsGx1rYzDBdGGIy64k?=
 =?us-ascii?Q?+EXc8AcvkMP/pewuYh2rIrdMylzkhu9kJktSnlxX32mpuf8LNseMBbLsNyNI?=
 =?us-ascii?Q?vm2ffBrUoUD5UAHVfV9Gepmht0gy1Jwhfj1tLF+TZNaNYoGD7gsRQpyOVild?=
 =?us-ascii?Q?UzO9kWh0I8Addz7oUXF/iJOao0bDJX5rGjo4leJ5yfHWd9fl+wm7LzJcZyH+?=
 =?us-ascii?Q?dnCFUZ3QVVmSF1JQ8b96tLdmKe/cRwue435BCLScRJ6DFlYQqWE9TOHIgY09?=
 =?us-ascii?Q?xZniAVVd++RE+YdFX9wZ6ctKYKvR2LsqO7DB/sYFBnjufnj/g9b77hzww/my?=
 =?us-ascii?Q?myWvxqPE7pk8n1qR+e54jxh0LYGS8WNlhc3woacAwp/bmIruwWi7VN0u+FKv?=
 =?us-ascii?Q?WCAKda1rVHJLLZuAo22MnWtknG6P7n/Fqy7glYLisCAq2R05O4qcyfjY7XsT?=
 =?us-ascii?Q?/0VQAdO104IxrLwOQuVV6Wu00O0+FnwLWsN1LYra+VcjZ8XV8YKV968WjHlE?=
 =?us-ascii?Q?atYvqA6RvZ60XApjYWRgL0WkrLQb6bSZNXeV3efkP9rNHMhIfD0JPiEgfRO6?=
 =?us-ascii?Q?lRB/w383Pf24W+t6IZws6UghywM+vwDsfgyLvRVG7HKGYlND3db2E48ahkQz?=
 =?us-ascii?Q?os5ED+fDKzxn8BMcOlslGriQY2vUVi+cWPY8uGoWxXijumF3RkZmMbwkc/rL?=
 =?us-ascii?Q?r4c+KT5xDXhao/7X9jujaHqkYl6ehgoYtCzZLmgTXzudC26rNYrfFiW/oxrr?=
 =?us-ascii?Q?gNtCUAReJoiCvKkfL7sUKUtaXoI3jIdsaNcjwvqqoT8rpRq+bJDdWXfeTVrM?=
 =?us-ascii?Q?vLLj1oOaH3hqUufTFImStN0VjHaUX0LZeX6N90jwBpWJ4Zfm1YzLOEehj6f1?=
 =?us-ascii?Q?887HrWPyAJg67aXYB1GFUBSehovpoXxBbRqzsCVoWtNyoTZPDgfMGnfH/XmS?=
 =?us-ascii?Q?gVr8oZKBUBNqhLJ7U7F1YegZwcUx7rmLACrbOnn9OxgmM1FASfkRPq/GuL0w?=
 =?us-ascii?Q?9UljxFgo9+7zSU9IxotNTtSr/8J02eh/W9fYL5S4ukYYew2Y7hFOe99n+SdK?=
 =?us-ascii?Q?Jinh4oWnCD5V9SKGJTFBB5RnulfDvm1Sfxl5sy+cRArucTJ0n2KqEdIKFDQE?=
 =?us-ascii?Q?m8qzQQ9saPVambUXLllIkQRG19vtgE3sgSX8xMwRm5I66e7Tqlx5DwZNT76X?=
 =?us-ascii?Q?NIDFBIteDuHfPCx8xcVN/2ry3xGMUHGGIqA+7+2Jd5cjKlvJorhWSogS6IZ4?=
 =?us-ascii?Q?b1NKdaMfOdVkP4otxm3gTcuTJh0S0xHn9uE80SlYLrnpfviBhjoWigBaj2Qo?=
 =?us-ascii?Q?cOjsxj0Wq+MDJdumnJTxA8EjOhKhnzmL3pGOcTIypkulPBpjdQ1q2YD2Uk6q?=
 =?us-ascii?Q?88P1Bg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B4oiPXyMGNrWSMe85E5V+V20qakR/RnJVcmvTFhMl5Wc2iYL6ZPFuTDM0VbmoDEltbiHYEi8DPRTDb1MX88PSz8eapM0ne2luZj/r3kHLAC2oe/Sh+YbnjjxBDEdBXhXYAbrq4tZCNxskFOGBJtbrOvAR8/qbytJQoZpQgHYi6dqhITGDXVMuGfNP0Q/K+oWIs8ud7QRlCjqNVIDTjIp86oitBmpaJ+lTvAm2Kuxp9vsxfCl9fhKMA6XpGOrQt/sqptSMMLAbVQ29TQ2WCN12u50nveUtz6SOW6VLM1XlNEbme5FtZSSldw3MZuoCUr4a0wF9iavUBpQAj+rugkageEBBKNiOZgYt7R4SynPux0af/IMSIyWAIT6bM59iqcV4kESA59uTNMxiCuNPUc6VlTQbgAdy2EVRNH7QXoPTHOk6Lfp8SFYqplLcmmWl0O6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:51:58.1000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb228c3-e182-43e8-2eea-08de64830e9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6462
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

This is a design change to move the scheduler suspension and resumption
logic directly into kfd_ptl_control. This ensures the KFD scheduler is
always stopped during PTL switching command execution, which is required for
the updated PTL control flow.

Additionally, update profile_lock_device() to check for ptl_hw_supported
before attempting to enable or disable PTL restrictions.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 27 ++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 6fa8cff55a32..5fda0efe5469 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1778,10 +1778,17 @@ int kfd_ptl_control(struct kfd_process_device *pdd, bool enable)
 	if (!pdd->dev->kfd2kgd || !pdd->dev->kfd2kgd->ptl_ctrl)
 		return -EOPNOTSUPP;
 
+	if (adev->kfd.init_complete)
+		amdgpu_amdkfd_stop_sched(adev, pdd->dev->node_id);
+
 	ret = pdd->dev->kfd2kgd->ptl_ctrl(adev, PSP_PTL_PERF_MON_SET,
 					  &ptl_state,
 					  &pref_format1,
 					  &pref_format2);
+
+	if (adev->kfd.init_complete)
+		amdgpu_amdkfd_start_sched(adev, pdd->dev->node_id);
+
 	return ret;
 }
 
@@ -1831,11 +1838,7 @@ int kfd_ptl_disable_release(struct kfd_process_device *pdd,
 		goto out;
 
 	if (atomic_dec_return(&adev->psp.ptl_disable_ref) == 0) {
-		if (adev->kfd.init_complete)
-			amdgpu_amdkfd_stop_sched(adev, pdd->dev->node_id);
 		ret = kfd_ptl_control(pdd, true);
-		if (adev->kfd.init_complete)
-			amdgpu_amdkfd_start_sched(adev, pdd->dev->node_id);
 		if (ret) {
 			atomic_inc(&adev->psp.ptl_disable_ref);
 			dev_warn(pdd->dev->adev->dev,
@@ -3337,7 +3340,13 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 		if (!kfd->profiler_process) {
 			kfd->profiler_process = p;
 			status = 0;
-			kfd_ptl_disable_request(pdd, p);
+			if (pdd->dev->adev->psp.ptl_hw_supported) {
+				status = kfd_ptl_disable_request(pdd, p);
+				if (status != 0)
+					dev_err(kfd_device,
+						"Failed to lock device %d for profiling, error %d\n",
+						gpu_id, status);
+			}
 		} else if (kfd->profiler_process == p) {
 			status = -EALREADY;
 		} else {
@@ -3346,8 +3355,14 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 	} else if (op == 0 && kfd->profiler_process == p) {
 		kfd->profiler_process = NULL;
 		status = 0;
-		kfd_ptl_disable_release(pdd, p);
 
+		if (pdd->dev->adev->psp.ptl_hw_supported) {
+			status = kfd_ptl_disable_release(pdd, p);
+			if (status)
+				dev_err(kfd_device,
+						"Failed to unlock device %d for profiling, error %d\n",
+						gpu_id, status);
+		}
 	}
 	mutex_unlock(&kfd->profiler_lock);
 
-- 
2.34.1

