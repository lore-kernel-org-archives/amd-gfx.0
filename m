Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6591CC433E9
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 16:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06FFB20775
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 16:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GoSpmBd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FFB20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B01F76EA09;
	Thu,  3 Sep 2020 16:22:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 087626E1F7
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 16:22:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtQJrgtRE3BuxDzP5u9XLlqX4G6uUnrczGg7j62UsP+1/Q14hpviSzw0NrMq7tU861gqNXbVHyWj1cEE6ydIi1GfU0lFT/Z6/6LVc967kIh9vgX6orZ8FuE7RNFRCgD7ooPWmQN03E0QTfKQIacp9n+1kOwHC6baLycG7eNwElr7ofVt+Kwo15jjOhb/lmp+itH0E4MITBX7JseGIdtVtlrf2tA/vBgIXzATp1OW644DTog4H5rwArtBb9p36qfMRLPZHg+eA1eQLB1ISLKuRb/Fp6w0OmEpu8co4HREK37GrSO1JnUoeea54z1Hgt5YEfnEkAvC3O94lv4MWiSM5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMzSFHSXv+BWk0jRijO5ddStd0dgN+OP6xAXkt2Lguk=;
 b=Wog7tpwusNtsQtyFs7P3Rlh25D9b6/h+LJ7jWBleJo//HRQjV9JDG64X7TicCCGpAoizFqs9Qud6aLEsEF9MgXwgEINIUR4ftpdqgaAAzkNVUgTlVOULHcls2lNXn+4SFODCQNesSvM+BKy7IIVJsUiBCvLqWG8fnQy55RePFwPLTQft5mLBrYWACUzN722r/qTDqC8V1dbG48ksbX4vZSHLXELJKR2OxvnfC++Bsy2j/AB/1ksPDtuxma+XsOJhjqMO47ch3C6I8tdk8V5xrKPeIOkzbhsFWtLsL+GujfkQSx5zM24AitMe90kwd0KVm6liMGDFEr5AxNRnN+82vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMzSFHSXv+BWk0jRijO5ddStd0dgN+OP6xAXkt2Lguk=;
 b=GoSpmBd/ueB6+Li5VKuAc0ifRoJMelgHG+uia7iRh0Odvwh6WmVabWFAQanGFeSQhObB7SJfKVTCPczQ8NxV1bepwmpWvCWP9WN4k5t5+dF/5ifCO7N8SlNyIm0oExdDM24chFh0ZdHG85z3SE7qmS5knd4kDPNy1jRzowOPKRY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN8PR12MB2978.namprd12.prod.outlook.com
 (2603:10b6:408:42::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Thu, 3 Sep
 2020 16:22:09 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 16:22:09 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/6] drm/amdgpu: stop resetting xgmi perfmons on disable
Date: Thu,  3 Sep 2020 12:21:49 -0400
Message-Id: <20200903162154.55694-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::40) To BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTXPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 3 Sep 2020 16:22:08 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ebf5bd9b-b106-48ab-38df-08d850258192
X-MS-TrafficTypeDiagnostic: BN8PR12MB2978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2978FA36D3B704F39A42F54B852C0@BN8PR12MB2978.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4wJHM3MpBoF4nQdm4sRIy1p4UKaP3bDp/gMmswDB2Xq3g9fWWn50FK04ABdxdZ53uYypNEvXMXxtlhifmNjAuAxyN2ot7tpBCbxynViBU+QBdiuBIXd30IOgt0NAvLy45RnhAvYI3Yc1+l7jok86G3Hh5tRuiSalIZ3d8QMfL5wHeJo08chVqVq+AOq0gk8VAMqoMYmHnMkhf59A3dUWNnu/m0viwxSehWuW5gBNXW333P1QXW/RaydU/0SRnUpYHurX66w4+d+tiK784OdYSLspo4D5PIPmmXeITF0Q5QaOOicNNu+25OUW1wcy4JP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(316002)(54906003)(2906002)(6486002)(4326008)(16576012)(478600001)(8936002)(6666004)(83380400001)(8676002)(66556008)(52116002)(6916009)(66476007)(5660300002)(86362001)(2616005)(186003)(44832011)(1076003)(66946007)(956004)(36756003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: yOBbOzYbJP9w7FXEOytkhPjKKSGo16K1WDEM8szl1OZPw/vzoyQkBsBm3Ixa+jG3C6dH9c6icFUD51yLTQlt5gjJtt1rKyx00GpvCtylj0kkwLC0nkmsoTHPG3q469kkkOvHH2UuAV+eB6OuW2d4Nw4N0xFN6pGx4zSgM5Pca2ymP+tdlsKvI1IMWC8tihFEKYm2zuZjMymwe1emsR7/dekFw3KHTt1I6x6sbBlhuOE9/fBeMNr/EoCAh+UOQrMJZAVbIsL6LcA6lBH+7cnrv2VsPr1O7aZmB5YesWpAU9m30D/M8/gbmpuyFYu9Zey0zZVhpLB6q4Ffahdpx6jrpEI+Jf9IqpoVGiUQxMk2gVq2p3Lijh00G2e948YZs7tJ4MR8+siMiaBSqjOxWdDFc0arHJOhkSMYptYloYD03Z0bXXmXO2sOWwRcQJzgE20eu2b0b5dTknGe8jA5pAAN5OmG5TAKNPjohaTdOYJYvGdi3nJ6s2jFsOSr6NWQU34kZnphnFggnIJ9t+qH5ndgAthUch/oYDibFFXRy1toG22WDYnCDFOfzEEGbCjvKvI1QMg7BlnRTcqoXzckdDgfhkGKbKNWvHBUocYLlmxNzrx5s+SkW5ngNVGvdSGiJB7M+CWMeb/5NDe+zjWi8CV8ZA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf5bd9b-b106-48ab-38df-08d850258192
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 16:22:09.2720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsWTthvYXA4gDMY3SViNexc8Wi+F/i/Cr1cVf5dW1VJMbKqaiqrHT2HaSauPo7Ez
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2978
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <Jonathan.Kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Disabling perf events does not specify reset in ABI so stop doing it in
hardware.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_df.h |  4 ++--
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c   | 23 ++++++++++++++---------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
index 61a26c15c8dd..373cdebe0e2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
@@ -44,9 +44,9 @@ struct amdgpu_df_funcs {
 	void (*enable_ecc_force_par_wr_rmw)(struct amdgpu_device *adev,
 					    bool enable);
 	int (*pmc_start)(struct amdgpu_device *adev, uint64_t config,
-					 int is_enable);
+					 int is_add);
 	int (*pmc_stop)(struct amdgpu_device *adev, uint64_t config,
-					 int is_disable);
+					 int is_remove);
 	void (*pmc_get_count)(struct amdgpu_device *adev, uint64_t config,
 					 uint64_t *count);
 	uint64_t (*get_fica)(struct amdgpu_device *adev, uint32_t ficaa_val);
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 2eab808fffeb..7b89fd2aa44a 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -455,7 +455,8 @@ static int df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
 					  uint32_t *lo_base_addr,
 					  uint32_t *hi_base_addr,
 					  uint32_t *lo_val,
-					  uint32_t *hi_val)
+					  uint32_t *hi_val,
+					  bool is_enable)
 {
 
 	uint32_t eventsel, instance, unitmask;
@@ -477,7 +478,8 @@ static int df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
 	instance_5432 = (instance >> 2) & 0xf;
 	instance_76 = (instance >> 6) & 0x3;
 
-	*lo_val = (unitmask << 8) | (instance_10 << 6) | eventsel | (1 << 22);
+	*lo_val = (unitmask << 8) | (instance_10 << 6) | eventsel;
+	*lo_val = is_enable ? *lo_val | (1 << 22) : *lo_val & ~(1 << 22);
 	*hi_val = (instance_76 << 29) | instance_5432;
 
 	DRM_DEBUG_DRIVER("config=%llx addr=%08x:%08x val=%08x:%08x",
@@ -572,14 +574,14 @@ static void df_v3_6_reset_perfmon_cntr(struct amdgpu_device *adev,
 }
 
 static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
-			     int is_enable)
+			     int is_add)
 {
 	uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
 	int err = 0, ret = 0;
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
-		if (is_enable)
+		if (is_add)
 			return df_v3_6_pmc_add_cntr(adev, config);
 
 		df_v3_6_reset_perfmon_cntr(adev, config);
@@ -589,7 +591,8 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 					&lo_base_addr,
 					&hi_base_addr,
 					&lo_val,
-					&hi_val);
+					&hi_val,
+					true);
 
 		if (ret)
 			return ret;
@@ -612,7 +615,7 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 }
 
 static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
-			    int is_disable)
+			    int is_remove)
 {
 	uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
 	int ret = 0;
@@ -624,15 +627,17 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 			&lo_base_addr,
 			&hi_base_addr,
 			&lo_val,
-			&hi_val);
+			&hi_val,
+			false);
 
 		if (ret)
 			return ret;
 
-		df_v3_6_reset_perfmon_cntr(adev, config);
 
-		if (is_disable)
+		if (is_remove) {
+			df_v3_6_reset_perfmon_cntr(adev, config);
 			df_v3_6_pmc_release_cntr(adev, config);
+		}
 
 		break;
 	default:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
