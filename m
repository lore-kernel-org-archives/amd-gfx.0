Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B17C001B0
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 19:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEC9110E77B;
	Thu, 13 Jul 2023 19:58:57 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7FC310E77B
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 19:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYpLdF4vj7oW0wTngpBQlpVr7Ry1s3Bv/GH/QptCk1D1+XTFGVsGOeDxLRtxOnZYcC1HBkjaEoomy7WVDh7VpgW2bce8syewhpcqyaULV2DviRVg7zpe6xKOGpc62/18cyEN3zbZWw47D/oM1deIiPsNenO7evUI9KcwAwq7t1Fpt+8hN+i88mSDCLUSxlL4E78xTyxpOu2NhM9fbZvGK7K2jwAdZ8fUUMd8wU6qE98oTbrwAsYbRLYww0C+EaHJWwK1br3Bw5VCcToa/X//gfRWWRnIuRdynivkBCkzYD6r0CXF83KaWH79Ui5vqIX+g5g/P8Mfv72fIcdhTFKhyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4x2yq/3TpDep/OvTWT3Ebquq8lTmIgU4c8/R1x8yv0=;
 b=j3EYlAHJBdcps3yja0u8gyvwDL5bspssiL06iiOQHw1VZQ5fEfmXxculfY6egUlocJVXVJPD3VOY8YDqZmqGriovjPAhPirqzbuFuz4EYRfydAcoX6K8l982Gbb6u4l4STKfIc5c//+SMpYvmHKM0wWXgvgKNQEkWjG7877rKP0iiVrX/wHts/ngaLPdFZLYztn8d82Cra7N6hKFjOegFsctM0lKEZyJ+o/Iukm59dyAIpH1/77CeEwlKLlQAF6qikRdG5x3VzmsQ6VVyaBaJfFxqXTwDJzafVr1zto+8mJDZj0ekJn5vxYKEYlpGZs/hZthguAt3phpAEDGOuB34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4x2yq/3TpDep/OvTWT3Ebquq8lTmIgU4c8/R1x8yv0=;
 b=yEL4KQGuduqA492O/EUf0a3Ebj3di0iQBFGgo1K1Lsp8U8tI9x3KiWq0ULItpreqIe6xkWLMrM5f/3JYcEaaUKa7G9GtKO75UTKhrblSiDDwtwL03Mun9WKUCxMxqc2KILjYkbwa8P5iueEJD97cG5a/IhPZFEgWW10+qTUjq5Y=
Received: from BN9P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::26)
 by SA1PR12MB8142.namprd12.prod.outlook.com (2603:10b6:806:334::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 19:58:53 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::3f) by BN9P220CA0021.outlook.office365.com
 (2603:10b6:408:13e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.25 via Frontend
 Transport; Thu, 13 Jul 2023 19:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.26 via Frontend Transport; Thu, 13 Jul 2023 19:58:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 14:58:52 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 13 Jul 2023 14:58:52 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/display: Use root connector's colorspace property
 for MST
Date: Thu, 13 Jul 2023 15:58:50 -0400
Message-ID: <20230713195850.165198-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|SA1PR12MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 882d4383-f9e8-4461-491d-08db83db9551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lyeTwcWT3d5rALz0sWXtbrnUtq/K563bSlijy2d6wgX1rpl/IE1yxXyO6ZcASv8bxdhwZXlix8u6TBRS/dN0feJJXtQ8TwLhcCnzrhXTL1LlmgRfa6hoxX1VSfQ1ilTRvpCwXonBLi8H83HJ5uxczSQsXzmx+V/DUCsoS1g0ldqofg+4tqYTMZbAm37H8E5fdR0pVku/RAl7m64f8fD8nuUqhUCJ61J2cz6HOhogMlAYatDN3n+d5bgYrEWnJGoUmf/TGKdDuDgj21w4FqzFJkTfjSX3WpHHgZ4HZdIiWxL2Jh29NrzCs+ROgGJFrSkWwQ6b3gvXlqFIA4cwF9wCF2y5qYCWraqnDrojTpv8cRoPyk72Hswabqx4KpgIZkJQcJlHUH0SeNhDtZYWy4GCdA6x7ggsMKUph7XtSQek7z5YsrPIcGosviJndlBLXQcCumueTx/4ItbjhQaODMT0WGOXmUyOt1V/CcOQLqs1SlZ+YQARQOIP8mfK/bxKdH+th283VcvKaCLg5lLMu0DmpCmg+r8F69BZ5aWq+H7ipn1hG/mKkrvo3ReY1sOaMR8wzi3JLr1lw4xn6knspp9GEj9vH704mnjpaT6v3/R1blSsL8oZgAuft+uoFVl0BWp7vvTOV+lYa3+jYznFhqarWcYxWQoEL5/3Q45rF59MK9wXVhJ2Ou4TjkdIJrvjZOaGV1zXvD9ZOyeobI85tKLEJRlaZOraA206+q+4pqCwqmlIXkirhuK6Fc57YjUnZZ71n4YRD3Ma6A4RHEbODd9LFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(478600001)(81166007)(356005)(82740400003)(86362001)(8676002)(36756003)(8936002)(2906002)(5660300002)(82310400005)(44832011)(4326008)(6916009)(70206006)(40480700001)(316002)(70586007)(41300700001)(1076003)(26005)(36860700001)(426003)(336012)(47076005)(83380400001)(2616005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 19:58:52.8953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 882d4383-f9e8-4461-491d-08db83db9551
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8142
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
Cc: Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After driver init we shouldn't create new properties. Doing so
will lead to a warning storm from __drm_mode_object_add.

We don't really need to create the property for MST connectors.
Re-using the mst_root connector's property is fine.

v2: Add curly braces to avoid possibly 'else' confusion

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 28f8ac6007fb..f6dab6226b29 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7357,8 +7357,14 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 			drm_connector_attach_colorspace_property(&aconnector->base);
 	} else if (connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
 		   connector_type == DRM_MODE_CONNECTOR_eDP) {
-		if (!drm_mode_create_dp_colorspace_property(&aconnector->base, supported_colorspaces))
-			drm_connector_attach_colorspace_property(&aconnector->base);
+		if (!aconnector->mst_root) {
+			if (!drm_mode_create_dp_colorspace_property(&aconnector->base, supported_colorspaces))
+				drm_connector_attach_colorspace_property(&aconnector->base);
+		} else { /* use root connector's property */
+			if (aconnector->mst_root->base.colorspace_property)
+				drm_connector_attach_colorspace_property(&aconnector->mst_root->base);
+		}
+
 	}
 
 	if (connector_type == DRM_MODE_CONNECTOR_HDMIA ||
-- 
2.41.0

