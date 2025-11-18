Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D39CF2560
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 22:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 191D310E53D;
	Tue, 18 Nov 2025 22:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5sqKQRZg";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBBF410E53C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 22:58:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLovlgGZH3373bY/j1SZJQH2p8qb5inqP0QDkbeZUFdivG9iJNYpLPTQpW7WQn+Wvt49e/0B0RbNHp9gY1MIoo02P00TfUJjqAstry4/iAuQzvGo6Jg9UxqnuqztOeCABIhF6OxlP9tIpCqUJ1VQ8R6HMImPLDsCKPt94TrH0YMVK429ylrH6YWDCMQkDybHu/7MhgJEIsWvIvIB2nyCR+CRYYFzaCZr6r+jSnqinbdaG+kbVVLrJC1APId6dVpxEKJpPvuzMULoaEWVALssFXmTkaolWutttmPcet7Zkc0pzSS2Sb+YeEU0ricOtamOiXUG8AgOnmTILssLx4SbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG2hNUCMNlelRY7/bHgCAIzDwInIY22afCI7sl7s3kc=;
 b=vgWEcWVnB99VVBzpuJx1eztRXIF0/13VgNTWZA/S6Zh167sgijfCPLfczavKG+DYcFd34BhrD+myMK439eBzME6OGloeKfnu+AdYVttszaea2JkU+P5nrgWvCHfEsFq+H8ljZAX+Ime3sbcylXq1a34pLJa1DgS/GC1DEh10O8zyu+v4507kPjB/Q2Htu4OIBJ5YyU/TMLCO8+1NEalKrl6tZnCfLxUNDUFp9bLlDSuRR17lllLSxV9AIGFTTR84JSW9QJuZAMc3NrwPTxDni7Hrnmn3uMcb9+Jb77zu2NRThHlx//PAHw1HYDdFAD2aNRIh0yju1QNK95d+GHODng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG2hNUCMNlelRY7/bHgCAIzDwInIY22afCI7sl7s3kc=;
 b=5sqKQRZgIaucPqKLwXziSHcLmYrTeB4OAOE55id6C4xU2eAbLbn0rRCBYEdiZ7ukjmJoQY8KIMBs69yN++/b0A6P07h8Sq7jGCXHj+N0mirpkwgIbycvgBBieiEkuD8YNTXsAwvgluKXl+qrzQJd9/1J9tExatCh3hJTga/y45A=
Received: from CH2PR17CA0024.namprd17.prod.outlook.com (2603:10b6:610:53::34)
 by IA1PR12MB6530.namprd12.prod.outlook.com (2603:10b6:208:3a5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 22:58:05 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::8) by CH2PR17CA0024.outlook.office365.com
 (2603:10b6:610:53::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 22:58:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 22:58:04 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 14:58:03 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: Set skip_tmr to true for psp v15_0_8
Date: Tue, 18 Nov 2025 17:57:48 -0500
Message-ID: <20251118225750.3613219-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118225750.3613219-1-alexander.deucher@amd.com>
References: <20251118225750.3613219-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|IA1PR12MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: c88459ee-0a49-4fd0-a1df-08de26f5eed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IUdJBgodbV7bQMT3ekb3tebEJ2qBP7o0696qD6fuyF72JzZBi4FjbKBiFIM8?=
 =?us-ascii?Q?t7H+DfSnOtZdmB2NOq2Xid5k/RaRewCHkoHag1w17z6Zwp4ofMV6N+Bq3w5q?=
 =?us-ascii?Q?xlHHjqslicBJhMo2LdyM5x0gcbDySUrLI5pdBAcI+R7CWxUJPSEwb1DWFtJU?=
 =?us-ascii?Q?RiIuU/YoW9Q/BTnFB2YmlK/tW+kFCOqWoVKRQEWE/LL0OLCle7oaKG/tJ2g9?=
 =?us-ascii?Q?/l8FrnGUhTtRjgB2EOuyr49NHtrhlVpNjnyhne3GBv9OQV/9LgopT6N7HdnO?=
 =?us-ascii?Q?3xyZazzFu9PCcBJ1LNUZSlHYpACStcB5Xb5AjpWblNPqv/ZAm9cOQm4i6wdz?=
 =?us-ascii?Q?ckpGX4IyZZ9NDM6D5tXJzCOu8DhmgJS8a+/FgKIXhj941fUJAT7wnlnh7VNK?=
 =?us-ascii?Q?E1Ur06nXUEiTEYoPE4KSDuA6enP5DcwOnzcr9TH1bWfaOo9dZikBXDtdbTlB?=
 =?us-ascii?Q?9Zj1g1cbjDRmnBzEKl9MxMVUaqX7kdSosGzjOC5IsP3oMOk/BEszYbCqbuLA?=
 =?us-ascii?Q?bOO68qNCWwNycKZhP2fdeJt7EK9AiNTP4EIjgKKiVDiQ94XUeMpqy0WYbPRS?=
 =?us-ascii?Q?vLO1XIE+WzUiy3ozIhOmiPi6CRD9tUBn12Vpf/4T/T1/5cCGqTufKxzQ7DAk?=
 =?us-ascii?Q?M0mS1Ydda0eomnEpGhEkNP0gm0Vyrey3fHYzSXbVYsiyZFVZxto4mdh8qd6E?=
 =?us-ascii?Q?qhQqxXipTScba+IBkUzhOq4X155/PW27Nfw4bUt19g7/KnonJOokPYmFslht?=
 =?us-ascii?Q?mwrwU+/kxKVmckU/w8+4qUZkDIPkxNd2mH9K8XPkkvPFnAns9li0IX4nie1i?=
 =?us-ascii?Q?sbIa4/Ztj7qcCc1uOaae1No4XgDYzRwdjb58lSJM8id5+oFX5bQ00u6pIyAh?=
 =?us-ascii?Q?DetzD4cewn5WZXKFZY4Rou6NtcVcCnSEcAjdyDtC6BZgEJ6SWp0ySsMyq6wi?=
 =?us-ascii?Q?y3NDO1v2Z1KHNfHQOpaLNkpPtlhPWrFZYhnVpiz7wVGJOPluIbZ+JeQa4ctU?=
 =?us-ascii?Q?RKOaA4z014SahPG+Y6SZqszc+SynSmndEjmDQLy2dIggv8GumbL8XvV13wpL?=
 =?us-ascii?Q?ZhAdCmlcm4Eduu+D8y9L+BOHANZxvF2OdRsvCK4UU3Y8hEWg92rT51m/VCR8?=
 =?us-ascii?Q?uw7wzqJHEO6AVq5hssk6OBzeQpauJC/6AV3C+c5ecSfZyrob6A+5KgiGjrTM?=
 =?us-ascii?Q?JKEyNi/z7p1gv/9df/h2GmPmK3O9QuJC9AjBUa8Ixd6uJT5jL5oIrQ+FxHb/?=
 =?us-ascii?Q?jprd+U3KOzJCugrjiy28ivcUBTnO1/LXnS2pvtHnxDMnLOW5rJ/UBsjSUk4a?=
 =?us-ascii?Q?lP/V0jqWoM6sFh8M/j5Fgvh6cH+Y/Uj5JgTsXDwe4Nv+5WG8e+9CJbPRMJRe?=
 =?us-ascii?Q?I8jhcikbS6Rj4zMMZRPPPHY6pC6A9IJPVoir12TuPVsgOmKsVFLAnce547Gy?=
 =?us-ascii?Q?TI9eWiavFoeZ/ybrPOzXhWDk4LGyk+n9OaCgS8ZUUs819uHZxfHkACVaY7Y3?=
 =?us-ascii?Q?HaqV5aB9Szyavwl6o+XDcunaOWH0LjuBwJNAaPAntrjGIafPUohFWGiqc2em?=
 =?us-ascii?Q?2ZGvrli4O8h8onaiAoQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 22:58:04.8273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c88459ee-0a49-4fd0-a1df-08de26f5eed6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6530
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

psp v15_0_8 does not require tmr created by gpu driver

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 6619970da250f..204005ad6252d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -901,6 +901,7 @@ static bool psp_skip_tmr(struct psp_context *psp)
 	case IP_VERSION(13, 0, 10):
 	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(15, 0, 8):
 		return true;
 	default:
 		return false;
-- 
2.51.1

