Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F62FC47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4776060FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4776060FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D7426E942;
	Mon,  7 Jun 2021 16:49:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB6A06E941
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:49:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UL4dw6XyMk3b5p0YFqJiBJ60QLkSR28Q2mXgi7sv1cffoFa0gF6joVby8XOZ01jJJdtwob3b1DyM7NX+ft8TNjyG86lMN8OvTDefqf9w6r5avf77W3M83gx7mk7nCKkTmGueRbpwfg4HCiae1eOQJX6UQA2bPBJGoaxE76PYYYbwXzuIy6s7Jelfy346iY9EP71oX8XXNx4pF8VrgJ5h8Z92MBQdH+KNPf/NyWDyjhqhJ5ujU7dWFCOxpi79pdAixYs21KzcGD7RVUs3tnxTj44YzgxiRHjC/y7coYoleBTEjuzVLOcoo25tmZjCIeK83tX7viwIpXTYE+ypeQvupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fn107YR9dfuYfxxYF5wLE3q6mJvuBWlXVhbSv0FBqVc=;
 b=PBU69DDEGeXyNsrPw+MWN2HXspaXXv41jqOwYTezG/rH/gPyx/rkRvjcyMVTHA+BOr04pzmuyekk+ExQ4aWdgrFUohP0OhIu7XJSGH5Et4s6D8qtg2ofDERQsXfW0x7DD1FJxZSTkyaOmetMFmaB9pYHiARgXs4m/DNvBSo0Cc7BlJB36pbXpYphqs11YJl0IHNMMfXWmHjXzJCwISbIHEV3tby4HqRvowT+igPCv2qKKrSRKY6sQBod9pK2nEAGIrBg+dk9zQ9I9haB3XFhZRXO2gJoFRQOnTU7K1UoDXxNlbefMGxjj9BpfKyUhsLAeQW1Ago3Yg2uGgcmk7RhRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fn107YR9dfuYfxxYF5wLE3q6mJvuBWlXVhbSv0FBqVc=;
 b=pa/72+Ha69WeDpSbAQmDh9EMFKdI8JYM7drzEbpfZA0JcH0tviTZxQGIR8AIVX/OhQJc8KRd72gR1k1fq3juvc69mUb3rwd/lO4WVwYp8/T9ZZWtEFClSxRVFTRVCosYo3PAAl8wcVzusXc9/FSs9LUaTgyCW/VL15goLyUc9rI=
Received: from BN9PR03CA0061.namprd03.prod.outlook.com (2603:10b6:408:fc::6)
 by CH0PR12MB5105.namprd12.prod.outlook.com (2603:10b6:610:bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 16:49:12 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::b3) by BN9PR03CA0061.outlook.office365.com
 (2603:10b6:408:fc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Mon, 7 Jun 2021 16:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:49:12 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:49:06 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/30] drm/amd/display: Revert "Disconnect non-DP with no EDID"
Date: Tue, 8 Jun 2021 00:47:09 +0800
Message-ID: <20210607164714.311325-26-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15ad75bc-a60b-42cd-d821-08d929d42d65
X-MS-TrafficTypeDiagnostic: CH0PR12MB5105:
X-Microsoft-Antispam-PRVS: <CH0PR12MB51051B4608B9DC7E71917422FF389@CH0PR12MB5105.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R039dYV5msujwcEMxQJl1rxnSyQlxyQ93IpMRPWpRRIgYJqN7P0CIXvw/dS5bIkKKazVikDV5rSrpDU6J4gA1u+UkkWhhiynzmgToHmVoPH5ayVDypZaAm6uQh8kfsszZxYzOkXZNzC4DU1tAWJ7FXZaft3oLkym8QSAlhkqCO8PugOEHOk9lzdwo4Rf/wrF5l+4G6z+f9O31CT/oFdnS5qLaX4N2bHY2dsfQq6ujXc9cdNN1618pGcnMkQFMI6cKXecjI3UFb5yrmL7bBfG8TXC6g1rqIfjuUtci0nEGJm6g7vr/ACzI16PimqnjwjZNCZxjS3zTvcZ6nCiMfSFnQ31kYtmsRU9FGcMNKR4RqGoTLgbK2Q8BksYtAmHMGTNSL39fq+egZJWIOl3+q2eIhXp02gPIK4pHjqemfweuPlxWi8UXAC3G09m/biX1qiObKu1vh/oBJe4qqXojb7XpM9PSgh3BpMSB6cFPkuGBmpmTrxuCw0gE+/nEyYUa/gRGkbVVROIzX09TPBB0piWYMoWZVKdLNCj+9v7dWjaJkBJJEVh2evLANvYPvu7VFh+n+Zt3UV9rZEQFAG7CQw2PixqQ2jbkSI6rK+QKjqOja3MvMEOq6H3Q8xu6dk9Z8Rh88VmNsszW8aIctG+31Rk93Yo/fP/UkKXGNBjHy5LGvG6CYcxUl403yNoae3UKf0W
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(136003)(396003)(376002)(46966006)(36840700001)(1076003)(186003)(16526019)(6916009)(36756003)(36860700001)(26005)(70586007)(7696005)(82740400003)(478600001)(47076005)(70206006)(82310400003)(336012)(426003)(8676002)(2616005)(44832011)(54906003)(356005)(2906002)(5660300002)(81166007)(316002)(4326008)(83380400001)(8936002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:49:12.0661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ad75bc-a60b-42cd-d821-08d929d42d65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5105
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
Cc: Stylon Wang <stylon.wang@amd.com>, Chris
 Park <Chris.Park@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Roy Chan <roy.chan@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roy Chan <roy.chan@amd.com>

[Why]
Found a use case (IPKVM) that DP-VGA active dongle does
not return any EDID and the mentioned commit broke it.

[How]
This reverts "Disconnect non-DP with no EDID"

Signed-off-by: Roy Chan <roy.chan@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index d1ade55a8d47..7e699a5bfd24 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1099,24 +1099,6 @@ static bool dc_link_detect_helper(struct dc_link *link,
 			    dc_is_dvi_signal(link->connector_signal)) {
 				if (prev_sink)
 					dc_sink_release(prev_sink);
-				link_disconnect_sink(link);
-
-				return false;
-			}
-			/*
-			 * Abort detection for DP connectors if we have
-			 * no EDID and connector is active converter
-			 * as there are no display downstream
-			 *
-			 */
-			if (dc_is_dp_sst_signal(link->connector_signal) &&
-				(link->dpcd_caps.dongle_type ==
-						DISPLAY_DONGLE_DP_VGA_CONVERTER ||
-				link->dpcd_caps.dongle_type ==
-						DISPLAY_DONGLE_DP_DVI_CONVERTER)) {
-				if (prev_sink)
-					dc_sink_release(prev_sink);
-				link_disconnect_sink(link);
 
 				return false;
 			}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
