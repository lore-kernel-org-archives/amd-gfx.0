Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19E9C47082
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 10:10:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7341D61355
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 10:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7341D61355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76BCF6E508;
	Wed, 26 May 2021 10:10:56 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2082.outbound.protection.outlook.com [40.107.101.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A186E0ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 10:10:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJrNVmc+2PS8sfiX59FlrvgU3R18iNM7ab/jo/1D0aIz9zEOLcB03SnM1gMZN4iBiL/USm++CilNTRN4EFn1goB83EDOIAVjlY9kKNcq4dFu1tHM1cT4wJvpaukE9tahaX8fh4b9irsBXqFtVtqjaKFBQ7A3iuIF19EhWQ7McUM98fRwISwSTCkQ/w10n/BUHngmdBj3JDAJuwxS+jV5kOROC6oMV1fJ9aPPmHJv6IG6KHL6udTAnGbigB+TIAz5XZsnAJ0oJObWRu+FJAsdY8jX3n1qhEQlYI/MSTBZlk0pV+mM/hHlRjCq4vHOsdM6Xn93m44yO9JCwfIYBhNPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzqbPa5FGicMAUrg1EE+wsbI79EIFrcaCy+5thNXt9w=;
 b=g9/0PQI/igZYTts511vPjZLg6Bsmb/oHuIComfN7MdiyL8g76shD33Emmr/0x8g9TPI7sr/AgOmOayVxkDaMsA+OQhO/dTRLacs7MJuRNl5YNIKYUdRWBRpmQiGphI5ori9CS8UOBbjCGwMraRuPvAUEnunvdfEFprNqtkm6qhlPh0mwT2I0v7+NRD9DgmHFz/NnmUr8rt/GhvJ1J/i+06C2BPAGF9IUA2h9tDdNfnoa7DIwdlf/B6G8KRMhlOBB9uTq228P/E3fJ+fo7kzK0wvMAhsPhRJx/Upr2FiBVt9x9fW04jf2ogFibtRZajrlnDZx3KDRrdYj78SwaD0PkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzqbPa5FGicMAUrg1EE+wsbI79EIFrcaCy+5thNXt9w=;
 b=LPnhYEvSNv/0RJgRZEg4LUOpGnl8Ykb2u08/zep/Ep+kOt1NH8GFmys38vx7FSauq95GRNQbZJBDfRXa2yp1VKlfifsF47Uvvx0GIYQuLDawawEpa966Jika9uGiHSMLNjasH9QonQ52GS9Dey8jr4+wzuneOPsihRXRbpbl1XU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 10:10:52 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 10:10:52 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/7] drm/amdgpu: create shadow bo directly
Date: Wed, 26 May 2021 12:10:24 +0200
Message-Id: <20210526101027.14936-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526101027.14936-1-nirmoy.das@amd.com>
References: <20210526101027.14936-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.98.218]
X-ClientProxiedBy: AM0PR03CA0049.eurprd03.prod.outlook.com (2603:10a6:208::26)
 To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.98.218) by
 AM0PR03CA0049.eurprd03.prod.outlook.com (2603:10a6:208::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 10:10:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79bf5310-37cb-434f-5f38-08d9202e8b2c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB523208F4AC6CC64D290A374A8B249@DM4PR12MB5232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0928c5a1Gu4fFh90VV8BPylMwowdYInomHtrjXf+MIEIecDhWRUvK0HkQ/NbdDJXD7f2gWyv1Fok8w3/CWGmkBzpeG5jol9V5t1tMWnPI22LyMyjPRqMd5mBuEToS8w4Q3nLJK2Ln4HrTlmUIy3z9M8ReVRcpS5LVUKUuFhYYSi5GftQh3l9dWFCVQ2MsEVFvEYUUrLNbhheiLdFtcPynkvgz5yl7aMGDmdAtFYIbcRQFLk8fRYvioW5Gz7ec2nOGmDcy5wWZqX9pmKll02g3gGBgBUnJpHDhDna01uYJdR0/qmwO4lsvZof0r88xFkX7KyYH4a8c75um6wjTyLa2eiSF32HRTJzb8szAMQhcQiwUGoJctz03Y+YN9u3lTzns5lon0iZ672KHC+h1736hXQXf14Pwlz3ir39jEj6Gu1YLobh2QRLie5vWIZ8lPfMh09mDUZyhCd/g4PkRYpH5MZWdRn66eLOrxuVzmslnfo4IIyQurIzoMv+q1jA+bPe98N3Ulc1Ir0h+MVKsekQVub2h98md4Y+NKXK9yrRpoLm7CpwUFlmtgWNqFUUkwYep9lfL2qmWrTaseH8BKMSppNzn+7CG+DhxR4Rb/iUHtopZMIeAtTciVJtA/lMhcH2UNOiehNHzAQ3+rbnTJILVf87ubQduOM31QsU+0nZzPo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(5660300002)(66946007)(66556008)(6486002)(66476007)(6666004)(86362001)(2906002)(1076003)(6512007)(83380400001)(16526019)(44832011)(36756003)(186003)(6916009)(26005)(956004)(2616005)(4326008)(478600001)(6506007)(8936002)(38350700002)(316002)(38100700002)(52116002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cXcnXyRGKqEAcyzxkKyJzaAr0SH+YF+qUErNzHR5NQWcRQa9LtJHpuFi53yN?=
 =?us-ascii?Q?aH7CddN28SyN+hihyAe3teipKk127hB0rZVv+5OJIcDPU8IsegnyN1CVVQVI?=
 =?us-ascii?Q?h+vnO6CtSAo+PL4qK1ONq+w5KX49HOZGVaNtEgOP/hIzh9FCAGzquhDZNkb9?=
 =?us-ascii?Q?3uBcNVAwBrgBXisp/N05nj4b4tU4AKH5rczlbuTfGG1GZlvhUHJyfx7/SE8o?=
 =?us-ascii?Q?tlQVSeVIu/8AvoBKcm1gbJ0GXTTIo1XmJEpRKHxHs/x/D2038EjPDeuDfXdy?=
 =?us-ascii?Q?IXGyD0ATqvDHlmTnUL6pGgzc0xJaLG56duEphWCZrZwiXWyOeWPWG2Y6CYuw?=
 =?us-ascii?Q?5PfaLQD+qaAW9F5CPSbUkxUCAV+gm0WTRox+74cr8mTEnYQliQxm7FoKSLtT?=
 =?us-ascii?Q?0n7B4EaS7galaEvoI/DEaASUmFFfY3QDfTMfpL2PvU6UFWZTcUTqTPo0IQAX?=
 =?us-ascii?Q?NnD9DqzXKNvQSG+Hb8D5MPYcNnUg+vr42teGcIBqC6zBaqLPmo7qitcA1lUq?=
 =?us-ascii?Q?jd0HoCymGB7LtvgC1fdHiPsGolgWt/S4sw5UUjSI6FmymWq4lJFc5Me0O10h?=
 =?us-ascii?Q?ztasCw8Xy73q3AViqJ7QFiTZIeMg7CWmgEUMK90G6H3qaD8adJpMUleLy7Bb?=
 =?us-ascii?Q?D8h3KLcxWEU6ttZYyqRvG3WENorEbmXa49HC2xUr3Qehzq14W7fkqOExgQN4?=
 =?us-ascii?Q?+Hk7XkCYLimH4xNU79p9LkXXuwAhI8yG5KeKKtXntskksbdtsRgP0EWjsGZe?=
 =?us-ascii?Q?4AQBCzN4oQ5WJcx9k3SBldZOkwt5th2RZeNCV7uHhHJoI+Ejj8/thG7gx4rH?=
 =?us-ascii?Q?JZ8GknCtz4vlGPQ6wug/k+HxPEACxm6hMjBixXvSgGsJnS9mAUM2zX2UgiP4?=
 =?us-ascii?Q?qkKhwpNMvKZDdo7JZy3RmDJD1Gt8cUDH4f8aPhE00BNe4CCKh7ob9TOyROPZ?=
 =?us-ascii?Q?687Igogj6BNqD3weLrluClKUKWIDsjwBnwn5dL/U/LifruEUEAVicZZTxSoR?=
 =?us-ascii?Q?SZ11xGwQsZ0sOv5aFGZf8zg0ZHNCj9qQGP76l1tF4X/85MFSTnVDEJGKOhIb?=
 =?us-ascii?Q?xmd+dkHoEmfnIj3T//1qrejsleIquwsYlRLveZs5Bo90kzk6GTRAMLHpJv++?=
 =?us-ascii?Q?KWWPVQS2M8Ohz3Th+8pQwTeIopbrvepx7Zzz6m8de9gO+sTA0xP4rU9SiLD8?=
 =?us-ascii?Q?GzL7r1y81FmwrKAiPF5i3YxBOj+zg2U1+HJn8aoO39yQtv2eNK6r1cYT8eHE?=
 =?us-ascii?Q?Y+Hyn/Y4Aqp3Ac3vMvc+nhdlMHxTS0jsWxPjWHAER45y3D5L9jCIau0XI/3t?=
 =?us-ascii?Q?CXs3dFOONOpQBasFN8vdkDyr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bf5310-37cb-434f-5f38-08d9202e8b2c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 10:10:52.6246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/J/cjgeDOYAuQv3CgVhhNY9Zfk+ZFMnXr6N0yYuF2UPjUw4yBflrE/kxBYa/7RvmoP3g91VB7wOc1w0M1klDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Shadow BOs are only needed by VM code so create it
directly within the vm code.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 2c97d67d9cfc..04cabcc3dc3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -872,6 +872,8 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 {
 	struct amdgpu_bo_param bp;
 	struct amdgpu_bo *bo;
+	struct amdgpu_bo *shadow_bo;
+	struct dma_resv *resv;
 	int r;
 
 	memset(&bp, 0, sizeof(bp));
@@ -902,9 +904,19 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	if (!bp.resv)
 		WARN_ON(dma_resv_lock(bo->tbo.base.resv,
 				      NULL));
-	r = amdgpu_bo_create_shadow(adev, bp.size, bo);
+	resv = bp.resv;
+	memset(&bp, 0, sizeof(bp));
+	bp.size = amdgpu_vm_bo_size(adev, level);
+	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
+	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
+	bp.type = ttm_bo_type_kernel;
+	bp.resv = bo->tbo.base.resv;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
 
-	if (!bp.resv)
+	r = amdgpu_bo_create(adev, &bp, &shadow_bo);
+
+
+	if (!resv)
 		dma_resv_unlock(bo->tbo.base.resv);
 
 	if (r) {
@@ -912,6 +924,12 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 		return r;
 	}
 
+	shadow_bo->parent = amdgpu_bo_ref(bo);
+	mutex_lock(&adev->shadow_list_lock);
+	list_add_tail(&shadow_bo->shadow_list, &adev->shadow_list);
+	mutex_unlock(&adev->shadow_list_lock);
+	bo->shadow = shadow_bo;
+
 	return 0;
 }
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
