Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C54CCD128A
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Apr 2024 08:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40C5910E807;
	Mon,  8 Apr 2024 08:17:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2eIatUdv";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2093.outbound.protection.outlook.com [40.107.92.93])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD4D110EBB8
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Apr 2024 08:17:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUEq8PvXMRPlr3h7/NsZoGsq2yxXsQRxQWIX7kOR547YfqflQjZrjYLogNXeS0xX+/SyhUG2VQ+UnKvL30Ei7ANwlkIwjzoaNuFhDPwgysjODxqQx1qgzSGonn43Tod2FEhk20yBtxfZagJhFujG3xJNM/V5pJzRwmrh7ldA/5X/TjbunFBcUbg7+8xP0RqLcrQu/WuGRd48ONx+gT2C3A0OrKJJwK/1vshWcDGJDaze3WBTLvL8dJdyooJKJK90umpBpsilpS7Z311eGaKL+IZ3zN/4c9xjNwjQL6zJHVCGAvTzoljVwZ8BhDt9vvp/ABE2l9E3VorWygiaZaADog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkIlS9Oh1zwFzQN5k6Ydmdw8VzU6AXZU3II5vjzufW4=;
 b=DuEAU5qruEA4HY3yGumCv/z3P4GqeLdde4+eAOlDUiXfY8hZVR5OT5y6f1IAyItt8ayLKFHr8ZBNXrA3BPWiwZpVWgsJtUbXU0q0dGfNiIx6mi1u48vgMLmP2/ByMfAKXX64b3nuBRpQZSiufrHQBGpdi9QkoQnKpw8EWWyuAGjhscfTMchKsbUCVc31L6zX3PTGssJ2xmByP187U/esUF6FGhIAn47Hil9BS6DjzBwAv6Wh+hJLE+YJaU7DEEeXTqGjxvOfwK9t6dbNhDV+ornR0LN95O+BiRb5pcmfGg/xk2kulKmYukatLwmtCxUJ/l0sXT8vFmMMLjJEtzetyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkIlS9Oh1zwFzQN5k6Ydmdw8VzU6AXZU3II5vjzufW4=;
 b=2eIatUdvBtXQ3+0CG+CqUCgAIjch0xlS8W/zVq7j4ofbW8rlZpwSH8W/ockjVfimOWGRgqX4fjF0ILPtRdqYGK3+1jrwK9zPN6nQAwIxwhZkGTehQpQcMXIrCwbym+adsp22YYrNyQdXwfPMuvs6ese42LBLml7LoKVnVzXTRbQ=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 08:17:51 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::d6a1:3931:bca2:6f07]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::d6a1:3931:bca2:6f07%6]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 08:17:51 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: make sure VM is ready for updating operations
Thread-Topic: [PATCH] drm/amdkfd: make sure VM is ready for updating operations
Thread-Index: AQHaiKd7Zxl97lQhPUulvWg5h+myIrFeAt+AgAAEI9A=
Date: Mon, 8 Apr 2024 08:17:50 +0000
Message-ID: <MW6PR12MB88985E50FB5586A5B518A8E8FB002@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20240407045236.3487634-1-Lang.Yu@amd.com>
 <0bc7bc06-0df8-4b19-b4db-06701c2fa9d1@amd.com>
In-Reply-To: <0bc7bc06-0df8-4b19-b4db-06701c2fa9d1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c8964bec-ba1d-41e4-8e90-2fecd9f5fbe5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-08T08:10:02Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|MW4PR12MB7141:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /1abq82nArejlu3FHilCQhdp6wdPwVRs0XpBmOw+yRq55i6VWItuipWM82kINnCZDqiQOt8bD+wkjMXd+Cvp6ZloAgpJqySVZ/YetS2do5/HluBmApvKSw+QUuKZ7wTpZvzHOU2A2epXznNX6YOX27TLNqNaQ4I1gjAwQTqo45bzLe+3+kx/EpidoPmO+EQT3mVl0SzwOsOQatSaVwUhsEcILjek3w/FIIpVvHNAIC4azqVpgMjBTOPkQ63S3LWN9bH9zsNbK60IyJUm/eW91o8BerpT/aupgjsxHDEchz0mvnp1WK2i0BJ6P7cTj9nFVNZyZoC+koSlXU89JmYdtqwzcZ2Zh42QVjV3xcN3JfCBaD0E7wPecbvoNp9XM2DCxk2huZVGLy9lI7bBJYkuTWNeEuIWrNEwf1Rw54fpw3+f5zH2Q7+2MteZ4zvlP3Sr6ROc4SSUdODzNOSZevu+R8XOzJlRW1OehdKNvBvTdrGOeIjylryWJEYFHKk2dwEnYRm8ZptNfZ75UXb+IlhxQFR/ShPBjzvGGhZ0FaHqnIlWFNw21u/Gf+8zoT2I13sk2bw+CtPoXvXfRyAzzLdrxSUIYlLX5MMtw4r29iq5o1sGcfVTaKOrSybJripsOIxP70ju2I80kER7+B7VGF+0IkrYiwwzRveA7CWtxiCPWVw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eExZSExyK3ZWdE1NUjVoYnl6SUxYOFNJMytHRHU3bWZ2Z3pPQ3FXOWxDclE3?=
 =?utf-8?B?N1p2a1VCc0t0MDhjb2tTUkhGcHZTY2NIYkxobi90SjAwbGovYWR0WnJYYytv?=
 =?utf-8?B?d0VudTRQTkx5SElzOC9IMUJNUkM4TC93NkRwS2Z4aXMvcFlvREMrc0h2ZEMy?=
 =?utf-8?B?eGYxdFVheFNOQzV6M0xJUHdrckVRaHJMeHh0VFJDUTYzTmE5R0RyMUNRYWIx?=
 =?utf-8?B?VTMzVWczc1dWMTZJVW9uK25sdVRGK2lad3lJUDZveTVzQ1h5bXhoN3N5MXox?=
 =?utf-8?B?bzF5ZHk3SXYzOEpFMUtCODFTNm1YRm9xOHJ2NnE5WkZqVFZkcStKWU16ckg4?=
 =?utf-8?B?U09TTkZaY2FOY1grTG43Qm5IUW9rdWswRGdrU0grVERlQ0loNFJ0bVkvRzlZ?=
 =?utf-8?B?d0JnNkZqODVwcXRnUTF0MEZzdTJ4bW1jcENtdER2a3hzTFZZYW11R0dVMnJq?=
 =?utf-8?B?eE1yMENBY3JwbEhsQkN5amlocFNwZXAvNWVPbXJ2VkgyN3NVZW1YK2hGNFNI?=
 =?utf-8?B?c2piVStLZTRRczlkS25HQkVLWVcyb3prVG1TZElWeU50ZXRXeG04ZEJXYm4v?=
 =?utf-8?B?eFA4bDVqeDhhUHczbzY2SGsxSnlUNGExSWZBVC9zNjlmUjZFKytkeVp4ZjNW?=
 =?utf-8?B?U0lobkFjN2NLS0NNMEE3SlVCYTR4NVdQYlFuYk90dXZVUXM0QVQ0a3pxYm9n?=
 =?utf-8?B?UjVYaG9BSThFK0xic2l4RFRFSXZET3lDSGhsUTh6eWkwdlJlMFpIa2FvdnFh?=
 =?utf-8?B?c0Z2cGhZc2JuU1Zjd3lrMXhOKzNYeDJOanVRNmF1NXhTb1dsSXVFcXFPdm9K?=
 =?utf-8?B?L2xXYldoN0VVb2VjWXZRM0o5N1FkWThjbVFUSWNmUjF6b1dpS3VVNUNydzQ5?=
 =?utf-8?B?OUVKa3NGRzRiK2E4ZEVQQkFUUXZldXp6Mmp4bktvc0k0TlVGeWtjc0VUNjV5?=
 =?utf-8?B?NFZ4VmhwN3p0cTIralJmT3dzU2VNV2hxNmFlQ08rRjNGcmtkYkhZUDhVQTJv?=
 =?utf-8?B?TWRpYmZucVBjdTh0d2xsVW0zNE9KaS85aFRzdXQvK3FnODZ6M1lpa0I2TFMv?=
 =?utf-8?B?S21kSUdXT21pWFU2SlV0T0s1Tlg3Zm5OeXpwRTJqa1pudENJZGF0Z1Q1elkv?=
 =?utf-8?B?ZG5IZXBvb0k4Qll4WEJCUFJiTGVQcmxaRUxMUDNQaklUMk5LcWlIWnVBSmZP?=
 =?utf-8?B?VjVaQXhSZEx6d2N4N1VnM0Y1cWl2dzJMbnEwRUVxZVJyVS9qUktud3pZMGRF?=
 =?utf-8?B?S0kwYUFkRHVUdFhsYzRRNUt1L3RhNzVSZUlhd3lBeVNKS0trZHNETTVuV2Rn?=
 =?utf-8?B?SkRPU3dIVGFOZnhmaHlrM3VQVVlHY2N3Ky9xUC9mR0dnL2UxYXRlaXA1QjJh?=
 =?utf-8?B?OURKQUJQcGdRRCs5NmlXR01BbUxXeHFIRU9tMGg2S0FkbmNhMndGdmFLOXNw?=
 =?utf-8?B?RHk3VnVyM24vS2xVZFlTcFAwZ28vRDM5R0xIbCtTM3Rjemt3RnJ2alplZlZG?=
 =?utf-8?B?M25wRTh4VTNPemd6cExMbWdpakIzQUZZaFBab3ZDVk9vNlBaR0dVTkluZ1Ry?=
 =?utf-8?B?VnJmdkM3ekpwT2x3bHhaTncvMHlHZzhJc3VOUGh4M0h1cFM0cll4eDExUGpY?=
 =?utf-8?B?REttV1RFSU5LWUl1NnlnSnQ1eUpsMVdPR1JLZXhRNEN0Y1BTK2d5b3pNMkZm?=
 =?utf-8?B?WEZsd2s2YWdMM050dWFEV1R3MVdwQTZlMXVBMVFrSkt4RkovMjdtK2ZjLzVF?=
 =?utf-8?B?TXN3SThVdmtsTzlubE1LK2xMTzM3RmNxU3RDUjEyZWlZTDhabmU5dHowMkl6?=
 =?utf-8?B?YTVBNHlRczM2RGtiL3NxdmpFZzVLcUo5UzFYU2xCdnNMYnFTWGJrYitQWnRU?=
 =?utf-8?B?Z1RWVmRaUVJCUkdZOG9jTVBWN1pEM0JhRTFwbUhTZHZnL3Ridnc4K0RKZWF4?=
 =?utf-8?B?dWt3SnByOGRSc3BKdTRnS3hSM3FEYzV3RkhOaWZrZDB3VHNENlAxUkpJUFJO?=
 =?utf-8?B?Z3BqV1pFYXJFaU14TU43WTFrUEdGMDg4MUx1d3hqQ3dsRGNkdVJHQTNjSHZO?=
 =?utf-8?B?aFhUU1lEQVdiZXMzV0FvdWVDV3VrQzk4YThqN2JQOE9qNTVrUDh3YUhMWGJu?=
 =?utf-8?Q?l8H4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a46388-628b-4af0-c4ec-08dc57a461f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 08:17:50.8868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 94uv8tqkunDJtFZPtPTLVGF1pGgZLs8qGaqyw/6u4/pe8RInlTypK/NE1YJSs6I+LfjPtIq5riDuqi6n68L7IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7141
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5j
b20+DQo+U2VudDogTW9uZGF5LCBBcHJpbCA4LCAyMDI0IDM6NTUgUE0NCj5UbzogWXUsIExhbmcg
PExhbmcuWXVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+Q2M6IEt1
ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BB
VENIXSBkcm0vYW1ka2ZkOiBtYWtlIHN1cmUgVk0gaXMgcmVhZHkgZm9yIHVwZGF0aW5nDQo+b3Bl
cmF0aW9ucw0KPg0KPkFtIDA3LjA0LjI0IHVtIDA2OjUyIHNjaHJpZWIgTGFuZyBZdToNCj4+IFdo
ZW4gVk0gaXMgaW4gZXZpY3Rpbmcgc3RhdGUsIGFtZGdwdV92bV91cGRhdGVfcmFuZ2Ugd291bGQg
cmV0dXJuIC0NCj5FQlVTWS4NCj4+IFRoZW4gcmVzdG9yZV9wcm9jZXNzX3dvcmtlciBydW5zIGlu
dG8gYSBkZWFkIGxvb3AuDQo+Pg0KPj4gRml4ZXM6IDJmZGJhNTE0YWQ1YSAoImRybS9hbWRncHU6
IEF1dG8tdmFsaWRhdGUgRE1BQnVmIGltcG9ydHMgaW4NCj4+IGNvbXB1dGUgVk1zIikNCj4NCj5N
aG0sIHdoaWxlIGl0IHdvdWxkIGJlIGdvb2QgdG8gaGF2ZSB0aGlzIGNhc2UgaGFuZGxlZCBhcyBl
cnJvciBpdCBzaG91bGQNCj5uZXZlciBvY2N1ciBpbiBwcmFjdGljZSBzaW5jZSB3ZSBzaG91bGQg
aGF2ZSB2YWxpZGF0ZWQgdGhlIFZNIGJlZm9yZQ0KPnZhbGlkYXRpbmcgdGhlIERNQS1idWZzLg0K
DQpXaGVuIHBhZ2UgdGFibGUgQk9zIHdlcmUgZXZpY3RlZCBidXQgbm90IHZhbGlkYXRlZCBiZWZv
cmUgdXBkYXRpbmcgcGFnZSB0YWJsZXMsDQpWTSBpcyBzdGlsbCBpbiBldmljdGluZyBzdGF0ZSwg
dGhlbiB0aGUgaXNzdWUgaGFwcGVuZWQuDQoNClJlZ2FyZHMsDQpMYW5nDQoNCj5ARmVsaXggaXNu
J3QgdGhhdCBzb21ldGhpbmcgd2UgaGF2ZSB0YWtlbiBjYXJlIG9mPw0KPg0KPlJlZ2FyZHMsDQo+
Q2hyaXN0aWFuLg0KPg0KPg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExhbmcgWXUgPExhbmcuWXVA
YW1kLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
YW1ka2ZkX2dwdXZtLmMgfCA2ICsrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYW1ka2ZkX2dwdXZtLmMNCj4+IGluZGV4IDBhZTlmZDg0NDYyMy4uOGM3MWZlMDc4MDdhIDEw
MDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9n
cHV2bS5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2Zk
X2dwdXZtLmMNCj4+IEBAIC0yOTAwLDYgKzI5MDAsMTIgQEAgaW50DQo+PiBhbWRncHVfYW1ka2Zk
X2dwdXZtX3Jlc3RvcmVfcHJvY2Vzc19ib3Modm9pZCAqaW5mbywgc3RydWN0DQo+ZG1hX2ZlbmNl
DQo+PiBfX3JjdSAqDQo+Pg0KPj4gICAgICBhbWRncHVfc3luY19jcmVhdGUoJnN5bmNfb2JqKTsN
Cj4+DQo+PiArICAgIHJldCA9IHByb2Nlc3NfdmFsaWRhdGVfdm1zKHByb2Nlc3NfaW5mbywgTlVM
TCk7DQo+PiArICAgIGlmIChyZXQpIHsNCj4+ICsgICAgICAgICAgICBwcl9kZWJ1ZygiVmFsaWRh
dGluZyBWTXMgZmFpbGVkLCByZXQ6ICVkXG4iLCByZXQpOw0KPj4gKyAgICAgICAgICAgIGdvdG8g
dmFsaWRhdGVfbWFwX2ZhaWw7DQo+PiArICAgIH0NCj4+ICsNCj4+ICAgICAgLyogVmFsaWRhdGUg
Qk9zIGFuZCBtYXAgdGhlbSB0byBHUFVWTSAodXBkYXRlIFZNIHBhZ2UgdGFibGVzKS4NCj4qLw0K
Pj4gICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KG1lbSwgJnByb2Nlc3NfaW5mby0+a2ZkX2JvX2xp
c3QsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgdmFsaWRhdGVfbGlzdCkgew0KDQo=
