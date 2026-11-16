Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FFD606A339
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yXLX4BLv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAA9B10EE5E;
	Mon, 16 Nov 2026 14:22:55 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012027.outbound.protection.outlook.com
 [40.107.200.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B804510E908
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 14:22:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgHO66rJQFcxKPWGZ+aE4Juf8XFsjeLxxzNED1IezMqG6CSo6QH0eJ2UirD8j0vkNP3cGHXO42le3CdExx+ubnYEPFDvDgW4SoU/ds1OaEG1hJuvxpZkxRgDXk1p0GksYexctB/v+N7vehhuu+04SpwpPN8FVs5X7YoTceivI3zwDP5x8R6v8RilgXm9RIk8tfe461ILfiIJ/ft32plMpYN32iA7yqpfkrGrjv9UEkpZbKgkJAlKKv3BYQ8gBpfdRxrlzouuMkZGe9yn1yWatLtVpk51aRHzUhKgFGSIzAgxZmxGw8DQWFJ2Sg+Z+/09Mr0bQE+xvV4VC4u7FCLTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GhumSu4XQCoNmV69xl0TnlJSUd3CI5X1YpQgytmkk0=;
 b=QqiMWMNY99ye99w9CI7NxPOexK08gqx1qPFsJQ7XlYHfxVmpY4bKahIBsbEOInZnwPpddQAkdR68V6jeeN0kfy6VVMZsL2D0kpoew+C2A6lGva4RoBbCEOBXqkkh5Y0u2FnGOPIJLaBO5DmpqI1WdKdWiPsXWBcokrSqmsTw+Upi6m8jFq+eoz5vhh3qInBvpML7o5s0XpuT0g4pntYY1F6PlO1h1cdZIIpZ4DxoyEYdv+PV9/keYGYtN46wp9/+BZ4A5yAVKGWYSuPyjfb4M0b5wXfZ5z1s+GmNpvCOdtu5pc41tmjM0NTmfHOamULP+KW+A/6STqMMPIC3kJ4ejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GhumSu4XQCoNmV69xl0TnlJSUd3CI5X1YpQgytmkk0=;
 b=yXLX4BLvQt35HYTXX8NLxwt19bwua+nHBCYZC8KvNQGCEFI0PNiaz8M2+cdVYVzDw9krtgFctw9DM2h5cO4wq2Q66NmNNalhjO7G7RXzEMWk4Y43PlkP0f5vZ7XcRj27IjdBne20zdo5qFEG6/1qTrBW8GA4IYyDluBe1yNxiaY=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 14:21:45 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 14:21:45 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei" <PingLei.Lin@amd.com>, "Chen,
 Chen-Yu" <Chen-Yu.Chen@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>
Subject: RE: [PATCH 00/74] DC Patches November 16, 2026
Thread-Topic: [PATCH 00/74] DC Patches November 16, 2026
Thread-Index: AQHdcX2mhB4RTdmLxUmGrt335pMeb7cwyDuQ
Date: Mon, 16 Nov 2026 14:21:45 +0000
Message-ID: <DS0PR12MB6534333412F3E429C145FBB69C7C2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-11-16T14:21:39.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CH3PR12MB7739:EE_
x-ms-office365-filtering-correlation-id: 1432313a-ccbd-49e0-0ce2-08df43ecf190
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|6133799003|261009223027099003|3023799007|56012099006|5023799004|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022113327099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261021135927099003|38070700021|10067099003;
x-microsoft-antispam-message-info: pSq7qxC2hRGPDxwjTgLNbY6Qj+NT+CUp6lh3xl/oiCN1iAilLHLgsoZUSLfYT885vo3GyWV1SyyzXkP37qxN5FdZUdTBq5EYcscfQdcl900wuKQq/gaEHgyJ5CRsPw36ssJOM15grOEbgiSk1UPPF79FGVxapPVKqXsOkPXbVSGYhSlDCl5BWtYnUN/mEjHwBUFVSZOASa3Ld6RUEuJQrCUJ8/SwvYFG+XqFRITC8eW0ajqYN69a9JO6DqUqXQp7wggZuesSCuU41UoCkWWW0ugyhmAMWUe9MdxRaW62fO0/FtiooVeHf2eV346GUAH01nRvAgQkBIlJtrCKEU4GVM/ai/NuNyzWiVs40YoOkC8byxvlDgWOGzLpP6uAi7PWh1rCid+sWEELtHaXSwhkqNOcU7kYvIdIrEoJJXOmQHaxC3vW25zlnz6PqzLyALhsds9n8TyZ10byWwSXsdvUjXVoEGk1L/80wvzj02sH6/n0Xm97A2e6cfxe3nubSH/8GBzzxRrs6o5+Z0IJ8QbW5GAnHUSGqOpvR+HfQI+D8eObeMfWFja13nE3VffIoZ9xgIyRcCFRS5E6qq7/x/sOf520ubVC5KpAxS3rh88ZERGszWtgm6waGgtHIThczg79xm//LfaTYNF9TbIMXM55STEKIMRj306LNUeV85XsP27qmc4m4D7pQA7ribELOXG35cYOcFvkqCUg8gFb3GkY71VhM89fTGpnay3OpKDuzR4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(56012099006)(5023799004)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261021135927099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aODJL66JwBbyNQWtV1iiET2fuVfkL2V3t3pWnbJtSFFe87EfmzDbBppSu9?=
 =?iso-8859-1?Q?23ch1WJSMvNErBuoxOSLiuNM9i+S5Khdyt3Qhei5UBwMP0/DOIEOjZlIfu?=
 =?iso-8859-1?Q?zLC4uD1yyfEI+msNE4WsTHROzMTYQ20HWJC1Er88qFLJEu2QnwYA6G52Rk?=
 =?iso-8859-1?Q?cEcqz40/U6VL6PQq2zC78EIMf7tIpwyTNMq4gZFj3/Crf+anP1fqGYCz9Z?=
 =?iso-8859-1?Q?0Ycq0UPkN3WTP0BFdtbtsB7Uf6AgxUygr96jRBI3iZTcAICd79vezthrjt?=
 =?iso-8859-1?Q?ihEq6U5Ufu4AeXghVeNDbQHkJZsvpgBrcrIb4a4fuYN1d0XOUlNRQOLDL/?=
 =?iso-8859-1?Q?SP/T/JIunQ8y20xuwh1n5kxyvtzNpwHXaZI+33G95cb5gsk/EFfE/L7NiM?=
 =?iso-8859-1?Q?OsGO+/CKVkqDNaZuGAPDjZhDU+cMlPg5IWDUQr8v5mvyaBoTtxetko3r3c?=
 =?iso-8859-1?Q?vgwOxKiPTroI04s9d3XXmQIxepWkxwyYOquSAt8osDUbcoRWDiiO7uRNFH?=
 =?iso-8859-1?Q?1uxTwBRbRkH3d6+tkphGdxpxW3o+WPbUTbKDQvbryGqvda6mMibysFRsbu?=
 =?iso-8859-1?Q?qdUd09HQjwPotQTv8zKQJIXCMJ2cs+VPBYQZ4bgAEhmFQAUFcmwFOxBmWC?=
 =?iso-8859-1?Q?G3b+WD/owdpa47RwmDYdbeM5m5sBHorBktkipc6FUyz/zh8L7Yg4/vxvMo?=
 =?iso-8859-1?Q?/4pkRpituvCCbLqljON6Jrq+jFuQWgK7yFQ5cnbyynEL7G086dzJfZf79F?=
 =?iso-8859-1?Q?Lh8uQ5X1qNcf2jO9JveS1/HyWl4XGicEAgTulg5rwIml0snVn0OtR5Ssg8?=
 =?iso-8859-1?Q?BoR9oUEcYTOOD2doRvW0v3ugvl+1/ZUyFOcYIecwoVJa4Tf1IUIgFdpcjN?=
 =?iso-8859-1?Q?dQ3m85CLwM6GsHdXIMv5FY+2tdn05pv7Io3TMPQShjqHeZeAm2FFTg5Yjg?=
 =?iso-8859-1?Q?4LUS/iWNC5TFbYmGQSNVbhOFH4/0IkzUFOV7/flkbTymnI/yIl/sflXeCA?=
 =?iso-8859-1?Q?l8olfsUCdtnE8G/fxGZvzo+gnlkDxnPv7fjmeMJuYoukpJpwHS7bBKCawk?=
 =?iso-8859-1?Q?bEpB1MxBMyHcNLYNLEHgRCjpIrLzuUMDBlhXvPKw/1829788IoxeSnBXV5?=
 =?iso-8859-1?Q?2PmCqjCXaV35wFI9SnzJKk26TYpUDFRz5gs9XJJRnIsydO5+0rGLTCSw2K?=
 =?iso-8859-1?Q?OZrfo7imdGi5yRr8u9bAWp1Y1h2b7z+qyu1n0AKBB2D6KrMIGSkUOgFnAq?=
 =?iso-8859-1?Q?uz+U71fOXMYlk2MKvjWyszAcdvIwhHomve3UIADvsAxcK9jcj4dUJST3Dd?=
 =?iso-8859-1?Q?csV70pip4WWVDHHCgT3SKwyTIHFro782no/Xuosg/XHHTz0Zh643sC0Dzk?=
 =?iso-8859-1?Q?fiHjpQfnPRBd26l8DH4Nsrk1ooDo2lMJ2LgBoKDCO5l/ruw47Hgk37oEgI?=
 =?iso-8859-1?Q?1Lk7/8XBKeoIzWTYEccuu83TU2PZqSOruTWbXMjBK3rbSuGuADBCfgTDCm?=
 =?iso-8859-1?Q?9b7YBaMkOgK+IUDKSFWYLHRhviEXboLWhaxUX3vNeeo6aXT3NV2Qq5ZNDP?=
 =?iso-8859-1?Q?n918D5AdzfQ+NrRFQNDPnP/Uv47U7gvX312PE0QS9VenvZsEt8iRPSyHiR?=
 =?iso-8859-1?Q?Mo57wPvUEMb05Mh05NL3wfPV9ed7YF4XhOY3QpPek3TAqXTRh1CS8FMC18?=
 =?iso-8859-1?Q?5adrLEHcr/XjAi1Akukkg+qhucqD2cjV4AtpxsvQvPTxDpJbBGs4N/QjPM?=
 =?iso-8859-1?Q?Eq1s5g8fGWTfhL4rQNQDcpvL1+eEmYic/RtHI6Os5n4VNu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1432313a-ccbd-49e0-0ce2-08df43ecf190
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 14:21:45.2875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MwRfY1/qTgfymg7r8MsPsMue8n826BA4sayA7JAzD7IcSSf1VpcMV2pyHAFrmQkY6ZysbRt7tfxGigAzdLLpCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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


The patchset consists of the amd-staging-drm-next branch (Head commit -> 68=
9427a99619bdae427dc9bf574fa5949d428b95 -> drm/amd/display: Fix elapsed time=
 indentation) with new patches added on top of it.

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
From: Wayne Lin <Wayne.Lin@amd.com>
Sent: Tuesday, November 10, 2026 8:28 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; =
Chen, Chen-Yu <Chen-Yu.Chen@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>
Subject: [PATCH 00/74] DC Patches November 16, 2026

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

- Build DCN401 virtual commits and seamless plane updates in DC2, and
  dispatch the hardware span of a commit through dc2_funcs.
- Add the leaf block-sequence entries a virtual commit needs, and read
  the accelerated-mode bit through a query builder.
- Resolve watermark policy and the DPP, DTBCLK and DCN401 DENTIST
  targets when the sequence is built.
- Fix DSC teardown gating in the post-unlock sequence.
- Move HDMI FRL status polling outside dc_lock and stop it on fini.
- Relax stutter constraints for DRR streams, including ramless idle,
  track static-screen idle, and enable the relaxation on DCN42. Raise
  the DCN42 DDR5 stutter latency.
- Let DC_PSR_MASK enable PSR without a DMUB PSR cap.
- Enable HDCP on DCN6 and the DF C-state vote on DCN42B.
- Enable SST PCON FRL DSC passthrough and program the correct DP HPO
  APG instance.
- Exit IPS before checking flip pending, and keep the HPD IRQ reset
  path from taking dc_lock.
- Skip UPSP programming when the registers are absent, and skip
  visual confirm color programming when firmware owns it.
- Align DCN42B with DCN42 and extend the IOMMU mismatch workaround to
  DCN42B. Restore the missing DCN6 vtotal cap and vstartup assignment.
- Update the DMUB interface to 0.1.83.0 with an extended SoC bounding
  box, RAMLESS_LOBF commands, and a seamless-boot eDP request.
- Initialize the DMUB LSDMA ring, accept a 1932-byte PSP footer, and
  update the default VCO frequency.
- Fix the FFE link-rate change path and the p-state enable sequence.
  Commit the validated target when a minimal transition cannot be
  built.
- Fix KUnit tiled EDID size
- fix hubbub read state logging
- skip_lcdvdd_off for eDP link lost retrain
- Don't shrink zero-area recout in full viewport visual confirm
- panel specific wa not fall back to tmds
- Use expanded DMUB-provided SoC BB and IP caps
- Only force P-State on first plane if TTU is below WM
- Program the kept-plane scaler in DC2
- Add and remove two MPO planes in DC2
- Add DC2 state facts and split the builders
- Program DC2 commit stereo once
- Maximum SOP states is 8
- Use soc_bb hostvm fraction instead of hardcoded value
- Increase state if dcfclk deep sleep needed exceeds dcfclk
- Flip dml2_core_utils_get_segment_horizontal_contiguous() Inputs
- Update DCN6 Calcs
- Add effective_number_of_dpp parameter
- Read DRAM channel width from SMU init table
- Update DCN42B stutter latency to match DCN42
- Expect VRAM|GTT for the DMUB framebuffer
- Report QoS latency bounds and request
- upsp fixes
- Limit VRAM aperture retrieval to DCN6
- Make DPP_PG_CONTROL and HUBP_PG_CONTROL BLS compliant
- Seed boot clocks to avoid lowering pre-OS display clocks
- Account for split pipe overlap in alt channel copy size
- Get OPP heads and DPP pipes by stream in dc_resource
- Program ODM 2:1 and 3:1 on one stream in DC2
- Enable Replay timing sync by default
- Various cleanups.

---

Alex Hung (2):
  drm/amd/display: Fix elapsed time indentation
  drm/amd/display: Fix KUnit tiled EDID size

Allen Pan (1):
  drm/amd/display: Update DCN42B stutter latency to match DCN42

Alvin Lee (4):
  drm/amd/display: Update indicate pstate enable sequence
  drm/amd/display: Update DP HPO to use correct APG instance
  drm/amd/display: Updating missing assignments for DCN6
  drm/amd/display: Don't shrink zero-area recout in full viewport visual
    confirm

Aric Cyr (1):
  drm/amd/display: Ensure exit IPS before checking flip status

Ashwin Santhosh (2):
  drm/amd/display: Skip visual confirm color programming when FW owns it
  drm/amd/display: Account for split pipe overlap in alt channel copy
    size

Austin Zheng (5):
  drm/amd/display: Fix Stage Optimizer Parameter Naming
  drm/amd/display: Read DCN6 SOP constraints from the idle row
  drm/amd/display: Use soc_bb hostvm fraction instead of hardcoded value
  drm/amd/display: Flip
    dml2_core_utils_get_segment_horizontal_contiguous() Inputs
  drm/amd/display: Add effective_number_of_dpp parameter

Charlene Liu (6):
  drm/amd/display: Extend the IOMMU mismatch workaround to DCN42B
  drm/amd/display: update dcn42b based on dcn42
  drm/amd/display: enable DF C-state vote on DCN42B
  drm/amd/display: Increase the DCN42 DDR5 stutter latency
  drm/amd/display: Keep panel power across link-loss retrain
  drm/amd/display: Keep patched HDMI panels on FRL across detect

Dillon Varone (3):
  drm/amd/display: Relax stutter constraints for DRR streams
  drm/amd/display: cleanup tiling and address formats
  drm/amd/display: Enable DRR stutter constraint relaxation on DCN42

Eric Bernstein (1):
  drm/amd/display: Skip UPSP programming when UPSP regs are absent

Fangzhi Zuo (4):
  drm/amd/display: Correct the forced YCbCr420 comment
  drm/amd/display: Move HDMI FRL Polling Outside dc_lock
  drm/amd/display: Stop HDMI FRL status polling on fini
  drm/amd/display: Enable SST PCON FRL DSC passthrough

Gabriel Abarca (2):
  drm/amd/display: Increase state if dcfclk deep sleep needed exceeds
    dcfclk
  drm/amd/display: Update DCN6 Calcs

George Zhang (1):
  drm/amd/display: Don't let HPD IRQ handler take dc_lock in reset

Ilya Bakoulin (1):
  drm/amd/display: Fix FFE test automation link rate change

Ivan Lipski (4):
  drm/amd/display: Initialize DMUB LSDMA ring buffer
  drm/amd/display: Enable HDCP on DCN6
  drm/amd/display: Use expanded DMUB-provided SoC BB and IP caps
  drm/amd/display: Limit VRAM aperture retrieval to DCN6

James Lin (1):
  drm/amd/display: commit validated target when minimal transition
    cannot be built

Jing Zhou (1):
  drm/amd/display: Seed boot clocks to avoid lowering pre-OS display
    clocks

Karen Chen (1):
  drm/amd/display: fix hubbub read state logging

Nevenko Stupar (1):
  drm/amd/display: Update default VCO frequency

Ovidiu Bunea (1):
  drm/amd/display: Only force P-State on first plane if TTU is below WM

Piotr Maziarz (3):
  drm/amd/display: Resolve clk_mgr DPP DTO targets when the sequence is
    built
  drm/amd/display: Resolve clk_mgr DTBCLK DTO targets when the sequence
    is built
  drm/amd/display: Resolve the DCN401 DENTIST divider when the sequence
    is built

Rafal Ostrowski (4):
  drm/amd/display: Remove duplicate block sequence leftovers
  drm/amd/display: HWSS Refactor - Watermarks
  drm/amd/display: Fix DSC teardown gating in post-unlock BLS sequence
  drm/amd/display: Make DPP_PG_CONTROL and HUBP_PG_CONTROL BLS compliant

Ray Wu (2):
  drm/amd/display: Allow DC_PSR_MASK to enable PSR without DMUB PSR cap
  drm/amd/display: Enable Replay timing sync by default

Sreeja Golui (2):
  drm/amd/display: Include Ramless Idle in stutter relaxation
  drm/amd/display: detect static screen state and propagate

Sridevi Arvindekar (1):
  drm/amd/display: Bypass chroma upsampling without the DPP cap

Taimur Hassan (4):
  drm/amd/display: [FW Promotion] Release 0.1.83.0
  drm/amd/display: Promote DC to 3.2.406
  drm/amd/display: [FW Promotion] Release 0.1.84.0
  drm/amd/display: Promote DC to 3.2.407

Tony Cheng (13):
  drm/amd/display: Dispatch commit_state_hw through dc2_funcs
  drm/amd/display: Add leaf BLS entries for a virtual commit
  drm/amd/display: Build the dcn401 virtual commit natively
  drm/amd/display: Build the dcn401 seamless update in DC2
  drm/amd/display: Read accelerated mode through a query builder
  drm/amd/display: Build the kept-plane surface update in DC2
  drm/amd/display: Skip first-enable steps on a kept plane
  drm/amd/display: Program the kept-plane scaler in DC2
  drm/amd/display: Add and remove two MPO planes in DC2
  drm/amd/display: Add DC2 state facts and split the builders
  drm/amd/display: Program DC2 commit stereo once
  drm/amd/display: Get OPP heads and DPP pipes by stream in dc_resource
  drm/amd/display: Program ODM 2:1 and 3:1 on one stream in DC2

Wayne Lin (1):
  drm/amd/display: Expect VRAM|GTT for the DMUB framebuffer

Wenjing Liu (2):
  drm/amd/display: Read DRAM channel width from SMU init table
  drm/amd/display: Report QoS latency bounds and request

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   17 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   16 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |   15 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |    3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    9 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   10 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |    3 +-
 .../tests/amdgpu_dm_connector_test.c          |    9 +-
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     |   45 +-
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     |   27 +
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      |    6 +
 .../amdgpu_dm/tests/amdgpu_dm_psr_test.c      |   35 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |    3 +
 .../amd/display/dc/bls_builder/bls_builder.h  |    6 +-
 .../dc/bls_builder/bls_builder_internal.h     |    2 +
 .../bls_builder/bls_builder_private_types.h   |  137 +
 .../dc/bls_builder/dcn401_builder_internal.h  |  110 +
 .../dc/bls_builder/dcn401_init_builder.c      |   36 +
 .../bls_builder/dcn401_non_seamless_builder.c |  501 ++++  .../dc/bls_buil=
der/dcn401_seamless_builder.c  | 2235 +++++++++++++++++
 .../display/dc/bls_executor/bls_executor.c    | 1076 ++++++++
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   83 +
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  170 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |   15 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |   31 +-
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        |   25 +-
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h        |    1 +
 .../drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h |    3 +-
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  |  157 +-
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h  |   14 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  115 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  317 ++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   48 +-
 .../amd/display/dc/core/dc_resource_helper.c  |    7 +-
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   |  341 ++-
 .../gpu/drm/amd/display/dc/core2/dc_core2.h   |    1 +
 .../drm/amd/display/dc/core2/dc_core2_init.c  |    2 +-
 .../display/dc/core2/dc_core2_legacy_init.c   |    2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    2 +-
 .../amd/display/dc/dc_api_dispatch/api_shim.c |   25 +
 .../amd/display/dc/dc_api_dispatch/api_shim.h |    9 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |    1 +
 .../gpu/drm/amd/display/dc/dc_hdmi_types.h    |    1 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   16 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |    8 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |    3 +
 .../dml21/inc/bounding_boxes/dcn42_soc_bb.h   |    4 +-
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h  |    4 +-
 .../dml21/inc/dml_top_display_cfg_types.h     |    1 +
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |    2 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |    2 +
 .../dml2_core/dml2_core_dcn5_calcs_dchub.c    |   75 +-
 .../dml2_core/dml2_core_dcn6_calcs_dchub.c    |   30 +-
 .../dml2_core_dcn6_funcs_mode_programming.c   |   34 +-
 .../dml2_core_dcn6_funcs_mode_support.c       |   19 +-
 .../src/dml2_core/dml2_core_shared_types.h    |    3 +
 .../dml21/src/dml2_core/dml2_core_utils.c     |    4 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   20 +-
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.h |    4 +-
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h |    8 +-
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c    |   19 +-
 .../src/inc/dml2_internal_shared_types.h      |    4 +-
 .../dml21_wrapper/dml21_translation_helper.c  |   17 +-
 .../dc/dml2_wrapper/dml2_mall_phantom.c       |    1 -
 .../display/dc/dml2_wrapper/dml2_wrapper.h    |    1 +
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c  |    2 +-
 .../amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c |    4 +
 .../display/dc/hubbub/dcn10/dcn10_hubbub.c    |    3 +-
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |    1 +
 .../display/dc/hubbub/dcn20/dcn20_hubbub.c    |    8 +-
 .../display/dc/hubbub/dcn201/dcn201_hubbub.c  |    3 +-
 .../display/dc/hubbub/dcn21/dcn21_hubbub.c    |    3 +-
 .../display/dc/hubbub/dcn21/dcn21_hubbub.h    |    1 +
 .../display/dc/hubbub/dcn30/dcn30_hubbub.c    |    5 +-
 .../display/dc/hubbub/dcn30/dcn30_hubbub.h    |    1 +
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |    5 +-
 .../display/dc/hubbub/dcn32/dcn32_hubbub.c    |   23 +-
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |    7 +-
 .../display/dc/hubbub/dcn35/dcn35_hubbub.h    |    1 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |   12 +-
 .../display/dc/hubbub/dcn401/dcn401_hubbub.h  |    3 +-
 .../display/dc/hubbub/dcn42/dcn42_hubbub.c    |   20 +-
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    |    3 +-
 .../amd/display/dc/hubp/dcn50/dcn50_hubp.c    |   52 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   61 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |    9 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   48 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |    9 +-
 .../amd/display/dc/hwss/dcn302/dcn302_hwseq.c |   15 +-
 .../amd/display/dc/hwss/dcn302/dcn302_hwseq.h |    6 +-
 .../amd/display/dc/hwss/dcn303/dcn303_hwseq.c |   11 +-
 .../amd/display/dc/hwss/dcn303/dcn303_hwseq.h |    6 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |    8 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.h   |    3 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   15 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |    3 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |    7 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |    3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  180 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |    2 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    2 +
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |    9 +
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.h   |    1 +
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |    2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  422 +++-
 .../display/dc/hwss/hw_sequencer_private.h    |   14 +-
 .../amd/display/dc/inc/dc_core_interface.h    |   12 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   38 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   22 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   21 +-
 .../display/dc/inc/soc_and_ip_translator.h    |    4 +-
 .../drm/amd/display/dc/link/link_detection.c  |   26 +
 .../dc/link/protocols/link_dp_irq_handler.c   |    8 +-
 .../display/dc/link/protocols/link_hdmi_frl.c |   30 +-
 .../dc/resource/dcn42/dcn42_resource.c        |    2 +
 .../dc/resource/dcn42b/dcn42b_resource.c      |    5 +-
 .../dc/resource/dcn60/dcn60_resource.c        |   30 +-
 .../dcn401/dcn401_soc_and_ip_translator.c     |    4 +-
 .../dcn42/dcn42_soc_and_ip_translator.c       |    4 +-
 .../dcn42b/dcn42b_soc_and_ip_translator.c     |    4 +-
 .../dcn60/dcn60_soc_and_ip_translator.c       |   96 +-
 .../amd/display/dc/state_facts/state_facts.c  |  294 +++  .../amd/display/=
dc/state_facts/state_facts.h  |  132 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  213 +-
 .../amd/display/modules/power/power_replay.c  |    2 +-
 125 files changed, 6985 insertions(+), 905 deletions(-)  create mode 10064=
4 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_build=
er_internal.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_s=
eamless_builder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seaml=
ess_builder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/state_facts/state_facts.=
c
 create mode 100644 drivers/gpu/drm/amd/display/dc/state_facts/state_facts.=
h

--
2.43.0

