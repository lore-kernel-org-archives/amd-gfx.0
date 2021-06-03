Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236E2C47096
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 04:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7AD613D7
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 04:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7AD613D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66ED66F395;
	Thu,  3 Jun 2021 04:56:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEA4D6F395
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 04:56:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mklItEMML2SlFVy9CUCamlpB0E7paPCwmeiA3qqwJFLYwR7nA6La6+riAGrzOBzQFs7TBkq0A72Wt2ZbTUcOUemBcsHmrcxsInVe+rD7Oz2VXqiX4hwySmTxPljFMHsqvxcWnR+kbdImM0JTnpGh83Z0o6U3VmsbFi0f0Aw40f5YHEyFK4zWGsf6jXSWkz+hsiotka89I1eec/keRjuAS7DkMLdprf/C1vSWzVwhAZ6JHy9wuifHTnpiWXLz4CfOTUETi22DQqt24Ulbh3Ie11ozl0PRVYXiMFiE6/F9UmZ5TbFUDmDlKBI5HcufLV/Vubl5/N3YXvOWzSF4v/uPXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCkCzO3pJpCjAalgftvR5uqGzngXIUaNuUEiX3ghhiU=;
 b=ko3qrBv9j/PRi7SkFe/0cbSJcvRrnCE1rTjEOH4xWikfCrnTvANINzDzuk+w0PMqN7bWPZwohbKj3Cb5rOc2NVHFczRCDoOGc2R/dvr2SMEaz/X95EdNB8OG+lZljnAszIHtvXN797Zum9rXd42DiK5jKkWqL9G1EUl4n5oIEpmhLSdAa8st+/y77CuM3+ZUQblMfXGkJGdD3zYM4QsyKuzBVh7LLMth+R5kfGJA4at4Udv85z6oKS3CfkDypJ43VV6hAox8CG78Werds76NSi5B9PmjrFzVW8BeMyJdgTa5FRjHnLfVlcWl7VtPkbuXZOAdyHZo/unSTuKZmZml8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCkCzO3pJpCjAalgftvR5uqGzngXIUaNuUEiX3ghhiU=;
 b=Nr42sn4MdihuehNxNdR1RySD3KwuM5Utw85pju5xmow3izk2JcUq7m29HtEcsGiyV3HKgkBJQ6jdVoAxYZNlx7lcWgo+dPlfQlw6CnK+uKteQqXzNK/7GcORMn7wdvc2YSLHA31FnFv9OdiX0/aj41M4w6NXtscHTr6iviZiXDI=
Received: from BN7PR06CA0039.namprd06.prod.outlook.com (2603:10b6:408:34::16)
 by MWHPR12MB1421.namprd12.prod.outlook.com (2603:10b6:300:12::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 3 Jun
 2021 04:56:23 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::94) by BN7PR06CA0039.outlook.office365.com
 (2603:10b6:408:34::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Thu, 3 Jun 2021 04:56:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Thu, 3 Jun 2021 04:56:22 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 2 Jun 2021
 23:56:21 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amd/pm: drop the incomplete fix for Navi14 runpm issue
Date: Thu, 3 Jun 2021 12:55:59 +0800
Message-ID: <20210603045603.977998-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc371033-4f14-4bcd-3af5-08d9264bef2f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1421:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1421E7169AC93D2BA94BD321E43C9@MWHPR12MB1421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WnaMGRtCtXfBrIHflTMcekihLEX68BKe9ZDSWL41oSIPH7W9kFNyWSl0utTp4cLGADgUa7U9XE6Y56UDzN0y+GeXTjJt+aopLXNF/kYMDxBylUh5xBhTHxtrwVEGCxW6gOIbh66uxUAq0rhjTQurFOggPj7KRoWQuBKw1NVMd/mEwd3sEBzODrnxs5TOvxIAXNDL+JQ+vPdtRfy5sAoivopUKaOcJdsj+I/FEP2AMyNlkze154H8jW2JeR5x57pa5rUS7XDTTovtPxjzfvL/B+RbXoX+w8whNzIzhuH9vIAX5lvOaOg+4ppXrU+3xuhwI083UNFMNLdpAkwCtuxnskmrOkrDygDpWIlC83FqVyOTVI1to1UxB7lBJ0N5OQV4/du7GKEz9KtJQ78f4gMBZFxQc4sdRs/aYifB78BwMeZYRQO4eB/DfQSbCQeIy6UEnbcgASVXJAhdvbachKnhf06ptbE2vct4Fl7Tp88X42iiqB2Ik3bgc/tuL96+lCu/2sO9akVL9IHP3NQU5CgBd+AAi3BwrdRm4VxqBXPSM+WeOau1MbQf+ca+jv2OGQuJaUou/D4PriijnSHDqJaAZ0Kd00N9zscrbQIrTFPpT61pdFbX5FtDcdECzdlilhUFd4ytUUHJbI+vLuVet6iZk31/AnfNWtu6W2jSItkrUgWvSBFrZ9m14ZqxLSzG5AeQEKxpZCkV0Y1SZElQakdT1ttFL81QASxqqCKC6ldNpi9LT4Q9849tHTfHDas4BbzLkiHxluYzhfUcvubExMpCzEgDdfvyXsdCAmPMiJWteJcJMgaUQ5YAKZ7EPo2/9EqS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36840700001)(46966006)(4326008)(6916009)(8936002)(19627235002)(8676002)(6666004)(478600001)(336012)(7696005)(26005)(426003)(44832011)(2616005)(70206006)(2906002)(1076003)(86362001)(70586007)(16526019)(966005)(81166007)(5660300002)(36860700001)(316002)(83380400001)(36756003)(82310400003)(356005)(82740400003)(54906003)(47076005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 04:56:22.6448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc371033-4f14-4bcd-3af5-08d9264bef2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1421
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
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
