Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AF0E7718C
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9379610F073;
	Fri, 20 Dec 2024 21:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D+uTEb/g";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0127010F06F
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mB3dKHqS8MAzdW+jC6FtFlQbZizVLpxPnzprUY+z3aZRgzCbnauAJ2DDXDGHIAJqIMu1bnbdHD5r+QSs8XDVRoSt9RjNAN/O5uANBchw61YpEeCeyNZfTRkVdoeFyE25Sw3oitUWii28ixwiz8gIeYcjuYcrt6e+CuBmiW6OxZFfiJ4iMfwfSozxyi/OMJKIKG/IoP8vxhsqp2Ld9qDQNW7wduMmbUsAPWr71v4xNjltm3HYAJsBqRdgEdraqJmtNHCwicp4GjHUcNHO4Zc/TJXtXTXBGFWpl+p7r9FeJptnrFgOG+ZDJQjQ7haz6kpzcaLafRvpKYD/cX4IG2Y6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/u4uMYhpOfjCgfF7nciyXoIXGIasAxGhiVVq8ZPsAg=;
 b=CC5ChwuY2Fetxggl1ZTnBp3jLKP+x+SaguEBw7pMODVYGYjeAbFT0C2+TLDjBeCsNZiikkSocotZzipfWAhpam5xZplvCUF3gvMNpcOTgy4Rvf6iXD9WJj+6Jmpq5jsA6w0vyxNfvI0X2++ObT0XURBTOpbHEcfW4VD0TokMqlnCApVi3kbBRn+h3Z9MEGBxWmdD090AmuxZRm0Pjq6Jx21CwY9bj0xP18c0wd03gitIjMpORAbiawy1nwtr+879NUSbs8PWQEfBGSCAoTTXG/6SHp9MJ7qTLhxrh/KPFDV9Uh9X6r/NV7Jz3+2inOqsvSMzzeuNkVyNOwRZ/3wihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/u4uMYhpOfjCgfF7nciyXoIXGIasAxGhiVVq8ZPsAg=;
 b=D+uTEb/gGblYizSsTSDe69U7Ei5aRVRtDBlCEAB1Y6PDfIRnnrpsTMZTYLY4OUC2cvs6VjQcdxQz6Ebq1g6hBx1TMsVYHzQt0HZrcdlnjki2idzA+Ogao5oJUNHzpSOaL8EM6zX3VnVqu+9GsbsufPSU1qR0MvLLRyWRJ0Faywg=
Received: from BY5PR20CA0001.namprd20.prod.outlook.com (2603:10b6:a03:1f4::14)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 21:51:10 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::7d) by BY5PR20CA0001.outlook.office365.com
 (2603:10b6:a03:1f4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Fri,
 20 Dec 2024 21:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:09 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:08 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:51:08 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 11/28] drm/amd/display: Add guards around MAX/MIN
Date: Fri, 20 Dec 2024 16:48:38 -0500
Message-ID: <20241220214855.2608618-12-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6c4046-fd07-41b1-b2e3-08dd21406a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vJcqH3WbtPlZkFePp1c0wnnivWFvu+1ifPk7DBW4j3x92BEe1T6EZjYLXg9i?=
 =?us-ascii?Q?bT6UTvNID1Xwk7iBKIty/2LLS7iYUZDN+sXTiPZFaLGDm0YSEqAoWqj8634q?=
 =?us-ascii?Q?wHamFVTrABlALfFUcd/MOHYGQFr9PMAtlXGeA+efOInS0GhVLcNOlDhP5zoY?=
 =?us-ascii?Q?HDTSkoxg1s0Bn26rXINFC0rj+r2RPnsAxyL4moPO6SBG+5OIWl+OuM5ELJSp?=
 =?us-ascii?Q?5RbPLwWoESfv5yTEAdPPgOmVaBkClpo5of2NSbDfLBCdeVSz2kPjJODEiFgk?=
 =?us-ascii?Q?NKDmiy6OcHHplVhnQASVi6UuGy8nCuR6oB7YzISWZOk7YPq+2bTgVcL6XicE?=
 =?us-ascii?Q?yoThk4MxgWi7oVr6C3dp749/kgTFDfWMPetBcHaKkOUt720SwGypGmgfyY/N?=
 =?us-ascii?Q?f1lkwyvRuuAlIB/N+06rHp3lNOv96dpxE/8BCkPFSIwHp0F6h5QD19Qrb34G?=
 =?us-ascii?Q?qBhr+ymFFcFsm5lABxciytsH+73ThLa/1sgyxbphGqOdpDc83kAGWvbbYWXE?=
 =?us-ascii?Q?P/f7I01ygojhtk3l5ybAX3Wg8h2QDgzcN2uHd/9twzCN7q+Cfi3aJ3ow8ta8?=
 =?us-ascii?Q?UG8UK3umz1gaNhFdvSvh0+37x2vlGtfq2k8ph7cQpl1zJF7SjJyrefbAIUU4?=
 =?us-ascii?Q?T2yQLPkqcyJcbA4i+cS8J/Dnz896w5KPzY2z1R/K86LSgzjaa4GKW4Ynu+lV?=
 =?us-ascii?Q?6E+0NvoRlBpIHS8riKwBSOkPdm9N019FJXloLxX9nuimkist3dp0MHp7BKB/?=
 =?us-ascii?Q?VMHWJKJrj81ygkXtms9V+b/bWHJ4UJ2UaJmr8noxu4jiAgfJG8ogbxLC/s9b?=
 =?us-ascii?Q?qE5eYsw+chMl2FWo4M+j1zHslE7mXIWFXuKAyMWf8py3RNaNfT0DSNlRfEAI?=
 =?us-ascii?Q?GiBc6mgNnnMeZNDaKo9beX3SWCa+JVWamNT6rU5CBdQOreohrRtt144FC3LN?=
 =?us-ascii?Q?4fjhioX896vNmRfmUo9q9dckC8INO3wueBTW3a8JjkQatF87X4Tg2jDFEUjA?=
 =?us-ascii?Q?gx/Se71aa4PQmdlbZmWaHfevkt2l1anaRL5rqktCAo1087zTooZcRwXRM/4f?=
 =?us-ascii?Q?d4JuZIsnF227Xo/jCo+0eg382YvSs1tVu7XYEDIl9od7q0PoeO6mj0aJLajd?=
 =?us-ascii?Q?PoqMORQJ/7XqaQknAmpURpTnljAXl5lFWyTEAcl8BGWuhBDjtY9TBYj/2Rr4?=
 =?us-ascii?Q?r61VXpm5ZaT+HQOLVCn08YXxP0+RBpf+dKDi80se/7YCUzt2tddicVMSO72N?=
 =?us-ascii?Q?5B7yuspXyYaegr96RUssU6pVtR1Ddepg3Sgyv3eHe/uTjuAl9KNc7KUr3jRh?=
 =?us-ascii?Q?AX20u8zh0zYE2kRlzz5uKPO3UB1S7LVTjcjCLTNJZpEL5WuBnj8E04eI4BUe?=
 =?us-ascii?Q?2GR/8IWbXeBtlE02WY8/3oEdU6y4uEk3lv0fsEZPgLkgBfERp6Ydjv3ti1hI?=
 =?us-ascii?Q?6byyrYb9FQ/RiQSSnNhakFICT8iXibJQsy0prCUgaFDwbHiXOcGo9Hvcoidq?=
 =?us-ascii?Q?yrrXOib/a/rGvVE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:09.8090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6c4046-fd07-41b1-b2e3-08dd21406a32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

MAX/MIN macros maybe defined already, hence add a guard around them to
prevent errors that complain about redefinition like:

drivers/gpu/drm/amd/amdgpu/../dal-dev/modules/hdcp/hdcp_ddc.c:31: error: "MIN" redefined [-Werror]
   31 | #define MIN(a, b) ((a) < (b) ? (a) : (b))
      |
In file included from ./include/linux/kernel.h:28,
                 from ./include/linux/cpumask.h:11,
                 from ./include/linux/smp.h:13,
                 from ./include/linux/lockdep.h:14,
                 from ./include/linux/spinlock.h:63,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:37,
                 from drivers/gpu/drm/amd/amdgpu/../display/modules/inc/mod_hdcp.h:29,
                 from drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp.h:29,
                 from drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_ddc.c:29:
./include/linux/minmax.h:329: note: this is the location of the previous definition
  329 | #define MIN(a,b) __cmp(min,a,b)
      |
cc1: all warnings being treated as errors

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 701b7e4f2920..e8134c47fe0d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -37,6 +37,8 @@
 #define DC_LOGGER dc->ctx->logger
 #ifndef MIN
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
+#endif
+#ifndef MAX
 #define MAX(x, y) ((x > y) ? x : y)
 #endif
 
-- 
2.34.1

