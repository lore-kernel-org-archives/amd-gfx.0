Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F03C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E4810E8A1;
	Thu, 25 Jul 2024 18:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bs3q1IxF";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B9810E8A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZt0Q57sreVyaCNzHmboV/XHE819NYIWux2IrWnTth1geZpVHzqjzhC7o/rWJXEKcHeE54Fkwsass09+G9p/8fbeEYeTMaAk0mqnJvKn7hQONjrbC/IcHaOHu5Ax8KaREYdKoppGpShx3sLjNRvgZQgMhsmS/G5JJAXMlg5Ol9dQPhassHAin8NoO56c627YCu/jHCxMPqLkan1CWXaavcJY83B3vdukOfsp2HMKCqXqI06GEA5ro2/MyJ0gF62YgyemjP5W3U1WLSeQMb8v065QEWDfbrL6Vrgc0V0tqFz5SagyfOOoh1u2mWthKLcWgGt8y3GR/DvhwqhEzxL4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiNzaW9ERDU0pnJ36YMK+/a3XyZZjOGq+6lO0BvHmzY=;
 b=SldGhRZtG/pRcqAZoJH50kINVuykzGGJm7be9oTLrnoJnm4+TecVFz7bMAPW/SbEOXAFa5vsWRVG0xMt4/S4nO7x8tjweY36tzAcZ4kIZrEJ8Vofd9WUPqXVUSmEUAChDglbSYREuZizv86Wdz7pVPnlvTpEW1bsbPSFoX7bLob/wVxw6dJoHpRq1pqdxmkfz4ntGyJd5a1ILSc/+Vh0wgqg2NuUV3GmlW3l2ooUiFIcGqJidBl7guXbllIZR74V83alTAu9JPbvIMKC1AtOapDbz8nFPiJvaZ8UjciNKg7sOQpH9LPdIhvHvsmCX/Mil/elUZfJphCEMvBuLygVqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiNzaW9ERDU0pnJ36YMK+/a3XyZZjOGq+6lO0BvHmzY=;
 b=Bs3q1IxFrIjMfY/bDFZNFIam5HUEyyVQDY4X1LSjF55O2YTD6WRaN5PP+/oCG70IpirW5uN+YddSYxeXtBbrAynAjIFpnLx+wm6r/yCX5/HFzfQ+ifMkPZ75FwR3CMVAIYlc8Fs76msrqa6bkp8zcRoEuE9oHjdG3x4MlYZjCio=
Received: from CH0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:610:b1::21)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 18:03:52 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::41) by CH0PR13CA0016.outlook.office365.com
 (2603:10b6:610:b1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 18:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:03:51 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:03:49 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 09/39] drm/amd/display: Check null pointers before using them
Date: Thu, 25 Jul 2024 12:00:53 -0600
Message-ID: <20240725180309.105968-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fc40e0-33c0-4141-057e-08dcacd42456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oSzWbWy4qqojZh2n1WfC1E770dtcJkQa70J5sHp8M3FVutu+/WXHeAz+PR8X?=
 =?us-ascii?Q?HerDcR2h3RqLhWP7oQUB3G+HfGP4cKcQqsc/R/JQDiKgpifZLJJOkPImfBql?=
 =?us-ascii?Q?vii9qxHBFFQsoUqtJBwlrJV7oY2sUlgHy8E6CO2CqHZJeb0mVBCcqXNom7fh?=
 =?us-ascii?Q?YhBmulyOoCd/NWwQPb8O6vLG0kRRmv3T+X/5BJahlDBxfweLfbNzvy6sesUv?=
 =?us-ascii?Q?klxdTCG8YTZ0YzAbqjsyL1cS8jOSNIRa8okmFkdCquTJy+8Hl97/5OGwOxGy?=
 =?us-ascii?Q?MSgc1LimaQaWyE6W3CvcCoZkE+4va1DTgGIhVl0rgMrEerdsyj2d0bxjZId2?=
 =?us-ascii?Q?UrkncvCn/8W21II0t4VIThHUkyB2UMPlGK+Ufxv3rntxwcengACmnrIxRrvV?=
 =?us-ascii?Q?6+kQwLkFqroXHuhOsZWodxv53pBPdarDxvpnTGWylBj+OPZfC3jsNCt/T4UF?=
 =?us-ascii?Q?W1jOsuqY/DxCkzdLzs9bteP6NS8OC5k+clPb/ftQuiwwCOe1q38voIwzPGmq?=
 =?us-ascii?Q?G4p4W0BDW9t2psp0auSy833CoIH2TFmMLflSCIawq3+S6YhurgGMXiM74/kL?=
 =?us-ascii?Q?iHf5+oH0Zf1qAtj6JuHweJJJQfozWPWqgYrLm6/poYgxtE2jioTIxwv3EU7y?=
 =?us-ascii?Q?1nSa1ru0FV1pF0AI2OkDlVRUuMeJkUh4QyV6hWBazOpgJXQVOb/KtKyyeVTg?=
 =?us-ascii?Q?Aq0kOir7/kgV/wNyJ1dlQRguLY7YEZVVl6H36CJSGEf9eYgit416yAn4I58V?=
 =?us-ascii?Q?mYTW3KY6h59xtTmx3DJBIpCXozrZbge0S7lu0o4c42RLqw3kRSExEIJMKEAS?=
 =?us-ascii?Q?xYXVGjGfF0qmJr8/CzmhL5jSBFNzGRLNFBODxI9+M5FdONT7CWPWH1YADO5+?=
 =?us-ascii?Q?Tmo7+OnNVesS2nR/hqyVJry+WbKLvKJlv1ZUcAPXQBsCNTa/PO/DcLIQjjul?=
 =?us-ascii?Q?5f/4UaVnrtvzVPICG1dvtRmC6dblSpa9UYezahECjek1B8EHHy0atxcZre7u?=
 =?us-ascii?Q?ojHdEre6NEOI61Xis0aTgUCjwuxY26aetVNkIIN5Kb574GyMn9WglXTmxrkL?=
 =?us-ascii?Q?U24NNIsSNTUTFNfbFCpm5OouPuIS27395BMPeDqh227zpI5Vrjr2xPXSOisS?=
 =?us-ascii?Q?NpuoSoe+Z+cBy24ce9RZ/ZanzqJbBNO94DnhIZor5U+Fd53cbNsn0Wi+xAM2?=
 =?us-ascii?Q?SZvUEHUsDAoVE1rumtd+DbMksqrdpwIOkPbSSesAz+gc+x2fdSakPNMGeLBX?=
 =?us-ascii?Q?ZrzAr+rYYu1RQxtOHkwE/HADO+s4BAsm4k7n083MxlUDdVcC2+2saoGk2nY5?=
 =?us-ascii?Q?hH9OZleYtQcazrndYi+wUkMyA5mR4duMDO1SHPv6P3rKEWAhZ/PXCGC2Ymoj?=
 =?us-ascii?Q?WeeeoU/5XkX4iVwgWSj8D9qeW7/JCLP8eMtNG600NHx/n/rYDd5yU8E0rmH4?=
 =?us-ascii?Q?JaGd1v6L4LmEpI7WI+77qa/633H+93Wq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:03:51.9929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fc40e0-33c0-4141-057e-08dcacd42456
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924
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

[WHAT & HOW]
dc_link is null checked previously in the same function, indicating it
might be null as reported by Coverity.

This fixes 1 FORWARD_NULL issue reported by Coverity.

Signed-off-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4d36a66917c6..54e665227e8b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12083,7 +12083,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		}
 	}
 
-	as_type = dm_get_adaptive_sync_support_type(amdgpu_dm_connector->dc_link);
+	if (amdgpu_dm_connector->dc_link)
+		as_type = dm_get_adaptive_sync_support_type(amdgpu_dm_connector->dc_link);
 
 	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) {
 		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
-- 
2.43.0

