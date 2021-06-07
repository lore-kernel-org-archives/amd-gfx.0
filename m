Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BFFC47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DFB360FE5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFB360FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2122F6E92C;
	Mon,  7 Jun 2021 16:48:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD5FE6E92D
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:47:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4z+qIbGoiZsBR3W4tzOXC6UjtIypnawVCYbwkG6h/0/GguxygONlosUwhnqbU6XQvQVCdBy4SwiVzGvaCpEN/nzmYCdvdvSpXgAY10KVRav2Jt710H+GEoZe0diFfzFu9HY4stkxh4zvzHb5aU5R0+HL8UKEe/Arp/YRXu9wDTk1NT3r1CWO5VxUWzI0OSt0T2nuC8ikDi6N/zyOWR33Xo7U9kohk1SkWX5n3J2/x9tSoLkS65TkNeTV6eQ8/ya8UbR+lF8FGLgO4ha6kz/GXFOKR4yxRdJ+IT5C3w2TT+/DR+0qGQmSOPyTYCGMcn8tkfkeb7CGqNl8gVXjcX9Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mluV37CY5nYDOYauKXVra5iZXcZmvg4+QqQ3Yyycpas=;
 b=fWw9c1QCNrLDLFHDjOSOodbL24CJEYFkU88H/UKPISPVze9CwIEcefp+7lYSB2VNDeXBXzSN89wiaj5Jr1jwWwbi3Iv3OZBYUfUWIYXl8Gs/DdDMqB10NOIQ0HEnMxZ/3itZw0Dco+1Hl/coRHs8xvcEBUtUV2uPyQKswjHMoJQ8i/aDVTZgbvPijlYIQsmsid4hpTqQQAYPpOis5gLFi9AkORxIbCiexc4zA3iRsLML+RAxVIOuvISxnRul8wkNo0LQSe+zbG8ah5EO564VPdDqAuAYgf7Y1sCqMBnOJs5vKN1V6JDiuSCuzXntsD7l2Zfokt8IqR0BHVgvcPdjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mluV37CY5nYDOYauKXVra5iZXcZmvg4+QqQ3Yyycpas=;
 b=Zg1/gWfFhz7c2JG0bzczLcTqtiFDlqSMBEQqekP0nn6BE8Z0OIWyX8u1u92LhM37cOXxPQ6p92C4joxBx3nnHTNha67771XUYx2Kw8CmiIUv6INlXgCJHlPW3i2AYO4LS1clmUbKUu+cdZgHlr31jZQi0DLTIrLG09zj8B4WPF0=
Received: from BN6PR2001CA0044.namprd20.prod.outlook.com
 (2603:10b6:405:16::30) by MN2PR12MB3726.namprd12.prod.outlook.com
 (2603:10b6:208:168::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 16:47:57 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::b0) by BN6PR2001CA0044.outlook.office365.com
 (2603:10b6:405:16::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Mon, 7 Jun 2021 16:47:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:47:56 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:47:53 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/30] drm/amd/display: delay 100ms before restart after
 failing to read CP_IRQ
Date: Tue, 8 Jun 2021 00:46:47 +0800
Message-ID: <20210607164714.311325-4-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a761e0dc-c159-4991-6d56-08d929d4007d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3726:
X-Microsoft-Antispam-PRVS: <MN2PR12MB372616A5F125258AA93D7C2CFF389@MN2PR12MB3726.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pa/X1YGUWhpq8pstcmuz4act3zoE2YjhQLzxTjtuJXR5ZiV4LiodY+NuI4K4rH4uGSmxUOspYIulraT9TisLBkIE6ca8ujb1WfgMPkiFePF/nu1GSgT4FOx3pHOCR6GKjKkdzM0wXWz2Sd1hMXZjC8eMV34vHX6h6P3KWmDkL4n96S88Vqr2oIsIiUPWY0k+syK+qmpaoNpMlxoWIa/fXdhUf9AdNOtOD1rhpt9QJeZg0ln6lHfMbXS91eB90iuRd7nQKfs9hZe8WlSEEAuuP1ffJjUqZDMNr/mCJD3cmKb0uXX1wIpJnm7YaDH8GWRioQkBjAzE88I7nwjTfDuzf7PjuGJa4Wl1b9smtSAOsmRLezf5393niy6dYs9NIoCpkJdybqiD4vodF2GzrmVLh5ltByhCKrwrgWnIfEuTNfEP6s1PYDtiY63/0hxtifOhDm4DNjCQpbNE+Fd66tScI6W9M+l8oRROwzwde0h5zDmxMn/47zVuMNUAX3X0b4QquJ2lA8lUO3v38tL+YiAc64OiEyrSuHZ52fGkPKEGA0gTKZNJLHXrerOGr6JYSzcB8yBqHMk9iTMkKr8GLPl6DDA5wBw2I46tsbwgtrdRe5CyTa4VYqQVmWFy8wqVMQtBIfyY+SvxtjnWMvh2cfwDw3bHqqvWKwhYIymrON7MAMxmS+DHdHQFmTNgj+F1wXYh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966006)(36840700001)(83380400001)(356005)(26005)(70586007)(6666004)(8936002)(54906003)(1076003)(478600001)(8676002)(70206006)(82310400003)(86362001)(4326008)(36756003)(82740400003)(16526019)(81166007)(426003)(36860700001)(336012)(44832011)(5660300002)(6916009)(316002)(47076005)(2616005)(186003)(2906002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:47:56.7221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a761e0dc-c159-4991-6d56-08d929d4007d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3726
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Some DPRX will issue CP_IRQ when user disconnects a display
that has been authenticated.
Since display is being disconnecting dpcd read will fail.
This will cause us to attempt HDCP retry on disconnection.
We are adding a 100ms delay before retry.
So we will only start retry if within 100ms there is no disconnection call
to HDCP module.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
index b0306ed6d6b4..70cb230d8f56 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
@@ -564,7 +564,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_dp_transition(struct mod_hdcp *hdcp,
 	case D2_A5_AUTHENTICATED:
 		if (input->rxstatus_read == FAIL ||
 				input->reauth_request_check == FAIL) {
-			fail_and_restart_in_ms(0, &status, output);
+			fail_and_restart_in_ms(100, &status, output);
 			break;
 		} else if (input->link_integrity_check_dp == FAIL) {
 			if (hdcp->connection.hdcp2_retry_count >= 1)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
