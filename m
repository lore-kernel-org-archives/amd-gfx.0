Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3C1C43457
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A84206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Rb/4DhH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A84206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D1FA6EA84;
	Fri, 16 Oct 2020 03:28:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7015D6EA83
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:28:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuVwJpPPGOiSVxgA30VHawidxAs3vuWUBKeG6hZznYAh4m6095JEYq2R9W1HLxArRrDiGC7Funs6xPi9UWInrD7eBv64Savzwf68ldHyoaq5A1wKHp8fFR7/8xIaE/mh4+uHmqGw/+bkpYjJttIwuOgDTyc/+aI7qQpGFDatXhK32h8RYmSW3cEd4EYxLJr7846z8atswbcOBRKUmfMB57PFyjR6pkZGHT5yb9TcXmBSN7onhvjefd9Bj/PBzXwlu/GRl8qQR+xccxn0ckrS+EtvfUivuzkiiL0AlgiMzUe2E1k5KSJeIjvRVXpC/INdzW5XbfsBIGJ4qJoyyya+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQCab2l3HXSuRWZPKrbxW5j7WvCMfaSgj+73vgFPcyc=;
 b=VFmW0p8aEFfviov+D/vdWnyF9HD2eAYEiPNqdaEL2Z9naVolqyxgCSg/ufqrSpF3X2K1iknwWmYsMbGyOq90AOqtcgqVKOsPNltwAr0mhJCztnGix6/s9vJV+i9K+XGFHK9W2wh9GQD6y3yGywzsFSsmDvP3WYG5mDorUNqvwcwNT+FABs2ke7IIyu5Gd5UJ7bZ83/KvQtElR35MG38tloGS+BEtKc5UV2JDDSFZr+hiv9wWx3u5FGwauIpsdGPY+m7kkFEBeQHUqhpitbuWn28jplah9aWjpQZZoVLGukeSgrHCRQz/ilM/mchL1nWWWS35cVZjnF2hJmStNgY9Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQCab2l3HXSuRWZPKrbxW5j7WvCMfaSgj+73vgFPcyc=;
 b=Rb/4DhH4bdk258AcT95lY+0fT5pFi9yMZyqcQmZ6vURvjN5qWrRFCT/XhD7ZyEk5gpGH7kdxVkTwKetTTkTb6B3Ao6SxWW3wJLlfm5IIPQ4F6Xtf/gwKA6gjb5K/6I7/vwpQgIiNrM3HVdL+VgQVteZvNa/dyLI/7ZdRBukKtiQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:28:15 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:28:14 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 24/40] drm/amd/pm: correct Polaris DIDT configurations
Date: Fri, 16 Oct 2020 11:26:36 +0800
Message-Id: <20201016032652.507-25-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23ef3cc6-f10b-4226-4fb3-08d87183844f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1354D3158420BC431959D121E4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bCPHAP385TbqhwH4lCMO6xka9ZKiQZnCiQ5aJxyG0XaQ33vbjEm7w2G4GSA4G8xIFkibASkQLczfaGrF9zrSRtmdOy18hzv5fPunMnX5zyAio6oBEccVtBufwwaKk/54hsM7aLtWNA1uTlXleh0L5kXAe0PpEJPnjyDdSjigq/gn2EVYsGxQPZSBG5ld0XNLswyWzGdDbS8jb6Osw15NGNhbN4mn5rLyoCyxWVViynM4t/bCSdYNWwLMMUIB4S7n5ADvs3PRm8oJPwVU4TvElr8hqOwSXQ51xATvUx4SG0YI18bhlFwigYrUuxxf1CNQphb+SEnHdxNkBKSfilpPUkJgYhTorA+Chch9QauaOzyY1voSsGIo8S2HrPEY0SP3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JjuTYcprh7ndm0NSiTjVO+0R6StdKYBHfPfAqwcb/X4SbIMsKwdfEghGzOgM22wL2E/n0BvBmfcgIwJFKtCtbTnzy+rPHnIJWc9/of7XPNS/HxyADoyI5rmyAsKAdRfzfZm8UwwN2P6vD4lw+exQbgm8LPD9ERrZTbizKq4/OqWOZAZCLgVIn+CXQrMFpSMVhtYMbzV/mSU3R4IrH3zBq1/t91JF3Foigub+d+y3WDnAvmbIMMpQbedlsRWgPj7ewGpRjPX44Rd5q+RbXJorSlsFgZ0BcXBYZqv4MtSamh27xejwkJMtYmaLAIxwD3AViMv1bfTX/TZXXmZzqAcJnkcLCk/aS67diDF1QrmlQ1mk3JkKb+lv+rXOfAu4gbrHEXmcx9CTrcXX4W27eWWn/UhluDnLe8lrzxTsmdDTC9EnDNoTwtibwaGRQ3XdYPPCHnbHqFW1OPH7DDMp49v8hrQQGr1ltviBSqgAozWSe7evMX99dlIXNYkpksvxJyX7fYWgYLhzmtGnQi1ak6CsS/rzAuZsr4LhI4084P3bUJOIBgSP/Hj/buC3t0OAqBWAV6sUOBH3YaMa/81aYJ7ifhR470NveWFxg7gBAcrgc/9plEKzg9kpFzfb3zaoqDeLkF/LzvVdxMhRNw461WKXfQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ef3cc6-f10b-4226-4fb3-08d87183844f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:14.8489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvUYtfhkXgIvouBwtp8/NVRuam8OAJsryA0xAlFOw2kwwtIz0dUlj6t5sLlzywva
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct Polaris DIDT enablement.

Change-Id: I8e0033aef8cb0ab005b59517241338ecdf6f3817
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h       |  2 ++
 .../amd/pm/powerplay/hwmgr/smu7_powertune.c   | 34 +++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h
index 97302aae4b27..a0a38b8a4b1b 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h
@@ -403,6 +403,8 @@ typedef uint16_t PPSMC_Result;
 
 #define PPSMC_MSG_EnableDpmDidt               ((uint16_t) 0x309)
 #define PPSMC_MSG_DisableDpmDidt              ((uint16_t) 0x30A)
+#define PPSMC_MSG_EnableDpmMcBlackout         ((uint16_t) 0x30B)
+#define PPSMC_MSG_DisableDpmMcBlackout        ((uint16_t) 0x30C)
 
 #define PPSMC_MSG_EnableEDCController         ((uint16_t) 0x316)
 #define PPSMC_MSG_DisableEDCController        ((uint16_t) 0x317)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c
index 5d4971576111..32a5a00fd8ae 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c
@@ -852,12 +852,14 @@ static const struct gpu_pt_config_reg DIDTConfig_VegaM[] =
 };
 static int smu7_enable_didt(struct pp_hwmgr *hwmgr, const bool enable)
 {
+	struct amdgpu_device *adev = hwmgr->adev;
 	uint32_t en = enable ? 1 : 0;
 	uint32_t block_en = 0;
 	int32_t result = 0;
 	uint32_t didt_block;
 
-	if (hwmgr->chip_id == CHIP_POLARIS11)
+	if ((hwmgr->chip_id == CHIP_POLARIS11) &&
+	    (adev->pdev->subsystem_vendor != 0x106B))
 		didt_block = Polaris11_DIDTBlock_Info;
 	else
 		didt_block = DIDTBlock_Info;
@@ -962,6 +964,7 @@ int smu7_enable_didt_config(struct pp_hwmgr *hwmgr)
 	uint32_t num_se = 0;
 	uint32_t count, value, value2;
 	struct amdgpu_device *adev = hwmgr->adev;
+	uint32_t efuse;
 
 	num_se = adev->gfx.config.max_shader_engines;
 
@@ -988,7 +991,9 @@ int smu7_enable_didt_config(struct pp_hwmgr *hwmgr)
 			} else if (hwmgr->chip_id == CHIP_POLARIS11) {
 				result = smu7_program_pt_config_registers(hwmgr, GCCACConfig_Polaris11);
 				PP_ASSERT_WITH_CODE((result == 0), "DIDT Config failed.", goto error);
-				if (hwmgr->is_kicker)
+
+				if (ASICID_IS_P21(adev->pdev->device, adev->pdev->revision) ||
+				    ASICID_IS_P31(adev->pdev->device, adev->pdev->revision))
 					result = smu7_program_pt_config_registers(hwmgr, DIDTConfig_Polaris11_Kicker);
 				else
 					result = smu7_program_pt_config_registers(hwmgr, DIDTConfig_Polaris11);
@@ -1016,7 +1021,32 @@ int smu7_enable_didt_config(struct pp_hwmgr *hwmgr)
 						NULL);
 			PP_ASSERT_WITH_CODE((0 == result),
 					"Failed to enable DPM DIDT.", goto error);
+
+			if (ASICID_IS_P21(adev->pdev->device, adev->pdev->revision) ||
+			    ASICID_IS_P31(adev->pdev->device, adev->pdev->revision)) {
+				result = smum_send_msg_to_smc(hwmgr,
+							(uint16_t)(PPSMC_MSG_EnableDpmMcBlackout),
+							NULL);
+				PP_ASSERT_WITH_CODE((0 == result),
+						"Failed to enable workaround for CRC issue.", goto error);
+			} else {
+				atomctrl_read_efuse(hwmgr, 547, 547, &efuse);
+				if (efuse == 1) {
+					result = smum_send_msg_to_smc(hwmgr,
+								(uint16_t)(PPSMC_MSG_EnableDpmMcBlackout),
+								NULL);
+					PP_ASSERT_WITH_CODE((0 == result),
+							"Failed to enable workaround for CRC issue.", goto error);
+				} else {
+					result = smum_send_msg_to_smc(hwmgr,
+								(uint16_t)(PPSMC_MSG_DisableDpmMcBlackout),
+								NULL);
+					PP_ASSERT_WITH_CODE((0 == result),
+							"Failed to enable workaround for CRC issue.", goto error);
+				}
+			}
 		}
+
 		mutex_unlock(&adev->grbm_idx_mutex);
 		amdgpu_gfx_rlc_exit_safe_mode(adev);
 	}
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
