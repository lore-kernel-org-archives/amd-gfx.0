Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADA9C4BA21
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 21:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEC92072D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 21:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="quc/d0Zy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEC92072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B20E89F73;
	Wed, 26 Feb 2020 21:31:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B49A89F73
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 21:31:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqCFTSPXOUP57pZgvSXIfMyFeDBqydhcvIov0Nq+06L1BOzfCgWz0xhtzbCWP5Nc6OCqGu+iY0yFkm0nn5Xq21dmG2hrIXUe0/Ub3bA5pB0ixO0SoAP92buuxDgiYMj+o1zNnba4BIVF0JQRilixCjy8x7OlV+5x35Kz1OSHns/NegfU+Y2fFZ/X/IljmDigvN9axF2kPo2D8jgNySfjnTkhTllORl+oHwRtDS+QshJk2/wgFJe59Iyn/mWNEe5x+kjYTqn8MbfivS7J53xhZOcN7jVHmDRWAOAYpUQFMu9FrsDiBvS8YEH4EUvJ4nG6Jc3ETRWUPB+sNQR0FwwnpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9y5pXfbdxuAlWvOooxO4TxVtB8CR0qlHeq+aHXxSWLE=;
 b=FVCxyPkZiyGDlpGnNaLlEmVOItSDIrcZPSKSFSUQOI0K6MDLO5a2v0A/C2WEx3fLIjuabcgKantNNPLSONVl8MbpmQfUusYHiINRGg/JVziVT08pck+LsT9p+cwCDNKvCcZ7NXllbijmMfPEyjI06DklcmUNeno3gWM1PB8FfKitfZtbJlz3DN8EyjeMr2sbucbEI9hdLRmJNRD46YHcOvkDLZmvpg2NY4a9oSQhEKoTqQXIFzFSFq8HQUnXOsET84DlBjz7IHWvFI9UqFkUm2zK2RQlqnqQYBFq/C7NHQJIpF0FjQwcDS6y6mnPk+mYlfJmkUGr3T/NXFmbet43jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9y5pXfbdxuAlWvOooxO4TxVtB8CR0qlHeq+aHXxSWLE=;
 b=quc/d0ZywL095geJpttDHqlOQnp4VwmXzA1epEH4y2BxKw/A/4JFd+zIpVEAjI6Yv8GLz+EDxezUfQasbz5NMq7QLSs1zQS6/gT/ard/6z8rIPDcq/n5UwLJhw3tc8s2d8DD1ECn0UF1I5GSPeAqCZnqmhknT0QZjXQdgpBfdAQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2SPR01MB0010.namprd12.prod.outlook.com (2603:10b6:610:35::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 26 Feb
 2020 21:31:44 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 21:31:44 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Add more comments on GFX9 user CP queue MQD
 workaround
Date: Wed, 26 Feb 2020 16:31:31 -0500
Message-Id: <20200226213131.6880-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::29) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yong-dev.amd.com (165.204.55.251) by
 YTOPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Wed, 26 Feb 2020 21:31:44 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86e46b1c-8774-45c5-792c-08d7bb0346bb
X-MS-TrafficTypeDiagnostic: CH2SPR01MB0010:|CH2SPR01MB0010:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2SPR01MB001099491FF05F49B06B8F3FF0EA0@CH2SPR01MB0010.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(16526019)(26005)(86362001)(2616005)(6486002)(956004)(5660300002)(66556008)(66946007)(66476007)(186003)(4326008)(498600001)(6916009)(2906002)(6666004)(1076003)(36756003)(81166006)(81156014)(8936002)(7696005)(52116002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2SPR01MB0010;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KGyueyH1ikP5518B7LiRkmbu+jYdUV7uXciyPyLQuObKJ9duLOf7QioquN5B10B5KvQGLPeLvAoRdPsE8pcTmgVjRaChC8IVsPwXQjMVxV2OwlLebqgCi+78yQ+3BKALIwn1SkkZM7gyanJoXNulrJKrbKKjTqteMc3e18YMjL1IScZVxaPeKBsIL78HKpqHFqQ4TG83QTYNGmNatWzYnYuJizTQ+J2gncw72iMv6l0PgvSCSbdBQrdHMV6//Sc2qYxyy+mA3Jb2G2n/xuzb/paCEc2CTZAG44YM7Q8OzgCtigY1WRy3sslm11Lxa9uk/cWkNmExM+xrg7JDMLfA6WzEYgqZRl2IhmTNFfoq2/E5OxS+69gwmeA3Ypw18X9RC/+XM4Chc807l6p1yX5tfgAGaWnQeHPKPvW5qKg+G3kywJK/7kqy/X9IXNTjqZd9
X-MS-Exchange-AntiSpam-MessageData: DWr82uEu9zlEQzB8ByeP8owoqrx6BXgwMGbZz+j41DPr2wMx6rBk11ZJyz/p10p7CEWy8alkiwOmrU//ARFDTlhM4r89zsrzKLSambjrV4r7RJzz24haDUNRnPUBccN8rjoi4L0YxcmAxuv34a6xbA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e46b1c-8774-45c5-792c-08d7bb0346bb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 21:31:44.4000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: duHNCYbOL8CNzDtb6I4KGqEtvN9bcV8VFlwyWIqFI4x/pkpL5S5PPQs2i1suLUBo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2SPR01MB0010
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

Because two many things are involved in this workaround, we need more
comments to avoid pitfalls.

Change-Id: I5d7917296dd5f5edb45921118cf8e7d778d40de1
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c         |  5 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 16 +++++++++++++---
 2 files changed, 17 insertions(+), 4 deletions(-)

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
index 436b7f518979..06a3d9ead510 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -87,9 +87,19 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_dev *kfd,
 	int retval;
 	struct kfd_mem_obj *mqd_mem_obj = NULL;
 
-	/* From V9,  for CWSR, the control stack is located on the next page
-	 * boundary after the mqd, we will use the gtt allocation function
-	 * instead of sub-allocation function.
+	/* For V9 only, due to a HW bug, the control stack of user mode
+	 * compute queues needs to be allocated just behind the page boundary
+	 * of its MQD buffer. So we allocate a enlarged MQD buffer: the first
+	 * page of which serves as the regular MQD buffer purpose. Although
+	 * the two parts are in the same buffer object, they need different
+	 * memory type: MQD part needs UC (uncached) as usual, while control
+	 * stack needs NC (non coherent).
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
