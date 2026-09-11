Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC0CC88E42
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 06:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A363010F4EC;
	Fri, 11 Sep 2026 06:46:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cjSJPFDK";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013044.outbound.protection.outlook.com
 [40.93.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7012A10F4EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 06:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YScPmA6Y80rzyfSdsO4b64WHsuhOKn0mmp4weic2KlrjaTef6VmhOs6O7wGAjE4cXkRZyrEhz3B2+jXK9wTo9OtUSjEQ4yqXEsLBgcakhav0wV5f65X25BwB0i8BH7hu60jKF4T5+dGVzcpmX7euA2eRbLxtedApFHjdvjvicT06ZLXs6RUN67qORzBGrGVMx1OOqthpra8hW2/BDpQQVOdHUR4IT3bf8NpoK6Pugo1F0m8uGiHITAZbjo6uI47Y8mJ/5ZPDv0ACX4M3JCPsZQ06C2YxR0gtNIz0LvMCddYKnZBgiqIlmfoI4cyLGyY39X6QEIBu/PakT42et7NOpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/cZFJolCwDCCQ4L3ANSVjOnAQad4sCNpQRZZyA1yMQ=;
 b=NyGBGox8CdDFtcCu8ahlR6wbUAULWYbJ46W9+00PWSYflp5PD/55y93E/CK5NMRpOxx5BT/35M3mHC6Jh2FTu1n9gEuqr4XD0GbYkNxNffBJq1UOs3SG7rDg/u+lAsEtzlayAOjzCUa8OhUS6WuoKA1sax2eNsn0cu5seCBpQc6pK/m1e+FDV0IvhctkFgd57K2iZXWIf4xxEBtTML/GJz/e+DGFwhbSOkP33dJJ9/tO5NiPQX/E44xnJ0b0zSdYOWYv5YI+gGUg7/GOf6IjeQEZyk+08Ls7U7kuEvJS+U9n9s0Mf9c5kSXZqXKOuf6+y+ILWD4ksLogoZptvFEFTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/cZFJolCwDCCQ4L3ANSVjOnAQad4sCNpQRZZyA1yMQ=;
 b=cjSJPFDK2umdI27Jw2bo4rimw+i7lvn3HXOGVpFB9iGbHM+Wxn38w/hSOJA0sfY/+pOx6zTc9fTx4C/3c8wcLb48JBc9I+V6SNTtZkoj8MFdpyylI+VTjMBpp9AEPrpTSHo/MqEsYbPMYoR/PtPZyxUmDHH9/7UXiOQ00Fgs6JU=
Received: from CH2PR11CA0022.namprd11.prod.outlook.com (2603:10b6:610:54::32)
 by BN7PPF7F4CD71A4.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 06:46:11 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::a2) by CH2PR11CA0022.outlook.office365.com
 (2603:10b6:610:54::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 06:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 06:46:10 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 01:46:08 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 5/6] drm/amd/ras: use common mp1 ras interface for v13
Date: Fri, 11 Sep 2026 14:44:09 +0800
Message-ID: <20260911064410.1693567-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911064410.1693567-1-YiPeng.Chai@amd.com>
References: <20260911064410.1693567-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|BN7PPF7F4CD71A4:EE_
X-MS-Office365-Filtering-Correlation-Id: 209d4199-bed2-4af8-3262-08df0fd05da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ggAEuKgnpEh5aFwhFFX2hNydnEl+vlUaysD+cMGfvw4dGWEmPD6avloEBfEOd/H9ypPsVL+W897jKClVuwbZ6mznUxiz1l4s6L27aNH2HvsCgL4sTcwZ8gVTCAFAeZo/+p8BR6yq3nfg+YHzyviDVVexWdMGKfp5qC1IoWNwSg8I/64KdliZi3zVFa4US+JppIdUq5sUGgVuQlSx9VuYDjt5GfjHXI9EU6jMqqb8/15pLAzjm2JipM4QdfRVI8plXxfXNMQzbc29r0K0JucP1riUUykXZdn82F2d78PX3SRaTPyHO+yflTuQTbBjyjgs2RlESHOJuSEl8ariGUcWZArJ+qPR7tnaRimc4YaEaFLkX5zceMpebsR2OaYOTf/NIcVDml1AkQla5SSmCQG/1xYESEgGLnRa4EAqxRPqUaa1XqNponEY4cHmcRadPpNXWq0VV8YWLbbw2CBNCTiYysGkX2hLyK0G+v50BwD5UWXOP1Iba8G4GAmmtAJMH3CHR/n+vjErmFCAPPFKpXFEEqk4rowlTFnlbl+XlYqylza8RvfRH+8oipt3nXlyuK9Er8p4aIb0Zd4Eq/oa6CPuOaMndTh0H2StnaUSWKoW8EEUs2JXy4aLZY0Y1aD4CD42Ah1JJke0D7iWioYktIvUVZIg8Igk8VYJGpGrv3oMuM5gzRMFaMTiF4MyUDr+dfMGKT1kPF1ho3pTnFA+rKRNDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3aVa1IVw8pY/9zkINEINxAvOiquYK5cNmX+6BnrnljWZfnYeA1xk7xz72dOmBq84Zwo0E6LdLgWvOBletzKTNRcBwtcAIX9CQfpuz/TAha6P5rWmhvsMcPc8YtvSxLNQbtFoD68iqw4iBPg6QoeItla6jXERvv5u7E0HA8pIEre7x5lJQEm6p0Mx2zFQJDq8HfdyHZv9+CpfqNakkjeqR9MDSQqv5IrZC/57o4Rx+QJ1mQDgEEPkfZdGfjSn83CAwrlg5oILeoHSyZdlAPP1zu1jA9VxNdpq94jszyw6iKydLNUfAIZa2Y0X7LhuGzEc5h3AWbdyUR0HV+sdedWwqNu+Z/AykRRVT+TnblAw+MtdobmSNXnzfXSiMUQy1yy+4eyUAC+cZk2HV/0r9kn6UANjtI9/uPIgg4GvI8ZDrAIPq9NzDyjW04s/EAn/5Q7T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 06:46:10.8127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 209d4199-bed2-4af8-3262-08df0fd05da6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7F4CD71A4
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

Use the common mp1 ras manager interface for MP1 v13_0.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index a02167397ce2..7dd8a331bd1d 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -158,8 +158,6 @@ static int amdgpu_ras_mgr_init_mp1_config(struct amdgpu_device *adev,
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 14):
 	case IP_VERSION(13, 0, 12):
-		mp1_cfg->mp1_sys_fn = &amdgpu_ras_mp1_sys_func_v13_0;
-		break;
 	case IP_VERSION(15, 0, 8):
 		mp1_cfg->mp1_sys_fn = &amdgpu_ras_mp1_sys_func;
 		break;
-- 
2.43.0

