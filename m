Return-Path: <SRS0=AKuh=J7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9A7C43461
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 21:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FD8613C1
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 21:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FD8613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A6466EB95;
	Tue,  4 May 2021 21:48:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 831076EB76
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 21:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNfLkmNvx1q8h3yJPcZot3wS31WqGk+7b+KrksV8fj0lVDQ6KmvOI3MdwEO9QhrtLxERZiyTnBpCXrljXK7Fn+84fv1JTCVJjO7v1JyP1nllnG23MKIyxy3C50Imosca7qxs4mcC0kps7zNfVea49AzSa0noCx3mJRj4v5b/CQHJCgz3qCSoJjkORSRa7um8M8TJbg/bU6AfkDCWAv/1MwZxidcUTRQxHneAtXTKKSUt1K6RX3xDnM4aqC3sMpxdr9uF9eiAVvoy9VVJfVPcwbBQlEN7/Yc/b6N5AiEkiqw05Rf8nzCkLhwhN9IHeDVz8dwOKob4J0iKuyAWPHBEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lHnX5c4uhI5OvHMq7hdswrFmYBTJmGQbSruRdl1eMw=;
 b=EZ9nZInz3turvKHh5/zDI+jZr23NAttfujDNcuqL06oy5Xiv8CY7REXxKszyJ0HMNQ+Vem1cog4UTdRW6YLxdIoh6oGo6Niq2RVaCCu0BqStVeedQy9S2XhpBhEN8xWDHehm/IoH08HfjBTDkb7Z8JVn8qHWisWx+9bhSqkFClLe3jvnzMy6v8TQN3RYxNvVHhX4UFKvl/8iyJ0+l+KWrmSoB+LV/L3bqX6EtR8iiagzKkxWpXfUSdCWtWiO5D/+e4RpgNNF4YD81wcXs87nbI/44p2E95izrd0UdKVRBbDq5/d2YELJW7TTMmY9rS6caOfGn+ZkiMeQWGkBrPgdeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lHnX5c4uhI5OvHMq7hdswrFmYBTJmGQbSruRdl1eMw=;
 b=bVjcUSNa9T9j/qRphcEMh79iPw+jSUu26Ln3XF5OsQLn+tEcfH3MFsxOuxE0B6mglnPEvtAO7+mMQz7YVmsGyRGIIQnSLZcs0amN98j2hVOu0vuN8i1N3T2ox26y0ev6JrQ/lq0+3nuEc9ebSO3PuXoONJ219tQbOshHg4rjQ0k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Tue, 4 May
 2021 21:48:22 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4108.024; Tue, 4 May 2021
 21:48:22 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: Rename to ras_*_enabled
Date: Tue,  4 May 2021 17:47:55 -0400
Message-Id: <20210504214756.3816-4-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.0.97.g1424303384
In-Reply-To: <20210504214756.3816-1-luben.tuikov@amd.com>
References: <20210504214756.3816-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::30) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.38 via Frontend Transport; Tue, 4 May 2021 21:48:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2f472af-8ca0-4aa0-9eb4-08d90f46565e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4155:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB41557D46A39AB0D7EBFEC1B4995A9@DM6PR12MB4155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9xOvyeJXekXLi5Le7RJzoUOTy+mp+9i601ANbOY5Tf2FeWVDdlT51JlFISDZ823WMhwa05s8noPSviLazUVFGWbnY0kl8QksOkPCgUhmsdJ7+gsIpCQJx/ZuGcJUSRFOLSPB6S2WE4XzPltdei8ud46AbzqKmG9aCsrRztV2rHVWe3ulXdiw/8tPAwlV5VhZP6JX8xuiKQgqBcMND6kkZfc9Qo1xAuY/La4XgQqlc7+lNOL71+MV3s9ZVq4NwaRB/JElfiNLbdPWXP5c4EoZPUklOFAnzMl3EsrHOxIN2ADDV4DYLE08x4KxGrgRNauK9ICTQ8cmbTuHmjjpitYWe81EGkgGuT+qXHvWc5kqow4qt0ywQS3WPGc85ksx68pDE7TK1fRAQCjwXEcaFfU+24hSdC2MQa0vABKVduwfF74jLn/54HvOA2w/gz3RV4M7yhNckL40RnbSDudiE/fB96DrqQ7aseMMC+RlBPxg/LX4SeKK1z9WLwJYLqpusQPm6xWnF+qPmhHXuMlUlkOy7P/x+mEvAK2yCQDmD86MWLStJWJ2xKkZakMFWMdhiV/lMXvjZkoYv9Up8s6TZ0UldpWohMlzPI4lDkZRAtwtkpmjctlb/z4K+qYtW1NYRksQEyMEAd3pl6IUoZC5FvCV+NrgO9Zxtup5f8Dmj1Xhrt5UTw23JCMdwOg+5QjbS1uE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(478600001)(83380400001)(66476007)(6486002)(2906002)(186003)(2616005)(6666004)(44832011)(5660300002)(36756003)(4326008)(16526019)(316002)(26005)(55236004)(6506007)(66946007)(52116002)(86362001)(30864003)(8676002)(8936002)(956004)(6512007)(38100700002)(54906003)(66556008)(6916009)(38350700002)(1076003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HYySoMJLNxiRJbOjwsfiXXVSjBKEC5U1I6Ln9sGCJY2oRI1MheHTLzb8e5U1?=
 =?us-ascii?Q?C5S6ndZxWcnq4wfY9lKYiwk3Xz4MEAxpzJxhaxCLBA31JDeJFQb32WylHBdg?=
 =?us-ascii?Q?SPDh4hHcsdxTAmMRabbwariJ+58cMy98yNzwyTH/WOLQJsnnYlKzjP6ktZ/Q?=
 =?us-ascii?Q?2O0yR2VdSSRzs5nbae9RFgGAJi5PmKHmGxRHHBewXSVJACNqsmCS6JzUr+XJ?=
 =?us-ascii?Q?KLA6h2BCCvWOHuk1SFZl+G2sY7PvcVH7+aSxMl7QtFXkE/H362ZGpKdaUenx?=
 =?us-ascii?Q?usXXjYSkyXOJlVXsjJAd3g8I1uWIHJB+4GtM0C6oXmwcf1geAIUq+St/Tm0s?=
 =?us-ascii?Q?4r5fxucxTOlOUkaWwU5hZ14ft/0Cx/2ipersAKTqkMmeFPaXCMTZNc4qCV3V?=
 =?us-ascii?Q?JhuMRC1zgM/r2rRpwS28XmUagKpzPK7zPlYqm4f1OXKAiD9epKds96tfpDC8?=
 =?us-ascii?Q?tPo9Jkd4yyPYKrG+JPUckawZVX3hutsa+ZfClTxfdxy4roevXdodxBVj8xK5?=
 =?us-ascii?Q?UPZOFYuIlmmL2WemRHxiX5JWOf/39A4RgHgRZMfXo6u+alzP3A/mzXG7fjpQ?=
 =?us-ascii?Q?BTrvZgtqksGlOllNUuAZS1B3dEretqPVL9+BLKg5NLDyVEVIPW3XFg/pEfbW?=
 =?us-ascii?Q?1hInOoCi60L0vFPFNT/2Fi12uhMTC4nAXB3jU2Sa1TviJJCqXUNc5g2peQ1c?=
 =?us-ascii?Q?bbIA1QzNpwhWwNap9wEkmCPTXS92j5gBxElX+9nJZysfATxSzuiYcSndEcmY?=
 =?us-ascii?Q?9HzreGY+6PtAi1Ve5G4jLgeoBJe8KdlSQnOUhcu24d4o7PVkNEW8iE6YtFwy?=
 =?us-ascii?Q?4EPogn3r8Icpu01Pzx9OyNMNji1TtKK9OeHfLLbwbeufpLAPykBxrFazyjiR?=
 =?us-ascii?Q?+HQVpdmGZkPgtYJVY5leLLv0HVkj9CWt2jY4v5Kl3NZAHEMLU3CZ3iMGxha0?=
 =?us-ascii?Q?4TVT0p5vgJtph+5Mb6fCNbgOPfIo5EDQpngr5I5g2Q4IZvWwozsB7NPsoDZf?=
 =?us-ascii?Q?KlFtKGRP6ePvYenpjnM3FqQaYQ9+KxLLJUrvKkGSRNpa7PFZAPUoOEBvOy9I?=
 =?us-ascii?Q?14AgmTdXqaPtyb9s3PjaQDvpITkgUF1zugdE3CPid0m86Ve74meaxwvYuTMl?=
 =?us-ascii?Q?AIaxoXtIEKMAYM0gOeFiECLDhEgQPJJAnkgNC1ATqE26TQlJAoNAQ+pO3eZo?=
 =?us-ascii?Q?VYVtW9ezBlC5tjvz25w0ThvpxN1j3qmvpjfyn65P6n/Vg1aUWrFxOHMF4eyu?=
 =?us-ascii?Q?l2Rb/eO4EroDYHlfmC9qlgWjuxxWnJlA3SHZX+qV0rbdQDHs4eWeVCRTZxnf?=
 =?us-ascii?Q?YccvntNgF+vvb/TwnDRf3+GB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f472af-8ca0-4aa0-9eb4-08d90f46565e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 21:48:22.2673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPvERZXNEzY1Sre6mBXwV9zN2ut6uwqNRQoaSY3LagGNqzPtboZBLfTIBRQoPdBP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rename,
  ras_hw_supported --> ras_hw_enabled, and
  ras_features     --> ras_enabled,
to show that ras_enabled is a subset of
ras_hw_enabled, which itself is a subset
of the ASIC capability.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 50 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  6 +--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  6 +--
 .../drm/amd/pm/powerplay/hwmgr/vega20_baco.c  |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  2 +-
 11 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3aaf2a12949f..b292c1e3abc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1076,8 +1076,8 @@ struct amdgpu_device {
 
 	atomic_t			throttling_logging_enabled;
 	struct ratelimit_state		throttling_logging_rs;
-	uint32_t                        ras_hw_supported;
-	uint32_t                        ras_features;
+	uint32_t                        ras_hw_enabled;
+	uint32_t                        ras_enabled;
 
 	bool                            in_pci_err_recovery;
 	struct pci_saved_state          *pci_state;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 80631f999fce..dc72b2429280 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5110,7 +5110,7 @@ int amdgpu_device_baco_enter(struct drm_device *dev)
 	if (!amdgpu_device_supports_baco(adev_to_drm(adev)))
 		return -ENOTSUPP;
 
-	if (ras && adev->ras_features &&
+	if (ras && adev->ras_enabled &&
 	    adev->nbio.funcs->enable_doorbell_interrupt)
 		adev->nbio.funcs->enable_doorbell_interrupt(adev, false);
 
@@ -5130,7 +5130,7 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 	if (ret)
 		return ret;
 
-	if (ras && adev->ras_features &&
+	if (ras && adev->ras_enabled &&
 	    adev->nbio.funcs->enable_doorbell_interrupt)
 		adev->nbio.funcs->enable_doorbell_interrupt(adev, true);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 0327ac403423..75f34a9008e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1005,7 +1005,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 		if (!ras)
 			return -EINVAL;
-		ras_mask = (uint64_t)adev->ras_features << 32 | ras->features;
+		ras_mask = (uint64_t)adev->ras_enabled << 32 | ras->features;
 
 		return copy_to_user(out, &ras_mask,
 				min_t(u64, size, sizeof(ras_mask))) ?
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 4885b718cb6c..3179ca9fc03f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2146,7 +2146,7 @@ static int psp_load_smu_fw(struct psp_context *psp)
 		return 0;
 
 	if ((amdgpu_in_reset(adev) &&
-	     ras && adev->ras_features &&
+	     ras && adev->ras_enabled &&
 	     (adev->asic_type == CHIP_ARCTURUS ||
 	      adev->asic_type == CHIP_VEGA20)) ||
 	     (adev->in_runpm &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7a4916e30945..737f9d5371d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -532,7 +532,7 @@ static struct ras_manager *amdgpu_ras_create_obj(struct amdgpu_device *adev,
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
 
-	if (!adev->ras_features || !con)
+	if (!adev->ras_enabled || !con)
 		return NULL;
 
 	if (head->block >= AMDGPU_RAS_BLOCK_COUNT)
@@ -559,7 +559,7 @@ struct ras_manager *amdgpu_ras_find_obj(struct amdgpu_device *adev,
 	struct ras_manager *obj;
 	int i;
 
-	if (!adev->ras_features || !con)
+	if (!adev->ras_enabled || !con)
 		return NULL;
 
 	if (head) {
@@ -613,7 +613,7 @@ static void amdgpu_ras_parse_status_code(struct amdgpu_device *adev,
 static int amdgpu_ras_is_feature_allowed(struct amdgpu_device *adev,
 					 struct ras_common_if *head)
 {
-	return adev->ras_hw_supported & BIT(head->block);
+	return adev->ras_hw_enabled & BIT(head->block);
 }
 
 static int amdgpu_ras_is_feature_enabled(struct amdgpu_device *adev,
@@ -767,7 +767,7 @@ int amdgpu_ras_feature_enable_on_boot(struct amdgpu_device *adev,
 			ret = amdgpu_ras_feature_enable(adev, head, 0);
 
 			/* clean gfx block ras features flag */
-			if (adev->ras_features && head->block == AMDGPU_RAS_BLOCK__GFX)
+			if (adev->ras_enabled && head->block == AMDGPU_RAS_BLOCK__GFX)
 				con->features &= ~BIT(head->block);
 		}
 	} else
@@ -1072,7 +1072,7 @@ unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 	struct ras_manager *obj;
 	struct ras_err_data data = {0, 0};
 
-	if (!adev->ras_features || !con)
+	if (!adev->ras_enabled || !con)
 		return 0;
 
 	list_for_each_entry(obj, &con->head, node) {
@@ -1595,7 +1595,7 @@ static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
 
-	if (!adev->ras_features || !con)
+	if (!adev->ras_enabled || !con)
 		return;
 
 	list_for_each_entry(obj, &con->head, node) {
@@ -1645,7 +1645,7 @@ static void amdgpu_ras_query_err_status(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
 
-	if (!adev->ras_features || !con)
+	if (!adev->ras_enabled || !con)
 		return;
 
 	list_for_each_entry(obj, &con->head, node) {
@@ -1959,7 +1959,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	bool exc_err_limit = false;
 	int ret;
 
-	if (adev->ras_features && con)
+	if (adev->ras_enabled && con)
 		data = &con->eh_data;
 	else
 		return 0;
@@ -2076,7 +2076,7 @@ static void amdgpu_ras_get_quirks(struct amdgpu_device *adev)
 
 	if (strnstr(ctx->vbios_version, "D16406",
 		    sizeof(ctx->vbios_version)))
-		adev->ras_hw_supported |= (1 << AMDGPU_RAS_BLOCK__GFX);
+		adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__GFX);
 }
 
 /*
@@ -2090,7 +2090,7 @@ static void amdgpu_ras_get_quirks(struct amdgpu_device *adev)
  */
 static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 {
-	adev->ras_hw_supported = adev->ras_features = 0;
+	adev->ras_hw_enabled = adev->ras_enabled = 0;
 
 	if (amdgpu_sriov_vf(adev) || !adev->is_atom_fw ||
 	    !amdgpu_ras_asic_supported(adev))
@@ -2099,7 +2099,7 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.connected_to_cpu) {
 		if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
 			dev_info(adev->dev, "MEM ECC is active.\n");
-			adev->ras_hw_supported |= (1 << AMDGPU_RAS_BLOCK__UMC |
+			adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__UMC |
 						   1 << AMDGPU_RAS_BLOCK__DF);
 		} else {
 			dev_info(adev->dev, "MEM ECC is not presented.\n");
@@ -2107,7 +2107,7 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 
 		if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
 			dev_info(adev->dev, "SRAM ECC is active.\n");
-			adev->ras_hw_supported |= ~(1 << AMDGPU_RAS_BLOCK__UMC |
+			adev->ras_hw_enabled |= ~(1 << AMDGPU_RAS_BLOCK__UMC |
 						    1 << AMDGPU_RAS_BLOCK__DF);
 		} else {
 			dev_info(adev->dev, "SRAM ECC is not presented.\n");
@@ -2115,7 +2115,7 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 	} else {
 		/* driver only manages a few IP blocks RAS feature
 		 * when GPU is connected cpu through XGMI */
-		adev->ras_hw_supported |= (1 << AMDGPU_RAS_BLOCK__GFX |
+		adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__GFX |
 					   1 << AMDGPU_RAS_BLOCK__SDMA |
 					   1 << AMDGPU_RAS_BLOCK__MMHUB);
 	}
@@ -2123,10 +2123,10 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 	amdgpu_ras_get_quirks(adev);
 
 	/* hw_supported needs to be aligned with RAS block mask. */
-	adev->ras_hw_supported &= AMDGPU_RAS_BLOCK_MASK;
+	adev->ras_hw_enabled &= AMDGPU_RAS_BLOCK_MASK;
 
-	adev->ras_features = amdgpu_ras_enable == 0 ? 0 :
-		adev->ras_hw_supported && amdgpu_ras_mask;
+	adev->ras_enabled = amdgpu_ras_enable == 0 ? 0 :
+		adev->ras_hw_enabled && amdgpu_ras_mask;
 }
 
 int amdgpu_ras_init(struct amdgpu_device *adev)
@@ -2149,11 +2149,11 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 
 	amdgpu_ras_check_supported(adev);
 
-	if (!adev->ras_hw_supported || adev->asic_type == CHIP_VEGA10) {
+	if (!adev->ras_hw_enabled || adev->asic_type == CHIP_VEGA10) {
 		/* set gfx block ras context feature for VEGA20 Gaming
 		 * send ras disable cmd to ras ta during ras late init.
 		 */
-		if (!adev->ras_features && adev->asic_type == CHIP_VEGA20) {
+		if (!adev->ras_enabled && adev->asic_type == CHIP_VEGA20) {
 			con->features |= BIT(AMDGPU_RAS_BLOCK__GFX);
 
 			return 0;
@@ -2204,7 +2204,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 
 	dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
 		 "hardware ability[%x] ras_mask[%x]\n",
-		 adev->ras_hw_supported, adev->ras_features);
+		 adev->ras_hw_enabled, adev->ras_enabled);
 
 	return 0;
 release_con:
@@ -2319,7 +2319,7 @@ void amdgpu_ras_resume(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj, *tmp;
 
-	if (!adev->ras_features || !con) {
+	if (!adev->ras_enabled || !con) {
 		/* clean ras context for VEGA20 Gaming after send ras disable cmd */
 		amdgpu_release_ras_context(adev);
 
@@ -2365,7 +2365,7 @@ void amdgpu_ras_suspend(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
-	if (!adev->ras_features || !con)
+	if (!adev->ras_enabled || !con)
 		return;
 
 	amdgpu_ras_disable_all_features(adev, 0);
@@ -2379,7 +2379,7 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
-	if (!adev->ras_features || !con)
+	if (!adev->ras_enabled || !con)
 		return 0;
 
 	/* Need disable ras on all IPs here before ip [hw/sw]fini */
@@ -2392,7 +2392,7 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
-	if (!adev->ras_features || !con)
+	if (!adev->ras_enabled || !con)
 		return 0;
 
 	amdgpu_ras_fs_fini(adev);
@@ -2412,7 +2412,7 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
 {
 	amdgpu_ras_check_supported(adev);
-	if (!adev->ras_hw_supported)
+	if (!adev->ras_hw_enabled)
 		return;
 
 	if (atomic_cmpxchg(&amdgpu_ras_in_intr, 0, 1) == 0) {
@@ -2441,7 +2441,7 @@ void amdgpu_release_ras_context(struct amdgpu_device *adev)
 	if (!con)
 		return;
 
-	if (!adev->ras_features && con->features & BIT(AMDGPU_RAS_BLOCK__GFX)) {
+	if (!adev->ras_enabled && con->features & BIT(AMDGPU_RAS_BLOCK__GFX)) {
 		con->features &= ~BIT(AMDGPU_RAS_BLOCK__GFX);
 		amdgpu_ras_set_context(adev, NULL);
 		kfree(con);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index f60d1cfafa3e..201fbdee1d09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -475,7 +475,7 @@ static inline int amdgpu_ras_is_supported(struct amdgpu_device *adev,
 
 	if (block >= AMDGPU_RAS_BLOCK_COUNT)
 		return 0;
-	return ras && (adev->ras_features & (1 << block));
+	return ras && (adev->ras_enabled & (1 << block));
 }
 
 int amdgpu_ras_recovery_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3daf806a00d0..1017e0723071 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1266,7 +1266,7 @@ static int gmc_v9_0_late_init(void *handle)
 	 * writes, while disables HBM ECC for vega10.
 	 */
 	if (!amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_VEGA10)) {
-		if (!(adev->ras_features & (1 << AMDGPU_RAS_BLOCK__UMC))) {
+		if (!(adev->ras_enabled & (1 << AMDGPU_RAS_BLOCK__UMC))) {
 			if (adev->df.funcs->enable_ecc_force_par_wr_rmw)
 				adev->df.funcs->enable_ecc_force_par_wr_rmw(adev, false);
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 29c8ee267990..d91ff069eb70 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -655,7 +655,7 @@ static int soc15_asic_baco_reset(struct amdgpu_device *adev)
 	int ret = 0;
 
 	/* avoid NBIF got stuck when do RAS recovery in BACO reset */
-	if (ras && adev->ras_features)
+	if (ras && adev->ras_enabled)
 		adev->nbio.funcs->enable_doorbell_interrupt(adev, false);
 
 	ret = amdgpu_dpm_baco_reset(adev);
@@ -663,7 +663,7 @@ static int soc15_asic_baco_reset(struct amdgpu_device *adev)
 		return ret;
 
 	/* re-enable doorbell interrupt after BACO exit */
-	if (ras && adev->ras_features)
+	if (ras && adev->ras_enabled)
 		adev->nbio.funcs->enable_doorbell_interrupt(adev, true);
 
 	return 0;
@@ -710,7 +710,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 		 * 1. PMFW version > 0x284300: all cases use baco
 		 * 2. PMFW version <= 0x284300: only sGPU w/o RAS use baco
 		 */
-		if (ras && adev->ras_features &&
+		if (ras && adev->ras_enabled &&
 		    adev->pm.fw_version <= 0x283400)
 			baco_reset = false;
 		break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index fb4f718a1148..7fae6a7e51f5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1430,13 +1430,13 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	adev = (struct amdgpu_device *)(dev->gpu->kgd);
 	/* kfd only concerns sram ecc on GFX and HBM ecc on UMC */
 	dev->node_props.capability |=
-		((adev->ras_features & BIT(AMDGPU_RAS_BLOCK__GFX)) != 0) ?
+		((adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__GFX)) != 0) ?
 		HSA_CAP_SRAM_EDCSUPPORTED : 0;
-	dev->node_props.capability |= ((adev->ras_features & BIT(AMDGPU_RAS_BLOCK__UMC)) != 0) ?
+	dev->node_props.capability |= ((adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__UMC)) != 0) ?
 		HSA_CAP_MEM_EDCSUPPORTED : 0;
 
 	if (adev->asic_type != CHIP_VEGA10)
-		dev->node_props.capability |= (adev->ras_features != 0) ?
+		dev->node_props.capability |= (adev->ras_enabled != 0) ?
 			HSA_CAP_RASEVENTNOTIFY : 0;
 
 	/* SVM API and HMM page migration work together, device memory type
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
index f6b1efce450c..8d99c7a5abf8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
@@ -85,7 +85,7 @@ int vega20_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STATE state)
 		return 0;
 
 	if (state == BACO_STATE_IN) {
-		if (!ras || !adev->ras_features) {
+		if (!ras || !adev->ras_enabled) {
 			data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
 			data |= 0x80000000;
 			WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL, data);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 72581e43d83e..a06e6865507d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1531,7 +1531,7 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 								      NULL);
 			break;
 		default:
-			if (!ras || !adev->ras_features ||
+			if (!ras || !adev->ras_enabled ||
 			    adev->gmc.xgmi.pending_reset) {
 				if (adev->asic_type == CHIP_ARCTURUS) {
 					data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL_ARCT);
-- 
2.31.0.97.g1424303384

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
