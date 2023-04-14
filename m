Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68269C77B73
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6B5D10EDE5;
	Fri, 14 Apr 2023 15:54:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 513E110EDE3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esrX3QETSkCa4OsmjozAswOrKyKRHInzGq/qJhh9T33GLWvunYwAVRZ/VCQjARmCQXDMsTZsE2QSYzEND+q5iuncMdFfoXDQsDsHw5t4d7Qc7LjRcSjjK5mNvIqNRTv9H5f4eOm8NEDXAhmwdngUwRuhKx4DQM1xy1zzuZQOsefPy5UFGAn7s8eDmdhZoK00DWkiA6lOn2q0ZuaDVqO0WgCHe9Zq0BDrhuVKZHhcDqfDQzfydgPXBBcMiYHQzAuvbOBnbgilsOcn6Msmd9E6RYjFZBSAvVgrNKGBOBL58YCzobSdAl5jjRAGfYL7uxy+O9QnS4OyYybOK47OSTehyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqKl7JbXMSdOi2aTYaFvWncGg56Z8nPf3CuKLgyNmM4=;
 b=m4VEIFwnsWk5LrIuFXk2oylstll3AwlD+S2MMAg7fHSFd6h1v8k4lxdQueKfEShMbiARJghftENhMxaUaYqtrJKRDcZ27cRPlYA471MYOxStYCqy868LoAAKGHolq/FMEkbIB/Zj+WxG02YZgSirfBE4siySOs+dE3m06/vFAn5DKExSPW83CEgyFNxdmHMdaB2fTEf7a3IMydM5rm9DCRaX+K03m+8umI5o05I4vrEB73H2rBL9y3jtTFtkr9gPGDlEHA358O9cJVRhwzgFvYL20c1qg7M2TqxQ+iUZfpIzyRLvxPoHMF4LDs2T09UztsfaLRSVrFjSRktQIcgbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqKl7JbXMSdOi2aTYaFvWncGg56Z8nPf3CuKLgyNmM4=;
 b=gGwhA2bS6aaWOAOFWLMFS/I2JqY0Q0zUmrICWQvQEtJsdEmbXVmsX69rQNQxA0Ap8qVcX25TvlrqA6CXlIt30ajmigLY6ROxRr4diDnB1L0AoE7YKiuAUYP2HN9r1VJVh4+oo5m1R9VY4aqTRRM/4nLbTJmISFau1s5tA73gRZo=
Received: from BN9PR03CA0183.namprd03.prod.outlook.com (2603:10b6:408:f9::8)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Fri, 14 Apr
 2023 15:54:48 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::89) by BN9PR03CA0183.outlook.office365.com
 (2603:10b6:408:f9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:54:47 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:46 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 40/66] drm/amd/display: Write TEST_EDID_CHECKSUM_WRITE for
 EDID tests
Date: Fri, 14 Apr 2023 11:53:04 -0400
Message-ID: <20230414155330.5215-41-Qingqing.Zhuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a42c82-ff0d-4349-dbf9-08db3d00931a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CYaEbxQiDWapgr2Ox81UOfD9Eo5jE+gsZ9/QsCKA5dLaG3s+ow6KX61cM27X3h8k+poHoYM1qJXOIr0/W1d+m8tlx8XywprDAxwaeIUAH8pIHvSLuWnTvu5Bhj7OQk7+WhgPSlV+oBd2b+o0tgHVQrWIu/KT2An8IKXgI8voOWKtYg80Z4kzYp5GnqbmT4Jp8OF9guOnKMHf6/0fwf+oqBgl+VALL2Q6PtfggYNj9wqRaJV6GaGRGSJOfJ/yhEgZK/w0wnZy0Byo4yCw6b/4fwIej/uYoJ8LNcO9MBtdJbo4M97ZJtV9hjM4sfzzU7mrqT8HBR9AWkIBCjYKzu8gSE9DorlbriP7heM1TRKsO47izyyw3fo6Z086n6vgHIxcP4qRpAY8kCLHpGKdZ2e38TfG4BZjjZvz0Zfasmqq8lB/5s7VnIQEdfZePrLHA/utpksX4/kbw8JNvupIZk3p/aPU5ZVhnhFRdiUIzk9FG5UCZFKo7LoOKtLm7fNnLD4B3WTYcqdnL0L/hKhkpfV+LeNFCBZRrZqaPJO2w0gXHXF+tn1SdKIxXCmoUVHebEaELZh9w1SMZlYtoR3roDgtPDns+qgfZXtDLJzlUMuvHRYiM1W1RG7RhcKGVdXNusRXn0WmpAi4z16uxG6skRDDuoW+gD5Li2+9bZWcw1rBaxgKzelltWoBDBp5DCigtwqSInowU4vffY66E2FDfoL2XViWixukhhmT7PWtYUp2a/4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(1076003)(82740400003)(356005)(26005)(81166007)(83380400001)(47076005)(336012)(2616005)(16526019)(186003)(36860700001)(426003)(316002)(8936002)(41300700001)(82310400005)(40460700003)(4326008)(6916009)(86362001)(36756003)(6666004)(8676002)(5660300002)(40480700001)(2906002)(54906003)(478600001)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:47.9893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a42c82-ff0d-4349-dbf9-08db3d00931a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564
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
 wayne.lin@amd.com, Mikita Lipski <mikita.lipski@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

Extract edid's checksum and send it back for verification if EDID_TEST
is requested.

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index c6ce2b7123b7..09e056a64708 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -885,10 +885,34 @@ enum dc_edid_status dm_helpers_read_local_edid(
 		DRM_ERROR("EDID err: %d, on connector: %s",
 				edid_status,
 				aconnector->base.name);
+	if (link->aux_mode) {
+		union test_request test_request = {0};
+		union test_response test_response = {0};
 
-	/* DP Compliance Test 4.2.2.3 */
-	if (link->aux_mode)
-		drm_dp_send_real_edid_checksum(&aconnector->dm_dp_aux.aux, sink->dc_edid.raw_edid[sink->dc_edid.length-1]);
+		dm_helpers_dp_read_dpcd(ctx,
+					link,
+					DP_TEST_REQUEST,
+					&test_request.raw,
+					sizeof(union test_request));
+
+		if (!test_request.bits.EDID_READ)
+			return edid_status;
+
+		test_response.bits.EDID_CHECKSUM_WRITE = 1;
+
+		dm_helpers_dp_write_dpcd(ctx,
+					link,
+					DP_TEST_EDID_CHECKSUM,
+					&sink->dc_edid.raw_edid[sink->dc_edid.length-1],
+					1);
+
+		dm_helpers_dp_write_dpcd(ctx,
+					link,
+					DP_TEST_RESPONSE,
+					&test_response.raw,
+					sizeof(test_response));
+
+	}
 
 	return edid_status;
 }
-- 
2.34.1

