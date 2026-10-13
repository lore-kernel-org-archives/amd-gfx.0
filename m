Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEBECC6B0E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 16:34:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89F8310E20E;
	Tue, 13 Oct 2026 16:34:24 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11C2010F56E
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 16:34:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYijnuVHxyZL772NTsx52gzO7PEyW7pTjljkcMiw/SIFBfZetitBweuP4LCKjF4uhntG48JfTnGfrqMDtJlN8hJXEYPImoGkt8+pFiCVBdfFD5LMpuRoT3LqovNcb1EH2ofnd6jpozsdBhZoJmZBCZaOLeAJzvRgSLi878UDjSZ33MC/9ZWdp3S0zvpwtUhb80hDyfxKIDXytubZHRzUEJmFFNXaTmADFOoVdiTHk2PbQrC9FxMYDflJkT5co9k+Vdo+tz14q4y5kKl7c4pSADN0x9AwVDS/0C+Cwsu+4Vr+doz2RKqPqQFnkLnQufI0/JiL6vhtFB5CYUqf19bf5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVGSCG6f9i6gtAxlEje+J2VdCLwHUZnO811QmO0Kks8=;
 b=gezw6AwiLtjrjva1XD0JddywozY6+Djw8cevutLKODt6FZCXppVdTnVPSzqXcj/M9am0869jtcylczMBJAHwtoUF4dbKqQyEX5xrcKwUp+b4WehIoYSfPLZ0qBAEQGrecTxOy9y/gt8+ZRL9WxKX34gxNCxB1PKZ7WhC9YPuJtoFGCqbuWGeRrreXJJ4Gw40rD+gJh7KSNJG860bE18GMi9+bjFeTyb29NLDESyFe6iPe7C+ReFKLLbESEgr7UNhVKHY6hs/RyHqnTSc8Jfl6LjvFLT+DdKnY/KGfTgSIRTSWZflRXFQeMTXTTZGeDd//4zsZV0TFY6VpZc0d+LXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVGSCG6f9i6gtAxlEje+J2VdCLwHUZnO811QmO0Kks8=;
 b=ec2o6ahjCLPNJFcH/K3QmlTjAxFwaZdxmhACh8d+FA3Mu2HX8fKnjfFDDakMf6JsMvf1n6RS1OHixnuyNeYuToScMp+IIQ9j9NzJ5dP8B0OeZgrKLqNAeGMrE6EIImYiDwa8BYGvBZGkrA0ofLY3FSd3XxOP3KQDrjpgoR6Xzok=
Received: from CH0PR12MB5139.namprd12.prod.outlook.com (2603:10b6:610:be::9)
 by BN3PR12MB9593.namprd12.prod.outlook.com (2603:10b6:408:2cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 16:34:14 +0000
Received: from CH0PR12MB5139.namprd12.prod.outlook.com
 ([fe80::8715:80d8:e0b7:7bb1]) by CH0PR12MB5139.namprd12.prod.outlook.com
 ([fe80::8715:80d8:e0b7:7bb1%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 16:34:14 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Natalie Vock
 <natalie.vock@gmx.de>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Rosca, David" <David.Rosca@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, Tvrtko
 Ursulin <tursulin@ursulin.net>
Subject: RE: [PATCH] drm/amdgpu/sdma3: Work around POLL_REGMEM / FENCE hang
Thread-Topic: [PATCH] drm/amdgpu/sdma3: Work around POLL_REGMEM / FENCE hang
Thread-Index: AQHdVd52VtrTkjszvU61nEeGX1x3Bbb7tV+g
Date: Tue, 13 Oct 2026 16:34:13 +0000
Message-ID: <CH0PR12MB5139003E4C4553CF37846BFCF79E2@CH0PR12MB5139.namprd12.prod.outlook.com>
References: <20261006220253.102403-1-timur.kristof@gmail.com>
In-Reply-To: <20261006220253.102403-1-timur.kristof@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-13T16:33:34.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5139:EE_|BN3PR12MB9593:EE_
x-ms-office365-filtering-correlation-id: facc2e18-b4cd-418f-0362-08df2947d146
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|10067099003|921020|56012099006|38070700021|11063799006|261009223027099003;
x-microsoft-antispam-message-info: cDkPWz6WkgDRjZWp/h+G//6rSzgtKnRGwi+1yDeQa9Xu76AReBC2paaGRz4uAyj0/y7UwCKnzy62IbhACpnA9mrNPP44olsaHG7l2Q5RNSE/LAYIaFSLw3jNsya36B+FbYPshkMgeSHLEiUyWhTw7odz4h8WtnQhwQQiuMB+v054KRvH/eaolNsuZvks6Opr1aocQzC2kjpV9Equm+MuDMCNqH9wrGRPPwwV5hrjAOj48sfm+IHme2lpwTI14LWA1juKBM5OYzaUCI3m1P8BOHFXN9LzSWR4mqDskV076jxiVNKL+oGveR0uS7FE11khEQPj6LQNXiCPemFfkKAuAdaDjXzgI3dSqEVOzsomkPI01fgNFK5jpeBdC0Yxz8n6h3ffa3GxifNFhbAOtDu+MvgswH2FMicbnlg7Tc7oxqhijxVUWI/EuPUoRs5EkmzPOf7jJC9l7pPsPP35Xs0GAtEh8Is28xQXU0UAjSyoxYCfHPX1EAcmcVaWUiNjB+CC7bo/8r2knIIwnqDSUeBgQguz0M6ZUsGrF+YHfhNI0PvJGTFKW0BSIae2yxUXSRNztYsBardXeFeTzXqkSPD15vtquzXrIV/06DSMfwvp3Evg1lTMF94aeKD1T4vYY86/md1+7DfbclXu7yx2TaurcoKKqRv/K3e4pxto2w/cQ39HOMMLbKzerL9rGzBtLyS2AYAvh6ALBJr16fDIEQtGxyk/zG9ng9kW4b2nVGbKiTqkLFYGpcsSmshC9v6v/Vdl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5139.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(921020)(56012099006)(38070700021)(11063799006)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFV0SEpXcUUvZnhTaW1EbmVRdHZhQjNNRWFuZG9vMVZhNEoxWjlkbnhlb1Jk?=
 =?utf-8?B?ODFhNXBicGVpN0VsRVg3NWRmOENRNzBJR2NJaG5ERllXdWJnSHl4OERpRVVY?=
 =?utf-8?B?c1Q3YVJDTWlUaVdxSjVFZHhzR3U3bjZzSHdwWWYzV3p6dmYrTm5wVVpRVDQy?=
 =?utf-8?B?a2dCQ2pQRXVFMmZwQ1VjNmNBelRQWm9nNy9KUnRiaDcyYnhsWGhENmtwbmlU?=
 =?utf-8?B?d21rZzQwbUtWWlVzd3paaFZjOFdlOGZGN1lKVFZYemFIaWFGbkNSWkVLUmNC?=
 =?utf-8?B?N3RWK1RMbHllYWwvKzN3czFXQ1N0VXVwTUp3VnFOYXUxdkRGelE4SC8vVWFE?=
 =?utf-8?B?TmsyYzNSeFRKZGhVZkpVQUtZSTNUZllmZnRvRXhFMm9TTDRIVHdvQ0s1RVl1?=
 =?utf-8?B?eEc5QTVQTXpSbkZteGhzcnBnZndCVk9xOHJwd0RNMFNnWjYyVzVCbnYwOWlE?=
 =?utf-8?B?RGloZHM4T0ovYVlIY3hRbE1ETXB6ZlN0MXEvUDRXZUN4Y1QySUxGYVd4UmN5?=
 =?utf-8?B?dUtrV29GdmVGSlEweENsTDB5MnUzQTh6djdNSFFncFVPdVliOHFSQWpEMXA1?=
 =?utf-8?B?TmVMT3ViNG5WYzdpT0NsRTRkOFFRWnBFYWovVW01a1N0TzFvck82TWlWMjBh?=
 =?utf-8?B?dms2dmtNVnpmOXBCc2RjTXBJWGpJd01qK1NVeEIyRHpyeW9VZGhORDYzTjZs?=
 =?utf-8?B?MVZNbkt5WlVCY0R3MkdNMTR3RW0xWTBYUGJPc05Wb1NrOXphV2JndDlOTXRi?=
 =?utf-8?B?bjhkUDJqWEJtQUZqOHlPK2dQaGtGNGJSbjNVZjMvMm1CLzlvbEp1TzF6OFBs?=
 =?utf-8?B?c1dNaVFIMkVKMzJpK1BGUnZ6MUdDZU9jR2w5Mi9XdVYrT1J3OWZFZFg2aTBz?=
 =?utf-8?B?RGdnWkZmbHE1ck5mVE5JZTJQaGg2akZQV3JyVzRHQk95VWpzdnhMbHU5M0Nv?=
 =?utf-8?B?bHp5UjhYd1pvVnRiMURqTUxGQXR3MkZwaFEwN3F6Q2cxVmNEd1R4RVpJVHdO?=
 =?utf-8?B?aWh3akRpVzg5TzRMSkxSQ3V1a3V4a0E5SmM1QUdwMG1aVnpIQjlwTFVBOHk0?=
 =?utf-8?B?SlFGTVAyMzRPY1Y4VDNQVFdGSWx0cjl2d1R1QkNOTW9VbFZMWVJEMjF5NXhG?=
 =?utf-8?B?NTU4QUpxM1I0OWREYit1WXlGMW9RTFo1bkUxS3NsZFFmN05hSytlUi9uQm1D?=
 =?utf-8?B?VCswMm1HbFlRVlE0YWg5NUJteUp6NlkxUEVhSFMxSExQb3V5blhaSzNUODYx?=
 =?utf-8?B?TldxRDNENUEyUENkcEVka2haMGQ4TTh5OTYxTlhUaGNsN0xENkVqbUFqTHNo?=
 =?utf-8?B?SlJ3dVZkZVcwa3F3VGUrY214RnZiQnpUek8xV0NQUmEyVi80MDZqdU1RYXZR?=
 =?utf-8?B?b0JoUHhmSnpQNHpkTXgrdTF3QWsvWHpVelB6UmRXMXI5cE90aVdsV1lNN0Fv?=
 =?utf-8?B?c0sxN2Y4SVVqaVdUYUZKcjVqWnFNRXJweW9xSWt5NEJSeDBCYkNYYUlPWFVk?=
 =?utf-8?B?TWJYdXZIN3BSUnliR1FYTEk0eGZzb09kVkpTQW9MclBPd1pUaDdhSUowSDgr?=
 =?utf-8?B?V2owNnplSEE4MFZrcUhpejhzVGY1UjZPZS9EWE5kbVl4V2tjSVI1b3I3NUpS?=
 =?utf-8?B?MTl3UFRmSXVvNFd5dHlYc3F1R1dtVFJra2RhY3FYd2hCUVhqWjNuVnFiN3ln?=
 =?utf-8?B?VzhRN0tTMzBiMVRCUnRLZTRBNE5MMm9PeXRYMUVqbFZTdkhkbm0xT3VXdW9I?=
 =?utf-8?B?YUF6NGU2MDBhcm9Uc0licDBtWlRoUVNtR0luSnVYWURZMHdPSFVjeEZuaW1q?=
 =?utf-8?B?d2ptWWRMRGdRbzA5QlpZTVd6Z0VreWZFSU80M2lkTlVTSHYvcTdrOVRNOVFJ?=
 =?utf-8?B?KzBPdUExd291cFNvYmVqV1luaXA0QlVzWjRFdnNtOFRKaXB5VmRSTzZFMzZM?=
 =?utf-8?B?TEJOR2V0a1hOQmhxNVJhTXZCTkhZVnBVWDFmWWRrRlg2RnVTeXNxRTdCYWFp?=
 =?utf-8?B?bnlNdGRqcDFnbEFHNmplVWQ3d1kwbFplalQyTGlUWVNlYjZ3OFBRaW1iNTkz?=
 =?utf-8?B?TmRwcDVmZTRhMi8rZEozT0FBZlpRclN3UXBiaFV6MUUxckxmMjlxaElMUlY3?=
 =?utf-8?B?R3RaRnI2MWhsKzRYSXpqeXo0dXhkc1BuNE5BcEwrbXdoRkxOcDJOSGNFQmwx?=
 =?utf-8?B?N2cxUnc3cTBJK0o3SkI2YkxnYXdUd1RmcWQwK1dCeGY5d09yMjZUNUp4S0Ix?=
 =?utf-8?B?VEFiSVlhQjVjTys1aHBVTDJQTW1GQUJpOUdYd3FNZ2JhZ2phaEVtWW92Tkpa?=
 =?utf-8?Q?yao9pceYPli03EEqEu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5139.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: facc2e18-b4cd-418f-0362-08df2947d146
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 16:34:14.0114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ebGHivA6SMVAyeH6bKNMKaqsIH4MubRNybN3veHOHp0niJDGmR9oaRS/kL33AjlbPqOIKeQHrE29wOGfG0ygw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9593
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

UHVibGljDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGltdXIgS3Jp
c3TDs2YgPHRpbXVyLmtyaXN0b2ZAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVy
IDYsIDIwMjYgNjowMyBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERl
dWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IE5hdGFsaWUg
Vm9jayA8bmF0YWxpZS52b2NrQGdteC5kZT47DQo+IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8u
TGltb25jaWVsbG9AYW1kLmNvbT47IFJvc2NhLCBEYXZpZA0KPiA8RGF2aWQuUm9zY2FAYW1kLmNv
bT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+Ow0KPiBMYXph
ciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgVHZydGtvIFVyc3VsaW4gPHR1cnN1bGluQHVy
c3VsaW4ubmV0Pg0KPiBDYzogVGltdXIgS3Jpc3TDs2YgPHRpbXVyLmtyaXN0b2ZAZ21haWwuY29t
Pg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHUvc2RtYTM6IFdvcmsgYXJvdW5kIFBPTExf
UkVHTUVNIC8gRkVOQ0UNCj4gaGFuZw0KPg0KPiBTRE1BIGNhbiByYW5kb21seSBoYW5nIG9uIFBv
bGFyaXMgMTAuIEhhcmQgdG8gcmVwcm9kdWNlLCBidXQgaGFzIGJlZW4NCj4gb2NjdXJyaW5nIHNw
b3JhZGljYWxseSBpbiB0aGUgTWVzYSBDSSBvbiB0aGUgUkFEViBQb2xhcmlzIDEwIGpvYiBldmVu
IHdoZW4NCj4gTWVzYSBpc24ndCB1c2luZyB0aGUgU0RNQSBlbmdpbmUuDQo+DQo+IFdoZW4gTWVz
YSBhY3R1YWxseSB1c2VzIHRoZSBTRE1BIG9uIFBvbGFyaXMsIHRoZSBoYW5nIGJlY29tZXMgbW9y
ZQ0KPiBmcmVxdWVudCBhbmQgdGhlIHJlcHJvZHVjdGlvbiByYXRlIGdvZXMgdXAgc2lnbmlmaWNh
bnRseSBpbiB0aGUgQ0kgc3lzdGVtLg0KPg0KPiBXZSBkb24ndCBrbm93IHdoeSB0aGUgaGFuZ3Mg
b2NjdXIsIGJ1dCBpdCBzZWVtcyB0aGF0IGluc2VydGluZyBhIHNpbmdsZSBOT1ANCj4gcGFja2V0
IGJlZm9yZSBlYWNoIFBPTExfUkVHTUVNIGFuZCBGRU5DRSBwYWNrZXQgd29ya3MgYXJvdW5kIGl0
Lg0KPiBBdCB0aGUgbW9tZW50IGl0J3MgdW5jbGVhciB3aGljaCBHUFVzIGFyZSBhZmZlY3RlZCwg
c28gbGV0J3MgYXBwbHkgdGhpcyB0bw0KPiBTRE1BIDMueCBmb3Igbm93Lg0KPg0KPiBOb3RlIHRo
YXQgdGhpcyBpc3N1ZSBpcyBub3QgZG9jdW1lbnRlZCBvciBhY2tub3dsZWRnZWQgYnkgQU1ELg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBUaW11ciBLcmlzdMOzZiA8dGltdXIua3Jpc3RvZkBnbWFpbC5j
b20+DQoNClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+DQoNCkFuZCBhcHBsaWVkLg0KDQpUaGFua3MhDQoNCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zZG1hX3YzXzAuYyB8IDI1DQo+ICsrKysrKysrKysrKysrKysrKysrKy0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92M18wLmMN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3YzXzAuYw0KPiBpbmRleCA2Zjcy
NDMzNzBhY2IuLjgxZjgwNGM5ZDA5MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvc2RtYV92M18wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
c2RtYV92M18wLmMNCj4gQEAgLTQ1OCw2ICs0NTgsOSBAQCBzdGF0aWMgdm9pZCBzZG1hX3YzXzBf
cmluZ19lbWl0X2hkcF9mbHVzaChzdHJ1Y3QNCj4gYW1kZ3B1X3JpbmcgKnJpbmcpDQo+ICAgICAg
IGVsc2UNCj4gICAgICAgICAgICAgICByZWZfYW5kX21hc2sgPSBSRUdfU0VUX0ZJRUxEKHJlZl9h
bmRfbWFzaywNCj4gR1BVX0hEUF9GTFVTSF9ET05FLCBTRE1BMSwgMSk7DQo+DQo+ICsgICAgIC8q
IEhhbmcgd29ya2Fyb3VuZCAqLw0KPiArICAgICBhbWRncHVfcmluZ193cml0ZShyaW5nLA0KPiBT
RE1BX1BLVF9OT1BfSEVBREVSX09QKFNETUFfT1BfTk9QKSk7DQo+ICsNCj4gICAgICAgYW1kZ3B1
X3Jpbmdfd3JpdGUocmluZywNCj4gU0RNQV9QS1RfSEVBREVSX09QKFNETUFfT1BfUE9MTF9SRUdN
RU0pIHwNCj4NCj4gU0RNQV9QS1RfUE9MTF9SRUdNRU1fSEVBREVSX0hEUF9GTFVTSCgxKSB8DQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIFNETUFfUEtUX1BPTExfUkVHTUVNX0hFQURFUl9GVU5D
KDMpKTsgLyoNCj4gPT0gKi8gQEAgLTQ4NSw2ICs0ODgsMTAgQEAgc3RhdGljIHZvaWQgc2RtYV92
M18wX3JpbmdfZW1pdF9mZW5jZShzdHJ1Y3QNCj4gYW1kZ3B1X3JpbmcgKnJpbmcsIHU2NCBhZGRy
LCB1NjQgc2UNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQg
ZmxhZ3MpDQo+ICB7DQo+ICAgICAgIGJvb2wgd3JpdGU2NGJpdCA9IGZsYWdzICYgQU1ER1BVX0ZF
TkNFX0ZMQUdfNjRCSVQ7DQo+ICsNCj4gKyAgICAgLyogSGFuZyB3b3JrYXJvdW5kICovDQo+ICsg
ICAgIGFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsDQo+IFNETUFfUEtUX05PUF9IRUFERVJfT1AoU0RN
QV9PUF9OT1ApKTsNCj4gKw0KPiAgICAgICAvKiB3cml0ZSB0aGUgZmVuY2UgKi8NCj4gICAgICAg
YW1kZ3B1X3Jpbmdfd3JpdGUocmluZywNCj4gU0RNQV9QS1RfSEVBREVSX09QKFNETUFfT1BfRkVO
Q0UpKTsNCj4gICAgICAgYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgbG93ZXJfMzJfYml0cyhhZGRy
KSk7IEBAIC00OTMsNyArNTAwLDExDQo+IEBAIHN0YXRpYyB2b2lkIHNkbWFfdjNfMF9yaW5nX2Vt
aXRfZmVuY2Uoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCB1NjQNCj4gYWRkciwgdTY0IHNlDQo+
DQo+ICAgICAgIC8qIG9wdGlvbmFsbHkgd3JpdGUgaGlnaCBiaXRzIGFzIHdlbGwgKi8NCj4gICAg
ICAgaWYgKHdyaXRlNjRiaXQpIHsNCj4gKyAgICAgICAgICAgICAvKiBIYW5nIHdvcmthcm91bmQg
Ki8NCj4gKyAgICAgICAgICAgICBhbWRncHVfcmluZ193cml0ZShyaW5nLA0KPiBTRE1BX1BLVF9O
T1BfSEVBREVSX09QKFNETUFfT1BfTk9QKSk7DQo+ICsNCj4gICAgICAgICAgICAgICBhZGRyICs9
IDQ7DQo+ICsNCj4gICAgICAgICAgICAgICBhbWRncHVfcmluZ193cml0ZShyaW5nLA0KPiBTRE1B
X1BLVF9IRUFERVJfT1AoU0RNQV9PUF9GRU5DRSkpOw0KPiAgICAgICAgICAgICAgIGFtZGdwdV9y
aW5nX3dyaXRlKHJpbmcsIGxvd2VyXzMyX2JpdHMoYWRkcikpOw0KPiAgICAgICAgICAgICAgIGFt
ZGdwdV9yaW5nX3dyaXRlKHJpbmcsIHVwcGVyXzMyX2JpdHMoYWRkcikpOyBAQCAtMTAxMCw2DQo+
ICsxMDIxLDkgQEAgc3RhdGljIHZvaWQgc2RtYV92M18wX3JpbmdfZW1pdF9waXBlbGluZV9zeW5j
KHN0cnVjdA0KPiBhbWRncHVfcmluZyAqcmluZykNCj4gICAgICAgdWludDMyX3Qgc2VxID0gcmlu
Zy0+ZmVuY2VfZHJ2LnN5bmNfc2VxOw0KPiAgICAgICB1aW50NjRfdCBhZGRyID0gcmluZy0+ZmVu
Y2VfZHJ2LmdwdV9hZGRyOw0KPg0KPiArICAgICAvKiBIYW5nIHdvcmthcm91bmQgKi8NCj4gKyAg
ICAgYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywNCj4gU0RNQV9QS1RfTk9QX0hFQURFUl9PUChTRE1B
X09QX05PUCkpOw0KPiArDQo+ICAgICAgIC8qIHdhaXQgZm9yIGlkbGUgKi8NCj4gICAgICAgYW1k
Z3B1X3Jpbmdfd3JpdGUocmluZywNCj4gU0RNQV9QS1RfSEVBREVSX09QKFNETUFfT1BfUE9MTF9S
RUdNRU0pIHwNCj4NCj4gU0RNQV9QS1RfUE9MTF9SRUdNRU1fSEVBREVSX0hEUF9GTFVTSCgwKSB8
IEBAIC0xMDM4LDYgKzEwNTIsOQ0KPiBAQCBzdGF0aWMgdm9pZCBzZG1hX3YzXzBfcmluZ19lbWl0
X3ZtX2ZsdXNoKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgIHsNCj4gICAgICAgYW1kZ3B1X2dt
Y19lbWl0X2ZsdXNoX2dwdV90bGIocmluZywgdm1pZCwgcGRfYWRkcik7DQo+DQo+ICsgICAgIC8q
IEhhbmcgd29ya2Fyb3VuZCAqLw0KPiArICAgICBhbWRncHVfcmluZ193cml0ZShyaW5nLA0KPiBT
RE1BX1BLVF9OT1BfSEVBREVSX09QKFNETUFfT1BfTk9QKSk7DQo+ICsNCj4gICAgICAgLyogd2Fp
dCBmb3IgZmx1c2ggKi8NCj4gICAgICAgYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywNCj4gU0RNQV9Q
S1RfSEVBREVSX09QKFNETUFfT1BfUE9MTF9SRUdNRU0pIHwNCj4NCj4gU0RNQV9QS1RfUE9MTF9S
RUdNRU1fSEVBREVSX0hEUF9GTFVTSCgwKSB8IEBAIC0xNDY3LDExDQo+ICsxNDg0LDExIEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3Mgc2RtYV92M18wX3JpbmdfZnVuY3MN
Cj4gPSB7DQo+ICAgICAgIC5nZXRfd3B0ciA9IHNkbWFfdjNfMF9yaW5nX2dldF93cHRyLA0KPiAg
ICAgICAuc2V0X3dwdHIgPSBzZG1hX3YzXzBfcmluZ19zZXRfd3B0ciwNCj4gICAgICAgLmVtaXRf
ZnJhbWVfc2l6ZSA9DQo+IC0gICAgICAgICAgICAgNiArIC8qIHNkbWFfdjNfMF9yaW5nX2VtaXRf
aGRwX2ZsdXNoICovDQo+ICsgICAgICAgICAgICAgNiArIDEgKyAvKiBzZG1hX3YzXzBfcmluZ19l
bWl0X2hkcF9mbHVzaCAqLw0KPiAgICAgICAgICAgICAgIDMgKyAvKiBoZHAgaW52YWxpZGF0ZSAq
Lw0KPiAtICAgICAgICAgICAgIDYgKyAvKiBzZG1hX3YzXzBfcmluZ19lbWl0X3BpcGVsaW5lX3N5
bmMgKi8NCj4gLSAgICAgICAgICAgICBWSV9GTFVTSF9HUFVfVExCX05VTV9XUkVHICogMyArIDYg
KyAvKg0KPiBzZG1hX3YzXzBfcmluZ19lbWl0X3ZtX2ZsdXNoICovDQo+IC0gICAgICAgICAgICAg
MTAgKyAxMCArIDEwLCAvKiBzZG1hX3YzXzBfcmluZ19lbWl0X2ZlbmNlIHgzIGZvciB1c2VyDQo+
IGZlbmNlLCB2bSBmZW5jZSAqLw0KPiArICAgICAgICAgICAgIDYgKyAxICsgLyogc2RtYV92M18w
X3JpbmdfZW1pdF9waXBlbGluZV9zeW5jICovDQo+ICsgICAgICAgICAgICAgVklfRkxVU0hfR1BV
X1RMQl9OVU1fV1JFRyAqIDMgKyA2ICsgMSArIC8qDQo+IHNkbWFfdjNfMF9yaW5nX2VtaXRfdm1f
Zmx1c2ggKi8NCj4gKyAgICAgICAgICAgICAoMTAgKyAxKSAqIDMsIC8qIHNkbWFfdjNfMF9yaW5n
X2VtaXRfZmVuY2UgeDMgZm9yIHVzZXIgZmVuY2UsDQo+IHZtDQo+ICtmZW5jZSAqLw0KPiAgICAg
ICAuZW1pdF9pYl9zaXplID0gNyArIDYsIC8qIHNkbWFfdjNfMF9yaW5nX2VtaXRfaWIgKi8NCj4g
ICAgICAgLmVtaXRfaWIgPSBzZG1hX3YzXzBfcmluZ19lbWl0X2liLA0KPiAgICAgICAuZW1pdF9m
ZW5jZSA9IHNkbWFfdjNfMF9yaW5nX2VtaXRfZmVuY2UsDQo+IC0tDQo+IDIuNTUuMA0KDQo=
