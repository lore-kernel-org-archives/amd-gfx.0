Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397F6C388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 06:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13172245B
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 06:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fmOYHooa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13172245B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 607046E47E;
	Wed, 28 Oct 2020 06:07:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 182B06E47E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 06:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJLtTHnIKvINE6/LsP/Ggd8Ocits+FESFkqaf9uQmvi7/gMzFp8HdTFxfFOsep77ICo77cpB1LzJi2o8+1AhCBmyyLp8dDy40pUn8fsPxSr7ijahyGTbXMHhsqYEpdetbPA9LYQiwFlQzaZiEC+4Jlou8JjDmBQMGuPeWXYawUogxFKF1ix8zFMBMbnaWVWPnNWfm6PZq9NZ+usQFy8MdLDXuTHs7ENwGdhId8LoZK+QoDseBP2Q16t6ruzKitIeD3Nl+DTK8bLVaz6hxRwOetD3VER3dcL0ZcuRpwQaxRRINpv0795r12KW1FqGKsfnumF68YUm/MT8Ly4iJh953A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ke8NDTeIFRYHQieqJ8GBcWKs0pWsDAMFpv52ICcBcmk=;
 b=cgvHIDY2YsINHkPEpPdoN0sn/hGZHU4TCGrLAzAJ8V7BpUwnIQph5xz1t11Y6JSuuui/ebBhf0rZUJIrTDcQwhGDdMDO/TFLwFZDeXsTwr+kVNE2CNyH7mOO5dlpVZc4phEMgyPOck55jURlmOvyMpKSBvWatbqW+KGYHshAankBrPVwkHYvFFJAnG4R5lDVfXlbzytMEHUnCJeYfH2wkpRGe9u5ILxqKhU5y3SfhlHrTCSidETneoViXk8Bd7OdmL4SUW7I5ix+TbOy8so6DJCuXLUw90KSR4ZCEWW07oqy5usd0/aIOdSxklHUfFHTWYUC22GUzhwv9aNH+8lcsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ke8NDTeIFRYHQieqJ8GBcWKs0pWsDAMFpv52ICcBcmk=;
 b=fmOYHooaHTHmCatJeKhA0DP9I3ATrHeetozWOfe77fM3puuipP1TDLI6Gjm7R8SMrU2Ko9eUX77ocrGDR51NLfN0u3VS8t2ZCzqAJFkMTaHXxSF90Gr9hJ8FwdzUHgFtLJVnh3rMchRH8Vgu9Nlt3nASud9mwZd2yQxqhYiZHuM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3765.namprd12.prod.outlook.com (2603:10b6:610:25::18)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 06:06:58 +0000
Received: from CH2PR12MB3765.namprd12.prod.outlook.com
 ([fe80::300d:3bf6:2b71:b6af]) by CH2PR12MB3765.namprd12.prod.outlook.com
 ([fe80::300d:3bf6:2b71:b6af%7]) with mapi id 15.20.3499.018; Wed, 28 Oct 2020
 06:06:58 +0000
From: Flora Cui <flora.cui@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: rename nv_is_headless_sku()
Date: Wed, 28 Oct 2020 14:06:38 +0800
Message-Id: <20201028060638.2339229-2-flora.cui@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028060638.2339229-1-flora.cui@amd.com>
References: <20201028060638.2339229-1-flora.cui@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HKAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:d0::21) To CH2PR12MB3765.namprd12.prod.outlook.com
 (2603:10b6:610:25::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from flora.amd.com (58.247.170.242) by
 HKAPR04CA0011.apcprd04.prod.outlook.com (2603:1096:203:d0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 06:06:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9cf6ffed-34b2-45fc-893e-08d87b07ad7e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4133:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4133DE5DF4432B880D2CBECBFA170@CH2PR12MB4133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yK42/RC4tq5RiLl9G4k6dn1UP+u6vhKHzXaU6aOK0Ya4L6lYliykuJ+jcSX0SsXWSxm73JEutVVAAIsmuxMRa1o3HgxodoDNJYDKDjhSJ4wKHqYLgijTTuBdLuB2v3F/Jri711fQmcI4BDT69EWSSjKzBfpkyRMpn8rDGJoXux/T3SualqekzPCj8WYokKoDp+BDgXTPSEhbdGatQLWwE91tksbzpiRdJ/qaqqCGx3wG/0isrG9ISR0ZBPFOUHlpArZE6JF5U9VNlwJZNzfjFY0NhkVzTafhtzduNxL6v82xZ9HPQKc5jYEzWk3HFPjZugpbJMFHd6gxO8pH1zk+Lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3765.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(66946007)(54906003)(5660300002)(6486002)(16526019)(2906002)(8936002)(26005)(44832011)(7696005)(4326008)(186003)(316002)(8676002)(478600001)(956004)(86362001)(2616005)(52116002)(6916009)(36756003)(6666004)(66476007)(66556008)(83380400001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZaE0/FgYdcxXeYEDC0qEpALdN2awuZEOiczRj4yiKMVxNC63A4TEKLg8kpZiJg4EJIisdbae1PsxOSjB3s2pKwmBZ80gqRziMcCDaCpk9d9Qe9Dx3NMcJCv0eFYKL7fDid+xiAj0QhFrNUzOHzhfFqKBVQOsJlUK+DfmRqobznUNg9sNRFF2mpk0PgWqupyYANwTGQcAkYp5WFJGSHUJOjFJQ1/QZPT8vQZC47uHPi7kpb7sXni6IxS6KUrEWNwEG0xSY0ci+33t8g2Xa74U/PyBf/4CuEmVYy+jCvof7azb2UN/ERXRFH0Nvvxc67cMs9Hu3tKhVTFma+2PyeOnNdo46lB+oh/0bxjmkInPllcnBzEaaMw4wB9I7wMeOwt5XeuAgEYetLe6UALUnS/FVEt5ZHkmKN5WnetYRYtcI79P9TLuAK5aQnj4g4UMYZfeO69C4dDFXUcCQQyNF4X1cw35djqRUo/GQ3x3VELBv7kYXxLNp5cx4UPo80EFfegEyZMrA5eslQM9NXSwyCcNDF0rNN54da6+nJQ83YMzREc1eGW7VP+Sg1W8YGi8db9BQfZi8tRfVh15LDfFxEURfSLFDHf6wMZ8UJ+UyuWHTBtM/M//iwunjCth6LyMTZLKdIWni48o1byTv5ipcLxL+A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf6ffed-34b2-45fc-893e-08d87b07ad7e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 06:06:58.0872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bn9oqj5z0GZjo6sCGTNq9twYmpBa9Fe8Pwdj4rBHtS58J4LU28rXWiYppst1JPQU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133
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
Cc: Long Gang <Gang.Long@amd.com>, Chen Guchun <Guchun.Chen@amd.com>,
 Xu Feifei <Feifei.Xu@amd.com>, Yin Tianci <Tianci.Yin@amd.com>,
 Flora Cui <flora.cui@amd.com>, Teng Rui <Rui.Teng@amd.com>,
 Zhang Hawking <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

for headless NAVI ASICs

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 23446aceea1d..c65b4462bf5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -493,7 +493,7 @@ void nv_set_virt_ops(struct amdgpu_device *adev)
 	adev->virt.ops = &xgpu_nv_virt_ops;
 }
 
-static bool nv_is_blockchain_sku(struct pci_dev *pdev)
+static bool nv_is_headless_sku(struct pci_dev *pdev)
 {
 	if ((pdev->device == 0x731E &&
 	    (pdev->revision == 0xC6 || pdev->revision == 0xC7)) ||
@@ -536,7 +536,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 #if defined(CONFIG_DRM_AMD_DC)
 		else if (amdgpu_device_has_dc_support(adev) &&
-			 !nv_is_blockchain_sku(adev->pdev))
+			 !nv_is_headless_sku(adev->pdev))
 			amdgpu_device_ip_block_add(adev, &dm_ip_block);
 #endif
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
@@ -544,7 +544,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
 		    !amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-		if (!nv_is_blockchain_sku(adev->pdev))
+		if (!nv_is_headless_sku(adev->pdev))
 			amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
 		if (adev->enable_mes)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
