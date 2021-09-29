Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72FFC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 20:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CCA561152
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 20:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6CCA561152
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBFB989B29;
	Wed, 29 Sep 2021 20:36:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE28F89970
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 20:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HY+nackFSX1wVJ1qdZvOfVtp8vUylRqRXrNg4ipnv1q0saHGpFBxTewSEStMYHXUKgwDVIwDCBHm3gepUNnAgqGT6IyXlwoWhc36DSp6MAMu8NyJ22svKKeu4vKip1mp+bZznPRz/6YmSsWGCon3NmKBOLsPZ8pkKZkHzaV3ciBQ1jN/mV6h2JNjr32lAU4Jo+IbYDSBKGZgAdThaVq8fdlVUTbUaXgv1d8n5xVIdeO5j9dAXIf+JdlOG379mdYTiLfoOT7qbRTp7VvvgqMvtCCw2FCeyd469EFPqMdSnD5PNjAiK+zd8PjNvn1/kNUKn3cfKrZOfKDvz7ATiOCu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=EQPnKB/S5DT67/AuxYVIVvBGqeBw3fSf+Ew7bAm10j8=;
 b=QAJ+nyMP8Ll5DQDuUIA6C1vv2a9tagKTNQTSJ9XFGQps/x6n1NkUBqZ1gGvOuLu92FS/MwgjEVyxSxoP5IPZ7n2OQVrUIbyh27aMiXwL6PfXjILedkThh9RtMC+JcC9Wy1dJPwn9Vwtz5dWNTiBPoSGU7maYkKpoNJGCIUNvwb3v49cEQfvpfuENztUSA/92gGd7yYM9iUX0hS0S56P8AvRYPuXSp4zICnQ4yYA+M3vTeqIgasG0qjoxWDf/PbMYjp1+tTE/QeNZs+0Gw3hXhgL63I4TcAeuT+stK1u+IMtMjAmjQ0xs9Crb2oCQTN2vwzi5lkMA/4mxwvEJ9VqWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQPnKB/S5DT67/AuxYVIVvBGqeBw3fSf+Ew7bAm10j8=;
 b=DGRfyGEpncW0MPBRnXqm91d1XP5zwQ3jJbnb3QRNEoqrsFCW6mE6QOx8Yi3mJj1yFpl0aCK6gVyt0ZMbJ33C0lxIgQKre7xxdW/MvgnxmugCpFiBywGOdUmpY7ko8pABzRDlXSiDUsrR2S09xXLe7EggZLL+WdieYkQduWAy8oI=
Received: from DS7PR03CA0046.namprd03.prod.outlook.com (2603:10b6:5:3b5::21)
 by MWHPR12MB1455.namprd12.prod.outlook.com (2603:10b6:301:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Wed, 29 Sep
 2021 20:36:31 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::94) by DS7PR03CA0046.outlook.office365.com
 (2603:10b6:5:3b5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Wed, 29 Sep 2021 20:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 20:36:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 15:36:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Michael Strauss
 <michael.strauss@amd.com>, Eric Yang <Eric.Yang2@amd.com>, Anson Jacob
 <Anson.Jacob@amd.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] drm/amdgpu/display: protect DCN specific stuff in
 process_deferred_updates
Date: Wed, 29 Sep 2021 16:36:07 -0400
Message-ID: <20210929203607.1946811-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32d15753-b638-4ea7-ff0b-08d98388d1b6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1455:
X-Microsoft-Antispam-PRVS: <MWHPR12MB14557693CFFC7536CAA28030F7A99@MWHPR12MB1455.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OPlzoWKKoDsUrP3fhIM4LFi31JYew6PYYgnnZRMPpBrXeExVcEm+Zj6j0Lpbgyh93BBv6eluIqWoTv11fF6J45NQjcPPzu9vudi79cD4ShOQSF5yKeYBOVf5fKnEMO45iYxtMfalryQkQ57GxHUjBZeixYithKI9Lz5N59miumaEBE8hxUjQO+eNg8J/0V/CRwCS+peal2QDhkLPPjk44pN/epG9dUUXr1orXz3T7uprdH8S2fXhw4BIt8uxxIBy7OKPRkWE57oev06ucW9zpl9CJefRj+HEglNDML8emB2v3Gcq0qBJ2cT09TgMttXLZS4lrFSVtZa6yyW4NWnam99X18NQeEv1jT8VvKcvUVa2dtwNQxwpbSIYVw6K2tbj8BHP8ZNsxcaxhWXOlELQOrDckvgWsZiXk8UTSSbpRf9qYF1Uwy4+N5BL5/rqUrNG5LnVBY1O8BYXDdGslSZ3M/rmWKyoHdiOdGKatn/Jx6IOgQ0igBOOojtUftQQ6eLzYOnguYI3pRy1yoUX0y1Melehv6lLQnvxPcRUK2vmvKbeqa/6pEtq54mDtlLMmvsSGBqBPPy1Kng7Z37bJVNfHcUNUfkvR/R4R/hTko10nPQqFDR2p7kGby0l8R496VE+Tiu4tW3btxgjw5CsXYpGi94iW3E5MYbWjdMGWA7TxERfu5gizAOxiGxC5Qz2dAAOMfNYrpzOTjUOsDX+BqDTzQyk/wccxSidO4yx7wt6pAk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(1076003)(70206006)(2906002)(86362001)(36860700001)(36756003)(6666004)(508600001)(82310400003)(70586007)(336012)(8676002)(83380400001)(4326008)(2616005)(426003)(54906003)(7696005)(316002)(8936002)(47076005)(356005)(81166007)(5660300002)(26005)(6916009)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 20:36:30.5988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d15753-b638-4ea7-ff0b-08d98388d1b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1455
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

Need to protect this function with CONFIG_DRM_AMD_DC_DCN.

Fixes: bfd34644dedb ("drm/amd/display: Defer LUT memory powerdown until LUT bypass latches")
Cc: Michael Strauss <michael.strauss@amd.com>
Cc: Eric Yang <Eric.Yang2@amd.com>
Cc: Anson Jacob <Anson.Jacob@amd.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0f0440408a16..b113e7e74ded 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1802,12 +1802,14 @@ static bool is_flip_pending_in_pipes(struct dc *dc, struct dc_state *context)
  */
 static void process_deferred_updates(struct dc *dc)
 {
+#ifdef CONFIG_DRM_AMD_DC_DCN
 	int i;
 
 	if (dc->debug.enable_mem_low_power.bits.cm)
 		for (i = 0; i < dc->dcn_ip->max_num_dpp; i++)
 			if (dc->res_pool->dpps[i]->funcs->dpp_deferred_update)
 				dc->res_pool->dpps[i]->funcs->dpp_deferred_update(dc->res_pool->dpps[i]);
+#endif
 }
 
 void dc_post_update_surfaces_to_stream(struct dc *dc)
-- 
2.31.1

