Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F0CC4332E
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E22E64EB9
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E22E64EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41F9A6E88B;
	Thu, 18 Mar 2021 04:34:00 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B94B06E090
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 04:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5kLds7AI35S+ml36LLt+0ixUUueX9WMCFLheDRyCCXoe64454NNdrC77ZXw/gcfo3EiuFPX3GQTeFgI/6CSCwFnXaZu0WVrYZxx1CPQbHZFXzIT4KzUXIP6JWwCJNiUlztED+kjZmZK4+AuiEa3WbaSDAnuKpws8ZcMJs/Wm5gucqr/rCMwWe0fHs05dkYjNLFkU1vFUDwY0m5zkwlhv3QiiynqwkAw8lTizmCiSnvWTABsnKC5KYRgH3aFri1qqKzDdmcJ6IfcwP7RO1zhJT5hGEM79qIIpCPe36zUMH+43z1uT2wqbQbCvjSeY9z0PI1FUMP4oG0S3ZgrrpyRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNaeIc2P66UhU6GLac0THs4A67UBKWuqSNcpFGp6QtQ=;
 b=U9k0Di2zbvgh5Q6cuP6LanWqOZ3yxCeBhVza9D+j1YQHHVAaOGALfxguPsfGIVk0oQpjGLTetfuwKkxS3k6yeHEVOJXbXt1hFrdR5aX6rtGIGN8s6d9PYXY+SQ1y5H3ULAdhi6rZroXDWjcl0SN14OU4aYY7Zr3fvFRW2w/9RGYZLKXaX+n5IBaJ0/Nzqcbhzl2dOPMctMLBRyz9k7nuDn+y0VV5Mk+1BEgH4ugmAdBbjb5feco/8frXXs1R3+FInSWs0Y7EaD9Mp7D8qigZhmYTqxM36O1Vgt3Kw69Bt6ZgWrE0iYscAJClwBIipyQH6rf2VI+lXWGZFLfPsk1YZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNaeIc2P66UhU6GLac0THs4A67UBKWuqSNcpFGp6QtQ=;
 b=1VnL0Elw5cj9QJk+UehPWwxFtgzMIEuwOSOQaPdavhSpEF9kZxwo54cZga4mebSnyYI/0APc8Fz6Mv5K17RL2pBFmm2l3NimhPcnI00xDs4/h6Av3jtAsgw1gHnAhYPaSWHdhdNr/+tJ1uc5FuHqrpZBEUAu9yl0g3WCQIr7IUY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4016.namprd12.prod.outlook.com (2603:10b6:208:16b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 04:33:46 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 04:33:46 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/13] drm/amdgpu/swsmu: skip gfx cgpg on s0ix suspend
Date: Thu, 18 Mar 2021 00:33:19 -0400
Message-Id: <20210318043323.3989-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318043323.3989-1-alexander.deucher@amd.com>
References: <20210318043323.3989-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:23a::29) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:23a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 04:33:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f2cba497-af64-4e86-b4e5-08d8e9c70528
X-MS-TrafficTypeDiagnostic: MN2PR12MB4016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB401615959FE16FEAE26CB99BF7699@MN2PR12MB4016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PoKaeqm0sB7R2QSQYtJJ20VELRPB64KV8ObGJSRmLzRxXu4uIGak93K4IpGofoZ+CKwG8ziuU8D2a/hRYMck7YNjcfrYVZQABI5JQ6eolKCruO94QAH8KvFh9DykC96Vb6OGSZtXD7FGE0Q6DNq55bO7VEu61w1h9j0ZJeJwZxdYHNHnoSGubOrV2OVTjJgdSHqVy4T9Mi79LbpzVcCKIybni4OJZeWKLPAc6hy/IlsuCxL4crIKUCkRR4b4b/NIGihEqtg3mKPHSwOWNKnNEIC4WeaBL6yOZWnNUAOpt1EdqnMzgtpO0Y5IEAKwY5JgxevCQkUK7jYNzSuLJtYX2lmKW3Nln0F1O1oAdlR7Guj385wHwICQ9JhQ7P4kUsEP4itMrDyZPdSPPieCH0yekQJKQDzlvocgkRoRcLAULc1qLoSTOTFnKVUVfpynoNvG+7GGpyt0QpgiAiv+ZDE3pygGACW8+N21oa0QO5DZNcQmX905BfXrXMrb7utM++eicVYQ6Tx1ZEUQFX4E9mxBMrEpcjCVV/BKrLM4IvrqtT0v3lUAdKAXgVUma6OV8Tz83VgwIKbdiyuCzixhgN4wKhCtqPXTZxrGGdl/ubztZqW2cuFVF0nqa/SEU7WLd0gscK5m/0aM3j4mAI7o0TLlPQOUDPMd+KsMd2lsxAYOQLdAtswrPwfUsoAJGIC/68eHI49O6eF751rBWMmcUDAmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(316002)(5660300002)(52116002)(1076003)(83380400001)(8676002)(66946007)(478600001)(38100700001)(86362001)(8936002)(16526019)(69590400012)(4326008)(6506007)(6666004)(15650500001)(186003)(36756003)(66556008)(66476007)(2906002)(6486002)(956004)(26005)(2616005)(6916009)(6512007)(21314003)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sU5DWusz7XeKzguxHNahlFurKRd58TzyHyF7DG6R+LWB6+pflLKzGrvHASmf?=
 =?us-ascii?Q?9CxkheTndBbiE/vN8sk9cqLvSL7qEVgIh5oTAVjYO7X4zmhoRtPvbdUWrdju?=
 =?us-ascii?Q?1zqmbt/X6V3CqBtOLcnjYF1OYUt1StHk3Jp8Bk7wVabJCynjJNopDiq4QE1J?=
 =?us-ascii?Q?T3UPjxMhjcRCQpsYaI9u9JDXOMBb7zhp1ZNFm86+gheKmm6bk7iIoV0o3Zb/?=
 =?us-ascii?Q?aZHtXf6Bh02YKV43gJ3xCXQRTu36LcU9jf1aJSHBe5kGvIhvpe+XpE+iUmoR?=
 =?us-ascii?Q?vHJiDgG/6gCZiyzQPJoXZ65OoDmqEcEef7WnWyfhuSzgPKMkD5fP4jG/6sbY?=
 =?us-ascii?Q?CtSGVZT2NmPq68CVq54TNakCcipx7kpwq+AfYLQPEWfwdyhbkmqmURFiWqDF?=
 =?us-ascii?Q?TmaMcoM5tv/v46Og2JHYhsHLEg/7QBGl5Kr0jSgyhZxXfJPH8W566heno0bj?=
 =?us-ascii?Q?CQTN9Mqz+l0n1ZeCXYPcAyyEu5tphRL4eJWlSr3gM1TtaC/Naad7yL/3e37s?=
 =?us-ascii?Q?kWAYbRwT7q3fpyIWpRwHBV2fM6c9In1mFHi20YzmnIn+RqOtnm9D4YiuCWyR?=
 =?us-ascii?Q?xMao34nnd2TXtzr8PGV/YVsle/SzTzzVckhz27y0zhI629wDyeF2tfLS4Dio?=
 =?us-ascii?Q?/FIDtnhdAKf99aP80HhrQSaNsyn8FnaFYstslamiMMcgHmfutkb7lpfIkrLZ?=
 =?us-ascii?Q?n/qNqvLyL0tVwRZjdXTSI+Pce01UxX8ngMgc8YDDEw/vVxnNLLBMPQF+ZGev?=
 =?us-ascii?Q?KOpzp8QTu5oD1pYVcxHChLX74KNc0luiI+77mfbJu049zeeVgvuJXsv8uqFZ?=
 =?us-ascii?Q?2GXAGvz/y9KT8EajbzuUye4Tf1Nx30TwXdP7GE7Xzsn90404y7MzCR+IJhaV?=
 =?us-ascii?Q?UnevWLRhzRAFR9IMUJH/Fh/v9o0o+BIVfLm9t2U38tOkWawkPxP6OlZoiuL2?=
 =?us-ascii?Q?svZ8ZiYvavmRAxC/EON2fzCWCmHRcNgKgkgqxlgwMxXgzKByKyEiBAQkFT3i?=
 =?us-ascii?Q?trpsHbgO4mgkOIUZ4KC3tqi460qOJ27EYXK1k04Qj6aQ5AL5kQviZVBprDyU?=
 =?us-ascii?Q?KM6SCL2G03AJB0akNGZB+cfGo0CiqnFtMXpkznpNoh5zttvYXbd2/4llegQ1?=
 =?us-ascii?Q?yuK0KoKKhlkoaz33u+AIyyvVJv5hO0aj+V4W+CjSrYf8e4ycvJwJSg5pbo54?=
 =?us-ascii?Q?PXkcONOfPdRDqlxafJKsvN0Vu/COsjx6r4Lsx9DmVf6om5fErSdJGywKPxyg?=
 =?us-ascii?Q?8782sldWFsQp9qLq14PYxVPOu+bbJqlvn4Wxy7jiFvrl53Hnhr/K6pxOIrzw?=
 =?us-ascii?Q?Xfzqarb7rnxNHswnG0qvdd73?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cba497-af64-4e86-b4e5-08d8e9c70528
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 04:33:46.8965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10e7VaONkX2jObJyZMBbxA/xy/U9SYk9fx7d6dsGOyBWLUsaF8LEdZWYNAils7SzShMmxAsQJV4N2IE9EalAhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4016
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The SMU expects CGPG to be enabled when entering S0ix.
with this we can re-enable SMU suspend.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 99444bd1f2e9..a84d93ced407 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2727,8 +2727,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 
 		/* XXX fix these remaining cases */
 		if (adev->in_s0ix &&
-		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC || /* breaks suspend */
-		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP || /* breaks resume */
+		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP || /* breaks resume */
 		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX))  /* breaks suspend */
 			continue;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index cfcac110ed84..143e3783251e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1474,7 +1474,8 @@ static int smu_suspend(void *handle)
 
 	smu->watermarks_bitmap &= ~(WATERMARKS_LOADED);
 
-	if (smu->is_apu)
+	/* skip CGPG when in S0ix */
+	if (smu->is_apu && !adev->in_s0ix)
 		smu_set_gfx_cgpg(&adev->smu, false);
 
 	return 0;
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
