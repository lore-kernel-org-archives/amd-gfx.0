Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEB3C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 06:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D194B604AC
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 06:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D194B604AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56BF86E2D7;
	Tue,  5 Oct 2021 06:30:08 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B816E2D7
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 06:30:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWWXLHLIdRr79Wa4gZVfQhHl7zhijs8tx4l37Ob0Wj5eTwZwbyP5BX8F2R66A4lmtXy8l9atHINOF3gMxLq8UezLoQnSaupypYBJq0P3aRGddNl5JqHcTjANzeLrbuoI2di52jbkcxR7NhiuvCu387f0oTVRuxaXpGriCmfVawsCkdo08EwkRsw/Kd6in3N6Dcae9gPtnyGw1dg/LjLRbcOWTHwws9ROYCvJ/OTAL9GhKQeQmkjOpPWSiH+hh8jHjZT8hNCIoM6L6cSeipECxMeMlrsZSM6v8dkpkfSEAdMoUs42rHEmGBxi71gFB3sMMzkBibSt3Q7LHQ06IkL+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ChIbdnBUajPatPsz8RX58/Vyf0v3dFZPRwf5DtxNEc=;
 b=LzXy5OWmM8Qicrod95kNr619s5QE4MTYQTG+T4x35LPhbXSMMieemmLWbs8mrLNUTI5GZUunRuYwE6PinN7kTjpax72RDAURDx0rWe4ufH0IOS9avHSqG1mzqPcDmGmb8DRDmjybSIQ4EH+xGuDtdbkfVPsZRgVuWJHp5jT/5n+X5yTZrqkgjdTCP3CdHduiRrSxlfFVB4+bXs/Eyn4q86S83/Ih6mWtuZTXlOZ8weiDioJegBKiVEva1Nr6+MHjenBoEhhLHHg8xR1GjWujfNdBsX7win+dZzDp7Ij+/05Huu78zPzeEyK7RIzvgr4cpjYIvHGZChRoHHkoIYGHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ChIbdnBUajPatPsz8RX58/Vyf0v3dFZPRwf5DtxNEc=;
 b=eOZ3ZZP90VY3nF4YwtCuWF3mPcaDRvNBIDOdLDvBAgfbf8SlP1wG4Kns0d6mI65rMAyEw5lv2pNSus7dDXlkVYfBwvdxXxYewihvd4V59o62qRy/J7QE3hpPDWUrB6pMHVHWLvo3PUMOqGaMRX1m2HgMSwn4OzA1LINJx8avtsU=
Received: from CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18)
 by CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 06:30:05 +0000
Received: from CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::14f7:9173:d617:e87c]) by CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::14f7:9173:d617:e87c%2]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 06:30:05 +0000
From: "Lin, Wayne" <Wayne.Lin@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>, "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>,
 "Shih, Jude" <Jude.Shih@amd.com>, "Kizito, Jimmy" <Jimmy.Kizito@amd.com>,
 "Somasundaram, Meenakshikumar" <Meenakshikumar.Somasundaram@amd.com>
Subject: RE: [PATCH 00/23] USB4 DP tunneling
Thread-Topic: [PATCH 00/23] USB4 DP tunneling
Thread-Index: AQHXuS3fyIf3RRq6C0KGrOzsGBYTQ6vC61GAgAEFSaA=
Date: Tue, 5 Oct 2021 06:30:04 +0000
Message-ID: <CO6PR12MB548955FAC50658254532DDC0FCAF9@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20211004144050.3425351-1-Wayne.Lin@amd.com>
 <51f9eff8-02d6-0be2-b7b1-8fc226020a6a@amd.com>
In-Reply-To: <51f9eff8-02d6-0be2-b7b1-8fc226020a6a@amd.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1ee138a0-7743-413b-8000-c288653a9e90;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-05T06:23:34Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd6e5513-1677-4683-654f-08d987c991c1
x-ms-traffictypediagnostic: CO6PR12MB5394:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB5394772D16FBFCC47EF6A691FCAF9@CO6PR12MB5394.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 76fglhOlAiB5zeL46/hmSI294UxXUQcXMl/wOZc/off7bpz77ArU1BJ2SPWAwWitgz1OldSWQnIbnUagUo/A0yTbYC12OP8tnlRyqpN02nZiNdmH6QmN+alHLtdqUxlsTk6yOD7ghlBtcydDAa9LscHCjEyehkHEHYi+qvDAwVcMSwct/zGJdlQqbo7lEMZS8exBw99iW/N+Wy1LsiDfyurNCYib/s2Qni05wc1MMY1bVWqd/FAI7IV6le5JrMk9VoR5q3pcODiIih5frMjpMQF086ky0IRhZLKABLMGPpcIWNRBt0V6OKGi1qZFWtnGGxkl/bluOuts1lG91toTiqKLhohwg8YveJGqeP3d5hfiEGAJ1w5VnGikpW+NyXnDrXk2f+cXPANFMic7zXYpjoiasmU8Z5OHv5i24japhsB6BSCB1R4jp+cyuNhBtO8k9Zsn5caZMf3PxVxI929z8tkKMNBWki7+okcZhXSVjXzDNO4RoTpLBbB1gcqmIgTSAXAq6BtfB6stEHiGIAbENHGc7vcAMW2qROuR4FR3lkIZzULGOzrwhDWaGppu80p1tFeKQMaOmH4oGTe1318tqkztkyg7HPsElA+2oHwB4V5oeVZK5jd3/cUK/yACpCx6rVIGLJviVaIPfxS4bSzA7EVblVroSuLNGIdXWayCZ7J43bpv1OijKqxI9r4sclnxN6ibx8kieR9joW30ZGG9HA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5489.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016002)(54906003)(186003)(86362001)(83380400001)(26005)(316002)(71200400001)(508600001)(52536014)(110136005)(8936002)(33656002)(6506007)(7696005)(38100700002)(66446008)(4326008)(76116006)(66946007)(122000001)(9686003)(38070700005)(2906002)(53546011)(64756008)(5660300002)(8676002)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0c1VHorMzFLdWFveXFLdXZyZ3g5N090MzhPZHFzZXpWWitEeUticjc0Mlkx?=
 =?utf-8?B?a1NiaXpYK3FNZzdpRXh6RnVzVmd0YVpQRWw4U1RGN3dlVEV2bzQ0eHJpNlg5?=
 =?utf-8?B?TDRDam9iQ2plSmliV1g0RmFjUk5KWkMvMGttbEsza293QmQ0SXVjUFU2NVJH?=
 =?utf-8?B?OWFkRWo2UDhJcExLNWJjcHozTXZiWlMrVmp2YWxXbWhWSXVUUWk3VER1Qi9H?=
 =?utf-8?B?dkZTdlp1aHhSWWxlRjZhNHd5SXJSSXhEV1FxV2JPb0ZJb1h4M0xWeWl6aDdq?=
 =?utf-8?B?Szh2dFJ0QkhNdENqZ1Izd2F1eDhXMC94VnMyQVlQY2FRSWczT1lsK1BNbEYy?=
 =?utf-8?B?ME9BZFBDaDJsTWN4YzJVaDllSS9lODhDWWpZU1JoZm1oVHRQUW4rQmdWVDFa?=
 =?utf-8?B?bTFKNDFmV3RtQ0FHZm1xSVM4Y1dpQlEwaWVSRGRyUHRNa21FdThLdDRmVXJl?=
 =?utf-8?B?U08ya2ZrS2xyWUFMMFNHbm9SSjVFTzBEU3hqTUR4Q2VBcWhCOUtQYzhZYjdE?=
 =?utf-8?B?WXdhLzRaNEN4QmRGVGJjTzFNbGxXaEpxWTRjVVNHckVHa1hCUGR3emdSWjJP?=
 =?utf-8?B?ZllTSDU1SXV5cG1nZUlrVHRtY3BwbWRtL2JJUkpSTHRNQ2h1MUtzMGJtL3FN?=
 =?utf-8?B?U0IxUUtKSGh1d3plbFFFZzdPdzY2ODh0OWN3dTFRZHV3ajEvZEcvZktCQ0VG?=
 =?utf-8?B?MlhsSFdVUWlWcXRocDR3NmFQYWRzUlJoQ2doNElSMkEyVDdqNmxtT0liWUIw?=
 =?utf-8?B?RGdGd3VvaDN0WDBiZk11azU3aFovMExuSVp6TnBUMUFucDBPNTNBSXNDanIy?=
 =?utf-8?B?c29kQlhEYWxjRkI2QUtsU3FsQlpsc0QwbFNjcjI5WXFxVElBblJCOXVzSndM?=
 =?utf-8?B?VFoyRUJ3WjJUR0oxUzZqb2pXWTZ4U3pwemZvUWx5LytiNXFETHQrYmVYUlpP?=
 =?utf-8?B?QnlqaUNjNWFYdSs4K2YzY0lKemdJTlZsMjlCdEI4SG54aC83RlVjZTB4M0t5?=
 =?utf-8?B?L2cvVmtUR3RVM09rVUQwVnVYM2R4TElmOGpoNExkNGFtVUl3djlxc3F5NVBG?=
 =?utf-8?B?NzJCM1NqYkVZZWxKb3F2L1VGdGR0V0VWeGhuVjlqY3BXTUcvVXJFekdXMmlm?=
 =?utf-8?B?RW1tTTZ5YjFSdTlpYVRMODNrdUx0K3Uvd3ZRbmJPWjR0WTRPbTRPZVgzM1Q2?=
 =?utf-8?B?aXlpWUh0YXpiaCtkcG90Q2s5WW9NOEVSdGlnbHpqTVZaSGFEOTB3cndwOERr?=
 =?utf-8?B?Z1Jpdzd1VWZlY1dYZHZMMDdMOXB1L2Z2STV1MG8rZ0JXMHVUZksyOFFGYTY5?=
 =?utf-8?B?TzVUNnlZaDZkSjdlOEpBOWhlbDdnbXNvM0ZWM0xablpHTHhUVHE5TWVzSCsw?=
 =?utf-8?B?aUtGTEt5OCs3R2E4ZUVxMEdZM09GYnFmUUgwTGFVbGtJWFIvdzI0MTJsamhj?=
 =?utf-8?B?cjFLUDg0UDhsVTY4TStkNEVmL1A0SkVRUFZ4aU9qQmlHTWVBUnBvUHFoNnlz?=
 =?utf-8?B?blF6MCtobHVSM09IZ1VFRzJHUUxHdUVCUjl6VjhYNjRJM2dWWkY0YVV1YVpI?=
 =?utf-8?B?Z1Y2aWJxak9mMGkwMkNFcXIzZ3o5dnNuTHV1czR5ek0wR1NIbWo5TEt6d1I1?=
 =?utf-8?B?WnFLVDV4NklZMjhjNWM0YXVpdUkyT1ROeWFOOWRsRzNWVDB3QUVETmdIbnZt?=
 =?utf-8?B?Y3hWeU1tVlkrUi9lcUNTS1hkalBDUUFSd1l0UmRpM1FqSEh1UWVOTnhNUndJ?=
 =?utf-8?Q?VpCj8U7mYXHoJOUriMfys+jYXHdtkk0/lFBZjSi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5489.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6e5513-1677-4683-654f-08d987c991c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 06:30:05.0713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZwIq888otbn6SjydQb3lRndUZwvw9zTsDsLOBd8qHXR98qO84GHAT0tjs0+Aq3MazfS8M1+UjFT2wloQDJS+yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5394
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXZW50bGFu
ZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2Jl
ciA0LCAyMDIxIDEwOjQ4IFBNDQo+IFRvOiBMaW4sIFdheW5lIDxXYXluZS5MaW5AYW1kLmNvbT47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIg
PEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLYXpsYXVza2FzLCBOaWNob2xhcyA8TmljaG9s
YXMuS2F6bGF1c2thc0BhbWQuY29tPjsgU2lxdWVpcmEsIFJvZHJpZ28NCj4gPFJvZHJpZ28uU2lx
dWVpcmFAYW1kLmNvbT47IFdhbmcsIENoYW8ta2FpIChTdHlsb24pIDxTdHlsb24uV2FuZ0BhbWQu
Y29tPjsgU2hpaCwgSnVkZSA8SnVkZS5TaGloQGFtZC5jb20+OyBLaXppdG8sIEppbW15DQo+IDxK
aW1teS5LaXppdG9AYW1kLmNvbT47IFNvbWFzdW5kYXJhbSwgTWVlbmFrc2hpa3VtYXIgPE1lZW5h
a3NoaWt1bWFyLlNvbWFzdW5kYXJhbUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAw
LzIzXSBVU0I0IERQIHR1bm5lbGluZw0KPg0KPg0KPg0KPiBPbiAyMDIxLTEwLTA0IDEwOjQwLCBX
YXluZSBMaW4gd3JvdGU6DQo+ID4gVGhlc2Ugc2VyaWVzIHBhdGNoZXMgYXJlIGZvciBzdXBwb3J0
aW5nIFVTQjQgRFAgdHVubmVsaW5nIGZlYXR1cmUuDQo+ID4NCj4NCj4gQ2FuIHlvdSBwcm92aWRl
IGEgZGVzY3JpcHRpb24gKHdpdGggb3Igd2l0aG91dCBkaWFncmFtcykgb2Ygd2hhdA0KPiBEUDQg
dHVubmVsaW5nIGlzIGFuZCBzb21lIG9mIHRoZSBrZXkgcGFydHMgb2YgaG93IGl0IHdvcmtzPw0K
VGhhbmtzIEhhcnJ5LCB3aWxsIGdpdmUgYSBzaG9ydCBkZXNjcmlwdGlvbiBhYm91dCBVU0I0IERQ
IHR1bm5lbGluZy4NCg0KPg0KPiBEb2VzIHRoaXMgcGF0Y2hzZXQgaGF2ZSBkZXBlbmRlbmNpZXMg
b24gcGF0Y2hlcyBpbiB0aGUgVVNCIHN1YnN5c3RlbT8NCkFGQUlLLCBVU0I0IHJlbGV2YW50IHBh
dGNoZXMgYXJlIGFscmVhZHkgaW4gdGhlIFVTQiBzdWJzeXN0ZW0uIFNob3VsZCBoYXZlDQpubyBk
ZXBlbmRlbmNpZXMgaGVyZS4NCg0KVGhhbmtzIQ0KPg0KPiBIYXJyeQ0KPg0KPiA+IC0tLQ0KPiA+
DQo+ID4gSmltbXkgS2l6aXRvICgxNCk6DQo+ID4gICBkcm0vYW1kL2Rpc3BsYXk6IFVwZGF0ZSBs
aW5rIGVuY29kZXIgb2JqZWN0IGNyZWF0aW9uLg0KPiA+ICAgZHJtL2FtZC9kaXNwbGF5OiBTdXBw
b3J0IFVTQjQgZHluYW1pYyBsaW5rIGVuY29kZXIgc2VsZWN0aW9uLg0KPiA+ICAgZHJtL2FtZC9k
aXNwbGF5OiBTdXBwb3J0IFVTQjQgZm9yIGRpc3BsYXkgZW5kcG9pbnQgY29udHJvbCBwYXRoLg0K
PiA+ICAgZHJtL2FtZC9kaXNwbGF5OiBTdXBwb3J0IERQIHR1bm5lbGluZyB3aGVuIERQUlggZGV0
ZWN0aW9uDQo+ID4gICBkcm0vYW1kL2Rpc3BsYXk6IFVwZGF0ZSB0cmFpbmluZyBwYXJhbWV0ZXJz
IGZvciBEUElBIGxpbmtzDQo+ID4gICBkcm0vYW1kL2Rpc3BsYXk6IFN1cHBvcnQgVVNCNCB3aGVu
IERQIGxpbmsgdHJhaW5pbmcuDQo+ID4gICBkcm0vYW1kL2Rpc3BsYXk6IEltcGxlbWVudCBEUElB
IHRyYWluaW5nIGxvb3ANCj4gPiAgIGRybS9hbWQvZGlzcGxheTogSW1wbGVtZW50IERQSUEgbGlu
ayBjb25maWd1cmF0aW9uDQo+ID4gICBkcm0vYW1kL2Rpc3BsYXk6IEltcGxlbWVudCBEUElBIGNs
b2NrIHJlY292ZXJ5IHBoYXNlDQo+ID4gICBkcm0vYW1kL2Rpc3BsYXk6IEltcGxlbWVudCBEUElB
IGVxdWFsaXNhdGlvbiBwaGFzZQ0KPiA+ICAgZHJtL2FtZC9kaXNwbGF5OiBJbXBsZW1lbnQgZW5k
IG9mIHRyYWluaW5nIGZvciBob3AgaW4gRFBJQSBkaXNwbGF5DQo+ID4gICAgIHBhdGgNCj4gPiAg
IGRybS9hbWQvZGlzcGxheTogUmVhZCBVU0I0IERQIHR1bm5lbGluZyBkYXRhIGZyb20gRFBDRC4N
Cj4gPiAgIGRybS9hbWQvZGlzcGxheTogRml4IERJR19IUERfU0VMRUNUIGZvciBVU0I0IGRpc3Bs
YXkgZW5kcG9pbnRzLg0KPiA+ICAgZHJtL2FtZC9kaXNwbGF5OiBBZGQgZGVidWcgZmxhZ3MgZm9y
IFVTQjQgRFAgbGluayB0cmFpbmluZy4NCj4gPg0KPiA+IEp1ZGUgU2hpaCAoNCk6DQo+ID4gICBk
cm0vYW1kL2Rpc3BsYXk6IFN1cHBvcnQgZm9yIFNFVF9DT05GSUcgcHJvY2Vzc2luZyB3aXRoIERN
VUINCj4gPiAgIGRybS9hbWQvZGlzcGxheTogRGVhZGxvY2svSFBEIFN0YXR1cy9DcmFzaCBCdWcg
Rml4DQo+ID4gICBkcm0vYW1kL2Rpc3BsYXk6IEZpeCBVU0I0IEF1eCB2aWEgRE1VQiB0ZXJtaW5h
dGUgdW5leHBlY3RlZGx5DQo+ID4gICBkcm0vYW1kL2Rpc3BsYXk6IFVTQjQgYnJpbmcgdXAgc2V0
IGNvcnJlY3QgYWRkcmVzcw0KPiA+DQo+ID4gTWVlbmFrc2hpa3VtYXIgU29tYXN1bmRhcmFtICg1
KToNCj4gPiAgIGRybS9hbWQvZGlzcGxheTogVVNCNCBEUElBIGVudW1lcmF0aW9uIGFuZCBBVVgg
VHVubmVsaW5nDQo+ID4gICBkcm0vYW1kL2Rpc3BsYXk6IFN1cHBvcnQgZm9yIERNVUIgSFBEIGFu
ZCBIUEQgUlggaW50ZXJydXB0IGhhbmRsaW5nDQo+ID4gICBkcm0vYW1kL2Rpc3BsYXk6IFN1cHBv
cnQgZm9yIFNFVF9DT05GSUcgcHJvY2Vzc2luZyB3aXRoIERNVUINCj4gPiAgIGRybS9hbWQvZGlz
cGxheTogQWRkIGRwaWEgZGVidWcgb3B0aW9ucw0KPiA+ICAgZHJtL2FtZC9kaXNwbGF5OiBGaXgg
Zm9yIGFjY2VzcyBmb3IgZGRjIHBpbiBhbmQgYXV4IGVuZ2luZS4NCj4gPg0KPiA+ICAuLi4vZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAxMDYgKy0NCj4gPiAuLi4v
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmggfCAgMTIgKy0NCj4gPiAu
Li4vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZWxwZXJzLmMgfCAgMTcgKy0NCj4g
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL01ha2VmaWxlICAgICAgIHwgICAyICst
DQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgICAgICB8IDE3
OSArKystDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsu
YyB8ICA4MSArLQ0KPiA+ICAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtf
ZGRjLmMgfCAgIDkgKy0NCj4gPiAgLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19s
aW5rX2RwLmMgIHwgIDM2ICstDQo+ID4gIC4uLi9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19s
aW5rX2RwaWEuYyAgICB8IDk0NSArKysrKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfc3RhdC5jIHwgICA4ICsNCj4gPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmggICAgICAgICAgIHwgIDIyICsNCj4gPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX2RwX3R5cGVzLmggIHwgIDMxICsNCj4gPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX3R5cGVzLmggICAgIHwgICAxICsNCj4gPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYXV4LmMgIHwgICAzICsNCj4g
PiAgLi4uL2Rpc3BsYXkvZGMvZGNuMzEvZGNuMzFfZGlvX2xpbmtfZW5jb2Rlci5jIHwgMTI2ICsr
LQ0KPiA+ICAuLi4vZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjMxL2RjbjMxX2h3c2VxLmMgICAgfCAg
IDYgKw0KPiA+ICAuLi4vZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjMxL2RjbjMxX3Jlc291cmNlLmMg
fCAgIDcgKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1faGVscGVycy5o
ICAgfCAgIDUgKw0KPiA+ICAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9pbmMvY29yZV90eXBl
cy5oICAgfCAgIDMgKw0KPiA+ICAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9pbmMvZGNfbGlu
a19kZGMuaCAgfCAgIDEgKw0KPiA+ICAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9pbmMvZGNf
bGlua19kcGlhLmggfCAgOTggKysNCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2luYy9yZXNvdXJjZS5oIHwgICAxICsNCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL29zX3R5cGVzLmggICAgIHwgICAxICsNCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RtdWIvZG11Yl9zcnYuaCAgIHwgICAzICsNCj4gPiAgLi4uL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZG11Yi9pbmMvZG11Yl9jbWQuaCAgIHwgMTEzICsrLQ0KPiA+ICAuLi4vZ3B1L2RybS9hbWQv
ZGlzcGxheS9kbXViL3NyYy9kbXViX2RjbjMxLmMgfCAgIDEgKw0KPiA+ICAuLi4vZHJtL2FtZC9k
aXNwbGF5L2RtdWIvc3JjL2RtdWJfc3J2X3N0YXQuYyAgfCAgMTYgKw0KPiA+ICAuLi4vZ3B1L2Ry
bS9hbWQvZGlzcGxheS9pbmNsdWRlL2RhbF9hc2ljX2lkLmggfCAgIDIgKy0NCj4gPiAgMjggZmls
ZXMgY2hhbmdlZCwgMTc5MyBpbnNlcnRpb25zKCspLCA0MiBkZWxldGlvbnMoLSkgIGNyZWF0ZSBt
b2RlDQo+ID4gMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xp
bmtfZHBpYS5jDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvaW5jL2RjX2xpbmtfZHBpYS5oDQo+ID4NCi0tDQpSZWdhcmRzLA0KV2F5bmUNCg==
