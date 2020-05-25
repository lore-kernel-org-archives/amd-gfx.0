Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A800C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA34E2071C
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dD/ONV5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA34E2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC23D6E10B;
	Mon, 25 May 2020 18:13:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7615389C21
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 18:13:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJkgSbIGl9Yscpue1MvbgcJEL1xnYV7XuTgvvBOFSHIRSdwLTPyqwEk9xdExTp8nNt8rxBM3sL0pFbW5Lz+XQnzWc2HRpFv52aJCve+DoSrgiGDFbTNZ75S5jmQHliGUF/is94qBAd0JifgFEyvwLn8VAYA7V+HNFzmd6eYGcJ4wf0TU9vcEcQyVu1DgIufMbFt8Hb9K5aTQmjFcTuUIbNaWixU85z8Hbff7E29sOIAW03XNF4D+PE0XiXmMJ+jAMzDrTDRMJYe2/LVPw5QnB8MGajdB9UhQQRDAfqBEG3kwGaia61EEWM+OMEXnc7sd+IpY1Q/V/1w8dQy+ZA2XNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7P0E0cO222j6Mn4Fog58GNSVxo1PDIOyBXh5np13EEM=;
 b=aL1ySJIe3gyMBtvVXd1aK37P9mwZDxFvR3BkPnSU3UArBxa0ytdtvaJ8o5kzLXcUV0rF+3G93mEtKdSa6HMXxn73EHj/tikh+Vc0xsjNzpW5Ie8jvnDjezje6tuLYaUpjV0EPIyP3l336Y/Zy825mcm6g/8QNLdq5C5o0x0Zwmj7jyhThP0qjuAkjr0guEnMdsBX39Cv4gtALbH6lwJcsr8DyccFVabiBuI7C3JXG5ljv0YKfjs3GybInN41BPJerlIN46LOCmPe/zExNMmJ35MQr16ycJE7yQGzQZn1NS5ZyU24Jv+34BbQbO4TGlC/WTExdXqJtxSUmJ7n9Eh1IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7P0E0cO222j6Mn4Fog58GNSVxo1PDIOyBXh5np13EEM=;
 b=dD/ONV5P1FmzoQVejFy6lGHuB1Ts3xzvtWnlhhXlBsmpBudR/f/D9JVcR8UQkTNHvfix3dDa25hT23y+KW0XM1t8hDc6HZwDZFj9h2bJ2kdKBtoNEfcwIWxosmw7Gcp8vmo+jVd4v68Sp2v22KqpD8Zrvn0Vy4EigTVFgRS/+6U=
Received: from DM5PR20CA0005.namprd20.prod.outlook.com (2603:10b6:3:93::15) by
 DM6PR12MB3097.namprd12.prod.outlook.com (2603:10b6:5:11d::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23; Mon, 25 May 2020 18:13:15 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::61) by DM5PR20CA0005.outlook.office365.com
 (2603:10b6:3:93::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Mon, 25 May 2020 18:13:15 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 18:13:14 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:13 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 25 May 2020 13:13:13 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/16] drm/amd/display: unit show garbage when do OPTC blank
Date: Mon, 25 May 2020 14:13:00 -0400
Message-ID: <20200525181306.3749-11-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525181306.3749-1-qingqing.zhuo@amd.com>
References: <20200525181306.3749-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(46966005)(54906003)(316002)(5660300002)(44832011)(478600001)(6666004)(2616005)(426003)(82310400002)(36756003)(356005)(8936002)(1076003)(8676002)(186003)(336012)(70206006)(70586007)(2906002)(81166007)(26005)(82740400003)(4326008)(86362001)(6916009)(47076004);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2ca6f32-9b92-4da7-95d2-08d800d74ac4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3097:
X-Microsoft-Antispam-PRVS: <DM6PR12MB30972DA3BA2D12419E01FA0FFBB30@DM6PR12MB3097.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:201;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wam9D0haosLtnPIEpq0i3QkKgbaudpFubbqImWPR3englnxH41cCDBFgC8tUf7ARV6gHhFh+ZktPEyCCoO5JXc3EJSEF2kM+pBXX0vDj1NmWVZ9aF/2C+bOWkc9WhODF3IJf0CcKY/QgqN+d9HjBGJwgqF+lqbmtLClOP6hibRyRe7kWTma24JaRmTO0ioPbtj/fRvyK6xYYdAidPwDEqjl0GaZz7/woUuAMbhmvGGFzuJ2OvWpxuv9gHhlcjOWMOMcexSxkDHF677MiRcfZuH8bFQbIfTm0KTQDYHlEqPl303WcjoiR5o14WL+1E50nc/jOG8vV616nQscYa53SO0quZX9UZq6wccT+lyawAVwIQYL9+wo8T0NGDdVsFuXyF6QF347yypDNgA0zkI17w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 18:13:14.4311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ca6f32-9b92-4da7-95d2-08d800d74ac4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3097
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Paul Hsieh <paul.hsieh@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Paul Hsieh <paul.hsieh@amd.com>

[Why]
Unit enter to S4, garbage show on screen when do OPTC blank.

[How]
Wait for vblank then do OPTC blank

Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 0313ca83cdb9..deaafb4782d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2581,8 +2581,10 @@ void dcn10_blank_pixel_data(
 		}
 	} else if (blank) {
 		dc->hwss.set_abm_immediate_disable(pipe_ctx);
-		if (stream_res->tg->funcs->set_blank)
+		if (stream_res->tg->funcs->set_blank) {
+			stream_res->tg->funcs->wait_for_state(stream_res->tg, CRTC_STATE_VBLANK);
 			stream_res->tg->funcs->set_blank(stream_res->tg, blank);
+		}
 	}
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
