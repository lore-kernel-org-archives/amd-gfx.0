Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC3AC11F68
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:03:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB5FB61DD7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5FB61DD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 462106E8E2;
	Tue, 29 Jun 2021 18:03:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C4226E8DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 18:02:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mj/VbKIGRSIdbcH3pUcFokLTcC5sJ79Ud92XgeHbRQJjVQT3UAJssVf29vrw1pJBFcoeu55UhzKWg5AzqSuzdhlZdMWkAJiuvi18wV1VHuGktOf7lFz6Qw4N5n/BvCF7mq3zNeWDSTKVJK+obFmqdJe7DG4VlybrQvq7P/Jm4hhTHKqRD/hCZRl4F5z6kSQjnqiOcBXQmPRCpp7hHA9/qObyOyOrEYdyKNT91+bvs8+/dqgTzTnLOsrI358FRbM6DoId20CFBwj+N+vZEqxZqn/YLpfyver6kCNcRfVOU/QD7Jh6TAzZ1ioek3Vt7bYRT0j/0ZrgnYylprSsTFlPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI5vKBnaYBKinafkyVynkIk3K5WdRdUZCA1KD61ZI28=;
 b=iCUmmKmpkH2kZjwJ1linbHkY5EJ5A5Y5WoWopm6AHzqQr4isbyQWjSjCn5Rligc8T6Z4OaLGfrDp9jbzBnAOU5IYmt3aJeS1S1Q9sEdatgNMuEALeO5bu6zb2xGHess61i8GCAvI8nzmWFqKtS2Neaw33myOe2pjEw2sSlvcPpVR3KcbxpISwte3UxiKGN8WixhVs9TQ9rQP8ZiHPO3WklYllw56ZvVenX055vjCgivhaNMoCfQHY5sUgFdFCTLnlDxhiaYTjwdD6e/YhlxsZnArhQpix0m48MeDuGYOzIvI5cy99D/N195X4jDNa8SsdOe1OO9m7DmzOG6HhS3rDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI5vKBnaYBKinafkyVynkIk3K5WdRdUZCA1KD61ZI28=;
 b=vUo/44s+9rxVjX1eRHz1aV/zdkJxbwTQcqsMbR9ULlI7FNcVKlmO/lnjyvJKKgfKw8bTIKUFnfySDIrfxPGIvxq6cJOND8ZxaL9jOboXzWalUTWTzIK5rGirlI98KMiOblNxUsCSuJzLV2dK8DXDwRjY2CLdFVit1XKaGqewndQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 18:02:58 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 18:02:58 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/11] drm/amdkfd: inc counter on child ranges with xnack off
Date: Tue, 29 Jun 2021 13:02:06 -0500
Message-Id: <20210629180206.8002-11-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629180206.8002-1-alex.sierra@amd.com>
References: <20210629180206.8002-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::27) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 18:02:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82144023-0333-48f6-000b-08d93b282095
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25426E729C59179B34A834F1FD029@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbXV9n1yLyFWykjQPJg4RYMpOfvQn+DlL/wL+QDA8K8ijD+AGjVo/OgTyJCK0azyASS0kRzEnNe7DuN0uD+TxIXCNwQgIlevcGOnKOFD5h46GzjB7WUR3JDBy2Kp3JWqPTnFX6qybGeWd9RyRcTgSDbrFhduo+qG8CXVSq3k2XLUy+X8gAEmkp9NZz9xaryWEDAcZ+BbmLpTQuof4aVuqt3wDvAxfB2FII/V012wD+gbguyiRmaVgJu53v4sWrVzgWPEb8B81uvCVMUrRdtyO2gB2+ljFLcQbtkkatKteTuk5mBLBk9XPvv1e9oFiQs9zjOGxeM8sEoKQWwJNYn+4hGA4bV1tl0XCLPDxbxgIX2EU35a7Kbbfoke6yoEhOeGW56rs+kTw0EixcDm4UTsLA73aR4E3f8IMPxC0c9njoexoXS1EqHlsJ1J30YOGF4LeRINEBq+dgrfisnrHFut+iyjA8ta55QG6I8jVuDzZhdYxwGsKNedaFOXPa3NI1SVuDOB9HM91yC5z6JOQEDo4uTmEab39Pg9ERG8+R6hKXdtMSYXbmj7xqhCufNWU1ki19oCllDFFQg4QzBUhVwpczRu5LyvmvEbFvCJKqj9nutlr64Az4ZQs7S5Zarv09cJE1zGf0phP3RIkD9LqRNDnn2tpybfULMEVIAAzw6V2io3yuc1+UHZkV1UIByB9KwKaX/q2uKERM5Iqup3gF0RRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(38100700002)(2616005)(86362001)(52116002)(186003)(4326008)(44832011)(6666004)(6916009)(7696005)(956004)(8936002)(16526019)(8676002)(38350700002)(1076003)(26005)(36756003)(6486002)(66556008)(66476007)(66946007)(2906002)(83380400001)(5660300002)(316002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nx0KNgqKZDDYDSAU4WVAkZLrnHEUBYhxMhPw2cRvv6LfJX1V0CK/iMKDO9bW?=
 =?us-ascii?Q?Pxr8HsfKH0N0iqJrOhwzLYteMMqT2hMEgPoj6LOF2DDEsF7BIX4SWa7NYP+I?=
 =?us-ascii?Q?kn5X94vnAIAQVKJX8Q4U7Hh/WxbGas8FcbcXJL4uAS+r/CTVOCzu/5f7CW/x?=
 =?us-ascii?Q?VkmaAKvcK1Z4onlufVsamZ3vDmDYMAAQ6v+WSq6NQGOTZ6BfHJzCMtQCELNj?=
 =?us-ascii?Q?l6FYlXeZUOTEMPGcJ6KbXsSu7MzM2jRs19GOyj6sBKXT+NZquyQzTTwdMkI/?=
 =?us-ascii?Q?XFYEO5sMbHytJYO3Q1b+RKkn9CxlyVg6whAcpRr8ni/zrBnbmAVgDsdVT/oj?=
 =?us-ascii?Q?DKsTKdpfX76kpFKtqzUlSz7YcBzOUY7u//ASsMqx22oGw6XPEt+O4zJT+xef?=
 =?us-ascii?Q?NKfxlI+oJnnmfkbgpSmXTfqSPY6fhH5AhkZtOXiIAEiCxS+YFnaZ4gaxfMgO?=
 =?us-ascii?Q?7/6/d3lAAYHvrSegtAjMz/Mm1VroxItl5eYH6WeGn9cLJazsBBi72nTWla+e?=
 =?us-ascii?Q?vBaHmyq2LFjHVIfZbTJb84mSd/c6jY9VApByh05Immsj6F1pe6EY6C//4paD?=
 =?us-ascii?Q?dgQtkYz/E5L+98PzNPvzX+pL9tB/IoWelyQmEpImPuyk9Yob3+6ajrsQhw/H?=
 =?us-ascii?Q?+LlRa5KA4D/HJBRyY6WnlXxG8fYuFQg0quF6ZL2uV/zQL1Jh1sJI/dBOgfE+?=
 =?us-ascii?Q?qXQ4Zwc2GB0lEiuOvUgI5v8bDWLHq55tQ6bO+XB50hVeWkCjT2jlmLge15Dk?=
 =?us-ascii?Q?4XvCpWVKmy3Wt7UvCglHm91Rk7eqcrH3z7t/brL8F+QdyQ6GGNWB0wveGjxi?=
 =?us-ascii?Q?E54vR+0pl1SgzHTZAC47m5ew6Tn9F8Knrowgv3t6pGHcZXM3AOVdfENY2BOv?=
 =?us-ascii?Q?CKlF5SvnaH0nqpXdwqPHKCKLhtkRMw8SOkSiKpyBiv3iNKrIRmvqvyH0Vwiu?=
 =?us-ascii?Q?Zf597cFE3U6HN1vCH5Xe/sDDWTfIVd2uowC5cLoPS4kDapDb6RR5Vtet4wLD?=
 =?us-ascii?Q?SOKqFul3L3kwT4TTXiHDKWe6YcAFEQFUNq/hPFTkQvQrZMjFmr80nwZR95rQ?=
 =?us-ascii?Q?dI1buAZH4PM20FrxZWjM/L1EnPySM+ScJMUp+BCcf0EDHEcMH9D9garVNw+l?=
 =?us-ascii?Q?rMiOHozcE8t+A5l29iqSu3ETEzsKTnTTIJJslnN58DWB2dtiIgsZyp7C61HU?=
 =?us-ascii?Q?LNGrEOLEIy5oe60VwlqB6lCjFH54aTnzgSoYkzhFIUSqVJgT/9yu0GPwqLwT?=
 =?us-ascii?Q?fWBLbkfgTvDXXIDnTNe4+bztROfNEcg1uXcqfCBMgSPrqz2EUx0kyS1C8wGi?=
 =?us-ascii?Q?TfCZtb8cU5O5Lcohw4Rplv9F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82144023-0333-48f6-000b-08d93b282095
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 18:02:58.2844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dvV2SPgnLsPSx0x5Xiay4qXutxOIzyvEwaRGm+LIO8ZVx+pRp/BNai/wayGh3az7Gy6RcJJrxdEvr4g79kt/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2542
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During GPU page table invalidation with xnack off, new ranges
split may occur concurrently in the same prange. Creating a new
child per split. Each child should also increment its
invalid counter, to assure GPU page table updates in these
ranges.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 294c9480a184..67605e4bc3c6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1622,6 +1622,7 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 		unsigned long start, unsigned long last)
 {
 	struct svm_range_list *svms = prange->svms;
+	struct svm_range *pchild;
 	struct kfd_process *p;
 	int r = 0;
 
@@ -1633,6 +1634,12 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 	if (!p->xnack_enabled) {
 		int evicted_ranges;
 
+		list_for_each_entry(pchild, &prange->child_list, child_list) {
+			mutex_lock_nested(&pchild->lock, 1);
+			atomic_inc(&pchild->invalid);
+			mutex_unlock(&pchild->lock);
+		}
+
 		atomic_inc(&prange->invalid);
 		evicted_ranges = atomic_inc_return(&svms->evicted_ranges);
 		if (evicted_ranges != 1)
@@ -1650,7 +1657,6 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 		schedule_delayed_work(&svms->restore_work,
 			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
 	} else {
-		struct svm_range *pchild;
 		unsigned long s, l;
 
 		pr_debug("invalidate unmap svms 0x%p [0x%lx 0x%lx] from GPUs\n",
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
