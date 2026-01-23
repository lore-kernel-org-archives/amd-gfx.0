Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962D9D77881
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 17:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C28310EB6E;
	Fri, 23 Jan 2026 17:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GVyuereB";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E80310EB6E
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 17:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwV+yoWNSInk1R5L7tePNCLg9aqVOqImLTM4rVzPpfda959W4dOypcJv87P0RbZKEMjt749+RrANe9uYax/o8FI70QBd4SsaNVS0Qn55dMcv8dLbybZgpae5hgaapdp25JgNSH79xWrOW/r3b1TsGHxQiu/9oVQvb35a78+nErZCdEtFnnpxAXlLZWo4FIcmv3/mwKe3JUL9MbyPGT2Duc4tGG3snurv5/LQKmyVdNu0aEkA7E0ofvk0jBNiKRwPD+mKaYr07Xjvm8C/hgX0BhWP0QHide/MGa0RwYyY9k5Ac3Pel0kvW7oXa98Or6MyQQxmAuZrLlxiBhAyIcYTYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N21i0kJ/EkPoJL75fS/xcD0mp1i7huURWXoaBlqBfBo=;
 b=XTHUtjV3X/D0caxkZ37V3YA9VZpfaIaVFB4ymcSkKO3hVWi8iLLilZaABlYwAkvAOanmvv+ahcCoaB0Gj1Rf5a6T/mtCo3wMdGivn7vmYxtbTqDV+V3c4ldzlARMCvzVuaE4qUw7zHUXxL84xRAoIeE5kQyjJlOvB0jGsmVwGtiPsE93H7Jsu+eMpsmVYI/D7j2PzRcmOVcRseUGRhhT9yVtOyA+0/1XyEO8zxSo4z1UcadXCefD+odCHl5XnERsIkWtiDerT4biYw/+wWns0qkSlrs2A5KmjZCs2ttX+rbWsSq7eR9lF3P6oYcBkNSLx+381KtgXJdyTMC1Q72keQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N21i0kJ/EkPoJL75fS/xcD0mp1i7huURWXoaBlqBfBo=;
 b=GVyuereBppXmDdj8zJJ1aG0oJOBSDWJ2brcdnllwyD/74cdwgZ/hDDZ7V03BXCK4Vf0RLRzonxw9DH865jrWZqEDHqZ2jIKU6xOEFKJAvL9dVQMIFmZssKJ/unhHX1YkNRHKRoQ34173tFjlCHU9127shKvWCTKbd2hS9ep0w/E=
Received: from BL1PR13CA0330.namprd13.prod.outlook.com (2603:10b6:208:2c1::35)
 by SJ2PR12MB8034.namprd12.prod.outlook.com (2603:10b6:a03:4cb::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 17:19:49 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::34) by BL1PR13CA0330.outlook.office365.com
 (2603:10b6:208:2c1::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Fri,
 23 Jan 2026 17:19:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 17:19:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 11:19:48 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 23 Jan 2026 11:19:47 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 06/11] drm/amdgpu/cs: return -ETIME for guilty contexts
Date: Fri, 23 Jan 2026 12:19:32 -0500
Message-ID: <20260123171938.16814-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123171938.16814-1-alexander.deucher@amd.com>
References: <20260123171938.16814-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|SJ2PR12MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ad008b-b3de-40c5-43b7-08de5aa39ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gw2UposOddz00S7T9szeFFdtaRd1L/jEt6Fv7+iFdwJox6CZwQvQmpGWf6gB?=
 =?us-ascii?Q?R4dZ/ePD05n0DX+BPB3L6CUrqqIDZWINAxkQpU8ynUbSpvMDMgImxmGHLPZ4?=
 =?us-ascii?Q?JWxKdBQQfFdWZKujSte1bysy2Ek09iaHTcNDWk/B8B/OMFtzBBSV0F2H6zSV?=
 =?us-ascii?Q?8UzjlufmVpbMr4hxBNki/klncWJ44j076pxORnRbXfKL3mMKjFVFrT3yhIfm?=
 =?us-ascii?Q?ShVXEaynMAQxZ0rUcjHqINtyhxpSDKadqgrwzk5C6TZpBr2hEAOuedqMeNAM?=
 =?us-ascii?Q?W3TvnHjnc4J8PEp/KraoL2XenPhq4Qd75P6+Yg8yOdPb1E4wN4ndhjdSJmFg?=
 =?us-ascii?Q?0jzCGEQ47S3Cz01zw1zb7HxAg7t7kIbQgVq18cDpPLtPyaa9Nwf72a1rtdv/?=
 =?us-ascii?Q?b8rgJD4oJbBDxUZY0dQgTUvnv9Qe1ojpRcd8RDPFaZonaPpbF2zZ6wlWFFZK?=
 =?us-ascii?Q?O8iN6wu3fDrlA9N6O10ZIO6X+9GKNLASxJSgHmjp1guskDDWmAmaZ70I50RD?=
 =?us-ascii?Q?DBACQh7X6zpivub8YkMCZf9A1SGjZpPtUdXqPVkRnqabGVP7kJYgQY0dD4HQ?=
 =?us-ascii?Q?A6wBpMhbcx79MEnLvizHpzCb2BYCC1s3XgMWY/Ki2B1k6D7qGSLezJRWWDTh?=
 =?us-ascii?Q?Yk6sVFLnh7M3xMm+gYNp5Tn/YbJF2mkhT86OejMmw5CTKJxH/+HnBFoFeU6Z?=
 =?us-ascii?Q?5AHF8YpX20seXW7kqb9OemsJRkg1QF/i9ZMU52r47DoDf/Wa1WDJTw35MICg?=
 =?us-ascii?Q?OIPXK/+YecEROf5bb/Wo9yZqebFovfEnez/XkotGpnkHzpUedLPGpbJ5gDRS?=
 =?us-ascii?Q?LYIkNyvhWnvuVY/6pacBFAgA1lu5GA8iKcvR3gz8hJjdbHj0VgaaZDHQcEKE?=
 =?us-ascii?Q?9zY28diONNf9G+8OApQB9YrU2eeJJeQA0RKkt/GS1YS9PLZHJFZnveYF32p+?=
 =?us-ascii?Q?oI9t8wlGWQFpn4cVgtOqKcwJBVGhyXPGLDryjT16z3q1VXw2JdXAvsiTyJja?=
 =?us-ascii?Q?9F7ap8ZTuX9ZEfX35ADf/ICVhCY5BpCeZd74lF2XAxu0py5RMCAAzr5jx4Ad?=
 =?us-ascii?Q?MG/se+XxQN6b7DB4OcOpY/RgD3oDtAvp466vsSwZ0Oa0YOI7UWTdjyghcyoz?=
 =?us-ascii?Q?BpNNvOLAdemEmhf72ZjPZ1wy4Vw55mTviTVZC4uNPlLRKfvym/Kbf+Gy0cRn?=
 =?us-ascii?Q?d7r8qA78oOdDanH0TTCoFMZxJZfUIXBTzAB/T+QwXOA0zLNb+h4XVIC5Sn7s?=
 =?us-ascii?Q?K45UVcjJXUqonKzkxEXxx141Ql+YyQcjnpo0Ai4r3+q4kvSUJRiWMLCZVB2M?=
 =?us-ascii?Q?cr9uDWSId+HUVe3NCNhiJssRIK2ZcPUCAzO0TU3sfYrb0MuGeL8s0v+IrbV4?=
 =?us-ascii?Q?p+uo4vgUOA0OHjnF8u90wF/r6Vqu7eauEyq4Czq7YVzLv53dScwrAUvyVF40?=
 =?us-ascii?Q?X7B2YXk63eP6kHivzPP9nR9XrqWKeaGmUFiwMjARPofs+sihWbzXlZgc6+SQ?=
 =?us-ascii?Q?l/JESGpjpgVg9fbLbnDyrO/XiFJQBH0iAnL+JzCb+1tu3L6NbkrvZfFD5mSO?=
 =?us-ascii?Q?spEul1e1nJEwOo/zqZ7t2cU2yfQmfceFHBEkJVaFDTN+F2gu+rfMezRaLxZA?=
 =?us-ascii?Q?R5l8dUS9AAcAZLD03+h3FQAKz+UFboFfWT9saDFaU0beVqtWtnNxHETQmmAH?=
 =?us-ascii?Q?XjLSxA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 17:19:49.1127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ad008b-b3de-40c5-43b7-08de5aa39ce4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8034
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

