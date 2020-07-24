Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16142C433EB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6792070E
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HRntcGIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6792070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA3146EA0C;
	Fri, 24 Jul 2020 21:08:36 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690059.outbound.protection.outlook.com [40.107.69.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 404C06EA0C
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 21:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqIYqhFZ6OZYiMmzFwome9r5ZOl34AGNdnim2Ut8DB8qEpAGNnRRSqCGOVCVVPvoLGXYtvU8i1vZzH8q2y2wAZbNpB+McR0ast8f8XI1vRXlGuKrjNPyupqZPN3TJM5lJyhulPxPx7PEKzc8dFrmO6TZHDRPsSRnZxCYDc1LquQDDnNiDs1lm11lPKPn6mgrI0PyT2BQSL5Ot4hqnG4xkE6RpFZNBviYi639rwOQpHqL5iBbRSRVUGYOKSrayD7cKBUOFDIWUPbtb8aSrO8Ql+bP5AQGaq88hVNBIbkChEsA/I+2GBEa4F8LCt/xKaJMBBIZuUJsKSJ7xMs/SmvtmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdNeebindIyc8Ysy6MiTuE8hJXvqCaMN/bp/i601eEs=;
 b=kWN4PGcXpscY1ZaBK/nZEF70yunXcPar2M/zXWssdF3AkJ+OiF0Fyg+xoYl/G8XrtUazSEhDvOta0rmLxa4TtFOxpjn4MauC9ojDsy75LdZl40O3MqtFh0gr/R28d9FS03KAqIvwbX1vFl3821dsq+9zPlcuZWuiNKoCx8ijnmSqMXIHZP5inGaKv5d+ZpQECmmpnu5bBrdAPZ7XfCLeRLucm95N+95FQBtiiuAaezYN/2Fde0tcyShElA99r5DSatcOGkAqWCM8YEoJgFOAL5Selo9JK9IYSDkRdWZZJj8GM829JIZnvVGGch+8AI3g41gaEyzDOgfsOv3EIHW8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdNeebindIyc8Ysy6MiTuE8hJXvqCaMN/bp/i601eEs=;
 b=HRntcGINpZAj5qJwPquBe9z8Ho30hLHBJq265/mCmyN+9/4MtV7x2xB4uQ1DGE6v6WmV20PH+vlVWpk9lah4FDsS/x58wPysDDqWOP96CvZjtbHWM8/cjgwiQzDCNOnVKMCELbvYaHTMjybMOr49jUwoP0nb1ncdVfm99cRcTLg=
Received: from BN6PR11CA0022.namprd11.prod.outlook.com (2603:10b6:405:2::32)
 by MN2PR12MB3102.namprd12.prod.outlook.com (2603:10b6:208:c6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Fri, 24 Jul
 2020 21:08:34 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::29) by BN6PR11CA0022.outlook.office365.com
 (2603:10b6:405:2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Fri, 24 Jul 2020 21:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Fri, 24 Jul 2020 21:08:34 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:08:33 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 24 Jul 2020 16:08:28 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/15] drm/amd/display: Fix DP Compliance tests 4.3.2.1 and
 4.3.2.2
Date: Fri, 24 Jul 2020 17:06:18 -0400
Message-ID: <20200724210618.2709738-16-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724210618.2709738-1-eryk.brol@amd.com>
References: <20200724210618.2709738-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3836578e-e59f-4fc2-f578-08d83015b9d7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3102:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3102CA17C6551069A376A7F7E5770@MN2PR12MB3102.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CV4ZFo+x6+HLX65VB5dIfLEjp+O0QEROM66rgV6kipSkoK8a9z7TjjheIY0834Ao203Lit6ChR0Fkph7ivIZkxuJNZTbxaaIvUYawlsPvnVN+/45usohZxHSCQwB518IlAoS9gWsAC1h8pnstlvC1ib4T2dL8Aie0w/UH7bU5Sr94cC97db2AtVSSGXcYQFMwaJ1SvJqAcMHVvcnw819g/A4pi49ZM0c/wSzP7qQ1h4tM6W1+weINv2MP9qNjEZ0T3iN/pb6K1BUsKJHmiUbUAyxPMtKzByfhvYYFsOlzg3oYuLnAKAIXr04NrXL5w4omKLnWhyDVvHqFGEJaejPLs7iPlYx0DDYCy2VZAeFbT+2zgG4xX9HIZ3YNfYxcXGKOCcYNlIt9S5r22W30vms0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966005)(1076003)(54906003)(316002)(186003)(44832011)(26005)(36756003)(336012)(356005)(478600001)(2906002)(86362001)(8936002)(2616005)(47076004)(6916009)(70206006)(70586007)(83380400001)(82310400002)(6666004)(82740400003)(5660300002)(81166007)(426003)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 21:08:34.2879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3836578e-e59f-4fc2-f578-08d83015b9d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3102
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
Test expects that we also read HPD_IRQ_VECTOR when checking for
symbol loss as well lane status.

[How]
Read bytes 0x200-0x205 instead of just 0x202-0x205

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 0447492d30ca..2bfa4e35c2cf 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1138,23 +1138,22 @@ static enum link_training_result check_link_loss_status(
 	const struct link_training_settings *link_training_setting)
 {
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
-	unsigned int lane01_status_address = DP_LANE0_1_STATUS;
 	union lane_status lane_status;
-	uint8_t dpcd_buf[4] = {0};
+	uint8_t dpcd_buf[6] = {0};
 	uint32_t lane;
 
 	core_link_read_dpcd(
-		link,
-		lane01_status_address,
-		(uint8_t *)(dpcd_buf),
-		sizeof(dpcd_buf));
+			link,
+			DP_SINK_COUNT,
+			(uint8_t *)(dpcd_buf),
+			sizeof(dpcd_buf));
 
 	/*parse lane status*/
 	for (lane = 0; lane < link->cur_link_settings.lane_count; lane++) {
 		/*
 		 * check lanes status
 		 */
-		lane_status.raw = get_nibble_at_index(&dpcd_buf[0], lane);
+		lane_status.raw = get_nibble_at_index(&dpcd_buf[2], lane);
 
 		if (!lane_status.bits.CHANNEL_EQ_DONE_0 ||
 			!lane_status.bits.CR_DONE_0 ||
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
