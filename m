Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F786C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jun 2022 02:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F8DB10EAC8;
	Wed, 22 Jun 2022 02:27:07 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59AE310EAC8
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 02:27:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/oguTjqDiv/tvzJ7JSb6Y0DTpAju3o/QVT6evEa8XkFsL6Blni22jYNiuwmIH71HTeG6ja+07ldHFIjlcEFk5Ex1ZppXnHIbH8cQnJScmRD/1QD7qHNvn/43PWmzIPC6EdaXJ3LAdpf0NgFJJ//Kk46htLGYTxfhKtNLnnzOzn96DclyVqO6qmqyfUxMhB0bdBNNisHksfZitVIV4mUh07gWw0gjX2f/4fg1QavMSc5fwZr8pyJkN3GyN/55qzBYljMBVXktc62klcnSucD1u+8OgJ57J1IDg/O/jDmRTDTMkhbOhvcXnb2oB9jlN9uUKLS/ZhsZ62xKO66E1dWdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEoMR9nziWsUmGOAFlt18c0lkHdVlR71gPngSGQ+meM=;
 b=Dl4NUmTjevEHe+hionmSa7meN4znA7+ysOuprEkDmHU6o9PWmhY4Pl5vMfYBzR8/DoESaFcO2kGtovOoWY8LvvtHt5G1yraan6GS4QrevLz1IPBw+KyCjJTVVS02xIBgiu5zkVJHis9kKgEsVU7DnN+w7IpAd8KVpb6GjJW86U1XNisYeAJ3nvTgjxbclf49lKV9G6V3wE+78ln8K7xsPg528EKUVBG29kqRXMuG8hxgfv/K1jknaqU2tGqFrZZ1VP7uiGK1lCUyPlFvk5WWWreGQHDWqc54N4lfcWE6ss5poci2hEr7tz+whRLxNfmvzSyoZ7CZtZoMVuUfiZhyew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEoMR9nziWsUmGOAFlt18c0lkHdVlR71gPngSGQ+meM=;
 b=khB1aVtNXoIUEfsKCBqHTEY2XhHNL5N05DeJ5/nnY/Z4bOF0ucEKLc/sK8qy8SHyVOZ1ja2os8NPoBqYG468DXQNT2bY3TldeAyub3dz1s9PiCkqQ3vcCpACV0Xn7iO3dZneoPvMgaZkUTIAQ2Yfrp9B7jq+eC/9ZaGbDmsNzQE=
Received: from CO2PR18CA0044.namprd18.prod.outlook.com (2603:10b6:104:2::12)
 by BN6PR1201MB0228.namprd12.prod.outlook.com (2603:10b6:405:57::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Wed, 22 Jun
 2022 02:27:04 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::2d) by CO2PR18CA0044.outlook.office365.com
 (2603:10b6:104:2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Wed, 22 Jun 2022 02:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 22 Jun 2022 02:27:03 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 21 Jun
 2022 21:27:01 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: enable VR0 HOT support for SMU 13.0.0
Date: Wed, 22 Jun 2022 10:25:56 +0800
Message-ID: <20220622022556.35736-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220622022556.35736-1-evan.quan@amd.com>
References: <20220622022556.35736-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afba9a2b-0a1d-44a3-c6c6-08da53f6b219
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0228:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB022828C6B5E36375B7970DAEE4B29@BN6PR1201MB0228.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2SZusq13vlU0DgHT6TAhSqnd4p+drPo7TN50sddMOQe1eOXSfunVxAWeHV0ErtC3pMRoqFVxZQxZScMZ+gyiOErFSRR5BzmSM9XljAdZ8jZSdmmczhCHukR201UxsXjdTyBTvEJxIg+sbqhEENfTvtEA5PoMcOhU7z70NhvhgdMGEzNTqCGBUuIypSe4muQmqhJIpGR4Iz4JgWFH8E1UMo6CXAQGi1GiTk4k7sIIEQamodiRArtp+Codkp2YYmw3YJVgWTSypYA5w/XCa/VRCtQqhXRQrQJvIRg44ykEXYWT2O2F+zyNZmqc1j+RvOqOWtZqXkoAUlFSPzeg8P8RmZymrqKXl9fLqgeNBmHBcOXUX86SFnyOsH9r9ZneFOuQlPnc7xv1VU4UyOBAXVwFVTKYtQyKDJ+zHHUjm59K0rwisMPp8/lBAPxQPrKAMAqQ/lhuMTzOPYyjvmZ7j8qh+BPWq1JQb9yYUeCX6TIj5EYk8XMetmquIFgPkC2NnfzuvYxOxhuOtCJwkDKRH3Jmu0apjn5eL4ub+DxtWbxvlAHEjMqRAUivy/QnixNhbnie79gyJhaPe2RtItoTlKPE/iBV8naU9ghgL3qmj9MfS+nxnsrUKweb4gfKcU8hzzkajxgFIgM9QxBYy2H/gR1oO8R6593vbLHdEBwPwU5Y1/r65QIbKvTmB8I24U1M9GoDjt/Cig6ahTLKg7eigybd0JhwVrVrDXjOu9Lg89iGxr5dfCUu+9J8jLi3PLrkw1b
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(346002)(36840700001)(40470700004)(46966006)(82740400003)(47076005)(70206006)(426003)(1076003)(2616005)(186003)(2906002)(336012)(36860700001)(4326008)(16526019)(70586007)(356005)(86362001)(40460700003)(40480700001)(5660300002)(8936002)(4744005)(44832011)(41300700001)(54906003)(478600001)(8676002)(36756003)(7696005)(316002)(81166007)(26005)(82310400005)(6666004)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 02:27:03.9253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afba9a2b-0a1d-44a3-c6c6-08da53f6b219
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0228
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable VR0 Hot support for SMU 13.0.0.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: I11a642033d6e0885877cf48c1f1e07f30de4622e
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 6fb2b072a730..ce2fa04e3926 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -308,6 +308,8 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
 
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_UCLK_BIT);
 
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_VR0HOT_BIT);
+
 	return 0;
 }
 
-- 
2.29.0

