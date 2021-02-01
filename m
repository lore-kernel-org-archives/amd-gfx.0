Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812F1C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 14:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D22164DFA
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 14:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D22164DFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF5EE6E5D5;
	Mon,  1 Feb 2021 14:38:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 113676E5D5
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 14:38:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFxgUeRzYHV/eBRgxnR09PKTXxR6+bhHfAwV0VzqYbqN4DdCCFA+JFi8rVaKTk8neHjTGAsAgepEof1yzBH9F40AxlUtnowS+h8vXDgQXoos1tikA8RFOSmoXifktuvQCysYkPvxxC7gGloEJz7P2COwmgDGTooEt2QFlFJDGNPvd+acWyzpH0zA5wVJxKjhtG7IKRRrdoTpGUz32egu6D7NMvDp33jZNAxq9jxGeA7+6mwj6kNDAaAIngMVdmc+ImNkgKRaS7bz5cpTWvm+kBvqqlDgfccU20LZVZgVnZXY8IXFUUAhgpSrSQ4FjZWgGQjTGM6mDZuqp36wCwTCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMqU6nuolhZZaVsRH7gPYhZIk9A26OromheXo0VjcVc=;
 b=F5c/frb4FD6hzGwxnSXXDaBcTlor41aK4xCFxHKL90XI0c3RPtY4ZXrDNjSpTXvrfQnLSvVnm+vqbgLxaXsCYucBZYdgIe0olVKzT9a2Ila9OgB1uf4/jgvN42D2Z600hDSf3+xP5x7iQOxVU01za0Ztm8Cg+LbDQb0BSCzlhySgoy38yrccg66DjERdhWxrtTR8dyzPqeiZML90volmOoquU3+gvg9bIMExiDYRT7uOc1tXomMOJeuM9MzzPXmuJRoMIuJTnC5yDqWSNggtSLLqQaGCBiUUQo4WGgsx8zPnHjDXphnOrF+dRFM83T0/SmUdgTbcmdgo2i42Gyvaqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMqU6nuolhZZaVsRH7gPYhZIk9A26OromheXo0VjcVc=;
 b=GCsQ19BvbJHzkJDkfFAgMp/KzlY3v8QOB7ilCp4k/kR+AR1u6wTisp60d6qIBsY2pC9v+bbUjXoT71kwxhP34/ZWKJU9A+5lktkJo7Y8JqLvFkCvR49DuX6XAKmW5O/bN9tzWKRXO0wOYSfyxch8lohUya4xOVVdy4T83mkCr7M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB2373.namprd12.prod.outlook.com (2603:10b6:4:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.20; Mon, 1 Feb
 2021 14:38:12 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Mon, 1 Feb 2021
 14:38:12 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: fix ring priority assignment
Date: Mon,  1 Feb 2021 15:37:57 +0100
Message-Id: <20210201143800.26908-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [93.229.32.223]
X-ClientProxiedBy: AM0PR04CA0144.eurprd04.prod.outlook.com
 (2603:10a6:208:55::49) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.32.223) by
 AM0PR04CA0144.eurprd04.prod.outlook.com (2603:10a6:208:55::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 14:38:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 64b51426-8f0c-44be-8dd3-08d8c6bf0065
X-MS-TrafficTypeDiagnostic: DM5PR12MB2373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB237397636C680EA62335756D8BB69@DM5PR12MB2373.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMlDOWWdMIm/1MF5Gx1fiiVjAvP8C/MoiEboeRUvoXibRb6VVcU62b4mFs94elUxXpr/JWaRHsUyxoKGhnqtKDUNZ4Wl7jx/BYzZjRQlC9yFb4yz+ouPbryg5nq9wgl3Z04JxusZ8FnjHu5ONFaHvDPJD/4Hd5sV2lUEhYSi/XQSIbMT/bPFmacy00hpgMUdEEYLLhlbvNIG64S5pdeOxiU9I+AIhn725iTObabKFxALJ34RAqQ27DMqnv/kalKsl6EZOef6gZVfBBrWHpYkOE06gVLugRU4O5nw8J+O07S5I+crPTyJkMH42FzzkpaoNBnGv0Xz/VHvulwJd4o0Hut06r1cjGbgDsz4/E4/ECvbqLJJuAKf4yh/qPD2niCZNdgdJuac44lJfSxv6pD0uN/Bm3uhziSgduZYJgVF54NB9B/TaK7f5iAY9ygVeDXJJpZpRlai6kTI5HHxpfF6r7TH0ZDAXQzRnVEYqYV6tCaKs7aHFke95p0YMjgDAKBgSnO4IjYcxJ2msqth9Z3hhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(2616005)(6916009)(44832011)(6506007)(26005)(186003)(36756003)(316002)(52116002)(6486002)(956004)(6512007)(86362001)(6666004)(8936002)(2906002)(8676002)(66946007)(16526019)(66556008)(83380400001)(478600001)(4744005)(4326008)(66476007)(5660300002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?G1pkLbGGPIQOIHnYa/bX9VaXpIPZmRsILDGpVSqUp0XWGBqC4P8JGZWD9jIR?=
 =?us-ascii?Q?IoU1we7YTdvC0/ZGJ6w5GYaoo1z1jjHZ1zpejgP4JYINMS/xFGINBH1ilY1K?=
 =?us-ascii?Q?520KuI1CqGGoMTx5Oy2YHFEpOXEFTftuJMa97DXgwVlG0LUnUU7opeQnpeEY?=
 =?us-ascii?Q?YPxKPICsHfs//IqiiCcTFT9c9iGNxluczkE+4kqyckHZTG58xs1vc5RP37FR?=
 =?us-ascii?Q?QAP1Mvn7MmyIhQWJNZWRsGly8d5Ov5nhvkOwfdWzbvIJPWM/47Rc7MY4Lj6I?=
 =?us-ascii?Q?hb08ZiX1pZFIe5deXa+gxehv5E2MLTsg0/p4fGxFOcL5PHaAvCdaic+fX+gz?=
 =?us-ascii?Q?NYCjcFpO7pwW5mD6Z7Ldqc4MlfImx+kpD6McyiUQySdftvbSrZuL06KtQH5v?=
 =?us-ascii?Q?14HdO7lcF2A2kmI/VYlYFXMukL7XYPT3SXLKPkpq1W8Ba+CTdYG6DSge8bZe?=
 =?us-ascii?Q?SfOOHxBfKcIvX4lKbOUUwWrEx8ETHZdgA1hMz/070AUjIVYfs5tLKrVujqua?=
 =?us-ascii?Q?LLpdKqk3oKR3utqXEGAwK/YcrGl4mStT/v7REa8jwOF9KaY5JORkdXPn9Ywb?=
 =?us-ascii?Q?VlqO3QRGw73I10drwd7/8qGDuhK764xgZIKD7IATUfYSQQ3cfXQr7sb24vpU?=
 =?us-ascii?Q?cQzm/IMSp+6gRfMduomZZgX0Ll5ojB8/ERoSAgLcWXyILIfd/K2ycxvErT9T?=
 =?us-ascii?Q?aRryt1jsLGngSLk7/0lmZgY0InAsRBhDzLLX6sYdALWVzlQMjp2JhXdpd8NW?=
 =?us-ascii?Q?sdLP9oIXuGylYrDu2cVcFE6uNA+CZHsGLuEU7gdR3lar8Y/xlzl7PyONKlcr?=
 =?us-ascii?Q?gfe03s9yVidygwQydIOFr+cPK8WNGFQYcv7201git/R/DxHC1Xf/lKu4NLJH?=
 =?us-ascii?Q?+PwWNIbNSHJVWnuHzk8YSMZV33sWrqLS58DuHhF4UJe7PgWYcP2fJ+TB88/i?=
 =?us-ascii?Q?aclBqxaOuo/gSd0AZTBuvtMz4dZPHiiSxJrpjI3zNUUxRNAFuZGl0SzxUKL5?=
 =?us-ascii?Q?7X4Yg/ApUa8+pT8UAfzIcgtzsMRvmM7Sm7rLHnwUehjA0v4qNijX1YOGTHrV?=
 =?us-ascii?Q?W8tidDvJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b51426-8f0c-44be-8dd3-08d8c6bf0065
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 14:38:12.3632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hs/i7aZzHDBNw6vRb48lYqz0X99Xke35XYCpb0a68x7po+XX6pCy0krYLwX1zzGWZtpQp0UydWcrS6E1qvLbwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2373
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
Cc: Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 Nirmoy Das <nirmoy.das@amd.com>, ray.huang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Assign correct ring priority.

Fixes: 33abcb1f5a17 ("drm/amdgpu: set compute queue priority at mqd_init")
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 1a612f51ecd9..b3d064383807 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -258,7 +258,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	}
 
 	ring->max_dw = max_dw;
-	ring->priority = DRM_SCHED_PRIORITY_NORMAL;
+	ring->priority = (hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH) ?
+		DRM_SCHED_PRIORITY_HIGH : DRM_SCHED_PRIORITY_NORMAL;
 	mutex_init(&ring->priority_mutex);
 
 	if (!ring->no_scheduler) {
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
