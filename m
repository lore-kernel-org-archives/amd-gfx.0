Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C73C47DDB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 08:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A7C610F178;
	Fri, 26 Jan 2024 08:04:12 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 946EC10F2D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 08:04:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSinIhCevM88zkgp9k+LAqXlMbZyjP1Ckj0Yh9CtlJ+SAz0syGs88mt9cVTX5fPqBPLeJBR+zNUKSM0QfdGjY+d/wBPjWn+IEX2SP5zb2k7A+jJAIgnyUOjIXhkoKT76I+AkuFaxS0WfRGL7KqkMxUSIoP89rmafByDPPC5swAp5P/bTJFFFP2Xn1hkDeZsNNyJFGO0CyGvhTFSbHBQPyqLhZwkJnThxsrd0HseYKB3PIcCM71sXkNOsCvPRlE8m7kxrWZGgThrtNfBfgs5EHEcr0AbO0yGa+X29zEed1Z6Kl6VULrUI6O3kKmEvYtsbzdtlfvDFEug80xwwSfuZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqznWObZQr/MYGATXVv4Tm2svSDn5UJ0maPr0HcVPZk=;
 b=Ooh1BhAvvfN8mRIusSSOM+Rg9Pwk0aQGA59Md0I2A50BeP/FKBUnkJrR5j1rxwCkN/g56zEqOCHy+TRcZLzQB1j0nuEcZMTULfOQzaYdc8EB5MZV8WXTbebS1CFu4emRPp7HY3H1mJEloM10zEGn2iIClp5E5Q9miYeYnVayNBYLR8bO/Abv6M4sArGSXfZgLalt5fqjsfNsX7Q4hx+y3HDjJpxGkc0hhH3gcW0NpXUKphgYU2j5M6PoSZ0DUj+2yKyM7ENVZp0CAkmhCGJaByORDuWX2C0KhK4r16c75NXkermU7eNpa5qGB9pk/tUv9KgHrEPxeEkqxm3m6C6/KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqznWObZQr/MYGATXVv4Tm2svSDn5UJ0maPr0HcVPZk=;
 b=M3XMbiQ+y3rcV7S7DV5Uu10bbg5bc4nqio+7RoRxwAwJlMQCOCeRvkEAt0z2KK5a6b88fpDUmH39k/qiC29/zl+Se6H291DtaFhRpTaUM0bvqUvnaxUbECfqvHBPkq2QkedjVSnapDdkujR8Mu5d4arRGo1zdnn983xEr6IwR5U=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 08:04:05 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::62b1:4407:aa73:333d]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::62b1:4407:aa73:333d%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 08:04:05 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: reset gpu for pm abort case
Thread-Topic: [PATCH 2/2] drm/amdgpu: reset gpu for pm abort case
Thread-Index: AQHaTz3TrRHBNnxGnEmGW4ad3K6E4rDrJQ6AgAAwG3A=
Date: Fri, 26 Jan 2024 08:04:04 +0000
Message-ID: <DS7PR12MB60056096BB24CF04706F1199FB792@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20240125032255.898308-1-Prike.Liang@amd.com>
 <20240125032255.898308-2-Prike.Liang@amd.com>
 <CADnq5_MKmkrCW0Gia74DJhq297W=AGeW8J4tQxxFxcSjt+-f3A@mail.gmail.com>
In-Reply-To: <CADnq5_MKmkrCW0Gia74DJhq297W=AGeW8J4tQxxFxcSjt+-f3A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9506f0d5-8d58-47c8-bb5b-26b61db9a51b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-26T01:48:56Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA3PR12MB8812:EE_
x-ms-office365-filtering-correlation-id: 3456de54-c0df-438c-87e6-08dc1e455d87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CPSz7QRyiI9pM/yx5h+h71zgEygsY5A80mUTIrr90cqyhrsnCh1a8uBqd0cqhIaIgTz5UjGUT3MB8HN5nSf0MlRQFG6vZows/bP6G7/W8Fplj0tnfiiHDEZ07Iwq1+znNj5ao3HHKAeXn2/VLCwbeA/cjUgjbaz0EUtrQ9Bu83VaPMdd2XAgHELsIFTT/66WLy8ChKCyEBtMeLvahWdZ91b7nQ8yvhUhuZSFPFd40lmNcJB+5Ei6plu7S9zTPblb0tQb9v3OwvcKmwX8pZ6mp3c01UCKW26dk7buXY3r7UhzhBpL+Dp5DMWXzQIBsQaSF7vz2Hm6wN009EUYphRe4ikHL0fNSnPEvL02ZQ9lQ/T1jUWjj4iDodjxLC4/oAZsVDPdCmEefz6N5f5XdR4Nso71nGwXSVGrH0QMMESsSe16/HHKuyWwtZh73qJBWxSWEpLKRO7EZqbZrzfKWDEdG+olCE2E2C8WrOeyqaL2+VPsKgYCYk9T36KAKq0QJeJs8+sOwJuZbxl8adExsnFc1GDwvqx4rW+B5NxgUbL8Gaq4NLdiD8xYrw2iiZXRgNlsHySLMRD2727ZBKp/h98EpNtq1g+PSjOm3gjxsMQJSB09X8CMnmWSUEpv5AO72uAc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(2906002)(52536014)(122000001)(5660300002)(41300700001)(38070700009)(33656002)(26005)(478600001)(53546011)(9686003)(7696005)(6506007)(71200400001)(8676002)(8936002)(4326008)(83380400001)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(316002)(6916009)(76116006)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vmk3bWlNSU1reTZ4WmFSY1BZTWdvNWhiQTBwWXFvcldrQUJxSUI3RDFjQUpr?=
 =?utf-8?B?S1Z5dy90a3laYUkxdVMwRzJOUUFOaXArekVBV3lWTUFGK0NLMXNxRi9GcXN2?=
 =?utf-8?B?R2lpR2FhVENmdjllRm5RVThkM0U1RFIvZ05rRXVnZGhJNzlhYUZCdjVHTE9S?=
 =?utf-8?B?V015RFVCWHBYS0lzSXlmZ000NEtvbWNRaE0ra3RGcnlUZmZsSkQ3RHhrVTRQ?=
 =?utf-8?B?RDk0WXFSbkR3ejJ0dzVCUFpsZjU5d3JFbkJ4WkpkUE03YkxmSGJxVFAxdFlP?=
 =?utf-8?B?ekE0S3NBdHNEdmx0QmJxRkVLMGJ6TlFYS0FuUkc5UFhzTDBhRnVFeWh6MndU?=
 =?utf-8?B?RTBscXdGTzlqRWxtc3c4MkNCVHJWNVB5OTJldmo0MXBSTEF0TzA3NmFYck1R?=
 =?utf-8?B?YzNQVy94cisyQjJWSjNEd3owaWpNMmZVdlVzcHhXa1Y0clNqYnE4a3g1MDZD?=
 =?utf-8?B?UmRqR2ZBVkRSMWVnNUpZK3EwOVN4WExGZytPSDdjSXZ0YTFrcmxwemNrdWUw?=
 =?utf-8?B?U3NaWTVpbUFPUFNjMStZS1FWeENjSWhwaDkxVmRjVkd5ZlpIamIrelBHUENs?=
 =?utf-8?B?QkRzakhQS1hDWWZ3SFA5NEl0MWFjZStwMm1JVmhiWldCanhDMktaTm5lT0ZD?=
 =?utf-8?B?KzRSOFNMYTJnL0ZBZ1MwUlpYemw4cXJzZUQxTGJyM1dNQ1RPMmdTUnJVK2s4?=
 =?utf-8?B?RngvN2I5UEVtd1FXQVdPUWY1SytodkxveGRrcDgxR2FWclV3endnb0RVSXRJ?=
 =?utf-8?B?OURMMG1qVHM5VjcyazRPNWNiUG80QWVhcXdWK2htTGFkazNUQUE0UE5LMGQx?=
 =?utf-8?B?bHF4TFlXemUxQVZpTVFrbERidHRMSi82SzErSlFJMjBDSWZqbitHL1NRVUor?=
 =?utf-8?B?MTJ2ZmtQaWlrUm44ZjMvN1UzcWRLaVBPNXVUMmxwTUhLYTJaVkRDYmJmdGhM?=
 =?utf-8?B?NWc2aXFGT3dJUWpVVzB6Vy9TdG1acWRMNk1qbVBreGNPZDdQTmFRSXRLSXR2?=
 =?utf-8?B?ODEySnJGT2JZMkhjOUpLT2tpd3dnbTFWK3BNV3FpL0xCNld6RHFyKzZQVFgr?=
 =?utf-8?B?SmdkbG41Z09icXE3Y3BEKzlFampoQUZ3ZzdoTWQ0L250dzJHdm9UK0p2dmlR?=
 =?utf-8?B?bjVucTdSbzYrT1phQlcxZzJkS0ZtTzZIVzF2ZUoyb3YwRkxWNDB1ZGhsbG12?=
 =?utf-8?B?bHk4NXJqVGlQTHE5bytlUGxhaktuUnk5OHRvaFNYWVFYVGtoLzViWlZTZzBu?=
 =?utf-8?B?NXBITDZHNG1VZTNBSVJhQ2R3c21CZk9qcThUMzJ3Nlo2UUhXQ0w1bEpKN2la?=
 =?utf-8?B?WkNLNDZXV3VEa3p0cTRlMkppQXRPNWhzL2Eya3dKTTQvTDlyTE9qWUcrOEh5?=
 =?utf-8?B?WklBb2NSQzFQQ0tDVjUrQ3lkVkhUeU02dUxqVFlmTlZvZCtCQ3QxMW1pVlpx?=
 =?utf-8?B?UkJsTThOanBSbFVScjZPSVJmQ0dOUnkwTVh2eGx1VUtDRmNhRVZ3ZVBvSlVk?=
 =?utf-8?B?ZXhldW93TWM3eTgyZEtKL2FidWd3MHN4UHZSWDNVa3dvQm1xR0xaclpibGI5?=
 =?utf-8?B?NU5tbEN5dWMySG4xNnRMaFRWWEhaSmV0eDNPelBVblR0ekh3M0l2UTE1dDBV?=
 =?utf-8?B?dWVVaUJ0S3NBVjZQYi95YTlRMlhoZ1VvcGIyN3k0YkE2d0hFMm9QLzdEelNx?=
 =?utf-8?B?K2trNFcyTjlscjdBTVFYK3htRm9XNWdjbjdsamlsYzJJeDM1cHVJUFBIK01H?=
 =?utf-8?B?VkRYT0kxUkp4aEJxRk1aaGpwdHFMeVh6WWJoU3JCdmdBc0ZCd21XTEZXd2tL?=
 =?utf-8?B?cjk3NXk4bzlUWEFJN3c1Rklac1JkUGMxM0kydlZxdXBTdytLcE0yK1FUMC8v?=
 =?utf-8?B?d0Z6RHRXUFcxUC9XV09iN0hHVy9oVW9YUTFyd3dZNzY2Nnk2MVZMVzhrS0RF?=
 =?utf-8?B?bjN0M29BYUtBcEZEQjVaeW0rcUJKemEzeUp2R0Q5KzJpM2NTWk5ka1BSRVE4?=
 =?utf-8?B?UDhKUTkrbkRsZFhsQ3dBRHI3L0hCRDF3NWhKc01TaGpTMkVJUUNSN3lkbDZz?=
 =?utf-8?B?bk0rVDFQeWs5SGZDTTU4aHRZNVFhRC9ZbzlkSmVHVzk0NGtKeFpvcWI3OW5v?=
 =?utf-8?Q?RRj4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3456de54-c0df-438c-87e6-08dc1e455d87
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 08:04:05.0096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CldffjwaFpoexFads2IrxwB4j3u0jRL3qBSaOZC4LJPM/Lv76a/8/RT3fQlEgmtC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sharma,
 Deepak" <Deepak.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gRnJvbTogQWxleCBEZXVjaGVy
IDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAyNiwgMjAy
NCA2OjU3IEFNDQo+IFRvOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+IENj
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgU2hhcm1hLCBEZWVwYWsNCj4gPERlZXBhay5TaGFy
bWFAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6IHJlc2V0
IGdwdSBmb3IgcG0gYWJvcnQgY2FzZQ0KPg0KPiBPbiBXZWQsIEphbiAyNCwgMjAyNCBhdCAxMTox
MeKAr1BNIFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+
IEluIHRoZSBwbSBhYm9ydCBjYXNlIHRoZSBnZnggcG93ZXIgcmFpbCBub3QgdHVybiBvZmYgZnJv
bSBGQ0ggc2lkZSBhbmQNCj4gPiB0aGlzIHdpbGwgbGVhZCB0byB0aGUgZ2Z4IHJlaW5pdGlhbGl6
ZWQgZmFpbGVkIGJhc2Ugb24gdGhlIHVua25vd24gZ2Z4DQo+ID4gSFcgc3RhdHVzLCBzbyBsZXQn
cyByZXNldCB0aGUgZ3B1IHRvIGEga25vd24gZ29vZCBwb3dlciBzdGF0ZS4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA1ICsrKysr
DQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgICAgICAgICB8IDggKysr
KysrKy0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMNCj4gPiBpbmRleCA1NmQ5ZGZhNjEyOTAuLjRjNDBmZmFhYTVjMiAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiBAQCAtNDYy
Nyw2ICs0NjI3LDExIEBAIGludCBhbWRncHVfZGV2aWNlX3Jlc3VtZShzdHJ1Y3QgZHJtX2Rldmlj
ZQ0KPiAqZGV2LCBib29sIGZiY29uKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biByOw0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gKyAgICAgICBpZihhbWRncHVfYXNpY19uZWVk
X3Jlc2V0X29uX2luaXQoYWRldikpIHsNCj4NCj4gc3BhY2UgYmV0d2VlbiBpZiBhbmQgKC4NCj4N
Cj4gQWxzbywgSSB0aGluayB3ZSBuZWVkIHRvIGNoZWNrIHRoYXQgd2UgYXJlIG5vdCBpbiBTMGl4
IGFzIHdlbGwgb3RoZXJ3aXNlIEkgdGhpbmsNCj4gd2UnbGwgYWx3YXlzIHJlc2V0IGluIFMwaXgu
ICBXZSBjb3VsZCBwcm9iYWJseSBkbyBhd2F5IHdpdGggdGhlIEdQVSByZXNldCBpbg0KPiB0aGUg
c3VzcGVuZF9ub2lycSBjYWxsYmFjayB3aXRoIHRoaXMgY2hhbmdlLCBidXQgbWF5YmUgbWFrZSB0
aGF0IGEgc2VwYXJhdGUNCj4gZm9sbG93IHVwIHBhdGNoLg0KPg0KPiBBbGV4DQo+DQpbTGlhbmcs
IFByaWtlXSBZZXMsIHRoZXJlIG5lZWRuJ3QgcmVzZXQgR1BVIGZvciB0aGUgczBpeCBzdXNwZW5k
IGFib3J0IGNhc2UgYW5kIHMwaXggc3VzcGVuc2lvbiB3YXMgYWxyZWFkeQ0KZmlsdGVyZWQgb3V0
IGluIHRoZSBuZWVkX3Jlc2V0X29uX2luaXQoKSBhdCB0aGUgZW5kIG9mIHRoaXMgcGF0Y2guIFJl
Z2FyZHMgdG8gcmVzZXQgR1BVIGF0IHN1c3BlbmRfbm9pcnEgY2FsbGJhY2ssDQp0aGVyZSBhbHJl
YWR5IHNvcnQgb3V0IHNvbWUgY2FzZXMgdGhhdCByZXF1aXJlIHRvIHJlc2V0IGF0IGFtZGdwdV9h
Y3BpX3Nob3VsZF9ncHVfcmVzZXQoKSBhbmQgaWYgZG8gdGhlIHJlc2V0DQphdCB0aGUgbm9faXJx
IHN1c3BlbmQgcGhhc2UgdGhlbiB3aWxsIG1pc3MgdGhlIGZpcnN0IHN1c3BlbmQgYWJvcnQgY2Fz
ZS4gSU1PLCB3ZSBuZWVkIGZpbGVyIG91dCB0aGUgZm9sbG93aW5nIHR3byBjYXNlcyBhbmQgdXBk
YXRlIHRoZQ0KcGF0Y2ggdG8gYmUgYSBtb3JlIGdlbmVyaWMgc29sdXRpb24gYWNjb3JkaW5nbHku
DQoNCjEpIFRoZSBQTSBzdXNwZW5kIGFib3J0IGNhc2Ugd2hpY2ggaXMgZXhpdCBQTSBzdXNwZW5z
aW9uIHByb2Nlc3MgYmVmb3JlIHJ1bnMgaW50byBub19pcnEgc3VzcGVuZCBwaGFzZS4NCjIpICBU
aGUgUE0gc3VzcGVuZCBjb21wbGV0ZWx5IGJ1dCB0aGUgR1BVIGRvZXNuJ3QgcG93ZXIgb2ZmIGFu
ZCBQU1AgVE9TIGlzIGFsaXZlIGF0IHRoZSBhbWRncHUgcmVzdW1lIGVhcmx5IGJlZ2lubmluZyBh
bmQgdGhpcyBjYXNlDQpoYXBwZWQgYXQgcGFzc3Rocm91Z2ggZGV2aWNlIHN1c3BlbnNpb24gYXQg
WGVuIGd1ZXN0IHNpZGUuDQoNCj4gPiArICAgICAgICAgICAgICAgRFJNX0lORk8oIlBNIGFib3J0
IGNhc2UgYW5kIGxldCdzIHJlc2V0IGFzaWMgXG4iKTsNCj4gPiArICAgICAgICAgICAgICAgYW1k
Z3B1X2FzaWNfcmVzZXQoYWRldik7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICAgICAgICAg
aWYgKGRldi0+c3dpdGNoX3Bvd2VyX3N0YXRlID09IERSTV9TV0lUQ0hfUE9XRVJfT0ZGKQ0KPiA+
ICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zb2MxNS5jDQo+ID4gaW5kZXggMTUwMzNlZmVjMmJhLi45MzI5YTAwYjZhYmMgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCj4gPiBAQCAtODA0LDkgKzgwNCwx
NiBAQCBzdGF0aWMgYm9vbCBzb2MxNV9uZWVkX3Jlc2V0X29uX2luaXQoc3RydWN0DQo+IGFtZGdw
dV9kZXZpY2UgKmFkZXYpDQo+ID4gICAgICAgICBpZiAoYWRldi0+YXNpY190eXBlID09IENISVBf
UkVOT0lSKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPg0KPiA+ICsgICAg
ICAgc29sX3JlZyA9IFJSRUczMl9TT0MxNShNUDAsIDAsIG1tTVAwX1NNTl9DMlBNU0dfODEpOw0K
PiA+ICsNCj4gPiAgICAgICAgIC8qIEp1c3QgcmV0dXJuIGZhbHNlIGZvciBzb2MxNSBHUFVzLiAg
UmVzZXQgZG9lcyBub3Qgc2VlbSB0bw0KPiA+ICAgICAgICAgICogYmUgbmVjZXNzYXJ5Lg0KPiA+
ICAgICAgICAgICovDQo+ID4gKyAgICAgICBpZiAoYWRldi0+aW5fc3VzcGVuZCAmJiAhYWRldi0+
aW5fczBpeCAmJg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICFhZGV2LT5wbV9jb21wbGV0
ZSAmJg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHNvbF9yZWcpDQo+ID4gKyAgICAgICAg
ICAgICAgIHJldHVybiB0cnVlOw0KPiA+ICsNCj4gPiAgICAgICAgIGlmICghYW1kZ3B1X3Bhc3N0
aHJvdWdoKGFkZXYpKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4NCj4g
PiBAQCAtODE2LDcgKzgyMyw2IEBAIHN0YXRpYyBib29sIHNvYzE1X25lZWRfcmVzZXRfb25faW5p
dChzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPiAgICAgICAgIC8qIENoZWNrIHNP
UyBzaWduIG9mIGxpZmUgcmVnaXN0ZXIgdG8gY29uZmlybSBzeXMgZHJpdmVyIGFuZCBzT1MNCj4g
PiAgICAgICAgICAqIGFyZSBhbHJlYWR5IGJlZW4gbG9hZGVkLg0KPiA+ICAgICAgICAgICovDQo+
ID4gLSAgICAgICBzb2xfcmVnID0gUlJFRzMyX1NPQzE1KE1QMCwgMCwgbW1NUDBfU01OX0MyUE1T
R184MSk7DQo+ID4gICAgICAgICBpZiAoc29sX3JlZykNCj4gPiAgICAgICAgICAgICAgICAgcmV0
dXJuIHRydWU7DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=
