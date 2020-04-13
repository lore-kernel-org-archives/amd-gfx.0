Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6343CC2BA19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 06:46:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17EAA20735
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 06:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iUB2RprX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EAA20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AD196E192;
	Mon, 13 Apr 2020 06:46:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 537CA6E192
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 06:46:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNysRpRtRUsqwGhvic+reBDT57YaLSdsdtOO8IY/1U4c+e3pgjv1YPjSKnWhmmD9pUrBQrsESr7iZDZLhDOi51W7oBvSrhbvMJfIVJTbGHJ6i3iUwnDK82je13rq5rL/u0XPc4Nyz1nrgQ/CeEOg3G0tcyKCrSbzOJQDsZLXKvbCgxwvoNpO2xXpZX5WQQuZ/u52yoduVRCpetiPPAKxzSWwKJKkxeZJ70ZrH1M/m1I7GbGJmY6olGlVfHQexuJbVXbQwhPNT+banOa2Zg4cQhA9copgDA+EnRegkgjCdzNqjjrekj2XPikECs2EefYUnltTspLxSaBY8qln7xoFHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpW8oLIjDAeDjURKvhTv6CtA3xDAc8oQFHp51G9EFMg=;
 b=N6V1L/qYKiENjEPCBlVI7x0b21hqYZDKusH8S7svAmTT1MHwsTdhQSrZKLKcvP0peHtakS1tp2pHs+aL6UVD/YB1jI5K0XX77Rzb4tJKR0qwLlMRlR8Bv6ztRMn296F0n1C9Us6cLX1THZPc/PvXK0cKLmQhoHydbVNumkHQjlByGQQ3W3IS4/jjdxakCf5esor+SROUURP1laA3YNPH7wyaesDfkz7ee/ORgCniIRw+OTMzDLuarmVoQv0aiMlpf5hRCvtztnr22URvXEMHhLi+Cb39p3D6S038KxTLzX8mRuPO2oSvXIXM7T2E/U7LhTISaGp8ngRVedfs9J5plg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpW8oLIjDAeDjURKvhTv6CtA3xDAc8oQFHp51G9EFMg=;
 b=iUB2RprXpN41HvjbsrkdTgSQQ406/bLYT7eRfOTKer8rFfiZ96F7X2KpgIvB9jxHCOqWduWDaqAYzDlw8G0Mtsa2IGA+K67gzeehc9jmgasdHDWLH64u2F3GzUve1XKwo0kUqPGsgvpC9CJ8Gu3p5R2vMKpdy+GoDMTR0tJLpkI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1285.namprd12.prod.outlook.com (2603:10b6:903:3e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Mon, 13 Apr
 2020 06:45:57 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc%8]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 06:45:57 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Hawking.Zhang@amd.com,
	Dennis.Li@amd.com
Subject: [PATCH] drm/amdgpu: replace DRM prefix with PCI device info for GFX
 RAS
Date: Mon, 13 Apr 2020 14:45:40 +0800
Message-Id: <20200413064540.15902-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0158.apcprd02.prod.outlook.com
 (2603:1096:201:1f::18) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR02CA0158.apcprd02.prod.outlook.com (2603:1096:201:1f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Mon, 13 Apr 2020 06:45:55 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8e17350e-9840-4b6f-2acc-08d7df7651f8
X-MS-TrafficTypeDiagnostic: CY4PR12MB1285:|CY4PR12MB1285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB12853162EAC6FCF9B3B3490DF1DD0@CY4PR12MB1285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:451;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(2616005)(5660300002)(956004)(186003)(4326008)(16526019)(2906002)(86362001)(8936002)(478600001)(8676002)(81156014)(44832011)(66476007)(66556008)(66946007)(7696005)(52116002)(26005)(6636002)(316002)(6486002)(1076003)(36756003)(6666004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rskca7cb1twOoP0fApSjf/EueRgOpROShnW/aqby0Kk51aRWyIeBw2KNrZ8TZOuuzynIBMGH6e8664wBc2pH1DR1TquLQssikAiksMKxcG47c8mhTb0Oa55cZ3+eefbVbudLlYYQ7rqT4BBkek0tPMZahIXPzWVMdZou5w5G2CHo/r5Jp9pit2bZqSRRoDUgn1tZXofy4Ut3/20HSVKImwh40Y4E9ZM0PrGc4WshPVtRSsw8FGXowQ1I7ojvh8KOsIykjulAUDNnczh7VtVaa/QSQkApdrwgnk1hksNi6fUo4MjkbpQb+eN/uc7fIz8DffHUhk6OuZt4f/0bhFhj+wZlkmNVuuZtyoAsGq8b9bcRWDitbrMoHdqmJNPqudqP1d05b81tkyF+bLT0Ls56TOiUcs4gGHeXNBjJSKdC/FDfDxVRBvZsYKXcM60mYnj2
X-MS-Exchange-AntiSpam-MessageData: zeZEug0vHoix4e5/yJ22U+jqVI8GmE11rd81QkPKeOcV2WU+29i8i9bNT9lDiaM+clhvGnq6bOOIIiv8IzF5nxnCGQmATN4U3FgmVVnpybr9v8j79MRaEMC7RPCpc2nimihVGV5HLFYHyqXkYl21hw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e17350e-9840-4b6f-2acc-08d7df7651f8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 06:45:57.4006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2cmMIqyU658axyG10gFKhXvM8cR750qeXRDtp7U4BsiFbcz+MSHKdzsPzSSKNVZbtxGiMJw7j9Kpku9PJTN1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1285
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
Cc: Candice.Li@amd.com, Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Prefix RAS message printing in GFX IP with PCI device info,
which assists the debug in multiple GPU case.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 47 +++++++++++++++------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1d18447129b1..84fcf842316d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -6397,15 +6397,15 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 
 		sec_count = REG_GET_FIELD(data, VM_L2_MEM_ECC_CNT, SEC_COUNT);
 		if (sec_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, SEC %d\n", i,
-				 vml2_mems[i], sec_count);
+			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+				"SEC %d\n", i, vml2_mems[i], sec_count);
 			err_data->ce_count += sec_count;
 		}
 
 		ded_count = REG_GET_FIELD(data, VM_L2_MEM_ECC_CNT, DED_COUNT);
 		if (ded_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, DED %d\n", i,
-				 vml2_mems[i], ded_count);
+			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+				"DED %d\n", i, vml2_mems[i], ded_count);
 			err_data->ue_count += ded_count;
 		}
 	}
@@ -6417,16 +6417,16 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 		sec_count = REG_GET_FIELD(data, VM_L2_WALKER_MEM_ECC_CNT,
 						SEC_COUNT);
 		if (sec_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, SEC %d\n", i,
-				 vml2_walker_mems[i], sec_count);
+			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+				"SEC %d\n", i, vml2_walker_mems[i], sec_count);
 			err_data->ce_count += sec_count;
 		}
 
 		ded_count = REG_GET_FIELD(data, VM_L2_WALKER_MEM_ECC_CNT,
 						DED_COUNT);
 		if (ded_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, DED %d\n", i,
-				 vml2_walker_mems[i], ded_count);
+			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+				"DED %d\n", i, vml2_walker_mems[i], ded_count);
 			err_data->ue_count += ded_count;
 		}
 	}
@@ -6437,8 +6437,9 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 
 		sec_count = (data & 0x00006000L) >> 0xd;
 		if (sec_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, SEC %d\n", i,
-				 atc_l2_cache_2m_mems[i], sec_count);
+			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+				"SEC %d\n", i, atc_l2_cache_2m_mems[i],
+				sec_count);
 			err_data->ce_count += sec_count;
 		}
 	}
@@ -6449,15 +6450,17 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 
 		sec_count = (data & 0x00006000L) >> 0xd;
 		if (sec_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, SEC %d\n", i,
-				 atc_l2_cache_4k_mems[i], sec_count);
+			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+				"SEC %d\n", i, atc_l2_cache_4k_mems[i],
+				sec_count);
 			err_data->ce_count += sec_count;
 		}
 
 		ded_count = (data & 0x00018000L) >> 0xf;
 		if (ded_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, DED %d\n", i,
-				 atc_l2_cache_4k_mems[i], ded_count);
+			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+				"DED %d\n", i, atc_l2_cache_4k_mems[i],
+				ded_count);
 			err_data->ue_count += ded_count;
 		}
 	}
@@ -6470,7 +6473,8 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v9_0_ras_error_count(const struct soc15_reg_entry *reg,
+static int gfx_v9_0_ras_error_count(struct amdgpu_device *adev,
+	const struct soc15_reg_entry *reg,
 	uint32_t se_id, uint32_t inst_id, uint32_t value,
 	uint32_t *sec_count, uint32_t *ded_count)
 {
@@ -6487,7 +6491,8 @@ static int gfx_v9_0_ras_error_count(const struct soc15_reg_entry *reg,
 				gfx_v9_0_ras_fields[i].sec_count_mask) >>
 				gfx_v9_0_ras_fields[i].sec_count_shift;
 		if (sec_cnt) {
-			DRM_INFO("GFX SubBlock %s, Instance[%d][%d], SEC %d\n",
+			dev_info(adev->dev, "GFX SubBlock %s, "
+				"Instance[%d][%d], SEC %d\n",
 				gfx_v9_0_ras_fields[i].name,
 				se_id, inst_id,
 				sec_cnt);
@@ -6498,7 +6503,8 @@ static int gfx_v9_0_ras_error_count(const struct soc15_reg_entry *reg,
 				gfx_v9_0_ras_fields[i].ded_count_mask) >>
 				gfx_v9_0_ras_fields[i].ded_count_shift;
 		if (ded_cnt) {
-			DRM_INFO("GFX SubBlock %s, Instance[%d][%d], DED %d\n",
+			dev_info(adev->dev, "GFX SubBlock %s, "
+				"Instance[%d][%d], DED %d\n",
 				gfx_v9_0_ras_fields[i].name,
 				se_id, inst_id,
 				ded_cnt);
@@ -6587,9 +6593,10 @@ static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 				reg_value =
 					RREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_0_edc_counter_regs[i]));
 				if (reg_value)
-					gfx_v9_0_ras_error_count(&gfx_v9_0_edc_counter_regs[i],
-							j, k, reg_value,
-							&sec_count, &ded_count);
+					gfx_v9_0_ras_error_count(adev,
+						&gfx_v9_0_edc_counter_regs[i],
+						j, k, reg_value,
+						&sec_count, &ded_count);
 			}
 		}
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
