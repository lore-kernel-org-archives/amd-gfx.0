Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16425C47087
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 12:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C43066124B
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 12:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43066124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55CF36F5B1;
	Fri, 28 May 2021 12:54:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 464F66F5AF
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 12:54:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNeibMQ9BYFgDKJRuUPsOwrGuMDJjGtmWyLSDTOsh+nhX6e7RfrvkrFt0pKb6gEn9lNJMtPkzt7pbolA2rapuhC5D0ZYkmRjexSHpvgUeDA91nDc/XhFugt7YB3ArSE65So88R9Kpjsrwn6nNgmcBfxsQePfstE1/sIgqA9jsDz3KrC6o7aXOYyDZxuSIT5BxRbUaJ5qYi8zHPZfahtOJUmSod9GdbrcF2qNbL2Gyc3wVVVGbQDV944ZCZPtIJUoKkubhgaXfRw/RryqtNFLlgwlljZ3zwebnfRYv/7Kv1/isa8FKoeZUfA+PtDNoLFfDNU9mvI29VUEGN3HkogYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=timMVAdv/z7gS6oVdNPhLSD2xsdUbEL1U6QZBNKVmL0=;
 b=eIHmnHh3b14QQT5IO3sMLPyFFTTE50LiB06+JudpsPD+c6gNMZ9irJ0wqhrzikKEp5x0XoyFVqe8KQrEoYFt5sq6kAFewo7XUkMO1A15dSEgOh1OXshJqYPYUqu6MUr/HmRGg/pcayzr4o0xmW9tW4zen7T8TyONSF8jYMUJ8b+skWE87ApkvYyDrKntOOI4mrxkfdpMcDV7zl3kVZ8vYtgWR/I2BHs0RZsYHb3VI9NJiL+Z2a3vm4/ekK1ZEztn8DXc2/8noYULPqedb8pOTnMsew6NpY+KiXnioKcFt+p85PeHuA2vdhLwj5UTiZZmzkqJ0iY9qKoUGuKrtnCufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=timMVAdv/z7gS6oVdNPhLSD2xsdUbEL1U6QZBNKVmL0=;
 b=Dbw+RHy+r0RMFQjGuPrapBKruZS3JoNDyCtKMAV5cnYDdYYvxhZpeRbL665VtnhgX5WnNUUNKdtpo//2mgx4ZBLGIWDdQEq5bSCH3p8MXlMmOhyXIau4hbV/fvVNxDlEdhQpis/uwS26wAUunK+ObcE+oUp6gKiqk9Y552FQFyQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5215.namprd12.prod.outlook.com (2603:10b6:5:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 12:54:43 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Fri, 28 May 2021
 12:54:43 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: flush gpu tlb after a gart allocation
Date: Fri, 28 May 2021 14:54:28 +0200
Message-Id: <20210528125428.3862-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.100.114]
X-ClientProxiedBy: PR0P264CA0159.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::27) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.100.114) by
 PR0P264CA0159.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 12:54:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 527cac56-3fb8-4f2d-0776-08d921d7c3ad
X-MS-TrafficTypeDiagnostic: DM4PR12MB5215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB52153CB53268191E3C1A10468B229@DM4PR12MB5215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F1ouAiWPQFJNxHN8kpN3tB3ene2oLpLwNifs6NxLpzd7bNan3NHarVIrLiVr5KgumcNfDfy7d6ieHpricmzrtZY10jV8kec8dAEmfuWXteYUds2fXAUPGlh+BV2MINwS6HFnwnPrLWC6E9cH6dw9MvVrq9LtDvD9yYMZO1xpXJSgm3FSWjdWAt0svfpS+fcpGTizBRIqfC8R4Ps3sLUEf0CHS5d3JEuPUCaQbqPKFLVdjfD0ZzR7x9vczCZJK2JfQ22EAc8aZz74Cdo8t9PkoshVoDBPICF6+gKpEi67+K4lBHs5Cjucs1vNxNabynH7LOkRvCU+rrEUjPeNrskJuXcJdhz51wmkIZLaDRu4CLZNaFl/K6rxfr7+rM+bZknAAohj7/yW54ksCWpfAw3m2qszN62sqva93yppgyxFenHfr/yEhiuXXIqJvgxAJqAHj48riXpsmvHzoIkk5BqZNmEGnFTSX1iHm1Pw1tAliTCOEih1GRcwH9MUw1BElZWjwE5sfPx+N9IG7469lR4K8qTcbx9Pjjmcl4AkJvcFrjofkIHOYcJbOHTK0K9fsLK0zSuYU+FL8tL76uEVLmlDPusu3LFvZbpsjZt1LAHK6EIizIq3mehiLnu2gAqc/bAq5AohSWrGQucgHTuVZLMI9ya7QAPbjnnI4vDyjQkeZa8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(66556008)(66476007)(1076003)(66946007)(316002)(6666004)(52116002)(6916009)(478600001)(5660300002)(36756003)(2616005)(956004)(16526019)(38350700002)(186003)(44832011)(26005)(6512007)(2906002)(83380400001)(6506007)(4326008)(6486002)(86362001)(38100700002)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Z3x+HSJBl1aGbGK1UmKvJ12rscJyTv/nfdHpb2BpFWQ6K64h4cqzFXj6XJ7q?=
 =?us-ascii?Q?86FSOFfA0VRKVNh4k4vecCnZ6R7ApHs3W0Tc7cXlItvcXfgVZ7Va21djaBWD?=
 =?us-ascii?Q?xpqCqlvubQl8Cp6izJwMWCtzXqrlDls601Sc/3S2UGgLZVSWuh/1tsH13ebQ?=
 =?us-ascii?Q?EXHEm7rdmmfSiHxCMFbbmPNbTWpop4wSulO+CvL6llWFd2buPOqhi2uYRxAd?=
 =?us-ascii?Q?i6CIFPQcujRCbCKB2f9Jskr7g2n+Q6EnDN0+nDK9iEsYTL+nlGdzD1ngGOvD?=
 =?us-ascii?Q?k1QEQ4GzL60n2haJXs9FNz6phs1WoILFl8x81pWbhbWwR/g2Uft6eoSVEg+t?=
 =?us-ascii?Q?wNdbcIupk3D9HiYn9XHFqH9j0M+SuqAAhkw7U9aK+lYjefU/bhrCVsWLosSK?=
 =?us-ascii?Q?8RLzFZyupDcP+xesxkJjkbEO/54DrFj03OiYZTmDWqkjXUPOiA+yw7h/4/1Q?=
 =?us-ascii?Q?OKoIfiEru/jfk2lpPW9aJdcXrkWyiyFSfPpZeAPVkQReBRuli/YKvhOClhPV?=
 =?us-ascii?Q?8o/SWMvkyY5TI6atn+XpWCGdByHqW58twxURHcZM8n+2zOlbpsor/YCw80tO?=
 =?us-ascii?Q?chhqQ1E1CpWrNNyUKt4lRKLzTL0DL04bWQ+Unma8vTRakt+uuy+0AtxbWrOg?=
 =?us-ascii?Q?s1Cj2CpQC6Sqh0NHIGx0FuQNIu2noxGgcq6a1TaMoonHYhjtEPM2BNM+kNtr?=
 =?us-ascii?Q?TaH6mzt8gPVRNq6wkcRTcryzZYr48iK38TnyhBVXi1cD8ch4tazgss4e8zcb?=
 =?us-ascii?Q?xiYXPT90ig1h5e42cK+ui56QuZH7olC64Ot/Pu6/jeb1BI4bNSulYK9zpMbj?=
 =?us-ascii?Q?7gGwggFl4bRT6HmQmoRGWpho0XNVHRvx4tpByNoPcP6fcaArqc7eXUmA0g95?=
 =?us-ascii?Q?9D8iyCP6kvxppGj5haksz96HZ/XH5MpvZGjkMQsS0ZbzHrK4N4Sq5982tkFN?=
 =?us-ascii?Q?p45Pmvu+iPDwX2FKNJkvT9hwgUp/+7iRwPq00xbeyaVFvvVfIGRrMG0mk38O?=
 =?us-ascii?Q?+7odbXglggZSgA6CuTqS6mk0m7AGFXAAUQYLH+IdML1PE2GMGWs/EyMAHBCf?=
 =?us-ascii?Q?h7gRZ0gLHcGToLnRi2Z99SI/m3d+G6Qq5nUd+yqEnCy/lWGPPgzVaZtBvs2r?=
 =?us-ascii?Q?sWz8KQ6gTPhUo7BnZyHjZSerkRh6AIjdnH/S6gbLiWZWuQKqiF4YMo2Ea6Zy?=
 =?us-ascii?Q?5yX08+pKRyxdI3RYEViqtONXUnL90KGpl/LXEB8RolMA6OIsXzCWQau+Cfcv?=
 =?us-ascii?Q?xsyoTIrS3uhFTr04R8QqTur4JUuurJ8G2iSBMd2x6VVjW14g5yZo5jvZfSgv?=
 =?us-ascii?Q?R3oGUrXwvfbvldD6L55TAsBx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 527cac56-3fb8-4f2d-0776-08d921d7c3ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 12:54:43.5830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QpgEOYV1UDU5xEZw2Ya9XhAtJf+X9morVB3xES5a/Pb7Sd6TDXuDaHsy54CZMFFo8w//2FP/2kuOn3Ig8CvlEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5215
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Flush gpu tlb in amdgpu_ttm_alloc_gart(). Also
don't flush gpu tlb after recovering each BO.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  | 5 ++++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 5562b5c90c03..68d41063e120 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -329,8 +329,6 @@ int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
 
 	mb();
 	amdgpu_asic_flush_hdp(adev, NULL);
-	for (i = 0; i < adev->num_vmhubs; i++)
-		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index c0aef327292a..e68b5dab84a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -977,7 +977,7 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
 	struct ttm_placement placement;
 	struct ttm_place placements;
 	uint64_t addr, flags;
-	int r;
+	int r, i;
 
 	if (bo->mem.start != AMDGPU_BO_INVALID_OFFSET)
 		return 0;
@@ -1014,6 +1014,9 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
 			return r;
 		}
 
+		for (i = 0; i < adev->num_vmhubs; i++)
+			amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
+
 		ttm_resource_free(bo, &bo->mem);
 		bo->mem = tmp;
 	}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
