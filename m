Return-Path: <SRS0=AKuh=J7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16C2C43460
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 21:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5B2613D2
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 21:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5B2613D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E22186EB76;
	Tue,  4 May 2021 21:48:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE7AD6EB92
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 21:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8huBGZgzzgkDeh1NfhHOOFd5rfNGafJqo7FJDtqduK47/IFv5b3nsgO7pPm24VkCx6k2/Tf8ExWrkD0hL/tGGij+S6HnWmI5r9SBNyH6mbATaf7KiJtVB4dO/FSibBVP6C0gDmfz049ODeBOP+A6SNqWlhZk4pAwuZnnIlwvNwQpKSkRUkxXio3B8JjIVf/ZZPF7TWxkEiwnuMVxbdBaRYsU5u0meRyY/SrFbPb9iScNfHsvqnqgqduSiCJkVGEDGSUwQ/ljNeJqb4VSb7S0kbbtIB23NFHy+74sUgycuy/vXJnOa4z02GE8CJxpDMlnYndKH5AzffTAK+eDK/PrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3aLPStNSDYdJUdXKOC/rK7FjuXkZH6GZDreV3jysqg=;
 b=NwgopIikoGTeMAyd38q/KEJY49gQw2x7GDeWo+TxjObFlXIhEwhC1J7AlF0XkJk8HdMpchBeWexBSTDvjFne6vmKtO8pTYRgkm/D7bbmZyTEwdlqxM4o2t1wAdC3vmn7EhRnBiHVxGvUEbECTShGGs7gGtc2HqqNO9Mi+gVM3PtMMdO3I4YFaA8R58SGEH15Bq+8oLldPavymn2gE2SWiLoZrsPbTlcQu19t29xhit7X720HCRv0Uw92HXLQnaBAnmmwoRQFFUFe6ypfvE22/cHQOLjCmG8iuil0Mm3YPGk5lBoUi5QLkd+Bkdx8QfdtsnCimmj8mA8t7eJJrYvcqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3aLPStNSDYdJUdXKOC/rK7FjuXkZH6GZDreV3jysqg=;
 b=qT6BlNFuzeDzC2+YgVCvXi5y4NUowLvR7FzPG0Y06yAP8xAHGXHwIRJ1wHMJsf66AhCywZYyH2uuJW9phSWXnj5m1blB3g+ge6u9//3geZZIziW2YpKqnCQPLRhygv4KJCc4cdqg3ZmMpJO6WM2wxnSpGXYA60nnyT6IPg2Vme0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Tue, 4 May
 2021 21:48:20 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4108.024; Tue, 4 May 2021
 21:48:20 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: Remove redundant ras->supported
Date: Tue,  4 May 2021 17:47:53 -0400
Message-Id: <20210504214756.3816-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.0.97.g1424303384
In-Reply-To: <20210504214756.3816-1-luben.tuikov@amd.com>
References: <20210504214756.3816-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::30) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.38 via Frontend Transport; Tue, 4 May 2021 21:48:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7002e13d-0a6b-44b6-7f0b-08d90f465578
X-MS-TrafficTypeDiagnostic: DM6PR12MB4155:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB41559939DA644DD1A677099B995A9@DM6PR12MB4155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N9ZfFpLCf/ilOQbhA9B39CqQuDz2S/hqbXkFmCCfWwCodq5KbGexKh6yX+xiwbV8xO8WHzyUvboWLkKuTWJtiBtsr32kQr+8mURC0koRbSJ4jAjEwPfFSctbhLbqT15HkZI/7OITR/5ugP8IwTgFLlKmyaoZ4dAUi31egHuQHf7Ed5hv4Aah3aNhrj2HCp0AIMKuEEhxfMDkIK3MFmRY3YTDFexW5RvDeZpvu30NnxCzPQMsRR5aNPmwFEe85XPOAuxPNJp/sGPFT9l/MFuk9PmYXq6r74J+4ySWe3+ExcF4S119iJ46w3MO0s0smAF77UEBwdYvHU7+es9/7K6hOrTHS8/n07xp8fAaEAR0q48anDP1c9lUIHb0NbNZzLL772hjlVK752bAN6oGtJ89yauBfFHSE1ErvhHOJwrEPqyl/uqpxn4CPMMZdhnsWgYk8Iir4h79L268OT6J7fcoxJfU3s6Ixl5MPd9qDDveSm7+11Tu58i74XISZglreCxWYWCIKxyOGc/oQAuYh3jTJ5oNd4EPrN40uDQoKJvLoZ4WTB3GqaTCKJo+VKrxPxbyvmk5e0kNnV/YlDoEccKobF3qS17dhlgF4kStWHDQbJrDcasaYDusEYxxCpjX20AGeHhjThMKQlazEMr9qJvPOP8EKpQbT1zgVHJHTpqerNpfT0aTY9uC6YnCjczMZt87
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(478600001)(83380400001)(66476007)(6486002)(2906002)(186003)(2616005)(6666004)(44832011)(5660300002)(36756003)(4326008)(16526019)(316002)(26005)(55236004)(6506007)(66946007)(52116002)(86362001)(8676002)(8936002)(956004)(6512007)(38100700002)(54906003)(66556008)(6916009)(38350700002)(1076003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2X/SgwisY5NkJ9bPgQkhbKYoYgkbDoDlGTH3OEiF/pkOmPULB9x567xp2K96?=
 =?us-ascii?Q?HB3TTJ0JSVEMuGd9NXPKy3QnOgbKc0+4Bkh5muxKrnA/C9ZvWTF00a8+9kZS?=
 =?us-ascii?Q?iVeXi4CaKau4DvOXnHFA+gGYZBY6aETymYLDqJM0mp1tupXG9phTBzL+8aOG?=
 =?us-ascii?Q?XHiWgodTIKpFvzir64QtnTycJiE7e8Nsm9rX8ks8MiOVFN1jxqS1vSdXhmei?=
 =?us-ascii?Q?OW3wA7mWdwjdOph3tkFKTKYrqdXFenTVjAhShjUlCnkcwEt6mYA0ZA/H7i5j?=
 =?us-ascii?Q?p3zLuovr85eahVpCKuGSlDTCQwfW+Np0a4srRysAuZiJM/IDN/8IaY569MBe?=
 =?us-ascii?Q?rNcHjk7hJzeyxZ16v9g6+RylEeun1xDi2VNi/m6SnJd/UoxAYGOHfl4dW2uD?=
 =?us-ascii?Q?TrlKTtG+AgvkNOZkGkjssLJDe9vAKD8ZWUpW7KVTUZxpoDCFbKZ1aQFZBCkR?=
 =?us-ascii?Q?FcWy7gXz+V262xmTraVqJRrwsI+42X41yKoxvQ8YtAsNCi+CPHkL7MIIJiNu?=
 =?us-ascii?Q?ommfT/HAokShQIxy5C36wa/xTAsSxnVFgoJXdXAcx8Dpb2GOsOnVMSHJK75C?=
 =?us-ascii?Q?oWYm0Au3XRwYXmlO7fE0xrPwzMJuVnrQH3a0BWz+D8MZB9pLy8ujzk7Ug8x6?=
 =?us-ascii?Q?6aoyAiFx0zvqh1ME4FqVXnwhzUj1eXkmF7H50kNphuurB/E6N9g+PmCpFTUI?=
 =?us-ascii?Q?wxficJRs2uRB/BCH+e0TzUJm8K1pSAppz359vPwY329Vi6EiqQU9NAr7Bp3Z?=
 =?us-ascii?Q?6/koR9U9EhOSgGZ1Iof/DW4QrDhux/WtM2IKwVJRwjmopcEXZi6DREaeJK9G?=
 =?us-ascii?Q?O+kWGbf4aRM5p2teMmmX1XVqfwqZmQwyUy18XfFzi8eOvP5Z46Ox+7tPTBII?=
 =?us-ascii?Q?3GPUhKRuqPvVfezGE28Egfw+HO1WnSvH3SCYWB9m8TbUPfA3vkFdqrcEVRS9?=
 =?us-ascii?Q?xKY0URAOy0r+IdAI6426QW3WN8gEtIOAHsyRrmCiRvx2oWJLxOUh1svOmtAG?=
 =?us-ascii?Q?5zfyVaWspSi/9aU8SKBZtYxgEUqlZpNljfV/RjYNb+dmXRmlzIbCeN5GE5to?=
 =?us-ascii?Q?14R1badZbwJ4awlGS9EWWqGXaOB4TmbCUILYpyh1E6eE6VIn5gxw8MwhwSm2?=
 =?us-ascii?Q?OiaGPZwI6jH43a3E4daqgVjf7Mm32fVUYasCV0bgS01IrK3v04sse8u6Hkhh?=
 =?us-ascii?Q?g8+J6KdTvEYzOMNHxeAueg2/0ZPdTkj25apgK0/m1eLUabA+SfyW9Cw4g7De?=
 =?us-ascii?Q?hCkUN6kQRTek1oUDK/iSN2ML8iWuAnJTT8NEAD92tCdDk/t7tEneZemFsMP+?=
 =?us-ascii?Q?qSp1r8eTXw+3ZvRSpgn3ADQS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7002e13d-0a6b-44b6-7f0b-08d90f465578
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 21:48:20.9091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4miy73OxipAQ0OwXFMqmL7wcYlK9rAqMxsromirHIdyoljWwOvOEBlgWS1+GTMip
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove redundant ras->supported, as this value
is also stored in adev->ras_features.

Use adev->ras_features, as that supercedes "ras",
since the latter is its member.

The dependency goes like this:
ras <== adev->ras_features <== hw_supported,
and is read as "ras depends on ras_features, which
depends on hw_supported." The arrows show the flow
of information, i.e. the dependency update.

"hw_supported" should also live in "adev".

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c              | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c              | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c              | 9 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h              | 4 +---
 drivers/gpu/drm/amd/amdgpu/soc15.c                   | 7 ++++---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c       | 3 ++-
 8 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 357f9405f1aa..80631f999fce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5110,7 +5110,8 @@ int amdgpu_device_baco_enter(struct drm_device *dev)
 	if (!amdgpu_device_supports_baco(adev_to_drm(adev)))
 		return -ENOTSUPP;
 
-	if (ras && ras->supported && adev->nbio.funcs->enable_doorbell_interrupt)
+	if (ras && adev->ras_features &&
+	    adev->nbio.funcs->enable_doorbell_interrupt)
 		adev->nbio.funcs->enable_doorbell_interrupt(adev, false);
 
 	return amdgpu_dpm_baco_enter(adev);
@@ -5129,7 +5130,8 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 	if (ret)
 		return ret;
 
-	if (ras && ras->supported && adev->nbio.funcs->enable_doorbell_interrupt)
+	if (ras && adev->ras_features &&
+	    adev->nbio.funcs->enable_doorbell_interrupt)
 		adev->nbio.funcs->enable_doorbell_interrupt(adev, true);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index abd9bfa419ea..0327ac403423 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1005,7 +1005,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 		if (!ras)
 			return -EINVAL;
-		ras_mask = (uint64_t)ras->supported << 32 | ras->features;
+		ras_mask = (uint64_t)adev->ras_features << 32 | ras->features;
 
 		return copy_to_user(out, &ras_mask,
 				min_t(u64, size, sizeof(ras_mask))) ?
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 17b728d2c1f2..4885b718cb6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2146,7 +2146,7 @@ static int psp_load_smu_fw(struct psp_context *psp)
 		return 0;
 
 	if ((amdgpu_in_reset(adev) &&
-	     ras && ras->supported &&
+	     ras && adev->ras_features &&
 	     (adev->asic_type == CHIP_ARCTURUS ||
 	      adev->asic_type == CHIP_VEGA20)) ||
 	     (adev->in_runpm &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ebbe2c5190c4..a484ac6a8399 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2130,9 +2130,8 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 	/* hw_supported needs to be aligned with RAS block mask. */
 	*hw_supported &= AMDGPU_RAS_BLOCK_MASK;
 
-	*supported = amdgpu_ras_enable == 0 ?
-			0 : *hw_supported & amdgpu_ras_mask;
-	adev->ras_features = *supported;
+	*supported = amdgpu_ras_enable == 0 ? 0 :
+		*hw_supported & amdgpu_ras_mask;
 }
 
 int amdgpu_ras_init(struct amdgpu_device *adev)
@@ -2154,7 +2153,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	amdgpu_ras_set_context(adev, con);
 
 	amdgpu_ras_check_supported(adev, &con->hw_supported,
-			&con->supported);
+				   &adev->ras_features);
 	if (!con->hw_supported || (adev->asic_type == CHIP_VEGA10)) {
 		/* set gfx block ras context feature for VEGA20 Gaming
 		 * send ras disable cmd to ras ta during ras late init.
@@ -2210,7 +2209,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 
 	dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
 			"hardware ability[%x] ras_mask[%x]\n",
-			con->hw_supported, con->supported);
+			con->hw_supported, adev->ras_features);
 	return 0;
 release_con:
 	amdgpu_ras_set_context(adev, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 60df268a0c66..3e830dc1a33d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -314,8 +314,6 @@ struct amdgpu_ras {
 	/* ras infrastructure */
 	/* for ras itself. */
 	uint32_t hw_supported;
-	/* for IP to check its ras ability. */
-	uint32_t supported;
 	uint32_t features;
 	struct list_head head;
 	/* sysfs */
@@ -478,7 +476,7 @@ static inline int amdgpu_ras_is_supported(struct amdgpu_device *adev,
 
 	if (block >= AMDGPU_RAS_BLOCK_COUNT)
 		return 0;
-	return ras && (ras->supported & (1 << block));
+	return ras && (adev->ras_features & (1 << block));
 }
 
 int amdgpu_ras_recovery_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 28e9f6b726a6..29c8ee267990 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -655,7 +655,7 @@ static int soc15_asic_baco_reset(struct amdgpu_device *adev)
 	int ret = 0;
 
 	/* avoid NBIF got stuck when do RAS recovery in BACO reset */
-	if (ras && ras->supported)
+	if (ras && adev->ras_features)
 		adev->nbio.funcs->enable_doorbell_interrupt(adev, false);
 
 	ret = amdgpu_dpm_baco_reset(adev);
@@ -663,7 +663,7 @@ static int soc15_asic_baco_reset(struct amdgpu_device *adev)
 		return ret;
 
 	/* re-enable doorbell interrupt after BACO exit */
-	if (ras && ras->supported)
+	if (ras && adev->ras_features)
 		adev->nbio.funcs->enable_doorbell_interrupt(adev, true);
 
 	return 0;
@@ -710,7 +710,8 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 		 * 1. PMFW version > 0x284300: all cases use baco
 		 * 2. PMFW version <= 0x284300: only sGPU w/o RAS use baco
 		 */
-		if ((ras && ras->supported) && adev->pm.fw_version <= 0x283400)
+		if (ras && adev->ras_features &&
+		    adev->pm.fw_version <= 0x283400)
 			baco_reset = false;
 		break;
 	case CHIP_ALDEBARAN:
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
index 2a28c9df15a0..f6b1efce450c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
@@ -85,7 +85,7 @@ int vega20_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STATE state)
 		return 0;
 
 	if (state == BACO_STATE_IN) {
-		if (!ras || !ras->supported) {
+		if (!ras || !adev->ras_features) {
 			data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
 			data |= 0x80000000;
 			WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL, data);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 6274cae4a065..72581e43d83e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1531,7 +1531,8 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 								      NULL);
 			break;
 		default:
-			if (!ras || !ras->supported || adev->gmc.xgmi.pending_reset) {
+			if (!ras || !adev->ras_features ||
+			    adev->gmc.xgmi.pending_reset) {
 				if (adev->asic_type == CHIP_ARCTURUS) {
 					data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL_ARCT);
 					data |= 0x80000000;
-- 
2.31.0.97.g1424303384

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
