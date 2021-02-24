Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4F8C4332D
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC73064EF5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC73064EF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F23C6EBA1;
	Wed, 24 Feb 2021 22:22:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFAE36EB98
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8kdak5A1TFjJQc6B7dWX6rU2B5sQ7Qp6tGdSrWtp0l61gSo/83A7NkuLiHn/XHqZQ5uRmKAVEwRZA4/eAht+BcToCozy0JPZYib7sObFXm/c9oAqeRDQ3iaqbGcXZb9yeSXmSj9TabMOkR8C2kjKBD2TvurGrGTH+B4bZW6vddYMnF3XwAA142z5NTQPmG3v1JXwHAr4af7/CRCkpRssMWjQ+KWqiv17fmDR3bXlsCPvJg0zZ+1UphCxw+kBlW+OBgMgqR+FV1pxZK4HXhwy+dhnPpmRFYfXTSTPr/hOOCGxPrN6EI7kJESZL0tFX329iUr47lJadBUyhPnPfGk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA2vyZQT/6Gn94GvwNydWlEFORg2Jc4YywIt4DLA8eU=;
 b=FQEzKLKhpkRxnkuwznwkTzBQCJgWYx00HnYUkSsQz6gMWQQUYMdEW4ghM4ej+kyi1rrZMdtc0CIzizwMi2lwqBo2FvJkk+jCMuxp0x9BdHlN9/yhFa/DKxa32AAQ/+ESppTsp0RsQ2fc6heCzAHaASKcxO5Q7ramYeGo0MJ2tAaf78kOhnWtdlz0K923XXuciZyzJNQdoogl91uSZMSZLyxlBsu7jKjVVN/9d8n/Omq9d9rzQhrzrk+/P7hPW4T2sRXLn5CQhwyo/7/ihwtcCPMAUQzxKEaiwUQoc331VlOWPA6YNJMqVnyzbbfQQGG1qsApNse9MX4ueTjeMN1n0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA2vyZQT/6Gn94GvwNydWlEFORg2Jc4YywIt4DLA8eU=;
 b=yRvuJvGZtVEGK6t0Ixt6b96hfLyI+svNqBUso+/jjZKachoAF2ifFXb2+kztzTAGJhHQFw+LlFMgipkO5O/oN7/d/YyH+lAaKBW6mJaVCpDPceMUGXYiV2I3QJg52shfEjgLOtGHMq9nPGv6fibDKGnEZAY9KLKd2KuBMp+x780=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Wed, 24 Feb
 2021 22:22:30 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:30 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 135/159] drm/amdgpu: workaround the TMR MC address issue
Date: Wed, 24 Feb 2021 17:18:35 -0500
Message-Id: <20210224221859.3068810-128-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7789e24-9e19-454a-7e2f-08d8d912737c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB450302A38EE1E5623947916CF79F9@MN2PR12MB4503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MljbDk4IThK9zi56uQJ7wrORwHi8a/1wkXQjNiiWL/MGgnao1V1WsUmkSYnUbL2IsDr7QEU14z/poaTlZT4Sx/FIb2Uv9DNp/0AxTLSdZD83AYUef0tW/hi6v8Ar/aV2Ag2oHJDb9bMGzFvN479OectxChuqloSR1cu0jzYK92U+4c3Q09eynajwIj9g+D0wzG7nGzIPzVr3orA4i6aZOc0qp+BEcTpWJE4KJITSia4FthuGfdDJd1siIlHOTpvhOlQQVJFoOe7UaiIFqa1GNvrLgvxV/qwfZiskWH/FpCXjr6K4DqnElS6Cz5FbbNB1NYEuqdgF0bzSYrZ7GZMRMrt2b5Q9TPGzVIxqBkpBrhILM7kyecFA462SQ3vVpl7yn4YYHIssKewnxMT0QLYG0D7pcmAYDlqHUzPp/UfcZyMQbAM/eiGVn0Hs4rs4NPilP5RWRSmRpU5oqzwa4F0XivuFYENWjAP7lqjRYOCgKMdZSWCmtaG/3q+DbkwxZ4gxbzqryMfQSfE0DGkAQbHLN4GBeI0W5cH0tuohL4n40U/eTNyLyWIxdQKDlZROcxAVJf0m3aH4Bqos4nRxOIJB+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(6916009)(52116002)(478600001)(5660300002)(1076003)(4326008)(36756003)(54906003)(6506007)(6486002)(6512007)(66556008)(6666004)(83380400001)(186003)(26005)(66476007)(8676002)(8936002)(2616005)(316002)(956004)(2906002)(86362001)(66946007)(69590400012)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2q3vN/sD9eo+o3QPVi5UuF7Cg9R+JzLvL0Z8RytS/78i5TboDlD0pLwFDPK8?=
 =?us-ascii?Q?dJIMcNWMTNjYoMLcO2T/Y04tkyChprreHFHPLlz0iWb1dYyuKva2fgobvA4Z?=
 =?us-ascii?Q?jp1hUtr6SEyx9i/wBD1LYXy4PxiinsONPMjlHFKkSaBu47uEs2M41a8aelt/?=
 =?us-ascii?Q?rq/fl9yPDuidkhW1O6JfsXLxVnVrhsMvLX1ZzKWGdTOx2esoFcSs3lyIFiRT?=
 =?us-ascii?Q?S66QY3Yl0me8SsR31qgwT6BGLJncVXiSyx46TAJkb+G91rvrLEcX4F3BHuMO?=
 =?us-ascii?Q?Mi/1sz6/HemYiLh4cV/zNNdJ6v9k9KOSfUlLAD8BB7X51C0pEZsvu2XTqGUx?=
 =?us-ascii?Q?/xMKYnhZsfRvajhukzXYAw5QLCM+CgjLnMIs93FVJYaMAmeV94VmYPWyxtVl?=
 =?us-ascii?Q?7RpZv6+qD5KBOdlO/wl4+pukvh3BRe5x9aRk+5o83VOrwAw76238O1WnAIbu?=
 =?us-ascii?Q?XkGH55tFfdHI9U36370TxTxKKfFAOu/5MwF0He5ZwyVaQiJ+e0ZB7Tb0C+bL?=
 =?us-ascii?Q?xUDy6uh7nsImzN2G1WIstVABszBuh0IiV+y1Ho1sH6P+tPxnaxbjyYIGqeCr?=
 =?us-ascii?Q?mL2aG+TN377zBKWWw8pIBsJMjicLBcJdpsYDtG0TJbz6GjPH/OcLvygZZZxr?=
 =?us-ascii?Q?Wp256658fYt1ty7TwKUZkrr0kOFKYQiysNQc5zoqJZQ2sxnQxtqI3B6z7raU?=
 =?us-ascii?Q?uA4IjjDmjnVZfFXvl3poUzNmTPmzfG5B+gCJhwQ6hzFaJTMa/1bHJgkybsBC?=
 =?us-ascii?Q?HfSQ67ccZMRyi3qriygsJ91BncCIRPmXpW0YwMRBIO4Q+ySsU6JwjqOh9sZ/?=
 =?us-ascii?Q?LkXdDswwA2caG61kObLTe3gV/c2ou3DNV7kO2WUJvbIUMBYkc4vFqQQ35ajo?=
 =?us-ascii?Q?QwEY/5D6Y6RtnWu1aCVCKcbnTi9xoFAWzJZHjB1FZ7AJsOcUDi5ByA6j9890?=
 =?us-ascii?Q?b4KxyN6j5nQ9XeO/ThDL2bTqoO4Q3Vg6Al56vBNN7MXt7nGYq0/29e7BiDWx?=
 =?us-ascii?Q?0ct2e9+2btK1VNIgE24lIQSdOoYhgIoof0KZT3+fcjGe92HMDnB1Df1R+nsQ?=
 =?us-ascii?Q?UORDABOzD9U6MtlcbNUGA30PixXr4ly50RYUEEu/xYH6+Wk1+ZEk4YCGKMCm?=
 =?us-ascii?Q?U40fzG2mJQ71TY0aW5TlkftH4ZfdC1WuMCp10yOm8SYTdAiKKkcNPh7tuxwC?=
 =?us-ascii?Q?6J3Qdelw9VRqQlkBukYRs+fb2g00iIBOHkSNTfHv6yxZxpMKHc5sro4Y6TEH?=
 =?us-ascii?Q?KTj2t3zIR+8edwBVbj2ffFkK5U0lt1Q31Yjcct1ulfBK8AwzzM+U2v9R7yOf?=
 =?us-ascii?Q?Eu5kaLXClYYMtLMhSfHnBXMF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7789e24-9e19-454a-7e2f-08d8d912737c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:54.4984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6Jno8PrxAqvRLTbvRUvzaGq/XvREdbP+Fx6pU6qOQ6wQUaQGtERV3CmqmcXZKWjoLdXn+w5j86RRrw6Omhiyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

With the 2-level gart page table,  vram is squeezed into gart aperture
and FB aperture is disabled. Therefore all VRAM virtual addresses are
 in the GART aperture. However currently PSP requires TMR addresses
in FB aperture. So we need some design change at PSP FW level to support
this 2-level gart table driver change. Right now this PSP FW support
doesn't exist. To workaround this issue temporarily, FB aperture is
added back and the gart aperture address is converted back to FB aperture
for this PSP TMR address.

Will revert it after we get a fix from PSP FW.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  |  8 ++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 10 ++++++----
 4 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index d5f3825cd479..cd4592ff70ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -208,6 +208,15 @@ struct amdgpu_gmc {
 	 */
 	u64			fb_start;
 	u64			fb_end;
+	/* In the case of use GART table for vmid0 FB access, [fb_start, fb_end]
+	 * will be squeezed to GART aperture. But we have a PSP FW issue to fix
+	 * for now. To temporarily workaround the PSP FW issue, added below two
+	 * variables to remember the original fb_start/end to re-enable FB
+	 * aperture to workaround the PSP FW issue. Will delete it after we
+	 * get a proper PSP FW fix.
+	 */
+	u64			fb_start_original;
+	u64			fb_end_original;
 	unsigned		vram_width;
 	u64			real_vram_size;
 	int			vram_mtrr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index cf8cfe620d8c..71c50f93b6d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -407,6 +407,14 @@ static int psp_tmr_init(struct psp_context *psp)
 				      AMDGPU_GEM_DOMAIN_VRAM,
 				      &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
 
+	/* workaround the tmr_mc_addr:
+	 * PSP requires an address in FB aperture. Right now driver produce
+	 * tmr_mc_addr in the GART aperture. Convert it back to FB aperture
+	 * for PSP. Will revert it after we get a fix from PSP FW.
+	 */
+	psp->tmr_mc_addr -= psp->adev->gmc.fb_start;
+	psp->tmr_mc_addr += psp->adev->gmc.fb_start_original;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 62019885bda5..18d1065233ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -141,12 +141,12 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	 * FB aperture and AGP aperture. Disable them.
 	 */
 	if (adev->gmc.pdb0_bo) {
-		WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, 0);
-		WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
+		WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, adev->gmc.fb_end_original >> 24);
+		WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, adev->gmc.fb_start_original >> 24);
 		WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, 0);
 		WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, 0xFFFFFF);
-		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
-		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
+		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, adev->gmc.fb_start_original >> 18);
+		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, adev->gmc.fb_end_original >> 18);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index d53b3751418d..4df0b730774f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -47,6 +47,8 @@ static u64 mmhub_v1_7_get_fb_location(struct amdgpu_device *adev)
 
 	adev->gmc.fb_start = base;
 	adev->gmc.fb_end = top;
+	adev->gmc.fb_start_original = base;
+	adev->gmc.fb_end_original = top;
 
 	return base;
 }
@@ -124,10 +126,10 @@ static void mmhub_v1_7_init_system_aperture_regs(struct amdgpu_device *adev)
 	if (adev->gmc.pdb0_bo) {
 		WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_BOT, 0xFFFFFF);
 		WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_TOP, 0);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP, 0);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP, adev->gmc.fb_end_original >> 24);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE, adev->gmc.fb_start_original >> 24);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, adev->gmc.fb_start_original >> 18);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, adev->gmc.fb_end_original >> 18);
 	}
 	if (amdgpu_sriov_vf(adev))
 		return;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
