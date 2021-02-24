Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42F2C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82BD864EF5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82BD864EF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 987AD6EBFB;
	Wed, 24 Feb 2021 22:22:51 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770078.outbound.protection.outlook.com [40.107.77.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 295516EBA0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/1LT9gJNT72XggMytOu1/My4+tb4CR0qeQyTVKmq+LGbgbXbTBXUVW9kFD6U1Utn7meZOwJquSPGRKlHhC05PWrOPaSXizEjzU09JT8B1GDInY6RLOjnd/Qz4b98IWixEHauFB+ziRXN5RXHAnp12mYCBVgxxCwIsMhZuLGorsbEhGb5uIOMmqzvwkT0uxpCgvpQ+4kUM/GSrcDxDHKoMzMFuFPV9rux8Yc3EsWsL163HmKoWH86jsQiSXJBBKWIlTKwlyyfEQo8FcviGLUw+anZ04J6I4Sb5MPVdOT3D17X6I67EkdtMtEzsIAUvLyLzdMc+CH+6Kym/HMATKEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PilFLfltLoKi7f+X+XX6OVpRS5F2J7BiVGfNmCU0Eiw=;
 b=OO0YI1QiktA89tThnbqGIyMPwPB6WfSIgLD3AbItpuKHfCYqjoIdLg1wXNQY+44FPEzbH39+eZswtb1+w+leIqdfZIJBEvVZmNQ/VU6L/II7qg1tYUiTLdAHYFJr1l8E8Qm4htsJ+EcAmnGDyndC3ZgZWtDSkGnE4pDPBm3khRu644lm3vyo+V26RMc2thdMrKa295qDnROlSxKDuAv9nheqzO3EAf2NBNJrCOr8oL1qfiD2IaeUhJGiVax/bpZLUOHLJUrHxc7AMuutJijQCM/lEIp/Mg8bUYJ0YiNY9m6SUCQjdD8wVS++xm4tN6//bK7HmSZPs95eQJmMw68HGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PilFLfltLoKi7f+X+XX6OVpRS5F2J7BiVGfNmCU0Eiw=;
 b=CgJHz2XVB010Vkqpm+2pQcJ2TXmJt5gBDmh89sUTbFrGL5AwgPc165hrXmuQX6vyA+ride1ctCC/fUkCKf5qahH4bx2DUCRwwJxJ7v3rb/H5ffOtaRZ6vFi89FN4TU6mwnLnB3UqPIV+Y5VT2G09tUW12WgtWPy0CX1deCH+xC0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 22:22:32 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:32 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 140/159] drm/amdgpu: use pd addr based on gart level page table
Date: Wed, 24 Feb 2021 17:18:40 -0500
Message-Id: <20210224221859.3068810-133-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9adbc419-eb37-4491-17e7-08d8d9127557
X-MS-TrafficTypeDiagnostic: MN2PR12MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3807C8E6DE6B1842DB60265EF79F9@MN2PR12MB3807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HPlrYNdolpQdf/racLPszqY0Mob9esuuEvvLikPfrF6tTaK9FFrwCHL6FZoeeL3+SuG3f6Lfixm9BwL/6NZuK8wV97nBthSTtryd8MEB33qBKdfCXy747nRR7jclNB+oO1WiXjuYYMnLOWx2V93fjDyN++gUJ2wD2eFiRCdYgxLNJvqWQoQ6H4sQzqmY0DGoqJfs25lNUJyG0HCSzujOyrIF8QSaEwZwMLzb3aTsbS+M5aCdxdna5M1a1bVoIXpMnExpphc8WSyKxGxMd6JgCCwdKxf5/5plg/6d23BYZNY07RXCpN0yuVFgpdAba1MpUrAVNs7VL00gUBt6dmsDd8UaSGIinG15eHLvk6dYp68S+W8lOrn5q4WvyKAD8gzxKFAdyQbVCmhyqWn0Us96O59vBT0/IvijelgwdxRxXLLnik1ZqQtIFi2SIhNixkr5tdrDijGKUqYbW+U+D5/hw/kdUC/KoSKjLQ4suo9S72s/FqjaCHmkv4GMhsalyeuHSeDXghJXhFQws54iuy8oswyw7uoowHMZ0vj65pOkUOgHUKPOHHIU2iY/6QmWe6GeO12lZGuDL2eX65O0jUJalA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(54906003)(478600001)(4326008)(86362001)(83380400001)(16526019)(2616005)(186003)(36756003)(66476007)(1076003)(6506007)(6666004)(66946007)(69590400012)(6916009)(8936002)(6486002)(6512007)(52116002)(5660300002)(956004)(316002)(2906002)(26005)(66556008)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1hmzpTr/+DAfe67oRJ4iIIWDXH+ddYtY4iCMn1m8F6gpezHKzFaaaeLdIyeH?=
 =?us-ascii?Q?MmlV8/DELLPcC9+6Vg7RZQkzEIOoWVNL29nPQircNfCkQtW5sose4KnMZ7q8?=
 =?us-ascii?Q?0yiwdVg1Vzkxml+dPSISbivYfp+WLzSga57iRJG9I5lxD71dZAOhxOHDtF3c?=
 =?us-ascii?Q?+bN4PY4haO7AToowfCLQ9LSs+ajacyibr5x9qL0fbM1E6ZpqnuAYWaqTKMPO?=
 =?us-ascii?Q?lGKnP0kfhUVdBHoEAxiBYGyb7s3XdeQfjmeifgwv3N0W4FqiETC+GGhXuNFZ?=
 =?us-ascii?Q?buFNJg2U2jhPsO9rusb3pmIu2IB+Ik7o5Ka9zo5vbDBaB2E34TEardeaYOeS?=
 =?us-ascii?Q?Y80xewVTlHjIs32qUuI03LMBr8D0MLcmiK+b5BVtBhn5cKjwXWg0u6zcxhuI?=
 =?us-ascii?Q?Vnwg2SKs34MhnnN4pK8l0p+LrWIF/nQcH3V9bsne4GRC3b54vYMG53dAuU55?=
 =?us-ascii?Q?1SOHlO3gdgvC6wdZ/AEp8QAeVMLcQvhzo3BRJE2n3rImCxfKJRxLeBNhJFgJ?=
 =?us-ascii?Q?U6WuAE+nVFOF4xhX8jnqpNWpUppcK+t0ahEgg233HJVvTDs5dPGvJP4hVVta?=
 =?us-ascii?Q?fQPXCs1OK5tR9SDNBGHf5/d5QC69hB7Wf0NYFqQwWWkNUm60ZWgQthcQ+8yj?=
 =?us-ascii?Q?zeHansUKttr8E1cdaVvhTVLcQKEW/0njH7kPQ6SBT7NUJ8g4DttTVNCJwLsr?=
 =?us-ascii?Q?YCUBGHlnXCxVfiTPBMFi79GfUfP5ozKLLlIuF/ZALlVvw+wdvUkIjr593HRv?=
 =?us-ascii?Q?2RF3jq0z9xQp2Jfm3ZM6Sc8EAxzkTVC7oJ5zL5e8TOOmilcAHIK61cKoU37o?=
 =?us-ascii?Q?fW1J9DLM9BkSU2e2dLby30cMEHDzH0awP3nqwNuY6SNW68+AOjDJO7GFrqHN?=
 =?us-ascii?Q?CKXUuhntGo5Bfi1qFgXx6GnqUrBsNZJJePQMYSsrPDoMIw3/QshgvORwkaHJ?=
 =?us-ascii?Q?BBhq7SVsZ3V0Rtryijed9mJl0muu9pXhkbOXa2NRSwFMDItnQLDL+KCHhkIy?=
 =?us-ascii?Q?jcP3YydnCvk1nKnnTk+tZXV2OiXY2V5ZMsmIG8RWebnUUU4LDaozNP9x/3nz?=
 =?us-ascii?Q?mJGCBPLa2cGbTPtt5QgVuPDBD69giKpVWwV+x2fy7HDx5+nAP+zpEANVfCTi?=
 =?us-ascii?Q?2lYUsKF465e0kzrks5wSoJimF2mQgk0Dz+9uNcxfnUWIDGv+FxvHLY0kvA1u?=
 =?us-ascii?Q?s66976IUPnaV8/ucX2ouD4C96/ZMe9tyxC2SENUwQy6sF21A/alCG3OsBu18?=
 =?us-ascii?Q?t1akxVr3Jx7dvpevCXeAvWiVi69yheyTLROjEjcCk+Qw2Wv6tIblT/aHtciv?=
 =?us-ascii?Q?rsn5HcvaodrhCTUuQDJ+jGnn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adbc419-eb37-4491-17e7-08d8d9127557
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:57.5918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAg8pzk9Tz3Q42AfJAZpVsYbVv5qrqtjAPkjKnDxmG19OxWBc7KYIJPrPT/b318WbZquzJdV/zc0ia1isgbsag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3807
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
Cc: Alex Sierra <alex.sierra@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Oak Zeng <Oak.Zeng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Sierra <alex.sierra@amd.com>

With a recent gart page table re-construction, the gart page
table is now 2-level for some ASICs: PDB0->PTB.
In the case of 2-level gart page table, the page_table_base
of vmid0 should point to PDB0 instead of PTB.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Oak Zeng <Oak.Zeng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 1118142f783a..0213e4667422 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2122,7 +2122,8 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 		return r;
 
 	if (vm_needs_flush) {
-		job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
+		job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ?
+					adev->gmc.pdb0_bo : adev->gart.bo);
 		job->vm_needs_flush = true;
 	}
 	if (resv) {
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
