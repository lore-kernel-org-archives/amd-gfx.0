Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DD5C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 04:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC81161249
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 04:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC81161249
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FDDA6EA96;
	Tue,  8 Jun 2021 04:34:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11FA56EA96
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 04:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bN1wqBcbj/vRUBR/+j2ALII9VfpZDorUdXAMJ8zxNvmbJz9xh2RUqOCiuuD2wc9YDhajWu5Ogkus+lUw0BSE7+s954B54D+BMFgd3NMreJM6oe30s4jTnr7IntAHfz9RDyNlBM9WGtyJDjRpOIR07Zc478O4gnnHBLltq2VuLLNY3XmAcPFHRqftPHLxZkNuIonkDnA78TI/2Zw7ZSJSBiYDR8WrEnA1GBosd14l1fE5eRNevkGekqCNeWH/KxHuUAAmLmk60ip+Cfdwq8UrsAM7dXRSC/IRLZCVdV+qBeGTnnK5XCjAIHUFRrZU9zuqv79tzBMKEsQAxUJjWQf4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxVdNRU7VFQ23/MJ/u11kd9UP3SKcN05SFupuNsTHzY=;
 b=TYNYSQiR+ST+3RvvZUzzJQPnELOd7B4Dli4jGSahtIALlYmfqFPyrV854t+MugESdaf2zs/2PhBoNGgkCxTyjqyk91w9emc/8tmiib+EWEvC1aCeN2FJftvx2ZT+ztguSefVFbfRR/yft1TU6/Z3BYR2ATMlnGJqoHhVHFgYTC5DBbk0ZIBshkmboxP9PswyXZCMhwV8a90GuDSHr+0AtR6jfE4XZuGEYVd/5W8TH7BQ024bE9+NzKxkeAKu80pEsrFjDuFe5g0GWE0pdaX6PIzyQ0ls1BSj0hxhydKcugh/kO0KIZ9iOh2wh32HqLvgfaSUbHuxx+nyTZKR7qOrGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxVdNRU7VFQ23/MJ/u11kd9UP3SKcN05SFupuNsTHzY=;
 b=y68R0pjakGjNxzso5ypk9S7xw7x6UssjkGQByqTo/ihOB3WKq+dtmP+OH6jrBkkAWnKmjSbwMwR2ITBD+NnS7cr5VaiF6BVWW389GqAVdpPV/5gZJP0K5wv3YWv9EIkdG6DCio6KoayfIeCrraII5nEhhnaPt9/hKxcebNPTAAQ=
Received: from BN0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:e7::10)
 by DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 8 Jun
 2021 04:34:48 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::c6) by BN0PR03CA0035.outlook.office365.com
 (2603:10b6:408:e7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 8 Jun 2021 04:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 04:34:48 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 23:34:46 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 1/5] drm/amd/pm: drop the incomplete fix for Navi14 runpm
 issue
Date: Tue, 8 Jun 2021 12:34:27 +0800
Message-ID: <20210608043431.1855151-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f53b176-95f8-46e5-5027-08d92a36bfa9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4958:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4958507AE7BDC937D871B589E4379@DM6PR12MB4958.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83lQp+FD5p5evywZy7aMwwyQSGX1K2bMSjwcU8D5StiUlibWoiMuF8OCeZyqTQ3gl8O2vxHNBC+9KjNKdgJhpf8drG34Gp0+K2Jw2rqJhY9Q7KW+bl2ci8tV3hXrXaRaT/KIBVnlKdodf8tQhkfAFWn1VyzdXN5/KBch0/p4S5Ri4YPjMpXnmd9n3UO9qBNgZ1hQj88KY2MTioz4UrwfU9QfeSsnp4v6jTX7lrwFJsF9N9s5F3DZpe8XC0U9TfoANp4mrvzjZ82k4SZ+JCvuQgxHDmXzJf/c7bC0Vqdj5zGX7rwG7O0ChjHpWmC0EttGyvJb4ywMZ85KVzTCqXnK7cjDBDyIJQodREyV7xXrsabvr5VFAdB+PACR9mV8FhN8u88/8xC7BHKYAWlZqNosTZx7NsORw6f3DeNygiVsWIGis4201rCYWNykPvJiqAigiFMV3jtJPhKeQT3uwuULrA5/FH7ow5pklYEWy+qWDdPf+UAgti5P3zIb2HXoLNx8TUVxyANF4FWOtft1FqUZny5vWdKYGSp6nKG0xTTGN0oew2GFP1qGdXEy1/OCS6BpeNKlKxDvoqByg9wORnPWeU99Xrra30EGy/UfBn8QYa9v+CQ5bbzE3DeYoY7j5UOlYDQ4wOTH1fi0kFmsPIHnXyMHcet6jUdTA4uFLM8Zs6QEWJ0ArDv1otglc40RnW1Zzy3WganJRC2uEu9ugUW09irfkIxmvrTw8tGfSaP1lJyRG1u6yDwm9SoHVSdWlbjfjJPzQFfAUaasAIBUrk5yT6w3LJ+9CJrh/QG778U62DL/tdX79kvSyylMVqCLeQ/0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(36840700001)(46966006)(70206006)(70586007)(81166007)(8676002)(5660300002)(83380400001)(7696005)(54906003)(1076003)(6666004)(2616005)(36860700001)(8936002)(36756003)(86362001)(336012)(426003)(356005)(82310400003)(44832011)(16526019)(26005)(966005)(186003)(47076005)(6916009)(4326008)(2906002)(82740400003)(478600001)(316002)(19627235002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 04:34:48.1341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f53b176-95f8-46e5-5027-08d92a36bfa9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4958
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
index 47ceb783e2a5..0e632eda4d10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2180,10 +2180,7 @@ static int psp_load_smu_fw(struct psp_context *psp)
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
index 695c65767258..267fbbdbff94 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -446,30 +446,6 @@ static int navi10_store_powerplay_table(struct smu_context *smu)
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
@@ -3122,7 +3098,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
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
