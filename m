Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A473C47082
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFD260FF0
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFD260FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD9BD6F4A2;
	Thu,  3 Jun 2021 15:17:40 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C72566F4A1
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 15:17:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ay0XqvPhbcJ1yJVrbM0f08Ak6yBJg8oS49GUrEwhOq8s2m+AFI13EzlE/I0VP466cFqOpI6ZwcIQzsQGwwH8/EOB6SYj7kUlU+uO0P/XbvLRVuey/J4mA6geiShU3khu0mapKX/crT/CjhLEyIdT+mtJiOp0Q1lNrQi9ZKnAt8T8oAtVxxO64JQqM6xX/qXem3U1AD1WRNjXz/iPRZc/Ol+Ie7LQfpKDRUT76kBAId98GBRPtWk5hbHS8W2WR67NP3sog7zlBrux/KHnOu1WnGdDxMSXAK53ctNdU3tuih5lJxzrhBd0j73slwaJwcUUyxHWqCld+/ok2WcTDkdxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8Gy02qq1onN84XVK6IHMIqmtrPyWtmH4ZEGOrWC0os=;
 b=Z/EQ6uc8Zi7etppqLhFIoX6/KtyCH03fS1NXzbG4My3ajRiq1Y9MiAXmnzXPaDCy6RA2slFVYeHuiKoED/wH3RyIQciZDWNm7gFoBg8H6LiFfaU/CYGd220x4Cw9omimcR8oysrYhKOuKnzG1I645+69vVHXnHJYYZGBiITLfXYjNDxJv/4YDCXnhYDDzRLeKzbYkfJYAWAg2sasrnjTE8q22E+RE4S7+U1JyebG5mmbQ8KnqHGB3a1cCva4D8XUb/3zjD1Jxq2ibi1vV1le86ijrs4GUfDd1ibJ+K5p+7xeRkJrEQQHJj3zp+6IIAbiMzt2Lag65aK1HZc540EB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8Gy02qq1onN84XVK6IHMIqmtrPyWtmH4ZEGOrWC0os=;
 b=pAq1Pzxnz1Rir2Tm5fxdwXsU4J6T3mxskB23kWxWZu7S3hzeFlmq9ExYv/OJZQspm2Gh5w0KrYjuLtrDHqaUSUZMCqXucGOVirNBlmKwDUY5/wPABxYJf9A8MO6FCp6bEfeKjs07Wc+EgsuNQWCnDNDN5FyPGX4katU3XwneZz0=
Received: from DM5PR2201CA0019.namprd22.prod.outlook.com (2603:10b6:4:14::29)
 by BN8PR12MB3171.namprd12.prod.outlook.com (2603:10b6:408:99::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 3 Jun
 2021 15:17:38 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::58) by DM5PR2201CA0019.outlook.office365.com
 (2603:10b6:4:14::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Thu, 3 Jun 2021 15:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 15:17:37 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 3 Jun 2021
 10:17:32 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 3/9] drm/amd/pm: Add common throttler translation func
Date: Thu, 3 Jun 2021 11:16:36 -0400
Message-ID: <20210603151642.14014-3-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210603151642.14014-1-Graham.Sider@amd.com>
References: <20210603151642.14014-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab254f3e-5677-4425-5582-08d926a2b907
X-MS-TrafficTypeDiagnostic: BN8PR12MB3171:
X-Microsoft-Antispam-PRVS: <BN8PR12MB31719A8D6CEEF72113E3FA418A3C9@BN8PR12MB3171.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bI9THBpIbFLAXVDo0rDZCXPJ2v5ByR1/Fy/iWNgHe/0zBcfPQiX/6hB/6xi6Lvt9er2io/LOxID5C5ekTDHAporcSjIPti/IWIdPq6hcwfyGKMc72wPy9VojUG+gE0vZ5B0zq+q4rlMyZq2/H2qdzj5LA78BgQYB8G15SZSjiXIfabGChTpoZyOwxZqA89in0AlqOoA7JDa/F4CBb2urhrEolo7OMs6uXcBxgCVdte7niaD1VbTx8R26lpLd5wiBWzAWHKrpLY166agB/WYAdMHOnd6UM83WRRHdnPBCq/KnVx4l9rSYDTd1IiiXUtzzgD/QSDvRCjsTP3iaR7Xn0X4VlB7MTWMDSpAZoic2Tkx3337UZYts+6qwXmXNEdnFyAOajy6ismqXnHMBs7dfTPZfdN8n9RIYRJRFaHRxurGNsk+NJWnM4gxcqRA5te5quVA6MUMuY1u9eUH0KR3f+IQf2ijaDgK/KwJGSD8nx8dllhIFF5kpl0E01tYACyYOLJlFJXxGmoSdAGSP2f3K8mJBORe3GJCYyj92mEPpHdjZ/0rg+elZB1jFqgeeg2h+YvLo1IjI5GBrBUiD4R6qVbjqTWUdWq0kbXLOSqB6KULqXR6bVpJ9wryWPDCssUil2Og5L9kedi+nhl+iU3y8AKFDZLqt4qatJ4AXKiZrkmySd3dg59YQk/K7LrVmABYu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(83380400001)(86362001)(4326008)(356005)(5660300002)(478600001)(82310400003)(1076003)(316002)(54906003)(70586007)(26005)(336012)(36860700001)(82740400003)(6916009)(81166007)(8936002)(8676002)(2616005)(7696005)(426003)(70206006)(186003)(2906002)(36756003)(16526019)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 15:17:37.9419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab254f3e-5677-4425-5582-08d926a2b907
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3171
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
Cc: Lijo.Lazar@amd.com, Harish.Kasiviswanathan@amd.com,
 Graham Sider <Graham.Sider@amd.com>, Elena.Sakhnovitch@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Defines smu_cmn_get_indep_throttler_status which performs ASIC
independent translation given a corresponding lookup table.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 13 +++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 01645537d9ab..269a42c0536a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -398,6 +398,19 @@ int smu_cmn_get_enabled_32_bits_mask(struct smu_context *smu,
 
 }
 
+uint64_t smu_cmn_get_indep_throttler_status(
+					const unsigned long dep_status,
+					const uint8_t *throttler_map)
+{
+	uint64_t indep_status = 0;
+	uint8_t dep_bit = 0;
+
+	for_each_set_bit(dep_bit, &dep_status, 32)
+		indep_status |= 1ULL << throttler_map[dep_bit];
+
+	return indep_status;
+}
+
 int smu_cmn_feature_update_enable_state(struct smu_context *smu,
 					uint64_t feature_mask,
 					bool enabled)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index da6ff6f024f9..c57ce2b2cdc6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -60,6 +60,10 @@ int smu_cmn_get_enabled_32_bits_mask(struct smu_context *smu,
 					uint32_t *feature_mask,
 					uint32_t num);
 
+uint64_t smu_cmn_get_indep_throttler_status(
+					const unsigned long dep_status,
+					const uint8_t *throttler_map);
+
 int smu_cmn_feature_update_enable_state(struct smu_context *smu,
 					uint64_t feature_mask,
 					bool enabled);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
