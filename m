Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FC1C4BA24
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 21:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B572C21D7E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 21:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L1qWOmci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B572C21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6483A6E489;
	Wed, 26 Feb 2020 21:44:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC6C6E489
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 21:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETyOp8iidNtTmHwPlO5rs2VxYljDueR3Y/8umBTtIahLlADupf/GbnY97uk73z1DGtKnnbVnsarkCNpTI/r8g/mcBAi29FsMnhsx0aqlkMgIVqpp1pyo1X9/AtTh6F01GP0STdh5WQAw13urrUG2X349sOrbI+PggDGuFDEHLQ6qZzH0+l/V6cQjY+GJLykwWvZPyozeXR7i4lTNiSH0P/W2sd2RpdvfDMf/1QdcsevFudOZzFTxhoOOGBJ2xS0sOqk585xEeDcctnU78Uq/ZXtpz7bkJvl8v/O66bxyCpE7jJifgTA1z2OeNJPpE/9qqcrOx21D9oawPpmB0UM8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vheJSc223CxIWJ3ePq9rHJl95M89hc4VePlnndMTIHU=;
 b=DR7pv3VMnyfYbLooG4MrQlh2TIOUn1hFAK+m05WG5JKgzhY0bEeFg8Ol9MX4ywe0D3UIY7zZOFh5EE4UQjRCgay2yf+SWEqAMdBeSMG4ETxJ+sTxB+uW0CHho2us2Chc8f7u2z+N0yQsxKiyqWzuXjaYkyxSeeO7QOb0sSIDX5QV9dsOAKKOZh1Y/AIDa75TpX93FnuaoUTuoGfS25qNCV6n4vLyM3J7YirEWP2izmdFfo1A6c+snMt8vvJ2LXXkstIcSTj+UnfBXV6CTm5OAVR1ryAHhmQr3Eqot95F62owlvgoc1lfdkY5ON3Gyxl7hEBuJaofPeY/llPi2V7i0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vheJSc223CxIWJ3ePq9rHJl95M89hc4VePlnndMTIHU=;
 b=L1qWOmcitXwguAm0gqe8H/MwZ5PVtspYDupSMMCHlO5LO4/r/jNApOTZeYit517nnzazuvnVzbMA3NdHeT5XYkKVCkkhgpWpODHeuWPNkRI47HXsEe1Cs1QQp3cwU/lzdCdMskp82hBrp7FJTtsU3FxcMDTfryui1iWcPKWskoM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2PR12MB3670.namprd12.prod.outlook.com (2603:10b6:610:21::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Wed, 26 Feb
 2020 21:44:27 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 21:44:27 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Add more comments on GFX9 user CP queue MQD
 workaround
Date: Wed, 26 Feb 2020 16:44:16 -0500
Message-Id: <20200226214416.7694-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::16) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yong-dev.amd.com (165.204.55.251) by
 YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Wed, 26 Feb 2020 21:44:26 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 96276636-485f-49c0-9f87-08d7bb050d57
X-MS-TrafficTypeDiagnostic: CH2PR12MB3670:|CH2PR12MB3670:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3670F780B9FF0CC93425B412F0EA0@CH2PR12MB3670.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(199004)(189003)(2616005)(6666004)(52116002)(7696005)(956004)(81166006)(8676002)(8936002)(6486002)(186003)(6916009)(81156014)(66556008)(16526019)(26005)(66946007)(316002)(5660300002)(478600001)(1076003)(86362001)(36756003)(4326008)(2906002)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3670;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRDX9vhKz4JUNVZ4SdN0mFTJVXsZ5YNGCZkWOSjN1Wdn9Jwc25wxCgQc4aq94B1X/Z2SKcDDbbtRn+SVbwOu2yUgRckTicuzcOk/8jzAGPytGP06d3V6xD4bBKNGcvkX57CJiyLaLvG4zyR6CQZv5kU4jz5gx5ucLGJq/OLQJnix6Wc6xmoqB0PZB1i4o4TsFvJA/FYrJiKXND+JvU7LvE++x+ZoiLVcseo3a1JATWAOfH4CMaAGFPFDhXrLPAzg4nk6CbkGBoeh8a6cfLgIALaMsJTJOwvZf6lX/xTIdFFs1TEtDw78DuNbyH7nOBXG8PAe1Nh2vbhHzo4P6PcFWbJRE8GlH6rNtt6iDNBB5SfqsOd9tQAMSDxifVYsxaI3pUOk4VZkAqJ9xq4/BvrZLLgpEPfdHBGbWu2GRLQZbKkSISui+e+P0N7O6pBnVrPl
X-MS-Exchange-AntiSpam-MessageData: alOVxZ+OcjVrqfxJwJIvzeo3LQs9OaaGoo9CU37NdoblFSeuq+aQ/GnLxp6FEhe61KWleFPR1pzlChl+ebfAVLjN/ax9wt1ALxBE1OpFWKB51wUSGQF+K8CZh6ceXAEqF6nbLFValcKIrtKLJhhR/g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96276636-485f-49c0-9f87-08d7bb050d57
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 21:44:27.0940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzyHbXx0kILVKOr53WwdhDWHHsuB1GMMRhOuAJEmsauxCgRR1foj8erwrKEFkEeU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3670
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Because too many things are involved in this workaround, we need more
comments to avoid pitfalls.

Change-Id: I5d7917296dd5f5edb45921118cf8e7d778d40de1
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c         |  5 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 17 ++++++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 660867cf2597..a6c8e4cfc051 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1041,7 +1041,10 @@ int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
 		if (r)
 			goto gart_bind_fail;
 
-		/* Patch mtype of the second part BO */
+		/* The memory type of the first page defaults to UC. Now
+		 * modify the memory type to NC from the second page of
+		 * the BO onward.
+		 */
 		flags &= ~AMDGPU_PTE_MTYPE_VG10_MASK;
 		flags |= AMDGPU_PTE_MTYPE_VG10(AMDGPU_MTYPE_NC);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 436b7f518979..ff2e84872721 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -87,9 +87,20 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_dev *kfd,
 	int retval;
 	struct kfd_mem_obj *mqd_mem_obj = NULL;
 
-	/* From V9,  for CWSR, the control stack is located on the next page
-	 * boundary after the mqd, we will use the gtt allocation function
-	 * instead of sub-allocation function.
+	/* For V9 only, due to a HW bug, the control stack of a user mode
+	 * compute queue needs to be allocated just behind the page boundary
+	 * of its regular MQD buffer. So we allocate an enlarged MQD buffer:
+	 * the first page of the buffer serves as the regular MQD buffer
+	 * purpose and the remaining is for control stack. Although the two
+	 * parts are in the same buffer object, they need different memory
+	 * type: MQD part needs UC (uncached) as usual, while control stack
+	 * needs NC (non coherent).
+	 *
+	 * Because of all those, we use the gtt allocation function instead
+	 * of sub-allocation function for this enlarged MQD buffer. Moreover,
+	 * in order to achieve two memory types in a single buffer object, we
+	 * pass a special bo flag AMDGPU_GEM_CREATE_MQD_GFX9 to instruct
+	 * amdgpu memory functions to do so.
 	 */
 	if (kfd->cwsr_enabled && (q->type == KFD_QUEUE_TYPE_COMPUTE)) {
 		mqd_mem_obj = kzalloc(sizeof(struct kfd_mem_obj), GFP_KERNEL);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
