Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694FDC4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF1DA1130CD;
	Wed,  1 May 2024 07:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wZdX0P3X";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D141130CD
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:19:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTnB2Tq4rkqQbuVnbrBjbZjl5tr4mCgjyemut3cKaOWwTtD7SJpYdaFCLPKxyiG++jqWPlNY3vOYyKYyQusCKwXnAd18ULtIm+RR75P7ii0BKgeX1QHU+3L3Y4F0CpBushhQblftVp6r6WLWMb7iyxct/htobU7yDKQSLraOtnCniu9Hx0o8CB/1ZiDqSwF5sispp6grgGiQHOWgWSM7CuYOsAFpvlKfxVTM//+BRrwt0HtkCG39UxHtajBBlpjDty+akJXyN4cTL95VHFvLtjF7gKf2RrIVAH2QnUSQU64YuJleKOE2Tsn3V6TzhWw94XCwx2nkJw1RgGNiNuy5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJFsAJS/8XTnYPhAFtWLtpD2x6TQv5KBM6oWcTLQTC0=;
 b=HA/PQsANCDXGyVLbQ9LcfnAEtunYCHLWPGk7fd0LLgnDgd5EXOHDlZFEl7hqR+oYZ1RQoxelUR1UmSboMoYEeXmGU9yxt04fb9llPc2HAOkFpXCkuHOKPaGs8kPejb8Mtc+QBSfY0cEjN8PH/3vwB8oBsF6A71zvSXEf0Sd+OB5npedjA3OoNIub8IiakAA5pN8zkug/KHCV+Bf2pMhopM59eI46BH5nwED800MZZbVyZ5wK5hjstGL5P3Coh4uNfSCJXm++x/aOww/OKAjzH0yTf3m6KpV7TbFl7idrUKr+6S+aXQ/peKxUCiV+zQZ+qWr4Dpnw3joO/3X685m+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJFsAJS/8XTnYPhAFtWLtpD2x6TQv5KBM6oWcTLQTC0=;
 b=wZdX0P3X8a9CLW16rAQ59YgnmcfmkVCS9/AWKYFC/u7j47836tkTblUPUxRAaavpy+5CF6N+/AAa1QgJ4R13/G4IZ5GABLCcfG54z+Nsj0mD82ja7N2sR53tkAnRuC5J69rx+J4XhACpufATCoXcTdzuzK5h/TZSCBDQ4wpcFZw=
Received: from SA9PR13CA0147.namprd13.prod.outlook.com (2603:10b6:806:27::32)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 07:19:54 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:27:cafe::79) by SA9PR13CA0147.outlook.office365.com
 (2603:10b6:806:27::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25 via Frontend
 Transport; Wed, 1 May 2024 07:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:19:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:19:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:19:52 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:19:50 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Swapnil Patel
 <swapnil.patel@amd.com>
Subject: [PATCH 29/45] drm/amd/display: MST DSC check for older devices
Date: Wed, 1 May 2024 15:16:35 +0800
Message-ID: <20240501071651.3541919-30-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 65200f4c-f258-4a8e-3f64-08dc69af18e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lSJv97bip/RpMq6/p5XbB2lbM3dibcoLUKwGhYSAJNV/bn7iM/XyH11E51vb?=
 =?us-ascii?Q?AP1IKEQX5Z1AcXD/s+iidHLMaz/AcDpPjaiH5M6o4E5NxicOgUej5dv6EWr4?=
 =?us-ascii?Q?fZAjJ5F5MXOOvWdMf9t0axFtkK84Cnjyx5yf/3tseQS3qvVzz/HJeWGsLE3G?=
 =?us-ascii?Q?ItHDQFdfB8BJnM3t47bMXtAU0Es9y9dQNoJps+l7ZpxwYu7iyuFad5zv7FLg?=
 =?us-ascii?Q?tFLb12+V1HLYPAnufSerrTwt/SiQszVPtWt8WTNmrGw7yJprwtrfpLMG/98O?=
 =?us-ascii?Q?1eUsAb3DbFfjRz2PENtqrUd/KnUKq2sDiWy2Nyu78waUSiNATmOBwNj1PMz8?=
 =?us-ascii?Q?oioeABz5W/TVN0fpslpcvNiV7QEbRNhNsrhrFlK6jNF86iRgx3JzVAD/C27i?=
 =?us-ascii?Q?UkHcGQFy9yhG7Ygeqx/RdZs7Hk18iXvQGYh+JfbMyJKO2Zyv4g72EyAnpu2C?=
 =?us-ascii?Q?4wZk08Tyv1QOy+UolFAn+enU4LJanhkYtuRiM/msPcBZjSrhVZD7P7qr6XGk?=
 =?us-ascii?Q?YaZZoxIf9SLUaRF3W7pqestJhBFQy+h98kZwbfhlmgn1dWPK1ZcJxESa1G/l?=
 =?us-ascii?Q?ta2uRSKpnnUId0ZOLigSgP5YUoeaiXMhHcl0bf9wdzjcbmvb/Y0M4gDsdhHO?=
 =?us-ascii?Q?u7CmYsihW3D/n8peELQqLhyAU6jqFYb5KDJCQ6DyE6WuTLtPeP+IkYbsFWxo?=
 =?us-ascii?Q?1siZkR/knztxtg0CsbJBI4spOst0GCeG82ZEqU2fFI5EE2RVefHKy7rGzXgV?=
 =?us-ascii?Q?Pd3xuZ0UIknhmqf7jnCa6kQVP7zCEGPCljHUfI3FoYzuIBgmidnAftDkBwd6?=
 =?us-ascii?Q?JUesZJOcYMnxc1iO3UtUnRzgTdxH4OdjhED4+JFkwWGRa0YLg1Sbuo5aBCeh?=
 =?us-ascii?Q?48g544mhLAKQ2xeCZYInSLAz7AGxoSWM7QPDZT1B08AO0h1SPHa33RHr78hN?=
 =?us-ascii?Q?BcXjfb/Y+tWge3EYz3UJ9sJBykbVJCRz5+hn/QJNNdLfrSPBZ4Xg8u1VG6YP?=
 =?us-ascii?Q?XWXY5vRfuXls4wgqTEfRtP03ooa1x6YDhxLiMYqvtEkrOgcrF4OrQogyM78N?=
 =?us-ascii?Q?pI1WkGGuTAkK0i3hk/txsn/O6I0fkLDq04V3BI2gTmbC0WqC0oSprTwvqws8?=
 =?us-ascii?Q?kvA49VDi+fdIBYBXloevaX6hfS98dPFndd2ELuN2fLtgPhrOzWi6HV1fnWYt?=
 =?us-ascii?Q?BUj1QDvxx40q8LNmFGOzSB5IYGDcZ4YdAqAOrdCc3plMi85HdoGKqK9N8HVD?=
 =?us-ascii?Q?3j50Ymy4FhzhjGOAtYfrisMOaTxQXZraiEXGDeHn0oQt+X9D7mCQYjOrceCC?=
 =?us-ascii?Q?Qbs2oOeHKFbUag639ZlvRVQVDOmvd7Vqb0kzVPMhRlYPTZ9abMliAk+V4JxE?=
 =?us-ascii?Q?jE81bvlxah6xuFpafOloR38UyE9B?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:19:53.6751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65200f4c-f258-4a8e-3f64-08dc69af18e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780
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

From: Agustin Gutierrez <agustin.gutierrez@amd.com>

[Why]
Some older MST hubs do not report DPCD registers according to
specification.

[How]
This change re-applies change: c5365554514 "drm/amd/display: dsc mst
re-compute pbn for changes on hub".
With an additional check for these older MST devices.

Reviewed-by: Swapnil Patel <swapnil.patel@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 5542e7d63b81..affedce9de6b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1209,6 +1209,12 @@ static bool is_dsc_need_re_compute(
 	if (dc_link->type != dc_connection_mst_branch)
 		return false;
 
+	/* add a check for older MST DSC with no virtual DPCDs */
+	if (needs_dsc_aux_workaround(dc_link)  &&
+		(!(dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT ||
+		dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_PASSTHROUGH_SUPPORT)))
+		return false;
+
 	for (i = 0; i < MAX_PIPES; i++)
 		stream_on_link[i] = NULL;
 
@@ -1230,12 +1236,8 @@ static bool is_dsc_need_re_compute(
 			continue;
 
 		/*
-		 *	Check if cached virtual MST DSC caps are available and DSC is supported
-		 *	this change takes care of newer MST DSC capable devices that report their
-		 *	DPCD caps as per specifications in their Virtual DPCD registers.
-
-		 *	TODO: implement the check for older MST DSC devices that do not conform to
-		 *	specifications.
+		 *	check if cached virtual MST DSC caps are available and DSC is supported
+		 *	as per specifications in their Virtual DPCD registers.
 		*/
 		if (!(aconnector->dc_sink->dsc_caps.dsc_dec_caps.is_dsc_supported ||
 			aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_PASSTHROUGH_SUPPORT))
-- 
2.34.1

