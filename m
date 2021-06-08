Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F46CC47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 13:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09691610E5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 13:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09691610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C167D6E87F;
	Tue,  8 Jun 2021 13:06:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E7256E87F
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 13:06:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSD9BiAGU4oFChNMvH70Vi/8M4yfUCSSLz/a1wbcVJ4yJ1dWB4P4El2Nx3KyBWSwV34x8k4oU2jxjJs6fm1WarOI+VrKcdDBaWL2mudwfyWHMau8FQzaTGw0MjdRFaYIiOM0hDfThM/pG++yVm68uRv+MOpDC33vsBjs6jAPiPALTDMaan14SXzDLnen0/gLbW0gLUxCOlP7TjsP/+b6bEJREtP5rRuOGKoVXbLMyvPrkiXWDAcssE85zFScc0VlyNIK4PGu5KyisfgigDU84DMJam8jM2TdLzMFLj38JF6+E4ounaduUP9xxmCQ88v7RcUc4kkPTaIsufkK2v5xmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCO9O/hVWhG8AHpofAI1iSKdNIB72Qtk4xwRb93a2PQ=;
 b=CdVXECdL6pj3I7fpcHvcaB3hyOBhWTEth+KdUPQLbdyvii8Zz09If0YEUrjVWHqgWaH9qSUO7j03NtjEsMBRTSuj01Wx8Lm37Px+GoQAuhr2cnP9VREuu/JerO307BEemUYIhOrEvTiJcUg/HWVY1c1XSMep4fIOG6SeoiZ0GYBQ/8uQhKTRufqHYxVE77O2xl8hPoqkFn1i3LxfytcvyCkfZQoqSBvoGPPc0QfeDIM7V8dcHOjynb5dWBPm4pgI5Rr0loGqmb2frIJCzJGAWdjbPdSuQXb1LFQMt6wL4CbrDJ7Ks0TkVDaUkcRKfPX6P65vDexjj4sD91To8BHcww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCO9O/hVWhG8AHpofAI1iSKdNIB72Qtk4xwRb93a2PQ=;
 b=VEBDuwuJSWFZtFDtqU0AHz1P1xI0JWX9h3GvojWO644lIavDJq7Qf2tMdycmSkmds1nZ4xm3TgDgaK92MJl8pk/WXsMt8CP/O9FPsjl5FydT+T5jOemHRzMzkPiIB85LJ5U/eGkHwSa8nSKjlR+9LhrC3czuTixBcJjl/fz32Bg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5477.namprd12.prod.outlook.com (2603:10b6:8:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 13:06:41 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.037; Tue, 8 Jun 2021
 13:06:41 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 1/1] drm/amdkfd: use allowed domain for vmbo validation
Date: Tue,  8 Jun 2021 15:06:28 +0200
Message-Id: <20210608130628.71281-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN0PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:408:e4::25) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN0PR02CA0020.namprd02.prod.outlook.com (2603:10b6:408:e4::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 13:06:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a103fa8-0467-45da-d1a2-08d92a7e41ff
X-MS-TrafficTypeDiagnostic: DM8PR12MB5477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB547709428B7F4340830D214A8B379@DM8PR12MB5477.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fMeuUkkQ/lBKvFrE4ZmQhNCiIGDmVh8jFYA0iOqJAsuDRIjYiEVKXDHLxuoW33nJwc6jYB14Ahx/54+/fagVssC14Tu6V6zzj0MegrejUPX2W19IYn6B8SH5UMuWV2cJnT2j7X7OBkFbOiw1uO7YUBjDF0A6t106iTP7G4BwHjhG05vMla95zvjRhCA7HCzNgdb4Z56EFKgchDs4AdxSPQ+sliiY9oTQH/gkv/FCyU0HcHrmdmgtqzxzCdyo0MPT6/R7XbS5VeWPdyVk+bRhXAW7VjM6eYU1RoEaagvLdIjDfJGO24ZnQmBZ/5JoOQVJkaZROHzqZ643ZcDeJBiQMuNK1jzrNHXSulGlXUOxi6iyKs6LRsCkEUuPMuSq6xXLRhXHQtYi8w6cwtBSY6CdmMJ+auIHJZwObQhTUsL5wIHr19qoQ8hn1OR4Kl4IyTWtyVsAxlAD8N2hPNO0epGa6Px2g472pfNG7P0bKXd7360dpZyRdF2Nt+A0guzfN/QtR6u5pI/E5iWmdqZS9lz1xK445vOy2f2icW6MPRHUetTMHySOq7hdxXV+0oOvVcJqJUH65JZMOIbuEZe1kq6xvV6wHDAcoBv2zPAherXJy3bSOP3zF/V3t0iht7TZxe6pcm/vPTsIDa2Ag6SEwYwieA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(44832011)(5660300002)(66476007)(66556008)(2906002)(956004)(38350700002)(1076003)(38100700002)(8676002)(52116002)(66946007)(36756003)(8936002)(2616005)(16526019)(7696005)(6916009)(86362001)(316002)(6666004)(478600001)(6486002)(83380400001)(26005)(4326008)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TphoXqpR1qwomj+00cKT/QmS7h8DmUypA5347iIHqijZFa2k1V/Lv/6KhKIlwjoDgkV8G6t2qQpTb95nysgrshbaTMnC7zTFrYsfqzwCYiUwO86OiUPTAd69LCdBzQfa/20aIlOuSn2J6IOYjgdzC4mwgmKiItuMYEDuFemtTgjTYN/fZHMjzEAUVF2UaL+Ulq+aEq605mz1rno7jjkp0VuE/ArjD0amTU+IkHfRanyPEnvA0Vu2oDSXhsr0qvA7nX07adUlImWcRZLxE+XgBrHdS8ZUQvFApxpXgVKOcl4R1irtfNxuxR08T5DOTW+5XAmizYoPc/8LIA4qeoU+V2O0/E0UydAyWjR0uftpe2MX9xdLwxnFNhMSrTJcTKw2F5Kbz0leIO4ekVNiOoSsyJ5zzjRKr+3nS7hC5UgyxCp62GKlpjyq0SMROXZa2o8lgnQHIrgkF7dzJYTiJwC8riKPp+Fp5SuTiAh/Fj9A40GPBVVn+wZHcm7LctbJ/QCrtCrbYECHcrQhtLZJQkCmQSEV/y0w5o7a8MDsS86tY5niy7s3e0WXx+jhhCJ3Bi8iFa7XnMQ3PnHzGxQljr2PhRGf/9KnZOSitLmdjwRGN02IjqrtLMRtmUvqqiiTXkn03Zy/WTr9fpcDBdjmoZNZOQUoU5L1btjWuH8Ws3knuuL34iFUtskC7J4N+UFxBis8klCh2fqqOjl/EI9ta9yNSLv0mdc680jXGNFA9KsUnDJmGIP3+Bo8tpW9suAJ+Myg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a103fa8-0467-45da-d1a2-08d92a7e41ff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 13:06:41.3973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAT0ZzXSh/YIN1rIqdR6AhuMQQ9KGV+GJeeIR2CisyMne7MAbuGXM/EoZke1b4VG43kzK8Qr1IKrYuWrN1KIgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5477
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
Cc: Felix.Kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes handling when page tables are in system memory.

v3: remove struct amdgpu_vm_parser.
v2: remove unwanted variable.
    change amdgpu_amdkfd_validate instead of amdgpu_amdkfd_bo_validate.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 21 ++++---------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d6cb7cf76623..016815b7a773 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -47,12 +47,6 @@ static struct {
 	spinlock_t mem_limit_lock;
 } kfd_mem_limit;

-/* Struct used for amdgpu_amdkfd_bo_validate */
-struct amdgpu_vm_parser {
-	uint32_t        domain;
-	bool            wait;
-};
-
 static const char * const domain_bit_to_string[] = {
 		"CPU",
 		"GTT",
@@ -348,11 +342,9 @@ static int amdgpu_amdkfd_bo_validate(struct amdgpu_bo *bo, uint32_t domain,
 	return ret;
 }

-static int amdgpu_amdkfd_validate(void *param, struct amdgpu_bo *bo)
+static int amdgpu_amdkfd_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
 {
-	struct amdgpu_vm_parser *p = param;
-
-	return amdgpu_amdkfd_bo_validate(bo, p->domain, p->wait);
+	return amdgpu_amdkfd_bo_validate(bo, bo->allowed_domains, false);
 }

 /* vm_validate_pt_pd_bos - Validate page table and directory BOs
@@ -366,20 +358,15 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
 {
 	struct amdgpu_bo *pd = vm->root.base.bo;
 	struct amdgpu_device *adev = amdgpu_ttm_adev(pd->tbo.bdev);
-	struct amdgpu_vm_parser param;
 	int ret;

-	param.domain = AMDGPU_GEM_DOMAIN_VRAM;
-	param.wait = false;
-
-	ret = amdgpu_vm_validate_pt_bos(adev, vm, amdgpu_amdkfd_validate,
-					&param);
+	ret = amdgpu_vm_validate_pt_bos(adev, vm, amdgpu_amdkfd_validate_vm_bo, NULL);
 	if (ret) {
 		pr_err("failed to validate PT BOs\n");
 		return ret;
 	}

-	ret = amdgpu_amdkfd_validate(&param, pd);
+	ret = amdgpu_amdkfd_validate_vm_bo(NULL, pd);
 	if (ret) {
 		pr_err("failed to validate PD\n");
 		return ret;
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
