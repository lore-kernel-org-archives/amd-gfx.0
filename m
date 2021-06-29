Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB06BC11F67
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 21:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6355C61C8D
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 21:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6355C61C8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E0A989BC0;
	Tue, 29 Jun 2021 21:48:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94BED89BC0
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 21:48:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hY1awt9Os7DmwbmDphgbOYfmXAhnFQOqyH0S9rR8MTg6LbEj9/O+G79+L2APSaiY6tXpwJHx9fAIN2osU9X92WcmjB+3Nd4mrYXQHDUzLDxpg02J88aRa34fmZSmiTtClG0HIpt8HipCAK1C5V/lxAaRKoCXtZQgjgjk9efiE/YyjT936Oz5NT6qN6/ZW4uL4OnV6F0wz2TXlI5aFLbD8uM1psMMytgThk7Y4cq5oYdFPkqd29IinRqXSXamBiugdZYw3SVSy4E9q2p1mY8B8rU9J5OqrIw9pqkjexQ/mV14+sVXP7gdlUj2+ZDhPjiHlD6XltgY942/uAeZLfUT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRx5PdrfpPfHrhnT/Fbl0bavKGdkI1lIFnlwClAiFCo=;
 b=nM0pzSpHyYD7zuuQKMerpQTK4zBOMJ2eT3e1Si1m0BvJ+mrfBdvXt963Tn56NPHKtE+GyJyauSwL28nNInHdK2XfrWLWx3XQohsr77+cmCSdJt60rou9cnEHdhNoBEIZLzPcTloPXDRyOe3JStWt+c7yMl+tNuywueLjm9c+DAi+3ydUnLfzZtNapevRtWsJ0ky5bWrG6xq3csG2G6uppqCpnbildL8HtbU4qqY9VoUxQmZLz/Rv2fzYpy0hM6OWWiRU3bIMWKZ5Bd7j4O7IphX/88CBZINdJFlqJj421QzwdcDXDkJaqD1aMOC+HCpdR8ZzUsMq78d7C0ox538jRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRx5PdrfpPfHrhnT/Fbl0bavKGdkI1lIFnlwClAiFCo=;
 b=5gsrXLxMqE3LJxSg+HoZ5Gok3L1iwWytkJMdkxjNPILbE9evxpU49mr/AaPE9oMCSzY78mcm1sq20qHsxcxn2lZ+wYt+kDAnwQR8qd9u/oJObwvOD4yYg1SGYDi4wUUTsUUnihot8kPaiyktMo+yNWJ9u6l54gY5MLv/lgXDS8Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SA0PR12MB4575.namprd12.prod.outlook.com (2603:10b6:806:73::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Tue, 29 Jun
 2021 21:48:43 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 21:48:43 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: inc counter on child ranges with xnack off
Date: Tue, 29 Jun 2021 16:48:28 -0500
Message-Id: <20210629214828.3847-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN7PR04CA0189.namprd04.prod.outlook.com
 (2603:10b6:806:126::14) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN7PR04CA0189.namprd04.prod.outlook.com (2603:10b6:806:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Tue, 29 Jun 2021 21:48:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b2aef0d-16a7-4881-8e91-08d93b47a9dc
X-MS-TrafficTypeDiagnostic: SA0PR12MB4575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4575161324BC06C9E3FFE7B3FD029@SA0PR12MB4575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FtSmYmJY0HmPRUllJsyKRw3Pm8DZAaIk+7deEJpjA4gFS0RtfdDBSIdpx78gtQdRT2lcEqSWnx+TIwlYOv88kXnM6+U1z83adkLcndvRoJDUEvbhP+By1emNzKIoATk9b7HvkmpTCgY5ibT4hqPbQDJhtgnrYuIIh92WIUZOs+fASi/LBq4w4ZeLVjLU2Z6NCbrr/e3Y+aSOlDa6X/jS6ahLYw9VQhB3EijZNM9sFiiNYFIoJUzK6ywYlNtnI93UkYq1DnvifJFSjbCyKUktLNlM50TiRpgqFk4b7n3dO0aSnaQDS5h/yXJ6ER86QgRv2e2NJo98zCWYb6ZGkR7iwm7Te6FQpw7Qe/diEtlcBZWwct9aF3CWqpSX9sAIsnQm8jFaUAfKSpuc5v2RbO/Ss2mmf1CL+5VgYR0jLGbBZNE81V43wwXR7WEDbuVxMrrSRCltVTRfyBhyyyJVnXv1AmHyH/26wildcCcJpw5ClAq44OsqhupS0ZwNPIGNZtbF1doJDC2AB5uCMZXidM9hel+IAnaEn7GOUJgt0YZiuaAEqM7rOMfBA3vy8+PhEp678mTBnA7PjkYWPV5O4fpJ4xL+hBsVqZ4rjAfHy7FtOqN6Vv09sXgZPFLkFYwcKQt4T6gPvsXV2Ki9ZopJHdrr4XhfTz3bEYG/WyE7q0DL8KOsqy1UmZKJXeYJVsB0q5A3yH/fShfFSfU+XZgYvhBZcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(66476007)(956004)(4326008)(66946007)(26005)(8676002)(7696005)(52116002)(66556008)(5660300002)(36756003)(8936002)(186003)(16526019)(6916009)(478600001)(6666004)(6486002)(38350700002)(38100700002)(44832011)(316002)(1076003)(2906002)(2616005)(86362001)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PvmKyY6jrEeDgt0OW9OOq9uo1k6O+KSDVgGv11T6fGHnWTp4oZqC1QkxAZ+C?=
 =?us-ascii?Q?pI/95HuCctW6GkXncy7e+e1HIiwFlQ5lLyDaC94FvhPrT0PCN/JK9M8/XXEJ?=
 =?us-ascii?Q?Ogp01J9oQzyeqe1Fgaz2j16DfZl3z11aNydnoJQe6eLLFzoaVsyOdDstYRfK?=
 =?us-ascii?Q?brv4P6N4YoBMILdmSiID9mkKs3U2aP2h52HFDYW2Edcxg8qL94T4biovOnA/?=
 =?us-ascii?Q?Vnw9iiGIUmzixbD4sYItI1/Te6LXm+hbCULnEOMGtk26/rmBB97vHTSTCGJi?=
 =?us-ascii?Q?MaQ/xTWYPgXkhqnEkKBL3SPbQGOeBpvy9WM5ZDh+qy99qmxS9gacADleMP0I?=
 =?us-ascii?Q?7zmjRJALI5tOx1vwihZnL3TTKNky29OgAN50NeNKZRmwUDJ2LIVTPkxCzhv3?=
 =?us-ascii?Q?hEiHb8aO3mIgNvjvoynQ6mD5uR8pyQqBfszIy+/2iyrYxZ+9TkkLBP5KZ+Gx?=
 =?us-ascii?Q?tdg9GyuANAUX5Fvi1oe943P7OF0gqJjnGCUElfkQgCMz0rOxNxfLZFLKeAVN?=
 =?us-ascii?Q?+t5N+LxF7YOMcMMsuTGwzrPTH3jv8N+KfbqxxaW0aT8cB5W8y6trwOS21UN7?=
 =?us-ascii?Q?7s1aZbLpH1OX7cWBJNMeOtQCSTmdMTbcoKCH9GnIQLIA5hhLBnFYcboxW2KL?=
 =?us-ascii?Q?QJIFVZ62vxgVilwIdKShwrR4HGZ30SW8fniyav+UCOUlzoyzLsSZULDFU+Yh?=
 =?us-ascii?Q?gCEfiA+p8Yuye4KpY/tOEGh3NNfLuBUP3fnOliTrlbwAPc8q4YX9qfXoG0Nu?=
 =?us-ascii?Q?vFmGMzJZX/jXTwZ2ilEIvlNiTfM1CkUElLbwC9N4cV1CEp80Z2iBkqGKVfAi?=
 =?us-ascii?Q?fGuKtHkXWjasSmBqiy/edbY54yF5yrZSX2VJ2qOKsyaiBwwAVq3E/o1+bNOQ?=
 =?us-ascii?Q?7ttSCyZyFgSt0AAKuAR0kVd9+rLzg8fp/3e9lom3dFR73ByxrFkKwh+YjvOZ?=
 =?us-ascii?Q?CUSKfkVduG9sd2keAJ+5F181HTn3ghTKbDLsl4NkPZOys66nqe2KU72Xofcm?=
 =?us-ascii?Q?7/Bj4brsokyanBtcNUgDmiJWdTRGCio8j7uOJ7+HuyNtOmjSsY8WF3lw/gse?=
 =?us-ascii?Q?D7Jq49nWDVvhf8qSuQ0r5HhXIicrFAXxF2H3wmr40Gkp31VWpSBh62UpXdVZ?=
 =?us-ascii?Q?NoLYX34QNwPw3nNh5/+/AYZ/bR1G+8M1af+U06BccYgs8drrJmQSA2odDkno?=
 =?us-ascii?Q?ZhYSVimiZ+aCUtVZv++sAa6pcCNLVBe9wm1/AvvPtH+YIvYT7+DyDQCqMPDS?=
 =?us-ascii?Q?xDcREh6PTu79MdWpeijBP9bitmEO/T/GSbNQg37sBgkakHpYQ2tabNgYQUMs?=
 =?us-ascii?Q?QvA8gDalK385mNmCRKfe4+8N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2aef0d-16a7-4881-8e91-08d93b47a9dc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 21:48:42.9978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CB2g00BcK9Mbn+TUzB+a7R+g3w+p2CGVhfRt7/QAvCHZoZgkqQEiii27K7wAc5PgETU8kakIb9/ros8Fuy8f5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4575
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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 00b46846a5e0..e3b4f684393e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1590,6 +1590,7 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 		unsigned long start, unsigned long last)
 {
 	struct svm_range_list *svms = prange->svms;
+	struct svm_range *pchild;
 	struct kfd_process *p;
 	int r = 0;
 
@@ -1601,7 +1602,19 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 	if (!p->xnack_enabled) {
 		int evicted_ranges;
 
-		atomic_inc(&prange->invalid);
+		list_for_each_entry(pchild, &prange->child_list, child_list) {
+			mutex_lock_nested(&pchild->lock, 1);
+			if (pchild->start <= last && pchild->last >= start) {
+				pr_debug("increment pchild invalid [0x%lx 0x%lx]\n",
+				pchild->start, pchild->last);
+				atomic_inc(&pchild->invalid);
+			}
+			mutex_unlock(&pchild->lock);
+		}
+
+		if (prange->start <= last && prange->last >= start)
+			atomic_inc(&prange->invalid);
+
 		evicted_ranges = atomic_inc_return(&svms->evicted_ranges);
 		if (evicted_ranges != 1)
 			return r;
@@ -1618,7 +1631,6 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
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
