Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C570606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NziLzXFi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 319BC10E285;
	Mon, 26 Oct 2026 13:22:16 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3254810E285
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 13:22:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1IJ3nGpQsBvKIi5FN2I3vP0Elu7FLFjtvsvLj8zaXmisKQg87ubPtdnZyNNFNQBDlhPstdYn0LkM5w2RGmWuYyJuZrUuZbM1O0fQMpAtNYI4UKoAG3U5NMZ3GXSgKmKxZ/fRoH3W/06nCTHaqLYYaK+eN12hsPUNKO82v6KZjzHMWltzqhyOtelyOSpDBEHDUPFmTuG4WPL7dH2IHXILsYr7NW60rpH1k53pVVsO43xmNLZxVu8QGyLi7VKLDjNvZSGnvdcQKqNE/vwXW3Xhhc44M9Qa91j4TUIlgcmVi4zvQHq16F/dZ7wFGAzpvavN8ecXl48ci1G5CXqnbo5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQ761DjsxYN2ChSJHYHR03n7D1nVr205Xt6QRGcfidk=;
 b=csBltVCgS9MbvHkphi99kXiJV18AOIe7R9XQZpYwHeJqYa5plM/VAiwX3zmCL6UPUJweb61A5sdaRUyDynMIDzE0fAVw0zr1brzGYgZdAqN7T++glDHLI1oY8W10HC9r2XCMMiIFOn/4OCbAFH5zxSDML2i0Qk7PxpMKNz6JH7S+RhvvZjHClzpaLs/RUG6zt0rRQda7I+24auGShu+ltU+7m5D5l7s4LzM+fEkX/8MbayM+lvGMC3yt7/GyJXzCkIzGNxzd3RtJtT4prir2HtFH2T8FgcEakPwcHhKrRQOvxsTjq5zb4PODyTyK0nBJj2lYhVteASDyIjfNXy/xyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ761DjsxYN2ChSJHYHR03n7D1nVr205Xt6QRGcfidk=;
 b=NziLzXFiweNAq0jBIlDPvjYMp3D9Y8vmOErwoVbGY6Dxy9sVNIkdQYEtjtjtGbEqkSGJk0P15yKCYSkUOtU25bAnN6R0kU+KBOIOaNVpKJGvOUUEOgpv0sPUz/K7jxBOc2O26FkbFiz4BlIAziHZYu4oImIzYQm5tg6Ty+XS11M=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Mon, 26 Oct 2026 13:21:37 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 13:21:37 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei" <PingLei.Lin@amd.com>, "Chen,
 Chen-Yu" <Chen-Yu.Chen@amd.com>
Subject: RE: [PATCH 00/49] DC Patches Oct 26 2026
Thread-Topic: [PATCH 00/49] DC Patches Oct 26 2026
Thread-Index: AQHdYST8Uv1NV/bmlkO/ev26e7QmlLcP10/w
Date: Mon, 26 Oct 2026 13:21:36 +0000
Message-ID: <DS0PR12MB65349A116A9329A49525E6B69C612@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-26T13:21:30.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SJ0PR12MB5676:EE_
x-ms-office365-filtering-correlation-id: d362e3ed-78e3-4bc7-a0ca-08df3364101a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|11063799006|56012099006|261021135927099003|261021121427099003|261021123027099003|261022113327099003|261022105027099003|261022075727099003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: y63TtmrPSz6gwwcqNFHuiDBsVOMmHQlRfu6aozE287rYliSEg+r0GvrtFDZnvLu7hzin11pXJNVnvTf1jYo8Pj8/7DctzhU5dlXAuKYfnVs9x7647NH7hZbxL56gwcXtH4X+PAZ3wOj3DzF/2fxta9atmy3xGFwy1aRhD9nwQzUffL3T6Vq936k+nAdaCbop8wj0ZRCDxRcehzDnJ+tWh68uca2+/ZSmfqcCYtL2K/eTOP1uzZM/cmL6HsmquxSaUZ29tlUepAEaQowzENbeyEkseMrRMkuqsTM1//Zg+iy8EDsmQkkjuEjITNl4G4rArayekEIcJ9/0DUfe1H3JMDmy5LWYxuMOFWkcMT2wvxU8HnXFh+GZQVcs9A/kw3eHU2wXepTbkzwnUsKg3hu2MNxHAKOiqzOtktLtzfpTLOgGQXb03xhQtUo3sYkoeA2E/bPck5lh2FrF2QKzuU+qYUjU4wEkbz6xYpoKkp1B+ovMhqDpm3bfPhTBAzEUd+QO2zkoKO3FYjR0TvT20c9aeWmHxZDNYxVBJKyhkTxvvev6lR8P/Et76R7ZL/GN0VHDGbNKEDiJ8wR22PR1ImAQKXKfa+DP0KUlr5ZRb6WRx6B/rzOZHfOCrL6fp7QsAq2uvxHXW3DeqJ6rYdLMDb2SfXUM+Vrc6Cz9xhmhDywVN2YANxHu1Qflk4T8q7kbepasb+84oqYAH8zQQ9YDb85f6A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(11063799006)(56012099006)(261021135927099003)(261021121427099003)(261021123027099003)(261022113327099003)(261022105027099003)(261022075727099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8AAlV2I41lnVRM0pA+2UfoiRmV0dTpl4ncEanuxhqrw3pQaOrLFwmMvNaf?=
 =?iso-8859-1?Q?0X0Qk8akee4cvgpRwXTetZ4Ivlth7sQiG2V8d0ynsbVMWqt2BrGlw+Fmmq?=
 =?iso-8859-1?Q?c5l0EItN+qQDVTtnNU1cXA3TCtdmRN8RwfF9J2JubteYvVnqbStOqrsFHt?=
 =?iso-8859-1?Q?tvI9ZBleEbgTKNWeLykhae3HKkTFIO8v25mucSyIRgSr3yKQ95Q3A/QUPg?=
 =?iso-8859-1?Q?4DJaDcpORvi0VpaUI9YH9ZtXq+cmBd/jdFSF0dxLJNKqcrmftXT7axeoLB?=
 =?iso-8859-1?Q?B75uIxkWw6HrIK9yn9UIzvoadKDgCDuhJpOFGrtUWhJdCu1HmgjXwb18Od?=
 =?iso-8859-1?Q?jGh+74exXvKRC7lR4qMgQ/ktOz7fSJY10yG7rzxcZa68g2e9qEXiRiib6+?=
 =?iso-8859-1?Q?KvMLAiFCIW5Ib6Eicvj0JcJRtOZcphdj8PdkGONiM1TgmC+2WP6jFyEKyX?=
 =?iso-8859-1?Q?mQMzDfXCSqaQsDZerMp4gD6YmPxDpqAilY4cEJa9apbT0v8xmELfwYRj43?=
 =?iso-8859-1?Q?Co09bYCQbJGKMW+rhdqvY8F6NTuPqlxcLPJTpwpGOLCKFcF4fF6/x5mtV3?=
 =?iso-8859-1?Q?RI4Dk7xPWpKJ7REyLh+nlyvBTugIK3t6p+abe0IItXxWE2bM38I/wa9HgE?=
 =?iso-8859-1?Q?2YvHHqpDeVHNs12NWtPecD3NV1OHe5ViPDoBnqFCPy4moYlWB9egKJjxeB?=
 =?iso-8859-1?Q?Z/qgNLqZPqF2OP6sb0vj5etgZBOMCMh3kuIxG2w0d1GLJ8xFQj2Qhpb7+C?=
 =?iso-8859-1?Q?5eIjmMJv4BOTHA/EPAUZAdyQ+CaplMroFe1KzshJdZeZz9qi4j0YUJF5i2?=
 =?iso-8859-1?Q?VKe/MgLkg/7s7qd2rcMW1XodRfJdwbA0WNS7eNVzZEYlCG9thKyA2JGtsp?=
 =?iso-8859-1?Q?sUrjm3q9Wah1V7j9SkFeOH5ItqhTmI5ZAM/K/8fvrnU3TQpnyBytpzQ6wb?=
 =?iso-8859-1?Q?g7S+w3tAJFWkGpmMb6Dba6wrzBBlbH++G/WbcgV9CYktcEVswCiIMOCUrv?=
 =?iso-8859-1?Q?pRgMI6mv7MkVUUBGAe551ZsqGt0K/z7pxtA9Dvy4zus0IgvZHTunLh14k7?=
 =?iso-8859-1?Q?jhNolWBvisE2/SXU3oVHqTPVLvnur0MW2t2IG9mbUtLGCR7p8ORYQ8mWhv?=
 =?iso-8859-1?Q?AIVYFWLeTQISa7oIbofusdSBaCwQzeLifWjpBHIRwaQzcs0OWtc1R+zkJ+?=
 =?iso-8859-1?Q?Vq83JWQN8F9zcOsbzkEMve2MGv9Jnlw4FSDvHGjGoy3yj/3cJVLgoT+7+5?=
 =?iso-8859-1?Q?LBCNq5vnaKvJARXfiY7cBHHbrrTEHRrF/aZ91lc6kezn/SU5EKtvLbAgtA?=
 =?iso-8859-1?Q?vcDNoQbH+6ilf0Re2OA0jJAvULTKm7zd0DtDqs9MRL3Fw8a40SGNKxiRh8?=
 =?iso-8859-1?Q?BoHpLdYwTrqbzSLIgYEWL952h51/gpjHVcirPIxPONah+iYRiuA2X2uIS6?=
 =?iso-8859-1?Q?uvq+dsYeVYKyDEq+H4pYlIa6q7ZaBmqnHdhXXCAtOLA+xjs1U2hzeAZx+I?=
 =?iso-8859-1?Q?vU2dvlAnLStk75L9Gs8Php5bVRzGyzAK81ZJhzFkumFbmKVS0di6+1zMgL?=
 =?iso-8859-1?Q?CxRhBLTX/oRb24k1hSF+NU1/My9XG1HHUG9LXBvXW+stU7HU6vk/zSa6x2?=
 =?iso-8859-1?Q?ulGYGiIUqmP196xSCvxX5PTNyo7xYmzPUBAZ+Glq/4davobOVdVc84slR5?=
 =?iso-8859-1?Q?lydbaGSl0GMkeG6wvcSSgykImZi7DTF1X9bMjsjQK0B3unG2SLP2AuICb6?=
 =?iso-8859-1?Q?HnaJBnjXOu84NUwoPKcPdM0/Kbi440J43/AG2dfGKhpFke?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d362e3ed-78e3-4bc7-a0ca-08df3364101a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 13:21:36.9468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VfX2x+UrkSbVjuU8TnxyDxpfUezkwswSnHEQwSiolYcuLGO3jI5YzCYAsHGJ8t2Y/ILxk3R7776veYa18t1k/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5676
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Public

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


The patchset consists of the amd-staging-drm-next branch (Head commit -> 6c=
f9ac79fec2758320a133138eaf06a2f8bf2cf4 -> drm/amd/display: Attach retained =
DMUB windows to PSP reload) with new patches added on top of it.

Tested on Ubuntu 26.04, on Gnome Wayland.

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
From: Tom Chung <chiahsuan.chung@amd.com>
Sent: Wednesday, October 21, 2026 2:22 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; =
Chen, Chen-Yu <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/49] DC Patches Oct 26 2026

This DC patchset brings improvements in multiple areas. In summary, we have=
:
 - Add Core 2 BLS initialization scaffolding with builder, executor,
   workaround manager and DMUB dispatch.
 - Run DC2_DC1_Wrapped dcn401 init as staged BLS builds.
 - Split dcn401 init register writes into hwseq funcs.
 - Read MPCC LUT modes, cursor lock and DCN401 PHY state, and add BIOS,
   link and DSC sections to get_hw_state.
 - Fix QoS bandwidth fields copied from DML.
 - Convert update scratch to memory pool.
 - Pre-allocate DC state for atomic-context commits.
 - Preserve planes on DPMS-on during DP test link retrain.
 - Poll passive DVI sinks for EDID readiness.
 - Re-init cursor offload to DMUB after resume.
 - Add fec_status check flow for 8b10b links.
 - Revert DSC programming changes for DCN60.
 - Update alt-ch size calc to handle MPO + ODM correctly.
 - Cap DSC bpp for USB4 DP tunnels.
 - Add debug options for DMCUB FW loading and forcing MPC combine.
 - Fix CRTC init cleanup and pipeline name OOM handling.
 - Various cleanups, coding style and KUnit test fixes.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (11):
  drm/amd/display: Handle pipeline name OOM
  drm/amd/display: Fix CRTC init cleanup
  drm/amd/display: Flatten CRC update flow
  drm/amd/display: Clean up allocation handling
  drm/amd/display: Fix coding style errors
  drm/amd/display: Fix KUnit connector leaks
  drm/amd/display: Use kunit_kcalloc for arrays
  drm/amd/display: Destroy dup connector state
  drm/amd/display: Drop single-entry kcalloc
  drm/amd/display: Use kzalloc_obj in tests
  drm/amd/display: Assert NOT_NULL on allocs

Alvin Lee (1):
  drm/amd/display: Update alt-ch size calc to handle MPO + ODM correctly

Ashwin Santhosh (1):
  drm/amd/display: Pre-allocate DC state for atomic-context commits

Austin Zheng (1):
  drm/amd/display: Expose Generic Function That Can Be Reused

Charlene Liu (1):
  drm/amd/display: remove not used code

Dominik Kaszewski (1):
  drm/amd/display: Convert update scratch to memory pool

Fangzhi Zuo (2):
  drm/amd/display: Poll passive DVI sinks for EDID readiness
  drm/amd/display: Cap DSC bpp for USB4 DP tunnels

George Shen (1):
  drm/amd/display: Preserve planes on DPMS-on during DP test link
    retrain

Ivan Lipski (1):
  drm/amd/display: Re-init cursor offload to dmub after resume

Matthew Stewart (1):
  drm/amd/display: Reuse mpc401_read_mpcc_state on dcn42, dcn60

Ovidiu Bunea (1):
  drm/amd/display: Add debug flag to support for different DMCUB FW
    loading

Peichen Huang (1):
  drm/amd/display: fec_status check flow

Samson Tam (3):
  drm/amd/display: Revert "Program DSC prior to OTG enable starting
    DCN60"
  drm/amd/display: Revert "Add new config_dsc hwseq function for dcn60"
  drm/amd/display: Revert "Split link_set_dsc_on_stream into encoder and
    DSC components"

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.81.0
  drm/amd/display: Promote DC to 3.2.404

Tony Cheng (18):
  drm/amd/display: Add Core 2 initialization BLS scaffolding
  drm/amd/display: Scaffold Core2 BLS builder and executor
  drm/amd/display: Add Core 2 Workaround Manager scaffolding
  drm/amd/display: Scaffold DMUB inbox BLS dispatch
  drm/amd/display: Scaffold generic DMUB GPINT BLS dispatch
  drm/amd/display: Scaffold DMUB STOP_FW on the init BLS
  drm/amd/display: Name the init STOP_FW entry DMUB_HALT_FW
  drm/amd/display: Scaffold PSP reload, ABI query, and Initialize DCN
  drm/amd/display: Call the init BLS from Core2 hardware init
  drm/amd/display: Attach retained DMUB windows to PSP reload
  drm/amd/display: Split dcn401 init register writes into hwseq funcs
  drm/amd/display: Add dal_gpio_ddc_open_aux_once
  drm/amd/display: Dispatch the dcn401_init_hw calls from the Executor
  drm/amd/display: Narrow the DMUB-driven dcn401 init builder helpers
  drm/amd/display: Run DC2_DC1_Wrapped init as staged BLS builds
  drm/amd/display: Read DCN401 PHY reset and lane enable state
  drm/amd/display: Read cursor update lock into mpcc_state
  drm/amd/display: Add BIOS, link, DSC and cursor lock to get_hw_state

Wenjing Liu (3):
  drm/amd/display: Fix QoS bandwidth fields copied from DML
  drm/amd/display: Remove deprecated bandwidth Kbps fields
  drm/amd/display: Add debug option to force MPC combine

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   69 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   22 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |    4 +
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |    8 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   12 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |    1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |    5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   24 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |    4 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   17 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |    6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |    2 +-
 .../display/amdgpu_dm/amdgpu_dm_services.c    |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   |    2 +-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |    5 +-
 .../amdgpu_dm/tests/amdgpu_dm_audio_test.c    |   84 +-
 .../tests/amdgpu_dm_backlight_test.c          |   48 +-
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    |    8 +-
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  |    2 +-
 .../tests/amdgpu_dm_connector_test.c          |   80 +-
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     |  248 ++--
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     |  168 +--
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c |   24 +-
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     |    4 +-
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      |  329 +++--
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c |    2 +-
 .../tests/amdgpu_dm_mst_types_test.c          |   12 +-
 .../amdgpu_dm/tests/amdgpu_dm_quirks_test.c   |    6 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |   30 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |    7 +
 .../amd/display/dc/bls_builder/bls_builder.c  |   21 +
 .../amd/display/dc/bls_builder/bls_builder.h  |   98 ++
 .../dc/bls_builder/bls_builder_internal.h     |   11 +
 .../dc/bls_builder/bls_builder_legacy_init.h  |  128 ++
 .../dc/bls_builder/dcn401_init_builder.c      |  413 +++++++
 .../dc/bls_builder/dcn401_init_builder.h      |   42 +
 .../bls_builder/dcn401_init_builder_legacy.c  | 1071 +++++++++++++++++
 .../bls_builder/dcn401_init_builder_legacy.h  |   18 +
 .../drm/amd/display/dc/bls_builder/dmub_abi.h |   13 +
 .../display/dc/bls_executor/bls_executor.c    |  703 +++++++++++
 .../display/dc/bls_executor/bls_executor.h    |   21 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  125 +-
 .../drm/amd/display/dc/core2/dc_core2_init.c  |   78 +-
 .../display/dc/core2/dc_core2_legacy_init.c   |  236 ++++
 .../display/dc/core2/dc_core2_legacy_init.h   |   17 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   33 +-
 .../amd/display/dc/dc_api_dispatch/api_shim.h |    4 +
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |  173 +++
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c   |   22 +-
 .../dc/dio/dcn401/dcn401_dio_link_encoder.h   |    8 +
 .../dml2_core/dml2_core_dcn6_calcs_dchub.c    |    7 +-
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.c |    2 +-
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h |    1 +
 .../dml21_wrapper/dml21_translation_helper.c  |   11 +-
 .../dc/dmub_messenger/dmub_messenger.c        |   81 ++
 .../dc/dmub_messenger/dmub_messenger.h        |   55 +
 .../drm/amd/display/dc/gpio/gpio_service.c    |   19 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   48 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |    3 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    4 +
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |   97 --
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.h   |    1 -
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |    1 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  229 +++-
 .../display/dc/hwss/hw_sequencer_private.h    |    8 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |    7 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |    2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |    1 +
 .../display/dc/link/accessories/link_dp_cts.c |   19 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  336 +++---
 .../drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c  |    2 +
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |    2 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |    5 +
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c  |   10 +-
 .../drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c  |    2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   10 +-
 .../dc/resource/dcn42/dcn42_resource.c        |    5 -
 .../dc/resource/dcn42/dcn42_resource_fpu.c    |   22 -
 .../dc/resource/dcn42/dcn42_resource_fpu.h    |    1 -
 .../workaround_manager/workaround_manager.c   |   74 ++
 .../workaround_manager/workaround_manager.h   |   46 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   11 +-
 .../display/include/gpio_service_interface.h  |    6 +
 84 files changed, 4603 insertions(+), 997 deletions(-)  create mode 100644=
 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.=
h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_=
internal.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_=
legacy_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_=
builder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_=
builder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_=
builder_legacy.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_=
builder_legacy.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dmub_abi.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_executor/bls_executo=
r.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_executor/bls_executo=
r.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_legacy_in=
it.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_legacy_in=
it.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_mess=
enger.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_mess=
enger.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/workaround_manager/worka=
round_manager.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/workaround_manager/worka=
round_manager.h

--
2.43.0

