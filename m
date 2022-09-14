Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA8FECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 812D010E81E;
	Wed, 14 Sep 2022 03:57:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C58010E81E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ay2T95FBAvu4NrRcZVjz34l9ch4e+Vt1GwMUmHJeiQD3gCucDypn9L8O0Xzsi29py4RcZulK+VsXSdKmNLu7CwyVGbA4F/JyQeoFX2unhinff5GKIJzaAOUCPyJ1Dwwcpi3KFgZatNcjNcL46e2qfIqAmrLwjfY0G6cvsGhss1nNTyzdcP1hoLxxPUGnxFu1J5V103DMs10FQmiq6BJUj0jBsTdSLkHIfnX25MwZXpo1czVrNuARgvwMrJdIKHqdvY3awVy+edSQW2qeYKeIhAbf3CEnwEjjmWPrif8OnnkxMbLou/N9d9JrVFJdXRbAOVitlfiAAmlz7NdbScrE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leWVn4US5H5/PRSYb0pja9bAqyM+cJR2Q5GX8S9Zf9g=;
 b=gAEvM1N420IHR6O5PDpi5qoehMp5Mi+DxpgbnNirrpHWaaWf1srBKOTLibw4graTKDHW3kB5f3tZKKZnhf86bEQX46gHn+MwwSvr3Q28uAbFIpPxVzkQp0hV4k6//0ql2pI+E6zeCqVu9j4IWnS0bixv5OzaVlls5FpguRCjNqPB2Ax0KdQKQtjIRdBjl5C4WkD0hQu+RN83X7aGmmuYyXfZRrGp0OT+ldcm9LZS+2DjEohcpewfZ+0RJNe7cCWn0UiaEWLiPD7Vroxx5anCYy9v0B/qRH0egV0M7rg8s03r2ll7MlmzO96WKt8k2G4eZtH9DPAgPkLbfC5ihM1eWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leWVn4US5H5/PRSYb0pja9bAqyM+cJR2Q5GX8S9Zf9g=;
 b=BcQtOopSmTgQ0P8Tn7Yvn2QYlC69uZRB/3Z0gRsNTkIOJ1B8p1ylBLQ2OsB6d/+eOImZ2UyQJeKDeMXsjBLDE7q1K3kY5NsEtwnHlC7hJAauq1PRvGxtQM4f0piBDCtRfnpFPdHubny8172lgKL3Ro1gL/PgUu8Uw81Zx1F+BeY=
Received: from BN9PR03CA0878.namprd03.prod.outlook.com (2603:10b6:408:13c::13)
 by CO6PR12MB5442.namprd12.prod.outlook.com (2603:10b6:5:35b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 14 Sep
 2022 03:57:01 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::75) by BN9PR03CA0878.outlook.office365.com
 (2603:10b6:408:13c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Wed, 14 Sep 2022 03:57:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:57:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:57:00 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:56:56 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 41/47] drm/amd/display: log vertical interrupt 1 for debug
Date: Wed, 14 Sep 2022 11:48:02 +0800
Message-ID: <20220914034808.1093521-42-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT011:EE_|CO6PR12MB5442:EE_
X-MS-Office365-Filtering-Correlation-Id: d78947d9-a4c3-4d6b-8918-08da96052d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rsKa4jcG/2I2N1/vDiwlsWViiAkZ64UIX6CW1OPmswclhM4VHmuOTbJ5SwxJWJOcAP/DmVeW5DLBaR5O0KX4RlKIee4XJLk9rc8HchDDRuVkH4rInqGKrlrEF+NoGl/oQML7ar22BXliJB7g7uwy1U/ChdBdP0CI0CJM5fJ6aojfKihTgvF9+N4RbsEJnh5V4S3SpWCE9c/j4NdCQGTxmmsY4o7PKQ5jzJIjm7+4rnDqwveYeI0CXXaGjdZtxaM5POP+eEGQSwcGQ8oLl834YEIqkHF3O+0jMTFbm88TmTTRwsbgWuDnPF2wE7BmzgLs/IAdLtJO3HXwD5YnAP9jrL594YTCwUET13ambJNyl63sMTgLXG0Xqvix10+HBynD7ZoAxaUpheH4YqeVPKX+ZXL9nVoq79VYiTzprYzwT4lcw886RxezKfXfXYLnOdAUndSADSkpQ9BOBQCj7ue8ZXUDIejirlG+nIkWhqvrQZiMFnB8LAMQ1moaRvAJ4XfzhOqPOm4hH/pM17OzarRSwk+JUCx6aezMSeIOw9FHaqOiibc6GKFECXPb7zVwqo7ih8BWRBGC3SmvDi4gREpMKWv1tewbHU/iQnaz+qQKIXUWu5Rxjx3JtsSZObQQ8jW5Pl9iR8FowQX1O52st8mkVeUOpXZ+x5qDJPzA35IQpBI1OeZ/cgDw0fsy1ePAkUh5BUbupDJQ/G3u8ezPdK/uEHxJaGaxb7GnW3EdHIMDTHrctmF+wZfQMptQOBaJq3tsdwk8hfKNFWOycS3XW7zA9NYNl/DKNaafoppCeml3LOBHyFMYyh/6pYUuKAtMVBwT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(81166007)(41300700001)(86362001)(478600001)(336012)(426003)(6666004)(36860700001)(8936002)(316002)(70586007)(70206006)(40480700001)(4326008)(6916009)(82310400005)(82740400003)(40460700003)(8676002)(2906002)(7696005)(54906003)(2616005)(5660300002)(47076005)(36756003)(1076003)(186003)(26005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:57:00.9433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d78947d9-a4c3-4d6b-8918-08da96052d94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5442
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
Cc: stylon.wang@amd.com, Josip Pavic <Josip.Pavic@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Aric Cyr <Aric.Cyr@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why & How]
Extend existing OTG state collection function to include the vertical
interrupt 1 state.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 294827906c69..ea7739255119 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -1393,6 +1393,12 @@ void optc1_read_otg_state(struct optc *optc1,
 	REG_GET(OPTC_INPUT_GLOBAL_CONTROL,
 			OPTC_UNDERFLOW_OCCURRED_STATUS, &s->underflow_occurred_status);
 
+	REG_GET(OTG_VERTICAL_INTERRUPT1_CONTROL,
+			OTG_VERTICAL_INTERRUPT1_INT_ENABLE, &s->vertical_interrupt1_en);
+
+	REG_GET(OTG_VERTICAL_INTERRUPT1_POSITION,
+				OTG_VERTICAL_INTERRUPT1_LINE_START, &s->vertical_interrupt1_line);
+
 	REG_GET(OTG_VERTICAL_INTERRUPT2_CONTROL,
 			OTG_VERTICAL_INTERRUPT2_INT_ENABLE, &s->vertical_interrupt2_en);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
index 3fe5882ed018..6323ca6dc3b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
@@ -583,6 +583,8 @@ struct dcn_otg_state {
 	uint32_t underflow_occurred_status;
 	uint32_t otg_enabled;
 	uint32_t blank_enabled;
+	uint32_t vertical_interrupt1_en;
+	uint32_t vertical_interrupt1_line;
 	uint32_t vertical_interrupt2_en;
 	uint32_t vertical_interrupt2_line;
 };
-- 
2.37.3

