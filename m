Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97227C3F2D7
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 19:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8932166E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 19:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oZiJX5SI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8932166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0914A6EB63;
	Wed,  4 Mar 2020 19:41:07 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700062.outbound.protection.outlook.com [40.107.70.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE3936EB63
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 19:41:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGmnuuqN/YlcKjFXw8cJK0aanl5wTBfgklYkqWxPDsDnR1FpbkpOymfL0LxXjlSbADJbOmZpbEgUkyCPQ9NPq0Dk7ppUt8PcGcteaZPGx2bUhfZuNgi6ZR+zX96Tl1UzEX/1F5GNfTpVHd+62xmK2wo169JaaDmEVDjsBXuhj2hQzKDvj12s+hw978aYGkw+nJeSctYw8fm/J02dbqv+tGg/OeKrnvAGJhcFh40liFcsQsOxNEOHzEKYtTxZNEo0021GgoNsiWVyez9R9WkNuk5KQXWLvlfGIOwyVrnmfgFqMJqJXzV10zUklDZBP3fWb8DbkypW1WDRJFgS3yChMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bHPEjjMWO6LMcQ3R5KCIZ5baSvETrqH5Ocs0vcmFZI=;
 b=Qt+ir+j/dDri77ZRRZ7O4WzTaMBpIfk6KqmMdxS02t3A0T7boLXZ3zshFlQk4vUe3+5qMVoa9awu1l8Pwd0i22xvuZSFrewgqE68cbKNrPqiUM77hj9IlE7avoD/Vxte1o64/2EGbC+OMzRTAwxhQo8BK06/v7TUtqQ6l1D3se9cTVrfzAUV2LJqpnuOmOE3p9wcmcIOKomiZFlVnUtLrR3bYCY3XwDiVP3jjpvgwuvQQ4UzPnrbb1fhu/DAAmKhWf1IDyeFPHKa32Fmv1DpmbOTcAX+Ikp07CKpFoaadS54DBUSzlRn/YIwcXRqYUQWeubjheTSwcERA7RTfP28DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bHPEjjMWO6LMcQ3R5KCIZ5baSvETrqH5Ocs0vcmFZI=;
 b=oZiJX5SIJ3lOPm3xBDKEKPBc3CJ29WnNcgZ7zUQm2xWVM1GT4WgPzo60G4YhOzS5wCeOGegUpguFp4ah7EYK84mV16D9qFYT7Jx2ET16g7AabPlDg6WstdMJv46MkYnfusBs9KIsz8fSAuSZIZLzWd01rXnvKIVGhEt4Ld0zJs0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2PR12MB3672.namprd12.prod.outlook.com (2603:10b6:610:2d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 19:41:04 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::8c06:4379:c755:dfe4]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::8c06:4379:c755:dfe4%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 19:41:04 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Add more comments on GFX9 user CP queue MQD
 workaround
Date: Wed,  4 Mar 2020 14:40:51 -0500
Message-Id: <20200304194051.9189-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::27) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yong-dev.amd.com (165.204.55.251) by
 YTOPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend
 Transport; Wed, 4 Mar 2020 19:41:03 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e8bf936-ea3c-4b59-360f-08d7c073f996
X-MS-TrafficTypeDiagnostic: CH2PR12MB3672:|CH2PR12MB3672:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB36721E2574B21E1E29BCDA9CF0E50@CH2PR12MB3672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(199004)(189003)(52116002)(7696005)(2906002)(186003)(316002)(2616005)(16526019)(956004)(6666004)(26005)(478600001)(36756003)(8936002)(5660300002)(81166006)(81156014)(4326008)(6486002)(1076003)(66946007)(86362001)(8676002)(66476007)(6916009)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3672;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MOMPn7lkpaMHm7s+TFDCTTRzeuHB84inzzz+E7hr80qT/YCjzTg8M0Ccc36e0L3EdbgEVl/7QhQYzjk6asbeLb85x09AfCrOvPvUcMmYX3u/+tEQVLAUNwUzmvYXD4i801BnjN3eVYPkMjYyhfjRGCqFMsxIV+Wp9a1+7XbtS2Iuv6qwqi6M3aZ/luZ8gSFWKU0ZgkrvQ3ZDM6LYfIWbaNiv8ry3Blduh8gKbHY3Pgbi5egjX3NP3eQWDK943boZoY0rEZoRySRF3a3MunBACchfchquxeou5X7w3LrF5XdnjCFVx8RZnhgTMJXJh4NBlwCdrzfsavBc0sBbQXfKmkPqReMobV+VD5nBfItFFI064k5wFaM+Z/WDcLTREXsyIy67sskmJ5RFaZ/mXL+aNDEcb+CO8Uq0wmQFa3mqvwRu1Z6MjRSVg+4RU8ZlHJt1
X-MS-Exchange-AntiSpam-MessageData: 3AF84L/X/rTU7IVCkJ2GDmC9LaZ74CC7SBojqpDrtUJOp/Vet9pNl0Oe8Pg0VFiB+zr23+le9qtBUYu7ZfdfSpOmX9dtDpPyaf5qrY7Qj0fXOMpwOwbLbRgWB6ozJpc7N6d61h2Nu1A/5YKE5tx0vw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8bf936-ea3c-4b59-360f-08d7c073f996
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 19:41:04.0935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIMzjukmgpsEMX2zHVtkjaaWVD9uhkfwLonhagYl4xmSbrDAsJNkjGn9oFAVZNyR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3672
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c        |  5 ++++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    | 18 +++++++++++++++---
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 1947a326de57..10f6f4b21b44 100644
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
index 436b7f518979..5b11190ff6e6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -87,9 +87,21 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_dev *kfd,
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
+	 * types: MQD part needs UC (uncached) as usual, while control stack
+	 * needs NC (non coherent), which is different from the UC type which
+	 * is used when control stack is allocated in user space.
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
