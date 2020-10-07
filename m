Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F748C4363D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B781E20789
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tZTo+DB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B781E20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AF596E8DE;
	Wed,  7 Oct 2020 12:42:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08D926E8DE
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 12:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4BXKjKknCYS7kpGzaRXLRpFCUxK64uiFyopsa5Tg9yTL8h96f2k13W5cbIlaXViqpdb1WMHXsLbTlizZgTVywzGix6V3Zwc1MSR1MmMSsjAIDQbX57ug0wZ1s0a2Q7FtPbHRJexpGoQyZ+3qeUdPV4ONaswlf8b9aLZw+y5p2+8Puv0H/y5AqxweICTe4zk4NLwJVIuQZ2YPRyHdcGpV3Km+UQtS+6d/rCg/1BsGk+FPssY25NbRZKCoX2ouJeRN+Q3qPlu1Q/n/LpNwdxRgpFZvElnPRrUvFhqmB4c3hTRRDgJX9z49FtsH8WSPmkZFNP/tZb//PRN1T0MT5/N5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTavLZjKpPkbWJyo9aFWqlGG16hA48aSTp+WndmUqvY=;
 b=clCt5q2NnGz6ayTIDlsNlRQCDuuCHA0TrXe5/lmHicC7eUEQCi376sSoMERQMPXuTqZL7fRf8vuM49udWtA5Ppf38Ksg/08M9nFPRsK5IpWkcs3hsUgOVMxngI9hIFzs+Jy9gwq87I10JC+yRbOGcamVHB+b4n7X4OyQvtR0FRwc8tvPH+XZaYIQfNombt2KyVx8h3WEf8qaTFKmzb8bZB3tDi3e8tDenQuhBY+RZkftW2g3fngdRFM5cugwYQb7mw4K1pTvRWtjrXDnlm312MBTDhbCn7EYlhqCIdW0xe7+LG1qKmqQxatLAeYQbTvjP3K2Lwtkfiz2hSBkr5H5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTavLZjKpPkbWJyo9aFWqlGG16hA48aSTp+WndmUqvY=;
 b=tZTo+DB92vt7hAZgOj1whwbp0ld1IVICSUN4sBqjGZ3m3oiCOBruEEYHMOZoPr5vadCe7r1v+EYHFF1b8P4mmGtuTqUfBbOD/Dm1BCKUOqhZFmCIzF4YZdMpMbzoLu7xn+ul9lcMvvTN25pZHI12zqnklNZ8QENjaLsnxEf/NFI=
Received: from MW2PR16CA0045.namprd16.prod.outlook.com (2603:10b6:907:1::22)
 by MWHPR1201MB0240.namprd12.prod.outlook.com (2603:10b6:301:58::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 7 Oct
 2020 12:42:36 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::f6) by MW2PR16CA0045.outlook.office365.com
 (2603:10b6:907:1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37 via Frontend
 Transport; Wed, 7 Oct 2020 12:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3455.23 via Frontend Transport; Wed, 7 Oct 2020 12:42:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 7 Oct 2020
 07:42:35 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 7 Oct 2020
 07:42:34 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 7 Oct 2020 07:42:29 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/12] drm/amd/display: Reverting "Add connector to the state
 if DSC debugfs is set"
Date: Wed, 7 Oct 2020 08:42:18 -0400
Message-ID: <20201007124224.18789-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201007124224.18789-1-aurabindo.pillai@amd.com>
References: <20201007124224.18789-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70c984f1-5603-4f2b-f9ef-08d86abe77e4
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0240:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02404555F909162232B396888B0A0@MWHPR1201MB0240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:110;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37zQWX1YBsJ7R+m3uizM1Hmlf6hNnEyLiWXYMED8YcVJ/9rPVPSpdZe+onbzGnjLegzYyRKHNdkbXjEEgFgeSv9IvJYEVo0jSv0fUM9CTA7OOpDxBtRxsf3IwuzfGLfP7p3XaQLi2cjkZ/zLTA+1bYADB//4Lzmh1smR3SlStOR7+LsepoVYiEkCF8jj3hCAC1CgEWi5un0guLaBL85gGgBr9c9b0EW/lVpUrgRWxgd1l9zwgr6EgQe7cye6zh3Zh5kQFR7gRdcG4P8NDFfzwhcweqwciI0xyJ9H/l9+ebywM0gx1HgKB8Dn86SsctY7bkMt7X2AaY2stYfJUmzwrndXSHDhoq8+rtxU3d8ric0tk19IYBWdfvds/k+jJSO5OIjISyBzAf+BKaIwebLHNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966005)(26005)(426003)(36756003)(2616005)(336012)(186003)(44832011)(478600001)(2906002)(8676002)(54906003)(7696005)(6916009)(8936002)(316002)(82310400003)(1076003)(5660300002)(86362001)(82740400003)(47076004)(70586007)(70206006)(83380400001)(81166007)(356005)(6666004)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 12:42:35.9191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c984f1-5603-4f2b-f9ef-08d86abe77e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0240
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eryk Brol <eryk.brol@amd.com>

This reverts commit 39edb76689b8c9e41b1b9e2557da4897a405221b.

Reason for revert: Patch introduces performance issues and might
cause memory consistency problems with multiple connectors.

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 41 -------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dfcea66ee23c..03a45c3331c1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -848,45 +848,6 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void amdgpu_check_debugfs_connector_property_change(struct amdgpu_device *adev,
-							   struct drm_atomic_state *state)
-{
-	struct drm_connector *connector;
-	struct drm_crtc *crtc;
-	struct amdgpu_dm_connector *amdgpu_dm_connector;
-	struct drm_connector_state *conn_state;
-	struct dm_crtc_state *acrtc_state;
-	struct drm_crtc_state *crtc_state;
-	struct dc_stream_state *stream;
-	struct drm_device *dev = adev_to_drm(adev);
-
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
-
-		amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
-		conn_state = connector->state;
-
-		if (!(conn_state && conn_state->crtc))
-			continue;
-
-		crtc = conn_state->crtc;
-		acrtc_state = to_dm_crtc_state(crtc->state);
-
-		if (!(acrtc_state && acrtc_state->stream))
-			continue;
-
-		stream = acrtc_state->stream;
-
-		if (amdgpu_dm_connector->dsc_settings.dsc_force_enable ||
-		    amdgpu_dm_connector->dsc_settings.dsc_num_slices_v ||
-		    amdgpu_dm_connector->dsc_settings.dsc_num_slices_h ||
-		    amdgpu_dm_connector->dsc_settings.dsc_bits_per_pixel) {
-			conn_state = drm_atomic_get_connector_state(state, connector);
-			crtc_state = drm_atomic_get_crtc_state(state, crtc);
-			crtc_state->mode_changed = true;
-		}
-	}
-}
-
 static int amdgpu_dm_init(struct amdgpu_device *adev)
 {
 	struct dc_init_data init_data;
@@ -8661,8 +8622,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	int ret, i;
 	bool lock_and_validation_needed = false;
 
-	amdgpu_check_debugfs_connector_property_change(adev, state);
-
 	ret = drm_atomic_helper_check_modeset(dev, state);
 	if (ret)
 		goto fail;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
