Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4777C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 05:05:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B37AC20715
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 05:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P7YhvvOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37AC20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79F276E301;
	Mon,  6 Jul 2020 05:05:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE5FA6E301
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 05:05:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUunY6SaAsUsThUrUrDWZcyZqRcF3+CQ9y040pPkHpAy8G7anN7KnKu5Cz+UXzBr0bFUfHW2mwnOg3g+3akItpC+Qxt2Yy7KCA/0dqOM9zi72i7ZIo3QNG57jCseGrSuOxeeYf7Uf7OCB0Pgn79ajv7Kp8E63PEmLYH6TopYtGUFsD/sgXBVZvrEerLTbPiwDQ1QdifPcXIlh6EPTagFIT4y4fhVvzw+Qhma7igdrxji6shmk8T5C/PKrIrUiFg8j8/UZRP9ZiZQqyV+8EFpo32TXsxWcbDVvnR5LhKy0UpzrOJbwiLAwjoczSKg29A/TKcsOlzHrs9Kxt1DZ4h9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBLziQfQoXWosYh+sGUre7LvDGSVUgZepm+2+W7SplU=;
 b=J31iwwcUGr6nY6smAsX0hYXaBtywOxgCP2c7azkxbBDBYWoyuTf3y2a2yWtL8mPc8vgSh+McbxpqmlMmC40a+D8kf4IOMjAca2YWQRWTYLL6BwECkrQXX6EfEmidV0sEZGARpO5h9ed9TccHHxSkhtr5Eywe4u12aglOShtv52Y2ZTB5+jdjA1RVEhde3W/Yp+axqlR7/3spi5Q2pcPP+Q4f++Vq2Zx9sjMLarnU+uYS4qBHRTaHDLMxwbyZjQIZK8MQn7lffyl+k0t/cI+ERv+K89SUORLFVYi0nJWxVB4YDmJKpK5JvL33yAKdKhbR0h/oDDkHJbQXG0lKfERxfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBLziQfQoXWosYh+sGUre7LvDGSVUgZepm+2+W7SplU=;
 b=P7YhvvOOT/WXiOHDee9cRxhWJTpWy8cKshsL1Karot5/n6mHzdb+DcdvWMUUnASNeuFgWAA/f1D/0n++WKq8RKFDn09hEFx71gRrNCXUA5Eey4FEo8fQLeCmded6yMhHH54aYp7KoovLUOx48tvhZ2IzlCle+NnPHLQpaR65VkI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 05:05:47 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 05:05:47 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/12] drm/amdgpu: use register distance member instead of
 hardcode in VCN1/JEPG1
Date: Mon,  6 Jul 2020 13:05:01 +0800
Message-Id: <20200706050509.714975-5-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706050509.714975-1-ray.huang@amd.com>
References: <20200706050509.714975-1-ray.huang@amd.com>
X-ClientProxiedBy: HK2PR0302CA0017.apcprd03.prod.outlook.com
 (2603:1096:202::27) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK2PR0302CA0017.apcprd03.prod.outlook.com (2603:1096:202::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.13 via Frontend Transport; Mon, 6 Jul 2020 05:05:44 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 46a7b774-e65d-4d0e-b249-08d8216a3e3c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4470B57A006A5C1A3B6A0EB1EC690@MN2PR12MB4470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dSwFgmqGxMUJ4c9D4L153Wo88mXILK8hbHQ0cd5A2O9TSTl2iC2lZ3FdDgPEIdjq0pZadHkkr5lJedzvfRRFkQslyckD96IJM42ptYKbrXP0iW6bPovlwRkUBXxcoLlWElauQW9VgAqnak0vCfqvkPp6seRhdSMELuRiv223M3O5KyuTFBXAEXWJGfOVrJZKNT4whpu9D9M7+1oqbdg+NVK20lMJLv6x7kgvZu876fmoIZ9GoW9pSwhRX+G66RXvyFSiUgIlLOcvEL6aeXTlZxOAkO3nldDgqA8LQfslMBPh6Bo5a8Hos1SrbZEaihUdBUgkuymBx9q0Q0mBShd46Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(6666004)(26005)(54906003)(66476007)(7696005)(52116002)(8936002)(66556008)(66946007)(36756003)(478600001)(5660300002)(86362001)(6916009)(2616005)(186003)(6486002)(2906002)(316002)(1076003)(8676002)(16526019)(956004)(4326008)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Xd+vHx6pSw6Z9m1WT/lJmPgjBSU0hfZwRUB+UM+HNeSuIi2Rm53aMwf6sXZOEq3dFyl9loFV94YydvZ21lyUbUmsxMzyXbrEACQ3CLrsWp18zEY8ZNI6ebH1rG678c1Qkivu6eDyhEyQcqrcijcDBdTnx6bgz5MJktk4iXzA8xquiVS9jsVjdphYJ6LWBUKvv+CK4K+5qQBaSOT2A4vUnPEKXw3LDXhon1nvMloRtfOvm2HCj11hw1KBzyK4XWKOfR8hZ2hT3+VaMT8brO4EOFv2bLDuxIIxGsR1dYEfnuQhX41cEhzo8ZwrghcK7W9YmxRurHfPxxS9y3ypGqt3f12R/Hv722g8vZROrQDnjr+JyXn0Jl+YQDtV2iTVV4WxzzwWvSOkRotIULL8zils8HxBX1RdA380mUq8mAN4pWPyYtWK3BTXBRY14E1qFyypJo/OfF/BWa9V6S3FZb524cY5ot8y+OpGDSkvXU2cue+bgVov9+c7T8+wiiHw4PXB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a7b774-e65d-4d0e-b249-08d8216a3e3c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 05:05:47.1168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxZBWGLiPs7lZnEALZf/XNGj821UWI9c6/Bj1MV1pzBRAq4J2zqJM14AEe2ei8WeLGaR0svqFwlSioOLUiJZdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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
Cc: AnZhong Huang <anzhong.huang@amd.com>, Aaron Liu <aaron.liu@amd.com>,
 Huang Rui <ray.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Leo Liu <leo.liu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch updates to use register distance member instead of
hardcode in VCN1/JEPG1. They are for the same ASIC.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Tested-by: AnZhong Huang <anzhong.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c  | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 4c6c7544b400..bc300283b6ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -377,7 +377,7 @@ static void jpeg_v1_0_decode_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
 	/* wait for register write */
-	data0 = hub->ctx0_ptb_addr_lo32 + vmid * 2;
+	data0 = hub->ctx0_ptb_addr_lo32 + vmid * hub->ctx_addr_distance;
 	data1 = lower_32_bits(pd_addr);
 	mask = 0xffffffff;
 	jpeg_v1_0_decode_ring_emit_reg_wait(ring, data0, data1, mask);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 6dcc3ce0c00a..927c330fad21 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1539,7 +1539,7 @@ static void vcn_v1_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
 	/* wait for register write */
-	data0 = hub->ctx0_ptb_addr_lo32 + vmid * 2;
+	data0 = hub->ctx0_ptb_addr_lo32 + vmid * hub->ctx_addr_distance;
 	data1 = lower_32_bits(pd_addr);
 	mask = 0xffffffff;
 	vcn_v1_0_dec_ring_emit_reg_wait(ring, data0, data1, mask);
@@ -1679,7 +1679,8 @@ static void vcn_v1_0_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
 	/* wait for reg writes */
-	vcn_v1_0_enc_ring_emit_reg_wait(ring, hub->ctx0_ptb_addr_lo32 + vmid * 2,
+	vcn_v1_0_enc_ring_emit_reg_wait(ring, hub->ctx0_ptb_addr_lo32 +
+					vmid * hub->ctx_addr_distance,
 					lower_32_bits(pd_addr), 0xffffffff);
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
