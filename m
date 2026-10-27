Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6B1606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3ljVrtJx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B651510F634;
	Tue, 27 Oct 2026 15:23:04 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013041.outbound.protection.outlook.com
 [40.93.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEEF610F634
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 15:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sp9PxzvuRRt0MLvHmuOKBF1cSVpNjEKNw7kFqaJDMXGFnmzMwe/HKs2iDxRjkwNwi5ISKCYxyR8GuWQOv3eRtirkYJ9G9UfAQMAVsV3OBIa/53YnFrpgnKXEONgIwmqZbGgGalEFNXcYXxL31TWmbBeFrLAu0Wezl32ie1KYlZGrpFsAw14J93ASR3FQyB2sW0oWdfSYAY3wJqULoBIPob7VwXk9BrQKfbEBKJPZ//z7rRoH+RjHO/8ZzvUqOvAKv+jx64ZhJUzWKNKBmwpEutF/25ixNDU0nHSPtZphPH2GkKukXIZV7xsNjRKAAfZXXhubmdpirjo6IRS+DHYuzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dodiduh2KTXZGjlfvDaUIXmiA0dsG/xvvxZkpJIukGo=;
 b=EO/a+AiH02BGje9G5+K3JSHOusEHvtGqDVTlGbWCe6wGeVfK9WfWz+uUsn7CP7DzPiRq8XC4JeK84Ko67E2N33TtO94HZqxTJnFb8wW6ktVIsEpUg670AMae10tmQlr9cp3LVW/lLGktB46ae0Vr4EP458sTkeFBh88Z0Yi9QRADMTv9AdgoD/knnAHGo0eT6Y/xKU7ggfuvX5lvw6dbDnyAY/vwI/HZfw6s4eenoxCzppSITqTBWxJa8FIPFz+Rva7F8KVimPaoaJpnYFevMAJzgM/J6AbjSvuEaE8pUQff322Kx7F8V0nkEetjv5S22rrlzJaPQv0DwXFG21mwxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dodiduh2KTXZGjlfvDaUIXmiA0dsG/xvvxZkpJIukGo=;
 b=3ljVrtJx67Ku2hWrVcNEijDEUn3OwK7enRqraQdCqDiNQjcJm9dD/FrWM0Rw12i5mWIZdAXHT4glsrM0GX25xYWA9TnDxQ0Q/U4XHs+a7pZdqhhoKRD+zgcAiVEC7x8q/zK92o/J/vwoxXmIQ8po0pspk8lSHXX2Y71fNC+V2QY=
Received: from MW6PR12MB7072.namprd12.prod.outlook.com (2603:10b6:303:238::13)
 by LY0PR12MB335920.namprd12.prod.outlook.com (2603:10b6:404:22e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:22:55 +0000
Received: from MW6PR12MB7072.namprd12.prod.outlook.com
 ([fe80::a786:e93f:6c7b:ad9a]) by MW6PR12MB7072.namprd12.prod.outlook.com
 ([fe80::a786:e93f:6c7b:ad9a%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:22:55 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN
 idle work
Thread-Topic: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN
 idle work
Thread-Index: AQHdYslo88eLyLqXy0GjsxTisxnSPbcLucawgAPSZYCAAFBmMIABiZmAgAAgDeA=
Date: Tue, 27 Oct 2026 15:22:55 +0000
Message-ID: <MW6PR12MB707276D3E59DEE221733930EE5602@MW6PR12MB7072.namprd12.prod.outlook.com>
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
 <20261023083422.3049246-5-Prike.Liang@amd.com>
 <CY8PR12MB7435B329FCC59091483D66E4E5642@CY8PR12MB7435.namprd12.prod.outlook.com>
 <PH7PR12MB6000E8F8FD01623634E3EF18FB612@PH7PR12MB6000.namprd12.prod.outlook.com>
 <MW6PR12MB70724A38A2BFAAC16324E233E5612@MW6PR12MB7072.namprd12.prod.outlook.com>
 <PH7PR12MB6000F0BEA1BEC025F02E5E2CFB602@PH7PR12MB6000.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB6000F0BEA1BEC025F02E5E2CFB602@PH7PR12MB6000.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-23T22:41:42.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB7072:EE_|LY0PR12MB335920:EE_
x-ms-office365-filtering-correlation-id: 4b0ce322-9618-4242-cf01-08df343e2cf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|42112799006|261022075727099003|261026140227099003|38070700021|260925021911599003|260925021311599003|260925022911599003|5023799004|11063799006|4143699003|56012099006|261021123027099003|261009221227099003|261009220027099003|261022105027099003|261009223327099003|261021121427099003|261009223027099003|261009221727099003|10067099003|22082099003|261026121527099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: /aJakt1YHU7AuMkHQsJkZCDAVHW7bX4IjzDQ5Mjrs7g/9/Xr8+xvHH5yVNas7FrcOvnqE1LEbhwl8zEQRvtlIs3pmI5an/eKP0v9SXh7+gwYHpF0VatwbHqvd4AUhNx7UDectvQCW3Q945hGeLJfPKqHJfIKOMcvMxTRvjOGe+DXy4X8DDsbLldwEdrZcBguN8NYNTN5N4iz+TCVmTEIKxn0X11Kj/xzUFown6dK2c7ANAk4jAtGU1MAUjMNJdXpGRf1CS7TLQj1EgynO26U+esgE+1K0nW/TWYZB9yLTLh1TBBuFQ3YqFJUbYZRwBj2sJzM0cVVLGx1Zns0Ny2j2yDI5sXC2suDTfgeRTv8iEp0Dxo4z47qR8OKmVPBO0dmHoxHnsptH9mzBZ3XkBn8jwqDTwZCRqM+xmub61X1+tV/mB6i0Kk7JBLtm+tUEYsCsbflXNyp4SubOYz+IHiDwYhj0Qld0yuuxWQC+mDe4yp6zx3/BHsYhZRbOzxqQDItMh7suQAtor037smeaTshyTcZWI4ygdN9pNANefKh35b6ZZBQpqLqt+ouJHC1q2W/A0gPopUM3/NavlrhXSFJLouaX8LtnTZZy88Hoe7oMHQCbMdxHAvff1ah7FFmDA9VQj0k8boL2KxuPgz1e2bI7PJ30QaiDEmiuj9w418dQaw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB7072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(42112799006)(261022075727099003)(261026140227099003)(38070700021)(260925021911599003)(260925021311599003)(260925022911599003)(5023799004)(11063799006)(4143699003)(56012099006)(261021123027099003)(261009221227099003)(261009220027099003)(261022105027099003)(261009223327099003)(261021121427099003)(261009223027099003)(261009221727099003)(10067099003)(22082099003)(261026121527099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yM1sa9mCP6UGAGWxFX4u+ObH6MTVudbIeL/LuxHqA9X4WZL7lFhLs0238kSN?=
 =?us-ascii?Q?poQcP2MYBgvJtWDekjL2E0wTorCb7Y2QQfP+x15aeQrY8hZPz10YWbGEzPj+?=
 =?us-ascii?Q?kEeU6/AI1kMN5oCbTlestVbqGk401Bz8v3KX/hrCizy48PR5Um0alrqQFMx1?=
 =?us-ascii?Q?LauZJFnx8/3PoA2/7quCtbJakVHAAsMBBjeTo+HszsU6RC52g5m9cF1YqnTm?=
 =?us-ascii?Q?sCdjUAH7Jsb5JmruJ0FkN946TIaT51yW2x7sqCCpQupw8/BCi6iH391GUi0b?=
 =?us-ascii?Q?QUHl0Z3Sfsi+ZuAh3RvFrodjkTQnK/TqMWHPBJFS8ns2JSnJdNmemI0Kd7Qp?=
 =?us-ascii?Q?p32Q5kkpNHGKatqcgIfUd52lxSkSmdmpdcTmlKYcftLT5oo4uSIuFmOC/7Cw?=
 =?us-ascii?Q?+8XYXlaA+UPAMKobtVzt0CtcRqzNGNeit/gsWPcImVgIvXvx55/wHl57Cl0E?=
 =?us-ascii?Q?cbBsvcu5PPBYt3NcDcWH87A1mVsd5TQbMh+Ec5k6ojdGdIaJz9uJ03tRMgDr?=
 =?us-ascii?Q?xHADZe5UVRuCDInbPpGjkPENXOVg1Sr4vAvUopTJZvA1UNxzASWjVPzYHfN7?=
 =?us-ascii?Q?f3/env0NaNoZ/sgOegvOcS/6gpR6wLP4Jrw4alRH3UOlzlz/ewxmBncAB96b?=
 =?us-ascii?Q?NMw/DPECo3aqOnpyEDVbx0i3/DipluZS2UTjp4YT7Q5HJsUlgeVijCaBSFpD?=
 =?us-ascii?Q?zM3A6lEFfW7/nYtB7Mes5Jr5guPNvPfPyiQ2UaIHr0kOCydpjIZOEaNYn4lR?=
 =?us-ascii?Q?f8m+hEZVIGj2/SqlQET8XgwgX7NjOXVj3lNBZBZc32NSYe18S6uWh/05HIuZ?=
 =?us-ascii?Q?MrQhc+irYoT7MzEOfCXJGXFictZbCs4vQw2TUqmwhTjKnWNOxghTbOAWzpWH?=
 =?us-ascii?Q?2eBH7JYG6KSWg0gY+fvhW+k3HUHG01Bbsh9Nk+B1CjeCgZJIYPewIWli2XUs?=
 =?us-ascii?Q?4jNRQ/AWre1KOmucd1qUMSqGTRA16pbcJqS0/WIE7rjbgr1+x2FbiYFe4leY?=
 =?us-ascii?Q?X3PrZj4RPeY1vHKumIzkomSSyDlorQG3EMFyaVXbzpyNEiF2gXpYs7IxWDkr?=
 =?us-ascii?Q?cO0+UxnSznj8jsaRnN7hoZi/DjsOBYQgzD2TH9ZtMoivNDL+8ookQVs/q3Od?=
 =?us-ascii?Q?gEbknay6jyfP/9o1bDLlWGRIlrn2XhUwzB4RxV5DIUCiwktPGuvIHJ0xlNpr?=
 =?us-ascii?Q?n5yFkQXi5FTSOLz+zWt7ezrWnDwXbrJ5SkaD7oRpVoESOPolW4p9HLxsEPiM?=
 =?us-ascii?Q?cCAb6fy+1yoCs7+EykAipJTUAc0ylomhaUcU0TbbmgiLQawL0GcJ4usWpIGH?=
 =?us-ascii?Q?ZDqm2fRn7nU8KUJ9NK8LrKB5cAv9PqRyt7vtNKTP7UEJi5AJi+CjyTmpquIS?=
 =?us-ascii?Q?plrTI2ezBRxD227vfC4XORckab/Mvt73f0FuV3VXb4DnbZNbpdwqYljRxaQo?=
 =?us-ascii?Q?zNkTnMC0e+5VZ4aUM4NTbTWA5W2QLIUSW8Ywrb27ERBV7YOCtHRHshUSEZLb?=
 =?us-ascii?Q?DbpgmBrzg0lIQ9Hogzjk0Qkm9CB6Gw+T5WhrGJDgp8hOMCMSCcBy26zo9YJo?=
 =?us-ascii?Q?sR4VBVvaa/aMZg2URYyAmBCXlGPPKapQIX9nro07a+EcdpJ1mwl6kmjTXIp4?=
 =?us-ascii?Q?uTX+jkafyiIXnLE99pVdkXRVsIeeokE1ZMcyTm3JD2Y008oLSZpe/uEDJzW+?=
 =?us-ascii?Q?TS5jGXRHqOh5YYG3WzA763ZtT695uuuWjcmIk+mRy4w4kOis?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0ce322-9618-4242-cf01-08df343e2cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 15:22:55.6134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TAD1A7bxZu7IzOpFEF5/L2D93bzdBgnSWpQbjk2QdXAJf1KQugLD5Uz2h7df6y3n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB335920
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, October 27, 2026 9:20 AM
> To: Liu, Leo <Leo.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Prosyak, Vi=
taly
> <Vitaly.Prosyak@amd.com>
> Subject: RE: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the JPEG/=
VCN
> idle work
>
> AMD General
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Liu, Leo <Leo.Liu@amd.com>
> > Sent: Monday, October 26, 2026 10:32 PM
> > To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Prosyak,
> > Vitaly <Vitaly.Prosyak@amd.com>
> > Subject: RE: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the
> > JPEG/VCN idle work
> >
> > AMD General
> >
> > > -----Original Message-----
> > > From: Liang, Prike <Prike.Liang@amd.com>
> > > Sent: Monday, October 26, 2026 5:04 AM
> > > To: Liu, Leo <Leo.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > Christian <Christian.Koenig@amd.com>; Lazar, Lijo
> > > <Lijo.Lazar@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
> > > Subject: RE: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the
> > > JPEG/VCN idle work
> > >
> > > AMD General
> > >
> > > Regards,
> > >       Prike
> > >
> > > > -----Original Message-----
> > > > From: Liu, Leo <Leo.Liu@amd.com>
> > > > Sent: Saturday, October 24, 2026 6:47 AM
> > > > To: Liang, Prike <Prike.Liang@amd.com>;
> > > > amd-gfx@lists.freedesktop.org
> > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > Christian <Christian.Koenig@amd.com>; Lazar, Lijo
> > > > <Lijo.Lazar@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>;
> > > > Liang, Prike <Prike.Liang@amd.com>
> > > > Subject: RE: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for
> > > > the JPEG/VCN idle work
> > > >
> > > > AMD General
> > > >
> > > > > -----Original Message-----
> > > > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf
> > > > > Of Prike Liang
> > > > > Sent: Friday, October 23, 2026 4:34 AM
> > > > > To: amd-gfx@lists.freedesktop.org
> > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > > Christian <Christian.Koenig@amd.com>; Lazar, Lijo
> > > > > <Lijo.Lazar@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>;
> > > > > Liang, Prike <Prike.Liang@amd.com>
> > > > > Subject: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the
> > > > > JPEG/VCN idle work
> > > > >
> > > > > The common JPEG and VCN idle workers program power gating and
> > > > > DPG pause, so they must not run while a GPU reset is in progress.
> > > > > Recovery must not wait for them either, since everything the
> > > > > workers depend on then becomes a dependency of GPU recovery.
> > > > >
> > > > > Make the workers take reset_domain->sem for read, so they wait
> > > > > for a running reset instead of touching the hardware.
> > > > > hw_fini/suspend and begin_use, the latter for the IB tests, run
> > > > > from GPU recovery as well, so only skip waiting for the idle work=
 when the
> reset itself calls them.
> > > > > The reset holds the semaphore for write and would otherwise
> > > > > deadlock on a worker blocked on it. Outside a reset the cancel
> > > > > stays synchronous as before. sw_fini always cancels
> > > > > synchronously, it never runs with the reset semaphore held.
> > > > >
> > > > > Update versions: https://lore.kernel.org/amd-
> > > > > gfx/PH7PR12MB6000698A62D208E47BB358D7FB662@
> > > > > PH7PR12MB6000.namprd12.prod.outlook.com/
> > > > >
> > > > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > > > ---
> > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 20
> > > > > ++++++++++++++++++-- drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  |
> > > > > ++++++++++++++++++18
> > > > > +++++++++++++++++- drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h  |  1
> > > > > ++++++++++++++++++
> > > > >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
> > > > >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 +-
> > > > >  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 +-
> > > > >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 +-
> > > > >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  2 +-
> > > > > drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  2 +-
> > > > > drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
> > > > > drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 +-
> > > > > drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  2 +-
> > > > > drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  2 +-
> > > > >  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  4 ++--
> > > > >  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  2 +-
> > > > >  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  4 ++--
> > > > >  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  2 +-
> > > > >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 +-
> > > > >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  2 +-
> > > > > drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  2 +-
> > > > > drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  2 +-
> > > > > drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  2 +-
> > > > > drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  2 +-
> > > > >  23 files changed, 58 insertions(+), 25 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > > > > index 87f879a2e4f4..2bddef322870 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > > > > @@ -74,6 +74,8 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device
> > > > > *adev) {
> > > > >       int i, j;
> > > > >
> > > > > +     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > +
> > > >
> > > > I think this is redundant when hw_fini() ran normally,  they are
> > > > only needed when
> > > > hw_fini() was skipped - i.e. when hw_init() failed and status.hw wa=
s never
> set.
> > > > Also, UVD and VCE should be covered as well.
> > >
> > > Yeah, this change is aimed at the cases where the idle work isn't
> > > cancelled synchronously before sw_fini(): hw_fini() was skipped (e.g.
> > > hw_init() failed), or the suspend/hw_fini path only did the
> > > non-waiting cancel because it ran during a reset. If the idle work
> > > was already cancelled synchronously before sw_fini(), the extra
> > cancel_delayed_work_sync() is harmless and just returns.
> > >
> >
> > The problem is that calling cancel worker in sw_fini arrives too late,
> > the idle work is scheduled ~1 second into the future.
> > The fini_early/fini teardown sequence runs in that same window,
> > tearing down other IP blocks that VCN depends on (MMHUB, SMU). The
> > right place to cancel is in hw_init()'s error path, immediately before
> > returning the error, while other IPs is still alive, and close time win=
dow which
> could lead to problems.
>
> Yes, I'll add a separate patch that cancels synchronously the idle work i=
n the
> hw_init error paths, so the worker can't run after a failed hw_init.
>
> I'd like to keep the synchronous cancel in sw_fini, though. It covers the=
 case
> where hw_fini doesn't wait for a worker that's already running, which hap=
pens
> when a peer in the same XGMI hive is resetting. The cancel makes sure tha=
t
> worker finishes before its state is freed.

That is a race condition, and the cancel doesn't fix the root cause,
The preferred fix should make hw_fini properly so it always guarantees the =
handler is done, removing the need for anything in sw_fini.
At least, if keeping something in sw_fini, you need to make it conditional =
- only when hw_fini actually left a handler running.

Thanks,
Leo

>
> There's still a related timing issue in the hive reset case: the worker c=
an run after
> VCN and SMU have been torn down. I'll handle that separately, I want to k=
eep
> this series focused on GPU recovery first.
>
> Regards,
> Prike
>
>
> > Thanks,
> > Leo
> >
> > > If there are no other objections, I'll submit this fix upstream later=
.
> > >
> > > Meanwhile, could someone help review patches 3 and 4? They remove
> > > the VCN/JPEG memory allocations, which can trigger reclaim, from the
> > > GPU recovery path.
> > >
> > > Thanks,
> > > Prike
> > >
> > > > Thanks,
> > > > Leo
> > > >
> > > > >       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> > > > >               if (adev->jpeg.harvest_config & (1U << i))
> > > > >                       continue;
> > > > > @@ -95,9 +97,18 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device
> > > *adev)
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > +static void amdgpu_jpeg_cancel_idle_work(struct amdgpu_device
> > > > > +*adev) {
> > > > > +     /* The reset mustn't wait for the idle work, which waits fo=
r the reset
> */
> > > > > +     if (amdgpu_in_reset(adev))
> > > > > +             cancel_delayed_work(&adev->jpeg.idle_work);
> > > > > +     else
> > > > > +             cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > +}
> > > > > +
> > > > >  int amdgpu_jpeg_suspend(struct amdgpu_device *adev)  {
> > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > +     amdgpu_jpeg_cancel_idle_work(adev);
> > > > >
> > > > >       return 0;
> > > > >  }
> > > > > @@ -114,6 +125,9 @@ static void
> > > > > amdgpu_jpeg_idle_work_handler(struct
> > > > > work_struct *work)
> > > > >       unsigned int fences =3D 0;
> > > > >       unsigned int i, j;
> > > > >
> > > > > +     /* Nothing holding the reset semaphore waits for this work =
*/
> > > > > +     down_read(&adev->reset_domain->sem);
> > > > > +
> > > > >       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> > > > >               if (adev->jpeg.harvest_config & (1U << i))
> > > > >                       continue;
> > > > > @@ -129,6 +143,8 @@ static void
> > > > > amdgpu_jpeg_idle_work_handler(struct
> > > > > work_struct *work)
> > > > >               mutex_unlock(&adev->jpeg.jpeg_pg_lock);
> > > > >       } else
> > > > >               schedule_delayed_work(&adev->jpeg.idle_work,
> > > > > JPEG_IDLE_TIMEOUT);
> > > > > +
> > > > > +     up_read(&adev->reset_domain->sem);
> > > > >  }
> > > > >
> > > > >  void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring) @@
> > > > > -136,7
> > > > > +152,7 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring
> > > > > *ring)
> > > > >       struct amdgpu_device *adev =3D ring->adev;
> > > > >
> > > > >       if (!atomic_fetch_inc(&adev->jpeg.total_submission_cnt))
> > > > > -             cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > +             amdgpu_jpeg_cancel_idle_work(adev);
> > > > >
> > > > >       mutex_lock(&adev->jpeg.jpeg_pg_lock);
> > > > >       amdgpu_device_ip_set_powergating_state(adev,
> > > > > AMD_IP_BLOCK_TYPE_JPEG,
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > > > index 34e1242d66ea..631f9471be1f 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > > > @@ -269,6 +269,8 @@ void amdgpu_vcn_sw_fini(struct amdgpu_device
> > > > > *adev, int i)
> > > > >       if (adev->vcn.harvest_config & (1 << i))
> > > > >               return;
> > > > >
> > > > > +     cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> > > > > +
> > > > >       amdgpu_bo_free_kernel(
> > > > >               &adev->vcn.inst[i].dpg_sram_bo,
> > > > >               &adev->vcn.inst[i].dpg_sram_gpu_addr,
> > > > > @@ -459,6 +461,15 @@ void amdgpu_vcn_put_profile(struct
> > > > > amdgpu_device
> > > > > *adev)
> > > > >       mutex_unlock(&adev->vcn.workload_profile_mutex);
> > > > >  }
> > > > >
> > > > > +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst
> > > > > +*vcn_inst) {
> > > > > +     /* The reset mustn't wait for the idle work, which waits fo=
r the reset
> */
> > > > > +     if (amdgpu_in_reset(vcn_inst->adev))
> > > > > +             cancel_delayed_work(&vcn_inst->idle_work);
> > > > > +     else
> > > > > +             cancel_delayed_work_sync(&vcn_inst->idle_work);
> > > > > +}
> > > > > +
> > > > >  static void amdgpu_vcn_idle_work_handler(struct work_struct
> > > > > *work) {
> > > > >       struct amdgpu_vcn_inst *vcn_inst =3D @@ -470,6 +481,9 @@
> > > > > static void amdgpu_vcn_idle_work_handler(struct
> > > > > work_struct *work)
> > > > >       if (adev->vcn.harvest_config & (1 << i))
> > > > >               return;
> > > > >
> > > > > +     /* Nothing holding the reset semaphore waits for this work =
*/
> > > > > +     down_read(&adev->reset_domain->sem);
> > > > > +
> > > > >       for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
> > > > >               fence[i] +=3D amdgpu_fence_count_emitted(&vcn_inst-
> > > > > >ring_enc[j]);
> > > > >
> > > > > @@ -499,6 +513,8 @@ static void
> > > > > amdgpu_vcn_idle_work_handler(struct
> > > > > work_struct *work)
> > > > >       } else {
> > > > >               schedule_delayed_work(&vcn_inst->idle_work,
> > > > > VCN_IDLE_TIMEOUT);
> > > > >       }
> > > > > +
> > > > > +     up_read(&adev->reset_domain->sem);
> > > > >  }
> > > > >
> > > > >  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring) @@
> > > > > -507,7
> > > > > +523,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring
> > > > > *ring)
> > > > >       struct amdgpu_vcn_inst *vcn_inst =3D
> > > > > &adev->vcn.inst[ring->me];
> > > > >
> > > > >       if (!atomic_fetch_inc(&vcn_inst->total_submission_cnt))
> > > > > -             cancel_delayed_work_sync(&vcn_inst->idle_work);
> > > > > +             amdgpu_vcn_cancel_idle_work(vcn_inst);
> > > > >
> > > > >       mutex_lock(&vcn_inst->vcn_pg_lock);
> > > > >       vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > > > index bea95307fd42..a6438950854e 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > > > @@ -526,6 +526,7 @@ int amdgpu_vcn_suspend(struct amdgpu_device
> > > > > *adev, int i);  int amdgpu_vcn_resume(struct amdgpu_device
> > > > > *adev, int i);  void amdgpu_vcn_ring_begin_use(struct
> > > > > amdgpu_ring *ring); void amdgpu_vcn_ring_end_use(struct
> > > > > amdgpu_ring *ring);
> > > > > +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst
> > > > > +*vcn_inst);
> > > > >
> > > > >  bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,
> > > > >                               enum vcn_ring_type type, uint32_t
> > > > > vcn_instance); diff --git
> > > > > a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > > > index 72069b77f6f1..b048fd4b8b59 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > > > @@ -177,7 +177,7 @@ static int jpeg_v2_0_hw_fini(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)
> > > > >  {
> > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > >
> > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > +     amdgpu_jpeg_suspend(adev);
> > > > >
> > > > >       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> > > > >             RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS)) diff --git
> > > > > a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > > > > index 2968256d4cd7..f6a9258ae3ca 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > > > > @@ -239,7 +239,7 @@ static int jpeg_v2_5_hw_fini(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)
> > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > >       int i;
> > > > >
> > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > +     amdgpu_jpeg_suspend(adev);
> > > > >
> > > > >       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> > > > >               if (adev->jpeg.harvest_config & (1 << i)) diff
> > > > > --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > > > index 564e40899df2..922711aa06a3 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > > > @@ -192,7 +192,7 @@ static int jpeg_v3_0_hw_fini(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)
> > > > >  {
> > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > >
> > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > +     amdgpu_jpeg_suspend(adev);
> > > > >
> > > > >       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> > > > >             RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS)) diff --git
> > > > > a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > > > > index b29ca3a49939..fe7ab9cb35bb 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > > > > @@ -221,7 +221,7 @@ static int jpeg_v4_0_hw_fini(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)
> > > > >  {
> > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > >
> > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > +     amdgpu_jpeg_suspend(adev);
> > > > >       if (!amdgpu_sriov_vf(adev)) {
> > > > >               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> > > > >                       RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > > > > index 0343a64595f2..f4896ad9d1de 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > > > > @@ -455,7 +455,7 @@ static int jpeg_v4_0_3_hw_fini(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)
> > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > >       int ret =3D 0;
> > > > >
> > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > +     amdgpu_jpeg_suspend(adev);
> > > > >
> > > > >       if (!amdgpu_sriov_vf(adev)) {
> > > > >               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE)
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> > > > > index 4da3f9c995c1..87efc3c2b9e0 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> > > > > @@ -250,7 +250,7 @@ static int jpeg_v4_0_5_hw_fini(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)
> > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > >       int i;
> > > > >
> > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > +     amdgpu_jpeg_suspend(adev);
> > > > >
> > > > >       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> > > > >               if (adev->jpeg.harvest_config & (1 << i)) diff
> > > > > --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > > > > index dcdb089b4308..91968ad26f17 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > > > > @@ -189,7 +189,7 @@ static int jpeg_v5_0_0_hw_fini(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)
> > > > >  {
> > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > >
> > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > +     amdgpu_jpeg_suspend(adev);
> > > > >
> > > > >       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> > > > >             RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS)) diff
> > > > > --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > > > > index f2debf6b6bd0..27116d1e9e64 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > > > > @@ -326,7 +326,7 @@ static int jpeg_v5_0_1_hw_fini(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)
> > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > >       int ret =3D 0;
> > > > >
> > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > +     amdgpu_jpeg_suspend(adev);
> > > > >
> > > > >       if (!amdgpu_sriov_vf(adev)) {
> > > > >               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE)
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> > > > > index dd0abce73687..7e068c2d4d6d 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> > > > > @@ -299,7 +299,7 @@ static int jpeg_v5_0_2_hw_fini(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)
> > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > >       int ret =3D 0;
> > > > >
> > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > +     amdgpu_jpeg_suspend(adev);
> > > > >
> > > > >       if (!amdgpu_sriov_vf(adev)) {
> > > > >               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE)
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > > > > index 8ddd12740a04..16daeb61114c 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > > > > @@ -172,7 +172,7 @@ static int jpeg_v5_3_0_hw_fini(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)
> > > > >  {
> > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > >
> > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > +     amdgpu_jpeg_suspend(adev);
> > > > >
> > > > >       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> > > > >             RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS))
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > index 76793a5caa70..470d8f110799 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > @@ -150,8 +150,8 @@ static int vcn_v1_0_sw_init(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)
> > > > >       if (r)
> > > > >               return r;
> > > > >
> > > > > -     /* Override the work func */
> > > > > -     adev->vcn.inst[0].idle_work.work.func =3D
> vcn_v1_0_idle_work_handler;
> > > > > +     /* Own lockdep class, this work is still cancelled synchron=
ously */
> > > > > +     INIT_DELAYED_WORK(&adev->vcn.inst[0].idle_work,
> > > > > vcn_v1_0_idle_work_handler);
> > > > >
> > > > >       amdgpu_vcn_setup_ucode(adev, 0);
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > > > > index 7d2b9e4b913a..ba451f2a2534 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > > > > @@ -322,7 +322,7 @@ static int vcn_v2_0_hw_fini(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)
> > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > >       struct amdgpu_vcn_inst *vinst =3D adev->vcn.inst;
> > > > >
> > > > > -     cancel_delayed_work_sync(&vinst->idle_work);
> > > > > +     amdgpu_vcn_cancel_idle_work(vinst);
> > > > >
> > > > >       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> > > > >           (vinst->cur_state !=3D AMD_PG_STATE_GATE && diff --git
> > > > > a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > > > > index 10ef5616b2f5..9dd4c313cbe7 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > > > > @@ -304,8 +304,8 @@ static int vcn_v2_5_sw_init(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)
> > > > >               if (r)
> > > > >                       return r;
> > > > >
> > > > > -             /* Override the work func */
> > > > > -             adev->vcn.inst[j].idle_work.work.func =3D
> > > > > vcn_v2_5_idle_work_handler;
> > > > > +             /* Own lockdep class, this work is still cancelled
> > > > > + synchronously
> > > > > */
> > > > > +             INIT_DELAYED_WORK(&adev->vcn.inst[j].idle_work,
> > > > > vcn_v2_5_idle_work_handler);
> > > > >
> > > > >               amdgpu_vcn_setup_ucode(adev, j);
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > > > index 0f4f4d66e2e4..3e85abd1e82c 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > > > @@ -449,7 +449,7 @@ static int vcn_v3_0_hw_fini(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)
> > > > >               if (adev->vcn.harvest_config & (1 << i))
> > > > >                       continue;
> > > > >
> > > > > -             cancel_delayed_work_sync(&vinst->idle_work);
> > > > > +             amdgpu_vcn_cancel_idle_work(vinst);
> > > > >
> > > > >               if (!amdgpu_sriov_vf(adev)) {
> > > > >                       if ((adev->pg_flags &
> > > > > AMD_PG_SUPPORT_VCN_DPG)
> > > > > || diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > > > > index 4b7f7bbe18da..5b47a643d725 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > > > > @@ -374,7 +374,7 @@ static int vcn_v4_0_hw_fini(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)
> > > > >               if (adev->vcn.harvest_config & (1 << i))
> > > > >                       continue;
> > > > >
> > > > > -             cancel_delayed_work_sync(&vinst->idle_work);
> > > > > +             amdgpu_vcn_cancel_idle_work(vinst);
> > > > >
> > > > >               if (!amdgpu_sriov_vf(adev)) {
> > > > >                       if ((adev->pg_flags &
> > > > > AMD_PG_SUPPORT_VCN_DPG)
> > > > > || diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > > > index 3f39aa83c319..5aa09c3bd79b 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > > > @@ -417,7 +417,7 @@ static int vcn_v4_0_3_hw_fini(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)
> > > > >       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> > > > >               struct amdgpu_vcn_inst *vinst =3D
> > > > > &adev->vcn.inst[i];
> > > > >
> > > > > -             cancel_delayed_work_sync(&vinst->idle_work);
> > > > > +             amdgpu_vcn_cancel_idle_work(vinst);
> > > > >
> > > > >               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
> > > > >                       vinst->set_pg_state(vinst,
> > > > > AMD_PG_STATE_GATE); diff --git
> > > > > a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > > > > index f30f80c1b07f..9693950cd16d 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > > > > @@ -327,7 +327,7 @@ static int vcn_v4_0_5_hw_fini(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)
> > > > >               if (adev->vcn.harvest_config & (1 << i))
> > > > >                       continue;
> > > > >
> > > > > -             cancel_delayed_work_sync(&vinst->idle_work);
> > > > > +             amdgpu_vcn_cancel_idle_work(vinst);
> > > > >
> > > > >               if (!amdgpu_sriov_vf(adev)) {
> > > > >                       if ((adev->pg_flags &
> > > > > AMD_PG_SUPPORT_VCN_DPG)
> > > > > || diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > > > > index 7b7c3bc9f046..0c189063a6ab 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > > > > @@ -291,7 +291,7 @@ static int vcn_v5_0_0_hw_fini(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)
> > > > >               if (adev->vcn.harvest_config & (1 << i))
> > > > >                       continue;
> > > > >
> > > > > -             cancel_delayed_work_sync(&vinst->idle_work);
> > > > > +             amdgpu_vcn_cancel_idle_work(vinst);
> > > > >
> > > > >               if (!amdgpu_sriov_vf(adev)) {
> > > > >                       if ((adev->pg_flags &
> > > > > AMD_PG_SUPPORT_VCN_DPG)
> > > > > || diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > > > > index c9e990ab297d..3fa553fb41d3 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > > > > @@ -364,7 +364,7 @@ static int vcn_v5_0_1_hw_fini(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)
> > > > >       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> > > > >               struct amdgpu_vcn_inst *vinst =3D
> > > > > &adev->vcn.inst[i];
> > > > >
> > > > > -             cancel_delayed_work_sync(&adev->vcn.inst[i].idle_wo=
rk);
> > > > > +             amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
> > > > >               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
> > > > >                       vinst->set_pg_state(vinst, AMD_PG_STATE_GAT=
E);
> > > > >       }
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> > > > > index ed47ddd5b08c..eb13f792e25d 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> > > > > @@ -279,7 +279,7 @@ static int vcn_v5_0_2_hw_fini(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)
> > > > >       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> > > > >               struct amdgpu_vcn_inst *vinst =3D
> > > > > &adev->vcn.inst[i];
> > > > >
> > > > > -             cancel_delayed_work_sync(&adev->vcn.inst[i].idle_wo=
rk);
> > > > > +             amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
> > > > >               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
> > > > >                       vinst->set_pg_state(vinst, AMD_PG_STATE_GAT=
E);
> > > > >       }
> > > > > --
> > > > > 2.34.1
> > > >
> > >
> >
>

