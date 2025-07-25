Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E8DC87FCA
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 15:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2B6010E20D;
	Fri, 25 Jul 2025 15:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eHy63OBs";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15DF110E20D
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 15:10:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyfTeOqLf8vrwmhs2+RcY+Mt9UONmBy/brfNMNBiha9aD9qj9UQbxjwqPXFfOXIpFicpFb5kAqmP3vgixUYcXIuQNKYsGd0eR95yvtcwN8cOcap0D0HA+Gl3rb0tnCbLnltuGcRP0T77w37ZmI4rKdLFSRQEyrwqLwZDd0Lxq6DrZ7gJwy9tFA2fq8me6tyJsupWg7Ovua2sRsXv99pOGnyRBdzdlA4pKoI+Lic5dc8a1YgiPmkhodvpkUt4Iex6z3ayXtiXQEMBCzvOfvc15vlMWoizRJ1iBtKT8pp2qSDwv3/XYeadvCppjV+LVD2Zme8RoM7j7jI99Q8Za8DdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AApgNE8wh98pXqnudn0z2MTmolxbgKs6q7hmCwjf0Js=;
 b=sDv+3MV32PmNZXxeLiXt5Nt2czoAM4uuW87C9uOkX9rE42K8c4an1DJ/z7nRWc7X2JAvDB3sBniG0H8MUD/Rd5DZSD1eiZh572Shk7Q1DdMo6adDwL6us7RjUx4cVF7uUZyJkzL4KzqkSRLwNe6R441RyN7jXnVZ8OGMGY2fc48su7YBvZ+0x8bfQW75J8D3I8Nu1V2sGG4uLZeu8Dc/dl4lX7FrMn9qafMCDANsiYunSj41euuuYKIALTDsK0r1vaK6s/2NZ0acxrr9Se1ddW+BDq+UZr9qTbLXdzcx8bRThHv3SbYyIDya1cDpTAJxBFX+4x0nM43XfKuOkzr9bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AApgNE8wh98pXqnudn0z2MTmolxbgKs6q7hmCwjf0Js=;
 b=eHy63OBsdxGh6X1NArAq5t9V8hrTNmae+HUvAya5Cx3y0TpnfS2jEDHwYFTVPXAcMB4N+O19ZEVc3PJAWHy35I9KRMzCFf8ikYAidleFPDl7sl1hkqSlPYolmgpkTvGNcEiv7CuSrZza6IkQ7MdmFb85IBovFFRBzdUbnvpu9l8=
Received: from BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16)
 by CH1PPFDB1826343.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::628) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Fri, 25 Jul
 2025 15:10:05 +0000
Received: from BL1PR12MB5192.namprd12.prod.outlook.com
 ([fe80::1827:386f:7b23:dca3]) by BL1PR12MB5192.namprd12.prod.outlook.com
 ([fe80::1827:386f:7b23:dca3%6]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 15:10:05 +0000
From: "Liu, Wenjing" <Wenjing.Liu@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Strauss, Michael"
 <Michael.Strauss@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, "Shen, George"
 <George.Shen@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lin,
 Wayne" <Wayne.Lin@amd.com>, "Lee, Alvin" <Alvin.Lee2@amd.com>, "Wu, Ray"
 <Ray.Wu@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Li, Roman" <Roman.Li@amd.com>
Subject: Re: [PATCH v4] drm/amd/display: Reduce Stack Usage by moving
 'audio_output' into 'stream_res' v4
Thread-Topic: [PATCH v4] drm/amd/display: Reduce Stack Usage by moving
 'audio_output' into 'stream_res' v4
Thread-Index: AQHb/Ramni2r3EtRx0G6ot67VxcoL7RC8ggC
Date: Fri, 25 Jul 2025 15:10:05 +0000
Message-ID: <BL1PR12MB51927F54E204261B0984B7FBF559A@BL1PR12MB5192.namprd12.prod.outlook.com>
References: <20250724074833.1385215-1-srinivasan.shanmugam@amd.com>
 <20250725034534.1403158-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250725034534.1403158-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-25T15:10:04.1970000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5192:EE_|CH1PPFDB1826343:EE_
x-ms-office365-filtering-correlation-id: 6e21a71c-e9ff-400a-5453-08ddcb8d5627
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|8096899003|38070700018|921020;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?VBIp08pDCpmA/E7D6t6RqehUbNHE1XARAj7LIR9JHMP5AP58Adg7csAWyI?=
 =?iso-8859-1?Q?b+ksggAjZXkI3viWUFSSmSeQ5otBwlfPD0yUtU4ioMBEum50imd5UbM/dS?=
 =?iso-8859-1?Q?pdtH45QCWZxEvVYbvjkv4eoiC0gkaH/xsIm7U3tnNR5Z9qD7wk2mGeKgxL?=
 =?iso-8859-1?Q?sx+0XFDZmMtpTrNSkPwM2XAGcHMzRXJqh7mOXMSpvZd0x3VQuqM1QcOiDf?=
 =?iso-8859-1?Q?ySX77+jf/a6+YuBvWlHO/m9waECanqf3mVLf3kNVR8urjbYNXVmfoNi2LY?=
 =?iso-8859-1?Q?fCl5K8WZx67yhTy2QjW09kStyOT2wiXWy3NCCDWIsgYZbsMZyLNhkWTBDH?=
 =?iso-8859-1?Q?W5Q05cy889PvvnO55R2ZmuK8Y69eIfRh5z1pgnFM/6Bq7cDQwULR15KlYO?=
 =?iso-8859-1?Q?XLOc/fJB6SV7MsbAKdGBOh3p21GHrCmLBuO4iXaCxr3S7RjvppVpY559+h?=
 =?iso-8859-1?Q?INjTe5ERPHDE+gFLP9sKdApHFudXbyYFXzQSOhS9TVKLb/0gctNNuePES6?=
 =?iso-8859-1?Q?jYOYMK1Yn7auL0m2E3huGoGdaaSijlJFRzEmf2mO/9KliugAl397dX+tkc?=
 =?iso-8859-1?Q?mdfNUhn5pzbJ1r05eTAlVUnWWei2NtTpw2cF4O7DAmqcRvD7BAe+qkjwFb?=
 =?iso-8859-1?Q?xbYxQC1AGiv4Ozpc0ifp4efcYvObmZqP0JambbledsmgoCVsdNac/IHOSA?=
 =?iso-8859-1?Q?5sHQhtoLqvu5JlWS/YwiTJUbPCBnPo6FEv8o820h5bwCmQKKUgDBvqrBiB?=
 =?iso-8859-1?Q?hsC25uHMRFSMIfIUxsHJUvzWxHO6F2udDXB7gOsyqMaSD2ADgrDmqWeMMA?=
 =?iso-8859-1?Q?oKXcid+HCNU8PdQodgIVd51nKUo+G7xIcvV21T/bpaCXiwJd3Wbldye8X4?=
 =?iso-8859-1?Q?y6M6fpl1Ij6Sw2XJ23I6bwGcIo8DSnw8ufJvJVkN2z0ts4ahfKlUGh4ni9?=
 =?iso-8859-1?Q?QQp/Gjmef5UxQqk3xP7uoBgXfPPCZf7g2R+WU/fJbX2grWhIaecWo/rwEB?=
 =?iso-8859-1?Q?0iJeT8+oT070rh+GWPfEvJgOeqH82EGcDzdOrMbsppNoYWeQO1FA9OnXhy?=
 =?iso-8859-1?Q?n6EwQtFlGSBQ8S8uyn2Wm5r634ZqvnXJu+BDacrvmnKzfGW6kE00sYk7gj?=
 =?iso-8859-1?Q?j/vv5pRXEhyYOR3UggpDEdcuu6KBkcenZ2YaRBa6QfBovLLv4580ETLW57?=
 =?iso-8859-1?Q?8chnJ9GmGBvZ+eXFpWChNlHTPwoVo0sx3DDEUACZzVhEsbNpx62Shsq8y1?=
 =?iso-8859-1?Q?yzsk987LwMz0VH7LJVGuv9l63tid7T4sfPbWrxeJsC2gMj8Hx0fSfYk8j0?=
 =?iso-8859-1?Q?Y4AyXolAlpWN2gYdCygfRbI4Tiqvrp+54PwedM8ntObReVRTjiAk03dZA/?=
 =?iso-8859-1?Q?2UJ/XAU/KO0Nj5drieNlMvBJZfFGTJtn3jHKp8qFcW0NyFdMzn6IAQG5lm?=
 =?iso-8859-1?Q?mvbtfA7hBcwv6geg5nHjDxzlJeMgcxo3QTsi70uv0hgG2PEyfNSz9DfzFJ?=
 =?iso-8859-1?Q?17I1vGoIRaEXp+qQ8dfYIVOhfCcfp8IZ3OYEQphNNQnqQoufxjTI1sw27Y?=
 =?iso-8859-1?Q?Nw5sf5k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(8096899003)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pVDnGDkn17tAtmE40EAeOc+uCoAcoCQ83cM0ywQdcEqS09Mx8D+wAf3s1T?=
 =?iso-8859-1?Q?iuX44FEPEWOp22cgD0/6gOT6jPEZ9XBmAeHtZuXxIr4Lqsp3LNSelQuL3O?=
 =?iso-8859-1?Q?RbvfeR8yelGa1sL+B4KZKHYZ7FDWKLNurU7W4ehxmv+Ayoq7hWXuanSjaC?=
 =?iso-8859-1?Q?EcaRyK/6oNXC5hsOfjNAUE0/CgPae2aPtHQArneBVvVKrVabLZp+k3wjd+?=
 =?iso-8859-1?Q?cc4OMMfPjOu/eBAZoX6YXzomYYjhwgCYeoMqF2aYnaZpxhhtASEEjhx6pV?=
 =?iso-8859-1?Q?A8hw4z9gJypjbPgAXopo/m9p0wQnX38aUttM//lu4PKAwF/OMiLVy8a0TF?=
 =?iso-8859-1?Q?Y9erI7OazPmq/Z4xC/xwAvzV4So2RDq0XSKhbAs3H4qKIIaE9jI1/UYgYh?=
 =?iso-8859-1?Q?0Rh8DByyf/jYTzClzvT0zhS85wkrYpn6TSYSk5kyCn3Q1yAabHEFOdE9m5?=
 =?iso-8859-1?Q?FdlUalndqaCfulpK6P6zUAW6VF02oxdpSBxMQWlbeBJHgY+q1VsMhE2MfD?=
 =?iso-8859-1?Q?J6tMOZ1Gz6OPmZwwB3HJYPYhYhPd0HLDwZnLtT0jJAHniUoKP1a3scHWE1?=
 =?iso-8859-1?Q?yUXcGzkO1f8OeWQEHSMPFY8+lzZDCb6xzsBhkdkVQbcBQOcX4z0OiVQoxk?=
 =?iso-8859-1?Q?DYkMbpyOuBc0F4r/icPDVI4GNq47e8hDXuxxECWFGRZSIWokxzbYe0DxVf?=
 =?iso-8859-1?Q?aGZQWosBdVhRVbmDTJMVc59M+gaqyqehhJaRr9uBAYOMTT8/kSGRAMA1/V?=
 =?iso-8859-1?Q?OShveJgGYUDxpqfr5zPhj7yOob6oZ6OpjvHjTBv9RGEd8GOGRTNCxnnSWv?=
 =?iso-8859-1?Q?6n1NXBtF93UVe1exDlNh4Nyva8I+9Zp+tpK8o9Iz++Vg6cutREZDl9pIzg?=
 =?iso-8859-1?Q?xXFRhPWAYb82yhcrxZeroAI/y36ATPcj7jTFgvVRBlyOcIWxnWw816N1/w?=
 =?iso-8859-1?Q?58mRnBppaeUxyqq8WDWlcitziaie+0exeyPNJmOW32Mtqmqa1/aJ2O8p77?=
 =?iso-8859-1?Q?QsDSsEy/WXMTYlL4ReGnSMhy5yBtnLXesVUxYU868AJduedMkB02MusEDJ?=
 =?iso-8859-1?Q?WaHLvm1on1vORFsebUeKOryeMSYDf0LuhRsRk4jzJdxqqcXiScmSMSfpys?=
 =?iso-8859-1?Q?zD+znCAAzv7Jabo9IcBCouCvgCF4OvduC9y6taa1AnRMUYpro+s9nOtDUu?=
 =?iso-8859-1?Q?opZUC7q/bP0Oes9G/e2IbZbxxQnfGowBHK/1+WmJbG+RTMWuCa/iEe4o9W?=
 =?iso-8859-1?Q?HDOZYXXpGJqbz1Wffw1Pp+kuytBPWn1vjDxjnH4ot71BLsgyb/8Hx9b8Gz?=
 =?iso-8859-1?Q?fJmEf1K67UqDwx43kiaOlGANALXEMZRYQC9yUwbiR55NhhzRUR4uvYpbsc?=
 =?iso-8859-1?Q?lp1UfXhbihNl6dnC5tyXTH2ZEI4D1h85xQ7gdOTi5X0gSE7EceVm78dF2G?=
 =?iso-8859-1?Q?8xIICSccuvlC3IO/en7YLOwLFKOSmq4ViP12Z67QWihWcsKfqY6PocKKDI?=
 =?iso-8859-1?Q?U/LMHJOWyVwGOExEvlJrrUPPl0zn+Y9W6QxdmO5yX1a2MNc0CyDuNrrrM9?=
 =?iso-8859-1?Q?zXewkbRGsCb/nwqdGwMXjo0ML6B320jUJT/cjUtMYkTRXDflWSOhH+w/Zs?=
 =?iso-8859-1?Q?NuiwRxKWgO1q4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51927F54E204261B0984B7FBF559ABL1PR12MB5192namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e21a71c-e9ff-400a-5453-08ddcb8d5627
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 15:10:05.2660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZf/k+NtPemSOelfBpGVohMhB72b8HYYaQ1LHOv5yC8Ao8FifS4cXBURkBwd9HKO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDB1826343
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

--_000_BL1PR12MB51927F54E204261B0984B7FBF559ABL1PR12MB5192namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
________________________________
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Thursday, July 24, 2025 11:45 PM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Liu, Wenjing <Wenjing.Liu=
@amd.com>; Strauss, Michael <Michael.Strauss@amd.com>; Hung, Alex <Alex.Hun=
g@amd.com>; Shen, George <George.Shen@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Lin, Wayne <Wayne.Lin@amd.com=
>; Lee, Alvin <Alvin.Lee2@amd.com>; Wu, Ray <Ray.Wu@amd.com>; Wentland, Har=
ry <Harry.Wentland@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.co=
m>; Li, Roman <Roman.Li@amd.com>
Subject: [PATCH v4] drm/amd/display: Reduce Stack Usage by moving 'audio_ou=
tput' into 'stream_res' v4

The function `dp_retrain_link_dp_test` currently allocates a large
audio_output array on the stack, causing the stack frame size to exceed
the compiler limit (1080 bytes > 1024 bytes).

This change prevents stack overflow issues:
amdgpu/../display/dc/link/accessories/link_dp_cts.c:65:13: warning: stack f=
rame size (1080) exceeds limit (1024) in 'dp_retrain_link_dp_test' [-Wframe=
-larger-than]
static void dp_retrain_link_dp_test(struct dc_link *link,

v2: Move audio-related data like `audio_output` is kept "per pipe" to
    manage the audio for that specific display pipeline/display output path
    (stream). (Wenjing)

v3: Update in all the places where `build_audio_output` is currently
    called with a separate audio_output variable on the stack & wherever
    `audio_output` is passed to other functions
    `dce110_apply_single_controller_ctx_to_hw()` &
    `dce110_setup_audio_dto()` (like `az_configure`, `wall_dto_setup`)
    replace with usage of `pipe_ctx->stream_res.audio_output`
    to centralize audio data per pipe.

v4: Remove empty lines before `build_audio_output`. (Alex)

'Fixes: 9437059b4bfb ("drm/amd/display: Fix Link Override Sequencing When
Switching Between DIO/HPO")'
Cc: Wayne Lin <wayne.lin@amd.com>
Cc: George Shen <george.shen@amd.com>
Cc: Michael Strauss <michael.strauss@amd.com>
Cc: Alvin Lee <Alvin.Lee2@amd.com>
Cc: Ray Wu <ray.wu@amd.com>
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 32 ++++++++-----------
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  5 +--
 .../display/dc/link/accessories/link_dp_cts.c | 12 +++----
 .../dc/resource/dcn31/dcn31_resource.c        |  5 ++-
 .../dc/resource/dcn31/dcn31_resource.h        |  3 +-
 5 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/dr=
ivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 4ea13d0bf815..c69194e04ff9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1600,19 +1600,17 @@ enum dc_status dce110_apply_single_controller_ctx_t=
o_hw(
         }

         if (pipe_ctx->stream_res.audio !=3D NULL) {
-               struct audio_output audio_output =3D {0};
+               build_audio_output(context, pipe_ctx, &pipe_ctx->stream_res=
.audio_output);

-               build_audio_output(context, pipe_ctx, &audio_output);
-
-               link_hwss->setup_audio_output(pipe_ctx, &audio_output,
+               link_hwss->setup_audio_output(pipe_ctx, &pipe_ctx->stream_r=
es.audio_output,
                                 pipe_ctx->stream_res.audio->inst);

                 pipe_ctx->stream_res.audio->funcs->az_configure(
                                 pipe_ctx->stream_res.audio,
                                 pipe_ctx->stream->signal,
-                               &audio_output.crtc_info,
+                               &pipe_ctx->stream_res.audio_output.crtc_inf=
o,
                                 &pipe_ctx->stream->audio_info,
-                               &audio_output.dp_link_info);
+                               &pipe_ctx->stream_res.audio_output.dp_link_=
info);

                 if (dc->config.disable_hbr_audio_dp2)
                         if (pipe_ctx->stream_res.audio->funcs->az_disable_=
hbr_audio &&
@@ -2386,9 +2384,7 @@ static void dce110_setup_audio_dto(
                 if (pipe_ctx->stream->signal !=3D SIGNAL_TYPE_HDMI_TYPE_A)
                         continue;
                 if (pipe_ctx->stream_res.audio !=3D NULL) {
-                       struct audio_output audio_output;
-
-                       build_audio_output(context, pipe_ctx, &audio_output=
);
+                       build_audio_output(context, pipe_ctx, &pipe_ctx->st=
ream_res.audio_output);

                         if (dc->res_pool->dccg && dc->res_pool->dccg->func=
s->set_audio_dtbclk_dto) {
                                 struct dtbclk_dto_params dto_params =3D {0=
};
@@ -2399,14 +2395,14 @@ static void dce110_setup_audio_dto(
                                 pipe_ctx->stream_res.audio->funcs->wall_dt=
o_setup(
                                                 pipe_ctx->stream_res.audio=
,
                                                 pipe_ctx->stream->signal,
-                                               &audio_output.crtc_info,
-                                               &audio_output.pll_info);
+                                               &pipe_ctx->stream_res.audio=
_output.crtc_info,
+                                               &pipe_ctx->stream_res.audio=
_output.pll_info);
                         } else
                                 pipe_ctx->stream_res.audio->funcs->wall_dt=
o_setup(
                                         pipe_ctx->stream_res.audio,
                                         pipe_ctx->stream->signal,
-                                       &audio_output.crtc_info,
-                                       &audio_output.pll_info);
+                                       &pipe_ctx->stream_res.audio_output.=
crtc_info,
+                                       &pipe_ctx->stream_res.audio_output.=
pll_info);
                         break;
                 }
         }
@@ -2426,15 +2422,15 @@ static void dce110_setup_audio_dto(
                                 continue;

                         if (pipe_ctx->stream_res.audio !=3D NULL) {
-                               struct audio_output audio_output =3D {0};
-
-                               build_audio_output(context, pipe_ctx, &audi=
o_output);
+                               build_audio_output(context,
+                                                  pipe_ctx,
+                                                  &pipe_ctx->stream_res.au=
dio_output);

                                 pipe_ctx->stream_res.audio->funcs->wall_dt=
o_setup(
                                         pipe_ctx->stream_res.audio,
                                         pipe_ctx->stream->signal,
-                                       &audio_output.crtc_info,
-                                       &audio_output.pll_info);
+                                       &pipe_ctx->stream_res.audio_output.=
crtc_info,
+                                       &pipe_ctx->stream_res.audio_output.=
pll_info);
                                 break;
                         }
                 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/=
drm/amd/display/dc/inc/core_types.h
index f0d7185153b2..f896cce87b8d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -228,8 +228,7 @@ struct resource_funcs {
         enum dc_status (*update_dc_state_for_encoder_switch)(struct dc_lin=
k *link,
                 struct dc_link_settings *link_setting,
                 uint8_t pipe_count,
-               struct pipe_ctx *pipes,
-               struct audio_output *audio_output);
+               struct pipe_ctx *pipes);
 };

 struct audio_support{
@@ -361,6 +360,8 @@ struct stream_resource {
         uint8_t gsl_group;

         struct test_pattern_params test_pattern_params;
+
+       struct audio_output audio_output;
 };

 struct plane_resource {
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c =
b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 2956c2b3ad1a..b12d61701d4d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -75,7 +75,6 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
         bool is_hpo_acquired;
         uint8_t count;
         int i;
-       struct audio_output audio_output[MAX_PIPES];

         needs_divider_update =3D (link->dc->link_srv->dp_get_encoding_form=
at(link_setting) !=3D
         link->dc->link_srv->dp_get_encoding_format((const struct dc_link_s=
ettings *) &link->cur_link_settings));
@@ -99,7 +98,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
         if (needs_divider_update && link->dc->res_pool->funcs->update_dc_s=
tate_for_encoder_switch) {
                 link->dc->res_pool->funcs->update_dc_state_for_encoder_swi=
tch(link,
                                 link_setting, count,
-                               *pipes, &audio_output[0]);
+                               *pipes);
                 for (i =3D 0; i < count; i++) {
                         pipes[i]->clock_source->funcs->program_pix_clk(
                                         pipes[i]->clock_source,
@@ -111,15 +110,16 @@ static void dp_retrain_link_dp_test(struct dc_link *l=
ink,
                                 const struct link_hwss *link_hwss =3D get_=
link_hwss(
                                         link, &pipes[i]->link_res);

-                               link_hwss->setup_audio_output(pipes[i], &au=
dio_output[i],
-                                               pipes[i]->stream_res.audio-=
>inst);
+                               link_hwss->setup_audio_output(pipes[i],
+                                                             &pipes[i]->st=
ream_res.audio_output,
+                                                             pipes[i]->str=
eam_res.audio->inst);

                                 pipes[i]->stream_res.audio->funcs->az_conf=
igure(
                                                 pipes[i]->stream_res.audio=
,
                                                 pipes[i]->stream->signal,
-                                               &audio_output[i].crtc_info,
+                                               &pipes[i]->stream_res.audio=
_output.crtc_info,
                                                 &pipes[i]->stream->audio_i=
nfo,
-                                               &audio_output[i].dp_link_in=
fo);
+                                               &pipes[i]->stream_res.audio=
_output.dp_link_info);

                                 if (link->dc->config.disable_hbr_audio_dp2=
 &&
                                                 pipes[i]->stream_res.audio=
->funcs->az_disable_hbr_audio &&
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c=
 b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 3ed7f50554e2..ca17e5d8fdc2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -2239,8 +2239,7 @@ struct resource_pool *dcn31_create_resource_pool(
 enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *li=
nk,
         struct dc_link_settings *link_setting,
         uint8_t pipe_count,
-       struct pipe_ctx *pipes,
-       struct audio_output *audio_output)
+       struct pipe_ctx *pipes)
 {
         struct dc_state *state =3D link->dc->current_state;
         int i;
@@ -2255,7 +2254,7 @@ enum dc_status dcn31_update_dc_state_for_encoder_swit=
ch(struct dc_link *link,

                 // Setup audio
                 if (pipes[i].stream_res.audio !=3D NULL)
-                       build_audio_output(state, &pipes[i], &audio_output[=
i]);
+                       build_audio_output(state, &pipes[i], &pipes[i].stre=
am_res.audio_output);
         }
 #else
         /* This DCN requires rate divider updates and audio reprogramming =
to allow DP1<-->DP2 link rate switching,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h=
 b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
index c32c85ef0ba4..7e8fde65528f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
@@ -69,8 +69,7 @@ unsigned int dcn31_get_det_buffer_size(
 enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *li=
nk,
         struct dc_link_settings *link_setting,
         uint8_t pipe_count,
-       struct pipe_ctx *pipes,
-       struct audio_output *audio_output);
+       struct pipe_ctx *pipes);

 /*temp: B0 specific before switch to dcn313 headers*/
 #ifndef regPHYPLLF_PIXCLK_RESYNC_CNTL
--
2.34.1


--_000_BL1PR12MB51927F54E204261B0984B7FBF559ABL1PR12MB5192namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Wenjing Liu &lt;wenjing.liu@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt=
;<br>
<b>Sent:</b>&nbsp;Thursday, July 24, 2025 11:45 PM<br>
<b>To:</b>&nbsp;Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Liu, We=
njing &lt;Wenjing.Liu@amd.com&gt;; Strauss, Michael &lt;Michael.Strauss@amd=
.com&gt;; Hung, Alex &lt;Alex.Hung@amd.com&gt;; Shen, George &lt;George.She=
n@amd.com&gt;<br>
<b>Cc:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Lin, =
Wayne &lt;Wayne.Lin@amd.com&gt;; Lee, Alvin &lt;Alvin.Lee2@amd.com&gt;; Wu,=
 Ray &lt;Ray.Wu@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;=
;
 Chung, ChiaHsuan (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;; Li, Roman &lt;Roma=
n.Li@amd.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH v4] drm/amd/display: Reduce Stack Usage by movi=
ng 'audio_output' into 'stream_res' v4
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">The function `dp_retrain_link_dp_test` curr=
ently allocates a large<br>
audio_output array on the stack, causing the stack frame size to exceed<br>
the compiler limit (1080 bytes &gt; 1024 bytes).<br>
<br>
This change prevents stack overflow issues:<br>
amdgpu/../display/dc/link/accessories/link_dp_cts.c:65:13: warning: stack f=
rame size (1080) exceeds limit (1024) in 'dp_retrain_link_dp_test' [-Wframe=
-larger-than]<br>
static void dp_retrain_link_dp_test(struct dc_link *link,<br>
<br>
v2: Move audio-related data like `audio_output` is kept &quot;per pipe&quot=
; to<br>
&nbsp;&nbsp;&nbsp; manage the audio for that specific display pipeline/disp=
lay output path<br>
&nbsp;&nbsp;&nbsp; (stream). (Wenjing)<br>
<br>
v3: Update in all the places where `build_audio_output` is currently<br>
&nbsp;&nbsp;&nbsp; called with a separate audio_output variable on the stac=
k &amp; wherever<br>
&nbsp;&nbsp;&nbsp; `audio_output` is passed to other functions<br>
&nbsp;&nbsp;&nbsp; `dce110_apply_single_controller_ctx_to_hw()` &amp;<br>
&nbsp;&nbsp;&nbsp; `dce110_setup_audio_dto()` (like `az_configure`, `wall_d=
to_setup`)<br>
&nbsp;&nbsp;&nbsp; replace with usage of `pipe_ctx-&gt;stream_res.audio_out=
put`<br>
&nbsp;&nbsp;&nbsp; to centralize audio data per pipe.<br>
<br>
v4: Remove empty lines before `build_audio_output`. (Alex)<br>
<br>
'Fixes: 9437059b4bfb (&quot;drm/amd/display: Fix Link Override Sequencing W=
hen<br>
Switching Between DIO/HPO&quot;)'<br>
Cc: Wayne Lin &lt;wayne.lin@amd.com&gt;<br>
Cc: George Shen &lt;george.shen@amd.com&gt;<br>
Cc: Michael Strauss &lt;michael.strauss@amd.com&gt;<br>
Cc: Alvin Lee &lt;Alvin.Lee2@amd.com&gt;<br>
Cc: Ray Wu &lt;ray.wu@amd.com&gt;<br>
Cc: Wenjing Liu &lt;wenjing.liu@amd.com&gt;<br>
Cc: Harry Wentland &lt;harry.wentland@amd.com&gt;<br>
Cc: Tom Chung &lt;chiahsuan.chung@amd.com&gt;<br>
Cc: Roman Li &lt;roman.li@amd.com&gt;<br>
Cc: Alex Hung &lt;alex.hung@amd.com&gt;<br>
Cc: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br=
>
---<br>
&nbsp;.../amd/display/dc/hwss/dce110/dce110_hwseq.c | 32 ++++++++----------=
-<br>
&nbsp;.../gpu/drm/amd/display/dc/inc/core_types.h&nbsp;&nbsp; |&nbsp; 5 +--=
<br>
&nbsp;.../display/dc/link/accessories/link_dp_cts.c | 12 +++----<br>
&nbsp;.../dc/resource/dcn31/dcn31_resource.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 5 ++-<br>
&nbsp;.../dc/resource/dcn31/dcn31_resource.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 3 +-<br>
&nbsp;5 files changed, 26 insertions(+), 31 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/dr=
ivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c<br>
index 4ea13d0bf815..c69194e04ff9 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c<br>
@@ -1600,19 +1600,17 @@ enum dc_status dce110_apply_single_controller_ctx_t=
o_hw(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pipe_ctx-&gt;stream_re=
s.audio !=3D NULL) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct audio_output audio_output =3D {0};<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; build_audio_output(context, pipe_ctx, &amp;pipe_ctx-&gt;stream_r=
es.audio_output);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; build_audio_output(context, pipe_ctx, &amp;audio_output);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; link_hwss-&gt;setup_audio_output(pipe_ctx, &amp;audio_output,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; link_hwss-&gt;setup_audio_output(pipe_ctx, &amp;pipe_ctx-&gt;str=
eam_res.audio_output,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.audio-&g=
t;inst);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.audio-&gt;funcs-&gt;az_config=
ure(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.audio,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream-&gt;signal,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;audio_output.crtc_info,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pipe_ctx-&gt;stream_res.audio_output.c=
rtc_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pipe_ctx-&gt;stream-&gt;aud=
io_info,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;audio_output.dp_link_info);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pipe_ctx-&gt;stream_res.audio_output.d=
p_link_info);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (dc-&gt;config.disable_hbr_audio_dp2)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p=
ipe_ctx-&gt;stream_res.audio-&gt;funcs-&gt;az_disable_hbr_audio &amp;&amp;<=
br>
@@ -2386,9 +2384,7 @@ static void dce110_setup_audio_dto(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (pipe_ctx-&gt;stream-&gt;signal !=3D SIGNAL_TYPE_H=
DMI_TYPE_A)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (pipe_ctx-&gt;stream_res.audio !=3D NULL) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct audio_out=
put audio_output;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; build_audio_outp=
ut(context, pipe_ctx, &amp;audio_output);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; build_audio_outp=
ut(context, pipe_ctx, &amp;pipe_ctx-&gt;stream_res.audio_output);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (d=
c-&gt;res_pool-&gt;dccg &amp;&amp; dc-&gt;res_pool-&gt;dccg-&gt;funcs-&gt;s=
et_audio_dtbclk_dto) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dtbclk_dto_params dto_par=
ams =3D {0};<br>
@@ -2399,14 +2395,14 @@ static void dce110_setup_audio_dto(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.audio-&g=
t;funcs-&gt;wall_dto_setup(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&g=
t;stream_res.audio,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&g=
t;stream-&gt;signal,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;audio_output.crtc=
_info,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;audio_output.pll_=
info);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pipe_ctx-&gt;stre=
am_res.audio_output.crtc_info,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pipe_ctx-&gt;stre=
am_res.audio_output.pll_info);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } els=
e<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.audio-&g=
t;funcs-&gt;wall_dto_setup(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.audio,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;stream-&gt;signal,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;audio_output.crtc_info,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;audio_output.pll_info);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;pipe_ctx-&gt;stream_res.audio_output.crtc_info,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;pipe_ctx-&gt;stream_res.audio_output.pll_info);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -2426,15 +2422,15 @@ static void dce110_setup_audio_dto(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p=
ipe_ctx-&gt;stream_res.audio !=3D NULL) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct audio_output audio_output =3D {0};<b=
r>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; build_audio_output(context, pipe_ctx, &amp;=
audio_output);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; build_audio_output(context,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe=
_ctx,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp=
;pipe_ctx-&gt;stream_res.audio_output);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.audio-&g=
t;funcs-&gt;wall_dto_setup(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.audio,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;stream-&gt;signal,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;audio_output.crtc_info,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;audio_output.pll_info);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;pipe_ctx-&gt;stream_res.audio_output.crtc_info,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;pipe_ctx-&gt;stream_res.audio_output.pll_info);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/=
drm/amd/display/dc/inc/core_types.h<br>
index f0d7185153b2..f896cce87b8d 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h<br>
@@ -228,8 +228,7 @@ struct resource_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dc_status (*update_dc=
_state_for_encoder_switch)(struct dc_link *link,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dc_link_settings *link_setting,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint8_t pipe_count,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct pipe_ctx *pipes,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct audio_output *audio_output);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct pipe_ctx *pipes);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct audio_support{<br>
@@ -361,6 +360,8 @@ struct stream_resource {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t gsl_group;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct test_pattern_params=
 test_pattern_params;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct audio_output audio_output;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct plane_resource {<br>
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c =
b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c<br>
index 2956c2b3ad1a..b12d61701d4d 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c<br>
@@ -75,7 +75,6 @@ static void dp_retrain_link_dp_test(struct dc_link *link,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_hpo_acquired;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t count;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct audio_output audio_output[MAX_=
PIPES];<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; needs_divider_update =3D (=
link-&gt;dc-&gt;link_srv-&gt;dp_get_encoding_format(link_setting) !=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link-&gt;dc-&gt;link_srv-&=
gt;dp_get_encoding_format((const struct dc_link_settings *) &amp;link-&gt;c=
ur_link_settings));<br>
@@ -99,7 +98,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (needs_divider_update &=
amp;&amp; link-&gt;dc-&gt;res_pool-&gt;funcs-&gt;update_dc_state_for_encode=
r_switch) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; link-&gt;dc-&gt;res_pool-&gt;funcs-&gt;update_dc_stat=
e_for_encoder_switch(link,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link_setting, count,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pipes, &amp;audio_output[0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pipes);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; count; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipes=
[i]-&gt;clock_source-&gt;funcs-&gt;program_pix_clk(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipes[i]-&gt;clock_source,<br>
@@ -111,15 +110,16 @@ static void dp_retrain_link_dp_test(struct dc_link *l=
ink,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct link_hwss *link_hws=
s =3D get_link_hwss(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; link, &amp;pipes[i]-&gt;link_res);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link_hwss-&gt;setup_audio_output(pipes[i], =
&amp;audio_output[i],<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipes[i]-&gt;stream_re=
s.audio-&gt;inst);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link_hwss-&gt;setup_audio_output(pipes[i],<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pipes[i]=
-&gt;stream_res.audio_output,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipes[i]-&gt;=
stream_res.audio-&gt;inst);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipes[i]-&gt;stream_res.audio-&g=
t;funcs-&gt;az_configure(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipes[i]-&g=
t;stream_res.audio,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipes[i]-&g=
t;stream-&gt;signal,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;audio_output[i].c=
rtc_info,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pipes[i]-&gt;stre=
am_res.audio_output.crtc_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pipes[=
i]-&gt;stream-&gt;audio_info,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;audio_output[i].d=
p_link_info);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pipes[i]-&gt;stre=
am_res.audio_output.dp_link_info);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (link-&gt;dc-&gt;config.disab=
le_hbr_audio_dp2 &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipes[i]-&g=
t;stream_res.audio-&gt;funcs-&gt;az_disable_hbr_audio &amp;&amp;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c=
 b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c<br>
index 3ed7f50554e2..ca17e5d8fdc2 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c<br>
@@ -2239,8 +2239,7 @@ struct resource_pool *dcn31_create_resource_pool(<br>
&nbsp;enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_lin=
k *link,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_link_settings *l=
ink_setting,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t pipe_count,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pipe_ctx *pipes,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct audio_output *audio_output)<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pipe_ctx *pipes)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_state *state =3D=
 link-&gt;dc-&gt;current_state;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
@@ -2255,7 +2254,7 @@ enum dc_status dcn31_update_dc_state_for_encoder_swit=
ch(struct dc_link *link,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; // Setup audio<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (pipes[i].stream_res.audio !=3D NULL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; build_audio_outp=
ut(state, &amp;pipes[i], &amp;audio_output[i]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; build_audio_outp=
ut(state, &amp;pipes[i], &amp;pipes[i].stream_res.audio_output);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;#else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* This DCN requires rate =
divider updates and audio reprogramming to allow DP1&lt;--&gt;DP2 link rate=
 switching,<br>
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h=
 b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h<br>
index c32c85ef0ba4..7e8fde65528f 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h<br>
@@ -69,8 +69,7 @@ unsigned int dcn31_get_det_buffer_size(<br>
&nbsp;enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_lin=
k *link,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_link_settings *l=
ink_setting,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t pipe_count,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pipe_ctx *pipes,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct audio_output *audio_output);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pipe_ctx *pipes);<br>
&nbsp;<br>
&nbsp;/*temp: B0 specific before switch to dcn313 headers*/<br>
&nbsp;#ifndef regPHYPLLF_PIXCLK_RESYNC_CNTL<br>
--<br>
2.34.1<br>
<br>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB51927F54E204261B0984B7FBF559ABL1PR12MB5192namp_--
