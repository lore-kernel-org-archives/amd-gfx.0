Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC11D5B874
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 04:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D00C910E0B0;
	Tue, 29 Oct 2024 04:50:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eAhzmDPx";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E68F010E0B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 04:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpztdumJcCDTrMr6mJT5vCRqdidQ5hddYpxCGZKVL22Ob2sUMJiI5ruW/wgCdDOzHuvBsWZ+H+g51K7D9lackX4mqNVZJUFybWKKfKBrrQvew50svA6fJyJmZEwVUPYOWSLKe2ZKvELuHPvfbOWWNtUfLmkwkWOiNd/NgBSeIhJhzagmho3kcH+ZpBZ2IKsGWY9tdLC8fMQY+cWQgpFkTNn28wCo+PdxGBBICAt7nV83o8z3hnCqLrcdp0MFqbvILT1yTGyjShKZ/zFlqr3pdoapxwG5QBVF6F1ouoJ72HCdLKBQL+qf2ubIWBXkjtRcltHvch+XYDeO129BFBd+yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEmNeHJPX21SZzQKUNqNueDIMUlxUog/0fnZKhvKvbk=;
 b=DieWRnKNByXmcL7QKTKtMx1YOUeDLVDYf/h3JhkDN8OaI6epkiyvFmpKndleiRm5LRUa27F132ZixScIeMh5iRqUhZXsBSsBzIpk7Od8tCERxSRyAtiAAM58rSR77UrD5SGI8B7elZRMI4nolEVMY5QMSrrc7kJM/RAlAo3WASYhxQFsv2/WtCVGG1YmpUAVolHIiqDwebhAv1FL2WUzydApX7cIaDaoLJHsJch5kkV3BWVpsn8Q02gnw4VwcV6T1ZCSKYhfAAwQ9oU2rEuLqtFA1b5CVdMRCIAVD2C2dL5qWn2Y8qqAj0HNylUDxYLdhcyhC0qZKrPj9mhSVTJzYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEmNeHJPX21SZzQKUNqNueDIMUlxUog/0fnZKhvKvbk=;
 b=eAhzmDPxSwighSwm1s9ztnhr+fdcQeoQod9IwZ4/ANQq7tA12ohJSikmB77CBaYUEmcTSphSOtV9yOw9hvfccf997G3ped5B5KPtBhMzmWdmXK5XhFOGVlrQXpetF6GGsIJA5sSZd5YQ3U9cGyxZsCBVWRXO/ck4gvmYPtUP1p4=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by PH8PR12MB6697.namprd12.prod.outlook.com (2603:10b6:510:1cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 04:50:48 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%3]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 04:50:47 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH V3 1/5] drm/amdgpu: Add sysfs interface for gc reset mask
Thread-Topic: [PATCH V3 1/5] drm/amdgpu: Add sysfs interface for gc reset mask
Thread-Index: AQHbJeftqp22rHaPQkirmAVZzhi5B7KdJ2HAgAAF+DA=
Date: Tue, 29 Oct 2024 04:50:47 +0000
Message-ID: <CH3PR12MB8074149DAA2D6217D6FFB69CF64B2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20241024073933.2709389-1-jesse.zhang@amd.com>
 <CH3PR12MB80740FE14544C2B5AFBD8BB2F64B2@CH3PR12MB8074.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB80740FE14544C2B5AFBD8BB2F64B2@CH3PR12MB8074.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=7566df4e-db63-44ac-83a1-85ad3ea97ba9;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-29T04:18:30Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|PH8PR12MB6697:EE_
x-ms-office365-filtering-correlation-id: 1bf60012-4ad2-47f3-c01e-08dcf7d5416a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?REPDpp6GvFF3Ng1cGsECYmx+ptXVRGdj44Apj6xAwRo5X5Y+w4HqxHGv8EmA?=
 =?us-ascii?Q?xX2LyRGeEgeUYDLhw2ItKXpYfD+KnDyVtUloEeUKxCLTJ93vYmci5pK+/H6z?=
 =?us-ascii?Q?M3EBc+iWyYK3jb3IEDBcKHTrwDbkbvPnLPOst/jVzZrx1O1HpaOWebEtXDgH?=
 =?us-ascii?Q?g5UUVAFxFN5Tpjnte2EzUYbRqWheuvahugrsPFw4XQ1oyGviIE57864FPMEv?=
 =?us-ascii?Q?bPxNGY7vPJFh/HuDaewT/lSjazcwcCZzkRiv+mf602Ep1FVQcQCiWRgIOmKC?=
 =?us-ascii?Q?8ZqUCYfTeVs8wwYQFTHGZw/t2xgoHiXe0nlyrIKFdDnCZ/NntmVSikemXkle?=
 =?us-ascii?Q?mXRwteqmMBbTw83pmnGgltvDkXfz5d1SFm66AyTSrEIxU5D7LU4gXJejRzs7?=
 =?us-ascii?Q?+Be/apJcLhgzLUqD/j3W05J88jVWRGm6AiRUTlaMM5S9PT6V2FRaWUWueIEZ?=
 =?us-ascii?Q?99rxW2GHH1gdrLF/OoOA1mxo/ae/EikREPd15Tg94FB3S5LzCJvP9lVIkepe?=
 =?us-ascii?Q?8CnQSV6ByMRQ3O3qQKqXm51iBNLnB4t2n0wM1efDCFbSijopVCSYfbM+g3Du?=
 =?us-ascii?Q?ztxuiFZmSwJy+4VYBomYW9eqFt66SQRsUob2NBfNniY//27DtobCuzh3AzeK?=
 =?us-ascii?Q?MHys1/jvOxr7KRAt7vl4ZygEviyXNj/TNMkDdJwazoRPk3XXQKHPotEwcNDX?=
 =?us-ascii?Q?goPoLthxwB3nzbDFNBCC9AS4ceL4JIbAmQ8QtJkNpG3EMtThUdY6Nhb0iFnq?=
 =?us-ascii?Q?R5Ki8K7TM141kGSrmmgzFGV39Xw1ZFR3n/BSPfmUKErwKwjKIAlUWSJBAt45?=
 =?us-ascii?Q?5OXHVjnwcsxc8zCbutDSRs/SnUbir8xJ0mzNXbXtIUWLT4gxurxRg/WHqBok?=
 =?us-ascii?Q?uEAqNWKzVJ3TrCzTftLuBujtzfTQCI2K2VFMIG2yYYpBRd1kDQ4k81D2aG1w?=
 =?us-ascii?Q?9PLzS/23EEURhTXTidXlXdFbEvYXIydg4oLtVayTjbcOvvo6+kGYCQsNvrce?=
 =?us-ascii?Q?O1ENJuIVFgEAMVO/SNSbFk85kpu5SOruhmoHJz1mlM4Xp06vbw4vVzFT6mDT?=
 =?us-ascii?Q?AxapuGWxpovJp6KBHRoimgp3kE5qYFC3/k5bZl+TLDyLw5u18TRZer0hNj/P?=
 =?us-ascii?Q?sYj9gpVc8zJdyNBezNEjTwKFi+Ubmr4C+fegsEGrq8nEXKWCPJVQKb+IROHV?=
 =?us-ascii?Q?jTTbH8dbkYtBsKezQ3/tEjPcJGgkFr64YgTxYZQ1QEmGjtxIYl3YWZBT3GQA?=
 =?us-ascii?Q?56w76vXrY50laA/6khguP2y+Dc3NQrL37B/949dqDJZLYjk/sZtj6/RrsA+8?=
 =?us-ascii?Q?HL/4/EcgGwHnosY6SAuawSGG5ibLAdOu0fz4p4NxAuRqpGU4SdHvr6qzvcxH?=
 =?us-ascii?Q?y9G13Gw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tg89+lwD0urEFXt+bld8VHBZpsYaGP8Hkv7XoBavldkE36kYIxXfu8sCEP+C?=
 =?us-ascii?Q?jkYZQ+7s1wWr9CudxX4cuolx6AiTkznnHTbBr1GwClII3N1BXpPdrYJFFEle?=
 =?us-ascii?Q?zWZmZXXjow+H2L7qm60/yTI5fFpBSFqoU6DB12f28ULzSzHwSn++6GCN4PHl?=
 =?us-ascii?Q?VHOT80Y9rkD9mUKbRKznZf8Fx0FKdJHUjYlFxrzPTrPEKAnka+H0xs3i3mfz?=
 =?us-ascii?Q?qT/wMquy61envIEc2ZB65ozf/p7XRSRgdXTCrmuO4H6Z3C0HS6L0Dy4tHCX/?=
 =?us-ascii?Q?dWveff50HnZgDcEDgav1snr+bYPMtqZzXe0rLKv3QkdrNw1kcNPWzndwDdG6?=
 =?us-ascii?Q?Fc2ztzJ0BTjTYVBmFgyGePmywOeS4XWgPRx31HtghfEfsUtjQAqbV5HD6Vf2?=
 =?us-ascii?Q?D50fVvurSXc2DURlqUclqxyV2piuAC16IKhr5uRq6qS5ZSAJggL8ybUVl6yt?=
 =?us-ascii?Q?oA2Qu1HWRWuKEdoDtXxwOi+hneplbnjkhtofz4dt0+QFwlKX6gEPreYbYzTi?=
 =?us-ascii?Q?gjpZNvRh5TyiErLP+x/+tJaeCmfvTnJcU8XlUuNtlPAlSONtTvY2Z/EybriI?=
 =?us-ascii?Q?YdU+UZJBRA5EoLtqdF/7TJfnjXvqNaiIohIsMSoSlcI/0b9PEbsbrXoZQViB?=
 =?us-ascii?Q?3d9AWa/C9FhpKo+gSqSbozy8OsPbL5lJ+uHXKRobvj18ruWyLWN6SnJLYYNU?=
 =?us-ascii?Q?l3deUMdmygkRq+mJAN72Jr30VdfOTFjcCAIChacKmGSxFmGk7RQlDxfa0h1F?=
 =?us-ascii?Q?0skWr3YpxYhcKyqu6sC1G2Wqk87gN4DmEQNwrDDGXuUrJ4AJ/OP2DjMswCB0?=
 =?us-ascii?Q?qR21PKO32rPaa52QA+d/7UDEO5nJlOfXCvcIeTtypJIL5pALQ4eumPvPfC5a?=
 =?us-ascii?Q?peGMDc2nXKlAfaDq1TOviIqfi9a3nkAVOtVKwx+k1/mDrQM0Tsn6foGnNpb8?=
 =?us-ascii?Q?QFxsV38sB7qIOJWdYLl8XoRnw2XG5U+ff8AQzTcpp8Bb22ZsX/zxuVTVVnK+?=
 =?us-ascii?Q?uYA27KEd0NflzXmEsGTj7FpeWvBAg7xk86140JidAuDY++K7P6KogoZM+s1E?=
 =?us-ascii?Q?yLD8e8hsQUJeLvKg5V0ufjU7mbimwXh/G6PyRGn0IArNnTOpzrCl6onBwkiQ?=
 =?us-ascii?Q?D2Amc+ujq/V06ULMwQgEPYmZhw2dLZeG4Ds2mSk/io/NH35JAYDLQlhxv/Bf?=
 =?us-ascii?Q?O+ekUB7b6eblZXr1ocd6shAAudmimO+fP/nE3fjI8gxCW8cqK1bEun1Xrwgv?=
 =?us-ascii?Q?SOxPvzWb6aNep6rywCJ4ufH+015U/xbbdyq5cg+0XwzN8bGtAZYBMM6nyZzh?=
 =?us-ascii?Q?ZDEAabN5u6ru5wDm4poKFiJmEtBv7IBFh60oY1DtqFueCsIsGKCuk0hyWbUe?=
 =?us-ascii?Q?enFE3nBsuRltQRXP9dYRCALwTOFyYLCi3yEuzxggx3gtlJ9/Y4H2La4CUqFG?=
 =?us-ascii?Q?NrfR8m9ziDgps9hMzUv+5dgjxSUkkliN4AE2TslhZ70etpYv6voBHAjSaMoA?=
 =?us-ascii?Q?Kj4NoGnLNk+S6tVQvKOMdtTGGxMJeDsKpYcgiVYx2GCxgJ9/B2wk2WxBde5t?=
 =?us-ascii?Q?9kalLZUaatuJ/HPysEk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf60012-4ad2-47f3-c01e-08dcf7d5416a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 04:50:47.6969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DxZT+59heVBn6ItvDreBQWsOmZkNlc8l/CEw9UocJWMUx15YQvtyosSfWs9lGTO4jYHaJdNQI8FSeJjzkTHZkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6697
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

Hi Jesse,

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Huang,
> Tim
> Sent: Tuesday, October 29, 2024 12:21 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.or=
g
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: RE: [PATCH V3 1/5] drm/amdgpu: Add sysfs interface for gc reset
> mask
>
> [Public]
>
> [Public]
>
> Hi Jesse,
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Jesse.zhang@amd.com
> > Sent: Thursday, October 24, 2024 3:39 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> > Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> > Subject: [PATCH V3 1/5] drm/amdgpu: Add sysfs interface for gc reset
> > mask
> >
> > Add two sysfs interfaces for gfx and compute:
> > gfx_reset_mask
> > compute_reset_mask
> >
> > These interfaces are read-only and show the resets supported by the IP.
> > For example, full adapter reset (mode1/mode2/BACO/etc), soft reset,
> > queue reset, and pipe reset.
> >
> > V2: the sysfs node returns a text string instead of some flags
> > (Christian)
> > v3: add a generic helper which takes the ring as parameter
> >     and print the strings in the order they are applied (Christian)
> >
> >     check amdgpu_gpu_recovery  before creating sysfs file itself,
> >     and initialize supported_reset_types in IP version files (Lijo)
> >
> > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com> Suggested-by:Alex
> > Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  8 +++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 66
> > ++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  4 ++
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  6 ++
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 14 +++++
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 12 ++++
> >  7 files changed, 147 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index 48c9b9b06905..aea1031d7b84 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -300,6 +300,12 @@ extern int amdgpu_wbrf;
> >  #define AMDGPU_RESET_VCE                     (1 << 13)
> >  #define AMDGPU_RESET_VCE1                    (1 << 14)
> >
> > +/* reset mask */
> > +#define AMDGPU_RESET_TYPE_FULL (1 << 0) /* full adapter reset,
> > +mode1/mode2/BACO/etc. */ #define AMDGPU_RESET_TYPE_SOFT_RESET
> (1
> > << 1)
> > +/* IP level soft reset */ #define AMDGPU_RESET_TYPE_PER_QUEUE (1 <<
> > +2)
> > +/* per queue */ #define AMDGPU_RESET_TYPE_PER_PIPE (1 << 3) /* per
> > +pipe */
> > +
> >  /* max cursor sizes (in pixels) */
> >  #define CIK_CURSOR_WIDTH 128
> >  #define CIK_CURSOR_HEIGHT 128
> > @@ -1466,6 +1472,8 @@ struct dma_fence
> *amdgpu_device_get_gang(struct
> > amdgpu_device *adev);  struct dma_fence
> > *amdgpu_device_switch_gang(struct amdgpu_device *adev,
> >                                           struct dma_fence *gang);
> > bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev);
> > +ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring);
> > +ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
> >
> >  /* atpx handler */
> >  #if defined(CONFIG_VGA_SWITCHEROO)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index ef715b2bbcdb..cd1e3f018893 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -6684,3 +6684,40 @@ uint32_t amdgpu_device_wait_on_rreg(struct
> > amdgpu_device *adev,
> >       }
> >       return ret;
> >  }
> > +
> > +ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring) {
> > +     ssize_t size =3D 0;
> > +
> > +     if (!ring)
> > +             return size;
> > +
> > +     if (amdgpu_device_should_recover_gpu(ring->adev))
> > +             size |=3D AMDGPU_RESET_TYPE_FULL;
> > +
> > +     if (unlikely(!ring->adev->debug_disable_soft_recovery) &&
> > +         !amdgpu_sriov_vf(ring->adev) && ring->funcs->soft_recovery)
> > +             size |=3D AMDGPU_RESET_TYPE_SOFT_RESET;
> > +
> > +     return size;
> > +}
> > +
> > +ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset) {
> > +     ssize_t size =3D 0;
> > +
> > +     if (supported_reset & AMDGPU_RESET_TYPE_SOFT_RESET)
> > +             size +=3D sysfs_emit_at(buf, size, "soft ");
> > +
> > +     if (supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE)
> > +             size +=3D sysfs_emit_at(buf, size, "queue ");
> > +
> > +     if (supported_reset & AMDGPU_RESET_TYPE_PER_PIPE)
> > +             size +=3D sysfs_emit_at(buf, size, "pipe ");
> > +
> > +     if (supported_reset & AMDGPU_RESET_TYPE_FULL)
> > +             size +=3D sysfs_emit_at(buf, size, "full ");
> > +
> > +     size +=3D sysfs_emit_at(buf, size, "\n");
> > +     return size;
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > index e96984c53e72..6de1f3bf6863 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -1588,6 +1588,32 @@ static ssize_t
> > amdgpu_gfx_set_enforce_isolation(struct device *dev,
> >       return count;
> >  }
> >
> > +static ssize_t amdgpu_gfx_get_gfx_reset_mask(struct device *dev,
> > +                                             struct
> device_attribute *attr,
> > +                                             char *buf) {
> > +     struct drm_device *ddev =3D dev_get_drvdata(dev);
> > +     struct amdgpu_device *adev =3D drm_to_adev(ddev);
> > +
> > +     if (!adev)
> > +             return -ENODEV;
> > +
> > +     return amdgpu_show_reset_mask(buf,
> > + adev->gfx.gfx_supported_reset); }
> > +
> > +static ssize_t amdgpu_gfx_get_compute_reset_mask(struct device *dev,
> > +                                             struct
> device_attribute *attr,
> > +                                             char *buf) {
> > +     struct drm_device *ddev =3D dev_get_drvdata(dev);
> > +     struct amdgpu_device *adev =3D drm_to_adev(ddev);
> > +
> > +     if (!adev)
> > +             return -ENODEV;
> > +
> > +     return amdgpu_show_reset_mask(buf,
> > adev->gfx.compute_supported_reset);
> > +}
> > +
> >  static DEVICE_ATTR(run_cleaner_shader, 0200,
> >                  NULL, amdgpu_gfx_set_run_cleaner_shader);
> >
> > @@ -1602,6 +1628,12 @@ static DEVICE_ATTR(current_compute_partition,
> > 0644,  static DEVICE_ATTR(available_compute_partition, 0444,
> >                  amdgpu_gfx_get_available_compute_partition, NULL);
> >
> > +static DEVICE_ATTR(gfx_reset_mask, 0444,
> > +                amdgpu_gfx_get_gfx_reset_mask, NULL);
> > +
> > +static DEVICE_ATTR(compute_reset_mask, 0444,
> > +                amdgpu_gfx_get_compute_reset_mask, NULL);
> > +
> >  int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)  {
> >       struct amdgpu_xcp_mgr *xcp_mgr =3D adev->xcp_mgr; @@ -1702,6
> > +1734,40 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device
> > *adev,
> >                           cleaner_shader_size);  }
> >
> > +int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev) {
> > +     int r =3D 0;
> > +
> > +     if (!amdgpu_gpu_recovery)
> > +             return r;
> > +
> > +     if (adev->gfx.num_gfx_rings) {
> > +             r =3D device_create_file(adev->dev,
> &dev_attr_gfx_reset_mask);
> > +             if (r)
> > +                     return r;
> > +     }
> > +
> > +     if (adev->gfx.num_compute_rings) {
> > +             r =3D device_create_file(adev->dev,
> &dev_attr_compute_reset_mask);
> > +             if (r)
> > +                     return r;
> > +     }
> > +
> > +     return r;
> > +}
> > +
> > +void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev) {
> > +     if (!amdgpu_gpu_recovery)
> > +             return;
> > +
> > +     if (adev->gfx.num_gfx_rings)
> > +             device_remove_file(adev->dev, &dev_attr_gfx_reset_mask);
> > +
> > +     if (adev->gfx.num_compute_rings)
> > +             device_remove_file(adev->dev,
> > + &dev_attr_compute_reset_mask); }
> > +
> >  /**
> >   * amdgpu_gfx_kfd_sch_ctrl - Control the KFD scheduler from the KGD
> > (Graphics Driver)
> >   * @adev: amdgpu_device pointer
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > index f710178a21bc..fb0e1adf6766 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -424,6 +424,8 @@ struct amdgpu_gfx {
> >       /* reset mask */
> >       uint32_t                        grbm_soft_reset;
> >       uint32_t                        srbm_soft_reset;
> > +     uint32_t                        gfx_supported_reset;
> > +     uint32_t                        compute_supported_reset;
> >
> >       /* gfx off */
> >       bool                            gfx_off_state;      /* true:
> > enabled, false: disabled */
> > @@ -582,6 +584,8 @@ void amdgpu_gfx_sysfs_isolation_shader_fini(struct
> > amdgpu_device *adev);  void
> > amdgpu_gfx_enforce_isolation_handler(struct
> > work_struct *work);  void
> > amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
> > void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring
> > *ring);
> > +int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev);
> > +void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev);
> >
> >  static inline const char *amdgpu_gfx_compute_mode_desc(int mode)  {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > index 9da95b25e158..446e37768397 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>
> Here may miss the reset_mask_int and reset_mask_fini for gfx_v10.
>
>
> Best Regards
> Tim
>
> > @@ -4806,6 +4806,9 @@ static int gfx_v10_0_sw_init(struct
> > amdgpu_ip_block *ip_block)
> >                       }
> >               }
> >       }
> > +     /* TODO: Check the version that supports fully queue reset */
> > +     adev->gfx.gfx_supported_reset |=3D
> > +             amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> >
> >       ring_id =3D 0;
> >       /* set up the compute queues - allocate horizontally across
> > pipes */ @@
> > -4825,6 +4828,9 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block
> > *ip_block)
> >                       }
> >               }
> >       }
> > +     /* TODO: Check the version that supports fully queue reset */
> > +     adev->gfx.compute_supported_reset |=3D
> > +
> > + amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
> >
> >       r =3D amdgpu_gfx_kiq_init(adev, GFX10_MEC_HPD_SIZE, 0);
> >       if (r) {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > index 5aff8f72de9c..3b23402dfb47 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -1560,6 +1560,11 @@ static int gfx_v11_0_sw_init(struct
> > amdgpu_ip_block *ip_block)
> >               adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D
> > &userq_mes_v11_0_funcs;
> >               adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D
> > &userq_mes_v11_0_funcs;  #endif
> > +             if ((adev->gfx.me_fw_version >=3D 2280) &&
> > +                 (adev->gfx.mec_fw_version >=3D 2410)) {
> > +                     adev->gfx.compute_supported_reset =3D
> > AMDGPU_RESET_TYPE_PER_QUEUE;
> > +                     adev->gfx.gfx_supported_reset =3D
> > AMDGPU_RESET_TYPE_PER_QUEUE;
> > +             }
> >               break;
> >       case IP_VERSION(11, 0, 1):
> >       case IP_VERSION(11, 0, 4):
> > @@ -1663,6 +1668,8 @@ static int gfx_v11_0_sw_init(struct
> > amdgpu_ip_block *ip_block)
> >                       }
> >               }
> >       }
> > +     adev->gfx.gfx_supported_reset |=3D
> > +             amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> >
> >       ring_id =3D 0;
> >       /* set up the compute queues - allocate horizontally across
> > pipes */ @@
> > -1682,6 +1689,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block
> > *ip_block)
> >                       }
> >               }
> >       }
> > +     adev->gfx.compute_supported_reset |=3D
> > +
> > + amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
> >
> >       if (!adev->enable_mes_kiq) {
> >               r =3D amdgpu_gfx_kiq_init(adev, GFX11_MEC_HPD_SIZE, 0);
> @@
> > -1721,6 +1730,10 @@ static int gfx_v11_0_sw_init(struct
> > amdgpu_ip_block
> > *ip_block)
> >       if (r)
> >               return r;
> >
> > +     r =3D amdgpu_gfx_sysfs_reset_mask_init (adev);
> > +     if (r)
> > +             return r;
> > +
> >       return 0;
> >  }
> >
> > @@ -1783,6 +1796,7 @@ static int gfx_v11_0_sw_fini(struct
> > amdgpu_ip_block *ip_block)
> >       gfx_v11_0_free_microcode(adev);
> >
> >       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> > +     amdgpu_gfx_sysfs_reset_mask_fini(adev);
> >
> >       kfree(adev->gfx.ip_dump_core);
> >       kfree(adev->gfx.ip_dump_compute_queues);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > index 016290f00592..b9d5a79ba85c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > @@ -1067,6 +1067,11 @@ static int gfx_v9_4_3_sw_init(struct
> > amdgpu_ip_block *ip_block)
> >                               dev_err(adev->dev, "Failed to initialize
> cleaner shader\n");
> >                       }
> >               }
> > +
> > +             if (adev->gfx.mec_fw_version >=3D 155) {
> > +                     adev->gfx.compute_supported_reset =3D
> > AMDGPU_RESET_TYPE_PER_QUEUE;
> > +                     adev->gfx.compute_supported_reset |=3D
> > AMDGPU_RESET_TYPE_PER_PIPE;
> > +             }
> >               break;
> >       default:
> >               adev->gfx.enable_cleaner_shader =3D false; @@ -1157,6
> > +1162,9 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block
> *ip_block)
> >                       return r;
> >       }
> >
> > +     adev->gfx.compute_supported_reset |=3D
> > +
> > + amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);

May careful handling is required for the initialization of `adev->gfx.gfx_s=
upported_reset` and `adev->gfx.compute_supported_reset`. For instance, in `=
gfx_v9`, `adev->gfx.gfx_supported_reset` is not initialized, yet the sysfs =
file should be created by `amdgpu_gfx_sysfs_reset_mask_init`. Additionally,=
 `adev->gfx.compute_supported_reset` may perform a bitwise OR operation wit=
h an uninitialized value when adev->gfx.mec_fw_version < 155.

Best Regards
Tim Huang

> > +
> >       r =3D gfx_v9_4_3_gpu_early_init(adev);
> >       if (r)
> >               return r;
> > @@ -1175,6 +1183,9 @@ static int gfx_v9_4_3_sw_init(struct
> > amdgpu_ip_block *ip_block)
> >       if (r)
> >               return r;
> >
> > +     r =3D amdgpu_gfx_sysfs_reset_mask_init(adev);
> > +     if (r)
> > +             return r;
> >       return 0;
> >  }
> >
> > @@ -1200,6 +1211,7 @@ static int gfx_v9_4_3_sw_fini(struct
> > amdgpu_ip_block *ip_block)
> >       gfx_v9_4_3_free_microcode(adev);
> >       amdgpu_gfx_sysfs_fini(adev);
> >       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> > +     amdgpu_gfx_sysfs_reset_mask_fini(adev);
> >
> >       kfree(adev->gfx.ip_dump_core);
> >       kfree(adev->gfx.ip_dump_compute_queues);
> > --
> > 2.25.1

