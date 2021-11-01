Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA1AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 01:53:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2AC60F24
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 01:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B2AC60F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC8D389A8C;
	Mon,  1 Nov 2021 01:53:41 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2056.outbound.protection.outlook.com [40.107.212.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C24389A8C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 01:53:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBvl16hbUWl3nS+yn9lXtK23ct6coFp+KJtECG1TJn6xEeJZDsrqZ3n47/+XQj5lF2TGsV4qnzKMi/l/pc9og8L1Knm0jsY2V6/n4Jg5KZD5sCRpRGAoGeQOwhEeyQR27v9VURc0qzlFs41+lyVzQwQt7GknM/7b4Ty9qDVpfzIKeAdgF3alUyrNphb08HJtpazQorKNNHfhVEKzMqwzSGPXhcqZ+JlkMWX1LD8EUwGCRol4vZLAg+zbx7CPuPncRoYHJU22zSdRXQg3ZVR/QPrQHBqdEIoDb8UquGZW+MPhkSBDZUuhvXn0EBxcG8PFIa7+SmGZDf0/rTwNjaWXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2s3yephL2GTdOdbJ/Ee+BQwIxqFeN9QXtYM7maFzUU=;
 b=QR6HtZfm0zF8mfA5I8KZeZc1VtjweVyhblWkR14MdAuTt1dnjAMfgf5d7cG8DXfsYAjd16lHuv/TAUVA7HiLyW7d1Dclx3O6CNQ+DimS6t58Pemeaue6dbuFp/98Z7DxfkIZdpNykaYKiPKov3wChQH5cNxf79Sluicz8uYWW7oX+gb2Xcq7Otvkgr6XzGi6i7gAJt+36957AWgyqkVbzNPD8VFA20qdVPOgs2PtWos0aYmkz/zYFrPcvLJbVfxP9cR8Fy+KAxhV782wiB7W5NIfc67SxVMSnHQVQj19hhDiz2WXh/Y3nrTF1hcH/hkDzvJ1tAGie1VwyAMarKnVmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2s3yephL2GTdOdbJ/Ee+BQwIxqFeN9QXtYM7maFzUU=;
 b=Yf7W30Ne3rkOKgNbQwZsIA3MgxHP8A/4Tl3UCQprH5iXeqXjHNrW31nK4uwIbnJHN7xoW05HKCO+kfJxojtRjwPYCG4jjWYwoJeOJMq6OVQFajWbOHsvAj1lVpeDancSrHVqmUppKLLVkU1g9Mib8LQNXgNMuccrtzyRfXMfeIo=
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Mon, 1 Nov
 2021 01:53:37 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea%6]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 01:53:37 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, Alex Deucher <alexdeucher@gmail.com>
CC: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/display: Look at firmware version to determine
 using dmub on dcn21
Thread-Topic: [PATCH v2] drm/amd/display: Look at firmware version to
 determine using dmub on dcn21
Thread-Index: AQHXzQQoEyww7zJKT0qP+DY0EMP6XKvqbq8AgAAr5QCAA1GGQA==
Date: Mon, 1 Nov 2021 01:53:37 +0000
Message-ID: <SA0PR12MB451008EB97C944B5B9EB957FE28A9@SA0PR12MB4510.namprd12.prod.outlook.com>
References: <20211029203238.4486-1-mario.limonciello@amd.com>
 <CADnq5_PYO6ikVUV4Qy=b70MRQFspd6nmQ5jJ6mFXi0pvHu+1xQ@mail.gmail.com>
 <BN6PR1201MB0084BB61B03DF72CA37E323589879@BN6PR1201MB0084.namprd12.prod.outlook.com>
In-Reply-To: <BN6PR1201MB0084BB61B03DF72CA37E323589879@BN6PR1201MB0084.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-01T01:53:35Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=cc3897f3-093e-4998-8ad8-2523318ca706;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ded5c995-f876-4e3b-62da-08d99cda6bb5
x-ms-traffictypediagnostic: SN6PR12MB2685:
x-microsoft-antispam-prvs: <SN6PR12MB2685B2695A63F5585F130672E28A9@SN6PR12MB2685.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z2KnZ2HDdotyz0A5AFFG4BhOfhgVc/oOQwulR0a39faDsF8b4SHM2zIls05jyT5IGNsSaux4Drg+vDI8M+yPKRcD8IdXKPuvu6Hdo/igF9ddPFDfMbTihU3CHbVz1c6V4sfc9FDM6dQ482ql0xwLAgd/bwi7dkGPDaGgR8vH6YfE2RE+zvWNLEr4uMuMOo2zKis4jZyz4dfRFjfM9Zy+jIXlo2de7CtCOQFsuOmCybowgQd01oxTnhBzDD84jvezte4N1iwlOXXt9WF+imO3mw6+aBZgAco5DiwCzHrhRJ3Z0nrsRRHYX/XiwNDhYR/qmakhUj7ekVuwC+lRGqkRbbRss7CUGZvw5kyFfUi7TWmny1t8CQjAGQI/EGcosDIUPhoepL8waBPDPb03e8ANluCzvWOMnvZ8EM7Pm7ir/oOMDePMoZpPtP0ZUK8YbiiZSN6G3z6r93Z0RkFbsnASbXb2jn7Oqmo8JfG5UbINZ+yO5KSq2ywmt4P3B4nu1v8SAi6HF4IFz7knrqdASFvSq2T0/iDNK56lpCps4iAG6VSDCkGlYl3F3+yUHX+5iaNJlj7A/dwrd20iHyV7PjWaIzVW+cV9T0ah9eVy80cREKkFSQvOCjbgsZCKHV7A0bP2br6e5zPjer2cPeB3ppFZanGSW2U5bXP9ZKMMOMRP7FjIcDBnHOm2YsmSmDyq32Nfaht5sclLXm6jJ0uYMGkiyaEu/jGfnlFF7bu4cVxty3K5tAT7HtUSETEUFiSn2CrzsijlOzcP9UzEkRoUNZBWExDD8tiMgtBix0aEyMdp7YI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(9686003)(122000001)(8936002)(71200400001)(76116006)(55016002)(110136005)(316002)(8676002)(53546011)(83380400001)(6506007)(38100700002)(4326008)(508600001)(38070700005)(186003)(2906002)(66446008)(5660300002)(45080400002)(64756008)(966005)(66946007)(7696005)(52536014)(33656002)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OcgTl/GWvnt+TC6RKi9EuIeMUnSUI4qL2HV6TZzb79R60ocL9NZKvKyMpUbj?=
 =?us-ascii?Q?BSDQzPwOk61sMaOH2omTgFD6qzgaR3SCbVA+H/V/VbggAlxc/kuUySkWaLjd?=
 =?us-ascii?Q?2kSaTS4pTkIFEw2WTIuDiKCRKEobLBIFvkmX6ECgnVyAKPjfrTXstGTqHiNO?=
 =?us-ascii?Q?3FJIcCD/iidq5CpvynQSVgb2IE6buDNbF39I0gW2Ufs0LLVZWx0TGPjK1rhV?=
 =?us-ascii?Q?hE4IyS5yK+YCLlr6oecgESHcMcThy64muiq8/dMiYLfIMAM1QPZLRa/lvsdL?=
 =?us-ascii?Q?ipBuP8Glo1z0pFOt5y+uIfH4I1rp5+PoIyagT1uef30AlzFj4I1MuKGgRkLh?=
 =?us-ascii?Q?Zz8R/G3dt0CJWPJ4ADt8o2CTdkdhGlcSRQJ29/ttSZXhV0JKK7A8zgKpRg+W?=
 =?us-ascii?Q?O8DiB3i2hwJyxvGeuIc7+9Rmidsk6zdSf0bEeYlYpZ0Aoj98QKaEPA9pnlwy?=
 =?us-ascii?Q?Z9XvT9JtLQajIgb2E+UlR9WT/xdqKyIdPzj/29CQ8w7n39Pn1tNNrGgi065u?=
 =?us-ascii?Q?cKvqMYZILc9TCdS152nH3BhyL+ZuB0BFsQ7eEM94MWg9F/WsXMpOXVBWsmix?=
 =?us-ascii?Q?zdkr9+QLKX05LtsxRdmi+kNTcCReaFbnGTka4ldFtM4l02Q7zivaX4GMrYXe?=
 =?us-ascii?Q?KZta2t0ki4Ak/bwvgc1JP9fFFkdVin/9sh291v36AKB2erG/qqni5s/+ux4p?=
 =?us-ascii?Q?8MghDUXqzcDOadpuevrdu9i2oQbCYhWo2NroboOT6SX7bbkjSS3q8EaxVlAr?=
 =?us-ascii?Q?O7KspY2pneGT58BP9vaZSrM5wKV1XJmlkUVM2v2NrAD0Bz0uc3AYjvPtwP/L?=
 =?us-ascii?Q?KQmuMnkJ7CwUVM1+2XsAEkPX6f5gnB5q1cCglIdIe2UV5JBnqcrssdgGtXAe?=
 =?us-ascii?Q?uCYVVdJ1NuQEr/jhnB5PE5YHTbv1pRGqNLDc8atjHhGYxvOhtFJoAkUO5iuh?=
 =?us-ascii?Q?0nE5KYY5nO0u4KTIe7rACfLILhsx9VV6GyDPgf430ALVueQ73wR1hob5wsAn?=
 =?us-ascii?Q?l6ZkFwbi9/kCq4WmYoslzvXigZsvb0vi9+hXOvwSQPNpCcEklKsJBXXhSDFv?=
 =?us-ascii?Q?LeAh+0oKe6P7fEUZrUnoVdDtOkAFNspbE+WPvbZSHWgTH5eVnhI53lf2xCHZ?=
 =?us-ascii?Q?i8LetS56kBWqF5q+vHAf/VrxTG7UHfEKP4X+SoebMFqxxyeP+GPstejm+eEW?=
 =?us-ascii?Q?+xR5i2+OJ4et4VD7jxKhZ6XZeWSgRefYWhzYaJRaPStiRO73+1GptluaR/Ef?=
 =?us-ascii?Q?yrckMjRxwpLfJ6p0+PysqnEq46BlKbbhasLKbFdwqb5/0Vp4zX17S2t7dik9?=
 =?us-ascii?Q?Xo48E4+4F5MGKewKYj3/K5zbWUDOja9DSkg7P5eCUKulbSOGAHD+qghRrCFF?=
 =?us-ascii?Q?uAQK8b7suWvsvNNjAe3dXYwtncO7ALvlZBJwIHgFQIIootFaT5h2CedtpeBF?=
 =?us-ascii?Q?jFoDpMek8h4tc8tQCp9g80uG2rvtz+y7T0se53gg4MQaBslk1fQUXj5v9YCC?=
 =?us-ascii?Q?2xDebPdFU5ivDl9L/NJYoRvD9W+2xmbOCMcMnxUUNttt44BYI/C6aknnZobG?=
 =?us-ascii?Q?3dXzBlldlRXJHSqDeCA4UPZhzvtXBgi7E5FmbZzf0EcXGFA0Ox0BmTr8kXcL?=
 =?us-ascii?Q?u6ewQawYjaFSllci9uEukSLGR5QTTBQMDDiZNgaVzjDNHnJujKgTNXqDtAvp?=
 =?us-ascii?Q?kULEhw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded5c995-f876-4e3b-62da-08d99cda6bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2021 01:53:37.2194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1P+UcTrtIezsoJxBosHQotlG5f2iYowfAaZjw2Ug7wa27WaQzva4KMMq62keTIeGN8jyqYqoYVRmo+s3glkqEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2685
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

[Public]

> -----Original Message-----
> From: Li, Roman <Roman.Li@amd.com>
> Sent: Friday, October 29, 2021 18:12
> To: Alex Deucher <alexdeucher@gmail.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: RE: [PATCH v2] drm/amd/display: Look at firmware version to
> determine using dmub on dcn21
>=20
> [Public]
>=20
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Friday, October 29, 2021 4:34 PM
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Li, Roman
> > <Roman.Li@amd.com>
> > Subject: Re: [PATCH v2] drm/amd/display: Look at firmware version to
> > determine using dmub on dcn21
> >
> > On Fri, Oct 29, 2021 at 4:33 PM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> > >
> > > commit b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all
> > > dcn21
> > > asics") switched over to using dmub on Renoir to fix Gitlab 1735, but
> > > this implied a new dependency on newer firmware which might not be me=
t
> > > on older kernel versions.
> > >
> > > Since sw_init runs before hw_init, there is an opportunity to
> > > determine whether or not the firmware version is new to adjust the
> behavior.
> > >
> > > Cc: Roman.Li@amd.com
> > > BugLink:
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
itl
> > > ab.freedesktop.org%2Fdrm%2Famd%2F-
> > %2Fissues%2F1772&amp;data=3D04%7C01%7C
> > >
> >
> Roman.Li%40amd.com%7C4e27c983112e4ffdd36008d99b1b860a%7C3dd8961f
> > e4884e
> > >
> >
> 608e11a82d994e183d%7C0%7C0%7C637711364793611804%7CUnknown%7CT
> > WFpbGZsb3
> > >
> >
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> > D%7
> > >
> >
> C1000&amp;sdata=3DcFwunb4aAJbFkCe6lIFMY4oWfbkCVWAGshe8lB0rg0U%3D&
> > amp;res
> > > erved=3D0
> > > BugLink:
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
itl
> > > ab.freedesktop.org%2Fdrm%2Famd%2F-
> > %2Fissues%2F1735&amp;data=3D04%7C01%7C
> > >
> >
> Roman.Li%40amd.com%7C4e27c983112e4ffdd36008d99b1b860a%7C3dd8961f
> > e4884e
> > >
> >
> 608e11a82d994e183d%7C0%7C0%7C637711364793611804%7CUnknown%7CT
> > WFpbGZsb3
> > >
> >
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> > D%7
> > >
> >
> C1000&amp;sdata=3D%2F9sfVD5PN2tsl0bXkctPzkrHpJKQoZDex8xCDt1bVPg%3D&
> > amp;r
> > > eserved=3D0
> > > Fixes: b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all
> > > dcn21 asics")
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > > ---
> > >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > index 6dd6262f2769..e7ff8ad4c5a7 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > @@ -1410,7 +1410,10 @@ static int amdgpu_dm_init(struct amdgpu_device
> > *adev)
> > >                 switch (adev->ip_versions[DCE_HWIP][0]) {
> > >                 case IP_VERSION(2, 1, 0):
> > >                         init_data.flags.gpu_vm_support =3D true;
> > > +                       if
> > > + (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
> > >                                 init_data.flags.disable_dmcu =3D true=
;
> > > +                       else
> > > +                               init_data.flags.disable_dmcu =3D
> > > + adev->dm.dmcub_fw_version > 0x01000000;
>=20
> Since this is the only fw version that needs dmcu, it's safer to use equa=
l condition
> here.

Are you sure nothing older needs it?  Or are you just thinking because this=
 is the
"first firmware" that is released?

I seem to recall seeing this in a log that worked with it set to "false":

[drm] Loading DMUB firmware via PSP: version=3D0x00000001

>=20
> > >                         break;
> > >                 case IP_VERSION(1, 0, 0):
> > >                 case IP_VERSION(1, 0, 1):
> > > --
> > > 2.25.1
> > >
