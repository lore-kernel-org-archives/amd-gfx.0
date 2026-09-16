Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C5AC982D0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CACCC10E7B7;
	Wed, 16 Sep 2026 17:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rh+SMici";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACC8510E970
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bT5r8m38J3l+zyZZ1f1jYH3eNIm/mE85P9/oHGc31EX4TeKpvCyQv40G/qm4XOmOxI2N3e4Msk6MK2R5Q/4bHev3ki46BIG+phzOZ+gR8R+h2HY7nNP0p3/xJPhPB3vlztWOclW9bDjei4LPu2P+d98URBeebFkClnndm6WlmjzkFMrF2y67x6Ih4gYzywYDv+o8GCfKin+jTlFxPIoqivGN6TZJkW/6Vhy8N01qZCrbPZzlFgfZbi4ZHIu8sPRXangY6EEatOlWCHuYOxx0KC4VczS3DGDjpNlL7mFzUIWWKyGLFsqkbG4fOOvizQasFJUMWSAGb3BnMC/SAR9uow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nTOs6Z72nze7ja+c2Nbpg/g8MmsbRiz0pY5koVHNi8=;
 b=Hu8I7V7BPuoPi5KPdjgCqmJASqwXgnNgu2zme4w8qlujr5D9tSPgWEjFZDiBwy9ibCccqsgSzaGQHdBkdUJ3gapstUwaszl4uajKVXY04zOjsPJgIcCfQ2ulGuJzrlX7tMMvKFlcsSr9uWI+OYETHoSNAwhqUd3yP5FoTArdkrmiDFrHu3EXlF9mOOd3Wrix7RlmC4Uhi1gs7kw4RUGPYMEs8RBJ8ropulvTvlkPIHEHKpulHaNOEXDUAhtRmjrlJNCoX02nYWfT5D4/TWDbfzXi5wY0HzdpRsBM6TOuSMMzrUp55QBSM0YDP4JZX5A0Bn3fiJQ0eWC0vjCQK8B8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nTOs6Z72nze7ja+c2Nbpg/g8MmsbRiz0pY5koVHNi8=;
 b=Rh+SMici+IUpswSbtp5QB5W98t9sfuxQTVU3KonRYkb7wYtl8k7OrWSSHI4EfFwJTMQm1Cu64RQ3PQHjlSlERgpiYnmGx2FUQnESJNRivleBwAZkogkAp20jyJzBBNOaNptR0aoNKvSOa2a3UY7UgN3JORtjYTMbo3PloxuOqao=
Received: from CH2PR10CA0013.namprd10.prod.outlook.com (2603:10b6:610:4c::23)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:52:28 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::a0) by CH2PR10CA0013.outlook.office365.com
 (2603:10b6:610:4c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:28 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:18 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 09/64] drm/amd/display: Add inst field to struct dmub_psr
Date: Wed, 16 Sep 2026 13:51:24 -0400
Message-ID: <20260916175301.368306-10-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 0677dea2-6ffd-444e-2a6e-08df141b4617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +o0TNbJhBrUdElvphzN/aoeSmV1Tz5m+UOch3EcbSfuB+tB9NIfoK25kT/ljACLA1Zd0W2NKJzSBQItdP7ckMSM1XR+yE0JFnCA0kwbaKCsz85NibbCQDFx29pUvvcidsuOoxnxBm4JeDnGjSAw8gAIQH2bQfUiFqckL/PuSFpWlYdsF78TwRBtrFSSMHrwlXKPWfVlC5EeLRdk/hsP2Rzdb7/SmHo3oKiGE9ba4SGHyueWwzHo44C+vt5OYvlv0myPwJoziSP/wfUqoNNBXCM7tR/2jL/OinJnXC3DXyP65Ym3feL3mRAd4yKie8zjGjmWMTGiDEGEcTODooV8S6bJJqx14M0Y4GE46qqfFzTmf6Vw4/Z0/xXrslHzUf9T0j4e0IT9JBi9N0ikoIrNi/ziD7QybiZT4le0BsbLJIPfg1sK0Y39nCt42giOeEnx9Mh5aCFhB68vOQ+dH3r2zBuU8NR4gh3nOfBq2q+2pFwjwlu9AfqVRP0HNtV/CA56n8mZ9rvbJsysCnT0Xcr0mK+tFmSeeN5i4L9WSc89N540/FuUtezLG8VMMHnI1bDyV5ah+VEp8ko40tbaUVsruwYmVAZpr//UAQHNS7ncgGEaMiS7mCUH10cJ3h9oKhZ/WnH7tTii7HpmrlK8R0EWalxhZmdqTC6gV+f2rUcijPXc9bSPgU58MwKMRZ54RkOxMsC1DR/t2Xaq6zLANDUZfqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ffbF+2+Yow1hDv/VNmT5xqhpqGF3SUc8uW10T9oScSl0OQJWwaG8KYnSjl1tfLNm9vU97HZRyExWw3NHFlgl69jttrHGnUu/CKqPgyngBXMPi8jv2r8IFrC51q5fEGhvXNX0/aI2EC7kSXxM0VOOYBbYwmNjlvYsXRm79aT4cZs5hg89lA3IyzbbKaYdVzboX1Y55CyaG/x8510Hay/qHLXBOlCL4xDyV+JZ/79/Qt10Ic+22KyAhyp7Ls68XL5rB04h54HFOw3pi10Enndysfv5bR1RcaEJrHJ1pabsFsPJUMywhfMf+zItev2PeE2CG39noP6RlJ3+H0boAFolZkBNzopaB1+N7k7D5NbvsnBcru2pyybo7R9Y+7Uwt6vufozZHQdqKqDqPGL2dwfSJ3cYNfMVK7iJBNBBVQT1CEsZEPgsNj66S3VTJcBznHjp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:28.1932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0677dea2-6ffd-444e-2a6e-08df141b4617
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258
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

From: Tony Cheng <Tony.Cheng@amd.com>

Add an inst member to struct dmub_psr and set it to 0 in
dmub_psr_construct(), since the PSR object is a pool singleton.

No functional change; the field has no readers yet.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tony Cheng <Tony.Cheng@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 45630c3effe1..66d8ba73d38b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -481,6 +481,7 @@ static void dmub_psr_construct(struct dmub_psr *psr, struct dc_context *ctx)
 {
 	psr->ctx = ctx;
 	psr->funcs = &psr_funcs;
+	psr->inst = 0;
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
index a6e282d950c3..45ba9902ebbb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
@@ -34,6 +34,7 @@ struct dmub_psr_funcs;
 struct dmub_psr {
 	struct dc_context *ctx;
 	const struct dmub_psr_funcs *funcs;
+	uint32_t inst;
 };
 
 struct dmub_psr_funcs {
-- 
2.55.0

