Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39612CD6E49
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 23:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC55D1125E4;
	Fri, 29 May 2026 23:15:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a9XFyrV6";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010014.outbound.protection.outlook.com
 [40.93.198.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36E541125E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 23:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWF7fuBMsMXy0ssLu3X6kePSK7x96qO0dArPNjKegIODnRH7C8XYTPEJdRq8Cz27y19eKrC740BAumwC0IDOyu5mfpWe9xoo9mMqVxDfaxs/7qhAp029q8mKmvxxBnHJQfG5My5iYTGmqjA0bp04D90tcUXOzToIazaCzFJWyfI/HRG/6mhyVmfE7eih+Qc0Xa4+aqJUO86xrD8EznnlPUkooYEUlNfUgokmqemWOySo/xIrQnRfZLFnkpFbHkV1i0hO472UeMQOmcmF74AezO4+yMByqZtWxS9SkEb/dDRE9aoT6iUL+lCu9zfQUVykNtVU3vAB6xjzgfIZ7YKxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1atJO6RTfhFJ7tM8vAzf/uwpSJrdVLvYzmIj6wmyhM=;
 b=me/3ecnwsuC7mtTVLqHapEWzvpRN3vtagVlhVT6BA+LghiLbW6KOLDu6kcfgiYqDgMihhnO3YXxVZK5sbL54X0AnLT5E/XRWH76LoBejPIoKOhgGBNLsw3tpKACw8ireC3dmWiiOP4r4q5xAZJDT/zOHCKK2pTPkyzIjWwj8UGpjAC+hg9IH4R98wDoWi+vT2Ra3ydqxblcNioZ5+mem0DQo+yOW+ZSIKsBl4leuw1kpwWG/BX6vl3v1IEcF2RdoV7Dgs7+padQUyjyvBIiULSJf75gy970un+csDwNSfu4+Fke9sobruKHBglfGd1zrHDo01VeQlo8e52BAexSlSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1atJO6RTfhFJ7tM8vAzf/uwpSJrdVLvYzmIj6wmyhM=;
 b=a9XFyrV6M0cxePI+LzRl/SzV026Gm9yS4fWehZO+bkUN/rCPoRu50qilxop5XHyfX4rpa1q0iKXFCRGvPbip5Mul427ZhNJFJOhTg6G1Goo/34hhiWqT09CafYNQMNZUui6SXf8nnrkqVppvUr3EiCUwb2LzwvMt/LmpGSkCxPM=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 23:15:25 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::4c39:c452:1296:e09b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::4c39:c452:1296:e09b%5]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 23:15:25 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/gfx: move fault and EOP IRQ get/put to
 hw_init/hw_fini
Thread-Topic: [PATCH 2/2] drm/amdgpu/gfx: move fault and EOP IRQ get/put to
 hw_init/hw_fini
Thread-Index: AQHc7jGgjUdxwZGDhkq7rQ+Sc4D8nrYkC8SAgADpiGA=
Date: Fri, 29 May 2026 23:15:25 +0000
Message-ID: <SA1PR12MB85997618DC44E4FB68187865ED162@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20260527233504.1830940-1-Yunxiang.Li@amd.com>
 <20260527233504.1830940-3-Yunxiang.Li@amd.com>
 <CADnq5_N9tz-NR0o3WCod+=7j+oqZsMjX4RT6P__Cu-2DSLuy6g@mail.gmail.com>
In-Reply-To: <CADnq5_N9tz-NR0o3WCod+=7j+oqZsMjX4RT6P__Cu-2DSLuy6g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T12:44:09.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|DS0PR12MB7747:EE_
x-ms-office365-filtering-correlation-id: 11ce6766-0f9a-4485-4c67-08debdd82a62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|38070700021|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: DsvLhxINet4J+Y123bkmUf2QdpyEJAqeOAFETWMXeewXWRB7U4HKNdXZ4NFSjEsD3OWzdDkYdK8evy1unZFCyn1qhuG4bbTvLFbSg7S6YAEVDjqsrt68TcdyveMkNUHzntSfHWO2Ke90DJh9gJgz+wgyyo5uyNtXKOOQR7pT2mWxa3v3jMRbYfzK+C+cFLvoneK3N5yoWqjw0T5xOYe34u7dvSSx9Ui6gdmlcdtuGpcFiXF/6suc+saBzftr6sBPvQeHGLsjF3pU42mOW41rOPBz9Xgo49LIYsPeVk79Elk0quWRElrBnwexNTljgw56n3iasjX34vk/8wWOjNUUoxGs8Xs9l4MGF42lpGGvGUuEyP+pFCIpUUT2CvdPtXGEMXR7VkuZZg8tUYcco92J6kzYQ4JD2LeYYlVNqyFZkNnXFn6zd97PjITwjRDDye6n9kmvndBQpFaHjnq99RwS+1/KK1e1/pCDuxB/pB1x5/IokvBw0N8zR1fytoauF1KCoghANioQ6F9dLxkHsETMBPb6438iL57BY/AAdkqqk9GiDk1PoqBrV/Xd7NTqtyIlHkA1MyjGbfmJ/rDGms9qmThxpRTS2B+QZ+H14DoU4sFnDszWCj87UaBz1QEoBkY2lRNImbRCjn+JArN0s63y0gcFMVNrNL7zfOfDz4WAdCNRR73q2KqmS7SwG0iTr40eEIV3DSG8qqrLiPGEwjLL9FUc+iBvPaN2PlPMNUpaRQbq2Q5CisCc/KeEmObIcGbk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTZvdG1nMjN1eWkrK3p0L3cydW5DK3VTVDlrVktSWUhWVmdWM0FRZXFoU3Rk?=
 =?utf-8?B?eVNHUC9JS3dXQ29LaXdBMEV5Ujh3ZC94Q0d3U1JuK1hkNC9lWDhudTZweUVV?=
 =?utf-8?B?YWtZbnBCTmV1eTNMWUt2STBDYWJJNEVaeGtSbHdwSUV2dXEvWDNpd3c1YWpZ?=
 =?utf-8?B?MlZIYkFNYlJHZnNMUndsQWdDbERJSXltTythRVFQZ1dYTkZ3ZHB5VVZ0Tm9x?=
 =?utf-8?B?Y29JREVTdWNYNllKOVp1UFE5UU50K3IxQmY2RVhxbWg3VDdoeXl1ZEl1bUVM?=
 =?utf-8?B?MTRGdC96cHVDMVVtZk40Si85SmN1VFF2bFFpdlIrY2dXRDlOZ3dZeXkxVkI5?=
 =?utf-8?B?aDlENjdrdzBNa1FaaVFMYWNIaHBkdnFreXg0UHVLcUtYdW5saTVQRUpscUJs?=
 =?utf-8?B?MStNbS9aL1JNZ3k2Nm0zOTYrWVFRTjhqSGh1ckdRdG5OK0xGYkNXU3VVbFBl?=
 =?utf-8?B?N1Zwdmw1U2N0MFZkR0hqbm1vZFBCcHc5TDN3M1ZwdzdJczBJL1p4c1I1RU1Y?=
 =?utf-8?B?N3JnbERqRmtPWVdvSll1b0ZsNVowcURxSXZHSG9DMHhEaVhrUEJpcERhWXdq?=
 =?utf-8?B?cnJkSHloLzVNVmowUk9waVFrWGMzVXdFZStZbXZzazcxWkM4aTdsMncyVm41?=
 =?utf-8?B?Y2JJWWVONlRMRkh2SmNna3l3elVzZ3Y3UWN1U2swaEZ4a1IrNHZ2WnJqTlhF?=
 =?utf-8?B?dXZtMUdiRlI1MGR6b2pSRjV1MS9CV0hqL3BTblhYQnhVaVlVTkM1Z3FGQUtT?=
 =?utf-8?B?cXIzY3ZHWUFSa3hSUWw0bTdLcytuR3RETm1Ea3QvdnR6NWFvSUlMY3Y4SSs3?=
 =?utf-8?B?emJ4dkJFQUhzSzV0akl2UGhNNnlBeUtkVnpId2tLVzQ5d1U4RjdaaGlnc0JP?=
 =?utf-8?B?TEZWLzZuUkY3MU5nYmNKNVRVYXVoaDRMVFBwY2VMaVR3SFE2bXhYNTFUUU42?=
 =?utf-8?B?L0tSa1NOcFZQaDFoaXBiWi8vSVU4WFBoRzJPM0ZSYmVDRTk3YjNrbFZnS1c1?=
 =?utf-8?B?cUZiSzRtUTRQcnU3V042QjBha295Y2oxeVV0MGVuS2FOMzVCZFRGUEhqdmtw?=
 =?utf-8?B?SXllcTNyTGVsRktlMzhhSlBsMmJUY0FDNVpvenNjb09HaXU3WGsyUW91ajRl?=
 =?utf-8?B?ZFpkWUFMaDNPT1lYM2F2RFlHc2dZbms3M0NZZVNvbWZlVkNEL3FUWlpnbllt?=
 =?utf-8?B?U1BSVnRQSTlTWCtBaVIvOWpDamxpd1FQcEF3SDR1THdkWXQ5RS9ZTzhURloz?=
 =?utf-8?B?NFJoQ0dFc05RdXJTc3ZHc003Tk1nK295cmYyL3dvdGs2VHFHR3RRUU9sRnRh?=
 =?utf-8?B?RmUzVkxob05jeEJXc2IzM0xORzNOUmV5ZjIxdFRITGlDd1JWMzNra3J1WUtY?=
 =?utf-8?B?U280ZXQ5dFNQN25xUE5xME1BLzdBTUNaM1EyajhnUm9kVGNrdXBITXJEd2ln?=
 =?utf-8?B?N2ZjOFA3SmxsNUpKYzc0RVRaSURXZ1hVMWpUT1FEbG5lSjEzQmNqTSs2Z0V2?=
 =?utf-8?B?NTR6SmtWUFdmS283UUt2RmhEOUNSekVJNGdTd0tESmdKY1I4T0pGdzA0bzIx?=
 =?utf-8?B?KzQvSW5BT2Q3VFRMQnNhZkhVTXBZcmZEcUJEcUF1RjNTSll0Z0VjWDVUMFR1?=
 =?utf-8?B?WHhWOGU1UGpqUE4wZ2dRWUZaNFhJNGxYa2hSTmRoK3NLa0hzSDAvbDU3SE56?=
 =?utf-8?B?TzNrWlBkZFlPTDdSTG1zWnhlZ0t1Y0d1aHB2RkNaT0hENXpqaVFJZHA5czZM?=
 =?utf-8?B?MDdudGZySkRLeU5nYVpMRFhDcGp4alFGMjBXN3pWUzd3SE1TcHV4dWErWlVx?=
 =?utf-8?B?RWRYVFg2VG1DK2twaGNDWW42ZzQrREJLU0Nnckh1YXNOY3F6UGdJWTdhRTZZ?=
 =?utf-8?B?bG9PZmdVcjl0QzZSakZFMVA4cDZCYldDNHZTN1BlamZRb2lkRFI4RlBHQStN?=
 =?utf-8?B?d1FWWXBteWc5UWxndEZwOUZMaERsdTQ1ODF1b1lpQ2FUdkFBSFplQy9TclZH?=
 =?utf-8?B?VVZLTUZjWlEyVGUrRlBId3ZDWDlydzBndG9mMnlLK0NmOFZ3dTFPSzJ2Y3lh?=
 =?utf-8?B?UU5sN3g1MisrZWFHdDFCaDFmUHdCNUdIOXRCV1JJODB5Unh0SldwWi90b05z?=
 =?utf-8?B?Vnl0Y3VmQjRTcXMybk4ya3R4cjNvTlpDWis1VnNuZzlza00rQjExSytsNHZz?=
 =?utf-8?B?R29lMkpCd0RtSHdVYmcvWFlHZkw0ZGVsMmVjdk11R2psNkk2RzRZKzBycHRs?=
 =?utf-8?B?UE44YjlVOW1kOE1rV3NqbmJDeUlBWkM0b1NEQlFXeW03Sk5WQ3lpazl2M1dp?=
 =?utf-8?Q?/4KFZHgUrAhG59KYok?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ce6766-0f9a-4485-4c67-08debdd82a62
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 23:15:25.3634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJECNE3hxWCSU2IliArc2YFAIwyA7lbTSFbkhWdZvc5gjM0DcJQxQd+1Uh+05/M8LjX5AP+Yx8Ul5M2ZuCjYvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7747
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

QU1EIEdlbmVyYWwNCg0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNv
bT4NCj4NCj4gV2Fzbid0IHRoZXJlIGEgcmVhc29uIChzZXF1ZW5jaW5nIG1heWJlPykgdGhlc2Ug
d2VyZSBpbiBsYXRlX2luaXQoKT8NCj4gQXJlIHlvdSBzdXJlIGl0J3Mgb2sgdG8gbW92ZSB0aGVt
IGludG8gaHdfaW5pdCgpPw0KDQpOb3QgYXMgZmFyIGFzIEkgY291bGQgdGVsbCwgZnJvbSB0aGUg
Y29kZSBhbGwgdGhlIGRlcGVuZGVuY2llcyBhcmUgc2F0aXNmaWVkIGluIGh3X2luaXQgYnkgdGhl
IElQIGJsb2NrIG9yZGVyLCBpdCB3YXMganVzdCBwdXQgaW4gbGF0ZV9pbml0IHNpbmNlIHRoZSBi
ZWdpbm5pbmcgb2YgdGltZS4gSSBkaWQgdGVzdCB0aGlzIGNoYW5nZSBvbiBnZng5IGFzIHdlbGwu
DQoNClRoZSBzYW1lIHBhdHRlcm4gb2YgbGF0ZV9pbml0IGdldCBod19maW5pIHB1dCBzZWVtcyB0
byBiZSB1c2VkIGZvciBvdGhlciBJUHMgYXMgd2VsbCB0aG91Z2gsIHNvIGl0IGNvdWxkIGJlIHRo
YXQgc29tZSBoYXJkd2FyZSByZWxhdGVkIHJlYXNvbiBleGlzdHMgYXQgc29tZSBwb2ludC4NCg0K
VGVkZHkNCg==
