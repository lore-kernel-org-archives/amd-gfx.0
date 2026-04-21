Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BC2F94CB3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 22:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26F9A10E929;
	Tue, 21 Apr 2026 22:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ls51CXC/";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013044.outbound.protection.outlook.com
 [40.93.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C87E10E929
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 22:11:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFB1txtVlEoWF1emN1Nh3G6TMdeIOx6phCuHnRMbn+Og+b+YpNmsCWm+pqDTLKgsWfFV8zW0FOLv4mTakH2WSUcCxe9ygcPeiGEOxUe4ssvGUzczeSQh4MmhB3oIlsbSLJfwE7v7Jcm3/zPAioyU9tUTaoBruZxbEs4GC7MXY/V7ntiIouYMTVZLdd5PaDdvE3QT5Yk9tbva9X1SGG2SwQF+CMmnrRJPXMiwpV/Pr7vc+6+DBgwsICTPzuiwyMxO2Q1zbtGPECGwQgsJIALGtqYDJQT1AJVcieXbGQ6ZyAGx5SWLz5AkwPMKhuDAf9orX1Qc7VWjg+MtVoNvve6aHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l484QeR5tWipvjtxxw9PvHa+s63Z2F88tCLZoNOpie0=;
 b=KMEJSYrW6v+BkO4cpAaMwQZFY2vRA0lnXrHoSxdGZW8Ajw3Jxk4ZnGWWVr09oGP5xKF7SI0yUwIYCuE4gaeeArAopR6vYA95quXeSQBdr42C16oFb4iMHgBw02AE/5PQ/QVXX6nb6BzJ3QtQHzkSzjvZ4PMLon2JFIpuAaLC7DGhwSd0ouZP/cS813E+WDGVHyLMJPY1t8TbtmEBsKmKjqyKpPbtAsJqwRbB9+6vneTcpMW2DK82WzUS1U1+GmhRdM9M+JMmGkpah7ZXxF5oo2Ke7kDZGoo3BXXE/ASOtWDaPRIeALEVINv/HD+aYaHvYTAjd4yI2n/0rAF57uz/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l484QeR5tWipvjtxxw9PvHa+s63Z2F88tCLZoNOpie0=;
 b=Ls51CXC/TRKPNGQuD7TbkzcpfCDAX+4BWUVM09vIn4o+f3zdbcGbLojH6Va5T2rLKoCGGVpMww/kdxPVHQswT3Nk+ODWhFHKKbMbb3k50msP8ZCO9Xra7qRtrgZ94PO46J265Vjopj4yXjJHMaq5pqvfzK5jtNjCvfTgTD9Q0f8=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.17; Tue, 21 Apr
 2026 22:11:02 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::43e3:7eec:f4e2:b0e7]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::43e3:7eec:f4e2:b0e7%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 22:11:02 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: =?iso-8859-2?Q?Timur_Krist=F3f?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Pillai, 
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>
Subject: RE: [PATCH v3] drm/amd/display: Restore analog connector support
Thread-Topic: [PATCH v3] drm/amd/display: Restore analog connector support
Thread-Index: AQHczstsLPMyDsv11UWJTaXikh+QBrXp1YXwgAAWLoCAACo/QA==
Date: Tue, 21 Apr 2026 22:11:02 +0000
Message-ID: <CY8PR12MB819381C2BCB80C0D60820617892C2@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20260418003539.1862136-1-Roman.Li@amd.com>
 <CY8PR12MB81939EDD14C03CE06C32C07D892C2@CY8PR12MB8193.namprd12.prod.outlook.com>
 <5053236.OV4Wx5bFTl@timur-max>
In-Reply-To: <5053236.OV4Wx5bFTl@timur-max>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-21T21:57:21.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|BY5PR12MB4145:EE_
x-ms-office365-filtering-correlation-id: 2c56fc04-a0c1-4c87-22de-08de9ff2e01c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: xxpzyGktCgRdbMb4h8C5djP7w+rZj3nMnD0FWFHglqEXt5TPL8iYJ6zBoOz4x3rV/tmH0rKl4jZ9j49+EXWf4A3p78+SZnRUeugi7BoGOSEJdHsxZ+UJxNlm+ZdmkdlFFh6pdY1CA4+31jxL6Gj968uec7f3NwnkpEo3z06jdQWbMgXISQ55QzXpFAxz8hBWve/Av6o7djDby8rPltYPgFf/qtgW2i+Y5DjBp6YLiLBUy3QwihH8XcDGSIUt08aca4Hm1aFcFfDAGKmcScwkYF1U81ESN6kMta/GDJ8w5sbBUveEw78dwTioK2Ws9Xm/QtDa/64iKgZdPAZwaVCyPmFO5PGXdOty3nOXFyOyXkh5yPG2cKDCbZYfZW8y7wS9k6lHOnr+YJi/cRtd0hVh8lEnyqYgefa9qj4Wue/8/Ml3NgucatmOe5Of8N+nDXOJTdmvbrrptRuyj1SEYarIBx0GVoJeaet2MjYbzRCeqnF6kcGTupt/DqC9qV9Llo5BzknKxo8TNc2WgC73u1c0lM/MkgmDCdIZFWboUvRsu7loioMuBWuy3h0fk9XTtGydgLxP/4QIH5P7DP+SBqdGWqgnDTzR9uJFLVQ/ESNGmpU6oXct3/3vsFck8EKodHVuQtuAz6ZSWCyQbotx+0/yl6az8EMwOhfeH+AIz2j4tpzTsj0w3rhbFFfq4jfsFXuAbaIHH0cnHOepzodzRuCff5u4z52tEch7Dmia1IzHAbb5HKlAR91KHcYRRDwYnY5k
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?FE9I15ytQQ39cyLJQBuTDt+kt1k1NS4QcJleprzH4tzbeHCa0T6H0Em83w?=
 =?iso-8859-2?Q?poRW6eRL4hedI1sa/2N4WWiSdutbsiQ7UO89kc6zyj9Ospn7xWFthBJmfM?=
 =?iso-8859-2?Q?YTmoPQwuuLdzcFF+shzGC/emZ+R6rvHNBXnvoIiA+Z8kyf/Ko4dM0EchKj?=
 =?iso-8859-2?Q?ICEI6WoxGoIy5i8kEFbIKjR42BEQwS5EB+XFWAHPz2Q+ZC0+sYJkjgGHh0?=
 =?iso-8859-2?Q?pBKwvRdnx+qb2iSeo1ujv+fAwN+19iVXaIPDodc3Naj2JcIsjYifpmtXzb?=
 =?iso-8859-2?Q?XFwmqz2NuW0/qKwiInEDtJ8t54ul9xuOpwJXBkxFlVMvYhQ9RdX9CNfKJb?=
 =?iso-8859-2?Q?PtUCHJ6UceRHy9WADIHV05MW9E/YDkxp1RP+Gqvlk7QuYroMIWdsYZMSB9?=
 =?iso-8859-2?Q?CYQK+H2To1GjpKaik7/J5Po0/khyX1FR9p2hhl2k0vSSsTJ4auQeKV3u8Y?=
 =?iso-8859-2?Q?pFTXMq4ZVeHZ8q9fTXmvrvjRO6CKJd25bX6RJX3hrjKrtydLjKR/KFa95i?=
 =?iso-8859-2?Q?yz0ePrOtLMcdPNi2yPkHxloAc1tjEz6jUb02o+PEhxSg7a3HIoTgj9JfwF?=
 =?iso-8859-2?Q?2IyrfdRGtoVQ7uWIP43kClhUTdFpSDmxzr8+ZV1OOK0O0lxDKfMRDivYkV?=
 =?iso-8859-2?Q?cAhrXAb9YU+4Lj8AvRnX5DH2ArunYycBel3URzdI7nE2W11RUTFJuSh55Q?=
 =?iso-8859-2?Q?guta9WYVPem3eoIqwf9o+bjL7SmR8GB0OXX1IRcGmpkMSfnPvISTSZX4bk?=
 =?iso-8859-2?Q?6WTa6LHcOuiJYGQMHxMjINj1JlAclNPkckTtFigBl2wBiBu/8pQ5MSYEj1?=
 =?iso-8859-2?Q?+j/sBsTfe36txBFImYOMJYj5yZ0pNQpoHwBuJ1LMeN5xPVYOwAgb9Vwd9V?=
 =?iso-8859-2?Q?ewVjdjPEbuLraZNjJmasv4buezuvG6LB1ZGae0I5Z9lDRu9sAGm2bRJs4c?=
 =?iso-8859-2?Q?MpklZaOrHPa1qNnbWEatsF0RMg6BdHt5H6I18xVCCUoryo4xVqKlqWWrKc?=
 =?iso-8859-2?Q?HGi+9asbaQKPEj6T3BjOJrGJ+CA8O8gj4gYpoFjkovUwJsSjHVNiK0oo7g?=
 =?iso-8859-2?Q?iLAnSc8WNZFE5TqSpMPA4r4jco96ugJpEbIgaZHZtWbQdNt2DW2jBsMAF2?=
 =?iso-8859-2?Q?DZafgR0pb4c2cDnjSwKL/aWPQ/ooBKX5aNI7fHYcPgbW2UYGexuRZtqart?=
 =?iso-8859-2?Q?X2fc63As2b3hrayy9ZRXOfOfVFTgxeYOsS6j4Unr0xjuNgvc/BaW2jIabm?=
 =?iso-8859-2?Q?rZYvwc4CH4n4/KPVQ+7IR261RQ8D0LmFdwXrg8f+k7rcQku3OB+slmFa9l?=
 =?iso-8859-2?Q?IrBnGfiyHHtr2uoVdr50UNMRy8JAHjsDxAqZWyYwYepIZ4HSqw0dixrQ1q?=
 =?iso-8859-2?Q?2KlSKr8NQ3RJo4uylMn1Y5lSczijel+L0ICqtQbFuG1DsSwNuVuQin9DwG?=
 =?iso-8859-2?Q?xMMw6sdYEEjEc+7hXK4N0a5x65KZjUu3XWyHTQo7eK2IFdg555NK/+DdRs?=
 =?iso-8859-2?Q?h1yRcGMPmdGvQlXkLy77+VaiaJSVRpkhWpxyG4BOG9IRg0icLMwomgLWlw?=
 =?iso-8859-2?Q?xRKmgkdGh8kpXzMPn9CdZNHhA6KixSFM+yET0cOGr+2rnHs8GMmCwuY6jN?=
 =?iso-8859-2?Q?7QVXJgj5gNUpGMaJ/rH3LgFE8MSTQ3zAMUmfq0ayGxLLADhwnU2TRSSOuN?=
 =?iso-8859-2?Q?mU5dO+VOZ4pZ2FKW0V9W2ENFUjFo4ue3x8uTtqCHycXvj93l63DAXmzVIQ?=
 =?iso-8859-2?Q?aEjdbjwkEZNU3Af2NDw3+jUp2XMuT8u4NJNp2SRU0M6B6p?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c56fc04-a0c1-4c87-22de-08de9ff2e01c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 22:11:02.3212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C+wIvzxO/2BXf2zi7TysjgITub98zg84I9f7ZbS/JgIN1e+Gc9vGnjLcaVgUVIra
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
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
> From: Timur Krist=F3f <timur.kristof@gmail.com>
> Sent: Tuesday, April 21, 2026 3:26 PM
> To: amd-gfx@lists.freedesktop.org; Li, Roman <Roman.Li@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wentland, Harry
> <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Pillai=
,
> Aurabindo <Aurabindo.Pillai@amd.com>; Hung, Alex <Alex.Hung@amd.com>
> Subject: Re: [PATCH v3] drm/amd/display: Restore analog connector support
>
> On 2026. =E1prilis 21., kedd 20:08:21 k=F6z=E9p-eur=F3pai ny=E1ri id=F5 L=
i, Roman wrote:
> > [Public]
> >
> > Hi Timur,
> >
> > Did you get a chance to test V3?
> >
> > Thanks,
> > Roman
>
> Hi Roman,
>
> Yes I tested it, it works fine also on Kaveri (with DP bridge encoder) an=
d other
> GPUs with a DAC encoder. Nice work, thank you!
> V3 of the patch is:
> Reviewed-by: Timur Krist=F3f <timur.kristof@gmail.com>
> Tested-by: Timur Krist=F3f <timur.kristof@gmail.com>

Thanks, Timur! The patch is merged.

>
> I noticed that there is still an issue with an Oland GPU that has a VGA c=
onnector,
> that hits an ASSERT(0) thanks to a recent HPD refactor:
> https://gitlab.freedesktop.org/agd5f/linux/-/blob/
> a1404287ad4cc349ce3f5d94ac81903db9e0351f/drivers/gpu/drm/amd/display/dc/l=
in
> k/
> link_factory.c#L608
>
> At the moment I'm not sure if we should just remove the assertion or mayb=
e other
> changes are also necessary? What do you think?

I think we should remove the assert and gracefully fall back to HPD_SOURCEI=
D_UNKNOWN for VGA connectors.
Will submit a patch after internal review.
- Roman

>
> Thanks & best regards,
> Timur
>
>

