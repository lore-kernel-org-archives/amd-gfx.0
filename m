Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F746E7718E
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E86410E9FB;
	Tue, 10 Dec 2024 22:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nltr/ufD";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D102310E9F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmRY9MUOZwn+GS+0uD88JZ48XpFzaf0EbmyEk71TOQ8A4VmfuuPS+4V5vxZg+DGI9RXSN/3v4CIEkNB9xc7Nbfxt7UcTy4OHJp8wG2xr/A9cnSNCTh+4lnS6STjcgaOvkrTs+1CAeQfL6d2lzAMFnC8JuSuDt9XSJ+VihG0vZlUWQKoYxbp5irBwEY55FLLYZEZo9BjJ+uY6P003I+ZH+w/G9AhZKTo8Zgt2GvH8w0vPcMrMziJSWvoL6Ph+ioSURVjksuCeMEXMXCuhcadIRIHidA8hnYNFQ/Plq/0IDz7HJKl/GR4Dajpy91D/bH3OvgV5+Axu8nE7b4rurUkx3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4RcenaSOwcvQbSkFnenERwK77zwpYoVqwmmYQa1JQM=;
 b=h7qOr6G67Iszduap9lDsCBMiPTiFo+TVOtg/nq1wakya7w3U9HVk9kPzjIxqc152OgaY5nXta7RtscwpeO1i3hRq6ao0zR+tqKGtyH2s6yaioyvftauzg/77SzLSYRu4tNzdRqdy0gjNm9DGFlO/PM1jAfcFuepyZ65gSqfw+YyQ4gGxVAx+nT4NxzvFrfNsnM0qpXVVvs8geJKfjf8Sq25KwxpBxGtRVqJhoOUaUmVFGGVmL7AeLZNeDqk5Zub273cZQjHS0vH7d4qKkIXfq/Q0ursjFDfC37jojMI68PJqb7k6Ivb0SYMPzBggY5ribHIyGWY4dQK3Ptlyu4/7EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4RcenaSOwcvQbSkFnenERwK77zwpYoVqwmmYQa1JQM=;
 b=nltr/ufDNU8/zEXUXZjXuyxgJvcbV4jC7248nQfs2IDBPCF9cJwhMujtGu7SgRrwLWTZIGVeuPwF/Fg/ZLPtD51bTcJcLs6ezkju3xMsepxoWl9kJNgRxV0aFC3MLoiNTxY4O88Fskq1W/B2PKBtc9gL58vkah8R7NIf64erB7c=
Received: from BN9PR03CA0231.namprd03.prod.outlook.com (2603:10b6:408:f8::26)
 by MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 22:54:17 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::7b) by BN9PR03CA0231.outlook.office365.com
 (2603:10b6:408:f8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Tue,
 10 Dec 2024 22:54:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 35/48] drm/amdgpu/vcn2.0: use generic set_power_gating_state
 helper
Date: Tue, 10 Dec 2024 17:53:24 -0500
Message-ID: <20241210225337.75394-36-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|MW6PR12MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 680cd180-ca82-4ad0-d974-08dd196d91f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1B/nnq07tO3MC++ue+8DmM9WQfTQ9/3sTaRO3b4V7reMLZQUE2LDjY9MYENs?=
 =?us-ascii?Q?Wa9aWKwIVYurKSAl7tSAlxUdymVoCJ+2cHyx16U2kRN4nmTi/tIHyySF1dPX?=
 =?us-ascii?Q?mgWQ5jOxJrTs++XuPDKwfKwbYHgKDn6pR83+SrjBEnE5aRE2eJKW9y/Igjx6?=
 =?us-ascii?Q?UI2LlnchyVvo6qYXUzw8wV0HbN3qJQdGfk/80LkCBvH7aMFl9aiLHz9RnXQO?=
 =?us-ascii?Q?kTBS6QWCLTFSvIcYSWxvaMEpzb3fSnnes8KCm36+SDKhraSfnRusgQr/0rbk?=
 =?us-ascii?Q?RvlbdgRAyHfAiCWI7h+/8RGyvAYrgF/hhlc+QTDGuWBkCGBIPNVnSD03chUc?=
 =?us-ascii?Q?UVGkq6MPUKrcL15+EUlDaeNeSk/YC77zd8m/rpLEALGi2r0LNh7EosHFqdSW?=
 =?us-ascii?Q?CL7fN1R7UG+Mh1MPTq2fs7oMAQz8bS+5VqSpkheUHcfWRvm+gI/y1aEO57Na?=
 =?us-ascii?Q?dLpo9ykro1BJ240FN5ZdfE8+mM3fqpADY6tXH7vi1JK/QXEPYRuLQ/j/YqIj?=
 =?us-ascii?Q?2Pd7frQJhM+mUi9mapjaxl0wXFSDf07P7z8NXRYSZp9QICPeVWoeIDTRd/n/?=
 =?us-ascii?Q?XcDjiWOH+uW5JhsdIPbgNsLGZAAIWos1Zbfz8oqGjDJLubfhb914Uy54yNEH?=
 =?us-ascii?Q?U7fzpRmkzN3TeeB59KBu2xRP/evYwCW82wQIJfzrVorv1AR4mlB+mmk0MY9C?=
 =?us-ascii?Q?RDlWrYNdgfmcArp0K5R5Hi4GsCkoq1VGhhtUn9OsVjk6T7XNS9jtLPS4w/iO?=
 =?us-ascii?Q?loiljJyj50SOzcnjfznFHMdqtFTAmc8g2xvQrK95ur4BpGnuearJUgZcUvid?=
 =?us-ascii?Q?vOnTacjfwIVUbzT+8csuVyNS7y4F8A2JCG/MtIrL2aNUpYK9TLDcd03XCxmG?=
 =?us-ascii?Q?2cilRNGE/SDz54IdOGnTu+sMTwxZnj0gcJ0Px7g72p5t9oLx8z1Y4H0nhgAh?=
 =?us-ascii?Q?GlsV010Gjwh+zxfF/Pc06QolswYamO3SAkd2Vpo6U1cnlsDCw+X7A+xisspG?=
 =?us-ascii?Q?tIbbYeeZwAlhpIInUeTYabDSKt+/TJNQPKcWurGQT/7QPJU2v8LUpeXh3KBm?=
 =?us-ascii?Q?WzxdP4ChIOiFMUYcgOjJQlofrqQNEEz9g/wAWOdzOayyZQ/JRJh6js//MY/8?=
 =?us-ascii?Q?MkCl5gS3UrBktryJweWWE3dHj/R8WdhZI71GwiiYGNySPxHbWWaerljRKcJj?=
 =?us-ascii?Q?X+93U49lYqy1LbII3mVAKGvGEAB+O5VoCE188BZy2rFAueDJ8qXl+m7NaH2y?=
 =?us-ascii?Q?qbnc5JRfbGjgeAwM/sbZJ8dzSCANFMiiQ5HcrSAB1IK1HbDxw8rmlIivHsqD?=
 =?us-ascii?Q?heDornFWUJspJif2mlhDc/MN9SkJr1Vz0g9TrxT8oWRFkTja2woAyXLw1kd6?=
 =?us-ascii?Q?YS1DVWsSjAzw/oTLvlTEUEUAOEgCZcpuwqLUw2d8fT5yyJjYQA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:14.6529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 680cd180-ca82-4ad0-d974-08dd196d91f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8760
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

No need for an IP specific version.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 93e2cc41e19c3..47759ef026213 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -94,8 +94,6 @@ static void vcn_v2_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_0_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v2_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				 enum amd_powergating_state state);
-static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-				enum amd_powergating_state state);
 static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
 static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
@@ -1846,15 +1844,6 @@ static int vcn_v2_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 	return ret;
 }
 
-static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
-
-	return vinst->set_pg_state(vinst, state);
-}
-
 static int vcn_v2_0_start_mmsch(struct amdgpu_device *adev,
 				struct amdgpu_mm_table *table)
 {
@@ -2132,7 +2121,7 @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
 	.is_idle = vcn_v2_0_is_idle,
 	.wait_for_idle = vcn_v2_0_wait_for_idle,
 	.set_clockgating_state = vcn_v2_0_set_clockgating_state,
-	.set_powergating_state = vcn_v2_0_set_powergating_state,
+	.set_powergating_state = vcn_set_powergating_state,
 	.dump_ip_state = vcn_v2_0_dump_ip_state,
 	.print_ip_state = vcn_v2_0_print_ip_state,
 };
-- 
2.47.1

