Return-Path: <SRS0=uqaI=KB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12444C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 19:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0AE66121F
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 19:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AE66121F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32CA26E0CF;
	Thu,  6 May 2021 19:47:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3939A6E0CF
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 May 2021 19:47:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dbc1puem6HQ9pmrSMi1UU0OvQJQqPeiyy6RHQo9yHtEwG/0FqG7WwzkHCzrqDUivn+Ji8EqsgvgMVXqt6mSyGOWdGlLLRs0m/aWjOwpn0CLecHj+pvuS6kqcwRMfOJ7XhypKxkFsvweCpS5TYACYvZDR5SlTaJjLneHuOcRuKhVLGWgMUQIlRan+nOcpybT7iw2lkoLDLsPfo+4tFAiE3k/jFIH4XNp/4KbQA/ABvlbgYmy6Cq5RVVh75qn6lDB846y01XUmwl2EHOL3HA53HNdyVOoRcsVPMXiBc1ByVD8eR5OViftyeDBcCtaPqrUiLwicJKLxXeTK/mHJ8jd/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+5g92+edt9i0hr0zQu7nacXR0LC0zdgDFy8aBdKGbI=;
 b=VmtZgjqU1HxdNbg8cnLnAt9iJGnfko+mMQs2AjNKQp34ALI4w1KgNYl7gnrBJG41o8apd/0Qmko3CZr78d6keK60YH2XloKvs7Xn2XPA6w9qOv1BFpl+L19doBnYEO3BWwgaXxzNx95adZ2xcXdm+SdluNy3o4LzM4jRhe63OXeKWcpjuK9MYBdzbQZuXuHovsmSTZmpKYtKdUyLpXM18mgY7sP90sdKQjcIcRAcNaCqEasurkMV0NsJ31yiJfTgW7NG37oGiNRrIe9LmaoTP0z25MrYi5vFq67AAWoSszG+lsTSOQM8EAkJJB4xV7Ww4MQjgk4sX/edASSlVlsquQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+5g92+edt9i0hr0zQu7nacXR0LC0zdgDFy8aBdKGbI=;
 b=2qb7o3bLkoSP5HCY2WyCYZBI/Z6cWwKo/vexx+JZ67lqc4NJOpKWyNlrSgeG0aX08MDUm8NLpkXOxGrxqXWqCJv5NajrEz8pr9vqHkca64pyMIL1jAe2rZ3kCeYiB4f0ARkW+SNjGBht2fRTs8xp4DefyEqQkLps2YGMwdCl64w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM4PR12MB5198.namprd12.prod.outlook.com (2603:10b6:5:395::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Thu, 6 May
 2021 19:47:54 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c%6]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 19:47:54 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Enable TCP channel hashing for Aldebaran
Date: Thu,  6 May 2021 15:47:24 -0400
Message-Id: <20210506194724.9964-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::20) To DM4PR12MB5263.namprd12.prod.outlook.com
 (2603:10b6:5:39b::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mukjoshi-dev.amd.com (165.204.55.251) by
 YTOPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend
 Transport; Thu, 6 May 2021 19:47:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6458f79-6f47-4f9d-0eb2-08d910c7d72c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5198:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5198CC6A0F9C92C49CBD792AEE589@DM4PR12MB5198.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ymxpfZM7gWFJah4yAS5V3v6gGzOS5AhNo+mISsXtcZSd/FFDeDUO69dqrP+haZYRmPMlkzVHXPhVGS3mQcyCWXiluYzQ3HMQN4JiAucAsicb93RN/UbGXGNJ/LGtVUfCX+38wykpccwqZqDsY1nXe2MIp6d/LuZ7r5gFRgbKqUXywRd7BiL70APy+jZEtzSi8NhrMl0rVGB0rIDu69oPJEeSEuJTlmqQnanWIa+nYQfheSeH+vdVlLvF4mgJixjGTnv9GfmLxUJJJLmgWMHCiH+pZQEoVaBv4xauj/yBV3DFx716+xa6oz3SRCrrqt6LP0USZCLU4Jht7dbyoWYj3xU3tA/kgIXXnDcDseaKGREDYng8UGafTvLy/69U14tM15ZuWZ16Z4s7MSZByMHZ0xgjyGFxTpPwBaUWC2wmRIE3C++sgmVvYKv+dzn2nBUr3DE5sb/d+aWk1KUbAL0hDEFIfVQ9fEpuL3Kkfv2ZxZPLXdntUSH5C5Ojz4MIVNfy9jMLCBjcRxTYIIrJPxZ13O8x41aEdn84IE6nLA4vweW2pNUX57fRWIRJWOGt3IqpB91eEcb4uYqxt0gOcXBpLJsXdvZKsfgAU/vUxXhRuxwrdIm7lvR55QlJzdltmn/BFMZs7Kgwkn/8rax8O3T+sUJ+FyFZhH9U/+vJyRS8hQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5263.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(8936002)(66946007)(16526019)(8676002)(186003)(66556008)(5660300002)(7696005)(19627235002)(956004)(2616005)(6486002)(54906003)(86362001)(66476007)(26005)(1076003)(83380400001)(38350700002)(316002)(52116002)(478600001)(6666004)(36756003)(38100700002)(2906002)(4326008)(6916009)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BJlgftrfp1QbmHbbIKF7HAdkIdiXoOlFk0KYqP8rDjju9d8o61TAghOeQxs/?=
 =?us-ascii?Q?uwLu9hD74Jit/g9CAHMBNN70RQ60eNU0s3BCFAi3GcpH/KSbndgPMxi7raPN?=
 =?us-ascii?Q?+5ZpxtR64jI670aXFUtCnj3I/xR7C0hyxWrowG+LmfuD6KZsdG9ldLHurVXg?=
 =?us-ascii?Q?CoN0ZHJjyY0Kb4RmwB4I111UF4WGkHt6aoDBfeAFs+W2HWUD6hU5jHtzTEGS?=
 =?us-ascii?Q?DKwCw3/VYuXFntRcJIMB4OqaUE/hJbF3DwCC/20IYeCrH5rHOUfo4v+H6Yln?=
 =?us-ascii?Q?tqLYfmgQBTyGqH43wPFY3wY7UzGu1QHlzSbKRqMy6UAcWWG+8oZRg3qxNrWa?=
 =?us-ascii?Q?TLs7GkMQDR1jOh6D42+aAfhB5R2NoiKDnhfLMGI7TXHxmXQB5w001Z98ddi0?=
 =?us-ascii?Q?mEs9hJc6IcQS6UakuWfoPPhTY2PEGHJ1v+WL3l4RNfJsetYfWFdbCUbTh/3q?=
 =?us-ascii?Q?zKzzR4uz/0lwAvzPYANMQhfP+M85YYIzoCnQprYVZ/E2xjNfAU8py7DUJgci?=
 =?us-ascii?Q?G581smgX3NZUsTlQLWZwH9jUUmJJ+jtdBJslqPpl2kxwLsCMYkrmAEeFYtAU?=
 =?us-ascii?Q?XHZK0pla3cOSdNuE7L6uKaKCV9miSdyU6bNwV7nbuFy+wHqWPgsrbyyCnVmE?=
 =?us-ascii?Q?ZRCV1GjBZR+FlUp3TH68qHeSxu7agZDc4Z7+WX+yNX1YEdsjaiTDlNxwIGwl?=
 =?us-ascii?Q?yYbeFP97erIfkrvgJXxINkWbLuLkAaPogcK57T34qp7hJoJAGskqMQAxLvoq?=
 =?us-ascii?Q?ysy3dNrCu0XTooDa1U7VBjnruKQeumWBIDRCPDu8ffRcwe4PDFa40XS1XAzf?=
 =?us-ascii?Q?dZLWSlXYsdRSugnEoHwU8lOqxApZcf+Kpwe7p7Hd2o/8oFFqy3a12uBlfaM3?=
 =?us-ascii?Q?nDaexB4J39/BfmisGc67SfK+N7h9SjDaFoBXos5TUrehxMyiMfXbjvkESvfQ?=
 =?us-ascii?Q?JRwVcLquXIy9+aFowN1erF1tgD4425z17dFRn8bkhXDZqTuWx6tOEkVfnnMA?=
 =?us-ascii?Q?1etjum4UFnohEbnm/Chm23jO9zoa5NYURjSfP/CZxEqVcopi7c/zyeRmfAU5?=
 =?us-ascii?Q?+fxyrZyg/HmBri2/nDu0c/OFgr/pkzRzyp15tu+wBjA7Udx7lZwT8+maU9Fz?=
 =?us-ascii?Q?QDvVxOoDzq/PToeeGJzz06G45o0TOkSlLN94vmOZ9zPxhI2QJzWEfaDoJPmS?=
 =?us-ascii?Q?WkkL3TgG3XxfDMqCLXKTJFahbW2rC7WuaCYIFVTEeG5kQDjHSA0LKCB+SqnM?=
 =?us-ascii?Q?gTrQThHxAQ3ome4LyouEb7xsBk1Uylnhkm7Ht56KgYuXefpWTASPQap7LiVr?=
 =?us-ascii?Q?7mHNI+0g/OaQXWozafquZtcq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6458f79-6f47-4f9d-0eb2-08d910c7d72c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 19:47:54.5524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+FEj6BU1ZLUcQ6C7xu88gdG9X4cT9/z3O8dHa475wDZ8w77seyHrMM7TJ9A/RSJJ0dNaEFufDmLpMEdNfE2tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5198
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 harish.kasiviswanathan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable TCP channel hashing to match DF hash settings for Aldebaran.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c            | 17 +++++++++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c           |  3 ++-
 .../amd/include/asic_reg/df/df_3_6_sh_mask.h    |  1 +
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 0d8459d63bac..36ba229576d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -219,11 +219,11 @@ static void df_v3_6_query_hashes(struct amdgpu_device *adev)
 	adev->df.hash_status.hash_2m = false;
 	adev->df.hash_status.hash_1g = false;
 
-	if (adev->asic_type != CHIP_ARCTURUS)
-		return;
-
-	/* encoding for hash-enabled on Arcturus */
-	if (adev->df.funcs->get_fb_channel_number(adev) == 0xe) {
+	/* encoding for hash-enabled on Arcturus and Aldebaran */
+	if ((adev->asic_type == CHIP_ARCTURUS &&
+	     adev->df.funcs->get_fb_channel_number(adev) == 0xe) ||
+	     (adev->asic_type == CHIP_ALDEBARAN &&
+	      adev->df.funcs->get_fb_channel_number(adev) == 0x1e)) {
 		tmp = RREG32_SOC15(DF, 0, mmDF_CS_UMC_AON0_DfGlobalCtrl);
 		adev->df.hash_status.hash_64k = REG_GET_FIELD(tmp,
 						DF_CS_UMC_AON0_DfGlobalCtrl,
@@ -278,7 +278,12 @@ static u32 df_v3_6_get_fb_channel_number(struct amdgpu_device *adev)
 	u32 tmp;
 
 	tmp = RREG32_SOC15(DF, 0, mmDF_CS_UMC_AON0_DramBaseAddress0);
-	tmp &= DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan_MASK;
+	if (adev->asic_type == CHIP_ALDEBARAN)
+		tmp &=
+		ALDEBARAN_DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan_MASK;
+	else
+		tmp &= DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan_MASK;
+
 	tmp >>= DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan__SHIFT;
 
 	return tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 16a3b279a9ef..22608c45f07c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3937,7 +3937,8 @@ static void gfx_v9_0_init_tcp_config(struct amdgpu_device *adev)
 {
 	u32 tmp;
 
-	if (adev->asic_type != CHIP_ARCTURUS)
+	if (adev->asic_type != CHIP_ARCTURUS &&
+	    adev->asic_type != CHIP_ALDEBARAN)
 		return;
 
 	tmp = RREG32_SOC15(GC, 0, mmTCP_ADDR_CONFIG);
diff --git a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h
index 7afa87c7ff54..f804e13b002e 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h
@@ -50,6 +50,7 @@
 #define DF_CS_UMC_AON0_DramBaseAddress0__AddrRngVal_MASK						0x00000001L
 #define DF_CS_UMC_AON0_DramBaseAddress0__LgcyMmioHoleEn_MASK						0x00000002L
 #define DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan_MASK						0x0000003CL
+#define ALDEBARAN_DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan_MASK					0x0000007CL
 #define DF_CS_UMC_AON0_DramBaseAddress0__IntLvAddrSel_MASK						0x00000E00L
 #define DF_CS_UMC_AON0_DramBaseAddress0__DramBaseAddr_MASK						0xFFFFF000L
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
