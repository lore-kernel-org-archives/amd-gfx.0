Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69A9C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 10:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5446023133
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 10:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5446023133
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF7AC6E16F;
	Tue, 19 Jan 2021 10:49:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 783B46E16F
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 10:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3N019Wfb4qfLvWe31cvIvJnXlD4+ynRl8AYIuGJ8cMltQN2LSWEoNeh6GwOgFEHzArX1VpEPnNFer5NgDUfkWUS8cgbrUpJdR3p06b7lYjSrtKIn1E/1CtQmVXDmskR0b9kgFTB79AlROwsiGqakms45jVsnTOrgs105INNHVuYIwcHAlLFlzdmeBjOxR9WdNf+0XR4ML5YwH9i8ue0sbL1vq8wbmXuYFNqNfPOUvyiKbfo01sDwmBy/Xwk0hAaWUWgBlm7juYzYvCS7yI4Fw+CYXERIQ4tiDi83al2d5A1j69O4zktKBa9VSSPAi/giPSFcaoENBb8HYkY37EN4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGj3g3IsLpxk/jv77gq2CZqI/XKV+y8FiMLlsZqs9Og=;
 b=IitGdBj/kHO5T/DMmTLH2R/dUhcI4u6NnMzmLHAIhQP/zcRN4WfAD2CJLHxOsMfPv2XfvSgGLF4G2tdRWc2KSTfMWoP0vkj7tYLAWrrfHN1Fa+vBp4pObQZPBlO/5osDsC34lkDumSXMx2fQ0glme4/khLyqeKjMhUkhr8qQWEhIFzr4SLePG/KT9vDhdMXqqEiF+UHvgndn1rPpANsxJ+wN+N9noEm491nV996i852Qd+/yLFkT/azUNh5ylzjmFtKBvkCiA1IkT60PDrRS1WtFN+41+98TvysLunvZC8OgzqVoxCtTFqi1YXm3QNxQhZhT2Pu4pUQsTL1As4DYEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGj3g3IsLpxk/jv77gq2CZqI/XKV+y8FiMLlsZqs9Og=;
 b=z2Yl2x+6FVcMvt4HTMgNzjnSOvl5AVvTjxW5te+g62ayrp7pkYZk5COUm2yixQ6aoNOo6RSfHlKrtYn9JmEIs81+/gYM45J/uR43RGJ+VSI9KWE3E8Pq41PIpratpsyXdMs7PG7cVArmEQIo//OPQ4ozhyHtPbvSrGNfr8XKZko=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) by
 DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.10; Tue, 19 Jan 2021 10:49:16 +0000
Received: from DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::79e9:b52b:c230:6118]) by DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::79e9:b52b:c230:6118%3]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 10:49:16 +0000
From: Jinzhou Su <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add RLC_PG_DELAY_3 for Vangogh
Date: Tue, 19 Jan 2021 18:48:54 +0800
Message-Id: <20210119104854.24380-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2P15301CA0007.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::17) To DM6PR12MB2812.namprd12.prod.outlook.com
 (2603:10b6:5:44::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (180.167.199.189) by
 HK2P15301CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.0 via Frontend Transport; Tue, 19 Jan 2021 10:49:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7262b1d5-05dd-47c9-9a0b-08d8bc67dd96
X-MS-TrafficTypeDiagnostic: DM6PR12MB4042:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4042054714B39393FBFFE1BD90A30@DM6PR12MB4042.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C5KL0kxrFS+DUfpNqL6MQ16JBFvYsPzJBi7Fyf/aiK4pASW+2G+qokPs6oOhJqUSpSnupCPsn84YDxBXxS2oSLgpEDExAmz447IbGlf157J7hr+aKDzo3jq9jygnVJRk2TycCkTbxaJkbspDxzLLAA2sPSwR5710HNNO1defaYCBzgAXCS9NIMWwf2MxD/BaEl6pQfiVf0syFThOrPUeSalJEGZHg73A/PSuN2nXo7vX5kcvP64ZOz6Gk6ylIALRDOtWR8xPtG6KdS0BHkg1dVJDT4MAs/8hozuH/976hVB3fmqmdpgSHCchW+2xOOBPzgGjXXDcx+bDoiZL7/24yW993jrXlD9y+rbNGVUgltH7X8fbFZ0K88i8WM9sBBwa8Pk1aEElbGvwb1fWtIw/cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(6486002)(4326008)(316002)(16526019)(26005)(86362001)(5660300002)(6666004)(2616005)(66476007)(478600001)(52116002)(8936002)(66556008)(956004)(66946007)(186003)(6916009)(36756003)(1076003)(8676002)(7696005)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XlTKf0l3uVskQK7ztaptWtquLPP8KsD7kQu1MQCIFMgumzlE8zGeAoQ+t+5o?=
 =?us-ascii?Q?5QgjDsq2D+SC5bTDamcpZtSPEBvcQlnLETQ5O9EUYbJK30wGo4iwxtmvwBXT?=
 =?us-ascii?Q?x5xVbe9+U7cOcj7gcZKVFC92QPcHYsKKW7xLRAZl3tcFTeNe9RlZfCCOeBqO?=
 =?us-ascii?Q?wnhOtECCdczIr1FWAPt5wunVoLC4lT8hc6rt+VdF1wEneXAPnf6N+MvCYJES?=
 =?us-ascii?Q?gxMBQTD7Yzqr0LH3BCfGHxxtXpgMP/w/QOJEyhpApWHOJrIOioth4pkKIVDD?=
 =?us-ascii?Q?42/wYsesuL9FeEek2UEiNBbqBkro69qXcReUeBSt3HAFUk2inSqVdojK3h59?=
 =?us-ascii?Q?vZ7ILXCxF3r5YnDsOHzLuZVYojkdK3h+LtFB6wSzdxVX7gE7MI+YZxahs7MH?=
 =?us-ascii?Q?Ln65nPH7Y1ps9brmHGRIsp9mar/GqO/l1RgOOIJwohieKC8c8cbO1+fOmT2j?=
 =?us-ascii?Q?EKKUBwCYJdibyGyBVyerSdBplHeyDogyw9PIdfpRE15uMoiVY1GbFCzdgj4X?=
 =?us-ascii?Q?1UxX64mvrCViJoTAlXI4agjOX8YsbKaNZp1hzOiTr00XX64j9SHyY+hyZfPi?=
 =?us-ascii?Q?J/jnFkZekXBf1Hg864Ivaho6UAWJ8F5vauSJVnvlkCGxc5kMyptCrRMWQaxL?=
 =?us-ascii?Q?7UrCxgshiVqFJysRmoG3/bj7G3/mm5FZYjrXAGA8ZJy9dK9FRSbWLWNz+zYl?=
 =?us-ascii?Q?5UZWK3Db/FnOIcQmmIP0WCILD921UiY6WLPxKqqeY6Q8BUWhkuAXBLGo/x6j?=
 =?us-ascii?Q?om2XZX1bN0tSJHrhl7ByRTWYFVtcui/7eyzdd8/jtiXmQ9WLIsL6u81pjmWJ?=
 =?us-ascii?Q?fRpJAsxpezHsiyJH0l9MD+IRTc294MUyE4+0zlgGRdwvfzuoZstYrW5YE8cP?=
 =?us-ascii?Q?CbiRGOGKmB5uhGMhRtDecYgUBu0ytvYlja7OLdDL5Tz9UMibPHgkjZT8xuOL?=
 =?us-ascii?Q?rh4CIt1iXVfVBw36ROX9Mvg9lqr76bkxZ4Jn7J51R/4ZugXjFvy5RLAgjw9s?=
 =?us-ascii?Q?tm5e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7262b1d5-05dd-47c9-9a0b-08d8bc67dd96
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 10:49:16.1507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlByqwhhZwq4duOpzLdqvIOKkSIJLFIl9q9gliRL9nsSdghCgslrS2mQsnIR0U3xpG1g7CbwUcNosKSa/skbRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
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
Cc: Jinzhou Su <Jinzhou.Su@amd.com>, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Copy from RLC MAS:

Driver should enable the CGPG feature for RLC while it is in
safe mode to prevent any misalignment or conflict while it is
in middle of any power feature entry/exit sequence. This can
be achieved by setting RLC_PG_CNTL.GFX_POWER_GATING_ENABLE = 0x1,
and RLC_PG_DELAY_3.CGCG_ACTIVE_BEFORE_CGPG to the desired CGPG
hysteresis value in refclk count.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index c4314e25f560..23a11ec40c33 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -120,6 +120,7 @@
 #define mmSPI_CONFIG_CNTL_Vangogh_BASE_IDX       1
 #define mmGCR_GENERAL_CNTL_Vangogh               0x1580
 #define mmGCR_GENERAL_CNTL_Vangogh_BASE_IDX      0
+#define RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh   0x0000FFFFL
 
 #define mmCP_HYP_PFP_UCODE_ADDR			0x5814
 #define mmCP_HYP_PFP_UCODE_ADDR_BASE_IDX	1
@@ -7829,6 +7830,17 @@ static void gfx_v10_cntl_power_gating(struct amdgpu_device *adev, bool enable)
 		data &= ~RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
 
 	WREG32_SOC15(GC, 0, mmRLC_PG_CNTL, data);
+
+	/*
+	 * CGPG enablement required and the register to program the hysteresis value
+	 * RLC_PG_DELAY_3.CGCG_ACTIVE_BEFORE_CGPG to the desired CGPG hysteresis value
+	 * in refclk count. Note that RLC FW is modified to take 16 bits from
+	 * RLC_PG_DELAY_3[15:0] as the hysteresis instead of just 8 bits.
+	 */
+	if (enable && (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG) && adev->asic_type == CHIP_VANGOGH) {
+		data = 0x4E20 & RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh;
+		WREG32_SOC15(GC, 0, mmRLC_PG_DELAY_3, data);
+	}
 }
 
 static void gfx_v10_cntl_pg(struct amdgpu_device *adev, bool enable)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
