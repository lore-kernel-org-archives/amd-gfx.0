Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A0BEF06E4
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Feb 2026 16:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3BD110E23E;
	Sun,  8 Feb 2026 16:43:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x8tvlNDq";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011071.outbound.protection.outlook.com
 [40.93.194.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EAF510E30A
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Feb 2026 16:43:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYTwS82b17Ya7+RnFerk35M4Pc1/K/27AgNxfsxy9kIg+DDHjqLcGR4TMXiJx+NtNcb1ejq1A2FLYrlA3+cbgoR+z+6OWN5LuF/ualza7lAMNxDy4wJ/mJu7u9CIj38L9SZUUFPBgVJCAAoxLXMjROqcP4VIq2fuq8g2F2KLCxmmlgNRadetq6lYc2asU5jcIcXkr4eQeYN3xihFNq27ZhIqUNWgPxe7KFe68YZZG0kLlGNU//79d47cpU1M//0mDz1O4XE/8G8nVl0SuZ77yC/B9ymj7+9A+peqL3NZs9n0bBGI1f4zMSadheXLlUaLMgaxjZmw2MFL498FL1cpBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pmk1xVKZWPXsR6F7ONoh7O6BMyRMfnGexr2UjZ2iVwU=;
 b=l6UKRHISAuBwBcHDD54+dFOBMrF4c10qy/GO/ugpzSjM84oZxKPqyWqhySGywplLB+BmkCfQ8vi/K4/wqe9SXKT6HaMBQrzSKY7RtFYSz1ALhw8CgPNURoDhRviqvzb9Jx1Pl98Zm1z9LUx34J4jY6nHFnkA7U11L3t5RvBLbh0SBMpfUDDADWtj9TYpNQOrLhcz6+jPgEalT0Y+4loAoBPA98JjFkfvukVA+IUby8E6OIepSYI7eR7/C2im32/6awkP+0YEz08zonETehxMzVwxbhdaF+UmLslpHwTm0dR8Iy52bpEG/x9eoPMItSBXWHRr8bVxSK17lOO3do/z6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pmk1xVKZWPXsR6F7ONoh7O6BMyRMfnGexr2UjZ2iVwU=;
 b=x8tvlNDqRtu8ZO78Y8ej3fqddWzD09jWHn4m6d8BAM3iM4GANn686Fg7ffFGDCPa3UR3+y38JmV5OMDXmKnefQvyG9BZ6VaCk1JNsipQJPYovDzWTD3J7A82Xk3FppjB9tjGS7w+qYhdZNBCg/K9T6HWHT1Tgu6L9i95v2D8zF0=
Received: from SJ0PR05CA0179.namprd05.prod.outlook.com (2603:10b6:a03:339::34)
 by DM3PR12MB9328.namprd12.prod.outlook.com (2603:10b6:0:44::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Sun, 8 Feb
 2026 16:43:47 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::b1) by SJ0PR05CA0179.outlook.office365.com
 (2603:10b6:a03:339::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.5 via Frontend Transport; Sun, 8
 Feb 2026 16:43:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 16:43:47 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 8 Feb 2026 10:43:46 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
CC: <Yifan1.Zhang@amd.com>
Subject: [PATCH v2 10/13] drm/amdgpu: Track PTL disable requests by source
Date: Mon, 9 Feb 2026 00:42:09 +0800
Message-ID: <17a54e71a4e4f9f0a1c2cc720bd7f71adcd724f5.1770568163.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1770568163.git.perry.yuan@amd.com>
References: <cover.1770568163.git.perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DM3PR12MB9328:EE_
X-MS-Office365-Filtering-Correlation-Id: 319544a3-1a08-47d5-1e25-08de67313b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f/IfdbbJsvNEY3OGLabffvWUQ/pMB9gFbahxtJcLnpnaLugIJ8Zdg4y9Qpdq?=
 =?us-ascii?Q?ogjxvQJHlPq87/Hrr0q0Gd7J/rn9aipzKQFG00uYIqIJCJ7nXph91TaMu7DL?=
 =?us-ascii?Q?vrKI0kc1rtXesvU0py+I+gLVcf2s7hiEd3JNi4XWb+OGaQpfRzNjhG+JUxbE?=
 =?us-ascii?Q?LraevRXvHuz1ohL8rZA/mfOGtoxik8CoiEyumFJCRJRiHOu9xudOb68vX1Xq?=
 =?us-ascii?Q?nqkr7fVCPIeXuqSJQMR9jMiyj4sL0ZJgzNtfK5+NAX1lqFxFOQwaUUAnvtjj?=
 =?us-ascii?Q?dRTSZgk6SCUU9Uvvsj0dU/stofY/GGY89susJAuD5STOuNz60eku02/CC2lB?=
 =?us-ascii?Q?NWqjXJCapz4RzOlw8m7kKwXFNfH9aej9sDb+Yv5VmcQkjbiug0QniwYBoHz5?=
 =?us-ascii?Q?JlYf6xrVhkLq1oVaqGYSwvVOVToQxy6gc6YmWvGtvpiieySeoTnb3oF0sU3N?=
 =?us-ascii?Q?JvpMvQa+f+KC8Y0y1Cuq+jbhd7R0OPkaz7nznEF51Tip0LTOnJb/Yhg4fPPS?=
 =?us-ascii?Q?jKstcYmXXTrIQ/TD7BANefd3Lhtq0uCxFabSJ3/2I4DoYn145H14uqTV9zAJ?=
 =?us-ascii?Q?1AtCr6l+STlTn+EQroc5oCtIpbCovk0wL8arB+qo5KvZD6f0fHRfM1JUoQWo?=
 =?us-ascii?Q?JdLtC7boJ0HiqyOXnGziJGjwgWrXmHJSthiv6kuRc1ZiQcFBdWNtzcDJtxie?=
 =?us-ascii?Q?Vle03mvCen8xmcuDDJBUf/LS17RyimEAsQGFtQ3oaNhvEHlbmvprqd2bsdDb?=
 =?us-ascii?Q?2xoqxsFwRTsPBN5sBuPzUJ8W+yz/nilMC9O5VKsNNvniTpJZJJGVXTkwEzbK?=
 =?us-ascii?Q?D+zAucdGz+tIHxOGwwNxgx2hsgy/BE52aKVE+DMOIV9zro5j+P09l1ooVN6V?=
 =?us-ascii?Q?74ic0sTaj+KbW8dVApyRiYqMYOU6oGwjw1jPRc0xdaJivSDzFuPNAX/jx9oK?=
 =?us-ascii?Q?0bjCZzPUiMjgwTHNO2NTdj5I4aKu6KWhbH8W7kkH5Xo+DAmMIEMco6bs+L0v?=
 =?us-ascii?Q?hnTRrKSSBOaFs4wWFOqUlNPxClBXo+MQGf0hLP8F4U7oe9LXnK741J4LRzNf?=
 =?us-ascii?Q?7nNbvX2sGbhsankqarvNrLI9GYoL8xr6YK2ODe/JXeyFNoF9lCcVWptN61Ab?=
 =?us-ascii?Q?gQt22avPbrFU1/2x9TSENXTntSVGlvm5kWhCQTxpK13DGRE+JQSzNjBOwQjy?=
 =?us-ascii?Q?wrBtX/AwF3QNoUJ5J88HhRKwFTKYTak6NtMjs7gLvrBRMjVTx4/eRsPtCHYf?=
 =?us-ascii?Q?4LPLnaxJA6nS5qeUMdkIH2wTr9hc1iDO70C129y4WhsdlBIyYl3/Y1NXqaDD?=
 =?us-ascii?Q?OfOt1m9+VZ7XLKBpPdE/bZLracIjUJCbbT4tFxNR9ic9Hm0ugV2WPgu1hb7B?=
 =?us-ascii?Q?AQ9zSDn9JSdStrGZWdN/Hi1R3IxtKttx2kYE+ihuS466d5f3981ifsZlqfX9?=
 =?us-ascii?Q?XvlHVhHpBjMyhK7yKIlfU+rhtFIkVcxgzq3pJgaoY08C0nCXrRVGtz2pxBuk?=
 =?us-ascii?Q?YNgb1Q4nIlXGK8cPeKgtXAxvc+/HCT/0EnFbUmizIiUWFQ35NdjJa9ex8x9K?=
 =?us-ascii?Q?H7zQiQOnct5m7A+wgpaENpP+44TJ38EOMsPo/wDa4sxuxT3kYZrKPgKGUh/I?=
 =?us-ascii?Q?ffUfxn9yvHWTKSwyj6fdXar6BYZAewi2GJv6X9vnNxLzKK7lO82CKB8Q0SEt?=
 =?us-ascii?Q?fvVPZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /XtFG9+yR+9Dd/HpVr/CwJbE+cENEWMCGic6QTUwaZOV+iZ9hi6SFQtoravLYowhrg/ufAu+zFQL+RTagHbtTWEkTpKhcW60T0GfkhoF8DoN/7WqiO0S7ZKeHuC8jbCjxae8pSFLLndeDeTnPaItL7d/7rpgCfRQUqvOLv2bIo5dASEQqfNrAAYCt4Nm+8MDVv2ZoAwGVPNzMH0mjci1WGlVt4ZUHwCw1rXrrwO2xe/ekIt91sn1OJKkuBIlq3yXJAOIAf5WXbnLIK6A8nr06U6etUZwHxj8aB/iHX3HRBXl6dfY6+aUa94THW+RweqdIZXANU2Yw/wCMMlBPPNGTIxysCYSIAOT/DwETAZ7M2cub1lbVNG+tpX076nq1pt99BSJ/Hhlxvt4EEXAV4PA/4+NTuiJa5BG3i4eyLDxOfYzdR7l3yswNS3itTbehvxK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:43:47.4141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 319544a3-1a08-47d5-1e25-08de67313b11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9328
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

Use a bitmap to track PTL disable requests from sysfs and profiler.
PTL is only re-enabled once all sources have released their disable
requests, avoiding premature enablement.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 26 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  3 +++
 drivers/gpu/drm/amd/include/amdgpu_ptl.h |  6 ++++++
 4 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a1481ad465a4..413a7e44048c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1314,6 +1314,21 @@ int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_code,
 			ptl->fmt2 == ptl_fmt2)
 		return 0;
 
+	/* If enabling PTL, check disable bitmap */
+	if (req_code == PSP_PTL_PERF_MON_SET && *ptl_state == 1) {
+		if (!bitmap_empty(ptl->disable_bitmap,
+					AMDGPU_PTL_DISABLE_MAX)) {
+			dev_dbg(adev->dev,
+					"PTL enable blocked: SYSFS=%d, PROFILER=%d (ref=%d)\n",
+					test_bit(AMDGPU_PTL_DISABLE_SYSFS,
+						ptl->disable_bitmap),
+					test_bit(AMDGPU_PTL_DISABLE_PROFILER,
+						ptl->disable_bitmap),
+					atomic_read(&ptl->disable_ref));
+			return 0;
+		}
+	}
+
 	return psp_ptl_invoke(psp, req_code, ptl_state, &ptl_fmt1, &ptl_fmt2);
 }
 
@@ -1353,6 +1368,7 @@ static ssize_t ptl_enable_store(struct device *dev,
 	uint32_t ptl_state, fmt1, fmt2;
 	int ret;
 	bool enable;
+	bool bit_changed = false;
 
 	mutex_lock(&ptl->mutex);
 	if (sysfs_streq(buf, "enabled") || sysfs_streq(buf, "1")) {
@@ -1368,14 +1384,24 @@ static ssize_t ptl_enable_store(struct device *dev,
 	fmt2 = ptl->fmt2;
 	ptl_state = enable ? 1 : 0;
 
+	if (enable)
+		bit_changed = test_and_clear_bit(AMDGPU_PTL_DISABLE_SYSFS,
+				ptl->disable_bitmap);
+
 	ret = amdgpu_ptl_perf_monitor_ctrl(adev, PSP_PTL_PERF_MON_SET, &ptl_state, &fmt1, &fmt2);
 	if (ret) {
 		dev_err(adev->dev, "Failed to set PTL err = %d\n", ret);
+		if (enable && bit_changed)
+			set_bit(AMDGPU_PTL_DISABLE_SYSFS, ptl->disable_bitmap);
 		mutex_unlock(&ptl->mutex);
 		return ret;
 	}
 
+	if (!enable)
+		set_bit(AMDGPU_PTL_DISABLE_SYSFS, ptl->disable_bitmap);
+
 	mutex_unlock(&ptl->mutex);
+
 	return count;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 332633f6f4be..11fafe332bff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -31,6 +31,7 @@
 #include "ta_ras_if.h"
 #include "ta_rap_if.h"
 #include "ta_secureDisplay_if.h"
+#include <linux/bitops.h>
 #include "amdgpu_ptl.h"
 
 #define PSP_FENCE_BUFFER_SIZE	0x1000
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index d699d0354bda..4498de4aa925 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1815,6 +1815,7 @@ int kfd_ptl_disable_request(struct kfd_process_device *pdd,
 			goto out;
 		}
 	}
+	set_bit(AMDGPU_PTL_DISABLE_PROFILER, ptl->disable_bitmap);
 	pdd->ptl_disable_req = true;
 
 out:
@@ -1835,9 +1836,11 @@ int kfd_ptl_disable_release(struct kfd_process_device *pdd,
 		goto out;
 
 	if (atomic_dec_return(&ptl->disable_ref) == 0) {
+		clear_bit(AMDGPU_PTL_DISABLE_PROFILER, ptl->disable_bitmap);
 		ret = kfd_ptl_control(pdd, true);
 		if (ret) {
 			atomic_inc(&ptl->disable_ref);
+			set_bit(AMDGPU_PTL_DISABLE_PROFILER, ptl->disable_bitmap);
 			dev_warn(adev->dev, "Failed to enable PTL on release: %d\n", ret);
 			goto out;
 		}
diff --git a/drivers/gpu/drm/amd/include/amdgpu_ptl.h b/drivers/gpu/drm/amd/include/amdgpu_ptl.h
index f944ab45d1ea..875277312d30 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_ptl.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_ptl.h
@@ -34,6 +34,11 @@ enum amdgpu_ptl_fmt {
 	AMDGPU_PTL_FMT_INVALID = 7,
 };
 
+enum amdgpu_ptl_disable_source {
+	AMDGPU_PTL_DISABLE_SYSFS = 0,
+	AMDGPU_PTL_DISABLE_PROFILER,
+	AMDGPU_PTL_DISABLE_MAX,
+};
 struct amdgpu_ptl {
 	enum amdgpu_ptl_fmt		fmt1;
 	enum amdgpu_ptl_fmt		fmt2;
@@ -42,6 +47,7 @@ struct amdgpu_ptl {
 	/* PTL disable reference counting */
 	atomic_t			disable_ref;
 	struct mutex			mutex;
+	DECLARE_BITMAP(disable_bitmap, AMDGPU_PTL_DISABLE_MAX);
 };
 
 int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_code,
-- 
2.34.1

