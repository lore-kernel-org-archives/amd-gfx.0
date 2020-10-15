Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C30CC433E7
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 04:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F9A221FF
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 04:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T2vNL4qr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F9A221FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FDEB89F2A;
	Thu, 15 Oct 2020 04:04:27 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E865A89F2A
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 04:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYr5orfl8hdZYsA4e/6CTDSdxuRhddvwSFpBKrlKm1LjdzBQS5BuJnbnyEKWS+eJTcAjYkmYzmkWuLXy6ljuPuvDjHkOYZo8scxYRW9w8UzLS9vqB4YmzQr+J72UAMvM2DDP0s3OfJYICedQyxwW8PvLVo7o7z8vashcs5C5cubP3Fs907/Ywm4UUtyKUY1GlEGQdLoh2Lb0UO9dvxlGCthi+8UHWFlsKz6aYeEGrWTGuTrOCEUeAf4JU1hXDPwiEsI7hpHGSsAprmZUEZuF45smBideJqn+4VQxdlp8k3TnWtvHpSWHyGMc5iromv0yS5iWe7Ec4ciNfdi7B4e3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVGxW282tYyVbxxkWCjdC0fjnBXoSRpoPRtV4R23KbM=;
 b=Qy9T60AsI/IgJnTpcl1tY4mq8FlY8cHqax5ZxdCzGrzQ/+VxbAx1v6M44wmUJQWkNePFfOnqGo4cdfTI/V3GGVt39Fk/sp9nqZ/JqVvOM6vRZbj+RDirD4bg68koAU1Pf30SnbWBZ59ZEQeuJZMPnOV/T3e1MSTilE7JDsCDvGzSPzgXEP0EeFwhcNt/AHTYiBGxkWVtr/oHXxsy5zyvEq4EauMHlTopX+l73z8RPeQwKoaJeTnxTzKANj1sbcgueH2Jj+tQnYV9yZsJrymEIAX3J4/QYqcVDbvjjVlo3rL0q9a4humBgisHF3uFTshb9HEr/PB4YcYo48OiiMlGCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVGxW282tYyVbxxkWCjdC0fjnBXoSRpoPRtV4R23KbM=;
 b=T2vNL4qryOB13lxOa9lkVSRumCpdK87N62SkSMmYKMDLzfPNr3HtSVkqZFDUMWuBXg0BSeT1+8o7SEeraJVeNLVv0Hr5JOmAZEjAFdC8izQ7sg5CMflEN077JTkN09W9inV/9dm5uDJyv571ZR98cTLgOn5DoeFjTm9LuV+zmbg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW2PR12MB2523.namprd12.prod.outlook.com (2603:10b6:907:11::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Thu, 15 Oct
 2020 04:04:21 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::5930:79ab:d15c:2826]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::5930:79ab:d15c:2826%3]) with mapi id 15.20.3477.021; Thu, 15 Oct 2020
 04:04:21 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add function to program pbb mode for sienna
 cichlid
Date: Thu, 15 Oct 2020 12:03:40 +0800
Message-Id: <20201015040340.143379-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HKAPR03CA0036.apcprd03.prod.outlook.com
 (2603:1096:203:c9::23) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HKAPR03CA0036.apcprd03.prod.outlook.com (2603:1096:203:c9::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.16 via Frontend Transport; Thu, 15 Oct 2020 04:04:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 63a206fe-47b0-4ddd-d85c-08d870bf6519
X-MS-TrafficTypeDiagnostic: MW2PR12MB2523:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2523473780372B2C4011CD8FEF020@MW2PR12MB2523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sMlNEtHZ08BRXOKHRbyuTo0+4tQ87gCkrkkyrr+UT2Qm73Nza1LT1MuPnTZf+DK+oTAKHQl5+VKAR0b/yiGVtd6XaOii6sTG+MyhFhn2nU7zALZGfaPO+sFtxCSPBnm78nmyPlQAFh32F6LxQ4w9eG0o9iNOGxO9UL9NfkYqVw9pFt++SV6JKvcLvUUB/hXeocVUpaSC3aO8QPjkCz1hdaS5H2LdPaA0BBwrb2tI3PU3EHKebKCMiTEG9V9arR5O1+VlEKI5Va8yks7BvElSmN7BeTvKvaXriZa1pTv9mnyyn+BXM9Y0f983MKUkkPfrbNg8KjcMIHpTWWeW/mOdwv7fcGQvaWVtf32qPNmEfhsjoCfz1600GmGUZ+46zHjm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(316002)(1076003)(8936002)(52116002)(26005)(6666004)(8676002)(7696005)(86362001)(36756003)(66946007)(6486002)(186003)(16526019)(478600001)(4326008)(2616005)(5660300002)(2906002)(956004)(83380400001)(6916009)(44832011)(34490700002)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: rERDzG18tTnUGJ7kxf34eJJ8/PTELO7GHU3BIGOBR+OwNr7q5+nLvSbQWtHMyV5w9i0zoZpf1nz/qBHSl+Az1zeSQwZXElfQ1mwY1QK27Xn4SI8EWwjL+9JgrJBLfJc2ADEjZV4g4N5nGFS3KQGzgAuZLB5bnWKXqiSJfJf73WYeXENjx3Q3a6REeDB7nBJztS+mb9WbCcX63PqFFSwxT83bT14paO9QBTudNz49TI8IFOpBNJa+a8D/D5kn1oBQOmAhP/Ur6obcKiA6LF1FwqqyBasgeINN7cyEZrNGccm6xm17swHxcwnzU/p7u7bKWON08s6f3c0WVhpuu9uUckkRPC7k0uHvg520J7qNWpDKHWLOivFLCsI0yaEmvEu8zOVvymRZgV0TTlwXC6WruKlJs0YlUf+sQqj7V5Hgf7EeASAzteHTQtpLq3iaoQBSqC2+JV8SCJk/0JJ93uUFiW73HPChRXbgC+kJE829FdIzEeXv0/JN8visvoHeS1MOfgvqUoZ5H9IzM5uFMIFYOegAT6RW6GfwYW0lU5KC5kmnsA/qSdp/naKiEruAY0I3a7Z/q0K1XpqKl+2zXmL8DbnxL2Dn7+d0X4Tps0pv+hDfzbvtZ8YYEX2exUWIBONGNFmINDh/65f7SOOCOhVAvA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a206fe-47b0-4ddd-d85c-08d870bf6519
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 04:04:21.2731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFK2L2nqufetdgmNHx5LXjPPykQ/9ZEcWIenqfJSH2+hkP/2FHOitUxmDgF/jFGs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2523
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
Cc: Likun Gao <Likun.Gao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add function for sienna_cichlid to force PBB workload mode to zero by
checking whether there have SE been harvested.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I3bf2fe0b976affe26c829ac67bee176018f13fe9
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 65804137b7f8..aa48eab85c7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -112,6 +112,22 @@
 #define mmCP_HYP_ME_UCODE_DATA			0x5817
 #define mmCP_HYP_ME_UCODE_DATA_BASE_IDX		1
 
+//CC_GC_SA_UNIT_DISABLE
+#define mmCC_GC_SA_UNIT_DISABLE                 0x0fe9
+#define mmCC_GC_SA_UNIT_DISABLE_BASE_IDX        0
+#define CC_GC_SA_UNIT_DISABLE__SA_DISABLE__SHIFT	0x8
+#define CC_GC_SA_UNIT_DISABLE__SA_DISABLE_MASK		0x0000FF00L
+//GC_USER_SA_UNIT_DISABLE
+#define mmGC_USER_SA_UNIT_DISABLE               0x0fea
+#define mmGC_USER_SA_UNIT_DISABLE_BASE_IDX      0
+#define GC_USER_SA_UNIT_DISABLE__SA_DISABLE__SHIFT	0x8
+#define GC_USER_SA_UNIT_DISABLE__SA_DISABLE_MASK	0x0000FF00L
+//PA_SC_ENHANCE_3
+#define mmPA_SC_ENHANCE_3                       0x1085
+#define mmPA_SC_ENHANCE_3_BASE_IDX              0
+#define PA_SC_ENHANCE_3__FORCE_PBB_WORKLOAD_MODE_TO_ZERO__SHIFT 0x3
+#define PA_SC_ENHANCE_3__FORCE_PBB_WORKLOAD_MODE_TO_ZERO_MASK   0x00000008L
+
 MODULE_FIRMWARE("amdgpu/navi10_ce.bin");
 MODULE_FIRMWARE("amdgpu/navi10_pfp.bin");
 MODULE_FIRMWARE("amdgpu/navi10_me.bin");
@@ -3188,6 +3204,8 @@ static int gfx_v10_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev);
 static void gfx_v10_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume);
 static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume);
 static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start, bool secure);
+static u32 gfx_v10_3_get_disabled_sa(struct amdgpu_device *adev);
+static void gfx_v10_3_program_pbb_mode(struct amdgpu_device *adev);
 
 static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
 {
@@ -6990,6 +7008,9 @@ static int gfx_v10_0_hw_init(void *handle)
 	if (r)
 		return r;
 
+	if (adev->asic_type == CHIP_SIENNA_CICHLID)
+		gfx_v10_3_program_pbb_mode(adev);
+
 	return r;
 }
 
@@ -8841,6 +8862,47 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_device *adev,
 	return 0;
 }
 
+static u32 gfx_v10_3_get_disabled_sa(struct amdgpu_device *adev)
+{
+	uint32_t efuse_setting, vbios_setting, disabled_sa, max_sa_mask;
+
+	efuse_setting = RREG32_SOC15(GC, 0, mmCC_GC_SA_UNIT_DISABLE);
+	efuse_setting &= CC_GC_SA_UNIT_DISABLE__SA_DISABLE_MASK;
+	efuse_setting >>= CC_GC_SA_UNIT_DISABLE__SA_DISABLE__SHIFT;
+
+	vbios_setting = RREG32_SOC15(GC, 0, mmGC_USER_SA_UNIT_DISABLE);
+	vbios_setting &= GC_USER_SA_UNIT_DISABLE__SA_DISABLE_MASK;
+	vbios_setting >>= GC_USER_SA_UNIT_DISABLE__SA_DISABLE__SHIFT;
+
+	max_sa_mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_sh_per_se *
+						adev->gfx.config.max_shader_engines);
+	disabled_sa = efuse_setting | vbios_setting;
+	disabled_sa &= max_sa_mask;
+
+	return disabled_sa;
+}
+
+static void gfx_v10_3_program_pbb_mode(struct amdgpu_device *adev)
+{
+	uint32_t max_sa_per_se, max_sa_per_se_mask, max_shader_engines;
+	uint32_t disabled_sa_mask, se_index, disabled_sa_per_se;
+
+	disabled_sa_mask = gfx_v10_3_get_disabled_sa(adev);
+
+	max_sa_per_se = adev->gfx.config.max_sh_per_se;
+	max_sa_per_se_mask = (1 << max_sa_per_se) - 1;
+	max_shader_engines = adev->gfx.config.max_shader_engines;
+
+	for (se_index = 0; max_shader_engines > se_index; se_index++) {
+		disabled_sa_per_se = disabled_sa_mask >> (se_index * max_sa_per_se);
+		disabled_sa_per_se &= max_sa_per_se_mask;
+		if (disabled_sa_per_se == max_sa_per_se_mask) {
+			WREG32_FIELD15(GC, 0, PA_SC_ENHANCE_3, FORCE_PBB_WORKLOAD_MODE_TO_ZERO, 1);
+			break;
+		}
+	}
+}
+
 const struct amdgpu_ip_block_version gfx_v10_0_ip_block =
 {
 	.type = AMD_IP_BLOCK_TYPE_GFX,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
