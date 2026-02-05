Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1A7EC1EB2
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 13:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DA9E10E255;
	Thu,  5 Feb 2026 13:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gjukWcmZ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012056.outbound.protection.outlook.com
 [40.93.195.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 301A410E255
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 13:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Up7sIfTickSOutb6d6M+GR88rTsZl7NA76uZFqvQ75HaosSqdwToxN5KfIptig3W7SMllTYn3AV0X5x8XKTtji91T/JRfGEZDW0t0GYvzIZkra+dcNOzK1c09xoz7D6qBIDKqiYTQNQ6KJNPrtt1ztJwfpZWcf2G5qM66wj3bU7ViqFEKm5gMR+ZwVgPmhenMVKNzVQR7kdRPWCvuDjkEFg0zFtJemEtvXjLqOFHS3GaAnLiTmqJqYU5k8AMvbK2r5tDSxjaoN6chW6kEJHBPystP5ivuH0Fk3/MsknteAjvt+9muU/P/8YU5QlI0jC8O5gzItXIccdJkxchZQjDhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=758bIoZmEFbJaHlAgJwlDirBn6Px50ipAkgBXzxVyXM=;
 b=ox/UoeKM3iKJH5PUMI5XGsAlJwp9nllf60DGMfdcKGgnV4/PLqtJ889q12ix82F/LBRGuKq9jMoYlTXy7fKvGuNRecGURmVKPbIH0yupQQD71lpWpxNpj5+oWw8N370KSh1bJsr84gf7CHNBDV/Yit1ddcgQz1FPvaUaf348efw9ngu3g4OMxk6h+M8tljVq2EVTilKPffps1AaUDQHbjSzTn4kMHk2Mf+qY5TsjbKMvPd4q71G8mWsRgSW+7MUgesRCpm8EN1bdUKJwdb/sQl7PwL5q0GMNaPKZXYdS44p+7nKKUY99XDJj0j4zcZxSb1oMYVsDGdo1bV6Wk/BaWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=758bIoZmEFbJaHlAgJwlDirBn6Px50ipAkgBXzxVyXM=;
 b=gjukWcmZ6mKxdrs+FBdnp6fBzLei1OGL9tnz67F2muYHVT3GKQ4dfd7XEX+DBwqwBNqrwHUvLvxmBn7Ag6QXHDrL/uQInIiGLjyZsl1CGnKhptLoURw4L7dx1XLT7lNfhgDC4TXcOfoDVQWVkD1n+9kTVWr1yj6NM4anaO2Msd0=
Received: from SJ0PR13CA0195.namprd13.prod.outlook.com (2603:10b6:a03:2c3::20)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 13:56:53 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::72) by SJ0PR13CA0195.outlook.office365.com
 (2603:10b6:a03:2c3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 13:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 5 Feb 2026 13:56:53 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 07:56:50 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH v3] drm/gem: Make drm_gem_objects_lookup() self-cleaning on
 failure v3
Date: Thu, 5 Feb 2026 19:26:17 +0530
Message-ID: <20260205135617.288153-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 3244cc36-9037-4459-e1c9-08de64be6ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djg0K0YxR25mMHNuTVRINWZJa3o3NGFUYlRkbEhFSUdHTDlsdW9KVmRoUnBD?=
 =?utf-8?B?cGJmeUJJYzF2bUd3QitYV29IaXRIVkpndjNLRkxWaTJrUzJRRkRnNk96a1VE?=
 =?utf-8?B?UDhQK1ZQb0U1emxIM0dzem9mNU15R1ozbWpiSU1rSnZna2FUR2NUY2ZvcGVq?=
 =?utf-8?B?R3hsTklrUFMwbm5aSW5pTXBKaFF1aXNEUjBGck5NWk9oUks2TnUyM3E4MEdl?=
 =?utf-8?B?VWVsOXRrV01ReUM3TTh3MG5GWWdmWnVic2ZGSm5hN1NBLytuU3FTOEVhTjdZ?=
 =?utf-8?B?a29DU2NGbVFmcUh5M2RRTGVZZjB2N0xISU5CeU42ZGxqQ1RudzZKR1NhZjlW?=
 =?utf-8?B?RlNPVSsxSExncGFWK2djWERWV2t6UjhQNlhPUVR6N0pIbytaU0hwdmtFT0FN?=
 =?utf-8?B?Y2JETHZwOGF6ZkJDVEhhSTYrdEdaZ0Q1c3pRbGJQakxRVGFHeVF1bDBVaW5Y?=
 =?utf-8?B?Z1AyY2xiRzlUTWUwMGdEd2hsOExkUTZXd1k2alNKYUlZSXJ3NTZJOTBlaTZU?=
 =?utf-8?B?NkxrOHV1UDBQeVJSYjBkRWViL3RFeFczazY5MUNnY3VWdHp5eW10MmJ1dXBQ?=
 =?utf-8?B?Q1BOYytqd3F3YlQrak93dk1TWGh6bnhkOGlWZzFicFR4bG5WRWFHTDVTTFRi?=
 =?utf-8?B?Z0hNMkxYbXhmUmNrUDZjWk1uZlVteUNGTitCaVJ3MEVYUHc1dkZ2Qmd3dSta?=
 =?utf-8?B?WXpXSkYwSEtrYXV3bTFPNkMzTjFvYlhNRGloeVRLMDJmb2NuUDl3aXowTjlH?=
 =?utf-8?B?NDZkNmY4c0NFT3FiVUZ1MGgyRmlqdGM3WGtld1I3VU9HK05kU01EOGs4Y0dz?=
 =?utf-8?B?TXpyNlJyTVBhRXFtcnlkU2YrK0pxM0hCcXNINWVkUHBVQ3AwT0R4UkNsWTVW?=
 =?utf-8?B?TTBsK0dnT1h5SHVYUVZraUhLWEIrZXR5N041WlpFbVNjWmc5MHFhQWxMam5i?=
 =?utf-8?B?dEpxNDJOVzBib252Z0FvU0NuYXo5MTBmNUxORTZSYnlyamwreThMUG05V3ZE?=
 =?utf-8?B?d0czaFYxeXYxcnRmbXV3T1FIQjhDT21YTE9BR2tMYTlCWFlrRzZsOGk3bnFp?=
 =?utf-8?B?bi9sbkxDZVVxRlRXRlNGMkhubG16Q2NhR2taelRPc3c3bFhoYnlqbkJLNTJW?=
 =?utf-8?B?ZUVubHNySWdFMVBJdzRGSWtqZUpsSGhqKy92WGZOZkZyTEc2QTcvSjFuczNx?=
 =?utf-8?B?aEhsK1c3NnVHRFB0SVpxTGNiNlVpdjIweWgrcXp0c0VTeno0SnNzeUNiaTkv?=
 =?utf-8?B?S3ZWeFNuTWxWV3pNSzhQYVNKWWo4WFF6bnRLNmJPOElTTDlETUtrZXFlZnhW?=
 =?utf-8?B?cVpWK0ZxRnNaOUdFRVlnWTdhQlNsNUp6Mm9CeHVwNXZWWmRCWW9WUG1EUWZs?=
 =?utf-8?B?ODhyclZIOHpIbWR0aHdIZEVrV0JEWXFEUExvTnovQ2tKTExqNE1DRC84a2F5?=
 =?utf-8?B?ZzNoWWV6ei91R2RqL2ZYWmRiV08zaEpCZEtFbmlIK1FkWS9rNzcxbG4xaGk1?=
 =?utf-8?B?eDlQUkFLL2NHUjlMSlhVbkRmYytvc2dvamQwMFI4Y0IzVzF4dFNVZmhVZVdv?=
 =?utf-8?B?cFRwVC91cUtkcHl6dzFjSlZyRlZoUjJHbTBzK3BZZEcya2E4N0hpT25lQVcv?=
 =?utf-8?B?dmdGV2c5UjByNStza2R1dlRqQnBsdVRwWjJmaTlRL09IQkoxRWVvQW51anVy?=
 =?utf-8?B?YlNKVk9Zc3ZBOThkdVFRNVZvb3ZlbENzVnNCT3g0dGRzbGtNNzlMb0dwcHQ1?=
 =?utf-8?B?Wk51Z3F5OWlRSWY2dThYNk9yRHJCY2RUL2ROdmh3UjJXWEVibzlqNFh4cThv?=
 =?utf-8?B?OUdPYjBHc1cwTG54WktIVjR0UFVCbDBJblZkUDltRmlJcGFJbzZjbFBvaitW?=
 =?utf-8?B?aUxEbHMrRDcxa1FTdWozV1A2NXlwVmhYRitaUXBYY01iWnVsQTBpMmZ5ZEQr?=
 =?utf-8?B?M1FJcXI1MmtDb2kyVFN5bUpac1A4TW00bHNvclhHa2xxbXZkVG9aV0NmbURr?=
 =?utf-8?B?ZFgzMHZhQWZCZWJXcWovcTVkM2tVZ2JaVGZucG5jWm1qdlVsL21zQWxFa01u?=
 =?utf-8?B?cS9tM20xRFhZRFlvWkR6TlNzZHBNTEtvenpBRklPYWU4VzE3K0QyUkNiQUsx?=
 =?utf-8?B?YWU0a2NUWUdNUExrd1poWEFGdm9xSmhWY2t0ZEhoL0VPSi8wY1J6Q3lXZFYx?=
 =?utf-8?B?KzUyUGhQZlcvWnhHNnM2aGkrWGtxUEs5RDN1V0xqQ0JvSXZxclI0K3BjeXNX?=
 =?utf-8?B?S1pMbndjZ1Uzc0FUcjhUK0VBWWlRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 45mfxJU/xrDcKy5VO5PKjA3Ews8Zh/p114pN459tVWRa5KsN370ZmoCq2SPblOLD3uyrtQVTQothxj/yEVa71caGGxUg+E6s0Ad+jCpEZvdzR+GTMjvAkVsFv1a38SMSbxDbMk8Bz/Az9TPC1JXdPyFZB+YBCr/sZjWJC8YjfgHyZmZXhGYq+m2G5DYg2VE5URlK3SN8Sv+gVU/zzEZFmLJvq8iflmNXJn7eQ5LRrwmboWRMhJI5uFImBJAM9sKEcBb6NDvGbvVEQlTX0VfXXYBIfjT7NtXlK2tkfaJn3SDwrTpbZnazpLCgMW5BAHFiN/ljTZWcONBM46o+RbJIyRKWZO67SNIO78e+4AgIqdzONIii1cFjHr1RjSJbxlt62AK2n6OmgcNQZn0OQ5pPqY1IPxlCW92j3osHv29gZp5SWOK/fG21yCPXIcTnRKSE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 13:56:53.0558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3244cc36-9037-4459-e1c9-08de64be6ad1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231
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

v3: Move partial-lookup cleanup into objects_lookup(), perform reference
dropping outside the lock, and remove reliance on __GFP_ZERO or implicit
NULL handling. (Christian)

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/drm_gem.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index a1a9c828938b..da18e49a8bde 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -759,6 +759,11 @@ static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
 	}
 	spin_unlock(&filp->table_lock);
 
+	if (ret) {
+		while (--i >= 0)
+			drm_gem_object_put(objs[i]);
+	}
+
 	return ret;
 }
 
@@ -775,9 +780,11 @@ static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
  * For a single handle lookup, use drm_gem_object_lookup().
  *
  * Returns:
- * @objs filled in with GEM object pointers. Returned GEM objects need to be
- * released with drm_gem_object_put(). -ENOENT is returned on a lookup
- * failure. 0 is returned on success.
+ * On success, *@objs_out is set to an allocated array of @count pointers
+ * containing GEM objects. The caller must drop the references with
+ * drm_gem_object_put() and free the array with kvfree().
+ *
+ * On failure, *@objs_out is set to NULL and no further action is required.
  *
  */
 int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
@@ -785,36 +792,42 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
 {
 	struct drm_device *dev = filp->minor->dev;
 	struct drm_gem_object **objs;
-	u32 *handles;
+	u32 *handles = NULL;
 	int ret;
 
+	*objs_out = NULL;
 	if (!count)
 		return 0;
 
-	objs = kvmalloc_array(count, sizeof(struct drm_gem_object *),
-			     GFP_KERNEL | __GFP_ZERO);
+	objs = kvmalloc_array(count, sizeof(*objs), GFP_KERNEL);
 	if (!objs)
 		return -ENOMEM;
 
-	*objs_out = objs;
-
 	handles = kvmalloc_array(count, sizeof(u32), GFP_KERNEL);
 	if (!handles) {
 		ret = -ENOMEM;
-		goto out;
+		goto err_free_objs;
 	}
 
 	if (copy_from_user(handles, bo_handles, count * sizeof(u32))) {
 		ret = -EFAULT;
 		drm_dbg_core(dev, "Failed to copy in GEM handles\n");
-		goto out;
+		goto err_free_handles;
 	}
 
 	ret = objects_lookup(filp, handles, count, objs);
-out:
 	kvfree(handles);
-	return ret;
+	if (ret)
+		goto err_free_objs;
 
+	*objs_out = objs;
+	return 0;
+
+err_free_handles:
+	kvfree(handles);
+err_free_objs:
+	kvfree(objs);
+	return ret;
 }
 EXPORT_SYMBOL(drm_gem_objects_lookup);
 
-- 
2.34.1

