Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A47C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 14:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF046103A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 14:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5DF046103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC0E789B8F;
	Thu, 19 Aug 2021 14:36:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C61EB89B8F
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 14:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlrfMMui6+56aEPF98NjxIk/eUnVlwgpPdiM1LCA5YmjWnTLoLdtwhudiN/bR149k7WwiRhISBqRz/rw5vc0uMyd5KwwQWptHmeliKSEekF7ppvE6qFyEzk3TIVYlTJnFcx5bq7D3mK4zIxHEeojuCT/ivySoRGuATTewwGU2ASiGJIVmCiPPnbHtVt6I2t9MjilaZFF7aA1Et+Qhuf41s8Yd0hGJ44Sh/SEopM7NYkBrfc9Q4UMLK68nEXjnLX3BD2B1aNLv2XfkK4wcYWecu5epHcrv2ugofvWeZQMxeApDZ2UnLE6tA3rk7P33NwkBDPRwEGt4Kbi3alBs/J+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNS86wCnoB2t9zdatrRHsjgLtcqdv3BWy4G/B6XyeSk=;
 b=VEC/CFQoTJMU23emo5jRJDyU/ULsB5Ax+FTs3XT6rDcOcCu3JZ0aVAUFQHc1zF0DwYGrdOlHHM+u3qgAx1dwipR9opxZiG4TE/5vcw+ROaiZ7TvRPOAHsjbup96REXLOCX/Zc6gjaXOXbsnzjcgxS4NvoO/2m6ZQKACmvbXsAM7PJoGb6XgWZrQ+v5We1nOlF8klIjYAVORP2gs0+JWqEw0YYrsZ8bkQzpC5zTnifPiwa5u62pOYb0vFpGfFfokBSZSz1UVJITUOcgx2WJzlqdtnr6nHwJIhazpp4SImCqqOP+5Z6k96ocjbP5NScQgys+SNb4JXWiZR7Dq87m0j3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNS86wCnoB2t9zdatrRHsjgLtcqdv3BWy4G/B6XyeSk=;
 b=K3iC4pSKL2KNjepGUwbcAQgzz50PSE3I4KrW3Mo2xqE80F/JFeHKAAOuvf3kulPLX0abopWmf25V6vJIM7LXRh7dN/I/bCmAHxkp9G/vZXtjKDIfIbrrFzfeY6k1u6Qis2g6UjniUYEhTcX7DCip7uGdy41970gfQ4TVTt8/VHo=
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5143.namprd12.prod.outlook.com (2603:10b6:208:31b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 14:36:24 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 14:36:24 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on
 suspend
Thread-Topic: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE
 on suspend
Thread-Index: AQHXlKeZqnvCYKWpWk+D9P71kRR45Kt64RiAgAAC74A=
Date: Thu, 19 Aug 2021 14:36:24 +0000
Message-ID: <BL1PR12MB5349E230CC22C6031E03DE9097C09@BL1PR12MB5349.namprd12.prod.outlook.com>
References: <20210819030859.1470753-1-evan.quan@amd.com>
 <DM5PR12MB2517FA1095D8D016C2E784D5E4C09@DM5PR12MB2517.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2517FA1095D8D016C2E784D5E4C09@DM5PR12MB2517.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-19T14:36:20Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 636dfb96-2cae-4291-c050-08d9631eb892
x-ms-traffictypediagnostic: BL1PR12MB5143:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5143C6ED5A428D8636BA97AB97C09@BL1PR12MB5143.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FnFGii2MfXkOOeSPBg9gnMuMO3BNplIFWOS7qrIpadnHhLcqJGcmdP9A+76+Uy1Gh2EWI8y3MAPC8ZVbVvjyk9uUr7mkKzPbQsqyPp0a8IX3fQe9vMemof6zgj+hQ13UPKiDKh98jsfjXYNS/kJplCcIncoL+UBbSm3vZ3Oi+X5GucQFkHAmJU9V5tOPwnfY0NAgyxyXC+Pa/qf0WRzKW1cRQQGcuhAs8sqP43WZIOzu8/3our0Z9FuPUZPUinsisuhXSBs69ZpEVMLhG94ATlkzQeZnmdhG9oBRzR6CSXxVGa0cdgSCeDudFufxgvVp2HcaeXQxgkw9SNV84989TD4Nnb66Oa5qLNHRRfh+lt9pADIaE4c4FlY8hzwHz82Wtc7pNGDCsvbxRMhhwffOwQf4CoiM0Txh9Ta6Xgiy5Q1hNjw3JpF8Q8JanDmWups9ywunoY/KuhiCKIRlsD8JDPmU7m3qkKBqLw96UpStFsfyqS5pGmdvH0bZRQkIoO638Xinzy8hyi3JGh0Vj/zxONqLNWJs76Qa+CiwvXn9oI/IMv8MyShH5PrdZfbxS2b7+/IvRRMP+ly3kd3VHpjLYjf5eFcVyHfrEEHMwRKnbr3jdnNTsWHR7liw0ogkzn8epXo5yzBaHE7DkE2OQ7todxRdFGuYgc6BxjUkrXdAFJM9miC/jTYHV39atLwASrmyuI+9Ixi5cW1Bf/V7QbK0GA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(478600001)(66556008)(76116006)(26005)(2906002)(8676002)(186003)(66476007)(66946007)(110136005)(6506007)(53546011)(9686003)(52536014)(38070700005)(71200400001)(66446008)(5660300002)(15650500001)(7696005)(122000001)(83380400001)(38100700002)(54906003)(316002)(64756008)(55016002)(86362001)(33656002)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PWuMqsQ0Vw1h8728LgzOTSdf8IxF+sR9j+dESIY8eS8goQavKdnK/b382HlV?=
 =?us-ascii?Q?GFZSeJnW7arsX2GUPp90ympbq6NlVW+fuA2udyybP6PHl3uQAkXv1woKXDY+?=
 =?us-ascii?Q?xKNzAbr8OKyXnoitFt4RywEsUv76l6D/k/pV2uBS/BD33bM6o73lpA47Ecvs?=
 =?us-ascii?Q?CLAdMLRZ6qofi7R6Z1fW6aoOk7m5R5Qb8pYybpMsFC5iHILipB6zCtqiNjcJ?=
 =?us-ascii?Q?Brdwui4adoi51BAmOXSXpmbmAveB6Fbhsc9rNMLi48H3lpWU0R3iDQlBgL15?=
 =?us-ascii?Q?421bPnGXoB5oFerVnb3MC44gw1QsPrwrIKo5EpvUZmWQF2+8cds/Dky6z2Pm?=
 =?us-ascii?Q?YiewDgHFy6BVi59eg/T5p5XZXmYXjSUWqkZhSuUObqbrRH3r4UdmiYqQxUXn?=
 =?us-ascii?Q?BvI4bGvUq89ubqPMO1DmzPpmJ3aGbk/LSNhVhfIG2pwOhbg+QblEObgkNNfl?=
 =?us-ascii?Q?73R8h7Mdhe6hflJtpOJhVlNiIb9VahCy8108SjDWIneVjMrZFSKlcFP42XUB?=
 =?us-ascii?Q?oxbyAyTa7ypnj6o14bJnCdAvpk0UA1vs9X4eHGTD0Pc7B4CYgfDyTomBF0aD?=
 =?us-ascii?Q?VwTMFvbEQME6P7riWVXkPZIbeUx6qms/JxUcJS3F7OJRpftqobdNO6DnW2C1?=
 =?us-ascii?Q?Im+LDoyqd0Jykr+Kmx+hDTmBwRMoc7BBlh4IUbPrgN4wnmhWnmmEt3JXANMU?=
 =?us-ascii?Q?uKtaHEf+5R4DeS24uhUFDYgwvx7V0Vlh86PrIJPf4xt+sOQeW5zhIhMyoWib?=
 =?us-ascii?Q?M/f9wpEgzE/jOrbQ7K853Q8pb2N+wqzFAc8YsPWSfX6xW5wz3g11VTUAbMCY?=
 =?us-ascii?Q?JaeHubrqG26/GFCwUqgeyY00XcCVD3TFRxT8t20H35J3GH53JvRjVIJoGUY6?=
 =?us-ascii?Q?+WkKhgED7hoPSLTdBHzs0Z+M5+VL4jj+qTcAW1EeWNb9sqE8Hv1c6AdglANR?=
 =?us-ascii?Q?Jkg/F3bdj5aW43ZHfOA4ZcNUIep35VHIKnPMoGqXdmhQJlXpvAmTmlU4gkZ+?=
 =?us-ascii?Q?LMYcqzkjTZJIRSQzGs+QZTEwVcyjqlk4wNsND6/yuKonX9/trVmMNSL6Z/bd?=
 =?us-ascii?Q?QBaiG6gXoISvUDxFX4aKjSfYLF3dPPm8DkOjHh1pZyrtcyDIOxLl663uuaGY?=
 =?us-ascii?Q?c5/rMdbc6HTiE50BugH4SHGu0lPZsdgeTY/0AFY2lcTgHoPZ9u4SzMCQOWDL?=
 =?us-ascii?Q?Nt+R5slozLZP9pdVM3L+2HUyHLAeUtau5QxfvU6XuY3McPlw9S8WoD/+oepY?=
 =?us-ascii?Q?YnwrfvCS+S48djpa8u5b36ZucTCVnzksLnSB6M3i9R4znD2OIJrRHD8B7Tr3?=
 =?us-ascii?Q?wcJUVuOu6f+ChVwqMdf89fqo?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5349E230CC22C6031E03DE9097C09BL1PR12MB5349namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636dfb96-2cae-4291-c050-08d9631eb892
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 14:36:24.5354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGKT960WJ99YJk8xtK0Mr83FLtwdiVU53VEZkcKrwbXXVhk19MElYM0PB++lWrND
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5143
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5349E230CC22C6031E03DE9097C09BL1PR12MB5349namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

If that is done  -

+               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_T=
YPE_UVD,
+                                                      AMD_PG_STATE_GATE);
+               amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_T=
YPE_UVD,
+                                                      AMD_CG_STATE_GATE);

Usual order is CG followed by PG. It comes in the else part, so less likely=
 to happen. Nice to fix for code correctness purpose.

Thanks,
Lijo

From: Zhu, James <James.Zhu@amd.com>
Sent: Thursday, August 19, 2021 7:49 PM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.=
com>
Subject: Re: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE=
 on suspend


[AMD Official Use Only]


Why not move changes into hw_fini?


Best Regards!



James Zhu

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Evan Quan <evan.quan@amd.com<mailto:e=
van.quan@amd.com>>
Sent: Wednesday, August 18, 2021 11:08 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; =
Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; Quan, Evan <Ev=
an.Quan@amd.com<mailto:Evan.Quan@amd.com>>; Pan, Xinhui <Xinhui.Pan@amd.com=
<mailto:Xinhui.Pan@amd.com>>
Subject: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on =
suspend

Perform proper cleanups on UVD/VCE suspend: powergate enablement,
clockgating enablement and dpm disablement. This can fix some hangs
observed on suspending when UVD/VCE still using(e.g. issue
"pm-suspend" when video is still playing).

Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed
Signed-off-by: Evan Quan <evan.quan@amd.com<mailto:evan.quan@amd.com>>
Signed-off-by: xinhui pan <xinhui.pan@amd.com<mailto:xinhui.pan@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 23 +++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v6_0.c
index 4eebf973a065..d0fc6ec18c29 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -554,6 +554,30 @@ static int uvd_v6_0_suspend(void *handle)
         int r;
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       /*
+        * Proper cleanups before halting the HW engine:
+        *   - cancel the delayed idle work
+        *   - enable powergating
+        *   - enable clockgating
+        *   - disable dpm
+        *
+        * TODO: to align with the VCN implementation, move the
+        * jobs for clockgating/powergating/dpm setting to
+        * ->set_powergating_state().
+        */
+       cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+       if (adev->pm.dpm_enabled) {
+               amdgpu_dpm_enable_uvd(adev, false);
+       } else {
+               amdgpu_asic_set_uvd_clocks(adev, 0, 0);
+               /* shutdown the UVD block */
+               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_T=
YPE_UVD,
+                                                      AMD_PG_STATE_GATE);
+               amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_T=
YPE_UVD,
+                                                      AMD_CG_STATE_GATE);
+       }
+
         r =3D uvd_v6_0_hw_fini(adev);
         if (r)
                 return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vce_v3_0.c
index 6d9108fa22e0..a594ade5d30a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -503,6 +503,29 @@ static int vce_v3_0_suspend(void *handle)
         int r;
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       /*
+        * Proper cleanups before halting the HW engine:
+        *   - cancel the delayed idle work
+        *   - enable powergating
+        *   - enable clockgating
+        *   - disable dpm
+        *
+        * TODO: to align with the VCN implementation, move the
+        * jobs for clockgating/powergating/dpm setting to
+        * ->set_powergating_state().
+        */
+       cancel_delayed_work_sync(&adev->vce.idle_work);
+
+       if (adev->pm.dpm_enabled) {
+               amdgpu_dpm_enable_vce(adev, false);
+       } else {
+               amdgpu_asic_set_vce_clocks(adev, 0, 0);
+               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_T=
YPE_VCE,
+                                                      AMD_PG_STATE_GATE);
+               amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_T=
YPE_VCE,
+                                                      AMD_CG_STATE_GATE);
+       }
+
         r =3D vce_v3_0_hw_fini(adev);
         if (r)
                 return r;
--
2.29.0

--_000_BL1PR12MB5349E230CC22C6031E03DE9097C09BL1PR12MB5349namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If that is done &nbsp;&#8211; <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_set_powergating_state(ad=
ev, AMD_IP_BLOCK_TYPE_UVD,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_GATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_U=
VD,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_CG_STATE_GATE);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Usual order is CG followed by PG. It comes in the el=
se part, so less likely to happen. Nice to fix for code correctness purpose=
.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Lijo<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhu, James &lt;James.Zhu@amd.com&gt; <b=
r>
<b>Sent:</b> Thursday, August 19, 2021 7:49 PM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; amd-gfx@lists.freedesktop.=
org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chen, Guch=
un &lt;Guchun.Chen@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Pan=
, Xinhui &lt;Xinhui.Pan@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 =
UVD/VCE on suspend<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Why not=
 move changes into</span><span style=3D"color:black"> hw_fini?</span><span =
style=3D"font-size:12.0pt;color:black"><o:p></o:p></span></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">Best Regards!<o:p></o:p></s=
pan></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">James Zhu<o:p></o:p></span>=
</p>
</div>
</div>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Evan Quan &lt;<a href=3D"mailto:evan.quan@amd.com">evan.quan@amd.com</a>&=
gt;<br>
<b>Sent:</b> Wednesday, August 18, 2021 11:08 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Chen, Guchun &lt;<a href=3D"mailto:G=
uchun.Chen@amd.com">Guchun.Chen@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D=
"mailto:Lijo.Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;;
 Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.Quan@amd.com</a>&=
gt;; Pan, Xinhui &lt;<a href=3D"mailto:Xinhui.Pan@amd.com">Xinhui.Pan@amd.c=
om</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/=
VCE on suspend</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Perform proper cleanu=
ps on UVD/VCE suspend: powergate enablement,<br>
clockgating enablement and dpm disablement. This can fix some hangs<br>
observed on suspending when UVD/VCE still using(e.g. issue<br>
&quot;pm-suspend&quot; when video is still playing).<br>
<br>
Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed<br>
Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan@amd.com">evan.quan=
@amd.com</a>&gt;<br>
Signed-off-by: xinhui pan &lt;<a href=3D"mailto:xinhui.pan@amd.com">xinhui.=
pan@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24 ++++++++++++++++++++++++<b=
r>
&nbsp;drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 23 +++++++++++++++++++++++<br=
>
&nbsp;2 files changed, 47 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v6_0.c<br>
index 4eebf973a065..d0fc6ec18c29 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
@@ -554,6 +554,30 @@ static int uvd_v6_0_suspend(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Proper cleanups before haltin=
g the HW engine:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - cancel the dela=
yed idle work<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - enable powergat=
ing<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - enable clockgat=
ing<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - disable dpm<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO: to align with the VCN i=
mplementation, move the<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * jobs for clockgating/powergat=
ing/dpm setting to<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * -&gt;set_powergating_state().=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;adev-&g=
t;uvd.idle_work);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm_enabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_enable_uvd(adev, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_asic_set_uvd_clocks(adev, 0, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* shutdown the UVD block */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_U=
VD,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_GATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_U=
VD,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_CG_STATE_GATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D uvd_v6_0_hw_fini(ade=
v);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vce_v3_0.c<br>
index 6d9108fa22e0..a594ade5d30a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
@@ -503,6 +503,29 @@ static int vce_v3_0_suspend(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Proper cleanups before haltin=
g the HW engine:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - cancel the dela=
yed idle work<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - enable powergat=
ing<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - enable clockgat=
ing<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - disable dpm<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO: to align with the VCN i=
mplementation, move the<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * jobs for clockgating/powergat=
ing/dpm setting to<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * -&gt;set_powergating_state().=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;adev-&g=
t;vce.idle_work);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm_enabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_enable_vce(adev, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_asic_set_vce_clocks(adev, 0, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_V=
CE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_GATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_V=
CE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_CG_STATE_GATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D vce_v3_0_hw_fini(ade=
v);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
-- <br>
2.29.0<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB5349E230CC22C6031E03DE9097C09BL1PR12MB5349namp_--
