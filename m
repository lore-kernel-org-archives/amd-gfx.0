Return-Path: <SRS0=HO04=KR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9597CC04FF3
	for <amd-gfx@archiver.kernel.org>; Sat, 22 May 2021 02:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD986023B
	for <amd-gfx@archiver.kernel.org>; Sat, 22 May 2021 02:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD986023B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 576F16E8B7;
	Sat, 22 May 2021 02:11:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 820E26E8B6
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 May 2021 02:11:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FO3g4dla4ZT+6yPCcL62nNuBIjArpUB7hcMO10/37rpot97XFbFQCTvqx6BxAVK+QaeUejX8PKNE8snkRtrfyDhbYwldpdZGhfQvt2t1k7c6gsD8bRpSF5RyhpRuyf1CvtCJ6uhe6BlF0iQ4S7AXB0zoFIFTmleOna6PUWIkl3ivZreYC36Ummf64sTYmNLmV5xysKy0EzZxWiNFU6WaFyGxy0r2IPn7YFd5H1ndQx9NqoI5n1evDaHV9o3ZpCZsiyhBO9eEUatHnBs5K6jLHpAecwqYtqYn84cRjN60i3KDC+NnEA2JjsNXPFGQbr/ohe9CW74GLwIT1dnxCE8z3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zjVtqqf1HRHiJUz8BYgiuV8oXyec/r+anXmGBbvdWg=;
 b=b3XkKHU7el/EuzuRH35J62HvieDZ4qJZBregKJLy4NJg/hee8sKHIVP6NKNkFxJi4Ah0S40ET3ZYRKlPuo2IkD7dCbQtYq2BbaaSucU9UKqzN9W++vo9QEplt1Wf7S+tL8Rd+BbhbwMIDQP3Pt3mTiGdNhUh1+FSj+4Pgl1HpFYaoZNg+B2OOgtJp+NE0itmoBsKgovtTW60MZuWp/X3r1NqFrJmJb6k7xzF4V1mP70a6dIKCVW3xEgKXC4K6OqOLmvmCDA7V8NXN2M4Dt28n5w/JAVVyNnD5jdzaBCxDY/XVKcrRgLHXB6y5w4R4GphUQIpaj8E36/fElzL1OsWPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zjVtqqf1HRHiJUz8BYgiuV8oXyec/r+anXmGBbvdWg=;
 b=TWbrNaUA3XRpAtUPpMdvHjxwmr75vFyfXB5QPtY6TYEZF0d83irv9iPRiYBzj4WaFw15BlAkwCmY/3mPDzR4NXgS38GZjOlFUVv+51ybQahXtc2DMKraA7R6C151IdfZ2rm7TeQLlY4HwnKyCvonQN9OJHMuyI/S5NMcdKlZySU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB5086.namprd12.prod.outlook.com (2603:10b6:5:389::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.23; Sat, 22 May 2021 02:11:33 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::4543:6802:6acc:c92d]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::4543:6802:6acc:c92d%5]) with mapi id 15.20.4150.023; Sat, 22 May 2021
 02:11:33 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix a BUG_ON due to resv trylock fails
Date: Sat, 22 May 2021 10:11:14 +0800
Message-Id: <20210522021114.4166-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.134.244]
X-ClientProxiedBy: HK2PR0302CA0024.apcprd03.prod.outlook.com
 (2603:1096:202::34) To DM4PR12MB5165.namprd12.prod.outlook.com
 (2603:10b6:5:394::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (165.204.134.244) by
 HK2PR0302CA0024.apcprd03.prod.outlook.com (2603:1096:202::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.12 via Frontend Transport; Sat, 22 May 2021 02:11:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0fb7a27-3081-425e-b848-08d91cc6eb7c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5086:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5086F6AF80729D0E5006BA9F87289@DM4PR12MB5086.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6gwrQgVfSvUH0b2gxiTAL1e7HPDX7qJVZdmwPynuMJX5TzK+vijgupKcGYfhecLnHKMsLMLfpNt8p0FQelfCB0cdRbfUR+ye2mGrQf636MZrL4NqZ95qedhw342NXjLa+r+EGapCHkZnYJ9BXg+CncDqg9GBgv2JDnM6yu+3gG1L/AlkAXOQbwIW2Dc5CKBeSK+PoDjo533EYv+SnZzQfep2YNZZ+CAalxBBmRyyfIsaCmzkRErh8NxtABP1c0uJ7VVjADRzVeUPBuhYl2Aa80MgZapamMVk8g2jplh10QYHlDyu0AHd++K+2YpjdEWlc+kKqSADWEtNKhZ9KhbxOLawu8WGAmNfGW1oWSHASmYmtuwha03o5eUYX5PLl32MtY7ITW+yqs+CUsKF2VmHGeN5Lul466P8JQzyBUtB2V3zRRWOxOlMV9ww7ORG+LgwKN6iIL6+C73P6GTpDxyQGSsutoDDPTUUTjhgOBkabfaKVyM+vIRh1MHKqKaCfAHzdSrKGDe83kzzhKz4lWG7WsrwEQtHsN/fnwiNGDJ/99PjeoPxaQvYwzLXH0ungam/p0ITlwJMGTGrQZAZiQEjIOVP20YXy8sMWtmXn/y7AmDUeS03rIv9tIGXmx9DCe4/7Qc2m3nydL34ySDSBzyQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(16526019)(83380400001)(186003)(2616005)(2906002)(38350700002)(38100700002)(478600001)(8676002)(6486002)(6666004)(26005)(956004)(5660300002)(7696005)(1076003)(86362001)(4326008)(36756003)(66476007)(6916009)(66946007)(8936002)(316002)(52116002)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hKt+VbU2HdJvik3s7oyWASMmQZsu2azNeGjxNoxyfAzQ80avlg0ZAUBD5feP?=
 =?us-ascii?Q?3AuyVyLPq94fl8ZXQ9IUg6P1/596prapUN/XfnQjoPdQM31wjkxhNh+8C+XP?=
 =?us-ascii?Q?vHr4bnly+oJ4xRps2c0YaHbsDHthlBFTVMa7hKajWHhpRDJEDiLyXY1tj2x3?=
 =?us-ascii?Q?nUsGz9EqHJm0CPxxzTOtOPDklFyi0cw7wzIG57/GDhuGKInEaoGPeiXf895H?=
 =?us-ascii?Q?F+ixZDYurPF3prYRjsIR0ncg2VsMn5NegPzacZMoQBEYVQHwuSnL3QKcjiE5?=
 =?us-ascii?Q?wymnQe3QLCquacwvUy1h0xsOyWgbUDkEZoDnEmFreFsSdYzimHiMM0x8WjJw?=
 =?us-ascii?Q?p94mXI1mCjWczkX2RoQaJXy7Vl5mSVy6djbGIxbLElfsgAe6D6KsFmGDgWS7?=
 =?us-ascii?Q?HhBtDQ5bkn3dfbkOx+L5/G/hX2cry5MyMGWaNhd/jCizhC3gmITWoUM/aoVZ?=
 =?us-ascii?Q?8CYz01e/an72mxBgKvYBRW8j3RL4rv7zo+L5BPfZ7njHQsvjxJjKbINwwOai?=
 =?us-ascii?Q?Dtl8MCGhP0C2knpp5udmkvIrFNPr2t6ByWqcYLtBMDBbLdpdssvby0eO+Nzs?=
 =?us-ascii?Q?mDyA6BRgV3t9xkVlmM34fjVu2/9OsJ/YvL8Y0wPJfqPq52TQld5sr3LkNGeu?=
 =?us-ascii?Q?166YpCxs9hHYaXBRhiCkDwU3NyAJ7WlJYwOBB1hTYp2Qx3sYf4a6n5cV6nx1?=
 =?us-ascii?Q?Sg0e+4LOXJlg183/Ntx3XPrIyXWVibw7yz4MpA0O5SGO3u9+PkyBRFwKtZ34?=
 =?us-ascii?Q?FigQTeFRJoYAnd9TmSXbwynk1h+2+dZzMpn8T30hYnXsBv7MYhGVJWAoDzDa?=
 =?us-ascii?Q?8WzUR/KwXye4X1z++4YWKebaF8BIN0GIpbz0Do42RHmXXgkBZ+YASOyaU9/F?=
 =?us-ascii?Q?hay6uip9dbtAmEaKNyvBaxXfudXrk3F+cFwvP58+R6yt1EEzNi/9BIsN46Qd?=
 =?us-ascii?Q?Ip79UWPnD+ASi26Y6WbVq57+kmOwhnMg5sup6Gxf7rrIA6hais6kZIubjlNV?=
 =?us-ascii?Q?v+lv7jzAuLCsj/7TpDRCoik8AioiQSe3cDP6a46nofYa3I2mgaSy6KkxQ1G/?=
 =?us-ascii?Q?DSpwxO4LW2sSwZDuVzEsPAxJxqtxH15fzYRv3N4k+xflb3IsX/q0uL9RwmQy?=
 =?us-ascii?Q?A8yH+/YyVvfyV0PBUXvFF64Ld5lrdYAXgxYuexOL8Unyc7l3DANSEkY8P/fE?=
 =?us-ascii?Q?gBbmVXN0O7Wi/XN7Gfal4nL5akUA67Tu6gI1FH4iq1+7x90P0ugvd65U6ddP?=
 =?us-ascii?Q?3X/cZ/+ggXN1wR7I8B1Ol1rv/Jq3cBt4t2YCOnJzT0LbHD4H8+R8Xf8Hi7Rt?=
 =?us-ascii?Q?QHRPD7q/0SuxtMJQ/sgG2v+Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fb7a27-3081-425e-b848-08d91cc6eb7c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2021 02:11:33.1240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJGy5+KUKOujshFNrSshdZe+dQjdpzsAqq1iryFfocz7Kszcl/PzOngy+Vg5SPw2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5086
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 xinhui pan <xinhui.pan@amd.com>, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The reservation object might be locked again by evict/swap after
individualized. The race is like below.
cpu 0                                   cpu 1
BO release				BO evict or swap
					lock lru_lock
ttm_bo_individualize_resv {resv = &_resv}
                                        ttm_bo_evict_swapout_allowable
                                                dma_resv_trylock(resv)
->release_notify() {BUG_ON(!trylock(resv))}
                                        if (!ttm_bo_get_unless_zero))
                                                dma_resv_unlock(resv)
					unlock lru_lock
To fix it simply, let's acquire lru_lock before resv trylock to avoid
the race above.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 928e8d57cd08..8f6da0034db9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -318,7 +318,9 @@ int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo)
 	ef = container_of(dma_fence_get(&info->eviction_fence->base),
 			struct amdgpu_amdkfd_fence, base);
 
+	spin_lock(&bo->tbo.bdev->lru_lock);
 	BUG_ON(!dma_resv_trylock(bo->tbo.base.resv));
+	spin_unlock(&bo->tbo.bdev->lru_lock);
 	ret = amdgpu_amdkfd_remove_eviction_fence(bo, ef);
 	dma_resv_unlock(bo->tbo.base.resv);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
