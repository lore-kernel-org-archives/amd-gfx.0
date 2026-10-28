Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AF6606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fMrg23zK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2BAC10E514;
	Wed, 28 Oct 2026 15:40:18 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EB9810E514
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 15:40:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFhgpiv/yzJN4tvOPfMYSYmXzTB8irYgDNlpVLJ4Y6wRe6V2anH53fKhHuWQcfjFxnITaGfUVGY0D2HQ9KdCl4Sie82RjgwCI1V+K3LpkKT+/vM3P1/GfleUu+cu2OEL3PRMGJgEN6rsXvArsNtzHsyISN9vyLA98aKrcnCqhrJomHQlLGeiXOpBL/pDDhL5JonPQKyjTDXRGiI/9A0xbo8wWxBuG0AUCBGQjAAGsgTNTBc5rBx74XGNGyIIo/JHhSCxm1iPVIJRJEi8VlKbAOvh3eVJtDsXjwKcZMVsCSinY4+be2kp+c4TgP+uOBuObLapNH4jaj01CTBg0oIW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGEGS+Y2fQ3PuWEEPg8SXX0fA7BIVKuhjbikVFL+XDk=;
 b=dR1grEGsOWxybucwbOyQ0kLtQLo0NEGgs0BnaAEtJ9KkoUy3Vp2Ub7c5o6sfWGRyqJ1L+SjsKg7Dui7ecq6xvQCBzmqEy+gJsoKVmC3m5iJsrOZ14KucM6hna6/K1Mj5B5x/X5dyWprlIrW7gHFJYUeSiSib5MJ6lXYn2VzJN0BX8POzq9ugM29B3ykVGEJz2CMKidsytcqzY1SxLIGf+XfZ/QXfS7HLdAiMOVmGTQf5jx0eCuxAEYcrJeqy43jpAvcbejpHOTIf4h41HB2Vn1q02Cwquyq46nLsvUlGHMLrO55Ds1C2c53uWvceA8oz2WFTiDjUVAuVLYHZDW4G9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGEGS+Y2fQ3PuWEEPg8SXX0fA7BIVKuhjbikVFL+XDk=;
 b=fMrg23zKBNS4RyBNdAbv3B+tujSSxOMAglBe/mkOKEWLyULSzyghqDKhCZ+nSCj1lxionYC1I/gfbw+BT0b35zk3y867TZ7kkPX96tLlreIucJNG8cNcdm0o6LKnKBfaqnQPKJiPhixyBWE1/jqhFsEb5/4wH58IjktA7q33aOE=
Received: from MW6PR12MB7072.namprd12.prod.outlook.com (2603:10b6:303:238::13)
 by DS4PR12MB9635.namprd12.prod.outlook.com (2603:10b6:8:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Wed, 28 Oct
 2026 15:40:03 +0000
Received: from MW6PR12MB7072.namprd12.prod.outlook.com
 ([fe80::a786:e93f:6c7b:ad9a]) by MW6PR12MB7072.namprd12.prod.outlook.com
 ([fe80::a786:e93f:6c7b:ad9a%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 15:40:03 +0000
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
Thread-Index: AQHdYslo88eLyLqXy0GjsxTisxnSPbcLucawgAPSZYCAAFBmMIABiZmAgAAgDeCAAMz8AIAAywug
Date: Wed, 28 Oct 2026 15:40:02 +0000
Message-ID: <MW6PR12MB7072E3EE2ADA969ADA7C456BE56F2@MW6PR12MB7072.namprd12.prod.outlook.com>
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
 <20261023083422.3049246-5-Prike.Liang@amd.com>
 <CY8PR12MB7435B329FCC59091483D66E4E5642@CY8PR12MB7435.namprd12.prod.outlook.com>
 <PH7PR12MB6000E8F8FD01623634E3EF18FB612@PH7PR12MB6000.namprd12.prod.outlook.com>
 <MW6PR12MB70724A38A2BFAAC16324E233E5612@MW6PR12MB7072.namprd12.prod.outlook.com>
 <PH7PR12MB6000F0BEA1BEC025F02E5E2CFB602@PH7PR12MB6000.namprd12.prod.outlook.com>
 <MW6PR12MB707276D3E59DEE221733930EE5602@MW6PR12MB7072.namprd12.prod.outlook.com>
 <PH7PR12MB60008FA62BBB45916BF2BC5BFB6F2@PH7PR12MB6000.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB60008FA62BBB45916BF2BC5BFB6F2@PH7PR12MB6000.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: MW6PR12MB7072:EE_|DS4PR12MB9635:EE_
x-ms-office365-filtering-correlation-id: e666c9f0-3cda-441c-ea56-08df3509bba8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|42112799006|376014|1800799024|23010399003|261026121527099003|38070700021|11063799006|4143699003|5023799004|56012099006|261022075727099003|10067099003|261022105027099003|261021121427099003|261009223327099003|261009223027099003|261009221727099003|261021123027099003|261009220027099003|261009221227099003|260925021311599003|260925022911599003|260925021911599003|261028144727099003|18002099003|22082099003|3023799007|6133799003|261026140227099003;
x-microsoft-antispam-message-info: T3OJBohkw0Ss2acsMIS60nc5LuCTdteEk9JMx0UCA7U4cDxveHqWeTFm4Xn+lP+ICwQ3YlNDvZRVMDAzb4pn5+QOxOqfaqTUbMjehyCAtmi8MumK3ODr9j7aSpGNkWvZexe8vbdFSuI0TVkWtIlNWXoGcb+woD0JCtvv+8RWFoVxfB5HBgsBHsPEZug4Si2aykrPOCyBlfwIGV1SR5KgPTm74BLhnoS7Umv3Fp8G8hGrIbGPWiAWMASfRsM+JaLTJqwXiTIHHibrWJ/nzDK++nRpv3JLzLzHr95rMeSR2emFsVtgc1D+mhaZbg5CzlPR+HbHWT3wxYJ0hOHmbUCKVE5RtCCMsMIgcnUKQsHy0qnpK0+KXRyvRAH/n0YrfAuUOaNHQz/l4I4A8uAA+5EAPWR5ACOBR4z9wQHgW72oUPr35IUzbk8+T6waiLjpaAlke8fTZyNo9f7z/pk6HH0zOBtZBx69b2aiEduUam8n2fcwdj8wtzL/LC4zbrEIsVLzOCv15cQXRTEP9eNN9hvRtAtUGuYOinN5y0sAH88nWuLHXmIBYwjUC0EM3pS8mvvXSWZc2ItC3o0WCjkTq6Q+g0utdXBkSRvxy5HVyvLEdta/G/33pDY/3tECEwYiqxUFoP2710rltfQqpLQcQ4yxCCC/PXyC1YJLQTEZ0M+7lH8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB7072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(42112799006)(376014)(1800799024)(23010399003)(261026121527099003)(38070700021)(11063799006)(4143699003)(5023799004)(56012099006)(261022075727099003)(10067099003)(261022105027099003)(261021121427099003)(261009223327099003)(261009223027099003)(261009221727099003)(261021123027099003)(261009220027099003)(261009221227099003)(260925021311599003)(260925022911599003)(260925021911599003)(261028144727099003)(18002099003)(22082099003)(3023799007)(6133799003)(261026140227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zkXcpRbTNwNjF8uNXMTAgG6X+60Ca73bEaxgZPbxZV3E8z2hHvh0Xm/lgsyO?=
 =?us-ascii?Q?VIeUbyuCll2I7+iiHwKlxyKYZ1asOHaKpqJipa/Cub3MVaItvK+9aC1WdPS4?=
 =?us-ascii?Q?jiazt83+zkUOxPHs7Yc/I33o+hM+VePPIYDojNGO8LXY1VcmFP3S0Erscwmf?=
 =?us-ascii?Q?QCKYjSMcPft36ah+MuArcD/Oy1UP+Lw46vmICbUpb0u40mFC7I4v+AEge7k2?=
 =?us-ascii?Q?F8BZ4p1lNVKzNtnxCJLLfI45vIimfkulXLlAFC+w3UkAuMVZXCavDEYGhKII?=
 =?us-ascii?Q?0vOzrOrZpU8ikNaozXUg1NMYLE8eOFluyz6Z1tE/pFhl8jjIB/FmYreAt+uI?=
 =?us-ascii?Q?Hg+/AZLkPyWLBi6P3f5oIBfG3KwyaHKiKFzkeClnM0lRN86VkHre6H3NPRL4?=
 =?us-ascii?Q?CwgWs4Dbdtqyyi84JfvwK7+QT6AAXiYKyq2fUf09d+J7B0qzfM6PjHR3QQgG?=
 =?us-ascii?Q?Imnj2bnX02m3U0rxtqF5a+RFM0I+J3KeqVMhSSPQDPnivlXSjdup0X76qVUg?=
 =?us-ascii?Q?9oldp7KK4IDQLkRpy0AH9w1kIGzh4XrMT40xQC+l8fT7Ch9wcSZ8uPzALH/Q?=
 =?us-ascii?Q?txUdm0ubup7XETP9eLCkxMqgmBbfQQSA5/mSyLa2ADoALO7ixHYB0gv97pl8?=
 =?us-ascii?Q?R6Y4CAPdkfRWDcz2XvcDT247KCIriwVO2/fnRQxAz6a12qDVjZaNb72mirQp?=
 =?us-ascii?Q?gclSs15iLUkVeoI+xrpQ0Tj0gf0WBkJ+lovdMqbGYhD0z5LL/eE9bXs7zTX/?=
 =?us-ascii?Q?gYnkRcnx+TtnO7Yn59zMTwHA9dpnsWWr8uLCB06x0I9AjDQdj9MvyOMO7hWC?=
 =?us-ascii?Q?bme7lJyyZwkvOGit9CkSvK7c+KU4GnFrplkvXVJFA+8xjDGZP68rdRJqMmQX?=
 =?us-ascii?Q?ArhfvfZdmH2cErqkz/UgworDJVE5CB3YHa+jI9Bou/EqI5XEcehWXK7X2f+g?=
 =?us-ascii?Q?+oRWzqWcRJj7ctVSLWlUXNZY/CjCZlX7fyOjcT+B7dOWzBx2owuQHYHvoKkq?=
 =?us-ascii?Q?+RdUihrXX0CfYkX/ZQJpXAAhE34qJ26dHxPJ3d19Xk2g9zGfE7f+DkMSSAEE?=
 =?us-ascii?Q?8lZPHEvnEsvrn8Z6D3jajgcxSBs+DCWQwL4U/yVmny9e4sis0ynjMNFrsH8x?=
 =?us-ascii?Q?exO6uupomcV+ZPUErNaXkICdhBvS3al5dZQe2LPwFPi8JQp5Vaeh1kjpMdmN?=
 =?us-ascii?Q?jCf62w10wIX73Ofg6bybsdX//ap51CISx5eK/X8VRDItCJbduuKNKRptlZjS?=
 =?us-ascii?Q?xR1rKvPiReGU1tyiNm5Tofwra81P5JIRAYfLa/pk0A81jb5Yg1Kf2FdGL4rz?=
 =?us-ascii?Q?Lh746p6JKzIt+eCiZg0FiANL+GZlQG6WQLZ9vHDYLv+NdvRqZLW2wyFnE9Ku?=
 =?us-ascii?Q?S9QUxEFoNBIFg5KGHNBbDT3b9HS0LsXxy0b2NujxowVI4KzpYGQWXLrklUcM?=
 =?us-ascii?Q?4hpCuA8tG6UBNaOEpN/uAH1qRUefdglfzjAIB97Zoatj8dxe8ef+zCb5aHzi?=
 =?us-ascii?Q?2ls9e+uT8F+xZU83xIGHVA8NhaSK1gPHNPqYMUxP3ULKGTftNpAgXsvcjKAH?=
 =?us-ascii?Q?U6NdNNzN5vtCf9muWucMPYlAJm7KMJQQtRl2/Ki61OFbdMZKBpkri7Db0BQV?=
 =?us-ascii?Q?Co5uZYuYrUB4obnB0a0Vtk/Iuaqv0qQZ3VtjYjeaFJevIgkY2/RyQ5KtYO60?=
 =?us-ascii?Q?O6J1b7N2AjdImoOT8loe4FBeOzHetTdmt8/Nej/AG+IHJjg8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e666c9f0-3cda-441c-ea56-08df3509bba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 15:40:02.8867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q9pQKfU/DQ01yF4SgnSJKFwr+jwo7NBTebKAJleDx74C6DftBhjknPbJoNVC02wO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9635
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

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, October 27, 2026 11:28 PM
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
> > Sent: Tuesday, October 27, 2026 11:23 PM
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
> > > Sent: Tuesday, October 27, 2026 9:20 AM
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
> > > > Sent: Monday, October 26, 2026 10:32 PM
> > > > To: Liang, Prike <Prike.Liang@amd.com>;
> > > > amd-gfx@lists.freedesktop.org
> > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > Christian <Christian.Koenig@amd.com>; Lazar, Lijo
> > > > <Lijo.Lazar@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
> > > > Subject: RE: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for
> > > > the JPEG/VCN idle work
> > > >
> > > > AMD General
> > > >
> > > > > -----Original Message-----
> > > > > From: Liang, Prike <Prike.Liang@amd.com>
> > > > > Sent: Monday, October 26, 2026 5:04 AM
> > > > > To: Liu, Leo <Leo.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > > Christian <Christian.Koenig@amd.com>; Lazar, Lijo
> > > > > <Lijo.Lazar@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
> > > > > Subject: RE: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for
> > > > > the JPEG/VCN idle work
> > > > >
> > > > > AMD General
> > > > >
> > > > > Regards,
> > > > >       Prike
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Liu, Leo <Leo.Liu@amd.com>
> > > > > > Sent: Saturday, October 24, 2026 6:47 AM
> > > > > > To: Liang, Prike <Prike.Liang@amd.com>;
> > > > > > amd-gfx@lists.freedesktop.org
> > > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > > > Christian <Christian.Koenig@amd.com>; Lazar, Lijo
> > > > > > <Lijo.Lazar@amd.com>; Prosyak, Vitaly
> > > > > > <Vitaly.Prosyak@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> > > > > > Subject: RE: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait
> > > > > > for the JPEG/VCN idle work
> > > > > >
> > > > > > AMD General
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On
> > > > > > > Behalf Of Prike Liang
> > > > > > > Sent: Friday, October 23, 2026 4:34 AM
> > > > > > > To: amd-gfx@lists.freedesktop.org
> > > > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > > > > Christian <Christian.Koenig@amd.com>; Lazar, Lijo
> > > > > > > <Lijo.Lazar@amd.com>; Prosyak, Vitaly
> > > > > > > <Vitaly.Prosyak@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> > > > > > > Subject: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for
> > > > > > > the JPEG/VCN idle work
> > > > > > >
> > > > > > > The common JPEG and VCN idle workers program power gating
> > > > > > > and DPG pause, so they must not run while a GPU reset is in p=
rogress.
> > > > > > > Recovery must not wait for them either, since everything the
> > > > > > > workers depend on then becomes a dependency of GPU recovery.
> > > > > > >
> > > > > > > Make the workers take reset_domain->sem for read, so they
> > > > > > > wait for a running reset instead of touching the hardware.
> > > > > > > hw_fini/suspend and begin_use, the latter for the IB tests,
> > > > > > > run from GPU recovery as well, so only skip waiting for the
> > > > > > > idle work when the
> > > reset itself calls them.
> > > > > > > The reset holds the semaphore for write and would otherwise
> > > > > > > deadlock on a worker blocked on it. Outside a reset the
> > > > > > > cancel stays synchronous as before. sw_fini always cancels
> > > > > > > synchronously, it never runs with the reset semaphore held.
> > > > > > >
> > > > > > > Update versions: https://lore.kernel.org/amd-
> > > > > > > gfx/PH7PR12MB6000698A62D208E47BB358D7FB662@
> > > > > > > PH7PR12MB6000.namprd12.prod.outlook.com/
> > > > > > >
> > > > > > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 20
> > > > > > > ++++++++++++++++++--
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > > > > > ++++++++++++++++++|
> > > > > > > ++++++++++++++++++18
> > > > > > > +++++++++++++++++- drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > > > > > +++++++++++++++++|
> > > > > > > +++++++++++++++++1
> > > > > > > ++++++++++++++++++
> > > > > > >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
> > > > > > >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 +-
> > > > > > >  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 +-
> > > > > > >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 +-
> > > > > > >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  2 +-
> > > > > > > drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  2 +-
> > > > > > > drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
> > > > > > > drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 +-
> > > > > > > drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  2 +-
> > > > > > > drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  2 +-
> > > > > > >  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  4 ++--
> > > > > > >  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  2 +-
> > > > > > >  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  4 ++--
> > > > > > >  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  2 +-
> > > > > > >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 +-
> > > > > > >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  2 +-
> > > > > > > drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  2 +-
> > > > > > > drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  2 +-
> > > > > > > drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  2 +-
> > > > > > > drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  2 +-
> > > > > > >  23 files changed, 58 insertions(+), 25 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > > > > > > index 87f879a2e4f4..2bddef322870 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > > > > > > @@ -74,6 +74,8 @@ int amdgpu_jpeg_sw_fini(struct
> > > > > > > amdgpu_device
> > > > > > > *adev) {
> > > > > > >       int i, j;
> > > > > > >
> > > > > > > +     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > +
> > > > > >
> > > > > > I think this is redundant when hw_fini() ran normally,  they
> > > > > > are only needed when
> > > > > > hw_fini() was skipped - i.e. when hw_init() failed and
> > > > > > status.hw was never
> > > set.
> > > > > > Also, UVD and VCE should be covered as well.
> > > > >
> > > > > Yeah, this change is aimed at the cases where the idle work
> > > > > isn't cancelled synchronously before sw_fini(): hw_fini() was ski=
pped (e.g.
> > > > > hw_init() failed), or the suspend/hw_fini path only did the
> > > > > non-waiting cancel because it ran during a reset. If the idle
> > > > > work was already cancelled synchronously before sw_fini(), the
> > > > > extra
> > > > cancel_delayed_work_sync() is harmless and just returns.
> > > > >
> > > >
> > > > The problem is that calling cancel worker in sw_fini arrives too
> > > > late, the idle work is scheduled ~1 second into the future.
> > > > The fini_early/fini teardown sequence runs in that same window,
> > > > tearing down other IP blocks that VCN depends on (MMHUB, SMU). The
> > > > right place to cancel is in hw_init()'s error path, immediately
> > > > before returning the error, while other IPs is still alive, and
> > > > close time window which
> > > could lead to problems.
> > >
> > > Yes, I'll add a separate patch that cancels synchronously the idle
> > > work in the hw_init error paths, so the worker can't run after a fail=
ed hw_init.
> > >
> > > I'd like to keep the synchronous cancel in sw_fini, though. It
> > > covers the case where hw_fini doesn't wait for a worker that's
> > > already running, which happens when a peer in the same XGMI hive is
> resetting.
> > > The cancel makes sure that worker finishes before its state is freed.
> >
> > That is a race condition, and the cancel doesn't fix the root cause,
> > The preferred fix should make hw_fini properly so it always guarantees
> > the handler is done, removing the need for anything in sw_fini.
>
> OK, got it. For the XGMI hive case, where hw_fini doesn't wait for the id=
le work
> while a peer is resetting, I'll move the synchronous cancel to early_fini=
(). It runs
> only on teardown, before any hw_fini. I'll also drop the cancel from sw_f=
ini.
>
However it still leaves a time window between the ring test failure and whe=
n early_fini is eventually
reached, during which the idle workers can fire on broken hardware or race =
with other
IP blocks in transitional states. The only place that eliminates the window=
 entirely is hw_init()'s error path itself.

More importantly, it seems to me that early_fini is only called from amdgpu=
_device_fini_hw() - the driver
unload path. It has no presence in amdgpu_device_gpu_recover(), if that is =
true, does it affect your case?

Thanks,
Leo


> > At least, if keeping something in sw_fini, you need to make it
> > conditional - only when hw_fini actually left a handler running.
>
> Yes, a flag set when hw_fini skips waiting would let sw_fini cancel only =
in that
> case. But the worker could still run while the hardware is being torn dow=
n. So I'll
> move the synchronous cancel to early_fini(), before any hw_fini, and drop=
 it from
> sw_fini.
>
> Thanks,
> Prike
>
> > Thanks,
> > Leo
> >
> > >
> > > There's still a related timing issue in the hive reset case: the
> > > worker can run after VCN and SMU have been torn down. I'll handle
> > > that separately, I want to keep this series focused on GPU recovery f=
irst.
> > >
> > > Regards,
> > > Prike
> > >
> > >
> > > > Thanks,
> > > > Leo
> > > >
> > > > > If there are no other objections, I'll submit this fix upstream l=
ater.
> > > > >
> > > > > Meanwhile, could someone help review patches 3 and 4? They
> > > > > remove the VCN/JPEG memory allocations, which can trigger
> > > > > reclaim, from the GPU recovery path.
> > > > >
> > > > > Thanks,
> > > > > Prike
> > > > >
> > > > > > Thanks,
> > > > > > Leo
> > > > > >
> > > > > > >       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> > > > > > >               if (adev->jpeg.harvest_config & (1U << i))
> > > > > > >                       continue; @@ -95,9 +97,18 @@ int
> > > > > > > amdgpu_jpeg_sw_fini(struct amdgpu_device
> > > > > *adev)
> > > > > > >       return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > +static void amdgpu_jpeg_cancel_idle_work(struct
> > > > > > > +amdgpu_device
> > > > > > > +*adev) {
> > > > > > > +     /* The reset mustn't wait for the idle work, which
> > > > > > > +waits for the reset
> > > */
> > > > > > > +     if (amdgpu_in_reset(adev))
> > > > > > > +             cancel_delayed_work(&adev->jpeg.idle_work);
> > > > > > > +     else
> > > > > > > +
> > > > > > > +cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > +}
> > > > > > > +
> > > > > > >  int amdgpu_jpeg_suspend(struct amdgpu_device *adev)  {
> > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > +     amdgpu_jpeg_cancel_idle_work(adev);
> > > > > > >
> > > > > > >       return 0;
> > > > > > >  }
> > > > > > > @@ -114,6 +125,9 @@ static void
> > > > > > > amdgpu_jpeg_idle_work_handler(struct
> > > > > > > work_struct *work)
> > > > > > >       unsigned int fences =3D 0;
> > > > > > >       unsigned int i, j;
> > > > > > >
> > > > > > > +     /* Nothing holding the reset semaphore waits for this w=
ork */
> > > > > > > +     down_read(&adev->reset_domain->sem);
> > > > > > > +
> > > > > > >       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> > > > > > >               if (adev->jpeg.harvest_config & (1U << i))
> > > > > > >                       continue; @@ -129,6 +143,8 @@ static
> > > > > > > void amdgpu_jpeg_idle_work_handler(struct
> > > > > > > work_struct *work)
> > > > > > >               mutex_unlock(&adev->jpeg.jpeg_pg_lock);
> > > > > > >       } else
> > > > > > >               schedule_delayed_work(&adev->jpeg.idle_work,
> > > > > > > JPEG_IDLE_TIMEOUT);
> > > > > > > +
> > > > > > > +     up_read(&adev->reset_domain->sem);
> > > > > > >  }
> > > > > > >
> > > > > > >  void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
> > > > > > > @@
> > > > > > > -136,7
> > > > > > > +152,7 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring
> > > > > > > *ring)
> > > > > > >       struct amdgpu_device *adev =3D ring->adev;
> > > > > > >
> > > > > > >       if (!atomic_fetch_inc(&adev->jpeg.total_submission_cnt)=
)
> > > > > > > -             cancel_delayed_work_sync(&adev->jpeg.idle_work)=
;
> > > > > > > +             amdgpu_jpeg_cancel_idle_work(adev);
> > > > > > >
> > > > > > >       mutex_lock(&adev->jpeg.jpeg_pg_lock);
> > > > > > >       amdgpu_device_ip_set_powergating_state(adev,
> > > > > > > AMD_IP_BLOCK_TYPE_JPEG,
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > > > > > index 34e1242d66ea..631f9471be1f 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > > > > > @@ -269,6 +269,8 @@ void amdgpu_vcn_sw_fini(struct
> > > > > > > amdgpu_device *adev, int i)
> > > > > > >       if (adev->vcn.harvest_config & (1 << i))
> > > > > > >               return;
> > > > > > >
> > > > > > > +
> > > > > > > + cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> > > > > > > +
> > > > > > >       amdgpu_bo_free_kernel(
> > > > > > >               &adev->vcn.inst[i].dpg_sram_bo,
> > > > > > >               &adev->vcn.inst[i].dpg_sram_gpu_addr,
> > > > > > > @@ -459,6 +461,15 @@ void amdgpu_vcn_put_profile(struct
> > > > > > > amdgpu_device
> > > > > > > *adev)
> > > > > > >       mutex_unlock(&adev->vcn.workload_profile_mutex);
> > > > > > >  }
> > > > > > >
> > > > > > > +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst
> > > > > > > +*vcn_inst) {
> > > > > > > +     /* The reset mustn't wait for the idle work, which
> > > > > > > +waits for the reset
> > > */
> > > > > > > +     if (amdgpu_in_reset(vcn_inst->adev))
> > > > > > > +             cancel_delayed_work(&vcn_inst->idle_work);
> > > > > > > +     else
> > > > > > > +
> > > > > > > +cancel_delayed_work_sync(&vcn_inst->idle_work);
> > > > > > > +}
> > > > > > > +
> > > > > > >  static void amdgpu_vcn_idle_work_handler(struct work_struct
> > > > > > > *work) {
> > > > > > >       struct amdgpu_vcn_inst *vcn_inst =3D @@ -470,6 +481,9 @=
@
> > > > > > > static void amdgpu_vcn_idle_work_handler(struct
> > > > > > > work_struct *work)
> > > > > > >       if (adev->vcn.harvest_config & (1 << i))
> > > > > > >               return;
> > > > > > >
> > > > > > > +     /* Nothing holding the reset semaphore waits for this w=
ork */
> > > > > > > +     down_read(&adev->reset_domain->sem);
> > > > > > > +
> > > > > > >       for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
> > > > > > >               fence[i] +=3D
> > > > > > > amdgpu_fence_count_emitted(&vcn_inst-
> > > > > > > >ring_enc[j]);
> > > > > > >
> > > > > > > @@ -499,6 +513,8 @@ static void
> > > > > > > amdgpu_vcn_idle_work_handler(struct
> > > > > > > work_struct *work)
> > > > > > >       } else {
> > > > > > >               schedule_delayed_work(&vcn_inst->idle_work,
> > > > > > > VCN_IDLE_TIMEOUT);
> > > > > > >       }
> > > > > > > +
> > > > > > > +     up_read(&adev->reset_domain->sem);
> > > > > > >  }
> > > > > > >
> > > > > > >  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring) @@
> > > > > > > -507,7
> > > > > > > +523,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring
> > > > > > > *ring)
> > > > > > >       struct amdgpu_vcn_inst *vcn_inst =3D
> > > > > > > &adev->vcn.inst[ring->me];
> > > > > > >
> > > > > > >       if (!atomic_fetch_inc(&vcn_inst->total_submission_cnt))
> > > > > > > -             cancel_delayed_work_sync(&vcn_inst->idle_work);
> > > > > > > +             amdgpu_vcn_cancel_idle_work(vcn_inst);
> > > > > > >
> > > > > > >       mutex_lock(&vcn_inst->vcn_pg_lock);
> > > > > > >       vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > > > > > index bea95307fd42..a6438950854e 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > > > > > @@ -526,6 +526,7 @@ int amdgpu_vcn_suspend(struct
> > > > > > > amdgpu_device *adev, int i);  int amdgpu_vcn_resume(struct
> > > > > > > amdgpu_device *adev, int i);  void
> > > > > > > amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring); void
> > > > > > > amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
> > > > > > > +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst
> > > > > > > +*vcn_inst);
> > > > > > >
> > > > > > >  bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,
> > > > > > >                               enum vcn_ring_type type,
> > > > > > > uint32_t vcn_instance); diff --git
> > > > > > > a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > > > > > index 72069b77f6f1..b048fd4b8b59 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > > > > > @@ -177,7 +177,7 @@ static int jpeg_v2_0_hw_fini(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)
> > > > > > >  {
> > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > >
> > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > +     amdgpu_jpeg_suspend(adev);
> > > > > > >
> > > > > > >       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> > > > > > >             RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS)) diff
> > > > > > > --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > > > > > > index 2968256d4cd7..f6a9258ae3ca 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > > > > > > @@ -239,7 +239,7 @@ static int jpeg_v2_5_hw_fini(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)
> > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > >       int i;
> > > > > > >
> > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > +     amdgpu_jpeg_suspend(adev);
> > > > > > >
> > > > > > >       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> > > > > > >               if (adev->jpeg.harvest_config & (1 << i)) diff
> > > > > > > --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > > > > > index 564e40899df2..922711aa06a3 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > > > > > @@ -192,7 +192,7 @@ static int jpeg_v3_0_hw_fini(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)
> > > > > > >  {
> > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > >
> > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > +     amdgpu_jpeg_suspend(adev);
> > > > > > >
> > > > > > >       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> > > > > > >             RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS)) diff
> > > > > > > --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > > > > > > index b29ca3a49939..fe7ab9cb35bb 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > > > > > > @@ -221,7 +221,7 @@ static int jpeg_v4_0_hw_fini(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)
> > > > > > >  {
> > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > >
> > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > +     amdgpu_jpeg_suspend(adev);
> > > > > > >       if (!amdgpu_sriov_vf(adev)) {
> > > > > > >               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE=
 &&
> > > > > > >                       RREG32_SOC15(JPEG, 0,
> > > > > > > regUVD_JRBC_STATUS)) diff --git
> > > > > > > a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > > > > > > index 0343a64595f2..f4896ad9d1de 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > > > > > > @@ -455,7 +455,7 @@ static int jpeg_v4_0_3_hw_fini(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)
> > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > >       int ret =3D 0;
> > > > > > >
> > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > +     amdgpu_jpeg_suspend(adev);
> > > > > > >
> > > > > > >       if (!amdgpu_sriov_vf(adev)) {
> > > > > > >               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE=
)
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> > > > > > > index 4da3f9c995c1..87efc3c2b9e0 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> > > > > > > @@ -250,7 +250,7 @@ static int jpeg_v4_0_5_hw_fini(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)
> > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > >       int i;
> > > > > > >
> > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > +     amdgpu_jpeg_suspend(adev);
> > > > > > >
> > > > > > >       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> > > > > > >               if (adev->jpeg.harvest_config & (1 << i)) diff
> > > > > > > --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > > > > > > index dcdb089b4308..91968ad26f17 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > > > > > > @@ -189,7 +189,7 @@ static int jpeg_v5_0_0_hw_fini(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)
> > > > > > >  {
> > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > >
> > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > +     amdgpu_jpeg_suspend(adev);
> > > > > > >
> > > > > > >       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> > > > > > >             RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS)) diff
> > > > > > > --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > > > > > > index f2debf6b6bd0..27116d1e9e64 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > > > > > > @@ -326,7 +326,7 @@ static int jpeg_v5_0_1_hw_fini(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)
> > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > >       int ret =3D 0;
> > > > > > >
> > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > +     amdgpu_jpeg_suspend(adev);
> > > > > > >
> > > > > > >       if (!amdgpu_sriov_vf(adev)) {
> > > > > > >               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE=
)
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> > > > > > > index dd0abce73687..7e068c2d4d6d 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> > > > > > > @@ -299,7 +299,7 @@ static int jpeg_v5_0_2_hw_fini(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)
> > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > >       int ret =3D 0;
> > > > > > >
> > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > +     amdgpu_jpeg_suspend(adev);
> > > > > > >
> > > > > > >       if (!amdgpu_sriov_vf(adev)) {
> > > > > > >               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE=
)
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > > > > > > index 8ddd12740a04..16daeb61114c 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > > > > > > @@ -172,7 +172,7 @@ static int jpeg_v5_3_0_hw_fini(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)
> > > > > > >  {
> > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > >
> > > > > > > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > > > > > > +     amdgpu_jpeg_suspend(adev);
> > > > > > >
> > > > > > >       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> > > > > > >             RREG32_SOC15(JPEG, 0,
> > > > > > > regUVD_JRBC0_UVD_JRBC_STATUS)) diff --git
> > > > > > > a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > > index 76793a5caa70..470d8f110799 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > > @@ -150,8 +150,8 @@ static int vcn_v1_0_sw_init(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)
> > > > > > >       if (r)
> > > > > > >               return r;
> > > > > > >
> > > > > > > -     /* Override the work func */
> > > > > > > -     adev->vcn.inst[0].idle_work.work.func =3D
> > > vcn_v1_0_idle_work_handler;
> > > > > > > +     /* Own lockdep class, this work is still cancelled sync=
hronously */
> > > > > > > +     INIT_DELAYED_WORK(&adev->vcn.inst[0].idle_work,
> > > > > > > vcn_v1_0_idle_work_handler);
> > > > > > >
> > > > > > >       amdgpu_vcn_setup_ucode(adev, 0);
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > > > > > > index 7d2b9e4b913a..ba451f2a2534 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > > > > > > @@ -322,7 +322,7 @@ static int vcn_v2_0_hw_fini(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)
> > > > > > >       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > >       struct amdgpu_vcn_inst *vinst =3D adev->vcn.inst;
> > > > > > >
> > > > > > > -     cancel_delayed_work_sync(&vinst->idle_work);
> > > > > > > +     amdgpu_vcn_cancel_idle_work(vinst);
> > > > > > >
> > > > > > >       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> > > > > > >           (vinst->cur_state !=3D AMD_PG_STATE_GATE && diff
> > > > > > > --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > > > > > > index 10ef5616b2f5..9dd4c313cbe7 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > > > > > > @@ -304,8 +304,8 @@ static int vcn_v2_5_sw_init(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)
> > > > > > >               if (r)
> > > > > > >                       return r;
> > > > > > >
> > > > > > > -             /* Override the work func */
> > > > > > > -             adev->vcn.inst[j].idle_work.work.func =3D
> > > > > > > vcn_v2_5_idle_work_handler;
> > > > > > > +             /* Own lockdep class, this work is still
> > > > > > > + cancelled synchronously
> > > > > > > */
> > > > > > > +
> > > > > > > + INIT_DELAYED_WORK(&adev->vcn.inst[j].idle_work,
> > > > > > > vcn_v2_5_idle_work_handler);
> > > > > > >
> > > > > > >               amdgpu_vcn_setup_ucode(adev, j);
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > > > > > index 0f4f4d66e2e4..3e85abd1e82c 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > > > > > @@ -449,7 +449,7 @@ static int vcn_v3_0_hw_fini(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)
> > > > > > >               if (adev->vcn.harvest_config & (1 << i))
> > > > > > >                       continue;
> > > > > > >
> > > > > > > -             cancel_delayed_work_sync(&vinst->idle_work);
> > > > > > > +             amdgpu_vcn_cancel_idle_work(vinst);
> > > > > > >
> > > > > > >               if (!amdgpu_sriov_vf(adev)) {
> > > > > > >                       if ((adev->pg_flags &
> > > > > > > AMD_PG_SUPPORT_VCN_DPG)
> > > > > > > || diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > > > > > > index 4b7f7bbe18da..5b47a643d725 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > > > > > > @@ -374,7 +374,7 @@ static int vcn_v4_0_hw_fini(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)
> > > > > > >               if (adev->vcn.harvest_config & (1 << i))
> > > > > > >                       continue;
> > > > > > >
> > > > > > > -             cancel_delayed_work_sync(&vinst->idle_work);
> > > > > > > +             amdgpu_vcn_cancel_idle_work(vinst);
> > > > > > >
> > > > > > >               if (!amdgpu_sriov_vf(adev)) {
> > > > > > >                       if ((adev->pg_flags &
> > > > > > > AMD_PG_SUPPORT_VCN_DPG)
> > > > > > > || diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > > > > > index 3f39aa83c319..5aa09c3bd79b 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > > > > > @@ -417,7 +417,7 @@ static int vcn_v4_0_3_hw_fini(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)
> > > > > > >       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> > > > > > >               struct amdgpu_vcn_inst *vinst =3D
> > > > > > > &adev->vcn.inst[i];
> > > > > > >
> > > > > > > -             cancel_delayed_work_sync(&vinst->idle_work);
> > > > > > > +             amdgpu_vcn_cancel_idle_work(vinst);
> > > > > > >
> > > > > > >               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
> > > > > > >                       vinst->set_pg_state(vinst,
> > > > > > > AMD_PG_STATE_GATE); diff --git
> > > > > > > a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > > > > > > index f30f80c1b07f..9693950cd16d 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > > > > > > @@ -327,7 +327,7 @@ static int vcn_v4_0_5_hw_fini(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)
> > > > > > >               if (adev->vcn.harvest_config & (1 << i))
> > > > > > >                       continue;
> > > > > > >
> > > > > > > -             cancel_delayed_work_sync(&vinst->idle_work);
> > > > > > > +             amdgpu_vcn_cancel_idle_work(vinst);
> > > > > > >
> > > > > > >               if (!amdgpu_sriov_vf(adev)) {
> > > > > > >                       if ((adev->pg_flags &
> > > > > > > AMD_PG_SUPPORT_VCN_DPG)
> > > > > > > || diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > > > > > > index 7b7c3bc9f046..0c189063a6ab 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > > > > > > @@ -291,7 +291,7 @@ static int vcn_v5_0_0_hw_fini(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)
> > > > > > >               if (adev->vcn.harvest_config & (1 << i))
> > > > > > >                       continue;
> > > > > > >
> > > > > > > -             cancel_delayed_work_sync(&vinst->idle_work);
> > > > > > > +             amdgpu_vcn_cancel_idle_work(vinst);
> > > > > > >
> > > > > > >               if (!amdgpu_sriov_vf(adev)) {
> > > > > > >                       if ((adev->pg_flags &
> > > > > > > AMD_PG_SUPPORT_VCN_DPG)
> > > > > > > || diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > > > > > > index c9e990ab297d..3fa553fb41d3 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > > > > > > @@ -364,7 +364,7 @@ static int vcn_v5_0_1_hw_fini(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)
> > > > > > >       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> > > > > > >               struct amdgpu_vcn_inst *vinst =3D
> > > > > > > &adev->vcn.inst[i];
> > > > > > >
> > > > > > > -             cancel_delayed_work_sync(&adev->vcn.inst[i].idl=
e_work);
> > > > > > > +
> > > > > > > + amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
> > > > > > >               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
> > > > > > >                       vinst->set_pg_state(vinst, AMD_PG_STATE=
_GATE);
> > > > > > >       }
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> > > > > > > index ed47ddd5b08c..eb13f792e25d 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> > > > > > > @@ -279,7 +279,7 @@ static int vcn_v5_0_2_hw_fini(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)
> > > > > > >       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> > > > > > >               struct amdgpu_vcn_inst *vinst =3D
> > > > > > > &adev->vcn.inst[i];
> > > > > > >
> > > > > > > -             cancel_delayed_work_sync(&adev->vcn.inst[i].idl=
e_work);
> > > > > > > +
> > > > > > > + amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
> > > > > > >               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
> > > > > > >                       vinst->set_pg_state(vinst, AMD_PG_STATE=
_GATE);
> > > > > > >       }
> > > > > > > --
> > > > > > > 2.34.1
> > > > > >
> > > > >
> > > >
> > >
> >
>

