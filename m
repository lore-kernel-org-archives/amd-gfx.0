Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C05CE8783D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 15:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9520710E6BB;
	Tue,  3 Feb 2026 15:14:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FA+KvPDe";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05DB910E6BB
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 15:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdANmf20qI7hUQTwMqGYfs84MbGP2MBGEpvmu4ENjS7IDcMfg2vm3uATGhjd9owpnJDt1/Pw8ZtcB3zfrd+kYNcysKg6mMbhoB2usuKnHHShh/1YQquawFRZiFbmeRlqCeyCS4Bpg6WbNhiibmJbmmSTrnA+voS+/NJR8WqFi1vKDMpw5PicI/j11mDR0zx4//k4bD51gkqRRf2vZhQWzmHt1+a19XbJ381lMn9DxtQQXjJUNSbLAOcMlW/YEPP6thmGK/+WwS+rW9Kw7Cmq5F22LJNrCg4ZUni2MKc/Am5KzfQ8trhnEsSA0EGarZFqIcNkfRFNJFwb6ehSnLdqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Jx3m6EuCBz8JAH4jGQpeCQqjDWQAwlSW5fn51dX/dU=;
 b=TOlzqpDb9c20Tly3ctR1/tT3cUHk4w/xJWi3ElYDua1qF1Dp+dYPg3G8KE6Ds4jNFGwyYZRTYPqXFuutku36wZJr1clSAJZwubwMhv35ZMJqj0FeyOj0k4+iSBRhmUwrytZPL3UYk8Gwd/5UmFdg5oEQ7eADzpR+AeMXDFITrWr7PG8FcGD4n6ZsO0LfwN3WIqgIENSp4Ntd6vhmq8LzWwGfihSCAz7wjvLJxfOmqLAmHeyDeQKzl9xiSGm5eCVc9E/EKe0wyYEivzk6lK1bv3dSjGEnN99rb5SFnVO0+o2hOdOE3CXkYrMls9aELmNVHWNBHB/CTKujSsNBwlkVqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Jx3m6EuCBz8JAH4jGQpeCQqjDWQAwlSW5fn51dX/dU=;
 b=FA+KvPDeD58OjokuRtotDwqyBElcSPfZ8krzyUMuFVvknjNBAIuv8c47XvIdbomWWFIz1kL2k7I2eLxLoSldF1o4JskS/N5kzfBBcTNwEMlsNZc/67K3CmN6jPzm6dOfdy+0ybM9zq+oBOdDO/4RY5Kgn3bPhuVSk4E0LZ/gG10=
Received: from BN0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:408:e4::24)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 15:14:00 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::a7) by BN0PR02CA0019.outlook.office365.com
 (2603:10b6:408:e4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 15:13:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 15:14:00 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:13:59 -0600
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:13:55 -0800
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 16/16] drm/amd/display: Promote DC to 3.2.369
Date: Tue, 3 Feb 2026 23:01:58 +0800
Message-ID: <20260203151229.3673042-17-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
References: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ba69c7-7ea0-48c4-2c51-08de6336dbf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PK3y8Nfswa8KGJrorMMkP2qkO7UukEjQ5ozLVuymEohNh1EkyAtWFjwj4FSJ?=
 =?us-ascii?Q?wkPNAA+6cHoTtNkcMNWCEpi70bCMyPKdfNCOpJ6x7x99GJq615v+D5HkGUzX?=
 =?us-ascii?Q?cnH7a/uilDGZxbvqqPv/XPBCuDs+uNQlS3DROT1/ndA2BVW+1+0EmXzF2O76?=
 =?us-ascii?Q?3LzL1LcFTFO3mEdS4XfZ5Jv+C8LHM2B7P4HHLSDZrayHjTskWlYURTuU/eAn?=
 =?us-ascii?Q?lm72NCmA9Y8Rm6ECwjDHG0uHKzBy40315TSES2FF6tf1jWXLhK24UX/zIimk?=
 =?us-ascii?Q?+kJFbL/rvbG7y2Ji/3au7OQ+hYahLRSChzzPy1WUrmaOYUjbxa5bLEnIYZ2E?=
 =?us-ascii?Q?7EXWsVlbmyFpvLrNj1b8xYER8vzC98B1+Rrnd/ZEiIjQKWnUXGC39soPNvTi?=
 =?us-ascii?Q?T8ZycVRqVTbXDTIA0EfTJfYapcJq/pj9w8PAaFu6tppjGSlduhJJdYD4yoFy?=
 =?us-ascii?Q?tmIYEJliaQRR4sNJmMcaFuRjZPvA2D2nxf4KpQdevctKIYl4PJ+WwEoyGaP7?=
 =?us-ascii?Q?IvzL8cyd/O+kPl9dVAEn7rnGCg4T2VJP2DXi1ewFBBrEp73zeh8uR7ljj5je?=
 =?us-ascii?Q?S358PSkZDwe0YO1zwAu78qxQaaTZZYHQ8w37OziC8vDLJrTSaDt8ck96xy7r?=
 =?us-ascii?Q?5x1HfbEl5bs5t7VyzeshaMaj/sHMghnC3tYCeYXEzJqF4TGVifjiykeVGrB5?=
 =?us-ascii?Q?RDdvCNLIlU+XsqR4Wa33CCUD+8gNor9gFmCjyFgRF1TaTdM1fi1N4MIFoe0T?=
 =?us-ascii?Q?zd9XirWreO7lezmOBLRDPWZt+aQqkhy0K15Gm3g6uHPsMGhwjweJr9ZTfBVT?=
 =?us-ascii?Q?vFwb+Vc8804vE4l0EyflzpMTKKee4d5yPul7/7FcZMyOdTFqfAkqnlKidUMY?=
 =?us-ascii?Q?N8NhqeVbK1n1x2IfQ1PH2iQ3EgmQpK/sduUb/wlD0lwZiZs15mTjvC6JDFR4?=
 =?us-ascii?Q?IiWqfIEm07slrSzUR4OCH3f2pdcJPaCEHk5wtsrlcFg/1fVoySBN48Jb5hyT?=
 =?us-ascii?Q?NC6tcMbi3q7YSKnDLD9khBc0uxrQS5sFeYyiIx82LHJe9YSbcTKbD2JPELZq?=
 =?us-ascii?Q?gKzIM7QaqTcHabP6Qc3rj4b/Y2Ep52q69NTk2Bz9QIrr11idSeKMskKVmz3U?=
 =?us-ascii?Q?x22Pt3iXrBOX9wQhpKN7N2JaFmqWzX60A2wlenGab1rMtdiW69fYZ9tV1n9H?=
 =?us-ascii?Q?kC3wzI1YfiRrntQLhU87eOq8WQJnFOsy7NOA+YxHj85xpGo1ksF7vk3rnZ0/?=
 =?us-ascii?Q?+Pq+UJ2QN8nnchUYqhrkVaEyLMpZejK+NXDOC7aW8yvm6ik6NoWto9dWEqeK?=
 =?us-ascii?Q?OhPz96FRL5cXgtDxp5fuTdA+CBj/RmELgiTytB6dX/vuPHqcr22dzIrDkLd6?=
 =?us-ascii?Q?QepdU/5HArah+t0Ye4T6tLTPlJ79kBtbHZb+t/1UlOwEO1d24ejUSkqxTZEs?=
 =?us-ascii?Q?aQXkzY37BBGpUypOi/Xzm1rHX5befMHXfaNuUVNy2lRK2mTDN6nv+Hj4CYDt?=
 =?us-ascii?Q?kbTeP2zFVRlDBIr0Kizg/1/kwEaCW4W7FnAPdYsodIklrohVcpj/D5LwbebL?=
 =?us-ascii?Q?9P/N1exCSLro0eK4+jIN8QkrabMKLnmJUx7BWf20CdAgbF+L1F0oBeRNbyNt?=
 =?us-ascii?Q?m+K/sLf5neywrrY01UGaRnOxMeXyBvy2R1AFW73G8wrCfNtN3Q3saZkYhwr0?=
 =?us-ascii?Q?DJcazg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PGgPB9dNJ6JhnCTBwpME5ujF+14vXXTCruj7xOyNUlM3pHZH3zPlTeUXNK7hvWdXFGecHhZGVytU8sroES5BYngbR8wXINhIndgXQ7YvyjAiJKhmXsqDz1AJ2zgML1XQm8EganXegYXOtE+MU6VUBX+fkpC/ktsCAnS7Q9eOmhyEOp0U+L25pm6T0/Iip9ct0wTg8sU/zalivRXA7Jh4J3/NPnx6yZB2JG/CzKB3Te3Lw7vmVuop1JuXbfGdDPDa6FVTuT2H7wIaWgy9RP2r48ZSJEbzG1k28qc0N7srAZ2knyGlWG/n2OHfjv19AYXZWyZYgc6thFg03M+sEVX00MjdaRvSFJhcBpvP94XmWNgb65MGSy6OQ8Zcmgn/HmMSjTwdhw3VuDJrGuzoyKNc6c4Rvid9I5cNDFtTwy3xyvEnaA/GaRhSZn3bTbNb5IR0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:14:00.2460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ba69c7-7ea0-48c4-2c51-08de6336dbf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along following update:
-Fix system resume lag issue
-Correct hubp GfxVersion verification
-Add parse all extension blocks for VSDB
-Increase DCN35 SR enter/exit latency
-Refactor virtual directory reorganize encoder and hwss files
-Set enable_legacy_fast_update to false for DCN36
-Avoid updating surface with the same surface under MPO

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index fdfcfa416d16..ce08477d1ccd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.368"
+#define DC_VER "3.2.369"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

