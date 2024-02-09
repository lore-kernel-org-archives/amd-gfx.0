Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8E7C4828F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Feb 2024 14:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A866D10F542;
	Fri,  9 Feb 2024 14:53:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CA8komM+";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2775110F542
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Feb 2024 14:53:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQwG5pPeDebITr4syM+B5vrPR67U4LwZzVFF7W3VWh1NpX0JJ3JTQw0Tafr/cxzJe4gZ6MGaa4atMfTwLwFr3XzwEHMrpdSYqliXHgka+la3O0DYdmuGF4hYBs5dmOvquTwK4hogEBTEVZ0u16Bu64cCy4Xk3pVuR78bqgb/1dBq/dvGFlSaExmGfnJ1avoROzvjaZowuj4GuJb43tMFMa5sROTlatOmuqLu9qC25sdWdxaAE2YsdLgeKHVcanZm6IW2Q3lVjIhaYmsiN3FjlwAoD5nI+WYXhZG4ctUKE3DC97uC25LnFTDr7d81U8In6iiNK7WjkMJ+W18xUctt6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFXAnVLX6PJK3jBP7Na3cNh4WY6v1i07zOSvw0RaRcw=;
 b=b5k3CPSAc2PF0eebp8muCS43DabNgWlqKu9MyIjNZDZ5mHAFHbp+k1BbqS6n2zejLWwOTG0542W9X8gnC4eNzCNo6uMAhxUJSNV0wHy5LQB03vlYKOuo56P7NgwwxdsM+c4/8NLKQEwBNru2zzw0LnLPdtQZkT/+pz7sruVJFpDPpeOQobHF1aRx0issofmAwLx/2LxhKsjyv3SXn6McQGoIKcMu/UXvjuILBzgrE2oEmDr5JJH7mFsaQOXqYdNBuMTFKBc2mjCT0MVMgCr9UiwnSBShyv4kSOR87/PtFw3Z1p1kJnr2nygrIlllhayxPB5FynCeZ+0vDX3exgJBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFXAnVLX6PJK3jBP7Na3cNh4WY6v1i07zOSvw0RaRcw=;
 b=CA8komM+YMFZJw6GJ+syFdZm4tAjMjpkgVjhmPcqpRf9JloXjM+WNwIbf0M5o4fqd2UecG/+zfG9bdF0VQMk09EEHkYhtPwK8ApBVRuOdfMXfd7pafeGMwiJZbJCQRqsimD7+T3XciKkVwQvSva2lqwwcUFmqnxvv/XkP3BnQ+8=
Received: from BY5PR17CA0061.namprd17.prod.outlook.com (2603:10b6:a03:167::38)
 by IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Fri, 9 Feb
 2024 14:53:17 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::ad) by BY5PR17CA0061.outlook.office365.com
 (2603:10b6:a03:167::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37 via Frontend
 Transport; Fri, 9 Feb 2024 14:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 14:53:16 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 9 Feb 2024 08:53:13 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Bhawanpreet Lakha
 <Bhawanpreet.Lakha@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Fix && vs || in
 'edp_set_replay_allow_active()'
Date: Fri, 9 Feb 2024 20:22:58 +0530
Message-ID: <20240209145258.51727-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|IA1PR12MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: a0096f4f-3705-47d2-4000-08dc297ed948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ruAEsR8Ah/xNYejyoZHzt+zoU9yS34S6hSa+QOHLEOSIrc2+U3z7Wyts6ezw1uCAqQMTvitbu2T3GSQ88YoV/evg+fHMLxp3rFhG+WiaLVg9YEKgh8wTGn/GKpxaYxTt+YZDThLQwW8fHp9rfmFK+BF3OGhlOCnyMUNOexQKofLEXvutE+snRTLe/US+HCPFRAcGl5iPsuXfjM4JE9JZHC2Wzsxq6MxpgT5g6D0E4Zj/jLaBVcztk3EGAzR5fulhRMWFzFuFMujePeIxZtWy6xWte6+Kq0aXyJkh7q4vKUA38Y5iOVOQsisgsUrNhb3XLe3kdm3k8A6eXhhpIxd9Yqng8s5Li3st50ttTE29/PHwVowyPALchWslIub6nz7ravPULtZKmYWPPovY/g5idZwr7c/xPV2JNUigsQ8DpR/tMANZ5OimNQG4ujpAwx6KsS6XrY2of17CGYE9X4EtKIHvnoMmORm+WX0x9ZPyrfvYSGzZEV2frriVOtmo4Q6mAzmERM0h9RGslM614Xe3sQGUIl7ay8TAvBgE+d2Yy5fjUzVK207mFF0sK8l96jj69+NZLnfymSbycyUuzMYQlRu9vdvmj+AXnvkm8GAkdlQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(41300700001)(6666004)(70206006)(7696005)(2616005)(8676002)(5660300002)(4326008)(2906002)(44832011)(426003)(86362001)(16526019)(478600001)(26005)(336012)(110136005)(83380400001)(316002)(81166007)(6636002)(356005)(82740400003)(70586007)(54906003)(36756003)(1076003)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 14:53:16.6526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0096f4f-3705-47d2-4000-08dc297ed948
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8554
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

AND should be OR or it will lead to a NULL dereference.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_control.c:895 edp_set_replay_allow_active() error: we previously assumed 'replay' could be null (see line 887)

Fixes: c7ddc0a800bc ("drm/amd/display: Add Functions to enable Freesync Panel Replay")
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_edp_panel_control.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 443215b96308..77648228ec60 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -884,7 +884,7 @@ bool edp_set_replay_allow_active(struct dc_link *link, const bool *allow_active,
 	struct dmub_replay *replay = dc->res_pool->replay;
 	unsigned int panel_inst;
 
-	if (replay == NULL && force_static)
+	if (!replay || force_static)
 		return false;
 
 	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
-- 
2.34.1

