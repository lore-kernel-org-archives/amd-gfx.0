Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB621EF06EA
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Feb 2026 16:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF12410E302;
	Sun,  8 Feb 2026 16:43:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2LG7a2+d";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA66810E301
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Feb 2026 16:43:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJIrTyRGRCLS8MsyQoJD5826u0cus0IeQMizLs2tQXkMCUhCVMA5peno/D/8RLMS8/cONe7rsuSoUMkESaDwu4VhK/zA53+fX/NsXkspvIUGjWhevguhXrIO4FCiYhwO1IfDBCDI6pve+9CRi2h1Vps3j5qu5aGWbFF/X5UIweDAfMTt5nEBRnfKJBv2T+B/3BXvc7ZR4fzkoPW48v0M2LZKqwC5xyLkIT4WVnyNGH/nh2fe2Ohv1YQ7hdb+4AsMDnln2JthErGxGtCBEM7g+dEHQOPsC+NfV/p9OsN8Sn2ZKoV3bB05Fce/31YKNqnO4RQBqR+04pttClJ3gyEu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ie4GkpUjkhXRBZ7XG0HgV/L33NxKDpRnpxMup79EPhM=;
 b=yZnflhpZiA0UMnjAxTYLyb7+x0U77G4Rgfkupl8Jaw7IqUPvFws0S5xwG+pSwdWPh5esKgYvFH3/L44StqPermuVpYvhkh7vSrYdYEMnBgq3KMpzeX6+76w6MyI0ErOdzeDVOR05LU6zdKWI0Y2zjAII4K6a+lmFakfCkYT3qhtawv48Mhj305TtKNvgRXaY/68XXVUTivAPAjSIMqX1Lg7Gih0GB/YHhTvXVztQPmh9dNGRC58PN/K10rZh38uh654jsifrD8cdibEu7u0CiyuZjgDEu5TMnytawfVDAD/FxXXvr4nqC/uqmcVU/W/lMhttmr6CHB/yToG3rTKWYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ie4GkpUjkhXRBZ7XG0HgV/L33NxKDpRnpxMup79EPhM=;
 b=2LG7a2+d/zSPsNO9p6gZwx8nqvjArMQspVJKlAhTAG4ZVK8ol1tALN6xoI3JYJDLSCu1H5tBzzsvyikHA1leALCC7bDzDM4rmV0tDdOVC7oCK/oGp8fsVenSCehh3EEviNh3FP5ri9P8ZJNvDb3XxgGXc0QNDb7/zoYEIF9rbmo=
Received: from SJ0PR05CA0167.namprd05.prod.outlook.com (2603:10b6:a03:339::22)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Sun, 8 Feb
 2026 16:43:43 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::58) by SJ0PR05CA0167.outlook.office365.com
 (2603:10b6:a03:339::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Sun,
 8 Feb 2026 16:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 16:43:42 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 8 Feb 2026 10:43:39 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
CC: <Yifan1.Zhang@amd.com>
Subject: [PATCH v2 05/13] drm/amdkfd: add kgd control interface for ptl
Date: Mon, 9 Feb 2026 00:42:04 +0800
Message-ID: <c4e1b98bb3517871ae2b4f909f54e280c0b54d6a.1770568163.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SA0PR12MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: f1798471-2078-4df4-3a32-08de67313844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/Qy1sKxaWe+WMk13mYce/R1F1Pv2duDHKos5zMJ/pmdkT2Ic8GmdgYrt+6T8?=
 =?us-ascii?Q?5/60fc83uoJLhPDVD8sZZ7WtZXqqch17M3J1lberuU0PjUYCqIimNo1RIeID?=
 =?us-ascii?Q?LyISEiMS7EeodrB0293fuxELYydtGD2IXf/Y05AvOyKJR8zkAPsIdrxXp73V?=
 =?us-ascii?Q?TpYO7f9M60ZjO20LROBmR/WijIG2HHzeV93F7t1K71fX9/MCsyxnGRStHbR0?=
 =?us-ascii?Q?G+RR+pQIYiq+b2n+Bf2R8a4ai73/g+WMCqvXeYqGALRhAOqyCpBZtRJHEeXs?=
 =?us-ascii?Q?x0cp1HPG/1/ljEu50l1yV8Mg+jVutw1IMzqsLiu/KBVXzpa7MkZGTj1I5+Nz?=
 =?us-ascii?Q?NZvowneKbVjinM1h8FjxzWgGJNNMYiD8oRk4UvTv6/cX+GdR3TedW09WGSbS?=
 =?us-ascii?Q?Xl+SzPw5T1kt5+SOWXBmzcqLifSjxnEMD1HCa5ZhDKjpuq74nfTlCYEC2I8E?=
 =?us-ascii?Q?FXj8EnWqZ8tGx9VCeN8XN1ruWiKma28xoMU1gRdHGsUGjg1da7pJg5moZuOw?=
 =?us-ascii?Q?gu1qphWpjmoiTtB82rTxTt85cRlv6qoKpsm7fB7/HB2ftf6LdBY9HK9k0NOp?=
 =?us-ascii?Q?cUDXwtfk5oSzZsqezMBpzctNXSfJJ/IZFBaauP0hYwTlKeteW78Io8TMFwPd?=
 =?us-ascii?Q?otiuBWtRE2YxGv4s9d+UHp+xbaZcPm4XKCW5dlNqXhuf6GxfdiGkH0TmvjkF?=
 =?us-ascii?Q?C6LIvboWVaqlAk4ZcwFzcIAQPC8hjbJghyFMXFsX+X8fdxP7Gosn0Iajhukc?=
 =?us-ascii?Q?G8pd/vagn32NmiGTOAq/MUxx8uupYRuCIZysis+U5kZ03ACDHwCQ+j+nt4tQ?=
 =?us-ascii?Q?qH3Wxp3AwdvBqNCHvN1GkHpmMrqvxyGsXEJiS8hZLnSYWWRgjoGR7QaugWcO?=
 =?us-ascii?Q?0+A/pk0HWGWmowSkZmclHuZ3efjiX3EPzHTV2Og5Fi9qjl0Maybk3yXZFRsI?=
 =?us-ascii?Q?MHlZ6zbc+lcZd+EFVVDR8aoQ87XvhsZxLxeIZDdzfju1MjkoCja+dZBb6Vb0?=
 =?us-ascii?Q?zFvPR6jKCaJv1/mE6AuhUY+QK3Gvjg8F5lF5fEMSmiw40EBwriU6+Oa6Sods?=
 =?us-ascii?Q?dS+8gkKMr2KeYSihknFh2qYAWCOBkRw9oGrTK+/FVZjmSo9lWc6/gCQcDJuX?=
 =?us-ascii?Q?81hT9/BtqoJ0uUQz6VpPdnzyYMII+pX1Tu+NDyEyg3yo5PpSitTC3JPM0hp5?=
 =?us-ascii?Q?7y0mK7P08ISMvJvWUvlRe5Pubfl+YOgxW4bUomEBaMpT5hxHoAWG0l6qRRDo?=
 =?us-ascii?Q?PBdhaLpklh6mWjPSBPpXT2iJKdrJxNAkpw+fqms+eeBjDjQksAxPIVOWbGMK?=
 =?us-ascii?Q?YeW7/sEo15GzTv2wG61x6u5G6gEUENHEJyCmaBF6GsYvrkjvRTF88Gs1MP2v?=
 =?us-ascii?Q?8NYXtYyYDBlPnjTYxwFxi0y1WlNjL1OoK7mbuHEYuJ2EI+svi7lV/+GWmseM?=
 =?us-ascii?Q?lBitu1cotoxk6lmwHGsgxqCsLFQzHx+qfD6JH2X1UdPv0rG/2J/EQwdV0U11?=
 =?us-ascii?Q?IR/yEX9X15aWfNuUrkzZhzHLE605Vx9dJGayATxeI4ZFi8VW68YUOM2pbJA7?=
 =?us-ascii?Q?+K4oPtqosyVBL6IS5p1v/DR1FSLhfd55zvktkXGm16D76hCVPa8CpAjgkChv?=
 =?us-ascii?Q?oqtUpMSgJjl7O9YKZBgVebyzCRo3jAnFXL+QLHIzvqq3yW3p5Q/biY52VeNX?=
 =?us-ascii?Q?0bcxKg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pyOQoRAxTKIQPRikUh1JqP6WgDwiuu9pcrcXEk9pQWnLnZIrXuP3TxnfpVXC6nMdWngOipNPLCaFOo7c+oF/P7zhXZu2121KvOxwnCdBUMBAo1yoXdB3ou9QjGUXFsabr41VGt5YUgLolazp04ipng7LgfiTPAITdzGxXxv9v5F6GNeB0qxcx/5HSTn85OMb/DRuZdOZ6CM3TZ2XLjOb5PNnmYAEZu152tC+75EtX7UdbMfJxrbvFSFMxvuM4lPz1vk0jiiZf4BiqJYg95CqipBaD5UG0xnn5wPh6JiZnVeUTib9EWCQBpSkJBb2UAEGEC0KKTqJNkLko954oHG0SGFxhz+9220XlSD7AnklbIGKPXWwoI5vX8ho/uVf8s6N8BmpwdFpIWhwHbng8O53VSj1+E8x07Xefs5s6Yq2dTxSNmzjn9vqRrt8FkVbpIgQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:43:42.7151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1798471-2078-4df4-3a32-08de67313844
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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

Add kgd->ptl_ctrl() callback so KFD can query/enable/disable
PTL state through the PSP performance monitor interface.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c | 13 ++++++++++++-
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h     |  5 +++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 89a45a9218f3..74eb57332e07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -520,6 +520,16 @@ static uint32_t kgd_gfx_v9_4_3_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
 	return is_active ? doorbell_off >> 2 : 0;
 }
 
+static uint32_t kgd_v9_4_3_ptl_ctrl(struct amdgpu_device *adev,
+				uint32_t cmd,
+				uint32_t *ptl_state,
+				enum amdgpu_ptl_fmt *fmt1,
+				enum amdgpu_ptl_fmt *fmt2)
+{
+	return amdgpu_ptl_perf_monitor_ctrl(adev, cmd,
+			ptl_state, fmt1, fmt2);
+}
+
 const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_4_3_set_pasid_vmid_mapping,
@@ -555,5 +565,6 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 	.clear_address_watch = kgd_gfx_v9_4_3_clear_address_watch,
 	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
 	.hqd_reset = kgd_gfx_v9_hqd_reset,
-	.hqd_sdma_get_doorbell = kgd_gfx_v9_4_3_hqd_sdma_get_doorbell
+	.hqd_sdma_get_doorbell = kgd_gfx_v9_4_3_hqd_sdma_get_doorbell,
+	.ptl_ctrl = kgd_v9_4_3_ptl_ctrl
 };
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 6df5afb242ae..44e225e097d0 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -334,6 +334,11 @@ struct kfd2kgd_calls {
 			      uint32_t inst, unsigned int utimeout);
 	uint32_t (*hqd_sdma_get_doorbell)(struct amdgpu_device *adev,
 					  int engine, int queue);
+	uint32_t (*ptl_ctrl)(struct amdgpu_device *adev,
+			     uint32_t cmd,
+			     uint32_t *ptl_state,
+			     enum amdgpu_ptl_fmt *fmt1,
+			     enum amdgpu_ptl_fmt *fmt2);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.34.1

