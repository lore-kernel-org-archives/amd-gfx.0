Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0A6EC1EA5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 12:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66A4510E883;
	Thu,  5 Feb 2026 12:13:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1QJioE6Z";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013046.outbound.protection.outlook.com
 [40.107.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC2E010E883
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 12:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOTm2ehTYSRssFR6F6Lx66Umv22anqJvQRpgZMSFLPzF1x5YTcneiXLR5prr5AYTpaD+vf033FTmUXs3ghcT8mkAP5tr5qygEPti/n0xQiDzqW1+e1aj8x6R2AHiqSl87eexb/+q5YFEwOHfvIchnNN8lZnjqn6XVIsPIPR2382kGZmCDjggQKdWMQW41VAF+sH68hxHOnnVh0758RSIkM6m9D+BhzdjGaeOO5b8YYa+BnA1FWH+dh5FjPktn7tlyfpIAr3p2M8e1v8RH8jxytyPCSKQi8TvZKfZ91tGD20vJ+dCQuBR6rAXMbPy+YwtsQQhyTJUlAZCpDAHkyX+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UwJ/98L2Wx8spPbsl1AVPzSQSUYMLyvq9q5S4gMB7c=;
 b=s/jiWNCGF5rqDakfqv+6eV4xO7UbLRnVO2W+55WI3qeCj9FbFEU7jiGSYqfN+PSwLmlL1EpRidFJvqzld22AfoQjI/Ky8gsC2g3jfXVJ2Kbbv9DzTUXiOOfvdsuG7NJ6+3VT88in8iHyFqBCNGr4Z70zRJ0VpCLuiy9238m/EvemgqRLP6pP8IzeWKfW/fYOJiW74IY/Znq5kDO0ZbzTHFC89ldKELfOu0JBvkUF7bd6TmoBnwAP/tY8ydYxv8YWRvLXuOvAGMtrEIS4dvkQqADKsLb/zrrRlJywZ2bX8AFeJ6yuprVS/qFXyBTRrMgmRCgjuJCovBQZ0+UZUKaiCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ursulin.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UwJ/98L2Wx8spPbsl1AVPzSQSUYMLyvq9q5S4gMB7c=;
 b=1QJioE6Zt62iIyF6hYRTAqKWNzEyy5L2Vs2dCQ/4Hi26td8LlsONyIIKngFP0lWx8iZ94gfDlaAiNzk0vucJAefICpVjIDHFqD47wgbSw/f3vFrqbSnbN/dLRAxuUNNljHdRoyJciGY7HCAFO5VvlKoP85XdhRvA2YO4JQxynkY=
Received: from MN2PR20CA0047.namprd20.prod.outlook.com (2603:10b6:208:235::16)
 by PH0PR12MB8006.namprd12.prod.outlook.com (2603:10b6:510:28d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 5 Feb
 2026 12:13:24 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::7) by MN2PR20CA0047.outlook.office365.com
 (2603:10b6:208:235::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 12:13:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 12:13:23 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 06:13:21 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: Tvrtko Ursulin <tursulin@ursulin.net>, <amd-gfx@lists.freedesktop.org>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/gem: Make drm_gem_objects_lookup() self-cleaning on
 failure
Date: Thu, 5 Feb 2026 17:43:07 +0530
Message-ID: <20260205121307.285864-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|PH0PR12MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c0ad87e-8dc5-4b15-cec8-08de64aff5c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlNoK3hDbStuZkxYZVg2YlpMbnhrQThjYk5uM2NxMVZVSStkajY0cFhSMjNk?=
 =?utf-8?B?L1NUQnN2UVB5VU9CSTczUG5MV2RCSXJJSDAxOVFLVDFkVWtVd2dFYkVYc3JT?=
 =?utf-8?B?bjNLbmtQbmNiZWllWHZFYWJaOHpDaFltejUreTVid2tqRW5CYmRNbUI4QWF6?=
 =?utf-8?B?MjQzMEVrMkQ5Q29RQmYvbDdGSGVVei81N0lTL0lLTHBURVRhNDV3MzhiSlBS?=
 =?utf-8?B?S1l2alpRaDhkUXppNE15RlRzQ0E1aExZZUdkWWM5ejZCR1hqajlGS2pBOXhO?=
 =?utf-8?B?TXdJVmZwdUxKNlBQcU9BbGhSM0VLVm9MamdNUlhKRWdRZ1F5VVM4R2hHbCty?=
 =?utf-8?B?UkxscU1vb1NrMGZxQ1RKVDgrbEMyV2NkMGNzUGVsWlAzbmdkODV6dURDdEJY?=
 =?utf-8?B?ZldJUFFQVG1PS1E3czBBdDUvK3MwSTcwR2p0dklwMlJmZG9wRHdzUnRheWk1?=
 =?utf-8?B?N1g0azVKZVFncmJNOWs5ZTNvaUYrSVdVVmc4R2pJQSt0cmQzeTdFbGI0aHg0?=
 =?utf-8?B?eHpZOUw5elNmbUJJbm81cnJVQmlDZEVQc1dmMm9nUFA2TFVELzJlNllnUExu?=
 =?utf-8?B?elovL3pmd2N0Ym96aVc4RWRSdCs4b1gwcUNkbXZIN3lOZkxvT3NNS2Vua1lt?=
 =?utf-8?B?RzdTaDBoWDRGSHZ6WjNIUTdzQUhxWnRPZ2RQc2hvT1pGdWtucllSaUdBdHE1?=
 =?utf-8?B?S3BQTFBTTzFwYnMvd0NFS3BaY2Zsc1hobXJmSTdsUGJ6Wm1YNVpyeGRmUnJj?=
 =?utf-8?B?aVd6MjlEalU4TTQxMGVSRUlIelE1L2dUeWtmU2lTOTBxYkRsWDIvNGN2bjhh?=
 =?utf-8?B?TjQ5bjEwZjNwR2VuV0ZYWlNPUlZibVlIeXV2MVBYVk1SZlI3bXlYUzJlZ0Ex?=
 =?utf-8?B?MHpSWTg5QWNTNzNtVnE2ZTd2Zk9UekVaU3JYUG5ZSEhsZmovWTc5b3pNWENk?=
 =?utf-8?B?ZE1sWFEyT0dTdXVUbGpkcVNYNjlValJZc1lhNUczOE83RjFSbWJiRmVtT25i?=
 =?utf-8?B?bTR2UFMwb1g2a0tPTkdKdWJoMnpmLzRnazAwWFQrZ1Z4K1pEQVRwKytmdi9Z?=
 =?utf-8?B?Q29CWHhEbmdhTExGcms1bFE5Yk94YlUzSnRkSjZxcG9IU0d3b0ZSZy9mbTA5?=
 =?utf-8?B?NlVueC8wYk1hU3U2UnByYzM0Y2NIYVduT3g5YjlPUHViTHhibDNmbFhFa2c5?=
 =?utf-8?B?aFp2MEQrNmhsU01nQjdYRmc4RVNJQUk5cFZEUnB1czltOU02MHhOMUV5VGpU?=
 =?utf-8?B?SGNyTUFIWklMdzRObDR1QTBHN0VNOTVjaHord1FPMG1nTUdYeDdIL3ZUR0M2?=
 =?utf-8?B?djZmUFZhTkg1dVkxalFzRzlZRW9BSzdvSy82cm9keHc0bW5HSXpMOXh2emZr?=
 =?utf-8?B?WHVEMWdaSUZ2aFg5Z0tCS3F6NkZJVHJ5ZUVZZ2tnanVWMllyZHBnaWVHTS9O?=
 =?utf-8?B?R0dVamtwOC9TRGRpd0VQSm5LZTdBN2NhTFN0MkoxV05RQTA3aDMyMCszZnhq?=
 =?utf-8?B?dmVoU2NFSG1OTTdHYjhnRXRZbFBubXNsMEV1aGVZUFdEN09RdGlFVCt6VFpE?=
 =?utf-8?B?aTEvL1FtQzhJK2xQckszeXBxYjRnUzZxYmEyMWhrQzJSRTh5Z0dNWGtOa3RY?=
 =?utf-8?B?S1orVWVFK2UxS3Q5WWtOMEcyRVRFbmFFQlNTWTFFd3hORFNKZmdvakJlOVUw?=
 =?utf-8?B?VS9CblpJWS9McjQrM0pRNzNhZG5OMERjR3hZKzBPeXU4dHFVcms2bkFYN3BT?=
 =?utf-8?B?SC9EK21aczFqYU9ibXJEYm53UXdLNkduQlZrQnZ2Q2pQQ0pXY0RxU0c3RUNI?=
 =?utf-8?B?bUlxWS9PU3ZJcUZlSjJ4dm1JWld1SXNGWDdtYXQwekppeGRmeDFuRFQrcWpz?=
 =?utf-8?B?b1h2MHhGdnBod2R0U3VHUlo2NURBZnpUVVVybTQxc1FodlhGd0s5am5zOU8y?=
 =?utf-8?B?RE5heVBkMS9yMWFRcGpnWmlYQ1hDaE9rbFptbXBlZU5zY2N5dHNjMUUvUGRV?=
 =?utf-8?B?eUVRTXdxc1RpdnByeHZrYStRVkN0c3NTaWR4Q1V0dFdtVzhOcW0zVmtyckpv?=
 =?utf-8?B?N3cvMkJlNjhncUNpL1VidVd6c3RQYUxkRmZYbHBoN3dqUjdKNlF6RGttaU5D?=
 =?utf-8?B?U3kzSkE5VmZldVJjTmJraVNtYWZoTElLYVdGUmhQSndDazFpRnpEazlwcnBY?=
 =?utf-8?B?SkpscGtCUEVNQmlBMkdjdHpTOXA1K1M4NXZwWm0wc3FlTWs4TjZaS1QrWmFD?=
 =?utf-8?B?Q3d2QmREMGtmeDc4MHRQSFZUbUtRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lPRjRrDjJfUif2zp0ZAQReGYFGBt9DC6Kk1IaAcTStMG3ht1VCL9T/hjg59J7wkkxqL4ZO03D/+OII7ykXZLzPlcjBzohXEAAgRTa3Ngow9T6t0pGDcJh+1PVB54zM1o3OFJ8y+KRk+KPdIsIDP6k4EqKVJ/UjQOkJxxidNN0d16hnsKsgS+qHfce3s697o2/7KqcaL3d8VbVJkWea0QxsWKrsa0hb4ML9j9NA0YWoFPnc8zU2iFLKOfwiLWK9NCHHbzCKNbnwjplf0evo//u/ItaUEGYl3xJYFUxTZapM+Xm1Z6VeuaRT2buOSg/wSIRXK+MvntfbOs/DxFzQcGfjinIHEDutLFFrVTnda4hKtYcxypGkmNb0VpmPtsa1bfK6+WoxLwaMc6LCgxxFle4rlQObg206uP2yKbdHSgkvQPDwjTLvtOhrAlpI1FjG0r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 12:13:23.8128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0ad87e-8dc5-4b15-cec8-08de64aff5c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8006
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drm_gem_objects_lookup() can allocate the output array and take
references on GEM objects before it fails.

If an error happens part-way through, callers previously had to clean up
partially created results themselves. This relied on subtle and
undocumented behavior and was easy to get wrong.

Make drm_gem_objects_lookup() clean up on failure. The function now
drops any references it already took, frees the array, and sets
*objs_out to NULL before returning an error.

On success, behavior is unchanged. Existing callers remain correct and
their error cleanup paths simply do nothing when *objs_out is NULL.

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/drm_gem.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index a1a9c828938b..862c9b2b9c0c 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -775,19 +775,21 @@ static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
  * For a single handle lookup, use drm_gem_object_lookup().
  *
  * Returns:
- * @objs filled in with GEM object pointers. Returned GEM objects need to be
- * released with drm_gem_object_put(). -ENOENT is returned on a lookup
- * failure. 0 is returned on success.
+ * On success, *@objs_out is set to an allocated array of @count pointers
+ * containing GEM objects. The caller must drop the references with
+ * drm_gem_object_put() and free the array with kvfree().
  *
+ * On failure, *@objs_out is set to NULL and no further action is required.
  */
 int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
 			   int count, struct drm_gem_object ***objs_out)
 {
 	struct drm_device *dev = filp->minor->dev;
 	struct drm_gem_object **objs;
-	u32 *handles;
-	int ret;
+	u32 *handles = NULL;
+	int ret, i;
 
+	*objs_out = NULL;
 	if (!count)
 		return 0;
 
@@ -796,25 +798,34 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
 	if (!objs)
 		return -ENOMEM;
 
-	*objs_out = objs;
-
 	handles = kvmalloc_array(count, sizeof(u32), GFP_KERNEL);
 	if (!handles) {
 		ret = -ENOMEM;
-		goto out;
+		goto err_put_free;
 	}
 
 	if (copy_from_user(handles, bo_handles, count * sizeof(u32))) {
 		ret = -EFAULT;
 		drm_dbg_core(dev, "Failed to copy in GEM handles\n");
-		goto out;
+		goto err_put_free;
 	}
 
 	ret = objects_lookup(filp, handles, count, objs);
-out:
+	if (ret)
+		goto err_put_free;
+
 	kvfree(handles);
-	return ret;
+	*objs_out = objs;
+	return 0;
+
+err_put_free:
+	kvfree(handles);
+
+	for (i = 0; i < count; i++)
+		drm_gem_object_put(objs[i]);
 
+	kvfree(objs);
+	return ret;
 }
 EXPORT_SYMBOL(drm_gem_objects_lookup);
 
-- 
2.34.1

