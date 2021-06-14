Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D784EC2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 14:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B6961246
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 14:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B6961246
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F3989C9D;
	Mon, 14 Jun 2021 14:32:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70D7B89C9D
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 14:32:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L17CRcGlz2LhWdGmWwGjCfqU3cFJ+LHLbPKEkgF6r240r7kdqUAaaXlhXt81RlX2opGlOsX6MRhIE7+lftMKgeVV+3r1PwmmdjFMkfaR06NCBilVkV5Qd+SgnBccdyTVItu2LiWxm2hYJWFoYgJi2b2Rqddbkha58V+wPKfzM6N5/1NzJHWDYq+h/NEHm4JEJKi4Cizpl71cJpFasEAGenSVCBSy6IIQsqvIvPm1Nvu8EQBldQYqbQAyR2BKNflWR3lclGvs4a/kxm31pd/brze0/knV7IiCDGXD5g+4gnV4RjmSYQhMnnfNfGvJkQo+uBJDDkY5SrTlKeg/V1gAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd+2592uLdoAy6oYMdAU7x/X/9/uEKAaz4megLpOizw=;
 b=dw75rb/vcRSnQQuq8VYiQcdcdOtvNFueUy97nrGmf7lxhJ4PXu2KzbjQQ40ChNiyqv5YYoNQDis2EORqxeMwbAIl1QOc6odC9ek1gpa62f/6C3gaNfzcE/2Dy5mPWXz62HqFbRiZAS/CtwRtdGThkQN5HSMQA6aZPQG9K2mtSNV/wQA/9E8hu8AHR9VPLU5Mg5e/T8/dcgwcowzW8nDfebUeOaI6YvJjyxgZFaSvYwlPPDHniNBBR0XUKWJUQhxKtuoHCOeBnFna32JILxXuOd5dH27yI2yQOAKOpCGnTI1RNzrf2WMgI50M83UuxpO4VBlNN2M72ZzNScaw3wmhQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd+2592uLdoAy6oYMdAU7x/X/9/uEKAaz4megLpOizw=;
 b=a7HFuDzgyysm0K/UPBBObMb0UENJkN9Wth4MY8bthHl3mK8WtLFpubRHWqrTcWAEwq3SlMBopNypzw0fZegxLnsopBFcUxwBjwtP+Jx54h8/dK2w7LhMtDyQyktyQxJiLjXNtQ5FoBkQP7a5zKd3oY3YSrX22sDVOj3cfCGFxzI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Mon, 14 Jun
 2021 14:32:32 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 14:32:32 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: parameterize ttm BO destroy callback
Date: Mon, 14 Jun 2021 16:32:15 +0200
Message-Id: <20210614143217.10285-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.117.118]
X-ClientProxiedBy: FR0P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::14) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.117.118) by
 FR0P281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:15::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.9 via Frontend Transport; Mon, 14 Jun 2021 14:32:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42ea000f-5879-4a99-45f4-08d92f413ef8
X-MS-TrafficTypeDiagnostic: DM4PR12MB5328:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5328C5767BBFB5DD26AA73728B319@DM4PR12MB5328.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O6nr3Bp42kOiKvUa2sRJfCwXeA40FkI7v8XhMobcilr1EWHTV5AaE0iV9vAGsqrZyENndrymspIi4UY2WDTWVFYOFkN2H7q1HmEhv7Ekd6wWAljHlM5gUUz7vIJ8778LvEfZtQ69YtLvyPtUQsfoHDybzuUXdmESsjVy/j+MmGUBUDAK/zX4ywKRVQgBNWY5ZyyH2WIahbCWTRbGK4aEtlnwh52gJfkDH3h+nHJFpbHhk8d4fXNT9n3ZmAb1WbIKQaYIW5ID4OtvcGlOQJoUWGqJ+tx/PSluWM8p+bHzJ3znjgfq7FoHY3f5rey3KSbGot+JnOlpyKiSIQvwiNSr21cqYGISjmevAXePmxIVbzFIMTyqCNENa1PlYxPx2D8tNI7znY/7kSqmg2HD9eunQrCQA/Q/t6xer3pGnhsXAsWqcROyX2slZhQkbWl4QHmOzANmBrl1q38QzRmSk/ZhXCyW3m4VTXXLE7Gz4m0iY3dhhppa3EpDoGsXvaZQl1F3xblJqmM3otfIT0Kx1WGsN/+Qe3+Y1mQctFydfzFOFhxuPyHozm0kZmdpQbHaT3xJQm2DfenKKXmLSARjTwl2I5L04rNkV5wC9u2PzfHJDUgzjMcvkV512qsyyqSHXIuAbCyUhA/JEXnmWYtKwm4HYrvvEKsC2orcIRaKvGkSIcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(6512007)(44832011)(8676002)(83380400001)(38100700002)(1076003)(2906002)(6486002)(478600001)(956004)(6506007)(86362001)(316002)(36756003)(38350700002)(2616005)(8936002)(66946007)(6916009)(66476007)(5660300002)(26005)(186003)(16526019)(6666004)(4326008)(66556008)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2FpDnXCDdKyYj96Uh4+ZXTVhotFvP8MaCBL5wLE0PpDtSRVRb0+jz9wDXV9p?=
 =?us-ascii?Q?n52m2dNsC6IP66XI1NXf5zuZ3ApRdf9GTXdvzQSO53kgv+PvOo89KB0/0ezN?=
 =?us-ascii?Q?7XkSBLEMUar/p2syZiaFTBj1KWIhA/bgoKpFrd4MNTLTm9unrdIqyXv/kDzu?=
 =?us-ascii?Q?iSJbWa6fQ/IgmknRbUfGgEt4wD9C2hTVsyzVHFqmGmRbhBkbNrCayWujQIxX?=
 =?us-ascii?Q?PLFvrZW60U5s3x0OVjqbe5oeINWBVqLve8kAxHvJtG7L6DhwqMFp3mrpKTij?=
 =?us-ascii?Q?EuNUwJOIBIwPtm6A6S1sN4ZpIKq41QQ3i3OYJRVXOwZPBugcmCVs2zBTfL3L?=
 =?us-ascii?Q?WaWTFgWtIAaG1P2p6R79JU+sP4Ypb2pEDLFCIf1VeqdVgje3eXxvjwBChLd/?=
 =?us-ascii?Q?9SqdPl43vT68cth2aYtj+9AoS5CljcPnf9PQ3saUCvON6kK+W/hMg8GHdhhi?=
 =?us-ascii?Q?XHTsJL4X8+XFJIgf0/T8eegni4T4W3O7R8xKZ/RrzVoLMoguMrA3jJ10jmze?=
 =?us-ascii?Q?liG3BwSijiCvL8rEfh1LYyMiI/62XcVgPvG70y9tZdJShV55zIN50zzOMWb4?=
 =?us-ascii?Q?rOQSGD5lY5wS34JcmKq7RHufleDnwUECCjsvEARSGnAiNbrk+QB97ybbTTby?=
 =?us-ascii?Q?D8T2pQrzuFMpa2gLb0KZX/jsdiUT/pjp8zT+qaQUPj4CQMVRoZ0YYwgE11bg?=
 =?us-ascii?Q?iKQNi0ZqdYEhxJSs7N59cZ0DCi9TiL8h5aXAer8tDVIOJlcCg63nqp0XVVir?=
 =?us-ascii?Q?QAHr6zMmMFsYulgWUa3ZMuRxSeJUYBTBNmY4+lJq+FHEq5bt9beTuC4V4guP?=
 =?us-ascii?Q?vKbaB7ZZEBH+ah+eLq8R4p8MxrIwbqvEjE++e50s+aJDvrrLpszqAhqiAyHK?=
 =?us-ascii?Q?Sk5AtPTFtziV2V4UqZIIG2ejizjKvNL53C8OwC3qsFyMVDOgKoGER+l1yd0b?=
 =?us-ascii?Q?7yFa9+tlVm7MC4ufMUOaIjvNDl7Z+5cMViIl/bu9DgHtuAAmQZW4mmSP89up?=
 =?us-ascii?Q?kBY9gDXwSaqusF4lWMLczVp2bZDTFq8pS4l3AEfvFxDCbRQspPUK3mS2/NLw?=
 =?us-ascii?Q?ONtaQZ1Yl+9oIsHInUXGsrrBf2aGzgwXkhVx22wgEichuwsmp+U775JaUEj/?=
 =?us-ascii?Q?dgLM8cF1SuqKzj4R4tC9M0yo53Px0GnS0GtfTdH+LpNid8SwAChDXKOeIYw7?=
 =?us-ascii?Q?liK7UGaaszWddPHsGEDsWItxp0TPKdLQybJLHnePYggeXf3aqDQWv6g4Qb2u?=
 =?us-ascii?Q?fgzmaOxauMRHu3D5SqoIpaPWLwCfhP83F7gm1VZoHgDSYy9AQ60HWy6r1Kgt?=
 =?us-ascii?Q?RJoSfhrxEvIG/deb1LcZbN19?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ea000f-5879-4a99-45f4-08d92f413ef8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 14:32:32.6778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozx1slx8qUhui5DfxhbWpb7bjKDKQhkwtrOCECsQRbWrhBxzfbz7ve9RJpeUhrzrrzU2OAHkOlG9Ymp/fYQLEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5328
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

Make provision to pass different ttm BO destroy callback
while creating a amdgpu_bo.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 28 ++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 9092ac12a270..71a65525eac4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -522,15 +522,17 @@ bool amdgpu_bo_support_uswc(u64 bo_flags)
  * @adev: amdgpu device object
  * @bp: parameters to be used for the buffer object
  * @bo_ptr: pointer to the buffer object pointer
+ * @destroy: ttm bo destroy callback
  *
- * Creates an &amdgpu_bo buffer object.
+ * Creates an &amdgpu_bo buffer object with a specified ttm bo destroy callback.
  *
  * Returns:
  * 0 for success or a negative error code on failure.
  */
-int amdgpu_bo_create(struct amdgpu_device *adev,
+static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 			       struct amdgpu_bo_param *bp,
-			       struct amdgpu_bo **bo_ptr)
+			       struct amdgpu_bo **bo_ptr,
+			       void (*destroy)(struct ttm_buffer_object *))
 {
 	struct ttm_operation_ctx ctx = {
 		.interruptible = (bp->type != ttm_bo_type_kernel),
@@ -594,7 +596,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 
 	r = ttm_bo_init_reserved(&adev->mman.bdev, &bo->tbo, size, bp->type,
 				 &bo->placement, page_align, &ctx,  NULL,
-				 bp->resv, &amdgpu_bo_destroy);
+				 bp->resv, destroy);
 	if (unlikely(r != 0))
 		return r;
 
@@ -638,6 +640,24 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	return r;
 }
 
+/**
+ * amdgpu_bo_create - create an &amdgpu_bo buffer object
+ * @adev: amdgpu device object
+ * @bp: parameters to be used for the buffer object
+ * @bo_ptr: pointer to the buffer object pointer
+ *
+ * Creates an &amdgpu_bo buffer object.
+ *
+ * Returns:
+ * 0 for success or a negative error code on failure.
+ */
+int amdgpu_bo_create(struct amdgpu_device *adev,
+			       struct amdgpu_bo_param *bp,
+			       struct amdgpu_bo **bo_ptr)
+{
+	return amdgpu_bo_do_create(adev, bp, bo_ptr, &amdgpu_bo_destroy);
+}
+
 /**
  * amdgpu_bo_create_user - create an &amdgpu_bo_user buffer object
  * @adev: amdgpu device object
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
