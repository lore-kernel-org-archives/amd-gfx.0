Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C90EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 17:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48AC010E5CC;
	Fri,  7 Jul 2023 17:47:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1571710E5CC
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 17:47:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFgO3A5n+3yd7Vkk0HHGAd+FEur06laY1TV4xq9l8DfMA4VMG/KnEOYcILaBs/1o9m6XTrsgS91Xdp9zwOViYtHVcoOz6zaNO4pvSDtfS0RrXgyd6nD3M6sQTkA77EHsyRI0m7n/gDULWd158FzcAFt+TN+rabOXuMSQwL6T7SUL/pcYdfK0eqvtMROMF7s6T0wi5q/tTwnHZKVhu/siDFJsC6CbghdjmAV0LisUUkklg+JJJqzBwXJlHrYDzd0gQF8Qq844jrDnfPA3RWxVMEt/kWY7M0JzeXkwOfHnK1IEhr9eV49O4ba5vam2WfAoDTm1ZQDWz/CjhFrUIkPJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YOphsP3mla6+ylwKwDmAAlvGoUmg0t16YLlV2OynWw=;
 b=VdAuGxzcrpT2vC/Kw4jy75HQ5y32S0Xn1NpP0YNnd/l2QIcOZtjGKS0jGAdmj8trZdCVfxBhbHzR28kvVgUMXn+S7Skmci9WFY4/aX81k07BiiCTjp5Tm4xd02MBl7Gdl9VFwmUxNHQVmceB4h4NK2Y52bD+J2LDLM6lmQDoz/XxMW+9f//yHtdjFlEv4AbyDDve4UvwokBttNNUajmHQoD3xKd4lnifKlwv6vaTGLtMS0lG4tuKgFENIRLp8ETmKUBmuIq7gv38ccvWs1R3rP4567Z1vDqAvFQRaaWKZ6dZfIODS29iURMryt0MmE7Cl2MvR6fYGuGnuqqKMGVUvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YOphsP3mla6+ylwKwDmAAlvGoUmg0t16YLlV2OynWw=;
 b=cdW4Sm3/tmw6NibSyWQfSgt5hxAJjgIc/zSVEot9Y34e7+rxumyV8segaaipdZY9RSwkP9kJ/cJqm8rznMvP0w/uZ/a5wl6Zc1tT91spwNyW8CMSkG3fRfGlW4iQKpPWYwDVlJp8QTwo4h3ZMjTz3Urw2y+IzZWm3L8OOpO5KCg=
Received: from MW2PR16CA0005.namprd16.prod.outlook.com (2603:10b6:907::18) by
 LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Fri, 7 Jul 2023 17:47:09 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::5b) by MW2PR16CA0005.outlook.office365.com
 (2603:10b6:907::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 17:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Fri, 7 Jul 2023 17:47:08 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 7 Jul 2023 12:47:05 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdkfd: restore debugger additional info for gfx
 v9_4_3
Date: Fri, 7 Jul 2023 13:46:46 -0400
Message-ID: <20230707174648.146441-3-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707174648.146441-1-jinhuieric.huang@amd.com>
References: <20230707174648.146441-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d14631-506f-432c-fbf6-08db7f122fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bttz5BQobrkQM4oea7yyvc+hemTg/UKtD+85H8Z242dEWwXB0Qs29EV6nXC3SyLjA+ODtSinD4NrIxsEPs1eP1eIsZIxGNAwWpin6u30jr8kny6h044UV11Kf7VuL6ZqXE9eLLpEx4vtODsH/Q2qsW1Bjb0lfNtLOTM4irOwra4CZ9g6HYtdO7BFHSxaQM7zSCtoiZUX9QJptAoI9zH3LlA1apDdwlfNbYNICghkAACkq4Iav2+VALIMYQnurenG2h+1aok25fcL95VijVYbQ+YWCTM262UKEhBU7jCWK/rio7sEBI8NQv4LmFw+gVpf3ljvNJ+/bx461ON4ttbERZLR7/Ui4Kam/R5ax6xfPmKxLDsaVKWIFYjDswYoe1SS3HfehDrdo7Yf8EmLgcS4vtiUzI3vSOYRiNI6m9iB+WvW9Fx4aW+Y/1bnM2ysawLopA0RV16SG6DDR48gnhTlxycgM/dTmvmeOOxyXERyL9o30NWuXJToR03cRqdWTtuSPzfix2mSABqiqoONAIyELKuGlLA2biTTkGbyDUNDVzi3eSUOzPnK8jFD/H+/OeDpP2+Vp8fVVp4gWkFSHShCq6JoXNtyiJsGMnh4RKFLAsn9Jnzkx20Aw0Sq6/gk/UJ5/PXriaXRqrIHRDii2Y5qVBg6Z4vnUV7v/5l54/3Dxrk5lZZ2/+tJq+TjesRDqJhWACvOo/g4cHNgdAPScedI7y3n1CSRqTHvxvhc2CjbtZrPyj01VPgHELr6MofJZAEVHuZSd5OCg73FnTVClhCPtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(336012)(478600001)(70586007)(6666004)(7696005)(54906003)(36756003)(47076005)(83380400001)(2616005)(426003)(86362001)(40480700001)(316002)(26005)(186003)(2906002)(82310400005)(1076003)(70206006)(16526019)(6916009)(40460700003)(81166007)(41300700001)(82740400003)(4326008)(356005)(8936002)(5660300002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 17:47:08.7761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d14631-506f-432c-fbf6-08db7f122fb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
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
Cc: Amber Lin <amber.lin@amd.com>, Eric Huang <jinhuieric.huang@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>, Harish
 Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jonathan Kim <jonathan.kim@amd.com>

The additional information that the KFD reports to the debugger was
destroyed when the following commit was merged:
"drm/amdkfd: convert switches to IP version checking"

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Acked-by: Amber Lin <amber.lin@amd.com>
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 ++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  3 +++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 61fc62f3e003..1a4cdee86759 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1932,8 +1932,14 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 			HSA_CAP_TRAP_DEBUG_WAVE_LAUNCH_MODE_SUPPORTED;
 
 	if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0)) {
-		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9 |
-						HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
+		if (KFD_GC_VERSION(dev->gpu) == IP_VERSION(9, 4, 3))
+			dev->node_props.debug_prop |=
+				HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9_4_3 |
+				HSA_DBG_WATCH_ADDR_MASK_HI_BIT_GFX9_4_3;
+		else
+			dev->node_props.debug_prop |=
+				HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9 |
+				HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
 
 		if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(9, 4, 2))
 			dev->node_props.debug_prop |=
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index cba2cd5ed9d1..dea32a9e5506 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -32,9 +32,12 @@
 #define KFD_TOPOLOGY_PUBLIC_NAME_SIZE 32
 
 #define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9	6
+#define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9_4_3 7
 #define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10	7
 #define HSA_DBG_WATCH_ADDR_MASK_HI_BIT  \
 			(29 << HSA_DBG_WATCH_ADDR_MASK_HI_BIT_SHIFT)
+#define HSA_DBG_WATCH_ADDR_MASK_HI_BIT_GFX9_4_3 \
+			(30 << HSA_DBG_WATCH_ADDR_MASK_HI_BIT_SHIFT)
 
 struct kfd_node_properties {
 	uint64_t hive_id;
-- 
2.34.1

