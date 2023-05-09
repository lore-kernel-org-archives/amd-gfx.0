Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F210BC7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 05:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FFF610E061;
	Tue,  9 May 2023 05:05:33 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AF1110E061
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 05:05:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvt11GQzCTmFq5/uNJRVYICCkLgo7OQ5mRLmBZA6IRL5HxjmBeOOLIsXA9ffO9aDooyIYY62jY3HkdShIl7DbdSkeezMdEvTh0IoKe/pEf2jaxdP39tmxKz9+opEHNag8KW0X0FoeTdZNzbitNbJNRC4wFQxm0/tgErmivMnVQkHWJIethBrrkcza044kYdlBYG6sC4q7cqFmot/T6l1Zgdv3gfCgv+x1KWwRKa8DheL7um/BNA+EFNAYSILNALimEPWydTBAh2TmSCWfxSyqZIWMa2vIyTSFNjLu2ayQMSwl0wF6TxSdrYG5P12HMmc3XFb0WzC4X4fHR6mppbX4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dELtofIr0A8QICR9GR5jbS4f5EeQfm6n4tSVNYkjAuA=;
 b=j1+T4domWaDhf7CulKrlcuMSJOkz9uv0qbMhyInXo/HYTqwSwkK5W+wrH/IaJ3QiMdEFaduY/GcEw20buCm/4KrXiqbr4m3yB/eo7ALorc4k/dntZm0oYBgXwkXldDlut5qMMtrE97iJJLLHXuX2YfhiE+SFLyo01sJ0RQ8twPnd+3Zvg1+l0xgajegPEiybV0yLRg285+kbYIq6gMHhGrkDb2eBcut4+4djhSezi5smInzL79KzoEmqUZuM+TwScvN5lR7DpxQW6YGKzqEjYVcQ6lZoj8XkhovlVJ+WcHSgXFN3VobXd3lBbNb9u1HB/9NLnwn3NmsdVfRWNlzv9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dELtofIr0A8QICR9GR5jbS4f5EeQfm6n4tSVNYkjAuA=;
 b=YzlCtXNyylrT7Ylqt28497kCt8EELRCeNALUiNtH+jPtkB1qdrmf4d+dbcQDeSY+k6vfykhXtvYBd/XEECOcqbgQmVrOa4AeVOhvINynvWDOVUttBA4grAo+0ckScwVgQc5xkB9lwRs6GnmuvloEoV061XSJnNZAqP/P66ddSUs=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.30; Tue, 9 May
 2023 05:05:27 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c7b1:f457:da06:8bc8]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c7b1:f457:da06:8bc8%3]) with mapi id 15.20.6363.027; Tue, 9 May 2023
 05:05:27 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Quan, 
 Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amd/pm: avoid potential UBSAN issue on legacy asics
Thread-Topic: [PATCH] drm/amd/pm: avoid potential UBSAN issue on legacy asics
Thread-Index: AQHZgheeB6/lG1it1kmZlpjAYk1Ee69RTcSAgAAVlaA=
Date: Tue, 9 May 2023 05:05:26 +0000
Message-ID: <DM5PR12MB2469FCB4BD93182AB15057B0F1769@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230509014233.2101573-1-guchun.chen@amd.com>
 <a00ae4e8-1ba8-560e-2f31-23c7ebe0588b@amd.com>
In-Reply-To: <a00ae4e8-1ba8-560e-2f31-23c7ebe0588b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|PH8PR12MB6865:EE_
x-ms-office365-filtering-correlation-id: 522df483-76f9-4f69-781e-08db504b00c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I5flnmX0NG7jVOHgR9cTCkA8OFRkcWI+dt1jyp1j0jpGMfzcsYkJNvaC42pZpXIfw8t0rw2YCYBiUhGaaSUck6vZZhAU4iaifoxPMD5P3yW6oCc2KzJH5yMdY0pcb18sQ7COciwYMFmy90g+7aETcxbJp1U255Ug21C8PtdQXDOLQLUikFJkfi1e6/ehpRjGRWCWo7qlJLjoAvRKz0zr7unEpZI9OujOy7w7SVizMzsYPg0dPPXYks3ydOTKY0IJkCrzH6/R9MUhj9S3QoO/s18gkEfXeyPnYgSM1JPruHPnzjfVh6ANph4+2Vy9T25f4zd+bOvUtBHvc216ZfqVhiBbhBtC23Mi2aO8nmrp+tGcSrnwmxDFhvxbZ3K047p/1S0BtdT9kwgA4OKd+f0LForIfKQyMqbQTFzMhorxb0XYDKRpP/hF3qFXTDyy3pVeAAWcQtzMIoKan8y2wHfr79UoOB4XXIwLpGbaBnB7WDAWzlmmbjF5DsBouVOt9sAr/N3QsVWKocQp0vdczO1r9lxqe6m5HsHP2Roo1GOPoxa4MRZRowmrtpZunIOg65b35PJ7Rc2qtrTgX1rx/Q91B3EkIaVZg++23ZabTgsu3wM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199021)(83380400001)(186003)(2906002)(38100700002)(86362001)(33656002)(38070700005)(122000001)(55016003)(5660300002)(71200400001)(52536014)(8936002)(8676002)(6506007)(66556008)(66476007)(66446008)(66946007)(64756008)(6636002)(76116006)(7696005)(41300700001)(316002)(478600001)(53546011)(9686003)(110136005)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTJlbWk1UVdISkdBdllMVGEwT3lKVmpaR1ppamswSkIzL3U1SVRNdWdHN3VU?=
 =?utf-8?B?TlU3cEZ6M3RId0w5bE93d04wQnVkZDdIdGxnaHJDUG8zZTREUytMUjE1bzZj?=
 =?utf-8?B?blNFMis0UktWSmRreVZ2Nyt0MnNFZzViditVOTR4TWw4dlIxZm15czFlVlA2?=
 =?utf-8?B?eXJWQ0srTjhxdnFKdUV5K0xGYTFKRE9sUkJyUFhFQmZzemVJOWI3Nlp3UXJy?=
 =?utf-8?B?U3dlZWZOaEUrSXlSanQ4NnpJQlQ3ZERTM2NDZWFiQmUzUWFTMmZMREsraDZv?=
 =?utf-8?B?T2NIaVRIMFJUNC8wR1o2a1hGK2RhS3lrczR6R0lQVWJQeW9WWWRXbGRDaG1q?=
 =?utf-8?B?ZDZMU0VaOWZyMkd2L2R5czFnQzNkdFJFaDVaZWtkbzkwQmVXcHhoRDdoQjJ5?=
 =?utf-8?B?QU93OGdhUTRwemVmNUdEcVN1L2Nlc1orZUZ5QUFlOFFuS3pLWFFZV2p1b1o4?=
 =?utf-8?B?aGxMeFprQU5QMGFVdUdiMURaQkxuSDZ2dWpIN1RrZnhFUkNZc0ErQmJEQnRS?=
 =?utf-8?B?NitkSHZlakZ0NkhIQ0RkZ09tclJrOWE1YzRvSnRyNk5JVzE3NXJJSnVGSGRu?=
 =?utf-8?B?R0FHQkFBYW0zYS9tVU1SaDQ3Z2hPTmpZSmFML013RVRpV1pTV2FZWityM2E4?=
 =?utf-8?B?aTh5ejVKTUQ5eE5QcnFuYnFFUXlPN3oyT3grWGk1eVNRVllPZjAzMVhTSGxp?=
 =?utf-8?B?b1k1NlFQdGMxdXYwU0dFWnN4UldJaDlIcks5T1owTFhpb0EwR0dHanJRdkVx?=
 =?utf-8?B?bG9tMC9oZzBnSjg1NzhVR2dNa2JPZFR1dnN0RHVXKzdGRGdMVDNyeWxGYm1W?=
 =?utf-8?B?cG1BTkw1dXU4ejhHWWRIemFpY1dISm5GU1RwQWc2TXFtOHRjLzNrNkJYdjcr?=
 =?utf-8?B?V3IvL2UwNHpIRHAzQzFCdXpUREZBcFZwNjZoVGhIODN0TVlZb1gzTHNWME50?=
 =?utf-8?B?ek81RmFEMnM1b3N4N0VaaTRlRUZxQkpBbkZ0SHR0MUVJenUySDVlblRPNW04?=
 =?utf-8?B?Q2NJbmVRSHVOZkVtRnIzRThJS1Z5WXdVT0tyZmppb3JCT1MyTG5Ga255cWQv?=
 =?utf-8?B?bDJlL1V1Q0REbmpIb0NpZVBxcktRcy9tcE83cDdYVkJhOEJPQWw0dEJRc3o3?=
 =?utf-8?B?MXJZY3pYZEdxbVp0bGJDZDBiWjk1UEkxV043QkVrQ2tHM1BzSDlJWTJLNGow?=
 =?utf-8?B?UnFMWEczNWV5WTdidkhiaE9pRVN4NVhobzJtTlQ5b05IWm4vQVNOM3FyZjFq?=
 =?utf-8?B?RnVkTndVeGNDOEl5RkVId2RwZnZGb3dEZFJWY2E1VTMrUHVEa2JHbnNUU0dC?=
 =?utf-8?B?U3hJYW4yM3NZZGZaSXdJUVhKZ0U1bjZla255UWpWcUFkY0RzeWFnVWdyTTRZ?=
 =?utf-8?B?eFB2VGxxdXYydDdQS2dzY0JkaFdoVThlaUlnWXgxVGN1K01qZ09rTnlTU0FE?=
 =?utf-8?B?R3BUU3FhUTZkU1d1b1M1eVBTNEU2TENHVjEvenBCN2ZZRGk4MVg1Q1hySysy?=
 =?utf-8?B?RGE3VU0yajZ0SE5iRTgwLytSK2loeHZpaXRtK2lUV21iYTZpOWU5WVlIOG5F?=
 =?utf-8?B?d0pRYUU5SE13dTJjdmhmNE5tMDQrVVlyNFB4WkdFT0daRDVxOEdZWVdvVnFU?=
 =?utf-8?B?aVZMVTRFakdod1NpMkhhdnBLeXVnRm03dGw2UWZGV1JlUGFlUlpRT0sxa0c1?=
 =?utf-8?B?Wm9kNEpBV3JtTHI1U1l5YTRPUCtpUFVzNHRIZHlDUkxlNDhoNXpMYTVBUmpK?=
 =?utf-8?B?d3lzRVVJV2k1RW9UTnFyekd2M2NodzVrRERkeDBSUXhlQ1pYOVVrWHlwRWpZ?=
 =?utf-8?B?NExhMzcrODNBK2lRS3M2a0lNWkxNY05JN2loZEIrMURpOUNMVmR3RFU0Y1JL?=
 =?utf-8?B?REFwK1JDZFo0Q0xGTVdiSkdsa2JYdTJhQXNSME4vZHJGNnZZYlBYWU9RSWRH?=
 =?utf-8?B?ejRrSHNaME1SQ2N2YUpSNUYzZGl0c25lQTJzZXAxUEJmMWczNUVXdGNmbkhp?=
 =?utf-8?B?RUI4UWtTdWlnZVdXNGtxRzhzQXJjNTVON2c1dDMwVzdFZzRBNFRzN2trTkhG?=
 =?utf-8?B?NUdTdjNtOHdFQWs2VUpVcmpoT3V2SXo5U3A1TlJRSlkyc1J2aldsWlY1YlRh?=
 =?utf-8?Q?kA2k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522df483-76f9-4f69-781e-08db504b00c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 05:05:26.8196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4IiV21gx3bwBWVA0QpB9iJPuArIQy9eLYxprFvx3cwbdGod86AQPR1CcKlDrJ/xKZQUIJjPVYCBaPcqFhOrGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExp
am8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWF5IDksIDIwMjMgMTE6NDcgQU0N
Cj4gVG86IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT47IGFtZC0NCj4gZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcNCj4gPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47
IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBk
cm0vYW1kL3BtOiBhdm9pZCBwb3RlbnRpYWwgVUJTQU4gaXNzdWUgb24gbGVnYWN5DQo+IGFzaWNz
DQo+IA0KPiANCj4gDQo+IE9uIDUvOS8yMDIzIDc6MTIgQU0sIEd1Y2h1biBDaGVuIHdyb3RlOg0K
PiA+IFByZXZlbnQgZnVydGhlciBjYXN0aW5nIG9uIGNoaXAgTVVMTElOUy9LQUJJTkkvS0FWRVJJ
IHdoZW4gY2FsbGluZw0KPiA+IGFtZGdwdV9kcG1faXNfb3ZlcmRyaXZlX3N1cHBvcnRlZCwgdGhp
cyBjYW4gYXZvaWQgVUJTQU4gY29tcGxhaW4gaW4NCj4gPiBpbml0IHNlcXVlbmNlLg0KPiA+DQo+
ID4gU3VnZ2VzdGVkLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfZHBtLmMgfCAxMCArKysrKysrKy0tDQo+
ID4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X2RwbS5jDQo+
ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9kcG0uYw0KPiA+IGluZGV4IDg2MjQ2
ZjY5ZGJlMS4uY2NkM2VhODllYWNmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG0vYW1kZ3B1X2RwbS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRn
cHVfZHBtLmMNCj4gPiBAQCAtMTQ2Nyw4ICsxNDY3LDE0IEBAIGludA0KPiBhbWRncHVfZHBtX2lz
X292ZXJkcml2ZV9zdXBwb3J0ZWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gICAJ
fSBlbHNlIHsNCj4gPiAgIAkJc3RydWN0IHBwX2h3bWdyICpod21ncjsNCj4gPg0KPiANCj4gSW5z
dGVhZCBvZiBmYW1pbHkgY2hlY2ssIHdoYXQgaWYgeW91IHdyYXAgaXQgbGlrZSAtDQo+IA0KPiBp
c19sZWdhY3lfZHBtKGFkZXYpDQo+IAlyZXR1cm4gKGFkZXYtPnBvd2VycGxheS5wcF9oYW5kbGUg
PT0gYWRldikNCj4gDQo+IENvdWxkIGJlIHVzZWZ1bCBmb3IgbGVnYWN5IGRwbSBjaGVja3MuDQoN
ClNvdW5kcyBnb29kLiBXaWxsIGFkZHJlc3MgaXQgaW4gdjIuDQoNClJlZ2FyZHMsDQpHdWNodW4N
Cj4gVGhhbmtzLA0KPiBMaWpvDQo+IA0KPiA+IC0JCS8qIFNJIGFzaWMgZG9lcyBub3QgY2Fycnkg
b2RfZW5hYmxlZCAqLw0KPiA+IC0JCWlmIChhZGV2LT5mYW1pbHkgPT0gQU1ER1BVX0ZBTUlMWV9T
SSkNCj4gPiArCQkvKg0KPiA+ICsJCSAqIFNJIGFzaWMgYW5kIGNoaXAgTVVMTElOUy9LQUJJTkkv
S0FWRVJJIGRvIG5vdCBjYXJyeQ0KPiA+ICsJCSAqIG9kX2VuYWJsZWQsIGFzIGl0cyBwcF9oYW5k
bGUgaXMgY2FzdGVkIGZyb20gYWRldi4NCj4gPiArCQkgKi8NCj4gPiArCQlpZiAoKGFkZXYtPmZh
bWlseSA9PSBBTURHUFVfRkFNSUxZX1NJKSB8fA0KPiA+ICsJCSAgICAoYWRldi0+YXNpY190eXBl
ID09IENISVBfTVVMTElOUykgfHwNCj4gPiArCQkgICAgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQ
X0tBQklOSSkgfHwNCj4gPiArCQkgICAgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX0tBVkVSSSkp
DQo+ID4gICAJCQlyZXR1cm4gZmFsc2U7DQo+ID4NCj4gPiAgIAkJaHdtZ3IgPSAoc3RydWN0IHBw
X2h3bWdyICopYWRldi0+cG93ZXJwbGF5LnBwX2hhbmRsZTsNCg==
