Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D99C5B56A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 14:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76BEE10EC2D;
	Tue, 11 Aug 2026 14:16:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WKBwDY5r";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011021.outbound.protection.outlook.com
 [40.93.194.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 478EC10E72A
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 14:15:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dN6iO3kEYf61nC9Qii0c+vLNmzpBoCNps3K/O6FNPaGWiqqjq7nbIhDIDrvuIi63N8j4kDCe1e4QI7qc2bAJXrhn0yj1jIS4MLEDOCbAt02XwYL/xz36Rvzih+UvY7uVVniLW5DCvEna59C2kufiXD9WBEWT3DgfEjl4ByBuZZ4bF4kPAJgyC2ZzZDEzUK+L3D9QN4FzYuuXw62lV9UrP9fn1MI0UgG/DXNc1MRyecDMpXtzO2IQU2gmQJv6RiWRYeTklcDj9Le+tOrYVoxTz6OIWD/dy9CAW3OlY7pmuKhwU3AcP3no7+rUGrcusv2tJYr9q8Hp9LWA7yCwp+x7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wwu12KZnzBk3vYgH/lxW3+NrE8+qmtMEsrhCSUjmgj4=;
 b=Y4Kf1kMQ5R4mKrUV/IYCkSzx+0Ijupt41rbMBkB0+5vSOK9nG+UF1SXM7KmxG+4YiXh4n/OqTCjOihCC6J0Ugsz/MIQYG79Qg9bSJjjrCCtDJfYcPr79PnYhXaglPCtDfZcUvWEAUgFyOMsYJk5z5CEX63TKzq0sKaKZYhmSfmYSAevswZYEhXd/h+aM+f9YaroHlBysT7sIXVdqvohgGEEcXy13iWQWDMBhg2iw8XYfXyOhgW80tPh3CS2IJOXOItmc2S1di57S+b3rceagQF7UQGwLtjEhzV5P6Ba47rQgiXq1WhxuzFFKrzLi0aFE+R0fbse855/tYvq+D6u7fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wwu12KZnzBk3vYgH/lxW3+NrE8+qmtMEsrhCSUjmgj4=;
 b=WKBwDY5rsehCgRgeNIOpKXGtDnYL22E8Z0HTare5db30jpAMYn3K75NrQ5DECYq4HJq5TM5lQHbbxPXibIuL9iTAmCxHVyjhMQsWIOE5aLgNT8mIc8YXfT/9fY+nysAIHqIcpf4ZmCs9tW/qgDXrs+CXiunBlCSvOyGMmmBZqu8=
Received: from BN0PR04CA0020.namprd04.prod.outlook.com (2603:10b6:408:ee::25)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 14:15:53 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:408:ee:cafe::2c) by BN0PR04CA0020.outlook.office365.com
 (2603:10b6:408:ee::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 14:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 14:15:52 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 09:15:40 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>, <yogesh.mohanmarimuthu@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH] drm/amdgpu: Bump version for userq timeline syncobj fixes
Date: Tue, 11 Aug 2026 16:14:32 +0200
Message-ID: <20260811141431.555557-2-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: 35317ff9-75c1-456c-87d9-08def7b30d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: CZj3S4dfC+Qp8BasoWAlvW+HXPZsKETubuepwdqjTRn+qWRsyiNl+0Q5SCHxI4Co711fTCJ0rnAv/NiFPh9VRow0dcMfnmvp4kgMiiApRXgA99WBygsY++wGxUpRIeJr+6yC/9FHiboj1LeZlmO+onqJEESSakLBLx4HJGvfNtHmFQjvg6/PVfdtP9byrTzYyoHSFvb3Y1+PRmGy9gOV/XPMTdjCRVeh/IWTgDJX9Wn6XPusA/X62TAtLkGLDaXbErOpbo2KD2D9+KOVuZ1ThpeTtIjPYjersD8oXaYMC9Xgacz/ErPRJtu+XELdUAzXMtO2Qc9u6x9bgqLCenOY1SEr+k+Tbk8SWwZYYKE6Byq/CvwufJ22UrzcZLFyiypLMEesmEQsGUOB0QQpuRI99jydC8dh/+D4fFJxD4RrTqudQl8pdMejP0LHXJBk329C7r+gBejhEFKeugFxrTe5T33EhODV3L5rB8Pl0wNsN1QQUtSdUsZ2afM2/qOCpEU8qd+xE+y/CTNfdI4Jgumov0NsRKW8QjBH0jLEf7RQhRAoH8YdiImHCd5kJj8H3sxNq/e/TPESQoM5elqxUlQx6dCD6EfLS6gB6WLQPKpHajupDeRPYoJ71nYLFcGICcFOtbW8jzOknF17AWlg17LVAIrKhRegVVXUpHsOMQ/Mjv6W3ghlUMLtHgwyL836bjycnpq0yAtwAhV11bVa3pxjSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KvINNuggCNfTjgO5tWuERPy1vTw0JxNhUGYA8fyZRUNCBzovgwGR6CSWpUvxhJXbQXAKAxwmIfGVe1OYmL24g9Z1Dc+DYxUMG+sX/BwsFMTxv3I1uMWhvA5OOsRIKuVJhQYUiUMsipqcpyo4CrPvRphPTONw2FfqN0/wLUQjGgXPpMoQ8PTsSFCjQKnc3MEgdFdbpU9nwwEtdFCX3ykb5DlFhjwW5eNq66i4Zo+YHjL4elbBsCTrknovnhZC2xdvpiPLf3P0tQxfhtrSCNgAGoZcs0zr0/NOpzlsJH3oQxClD1WhJV101RVWsoO+hLq4H3Shho49+ZnADavfFsYAvYpc4X5nznNPVckT4Pka6gzQBcGjMquxf/0q7NNdMXp8Z7Nru/7+t1sXUUGtH+pnsjTMcysT6DKmOEegTIbkAInevBC5gzBdc4vAFXlIhdYk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 14:15:52.4099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35317ff9-75c1-456c-87d9-08def7b30d1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040
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

Contains fix for userq waiting on timeline syncobjs and adds
userq support for signaling timeline syncobjs.

Cc: yogesh.mohanmarimuthu@amd.com
Cc: pierre-eric.pelloux-prayer@amd.com
Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0ab380ca7e64..da36702a7468 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -126,9 +126,11 @@
  * - 3.62.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF & AMDGPU_IDS_FLAGS_MODE_PT
  * - 3.63.0 - GFX12 display DCC supports 256B max compressed block size
  * - 3.64.0 - Userq IP support query
+ * - 3.65.0 - Add userq timeline syncobj signaling support
+ *            Fix userq waiting on timeline syncobjs
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	64
+#define KMS_DRIVER_MINOR	65
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
-- 
2.43.0

