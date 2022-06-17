Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F4AC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37E3D10F4E0;
	Fri, 17 Jun 2022 19:36:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9BDC10F466
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:36:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZPuT1zH5umnQqOoZvFOIC35mWQtZ35bKCMMi065GBjx0H19xA7mTH3g/6z8yqAnx74NiiKPKq/s7wMYr8j2TuRWcQjLP7LH3I/oCQtdTxyH0g2Cdldm9WTj/ucygkWZ6UddOrhdPQo2H0JD+TygOvOzYPmcWaWHbmak1aQKxANHT5t6KqohMlRh8+dcyOGJ+Rytih1w4T7ng6fkUcQw7A4aITuQ2pKUtVHoQLAsn4anOjCo1NJJ/EXpizmEwEVylVfpof084Q7cMgDqlpFeb1KTPGStpUNyjKeyAZmVNP6ozBauHfcKXs7s9x+q5H++mkvmn0GYyqQkP+fbyEjaew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buPvFDq0KdgQwTzwSnN2NgR0RrIg1lpsEjAJE4Z/CVQ=;
 b=Fnojio2Kkevr34jm5L6eXhcnPK9DhUfhVzutOKf9gNyr5TqcPxF+CI7dbr6xnwYpUyGIZ3qRtseZcBwYVscIjDwn7JsEiInS3e2cC9la+W5duNKQTFJ6M4BUDMuNZQgHn0KdvydQ7qppDkv0kuwu3hSocG654CaQQxgSHP+wImNcvXWMFMx1Vzb4AxARt6fLGcNPSE+B7j5TE7cXCCARwqMq/v2FK7yfLj8zvoTTkQYYqHhhJLbpViC38ldE4YmC2bPjzJ19OFgA+LV8NkoALtXsWCOlEXPKlkGXTp7wahEYIvwoIItWuvikz0ZrBNqccgmfPOaBPbtuYwxRShjgmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buPvFDq0KdgQwTzwSnN2NgR0RrIg1lpsEjAJE4Z/CVQ=;
 b=vQ5RHsnXxv/AFEnYjnrX6XgJPgnxlyrxj6IcbfablL9VJTmhROK892TD+B0uqNckT/3IHZ+SQRxzoQEYKAq5fYe8agXlK9+G7WqD6ecwgmRdSxcPsbSNjoeYqVzp4lvdpRnQeEDCN68lOUC5FoaElXcMOjtO6H0xtVxgRQ+9V98=
Received: from BN9PR03CA0770.namprd03.prod.outlook.com (2603:10b6:408:13a::25)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 19:36:10 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::2d) by BN9PR03CA0770.outlook.office365.com
 (2603:10b6:408:13a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Fri, 17 Jun 2022 19:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:36:09 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:36:05 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/31] drm/amd/display: Drop duplicate define
Date: Fri, 17 Jun 2022 15:35:11 -0400
Message-ID: <20220617193512.3471076-31-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f43e7d3a-1624-4fcb-a99a-08da5098a11e
X-MS-TrafficTypeDiagnostic: MW4PR12MB5628:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB56282C7D91A0C7F0EB4D380898AF9@MW4PR12MB5628.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0flgojp1YDiRYlyMfeCU/X21xL171TStCykePRRfMvjOt0qcW4pmT5byLcTHF0UAKe5LJvNfkbcQBR2u4f0oavN6knGQ2esUDBbZxW+qNnqYxaLh/93uNC+oVgSVBu1PPBnCVSGQYBmNDUHNuCUkDeLqb+0YzUyVvV+W05m++6upjVbY4z1gcxX80h1vo8RRJqQNwHJaplh20RjjRdn0iT2r4J5wUbpfGGOurOYTXkmnOsFxE+aHBXCRC1HA6WsjIHASnFj7oaVr9Odstw9LtWy64wk1Bt2Rlp2tYbksA+TX9xjWUPxNliVR+32zRzx+2ORBcRt0lslC+eaY524/paF/I2c1Cb9m4E12v1uSwlCKaMeKwTDF7XGwCrG37tOg7MxyNMKjsCX/eLVahxnCWZMy6xYEJYdAbnv2ewyAkO1xFzGfUL7DQdiU6Y8zsxPMZ/Ql4MsuOicDIX+SABxGzoGKZzpurojb/cu2+SufdaD2m/b0G+idc2R4vTsbwOS0UIh3ULp5t5jO7DyiZDK5WrDfVn9waI8x4DyEZZL2JzKMBF7SReFQcBz5AgJKYnMAU+XqjEma/Ei2DSIdyhEry8fJJpw4sqYwgxGqOs0qwrQMmH6th0yCDIZ7VSmUwyBWM/E+fz98i6+5ag10aMqkfTq2at7v0HXVGyNyliu3HR0u6ZsKIxBPS0CPUoYrzx7f2S1eAobNn5NuRmfSyWULw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(70206006)(4326008)(4744005)(40460700003)(2906002)(82310400005)(26005)(426003)(498600001)(7696005)(54906003)(6916009)(19627235002)(356005)(6666004)(70586007)(36756003)(316002)(81166007)(186003)(36860700001)(16526019)(8676002)(8936002)(1076003)(83380400001)(86362001)(5660300002)(336012)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:36:09.3957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f43e7d3a-1624-4fcb-a99a-08da5098a11e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5628
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We already have DALSMC_MSG_TransferTableDram2Smu in the file dalsmc.h;
for this reason, we don't need this definition in the smu msg file.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c    | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
index 67ed8bf4510b..3137b987f0a0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
@@ -34,8 +34,6 @@
 #define mmDAL_ARG_REG  0x16273
 #define mmDAL_RESP_REG 0x16274
 
-#define DALSMC_MSG_TransferTableDram2Smu          0x8
-
 #define REG(reg_name) \
 	mm ## reg_name
 
-- 
2.25.1

