Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987DAC27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2C010E288;
	Fri, 31 May 2024 16:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TMY6rcnN";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3219310E255
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bf9RYs/+dwBCPV+VquaqaZR+8fns0EPpINe6h61Ql82Es7jqSakdEkMuSlzKXWWrfHTwdNBgOpNylA6Ov4fcOydcGYWIPejPd5Mvo/IrEF59jZGW2woE10YrkXnemZHL7y26PMP4yomBSEuowq7YJbFU4NRC0H9h1uDe74HBdlpZ8CT9tvBbyAXuaaLrvTLNrilUoKwM/gaCDppx96KuJamIf+0CEGhHDA598Gtnbyo2aAFlPpARv9fjU7dtuoSbcxjRcvr2yBMhXwJ+C4loQR30j7kq/RCQ9rMGmc4LvVLFUiIYl9aP0gxFIVWYmKO7/j2nSOIXLuGpUx2zvOiDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hg3+7/HFD8ApvPLAkaiGuLtacpBQNUVWluFSF6GrJoI=;
 b=kT1aAK8k7+CNy+s381c5Ps3vi4V7vsbrTxf9S0onH+fM1rXhUA05DuQ6eLlMTOCyEV4E/2K9YbD6aDFV5sUTzOBkoEzUaTG6Mwf00XgYMHN2+EDUuhHunU3r1IR/WEapqPgf2KjC5OvSrtGi7HdkPk+4CFygqqtaJ4Nih4W/ZV02ecH2pJxah3GZ/FBx46bTwL/puZCNY7CoUNvx4gvAm4UoXkyJ2mS23SsdjxwTsrK3P4Zl6JiA8CnAePcG/AF4tFwDe3mF7qpBrxxFgOUD2RS9Cnv2dUZpAP4CMJjUCocg/K9ON9FL6sMwTK/8Df/sxPIdSZCCKoVTLledoIhIng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg3+7/HFD8ApvPLAkaiGuLtacpBQNUVWluFSF6GrJoI=;
 b=TMY6rcnNZwo7snOPgZ/WkI8ER4gvOYKhvmbsZH6is8Z4KewCP+O9/LbRakkdX9fxrN62MXASJT6hlX3LMIOUEoJr+KuoD95g5x6aT3JisiaXpIYxtdjjU1/V82Pj+AiXeimkVIruCCuSHrEvYo73pV9qP8YD3AMENx9VCAjiHJc=
Received: from PH7PR10CA0023.namprd10.prod.outlook.com (2603:10b6:510:23d::21)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 16:52:31 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::1) by PH7PR10CA0023.outlook.office365.com
 (2603:10b6:510:23d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22 via Frontend
 Transport; Fri, 31 May 2024 16:52:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:29 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:24 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, Aric Cyr
 <aric.cyr@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 04/32] drm/amd/display: Fix swapped dimension calculations
Date: Fri, 31 May 2024 12:51:17 -0400
Message-ID: <20240531165145.1874966-5-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: 9859548a-87ec-476d-7911-08dc81920f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1Fz8dydcDpdLIvTNsKHhzIpUsVu2smwexzeYgwAGhEQhE9IhlkpxfzLifu1U?=
 =?us-ascii?Q?GqAvjavk/waJlYCIdMuKmjuF50fCeOtDr/u/EK2spCAxxe9hDO9m5HudL+tW?=
 =?us-ascii?Q?x+WPNPN7W07BKuyBsrkHYb4wPG55Jxx3OkMKffR/afS4YUhsJw5lLitmnPFl?=
 =?us-ascii?Q?oiJ9luh/X3MDSC7lYiZkCU6GlPHxaXiVWlSzQRIn1puQC2MJwVwlnWtP0cZC?=
 =?us-ascii?Q?DOt1Es0CwSJKXkd4MhMOcaotghLS530JNEX8pgFTBhaKHa3HD6rV0rVzrty3?=
 =?us-ascii?Q?nrQYe4/yLsll8SQJ/o01WNCKCJuC7uxmV6ORJ1eQja8KjRn+ETNAr9K6vP6L?=
 =?us-ascii?Q?DvsySjxo84wPE6AoT/9z5Vyvp1kVhoM4q0WV05iXhc6gWvo40YTL4gPB73y3?=
 =?us-ascii?Q?9Jvghs1ucoBlFFO3vKYmEAD8STfAy8DRk8rR3/t8pnjFXTgATmPRw3gzcF9Z?=
 =?us-ascii?Q?lY1jhYvG2gQKzE3uuhA/4r43Ib6nItTZvJo1KS24BsanTHXpbxlhjuBop3qD?=
 =?us-ascii?Q?cNTC/9y+NBgccgwBPYFF6AcCgBbpD/vvio2CnCxTQjcKUFl+W43MNiPeciTM?=
 =?us-ascii?Q?mTPPHo+8hFiJMAMT0UjFA1ADOajsWAhwV0FbFflrTXOS4m/0eGNZPuiK2pNH?=
 =?us-ascii?Q?MmmrfIUN0CAtKWk6M8mq8r4oifami8lpuXWezKPrK8lMcX/XYbxbRrS7zucl?=
 =?us-ascii?Q?pQ7cJ7XrmXJ+XSEIO6Ac71b6/RcLKhg3W2HUDcq0mCxASixww5b41eO6iXNL?=
 =?us-ascii?Q?u9BCK/UYrD4hvFVhb4lY6MiSDzCGktUcpdO04hEKRZOIpCrwqCJy7t3AH44F?=
 =?us-ascii?Q?3rHzPtgX9r/3pBGl69R/lq8JsQ23D3PGvOPXk+9Aj00ahzbi/dsj7WSrcRsk?=
 =?us-ascii?Q?9DTWEJLyaAyxJ+Vrv4Retb2rJdD8dA3OsshG6+V7hOJzbz5XD5v3pJepIXTx?=
 =?us-ascii?Q?2Ep/kKiHfWPLkcmAFigfk21gXvhGhQjhD6Hmf32kXKNj1uc2nUxgflua4dxS?=
 =?us-ascii?Q?ORhkQy+7WjG5TAeiitSPnzPKcBeg7Q1P7asfGqQ69ByRSbzaf+6au90EfujF?=
 =?us-ascii?Q?rKQcqYt79bgwrnh5TeygmjmfS1926QjvOh9I3y75QzUfAxh3V+cEXs/Pedea?=
 =?us-ascii?Q?gPvqKay2cuLaPQI6cY3Lf0wyXeD7MmuvZQzT42AP1Gnp9qtHzAzNmFZjK30G?=
 =?us-ascii?Q?ucHPlHC0j2V99AJmXS3eoZ8WAD9woU2ecTUElB42oP7I/+Dx9ZrN8RNsz3yE?=
 =?us-ascii?Q?zkHDGlkgOlGJL0QCd3jxtJJAeNsqbDNiRUOlPxEvfJFnjMCzWt53fXXjbsB7?=
 =?us-ascii?Q?3BPREvmpXuRMMejKpknPngcqurW7Sn2dXJjhIQwHSQP03sGbjfeXHIaGKwGf?=
 =?us-ascii?Q?2wpzBSqhGfZhDuO0Ry4B17edn9/q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:29.6055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9859548a-87ec-476d-7911-08dc81920f05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
The values calculated in optc1_get_otg_active_size are assigned to the
wrong output parameters, vertical blank is being used for horizontal size
and vice versa. This results in DPG test pattern looking wrong during
hardware init, as the DPG dimensions get assigned from this output, and
potentially other issues.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
---
 drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
index 03140e7372d9..336488c0574e 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
@@ -1423,8 +1423,8 @@ bool optc1_get_otg_active_size(struct timing_generator *optc,
 			OTG_H_BLANK_START, &h_blank_start,
 			OTG_H_BLANK_END, &h_blank_end);
 
-	*otg_active_width = v_blank_start - v_blank_end;
-	*otg_active_height = h_blank_start - h_blank_end;
+	*otg_active_width = h_blank_start - h_blank_end;
+	*otg_active_height = v_blank_start - v_blank_end;
 	return true;
 }
 
-- 
2.34.1

