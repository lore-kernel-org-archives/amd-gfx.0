Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C0AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 07:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B332D10FA8D;
	Fri, 28 Jan 2022 07:05:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3364710FA88
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 07:05:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLnMCOMhlusCFRaKKQMxO0uMW66PPmvBKlV2TL8MP8GmLnZ3kInTrhnVN5vfgAX6xVchbAVh87kokhVq3qrwm/xnUphRTDrnmXeYjz11km+QrTcy/SQM25hG2ugCSnYidj5f4feqhR1IXWUEG/Et3zVRNqdH39Z2/Td8SHv8hdbUMpD0suVHypLBi0B8dEmrQ1p1y9xKaHNMYp/6b1JykHZ37OnxKIGPc4sjNgKwLXV1W9lg1tXDMJnexT64A6Wvw3JGmswyxy+nCChhc7TI5JaVeDRdbeATsSDlZOSoXJsfS85eDWIZBX2DYCPpaHfQ9uagMqCqarWGe+irEFwMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzvfiAzTWVJiCqByK7nfJw828EqpXbdZvFZpqcGfyf8=;
 b=JqtD0HtQAe8Znxy5GT/h2icegJyE/aBtNbQozabKz5LudJ7fqu+0UsTdTaJNWkisJCZ3HpeaRcGC56MCCzVFHBmlG9fZoPbF0seSzK3hOGiwZOlhTGaoHRbrMvbWbc/zzTdS4fSZOyV0OZaZq88MNUmfgE/XlesaxRltG7sZC9bgHAldC5rk5+wwTtEjjWG8pYe8ubKxgqAnAsyY/xvPR+BwVxgV39LV4KDtfa0P2KgLnVAVOCFaOAAE1N7VUt+TyQfgJKZnuKkgWY6L0guouvaexkhhXzZ7uM+Ju5dpMLNaHHNRNAuyzFMy/bNtwfMB//0y9kYU/9819OikYiQ6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzvfiAzTWVJiCqByK7nfJw828EqpXbdZvFZpqcGfyf8=;
 b=Raryr9xcJb9fklmQoMixJG5GNikrnGyJu4YeW8YamDNYNxNQ5h6OE1mxmNcUlswfUzGpd40361YkmIaPsgfaX3+BJFUa73G70K5E+CZaIKrS7faw5L1z6pglSU3qWlCHXNhDRTpB9urHu/24/oJP34FQgH9yudDNOg1R7o2258U=
Received: from MW4PR03CA0181.namprd03.prod.outlook.com (2603:10b6:303:b8::6)
 by DM5PR12MB1145.namprd12.prod.outlook.com (2603:10b6:3:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 07:05:38 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::d1) by MW4PR03CA0181.outlook.office365.com
 (2603:10b6:303:b8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 07:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 07:05:37 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 01:05:35 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 6/7] drm/amd/pm: avoid consecutive retrieving for enabled
 ppfeatures
Date: Fri, 28 Jan 2022 15:04:54 +0800
Message-ID: <20220128070455.202014-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220128070455.202014-1-evan.quan@amd.com>
References: <20220128070455.202014-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93a7706a-2545-4b40-6c4a-08d9e22c9661
X-MS-TrafficTypeDiagnostic: DM5PR12MB1145:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1145D6505CAC731A3DD193B5E4229@DM5PR12MB1145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MWzpTuB5/xmIdhviI59AO6LkwB8IQs9kVwqvCz4nbKIpChvbkduRqJwhyCydHs0650X9YWQ9T2DuffRLvdUxKriwsztNc6mzGLwL8QlO+byc49pGgsh2Eerwfq5qeY20L/F/Sp2xgarPcZWYAyVxai8JHVFCTAhXXRuv+MUFaInb7Bs6o0g/Kx8AnLPiUzrIsJ9LN2WQFjn+q5ytkmF0q5/UFglUoqWMjOx9FXMWf/6PnOZYn+cQ1vve0RxW4FXzUEenRTVsvAzHO27H5xhtI1MIac1qf7U2N58Qi0UQFYbcfa4hsaEQwVEu0ICtco+JfIr1BqIhCXOhriqDlFtHNrYEfKJPQZ7/LzMWVxwvSAVp3U/RKn0G1W87J1MuYNNw+tpnEoxV3prXLg5IzihynfQrsAO/lpl7Dg8T9NgTKnINDXaWWBeMJpTXiYZF/aQxxeQ8AgJGzbYonhIc6AivDmG/OJAbNaBtkVXiB0y0XFIDzvxUWuDvjytIpB6OQPSXxy2O5uEvUkqFfCWrW5VlEX6TfFNSycj1yN+IqKGsy+blE6BZnd6aYWxI9kIz6Vk6H1ywBtTVlltgmwfwA53D6VDeE19Nbq33yn2q2RWxIx/LwWYahhIIIUswbYMwFYnHyBUOe+Tly8sfHftZ66pLd1rdy+MbWnWQ20gns5Ded6KOPdz3YQTIW2y78I9HY+Q9QtV8QLysaT3JyXtNMbCzyRpgbZYHef04Mv2qux/PjVY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(16526019)(426003)(2616005)(86362001)(336012)(1076003)(186003)(26005)(82310400004)(54906003)(6916009)(316002)(6666004)(7696005)(508600001)(81166007)(356005)(40460700003)(47076005)(83380400001)(36860700001)(36756003)(44832011)(2906002)(70586007)(8676002)(8936002)(4326008)(5660300002)(70206006)(36900700001)(309714004)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 07:05:37.7322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a7706a-2545-4b40-6c4a-08d9e22c9661
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As the enabled ppfeatures are just retrieved ahead. We can use
that directly instead of retrieving again and again.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I08827437fcbbc52084418c8ca6a90cfa503306a9
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 3d263b27b6c2..acb9f0ca191b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -680,6 +680,7 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 	int8_t sort_feature[SMU_FEATURE_COUNT];
 	size_t size = 0;
 	int ret = 0, i;
+	int feature_id;
 
 	ret = smu_cmn_get_enabled_mask(smu,
 				       &feature_mask);
@@ -708,11 +709,18 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 		if (sort_feature[i] < 0)
 			continue;
 
+		/* convert to asic spcific feature ID */
+		feature_id = smu_cmn_to_asic_specific_index(smu,
+							    CMN2ASIC_MAPPING_FEATURE,
+							    sort_feature[i]);
+		if (feature_id < 0)
+			continue;
+
 		size += sysfs_emit_at(buf, size, "%02d. %-20s (%2d) : %s\n",
 				count++,
 				smu_get_feature_name(smu, sort_feature[i]),
 				i,
-				!!smu_cmn_feature_is_enabled(smu, sort_feature[i]) ?
+				!!test_bit(feature_id, (unsigned long *)&feature_mask) ?
 				"enabled" : "disabled");
 	}
 
-- 
2.29.0

