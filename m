Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A8C606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uMwVw0sk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA63D10EE5A;
	Mon, 23 Nov 2026 14:23:40 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 571FF10EE5A
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 14:23:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZTCclPSI1muRVBAKybcE3KTmGwa5U0zct6J450r8XNs0ablX6+Mm679bl15fJrEiA5okntqjt/BzmIlsONCOfFlhSEKrhfu/WZI0gvHclfHL9pNDsfqjOoWxSjtYEokUQBfiHP4r8c4Z3pHlvjGwBUxhUjXvcNJn/Ak6f6cUb/+ueL4udVzJmCTPtpPYW/IVKA25GB9i+MaeUDp/NRUt+0XDf2bRrO4ftOghM5sHP5gOR2n7VDwW0mv362A9v5BhwC70LYqZqNu2Sv6mTPaOrnu1nnKwc3XviUeiUpUgY0Nzl59zQZYTcPz2sXppNsmULm3KYXKWV0tlHMBsfBG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSFrVnTRAWh/PHGpfllFddI/XmsMydRUYXpY9cjPgIM=;
 b=u75kilzI7Zo7G3oa9ViIiS85YJXAJh8U0keoN4EXUJDKGti9SuhXwthm25TK2Ln2djDvGYOJzRbSeHTXzItVxaonlN6IIoe76A36PAGcW1jKdESSD1LkXy5xxPMGxPeDBxNmQu8aKFfntDDZbBX4x8bE4+lxDe7t1Joylto8qjLRv2umCMFaiWcXGmybzXX4Lf34o8uZP9OYevoXXWWO/T3o/X19n+eRPZtOj+4uu8Wrqv+4115KrdILb+g5CKd/capxbpnYb/xwhQYL+JLGRaDatloXoMe3GcUUF5JwWRYdouShta3BPnvHHjooXc0hb88BVcGVpPuBJSVjcE6R/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSFrVnTRAWh/PHGpfllFddI/XmsMydRUYXpY9cjPgIM=;
 b=uMwVw0skUo5TNyToSD6JNKE2pgrOw+vHvq28mcY7WGQVTpgobgcQnAwE8/N5HBJG1C1P2oDj4P5rhva+jqc0G1VEVJDkuca9RIX+h7uyhkI95PlEPtWsuGLj59yIyn4n4gNYOqf7UL706tAIrvqs6wnNA70BSOtT303KsmWUSDU=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 PH8PR12MB6747.namprd12.prod.outlook.com (2603:10b6:510:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 14:23:23 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 14:23:23 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Ping Lei" <PingLei.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei" <PingLei.Lin@amd.com>, "Chen,
 Chen-Yu" <Chen-Yu.Chen@amd.com>
Subject: RE: [PATCH 00/33] DC Patches November 23, 2026
Thread-Topic: [PATCH 00/33] DC Patches November 23, 2026
Thread-Index: AQHddrbOOoG9maE0G0Gq01HFfTtM2rc7vnyw
Date: Mon, 23 Nov 2026 14:23:22 +0000
Message-ID: <DS0PR12MB65347892A1D7412346F45C079C452@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-11-23T14:22:07.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|PH8PR12MB6747:EE_
x-ms-office365-filtering-correlation-id: 982a9f7d-48bd-409a-26ca-08df496d54a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|22082099003|261009223027099003|3023799007|261021135927099003|261021123027099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003|261102123227099003|261022113327099003|261022075727099003|261028144727099003|56012099006|10067099003|38070700021|11063799006;
x-microsoft-antispam-message-info: Qg3wH19cArJu/CkIfEQvlGhUpbDI5qjWJ/xZoL8m6saACklZFkCXFLnSgpggne+F+XnhkJEMP5CedxJydzhmpyXbjcVfINrU1IZlYdKwlcwQeS3zG227lb+EC2Q58etsiGBd1SwJjgBjLa/vhGL0QV6F+spI6c7vWi99S/ctBb0iyzBqtvtjm9jCFUPznvIyF7XSvpNrxc5YBpvRFUbt7p/8sh3mZSQetNYj5dFVeo/fFgZz+Waj2QDzpIZFyTN/n7FoaWFK8+2bN2D+6Qt+ajE1mBJqCpNBTpYdw88+kXpVGZb3wO0bMqo8wZiIiA0B/o4XpF8mBMHZwWB2WFkRzWU2HmusC7OG2Z9rMruuztPYsmaKoQASFnIis/Gz1tEW4a0bHXsPQzG/9eUV14XlG0pD9kQYiFZmkJION8XtVnGpV03l9c5S18EZaEpD2HfoFWbITTNSjaTkduPUDD+rZosEBvfkbT+cs4nieSyMrPV74VPD/H/MJkXYk2jMXPb72BQD9Wmsokznd3jvD3trczW5p9m6dYx/tv1X+JZab76cEaSvIonerEEM0pWI9bjriSsLHmtU7oM84tB9yfGlnFYihRKTd4LDgb/b8DwSkcf+2PS+pe0k2uxPi0ZPEPt06ZdH4F1MJt3ihSOLJVh6vJAR8GujAVjcTJxTWM7C6SLvAjrgn+vKHCBvLxfS5zzGdw9VjibwsJJKT45rTS7RDIEJxl27kIBeK0E9p/obZk4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(261009223027099003)(3023799007)(261021135927099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(261102123227099003)(261022113327099003)(261022075727099003)(261028144727099003)(56012099006)(10067099003)(38070700021)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?73cfH8LroYd+S8q6RnnYVeeXjJGifkg79aZcwgDN7mXqckSyKAE88nWKjJ?=
 =?iso-8859-1?Q?AOz7heZ4UMC6zGyblsZwStF4PdVcTIVDfb7OdaGXcruFA8K42msd43z/n8?=
 =?iso-8859-1?Q?5fjI/GousymNx2X35DvisSIq1I19TUVGTmYrilmZ7hwB67I8z5DwVkUtFJ?=
 =?iso-8859-1?Q?MWoQhcL2yXYUT/zFAVBSNz9U45LN3O+i1w0HJ5IwtXuNS9WzHU0zzt66oG?=
 =?iso-8859-1?Q?E3U/aVizs6ssDXUwTbaNmJ8L1xWETporHolHwD/QHuHwwRFi3J5ftokC+Q?=
 =?iso-8859-1?Q?V4LogpyJ6L15IVmT+8d1sfv8V6ZCBm1cS/dmoGtOhah9u11gvL/oeiVTp+?=
 =?iso-8859-1?Q?lYnn652RgkkUEc2/KTPI8ySp7fQdifx6y7UNaY2GJjyJEGVN+qHGvg+cv8?=
 =?iso-8859-1?Q?PnvrIB0u1HLGDLNjNDN14H6IWZF/iIsemsXInw9K3VdH3/qI86fy4nDAjG?=
 =?iso-8859-1?Q?l0QzyuNcssKaITT1qL6TpxRaNa+zx9AZIDCBRasHDvsr7HgLEVxdbWRZg1?=
 =?iso-8859-1?Q?ZZEGlW1MWNnhViwzcNArk6vuQFOfaJe2FZfakpPNsxPYmjMZAemHs/fPde?=
 =?iso-8859-1?Q?ShdtzhgLalB/xg3snTDzrEmlK1RgrS7nf4GGtQdkNvmQxyVCqdmOpcpeLs?=
 =?iso-8859-1?Q?KDZiQ5JZB0oFvgbTXZFwYT1MIm/rWjJp9GwQ0jHuH+bmcIittsCYOF43xL?=
 =?iso-8859-1?Q?qCnxOP2QRVIu2ZQKLnCKjRT3PkXiXAb+k4FIbLi5DnX19H7EWD2EFECp6x?=
 =?iso-8859-1?Q?O9Uuu/QlMFC51jQO/wCw8XyWSuloWTNxH1SdG5Ohy8OnhkYsVQpxJEcChP?=
 =?iso-8859-1?Q?kF0EFCuJm2FI1/IeXdCHRAvGExyBtL/RCxsHNNtKRs0HJeLD2Er+yL82vd?=
 =?iso-8859-1?Q?xzKRmm2UY+8prBZYmzVemRbDUrVhHP0d2Yl80fILLEXa+/v580btgE3Mtg?=
 =?iso-8859-1?Q?tPAMvpByvwEPRU34oZr98w4Wxq/CvqfQsiB+ck6Bf8FFi2PVGUsUAL34qr?=
 =?iso-8859-1?Q?nzywvEu/M4XfvV9fgWouBlu+SLqxPdEPUST+tCcvZL5AnYdUQClIrWEazr?=
 =?iso-8859-1?Q?JBsR+5opHbnUl9aUnEIxK40vedBs6B4BpxdygFAoWgsT0nxUTXJ5VR0Sao?=
 =?iso-8859-1?Q?4pNOghKUWdAH8b7ritr6QK+2SIwQKvSnq4P9QCrxlBq9qKBb4k/bGXADyJ?=
 =?iso-8859-1?Q?3oAcq535bOANdbNZlqF12nv1Ttx/mXdY/r2gt/kSf5dKD7BDx1eo4WL62V?=
 =?iso-8859-1?Q?mbtkqyWw9LIdZgLMOKMcENH23/nuK+hKHSmAKs8tNMKFaqq7dYSZCWza5T?=
 =?iso-8859-1?Q?svumkUJj1M3rXpe2ilBKF9888BpmyjGnEBhhPX3OSeQglyLZ1b06Gi0qjy?=
 =?iso-8859-1?Q?mWPClu8Uom9OXlvMjMJaL1WFul5N9OZVTY+uY0npXv5v2Nh6rfhUF7e5C6?=
 =?iso-8859-1?Q?1cqOqtpRV688KNSgAA8zIfoFxO5N+h7F0CWyYp2y67E/8U8+zoEqzzXUrb?=
 =?iso-8859-1?Q?lhTEphItjeWryAXEgomKgJ6evuNuj4xVoDr48FFqvsNvwuywbHVlatCKWX?=
 =?iso-8859-1?Q?D+0LZ6Uc62/wFto2OF+Rz2XKu8LCg4u2guIvvkL++oLV/NaXLoUfZGf6CE?=
 =?iso-8859-1?Q?F3aGcjwgRLYgfENuyaYulWJ66Ar5Rgb7qkuZ0pNWpNrcuNyWlAhKeI5owN?=
 =?iso-8859-1?Q?K1mVWUUzVZxiX+LLucZcdaoyohT2RpFaE0t44GuF9MxZbkCEBg00CSMLGf?=
 =?iso-8859-1?Q?e043x1GEma9Pb8rRJjrhMDTJtvzUPZb3AocSKig0HIOygT?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982a9f7d-48bd-409a-26ca-08df496d54a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 14:23:22.9853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRgxsDnuOwlTWfRniJ1P7aYhx3rtXAmnXVwpiyQ8R/15ZyjdFXEd4DI3gxjWmsbRKanwInQfu7ClAkEC2IXbnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6747
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
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URG_BIZ autolearn=ham autolearn_force=no version=4.0.1
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


The patchset consists of the amd-staging-drm-next branch (Head commit -> a6=
10ecccfc426cf1f4a25d3f06ff4671ed7c1963 -> drm/amdgpu: add support for FB ca=
rveout disablement) with new patches added on top of it.

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
From: James Lin <PingLei.Lin@amd.com>
Sent: Monday, November 16, 2026 4:51 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; =
Chen, Chen-Yu <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/33] DC Patches November 23, 2026

This DC patchset brings improvements in multiple areas. In summary, we have=
:
- Rename DPMS to DPMS_v1
- Power up eDP when detect link
- Add DPMS-v2 files
- Refactor DP retrain link HW sequence
- Add extra 0.25 line reserved for TSetup/TCalc inefficiency
- Use panel luminance range for AUX backlight in power module
- Read PWM back linearly with the linear backlight curve
- Add API to set brightness percent
- Pass linear brightness percent to power module
- Add DPMS-v2 types
- Always apply 0ppm pixel clock adjustment
- Add otg versions of get_vblank_counter/scanoutpos
- Queue vblank control work to sleepable context
- Fix KUnit tests for vblank control rework
- Add urgent request and assertion probes
- Fix G7 P-state aperture addresses
- Set stream min/max refresh from VRR config
- Add DC2 wrapped initialization for DCN401
- Honor the Replay stream regeneration wait event
- Disable Replay when link off frame count is below 2
- Skip DSC padding borrow estimate for zero padding
- Drop unused DC interfaces
- Let the DC2 commit replace or keep a stream
- Support two streams in the dcn401 DC2 builders
- Add a plane beside a kept plane in DC2 update
- Keep an unchanged stream in the DC2 commit
- Change the ODM and MPC layout in DC2 update
- Give the DC2 builders State pipe facts
- Add RGBA8888 surface pixel format support
- Fix DCE crossbar for RGBA8888 surface format

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Allen Pan (1):
  drm/amd/display: Always apply 0ppm pixel clock adjustment

Dominik Kowalski (3):
  drm/amd/display: Rename DPMS to DPMS_v1
  drm/amd/display: Add DPMS-v2 files
  drm/amd/display: Add DPMS-v2 types

George Shen (1):
  drm/amd/display: Refactor DP retrain link HW sequence

George Zhang (3):
  drm/amd/display: Add otg versions of get_vblank_counter/scanoutpos
  drm/amd/display: Queue vblank control work to sleepable context
  drm/amd/display: Fix KUnit tests for vblank control rework

Harry VanZyllDeJong (1):
  drm/amd/display: Honor the Replay stream regeneration wait event

Harry Wentland (2):
  drm/amd/display: Add RGBA8888 surface pixel format support
  drm/amd/display: Fix DCE crossbar for RGBA8888 surface format

Ivan Lipski (2):
  drm/amd/display: Fix G7 P-state aperture addresses
  drm/amd/display: Set stream min/max refresh from VRR config

Michael Strauss (1):
  drm/amd/display: Clear OTG_AUTO_FORCE_VSYNC_MODE on OTG disable

Nicholas Kazlauskas (2):
  drm/amd/display: Skip DSC padding borrow estimate for zero padding
  drm/amd/display: Drop unused DC interfaces

Ray Wu (5):
  drm/amd/display: Use panel luminance range for AUX backlight in power
    module
  drm/amd/display: Read PWM back linearly with the linear backlight
    curve
  drm/amd/display: Add API to set brightness percent
  drm/amd/display: Pass linear brightness percent to power module
  drm/amd/display: Disable Replay when link off frame count is below 2

Samson Tam (1):
  drm/amd/display: add extra 0.25 line reserved for TSetup/TCalc
    inefficiency

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.85.0
  drm/amd/display: Promote DC to 3.2.408

Tomasz Siemek (1):
  drm/amd/display: Add DC2 wrapped initialization for DCN401

Tony Cheng (6):
  drm/amd/display: Let the DC2 commit replace or keep a stream
  drm/amd/display: Support two streams in the dcn401 DC2 builders
  drm/amd/display: Add a plane beside a kept plane in DC2 update
  drm/amd/display: Keep an unchanged stream in the DC2 commit
  drm/amd/display: Change the ODM and MPC layout in DC2 update
  drm/amd/display: Give the DC2 builders State pipe facts

Wenjing Liu (1):
  drm/amd/display: Add urgent request and assertion probes

Zhikai Zhai (1):
  drm/amd/display: Power up eDP when detect link

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  116 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   52 +
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |  208 +---
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |    9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  225 ++--
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |    2 +-
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |    3 +
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |    2 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |   20 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |   23 +-
 .../tests/amdgpu_dm_backlight_test.c          |  552 ++-------
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     |  219 +++-
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c |    2 +
 .../amdgpu_dm/tests/amdgpu_dm_replay_test.c   |  129 ++
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |   78 ++
 drivers/gpu/drm/amd/display/dc/Makefile       |    3 +
 .../gpu/drm/amd/display/dc/basics/dce_calcs.c |    2 +
 .../amd/display/dc/bls_builder/bls_builder.c  |   19 +
 .../amd/display/dc/bls_builder/bls_builder.h  |   86 +-
 .../dc/bls_builder/bls_builder_internal.h     |    3 +
 .../bls_builder/bls_builder_private_types.h   |   28 +-
 .../dc/bls_builder/dcn401_builder_internal.h  |   87 +-
 .../dc/bls_builder/dcn401_init_builder.c      |  812 ++++++------
 .../dc/bls_builder/dcn401_init_builder.h      |   16 -
 .../bls_builder/dcn401_init_builder_legacy.c  |   77 ++
 .../bls_builder/dcn401_non_seamless_builder.c |  243 ++--
 .../dc/bls_builder/dcn401_query_builder.c     |   41 +
 .../dc/bls_builder/dcn401_seamless_builder.c  | 1091 +++++++++++------
 .../display/dc/bls_executor/bls_executor.c    |   79 +-
 .../display/dc/bls_executor/bls_executor.h    |    2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    6 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  267 +++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   48 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   28 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   38 +
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   |  142 ++-
 .../drm/amd/display/dc/core2/dc_core2_init.c  |  298 ++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   60 +-
 .../amd/display/dc/dc_api_dispatch/api_shim.c |    1 +
 .../amd/display/dc/dc_api_dispatch/api_shim.h |    3 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |    8 +-
 drivers/gpu/drm/amd/display/dc/dc_probe.h     |   61 +-
 .../gpu/drm/amd/display/dc/dc_state_priv.h    |   23 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |    6 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |   25 +
 .../drm/amd/display/dc/dce/dce_mem_input.c    |   42 +-
 .../drm/amd/display/dc/dce/dce_mem_input.h    |    6 +
 .../display/dc/dce110/dce110_mem_input_v.c    |    1 +
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |    1 +
 .../dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c |   13 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c  |    3 +
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c  |    3 +
 .../amd/display/dc/dpp/dcn201/dcn201_dpp.c    |    3 +
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |    3 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |    3 +
 .../drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c  |    3 +
 .../drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c  |    3 +
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c  |    3 +
 .../display/dc/hubbub/dcn10/dcn10_hubbub.c    |    1 +
 .../display/dc/hubbub/dcn20/dcn20_hubbub.c    |    1 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |    1 +
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    |   80 ++
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |    4 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |    4 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |    3 +-
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |    4 +
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |    4 +
 .../amd/display/dc/hubp/dcn50/dcn50_hubp.c    |    4 +
 .../amd/display/dc/hubp/dcn60/dcn60_hubp.c    |   35 +
 .../amd/display/dc/hubp/dcn60/dcn60_hubp.h    |    1 +
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.c   |    1 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |    1 +
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |    8 -
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |  243 +++-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   80 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   61 +
 .../amd/display/dc/inc/dc_core_interface.h    |    6 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |    3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   12 +
 .../amd/display/dc/inc/hw/timing_generator.h  |    4 -
 .../gpu/drm/amd/display/dc/inc/link_service.h |    6 +-
 drivers/gpu/drm/amd/display/dc/inc/link_tx.h  |   59 +
 drivers/gpu/drm/amd/display/dc/link/Makefile  |    9 +-
 .../display/dc/link/accessories/link_dp_cts.c |   43 +-
 .../drm/amd/display/dc/link/link_detection.c  |   17 +-
 .../dc/link/{link_dpms.c =3D> link_dpms_v1.c}   |    6 +-
 .../dc/link/{link_dpms.h =3D> link_dpms_v1.h}   |   10 +-
 .../drm/amd/display/dc/link/link_dpms_v2.c    |   44 +
 .../drm/amd/display/dc/link/link_dpms_v2.h    |   38 +
 .../drm/amd/display/dc/link/link_factory.c    |   23 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |    6 +-
 .../display/dc/link/protocols/link_hdmi_frl.c |    8 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |    4 +
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  |    4 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |    4 +
 .../dc/pmfw_messenger/dcn401_pmfw_messenger.c |  211 ++++
 .../dc/pmfw_messenger/pmfw_messenger.c        |   62 +
 .../dc/pmfw_messenger/pmfw_messenger.h        |  118 ++
 .../amd/display/dc/state_facts/state_facts.h  |    3 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   48 +
 .../drm/amd/display/modules/inc/mod_power.h   |    7 +
 .../drm/amd/display/modules/power/power_abm.c |   83 +-
 .../amd/display/modules/power/power_replay.c  |    1 +
 103 files changed, 4807 insertions(+), 1898 deletions(-)  create mode 1006=
44 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_query_builder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/link_tx.h
 rename drivers/gpu/drm/amd/display/dc/link/{link_dpms.c =3D> link_dpms_v1.=
c} (99%)  rename drivers/gpu/drm/amd/display/dc/link/{link_dpms.h =3D> link=
_dpms_v1.h} (92%)  create mode 100644 drivers/gpu/drm/amd/display/dc/link/l=
ink_dpms_v2.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/pmfw_messenger/dcn401_pm=
fw_messenger.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/pmfw_messenger/pmfw_mess=
enger.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/pmfw_messenger/pmfw_mess=
enger.h

--
2.43.0

