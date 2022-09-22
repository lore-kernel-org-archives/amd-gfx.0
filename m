Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E626EC6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C6510EA0D;
	Thu, 22 Sep 2022 00:19:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5690C10E9FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+IHzhgNEgj0qPTtzXzIheUg5KfIySLYAw2w1/Zd3Lh/pMPJmDz/CNRIJrz+2fTzDWNuep686A3RJnMwMf2Ce6lGDRXAZfXWfiDSu3K1dyJFOh3MyAv6Fac5vE6yYBDwDNb/r3BbSrXCBfJ7Gvxwv7CtQxjDmt3AfW41RtwH32IoXBYpW+sfYVHt+os/HBgoMZjzqq1ZDFMGFOHy7SBQdUTvub8V6ZwFC2UUm9O4jHq0gycJP7kc2nJxbyRQJX9Y0/5iZ/Db8PoGWL8ybmQf2kRaOt1MOpCQmASjPprplLz6avqChtCa8heBsW1oT2IbA1W2HSClDnkwG9g5pZ5aTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXv1qSs/0aKlfnr3fidemg8SUMdturH8qZor91PVy/g=;
 b=NcScnpibMnO/XJw4PQGQBNrLDPy6WkxdOep8LaWJ9cwNzw5WWmUHuDVqaK7N/zF882bPrk5KM/BoKc4k3ytcfYiZgk910zEyDQVuPIZyV3SGAIJGT5rn2dT05RrnC/+av9Nkm0fuQ4lBqdwTsnyuBd52I0TFCeN3H4Q7zthtjUPbPmpbGElUKCMLHd4I5n12CBndwkh6JXQKS1nJuTkE47nTBFfCz6q822FKqxPQ6MIZNF+HhTllvaQEK5Qr0PMwqgwhmSfN2ePM25FA0+S2cdG7XoJz7Ybe0aFbEvtCuUVGXE1SAhs7v5nD5cYieVIMc7a6cSyg9CCX0zHllucjzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXv1qSs/0aKlfnr3fidemg8SUMdturH8qZor91PVy/g=;
 b=PmXTMOq1ZI6mcuWh9uk4cwKiQlVEfi7/lvWE3Eva79AVdzj6+l/OLtqafpSH+dimvYoC8oNdOSSYiII0ptHT6rwyM3Ur1qBy6do4WogxIEm01aM9d7WWF+ktwjoIcYHBE2vJmzXybWxNJf2YIvN1pLLluAYJrb/KLio48k0TrKo=
Received: from BN9PR03CA0891.namprd03.prod.outlook.com (2603:10b6:408:13c::26)
 by DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:39a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 00:19:20 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::1b) by BN9PR03CA0891.outlook.office365.com
 (2603:10b6:408:13c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Thu, 22 Sep 2022 00:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:19:19 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:19:17 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/31] Add ABM control to panel_config struct.
Date: Wed, 21 Sep 2022 20:18:11 -0400
Message-ID: <20220922001821.320255-22-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|DM4PR12MB5055:EE_
X-MS-Office365-Filtering-Correlation-Id: 31341f72-d70c-4a58-2060-08da9c3017d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vsT8nWUjoxSD68lKApC+xUpDifShrNNBwV5UvbP0YIfKAVj5ycKpVA7PmnxUj/ZtBSOTjKHvavWh9NvdPtBgC7iEbE29xq5B8W5ukDQ3YOpg3roBaaQONP/vhC+pRIcFmUvLg5r1j8WtB2QkZgcuTKY5IXCnSCcju2V0qq1xsY6Skssv/3LfnVRBpnoCusxFaIBYs4AQHQ/Ugvfm1j9hBy/7ZnMWimhIUMZ/8fEt8GZ2BDX/NJuMfQC3bIHo0uKydqHhtbDfLLNnE5cdn3W+rFI7K9qel6g0oQmOvKZIBk9B2etveeH+A5qF1a98LoHO/CDDzR02knD+Xzhs0C3GIeY6yw9vVqRYgsGiwvC4kSxLh+jaa7fWaFZxLqIWD66C/JBsJ7iK/XKePj6RO75thzgahRUiyoHfu2wtanq1KOGTsG0rQiw9RLdc76zhJ0BPpEuuxmu4IzjKBJ7cvcyL8IF13VZwmox8O1P+fn5VhJEoKx8lU6/LEFMfKMXjop+Udd4hCtNLJrYTz+VctXQ54KcpGqy7VKw6MNMidcokWMb9u2MeZt6+++kZL4NVYmawNSJu5Hb/nOgM6kBTeTmaa73zPIAHrI7Zq8JCTSziuAgVWHhrM+fJauTyM7JIvf6WOtfwKB8RNm0ksHPv4e5K7vRKwA7Kyh/YrwEX01M19YYBEpJEidDPUj0uEl6IAhIGEfRhImrxvuf98r44HD/QA1JNBFUIYystr+/Vix5vkIDrRWGlpvy56VQjrB8G/rQChlRHxpSKT/CXSdaZsVd3zSmfVw7qx3wO71lUg3LelzGXD0fUexiF/M6zfECrQ3xi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(54906003)(6916009)(6666004)(40460700003)(26005)(4744005)(5660300002)(41300700001)(36756003)(2906002)(316002)(70586007)(70206006)(8676002)(4326008)(478600001)(8936002)(426003)(47076005)(186003)(2616005)(40480700001)(1076003)(336012)(16526019)(356005)(36860700001)(81166007)(82310400005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:19:19.7862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31341f72-d70c-4a58-2060-08da9c3017d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5055
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
Cc: stylon.wang@amd.com, Ian Chen <ian.chen@amd.com>,
 Josip Pavic <Josip.Pavic@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ian Chen <ian.chen@amd.com>

Reviewed-by: Josip Pavic <Josip.Pavic@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_link.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 6e49ec262487..bf5f9e2773bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -127,6 +127,12 @@ struct dc_panel_config {
 		unsigned int extra_t12_ms;
 		unsigned int extra_post_OUI_ms;
 	} pps;
+	// ABM
+	struct varib {
+		unsigned int varibright_feature_enable;
+		unsigned int def_varibright_level;
+		unsigned int abm_config_setting;
+	} varib;
 	// edp DSC
 	struct dsc {
 		bool disable_dsc_edp;
-- 
2.25.1

