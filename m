Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFFFF46C53
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2026 16:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D779310E26D;
	Mon,  6 Apr 2026 16:03:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xr1oVTDL";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A2A10E26D
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2026 16:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKg4f1ayy8HCmQ/ylE1gs0nxr8u1f2LKYYviufcP8cxYY3YkBZxDwrgRp7oLsIexZM5bcuzw0ieF6WJ9RTAiwlv2lQKGkHfr33fLkFyBxgoLn3jhG46c/sAM6i21QuXlNfF/8blzRHZJztwJou3nus6XCDx7Q3F3+16/C58l/g3MaqUCKj03ZA4yU+Jezznd+x5hpixhzjXYI+tN5UFqNFK31qtnLmzt9ZJmsgNeHfT36xg4l+KHKP79x1VPbl7TESyAe0NPWOGdYi6dx+b5S2ig3PQCSKchGxIQjLcehjmD7dNF9AsGGlou1jzQp+W/Zw7nyUEskKQ4gOp1q8Wb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osOK+NyiCFWwTkK/w9Bw4yrY7jsKDeDRO+g1DzU2nTs=;
 b=exUflFJk2alDtRCmthCp4or9Z7E15LaW/CxoVvqQAwAfLsanOakraqNe2PCZ8XsHLOTHcf3o1XzBYsMyOHP1CqFVj4QXKs06pt3KVFr2rSP7O3/F2oi0y3X4p9PSNw2kkD0knXQbooUUvMHIVBTuAr14Q7ZepPCwVieQuuO6s2IgZ8fBPvn9uAWm0ssj7yG9qG22v1EkrXeshAlS/sZm+15BjQOh+5ygx+m6GLgmyBsZmJoakFLq7f2xN2AxKFXS5O88Wc0Uj3d08LXb5AvvdS3ulakxNHou/wsX30W9beCuByRUVNuyPc/YfFNI5R91hggohNHuNEcFBTCgQObJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osOK+NyiCFWwTkK/w9Bw4yrY7jsKDeDRO+g1DzU2nTs=;
 b=xr1oVTDLqKQzOAE0C6ruvGZ1qciYT0RZr4WKk64ivog9PfZBASr8XrVid4NU3cE1ULVDKQrRSfYtun53+xlE5q9LELJEBBzFEqla9WlaUoAZfr+hA+FBoyKy3v/KfvEOt9Be8hx3yIVLecbIkCkBaW0vs02oQqe8aon52IrVZQ8=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by BN7PPF48E601ED5.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 16:03:22 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%5]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 16:03:22 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, 
 "Li, Roman" <Roman.Li@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>
Subject: RE: [PATCH] drm/amd/display: Fix do_mccs handling (MCCS/DDC) in
 amdgpu_dm_update_freesync_caps
Thread-Topic: [PATCH] drm/amd/display: Fix do_mccs handling (MCCS/DDC) in
 amdgpu_dm_update_freesync_caps
Thread-Index: AQHcxKRnirFuXGQMC0CWKnsVl2B2wrXSL30AgAAEtmA=
Date: Mon, 6 Apr 2026 16:03:22 +0000
Message-ID: <IA0PR12MB82088F66933DD034DF33E178905DA@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260405023145.2259115-1-srinivasan.shanmugam@amd.com>
 <3cb0ba02-90f7-4b32-86be-ad991e8a397b@amd.com>
In-Reply-To: <3cb0ba02-90f7-4b32-86be-ad991e8a397b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-06T16:02:17.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|BN7PPF48E601ED5:EE_
x-ms-office365-filtering-correlation-id: ffe494ba-4e86-4488-b628-08de93f60732
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: Aqe0s9s8hPEIqAEo9w21vU/jR/klheWEj4SZ6nRKbDa62kiV+LVx/AghgjeWysFWQ1H0BW/jtHA8oOcWv1IHuUtpO6f0Wk5jcaXZCDCl4GPCRDlE1o+Wgu4ffPVxPFdUOGXJT4hKQikWNBHp0ikqm2GrUedhDcKcQVLMJrBdvBPiRP/XYC8Ossrg8v4l29ZNldGOFDwTX7rniDlvxs/F63sB0ge3lvjWIzauiEIhBmdHKAmaM0DPtPbgww++SWIlfTY9Sn5/tD0cJXk/L9heFYBHpnqLfG2GLc+raDu/JXN0mmAyPnfiqNmq93CejgmOwMhPVrbIZxocSUC3fKYvdPsrqPGko/40cKx58dvgplwhmwebbu/1LXF1q1oW8JTfa+/jO5vDwMRaGYm5DsCWJ2lk05FdeOJGlWUDgib51AvW7LTqwrOWy/UeTslGhrPpZxayLaP5wjJlvL8gLA2lKpCgkQ9kdaOksrUuo+SueBzh4Oyd7qLLxZTJ/pqT3kPGKsa6tq9/KOxzonXO8Oy/X3tgjL2Uln/xSfGV2I43DYlzvhD0N6fK/2+j/V2W7PAFK3luQbChd5j3JFprmrsh2M3A8bkaiYqcdrHlCvnS5MC9lQDlRtkrh9AOqw2Ji5+ZpXssbNfLK1GkTlAu9mxZVKIAR1L2R1y11JE2YPBye34VRAY9MyfgItonku6Jflu5bDiIVdfhufDVEo7WzV842bKmlAd5zTFXLdlieWQmv2VoZGO6cEn460wVS94UVzND+8Ypc88y4yw213G/cWUEt6T+u0AsH6Gk44OL7A3pzFc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXJiNWFhTFpTeUtyNmFJaCtIQ1dkRFZoWGdHb1JjTkovM2QydnpFWUs5cnVk?=
 =?utf-8?B?Z0o1d0dxblVGY1NqdjV5NjRMOG5PZVBiNTNYd1pFQU1KU0Jwbkkxa0c5K0k1?=
 =?utf-8?B?bDBueHJKb0VqVThwVS9pSzlRRFg4eDZjaldmZ3c3bmtOTFVPbkJBY21FQ205?=
 =?utf-8?B?N2ttaWFLeHI4WGVLQXFtUnYySzZPUjRqYzRuUTB2SGpqVTBhaW5Sb29RUWV5?=
 =?utf-8?B?ak5qZVgxTWNWaHhFZWQyL0I1bE9CWDJTSklEUlBqNG8wUzBRTDdtZWRkbnNG?=
 =?utf-8?B?Z05UTjNaKzM4SVNyYjdiRDNuSE5TK1pWa1FrT0hjWDByR200R2poSzVQUUFz?=
 =?utf-8?B?aHB5UWZhc2ZnaytjL1FZY1lOeU1MeWtiSXJncDlLVUkreEFCN3lQVWc2V1lS?=
 =?utf-8?B?bHRyckFHYkEyaE9NaUVCWUkzMFp5OXlKVnJseUswaXk3dGFwbXFadmVqaFc2?=
 =?utf-8?B?R2dSSGFxK0YxTFU0QVM1UEVvVUh0a2hkaFgzUGM5YTBlb1gxSVdJNDJTWnYx?=
 =?utf-8?B?cU1XaUhZVmljN05lakRWdjlYWS9ycGwrclFDVTQzWS95TS9zc2FBaWFwT2hy?=
 =?utf-8?B?clF6ZlZJVnFFWldJeXcwYllWVGJrNG9ZZ3p0Y1lVZkZZbmZ3Mzd3RXZsOEdI?=
 =?utf-8?B?b29RazdRU09LeldBdEwzbEVOV3FNdU1NZjB1NVBwajN4TjBxc3JUYWkwYk94?=
 =?utf-8?B?RnkzQ0IyMG5WZkI3WHl5N2tvd3Z5dWZ6Sm4wRExhYnAvTXhFWE0vaDQrZ1FF?=
 =?utf-8?B?SGk4dHB5eEJRK1dkdkxxbU1KRUhzRGlra2RiWnYvUVhIb0pBUGxnYUdoTENh?=
 =?utf-8?B?ZkcvVWovY3JDMVRYV0xpb0YxTVNIRit4MENuWmFCMHdoVTNaVzlGTFF1cVpW?=
 =?utf-8?B?MW02ekFYZmh4d2xnRDErc1AxdDQ3MWRWbDNmRTMyZTB0a1M2c0hCeFBadEdT?=
 =?utf-8?B?dWNFV0RNTkVvZTZaekd5QmdsT2k0ckFxYndwd2Z6cEZrWkk0akh3a1B2b1lt?=
 =?utf-8?B?WlVubTRlUENzVW5COFVFV2l3TFVHTU1lUmFqSGM0NlhkaUppZ1NScnVxdCt1?=
 =?utf-8?B?bTlnY2pUUC80ZWdvRFpXVWlScG5ESGhNKzludTlFMUlrcjRPSThxb05xZ3Rw?=
 =?utf-8?B?SWpvY0Y1UTJpUUxMNEQrUTRIdjZqNm9hUm9wWGJJZWJVZTRVaEJjZUIzNTVQ?=
 =?utf-8?B?V3FSNTVhU3RLT3B3RW5sT2JrVE51U0hPN2xuR1V1Mnp1QXl0WTVuNTFEeEVB?=
 =?utf-8?B?K1lEZERBakZOWjRzSitVUmFaSnY4NFpTZ0VLbmlvWlhld0t6blpmNWp6Z2J2?=
 =?utf-8?B?NHU5SFZBVllBR2pTOWlQcFN4d3NPZk1NVkNRYTVzUmZqYkgrNCtxNXVIM0tB?=
 =?utf-8?B?RkxycmVRaXd4WGx3OG1jeithUVdMKytwWlNNQWFsOU1KaGN5V0VjTFc1Vng0?=
 =?utf-8?B?aGNtUHJycnhWYmR1S0IzNUpteXM4dURVejdzdlBzaG1WWFJKaDJqRWVDR2pa?=
 =?utf-8?B?U3FqMnFhOHNyUDFQYmVBZE1RTG55NlhEbW92R0NteFpxcjJPYUhCWUMrN08y?=
 =?utf-8?B?czNqRHI2bWRxMW5ZV0kwVnBoRGVDSmpaNEF0V2xRVS9lVnJ1Z1dKeWZYMzVW?=
 =?utf-8?B?dGU2VTZxL2JDSXk2aXBNT004eEZZYjhoN09CUHkrYTlPeXp4OGlhT2V3RjJ2?=
 =?utf-8?B?eHFycjlaZ3NwMkhYN2NoOFRhbndOMndmZWtKejBqbjJieW9vUlF6ZDBQZVA5?=
 =?utf-8?B?T2s0YXhBUnNpMk9pelVOUHhyZFljK1I2anNSY01OSHpidUprdGtqdktPRFhG?=
 =?utf-8?B?M0ZMT3Z4NkwrY0J4UUZVWTV5eDVha1lpeFJlR2R0R2ZBTkZrTDkzQmJBRDdI?=
 =?utf-8?B?MjMvWXN6ZUNKSlgxZDRZUnFoQ3FYSVJ5MUNQTFRTWU1TazNmWis1aXNZNm45?=
 =?utf-8?B?STF3ZHlyM2NZOHJBYkp5YmRTdzVXMnBKRTB6ZXJuc3R5YnNnY3NoeUJ3d05x?=
 =?utf-8?B?R1hIeHhMeDJHRHIrYVFaRCtDREZhUGxLLzRadFMvSkcvanZ2cmNmZy9zSDBJ?=
 =?utf-8?B?Yys1dC9HRnlGUnUwZHFBb1BSS1FaQmJKbnBmQzlHMUtXSGZ1bVh0eE9ZU1BS?=
 =?utf-8?B?ZzIyUzBIRVhNOEpndE9hWHcza0ZYcGdLb1FWRURsS0ZQaTdoOTM0NTlGeE5j?=
 =?utf-8?B?ZG9PQ3I0NVJqSWhCYytPMFNCU2U5VUdjdHcwbFNQUFR0RVRaK3pud1JLTFZa?=
 =?utf-8?B?dXQwYkdPdE1hZDVIQ3FkSzZKd0NORHFxVnBnR3FZeGpWNDk4SEFhSDBpK2FU?=
 =?utf-8?Q?HzwNphTTMMroyUjncY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe494ba-4e86-4488-b628-08de93f60732
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 16:03:22.4933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6VzqcRaemUaIW3jjlg08M+YY64ehMH6o2XhBtgFW9P9DrzLG/+48DMtkng4fJ2po9JlO4bncYU4P0iUDcchAPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF48E601ED5
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIdW5nLCBBbGV4IDxBbGV4
Lkh1bmdAYW1kLmNvbT4NCj4gU2VudDogTW9uZGF5LCBBcHJpbCA2LCAyMDI2IDk6MTUgUE0NCj4g
VG86IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47
DQo+IFBpbGxhaSwgQXVyYWJpbmRvIDxBdXJhYmluZG8uUGlsbGFpQGFtZC5jb20+DQo+IENjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgV2VudGxhbmQsIEhhcnJ5IDxIYXJyeS5XZW50
bGFuZEBhbWQuY29tPjsNCj4gTGluLCBXYXluZSA8V2F5bmUuTGluQGFtZC5jb20+OyBMaSwgUm9t
YW4gPFJvbWFuLkxpQGFtZC5jb20+OyBDaHVuZywNCj4gQ2hpYUhzdWFuIChUb20pIDxDaGlhSHN1
YW4uQ2h1bmdAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZC9kaXNwbGF5
OiBGaXggZG9fbWNjcyBoYW5kbGluZyAoTUNDUy9EREMpIGluDQo+IGFtZGdwdV9kbV91cGRhdGVf
ZnJlZXN5bmNfY2Fwcw0KPg0KPg0KPiBPbiA0LzQvMjYgMjA6MzEsIFNyaW5pdmFzYW4gU2hhbm11
Z2FtIHdyb3RlOg0KPiA+IEZpeCBkb19tY2NzIHBhcmFtZXRlciB1c2FnZSBpbiBhbWRncHVfZG1f
dXBkYXRlX2ZyZWVzeW5jX2NhcHMuDQo+ID4NCj4gPiBUaGlzIGZ1bmN0aW9uIGNoZWNrcyBGcmVl
U3luYyBzdXBwb3J0IGZyb20gdGhlIGRpc3BsYXkgYW5kIHVwZGF0ZXMNCj4gPiBkcml2ZXIgc3Rh
dGUuICBNQ0NTIChNb25pdG9yIENvbnRyb2wgQ29tbWFuZCBTZXQpIG92ZXIgRERDIChEaXNwbGF5
DQo+ID4gRGF0YQ0KPiA+IENoYW5uZWwpIGlzIHVzZWQgZm9yIGNvbW11bmljYXRpb24gYmV0d2Vl
biBHUFUgYW5kIG1vbml0b3IuDQo+DQo+IFRoaXMgY2hhbmdlcyBjb21tZW50cyBidXQgdGhlIHRp
dGxlIGFuZCB0aGUgY29tbWl0IGRlc2NyaXB0aW9ucyBzb3VuZCBsaWtlDQo+IGNoYW5naW5nIHRo
ZSBjb2RlLiBDYW4geW91IGNsYXJpZnkgdGhlbT8NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0K
DQpUaGUgY2hhbmdlIG9ubHkgYWRkcyBhIG1pc3NpbmcgZGVzY3JpcHRpb24gZm9yIHRoZSBkb19t
Y2NzIHBhcmFtZXRlciBpbg0KdGhlIGZ1bmN0aW9uIGtkb2MuIFRoZXJlIGlzIG5vIGZ1bmN0aW9u
YWwgaW1wYWN0Lg0KDQpJ4oCZbGwgcmV3b3JkIHRoZSB0aXRsZSBhbmQgY29tbWl0IG1lc3NhZ2Ug
dG8gYXZvaWQgY29uZnVzaW9uLg0KDQpCZXN0IHJlZ2FyZHMsDQpTcmluaQ0KDQoNCg==
