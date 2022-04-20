Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BE6C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 06:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0157010F17B;
	Wed, 20 Apr 2022 06:21:21 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 374EB10F17C
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 06:21:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/sHME5RUNwELvU70y94t41156cG4eiRUe+ii9sk8p2ewTBcCZKHCS+r+LEb/Cr4H9UxD+e93CP76+GiKzLX5sEM573h0VSmDibDglZKHnAaFsmyEM1T82RPKCOsYV3C2bgdJgzu35rDOO5ssnvJrAwqqudbazOvgixUMO4HmTqrWf3XpooR4/odbQYTTZ/MFZETYlM27j+vk5aVvWDWyaHslDHTj218mcTDo6xDUKGlunB0YnQEAFyHmNZj9/1JmocpkTS/idBoaq8/sR8uLUTCsGxWcMqxPcCN502uHra4ZOgkwBkYiM2l7RIKzvCJjTID3z5lCgCwRA7a1PGBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGdRJExst1N9DcASx4/3uCSPiu/2fjofQTgqsaaiHCo=;
 b=eBDjDwh1ruuV/AGxJkDnjA8wlftOvYS6WECc7raHUa+LsSBtmIuGOlYelo+7LJ5BLlj0TGqrf/En8lb4fz+9MeJsd2i8/KmGZIXqvOiF9H70WeiPuC8yG5Bm22K/9kzVf0f3yYJbINa/VsJQHupMTP+6LUtDFMML4X78avS60jiQevQm7y1z/XB6SLdFcTXJjIxmlM6lmUxm6ELhhEoeQ1IbyVBZSttJ7uf+HpAsKRy0+G6V2UgvIPoUKW4wZOiTOIO0wp9wv4JcRPbNp2TzSK1Qa9B4U1HC05K2q32TSQshFIlgMD/HS1JByeDgB/rVpxhxn9O5BHzl4upd38TL3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGdRJExst1N9DcASx4/3uCSPiu/2fjofQTgqsaaiHCo=;
 b=TYhhk3olrWQMmydwueCcMC2HFmiwrTevP0Vehzl30MT1QdWMAZYKJkHYlNiCm+TLKP0QzirCFoMuFm7lT/h7AdJKACeIzAU8mFfAhMUUtfMsMoP6KfnHgAXSlna4Mt10Gb7bJExFNou3cj5SrcQSVlTvySC+mYA3xbR8nlrFgo8=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by MN2PR12MB3966.namprd12.prod.outlook.com (2603:10b6:208:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 06:21:16 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::6191:648d:c4a:dff]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::6191:648d:c4a:dff%7]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 06:21:16 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Ziya, Mohammad zafar"
 <Mohammadzafar.Ziya@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: add RAS poison consumption handler
Thread-Topic: [PATCH 2/3] drm/amdgpu: add RAS poison consumption handler
Thread-Index: AQHYVGo5c/F2kcTMF0KhAUXbK0fsX6z4NqoAgAAc7oA=
Date: Wed, 20 Apr 2022 06:21:16 +0000
Message-ID: <DM5PR12MB1770502A0980D9DCA57FCC6AB0F59@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220420035317.4008-1-tao.zhou1@amd.com>
 <20220420035317.4008-2-tao.zhou1@amd.com>
 <5f79e645-316a-0afe-c91d-33e57fdf9ca7@amd.com>
In-Reply-To: <5f79e645-316a-0afe-c91d-33e57fdf9ca7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-20T06:21:13Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b9ac1aa9-7de5-43a4-9c14-64d3109d0f21;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-20T06:21:13Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: d0a8d285-d636-46e2-baf6-f9590a7726a9
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20df80c1-19ba-4fb8-eb1e-08da2295fa1c
x-ms-traffictypediagnostic: MN2PR12MB3966:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3966F6D7B00EEF2B2AEF98FCB0F59@MN2PR12MB3966.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Is634lPXHwIkx4Kz0oDFgMJJyQqeztUvrl7yes31uFygEUPX4dCAV5PPAKQ9zXJUbQEg7n5mm04zce8Mt3MVWkZrE4I9gM6yjQlzqZazsPglp+HGiiY7mc7SHH9IT4vcqRkU1COJeBMwjql9Jmfe+k2FaAIlbwvg22KJRoQSUYm4Hw97nK9y5JVDdEi8HGB6hqtwVkjxTMClvuSaWjvXywR+OjejNgUONSZ2T//VTZnSonGskLE2vzy9DFZB0TOYsFr2g/HkTqSrE4dNhJkvLCWLgydb2bmG+C9O4E+Rr6XZ8y6oW3526ZzmDuXXgFKzemutHv7YOfoOlIp4m9Hb6blWyqsXa2ihEuNc71nJ/k/Z4nCfkM4BHCDl5VFeDpbSb7VVXsY2tcebxo7iLtRdOYwayW5cc2go3C32JG8WPAthm76EH20u5DVqxM+Z3ti5BQI8EYhDCommqT1niArrWmodehMvtVDblOnbmheLcmRre9vknyYjmK2FPEmucEJkL2GNz+GQvb2tIWiEpIXez56iF+BaNlCe32554ERn7UtHQP0Y4vAEhnFFt+1y4TtZDkHUTVP6LHinOXL5dzUNRFNqdOuRjD6tOeGYqTu9lPoY3jsUnUbUJvCbG8ew63/xab8TTbUgTgLn/5fTfGAFEUalNYUSVbVAB8ergiE3p+nek971M5lrZ+MwSowrdREfAzro6RAWTLrzAD7r4j2ZGiv+PcaJJGYeBM+rtpMBbAk3w9NIxYBEUEIFKmXKP6aI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(6506007)(316002)(53546011)(55016003)(6636002)(122000001)(76116006)(38070700005)(921005)(71200400001)(7696005)(9686003)(33656002)(66946007)(66476007)(66446008)(66556008)(8676002)(52536014)(83380400001)(38100700002)(5660300002)(8936002)(508600001)(64756008)(86362001)(2906002)(110136005)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHdHc29IU1NYRzc3Rkl5dFZXYUErWTgrZExGeWZXUGpVcGJqQ3ZPVkFlZWJz?=
 =?utf-8?B?emcyV3lYT1R5OUhtVzhjTUw0U0FaeXlsa3NEbUZsekZSK0xVUFFwbGpqQlZV?=
 =?utf-8?B?cUFNblREZko2dlIwQWl5Nk05OHZSaks2REIvOGd0VjZWeVlNL0FGY2ZlL3RC?=
 =?utf-8?B?aGYxNzRianY2QVY1MHQ4d0VxcGVSNkVUVm16STU4RzBUSzNxU3ZMUGdxUWxn?=
 =?utf-8?B?R2REajJnamtvdVhiMUZoMVZHVnFGRitib2xWS01JWnBrb1dXTnBWZXF5TGRW?=
 =?utf-8?B?bXhWaHVMNVVrNER2VFI1K3JNYkJNSktXcnptU3dOQ0dsNVJmTERjdWpMakxL?=
 =?utf-8?B?ZEZ3cVFjU1NRZjRYY1pURno4aWtENlBBa2EySHgyNnhzeU1zckpSNURUVGM4?=
 =?utf-8?B?VE9Za2VJWUxKbjZIbjh5dFllTmhnZVBTM3VMRHcvRmpuY2hvRTJKa2ZJcmZZ?=
 =?utf-8?B?cGl6TFhEOGMySkMyMzFUb1kyZWVTK0t6T1UwQzVnTHI3M0NsalBKQjFTV1c0?=
 =?utf-8?B?bTNTazF0MlhNVGtORGxkVXZTL1AxRC9vbVo4NUNZK2VrZ3U2OHNudStNUDhv?=
 =?utf-8?B?Qkh6SkFBNUVoa0dkUlRORDNFemkwcTl2RmxjODdXWWdHT3ZTTllJYk1BSGVG?=
 =?utf-8?B?QzY5YlVqdVE3U0R0ZDlMc2tJenFoK203aEU0L04vUTBVUFhhU2FhYnlYc3VD?=
 =?utf-8?B?WDlwVndqUDh1VU9ZQURKVGU0eTV6cUxJbE5aVlhuTFFjSWc1ZmdWUE1QNWxF?=
 =?utf-8?B?SE00bjdtbUtJTzBPOWVLWVFNR1JtM3I5VTNhVk45c0NGelZKSk1JdW41Qmsw?=
 =?utf-8?B?ZGZQRVJjek5kYTF1aVo1THlTY2QySHhYd01sNGkrZEdVbjl0eGplRlptaHdS?=
 =?utf-8?B?K2VxM0d2ZjBLZVFncXhwN05CZEpIRU5QNDNUdEdpSVV2NUlEVnVBUFY5YkFW?=
 =?utf-8?B?UUxkVmxsWjZMUzVtc0szbTY0WXU4Myt2NGVSQWZMOVp6eXJmeGtZREpnUjll?=
 =?utf-8?B?OU9oQ3lRVEZxeGNYU1l5dGo1dGVGNkdkT3BYWS9MWlRzM1ZFVHI5U09Rd1Fx?=
 =?utf-8?B?MDVrZmhsaDBCMWtHNmRJVnlVOXAxRmdJaUpjZ0pRMTNoSkxBcFpTeWNsMml4?=
 =?utf-8?B?SWthcjliZDRvMEZUOGZEV1c5c1owRmhkTjZvdDhFbU9mcUN5NWJJRXcrbEJs?=
 =?utf-8?B?dEFMRk1QVHc1ZGNIQXlPMUdKNmJmMkVvQU9SUUtQUlU4WGZqS2drVllncTJq?=
 =?utf-8?B?b0d2VTBTNFowV1lDWi8yQW0rbWRlSmgrREdFK0RjeFZZWit3bEZpdU16ZzRR?=
 =?utf-8?B?TEF6REVxZERPY1ZkekRrdDlDelJwbHFodDRDWU9qeXd6bjY1OHRablJGZ1VU?=
 =?utf-8?B?TjlueW9uVjBLNGsvY3RMOGw5MWdSRHpsZ253OGU3bGhNTXN4UXpYV0tLcHpP?=
 =?utf-8?B?YzJXVllNNlQwL2I5anJ6a0g1a3lscllndnlwS3oxc05maWppUVVsVXhiZDlx?=
 =?utf-8?B?V0JBNEs3cG56cUdrOTlud1RCYWpkRHJpaWw4Q242d0VUME0rTFZVMlI4Qm9M?=
 =?utf-8?B?UUdSZGtrSHJqUm13UDE2T2hocTloU3MyUDNSTmVhLzBGdTcrL01FU1l0M3Rw?=
 =?utf-8?B?ekZ1cjBMaHVBdXcvVi9yQ1RTdEpRZ1QrRjZ0YnF1Vnlzc3lIOU5oWkxnbW9I?=
 =?utf-8?B?NFpZQjdQMnExLzE2bzlmTU5EQzR5VlE0MU5sbGV5VCtHVVAvdzF1MkVUN0Ex?=
 =?utf-8?B?QXg0SzVnOFRkZDVMTmdsR0Z5YUk1cFN5aGUva09tcW9TemIzYWhHNFlvQmhh?=
 =?utf-8?B?OVdsOUR0a05QYXJYZk00N3hpVEtGWkQ0TDFqS0dKVzBoejVWK0hLRld2dWxG?=
 =?utf-8?B?TUdkZjJDNjNmd3dUN0pqM1JSWjZKRWt6VHBwMC83UExIK25GMlhLNXU3Sk1J?=
 =?utf-8?B?M0xNVi9tQ29aSkdOeFk1UGF1L0RDN2tySDk0emFrMVBOa0RNUkpOZW5uVit4?=
 =?utf-8?B?bmNCUHhzVlhnMU5IU1BLNkxOcGVYRDl5cFRiYlNDUjlKTWh0SzV1ZnpBRlVC?=
 =?utf-8?B?YzdWTmowZ0hoSDhWeVJZMnNxZUM4Vm54Mit5SWZHUnB2eGw2L1kwdEp6Q2c0?=
 =?utf-8?B?R3NjZ0RxQVhHR1ljQWdSanFENDR4UDErSSs0aHRZV3R3UndWcE8wOUZlUHhO?=
 =?utf-8?B?NTBsOC95VndqeXlTTlRxT0I2V2E1MHkyUUV6cnQwbFBpbWJ2RWZ4RGxUaHQ1?=
 =?utf-8?B?Wm8yUGdUaVo4eWROb2dpV1oxcXI4WnE3WFZFU25nVVdhdi8wTW1aMGx1cXhN?=
 =?utf-8?B?aGxwMnp5aitzRGlSSk43eC9DY3pZaXlDL0d5b0o4SStWYi9zV2VtZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20df80c1-19ba-4fb8-eb1e-08da2295fa1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 06:21:16.5986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6MC1FTB/NjGuPoj5QVfXuAb3TgGTwLlPx3bhDFenQ+HlvVX2low+avQQxytjCHdM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3966
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBBcHJpbCAyMCwgMjAyMiAxMjozMyBQTQ0KPiBUbzogWmhvdTEsIFRhbyA8VGFvLlpo
b3UxQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWmhhbmcsDQo+IEhh
d2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFlhbmcsIFN0YW5sZXkNCj4gPFN0YW5sZXku
WWFuZ0BhbWQuY29tPjsgWml5YSwgTW9oYW1tYWQgemFmYXINCj4gPE1vaGFtbWFkemFmYXIuWml5
YUBhbWQuY29tPjsgQ2hhaSwgVGhvbWFzIDxZaVBlbmcuQ2hhaUBhbWQuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDIvM10gZHJtL2FtZGdwdTogYWRkIFJBUyBwb2lzb24gY29uc3VtcHRpb24g
aGFuZGxlcg0KPiANCj4gDQo+IA0KPiBPbiA0LzIwLzIwMjIgOToyMyBBTSwgVGFvIFpob3Ugd3Jv
dGU6DQo+ID4gQWRkIHN1cHBvcnQgZm9yIGdlbmVyYWwgUkFTIHBvaXNvbiBjb25zdW1wdGlvbiBo
YW5kbGVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQu
Y29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jh
cy5jIHwgNDMNCj4gKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oIHwgIDEgKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCA0MyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+ID4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gPiBpbmRleCAyZDA2NmNmZjcwZWEuLjRi
ZDNjMjViZTgwOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcmFzLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmFzLmMNCj4gPiBAQCAtMTUxNSw2ICsxNTE1LDQ0IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Jhc19m
c19maW5pKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ICAgLyogcmFzIGZzIGVu
ZCAqLw0KPiA+DQo+ID4gICAvKiBpaCBiZWdpbiAqLw0KPiA+ICtzdGF0aWMgdm9pZCByYXNfaW50
ZXJydXB0X3BvaXNvbl9jb25zdW1wdGlvbl9oYW5kbGVyKHN0cnVjdCByYXNfbWFuYWdlcg0KPiAq
b2JqLA0KPiA+ICsJCQkJc3RydWN0IGFtZGdwdV9pdl9lbnRyeSAqZW50cnkpDQo+ID4gK3sNCj4g
PiArCWJvb2wgcG9pc29uX3N0YXQgPSB0cnVlLCBuZWVkX3Jlc2V0ID0gdHJ1ZTsNCj4gPiArCXN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gb2JqLT5hZGV2Ow0KPiA+ICsJc3RydWN0IHJhc19l
cnJfZGF0YSBlcnJfZGF0YSA9IHswLCAwLCAwLCBOVUxMfTsNCj4gPiArCXN0cnVjdCByYXNfaWhf
ZGF0YSAqZGF0YSA9ICZvYmotPmloX2RhdGE7DQo+ID4gKwlzdHJ1Y3QgYW1kZ3B1X3Jhc19ibG9j
a19vYmplY3QgKmJsb2NrX29iaiA9DQo+ID4gKwkJYW1kZ3B1X3Jhc19nZXRfcmFzX2Jsb2NrKGFk
ZXYsIG9iai0+aGVhZC5ibG9jaywgMCk7DQo+ID4gKw0KPiA+ICsJaWYgKCFhZGV2LT5nbWMueGdt
aS5jb25uZWN0ZWRfdG9fY3B1KQ0KPiA+ICsJCWFtZGdwdV91bWNfcG9pc29uX2hhbmRsZXIoYWRl
diwgJmVycl9kYXRhLCBmYWxzZSk7DQo+ID4gKw0KPiA+ICsJLyogVHdvIHdheXMgZm9yIFJBUyBi
bG9jaydzIHBvaXNvbiBjb25zdW1wdGlvbiBpbXBsZW1lbnRhdGlvbjoNCj4gPiArCSAqIDEuIGRl
ZmluZSBJSCBjYWxsYmFjaywgb3INCj4gPiArCSAqIDIuIGltcGxlbWVudCBxdWVyeSBhbmQgY29u
c3VtcHRpb24gaW50ZXJmYWNlcy4NCj4gPiArCSAqLw0KPiANCj4gVGhpcyBkb2Vzbid0IGxvb2sg
YXBwcm9wcmlhdGUuIEJldHRlciB0byBoYXZlIG9uZSBzdGFuZGFyZCB3YXkuIFdoYXQgaWYgYW4g
SVANCj4gaGFzIGNhbGwgYmFjayBpbXBsZW1lbnRlZCB0byBoYW5kbGUgZXJyb3JzIGluIG5vbi1w
b2lzb24gbW9kZT8NCg0KW1Rhb10gYXBwcm9hY2ggMiBpcyBzdGFuZGFyZCB3YXksIGJ1dCBzb21l
IFJBUyBibG9ja3MgbWF5IGhhdmUgZGlmZmVyZW50IHJlcXVpcmVtZW50cyBmb3IgUkFTIGNvbnN1
bXB0aW9uIGhhbmRsZXIgaW4gdGhlIGZ1dHVyZSwgYSBjYWxsYmFjayBmdW5jdGlvbiBpcyBtb3Jl
IGNvbnZlbmllbnQgZm9yIHRoaXMgc2l0dWF0aW9uLg0KDQo+IA0KPiA+ICsJaWYgKGRhdGEtPmNi
KSB7DQo+ID4gKwkJbmVlZF9yZXNldCA9ICEhZGF0YS0+Y2Iob2JqLT5hZGV2LCAmZXJyX2RhdGEs
IGVudHJ5KTsNCj4gPiArCX0gZWxzZSBpZiAoYmxvY2tfb2JqICYmIGJsb2NrX29iai0+aHdfb3Bz
KSB7DQo+ID4gKwkJaWYgKGJsb2NrX29iai0+aHdfb3BzLT5xdWVyeV9wb2lzb25fc3RhdHVzKSB7
DQo+ID4gKwkJCXBvaXNvbl9zdGF0ID0gYmxvY2tfb2JqLT5od19vcHMtDQo+ID5xdWVyeV9wb2lz
b25fc3RhdHVzKGFkZXYpOw0KPiA+ICsJCQlpZiAoIXBvaXNvbl9zdGF0KQ0KPiA+ICsJCQkJZGV2
X2luZm8oYWRldi0+ZGV2LCAiTm8gUkFTIHBvaXNvbiBzdGF0dXMNCj4gaW4gJXMgcG9pc29uIElI
LlxuIiwNCj4gPiArCQkJCQkJYmxvY2tfb2JqLT5yYXNfY29tbS5uYW1lKTsNCj4gPiArCQl9DQo+
ID4gKw0KPiA+ICsJCWlmIChwb2lzb25fc3RhdCAmJiBibG9ja19vYmotPmh3X29wcy0NCj4gPmhh
bmRsZV9wb2lzb25fY29uc3VtcHRpb24pIHsNCj4gPiArCQkJcG9pc29uX3N0YXQgPSBibG9ja19v
YmotPmh3X29wcy0NCj4gPmhhbmRsZV9wb2lzb25fY29uc3VtcHRpb24oYWRldik7DQo+ID4gKwkJ
CW5lZWRfcmVzZXQgPSBwb2lzb25fc3RhdDsNCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+
ICsJLyogZ3B1IHJlc2V0IGlzIGZhbGxiYWNrIGZvciBhbGwgZmFpbGVkIGNhc2VzICovDQo+ID4g
KwlpZiAobmVlZF9yZXNldCkNCj4gPiArCQlhbWRncHVfcmFzX3Jlc2V0X2dwdShhZGV2KTsNCj4g
PiArfQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyB2b2lkIHJhc19pbnRlcnJ1cHRfcG9pc29uX2NyZWF0
aW9uX2hhbmRsZXIoc3RydWN0IHJhc19tYW5hZ2VyICpvYmosDQo+ID4gICAJCQkJc3RydWN0IGFt
ZGdwdV9pdl9lbnRyeSAqZW50cnkpDQo+ID4gICB7DQo+ID4gQEAgLTE1NjMsNyArMTYwMSwxMCBA
QCBzdGF0aWMgdm9pZCBhbWRncHVfcmFzX2ludGVycnVwdF9oYW5kbGVyKHN0cnVjdA0KPiByYXNf
bWFuYWdlciAqb2JqKQ0KPiA+ICAgCQlkYXRhLT5ycHRyID0gKGRhdGEtPmFsaWduZWRfZWxlbWVu
dF9zaXplICsNCj4gPiAgIAkJCQlkYXRhLT5ycHRyKSAlIGRhdGEtPnJpbmdfc2l6ZTsNCj4gPg0K
PiA+IC0JCXJhc19pbnRlcnJ1cHRfcG9pc29uX2NyZWF0aW9uX2hhbmRsZXIob2JqLCAmZW50cnkp
Ow0KPiA+ICsJCWlmIChvYmotPmhlYWQuYmxvY2sgPT0gQU1ER1BVX1JBU19CTE9DS19fVU1DKQ0K
PiA+ICsJCQlyYXNfaW50ZXJydXB0X3BvaXNvbl9jcmVhdGlvbl9oYW5kbGVyKG9iaiwgJmVudHJ5
KTsNCj4gPiArCQllbHNlDQo+ID4gKwkJCXJhc19pbnRlcnJ1cHRfcG9pc29uX2NvbnN1bXB0aW9u
X2hhbmRsZXIob2JqLA0KPiAmZW50cnkpOw0KPiANCj4gU2FtZSBwcm9ibGVtIC0gcG9pc29uIG1v
ZGUgaXMgaW1wbGljaXRseSBhc3N1bWVkLiBQb2lzb24gY29uc3VtcHRpb24gaXMNCj4gcmVsZXZh
bnQgb25seSBpbiBwb2lzb24gbW9kZS4NCg0KW1Rhb10gd2lsbCBmaXggaXQuDQoNCj4gDQo+IFRo
YW5rcywNCj4gTGlqbw0KPiANCj4gPiAgIAl9DQo+ID4gICB9DQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oDQo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmgNCj4gPiBpbmRleCA2MDZkZjg4NjliODku
LmM0YjYxNzg1YWI1YyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmFzLmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmFzLmgNCj4gPiBAQCAtNTA5LDYgKzUwOSw3IEBAIHN0cnVjdCBhbWRncHVfcmFzX2Jsb2Nr
X2h3X29wcyB7DQo+ID4gICAJdm9pZCAoKnJlc2V0X3Jhc19lcnJvcl9jb3VudCkoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpOw0KPiA+ICAgCXZvaWQgKCpyZXNldF9yYXNfZXJyb3Jfc3RhdHVz
KShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7DQo+ID4gICAJYm9vbCAoKnF1ZXJ5X3BvaXNv
bl9zdGF0dXMpKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsNCj4gPiArCWJvb2wgKCpoYW5k
bGVfcG9pc29uX2NvbnN1bXB0aW9uKShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7DQo+ID4g
ICB9Ow0KPiA+DQo+ID4gICAvKiB3b3JrIGZsb3cNCj4gPg0K
