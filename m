Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83312C83F2C
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Sep 2023 06:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5698310E0DD;
	Sun,  3 Sep 2023 06:06:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4D2810E0DD
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Sep 2023 06:06:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9P1UyFY2hE3fe6yg4lBj2qJHHPKZkPdO91wyLr41v0TJVtJ6naQnGyZon0GuHBxhtAO+Y82WytFIWaii9HEr2AvPhhlObvWiOu4H/HCxb0pz0Uksjze/blF7AyJQwM+tKNjJFCHJ3xPc7Qm/1WNvGgJk0yzoZU36Zj09+8rUad9MzBx/Wz8PXZz3wFdtlnhf+GqmHwkVAzwCBn/AlyDU9bvOeFizw5StqTynqvJDS351Vit4Np+C9glgfuFCzSc3WenXOF8nrNOA4ZT07KJUIkAhqtcg88yDeNvKFAXEPMbCPkHWHm+o2/h1cUhgfTGpftnX8wERX7QLiplZNBkJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6AZtlqKFkhjAOEJ7F37bKuOTV7S6TUVOrWR5OYVfWg=;
 b=Vyiv44HIub738a4NnH+B18EQIRU6J4bL2Z87TIn2pjAmWlUvlvCNOG7nTue3IPG/rqPbmsJkzwlyn+uOyHXemwhX7jMFgQgBq9NL9uoTWLPWkd5mz4gqQGRbR5ay4lCa+EUmyGZSYULm8bMQIfB/8kW51wUHEbSeITSwFh6O5U6SSlXIsrm6zG9ZGbsNQl7AwMBVGcHMLv17LRIoRZ4U52OZbdyAjeu26sDiIZKCQ8ZcF6Uupik4rudu8gJ+2e75A4nLxQkupIg3ij1FoC5VpfqyI6ic/nFVpdv5E5iqkVHpXZt4uQr8U6tULMkfnfaqxhK0gks1tBJn2cGLWxXqUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6AZtlqKFkhjAOEJ7F37bKuOTV7S6TUVOrWR5OYVfWg=;
 b=4WYmaGoz2uLxNIh+M5vRDIh0bw/3MYasnny7WNutX3MmD4b9cdJWNPL9UyHY5578tKIIITLtcFicQC25fk5QE/HYnTFfthUhpJ2Le90Q7QH4ST6FWN1HNcdqSYciLtWB0/NfUTRCIpJ47wTlW7X4NfAKSP81BCSCcQXHJu30PSs=
Received: from CY5PR19CA0011.namprd19.prod.outlook.com (2603:10b6:930:15::13)
 by MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Sun, 3 Sep
 2023 06:06:05 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::73) by CY5PR19CA0011.outlook.office365.com
 (2603:10b6:930:15::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.29 via Frontend
 Transport; Sun, 3 Sep 2023 06:06:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Sun, 3 Sep 2023 06:06:05 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 3 Sep
 2023 01:06:02 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Declare array with strings as pointers constant
Date: Sun, 3 Sep 2023 11:35:48 +0530
Message-ID: <20230903060548.1972667-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7e251a-d18e-4b76-cc3c-08dbac43dbac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J31uETRTI0w3sQE3HMLU1P8BLx7VuhZaLQ1QDD1aOBXfI2CtIV7VEN3wQYqGVZb/PU5dctJx4hpSDLksFJ20xUS8jBjm+i//U9KkqPlz5JItV6vjUAxvWdWlYgtdNEtKR0dkg+V4ytrlmAAMC1WpYFeZI2TpU2xkg64rPap/VYVmdRzgRxcaPDyOs0uAe/FP9euE7GAFUbOyX0by5Ny+wA0wPoWJDYGFLJJS9MW4JqHy0XWa7GG9BCo+YNzuVYce4cKkB+HUfkOnNFdG3kF5WJSSZfq0SHohQLd9DLCDf7EE5osVuUyVgb57hI3QaJzAIwrUgWa7YGW7aB9ua2EaV3Q+WN01LcnNcyoHAY3brSqtxWrZhOUOEYxPOjT5H7SsrrXrQn30Os/rFl5JBaqYu5w5ph2Cdfy3g1SI5Ol34W1qgo04yJOW+7pfR8L4qAQ9Jg39xwEDdHKRuwXWbp2ODRk7iGJ1iH6nGQ99KXEApPGZQxxXhr6VAY+dG1oQyykGLgepppUnycZj98c8BaRfWBvsNROAsq1tjW3sB7shsh2i5tb3yXDUFviHdhizjToAgBTVRB3ouBpC8fAChr2z8glXU+rIntPqX+4lwcKIzc8lC0ZgIdgaPdmTm+o30soamUGat1toXSy5PwsEsuZw7gZzsiw0TYjnWsomFk/vGTiTbx0y8IPok46df0xH/Q53KEuhnZGa0r3cppl7zEy6sFpMFPGxIywYhzQupe1Es+TLKPHZ/V0ODM5+Xv1IhM8LVoGLfff0jMaRENvVSe8buA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(4326008)(7696005)(41300700001)(5660300002)(110136005)(478600001)(83380400001)(54906003)(1076003)(336012)(26005)(8676002)(70206006)(16526019)(2616005)(6636002)(316002)(44832011)(70586007)(40460700003)(40480700001)(36756003)(47076005)(356005)(36860700001)(81166007)(2906002)(86362001)(6666004)(66574015)(426003)(8936002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2023 06:06:05.0284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7e251a-d18e-4b76-cc3c-08dbac43dbac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This warning is for the declaration of a static array, and it is
recommended to declare it as type "static const char * const" instead of
"static const char *".

an array pointer declared as type "static const char *" can point to a
different character constant because the pointer is mutable. However, if
it is declared as type "static const char * const", the pointer will
point to an immutable character constant, preventing it from being
modified which can better ensure the safety and stability of the
program.

Fixes the below:

WARNING: static const char * array should probably be static const char * const

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 458faf657042..5c85ac34360f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -6454,7 +6454,7 @@ static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
 	return ret;
 }
 
-static const char *vml2_mems[] = {
+static const char * const vml2_mems[] = {
 	"UTC_VML2_BANK_CACHE_0_BIGK_MEM0",
 	"UTC_VML2_BANK_CACHE_0_BIGK_MEM1",
 	"UTC_VML2_BANK_CACHE_0_4K_MEM0",
@@ -6473,7 +6473,7 @@ static const char *vml2_mems[] = {
 	"UTC_VML2_BANK_CACHE_3_4K_MEM1",
 };
 
-static const char *vml2_walker_mems[] = {
+static const char * const vml2_walker_mems[] = {
 	"UTC_VML2_CACHE_PDE0_MEM0",
 	"UTC_VML2_CACHE_PDE0_MEM1",
 	"UTC_VML2_CACHE_PDE1_MEM0",
@@ -6483,7 +6483,7 @@ static const char *vml2_walker_mems[] = {
 	"UTC_VML2_RDIF_LOG_FIFO",
 };
 
-static const char *atc_l2_cache_2m_mems[] = {
+static const char * const atc_l2_cache_2m_mems[] = {
 	"UTC_ATCL2_CACHE_2M_BANK0_WAY0_MEM",
 	"UTC_ATCL2_CACHE_2M_BANK0_WAY1_MEM",
 	"UTC_ATCL2_CACHE_2M_BANK1_WAY0_MEM",
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 63f6843a069e..e7ae37233234 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1548,8 +1548,8 @@ static void gfx_v9_4_2_log_utc_edc_count(struct amdgpu_device *adev,
 					 uint32_t ded_cnt)
 {
 	uint32_t bank, way, mem;
-	static const char *vml2_way_str[] = { "BIGK", "4K" };
-	static const char *utcl2_rounter_str[] = { "VMC", "APT" };
+	static const char * const vml2_way_str[] = { "BIGK", "4K" };
+	static const char * const utcl2_rounter_str[] = { "VMC", "APT" };
 
 	mem = instance % blk->num_mem_blocks;
 	way = (instance / blk->num_mem_blocks) % blk->num_ways;
-- 
2.25.1

