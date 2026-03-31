Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE0D1061B2B
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 02:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFCFD10E167;
	Tue, 31 Mar 2026 02:41:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lzInxQJE";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA36A10E167
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 02:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPwmw7RE6mrWHMIqb5xiDEslpGB56DiJjHx1jAJNAhl127tCjSzRtPrQ+5PaYQk/ETiJIx8rPsV0fgXgOBa+qf+sIE/izcK8WLux2QMis7TKpHsu5oHOYr6Yy5HOTeLLhSwqclbak1Qln+1JJ19XmallLjulNq/sHnf0gICijqyNtzcLUGz7m7AKzTZiIsnsc/uzssu1aYbAvvVyltP+zw7quwtPyKIcQot7XD5qtdrHGI5JnI3AFgLkp8gxFAcaDVaqD+q1/1BiYkq7bq4FwhWCLqWMPYjHHZAwTSU/ksvEmGIr4NlXR+H+3Tv8ktzKc5xih/9gqhmlNIxKc3mysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEA/wcDhvVQ1f1Hf2rTGE0YFbkEw03FCJ4v/nygC7XI=;
 b=EHqLeVdEe1yEY8PN5BpZ/LONScwCrsWax1n4O95Xts4ePIjEXEmiuY4c2Yh/xggPXrDSOO2wyeo4/8P7LJgFzPxAOvdFlCM1Fp2s3JxnX7RZ7qI3+qEZuclO0uo45hA42n9AC7KttB8/kmAskWrrvU77fEbMSGZ2PubhZFFNXMXlY2UvsVAMhSrHszmYEhBfNwEq41feiYPMydp7uDebJjdUYVYa0kUU/e1QTjas3anGG49SiImSM0hyl0yj1/aAkMmRojYKhGVTIKMDtViCzlsxKtfGz5Dj71kK/wM4S9SjhsWXTCyXMBRJMX10Fe2CnxMG/HsMxUvOCr0NJoHO2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEA/wcDhvVQ1f1Hf2rTGE0YFbkEw03FCJ4v/nygC7XI=;
 b=lzInxQJEN96Ph/wzKh1uuDHT26z8h9KnUx/Cn4AJ/97v6aIkVdPM+AU4H5c66yggCsWK4VAQNY9woAlGH4UZ5poHfPOYbyVWSo1oZ3xQNdKyRzeoH/lEiCB7YcvKAjZ2lEnKGo0JK4UVz47HIjA1e7Y0nPQi56b0zfeRc20r/q0=
Received: from DS7SPRMB0018.namprd12.prod.outlook.com (2603:10b6:8:78::7) by
 IA1PR12MB8465.namprd12.prod.outlook.com (2603:10b6:208:457::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Tue, 31 Mar 2026 02:41:38 +0000
Received: from DS7SPRMB0018.namprd12.prod.outlook.com
 ([fe80::3603:32e4:68b8:639b]) by DS7SPRMB0018.namprd12.prod.outlook.com
 ([fe80::3603:32e4:68b8:639b%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 02:41:38 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: make userq fence_drv drop explicit in
 queue destroy
Thread-Topic: [PATCH 2/2] drm/amdgpu: make userq fence_drv drop explicit in
 queue destroy
Thread-Index: AQHcvdYUb+GkM+JsWki87YxWafFgkLXHI08AgADQHtA=
Date: Tue, 31 Mar 2026 02:41:38 +0000
Message-ID: <DS7SPRMB001884DDAA00694B054D0B4DFB53A@DS7SPRMB0018.namprd12.prod.outlook.com>
References: <20260327103621.3374979-1-Prike.Liang@amd.com>
 <20260327103621.3374979-2-Prike.Liang@amd.com>
 <3cac3a26-e947-493c-ae33-0adf6032fdba@amd.com>
In-Reply-To: <3cac3a26-e947-493c-ae33-0adf6032fdba@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-31T02:39:14.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7SPRMB0018:EE_|IA1PR12MB8465:EE_
x-ms-office365-filtering-correlation-id: ba6fa645-9b69-42a0-1306-08de8ecf085a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: hfxYB/L6M+mnQkt3t0S0GKc5cV9kLMlB7WbQJF6nOtt6LsuI2HHsdmcqOYcqTdAeCLwYA8Q4053bz+MYNFtgwHoAbkQ59TsckfdYFWxUVlbhu7OWgpixKbCvTfliz9Wqhjs6wNgU5QhS+El+A9i6DMF2U8ka4oh8JeGXVdPoJTpam/VidGqj/JshSZZTemhFdZ4Yx05v5LJ34fyXCJw0brLozKLP8BpIx4qrcyy3exYd867jLfgdB7NFrAXeyu52WhlHUSmuSjSyZx1QgG8Vex/y0M7uzzoAmrazZdaTCucGWHlZv6tfuxHnx+0LMEyxypXYg9XZC2gCELtqAaKV1kX0/GgqGGYJPc4leqJM5wb1u+t4F0G8fCSTDalU4uTYOaPKTsIhoutTLq6QzH2XuavJ9WLbys/+E3mHXBzbOo2HebMVNas9qPCVFZLnfFkh+EewgOjhT9zCoKsekfHYI2fgaXrghqnnIhJde8taVUY4ccLxYmHIusIs7cVfYfkyLVpk2OOROj0K5fS3xPxw3SELTArdLXi0FLRd1o7dCkNaurO2N/TI2Sb6u+I0MZf17F69Tj2NequmRsp27EMEFqxj4VsoAmD99Fd3ETFns7lUwTA5HQIChtluffYLazl5q1wjwL3zZdz9RBacLCZJ3eulZG+GqiVve96Wf/kDSd+lNFpNGY/ytDoeegjSiqHE8WWxyJgdM1RqY3m5hE6PuFEWz2rz9u7ZwZf5JhiL2pJ/PqSa+DAWIE9JPH4kPf/7l57ky8xjyZ2VQqcuBrCKBXaFZBWgd4o6hillnq4uwgI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7SPRMB0018.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFlUOCtoUVBObEtFZ0o0aUxVMmlISThwckthTEpwQ2h3NnRMTENNdFFwcUtB?=
 =?utf-8?B?cDB6alVnZ1E0WVJma1U5eWd6WFhlNkRBNmQ3SndEemVpRmpkeFpmTmQzSjly?=
 =?utf-8?B?bFNZWnhZVnBJVXp4N1NDZ1NwdVpSRnB3RXV6cFY0Zk85bFNkWUFqOTk5SllX?=
 =?utf-8?B?MjgrbkttaVR6RzRBbERsWkZEWmFidWh4L3JabWJTTDBGdDhTQzBkc2t3TGIz?=
 =?utf-8?B?L3MyZ0lIaGVDZ3VXWTBLRzc3L1Q4UU1jcjIvOFk2elRKV0htKzhDWWxiTlBh?=
 =?utf-8?B?QkVoaEl6cCtEanRNZmRDQmNxeGhWZHVWNUxUMlJFUmtvSzhZOUF4TUZOMWx2?=
 =?utf-8?B?anJLbUhqNDRramliYUJPZFVpcUZ6TW52Lys2dlZzTmFRaUtXUDVoMlhPL1lq?=
 =?utf-8?B?VEFTTUlsdXdUdlg2b3pvZ2RMS1J6cWpucU55WFNXcW80ZGJVMGpuSDBwQ2xG?=
 =?utf-8?B?Y1cveUhjSXBJREZDZGpXeHozUGdqT3o5a3RXVllSZUI3Zmk1MEpSN2tHaGV2?=
 =?utf-8?B?RXhCNEFzOVRmS0ZMdDBKL0JuTVZTRG94R0RQWGl3RG1iVFh0VEFxZkxqdTI5?=
 =?utf-8?B?V3k4NzZmVlZ2WlhNT29kNk43aW9nNnhXakxYcUd5TlNpVXdQL3hJdzg1MzY1?=
 =?utf-8?B?WGcyYkVBcEVzLzhBb1JnNnpXdzdWYzJTV0pacVlvRXBTQjNNcDBYT2VuTW1S?=
 =?utf-8?B?TU0yMGpTY3RPMGZrc05FWmlTc0lzalJrT0pFOVcybnVML1NCc0VxcFFiUHhW?=
 =?utf-8?B?N1pYVHViNCtWR3E0Q0NQdzltaHFNNWY1anh2SXk4Y3ZMZGZTNHlpUTV0aDNh?=
 =?utf-8?B?QzZyRE1aYmh3VkhmR3FrSllZYWx2N2I2RWFzZTMydUN0MWhnQ2c1UGRZZWx1?=
 =?utf-8?B?Y3VhZFIzMEZsRVllek9UTldINGZJVkFpSWpNMFdXR25HQVRpUkQ0VFZmdGY0?=
 =?utf-8?B?UVhHSEFCTW94UjhicFBRSEhyMGNPMXVFK3gyWmdpOUhNZkVETTlETkpZbFdI?=
 =?utf-8?B?YTNxdXRwNW1VMXAwTW95ODZHdU00cEw1Tk9DRUZzR3BnU2pPMjZPcnJ0Sm5w?=
 =?utf-8?B?VmVGY1diL2ZRbkcyMGdKZGF2KzRyUGx5Y2N1elB3NklXZUI3Ukc0ekpaMTlP?=
 =?utf-8?B?cnJBVkcxWHNuT21UZ2cwaTNoNlkySXN0S0h3VmtFRHB1NldnOHk5OUV4NGdF?=
 =?utf-8?B?UVlEMmxDUkJVZmI4VzNQRGY4OXlWUzE4cW91bnNEUWNXZjdnVnBNWkZybXA2?=
 =?utf-8?B?QkhJZkhtcnB0amhKTWMzSkF3bXVjQVRQc3cwZzVlUEFNU1AwbXgxMld5bE9Z?=
 =?utf-8?B?MGgzaTJBdGxTWFhlQktzdFRjMnFpM3hPNk9OaWF5ZlhGRFFod2lWc2g5Rm5h?=
 =?utf-8?B?UjJuU0pxclYvbGVJZit1U2VhR1JvdnBjU0lFUkZnRiswMUUvcGdsU1ZmSjFV?=
 =?utf-8?B?M0dGc0FGakhHdDYydVBRZURaZEpYUzJwazhyOWswTzJBK2o2b0FLaGVCVytS?=
 =?utf-8?B?bW5lRTRZWktBRXFOeTBvL3JRMFpCcUJBVThLRTN3WEV0NE1pMFlBVDFEMEFG?=
 =?utf-8?B?VGVpcUpXbHhSOFA3V0pIV2tpZnRSVytuR3NuTUFwL1F3OEk0T3oyRDI1SXdr?=
 =?utf-8?B?UzVWS01IbEp3eGdleUJ1RHhHdEEweTNFaFByRFBzRWNFTENSTDN1cnQzRFMw?=
 =?utf-8?B?bCtIbHZ6OG5jWGEwNi81VTc5cWVKYUtaUDdHTk4vcHgxSUNDR0FjQ3pCZzgw?=
 =?utf-8?B?YUhqSHgyV0x5dEVYanNKZGdvQnlrd20yRmtMYlJuMlhKeXhaYWh5akgyUHJD?=
 =?utf-8?B?a0JnTmdMSWdCcXE4OVBia2NIWER4MlJINFN0Qk11eXR3bnV6Mm1WcVRpRHNp?=
 =?utf-8?B?Z0NsRGhYT3lZL1h5NkJmVzd3OXVwdy9VVVRGL2VGTENEZ0xKRkY4N0ZJSzVl?=
 =?utf-8?B?aS9DN3ovd3NRd0hsVmRhc1p3d0E1eUhmWkxlMGptNkNTM3NpZ0REbzY2dWVt?=
 =?utf-8?B?b3hucnp4YVY3SDZIbE0vLzdhbVhiUVJza2l0Z0FIaXBEOXRoUHIydnUwekFu?=
 =?utf-8?B?OFZncUVNeHJybmpHSldOS05sTUk2YlZQQ01NMnNMVmFPZ2RqMkU3MmFoejlB?=
 =?utf-8?B?bEZmYmQxbjRwckkvWDlXY1VhTjdCQ05HM2VLVkgveDEwaVpGcGFmVmRTL29L?=
 =?utf-8?B?YlNrb3JzQ1ZpdVFIRGg5c3pVWkhpVVM3SlVKRFl2aVVodVpNWGlEVWV2Ukd4?=
 =?utf-8?B?ZGd5cmxydGo3K3MyTFV6QkRiVjlMWWRMV3ZsVEx5MUpmNURiQS9HWVdCdi9Z?=
 =?utf-8?Q?omAXKHTlTucPYB+T+Z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7SPRMB0018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6fa645-9b69-42a0-1306-08de8ecf085a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 02:41:38.2097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yEAHx2e8hq6rKvmnyea9WnbQ/klF4td8rvmbznOmRAqxSoUXfpwHw76/yjrt5VY/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8465
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAzMCwgMjAyNiAxMDoxNCBQTQ0KPiBUbzogTGlh
bmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6IG1ha2UgdXNlcnEgZmVu
Y2VfZHJ2IGRyb3AgZXhwbGljaXQgaW4gcXVldWUNCj4gZGVzdHJveQ0KPg0KPg0KPg0KPiBPbiAz
LzI3LzI2IDExOjM2LCBQcmlrZSBMaWFuZyB3cm90ZToNCj4gPiBhbWRncHVfdXNlcnFfZmVuY2Vf
ZHJpdmVyX2ZyZWUoKSBpcyBub3cgcmVzcG9uc2libGUgb25seSBmb3IgcmVsZWFzaW5nDQo+ID4g
cGVyLXF1ZXVlIGFuY2lsbGFyeSBzdGF0ZSAobGFzdF9mZW5jZSwgZmVuY2VfZHJ2X3hhKSBhbmQg
bm8gbG9uZ2VyDQo+ID4gdG91Y2hlcyB0aGUgb3duZXJzaGlwIHJlZmVyZW5jZSwgbWFraW5nIGVh
Y2ggZnVuY3Rpb24ncyBjb250cmFjdCBjbGVhci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBy
aWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYyAgICAgICB8IDUgKysrKysNCj4gPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMgfCAzIC0tLQ0KPiA+
ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEu
Yw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiBp
bmRleCBjNDg0MWRmODBiZjguLmQ2NzZmMjcwOWEwYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gQEAgLTQ1OSw2ICs0NTksOSBAQCBz
dGF0aWMgdm9pZCBhbWRncHVfdXNlcnFfY2xlYW51cChzdHJ1Y3QNCj4gYW1kZ3B1X3VzZXJtb2Rl
X3F1ZXVlICpxdWV1ZSkNCj4gPiAgICAgYW1kZ3B1X3VzZXJxX2J1ZmZlcl92YXNfbGlzdF9jbGVh
bnVwKGFkZXYsIHF1ZXVlKTsNCj4gPiAgICAgdXFfZnVuY3MtPm1xZF9kZXN0cm95KHF1ZXVlKTsN
Cj4gPiAgICAgYW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlcl9mcmVlKHF1ZXVlKTsNCj4gPiArICAg
LyogRHJvcCB0aGUgcXVldWUncyBvd25lcnNoaXAgcmVmZXJlbmNlIHRvIGZlbmNlX2RydiBleHBs
aWNpdGx5ICovDQo+ID4gKyAgIGFtZGdwdV91c2VycV9mZW5jZV9kcml2ZXJfcHV0KHF1ZXVlLT5m
ZW5jZV9kcnYpOw0KPiA+ICsgICBxdWV1ZS0+ZmVuY2VfZHJ2ID0gTlVMTDsNCj4gPiAgICAgLyog
VXNlIGludGVycnVwdC1zYWZlIGxvY2tpbmcgc2luY2UgSVJRIGhhbmRsZXJzIG1heSBhY2Nlc3Mg
dGhlc2UgWEFycmF5cw0KPiAqLw0KPiA+ICAgICB4YV9lcmFzZV9pcnEoJmFkZXYtPnVzZXJxX2Rv
b3JiZWxsX3hhLCBxdWV1ZS0+ZG9vcmJlbGxfaW5kZXgpOw0KPg0KPiBUaGUgeGFfZXJhc2VfaXJx
KCkgY2FsbCBtdXN0IGNvbWUgZmlyc3QgYW5kIHRoZW4gZHJvcHBpbmcgdGhlIGZlbmNlX2RydiBy
ZWZlcmVuY2UuDQo+DQo+ID4gICAgIHF1ZXVlLT51c2VycV9tZ3IgPSBOVUxMOw0KPiA+IEBAIC04
NjYsNiArODY5LDggQEAgYW1kZ3B1X3VzZXJxX2NyZWF0ZShzdHJ1Y3QgZHJtX2ZpbGUgKmZpbHAs
IHVuaW9uDQo+IGRybV9hbWRncHVfdXNlcnEgKmFyZ3MpDQo+ID4gICAgIHVwX3JlYWQoJmFkZXYt
PnJlc2V0X2RvbWFpbi0+c2VtKTsNCj4gPiAgY2xlYW5fZmVuY2VfZHJpdmVyOg0KPiA+ICAgICBh
bWRncHVfdXNlcnFfZmVuY2VfZHJpdmVyX2ZyZWUocXVldWUpOw0KPiA+ICsgICAvKiBQYWlyIHdp
dGgga3JlZl9pbml0IGluIGFtZGdwdV91c2VycV9mZW5jZV9kcml2ZXJfYWxsb2MgKi8NCj4NCj4g
SXQgd291bGQgYmUgbXVjaCBjbGVhbmVyIGlmIHdlIHdvdWxkIG1vZGlmeSBhbWRncHVfdXNlcnFf
ZmVuY2VfZHJpdmVyX2FsbG9jKCkgdG8NCj4gZ2V0IHN0cnVjdCBhbWRncHVfdXNlcnFfZmVuY2Vf
ZHJpdmVyICoqb3V0IGFzIHBhcmFtZXRlciBhbmQgdGhlbiBjYWxsIGl0IGxpa2UgdGhpczoNCj4N
Cj4gcmV0ID0gYW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlcl9hbGxvYyhhZGV2LCAmdXNlcnEtPmZl
bmNlX2Rydik7DQo+DQo+IFRoaXMgd291bGQgbWFrZSBpdCBhYnNvbHV0ZWx5IGNsZWFyIHdoYXQg
aGFwcGVucyBoZXJlIGFuZCB3aHkgd2UgaGF2ZSB0byBkcm9wIHRoZQ0KPiBxdWV1ZS0+ZmVuY2Vf
ZHJ2IHJlZmVyZW5jZSBpbiBjYXNlIG9mIGFuIGVycm9yLg0KPg0KPiA+ICsgICBhbWRncHVfdXNl
cnFfZmVuY2VfZHJpdmVyX3B1dChxdWV1ZS0+ZmVuY2VfZHJ2KTsNCj4gPiAgZnJlZV9xdWV1ZToN
Cj4gPiAgICAga2ZyZWUocXVldWUpOw0KPiA+ICB1bmxvY2s6DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jDQo+ID4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnFfZmVuY2UuYw0KPiA+IGluZGV4IDg3
NTYwYzEyNTFkOC4uYTM5MmVmOWJhNWFhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMNCj4gPiBAQCAtMTM0LDExICsxMzQs
OCBAQCB2b2lkDQo+ID4gIGFtZGdwdV91c2VycV9mZW5jZV9kcml2ZXJfZnJlZShzdHJ1Y3QgYW1k
Z3B1X3VzZXJtb2RlX3F1ZXVlICp1c2VycSkNCj4gPiB7DQo+ID4gICAgIGRtYV9mZW5jZV9wdXQo
dXNlcnEtPmxhc3RfZmVuY2UpOw0KPiA+IC0NCj4gPiAgICAgYW1kZ3B1X3VzZXJxX3dhbGtfYW5k
X2Ryb3BfZmVuY2VfZHJ2KCZ1c2VycS0+ZmVuY2VfZHJ2X3hhKTsNCj4gPiAgICAgeGFfZGVzdHJv
eSgmdXNlcnEtPmZlbmNlX2Rydl94YSk7DQo+ID4gLSAgIC8qIERyb3AgdGhlIGZlbmNlX2RydiBy
ZWZlcmVuY2UgaGVsZCBieSB1c2VyIHF1ZXVlICovDQo+ID4gLSAgIGFtZGdwdV91c2VycV9mZW5j
ZV9kcml2ZXJfcHV0KHVzZXJxLT5mZW5jZV9kcnYpOw0KPg0KPiBJIHdvdWxkIGtlZXAgdGhhdCBp
bnNpZGUgaGVyZSwgaXQgYWxyZWFkeSBsb29rcyBsaWtlIHRoZSByaWdodCBwbGFjZSB0byBoYXZl
IGl0Lg0KPg0KPiBXZSBqdXN0IG5lZWQgdG8gbWFrZSBzdXJlIHRoYXQgYW1kZ3B1X3VzZXJxX2Zl
bmNlX2RyaXZlcl9mcmVlKCkgaXMgY2FsbGVkICphZnRlcioNCj4geGFfZXJhc2VfaXJxKCkuDQpU
aGFua3MgZm9yIHRoZSByZXZpZXcuIEnigJlsbCBmdXJ0aGVyIGNoZWNrIGFuZCBwb3N0IGFuIHVw
ZGF0ZWQgcGF0Y2ggc2VyaWVzIHdpdGggdGhlc2UgY2hhbmdlcy4NCg0KPiBSZWdhcmRzLA0KPiBD
aHJpc3RpYW4uDQo+DQo+ID4gIH0NCj4gPg0KPiA+ICB2b2lkIGFtZGdwdV91c2VycV9mZW5jZV9k
cml2ZXJfcHJvY2VzcyhzdHJ1Y3QNCj4gPiBhbWRncHVfdXNlcnFfZmVuY2VfZHJpdmVyICpmZW5j
ZV9kcnYpDQoNCg==
