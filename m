Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F000FECD6FE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 01:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 963BE10E6AF;
	Thu, 12 Feb 2026 01:11:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JDcVpfvU";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013035.outbound.protection.outlook.com
 [40.107.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 722D310E15A
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Feb 2026 01:11:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKG1OyDKRdlxqvgjI+/rQzAbhcHMBHEER14ESCt0CMzui/uvN6StUvp5SHG5kPhOLHei5F1tG3jtzQUARTmjy932yNAgeY7ASLgLn9lizxGOcILM0lkbj0ERufl5gEkpD2d5Kb2cl80UjZz2oDSnUu43XdulXp5tginvExRyKQLvWOpKfarO0Ws7JR09mOUPzZStdO7icbOiYUsrcWWtDQ4c8Czj58pZJpMenzblzbPVGr2TY9tOz0rPclD+6x8eQta5so7s2iRCKohwGZPLV3jOZnxQ2FmPBddXd/Y0pw4vpkndVgm7FoXjtHy9cI9nqNobA7FNAsXcFrNZue6akg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecdptMM9ywsoSo9W7F4OVlK9NpxcGaLc+uJVNPloTvc=;
 b=I5tVJlcYg28xL7t9VwAFN7A3FKHdnufmAHQhjc0Bnwty9xBjejKh4JixdrLOPs2t/j93CN+u3qftHAWzmuFi4oDk4jZ9HLUBcWMvqBcYIx2NyLzOTNpzvs1vpyYwO0AJVP5PHkZeqKiuXpI7PYcD/LENPyEPhTW7l4yVbVsFhhOsGBvlZnQfGqH5J5QcubGOlyPokZhWbUPQNhm2v605zd6g4xqb6u/bU7W/rrXxEm1ctyHfHiIH6PZJ7Grc5OWrpG9Dq+n/j0ybTiEn3Xeifq2mh5urzrpXufMVi95oDY2x6mQ80eAd+J4WOEC5nuWOCXNcWC/w1kuJdwbeqbCGSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecdptMM9ywsoSo9W7F4OVlK9NpxcGaLc+uJVNPloTvc=;
 b=JDcVpfvUIZsLV1aMqMaJ7ovsH4gXqhdEiAkz0OnnX2MbTf6o8ZfwbiWzXfl9gLzz72Qr6aWioWdo3JCctEuY5Qv5lClQKxTGKEDroR58MDYJjNOYmjlcmZracvW8oqLRPO7mUN+DFW7Tbv+wjz8e2m0oPGYECe8CDNs6X7DeA9M=
Received: from CH0PR03CA0283.namprd03.prod.outlook.com (2603:10b6:610:e6::18)
 by DS4PR12MB9586.namprd12.prod.outlook.com (2603:10b6:8:27e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Thu, 12 Feb
 2026 01:10:47 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::b2) by CH0PR03CA0283.outlook.office365.com
 (2603:10b6:610:e6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Thu,
 12 Feb 2026 01:10:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 01:10:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 11 Feb
 2026 19:10:46 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Feb
 2026 19:09:54 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 11 Feb 2026 19:09:53 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, Roman Li
 <Roman.Li@amd.com>
Subject: [PATCH 1/7] drm/amd/display: Add dcn42 version identifiers
Date: Wed, 11 Feb 2026 20:09:43 -0500
Message-ID: <20260212010949.654686-2-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260212010949.654686-1-Roman.Li@amd.com>
References: <20260212010949.654686-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|DS4PR12MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d6fa95-fd12-455e-0822-08de69d38d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3z7XFdBhfUkFeez+uVWtFNWTSMY/OUgEsaF+ZXCBSkpTxLK00PoICyw1cMyC?=
 =?us-ascii?Q?1+CnCkoL2rYEr2oNw1J5C8ITgK4RD0Dm37DlgnJJbfDe68VKI72oNyDoisuo?=
 =?us-ascii?Q?vRI7/Jl75/7P3wSTr/xmQPbppH9C71+EY6rn9an3uxnax4/KUKghLiJc2qS5?=
 =?us-ascii?Q?vLRCIar3Gw3liBdzxdvNNHeCbmx3IgX/WLGa6Nem5AJS3qLPaFy7GMqyS74N?=
 =?us-ascii?Q?SWA0lQgA4aaWRNV/pOBuuSkQ0Xun4tgNMF3lq00lM4GtfnwdzHx8syaUmZyj?=
 =?us-ascii?Q?GPGS9gO4CZQKEpaWs10nfoU8sHruripWe1EdihTPup7ZbyRjA3h5k3Qr85QW?=
 =?us-ascii?Q?Vr4/zrxSs8KGcQS2Hxg/PEcUwQjCaQwPe0l3ZA43a0Kvb3H0420GrbQWxn3J?=
 =?us-ascii?Q?uvCj1XIw8gFAIxccHaYlD4/3722IELzR7ITk9zcRViFPr6MAk+sOm0cx9eqq?=
 =?us-ascii?Q?rtEWqvD+q1iV5aj4Xa2A6jt3iYDcJN7lpx2js4iJ90VCCFEtCIykvKmqWEnX?=
 =?us-ascii?Q?1ONu0TH/LaczF/98M77pWiDHOsVrrHTRwchyu2oAK20/6zqfNzqd28rByM0O?=
 =?us-ascii?Q?gIRRsVqVGwr1BB6O4Fery/LGoNfae/vU1A9OZrLHuhZR7UbW6w9zjrtWyKjF?=
 =?us-ascii?Q?3k6tJihVKMMWnvNVk9BiipZ6ufW4kuxujGHaiHdfARuDp45vz+dX+vi1gEKQ?=
 =?us-ascii?Q?d1am1eM+p1GSFvyJcF1Ajgfm2VYQtcunsbc0j6Shvqcn25WCvCAPRZ5XJZ+A?=
 =?us-ascii?Q?9igCUFHRozLlKIdl7rOOBdf4M6P6FXvdZAoOkM5eQMuOutxVjV6n9aIDCuZ7?=
 =?us-ascii?Q?eDDnQTxduVq++EFplp1viReQszbjR48O63ZmGrLrAZm4DgDDe1EBYmlFbQ0g?=
 =?us-ascii?Q?keBf5/dqBypvPWMPSlHRizxIwqgKE+9CYMyNARqh8O+6Q+LOAOivRpJJYLPV?=
 =?us-ascii?Q?IawTOXW+u0V3aT3zOL7R5mKZBBuTwOVS2LkDBqZ8z4S8siyjJO+pH69MD1nS?=
 =?us-ascii?Q?cuSBS3kl5B6Ndb55SYwFGIzKTOSH09phU+GlBXC7VNTxL+dbJO3IrFSmFBCg?=
 =?us-ascii?Q?qirUNaspUmf4QYtCRtLONprBE+kw+IKL0OFy4Aac47Uo35E6dKN1NZ307+nG?=
 =?us-ascii?Q?BauYF8JKuVGQnC7C11kMyt6QTZI8uLVBXaI5HbOap+SFKoZpr7Ggun+1FGu6?=
 =?us-ascii?Q?4GJC93r2mlkaJsZ34hbZcS8HsGFtwbaqDv6qlswWZrRwsNbHgpyKmUS2Rj6V?=
 =?us-ascii?Q?KRoRk7dATP1vYQikdcecddIb3eMkk+/Ty8TxhBzmhHaibC2qFEqox/j2MR0w?=
 =?us-ascii?Q?a/rUiyAD+4Hpbs/n1374CZB2ZQ8CQda5ecnUydotjYHXCM9BL2bQ46HUQDXn?=
 =?us-ascii?Q?brM/nxHbPvtyNb/PE3sVAOZgT3xhVBI5neBoYk/ENu4oH3E2LZH6Dp6JiKez?=
 =?us-ascii?Q?Lmrb3KgMidInGSR17Q1UBi8WQLJU0dpPd+b4SZJkTmuJB+PbhDe9t0WhD4KU?=
 =?us-ascii?Q?GlwcGxolRP8LtwqnJxhSRMWT3vx8Xjo0V9VdUIFdPUiKH4fVgL7sVqe5xLkd?=
 =?us-ascii?Q?p8WslNi9oc7+55k58qNs3oNE8uMYvofAsSd56n34rFgL+G7YwQYtMSeCujCP?=
 =?us-ascii?Q?GXb1CFUwucYaGVqFpYcaP4KbJJIBE2a02ZD/P4RtDefLGdSn3xra/OVFgHoU?=
 =?us-ascii?Q?FaEYlQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Hndf5qpfnjf0C86OC2TmEWBWtZkAhYBh9NMm+34CqJlIWuBDrZ48IIIifACp6AyAiMiTj/y+uFy6WQHPjxJWF2HBLJ33glmz5Izrw6mJ4SJQ1m0Zsa09Bfm6+XyeNo6/4ajXa97nBrQug0Y1nBf4nI0b3nX1P/xDn93rnnv7mgieW9n6SJJ2cR8W9ni/4nnWy/xkOXJmBVSC32tr79nzmeUgy8I93UeQpR7OKaCpjogrKNPch75HXOcMG7UEKFouqocNLuXy0SX3OHM9nhfPfgDpm2oKTBKs+4YE63ckc46YiYIDC4goM+zWLwPj2WZN101zsf4ehyb0W6NLx2jDRVbADgZeS/Qx+HwbP1fHSmQt/H2GWNlbnq3FZ0N0UeTw/EkTaTuEHjxh6e7CqcSxVHY3NiOnPs9B6WwMgi3AyoNJpd43eXZPnw52Qu3d1pqf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 01:10:46.6787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d6fa95-fd12-455e-0822-08de69d38d91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9586
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

From: Roman Li <Roman.Li@amd.com>

Add DCN 4.2 asic version identifiers.

Signed-off-by: Roman Li <Roman.Li@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 1 +
 drivers/gpu/drm/amd/display/include/dal_types.h   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index 8aea50aa9533..92510af1bd65 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -252,6 +252,7 @@ enum {
 #define AMDGPU_FAMILY_GC_11_0_0 145
 #define AMDGPU_FAMILY_GC_11_0_1 148
 #define AMDGPU_FAMILY_GC_11_5_0 150
+#define AMDGPU_FAMILY_GC_11_5_4	154
 #define GC_11_0_0_A0 0x1
 #define GC_11_0_2_A0 0x10
 #define GC_11_0_3_A0 0x20
diff --git a/drivers/gpu/drm/amd/display/include/dal_types.h b/drivers/gpu/drm/amd/display/include/dal_types.h
index a021d12acd74..d30eb24cf11e 100644
--- a/drivers/gpu/drm/amd/display/include/dal_types.h
+++ b/drivers/gpu/drm/amd/display/include/dal_types.h
@@ -65,6 +65,7 @@ enum dce_version {
 	DCN_VERSION_3_51,
 	DCN_VERSION_3_6,
 	DCN_VERSION_4_01,
+	DCN_VERSION_4_2,
 	DCN_VERSION_MAX
 };
 
-- 
2.34.1

