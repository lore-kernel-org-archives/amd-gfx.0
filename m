Return-Path: <SRS0=Eo7T=DR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C575BC433E7
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2020 07:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5728A2078B
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2020 07:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YYwg96U1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5728A2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 549DF6E0E3;
	Sat, 10 Oct 2020 07:57:40 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680068.outbound.protection.outlook.com [40.107.68.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49A6D6E0E3
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Oct 2020 07:57:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSyrVq41Q1Mwwd/QKowaMWQE6WOQAPL0SINzMCvJzfGa6PlY58wdttxsaBDGP72JcMh98h8LhTxbOxyDPavtVwtxZ6MMB70E+2Pze79QPed6t1XatZgn43eyZHXrRZvchrN2ZZBHQDfzjepJfsAHbuR/T11xSLZycLvErtnrNygo3S19FGYkI1o9cXRl1DF3Jsl57QdJL7EUOcwXr5kPJRPJQgGCa8W97Fn85mhghH6nqTtyxhXtdqOp3LAPUHG8FmQ/SysV7bPIJ27dpoITwbnEvIDStvmSnDsoABQIGAaje82+RWNcG+uoBqrzwqUj9pYc3t3BmjuAWsFThrnKwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MXW3Ou9+rYC6/XXaLYh/wc1SnxYzCleQ0YJTm2uJfM=;
 b=M5OMSi9Lbn+MgnCnDiZMGElztorEDWI6D5CiLMSj+JUEiUAaSsSkduEsZneuTd6jnqp3Kmgv9YbVR35WfJkGeJHVLFjDWsr9avhr68PI2MGP16TyCWLD9Oy/fvuyDNTialRGBJDX5/F3g6nW+2S9MdlBXBDnRqf0s6GQDKSKEaW4YINMroH3kVuQnXx5Sup6TFq3d53z+R2eki4kH53um/zhTu6uEoOn2UdaZ9XGZod/3vy62es2BXgvknAhmTL2+V5eO+AI0neEakjHAwCYbFN61Cv9NmMXGR3sfPGIiUBDILMG3Jj5afA0AjKGyglHvMgU7Kmm/VQwS8riCei6JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MXW3Ou9+rYC6/XXaLYh/wc1SnxYzCleQ0YJTm2uJfM=;
 b=YYwg96U1QFTOUiKZVAni/hOkIKKiuJ5/KKGgM/WgEBGS2nU/0sa+lyaGXAS0sVWBty+M9TXBJ9HfedyfASCrPUcmmRcCFTwe8IlDtbTI5+gYk4tzLPAfYuMynqjwbUh/QXO3BbifMDZiQPO537Wv9AVGndD0RBJeS5x9mLJNYPI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB2998.namprd12.prod.outlook.com (2603:10b6:a03:dd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Sat, 10 Oct
 2020 07:57:36 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf%4]) with mapi id 15.20.3455.027; Sat, 10 Oct 2020
 07:57:36 +0000
From: Tao Zhou <tao.zhou1@amd.com>
To: jiansong.chen@amd.com, jack.gui@amd.com, hawking.zhang@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: add DM block for dimgrey_cavefish
Date: Sat, 10 Oct 2020 15:57:19 +0800
Message-Id: <20201010075719.16491-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201010075719.16491-1-tao.zhou1@amd.com>
References: <20201010075719.16491-1-tao.zhou1@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To BYAPR12MB2888.namprd12.prod.outlook.com
 (2603:10b6:a03:137::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from taozhou1u2.amd.com (58.247.170.242) by
 HKAPR04CA0012.apcprd04.prod.outlook.com (2603:1096:203:d0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21 via Frontend Transport; Sat, 10 Oct 2020 07:57:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6f2ec6e3-1009-4112-03fc-08d86cf226f5
X-MS-TrafficTypeDiagnostic: BYAPR12MB2998:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB299877742371E13269F725C2B0090@BYAPR12MB2998.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWaUIL93BVGT5OjRKv6XuUKeq1d8ZMdP8ikcLq3xUOdEzqsHApt8FtUHYx6I2J2kYJjU66vsy2Lx9gmBDLIWP60oh4AbrksjYMVrF1FCU7DBRVLm+MOmqQi763TBNx9q3MbvRdlOG5Qphqp4n8gvpti33Gjfw7lH6yM/iZaGk7v0qjklX8a8M/alZ0aGAVowL/7eL9sOvTbTAReer+L0+um5377DleNoFaiG73KrIxQ7s0m8wZ9IBx2AFQ8o/y88HXMCmoGZyrqIifIsWMHI1bY9j9H3ieHgkFNaWQI+k98hfY4Mu+H2q8m1Hu1ZMd7p1k9xuNiuwg4Nhu83KVmFrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(6486002)(66476007)(5660300002)(26005)(186003)(7696005)(478600001)(83380400001)(8936002)(52116002)(66946007)(956004)(6666004)(16526019)(2906002)(36756003)(66556008)(2616005)(1076003)(316002)(8676002)(4326008)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KRcPLBzDlyShJD8q1D5LHZdyITrbbXYnBICbSyKdwsO9HKpYSTv6T/mntUDqYUGlRyzCeKYo7vzNO/M1Srhf6Osgr0BBPPAEg3F3qMdjcAmDVxZ2ATsKP713gFiR38X+ux+ewAvzNlvpjuV2//Vj7TwVY74B/2VVXcymlMAmnL8XedofvRi409XxZ+IQZU1suXdjaKCk/dMEIZkIwKmE8/vgfBU8scOQPQfwoHtXmhjTEBtI2L801Ia03XLhFzGz3q98FhAt1IcHv6J8LaFQh2hqVZkQ7m6Ed9ZwgzxB3uPE7/3nRjBV3E2J9ZDmKuj//mEelC0w9rodEv+7HeGp44eqX1iHDqyA+VTobdr4/6vYi3EkiPfxSC1FDpWRIsXX3L8Q+MSBwFHbZDVpCJyv501XPVQvdcsNUfvThFM9mHsp8y2BvadZcXBu8xIxNdt2wVkj1PHIAoox8CYMXuyPQvi64rQRiOMcQy42AcBzg3hMZ13K0wfaHwm1IEUCbTahi2d+Fo/Vct8OUDza+h+/UxBA3SCryQNjrZDOjfni4Aw89no4JPwRheJm29rFlaYL4R6WR8EQ3tIecYVm7ttCNuGoQts6FA3xNqAtyndDT2+oI9Pjkf9jP1XNkOiUXJrxWSNHUkDyMx/JG0aTIKbfOA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2ec6e3-1009-4112-03fc-08d86cf226f5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2020 07:57:36.7940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7MlJ5WgHCIBYlfN2tgHiO3B/4ctbDjF/MeYRZULeSw0mnaZnMQBi9sRUzti+6wTt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2998
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add DM block support for dimgrey_cavefish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/nv.c            | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8de930108db4..a2f0ce854160 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3013,6 +3013,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 #endif
 		return amdgpu_dc != 0;
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index e6bc7f09ec43..47bd79c9e6ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -637,6 +637,10 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
+#if defined(CONFIG_DRM_AMD_DC)
+                else if (amdgpu_device_has_dc_support(adev))
+                        amdgpu_device_ip_block_add(adev, &dm_ip_block);
+#endif
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
