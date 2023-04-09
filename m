Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34291C77B6E
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Apr 2023 19:21:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A029610E1E1;
	Sun,  9 Apr 2023 19:21:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE64A10E1E1
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Apr 2023 19:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rnmp88ED8qvXiKJFfil+V+JAOEVQhIN/ONjCkn4JQLSCJZcLO+Q7PGH2ZTG9Ww0M6KGZtbbs9bIFKEZX9AuNB6Kg/cJaJVaWfzSbxrOsN3hbR4FrOh4jYN1y8sYnfrjbUuC0USAZ/T9PkPSCLBBn5cp1Ww1DFzLjuo3gtCjFUjLOkdT8BtQw+sqLISBWd9HVIPei7WX/09jxL6UCltQW7Y+1H90HuHPB7n5+evk8MifjLwCFBFEVClCf54XBinr7+gmjw7mqOPYwd+ZCQF+AjP8Bh0rSifYRTxBdZSWqtjzXJnA6yk9W5UkBpMrreOqMU3HdUqw+BBw6PcQdKa/gUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXgIh0I7d1XTB5Dd+lheGjQIz4NV48UHYYwQojyT53k=;
 b=T+RCjcOW6ePfLf8lnhL7Q6fHRVRmi/I2WBiHEXz+QwRYDnjuPfUrbB23AH8HZzyyCQrZXehrWc6jK3Jjs76xAFZBopfLOXrwaJVEbHECBVFMpJru6csrtsjyWNu3xE6uKidehOkXJCk9rIb21DcUCDB6+w1W+1QA3oK9QhWe0x1rtV39J9U23XmxaBv8GM+7zSO9ym1QlE12EPK6X/YszatKYBAqo51gOuSLWPGOfMKCiQ5SWzkBBfRWa/qxeOdVaUVX/e3gurU0ZAnvPdEFJsTr1WJddwIQ2BU8+8yGgNXQAiYOkckVo5qclhMhRxtbnAyb3A3z3v1h0FvnHOu15A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXgIh0I7d1XTB5Dd+lheGjQIz4NV48UHYYwQojyT53k=;
 b=dPLiuGo8GI7T9uIa4N5UNLip2CrycVYSKVvFL1c/HZWbizq4NYbl72rBEBJ+NtDm+qVb6KHx5rcQXN7vmQVPZxKEBhUqFlhbhOnWJouCfVFzLWED+eCd8gZPpV/bFaw55s6yQih9fDYlaG6PiOvBFkEZ/HeRlkQxpKLFx/zvd2A=
Received: from BN8PR15CA0059.namprd15.prod.outlook.com (2603:10b6:408:80::36)
 by CH2PR12MB5513.namprd12.prod.outlook.com (2603:10b6:610:68::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Sun, 9 Apr
 2023 19:21:31 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::66) by BN8PR15CA0059.outlook.office365.com
 (2603:10b6:408:80::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35 via Frontend
 Transport; Sun, 9 Apr 2023 19:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.25 via Frontend Transport; Sun, 9 Apr 2023 19:21:31 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 9 Apr
 2023 14:21:28 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Li Sun peng <sunpeng.li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display : Log DP link training downspread info
Date: Mon, 10 Apr 2023 00:51:08 +0530
Message-ID: <20230409192108.1505595-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|CH2PR12MB5513:EE_
X-MS-Office365-Filtering-Correlation-Id: bda343a1-b726-469c-5616-08db392f9fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kIZ+8bBeMlAQMH/HkbnCnK/jApp2Edqre8Qxg3C8QRuXjO/UPREYC+CuARjbjtNFIrpxYIQO/Tn217XE4MlV5zIN1yEq6h6Bm5eS9xNHWjG9GfpCji8gu2RMlwkYzxfiDgRzc4saQky43upA7LRQk2a7TNmOxBnFs44lrofmS9T52CI2VZyodn09Iq27D3pyNkIiHw6L237atxgeEUMNjPoH65XgIeT4bO6q9ljS4+LvFBYjMfTyp+AKU4DndkNYCFcNy8oCWrVlzbmLTkW47wmZB/UIx57GCsZC9Hn2z5YdKYs0Ma4zRek+VSJTgqNO5J7zgOhAZMEI/E9cqK1MlnUkWLlg6cWUBfiGsguFMoKz50qXTXgzG43EvjbTNNm4auQhoRRi93iaZ0qfo4fuY2Swkl6+wL8CRDQmsgKvCFbQOub8y2rQdsCsFnmYo3UakE14IEJg+fgIAjF0t+kUBSpIwd6J0U8BgSx7+XU5WssTe/Ou+VY3NMruuK9/qCftYbesp1vBVOsVThh1fn2IQTP5sz8DcELicoO3C53qkwel4Y8IMKF0khxLzerV4lrjTigGyQC5f/WyJrKcCnywzTTbaL3ZCIAjP9dt67AkSzlonDPDLCJRercc5U/eertT/gQkx6g+R5MujlsUKh30p2N2sEQswk8Qxm0a7Ho0M4zcetaIWKWG6cKE9J5B4FVNyS3AkV8v7EVjF6Th8x1bSfA0Rm9kweztFrtAw9qw1aY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(478600001)(7696005)(54906003)(6636002)(110136005)(316002)(1076003)(26005)(16526019)(186003)(44832011)(6666004)(2906002)(4326008)(70586007)(70206006)(5660300002)(8676002)(41300700001)(8936002)(82310400005)(81166007)(356005)(82740400003)(86362001)(40480700001)(36756003)(40460700003)(47076005)(83380400001)(2616005)(426003)(336012)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2023 19:21:31.0196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bda343a1-b726-469c-5616-08db392f9fd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5513
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the existing log with DP LT downspread info:

[Downstream devices shall support down spreading of the link clock.
The down-spread amplitude shall either be disabled (0.0%) or up to 0.5%,
as written by the upstream device to the DOWNSPREAD_CTRL register
(DPCD 00107h). The modulation frequency range shall be 30 to 33 kHz]

Besides, fix checkpatch warning:

CHECK: Alignment should match open parenthesis

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../display/dc/link/protocols/link_dp_training.c   | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 70fc0ddf2d7e..2d067a4a8517 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1560,9 +1560,10 @@ bool perform_link_training_with_retries(
 	j = 0;
 	while (j < attempts && fail_count < (attempts * 10)) {
 
-		DC_LOG_HW_LINK_TRAINING("%s: Beginning link(%d) training attempt %u of %d @ rate(%d) x lane(%d)\n",
-			__func__, link->link_index, (unsigned int)j + 1, attempts, cur_link_settings.link_rate,
-			cur_link_settings.lane_count);
+		DC_LOG_HW_LINK_TRAINING("%s: Beginning link(%d) training attempt %u of %d @ rate(%d) x lane(%d) @ spread = %x\n",
+					__func__, link->link_index, (unsigned int)j + 1, attempts,
+				       cur_link_settings.link_rate, cur_link_settings.lane_count,
+				       cur_link_settings.link_spread);
 
 		dp_enable_link_phy(
 			link,
@@ -1640,9 +1641,10 @@ bool perform_link_training_with_retries(
 				break;
 		}
 
-		DC_LOG_WARNING("%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d) : fail reason:(%d)\n",
-			__func__, link->link_index, (unsigned int)j + 1, attempts, cur_link_settings.link_rate,
-			cur_link_settings.lane_count, status);
+		DC_LOG_WARNING("%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d) @ spread = %x : fail reason:(%d)\n",
+			       __func__, link->link_index, (unsigned int)j + 1, attempts,
+			      cur_link_settings.link_rate, cur_link_settings.lane_count,
+			      cur_link_settings.link_spread, status);
 
 		dp_disable_link_phy(link, &pipe_ctx->link_res, signal);
 
-- 
2.25.1

