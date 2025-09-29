Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03316CAC5B5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Sep 2025 12:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A515410E40D;
	Mon, 29 Sep 2025 12:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N56YpX3g";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1DBE10E40D
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Sep 2025 12:57:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0lGK98pXggZmc6nmiaadDjHONMfU6xDoGInb7W+30nNOw20J8ugobMhG+vs909yXFyi/O9Jccl/+L7jGiu4IgVAi3z4bhLjEA/AloXYtwDxj1kqWbhBdZ3WWvaQ6zdQZyRgThyK2qkddcNRfADScVnEDSyWnPbYAweUTeRWsau4r5eieMS6gQd003S2d1lW4v6sykIg0DRHy175OWGJguX8SXOYiWY+JpH5RJBgaoyey70mZjzrhaybNnDtDBdMq7pvwpvbLSmEx0iFPlPOIDFF0YaXe+mjfLf28oegG9IxMyFbIzko2mEcKklilwjx0LBBMijNh1+kkufQ8GDbsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5P24VwClZXiwzIb+Syk1DUjEqJfpGar/CS7iUqacQc=;
 b=IIjqkfhOjH/TC6jRAhhIg6kK21/zUeuxn/tRf7KvwwgC9c6RgPcamREgLxi3nwYv+Kv+bns1rk/Z48US6V/RQSAkG/bA6E6Dp1M067axY616vjxtocN+AsxXcFusOHfX0WWmktFMyKdjo1Uz4LI50Nve+p/PIdg3/5wbQb/Q5fJY6//FzN2n8A0+XfzDR3OPbui3o4LaIp91EzB1t0PMMiBrpXkoOWBDVVKi6okULX+Lv+L5F9x/zcE5P2eJQ1sO/m+F4vSMF35SzK0zVRCPN2Ou6DalP7jZBzIYoDXkD1YQ82vm3F7uNWpY//Rsv2QSysUd8ZXcDzLk68Za73UL9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5P24VwClZXiwzIb+Syk1DUjEqJfpGar/CS7iUqacQc=;
 b=N56YpX3gHwezfGcOhXosw+usxNrwXbWJmdcJ8UEkkrf6SUkfubZZRZ3/9/jiD95vAnXRQN9l/LLbjMdUQbwJ+4EG6zvxrZmLj/VcBQqU7i98860XexhL9tazQ6ZP0gZJq5mZXAe1hakuW3Ng0Y7JxieIWu/9p/LGrv/CeafgJ/g=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.16; Mon, 29 Sep 2025 12:57:26 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%7]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 12:57:25 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Li, Roman" <Roman.Li@amd.com>
Subject: RE: [PATCH 00/10] DC Patches September 24, 2025
Thread-Topic: [PATCH 00/10] DC Patches September 24, 2025
Thread-Index: AQHcLYArZ5PqLnznQkKtefdntmuVx7SqJNhA
Date: Mon, 29 Sep 2025 12:57:25 +0000
Message-ID: <DS0PR12MB65348D442E0F732AA97A507A9C1BA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250924182201.1049389-1-Roman.Li@amd.com>
In-Reply-To: <20250924182201.1049389-1-Roman.Li@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-29T12:52:45.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DM4PR12MB6158:EE_
x-ms-office365-filtering-correlation-id: dbcc72df-cc51-4f09-63a8-08ddff57bd33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?3guLkd5E5fPQNU3G2wIXV5IngV2z7OOXI9B79mSXzXzxB+dge4HP0xkDM/?=
 =?iso-8859-1?Q?LEL3IdBJ0HMqxGfHhaAfsnjeScnXIQV+hlwj99RJc48ThY7shItSQNslFS?=
 =?iso-8859-1?Q?rJnAgGCCnQh0Tr68KXmYqG/i+fxQwqeBYM+u8MILpBvyReWcl7uWOhCFji?=
 =?iso-8859-1?Q?T5ey2WyjX0sD16Fn3wQmxH2WM+5AAZ0mMDG/ef5FyQKPR2YC0bNXYBw9F8?=
 =?iso-8859-1?Q?z3SC2/rdVdQdNnGrg2HRlqvTiCfgU7SNIioHvSZ3BbfZNynFwq+hhgEcBu?=
 =?iso-8859-1?Q?eFdGMygB2Q44OBOxij2kpoRPciyXBnpaLmsfnqQ8w8C6RK+nDuk3F8Judt?=
 =?iso-8859-1?Q?m1fWWxADDUoX7rwORGlt88CG7OOg1JmFicaXcrNyhD60CCaXdHcNotZsxp?=
 =?iso-8859-1?Q?ThDXs4pqoD1U0Zy27sosWbHKDH41yBYlsHQxFOxRkInSrtv0A7c6xLKLOH?=
 =?iso-8859-1?Q?p8YLqWUJ/eLwFHaQDR+3vVDEpUjfEjh+VXy+sl6n6St9Fg81/3+SruZ8Z7?=
 =?iso-8859-1?Q?67+cfQPT2eavV7uGW7xPKkAYOAUJ0DmBY5ETmu+RQ0TByiz1Kvzor32oZV?=
 =?iso-8859-1?Q?Os6db3vhOQohuLhgrwdTv2iTr1iu1NhrNFJIXiJRuMJFijV8ezwhM4nuIg?=
 =?iso-8859-1?Q?sA6VYYmYtz3OsuCy7MLMljt6lQLSR6c8PuIJmWIu5T6anqT48JINtpzwON?=
 =?iso-8859-1?Q?Ojj9pXrjMipNaLtQYq90iY/dGdSM0pPSWV8A7klvFDI3K17egzRK9GOD8d?=
 =?iso-8859-1?Q?N0hRq2WLMcplOvjBapvh/Fg0Byz1Av/hXqjCghZaigHPv2mCPf69hBV0g2?=
 =?iso-8859-1?Q?4nbV4zbcHGES5Un4eXpPW4YdwvdwdP1lqG1mMzZfAk/fIIePBn5VtN04ES?=
 =?iso-8859-1?Q?2JDzSBArhXb3xqLqHxRpxaCbdyHPyCUOdhvl3v8DQaiWuFxnb95sQkJO8t?=
 =?iso-8859-1?Q?P1WaqsFt/me/h8eMvnOtegUm3mMJ/wWXEAhZrPg4DLffIJBsNyvyaHXHO1?=
 =?iso-8859-1?Q?/7nbEsUaW+4dk7UC9cKPVvo5j2alrPwPis4yaBXb1+qVDxBOW3dBesCKRG?=
 =?iso-8859-1?Q?9c9sqfOaAHbmvPq32bY4Gt8uPX4WphYlKQwrFJb+hvagaVJczSYTSrvit5?=
 =?iso-8859-1?Q?GaYVdc4QaZ1G1y5+bLOTtylME5emAcCSVLVUZpsaE5Vh5MQzRZHoAXa+tn?=
 =?iso-8859-1?Q?J9Bc2Yznyeg2SCFSOhm/RHR+kCFCYn6JEyhCsqDe2YxCMs6gR/toLs/DWd?=
 =?iso-8859-1?Q?9bEy3Cc5r2QJLhMMg1Gvx9xMY9tKb2MXRMePLkPO0ooVm9mbDrW8tzyGpz?=
 =?iso-8859-1?Q?celW01ZqaDlNk8pbvbrhcmHJ4FMVfXBY3gy8tV1MLC/+MvJ1QqqC8tPP2F?=
 =?iso-8859-1?Q?Jc9ORerG1bn9KgBwXIFPp3FmeDFDge61f8eG/p1MNHoTOa1fsuRCen1lYF?=
 =?iso-8859-1?Q?BAVpagNromCygCJSSqb7OjeUyYvHbNrMkZSi8DvHokn7DvVI6VhJgFPHgd?=
 =?iso-8859-1?Q?NCr+740eznG2jNpM/3JIsyypOqCiLMls3Z1zlexiTvkH7lAfPv5Q/6zPEm?=
 =?iso-8859-1?Q?84UeTFT3F0YHzN1YuMC2VkyTqLaz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TwewRBYyvh5FAmw/l98Jd18toNQAr4/FfnA4OtYWwynktjncsfYjaI8CDQ?=
 =?iso-8859-1?Q?ka2v5mKBr/5RHN78aHwTTmaTwnn/5KYbSm/LPKTxF6yVHhiNp7N30lq9Sb?=
 =?iso-8859-1?Q?vOMBNR/psDgwq6nTJ2iqLk57PzE2KxDlieNF+k8mbftgYAbaaEt14v25Ta?=
 =?iso-8859-1?Q?2lFNl10n3l6P5quHb+QZeRyEFTwQAv+P7Kocn5EVSdCDj8rvikaSmSuOlm?=
 =?iso-8859-1?Q?ox7zsqEfDMeRcqs5oHwm2tCJkFaNndtGwHUCSv/J04wv/r1pOmnXuZV7eY?=
 =?iso-8859-1?Q?KJfr0Q4B6R9ozlNDz/1LHoj2W3+3s0bCTna4Gb3AOmsIYBQRRaTeNqNvfk?=
 =?iso-8859-1?Q?jjHPg9ixBpsbiJOIZ85qB7EGK0dOCK9wSIJ7x8BfEzc5550QiuYgXUoPHE?=
 =?iso-8859-1?Q?SoJz4iRwzAnT+DMSjkdzTf4OSBEsIre3XgSWzgiUZGvcPVX4kFV2Qh8u89?=
 =?iso-8859-1?Q?4KDhbhttDsQLlW4znyJvSdDOH5QEl5gwBFG0ULIzb768WjgzI4432vAWf8?=
 =?iso-8859-1?Q?E5E83NWLaFO3RrLOW3WZgefcXoMH0hsF50tHxfDQK0SepoEJoP4zYRtQ/7?=
 =?iso-8859-1?Q?hjOaUQPQLWUXhOeGBJiymOezCI/cqQOq2lntVQpIc/BKFevIACW9aPqJdj?=
 =?iso-8859-1?Q?qUkdMvWdHkA2Qbgk4e0mq9552uRM3+SeXGTU7vbhQj8gRtrK8YvZ3hsVje?=
 =?iso-8859-1?Q?KJRqTyqNSqX7MGaxW5gY43XzouRqGktOzYYjafnSSHbU0OTsVEBY4T4Onf?=
 =?iso-8859-1?Q?6NfskiCWrOTr5fKVEoBvttQIhK0H/wL6gcREHyTqGuCzfcAFgDf0CnK1Ey?=
 =?iso-8859-1?Q?maR5p+ciJVTtQsUJAxOuVK34zHF0AgOgQd8ql+hwKFcB33KmXHK4PPHU6X?=
 =?iso-8859-1?Q?xj+ltAxO9UOZ+v4xLhCwFtf4Oi9jtOrG8n8PH5Y/5ouXTDvrh17hLsvvUn?=
 =?iso-8859-1?Q?2GVZkxtrWll3mOpROJlm8vXLM85v1GTPglSefOBcuKxK9Rj10sKHAJ+PNU?=
 =?iso-8859-1?Q?gniZoe6n+75sz7q5wPlclwnpv+dN6Gsk5pL/T3BgZ4eBBzwHMAqFpGCcEC?=
 =?iso-8859-1?Q?kIUX1yiNBvTy064NlWdUhU3pt7HUccTgSI5t9RYSJFjEUCSGlCkfGzoZV/?=
 =?iso-8859-1?Q?oCaQ+Mw7+wUt96tGaSTrGoRIdLbC3MbXlcuYlWFtfnFby00zz50ZhXpGiV?=
 =?iso-8859-1?Q?MBPIr0+bDKelxqHoGgHyhhI6FnvtvciUUuSmLpQHYNtXVHPjSDmIDZi+mq?=
 =?iso-8859-1?Q?W1TnYhV+sEXmrtHTFyHrwjnke13VRED5GoPuxVs+Ydp/Cp+pwcIUhJc7hu?=
 =?iso-8859-1?Q?d0VcyxzBSgtBkuvPa2UZ9MnLMKv/H915OOcXDHogTc77tJQnicw4SEHhJT?=
 =?iso-8859-1?Q?mUvtfQyCvlhthPgMcmjnHT8D0+wLmIc92qmvH6imWrEcEhUS+BVvpww6uD?=
 =?iso-8859-1?Q?VjkLgk26GH1ucx85vIZcQg7yGcuixPAke2L8f7J3VyXAjPwAsNFqu3qB8m?=
 =?iso-8859-1?Q?kgr18x258n2bkuFEd8Q5DtZokHxFzuiuZCmOa0QIPRYEL6jnKPSMo7336j?=
 =?iso-8859-1?Q?jSP5j7naAchHh1QyhOFUucACdEX9X7HwosSLWYW6LCAofuE6Y6FxQ6KenW?=
 =?iso-8859-1?Q?Yt0kdjVI6dmFU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcc72df-cc51-4f09-63a8-08ddff57bd33
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 12:57:25.7545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0W8KTKkhnIcU7irrPRs/D83lZBeoULlbFvElKfYhu3xc0nyDGr0mOMJNRpwjT/f/fycV1UaWcL37LbENYsJybg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158
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


The patchset consists of the amd-staging-drm-next branch (Head commit - 188=
0960e845adaa5a356e4ce3572f1e4c221c529 -> drm/amdgpu: Use kmalloc_array() in=
stead of kmalloc()) with new patches added on top of it.

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
From: Roman.Li@amd.com <Roman.Li@amd.com>
Sent: Wednesday, September 24, 2025 2:22 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Li, Roman <Roman.Li@amd.com>
Subject: [PATCH 00/10] DC Patches September 24, 2025

From: Roman Li <Roman.Li@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* Fix slice width calculation for YCbCr420
* Fix DTBCLK gating
* Use NRD cap as lttpr cap
* Consolidate DML2 FP guards
* DML2.1 Update
* Firmware Release 0.1.29.0 changes

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Austin Zheng (1):
  drm/amd/display: DML2.1 Reintegration

Fangzhi Zuo (1):
  drm/amd/display: Prevent Gating DTBCLK before It Is Properly Latched

Ivan Lipski (1):
  drm/amd/display: Consolidate two DML2 FP guards

Nicholas Kazlauskas (3):
  drm/amd/display: Support possibly NULL link for should_use_dmub_lock
  drm/amd/display: Rename should_use_dmub_lock to reflect inbox1 usage
  drm/amd/display: Rename FAMS2 global control lock to DMUB HW control
    lock

Peichen Huang (1):
  drm/amd/display: lttpr cap should be nrd cap in bw_alloc mode

Relja Vojvodic (1):
  drm/amd/display: Correct slice width calculation for YCbCr420

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.29.0
  drm/amd/display: Promote DC to 3.2.352

 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  33 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  24 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |   2 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |  29 +-  .../drm/amd/displa=
y/dc/dce/dmub_hw_lock_mgr.h |  10 +-
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |   2 -
 .../dml21/inc/dml_top_display_cfg_types.h     |  11 +
 .../dml21/inc/dml_top_soc_parameter_types.h   |   7 +-
 .../display/dc/dml2/dml21/inc/dml_top_types.h |  13 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  55 ++-
 .../dml21/src/dml2_core/dml2_core_factory.c   |   2 +
 .../src/dml2_core/dml2_core_shared_types.h    |  10 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  | 459 +++++++++---------
 .../src/inc/dml2_internal_shared_types.h      |  36 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |   1 +
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   1 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  18 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   4 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   4 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  10 +-
 .../display/dc/link/accessories/link_dp_cts.c |   4 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   2 +
 .../dc/link/protocols/link_dp_capability.c    |  38 +-
 .../dc/resource/dcn20/dcn20_resource.c        |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 204 +++++++-
 32 files changed, 663 insertions(+), 331 deletions(-)

--
2.34.1

