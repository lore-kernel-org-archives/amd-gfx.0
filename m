Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89D0CCF2D8
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 01:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D6DF10E165;
	Mon, 19 Oct 2026 01:47:42 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D9A010E165
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 01:47:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddGYn9mAGp/hcq/lUopIVHcRRdAl1DCfZiBXMFGSElD/oLXuRA3c6EioEnWRE1ljNtTRdYYkR3xUqjl+BWrcdX9gz29NVcmOMyvgvOFwnRA3BXaa7Vi/9qPabMF3DzCXj/j9NQityBkfLs4WhkDLzhukeR2MQFZIycidQQMoaTVDM0kAoQ1UpnXj3JvDMkwP7QqLRS8otjvT6HeHARx5Q95yWHBqTlAl26YRghCgE/SWzre1CSRc/FOxC4GBYugPZVwP7a8D/KSNsS1W/9xwPkDBENJcEzJKxxK9TaXWfPktbH22RJP9V4XtbxaVyjs1jr+NeXruBMSC6lkUaWz2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ycCUCBwdfSUhLwcjOEn+FC7sxyuNhQob83Umf1fW7U=;
 b=Wjsc8hJBEIRncMaZGa6ZoIDhJ0Uhb2zcJcWFBUq3AX6tdPQk2XMof6HkYaRwejye/+8Fz5qvEldAk3G1lEu9qCL5zg1KUemPu1Mq5Sjc7MmQUrLKII69D3AZD9YA4pbUXQox6XhvwH33m85CkdFXtQbJFfLZPdlbXQ9PH/ifKUkNKdB7IKqLlcnGd3WX+E3js2j5P8ZQQhnGtK4Efd6y1FlN/LG9o7ffcqD1/WXDH8Gc61YQnlxwpAOuRdDFYE1KWXd0hDZ3MJdOimf8ZDfmjQmnZHKkyo7dvMVV9qtp3KjJUQgMUK3Ys1wFGq62ZxRzau/ZuPbf0t1iQMd4Hp/JiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ycCUCBwdfSUhLwcjOEn+FC7sxyuNhQob83Umf1fW7U=;
 b=XdPYkeaLDowy4h0eOVANDc41E3k9WLc1qZ/H9DA5Ic5SFOvtSMx75xs/WA4UZ5SslUIF5db8u9ZxX85lGBjTUX5Ac9MMl9mpwbGwsFmaBRPiZ3UBeA1fphnheMu3+O0iiImqRvmVJ5/m1uCfaMJR7jlU6fSySY9CT05AWOGtbF0=
Received: from MW4PR03CA0356.namprd03.prod.outlook.com (2603:10b6:303:dc::31)
 by IA3PR12MB497638.namprd12.prod.outlook.com (2603:10b6:208:626::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Mon, 19 Oct
 2026 01:47:15 +0000
Received: from MW2PEPF00014677.namprd04.prod.outlook.com
 (2603:10b6:303:dc:cafe::7e) by MW4PR03CA0356.outlook.office365.com
 (2603:10b6:303:dc::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 01:47:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW2PEPF00014677.mail.protection.outlook.com (10.167.249.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 01:47:14 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 18 Oct
 2026 20:47:06 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 18 Oct 2026 20:47:04 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 "Jesse Zhang" <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: keep PRT mappings off the VM state lists again
Date: Mon, 19 Oct 2026 09:46:51 +0800
Message-ID: <20261019014711.1486757-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014677:EE_|IA3PR12MB497638:EE_
X-MS-Office365-Filtering-Correlation-Id: 09215fd2-a37f-4e21-7e34-08df2d82e663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: X+zFarwlvKvnhxFmai8lyOjVQMYwfQNqtTo41eSNqBC3k72p1DyOUPgpPRVkIxAOPQQkvWMdvU8lSjTE0S3VCQKMU7sHLQwE7+U532jvuxn6o9erHk4jmhyKERqGCRrvdZ6dBWalMikKQHfcaq+UBpDXzYovysulKesr1BMCSmnsp/A/kikJUhJTzQW+zhIMLD5FyH+cySvvQRjenZg72/BaIg2l2kcZ67UKyHCbdnBx8uizu1vFahPL1e/75RT2GS0qN9BWfVnsuJswk7w2BD/ZH1/397zvOvRO40TPj6W6zBiIkrlU9bdCr0aIAiyjNWeIHVDQVjI5Po0c0ZNX1FXsUL84aDhpDKmQ2HQS7hbWAiUmAL+fB4TqEQo8ybSQf+z86fUc/hDOpmQNTjEONhJDJttq+Q/HVqg3UO9X4BX9awd3J0JLHW4PpNQtcEdE/I7bDlMdOKuBAmuy8dzVrhQ9hKLUKPPhMPCkX9sn1PsYJqMPPTKV3dfQacAzcRamB5XExYiC202SOVfj142s+UeY8MXhsz/4qBLNNUgSq1BcNJmh/YGa5tdebDDeek3Iai6txsluRT4VEaGiIGIUHCqt5NinX+XQvBctMuVuOHTobFoaBEctF0KtXHm7rUx02aNsHry9/FNNMYZ4oEzpnz6r2f/46W4cS7uYvvjRs+j2FvTonxEHmJhc8hEGU73NeSXb5D6aCgVWCCNdOAdC4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YfTCc3nQsbI++2V+6zPOfbt8QDOG6aZgU4nhSN1NeRH+iJGIGD7LILrqw2W3hR30m714tvEdUoshVHgiLAFrCFORb9KL/Lfb66CRjni4jaktR8xElrxjfOuN5fZWidLBFbv64Ktlto9ALJPxgyHd8z0k81mNiXWlARsgAoBlIadkt67xyWSZGRHKPWNGyo9gZs1l9iML/dQytp5qFJlsCsFnLb6zXxmttoYKU4bqPCfhrQIPyLgNQ+XqkZ7iz3UB+yWKn8m42Xo/DdnlleC/FLtHLwbECq3rKB5ymF2Glfbl9FuzvUjWmyCd0qISHfIMAHQItUW/pv8fE6JVD6uKOYUo/ijTxczLUe0g0MpXzXTJ30hM9MFZL73XZH1KB7QuDwhMCeZLAM1JiFzvADvVVnbujJqgKTbb/isx6frR/K3HaIbt+rVZyqj/jFWwZSt8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 01:47:14.2814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09215fd2-a37f-4e21-7e34-08df2d82e663
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF00014677.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB497638
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

Since amdgpu_vm_bo_insert_map() moves all BOs to needs_update, it moves
the PRT bo_va, which has no BO, there as well. amdgpu_vm_bo_update()
leaves it there, so the next amdgpu_vm_handle_moved() dereferences the
NULL BO.

A CS after mapping a PRT range:

  BUG: kernel NULL pointer dereference, address: 0000000000000158
  RIP: 0010:amdgpu_vm_handle_moved+0x17a/0x200 [amdgpu]
   amdgpu_cs_ioctl+0x1579/0x2510 [amdgpu]

Only move bo_vas with a BO to needs_update.

Fixes: 3a1abd9743c2 ("drm/amdgpu: fix amdgpu_vm_bo_insert_map to let bo gets update")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c79a673d9d2e..9d6f93d4ff38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1832,7 +1832,8 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
 	if (mapping->flags & AMDGPU_VM_PAGE_PRT)
 		amdgpu_vm_prt_get(adev);
 
-	if (!bo_va->base.moved)
+	/* PRT mappings have no BO and are kept off the state lists */
+	if (bo_va->base.bo && !bo_va->base.moved)
 		amdgpu_vm_bo_needs_update(&bo_va->base);
 
 	trace_amdgpu_vm_bo_map(bo_va, mapping);
-- 
2.50.1

