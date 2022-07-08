Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3716C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 16:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B09B10E1F1;
	Fri,  8 Jul 2022 16:36:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4A3110E27D
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 16:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQfMyhfSeZ08Q4qL7Mbcc3B1rd4+vDP0+cPzKEH5NxyT0LPn6nryXCYY65QJOubrKotEEEY/khgFDvXKjR1nW7cCpi3IHBizZATafCg/EbG0wetAeN36JH7WkqnC6xwpLUgMrprS3gedzSKYK+XSdLQ7fJhewFSa+eTnvRf0LQDuY607cfdcMTFNKk3wLf0Wo9Fva02YdzdO44iVipqjZif3UIlH9ZIUyaj5tv0FiYojP0c+FFJ154WDcI4Ntl2dCEIKG4jhQHkKxSbRZHO1nRvZzyhzYterkcYcmd9Da9mEcibZ+6mOavMwNWFY9gDUXTlz44UH+IJGk6ePgoISAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8TFy92i2WDyy2hkxTBx8Yao80JC/iYCTCwwdbJCtVw=;
 b=FvDF8beZg/ggK4BCN7PCGOt4bk31akbKLLvpf+rQW/RPJCk+NTpAIBNN+QbCzmABe0gd7RhVWuqT/3sZ6z71g4jKksj5qd66RjRHOsSY9k23Ykhi8C59kSLBLeTusdx0N9CCwkIJJRw3NEs/IIykmL9hQlYuG93L/zi+GFNakI/lTViRITj0JR7ZDnC+IazhJneVwJJGMA+oB5dseAISWhSZrV0czz7hZmkN3k7ZVCRTvyBzRbAsOrCeU7qUNAjD/9rPzEmJ5gyvMdoHEKgcT4kcix5iyFOpVSKLTr+cUCqcQcjsjq7bdP2lGXHQ9dw99wgUaQzi6tWg4WRbdjcf1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8TFy92i2WDyy2hkxTBx8Yao80JC/iYCTCwwdbJCtVw=;
 b=FSikzXM+LWTZXFoO0gFG1V8eNZp1nNNsx4TB8TginzpMH5xnwOl1XFblUCcnV6XyJriGertaogBBrNtGpkAngPzZ9TAnm86r7RnJhbfecf4jVn6MjJpWj9PpaCGFVoqcTSQLzpf5KzB4afKVZhr0zFcImSgaUoDg2natlQvUztk=
Received: from BN9P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::11)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 16:36:51 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::a9) by BN9P221CA0023.outlook.office365.com
 (2603:10b6:408:10a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Fri, 8 Jul 2022 16:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 16:36:50 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 11:36:45 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/21] drm/amd/display: Reduce SCDC Status Flags Definition
Date: Sat, 9 Jul 2022 00:35:18 +0800
Message-ID: <20220708163529.3534276-11-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708163529.3534276-1-solomon.chiu@amd.com>
References: <20220708163529.3534276-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8408207-83b7-4566-1def-08da61000ed9
X-MS-TrafficTypeDiagnostic: DM4PR12MB6277:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vxDvlCsiVgkn8xGEFpeeGxIxmjzrcO4DCIXJUWXKg15xSwlEWDV+4DZIRUJUiepL3MP9LKn+4zylOLieewWeraUWesetrPSs2FgwotPadW6LGz69nZCZiKDbZohpRmC4aX5VwCUJj0nNroXbjmvM9Z3LuTH0cbnIXVQx4Nbfo/VosI0ducQzN5A4Na1MK3iP7OiVb6QloYAhu/yV1PWsNxJ6c2c/hntkOIQ1n0d3t+j6/oarIJwO/9cLhVQ110PdKKucMGRXMALhlb1m9v8WIEXRiNFOntL0kJQGGxT13h+hjn0aSUQDWqNRPj9So3m6F8j315HX171a0We7wH8WakIikUbx/KuQX/b+oJs4UixkZBOsV1A22PgGhNmRBo3jrd/ZQDxo3nMumznXLGGhjbCwrQMoGEjOlRRzbZMmwIbFmhqf/PW08P7S0bCYLYXevXTvPJMwr1RMHRXZzoh95lMkfxIn1Kkunqf6AhqnZ6w2jU+k21QUWkPZA/fmK6AAA+TkYW4t0ur3Vv7xqD7ln+pWlIciV7CaNJ3htH7T7zBd70ZGmu8p2j5j9MvgzAtMF5NjxrOR2EXmOeJUSd8Khe7DZUCnqXB8jGaZazvwMurReEDxjWpKQ50XFdpxb5hf/H4k9XYtGzCm1SwWQbxnuuk69rDtwwcsjQuYrFFG+MWXnXTWuwMArQuBa3V/usCRpmFXHi+Ci/sLNbnAtILmhCB87P3l6uZaLi/T2FVZ//asGqgJB7vXUGC2QrdFKsaWyxwDMKwfDL5HbM3s98BgLmp8rJ8lXayUdmPXlil/B9zUtI/qp5gtFuMqvQev9BT3HOK7pRdR3S+Yvlz4CXFJNTFkX9uu3fzspnTQ+B+xCXign3zVBRmD7//0+0MKoLVJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(36840700001)(40470700004)(82740400003)(34020700004)(40480700001)(81166007)(83380400001)(186003)(54906003)(4326008)(16526019)(426003)(336012)(47076005)(8676002)(6916009)(316002)(36860700001)(70586007)(70206006)(356005)(36756003)(41300700001)(8936002)(26005)(86362001)(478600001)(5660300002)(2906002)(6666004)(2616005)(1076003)(7696005)(40460700003)(44832011)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 16:36:50.2569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8408207-83b7-4566-1def-08da61000ed9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Chris Park <chris.park@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <chris.park@amd.com>

[Why]
Status flags definition is reduced to read
less bytes in SCDC transaction for status update.

[How]
Reduce definition of reserved bytes from 3 to 1
for status update.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index b13a516ba0f2..d01d2eeed813 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -93,16 +93,13 @@ union hdmi_scdc_update_read_data {
 };
 
 union hdmi_scdc_status_flags_data {
-	uint8_t byte[2];
+	uint8_t byte;
 	struct {
 		uint8_t CLOCK_DETECTED:1;
 		uint8_t CH0_LOCKED:1;
 		uint8_t CH1_LOCKED:1;
 		uint8_t CH2_LOCKED:1;
 		uint8_t RESERVED:4;
-		uint8_t RESERVED2:8;
-		uint8_t RESERVED3:8;
-
 	} fields;
 };
 
@@ -770,7 +767,7 @@ void dal_ddc_service_read_scdc_data(struct ddc_service *ddc_service)
 				sizeof(scramble_status));
 		offset = HDMI_SCDC_STATUS_FLAGS;
 		dal_ddc_service_query_ddc_data(ddc_service, slave_address,
-				&offset, sizeof(offset), status_data.byte,
+				&offset, sizeof(offset), &status_data.byte,
 				sizeof(status_data.byte));
 	}
 }
-- 
2.25.1

