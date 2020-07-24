Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E508C433EC
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF98D206F0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T+mTqlIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF98D206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2B126EA0B;
	Fri, 24 Jul 2020 21:07:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7470E6EA0B
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 21:07:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E49T5TT9y3aqLQ3WJDhKVp97eiTY6MdPQWXHGPhAMqNuudQPMZm6sOzv6cMin4VJbpwr1gmt3lcSnpptYJWNtEszLBz1SMviP5r6HZIlR2uzvZtrj4WofU9MkyaGNEKADCpmOKGEXsF7qp3xsSgAFMCDuTUQbcVy0moL8GHPFKSH/BvUekJabnR80Fse8p9faVlgDviFdtMPfw7kNrA1fV7Uuvp48OkHMB43Uj0Zi23UCpx8BC8uGk5WBsY8dvAXUhJvt5n4pX82OY9FOC/1x29c1C6Ipn4mEeFybPdj21fehZmo3bRclLwW8Wmo0CAoArieCgfEDXYWF/RCoK2lHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbaXO67HevRQK4dCOHUSDJLkyjglMwwBEF4Fi+Ot9sc=;
 b=LvfavvzsNgxjQxD0uP0dFVmHDVVTkCVPDqSSbdbL+urzLbCYkR0H8b1mprto68fX8rXzqbSz/5AlphbPlgKVKuwGszstR/vxwiI1eE1oA8Iu1hhec2sjP4RwSlHfWDDFIcoINblwYiYkmCjOxpAgrllMgr9QP+tLusgw29rXprumdSL+J4sjIoQvbkrhKpS19bjjMS0NsfVGY2vx6uWql7ThugWCmp0X/D3SL2BODFNG7xfnoP79QI2QMoP+Wa59U3YJCGBTkXHXrYMyVuqeD520szUC5tpaGZ4p7bZINHEaOFQjgwB3pQonpxp5OfEHvjc3wdCVc/Bt5Y7C4hhVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbaXO67HevRQK4dCOHUSDJLkyjglMwwBEF4Fi+Ot9sc=;
 b=T+mTqlIo9EEIvZFGZ43AgxPm8kNkMnsFWRSZRW9CDTzgOGqXT6OrYErwUizKZa3fmoNg6ql3EWdom5hPCQpjOIBdXPpSLSI5XP97sDn1gwqn89Pn50a9LvgLR9wsmv8Gv8XOpqEFHP8UVg4UDHIsYl/sb20RojE3JW1eej/BHRY=
Received: from CO1PR15CA0060.namprd15.prod.outlook.com (2603:10b6:101:1f::28)
 by BYAPR12MB3543.namprd12.prod.outlook.com (2603:10b6:a03:130::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 24 Jul
 2020 21:07:17 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:1f:cafe::89) by CO1PR15CA0060.outlook.office365.com
 (2603:10b6:101:1f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Fri, 24 Jul 2020 21:07:17 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Fri, 24 Jul 2020 21:07:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:07:15 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:07:15 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 24 Jul 2020 16:07:09 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/15] drm/amd/display: Check lane status again after link
 training done
Date: Fri, 24 Jul 2020 17:06:08 -0400
Message-ID: <20200724210618.2709738-6-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724210618.2709738-1-eryk.brol@amd.com>
References: <20200724210618.2709738-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27cdef13-2b14-472b-41d0-08d830158bc5
X-MS-TrafficTypeDiagnostic: BYAPR12MB3543:
X-Microsoft-Antispam-PRVS: <BYAPR12MB35439CAEB0B250D3C0C66A58E5770@BYAPR12MB3543.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 75BCfLyT9IFsd8oDO6VzMrdq1mhsUIf5qihxT7mBzYOHLD09sG9Ty0REc0Yz81vn7Hmw7uDsNhW4WYeat01iSK+3vxOUdkmMuK0iB6xwMGULav0lU318j0I9/Q7iXqwzGkbqbam8sGWZbVJPNuWtEq67u1QdECdHskwVUEmSZ5S3/vv6Aw5WE4cFV7ztlfUNe9n7MsF0eZH+FBPVpwB+qKGaqCIo2vvrnLO0ixLzmrxLHyEhI7Pf1pHkVTI7kgjVZu1CqoJZkZr8o5XWb3r3L3Af2yMcO89eu3DYpjomGKzGV8wWswO3ntXTKqzXqQaUNCAtBy304KOYMXcsExfU4KXCcA4oAt5XEBJ8nqR/M0FqjelO4G8ZDBCuROmIQhfChCa87GkNSMZzUzyBFgXS9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966005)(81166007)(83380400001)(44832011)(2906002)(356005)(47076004)(36756003)(26005)(186003)(336012)(2616005)(82740400003)(8936002)(86362001)(82310400002)(426003)(6916009)(5660300002)(1076003)(54906003)(70206006)(478600001)(8676002)(316002)(70586007)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 21:07:16.7633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cdef13-2b14-472b-41d0-08d830158bc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3543
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Martin Tsai <martin.tsai@amd.com>,
 Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Tsai <martin.tsai@amd.com>

[Why]
Some monitors could suffer symbol unlock but cannot send HPD IRQ to
notic source device to handle link loss. This makes monitor stuck in
abnormal status and causes black screen.

[How]
According to the suggestion from scalar vendor, to check lane status
again after link training done. That can improve the comaptibility
from current production monitors.

Signed-off-by: Martin Tsai <martin.tsai@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 50 +++++++++++++++++++
 .../amd/display/include/link_service_types.h  |  2 +
 2 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 277b29590fb9..0447492d30ca 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1133,6 +1133,45 @@ static inline enum link_training_result perform_link_training_int(
 	return status;
 }
 
+static enum link_training_result check_link_loss_status(
+	struct dc_link *link,
+	const struct link_training_settings *link_training_setting)
+{
+	enum link_training_result status = LINK_TRAINING_SUCCESS;
+	unsigned int lane01_status_address = DP_LANE0_1_STATUS;
+	union lane_status lane_status;
+	uint8_t dpcd_buf[4] = {0};
+	uint32_t lane;
+
+	core_link_read_dpcd(
+		link,
+		lane01_status_address,
+		(uint8_t *)(dpcd_buf),
+		sizeof(dpcd_buf));
+
+	/*parse lane status*/
+	for (lane = 0; lane < link->cur_link_settings.lane_count; lane++) {
+		/*
+		 * check lanes status
+		 */
+		lane_status.raw = get_nibble_at_index(&dpcd_buf[0], lane);
+
+		if (!lane_status.bits.CHANNEL_EQ_DONE_0 ||
+			!lane_status.bits.CR_DONE_0 ||
+			!lane_status.bits.SYMBOL_LOCKED_0) {
+			/* if one of the channel equalization, clock
+			 * recovery or symbol lock is dropped
+			 * consider it as (link has been
+			 * dropped) dp sink status has changed
+			 */
+			status = LINK_TRAINING_LINK_LOSS;
+			break;
+		}
+	}
+
+	return status;
+}
+
 static void initialize_training_settings(
 	 struct dc_link *link,
 	const struct dc_link_settings *link_setting,
@@ -1372,6 +1411,9 @@ static void print_status_message(
 	case LINK_TRAINING_LQA_FAIL:
 		lt_result = "LQA failed";
 		break;
+	case LINK_TRAINING_LINK_LOSS:
+		lt_result = "Link loss";
+		break;
 	default:
 		break;
 	}
@@ -1531,6 +1573,14 @@ enum link_training_result dc_link_dp_perform_link_training(
 				status);
 	}
 
+	/* delay 5ms after Main Link output idle pattern and then check
+	 * DPCD 0202h.
+	 */
+	if (link->connector_signal != SIGNAL_TYPE_EDP && status == LINK_TRAINING_SUCCESS) {
+		msleep(5);
+		status = check_link_loss_status(link, &lt_settings);
+	}
+
 	/* 6. print status message*/
 	print_status_message(link, &lt_settings, status);
 
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 4869d4562e4d..550f46e9b95f 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -66,6 +66,8 @@ enum link_training_result {
 	/* other failure during EQ step */
 	LINK_TRAINING_EQ_FAIL_EQ,
 	LINK_TRAINING_LQA_FAIL,
+	/* one of the CR,EQ or symbol lock is dropped */
+	LINK_TRAINING_LINK_LOSS,
 };
 
 struct link_training_settings {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
