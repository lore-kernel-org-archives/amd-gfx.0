Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5157EECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BCBE10E839;
	Wed, 14 Sep 2022 05:15:21 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2083.outbound.protection.outlook.com [40.107.96.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77D8E10E839
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:15:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tes0MK2u+buVDZWrdgN563eoeqUNw393qJyN+5HIzAhBm/rDgjvtOqMFBXKLyNcYcW9PzXokVcgNp1+WgtLhOYoju1+85OKqb4Np7QQ0bLa1fQByDDqUqWi/PzqCHPOo1mDi0ZGiVQsAOHoV5laB1hXtTgMt1euq5qkZeTAvOl1MXcigpKFmMizA2a06aAgpT1Y80CikYhr/y3QEZ4keJPVz1otxq03aAi1/iU1FDbkJcl+0C05R8A8tW/Yd9/hll+fLuUZJHo9G+Qw8jh7+OGYqWxlEmMVslh/iUmtCEC34vTC+NlOXT0j7ZmkI/EyfdTNrEOSOF6gX1JHpCz6Mqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nM29T1x1rH/IJq1msxFUGvJ8GGpg3TV31j7SyKEDSIE=;
 b=iQZ12m3R3StOz5B0d2Cz3+KDtz+5NLobOswsmbqF2oL5U/KSc6V6iAFlx81eePLMcEzUGeazCyfCuATWoAL1hHyU6mzFXboJDwoVn1/skvVu39xZNUs7ct6Dkbcu8HNxcWU/1HWhTLcIGWYaFQ3kygwNjFgaBcMmAgYc9Oi0Jhapb/jEnBTyz1iNEEO0duIUbN4oEiP6753k2vSpPornbXMP5ZcDDY4UwcABY1sd7VLSYNT23hrFKYlsanO0GVWMLDbVpWL79di/9eJgwfeHnzq03qruesXJWpu2t9unpKyZPu+ZdopgUCM33WR3dYWwd9DAVDJMUeeqaSzRtx5Agg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM29T1x1rH/IJq1msxFUGvJ8GGpg3TV31j7SyKEDSIE=;
 b=aUaR/wXsBqa1ggP6z7Ep7FAVfnt3hIrgflPTj/e4ZXo7pR2SWHqdSZecXe2Fe4GqVCD2Ucujjjw5DtREqFwNUYTLAc3efMyAPV4Gs9H+RFodHtlLO4u34RgBQzo1nWiGnRZWCj8mjQFVn19CJJemVtmAHv9NZ7Jclx4qyLj2eD4=
Received: from MW4PR03CA0155.namprd03.prod.outlook.com (2603:10b6:303:8d::10)
 by CH3PR12MB7666.namprd12.prod.outlook.com (2603:10b6:610:152::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 05:15:11 +0000
Received: from CO1PEPF00001A5E.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::13) by MW4PR03CA0155.outlook.office365.com
 (2603:10b6:303:8d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Wed, 14 Sep 2022 05:15:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5E.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 05:15:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:14:28 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:13:50 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 17/47] drm/amd/display: [FW Promotion] Release 0.0.134.0
Date: Wed, 14 Sep 2022 13:10:16 +0800
Message-ID: <20220914051046.1131186-18-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5E:EE_|CH3PR12MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: f1be37bd-8ca6-4ede-d5ee-08da96101925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JF0IlH9X/IwWB7vB5FsvmQDvqxbaGSMNZaCal8EfmUZe4UgUgg1ojHcuaHwBYUfRdJ/L9A9P8qwqCF9uEDlObE5q/9KJVfopu4snwNfVyfFZSxwMcGq1SHn0ubAm/5N8o8lDBmbi+Ytj68/d7VRHn8UYhjvWbUn1Aeq8dHw/KAyKELKLH+fzyGZ7MOOQRhrv6mm68Z9fYNEYJIsoOznErDDP0GkuAjOuH7rWU4l17+F8QbjYo3hIH9c2C1NoT4fWogkdXctRFleRcpbgv1b2hI9NeRMprW4aQH50ZGWoObQ61pHSMRnyHBfbymuj/YBRfwOXJw75aGnsB38kQrX2mXeEhythGYq1TSJ92kQfUux34GsJpAGrOSooDJk8k0lnoVkN/owdJ8IYC/qLsC2pw8ZduSqRLlQ7ARW7ebNiD2orjtXK8uopxNe2vYPHYLwktW8D+DCrVmxPkTekU5eOCz3ZKPBGMU8HK8iUwTMtzJ8MH6t2yKw8dE6/mdE2LJ2JugO1Tqxfm0Tq6qF0Lp1nr2Dg5HolUU6UGEvJlxPihSgjKFUWe6ttXFD64dIxNt/138SZHlqFZUQwmylVRDxH38ay0u1JOGvS0mVvE7sToujxGVOwUA//aLC/K9RzI4WQ5CPcx6YE6QI8BKonvPXgKt9L4pDilE982ZrIbYzbDLfcQDEoTa9PLKnTAAQI65GJuQO3fGWiBeG+xfcSLXmooYJM6MOUAlVukjzDfKBsCBwAjPhTrlkdMUI4fiNurlWiBb9Wd8vK6AgZV3wt4hQM+/iCrgChCvYyNi3wCaWI8OVBjLiDK3k4QW2QSEkjwtpd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(2616005)(82740400003)(356005)(70586007)(5660300002)(6666004)(316002)(2906002)(186003)(4326008)(1076003)(40460700003)(82310400005)(81166007)(26005)(70206006)(41300700001)(54906003)(36756003)(426003)(86362001)(36860700001)(8676002)(8936002)(478600001)(83380400001)(40480700001)(7696005)(4744005)(6916009)(47076005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:15:10.7056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1be37bd-8ca6-4ede-d5ee-08da96101925
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7666
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

- Handle pipe split case for SubVP:
  Pass in pipe split index for main and phantom pipes

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 7cddbc431b57..6b9a529e9f12 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -998,7 +998,8 @@ struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 {
 			uint8_t scale_factor_numerator;
 			uint8_t scale_factor_denominator;
 			uint8_t is_drr;
-			uint8_t pad[2];
+			uint8_t main_split_pipe_index;
+			uint8_t phantom_split_pipe_index;
 		} subvp_data;
 
 		struct {
-- 
2.37.3

