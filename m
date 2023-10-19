Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A777CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 14:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBCFE10E0D9;
	Thu, 19 Oct 2023 14:57:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ECD910E0D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 14:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHFhB4UJzb7hPeIKv2Zl4Pud80AU3vg8ii/wBPdpuyRHr/8mz5S51Ewn+XbHDsYuA51ddCxTIOEyMoVgERBqFnTy4A1UxlYgnVUzDlPy08vhPXpTXaQl+L/dKfnUi0Nlmh/y79kfJA/swihkX8DQsAJw1yrjQy6VZu+OvoJL0FrI9aPjSK4aUQNn0ZyPECWbL+hdYCEvZWy/fTLOAxI09nl9ZHCWnfYnMwunEM+ao3Txl7KHk2f9RzcX6nIy4DrWQLApOq8SdBPWAD64m3Qf5n4zJvZW2DPL/Kxa0XNj+3NncZlJ8axHsh8OC7299V6JmZxal8ME4/KIUSApYq1Hhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s56YTlRmGbEJ+r7ZN2xQhB3TuIa/DuB/g8tSrWnIDNM=;
 b=jlMm4ow5EzVk8HWI833Zt77VXhMrUYP2cJ4Kj+FL4ty08Bdgl0X1lF/aaK+5mjt6eaX6+/L20kSD2qwv1tPC0rrwDsbKzi5v/XCNK0ZtrFmOuLQ9p9vI4CcaNrd8LNLlwVhrzlg7Z3DvWRDh3GOT9GcCWXI2Puypi/qOiAZ+989v83G1jYhYAadTf68Nedcljuc1ThFpShZqAZkgzA9sCE8OeJgQNMN64l9rfwbIrom5GylU9iSBxAu2NrS3BdFpwU8vu9CtZxeM2yGJBAG4Au5jgutjuZk0V5H+Rxt7ssTaU7lyeVSEjHKaxsenMNv/ubisHPtpr5mOSheF+eupFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s56YTlRmGbEJ+r7ZN2xQhB3TuIa/DuB/g8tSrWnIDNM=;
 b=fP5hcjyov1MQH9OYjMoogX60h3l7PeSFVAlcH3kFzlW9am+6Kjw6QKlKus3gnQbGjlj3hNtAGUyPIggxeA7GymqICwKFvXHHoIMuHSV2v1bdr2jn7XM1pHZj/UYMpq7Plz568XLY6c3b0lOYH5foGXYUMFMEeqSn9BS3r2bYS2I=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 14:56:58 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 14:56:58 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Enable RAS feature by default for
 APU
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Enable RAS feature by default for
 APU
Thread-Index: AQHaApvHd1uIDZWQ1UiZM4SKZyJF97BRM65g
Date: Thu, 19 Oct 2023 14:56:58 +0000
Message-ID: <BN9PR12MB5257366A46B2F2B5A8AAAE87FCD4A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231019145130.3314590-1-Stanley.Yang@amd.com>
In-Reply-To: <20231019145130.3314590-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ced2f7e4-2d3c-434d-9afb-61a97a6b3031;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-19T14:56:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL1PR12MB5238:EE_
x-ms-office365-filtering-correlation-id: 3d931117-70c7-43a0-0e14-08dbd0b3a4a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HCC/BbgcezgBxW9SxX1Ub9nM3ELE/0kkiH7SPWWTsKtmLb+7DM78oUQYjCrQLASWgWmCDV4nyK39RKKon6Rei/OkjdSAlijG1N/YvUsSR7+4VB7yQ+wofY8bTfE9ywwbC43wZYj15OGye9+f4EzIRXtmSfa/OrC+WjSoF11e3nHM5tfEs7IPS04PUfmneYrHbjV5I299Noo6vsDw9vPHj6f4YY0pDLIUhfpXgoGgNOyrlzeG8hqm71Limq1PWi7KxIduLbIQANhTBX5O9ZuJpDSfnhCRuqM/fCzewd5/1S/i7QO+CrhQ3N62Gyf6xOTqltA9mMegmJkHiexmhPQI9SDORux5U9YoUra/30KajwQy5znlgXV2gKLv3FRm6bi/vXJMgnQL0CBw40xRANF9wqOjalKfxRYwhqJAcQ6ARPLpDmsJvFbkA0tP4lQ4VovcQYsVh1dvhU1UixrJeF6wsfQrpYGJibinS5uGA26nu3n2e5PSRlJEaTdgdRpGq5Q9L7d6cL830Wca8wlZ0xyDc1U/TTaboMq9B4WtjzSduZoDSeNMb1wvYpIz1uvltroUixEiHIwJaxcKCowS09o3X7yN61Ib1Wg/vEp+4mHXnCfxNW+oLNsbQX032h+hfTC9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(71200400001)(53546011)(6506007)(76116006)(41300700001)(110136005)(8676002)(66556008)(66476007)(66446008)(64756008)(316002)(8936002)(4326008)(66946007)(478600001)(38070700005)(7696005)(38100700002)(9686003)(122000001)(26005)(83380400001)(33656002)(52536014)(5660300002)(55016003)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WuBGhzsLMATh1O0M6fn52r97a/Zo6+EU2F6L9mz0gTnCxLxyIHt+0rgcLcaS?=
 =?us-ascii?Q?dllnxqBRskrAOiIvAKj50y7q0OAeN9zj9Z7Ee9rbWy4Uz8LEJgeB1f7Qjsv/?=
 =?us-ascii?Q?BjMgugvu/r29Vmtcfc0E6Yvxm41zN65apI7g8HdQwskgC2ZlskBEIA+HE3if?=
 =?us-ascii?Q?6jn3d2LrHTF0eGSG9SC/YPASwnnQIKrrFoRilTXQIlLCrgSwi7K5dMOqfnQj?=
 =?us-ascii?Q?it3nSYeR4L4iR7f+R1/j38tI957jDvvXGRSZd5KwehpevBvl3MXWXzKAaYPV?=
 =?us-ascii?Q?u1d8TppoedsNV+DXUgBZWcmyTt9lDWTd559olwRYH1uHKQ98FniUMxnsE0wM?=
 =?us-ascii?Q?7NOHHL/m6TdrjV/V95O2GeSgR+hatbJOoF27h5ou/t2ecsjWu2h3vPklqNjP?=
 =?us-ascii?Q?b+ZzbwU+CkjJdu0TnM7ODIX/jHC1L9Y3DnvLGpO8kRnfHgXXZuQYlmh5CffH?=
 =?us-ascii?Q?4siRRSIouf0V46PZSePhuXOtE9ZO32qjDm1GmR6CYgk3Nb7caIm41WgUnsQi?=
 =?us-ascii?Q?C1li7pS/M24PNTbyUOYAgbsxOhv8oUVux/b5bAHYoXGXgJOs7FKmu8fM9ghA?=
 =?us-ascii?Q?k5LLLhJpR+EmKZL3Xxndeo9nwi9x88ZCYP9Ywo4xu68c9BcP5hH2Qyk0tic4?=
 =?us-ascii?Q?fmkthNbF3gd7twTZlOqSV8u3W+/cGrtfmZ7wnjpneep2g/0Gu+cGfB9J7a1Z?=
 =?us-ascii?Q?XmUn2BqHBFmmGs0StVXx3euZ6PhI8ZUkZxTrwDBe6qBu1CppoOBcymof0PQk?=
 =?us-ascii?Q?LoAlOns0YGamwaWPX6iYfoVXS7qroYjFlpXmnW1tff45Rhr1boNVQF4FB7AV?=
 =?us-ascii?Q?ZDAsVuMLeAnihKMeE/UqS1XWCm4K+kD+8jA1UvrxE9KN+wYVCqhicGQ4G/j/?=
 =?us-ascii?Q?hvALHO/kQQgLT0kgbkySZNmiVthK3Lb5CSczJSohVO6gj8TtlhLLA3kPwOVX?=
 =?us-ascii?Q?pbOytktml3vkOZXkESW45Fx1sqbtZZdwpuloVdasMfeKuXNx/B24Ea3Hg3Vm?=
 =?us-ascii?Q?xfcz3wzgyCT73dMM6yjpDnK9VA38S5sI+/8hOp9tPmOjZZRDIpw+O5LqMNAK?=
 =?us-ascii?Q?b+2N/tp3sXVwiY3vm8RoPlq3eRJqea+Pl9psqVQSKfqtEy6Y3bgQKhXFgvKv?=
 =?us-ascii?Q?ouKvF1p95lM61rCEVRlZ/YLx44ph52VHhiKp/gw9t/qUD2dUlotKSQ4ahg05?=
 =?us-ascii?Q?XNUkMN09jKSVuu4wMmEvH3hKEdN9kgaHDbXRQAd2c/EpTtPo5F8nRqT1lhgE?=
 =?us-ascii?Q?AF1gVf9SSM+YrN+46qjdJCb3+qtdyW9krQignWHVacDmByI23CRYeahEAU+W?=
 =?us-ascii?Q?qQgBAxK570iYdJSyj7t3E580KQyClwAmYnrcT0E1fVrPDgzlxTc7wL05wXAY?=
 =?us-ascii?Q?wyDWyoYI7WG4KDmcIwf7Noz7J1zVf3FivS+rMhovMq3zHT6IS9q8z9GaIGz9?=
 =?us-ascii?Q?lRhLVFMz2Kle7IS55yKlWKFMPT2P4fztxam+t3nDbJ8R/AmQ4g9drzcMkboP?=
 =?us-ascii?Q?EUbCCSSAZ4pydqSP2f5QYJ0WosEyHjkMyEHvP/PL0cw/OwkTQ7SSdlmWVG/u?=
 =?us-ascii?Q?JwYp/tXG/IM4XmBZ6iU73U8A8IXq21RfOIjxpKf8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d931117-70c7-43a0-0e14-08dbd0b3a4a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 14:56:58.2639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8PvAVUbeqvRwmsXbknIg1zSvTqaDYeFHgilT+ZRfrrgukxPmgH9pQcoKTYl3Y3lRxczgc6DNNf0R2VJ0NDr6wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Thursday, October 19, 2023 22:52
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Enable RAS feature by default for A=
PU

Enable RAS feature by default for aqua vanjaram on apu platform.

Change-Id: I02105d07d169d1356251c994249a134ca5dd2a7a
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 01c2e8e8fb69..3dc82a213e96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2640,18 +2640,8 @@ static void amdgpu_ras_check_supported(struct amdgpu=
_device *adev)
        /* hw_supported needs to be aligned with RAS block mask. */
        adev->ras_hw_enabled &=3D AMDGPU_RAS_BLOCK_MASK;

-
-       /*
-        * Disable ras feature for aqua vanjaram
-        * by default on apu platform.
-        */
-       if (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 6=
) &&
-           adev->gmc.is_app_apu)
-               adev->ras_enabled =3D amdgpu_ras_enable !=3D 1 ? 0 :
-                       adev->ras_hw_enabled & amdgpu_ras_mask;
-       else
-               adev->ras_enabled =3D amdgpu_ras_enable =3D=3D 0 ? 0 :
-                       adev->ras_hw_enabled & amdgpu_ras_mask;
+       adev->ras_enabled =3D amdgpu_ras_enable =3D=3D 0 ? 0 :
+               adev->ras_hw_enabled & amdgpu_ras_mask;
 }

 static void amdgpu_ras_counte_dw(struct work_struct *work)
--
2.25.1

