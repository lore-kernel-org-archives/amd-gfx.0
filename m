Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E167C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB4764ED6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB4764ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A50956EB52;
	Wed, 24 Feb 2021 22:21:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE736EB53
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7QxrnmOPIv07jCWlVR9lZaadKA3XXrTDyJIbXDonMXX9jfFghUcc6eaDNBVS1Fnh/0tZab4qp9RS0Q0uiMkzC8bwUMzFuwn5yKXw1qK382/62HM3qyRnaHGfpWE9sAQvpLnV/4He3kUw7IStlC0k2FXs4w9IjnP/ypzrccStTmY0TJ9Oe2qEYoOaS7ujPM/+tIv5hyF4obY6HNGFJumG/wYtX8Wwxrlg9dDDPMStfunE9jWHnarX8WL2A8qfeY4gSH73c7ahAeiAk6WcyAt3Sq6Hdbvh9e80RgRVo7WmOvdr9LfGEAext5wD3P+HYGdM600kX/QbA0RaPJ+PTvpGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOqxooN3ehPbaByH1NQD7ykIJC7Q1CXHAIQWwOzS6hA=;
 b=gJ5NQZUaq2/QVX0VCHXO/MdqVJ1B+dQ40w/DYoKY6O+/Bd+R0uJsW4Ig8mBA/kNTrShAorO4nKNrKOeUMI6Jr5GZ9PtnN9mzUO60kgGYUaekfq4yTtf2fnI9bkhm0huTV2u02JsBcm9Ci5hVcdDUNTnEWH6vLdUzqmzFPnXoYgvTTEUrARByPNrc9CCZ8OssvPvHjBNIXwmwuJ+9hMsy9+YueycTjl+v+iXfkbZJJXjDO9zhNXOmr3Av3fMN3XYiI48YVe7y2ukpakXjcuSI4FImLWQnBT/PKl7vTkFZq/UoWjYJJW5NLBMitvAVkYbz9WBlG1u5YTVn+llZF8GwsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOqxooN3ehPbaByH1NQD7ykIJC7Q1CXHAIQWwOzS6hA=;
 b=gOp3JlCCCP1jj8+1qRKEivHHwrCdp3mDSDnM3iZyvHe37+wlvjysPTozPZXprxOj8NrnxshTiyBmXsZRKqJQZbP6qFpGhzLtK7qBpz+nirB0Hc0Wm5Pwgf4ZwfXsBtd9PxwDNA+1zWynOAqYwJ4czbLg03EnbKOAH5Ogw/E2DEY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2497.namprd12.prod.outlook.com (2603:10b6:207:4c::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:00 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:00 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 068/159] drm/amdgpu:add smu mode1/2 support for aldebaran
Date: Wed, 24 Feb 2021 17:17:28 -0500
Message-Id: <20210224221859.3068810-61-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c406b571-65a0-48c5-4723-08d8d912574a
X-MS-TrafficTypeDiagnostic: BL0PR12MB2497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2497848E101537D10AD281F5F79F9@BL0PR12MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:336;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +rt0nDHlMsUBqM6r73MnRRS3P6Vk4tizTnyyp58o+nJP9C7roSZn7n5M+SOjpfkJfjnmOmtqfHS3vMoPWAEmphh8JtDZEyX9drjVzEwbdcJN4/bFoh493N0nk7xgiVm/3vYWSZ1lPdRQyVpK1cFxvrBo3+HhSwLZ0AwzYtwRHXC4rhnPqVub7FIf6HdBr3DWA7hi2B4et3g/CdaUAhSq8341h4ZbBvzQCzjbZC57QKRea8Q8dI8fyE4d9tHIdogQX9ATi2MKJ+UUVMN5XoPGlr1JpZmezBxBO8oIZiKSQ1LQAO4il9wZaF5YAIbLDWCik1BAHYbk5UAZlA0m4I5T9dOj+10Et2wbHKMjX7OBPt4aE83dIDZqS1cH71hoxqVP+LXPRhNT9YghMNglN610GHS+KU9U3IzgIZllWa9oKRA30dwuOsPvZiPowblwrFFwWuf1IDTjq6bynuMmYHV9Bmvthkacq+aeTm/wjFLeATcyvy+AAFR4B2CWjhWkoUZZv1w4MEKqNlnNqVdAXhYp7E3BKMdMpiFvTetvZyGmX1an8wEsVAVZGq4lsY0tE8nlXmPRDf0gZwVU49hyAKuYxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(19627235002)(4326008)(69590400012)(8936002)(6512007)(54906003)(6916009)(26005)(956004)(6486002)(316002)(2616005)(52116002)(8676002)(6506007)(2906002)(86362001)(186003)(16526019)(36756003)(6666004)(478600001)(83380400001)(66946007)(66556008)(66476007)(30864003)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pMFlbP0ng5in0rPBrkKg9S34UNjwea6xKffsCC9aZFQQ64eKnLTt50GHQ/eF?=
 =?us-ascii?Q?GXQKQHM8sJMYr9BDEd2/9Tt3tbM6rDWEbK+9/Mes5YBvv+JAEmev7WktFABs?=
 =?us-ascii?Q?ZH2X3JsnhCI3RTqnh0SmGckIGKq1T6o40BO9PcBNXGsnAJdythvAE7mJAjpe?=
 =?us-ascii?Q?AdHsh+L4NaKrCqauRqkGJuBtKOy+UD4Y+BmOEWOkmuoN/qAnuMsx0pApqxFT?=
 =?us-ascii?Q?Q9jlrQGLbCz4rzb8Akjc1glHAHJFoCq4g52vhLw1SG4fMhxTIY8HAfKyaCaM?=
 =?us-ascii?Q?/mbSlMCK4PEhGmoDf2sWSqlw6dKpZ/EqATrGeArbirxDMZtR7z7YlRXxbaDU?=
 =?us-ascii?Q?MZv7Hf+oZpUT0Pc4LCZ6hz7bQf0Y92lB971rJyN6zZhu+pwoHubrlzrMq672?=
 =?us-ascii?Q?M4y/NNYH90jsjW7ewvfK/MfWro00eIpCRs61yT32f4JEyqF2UUzvAgETZNM3?=
 =?us-ascii?Q?7BSFrU4G+ckVT3m1PxSdYpgG1QTxmExkQWf2X9ntUf35MrMKjWl8W37XJ5Ao?=
 =?us-ascii?Q?VNUDPOd1Kmt9JqCqRB4urht9c3tukQsK9Nv+129NPHZM8czXk5FcYTPP4rr7?=
 =?us-ascii?Q?XfWr/hYmaYE2RLlcpkTSSYqI/ANFXYDZabxMTNNGpIoqU+T2+9iDzaSDBK8u?=
 =?us-ascii?Q?2f/MoM6vT/9mGvz3PzRf1zI9DXXoliODYgBDF8N4Qqa5JClU2foq4D5tza3F?=
 =?us-ascii?Q?M1C/uD48dcPH6UV+Ub8Ou6o+7yED6+0YTkNolC8/N4TRXfOiPqQc3CdNFq7/?=
 =?us-ascii?Q?aorCK+SDXIBvgHbaBCIVIMSpF+ybjw01TmwgRM9KTPQGj9xOa6itBkcFnD4H?=
 =?us-ascii?Q?0TfaDuV0HayqM3T1aKhzVPf3OQwmDejsnpJpiwqMPKttuVy5kT+MjD9nb16K?=
 =?us-ascii?Q?tncRi1Hdjk6nJ4+QgFFSX1K9F+1RuwZAqVx999zSoot3k88NP1qYuoDFSJYr?=
 =?us-ascii?Q?dhBGQhMMgBFhQe6sIIcp58xNqxs/Rov4fmE+ho9Uxk1gSTJwlN3DRnnQNhB3?=
 =?us-ascii?Q?tf1SIaZHtI1sQgifP8LCdxX8iUJr4Z9vqp5DEsBpxv7bq2I+doJsSxbU7mD4?=
 =?us-ascii?Q?QLT3qTGieCjh+T4kd40tJlI7eNPFxTX4eIvp66q15wgdZg5hkGOQ8G8ZojD2?=
 =?us-ascii?Q?3RLBEGb1dpfF+DtcmGFXxCtUU0DC6TVesEUSj3/b8vTpv9CtqmwJDJ7rQSy9?=
 =?us-ascii?Q?OpwxPc/bqFQnsyyi1PmUc7KIjfKl9K66JUCCN4TJpRxwdZyRdc7nLDQRFqyK?=
 =?us-ascii?Q?ejDHnNRVJjp80blN2lSUNOmpt4MAPfk2n7l+madiXUi5boTrXZ2TyKkAvCUJ?=
 =?us-ascii?Q?93si3w/0dP/Bg04dByv5/apk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c406b571-65a0-48c5-4723-08d8d912574a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:07.2140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /iyGmGphd8zFxQVZBp6GWxpeH6+vs9BkKRJ9exg5cuAbh+smQH6O0Q0zMrPEFXwtp6ZAAJkfEJKVaKaQT331UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2497
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Feifei Xu <Feifei.Xu@amd.com>

Use MSG_GfxDriverReset for mode reset and retire MSG_Mode1Reset.
Centralize soc15_asic_mode1_reset() and nv_asic_mode1_reset()functions.
Add mode2_reset_is_support() for smu->ppt_funcs.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 39 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c               | 40 +------------
 drivers/gpu/drm/amd/amdgpu/soc15.c            | 56 +++++++------------
 drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h  | 25 +++++++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  5 ++
 drivers/gpu/drm/amd/pm/inc/smu_types.h        |  1 +
 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h        |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 20 +++++++
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 32 ++++++++++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 26 ++++++++-
 11 files changed, 164 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0035c91943f6..0b3913d2f568 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1245,6 +1245,7 @@ void amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
 					     const u32 array_size);
 
 bool amdgpu_device_supports_atpx(struct drm_device *dev);
+int amdgpu_device_mode1_reset(struct amdgpu_device *adev);
 bool amdgpu_device_supports_boco(struct drm_device *dev);
 bool amdgpu_device_supports_baco(struct drm_device *dev);
 bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8cb9ac385840..cdec53bfead0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4241,6 +4241,45 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 		return false;
 }
 
+int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
+{
+        u32 i;
+        int ret = 0;
+
+        amdgpu_atombios_scratch_regs_engine_hung(adev, true);
+
+        dev_info(adev->dev, "GPU mode1 reset\n");
+
+        /* disable BM */
+        pci_clear_master(adev->pdev);
+
+        amdgpu_device_cache_pci_state(adev->pdev);
+
+        if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
+                dev_info(adev->dev, "GPU smu mode1 reset\n");
+                ret = amdgpu_dpm_mode1_reset(adev);
+        } else {
+                dev_info(adev->dev, "GPU psp mode1 reset\n");
+                ret = psp_gpu_reset(adev);
+        }
+
+        if (ret)
+                dev_err(adev->dev, "GPU mode1 reset failed\n");
+
+        amdgpu_device_load_pci_state(adev->pdev);
+
+        /* wait for asic to come out of reset */
+        for (i = 0; i < adev->usec_timeout; i++) {
+                u32 memsize = adev->nbio.funcs->get_memsize(adev);
+
+                if (memsize != 0xffffffff)
+                        break;
+                udelay(1);
+        }
+
+        amdgpu_atombios_scratch_regs_engine_hung(adev, false);
+        return ret;
+}
 
 static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 					struct amdgpu_job *job,
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 160fa5f59805..3cbe51108256 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -304,44 +304,6 @@ static int nv_read_register(struct amdgpu_device *adev, u32 se_num,
 	return -EINVAL;
 }
 
-static int nv_asic_mode1_reset(struct amdgpu_device *adev)
-{
-	u32 i;
-	int ret = 0;
-
-	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
-
-	/* disable BM */
-	pci_clear_master(adev->pdev);
-
-	amdgpu_device_cache_pci_state(adev->pdev);
-
-	if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
-		dev_info(adev->dev, "GPU smu mode1 reset\n");
-		ret = amdgpu_dpm_mode1_reset(adev);
-	} else {
-		dev_info(adev->dev, "GPU psp mode1 reset\n");
-		ret = psp_gpu_reset(adev);
-	}
-
-	if (ret)
-		dev_err(adev->dev, "GPU mode1 reset failed\n");
-	amdgpu_device_load_pci_state(adev->pdev);
-
-	/* wait for asic to come out of reset */
-	for (i = 0; i < adev->usec_timeout; i++) {
-		u32 memsize = adev->nbio.funcs->get_memsize(adev);
-
-		if (memsize != 0xffffffff)
-			break;
-		udelay(1);
-	}
-
-	amdgpu_atombios_scratch_regs_engine_hung(adev, false);
-
-	return ret;
-}
-
 static int nv_asic_mode2_reset(struct amdgpu_device *adev)
 {
 	u32 i;
@@ -444,7 +406,7 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 		break;
 	default:
 		dev_info(adev->dev, "MODE1 reset\n");
-		ret = nv_asic_mode1_reset(adev);
+		ret = amdgpu_device_mode1_reset(adev);
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index c45904b4ae23..275408c178f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -420,40 +420,6 @@ void soc15_program_register_sequence(struct amdgpu_device *adev,
 
 }
 
-static int soc15_asic_mode1_reset(struct amdgpu_device *adev)
-{
-	u32 i;
-	int ret = 0;
-
-	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
-
-	dev_info(adev->dev, "GPU mode1 reset\n");
-
-	/* disable BM */
-	pci_clear_master(adev->pdev);
-
-	amdgpu_device_cache_pci_state(adev->pdev);
-
-	ret = psp_gpu_reset(adev);
-	if (ret)
-		dev_err(adev->dev, "GPU mode1 reset failed\n");
-
-	amdgpu_device_load_pci_state(adev->pdev);
-
-	/* wait for asic to come out of reset */
-	for (i = 0; i < adev->usec_timeout; i++) {
-		u32 memsize = adev->nbio.funcs->get_memsize(adev);
-
-		if (memsize != 0xffffffff)
-			break;
-		udelay(1);
-	}
-
-	amdgpu_atombios_scratch_regs_engine_hung(adev, false);
-
-	return ret;
-}
-
 static int soc15_asic_baco_reset(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
@@ -478,13 +444,21 @@ static enum amd_reset_method
 soc15_asic_reset_method(struct amdgpu_device *adev)
 {
 	bool baco_reset = false;
+	bool connected_to_cpu = false;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
+        if (adev->gmc.xgmi.supported && adev->gmc.xgmi.connected_to_cpu)
+                connected_to_cpu = true;
+
 	if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
 	    amdgpu_reset_method == AMD_RESET_METHOD_MODE2 ||
 	    amdgpu_reset_method == AMD_RESET_METHOD_BACO ||
-	    amdgpu_reset_method == AMD_RESET_METHOD_PCI)
-		return amdgpu_reset_method;
+	    amdgpu_reset_method == AMD_RESET_METHOD_PCI) {
+		/* If connected to cpu, driver only support mode2 */
+                if (connected_to_cpu)
+                        return AMD_RESET_METHOD_MODE2;
+                return amdgpu_reset_method;
+        }
 
 	if (amdgpu_reset_method != -1)
 		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
@@ -510,6 +484,14 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 		if ((ras && ras->supported) && adev->pm.fw_version <= 0x283400)
 			baco_reset = false;
 		break;
+	case CHIP_ALDEBARAN:
+		 /*
+		 * 1.connected to cpu: driver issue mode2 reset
+		 * 2.discret gpu: driver issue mode1 reset
+		 */
+		if (connected_to_cpu)
+			return AMD_RESET_METHOD_MODE2;
+		break;
 	default:
 		break;
 	}
@@ -539,7 +521,7 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
 		return amdgpu_dpm_mode2_reset(adev);
 	default:
 		dev_info(adev->dev, "MODE1 reset\n");
-		return soc15_asic_mode1_reset(adev);
+		return amdgpu_device_mode1_reset(adev);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
index 302888376c7c..433dd1e9ec4f 100644
--- a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
@@ -36,7 +36,7 @@
 // Message Definitions:
 #define PPSMC_MSG_TestMessage                    0x1
 #define PPSMC_MSG_GetSmuVersion                  0x2
-#define PPSMC_MSG_Mode1Reset                     0x3
+#define PPSMC_MSG_GfxDriverReset                 0x3
 #define PPSMC_MSG_GetDriverIfVersion             0x4
 #define PPSMC_MSG_spare1                         0x5
 #define PPSMC_MSG_spare2                         0x6
@@ -70,8 +70,8 @@
 #define PPSMC_MSG_SetPptLimit                    0x22
 #define PPSMC_MSG_GetPptLimit                    0x23
 #define PPSMC_MSG_PrepareMp1ForUnload            0x24
-#define PPSMC_MSG_PrepareMp1ForReset             0x25
-#define PPSMC_MSG_SoftReset                      0x26
+#define PPSMC_MSG_PrepareMp1ForReset             0x25 //retired in 68.07
+#define PPSMC_MSG_SoftReset                      0x26 //retired in 68.07
 #define PPSMC_MSG_RunDcBtc                       0x27
 #define PPSMC_MSG_DramLogSetDramAddrHigh         0x28
 #define PPSMC_MSG_DramLogSetDramAddrLow          0x29
@@ -92,7 +92,24 @@
 #define PPSMC_MSG_DisableDeterminism             0x3A
 #define PPSMC_MSG_SetUclkDpmMode                 0x3B
 
-#define PPSMC_Message_Count                      0x3C
+//STB to dram log
+#define PPSMC_MSG_DumpSTBtoDram                     0x3C
+#define PPSMC_MSG_STBtoDramLogSetDramAddrHigh       0x3D
+#define PPSMC_MSG_STBtoDramLogSetDramAddrLow        0x3E
+#define PPSMC_MSG_STBtoDramLogSetDramSize           0x3F
+#define PPSMC_MSG_SetSystemVirtualSTBtoDramAddrHigh 0x40
+#define PPSMC_MSG_SetSystemVirtualSTBtoDramAddrLow  0x41
+
+#define PPSMC_Message_Count                      0x42
+
+//PPSMC Reset Types
+#define PPSMC_RESET_TYPE_WARM_RESET              0x00
+#define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET     0x01 //driver msg argument should be 1 for mode-1
+#define PPSMC_RESET_TYPE_DRIVER_MODE_2_RESET     0x02 //and 2 for mode-2
+#define PPSMC_RESET_TYPE_PCIE_LINK_RESET         0x03
+#define PPSMC_RESET_TYPE_BIF_LINK_RESET          0x04
+#define PPSMC_RESET_TYPE_PF0_FLR_RESET           0x05
+
 
 typedef enum {
   GFXOFF_ERROR_NO_ERROR,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index a78c8c9220fd..8ad87ddb342c 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1044,6 +1044,10 @@ struct pptable_funcs {
 	 * @mode1_reset_is_support: Check if GPU supports mode1 reset.
 	 */
 	bool (*mode1_reset_is_support)(struct smu_context *smu);
+	/**
+	 * @mode2_reset_is_support: Check if GPU supports mode2 reset.
+	 */
+	bool (*mode2_reset_is_support)(struct smu_context *smu);
 
 	/**
 	 * @mode1_reset: Perform mode1 reset.
@@ -1281,6 +1285,7 @@ int smu_baco_enter(struct smu_context *smu);
 int smu_baco_exit(struct smu_context *smu);
 
 bool smu_mode1_reset_is_support(struct smu_context *smu);
+bool smu_mode2_reset_is_support(struct smu_context *smu);
 int smu_mode1_reset(struct smu_context *smu);
 int smu_mode2_reset(struct smu_context *smu);
 
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index e9a0bda98fd7..207d5d923c9e 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -184,6 +184,7 @@
 	__SMU_DUMMY_MAP(GET_UMC_FW_WA), \
 	__SMU_DUMMY_MAP(Mode1Reset), \
 	__SMU_DUMMY_MAP(RlcPowerNotify),                 \
+	__SMU_DUMMY_MAP(GfxDriverReset), \
 	__SMU_DUMMY_MAP(SetHardMinIspiclkByFreq),        \
 	__SMU_DUMMY_MAP(SetHardMinIspxclkByFreq),        \
 	__SMU_DUMMY_MAP(SetSoftMinSocclkByFreq),         \
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
index 699b656bbd71..ef9dad9a51ff 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
@@ -220,6 +220,7 @@ int smu_v13_0_baco_enter(struct smu_context *smu);
 int smu_v13_0_baco_exit(struct smu_context *smu);
 
 int smu_v13_0_mode1_reset(struct smu_context *smu);
+int smu_v13_0_mode2_reset(struct smu_context *smu);
 
 int smu_v13_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
 				    uint32_t *min, uint32_t *max);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b1c30a6cb16e..cf81b2ac2232 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1819,6 +1819,9 @@ int smu_set_mp1_state(struct smu_context *smu,
 		msg = SMU_MSG_PrepareMp1ForUnload;
 		break;
 	case PP_MP1_STATE_RESET:
+	/*TODO: since the SMU_MSG_PrepareMp1ForReset is retired in Aldebaran
+	* Add handling here forAldebaran.
+	*/
 		msg = SMU_MSG_PrepareMp1ForReset;
 		break;
 	case PP_MP1_STATE_NONE:
@@ -2581,6 +2584,23 @@ bool smu_mode1_reset_is_support(struct smu_context *smu)
 	return ret;
 }
 
+bool smu_mode2_reset_is_support(struct smu_context *smu)
+{
+	bool ret = false;
+
+	if (!smu->pm_enabled)
+		return false;
+
+	mutex_lock(&smu->mutex);
+
+	if (smu->ppt_funcs && smu->ppt_funcs->mode2_reset_is_support)
+		ret = smu->ppt_funcs->mode2_reset_is_support(smu);
+
+	mutex_unlock(&smu->mutex);
+
+	return ret;
+}
+
 int smu_mode1_reset(struct smu_context *smu)
 {
 	int ret = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index bdefb9078847..475bd5aff6c9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -45,6 +45,7 @@
 #include <linux/pci.h>
 #include "amdgpu_ras.h"
 #include "smu_cmn.h"
+#include "mp/mp_13_0_2_offset.h"
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -108,7 +109,7 @@ static const struct cmn2asic_msg_mapping aldebaran_message_map[SMU_MSG_MAX_COUNT
 	MSG_MAP(GetPptLimit,			     PPSMC_MSG_GetPptLimit,			1),
 	MSG_MAP(PrepareMp1ForUnload,		     PPSMC_MSG_PrepareMp1ForUnload,		0),
 	MSG_MAP(PrepareMp1ForReset,		     PPSMC_MSG_PrepareMp1ForReset,		0),
-	MSG_MAP(Mode1Reset,			     PPSMC_MSG_Mode1Reset,			0),
+	MSG_MAP(GfxDriverReset,			     PPSMC_MSG_GfxDriverReset,			0),
 	MSG_MAP(SoftReset,			     PPSMC_MSG_SoftReset,			0),
 	MSG_MAP(RunDcBtc,			     PPSMC_MSG_RunDcBtc,			0),
 	MSG_MAP(DramLogSetDramAddrHigh,		     PPSMC_MSG_DramLogSetDramAddrHigh,		0),
@@ -1250,6 +1251,31 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_0);
 }
 
+static bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	u32 smu_version;
+	uint32_t val;
+	/**
+	 * PM FW version support mode1 reset from 68.07
+	 */
+	smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if ((smu_version < 0x00440700))
+		return false;
+	/**
+	 * mode1 reset relies on PSP, so we should check if
+	 * PSP is alive.
+	 */
+	val = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+
+	return val != 0x0;
+}
+
+static bool aldebaran_is_mode2_reset_supported(struct smu_context *smu)
+{
+	return true;
+}
+
 static const struct pptable_funcs aldebaran_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = aldebaran_get_allowed_feature_mask,
@@ -1305,6 +1331,10 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.get_gpu_metrics = aldebaran_get_gpu_metrics,
+	.mode1_reset_is_support = aldebaran_is_mode1_reset_supported,
+	.mode2_reset_is_support = aldebaran_is_mode2_reset_supported,
+	.mode1_reset = smu_v13_0_mode1_reset,
+	.mode2_reset = smu_v13_0_mode2_reset,
 };
 
 void aldebaran_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 20fff2fda13f..15033caeacb7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1349,15 +1349,39 @@ int smu_v13_0_set_azalia_d3_pme(struct smu_context *smu)
 
 int smu_v13_0_mode1_reset(struct smu_context *smu)
 {
+	u32 smu_version;
 	int ret = 0;
+	/*
+	* PM FW support SMU_MSG_GfxDeviceDriverReset from 68.07
+	*/
+	smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (smu_version < 0x00440700)
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
+	else
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_1, NULL);
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
 	if (!ret)
 		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
 
 	return ret;
 }
 
+int smu_v13_0_mode2_reset(struct smu_context *smu)
+{
+	u32 smu_version;
+	int ret = 0;
+	struct amdgpu_device *adev = smu->adev;
+	smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (smu_version >= 0x00440700)
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_2, NULL);
+	else
+		dev_err(adev->dev, "smu fw 0x%x does not support MSG_GfxDeviceDriverReset MSG\n", smu_version);
+	/*TODO: mode2 reset wait time should be shorter, will modify it later*/
+	if (!ret)
+		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
+	return ret;
+}
+
 int smu_v13_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
 				    uint32_t *min, uint32_t *max)
 {
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
