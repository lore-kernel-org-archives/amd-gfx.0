From: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: build broken on drm-next
Date: Mon, 10 Dec 2018 12:14:38 +0000
Message-ID: <BY2PR12MB004008D011F3D09ED10050A5ECA50@BY2PR12MB0040.namprd12.prod.outlook.com>
References: <a097ffb3-2902-73ac-d9ac-1cfaeb8fe642@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_BY2PR12MB004008D011F3D09ED10050A5ECA50BY2PR12MB0040namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a097ffb3-2902-73ac-d9ac-1cfaeb8fe642-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "Zhou, Tiecheng" <Tiecheng.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Gui,
 Jack" <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

--_002_BY2PR12MB004008D011F3D09ED10050A5ECA50BY2PR12MB0040namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SmFjayBhbHJlYWR5IGhhdmUgYSBwYXRjaCB0byBmaXggdGhpcyBpc3N1ZS4gDQoNClRoYW5rcywN
ClJheQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggW21h
aWx0bzphbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnXSBPbiBCZWhhbGYNCj4g
T2YgU3REZW5pcywgVG9tDQo+IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMTAsIDIwMTggODowNyBQ
TQ0KPiBUbzogWmhvdSwgVGllY2hlbmcgPFRpZWNoZW5nLlpob3VAYW1kLmNvbT47IGFtZC1nZngg
bWFpbGluZyBsaXN0IDxhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQo+IENjOiBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6
IGJ1aWxkIGJyb2tlbiBvbiBkcm0tbmV4dA0KPiANCj4gSGksDQo+IA0KPiBUaGlzIGNvbW1pdA0K
PiANCj4gY29tbWl0IGU0MjFjNjU2YmVlZmExMDQ0ZjY1Y2Y1MGQ3YTc0NTVkZjYwY2Q3MDMNCj4g
DQo+IFJlZnM6IHY0LjIwLXJjMy01MzAtZ2U0MjFjNjU2YmVlZg0KPiANCj4gQXV0aG9yOiAgICAg
VGllY2hlbmcgWmhvdSA8VGllY2hlbmcuWmhvdUBhbWQuY29tPg0KPiANCj4gQXV0aG9yRGF0ZTog
RnJpIERlYyA3IDA5OjExOjM1IDIwMTggKzA4MDANCj4gDQo+IENvbW1pdDogICAgIFRpZWNoZW5n
IFpob3UgPFRpZWNoZW5nLlpob3VAYW1kLmNvbT4NCj4gDQo+IENvbW1pdERhdGU6IE1vbiBEZWMg
MTAgMTE6MTQ6MjcgMjAxOCArMDgwMA0KPiANCj4gDQo+ICAgICAgZHJtL2FtZGdwdTogYnlwYXNz
IFJMQyBpbml0IHVuZGVyIHNyaW92IGZvciBUb25nYQ0KPiANCj4gICAgICBSTEMgd2lsbCBnbyB3
cm9uZyBpbiBzb2Z0X3Jlc2V0IHVuZGVyIHNyaW92DQo+IA0KPiAgICAgIFdvcmthcm9vdW5kOiBv
bmx5IG5lZWQgdG8gaW5pdCBSTEMgY3NiLCBhbmQgc2tpcCBSTEMgc3RvcCwgcmVzZXQsIHN0YXJ0
DQo+ICAgICAgICAgIHRoaXMgaXMgYmVjYXVzZSBob3N0LWRyaXZlciBoYXMgYWxyZWFkeSBkb25l
IGZ1bGwgaW5pdGlhbGl6YXRpb24gb24gUkxDDQo+IA0KPiAgICAgIFNpZ25lZC1vZmYtYnk6IFRp
ZWNlaG5nIFpob3UgPFRpZWNoZW5nLlpob3VAYW1kLmNvbT4NCj4gDQo+ICAgICAgQWNrZWQtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gDQo+IA0KPiBDYXVz
ZXMgYSBidWlsZCBlcnJvciBvbiBhbWQtc3RhZ2luZy1kcm0tbmV4dDoNCj4gDQo+IGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmM6IEluIGZ1bmN0aW9uDQo+IOKAmGdmeF92OF8w
X3JsY19yZXN1bWXigJk6DQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmM6
NDA3MTo2OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24NCj4gb2YgZnVuY3Rpb24g4oCYYW1k
Z3B1X3NyaW924oCZOyBkaWQgeW91IG1lYW4g4oCYYW1kZ3B1X3NyaW92X3Zm4oCZPw0KPiBbLVdl
cnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gICAgaWYgKGFtZGdwdV9zcmlv
dihhZGV2KSkgew0KPiAgICAgICAgXn5+fn5+fn5+fn5+DQo+ICAgICAgICBhbWRncHVfc3Jpb3Zf
dmYNCj4gICAgQ0MgW01dICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3YzXzAubw0K
PiAgICBDQyBbTV0gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5vDQo+ICAg
IENDIFtNXSAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5vDQo+IGNjMTog
c29tZSB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycw0KPiBtYWtlWzRdOiAqKiogW3Nj
cmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjkzOg0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjhfMC5vXSBFcnJvciAxDQo+IG1ha2VbNF06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVk
IGpvYnMuLi4uDQo+IG1ha2VbM106ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo1MTg6IGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1XQ0KPiBFcnJvciAyDQo+IG1ha2VbMl06ICoqKiBbc2Ny
aXB0cy9NYWtlZmlsZS5idWlsZDo1MTg6IGRyaXZlcnMvZ3B1L2RybV0gRXJyb3IgMg0KPiBtYWtl
WzFdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NTE4OiBkcml2ZXJzL2dwdV0gRXJyb3Ig
Mg0KPiBtYWtlOiAqKiogW01ha2VmaWxlOjEwNjA6IGRyaXZlcnNdIEVycm9yIDINCj4gDQo+IA0K
PiBUb20NCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
Cj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
DQo=

--_002_BY2PR12MB004008D011F3D09ED10050A5ECA50BY2PR12MB0040namp_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Mon, 10 Dec 2018 12:14:36 GMT";
	modification-date="Mon, 10 Dec 2018 12:14:36 GMT"

Received: from CY4PR12MB1461.namprd12.prod.outlook.com (2603:10b6:a03:c0::17)
 by BY2PR12MB0040.namprd12.prod.outlook.com with HTTPS via
 BYAPR05CA0004.NAMPRD05.PROD.OUTLOOK.COM; Mon, 10 Dec 2018 08:05:48 +0000
Received: from DM5PR12CA0061.namprd12.prod.outlook.com (2603:10b6:3:103::23)
 by CY4PR12MB1461.namprd12.prod.outlook.com (2603:10b6:910:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.17; Mon, 10 Dec
 2018 08:05:46 +0000
Received: from DM3NAM03FT063.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::200) by DM5PR12CA0061.outlook.office365.com
 (2603:10b6:3:103::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1404.17 via Frontend
 Transport; Mon, 10 Dec 2018 08:05:45 +0000
Received: from gabe.freedesktop.org (131.252.210.177) by
 DM3NAM03FT063.mail.protection.outlook.com (10.152.83.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1404.17 via Frontend Transport; Mon, 10 Dec 2018 08:05:44 +0000
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4DC86E317;
	Mon, 10 Dec 2018 08:05:42 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690048.outbound.protection.outlook.com [40.107.69.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DEAC6E317
 for <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Mon, 10 Dec 2018 08:05:41 +0000 (UTC)
Received: from MWHPR12CA0032.namprd12.prod.outlook.com (2603:10b6:301:2::18)
 by BN1PR12MB0051.namprd12.prod.outlook.com (2a01:111:e400:52::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.22; Mon, 10 Dec
 2018 08:05:39 +0000
Received: from DM3NAM03FT059.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::201) by MWHPR12CA0032.outlook.office365.com
 (2603:10b6:301:2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1404.19 via Frontend
 Transport; Mon, 10 Dec 2018 08:05:39 +0000
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 DM3NAM03FT059.mail.protection.outlook.com (10.152.82.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1404.17 via Frontend Transport; Mon, 10 Dec 2018 08:05:39 +0000
Received: from gc-System-Product-Name.amd.com (10.34.1.3) by
 SATLEXCHOV01.amd.com (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1;
 Mon, 10 Dec 2018 02:05:34 -0600
From: "Gui, Jack" <Jack.Gui-5C7GfCeVMHo@public.gmane.org>
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
CC: "Gui, Jack" <Jack.Gui-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] amd/amdgpu: fix typo about amdgpu_sriov_vf
Thread-Topic: [PATCH] amd/amdgpu: fix typo about amdgpu_sriov_vf
Thread-Index: AQHUkF8pi+Bh+z/0SEexOxGshSJwvQ==
Sender: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Date: Mon, 10 Dec 2018 08:05:13 +0000
Message-ID: <1544429113-1032-1-git-send-email-Jack.Gui-5C7GfCeVMHo@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
Content-Language: en-US
X-MS-Exchange-Organization-AuthSource: DM3NAM03FT063.eop-NAM03.prod.protection.outlook.com
X-MS-Has-Attach: 
X-Auto-Response-Suppress: All
X-MS-Exchange-Organization-Network-Message-Id: 7e0b5791-307f-42c6-66ce-08d65e7649cb
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
x-ms-exchange-organization-originalclientipaddress: 131.252.210.177
x-ms-exchange-organization-originalserveripaddress: 10.152.83.122
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-forefront-antispam-report: CIP:131.252.210.177;IPV:NLI;CTRY:US;EFV:NLI;SFV:SFE;SFS:;DIR:INB;SFP:;SCL:-1;SRVR:CY4PR12MB1461;H:gabe.freedesktop.org;FPR:;SPF:None;LANG:en;
list-id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
x-original-to: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
delivered-to: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
x-ms-publictraffictype: Email
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0040;27:ZfY6dpJpy1qJ5mMLkPkQd3cF8gnW7yR6VzqZPMFKh4NDhCB0zj8sxhpWvndtygpr5GM+yHymupgttay7DqkayLrj0RVNOhkN6zMIb0p5ODHNa97mBXysnz9c4rZxuD4ivdEPzKah7qfqZmJquiNAz9f1plJ7JxUjjSrdc7pi9esofY5VoJJwuzq1yN8caI9c3DZXX0UhWn4gUVmkgsBNTIfD6Iy+PJM2snbzwbiudIvPwKp7v4+usVrI1K0jAiTffrP8kLNGNoDANR3rWgvB7vuw8HXZTzHjuAmb/DdfwIZZfcR992Hl6WQxMKz1Pwf3s0cE4Z3TdH7p3uoxTjp8/3xYVGU/40pKBsMITMBUy8xUUWhw5IEJqV60CLRHX/92JdSIzqG/tdngk2dgFRb3anFLWOJ6hZ9iBp1MAWP4BSV+nckgwyR0YAYoczoGpcL1
X-Microsoft-Antispam-Mailbox-Delivery: wl:1;pcwl:1;ucf:1;jmr:0;ex:0;auth:0;dest:C;OFR:CustomRules;ENG:(750119)(520011016)(520004050)(702028);
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmFDU3ZkTTZaek53cWZWeEs1bkJPVnpWT2x3eExub2NQVExwMVZWZTdVbDJy?=
 =?utf-8?B?R2dQUzUwdy9USFlLZnhTWUoydDRiNWg1VlQxZHdHaGRNMXhMTEVVMUIyUGxh?=
 =?utf-8?B?ZlAzK1IzbmEwV2tuT0lsM0dWYSs5WWtacTBxZlR3VG8yMENRNUxIeEtlOTY4?=
 =?utf-8?B?VlFEc1ZTeHFMTExnZVVRRmkvQUFlaFlORTJaR2V1a0hQL0VzUUhHN1FJT1pZ?=
 =?utf-8?B?c1MyaU1WcHBEdGtVM0cvbVBTdU9UMkxKNDZiZHh1QVVJc3VHYVhZQkhPSzA3?=
 =?utf-8?B?NGJMWlJtQ29PR1Q0aTJjSjNnUXJIeEVuVHExN2JQQTRnL0dqV1BRNnQ2WXJE?=
 =?utf-8?B?b2JsQkNLYXNHa2N1alJRQnU4TWhtL0Q3LzNNWWg0VDN1S050T015N0hoU2Yv?=
 =?utf-8?B?SmwrVlNIZmgvZ2VBMU9KUWk0T3ZWdkVBaXR0T1RVdjZqdlM4TUcybUpOSmN5?=
 =?utf-8?B?WElDQWVSak15eXVuam5SUngvY3RpOFc2Mm9xd2hCbWROK0hocXlPWTdOQTB5?=
 =?utf-8?B?dXRwaHhSbDcyWXBtSmlPdWdXbEI2L3VLVW5zZUxvc1BXK3ZhU1lCRkJsMzV4?=
 =?utf-8?B?eFFOemhZYUJFZmkycFJIdWZZOHQzTFZlVi9YQXJQY3QxTnJ5TSs0cTVxL1pR?=
 =?utf-8?B?OFFiVm1zdlhMRzhKQ3NwUGU3SFpHUk9uK1BBUUxBV0RiNkxPdXRlWTl2RzRL?=
 =?utf-8?B?ejBCOUxPWEhabzd5MitBZXFhb1d4a1gzMTJDTlZXNnJUSDRQL2V5WlFlalI5?=
 =?utf-8?B?TUZaNkZ2TUlTdEQ0UHBkQXpIK1NaL0RHTmJ2RktoMFhFbDBKSHczY0g3TUN0?=
 =?utf-8?B?RStBOEtBc3VxaHExUWhybEZGaVhPM3FJR0tXeWNTcVJNSVpmdm5nOExaRWgw?=
 =?utf-8?B?VHkzWkhhSnNWNy9NejcwWjFrWFJ0cEM4ZjVPYTAwaDhnMzl3bDRpdGh3WXZO?=
 =?utf-8?B?RCtxZGpLdzJCYzJNNTdCeEZHRGJQbDhOWXZRc00zVStOVUdCdEhxSVlhNU1v?=
 =?utf-8?B?clZvZkFhMEo3MWZQNFAvaDRWQWdxNENkSjIrc2kzSmg2SXg4c1BKYXF5K2s4?=
 =?utf-8?B?SFdlTjNieXRJb05NdDdhc1ZhcmV2azNXcFUraTlzZWtTd2hzQjBsTWkrZFhC?=
 =?utf-8?B?V2owZVVmdzdCUEp6b1Q4QUhPMnRrQmVKVXJZTnVKeU9idnFWcWQwd0RJMmM2?=
 =?utf-8?B?aTdvQ05EaEdJS2VIR1U3bzdPa0VuUW5yYi9hRXFpWFV1dHE4bFk1TW5lNmxz?=
 =?utf-8?B?TWdQSkhoQzlEbno3SHh5ZExKNzdiRkxaMGpxcmZNZXI5aE1TVjJjRHU1eTR3?=
 =?utf-8?Q?5A22JL9gT/cMM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <399E0D12539A1246A4691EAD8A62B171-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Content-Transfer-Encoding: base64
MIME-Version: 1.0

U2lnbmVkLW9mZi1ieTogQ2hlbmdtaW5nIEd1aSA8SmFjay5HdWlAYW1kLmNvbT4NCi0tLQ0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgfCAyICstDQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y4XzAuYw0KaW5kZXggYTljODUzYS4uMDhmNDQzZiAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OF8wLmMNCkBAIC00MDY4LDcgKzQwNjgsNyBAQCBzdGF0aWMgdm9pZCBn
ZnhfdjhfMF9ybGNfc3RhcnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQoNCiBzdGF0aWMg
aW50IGdmeF92OF8wX3JsY19yZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQogew0K
LSAgICAgICBpZiAoYW1kZ3B1X3NyaW92KGFkZXYpKSB7DQorICAgICAgIGlmIChhbWRncHVfc3Jp
b3ZfdmYoYWRldikpIHsNCiAgICAgICAgICAgICAgICBnZnhfdjhfMF9pbml0X2NzYihhZGV2KTsN
CiAgICAgICAgICAgICAgICByZXR1cm4gMDsNCiAgICAgICAgfQ0KLS0NCjIuNy40DQoNCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxp
bmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0K

--_002_BY2PR12MB004008D011F3D09ED10050A5ECA50BY2PR12MB0040namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_002_BY2PR12MB004008D011F3D09ED10050A5ECA50BY2PR12MB0040namp_--
