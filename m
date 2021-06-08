Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5588C4743D
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B42586128D
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42586128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B646EC11;
	Tue,  8 Jun 2021 15:08:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E536EC04
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 15:08:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALZfiHwBDKivkPbKciGfwi6VzTFuNWHQL2M5DydDYrwNNi1vaPtor4hdSNQGt/qn5OIJWWu2r2hKzS9UeF2mvUjALbt9aq2thXeDdoL+4B2LPavxmbd9ntneHHr06X2z2CnY4cDVbDif3BExkUpEo2s10kmbRQm7XIannPbPXOyF2r9exZMCIxP9HQkLRBKCRt9FdavNkGrkV8zqhf/OXTtPVrcLM9A97XzUMZsZNmhf2vhMIx4G+AKtFOBJEz+YgHjmOk7CdUu3A0qOoMr+/CDKLBjdfrvk/hKkoGku8Vw9V/xKvTvUSSt8bVUEXCoeXXUeZfWAxl472LzIfgeZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8Gy02qq1onN84XVK6IHMIqmtrPyWtmH4ZEGOrWC0os=;
 b=OWfH6b12I6oE2YagxeU6FozvoJinYJT1TxPUCXsT9Swy0BSQsTXkrZbYtuNS7xCQHO+meKpV1T7Y53yd/HFASI2x6LSuwVx7bDmKUA2Gy8VJ2kwLwjmOcilKgPOJkEvB83b7xxRy+JuwGFvM6U+cr5ohNy9J+jUR1JayzOnfxoF75kARtkHfyTUsEQ9rQ/jSv4oAk1MAjsnZ23O+vLym4PA5YDUJoUFsqkzLY7uYh9sD6xCzWqDgdNWlwlYyDUj+hfsibiTlcli3UWr+o4ivzeilZPLpmy1tXq8wkYtj26C0qLItLYrlHydJ3G05Wu/Pe5jFmkrlx4slP2M+o++u5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8Gy02qq1onN84XVK6IHMIqmtrPyWtmH4ZEGOrWC0os=;
 b=w4MT6T1ukktnbia/miBZcq6K9GKcbXqBV1iFxbxCfXaYwwbD62o+Y2IT7i3IdEk/rW41bOEfwpEDg8amy/wFHqhg8AiO2HB6uWvx2aZ4rqGt5NghiqRUA5IHAvkOeNV8nnl1tYLU2cfQCcIITEaL3LI9iG6FcqIc714+5PucL6g=
Received: from DM6PR03CA0079.namprd03.prod.outlook.com (2603:10b6:5:333::12)
 by DM5PR12MB2567.namprd12.prod.outlook.com (2603:10b6:4:b2::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.26; Tue, 8 Jun
 2021 15:08:27 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::1a) by DM6PR03CA0079.outlook.office365.com
 (2603:10b6:5:333::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Tue, 8 Jun 2021 15:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 15:08:27 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 8 Jun 2021
 10:08:25 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 3/9] drm/amd/pm: Add common throttler translation func
Date: Tue, 8 Jun 2021 11:08:04 -0400
Message-ID: <20210608150810.9679-3-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608150810.9679-1-Graham.Sider@amd.com>
References: <20210608150810.9679-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f77f1b1-eb4e-4817-9a71-08d92a8f44e8
X-MS-TrafficTypeDiagnostic: DM5PR12MB2567:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2567AD19C6DE4FCF63F7E99E8A379@DM5PR12MB2567.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O739E05LMceYFxPqYOizO4IqWkCmybaNvUqgSAJH80MxdIVCUtti7+fhCBxWP2DF/wfl+byveEPRkjWfXJN8yW/K/mfh6b9utqoqU/sb3zNZ3/duuUApbr32a53Cb3CguCNw1MyAI2u1NgpcKdjhT2FNqkkaozTMgieNFEusNP3uHz+LSmb9hy7vJI7hpd/kowg1kGzzJDTSMt2QePTpcfX3Vhpwo93icalImJrRTtF30IMUA9oHYHA+gmDAYLLSuOWrMsCqfL/wIbhJtOyGeUjS++K65FCGg0atFsQ1K6ovGHXjuwyDCoUkcusWunZwA1XfncvDwYF/34sm8XyvidGSPjzBmAhK8VXApwAuEJAQDXjsNLfU9fReZ7O0u00jyvm7t1ZX9DcxL0ac4gGJB7riU8L7IlLRcL9pbDMjnwQln8/1nlDgZMoELDocFY6L6ST16OU4PpI+v0MdQWZE7b8wFbCg3SidDHjj7Hw7oAdfZ/AE6YToh1JNMHPReyA3SAcwPDxjtuT5gkLsH/oQHDqEc2/j1ZRQXCcngJcwZdZQJojRDx/iPJ7hQ+SSlwts7swak9Fw+LU2OX5oTqkBarrciPVZ9MuelwHFtxoCvlDJPMXtBVJ7iVqTZc/GEulRMAdm8GuoPuu0+iFxjj32B/zDHFYSGuZBsYK0cap0BrklsnXLlClduim+Sh0wzakB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(36840700001)(2616005)(36860700001)(16526019)(1076003)(54906003)(186003)(26005)(86362001)(47076005)(7696005)(8676002)(6666004)(6916009)(316002)(426003)(4326008)(70586007)(336012)(81166007)(5660300002)(82310400003)(8936002)(83380400001)(478600001)(356005)(2906002)(82740400003)(36756003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 15:08:27.3380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f77f1b1-eb4e-4817-9a71-08d92a8f44e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2567
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
Cc: Harish.Kasiviswanathan@amd.com, Graham
 Sider <Graham.Sider@amd.com>, Elena.Sakhnovitch@amd.com
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
