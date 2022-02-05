Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5761DC433F5
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 04:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E18CB10EABC;
	Sat,  5 Feb 2022 04:33:33 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 141BC10EA75
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 04:33:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5OQRFnQzwDA5CeR7G2WwXyUK/fJTIKQAkU0mRgmrbOoSiZuOr+O+Ji6HsmlHjmShS+l1uE03hNeoSKmNEZpiVAaUPfw90MSioSSLeJwQQrRncnk3Z8+tZEqfzrtgChhASXs81UE7Uik5sDT4VB4Vxt54DaKNymlrJ3xlEtJvaCoXpE+Mz5a+YmG0ZIb8FGLAjJFRgC19lT9nusOay/dSk4Kd5Ffs9W9shMRzkB8XaKxsjmb6BGkKznk+ZDsL/g+3dN9etO8rdNYAz7dQLy/VHrWZ1o/DmiZl5U3kWajnyu3uwnLWxJ5zKAR19gq9K1GXfPs9WGQFEbIJggmO2KVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASo9lDomJio3oowD4+jH9I2CpFgbRFVdgCOYZKRmBLw=;
 b=DYIKdte73oTb7jRtNy9NLqaGsdX6s72MCPb6MsjhXAOGgVxUIidjah92WP2b44s0tZCVCg4smrJhcCs9Sg9Px6g0Hf99KzFNho/OYAo4nYTGCYh5grzRCWs8RBE59G7PSJBYFGObpipLVvHxN0SIDZOR98+RA16bewLt3BU0IZ7Jywr6/vQPwnKt7RPtiBN596Iv+p8R/eqOdU12RbwwiRHxUfI9x0D9a5FA4zyqhqaDthSHjpxc9VAVWSNrP4lcMDSmIjvoXwvk1KiuEr3QVor/ULaaXy6/6gVuw0GsOF2TJqTnsB4GmI4C3qyxfwEs0h+Hjox6r/DsLO13dmr6Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASo9lDomJio3oowD4+jH9I2CpFgbRFVdgCOYZKRmBLw=;
 b=oFkzxqT5OWgfLCtIcs17kgtGewQycfwdBNfVyAMVWOYT8vx6u+E+2OyVpXlGIBhkFJKrTkQPSSZW6GEsmDDhhFdKPavz3XOV+w5F/EVyKJQ2MuT9f6i4VAP1d6qAHvV+mjyFu6KPxOldihO1vADsSZiW8UGNFT+vrlSH8eJCJ8g=
Received: from MW2PR2101CA0024.namprd21.prod.outlook.com (2603:10b6:302:1::37)
 by BN6PR12MB1906.namprd12.prod.outlook.com (2603:10b6:404:108::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Sat, 5 Feb
 2022 04:33:24 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::79) by MW2PR2101CA0024.outlook.office365.com
 (2603:10b6:302:1::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.8 via Frontend
 Transport; Sat, 5 Feb 2022 04:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 04:33:23 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 22:33:22 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/13] drm/amd/display: Fix for variable may be used
 uninitialized error
Date: Fri, 4 Feb 2022 23:32:58 -0500
Message-ID: <20220205043310.165991-2-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205043310.165991-1-jdhillon@amd.com>
References: <20220205043310.165991-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed121a74-6454-4434-0e3c-08d9e860a56f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1906:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1906F71567805F0E90D76DDFFB2A9@BN6PR12MB1906.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhYwtnS1Nm5kvEltErQq6ChI3sMzQnraGo8JMaUc41amlsB8wy4y+R72yPJhqWOn244ukm8qF6K6N9yljfqJ2Rvs+9ZyLtYtE5fjBWahDzWthfSHfyoKUJz4iQSPHCf1ldMH1Wmt31m+eyRCfZQoBigy+sXRH9cCd5FoBErNbOUPoIgXd6Alw3Ux34o4MVxB/C7Pz+53KOM99CHYJbiiX4C9AYCT3eu5r2joWkNBqZnq8wyIXD4OkLvU732GkoxkUndK071c5j3C75EMYAJS5NrUWlXZWfDbXENlcuIvfGRR3LH27L27gDmjca+RowaYrYLIWMKw3t0fKtznkXi3tbwa4GT1xuF7KIoWYky8NUxmH/mAOH1YtewXnJhbtPKYRcFTXP2By7AyRqtMwwytUOlzHp/dq/BDXTa/OM9KOMD/TS/VwvRfL43fYg42IprW1FxtBYH9zgetNq9wt0NZXLOeNfSjGJEVxphjqIvsg/amY0RJRFkz0rC96Xlh0yM00PdUfL0SoR1Tdw6Mm7n6RJc3WWFyPynZ+yGZdIp3nqDO2LGXU828ytK+LoSZzH4Typ/8WxXvv9C+9kGEOnGFNnMgx89KM6l1DobhjZhYi9LJ2powyVaIuxgQLPSfvkNm/oZji6YRNKClciKEe+3Yk9iRlmwThtzDBCRJoLTTDP9ccJJ2VeZao0k1eFzCxXeuA132m0idiTBN/u4wN7mqGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(8676002)(8936002)(5660300002)(36756003)(40460700003)(70206006)(70586007)(316002)(54906003)(6916009)(4744005)(2906002)(82310400004)(47076005)(356005)(81166007)(83380400001)(36860700001)(508600001)(6666004)(1076003)(2616005)(16526019)(426003)(26005)(186003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 04:33:23.7627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed121a74-6454-4434-0e3c-08d9e860a56f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1906
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

[Why]
Build failure due to ‘status’ may be used uninitialized

[How]
Initialize status to LINK_TRAINING_SUCCESS

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 18fe8f77821a..d0cb40df60a4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3199,7 +3199,7 @@ static bool dp_verify_link_cap(
 	bool success = false;
 	bool skip_video_pattern;
 	enum clock_source_id dp_cs_id = get_clock_source_id(link);
-	enum link_training_result status;
+	enum link_training_result status = LINK_TRAINING_SUCCESS;
 	union hpd_irq_data irq_data;
 	struct link_resource link_res;
 
-- 
2.25.1

