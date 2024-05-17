Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161C5C04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 May 2024 03:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9696B10E262;
	Fri, 17 May 2024 03:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QdwoCJ4Y";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B65C10E262
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 03:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHlVVkJ2k+m7bog5eJwf3SPLEYqjB9CGGBtxfOg0D1xy1z59m1nVGZ9dDSoJbM/A2fSRzZsyj7rOQymsSjnnsdw3RbyWNyvv3pe2kUrCzkX+SLHE8Guxjfxe+ES3lBtAlkYczjvJsXn5/4wcNI7HdZ9hTM2UeRXaRcoqmE6wKBYUknAE1kLdnZlX6/dGNVfJ5asZluaOIpCQH0U30kA9Ihs1iokhRBCtyblMyIJRxigmFAArKzICFksND7G7axiYqlkVCtkG0cmKYTVYOc6orxKklktjEwg9SaCYEP85DbNon68743U7DVfiVWfQ2/USbCu6UondXPVteOblKtqSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hEaJdNM328W86jA66DC1M8Gx856HA/gTpTK+MalL9k=;
 b=gde5EG8tWRWhIBVXYrXWrOB7kx8BAc5xPI4cp4kgpisa2XWWauA+Oo6iqHvceO55St8IWecWnbA17M6lPewvqBsGYTsEyRAuKLuqvsS+xnuLj1QT7GVW5SVPh6ATvvg2VBkwWGbyXgjQ4sd9w+kDFw0Cxystb0tGY67p9pGfYjSKKLZS1UNqg84a9qS7VyUtTmcULkkg33oJ0MSo/mDd5kNZlx6AMdsUY4LZ0DrtrVKyMie4CkhJXH6y/CVXPijt4bLANmfTnI+kld6HnAPeOqmpe7o8Vl3FDyVwvL94pTs1u8TuSEj6okcGZi3phKDRLDY6sm0cGAYGhWnHDJlmzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hEaJdNM328W86jA66DC1M8Gx856HA/gTpTK+MalL9k=;
 b=QdwoCJ4YigBakgAXtyZNGUqiIrQIPeVrF9do8GuiJ/xqLPGWMb8Nel+msEP9AGCYLgZoomSYWf0GeYK6Phu8Ntvgm+qs+SwXCczgZxpt3jnKGhI7Sb6x6YXauAr3aMMGDsKXchwxuybFtH7lMnChuv0is1X0ZPqI5cyTeCbPsEs=
Received: from BL1P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::6)
 by DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Fri, 17 May
 2024 03:41:40 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::f4) by BL1P223CA0001.outlook.office365.com
 (2603:10b6:208:2c4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Fri, 17 May 2024 03:41:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Fri, 17 May 2024 03:41:40 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 22:41:09 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: change bank cache lock type to spinlock
Date: Fri, 17 May 2024 11:40:56 +0800
Message-ID: <20240517034057.2015624-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517034057.2015624-1-kevinyang.wang@amd.com>
References: <20240517034057.2015624-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|DM6PR12MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f38a19-2de4-44ae-6034-08dc76234358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4RM/YZ3x+6Z1rHaQ4k0W9qP973hMnk1sX4Hv/KAaORfw8IphRStjWJ6Se0VK?=
 =?us-ascii?Q?lH6IWdq7V9xv+8aGqjnMEf9zWqLQJYmBKynMmH2/9uEZyA+mQEa5Mx6JQG0D?=
 =?us-ascii?Q?4pVL6cADtKxx7kwV/4PwRuzwUpYi6MniSfQ2UZb7WNdWxurSqHGu6bKJNecf?=
 =?us-ascii?Q?wY4TXdyzQ17BKP3Rukoikw7T8LGIgmq3tcM3JvUIleFkzpMxS8YIpZC2i1Sl?=
 =?us-ascii?Q?ftCd0TWVMp6De/RZhrgN1xIiFVYn55Qb2ytyUP57Hg6dYklMV0rZgAc93I7v?=
 =?us-ascii?Q?w4HJVUJDvsM5GJdhJWt0uLjjYQI32hOEPdyQ7SSN4yCZkc6JZ9Z2XItweJYt?=
 =?us-ascii?Q?QcNdohKA/x+cBsRGfUpT+yQzW5op7jIPMyFegjkipaX2iEkd9Sro4EK2vuFS?=
 =?us-ascii?Q?jRh+TXxbnFaOtVceYp7efGnVTuy4gAX5U8Gk94ylSWw7N8CL8R+KuxoY38VN?=
 =?us-ascii?Q?8vHH4hGjOBEaex8O714ZoP57p+t40GLDWfyboC3rxKOiQRZuw2/1CsOcCB94?=
 =?us-ascii?Q?KqG1RUaNcsmkiDSHbn/IyqJCEw88toEVStNu6yvYZLW+Ize6iUzaRCFAMOHZ?=
 =?us-ascii?Q?kWsoo19p5L11/rgHFhebXZTCl/HUEDVZxHUticjTzIGjWIgm+NjTTqe9TJ9J?=
 =?us-ascii?Q?pMPi7Z9e3vrlPmjc5MFVpasxqFBUzZaEUbviFwFhBkFUcomy4HDZpyPOO9CZ?=
 =?us-ascii?Q?nE9voroF/xTgIQ+8PmlK07Km5ed87B4oNm3odOO0alXUVGbtZG9u2OqK6+rk?=
 =?us-ascii?Q?NN96wqX2+fcNbaOQkf8DDVC6QCjTs3G8z877xl0r+pMGjIafpKTOnChMQIYk?=
 =?us-ascii?Q?+T0O16l9c6LefGfDYuryWlET1bz/kPjiYx6dE/+aST8z3JpJ+SwhRCLZFm23?=
 =?us-ascii?Q?GJr40106Y7J1JPGDdAtDC0NWGC2ufIFbhYdZmLmU+09XBA8zHpA0t5+Qszpv?=
 =?us-ascii?Q?V6AyRP4mzfBzW1bAuMBow+t71O1Yw+Xr6XJSfPA88K2HyxcpQSMTnypDPwmj?=
 =?us-ascii?Q?4dWb1J+qU+WyHxOzB2m0RuH7fBy+Oy2Hpl7noL1nEiAWVr5/pDzS/J0zUV1S?=
 =?us-ascii?Q?bonnAoSJtIrVJ9txF/W+IOdXJa5Vf4dw5QwAuXdKoRW5zlSlA2rm0WX4Br3+?=
 =?us-ascii?Q?3zH3Hbtrao8Us9WqeKOXgDD94OuoD6HtrRqFSO6vMMU3OtueHBPGfIMcg+ir?=
 =?us-ascii?Q?tZnrh7YGdZQ9MeIMB3UtZ4wDF1gmgHpVsg67v6uJk7QRpbYRTMB1xfisoxZ3?=
 =?us-ascii?Q?rOvZrPKC9ZTMKXZmCQ+EW4mRsyD3wB2r68KBKy9TyuAjLga+N/OJQUVpS6Bm?=
 =?us-ascii?Q?qLaJauIKiwkpN35wBGyEt+Wj3+R7nW2uvDm3JboBHGUCqdRZCZxAygEI/AYT?=
 =?us-ascii?Q?syBWRqT4aiid2T0jjiLkVMhWO3Cg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 03:41:40.5097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f38a19-2de4-44ae-6034-08dc76234358
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330
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

modify the lock type to 'spinlock' to avoid schedule issue
in interrupt context.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 11 +++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 0c9a271c5028..f743fd6a5a13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -233,7 +233,7 @@ int amdgpu_mca_init(struct amdgpu_device *adev)
 
 	for (i = 0; i < ARRAY_SIZE(mca->mca_caches); i++) {
 		mca_cache = &mca->mca_caches[i];
-		mutex_init(&mca_cache->lock);
+		spin_lock_init(&mca_cache->lock);
 		amdgpu_mca_bank_set_init(&mca_cache->mca_set);
 	}
 
@@ -251,7 +251,6 @@ void amdgpu_mca_fini(struct amdgpu_device *adev)
 	for (i = 0; i < ARRAY_SIZE(mca->mca_caches); i++) {
 		mca_cache = &mca->mca_caches[i];
 		amdgpu_mca_bank_set_release(&mca_cache->mca_set);
-		mutex_destroy(&mca_cache->lock);
 	}
 }
 
@@ -456,9 +455,9 @@ static int amdgpu_mca_add_mca_set_to_cache(struct amdgpu_device *adev, enum amdg
 	struct mca_bank_cache *mca_cache = &adev->mca.mca_caches[type];
 	int ret;
 
-	mutex_lock(&mca_cache->lock);
+	spin_lock(&mca_cache->lock);
 	ret = amdgpu_mca_bank_set_merge(&mca_cache->mca_set, new);
-	mutex_unlock(&mca_cache->lock);
+	spin_unlock(&mca_cache->lock);
 
 	return ret;
 }
@@ -488,10 +487,10 @@ int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_blo
 	}
 
 	/* dispatch mca set again if mca cache has valid data */
-	mutex_lock(&mca_cache->lock);
+	spin_lock(&mca_cache->lock);
 	if (mca_cache->mca_set.nr_entries)
 		ret = amdgpu_mca_dispatch_mca_set(adev, blk, type, &mca_cache->mca_set, err_data);
-	mutex_unlock(&mca_cache->lock);
+	spin_unlock(&mca_cache->lock);
 
 out_mca_release:
 	amdgpu_mca_bank_set_release(&mca_set);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index e80323ff90c1..c3c184c88dad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -84,7 +84,7 @@ struct mca_bank_set {
 
 struct mca_bank_cache {
 	struct mca_bank_set mca_set;
-	struct mutex lock;
+	spinlock_t lock;
 };
 
 struct amdgpu_mca {
-- 
2.34.1

