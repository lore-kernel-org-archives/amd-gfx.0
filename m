Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB3DC77B75
	for <amd-gfx@archiver.kernel.org>; Sat,  6 May 2023 03:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B96110E132;
	Sat,  6 May 2023 03:50:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1999D10E132
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 May 2023 03:50:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkEecRGdcn+TyQcqEpbiarOUqf/9YEskFBATDfC4KTJgSQiIV64RllkH+4S6JuKPV9k1Al2rBzZze5GXnzwxDO4NCCYW2YxWGYAY5wc9l3DK2D+Rx52miELzoM6m92JDp6eVABM6EaxclkK2RGwIELVMXDu+SIBiTThurfN/FcZ+pUjpTY9rblCqE5z9mloWz7lhpGBBRs+RbjDV1Uu8iKt6Q+UOGYNjIyt6/en4NKo/yt9U0NnbHgM18jS5C+4G+7iNwbMIWKz8hgiDFMQo/Z88m4xFiOkbXLNqudqBcp+ypyxMqA7/dNZk1dyJGjOsSrMB+uJ68ErMM3u4XgVkOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpW6p8/wBLb0tBtC5gnXzIpldN1ELh78S6JSsLBmJ0k=;
 b=UxVagOeDlf3b3l09/oD0jYoURKd1PawB1P5mn9i0oeDZ+3M7KEJNGAUdLQnjR3lTbxgfH1OrGdw0zJ8Mw+WsJ1gHVMqXF2wjsroH+SbRJXmh0yzsnljgYIbyif+t1B8WNWUdzD0+wIJdNyusGCggZZqs/IvLGgkuUAmWx+qkQ9BZ9e6/9/JBdy8R1KPQsVNb3bmD+f4emqA2D+/FgaaAOU3zuR+AEIpAHkgs+0722jNJF8Wog1HUMGgJ3BC6qFgjycRWAUacjv+GdcGL5HpYh0gl8O1Ud8W4jkSKCnJ9XhAyNI3vXvv6czYz5nunRsKoZoz5TRweidLuvCOH3oL8Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpW6p8/wBLb0tBtC5gnXzIpldN1ELh78S6JSsLBmJ0k=;
 b=J9M3xqyyVSEPeXefHpZNsgaSdGFlZkvnpyVabethYjcp4pM6J1mmELr64Pn+vTmX1k74tIJyexlT4EfQ429Zf62+5yPC+O0l/tMSjCEZ7fy+22DUR7/LIjyj8EjpVVONW+5shAVpTHJBzGKxYakL5iN4MztBxc3pPap//qYjs/o=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.27; Sat, 6 May 2023 03:50:30 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c7b1:f457:da06:8bc8]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c7b1:f457:da06:8bc8%3]) with mapi id 15.20.6363.027; Sat, 6 May 2023
 03:50:30 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [PATCH] drm/amd/pm: parse pp_handle under appropriate conditions
Thread-Topic: [PATCH] drm/amd/pm: parse pp_handle under appropriate conditions
Thread-Index: AQHZfysFmefWCCX+dEmDCdU4VrHk+a9MfBEAgAAg4iA=
Date: Sat, 6 May 2023 03:50:29 +0000
Message-ID: <DM5PR12MB2469E2212F47AE17528B7C81F1739@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230505082414.1194477-1-guchun.chen@amd.com>
 <DM6PR12MB26192F8AEC87383455B1841AE4739@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26192F8AEC87383455B1841AE4739@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fd8920e2-1b9f-43fe-a309-c002469a0c19;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-06T01:50:55Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DS7PR12MB8201:EE_
x-ms-office365-filtering-correlation-id: a154cee8-995d-4c5b-8b4a-08db4de50904
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hlvNd+gfh6Ea8V2t1bA8Eme/2b+3vXcva1R+ChGVa6AoctUvJtLdt3S75O1zFaOaoIFttu4faf6ApocrLah0ad/kfxC4H2uemrUAPpJtXwlDqQdJrHg/CgGaTVFuKaGT1g/anjHRsG71BXgDfAEnv8krpljtP7urh5GoVCDYoQzsFApSjFlJnqpahvoQRBzVX2X3M7VUy5jzqEUNnMUc3N/Vagn6BQwV7WMLcrhsW62FNLOQFBKrR1W6LOReyHUcR+UAuRoVbQofg4kW/1HUSKskL60MZY6QVN0WFMI+W2dcAVbqs+g0iJcR6xAx8jgFXmEiHSh2itjbFoqybe8vMiCu2XCISk95lUM5/fLMj4je2tkyMNgaZc3Nxo8WuGGlHCTx2pdTo4xM0aGDfxNwKG2zvHSSL2MbzM5eEDybhWmpHZPjs/U31HY5TPfRUUSQPybdcr8sPs+XlPEVmWuzgaFpxT+K3rcoOF1LBOB454yoSxO9Bdxo5Y8snLAINuRSZCkNRVPrQEAQDEI+ihNBLtc7fVhBPQ3KbqjULdH53o0KHrYvVHEJ+rrGmauD0bnm3Wv+qoIOaAJDl+a9EkuEVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(83380400001)(186003)(33656002)(2906002)(38100700002)(921005)(38070700005)(122000001)(55016003)(86362001)(7696005)(966005)(8676002)(8936002)(316002)(41300700001)(71200400001)(5660300002)(52536014)(478600001)(110136005)(66446008)(66556008)(66946007)(66476007)(64756008)(4326008)(6636002)(76116006)(26005)(6506007)(53546011)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?htTzPkQoKwciCTDWaG92ufqnLJ8j1/dAhq1Ua7/wSvyr6E5G1i2i3MeZL5QK?=
 =?us-ascii?Q?+VmlRDBT+Ehv3H8i3sSIXazqAf+oz0lj3pSJ+uiTfD6L4x1pB1KogZzfLgVr?=
 =?us-ascii?Q?FYgpW1Vb3KYXKpQhcQ2elpq/bj4PzhTwG60RFBxv36+XSAYTr+IKwmXdwoJf?=
 =?us-ascii?Q?M7CEeqfYYeFFWwXW+CW6Wjxn7RGcS0RRkfBJ6hEiGQobonU4tY+supEHhSjg?=
 =?us-ascii?Q?9AqGFW4FefN/Nk8Oigddjs3d8gwhgmxDyIOmTSKyJdRT1lVhwmvUDgvsBuFZ?=
 =?us-ascii?Q?STmsnchD+SnICRL611vB5OEA65friad8bDAuXFcipVZ9ktAPJ9ozymDiFWt6?=
 =?us-ascii?Q?MiwWYTlTXtxtVzQdY3pZiruZgLtyL+mlsRICpXQI71ICiGE6c/Oy5zqTP7E2?=
 =?us-ascii?Q?0YObS7+zQ2MuC3ck0kOXu7D3mUBTsvVrhroFzACCGW1WeGZOa7tOfzH3UXE4?=
 =?us-ascii?Q?vbi5nI9RjKJPth6UDdgQFSRniphZKVYm6GhEHxIzxsuYpVlR19Winc6AOx48?=
 =?us-ascii?Q?hg6EQiVgAyK5JD2YbbFuy7hdLs3wyvb79k90smYTrX9BU8E0VtM/5P2eOz9k?=
 =?us-ascii?Q?+v3cJBtme0zZgdnE2iAVaFv4uz/+RQW9IFeZciT6T4mLD4TLK2koK+J9C/0q?=
 =?us-ascii?Q?mf1SZ7ZM/qHFRVLhdkAHdfRr7UKe2B2DrmPypC/Yb1a6sdHI4gER32xu/hOK?=
 =?us-ascii?Q?Cf9K7Ga6bAROy+Xhu8Q+0K31HIuCbm3GDI9wltrmU4kV+qhF0EECwxD6MUNC?=
 =?us-ascii?Q?7uhwjsO4ewY0sUt/ICkrqqOnRSWcmUljlPhdF2pFK/hoMFynsde6HpGkVuNR?=
 =?us-ascii?Q?slAq/0mt5QMBEipgC1lLAMegsvQDxXCIpNXGDEyEh3Y3ZLWWWHA5P6ztNMCH?=
 =?us-ascii?Q?3rZDGGG0c305gFW58eXmFgq4wgLvI1KsgFct/w3mMBckdVzP3FbJPEp7F+SH?=
 =?us-ascii?Q?4kUQJ5HKFJ7PmKci2c7ekFyOofkeiS1heDG/QoG4SgfmNeKTNIHLLl0xxbzs?=
 =?us-ascii?Q?ckEyCy/3FlCK5JOW10pQvVsKBtDo4C4UAF/012T+8o1+G7niUsbuKc58yR5F?=
 =?us-ascii?Q?X4IUz8sO2HnQmZ2FkTUxE3ZPl+F64OzfKhwghXnTd6B7vec2e0Bm2CQOYJQx?=
 =?us-ascii?Q?AtPcsOYudbTeqyLJYZi5s4nxNIJVcKZfTfT5K6gAG5fIhA558F23DCw0AUnd?=
 =?us-ascii?Q?4MwyT5VFUrbj46VluUByaxmCjz2g4+uoIv6y7OZgMd9CB4O7mYYwej9dsIdG?=
 =?us-ascii?Q?Yf8uk7XFETRjoz8iuCtqgM4rQcg2KEAmeKmQguB8CdbyewGxKgJ5MtH6FwL/?=
 =?us-ascii?Q?E+NtTspeRNFIpnD8EqufYOIwfEzULiKNIDevaeY5VC+6iPmBK/2o1WV3G7KK?=
 =?us-ascii?Q?2yIvpoWycLbxtSwDUjUqrCsanBtxDAoRm5C7O7cCQDml3IuWczJkeGe0zQB7?=
 =?us-ascii?Q?uovMFs40q/f7iwvqHtWMy2SRKtu/lRFwWr1SpB2Ax4OhvkyNaib1D+cSoGGB?=
 =?us-ascii?Q?b7GDGjimsFRrUADYQmvB4nxPx+8cXXC4WtqOHx0jDDSG9ZwvK3vBHW6pxW9Z?=
 =?us-ascii?Q?Pp9Yp1bN33p/RK9jSbw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a154cee8-995d-4c5b-8b4a-08db4de50904
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2023 03:50:29.6756 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WikaZoOPgNepOo7YDByH5LiO+e6G8+6KUP6hL3jt4U35s9ju6x1/6rZJkofjJ5OKodsA83Lq9dtDnnBdtl36ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201
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
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Saturday, May 6, 2023 9:51 AM
> To: Chen, Guchun <Guchun.Chen@amd.com>; amd-
> gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig,
> Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: parse pp_handle under appropriate
> conditions
>
> [AMD Official Use Only - General]
>
> +Mario
>
> I believe the comment below from Mario points the right direction to
> suppress the "UBSAN: invalid-load..." warnings.
> https://gitlab.freedesktop.org/drm/amd/-/issues/2541#note_1898035
> However, it might be not right to simply drop the line below since the ad=
ev-
> >powerplay.pp_handle pointer is still needed for those APIs like
> amdgpu_dpm_read_sensor().
> - adev->powerplay.pp_handle =3D adev;

Thanks Mario and Evan. I think the new patch set v3 should fix that problem=
. I will ask reporter to have a try as well.

Regards,
Guchun

> BR
> Evan
> > -----Original Message-----
> > From: Chen, Guchun <Guchun.Chen@amd.com>
> > Sent: Friday, May 5, 2023 4:24 PM
> > To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>;
> > Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>;
> > Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui
> > <Xinhui.Pan@amd.com>
> > Cc: Chen, Guchun <Guchun.Chen@amd.com>
> > Subject: [PATCH] drm/amd/pm: parse pp_handle under appropriate
> > conditions
> >
> > amdgpu_dpm_is_overdrive_supported is a common API across all asics, so
> > we should cast pp_handle into correct structure under different power
> > frameworks.
> >
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2541
> > Fixes: ebfc253335af("drm/amd/pm: do not expose the smu_context
> > structure used internally in power")
> > Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > index f0068df2d073..ae45abeab5b5 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > @@ -1455,13 +1455,15 @@ int
> > amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
> >
> >  int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)  {
> > -   struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
> > -   struct smu_context *smu =3D adev->powerplay.pp_handle;
> > -
> > -   if ((is_support_sw_smu(adev) && smu->od_enabled) ||
> > -       (is_support_sw_smu(adev) && smu->is_apu) ||
> > -           (!is_support_sw_smu(adev) && hwmgr->od_enabled))
> > -           return true;
> > +   if (is_support_sw_smu(adev)) {
> > +           struct smu_context *smu =3D adev->powerplay.pp_handle;
> > +           if (smu->od_enabled || smu->is_apu)
> > +                   return true;
> > +   } else {
> > +           struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
> > +           if (hwmgr->od_enabled)
> > +                   return true;
> > +   }
> >
> >     return false;
> >  }
> > --
> > 2.25.1
