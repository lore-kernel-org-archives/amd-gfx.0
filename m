Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCF2C2D0E5
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 12:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A8420714
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 12:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rdyaqXYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A8420714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B7EC89170;
	Mon, 30 Mar 2020 12:14:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD6B89170
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 12:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIaLr/fNsVdqtyMQNEk+00FqDrUyUkGqBurTLB4YXYjXZFppnlrEyXKcDNDac7YNORafWH46+XYoZ0tRJvKuU/heYZYrexj8NkRBUqm682ctXD7zbN1KnCs0cDcRleh74mpHf2wYxq1JW1hiQz1mjCKoMcuAeIP7esgkjJUpJ4d3GUrZma4N2msibyr4bZGTKr+5URu/IcQOaysLbH/79zvUMJAoHkscDbhW3TfohhH4BYp6/b0ToTfxc3iJrleer7tTJECibhhNr43Du5YhSqd2+qOpJ6CwpnK521FhppNmzIlD/8stjNNCa+LwVGhjm0edK62v1qF6Wm2JlkIy6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCRfpj5rGK1TuS0Rdss4c38aFYjXL4FI+TalWuqfOmU=;
 b=i/sA4I0O+tmcnXj4/KLzj6/IpTidjVe8eFws0LIdgf8Z0cnsLqxMB0vY2voat3L5UpnzVN7CjcFt/eImve8BiqY3N7LxSMx0GtLi74wOvILTXA2D6M7BXJYpUKL+WwFPGx6HGt6ZYNuE+jvKixIIiEvzgsl2eNAUAnCUXBFSsrA0yduOYIYjjkxwOpZPyANK12aVo7qthqdhhJOh3NW+LSiRVKSgpR79rKx6Jg9TjaWXFSSVx6sSHRvmPBS96R6Rzb4zyg6UZ/XzH7Fj+EATfDq3ejtO+uU0q9+TpT1ija7bNQHdib1aMQ3bHifvA1s+oDOLBJbc7QPZpzvj2Q1n/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCRfpj5rGK1TuS0Rdss4c38aFYjXL4FI+TalWuqfOmU=;
 b=rdyaqXYY/iOAjlmk2aH6hIpXADcfCz+20CI821qL7Aye3LciVktqGDxFm0mXIL9I9oytBLfOcyxjKB54DDHEgzhP/iJPGiJR9Kf9Q3rT/bbDEySn6wVJncGTaq2z/fzHNCXESO5dTYJfOahV8Kjmfw2nNTQwnKCnKb97/t1qBSQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB2358.namprd12.prod.outlook.com (2603:10b6:4:b3::34) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 12:14:29 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::bcb9:8228:818:6129]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::bcb9:8228:818:6129%3]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 12:14:29 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amdgpu/vcn2.0: stall DPG when WPTR/RPTR reset
Date: Mon, 30 Mar 2020 08:13:34 -0400
Message-Id: <1585570418-13894-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::15) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2856.18 via Frontend Transport; Mon, 30 Mar 2020 12:14:29 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec63764e-de5a-4442-edb0-08d7d4a3e593
X-MS-TrafficTypeDiagnostic: DM5PR12MB2358:|DM5PR12MB2358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2358420D2834237CAEC8B192E4CB0@DM5PR12MB2358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:353;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(66946007)(81166006)(86362001)(8676002)(81156014)(8936002)(6486002)(2616005)(956004)(478600001)(66556008)(66476007)(6666004)(52116002)(5660300002)(16526019)(4326008)(7696005)(316002)(2906002)(26005)(6916009)(186003)(36756003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KgskIxt4I0bTrAbSUHO7HHPV0NCCpQKoGJlVFTDacpHpBTxaY8u7z+k+rflWBAU3JobsNcxxKkJL9vfNphHwwUHYuCRX3ocLgJk2NdMdenHfYiZzWO/iYCZqNX9bCceUwjsmA49d8bM4hbgbTzG8PFocphoemXyXRh18RamgHMS0B+1XUM2Jkf1vlzAJVhSKagF2sc6+HGeKoccUD3quG9nQTWsYP5JSyMZUqzRPZnvzUTRBDJaoTHx3eXVVDl3v0uYVHuFTAqZfptsKukwx7/N0d9GfYSUyqz62TDcSVvVxcXcd/a6pIGtMRALIo5D0ZkwIysIlLIzAW1lrob0m7QHL5GELuj1ohdx+DbkCKkF/jUu5vQxWxS0JgsQPjYl37wH3zXleBgQEVhVmABSiJv+SUcJ4/dl+QJlSY492FFzTZvxNYhbtI83RAFLjsWv3
X-MS-Exchange-AntiSpam-MessageData: Pn3wvKRoaUHL7PUHb7B3W6yRwd29eNhETeltF8GP9KnntrI5KW6N6XFkFwCL5AnmvYcjkTqLt+c/sU0XhvaC5zPknlPHtnE+cEmaOjpNGIM9jzGKNGepbktq6fJ9Oi4vaxlwXgCrLJS1IxlPw7sMgg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec63764e-de5a-4442-edb0-08d7d4a3e593
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 12:14:29.4908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qg4TZYz+6xw0Mh662YJHtfjyylp3QqctOHu7J8r4Wem3GOyAs37O/B3pS73Sv5tF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add vcn dpg harware synchronization to fix race condition
issue between vcn driver and hardware.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index febd4c2..28ef7df 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -876,6 +876,10 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
 	WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_CNTL, tmp);
 
+	/* Stall DPG before WPTR/RPTR reset */
+	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS),
+		UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK,
+		~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 	/* set the write pointer delay */
 	WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR_CNTL, 0);
 
@@ -898,6 +902,9 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 	WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR,
 		lower_32_bits(ring->wptr));
 
+	/* Unstall DPG */
+	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS),
+		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 	return 0;
 }
 
@@ -1193,8 +1200,13 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
 					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK, ret_code);
 
+				/* Stall DPG before WPTR/RPTR reset */
+				WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS),
+					   UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK,
+					   ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 				/* Restore */
 				ring = &adev->vcn.inst->ring_enc[0];
+				ring->wptr = 0;
 				WREG32_SOC15(UVD, 0, mmUVD_RB_BASE_LO, ring->gpu_addr);
 				WREG32_SOC15(UVD, 0, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
 				WREG32_SOC15(UVD, 0, mmUVD_RB_SIZE, ring->ring_size / 4);
@@ -1202,6 +1214,7 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(UVD, 0, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
 
 				ring = &adev->vcn.inst->ring_enc[1];
+				ring->wptr = 0;
 				WREG32_SOC15(UVD, 0, mmUVD_RB_BASE_LO2, ring->gpu_addr);
 				WREG32_SOC15(UVD, 0, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
 				WREG32_SOC15(UVD, 0, mmUVD_RB_SIZE2, ring->ring_size / 4);
@@ -1210,6 +1223,9 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 
 				WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR,
 					   RREG32_SOC15(UVD, 0, mmUVD_SCRATCH2) & 0x7FFFFFFF);
+				/* Unstall DPG */
+				WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS),
+					   0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
 				SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS,
 					   UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
