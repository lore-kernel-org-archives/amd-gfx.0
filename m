Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E74606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0bXiT3qG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7CEC10E25B;
	Mon, 26 Oct 2026 14:36:57 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013069.outbound.protection.outlook.com
 [40.107.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 831EE10E25B
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 14:36:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+LtfJw6WL7qj9wa0VKBo3KegX9EgX6a21KutJKuTpyWSL6nQPmMBbo24Apflw8fjkE2YVSjAtoYoiLsKEr0mQEVrjkOcTp03Vge18z1YwEX2U/rHAHPWMGJ+8+ktLWzni/JCyCienC5xzbWGVnUTPLhjVCdiFQ7sn1tKZhLswpdd7ALXqt6liuN+t7KjCvWXux2AsAN9UcwgBNSBToGBRzQ5gvenyQ+oh9434HdZpH7c8Pkf8LBqSNygOEuLlYX3VpWo9VgiAMGs5J0WsM4YcMSiSDkT8yfD5Dre73FR6B3/w5AR3eP7B72xt+36biRt5fEWOsen1VCZwx7bgGREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6K2NhdFG2k45pboz3Kj3IZ6WSt8NewR/Wv5exXbIWA=;
 b=fNepevYEI+EApFN6ChoQC+rjQ34FWf49B6fQ9/4PkS2qS4uSAqHlLdPzEi7i2QpOx+p4MTs3Dfhwyzq0YWYedRJAfPwpAcz++7R4ox/t4uXNEdIVBgCjXyCFadVtoX6hPZKCpHrODxCO4XoCnp86s3vwwizOsnffolNeJGXf9wEkTKJwrIL76IYfRSPvy0QtEfTzDKPZf12gAarZ7w449u/KuKiU9cG/bDwjQ8vpeKSwDiP246SKu2dfcXT/qaX//PgxmHcAPGk3wxZj3iY0vqMVvK3auDKYPJS+xHnEGI7ZaajO9g884Awn4BsPIfXgkE+UlGuj/SWsg+DiJ5IEMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6K2NhdFG2k45pboz3Kj3IZ6WSt8NewR/Wv5exXbIWA=;
 b=0bXiT3qGq5Qmv5XXywUtMZmtE3YLq9NAlgXfjfGohPeNq3ao8tSuOnHYIPrlB4gJGAJqoueGlD89LbdkF/F43PiPZIGdlctSXoJ9I4N1h/AP4HtsAaU7UOapR7q52XEsFQGRU0slqPPR5UMEvefwjC9d7uElb79GpMcLx6AOPsw=
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by DS0PR12MB999103.namprd12.prod.outlook.com (2603:10b6:8:2fe::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 14:36:48 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 14:36:48 +0000
From: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
To: "Liu, Leo" <Leo.Liu@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN
 idle work
Thread-Topic: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN
 idle work
Thread-Index: AQHdYslpjH78sR5Uu068I1HnJJzbwLcLux6AgAPRDYCAAFusgIAAAWXg
Date: Mon, 26 Oct 2026 14:36:47 +0000
Message-ID: <IA1PR12MB8517638062143E3C0974A004E3612@IA1PR12MB8517.namprd12.prod.outlook.com>
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
 <20261023083422.3049246-5-Prike.Liang@amd.com>
 <CY8PR12MB7435B329FCC59091483D66E4E5642@CY8PR12MB7435.namprd12.prod.outlook.com>
 <PH7PR12MB6000E8F8FD01623634E3EF18FB612@PH7PR12MB6000.namprd12.prod.outlook.com>
 <MW6PR12MB70724A38A2BFAAC16324E233E5612@MW6PR12MB7072.namprd12.prod.outlook.com>
In-Reply-To: <MW6PR12MB70724A38A2BFAAC16324E233E5612@MW6PR12MB7072.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: IA1PR12MB8517:EE_|DS0PR12MB999103:EE_
x-ms-office365-filtering-correlation-id: 02a44330-9447-4099-1576-08df336e90cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|261009220027099003|261009223327099003|261009223027099003|261009221227099003|261009221727099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|260925021311599003|260925022911599003|260925021911599003|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003|11063799006|4143699003|5023799004|38070700021;
x-microsoft-antispam-message-info: oJkyC5UpOYbNKIsYiur76q4lYTDYYovZet9jxwwroqEXm+8KBYbGUHMMfF+L5IFzUmBzSGbAYT1//FRdlXCSpvRDVEpQKSQ8Je0fhKkykgEih0ZDscjS0O1gWMeYKI1g40Bsl3Hnuo3+Flvtn7inPB3r2mtEO54/DxKMrKx18yLp+TeFQm2nfc2YwwSkZVUWaEEFY5d6wCwyxT80Ke1rOuCu75jiy18c1IYL9aD45fryJokCsYkLOLUYV5kA2XYt40kzoJ1pUqwpk3SA6xWwMPVxsajAyE6exNh+s7xIj89AsgWN29JYknJOQJJQkDjzXjuZNjAwvIAYExe5WBsaTUFcbVsKMGOo3yOcemCYT7GPvDC18WYcfJoDmx3B/Kfpsw7IuExzgJD/Tdqwqg/gLT2CK2iSTm4Awilk2I+fLfrV6EtVOd2VlGUnAk7UxNTP7TWpfgaugDCkyvjKNl09NS6apOLeZW0w955zteavBW8532qXqIkSPHiq8jZhBBG8RaWov0dFEVKz6KrzPZNzHcaBC6n+8fgS9fkRE2Nywvh6PDtwVNOcjofQ25TdRFQyrvDNKXOorMCJVIjeJl6vtVJjYxIJUvnzivSJfsltSg97eNEx+bdn8RhB/pfuH49bXhetLjJiplEmackwcvu5ou3TZ7bfBZ+skxKklXVVRSQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(261009220027099003)(261009223327099003)(261009223027099003)(261009221227099003)(261009221727099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(5023799004)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G7OiTBHEOo08ZXF9UIKQigJMgBU7i9Ubn5y1YM2MRcLwx7978xMyCe5v01XC?=
 =?us-ascii?Q?nJdqt55Q6OJtry3k9dcnTuq0C8/+LvOUVdDlHfLl8KazhIPFyhLh73DKcZkl?=
 =?us-ascii?Q?PoiFIyssdDhDn7yqNvxJv3hf8XRzoNJOTha358QI4+W6X/5zM8g1u+wWIoph?=
 =?us-ascii?Q?jY7wLwBb84zIlU5HBLniR8KI0/O/IwW+K8qQa1u5R+BHU4OMBJSkfE9629ra?=
 =?us-ascii?Q?nqVg4rsnoE07ou1MIBXXR0RIae5vIix79uhvQsUI6BytRFAvtFLebhRvHyWa?=
 =?us-ascii?Q?bX6iAujuwDT8KJTjViXF2A6vodf+2Emw782LgLL+gJERC7pSi54IZrK4r9Uv?=
 =?us-ascii?Q?dyk2cUOxFo4BWeNlbI1gjFOmvfXqZBzN0zPdEEaepzveZNKtl9mMCvrIwCpH?=
 =?us-ascii?Q?5HcbUbLYSKl2EeJZzfDZbjcfRyNIBQUA+Nfs3GJyUFv9hy4s12+IhF1+B6jV?=
 =?us-ascii?Q?QQfodp0mbRkFvBY8/kVmOMy2xMDzyYoz7Te44cQHVVhRpYyIBRTIm5uRBlhr?=
 =?us-ascii?Q?4mOnM3C/jQVtrLKNgolTUly1dHVGXLLXxEpToqceRo13p0cxWa+VeguvvpCB?=
 =?us-ascii?Q?nJnJmRZe5uDXjQimZ0E4OXmsUBSIxv3O6TZdQa/e9wkXsTkzGPrvUTZl17iF?=
 =?us-ascii?Q?MODiz0xYc9SFrOtHYNmWg/B5S6jNAxOKwRADiq7dLPVtuxUikEWs8aalOLhg?=
 =?us-ascii?Q?WaAk5DQVrV77X4NoG16hhrtwaV7VZ3+23tDyu2tSozt0+sfuG7meoSFcoSTb?=
 =?us-ascii?Q?amaAHzrLESgMfzI+jrNjkNStP7nzH1MUzODldq+No3V/UaJvZOJz4CCf0imP?=
 =?us-ascii?Q?9u0H5H2eTS65eQJ+3C/3up6yPOe7QpgypwHOaWZ+kYKiKj3Qg1rZ+gd7Bv6E?=
 =?us-ascii?Q?C82eEGucZO+ut5eAhLt0QCT/jg3z9cof66x6SJU6l2cfpwuK6fszf8sb2/F/?=
 =?us-ascii?Q?ZDasrmuJ9C9lZd1Wy3/WB1Rba+UMpupVBnC4TqPI3SxO6JULlOmRrfVOxgSe?=
 =?us-ascii?Q?ooPV7NL5wpjUuub234GmtLrkzuzJTRT9CvdrWNXu2ag8R2JPXQS34WMDox3s?=
 =?us-ascii?Q?3ET1bkt+QTJSO6UbPfg6Z7UAwkJ9oUtCDuCrmm0WdXvoKAA/4RG0vKRa1ocY?=
 =?us-ascii?Q?dUHS0dWZMwjzlm8L6FaSzv4Ze77x919nwvUX965DMlX5OWxJMQbwJiJ2KaPG?=
 =?us-ascii?Q?WPTPRFHu5qA2rPRoJ5RQUTBY3wDsd4XuTQcxiaXWbVTu2JCG4c12hOXH81YC?=
 =?us-ascii?Q?RjPim6WdcYkUaJMw/FN35Agc24gMcSRL3k4RSkwLMm9lXAlKEQvk5r8EqyL2?=
 =?us-ascii?Q?vta7jjOeAMIwhYzSEd1y3KREsXouEYuiEqr4zh8xnxcHF2ebxD8J8R+Sg0Kr?=
 =?us-ascii?Q?++12ZGNR0PO+JTp3X9XF1J3M5rsuzl8QcFSOlvD2Rrk7JvaJPhevq5ALdjP9?=
 =?us-ascii?Q?sFoC0Jnq+ueYBWx4HBgqMt4Y7V+6sE4iUscDtc286ZDIfXDZdH7HkOOIC22V?=
 =?us-ascii?Q?IG7MOFDKpa7pGGGacSJsA27Q/XCpsKoDwWorXhNwCyLRKIH6l6ofNCKqBcnh?=
 =?us-ascii?Q?06A0eLD6HJi/zAdRqKEP14A6/5rd1e+/foOk3COvIsaluvjiVcqjdvFOPCcM?=
 =?us-ascii?Q?QTC6edqO6GyeSpeXdAgRC9it295Cn2em5NzxYA4DzwQk50LGN2Dua4ftFBgz?=
 =?us-ascii?Q?eB2ChT2h33vMqgzvNPyQJrarFOE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a44330-9447-4099-1576-08df336e90cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 14:36:47.8487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ORXunYXttlqIK4e2YptLngsY0faCi+jclGYvOUGCAzoKHxQNdFMyCJwkNPaY3ait
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999103
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu, Leo
Sent: Monday, October 26, 2026 9:32 AM
To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Prosyak, Vitaly <V=
italy.Prosyak@amd.com>
Subject: RE: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the JPEG/VC=
N idle work

AMD General

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Monday, October 26, 2026 5:04 AM
> To: Liu, Leo <Leo.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Prosyak,
> Vitaly <Vitaly.Prosyak@amd.com>
> Subject: RE: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the
> JPEG/VCN idle work
>
> AMD General
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Liu, Leo <Leo.Liu@amd.com>
> > Sent: Saturday, October 24, 2026 6:47 AM
> > To: Liang, Prike <Prike.Liang@amd.com>;
> > amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > Christian <Christian.Koenig@amd.com>; Lazar, Lijo
> > <Lijo.Lazar@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>;
> > Liang, Prike <Prike.Liang@amd.com>
> > Subject: RE: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the
> > JPEG/VCN idle work
> >
> > AMD General
> >
> > > -----Original Message-----
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > Prike Liang
> > > Sent: Friday, October 23, 2026 4:34 AM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > Christian <Christian.Koenig@amd.com>; Lazar, Lijo
> > > <Lijo.Lazar@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>;
> > > Liang, Prike <Prike.Liang@amd.com>
> > > Subject: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the
> > > JPEG/VCN idle work
> > >
> > > The common JPEG and VCN idle workers program power gating and DPG
> > > pause, so they must not run while a GPU reset is in progress.
> > > Recovery must not wait for them either, since everything the
> > > workers depend on then becomes a dependency of GPU recovery.
> > >
> > > Make the workers take reset_domain->sem for read, so they wait for
> > > a running reset instead of touching the hardware. hw_fini/suspend
> > > and begin_use, the latter for the IB tests, run from GPU recovery
> > > as well, so only skip waiting for the idle work when the reset itself=
 calls them.
> > > The reset holds the semaphore for write and would otherwise
> > > deadlock on a worker blocked on it. Outside a reset the cancel
> > > stays synchronous as before. sw_fini always cancels synchronously,
> > > it never runs with the reset semaphore held.
> > >
> > > Update versions: https://lore.kernel.org/amd-
> > > gfx/PH7PR12MB6000698A62D208E47BB358D7FB662@
> > > PH7PR12MB6000.namprd12.prod.outlook.com/
> > >
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 20
> > > ++++++++++++++++++-- drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 18
> > > +++++++++++++++++- drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h  |  1 +
> > >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
> > >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 +-
> > >  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 +-
> > >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 +-
> > >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  2 +-
> > > drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  2 +-
> > > drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
> > > drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 +-
> > > drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  2 +-
> > > drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  2 +-
> > >  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  4 ++--
> > >  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  2 +-
> > >  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  4 ++--
> > >  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  2 +-
> > >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 +-
> > >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  2 +-
> > > drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  2 +-
> > > drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  2 +-
> > > drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  2 +-
> > > drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  2 +-
> > >  23 files changed, 58 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > > index 87f879a2e4f4..2bddef322870 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > > @@ -74,6 +74,8 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device
> > > *adev) {
> > >       int i, j;
> > >
> > > +     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > +
> >
> > I think this is redundant when hw_fini() ran normally,  they are
> > only needed when
> > hw_fini() was skipped - i.e. when hw_init() failed and status.hw was ne=
ver set.
> > Also, UVD and VCE should be covered as well.
>
> Yeah, this change is aimed at the cases where the idle work isn't
> cancelled synchronously before sw_fini(): hw_fini() was skipped (e.g.
> hw_init() failed), or the suspend/hw_fini path only did the
> non-waiting cancel because it ran during a reset. If the idle work was
> already cancelled synchronously before sw_fini(), the extra cancel_delaye=
d_work_sync() is harmless and just returns.
>

The problem is that calling cancel worker in sw_fini arrives too late, the =
idle work is scheduled ~1 second into the future.
The fini_early/fini teardown sequence runs in that same window, tearing dow=
n other IP blocks that VCN depends on (MMHUB, SMU). The right place to canc=
el is in hw_init()'s error path, immediately before returning the error, wh=
ile other IPs is still alive, and close time window which could lead to pro=
blems.

Thanks,
Leo

> If there are no other objections, I'll submit this fix upstream later.
>
> Meanwhile, could someone help review patches 3 and 4? They remove the
> VCN/JPEG memory allocations, which can trigger reclaim, from the GPU
> recovery path.
>
> Thanks,
> Prike
>
> > Thanks,
> > Leo
> >
> > >       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> > >               if (adev->jpeg.harvest_config & (1U << i))
> > >                       continue;
> > > @@ -95,9 +97,18 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device
> *adev)
> > >       return 0;
> > >  }
> > >
> > > +static void amdgpu_jpeg_cancel_idle_work(struct amdgpu_device
> > > +*adev) {
> > > +     /* The reset mustn't wait for the idle work, which waits for th=
e reset */
> > > +     if (amdgpu_in_reset(adev))
> > > +             cancel_delayed_work(&adev->jpeg.idle_work);
> > > +     else
> > > +             cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > +}
> > > +
> > >  int amdgpu_jpeg_suspend(struct amdgpu_device *adev)  {
> > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > +     amdgpu_jpeg_cancel_idle_work(adev);
> > >
> > >       return 0;
> > >  }
> > > @@ -114,6 +125,9 @@ static void
> > > amdgpu_jpeg_idle_work_handler(struct
> > > work_struct *work)
> > >       unsigned int fences =3D 0;
> > >       unsigned int i, j;
> > >
> > > +     /* Nothing holding the reset semaphore waits for this work */
> > > +     down_read(&adev->reset_domain->sem);
> > > +
> > >       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> > >               if (adev->jpeg.harvest_config & (1U << i))
> > >                       continue;
> > > @@ -129,6 +143,8 @@ static void
> > > amdgpu_jpeg_idle_work_handler(struct
> > > work_struct *work)
> > >               mutex_unlock(&adev->jpeg.jpeg_pg_lock);
> > >       } else
> > >               schedule_delayed_work(&adev->jpeg.idle_work,
> > > JPEG_IDLE_TIMEOUT);
> > > +
> > > +     up_read(&adev->reset_domain->sem);
> > >  }
> > >
> > >  void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring) @@
> > > -136,7
> > > +152,7 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring
> > > *ring)
> > >       struct amdgpu_device *adev =3D ring->adev;
> > >
> > >       if (!atomic_fetch_inc(&adev->jpeg.total_submission_cnt))
> > > -             cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > +             amdgpu_jpeg_cancel_idle_work(adev);
> > >
> > >       mutex_lock(&adev->jpeg.jpeg_pg_lock);
> > >       amdgpu_device_ip_set_powergating_state(adev,
> > > AMD_IP_BLOCK_TYPE_JPEG,
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > index 34e1242d66ea..631f9471be1f 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > @@ -269,6 +269,8 @@ void amdgpu_vcn_sw_fini(struct amdgpu_device
> > > *adev, int i)
> > >       if (adev->vcn.harvest_config & (1 << i))
> > >               return;
> > >
> > > +     cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> > > +
> > >       amdgpu_bo_free_kernel(
> > >               &adev->vcn.inst[i].dpg_sram_bo,
> > >               &adev->vcn.inst[i].dpg_sram_gpu_addr,
> > > @@ -459,6 +461,15 @@ void amdgpu_vcn_put_profile(struct
> > > amdgpu_device
> > > *adev)
> > >       mutex_unlock(&adev->vcn.workload_profile_mutex);
> > >  }
> > >
> > > +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst
> > > +*vcn_inst) {
> > > +     /* The reset mustn't wait for the idle work, which waits for th=
e reset */
> > > +     if (amdgpu_in_reset(vcn_inst->adev))
> > > +             cancel_delayed_work(&vcn_inst->idle_work);
> > > +     else
> > > +             cancel_delayed_work_sync(&vcn_inst->idle_work);
> > > +}
> > > +
> > >  static void amdgpu_vcn_idle_work_handler(struct work_struct
> > > *work) {
> > >       struct amdgpu_vcn_inst *vcn_inst =3D @@ -470,6 +481,9 @@
> > > static void amdgpu_vcn_idle_work_handler(struct
> > > work_struct *work)
> > >       if (adev->vcn.harvest_config & (1 << i))
> > >               return;
> > >
> > > +     /* Nothing holding the reset semaphore waits for this work */
> > > +     down_read(&adev->reset_domain->sem);
> > > +
> > >       for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
> > >               fence[i] +=3D amdgpu_fence_count_emitted(&vcn_inst-
> > > >ring_enc[j]);
> > >
> > > @@ -499,6 +513,8 @@ static void
> > > amdgpu_vcn_idle_work_handler(struct
> > > work_struct *work)
> > >       } else {
> > >               schedule_delayed_work(&vcn_inst->idle_work,
> > > VCN_IDLE_TIMEOUT);
> > >       }
> > > +
> > > +     up_read(&adev->reset_domain->sem);
> > >  }
> > >
> > >  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring) @@
> > > -507,7
> > > +523,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring
> > > *ring)
> > >       struct amdgpu_vcn_inst *vcn_inst =3D
> > > &adev->vcn.inst[ring->me];
> > >
> > >       if (!atomic_fetch_inc(&vcn_inst->total_submission_cnt))
> > > -             cancel_delayed_work_sync(&vcn_inst->idle_work);
> > > +             amdgpu_vcn_cancel_idle_work(vcn_inst);
> > >
> > >       mutex_lock(&vcn_inst->vcn_pg_lock);
> > >       vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE); diff
> > > --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > index bea95307fd42..a6438950854e 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > @@ -526,6 +526,7 @@ int amdgpu_vcn_suspend(struct amdgpu_device
> > > *adev, int i);  int amdgpu_vcn_resume(struct amdgpu_device *adev,
> > > int i);  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
> > > void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
> > > +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst
> > > +*vcn_inst);
> > >
> > >  bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,
> > >                               enum vcn_ring_type type, uint32_t
> > > vcn_instance); diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > index 72069b77f6f1..b048fd4b8b59 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > @@ -177,7 +177,7 @@ static int jpeg_v2_0_hw_fini(struct
> > > amdgpu_ip_block
> > > *ip_block)
> > >  {
> > >       struct amdgpu_device *adev =3D ip_block->adev;
> > >
> > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > +     amdgpu_jpeg_suspend(adev);
> > >
> > >       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> > >             RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS)) diff --git
> > > a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > > index 2968256d4cd7..f6a9258ae3ca 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > > @@ -239,7 +239,7 @@ static int jpeg_v2_5_hw_fini(struct
> > > amdgpu_ip_block
> > > *ip_block)
> > >       struct amdgpu_device *adev =3D ip_block->adev;
> > >       int i;
> > >
> > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > +     amdgpu_jpeg_suspend(adev);
> > >
> > >       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> > >               if (adev->jpeg.harvest_config & (1 << i)) diff --git
> > > a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > index 564e40899df2..922711aa06a3 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > @@ -192,7 +192,7 @@ static int jpeg_v3_0_hw_fini(struct
> > > amdgpu_ip_block
> > > *ip_block)
> > >  {
> > >       struct amdgpu_device *adev =3D ip_block->adev;
> > >
> > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > +     amdgpu_jpeg_suspend(adev);
> > >
> > >       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> > >             RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS)) diff --git
> > > a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > > index b29ca3a49939..fe7ab9cb35bb 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > > @@ -221,7 +221,7 @@ static int jpeg_v4_0_hw_fini(struct
> > > amdgpu_ip_block
> > > *ip_block)
> > >  {
> > >       struct amdgpu_device *adev =3D ip_block->adev;
> > >
> > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > +     amdgpu_jpeg_suspend(adev);
> > >       if (!amdgpu_sriov_vf(adev)) {
> > >               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> > >                       RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > > index 0343a64595f2..f4896ad9d1de 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > > @@ -455,7 +455,7 @@ static int jpeg_v4_0_3_hw_fini(struct
> > > amdgpu_ip_block
> > > *ip_block)
> > >       struct amdgpu_device *adev =3D ip_block->adev;
> > >       int ret =3D 0;
> > >
> > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > +     amdgpu_jpeg_suspend(adev);
> > >
> > >       if (!amdgpu_sriov_vf(adev)) {
> > >               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE) diff
> > > --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> > > index 4da3f9c995c1..87efc3c2b9e0 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> > > @@ -250,7 +250,7 @@ static int jpeg_v4_0_5_hw_fini(struct
> > > amdgpu_ip_block
> > > *ip_block)
> > >       struct amdgpu_device *adev =3D ip_block->adev;
> > >       int i;
> > >
> > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > +     amdgpu_jpeg_suspend(adev);
> > >
> > >       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> > >               if (adev->jpeg.harvest_config & (1 << i)) diff --git
> > > a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > > index dcdb089b4308..91968ad26f17 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > > @@ -189,7 +189,7 @@ static int jpeg_v5_0_0_hw_fini(struct
> > > amdgpu_ip_block
> > > *ip_block)
> > >  {
> > >       struct amdgpu_device *adev =3D ip_block->adev;
> > >
> > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > +     amdgpu_jpeg_suspend(adev);
> > >
> > >       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> > >             RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS)) diff --git
> > > a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > > index f2debf6b6bd0..27116d1e9e64 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > > @@ -326,7 +326,7 @@ static int jpeg_v5_0_1_hw_fini(struct
> > > amdgpu_ip_block
> > > *ip_block)
> > >       struct amdgpu_device *adev =3D ip_block->adev;
> > >       int ret =3D 0;
> > >
> > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > +     amdgpu_jpeg_suspend(adev);
> > >
> > >       if (!amdgpu_sriov_vf(adev)) {
> > >               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE) diff
> > > --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> > > index dd0abce73687..7e068c2d4d6d 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> > > @@ -299,7 +299,7 @@ static int jpeg_v5_0_2_hw_fini(struct
> > > amdgpu_ip_block
> > > *ip_block)
> > >       struct amdgpu_device *adev =3D ip_block->adev;
> > >       int ret =3D 0;
> > >
> > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > +     amdgpu_jpeg_suspend(adev);
> > >
> > >       if (!amdgpu_sriov_vf(adev)) {
> > >               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE) diff
> > > --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > > index 8ddd12740a04..16daeb61114c 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > > @@ -172,7 +172,7 @@ static int jpeg_v5_3_0_hw_fini(struct
> > > amdgpu_ip_block
> > > *ip_block)
> > >  {
> > >       struct amdgpu_device *adev =3D ip_block->adev;
> > >
> > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > +     amdgpu_jpeg_suspend(adev);
> > >
> > >       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> > >             RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS))
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > index 76793a5caa70..470d8f110799 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > @@ -150,8 +150,8 @@ static int vcn_v1_0_sw_init(struct
> > > amdgpu_ip_block
> > > *ip_block)
> > >       if (r)
> > >               return r;
> > >
> > > -     /* Override the work func */
> > > -     adev->vcn.inst[0].idle_work.work.func =3D vcn_v1_0_idle_work_ha=
ndler;
> > > +     /* Own lockdep class, this work is still cancelled synchronousl=
y */
> > > +     INIT_DELAYED_WORK(&adev->vcn.inst[0].idle_work,
> > > vcn_v1_0_idle_work_handler);
> > >
> > >       amdgpu_vcn_setup_ucode(adev, 0);
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > > index 7d2b9e4b913a..ba451f2a2534 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > > @@ -322,7 +322,7 @@ static int vcn_v2_0_hw_fini(struct
> > > amdgpu_ip_block
> > > *ip_block)
> > >       struct amdgpu_device *adev =3D ip_block->adev;
> > >       struct amdgpu_vcn_inst *vinst =3D adev->vcn.inst;
> > >
> > > -     cancel_delayed_work_sync(&vinst->idle_work);
> > > +     amdgpu_vcn_cancel_idle_work(vinst);
> > >
> > >       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> > >           (vinst->cur_state !=3D AMD_PG_STATE_GATE && diff --git
> > > a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > > b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > > index 10ef5616b2f5..9dd4c313cbe7 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > > @@ -304,8 +304,8 @@ static int vcn_v2_5_sw_init(struct
> > > amdgpu_ip_block
> > > *ip_block)
> > >               if (r)
> > >                       return r;
> > >
> > > -             /* Override the work func */
> > > -             adev->vcn.inst[j].idle_work.work.func =3D
> > > vcn_v2_5_idle_work_handler;
> > > +             /* Own lockdep class, this work is still cancelled
> > > + synchronously
> > > */
> > > +             INIT_DELAYED_WORK(&adev->vcn.inst[j].idle_work,
> > > vcn_v2_5_idle_work_handler);
> > >
> > >               amdgpu_vcn_setup_ucode(adev, j);
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > index 0f4f4d66e2e4..3e85abd1e82c 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > @@ -449,7 +449,7 @@ static int vcn_v3_0_hw_fini(struct
> > > amdgpu_ip_block
> > > *ip_block)
> > >               if (adev->vcn.harvest_config & (1 << i))
> > >                       continue;
> > >
> > > -             cancel_delayed_work_sync(&vinst->idle_work);
> > > +             amdgpu_vcn_cancel_idle_work(vinst);
> > >
> > >               if (!amdgpu_sriov_vf(adev)) {
> > >                       if ((adev->pg_flags &
> > > AMD_PG_SUPPORT_VCN_DPG)
> > > || diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > > index 4b7f7bbe18da..5b47a643d725 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > > @@ -374,7 +374,7 @@ static int vcn_v4_0_hw_fini(struct
> > > amdgpu_ip_block
> > > *ip_block)
> > >               if (adev->vcn.harvest_config & (1 << i))
> > >                       continue;
> > >
> > > -             cancel_delayed_work_sync(&vinst->idle_work);
> > > +             amdgpu_vcn_cancel_idle_work(vinst);
> > >
> > >               if (!amdgpu_sriov_vf(adev)) {
> > >                       if ((adev->pg_flags &
> > > AMD_PG_SUPPORT_VCN_DPG)
> > > || diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > index 3f39aa83c319..5aa09c3bd79b 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > @@ -417,7 +417,7 @@ static int vcn_v4_0_3_hw_fini(struct
> > > amdgpu_ip_block
> > > *ip_block)
> > >       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> > >               struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[i];
> > >
> > > -             cancel_delayed_work_sync(&vinst->idle_work);
> > > +             amdgpu_vcn_cancel_idle_work(vinst);
> > >
> > >               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
> > >                       vinst->set_pg_state(vinst,
> > > AMD_PG_STATE_GATE); diff --git
> > > a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > > b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > > index f30f80c1b07f..9693950cd16d 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > > @@ -327,7 +327,7 @@ static int vcn_v4_0_5_hw_fini(struct
> > > amdgpu_ip_block
> > > *ip_block)
> > >               if (adev->vcn.harvest_config & (1 << i))
> > >                       continue;
> > >
> > > -             cancel_delayed_work_sync(&vinst->idle_work);
> > > +             amdgpu_vcn_cancel_idle_work(vinst);
> > >
> > >               if (!amdgpu_sriov_vf(adev)) {
> > >                       if ((adev->pg_flags &
> > > AMD_PG_SUPPORT_VCN_DPG)
> > > || diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > > index 7b7c3bc9f046..0c189063a6ab 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > > @@ -291,7 +291,7 @@ static int vcn_v5_0_0_hw_fini(struct
> > > amdgpu_ip_block
> > > *ip_block)
> > >               if (adev->vcn.harvest_config & (1 << i))
> > >                       continue;
> > >
> > > -             cancel_delayed_work_sync(&vinst->idle_work);
> > > +             amdgpu_vcn_cancel_idle_work(vinst);
> > >
> > >               if (!amdgpu_sriov_vf(adev)) {
> > >                       if ((adev->pg_flags &
> > > AMD_PG_SUPPORT_VCN_DPG)
> > > || diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > > b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > > index c9e990ab297d..3fa553fb41d3 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > > @@ -364,7 +364,7 @@ static int vcn_v5_0_1_hw_fini(struct
> > > amdgpu_ip_block
> > > *ip_block)
> > >       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> > >               struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[i];
> > >
> > > -             cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> > > +             amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
> > >               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
> > >                       vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
> > >       }
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> > > b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> > > index ed47ddd5b08c..eb13f792e25d 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> > > @@ -279,7 +279,7 @@ static int vcn_v5_0_2_hw_fini(struct
> > > amdgpu_ip_block
> > > *ip_block)
> > >       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> > >               struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[i];
> > >
> > > -             cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> > > +             amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
> > >               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
> > >                       vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
> > >       }
> > > --
> > > 2.34.1
> >
>

