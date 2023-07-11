Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31ED6EB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 19:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3E4210E429;
	Tue, 11 Jul 2023 19:50:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD51110E429
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 19:50:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7X7DozdxXBLGf3DC4EryUUp5jRxPeGSwl+wc/EcjIMvyObGw5oukCBI6Bbekajj5RcEItLXkTBVwToseIYqa9kAmP+1heNRxae0y819WisTWD8htU+5y7621omLoRetDX/tah9VjKHOqwcaKtI6KDVCrQqlPjIoudmX7CtoWO3DZk79hcX6PcUriCrKyGfcqwxUE0ND0wUb/XSn1IuF9iQ6jiSi0EPTSWPtwXMpzvqg2Ez75y0zzqQpc3cC0tGrQmThKPJt1z5VJ0BZee2gUPniUKKUDoCu7JBxskxUjbQHWgg0EsV+zkiU6VXeEyDVQN61+f9VoKxKKVu8Cam/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NleQpeGZCyqzmd3gr56hxPxYdlALjuhdOoaNDUJKKxE=;
 b=iRaXlvxkSMzzgH/KqjqlGpfvaBRAvw/6h752u951cecBupzXOMxIipwgZUXJAK37Ed7EXDinHiXXdZ9JNBwiIP9MBOkOG8mKt9mgswpq2XGhHGVD9qWAjzaB7I0SfH4sO3YubsRWgB6fjWeqaL8DFQ9Oih8t9lxoT/f/dfly66pSs/cfZvpVdizZzLhfwJLxNMdLlPHJR0l0LmUFHXe/l//ghov5kImejP6YgYFYGLoqy+5+wQoasQAci2TDdNKMBa1RTtZgyA7wXgvxPyM+0oeBEUI3A7jahEbRhGgHu0JRJgLdJl0Xaw3f5vKr43mb0wYYKHLm1XEz079W0jFqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NleQpeGZCyqzmd3gr56hxPxYdlALjuhdOoaNDUJKKxE=;
 b=kvVXXsEWprQJ3SZ1l9Eu7/+MZ1R5D683xGnp+e5uFnKKnzvvc5WzHueNSBX7gcRl4AGOgDWOJ0v0Ew3PBP60b3Zo8e0rE43NCZIrHnPH1SJr7qIJX22C3txqYIoZ5bRpoZRJxVlR5E8/QwWGmwrC2ukw0XMnqwqaQhQEyozwN/k=
Received: from BN9PR03CA0462.namprd03.prod.outlook.com (2603:10b6:408:139::17)
 by LV8PR12MB9135.namprd12.prod.outlook.com (2603:10b6:408:18c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 19:50:26 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::7f) by BN9PR03CA0462.outlook.office365.com
 (2603:10b6:408:139::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Tue, 11 Jul 2023 19:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 19:50:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 14:50:26 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 11 Jul 2023 14:50:26 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Use root connector's colorspace property for
 MST
Date: Tue, 11 Jul 2023 15:50:21 -0400
Message-ID: <20230711195021.171964-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT010:EE_|LV8PR12MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: f8841a7e-faf5-4e94-32ef-08db824812d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ZNiRth90/DjlxPSC9B5f9sHAtBGzll5nqYFqLJjyBrwjk/g0jn4761dc6JgH7/uWulFTFbBCEhZH8F+l8qSdRY6TLvwHubXpXWrOPSHwAN2Xl289GJp80bVosjBYMe2+zg07KPty43N3fiwGAjUdvnkMhkMWWuOCtARF10RISqvg0dh7nBV2eblEPxCIXfiaezCU6UsQdEJDEbNDq5gbaFAmYaahZaSiWfBHOVidIpmn4SfrdEtn5EFtDNM4E2eDSSbv2bD/jcAbboCuSCgr+cL3tTL2N0243mqhaeUKYuhjb2Al/tBi193vjnqEdpxjejvaXfeI06YALPaZXtdrhaPXYkm4eQcrKEJ/vJyR2JjpwKy9fAwN4Vdd90+RD+gK/wfodI2D/bTLeEwHOZ/RQ/ul0RQaabsA4yBDDYCrJg/1FHTMDdy+O66AK5srKfKS78Y007wqpUxjdjkPRgBvVkpYFC4iWlWv0yug3CcJxQzGCwI2NfP7sL1qEkVrSx4GmIy/I/8ff7N2lIFoIojv6kbjphxAeZ7NWu7Ng/BwoNuHhB+XZWHy9YaJqAVPnypjh08Ci5P/M+52yL4YHtJoqP2N1u08Pf8c6whbzt63N67EacMqN5xlyfyxpHkFyOUXa5scPv6DjR2iWxCOBLAAMh4XFxD/XRJQIiwhx4+gVlavnM64pyE/jh5kjFfQw2ROI2YvYh/wS7B0swTYJolF8x+LnxT+Gn33ObZgm6xPdIuKlnUI31I/WPhp5vDEN62LTCvp44zq+UxKO2QBl2u/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(6916009)(4326008)(70206006)(70586007)(478600001)(356005)(6666004)(82740400003)(81166007)(26005)(1076003)(40480700001)(316002)(41300700001)(82310400005)(8676002)(8936002)(40460700003)(86362001)(5660300002)(44832011)(186003)(83380400001)(2616005)(2906002)(36756003)(336012)(36860700001)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 19:50:26.7610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8841a7e-faf5-4e94-32ef-08db824812d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9135
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

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5722b14a6bec..ba493d325dcb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7359,8 +7359,13 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 			drm_connector_attach_colorspace_property(&aconnector->base);
 	} else if (connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
 		   connector_type == DRM_MODE_CONNECTOR_eDP) {
-		if (!drm_mode_create_dp_colorspace_property(&aconnector->base, supported_colorspaces))
-			drm_connector_attach_colorspace_property(&aconnector->base);
+		if (!aconnector->mst_root)
+			if (!drm_mode_create_dp_colorspace_property(&aconnector->base, supported_colorspaces))
+				drm_connector_attach_colorspace_property(&aconnector->base);
+		else /* use root connector's property */
+			if (aconnector->mst_root->base.colorspace_property)
+				drm_connector_attach_colorspace_property(&aconnector->mst_root->base);
+
 	}
 
 	if (connector_type == DRM_MODE_CONNECTOR_HDMIA ||
-- 
2.41.0

