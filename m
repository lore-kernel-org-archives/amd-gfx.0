Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD710C6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 20:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CCF710E557;
	Thu,  2 Mar 2023 20:21:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBABB10E555
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 20:21:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z025I+xJMrWBUVVV23uAnodC+OptLU98DhX4NtysoZtErqdiDI2+Cxz8f0f7hH63hwNwLkHVEXkTL5FSn6m1shBHTjQhZ9G/rRy+L/hNurWQp8dDYWYL9yLhQbR9siBefOUh+Qq0lNqvAk8CjBKGcAicjlY2Ygpv0ZQtS9S2sZMoVloT35N7Den8Ha0Y7lbS5obzXJyy51b326ASG1GIkSqQm6aZqe0latW3uQIpk5uVQ/OfYxjrrR0mI0rihqxOz8oR0tqP6u9JyyMCt4Gc0hVD39mixmdOzOJzJbD6fWYVa7VqSn4W9HgK+egDtTwaiTax4etcaftpINBflqFBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSMKvpxv0/cxiie4hJzuf3OqHBRTiEfLe1XU9uROCQk=;
 b=eij1a9OTGFTVRAfl2vnSdecycP4YhbvHSZopz6drYX3aPmHSNlbuyH2aqAI7jD35xG44tLwNW02i4vxW998FK3wk6pyirVaIwW2hM4vtOTAFpJVSeIbXbaVEfpwl+VVSSSAyHghKXf+BodqewbZqXqYQdo8CRiQS13H9Sam4SP0xhvo5sJchJVqMGSZxdZENi/hougEZ8/2IRalmdn6qujFi1K0Y5CReS2UUxVklPU9vJPFHOjP1qaJt1MDg1E8ci9mJN1d6gOA+x6ldiic6HphmkCOT2JnqW6nNdpvNqutzQHfCPahjren/kxbW5uuSChrAdd3nCxkeTDjeFUsQcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSMKvpxv0/cxiie4hJzuf3OqHBRTiEfLe1XU9uROCQk=;
 b=qlfGKy7OoCW4cnEmNh/3xLIjgxqNSohSGRmpLmdXKwlbdFUka7CP7D0BJjzg71Ktk6nb5FHpGjmZt+wCQ56qEbfrI51B3gw3jgAKLyONGdrVCuIApZnwoF64kA6F2ugVcJHRm6rcQVsTLlBJX4GwS29BnvUREhuZO1ADgG0d1Yo=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 20:21:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%7]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 20:21:21 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Thomas Glanzmann <thomas@glanzmann.de>
Subject: RE: [PATCH] drm/amd: Fix initialization mistake for NBIO 7.3.0
Thread-Topic: [PATCH] drm/amd: Fix initialization mistake for NBIO 7.3.0
Thread-Index: AQHZTSxRFnfkYSNAkkuQ2r8Re7Jwm67n7X2AgAAAl/A=
Date: Thu, 2 Mar 2023 20:21:21 +0000
Message-ID: <MN0PR12MB6101E555D72C3644F02DDF3BE2B29@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230302172731.721-1-mario.limonciello@amd.com>
 <ZAEEMQTI2L2UHOIa@glanzmann.de>
In-Reply-To: <ZAEEMQTI2L2UHOIa@glanzmann.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-02T20:21:20Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=20caf863-2cbc-4621-819a-5f22ec50e2e0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-03-02T20:21:20Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 037ec09a-fa19-4a04-bfb5-8f5f61a88259
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CO6PR12MB5441:EE_
x-ms-office365-filtering-correlation-id: 6735211b-87ab-4e43-be04-08db1b5bb053
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jyT/iVlG+HGTJfqzdL2r92FQYUdNmnPsVxJkjrNu8pxlz9bc11PwiC9+2llUNvpPYrdYnDt8vWd3bi2BhDtswL+hSttEYVg8yWrBtsSBoxoPuYZJL0HURdINAMQmzHUy1RNtjNUBrvaPygR54dvnd2N3vn2iDsriWLsbQyzttv0KwrXPXB/PalC0ATW83xoqzzQMOLIzwfNwD8mu7vDXU8+KFYdN8LuoX15bTUMB+LFXZ2D6hPUrJPTZQ+WunwQ7F+4SUfCgJWlDBDriw71cfrTAv4GqbFC7YnnQteK39toK+U3K6lfOmVQ5rHX9jMU+1IM4QS+zXUbU/5THm4MmDpqSYpOaofDMjHZu0gmkodl9nDBZQF1YJBD0OLxjriKjhH+Knjt1xZ91QLkLPgds6yiAFfOE4J07i3fxLP0C2UpVXCzu0XZYdDiofEwI2rXYFqc0MAPnFNY8d/69QYU4XJf4z78ZOD2DmhUh8up2yzGFGkHh85rOwpcLoV5yY/dlDg152TPeV2XCaCAFaj0+6sKulxSDAwQKOLDseeDwz6jDsMzgefWE5m3Agx7GQMjRcdb4ipa75J3zW8N6cWW+sPx1kV/3pcnBvV9i2LF5dpR/xENU2Uuf3qM6wStroYZEQiWYL1VJTi/tDAW7WSifLGb+VdsLWOhwgl6a9X4Py1anFRhcrEToqvCu9bLjwyJR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199018)(83380400001)(33656002)(55016003)(53546011)(122000001)(38100700002)(5660300002)(52536014)(478600001)(8936002)(66556008)(86362001)(38070700005)(71200400001)(26005)(9686003)(186003)(76116006)(6506007)(966005)(64756008)(8676002)(66446008)(7696005)(66946007)(66476007)(2906002)(6916009)(4326008)(316002)(54906003)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UQDoiedN/niVc+scH61Ir5YSr2zWS2/cXEjIfvCeq0UNTP0KUpDk75qbTaJw?=
 =?us-ascii?Q?YsXHpvdWf6B/28YvllcQ1ZyqS7IpjyMstcTUtPZy9tdf2LTfkc+5tg450p4i?=
 =?us-ascii?Q?u7+UgR3oicDEwf5yhyeABjCIStS1HoitdOroP7nT0LdKBfbnunzLwsrlTljk?=
 =?us-ascii?Q?8Tx/UdK80P2KWHRZik8sIxuuo45seXVn+WP0H7DYmYBmtbrvMXiX0zxjjGKO?=
 =?us-ascii?Q?WY4wqWIVBP8wME04mGtU0Sg4wHsiEpDiYmoMz7MtMZk8Kz5WfRxc7zW3imCB?=
 =?us-ascii?Q?lmbyjUHy1DMzRY78rnINeX9d2lzqjlN50P11+s3NamltIefelt6vcKUbeGZ3?=
 =?us-ascii?Q?jx8iVp3+bMB5A4owFB9MSJuLnJgO07MX8sLRKDqSE6PrMKs7b6hEYSWEubUv?=
 =?us-ascii?Q?277quX+9DgRNC+q1Bgme8O2Ju/lPu0cEVAi2Xa3uwm14/DWc5S+W13Pqpia4?=
 =?us-ascii?Q?Q0rIWwt+hIWplNMJWNB0w7EMyIXIys2Mq6wNLCQQRjjtojwHo2RlGmBEjfm8?=
 =?us-ascii?Q?W4jmREnT16rErQu/xiIqruS8D66OAA3nGngKNploSI8Aj7gjXWrOQGjVNWk5?=
 =?us-ascii?Q?Kh0eXqOgFNmWdzlq0LzeLa29jNPuqkuYuvUz2MAza4Tr0Xubo2ZOmE7P8vUi?=
 =?us-ascii?Q?BMVkwuktRGmKKWWtZNip19t8mXP1mM7BSvWwLNvxTVEGV9j/mZcu+Ya7D3Iw?=
 =?us-ascii?Q?YQeddce6beR4I5T/fbn/vq12Y7ypuEEXSpAB8VxBkhWDMfMlMx92AUrxA32C?=
 =?us-ascii?Q?7/gSXp56h+XHQBJc2khGAbD0kisBhUWNGu8Wo9qjJ3tkVH4FVsjFXG/cPu5l?=
 =?us-ascii?Q?2MAJaDS60uj5LjlTw05ImquXOUoerP+LfUFKRvltHs34H9nc2vSW/RpBDUC9?=
 =?us-ascii?Q?8vOHBMleNZ8Z2EVsi4tZDtpWV0yh92Rt0jUFzwazi+JFxU31w/0VSuSvWIbu?=
 =?us-ascii?Q?3h5j4k5MwEz28/wGtQUhElSBtPyRUOfZfxLx4X7+jFfc2cRcUjVPA9XiRawW?=
 =?us-ascii?Q?AkW4JHIj2en6L+SRVyMj0xiN5SRc6MH67SppXwQe2bY4C76o6cC/f2Gz8q2z?=
 =?us-ascii?Q?aGFRRRolOywQkyc8gTq+MmGE2AFB8pmXpgERM+u9YOfc7AqtqMTHHvyKuxlW?=
 =?us-ascii?Q?szXpLrtcMrMZY5lNUHK7ATQqfirrlXT3ZEVZlWAbhROG/CT9bNLkYEPJxxWk?=
 =?us-ascii?Q?YlsfOs7FMSo1IRTw+UHYZo4tcbCvt5x+ECPVWAcUhXBLTkN2s3OYwA1mQdDp?=
 =?us-ascii?Q?qNlDRh00086A/LkqZgYJvwzgbmFwLcmxyYQOS3VXTecWEzBwVWog1ZVIGWCI?=
 =?us-ascii?Q?pEgmEaft6MlOR1Qbzw7eGbSVDZa3jW8uYlStzlY/sgnQO5DIHk1UkD0p1h9Q?=
 =?us-ascii?Q?gP54AfwTMjOrOnH9KHYtXea2izwpZXBQK9hXQfCi9oQP34PiAPxjaiXeu+DH?=
 =?us-ascii?Q?QCncdvzt3P7Fjvn/j8J+ngQa1Kw/BwjGunElUPTnEq5EvEjnUsp4GZd8TqKm?=
 =?us-ascii?Q?7zUMo3LDqxGiJ6Tw7oNOpErYf9G0OoAEFxUl8c+LPO/S3975FbBNmuDNESoo?=
 =?us-ascii?Q?FSZEMfiCmSWi7W+t1Nc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6735211b-87ab-4e43-be04-08db1b5bb053
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 20:21:21.6528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t440CPE3U1j2gkCPSVNqjXrgRC2O0RM+TrHsvU17mXUONwADM6Wn2t5LYbYKYS5kP47lNZAiKLq+G+ym1H5hBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5441
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Natikar, 
 Basavaraj" <Basavaraj.Natikar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



> -----Original Message-----
> From: Thomas Glanzmann <thomas@glanzmann.de>
> Sent: Thursday, March 2, 2023 14:17
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Natikar, Basavaraj
> <Basavaraj.Natikar@amd.com>
> Subject: Re: [PATCH] drm/amd: Fix initialization mistake for NBIO 7.3.0
>=20
> Hello Mario,
>=20
> * Mario Limonciello <mario.limonciello@amd.com> [2023-03-02 18:27]:
> > The same strapping initialization issue that happened on NBIO 7.5.1
> > appears to be happening on NBIO 7.3.0.
> > Apply the same fix to 7.3.0 as well.
>=20
> > Note: This workaround relies upon the integrated GPU being enabled
> > in BIOS. If the integrated GPU is disabled in BIOS a different
> > workaround will be required.
>=20
> > Reported-by: Thomas Glanzmann <thomas@glanzmann.de>
> > Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> > Link: https://lore.kernel.org/linux-
> usb/Y%2Fz9GdHjPyF2rNG3@glanzmann.de/T/#u
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>=20
> Tested-by: Thomas Glanzmann <thomas@glanzmann.de>
>=20
> > ---
> >  drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> > index 4b0d563c6522c..4ef1fa4603c8e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> > @@ -382,11 +382,6 @@ static void nbio_v7_2_init_registers(struct
> amdgpu_device *adev)
> >  		if (def !=3D data)
> >  			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0,
> regBIF1_PCIE_MST_CTRL_3), data);
> >  		break;
> > -	case IP_VERSION(7, 5, 1):
> > -		data =3D RREG32_SOC15(NBIO, 0,
> regRCC_DEV2_EPF0_STRAP2);
> > -		data &=3D
> ~RCC_DEV2_EPF0_STRAP2__STRAP_NO_SOFT_RESET_DEV2_F0_MASK;
> > -		WREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2,
> data);
> > -		fallthrough;
> >  	default:
> >  		def =3D data =3D RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO,
> 0, regPCIE_CONFIG_CNTL));
> >  		data =3D REG_SET_FIELD(data, PCIE_CONFIG_CNTL,
> > @@ -399,6 +394,15 @@ static void nbio_v7_2_init_registers(struct
> amdgpu_device *adev)
> >  		break;
> >  	}
>=20
> My tree did not have the above hunk, so I only applied the second hunk.

Yeah this hunk it changes is on it's way to 6.3 right now.  I think with th=
e good
test results we probably want to take this back to stable as well when they
both land.

>=20
> I replugged by mouse keyboard several times and I have no longer any
> issues.
>=20
> Find output of dmesg; lsusb; lspci; dmidecode; lscpu here:
>=20
> https://tg.st/u/498cb495b307353870e4dbba901a9c7aa58b89d918f54fc73f014f
> 9a4778cc2a.txt
>=20
> > +	switch (adev->ip_versions[NBIO_HWIP][0]) {
> > +	case IP_VERSION(7, 3, 0):
> > +	case IP_VERSION(7, 5, 1):
> > +		data =3D RREG32_SOC15(NBIO, 0,
> regRCC_DEV2_EPF0_STRAP2);
> > +		data &=3D
> ~RCC_DEV2_EPF0_STRAP2__STRAP_NO_SOFT_RESET_DEV2_F0_MASK;
> > +		WREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2,
> data);
> > +		break;
> > +	}
> > +
> >  	if (amdgpu_sriov_vf(adev))
> >  		adev->rmmio_remap.reg_offset =3D
> SOC15_REG_OFFSET(NBIO, 0,
> >
> 	regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>=20
> Thank you for the workaround.

Sure, thanks for reporting it.

