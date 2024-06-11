Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153BFC27C65
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE9B10E6CA;
	Tue, 11 Jun 2024 16:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H4lU2YF2";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E243410E1BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3wCXXr7Dw2Sv6VpyROq7xamEmhd169BHdCzu7Qz8ez+w6vHcwbiBllfgo4GP09hH2b9DfJVhtx3OnBpldKFH/N++7INdVERRp/DW0gzNOs8oU2/qhtHY8UVM1ZjdjJEEpJpDeLvKLf7s/FjOzIV+UARPqVK85uXwgfbyy0Hhn4Qa6UEQHKp+9BNZE8QwBFoKoJeVwdgXjAQxJGj9aD+KYzJcenokhDnU1z/uLIrOC5cBbzSalocjcu9ct/jP0w4P5io0E1SWbBLNuMkTkFeNZ73JLZZWm9SbPENrYxHs++nitr5iY/WWlDc8h1Ww9AHwIG3YjOqTxe/uSeK6Lcaog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZQ2r8tnrZ4dXj/aVkxEf/d6ZmeQssWJbJgWUYncC1w=;
 b=B4S4eBqGbGl6CZKiZTFjQLGIPeU+uNsUoEez/S0E3Jbtw8JqJkyAqyLm99puj8JhJknI70PQ3cme1LGMN6Ik1ROenGKCY1mOgnE4Pbd+tGWtBNTu1D4WAqwGly3ge3rcMGpfGWeyQLop+0U8nABWBi/BiiGbGN7TxWk16nrtKUPwSGC6CJqmKoqv/JKEyAYil1AjcdPotA2zjsq+UhbpWwxXIBlqUO5io+tCmkDObYlIQpVoqtWftz7GTrYCHQBZrNf9Sp4G1XAcBpUuEmGAD9EfXCig8rPFoKaMJeWHJPh8xSZnY8iXa020qTo18DMrzbPP+QDCaoKvr404U2GFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZQ2r8tnrZ4dXj/aVkxEf/d6ZmeQssWJbJgWUYncC1w=;
 b=H4lU2YF2PfBZoApda7msIJLJEc29LFgHDtcOKT73DYnxIzl+zDyjGy30X9OyijfIwa7EGE/ZgkDcc6PfXcBnZ5R9y3CwlBH1V5u1Bbt4aEfyFMA4rUA2Sv3Dkqky3ZkU2N3ZCPqveFLeylOb1JhHIvvoDCckPWT0v6lnWauXkGk=
Received: from BN8PR07CA0014.namprd07.prod.outlook.com (2603:10b6:408:ac::27)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 16:52:35 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::b0) by BN8PR07CA0014.outlook.office365.com
 (2603:10b6:408:ac::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.19 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:35 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:32 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 15/36] drm/amd/display: Check BIOS images before it is used
Date: Tue, 11 Jun 2024 12:51:18 -0400
Message-ID: <20240611165204.195093-16-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: f0600e56-df73-46a7-8312-08dc8a36e4c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yvtclJrYaPXK3GXzUApsZ8kWxlrODEnC29TRsWAFqnX6+TN9qTLFX75m3zW/?=
 =?us-ascii?Q?zZ78e1cQAjhQ+QTW7lEWCClcXuiYh/r+jGznu0ZrsSDhdkjBJi3WiH61pfE2?=
 =?us-ascii?Q?qjdnCTgjULRaKN4kTo8FhVblpKaUEIaOuWPhnLnGSD5lkepsNl1H19Ek9kdU?=
 =?us-ascii?Q?vKZ5kyJjMt0YJJ250rK9ImqdrQY/OhdZzta/EHmP9S0zOwcs57pGOdLScVIC?=
 =?us-ascii?Q?YYGNouSIKdgjcyROrqreGk5Vb6fREToKE46YCIUjTBLTPvThl9Ea52dGoc2h?=
 =?us-ascii?Q?/euuk4UuMn5TjDNUthS6Ee5RBByjT/wnPzAeg3em3KJzmTs6ZnUcblHJzjJQ?=
 =?us-ascii?Q?zhAEu48/1P/bDY/yMC4JkuRp3oY3DPxBrsTuxAJvslWG8np3nKi3ku4Mt2Ox?=
 =?us-ascii?Q?1dFl2aXyW6CzCDXdjJqUcgzOd0ICBRgc2I44avY88EaMze5cg72VPY0gBdcM?=
 =?us-ascii?Q?a9VOtcMKAa8W+shyLXnL73uXq68eHh7HgTASskx7yky57n9YDWJjZLnEOooD?=
 =?us-ascii?Q?FfjuI0KrcdC7bhqyJXG6SjCSUO/sLr1ogfWPMlrFHGmBA6GYxHJIbtxqf4pW?=
 =?us-ascii?Q?tI+jPSQuta8s/jo019Xdc9GO82BpnGoY/JPM9QD6Y6+cXZk+NwXxMRG4sy4G?=
 =?us-ascii?Q?vo90uExEa+zgS4hURiqmWmIWJNEEoRKS07yLkr/oJXEr++ATkYAZOFgkV2Nr?=
 =?us-ascii?Q?D0f7MMeRlD/QdAbznthy4wXIAJPTii8LmB60NCoWpMoyNwFq9/jABu+7Rmnf?=
 =?us-ascii?Q?Lg75UdzvEV6rIf8DonT+rksvBlVUu2ZSUI+8mGizspsWTNXvHrW8DrOncyFO?=
 =?us-ascii?Q?zgUAG1cEzSBh96KtUHBA1eyoN7WTI3kylm9DmgVkdQDUVXOPvWJHdSQPmGD0?=
 =?us-ascii?Q?mrMgQHLUiIi89nliVsPoIgz+HnfPyc/ue0pPSMhWUcqG3ErNiyqCvO07Czu2?=
 =?us-ascii?Q?v2YvpTwGnLQ3o1yLfdiVm4oAk8dfjK+W9ymx4aK53XVkkf4pioJVP6+Iqf56?=
 =?us-ascii?Q?PtjPm/nnM+hfE0wxu/GxpEmDI+RFs8RpJf5wQna9zk1r/s/9OfsV/tr5T/zw?=
 =?us-ascii?Q?zoqCkYVhaQoAF0FVCN7kysH4ThpmZnzVVLvf30+Jsl8Oy/Aha67Im5hHOp6t?=
 =?us-ascii?Q?YI3WVnxUQ8vysDn0TWF2LShbMTu4UgLhQjoUq494l4JJ2ad55GUUc4Jz77Sn?=
 =?us-ascii?Q?5GM6q1hbh25AjZyf/YB3vJn9atRkpy0j+6Vit31xVkvoRsfCv/4ny/EKbNJX?=
 =?us-ascii?Q?S8Z63AcVxv43jSWJy0QxzdUh1jk6RDZzPG54kDLDKAbDmvy9reTR9oVFG3O6?=
 =?us-ascii?Q?RNkxDtUxDQQd5ITt1g8yBESfKkul0F0FqpXfPfq4iMGAvTyahnnuYnoaNefu?=
 =?us-ascii?Q?L/4JpflA0qFjgHBp1MpPjWu+G1aOi/+gNHoIM2WqnRH4rfAfIg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:35.0265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0600e56-df73-46a7-8312-08dc8a36e4c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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

From: Alex Hung <alex.hung@amd.com>

BIOS images may fail to load and null checks are added before they are
used.

This fixes 6 NULL_RETURNS issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 25fe1a124029..3bacf470f7c5 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -665,6 +665,9 @@ static enum bp_result get_ss_info_v3_1(
 	ss_table_header_include = ((ATOM_ASIC_INTERNAL_SS_INFO_V3 *) bios_get_image(&bp->base,
 				DATA_TABLES(ASIC_InternalSS_Info),
 				struct_size(ss_table_header_include, asSpreadSpectrum, 1)));
+	if (!ss_table_header_include)
+		return BP_RESULT_UNSUPPORTED;
+
 	table_size =
 		(le16_to_cpu(ss_table_header_include->sHeader.usStructureSize)
 				- sizeof(ATOM_COMMON_TABLE_HEADER))
@@ -1034,6 +1037,8 @@ static enum bp_result get_ss_info_from_internal_ss_info_tbl_V2_1(
 				&bp->base,
 				DATA_TABLES(ASIC_InternalSS_Info),
 				struct_size(header, asSpreadSpectrum, 1)));
+	if (!header)
+		return result;
 
 	memset(info, 0, sizeof(struct spread_spectrum_info));
 
@@ -1107,6 +1112,8 @@ static enum bp_result get_ss_info_from_ss_info_table(
 	get_atom_data_table_revision(header, &revision);
 
 	tbl = GET_IMAGE(ATOM_SPREAD_SPECTRUM_INFO, DATA_TABLES(SS_Info));
+	if (!tbl)
+		return result;
 
 	if (1 != revision.major || 2 > revision.minor)
 		return result;
@@ -1634,6 +1641,8 @@ static uint32_t get_ss_entry_number_from_ss_info_tbl(
 
 	tbl = GET_IMAGE(ATOM_SPREAD_SPECTRUM_INFO,
 			DATA_TABLES(SS_Info));
+	if (!tbl)
+		return number;
 
 	if (1 != revision.major || 2 > revision.minor)
 		return number;
@@ -1716,6 +1725,8 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_v2_1(
 				&bp->base,
 				DATA_TABLES(ASIC_InternalSS_Info),
 				struct_size(header_include, asSpreadSpectrum, 1)));
+	if (!header_include)
+		return 0;
 
 	size = (le16_to_cpu(header_include->sHeader.usStructureSize)
 			- sizeof(ATOM_COMMON_TABLE_HEADER))
@@ -1755,6 +1766,9 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_V3_1(
 	header_include = ((ATOM_ASIC_INTERNAL_SS_INFO_V3 *) bios_get_image(&bp->base,
 				DATA_TABLES(ASIC_InternalSS_Info),
 				struct_size(header_include, asSpreadSpectrum, 1)));
+	if (!header_include)
+		return number;
+
 	size = (le16_to_cpu(header_include->sHeader.usStructureSize) -
 			sizeof(ATOM_COMMON_TABLE_HEADER)) /
 					sizeof(ATOM_ASIC_SS_ASSIGNMENT_V3);
-- 
2.45.1

