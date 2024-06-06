Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCDEC27C5E
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 050C910EAF5;
	Thu,  6 Jun 2024 21:58:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m7IxceSF";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D95A10EAF1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:58:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzZ8FUe0fl+F9Q4nSsrH9aZrrMNXGYR5wPiNqzfeenKzZgxPLrMqsVBeoMYHnFJlrmG5aLQGyOPw/fvnkyok7QmuxMou02W56kJMhPVTIuhWcr4OyRgGRS5XYLDgTTQ18qPm0icYBr47J8Y4/RMTDNBE9TbFeaTc1EsFYskKQFAgKPoVASRd8CshWUAQefEGjJ4DNY1rEKkXM+9cMh4oHhhk23hbI4ZMW1U+yzDC1S8q30XimqbtmMRo/meNwKTzezRZgCuIhTwk4EJdQPT1O/FIFetmBA+u7eiUQhalDQ3d26svMKkWk/CmIuFDk23M0MteF5DKB0Y/vFXof+EC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8irxpssh6eK9CZw9Zf72f+DXswQCNldCvQNX67npwvc=;
 b=G1v9NG7crkrqs8EfklUUVFzDuAriKpcod/k3SdsFmTGx+/22S5RnAYCcb0bX2e1yFdSf8bVcLT5z+Rrvsn2/dit8M79A98wsV51+G/a7HQ55QS13HWZ6XVspzAr6/PWx3XC7VYTpeBeHEob1jHQde4K15u4KTHYkQgPfLKOvIw23vQgzpU9JU2ErcFZ8dB0mT8wLPbH6ZFvm+70LYgtM1eYrT+g/PcrsnXW/PWAFM1WRlYoONtNC2sVoHfwDVT4+GUKSl3GAhstZ03KvPr5lZ3xp4OeLsNcLRv/N7Sx0KjIGfNmKu2VF0M6D9tGI7RDSqWhLRmee5dNpCoR8tv++1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8irxpssh6eK9CZw9Zf72f+DXswQCNldCvQNX67npwvc=;
 b=m7IxceSFUpKFD4TY9ZIdv7nKNx1aP3tw5xsaD1hgBEjHDVHjePqLmXN+Ri/LVVuw1t+PW05RRjOcykWfI2cuqrjkHBe0ARgo7BhYQh/HDtbzduIroF6Ylu9uypfOybwKzpgF76abAgN2K3R8UeXSQ8EiCCefGVnPBW2PAhrnVhU=
Received: from MN2PR15CA0048.namprd15.prod.outlook.com (2603:10b6:208:237::17)
 by MW4PR12MB8609.namprd12.prod.outlook.com (2603:10b6:303:1e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:57:59 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::80) by MN2PR15CA0048.outlook.office365.com
 (2603:10b6:208:237::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:59 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:58 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 44/67] drm/amd/display: remove ODM combine before bandwidth
 validation
Date: Thu, 6 Jun 2024 17:56:09 -0400
Message-ID: <20240606215632.4061204-45-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|MW4PR12MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 868c88ea-ac46-44ce-bc31-08dc8673baf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?apVa3wo8BW3OHLOjQIh+xkzEI1ycyakPurAJ4aY4aCFVWB9Q/gTDAS4Gdo1C?=
 =?us-ascii?Q?JdrmQEqQp7BEqbQC0EWENfsFXRZpi9fHSoi9yj2F4uaE88GF1l4y4ysFJ4KG?=
 =?us-ascii?Q?ukj0a1T3QMBkG1xzepcAxVDniTG6FCm/7FcSUYzR+Mqd5idfIh1E5MaFZTKw?=
 =?us-ascii?Q?aiqM2oc0+uHMwBTg/viaJDIW4+mya38LCTzZC+OjWFDGh0MlclyPlvMoeGJd?=
 =?us-ascii?Q?xQo7+L1+ygbmCRpl+sVWdnVXG0Sr/XRZznDelJJ026tHLX0JkUDFh4IP2RZl?=
 =?us-ascii?Q?OOMTQpz3S+S53kNaKpfchRNb+JZ87pCvyI5F//IX3Vupp2FUdwvkaKpJktat?=
 =?us-ascii?Q?VaAcqn8Epj22Xkp2Lwf0U/DsiU8O6XoUP98YLcAUu6fLkV4z9kwaT4Nqrr4s?=
 =?us-ascii?Q?0EvmaW+2/99qLlOmXprhKq1nxddFmhxhdmGkjGoGcnr74ClS3KLgJHI9A9ul?=
 =?us-ascii?Q?v/IOuO4HaHgNkWlGEFC0A7/hVLVCSBny1E/p8NAb7eZeDqPLuIggfhy3lvJr?=
 =?us-ascii?Q?NYwmBdyM1PeshuMvNVGYTFXSBOIUPaH1VHAJMcbrd/+nd2046PI7dtQ/JB//?=
 =?us-ascii?Q?LqRM6pYZ78tA3GyanlH9tdZrw8H4IgA7ZzU92MVYZqgQy8NSyFqi960PZWLv?=
 =?us-ascii?Q?7iGjivjBhhllGqXW1p2MKaP/SmYlLN4SrpKiTPqQGI4oNcqeFMyqqFzo5d2S?=
 =?us-ascii?Q?zR70D7uNEqWSzrTY6nyIWvA6YAlvZvxecGu3mXn8QJQYi1zY7jGvQsrzZABf?=
 =?us-ascii?Q?kLZf3uJ4plO6z+u4zcrsqE0mjmaUjUdflQ17XymjcPVKxhoww40G7/6zRWs+?=
 =?us-ascii?Q?2diKy+kB7MRGRNNGEPb9tb8PcTxPvEPWZMGA86ZGo8RpLjjuz8z174wttc03?=
 =?us-ascii?Q?zRp6wcuW8JO39Bm6imgHwoXNdUetRVq/+k9+/qTUbGs1g8bt1/ex+diRUsiq?=
 =?us-ascii?Q?O2/xUYl/PQSY9njAV56ZvFkZN4NkIuwTJGKHNorV4iFnpz58WpKGghT0IYLc?=
 =?us-ascii?Q?ZNVuYGLgJWufhSee7JO2U7jdg8vYHuyF06aTxI33ggPXICwLuDqPbCYlU+YP?=
 =?us-ascii?Q?yCsliHxW3hMuQ6vh2lNyfswV2sIykkn4fExJGjl6RXQgEsDgky0MjeztquA6?=
 =?us-ascii?Q?XcEl65U95mlp1rU3F7XXsos0BZDNpRnOZdes2TJ2ZizEuEXvJp89rDuvryWc?=
 =?us-ascii?Q?/xaDm3c253goJdliE7PdV7lT0HXef5MAw8Keml/5NgYdn+6WpXvPlvwJg9F+?=
 =?us-ascii?Q?UAfhhdyq1D/Lj1QDxurv/rVk7vPd3w6Gm7DCOrnyiywWubS0e7lWo8zMuMM6?=
 =?us-ascii?Q?rgmJz6IVIiRQd5mbipEFsrZyJpr9cVZbRDnYXW5cIflBeSdzR4rddJ4FRI7j?=
 =?us-ascii?Q?x6RUAZ6dtgSViEV2g9vxea8V20ZcIB8z8aq5OxZkWNKZ7Fkujg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:59.4908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 868c88ea-ac46-44ce-bc31-08dc8673baf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
DML1 validation code doesn't have the ability to remove ODM combine.
It will directly translate currently used ODM combine config into ODM
override. If ODM combine is used in the initial state it will only
validate the timing if ODM is used. This is not correct for dynamic ODM u
se case, as ODM is used as an optimization not a hard requirement.

[how]
Remove ODM combine in the initial state before bandwidth validation so
DML will not translate it into ODM override in the initial bandwidth
validation.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 194422dd979d..5ef10e2b9443 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2154,6 +2154,8 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 
 	dc->res_pool->funcs->update_soc_for_wm_a(dc, context);
 
+	for (i = 0; i < context->stream_count; i++)
+		resource_update_pipes_for_stream_with_slice_count(context, dc->current_state, dc->res_pool, context->streams[i], 1);
 	pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
 
 	if (!pipe_cnt) {
-- 
2.34.1

