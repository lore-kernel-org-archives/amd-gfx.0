Return-Path: <SRS0=Y/Ds=M5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22028C4338F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9C7F61163
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D9C7F61163
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84ADD6E1BD;
	Fri,  6 Aug 2021 16:36:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F786EC29
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Aug 2021 16:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/Wg6dYMFOc4H4JCxhRFLYusMpSiiRRUvB3zxlzk11l4xZHq36hrZCeYebnGPfHbjdrYCrXOcTNGVoFJ32yehb9l7GRK/oxifr+4s8oFwUtFxERjozYoUil8odKFkKp4vSH8vLUBbkXpJ3XuglulzdZREOy9vfAuKJOrQ4l6KNknRA2uvq+Pp58AcoM2uWQmTX7f4pBCrB6pP2NkHLu8Bg/VZmR4rSkOL1MajiGpnZnMMFWkmA79SfCyTeI4hQnpv9zSNUK/792no3ZTr7jeY0FO42H6xUKshuYdracLH+VpnhAOTUJM12QQ/CB0g7yaWzEcwyIjQYzKM89ewPwaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MN5uNvPYgId1LNgX4/sfdnD4krrL8ZjxiSM6gHEA/eQ=;
 b=hhZAJOq5z4zdCDnnHq9xBODOs5MwRnP4BkOhe/+U5FbxMWPcyRQNZrGCInMOnjManzaQk2mepqjL5n9SjeR38Dgaz4OKg1U1k8tcL3G9HKYILzk64nU4Ko9p9zQeYlYv4AbjdLATj1VDR8gDANdvd80QwHXR/hF9Q0QU20KicrY77506ODkgDHNCi1Ocy9Aq8YBZFLxO41wlLJC69RivyWS9mLSm23AZANbUsHFBKyZKoMhnSTfMVVT8CSxhCsZ1INPjyq7XkeOlUoTtqF2JwXbR4uGUPMUydmWkir3EhZ8WH/mLYU8JBUD9Je40CTNFb+KpQ+RgPhLKwBDw+klA8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MN5uNvPYgId1LNgX4/sfdnD4krrL8ZjxiSM6gHEA/eQ=;
 b=ugXWE1wdPAQMGz8FAZFQvWxdm6kJYicfOiJ76nQ07QTgWvPZCNg6sowykEDWJrxZ7LhkMbnS1wTsMWxB23EyW0zlvSrfRb5BrS5SCsvMFqlVIOxo7Wr4/Irmty7rvE9zio9+AfSrVC9fNOQy4crX69cLdMb8czYHGFxldRljKzM=
Received: from BN9PR03CA0659.namprd03.prod.outlook.com (2603:10b6:408:13b::34)
 by DM6PR12MB3738.namprd12.prod.outlook.com (2603:10b6:5:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Fri, 6 Aug
 2021 16:35:53 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::fb) by BN9PR03CA0659.outlook.office365.com
 (2603:10b6:408:13b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Fri, 6 Aug 2021 16:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 16:35:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 6 Aug
 2021 11:35:51 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 6 Aug 2021 11:35:49 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <Eryk.Brol@amd.com>,
 <bindu.r@amd.com>, <Anson.Jacob@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
Subject: [PATCH 09/13] drm/amd/display: [FW Promotion] Release 0.0.78
Date: Fri, 6 Aug 2021 12:34:45 -0400
Message-ID: <20210806163449.349757-10-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806163449.349757-1-Anson.Jacob@amd.com>
References: <20210806163449.349757-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80c5d391-c769-4cdb-8ec9-08d958f84249
X-MS-TrafficTypeDiagnostic: DM6PR12MB3738:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3738F6B6FCE277AB19B1BBE1EBF39@DM6PR12MB3738.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRbLAv/909/eUHkhycd+Bt/8MuTdYuRAyckKmp3fVrMbgIiLqbgCXyelkTjM7FGo9qhF70+NI1S6ghIWpqfGxfaBPLo7Ra9Fz0TvOl77hHwbF8QUTh+4mj8NdWozzLPA/YsmVVX2zCQq1QYnYy+qC1I0awj0d4fSx1vziIUgJNQCELN6/hdfG2BDMaeezDf6lOyVKdNTHOJCfjUSkWkK+2oFpdmnrRZU3B8oJ8XkU30moaOer7eVYyQ6cTRBcbXSb5bkAaGGhLu13OcR9OqzUzelmPu8KR3ZirfbrX14p2Zy7k6iE6m7XOADcZ0dQwXpxEb7pUaPzovu/LTnsSVTiaIUTuzr8s2wFRasx15ZVU6pDO6YpXDs55/0ofsYmruyPHgSAH1NoNt8ABktRZ3y5E0uatD96ckLx+Dh0POWsM5FCEhdW5Q7l9gnSvxGUDf4tHkI7u3YLgql4qBqpjNcl6YfWyK8pfQcQlw/9/Vwsj7kZ3I1EbL2bQc4qThMAiuf8T5CfMFFOrCBY6wDUngY6ifcc7DvIk6CEbXX6NdjyQHEZVv+Y8UDQH5LimW1WxquMY6EVj0XH3ZR6hG0HkMO9r9rG4dQimsCJs+dN00Wbp5Mp4vY6z+KHf0G5e5Kidv2a7QZTVSk4MD6BVPs1ZJkR7HUYaBlwACgKBEZEq+7MqBUQQ71Kt5NiBa5dsash6YrEbKzyg+qtdNdTUdeyvmp/Fb3I+CtOD8tIXe+fxqbAW0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966006)(36840700001)(47076005)(6666004)(82310400003)(356005)(83380400001)(1076003)(4326008)(4744005)(70586007)(478600001)(70206006)(8676002)(26005)(426003)(316002)(5660300002)(7696005)(54906003)(2616005)(186003)(36756003)(8936002)(2906002)(336012)(86362001)(36860700001)(6916009)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 16:35:53.6446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c5d391-c769-4cdb-8ec9-08d958f84249
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3738
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 661b32a5ff9b..5950da7bf252 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x6d13d5e2c
+#define DMUB_FW_VERSION_GIT_HASH 0x9b7fa7783
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 77
+#define DMUB_FW_VERSION_REVISION 78
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

