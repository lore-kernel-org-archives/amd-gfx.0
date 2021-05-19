Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A059BC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 16:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD8A611BF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 16:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD8A611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EFC96EE15;
	Wed, 19 May 2021 16:22:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A90D16EE13
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 16:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QW8TgjX/h+2M+WQ1MEAAXxCjwGJs+gIIaWlpOBoUZNvRvbAyA+7sJBo+zVZ3T2sgiSVHCrUNS8E0DWDxS7MqufMcHxAH4xbjrjhf9ObQxO6VWF6Zfun2DXe8eznMMOn6qlHn+KMfMrUZueTW91zJsbXUSC4ytcnDaHqFQ/ret5Y1P6bd/46mCD/bVj7dAeB2DSePjm7BoJpd6XUF1SNMr/6xe6ngaDfYB6s8vzTNIrUzBCF3JU/llckVWl9VYnHm7ToMzEFS3YaPq4l09IzMOQz0yhUitNFEphfE83jT4NjLLwHF76qFTIw87cf6slY06trC064/L1OZxt/5ELNLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7EMFHgjx23+PLbF56f+R1d1KOXnsZE3NNrYAaHT188=;
 b=k+Pur3kRkZl0lamZmoZvqN5y28cCIVHtHEoJd7sc68P2TC3i2RnM1i9DYkNo5Y42WvvHtp5BtQ8r3F6nR9S+rkHS9BZ3FPmdEkjWHOVixVdgFdNnQDoSmkzhTxMD2BhtYAblaeH+LIquh1Ys2Ykj7PwcjdLrG58jEDLCe7Tb9oSolS52g/JFQKWwuztX2wvXjjl23fibB/CVcYGBCrFdfL4ILHSw+vpwEmD6Y7sP3W7gb+Q3nLNMypIN8gHOAH/nD1gKA9YeaQqZHOMH/3CNpMCNzWrCZJ+0J/RccPL97bhpBrj52moW2fwjBOolcIsY87Eh7eFKx1TqjeUdk5/+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7EMFHgjx23+PLbF56f+R1d1KOXnsZE3NNrYAaHT188=;
 b=v4alcfUxuZpASufLOwavD7ZlClR24ja5m+K3BSK5MoEBwnjpSkszTRRYZIK+525xCO8iYzgr9Yibii9qrhipDVwkb8wOvyQjAHraZFGaVotqy3DeZCgxnl4Ow7VGDowoOind0tqxzGU4Ql3Q/O7MBWziEyG4+u4Ad4dFo6ycnQY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB3259.namprd12.prod.outlook.com (2603:10b6:5:180::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Wed, 19 May 2021 16:22:56 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 16:22:56 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/7] drm/amdgpu/jpeg2.5: add cancel_delayed_work_sync before
 power gate
Date: Wed, 19 May 2021 12:22:37 -0400
Message-Id: <1621441358-14685-6-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621441358-14685-1-git-send-email-James.Zhu@amd.com>
References: <1621441358-14685-1-git-send-email-James.Zhu@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34)
 To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 16:22:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a45e763-3926-4b7c-5c31-08d91ae25bf9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3259:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB32590918625D1290F241FC3EE42B9@DM6PR12MB3259.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D5Hk6nRVFmEvFfrjvIBWcOGPpuyZyD2kA72F4T90ngnHaAugNIwNl8jf0mNmoHpJHloFw9r71oEGwnihvbKezvs6GssYDfwJegtFja2fIBUh2Zyrw7Qi67xGbRO3TiyaIpnVuTit0Eqx+3CaSQ1L5yx7aEwRIhnvlVkzTHXHXp45AgNgTHnX8pv8lg9aRm5wr5kBSlTPlGMI0DHwNX3hZLWJtRH8Ihcxh7APa4dbUFpPxvgPoI5wESUolsgH2EQUy4bqid1/uRrPP9EVzeKyqSwzsIg45SbNBiE7c1lTdvO3/JDfl7PJ0JHuoQOC+1wP8SCxNhnQ7S3SMjuKN3iPTX65X3x9RYK3qF5LV2zNu+5+wifgnPpb3andIIu36LzZ/eYK2752YLozK51g8UJSgesGzBai7Bx3gGjlWTqlvjHiqDTA3OwgRrB2RM/rxJOktax4UbZDhnTIrdrlykdEi7hKmNIEblVp9t41u8nUoDiwFMkbDZcrCtNeRFitAzTbqwFqd+ZIEYuuWkXrTZJfEqH9/nXKJ3nMWj5X1VLb1K65eJXQ9JMkfkW+4myhu0T8oyKFHYbknSwqi9teYY7TSsxD/dU4JrM0PK+qMAXRU85osj3iyKixXwdEeK+3PtQV46nG1naIexDvAvHaxWO0lF2G+PAERy8JK8zAJtWn3xY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(186003)(36756003)(4326008)(66556008)(956004)(6916009)(8936002)(16526019)(26005)(7696005)(66476007)(6666004)(52116002)(8676002)(38100700002)(66946007)(38350700002)(2906002)(2616005)(5660300002)(6486002)(86362001)(316002)(83380400001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jjEZKDp+w//H13CgpYAuua+jgD9BZHqqbMV9LZp9/cOSmkvMGKOxuB1YBb+K?=
 =?us-ascii?Q?k3I4bvmXjRiRzm/xL/QLUnFeigYKoUp6KyfFWG6N3EDKRKrsdUX6WlF26/Lg?=
 =?us-ascii?Q?XJzcJieS4MOGBNaKjRCm2jDYOo69JAE20X+I9/XWJeKTdZnvj4IURev8kAVM?=
 =?us-ascii?Q?AiaCaQWdsqT1xzEDBNhHYVq7f5X+i30GDWh04+DRMyg2oz2X3sv6Xe4CUAYI?=
 =?us-ascii?Q?bn2FyE7cm7ZAX0Nx/SfbsYq0SCz2v/NDHPp6lKkp6KD4334QAEHeAE3dDpvl?=
 =?us-ascii?Q?nWbtFgYLetaMOmG1Y9Vo8uySzdnBNdGkYykq1wxxOhWh+awMy6+oFz5cY/Sh?=
 =?us-ascii?Q?atPezs637e53KUVpO6ytw9lPF1VVmAKfLG55ASwB8XtR8CDFB3+dROfIAj/T?=
 =?us-ascii?Q?ut+opfoAH1gs8TvqxKqTy3TWrlIQ9DqzzVysUuhgqpbaCXeYGO15GC0cgHtU?=
 =?us-ascii?Q?hWle915V8M1FkQsh4KnMS1utKZO1d7FhqeBZB5dBzEGdG386DRfWv2lYwAoI?=
 =?us-ascii?Q?Y+kPg+vnaS8bMkY1C9Qn1aQEyiYrGT8qy4MINPM2rxthiO/blV0tKRzJN2+f?=
 =?us-ascii?Q?XAPusEcEJwrCO/fY8j5kmtKUtqDsCaTNmSzv+IM5Nx2/xXkr2+iUoNMS2PDP?=
 =?us-ascii?Q?ZX05tq6cvvHl3A7rnAo6IvDrS1Tc7g6/qMegLdmM5/eNw74FN2eb9PHQDn26?=
 =?us-ascii?Q?rGXdrifqCX1XYIUV+tsOFJ9bU8S/h8ygwWet2McRDn6isX7DKALAWXQRBkS+?=
 =?us-ascii?Q?ML/PNPS/5JJEvwnlCsJRVFb4sCOEX1yHt/rmYxxYFmYnOFTDEngJoxqS5NNi?=
 =?us-ascii?Q?kDa4dvRbMY3KyUZbiZeChoKGUyvQTIQxvaO08cmu+gGl7j1Kng+5AUe3+v/F?=
 =?us-ascii?Q?PpcQP9i2sEKHjJ0kZCOOeSvOwbPUuG9HDiRevoaUZSRSvmKSspcWe4EwfCu8?=
 =?us-ascii?Q?7TzOM7/ZAWmHrqaSpAL1ngF3ByQFxRQ7YYBOkienhFRJlcCszh/2cxAXKu73?=
 =?us-ascii?Q?N0uwR7ObKMqWUHSOIdA3FhcMoqD0h+esJuRG2c+ujvEUrlfddy1MfKkMGHTY?=
 =?us-ascii?Q?bL827z7jOdqL3b1MNM12nL/IiYMU6fVgTiPyLkvhGAGajyjWE8CwEj9yCmX/?=
 =?us-ascii?Q?BJrIBMopefkxxrH7wWrtO6zs5TuKgE+eO+rw82ry6bEtdpEhxtZtguS6qgkZ?=
 =?us-ascii?Q?bPqZ9GSt/XPPrzOtwU7EYKu0jEqI5ZWgl1/xU4F1GI9dPIerGsOeZO0H4Q8/?=
 =?us-ascii?Q?qNmN5oDl2bDYSenVdjO28yXuRIUW61k6cn1fwX4kQIsH0s9UGm6Mil+NNioX?=
 =?us-ascii?Q?LENJiVRh3Op73lJl5ytZ539h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a45e763-3926-4b7c-5c31-08d91ae25bf9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 16:22:56.0184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/RYvGejW/XCK99JLk8G2gIncj1jAt58nMCTHfsYM1HJDowUB9dDyaCZ8/EKI+ZF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3259
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add cancel_delayed_work_sync before set power gating state
to avoid race condition issue when power gating.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 938ef4c..46096ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -187,14 +187,14 @@ static int jpeg_v2_5_hw_init(void *handle)
 static int jpeg_v2_5_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct amdgpu_ring *ring;
 	int i;
 
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
 			continue;
 
-		ring = &adev->jpeg.inst[i].ring_dec;
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 		      RREG32_SOC15(JPEG, i, mmUVD_JRBC_STATUS))
 			jpeg_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
