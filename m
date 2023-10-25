Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09925C25B48
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 01:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39B6810E0E0;
	Wed, 25 Oct 2023 01:40:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC02710E0E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 01:40:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1IQtgHlX3gAeizngre2QreNmYQJjZANnUUYSG13tCAolEd1e3fYsOidGx2Ov91aEjsDxIUi/1k5PtVz6539X+xNK7mT2zzcODCaLI/+hl/SeVFFUE8c1wSRTGPRK9C0AIlm8MGjY6F8R9gkptiADEp16J1C1BjYhsjZRfSPNEWYpZ9ncG75GM83cIkHBn9qWSZBlpWHIaJuNnsRyII6KYGETMRkoXhRmBnEzFP5CJeH6H0QDgG2laZHhs2copHCPQJvyOGtybsvllWqfifbISQid50wMsaXQNCNMr7QWoK5qi1vHbm2IcgYIi1HwoMGQlzaUeu9UVvhJO3iqEkDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcHT8W6a4PfPEOdKKMPwkfrGwUE2dmOWihINVXBhX5g=;
 b=AVFSItupj3I6uMEVU5EeCpeqnqKc39n+aiqPPC/Ue0ETQxsXd048cDYUNF+PuKi4itvHl7m2fqr10LnpatIya22a760Kk1KvSIGEPqMYFM/DqGdbblCe8DChBRhBCWhoXAetWQWuqGyyywkiyu8FzcuFV+7drMlb3MjJ82qvHaw4NttZvBeXC9QqiuvPu+07PXDXimzJRa7536BwCdR5Ib/VI75u9fbSh/4ssyf/yiT4Hk82fuNpaIBI4GRf7bZXk87j28cQ5l+dsFthsW40JukMyHTD9BaktJ9JM+BYYwBe7vV62ZcZNSt/mFKmHIvgi46JV1qR5rGBO2QPF2Cn8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcHT8W6a4PfPEOdKKMPwkfrGwUE2dmOWihINVXBhX5g=;
 b=aCkH5bUkcLrA0SHBHe2t7Fpu8ShQAULO3/TE1RzfCE7GsRdyWc30rZZiP2FaEj0R9SMUPtY6jN/U3ThHUfzQZfeCSU7EmPWTpyvfo46BzDqcAy4RoT8MWw4YcAIW4pvi1KhLSgwEXkGproaQgnVn4dNkKsv7+fP4o0Q4vT78OoI=
Received: from CH0PR03CA0391.namprd03.prod.outlook.com (2603:10b6:610:11b::10)
 by IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 01:40:07 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::d5) by CH0PR03CA0391.outlook.office365.com
 (2603:10b6:610:11b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Wed, 25 Oct 2023 01:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Wed, 25 Oct 2023 01:40:06 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 20:40:04 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: call smu_cmn_get_smc_version in
 is_mode1_reset_supported.
Date: Wed, 25 Oct 2023 09:39:43 +0800
Message-ID: <20231025013943.1604055-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ae0306-e7a7-406b-cf15-08dbd4fb5152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aaren4Xxh01GJtZTWgI+duY6U0AqxsGX2FBHjzN70zvu9IkL6gCvf2ry9JwnvXf3bhB8+mS7VDMRt01HmLjvGpIHh+GTKm2BPjvgwgVPmNrp1GNQpnlmWLVNPfBAnU2Drhl+w4BVuhDWgWsx4iCM4oKPfF/g7rGMwui7v1S+G2TfMbjrtatURro8QXwDJrMfSzRmfDhg+O2c0amuOEHbJNTZ3psFTye2+JkfRZQVwpJCw2A/CMINMb2ARW7ulJCBPugER0X8aXnxYsJ/fLeDSvc6bKq7dak+VqGx6Y73a9nLeVaEFLRA/HnKB8ax5YoTVt6APbgiu1Um2EZ3fO7/h2HGgEyL6m7W0/nqASRHQ5pUVtbfDp5YzYPxRQF5cCZDSea+wyad+uq/F+vIB1uXGM2gMgQOmxJaBf/OAcGrKpL7+Gta2xysYRgAupEbHMb5axatjkgNlH3p2UzTxcXHyYzApCA69v54AjZJ9lJDc7cAR6pATEyW/4wydIS/aX36NwBfCKOlkxfuhD6u1Dz9y66i0Gc51mptLpqJRwX+PGL4uoXv2UMfk0TZKslk75jsPufk13g6zYDjPqZ5hOTzXbB/2byDzq9f/AOkZ2/eep++9NAU/jqumbDtDFvbOIsLl2IPtY/zFyoGVdV4/FhIChR4UvZIwzJ5Flu+RjQpPWkdjTVr0H9yZq++L6hLj2lo8EtTTWk7l0OJXhqRpub4+aWJwjHMNcBsXeVKbk/LuUX5P4YrX9YYCX2q8EJRcwLXxZR0/N2XgRBB48s8lwfjzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(82310400011)(186009)(40470700004)(46966006)(36840700001)(47076005)(83380400001)(41300700001)(81166007)(2906002)(86362001)(26005)(1076003)(82740400003)(356005)(336012)(16526019)(426003)(36860700001)(5660300002)(7696005)(2616005)(36756003)(40480700001)(40460700003)(70206006)(478600001)(6916009)(6666004)(54906003)(70586007)(8676002)(8936002)(316002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 01:40:06.8537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ae0306-e7a7-406b-cf15-08dbd4fb5152
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Candice.Li@amd.com, Kenneth.Feng@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

is_mode1_reset_supported may be called before smu init, when smu_context
is unitialized in driver load/unload test. Call smu_cmn_get_smc_version
explicitly in is_mode1_reset_supported.

v2: apply to aldebaran in case is_mode1_reset_supported will be
uncommented (Candice Li)

Fixes: 5fe5098c64d9 ("drm/amd/pm: drop most smu_cmn_get_smc_version in smu")
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  8 +++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c     | 10 +++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  8 +++++++-
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 090249b6422a..77c3d76c76a2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2461,12 +2461,18 @@ static bool sienna_cichlid_is_mode1_reset_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t val;
+	uint32_t smu_version;
+	int ret;
 
 	/**
 	 * SRIOV env will not support SMU mode1 reset
 	 * PM FW support mode1 reset from 58.26
 	 */
-	if (amdgpu_sriov_vf(adev) || (smu->smc_fw_version < 0x003a1a00))
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (ret)
+		return false;
+
+	if (amdgpu_sriov_vf(adev) || (smu_version < 0x003a1a00))
 		return false;
 
 	/**
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index f082cd4b40c1..1a6675d70a4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1931,11 +1931,19 @@ static bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)
 #if 0
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t val;
+	uint32_t smu_version;
+	int ret;
+
 	/**
 	 * PM FW version support mode1 reset from 68.07
 	 */
-	if ((smu->smc_fw_version < 0x00440700))
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (ret)
 		return false;
+
+	if ((smu_version < 0x00440700))
+		return false;
+
 	/**
 	 * mode1 reset relies on PSP, so we should check if
 	 * PSP is alive.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index b1433973380b..648d5eafb27b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2615,13 +2615,19 @@ static int smu_v13_0_0_baco_exit(struct smu_context *smu)
 static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
+	u32 smu_version;
+	int ret;
 
 	/* SRIOV does not support SMU mode1 reset */
 	if (amdgpu_sriov_vf(adev))
 		return false;
 
 	/* PMFW support is available since 78.41 */
-	if (smu->smc_fw_version < 0x004e2900)
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (ret)
+		return false;
+
+	if (smu_version < 0x004e2900)
 		return false;
 
 	return true;
-- 
2.37.3

