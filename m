Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA1BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 11:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E67B810EA87;
	Wed, 19 Jan 2022 11:32:16 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2077.outbound.protection.outlook.com [40.107.212.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1083210E72B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 11:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdiQaiet7qumgJaOhZjQpGS+WUc9aYHJEQqjGhNR0yDW6KVJsQJqUMQYvyOoqHv7ZTg7yGH/oxeaDyiTCHtkso/uytKpRYbJRwyuRQsGYukpGIXHYIxEMswqKBW1QgWnoHUvzmOtG1q9YnPIhZUX4vr6LxWQHhISw19HuSylEOz0pNopc7CI3hUdC4alcFUzhaE6HlGe4TD2v70cLaPPtPLdqi01zm4Q9yR6AgA798XRj5QJ2CL/QToGxOhX5latycDK5vhrOCClpc3Xb2zUgMebzTuFtw+XixYwxOmY8N5buM6zd09NMdHdlyotmcTR/uo/XmnZgAnGeA3Ya6ecWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsL/IoqykI6plZuUOW8v8CczvvrVAm+q+WZp9NRYa48=;
 b=kZoiMchaJzJRqyYeoMokAAMcoKRY6wqHdhyx/xcdQRUdniQ1LXFablWmnLSTEMVS84CNb9SjpOlIhRxiirPrPx7cIftECEL+3wfZnejkgNtDfSs5sEkWQr474BzH7pS5LPUL6oy+KKvUtBUPlRYL5IkDtfnnGVvd8f3kJ0b36Emhz0ybIpCFL8tZst6hxYSVaunODbYXEtYnW1Rf810TEwy/svL8wOW4JZLtwJ8ChU7i30VDlwkYuikVI74GH1MZWo7y2Ubs//P5b/XM41R6/jibpZXfjKlq9Q9JAjiLt5Sulh0ImjNsVgn4zeWfSmQG2WvkAD96PsjtV2K+dBhd3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsL/IoqykI6plZuUOW8v8CczvvrVAm+q+WZp9NRYa48=;
 b=DwKRNRxXjRJ9eLgcv9SWQ0w1/aBD+N7ILMPwegLpoGgstbgmrwQLyFW7jI/4eXcsv2P35XrIZvE6PnKmfr4CIMXUm/+Gi1xGAO6RMFPX3criMtQRuFnTuxyujrmV0WW168snowqlGuW8cqCfdElxvhVg7rAwo94uCcJw5dyfsOY=
Received: from MWHPR11CA0003.namprd11.prod.outlook.com (2603:10b6:301:1::13)
 by MN2PR12MB3071.namprd12.prod.outlook.com (2603:10b6:208:cc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 11:32:13 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::84) by MWHPR11CA0003.outlook.office365.com
 (2603:10b6:301:1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Wed, 19 Jan 2022 11:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 11:32:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 05:32:11 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 19 Jan 2022 05:32:09 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Mohammadzafar.Ziya@amd.com>, <John.Clements@amd.com>, <Tao.Zhou1@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: remove unused variable warning
Date: Wed, 19 Jan 2022 19:30:48 +0800
Message-ID: <20220119113048.3432-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3453caf-64e7-44b2-0a87-08d9db3f5639
X-MS-TrafficTypeDiagnostic: MN2PR12MB3071:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB30717900DB0CCA3E1DBE2C569A599@MN2PR12MB3071.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5n8SM2QXrEbrPeUHh5ojy13aZGwW6qmawU4VR8kYAsRpiVyf2QbAQ1msyBGIPQP1nLIzBTPxlI7nY6qpSVKi+Q+I8qDehVA82lkAJbxRklACyhk767aMijI7EhJJD1xE3yVYp/sMqypZ/k0HzcZGdwzwPw1fC4Or/OhA0YCtLm2uAFsozGpERTbSpHLmHNC/iiqJ+EbMJScg1k/rsxNgRYIbPYTE5ht7FJD1oZZ6LO0Zx/RCS1lp8eFO8QF7TFhIlTYAM/33LRQ/2dIP8L6UcG/Gae+8kIBnOK/r551KJbQTB4R6WFGhPhZ2ge/GCX+6PI4lcNXDRF44VyvV41ZL4AG1dLC0DIAahggxz8evUzC0kb82sLKrnTRtp3fIuldOljtrpia3hi8QvzOzi3Q4Z37MDfWD0qOnEYdnuLpvxewY5dj/iRDAIWoCijDdIOWb32EuHkFNFJN2iFFzl65IDnQdB7sgdNuXsprfLqcWMYybrAdWI37Sd6elwiEtE8QKWiLm3IhIxR5TqbJF4hKksdTWFCRivw8g1ts5DTwgDEN6ekC4RRfC4qdZ+Wk7UpqkQDgVr2crwqP8Id9pVe7eqUakYihlUTjUyfZNdPEo/X7kxvEYVRXVX283L/PUQgT4cy2DfjIbp2twbjAZWC9zo5TdB0GzHjDn8pX/iPcTy3+igR4XTyQ/WuexJC+zfCCZ/ZwuMblObsr8B71CjI8EZuneSYyp5ftyKsJaOhGAX1Io2X7ZSDZ9gEsXmtHO8824OHsbz9ruAitrZHSheqIgOIk+0SWPHO0Oc0dvT+T9a0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(336012)(36860700001)(83380400001)(40460700001)(1076003)(426003)(26005)(186003)(86362001)(356005)(36756003)(81166007)(110136005)(82310400004)(508600001)(5660300002)(316002)(70206006)(8676002)(47076005)(6666004)(8936002)(4326008)(7696005)(6636002)(2616005)(70586007)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 11:32:12.4074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3453caf-64e7-44b2-0a87-08d9db3f5639
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3071
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change-Id: Ic2a488ee253a913d806bd33ee9c90e31a71af320
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 23 -----------------------
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c |  6 ------
 2 files changed, 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 6953426f0bed..526de1ca9b8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -61,22 +61,9 @@ static void umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_device
 						   uint32_t channel_index,
 						   unsigned long *error_count)
 {
-	uint32_t ecc_err_cnt;
 	uint64_t mc_umc_status;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
-	/*
-	 * select the lower chip and check the error count
-	 * skip add error count, calc error counter only from mca_umc_status
-	 */
-	ecc_err_cnt = ras->umc_ecc.ecc[channel_index].ce_count_lo_chip;
-
-	/*
-	 * select the higher chip and check the err counter
-	 * skip add error count, calc error counter only from mca_umc_status
-	 */
-	ecc_err_cnt = ras->umc_ecc.ecc[channel_index].ce_count_hi_chip;
-
 	/* check for SRAM correctable error
 	  MCUMC_STATUS is a 64 bit register */
 	mc_umc_status = ras->umc_ecc.ecc[channel_index].mca_umc_status;
@@ -110,15 +97,11 @@ static void umc_v6_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
 
 	uint32_t umc_inst        = 0;
 	uint32_t ch_inst         = 0;
-	uint32_t umc_reg_offset  = 0;
 	uint32_t channel_index	 = 0;
 
 	/*TODO: driver needs to toggle DF Cstate to ensure
 	 * safe access of UMC registers. Will add the protection */
 	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-		umc_reg_offset = get_umc_v6_7_reg_offset(adev,
-							 umc_inst,
-							 ch_inst);
 		channel_index = get_umc_v6_7_channel_index(adev,
 							 umc_inst,
 							 ch_inst);
@@ -133,7 +116,6 @@ static void umc_v6_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
 
 static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 					 struct ras_err_data *err_data,
-					 uint32_t umc_reg_offset,
 					 uint32_t ch_inst,
 					 uint32_t umc_inst)
 {
@@ -192,18 +174,13 @@ static void umc_v6_7_ecc_info_query_ras_error_address(struct amdgpu_device *adev
 
 	uint32_t umc_inst        = 0;
 	uint32_t ch_inst         = 0;
-	uint32_t umc_reg_offset  = 0;
 
 	/*TODO: driver needs to toggle DF Cstate to ensure
 	 * safe access of UMC resgisters. Will add the protection
 	 * when firmware interface is ready */
 	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-		umc_reg_offset = get_umc_v6_7_reg_offset(adev,
-							 umc_inst,
-							 ch_inst);
 		umc_v6_7_ecc_info_query_error_address(adev,
 					     err_data,
-					     umc_reg_offset,
 					     ch_inst,
 					     umc_inst);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
index 05f79eea307c..cd57f39df7d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -114,7 +114,6 @@ static void umc_v8_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
 
 static void umc_v8_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 					struct ras_err_data *err_data,
-					uint32_t umc_reg_offset,
 					uint32_t ch_inst,
 					uint32_t umc_inst)
 {
@@ -173,19 +172,14 @@ static void umc_v8_7_ecc_info_query_ras_error_address(struct amdgpu_device *adev
 
 	uint32_t umc_inst        = 0;
 	uint32_t ch_inst         = 0;
-	uint32_t umc_reg_offset  = 0;
 
 	/* TODO: driver needs to toggle DF Cstate to ensure
 	 * safe access of UMC resgisters. Will add the protection
 	 * when firmware interface is ready
 	 */
 	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-		umc_reg_offset = get_umc_v8_7_reg_offset(adev,
-							umc_inst,
-							ch_inst);
 		umc_v8_7_ecc_info_query_error_address(adev,
 						err_data,
-						umc_reg_offset,
 						ch_inst,
 						umc_inst);
 	}
-- 
2.17.1

