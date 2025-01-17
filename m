Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F8DC02185
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 08:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E205C10E1F3;
	Fri, 17 Jan 2025 08:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V7WsMqlS";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D4110E1F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 08:10:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTjZlm+DHABo0BzjbzA3cgyFgZERh36RXdVn1rdoPxOVvZRlxJ0yp2xrnfUB3KSPMeEVDkNK4VEEBzrRgKfBMWwjO/XJc3Plmd7N0QmL7FkR8s1iF5mlYxjE+cegMvNkvFCjUkrezEvzxNk1KWwPENyeJHDgxwoKUyCiUC980V0oCTrZHp7c8agPJJA3W56UkQGfWTcVhsPyTu89iGWippa+9a6e8dm7fi7dc6tknENMGJ3cHmhU7ybC4vGBLqkwmEMmZ8owTpYrSELbkaazZM5aO3O8txVHh8zrkFZnETEhT3NGIBeqpVAl9FEtJPDqGVLshTj/OdkoBfy49l1FtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXbA2asa+oi4jlpG7O2pueDIVvpFpx3xGpaNFQczcnI=;
 b=r61tRrK04fSEiiD8aWslvFro7LpfkeblHR2vixwZ6gZnu0Pmn8ajy9dpyFOd00gNN5CEXEguG8A26yJpGBk/9Fb7bZeQnBdAUABK/nmgzKk/XbZn4Z7Wg7U8JarSDXpXKoauqwejcHhofrUtfEjEydl2J+mtJuWnVvYFHNgvx6zxa6if8Il+GwDANPPeozzDe9I66WO0SqkThab29GwAvfp2iEZ8dUvu1cOOTZ+N9RbcSR4cHundjzl27acwd3waKGTVLY9GxvJbcqiYXhfCzx1batQ0rmc/qbgIXtdh9c8JoZhk1aNdoGEkr8lV/D85Snqhcjn5XpdKesmeyU7H+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXbA2asa+oi4jlpG7O2pueDIVvpFpx3xGpaNFQczcnI=;
 b=V7WsMqlSyu+bnMsPSpCutHQs+GJ2ujRW8bOsw3y6SQqYEZFoNxoIxD3eY11riU3vZCXkUkGPXjwbe/iTBqoqkzMwRRCqtVzrYJVgDeX0TodQRQzPHA3pV/lHEWulObQUtEXXNk5z0Cf+regswpBh3n8T4Dr/NbOtpzIQhxTDD20=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SJ0PR12MB6966.namprd12.prod.outlook.com (2603:10b6:a03:449::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 08:10:19 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%5]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 08:10:19 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Xiao, Jack" <Jack.Xiao@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: validate process_context_addr for the MES
 shader debugger
Thread-Topic: [PATCH] drm/amdgpu: validate process_context_addr for the MES
 shader debugger
Thread-Index: AQHbZkNabNHHW0XLSUyzjxs2w46Zm7MWgskAgAKV3ECAAIAIAIABB1Xg
Date: Fri, 17 Jan 2025 08:10:19 +0000
Message-ID: <DS7PR12MB6005AE300C7D23F735A847E4FB1B2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250114051520.2917015-1-Prike.Liang@amd.com>
 <CY8PR12MB7435E8013AF15165A30B8D0585182@CY8PR12MB7435.namprd12.prod.outlook.com>
 <DS7PR12MB600558CE3227FC5817DECE92FB1A2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CY8PR12MB7435CD1D4A1E308298D1728F851A2@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7435CD1D4A1E308298D1728F851A2@CY8PR12MB7435.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Jonathan.Kim@amd.com
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=ff1206e8-ebed-451f-92c9-5ad0389420fd;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-14T17:13:09Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SJ0PR12MB6966:EE_
x-ms-office365-filtering-correlation-id: aa3cda4f-3f5a-485a-1bde-08dd36ce6204
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?tRjkKhFm3bC0VtPpGJd7xB6f4GhF4TonSQcijKE6nZOAuYgKmJ6D6VCsRCYw?=
 =?us-ascii?Q?X0bNhNzhU4ZglSlQp/knhvJiOYm7UmZCncWdPaov4LTvCmtuQeeGMAVmihFC?=
 =?us-ascii?Q?kQqUNpv0S/1YXLxVVcr65/VDu/mfJuXQaVQ80rnVa8t9Qpvp/slo+wyZmS3C?=
 =?us-ascii?Q?iZX7uqiJZMoAdWxPf9XpW5MCsNbLHlHu7Y4WCpNxXH5PepTTK18H2wSQXXOl?=
 =?us-ascii?Q?/F4jdfL57vhP1LzmUwqe/cWSGSVG1APbR8SDY5uJJPklaV5OT4TAU2V8FZ2s?=
 =?us-ascii?Q?UkXf6eChYmV6wW7Y9ywNmergMhwcc+NOJ/hgk5QU4Tvy//6zfM42bjoFS0Pv?=
 =?us-ascii?Q?LwqtQPi7US6jiO+AmZOyEEFLH16jK8zlEfDN9tEXAoEBLVvmafiV6aqZ44lf?=
 =?us-ascii?Q?NSfDQlkHtBPs/mW6rwYIFjscQIehqo3wfpI12lDn6wtFa1QAmqhy6v9f+goc?=
 =?us-ascii?Q?qBSKxGHyakRwzYNGMAjnwuvVyXdLnyw2US93MEf9DDZehLq1N0PVAVc7T5cM?=
 =?us-ascii?Q?r2qCzIsEikvMWg8tefJwax775HrUs5qZ38UzhU9zY9DfOHpLyyexb4BYF/vV?=
 =?us-ascii?Q?jpfj4257209hqU+xBnTA1eS+BV81/oNiJ1TgcGPwqcgRvEpAh3FzENu0xGKd?=
 =?us-ascii?Q?1sXTRIJepj1WSJJtZ+0+ADcsuS8q+dYSvLALhzeDVZiZ6101ZBUE+o3dsgw/?=
 =?us-ascii?Q?VDSBLsU38VTWQrR/cn6zBeTAXlypjPlnz497hK4Fg9ZNHK2rWWAcmdub9h5y?=
 =?us-ascii?Q?D/f9INE/lWt7C6msCeWT4xDTm15EgLgQSMTTJXVcdypL/y8gQquZaaDTPHIX?=
 =?us-ascii?Q?qxe1bbD/FY5wnBhrMSK6REtCYv11FFLDmxAjBt4KayKg27qYW5lMy9vDZ7FA?=
 =?us-ascii?Q?vT1Dcpi1IyM6kujrNG9sil7IatCwuPoH6VmGJXoA9W3EhoawEFIF1s7ziXB4?=
 =?us-ascii?Q?TJXusqqpYVBzXwSjAsIIG+cOSSEl1pqXiucYQzzVrVVoTuhWyhgqS2lEuhpk?=
 =?us-ascii?Q?dxRAS6D1/g34Z5MHPZsSFhkP8lV/wzoOP4MZgF7uRho0p6e8T60ECbXgO0WA?=
 =?us-ascii?Q?P2U0Xx7dsFeqGEm/jfxW5VQP1aYQNqPqTpzBtq9k/Ptk5O2M6CLvufrzLrS/?=
 =?us-ascii?Q?uNXKVidaPNFTwH3l85vg54cKRL98BqREs8x6rS4yf118KKxUACXIHQ7Rig/W?=
 =?us-ascii?Q?Y6UYSrT8+KEddAoKTX9efS2gon9ZzPwtJJs9CFIsmMrUWXSa3ocUxTB8mRH7?=
 =?us-ascii?Q?fem1ani9ptdUOjt3uOOU7wBbTOAn2AFSkc0kMt5+U2gbdXBcCPUmqmmzmGNe?=
 =?us-ascii?Q?+ifOoby47O4oqGh4HqVIYqS5cWBBAeYt/mT5UG/GSIaygyPHrFyKrS+EIQ4K?=
 =?us-ascii?Q?L1feB45Cc5AhJtZOrNd+OYV0P6OubKlgtvQMTrkufl0urQWn07naIR7IPQnj?=
 =?us-ascii?Q?5nJlUeztHeGWlz2jMwF0rfg+6UIM5vo+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IqWmgCMCQeEmlHLLs0KhGnjDNeGm7MKX7La8Eu+SzHLNy+X9L/lcWErIv9xC?=
 =?us-ascii?Q?axtkx+rhrrLoSaIlMWAQ8IlYhjU+1AmO8+UTyMYteBnIGbZv+ax16XuDO4CL?=
 =?us-ascii?Q?3x8H4BykljzDzczjP259e/txzLW4wasFI0BrE2R6kkRcexKTrWCwTMNv2geV?=
 =?us-ascii?Q?YSIf4pu9t0A9Jj7CuNtXLk2aAAFSFT10/LdZ7tQyJ+cCJEdnuwJnjQ4UI4/F?=
 =?us-ascii?Q?fHS/EzkEEHwhMchHQJt8dZoe5OolwxpWFtvauAypS84WK8hgP6rRhVovuvUR?=
 =?us-ascii?Q?uliL7/BNzKMsSHqEVpyjPENHQNAMX/QDAN+QdkhCAP/e+VfKN3u0qcmh6TlG?=
 =?us-ascii?Q?ra5sxdVtPzMGkVMzBnUwayDiI3q7WaathmPk17n7SXNRBY8WRgPhryfjpFR5?=
 =?us-ascii?Q?scn37YljfV2ALAPa4TC7Ji/CJcZSmUQYbWj1X+eL2XITBZiJVeVz8vbZnFHA?=
 =?us-ascii?Q?nxeqK/v+uGffLv2EuVzNI0S3NlvNLK7xntFnOg2I8RA8lNwjEXu/h7VzJJFf?=
 =?us-ascii?Q?CdmEK+rK+gVaS37cFrHIuDZNLLQkVWQ81xuunupFIjAvBeT8bzqhp3z8trFD?=
 =?us-ascii?Q?iGdO4yVvVXW35ZLxeI3W3nC5842NYdXq8/U+eGEwIGfqpsrdcabKcZGs+LU2?=
 =?us-ascii?Q?J4P+n9TIzAqBRlc4pGSDHs9ZyFOdmb1VCAgCoiziTe0Q64+54Kdn2rMMRNm8?=
 =?us-ascii?Q?YtoLRGLZsUmJvjrWnsdtV39oQ1RBMw0j8wOOwXIdY9oIb3SKfpIl7DGeeeE7?=
 =?us-ascii?Q?UwhT6+dL0M5C/6b0FOZl3pjnEfz0K7SIefk/NAIyGUuoFdbhv44CCLuW1b5m?=
 =?us-ascii?Q?Dkcb/3aCO4SBctevGs5a2PEo7gmmZ5gdIa9g5CEf8mr8nBLMq0Q8/+EIRKE6?=
 =?us-ascii?Q?YmdL8PXmMrUvjlZpE3Wo9vCw4qYLFROT3gCMKXrHglmmHSph3tNeOTvbt4Nu?=
 =?us-ascii?Q?wCIqjaDc9yurJl8AdplCLRo7/isuj/tqJtlnsfEbKwnnrCTLyLkB962lLahR?=
 =?us-ascii?Q?eucedRL6WGhcsyNkKTr6oIleTtyWC1Ak7FlfbeIWgpitlmlPglB42CVKHdw8?=
 =?us-ascii?Q?v2/ju6qG9dawXrpfTKVyZuCqGc0gRKtd9+p8vNxZdBPZSKTUWMd1yEv7v5sM?=
 =?us-ascii?Q?tjWNtN1I/7Aa3UuwKBhKLcK1Fj3IeUqxUqmLmg6uPrr2b37IRxJGjpmW5apo?=
 =?us-ascii?Q?0dvRi8Ar8pMe0wuITA1kkr6vFN3Ktk3hxQM5vxaZrsPHjr8Zd/sEpmiWnsmJ?=
 =?us-ascii?Q?dQx+iyFNDnuEn57U/f8S1SYh3uUbPxlGYaenbPZoAHY1vbNG2Hr1e00ZYsko?=
 =?us-ascii?Q?OaxorrKsObNaGnEZLQr3HKhKMpVKO8CWlXalGkHVXK6nE4V/8b1aeWBn1vRx?=
 =?us-ascii?Q?JDLek3Ww6zmZrTgRalwVi1/+LR4hrTzLlauJjY7oVC3Jb41qo/0fbXKhDSDI?=
 =?us-ascii?Q?UQcOOPK93KAMaX9sjxiRaE3HXU72jviGYGHoMaCmZx21W4IrWYNpQmX5TgWi?=
 =?us-ascii?Q?sp1ilI9vSCDCWEpJCFXcHEYPLDnVdV6RUkgGxrsY8FHUPi28Cv/ft0gneHIG?=
 =?us-ascii?Q?IteIdMaYEJUeXMLBgfg=3D?=
Content-Type: multipart/mixed;
 boundary="_003_DS7PR12MB6005AE300C7D23F735A847E4FB1B2DS7PR12MB6005namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3cda4f-3f5a-485a-1bde-08dd36ce6204
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 08:10:19.1700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CfMnRozqVJ3aKNIuWLUxbU65CL7IUK8PSC1UyFi2hW6c+nyJTcBRYD5vQxNQxX6V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6966
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

--_003_DS7PR12MB6005AE300C7D23F735A847E4FB1B2DS7PR12MB6005namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Friday, January 17, 2025 12:21 AM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org; Xi=
ao,
> Jack <Jack.Xiao@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>;
> Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: validate process_context_addr for the ME=
S
> shader debugger
>
> [Public]
>
> > -----Original Message-----
> > From: Liang, Prike <Prike.Liang@amd.com>
> > Sent: Thursday, January 16, 2025 4:16 AM
> > To: Kim, Jonathan <Jonathan.Kim@amd.com>;
> > amd-gfx@lists.freedesktop.org; Xiao, Jack <Jack.Xiao@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> > <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> > Subject: RE: [PATCH] drm/amdgpu: validate process_context_addr for the
> > MES shader debugger
> >
> > [Public]
> >
> > > From: Kim, Jonathan <Jonathan.Kim@amd.com>
> > > Sent: Wednesday, January 15, 2025 1:14 AM
> > > To: Liang, Prike <Prike.Liang@amd.com>;
> > > amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> > > <Felix.Kuehling@amd.com>; Koenig, Christian
> > > <Christian.Koenig@amd.com>
> > > Subject: RE: [PATCH] drm/amdgpu: validate process_context_addr for
> > > the MES shader debugger
> > >
> > > [Public]
> > >
> > > > -----Original Message-----
> > > > From: Liang, Prike <Prike.Liang@amd.com>
> > > > Sent: Tuesday, January 14, 2025 12:15 AM
> > > > To: amd-gfx@lists.freedesktop.org
> > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling,
> > > > Felix <Felix.Kuehling@amd.com>; Koenig, Christian
> > > > <Christian.Koenig@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>;
> > > > Liang, Prike <Prike.Liang@amd.com>
> > > > Subject: [PATCH] drm/amdgpu: validate process_context_addr for the
> > > > MES shader debugger
> > > >
> > > > The following page fault was observed during the exit moment of
> > > > the HIP test process. In this particular error case, the HIP test
> > > > (./MemcpyPerformance -h) does not require the AQL queue. As a
> > > > result,
> > >
> > > I don't think this has anything to do with AQL compute specifically
> > > but a quirk in the KFD where the KFD only creates the process device
> > > mes context when adding the first queue.
> > > Maybe we should move context creation from the KFD add_queue_mes
> > > call to
> > KFD
> > > process device creation when MES is supported.
>
> Looking at the git logs, the allocation got moved to queue creation recen=
tly which
> is probably why we're seeing this bug now (added Jesse).
>
> Commit description:
>     drm/amdkfd: pause autosuspend when creating pdd
>
>     When using MES creating a pdd will require talking to the GPU to
>     setup the relevant context. The code here forgot to wake up the GPU
>     in case it was in suspend, this causes KVM to EFAULT for passthrough
>     GPU for example. This issue can be masked if the GPU was woken up by
>     other things (e.g. opening the KMS node) first and have not yet gone =
to sleep.
>
>     v4: do the allocation of proc_ctx_bo in a lazy fashion
>     when the first queue is created in a process (Felix)
>
>     Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>     Reviewed-by: Yunxiang Li <Yunxiang.Li@amd.com>
>
> Maybe the solution should have been to transiently disable runtime power
> management and leave allocation where it originally was.
> set_shader_debugger (wrapper for mes flush) also gets called on debug att=
ach,
> which can be a queue-less call that requires MES process context.
> Having to remember that MES process context creation happens at the queue
> level is confusing.
>
> Jon

Thank @Kim, Jonathan for the input, if the original issue can be resolved b=
y exiting the runtime suspension at the kfd_create_process_device_data() th=
en we can revert the regression commit.

Thanks,
Prike

> >
> > I didn't look much into what queue type is created in the HIP test:
> > MemcpyPerformance, but the issue is that the KFD queue isn't created
> > when executing MemcpyPerformance -h. This means that the MES context
> > process isn't created yet in the KFD process that is released. In this
> > case, the MES queue will not be set up. Do we need to create the MES pr=
ocess
> at each KFD process creation?
> >
> > > Strangely enough KGD has an amdgpu_mes_create_process call that
> > > doesn't
> > seem
> > > to be used but does exactly this.
> >
> > Yes, it seems like dead code and may be implemented for user queue
> > cases in future usage. Maybe we can exclude
> > amdgpu_mes_create_process() and
> > amdgpu_mes_destroy_process() from compiling to reduce the kernel
> > binary size. Hi, @Xiao, Jack  could you please clarify why we need the
> > unused function
> > amdgpu_mes_create_process() here?
> >
> > > Otherwise, since the driver is always supposed to allocate and pass
> > > a valid context for any mes call, maybe it's better to do a context
> > > null check with some comments
> > in
> > > the kfd_process_dequeue_from_all_devices call to reflect this quirk.
> > >
> > Yes, I prefer to add the MES context check in the
> > kfd_process_dequeue_from_all_devices() function rather than creating
> > the MES context regardless of whether it is required to create the
> > queue at each KFD process creation.
> >
> > Thanks,
> >   Prike
> >
> >
> >
> > > Jon
> >
> >
> > >
> > > > the process_context_addr was not assigned when the KFD process was
> > > > released, ultimately leading to this page fault during the
> > > > execution of kfd_process_dequeue_from_all_devices().
> > > >
> > > > [345962.294891] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault
> > > > (src_id:0
> > > > ring:153 vmid:0 pasid:0)
> > > > [345962.295333] amdgpu 0000:03:00.0: amdgpu:   in page starting at
> address
> > > > 0x0000000000000000 from client 10
> > > > [345962.295775] amdgpu 0000:03:00.0: amdgpu:
> > > > GCVM_L2_PROTECTION_FAULT_STATUS:0x00000B33
> > > > [345962.296097] amdgpu 0000:03:00.0: amdgpu:     Faulty UTCL2 clien=
t ID:
> > CPC
> > > > (0x5)
> > > > [345962.296394] amdgpu 0000:03:00.0: amdgpu:     MORE_FAULTS: 0x1
> > > > [345962.296633] amdgpu 0000:03:00.0: amdgpu:     WALKER_ERROR: 0x1
> > > > [345962.296876] amdgpu 0000:03:00.0: amdgpu:
> PERMISSION_FAULTS:
> > 0x3
> > > > [345962.297135] amdgpu 0000:03:00.0: amdgpu:     MAPPING_ERROR:
> 0x1
> > > > [345962.297377] amdgpu 0000:03:00.0: amdgpu:     RW: 0x0
> > > > [345962.297682] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault
> > > > (src_id:0
> > > > ring:169 vmid:0 pasid:0)
> > > >
> > > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > > > index cee38bb6cfaf..4d313144cc4b 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > > > @@ -1062,6 +1062,11 @@ int amdgpu_mes_flush_shader_debugger(struct
> > > > amdgpu_device *adev,
> > > >               return -EINVAL;
> > > >       }
> > > >
> > > > +     if (!process_context_addr) {
> > > > +             dev_warn(adev->dev, "invalidated process context addr=
\n");
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > >       op_input.op =3D MES_MISC_OP_SET_SHADER_DEBUGGER;
> > > >       op_input.set_shader_debugger.process_context_addr =3D
> > > > process_context_addr;
> > > >       op_input.set_shader_debugger.flags.process_ctx_flush =3D true=
;
> > > > --
> > > > 2.34.1
> > >
> >
>


--_003_DS7PR12MB6005AE300C7D23F735A847E4FB1B2DS7PR12MB6005namp_
Content-Type: application/octet-stream;
	name="0002-drm-amdkfd-exit-runtime-suspend-for-the-PDD.patch"
Content-Description: 0002-drm-amdkfd-exit-runtime-suspend-for-the-PDD.patch
Content-Disposition: attachment;
	filename="0002-drm-amdkfd-exit-runtime-suspend-for-the-PDD.patch"; size=1822;
	creation-date="Fri, 17 Jan 2025 08:02:45 GMT";
	modification-date="Fri, 17 Jan 2025 08:10:17 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiYmFlYWVlMjU1ZmVkN2VkNDdmMGFiOTk5MDBiMjA2NzA2ZmNkNzY3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4KRGF0
ZTogRnJpLCAxNyBKYW4gMjAyNSAxNToxNjo0OSArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMi8yXSBk
cm0vYW1ka2ZkOiBleGl0IHJ1bnRpbWUgc3VzcGVuZCBmb3IgdGhlIFBERAoKVGhlIEtGRCBkZXZp
Y2UgcHJvY2VzcyByZWxpZXMgb24gdGhlIGtlcm5lbCBHRlggYWN0aXZpdHksCnNvIGl0IG5lZWRz
IHRvIHByZXZlbnQgdGhlIHJ1bnRpbWUgZnJvbSBiZWluZyBzdXNwZW5kZWQKdW50aWwgdGhlIEtG
RCBkZXZpY2UgcHJvY2VzcyBpcyB0ZXJtaW5hdGVkLgoKU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlh
bmcgPFByaWtlLkxpYW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX3Byb2Nlc3MuYyB8IDIwICsrKysrKysrKysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwg
MTQgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX3Byb2Nlc3MuYwppbmRleCA3NDg1YzBjMDg0ODMuLmU1OTA0MmI3OTU5MCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCkBAIC0xNjIwLDYgKzE2MjAsMTQg
QEAgc3RydWN0IGtmZF9wcm9jZXNzX2RldmljZSAqa2ZkX2NyZWF0ZV9wcm9jZXNzX2RldmljZV9k
YXRhKHN0cnVjdCBrZmRfbm9kZSAqZGV2LAogCXBkZC0+dXNlcl9ncHVfaWQgPSBkZXYtPmlkOwog
CWF0b21pYzY0X3NldCgmcGRkLT5ldmljdF9kdXJhdGlvbl9jb3VudGVyLCAwKTsKIAorCXJldHZh
bCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoYWRldl90b19kcm0oZGV2LT5hZGV2KS0+ZGV2KTsKKwkJ
aWYgKHJldHZhbCA8IDApIHsKKwkJCXBtX3J1bnRpbWVfcHV0X2F1dG9zdXNwZW5kKGFkZXZfdG9f
ZHJtKGRldi0+YWRldiktPmRldik7CisJCQlyZXR1cm4gRVJSX1BUUihyZXR2YWwpOworCQl9CisJ
cGRkLT5ydW50aW1lX2ludXNlID0gdHJ1ZTsKKworCiAJaWYgKGRldi0+a2ZkLT5zaGFyZWRfcmVz
b3VyY2VzLmVuYWJsZV9tZXMpIHsKIAkJcmV0dmFsID0gYW1kZ3B1X2FtZGtmZF9hbGxvY19ndHRf
bWVtKGRldi0+YWRldiwKIAkJCQkJCUFNREdQVV9NRVNfUFJPQ19DVFhfU0laRSwKQEAgLTE3NjUs
MTMgKzE3NzMsMTMgQEAgc3RydWN0IGtmZF9wcm9jZXNzX2RldmljZSAqa2ZkX2JpbmRfcHJvY2Vz
c190b19kZXZpY2Uoc3RydWN0IGtmZF9ub2RlICpkZXYsCiAJCQlwbV9ydW50aW1lX3B1dF9hdXRv
c3VzcGVuZChhZGV2X3RvX2RybShkZXYtPmFkZXYpLT5kZXYpOwogCQkJcmV0dXJuIEVSUl9QVFIo
ZXJyKTsKIAkJfQotCX0KIAotCS8qCi0JICogbWFrZSBzdXJlIHRoYXQgcnVudGltZV91c2FnZSBj
b3VudGVyIGlzIGluY3JlbWVudGVkIGp1c3Qgb25jZQotCSAqIHBlciBwZGQKLQkgKi8KLQlwZGQt
PnJ1bnRpbWVfaW51c2UgPSB0cnVlOworCQkvKgorCQkgKiBOb3Qgc3VyZSBpZiB0aGVyZSBhcmUg
c29tZSBvdGhlciBLRkQgcHJvY2Vzc2VzIGRpcmVjdGx5IGNhbGwKKwkJICogaGVyZS4gSWYgbm90
LCB0aGUgcnVudGltZSByZXN1bWUgY2FuIGJlIGNsZWFuZWQgdXAuCisJCSAqLworCQlwZGQtPnJ1
bnRpbWVfaW51c2UgPSB0cnVlOworCX0KIAogCXJldHVybiBwZGQ7CiB9Ci0tIAoyLjM0LjEKCg==

--_003_DS7PR12MB6005AE300C7D23F735A847E4FB1B2DS7PR12MB6005namp_
Content-Type: application/octet-stream;
	name="0001-Revert-drm-amdkfd-pause-autosuspend-when-creating-pd.patch"
Content-Description:  0001-Revert-drm-amdkfd-pause-autosuspend-when-creating-pd.patch
Content-Disposition: attachment;
	filename="0001-Revert-drm-amdkfd-pause-autosuspend-when-creating-pd.patch";
	size=3693; creation-date="Fri, 17 Jan 2025 08:02:44 GMT";
	modification-date="Fri, 17 Jan 2025 08:10:18 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlZjg3N2IyNGIyNWFkOWRkMmQ1ODg5Mjk4MGZmMmYwN2I3NWE2MmJlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4KRGF0
ZTogRnJpLCAxNyBKYW4gMjAyNSAxNDowNzo0NCArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMS8yXSBS
ZXZlcnQgImRybS9hbWRrZmQ6IHBhdXNlIGF1dG9zdXNwZW5kIHdoZW4gY3JlYXRpbmcgcGRkIgoK
VGhpcyBwYXRjaCBwdXRzIHRoZSBNRVMgY29udGV4dCBjcmVhdGlvbiBhdCB0aGUgTUVTIHF1ZXVl
CmNyZWF0aW9uIHBoYXNlLCB3aGljaCB3aWxsIHJlc3VsdCBpbiBhbiBpbnZhbGlkYXRlZCBNRVMg
Y29udGV4dApiZWluZyBmbHVzaGVkIHdoZW4gdGhlIEtGRCBwcm9jZXNzIGlzIHJlbGVhc2VkIHdp
dGhvdXQgcmVxdWVzdGluZwp0byBjcmVhdGUgdGhlIE1FUyBxdWV1ZS4KClRoZSBvcmlnaW5hbCBp
c3N1ZSByZWdhcmRpbmcgcnVudGltZSBzdXNwZW5zaW9uIGR1cmluZyB0aGUgUEREIGNyZWF0aW9u
Cm5lZWRzIHRvIGJlIGFkZHJlc3NlZCBieSByZXN1bWluZyB0aGUgcnVudGltZSBmb3IgdGhlIFBE
RCdzIGxpZmUgdGltZS4KClRoaXMgcmV2ZXJ0cyBjb21taXQgM2U1MTk5MTM0ZTQ3NzQ1MjU2YzNi
ZTQ0OGNhNDY2ZDA2YWNhZWJkZS4KClNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5M
aWFuZ0BhbWQuY29tPgotLS0KIC4uLi9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21h
bmFnZXIuYyB8IDE1IC0tLS0tLS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3Byb2Nlc3MuYyAgICAgIHwgMjMgKysrKysrKysrKysrKysrKystLQogMiBmaWxlcyBjaGFuZ2Vk
LCAyMSBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jCmluZGV4IGYxNTc0
OTRiZmRiMS4uZjgyMWM3NzkyYzZiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwpAQCAtMjA3LDIxICsyMDcsNiBAQCBz
dGF0aWMgaW50IGFkZF9xdWV1ZV9tZXMoc3RydWN0IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0s
IHN0cnVjdCBxdWV1ZSAqcSwKIAlpZiAoIWRvd25fcmVhZF90cnlsb2NrKCZhZGV2LT5yZXNldF9k
b21haW4tPnNlbSkpCiAJCXJldHVybiAtRUlPOwogCi0JaWYgKCFwZGQtPnByb2NfY3R4X2NwdV9w
dHIpIHsKLQkJciA9IGFtZGdwdV9hbWRrZmRfYWxsb2NfZ3R0X21lbShhZGV2LAotCQkJCUFNREdQ
VV9NRVNfUFJPQ19DVFhfU0laRSwKLQkJCQkmcGRkLT5wcm9jX2N0eF9ibywKLQkJCQkmcGRkLT5w
cm9jX2N0eF9ncHVfYWRkciwKLQkJCQkmcGRkLT5wcm9jX2N0eF9jcHVfcHRyLAotCQkJCWZhbHNl
KTsKLQkJaWYgKHIpIHsKLQkJCWRldl9lcnIoYWRldi0+ZGV2LAotCQkJCSJmYWlsZWQgdG8gYWxs
b2NhdGUgcHJvY2VzcyBjb250ZXh0IGJvXG4iKTsKLQkJCXJldHVybiByOwotCQl9Ci0JCW1lbXNl
dChwZGQtPnByb2NfY3R4X2NwdV9wdHIsIDAsIEFNREdQVV9NRVNfUFJPQ19DVFhfU0laRSk7Ci0J
fQotCiAJbWVtc2V0KCZxdWV1ZV9pbnB1dCwgMHgwLCBzaXplb2Yoc3RydWN0IG1lc19hZGRfcXVl
dWVfaW5wdXQpKTsKIAlxdWV1ZV9pbnB1dC5wcm9jZXNzX2lkID0gcGRkLT5wYXNpZDsKIAlxdWV1
ZV9pbnB1dC5wYWdlX3RhYmxlX2Jhc2VfYWRkciA9ICBxcGQtPnBhZ2VfdGFibGVfYmFzZTsKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCmluZGV4IGM3NTM3M2ZkNmVmMS4u
NzQ4NWMwYzA4NDgzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
cHJvY2Vzcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMK
QEAgLTEwNzIsOCArMTA3Miw3IEBAIHN0YXRpYyB2b2lkIGtmZF9wcm9jZXNzX2Rlc3Ryb3lfcGRk
cyhzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnApCiAKIAkJa2ZkX2ZyZWVfcHJvY2Vzc19kb29yYmVsbHMo
cGRkLT5kZXYtPmtmZCwgcGRkKTsKIAotCQlpZiAocGRkLT5kZXYtPmtmZC0+c2hhcmVkX3Jlc291
cmNlcy5lbmFibGVfbWVzICYmCi0JCQlwZGQtPnByb2NfY3R4X2NwdV9wdHIpCisJCWlmIChwZGQt
PmRldi0+a2ZkLT5zaGFyZWRfcmVzb3VyY2VzLmVuYWJsZV9tZXMpCiAJCQlhbWRncHVfYW1ka2Zk
X2ZyZWVfZ3R0X21lbShwZGQtPmRldi0+YWRldiwKIAkJCQkJCSAgICZwZGQtPnByb2NfY3R4X2Jv
KTsKIAkJLyoKQEAgLTE1OTcsNiArMTU5Niw3IEBAIHN0cnVjdCBrZmRfcHJvY2Vzc19kZXZpY2Ug
KmtmZF9jcmVhdGVfcHJvY2Vzc19kZXZpY2VfZGF0YShzdHJ1Y3Qga2ZkX25vZGUgKmRldiwKIAkJ
CQkJCQlzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnApCiB7CiAJc3RydWN0IGtmZF9wcm9jZXNzX2Rldmlj
ZSAqcGRkID0gTlVMTDsKKwlpbnQgcmV0dmFsID0gMDsKIAogCWlmIChXQVJOX09OX09OQ0UocC0+
bl9wZGRzID49IE1BWF9HUFVfSU5TVEFOQ0UpKQogCQlyZXR1cm4gTlVMTDsKQEAgLTE2MjAsNiAr
MTYyMCwyMSBAQCBzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICprZmRfY3JlYXRlX3Byb2Nlc3Nf
ZGV2aWNlX2RhdGEoc3RydWN0IGtmZF9ub2RlICpkZXYsCiAJcGRkLT51c2VyX2dwdV9pZCA9IGRl
di0+aWQ7CiAJYXRvbWljNjRfc2V0KCZwZGQtPmV2aWN0X2R1cmF0aW9uX2NvdW50ZXIsIDApOwog
CisJaWYgKGRldi0+a2ZkLT5zaGFyZWRfcmVzb3VyY2VzLmVuYWJsZV9tZXMpIHsKKwkJcmV0dmFs
ID0gYW1kZ3B1X2FtZGtmZF9hbGxvY19ndHRfbWVtKGRldi0+YWRldiwKKwkJCQkJCUFNREdQVV9N
RVNfUFJPQ19DVFhfU0laRSwKKwkJCQkJCSZwZGQtPnByb2NfY3R4X2JvLAorCQkJCQkJJnBkZC0+
cHJvY19jdHhfZ3B1X2FkZHIsCisJCQkJCQkmcGRkLT5wcm9jX2N0eF9jcHVfcHRyLAorCQkJCQkJ
ZmFsc2UpOworCQlpZiAocmV0dmFsKSB7CisJCQlkZXZfZXJyKGRldi0+YWRldi0+ZGV2LAorCQkJ
CSJmYWlsZWQgdG8gYWxsb2NhdGUgcHJvY2VzcyBjb250ZXh0IGJvXG4iKTsKKwkJCWdvdG8gZXJy
X2ZyZWVfcGRkOworCQl9CisJCW1lbXNldChwZGQtPnByb2NfY3R4X2NwdV9wdHIsIDAsIEFNREdQ
VV9NRVNfUFJPQ19DVFhfU0laRSk7CisJfQorCiAJcC0+cGRkc1twLT5uX3BkZHMrK10gPSBwZGQ7
CiAJaWYgKGtmZF9kYmdfaXNfcGVyX3ZtaWRfc3VwcG9ydGVkKHBkZC0+ZGV2KSkKIAkJcGRkLT5z
cGlfZGJnX292ZXJyaWRlID0gcGRkLT5kZXYtPmtmZDJrZ2QtPmRpc2FibGVfZGVidWdfdHJhcCgK
QEAgLTE2MzEsNiArMTY0NiwxMCBAQCBzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICprZmRfY3Jl
YXRlX3Byb2Nlc3NfZGV2aWNlX2RhdGEoc3RydWN0IGtmZF9ub2RlICpkZXYsCiAJaWRyX2luaXQo
JnBkZC0+YWxsb2NfaWRyKTsKIAogCXJldHVybiBwZGQ7CisKK2Vycl9mcmVlX3BkZDoKKwlrZnJl
ZShwZGQpOworCXJldHVybiBOVUxMOwogfQogCiAvKioKLS0gCjIuMzQuMQoK

--_003_DS7PR12MB6005AE300C7D23F735A847E4FB1B2DS7PR12MB6005namp_--
