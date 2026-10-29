Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A344606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 03:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tYyUh+tf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E5AB10E339;
	Thu, 29 Oct 2026 03:21:32 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013017.outbound.protection.outlook.com
 [40.107.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09E6510E339
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 03:21:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2LkEr2Y5JCcgjHdRlIs1jHNWAolM6itvGEfEyo0XT0cHVE/2e1BPe2+qzoDxI1oZFImbVXnRbSSp/iJM2LkJ6jI3da+OLUfJp7y67Ajw+tVxLHNAOZ8E/JGKNGhvBJ7GNpL58uwtNQ/Am6JZayOL7aR9+QCqDu4HcOl56zJBvtLfvOfWaUqN9fEopSytzJgx7NSGbcD89sCj7DqcP7WxihbalsLg6FYIeh+4Au1OLhmSm6wGhe7DpQ6ZIJxHDigZ+D3NpAkTmJ9tVMuPNhkmZu216QHr0sVpOEKlG+Y0ZGN98KM7VbumtvhZI4ilKqd7nwbvR9yv/u7GvXDR7cjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNceuiWasX9YJJazJdHk11/+kPwb5MpqL8456p9d9UA=;
 b=HqJzA29Q0BIBDblxrUzI8plwZvtV0Spx45L76HlxvoXVV6Q4UEylvX5U6G/SY/7bzB3ZB52OMMt809lzLFDYayjQa0CtL7qW7GnRhkz35KQgYhdxcd6xl43b9dxAxIpmDI4iBlb9t9n2BJ3SwfqV8spIXF/gAUZ2q6M4effzsYNBFhditxDC9S559GoW2KSXJTW41m6UlrGxMWDn5XLlftBh9p+mmvEjNUpZ8dGpVwX1myMzQNyplDtZbDs5vzOXXYcHm+aIeAHH0cefjUPvlpydLREaS+gqsuqXI8B3BcLQGPLM7Q+1sAziIEl0JeZgez53ZaAz4noxjOrjPU2DJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNceuiWasX9YJJazJdHk11/+kPwb5MpqL8456p9d9UA=;
 b=tYyUh+tfRD4jNgFsYlNxidTS2d+TGr1WGhQoIupA83Rd+bX3MrosB0eQ8Kxk3FCAMcnU7CRlt8RajpYDs20jf1E2I82ySPElUln3j9h0X8s7c1sw+iaSfELs2yMvuRKDFZx8bXR9Un0K/VBB6biraI2sqqO/XxpRgvIb9saSC3U=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by MW4PR12MB7382.namprd12.prod.outlook.com (2603:10b6:303:222::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 03:21:20 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 03:21:19 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liu, Leo" <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN
 idle work
Thread-Topic: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN
 idle work
Thread-Index: AQHdYslcjS+yR+4CnEuU71r/+OG9ArcLux6AgAOymdCAAHoggIABdj2wgAAqbYCAAMIxsIAA1OwAgACuhtA=
Date: Thu, 29 Oct 2026 03:21:19 +0000
Message-ID: <PH7PR12MB600089E49532E5B932948879FB6E2@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
 <20261023083422.3049246-5-Prike.Liang@amd.com>
 <CY8PR12MB7435B329FCC59091483D66E4E5642@CY8PR12MB7435.namprd12.prod.outlook.com>
 <PH7PR12MB6000E8F8FD01623634E3EF18FB612@PH7PR12MB6000.namprd12.prod.outlook.com>
 <MW6PR12MB70724A38A2BFAAC16324E233E5612@MW6PR12MB7072.namprd12.prod.outlook.com>
 <PH7PR12MB6000F0BEA1BEC025F02E5E2CFB602@PH7PR12MB6000.namprd12.prod.outlook.com>
 <MW6PR12MB707276D3E59DEE221733930EE5602@MW6PR12MB7072.namprd12.prod.outlook.com>
 <PH7PR12MB60008FA62BBB45916BF2BC5BFB6F2@PH7PR12MB6000.namprd12.prod.outlook.com>
 <MW6PR12MB7072E3EE2ADA969ADA7C456BE56F2@MW6PR12MB7072.namprd12.prod.outlook.com>
In-Reply-To: <MW6PR12MB7072E3EE2ADA969ADA7C456BE56F2@MW6PR12MB7072.namprd12.prod.outlook.com>
Accept-Language: en-US
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
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|MW4PR12MB7382:EE_
x-ms-office365-filtering-correlation-id: 1dd02606-47f4-4c8e-1b9d-08df356bb333
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|260925021911599003|260925021311599003|261026140227099003|260925022911599003|38070700021|4143699003|11063799006|56012099006|5023799004|261009221227099003|261009223327099003|261022075727099003|261009220027099003|261009221727099003|10067099003|261009223027099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003|261026121527099003|6133799003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: JHUYup/l9UALtNHxUzHFmHWHYghJbGYsOwdw6kmEERkFZyDJKRGAYK9nRTKo0prYU/KRX1PcuFwK6aMjRT0qcw0VcDx2Y/6yT8zbEw1obCqY/2XJ9xRtKXIuEMphESQ6zTXPf7n3W44Vsx+by26I1zacEJsUh/9E2NU5ceZQNSo84aKwfZFixDCZnyn28UC95QudlRasgFYu/hnr6QoSuD+WWi7XVq+fGx030kB04BSyuBrIxcU1CZVTpKRqSYddP+RGy6B7S111hmCH/Pn0EphOS3/KBQes4/YnnfMXB4+8R0fsuPdWGGDxsgaN6kjA/qjOmLAOecqKhVUdpfTeTq8I7LX9mst/uwl+c0tgC1SVbGIPArO6oIfjhgFyqcx7E2lMgW4kMTr6x1D/asAcutSPpfENREqrzB349tm9sqjbcBapZIZI0Y2h9q5rsioX9MeN/enslsYnaaXJ0C6GcK0kyiyV5suSqHIRAT3ofBl9fxDuaalepBJ5LHgpcFeHKYhvWT9gTT/ZOdglQao75CATONA+7aMEywCLBHlOQ7JfuxM/BRb2/9HOXyNLysPWX+7qkuzbXXttTgPHDSIgtutuBmfMvYBfGOAQbBhTStiBeHiun5vwlQ5OOuJ4BtnOpVbHTfdzGyplqJ3FEhmv6OixYpj2eqfWrSqS9at5yFc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(260925021911599003)(260925021311599003)(261026140227099003)(260925022911599003)(38070700021)(4143699003)(11063799006)(56012099006)(5023799004)(261009221227099003)(261009223327099003)(261022075727099003)(261009220027099003)(261009221727099003)(10067099003)(261009223027099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026121527099003)(6133799003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C+jAZ3FIRtNd5Whl8Yg5BkNpb8IoPLr9xDWd3erbQ7inimfp5Gg9k4DQ7HNv?=
 =?us-ascii?Q?lPDJV8ORcPEmd18UxOyRdnbFFaOup9KJZ1IABvbpJ1jD4ZXNINObceBmefTM?=
 =?us-ascii?Q?YZvaBqzQo7yfmjcAn1y4orDsMSSOD2r4rbmGUUX+4QCvjaydjU2/LVieNX1v?=
 =?us-ascii?Q?W+oINjR/i78WASGPgtzWkcG5H9xfZJygyoykh/J91iIWaGwzXVQRxiblo8HT?=
 =?us-ascii?Q?6lPxALwM6+/cO4C4xleNxz2qXhp296karBtTaOWroc0spPLCptrclthSWCaP?=
 =?us-ascii?Q?f/GIWFWOTugJzQRwcLCfczsI52sGBnDZRHvkxa0Z8X4RJG7OGMtg4nlvfmsB?=
 =?us-ascii?Q?Rr0s6sknmwKpYZXmzd2l/knKqaKX26cFg5nrpy92T6MKxwsInXf5z1Gwon/u?=
 =?us-ascii?Q?6OuEvfXmnhvmokwjkz/bcRDSdilq5MJ+NmfJJxP4txXGeuF6BnA8CXR1M89W?=
 =?us-ascii?Q?XfvLpqVQ7jIHDOcB8Y+tLBpD2LgGyzIICQwx8qgSSshXYsUNzg3aLX2zmvYc?=
 =?us-ascii?Q?6aaR2F13zzeyQetehGGUAx5qAy8kmp5ZeDOyIlxch3EzW3ViWVWrVj5lwREN?=
 =?us-ascii?Q?eYt4eMYHc4khh8/KJ1CranCnnJfMC873aRKgVmrtZNnsSFuQOcDzwpjX598s?=
 =?us-ascii?Q?K1Mviinhi+/7bZGoSHoj0k5gOxwcf8XQUJzJWe+AUvwIw8wPHnIPcX5QAAYy?=
 =?us-ascii?Q?gaq+gaSOUUWWv0azWmtSAou5PeB+o0KNNncH89LDL7MV61AiO9vU1pJRMi+G?=
 =?us-ascii?Q?lB2WpY7ZpAvi6MNeuKaFkGSHKFM6mS7P9uJ+1F1wvr/JeEjdByQH0qYQgBmO?=
 =?us-ascii?Q?M0D06lFBzkKI1c0HuzkFJyAOrtXQblVrGRTFA23zS64XBUuqF6t/XUKAdmDy?=
 =?us-ascii?Q?dXK2e/KHTKQ1n8OPDsIttwN3AorB3EFRsn9s8QbpBYgbqsb9MbpQm6Di8RIm?=
 =?us-ascii?Q?fr59Nyml+VwodQsH0MUfIk8jww/cI4FFevrfFXOEbZlktiZ+P2jKs2kbkHYo?=
 =?us-ascii?Q?sO+OrQXwDAO6EqYECJBf4dCatz0SWbzvSbGaPillwgUiZC9aC/dFlK3eWa+J?=
 =?us-ascii?Q?m+ohUPGGCy17zREjJfjqRsqEtbKZTrGZav8EIqLY9xKA9DyK8xPfR9kBcdHw?=
 =?us-ascii?Q?XkQZJCgtq81AJH9R41e7j5slkuUVSx2KR9f8f1rEK2SU7/3D0lqvMrcRK3c/?=
 =?us-ascii?Q?yeeJnXVQOyCiLh0/snlayzmjaEu1866qjtiHswsX8q/0NG5+r1Ic1suxxPF6?=
 =?us-ascii?Q?WetoToPJ2+JxaDxpluK2yMJQT0hTobl26eXyf9FWDVLxeGhum0LbF0aXaBEU?=
 =?us-ascii?Q?hP4Wzg2N7qjiXEfkNyji944SJ6xJ7NfFSaQD+Qie3l3sY5PcuJJorrFHb6NO?=
 =?us-ascii?Q?ZwwovN7n7PZx6CSGRcA9IwkvnTyKHj/f+vUAeXjlpqel/C3Z6QZyp+JtZRM+?=
 =?us-ascii?Q?dparvnucXkabIyr3FQFd2r602M0sPQOAwsW9ZICxruP9QNEalJI0+y560FMo?=
 =?us-ascii?Q?/8iCDIPNmNbhomNi+PGDWeXZ9AXlEkBLR2pOvWgcbwtCCprGtfMOLIXIc5a0?=
 =?us-ascii?Q?7SHB5Xs6wchNIvOiuAkE4+JssZxW+IcP5Crw7q6grc2lyTuLOvxtJD/dYRDs?=
 =?us-ascii?Q?i3sB80tatH6T+BwZG4tNKp95nCr7+eMm7YkL++4Lp2C5xEqi4xUG9JFFR96V?=
 =?us-ascii?Q?h8RtKIkPAUDVHeJZejbyUuLGDwTusnzqhAkJLisQH5EnB1eT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd02606-47f4-4c8e-1b9d-08df356bb333
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 03:21:19.3827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9V6QrlwGKfPMaD2FJC52MJ6qA1baY+lDc2J2RbcB6sO1H9tJOd3hQzDkTZ0/XB/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7382
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Regards,
      Prike

> -----Original Message-----
> From: Liu, Leo <Leo.Liu@amd.com>
> Sent: Wednesday, October 28, 2026 11:40 PM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
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
> > -----Original Message-----
> > From: Liang, Prike <Prike.Liang@amd.com>
> > Sent: Tuesday, October 27, 2026 11:28 PM
> > To: Liu, Leo <Leo.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Prosyak,
> > Vitaly <Vitaly.Prosyak@amd.com>
> > Subject: RE: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the
> > JPEG/VCN idle work
> >
> > AMD General
> >
> > Regards,
> >       Prike
> >
> > > -----Original Message-----
> > > From: Liu, Leo <Leo.Liu@amd.com>
> > > Sent: Tuesday, October 27, 2026 11:23 PM
> > > To: Liang, Prike <Prike.Liang@amd.com>;
> > > amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > Christian <Christian.Koenig@amd.com>; Lazar, Lijo
> > > <Lijo.Lazar@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
> > > Subject: RE: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the
> > > JPEG/VCN idle work
> > >
> > > AMD General
> > >
> > > > -----Original Message-----
> > > > From: Liang, Prike <Prike.Liang@amd.com>
> > > > Sent: Tuesday, October 27, 2026 9:20 AM
> > > > To: Liu, Leo <Leo.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > Christian <Christian.Koenig@amd.com>; Lazar, Lijo
> > > > <Lijo.Lazar@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
> > > > Subject: RE: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for
> > > > the JPEG/VCN idle work
> > > >
> > > > AMD General
> > > >
> > > > Regards,
> > > >       Prike
> > > >
> > > > > -----Original Message-----
> > > > > From: Liu, Leo <Leo.Liu@amd.com>
> > > > > Sent: Monday, October 26, 2026 10:32 PM
> > > > > To: Liang, Prike <Prike.Liang@amd.com>;
> > > > > amd-gfx@lists.freedesktop.org
> > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > > Christian <Christian.Koenig@amd.com>; Lazar, Lijo
> > > > > <Lijo.Lazar@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
> > > > > Subject: RE: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for
> > > > > the JPEG/VCN idle work
> > > > >
> > > > > AMD General
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Liang, Prike <Prike.Liang@amd.com>
> > > > > > Sent: Monday, October 26, 2026 5:04 AM
> > > > > > To: Liu, Leo <Leo.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> > > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > > > Christian <Christian.Koenig@amd.com>; Lazar, Lijo
> > > > > > <Lijo.Lazar@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
> > > > > > Subject: RE: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait
> > > > > > for the JPEG/VCN idle work
> > > > > >
> > > > > > AMD General
> > > > > >
> > > > > > Regards,
> > > > > >       Prike
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Liu, Leo <Leo.Liu@amd.com>
> > > > > > > Sent: Saturday, October 24, 2026 6:47 AM
> > > > > > > To: Liang, Prike <Prike.Liang@amd.com>;
> > > > > > > amd-gfx@lists.freedesktop.org
> > > > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > > > > Christian <Christian.Koenig@amd.com>; Lazar, Lijo
> > > > > > > <Lijo.Lazar@amd.com>; Prosyak, Vitaly
> > > > > > > <Vitaly.Prosyak@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> > > > > > > Subject: RE: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait
> > > > > > > for the JPEG/VCN idle work
> > > > > > >
> > > > > > > AMD General
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On
> > > > > > > > Behalf Of Prike Liang
> > > > > > > > Sent: Friday, October 23, 2026 4:34 AM
> > > > > > > > To: amd-gfx@lists.freedesktop.org
> > > > > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
> > > > > > > > Koenig, Christian <Christian.Koenig@amd.com>; Lazar, Lijo
> > > > > > > > <Lijo.Lazar@amd.com>; Prosyak, Vitaly
> > > > > > > > <Vitaly.Prosyak@amd.com>; Liang, Prike
> > > > > > > > <Prike.Liang@amd.com>
> > > > > > > > Subject: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait
> > > > > > > > for the JPEG/VCN idle work
> > > > > > > >
> > > > > > > > The common JPEG and VCN idle workers program power gating
> > > > > > > > and DPG pause, so they must not run while a GPU reset is in
> progress.
> > > > > > > > Recovery must not wait for them either, since everything
> > > > > > > > the workers depend on then becomes a dependency of GPU reco=
very.
> > > > > > > >
> > > > > > > > Make the workers take reset_domain->sem for read, so they
> > > > > > > > wait for a running reset instead of touching the hardware.
> > > > > > > > hw_fini/suspend and begin_use, the latter for the IB
> > > > > > > > tests, run from GPU recovery as well, so only skip waiting
> > > > > > > > for the idle work when the
> > > > reset itself calls them.
> > > > > > > > The reset holds the semaphore for write and would
> > > > > > > > otherwise deadlock on a worker blocked on it. Outside a
> > > > > > > > reset the cancel stays synchronous as before. sw_fini
> > > > > > > > always cancels synchronously, it never runs with the reset =
semaphore
> held.
> > > > > > > >
> > > > > > > > Update versions: https://lore.kernel.org/amd-
> > > > > > > > gfx/PH7PR12MB6000698A62D208E47BB358D7FB662@
> > > > > > > > PH7PR12MB6000.namprd12.prod.outlook.com/
> > > > > > > >
> > > > > > > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > > > > > > ---
> > > > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 20
> > > > > > > > ++++++++++++++++++--
> > drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > > > > > > ++++++++++++++++++|
> > > > > > > > ++++++++++++++++++18
> > > > > > > > +++++++++++++++++- drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > > > > > > +++++++++++++++++|
> > > > > > > > +++++++++++++++++1
> > > > > > > > ++++++++++++++++++
> > > > > > > >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
> > > > > > > >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 +-
> > > > > > > >  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 +-
> > > > > > > >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 +-
> > > > > > > >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  2 +-
> > > > > > > > drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  2 +-
> > > > > > > > drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
> > > > > > > > drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 +-
> > > > > > > > drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  2 +-
> > > > > > > > drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  2 +-
> > > > > > > >  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  4 ++--
> > > > > > > >  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  2 +-
> > > > > > > >  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  4 ++--
> > > > > > > >  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  2 +-
> > > > > > > >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 +-
> > > > > > > >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  2 +-
> > > > > > > > drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  2 +-
> > > > > > > > drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  2 +-
> > > > > > > > drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  2 +-
> > > > > > > > drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  2 +-
> > > > > > > >  23 files changed, 58 insertions(+), 25 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > > > > > > > index 87f879a2e4f4..2bddef322870 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > > > > > > > @@ -74,6 +74,8 @@ int amdgpu_jpeg_sw_fini(struct
> > > > > > > > amdgpu_device
> > > > > > > > *adev) {
> > > > > > > >       int i, j;
> > > > > > > >
> > > > > > > > +     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > > +
> > > > > > >
> > > > > > > I think this is redundant when hw_fini() ran normally,  they
> > > > > > > are only needed when
> > > > > > > hw_fini() was skipped - i.e. when hw_init() failed and
> > > > > > > status.hw was never
> > > > set.
> > > > > > > Also, UVD and VCE should be covered as well.
> > > > > >
> > > > > > Yeah, this change is aimed at the cases where the idle work
> > > > > > isn't cancelled synchronously before sw_fini(): hw_fini() was s=
kipped (e.g.
> > > > > > hw_init() failed), or the suspend/hw_fini path only did the
> > > > > > non-waiting cancel because it ran during a reset. If the idle
> > > > > > work was already cancelled synchronously before sw_fini(), the
> > > > > > extra
> > > > > cancel_delayed_work_sync() is harmless and just returns.
> > > > > >
> > > > >
> > > > > The problem is that calling cancel worker in sw_fini arrives too
> > > > > late, the idle work is scheduled ~1 second into the future.
> > > > > The fini_early/fini teardown sequence runs in that same window,
> > > > > tearing down other IP blocks that VCN depends on (MMHUB, SMU).
> > > > > The right place to cancel is in hw_init()'s error path,
> > > > > immediately before returning the error, while other IPs is still
> > > > > alive, and close time window which
> > > > could lead to problems.
> > > >
> > > > Yes, I'll add a separate patch that cancels synchronously the idle
> > > > work in the hw_init error paths, so the worker can't run after a fa=
iled hw_init.
> > > >
> > > > I'd like to keep the synchronous cancel in sw_fini, though. It
> > > > covers the case where hw_fini doesn't wait for a worker that's
> > > > already running, which happens when a peer in the same XGMI hive
> > > > is
> > resetting.
> > > > The cancel makes sure that worker finishes before its state is free=
d.
> > >
> > > That is a race condition, and the cancel doesn't fix the root cause,
> > > The preferred fix should make hw_fini properly so it always
> > > guarantees the handler is done, removing the need for anything in sw_=
fini.
> >
> > OK, got it. For the XGMI hive case, where hw_fini doesn't wait for the
> > idle work while a peer is resetting, I'll move the synchronous cancel
> > to early_fini(). It runs only on teardown, before any hw_fini. I'll als=
o drop the cancel
> from sw_fini.
> >
> However it still leaves a time window between the ring test failure and w=
hen
> early_fini is eventually reached, during which the idle workers can fire =
on broken
> hardware or race with other IP blocks in transitional states. The only pl=
ace that
> eliminates the window entirely is hw_init()'s error path itself.

> More importantly, it seems to me that early_fini is only called from
> amdgpu_device_fini_hw() - the driver unload path. It has no presence in
> amdgpu_device_gpu_recover(), if that is true, does it affect your case?

Yes, most of those cases are covered by cancelling synchronously the idle w=
ork in the hw_init error path. The one left is a device being unloaded whil=
e a peer in its XGMI hive is being reset. The hive shares one reset domain,=
 so in that case hw_fini doesn't wait for the idle work. hw_fini is skipped=
 entirely if the peer's reset has already suspended the device. Cancelling =
the idle work synchronously in early_fini covers this, since early_fini onl=
y runs on teardown and before any hw_fini. That cancel only holds up the un=
load, at most until the peer's reset finishes, so recovery still never wait=
s for the worker.

Meanwhile, I see you've already handled the hw_init error path, so I'll dro=
p my local fix for it and focus on the GPU recovery side. I'll update the p=
atch as follows:
1)  Don't cancel the idle work synchronously on the GPU reset path.
2)  Cancel the idle work synchronously in early_fini, to cover a device bei=
ng unloaded while a peer in its XGMI hive is being reset.

Thanks,
Prike

> Thanks,
> Leo
>
>
> > > At least, if keeping something in sw_fini, you need to make it
> > > conditional - only when hw_fini actually left a handler running.
> >
> > Yes, a flag set when hw_fini skips waiting would let sw_fini cancel
> > only in that case. But the worker could still run while the hardware
> > is being torn down. So I'll move the synchronous cancel to
> > early_fini(), before any hw_fini, and drop it from sw_fini.
> >
> > Thanks,
> > Prike
> >
> > > Thanks,
> > > Leo
> > >
> > > >
> > > > There's still a related timing issue in the hive reset case: the
> > > > worker can run after VCN and SMU have been torn down. I'll handle
> > > > that separately, I want to keep this series focused on GPU recovery=
 first.
> > > >
> > > > Regards,
> > > > Prike
> > > >
> > > >
> > > > > Thanks,
> > > > > Leo
> > > > >
> > > > > > If there are no other objections, I'll submit this fix upstream=
 later.
> > > > > >
> > > > > > Meanwhile, could someone help review patches 3 and 4? They
> > > > > > remove the VCN/JPEG memory allocations, which can trigger
> > > > > > reclaim, from the GPU recovery path.
> > > > > >
> > > > > > Thanks,
> > > > > > Prike
> > > > > >
> > > > > > > Thanks,
> > > > > > > Leo
> > > > > > >
> > > > > > > >       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> > > > > > > >               if (adev->jpeg.harvest_config & (1U << i))
> > > > > > > >                       continue; @@ -95,9 +97,18 @@ int
> > > > > > > > amdgpu_jpeg_sw_fini(struct amdgpu_device
> > > > > > *adev)
> > > > > > > >       return 0;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static void amdgpu_jpeg_cancel_idle_work(struct
> > > > > > > > +amdgpu_device
> > > > > > > > +*adev) {
> > > > > > > > +     /* The reset mustn't wait for the idle work, which
> > > > > > > > +waits for the reset
> > > > */
> > > > > > > > +     if (amdgpu_in_reset(adev))
> > > > > > > > +             cancel_delayed_work(&adev->jpeg.idle_work);
> > > > > > > > +     else
> > > > > > > > +
> > > > > > > > +cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  int amdgpu_jpeg_suspend(struct amdgpu_device *adev)  {
> > > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > > +     amdgpu_jpeg_cancel_idle_work(adev);
> > > > > > > >
> > > > > > > >       return 0;
> > > > > > > >  }
> > > > > > > > @@ -114,6 +125,9 @@ static void
> > > > > > > > amdgpu_jpeg_idle_work_handler(struct
> > > > > > > > work_struct *work)
> > > > > > > >       unsigned int fences =3D 0;
> > > > > > > >       unsigned int i, j;
> > > > > > > >
> > > > > > > > +     /* Nothing holding the reset semaphore waits for this=
 work */
> > > > > > > > +     down_read(&adev->reset_domain->sem);
> > > > > > > > +
> > > > > > > >       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> > > > > > > >               if (adev->jpeg.harvest_config & (1U << i))
> > > > > > > >                       continue; @@ -129,6 +143,8 @@ static
> > > > > > > > void amdgpu_jpeg_idle_work_handler(struct
> > > > > > > > work_struct *work)
> > > > > > > >               mutex_unlock(&adev->jpeg.jpeg_pg_lock);
> > > > > > > >       } else
> > > > > > > >               schedule_delayed_work(&adev->jpeg.idle_work,
> > > > > > > > JPEG_IDLE_TIMEOUT);
> > > > > > > > +
> > > > > > > > +     up_read(&adev->reset_domain->sem);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
> > > > > > > > @@
> > > > > > > > -136,7
> > > > > > > > +152,7 @@ void amdgpu_jpeg_ring_begin_use(struct
> > > > > > > > +amdgpu_ring
> > > > > > > > *ring)
> > > > > > > >       struct amdgpu_device *adev =3D ring->adev;
> > > > > > > >
> > > > > > > >       if (!atomic_fetch_inc(&adev->jpeg.total_submission_cn=
t))
> > > > > > > > -             cancel_delayed_work_sync(&adev->jpeg.idle_wor=
k);
> > > > > > > > +             amdgpu_jpeg_cancel_idle_work(adev);
> > > > > > > >
> > > > > > > >       mutex_lock(&adev->jpeg.jpeg_pg_lock);
> > > > > > > >       amdgpu_device_ip_set_powergating_state(adev,
> > > > > > > > AMD_IP_BLOCK_TYPE_JPEG,
> > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > > > > > > index 34e1242d66ea..631f9471be1f 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > > > > > > @@ -269,6 +269,8 @@ void amdgpu_vcn_sw_fini(struct
> > > > > > > > amdgpu_device *adev, int i)
> > > > > > > >       if (adev->vcn.harvest_config & (1 << i))
> > > > > > > >               return;
> > > > > > > >
> > > > > > > > +
> > > > > > > > + cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> > > > > > > > +
> > > > > > > >       amdgpu_bo_free_kernel(
> > > > > > > >               &adev->vcn.inst[i].dpg_sram_bo,
> > > > > > > >               &adev->vcn.inst[i].dpg_sram_gpu_addr,
> > > > > > > > @@ -459,6 +461,15 @@ void amdgpu_vcn_put_profile(struct
> > > > > > > > amdgpu_device
> > > > > > > > *adev)
> > > > > > > >       mutex_unlock(&adev->vcn.workload_profile_mutex);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst
> > > > > > > > +*vcn_inst) {
> > > > > > > > +     /* The reset mustn't wait for the idle work, which
> > > > > > > > +waits for the reset
> > > > */
> > > > > > > > +     if (amdgpu_in_reset(vcn_inst->adev))
> > > > > > > > +             cancel_delayed_work(&vcn_inst->idle_work);
> > > > > > > > +     else
> > > > > > > > +
> > > > > > > > +cancel_delayed_work_sync(&vcn_inst->idle_work);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static void amdgpu_vcn_idle_work_handler(struct
> > > > > > > > work_struct
> > > > > > > > *work) {
> > > > > > > >       struct amdgpu_vcn_inst *vcn_inst =3D @@ -470,6 +481,9
> > > > > > > > @@ static void amdgpu_vcn_idle_work_handler(struct
> > > > > > > > work_struct *work)
> > > > > > > >       if (adev->vcn.harvest_config & (1 << i))
> > > > > > > >               return;
> > > > > > > >
> > > > > > > > +     /* Nothing holding the reset semaphore waits for this=
 work */
> > > > > > > > +     down_read(&adev->reset_domain->sem);
> > > > > > > > +
> > > > > > > >       for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; ++=
j)
> > > > > > > >               fence[i] +=3D
> > > > > > > > amdgpu_fence_count_emitted(&vcn_inst-
> > > > > > > > >ring_enc[j]);
> > > > > > > >
> > > > > > > > @@ -499,6 +513,8 @@ static void
> > > > > > > > amdgpu_vcn_idle_work_handler(struct
> > > > > > > > work_struct *work)
> > > > > > > >       } else {
> > > > > > > >               schedule_delayed_work(&vcn_inst->idle_work,
> > > > > > > > VCN_IDLE_TIMEOUT);
> > > > > > > >       }
> > > > > > > > +
> > > > > > > > +     up_read(&adev->reset_domain->sem);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
> > > > > > > > @@
> > > > > > > > -507,7
> > > > > > > > +523,7 @@ void amdgpu_vcn_ring_begin_use(struct
> > > > > > > > +amdgpu_ring
> > > > > > > > *ring)
> > > > > > > >       struct amdgpu_vcn_inst *vcn_inst =3D
> > > > > > > > &adev->vcn.inst[ring->me];
> > > > > > > >
> > > > > > > >       if (!atomic_fetch_inc(&vcn_inst->total_submission_cnt=
))
> > > > > > > > -             cancel_delayed_work_sync(&vcn_inst->idle_work=
);
> > > > > > > > +             amdgpu_vcn_cancel_idle_work(vcn_inst);
> > > > > > > >
> > > > > > > >       mutex_lock(&vcn_inst->vcn_pg_lock);
> > > > > > > >       vcn_inst->set_pg_state(vcn_inst,
> > > > > > > > AMD_PG_STATE_UNGATE); diff --git
> > > > > > > > a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > > > > > > index bea95307fd42..a6438950854e 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > > > > > > @@ -526,6 +526,7 @@ int amdgpu_vcn_suspend(struct
> > > > > > > > amdgpu_device *adev, int i);  int amdgpu_vcn_resume(struct
> > > > > > > > amdgpu_device *adev, int i);  void
> > > > > > > > amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring); void
> > > > > > > > amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
> > > > > > > > +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst
> > > > > > > > +*vcn_inst);
> > > > > > > >
> > > > > > > >  bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev=
,
> > > > > > > >                               enum vcn_ring_type type,
> > > > > > > > uint32_t vcn_instance); diff --git
> > > > > > > > a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > > > > > > index 72069b77f6f1..b048fd4b8b59 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > > > > > > @@ -177,7 +177,7 @@ static int jpeg_v2_0_hw_fini(struct
> > > > > > > > amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > >  {
> > > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > > >
> > > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > > +     amdgpu_jpeg_suspend(adev);
> > > > > > > >
> > > > > > > >       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> > > > > > > >             RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS)) diff
> > > > > > > > --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > > > > > > > index 2968256d4cd7..f6a9258ae3ca 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > > > > > > > @@ -239,7 +239,7 @@ static int jpeg_v2_5_hw_fini(struct
> > > > > > > > amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > > >       int i;
> > > > > > > >
> > > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > > +     amdgpu_jpeg_suspend(adev);
> > > > > > > >
> > > > > > > >       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> > > > > > > >               if (adev->jpeg.harvest_config & (1 << i))
> > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > > > > > > index 564e40899df2..922711aa06a3 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > > > > > > @@ -192,7 +192,7 @@ static int jpeg_v3_0_hw_fini(struct
> > > > > > > > amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > >  {
> > > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > > >
> > > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > > +     amdgpu_jpeg_suspend(adev);
> > > > > > > >
> > > > > > > >       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> > > > > > > >             RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS)) diff
> > > > > > > > --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > > > > > > > index b29ca3a49939..fe7ab9cb35bb 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > > > > > > > @@ -221,7 +221,7 @@ static int jpeg_v4_0_hw_fini(struct
> > > > > > > > amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > >  {
> > > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > > >
> > > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > > +     amdgpu_jpeg_suspend(adev);
> > > > > > > >       if (!amdgpu_sriov_vf(adev)) {
> > > > > > > >               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GA=
TE &&
> > > > > > > >                       RREG32_SOC15(JPEG, 0,
> > > > > > > > regUVD_JRBC_STATUS)) diff --git
> > > > > > > > a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > > > > > > > index 0343a64595f2..f4896ad9d1de 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > > > > > > > @@ -455,7 +455,7 @@ static int jpeg_v4_0_3_hw_fini(struct
> > > > > > > > amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > > >       int ret =3D 0;
> > > > > > > >
> > > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > > +     amdgpu_jpeg_suspend(adev);
> > > > > > > >
> > > > > > > >       if (!amdgpu_sriov_vf(adev)) {
> > > > > > > >               if (adev->jpeg.cur_state !=3D
> > > > > > > > AMD_PG_STATE_GATE) diff --git
> > > > > > > > a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> > > > > > > > index 4da3f9c995c1..87efc3c2b9e0 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> > > > > > > > @@ -250,7 +250,7 @@ static int jpeg_v4_0_5_hw_fini(struct
> > > > > > > > amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > > >       int i;
> > > > > > > >
> > > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > > +     amdgpu_jpeg_suspend(adev);
> > > > > > > >
> > > > > > > >       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> > > > > > > >               if (adev->jpeg.harvest_config & (1 << i))
> > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > > > > > > > index dcdb089b4308..91968ad26f17 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > > > > > > > @@ -189,7 +189,7 @@ static int jpeg_v5_0_0_hw_fini(struct
> > > > > > > > amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > >  {
> > > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > > >
> > > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > > +     amdgpu_jpeg_suspend(adev);
> > > > > > > >
> > > > > > > >       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> > > > > > > >             RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > > > > > > > index f2debf6b6bd0..27116d1e9e64 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > > > > > > > @@ -326,7 +326,7 @@ static int jpeg_v5_0_1_hw_fini(struct
> > > > > > > > amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > > >       int ret =3D 0;
> > > > > > > >
> > > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > > +     amdgpu_jpeg_suspend(adev);
> > > > > > > >
> > > > > > > >       if (!amdgpu_sriov_vf(adev)) {
> > > > > > > >               if (adev->jpeg.cur_state !=3D
> > > > > > > > AMD_PG_STATE_GATE) diff --git
> > > > > > > > a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> > > > > > > > index dd0abce73687..7e068c2d4d6d 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> > > > > > > > @@ -299,7 +299,7 @@ static int jpeg_v5_0_2_hw_fini(struct
> > > > > > > > amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > > >       int ret =3D 0;
> > > > > > > >
> > > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > > +     amdgpu_jpeg_suspend(adev);
> > > > > > > >
> > > > > > > >       if (!amdgpu_sriov_vf(adev)) {
> > > > > > > >               if (adev->jpeg.cur_state !=3D
> > > > > > > > AMD_PG_STATE_GATE) diff --git
> > > > > > > > a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > > > > > > > index 8ddd12740a04..16daeb61114c 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > > > > > > > @@ -172,7 +172,7 @@ static int jpeg_v5_3_0_hw_fini(struct
> > > > > > > > amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > >  {
> > > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > > >
> > > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > > +     amdgpu_jpeg_suspend(adev);
> > > > > > > >
> > > > > > > >       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> > > > > > > >             RREG32_SOC15(JPEG, 0,
> > > > > > > > regUVD_JRBC0_UVD_JRBC_STATUS)) diff --git
> > > > > > > > a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > > > index 76793a5caa70..470d8f110799 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > > > @@ -150,8 +150,8 @@ static int vcn_v1_0_sw_init(struct
> > > > > > > > amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > >       if (r)
> > > > > > > >               return r;
> > > > > > > >
> > > > > > > > -     /* Override the work func */
> > > > > > > > -     adev->vcn.inst[0].idle_work.work.func =3D
> > > > vcn_v1_0_idle_work_handler;
> > > > > > > > +     /* Own lockdep class, this work is still cancelled sy=
nchronously */
> > > > > > > > +     INIT_DELAYED_WORK(&adev->vcn.inst[0].idle_work,
> > > > > > > > vcn_v1_0_idle_work_handler);
> > > > > > > >
> > > > > > > >       amdgpu_vcn_setup_ucode(adev, 0);
> > > > > > > >
> > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > > > > > > > index 7d2b9e4b913a..ba451f2a2534 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > > > > > > > @@ -322,7 +322,7 @@ static int vcn_v2_0_hw_fini(struct
> > > > > > > > amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > > >       struct amdgpu_vcn_inst *vinst =3D adev->vcn.inst;
> > > > > > > >
> > > > > > > > -     cancel_delayed_work_sync(&vinst->idle_work);
> > > > > > > > +     amdgpu_vcn_cancel_idle_work(vinst);
> > > > > > > >
> > > > > > > >       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> > > > > > > >           (vinst->cur_state !=3D AMD_PG_STATE_GATE && diff
> > > > > > > > --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > > > > > > > index 10ef5616b2f5..9dd4c313cbe7 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > > > > > > > @@ -304,8 +304,8 @@ static int vcn_v2_5_sw_init(struct
> > > > > > > > amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > >               if (r)
> > > > > > > >                       return r;
> > > > > > > >
> > > > > > > > -             /* Override the work func */
> > > > > > > > -             adev->vcn.inst[j].idle_work.work.func =3D
> > > > > > > > vcn_v2_5_idle_work_handler;
> > > > > > > > +             /* Own lockdep class, this work is still
> > > > > > > > + cancelled synchronously
> > > > > > > > */
> > > > > > > > +
> > > > > > > > + INIT_DELAYED_WORK(&adev->vcn.inst[j].idle_work,
> > > > > > > > vcn_v2_5_idle_work_handler);
> > > > > > > >
> > > > > > > >               amdgpu_vcn_setup_ucode(adev, j);
> > > > > > > >
> > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > > > > > > index 0f4f4d66e2e4..3e85abd1e82c 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > > > > > > @@ -449,7 +449,7 @@ static int vcn_v3_0_hw_fini(struct
> > > > > > > > amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > >               if (adev->vcn.harvest_config & (1 << i))
> > > > > > > >                       continue;
> > > > > > > >
> > > > > > > > -             cancel_delayed_work_sync(&vinst->idle_work);
> > > > > > > > +             amdgpu_vcn_cancel_idle_work(vinst);
> > > > > > > >
> > > > > > > >               if (!amdgpu_sriov_vf(adev)) {
> > > > > > > >                       if ((adev->pg_flags &
> > > > > > > > AMD_PG_SUPPORT_VCN_DPG)
> > > > > > > > || diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > > > > > > > index 4b7f7bbe18da..5b47a643d725 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > > > > > > > @@ -374,7 +374,7 @@ static int vcn_v4_0_hw_fini(struct
> > > > > > > > amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > >               if (adev->vcn.harvest_config & (1 << i))
> > > > > > > >                       continue;
> > > > > > > >
> > > > > > > > -             cancel_delayed_work_sync(&vinst->idle_work);
> > > > > > > > +             amdgpu_vcn_cancel_idle_work(vinst);
> > > > > > > >
> > > > > > > >               if (!amdgpu_sriov_vf(adev)) {
> > > > > > > >                       if ((adev->pg_flags &
> > > > > > > > AMD_PG_SUPPORT_VCN_DPG)
> > > > > > > > || diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > > > > > > index 3f39aa83c319..5aa09c3bd79b 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > > > > > > @@ -417,7 +417,7 @@ static int vcn_v4_0_3_hw_fini(struct
> > > > > > > > amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > >       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> > > > > > > >               struct amdgpu_vcn_inst *vinst =3D
> > > > > > > > &adev->vcn.inst[i];
> > > > > > > >
> > > > > > > > -             cancel_delayed_work_sync(&vinst->idle_work);
> > > > > > > > +             amdgpu_vcn_cancel_idle_work(vinst);
> > > > > > > >
> > > > > > > >               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
> > > > > > > >                       vinst->set_pg_state(vinst,
> > > > > > > > AMD_PG_STATE_GATE); diff --git
> > > > > > > > a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > > > > > > > index f30f80c1b07f..9693950cd16d 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > > > > > > > @@ -327,7 +327,7 @@ static int vcn_v4_0_5_hw_fini(struct
> > > > > > > > amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > >               if (adev->vcn.harvest_config & (1 << i))
> > > > > > > >                       continue;
> > > > > > > >
> > > > > > > > -             cancel_delayed_work_sync(&vinst->idle_work);
> > > > > > > > +             amdgpu_vcn_cancel_idle_work(vinst);
> > > > > > > >
> > > > > > > >               if (!amdgpu_sriov_vf(adev)) {
> > > > > > > >                       if ((adev->pg_flags &
> > > > > > > > AMD_PG_SUPPORT_VCN_DPG)
> > > > > > > > || diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > > > > > > > index 7b7c3bc9f046..0c189063a6ab 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > > > > > > > @@ -291,7 +291,7 @@ static int vcn_v5_0_0_hw_fini(struct
> > > > > > > > amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > >               if (adev->vcn.harvest_config & (1 << i))
> > > > > > > >                       continue;
> > > > > > > >
> > > > > > > > -             cancel_delayed_work_sync(&vinst->idle_work);
> > > > > > > > +             amdgpu_vcn_cancel_idle_work(vinst);
> > > > > > > >
> > > > > > > >               if (!amdgpu_sriov_vf(adev)) {
> > > > > > > >                       if ((adev->pg_flags &
> > > > > > > > AMD_PG_SUPPORT_VCN_DPG)
> > > > > > > > || diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > > > > > > > index c9e990ab297d..3fa553fb41d3 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > > > > > > > @@ -364,7 +364,7 @@ static int vcn_v5_0_1_hw_fini(struct
> > > > > > > > amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > >       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> > > > > > > >               struct amdgpu_vcn_inst *vinst =3D
> > > > > > > > &adev->vcn.inst[i];
> > > > > > > >
> > > > > > > > -             cancel_delayed_work_sync(&adev->vcn.inst[i].i=
dle_work);
> > > > > > > > +
> > > > > > > > + amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
> > > > > > > >               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
> > > > > > > >                       vinst->set_pg_state(vinst, AMD_PG_STA=
TE_GATE);
> > > > > > > >       }
> > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> > > > > > > > index ed47ddd5b08c..eb13f792e25d 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> > > > > > > > @@ -279,7 +279,7 @@ static int vcn_v5_0_2_hw_fini(struct
> > > > > > > > amdgpu_ip_block
> > > > > > > > *ip_block)
> > > > > > > >       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> > > > > > > >               struct amdgpu_vcn_inst *vinst =3D
> > > > > > > > &adev->vcn.inst[i];
> > > > > > > >
> > > > > > > > -             cancel_delayed_work_sync(&adev->vcn.inst[i].i=
dle_work);
> > > > > > > > +
> > > > > > > > + amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
> > > > > > > >               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
> > > > > > > >                       vinst->set_pg_state(vinst, AMD_PG_STA=
TE_GATE);
> > > > > > > >       }
> > > > > > > > --
> > > > > > > > 2.34.1
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>

