Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA949D5B16C
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 14:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B22F10E4EB;
	Mon, 15 Dec 2025 14:05:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G+8u2Pu7";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D766110E4EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 14:05:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSM/L8H8BBt0bc2sh14BFXzT0Fo1F2VlFanImlKO354X4HLnmk5LER6BUZ4w6kJ0VgsEYqi5duqSXS6foOsdqKXq4jyFMSJUctAoa7sBgceLl+CYs5G2edy3wzk73zkXrBccgSyMAFG8n26aCn3MGv3TqjNNyXfSQEstxGRiS9oR4m2TTS3MLpGoxcN+e845xtuEK6KLWQooIgiEkMJw+G9ta0x02SDp6HV9iUZLv0KBbGviNzGCesdJyWDV8qAsYqKE2Ea0L4vH4oxgTlYvaw6E0ple1Eej97lZGRlaJ/+2iJChKdGhRXVFaop7RfzhgPkdm3ekJXA/uGucbq9Cqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okY2DBSRd9V0BQQxalBoTh/vyJna1Q6p/FYTIS7uQ1w=;
 b=Vp9VD7Mov0KJxDbLBsBCZZexx6doPp9UPHfbrb1aYVgO7lbg3Wce4TqzpasVoAJlV09ckJfg0Yk79fqjBpnvuMYzUyhxXBKCuwHP1oQcYvzDiisyXFDE9pwxZsjAzr2e3nhogyBVxqFP7yc0uVh13oreH8xLFSBoC9MdrDT/g+1oK0iBzQsY1jUNsCgM7dgQ7LfwfXLmzU338wZ9+IBi+r5qlcVI86Ocslg8yuOajf5F3+M1cPwW2m4FdiDEzZ6LcfhTJ/my3PscCA2KT/Iev6zg60Kk1pTyTmiDQs6bPL1maPPFEEtqCatEpRYayIJFr7ngWYeR79wkxdg40K2Ksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okY2DBSRd9V0BQQxalBoTh/vyJna1Q6p/FYTIS7uQ1w=;
 b=G+8u2Pu7Ms4MDR6XL+N7JMKZaB++ka9IVisr0sIcD4QJp84HJsv6o+yU04FeBg4ZdoTMoCX04DZUOUAmcgKIshRIynJKyCPG4l56xHOdqbS5gKFCF5y1QFJhzACIqUaZ34SO3Vr4K2cbQiS6gRfHnKiyPyudE9vQ06WVftryJWQ=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 14:05:28 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%7]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 14:05:28 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
Subject: RE: [PATCH 00/15] DC Patches Dec 15 2025
Thread-Topic: [PATCH 00/15] DC Patches Dec 15 2025
Thread-Index: AQHcaOnTqmYYrI4wpUq7PVfmFeQ9MLUixZMw
Date: Mon, 15 Dec 2025 14:05:28 +0000
Message-ID: <DS0PR12MB65346B870D6CFBEAC1E3268E9CADA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20251209085702.293682-1-chen-yu.chen@amd.com>
In-Reply-To: <20251209085702.293682-1-chen-yu.chen@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-12-15T14:05:24.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|IA1PR12MB8285:EE_
x-ms-office365-filtering-correlation-id: d1d94a99-5610-4f07-33e6-08de3be3007c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?J129cv5VS6kYYjhWCRVESIJrkk12/KlXU7mdPvV968woxtx41bsf5QJHPV?=
 =?iso-8859-1?Q?kPJtzeTV9mbraUViXyNR6ULUdC/Gk7EZTpFUhG/4+x6mlliniGeSUyaXEJ?=
 =?iso-8859-1?Q?6nOuj0vxNlqNaEI3pP9/DCi+TrFKcEzylivVyU1YGEhtHIhu3owfyxFJBf?=
 =?iso-8859-1?Q?FsayD0bYjf3l6Q08aDEBePlLaSoLPpYWV0mTgzTQG3VJ7BnkgF5N1NHtwy?=
 =?iso-8859-1?Q?jP8kNzsXMZkkIUjHHsOgHcx++rWbOV9Je3zzZnCwwTpIRE5XS0ZhZt/KYJ?=
 =?iso-8859-1?Q?zJkAJ36Z6M19vjbWRSJU0O9uRQT3DMhd+Z6BR4mDZrkbFuyizSzgmWBvCY?=
 =?iso-8859-1?Q?uXyv/TNyokBBQANn32U6GnWrNASo0KZDkpKacZew+YK+UZs9VKSskE0vLf?=
 =?iso-8859-1?Q?Tz0QhGGDZZNVhgt38+O7QyJhbSuiqeEekhBZegEVZXsNCUh5FJbcxFMsVf?=
 =?iso-8859-1?Q?mBqFXlolQ2aWLguhOf8vV3lF98CYOrJuJjAB1BIrm2vPVENPJgQwxvO9T/?=
 =?iso-8859-1?Q?xr8xy7vWKl3pGC9HPGM/z5sl7cWdF09eZH4bwUl69H3WOiIa994uFm+59n?=
 =?iso-8859-1?Q?itziS0PzIRLHN2i+kudjxvY5lDI7zrCzerbXsnshZd9FDjCTGvcUBybpt+?=
 =?iso-8859-1?Q?znMM9A5j2Ig4lbV8XqvM61CiITf7SRVxzVKbsMAJ/Yb1ojP746n+Exp4r/?=
 =?iso-8859-1?Q?rTL+uuBPtxuvk1I8COgY+/30FWW2FzjYD8res8ZO29QZwddrALBb5KisgE?=
 =?iso-8859-1?Q?yxIdG7smkvoJ3Bz+UJ4v2+Mdb3bvNz8iWB5HP6ikfVNgIPeok7VOy5CrxO?=
 =?iso-8859-1?Q?h+32wNSGCchEA8DfQXy+bhax/jvYhQUsiYXjiNQIMHxjQ4/62tqljDJt4M?=
 =?iso-8859-1?Q?KLiy+t37TvvK3/DYo9EdzP1iDthRqI9qZbb6F4Sh280727MA7ZSPPghrWV?=
 =?iso-8859-1?Q?XXZfuDY5xozjZbcZcc/3vo5j8FPBIOwzo9n8G9uP6nWwoSLLwMd0aVmnPY?=
 =?iso-8859-1?Q?8kzrYJZ9cIgz87AJptAYKePZBuSzW9MswlRwHwgdqM+CM/zcufl0MBhAy1?=
 =?iso-8859-1?Q?k8OhvSgi61AXIt/oq4REQesncJKLjQ1WSJPM9fgwbISl1gSiHGq8nBsP4X?=
 =?iso-8859-1?Q?mlmtcShmpSBlX6+heZEHc1/4CTk/CIZlrTzMYkmnRKnczYRZkMJn0PyyWH?=
 =?iso-8859-1?Q?Hmk9/7NPO9QjG7pTc0DmFNvwG8oODDhDIwt1YSoF+GeWWDvwUe4dbKhVvN?=
 =?iso-8859-1?Q?tHWXMsNBKZTt0QbMMCQ2jYewWp9XNUVQnUoItPYEo2XgoGOfs5EU4fWj6j?=
 =?iso-8859-1?Q?KWeJu7RcrRS/l7f5IxkF/QWS3H6my2H+i/7SeQGLnNd08OxhcroMOmjjCU?=
 =?iso-8859-1?Q?hhAIXFVgnLIPcas/ynWdtFnLvYxyvhu1Z16nHrGPSeQ8efE3xJ4VA9qDXU?=
 =?iso-8859-1?Q?qctnvYatAojsUjF2NWm8xit13ax6DknCYYTUGSY0n4EVmqmjlUHNy+XW53?=
 =?iso-8859-1?Q?JXtKMl8KSiuVXhAHtLEHAjOaGIwbjTZBA8yYrnnhpu0a8tePmlp1YYpwF4?=
 =?iso-8859-1?Q?ZrLr0KMLGMdsQb118740y3YchpZ7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5V9p3qSRAd9IbiFPufu7ibx5UThTn4Z0A0Y5EhZHgwFVHVotRgHhDNX5EF?=
 =?iso-8859-1?Q?3Qf3owaFyUnm0acSSm8hNCJCptoUo6My6ZbEmVA2vLtk0AYPaKXN36HdWV?=
 =?iso-8859-1?Q?FQf4r8C3B9uwUFCLstTiCOtqRmlIp2YE9053EBDYsPmJosriV1zS7JamBI?=
 =?iso-8859-1?Q?t5M1Mm2tmQse3+w3eY0HjMDRWCvtMr08fIWFHv6uWMeG6UoENYFQ9WW/4V?=
 =?iso-8859-1?Q?HTwQ7RDsqkXGXcGUumy7TEfY2Ar33XMqXqRk9O2G9uoXdTw47EoyDNyTHW?=
 =?iso-8859-1?Q?CkJvYEV8H6rfCZ1iC2I8i0/GaFAouONPzQaUAbIvQ03oAxl0Wh4namxIQh?=
 =?iso-8859-1?Q?Xa5SPBYF34olSrnClDj0Gaer7vjHEq8HnEEWQlhgjsFDoazD368m8wJgFn?=
 =?iso-8859-1?Q?TsQ93mLYMDTV0wLjDadDcnjeC/Ho199I0YnrE9i2fVDLSqgHk0Rme87R6T?=
 =?iso-8859-1?Q?bh0F3GmganTYSnj/2uocfv9qlArIM0KVn8u1bdEWNYmieJMYrTVzfqJ/FU?=
 =?iso-8859-1?Q?Gi6SAVO0ugzGefOjyT1TmMkaIW2NxxUYUJR6csTq5bAd0b4UraS2vh7nKZ?=
 =?iso-8859-1?Q?/WR95WP+EgMMos3kHI2Jqn7G8z8qdCisJ0lontlT3h7cS9dfQiwn6dAK17?=
 =?iso-8859-1?Q?9lNFXlrWOu5jPnk/O+SSXGUW+B9JnlwTHS3cAGTyarPAQLRdvnr+oge4+S?=
 =?iso-8859-1?Q?UYh4d30k+lTzl8MzKqDNwXso6XlVTuBv/2EF7vksg3+8udVH1uN/WXbVjk?=
 =?iso-8859-1?Q?4VLeS8oGpndKyr8E3B2tM9+y2yfUMOa05LvyboSVhgfCUKRLZ4vxd1qIwZ?=
 =?iso-8859-1?Q?PtbMYEOYz0GxH3tWdgWbBrFO95FXwKmvfoPyuJ5u4ikl2PFKxb9jAzRxQz?=
 =?iso-8859-1?Q?T4KjdmgfOMzgMvB4z6MVR4owwTjZXHksGNpExpq89v9uPcDVEFywejxTmx?=
 =?iso-8859-1?Q?VE1aTk4vysrgKySivBQnHFJ5rTwbD3Y67/G1w5ec84tegZ4+rjQfQ8AGqs?=
 =?iso-8859-1?Q?4heVvBGIsxMWFDiRRzJ9aRWJxY/AeR2nquYN85wK1nnx4TuXkZknykA2+F?=
 =?iso-8859-1?Q?mb93cLtwwZ68gIAuCJn0GX50lSm6UKrQ1REqQ7HU/cv6A1mTePKAR+EB+7?=
 =?iso-8859-1?Q?G+b+IYntC1mrYTuEza4tSUYv+x1YuU9ZUWrKRp/MAaD0FGPrUVXUC+Xa/a?=
 =?iso-8859-1?Q?OA0B/WZIZ9bppRCVgZwT5oIVtTolYbOPaYpMnDhwugpukood6Mku8qoOd4?=
 =?iso-8859-1?Q?gTkYq0sc9JNkKgcQqKrf5P6OVW0Fel8GcA5ensr4dcErivUvvuU47US5wh?=
 =?iso-8859-1?Q?hINKUkyALFVmO1O16cOh8ukv+YHt3+S2DnUpIUVksleBHk1huus29x4vTb?=
 =?iso-8859-1?Q?zunaR80xi+nxsDoG0lNGSIhSRyDIaYNzRLlUva+E+wihAcMYd6HFdF6VtT?=
 =?iso-8859-1?Q?iOsSJJxLlcKqwEZaLr0g8brw2VPC5NiyKCZS1wAL8zzjb6j6WH9ocTECSP?=
 =?iso-8859-1?Q?0y5y6owXiZXGKbVfjZdHrMeKuCoF553JHABPmowBtiuFWUPbLdSn21Rf/P?=
 =?iso-8859-1?Q?BbGzbkSmrp2iYHpKeyTAkG2jqaPaZe2wMh6wWUQU7NFjYRCKjlRn5yUp6e?=
 =?iso-8859-1?Q?WDEjH07paMW7o=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d94a99-5610-4f07-33e6-08de3be3007c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 14:05:28.4617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MWupcE3ct7zHRFMvg/8j1e/7LIeydGXMWgMy27BJ5nIH0VlxacvTdmDCHsibB4Jb85onGG3nihMOkU+OOKPuMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285
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


The patchset consists of the amd-staging-drm-next branch (Head commit - d27=
22b16889647fb3fb22933442c5ab9e7c93361 -> drm/amdgpu/acpi: Reduce amdgpu_acp=
i_detect stack usage) with new patches added on top of it.

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
From: Chenyu Chen <chen-yu.chen@amd.com>
Sent: Tuesday, December 9, 2025 3:55 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Chen, Chen-Yu <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/15] DC Patches Dec 15 2025

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

 - Replay Video Conferencing V2
 - Fix scratch registers offsets for DCN35 and DCN351
 - Fix DP no audio issue
 - Add use_max_lsw parameter
 - Fix presentation of Z8 efficiency
 - Add USB-C DP Alt Mode lane limitation in DCN32
 - Support DRR granularity
 - Don't disable DPCD mst_en if sink connected
 - Set enable_legacy_fast_update to false for DCN35/351
 - Split update_planes_and_stream_v3 into parts (V2)

 Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Revert "Fix pbn to kbps Conversion"

Austin Zheng (1):
  drm/amd/display: Fix presentation of Z8 efficiency

Charlene Liu (2):
  drm/amd/display: Fix DP no audio issue
  drm/amd/display: DPP low mem pwr related adjustment -Part I

Dominik Kaszewski (1):
  drm/amd/display: Split update_planes_and_stream_v3 into parts (V2)

Fudongwang (1):
  drm/amd/display: Set enable_legacy_fast_update to false for DCN35/351

Oleh Kuzhylnyi (1):
  drm/amd/display: Add use_max_lsw parameter

Peichen Huang (1):
  drm/amd/display: Don't disable DPCD mst_en if sink connected

Ray Wu (2):
  drm/amd/display: Fix scratch registers offsets for DCN35
  drm/amd/display: Fix scratch registers offsets for DCN351

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.40.0
  drm/amd/display: Promote DC to 3.2.363

chunttso (1):
  drm/amd/display: Replay Video Conferencing V2

hewitt (1):
  drm/amd/display: Add USB-C DP Alt Mode lane limitation in DCN32

weiguali (1):
  drm/amd/display: Support DRR granularity

 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  59 +--
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 351 +++++++++++++++++-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  31 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  31 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  14 +
 .../dc/dio/dcn32/dcn32_dio_link_encoder.c     |  15 +-
 .../dml21/inc/dml_top_display_cfg_types.h     |   1 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   5 +-
 .../src/dml2_core/dml2_core_shared_types.h    |   1 +
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h  |   1 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |   9 +
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   | 102 +++--
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   8 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   1 -
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  16 +-
 .../dc/link/protocols/link_dp_capability.c    |   7 +
 .../dc/resource/dcn35/dcn35_resource.c        |  10 +-
 .../dc/resource/dcn351/dcn351_resource.c      |  10 +-
 .../dc/resource/dcn401/dcn401_resource.h      |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  70 ++--
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   1 +
 23 files changed, 613 insertions(+), 134 deletions(-)

--
2.43.0

