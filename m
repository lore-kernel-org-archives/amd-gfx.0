Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D57C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 14:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B2E10E573;
	Mon, 10 Feb 2025 14:32:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S4l/Tj/Q";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A486E10E573
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 14:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2n0ihirnTMNfOlk1RZT4wXiueYMKTZxwPbexyuT+Zy1MTN+UEhOoV19erxFO0eVfhA0GtlKrEbL/ZEfKszMK280iDkgdouvjvONfPruQXXXnKEESsSSeOYK6S8ZmmphUJgWxU+ixK+E4qn3Vvwzz7cpDNTNSNDdb7kUNXXAYk3HGD8Dq8TdtbNznkmQBkeBRtxGV+5saDNkd9gVoWVT4gZeY+O6f4MN3hC+5v5fvBjtQndR3nY2LqiwgdiwHd1j3LpvRwx1hzbsvC1Ywv3U9zDpyZzIaLGyFIK2oM1a8Mwx6+81oc+GuqTdBvXo4eZUeV8oiump/I6aCftrE0c4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkVJMRrB+S9lv3Q5x3Rvd2K0pgOOZogCb/QUt9Y6KMk=;
 b=JGnCXPaFPS2zsXB/D2f2bFtVcEBnApALeGSn1WlnhH/eyeZ750TP0c1/JwS9fRqETVBcR2o15qs+mRF/zj4344IisHOZvSOEpYaCVpFCjv5ceN3y0gb89s1M6mvTx9hgEx4D8glwKe77nP/KnrPSE1duDsjQyZ8Ypf8q+urihilrbsYp/uBf+Ia05DcwwPTLuEEOiDEqqbEx2GYbOPee514RU31BZGgYWh7CKQoVZdOzig1VDpiwpMwYJuaymH6uH757dMJAeW5qi9DtHulgpIwHxOOJMFkSgHA7OGiQSH/cFOEVOwMot/4t5VWgFfiNVCZDgLqtTQe7pHTZuDN1hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkVJMRrB+S9lv3Q5x3Rvd2K0pgOOZogCb/QUt9Y6KMk=;
 b=S4l/Tj/QyzR7P9tjB2KEWe0cgVJRdS9aXkb/q5qDKhAm+ObjtqLBUe80yWvXNl5eTx/8Xpm51762S+UsN8q7L6M+p1PYOA3Z4pxYjMiP9vf4KCiSdgpSB/u/XnlO/R+SbTLbUfFr2NqiJVjmYkqCNPrhrBPXpwZYXbZHnF9wujs=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 14:32:23 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%2]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 14:32:22 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung, ChiaHsuan
 (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, 
 Zaeem" <Zaeem.Mohamed@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>
Subject: RE: [PATCH 00/14] DC Patches for 10 Feb 2025
Thread-Topic: [PATCH 00/14] DC Patches for 10 Feb 2025
Thread-Index: AQHbd/188mQqiL+XbUKabbQPl0lJjbNAoN0A
Date: Mon, 10 Feb 2025 14:32:22 +0000
Message-ID: <DS0PR12MB65346A4995A3356B7254F5E09CF22@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
In-Reply-To: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=d95b0863-9657-4de5-8108-c3618f6df400;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-10T14:31:33Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|IA0PR12MB7556:EE_
x-ms-office365-filtering-correlation-id: 9e1c6c19-fbab-4204-b7af-08dd49dfbb71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?50Ys/dQ5+qd95TVohSTV3lJuKjVeJWqA/5eG3ndhpxd8h/d385ELRpHUGN?=
 =?iso-8859-1?Q?ItFZKgGVIMg0Qau0Y+QMD7g2HDAx9FgJKfyNbhvCDVTldGSENxnu4cykTV?=
 =?iso-8859-1?Q?MYcbVLpZf7IX8n84gZQXPT5xZthVhkr0yUk6LpNG8vG1cDNa5AmIM+Rbjr?=
 =?iso-8859-1?Q?KFBmeuAXo+vA15LqwYM3Z3fFpzPKxYq3LMCu/x72f3XASp3Xm66uv+vZvj?=
 =?iso-8859-1?Q?kmrp9DLfJaFp6Sfm5sNxd5Xui7hfXecvLVVK4TdNpSrExwiowrGN+YiZdm?=
 =?iso-8859-1?Q?UzOAIcEmj5idVwVbcckVFyjdx+2PCsAidhKeR4cDZzuz6jtMc2IxYVcGYI?=
 =?iso-8859-1?Q?Z6iWPrw53uSSOGmnnDn9PBk1L3QBVSfyv9ZKakzOlKucVoXBl8pWroABV3?=
 =?iso-8859-1?Q?MKO3MjIQOBsqb1jLoiBWwlWJPbCp1sxckDoiG6HcnMK/wuqKPXZes1mnrz?=
 =?iso-8859-1?Q?4s5xhhSCVrnblLlZxTdinMFJ2zwX58T2PbPpFK18n20MSsGzhr+wQ1crKX?=
 =?iso-8859-1?Q?Z1mbf9TMOo5OpddIgNItu8Zako6MezR8WwY5RhMHxwvoyuPa3tgFf2OP1t?=
 =?iso-8859-1?Q?spvfXNA4zjNv3og3bo9K363C4igDk7wVelPcZ3X7JZodf200TEzpKmPh6E?=
 =?iso-8859-1?Q?/5qLSr7yH1m2UT42PPjbw7hJ60jxF6v0q9mEGhaC5r7JbkJbLQVqO5pPUv?=
 =?iso-8859-1?Q?iDJu4COvi8ZHznsTnbVgTH+gfF0UUTgYGWjeQomMM0ivouhzndo+y8+slQ?=
 =?iso-8859-1?Q?UEE2BAxKrktB0HsyqymrP7Jlr66Q05as91T/4g/AlCtG04G0is51agQZpH?=
 =?iso-8859-1?Q?09NjPpBvxNAJTdS9JuGCU8FpMl23kJf0Nynyu2visCQH5Wq7bEONPdykk4?=
 =?iso-8859-1?Q?w4IU145iNoYmJf3ToxlMkP/WuSTSHzADUzxoMBKZyG+DB/DaoZLnbGUNOb?=
 =?iso-8859-1?Q?Myl4omT3RxcayBB727QZljEhwwEZtwwoFwdJfaEkS7D/DBqR1sAPc4HiCr?=
 =?iso-8859-1?Q?uCF0xfHA9QEZtrwToQm1/dP4f4ES+Z62/sWmI+1pAFX3wct37qo66CMhEs?=
 =?iso-8859-1?Q?4zLN0YHE01urFGPGHGahsZ4e5gNwGcz/rIrduF94+BSAUGYsAIXdVqTR2k?=
 =?iso-8859-1?Q?3p0OVW/d19MuKZiopeSC+/9OV62DTraVK7ODQPET7F6nUt2Rl5Tvfz3jqu?=
 =?iso-8859-1?Q?FhgFwMwpah/dmYnilIQHdTXT3E+s68YPbhkw/GzlgTy8yvfTaMIgr7GXfR?=
 =?iso-8859-1?Q?JM/GSm8DNvOdMiqo0WOIgcOElkBqt1ussf7PJUirG4CrhgS1CqcaaF0JEV?=
 =?iso-8859-1?Q?z174aI8U5+sFTSQ86+kLJOCGtWXxxG8sMcDEjuEEWJ0yH+HA1+AGXdUXAa?=
 =?iso-8859-1?Q?wrKIc7qLT26pjHu0rpvtAA8LUSml88DRsxmE9qkH3RZpgSH1p5u2gY+1qV?=
 =?iso-8859-1?Q?ku+zE3yrSLZvpcRZ4Dy5hR4v0CJwg87RYRcd7mifvCGMchUkpt/XhovCtD?=
 =?iso-8859-1?Q?I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8VhvTfkVOqiZMs7P+/fizWdignWa8ljNriccDhgOIB3JQ/xSulfqDaapSN?=
 =?iso-8859-1?Q?3hc7FTrpB6dPcnQVXlD0okwJBR4msh+caCLF87xQJSA2UrvPs3v7bsNPn4?=
 =?iso-8859-1?Q?7CkxjhY9HKimHqqcDhzIViuzgPoE5pRAI6sp+yRBmbDYliT8/5q+FCh0ik?=
 =?iso-8859-1?Q?AozLb/uNx7KPoReBXTJBLlLOZyh1Cd+A068gthb+HqUJQDn/Yr/7hb6gyg?=
 =?iso-8859-1?Q?cLioTGr2kbYVGE7woEck1YrigxdLU6ijfemj2hmSE3+dX1AOmNzZBTWhPM?=
 =?iso-8859-1?Q?Fl0PJkYqPmhOw1fvR0Lvu9giOyqwG2Ld93icqkoDP+4SziMnqB2/0AV8JD?=
 =?iso-8859-1?Q?bYBEHl4EwDiBYx0mPl1shrlsMtWVAI35uoGIl0Vc3g4X/70whdJBM304xt?=
 =?iso-8859-1?Q?QZ4/w+gyyZAPUvdoNOkZh34oi4WKo6QnBhJkjmy0ViBbAl0QXRs2VaJXQ8?=
 =?iso-8859-1?Q?6uCizl0tkOfVvQaX1Vamt2LYM+Q97rHmSUZXNZJG526l0fdlYxinPgghC2?=
 =?iso-8859-1?Q?X9DJ9Q0C4/r02nFryRWf/FibyV4ilVyZBr5A1iaC0YAR/T6S/eNVTyRFRL?=
 =?iso-8859-1?Q?uzR7tUEM2r9xLxxh8tqcHK/kqZTPH0N2iKW6UPgm4lxfWYa4euUvhrsdiA?=
 =?iso-8859-1?Q?uRHPorMLzN+FtC/dRDFxy4pWC8Tetezp5QnjS4yb4UIsIKTrGwrIFvvZTG?=
 =?iso-8859-1?Q?3BjTLmDpJ8v1VhYEFUI99KvdXMjvqHfCseVfg7sqBI2KGLRg3BmSfVAN8v?=
 =?iso-8859-1?Q?/ukyWP/T5AzOShfJpdOZzt4sMEluncKM9pRq/SE6o3D0+2IPwFebjSbeLB?=
 =?iso-8859-1?Q?WPzow0RuWJdA1q17PrlX0CFjL/RcFgjsfKdU6UCXDQ32GRH1f/LT3L9XVW?=
 =?iso-8859-1?Q?lvXCZTsCZ5Uhc7nz5v9qBHBAPjENvr3kPOiYEVLBQ9kPi4rbFUMkc7Wc+V?=
 =?iso-8859-1?Q?GIu2F/njR8MWiG0mUPlrwc9m12GvEyNOFGeZ0xzhPIxlFdd5rAyfjtzkvH?=
 =?iso-8859-1?Q?baJzhmc50vyDQzh2tw6o57NQjuNcaBXF6XIxxPc2ekCJGns18cJ/gtp3r6?=
 =?iso-8859-1?Q?R+iHHysIinMMna7jmQY/exO1OCDA4K0QIs9hGMZ63EW2N1Q4RrKB6UeS/4?=
 =?iso-8859-1?Q?2OZIPCz6PzPpIQCHbNu+JFCjmKuJnBE3Wf8x1oMINPFo9/798X222uXmoY?=
 =?iso-8859-1?Q?VXNkJirp1nk8cF7cmvD9q0lcJpzIvFMImiGkqxF1h7ROGUDFMfgbAVf7lX?=
 =?iso-8859-1?Q?JWx0ZUZ/7DXazM4eAYKCfLzdYcWRN7AKBeXTnBK/mpw/irUQcEEW1W/KDp?=
 =?iso-8859-1?Q?BDs4UIqhOo0dIMZvgvlEQoZ8nWe9KbxRkv7JkX+Xk3MrzQn7sV+u5ueeYg?=
 =?iso-8859-1?Q?EGAC24Y8rYxVlW5q5RN3ZxZ+dyinTZANLydTqZWDvYVyud1/2bXDwyC11x?=
 =?iso-8859-1?Q?c8c4edn8i2QK0viGMs5GkClycvihT1YeZA97vluDGp748CI4xWLsxrRWk3?=
 =?iso-8859-1?Q?SYiUcCoeGV5uCdzEHzI2NxrDseOVdNL4Pbo+A+CUCNskPIaPSXiJsZXALk?=
 =?iso-8859-1?Q?SF/vIRINBGoPTyxwCGXS5M/a+Ke1ExD8yXPrfEGBTvWFjXAlf9oWfMLhty?=
 =?iso-8859-1?Q?WWl3Qm/B3WZxc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1c6c19-fbab-4204-b7af-08dd49dfbb71
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 14:32:22.7309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4sMkSzRrLCxjx6lBbDb20PLxsqEDv8FG1jIcoMrdZDafmn9S2sSkHRsjakIywOly4w/oO6EszqcDPdY1bdYYJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556
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
        * Single Display eDP -> 1080p 60hz, 2560x1600 120hz, 1920x1200 165h=
z
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
        * AU Optronics B160QAN02.L 2560x1600 120hz eDP

The patchset consists of the amd-staging-drm-next branch (Head commit - 06f=
bedfaf1a93cd81387ecd517dc48f5b89fc465 -> Revert "drm/amd/display: Use HW lo=
ck mgr for PSR1") with new patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Sr. Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com


-----Original Message-----
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Sent: Wednesday, February 5, 2025 1:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerr=
y <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.Mohamed@amd.com>; Chiu, Solomo=
n <Solomon.Chiu@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/14] DC Patches for 10 Feb 2025

Summary:
        * Start enabling support for 4-plane MPO
        * DML21 Updates
        * SPL Updates
        * Other minor fixes

------------------------------------------------------

Aurabindo Pillai (1):
  drm/amd/display: Make dcn401_program_pipe non static

Ausef Yousof (1):
  drm/amd/display: limit coverage of optimization skip

Austin Zheng (1):
  drm/amd/display: DML21 Reintegration

Brendan Tam (1):
  drm/amd/display: add workaround flag to link to force FFE preset

Charlene Liu (1):
  drm/amd/display: pass calculated dram_speed_mts to dml2

Ilya Bakoulin (1):
  drm/amd/display: Don't try AUX transactions on disconnected link

Leo Zeng (1):
  drm/amd/display: add new IRQ enum for underflows

Samson Tam (4):
  drm/amd/display: use s1_12 filter tables in SPL
  drm/amd/display: remove TF check for LLS policy
  drm/amd/display: add s1_12 filter tables
  drm/amd/display: sspl: cleanup filter code

Taimur Hassan (1):
  drm/amd/display: 3.2.320

Zaeem Mohamed (2):
  drm/amd/display: Expose 3 secondary planes for supported ASICs
  drm/amd/display: docstring definitions MAX_SURFACES and MAX_PLANES

 drivers/gpu/drm/amd/display/dc/dc.h           |    10 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |     2 +
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |     1 +
 .../display/dc/dml2/dml21/inc/dml_top_types.h |     5 -
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c |    22 +-
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.h |     3 -
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |    94 +-
 .../dml21/src/dml2_core/dml2_core_shared.c    | 12413 ----------------
 .../src/dml2_core/dml2_core_shared_types.h    |     9 +-
 .../dml21/src/dml2_core/dml2_core_utils.c     |     3 +-
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |     6 +-
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.h |     2 -
 .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |     2 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |     5 +-
 .../dml21/src/dml2_top/dml2_top_interfaces.c  |     1 -
 .../dc/dml2/dml21/src/dml2_top/dml_top.c      |   354 -
 .../dc/dml2/dml21/src/inc/dml2_debug.c        |     5 -
 .../dc/dml2/dml21/src/inc/dml2_debug.h        |     6 +-
 .../src/inc/dml2_internal_shared_types.h      |     6 -
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |     1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |     2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |     4 +
 drivers/gpu/drm/amd/display/dc/irq_types.h    |     1 +
 .../display/dc/link/protocols/link_dp_phy.c   |     8 +-
 .../dc/link/protocols/link_dp_training.c      |     2 +
 .../dc/resource/dcn21/dcn21_resource.c        |     6 +-
 .../dc/resource/dcn35/dcn35_resource.c        |     7 +-
 .../dc/resource/dcn351/dcn351_resource.c      |     7 +-
 .../dc/resource/dcn401/dcn401_resource.c      |    12 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |    31 +-
 .../display/dc/sspl/dc_spl_isharp_filters.c   |   452 +-
 .../display/dc/sspl/dc_spl_isharp_filters.h   |    18 +-
 .../display/dc/sspl/dc_spl_scl_easf_filters.c |  1058 +-
 .../display/dc/sspl/dc_spl_scl_easf_filters.h |     9 +-
 .../amd/display/dc/sspl/dc_spl_scl_filters.c  |   232 +-
 .../amd/display/dc/sspl/dc_spl_scl_filters.h  |    11 +-
 36 files changed, 1231 insertions(+), 13579 deletions(-)  delete mode 1006=
44 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared=
.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/=
dml_top.c

--
2.48.1

