Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746EEC433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 20:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4210C206C0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 20:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lwu8PMKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4210C206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC05889E41;
	Mon, 29 Jun 2020 20:49:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE5A089E41
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 20:49:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDb3J9KUKnykVZMq3H00huq1C97YogVkaZIPk6ffju4hyiGRuxY7NUX3RCnZDJqaYQFOE5JzNF+OcmyMSMFzjNoWxu0J3tluhE2OfJzpAvzXTAId5JGmoZ2fCwp29QNoztQ9jY07F8O7ufQbFwKk4Ef1rBYcP1BwIkiq9AtD3Hg7ki+2NUXuElZ4pn9nYPmySXDMbSeMdwXziHn7HXp+CTHA4wsK2z6fbC8ra6qQ/WrvLH1Xq8bOLfOgqEHGV/Z8yyH/rLDSZwXlHQPuXIs/43Bpuie8ycWgc6vFtI1ucg9vsMQzzE7Qh3IleREsS9OgH+EDMk6hP92mNsrVyWEeMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5+DE/vB1wep2eMGjxvuQQhazzgR0VNYEjhD/33T7D8=;
 b=MLT+5FIg3vD3LhSbP65FxB/NKUMvgGzwSMTj+YlkJWrdFZS5/GDIpxDcpUL7Qn0YtkL1SsWcb4/qcgFYxJIE598a3QU37kXZj39YYswkJdMqVpLfVAPcQ0yXJ0b06cAAugDyaJvdtW5ai9HFEYl6D3LuZWiQR9B/JoTX1QX25XF9aWcVz6JR8tzal3NG5ibAGxAs9Znn/siUO9EM/ppwwkG2+dFbvFdYOX+1EKhFtRncqB9Epvs3Z0K4zAA/cLEEheJhwVYVKs6Ii2sFQ7K5cj2P1Dci02V6ODxMhMSFcL4yltzk8IwHPa08iUikw1rzwp1t6PSzbFg2hQ4Tf3ConQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5+DE/vB1wep2eMGjxvuQQhazzgR0VNYEjhD/33T7D8=;
 b=lwu8PMKvnhd8N4dJbWpcxeWgGAis/La0IplOc+wyXDp4bDa0xu8taNgpCR4g6e4DOS+1S8H3PFA6oNr7FSnxs4sbSm7SdYlvASqhLoOhzS4XRqB8qTQfTQ1olDQqSGJ228Wkimr4yW9XERo6H1Q0MD6OFg/38pUEvCDeROZ37rU=
Received: from DM6PR07CA0060.namprd07.prod.outlook.com (2603:10b6:5:74::37) by
 BL0PR12MB2436.namprd12.prod.outlook.com (2603:10b6:207:42::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.23; Mon, 29 Jun 2020 20:49:46 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::23) by DM6PR07CA0060.outlook.office365.com
 (2603:10b6:5:74::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23 via Frontend
 Transport; Mon, 29 Jun 2020 20:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3131.20 via Frontend Transport; Mon, 29 Jun 2020 20:49:45 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 29 Jun
 2020 15:49:45 -0500
Received: from DESKTOP-3JO4JG6.localdomain (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 29 Jun 2020 15:49:44 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Only revalidate bandwidth on medium and fast
 updates
Date: Mon, 29 Jun 2020 16:49:24 -0400
Message-ID: <20200629204924.13426-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966005)(44832011)(81166007)(82740400003)(70206006)(356005)(36756003)(966005)(478600001)(82310400002)(4326008)(2616005)(186003)(83380400001)(2906002)(47076004)(70586007)(336012)(426003)(6916009)(54906003)(1076003)(8676002)(26005)(15650500001)(6666004)(86362001)(5660300002)(8936002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49492523-26c1-4aaa-6341-08d81c6df506
X-MS-TrafficTypeDiagnostic: BL0PR12MB2436:
X-Microsoft-Antispam-PRVS: <BL0PR12MB24366B029195915C9AD8D242EC6E0@BL0PR12MB2436.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:451;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKdVauOcjEiXYF5H+/3X09UpL8WZ0fjiHUP6+a9QyUzOBWFfUCFpulbdxIzTkr3EDa2u2G8EVrgljzSf9oNSqqEt+mbkxFqtpQLKaWTv3PS+Q0fzIbAkEJGu3wx8NIetHOBL7RcqH6nyg5V4RNTbbHdLySRpg3e8uHq3Yp9Wonp0SksfAnyawEEAeuRiSIzwjCEh9ZhcKFSK9Fl8jEQUQPAjvpvjWQXvy4feBUV9VzfCSUJwbsy3Zhg82OQzl333ypCkUQV/v1DuCwqaNbeKQr3qxOt0Z+Dwum3498Sv3PSBA1ThespgYN5CcHzluScz6iFDAl+BQqz6rlCET5+2Ap/yPLj+IXZcEJB/Afjc4N/E5GgWgh7xk9QQeBbpHxKlzvVzA3djBeBQKUi/lGNojnYzFoMvIbwaZva4UWl7U9IXnEPQLU/bzRtQ8hNRFdI7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 20:49:45.9943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49492523-26c1-4aaa-6341-08d81c6df506
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2436
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Changes that are fast don't require updating DLG parameters making
this call unnecessary. Considering this is an expensive call it should
not be done on every flip.

DML touches clocks, p-state support, DLG params and a few other DC
internal flags and these aren't expected during fast. A hang has been
reported with this change when called on every flip which suggests that
modifying these fields is not recommended behavior on fast updates.

[How]
Guard the validation to only happen if update type isn't FAST.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1191
Fixes: e1995f0909e3 ("drm/amd/display: Revalidate bandwidth before commiting DC updates")
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 67402d75e67e..942ceb0f6383 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2607,10 +2607,12 @@ void dc_commit_updates_for_stream(struct dc *dc,
 
 	copy_stream_update_to_stream(dc, context, stream, stream_update);
 
-	if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false)) {
-		DC_ERROR("Mode validation failed for stream update!\n");
-		dc_release_state(context);
-		return;
+	if (update_type > UPDATE_TYPE_FAST) {
+		if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false)) {
+			DC_ERROR("Mode validation failed for stream update!\n");
+			dc_release_state(context);
+			return;
+		}
 	}
 
 	commit_planes_for_stream(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
