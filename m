Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D578CD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2958E10E66C;
	Tue, 26 May 2026 14:11:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WxgM5xJ0";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDDE210E66C
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:11:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAcHdkC30weaWzRnPFuOqY4kuE9vBsoD7oozHT14UK2igTFXfIQIbFYIn9Vx3MZACkwJeuT5iN5Ner1xXpDm7TeYkkovFuaX5/d0+uGkhzPheY5ZW7rARj6my3Zi4TG0/B2iTk5nTIxsA4F40/fCIKf1flsbZJ/xwC7By+yVyx57ueuBy4qV6hXHK60sOR72TK2TE3lpqk5ROlJniFU5iUhOQbaoMqjb3v587WmgyctGw65u+RwpDG1pCh8aGYMG7yP+cGSPYUT2tZ0mtvQMqCtrrg0aozG6R/UpKI/u0wFcBYVtBT9/4jKdhP/U0J3HaxCQyeDvE0fc9MFmnB3kYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jNiiHeowp4QIN58QKMzrpmSJ3PKeqVw5FetScOIicQ=;
 b=B/eG9V0WHIZvQ4TKtTc2dMUgS1mYta6sStr0S+HBAOaupg66cGaX7WFDWeysgfQKlCsFg+/aNWcHgrfnPf9qVvXYBK91+39sk3lZrpKmo5OZqIUdGSmaHoS2Usbi9Gpv1QgWaJFnsqo+Ebez74upS43uZsIPEpAgDkEa4sIBnKVF67Te7CIHVuiPg7VOxeT1uhzrvJm0NCwwNuiG1e85ivpnJOTqvirqrWHmutjkZTXuoRniC/KKCrmmPlIofqEPyJEPgTyzwyMeOQzijPlgZUbjRVfTAbGl8OdkHSXsYZ3BcXn+OINtKbf8qk8JIHdJCbDJcMzW6mFJjuJk58LRDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jNiiHeowp4QIN58QKMzrpmSJ3PKeqVw5FetScOIicQ=;
 b=WxgM5xJ0oA4doSQwqUmalnnSKT3jILxS22wHYjXBlMbjnKq4Sgz+5BLZO6NnUhVJS5igFxNNdiDL4v//NeNQa9dFnj05q+iTazot5SwqoKXdiiL1OG+Yf1lZBE/DqfwkfE5JbWdRsQXPW5Lne+6EqSQZkw/r3yH2k+FMehjzYvw=
Received: from BN9PR03CA0671.namprd03.prod.outlook.com (2603:10b6:408:10e::16)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 14:11:51 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::82) by BN9PR03CA0671.outlook.office365.com
 (2603:10b6:408:10e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 14:11:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 14:11:50 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 09:11:50 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 01/17] drm/amdgpu: add UAPI to support profiler
Date: Tue, 26 May 2026 10:11:13 -0400
Message-ID: <20260526141129.592886-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e78906a-972c-4bf7-6e97-08debb30bb29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|11063799006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 3VcGw1B/bY5PODxYEZEWrr/v0Tro5uw6uv8pbLaanKiO1IlGu9vnMF4rRYXv/AVNxDVDweszpXzCy4YnJKCFgyR4wlYaUG+yrPXILA/Sj9o6hQ/qVSYprYqTVIkSDnIjvasa/vEw5Mjs10gIFcJghjW3L88wX2ZreKM5nrSY7QoqQNZYZ9lnjCIR2T2dvjr4tuweyk2D2d5zK88v9ikvVllX6vDmUtu94pcw/VzPGMnFpEnNWJqmkypn0hzIRY8ed1w9zQkDnAFPzPK9HYx0t9VOqxO8ynTfjzGEWGfwYbgrm2EU+y1zLsmsO0CCFB5YUwwknRr06xchchHS32roy12XCps2H/hcbadYMzISHOW8tXmzLQE4yHSj9ze5N+h/gil6awgzivYnGkFPNu05fe2LPs4jiIc7QOFlcPcqFV9FlkC33dU5Q9qKOq1I6+4kxjsf8O477v4kBuLT9vHersadOP8qznkmMnCYBT0Z7cIfXms6zb3+v9whbTeAVUWnfrXI6OOkHKNuDwi0ry/5Dnf7AvwyjKCVMvTAayNUDmhcAHIZp8TK9IPlaBt0jUn3Ac/Au894BET3N05xTSKUQM+dZiaBxI0YgHQB2nTNajJqQmgO3vjD7/LxVvYTlwHnBMyBIWmzx6l6L5q9s2g2dQsVrRTijA/ULrsXPF449GA06/nGlGJiw+I1HJvF1+FPc/CNuchmOC+uHzR3n5M5YGyk2oL47nQrX9Rm9Gp1Too=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(11063799006)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8Jz4qaIU2yPBxGVYfCic27+QPwj35oHIkr0UAHMmkBdlrSPUAdwJbH48J61M0zJEepoqF6DcQGDZEFsSe5x7I2dVS1XT81YGXIFGqAtQ8uFhdPlvaQqz2yduoBqc37WgZ/1xu+u3ZTa0j5+DYN28vvJXgFRvhTcSTEf9S/ivhOVr0UCNvg0uxa4YDn6E5r5nIogREYrxXoXl7I7kq+1A9CPkxAKhhGYqcnmA7FuqRYQ3lHVo96XhC3Q9wcYlnh+yIsHC4oFffg8tDmt55iIc8aUpCHeRuVI1HK8rIQ9CITmQxfF9hO3NklXWh8rtlZQtPIf9Exn+fZofvJapndaJtSpYX33b4PiavB9fRI0zWzvzBFQmbRtcQ21mTd7X+Dm1oVsvAqvvuOudXt6vwuWGt7qadsNCRmHJcdaj8sNAUrIY1OQwDzppqlkFibiyJwI3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:11:50.5644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e78906a-972c-4bf7-6e97-08debb30bb29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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

introduce a new DRM ioctl DRM_AMDGPU_PROFILER as a unified
entry point for GPU hardware profiling features. The ioctl
takes a drm_amdgpu_profiler_args structure which carries an
operation code and a per-operation payload union.

The initial operation defined is AMDGPU_PROFILER_VERSION, which
allows user space to query the profiler UAPI version. The version
field encodes the major version in the upper 16 bits and the minor
version in the lower 16 bits.

Subsequent patches will extend this ioctl to dispatch sub-operations
for SPM (Stream Performance Monitor) and PCS (PC Sampling) profiling.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <Bing.Ma@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index c60633d09567..e66e190b5865 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -59,6 +59,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_WAIT		0x18
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 #define DRM_AMDGPU_CWSR 0x20
+#define DRM_AMDGPU_PROFILER			0x21
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -82,6 +83,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 #define DRM_IOCTL_AMDGPU_CWSR \
 	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
+#define DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
 
 /**
  * DOC: memory domains
@@ -1789,6 +1791,21 @@ union drm_amdgpu_cwsr {
 #define AMDGPU_FAMILY_GC_11_5_4			154 /* GC 11.5.4 */
 #define AMDGPU_FAMILY_GC_12_0_0			152 /* GC 12.0.0 */
 
+/*
+ * Supported Profiler Operations
+ */
+enum drm_amdgpu_profiler_ops {
+	AMDGPU_PROFILER_VERSION = 0,
+};
+
+struct drm_amdgpu_profiler_args {
+	__u32 op;				/* drm_amdgpu_profiler_ops */
+	__u32 pad;
+	union {
+		__u32 version;		/* lower 16 bit: minor. higher 16 bit: major */
+	};
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.34.1

