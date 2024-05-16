Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4030EC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54A110EDA6;
	Thu, 16 May 2024 19:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gK0QKVM6";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E6410EDA1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRHKurcDINQ5J6cUZBWssE0NG+qIym7eJWMuBrfAvF04vVBE8tLjyPJRx0Tb7s3wO2Kjgw+49IXIMeGRYVoqVTLod0Z72OMKC+0aXTqj2ekvXQbuOQes/OHB6KUeyn2kpZGZ87UBXvCSmyjrd2YiHqqPKexWwtoKhe56N4N7RZpyhLXyb4ulGPqaHkm0k8b/1OYx6trbgpPTtsTlJSQEI2pdQtd0TGrH7A4DAThbIfVl97RC1qTd4zqSMCZro2swJaoETiv2NQj1bp9VMMavqtDRBFvTEo2Xd/uVOE+pgddd0cs86xkl8DQ4BRtl447rLIKPCk836P9O6/tbljmnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHnA7RmO0lj137X3MxkQeo80n4XAXlFM143+mmSa/OM=;
 b=C+Gx4Apq5cwI6k+uROeCfMjqIeyH2vJNaiVU09NR+m6qbTkHhHE9+bSsJYfO8jiFEGRZpADhL28QXKRzgwlOm501gXW5O0566Cp5i7qAOac84oebmUY2MGXqjp2xyrvTd6+RiyCNEyebkN9EFI1YFjhc2fDREWSwnmQN40kgMpo/5qF4BINa+DKVp9RSY6awrYftpn6U4F8QgzLgRLv0+r+UUY9pyksSNl+8xbIlEIqQWsOhisJMMlywhKJYkNTNmSS9EKWfNnslnu49muw3bdj4s7iZN7PtZq9f4fOKSFchWaz92SpxZwdGv6Ikn0iF4T8bDuldeYHBkUuajcsMmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHnA7RmO0lj137X3MxkQeo80n4XAXlFM143+mmSa/OM=;
 b=gK0QKVM6bAlEef5KmRmpjfcztbTSyET7bxFyJTq4RHf3a0VXRHnq34mxrtzTDOLDIRFPo0wRmMr2kOLjJ8yL2JL4up+mpNnHmgrln2H75ruLoIPXdCU2nuzLeajBzA2hs9Q6s/yvWb8T2zFR3hN64deRe0sSQUdsr4uI2B0jzLo=
Received: from BN9PR03CA0245.namprd03.prod.outlook.com (2603:10b6:408:ff::10)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 19:27:02 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::a8) by BN9PR03CA0245.outlook.office365.com
 (2603:10b6:408:ff::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27 via Frontend
 Transport; Thu, 16 May 2024 19:27:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:27:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:26:59 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:26:59 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, "Revalla, Harikrishna" <Harikrishna.Revalla@amd.com>
Subject: [PATCH 08/24] drm/amd/display: Refactor HUBBUB into component folder
 for DCN401
Date: Thu, 16 May 2024 15:26:31 -0400
Message-ID: <20240516192647.1522729-9-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 36514439-166e-4a38-6832-08dc75de29c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j2ppux4Du8XCWPoE44ElFyIC3pkARABvPMCgVTXqr6GMsNomN0+eGj2mkvND?=
 =?us-ascii?Q?7q0aarH88wREeSiYEYcYXFQeSerOUfTeBg3fE3Pp83PfhktBlpZUjOL2cL5q?=
 =?us-ascii?Q?gG5PmtV2YJxsK56L5LAieCZ3WBmFITJT2fVhvqv3nrnMOSHX1Cyk1xGu1drY?=
 =?us-ascii?Q?hz2bqnrrT/F3Hnjm500+ScXj0FbECeAH+v8nJe5L/AJGxq0NANgVKuM4qnUE?=
 =?us-ascii?Q?N8Y0oEfLgmUyjDzliFNrJQbqtbjYzwWVvPQGNc8Fdn0A20uOnGHq+iGNHb4s?=
 =?us-ascii?Q?gqPClT/gq0LPTPYWckhJrxmnCgssHTuhSMoMWxCpNOYRkX4xxvk93nIUL5wO?=
 =?us-ascii?Q?eEgQS3OKVVyOzhgw4bJEAtBnlkPGaa9KVTu6bTfhsfJnuI5KL7201RmsQ+Kh?=
 =?us-ascii?Q?iOZJAJ/HE+27gNBk5i+Sy1Iy9tCkEWSiLB0Npiv5rrwe1d8kCviCUSJtGKCO?=
 =?us-ascii?Q?vEetcHfRsTbYkoaZHeHjXw3CBFD6dEQ8uceumWlmshD+04kzokP+5yUbmeqE?=
 =?us-ascii?Q?H1L8nd67Dy/8qrydzsKT4MgUBwQPq1sYsAC/qGcIHZlvsI80GcgKGA3XBaO1?=
 =?us-ascii?Q?e1Pq/EshBKrwax+ZN6q/1OGqTf+ReGjuTGSnpoc6XN+FLYK5MYZ8wXhiqIaS?=
 =?us-ascii?Q?vstljKn//wwcfZHWAlc/CMkK1FdazouiE0DJP4kaT1h0Q0eAhcev4mgDiR7U?=
 =?us-ascii?Q?s5pb2cZIJQoLC/xuvihWwPCYpNPDsI5cUsOcGvCSOuT1O+654/nhpXid2km1?=
 =?us-ascii?Q?jEwZfqCIWce5ywYWsVOX0GK5RsSWeA0e8evbTknCbFv8URGiMu962mOTxG0L?=
 =?us-ascii?Q?cFWisIDzqHC0hS+H8DX4qqMb1uaFA+M95dTMRY8d/TXyXz6UlHbHgtzKITcb?=
 =?us-ascii?Q?9nD9ssY0gvOo3nL3JLgKcq9qNnavrLyNFwUsS3/32Bt0PKT4dnwbXAUxADhz?=
 =?us-ascii?Q?sM7BPygxDgN/ryI3crXO+Mk5vi3EjCplRu79mhHpf5ZipxjKlmWqtmcBDEMp?=
 =?us-ascii?Q?CnEQE9TwJ3FgqrlaFEuOKs+7gnFy/R6x+mNxk3Du46hHuG1/4MvEG2eOFeYb?=
 =?us-ascii?Q?0kGhNCA0qAhTOE3JbJUJrImrIyTFek4jqpTGaxoORuxasR+WCnsje2hMHaoO?=
 =?us-ascii?Q?rABH/zj96FUXDSdgg4i4sc70RC+sDh4wEW99M0miKwcTq5uxp6PA/1JjWtFw?=
 =?us-ascii?Q?HT/yFVZfPlvyK08HHvpvT2BZumawT5w42LvRLwh8s6PuO4MJ8ndyyC42SnQz?=
 =?us-ascii?Q?RnsG2rQ23koJam4YEFdBWFZlgta+LFoNDzG6qIgep9IM3USgLYfixLy71ytO?=
 =?us-ascii?Q?ngzButLW02xQf5FEvShKtxekdI9o2Uf5DQ8dYSIRySbNm/VzxQa6OVyIFBu6?=
 =?us-ascii?Q?AGmnzQ2pFnh8XNCdX/J/KJnSNo5b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:27:02.3095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36514439-166e-4a38-6832-08dc75de29c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622
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

From: "Revalla, Harikrishna" <Harikrishna.Revalla@amd.com>

[why]
Cleaning up the code refactor requires hubbub to be in its own
component.

[how]
Move all DCN401 files under newly created hubbub folder and fixing the
makefiles.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Harikrishna Revalla <Harikrishna.Revalla@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn401/Makefile              | 1 -
 drivers/gpu/drm/amd/display/dc/hubbub/Makefile              | 6 +++++-
 .../drm/amd/display/dc/{ => hubbub}/dcn401/dcn401_hubbub.c  | 0
 .../drm/amd/display/dc/{ => hubbub}/dcn401/dcn401_hubbub.h  | 0
 4 files changed, 5 insertions(+), 2 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn401/dcn401_hubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn401/dcn401_hubbub.h (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/Makefile b/drivers/gpu/drm/amd/display/dc/dcn401/Makefile
index 73544559f41f..f3fdfa1fba37 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn401/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn401/Makefile
@@ -6,7 +6,6 @@ DCN401 += dcn401_dio_link_encoder.o
 DCN401 += dcn401_dio_stream_encoder.o
 DCN401 += dcn401_hubp.o
 DCN401 += dcn401_mpc.o
-DCN401 += dcn401_hubbub.o
 
 AMD_DAL_DCN401 = $(addprefix $(AMDDALPATH)/dc/dcn401/,$(DCN401))
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/Makefile b/drivers/gpu/drm/amd/display/dc/hubbub/Makefile
index ab2fddc4a858..66ca5a6a0415 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/Makefile
@@ -94,7 +94,11 @@ AMD_DAL_HUBBUB_DCN35 = $(addprefix $(AMDDALPATH)/dc/hubbub/dcn35/,$(HUBBUB_DCN35
 AMD_DISPLAY_FILES += $(AMD_DAL_HUBBUB_DCN35)
 
 ###############################################################################
+HUBBUB_DCN401 = dcn401_hubbub.o
 
+AMD_DAL_HUBBUB_DCN401 = $(addprefix $(AMDDALPATH)/dc/hubbub/dcn401/,$(HUBBUB_DCN401))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBBUB_DCN401)
 
 ###############################################################################
-endif
\ No newline at end of file
+endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn401/dcn401_hubbub.c
rename to drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn401/dcn401_hubbub.h
rename to drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h
-- 
2.34.1

