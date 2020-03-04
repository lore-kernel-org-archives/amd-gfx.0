Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CF7C3F2CD
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 14:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB4432166E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 14:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZqT2GWzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4432166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C74286E190;
	Wed,  4 Mar 2020 14:47:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26A5C6E190
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 14:47:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YP6s09Rb5BoAc+d6j/db++gK0PrXWThutAj4Lgog0GsCvxPIg94OQBRUA47cfgbjjQ/LA6jYiQ3a7cBUVQT6L389AHf9X6qY3qT8LPnoL1haN6ZyL+smnP6soTNY0RHzu2TJDWu3TEv7J9Ezhap3Lv5lOpQ9xC9bW7YbW18xXkw+Xg4uUbk3ozQjiZWXPCl5kZc9nZe3kDz1c/EZakHLTqm1ZHv7SBzEteuYHMoF2QPonC6AIafJFKEk8oIYGkGAVtQENkflIwBZDysBM6o7R+0LRkfn0UCuWl2+uONrLomcVFUvVT/H0ts71aqg0g2GrOwoFTyGbGttlFiFZxPfTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIgBQ+dIKY4ZLlhHkRBF4KyB9pmxNv/MqM+LwD1jCdc=;
 b=APqgLViR04mRzrXsfemDHqL7cJfDcJtwrR5VjXb385Vcsup3YgFGGbVYMR6ujVpr3OSu0rq5osbRpwo7rRBvn15vaX7l2eNgL0J1jKSyJsD6Kg91NSFIf+k1deTQHlOOw/RVzwzvf6XtPNUeM9soikO7oqJQQ9RlHAtbdXB0SwkcV6JLnJyDklkJChHeC8T9vBxrUaOhwJ/aL9ASwqp8ZQaYaVnGL2rvIDD4xwMH5c4+y1wIqfbc3njaRinHWfDPSp8LrL4TveOL3c/uF+cJQ7VKrLmbPJxCFMabmAJo+iJ2M7DffpHBPzfYYiWqRQBrllzz80DQnchKiK7jMN9UPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIgBQ+dIKY4ZLlhHkRBF4KyB9pmxNv/MqM+LwD1jCdc=;
 b=ZqT2GWzpKjkSDeTj84dN/RyI0P5OZV4cWdUofQhRZ6xB+s2J2Lcl151A2Q48gMnPCu/vIzT8jzCRoLi4wuNJTugE9R2oSH2T/IC58z0NWVPL39WBLdQXy+RRxRcwQYjQgb256hjoAQbY4QpfS5HgQte841g5XgV8DqtN9TAbPEo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20)
 by BYAPR12MB3397.namprd12.prod.outlook.com (2603:10b6:a03:db::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 14:47:08 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 14:47:08 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com
Subject: [PATCH] drm/amdgpu: toggle DF-Cstate when accessing UMC ras error
 related registers
Date: Wed,  4 Mar 2020 22:46:43 +0800
Message-Id: <20200304144643.24892-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:203:b0::26) To BYAPR12MB2806.namprd12.prod.outlook.com
 (2603:10b6:a03:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK0PR03CA0110.apcprd03.prod.outlook.com (2603:1096:203:b0::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Wed, 4 Mar 2020 14:47:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5b3e8b62-bf8e-4824-532b-08d7c04ae9b8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3397:|BYAPR12MB3397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB339756DF1158B8D1CBDEDB57F1E50@BYAPR12MB3397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:13;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(199004)(189003)(6666004)(26005)(36756003)(6486002)(316002)(956004)(44832011)(186003)(16526019)(2616005)(66946007)(8676002)(81166006)(81156014)(4326008)(86362001)(66556008)(52116002)(2906002)(1076003)(8936002)(478600001)(6636002)(7696005)(66476007)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3397;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyYEVkSjHrNNfEXaaQKqrom2+x4kkSaxxxlodn6OzIzLQ6wvWk2v+IH1kTBC4D8bxhJeP2JqV6efhR8Rkh223Ib3Ybg+yo0QxM/kXE73+4dwWyYXIdRPB+IfxGP321jnMqFitCqVoHcN7nSL//8Y/p3hEO5KRNXL7ae+o6ZcJZTNAniuj/r65AKYDeW1shsO6iXEkOK3ZgYhonRsyq3qUkqqhJBEBygY2HYK/4F5KZZBXf2mFoeScNvY0bjYKeaJ+sm4kH5wLXWu0s9RErT4O+iBMXlfalVWJuWF6YHUCWoTWHYCmlx0+lYCVpz3xEqb6rgdm6Avt5TZfdclyNWyv5b9Lw75zQqvir6LjfZhPjEMvzNiDqoGwHAoMBu0JsqLB0LkT/NVd7VtwgFvhxc7E4tWYw4eIvaciD2IJYEgIkg0cRUHlvh2+LqLMko58lwA
X-MS-Exchange-AntiSpam-MessageData: z5wn9oiii1bTLB1isM4yveYisMKrf/Ro1victW8mN15hgl1oYlOX0I7MtviWJK/B+ehyBYpU2VEwmwRWhNSxddsJ6P1lLm/x8S5V86ojkxkaKgGqQlptWr5U1KxaH12KHWc2xnoTY6uW5B5J4BBerw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3e8b62-bf8e-4824-532b-08d7c04ae9b8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 14:47:08.0696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hglf8NRvj3MdcmX2frAw72lb5GhVFiotw+YCzckr2qSINtcA06t5NDtaNiXSAPDlkvm5oixFKtL6HudnuCfHSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3397
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On arcturus, DF-Cstate needs to be toggled off/on
before and after accessing UMC error counter and
error address registers, otherwise, clearing such
registers may fail.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
index e6866f038209..77122a7282e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -186,6 +186,10 @@ static void umc_v6_1_query_ras_error_count(struct amdgpu_device *adev,
 	if (rsmu_umc_index_state)
 		umc_v6_1_disable_umc_index_mode(adev);
 
+	if ((adev->asic_type == CHIP_ARCTURUS) &&
+		amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
+		DRM_WARN("Fail to disable DF-Cstate.\n");
+
 	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
 		umc_reg_offset = get_umc_6_reg_offset(adev,
 						      umc_inst,
@@ -199,6 +203,10 @@ static void umc_v6_1_query_ras_error_count(struct amdgpu_device *adev,
 							  &(err_data->ue_count));
 	}
 
+	if ((adev->asic_type == CHIP_ARCTURUS) &&
+		amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
+		DRM_WARN("Fail to enable DF-Cstate\n");
+
 	if (rsmu_umc_index_state)
 		umc_v6_1_enable_umc_index_mode(adev);
 }
@@ -288,6 +296,10 @@ static void umc_v6_1_query_ras_error_address(struct amdgpu_device *adev,
 	if (rsmu_umc_index_state)
 		umc_v6_1_disable_umc_index_mode(adev);
 
+	if ((adev->asic_type == CHIP_ARCTURUS) &&
+		amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
+		DRM_WARN("Fail to disable DF-Cstate.\n");
+
 	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
 		umc_reg_offset = get_umc_6_reg_offset(adev,
 						      umc_inst,
@@ -300,6 +312,10 @@ static void umc_v6_1_query_ras_error_address(struct amdgpu_device *adev,
 					     umc_inst);
 	}
 
+	if ((adev->asic_type == CHIP_ARCTURUS) &&
+		amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
+		DRM_WARN("Fail to enable DF-Cstate\n");
+
 	if (rsmu_umc_index_state)
 		umc_v6_1_enable_umc_index_mode(adev);
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
