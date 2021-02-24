Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02969C4332E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C059164EDD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C059164EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F2A66EB7D;
	Wed, 24 Feb 2021 22:21:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B1D56EB72
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGss25VVMyZtVpj1oZCMJWD3Grrwl5KKpIkq0O/nlmeEx1J50PKe2w41jdjL4rWKVBRRtApuoGP734IWM5dgrb+1hTniCZP5oCNJqNZafcBs+XVvzlUZJdQSf4s/JFz5y/vVxrlBcFn1UXjLd8IwrMNMhu+71s2E/YX695Rl5QjzvvU3Dn6yB9jdsa1BKdE3BrQhdAQxjtuHS0KI26EVa22ZTOwLBoGlSnwXEnZDZD9aqwxWSlAlMmy+G0Hbx8BItg8AgjQ0tj7kPocNBKAksaWvqaWFolChYgO1k1yY9jpBK6oHpWH3rFmiYSFfE7pYs3IkddurW1Bhav8UiCM07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxqZKOWQSPXdIT4XPS8kvOYfSvzU1Cvix1AaXbwRXQA=;
 b=TvAMYLFYZjCui/X59iYgZMIPJQeZJ8DNGo0mRvq2s6Nmhk0bwnL/BmatMBiVykPn79mdLIwfZz0R6XUNLCX72J5x92rTZzF7ZAb788/kNlG20+/czxZt0Nc2nMKb4N2L2Cg7dhlxuI/nyGPZlR7l2Y83qqYpl8eOx7nwaHYPJxYcmsUzIB2rsFtvarbD5CM6jSCXjuLy3ErZbUrK8oiAIryL4o/bEElZLRumFxdMVJxJNsph9VrCJp3eY70M4F7Q/lr/qTcOQv/r84r+6GoqxpEffgAxD0+J6tXFClP5Ju1PpG69P7gbhFkRseO1ZlCtl5LJycLkBUeuCPQ18uXRww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxqZKOWQSPXdIT4XPS8kvOYfSvzU1Cvix1AaXbwRXQA=;
 b=FET8wKSg6Grb45JF4JgKhRIXPchg6CesVA/mB+RBWjniKVRrm7YoMnZ09stqcIiZsByrM9m2YCBD94orXv9GwxT0kW+PsvlXMeKbQHu1SPuY2ZYxh6CBJOVPPeO43bOlHcfyjmg0yywmQFN4i3upfjQqs9PSAG+Dt5dSZWlCNFY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 22:21:46 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:46 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 110/159] drm/amdgpu: Add clock gating support for aldebaran
Date: Wed, 24 Feb 2021 17:18:10 -0500
Message-Id: <20210224221859.3068810-103-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f194518c-ad37-4132-ee27-08d8d9126a26
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4798BF844C12E8539F6948FDF79F9@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40xXe5CjFHAtBXFmsAYvzDu5G9xEmfv3+7GOYXf7zRHUXdslJ4PGL/wOlICEaAd+XmAJV85v9ElfT/1QygzHFDUBy/HXlD9HdFhXAJE0+V4nAW8wFqWwC0aIkNacqMAXiiIFlOM712ix/fdvclQG9ZGm9fpWPc+tFQoW1M/Yd5kzocosgXPKr1epbJJNCOJqsTnDCliH6qPJKRPr//7Pvv9sRMGKKN+fJsCvw4NT3HHyHYcFKPSCzznza1pBP6mWHSWsVDYfcxotOn9UItusdXTf/+8QfmLH9L4nRAQ8iDuPeNQMw/KZpwghCAq8/3toIhRDCesZxsGIHkUj5bJ6GIsaYqsyuvRWoPW/WciWmww2WxwWh3XAeQfEqI8k0CS83uPlplPvDLW6Rmohn2tGm2LpNr30HkQnX1yACipPChFk2V9bQfBklYW0DeylWEnOkOVRbz5uKtPZfi2z1WHA3zIcGywLzGygrAA08gckZiKtEosQgDvLYN8hxHWiZ1tJgWXbDl/F6tse79rQ/TC7S8OtgW2gyt+UAu5HDhfsdAqneeOnTV9ciHBQ5vuh/ItIGDpXkXv7I7UfOyBI7xafmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(1076003)(83380400001)(8676002)(8936002)(186003)(16526019)(6486002)(69590400012)(66476007)(66946007)(6506007)(2906002)(54906003)(86362001)(316002)(6916009)(66556008)(6512007)(26005)(2616005)(6666004)(956004)(4326008)(36756003)(52116002)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QFW0jDaJc5QH+h9LDLdces0NdP1XN+daKbPfuVUxldoo5RoqWbqdbVD36pcu?=
 =?us-ascii?Q?nKm3V6RmhVeRYbxgby/iDzGGTNBcv2dxUDk8wpJMOhPBwvI7jPRim6s0dkCF?=
 =?us-ascii?Q?pKs/T/7aAmQzAcI8yGTrcauYeSuAmz5dqD/v4bQzn5CPCT8JAShK3Kldqukb?=
 =?us-ascii?Q?AIzr3XjwCM17CWk3/cmxQTxDwaRRdqrSk6D4Ogbk96JslcibW35qQ4fGycYq?=
 =?us-ascii?Q?kcm5cuYVF57mDXfhW0htgWTaqp3OMXoMb+/bY7HYh/+VsgzHbn59UAp8h0u2?=
 =?us-ascii?Q?kdkoHNGBR4KiSzrhAF0W60tUrEhwgHTSkJxqFFIt/5BTcgubgJVmJ1IYARvP?=
 =?us-ascii?Q?ZQxxT2E2aBXFLBtzfj02QomqZ7nAdlXxQqy5VjENVS0YOOW/5cU7/RiZXPQH?=
 =?us-ascii?Q?aBmcIU3QUcfOmZLshskBDN16NQsja8g6mQbg6TAe5CkZ1Zf94UtmiKkbmoAR?=
 =?us-ascii?Q?0xJMh38wpdtiYxu6EkpDeZ8agGXC/QVlByZBMUNJBPQe4PdPLWbvbMhsS4tl?=
 =?us-ascii?Q?cpmI/MKWqu91hW7CG+JSfkofV940MVfbixMXckm5j2goCV/rOUbmbaQVW4gQ?=
 =?us-ascii?Q?XstCeZgzOkyaOgIzXJpjNqPQHnY9kTR8gzokkuOoS9BNn9UVaLBgjmSeCMsi?=
 =?us-ascii?Q?05Z+EfBp7vAFcIzyETgLOuGgTQHtofIvsNbjQLOKxbNhpad4dswgqvZ+482/?=
 =?us-ascii?Q?cwo2FYjk8tgoqHjc1J4lzvZQIBSzynS2EwkkKMwiANa5gz69mUQO/MwjtEcu?=
 =?us-ascii?Q?ZLHVHU2L1MpdRT7hJt8968EatUVAS1QKAVcllxl1EY0ElLDE/X8dL0Um+8uv?=
 =?us-ascii?Q?9rVOOv9dQnxr5VztxUTLYmCuV9O87KTm31/kVS+IPbJe405BD3QzmIcHrY39?=
 =?us-ascii?Q?sE4qE6htTson5XFyKpl7CII3quafJq/QYhfmQcqR27p39vePnXd5MN19j5jw?=
 =?us-ascii?Q?XrFZquw3HxBnGAFg0TPM2UuiHD9B4tGFiDpllDE9608sC5Uejfh2PUNKrge5?=
 =?us-ascii?Q?9WBUWlQZL8psmwVxzq0ixZUrkFnY32xr0Y6S04CEY8s08aSfV7GJjLgAZyo1?=
 =?us-ascii?Q?PivUQ7a4eLfv8xU+xw69nE93mcrQh2V33Kn3Y60MELjJM0b6y/5nM92W0cRU?=
 =?us-ascii?Q?e3aC4x15zr/vXBeySplkM+D0bclTUd1D6BAE1/K5XJemj9JTg4mKOvzToTDj?=
 =?us-ascii?Q?HZfNXowNNlxH1TtUfYEawQJ0NirCNoej7Imfi686WLlskafuu+GYZEIDGDoR?=
 =?us-ascii?Q?J8wJwqyNHwSdsGiRX2tDXKKYS+h4qfnnFMG6p0xR+SBZDmefy5SsvPXOpiDG?=
 =?us-ascii?Q?LNN7DkrOGPkQRLJ/LyHQO+Lv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f194518c-ad37-4132-ee27-08d8d9126a26
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:38.8371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osyN7keS3HkqAFEOL4dpWONhgDLnicOvJNgLd/EIjaKlGhrPvBJdmSzEn8sbMtVfWSTZZ9fpZQRC+P2bt4Ittg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
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
 Lijo Lazar <lijo.lazar@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Aldebaran clock gating support for GFX,SDMA,IH blocks
VCN/JPEG blocks are excluded in this patch, to be enabled later

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |  1 +
 drivers/gpu/drm/amd/amdgpu/soc15.c     | 31 ++++++++++++++++++--------
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f886e9f22398..d30e60fdf596 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4892,7 +4892,7 @@ static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
 {
 	uint32_t data, def;
 
-	if (adev->asic_type == CHIP_ARCTURUS)
+	if (!adev->gfx.num_gfx_rings)
 		return;
 
 	amdgpu_gfx_rlc_enter_safe_mode(adev);
@@ -5139,6 +5139,7 @@ static int gfx_v9_0_set_clockgating_state(void *handle,
 	case CHIP_RAVEN:
 	case CHIP_ARCTURUS:
 	case CHIP_RENOIR:
+	case CHIP_ALDEBARAN:
 		gfx_v9_0_update_gfx_clock_gating(adev,
 						 state == AMD_CG_STATE_GATE);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 8e3bcdfe191c..9e8d08d60aa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2261,6 +2261,7 @@ static int sdma_v4_0_set_clockgating_state(void *handle,
 	case CHIP_RAVEN:
 	case CHIP_ARCTURUS:
 	case CHIP_RENOIR:
+	case CHIP_ALDEBARAN:
 		sdma_v4_0_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		sdma_v4_0_update_medium_grain_light_sleep(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index d10d112976ec..c6fb3e362694 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1255,7 +1255,16 @@ static int soc15_common_early_init(void *handle)
 		break;
 	case CHIP_ALDEBARAN:
 		adev->asic_funcs = &vega20_asic_funcs;
-		adev->cg_flags = 0;
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_IH_CG;
+			/*AMD_CG_SUPPORT_VCN_MGCG |AMD_CG_SUPPORT_JPEG_MGCG;*/
 		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG;
 		adev->external_rev_id = adev->rev_id + 0x3c;
 		break;
@@ -1492,6 +1501,7 @@ static int soc15_common_set_clockgating_state(void *handle,
 				state == AMD_CG_STATE_GATE);
 		break;
 	case CHIP_ARCTURUS:
+	case CHIP_ALDEBARAN:
 		adev->hdp.funcs->update_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		break;
@@ -1513,15 +1523,18 @@ static void soc15_common_get_clockgating_state(void *handle, u32 *flags)
 
 	adev->hdp.funcs->get_clock_gating_state(adev, flags);
 
-	/* AMD_CG_SUPPORT_DRM_MGCG */
-	data = RREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_CGTT_CTRL0));
-	if (!(data & 0x01000000))
-		*flags |= AMD_CG_SUPPORT_DRM_MGCG;
+	if (adev->asic_type != CHIP_ALDEBARAN) {
 
-	/* AMD_CG_SUPPORT_DRM_LS */
-	data = RREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_LIGHT_SLEEP_CTRL));
-	if (data & 0x1)
-		*flags |= AMD_CG_SUPPORT_DRM_LS;
+		/* AMD_CG_SUPPORT_DRM_MGCG */
+		data = RREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_CGTT_CTRL0));
+		if (!(data & 0x01000000))
+			*flags |= AMD_CG_SUPPORT_DRM_MGCG;
+
+		/* AMD_CG_SUPPORT_DRM_LS */
+		data = RREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_LIGHT_SLEEP_CTRL));
+		if (data & 0x1)
+			*flags |= AMD_CG_SUPPORT_DRM_LS;
+	}
 
 	/* AMD_CG_SUPPORT_ROM_MGCG */
 	adev->smuio.funcs->get_clock_gating_state(adev, flags);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
