Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B743ACCF9E3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Nov 2025 16:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 562F410E457;
	Mon, 10 Nov 2025 16:35:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bmPqFUuu";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2AD510E450
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 16:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWJXseiqdAI1S9liHuvYh7Orv359nW4xmRPCEi26ztdCfJ1VjiR4GtkhFFP44pzJAmMCkShVhySzxUd/4gW/Pkt2KvlMKTezA0o5pRurc7DeMzmoCXYRKd/yCiL3oeNk42UN2lqWjJhCyQgVBkP1DnpRpnOMcOBUNwGlpq5u8rSnY0oGwz8g0ixmwFh+krmrDOlLcP5l9VOjoTPc73wCKsLuKD/TCkSia0TjpxcwcFHMj/72FCn+AgWjGmVKO1p3ULH2EovGhAz7HRW9ov6A1zPRXM5NY5uAZPfJTryHV4nyHUUbePN2iJ2T2OZHqKmBBGrx6iTC1Zw5ZHXfoJOyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVay1zoE9OxKsN0tHjjuYERuUtcHrP2NXgbZsqvfgnE=;
 b=it6VAgFrUbO3e6EUQXXf9ETTUPPNIG9zOFEsaSxx29me2MkFwF+ifTylxbmdWrNP7AYbP42MVLyPw0yT6t446nh7xzxvpwpSX7zhCgRcyET7Hc978WWb47BzmsEVZXNU6X1/pTtQPhtraIZKwOcQr13GxFq9U8GljVMhHxHHy4gYRxcY5SQPBt5RE4ZfKc6gE8Jmg6PsZj1/x8ddN94RjoYn7KQIFGvC5ZGIN5nijiVSnDgZDg1u4TZVQ7Tk6U1q5T4UoVbg1S0nakb1X877C1KiidPEDe69E7EepZ01GjZ1OdA+T3CE+jmcqahLECHrhRdRNTS02aCidr9P2ar5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVay1zoE9OxKsN0tHjjuYERuUtcHrP2NXgbZsqvfgnE=;
 b=bmPqFUuuHIsqPbyf3k7HRJ5mzRCB5R2r168cnGF339vXyRFDi43GUFHkH3XoSozCGedPAOGdwuRG7NQzuj6zMY9b+AaZyYoQkKJALcXJ616cYnC5OcRNijkADNSqUIM6dYyD5mmg/Hq2FzxeBaw8IvjAE7c2qAj4hWcVVGtDGSo=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Mon, 10 Nov
 2025 16:35:36 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 16:35:36 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "1118349@bugs.debian.org" <1118349@bugs.debian.org>, Roman Savochenko
 <roman@oscada.org>
Subject: RE: dpm broken on Radeon HD 8570D
Thread-Topic: dpm broken on Radeon HD 8570D
Thread-Index: AQHcUlZw6WdwiutpAUqGRH3IbakkmbTsGrsQ
Date: Mon, 10 Nov 2025 16:35:36 +0000
Message-ID: <BL1PR12MB51448357F3CCE2B2F9D346ADF7CEA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <epyf7tdz3azb3fflb6rwuhax7mpccmqlsmzqqe2pcm7mxrdur4@zpx2uo5pvoqs>
In-Reply-To: <epyf7tdz3azb3fflb6rwuhax7mpccmqlsmzqqe2pcm7mxrdur4@zpx2uo5pvoqs>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-11-10T16:33:21.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MW3PR12MB4409:EE_
x-ms-office365-filtering-correlation-id: 0ca6c2ea-e307-4dd8-6749-08de20772d1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?okWhe24hCrwJJJC/nUyyD1gMk4Sm2k01tF1vZ1hnQpgN535LK00OXqXOOg?=
 =?iso-8859-1?Q?P6Ip/61riBJaku/PlHH/lHuku2xIbCC7C9XPEHO59Lvtu3Om6JD4W37PsU?=
 =?iso-8859-1?Q?xWN/4a2oHL3bvQroe9iyyWwRWvzBHHPRKzdZom7LisJO8MB09iKASyVUKI?=
 =?iso-8859-1?Q?jTJicn4hsFQsoZ7Ik5CZz9HN83ehekuTvODUr65idzMSRnXHmXlrAihVOx?=
 =?iso-8859-1?Q?Hp/WYVcbYNXp0juBYhSUzBy3HBKjBb6tNtK/6H05JZaVZAxgmwWOH1LE0M?=
 =?iso-8859-1?Q?gG4Z1pBZ1QQr6bojYX8pMKRMOxyuQe2H4DJ8kZ8kFtTBqmWaOyV5dkB7hg?=
 =?iso-8859-1?Q?UfgbEOivkIeZtZe9I2t1v1SSUCpUyGmap2ar6DfnCDrLoDSqKPMrhDAZxx?=
 =?iso-8859-1?Q?jD3jgF4GQ6JG/b9xtDRdefkDkEcTxAwdgvf6O7VxisS+A4+lhm0IfHmdqx?=
 =?iso-8859-1?Q?I4rHSOtxfz8E2XcqH3BbXMHysqxHBo7xteXPTnQ6YCRoQUKEuc4Uhr9P+v?=
 =?iso-8859-1?Q?rs0ls2a+j4h9+k7WhaKZvQAlt2vJXYIVE/em+zE4aOcePfz2eKRR6e/ycv?=
 =?iso-8859-1?Q?1QMHf5uR7Gj5qKbhVQKVCr4vpg6jiEd7yUFDgFtsB/tVCXI9UwSQ3Z5fW6?=
 =?iso-8859-1?Q?FXjRhgEx7QNlGGSuBAf+tPmVyvc7SXqESrIsj/RCl14Npdtm4ePVLBlcsU?=
 =?iso-8859-1?Q?3XKYOgdyB1Rf6uQM7d5SwhiPcpYRtLxuMCax9xqMKVDtKbIUnXgxnxJsiT?=
 =?iso-8859-1?Q?0duMqGqf4g2wzyosswJHj8mbvUpH+60D2SAISHBwJ7zBU5OGhfnNbUhCQM?=
 =?iso-8859-1?Q?S9Tam91VlY11LyJzs7HrcU3SDvTKpywTNDLAIrSpjwVAhqB95boMgqp6m4?=
 =?iso-8859-1?Q?38SdtwYBWxD1BON2bJCosH17LvUoAYl1x6MxFksHQ7u5PQ2SYAGimMl50Y?=
 =?iso-8859-1?Q?WRMek32FPS+dLDy8+5IK01p2i5wM0MHZH86HvQgOMp6BCYHF7ExulQLEKU?=
 =?iso-8859-1?Q?yEnyXRs3jfMC++J8ajlMqmV/SReUO1W2jIOBuCB1VtqhDjvaP8wHUNYwnk?=
 =?iso-8859-1?Q?iEfC4cSM/KAARxym2GuJPt1eFbb3Z6etWkAW/PwcPy2gdhQo/U0d3AE/NL?=
 =?iso-8859-1?Q?dNhzchJj/Mo+7z1iODB+FA/ThzIG8iJ76ig/pLRrxJZDeWfYt/uiWJrwKk?=
 =?iso-8859-1?Q?KuByHBmdHrL2LVR7uWxpjYP4dAYhrx37lA/g3lRpsNXKRNrdxM8L0rSzxw?=
 =?iso-8859-1?Q?IByldSOESilHa9eVfZ6LFlNOTXhg9OFAnTY8evoEebMd2mAYpUlh7sb/pO?=
 =?iso-8859-1?Q?XgudzdFwqNa3FikwNc5v5c/NP9ybIG8uEv55BPyuJzBVjP8zm1v7n/5xrs?=
 =?iso-8859-1?Q?sdEnrx2E/LuykuNxLlgMqld1iPQ6w6WNmQUdd0L303e3wyfvV6txnCcpMb?=
 =?iso-8859-1?Q?PNJas2vBcbfEdL2NmHrKCuG1MxaoxmpQwbkVjBtsm2MSZG/TZwvjYee6wj?=
 =?iso-8859-1?Q?M2TSLvR4YIN5o30Pl7P1J3F/IU0rCAHpM4lS6wX83Xcc5UMBZTy6wIaWFe?=
 =?iso-8859-1?Q?6rs8K9JgHm59LIt+w7VP50fNYkHJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?stNZSglMdY8afHZgS2pFkua+4/C3TqdFFEGWo1qKAkrhtO0mLiS0fMPDeU?=
 =?iso-8859-1?Q?486XoHENRtSNWMQ4I4qLNl4cL3LYXKd1jG96rR4C45iKwTdEpc3+PaypLH?=
 =?iso-8859-1?Q?hr5XvYngdqBYOKM6JVTZ54nJoigAcyty6ySruJLkIM4SWvM0YG0Wwf/RgY?=
 =?iso-8859-1?Q?QAL22JjycJkr7zLRiWKs+ktPOrvL69gjk5CgvaWUfELoUfqSqHfbYY8HFa?=
 =?iso-8859-1?Q?BN27CEpuBcpTe0NOnrHa09c4vmx/HEFelnykM+kRMsK9PwUQy4qn+t0mpg?=
 =?iso-8859-1?Q?p0cMKjWMrOCZ/iSlcbOYagqkY7VQ/r8tbsuCZAH9uCYvHyBy7EVha5osH3?=
 =?iso-8859-1?Q?LZPdcysISaUSoYJPtfSMvD1sHC3CeRmmA6N31xo3CcVf5Fz8zI9B1IBxF+?=
 =?iso-8859-1?Q?0c9QHs+y3O94sCzQbCGw0GogF2LU2934QcZNNVrw672+LWyCrhSh7P5pc2?=
 =?iso-8859-1?Q?n5G8c2oi++C0vA1igPr3S6uYEUghKzF+3nqT2guDNAW+Xpa9E5LWtFlUP9?=
 =?iso-8859-1?Q?wRJPwr98srx683tKo9qBKEZDjCrPc5jNAQ9l6VEe1Mwgu5u2Q3HMaVuGCc?=
 =?iso-8859-1?Q?z31dbabp2HzKE0JO1MsGFI2ptQmJGIdpCReldK+ratFXA+1NpSSKbAVEbg?=
 =?iso-8859-1?Q?vgJGGq3gejo8OMzREVQuhC1VwDKC1/nMYggmrPh9k98PfK79BQJkLifk0L?=
 =?iso-8859-1?Q?WDtgLM1/romsAKZwXCN1gn/GUHCEIhN3iFMZq2PAchMFDOLuJFJxkVKPdD?=
 =?iso-8859-1?Q?fggM1mAS9GskZsfQLsuKuiqm2HCOZ0/vH5kywwHTmYYte+GYgyWy5BpkCu?=
 =?iso-8859-1?Q?O+0iZAQKe3CxUcnUa8MClCPYrLO5r9603JLgiMUmFJRBy7Ii38J3rtb12u?=
 =?iso-8859-1?Q?h63St0RSKdK6cL2WDxRW8pUjRRsNJQCC0ueHnA2+CrefUGI2zTf6q8wRzl?=
 =?iso-8859-1?Q?iVCmHv1ZV5ct5C7sxqRtc52vSsn67U10f9XsfkAI88QsLhPdLGiIXEOtz/?=
 =?iso-8859-1?Q?dvBJnNCQqhIiHRbvcwFNwMI7kjZrMS7z4OWRj55G2YjkxeWJIoSgxNqgzO?=
 =?iso-8859-1?Q?bAJWAyuln100HN2EJ9OWTuwws7pp4yUBYvJp04rXNpEaMgbMtVowWCArQ/?=
 =?iso-8859-1?Q?oPNsrE6G3dBBEdLcO6pIFdE5aW146dNeT8q4K4payqgkzCjvyGQ20LSoRH?=
 =?iso-8859-1?Q?cYzHMIk+VhauFC3i9CAM7tfuTbPOgdvo3UPRf0D3CzIMJGlNEll4AmN5b+?=
 =?iso-8859-1?Q?QkGOeKBElxedQzXDbE+idnArgrU0Lv13oV5KnLP23V+Ezn1sTJT5vtzuAP?=
 =?iso-8859-1?Q?6zMjAb6RcwQdA9AqhFfFWm3/nUFHBnQPXQI0Z6UmMcbveDDQYQvwPE3Q5C?=
 =?iso-8859-1?Q?5AX8nUQFgqbdjrTNC5Brfl7vyX9VuXyRdOH+2I4CkbkyMkn678qQZaGhP/?=
 =?iso-8859-1?Q?wn4w7c56mEYpLk2VeO5+m5uCNIdPt827jdBBYyy79snsN3yTeU3Oy0eD61?=
 =?iso-8859-1?Q?/8Kh91YBJmmSCzimuGFwFZ7yTVeGOaWziaZq6q+C7sr/eXrSypc1rzd6Zc?=
 =?iso-8859-1?Q?wY35xd8U7Dfbg9epFyjDAJMndSMeVn43xyXiM7skBM3hbcwHZQ60YAvx3x?=
 =?iso-8859-1?Q?fRCqJvEHHLIHI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca6c2ea-e307-4dd8-6749-08de20772d1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 16:35:36.2713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EQMpITe/WoOUcI5eMXZfuU6M/jZSuvpxVKj/i4ybk15s1mAla4dOz1yo2tR6b0UXUswmZn/FfuKWIbsbC1rcHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409
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
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Sent: Monday, November 10, 2025 10:27 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; 1118349@bugs.debian.org; Roman
> Savochenko <roman@oscada.org>
> Subject: dpm broken on Radeon HD 8570D
>
> Control: forwarded -1 https://lore.kernel.org/amd-
> gfx/epyf7tdz3azb3fflb6rwuhax7mpccmqlsmzqqe2pcm7mxrdur4@zpx2uo5p
> voqs
>
> Hello,
>
> A Debian user (Roman Savochenko, on Cc:) reports issues (freezing with bl=
ack
> screen) with a Radeon HD 8570D graphics adapter. When passing
> `radeon.dpm=3D0` on the kernel commandline the problems are gone.
>
> Is it a sensible quirk to let dpm default to 0 with that hardware? Or doe=
s the
> behaviour depend on (e.g.) the actual monitor in use?

DPM worked fine on this hardware.  I'm not familiar with any general issues=
 with it.  It may be system specific.

>
> Or is there a bug to fix? If so, do you have a hint what to do, is there =
more
> information needed from the affected system?
>
> The full bug history is available at https://bugs.debian.org/1118349, whi=
ch
> also contains some hardware information.


If this is a regression can you bisect?

Thanks,

Alex

>
> Best regards
> Uwe
