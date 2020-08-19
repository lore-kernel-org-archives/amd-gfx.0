Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40474C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 17:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184AC20758
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 17:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184AC20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A58086E0D7;
	Wed, 19 Aug 2020 17:56:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD1506E04B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 17:56:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEXNS6chWgmi4WATI7vgjjUI0rIqkOyNYBV/mBl1CIvpRO5LalvMq3AqDwHpBfIxQPp2j1jyaEUfmVMufvKiLTg/4EFCDXiT+YUYgGcKZh8mkh+SgMVLyltWwSeJBMkGQDCGD1JTXO+IS7UiceHEh3ryIMu6s3FNQcgkr2P4lBLrIzzGTVWSOR6L7QgvXwcHDgQa8xg97deZgRo8abU/IFdEKLepGp3NFaEy5DUv8C/p6z2REwwOii43ysRfnHljjXrOcRS2NLKaTV3H1St101QmmDswto7nGTjlhrpxbJgYfFX0ysrOKzY/5/FHq8hlXmhgCNjRlC9lngmDcBgjYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCVRSkHzMp4hUCNbZ98FpMk5bg0+s1ogBzI6DpmdiXU=;
 b=b0EEp5JiSmbdWDeK59J1EKc1/rqPBllp9WjPQQOMbEJUStS+GD/gAHai/ziGTYsf6FaPcKqfE2fK+FvvYuR5t5Kr4/bW4fmbJiEjBncv1ZklBDmSoJBpIbTzsOY+UPjV1/X/D7xYJgaXQl2BVusfGJBmCoVd8k3ehAlZayCpjExCCfeYoGJIx9fRSYMZ3yw+0mxToc1zdeY29AYtDQF/sUuvH+EvF/7RGcNRglTjDsHGAfqQt1BV+1i+JlwDBzEL0dOz/XMIWIDQRUtQU7aQ3zPnE3uxeIDR4hpJGh9rD3o6mqXAirDV8LqzIk9f0ncsu/fz7YnYXJq1qN9BqTfKvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCVRSkHzMp4hUCNbZ98FpMk5bg0+s1ogBzI6DpmdiXU=;
 b=hNkzLsV1BqDaikYuCSSTo3/DV4Nn4+RVwKojdWoH7WGFQ+80zbcyzrFpyS8+Hg+7YWsrFHwrKeiWAf5/cDpgPFwBg8GwXYZcPzv4eYm/i9cJkqrDMBakcmAwwC/B+3WecH72qmb9A4TxwH39FWZCxdTKRLcItSbavBMxjkv/KjY=
Received: from BN1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:408:e2::11)
 by BYAPR12MB3429.namprd12.prod.outlook.com (2603:10b6:a03:a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Wed, 19 Aug
 2020 17:55:58 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::8f) by BN1PR13CA0006.outlook.office365.com
 (2603:10b6:408:e2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend
 Transport; Wed, 19 Aug 2020 17:55:58 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Wed, 19 Aug 2020 17:55:58 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 12:55:57 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 19 Aug 2020 12:55:57 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Reject overlay plane configurations in
 multi-display scenarios
Date: Wed, 19 Aug 2020 13:55:56 -0400
Message-ID: <20200819175556.285629-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7b36a21-88c7-4f37-96be-08d84469209e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3429:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3429BF3CB3B7AE637DC57248EC5D0@BYAPR12MB3429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BB9iZF+w4h/91xUuppn/Vyn+uNRX6Ph0NtLh8u8fe93ZGIoxt9LtUY4Ga1oo79d4Qa9K9dkY6eYMXLl9MfJl+ax9AQhIWVHagzupPB7FNLiK6HxEL4H7cKG7eu0PbXoheG8qH0Wuo+jWybQwRiAu7BrWLrf7xvoGE1fzt5qMzDa4yXNZ65sWNYxZsrvAy8jZbiZjKqXOfrOrw5EQBCAjfKByvHDVluW1abtp+BKGE7oIM4NHt9ezVAu03GDteGLOUm+hg7DeBgyaRbKV1NgaNkUkcr81ePWuAM0GWoTVLLGOvVg8mNnG+KLt/0sCS0GuaCFV5RbH92I8d52xtvFaNpdiHP+Ezm67sYqNVDt4Qv0zarxNes+hbQeUUduJWrsUwnQE9tiGKAJXQI9+6P+LNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966005)(82740400003)(4326008)(70206006)(83380400001)(70586007)(86362001)(2906002)(478600001)(6916009)(81166007)(82310400002)(356005)(47076004)(2616005)(36756003)(336012)(426003)(54906003)(8936002)(186003)(8676002)(316002)(44832011)(1076003)(26005)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 17:55:58.2024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b36a21-88c7-4f37-96be-08d84469209e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3429
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
Cc: Hersen Wu <hersenxs.wu@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
These aren't stable on some platform configurations when driving
multiple displays, especially on higher resolution.

In particular the delay in asserting p-state and validating from
x86 outweights any power or performance benefit from the hardware
composition.

Under some configurations this will manifest itself as extreme stutter
or unresponsiveness especially when combined with cursor movement.

[How]
Disable these for now. Exposing overlays to userspace doesn't guarantee
that they'll be able to use them in any and all configurations and it's
part of the DRM contract to have userspace gracefully handle validation
failures when they occur.

Valdiation occurs as part of DC and this in particular affects RV, so
disable this in dcn10_global_validation.

Cc: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 07571f84e0f8..1abd81e17f09 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1213,6 +1213,7 @@ static enum dc_status dcn10_validate_global(struct dc *dc, struct dc_state *cont
 	bool video_large = false;
 	bool desktop_large = false;
 	bool dcc_disabled = false;
+	bool mpo_enabled = false;
 
 	for (i = 0; i < context->stream_count; i++) {
 		if (context->stream_status[i].plane_count == 0)
@@ -1221,6 +1222,9 @@ static enum dc_status dcn10_validate_global(struct dc *dc, struct dc_state *cont
 		if (context->stream_status[i].plane_count > 2)
 			return DC_FAIL_UNSUPPORTED_1;
 
+		if (context->stream_status[i].plane_count > 1)
+			mpo_enabled = true;
+
 		for (j = 0; j < context->stream_status[i].plane_count; j++) {
 			struct dc_plane_state *plane =
 				context->stream_status[i].plane_states[j];
@@ -1244,6 +1248,10 @@ static enum dc_status dcn10_validate_global(struct dc *dc, struct dc_state *cont
 		}
 	}
 
+	/* Disable MPO in multi-display configurations. */
+	if (context->stream_count > 1 && mpo_enabled)
+		return DC_FAIL_UNSUPPORTED_1;
+
 	/*
 	 * Workaround: On DCN10 there is UMC issue that causes underflow when
 	 * playing 4k video on 4k desktop with video downscaled and single channel
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
