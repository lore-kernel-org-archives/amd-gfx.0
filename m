Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46380C19F4F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A80CC10FCF4;
	Wed,  8 May 2024 17:18:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TG/ySAuU";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AF0A10FCF4
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCRPrbG+p2kRzMxQPV+HOCwDiWIrUL81Ih9M5bq/zu53oR0D+fR4gINb9ZyGRESp0L9eq2o35T0cRCLy33yPJK5hU14YuuppSljQHBJpCzJ0qLMWQfh7uJADL4bAZ16wW+CRVCNPbUnn47o4fguQajp93Ht7f8NRYDs2ijYuEWLX2VilW0MAUYbkj+lmL37oXZ2UJR/yLXD6GHKAiyl9cdwmEeeBgHQI3utIsppOjgNBbkp1Ta3qcG29fgxfar+y7RH6/MTVQ+WkAcK5HkW2jGy7MLGnJPH2md+hlyMTbmxK55HtxtOT3ECSxYgBril6KMAiWfunPXyrAbVHC6FSrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfsca+8lBHqoj12OpCXTja1FeD8Q3+5CpggG08Vch7Q=;
 b=O5HkiaPu5/bHjKXwBvr4RN4iV0DSrc7XDhivv6ZkkL84X1O7pqg00DnMP6YjN946vwqKwsIFAVfr7+nobHAp4Rrm8BxwSAUC93duFBjZe4Qw/L4QSltvCT0U3A/RbeQINOxTBfc88lj3DUk6wxsdHeRqJ6KA6R9zecNH4/ivt5KxkXgfnHiwbdiZZodHPgVWV0+ZBD9pESFhlp1Oze/CaAoft1txtR973AayyEDbLjUMlrv1c4DgDvgyxDpiZEao3Nxmv8MvugqMR8GrxBNfN2IRN/58tvvJgKSBsHuDEyGmK8vG5FOTPZZMg+A0G+j5PBj+tPlZccM/EMf7+3CeCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfsca+8lBHqoj12OpCXTja1FeD8Q3+5CpggG08Vch7Q=;
 b=TG/ySAuU5OAImuvI174wOPvlGRbZoEpPxxGDFcW9d0s3AHjGhPmYOGXxQ4QRG7lGsO+wSGivdZf+HKUeSGI2X2a6VNesEUtW0W7yr57LmOo2ycYZctCfm+yNyKIOKjbh4PaJ+oaOv5fwDfjf9/oaHA8sMeH1DAPCR/vpaHGlt7s=
Received: from MN2PR08CA0027.namprd08.prod.outlook.com (2603:10b6:208:239::32)
 by CY5PR12MB6249.namprd12.prod.outlook.com (2603:10b6:930:23::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 17:18:37 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:239:cafe::fa) by MN2PR08CA0027.outlook.office365.com
 (2603:10b6:208:239::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Wed, 8 May 2024 17:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Wed, 8 May 2024 17:18:36 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:18:34 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Chris Park <chris.park@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 16/20] drm/amd/display: Reduce I2C speed to 95kHz in DCN401
Date: Wed, 8 May 2024 11:13:16 -0600
Message-ID: <20240508171320.3292065-17-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508171320.3292065-1-alex.hung@amd.com>
References: <20240508171320.3292065-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|CY5PR12MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: 93523a24-fe58-4a6d-ebf6-08dc6f82e574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B9AK8UEuEO1bmlE699IavT+B+/1DphHGuu3v3SaedAdkFXi2oC5YpNSJxlLI?=
 =?us-ascii?Q?Z+js+jSWv4i+McDo002kWawppSupEKp4cyhiB4gOdxWvgaNXDBVVOotkCzor?=
 =?us-ascii?Q?o4+Dd7E9qlnq4srIq8ZusPiqndePl1GF1D1ws9NxVmJZ4MJRRJQEDlyFQA0J?=
 =?us-ascii?Q?VWGdsrkf7mVDsBJA6UXMigB06w/cWSyYFEIKAT23bS9wSz/mflYaFHIvmcxI?=
 =?us-ascii?Q?BdxFMDzVgODst9ZoiLlg1+ahS6rO82aSQXesBvBFGDSk/xGps2w8N3v66ewa?=
 =?us-ascii?Q?6Bz2ErWiVhBR82xhKHR6rfwyHQhZuC2hTKhKcI/sc2NvpzDJJ0dr32UfgSZE?=
 =?us-ascii?Q?SekFMsvLIUTrSQ3tvr1mX33k9a9ouluO7k+REsBR4tLZZ1AcpiU3CA+3up7e?=
 =?us-ascii?Q?gLaqedWYRCq1iPj94K+qhFeAEXPPDkVOKukrB75qBjuMuuuYOsbItW8/VP9a?=
 =?us-ascii?Q?p4LC5vkzTB6hTlVAy5GbudEj8FDXFwEbK4C4yOxJNbVN5xRSrV3R4nYxlwgi?=
 =?us-ascii?Q?bScEOYGeM+Vx/fyoG7x9svVgOGu57fRPgQNhRBp5PH9Iq8RLrCpoB3pQhONt?=
 =?us-ascii?Q?dmVDsKUL8NpSLMBHcoy542kHt6d1Q5UvmTodSftlfa6yuT6uUGgctZTkPKJO?=
 =?us-ascii?Q?aMfvYrLIq9CTvWW8e4lbeeab/Zb0AlouRGsbGUf+Rg3/dH/90/4f1JiauMm/?=
 =?us-ascii?Q?r0FA6XqnQ7U5JHyQj93ESqH0IX5+8ZjMXfJ6LzlWcwcnrgKqHYDyUAq9yrmm?=
 =?us-ascii?Q?MRdhJID/B/0v2nbYcY5aj0ltIen/I9EVmkKYIBpQkONDbMOZ4iiMHiIjwXlV?=
 =?us-ascii?Q?CuxfFo0M5/XmKkBZBmwSugGpfD+PAHOV8mYUVvzeajsBQQQbktwFPMKO54q9?=
 =?us-ascii?Q?zLO1sJI44N2YGI/m9EZvJBvxwezmQkkfWpQ8uLDZhjJEh9Sksd2TE19yYH4Z?=
 =?us-ascii?Q?AVdrw5THzuIlwL+AjL2rCO/62OXwQzUHccIxsitegsZ4KmLCOoOyCqSoTyOP?=
 =?us-ascii?Q?0X6sbG/BEWx3rWMrv7hpEkEG4uKYAovHtn9JDqg315eX40W22oEZxpUBlog2?=
 =?us-ascii?Q?IYXUHHsWLGJ36W6v9dZba/4Qx+ApuRpwrglf9uTFB7c6XfFnP/KeTLjQrzgW?=
 =?us-ascii?Q?cjUcGDF58JLt3Q8q+YU/lZw+m3r10F7/7+iY4iHOkHhRoyoZMDKOnS1Km9vo?=
 =?us-ascii?Q?jcWJKPNDvnI+zqTu8pNOyv32sNHULCa2ER95HUwa86huVv6LMadD1ZtGQRhz?=
 =?us-ascii?Q?KnmauF4T+S5Fprsns53YwSU8XWUXBZB0VgbzqdSoeI+MYxKlqCiklkbp6qX7?=
 =?us-ascii?Q?qQqGnO+TrzXNStza7FMXdmbZgJOrGY1pVE1xkbAC8XJOTURL6uRhoZQmwbcf?=
 =?us-ascii?Q?UhPonHoFdUUahlFm5xMjIZnYP1K0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:18:36.5531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93523a24-fe58-4a6d-ebf6-08dc6f82e574
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6249
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

From: Chris Park <chris.park@amd.com>

[WHY]
HW for DCN401 is presented with a small I2C speed fluctuation that
exceeds the hard cap limitation of 100kHz occasionally. This violates
compliance requirement and will result in failure in compliance.

[HOW]
After various measurements and traceback to previous generation HW, DCN IP,
SI and SW driver agrees that we can reduce I2C speed to 95kHz to address
the I2C spped fluctuation in DCN401.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 75e2c62ae792..a55421363772 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1772,8 +1772,8 @@ static bool dcn401_resource_construct(
 	pool->base.pipe_count = num_pipes;
 	pool->base.mpcc_count = num_pipes;
 	dc->caps.max_downscale_ratio = 600;
-	dc->caps.i2c_speed_in_khz = 100;
-	dc->caps.i2c_speed_in_khz_hdcp = 100; /*1.4 w/a applied by default*/
+	dc->caps.i2c_speed_in_khz = 95;
+	dc->caps.i2c_speed_in_khz_hdcp = 95; /*1.4 w/a applied by default*/
 	/* TODO: Bring max cursor size back to 256 after subvp cursor corruption is fixed*/
 	dc->caps.max_cursor_size = 64;
 	dc->caps.cursor_not_scaled = true;
-- 
2.34.1

