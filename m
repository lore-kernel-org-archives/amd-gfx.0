Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DFDC432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 04:38:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8524760F92
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 04:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8524760F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DDFB6E067;
	Fri, 27 Aug 2021 04:38:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B03536E067
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 04:38:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLRE8OLA2O34LrlfqwsIQOdi62egjC7wXVzt4eAUcUq0J/kBPfALMnsHu4z2ibOYBLVMd+0gFsc2Q9G3CzpTTr/msoj6h86THMXIKnNZ1kIRpcxj7emff2PAyP+FnhOXOQnjGjDW1P9onXr/rwG3ywjoSMoPQC8FqRaANDvKl2Mc+76GVT0NAmnvdSSy5wl2YVQYWTNZUFlAoELWFn51k+joTKaKNY1sZWB41vi/IozzqKY/Iq9FELD6FSsgS3zWvlkb2yVQ1nPF4FhnytzPwrBnGjSsn2Q+FQofbPCh/cEW//caKCqQtKqRIPpH4TFfWOto36l+lwu6W4BxpfqvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VJYJnQ7rRq0dX7AwvHiGAlmlun23egRh15TZ2tNp+k=;
 b=Eflx8OR9a2IHNJ7tjCH5IRsVDZg3buAGYKPyq5kOuNZDFSDlMGQcOZu3wTsNPYv+ODx6lKn2JkEt45mcIZ8m4KOnnVjj6sPJSBnf38r/ybK/jsvozsV4MnU8Pr5g+6e4CoYg3awFFpqhOVTop6bcEyZkqDe2GOYbMZiliZw75Tm4aEqGTgpdrJ2XMxPT5lTYMMOIkIWbPvAp5pBCh9XtANQfjvf2wV+Jij0TmIS6FIqsKezfdi1BwzaKdoEDohUMbsKmF2XjZrb4+H2PUX749YkqbBrblOfo5HiO/iQuUFJVLP/yxjuN+G52qjEpO8lFASG92LU6mEyhZv4N5wLTYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VJYJnQ7rRq0dX7AwvHiGAlmlun23egRh15TZ2tNp+k=;
 b=1HZ5ECV1mwBSZLDPkb0BOkhmP/+jpddac7b7peXZKcbLADfUm5Gn3AtWcq+/wPhJwQ09o6q//nm3v5F4FPb8epMhpZ/TNnO+vVN7sRETGgeh45n3v+vENBGD2QitFhhBir0uTvOFVoV+U+DtB5+sFfbTiPPvbs9DCuFa4FLvVqE=
Received: from BL1PR12MB5303.namprd12.prod.outlook.com (2603:10b6:208:317::14)
 by BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 27 Aug
 2021 04:37:58 +0000
Received: from BL1PR12MB5303.namprd12.prod.outlook.com
 ([fe80::15fb:10e0:6892:6fb4]) by BL1PR12MB5303.namprd12.prod.outlook.com
 ([fe80::15fb:10e0:6892:6fb4%7]) with mapi id 15.20.4457.021; Fri, 27 Aug 2021
 04:37:58 +0000
From: "Mahapatra, Rajib" <Rajib.Mahapatra@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Set the domain as GTT when VRAM size <=
 32 MB
Thread-Topic: [PATCH] drm/amd/display: Set the domain as GTT when VRAM size <=
 32 MB
Thread-Index: AQHXmqVX8TtkZXjidkyezXkimdiAd6uGGDqAgACp/dA=
Date: Fri, 27 Aug 2021 04:37:58 +0000
Message-ID: <BL1PR12MB53034286ED2BA36EC616C422F2C89@BL1PR12MB5303.namprd12.prod.outlook.com>
References: <20210826180754.3193315-1-rajib.mahapatra@amd.com>
 <BL1PR12MB5144C0F1425B8CE8B11BC093F7C79@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144C0F1425B8CE8B11BC093F7C79@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-27T04:37:52Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21931e4a-97fe-4f22-2906-08d969147214
x-ms-traffictypediagnostic: BL1PR12MB5352:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5352DD9BF967B17002D36673F2C89@BL1PR12MB5352.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nafKY0VqbTvCBphPAjrobiP7plq5xQShgMXnH6uvqgpmR7CLIb+gAJMdHUpEfQ8SOCn11Q/iL/KJtVcARBBEHXMzzffM/YQYVgmMqLIxd0D3PFmLmXqX1ynwJy4i4jXLei7abGiLLp9V0yuEpPyU0mDpuDgIg63yl6hyh7mtnoskgi1jtheB74AYK5HKZPLqrDjUtCij90pnFUUSJPPfDTfgptDI2YsHQnea5leVa/Y982s4y4CE916Xw1EJVY1hbylssmf/x1SW9rwsaVehKBMYZTJdTIELObk0zO9w31TEDPf2YcqkFOytkoABVeYDU8FEJA5KJUYTq7pEaXNp25VV6C+q247uxaIbF/GrJCyTK2TpqdRDeKOZ6zNtCTQJxYOG8rP8MjRnUfSqGN8CC/DR4VEnToJmKJ/Rxwd3rtoYHUguUqGQ2NSp9rWdv36iRCkXIOJ5GtaEFpvSStjmAnr7/nnZSNSkANr+CTbAJK6aVGRAYFpelvbKNub2ZVFxrwSbx1bYIaaLogc/+s/9I6QsTsm98ii+MZSGUAXxQs9GuTgRK+yZX2euiWjHW+Miei03TXk6M6pxj8oG/uBg/7rGKP9sW5BeHEkYNbWH8Mhu8DFwk1tZCX5dYYKn2Wl4aEX3KrJ1XCAZ/fEsKEzjcDkScLsQ0txnXwvxStm0ioMbjWfeCwqf3X+QwCYeRJSenec0JRNr0qpPBPZvCP6Dkg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5303.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(122000001)(66946007)(33656002)(38100700002)(4326008)(52536014)(9686003)(110136005)(5660300002)(186003)(66446008)(6506007)(7696005)(478600001)(316002)(966005)(66476007)(6636002)(76116006)(71200400001)(26005)(38070700005)(8676002)(64756008)(2906002)(166002)(83380400001)(86362001)(53546011)(66556008)(55016002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yfbkzg1djawFXgokm8FfAl1p8O0vY1lvTr4jRCA548O//D6mD2XWdOmct9jf?=
 =?us-ascii?Q?7NIxep84iJPq/M2YJxAq5fH+LquiJLZIieYtBrVda0+ePZ4cC9GdG4/C26mM?=
 =?us-ascii?Q?gE5ZVNNXjAizfhKe2E8XvIzL3nse46iQ+BlgJtvyd4MCZC1RF8sLu1Qx5S+s?=
 =?us-ascii?Q?7yJILStCZpZopDhIueAvMj5sy2x3YqxyrAvv5Ka2YAkabyuDWkQojbtd4CIX?=
 =?us-ascii?Q?gFlvzWjxHqGEN89uhN8aT2HH3qUfhLxVtQXBkvHTTuoUCEqR/SetWS4+lErz?=
 =?us-ascii?Q?FYE03zVoVlBKmesF7+weqnmbE7guucvDt6G02vVmjcDzHPu4RFCbzqPUKBHs?=
 =?us-ascii?Q?vadJjrEaz+qbpIW5N6eQXeH6Ar2cWOGm/ytLossUmG3wCbCcPxIgYNrK9Ft/?=
 =?us-ascii?Q?Scx0mi2ocGRAAI15Z3Zi+Rh9l96kAG1cT2wsXNDWM181KtcR1S4Tp6SKMcLm?=
 =?us-ascii?Q?j6qQvexglsJGqzYwFWx/uH/k4bB1xAMVQIaWJxslRGEY1DkMI/wSUgk9OzwS?=
 =?us-ascii?Q?nQaje02TirQFZwBhDxiFIxcySrWkxeWhQoll+NYbeZv8Oqrb9n1WPtWnCUgp?=
 =?us-ascii?Q?d1M1EdAAogBM+ZYGDrpJnKJ8P53egu09QzbYOt+6O7wl5l0S0f15OiH5493R?=
 =?us-ascii?Q?s62DK1mY9EDHv1RT2jl+lKQ88bfUdCcqfWDAm4CWokEdOtIeKj1DaIzfZxzF?=
 =?us-ascii?Q?65QHJ04PvHWrFS/H9V9QP7a0TwFQrVM/4ebe9nqcaLlzxFNGM0QSzM+EVANh?=
 =?us-ascii?Q?xBa6CG/EPMvmw9C5TJTOCRp2T8r6nRuGJ9qmTmBqd9L/2T1/knsAu4YVn98I?=
 =?us-ascii?Q?mBbRItnhRYKEV5RKbgKKF6QlAgcSvzFMNBCLwI8l4sLyQLnFg6Lc3JjRB7hH?=
 =?us-ascii?Q?7Avo/qt12nhROLVFDgZWiYeyJrGuWMlr4agNdsdCuPcZvl6Va3RKG9E2E53B?=
 =?us-ascii?Q?KFavnnb+MSHP94IFr0ghBhDED0GM6PM+icaGFvHWn95mDdRLxmHUuv6W432c?=
 =?us-ascii?Q?hEASr5Woi6g7r6x76Pd8aoSdYP5jTaw1j1NNtCs1MbVZxvdVks718k4nn3i7?=
 =?us-ascii?Q?VEXW4Dxvwu1Vh1CmpHbqO2q/iJZl428yCAdJGfjYOTzBQjwRgpyjmjvK1cbX?=
 =?us-ascii?Q?TX3WXjx+hzlrjADAKw+0mdPzuqDbzJM/t01hKDp2vfJz4vpMObWrXl8c2euB?=
 =?us-ascii?Q?DTkU0bqmN0KOEwK9YtYVX2hjcakQQi9tr4NdQZP2cNbC/vyeYwqoVkH5Y9q9?=
 =?us-ascii?Q?ZPZTFVg9PBktRdWUiI/iMCJ7uNNx1iAv5fGLIoXQMVgZgbiGnqmVlhsYY3+0?=
 =?us-ascii?Q?R1kmY2DJJb87LY/wJjysuCDj?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB53034286ED2BA36EC616C422F2C89BL1PR12MB5303namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5303.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21931e4a-97fe-4f22-2906-08d969147214
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 04:37:58.2408 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1pmtUotENtY4E0/8jn91fZdDMQ8SP17q5Vv+uNnj10zf2a8Tp0naPnEZrXphjF+MyaHTW2BnJE24ItqOTfQ7Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5352
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

--_000_BL1PR12MB53034286ED2BA36EC616C422F2C89BL1PR12MB5303namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Thanks Alex for your reply.
The patch is not fixing our issue.

Thanks
-Rajib

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Thursday, August 26, 2021 11:48 PM
To: Mahapatra, Rajib <Rajib.Mahapatra@amd.com>; Wentland, Harry <Harry.Went=
land@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Wu, Hers=
en <hersenxs.wu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/display: Set the domain as GTT when VRAM size =
<=3D 32 MB


[Public]

I think this may have already been fixed with this patch:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/2a7b9a8437130fd328001f4=
edfac8eec98dfe298

Alex

________________________________
From: Mahapatra, Rajib <Rajib.Mahapatra@amd.com<mailto:Rajib.Mahapatra@amd.=
com>>
Sent: Thursday, August 26, 2021 2:07 PM
To: Wentland, Harry <Harry.Wentland@amd.com<mailto:Harry.Wentland@amd.com>>=
; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com<mailto:Nicholas.Kazlaus=
kas@amd.com>>; Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexand=
er.Deucher@amd.com>>; Wu, Hersen <hersenxs.wu@amd.com<mailto:hersenxs.wu@am=
d.com>>
Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Mahapat=
ra, Rajib <Rajib.Mahapatra@amd.com<mailto:Rajib.Mahapatra@amd.com>>
Subject: [PATCH] drm/amd/display: Set the domain as GTT when VRAM size <=3D=
 32 MB

[Why]
In lower carve out (<=3D 32 MB) devices, it was unable to pin framebuffer i=
n
VRAM domain for some BO allocations. The device shows below error logs and
sometimes it reboots too.

amdgpu 0000:02:00.0: amdgpu: 00000000d721431c pin failed
[drm:dm_plane_helper_prepare_fb] *ERROR* Failed to pin framebuffer with err=
or -12

[How]
Place the domain as GTT when VRAM size <=3D 32 MB.

Signed-off-by: Rajib Mahapatra <rajib.mahapatra@amd.com<mailto:rajib.mahapa=
tra@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index dc3c6b3a00e5..d719be448eec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -236,6 +236,7 @@ extern int amdgpu_num_kcq;

 #define AMDGPU_VM_MAX_NUM_CTX                   4096
 #define AMDGPU_SG_THRESHOLD                     (256*1024*1024)
+#define AMDGPU_VRAM_MIN_THRESHOLD              (32*1024*1024)
 #define AMDGPU_DEFAULT_GTT_SIZE_MB              3072ULL /* 3GB by default =
*/
 #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS          3000
 #define AMDGPU_MAX_USEC_TIMEOUT                 100000  /* 100 ms */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e1e57e7465a7..f71391599be1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7106,8 +7106,16 @@ static int dm_plane_helper_prepare_fb(struct drm_pla=
ne *plane,
                 return r;
         }

-       if (plane->type !=3D DRM_PLANE_TYPE_CURSOR)
+       if (plane->type !=3D DRM_PLANE_TYPE_CURSOR) {
                 domain =3D amdgpu_display_supported_domains(adev, rbo->fla=
gs);
+               /*
+                * Handle devices with lower carve out.
+                */
+               if (adev->gmc.real_vram_size <=3D AMDGPU_VRAM_MIN_THRESHOLD=
) {
+                       domain |=3D (domain & AMDGPU_GEM_DOMAIN_GTT) ? doma=
in :
+                                  AMDGPU_GEM_DOMAIN_GTT;
+               }
+       }
         else
                 domain =3D AMDGPU_GEM_DOMAIN_VRAM;

--
2.25.1

--_000_BL1PR12MB53034286ED2BA36EC616C422F2C89BL1PR12MB5303namp_
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
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader23c54b6f, li.msipheader23c54b6f, div.msipheader23c54b6f
	{mso-style-name:msipheader23c54b6f;
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheader23c54b6f" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks Alex for your reply.<o:p></o:p></p>
<p class=3D"MsoNormal">The patch is not fixing our issue. <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks<o:p></o:p></p>
<p class=3D"MsoNormal">-Rajib<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Thursday, August 26, 2021 11:48 PM<br>
<b>To:</b> Mahapatra, Rajib &lt;Rajib.Mahapatra@amd.com&gt;; Wentland, Harr=
y &lt;Harry.Wentland@amd.com&gt;; Kazlauskas, Nicholas &lt;Nicholas.Kazlaus=
kas@amd.com&gt;; Wu, Hersen &lt;hersenxs.wu@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: Set the domain as GTT when VRA=
M size &lt;=3D 32 MB<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">I think=
 this may have already been fixed with this patch:<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><a href=
=3D"https://gitlab.freedesktop.org/agd5f/linux/-/commit/2a7b9a8437130fd3280=
01f4edfac8eec98dfe298">https://gitlab.freedesktop.org/agd5f/linux/-/commit/=
2a7b9a8437130fd328001f4edfac8eec98dfe298</a><o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Mahapatra, Rajib &lt;<a href=3D"mailto:Rajib.Mahapa=
tra@amd.com">Rajib.Mahapatra@amd.com</a>&gt;<br>
<b>Sent:</b> Thursday, August 26, 2021 2:07 PM<br>
<b>To:</b> Wentland, Harry &lt;<a href=3D"mailto:Harry.Wentland@amd.com">Ha=
rry.Wentland@amd.com</a>&gt;; Kazlauskas, Nicholas &lt;<a href=3D"mailto:Ni=
cholas.Kazlauskas@amd.com">Nicholas.Kazlauskas@amd.com</a>&gt;; Deucher, Al=
exander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@=
amd.com</a>&gt;;
 Wu, Hersen &lt;<a href=3D"mailto:hersenxs.wu@amd.com">hersenxs.wu@amd.com<=
/a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; Mahapatra, Rajib &lt;<a href=3D"mailto:=
Rajib.Mahapatra@amd.com">Rajib.Mahapatra@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Set the domain as GTT when VRAM si=
ze &lt;=3D 32 MB</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">[Why]<br>
In lower carve out (&lt;=3D 32 MB) devices, it was unable to pin framebuffe=
r in<br>
VRAM domain for some BO allocations. The device shows below error logs and<=
br>
sometimes it reboots too.<br>
<br>
amdgpu 0000:02:00.0: amdgpu: 00000000d721431c pin failed<br>
[drm:dm_plane_helper_prepare_fb] *ERROR* Failed to pin framebuffer with err=
or -12<br>
<br>
[How]<br>
Place the domain as GTT when VRAM size &lt;=3D 32 MB.<br>
<br>
Signed-off-by: Rajib Mahapatra &lt;<a href=3D"mailto:rajib.mahapatra@amd.co=
m">rajib.mahapatra@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-<br>
&nbsp;2 files changed, 10 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index dc3c6b3a00e5..d719be448eec 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -236,6 +236,7 @@ extern int amdgpu_num_kcq;<br>
&nbsp;<br>
&nbsp;#define AMDGPU_VM_MAX_NUM_CTX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4096<b=
r>
&nbsp;#define AMDGPU_SG_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; (256*1024*1024)<br>
+#define AMDGPU_VRAM_MIN_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (32*1024*1024)<br>
&nbsp;#define AMDGPU_DEFAULT_GTT_SIZE_MB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3072ULL /* 3GB by default */<br=
>
&nbsp;#define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 3000<br>
&nbsp;#define AMDGPU_MAX_USEC_TIMEOUT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 100000&nbsp; /* =
100 ms */<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index e1e57e7465a7..f71391599be1 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -7106,8 +7106,16 @@ static int dm_plane_helper_prepare_fb(struct drm_pla=
ne *plane,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (plane-&gt;type !=3D DRM_PLANE_TYP=
E_CURSOR)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (plane-&gt;type !=3D DRM_PLANE_TYP=
E_CURSOR) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; domain =3D amdgpu_display_supported_domains(adev, rbo=
-&gt;flags);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * Handle devices with lower carve out.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gmc.real_vram_size &lt;=3D AMDGPU_VRAM_MIN_THRESHOL=
D) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; domain |=3D (dom=
ain &amp; AMDGPU_GEM_DOMAIN_GTT) ? domain :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_GTT;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; domain =3D AMDGPU_GEM_DOMAIN_VRAM;<br>
&nbsp;<br>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB53034286ED2BA36EC616C422F2C89BL1PR12MB5303namp_--
