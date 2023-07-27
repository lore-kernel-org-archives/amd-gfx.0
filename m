Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A5AC001E0
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 14:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 037E810E595;
	Thu, 27 Jul 2023 14:37:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D491410E595
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 14:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmGnZ7hNJF4Y4Wa5GtTOMzlcfkRZy3TpiLOXu5kLaWSw8exYaXcebn3/7pGwaXc+5eVtjXHbGgKM7w95rVkK6wSYl9RpbTLwkH3CcVAvdAsCiw19SQcFAXFfM8CAdOsZhFCErXeNhlo9YNRwn0eYoNfd6A0adh8OEbpBc/iljXXAqRuoBPHam9Tj05xo2SYF/9iiBzWu1T7zVbbQ5Ra8C01yVSZn/hydU945PfstzqA5R35pg/G9cjfPlgKj8n/QjgYdpq04rxBeOO50XmudKl0JH4e6TSzvXJgrugj9kazbxGf1c2uI7iXvSqNcXxTpcKrJy8YPHekBVBJuXmXvAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHWtcP/u6uRnwXTyUo8cmGVkxUCs0aQEZjFQP8FcDKQ=;
 b=CqjQQFyCFcZyynWzY10CN2m5bz1DZZXOYiYavVCq1ddEzKa3iIRX6FF7n6Ygr4NtOVRzt32NU2d5/FcA/3XcREWBGgmY0FiuOoeQFT4q0uuP6ZXtdZ1ulE3XVUmTJEjORL3SGWf8gMo4YIWzljSEFHHpRMXzcajMvF+bRlzmcQgCjPdlsG73mQjJHLg3PD56Y0JREqIZwXFokd1hkj12+m9wPhMUAvz76VJzAz/IP1F0rVseMYug0BZxSoNnMlnLVqsg/mTKTzZbQgzwQfH3TNlODZdrTgAVUP5Yx8F/9r6xBJzqGQm6jxjQ7tKPInZu5GKjlN3mUmUo4je5vfLQsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHWtcP/u6uRnwXTyUo8cmGVkxUCs0aQEZjFQP8FcDKQ=;
 b=z6yNdm91FKw2gg0K4GuOeGDSds2it4s3ZWsMcscJVNQ6BWypypYNnxk5cnyfyul+IHAz9wlqeVrGmWRq4/ibmUcIzwEWx+TMzeNiQsscVpKSXlInokHAlkW81KWaGhTDJB6qfuQbFYrYSR30n/zryuCNrD7TiekA7eV1XrHLRcQ=
Received: from DM6PR02CA0074.namprd02.prod.outlook.com (2603:10b6:5:1f4::15)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.29; Thu, 27 Jul
 2023 14:37:21 +0000
Received: from DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::22) by DM6PR02CA0074.outlook.office365.com
 (2603:10b6:5:1f4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 14:37:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT108.mail.protection.outlook.com (10.13.172.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 14:37:21 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 09:37:19 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Clean up style problems in mmhub_v2_3.c
Date: Thu, 27 Jul 2023 20:07:03 +0530
Message-ID: <20230727143703.2579001-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT108:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 2123e646-f0af-4ba9-4f3f-08db8eaefc89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9fV92HfLLAV3W93zHPdWFgAzzGKVcW1fUzKYafVMf+IkmHhtZLG68t4XBzhFQY83sqrVBuT8Z66WWj8MygyjtVKVwgLXa7E5clMRGA2npkmyy1PdqBel7SOCSfKKp93r/RuG+NulsIX/H9ncn89L2RNinZzkLD5M54cIlSzeCZzwoWfQvVWtcyADtqNyliZ1fCIhDVunef8DuyVSo5wZMChFa1kYdYk3sFUy+Bnk5AI5Z8TJQ7L9JZTHf6q9PvA4S0DBwHQsPNVMP2KZSpiZuGliIdG/lABHpl6ZWDmX1Rn6eIfuIZEUf6zODhGbDpRU0ZnwKu5rkVwj+DrdRMgxhuD/YaSn525p4Lek5q8SbFyAomKAPuaGSMMx4y6Hw+RYsCndurwD97GDnprIt9YNj533far4ZhtwjGLKpEunPxEqo5FMynNmdJebyaIt6gayWPY5EM+2BhTKrv4iEsHkpBIaMkguAtfUVJD8n3zmGU6jlkIqg5lO00bby4cVQuZ6695B0E006uJ0UmHi3xyfMsDQYP4y4qzO+G3jlCLIHYMIQWPZb8/xfrdEhBM0mkWPKLhzwu/HKBBqcKa7eC8V8Ra3hNdbFPCRge2zV/Q/l5vujHtEbC6/QFZJcq08bo0se/Z8iK/FDcY959R8Dh1p6e8y4xkqlowJc7pssC4N8reVO3ffu/NW+ia7mu4EOkurz+szZNmXvV7pMJz65IsYo23bk9cKILIQWoQaTsq1HhuzfjOvfU+9grB99nhAhbUN5Kn3MNuSjwZQNC/RqrWbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(8936002)(5660300002)(8676002)(41300700001)(44832011)(316002)(6636002)(70206006)(2906002)(70586007)(6666004)(40460700003)(47076005)(36860700001)(40480700001)(2616005)(1076003)(26005)(110136005)(426003)(54906003)(86362001)(7696005)(66574015)(478600001)(4326008)(82740400003)(81166007)(83380400001)(356005)(336012)(36756003)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 14:37:21.4430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2123e646-f0af-4ba9-4f3f-08db8eaefc89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following:

ERROR: code indent should use tabs where possible
WARNING: Missing a blank line after declarations
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: suspect code indent for conditional statements (8, 24)
+       if (!(data & (DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
[...]
+                       *flags |= AMD_CG_SUPPORT_MC_MGCG;

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 8bd0fc8d9d25..1dce053a4c4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -331,7 +331,7 @@ static void mmhub_v2_3_setup_vmid_config(struct amdgpu_device *adev)
 static void mmhub_v2_3_program_invalidation(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0; i < 18; ++i) {
 		WREG32_SOC15_OFFSET(MMHUB, 0,
@@ -406,6 +406,7 @@ static void mmhub_v2_3_set_fault_enable_default(struct amdgpu_device *adev,
 						bool value)
 {
 	u32 tmp;
+
 	tmp = RREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL);
 	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL,
 			    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
@@ -499,11 +500,11 @@ mmhub_v2_3_update_medium_grain_clock_gating(struct amdgpu_device *adev,
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG)) {
 		data &= ~MM_ATC_L2_CGTT_CLK_CTRL__SOFT_OVERRIDE_MASK;
 		data1 &= ~(DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
-		           DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
-		           DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
-		           DAGB0_CNTL_MISC2__DISABLE_RDRET_CG_MASK |
-		           DAGB0_CNTL_MISC2__DISABLE_TLBWR_CG_MASK |
-		           DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK);
+			   DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
+			   DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
+			   DAGB0_CNTL_MISC2__DISABLE_RDRET_CG_MASK |
+			   DAGB0_CNTL_MISC2__DISABLE_TLBWR_CG_MASK |
+			   DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK);
 
 	} else {
 		data |= MM_ATC_L2_CGTT_CLK_CTRL__SOFT_OVERRIDE_MASK;
@@ -593,13 +594,13 @@ static void mmhub_v2_3_get_clockgating(struct amdgpu_device *adev, u64 *flags)
 
 	/* AMD_CG_SUPPORT_MC_MGCG */
 	if (!(data & (DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
-		       DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
-		       DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
-		       DAGB0_CNTL_MISC2__DISABLE_RDRET_CG_MASK |
-		       DAGB0_CNTL_MISC2__DISABLE_TLBWR_CG_MASK |
-		       DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK))
+			DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
+			DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
+			DAGB0_CNTL_MISC2__DISABLE_RDRET_CG_MASK |
+			DAGB0_CNTL_MISC2__DISABLE_TLBWR_CG_MASK |
+			DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK))
 		&& !(data1 & MM_ATC_L2_CGTT_CLK_CTRL__SOFT_OVERRIDE_MASK)) {
-			*flags |= AMD_CG_SUPPORT_MC_MGCG;
+		*flags |= AMD_CG_SUPPORT_MC_MGCG;
 	}
 
 	/* AMD_CG_SUPPORT_MC_LS */
-- 
2.25.1

