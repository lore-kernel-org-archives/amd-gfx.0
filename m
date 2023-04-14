Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4409DC77B72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95AA510EE17;
	Fri, 14 Apr 2023 15:55:29 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4457110EDF7
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:55:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZWM1NWVdnC8Y9q9a++74eOQYrXQOMFqnOY6x778W31WmviShE0cBQZqay6d+GocMaRlHvSRiOgvqb8hZj1nfZNRVmhlmhJhGA97Q2RdSx9cIjcb5obwjDy5+D//Pf/ihFtvSjqayGaPUFZI+qVVbnGgUlT7Q/iS/RsirRgRMBxb7p20sQr6Un/VodMLZoTaSJSq3TTrGnqrpsa6Ely21PoAeIg6DzQNhVwAABHSy5FXkNytkV67z6ygP5tIVNl0mB0zOw4TVQP9mHuqHgsonnAWdSx+zuJ4SvV4OgxD7IQ26oOPoRm/ZwOsgPRruqPIx8Tcl/Z0j5Zp/LmfrygxJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYzXF0HYQdKSPov78n9xe+7bBmbj4XzmZSuhYIPh7yA=;
 b=k3PRGjXlTNSOs1xsIr+ddbftsThsouydZ+5mgsnqOWTu8T8cWYEPAdYXsFNzI+mwTLlXLPsxRNXVgIKLPQ1n6oN4ksfV+PlFcQM6qrfrxoZj7mKJwwNls8V2oRrDrDNGq93WrN5FIRRNip01UI92HuezYeO6brXk9M1f2y3u4Cx51JBukKERRKmA3CbHbg4iF644ybbBOCYu6GIoVGzCn00OuL8nQDMVw7OrP1/Xxu5M8MTnAEdkbkl64yikRclBbpjgWNN1OeYJXI5oyxw1LIuicFymwlU4LbehXeghJkj9xBpitBehLCxqN5QBjT0gZEo08gTnU8MtvELSuAweQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYzXF0HYQdKSPov78n9xe+7bBmbj4XzmZSuhYIPh7yA=;
 b=MOtY3fpq0468Yc9qvTfI5DHOFb8wR1mo7fI0D/nMxgyXe5gbbQCkUQ0MkdLKkSbxZ9bGL/TdGgsQWE3G2KYMUZ9Sd0QQNJLBxH9pC4lBEOfCt1hyeiDdYuB9wIV1dXYw8O47lnru8AFrhZ9n7EhfCkLheXDED8WTkBcvYz2BfVA=
Received: from BN9PR03CA0554.namprd03.prod.outlook.com (2603:10b6:408:138::19)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:55:22 +0000
Received: from BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::46) by BN9PR03CA0554.outlook.office365.com
 (2603:10b6:408:138::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:55:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT082.mail.protection.outlook.com (10.13.176.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 15:55:22 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:55:20 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 63/66] drm/amd/display: Add FAMS capability to DCN31
Date: Fri, 14 Apr 2023 11:53:27 -0400
Message-ID: <20230414155330.5215-64-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT082:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aebd1e9-c9b6-4131-8d1a-08db3d00a76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rvSinuR9pjmld+Yzv1ufJjanSbBonWqIWgzpVZNSjGSjKPSjXRgNL0dJcIzguS5P7LlUyLfdi0JEBN3Ln7ki5KTnm8zwxr8bVK1vh4IGUpyBk5plYuIUloDm1zDZAlNC73mwL42YhthZp4VCT8F3NbtAHIyu/EIpB0D8sSXuD87PTudczMbZGx+F8WuEotYqLMDEPuNMtotk3naQKystErp6r5NhntwkX+6aEGOQ0s/AglxeqkUOSR6Zatk7KhuIV4BZPKouDd71N3xd+nJxYxXt/Gtu1yZ2Y0gjD47X75TTTXT8/R5KKUzzIrx3zBm0KJ2FerdNwOCoG81JgX6rjoD13g6b8mux+T8oqCX2KrvKGQVGH3GYNwM3MRy/6ePNuyj7fijeChsbzSiJtnleoVTDyBOYwQGUwy6U5cAVyMdFhaR14UCHKzyxR4q7AYHEQZ4185gLOhMd30KvZl+mzuf/W20dmP13IVb5e8jAjc8Adt3i2Ht6lTUbUsKcRPYCQ5vrUOAiVb4jz01nuQxAGYseJ1jm70EHOErzWL/rYobC8OwiH+zaGklmjnfDc2CTZcMzioRpp2z7OAXMOIu98IZ3m0p7CVfLUYF7qjc0BEWVhGSN/tZjZFSAG2IAMSCMvg4NY+vkxiT0lH1F84Rk5HhjPqUJX0MwOzGe2VeVby/RtH0KrP/CZWAWzDP7xQnhT1Uy7+CQbA53CgJWe0SOnIoWHlv0+Yk1KkEHl5nW030=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(336012)(70206006)(426003)(54906003)(47076005)(2616005)(70586007)(16526019)(26005)(478600001)(1076003)(186003)(2906002)(36756003)(5660300002)(316002)(356005)(81166007)(41300700001)(4326008)(82740400003)(40460700003)(6916009)(82310400005)(40480700001)(8676002)(8936002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:55:22.1144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aebd1e9-c9b6-4131-8d1a-08db3d00a76f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924
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
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

DCN31 supports FAMS, but this was not correctly set to the hardware
setup sequence. This commit fixes this issue by setting the MCLK switch
capability based on the feature capability retrieved from the DMUB.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 890268d95495..55494730e500 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -295,6 +295,7 @@ void dcn31_init_hw(struct dc *dc)
 	// Get DMCUB capabilities
 	dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv);
 	dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
+	dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch;
 }
 
 void dcn31_dsc_pg_control(
-- 
2.34.1

