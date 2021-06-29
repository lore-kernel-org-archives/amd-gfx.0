Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A9FC11F67
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 21:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7DE61D81
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 21:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7DE61D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 938726E8F8;
	Tue, 29 Jun 2021 21:02:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EBC86E8F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 21:02:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9ty/cx/WvloQEiKtjpqe3fvnsyGQa7voviy63F1fXcw3Fs7sjhd3/sJTvMetA9/RP7aEoUW8ZqMHGdiidmm/PJuckQUlNBcYcIVGOTkvzh0j04IFdEak+D2ckwhCkADfzrso22oV8UsmJJj8nC5VvXxLxdVNnUwb4FOCcPWC0U/0Gj6PqxT13pF8XJNg9HQ8ne1bZ8zRnLhsn2u/GIpFRzMDq0/cLsUIbYBYuHAonvDBOKERZX2hjaoaJUvDHYGrOE/WQP/Ibq7uFVyvHT9Zdfi/C2Mj/nKOxRX4NLQokftQtHTNAJ+AmhHWlOFvT3+SaSiq8mvgD3PTLGQJE3BbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeGUZrYFwKpgEjWjlDof1hD0sm9dF7O0f+UN6DQORcg=;
 b=CVVLeAWJmmAyFZ3QUtqdRXOjqZk5AyhAJ0CDWYXqXNe1dDToBHP38ducs7X3EtZnrLL9cjWGYKYhiSBtZ65KYdNoRrKGTHRRzD4aTHgN6EYd9x6VDcShJH5DTNC1hgs/v/Vqs1q/8wCDGKQK0QhYYCjGNq0LB+fvKhBkFkW+LRB0QYnNB5YPqo6IU1AXcZxloEzUCn5Ev6mYlWn4eZ/OVSwakC4ceWVXGNjbknrU05hCcfVFOgpudnGqDeW4UmW4yL71eQCaGVw7LXNoTFUP1gHOZWW9ZjVxbCK/jlZwxm74quNmLsPEBBsI7eg8/JiHTqq2ITsm8tm1FnT0lYdW4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeGUZrYFwKpgEjWjlDof1hD0sm9dF7O0f+UN6DQORcg=;
 b=kwypHwqcxJNOFd467eQ8RSaF/IMKqdaUvie5hJRcDL2+KF5ByTSA6uOzMfCf1AyDM9uvDizO5Me4hUcEAR9c0V6MdnIdFGVRO544ZnX+1r1LXGYGOQS//5sHLZol9u5aNENS8jplNx4Mjtf6Rkkt/VG56BtrpPC5crLjQi3DypM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 21:02:42 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%7]) with mapi id 15.20.4287.022; Tue, 29 Jun 2021
 21:02:42 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: drop unused variable
Date: Tue, 29 Jun 2021 17:02:28 -0400
Message-Id: <20210629210228.362806-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL1PR13CA0244.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::9) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0244.namprd13.prod.outlook.com (2603:10b6:208:2ba::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.8 via Frontend Transport; Tue, 29 Jun 2021 21:02:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbefa369-3897-406e-e3ad-08d93b413c75
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5176FD29BFFF0B89C9054B9BF7029@BL1PR12MB5176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DINqEjy8zIe/OXVtZTxDwekpLK88Sj0U63tRG3RbBIhtyICe9eK0R/gVCQeHNffD8U9VB2USviAWLJr91Gm3pTn3r8lBzKinfAOKrxe/qbHyFH3HrawuuJZNNDkMmqVocpY3TFcWAaId42VYfv/JnqoCM0cz1MYgz96d8xTRHO3ExC3KQH8kEFURLCqFEkoG4PjmEk1/zuVffkHdDv5c9m/lOGJ31FuqCNRQIbcCDEfl2M+0u+tFkHqP5xNSD2859jGKDDKLTNmbmtE26mK/BWWeeP875GS5xA0ljiDkwazTNjLDkhkr9n99yrvZp4UQrxVxxOKynU9o9f4ywW7uZC9RD7oSc9IyTU6XK11xlWa1Ta9mXjx1BilOws4JolznXf6pIAjEYu/UbxYyJzBoAuuExbobhu2ILDpBfN3EDwxPxavKoBD95fjkOBly96fcJ2yYPgOjA3Kszvtr1QhHj50H+s2y154EeajA1c0jHeKyrQvs13wOGsICZCTZvhrVnCTbNJ2i42euSIOYkDVURE1oF1MSN+q7d1iqXCf9fpxqwQjauWi8sRCR0RgEf8khvxLbUr4wnDT7aRe8SkFn4gTNAlXiSS+iOylC0rMDF5/gcqgX+4lhOib+bH/kPdcdpuGMAm+gOnZESi26mC7yeV7EalNYN09HPiCv2hO75hkrd/m8z7+wemHeBQRJHIzGqS/Fwc3CE0UmKoCzxqMA2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(2906002)(7696005)(186003)(66946007)(83380400001)(16526019)(52116002)(26005)(6666004)(8936002)(66476007)(66556008)(1076003)(6916009)(38350700002)(5660300002)(38100700002)(36756003)(316002)(6486002)(2616005)(956004)(4326008)(478600001)(8676002)(86362001)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OmsKF5BRM6mC5Hx5wEA+p4r0MLKCHlW21llQ0HtNrQgiZYSh5XBuGG5J3gQX?=
 =?us-ascii?Q?8tPVcUQ63QyY9F4HCHPhsbRQAxTvVrYnxs5cndkYOuXjZdMxRDE5R48SIvoo?=
 =?us-ascii?Q?ZYbCGRUu4K2q4m3t5IQzsFn9u7JzlQLceANd6sypbZLyuQDOT6TFRs6S39mJ?=
 =?us-ascii?Q?ohrSR9+DwbTwQXvuz18v7/ZerEiy5Ssw4CN0wZUz6JsFiojtl67V8jjkoRgF?=
 =?us-ascii?Q?sBImvlmJd4hoUs0wnJUPLjWYRTCoBVm/QpaDj/wFkBbym8ZzlKNfV6bYftpL?=
 =?us-ascii?Q?jVsVkTDyiU2Rg22zeI09N/2qIdlfjbbTnx2NEsu5CDVilfL+3SgurJ/UHepQ?=
 =?us-ascii?Q?oXKAei5LuEbBHk+JiXEQc71Oc2j6Mf7FGcH44BwakaG7/ob92yyFU0yrXejr?=
 =?us-ascii?Q?g1Wc+d0yoncPMnSBm+Aq1KtL0AzVXe+dgx8yKITt4QLuyvdkmFxpwIqF18zb?=
 =?us-ascii?Q?Hj+O/x+P7Fm9XpRpcM0Wgtjs1v5H7t+22BhAxkBMpCbsFhjXUU7cnJFehC4A?=
 =?us-ascii?Q?t//nY7cVeoi9DwqgVMCFj3hzweMjDFIUiNBx1fGNwL1wVv1gakxecHPpojqw?=
 =?us-ascii?Q?P9BnP+yoSKj10L9g1trjBou6OKdZyr6h2qdwSLtCCz1TtxeAbESRUiIyUgY4?=
 =?us-ascii?Q?DoRHWsVtaJBwvQcWuZDbQGDeKvZwt+mdoNeMSydlGTGIRfe3cYwCfuxNsRII?=
 =?us-ascii?Q?TLV01llFoqTcUUHrcrx6yiTK9sjKD6EBIMmJQqpYmVnu1p7SMJzyFFKwRAGl?=
 =?us-ascii?Q?+Knr+FrhXzHt6lw+XWUw4K3KE74T299tqxKpmuuoLWp27Jh29plB+Snuet+s?=
 =?us-ascii?Q?xOFVOKz50HPgW3KoPVGArrv/zizrdA+C5QG4YhH4uxk62Q5HY8O6o0v4qlcv?=
 =?us-ascii?Q?r8z/UQofBaOvsNwfycmqjiNDnqJehefGtvrAuELUFe7oY8xPEmxD5daMo9re?=
 =?us-ascii?Q?R6PaCH5//ERcHtvXCVIJU23r165tsKSUh53By3/mMqjEdtXMRdd295Rnttcx?=
 =?us-ascii?Q?f7ocI8yiegXQY+UMh0tjByGuGI1wCVb5reBoKF9orrhESno2wzK6ezROkVJa?=
 =?us-ascii?Q?GgU46HW7EgcHwrYSTbl3/h+6pmaGFPvDGRvOfSTZgOMqjg34ROlJlt+1DGWN?=
 =?us-ascii?Q?5oqPYlqNwNJv50c4W54Qbb4DqIPwzRX8iXZ2beiSes2DnwYqLhEPyvn+yzLj?=
 =?us-ascii?Q?KF3m1zi0otncWcS2cAaJI1Ypb7RC9k1LuD8q8fc1zVjATg1d56KjsN6cJzD5?=
 =?us-ascii?Q?650l1ENEgOdbBYUkKC3s5Qwaske/RKYAWCZwes7EqwJ+j4iopeHhgc+V6tbp?=
 =?us-ascii?Q?JCirSVS3Mw6czMruPtaacXhj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbefa369-3897-406e-e3ad-08d93b413c75
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 21:02:42.5367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmjuKKpNadt9UTmcvxvdMpgK5fXNACywBz5Q8j7rWrQulwWqQ3rPwnyJU4PtfmPfV4kdwjBWeF/COJ+nu2XSVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5176
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove unused variable.

Fixes: 00858131205f69 ("Revert "drm/amd/display: Fix overlay validation by considering cursors"")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f14b5468b7ee..e034017daa1a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10221,7 +10221,7 @@ static int validate_overlay(struct drm_atomic_state *state)
 {
 	int i;
 	struct drm_plane *plane;
-	struct drm_plane_state *old_plane_state, *new_plane_state;
+	struct drm_plane_state *new_plane_state;
 	struct drm_plane_state *primary_state, *overlay_state = NULL;
 
 	/* Check if primary plane is contained inside overlay */
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
