Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C929C11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 10:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B3E61D4B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 10:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B3E61D4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8270A89870;
	Tue, 29 Jun 2021 10:14:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 743DD89870
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 10:14:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnZQ8faINSi3DA52tUBZvoS5qpgacm3SZV1NHutlQw94qcsvTwPNRPJQ6fXtG28JY1UgxX7s/t4PwzhDokF3Q6H3h2rsVYQENdKNqat7wPf9//tWjZw95d25jWCtQCWQ/SeS1JWfXZBm8cB4o7pdWTIOOjvd++oKRhjjwQiHzi5rqCceRJQKbhmmnhg7bN6xHx9r3dm9RRtOtyKwnYu81I/ZUbWZvHJoeKxa97k+O5WM3fJ7UlIyE7Q2ec6NBxjgcKLmO7uAxQg7uE3pvTdsdwIIFBDyuYVEkqZlzSHjn0SLQp7a8/fcJ467CN96+nFjjQKuf99I3N2esW7j2RyAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aES6+gN2HOADG3kzXSF9rZYfdDcDCcD698YHk9lhk4w=;
 b=eIQfpzqS+orR3s8pNXZJdakJYZBXJTNvu2Mj62/eI6//7pDZc2DQHDgA/PF1aOqUf6qW+f/1meWQ4RZcpbgQmdBUGrB9gqBSWZP3Slf0/k/WwqK/L563NZPFCnjNwKjSrA5BNYT5ppaApmrfXN+kO8bmWSPpHzU5IAJA8ApKayA1Yi0yShL6vv33Oe/1FbGUEWz1jIedH87bWH+YCkTnTrNbyg8Iw3D0fLk/tsz99EyoT7cL6BOuX7dJpiBoxkpEInJF5NxkV84M/iQWxuCDHHpOsJVNWYN1VsAs/pkbTtYtFv2H+XXHJLsuU3jNeGNUZCKqcDsjA6ygza+nNZ3jKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aES6+gN2HOADG3kzXSF9rZYfdDcDCcD698YHk9lhk4w=;
 b=V0CJzrQQxn8RnhBLn69GEPxztWAZ3rWQAywU05tb24FvlLtQ+y5OSvyUeD1tW8mpIFslWoFwnFewWeKyM0uhQsV71NSHIBfAwnTJBiIXVoUS2hvaVYX4M5ihkxFNsyeaEipPLaqb4aIqwtUDmCHm1YMi2OLWDaztd8afYnl5BKY=
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by DM4PR12MB5326.namprd12.prod.outlook.com (2603:10b6:5:39f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 10:14:34 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::9d6f:2218:2f3c:a383]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::9d6f:2218:2f3c:a383%3]) with mapi id 15.20.4287.022; Tue, 29 Jun 2021
 10:14:34 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce
 delay
Thread-Topic: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce
 delay
Thread-Index: AQHXbM3B9SgDtz7zZkeEUK2CelbyAqsqxV4A
Date: Tue, 29 Jun 2021 10:14:34 +0000
Message-ID: <DM4PR12MB507293A13885AFC95F7E2CA4E1029@DM4PR12MB5072.namprd12.prod.outlook.com>
References: <20210629100129.1913032-1-YuBiao.Wang@amd.com>
In-Reply-To: <20210629100129.1913032-1-YuBiao.Wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-29T10:14:32Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=280f4b29-cd33-49c3-b29d-00003100859f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-06-29T10:14:32Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 62fa7015-970b-44b6-8b78-0000218b3c34
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57c458db-dd42-41be-f2d1-08d93ae6b19b
x-ms-traffictypediagnostic: DM4PR12MB5326:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB53261D427DAD8C4F33576A73E1029@DM4PR12MB5326.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8qTki5pWoiFewOpM1xj8c5HiHCnyhmd0ottenXuE2k7KQJ8pnnBB6O0fSlHYQjREXIRClUcq1v1+CqTIZsSA/GjjKv7SYOUQLzW7SolBckMgQHywnuTHUusoCGsjrUQbSTHQhqnTWYiRMouAR2jh6B7r9IiEEh6nhOYHNIZwyl7DjNYpHdTm/OCTBRJ7fsE9WujcLi5Y7AqAJSLBZ5zaw9eI5pcyw6C1WVhFLPt8QsnnrB+k5ZqzX3VLUvNud9FwuE2K5UoTvUHgcB3in162gBofg6ZzEB2cu2n/XEX+ntoOKrCrW+AP42tdoHDarQPOQ3Qp1JbQadKNi8s0oZ2/ZSqpkAhGWcjWVXo6lou9nU2zxhzso9139AJslXIHBmW/tcKHgE84nLDQ44/wNvEg8CQtM5ogFyGS0hHyoVNJbHWOQeX5B1BrD6z0s0lfNQGR3XcItzX62APkKc+8+ND+H2u/7wOdD4UPWjqTTU+2rMScCmPprKbDYCdpaSktgPZKH6MbGWf5j/YUQX8jEDWalNKQoWucIqvE+HLClk5m4TPHAgUg/hUh8258GDPUM+HbRgl+Ix5EfEwpwEE39dqZVFmIoJ8vfA6ZothHZLC5tkEr9NEZNAv430YoJ1e53edD1b9pgCYbDcjQt6jKl6dCqw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(26005)(71200400001)(54906003)(316002)(52536014)(186003)(66476007)(122000001)(5660300002)(38100700002)(110136005)(66556008)(64756008)(66446008)(76116006)(6506007)(2906002)(478600001)(4326008)(53546011)(7696005)(8936002)(55016002)(9686003)(83380400001)(8676002)(66946007)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L+mYyplMNPX/itgfOOQg3yIsxeYtFHeQKjvS20Li8U6gTyUNQPodxnm7TYul?=
 =?us-ascii?Q?TFjbbrf/3FQzE8bmq5AjmOm0iSe2wwt9NJijrh+I1XmHJjRni/Hfwc00j6qn?=
 =?us-ascii?Q?Gt/JT83IMmwcW1SBQ92XB5r4MnfeWb4kDZd3jOPx9X7BM0fzbNPNH7RHD42n?=
 =?us-ascii?Q?xrgSEY10jQ3arag2slE0n/Q6HGh9VjA8pO9mR1NrkF+AqJQVXJGUU4D3X8pP?=
 =?us-ascii?Q?5Q5ztRqMlOs17gGDPaJkpBdY5CAuIFh53rxASMKCIrs5MGTg7kMGUfI7ZMcu?=
 =?us-ascii?Q?VIX4bz1zqZs+6Wl3hsPT1kLCUNPrnIzGjThcSbovJPO5DVwJBEH5L4MpWS0N?=
 =?us-ascii?Q?6sDFYPD128Yd4+dh95Ce14W6/XCaMMTg4SypRjpssnoOX8a2EkXKgFD2eIMR?=
 =?us-ascii?Q?pAqe7ezFVNkL3CFv21qHoSN2HSABClF0KwOneooe62q935P05lRyCOFmTp/S?=
 =?us-ascii?Q?vpUoWAQBWx5ZxBPrd1C4Aj2X9WZLDIXRBGU2mTQhiIBR4MC2P/kq13TwTvYm?=
 =?us-ascii?Q?urxyyjQ35XB4YSmIZ8JxAWF8bkbrQtVWFo578oUSVjH5gLfPYtP0aGYmsa1t?=
 =?us-ascii?Q?AqCiJRYPOoAiBo+lHG+4fuS022psPZnvHZ3Ysxa7Zbp8TilljIqaYYr0rOFQ?=
 =?us-ascii?Q?gD4odFKM0MHGlcMFLcatjN1sOxmQKOZFRoQT8LzLeU697PWZQvbLfdJqh061?=
 =?us-ascii?Q?dj8T4Uo1TDvTWMKW4Vuh9+9C5mjxHmNSM7RRmsxUN2NWDl52AG9PK4Gp0YzZ?=
 =?us-ascii?Q?NbsvgPm1zlpFu+ihbRDLFOp2C8aTbvaMikRr7A8oKTODEo511EOo0b9utB/i?=
 =?us-ascii?Q?PDe4k3FFGc5oOwKwH5jAljgZFNcer0x3xVSN4gLgaMOa0h1jT2hPqfrNRwZJ?=
 =?us-ascii?Q?41GyjgPwD3HcZHtW0PpP9QPrtZHBbYIlzwazZkqtVwInGh3s4zli2y0nWXfm?=
 =?us-ascii?Q?swczGDz6ZMmNa3cvUWLa3pamL8vMxyXYytgBUvh9AEv2q5xS4yNTOzHoEIeH?=
 =?us-ascii?Q?mrMpOrwcmFupFQ1iJDkb4SBJWmj5ZE6XlQTR7e0OW9V/LkdnUmWP9QHKag8V?=
 =?us-ascii?Q?QeMMMachmXTKKojOoIL+8sYdRCSuqv/TWVI2WxgPChN/oMOfrh6+jecEwjre?=
 =?us-ascii?Q?5++Qqv7hrNFnJawORw+01Kk8kMEpSq1vIRI8fR+NmFzkhrYimvohncekqUJw?=
 =?us-ascii?Q?9zSnj46rUEeGlONvCKrY3kIgMr1GJCEWDoeiiG02CioQOmZwrOMaQ3lbGKJB?=
 =?us-ascii?Q?qsUfxTt50GwCr5Bwey5xIXyeQP4PBi5XeKQKE6WSVoK4Eq4741z0n2+8bVGR?=
 =?us-ascii?Q?tzr+u/FXAlpDkuKO/oKptwDU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c458db-dd42-41be-f2d1-08d93ae6b19b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 10:14:34.4669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eWOQXIcqTiah6yWz3u1SBnBnwgT0FYEMcodfeFlUlMpmgMFVXT4nXK40xfDpmRSG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5326
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
Cc: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, 
 Feifei" <Feifei.Xu@amd.com>, "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Acked-by: Horace Chen <horace.chen@amd.com>

-----Original Message-----
From: YuBiao Wang <YuBiao.Wang@amd.com> 
Sent: Tuesday, June 29, 2021 6:01 PM
To: amd-gfx@lists.freedesktop.org
Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Wang, YuBiao <YuBiao.Wang@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce delay

[Why]
GPU timing counters are read via KIQ under sriov, which will introduce a delay.

[How]
It could be directly read by MMIO.

v2: Add additional check to prevent carryover issue.
v3: Only check for carryover for once to prevent performance issue.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Acked-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ff7e9f49040e..82a5b7ab8dc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7610,6 +7610,7 @@ static int gfx_v10_0_soft_reset(void *handle)  static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)  {
 	uint64_t clock;
+	uint64_t clock_lo, clock_hi, hi_check;
 
 	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
@@ -7620,8 +7621,15 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Vangogh) << 32ULL);
 		break;
 	default:
-		clock = (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER) |
-			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER) << 32ULL);
+		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
+		clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
+		hi_check = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
+		// If carryover happens, update lower count again.
+		if (hi_check != clock_hi) {
+			clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
+			clock_hi = hi_check;
+		}
+		clock = (uint64_t)clock_lo | ((uint64_t)clock_hi << 32ULL);
 		break;
 	}
 	mutex_unlock(&adev->gfx.gpu_clock_mutex);
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
