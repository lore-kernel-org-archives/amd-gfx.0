Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB1BC2D0C9
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 17:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401E721655
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 17:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qBMWeOb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401E721655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D963E6E13F;
	Thu, 12 Dec 2019 17:06:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C406E121
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 17:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIFhYwAgutW1KwrlS5OlLHCYJ0ZucjpQf3y2MDrVs1jTQL8pxEoErb5D+QknFoQplCBtKjnNf0Y98jTPB0ZZ4sOGfw5zSIvsUDEOSyyVxlm5TpjVTWIyTGTu0NU9HYLq8pU0qnVu4kbEv2I7EeQCjEcRmnCyhFmkh0+LZms90bVyFnB3oKVAFd839AfjVMnn7QdULv0Fs7XwKboAUboOQNxgHPBCAMqmQxBLLcQ4FRYi/pgtdFYKFIw2YDm7SgYGXr8IbZlf6Va03uVIQdPJuwiaI/oeHxfaOIhV6rHOt8KRm7BGwCqK/eO4vCx6PHFga96hpP2Uws0bpgHVJbWn2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMqTiLIolq9eUehMauK4ztpSECPQDdg3cA1g3rMo7lM=;
 b=VAYSh9hpu6kWbNEqMh6FqaHHcSmdLdNcsz11jU2D2djDesrCBKB4+T6zOhYoP76rgaoL7j4yjtSmVYj1EKHMssIcDlIVhjKzFU3OsBfGuOgZvCEmRNnqMWgVSf3gAWke/H0vyBzjAj7XvpbrsxduhLtSIjorsJ6gNqP4Sz+8scmojkKSW6fI8aqnQVx0utDAM9hRlU7Lz1wxVJ9hQvo0GwNCDpQ0ud1O3tGmxSPv5Ie42A1ij6h1Qpyj9/XpVgeas1yaUfbAkH9yi5JLNdYhwK5/xLbFSS8Yn0Dv48tiq+wjl29VSLgAvtHOubpe3Vt0KxJraQ0D3QtoW40g4dOdOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMqTiLIolq9eUehMauK4ztpSECPQDdg3cA1g3rMo7lM=;
 b=qBMWeOb+BOJqAXnSQNh4n1MdyByy1TS9mgpqYVG8FDkMQMMqoRVpKK7juO2CIpyEnNApLOoDTLeqeY8tfgQdHADfh8RjGl6al95baPvm0UttLRbbna9JlyDqxh6CbqdmrV8/nyp1EiUDlMnL8TC3UPE5CH7kxyVOmlXffMoPV+E=
Received: from BN4PR12CA0013.namprd12.prod.outlook.com (2603:10b6:403:2::23)
 by CH2PR12MB3733.namprd12.prod.outlook.com (2603:10b6:610:15::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15; Thu, 12 Dec
 2019 17:06:26 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::208) by BN4PR12CA0013.outlook.office365.com
 (2603:10b6:403:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.17 via Frontend
 Transport; Thu, 12 Dec 2019 17:06:26 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Thu, 12 Dec 2019 17:06:26 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 12 Dec
 2019 11:06:23 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 12 Dec 2019 11:06:22 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] drm/amd/display: rx_validation failed resume from sleep
Date: Thu, 12 Dec 2019 12:06:12 -0500
Message-ID: <20191212170614.24837-5-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212170614.24837-1-Bhawanpreet.Lakha@amd.com>
References: <20191212170614.24837-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(428003)(189003)(199004)(6916009)(8936002)(426003)(5660300002)(356004)(86362001)(2616005)(70206006)(7696005)(2906002)(6666004)(316002)(8676002)(36756003)(478600001)(70586007)(81166006)(81156014)(336012)(4326008)(1076003)(26005)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3733; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18f297a9-ce8f-476f-b73b-08d77f259f7e
X-MS-TrafficTypeDiagnostic: CH2PR12MB3733:
X-Microsoft-Antispam-PRVS: <CH2PR12MB373357F66B2ADC12A3E67B9CF9550@CH2PR12MB3733.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0249EFCB0B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bW2Taf0cB5jS3BA59uhE/cX3cAYtrfm6IR5ZsTfkxeskWGSqviMkVSyCtPTZOz8rbqZ+cqZYP40i19/Bj7h+Fl3YoLx+QVRys7ztZYvoLncKaR0QP0GPL1Xzzqhs1umParfKZaMhFIEDxa8LGDoTFZqlz2HJX4g0AfySk2TLRXx6zwx7P1i32WrAAyty/Bd/3t+v5UjFxNgPC+K128IuhZSv5jCzQLKPGxT+ywffmqE50Nmh5es1JTgzu0bmRXvPQTSQ932RCVU8xwZ5fuUqIA38a286lnauMl6XvJ7lLs7l+h0yw+txYvtcXhO/5UcOpaAMCXZVUBunZI2APGwmCQ/j9aonlGBOEapRCiI53iJD111OpmAfdOJbZfu/E0EkEaGTb/QC0T8Or6S3tWZd/0LhsOpVIYgt8xvmxACoa3x0RuhgFBS9nRFJlMP/PLyF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 17:06:26.1002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f297a9-ce8f-476f-b73b-08d77f259f7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3733
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
Cc: Jing Zhou <Jing.Zhou@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jing Zhou <Jing.Zhou@amd.com>

[why]
Most DP/HDMI monitors need more time to response rx_validation
request.

[how]
Add generic 1000ms delay.

Signed-off-by: Jing Zhou <Jing.Zhou@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
---
 .../display/modules/hdcp/hdcp1_transition.c   | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
index 136b8011ff3f..21ebc62bb9d9 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
@@ -67,11 +67,19 @@ enum mod_hdcp_status mod_hdcp_hdcp1_transition(struct mod_hdcp *hdcp,
 		break;
 	case H1_A2_COMPUTATIONS_A3_VALIDATE_RX_A6_TEST_FOR_REPEATER:
 		if (input->bcaps_read != PASS ||
-				input->r0p_read != PASS ||
-				input->rx_validation != PASS ||
-				(!conn->is_repeater && input->encryption != PASS)) {
+				input->r0p_read != PASS) {
+			fail_and_restart_in_ms(0, &status, output);
+			break;
+		} else if (input->rx_validation != PASS) {
 			/* 1A-06: consider invalid r0' a failure */
 			/* 1A-08: consider bksv listed in SRM a failure */
+			/*
+			 * some slow RX will fail rx validation when it is
+			 * not ready. give it more time to react before retry.
+			 */
+			fail_and_restart_in_ms(1000, &status, output);
+			break;
+		} else if (!conn->is_repeater && input->encryption != PASS) {
 			fail_and_restart_in_ms(0, &status, output);
 			break;
 		}
@@ -212,7 +220,11 @@ enum mod_hdcp_status mod_hdcp_hdcp1_dp_transition(struct mod_hdcp *hdcp,
 				 * after 3 attempts.
 				 * 1A-08: consider bksv listed in SRM a failure
 				 */
-				fail_and_restart_in_ms(0, &status, output);
+				/*
+				 * some slow RX will fail rx validation when it is
+				 * not ready. give it more time to react before retry.
+				 */
+				fail_and_restart_in_ms(1000, &status, output);
 			}
 			break;
 		} else if ((!conn->is_repeater && input->encryption != PASS) ||
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
