Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574DBC433FE
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2854B60724
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2854B60724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94C986E122;
	Sun, 24 Oct 2021 13:32:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 028296E11C
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltoCnRckw11d1sxKDT4TTf74towYnYtrIfa+ZRBfS2NvijUN2sLyPZvNw4VDageprH300qkz89TNChBw23xCBOOwnY5h5jR3jfSgewP/QYJM678pyavXxbjCdggbts3qm1fGutvA6Vd0HYIXvW9KA+t+yQbdfyNb4ufUypzhT9DuxHQXf+Zc0PG3uxYsaYHYwHEriSbgUQ4qb8WTrdcTkK6xTMjszBozjGY+qdxenKhlNvUdxTOFcUnMVV822ipetaQ9JVGR9bio6rDXaB9BW9Ih1p2Sdni/Q+k+U9TEaFaz2SoRT/r4XAY4MRzz3vLT2o82fZHbupuJH33asDd6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A26I8U2MdjlRNes3pKAohUB1fy3QXIHNelUmXDaQrf4=;
 b=ENgbLNZ88vuTt2YY62ZgTnGgjDoiacAmeQBHuT+Vrm1ZIRs4kHIKTquQEis5oZPekMwf6/iFwLuhi6bmM5nMJL8wnpnhMSLLDEP0EaCD0zd4COAe4/4yPrSrqMgzg/Ee0m7mPCKVkjuAmmn3TzMwQKbBPdt7LikhQvAQ6E7E+9fWVGknZ+MMu7VMdb3zBXmu1kGevyRQ3BX+29GpxoP5RNDdH00BEXNkdFi/IhGxapPpc9QcBNdXVe52/6lsbV7fUZC4GGjIcnXRW2KAdzLSl81LESXxc8P03IclIbDpDiByXF+WNPjhgu8KFJDLYr7KP7CV2CQLnovZPYnATQy+ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A26I8U2MdjlRNes3pKAohUB1fy3QXIHNelUmXDaQrf4=;
 b=3a6BiXCtMZdnF/4gWYxP9tAgc2yiatE4nwlYTHJKTakDM0nNtWiB4bT9pzRzPuWVDTqecz7Sle40IroNmrtCDXMa0rozDXQD4B9lDS/yGvan3ZZYTXx6nBzpe6qlRV/PlgzoxkYsDEEVh56Je+o0kra5/oX5mLlkSq17Az6SR1o=
Received: from MW4PR04CA0073.namprd04.prod.outlook.com (2603:10b6:303:6b::18)
 by BN6PR1201MB2496.namprd12.prod.outlook.com (2603:10b6:404:a7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 24 Oct
 2021 13:32:28 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::2e) by MW4PR04CA0073.outlook.office365.com
 (2603:10b6:303:6b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:28 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:22 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, George Shen <george.shen@amd.com>, Wenjing Liu
 <Wenjing.Liu@amd.com>
Subject: [PATCH 13/33] drm/amd/display: Add comment for
 preferred_training_settings
Date: Sun, 24 Oct 2021 09:31:21 -0400
Message-ID: <20211024133141.239861-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbede87b-fda9-4a24-4246-08d996f2b971
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2496:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2496FAD2DE00B6C7202BECB398829@BN6PR1201MB2496.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: APo6cTMg4oUF8AULv54Gy3H8bL5uVNO+VBcVOkgnv080bo8KPkzxCH2/fpj4YflHFGrv4Hm/O/9xYOREeA0w1CekTncgtaftthhq+5+Ty7V5pvwlVMKCUK7qpPHHsnpUKfIIOzz+NJPqm3WWzpOD0msHkMbRWs7VA6p2zjcL7LZm1HOhEhz1fVLZ6VJLyC3lBPJbwmFDgWNFWHqj8pOJljhUbMtn5NDHPZNI9SUwXc2q2TOiXoIUsk4RdIf0kIawWIW7PMA8mcfQBz9rrJ5q5ZH0W6zfUwoAn9AJbeMZkPwcaNKTRsi3PwS3N78MQydaPcyCL7BbQc+jCqD5GRib4hINgQjIPeTNIe5Bq4P0S/Y1+If7MNOLG/vciMXrdJjox9/3nBPpFPacTzf4eYb9Rg8ZudfsoEqUSAa1cgVw1sU7JEQR7wJHb7urt14lOU0tQVJsRwi/QBQqeKpEfciYer0ewFKv8xjo/bPAjNW7wo/D6JwBliPwAsJ2KppMgaUOeLDPRp5mjXQPkC5ypi018fYMiP44hmO53d6ilCTySE8EujE9Kuh/I4Kge0uZ18K32td8C+Ut/7WpMOb6yTYpUoXPXkZcRhy1zTtivXzCLxdWxj7dmNhN0XjRxYNDhwguVv3U8A1FHl/fBneBEanaE8nOJZZhB7OAFeY5a4CD4D8OoWbEHgT4N2X9/s4mhM+7rTPSfWcYYcnQevG49YOJAwhPkPL2NOqYtgPjCSX2Gq4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2906002)(81166007)(5660300002)(47076005)(2616005)(336012)(86362001)(356005)(6916009)(1076003)(54906003)(70206006)(508600001)(4326008)(36860700001)(16526019)(186003)(426003)(316002)(26005)(70586007)(82310400003)(36756003)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:28.5546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbede87b-fda9-4a24-4246-08d996f2b971
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2496
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

From: George Shen <george.shen@amd.com>

[Why]
Currently the naming of preferred_training_settings is ambiguous and has
caused confusion regarding its purpose and usage.

[How]
Add comment to clarify the intention.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_link.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 16c6dc5c3bfb..b975d1307eff 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -124,6 +124,10 @@ struct dc_link {
 	struct dc_link_settings cur_link_settings;
 	struct dc_lane_settings cur_lane_setting[LANE_COUNT_DP_MAX];
 	struct dc_link_settings preferred_link_setting;
+	/* preferred_training_settings are override values that
+	 * come from DM. DM is responsible for the memory
+	 * management of the override pointers.
+	 */
 	struct dc_link_training_overrides preferred_training_settings;
 	struct dp_audio_test_data audio_test_data;
 
-- 
2.25.1

