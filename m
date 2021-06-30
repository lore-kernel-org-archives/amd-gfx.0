Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53B1C11F69
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 11:17:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A939961424
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 11:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A939961424
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 625E26E0EE;
	Wed, 30 Jun 2021 11:17:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 818A26E0EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 11:17:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSp16kmqcpTpwIkN6twnAznJm189W2qAErtDFMxlnrWscXXj3dllijR4bNyhivQ9bEJuNpGf+8/WQVk9KaRSLDSI9r2DH3W+v0/ClXqkexUw0zpHjyWmnLnzlhf+W6BR8GhBb9J86/UHxzkLfgk83nJSgc+JK3iyZgtvG7xJrz2czOc0iuvWA/MYlvry63ITSFiMOTv+3yBEG40X77b4xu8nzTS69wXaCUkfuO+VGLMPDbYpd4k8v5SkQyvWYrHF8t8Fq8RCz0uTKqHi1wSavUVXcc+7wutS/X47EPm63FTb8/ZzczgaAKWNOjGdlY0JXVGqrOCnGUqF7b3X0ynWiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxUEHMZ7XcGo1y+bV9F2tbX0cJTKWBMeCN0mO5HtGzc=;
 b=V32CB1xJBmquG38YgwDfOUfi1Q/lSHjswLoCzJDmVreH0zexjVkBF6j3yfbn0FUBeJfvJ4I76fET1YwQmcePQSRmIcypx96bEbAjGi8wWcSp5beVcnYN6F5NH8wzwsFrNzc8YOn19Gvx+UM/gOkL/jCPnprUUUMnAY9WK4MVwA+VLwlpcNxuKf96y6uu2DseVVejbpMlswKqFOwjX0/IrQ67/LE4TEHIEVEJba2nZcK8thtivXBCsncEkAMyj0nvh/IDvpc6FMqMgiRB95zfk8lA1taP61PwDpVpQQabh4nClMWEtIsf7o7s7gKdB/xSa1MBYSggyeHn6+ClahGjwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxUEHMZ7XcGo1y+bV9F2tbX0cJTKWBMeCN0mO5HtGzc=;
 b=pAPNbEFHw2vlDtq9mJIkcaMHUhdB41WWqkcFi7L95k0O1jfESXHiXUoFNWHot7qvRu86AeJ4SJhKH1PbqNTuADzmqdnxqA6vk8GybsGxY1ihy8I6YhL6aaJ63XK/bmz4enWNNtM+4b3/GW3NXhpdKDLGigteMEVkRkdKA2dwPdM=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 11:16:57 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3%3]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 11:16:57 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce
 delay (v4)
Thread-Topic: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce
 delay (v4)
Thread-Index: AQHXbZgjyw4N2Vyxl0GwG8mHBUfpOKssZ5Jw
Date: Wed, 30 Jun 2021 11:16:57 +0000
Message-ID: <BL1PR12MB526956A68E4AE0F505B8015D84019@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20210630101012.2006307-1-YuBiao.Wang@amd.com>
In-Reply-To: <20210630101012.2006307-1-YuBiao.Wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-30T11:16:56Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b96655c1-7e80-4862-8740-60792166d0c3;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94b0cd70-da2d-4efe-b890-08d93bb89302
x-ms-traffictypediagnostic: BL1PR12MB5192:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5192BEA2B9B0B91C1FEE70ED84019@BL1PR12MB5192.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JVVv1GJojef0d8vXICRU1DK6B4eyj30LZq6ftp8Gew0RLGFwqY0SAf/8MIxyFT9yQuUT9amLWD+V6RRPywb5mLsOqaEbpOvYxtlS+oiGBe2AdNpyGQ1e0VDtHfj4NMy69BWerABGq/lvcXKAmhCigFSpHKSblZMzc71QAb/NcnoqJY85YIo7puB6R357Tev2HjDs2Rp4y6LVqPhpC6hQMhyy6VDXYwDCnn10it8J8731ZHlqnat59ld15pRR3uyf7r4ixfdyw8pqF8mAGgUdjFhluYsqaOtzhbVllqMQh8iEMEiMB4GPj1c4BNAo+Ns72kYNeL/p1be1O3+wMC85bPpC/I1mkWIrZDJpOVQCZMWxFcwe2Wy8KqzryQf348OX47TJ3pSEkgGWL/eS0eKs92x8Uh4egtiRP3Ok7DBrPd14Das4U250/g/ux1Y8tSJmjAym+HMpXT42C0LQiV7/xJgW8nf+eQXZsCZkPd5dRI+yGuxyw/jYNq9PtWFatUK+aJK/qzymuT+R1lqoRQ6lC/qlHZgaukc3EYnRBzb8ExuOkd93bfdwIdbAW5QykAgX4/PHfCjxQ/uiw+pkiPX51skQxNMmPnRyav3nhroM0kqvyyRMKIw4NPwbNtfNLdoDpaiCK18Jk8lRj3DYNPBZsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(8936002)(54906003)(66446008)(9686003)(4326008)(64756008)(66556008)(33656002)(316002)(76116006)(66946007)(55016002)(83380400001)(5660300002)(71200400001)(8676002)(110136005)(122000001)(66476007)(38100700002)(478600001)(52536014)(7696005)(53546011)(6506007)(186003)(2906002)(26005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mL/Nt7TLJGdeRgYP74RO+iHo6g16eVRzaqlDY+0A6phTcBS/BtVth6e534+T?=
 =?us-ascii?Q?v77lwNZj7TtDPidPBdNBXU/K4ShRo4IBGr2VLKVuxllJ0zJiDIklSfF0NxTb?=
 =?us-ascii?Q?SqvWtrEWp/Rfo6kHjuEv9vIXJy1BXg/8omDJyZXKZCnr+riMEfWmxYxv0D1y?=
 =?us-ascii?Q?jIpzpDbM/I1Jt+kKTDKx/WWOerbjR3ZpnbqIxaG0I9jn6WT+9lXFpx0u1Njn?=
 =?us-ascii?Q?0yaGHhGki3EHg/jozoU3AvzpTT0o/X76D6nRu7o6m6SLCL0ComHpbX0M72G1?=
 =?us-ascii?Q?wz5Jk14KpP0b5lpGYMJNG4CWLXRmyVRZVQPnqdguH7usdM2UuOydk2ZJZn7t?=
 =?us-ascii?Q?kaSwBRgD1qMpvTMLHPhS6vLLp1fEZoG5v7SI/eHI7nAu8OUzKob+cnHNln2J?=
 =?us-ascii?Q?HcY0nyIfvgkK8TGyksa+IJGLBOHzdDB6F8/HGYJ1NRDjtWgHBtRffpDvZiDd?=
 =?us-ascii?Q?qPJQ3yDHJE4MA/myj1uFncVzo/FbljZgZbDHRPEC5kGjf7NAFjkJa10mC8f1?=
 =?us-ascii?Q?hcJbfjtll2NPeO3t2fsBcD8iQ44DGZb4lFNfwl05QJqU4yHZnQ7fyCAdqbo2?=
 =?us-ascii?Q?fS3hkrYL7IXaSD/gvr7L5kEpNJ8P4JWdwzwy9HZbkgIIX0OQ+YODMqka6lvh?=
 =?us-ascii?Q?pHOx4uN4s+YJDz5IqE7XX0d0GyO2KJPU+KOr6eyM57Z+SdERWOj7l+RGqS2t?=
 =?us-ascii?Q?inp6WV8Lre4j0YleFoWyf/z1I+JBEk3mPNR8OgRBXI0RYnbCKheaiAyLHc99?=
 =?us-ascii?Q?x2pa0ruTymmwjEuPEgkq1wZkHQnW8JT1O+O88tmF616PYlkxQoDyHNBBQuaf?=
 =?us-ascii?Q?AJFiU/J4Rpuny95pb9vcdgx7f5a/mqsoPXA33+wFUn/IlaRDwXov5T75iBe8?=
 =?us-ascii?Q?0NgWH6dGNMsoFkWNOTYyiM4gBC87uelu2x0Ts6U6Bu1e5jjOv402Qhz4GZXe?=
 =?us-ascii?Q?XQ0af4UZqeCcaYRtmgHg10rRjnxo1WrlcYmjboXhPnRkVBX55VmoOqMqTxYb?=
 =?us-ascii?Q?dD8NGoBQB9gejafbPIfHW6n/Lj+zKwPWqamMnkQI6gTqjJ/w3bkq+c5ryF1t?=
 =?us-ascii?Q?quU5saeRzFakg0bjiFDCu/3Uq0eqkoi8HYGypBURUoxTCiXjjfMTXlHnQ3Z8?=
 =?us-ascii?Q?uiHTDAAAl4kmrc5xRkLfeiH8KdO1VsSL65JJfhHZQlhXUgs1bx0412FWxy1v?=
 =?us-ascii?Q?wNW3jwFB8Rd76ehEFRgxZTvYvz+9zUyl3dsFtT4rv1EDioQxBEO8ejawNcDP?=
 =?us-ascii?Q?YBMMvrgVLKcU75i6l0w8EI0KgJpt5fqeebaGbFzF0JqRsQKY4M2miiHoSijn?=
 =?us-ascii?Q?+DZdLnkPEuhs1Oeej/2aMibi?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b0cd70-da2d-4efe-b890-08d93bb89302
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 11:16:57.4413 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vc4l189PTkIKArxPP/5WgwFVCA+e62bZrSBcQQ82pbMVkFbHLbb22OfubfDfey9P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
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
Cc: "Wang,
 YuBiao" <YuBiao.Wang@amd.com>, "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>, "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

reviewed-by: Monk Liu <monk.liu@amd.com>
Thanks 

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: YuBiao Wang <YuBiao.Wang@amd.com> 
Sent: Wednesday, June 30, 2021 6:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Wang, YuBiao <YuBiao.Wang@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce delay (v4)

[Why]
GPU timing counters are read via KIQ under sriov, which will introduce a delay.

[How]
It could be directly read by MMIO.

v2: Add additional check to prevent carryover issue.
v3: Only check for carryover for once to prevent performance issue.
v4: Add comments of the rough frequency where carryover happens.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Acked-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ff7e9f49040e..9355494002a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7609,7 +7609,7 @@ static int gfx_v10_0_soft_reset(void *handle)
 
 static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)  {
-	uint64_t clock;
+	uint64_t clock, clock_lo, clock_hi, hi_check;
 
 	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
@@ -7620,8 +7620,15 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Vangogh) << 32ULL);
 		break;
 	default:
-		clock = (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER) |
-			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER) << 32ULL);
+		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
+		clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
+		hi_check = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
+		/* Carryover happens every 4 Giga time cycles counts which is roughly 42 secs */
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
