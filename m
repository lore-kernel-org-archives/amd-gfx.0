Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E47C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 08:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE12465266
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 08:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE12465266
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C31BA89E52;
	Tue,  9 Mar 2021 08:47:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00EF089E52
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 08:47:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0DQ/7kyqm602nVc21pKVQ1bQ3rQa+Lq24CNgHISuIs94wvSN/N/DzDteC+QD9gR4fFHCg1YNVpa8IYqzUdPxHsSZa/Wa32n+1Fc9lVgqzJbu9YHcTp9xoogdt+olhDtv8MdOkah/vwYP0DmGKFJPYVS93SWHk/rxGJXEOtpLuW9CgL2QIfbCryMJDC8fasKvgqKDnVrKNX0h6/A+jYaRjn/jWHU5BmSlwCX6cVYo28dLYil9xqKakmO6ukrD57vtnjESuFaCripcn5yHfyLjza22KB34b1Iz+CWdU4UO3ZUlHdMvTDocm3XDZO76AKQMS4q2WE9nYAcLu05aE0QGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEPJVc32lmCYj40U5n7naJ2lIHjp775VEB2DTFY2IMc=;
 b=FY2L5czCRY3xttleTTr5CXQqN/IOX48xKhM+2z55AKyqxGJJ4DRRyVue/uo71FgiKJojPp/cR+WxQ1KIT3Nm9epvEUT/9+XWJDHBm/4QeIL46FfB5MgrJoxjSW+qA8U5fdEbq/a8PFTOZ3dq7tuhSG8WjV15RcvF8wx4C/dbtJJi8rB6mXNSmDSykW/IOOjsgQjA/Va7rQ8geVE7I/moUiP/K9Yo2TE3N8uJI22qf8qKh1YBkLQUOjMUZ5SCk3H1OpIVhUjh+KrsVMOUtfQGQ0kY7jhij7fpkHL3DLbmTSJVQ23FeBWDOmH0+bIh6DX7+sKKrVxhydh5RHsbVjxjvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEPJVc32lmCYj40U5n7naJ2lIHjp775VEB2DTFY2IMc=;
 b=Ft7A8LTPjHMFvB5F/sxhkpMne3SabF5DkpXjCU4i8Qo55Z8NdAwi4kx3OWs/ymewSKARLYEIa7eM264ziI1K70aPmTwxtyY827Gppd2fivLfz93I3xXU1tMIt4cu7DdBB+CM925hqfYBbKs/Ku9iGYRGJjQGUaq7TzYc1oigfGc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1459.namprd12.prod.outlook.com (2603:10b6:405:e::8) by
 BN6PR12MB1377.namprd12.prod.outlook.com (2603:10b6:404:1c::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Tue, 9 Mar 2021 08:47:17 +0000
Received: from BN6PR12MB1459.namprd12.prod.outlook.com
 ([fe80::21cc:170a:9889:4460]) by BN6PR12MB1459.namprd12.prod.outlook.com
 ([fe80::21cc:170a:9889:4460%3]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 08:47:16 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH v3 5/5] drm/amdgpu: use amdgpu_bo_user bo for metadata and
 tiling flag
Date: Tue,  9 Mar 2021 09:46:59 +0100
Message-Id: <20210309084659.37649-5-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309084659.37649-1-nirmoy.das@amd.com>
References: <20210309084659.37649-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.127.127]
X-ClientProxiedBy: AM9P193CA0028.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::33) To BN6PR12MB1459.namprd12.prod.outlook.com
 (2603:10b6:405:e::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.127.127) by
 AM9P193CA0028.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 08:47:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25c91390-f2aa-44a1-bfae-08d8e2d7f0d0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1377:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1377A7CE825D4FDC549E17C88B929@BN6PR12MB1377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nOyp6l9pZReaheFUihLIikfY3vZhdVyZoEEJ9TKkjUTNOnT/EuAZFosB6Su6A4jV9wJgcY9N3jlYCH4EXtSnvazf26FCFhS0LjNso0uC83YS30THwZ8uMJRdA/cwjGtLYQayNyWpHM9NbsAuTNn+BZtrOaaSMRMMpp8ktNR4KzuaDYWzKdYUSVEsQSZbvVN2SwNG4ntVJ6VFSY3LRAucV9nfYoiIxreqGYggX0CbcTtvu39d0RuCDe7r7M4CZUTJeFA+0s4ZmEz69f4S0XehVO7imrO7vdEZsC3lXR0hEq/FoYEPYGyVQc8uONkTxPS0gPxB2t8szThNpiSSWoO6GizpqgcQQs0jh4FFrJPwxvU/+ZbxV0tUQhC5URhKwl1ZL1wb2webIB4nTorF5REOSOcq9+6K6rprac74c2YlR6LGIX/5RUZiNv8oreOh/D+xwAzsmjJmx5CnCWfoFTiUW4hNhoAS4zDCQrhfn0L+vom1osnm11WkMctmSfTMHn5wbxusYHnxue6BxCKsfylMKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1459.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(66946007)(6666004)(2906002)(83380400001)(316002)(4326008)(6506007)(36756003)(956004)(478600001)(8936002)(5660300002)(44832011)(37006003)(1076003)(52116002)(8676002)(6636002)(34206002)(66476007)(6486002)(66556008)(26005)(6512007)(186003)(86362001)(2616005)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vs4FSRKAYbs8kYPH3eBZ2h/b/gNcgPmBDIqL8AcqV6HrZ/UwsKU7Q4NUD1Ah?=
 =?us-ascii?Q?3hcyWxHwNwpGFMS8039AMGh/qTNdkk50vbLrtcN8C+QR4ogs2zVVJ6HlyOtn?=
 =?us-ascii?Q?OX1wOtGFIqagVGUoTSXm4LGPSscOaIW5f2YP8PHfsFu3jat3T3UNU+dXWvxU?=
 =?us-ascii?Q?UyZFU0osdv9PhQm2ctvOKDrBiFxo3n9YXejPGn3mdfxBkVwO8wndt1QHL8uk?=
 =?us-ascii?Q?BLnOOSDbR1+5E/DTioIJTzaCFPBkJo/N7lGcFLmtz7Sdyy+0WswWg3nFjlfF?=
 =?us-ascii?Q?owL9T57FegerQTko96pt5eJyaMuTthRxqpalVn0bDtEvGdg6p8ftOEY/huN0?=
 =?us-ascii?Q?UPREZGsHu+u2Sh8TYBMjgYI30Qdrxsrl6QZmE1MmJFUsKTmzuUNFSUa6aFAV?=
 =?us-ascii?Q?fG4aEFod7Bx7VkVi8tHvwdzXCfirk43zeVAwcOmIp4gOb1BSMyVyuDjPemSs?=
 =?us-ascii?Q?Rvg+0Pcr42jHI3NmdIgzF7vRM4sknRiC0laJpKegW3pHjn6DBZhZWiP2JY2e?=
 =?us-ascii?Q?72VwQjqTSt29qW01f8aG2494fdu2VQlYDL9N8JcJiifRtFJLJp0gn854qBCY?=
 =?us-ascii?Q?McIgw4Q00ZpHhe/rrbWtXjvxa1ZPhuivwDYCAopuTP9iAbj5hP11VyTAHZkl?=
 =?us-ascii?Q?TBBnqUxQbi9ExcbGCK/+JBwrJoAZYB7gD/p/0gxhRgQBC93vSLm8QBiuvKPq?=
 =?us-ascii?Q?Y3VPXWkZgtZiLzyqRT6FrgyQWCSGbjYZ4tjwF54HZvz3nrSkc+LCaHqTqq+v?=
 =?us-ascii?Q?u+Rc3a4w+bIxjKrpdHFNkXXyF7uP6gWW2atvnlo83ntVqfD9a34ine8dP8t/?=
 =?us-ascii?Q?0aPTuF366ERcWUUXY7DTKesIBnnUJF8aP64Io/RD3JIjlLNXWZwY2gJSglKg?=
 =?us-ascii?Q?rJWM75hj8CFQFN1daM71vigns0Ymax5CkOjdxbETs5iYZQnAfyrnAw6UUpoT?=
 =?us-ascii?Q?hHts9eIhOJDSmDTc8cv62waG0ZOlhKriBCk4vfkwJIeBXlfgCdtg/c5JWLU1?=
 =?us-ascii?Q?i2HJu18CcvnQKWFt4vDXN3ltz3jVFLDODDCM1w1PN2YGXroBwRaNOlbA9euo?=
 =?us-ascii?Q?UAycg//L2OOdKby8XzslKgCU9o6xDbTfjo1F4XP3lU5QIwEgIhRPXmy8iNla?=
 =?us-ascii?Q?GljrarHdcqC1yd/ZxgIJWKadhhkMHkQG3yMOPUFmSKPQOdqj2UhbaL2Vb3qM?=
 =?us-ascii?Q?91D+HbJpDQQv5z3QrF1zFHjFCovsFmDlgLxNK5bszigi7o7s8Vvg45ic8b2G?=
 =?us-ascii?Q?vPqwGJPzzu6wJ8q75OPhfcgoKxQZZeLrdQ7bl4d1a9qKgwcLLBX3LnWB2yGA?=
 =?us-ascii?Q?8F7fzP6xGiYFTo0y/r/AILIk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c91390-f2aa-44a1-bfae-08d8e2d7f0d0
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1459.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 08:47:16.1242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnbV9FBzxsALBnLUQUXCj2s3PwLj+SuGWnIREecxH5x6y+nvYjKxjzZXisc9m9wzj5ebhJEKqc7Z8W1LilqHbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1377
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
Cc: felix.kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Tiling flag and metadata are only needed for BOs created by
amdgpu_gem_object_create(), so we can remove those from the
base class.

v2: * squash tiling_flags and metadata relared patches into one
    * use BUG_ON for non ttm_bo_type_device type when accessing
    tiling_flags and metadata._
v3: *include to_amdgpu_bo_user

CC: felix.kuehling@amd.com
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 51 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  4 --
 3 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index de6b3ca64b45..efa79719d453 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -498,8 +498,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
 		*dma_buf_kgd = (struct kgd_dev *)adev;
 	if (bo_size)
 		*bo_size = amdgpu_bo_size(bo);
-	if (metadata_size)
-		*metadata_size = bo->metadata_size;
 	if (metadata_buffer)
 		r = amdgpu_bo_get_metadata(bo, metadata_buffer, buffer_size,
 					   metadata_size, &metadata_flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index bd89d44a1f2f..ac0e1cd83858 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -77,6 +77,7 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
 	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
+	struct amdgpu_bo_user *ubo;

 	if (bo->tbo.pin_count > 0)
 		amdgpu_bo_subtract_pin_size(bo);
@@ -94,7 +95,11 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 	}
 	amdgpu_bo_unref(&bo->parent);

-	kfree(bo->metadata);
+	if (bo->tbo.type == ttm_bo_type_device) {
+		ubo = to_amdgpu_bo_user(bo);
+		kfree(ubo->metadata);
+	}
+
 	kfree(bo);
 }

@@ -1160,12 +1165,15 @@ int amdgpu_bo_fbdev_mmap(struct amdgpu_bo *bo,
 int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	struct amdgpu_bo_user *ubo;

+	BUG_ON(bo->tbo.type != ttm_bo_type_device);
 	if (adev->family <= AMDGPU_FAMILY_CZ &&
 	    AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT) > 6)
 		return -EINVAL;

-	bo->tiling_flags = tiling_flags;
+	ubo = to_amdgpu_bo_user(bo);
+	ubo->tiling_flags = tiling_flags;
 	return 0;
 }

@@ -1179,10 +1187,14 @@ int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags)
  */
 void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
 {
+	struct amdgpu_bo_user *ubo;
+
+	BUG_ON(bo->tbo.type != ttm_bo_type_device);
 	dma_resv_assert_held(bo->tbo.base.resv);
+	ubo = to_amdgpu_bo_user(bo);

 	if (tiling_flags)
-		*tiling_flags = bo->tiling_flags;
+		*tiling_flags = ubo->tiling_flags;
 }

 /**
@@ -1201,13 +1213,16 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
 int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
 			    uint32_t metadata_size, uint64_t flags)
 {
+	struct amdgpu_bo_user *ubo;
 	void *buffer;

+	BUG_ON(bo->tbo.type != ttm_bo_type_device);
+	ubo = to_amdgpu_bo_user(bo);
 	if (!metadata_size) {
-		if (bo->metadata_size) {
-			kfree(bo->metadata);
-			bo->metadata = NULL;
-			bo->metadata_size = 0;
+		if (ubo->metadata_size) {
+			kfree(ubo->metadata);
+			ubo->metadata = NULL;
+			ubo->metadata_size = 0;
 		}
 		return 0;
 	}
@@ -1219,10 +1234,10 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
 	if (buffer == NULL)
 		return -ENOMEM;

-	kfree(bo->metadata);
-	bo->metadata_flags = flags;
-	bo->metadata = buffer;
-	bo->metadata_size = metadata_size;
+	kfree(ubo->metadata);
+	ubo->metadata_flags = flags;
+	ubo->metadata = buffer;
+	ubo->metadata_size = metadata_size;

 	return 0;
 }
@@ -1246,21 +1261,25 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
 			   size_t buffer_size, uint32_t *metadata_size,
 			   uint64_t *flags)
 {
+	struct amdgpu_bo_user *ubo;
+
 	if (!buffer && !metadata_size)
 		return -EINVAL;

+	BUG_ON(bo->tbo.type != ttm_bo_type_device);
+	ubo = to_amdgpu_bo_user(bo);
 	if (buffer) {
-		if (buffer_size < bo->metadata_size)
+		if (buffer_size < ubo->metadata_size)
 			return -EINVAL;

-		if (bo->metadata_size)
-			memcpy(buffer, bo->metadata, bo->metadata_size);
+		if (ubo->metadata_size)
+			memcpy(buffer, ubo->metadata, ubo->metadata_size);
 	}

 	if (metadata_size)
-		*metadata_size = bo->metadata_size;
+		*metadata_size = ubo->metadata_size;
 	if (flags)
-		*flags = bo->metadata_flags;
+		*flags = ubo->metadata_flags;

 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 06b6fa35db99..25411b2c4dd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -92,10 +92,6 @@ struct amdgpu_bo {
 	struct ttm_buffer_object	tbo;
 	struct ttm_bo_kmap_obj		kmap;
 	u64				flags;
-	u64				tiling_flags;
-	u64				metadata_flags;
-	void				*metadata;
-	u32				metadata_size;
 	unsigned			prime_shared_count;
 	/* per VM structure for page tables and with virtual addresses */
 	struct amdgpu_vm_bo_base	*vm_bo;
--
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
