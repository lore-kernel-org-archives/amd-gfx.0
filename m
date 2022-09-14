Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FF7ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A295210E7F8;
	Wed, 14 Sep 2022 03:33:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB6D810E7F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7xnCWljUcU2RVf7oS75/p/5IDQIL1Onai0+fdASLTvWiHpUe+/sfnVaFusRy224LeeDi1sWGf6BGozoBp21USfjlkZjaNdfZkXozQXygrjVz3YsHdnqDTOwZha/2cth89p4GP+pDFBmH854tBHKPcFqiBUo5HmD7CErAU26mNdKyf1Nxvdk28u5lVn17eH/NT+DrVDhEYUy6V+ojmP+OiFlNSMOoqO6Kk8N8Ip1cxctj7002MbXDTiGoloNVhBZqbKbsD8nohdDmXC5ZvsmFkG7hOujMBG+cqPPBXF0ECSBbN9aoKzf2qD5Z/gsHGuVVUFumhX3KjWOSL0wJ240tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcHs1Y/YywvrNge4YAmsX4w+nyGXzTS5JJRKeExEzpE=;
 b=RW/8xNtlztaJ1sjltljiETNv5dsoWWeT8u2YFuM6/yiG+MipDmKaMQsnlaM9aIylwgI3X/e9yEVlvaB+Wh6S6D1SuqatOt3oxjNEU8kw1p7X2iqyrmYIozspZm6HoNhQXcM3rgyKNkeJl+X+MNHQTcoWsIMWLDimwVLRYlZ/ADjX2lnqeh1mRi0NVU2KfRP9ws47Ti/9JS2jYvuM1G49Iuxg6djMT7Du/0V8PvqAhaioxNOKUkeHPhl4ViT/wCXKfN+cLsyh2Lc8i14ECaRznNTRV3Y+6eyZOvEpx0HAIQ4EEhJnPbmJX47n8qR1A9TfPFu77ra+bExaWYTvTSSJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcHs1Y/YywvrNge4YAmsX4w+nyGXzTS5JJRKeExEzpE=;
 b=bwlSyogSAQJeMch/WmgRHY9YaT2nfOkjPd9Sq46RYCEM98dtxmqKwCP0HcyHgrElXJ7QYjQ1s02sypZwjWrCu2UAsUD5+F+kVq222aNe+shFM135TarRYn7E6alJO4QlasLiZnhPBjAVQMT4lwtmtyKxNlBZDpB1moOw37EURgo=
Received: from DM5PR07CA0059.namprd07.prod.outlook.com (2603:10b6:4:ad::24) by
 BY5PR12MB4129.namprd12.prod.outlook.com (2603:10b6:a03:213::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.20; Wed, 14 Sep 2022 03:33:37 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::8b) by DM5PR07CA0059.outlook.office365.com
 (2603:10b6:4:ad::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 03:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:33:37 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:33:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:33:23 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:33:19 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/47] drm/amd/display: correct hostvm flag
Date: Wed, 14 Sep 2022 11:24:18 +0800
Message-ID: <20220914032441.1075031-25-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|BY5PR12MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: db6ffe72-1a3d-4ab2-a61d-08da9601e910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gogMdx9cIgUEw9OEWGvOAN4k30BI+SSuJ7FMOc3EVHKNalcsGjKyBMP+qH5PDFbOHmU5lG+g+1xjiHiSsgLQLNB5X/IOgT4CbRnQ+H0En4y4k3M3A7XaipOr/PfX89Ih72SPL2LgHYNKugOags6qtJJr5/p5IaB+TuYZ+8jnH9MzCrx1fJZBlMmbw/HBQNqD7Mg3xBwpLeTOhKxrB1fjz3xWeOeIuxnQoH7zl+t+yf22eiJXO0IRbog2dy+73qxL8EkcZlP1BNul4HX3HjWYssmKtuMnM9P/dQSqsG1cSYtD0pR9a7NG0rmAAjNOK7BKrG+V9vYDNMRqolwjoae0SahKjMQO2+FXa44Z5VrTk+aUDBP/9CEL40sQC6Rq1q3IcrLCP0byFhwJ8Afc9K6MN/HQWhvRxDxodcimeX4XjJtGyA7s5fgLXamv7hvMPmxlAWO3E1u8Ig5oOmRrbJjEuQEkn9LHdAXiXbKVVNkq8xtt4nrpayfTKwZkW1lXPNcBmLPPQjT5AmbTvE+B8CNa5vDN35MZbAgoAdtuO0JpflBqjNU5gBm1eWD/1VG/AfjEoL5nwqW53dL7qFUZERbPXUxvoqWqZzvs/wCqhp3L2unTIoHiq2jSQqeaa3mA+weU8MUhPOywxY0e9xmdR5XPH/4nFaiB1Zs4qSDU8FT8YRagj2wsmjSP4TLwG6o5vv2SLKCfVgugn0wY2cLASVdazMafcSzm8HU2utlLZWIdDFYcUfDECCNOmQUVFNTOjChYr1SfwgQnb3XlCiZnzjKzMmM6hKwrqQ8Cnawj5uOAc7nbS3dOx+vvdBtAIkuszK26
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(316002)(6916009)(36860700001)(5660300002)(82310400005)(40460700003)(70586007)(336012)(186003)(40480700001)(47076005)(54906003)(2906002)(41300700001)(426003)(36756003)(82740400003)(478600001)(86362001)(356005)(83380400001)(1076003)(70206006)(8676002)(4326008)(81166007)(26005)(7696005)(2616005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:33:37.4568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db6ffe72-1a3d-4ab2-a61d-08da9601e910
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4129
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
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Sherry Wang <Yao.Wang1@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sherry Wang <Yao.Wang1@amd.com>

[Why]
Hostvm should be enabled/disabled accordding to
the status of riommu_active, but hostvm always
be disabled on DCN31 which causes underflow

[How]
Set correct hostvm flag on DCN31

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Sherry Wang <Yao.Wang1@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 8745132d6374..8c1a6fb36306 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -890,7 +890,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = true,
 	.optimize_edp_link_rate = true,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
-	.dml_hostvm_override = DML_HOSTVM_OVERRIDE_FALSE,
+	.dml_hostvm_override = DML_HOSTVM_NO_OVERRIDE,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-- 
2.37.3

