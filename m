Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5941BC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 10:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143242075F
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 10:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zqLOU7C5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143242075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EBEF6E43A;
	Thu, 30 Jul 2020 10:27:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 872226E43A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 10:27:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEzQ3kIi8obF61rzTgWPMpToSpbK3FDzh73WbHvuKWkDiSrd4yeCi584rVcz234bOza0z21bSyTeBLRsJ+83KceR85CWroy8CEojWaWwB5DZphACWz2gyLVw3sZ6ckflZ189jfdyt3X6x/AN2BUWxulvbHlsiGVr3n5omzlF9x6xIsAa1P/vCtOJ3CxcZ4kyV/IjZML9p35U0RJ0gzAQnQpbaKki1QCdNAeaO7yKzn//wlNzdI0Nxc28k51FJGg1id+3Zoz2+3e4YkWuv7MFTiyeVKRVsv3qoHXwPifwVwyDyMfWemMEy96bKrfOWywGOeDZjPwqOHNUPkhOnat1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzZsE0fN/lyLLDD5WFddG6yDRvrf/Y/sLwhmjMo8+Tk=;
 b=mO4iD7sdR8182dJSPyFHGqRTb2tpqDpzf1MpNlzxQRc8pJftx96b259TyQLBUayoTInwwMBHYiWhrD5EKZ4O2zkd5pubocfyQfuEkAc0ipNgOldI0lEhIu6MFBuuMfJYVNx4lxobm95O8klMKPr9RvMiS9rKl/uBjKgM4IvPpo8aaUr/oXlZxFLF9xFICSceBXTZ9CCUuBFJnsQJhTTeadDbl2HXL90LQ+oGvfQ6AtNuzBQQq+rxG9syfROR6M+w1BgymGelNMDyw7kd7LiyViJ7nZ0X75sn6SVmkf2sr0cIoa5XT9Czlmid4/CVnkZD/2gccHiRh2fFWtFYYxqxJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzZsE0fN/lyLLDD5WFddG6yDRvrf/Y/sLwhmjMo8+Tk=;
 b=zqLOU7C5dzgRcfv9y8Ve38qrIHyeT+VnpAYr3R5/BRK0H496SC8PM4ZoH6+Krl/ZBaVV8Krmd1oW+oW1VFVd9wUNJTXQT7QpP9AQQ4gSg7gqSaqv8V7LUYGp4cDeB4x6aHlAJrWkbtmtF4/vb5Vt0WHHL1KVF+GCNjJi31cfXXY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Thu, 30 Jul
 2020 10:27:15 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::d85e:c081:c3d:9db3]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::d85e:c081:c3d:9db3%4]) with mapi id 15.20.3216.033; Thu, 30 Jul 2020
 10:27:14 +0000
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: new ids flag for tmz
Date: Thu, 30 Jul 2020 12:25:02 +0200
Message-Id: <20200730102500.23479-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: PR0P264CA0253.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::25)
 To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from patasel.lan (109.190.135.109) by
 PR0P264CA0253.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 10:27:13 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [109.190.135.109]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9b98417a-7f8e-4a6e-eb61-08d834732096
X-MS-TrafficTypeDiagnostic: DM6PR12MB4266:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4266C5C3EA96BD7DF46F286E8D710@DM6PR12MB4266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kO7OwQ3CEOV1mYef7IiW+0xagXkyDqEURvvmFVBlJoFrDZFa/0OJdQuRTE5rmp19CfI+24otloSHssNkJ+NRpG/ar0DegFg57Of8/tKHu4xCIV65BTrwmoKyJU7IRgfRTVIQaees9XUVI2v6UYajZKiBDsr1UmWEk+UtMI+5KRL1GY0fVPkwXh0TJ/BQ1W0WofAGeyLQEU0eHeTsjqqYv/ddzokImMHlTHryIto+DOgOCEbjnCA2AaV9BHTdMot7DDvA5fkK6il8rgjLX1VE/S2FHAU3KqogRPRgfxUfe+AZYVTJ/sPsR1c9292Wg0UhsXrA1sn2dCiScmq/SEB3H6rFzHI5BKN+ck+i7z1sYwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(6666004)(956004)(6486002)(8936002)(316002)(6512007)(1076003)(6916009)(8676002)(8886007)(2616005)(26005)(2906002)(966005)(4326008)(52116002)(6506007)(36756003)(83380400001)(66476007)(55236004)(186003)(478600001)(66946007)(66556008)(5660300002)(86362001)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: XgjnrJ0m1WCO9FKho39oQeILlReoHjmCLhvbp8felFt9aFTClDblChlDonm0f5nsTISBPaLayV6tJXl3j9/PHIfmZEqGBzvGngyNLtL1I665EEav+sqRaWL+GIyAaJD5WJLWs1+z2AIOVhi8+OG9U8LLhTbsHgkx8WCDteHVbow4Ng3laTUnGa3WoF2OGHn8XVCbNNx9oA7gm0D8qw3EifldFMnuzTowcpvJQgpzc1kfnfbZvBF20PhIKgn90cSjD/QWCyHZmm5nsSxcyj8uAOEG+VMGAmtBe9wRwmGW0+nmh4cFTfWxv1PjLd14bM24uuCHzqfKpSKgs7WSbpol3eVrtgVTY/z43XkTXEhy+hSV9RUiRJiCQ5mnNUNwsvtyVx7zgbSLanpGxmepqNage85FyEkpy61KxW87b2/8bmP7eD1rIWAqUmioeZrrovZvS4rMrz6PuvEjGwacOUqN3h8G5dmLcNkKnFs+r3hZfNAYgRZlgR+ize2/CNSIPbu6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b98417a-7f8e-4a6e-eb61-08d834732096
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 10:27:14.8508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OarB627joscH7sjOc/YoT6xTaI6y3SHu83lvWlQLHjAfoIwLVUiqtDI2Z61Tj7OoldJSQP4K9z3+QcX0xW47aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allows UMD to know if TMZ is supported and enabled.
This commit also bumps KMS_DRIVER_MINOR so UMD knows if it can rely on
AMDGPU_IDS_FLAGS_TMZ.
---
Patch for using it in Mesa is at https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/6049
(ac/gpu_info: add detection of TMZ support).

Pierre-Eric

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 ++
 include/uapi/drm/amdgpu_drm.h           | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6291f5f0d223..6dcab25914cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -88,9 +88,10 @@
  * - 3.37.0 - L2 is invalidated before SDMA IBs, needed for correctness
  * - 3.38.0 - Add AMDGPU_IB_FLAG_EMIT_MEM_SYNC
  * - 3.39.0 - DMABUF implicit sync does a full pipeline sync
+ * - 3.40.0 - Add AMDGPU_IDS_FLAGS_TMZ
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	39
+#define KMS_DRIVER_MINOR	40
 #define KMS_DRIVER_PATCHLEVEL	0
 
 int amdgpu_vram_limit = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index eebbe2103e32..d92ee30bc06c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -736,6 +736,8 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
 			dev_info.ids_flags |= AMDGPU_IDS_FLAGS_FUSION;
 		if (amdgpu_mcbp || amdgpu_sriov_vf(adev))
 			dev_info.ids_flags |= AMDGPU_IDS_FLAGS_PREEMPTION;
+		if (adev->gmc.tmz_enabled)
+			dev_info.ids_flags |= AMDGPU_IDS_FLAGS_TMZ;
 
 		vm_size = adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
 		vm_size -= AMDGPU_VA_RESERVED_SIZE;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 765a94ec4420..b826f2d6efe1 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -676,6 +676,7 @@ struct drm_amdgpu_cs_chunk_data {
  */
 #define AMDGPU_IDS_FLAGS_FUSION         0x1
 #define AMDGPU_IDS_FLAGS_PREEMPTION     0x2
+#define AMDGPU_IDS_FLAGS_TMZ            0x4
 
 /* indicate if acceleration can be working */
 #define AMDGPU_INFO_ACCEL_WORKING		0x00
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
