Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E495C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A817D10F122;
	Fri,  8 Apr 2022 17:27:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4803810F123
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:27:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtR6u2/OXLD+6Q0R+dOBm8BweCRj42Pov8JGXZFMeaL+P7E5MnEMfss9rqi4ZfMW/bAfIqYLpUJTbmXYoFX+A9KscmWJt2R3Pw/T4yJY41eOJYbt/cXTOyDRN3SwZt3wtCyN7CKeVR7HuU6ZN0SaWncpNuKJv/OW2UMJvr9Q6+2i9XLVCuBGc0kt36jyPo7edcN/i6kQ3E26OhvZ5tTlLRF9dcKOuP2q1dQmjNi7VTtBa4e3iyO+posgKEmXHsQ0a+xFMroMl/UZeXK7jpRElO3+JmC1wvnmvd884NHmPZvHDDJTZ3tsJuW0NNP8EKY7e0MrIQUN8VG1xGd5NRisvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBX3K0wQu32JI3R+gRwRB0Yb1NSF1RfN5VOBxQG28Ic=;
 b=SWBbjLB2KZDx9ylUXpMBrbYibc6UEsUZbv2Wcst9W45GSzKUNXDBZDePULat+CUeyqr2s+w9hG+OszfJ/VwD1W5pHfsrsW3O9e79by1RmkqyBH9f9M/+lkL5FGq2vyXKoEtDsMfO2MIQ9DtJtj0fpF2IcLKNxkBUQN6RE4xWccupB3UcVWlYUtzVq9G744mGy/RrJGKPaH4+xDvlgFJIjhfK2IWpFThqK0EbjwaVHfGU94uAq2r5imHcP9LerCLchkbu0MdLhFK1JUgBjNTMnrXeYAOVTdkCWmfUnrAjbLAuSCsQYM2w/mxntYLHioZxSw4dZFhnMGx90MiBHYG4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBX3K0wQu32JI3R+gRwRB0Yb1NSF1RfN5VOBxQG28Ic=;
 b=EExBweBVXbdvz8qTJrfhsmBBH0jjG+Ya0cDP/1LulswxU81WRq/cRIqTBJ289rSE0XGSwm65KWP6KXmIycuf4xCOCifI7jjl4ZUZWCLsxRmO4YPdarJWubj8mpDkNaeBDIhGx/0SEBJhluFiZUeYBRaVT2cSwhitq/HliB2iJms=
Received: from DM6PR07CA0117.namprd07.prod.outlook.com (2603:10b6:5:330::32)
 by MWHPR12MB1421.namprd12.prod.outlook.com (2603:10b6:300:12::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 17:27:50 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::a1) by DM6PR07CA0117.outlook.office365.com
 (2603:10b6:5:330::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26 via Frontend
 Transport; Fri, 8 Apr 2022 17:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 17:27:50 +0000
Received: from lnxpromo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:27:44 -0500
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/20] drm/amd/display: Add dtb clock to dc_clocks
Date: Fri, 8 Apr 2022 13:19:06 -0400
Message-ID: <20220408171911.601615-16-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77be15f4-2f8d-49bd-3eec-08da19851b43
X-MS-TrafficTypeDiagnostic: MWHPR12MB1421:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1421F6640953F2CDEFD7D97AFCE99@MWHPR12MB1421.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rPe4f0AqFng4fNiow8XLOv8IdAKOAkm10P0sDYXYJqNL0fewzk7Sb1hf8UL4qv8ouV8i27CEoUrzO/sahCG8fJI4UNSnQI5AE88X05jd+Q0ErqKQU3eUAE5TScQA8QvmEGjNNtsXyUlCdDD1Hve8gJj7MEM+AkssO3O5UdlTv6k1xsI9l318c4MoWRgp7amHt1zvLDhWNB0G61y/9bmcA3T+Og9May3vqtbq96KlQHlp9wH4UzUWS1jWw2VfuiuVj8+4CK2WwOHFAjvFmf0qqc7nhbMtz5NOO4u/+1YiI3TeEHXD4S1bWj6YI82IWR15eftQEy21rI1YPZAXlotaWP+yvO+4rWd2Wm/1kMbfaI0Nq6MVjwS/6T/LwEbs/NzkVCIAcscMa5VtDSPB7NWKxhFWkFESDF7TT7Sn9GQ86HGbvMNw6cqLRa3xnHbv+RQ+fcACPZCKmwtCS0871vxzJUoglLjpIZ1xQu421QGZut0yaplzMIOlUJ4JM/8xo4cH00iHRZdjzHCO5qsDuZzhTestQ8aWlu+z+idA+AbvZlGaKb04NzpOcIjRj8nLgoni06fS7C2IPQoVe7e2VnFoqHBWt2eNIpRlHRMmoXHYrMzLnjenxXcQXsY3cqn7Evv+x3xT6QP2qcetPgFgeqtcw9VBGfbTujIkCvcIVzHwbXq6bG0/NzuFXTVAUzONTJh+uBNPGFwgDCOoX7Yeo7mkhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(8936002)(4744005)(1076003)(16526019)(426003)(6916009)(8676002)(54906003)(26005)(7696005)(186003)(6666004)(2616005)(86362001)(2906002)(82310400005)(336012)(508600001)(36860700001)(83380400001)(40460700003)(5660300002)(36756003)(47076005)(81166007)(356005)(70206006)(70586007)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:27:50.3989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77be15f4-2f8d-49bd-3eec-08da19851b43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1421
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Ariel Bernstein <Eric.Bernstein@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, Pavle
 Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

Reviewed-by: Ariel Bernstein <Eric.Bernstein@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 863d90bec61b..544d58260269 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -417,6 +417,7 @@ struct dc_clocks {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	enum dcn_zstate_support_state zstate_support;
 	bool dtbclk_en;
+	int dtbclk_khz;
 #endif
 	enum dcn_pwr_state pwr_state;
 	/*
-- 
2.32.0

