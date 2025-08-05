Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CEBC87FD1
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 13:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E8210E26E;
	Tue,  5 Aug 2025 13:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cc6tzZt2";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC6E10E26E
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 13:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEEa3CsjO69XrkOFWMhsoxpT2STrqcypL3vDm3LQzfaOc3S+9v+ySLS8o/h1C2IZSoacH6qTsci3VsD93Wz0acu6dHMJ0/LOS70IL8IhsZ5YYziT3/yhrXdSjcYaYvOcx5aSEVNLZa8N/sbukf5TIgBOzcwoxKq5KjBQqiuTck5HPcNAs1uXsZZxQG4hhlVpn8Wo3RWMgFAsCjUeuA2tknFvanKurk6mjHGuOJKkN3xJlOkwYcPNQXz5s+ennSj3Xi7cl0noCsQhOlIGQQz0vZaNOvJL3b5QEs2HXwasNSH97nwfGPzhMKdsS8MVXFzvAJe9BkwB7T7BaNRwzZE1GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kRvfKw81GmJ+UAUulicVlblQMtNyXhbEY+tlzs0Yxg=;
 b=YMGQAmgWTbo6d4X2fdu3952qdwboFYNJD99Z0REpGMXHxChtTsd15/u7zBcpAxeLL8AUZaoQHWT8nMOtaHuR8UTvuL46+b6dXuDH2VMQhnetomxQaPSn4PBfFPniHklH/x8MUsE2OoiukAh9xJ6IsT05BRRQRix+NoeACIoMWWBPBek5PkD8bkpBnI3MORPfqltYjkc8DXUBmCraspQ/MS/GYo9Zd8WcHnf3nEns8WUKzis38FfwOas+f8AlYTmDO2hIj/Au8vRsq8EFjK3J2fGk+bzBpQPGd9vHFfF6Z2vLTzQ2YNXqUnAEgT1AMTo5o17hKTErtJPgcFyBfrxo/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kRvfKw81GmJ+UAUulicVlblQMtNyXhbEY+tlzs0Yxg=;
 b=cc6tzZt2SkTO915p4MlEUMm5ElXr6HcmYKejgPMF/Fi3JDWOQx2sT2cb5wIq/jSvsTrAVFPomZqPHRYJn874KL5838xmxKcnsohuxcYgt1a2LIO/htECk4j/GLoRgn415jRYq37Je/ELD1FkBcpZxq0eMKDC0kQtyu5jb2OTibE=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.17; Tue, 5 Aug 2025 13:04:20 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 13:04:19 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Li, Roman" <Roman.Li@amd.com>
Subject: RE: [PATCH 00/12] DC Patches July 30, 2025
Thread-Topic: [PATCH 00/12] DC Patches July 30, 2025
Thread-Index: AQHcAYRCsIIeSEpvl0KNJE1DqjlIQ7RUDzKg
Date: Tue, 5 Aug 2025 13:04:19 +0000
Message-ID: <DS0PR12MB6534CB60AD7CF0E0AD4175289C22A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250730185903.1023256-1-Roman.Li@amd.com>
In-Reply-To: <20250730185903.1023256-1-Roman.Li@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-05T13:02:19.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|MN2PR12MB4302:EE_
x-ms-office365-filtering-correlation-id: 9294509e-b795-4936-9d2d-08ddd42096e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/5iV5lyT1UecKb0snHhZWJfSZSGqaCzqSWeKz1ExUyfbGozpQjhYfiQfQ5ft?=
 =?us-ascii?Q?SJcxIvk/KYpI3vvCRoPg9a6NgHtNKUyzD9Igi9eyeThNuWEIsq/s6DnEkueo?=
 =?us-ascii?Q?9/fpGqmAi0yGiK+G53bowg+hZhSgJ5BnaH5qvoDRr0O1sYZMPx+Rf27fISz2?=
 =?us-ascii?Q?jwvaf0npG7Aa0tJUMcE6t4XdmXVrXCQreUGpICspTR0f9pTBuHXT9ITeSlPz?=
 =?us-ascii?Q?/cn9JLWk1ka6q1/DVK5dXhfkrXhZoCVWJFeKiwHlLvHLDVVRDaSj+m++5Vs7?=
 =?us-ascii?Q?w2aK2dyVwmPMB7jDsnnHSjN1Hbun8/JTEuAJp2PvwWSq8KGnOiUT0UW5H+RM?=
 =?us-ascii?Q?kk13Z76WsJeTrnIqFxSdCrHU14dwh/2aKvPq7YRH8DCl1/f5GRj7zBVG98no?=
 =?us-ascii?Q?1iMh4t3ItLABYHTPyG5AUD5STlXlXLpiQg/sICrc6DKyfQmpv9fkKUGKHpXz?=
 =?us-ascii?Q?GlKuwFV7/BFJBSgWYtuBXn/pEnthveJKLmdF8yYxy8BbweAYGFfyfZJwhXWe?=
 =?us-ascii?Q?3baZ8ozrfRH78TWunrEZNOQ5GDAGffBdw1CNIdTLdFVMax2/wvN2XkLqCaea?=
 =?us-ascii?Q?dtdMXjLQ4OtQGu2xxIyaUTa+Xi1BocdOShUZ/yiKgaXKS4i2BDbZfSE1dBQO?=
 =?us-ascii?Q?CmhAanE8jCs2aCnMuwHLYCvGZzAIxivABG+ZRJ4vwzZ5qU2tICn2XOVH9V0S?=
 =?us-ascii?Q?d66CDnqVujYuzwg+P2zBt0iOUXbwN2CSLk9bUfBLesoz1EmbRWbZ3nElgwYf?=
 =?us-ascii?Q?UjVvHCXrxZdp3BqTaEnCan6o91sjXdF8sxbKpxBc9SYAa7eW9mV3uOxS8s8/?=
 =?us-ascii?Q?GWwddbgMYtpYCHzyczc1gB3bAE7WKuL8eCCJm193yCQWqhLNbYEEevxwJSQi?=
 =?us-ascii?Q?lTiQFpgIzODO2h5ugxRCOEthX/YS435fIX7nW0mt3+IlC6xWEE9zee9PkKs+?=
 =?us-ascii?Q?8VaHSnIW3sgTZzed7ASR2p9FZI4iu0onuCkjRS7OOKD3gkKXaimvs3glToAE?=
 =?us-ascii?Q?RmQHXJc9vbYNtYP4FqTuMa3QMNudmAUeqWBBf0BfAYi8j0HRTW1NuOt1SaQP?=
 =?us-ascii?Q?DHLxqcwa393OEgpgQO9I4UPO2VwKRG8GN5UcD2AyJAKvNtyBROJK5CCf+B4/?=
 =?us-ascii?Q?UGZEoH9izGAXQwWbcthgm+Z90/EcQZMFIt8G79r5EQkMkTWa4kHzLlzmDaNi?=
 =?us-ascii?Q?IlN+GAzRC0hDb9lZaQCT1rgcdfsSVhfmNiM5uc+0DISAV+0FXf9RJDSCS3PH?=
 =?us-ascii?Q?UHef/hPubmGaJGaJxTmLQmkFppfQ89pgo+B/a7pZ6VMxRGjBDLexAcSuZhOV?=
 =?us-ascii?Q?kcR8l0RmT+O8KiNbaatpLcnwUhexgAO5RwsmtQWCaOfeyVHTk8gB/+dlveNW?=
 =?us-ascii?Q?7iTTyWgQIGwS56mEY8o6pp29ifv92nosYJzMgpx0djCiqWJduF4RMCi+hDVG?=
 =?us-ascii?Q?U68tR1Nve1NSY6HN6Cp4xtyCxBY/AtgerZpTvtkylRt4tYTwlquZ5w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xtC/Qhh3PCBaw+J2OgfHDT51p4fexEw/qOCYSiwzskp9ozFyOyopz/mthCtw?=
 =?us-ascii?Q?3a03lSQ8ZR2NRfH+U0pejjTvAKMcp2mvSgqlWKw86ToTlCjPQvFhqQ/otOXy?=
 =?us-ascii?Q?RnceePc5KHVQUMOQsivbZA3YdyPhr39yGGKXBPRPs6b6yUuZKQH1rXgverxg?=
 =?us-ascii?Q?4KjhhfcmHfb+vc9TiWvSm2C0KrAnEgazUsC9ltO+GKdSAWBLC3dBg3g8Fqbf?=
 =?us-ascii?Q?hHGQoXawOvUjcxuO4fWMLwRbP1gWEJjjLJ9hL+WKHCqxFyLo/hlNMmES/TuR?=
 =?us-ascii?Q?Z3ckyTEIAFsEjPuTJDYfezZIlbTCYHg7/t2qkX4Cgg/hHfc+HoyIjKou8uk5?=
 =?us-ascii?Q?2MVyFndBztZfVx00nBrMd8M2D3rdfkNuNmxh4tL48rNB2txxYN1qk5Dz1SzM?=
 =?us-ascii?Q?/2WQfo3oL9WunIVvH8KEShzYQ8w74crjpXZhMA2FY2rapJLgTiAg4kQhQDwh?=
 =?us-ascii?Q?frFMYcZdRVyrQ/rPRqNBb14FHa4nmHg0wh4Cf6jzxolkJDZEd2D5XOl+JLn1?=
 =?us-ascii?Q?HIWZhqfQTo/hN5hcx3bgqiVg8zxom2ywr0XMwlIRk4FqMv+O5UfRrq9uoKnw?=
 =?us-ascii?Q?8Rl/PkFRhGK9B6llxY9NNr4bwsE+kITrvXDsVAHnz4n9gKffyD3OhA+p92ZZ?=
 =?us-ascii?Q?alFqqKMvvlJG8u+/8JV00FAy7rQ6IengFoYBqtXsTspyuUgWz3VCG4ph/e3z?=
 =?us-ascii?Q?eHFczZE56fXreE3X3EgU42a8+LyKywPCFq2FX3E0mlds6fdIFsxjGIPhtVLO?=
 =?us-ascii?Q?nbzBeXu7HKvWQVswXlFsrFqQl52rUNPU38xfYXwR2JEVFxiut1I2R44DZfy+?=
 =?us-ascii?Q?L2tO8+YORwH7uSWR5s3cOcFu/4sUT+5Bs08RhNDtuJbO4EDGcFwhl16UFk9N?=
 =?us-ascii?Q?zpCTBhML5uOCCdOLQGFGiGEgv/7yJFxJFrZ9I/y0wQPr0HD3QHHw+5uLZuWi?=
 =?us-ascii?Q?J3153EFUEjiZFXkBeY2Rfb1XAVi2Uc+UeXBOiWSGyY36v3R6O4JxlkdBIVmt?=
 =?us-ascii?Q?i0DFerzMG+qpka1BC7s0SFTgJiimHCa+A0vmDV/fa78rQ8MgK4CnLNJARhoT?=
 =?us-ascii?Q?ki5yNkTienn0T+tB+bRu6W4yTjLraQSL156Qa5UhpwBWgkDc+1rhJx6YoYqm?=
 =?us-ascii?Q?/omMX9/Rb7Uhml6RvarF59jnlPrGywM7j03AQyRXelX+1qBLAmovXWwQb3nb?=
 =?us-ascii?Q?DApIRMhqAvIu0hKjEAixYD8ser/ISoPMrw8prIFqaCJY2HoqUsEf5wGqPipX?=
 =?us-ascii?Q?WzUwaktc1IXiIw2um4lWvD2CSH+BwXRC21zP50DUOBxd5r1jRZ7b5giueoKX?=
 =?us-ascii?Q?Rwnl0g4wRW+tLU8MUepLzcf1dyQxbRziEZBXSokXpvgVQhhTUao3CBy1F1I2?=
 =?us-ascii?Q?1t1vgURjD4KUUz2gPgy9EJN33x/bQDiVDAZDqXvucHf+A1jel7yWTvSoluYA?=
 =?us-ascii?Q?rJld7mL4ZIBj6TXb1KOEd+Z4X53N4GhSVZlJdWE+g1vAcJRd+N30p79INpmE?=
 =?us-ascii?Q?u1jDf4PN4E8U4/11D0RNLZiBCTl7W2d385jszo/dIFSIwn/RmZpNMCTSdN7r?=
 =?us-ascii?Q?FQFblDtzMfTHQAimOUo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9294509e-b795-4936-9d2d-08ddd42096e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 13:04:19.2059 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMmcJcGVS8v7u2M9v7Uy46fRzUDHA7XBAn8jE7loraMfrJoX+Im3FF3r6TAvZFUFfHfoGxpJocewWntB7WpoRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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
        * Single Display eDP -> 1080p 60hz, 1920x1200 165hz
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

The patchset consists of the amd-staging-drm-next branch (Head commit - 679=
5226cf20783be8a3ede94a26c1bc8976ad697 -> drm/amdgpu: Add chain runlists sup=
port to GC9.4.2) with new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using KDE Plasma and Gnome.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>



Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: Roman.Li@amd.com <Roman.Li@amd.com>
Sent: Wednesday, July 30, 2025 2:59 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Li, Roman <Roman.Li@amd.com>
Subject: [PATCH 00/12] DC Patches July 30, 2025

From: Roman Li <Roman.Li@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* Add interface to log hw state when underflow happens
* Fix hubp programming of 3dlut fast load
* Avoid Read Remote DPCD Many Times
* More liberal vmin/vmax update for freesync
* Fix dmub access race condition

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Aurabindo Pillai (2):
  drm/amd/display: fix dmub access race condition
  drm/amd/display: more liberal vmin/vmax update for freesync

Duncan Ma (1):
  drm/amd/display: Adjust AUX-less ALPM setting

Fangzhi Zuo (1):
  drm/amd/display: Avoid Read Remote DPCD Many Times

Jingwen Zhu (1):
  drm/amd/display: limited pll vco w/a v2

Mario Limonciello (1):
  drm/amd/display: Revert "drm/amd/display: Fix AMDGPU_MAX_BL_LEVEL
    value"

Muhammad Ahmed (1):
  drm/amd/display: Adding interface to log hw state when underflow
    happens

Paul Hsieh (1):
  drm/amd/display: update dpp/disp clock from smu clock table

Reza Amini (1):
  drm/amd/display: Fixing hubp programming of 3dlut fast load

Ryan Seto (1):
  drm/amd/display: Toggle for Disable Force Pstate Allow on Disable

Siyang Liu (1):
  drm/amd/display: fix a Null pointer dereference vulnerability

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.344

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 81 ++++++++++++++++---  ..=
./gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 14 ++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  9 ++-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    | 16 ++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 37 ++++++---
 drivers/gpu/drm/amd/display/dc/dc.h           | 59 +++++++++++++-
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    | 20 ++++-
 .../display/dc/hubbub/dcn30/dcn30_hubbub.c    | 31 +++++++
 .../display/dc/hubbub/dcn30/dcn30_hubbub.h    |  6 ++
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |  2 +
 .../display/dc/hubbub/dcn32/dcn32_hubbub.c    |  2 +
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |  2 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |  2 +
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |  9 ++-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |  1 +
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    | 26 ++++++
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |  8 +-
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    | 15 ++++
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.h    |  6 +-
 .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |  3 +
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |  3 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 41 ++++++++++  .../amd/dis=
play/dc/hubp/dcn401/dcn401_hubp.h  |  8 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 63 +++++++++++----
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 48 +++++++++++
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |  5 ++
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |  1 +
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |  1 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  1 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  1 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  1 +  .../amd/display/dc/h=
wss/dcn401/dcn401_hwseq.c | 36 +++++----  .../amd/display/dc/hwss/dcn401/dc=
n401_init.c  |  1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  4 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  2 +  drivers/gpu/drm/amd/=
display/dc/inc/hw/hubp.h  | 21 ++++-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   | 11 +++
 .../link/protocols/link_edp_panel_control.c   |  2 +-
 .../dc/resource/dcn32/dcn32_resource.h        |  3 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  1 +
 .../dc/resource/dcn401/dcn401_resource.h      |  3 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  1 +
 45 files changed, 545 insertions(+), 67 deletions(-)

--
2.34.1

