Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D94C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 09:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF2510E8CE;
	Tue, 25 Jan 2022 09:00:48 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2078.outbound.protection.outlook.com [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E1FF10E8CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 09:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QB3zISmZPCiGuR+sHR6jWLuXr0WHfsPQS1O5bCibv2qv3KL4KMq2/WPsW6moYYYS7WOWYNRSgvYSohPfaHdXSJtSxoVwYwCOZsKNNzczfA0bDBWeEJ0ZL/XBSQAjC7SENbgV0EVmI14XKPUUwWzyQvaf5PzsQ8zR7JN9iQAOsIkc18HJcBtV+XudqEyDTg9JBQ4wHeSulbZQeImLsplvf1tYc6qL/uLbFNZYvRIAySYvmSOQluYemmIoAc1Hf+JkTdf5g+m9KLO8NFss8HJt3nLKO5LCQ+3Anhxyk+NL0fTuLtSNfgU/pHh75rkWRxpPcgnYPXLeUdUEx9nNmHxNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yth+p6vKD6Si2Kt0IUcgXMg2v1zw9NgBsC32qg4PEOE=;
 b=AIh83xLmYaheSGSveC6oGUBySF2jznOEucijQE2Tkr9Nqlek7NvK1HAWaN1upuzlMiGqvXp6FV8wdxS6UmEwsodoGrnu6KDUbnti8pdzZA3ktmLZxJe0gRJYppnZ9QNQ7ExvSkLSElGxXMYh0eOvK+teL/7r/c/GaSluR3YZqKbrk/d+O/dEohNCTBCqKpxm7zGZJChAx4sDr5+T4Ag4rsLxLOQ9D+zaxd8PYDZJt3I7z/tOy8kWZoAVzN7nj0gq0styVewdW3diITSJLjI7eCpwRJr/odynBfpfZJlVBVvsDrzada+NzK3LF1vF4IKT0XbQWJi94QAnrCiju1I7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yth+p6vKD6Si2Kt0IUcgXMg2v1zw9NgBsC32qg4PEOE=;
 b=dIZovb6uGNFfSNfY3hzpjTXNPXi4Uwix+h2nAHruAD7vJrb+4TVjiNwOcz1KFVH9mC91e/whyBMJElpFF98v+I5gQyS4qCfY4iyumwqrV55+tH923TQRft9PU5yNqHyYZo5aFEgP45ZCLubU7rXyJZxtJijOIikCkg3oWM8dMe0=
Received: from MW4PR03CA0258.namprd03.prod.outlook.com (2603:10b6:303:b4::23)
 by BN7PR12MB2611.namprd12.prod.outlook.com (2603:10b6:408:27::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Tue, 25 Jan
 2022 09:00:42 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::7d) by MW4PR03CA0258.outlook.office365.com
 (2603:10b6:303:b4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Tue, 25 Jan 2022 09:00:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 09:00:41 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 03:00:39 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 6/7] drm/amd/pm: avoid consecutive retrieving for enabled
 ppfeatures
Date: Tue, 25 Jan 2022 17:00:12 +0800
Message-ID: <20220125090013.102080-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220125090013.102080-1-evan.quan@amd.com>
References: <20220125090013.102080-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f17ced4-306b-4df8-1de2-08d9dfe12a22
X-MS-TrafficTypeDiagnostic: BN7PR12MB2611:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB261168B7B28A49B1C5545913E45F9@BN7PR12MB2611.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xHAKXuGIvGivSty1V1PSfwSEhV5KvsVphofYRjYPZIfXGdGNM66jVEhZVvbWq4YHRnlH66n7s63TlwCP+e7hLI8XEYhCtz2CpbTkSOIFyA86gePnG4HCAGd7WNnvMJsb6AkGZiiYZpQQK7fKwiv+TIW7wD270AKaB7+GMHeWIEhGVCow8zpfKlQm23AGwpo9nGuQeKAO/vWrA+Q7aB6L1DIFRQgsy1suP3eNEsP85m8NYte+x4x7Er4jqqDtTbi8z5EZuT8zaEEdS5URESpW99UATP1hjE5E2gN0LxrBPLOAU85xmOrxnGn8lEU4YMG1IwUsguhOXefFzRAsQENPz1BrElZjKIFcS8379MYl1bR04BJ4FZuMdbPONnkYV4qImks3bZ1Aiz9zaBDHeOplLCcrpEVxgXHiENcoiJwD3dqahnnGx1Ty8IEOlAzDF/ClmiXnCzcR82NP4xnzF0CWGwAHhZHLUtt1p/ncodS6E8p+HZBnn1TwVPZstcZ0SLpyNTmlyiusoo7DD8mC6AdC/ZMWoGDKXf5hVv32GJypCPLzqhSplnqcEbbnNRLrzLkImicVYx4k25bUj2aqP+ObATpKUPNRInQ+DFOFWIy/A0IzV5OmCkJFXD8ClJ27Wu4NVXL6Yf4vhAYYJYOCfy8DzV8ODxW6kCAqXniePyTp9pfR8MUPiTOd05F4FesGoTWfeWrbbP1ojenqlYnjBpBK+z6SBuwjMYall+xtom++AbSmSAH/UvXCgRIUEjSALeAObmY39EYxrzplZ0nk7t3hfvRPGhF+6teUo3X4SlcrtFWFAqNswhHsgSQxGSs3h+Z
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700004)(46966006)(8936002)(8676002)(316002)(36860700001)(40460700003)(44832011)(508600001)(47076005)(186003)(6916009)(26005)(2906002)(1076003)(16526019)(83380400001)(86362001)(6666004)(70586007)(426003)(82310400004)(54906003)(7696005)(4326008)(36756003)(356005)(5660300002)(336012)(81166007)(2616005)(70206006)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 09:00:41.5588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f17ced4-306b-4df8-1de2-08d9dfe12a22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2611
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
index c4fe509fd420..2717f6abfe0c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -678,6 +678,7 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 	int8_t sort_feature[SMU_FEATURE_COUNT];
 	size_t size = 0;
 	int ret = 0, i;
+	int feature_id;
 
 	ret = smu_cmn_get_enabled_mask(smu,
 				       &feature_mask);
@@ -706,11 +707,18 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
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

