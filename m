Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C15AC636CA
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 492F9610CC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492F9610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 220AF6E43B;
	Tue, 20 Jul 2021 15:44:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F80D6E437
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLHbJXjyAheotRJ7Yck92vKP6xMPgJID11dKaP6s0W/YxODJhVMBHR9qS6O0OGuHKDRE8+bzMvQWInYN0bxG/IaV2gQxOsofy0wFRgujl0XClm5sVxlHCuX09drZ0oyuFXNQnuzYBwj4Oq1Z+fKxL+203BbWpwbxjJ003d81gw68NMCKJrbhor+UD0R1o1RQMbsc9BLZ3b0z9BVtmFgV9kD52I3XhS/11rOm4MDDq65bu0jMz6uVw7wsb+gZDpS5Agk1agjuC6frYPoM4g7b/KsAyMAd6h8epkAHmxQnMciTgRUbxXvWUNF6T+e5QCMEDNpSDpKNVubkGdPQ+epDKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fj4zCMgVEMdXRmwtNuK0i8Mbp8U3K0VC9J6kM2TX3U=;
 b=JOV/Q0iWPYDxYeOlQRiZcvTLGkQqCH9/2ZBix9hJeTzuSf1Y2L5HNJ0+IzX4EiQ58lwXjity8TOMH06S8ge+/1WIkwSlEDqvptI4IECFL1R8X3Dh4u6asKtRcNvfAwiMJQ+UXqaGpbJZzLpIfTn7haQ2gd0S5KkQPTRX6E274MR/VV0rkMMCGl28QvwZ3mMwc6GnJLAz95y0HLHuxFT4nOxGwVVvlqBunzi4MosSqdhhVzw9XuazKE89wVrkbP3PZ78/CrDMQI+jigTbGKybxtGnFL27yTdG5akO7LJxUJacUhSZLxvF9+TVtHiCMPXpGrKPWHFP9CYzuLkz1eDJ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fj4zCMgVEMdXRmwtNuK0i8Mbp8U3K0VC9J6kM2TX3U=;
 b=F8EaEJN5rAOGIjNgRreUOrJHjleO1wrsZpxQovKY6/SVLLHSN60dnNpC+bEzXvRRleB/+qxffd7qRQnc7zu8E/kJv9JoekiVxPMQin12brp6XPAWA+EKxdSWBMf4jsHM/JWVEZBozl2wVFaTUecKXvoZb5HD/5qXglb5GXpHt50=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 15:44:14 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:14 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/29] drm/amdgpu: add sdma v5 golden settings for
 cyan_skillfish
Date: Tue, 20 Jul 2021 11:43:32 -0400
Message-Id: <20210720154349.1599827-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 018c5657-59b2-4d35-74af-08d94b953a07
X-MS-TrafficTypeDiagnostic: BL1PR12MB5288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5288AD02344073B1271C51B3F7E29@BL1PR12MB5288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mor7NXr6KXrEfrkNarBR2Zt6eCPMH3WGqrZOIfLVPqnccOIz8Wxj4kP7WvhbS/uR/1MEdn0lFhEvGwH7zDyH0T1O2cS0XeAx7Ee4uLuAbPQL1JDnrph7BD5yvmHOwDX3YjHUxI4iyrplNNOH155rnrPM7PQ+I9U3lEpBuNg6kFtXpiHIo3Yzq9naqlP4k0cOW6f2Y+Bm5AJ2uE3zlQa6yBM+Onckv8F0CGNsgx4jKNC4nrQ1AzY/cG/jgFrP8defMfK6vjNLg5BUfaLsIqxnU2EYqV9uAp/gU/8xcflRh4ddRMx/36Vwwv5aqgoH6mofSVbqMsIvow9T8KT2PY90wt8nbDOG96knwaHRUmcCIILHK5MrqN2nK/VijVUc4vtW+nkquSwBxGgbzX7q8NIL10i/f+DqZeKvpmHz+XFXVfYJPznJdtRUfa575S5+yPIJXdLps9U4iN3WBYKeZHl1e9FwzmWVyApwDGDaiDLIy+ERg4J36wss0rLDhXjANRXMIiifZ6BDwB0C5X+m7JI4feij7nTBuD2AKxWPLeL2LQ2zMDpblSB4VxUjmt0/MKG6QQhH1bA7c9Kzz0jtiarwpSz50l8IAlW9R9lOgqd0GKLNcTDin39OcPpKSq6X4BaccjvyeTe/RerwiuL+QbGxSFsfaVHdk3rbjzTufEn0ybzZtTl60HOQdUVJTK7/IoVncUqRlUrL6qXPK0cwoWWh8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(6666004)(66946007)(66476007)(54906003)(1076003)(86362001)(2906002)(6486002)(38350700002)(38100700002)(8936002)(316002)(478600001)(36756003)(66556008)(6916009)(26005)(186003)(5660300002)(8676002)(4326008)(956004)(52116002)(7696005)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zwE6W+4UlkYJjEvsJNHDmtYqpkTdrfq97jXKR6fCV6npTL6qS9O8+a2w8gKB?=
 =?us-ascii?Q?ewkz8h0UMTHwAzEtFwl+bF9gNfhYZea3JQniqYjRtvLvdf5V9h5xzdtwPUZZ?=
 =?us-ascii?Q?bpeOuipat9cFj6zbbiQI10MadCy0CdSuNG9zSweT/FSSc2rXS46FAUMlNZL0?=
 =?us-ascii?Q?zs1XvkUS06GO4RngX+PbGmDz+QRzLb795pR8nKdYXWdyJ479JJhaHINIwRkF?=
 =?us-ascii?Q?gziNu1Tpqbf7rO/iYxbTemsopkmCrxsaxYIMCSmiQNe6fplsaoWN64jprvVg?=
 =?us-ascii?Q?zr7+/hqZHQj8CCpJjGPVOCQSFGaObKDQeqHrxTRGD5OfcMYuYkHHMZ7znBkc?=
 =?us-ascii?Q?OcxC2j4qqAuekylKQF74KQ2PQEN1qNgPctzqnbf2ZUYQ4CPbri0KsNrW8nkL?=
 =?us-ascii?Q?a1bVbbLE7GNfYOdJyoAN9etwjrKT5MD9X9VE5lg/K7D4QSWH0vc7OnZhM4b1?=
 =?us-ascii?Q?63WQfh34O7oht/HE1aXZiVwbTZFh1Y2WeGQKO0lLeMh4Lo4tonLnWui6FvSD?=
 =?us-ascii?Q?0hq022rYys4B3WuBTYshgJfiuGW+IEq2lLkjAlfknYpez62fdyYzPJQyeSTR?=
 =?us-ascii?Q?yFUla62HvDDMJgu2iknpD+Rz1tOE4KbFhX3E2ahtcf8U+ZEcxl724IK5neLd?=
 =?us-ascii?Q?+QCGn8rHUK+OePOKiDroI+59TJIdVZith49s7Md1wB8EjkQiBvse7kYlRapi?=
 =?us-ascii?Q?MO4XyDrpR2aZ1cXFiSe6P3S+T5Bdaw5LaODf8viAkdJaJpkbdtthiSKHEk0R?=
 =?us-ascii?Q?OL/37M2yKwhvMzAWgQVmRrVILaK6dF/9IhkJfKkw1+goQ4m+Lr5c+OiQaDjK?=
 =?us-ascii?Q?pWOVeTlg4chdvIquwynN1zcOtMSp72pWi2KpsK1xI7y2bZp5b6vXQJarNqAo?=
 =?us-ascii?Q?Gnwa7aYvDLp0T3PQLx13WIhpFycsP8sck1bfRszO7lcyrfsvHb/dmw0B92ud?=
 =?us-ascii?Q?HCs9uawufEXWvlgdE7bCPIqG1SJ4HNNl6cPmUWG9mNQIMt8dMn3brHcOBX23?=
 =?us-ascii?Q?X3U0MjsbkYhm8YY05mSwhHeb7LYL1f2vKjLi+BSkFi4OysN5DMtCZjTF5V6m?=
 =?us-ascii?Q?D2XdeiMAQXS5Dg1r/gG3L0BYGnASuAEmbFOwgltu8Znp2JIYwSthOgemfauB?=
 =?us-ascii?Q?2keTnF8FRA5KlqTWBOhCm+CI20mQ9tuQbwdndCUSFHGvzNsR3DnkvnuuQEuK?=
 =?us-ascii?Q?K9p2/d3gjdklf5SYk9VzHdOSD718sBUzeAY+wqHv6GbJIvkRqn1WNXI2Rky4?=
 =?us-ascii?Q?pNB3kuPmHfFNvuyHDNXL+MGCfNh2wUjBBkhiDfd2T8+BA9t6TTxxor21dE0a?=
 =?us-ascii?Q?NuVZB7MzHKMG+wDWXqjLDbxa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018c5657-59b2-4d35-74af-08d94b953a07
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:14.7205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMUJJc4awkX0mwPFKS+JkACYSiKnUE9gxL67C/OrfzrxI1zf19wibpmXWVnw8TWJJfe7nVH2UMMgaZ3xWsENwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 4fe5e02a2a49..50bf3b71bc93 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -136,6 +136,37 @@ static const struct soc15_reg_golden golden_settings_sdma_nv12[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_RLC3_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
 };
 
+static const struct soc15_reg_golden golden_settings_sdma_cyan_skillfish[] = {
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_CHICKEN_BITS, 0xffbf1f0f, 0x03ab0107),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_GB_ADDR_CONFIG, 0x001877ff, 0x00000044),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x001877ff, 0x00000044),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_GFX_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_PAGE_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_RLC0_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_RLC1_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_RLC2_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_RLC3_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_RLC4_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_RLC5_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_RLC6_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_RLC7_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_UTCL1_PAGE, 0x007fffff, 0x004c5c00),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_CHICKEN_BITS, 0xffbf1f0f, 0x03ab0107),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_GB_ADDR_CONFIG, 0x001877ff, 0x00000044),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x001877ff, 0x00000044),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_GFX_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_PAGE_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_RLC0_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_RLC1_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_RLC2_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_RLC3_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_RLC4_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_RLC5_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_RLC6_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_RLC7_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_UTCL1_PAGE, 0x007fffff, 0x004c5c00)
+};
+
 static u32 sdma_v5_0_get_reg_offset(struct amdgpu_device *adev, u32 instance, u32 internal_offset)
 {
 	u32 base;
@@ -186,6 +217,11 @@ static void sdma_v5_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_sdma_nv12,
 						(const u32)ARRAY_SIZE(golden_settings_sdma_nv12));
 		break;
+	case CHIP_CYAN_SKILLFISH:
+		soc15_program_register_sequence(adev,
+						golden_settings_sdma_cyan_skillfish,
+						(const u32)ARRAY_SIZE(golden_settings_sdma_cyan_skillfish));
+		break;
 	default:
 		break;
 	}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
