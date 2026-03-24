Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D02FEC118
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 21:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AA1610E0A4;
	Tue, 24 Mar 2026 21:20:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YEh/YiBk";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013041.outbound.protection.outlook.com
 [40.107.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20C9310E0A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 21:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efisnRcm78JyuJA//uF5Llwo348xF+aWulqMx4YLgje3L/5yo2VLvSZWoo6iWR3jq/9Ek/iHoBpzQSlfO391WE4BwgPHuSZwpz7gVNZcw4HPsXharivnoUafbAZJfcFTebLoHRHiacOmMR5c84lMdg1dTMcbW+8x2y4Tt75vQ3TiKkTm9nAvShpEX6FC+eJppMV/39eogkN1OS+iTCWlb0wSNjcO+0MrO80VPNgPQ4itj36oNQ4X3Sa67ndhKpnzWwkLCe5JQhMKbR4QbXwa91Uh5bt/b7yjHts3zZzlA7hBiowHJ/TBleZ7S8A8JqtKM+e7byoH2ZN5oK+xcbypoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CQ2YmvwAuzq+vC0OPx1Z5b6qUcF5KmQzAPEmp3FcDA=;
 b=PFpozWtrsl5m+OD1kPB3xo540QvDKWVtzVG8k6x23vta669cPlugm33EomnX4a2J1RASn/Hayn+B3+n0ok3aarleyxgFNE6iyEI379Bvey517GA0aOlqSWx6I+6fg7Om4CnegkPkfYCOG/cpm34ZdRbx8oTS7cmWj9iATPUgLci+bdSQVOM9btkRNjV19PsM+s9GrVSFuHLOA4CUjiN5B9+qQ+raRNxtwjF9DO9nhBD1BmBP+Hmp+rqifQe1YUYxooKtgFRPV7vkSAis9DKCougunZZWtVRrp0KYJzYHB+j+Gcx2v83ULePCaJSWJYMocJzpW+YJavtalM2xtbz9hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CQ2YmvwAuzq+vC0OPx1Z5b6qUcF5KmQzAPEmp3FcDA=;
 b=YEh/YiBkvhDeGsETVXpiZDoQyVkCSXaj6cNSapP8AK2YB4fzoxBQOKJzwkTDPmiT5D0lSRAuHhPMZnzu/LaHCXvJsIGOgqltn1g4abpIzGVq00Jvl1WUwl0rlmxaEPgqPWHFlylNi3DhBH90Xub9ELvplVG2dSTy1EMO7kmJeok=
Received: from SA0PR11CA0192.namprd11.prod.outlook.com (2603:10b6:806:1bc::17)
 by BL4PR12MB9724.namprd12.prod.outlook.com (2603:10b6:208:4ed::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Tue, 24 Mar
 2026 21:20:44 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::9b) by SA0PR11CA0192.outlook.office365.com
 (2603:10b6:806:1bc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 21:20:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 21:20:43 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 16:20:41 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <David.Francis@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2 01/17] drm/amdgpu: add UAPI to support profiler
Date: Tue, 24 Mar 2026 17:20:14 -0400
Message-ID: <20260324212030.822932-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324212030.822932-1-James.Zhu@amd.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|BL4PR12MB9724:EE_
X-MS-Office365-Filtering-Correlation-Id: d27018f8-b7f2-4581-6a95-08de89eb3567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: gUtyQYW8hhC914bUppcA+rRaWCuQoUq0AjX+zK/ZMm86qHEzTmY9tCrULKepAyEpD29vTlumxSQeAoXsOsEZQA0D02mZ3yX3D6r+kAxplxjenywI2jopVvoF12PBs4F6lJnbTP+Lc1muzI6vlxmXagIA7hKnb8nE9yVY+dcdF7hiY99A9IMc4x1DfeaG24c2dScB2l8iDBGWFza9PF4tqEKIkEKXYAEIX0oMHluVpOuPgWZFfZvK/KuuEGzBRJ8589lsihHblF+Mscl8MOFOut8PsZ13NAvPmq4+rEidc7LxxtuOGw6B9abNmw2wmlLXapbXqIpOilB6t0VTXkjrFSQImWXGxlwclnumaphG4SV5asUZ/IR/dfoi6viHUcdtj05ZHNF0uV5kg6PVRtS2Kl7Cvf2K0WiyDE8E57ZIdvQ6rnM6yF6iEIwdpXWoVRtJrdvQRzO2K0iFB24a83A4TKH4P9iAykSfmc7TYHUqS2dKi1T7q1T3CfPnH2LwqzgnTzXd6jArIwjnOrhQZ6IICbr9bnNApx1PM3Lmt4/DzKwmvps5/+9bxrGQq7NwWfFXczRsIy52q8U7sD/ZNWJf01mbf/1Ho83sWhkmKePoYA+pPu5iJJD4qB1kRprkyFYIdllgjBVcqkZFshhBIF4QolGqcb4wv/Z2D8paQ6XtdgXqgv+UQ2xdUUqJuLIaWaZHBX6uhKTonTa82blGeuscNol4ilBpVrvfLIzetvy9dmBf9DuhMKq8Q91D/GCEa6WPcxSRpjdMe1wIgrJLG/DYxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WHPusHO4bqQg0TS0r0Bm2w0aMsiBioj0lEFJNYQhqBXBCU1uilY76dRpzoE7jGfA1piFsNrukS8HFRVOA4mFznHDm1rSp9ppsVggxVpIgaegoXUw9b7sQeHCGlek+PEU2Xrq0giV4XuKd+r3BzyN8gxvOws9R66T9lSaKkaXmGwUQoB6D1ff/l1SdSa6No6GcRKJAGXa+CiQbAK/xNTCMhWoymFk28gvD1/oyXrXpmQYvuZUwliPNYt8QWxSyeHmigm8m4C+W1F3GMEA1eo2tRu5RJvGZMvO49RoK/hE+ews3WBSh8SYE+/f+a/E1AzuBt5QfJZOIlVXyiKPH96fIKIJaSqECVNuBnwIz2VwtOIEaYm1SwyDQrUyh6c/5pxYmtmGZV9/Tif8o50s1jihi3WAmBN5DMXtvJn3C25Z++ZDMF6mxaUgDXcm1ezL1fF0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:20:43.8861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d27018f8-b7f2-4581-6a95-08de89eb3567
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9724
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
---
 include/uapi/drm/amdgpu_drm.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 98528d81d3ec..2f9a5ddfe658 100644
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
@@ -1795,6 +1797,21 @@ struct drm_color_ctm_3x4 {
 	__u64 matrix[12];
 };
 
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

