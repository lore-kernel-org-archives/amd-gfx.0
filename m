Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA23606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LQ4/fBSf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEE1310F83A;
	Tue, 17 Nov 2026 17:16:25 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF9210F837
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHAiwiPa5j7lXNebZRussRMRjTDDGrrrjxjdNlbiq0hiIFKhVwJ3Qsqthkappoh2aEKU+3Fx5foNfDUPB6hnerk0e2M09ftNVdpaQ6MtjYqfcyisUWWeiNoZ25IKsSzMQ6SR0Zzhs08XXOU3KJjeHD2fqCMu/Qf0M7BTh86eYBrrXj+Ps1l6EXMnH2QSCcPO8O4Xj59MReHfyccc4h9keZ3QvcIuR+I4nTXapGKxql7d/HSVmYzQwF+r2LQYyx+Wyvnyda1yFYrhOCQNRwKAG/OLULoLBdYgCcEgBOh4CNJ1VaJcCXbXNWReQYAc2OfDfvOof148aN8hwLx3orsHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eL627CBjbDA/g7hPdOpyQoPjwwB0wWcrSoF7zYScuqM=;
 b=rt/Yc/qF98uftknlBQ0BqO4PHYV6s2s7BFAWxx0xym13H23ruolJN3/7m803zkvhmtwLxn0TzyIosSSGz9tPLc8OfdISE4nqTs2BRQhiefrs9jAGVjDKsLBjPWXOhYiY6kvHvOcQC29Ge3sqcVf/2VWQNXwHVXcHLc2rYudRZaTIx9heUVg7gVBOh3a5cU0+VNkDujA7dsvm+2arxU7EHzkDKpQVTMPkzlYFxZ0F43oFcULVytNI5w9VM1DVKRJcsOXZGV8w9GyIjXH0JaQsJ0ROIyXIXTeWM7NmQj78PlgVgtrjlLYsR8aN0Sbjrpef2F4KRPZChlvhktOt/h/R5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eL627CBjbDA/g7hPdOpyQoPjwwB0wWcrSoF7zYScuqM=;
 b=LQ4/fBSfjFtLqtwsGBOEfr4gg1BU0DQ9lrKDKnu0oSl6XWgvfRiYYce1cPI1U6aW+FgugWJN2xua0DUpj3uoU/BsrXj5/mPReH6F+1iYZLomYC3QCOlJc/0OP1Eqkm6C0laEivt1r11BxOvHbgY5GlPzAbvF6MBi3wBbGBbTbvs=
Received: from PH7P221CA0086.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::13)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Tue, 17 Nov 2026 17:15:19 +0000
Received: from PH3PEPF00059617.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::4f) by PH7P221CA0086.outlook.office365.com
 (2603:10b6:510:328::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 17 Nov 2026 17:15:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF00059617.mail.protection.outlook.com (10.167.243.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:15:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:15:01 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:15:01 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:14:53 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <alvin.lee2@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 17/33] drm/amd/display: Fix G7 P-state aperture addresses
Date: Tue, 17 Nov 2026 05:50:54 +0800
Message-ID: <20261116215641.2800595-18-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059617:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ed2a2c-0d20-4d71-6453-08df44ce5aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|22082099003|18002099003|11063799006|56012099006|261021121427099003|10067099003|261021123027099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: OabAop043siuxrB2+3XZBp17r0PKpZ+Riznf66ZHdirvOfiSdA/WuiBYwbJrilKXu5kUYBEwVXz12wlGl4QFLVpCB6FqQoEO50GG0LZQN3MK/xOlv+1YtnKItQuMXNpxfRg725QlC2uvKEZvj3ymMw+aIf12BAE/V//ml8KBbh0O+UBVJjfdgLnS8qz0XU/aspnY2LbDd5kqVbtM8csyV1LtZ0u1T/68Ahl4PZ12faNJRnmr7FUGfUJEPkcQe0Kze9bLzAhNLHDQ5mue3AQQcF9NRfTfIeA6WBBwUj1ridfWx+U6wbQQ1rtlOl4N+pP/268Uuqw0VmWdE8xaps83P96NLikOmxUKb/BC0kpuJsgBTH1i6M64FDx7BjKzJTF0qp34cEwUkB1MqxJ4pLdJZw4nwQiBzcB13yyDbS30CWdgo668laY3b7fUMcUr1By7f4Jd2a+Dnqovj5GYjifSVboSJfypkj+J/vlPNBkM72wcUEzxEKAUYn9NNVXapzX41zvFl5QyfwZe4dMyYodCteJt6B2SWt2Kd0loDbPXLYGSYFAYI20646n6i6y4M3q/yeALBBYx/HMggq56J1U/zCu9JOAWrGKe3Hw10i16ZZnFM+DsNocJyGviVU3oIpRS+w5SUYk4aoBkxvZSsqi9/T7Bs5VagCoRDdq2MDBxzrQNigozctn15ANkyZBbNRMtYqaLE/qvJ3bJRXWLb3WwWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(261021121427099003)(10067099003)(261021123027099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lllRhxviGaOcWdZt+alkkAeBRKPBBPmyYUKWY4/+bkq+0CooikUJqBGBuKvEMgTSq74h5ryzXMX9biTiU1m7mzeBJEtofopUPpqUUisNEa+yCSCjkgQLLrxvRRwYNUl9OsygXgMdZmIOTHHaMa8kgkDWMFV/3qdffmmmzaPIX8f+Rfy2N8d6H4eJzBWL4pztTjlIVlk/Vx3wUxbA3SLitIwpE70/fUTbPptrHNjPgMKTv7bJEqP6kbwSddSA05+NX2VPOgNwjC2foV/hv+axnqMEPJjY52UwFtnJlo+8FFJM7jiJvlM4CSvvSyNuoaV8LhOMXFydEFG062HIUwYLnKv1IWEd2tZ042GvoQLa+9XG/dqlm07qmvQsSJQ0ExhYbr6TrZQTDgpcjr0Zd4b37DH+LyHgRBxtwR7AVNt7N5fCBLQvX07usZHYtNNjT5Fi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:15:18.8608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ed2a2c-0d20-4d71-6453-08df44ce5aef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059617.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
On GMC v13, fb_start can differ from vram_start. Use vram_start when
translating firmware aperture addresses to MC addresses.

Cc: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index ebd8130cb04d..b251351fdfec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -213,7 +213,7 @@ dm_get_alt_channel_pstate_switch_aperture(struct amdgpu_device *adev,
 
 		/* DML2 requires the reserved-region base in MC address space. */
 		aperture_mc_bases[i] = apertures[i].reserved_region_start +
-			adev->gmc.fb_start - adev->vm_manager.vram_base_offset;
+			adev->gmc.vram_start - adev->vm_manager.vram_base_offset;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(region_ids); i++) {
-- 
2.43.0

