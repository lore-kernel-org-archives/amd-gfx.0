Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42E0D13C1E
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 14:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5916C10E443;
	Mon, 26 Jan 2026 14:37:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aEdK3sSN";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013057.outbound.protection.outlook.com
 [40.93.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 224D310E443
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 14:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2pWlCkfVw27CTq0KIfV5nM0rC2Y2AWc1jKaWhPdvaD7AJIDmvNxYMdVkSRPo+Zq1ZJcIeN1XekamG3vX/psjLsZxf9h5YRfXGVe/eu/uHaae/F3HM8/qc3xpppcADsk4uUqu6EXan+45/8EnINIFWTY6YOi0+jbiedJt+FDa1WGFWGSSqwEYLyPLFCNqEt8VZ6X6nXqjW5wPoVLaDCE7hk/4rJOaIxIlsPM5epnp2eMDlJcbXW7ASeyoyZQ24tAXeSwZbVSzqJQyvO89w+jjju5ZHnhy2gfdFDcOVNq6jYnqIG0TkUWYuHZjmmCneB7NCX8NealsaJhrtMIRmS3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88luzTy7JTYWOAwkB9gefEvEfhtGHZ3/alCRqgsK23A=;
 b=I43jxt3JGJwd8BY9Ls03paMG8esVqmetoBQ+cASo7H8yh3/60cCKq3CEiPVvFg2EiSCQ+MF4EQSREaxWDv5Hynd34q4SE6+iC8yPO2a5XkS13Aspr6lr3HDZC50Urpj1W2VlJ5AS2xv5JH3fLyhtaM+/5V3ZcjFLvrtHWTGVVEFtfsgZRtK1v3F/u1+wbycfzW9vztkeO55ng9lBahu8NX5QLY4gaGyC43bKoCB4fCpdIh6PI/kaaBpmniBwqTNj3uKr3ERArVQsbkvGZ9fUKPfAW0YUVzIAdWrr0mzDKLYOXFCMxNnhBGRsQchw7bCNQjP0L+xS/BQfMKdAKHEtGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88luzTy7JTYWOAwkB9gefEvEfhtGHZ3/alCRqgsK23A=;
 b=aEdK3sSNXLrPx2R/UTYVkev5mhcXM9w/GGBAKsjMge4sUfA0BRg9CmFORVSq+bP2JtiCSoV+uL8oVtavQz/sIcwoECiWsepriIoPTpUPsekYFrKTjSy4Y8iKw/7nPNos7lgiCObzbllMidGZraaNNthsVFmg+e/mjePR+p8grLg=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SJ0PR12MB6989.namprd12.prod.outlook.com (2603:10b6:a03:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 14:37:50 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 14:37:50 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>
Subject: RE: [PATCH 00/13] DC Patches for 26 Jan 2026
Thread-Topic: [PATCH 00/13] DC Patches for 26 Jan 2026
Thread-Index: AQHciyXmEiX5nxMtSkWjJR15tX4XwbVkjAEw
Date: Mon, 26 Jan 2026 14:37:49 +0000
Message-ID: <DS0PR12MB653492426527A380A2D46C979C93A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260121223247.186241-1-aurabindo.pillai@amd.com>
In-Reply-To: <20260121223247.186241-1-aurabindo.pillai@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-26T14:36:55.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SJ0PR12MB6989:EE_
x-ms-office365-filtering-correlation-id: b8684c34-db39-4b5f-7493-08de5ce87aff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?w1dfwo2jbc14pjusLGLm91dkiksI6vAMktonf5zfaiE5ZJPADOCy6cZBzI?=
 =?iso-8859-1?Q?DF8XYcPkTkooP8/O6JxYX/GSlVAQnfX9igVIMC2sGQ2vzKXddaX+MpkJA4?=
 =?iso-8859-1?Q?Wws9MMh5+lyBvDGYmcHeFaP4Qyh/ywv4tngIUvunZZaiGusuVMpYbs4492?=
 =?iso-8859-1?Q?AQo13Vflc4d6WRG/peN58WJgl84YBmnFyUPlP5b7w0PKCt0fZ0AZI5k/1x?=
 =?iso-8859-1?Q?3aR5UjqA9XW+QrcEXGyB1qjQaAKgGLH6t6J/nx1zR3MvxNn4IF8Ww5nbSd?=
 =?iso-8859-1?Q?HQkEOqGR2pY1/BbobRCpKS4bhQgkWxsj3iXTZOkuZ+vw2hUKK9IM5Pm3sJ?=
 =?iso-8859-1?Q?n4HyF5bxpFDWegFeFkyUZ5Tktgr2WHIcrEPBiXPp6//UeLAQr3GReuQlEK?=
 =?iso-8859-1?Q?F6I0WU+6wR0KoIj6Fmz3Vyr99JNjMqGj19LT6TdxHjVuZyVhaOlO0WqQ+v?=
 =?iso-8859-1?Q?mfHGdHWsAMw0TlVomjw51IdpOx/wze+tUZ2xllSa6BNzjoqOCUIXGoMPiq?=
 =?iso-8859-1?Q?gJMGPVbZPS0YpzvxzwUcH3WCnbZfIbtFf1PulTfG+cCUcbr+UcGnJrGaZ9?=
 =?iso-8859-1?Q?Iqlf2SSECgG9TBUshicO9SlXrzxwKNodmuDupKe8v60sJQjUnKLL/pBmwU?=
 =?iso-8859-1?Q?tHEVVToIxev62si/UIvGSnkfLQcpS3m6MxDuscjq/YGdnGfF240H+/uLpT?=
 =?iso-8859-1?Q?7Ev8eX+SQJAX7kjrGgGBiY8HHPPXTilc034jw2yE8ifpXRkXvmwau3ndcS?=
 =?iso-8859-1?Q?mVOaoACDiBZaSVTJCGyC3dznZuj56tJMh1FmrhpoUGgMbp99Q+lYJJzw/Z?=
 =?iso-8859-1?Q?TrtpW3i6pvWYJJpNSK2+7EwUnJiiUAtdssMl+QiiK4uQE4lyKH0FvU7qSq?=
 =?iso-8859-1?Q?1M4WK+4Xf30LDe0k8iBBnu/w49cPVBSKj7IIwkgPKAP1m6WGyTVkgbkEI0?=
 =?iso-8859-1?Q?6wsuzUokhrlScIsBLkz2n8XqtSgxEG9WEBBj6gpnpSki4yhpK6vAd2UNsy?=
 =?iso-8859-1?Q?lB1Dk0opuKTnS1Fy7PXR6d5d5g1MpQwSKaoQp2N6ez049SwGaWnTsnxEdo?=
 =?iso-8859-1?Q?rIMxvbgBDQDuVnTrp6y39gks/U5OWYtNurLnOqOUotfZBNroBOskAYBvIB?=
 =?iso-8859-1?Q?Ryxch6ehWDq7vwUlFdrYQj8AAek3Ayyg7G7kaQ2wcuNi/3C4x2qu4uXdPL?=
 =?iso-8859-1?Q?B/c64+lQOidgk8thRhxEWJdYQ2gLzgQCiXEzahbC2vByNqu6+NuWw0nYFM?=
 =?iso-8859-1?Q?S6AzrHVk0Ap0Hbp+/6obOmrOy5N1bMi55uVdxVyygug8dSR8oyplWO1GEa?=
 =?iso-8859-1?Q?OTZuiDMKdfx32+OlBSHM/Ll4oFLT/7bO75adlzJHPhXo6tYC8Qo0UEmryP?=
 =?iso-8859-1?Q?b9Ay0qMrN7RKYIoP4bfT/PgxGku1qHktU+1oRpA0gcVCrV6K+V9aBIwh2O?=
 =?iso-8859-1?Q?96ex6D2zwgsarXeGDDXbt+Uat/GJEUZe20X8jXrbgwZ308o+YEozdnqivJ?=
 =?iso-8859-1?Q?k6bzjc89GEaKNZA5QcsKWdUCdNpB7GQcbILXzAfpiFid2SGun9eVityL3H?=
 =?iso-8859-1?Q?MT+1XGuudZRq002HEYJTq2hS477rbLs54g/sEJD1E0+7hGDojDU8Mr/eYH?=
 =?iso-8859-1?Q?ieuoZfQaJXcWGBOkMpo1iaf38vudqySk4LpbE20uWAE/WAGLAxtzxQM11d?=
 =?iso-8859-1?Q?UG0YEOlzWd7rADyYDP8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lI2yQzjP2UX2urSHzkKctvErUDFfD1Uk5fz6Fwr9wSyLKsYfLqq3+iVNTt?=
 =?iso-8859-1?Q?xiYlC758XHJd/8REsXgN/f6r23EzWsI1LCfZxNSPOwciCGN+nvIRGTqOsY?=
 =?iso-8859-1?Q?PAzOvk1yfqkVAQQhZ5asvNoT0FJFGxRmzZVVPN40GKjZHtnmZdeFZHuuQ+?=
 =?iso-8859-1?Q?UeyuSF/PL5yf+pG2tWcAdr1DpxJBok3BAx90ee9UmP/TdBU7F87m7Iy4Re?=
 =?iso-8859-1?Q?wXgHf/5uC3/eOkTHXrWbfg2bQLtzg/IbEN4+xHBjAsRcUd0+PESdyT4Zgz?=
 =?iso-8859-1?Q?tnN0wFeBbPIwsRi/kDTXwPGmBQK9+kD7/p9DTEctFYewqqLZ07E6Ov5pip?=
 =?iso-8859-1?Q?WPhPhklof1nmucfcytT6omGWQmolS64NmO76GR50QJqRon6lFN/S9g7flO?=
 =?iso-8859-1?Q?dKctNEUjAQ11AGLY/fmGvo9pzSgPVbcACyQ2Ca2ULoUWcTIYUsiq1WrAe8?=
 =?iso-8859-1?Q?w6V+vSvqYfk+DYdbvq5gA5gTzsSxiUgIweLQX8d4DWS55OxBKxul0W83BP?=
 =?iso-8859-1?Q?qPsd9aaZGxY23awhxuoo156bKT1HMOTYucwKj7BriCIYsyTZfQyA5sGNqQ?=
 =?iso-8859-1?Q?ZQsYdmGpwRt/2QRbTAImInBraTwYxq5dc+lOd2KLDHCvaAA6ed46THnqI8?=
 =?iso-8859-1?Q?Ojiknl5xSnDJbzEDQh0R2uYSWIMosWR4tNokMkxaAmOy7VK0cdiriokU1G?=
 =?iso-8859-1?Q?Mn4cQ4R8o+YVHPUw9bMm7gc24W6WAeC54bUYwi0uJiQvybARRv3LvfZjr7?=
 =?iso-8859-1?Q?thb7quDRJ5GlHHq6ssyAV3yi8PyE02GxyhQJTyyzVPd4NUC1zVEf26UKbw?=
 =?iso-8859-1?Q?/Uuu2UMAOuSXFAHTxwVxSfYdZeISPm7fQj9mngh5nq4wXMoc3blGJ1cE3X?=
 =?iso-8859-1?Q?e3g7B1U/5kyP8fBox81gCHo4xfMWR02xDJ7q0vbd0pwvhXkasF6cUExe7U?=
 =?iso-8859-1?Q?94y9diD0/2LlvyhhoJMUyquZqIs9sCi5RhNZ37ibneQDyj6tWucG1bPOUP?=
 =?iso-8859-1?Q?IOqBciNY4WmGaH38xKqmWwyAXi48ilLuJc4nLFf58RyRlneBQKRdps0wAm?=
 =?iso-8859-1?Q?oif89MbiB6vwEWjM0io76TzHmGK/cOJuFSKps9Ya4QDw/WBkU3hjv/wbF+?=
 =?iso-8859-1?Q?g96oeAVRL2TqN8mztRs+UD/wCYSS/oA7/Aq0Zpt+vAZ8+NRlrDa+nxWl//?=
 =?iso-8859-1?Q?AvPAOorWDun0avMlf2FyYw4j1xIS+Gz6qP4xPmrO67fiVVR/x+qzhY3s3l?=
 =?iso-8859-1?Q?xvMXTcGkr3+hnEXrRnzdUh1OPbcE99PdpdnVywt80U9S++y30/c7AEK7R/?=
 =?iso-8859-1?Q?u9BO+j+BzZqcjW29wjpXxncJBo9POxBBDvO+VBjGJJy44B4pPV9IiIi0Pa?=
 =?iso-8859-1?Q?krMlG0dC3mG0zF33c7yxdjpJKOkykfhOdmANEGFrxB+p1pR+cDo/ZtGwtM?=
 =?iso-8859-1?Q?WWblcSd8pa7J6rrzF0h+2Z4eGi73u+ljykUp6KTQyHLDdCeXTPq2jAU3ve?=
 =?iso-8859-1?Q?emF/LCvfduL9MrHkv6MHCbVZ6CFme6cxJGjEGQQ8ypUoq1HSjj1rqJFo6H?=
 =?iso-8859-1?Q?OYKuqrCJAHYKTG7ilGvR2he6j5rtOwuQxf4NoI3P8LSHsAYwhw3KPhfzM2?=
 =?iso-8859-1?Q?qyH7eVrg7l4qUbW2HEWZHrjIndvOCcvggbC2XsCxDz8rDWS1OpFltzzi8G?=
 =?iso-8859-1?Q?VmIBlmCCPvuinscIc5NgS74DtuHIDOlluFvcCL7jv3Ao6b53lomcI8YJ7n?=
 =?iso-8859-1?Q?fD5H482rJEWIY/hjJFtO81jN69TEUEcqrlWRTu5TGU8Yxm?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8684c34-db39-4b5f-7493-08de5ce87aff
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 14:37:49.8410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qyGXfdSh7ofdbg+/+84qKEIzOtcrnmPA7Hr8gqwZoM4MKtmIHiTtsm1lssKBTGzZbcnAOmk0bAg6uUoAdOIrsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6989
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

Hi all,

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 1920x1200 165hz, 3840x2400 60hz
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * MST DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz disp=
lays, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * SST PCON -> Club3D CAC-1085 + 1x 4k 144hz, FRL3, at a max resolut=
ion supported by the dongle of 4k 120hz YUV420 12bpc.
        * MST PCON -> 1x 4k 144hz, FRL3, at a max resolution supported by t=
he adapter of 4k 120hz RGB 8bpc.

DGPU
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * MST DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz d=
isplays)

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to)
        * Changing display configurations and settings
        * Video/Audio playback
        * Benchmark testing
        * Suspend/Resume testing
        * Feature testing (Freesync, HDCP, etc.)

Automated testing includes (but is not limited to)
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The testing is mainly tested on the following displays, but occasionally th=
ere are tests with other displays
        * Samsung G8 Neo 4k240hz
        * Samsung QN55QN95B 4k 120hz
        * Acer XV322QKKV 4k144hz
        * HP U27 4k Wireless 4k60hz
        * LG 27UD58B 4k60hz
        * LG 32UN650WA 4k60hz
        * LG Ultrafine 5k 5k60hz
        * AU Optronics B140HAN01.1 1080p 60hz eDP
        * AU Optronics B160UAN01.J 1920x1200 165hz eDP
        * Samsung ATNA60YV02-0 3840x2400 60Hz OLED eDP


The patchset consists of the amd-staging-drm-next branch (Head commit - 820=
63f2a46b33313b089e5a182789ea337bc95ee -> drm/amd/display: extend delta clam=
ping logic to CM3 LUT helper) with new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using Gnome.

Tested-by: Dan Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com


-----Original Message-----
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Sent: Wednesday, January 21, 2026 5:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>
Subject: [PATCH 00/13] DC Patches for 26 Jan 2026

DC v3.2.367

* Fw release 0.1.44.0
* Fixes for corruption on platforms older than DCN4x.
* Bug fixes related to USB4 link training
* Fixes related to FP guard
* Debug helpers and other stability fixes.
* Some refactors to improve code quality

---

Aurabindo Pillai (1):
  drm/amd/display: perform clear update flags for all DCN asics

Bhuvanachandra Pinninti (1):
  drm/amd/display: Migrate HUBBUB register access from hwseq to hubbub
    component.

Charlene Liu (2):
  drm/amd/display: Enable vstateup hook for DCN401 to be reused
  drm/amd/display: add setup_stereo for dcn4x or later

Jack Chang (1):
  drm/amd/display: Add FR skipping CTS functions

Matthew Stewart (1):
  drm/amd/display: Fix GFX12 family constant checks

Michael Strauss (1):
  drm/amd/display: Add debug flag to override min dispclk

Muaaz Nisar (1):
  drm/amd/display: mouse event trigger to boost RR when idle

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.44.0
  drm/amd/display: Promote DC to 3.2.367

Wayne Lin (2):
  drm/amd/display: Enable bootcrc on FW side
  drm/amd/display: Remove unnecessary DC FP guard

Zhongwei (1):
  drm/amd/display: avoid dig reg access timeout on usb4 link training
    fail

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 13 +++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +-
 .../display/dc/hubbub/dcn10/dcn10_hubbub.c    | 18 ++++++
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |  4 ++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |  2 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 16 ++++--
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |  1 +
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  1 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  1 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  1 +
 .../dc/resource/dcn20/dcn20_resource.c        |  2 -
 .../dc/resource/dcn21/dcn21_resource.c        |  2 -
 .../dc/resource/dcn401/dcn401_resource.c      |  2 +-
 .../dc/resource/dcn401/dcn401_resource.h      |  2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 55 +++++++++++++++++--
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  3 +
 .../gpu/drm/amd/display/include/dpcd_defs.h   |  1 +
 21 files changed, 117 insertions(+), 23 deletions(-)

--
2.52.0

