Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4074AC27C6D
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93C9210EAA2;
	Thu,  6 Jun 2024 21:02:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h0pHnWY3";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 863E310EAA9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXe6OSGlkEBofnTPGgUBGjkTFGiWEEbT3qm8en2dfq2D+Je/qudTJD41pjvz5brKhAKm3ZLpT4tNHUxV2AAxbfISx57VCf9QlNue/a5rz1uCxoq890mbCOvrTpctCK+7LZAXN5AnnW9vfmUHpXvdCHwvX3dUIA8KR4VE0uNd5+ZVErX74k8vlLD04nLRVh7ULkvweUXslVielew0z/HojioGSHEI/soFAV2kpYWcu9OjGcCM6vJ1lqhqhxjmqTLDYRBkRXPcAC/5d845VFOvKP3rhvN4I6/kDnWOwGB1Nd/AnuibNKkyCD8NmwFZ3AcVHL91hS06TArc1IrEom2Gbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNaJztD0b2kyYr5LNBJJ9BxpIOy20tVOCwUN2aXK5w0=;
 b=BOoQQaiBqzLGpn81Q4swdSsseHBw+9VxWf9Ha7BqsJN99PXVVG0u+jnz99Iq8qT0ao/sHZYtLPxEKvZ2iD6veVO1sNoL2ixSurl1Hl2o4GZYLoQ9UrAIAPIBRN3CVikznA5gkk1ab9pzpPRPqKSLUmUCgX0OO605cS/6Z02om0Wm7NkoQsxRrDxabnIh1OUWI+VWSkWeUEYVwQymyOclm6fNN49pWJYxg8/Y4JCLnEeOPSTOciY07UmAvPN0/uGvXxEH4Xqup/vdiJ1l31FgMtopWPOsEy1JYXJXkaEG4u9mQPHJzxESsCV/5qQVSKUcVFOtCDwQypnFaSf0QX0p6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNaJztD0b2kyYr5LNBJJ9BxpIOy20tVOCwUN2aXK5w0=;
 b=h0pHnWY3FgBB+pPxLrKa41JkDkiM1euObf6JrwEHsbNN5iPPzea/jkCdDJEWayLc8SN6u/lHlctnQSxCY1ommDjnXdjAB6F/AwUHO0ET14g+LkGLnBEhOj/J3NCh1spzdxv+6R+3xdLhXZU9bmIEC63GK22bRFPpcqil2R6vXRQ=
Received: from SN7PR04CA0036.namprd04.prod.outlook.com (2603:10b6:806:120::11)
 by CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:02:05 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:120::4) by SN7PR04CA0036.outlook.office365.com
 (2603:10b6:806:120::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:02:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:02:04 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:02:01 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Ivan Lipski <ivlipski@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>
Subject: [PATCH 08/67] drm/amd/display: Remove redundant if conditions
Date: Thu, 6 Jun 2024 16:58:29 -0400
Message-ID: <20240606205928.4050859-9-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|CH2PR12MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f978891-247f-4fde-68df-08dc866beb66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bj93MQrksDrD7wvI3b/G3LNShexck3NLZWn8gEgUkoHJqe49TmaGXVj2rivX?=
 =?us-ascii?Q?dMCWicBZvrjyzprxSI3f0aJo4cnnQAt9Uy4czKh8s5239VZucQ6xUM9Lntkb?=
 =?us-ascii?Q?3gXjKr15EMvUya6/Uo3Wt5rLGKk+QGML0FuYX7nybrGwfakKDeZl5uWRjXRr?=
 =?us-ascii?Q?lQTz6JbkcWEw+kC6BPWYY2NtflUifwPyqRSGtNAzUgen5KNa34jgTV2RexXd?=
 =?us-ascii?Q?6qWSxPwTwwJu4lBiMDNNP1m/BdGtu5aY6NYxFjsnfmPLfDzKYfHf/kKjMten?=
 =?us-ascii?Q?rHvnG4qrPG1tDkzvrsHPt/HeBzUAvmejVyOizuBkiA2vieCg2yrRSq0xdwom?=
 =?us-ascii?Q?Oh8624G02yTtko/FCjhQkkjvp8s/y+B9aipdCPC3g/FNxyMkJwpin2aMxPdB?=
 =?us-ascii?Q?AR5OepV949rQjioY98rlJtyeDjGMTlzu0uzzpbmF+wAJdfWqB+wHsb695fzO?=
 =?us-ascii?Q?QeNAYlpnq4n6tftGZziu/HcWtJmE/P7UK6+fyI/iDeuNe/dei2kOL5uSuaZq?=
 =?us-ascii?Q?CFWmXv9Cm+NzuFUEiPlDXZraihHES5hZWC+WdqeTWh3bseviqW51xVl37AQA?=
 =?us-ascii?Q?ZkFG1/tiXtzC4yYiT3lMVdxBooBstsu4xUTyYlgKNd8g5gDeHsj9nMVJvHbI?=
 =?us-ascii?Q?f4VISxLrAO0q0SskrC/XqQWcogewIbhR8H3JpGdHmKmxeY63Q9vm+7Pfj8q8?=
 =?us-ascii?Q?JAM6czEV1ztmyheL9EoiS+NdlJbUWZ9W+Q+nAjzmANMV13hc97d3N4y3FULd?=
 =?us-ascii?Q?7zUVrdgM8ChPNVJCjVmENXyuB6GzDj0H2xapitWYb9PWb7sDYJbVsceaLhj9?=
 =?us-ascii?Q?HjfMMDQh3SHZHcX1dovy0jSf0wgKKSFVCSMkbGl3k7aaZb6C6+Hm3kgalp7l?=
 =?us-ascii?Q?1hRWoUlL/jaIQN5s4D7QojN/MZU0DiVLILZZ6Q9jQs4dPOdyFpvdKLpJFpuR?=
 =?us-ascii?Q?sNBaa4xqu5ypxPL/f41TvcNWjLwkp6iA5lg0KrgJ6rsnN7A1Iui+3BuUugcn?=
 =?us-ascii?Q?QuH/uCCRJsXzyMrdu1STXkhl9vRSP+qVXj6gAURSUjzqmUGkEfTjEs51Rqv0?=
 =?us-ascii?Q?hE2C4/jSQh+GY42rTK1H1zSQfwOLupt66mWmFZkecyxm8IxyUCCX7wwdAOO0?=
 =?us-ascii?Q?VXwFAUvgFcWtkakh//4G4RL46XbrDgEsu/DxSnlCKxLLQAgtj7Gb9UDYpjWL?=
 =?us-ascii?Q?86XTBEuQJFuXLeJFBJfwpiHwEhPO0bOKbQbnlkOjyL3p2VI2pzl+aP0uVsfQ?=
 =?us-ascii?Q?TY7PdUzxfo/pZzSkCIlcIJ3R8Wk5HoaPorOQhKTWBfuGs+UWlsWp94lGpeY/?=
 =?us-ascii?Q?5bG+5xZ27Z5QMrOAyQUG3odfQmwzBv1TfjuNKIQYZP+pe+zqkZFNcuMlZNj/?=
 =?us-ascii?Q?eJwrbsrWuyvUI9u4x7r5eXCYRzkl8oh+fTJwYb623L6XpaaCfA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:02:04.7966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f978891-247f-4fde-68df-08dc866beb66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184
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

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
Coverity analysis flagged the two if conditions in
dcn30_dpp.c and dcn401_dpp.c as DEADCODE since they
are never true, since the variable
'program_prealpha_dealpha' is initialized at 0 and
never chagnes.

[HOW]
Removed the variable 'program_prealpha_dealpha' and
the if conditions.

Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c   | 5 -----
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index abdf6a132e66..40acebd13e46 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -219,7 +219,6 @@ void dpp3_cnv_setup (
 	uint32_t alpha_plane_enable = 0;
 	uint32_t dealpha_en = 0, dealpha_ablnd_en = 0;
 	uint32_t realpha_en = 0, realpha_ablnd_en = 0;
-	uint32_t program_prealpha_dealpha = 0;
 	struct out_csc_color_matrix tbl_entry;
 	int i;
 
@@ -347,10 +346,6 @@ void dpp3_cnv_setup (
 			CNVC_ALPHA_PLANE_ENABLE, alpha_plane_enable);
 	REG_UPDATE(FORMAT_CONTROL, FORMAT_CONTROL__ALPHA_EN, alpha_en);
 
-	if (program_prealpha_dealpha) {
-		dealpha_en = 1;
-		realpha_en = 1;
-	}
 	REG_SET_2(PRE_DEALPHA, 0,
 			PRE_DEALPHA_EN, dealpha_en,
 			PRE_DEALPHA_ABLND_EN, dealpha_ablnd_en);
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
index eee64d8e1013..7cae18fd7be9 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
@@ -68,7 +68,6 @@ void dpp401_dpp_setup(
 	uint32_t alpha_plane_enable = 0;
 	uint32_t dealpha_en = 0, dealpha_ablnd_en = 0;
 	uint32_t realpha_en = 0, realpha_ablnd_en = 0;
-	uint32_t program_prealpha_dealpha = 0;
 	struct out_csc_color_matrix tbl_entry;
 	int i;
 
@@ -192,10 +191,6 @@ void dpp401_dpp_setup(
 		CNVC_ALPHA_PLANE_ENABLE, alpha_plane_enable);
 	REG_UPDATE(FORMAT_CONTROL, FORMAT_CONTROL__ALPHA_EN, alpha_en);
 
-	if (program_prealpha_dealpha) {
-		dealpha_en = 1;
-		realpha_en = 1;
-	}
 	REG_SET_2(PRE_DEALPHA, 0,
 		PRE_DEALPHA_EN, dealpha_en,
 		PRE_DEALPHA_ABLND_EN, dealpha_ablnd_en);
-- 
2.34.1

