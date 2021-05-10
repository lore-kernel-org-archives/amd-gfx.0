Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C308DC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 20:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B8C61432
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 20:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B8C61432
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D026789F49;
	Mon, 10 May 2021 20:29:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE69689F49
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 20:29:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzMqnHSSlwpkVKFuOtDH33sdwWK0hP0iYrD8QauGH439jmkIVpFv9sSMHVMb18sfi44RBHsftDu9saURxQrEI9Bqq4CAk4ov+hlyY0gA5jKHlFdgipJQBgMHv4BXZhvwJ1QOkIYHH4HGsFiMrc7Nkz52s2YNoRF8Va4GqjaVMRSW7yklsB4GKZkbj+xUi8UtCJpXYRb2l6mKJZrpLQKQ1p2+6nDTjvM+o7waiK1XqYiSrNB1DKrd/38YGal3elDaSG9s5m+KYBkwbvK/EY54miD7jyZm+9tNlXcM9Oovcy7CawDM5iMIAQ7nW70SWi7QYJ7pTxIkkdIUIZsNMXgevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaZhSwp4MTjncjecPRjoxGtqt0WgrZ+P3Bn2m0R8EZg=;
 b=TfZtf8YJCrqqtNxT0pnHTm+xVnMwUHY2iRKlNTzQGflSghYqCXF863CS3FwLKKePADLzBUN0Exo+DUO+x45TeQipoxHBBwOpyK+vBtPPgkMUYlJPYQnKUeAM/pdZvmAZ608tY81Quv6I+vaU7R9Wkrrpz8CQyCX2GH4pb4+YVNAE/m8elyvbBz1nSbps9aeQ4GpDVpFw0Tr1WDOrWTUe+55QPgNluwySL8/v9bU+md1G7YsCaBcLbs9Rhl4TmIBpY75tA2aO5UsQCMCmxLBorSpEMsIly0Pa9oXjOBRArccwZRXHKCjFQsbDzrlXHFV5XlUxD5oB9YtjDIPwhmjGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaZhSwp4MTjncjecPRjoxGtqt0WgrZ+P3Bn2m0R8EZg=;
 b=xwv+CQiBmYyOVBNbrHWun0bn0c6Tyl2T6QVRrz0aNmx+2GWxv+omMOok3xsK7kBrT9kAPyqlhaNeOWnUv20A8op7X5TH5anQYi8IhLOGvU20HlA1crz55YRjyLthOXA9ngRs5upDMt3ZZKjsWliT27DYNBJVQYHdIqko+DGjaR8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB3384.namprd12.prod.outlook.com (2603:10b6:a03:d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Mon, 10 May
 2021 20:29:33 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 20:29:33 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: free resources on fence usage query
Date: Mon, 10 May 2021 13:29:14 -0700
Message-Id: <20210510202915.30502-1-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <c1b6f68f-4b96-8752-c406-564e2b98ce41@gmail.com>
References: <c1b6f68f-4b96-8752-c406-564e2b98ce41@gmail.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR03CA0303.namprd03.prod.outlook.com
 (2603:10b6:a03:39d::8) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR03CA0303.namprd03.prod.outlook.com (2603:10b6:a03:39d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 20:29:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44e65363-6a6a-4481-6f34-08d913f25215
X-MS-TrafficTypeDiagnostic: BYAPR12MB3384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB33849B3D67A956893831C77BF4549@BYAPR12MB3384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:241;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P4ELnBfm7xfa/2Uqw1bZVBswtyILL/mtn/fuZteTwpLB4f5sjE4vUCTa/6F+eO9n9WDTFR5PO8+8TCIfXJpPf/L9SW5V9DkXmMBYeOK/k243Vzhrf2qQ1N9HMPnWO/JQWWM92gnZRX6h7JWFFoZfyTmfxdtC1tu8nspjEF2KgezK6DCB4Mq8Bka2krdOoincJwlB9oZGPPA5w7a977gKcLoa+XweGU1iHMRz2N29fP6/fVWDT+Zrz9qufdrRuL9cpwLDr51I/fmzxVrIXOxvU2hLksW9Kwadh1r/Q7zFL6Us9deB6kX9jZ6Qx8CoOv5yC9KHx3G/W5wRWhunkgPYAqsxb0W1AoqGv7GRs1vp+H9tefFNmpUscCrqFa3SCpr0n9xnN3jdtnR2ZC++VY0hK5x7jiAtYAhti/rqcSuhNf0fCUhaympsMFL5UEoVCa84hjWC+dANrdSQ+LHeck8zij9MzP3ApM9QJIskVJDxUTeCJ/is/56wOd9+V8OvOg3vSr9hXPx1i+GZCJf5t81cmKHwxHaIQFmYT+12OBGSnWhNcuQTiENyqY1B9VLd/xulKlV7A0Z7j6/3YEYVupB8mvtDoLazikjDxpFw/QuIhI3NybhSrKNISu6WtO4Sxz6/QL1yxXHSxapMtXomIO8SHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(4326008)(8936002)(186003)(1076003)(6486002)(956004)(52116002)(6916009)(16526019)(2616005)(8676002)(7696005)(2906002)(66946007)(316002)(5660300002)(6666004)(478600001)(38350700002)(38100700002)(86362001)(83380400001)(26005)(66476007)(36756003)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OEXQfSiG6COwVTcXz/0rVue3sGAidF2FlrEgyW8LIqG55nGvr8bTRzoegrPH?=
 =?us-ascii?Q?gq8M63sNrUJLJyciNkMBodJAUsKkrkuXMJTd+64zhwHLJIMbrQgHGBb/NZ3F?=
 =?us-ascii?Q?nTgO8osg98LjMr8sCafiAb04daOazKCYfIBA18f4XUTeln+sJNiPqGi1NiVt?=
 =?us-ascii?Q?Pnyy5FOgWAPmpgef/mtoy1Hy4CsF7w89NT2dyDhZCy3nGnBEkRVLVAIn8WTW?=
 =?us-ascii?Q?DxABcYPY6RtO0582ZFrxNxHmUwtHVide7UdEOwzVMGtYlDIZp4Yx/LRsDzgm?=
 =?us-ascii?Q?r6IocuV3khmnqbWMEpPtpJvFcxBnsoOUfqpcUIwOLrt4efsxPYXMMh+ATfP1?=
 =?us-ascii?Q?7pHKtUxfkVYS/vCLZYwPrvyZByBkiTkg8HPOC3ilTPew/ZZk5dsD3Y9R/pTf?=
 =?us-ascii?Q?pWFU6ykxqFEP1UYYnvVpWtVfnKkW11IRePmBlb7AyKrhJqDy/86oxV6PYmZt?=
 =?us-ascii?Q?A1Kl0fij0122znMCqDmwDmeV4+WlVxlaiIrAyo8vNjr/mzn0j/6TxgcwfpA1?=
 =?us-ascii?Q?xCbFkDU44rvbsZED17o5c1XK4RRyqcF4nka/EvykcbEKB9wa+ZceQlwGDm5j?=
 =?us-ascii?Q?xr1uQACqC77A6hZxViRMed47jbULzLUjlpP1PropUjunBx8TFGcGYWBRdCt9?=
 =?us-ascii?Q?nmjYU2qKSs4Hed9DmJXNyB1QkUH1nxkRKqwj7yc5SdzEZowZHGW5Rp/cb1tE?=
 =?us-ascii?Q?mj+PMaedMUhmVdJ6aYYWpfzKA1t2NFB5PKaa5JJu5w9ZlRRCIclYxVc6NofV?=
 =?us-ascii?Q?qKpWcGKLlj6ZEwrFHKd2Dw4qTvZM9Omxtt4QlEgl7F3Gp8BFiTC4jgA0n3KN?=
 =?us-ascii?Q?G7EJyC7E0EpucCCFKI8hmzES+qgTy99gRWPaQbVvZ65NqZMutMevrjnxw9ov?=
 =?us-ascii?Q?Kb15UlhAxkJq1/y8u95k0cuu+cugk3cDsiYbl83md4pkrMfUNFqqzqQ+rIVd?=
 =?us-ascii?Q?+VRIPfVfgapgLVyx7ur3ytRXvSZtbHhaZjlU0WpkVD8E5rHWmp925pnO/a9X?=
 =?us-ascii?Q?XTG2Qcza/bjQH2wFMm/UqQ0MTu6BwLvmHpZSY+u3tiJJ+QyyyI3xz0yLhJ6s?=
 =?us-ascii?Q?5LXK8JH5hQmkNZg7Zd51P680Cg26tm5iDZGYjGcFwOji31Hj8wcZmZBzlQkf?=
 =?us-ascii?Q?xxAn7xAl06rub1p2eYMlWZj+5wxyZLOGS2ITfbk1LqxePxfdlyxFL4kvRhS0?=
 =?us-ascii?Q?G8eI5qB/P5TEd9NQvnhZnaNRg38Yr34wC6UTK+TpwFt1D387o8eU3NZI6j43?=
 =?us-ascii?Q?8v8K15zEYfavIFzkN460md0wHzeXWcrZgvG+sBiKeyjQ4gCWyefdOV2QtNfR?=
 =?us-ascii?Q?5tt3WtbuCNH7bIOT95nwQUHJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e65363-6a6a-4481-6f34-08d913f25215
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 20:29:33.1534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhH2b5M6knd5euar3FIA4SS/NLGCiNcPd6HzsQzVezCSFM72w81rdW4bBm7O4p4s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3384
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
Cc: David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Free the resources if the fence needs to be ignored
during the ratio calculation

Signed-off-by: David M Nieto <david.nieto@amd.com>
Change-Id: Ibfc55a94c53d4b3a1dba8fff4c53fd893195bb96
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 01fe60fedcbe..9036c93b4a0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -669,11 +669,15 @@ void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entity *cen
 		if (!fence)
 			continue;
 		s_fence = to_drm_sched_fence(fence);
-		if (!dma_fence_is_signaled(&s_fence->scheduled))
+		if (!dma_fence_is_signaled(&s_fence->scheduled)) {
+			dma_fence_put(fence);
 			continue;
+		}
 		t1 = s_fence->scheduled.timestamp;
-		if (t1 >= now)
+		if (!ktime_before(t1, now)) {
+			dma_fence_put(fence);
 			continue;
+		}
 		if (dma_fence_is_signaled(&s_fence->finished) &&
 			s_fence->finished.timestamp < now)
 			*total += ktime_sub(s_fence->finished.timestamp, t1);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
