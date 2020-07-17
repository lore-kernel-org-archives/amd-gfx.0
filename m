Return-Path: <SRS0=DbcS=A4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B954C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A9120737
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="D1g0443T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A9120737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65AB26EE23;
	Fri, 17 Jul 2020 17:38:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 808DA6EE1A
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2020 17:38:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch3Ik0VFMPWsfEmbDySvvrWTtwjARF/AEcEb1Rss2NB7QiYeZVohPdJYCSpzG1tGVNmkyKfTCxrRJSB/DNm2KCtSYUBCq3pcZv5MJHLM+w/VxgH6WfRr9xhZsbskGzr0k3yWfwdXmA8LtjwvX0qJXKENwbhWNiFKjVHNByhND8iAw1UcAQYQkZIw729xuWhmuhcMA+bnLTqfhQgB3fpFtN3Yb4LtOOHKn7yvSaWxPygobgE9C1Eo2b8KzFuDEcP6y1xRqvgo3L6L5py+FO8oU2krK9lEe0qWlldnj6WP7J5uL83d0B4V1K/TL04SBgULo/qN/vPOV39J4NoMkmD7Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ruFXpTcgFu/Fag11EQBR+aSoAt3povzv++wkehMFFs=;
 b=iHfs8HM1rOg5eWNAg2iaX0gSTFF4xDdJZIVbDw2SBDKulp3etR/BeOWNkcm/wWSSfr7qlJwrGrocgoGNkqeJb8hH8tBPuMmv4YZJPtie2ck3puFE7gd3XJ2Jt+po25Qcw1iod8hK4P93QcDm1t/Z30amCnNkOcRer9im1VVtoPEnpUJQ/jEk/5mLMNoZcaiGzumUMpVcEiyNVTt6LKpp2LOJjzzMqDkPZirInpSYvXwECbGbPYAQ3xJT3SnCIvc1EEQ1+FVFq/4H//cHfnjRUzzBPHJ/q/ykJ5zaVeVeI6t+/Nb6O/rHVgAMScgkxYs5MMWgf18LSQysrOJAALmZvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ruFXpTcgFu/Fag11EQBR+aSoAt3povzv++wkehMFFs=;
 b=D1g0443Tb38Dq+ibTNSCEhK/+kM9I1MvsNNWBXvnsS8YcyB2/m1d1JKeCwmD4wKjNQtIaTexeJG9q6g6G6KZlqKV3cbSu6OmslZKC2wKhXw667AvpK1Uu80jsLQouwCXqyQREmaiLvGUwSNnbuwq8VZ63ARU9ek44EqFp7eTPLk=
Received: from DM5PR18CA0090.namprd18.prod.outlook.com (2603:10b6:3:3::28) by
 BN8PR12MB3170.namprd12.prod.outlook.com (2603:10b6:408:98::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.23; Fri, 17 Jul 2020 17:38:25 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::ab) by DM5PR18CA0090.outlook.office365.com
 (2603:10b6:3:3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.19 via Frontend
 Transport; Fri, 17 Jul 2020 17:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 17:38:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:24 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:24 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 17 Jul 2020 12:38:24 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/12] drm/amd/display: Improve compatibility by re-ordering
 info-packets
Date: Fri, 17 Jul 2020 13:38:09 -0400
Message-ID: <20200717173813.11674-9-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717173813.11674-1-qingqing.zhuo@amd.com>
References: <20200717173813.11674-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(46966005)(70206006)(82740400003)(336012)(4326008)(2616005)(36756003)(26005)(356005)(1076003)(82310400002)(47076004)(2906002)(81166007)(86362001)(8936002)(316002)(6916009)(6666004)(426003)(8676002)(5660300002)(70586007)(478600001)(54906003)(186003)(44832011)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e814d71f-bba3-42b4-0b7a-08d82a78356f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3170:
X-Microsoft-Antispam-PRVS: <BN8PR12MB31703F4EE18AA15989F0E8DAFB7C0@BN8PR12MB3170.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Yte337azd93DPWpswBUdwydiYDAWaU5VP9KwznQ+mql11Z8EVglHeFZw0Xaw0Sf6PSe7CH2KJ8NScsAYq4spO9yIWk2QurUfW1PiBsVOUWojsrk9ZZnrJXRrpRRqv/tzU7aqJ/sXMw93wJBY6gdV7uaVfZZmZf4lG1RNzh1hCyeMWI2MIxOG4KdAw+iwraBF5U/YOXxHX4gb5KfeAwwcBWzTNgBGmbYjpsQ19UKU+c1Obvug0OsTgA+arHpwwBGCarB1/IZgkKA8iqFlJQk6uzme9T2POv15aw4zr0PP2nMI9YC/LBy3iFn3+DhWjdULZ9yRqwzqDJGTFhN/sHcz0SBazQdftpwAI1jWd6EFOFlO+T0S2EtovupxGwIciCOvWZdFWsyoZvecieUJJMUmQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 17:38:25.2997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e814d71f-bba3-42b4-0b7a-08d82a78356f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3170
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
Cc: Naveed Ashfaq <Naveed.Ashfaq@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Naveed Ashfaq <Naveed.Ashfaq@amd.com>

[why]
On DCN20, Some features would not be activated when ALLM was turned on.
TV seemed to activate only the latest info packet sent, and the ALLM
info packet was sent after the VSIF info packet.

The packet indices was also inconsistent between DCN10 and DCN20.

[how]
Change the packet indices of DCN20 to match those of DCN10.
This makes them consistent and also makes the vendor info packet
be sent after the hfvsif info packet.

Signed-off-by: Naveed Ashfaq <Naveed.Ashfaq@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c   | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
index 99a7ef6ab878..e3984f02b7b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
@@ -152,11 +152,11 @@ static void enc2_stream_encoder_update_hdmi_info_packets(
 
 	/*Always add mandatory packets first followed by optional ones*/
 	enc2_update_hdmi_info_packet(enc1, 0, &info_frame->avi);
-	enc2_update_hdmi_info_packet(enc1, 5, &info_frame->hfvsif);
+	enc2_update_hdmi_info_packet(enc1, 1, &info_frame->hfvsif);
 	enc2_update_hdmi_info_packet(enc1, 2, &info_frame->gamut);
-	enc2_update_hdmi_info_packet(enc1, 1, &info_frame->vendor);
-	enc2_update_hdmi_info_packet(enc1, 3, &info_frame->spd);
-	enc2_update_hdmi_info_packet(enc1, 4, &info_frame->hdrsmd);
+	enc2_update_hdmi_info_packet(enc1, 3, &info_frame->vendor);
+	enc2_update_hdmi_info_packet(enc1, 4, &info_frame->spd);
+	enc2_update_hdmi_info_packet(enc1, 5, &info_frame->hdrsmd);
 }
 
 static void enc2_stream_encoder_stop_hdmi_info_packets(
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
