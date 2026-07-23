Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5536C531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BABB10F1F6;
	Thu, 23 Jul 2026 20:20:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eC/0eT5H";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5042110F1F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9ZpgBgsBrGNVSG7eDTcdNMI4cOx6wQVjk5GGlR5jtPxIObF7nE9qHt2n+UW3EQ1DcU/QyH86gyVED1dY//GZL9rlAtsGKBRivgt9YaSF841P3tPQFX0L67IdN+b72K1h+eGt8l0bIWqqjBGyAkZb7aFZsa1+MwXQSeXGLthE3QhjWm16Q78Y6s6xOHltd65fBOpfVw6LjWcNkhpFqDVsEJZVmIBuZnkIO1BmrSJh5DM0Vs/1QCrmvpmo/BwimsANmT0uQSaxvyGe0s0vphfJKM/d3I5znDoZLXwZAwAKuUtjOswQjX0R5nlXOLaHnCK+UlHejuRu0lxwI7XlbvJfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmzXmbUT4Grr4dKjq6mO5djclsts5xsbdLuJkzavONw=;
 b=x0rJFz6AO7rnMb2y8pf8KD9CHgPHh6fAVzZP2bP3j3hbvC6sKQBa6WeC+7LXhbms1hXK0Yk96V7yYtZ5ClJksxLJe97CEXgiXWRS1tIfvmswiwWueW1Uc74BpG+/GaX0gTBtrs/X8v3DAIjfmiDQ8tED32HaxRoDlXvWDXQgtMEV1h4D/GpTehVzLVubtXToFLDgEj/JUh31nf69F34ADkcjxPBousIPi+X7xvu+5po00C0rmJm341R3XARqmM6l5ntYg6rHrMlxII3fueodMkJsMOiqvNHXqRdg/07kW1yjYnNHhGGdQ0PtbCZnl1P+FIqTPYCCGu/RbxfNu3dNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmzXmbUT4Grr4dKjq6mO5djclsts5xsbdLuJkzavONw=;
 b=eC/0eT5H1IAfD1IN5xjFfrMTKeYBnJJY1/Cr5nZy4+lUppnhFljcuJptR2sn3o1LBt9hRn3sSx1xgUxoybi998Qv6NP2IewrFYUAJEgK1nIe4nl6HB4Qf8hKKiYf8oPWFRBMECs3/Z6V1LDbrsTAVre3varftbzqrd7y0z9dROo=
Received: from MN0P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::15)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:20:04 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::89) by MN0P223CA0013.outlook.office365.com
 (2603:10b6:208:52b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:20:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:20:04 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:23 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>
Subject: [PATCH 46/49] drm/amd/display: Fix rounding errors in
 CalculatePrefetchSchedule
Date: Thu, 23 Jul 2026 16:13:54 -0400
Message-ID: <20260723201908.373300-47-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2da9ce-730b-4fc1-3b7f-08dee8f7c83a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uN4B5z93ZRnPwA6oDekaKpmfkbmJ3umVwYuRFsECN+X3cvLFYvjzdDzNCZazG8vg+YsGKc8mLiAu1QIt3k7bmo1l7wgX4lDLNtpgpiBOhd/gsxH6ZSBZTw6y3kE+aAdXnJb9SyYV5j1Ha3NzK94gUtFm46glKEIMU1gP5YJa20c1UtDfVX875OsHpKz2lnMeLxJPeD1MXoA+i65hxc1NJTODo77Jd/mz5yo8HLa9Z1ZWmwUHNSpUq0X3pnGMNwWnFW+MN3TKULlD70s8DgGLxxmgAX899Vm46kZ4OSPQeVm1c7LsaHyIfRbikDxFFxZkRIGi18iSUBCz2TEemektMNyrcRV8rsKluuYEZOhWPRWbVKUAgexmSN0IcfHVNaoOtojgJz+t9aGwL0bwVGMjsvUS97WJkrx/NcSAzhHrWhhX9D1rrZejrl5rEyB53IEb7zGwUKAE0W/KAnXaGMNlSt8qEIacNd5/BwRP4Z9j6ppX/UIXkgUbeyGLvjYFRtvVoNcwvko2ih0j64HHS2K8sD6Ra4tY2QTZi3zJgxidr6BD8C6xEXxLEpr+K1tsQK6+DyM1hvuqIzZko23c98argnW9zQe4ZvE7AKLjv5B7YBcBuh1VcPaBE5PSqifU48tPcFa61PX3QLBbT5kJcstDmJP9yHWQu1mmUA3/cpH2AaNr3FTYAxr7xYK/ZQsJ+1mziDrOuRi+BSB5IE6A2B7S+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3d1kByDaeAe1d2ihPYd/7JhkCe2L34/YG1dqwg9RqCAVidYUyQW2ofsqjmSJoRNl/UFw1NdQJ4nyZmoi0ALAA/SCSvKdZ6uFbBvrm7Pk4yEeOnI53UoDxlW+p1cMY1dwmNGP2wt1vSRpthSNQVbl48WYnVuVNHeAPCL6xdMaLrZVkyMMe13jVFKCEGgbJcmbcs9fwIJenPXH6y3caCY10bH+GVsXKa/HlDhSUDp2R+oPPD3u8oLxoS1TtlxpMAC1Cyn5kkbUZye0cpuSEn4UMs/5M/XJ4aSsognI2qI/q5rfsNjODCjawMkyPsfUrUSWxquPJi0jRzo2Znq+NK8j7kMqTOzkAmD4yVD9cHlXfjl0oWwvvnS1CpjKTeiv4fPrAoG/2GcFbI+2OygrgGlodfIgOCgOKrgD/TGWmUHb9MzXouO0PodZxch27nYkyrYn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:20:04.6573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2da9ce-730b-4fc1-3b7f-08dee8f7c83a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949
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

From: Matthew Stewart <Matthew.Stewart2@amd.com>

[why]

Rounding errors were causing mode validation to fail in some cases when
it should not. (IE. Increasing fclk from a lower value could lead to
validation failure, which should not happen.)

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index da9a1c4e2bdc..4ca6a4521f11 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -5622,7 +5622,8 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 				+ 2 * (p->PixelPTEBytesPerRow * p->HostVMInefficiencyFactor + p->meta_row_bytes + tdlut_row_bytes)
 				+ *p->prefetch_sw_bytes)
 				/ (*p->Tpre_rounded - *p->Tno_bw);
-			s->Tsw_est1 = *p->prefetch_sw_bytes / s->prefetch_bw1;
+			/* due to rounding, VM can clamp to +1/4, Row can clamp to +2/4, giving SW less time */
+			s->Tsw_est1 = *p->prefetch_sw_bytes / s->prefetch_bw1 - 3.0 * s->LineTime / 4.0;
 		} else
 			s->prefetch_bw1 = 0;
 
@@ -5646,7 +5647,8 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 		if (*p->Tpre_rounded - *p->Tno_bw - 2.0 * s->Tr0_trips_rounded > 0) {
 			s->prefetch_bw2 = (vm_bytes * p->HostVMInefficiencyFactor + *p->prefetch_sw_bytes) /
 			(*p->Tpre_rounded - *p->Tno_bw - 2.0 * s->Tr0_trips_rounded);
-			s->Tsw_est2 = *p->prefetch_sw_bytes / s->prefetch_bw2;
+			/* due to rounding, VM can clamp to +1/4  */
+			s->Tsw_est2 = *p->prefetch_sw_bytes / s->prefetch_bw2 - 1.0 * s->LineTime / 4.0;
 		} else
 			s->prefetch_bw2 = 0;
 
@@ -5660,7 +5662,8 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 		if (*p->Tpre_rounded - s->Tvm_trips_rounded > 0) {
 			s->prefetch_bw3 = (2 * (p->PixelPTEBytesPerRow * p->HostVMInefficiencyFactor + p->meta_row_bytes + tdlut_row_bytes) + *p->prefetch_sw_bytes) /
 				(*p->Tpre_rounded - s->Tvm_trips_rounded);
-			s->Tsw_est3 = *p->prefetch_sw_bytes / s->prefetch_bw3;
+			/* due to rounding, Row can clamp to +2/4  */
+			s->Tsw_est3 = *p->prefetch_sw_bytes / s->prefetch_bw3 - 2.0 * s->LineTime / 4.0;
 		} else
 			s->prefetch_bw3 = 0;
 
-- 
2.53.0

