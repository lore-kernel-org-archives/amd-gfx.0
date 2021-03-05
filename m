Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FFCC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9DE6508D
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9DE6508D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B57B06EB97;
	Fri,  5 Mar 2021 15:06:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE3FA6EB97
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 15:06:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYkEAomy2ZJ8/CtnJ87rsL3IGZ6TIGpXg4yaWMQoslKOva/T80o1r5WbgrbM79Rrodb3/dio6lxGBFIiSn1Nh4M1OlOTCPOlXM77jOjcMBl+CqmeiWvZp4T5t+WEufwQif6RP9ETJD2SpZV58cOOqtHFvPDCuZo6w/cbsu6+uzT4QdYkoiKMJR0dc+o+IrOgjGX4rtgT4tubIZ4zkOnhiIpmKA0wtAiOYuBMBxBpNv1UYe6SnUL2g7Hv/EBHJucfsBj4J55zTjC1UyYKAc/NADiYW2uO6dqE2xWED9v0TMmDjrAzEnZVoZalC8y1UgXE0P1MLhu315qJ+PiQeu8qjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGmhJXcbaHLzP4WrINlsKd/F7AdjVDNXzmb0eFsSHWI=;
 b=HxUXE6TaeuyprlKHoTus/8CNyVpCJ7N4trrUKmn6/nDIarz2WH3IbHPSfRYLGyN2q7dhlsjWIecmnRqq+V6nlKgramdIG0sb4zCHiBhJBlbhRAtImRQ4IEW4ImiYkQByz1dDNR8X5NPe79LobCt4Lnel73h3glEej/Nzan8zo58figNals434s9K7YwCPFZtuYkv4ZDBdH0H/K0bpVhSMi2SIMyaqaEzbTpZq9qUrXs5PVyl0YHcAtuSSq48bps1t/kKdIU8jbne1JITEk0EYbHLr8ElVsMMSJZK9LU1LLMl6Z8fSRMFJDZvlu5L1Ds0AZWRgZLFw2bg+//yv2zOiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGmhJXcbaHLzP4WrINlsKd/F7AdjVDNXzmb0eFsSHWI=;
 b=0LoxT/KuRJfCLyePp3B/dYt+T5U7inIsmcAMz5hZ21akEhwXJUlYmzdaw+22ExdAv5DXxH99ZZWCWDUuWC1KBH0ghFymmPHeoT2vkHCwKw1M2XESP/9rdwN/jeSx272vTWYt3OnT7iXpiWmtV4w9d5jFn5hzTNf4Y2PO5GRpAzw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1208.namprd12.prod.outlook.com (2603:10b6:903:3d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 15:06:34 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.030; Fri, 5 Mar 2021
 15:06:34 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 4/5] drm/amdgpu: use tiling_flags of struct amdgpu_bo_user
Date: Fri,  5 Mar 2021 16:06:16 +0100
Message-Id: <20210305150617.20144-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305150617.20144-1-nirmoy.das@amd.com>
References: <20210305150617.20144-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.122.77]
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.122.77) by
 FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.14 via Frontend Transport; Fri, 5 Mar 2021 15:06:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a7a2a39-359a-4f4f-8a2d-08d8dfe843ea
X-MS-TrafficTypeDiagnostic: CY4PR12MB1208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1208A9276DCADA090C7B5CDB8B969@CY4PR12MB1208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AG/492zWmMeJMpEICVulAy8qF5t0OHQ/iEC7RhgTD5Qc/wlPuQvbtP5xCAPZSpgjJVArSo0SkJvtJsqMxcNQtkAiJBEw3ACfOUw8tpHE0eM48CS+NzOjgLSyyzdQJo66z3D8bHm2LH2l0Z4Sf90ZnUldiY0AbA1dZ1AcjlWZv385fQ4zppXF2r6r6zIynN3/YTxkvAPY86E9tifPMqarPY/gLaCsqJXM8GIt6ybVU0lKym+T6gC2/hDL4ZUyH26NtO2TBu2mpG6yco+hGL1/aEfFY9JFWyzgacYHS0a1Tg4fI/04QDuGK1hAQpRJSjD6NjcVSw/rAoYAPTyyvltsTQrH11phH9Zqd1LYJ/PgFjb9Zi+8Acm+MzvWSq2S649sg/qy4iqmpZyyTSA8Np/SWamShewHzK8EV9LvR9s0Ipc045ufjAMm8Bx5o+y2TtiKOQhamJlqzgioYo+87A8fb7VdE51TBt8bd81Y7qU6WPe21PjcnBZYFuIxxxh/YEKrDyLoxUHNJrT6IZttkUkEUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(6486002)(5660300002)(6512007)(52116002)(6666004)(8676002)(1076003)(6636002)(37006003)(66946007)(316002)(66556008)(66476007)(478600001)(956004)(2616005)(186003)(36756003)(26005)(4326008)(83380400001)(44832011)(86362001)(2906002)(8936002)(6506007)(34206002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4lYUY/+vtRw6Zkdp6hkOxVmjK5k9PS09YAzoQd6pTUEvnN9yxp/91RLifqZD?=
 =?us-ascii?Q?s298bV4OPTEgkB8OGOudZgbWuDDnLqPVXt31CTmaxkjvQvUc54xNdgRZAEr5?=
 =?us-ascii?Q?ua8KJdHkwqey7lfX3+rFEVqr9Aw/DR8mdZqEeWb3H4/Axs6j2thxqqpcNRpf?=
 =?us-ascii?Q?QOLF7BNL1YCNsrwOFbmQsWNR0VMT8gGYpKy2/g7IQ79nEAlRusD1j9szj92i?=
 =?us-ascii?Q?y196z4qCxOMoviylSOyWY0i5mVngsnisrsz7BkvRXeBp1IYa3fHnR3LJTe5F?=
 =?us-ascii?Q?dCT8kJsMNFGo/iyaB/2ZFUHO8/0Lj+qJlYnsfmQ0w+PrHb1QVoGsLvGHp6Lx?=
 =?us-ascii?Q?26/hp+THSIy4Z5mC8NWiDiMrAj6bBp8wvHIeFTQ6MKCOxA7rPEmeKBU4jcoc?=
 =?us-ascii?Q?mM98QPntMztV30jovh0G9y/ux9QFrPP7JUAWbiwv9f/0bx4cd94zdXMIuPEm?=
 =?us-ascii?Q?KM1hgsBNvolyUw8j0pbblzZA3wFSfHylcS4a1Os2VAkPWhhiu1U4Tw22a1qI?=
 =?us-ascii?Q?CE+lBNtTNbI2uoiysmr9w8J1TIayqB3SM3MrjH4+mm8GFfFrLTJloV0jz7Bh?=
 =?us-ascii?Q?ZSmwyRVApax2Lb8L2zHgQOrDc0k4nusNINBnBd8L2ZLNV+eFKsfvHk1lzdJS?=
 =?us-ascii?Q?gXs/3medv11/0IYlZtXd6wVT85JB3Odu/J2/QCaP3pTsGyc1M9Yqlvm2Twmw?=
 =?us-ascii?Q?I9GcQY2Gfepfem0ouDuxbZEU2rtTZSkuS4S2LV9z7tEwCVaUl3V0lWTEmlxT?=
 =?us-ascii?Q?yA8LuNvC6ZAQZiVIDpWUe8bMILqKgLMuWeOQ2QxBMX/ZZqH34coN7bxBI7z0?=
 =?us-ascii?Q?5AGq8R+rKCYTJYnka74fNCUtn9THRaug/2jqGUH3M4pi8crXbT1YaVp5Ayk9?=
 =?us-ascii?Q?hzmzaf9ZR5anU7SMui0cTnNBkS9dbXLLkiIw5a+B7LYHDEi1hYCq9PJGfFnn?=
 =?us-ascii?Q?BuzI4ZsxWx6O8wjKXBU434qttSMJRc/UboN3d+KP9pZjNX/Z+cQ/CoENDq8Q?=
 =?us-ascii?Q?+Ga+kgjUdQamXsRlC4etZaDpxBCbIo3Lo2ncTgUemT0wG7ze3VcG6H5fzLhJ?=
 =?us-ascii?Q?Nv3v8nMaZ0CzPGJFZ4EAPRJHkLSV9uqXpQgcq968jPKOMXwTZeAXK9injpvs?=
 =?us-ascii?Q?uDE3dMXaKtXPiGEKwEG0yvgL5oxi1L9D69QdYmr8HgrdxQmS0ZB7YOZ/MlQ9?=
 =?us-ascii?Q?7dA1tnTDWRZN5z00Lh5i0Ls4lvKiWC4Jds2pFSgF0ulk7+2TmfsQ67X7Jsn6?=
 =?us-ascii?Q?D4RT9+8BCLQvVO2vaZMAXppLux9o5+4EOp3/g8QldNL/Fo5vayxYXY5OJBzJ?=
 =?us-ascii?Q?VuCQAPxsl7KwH6whO1KbQi+u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7a2a39-359a-4f4f-8a2d-08d8dfe843ea
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 15:06:34.4963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ves1XMaNKHdoDXv5/amidOe4sDIUh87Ym3nkxdsurB/cOwXyBYRSV4CvwhByhqbnXxE5PISpr8ICFb+BM/Iaog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1208
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

This flag is only needed for BOs created by amdgpu_gem_object_create(),
so we can remove tiling_flags from the base class.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 19 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 -
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 09d3394350a6..ca60943312dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1180,12 +1180,19 @@ int amdgpu_bo_fbdev_mmap(struct amdgpu_bo *bo,
 int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	struct amdgpu_bo_user *ubo;
+
+	if (bo->tbo.type != ttm_bo_type_device) {
+		DRM_ERROR("can not set tiling_flags for a non-amdgpu_bo_user type BO\n");
+		return -EINVAL;
+	}
 
 	if (adev->family <= AMDGPU_FAMILY_CZ &&
 	    AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT) > 6)
 		return -EINVAL;
 
-	bo->tiling_flags = tiling_flags;
+	ubo = container_of((bo), struct amdgpu_bo_user, bo);
+	ubo->tiling_flags = tiling_flags;
 	return 0;
 }
 
@@ -1199,10 +1206,18 @@ int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags)
  */
 void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
 {
+	struct amdgpu_bo_user *ubo;
+
+	if (bo->tbo.type != ttm_bo_type_device) {
+		DRM_ERROR("can not get tiling_flags for a non-amdgpu_bo_user type BO\n");
+		return;
+	}
+
 	dma_resv_assert_held(bo->tbo.base.resv);
+	ubo = container_of((bo), struct amdgpu_bo_user, bo);
 
 	if (tiling_flags)
-		*tiling_flags = bo->tiling_flags;
+		*tiling_flags = ubo->tiling_flags;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 177ae825006c..67c1634fa8bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -91,7 +91,6 @@ struct amdgpu_bo {
 	struct ttm_bo_kmap_obj		kmap;
 	u64				flags;
 	unsigned			pin_count;
-	u64				tiling_flags;
 	u64				metadata_flags;
 	void				*metadata;
 	u32				metadata_size;
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
