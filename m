Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3592BC4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA98A23B5D
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA98A23B5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9949E899C7;
	Fri, 18 Dec 2020 22:29:59 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D743C89453
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 22:29:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8272TSnWJpT8+GXI5w7o/mVUwz3DDF1rvrpK4rGwldE6gmJA68ZmrwMORQU7SxuTySYfMuwCiKfr9rJoIFxwEBOFKvmz6UVurc5UlcncQfQfbptv9vtltCM+e6zpqg27iqb0YSxZqSJeWi2mR3L2+nGZKyDf8BafhodznSSxDA3BT0nqfAgj1LGpUq4Qc5FEceVbf/qmklRPB70S2xrSrbf9lJD+M5QSNc4bRlqJJq36FVUwkwQjVxh6J0Gjm4dTE3tKQdB2Mzj2+8R9xNk/aJwYlOxPE0U2thMX/iK32Bk0jSPw4XGwJoZxOHImvh4x/xTkwAAmXUMHqW1o/0pxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxRWUuUXpsTnb2WPW68Gzqzgf7XWrgYU8HJva/mzPNI=;
 b=fsos7H+KCT4eg4iI6oYF1vQgg8GjY58HVJDA3BMzPF2k9F5uKMANfg0xTagL3dqPMrhn6siTACGHvDWUm/13+s9kq9Yr3ivsn8rNe5jq84+Tvw/f8T9bXS9uDn0epL3r8fr9k9xvDOaDCIKB4I0NVJQEZ6qIDwQiPm1KPB3CTWjCiQ0emUz+o9cTZvvjkYCVOe4YJlpzJEiLZiHFly+amZMasVmBkz46qcNJX5OTC96nLLgNybmQimj7JOf1RCLVbCRb4QjGgBERUorAkbMm6kBCfOX+593bXr4Tbb2rblysdfs4CrtHClcZItEBFP8bI4EaOlcqd1A9vlka4/FynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxRWUuUXpsTnb2WPW68Gzqzgf7XWrgYU8HJva/mzPNI=;
 b=ZKfQnEf01Y86uF6EMrpeyj78i+b71dtGKcxn1+mC5RVXrZbcUicpxb9pC7PdWYXNhkJfRzBNTvDrCdd5qi7j5wQDg6WernJWqFEfMREeQodQk1zKjvjqI8FhQAhGhaj/2/hLYO36O8wyI6OmxqSFmzG0YT+s/4ho6dTWHxqBRcU=
Received: from BN6PR02CA0029.namprd02.prod.outlook.com (2603:10b6:404:5f::15)
 by MWHPR1201MB0223.namprd12.prod.outlook.com (2603:10b6:301:58::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 18 Dec
 2020 22:29:54 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:5f:cafe::84) by BN6PR02CA0029.outlook.office365.com
 (2603:10b6:404:5f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.28 via Frontend
 Transport; Fri, 18 Dec 2020 22:29:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Fri, 18 Dec 2020 22:29:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:29:51 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:29:51 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 18 Dec 2020 16:29:50 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/14] drm/amd/display: Modify the hdcp device count check
 condition
Date: Fri, 18 Dec 2020 17:28:53 -0500
Message-ID: <20201218222904.393785-4-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218222904.393785-1-bindu.r@amd.com>
References: <20201218222904.393785-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 525bde8e-93cb-484c-20d6-08d8a3a47039
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0223:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB022386C3EBD3EF8B94C7B053F5C30@MWHPR1201MB0223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hDqiiiqWkGn+zTcNZgelxP7GhAHUJndEKQBLoX5TyRnappFEDqT8sW7kNQh2UUWKTHb6QygdCWNIXWdgviwG1ekvQR7hi6iL3CWbsIfcH1N06nqu9P6e4lGRjuGDi5O9BeiTrXGDDat/Z2/Km8c/ykexaPsTFJ/TNGGvg8QJfER3TADvSpH7jH74Gc/YA2eWFM4MjRiKfzh4vk927Q6+rk/ekRQUDac6JEcF7RfEMfk2HeSiTsqOr0UREMV1/rnjWy4vB38qCCeT9y/lcFWlokLAKm8lhTW9yDhE60Nqqug2PMOfySEuqUUBYWDeSMkVwJ1Ggwfv8GKR5mZC4qHBS4ITrAZRLp6Ht6B9tIvlrQ6MWowqPDm6ZwiLaGrEdykHFdp/gHLYIb9/h+Jx3Tbg0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966005)(2616005)(356005)(316002)(2906002)(4326008)(186003)(70586007)(82740400003)(8936002)(1076003)(8676002)(82310400003)(26005)(6916009)(81166007)(47076004)(36756003)(54906003)(83380400001)(426003)(336012)(70206006)(86362001)(7696005)(478600001)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 22:29:52.5241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 525bde8e-93cb-484c-20d6-08d8a3a47039
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0223
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
Cc: Martin Tsai <martin.tsai@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Tsai <martin.tsai@amd.com>

[why]
Some MST display may not report the internal panel to DEVICE_COUNT,
that makes the check condition always failed.

[how]
To update this condition with the reported device count + 1
(because the immediate repeater's internal panel is possibly
not included in DEVICE_COUNT)

Signed-off-by: Martin Tsai <martin.tsai@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c    | 8 ++++++--
 .../gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c    | 7 +++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index f244b72e74e0..73ca49f05bd3 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -128,8 +128,12 @@ static inline uint8_t get_device_count(struct mod_hdcp *hdcp)
 
 static inline enum mod_hdcp_status check_device_count(struct mod_hdcp *hdcp)
 {
-	/* device count must be greater than or equal to tracked hdcp displays */
-	return (get_device_count(hdcp) < get_active_display_count(hdcp)) ?
+	/* Some MST display may choose to report the internal panel as an HDCP RX.
+	 * To update this condition with 1(because the immediate repeater's internal
+	 * panel is possibly not included in DEVICE_COUNT) + get_device_count(hdcp).
+	 * Device count must be greater than or equal to tracked hdcp displays.
+	 */
+	return ((1 + get_device_count(hdcp)) < get_active_display_count(hdcp)) ?
 			MOD_HDCP_STATUS_HDCP1_DEVICE_COUNT_MISMATCH_FAILURE :
 			MOD_HDCP_STATUS_SUCCESS;
 }
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
index 549c113abcf7..a0895a7efda2 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
@@ -207,8 +207,11 @@ static inline uint8_t get_device_count(struct mod_hdcp *hdcp)
 
 static enum mod_hdcp_status check_device_count(struct mod_hdcp *hdcp)
 {
-	/* device count must be greater than or equal to tracked hdcp displays */
-	return (get_device_count(hdcp) < get_active_display_count(hdcp)) ?
+	/* Some MST display may choose to report the internal panel as an HDCP RX.   */
+	/* To update this condition with 1(because the immediate repeater's internal */
+	/* panel is possibly not included in DEVICE_COUNT) + get_device_count(hdcp). */
+	/* Device count must be greater than or equal to tracked hdcp displays.      */
+	return ((1 + get_device_count(hdcp)) < get_active_display_count(hdcp)) ?
 			MOD_HDCP_STATUS_HDCP2_DEVICE_COUNT_MISMATCH_FAILURE :
 			MOD_HDCP_STATUS_SUCCESS;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
