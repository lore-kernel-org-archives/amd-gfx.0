Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C38C05027
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 332E410E2A6;
	Sun, 12 Feb 2023 17:00:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A8B810E1E3
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzYYQcCoH9WLbAjxRIDdaaKlz8DrKQ2c4h0gFpc9R9F2RG/gPdPnLSG0DYNo+Lf0l3/SgRJPBJE8lkEnwRLrPxuP5SwF3hmyJmT947blmvt4wSXLmXR7KSw/DGq6pbk6L54/oNJfB7gM4ieBziEShowW9+n0DIYgL+DvNgz0pJFltwVn5CmkFG6bWPZUmhavWKhOqVwxnbfs6b1wHjOB56LzXmg4GgYh4Fwds5JuCSJIJgj+BRFxFvBIBvx8zuuTOF7W5IKkDaFjNCFkDs2qx+VUZC/rjeD8fql+1CT85UnNo5t3b1qllXPTWfZlvnVLBUWgOWISFjjRYcQqRZX9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sCFfAz0dbp9QDoqQKztI5hbkPS57MKgbgZUh6jo/Mw=;
 b=Bk0xGNlx0ug5dVbCVBQthcXfFIP6Jc8Qt7B74xzKGuUxaOrO1BsyDrq3dRDJw/oi/a5ESseMBaVTwDabSc3WqIH1ppNP7q5yVfbQetCtk7/fIg2owKLBDnLRbeei0WHFpilOngB2QwtxIIrzk8QvWiLzGUagxOhW+BCr+uMAx0ahA5EFxtuCx5jdMJOkTDfirr3hchywsKx3aYZwMO4sI0XUqrRvAQ5lTzoV1czm0bJkzuXBks0nJ84fRvDcODnq/S11UR4FV98G8naPWTLQANvq0CyxFjCEQTtTUOzSO9T3tbeIsMx2LydGBHiLEd/0mqF8ThZyaSXwKzGol1RAHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sCFfAz0dbp9QDoqQKztI5hbkPS57MKgbgZUh6jo/Mw=;
 b=aeNOTP9P7oucjGPY6fMNaT74v5J3YA/4PldPkhDq5zssEELPePbArvYVvH/rO4FbLwdXzar/RXeDN8y1oUNy+83G1X5G2Pp8CJL5nFbgASiOTBy8JuN1WsRW7zQtrD8MHWymvwxUUl9jcak0aiCoX07ZeJEWIUUeouJSnuuzvlQ=
Received: from DS7P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::24) by
 PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.22; Sun, 12 Feb 2023 17:00:36 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::75) by DS7P222CA0007.outlook.office365.com
 (2603:10b6:8:2e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:35 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:34 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/22] drm/amd/display: Enable P-state validation checks for
 DCN314
Date: Sun, 12 Feb 2023 11:59:37 -0500
Message-ID: <20230212165955.1993601-5-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT057:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b596832-6d3d-4c8e-810b-08db0d1aa90e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpoPZinujYurlC6kqBdWoAPYM8HHOLKBlTvMlJznmAgW2FfDLbwOYdwYb22hBL1hOBHvTnGL1b8Kw6ezl0ZzvtvKjQ9UtNcYMZHA94smA0rPWeG6+KAakNERHFF2lTDVTu4I2G8kklfE13jzdTXWRxpKvRByXVZJuMYASI32KSPDqTErmxBSBn+2wEZ1SqLnKoDhghM6B4GKTtWjqKQ+rhkKnqbasuHFDSOv76bEH3TlfEePZsalHZ1Zm1zUKRAS1oHM6QPAymw8WN7g+vFK7hC0qF0hBSg9eGbzXJQx5XR7uzBXi3ppfQ1ljKuuN2PpcZ6vsgihMglGqgtyWrYMTt5MaSGy0vBt2Pg2P4b4GzjetMLWZZEC4GuD+T9C/C47+nC1xn6B5PydldfskOyql7aQHVQN1VWWulkZdh3zykhMq+FkFZriETtmGn/erHrrsr+gcJlt8pUF46Lao3LX0aNufyg2fhQMOHLzYcljk6At/woOtzJPug7r8yD4gZznvMYW8cKmUp90Y4ItBpJR4NcpKoHiWkAVA5bzUcKWBgTt4Hjviitd6VVHD7LDCW+GcUVjVxA0LQuqGJ/TS+J1XSjmoOE4Z338vGEyaqvLHDQlBbdpnp9SfcQjq+cLvVvFvlKVnOJxtGWX0u33J8J107uBsnecGssaWer401JP11b8N7l0oAYzfFcgg58IP5d2IYdZbIv+XI9JhEayzX3RCstTS8TRmCB34MQA9aHWzmc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(40470700004)(36840700001)(46966006)(86362001)(186003)(16526019)(81166007)(1076003)(26005)(36756003)(82740400003)(356005)(336012)(478600001)(82310400005)(2616005)(2906002)(5660300002)(40480700001)(40460700003)(70206006)(70586007)(54906003)(426003)(44832011)(36860700001)(47076005)(8936002)(83380400001)(4326008)(8676002)(6916009)(316002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:35.8886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b596832-6d3d-4c8e-810b-08db0d1aa90e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819
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
Cc: stylon.wang@amd.com, Hansen Dsouza <hansen.dsouza@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
To align with DCN31 behavior. This helps avoid p-state hangs in
the case where underflow does occur.

[How]
Flip the bit to true.

Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 79850a68f62a..bc7f2b735327 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -901,7 +901,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.max_downscale_src_width = 4096,/*upto true 4k*/
 	.disable_pplib_wm_range = false,
 	.scl_reset_length10 = true,
-	.sanity_checks = false,
+	.sanity_checks = true,
 	.underflow_assert_delay_us = 0xFFFFFFFF,
 	.dwb_fi_phase = -1, // -1 = disable,
 	.dmub_command_table = true,
-- 
2.25.1

