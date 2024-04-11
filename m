Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05C2CD1284
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 11:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9247510F01F;
	Thu, 11 Apr 2024 11:30:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c2dPpGvK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3570310F01F
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 11:30:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1W7wZFDfxxV/xIpsFb1wlrcZkW5FY15xEdVtX56Mj7ngRpTS3mBuqGQw26zim5CfAwT3M/Tchf/z9z4hOS7HpMs99WhqdUCmCq8wVBRQmVm1SPcvuCqe4PXi2AiqLHy787oyeQ1t2J+Iio3iXrybPkzHd/HTFORBOxxK8Du+0Pgc4Nz60ssAEwU8At8kS4RcFTkOzjuetAPYGZqnS/Si7xDpbTPBgPSA2fE7a6yp9ma2q21RIdcAoZaS3rPLK7OilKc7RrGPwgNIJCFxG9KDVALK9wVPfFvJHZ47OqdZhWu4CJgen04xpVcOSEl1MUaLdY7z2PgfJqDa1obKKoiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NRLSYaLcK/PlUxmtuxRPEdJauky0LU5D1KTxhQd2j0=;
 b=Ll1Cw5ldTeti3Eid3hDuC8tTQJZUb6f1OUqjk79x1Sq5i3UbJbSlUmUYr7grcPwnRAdgHYiUPDzo6NLYF4nMEZdTB5GIJaMFS+K7Od3jxOFXqf4vUyJtUOQTOkYIjcaJVXilkIVXqJlZdQLe0fC60RiZVwV0Njgw9hMiXfq7lryh7d08K0nF9GzJJN1IbNpj63geC3LA/6ahG1SOC+SH+Kk4XNLbuSEu8hMSpDgwVFVk75xOeX05KPiaynTLy7Q4PepDfZnSboN1YFdRC9uXRUvLp5D2hbaPnlPJCITkfo4LeWYVl1a7HCyHTwie5owJR7dKrX0VzwePKLJ0pdrvyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NRLSYaLcK/PlUxmtuxRPEdJauky0LU5D1KTxhQd2j0=;
 b=c2dPpGvKR0AJMLwHmhUECI7x+zje2A7OcOpf2ljGzRWeOTDuXqIgORFug3qbKiXiq6eDfdl614bRko1jQ9iFOJjNF1s4DE2Lr8KOqDLZUbYgRKnhQ8tqTWMSGjUhX/W0rrLtJ1Ji8NvKL3cXE6zNPNPxHX7s+BrzImQjI1uE/ZU=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 11:30:40 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::e45c:ba8b:1eac:6dc4]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::e45c:ba8b:1eac:6dc4%4]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 11:30:39 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Support setting recover method
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Support setting recover method
Thread-Index: AQHajAD+nsCJVHZE8U+bOekZsaJxIbFi65SAgAACA2A=
Date: Thu, 11 Apr 2024 11:30:39 +0000
Message-ID: <PH7PR12MB79881B8A7769C065A41CD8179A052@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20240411111108.3571355-1-Stanley.Yang@amd.com>
 <743be31c-0edc-4fb5-ae4f-694de64481c6@gmail.com>
In-Reply-To: <743be31c-0edc-4fb5-ae4f-694de64481c6@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=96ac2f6c-30d9-483c-9e1d-2a27139cf7ae;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-11T11:24:20Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|DS0PR12MB7995:EE_
x-ms-office365-filtering-correlation-id: 6f014e39-94c8-4648-d2aa-08dc5a1ad0d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CeteKjeagRistD8rGXbC+U5YKvCpBtrvbtcKsRAh8uXRZ+ThIxRmKaAba0ORLKe/BVs/WGykVXMKjAHlC1uGxNacEKCBKLyNq43ZEF+AijnpOik21llc+gZivHLnFei5BH9DrcFFR4h9NFry+TKR/tBO+fcobJIfitiSu/fOFnihd049A+IBUccuLxnB6uhwMwHNx4gt0rdZb0bMsiN6TiOQBkHyg7UGRnWtzvtaIX/c+/WcyhsdkpwCTTr4Bl7wZC1fX6qf2hBi9LBwnWV3XMXZfvhvPSO71Q8pYFtEvrwYhwmVN6+nqJWkcCHlU4KvFACEQdzYeJG7C7C7Sk1mDCZwDUHA3gKKshjJZB7j7am0Z210rtqn+caMv0EwFk2o9Ij2wT8EnHMRLC5okCXGKGSn2dKeos5egbnyrb7raoU8bAZwU/3giVsrnPVXpoMkxcEPbWi+MND+q27dCI7apPMlMzABq1SDq12W4SP42rD0/6/8LUpnSBzoAUOy6KxOXac118SRH335aoyuIpFVY6wOI6XOdNHTNGtGiIVEXpSlT0o7FQ9yg458Dk8EQq0dGur28c2tnhu9xLtj1tDMwM9JhISBGxidrhEv/YwuGGN4Q5U0hGpb7Mkdo2RuRGEVjt/eL9ZGz1lhc0e4Y3NEd4nUk1vU42xo5Iv7ZIlp4taltU7kdvlNxWnsMUO1mroyK18AvLCUdt58JWqLoF9CC5HMHemtksxGrnbrpqudVoM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTBybmp4V0g1cXFiWlZtZUFWOXBFYkMwYXNNeVBUb00xdmh3RlVhYkJJR0du?=
 =?utf-8?B?M0g2VUU0SUJEemYxTWsxQUtKMEJYMy9PNVlsMlgzUXdMQkxERERac0RCZC9P?=
 =?utf-8?B?VTd1OWdJS01pcXpnY21kZktUT2tna3hSZjhoVjlXTEl0UllBYzhFR1NSMVZL?=
 =?utf-8?B?c3k2TXgxSlIwbGNTbmxVTjBnWWNFbThYSnBtR3ppTURvaEkwVEpWa1cyZmo4?=
 =?utf-8?B?aFpUZnlqUW5Jem9Eak9aRmNMWTVaQkdHMGRiUXBBY0hzNjFOMUhtTXE5dTJo?=
 =?utf-8?B?YUp0QmIwVXFZdFZYa0ZHYlZFanZBdDhnRXFhS2RSU0lMZnpJWkRrdGpucEs1?=
 =?utf-8?B?ZEowa1F4NVd3Z3RiemVKRjdDNXpXRmxCYnA3eHk0UW9Ec0FIci9BL0N3WEM3?=
 =?utf-8?B?dmVENDVTQjVpcUNGRm9iWlVsWjBjczAyRmFDV2w0d1Q0NTdlNzVzM1RHWmNz?=
 =?utf-8?B?RlJYQUhsUjFLRjlPNk15Z0dwS2NkUVo2YUc3SUs1VmJjakI2L2cyb3hQK3kx?=
 =?utf-8?B?MDdsZ21TaFcrTFJyS1grMzRLYUJndk1xenR0d3h5WG1lWXZGSUQ4N3AxZ0hL?=
 =?utf-8?B?MFZtS1czRlZ4d2Zhck5hT3NBcGcwZ0dIcDIyR09EQ3hnV0lHeHdYbXpEcnkv?=
 =?utf-8?B?dDdXRXh6U0ExZjI0alpQeEt1L05rUW0vSHl3SHJWYlFQTEFjYTJCVlJaTFA0?=
 =?utf-8?B?VGtwVXhsRjVZQmdnczFueTFoMEUvVDZFRmxYK1hiNzBnRnJCUko0M2FYSUsw?=
 =?utf-8?B?cmhVTzczRXhMWEtCZDZ1WDd0WU5ReWVvOTByakZDUDNMTzZOMW4rdG1vOFY1?=
 =?utf-8?B?bkJSaGlDd2lXaUdoT3c1YTlacS9kUDlpdFVJVmFlbjNtU3VYaTRyb3MxcHJy?=
 =?utf-8?B?L0lucTlJZUNOOW9SNmVvMHNxZ1pjVTU2TGlYQnpYMzg5SW5oeGFVTnhQSXQv?=
 =?utf-8?B?ekp4aUMySFpUOE9EZTFERjNkTDdHKzNYWXR0MnA3OVNUTnZiSzgxZEROK1Zs?=
 =?utf-8?B?MlN4Y2ZHTDhyMDJuWlo0eGpXU3RNRE93NnBmcXRLWlB1ZkZhdm45YnRQazhD?=
 =?utf-8?B?SnU5anZ5MThDa3pDekdXWFR5WGV3clJOdVg0SkpFV0NRa09aa0ZmYm1YcTVL?=
 =?utf-8?B?VXlSYjlqV0Z1L3RDTWlJUUVOTHZqa2ladHRpbldtR05QV3RZcGp3NDBGNEZa?=
 =?utf-8?B?ZXVBclVWVmErYWxiU2Q2ZEhTSVZYTmZmUXNGNnFTdXVGN3NlZStQMy9hZ3FM?=
 =?utf-8?B?NExXWmxoUE52Tk9jbThoMHpQUnJsdHZDT0orN0dTTnhmOWhCTWlYUUVTU2d1?=
 =?utf-8?B?dU9Zc0RsaDVFTFhMdE5leVhadlBxcmkwaDdvUmVMbWsyQ0RZa0h0Ly9VZHNu?=
 =?utf-8?B?eVpxbnFJeEJ6SUlTM210c3ZhTjhwVU5yUHpLSGRkRXRuZ3lhNE5VSllOSmVU?=
 =?utf-8?B?RGxDeXl6SS91RzNsejJ3elhhcSszUXAvS2l0d3NFd1d5RTIvV08vam40Vnhs?=
 =?utf-8?B?Y2FzdThGVUlvQTlkYThWWUxYRnFJS2tzQkN2SG1uamVaSFVPUHA0SDFlUjB3?=
 =?utf-8?B?dVY3YTFGRUJyQ0Q0RXRsdWRFOFMvMk92UndjTmtVc0x1cHdFOE9kN2ExUWtN?=
 =?utf-8?B?ODU5VEN2WGNpOURHdDJMeHZGaHBCRlFyWVkyTnphY2sxcExGVHc2S1NpaE1J?=
 =?utf-8?B?UHdLL3o4TkIwMU5ZcXFjY0lKNkMrM2o1bWR0SE4vVlpsalpzbkhWbXhDU3A0?=
 =?utf-8?B?TDNOMEJvTU16VmRpR1BNM2xLYUVpSjl0RncraGRPVFdqVHBEMDlxV3FidFFi?=
 =?utf-8?B?bUMycjgxZUtJQlR2VnJPa3ZZc1Z2Z09maE84c0pJdmYwNTQ4SCt3YmRsOHRt?=
 =?utf-8?B?dzdkbGErMEI0VVUybTZlOUtsa3FCR0JwakNzdk1waDlqKy8vdUxQSHJGN2JB?=
 =?utf-8?B?MDR4azRzVHZkWEhtVFlJYW1BTy83U2xKbFhCL3VWUldHWDN1TDJFd2NtOHNa?=
 =?utf-8?B?MWFMOVdXbmthQWR5QnlOWXptYnp2N3VscVZ3Z2pEb3g4aG03NHlQQjk0UW9o?=
 =?utf-8?B?em5HWjlYckhjNE0zL3FCQTNJN3BTWmc4TVNXbmlodFplN1hlNnUzbGcxZ0U1?=
 =?utf-8?Q?tLmc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f014e39-94c8-4648-d2aa-08dc5a1ad0d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 11:30:39.8704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdaffwUG+JltDV5DnrtEvgV+JbYtob0JGhHktA4je5GkLxqSTXe4Lf+1afIqUsPeNXQCoz1RIaoaEgUSRD5Vcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtl
bkBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAxMSwgMjAyNCA3OjE3IFBNDQo+
IFRvOiBZYW5nLCBTdGFubGV5IDxTdGFubGV5LllhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUmV2aWV3IDEvMV0gZHJtL2Ft
ZGdwdTogU3VwcG9ydCBzZXR0aW5nIHJlY292ZXIgbWV0aG9kDQo+DQo+IEFtIDExLjA0LjI0IHVt
IDEzOjExIHNjaHJpZWIgU3RhbmxleS5ZYW5nOg0KPiA+IERvbid0IG1vZGlmeSBhbWRncHUgZ3B1
IHJlY292ZXIgZ2V0IG9wZXJhdGlvbiwgYWRkIGFtZGdwdSBncHUgcmVjb3Zlcg0KPiA+IHNldCBv
cGVyYXRpb24gdG8gc2VsZWN0IHJlc2V0IG1ldGhvZCwgb25seSBzdXBwb3J0IG1vZGUxIGFuZCBt
b2RlMg0KPiA+IGN1cnJlbnRseS4NCj4NCj4gV2VsbCBJIGRvbid0IHRoaW5rIHNldHRpbmcgdGhp
cyBmcm9tIHVzZXJzcGFjZSBpcyB2YWxpZC4NCj4NCj4gVGhlIHJlc2V0IG1ldGhvZCB0byB1c2Ug
aXMgZGV0ZXJtaW5lZCBieSB0aGUgaGFyZHdhcmUgYW5kIGVudmlyb25tZW50IChlLmcuDQo+IFNS
SU9WLCBwYXNzdGhyb3VnaCwgd2hhdGV2ZXIpIGFuZCBjYW4ndCBiZSBjaG9zZW4gc2ltcGx5Lg0K
DQpbU3RhbmxleV06IEFncmVlLCB0aGUgc2V0dGluZyBpcyBpbnZhbGlkIGZvciBzb21lIGRldmlj
ZXMgbm90IHN1cHBvcnRlZCBzZXR0aW5nIG1ldGhvZCBhbmQgZGV2aWNlcyBzdGlsbCByZXNldCB3
aXRoIGRlZmF1bHQgbWV0aG9kLA0KYnV0IGl0J3MgdmFsaWQgZm9yIHRob3NlIGRldmljZXMgc3Vw
cG9ydGVkIHNldHRpbmcgcmVzZXQgbWV0aG9kLCB1c2VyIGNhbiBjb25kdWN0IGNvbWJpbmF0aW9u
IHRlc3RpbmcgbGlrZSBtb2RlMSB0ZXN0IHRoZW4gbW9kZTIgdGVzdCB3aXRob3V0DQpyZS1tb2Rw
cm9iZSBkcml2ZXIuDQoNClJlZ2FyZHMsDQpTdGFubGV5DQo+DQo+IFJlZ2FyZHMsDQo+IENocmlz
dGlhbi4NCj4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0YW5sZXkuWWFuZyA8U3RhbmxleS5Z
YW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHUuaCAgICAgICAgfCAgMyArKw0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jIHwgIDEgKw0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2ZlbmNlLmMgIHwgMzcNCj4gKysrKysrKysrKysrKysrKysrKy0tLQ0KPiA+ICAgMyBm
aWxlcyBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiA+IGluZGV4IDljNjI1NTJiZWMz
NC4uYzgyOTc2YjJiOTc3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdS5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
LmgNCj4gPiBAQCAtMTE1MSw2ICsxMTUxLDkgQEAgc3RydWN0IGFtZGdwdV9kZXZpY2Ugew0KPiA+
ICAgICBib29sICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlYnVnX2xhcmdlYmFyOw0KPiA+
ICAgICBib29sICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlYnVnX2Rpc2FibGVfc29mdF9y
ZWNvdmVyeTsNCj4gPiAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZWJ1Z191
c2VfdnJhbV9md19idWY7DQo+ID4gKw0KPiA+ICsgICAvKiBVc2VkIHRvIHNldCBncHUgcmVzZXQg
bWV0aG9kICovDQo+ID4gKyAgIGludCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVjb3Zl
cl9tZXRob2Q7DQo+ID4gICB9Ow0KPiA+DQo+ID4gICBzdGF0aWMgaW5saW5lIHVpbnQzMl90IGFt
ZGdwdV9pcF92ZXJzaW9uKGNvbnN0IHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ID4gKmFkZXYsIGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4g
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+IGluZGV4
IDMyMDRiOGY2ZWRlYi4uODQxMWE3OTNiZTE4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+IEBAIC0zOTA4LDYgKzM5MDgsNyBAQCBp
bnQgYW1kZ3B1X2RldmljZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ICphZGV2LA0KPiA+
ICAgICBlbHNlDQo+ID4gICAgICAgICAgICAgYWRldi0+YXNpY190eXBlID0gZmxhZ3MgJiBBTURf
QVNJQ19NQVNLOw0KPiA+DQo+ID4gKyAgIGFkZXYtPnJlY292ZXJfbWV0aG9kID0gQU1EX1JFU0VU
X01FVEhPRF9OT05FOw0KPiA+ICAgICBhZGV2LT51c2VjX3RpbWVvdXQgPSBBTURHUFVfTUFYX1VT
RUNfVElNRU9VVDsNCj4gPiAgICAgaWYgKGFtZGdwdV9lbXVfbW9kZSA9PSAxKQ0KPiA+ICAgICAg
ICAgICAgIGFkZXYtPnVzZWNfdGltZW91dCAqPSAxMDsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jDQo+ID4gaW5kZXggMTA4MzJiNDcwNDQ4Li5lMzg4
YTUwZDExZDkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2ZlbmNlLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZmVuY2UuYw0KPiA+IEBAIC05NjUsOSArOTY1LDM3IEBAIHN0YXRpYyBpbnQgZ3B1X3JlY292ZXJf
Z2V0KHZvaWQgKmRhdGEsIHU2NCAqdmFsKQ0KPiA+ICAgICByZXR1cm4gMDsNCj4gPiAgIH0NCj4g
Pg0KPiA+ICtzdGF0aWMgaW50IGdwdV9yZWNvdmVyX3NldCh2b2lkICpkYXRhLCB1NjQgdmFsKSB7
DQo+ID4gKyAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2
aWNlICopZGF0YTsNCj4gPiArICAgc3RydWN0IGRybV9kZXZpY2UgKmRldiA9IGFkZXZfdG9fZHJt
KGFkZXYpOw0KPiA+ICsgICBpbnQgcjsNCj4gPiArDQo+ID4gKyAgIC8qIFRPRE86IHN1cHBvcnQg
bW9kZTEgYW5kIG1vZGUyIGN1cnJlbnRseSAqLw0KPiA+ICsgICBpZiAodmFsID09IEFNRF9SRVNF
VF9NRVRIT0RfTU9ERTEgfHwNCj4gPiArICAgICAgICAgICB2YWwgPT0gQU1EX1JFU0VUX01FVEhP
RF9NT0RFMikNCj4gPiArICAgICAgICAgICBhZGV2LT5yZWNvdmVyX21ldGhvZCA9IHZhbDsNCj4g
PiArICAgZWxzZQ0KPiA+ICsgICAgICAgICAgIGFkZXYtPnJlY292ZXJfbWV0aG9kID0gQU1EX1JF
U0VUX01FVEhPRF9OT05FOw0KPiA+ICsNCj4gPiArICAgciA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMo
ZGV2LT5kZXYpOw0KPiA+ICsgICBpZiAociA8IDApIHsNCj4gPiArICAgICAgICAgICBwbV9ydW50
aW1lX3B1dF9hdXRvc3VzcGVuZChkZXYtPmRldik7DQo+ID4gKyAgICAgICAgICAgcmV0dXJuIDA7
DQo+ID4gKyAgIH0NCj4gPiArDQo+ID4gKyAgIGlmIChhbWRncHVfcmVzZXRfZG9tYWluX3NjaGVk
dWxlKGFkZXYtPnJlc2V0X2RvbWFpbiwgJmFkZXYtDQo+ID5yZXNldF93b3JrKSkNCj4gPiArICAg
ICAgICAgICBmbHVzaF93b3JrKCZhZGV2LT5yZXNldF93b3JrKTsNCj4gPiArDQo+ID4gKyAgIHBt
X3J1bnRpbWVfbWFya19sYXN0X2J1c3koZGV2LT5kZXYpOw0KPiA+ICsgICBwbV9ydW50aW1lX3B1
dF9hdXRvc3VzcGVuZChkZXYtPmRldik7DQo+ID4gKw0KPiA+ICsgICByZXR1cm4gMDsNCj4gPiAr
fQ0KPiA+ICsNCj4gPiAgIERFRklORV9TSE9XX0FUVFJJQlVURShhbWRncHVfZGVidWdmc19mZW5j
ZV9pbmZvKTsNCj4gPiAtREVGSU5FX0RFQlVHRlNfQVRUUklCVVRFKGFtZGdwdV9kZWJ1Z2ZzX2dw
dV9yZWNvdmVyX2ZvcHMsDQo+IGdwdV9yZWNvdmVyX2dldCwgTlVMTCwNCj4gPiAtICAgICAgICAg
ICAgICAgICAgICAiJWxsZFxuIik7DQo+ID4gK0RFRklORV9ERUJVR0ZTX0FUVFJJQlVURShhbWRn
cHVfZGVidWdmc19ncHVfcmVjb3Zlcl9mb3BzLA0KPiBncHVfcmVjb3Zlcl9nZXQsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgZ3B1X3JlY292ZXJfc2V0LCAiJWxsZFxuIik7DQo+ID4NCj4gPiAg
IHN0YXRpYyB2b2lkIGFtZGdwdV9kZWJ1Z2ZzX3Jlc2V0X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0
ICp3b3JrKQ0KPiA+ICAgew0KPiA+IEBAIC05NzgsOSArMTAwNiwxMCBAQCBzdGF0aWMgdm9pZCBh
bWRncHVfZGVidWdmc19yZXNldF93b3JrKHN0cnVjdA0KPiA+IHdvcmtfc3RydWN0ICp3b3JrKQ0K
PiA+DQo+ID4gICAgIG1lbXNldCgmcmVzZXRfY29udGV4dCwgMCwgc2l6ZW9mKHJlc2V0X2NvbnRl
eHQpKTsNCj4gPg0KPiA+IC0gICByZXNldF9jb250ZXh0Lm1ldGhvZCA9IEFNRF9SRVNFVF9NRVRI
T0RfTk9ORTsNCj4gPiArICAgcmVzZXRfY29udGV4dC5tZXRob2QgPSBhZGV2LT5yZWNvdmVyX21l
dGhvZDsNCj4gPiAgICAgcmVzZXRfY29udGV4dC5yZXNldF9yZXFfZGV2ID0gYWRldjsNCj4gPiAg
ICAgc2V0X2JpdChBTURHUFVfTkVFRF9GVUxMX1JFU0VULCAmcmVzZXRfY29udGV4dC5mbGFncyk7
DQo+ID4gKyAgIGFkZXYtPnJlY292ZXJfbWV0aG9kID0gQU1EX1JFU0VUX01FVEhPRF9OT05FOw0K
PiA+DQo+ID4gICAgIGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoYWRldiwgTlVMTCwgJnJlc2V0
X2NvbnRleHQpOw0KPiA+ICAgfQ0KPiA+IEBAIC05OTksNyArMTAyOCw3IEBAIHZvaWQgYW1kZ3B1
X2RlYnVnZnNfZmVuY2VfaW5pdChzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPiAg
ICAgaWYgKCFhbWRncHVfc3Jpb3ZfdmYoYWRldikpIHsNCj4gPg0KPiA+ICAgICAgICAgICAgIElO
SVRfV09SSygmYWRldi0+cmVzZXRfd29yaywgYW1kZ3B1X2RlYnVnZnNfcmVzZXRfd29yayk7DQo+
ID4gLSAgICAgICAgICAgZGVidWdmc19jcmVhdGVfZmlsZSgiYW1kZ3B1X2dwdV9yZWNvdmVyIiwg
MDQ0NCwgcm9vdCwgYWRldiwNCj4gPiArICAgICAgICAgICBkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJh
bWRncHVfZ3B1X3JlY292ZXIiLCAwNjY2LCByb290LCBhZGV2LA0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgJmFtZGdwdV9kZWJ1Z2ZzX2dwdV9yZWNvdmVyX2ZvcHMpOw0KPiA+
ICAgICB9DQo+ID4gICAjZW5kaWYNCg0K
