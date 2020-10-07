Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F71C47095
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3567220789
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rQ/YPAal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3567220789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9D3C6E8E3;
	Wed,  7 Oct 2020 12:42:43 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA5326E8E1
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 12:42:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfKoVQI5poICvdVTCTj11IOGWVdaUa0TmPXdO8mun0hJlWdj5KJYOBNQpzgqlYe0QP6jvBM46RuiLPuy36Ht3VZJ+v3ym0eRQFTW3upXiymsqByLZqFAuIyp7+Csf6o8fQ83sy+d1npT3osuCnCjak6s5sdNIsgWF5V8+HP++4W5/LEVkxXqkDVpCO0uC4RYbuMQu1XEHhj88q+zySKa6LedAAiUoBB78PEkTGzSXAoHVHPUBbhy8DUzvGSnTxET5wWdtLDCOIxA1jj/3vkzegSvwuFjC8XIGGDguaivXay07dtl+CUTuIUj5Gym6xaqeCUL5iPD4vQxM3G9az/4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNSAMUb+6LYPCboSy61/x56wJrHO7Yd7PVrkp5td1yI=;
 b=FQ5QEUR5qIJI3Odn7CPvbGUzhBQcqYM0yRaadEyUVCIASRlYY31fTS+GQkmFoOeRwbDjfaL2vo+9+dq/Ct7FE7iQLUSYl59+a5TKXst5UKNJ+YRt2c8MQNGccTfxBB+c4AjvMNCvOoWODeqYhQJk0OG7Ct14zhZewDywaQ0Fyf8FrdwkSPNcds7+mj3trF0cBarXkmBstmlnn+hWEp8DhnePjey48/vsCm8jL3v9fg4symxDNevLNKV0XL8BQy5CKS5LBC6edFNLDCzNT0+dPAAoteB4a/0MMONcpTk1ovBjWRerCT7gcdX+vxWTUm7n4ekA1T1GMpV+STlWDno6/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNSAMUb+6LYPCboSy61/x56wJrHO7Yd7PVrkp5td1yI=;
 b=rQ/YPAalpBOCcbfdfMnv56RPvEGG/nrvMUrF4Lhnqx6d5mX1b6TyGIgGmv2vQx4uD/yPsSRwhFvlLXi94KvRAWMoAHJxmyeBeSfA1RjXPWwUo084zHgLEY4yOM+UGCIjXpfe/2rz5zUvyStDBCmcnwMMVMieYrUC7vC1AsQN2cU=
Received: from MW2PR16CA0061.namprd16.prod.outlook.com (2603:10b6:907:1::38)
 by MWHPR12MB1631.namprd12.prod.outlook.com (2603:10b6:301:f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Wed, 7 Oct
 2020 12:42:38 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::a8) by MW2PR16CA0061.outlook.office365.com
 (2603:10b6:907:1::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Wed, 7 Oct 2020 12:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3455.23 via Frontend Transport; Wed, 7 Oct 2020 12:42:37 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 7 Oct 2020
 07:42:37 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 7 Oct 2020 07:42:36 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/12] drm/amd/display: Define PSR ERROR Status bit VSC_SDP
Date: Wed, 7 Oct 2020 08:42:21 -0400
Message-ID: <20201007124224.18789-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201007124224.18789-1-aurabindo.pillai@amd.com>
References: <20201007124224.18789-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e1857fa-4576-44a3-106d-08d86abe790c
X-MS-TrafficTypeDiagnostic: MWHPR12MB1631:
X-Microsoft-Antispam-PRVS: <MWHPR12MB16311D33BEC06347900184138B0A0@MWHPR12MB1631.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KXAUAy7T6uGFaWc87WPpE8KCKOHlR5srW87oG+rfiprXwnNHhnuUBdBLDTvjgBX0vjdJ+NJoPDFrjFsuHYy6J16Dv66J5jHCKI7rHh0+cmo1zipK/PYoycW8Xbv/6yRx9Db5pc1K4MRaSsx0uhVUQscgiKmyQ7J5jrNGRWTjqFq0IZHPHI+AeuFFxSowselmDKz0JLkzlZIle4CXKSmsXoN7Qkk0tUC2AtfdRg5YSYZLH+wbXTCCjHbzCK6/BxC6AwrSBGBkB20Fh8bQpp/p9VfJyV+rCcvhdGd2DiUkm7JdyRBtjJJZ9v9+iOIgFMc7m6dedhA4Cg2lhOuP5+m2WurSJl2izYe4yEANnrpFPR5Hf5eZ/YlE8xXayPbfGGr+XfNN/LcHEoU4fKEiIJT9MA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966005)(8676002)(316002)(54906003)(186003)(83380400001)(7696005)(82740400003)(70586007)(8936002)(6916009)(36756003)(70206006)(336012)(86362001)(47076004)(5660300002)(478600001)(2906002)(81166007)(26005)(4326008)(4744005)(426003)(44832011)(2616005)(1076003)(82310400003)(6666004)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 12:42:37.8540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1857fa-4576-44a3-106d-08d86abe790c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1631
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
Cc: Reza Amini <Reza.Amini@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Reza Amini <Reza.Amini@amd.com>

[why]
So we can track VSC SDP errors from display

[how]
Define the bit, and use it in driver logic

Signed-off-by: Reza Amini <Reza.Amini@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index c2b392a533b1..7f5acd8fb918 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -90,7 +90,8 @@ union psr_error_status {
 	struct {
 		unsigned char LINK_CRC_ERROR        :1;
 		unsigned char RFB_STORAGE_ERROR     :1;
-		unsigned char RESERVED              :6;
+		unsigned char VSC_SDP_ERROR         :1;
+		unsigned char RESERVED              :5;
 	} bits;
 	unsigned char raw;
 };
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
