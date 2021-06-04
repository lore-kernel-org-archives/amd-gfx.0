Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5044C07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 09:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7880961418
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 09:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7880961418
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2496F5F3;
	Fri,  4 Jun 2021 09:59:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A008E6F5F3
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 09:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVJ9H8N4rzlC82vI+dGB+bKIkg8g08fDnQNriZASAR7+dxlzm3RXwu9z8JnwuhB5gnhyV2MAO9aS0nJ9+tcj5g97Kc83+JeTO86aHs9FWnq5Tqw20Szc86bLmc1ZIXL/ZOmSltdEAbFGFqF2ObkbZpVIROghZT1ybMnrthV9m/Lbut0JbDtR7mxoyoigRda4B6uGDYCiduL7KeRQzos5Fy3TsMZXEecoIcZ24kg0KYyho3V8LDqQbix+cauxouDD7ji6BdnMtpGOpDRldYC8yAJcA7Io4MWXappVAgtsHjejzUDWfmqhXfoPpXU5YH8QBV87ugxCJGvJT6yyrPZOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCkCzO3pJpCjAalgftvR5uqGzngXIUaNuUEiX3ghhiU=;
 b=nT8JgNXmFyhksAjsUBIulZ1HVqmGiXwpHWTOm2oZV5oNJoA4ks6RE59TI/QB8YEgZptDGtj+5/xtWWVHxdqlC93LDoVPTU+hTPYKvuj1385BDW97ySwHXl8YkToCWT/VRIqya+z0d1QpAUr9x9jaBERQ/ALYRBA0uY+OfO1dQPBGwKwTT9YCkMVHKnKdG1bUX5WezeNeqYNgmSy/a9MMv24T3y78HhjZEf+NMsgtrBLV5XknXpSmAybXVlFe5lZ33JclzjEjTfgW9TqtHkPkAd6bmqEqdWyQQIglkNP9ONAYThCooWYLKJa2kcxfQ2SSUdXYd3mLGsjZF8Nz0pi7EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCkCzO3pJpCjAalgftvR5uqGzngXIUaNuUEiX3ghhiU=;
 b=tT7qi1K5vbvBU7X7QTg9CQiEjnJS9ceeDQXIYSqexFnoLjHzVV9Wi3Qo6wCrUtEzts9LZt8jwpsjbJQIr2QnXrignRH15/Q6zxJObJH24pJuBSn2IyZjgAdtqPQFfb3UdUzrnTQ+gcSr8k8oVj0qY+aE10wraVyeylZ9l4Iuyjk=
Received: from BN9PR03CA0980.namprd03.prod.outlook.com (2603:10b6:408:109::25)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 09:59:03 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::9e) by BN9PR03CA0980.outlook.office365.com
 (2603:10b6:408:109::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24 via Frontend
 Transport; Fri, 4 Jun 2021 09:59:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Fri, 4 Jun 2021 09:59:02 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 4 Jun 2021
 04:59:01 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 1/5] drm/amd/pm: drop the incomplete fix for Navi14 runpm
 issue
Date: Fri, 4 Jun 2021 17:58:19 +0800
Message-ID: <20210604095823.1403271-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b384386-54dd-448a-77f6-08d9273f61fb
X-MS-TrafficTypeDiagnostic: MW3PR12MB4411:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4411E5C543E171F20BE2BE12E43B9@MW3PR12MB4411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rjlm+lB/ydJ09uXWOwU/eXrk7S+JzipnRNgiUURHWQ55b1k7vzbyu0mSqhOI2teUW++mKfjOqU8/uIa7YVzcvUp3MhwfrUFSQ49E53d9++ptHPHxhvHTE8QLn9ObNp2iP+nk6O1hKBnXvEnTyWku5C9RH1ps5MZgqINAwvyo+h/G+TJKdeNzAOAAWwYj1QKU5Zj5AIj9wCi2L09liu/vZDLRIsDutunX6SLKJZ6u2IWWQFXR5qxMZSnrCn+XbZc9iTeASkv7F1JZx6AI3azMODlyWfmqICt729YhkJbLWZ7etinv/GPk7H9xHsr/9fZGlAwSNsUrvH28CrK4FkZEVTgC8wjDaBJaubBnMBJun54mvmsB4tL3zO2OHnQT+9IHK5v/fjge91yh5U+biYCRFLoR+OteZfjH4yF7ntUVSNcMqd4ZQnbakd5/1FAyN1+jH10Ie/MevCArCEizwWcetoAT5p64PJxf3TQJ1hlytQSgadkn8CZc5f5c6LKmLTQbVdZc/ZCNZPweQX9nWbV6qTiAt39sBqEhXi7LHHpcx3k5FbZD7f+NU/K7p9jo+5i7I38uqXjODB3uZUWJW9w4MnKNAy1SBcYXK/qxFrzrxo1u8FjNlXYg9K5sjcPwkk0r0fXYlHuof58gvchvkjQwoIq/oGGWd9eEmupdkaxiNZuQdePELQB+CzdHZjGTgAOOQQbO2KzjqOR0U9/l8IY2zxTsqN9aJaS02kj8V911nHptYizzjXvHBYJcGoQ5OE7M/vG3Cmboe+YToKaGDegjaIVTZnjvPWE8jrbN7lBRW/aEnPOaQ2qrWkHr6Za9Qtot
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(36840700001)(46966006)(16526019)(966005)(7696005)(5660300002)(70586007)(36756003)(6916009)(82310400003)(478600001)(426003)(1076003)(83380400001)(26005)(186003)(336012)(2616005)(44832011)(70206006)(8936002)(81166007)(82740400003)(2906002)(86362001)(19627235002)(54906003)(356005)(8676002)(47076005)(316002)(4326008)(6666004)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 09:59:02.9509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b384386-54dd-448a-77f6-08d9273f61fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As the fix by adding PPSMC_MSG_PrepareMp1ForUnload is proved to
be incomplete. Another fix(see link below) has been sent out.
Link: https://lore.kernel.org/linux-pci/20210602021255.939090-1-evan.quan@amd.com/

Change-Id: I2a39688cdf9009885594663cd9ec99d4cfca0088
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  5 +---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 26 +------------------
 2 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 55378c6b9722..09ee34312268 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2176,10 +2176,7 @@ static int psp_load_smu_fw(struct psp_context *psp)
 	if ((amdgpu_in_reset(adev) &&
 	     ras && adev->ras_enabled &&
 	     (adev->asic_type == CHIP_ARCTURUS ||
-	      adev->asic_type == CHIP_VEGA20)) ||
-	     (adev->in_runpm &&
-	      adev->asic_type >= CHIP_NAVI10 &&
-	      adev->asic_type <= CHIP_NAVI12)) {
+	      adev->asic_type == CHIP_VEGA20))) {
 		ret = amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_UNLOAD);
 		if (ret) {
 			DRM_WARN("Failed to set MP1 state prepare for reload\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index d28236ba0018..32a52c1bea07 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -431,30 +431,6 @@ static int navi10_store_powerplay_table(struct smu_context *smu)
 	return 0;
 }
 
-static int navi10_set_mp1_state(struct smu_context *smu,
-				enum pp_mp1_state mp1_state)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t mp1_fw_flags;
-	int ret = 0;
-
-	ret = smu_cmn_set_mp1_state(smu, mp1_state);
-	if (ret)
-		return ret;
-
-	if (mp1_state == PP_MP1_STATE_UNLOAD) {
-		mp1_fw_flags = RREG32_PCIE(MP1_Public |
-					   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
-
-		mp1_fw_flags &= ~MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK;
-
-		WREG32_PCIE(MP1_Public |
-			    (smnMP1_FIRMWARE_FLAGS & 0xffffffff), mp1_fw_flags);
-	}
-
-	return 0;
-}
-
 static int navi10_setup_pptable(struct smu_context *smu)
 {
 	int ret = 0;
@@ -3119,7 +3095,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_fan_parameters = navi10_get_fan_parameters,
 	.post_init = navi10_post_smu_init,
 	.interrupt_work = smu_v11_0_interrupt_work,
-	.set_mp1_state = navi10_set_mp1_state,
+	.set_mp1_state = smu_cmn_set_mp1_state,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
