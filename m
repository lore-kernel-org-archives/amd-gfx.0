Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3D8EF06E1
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Feb 2026 16:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C061210E301;
	Sun,  8 Feb 2026 16:43:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B/GGSIuR";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010064.outbound.protection.outlook.com
 [52.101.193.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C087910E23E
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Feb 2026 16:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnTugC06AGth6g3yBEEEr+x4dWZvXBaztW7hr31KeSJLhsSC4mBJkj/XcSAW8TbAxerju7mzUwCmxfFd9oFZqDXjNywRKQbIsiJKclv81Mx05XJvcgpm9TY0xOHV42UuWt8pQSBYATN1XsuVJW09sYcrOT2JhxgU6sFFz0NpNwQj9cvrqbHZ7sZjyWPqjl5I1wY/xFdGZZPGadb5/jNIF3mqBSC+ebLZ7Ty3rhhFEgI0BH98O3ICGQqxYK6wgAn5TIkFLLIP1ZAFheDk75T3uAV+SRJH2gRJIoQphQTeN7xq87qUjPBRZPhXxiFJMsbJf+DvG6lajUSrl4HMAERx2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+SKdcr90onzAQsKdNrHuF2YKj8Rp3NCORjl45G8p14=;
 b=DhoN33amPLoQHZakRtHvSBGe5BKCMelgJV4gzNMYKZHhyY48h/30WCyzMD4YXjcDSeWtpbtPXvCKJbYAVBkeRNVrueJS3SsKFwAS0AXKlet3OOEUBkU1jj7Eu1qq446b8OJ3WJB5EFo0lqfdhbEfdPZ5ZisAfFbHv3NKOlP3nV1bJPU/hb94G/ZRPQj9Huy04nZ/daz2MRWu/FNAQhO7Gi9t6ODgdmvM7b/41lRcht8v1gHUaLhX7B6ezZW4c0vsOCxOiXI1VoDbXKNcY+t5C9dxg81XvFE7Tesamx1fVsTuZRxQtVfmiudG+9Bjl8vEVeGNVCiwvqaiN3Tf0tAG8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+SKdcr90onzAQsKdNrHuF2YKj8Rp3NCORjl45G8p14=;
 b=B/GGSIuRydKxqpZHvmGwGW4r6jV5hfxhCbicJyl5wfuz3qNqENbTf/6/ZaIz/vS0RoJYjI8oaLVPmEZutdWHHuz87+EXozKxRgaGRvqmaTkSQonU0BoKLkw8Ta1rmgAagGhXC9Be//NazbXb9zmp+gi7IHKkFnIurdsibVwTCoQ=
Received: from SJ0PR03CA0229.namprd03.prod.outlook.com (2603:10b6:a03:39f::24)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 16:43:49 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::e7) by SJ0PR03CA0229.outlook.office365.com
 (2603:10b6:a03:39f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 16:43:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 16:43:48 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 8 Feb 2026 10:43:47 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
CC: <Yifan1.Zhang@amd.com>
Subject: [PATCH v2 11/13] drm/amdgpu: add amdgpu.ptl module parameter for PTL
 control
Date: Mon, 9 Feb 2026 00:42:10 +0800
Message-ID: <2e0d794ed1886c649929d17b5334e23a9bfa1fd2.1770568163.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: cb434947-e985-4d74-4593-08de67313bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?24VUEViV+/+R4InxLbtQYNQ36B8HqnjnL9CF3AqgodvNYhOWdHmpB9qGkIpe?=
 =?us-ascii?Q?Hg9MaLTycFxWL/eSCjCGQaF/lOQVWzXAomIu20Wr/78A1PYzpgL56kvlwLDN?=
 =?us-ascii?Q?NO3vjVxk+xVhzS8Ad9qZUN063SVAfbVsZoWfGM0lcVxtB380OwlviDis2I0y?=
 =?us-ascii?Q?dpI4rdXchYynqA5GznNHfXkjXOlQ4qtRVhBv97s6Bf/Mbrs57lwFIDMnha6t?=
 =?us-ascii?Q?9hdYFjTht0puDVMo7nx62P3wmkO1wLnxvIUQzzkqH7TerbGXAJLe0Xgj7GGM?=
 =?us-ascii?Q?3k0q8Fj4OpVO+kisujQEy5cp8OMfe4EniSyTxMVLBsNoIDV+R1pHmj39GT6X?=
 =?us-ascii?Q?SlI5xGGQi7VC0J/BP+BNDZ9nlrxA9IuEwliZUfQRYo8XAypjfqxGJJW9rrq8?=
 =?us-ascii?Q?9JI7cfaazaCuACPbSse3e3hsazvMurwF63InRnim8Shj/UCqAlugpLqpAI9T?=
 =?us-ascii?Q?zaUcBXlL4ZyrngT8HM/dSykgsHGTn2p79cgVED/oHJetqIEyzNuPz82hoiND?=
 =?us-ascii?Q?qN2bvV0xZNBmgoLRwfsb+SOZ0Il2RZ4nJlpM4deY9ba80/lfwFRiX9SrNuyr?=
 =?us-ascii?Q?EIogBAaIGJjMU/BxZy7kIbxnGMPgOhK1BIHScr3ISWFoOE/eWj+UoXJIJh4r?=
 =?us-ascii?Q?5IcHfcgLKsaPlwzInj49vmoV47N90dXs7/jejbxB6s/8DPh6YVitMQrf7rKV?=
 =?us-ascii?Q?MfDKnL9KLCRq+GrL4zi8qaN/+E8MJj/x2kaaXRf0hiey1sJSXTCga6TAgQBQ?=
 =?us-ascii?Q?qLeMi+oNL4TPNTtOsmnm7E6dIYvBwuFPT55pr8C2J5HQmHEAfs6xtYrDaiwm?=
 =?us-ascii?Q?qhYfVylFIW4qyau2Qhs4wgwXF07rmegogviFI/yMGaWvGJdqQmwQ1kc/PJAq?=
 =?us-ascii?Q?5QFr7ITFPacc7MZ7nAigWiu03VmdIWL4ZzTrijmiXf1kh+VmGOt7ZIY+ymgc?=
 =?us-ascii?Q?TMUFiVnsg/OsCEhV9uoxthq39Mkoo1rQP+UNFS1VmX3JaFNckyOzoCzUlRuX?=
 =?us-ascii?Q?hEBgabKKU1tO2BGO4PNyz06yTmfTOOF+MruZbOpoOxBwoy9diraf6rusVwtL?=
 =?us-ascii?Q?Kptp5HcsBWI8b0xKUjZIu1zQYFqLbssniLivCyOeXDIS9E5h0ocQaYPrVxF1?=
 =?us-ascii?Q?3iZ8PNbzH/87LIdqv9sfxRPIcRD+z9mG9LR3uSI8DI3q03odTsJE4HgV7NHO?=
 =?us-ascii?Q?m9NKWnSg+VIkBX4OUCKxGRKNioK44hLQIna7u+Qd1ltBmrSUFof8psyty0/3?=
 =?us-ascii?Q?8vKSpnInenOaSSROaKRlBW6SoS3neWUxUJ+cwltQlKdCBD55aoYSfJwOFnj8?=
 =?us-ascii?Q?IjqfJxDvpw0khFjrHOkmffwA0bFZrBif1LyAuHkJJ+v6lulfE2BvKnn8DeuN?=
 =?us-ascii?Q?Itf+XZaemixnVaaqLtP8Jaf5sxJ4VufN6bxhnyxdrjT5R3mQX8LSZFH/VMg2?=
 =?us-ascii?Q?L861GWqglZ2/jRXtRlN5bB4eTj8K1JH7gm9PcagAFMWXpiNQyz7/FeHcHmKJ?=
 =?us-ascii?Q?3KrY9CKEp1aXXwX9xgZgF/OW3iDlftCUsmCxI5+F8Ag9g37N10fawkaeNrX3?=
 =?us-ascii?Q?X0vuEIl6qvxl48Qq/pVzYOFeImmLYQmzuVHQab4EfX7CsPmpJvGz3qHWJWu0?=
 =?us-ascii?Q?q0+XcBSZij/tB2jD50hWbrO6kS0Uf1qMVYoJt7DtqFeYNRN8I22fC7kcWDjI?=
 =?us-ascii?Q?WT7gVQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OrlQfXWhsZBNwSAgytt15d6Yb+vTYw1PabjI/3tnfIgXHgqHB0ifEofcC1tB5a9lrDDYrCWP68QVIJm77lSHEjs3IJ0TH/kr3BsThpTvDx2pbgQ40samPSmmBynCca7TfRjq4s7BwOzja29UcLCqfiOLo/q3fugg7wJyvBEEXGi3WZYi84EeU+9mJwqVYt5qog+2EYENT0vg0fe9vhbqCKSz7ZzgWgc6Pf3/8FoHZpt1ekJnT41xX1d3hl/YKL4phsD+yRWThVROgnsLSDo/hITD/U0VX2WLqjRmYyngTHnPXSCFi0QETcorEXpwjO0L0zjgEeNxLPhn0qMl2S+e8dcvrarUE1ubsOD5uiN6Plz+EbvQTmzT2OYE4HL+jlIDXJXElpqhJwKnuLD/OiC5MRXq/AERO9BbaCdRuGBbHkUgs8pFKEIkh+R1I6zhilQE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:43:48.9144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb434947-e985-4d74-4593-08de67313bf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318
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

Add a new kernel module parameter 'amdgpu.ptl' to allow
users to enable or disable PTL feature at driver loading time.

Parameter values:
  *) 0 or -1: disable PTL (default)
  *) 1: enable PTL
  *) 2: permanently disable PTL

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 13 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 12 ++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 28 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/include/amdgpu_ptl.h |  1 +
 5 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index af4042387f3b..23c58361b4d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -268,6 +268,7 @@ extern int amdgpu_rebar;
 
 extern int amdgpu_wbrf;
 extern int amdgpu_user_queue;
+extern int amdgpu_ptl;
 
 extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 95d26f086d54..482fa222292e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -248,6 +248,7 @@ int amdgpu_umsch_mm_fwlog;
 int amdgpu_rebar = -1; /* auto */
 int amdgpu_user_queue = -1;
 uint amdgpu_hdmi_hpd_debounce_delay_ms;
+int amdgpu_ptl = -1; /* auto */
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
@@ -1134,6 +1135,18 @@ module_param_named(user_queue, amdgpu_user_queue, int, 0444);
 MODULE_PARM_DESC(hdmi_hpd_debounce_delay_ms, "HDMI HPD disconnect debounce delay in milliseconds (0 to disable (by default), 1500 is common)");
 module_param_named(hdmi_hpd_debounce_delay_ms, amdgpu_hdmi_hpd_debounce_delay_ms, uint, 0644);
 
+/**
+ * DOC: ptl (int)
+ * Enable PTL feature at boot time. Possible values:
+ *
+ * - -1 = auto (ASIC specific default)
+ * -  0 = disable PTL (default)
+ * -  1 = enable PTL
+ * -  2 = permanently disable PTL (cannot be re-enabled at runtime)
+ */
+MODULE_PARM_DESC(ptl, "Enable PTL (-1 = auto, 0 = disable (default), 1 = enable, 2 = permanently disable)");
+module_param_named(ptl, amdgpu_ptl, int, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 413a7e44048c..dfda694aefe4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1296,6 +1296,9 @@ int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_code,
 	psp = &adev->psp;
 	ptl = &psp->ptl;
 
+	if (ptl->permanently_disabled && *ptl_state == 1)
+		return 0;
+
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4) ||
 			psp->sos.fw_version < 0x0036081a)
 		return -EOPNOTSUPP;
@@ -1380,6 +1383,12 @@ static ssize_t ptl_enable_store(struct device *dev,
 		return -EINVAL;
 	}
 
+	/* Block enable when permanently disabled */
+	if (ptl->permanently_disabled) {
+		mutex_unlock(&ptl->mutex);
+		return -EPERM;
+	}
+
 	fmt1 = ptl->fmt1;
 	fmt2 = ptl->fmt2;
 	ptl_state = enable ? 1 : 0;
@@ -1411,6 +1420,9 @@ static ssize_t ptl_enable_show(struct device *dev, struct device_attribute *attr
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct amdgpu_ptl *ptl = &adev->psp.ptl;
 
+	if (ptl->permanently_disabled)
+		return sysfs_emit(buf, "permanently disabled\n");
+
 	return sysfs_emit(buf, "%s\n", ptl->enabled ? "enabled" : "disabled");
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 4e04eba9879a..93bd2e06fa14 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2401,6 +2401,32 @@ static int gfx_v9_4_3_perf_monitor_ptl_init(struct amdgpu_device *adev, bool ena
 	return 0;
 }
 
+static int gfx_v9_4_3_ptl_hw_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ptl *ptl = &adev->psp.ptl;
+	bool enable;
+
+	switch (amdgpu_ptl) {
+	case 1:
+		enable = true;
+		break;
+	case 2:
+		/* Permanently disabled - cannot be re-enabled */
+		enable = false;
+		ptl->permanently_disabled = true;
+		break;
+	case -1:
+	case 0:
+	default:
+		enable = false;
+		break;
+	}
+
+	gfx_v9_4_3_perf_monitor_ptl_init(adev, enable ? 1 : 0);
+
+	return 0;
+}
+
 static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -2583,7 +2609,7 @@ static int gfx_v9_4_3_late_init(struct amdgpu_ip_block *ip_block)
 	    adev->gfx.ras->enable_watchdog_timer)
 		adev->gfx.ras->enable_watchdog_timer(adev);
 
-	gfx_v9_4_3_perf_monitor_ptl_init(adev, true);
+	gfx_v9_4_3_ptl_hw_init(adev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/include/amdgpu_ptl.h b/drivers/gpu/drm/amd/include/amdgpu_ptl.h
index 875277312d30..609b48b24367 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_ptl.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_ptl.h
@@ -44,6 +44,7 @@ struct amdgpu_ptl {
 	enum amdgpu_ptl_fmt		fmt2;
 	bool				enabled;
 	bool				hw_supported;
+	bool				permanently_disabled;
 	/* PTL disable reference counting */
 	atomic_t			disable_ref;
 	struct mutex			mutex;
-- 
2.34.1

