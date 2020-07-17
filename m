Return-Path: <SRS0=DbcS=A4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DD4C433EC
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80A2120737
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nuY2whbL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A2120737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDEDA6EE22;
	Fri, 17 Jul 2020 17:38:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F67B6EE1F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2020 17:38:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yt6Dk7vW0ItCs/7w3iA5EjCdS6tSqkiGDPJsAKZIeZ2q8XBfL1hthWyIPDrLxGBF8wTpBSA9i1QGzAXrnYXR1WMBpgwsi1ngxfAMRWhKNUy4Mzo6ohzP5d7QtUGZR+sKlvY/OYXkaz/5PTLiddPHMImaIJik8zZI90GJKTKfWHx/Dz2kjReD2BR4X5RhYkmM4KLX0ENfW89gmjahppwHYG2vDTE+WCpPToFO+shfXeh5k4JSW5NwCyFjTP4q0+5IXufCsZC+CaljCA+ZIdid8uS+CspIyzq1rne9OERklEoUyB6PUwRw8P1ZLhTPvNaVnK7uZEyIXbHyqn7+hsGHGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqpvtVK+la7qTEk0LPgCHv2a2D9JhNBmO55Ug1tDJlY=;
 b=LKZCPGweZUmkNwX4QL9W/e8i9i4GZEh21M/H/bqbolSfEIlSLR6LH32PSQ6LvFjL8difjUvobxqa//60LRN9mZNYIPsrrEgVZv2EGSR1R33y+h3an/sOnFeI39rJEn5mp1tzZPcEt88meiPa0ocsuWuBoQIg8d84iDWr8j7uYLt/zqCi0b0cwD+EMzQd2yWtT8lUo8j0AH2nCS/WaNaBe6gqbP2LWVaI5GydwXBoId+a/l31Y7WVV2MYYtMMrkWFVnX4/xitb+pkfXye0IPdsS5AuhhSo5Ct93xrWrThsnKA5QJTz+lR9r/RwR1hSKgPxx0sPwdepaBkZhe+hIftZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqpvtVK+la7qTEk0LPgCHv2a2D9JhNBmO55Ug1tDJlY=;
 b=nuY2whbLI7zIBP3IuraqfC7YOtF3NNz13mEb88Dexet7VN9iapJ0i2iyluZXktF75UWaVGB7cXj7acv72F/RIVqnJnluGYoprZ6v5ERz6lTBMTYvrt2o4QmM2ef3G3uQuzSP07FbbkVccbUisR10Jzvj6utbeLbVL47EphuHV5E=
Received: from BN6PR11CA0031.namprd11.prod.outlook.com (2603:10b6:404:4b::17)
 by BN8PR12MB3345.namprd12.prod.outlook.com (2603:10b6:408:64::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Fri, 17 Jul
 2020 17:38:26 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:4b:cafe::ab) by BN6PR11CA0031.outlook.office365.com
 (2603:10b6:404:4b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend
 Transport; Fri, 17 Jul 2020 17:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 17:38:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:25 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:25 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 17 Jul 2020 12:38:24 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/12] drm/amd/display: Call dsc related functions indirectly
 via dc interface
Date: Fri, 17 Jul 2020 13:38:10 -0400
Message-ID: <20200717173813.11674-10-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717173813.11674-1-qingqing.zhuo@amd.com>
References: <20200717173813.11674-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966005)(2906002)(6916009)(316002)(47076004)(82740400003)(1076003)(356005)(5660300002)(82310400002)(8936002)(70586007)(81166007)(6666004)(83380400001)(54906003)(70206006)(186003)(36756003)(86362001)(4326008)(26005)(2616005)(44832011)(426003)(336012)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66f8eff5-dc65-463d-ece1-08d82a783635
X-MS-TrafficTypeDiagnostic: BN8PR12MB3345:
X-Microsoft-Antispam-PRVS: <BN8PR12MB33450FB2EB9520F7E20E9F1FFB7C0@BN8PR12MB3345.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNwkL2URx34OdDPBSu7kZtGhBcUBTcm1lYDrVYHNKEzvATkUz1SBAlydl+zQIsD4PQ+tiQ6lVaKmXQ1MrXZRzIQZq4YFzrKA4DoIHlP4JJJS+Dup/LUN+ezmlf2EsMx/Obllgxh+hAM54W3L4eBtyzgyVj34lMhgeDX4foE6q0xilCVnGZCqEMBu72bXvqP6X9QUZe7LH6OC985vQTAcz5DHy6G4U7elgBchAuBLbKI1eouMeaU1Sb1dVi5jPK7Sa93ljNbfxEbMNjGk8x6B0S9yz7KY+MHV4GGJub4eE/FFIq9BsJgG5ZtELpdI+lOI734oWhyazZegVZOsNhnz0onGaah122oMhWy8ZhPwGFYGyI8Y+8g+7RAxBQgGDuNOFcmqFBmkPKfCQhEWJ8QCIQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 17:38:26.6441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f8eff5-dc65-463d-ece1-08d82a783635
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3345
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Accessing dcn20_add_dsc_to_stream_resource directly
causes build failure for configuration which has
CONFIG_DRM_AMD_DC_DCN disabled. Fix this by
calling the corresponding function exposed via dc
resource functions.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 20d420b26ef7..729ca38750d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -827,7 +827,7 @@ bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 		stream = dc_state->streams[i];
 
 		if (stream->timing.flags.DSC == 1)
-			dcn20_add_dsc_to_stream_resource(stream->ctx->dc, dc_state, stream);
+			dc_stream_add_dsc_to_resource(stream->ctx->dc, dc_state, stream);
 	}
 
 	return true;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
