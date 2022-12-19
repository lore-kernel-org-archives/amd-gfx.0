Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79019C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Dec 2022 02:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 801DB10E10D;
	Mon, 19 Dec 2022 02:10:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8937D10E10D
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Dec 2022 02:10:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sfgph3VyKPZ/k9zA56qs67MI7MigIgxpeKN8VR6TfcX9bEWnfZu9j6FztPB8Expkaf/1XhQl3cA4Oj+LOpHNsgWcdkiKMIWqLXfn6UMyeV8/f16NoLsLFqMXPcYB3oa39YpzYk2wNZxZ1y6ssJskhJX2ciH+JQ2WjaarXRWbhjVKk7epxaLVWKdwnUMvMFwj689u+MYWVuZkipKyTAqLEACUPW2r/mdmqED6nSmvf4cWfrKjCV+D8LH1MDJ4GO7G06Hw65CQfCvTq9qtYxmoCmCFuUL1ydFbORk6dFmQxNCpS02XVShfq8uk4Z+bZdiEWPCPed2SrGD9sahW7IoORw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zv7buKsHftndDM66e4mVG7iYEa5ie2Mx/Nf4jrYOG1k=;
 b=irds7oGU9I1gorKKu4FQG91IjoMTZlRsNVS5JePyGC5TqWqLUTJYJtTcoZEOXQU9sjUx1xplB/FCx4MfPiiLbmEb734fKfv/mYVaTy/0A5tydOcvNXvg7h5puo3hmykZi7QSLLP7wBKLenk7BdVM/bSyq39N787wPck5LHzClq1uUBnI7x2Jkq+4lzUcrACpslUpnQCrzfCxmZ9g68UEYiF9PjUWXbrZsZf3ssv1AZzqu2JQoEd2W9HfkXwOhLzzcPY6kvPlOVyZtCtVZ9D2a4u0AwEdE+JDxWI3HnrpysdFAiuNMej0+jLdB4HuHBkQYjTwa9yiNfUVJLnsfJoVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zv7buKsHftndDM66e4mVG7iYEa5ie2Mx/Nf4jrYOG1k=;
 b=kd6imMbx9jEznOOjAT0gxjQNOPqpUJOC+eDNAUOlA/746UMvXY6CJyoXpvHSjbmMr87S5fxG9U+hCiM5tGK237G6czAMg7bT4gO9qOnRteiE05ETdhmIxfsvFnH2in9HNUaEvC6dUjAjc4a6UWzmvP9G52WnJy3hcOv1TBNVFHc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Mon, 19 Dec 2022 02:10:34 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5dc8:98e2:7b6e:a9db]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5dc8:98e2:7b6e:a9db%5]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 02:10:33 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: correct the fan speed retrieving in PWM for
 some SMU13 asics
Thread-Topic: [PATCH] drm/amd/pm: correct the fan speed retrieving in PWM for
 some SMU13 asics
Thread-Index: AQHZETo4PMPkjSK9EEKZXEM6kuaClK5wZpEAgAQT1VA=
Date: Mon, 19 Dec 2022 02:10:33 +0000
Message-ID: <DM6PR12MB2619E62710E0978039956512E4E59@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20221216103550.2063886-1-evan.quan@amd.com>
 <0e3fc42c-d5d4-db99-ab6a-65b4f87ef201@gmail.com>
In-Reply-To: <0e3fc42c-d5d4-db99-ab6a-65b4f87ef201@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-19T02:10:28Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=921e9451-de94-4436-9cde-ff91801a0c30;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|CH3PR12MB8236:EE_
x-ms-office365-filtering-correlation-id: dbcaff23-7012-4413-cf3e-08dae1663617
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JREHTISFUm9Wa3f+6I6AMD3wIbRXB7BSaAwjyV+nkrWInOSJeAw4E6KMJUlycnDxUuffgfJbOdDRJhII0JktR+3JaLSHCvJG0+I9L1bglYRdp+IxLGAIq8vKXbXQ6XzkW94Yla9NoJsCLPQVj+HyfEYYLCrv+++s16QyRIsIrgX1+Yz14898rbbOjvzCBJoiVe6sKlBnM5JcgOAsrmhS6NKPkHwh/NA3uPfu54piMRoMkUAy3VW6kAObdf+MutHHuxZ3PNtw7ecxQq6dCi1qZNgelZ5I87JUm3mwcBjzfHNO9zIxLcHY2EG38GPsVwj0JdRdEV5NrXtOFmQXYALVWdvTH+NLW34ugSV3dQMmn2RqaJzsJRo5yYMaMMkL+Yf6COmGyXB1SVhhvvbwfoma/hFhRXzxjH/qj4rCWPOZJxMITBgxHTjjwbCT42psavmMocCkrk0KUt3EsC8DJ+Us0GCfOiSqjxYfTba0BUsMwZKEd8X/6u+INk42IicjvH7ld9TSEig8sZKG2VnngwdNc6LYerUJQFi9E+w9w33asDyB7Gb1Ido/U+7exOkeGtuDDUZUBPryAS4u7oe2WAhTNV1cPBk1JzVXCZwtZCY9TdOM3a7KDtg9fId3uA71A4I94zPVc3NlEHaDrv5bEFJZoYcT0sw8CRX6St0EA3jQzQDpYp5jQnFHRoLGKUam1jYTmmhypYfcsN38z2f4DSKtyw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199015)(478600001)(316002)(33656002)(86362001)(55016003)(9686003)(186003)(26005)(71200400001)(110136005)(66946007)(66476007)(64756008)(66446008)(66556008)(76116006)(7696005)(41300700001)(122000001)(8676002)(4326008)(66574015)(2906002)(52536014)(6506007)(53546011)(38100700002)(38070700005)(5660300002)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjBKaFFpS0lWQWo3b1E4TUNDMCtGc2d6Mnh3ekt6T09oNEtLenNZQVBibU1l?=
 =?utf-8?B?WS96WTRRem5CeFJtOVgvd0MzRlZ0aktVNE0yZmRkdHNYbzRrc1FqSGJlTGZG?=
 =?utf-8?B?TnNWNlNqRDhGSUhLbXRnT0ErMG1kT2MvdXVVT2NTSFVsSjM2eHhjckRMWm5J?=
 =?utf-8?B?ZTYrTGp6MFpONDV6cDY1YnVZelhtMHNTaTZ4MjB1OVNQeVdIcklkWWhMLy9I?=
 =?utf-8?B?K056VzJWTFVQQTVIQmVSU2NyZWx1MGl4YnFFVXZqQjMwYmVVeUx5Um5wQ1BH?=
 =?utf-8?B?SklpSENLemM1eEw0dmFteElmVkFiem5XZEprWFNqRVNLQThsMHpGTmF6THJr?=
 =?utf-8?B?QTAzR05sZERUUllUMlpJNnUwMnRRdWQ3VlBlUWpOTXorYjNUMnFyekFTRmVC?=
 =?utf-8?B?ekRBMVI5ZnlUQTI4Y01YUTZjYTBpTzR0M0RhWUI2Y01VTnF1VG5SZjl1cVZX?=
 =?utf-8?B?UjdWcUxGSWVFdGh0QVQrWDlIL2JkM1JPRkZ6MHhFMnVFaVZwdHZOaU50Tzd6?=
 =?utf-8?B?dE95VWlJUjQ1OWN1eXlSOW42OHFHU3JaQlBWNHprQ2pLc2hybnlObEZCYitt?=
 =?utf-8?B?T1ZBM0J5cmFQK2FYTXcza0tIemZJUENJNXB3Q056REp0QmdDZlpkNkZVcUlC?=
 =?utf-8?B?UDJoL3hPTmx2VloyZ0N4bmdqeHlicGxobTBBdVZQT2FUNERRVTZNWHB4ZXk4?=
 =?utf-8?B?Tjc3S0ZWSG5HeXpuclMwWEVVOUltSjd5UFlGU204OC80T2dSZk5EcTdLa3dm?=
 =?utf-8?B?OU9VZ2lvaUtwdUtDZ0xDRXVQK1oyVlJ4N1pSV1M5WHpWc3E1Y1hiWUNLSE9W?=
 =?utf-8?B?cW0vTEZPZUpZSHpzMU00czdQV2RwaGs4eE9qaWdYcE54TkRieG56T0ZiZ0pS?=
 =?utf-8?B?YTR0NHRMZ0gxMTFJS09lcGtOdm0vWm1tK2FjQkI0VXNMZUlFa0hJOVNzby9m?=
 =?utf-8?B?a0cxVWZkUFlqQzlmb3h6N2tIZHZ3dEIrZHVadmdiOTBaUmM0ZGM5aTJxZzVW?=
 =?utf-8?B?ek5yZ1JjWGtLQThtZmtZUlRYREVNRlBmT1VNU1U2MkRNTU5LZjNERytHYUh0?=
 =?utf-8?B?V2hIdFZRWGFsK1d0b2F0TmhEbzdhREpnMm8yY01PVVlhbFJneXBoSnhUZ21V?=
 =?utf-8?B?bTZCcThNdTNpbEI5RjdHeGRWalFJazEzYmhMeUh0enJCV3lxR1JkdkRzRXV5?=
 =?utf-8?B?dEkvOS9vRDFsR3JGVXNjUWVHZ2JEVk1qZndiWXlHdVhQaUl4VWN6YWdRbHFt?=
 =?utf-8?B?SnI1cEhSQ0dtTHFqd3ZJZUN4L2pMU0s5NkcvWlRNNlk4S0hXd2Q2M1czdklq?=
 =?utf-8?B?WlN5SXp0ejEzT2ljNS9tejBVeVYxQ1duMHNySUo0SG8xT3VUUis5QlpNRklz?=
 =?utf-8?B?UUh2ZzRuYmdzK21LZU5VSTU2anhwT05xSFhhYlRnRDc4Qld1b0s1amxERDhX?=
 =?utf-8?B?NnVkbndEUmNyaTMxSlBRaGsrRzdEbklKVG43Y0dYcTYzNjhSdXRDa2ZxOG5U?=
 =?utf-8?B?TUZCMC9YOW8yblNFaTZreEw5cjU1NzMzMnBtUE00VVRYSzhZVUdSZ2IrV1lO?=
 =?utf-8?B?Qjg3YmJsT2Zya0o0bTlZdDRDa1JEaEFQWEtxSlErUzFXbnRMNGxTend6ckZ4?=
 =?utf-8?B?Ky8yajh3aVdCMmZBMWpTYjRsRXM3WWFrdnAyQXVTZyt6ZFZqdHBWM1hFM0tj?=
 =?utf-8?B?QjNEWHVVVEJFN2JqZWtNYVJlMWdzcngvQUgzSkVPQ0haK0grdzF2UlpyUyt0?=
 =?utf-8?B?VTRZbFRBVVpETlgvdnZqT0hXVFgwZGZ2VWh0RWsrclFMamlQVDZmNEFmVUFr?=
 =?utf-8?B?ZEpUUC96ampMeXBOSXE4NUdRTHZXb1NPVHhYWnllc1l0RDVsdGo1SEFtZ2Na?=
 =?utf-8?B?dUxMeC9IUWhwVVdxc29vUHZUSUtTTlo5TDhEblBUZVZoTEFoWXJpRlVwKzgr?=
 =?utf-8?B?Um1KSlhjNU9MQ3VqWHcrY0NzSHlzQzRJMWZVY1lNalk5b3krQitWWmc5czZh?=
 =?utf-8?B?NWZXVlBlWWNGdmNOYjAxU0JsRUMwZ1ZZTEZjTmFNSGJZREpzbXNZN2ZhMW8w?=
 =?utf-8?B?UlZrUDlVcFA4YjFsRURIWkFibFZub284SnRDVzNVVkVZM05nVTN6RXZ5cUc5?=
 =?utf-8?Q?45k4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcaff23-7012-4413-cf3e-08dae1663617
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 02:10:33.6477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: geMaeOUA+f9sTeKpV9rZ1uxJId3nnMmXjH9lBFaEBXn/kyWiJBzTLQASERSA4bAp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcyBDaHJpc3RpYW4sDQoN
ClllcywgaXQgaXMgbm90IHN1Y2ggbmVlZGVkLg0KSSBjaGVja2VkIHRoaXMgd2l0aCBjaGVja3Bh
dGNoLnBsIHNjcmlwdCBhbmQgbm8gY29tcGxhaW5zIHBvcHBlZCBvdXQgYWJvdXQgdGhpcy4gVGhh
dCBpcyB3ZWlyZC4uLg0KQW55d2F5LCBJIHdpbGwgZml4IHRoaXMgdXAuDQoNCkJSDQpFdmFuDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNr
b2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIERlY2VtYmVy
IDE2LCAyMDIyIDc6NTAgUE0NCj4gVG86IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPjsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2Ft
ZC9wbTogY29ycmVjdCB0aGUgZmFuIHNwZWVkIHJldHJpZXZpbmcgaW4gUFdNDQo+IGZvciBzb21l
IFNNVTEzIGFzaWNzDQo+IA0KPiBBbSAxNi4xMi4yMiB1bSAxMTozNSBzY2hyaWViIEV2YW4gUXVh
bjoNCj4gPiBGb3IgU01VIDEzLjAuMCBhbmQgMTMuMC43LCB0aGUgb3V0cHV0IGZyb20gUE1GVyBp
cyBpbiBwZXJjZW50LiBEcml2ZXINCj4gPiBuZWVkIHRvIGNvbnZlcnQgdGhhdCBpbnRvIGNvcnJl
Y3QgUE1XKDI1NSkgYmFzZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2
YW4ucXVhbkBhbWQuY29tPg0KPiA+IENoYW5nZS1JZDogSTdiYmVhZTNjMGQ4MWM2Y2Y2ZTAwMzNh
YTI4Y2E2ZDI2ZjViNmQxNzgNCj4gPiAtLS0NCj4gPiAgIC4uLi9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9zbXUxMy9zbXVfdjEzXzBfMF9wcHQuYyAgfCAxNQ0KPiArKysrKysrKysrKystLS0NCj4gPiAg
IC4uLi9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYyAgfCAxNQ0K
PiArKysrKysrKysrKystLS0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF8wX3BwdC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF8wX3BwdC5jDQo+ID4gaW5kZXggNjM2Y2I1
NjFmZWE5Li4yODNjZjdjZjk1YWIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfMF9wcHQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzBfcHB0LmMNCj4gPiBAQCAtMTQ0NSwx
MiArMTQ0NSwyMSBAQCBzdGF0aWMgdm9pZCBzbXVfdjEzXzBfMF9nZXRfdW5pcXVlX2lkKHN0cnVj
dA0KPiBzbXVfY29udGV4dCAqc211KQ0KPiA+ICAgc3RhdGljIGludCBzbXVfdjEzXzBfMF9nZXRf
ZmFuX3NwZWVkX3B3bShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCj4gPiAgIAkJCQkJIHVpbnQz
Ml90ICpzcGVlZCkNCj4gPiAgIHsNCj4gPiArCWludCByZXQgPSAwOw0KPiANCj4gUGxlYXNlIGRv
bid0IGluaXRpYWxpemUgbG9jYWwgdmFyaWFibGVzIHdoZW4gdGhlcmUgaXNuJ3QgYSBuZWVkIGZv
ciB0aGlzLg0KPiANCj4gV2Ugb2Z0ZW4gZ2V0IGNvbXBsYWlucyBhYm91dCB0aGlzIGZyb20gYXV0
b21hdGVkIHNjcmlwdHMuDQo+IA0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+IA0KPiA+ICsN
Cj4gPiAgIAlpZiAoIXNwZWVkKQ0KPiA+ICAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gPg0KPiA+IC0J
cmV0dXJuIHNtdV92MTNfMF8wX2dldF9zbXVfbWV0cmljc19kYXRhKHNtdSwNCj4gPiAtCQkJCQkJ
TUVUUklDU19DVVJSX0ZBTlBXTSwNCj4gPiAtCQkJCQkJc3BlZWQpOw0KPiA+ICsJcmV0ID0gc211
X3YxM18wXzBfZ2V0X3NtdV9tZXRyaWNzX2RhdGEoc211LA0KPiA+ICsJCQkJCSAgICAgICBNRVRS
SUNTX0NVUlJfRkFOUFdNLA0KPiA+ICsJCQkJCSAgICAgICBzcGVlZCk7DQo+ID4gKwlpZiAocmV0
KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJLyogQ29udmVydCB0aGUgUE1GVyBv
dXRwdXQgd2hpY2ggaXMgaW4gcGVyY2VudCB0byBwd20oMjU1KSBiYXNlZA0KPiAqLw0KPiA+ICsJ
KnNwZWVkID0gTUlOKCpzcGVlZCAqIDI1NSAvIDEwMCwgMjU1KTsNCj4gPiArDQo+ID4gKwlyZXR1
cm4gMDsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIGludCBzbXVfdjEzXzBfMF9nZXRfZmFu
X3NwZWVkX3JwbShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYw0KPiA+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYw0KPiA+
IGluZGV4IDVlOTM3ZTRlZmI1MS4uZjIwN2YxMDJlZDdlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzdfcHB0LmMNCj4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF83X3BwdC5jDQo+
ID4gQEAgLTEzNjUsMTIgKzEzNjUsMjEgQEAgc3RhdGljIGludA0KPiBzbXVfdjEzXzBfN19wb3B1
bGF0ZV91bWRfc3RhdGVfY2xrKHN0cnVjdCBzbXVfY29udGV4dCAqc211KQ0KPiA+ICAgc3RhdGlj
IGludCBzbXVfdjEzXzBfN19nZXRfZmFuX3NwZWVkX3B3bShzdHJ1Y3Qgc211X2NvbnRleHQgKnNt
dSwNCj4gPiAgIAkJCQkJIHVpbnQzMl90ICpzcGVlZCkNCj4gPiAgIHsNCj4gPiArCWludCByZXQg
PSAwOw0KPiA+ICsNCj4gPiAgIAlpZiAoIXNwZWVkKQ0KPiA+ICAgCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gPg0KPiA+IC0JcmV0dXJuIHNtdV92MTNfMF83X2dldF9zbXVfbWV0cmljc19kYXRhKHNtdSwN
Cj4gPiAtCQkJCQkJTUVUUklDU19DVVJSX0ZBTlBXTSwNCj4gPiAtCQkJCQkJc3BlZWQpOw0KPiA+
ICsJcmV0ID0gc211X3YxM18wXzdfZ2V0X3NtdV9tZXRyaWNzX2RhdGEoc211LA0KPiA+ICsJCQkJ
CSAgICAgICBNRVRSSUNTX0NVUlJfRkFOUFdNLA0KPiA+ICsJCQkJCSAgICAgICBzcGVlZCk7DQo+
ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJLyogQ29udmVy
dCB0aGUgUE1GVyBvdXRwdXQgd2hpY2ggaXMgaW4gcGVyY2VudCB0byBwd20oMjU1KSBiYXNlZA0K
PiAqLw0KPiA+ICsJKnNwZWVkID0gTUlOKCpzcGVlZCAqIDI1NSAvIDEwMCwgMjU1KTsNCj4gPiAr
DQo+ID4gKwlyZXR1cm4gMDsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIGludCBzbXVfdjEz
XzBfN19nZXRfZmFuX3NwZWVkX3JwbShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCg==
