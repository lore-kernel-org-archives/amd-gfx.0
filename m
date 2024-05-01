Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E350C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 304A81130C6;
	Wed,  1 May 2024 07:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OUdqdeY4";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12F771130C8
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:19:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eP78+zCWJlL+AiEHfEWutiWAA9dtCsS1twZiv5SXDhe9vBbLOJX0q4g10T+4V2lNcRtFIV+qPg2duUSkqvViB5xEUA/Q/9M5+TOe28A/mvz0nxwU/clFA/SbUNv52Q6Z/oPik9MG9t4o9PufA3hI0USxNpY3x6SsVpxuhTDz2N4/hAVwR2qTl6W296cA+JOiVEFDAXEGwuGekr0YwEV4g0zKEBkQM49srq++3e8e6v91SaCmefEJApVApWvGJYVW6L0/YUv7VtiBjnl9u0oZfTjFEcebrGL5uV8SqukVrTiVt1qQxtjdlVJJirGQA3SglmjC06p6uF+DtxEfyzMV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DesqA/V83brMsCi8qMvn9M+fOTSeH3vek7NPMoMs/X8=;
 b=UCrSNmDeAO1JBqhh3QN0A98b6bPvKekIhZSU2paP6zFDRDnlZwjTVjPSSE9UHo0A1AmkSeVjc6qLBvVz4E4oXkQFA2TExBguNCHcgdyVQraOOAtK8nDPRE/rNWwyOHHbNLiz5cx7+jpV1finN0fEmD9v2mD4OdNU7InypOSC1loR3ZinxetWrZTAXWxk2Y72nQCQKJX+LEg+aP5UpA64jL21rnSNgGexjMVrkaN06W/DLIg1jFEkw7txPJrRiNnm+av0wRJ03nQxRty+oLOYKQrDp5J0BiHUo9gl1PrpfDjLw/Tne2v/bzFwA0EmM9h4f7pWCAGUp03ravYok43kig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DesqA/V83brMsCi8qMvn9M+fOTSeH3vek7NPMoMs/X8=;
 b=OUdqdeY43EbHRaBZAdBmOXxKqgcHFo1ikiE1cACL+R61DsZQ2VguMGqvnYWcpUA/ffXUFx01ycwxgU2RcufbYJZ1Sy3QG+GuOuqIusJCotFJtVPlFjAog6pAcXL8cwlOgdzjo8llVugqFei9C+0LzZvbvo+u9pb1ZOZBkQ81Dso=
Received: from SA9PR13CA0078.namprd13.prod.outlook.com (2603:10b6:806:23::23)
 by SA1PR12MB6702.namprd12.prod.outlook.com (2603:10b6:806:252::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 07:19:34 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:23:cafe::29) by SA9PR13CA0078.outlook.office365.com
 (2603:10b6:806:23::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.22 via Frontend
 Transport; Wed, 1 May 2024 07:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:19:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:19:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:19:33 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:19:24 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 25/45] drm/amd/display: Release state memory if
 amdgpu_dm_create_color_properties fail
Date: Wed, 1 May 2024 15:16:31 +0800
Message-ID: <20240501071651.3541919-26-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SA1PR12MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: 5efd03fb-b062-486a-eda6-08dc69af0d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nYoWLAEoTV3ofXoDrvv4hgydu3V/K44bRXoZ1PpD5cpg7OlT03I6Ok4o1Xer?=
 =?us-ascii?Q?elz3WRKfbNSc1cBGSO4VrMIf4Ci7W4Jo8kGJIxowuO56/pX9hgtqEYCSiUU2?=
 =?us-ascii?Q?vXDKAQj9V18QXImgx+y8qe9Wjc5pucpEyLioOMfG5kKCEW3tvFUg+4fIN33O?=
 =?us-ascii?Q?p8eBrb07exnVsvp4otDFq6Vog+aJ0cwtuPp5O32CBkP387933H+CU1jKtGx9?=
 =?us-ascii?Q?a06TtA/UPxwrd8hLMh+oSkFgyMsSctsOFNBeN4LeKt0X5ARbOusKWclcNZDu?=
 =?us-ascii?Q?6JG2c/Vq4t3DIhfQM+wjod5W9Rkn9weyNa0F1UB6dfrkm82gHdM/PL/8bP+l?=
 =?us-ascii?Q?afmtE7HuZepEl15NfYLyrGQvEKbDWDxU6VGNMt6iazTYhdPKhL82xSPrTb2c?=
 =?us-ascii?Q?xA9lLxD9W2th43KsRvVKVumB1+06+UFqKHO6U76mJ0NU35lk8Ka6NHKN95eZ?=
 =?us-ascii?Q?p1txsX1pMkRjywnkl0xsxcQLl48OR0Gkpb8fKsCqR7l/aNgNHwsbP14yvK+U?=
 =?us-ascii?Q?eIQCVZPSIE2g+Jy6RC8qPtuAovvAgS/JcdUFWicRyJ8QLApH1pnOmooJiGcx?=
 =?us-ascii?Q?wTLLfqrIJa3EtbZEQzezzJSRdKLp0ccz4/tIovqYQD407jmcDCfNl2+WveG0?=
 =?us-ascii?Q?VGtPY1+ICIPKRawCrMcpGzYyLRQU26wSvwKrx4CU3RFC1UzWIQzLPQRpKdjy?=
 =?us-ascii?Q?TzW26ysowxL7c2T6OIlVlHhbG840Zl2+qycL3VkX46mEvT1dJQiiV8XVVbec?=
 =?us-ascii?Q?+bQTLVLFfiP/8I9bIuKnTPu/W5f+kTzIJmO+edybJS28cOnbjKmFXIp8+Kk0?=
 =?us-ascii?Q?45xGfXnyon69BFwrxsA2PW0FdmO8aMBQac87WVTrKUDv4rAZw1VhPA0OB2Rj?=
 =?us-ascii?Q?Xb/sQTIRbqKI98dz8je3Y/0QM7UZoJH83YTboJMZo1dxxZNstOygly4sxhZH?=
 =?us-ascii?Q?Wt32R1hTPnsrLfqBvQ1gE+UsyryVbLi0UDp2cHotn8vK4qRhR4/CkePQVDG9?=
 =?us-ascii?Q?/uhwRzaRVnIuMNsf2YRm81N2APaw1LzqHtjiYxIHBIYzucxaLRSTpTBaH3De?=
 =?us-ascii?Q?FTH2oyKLzhNQ21w4wQ2Q+mp7NWCK3IW86tSXV589jiuX1wrXzw1v9cP510f2?=
 =?us-ascii?Q?TkrpNYp/Lru45XIKMhCycOAgm5JRY9hwG/iWn9/qRlIF6knw3WSxTgx/FliM?=
 =?us-ascii?Q?W2utWePj/pajQD5hsRLnl3Tku213ptkDNXVdNcMtjywIS/1/lbmviO6zwTs3?=
 =?us-ascii?Q?NxnQC0P5+FKYNJ/970Gk3222J3A2T0rPZc0rJcVagVPzcK9EsUvkiPuWN4zb?=
 =?us-ascii?Q?4gxK2d1EPVbCN58buPt0S/LntITN5tnkj1NH06mD405hzz9iB/VL7h+wx+Aj?=
 =?us-ascii?Q?vgWhv2ty6rmYcn50zIT/Sq2C1D+1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:19:34.2940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efd03fb-b062-486a-eda6-08dc69af0d53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6702
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

From: Hersen Wu <hersenxs.wu@amd.com>

[Why]
Coverity reports RESOURCE_LEAK warning. State memory
is not released if dm_create_color_properties fail.

[How]
Call kfree(state) before return.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index af35bb3c3b19..3abb2e6e7ebb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4229,8 +4229,11 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 	}
 
 #ifdef AMD_PRIVATE_COLOR
-	if (amdgpu_dm_create_color_properties(adev))
+	if (amdgpu_dm_create_color_properties(adev)) {
+		dc_state_release(state->context);
+		kfree(state);
 		return -ENOMEM;
+	}
 #endif
 
 	r = amdgpu_dm_audio_init(adev);
-- 
2.34.1

