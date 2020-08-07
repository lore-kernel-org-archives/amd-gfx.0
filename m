Return-Path: <SRS0=Hu2c=BR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31726C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 08:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF01A206B5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 08:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="22xjORFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF01A206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F4726E984;
	Fri,  7 Aug 2020 08:48:49 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760044.outbound.protection.outlook.com [40.107.76.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 248B86E984
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2020 08:48:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONedwEokI6RThJ6HYi/kBUijz0unN1rBY/YWrjOCu0XnQTzkR5nzD67OgimuJbni498a+m4mNi0T6P8o19TWceZqs8B78d9JlsuuwFNZfnvpWuGWfZNbcLAobh26yjXDDdW3l3ZQbH5xAz+MZhgasZ59rRzdG/lAvqyk4MNHe+dNxKzXlXfVFnWShRisv62aotsC6lYPsSLhoU0gQdaS0pd/Y5GPRrpy6GKF2tgw8g66abPK5g7EnQ6pJbNfFYOJZuduJ0noXuL07WsTJ7GT8NYVw6Ws7wOV1uM6hIeB1me/AJ+jKEOjToC8kltYzrI/dj0cTy2/dGjIrssWa+H/vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EviBd3qMUdVm6umsvdbimeQyMHrM89JsDkFVUHKECOM=;
 b=krxEq/lLo4FgIYToXrB4eJbv0oP9/JN/ij0lKajrg9A7lo4m3Kw1WM4dCxHvpJAnTVU5gXOVqEVsXb3zCN3JVr2FXISwf6tUZ1sb5odDX/RInOTL5xg4iHJk7H3VHcp5EEuV3V89V5WKDB7K2Jv3qBXDgdlSIJq9nC38Vyku/7uIVGVxnO3nafX3ArL8rm9bIoH+e0TjYx0/aK0W+gyFj6H5zHtDJiLQu99zvl98vKNzDcQiKRtcwiw8b0bLQ3NecCSmw0vMwcwvB9tW2TXB/id85NrH+ZDUMvKvFc3GE5ULaKd3WrnXTi0ZfF2JGPs+dz5nbWDgO+Ua5TNrhuPIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EviBd3qMUdVm6umsvdbimeQyMHrM89JsDkFVUHKECOM=;
 b=22xjORFbzXLQdX/WOWUhhby5S4RQ7+ecUBrC+J8KfL0Z8tJ4dC4lVQsa4yzrshFQ1I7LPtjICjrkhZJnHZ5PD83tKpiaTj0UDWViAWLs9YSjvZxT0q5cFM8fiSXvxoaVKJRCXmvfCiUvfifax4aWwLjKD1OTAwC8Ls/nzYGdMSY=
Received: from MWHPR19CA0068.namprd19.prod.outlook.com (2603:10b6:300:94::30)
 by DM5PR12MB1180.namprd12.prod.outlook.com (2603:10b6:3:74::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Fri, 7 Aug 2020 08:48:46 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::f) by MWHPR19CA0068.outlook.office365.com
 (2603:10b6:300:94::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend
 Transport; Fri, 7 Aug 2020 08:48:46 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Fri, 7 Aug 2020 08:48:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 7 Aug 2020
 03:48:45 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 7 Aug 2020
 03:48:45 -0500
Received: from chengzhe-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 7 Aug 2020 03:48:42 -0500
From: Liu ChengZhe <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Skip some registers config for SRIOV
Date: Fri, 7 Aug 2020 16:48:39 +0800
Message-ID: <20200807084839.730118-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70c9b5b5-43dd-4318-619d-08d83aaeb28a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1180:
X-Microsoft-Antispam-PRVS: <DM5PR12MB11803562D573009CB1AC1BBA93490@DM5PR12MB1180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:302;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mPR8Olzrhu2PS1gfKAUei9F+D0P51ZGoDr4mvQvluzVPlyrU0E9xHHz1lJ7g0rHLd3lKXZQL4IcowczQsZakFvl5oZG2EkmHzU40aVAiEO03NCUhAfRwuD7wc24Vvqb80s5DZR3QTXUi8ZX+2JMHLA5BVu0gquIcsROixlAKaBENYPSs6uV+8+KzcTscFnV+8xqlnBDXleP3dggPL7xAIgoDI/hnIfVr/OAhX3c/iWrN/doodBbUZoPZe0U4fGSx0EHgHyFJRmC0ARszrMMSpNNwgQZNw9mjwGK+LrzAN69nzCfrSlz+sT+gNDWI3MmPgD2I2zvnjhuU82HfO21FDuF1Bw7qsXjcgIIwu3edPi2j5v97muNJhR0lZarfHZryn8WB+CD4pVCgqk1hicXwsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966005)(336012)(356005)(4326008)(5660300002)(82310400002)(83380400001)(8676002)(8936002)(426003)(82740400003)(36756003)(70586007)(47076004)(26005)(478600001)(54906003)(70206006)(2906002)(316002)(6916009)(1076003)(86362001)(2616005)(81166007)(186003)(6666004)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 08:48:46.5460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c9b5b5-43dd-4318-619d-08d83aaeb28a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1180
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Liu ChengZhe <ChengZhe.Liu@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some registers are not accessible to virtual function setup, so
skip their initialization when in VF-SRIOV mode.

v2: move SRIOV VF check into specify functions;
modify commit description and comment.

Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 1f6112b7fa49..80c906a0383f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -182,6 +182,12 @@ static void gfxhub_v2_1_init_cache_regs(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
 
+	/* These registers are not accessible to VF-SRIOV.
+	 * The PF will program them instead.
+	 */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* Setup L2 cache */
 	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_CNTL);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL, ENABLE_L2_CACHE, 1);
@@ -237,6 +243,12 @@ static void gfxhub_v2_1_enable_system_domain(struct amdgpu_device *adev)
 
 static void gfxhub_v2_1_disable_identity_aperture(struct amdgpu_device *adev)
 {
+	/* These registers are not accessible to VF-SRIOV.
+	 * The PF will program them instead.
+	 */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	WREG32_SOC15(GC, 0, mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
 		     0xFFFFFFFF);
 	WREG32_SOC15(GC, 0, mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32,
@@ -373,6 +385,13 @@ void gfxhub_v2_1_set_fault_enable_default(struct amdgpu_device *adev,
 					  bool value)
 {
 	u32 tmp;
+
+	/* These registers are not accessible to VF-SRIOV.
+	 * The PF will program them instead.
+	 */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
 			    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index d83912901f73..8acb3b625afe 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -181,6 +181,12 @@ static void mmhub_v2_0_init_cache_regs(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
 
+	/* These registers are not accessible to VF-SRIOV.
+	 * The PF will program them instead.
+	 */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* Setup L2 cache */
 	tmp = RREG32_SOC15(MMHUB, 0, mmMMVM_L2_CNTL);
 	tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL, ENABLE_L2_CACHE, 1);
@@ -236,6 +242,12 @@ static void mmhub_v2_0_enable_system_domain(struct amdgpu_device *adev)
 
 static void mmhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
 {
+	/* These registers are not accessible to VF-SRIOV.
+	 * The PF will program them instead.
+	 */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	WREG32_SOC15(MMHUB, 0,
 		     mmMMVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
 		     0xFFFFFFFF);
@@ -365,6 +377,13 @@ void mmhub_v2_0_gart_disable(struct amdgpu_device *adev)
 void mmhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev, bool value)
 {
 	u32 tmp;
+
+	/* These registers are not accessible to VF-SRIOV.
+	 * The PF will program them instead.
+	 */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	tmp = RREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL);
 	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL,
 			    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
