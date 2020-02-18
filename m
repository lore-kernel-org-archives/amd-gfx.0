Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4193EC34036
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 10:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E165221D56
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 10:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Vb7h8xnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E165221D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A94BA6E1B7;
	Tue, 18 Feb 2020 10:40:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0232E6E1B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 10:40:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Peq3HJXA84TmNlXmpym/VlMbA/iyYFcbL+g8oh2iXTK/zj223K3lj4bSM24yawv01kx8wZEuCmLF3ALuSct1LoPz0z4pMRByvepFNyK5aZWTxPROzzCE2JaQjNuCzbyuOoxE/U8JAYUZL+PR4vIjShyNDJVBlZnKViuDoTVlBHFuPQgquIDWWAkR+/vsp/S5Gknfvbi3fNMoqOlw84y66ZucFFbAX3Rl82wBsinKjO/zQk6/RVLg/xj6pT99EE9JzT+1w+tNwmCuZlIihVFd1a7Ho66NqdRSJTSZ114jt6BiSTfQwTLi99JK81AHFh2zpcr4EQE1ObaziUvPqt1M0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MWXoC+5J/+4vDEZ7vTA9KNtp474gYiQrimMmj/HUmU=;
 b=DlphN46ew2JK2ImOaUShnCkaOMS64O9y9YbG/24e8R2VLEuoVC5oZvl/gNlpZ/LCSrCmstSuHotdR+blk8dfsHV5JChrgKXzYqrV0APcJVSuVZfs5O0qqDRc2sB0ePJRSfpkTzaezxW910zeXOz3UxMJXW2Npx6j8pIPIXP/4cYk2o3Vn3oniAJhuPcubSZoyjb6p0EBFWvPJEmp3TQ4ugFEdY6uB8fK9Sj0sJugTtG+cBZaXPjv5+nQWMzAMqbcpm4w6L8ufh5KK36CVKJhQynH4+ZanhUnaZsKyKHVWZga6/7fRH1CdwVcSKBGmB0QFN/DD0bPDP9Zk8Sm7pq2OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MWXoC+5J/+4vDEZ7vTA9KNtp474gYiQrimMmj/HUmU=;
 b=Vb7h8xnNekcHHkXQ/t3Ie09bDmlLUf31H2bExUg5ag9Vr4gD/1uu86NyXJ89nFOrkbG56ZsOEH/HEOo3dvBXNNEcJsaTiD3j9w6lZZjVoC+8zTN4n1W/1yDR1tTnoUlI14k946LJDyBUdsVDgwcKksg7FGGm0KhueFArUYYNVks=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4221.namprd12.prod.outlook.com (52.135.48.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Tue, 18 Feb 2020 10:40:43 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 10:40:43 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3] drm/amdgpu: fix the wrong logic checking when secure
 buffer is created (v3)
Date: Tue, 18 Feb 2020 18:39:54 +0800
Message-Id: <1582022394-17454-1-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR03CA0048.apcprd03.prod.outlook.com
 (2603:1096:202:17::18) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from hr-intel.amd.com (180.167.199.188) by
 HK2PR03CA0048.apcprd03.prod.outlook.com (2603:1096:202:17::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2750.8 via Frontend Transport; Tue, 18 Feb 2020 10:40:40 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aadbbb09-8c3a-47d3-a51f-08d7b45f00de
X-MS-TrafficTypeDiagnostic: MN2PR12MB4221:|MN2PR12MB4221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB422132DF0FD8D2142BF668A5EC110@MN2PR12MB4221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(199004)(189003)(66476007)(66556008)(66946007)(4326008)(2616005)(2906002)(956004)(186003)(16526019)(86362001)(36756003)(54906003)(26005)(8676002)(6916009)(478600001)(6666004)(8936002)(5660300002)(81166006)(81156014)(52116002)(7696005)(6486002)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4221;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zis2SIoxMYPS0YGzkJ3jVk0JDTu0CeM95xqRB/yrQktmljoYedGIMrXWOvivl0GPvFZNFSQDWFuPOsX4h1Sg0vE1Fq/JxxgeJwpVzMRyWayrz7lcjqkpF/1NqOc71GSNd4iR42PDgLNFcMg4W8q9C1uuuh3BXaH6tS18R6t2sjroC3EK5udQwgn1lMrFsHvBjrUUFSmJP7WQiLeuZGvLsJndA2RfIcEfTCKJ8ZLVj4hypimt5y3xLpsG0d8wSaOoxMcsaVRws/yMsofvmKv2A8LkzymdMgeBP5hwYPK6WtnBiRWzLca4JerXvaiZX0HkmI24skj1sR2vQg4yV/RQgFOCKMOas/LVFANR+jXQXOVHqyd6SwPkyhRHnFrkr9T4GcFu351ziX0k/OXd5ZsHR82/BeGELxyBai+NRQaVLB8Yc7YgtaV6zD5zlP8/CI59
X-MS-Exchange-AntiSpam-MessageData: G7q7cybfiPW1GOZC4VbrPjBvFJ5+KTUT0cmDhuBWSrWIUqIi9QZRjDrB1IeRjHleQMDdM6O1qAb0OgxJNMuTrBkCryl4UtlLZoZp37ehScaqe4G37HsfS/GsfSIwY/nWXtZlCiA19JWiNUx4OCNDDA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aadbbb09-8c3a-47d3-a51f-08d7b45f00de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 10:40:43.0485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOe5p2l8llxHucQo4Y3Ljh+WNXsj2YDfZBt00gSECOM6SrzvjP72YVJxiJBNtp0COJE/mFAYneXinaZTBKrq/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
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
Cc: Luben Tuikov <luben.tuikov@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, Huang Rui <ray.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

While the current amdgpu doesn't support TMZ, it will return the error if user
mode would like to allocate secure buffer.

Fixes: 17d907c drm/amdgpu: implement TMZ accessor (v3)

v2: we didn't need this checking anymore.
v3: only print message once time.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index b51a060..5bec66e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -235,8 +235,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
 		return -EINVAL;
 
-	if (amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
-		DRM_ERROR("Cannot allocate secure buffer since TMZ is disabled\n");
+	if (!amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
+		DRM_NOTE_ONCE("Cannot allocate secure buffer since TMZ is disabled\n");
 		return -EINVAL;
 	}
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
