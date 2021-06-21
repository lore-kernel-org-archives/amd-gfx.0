Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88847C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552F860FEA
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552F860FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 153766E1F3;
	Mon, 21 Jun 2021 16:04:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95BFB6E1F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 16:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebJAXhcZaov7MAIZPycrImFs8nQK/FpPNZMlbrkHcU4y4CdRzpXZU6+JM383qVZEwFz/KfsEr/Hz/ZdHWsnA8VgBntoJWvlzeDYhvifKLS2E1ziM5UdfMLZUPU/Jmm9STOTm+iCpo2Moa+y/5bJmuavZJWYxnFWhGlRypk7Rrupe7rKGpx8/+rLlg8gIrUTq2BwB8UXAnG++shXbEw3KRBsmSyR21YdFKZuPSS006qG9Cpy4+itXaEN81AkEWukGoZ9DHNBYoBTGAVAMZtIB27QMbqManI++ns+UrJZk/InWlXmr8AbdWVwI0yp38GkvAMoro9ROgd97FqQVKJOopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEQYATzPTItmwdcgoaAcYsBYBgsaSVJA6EtMeUWLEmg=;
 b=bq833tPaj3IcnA9Zn9Zif2gRNzf2fxElugVT1ApOf/ARw0hJZ7n7Jdu0B/UhMQXvcRYLOr5XZhhB7UHhwBpcY7ei/0EZmLVR1orFt20aJ8Q5Me3tNIkAUie4AIkWsAVWvWy/6sMOC53BViGKI/yZCgisMgU4yNfQK2W4xxHH4Ie06A2ldqRUyJ0y1ESFEhIokX3qT3CcbxmQJzc5977RfMhIQ4rjuZcFDrrXMMpzgWYoE5KHgtjUPdWv1A8gcUyw6+Ng3SWsmfmIpesR2Y0ABSYJDk0P8KTpcieWQSQeLG3NUDnieZDphFXAVZx6twhK5cJ1fPAHtIgTV3HQY8FwYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEQYATzPTItmwdcgoaAcYsBYBgsaSVJA6EtMeUWLEmg=;
 b=ulDD94iYNUTjd1wNET06ZeSRl79N2v14glBRp8FctEWTCO2yY99iEmxEUybzhB0avropjh63vnhnHCddMizdf4MCDOUtfTcqW7FQPe7IyVdZOGv5vZYSB0szf0PJhijG2MGaj063QT53m8YVZ0Wglb+2BCcp+hQJA/qckCYVywA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 16:04:39 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 16:04:38 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/10] drm/amdgpu: get owner ref in validate and map
Date: Mon, 21 Jun 2021 11:04:17 -0500
Message-Id: <20210621160423.3517-4-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621160423.3517-1-alex.sierra@amd.com>
References: <20210621160423.3517-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SA9PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:806:21::28) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SA9PR13CA0023.namprd13.prod.outlook.com (2603:10b6:806:21::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.7 via Frontend Transport; Mon, 21 Jun 2021 16:04:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c1b3690-a756-45a2-f009-08d934ce45c4
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:
X-Microsoft-Antispam-PRVS: <SN1PR12MB24476E17EABC679627B1DC34FD0A9@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GUqpGxhX2c9uLw09P/9cvEYFG+NUbSSxL3TacO4Y6gx15qwhod7SISSMUlGUbSgw8hXEivjYWelgNh3mPFEY78AE8NWKsKkJepOSDLI3G7mEZZH1WUzEGfAvSGg9gyWsqce47KWabfz0lSC0EpoVyw2UFmbrAXK67smgThUDd9WfqNZ8CjjsO2Ealk0mcxbxHC2HMSpB3tUF3bv63B+ucXMzq0LUJlkpYVYGL2WcnkY6U57Hh+aHixw06Vm0SPrWLydd4SFtkiKypuRl7V9w5itYKjGSYztH5aX4XwLax0GIAv5DH0OtuWcMwN5sRF+I8TqaYXVc1vlaq+bC+3udQgqoSygtcS1Ke46LXvbhF+CjhuKUhx1GTq5GctBJt2W7PPtd9ndF86/FU1k/UDdiHtE3N3gCJxos4oml/lwTvxyp2ZLA+rT+0o0d2BdZxObXU1kDI8KA8ytphmNed6BsXp1Qud1N4Zsz2BiAhgpjfnOxvnJomAJewjxJjUw0upLXvD4h1EWP/wOKIOEzjEsvuBT/3DnvwOovLI+m6YiLRTwFh9LP5X1L2EpATSWPcaPK7KNGDHfA0V7GXy2Z38uaimy/ZJjpal9tsCobwG/Fl7hXqGGP8IdgIRMikeb72ZUUpNfnJWhYC9pCyDySYDDx0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(26005)(38100700002)(86362001)(38350700002)(36756003)(956004)(8936002)(2616005)(16526019)(8676002)(186003)(5660300002)(44832011)(15650500001)(83380400001)(66946007)(6666004)(6916009)(6486002)(498600001)(66476007)(66556008)(52116002)(7696005)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uiZLYxAbbGpkGz0QiVafHEbxiZ2F6niT45V/adRwrInAbnjI4apYKdT29XYu?=
 =?us-ascii?Q?lDITdYp7hqurA+w8OD0NxCrDtGJfV6mqXBg0pMXrABR38gjc3te17jRJ0bn3?=
 =?us-ascii?Q?gwLcotcr1XFgzkeT3teputxljVDbGakjyG7LIjOoOUfJJemqbmEbRLsbUn6/?=
 =?us-ascii?Q?v/AvdlhnMABwOCaPFvqPm8UKautsGuxCKCiCo6Q5S8DMIEsH6saQ6yTq/4rq?=
 =?us-ascii?Q?Ud3KAp0bhkTgqKfSoY1GZMALTWXXpuO6jTU8vPE3VqiyB2tS45N/7hkoFVVM?=
 =?us-ascii?Q?L5CBmYNDucfwrfvf3ZVUJ8JHzBKBqUybH/E76pL0kvhE9LZt3gLl/ZYES/PY?=
 =?us-ascii?Q?dxIO7i0ctRGZnrWuxPSqpm6vu1f7XPWxf+Etu2W69SA/RhM2Gxg24jBmkFYN?=
 =?us-ascii?Q?rdo/8c3w4bA7VvrR3EPYapQjZjioIHmThjLJebv2D4xcliv4202Umk567kQs?=
 =?us-ascii?Q?Gyb44N+1T6efPoMWnruR42VQrvB8mXjkgRNP1dsAKmxMB/w/lJfUEgwXRKq1?=
 =?us-ascii?Q?/mmv3siy2v/+Pgi9IfS7SnCIfY0ggiSF6UFPISCSE0lQSZyEHuYa5jLkiUKs?=
 =?us-ascii?Q?LSTcZk2EntLslaiabF3XzLKlGN5ic/0lRFGvwGoxPj54aE5CKnzJhjhqnV8c?=
 =?us-ascii?Q?m7XB8JiNlnKoig9kzzz/FlIqEmsJs0DV66WgwReklJkeuQ6k6gyCqP2rDUIL?=
 =?us-ascii?Q?Ao0wSN/3B6qIyI1rLbxPg2u4hIipFCNoXE3Q9bvxGyRMMvym+jzR9+fWt0NG?=
 =?us-ascii?Q?PTk22X/WZaVhGtQZE9L3WwqdaI+onScVileWSwpwgakUMFGnaxkloPpv9WYQ?=
 =?us-ascii?Q?6TWhFDYrXDNx7roFW6I+WTkTKduFIO+nwXy5CF4lmIAN/9CHuL9wQvfXlGwq?=
 =?us-ascii?Q?ong/rPYaX53Pajff3dPBY1lrmDMSdDNB494Wxqd9QzteH8dFEdvN7oPmtQUE?=
 =?us-ascii?Q?FP1XTUHeGX2XzFx6TsT4bo55GGnLifK94PpYDV0wqmEnqodnyOXOuE4UuBIH?=
 =?us-ascii?Q?qVpDQ5Nvn775wE+uuXEP0cJKh9u5yvS9p19vR2Dtk7LnwDyaEtMvDV5q9Fta?=
 =?us-ascii?Q?NDxMLzkqRNeLIsHurrwq1L0EC6cOOcJERD9GtZbAyPU9i8p82H6IGLmJ9n+d?=
 =?us-ascii?Q?jSq7L7pN2IbDZNa1TwwTANWwsZFR1vherdLCrE7XXSPgeTtSDT/wVXn7sopR?=
 =?us-ascii?Q?8x7ASOv1XhxwrpceYrIUH0dSeDKc3uhxZNmprP+xPWq2o/yXfrrDiyhzhOVS?=
 =?us-ascii?Q?m4DFMI7IfRtBMd6Sy1RXUivRsEH2JMr84mBCdlKU1Q7Wgk1OlAq2uPm7Gkq9?=
 =?us-ascii?Q?mS1TCpVeYo3io18Eam3C46Nh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1b3690-a756-45a2-f009-08d934ce45c4
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 16:04:38.9461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Pr9sXnWCFupHsEr6Qaksrz7sbvLmzW5HAgoavfmuQnUxXlOyOMxqVvcFBzCEmykmYDZE0DaaJIcyzHrz2S8sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Get the proper owner reference for amdgpu_hmm_range_get_pages function.
This is useful for partial migrations. To avoid migrating back to
system memory, VRAM pages, that are accessible by all devices in the
same memory domain.
Ex. multiple devices in the same hive.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 54f47b09b14a..2b4318646a75 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1313,6 +1313,17 @@ static void svm_range_unreserve_bos(struct svm_validate_context *ctx)
 	ttm_eu_backoff_reservation(&ctx->ticket, &ctx->validate_list);
 }
 
+static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
+{
+	struct kfd_process_device *pdd;
+	struct amdgpu_device *adev;
+
+	pdd = kfd_process_device_from_gpuidx(p, gpuidx);
+	adev = (struct amdgpu_device *)pdd->dev->kgd;
+
+	return SVM_ADEV_PGMAP_OWNER(adev);
+}
+
 /*
  * Validation+GPU mapping with concurrent invalidation (MMU notifiers)
  *
@@ -1343,6 +1354,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 {
 	struct svm_validate_context ctx;
 	struct hmm_range *hmm_range;
+	struct kfd_process *p;
+	void *owner;
+	int32_t idx;
 	int r = 0;
 
 	ctx.process = container_of(prange->svms, struct kfd_process, svms);
@@ -1389,10 +1403,19 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	svm_range_reserve_bos(&ctx);
 
 	if (!prange->actual_loc) {
+		p = container_of(prange->svms, struct kfd_process, svms);
+		owner = kfd_svm_page_owner(p, find_first_bit(ctx.bitmap,
+							MAX_GPU_INSTANCE));
+		for_each_set_bit(idx, ctx.bitmap, MAX_GPU_INSTANCE) {
+			if (kfd_svm_page_owner(p, idx) != owner) {
+				owner = NULL;
+				break;
+			}
+		}
 		r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
 					       prange->start << PAGE_SHIFT,
 					       prange->npages, &hmm_range,
-					       false, true, NULL);
+					       false, true, owner);
 		if (r) {
 			pr_debug("failed %d to get svm range pages\n", r);
 			goto unreserve_out;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
