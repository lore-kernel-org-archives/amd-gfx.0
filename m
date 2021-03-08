Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C478C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 15:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA46F6521D
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 15:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA46F6521D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A44F89DA7;
	Mon,  8 Mar 2021 15:37:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0721D89DA7
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 15:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jabi6PbwyLjXFfPWAdxS5wlzNHsCMXBBO1dd/zpUJYctxt0YAxoI2uJd4OTYK2WUFQVG6/Q88lQ99n+DudZ1FFSjrXqRmOa6DaaZ0thbyqt8PkN3ocuhY13V4L578/Q8K94aLqluWSZeSgWpldu471g7xmHbI++9eErBjLkeJ2cFlq4jmG1SSGElhLoPiju3+TYlE2McBFNSvh8+1yiO4TUtKitBpTj+SIURUvTnIHDoUS9uA3p3zSezwuNrylm/t2e5krRZlLh2+QUXYxSjOlWKNN/s9wqXfQRwPv94aIJ0KxRZhKxaBcJt6cMPfLpiYJWvc23QZZEV/fsGcCD9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkGfyLh/aZcDnjexuknM1Fh55eM3qCSV4sT281LyGKE=;
 b=dM7p7I8fXpGHwNC/MnTk9AOehs+SJh7oLuDlaOOZo07cTYhoEAO0SITv2Fswn1xFuw5Pd07dH/LLLP1gP53w/fKpdANcDGdJPOl6/BccpxuZSRJvBT60MRZ4XA3mi9eEBH9377G9igNyPdTMrR8S9hT0C9TLU/HnK80/woIrd+Z9cx5tBHlY+Ej/iOWj/BHZKU0CB9vZtzX8Yc06B764LNfM3AEcZCGo9MaCzg8BHJbjvbv1kSU5tUiiSICBAfI6CR6oVUIy4IFfjn2AxaO6E/39UGa3GinZuSv9WsjFn4Df1ACDW7BL2eP4EffXK78kLjjmm4F6a8ax9WApbaWDsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkGfyLh/aZcDnjexuknM1Fh55eM3qCSV4sT281LyGKE=;
 b=sFXCZSunnXsgCtC7TOr52udSIOW9egD9341j/8pF7R++/ZOnKIe/rm6drjGPptpQp+vvNJwuywy9uJY3AfckE5zU6lalgvzNbfPkxnpP5C/IQDRPdP1eR4NT0pxrKSfPUaWupyA6RAGtGqOIrrNLl2cVm8j1iFNryw/v5qyYK3s=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1237.namprd12.prod.outlook.com (2603:10b6:903:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 15:37:26 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 15:37:26 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 5/5] drm/amdgpu: use amdgpu_bo_user bo for metadata and tiling
 flag
Date: Mon,  8 Mar 2021 16:37:05 +0100
Message-Id: <20210308153705.37414-5-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308153705.37414-1-nirmoy.das@amd.com>
References: <20210308153705.37414-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.42.112]
X-ClientProxiedBy: AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::13) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.42.112) by
 AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Mon, 8 Mar 2021 15:37:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7f2213d9-dda3-42ff-1e90-08d8e248130a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1237C1E2B9DD76CD378D12138B939@CY4PR12MB1237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVSZo4jyy2FpPnWXXbQcN6xWU+KWgitUUwUP9cp5TezRq1EpfkyfhKbTmhx/IqCq7OfF9s6pFI3uxs2rBi7G3ql4OysONmO/zzeU80XOcSqqBvyK2IOdXluNtAas1MnMoN2lJLNJ/L5SqHcGJQsB3622Qa7SrdIlg+CP2ckZNaN01yo0IjUc/ieTlexF57+rinNoD7b3X6pcwkUjs/hptwn6qyQUgljkpCN4GJkYMGBVcJebiLwmwToED3I8wZbru4phlbHXG4rELX6tprXW7awdK8vEng8KrMYNz9TmIiaZPP7TsIvp6Db0xvxEiQ29dnPPQiV0xFKCpadFIrDDwSrWbCpCwBfNr86HAq0L3NdV3Us2TVJzIZeh8tI8LklJmsQuLEzycuBpRFQVHViOSbjXvQK6hYVj6Xmj+MQjYXPl5l0UsAhGSWynfJs0iKjjDQ8IEDtorsPvRnSEVBjvabQ4aeGRXZMKyHqVmqd4/R4JH2wuF9idSiVfU/76F8nP3/BtjpNqzy5TSuayN2R1+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(186003)(86362001)(44832011)(2906002)(6506007)(16526019)(66476007)(6636002)(26005)(478600001)(36756003)(6666004)(34206002)(37006003)(4326008)(66556008)(5660300002)(6512007)(956004)(316002)(2616005)(83380400001)(1076003)(66946007)(8676002)(52116002)(6486002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Gt6Gqu1s9MZYidnPqv0ty4g4Vb2N48kuC4hh/m3juxPZYlXADg26fAdas5L3?=
 =?us-ascii?Q?n5D0uUxSdE5UOQ7LAcqWM3lerkWkNudYwvoV7fKJtCKfIE1maE1rqH9ef1XT?=
 =?us-ascii?Q?c05bCI/np1mvj07oKYsL4G5Rn6Tx7j4q130e6VfnX0LhjyIecjrwap/Kpty/?=
 =?us-ascii?Q?WwhkgEJ+/qCP6iMJjwUdlqCTsPcVNQnGUGTJFg2vnE/mIx3ZWIIIOxdLBwYb?=
 =?us-ascii?Q?e2r+cwJ9kyRO+rdh5h0U83D8AyDr1KIlxi7pV7ya60IheQlIP0mAb+uyr1QK?=
 =?us-ascii?Q?yDzVmO3QMD0Mp2YVUb1FGaf0GczPVF+P4ht85ixiVU9yHWMaB5JKQ4P4Cqkt?=
 =?us-ascii?Q?YPlYCsNLim6F57d8LbSTCo98Aaa/c2t8QOaxMoXI9yIIdBf3ctcI7icmXV3H?=
 =?us-ascii?Q?7cIhCtgmdlA29+jzYgVVcnjMQAbmzZtd1s6L5xzO7jLCjEsB/R9uqiYPIoub?=
 =?us-ascii?Q?mj6VTKIGQ2vWEhouFUW19Gi7FapREuUdNu+SjonOh+d8k0/NVr5ia/FeAjSi?=
 =?us-ascii?Q?3j6Skjj5zr0CNsHluf5UaXSYF1ugwcV4GoUsH0Wgo+l8G3Z8q+q6FmqS4JU+?=
 =?us-ascii?Q?VoXVdtHNE9Of3qAf+e1WK6/lasnUcrVHZSmoccxQxDam2TP7Wc2eAmdZiaML?=
 =?us-ascii?Q?6QwG0avUEIoTmQV2GepheNXFPAgV5FJWIV6YsgMolJMqRQEWnV47P65LISYk?=
 =?us-ascii?Q?dyiS3MJgYApcHPkW7W0D4eK7ITGJ+9C67UvGNUIppuyUft5b1t/BEaO6VKl/?=
 =?us-ascii?Q?asuF8eV9UvrVV4fuHEwf7VLS7vt4JmOpJZv9vqqO1r3ENA9BB6RZkXI/+r9M?=
 =?us-ascii?Q?dkvIEeS0pFy2x4DDL10DAHMNSOWFJTtAh6f7yjQuiegavjrO8FGK3R4fh+1Q?=
 =?us-ascii?Q?YDoUBvH7ee0SiEZFgXpZuw5gQ5xY82OSQEKE4OvageVVxEauIk6fT9DCA2hp?=
 =?us-ascii?Q?mN3k6BWz+v0IaXAO5ZHWp1hmxGUVZssfqke72PpS7iiu5e9PccZSPxM1SMNF?=
 =?us-ascii?Q?pR3sMYJ8s7Ax+cYkF06xLFMGOKxQuNbIi2X5J4S8tt0arTuU2nEdD/6GpbCY?=
 =?us-ascii?Q?HAktBmsELcEODxeRygS/dOSUpB16B8w6qHpDiYguKhJBcfaKeQH7lqlkDcCs?=
 =?us-ascii?Q?rqr6eS1qV2X9ASpFeOYj/fa30kJFyUWK+jpiSXD8RjuTDaHexzjoERJo5LLr?=
 =?us-ascii?Q?C8osq9yF2QJOXqmP/i1/Eq1bK5gJussUHz8WAKR/6FQbLti8980Yxccvshnm?=
 =?us-ascii?Q?/PXELLBOj4+LXKxUIn5l6IbmwGdcKhY8DCd76s0LAVASL17t8EPbdsGsmSyx?=
 =?us-ascii?Q?8GdXJ6RcNYyyjLrebmJJ5Kuc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2213d9-dda3-42ff-1e90-08d8e248130a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 15:37:26.1376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPDMaNLI9SGe+NnYTyO5H1obcXsCKCbU37QLVYf7Y0PsToAcXU3K/M3EuxsDQLxeE9ig1CSKurDNg9WePbHh4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1237
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

CC: felix.kuehling@amd.com
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 59 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  4 --
 3 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 00ac5c272f47..04a19cdc08c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -496,8 +496,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
 		*dma_buf_kgd = (struct kgd_dev *)adev;
 	if (bo_size)
 		*bo_size = amdgpu_bo_size(bo);
-	if (metadata_size)
-		*metadata_size = bo->metadata_size;
 	if (metadata_buffer)
 		r = amdgpu_bo_get_metadata(bo, metadata_buffer, buffer_size,
 					   metadata_size, &metadata_flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index abfeb8304894..c105ba96dd58 100644
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
+		ubo = container_of((bo), struct amdgpu_bo_user, bo);
+		kfree(ubo->metadata);
+	}
+
 	kfree(bo);
 }

@@ -1161,12 +1166,15 @@ int amdgpu_bo_fbdev_mmap(struct amdgpu_bo *bo,
 int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	struct amdgpu_bo_user *ubo;

+	BUG_ON(bo->tbo.type != ttm_bo_type_device);
 	if (adev->family <= AMDGPU_FAMILY_CZ &&
 	    AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT) > 6)
 		return -EINVAL;

-	bo->tiling_flags = tiling_flags;
+	ubo = container_of((bo), struct amdgpu_bo_user, bo);
+	ubo->tiling_flags = tiling_flags;
 	return 0;
 }

@@ -1180,10 +1188,14 @@ int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags)
  */
 void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
 {
+	struct amdgpu_bo_user *ubo;
+
+	BUG_ON(bo->tbo.type != ttm_bo_type_device);
 	dma_resv_assert_held(bo->tbo.base.resv);
+	ubo = amdgpu_bo_to_amdgpu_bo_user(bo);

 	if (tiling_flags)
-		*tiling_flags = bo->tiling_flags;
+		*tiling_flags = ubo->tiling_flags;
 }

 /**
@@ -1202,13 +1214,20 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
 int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
 			    uint32_t metadata_size, uint64_t flags)
 {
+	struct amdgpu_bo_user *ubo;
 	void *buffer;

+	if (bo->tbo.type != ttm_bo_type_device) {
+		DRM_ERROR("can not set metadata for a non-amdgpu_bo_user type BO\n");
+		return -EINVAL;
+	}
+
+	ubo = amdgpu_bo_to_amdgpu_bo_user(bo);
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
@@ -1220,10 +1239,10 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
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
@@ -1247,21 +1266,29 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
 			   size_t buffer_size, uint32_t *metadata_size,
 			   uint64_t *flags)
 {
+	struct amdgpu_bo_user *ubo;
+
 	if (!buffer && !metadata_size)
 		return -EINVAL;

+	if (bo->tbo.type != ttm_bo_type_device) {
+		DRM_ERROR("can not get metadata for a non-amdgpu_bo_user type BO\n");
+		return -EINVAL;
+	}
+
+	ubo = container_of((bo), struct amdgpu_bo_user, bo);
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
index fd30221266c8..a733b6323c0b 100644
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
