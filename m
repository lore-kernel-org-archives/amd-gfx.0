Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF688EF06E1
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Feb 2026 16:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B60910E128;
	Sun,  8 Feb 2026 16:43:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qJnlzku0";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011030.outbound.protection.outlook.com
 [40.93.194.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B07010E128
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Feb 2026 16:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9lVdsqplQDFs5pL6snNYMReMOxEukLQp+1sE3Tv8Th1vtqvQsKGA2v2S6r1pZzrg9HgqXv03KYpF+rBNX/hs5unrbfUGjDcDjQgqT+e+0ryboKNnb+7SBnkFkEJn5Gh01Cj92Sa0x14czTKxLZ6+OYSGM0kU6XGZYOiq1GT45H//WaYOudkcQAyvi0qZlszVdAuSpnYVwTUV5QAuorhn4cMxYi7/3tAZX4ZJKUTAs/r8Bayi0JtKAAEOy+1J9ZCFVeCOS/DtOmnlrgt22YBS/KWYVoB3UgzY6FBFJNUcGopg1e5ywuoAksxb4s+MY87xkHjS5ax4ih/IZ5sN/ZrSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nd6S7d+6sG1Dwf+hy5klTJVlYdVI6y+wPDdyK2UbboA=;
 b=a9VshKAtV/IcwDAUJ0WC0z7x75hNoG+YxfzBjURusyZAsj+/WX3nPEM3Obp6TrsQ+LirhlbtdmBcTb0FZ/26pss7XfR1AtjSZHKVk9mz0myZeoRuqSGv+sUZe934smTJptT1Y0oWnK3ngF8aMg4BijLXCi40/WXbMNuDl/DxKKfoAI1XKEoNzuLJX60StcUQw8Kjnj4rywtNkcjZenP8YsTANbph77H9OGZrhncPFTcr6sqSglefUGpAW9hlF3jWOAf3ej7eWapHx7NnBnRlvyEg3DADndd6mmDGEnCjilyNms5qjOMSQaiJZtZ8hGR5t2z0+vNjMlu7r5rVkgNWyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nd6S7d+6sG1Dwf+hy5klTJVlYdVI6y+wPDdyK2UbboA=;
 b=qJnlzku0kLx7q4DQZple01OSSRXi4ZBoUuY6lA3Fv4kBIJPpZL6BXU1yV8OwBN/CJMwpepAKSdXw5WMqBQFThF2jhM5f6wl0JY+Dh6Ku1yeOnNLDqMF30Y+p47PmtKYcapNhD+QNJhSdavxsueGJoB3NOch+ffRh1/ZlpTFQyXw=
Received: from SJ0PR05CA0173.namprd05.prod.outlook.com (2603:10b6:a03:339::28)
 by CH8PR12MB9792.namprd12.prod.outlook.com (2603:10b6:610:2b5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 16:43:38 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::ed) by SJ0PR05CA0173.outlook.office365.com
 (2603:10b6:a03:339::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.5 via Frontend Transport; Sun, 8
 Feb 2026 16:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 16:43:38 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 8 Feb 2026 10:43:34 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
CC: <Yifan1.Zhang@amd.com>
Subject: [PATCH v2 02/13] drm/amdgpu: add new performance monitor PSP
 interfaces
Date: Mon, 9 Feb 2026 00:42:01 +0800
Message-ID: <882c4c68bf48c25a30d8b613afe0852565a27713.1770568163.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|CH8PR12MB9792:EE_
X-MS-Office365-Filtering-Correlation-Id: 42117657-724c-4a4f-4cf4-08de6731359e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?orr8e/wsmrEMtDyylpOFCHCLgqtdmz3Ti4NWq61f5wrN51Ow9I9jsswsRsek?=
 =?us-ascii?Q?rksnc2W1UWu1j7C6gzngpHOeQUIAyL3LbmKZTIxAwCP3xorlDTJ6DzHe1FJM?=
 =?us-ascii?Q?BBHEusI4vaLDrIPUTg6Lca0/ouXhcKJagkvKDiZRuhdpcgF1yimmJqD/9le1?=
 =?us-ascii?Q?1O4psbDxVHz0upDKJXnlRH4sQhsrMMQ5Z+hHGPqApVaDirXvgal1cFPhPRS4?=
 =?us-ascii?Q?ObGX5Nbw8bSzgcP56ClWnoQsWHg3dnk2KYN6/2HWkAebaF+XcUa7pCAGoF+8?=
 =?us-ascii?Q?xd4iBKyROxDm7neGSGDm667ScvBhJyE/jPi8TOafx9SXrla1FtHYzBdYx1zO?=
 =?us-ascii?Q?UygbMgjfDbWpZ38ILHDugMhoXVcrbF/2hb3LKcWR6ux69KuE/ZmaM7JSVfTc?=
 =?us-ascii?Q?lxMUxWQeS11h9YBgoV8c5RFqBm7+jJjb7vAKietw4doloPvLDiIlmfwVcHrk?=
 =?us-ascii?Q?hUyEMQEQSckS7X0mYoVXnNBXUln3HuNSGD03Zz0/zGjtTTLNlspH2c9QcRGr?=
 =?us-ascii?Q?tN/+2Rturr1WgmMoDDsNhOVAICnjfpRlvHTkLvjsFnxfKZorQxwWzPw5haSi?=
 =?us-ascii?Q?V2Knlx6oJTjS1xc8tFcAA4U4xv931lHeMA5aEiiO1Lc860PK2MufKT9OU+zE?=
 =?us-ascii?Q?USx3HDj3y06DsrwMS+Rd8ozz90/sK6cGsuxSeewiL5eV5pOSz6tbnvnPBRhN?=
 =?us-ascii?Q?xRIxkIsmJxEEJboe+G212LZJg9RX6F+A2HxaWQ373Lu7E8rRZ/QxyUrvQVpU?=
 =?us-ascii?Q?MQIOT1vTYK7mIm/wtsCgEOPr79328nWxh7AGbib+ULOJ9gf0XTVYKyMksM34?=
 =?us-ascii?Q?sQ1ZXZT+ki7ssuU3DlgpnzpfxkyXkAA5mjzALJugJLzp7+I4FdvqdNxUjyZ7?=
 =?us-ascii?Q?6nNmqXemDDZMWMJy7l8QRNTmChrKyllup3tE+FDdOoAJ72UhW6uGZ7197pcx?=
 =?us-ascii?Q?ohPwZx2t7S43sWencDuteVOg8RuxwtZo7GiqtRqTtfUFK3DMxO7t1mSSiZ1O?=
 =?us-ascii?Q?WY9Y1QSxnJiK/wkZSYWhA+jNBnSMhmKEefhLZE7jQY0tdQVJw6c8/pxJAHcK?=
 =?us-ascii?Q?n91uPJ4NxCd9fLITLWheSJ8jb16BUsLZWIrtThRlkbMSVR+ZHjFpsSXxscEi?=
 =?us-ascii?Q?sxXP+nl9jPy3BG4a4vqnUbO8sHIZO+5DIIHi+HxabJXyHVsnnmKQzUBISnTZ?=
 =?us-ascii?Q?YHrVqWJ6Q5aA4nCfsMELc8PLKObSxcODd3DM/pbbgbu36OFYHVb6SKBXtzE7?=
 =?us-ascii?Q?fENbVTyxegMJVeoaHs9CqKrk9Bf29E7xV0SX/1bPLwSERILArkTuGXjzEVWA?=
 =?us-ascii?Q?Fu+E7Li9hJNj+Zy+70rC0Rjrro42AmZe2TtGfG0oJz9GURRx+X4K1BbQBP+O?=
 =?us-ascii?Q?5WDZpUAhsBfF7tuIcoIi/9H5bbjw8pvc54Ft28QunTMxUB7oOepAKjTm6KOf?=
 =?us-ascii?Q?OGJMa8gM9vWg0R5NVJ67JqAt8o3rMeaTUe8ZlkMkyr12rgVHFxOktw8zd8zW?=
 =?us-ascii?Q?vaCS2AOEEDph3UizePfG6ar0kKtL7CyvHS9EXdVkKamw18VVSQ75yqBXpl/S?=
 =?us-ascii?Q?59HaXKUQm2k+kUoXHMhA/RmVsJ4cZpZ9jy7HR7he3yHSlrJPfC+pnzqqZCi5?=
 =?us-ascii?Q?qof6g45GosbdOmbhpTbqzZER2EQbUu9mms4Q+68Ai1pbZNdhcfbi87TWBVXh?=
 =?us-ascii?Q?drM1Cw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g5jIX2+hENKim9d40AY9cKC9OfEeTCPJMmDTyPUUKZAVhE+OSKCXGdfEHeNWf719OnveL6BJle3h/aIthPebsp2iCefgqigJgxKuzujblRs3tDG0OYqX/FaNmbrEVTNXLpb0l1NEItGzh+Yco5M4+KAlmBg6zd1g6pkjwl7TzqhDSqk/9PV002Su1Z64/gHJTlpsfykb9iDUN077AmQbKkiAPLm+KEiNL04JVZe97tTk8Cr7/YKlMIsNLQKkATvGN/z2a6nWEkD5Zf+uuLyiEiB37+oqaD6P4R4Kw7ZF8S5CirFtkc31Wt2W2RGxlraOFK5ESjUpVvL5Awx79xSxqsnG51RL7Ua/bSSSXyslpRYJi06/JFZRqHOQBtVswvsCQfjXslzDaLz4bJwDFj1ZdZTAWquiM67PTZAepmDVPhTe6f8L8V0viAr89id4DNSX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:43:38.2729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42117657-724c-4a4f-4cf4-08de6731359e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9792
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

Introduce new psp interfaces and structures for performance
monitoring hardware control.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 17 +++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 79a49cba8d40..58f691db2e97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -359,6 +359,27 @@ struct spirom_bo {
 };
 #endif
 
+enum psp_ptl_cmd {
+	PSP_PTL_PERF_MON_QUERY = 0xA0000000,
+	PSP_PTL_PERF_MON_SET = 0xA0000001,
+};
+
+enum psp_ptl_format_type {
+	GFX_FTYPE_I8          = 0x00000000,
+	GFX_FTYPE_F16         = 0x00000001,
+	GFX_FTYPE_BF16        = 0x00000002,
+	GFX_FTYPE_F32         = 0x00000003,
+	GFX_FTYPE_F64         = 0x00000004,
+	GFX_FTYPE_INVALID     = 0xFFFFFFFF,
+};
+
+struct psp_ptl_perf_req {
+	enum psp_ptl_cmd req;
+	uint32_t ptl_state;
+	uint32_t pref_format1;
+	uint32_t pref_format2;
+};
+
 struct psp_context {
 	struct amdgpu_device		*adev;
 	struct psp_ring			km_ring;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index e8f768638fd5..ac34bac3c839 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -107,6 +107,7 @@ enum psp_gfx_cmd_id
     GFX_CMD_ID_CONFIG_SQ_PERFMON  = 0x00000046,   /* Config CGTT_SQ_CLK_CTRL */
     /* Dynamic memory partitioninig (NPS mode change)*/
     GFX_CMD_ID_FB_NPS_MODE        = 0x00000048,  /* Configure memory partitioning mode */
+    GFX_CMD_ID_PERF_HW            = 0x0000004C,   /* performance monitor */
     GFX_CMD_ID_FB_FW_RESERV_ADDR  = 0x00000050,  /* Query FW reservation addr */
     GFX_CMD_ID_FB_FW_RESERV_EXT_ADDR = 0x00000051,  /* Query FW reservation extended addr */
 };
@@ -373,6 +374,13 @@ struct psp_gfx_cmd_fb_memory_part {
 	uint32_t resvd;
 };
 
+struct psp_gfx_cmd_req_perf_hw {
+	uint32_t req;
+	uint32_t ptl_state;
+	uint32_t pref_format1;
+	uint32_t pref_format2;
+};
+
 /* All GFX ring buffer commands. */
 union psp_gfx_commands
 {
@@ -389,6 +397,7 @@ union psp_gfx_commands
     struct psp_gfx_cmd_sriov_spatial_part cmd_spatial_part;
     struct psp_gfx_cmd_config_sq_perfmon config_sq_perfmon;
     struct psp_gfx_cmd_fb_memory_part cmd_memory_part;
+    struct psp_gfx_cmd_req_perf_hw     cmd_req_perf_hw;
 };
 
 struct psp_gfx_uresp_reserved
@@ -415,12 +424,20 @@ struct psp_gfx_uresp_fw_reserve_info {
     uint32_t reserve_size;
 };
 
+struct psp_gfx_uresp_perf_hw {
+	uint32_t resp;
+	uint32_t ptl_state;
+	uint32_t pref_format1;
+	uint32_t pref_format2;
+};
+
 /* Union of command-specific responses for GPCOM ring. */
 union psp_gfx_uresp {
 	struct psp_gfx_uresp_reserved		reserved;
 	struct psp_gfx_uresp_bootcfg		boot_cfg;
 	struct psp_gfx_uresp_fwar_db_info	fwar_db_info;
 	struct psp_gfx_uresp_fw_reserve_info	fw_reserve_info;
+	struct psp_gfx_uresp_perf_hw		perf_hw_info;
 };
 
 /* Structure of GFX Response buffer.
-- 
2.34.1

