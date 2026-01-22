Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9915FD3EE89
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 15:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 435C710E9DC;
	Thu, 22 Jan 2026 15:56:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o8Ssm9lG";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013014.outbound.protection.outlook.com
 [40.107.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53C6310E9DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 15:56:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u586TtcZwmyHf9dF8EfRYmliEVlI+9rFvt2dvgL3/kHHnac7+YJetRHT3FqnOVpB+4L850vmGCQxrPG5Nt3IdIWnQwWq2lyLvP1rxGxDWAe0sme2tkz7XA6pfiOGL3FLbxmInpTatJmHWMCvINZu7DvXBSToFupd9jjmB8CvNBr58LdBv1mBdSgz6TeW8CwW2ms1DcRUfH/gjWmdD3EDfqS839iloYPY6U8tJe3HJs/uGrC1gvqS9bxY5iJyguvO0x4L4EPcpSLAAFe1P6cBvH6/rpPQNzoGjk+D/42HnECIzvv/2u24pFv0EFPe4Fg5RVzMHsz0DhrMu+IwTbba0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6LcYxqXv9Ne3C57L+ZTLPyh/Ro02d7xKTSP8dn9p+4=;
 b=rSzDhqRYg9DuFv9JfbvyoNOMkjNz5AelT9NIMGLSa9xxxatuNKjPyBvzXDBzgFHIKO96px6Lw1XEbalwnrvc7pdHIiHqOXUNQdODnuDk6cjAMYFiaRrPPo828bjvU9WgEZq3G0ydnrSj/gQ1V9+v2sbVb6fnj5LLSAfkRaA4KxQE2Ebm11NWn7pkvyNWKroKntymieH3Pll7sRHVTgPpVz4n3BMLZmDilWTqGFnc2d3d+ys6g0l2qpG8w+vCfKuvzBkx2NuSC1pqyqk7BWCgKwBFBfKSkZvN+5tOptszjI5u8NcOHFBkHUxHeeS3uuHd/1PW3gp2c9l/wgFknfT6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6LcYxqXv9Ne3C57L+ZTLPyh/Ro02d7xKTSP8dn9p+4=;
 b=o8Ssm9lG4omnlERegNnHEIHgtaaet+7Uks6FSo+Y9vtV0bffqUY9c0rQqfzuHGK+GXZCPjOxSZE73gL2CnCTSMv0BQYAbPg5IQCttfQN5z2Q8m37meH5SZRpv4PAAWYyIkPzjTUAPb9Qv+0U7XBZBxDhAHYczwShmTJueN5m5+w=
Received: from BYAPR02CA0071.namprd02.prod.outlook.com (2603:10b6:a03:54::48)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 15:56:19 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::3d) by BYAPR02CA0071.outlook.office365.com
 (2603:10b6:a03:54::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 15:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 15:56:18 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 09:56:13 -0600
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amd/include : Update MES v12 API header - SUSPEND
Date: Thu, 22 Jan 2026 10:55:59 -0500
Message-ID: <20260122155559.881810-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: a058f137-ae17-4c50-8056-08de59cec7c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m6/AjA9u3Xx/7csNItowrurXKtSSPqqz4Etc/JOsl4Npi7JgRuWhbOnDKv1+?=
 =?us-ascii?Q?+uiP8zJl723OPu+lHwW8KsdiEma2mitZP/cCOHEePsnF9b2U2i7FUTZNS3Qm?=
 =?us-ascii?Q?zkQ83KHDLVmRQD8j/TOS13Cg9A2+EsmKpgVyZV6BkhAS21Qtkx6MNkgfX2wq?=
 =?us-ascii?Q?aZXp03OGhWM2IIzBK0+VWoCqMfYh3RZVhNJGvUTZCsmFOZC4MzH79j3uHLyA?=
 =?us-ascii?Q?frn7vBqu7ISytlwMfpSZlhuUkiyy9LZEJaAx4I1GVJPYCD63ucNowbM5HPxc?=
 =?us-ascii?Q?+0UVCF1PO0jISxcFQ6Tc5+Mt1i4qOlFcg4jKEtt7e1RuUzQZ5F8McPRWmIlv?=
 =?us-ascii?Q?gUAQ7kUT1uUsGCIzrhokJpMfT6Xv0niYkgATp8Hj4W4wQTavsIPwoBlSzirz?=
 =?us-ascii?Q?wiXjb63aEsE0FBElyx6AoW8REWIkiGvDUIuYprHelrsJP2Zl9iVRssmc9ClM?=
 =?us-ascii?Q?VX8pnikw8FnpgMFKM5Vmw6/D+4Qr92tnMTbd9fnNpiY8bzDB5kIL41dM61xz?=
 =?us-ascii?Q?xFeKSKKH3SLY2VKkczyLaE6KxKD1+lQFIl9M+uMR11e2LLDZvp6C3v3YKpI2?=
 =?us-ascii?Q?YdQ26K5JXywoSDdOfx9zvZzvlRLj+iusXNbuOjWzJ6tRvOQVMFcbysYiEG7e?=
 =?us-ascii?Q?u0GWepOXBQCfb1hjXDLlwPJcEU3z/iJH6LTBFuHabg2GnuTAYm/Nx1PjUPgH?=
 =?us-ascii?Q?jaRg1ew7gi93UmFt2kcQ/BkPYVUoh1nZfCT3YBw5Xrl0RLs0xWP/86gclZvr?=
 =?us-ascii?Q?VLwiepzSjgkAfVNEL4nlgQaRQSKbkC2Sg1QhUVYhq8VmAh1Djfdi9XXCLkSD?=
 =?us-ascii?Q?t6jOlX92h7lVmezecyua+olEHljp90MC4yRV3fW2TjMSfOtNG2YIZdlsxk3+?=
 =?us-ascii?Q?utQH8sa/75jUqpQMu/RCp2uF7Gkf7viG+YZJK8yJ7Wqr+o22c+1VMxba5g+J?=
 =?us-ascii?Q?LOJxX0L7lb4Y/Lybvmvk+Xu5vFO2Q70ou5xa9mh6JCwV6vIdqdcZYu8GNvj6?=
 =?us-ascii?Q?2Kz3sHKiT1P7N9BV0x9jlW/TD0ERvs2esMD2DztPGfZWevPdILJCqX1053jO?=
 =?us-ascii?Q?9dvf3luUGX6H7AJLs3gpchpd/WA53L76lsSYGknwzT21CfmRfeWglTJiXVol?=
 =?us-ascii?Q?vfnGYSY5GJ+BnpfLO5tUFw3vOSHvajSyxmj+tRQqF/394yoRp/hmptW2s3VA?=
 =?us-ascii?Q?EW6bJUrLtnkd2N8eJi7mTVLiesShfrJCqjALh+s4MObzcAhWn1XKN8UVs8gu?=
 =?us-ascii?Q?eGN70qnZgOic8HrJ7bYhaOdCJkAa1b4B+t6OYQ4wpSjqwp8UIubyT7kARYSx?=
 =?us-ascii?Q?IQJo8rcES2ngJs6EGVko+TXj33TqIdEyruYszBaqBJ9bPpWdT1o9i8aBTx65?=
 =?us-ascii?Q?wY3FXyneHwo0tOjm//EcHE0LxJW1x16a00VPHBhAXuGMwiwsctPYwNYf9uXr?=
 =?us-ascii?Q?crldfnsXIuAJxWswe2RaUsjRHRNF/zasce5CjAesGLyP6B4wPYv/Mm91/EgZ?=
 =?us-ascii?Q?+4du6Dem11jSPdAGMchH2cjnhWqCnjBSP/EY4nlfInA3d2Npm7/gPTXpb1IT?=
 =?us-ascii?Q?ft40ye+qXXNw+iHqvO54MKZKFWrq0C+ItTsTdNYl8BdZk7kMUfrJLPN/OWCL?=
 =?us-ascii?Q?cFnWii72XeZdZBaV8N7KLP9fZ4eCMlSqMiBsOWigZdgS+YSEVRIgUTjokF2L?=
 =?us-ascii?Q?VjySEA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 15:56:18.1860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a058f137-ae17-4c50-8056-08de59cec7c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910
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

Update SUSPEND API to support sdma queues

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index 83e4f0142324..e541a43714a1 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -492,8 +492,10 @@ union MESAPI__SUSPEND {
 		union MES_API_HEADER	header;
 		/* false - suspend all gangs; true - specific gang */
 		struct {
-			uint32_t	suspend_all_gangs : 1;
-			uint32_t	reserved : 31;
+			uint32_t      suspend_all_gangs : 1; // suspend all compute gangs (can be set together with suspend_all_sdma_gangs)
+			uint32_t      query_status : 1;
+			uint32_t      suspend_all_sdma_gangs : 1; // suspend all sdma gangs (can be set together with suspend_all_gangs)
+			uint32_t      reserved : 29;
 		};
 		/* gang_context_addr is valid only if suspend_all = false */
 
-- 
2.34.1

