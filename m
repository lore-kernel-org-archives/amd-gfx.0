Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ADDC48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1C08613E1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C08613E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8408B6ED8A;
	Thu, 10 Jun 2021 16:29:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80AF56ED95
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlaxn7rhG9yVL5iou3Tkrt2C073WmKi5JqsjUvlhtI0XXd+i4HE8cMtnYvUR+GxfW5ZSXa9YOhVM0LL/O/TxcttlMX4PBLWSeoA4pOyFeEg7TlmDLV6/HkzSrN63S+nOAXLpFrt5gO9EtDepXn80pr4R4H4ugi8ncyL6TMqOs2WIUFIcyHOnLdwnK0KE9Lug748c4RbdhrDPhpT5Yd1qIbU/tdq5Ml5ZFvAXJPw1PcrzOul1c7mCoZdIMQ+tQWY2/t9gLythg31XGeoDISBqqU14XgtkhVUUzM20t38d0RqQLLfTzwhxTGPvrkeKeCcgMIMWr1/TlIjoILLXSOaJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3G3gz9mTziIC3ImzVOA9O0tvSEWTgdRv4TIT9ObphU0=;
 b=eRMcS9V5dRF8Ak/5/t7rA05VXdMKrEKCJdcF8iaEpQcI4N3htUDPzGn7wcFS9IpnB8wY7Vh5yXQRkDFWibRWcVXOj1Xud4tCx4iEk0PZTu+oTz2rhAGeUx0xNHhPnYN4GyctmF/7FpTeoHiPwVNE0YhWxXm7iMvFa1IjFFgRMN4+G943sYxcHZDka8Mza1rwMMq7JOziEYw5WQZxEuzfRP4DeFbuORGvybhPOS258hR0ctv+zD0n+K7vHAzTnYMFjetFRgYKwEUG+/yqpctp0t1tA6/XE2sKUm2XXQ4vA7JiWozFeHqD+FGEWkzFOSpZ7+JHvy8MdfLp+9fQedWyIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3G3gz9mTziIC3ImzVOA9O0tvSEWTgdRv4TIT9ObphU0=;
 b=Vm/T33votHeoWdbNece92k6bsU1xn5Lw9f7E60l3rkqCZr/MWGCf/6nfKj/744vM1TKMSv/KAVkQELdy8n07oTSQhitE0sUKQx6cvKduDVii4hyxv9ODeXnN3TdGbMbuBnPXCd8+vLUdmMBEnqnmNVBoHHqzXJmPsQYt83RKSwg=
Received: from MW4PR04CA0292.namprd04.prod.outlook.com (2603:10b6:303:89::27)
 by MN2PR12MB3920.namprd12.prod.outlook.com (2603:10b6:208:168::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Thu, 10 Jun
 2021 16:29:35 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::e5) by MW4PR04CA0292.outlook.office365.com
 (2603:10b6:303:89::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:34 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 09:29:31 -0700
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:30 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/24] drm/amd/display: Always write repeater mode regardless
 of LTTPR
Date: Thu, 10 Jun 2021 12:28:29 -0400
Message-ID: <20210610162838.287723-16-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e757229e-1c7e-46a5-0643-08d92c2cef07
X-MS-TrafficTypeDiagnostic: MN2PR12MB3920:
X-Microsoft-Antispam-PRVS: <MN2PR12MB39209116717F5B7824E102DAEB359@MN2PR12MB3920.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0PO2u3MtLtQ5J+3elm+ZZkXm1yr5dS3CHXr0XhscyMjQQmKbXUiGamH8QESbKMbrFPCjUDHmBFw1WNZheV+7Z/sA50OmtlF01MmjKSUiBb8mdoLJmfqjs6KvXF+cZsG6Kw0Y4FnpnYBNhPtMKKuW5lvOqPyB8dPtjJjnk076K81K9LDahWx4lfYpGlF+2F2HSJ2oZqI7PMyP7rK2is3dBfwPwsvP8YEuTw5//y0mrzah1OsyL8IUOzE6cmEeMD3vjFsvXROLS7KSepsfw73MnobUfi+V84QnLjDNPfezrQftrf2VDrpuJNP2v/oSiCkXmT2ma6OekJdIOiseQU7ZLZecwQ7kOJ/MfmiqqsSj33Q+xsUiDTD9/htJuLX524pf0ruvSJK0lQzewEoargGIifzQduSg0wrEE4jP0n193P1u48gZtchgl2fARn41Exdh4wtMB2+9mSM8O+UgS4rL7uS2xpLz6w94TzqgO37cVEEHHTPOVYSqBpiQ9UzKINXoo+GaNm6jrsPsZCjCq+XvQuE5rfNFDt6tELybWEq4tjq46CEPI1CexZ/cv4l4JxqPtbMmv1h7V9LzMsoVqAmDKarl7P0Mxv2rwnxkjwWOptNdqR1Abqh5ypWA1COK35gpr3BmFXqixC1NhpEQliGgAAT6Ar9ixFmO4xG2CONGaMCLMPcN3usNgrRIyaEb6+Z7Pq2drdv2jPWDFllG0ZQVdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(36840700001)(70206006)(7696005)(83380400001)(316002)(47076005)(6916009)(2906002)(70586007)(2616005)(8676002)(1076003)(478600001)(5660300002)(54906003)(4326008)(26005)(36860700001)(36756003)(186003)(336012)(81166007)(86362001)(356005)(426003)(82310400003)(8936002)(82740400003)(26953001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:34.8484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e757229e-1c7e-46a5-0643-08d92c2cef07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3920
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
SCR for DP2.0 requires that LT be performed with PHY_REPEATER_MODE
programmed to 0x55 (Transparent) whenever PHY_REPEATER_CNT is any value
other than 0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, or 0x01.

[HOW]
Write Non-Transparent (0xAA) to PHY_REPEATER_MODE when LTTPRs detected and Non-Transparent is
requested.
Write Transparent in all other cases.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 586f05a6cd77..c68b49a14f88 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1618,11 +1618,10 @@ enum dc_status dpcd_configure_lttpr_mode(struct dc_link *link, struct link_train
 {
 	enum dc_status status = DC_OK;
 
-	if (lt_settings->lttpr_mode == LTTPR_MODE_TRANSPARENT)
-		status = configure_lttpr_mode_transparent(link);
-
-	else if (lt_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
+	if (lt_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
 		status = configure_lttpr_mode_non_transparent(link, lt_settings);
+	else
+		status = configure_lttpr_mode_transparent(link);
 
 	return status;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
