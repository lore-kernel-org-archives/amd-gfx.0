Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94443CA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 13:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D88F10E1DD;
	Mon, 18 Aug 2025 13:38:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QteiBT4i";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FE8E10E449
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 13:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAGPGmdsCDiiusWjhaFGE4trh46wRkSee+Cqb87fgoYdq6nZSqyTYQLnpRYfPDbu/tPGET4EIUQJI6zPuzhqlkDHuyX1NuN2EYRjplgexBSKXTeQN8AAO/mCoXy5PXyF5/utgwqpPApzf+kDVP6XNWdvBmSfmEPPo7jReuycyvaD5ImqrfrVdghn4+TgoSOz/iQx1JOO5xF/td0+EF8KEBLHgUTezIZ1M045k/NkDMYCzqK5Dif5KVgh0BSJZGjnFp+RATY0/LGlNPsO0XMpqQrN96kAKT0Cdin7v00t0mvtzsktmzdqbFmYeLgg7EMs4biTscY7vk6c2AoLD8R2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ixfgj1SjsRA9G6mdVHmD3o7a//k1VC4Z57Rp3l7Y0s=;
 b=F045k9asql7uPRzMX06DPW0lrxPTgLwVIke9Dq7Rl4ZcacWKfJMlr/OHxJ8osFjw1imM2f55A44tFxpPbY8+XGvbTgRsFzcd6CPilhfNFevmWHEJ4XuH8O63CkjgsleBjmikO6xiuM0VL1cNfpqd8vucmQwKyhNls1yB8ZQHeIZZdCK5M4IH+gt42kSRYHg5fT+SX8r7fUjxVt96OgMEOqV8PlXdG4Sw3ESvzMGcU6/G40huAYOnsy+infIBsxrxAP5SdT6HNuEAFBtgsM1c9cPjQi0I0Je0bWWr6UXQDqJ8ychM2KjJPJJTIvtSRzDAOjagdqna4ZAUOJS1+vsoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ixfgj1SjsRA9G6mdVHmD3o7a//k1VC4Z57Rp3l7Y0s=;
 b=QteiBT4i7QQFQ1khNuP9DKDMaUBIoojSfZRz5Bv3M/PPEWBSaJbzRDv7J7Kg9ipg5W7NMdVP8VVsUGheEXKDoS8pkIopkWRI771ALqh/38yT7M+1qdyloR99yOwrWS+Wp6pD/wvc7eMAmrzILljZVKEciRUsXBAQ+Xl5QVAuZh4=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Mon, 18 Aug 2025 13:38:41 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 13:38:40 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>
Subject: RE: [PATCH 00/11] DC Patches Aug 13, 2025
Thread-Topic: [PATCH 00/11] DC Patches Aug 13, 2025
Thread-Index: AQHcDKm3gWsiu/UUvEWmKDQDF5i0Q7Rob3YQ
Date: Mon, 18 Aug 2025 13:38:40 +0000
Message-ID: <DS0PR12MB65340601B3C724ECAC3B28DA9C31A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250813232532.2661638-1-alex.hung@amd.com>
In-Reply-To: <20250813232532.2661638-1-alex.hung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-18T13:38:25.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|PH7PR12MB9222:EE_
x-ms-office365-filtering-correlation-id: 97940ce1-d020-4444-4e19-08ddde5c8b14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?aD4j5VQ6sWAP68t5yFg8H2Gl7wj5Ws2778FJ7pWapVRAl3gFhmEyeBmvCXZe?=
 =?us-ascii?Q?XfpEN6F59j59Ys0RFQ1VYAZRIvAy/TgcGP6dGI4js8UW6cOqJLSTPOhwVQ+/?=
 =?us-ascii?Q?mU1fATfWU+zalvhC6zyk46ksxjv1HvtnERaJbevshSGyHVUypwgSuSqEv0NG?=
 =?us-ascii?Q?Jn+eEQZZnVA0LtkqyZrffA2aksAImWz1nbrErAvGB/hqIBIDee8VO/TtrNSw?=
 =?us-ascii?Q?OEedTjQPQVcX0MoF+SqSEzz1Zu5YBayyEKcnW5UCgfKOzFymkPzdKjP6TUTO?=
 =?us-ascii?Q?k30CC2RB2VeD0vRgwd1FyoK7AVOzMxhk/SK6l/n3Z3Cuiw8aejYHJgIfwuoW?=
 =?us-ascii?Q?IDBCmTDqVEFyU9yYfe9/Ts4s7k8aPFBvXpx8zg97N9rOYoPdMto+SV40FWvB?=
 =?us-ascii?Q?n/A1/AKWugGbG6TL7nbqb+qjkWOfX2Z/9Ike5UAtNqgqY4y/C9GFTl9selKe?=
 =?us-ascii?Q?J57jmhi0I2/Tp6Atdzbbs3LdYG6Ae5tQCPluqBG2I48ULKQP9lY+C5xAYz7i?=
 =?us-ascii?Q?Zv93vBJeMC8MmTMB3JKKcY1z4IIgyrK+sY2/PkdBAPFhI2OOxYy/CBFvymXE?=
 =?us-ascii?Q?p/Ux8zSr4XNtTfWsa7lrDbf0HsFuGXOrC0cTbHITlXlJfGvDDqgDpv+d8Hdf?=
 =?us-ascii?Q?jnfWFIT+VjgSZrgAaeY5quJK2qQCcSr5UFBlVQYQ4AhuWMHJOB5dPDyCpnMY?=
 =?us-ascii?Q?bjyDNePiLfbgNpJRZN6hNUgRkjT3H5blsRE0iT0oHKNYBsZg0f39dOywBFog?=
 =?us-ascii?Q?gi3/u+6jdaroWQLzgUUtAQ711D8mSg3kWtdg1lU7yD51q56xSes0gDyFobO9?=
 =?us-ascii?Q?A6TG4NXCA9MYv6/8Ak5v9kGiYJDcAjZ9DcoUPMf55146qT3ju88IAqHg4Gc0?=
 =?us-ascii?Q?RPckTraiP4khMQ+X8l36SM66vS3P8FauPj72f8crE3CYrjgGoLo5aKfqn6Ek?=
 =?us-ascii?Q?H5ll7RcVp8asw2upGnbeRpLrWCKUWfUIba5vUTaiuKXcymdDDdF/WfEkH1XF?=
 =?us-ascii?Q?GZVfetKyiR3uOix1ihuFHA5d9IGcse/smIDGFr2v5101cDTqAO1eEzkCtKgd?=
 =?us-ascii?Q?NHMpWZlmoAb42IIOd0LkBHjax+R7mDItgqXr7Cj+ktIFhUdraPwk+2a2rNT2?=
 =?us-ascii?Q?8/TSiN2lk2cX4XM+RH/dBhSXOXjOO/JbCb/w9OZnT01HrYPUowH3jTNu8MxA?=
 =?us-ascii?Q?BJfYcXPcD+OYx+KM9f8A+/+JyUW45gBI3445zQpebCFtj0CUm6ZCPiYReppN?=
 =?us-ascii?Q?VRyiLl1mk/V3c577Zw5R6Pc3B7MrkvyYQ1vbOhnneXx9RomU+NvmeDFZdGuY?=
 =?us-ascii?Q?/qibK8l+KgOFB8xTgYcOQU0/nwOdnAu+qv1r0R8GSykddq1RzZIXIgSnwQgH?=
 =?us-ascii?Q?1KnfXFv6+I0LZc2/BEKAeuTgt/ajb8ShGSj3xHGjY+jRsW7onTg9NCX7vXfw?=
 =?us-ascii?Q?gRcLy2+dREQXOdQfhzU/qlV1zxJ/6mQNDHjOaGT/0xoDDC79F1+n5A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9cxf4/O5LF7Hc7dLLcxMscEtcivLg1pONgTf7KgM2rVyaKH9TcKrKG9kuTb8?=
 =?us-ascii?Q?ZYvfMCGXQl1VER0POzZq7DkGh3dKd/+ne8d61gO8j5G1AOrSiFd0CiC4JA5a?=
 =?us-ascii?Q?Gs4lAPVOgYE9uU3UDq0PuNVgwFL2+JKWZ7ZSGlJAe399G0Et8ap61LUxhD1L?=
 =?us-ascii?Q?HmmmLfF4h5dJpn+Tmru/cX2TNEnlRXHA2wCw219JcFb5kF1alxreJCWk23gn?=
 =?us-ascii?Q?mwwOTv57LLXE7RIJdGZN81qD/oblDKlVhyPSH2f/+/U26G47NMdSMa1tgAfM?=
 =?us-ascii?Q?/hydu/L57SyEPGElXZ4Uiaul8lu5xOlGhQfMgM+CPWwbXyioX7Q0Kva5kqYr?=
 =?us-ascii?Q?weOK/QtINRha30yykEL4837N1h4aNYCI9H52q5uK8pXSZLY+7T7dgcWEc8t/?=
 =?us-ascii?Q?WsQJU/TIS0RIGTh6liPxRkRHzTqtrtOISv+IyjKUsN/2+Ga4dX/RhpIxGK+A?=
 =?us-ascii?Q?cShMO7xfNxZ8DiSV2obThfV1Y4bYESp2uCEb52JUHh7fyL3EoNYbT1ho81tK?=
 =?us-ascii?Q?Dkjn6nOj/pGJGfc8JD9asP9Ku3AyvKB5G4U47ru5K/7VV+Wv8PFFee4ajymq?=
 =?us-ascii?Q?WVur70HvaLx35ceWX33GnDOF/SCouBK5lIh6zFUt3wMvaxt4niZJB1GNsbPN?=
 =?us-ascii?Q?hGKKvrMS/QkxGASXLNmN8T7KBjrwm2yBCVVLhAfoYznGIWa6XLWH2wS/aFAX?=
 =?us-ascii?Q?KPzgrT7FjYCHp66mnCjkh60lOOAE6lSgT622/qTSwSe/4t50O32W1QBaNqLZ?=
 =?us-ascii?Q?j5To3mH6xw2KyNup3/u3laIQg/+rJ3P/Dm4bS/1feKZxRzyYFmYhC9i+s2y6?=
 =?us-ascii?Q?PiJbKkIXtLqQ4iEo4pt9XnHU3wjQPbE/JXA7v9mEGsBHYd+hURZrCV1lH8XM?=
 =?us-ascii?Q?tzThaLCe0O2ahhXPpRDCIJiaw1iu8zPYXD6TK3x+t1gc4blp3KCEYHKuugiz?=
 =?us-ascii?Q?ziagWSX7FieLUIf6LWTYlPT75Bivsc1rDTyhu9/GpOBp4LE5XjsfhaQ/Pswr?=
 =?us-ascii?Q?eorKGzCJ2JCg6HOHCm6zVyJBkeCJILkv8Zs08AtF+8zk5h6CHkBz3L4YsGHU?=
 =?us-ascii?Q?A1m+Mvzy+0toT5sW88gfqx4GvFHg8ZY3038eECuw5TpjUz7HFhlkSGeA8rwW?=
 =?us-ascii?Q?39MMl+yKzFL1I39Bp+EY0dpZTkHo4Rg0f8aHezq5ZAdq7Eqn41LyIAxjoRYB?=
 =?us-ascii?Q?LObST6OwJ7u6FoB+q+GejCA9BLHEwyOfmqTtzbxJIY++Fr/9UnVUpVeKIoF+?=
 =?us-ascii?Q?YqavQofh43h17m1dokfiT4fBjIlFnS9xkDIC6NQSgFS81ubJjsmO780Oaa4m?=
 =?us-ascii?Q?ZdGk4rp7vVRZjmB2I1WSJgjK7d1z81ltE4NRahoMhpV/E/HrdBPC1cQlR0ii?=
 =?us-ascii?Q?dVAjWr7r2jgVLIR7PvDYFjVHrlnJVauR+oWjq34mwbcQGtit/KdHq0n/x2p0?=
 =?us-ascii?Q?v2WI7mvDHgvICbXZKvlfMlJUDE5OFv5KPZ2mD4UpECY0r86ANF/P6yk5Hi6/?=
 =?us-ascii?Q?Sqy4P7+NNl337F+526QjOQhPjeCAzId/wIkjvbT7Ze56CvkNbKzEJ3e+SleX?=
 =?us-ascii?Q?jDVcqSTzZRuOf+9Piaw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97940ce1-d020-4444-4e19-08ddde5c8b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 13:38:40.7825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GrHEHMUbdtkQumEsVX0ssCWyiS05/MoOUAuw743QObjXLTflqLY8T5AHeuQ0TI/C8WN+9PpQKedfRhqVaIkSNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222
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


The patchset consists of the amd-staging-drm-next branch (Head commit - 96c=
fc62d3b6ee1db4f334751ca4180c8bbd67f01 -> drm/amdgpu: Add description for pa=
rtition commands) with new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using KDE Plasma and Gnome.

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
From: Hung, Alex <Alex.Hung@amd.com>
Sent: Wednesday, August 13, 2025 7:18 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>
Subject: [PATCH 00/11] DC Patches Aug 13, 2025

This DC patchset brings improvements in multiple areas. In summary, we
have:

* Fix Xorg desktop unresponsive on Replay panel
* Refector by optimizing functions and deleting unused code
* Attach privacy screen to DRM connector
* Other misc improvement

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Austin Zheng (1):
  drm/amd/display: Setup Second Stutter Watermark Implementation

Clay King (1):
  drm/amd/display: Delete unused functions

Lohita Mudimela (1):
  drm/amd/display: Refactor DPP enum for backwards compatibility

Mario Limonciello (3):
  drm/amd/display: Optimize amdgpu_dm_atomic_commit_tail()
  drm/amd/display: Attach privacy screen to DRM connector
  drm/amd/display: Avoid a NULL pointer dereference

Rafal Ostrowski (2):
  drm/amd/display: Add LSDMA Linear Sub Window Copy support
  drm/amd/display: Align LSDMA commands fields

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.23.0
  drm/amd/display: Promote DC to 3.2.346

Tom Chung (1):
  drm/amd/display: Fix Xorg desktop unresponsive on Replay panel

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 142 ++++++++++--------
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  19 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |  11 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  70 +++++++--  drivers/gpu=
/drm/amd/display/dc/dc_dmub_srv.h  |  36 ++++-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   2 +
 .../dml2/dml21/inc/dml_top_dchub_registers.h  |   2 +
 .../dml21/inc/dml_top_soc_parameter_types.h   |   2 +
 .../display/dc/dml2/dml21/inc/dml_top_types.h |   2 +
 .../src/dml2_core/dml2_core_shared_types.h    |  12 ++
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |  10 ++
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  36 ++---
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |  15 --
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |   8 -
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |   5 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  21 ++-
 16 files changed, 265 insertions(+), 128 deletions(-)

--
2.43.0

