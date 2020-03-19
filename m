Return-Path: <SRS0=hs5v=5E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBE6C4332D
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 10:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2959C20752
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 10:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mdp49oFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2959C20752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E30A56E12F;
	Thu, 19 Mar 2020 10:51:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B0846E12F
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2020 10:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCGKsOOI1UkMrPRFCoxQTdzF4pVdUkGY72+G4f+0zo4LVU3zynvWWrqYPumz25kuPFTTinSo4aGX2Ohs9z9JhL2HUjhkK8r9oNyiiDHAxciQxzzrVSN0ElGOPaMZzd2n2Q8fBeFtqaClCFGvjhBVwbMm1+N+dTOWJ6LiNYET+9XvDHw/8BOlkrtU0g3radikkFcclr4SwwNRctKY1TfdT1cqsBGfBYhwrZ8ZuZWwwS7xmFEmIwdsnvDI1BxHNOMzsNOe0QzGt4/MjsP33oQhb+IfyGanJMh+ZWqI4qXuZjrhJMknCN/XNY5cnfELNgCQ+fUWyw4VSJmxNDIjOPA9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzmolpLnHdmrN4G8869Nr6Z7Qmrw9rVGK9QbYqpYO1E=;
 b=EjdYgQTK4NqDKQX83D4DTp3CGc6/g6qJ95gVrsXe5EWnegu5H80w11O+4qt5UI+5lOvtgn6qaqvuo67giIdosTgExTMS/TvcRxNCFGsKW1bibDHv2vnV9JJgjLJMsL+m/fyocok6QAs1kT8yRrZuHwnJxHtQP6Xc/t9tLgQXB1VevohyIgX88te7blW8M9oOHMXI/gHCCBAeA7i7LhyO5e66mXSk8l8NxN4KJUuJBfy8NDdo8fBAb7hUhlKKz6ZrhiQ5oz6xE40sda5kigqkkW+4YhKHpAEadcIfDmPaWjUzhgJp4z+okn5z9EwZXMinhsfwujx3BwIBCBgayzsS0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzmolpLnHdmrN4G8869Nr6Z7Qmrw9rVGK9QbYqpYO1E=;
 b=mdp49oFJvnhqHryniSH71+5Lt0DLVTi+237zTH8cR6tpFFbWekDHUp8z+ZLEUn2H39oLRa099qnhuC7jEqTmcsR46C5q/tG7N7giRiD74yrUv6EOOecPLIl3Ea8zaSSSXj543LmsuZZtdoSQLNpJioMeqjr+2ELPo4EDMmfm9xw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Thu, 19 Mar
 2020 10:51:52 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 10:51:52 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: correct the bootup power source for Navi1X
Date: Thu, 19 Mar 2020 18:51:32 +0800
Message-Id: <20200319105132.22561-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HKAPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:203:d0::14) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HKAPR04CA0004.apcprd04.prod.outlook.com (2603:1096:203:d0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.15 via Frontend Transport; Thu, 19 Mar 2020 10:51:50 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1edd513d-8082-4b59-f1e0-08d7cbf38811
X-MS-TrafficTypeDiagnostic: MN2PR12MB4159:|MN2PR12MB4159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB415950CFE9307D8156961FFBE4F40@MN2PR12MB4159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(199004)(316002)(81166006)(81156014)(8676002)(8936002)(4326008)(52116002)(36756003)(186003)(26005)(7696005)(66476007)(16526019)(5660300002)(66556008)(66946007)(956004)(44832011)(6486002)(2906002)(2616005)(86362001)(6666004)(6916009)(1076003)(66574012)(478600001)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4159;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWDt36MxaGLy6bmEGO1mJzBMlvOed9GGzIsCKEHI6ZLNYaLRz8r26GV+V9cKzbYogqudKPki1yzYRgJ6OMU8ASHheXzYqHcxMHVgm8mAHLVdCd/60DMUBg1RDliYSWa9ctv6upQQVSkSOBwCmagJJ3TvffbB6KLkHackPGbIx6n9qjI8rWMovqorHuyzWcbb857MR8E82bDslx8cuR3kbhPnX+Dxc3yVkgnoHz7NMA2DjgJP99ANcP6S0lRvXzL1g6OH+fr8X4E6pIRO478QXRJBAvxQoyfvHbhvRiD4TPx5bSFO2L3djY7jJ2dFK3xcDLb7PT053Oc5gxGJog4NLdZBVH4fSU/wcE2ngvTGckOGeC16DshqeMGsY7cjAY9gPPXde0Vz4R4eg5X0Ii5+rphBaTs4auT6EyCDv80YVo1d8hPO5LXYG41Jxl5ihXgEfbI+KDF9neQv4TLwmRQ6l1h8Pv4eGTbsjoFjKFcNhCehXroF0nhoLLkbiAhLr2nq
X-MS-Exchange-AntiSpam-MessageData: HXC6N/cxfscjWJvA3ev1JecxpXzK266i4GZa3ugB//dz3GybD/cunFrtlmut3CFMFONuaZOorO2zDC2UXuuvsNvoTh471Ph2Skf2DJY1STX5lLrKJq9JL+RWjOUOv1axNFUlWz+qu5wPlg7fdaRY+A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edd513d-8082-4b59-f1e0-08d7cbf38811
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 10:51:51.9691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmL6KOsmJ5/053yE93q5QEDQx8eBRBdF+Zw2PcAWv9BlRjBu8eKtypzZ3v0vQwf9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
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

PMFW may boots those ASICs with DC mode. Need to set it back
to AC mode.

Change-Id: I56ffd0e747f778aa013da43a8693ddfb5da31e3c
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 15 +++++++++++++++
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  1 +
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c     | 16 ++++++++++++++++
 drivers/gpu/drm/amd/powerplay/smu_internal.h   |  3 +++
 4 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 3f05921056ec..64041d90ddee 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1144,6 +1144,21 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 				}
 			}
 		}
+
+		if (adev->asic_type >= CHIP_NAVI10 &&
+		    adev->asic_type <= CHIP_NAVI12) {
+			/*
+			 * For Navi1X, manually switch it to AC mode as PMFW
+			 * may boot it with DC mode.
+			 * TODO: should check whether we are indeed under AC
+			 * mode before doing this.
+			 */
+			ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC);
+			if (ret) {
+				pr_err("Failed to switch to AC mode!\n");
+				return ret;
+			}
+		}
 	}
 	if (adev->asic_type != CHIP_ARCTURUS) {
 		ret = smu_notify_display_change(smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 657a6f17e91f..323e7e61493b 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -570,6 +570,7 @@ struct pptable_funcs {
 	int (*override_pcie_parameters)(struct smu_context *smu);
 	uint32_t (*get_pptable_power_limit)(struct smu_context *smu);
 	int (*disable_umc_cdr_12gbps_workaround)(struct smu_context *smu);
+	int (*set_power_source)(struct smu_context *smu, enum smu_power_src_type power_src);
 };
 
 int smu_load_microcode(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index d66dfa7410b6..45d46c38f7ca 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2275,6 +2275,21 @@ static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
 	return navi10_dummy_pstate_control(smu, true);
 }
 
+static int navi10_set_power_source(struct smu_context *smu,
+				   enum smu_power_src_type power_src)
+{
+	int pwr_source;
+
+	pwr_source = navi10_get_pwr_src_index(smu, (uint32_t)power_src);
+	if (pwr_source < 0)
+		return -EINVAL;
+
+	return smu_send_smc_msg_with_param(smu,
+					SMU_MSG_NotifyPowerSource,
+					pwr_source,
+					NULL);
+}
+
 static const struct pptable_funcs navi10_ppt_funcs = {
 	.tables_init = navi10_tables_init,
 	.alloc_dpm_context = navi10_allocate_dpm_context,
@@ -2369,6 +2384,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_pptable_power_limit = navi10_get_pptable_power_limit,
 	.run_btc = navi10_run_btc,
 	.disable_umc_cdr_12gbps_workaround = navi10_disable_umc_cdr_12gbps_workaround,
+	.set_power_source = navi10_set_power_source,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 6900877de845..40c35bcc5a0a 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -211,4 +211,7 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ
 #define smu_disable_umc_cdr_12gbps_workaround(smu) \
 	((smu)->ppt_funcs->disable_umc_cdr_12gbps_workaround ? (smu)->ppt_funcs->disable_umc_cdr_12gbps_workaround((smu)) : 0)
 
+#define smu_set_power_source(smu, power_src) \
+	((smu)->ppt_funcs->set_power_source ? (smu)->ppt_funcs->set_power_source((smu), (power_src)) : 0)
+
 #endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
