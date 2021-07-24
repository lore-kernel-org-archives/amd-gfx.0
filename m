Return-Path: <SRS0=oGIb=MQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC76DC4338F
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D44E60E52
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D44E60E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03A056F47E;
	Sat, 24 Jul 2021 04:10:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C10D6F47E
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jul 2021 04:10:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pc92UE91BeuWqWjEgbI2fRqmQSqNYO4NeBuBxTQJ18Q5b+sExYT7yCllUSxqSZSH+bcWh9n8UtAmcTtSnEkfc/86zYJs8RZCOeY94hZE6JHkr0lG0jgXbC28GN7YyUwFnJJOjK+R0hGnNp/0nCcUcw4BTy78JoWDAqppgJDvPQej4+NqbQomCb/kIM4+HD4ReeKjV4YzWc3y6Pgt77LRm6GwlrDdzMgd4iQRg2KhCEsZjP9Qy6i6IYFjXUCGsoGWmAvGAWevQuHwXRSBGl+IarJPwGW1Ir7qjWBekbUZIoDKQf8W8yF3NJhpqJp1G9kTo12uNT+swoFAQAL1XUA86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02ZudynBlAgu38U8FgWMDHBbgNBt9uzHD5UWTHT4Neo=;
 b=db9v9p0Ihq8kwkv4+qIpeDkLUD1Fo3sYRfsVEUlhtLjA1IsWFPzx3RreGfb5URkAvtQlzjcJyJpzLBkCYt1L773jmsmvdYebT86eOzKRX1qEVJ5oyNdf8MsPDZMsb/NYHcotEXybDEE5hL3rh39CGjZ9hrunVDZPztzmwSs4tKPfitc+xM939hq05TChxbtFMMXN9h7wckWjKkelOUcVBCqk6uuZ4fn/oxcAflSiS5EQzzoELURbyksYd5LDFt8icDbPkWz3sk3bGa6wfiCiJk9RLB3DXR4aqmwzMMEx0GpO6yYogZQBNBQTW+NCJ5kPW/NBws86dpQG8qHWqta/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02ZudynBlAgu38U8FgWMDHBbgNBt9uzHD5UWTHT4Neo=;
 b=O9eVA1aCkgQ9LJIYIX9P7wA23sggoUkfZTis8CS5mR9clsTxB+WM5ZEmDuBNWkNLPsr9DUnpPO4J2p6jS0fDOGPEP1qR5KxgySmVOT8r8+KjE89pM9VcLwiMmH5C8BKsMphzIIo3HSvtcWs0Y+KlqV2MjAigSDLDDeRoIznE2Wg=
Received: from BN9PR03CA0060.namprd03.prod.outlook.com (2603:10b6:408:fb::35)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Sat, 24 Jul
 2021 04:10:46 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::84) by BN9PR03CA0060.outlook.office365.com
 (2603:10b6:408:fb::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Sat, 24 Jul 2021 04:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Sat, 24 Jul 2021 04:10:46 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 23:10:42 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/14] drm/amd/display: Add ETW logging for AUX failures
Date: Sat, 24 Jul 2021 12:09:51 +0800
Message-ID: <20210724041001.3875757-5-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210724041001.3875757-4-solomon.chiu@amd.com>
References: <20210724041001.3875757-4-solomon.chiu@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe4f47c4-a462-4d84-6031-08d94e590318
X-MS-TrafficTypeDiagnostic: BY5PR12MB4131:
X-Microsoft-Antispam-PRVS: <BY5PR12MB41310993E8728682A0B9EBA697E69@BY5PR12MB4131.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKVziQMbKfRuHL65GHWuHWTTysPUbShcnmM/Jy2f9sUmo2gYIIMRCnAAyg88a7sScFvIWqzOMS31i7WII4hPMg1kChD3EEtNXFcM4DKJ42Et03SnLji3Gv4u/577wtlXelAF4VvseAfbv8aYqrDhXU5tsiyI0tqkMCIXg0sQ7Jz1siNWfNQBHdtT/1NWXK5iG6ROwj1CS/wivVAPyC8P3/wwe+mbtOY8Prw5UdiSwRCTS5LVk1c9ThngcO2YnnjCl4O/j9u/m32o7WD7yP1dub5e3v1bvlP6IhYYAKRZwNQxm2vqqXhIlR5fLGb9vg50rNj11IVNTfUuyppcGkVRwATSQV+gC+NoXNWpFFhWqMuTJZ/JeIO0nPzJHSGoskmdKgRDmYPlJcv3N0fCpc4zAuWKTCK3FtAF1fD8snMBxYYkGOsCzZuK1BpYuImyIdGbpJsWs2tmr8evv21nbsjZRapNt0Xhn8Ui75IKnN+mxuRjmtVmOR7tv65uD7Ldz++H/LogpVLnyWPkP4zYZhdfS6wekxm2CwZgPmgURF4vcqhomOho6DX7WEsexIuC46yLJzFT6YE67xYxu+Z7c96VoLqnLc9pu8OSYNB1LNX895qwb5SnfAZx+PjNDkwK51MWwIDpqDsjCyiCnU0QTzS9lwL052+vlkJ8gA4Qy6bp+mWb0GrdXHhp8EffMc85bp6X5kVOt1acnDZ7x8kx/faIhdXT54mnDtir3AprNoVVGHI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966006)(36840700001)(6916009)(336012)(81166007)(44832011)(70586007)(426003)(54906003)(16526019)(316002)(4326008)(186003)(8676002)(6666004)(82740400003)(8936002)(47076005)(2616005)(70206006)(26005)(2906002)(36860700001)(478600001)(7696005)(83380400001)(5660300002)(86362001)(356005)(82310400003)(1076003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2021 04:10:46.0081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4f47c4-a462-4d84-6031-08d94e590318
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131
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
Cc: Pavic Josip <Josip.Pavic@amd.com>, Solomon Chiu <solomon.chiu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Wyatt Wood <wyatt.wood@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Would like to identify the cause of AUX transactions failing
via ETW logs.

[How]
Add ETW logging for AUX failures.

Reviewed-by: Pavic Josip <Josip.Pavic@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 2fb88e54a4bf..058a9356a39a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -71,6 +71,8 @@ enum {
 #define DEFAULT_AUX_ENGINE_MULT   0
 #define DEFAULT_AUX_ENGINE_LENGTH 69
 
+#define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
+
 static void release_engine(
 	struct dce_aux *engine)
 {
@@ -743,5 +745,11 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 fail:
 	if (!payload_reply)
 		payload->reply = NULL;
+
+	DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
+				WPP_BIT_FLAG_DC_ERROR,
+				"AUX transaction failed. Result: %d",
+				operation_result);
+
 	return false;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
