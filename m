Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24171CDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E66010E478;
	Mon, 22 Jun 2026 04:42:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X3/zXWkU";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BD2510E477
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:42:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcPkdb9PLUX4AbQsCGn09u/IFTjqokI5QlKid+A0MXf7DAqsvnTtiajs2EGPGGUerESO/64R3hPrfrgvuRuijyY+B5icA+oowEfLFTPGstrelxc/P8nP0wbAPWSYHr4gV00tlwhE9HhJpFp3gH1aARibSVobMViBOoo0GqMOaAzizJek9DcPY3rb/WFo7bD29M698Z6+45seUQcEO9kwfhyjg4rAxYhRPWfICmReJ3M5ipsQoOsV8FSxwaGVnhOgRullVFohSA+Yv6fzDQL3rAPZAeitKB+oCvBZQmU+dHgaf6SxcQwg63PBAX5lq+JRCXlTvrxb0LEQru8PRo0TLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naNDdB/+/wf5P/vcSMCIvfWR8+vDbh4hhOC7FFT63LE=;
 b=lxRCfZflxK2NFYJ3LHudaTOUj3eahGLRblui/9PljJTaR57fbPOp03DgbLzfuammOiMwexfaIe22byDoZ2NxPCNc/0+/wNInqJkJaCw6a7gMcIagvpfhlxsXFDcEp23bBblLt3nNRKkc+c3pIigVsvlEdrB6gqs+GsfE0D5npl7mHtmaohoBt/UzSD7b5aIZKtjU7BxRUp/fnhoqQgudPp4lSlV2naI50MJQ1qohHCXtqf9CMCiLQPe3gSIl0+bHCFOu9BT3PnSRLezO3ZuyI5yeJnCNcoW8OrpVJzl6/YYIDDHgJebD7YII1Z0XI1Z1sAq1EUzTU7ezLpnlOdJ0mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naNDdB/+/wf5P/vcSMCIvfWR8+vDbh4hhOC7FFT63LE=;
 b=X3/zXWkUdpLFUWY+rdj/5Mhq4ggVtKro5MYo8LNtay1mJT3xTf+qUoFTvijRN8ihj7usDldQhskwjTNZeVSf96MTFxeNdyk2G3R70ym6phk9fEmHa85vmNsHFtg+fwTYK+8qnvdk9FB2vnz9pxszbZyUA3E3izywwlAg8CeBXac=
Received: from MN2PR08CA0028.namprd08.prod.outlook.com (2603:10b6:208:239::33)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 04:42:47 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::10) by MN2PR08CA0028.outlook.office365.com
 (2603:10b6:208:239::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 04:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:42:47 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:45 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 24/48] drm/amdgpu: add the macro definition of
 UMC_V12_0_PER_CHANNEL_OFFSET
Date: Mon, 22 Jun 2026 12:40:13 +0800
Message-ID: <7de9fbd6b23b72870bd3e60d124287c6eea6d816.1782103074.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6560a3-327c-42e3-9909-08ded018b585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LIJ789BbVNoT8sF95FHy09z8jrOtUZsDt6vMoqTQxqYaUxjHWf8DwDTvtUPZkg2mbLC1HrRWjEkwZNzia4eWr2xHeJqqGU3DcQoHujxD52+e+qM5xIXiHGKkWd91WpMhvShDHQvotgxzPidtDhrMmzHjbYGD2tZIeNgzkUEHHaub+s25zLWcTVWBx5qh5otF6jejiSUDlW68fFbm++2l+TznVZQHiykv5UQtaq0VEDL4lpR6HWlHi8rI6pDoNEKKh9ju9pgTtGGyWwFRA1vSU/Ti6j7H/YLO+EZ9qoUTT6erjeqsYcvYPFJTJpahXqxxmbScdvF5bEXcexL5Gp1urmEMsSCF2UkWF2rloQ+8hpHQ966w2JZq9zKXFGmgkZ4Yyb8HcjGGGqyAU/qh1NxDhN0lvzdFseuzQ422r3VGxDkecn3u6QhN4VFNZDEdJ1EA2JQAqc71otaDC+PEn3slsRgBwTMEA8u4F9o2oJnog4AyXccyMUgYUCIv+DsUHazDltpZnLpf8V+EfNXxiSVNMv4sLZBQA2MkYgY8WmtUFWRZsPxWDc+b4nUJwJbmR7aeFqoSRyXSHsVKUBiREJhu+hpzM5wgh8UqUoCbfFmZnb7F3GUQ20NnpYPt4whsMyiuZBB280NiL7rmEpzlr0BrqehB00B6z3rTPbe5xDuSP4tj3a5h3foDttMa+lx7FRZE5pxLy7fMwGfrvF4AId1Q8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ET2A+SCdw+1tASDDGWXdFoyFfvdYsG7S2eTGkg4BWj/ZNDhl6AzDA80xPZyj+G+SBkU0TKctdjLkwshZaNSlspfH73MCGZp2HxVlf1FjdArsLjsjTeyyHBEKKjetdv+aEi9rdWHU6CAk0406Zo18WbAHFpIbdRZp6T0OaEWr91OSg5d4Si4vD9rzXlWJF7wAMjaMxXHNY9KpiuOB1iNALabm0YOXSl4O4ucZQZJh1jNZ7TDUYtVyKhfyuf62egsZaUDxoZFecWhUgpwUWPn7nztJKF4h/Lo7z1JH0D28nLiFz03c6LY30hUfBhQjtSi9hhQlblgshknB69+bbk6EkWA1zAJK5ZbGnzbeRqmiGXRZ2jZYsNSWvFOwfgIg7qdQ+P2qICO4cMoYHk1vd1zw886XoNwi3hfy7pPltqUkao+jmlaruRGOVk7LeUriQhgS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:42:47.5976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6560a3-327c-42e3-9909-08ded018b585
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895
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

Add the macro definition of UMC_V12_0_PER_CHANNEL_OFFSET for subsequent
use.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h
index 8a35ad856165..650b5f1f22f7 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h
@@ -290,6 +290,8 @@
 /* R13 bit shift should be considered, double the number */
 #define UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL (UMC_V12_0_NA_MAP_PA_NUM * 2)
 
+/* UMC register per channel offset */
+#define UMC_V12_0_PER_CHANNEL_OFFSET    0x400
 
 /* C2, C3, C4, R13, four MCA bits are looped in page retirement */
 #define UMC_V12_0_RETIRE_LOOP_BITS 4
-- 
2.34.1

