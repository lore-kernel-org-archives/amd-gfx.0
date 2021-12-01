Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB9EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 03:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2A0A6E0DC;
	Wed,  1 Dec 2021 03:50:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D01486E0DC
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 03:50:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3y/OtmmhgNngZbwPr0WBPukoxejiCrXQtI4xTsKZJDoWLVI85pvFIVqUU2l9pApXMxgVYbURyImMCXxnO0Hcu0i8GoCvbEOjbr3Ce+fqb5wmPHiF/X7ULrxjEv6xTaVce2eF2cqfEEwdoc5WdaAQ8HiNa7R8lT6qLmN9cS4rsRrVAhhhPWesj3W8eSUpUa6IqmO2GcplTM1cGNuAVfW7iDEAA7zr0AbjSW7gDb6DBg22ZOBwZql2MFDrXvpcpvJjM8UqP2tOylw5bvpMgBpu1b09phjeK//hI2I0FsSEoA6Q2O2J2/H2S8PqwSJbEDUwBV8KmPMIUH+Al8Nw7DArw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIWzPI3ONnIJxRBETK4xfoGJ0FO36V0cXGI2QN4fZtM=;
 b=anhSFJs5n8+0uWIMlJFTs84RWAEknEuebUB9Jd0Jedab+gg0V/C6w7ZWOoj+yPZdLtauVf87alj3wrDtkAz9gK/tuEdH8aDRR5Ylp/BliHvkp5wZMc8qHR4q90nrKVhIDNfaV7o9kyUSlV3oQ0w/x3f9mLV68YEn0TOuzhFPGV82jc3KTCSYr64sJnuXB4mRt8ayfUYcEXM5fNm4SXhsgdOCwdi/JJ53rHClYLCNMWZuG/tbnc6hQztFaijmKVNnMb1aHdan1QmcxYz/TJ96fFziHyIoCtoxndMcvkYDmTX3jvOA7T9j0OF7f/2x81Q77pylNONZpp/FgGWTX5HGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIWzPI3ONnIJxRBETK4xfoGJ0FO36V0cXGI2QN4fZtM=;
 b=subTa2xcMebkvZ4SUFBIYvi+n+3UeiN9FG/LQYX4uls07kiQJDASx8WO7VTBFHDbXeYG+BS3BRYvoGy8cxEcFUVZfvGsEDIZYO93ePLnpKk1Oe3MvMsfl6rsOQWCtGiFlIjZdV6PSgNJdZra3wAUYIPxEKjPGh9fyVQaCBl/RNQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Wed, 1 Dec 2021 03:50:38 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4755.011; Wed, 1 Dec 2021
 03:50:38 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 11/17] drm/amd/pm: correct the usage for
 amdgpu_dpm_dispatch_task()
Thread-Topic: [PATCH V2 11/17] drm/amd/pm: correct the usage for
 amdgpu_dpm_dispatch_task()
Thread-Index: AQHX5b4DH+9mKlgyHkaC8bbst/FwbqwcFlsAgADoF1A=
Date: Wed, 1 Dec 2021 03:50:38 +0000
Message-ID: <DM6PR12MB2619D5D2F661DEC09E3A5016E4689@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211130074259.1271965-1-evan.quan@amd.com>
 <20211130074259.1271965-12-evan.quan@amd.com>
 <7405f5fb-1d74-40e1-0d1e-3b5f38c3597c@amd.com>
In-Reply-To: <7405f5fb-1d74-40e1-0d1e-3b5f38c3597c@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-01T03:50:35Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b233a35e-f415-4da6-942f-f78ecfa26b3e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96bd0b3b-b909-4df3-90e9-08d9b47dbd2e
x-ms-traffictypediagnostic: DM6PR12MB4220:
x-microsoft-antispam-prvs: <DM6PR12MB42205369E42083A8C4A27C9BE4689@DM6PR12MB4220.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pwrsAjzKioXuSB7MZTyhM64R43zFYGzhz+Bl064JUWMa/8/OHRSSM6EWPXQD2JT60yHsO+AnjsUk9s5/MWNepuapGDbTlNc8xAGjHDGoaUt5nDBICjFP0CN3mDB927A7NMO33DZAIOMaCttwasIDElGCv3ZrhMx5rEkUJLfn9HiFFB0zL4ufzuevcHaYuXCvL91NmZdQ1GpswDodxOBWNJI3atbMoUfjS+h9P3P42mIvxzBXyMSTQc2BY6gmLTcFgAsAsS7DppGTmu5TQnyPjVOiO4uXIzEuh92iQY/YMkwFr8pjk0c9aCJnsumVnF5Gbv3BwjOP+M8UXG+cqfaiNkyzDEGW316lDSQZKpH57vnwiHvXF8hDjXZWAF7GvTZSzCDxUFXrxzixBZ9Vt+oRWgSzYAK6qIQMfOByDTyeukd77/9LNayCMgviI/JQU8P/ZAQeGNMDN2TCquIg0RPDkjgcZBgcCJn3pVh8lfcVGgJDYMpUoUM+wJN45FIepZXXuuor/8WFOAdo9NtSL6IXPI4DjafDAYLdpqLJ+7eHL0cTHgfrZ2ZZbTAnbqPNW5lR10QJZsVHR422xg/KDznSAkOrzIVmN7tHrY8Qy52Kgxfxqnm3G5EmInwThZ5v7B/0IbzWZSAz1Zr3h6x4aeGmFRu5TOReqRxmfCbAZnA6QfrPRbEtE1k+iiBf4a9ife5zolZH0aWa+uyyZUAnpscruf7URHagXJheYy1ZQVWdUq0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(2906002)(38070700005)(186003)(508600001)(110136005)(316002)(66556008)(64756008)(66446008)(76116006)(66476007)(8676002)(66946007)(9686003)(8936002)(122000001)(54906003)(33656002)(38100700002)(55016003)(53546011)(6506007)(7696005)(86362001)(4326008)(5660300002)(71200400001)(83380400001)(52536014)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDBKeUxXUEdvL2s4cFBqSFl5YkFvN3J4Q0xqZXc4VFFNUUUwZHYxYlFuOXIr?=
 =?utf-8?B?ZXBMdUtPNGxYTVZDcHE1blcyb0RyTTJTYWZIeVFLRnpEZFU0aFhFRDBCME9K?=
 =?utf-8?B?N1BSTjdUUTgyUzRBZzllOUZQMGNCUUF2ekxUMmIvdkhRaDhVdE1kTG1iNTJ4?=
 =?utf-8?B?ODI1d01ubUZUZk5Vc0hzN1ByYktHQUFtcENuZllaMWlhMk5IdjVBQ3hYV2VF?=
 =?utf-8?B?K1hmVi9BaTNIdmc3aHdvRVVGa1NrR3E1VFcxTXlkdnA0SlUxUWtERjhFVTh4?=
 =?utf-8?B?Ni9aL3FhdUdCZWIxYXhSejRyd0VQUE8vV0JmZnJ0SVd0OGFKbjhKcFN5NW13?=
 =?utf-8?B?VWdmQW00T21TUDJQZk4rVnBzejVuNGovT1A4cnMrSXlaQnMwNWxwaGlwVGdy?=
 =?utf-8?B?U0V0Nm1YQzNyb2htRHBJbFRPNXZmcHltWGFMM2hWdEtiUk56Q0FST0M1c0xC?=
 =?utf-8?B?dlFUR3hoZ29wREEwOERsVGVkRUpJVmZvTGQ5QzNERU5wUEJpaUVON1lYNEht?=
 =?utf-8?B?YUNLb0NoTjBIdkhyMlVIQUcvTVlDVFRHdlpoR1c0b2NOLzkyQzRPTjhLTmVX?=
 =?utf-8?B?VVNreGFxRWtrUXNOaUw3WkNVV1ppd25neEw1UWp2MlpsM2wyYk9ZY0lvNkIx?=
 =?utf-8?B?MW5CbUlLVVlsZUVmaGNYUmgrd3hPRC8yZU1rc2NqWmFuQ1E5K2gvVVg2L1Uw?=
 =?utf-8?B?RjdIbTNMK1VWNDhYaWlnU2FBR0h0VnZLUXRQdGtLWmFvSTlBa2dleWQ1VjFS?=
 =?utf-8?B?NnI0Ulk2MHQyYXhkTmQ4Qkh0Z0xabnRNZnUrbGZ0dW1rSEpqSlpQdnZCVUJR?=
 =?utf-8?B?dktETlpXNVBxc1BPOU45eTdBTUtSYXFOc0NYaWZKaXkyNXorc3VBaitBQVJs?=
 =?utf-8?B?Z3ZWQllVSHVrbWdmRjV2b2dWY0JNdzIrUitzVlZDeFozR1lBN05pL1BncStV?=
 =?utf-8?B?S1VFeHFlUDhVTEF2dWg5TG15Tko5R3dlS0VqUms0QXVCelg0Sk1kdDc4UnYx?=
 =?utf-8?B?S25iNFZ2TjUyYWRVOUI0Ny9wTDFzVHQ4dTJ4d08rRFl4cDI4WmJNTE1JTHpE?=
 =?utf-8?B?UXFHNmJrdm0vajVnYnhPd05JRFpSUk90Q1Uwc29kSnhEVkhyWXBUY1VKUzFl?=
 =?utf-8?B?dmM3dmI3enVYNUdCM3lKVnhLdTJDUDRQTzNJRUJidWpjcHBYSWg0MlJTUndw?=
 =?utf-8?B?b1RUSGRZL1BXL1MzNDVNR0tScE5lYWUycHc1R3E1ejFyMWpEeFQxWXBnNlZz?=
 =?utf-8?B?Wmt3NlZwSURkNlJSUUViOXlyMHR0K2c5dk16ZmwxL0hEL0UycmZFdDJIWmNO?=
 =?utf-8?B?bjlwWHBpdmI3MEM4NC9rQmEzVzZZcnQ5UXdGcCtidmNrTzFUdEZaV25ocXdN?=
 =?utf-8?B?bUpNYThINGhtMDhHSjF2NDhXalZlUkNwejB4WWlGaUp4Q3lYV0FTMXJONjVy?=
 =?utf-8?B?bm5ISDIza0o5VW9kYTAxM29yNzFxT3pRTTlUUXQ5MFZER1YwRzlEenJwdXVX?=
 =?utf-8?B?OWt1d1dMQ21uZ1kzRWx5VFBuWW4xU0wzWFdEVGZVZkVhOXRHRGVWSVpJQnhZ?=
 =?utf-8?B?Z2dMaXBnZTlzakw2NDZCU2M0dEQ4dGVpdnZQUVdPTy9LV2p0dWN0Rk83QjBQ?=
 =?utf-8?B?VmdpWjR4bS83a0VsZmJickpKbXFTQk4wNmJ6MWZiSENlNFB4M0h1S2R3Nys1?=
 =?utf-8?B?dVRWMlF1c2JJVUdlRk12L2ZuSmV3NkRjM1lrMFJTa3NQdWVLT1c0SVROaXBh?=
 =?utf-8?B?Y3RpbnhGRkNFQjdCc3hVRkFnSUk2TDQvTCtQRHdFZzIvNk0yenJtUWxxYWZs?=
 =?utf-8?B?TzNkci9hVEFuSThLVUhkMS9RNjJDVlQrb1JHT3ovTU1HdWtBV3p0b2FWR3Nq?=
 =?utf-8?B?TFloVHBjWVcrMUpPMGp4ZTJYL2VQRUZuMCtiUTAxL3pFektSbEFMa0NWQXdK?=
 =?utf-8?B?cEpUSzlNZFFidWRmQnliTkFJRGRzRk8vb3RFVkFubXNBcWxYZDhKTnlOZWYz?=
 =?utf-8?B?TCtoZ1dmZmNxVnhQMHJjNXd3aXVjSGM4MVRCdkJMNWxHNWJ2d2JWTFFYUklj?=
 =?utf-8?B?dE5BdVp3TjlkbnFvRzBwNlBDNjAvb1pOVXRHak9xT1JObmwrWVdGOXNTS2xV?=
 =?utf-8?Q?+bJo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bd0b3b-b909-4df3-90e9-08d9b47dbd2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 03:50:38.5654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dF2ZqHxMYeh+TPAugw6BoFICWVejDG4tQF7baa+lGkTQ3caUWT+Qc3/R+9ASPKH/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogVHVl
c2RheSwgTm92ZW1iZXIgMzAsIDIwMjEgOTo0OCBQTQ0KPiBUbzogUXVhbiwgRXZhbiA8RXZhbi5R
dWFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3Rp
YW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IEZlbmcsIEtlbm5ldGggPEtlbm5ldGgu
RmVuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDExLzE3XSBkcm0vYW1kL3Bt
OiBjb3JyZWN0IHRoZSB1c2FnZSBmb3INCj4gYW1kZ3B1X2RwbV9kaXNwYXRjaF90YXNrKCkNCj4g
DQo+IA0KPiANCj4gT24gMTEvMzAvMjAyMSAxOjEyIFBNLCBFdmFuIFF1YW4gd3JvdGU6DQo+ID4g
V2Ugc2hvdWxkIGF2b2lkIGhhdmluZyBtdWx0aS1mdW5jdGlvbiBBUElzLiBJdCBzaG91bGQgYmUg
dXAgdG8gdGhlDQo+ID4gY2FsbGVyIHRvIGRldGVybWluZSB3aGVuIG9yIHdoZXRoZXIgdG8gY2Fs
bCBhbWRncHVfZHBtX2Rpc3BhdGNoX3Rhc2soKS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEV2
YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQo+ID4gQ2hhbmdlLUlkOiBJNzhlYzRlYjhjZWI2
ZTUyNmE0NzM0MTEzZDIxM2QxNWE1ZmJhYThhNA0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9hbWRncHVfZHBtLmMgfCAxOCArKy0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMgIHwgMjYNCj4gKysrKysrKysrKysrKysr
KysrKysrKysrLS0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTgg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9hbWRncHVfZHBtLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X2RwbS5j
DQo+ID4gaW5kZXggYzYyOTllNDA2ODQ4Li44ZjBhZTU4ZjQyOTIgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfZHBtLmMNCj4gPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL2FtZGdwdV9kcG0uYw0KPiA+IEBAIC01NTgsOCArNTU4LDYgQEAgdm9pZCBh
bWRncHVfZHBtX3NldF9wb3dlcl9zdGF0ZShzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwN
Cj4gPiAgIAkJCQllbnVtIGFtZF9wbV9zdGF0ZV90eXBlIHN0YXRlKQ0KPiA+ICAgew0KPiA+ICAg
CWFkZXYtPnBtLmRwbS51c2VyX3N0YXRlID0gc3RhdGU7DQo+ID4gLQ0KPiA+IC0JYW1kZ3B1X2Rw
bV9kaXNwYXRjaF90YXNrKGFkZXYsDQo+IEFNRF9QUF9UQVNLX0VOQUJMRV9VU0VSX1NUQVRFLCAm
c3RhdGUpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gICBlbnVtIGFtZF9kcG1fZm9yY2VkX2xldmVsDQo+
IGFtZGdwdV9kcG1fZ2V0X3BlcmZvcm1hbmNlX2xldmVsKHN0cnVjdA0KPiA+IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpIEBAIC03MjcsMTMgKzcyNSw3IEBAIGludA0KPiBhbWRncHVfZHBtX3NldF9zY2xr
X29kKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MzJfdCB2YWx1ZSkNCj4gPiAgIAlp
ZiAoIXBwX2Z1bmNzLT5zZXRfc2Nsa19vZCkNCj4gPiAgIAkJcmV0dXJuIC1FT1BOT1RTVVBQOw0K
PiA+DQo+ID4gLQlwcF9mdW5jcy0+c2V0X3NjbGtfb2QoYWRldi0+cG93ZXJwbGF5LnBwX2hhbmRs
ZSwgdmFsdWUpOw0KPiA+IC0NCj4gPiAtCWFtZGdwdV9kcG1fZGlzcGF0Y2hfdGFzayhhZGV2LA0K
PiA+IC0JCQkJIEFNRF9QUF9UQVNLX1JFQURKVVNUX1BPV0VSX1NUQVRFLA0KPiA+IC0JCQkJIE5V
TEwpOw0KPiA+IC0NCj4gPiAtCXJldHVybiAwOw0KPiA+ICsJcmV0dXJuIHBwX2Z1bmNzLT5zZXRf
c2Nsa19vZChhZGV2LT5wb3dlcnBsYXkucHBfaGFuZGxlLCB2YWx1ZSk7DQo+ID4gICB9DQo+ID4N
Cj4gPiAgIGludCBhbWRncHVfZHBtX2dldF9tY2xrX29kKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KSBAQCAtDQo+IDc1MywxMw0KPiA+ICs3NDUsNyBAQCBpbnQgYW1kZ3B1X2RwbV9zZXRfbWNs
a19vZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gdWludDMyX3QgdmFsdWUpDQo+ID4g
ICAJaWYgKCFwcF9mdW5jcy0+c2V0X21jbGtfb2QpDQo+ID4gICAJCXJldHVybiAtRU9QTk9UU1VQ
UDsNCj4gPg0KPiA+IC0JcHBfZnVuY3MtPnNldF9tY2xrX29kKGFkZXYtPnBvd2VycGxheS5wcF9o
YW5kbGUsIHZhbHVlKTsNCj4gPiAtDQo+ID4gLQlhbWRncHVfZHBtX2Rpc3BhdGNoX3Rhc2soYWRl
diwNCj4gPiAtCQkJCSBBTURfUFBfVEFTS19SRUFESlVTVF9QT1dFUl9TVEFURSwNCj4gPiAtCQkJ
CSBOVUxMKTsNCj4gPiAtDQo+ID4gLQlyZXR1cm4gMDsNCj4gPiArCXJldHVybiBwcF9mdW5jcy0+
c2V0X21jbGtfb2QoYWRldi0+cG93ZXJwbGF5LnBwX2hhbmRsZSwgdmFsdWUpOw0KPiA+ICAgfQ0K
PiA+DQo+ID4gICBpbnQgYW1kZ3B1X2RwbV9nZXRfcG93ZXJfcHJvZmlsZV9tb2RlKHN0cnVjdCBh
bWRncHVfZGV2aWNlDQo+ICphZGV2LA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL2FtZGdwdV9wbS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9w
bS5jDQo+ID4gaW5kZXggZmEyZjRlMTFlOTRlLi44OWUxMTM0ZDY2MGYgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYw0KPiA+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCj4gPiBAQCAtMTg3LDYgKzE4NywxMCBAQCBzdGF0
aWMgc3NpemVfdA0KPiBhbWRncHVfc2V0X3Bvd2VyX2RwbV9zdGF0ZShzdHJ1Y3QNCj4gPiBkZXZp
Y2UgKmRldiwNCj4gPg0KPiA+ICAgCWFtZGdwdV9kcG1fc2V0X3Bvd2VyX3N0YXRlKGFkZXYsIHN0
YXRlKTsNCj4gPg0KPiA+ICsJYW1kZ3B1X2RwbV9kaXNwYXRjaF90YXNrKGFkZXYsDQo+ID4gKwkJ
CQkgQU1EX1BQX1RBU0tfRU5BQkxFX1VTRVJfU1RBVEUsDQo+ID4gKwkJCQkgJnN0YXRlKTsNCj4g
PiArDQo+IA0KPiBUaGlzIGlzIGp1c3QgdGhlIG9wcG9zaXRlIG9mIHdoYXQgaGFzIGJlZW4gZG9u
ZSBzbyBmYXIuIFRoZSBpZGVhIGlzIHRvIGtlZXAgdGhlDQo+IGxvZ2ljIGluc2lkZSBkcG1fKiBj
YWxscyBhbmQgbm90IHRvIGtlZXAgdGhlIGxvZ2ljIGluIGFtZGdwdV9wbS4gVGhpcyBkb2VzDQo+
IHRoZSByZXZlcnNlLiBJIGd1ZXNzIHRoaXMgcGF0Y2ggY2FuIGJlIGRyb3BwZWQuDQpbUXVhbiwg
RXZhbl0gVGhlIHNpdHVhdGlvbiBoZXJlIGlzIA0KMS4gaW4gc29tZSBjYXNlcyB0aGUgYW1kZ3B1
X2RwbV9kaXNwYXRjaF90YXNrKCkgaXMgaW5jbHVkZWQvaW50ZWdyYXRlZC4gRS5nLiBhbWRncHVf
ZHBtX3NldF9tY2xrX29kKCkgYW1kZ3B1X2RwbV9zZXRfc2Nsa19vZA0KMi4gaW4gb3RoZXIgY2Fz
ZXMgdGhlIGFtZGdwdV9kcG1fZGlzcGF0Y2hfdGFzaygpIGlzIGNhbGxlZCBzZXBhcmF0ZWx5IC4g
RS5nLiBieSBhbWRncHVfc2V0X3BwX2ZvcmNlX3N0YXRlKCkgYW5kIGFtZGdwdV9zZXRfcHBfb2Rf
Y2xrX3ZvbHRhZ2UoKSBmcm9tIGFtZGdwdV9wbS5jIA0KVGhleSB3aWxsIG1ha2UgdGhlIHRoaW5n
IHRoYXQgYWRkcyBhIHVuaWZpZWQgbG9jayBwcm90ZWN0aW9uIG9uIHRob3NlIGFtZGdwdV9kcG1f
eHh4KCkgQVBJcyB0cmlja3kuIFRvIHJlc29sdmUgdGhhdCwgd2UgZWl0aGVyDQoxLiBzZXBhcmF0
ZSB0aGUgYW1kZ3B1X2RwbV9kaXNwYXRjaF90YXNrKCkgZnJvbSB0aG9zZSBBUElzKGFtZGdwdV9k
cG1fc2V0X21jbGtfb2QoKSBhbWRncHVfZHBtX3NldF9zY2xrX29kKCkpDQoyLiB0cnkgdG8gZ2V0
IGFtZGdwdV9kcG1fZGlzcGF0Y2hfdGFzaygpIGluY2x1ZGVkIGFsc28gaW4gYW1kZ3B1X3NldF9w
cF9mb3JjZV9zdGF0ZSgpIGFuZCBhbWRncHVfc2V0X3BwX29kX2Nsa192b2x0YWdlKCkNCkFmdGVy
IHNvbWUgY29uc2lkZXJhdGlvbnMsIEkgYmVsaWV2ZSAxIGlzIHRoZSBtb3JlIHByb3BlciB3YXku
IEFzIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIGFtZGdwdV9kcG1fc2V0X21jbGtfb2Qo
KSByZWFsbHkgY29tYmluZXMgdHdvIGxvZ2ljcyBzZXBhcmF0ZWx5IHRoaW5ncyB0b2dldGhlci4N
ClRoZSBhbWRncHVfZHBtX2Rpc3BhdGNoX3Rhc2soKSBzaG91bGQgYmUgc3BsaXR0ZWQgb3V0Lg0K
DQpCUg0KRXZhbg0KPiANCj4gVGhhbmtzLA0KPiBMaWpvDQo+IA0KPiA+ICAgCXBtX3J1bnRpbWVf
bWFya19sYXN0X2J1c3koZGRldi0+ZGV2KTsNCj4gPiAgIAlwbV9ydW50aW1lX3B1dF9hdXRvc3Vz
cGVuZChkZGV2LT5kZXYpOw0KPiA+DQo+ID4gQEAgLTEyNzgsNyArMTI4MiwxNiBAQCBzdGF0aWMg
c3NpemVfdCBhbWRncHVfc2V0X3BwX3NjbGtfb2Qoc3RydWN0DQo+IGRldmljZSAqZGV2LA0KPiA+
ICAgCQlyZXR1cm4gcmV0Ow0KPiA+ICAgCX0NCj4gPg0KPiA+IC0JYW1kZ3B1X2RwbV9zZXRfc2Ns
a19vZChhZGV2LCAodWludDMyX3QpdmFsdWUpOw0KPiA+ICsJcmV0ID0gYW1kZ3B1X2RwbV9zZXRf
c2Nsa19vZChhZGV2LCAodWludDMyX3QpdmFsdWUpOw0KPiA+ICsJaWYgKHJldCkgew0KPiA+ICsJ
CXBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3koZGRldi0+ZGV2KTsNCj4gPiArCQlwbV9ydW50aW1l
X3B1dF9hdXRvc3VzcGVuZChkZGV2LT5kZXYpOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKwl9
DQo+ID4gKw0KPiA+ICsJYW1kZ3B1X2RwbV9kaXNwYXRjaF90YXNrKGFkZXYsDQo+ID4gKwkJCQkg
QU1EX1BQX1RBU0tfUkVBREpVU1RfUE9XRVJfU1RBVEUsDQo+ID4gKwkJCQkgTlVMTCk7DQo+ID4N
Cj4gPiAgIAlwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5KGRkZXYtPmRldik7DQo+ID4gICAJcG1f
cnVudGltZV9wdXRfYXV0b3N1c3BlbmQoZGRldi0+ZGV2KTsNCj4gPiBAQCAtMTM0MCw3ICsxMzUz
LDE2IEBAIHN0YXRpYyBzc2l6ZV90IGFtZGdwdV9zZXRfcHBfbWNsa19vZChzdHJ1Y3QNCj4gZGV2
aWNlICpkZXYsDQo+ID4gICAJCXJldHVybiByZXQ7DQo+ID4gICAJfQ0KPiA+DQo+ID4gLQlhbWRn
cHVfZHBtX3NldF9tY2xrX29kKGFkZXYsICh1aW50MzJfdCl2YWx1ZSk7DQo+ID4gKwlyZXQgPSBh
bWRncHVfZHBtX3NldF9tY2xrX29kKGFkZXYsICh1aW50MzJfdCl2YWx1ZSk7DQo+ID4gKwlpZiAo
cmV0KSB7DQo+ID4gKwkJcG1fcnVudGltZV9tYXJrX2xhc3RfYnVzeShkZGV2LT5kZXYpOw0KPiA+
ICsJCXBtX3J1bnRpbWVfcHV0X2F1dG9zdXNwZW5kKGRkZXYtPmRldik7DQo+ID4gKwkJcmV0dXJu
IHJldDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlhbWRncHVfZHBtX2Rpc3BhdGNoX3Rhc2soYWRl
diwNCj4gPiArCQkJCSBBTURfUFBfVEFTS19SRUFESlVTVF9QT1dFUl9TVEFURSwNCj4gPiArCQkJ
CSBOVUxMKTsNCj4gPg0KPiA+ICAgCXBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3koZGRldi0+ZGV2
KTsNCj4gPiAgIAlwbV9ydW50aW1lX3B1dF9hdXRvc3VzcGVuZChkZGV2LT5kZXYpOw0KPiA+DQo=
