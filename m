Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA803E6BF31
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 17:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AF8710EA2C;
	Fri, 30 Jan 2026 17:31:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SBtAmYnP";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 726ED10EA27
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 17:31:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=way2PT5iWAFY+MIDS1kTb0qbMSSE63n4uI0G2e7owlCQ3FRHub4akdgfwE9fl50wgKYa9z+cQVQbR6OhMhWAmUaelF5PU3GOob+iGh1EOrxl0xYxGQ6N2n8NVfviCgFiLqWbefbpzz+K3fyqp3XdFREUFDANehGPeadHZ3LhQUnNePQx+CR4T1ajL6szRvUcoI1gyXGOD+AzV+WNhaLt5zxkgqxMT703UjPxC6Zv3Aio/zaLXB/noocbY0ixdPQlm+ks53zVrOYEyemUhf0ayaghQcZwZa4y1HujFt0RKsNsAotWAxOSpPkdenuPPFNuNzAnNKQGgHxLTLpbTlqxyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N21i0kJ/EkPoJL75fS/xcD0mp1i7huURWXoaBlqBfBo=;
 b=XKhoZ+5AXEIVZtNU9cH1PPJF+4g3xPz459q0DlqtLfrnqP1Nq/jjgCRp/CFzA5huThbRP9gHKh2GBMCP2OTu9ztj2zjGV5VaRkokfH7vsSTCcyJzjk8ObbdMNc+PzLp+TkukRoPT1LSsNLrYQqEr+FOGIXf9WJqjxS8OxO6dXFQH+m4xrO1b9JJ7UiFQCmK6BBz0t8qpTWvxhezbxeZALXgv2WxvdhQQtd8xhEMGB2D6nD2Agh8Psce+ARUUPVqWvh4dbHMz5ZbbK5YfgCLhJ0fVyJPLwyCwFeECsJM+AhzVx9Qc98gLep3GMGewGmjnF5cDxCCkhp4iLcTK5EeCag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N21i0kJ/EkPoJL75fS/xcD0mp1i7huURWXoaBlqBfBo=;
 b=SBtAmYnPkxrDcjZ43oQ4UxbVQSpN2VZQdyPP/Zhr9Q45rKy/LEeCmOChYpev3l6HIHEPi8Y3COXxSovat7hwfKw5YjMn9eVpguMgQ5AenBRJto0ROU31U+xCzZHR3EXAbyXvxKL3Z7E26NOBw+X5d1sKvf0dFRYrCVA0olF2Fnk=
Received: from BY3PR05CA0039.namprd05.prod.outlook.com (2603:10b6:a03:39b::14)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.8; Fri, 30 Jan 2026 17:31:01 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::73) by BY3PR05CA0039.outlook.office365.com
 (2603:10b6:a03:39b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.5 via Frontend Transport; Fri,
 30 Jan 2026 17:30:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 17:31:00 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 11:30:58 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 30 Jan 2026 09:30:58 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 06/12] drm/amdgpu/cs: return -ETIME for guilty contexts
Date: Fri, 30 Jan 2026 12:30:36 -0500
Message-ID: <20260130173042.15008-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130173042.15008-1-alexander.deucher@amd.com>
References: <20260130173042.15008-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 26575958-8039-4804-018b-08de60255618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b368fxnlRWXxk8jfD0HQ6sjPQ2ChgNkOyWLDlWV4trv2sgRh+yk3py5mZ3/H?=
 =?us-ascii?Q?WuM0NAzb+4H1+bun3C8UK4Xz3FKvcsn5dB6zRzj7pa9WEzPFlVzTtY1nEAC0?=
 =?us-ascii?Q?4NQPKG0uBNVPd4BsHaK9WeQVbDR6xU/RZJ6+g07vRZO0G9lvxMUWdmRsr7du?=
 =?us-ascii?Q?MLTKqDDHy7EgeN88cIfjWcDmqMySvja2R320QK/V7ZGZ+8KtX3KuBZ2CjISw?=
 =?us-ascii?Q?CUufa1XOhrZ54hzFuj4FVKTbmwI3URSwT6/lczaSi1Qfz8XeL2oCpTyDk/Do?=
 =?us-ascii?Q?uOeimUHvSi/ASTVXmZpcN53GZcrrW0yxNtDEHdQtowbwyoewyqFt8dAdj78p?=
 =?us-ascii?Q?15HHssScxwUXHccARwA6J8nIac2uYeJQsa50cw8iCiVRB1qUSXLy091buWaf?=
 =?us-ascii?Q?NIeMHZujTA4H+rWNIN3+6AtYAhl/XhasZRS3/JzfQVMHurHj2MsPidj8Fw6f?=
 =?us-ascii?Q?RvqKP3K/t6LiPPqusYU7Az1xhi1qBfTzzhylJO4xEAYuf3zIUqVT7hU38diq?=
 =?us-ascii?Q?CV6C/BHVaGAUM8mAjANXgyRPu8KPnQK8cH1cXh2ZpStzRpfzwkC6onF4HqMq?=
 =?us-ascii?Q?aOJ5MrrpNcqOeO/vaDgIKUgMSM46BKBO0LLNponqboeEa32N+wrYwDgWCw5R?=
 =?us-ascii?Q?YnQgpQgE7e6F2p/K1pQRbDvZ+4c85jb8wYbUxv6nNxdBORHPTbMr6MN1tdpS?=
 =?us-ascii?Q?OYz2FEECj5gVDmZyqWjN42ZRfmk1xQ3jHc70DDY90MZBwK8Z0DAn/ThUbdO+?=
 =?us-ascii?Q?wUcXQlknfYVB/dv00MoE+lp9XPrViZnYL62ABwVXMBTZY2OBK1AZCFGIpqsJ?=
 =?us-ascii?Q?YYrdD0Fmv4wVUrWpFQsmcgt5qstUTf9U+Mx02Y2PIyXBLlW+Wi/9Txz6No4f?=
 =?us-ascii?Q?2u4h0bYo45qsueg427aklYDt6i9e3J4czCFW7Gl8UhbzxXiLtisnhoGKPAUo?=
 =?us-ascii?Q?fRCERenkV+YKPvWDmMOkQBMbD7h1sy1QHsdwu8svBxYFBC3DdSe631mKtfhM?=
 =?us-ascii?Q?WJg0lZSA+cyRZhicEilJSCEHRc3Zl2hx7Qb8B0xEkvNVUhbKH0kRWge6NsWv?=
 =?us-ascii?Q?eH3nlcLOzmqEzXkz8zgpNqdO6sSGnmnR6cQhVrnYwLnAzef343ggC6t3xGcf?=
 =?us-ascii?Q?O8zgBOSJlO3lmMdMlkkSlsEAkXGHTx/p2VAbjqavtpdjYOSEZby9MwyZPTpl?=
 =?us-ascii?Q?cNko279qX/tZGmeZfYwqLBfpj3t3234CzexCFX6Rk2aA0LEUls2HOhBIuliM?=
 =?us-ascii?Q?2he6zHxeIpS3DyEnP8aqwMIn4kO2Czuk2IBjlA272ux6fRv1iYypK+TtTltG?=
 =?us-ascii?Q?LHedrueFzByTe4NfUcgl+7rOQkJV3GLfj6DnFau1FkNHz2T69rY0BS6eCg44?=
 =?us-ascii?Q?UihTNviPa7BIxcANocG34MmEWR4XEymoU2URaHUbWnE1JjtB/tZ8BTosaKpz?=
 =?us-ascii?Q?ZZsRxLXPHrbx74gpaWvjsFwYl9BWvtpj7hk2ajYVqSSmQii/2vw9rHDhvfEX?=
 =?us-ascii?Q?DlOP4a2wXj+BWveY9nBraz+d3Dg2AmA+E6Apmhf0Rd+T3c03kjA7jsJITLL1?=
 =?us-ascii?Q?wAETyMbLmmfwG/NrAGyTLIOJ5rVEtdSbrsC+lHwaEU/Pl19unKMRcTGQsFqM?=
 =?us-ascii?Q?56pXbbsF8cijmOjgdIV8Xb7DuhB1A04njm+mUL16RagdOLQey9MvP2VPz4bC?=
 =?us-ascii?Q?3oMqIQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GvQ7mbJoOIXXQumBsJpfdm9M9vgwsvbQPwmccg+XeKExENsoiG54I7UiKHKHom8/0WU9mXq2BicguyIdFXvNbe/6qJ8eFcAMjLSEG+A5mPReNunEmZ/x+1rw/FBCEZzIt9P46J3GrS/Me8tsgZIHSTEe46P5EG4PSV6AsUbqc/iyTx0KDcH21Xf/9Da4nX1YWIEtGUCh40COibQbs5JGR9EEr7JG8ThKoc4TKCzwGXPXe2yPq6rjBLbxJ/gfgYsCj3bDljDNZyvtjXL5EjUfoWvKbQJRX1a3wMFSWkg6Rl2maFMm4upYdGJ+gVH7BMFw/06hl+HnbqwPWny5UGQW254VaBd3bDs163pwPrBVJ/vt1cqbUxnuXCqlPIeAgWByO2p5dsgsLynhitduJ1r3Ia9FLSLA7QWKLVPRL4Gv8QQuootB289ZZiU+1br/wlUy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:31:00.6318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26575958-8039-4804-018b-08de60255618
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285
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

Return -ETIME rather than -ECANCELED for guilty contexts.
Userspace only considers contexts to be guilty if they
return -ETIME.  Returning -ECANCELED means the context was
innocent.

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 4d53d9cb8490d..3112a7c5be81f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -62,7 +62,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
 
 	if (atomic_read(&p->ctx->guilty)) {
 		amdgpu_ctx_put(p->ctx);
-		return -ECANCELED;
+		return -ETIME;
 	}
 
 	amdgpu_sync_create(&p->sync);
-- 
2.52.0

