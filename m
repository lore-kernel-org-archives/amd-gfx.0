Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26CFC43381
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A8B64EF1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A8B64EF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABC666EB75;
	Wed, 24 Feb 2021 22:21:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3DD66EB58
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lO4D2ruo+/wMnfaua5R85agMHPB/AoFpSGboEI5tQNjitP1fuW/+RGiNMuXonO40pAuZ0IHfjpzYvZCUmeF9E77k3XIhCuZ/E+QYKN8+fDSUqMKQVkDSiC8HhHMiaNGe2JFvbkAE3J7RQfmQs4VLa8/AIIqRtJq1L9/t84GBCHDloSRV3BpZ0myv4a8sWmY2kLBfAM2ibtFcNhh6TZVwV17hGcz/v7gE+yjJARXGSmHfyNcxE3iW/p6fb9ZQBVuSipuyJWlK1I07N+JDrudQwxirtVPRIRs/ZsP4wYPZJKH9FVmJHoMG5Fr3XZ3Y6WjTsSvIXbiSHG2u40zybrMU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQWsxqSbh7MkhCVdmdt/pI9TFDeIMHp/8TSEKRVUFME=;
 b=QiQj5leU4bXiBGFE3U64tCNI4zyPo7jdenORDjY7MHpbq8DnOaye/4B36OPnf0uYal7H3oagTKkWsKPWIxBaSzQ48irZyoWy+67QSWiO2njBQVSzuQvopVDzRWILLd/lyIhj8ZgsoxG/jso2Y4VaxySo2S5+TjKNjRHPIAxezHRth9lqtyitRbVTX1HZRE5WsjMmbPWfuUdIDeonzljCwMTueWN+36QU4snSp2fkAQeWXEPZ4eEUU4DChQ62AHM8hak+uyq4IbnJr8mZ87UiefCF3UOnveMffpgNJ2CaFaG8VAGcMgAlKrBiRbmOUoaFsxpfQgQePC8bMcWPWL8NXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQWsxqSbh7MkhCVdmdt/pI9TFDeIMHp/8TSEKRVUFME=;
 b=nYmU3lCSn90kWmLsjRxOJHQGFLuiuOPKLrI0rTy9iZFZqVQ9Y9Me1SvoeUGbSD6D2DJXwclbGDKVYLZJ4EbqOeiLGYtbqboAC1vY9So7N7T/ebjVw10CzFFWAcI8l07xtnBQ+WN8fUnbgxFIHxSocP5jMYTd4wwMRdd5tBzLZyE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2497.namprd12.prod.outlook.com (2603:10b6:207:4c::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:03 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:03 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 074/159] drm/amdgpu: use physical_node_id to calculate
 aper_base
Date: Wed, 24 Feb 2021 17:17:34 -0500
Message-Id: <20210224221859.3068810-67-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a9d8539a-ca46-47af-0e75-08d8d912597e
X-MS-TrafficTypeDiagnostic: BL0PR12MB2497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2497634C218092ADD830263CF79F9@BL0PR12MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJnCT86QeKw44RuUecLqjbob1kM6P3eJ5aAc4GLpq2TrBXi/lMGl+qjIKMYeUKgwd03CGWS6HdGubK9mJ2LnWeKMvIkA8j2zASMx0we8OpoH1+EoB/8p7wKxQ3QeCMxET/CdkRZ938UoUTPaDeXlvbjUHLX+udyQ15z7OGu/6VH2qYcOkLiNaHbO1KH4Unq5zWWiTpHSIcbCa9YhkLtcMUrfOZsCDvFBt8a3oBPPbHY6C0Bw/NCA4A0Jur9oQt9rO518HQ3EE7jddJvTGf7u3kUt7v58SIEHxTPbU5vNcCAExCyOPArDJb/bDrP5R7hV1giFiUQcQLzUjZLThNuK+V2qFYnWx6PaL1DRhgu/EL7knfPH7OPLLkSJEhFU7lqGQ8nONepy7ZSweXVU1ZaQjgRAuBmmCA/C4X+yOpPtVAtqMY/nqKPn9K66xaFEI8sTBy27WB5scYOpa7GYFrKgWmmCBi0r1ojZF8ap3PVS/dz5MkKcXA486XoBf87GEj0Vj9gPXLpCOJ3vubvkNh1wrqi7AkcmDb2MPrTcO+dGtgFXl2bf5nK/MryyXypkqKrrDoexyBTkkpS4nOSTl2Xi5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(4326008)(69590400012)(8936002)(6512007)(54906003)(6916009)(26005)(956004)(6486002)(316002)(2616005)(52116002)(8676002)(6506007)(2906002)(86362001)(186003)(16526019)(36756003)(6666004)(478600001)(83380400001)(66946007)(66556008)(66476007)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RutG4a5cE7MvaGKcmkg49UC+5aKPsDDBxyu29VxbE4nv6B5SdqvCWNZT51q1?=
 =?us-ascii?Q?uaBuyAGjjRd5YtJnA0ci53QcAXI7+wyR6aZ/K4JwjZk94kYZyeaVV0+/mcCg?=
 =?us-ascii?Q?hAxSr3Ut+3FTzCcuqamjqvedQxkzMdCjG5wFPQ0UIOzVQiWFbLbxLms9pQ/K?=
 =?us-ascii?Q?0hrJwrFtJLdtR1qDfluyeyQVzdSzIYRh/ZgYAo7OY6JPF8bssCfFKgJI2ZLK?=
 =?us-ascii?Q?YqQ450pmDVEW0ydeATkVQDz/HUgmjUUFkI8GUMSdnknswDSNEIGL3Em/rMEf?=
 =?us-ascii?Q?yb3Qb+8BlNcYBzfizldApAEAv2rC55vwjRbU0J0IEkJlcX1w4XxFdTX1QabO?=
 =?us-ascii?Q?c92CoHXhy7RBTd3bbtvUFQdmbwg2Npmnmr52zfIkLKyxWyHHxbegmVbnc4/Z?=
 =?us-ascii?Q?By9+HjwQcN1PEOgbIHrDd98J2MeVnqTuALoXCVVne2BI6qyQ2lyZ0xvBBDBy?=
 =?us-ascii?Q?aq5WHqv9aZcmHeobIkOXMx+9QH3tT2pXSKy+W0qxNXQZc7UtQBIzHfEza0h7?=
 =?us-ascii?Q?663+/qVYpoEy7BQbwOuPDWeOTguaXwbPlDZnh8j4qAZih0H/OQEhb+hq1Aoy?=
 =?us-ascii?Q?EUs02e6ZUrGFDQP6vzt4HKiQZ5bTV3d7IDAHfd1Y2pLbDM3NEizgcOId+Xoi?=
 =?us-ascii?Q?i3AaPNyJXw3oJs75ucAFtqA91W2kHvTzzNKYmlgxmNluCJ+4T0gMGaIApJ3N?=
 =?us-ascii?Q?iUhB+GHoWHb5WEatbA5M27t3UUhvTYIl5dpexoZ2XR1wmP2uWthH7BkYggCD?=
 =?us-ascii?Q?qspR1wu6V/btd1y9OWNTX3Nnap78gx9VMqh56Ilrs4NDaKC5Djd8N8iB7HS4?=
 =?us-ascii?Q?/rJT1Lsi1YiF4FMSGelyZFnX/pJzd8P3HY1vM7S9DezeD80M2FofufHMwfMF?=
 =?us-ascii?Q?ST+qTh+uT7kP0kn7I+HE0I9zIV9TBfUSbCA1iHWApRrHhSbfyLA/TE6COi+B?=
 =?us-ascii?Q?f+Ns+6rHUCgxRov5TMcBAerGPFn4pJkUyMoiPdYJQeQR0ctkG4+1kPFZm4Fc?=
 =?us-ascii?Q?AZQqtqvNPShzuzGeXFsienzri1APC+3f7gZkEbvCuUNYqvsiz9NOdx7mAM5h?=
 =?us-ascii?Q?aRIjYJhRy4mEPlYdiCjyjEbAQ46K0SwZ94lh9g4ZHs7ekChrHRyqnJ++YTZR?=
 =?us-ascii?Q?25JZzUT0LLzB87FxMdIGf/bXu26rv4+JJwtkCrDAYhhJAbCmirHBewhz6e49?=
 =?us-ascii?Q?Cy+vp0FN9Fu9wEMXMDvedAYp4tipFGZakmZgkFCirxCJQwsyYVdhvuF0o5Tj?=
 =?us-ascii?Q?MvF5kA5NIXAessW9tLaT9WJda23EKbLv8hIoZiJ/zFdJiTGYblpEwPU2S9kY?=
 =?us-ascii?Q?/vtesZ/Kj9uN/Wzksm5vtlMj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d8539a-ca46-47af-0e75-08d8d912597e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:10.9018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXpp8EcSh5+/oWctO35IzlPF8oji5IG7D8XsQYjpgRzIoAztUMk5QIWixNwKDwiydjWZKvJjuXX9RR/FqVWHJw==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Similar as xgmi connected gpu nodes, physical_node_id
* segment_size should be used to calculate the offset
of aper_base.

The asic type check is redundant. once physical_node_id
and segment_size are initialized, it should be count
on.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 44fc85b78563..37c815094adf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1263,19 +1263,13 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 	 */
 
 	/* check whether both host-gpu and gpu-gpu xgmi links exist */
-	if (adev->gmc.xgmi.supported && adev->gmc.xgmi.connected_to_cpu &&
-	    adev->asic_type == CHIP_ALDEBARAN) {
-
-		adev->gmc.aper_base = adev->gfxhub.funcs->get_mc_fb_offset(adev) +
-			adev->gmc.xgmi.node_id *
+	if ((adev->flags & AMD_IS_APU) ||
+	    (adev->gmc.xgmi.supported &&
+	     adev->gmc.xgmi.connected_to_cpu)) {
+		adev->gmc.aper_base =
+			adev->gfxhub.funcs->get_mc_fb_offset(adev) +
+			adev->gmc.xgmi.physical_node_id *
 			adev->gmc.xgmi.node_segment_size;
-
-		adev->gmc.aper_size = adev->gmc.real_vram_size;
-
-	}
-
-	if (adev->flags & AMD_IS_APU) {
-		adev->gmc.aper_base = adev->gfxhub.funcs->get_mc_fb_offset(adev);
 		adev->gmc.aper_size = adev->gmc.real_vram_size;
 	}
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
