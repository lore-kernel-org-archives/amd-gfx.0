Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFF6C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 12:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6925764D73
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 12:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6925764D73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D28406EE17;
	Thu, 11 Feb 2021 12:26:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EEB26EE14
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 12:26:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgyAzBlGLy9dvLRWZaF+ATu6kvSispFkD+NLi7EONw2iY6QeRo9/+UF7HIhu8jgVV0L230XZhrRa/1mxMo5bm06NgX+w9nAimT+4G9ZRc+4nNjiBCat/hfMxvAd9c1z3/gMUz0R83/saP9iJYYjdhav6E23JogNnM8IOD2DLuquAnX5NA2sMvaAPzPmyGwNs67HVkQlyQ8cql0qEFImzv8/YdwzlNEW1BKSAX3AZNhgRpC72IJ34PxqwyKgAhTPJbzm6P0Pdl7SkttUD7GpmwL6P0eHgOqPWk/mRtfRf+65PHIEhPE2Krbs9RhHgsLe5Mdhoz5ojyR0OSEhAkQ5e2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfRidvRJ1TrRg+OXLxZ8M57GRlEiTwNpgEYDYPeXP6Y=;
 b=YatFWSS9xg5/HAuf0f7gmtrMilNNrq6vqybro2dCbmC75MyFla3W/defSARLnSFZeQhXCiLiDRoksJeBS0UmZHpcW9l/BUYeb3uhZDcuClJ9HNk/y5SE0+m/cC4hcsI/iGpm2s/D5nuph8q0El77w07oXdZBF9XTVrscIFHaqMobQulQkEODUtG2dqDNN33yeR86DpSERlqNF42yYyfib0fg1TpVb+J2qokN3gmC2qLVgQ4S3GdT6FjcaV7q5qyJsdKIDVTdqIsAwr1e7tIuM0VY0OhsaHI3/tE4LPcgEm/RgJEPrecRCvVraZT7Xvj+Elz7MmAhHEpViMUzTSvmuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfRidvRJ1TrRg+OXLxZ8M57GRlEiTwNpgEYDYPeXP6Y=;
 b=GAdSf315p26L27aHH6irAk4zAbaKXcQxKUqbHSN0dkAggEhcRDMA4P3axoItlqfEIIiqGbznGCiUpGvEAFp+q7hDXbcJgck2GgixJ4Y0EZQxd7j8FHbiXVlC1ioiOS7F1kp96scctT8ntJLVxqFD6HYVaW5hdURI4MytkqPFreI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1196.namprd12.prod.outlook.com (2603:10b6:3:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Thu, 11 Feb
 2021 12:26:21 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 12:26:20 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 2/2] drm/radeon: cleanup debugfs
Date: Thu, 11 Feb 2021 13:26:07 +0100
Message-Id: <20210211122607.36991-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211122607.36991-1-nirmoy.das@amd.com>
References: <20210211122607.36991-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.97.172]
X-ClientProxiedBy: AM0PR03CA0026.eurprd03.prod.outlook.com
 (2603:10a6:208:14::39) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.97.172) by
 AM0PR03CA0026.eurprd03.prod.outlook.com (2603:10a6:208:14::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.27 via Frontend Transport; Thu, 11 Feb 2021 12:26:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 68a0cee7-5fdc-4589-4ca4-08d8ce883ce8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1196:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1196611BE61E02CC831F34F58B8C9@DM5PR12MB1196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:82;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N38+BcUQbA2n7Fx4Mu1soUvOTxxqxrifQjZMmmCjLmI33o7lufcTfkPU+YvS4aRUGB9BAN49sMkNTM5bPiX+sMFCtoH38gKXPqL/gyePkhTqzG7uA07ZTW/8WFgGtCaYt8LXQvAKafbJyiVZvtL4CptfrqXknpsVweglYU792pI8Q893h37taC0+nx4luyavXV80vN5CxewHheHYKh85SpffgF9FjBgjv3ZcoHl11HR9oNFj+nQPJqdmfAD8OYV3TX/1i/yM16aqQzBbVmmjyeMEMJVGYflyfICMm0lChjEqML1V/5tCSlxmoykzdmVFe5fy7A52DctFnvkeysUOv3G3BhxKLOrm4VskrYb4WbZte86AG58sRWdJO0Gylq9SPiJpRKUfjsnTCsz5E05m9zZlfB+2fvFvoDJthZZ44fqXdaPl01Qv7j8TmDKIQ6+h86kPNlZOrhrwHNb13eup3j3yNNr6CgU08XevA1QoxZJ3WaNyDGGAXppRcKUGdI2LTquAqiGD9JlcwqCpnBKqew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(44832011)(478600001)(83380400001)(1076003)(186003)(36756003)(34206002)(6486002)(2616005)(8676002)(4326008)(5660300002)(8936002)(16526019)(316002)(6512007)(6506007)(66946007)(2906002)(37006003)(26005)(52116002)(6636002)(6666004)(66476007)(956004)(86362001)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PdsdWNiWvju8gT7zQK62+v1Y4ENes+LkPth3dWmcC33e7HH2WwKaHoVgtuv8?=
 =?us-ascii?Q?VoOANasiBH+QE36ECqL8SW3lxi1NV2kPDNGMg9Gs2JxccVXDeSBK65twRLiz?=
 =?us-ascii?Q?2t7IZxI7ILoyQzwczrnDmXZ23zdj5WWb7YeXNbm6E9H9po62ehJFSqndH+FI?=
 =?us-ascii?Q?joRjjEms1fhOfRWzlQioW8VuZ5b4dLLYU7jKF/b9eMN4GNgqwsZ/YX3zyeW5?=
 =?us-ascii?Q?DKlFbgX2I/qtvHrdedfJ0opFnZ1/PhNTtDO4ZQWsUrd7tzOvRhWmoUZDE2ST?=
 =?us-ascii?Q?Sms2iMnFppw136ef4Jqa8xabW9d8RBZO4mhl0DT8zEjxh4BnHrb7ugkUuirZ?=
 =?us-ascii?Q?wJYoXa1yMsc2NubgiVd6n0cI3SgsWPdtoSWhtRYqqapB64x/cYnfKkTGc1cQ?=
 =?us-ascii?Q?tPnmXf43HtTCzSs9MvqwZRoO6IrgWttOdMzGQD/q6mC8d9AAQyAlKlqeM+X5?=
 =?us-ascii?Q?mRoK3ZtRW4jnMHABsEBQdzaVOqmp6Fqpblno+cnS8Zl/iybjMflQ8aSi+c4v?=
 =?us-ascii?Q?ON9MHzwCx9Z64ePvGlHAyzGKKPqUNNYNm3eeDREP5N+0OBFQemFf7kdjkzTi?=
 =?us-ascii?Q?LfeUyW4TN4YV3yxyW7QEh4JsZPC8HLx+xIfqm4A1OujE1/OlUoE2/SVL/pAH?=
 =?us-ascii?Q?iFMGKhgLkAGgH318hdI7z7Wn454764aGo8xb9v8uRdBZ1+E5wa3yd/ARgOw2?=
 =?us-ascii?Q?8L0RFKEhGEafKo7W3E81kdSYFKWRksJdYD56ZthlefN2+/6EZpD3xiXi+ytJ?=
 =?us-ascii?Q?w0aa4SHnnUtEolO8Zorxumco4x+mKazYasMc7MyA/OXA+I5iDblhZBwg9RR8?=
 =?us-ascii?Q?p6WmrpJvA0ikP+ptEEnDAKbWVcyhRYu847Po8Op+N6CZhEy90WLAdE7zJnSp?=
 =?us-ascii?Q?Isin64rGghnPbUOP8D1tDzsjS09Ek7hlN4JTHfNASgVfAc1CGueehdJkSTO/?=
 =?us-ascii?Q?J0vQvGdvnpBKEvpdQ5jKeYNp99mVpG7F70D9Mzoy3dHD2HiQKA5McRwncSUc?=
 =?us-ascii?Q?A+iogNmzKjWCT8uVefz40r3Let+xZ7G8kaCC1j6U/2ZCge59RC1BfKNGx6to?=
 =?us-ascii?Q?+QisXSj3NvFcTx7ACMFg+RrdcSjv3ob1gBNncltWrP+G1nDQxoDgXflNpTdg?=
 =?us-ascii?Q?+ksmmN0935Z/KU1vSrtw5DjNkfp6KgI5Fh/jpLuUet/Y7jKBlW1+AZm7HKVh?=
 =?us-ascii?Q?QybEMmndn0uiCVwecWvroy4cjfrJymMbntdqi6UbOiCGiv5I5+Py+UyvTnMY?=
 =?us-ascii?Q?CpkDIsnhyRNdCLA16DHKvTibaDvBPEp9ScP+/QhBHkIM40i5kaxWl7kVphoA?=
 =?us-ascii?Q?PKUeG3LGwKfNo7bzu1VHqol5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a0cee7-5fdc-4589-4ca4-08d8ce883ce8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 12:26:20.8964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4NFziL2ahvL/qSF109Vx/ae5sXDPe/kgih04KAYrNbDy0wUFBTHwULV7/h17CSBRNnDd/Abvgs16jwQFmdKYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1196
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove unnecessary debugfs dentries and also radeon_ttm_debugfs_fini()
as drm_debugfs_cleanup() will recursively remove debugfs files.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/radeon/radeon.h     |  5 -----
 drivers/gpu/drm/radeon/radeon_ttm.c | 24 +++++-------------------
 2 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index f9f550784590..2c0e3e7c294d 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -454,11 +454,6 @@ struct radeon_surface_reg {
 struct radeon_mman {
 	struct ttm_bo_device		bdev;
 	bool				initialized;
-
-#if defined(CONFIG_DEBUG_FS)
-	struct dentry			*vram;
-	struct dentry			*gtt;
-#endif
 };
 
 struct radeon_bo_list {
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 46bf835284f4..9d156b12d24c 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -55,7 +55,6 @@
 #include "radeon_ttm.h"
 
 static int radeon_ttm_debugfs_init(struct radeon_device *rdev);
-static void radeon_ttm_debugfs_fini(struct radeon_device *rdev);
 
 struct radeon_device *radeon_get_rdev(struct ttm_bo_device *bdev)
 {
@@ -793,7 +792,7 @@ void radeon_ttm_fini(struct radeon_device *rdev)
 
 	if (!rdev->mman.initialized)
 		return;
-	radeon_ttm_debugfs_fini(rdev);
+
 	if (rdev->stolen_vga_memory) {
 		r = radeon_bo_reserve(rdev->stolen_vga_memory, false);
 		if (r == 0) {
@@ -1009,12 +1008,11 @@ static int radeon_ttm_debugfs_init(struct radeon_device *rdev)
 	struct drm_minor *minor = rdev->ddev->primary;
 	struct dentry *root = minor->debugfs_root;
 
-	rdev->mman.vram = debugfs_create_file("radeon_vram", S_IFREG | S_IRUGO,
-					      root, rdev,
-					      &radeon_ttm_vram_fops);
+	debugfs_create_file("radeon_vram", S_IFREG | S_IRUGO, root, rdev,
+			    &radeon_ttm_vram_fops);
 
-	rdev->mman.gtt = debugfs_create_file("radeon_gtt", S_IFREG | S_IRUGO,
-					     root, rdev, &radeon_ttm_gtt_fops);
+	debugfs_create_file("radeon_gtt", S_IFREG | S_IRUGO, root, rdev,
+			    &radeon_ttm_gtt_fops);
 
 	count = ARRAY_SIZE(radeon_ttm_debugfs_list);
 
@@ -1029,15 +1027,3 @@ static int radeon_ttm_debugfs_init(struct radeon_device *rdev)
 	return 0;
 #endif
 }
-
-static void radeon_ttm_debugfs_fini(struct radeon_device *rdev)
-{
-#if defined(CONFIG_DEBUG_FS)
-
-	debugfs_remove(rdev->mman.vram);
-	rdev->mman.vram = NULL;
-
-	debugfs_remove(rdev->mman.gtt);
-	rdev->mman.gtt = NULL;
-#endif
-}
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
