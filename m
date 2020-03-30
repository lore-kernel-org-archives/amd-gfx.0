Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A63C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 18:01:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2EF820578
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 18:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3bteOHz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EF820578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82E456E483;
	Mon, 30 Mar 2020 18:01:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 609786E488
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 18:01:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGELnoknfB/W6rtT+hEJLp7mbiiq1nBzvWK0A/4y321YLJo2zgwFx5nzGl4X82UEeiG3rWvZ7utwRtOMNeyoWNv6JfcHQ9enKSXRGO5f/bAMYji6pS43/k/m18XzVB7sdB6bqSXYtYGiEDCC4+PgEBgVWouAoMbMdhj4HbzzS+mYgTXfyGg9eeTjWSSGw1lSnf+cHiHnXXMIi2ZN2tVQnDn58a+pF9MNctXCjC2yChGbPbz2TSUYD1sFULOKjmVwXYXlMuiI58dFdKhrwdBlgSa+u3fXGg2FztWIdkKd1j+3NUhHgbXopRKp56ZnGgYN/3lR9ACqNG/3TnX5uHnjGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AprWF5r+pUKz1VKM8LySbe6GF1XlLP1vvPpA5NhQR0=;
 b=fBzjMexyFcsJAcF1pohjrVkbeFzEISakZcIm6wrBxHNRWMUuN6f3Swqg5elCnouP9MtNo0akU17h7Ksk4j7wxP4UTa7+r4lGaLVSuJCTRnZCmKDXfk8WQgmNYT33ES78DA72MM/7fDJvX0aYm3z4K2OTsHwNk0yOvD305HE0pZ0A2zyWedHe/FZM6cBrHjabXJV4bur6/2VaSByfYNYXpnukQUDBz+ww2qZ3tHiCggAKQP865r0J1HlW/rP+FF5xqOVydJ/IRWQe7VPY5tkFfgc4G1+iZTEMA249EnKzP5cCrxx4FZ/Pf1QKfPjhsG+TgtqpCW7zPRrHkVtsBalONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AprWF5r+pUKz1VKM8LySbe6GF1XlLP1vvPpA5NhQR0=;
 b=3bteOHz4Iy4buzop4mq4rME77yxfSCF6hWjqPa/ptji81+OmevZg+9jI92ApPtWLjg+37MEAA1o+Wdu7qwC5BYyl78vNpGkL0NbIMGlXlHLDDB7umrd1BzTz5TjMoWlOjhFenApjGuiEGveuGPPUuXuY4SblKy1eyoBx17DnbEc=
Received: from BN3PR03CA0066.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::26) by MWHPR12MB1952.namprd12.prod.outlook.com
 (2603:10b6:300:114::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 18:01:02 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:7a4d:cafe::e) by BN3PR03CA0066.outlook.office365.com
 (2a01:111:e400:7a4d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Mon, 30 Mar 2020 18:01:02 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2856.19 via Frontend Transport; Mon, 30 Mar 2020 18:01:02 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 30 Mar
 2020 13:01:01 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 30 Mar 2020 13:01:01 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/display: increase HDCP authentication delay
Date: Mon, 30 Mar 2020 14:00:25 -0400
Message-ID: <20200330180025.21433-3-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200330180025.21433-1-Bhawanpreet.Lakha@amd.com>
References: <20200330180025.21433-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(428003)(46966005)(8676002)(336012)(426003)(316002)(54906003)(110136005)(186003)(7696005)(26005)(2616005)(4326008)(1076003)(478600001)(356004)(6666004)(81166006)(82740400003)(70586007)(2906002)(47076004)(8936002)(70206006)(81156014)(5660300002)(86362001)(36756003)(2101003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee172a10-7a5d-45b5-79fd-08d7d4d44f26
X-MS-TrafficTypeDiagnostic: MWHPR12MB1952:
X-Microsoft-Antispam-PRVS: <MWHPR12MB19524517A66FFF9061C78E0CF9CB0@MWHPR12MB1952.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0358535363
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJMQgvmXkCw+996nVzF6APO9KXhWD96M2H3r9RsZ+FmtPsjZvnj6AfWJTLTN5uyLBxI8R2nTVnGFHIex22hysr90eA2M6t3mASW16iR2DMCgwFTgCoc/aWYT1yIK/2oUm6YKF81612OmLNurOFDEYWOf2x3eZTr/vj1vz7iRLmLEt/O6XNDAQnXAL4zEBdfTJ4aDhJcysbkETdgEdzxjm+x5yvHG35UZMKx8VNNH5IYuKtkJ+x82/fh5b7K4UeDNrrvIurcaiPX82+EeqRhyA875YRDtS0+0785LBtGSlxbTfKsJx+5RxJ2EehD3PjVPkM2IUmTtbYLdhiAuQyNjxVAeAdxW+fJUn67kuXLQmkc4dbGMC/rCtXB0IYylSsF9G9dQIwUyjMO/Smof4wcb1N5Rjy52/12Vi2DMWdFkru/QjRU2w21IsP5Ev6oe/SuWBeCqxGSqBSkGSjm/ZqSb040meazgMBczFIwOk9u1aUIwB78y9SKAIGvfu753mW9OT6Fh/fWXOtHJG1PLC4/Cc5oHK4tbPXVnFh9ZwtYv3yI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 18:01:02.1861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee172a10-7a5d-45b5-79fd-08d7d4d44f26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1952
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Some displays have an issue where the hdcp chips are initialized after the
display has already lit up. This means we can sometimes authentication too early
and cause authentication failures.

This happens when HDCP is enabled and the display is power cycled. Normally we
will authenticate 2 seconds after the display is lit, but some displays need a
bit more time.

[How]
Increase delay to 3 second before we start authentication.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 39804d2df9df..78e1c11d4ae5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -419,7 +419,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	link->dp.rev = aconnector->dc_link->dpcd_caps.dpcd_rev.raw;
 	link->dp.mst_supported = config->mst_supported;
 	display->adjust.disable = 1;
-	link->adjust.auth_delay = 2;
+	link->adjust.auth_delay = 3;
 	link->adjust.hdcp1.disable = 0;
 
 	hdcp_update_display(hdcp_work, link_index, aconnector, DRM_MODE_HDCP_CONTENT_TYPE0, false);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
