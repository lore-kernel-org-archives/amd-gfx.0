Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BDCC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 15:50:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 055F510E3FD;
	Wed, 29 Jun 2022 15:50:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA7E110E1E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 15:50:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8Wpbzlru4Jzkovbk2KkxpKs2+TWkMc/IBis85hmGaCJDL+09uLW9Yhj9ZZA3DJGLC1mUkd55siR0HZZ3m7PjiLCMft0IN1mR8IUHvrvFRhmu+IJCL+ff7kdC/ALuEKJcLBKUr4rjo/KyYp8E1bEfdOhAW9LMsAmU6TumZWWVx6RK9ckAm1L6Y1JO6xkFF13Rl8LS4S1JWz/fuS9f7gnggO2le5pJdzV5t2cr90Riafqlro/ncg+W62CeRtdmSZQMIsT+ifttrDd7/a1khw5QSNJXMiZgIHlYxa7xzu5JT9nUlkVLbkKCsrKVleE2j0iVudM3xPNkQYlrTCAYnTtsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdwBpTS9ThVH6PRYnQacOXTRe/vVbrHML8pFch5yV3g=;
 b=WEYaZRRtHDFPofFaoELpE7ute4rh1d4XXhZ5aJzi9ug9I5boywfqkTz5YZTQLCAnNpNHrGkx5unJLmGkIeqkdFS5dpm4z+ab6NTQDYASUnDysmhmVfJoDqd/sjUoLXTWDi5SO6jCGGOA+lGxJSt+REVUJGJgmBoxNzYJLFTkr5BnfJsiVivQF/Mm1TS2y/TY7g3vv0/IVs47HPhVV7+B4Jkhq0H9eS4NYCW1LK1wkJBpuieEaDplT0T0yq4GgrGoPlM6+qLtpqzMFso9KvMHubeXxBou/Kn/0N4vwTaViq5NDSl6vKA7+w+kAqzOfSflyhK6ua7aqx6xOsyo7VpVUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdwBpTS9ThVH6PRYnQacOXTRe/vVbrHML8pFch5yV3g=;
 b=ZuzeurdR4TxMf+4ZpNp8WaAavkMqUlKCsm4w6SGnFFhntlTdStPfmYewG9DY3Xvc81V4x30lL+sHQhwL8Wen/hmbuGVMy/9qudWMnY0eaxb4aTsf+Fl8yrBcVpbxzEioVNFbOIHLdzGCTp4Tply2DwwH5raQ/VJNJ/k39M4x1xE=
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 15:49:58 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::fd9e:c9da:16b5:a35b]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::fd9e:c9da:16b5:a35b%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 15:49:58 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
Subject: RE: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
Thread-Topic: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
Thread-Index: AQHYi0ZmJwh8SNuw3EmRE3n9zwdWGK1leoiAgAAEZPCAAOsdAIAAHKiA
Date: Wed, 29 Jun 2022 15:49:58 +0000
Message-ID: <SN1PR12MB25752B77126EEA01DB36A4EBE3BB9@SN1PR12MB2575.namprd12.prod.outlook.com>
References: <20220628232538.1316250-1-Ramesh.Errabolu@amd.com>
 <846ecd13-edaf-c0eb-44a9-5232dca997c7@amd.com>
 <SN1PR12MB2575F5E425FB5B43CB1BF119E3BB9@SN1PR12MB2575.namprd12.prod.outlook.com>
 <3e62a389-68b8-bd38-54a9-8fdb6b630c34@amd.com>
In-Reply-To: <3e62a389-68b8-bd38-54a9-8fdb6b630c34@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-29T15:49:55Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f8bd1d6e-9639-4f55-8144-a1830425ec91;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-29T15:49:55Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: ce5b2cfc-412d-4881-b6fb-997ec2580890
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56557dc5-782f-41f8-79ba-08da59e704eb
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qyz+YFoP6MipuXW22pdVHEwrIsVPQQPNS7L2G+oCy6SmlYK5BxnO7DSvRpyL/n4SxB3Q2jAX7aatFf3lFrdfU/VnM6s0iUWLYXp9dr81p1u7PZZRN5sfen1l08hA8WO9ScZ2l4LqJNzk9kve4penmhV+7JzTOTZL8pCiEBAwhh/400zOtnKNrzexmjpKsEnKnb32hdGk2wf83yE+ayTl5Roq/x1A0QAYI3jrkWkqjfbkQLFBEPnOSV6D4cvvxK6FjrgoA++cZoOzOec3CRcI6A1cR2/dT54JpR7r3NYCpUZgsx6EYE6yJg7aYPzlzqd1WF6DDlSmbVbrvnRUHgsG7UM9P8NP3hueGYLaZ6+gT8VAKz8TgnFemXqbo9idCdwPIo2HvZ1qBa6UBHctaQEfiIEoQRoJ9x5U9AAhjdy0er5+yKfMOkWLH8i7UtkwD63GwMMMrxC3b1teHoCc+nMXHXLhUN+LBzK7M62l4bjs59BpkG4xYfBBiEFAR77Aafdo1UJp4NR0ASjF5Br16j8viFoRG8O2AD7cBChiSde0qrKez6rcmSKseOYxATQFsJEdlBoNhGeGvORAMLWYEKM8KHjbMBsb3CJsPhngTf6xiP9sV4U3kS2CkPFV8qJvPMuPUEm1OdhkEZSnhMl72NMWBO7bj5Enbg+zRsjA+0QI3OTAgw6ysJ0GiiBuTmXt6AOiITw00giU6opNEbTKVBnfLzMVuyh+5xogE/IFByXS6AYYDFb68QrhdRPfYcmCYxjmoSyh3vudVd0QnK2frdf30uba+/oTFct7nfL51m2ClUk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2575.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(66476007)(8676002)(66446008)(64756008)(52536014)(5660300002)(66556008)(8936002)(9686003)(55016003)(2906002)(66946007)(83380400001)(86362001)(38070700005)(33656002)(38100700002)(122000001)(71200400001)(478600001)(110136005)(316002)(41300700001)(186003)(53546011)(6506007)(7696005)(26005)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vm1PbE5IeHZYWW10R2Uyc0pKamVVU3FldzMrK3BISFZjaHB3MVlMVi80dEs5?=
 =?utf-8?B?Y0lsU2RjM0RPU2t6Y0x2VWxkSUk3VjgzWmc2L0hmTU1KZE1yYVJBTGVSK3JZ?=
 =?utf-8?B?cDduUWJwV3hqZGs3U2tBQzRhOWRLT3FWcTVVeGRhaVQ4Rzk5Z055THRyUmV4?=
 =?utf-8?B?THZMQVR5dzFmR29RS3laRzk0TEs1R3cwd2h0YlpFMkk2VmF0ZTZSRFpobGtx?=
 =?utf-8?B?aWplZm9mTkMxNEJNUlJTWmxnYy9JeloyWHpNbmEvVVlQRzhORVZqZkVQanhW?=
 =?utf-8?B?YW1KbE5ibXdDSlNTQkcxODF6UmxTU3JoSlpabXFtRXlJcXV4dUdScW8vNjV0?=
 =?utf-8?B?dkh5ZzZLem05NU9XSTZIVC9scm1EYmwzanIvMk1QWDY5bTU0WUltOHQxSnJ6?=
 =?utf-8?B?YXE5d2szREczNjVqaFl2K3FUd3A1UTZnNlNHL1NGTk9lMkw4aEhIV1Q2TmxK?=
 =?utf-8?B?NHdWT1Bib3R6ZlIxNmhZcFkvZnMrbGZmRnplODJ2RFZiS0VBck42bWNhVm1F?=
 =?utf-8?B?WGdoNEMyT3I1UkhNUHBScUZ5OUlHZDA0YlV2UmFIc1NQVjh5c3pmY0dydTc2?=
 =?utf-8?B?L1RiR0kyeTAydEJ5Nm0rKzVYeVN4VEJoQXU3am9kNFlrd04zWkpPczhmTisy?=
 =?utf-8?B?UkViRkZtOXNwcGZGdjQwdEhaU2ZXbVhuM3VINTRyeVJMU2xZc1dVM1ZDOFlq?=
 =?utf-8?B?ZXZlcnRHTTlnRWg0Nk9ZRWUvWUhjSE9CUTJac2M5ZUp2T0FidUZtTHZ0UHpD?=
 =?utf-8?B?NS9WREh3UXljMmN6NUovb09PbytyLzhneWlqOFRndFlhS1ZVMGlXVTZyQXoz?=
 =?utf-8?B?d1djaHlsUmVlQkZ4ZlhaaVhKUUlBb2EwZ2VaUTFkdURmcHMxaG1NOW1yVlhH?=
 =?utf-8?B?THZGRjhDbXdDRDJrNWdQRWd3UUFiczN3eEtoaUc4SWdyTHNGYk1XS3hybDRs?=
 =?utf-8?B?WDdCRkY5eDUreCtIWlNZL2c0NzNHSkRYNGc5bEI0YXBMRnF6S0tTanhwd3NR?=
 =?utf-8?B?UXRVWUl0MTZoVmNHMmJWY1NEcHNUUW9kT2ZPaFQyZ3R0V01ER0xrUkJjbFNS?=
 =?utf-8?B?SS9LeVNubnMvNERpTlFIa1hQejlJUDM5N2xvdGFJdlh0Rm9hU052L0swZkpx?=
 =?utf-8?B?bTMyMUpMbVpad3E2dzM5eFJWaC95Y2FMVE1SREhqWGZLUHdDL3piTmE5VFFE?=
 =?utf-8?B?TDUrZUVseFJjZFFhZndIcHZKczlJWEFnZkJsYjJYeHhqRlNXbWk0cTRiQ1FN?=
 =?utf-8?B?bDdRZ0Y4bVNBZzdzN0Y3Mng5UkFkSmNFQVhzR2k4dHdLSUgvdHhZdXAwQlFC?=
 =?utf-8?B?VDZzZURQK3ZPMVMvUTcvWW1IVHFxOWJZaTh3KzY0WTRZbG5SQ3RUSTV2WjhX?=
 =?utf-8?B?dlBnUzB6K2o3R3ZOZ3lJWWpmbE1zQ2ZtS2R0Y3N2Z1I0aTlZV2phL0kyMXdY?=
 =?utf-8?B?ZHVpZXpGNjY3OUZVay9RZ1pZeUVTUWNPZVd0d1BOZlp2M09NSjNaZ2VHdWxH?=
 =?utf-8?B?Sm50UWtjTzBZOFVLWDhFM2FEdlpnM3lTQVRuTm0zMWl5MFIweHlqSTlSSmVK?=
 =?utf-8?B?akZQb3g3RXEyMWY1V202azdJejVsNHV3WDEzQ3p2RU94WUxJV1R0dlZXRGk2?=
 =?utf-8?B?RG9vcDZtS1pmbTRJRWhGeDZuUlpQMDk2SGx1YmpHeXB2YjlmVzFtM2JrRHBk?=
 =?utf-8?B?UnJvVDhBbTk0K09JRmQrTTFGU1NlMW4xMFVGTHI5VGU3RjU3bldTc1U2Wnc3?=
 =?utf-8?B?NWNuemM2dGxKRGlnUG52QUZTdlZNREhVOFdRZ01wTFdzNFlkK3lvMXp4ckZY?=
 =?utf-8?B?Uzk1eUEvTEpiejN2alc0K1MzdmxoRWhYWGJXa3RQWDA5VzdTSmluZWZaZkdq?=
 =?utf-8?B?aCtqMTdxTGlHbXFXSE0xZGpoZkNEWVJ3T2FqQkY5alpHVk13dk9hRXpZaGRN?=
 =?utf-8?B?RzBSTVBDemJyVHk5YXgyRGQxaVk2R05zMnJ0cWplSXhMdE9TMzRFN1FpcjBR?=
 =?utf-8?B?S3VzVVR0cDdGcXQ4WnEyeHJPVUViWnpaemJkajlQTWNZQ0dVYnFyWmtOdjY1?=
 =?utf-8?B?S1NXcmxqVXc1ZSszU3JRVFJZcUlRWnZZS1hvRlRqRTNoWFBSYXBId1gza1Iw?=
 =?utf-8?Q?pjdQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2575.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56557dc5-782f-41f8-79ba-08da59e704eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 15:49:58.0736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NfZzfTekZCHLcdOO0uSM5PQl/kt651Wu2KQYKHlXzk26Hu+kettcXY1J5Q2ApBEikWaGgBJ4VkUw2/2WgChwRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCldpbGwgcG9zdCB1cGRhdGVkIHBh
dGNoLiBNeSByZXNwb25zZXMgaW5saW5lIGJlbG93DQoNClJlZ2FyZHMsDQpSYW1lc2gNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3Vl
aGxpbmdAYW1kLmNvbT4gDQpTZW50OiBXZWRuZXNkYXksIEp1bmUgMjksIDIwMjIgODo1OCBBTQ0K
VG86IEVycmFib2x1LCBSYW1lc2ggPFJhbWVzaC5FcnJhYm9sdUBhbWQuY29tPjsgYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc7IGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbQ0KU3ViamVjdDog
UmU6IFtQQVRDSF0gZHJtL2FtZGtmZDogRml4IHdhcm5pbmdzIGZyb20gc3RhdGljIGFuYWx5emVy
IFNtYXRjaA0KDQpBbSAyMDIyLTA2LTI4IHVtIDIwOjAzIHNjaHJpZWIgRXJyYWJvbHUsIFJhbWVz
aDoNCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+DQo+IE15IHJlc3BvbnNl
cyBhcmUgaW5saW5lDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEt1
ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwg
SnVuZSAyOCwgMjAyMiA2OjQxIFBNDQo+IFRvOiBFcnJhYm9sdSwgUmFtZXNoIDxSYW1lc2guRXJy
YWJvbHVAYW1kLmNvbT47IA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgZGFuLmNh
cnBlbnRlckBvcmFjbGUuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRrZmQ6IEZp
eCB3YXJuaW5ncyBmcm9tIHN0YXRpYyBhbmFseXplciANCj4gU21hdGNoDQo+DQo+DQo+IEFtIDIw
MjItMDYtMjggdW0gMTk6MjUgc2NocmllYiBSYW1lc2ggRXJyYWJvbHU6DQo+PiBUaGUgcGF0Y2gg
Zml4ZXMgY291cGxlIG9mIHdhcm5pbmdzLCBhcyByZXBvcnRlZCBieSBTbWF0Y2ggYSBzdGF0aWMg
DQo+PiBhbmFseXplcg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFJhbWVzaCBFcnJhYm9sdSA8UmFt
ZXNoLkVycmFib2x1QGFtZC5jb20+DQo+PiBSZXBvcnRlZC1ieTogRGFuIENhcnBlbnRlciA8ZGFu
LmNhcnBlbnRlckBvcmFjbGUuY29tPg0KPj4gLS0tDQo+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfdG9wb2xvZ3kuYyB8IDM2ICsrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+PiAg
ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5j
DQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jDQo+PiBpbmRl
eCAyNTk5MGJlYzYwMGQuLjlkN2I5YWQ3MGJjOCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYw0KPj4gQEAgLTE0MTcsMTUgKzE0MTcsMTcgQEAgc3Rh
dGljIGludA0KPj4ga2ZkX2NyZWF0ZV9pbmRpcmVjdF9saW5rX3Byb3Aoc3RydWN0IGtmZF90b3Bv
bG9neV9kZXZpY2UgKmtkZXYsIGludCBnDQo+PiAgICANCj4+ICAgIAkJLyogZmluZCBDUFUgPC0t
PiAgQ1BVIGxpbmtzICovDQo+PiAgICAJCWNwdV9kZXYgPSBrZmRfdG9wb2xvZ3lfZGV2aWNlX2J5
X3Byb3hpbWl0eV9kb21haW4oaSk7DQo+PiAtCQlpZiAoY3B1X2Rldikgew0KPj4gLQkJCWxpc3Rf
Zm9yX2VhY2hfZW50cnkoY3B1X2xpbmssDQo+PiAtCQkJCQkmY3B1X2Rldi0+aW9fbGlua19wcm9w
cywgbGlzdCkgew0KPj4gLQkJCQlpZiAoY3B1X2xpbmstPm5vZGVfdG8gPT0gZ3B1X2xpbmstPm5v
ZGVfdG8pDQo+PiAtCQkJCQlicmVhazsNCj4+IC0JCQl9DQo+PiAtCQl9DQo+PiArCQlpZiAoIWNw
dV9kZXYpDQo+PiArCQkJY29udGludWU7DQo+PiArDQo+PiArCQljcHVfbGluayA9IE5VTEw7DQo+
IFRoaXMgaW5pdGlhbGl6YXRpb24gaXMgdW5uZWNlc3NhcnkuIGxpc3RfZm9yX2VhY2hfZW50cnkg
d2lsbCBhbHdheXMgaW5pdGlhbGl6ZSBpdC4NCj4NCj4NCj4+ICsJCWxpc3RfZm9yX2VhY2hfZW50
cnkoY3B1X2xpbmssICZjcHVfZGV2LT5pb19saW5rX3Byb3BzLCBsaXN0KQ0KPj4gKwkJCWlmIChj
cHVfbGluay0+bm9kZV90byA9PSBncHVfbGluay0+bm9kZV90bykNCj4+ICsJCQkJYnJlYWs7DQo+
PiAgICANCj4+IC0JCWlmIChjcHVfbGluay0+bm9kZV90byAhPSBncHVfbGluay0+bm9kZV90bykN
Cj4+ICsJCS8qIEVuc3VyZXMgd2UgZGlkbid0IGV4aXQgZnJvbSBsaXN0IHNlYXJjaCB3aXRoIG5v
IGhpdHMgKi8NCj4+ICsJCWlmIChsaXN0X2VudHJ5X2lzX2hlYWQoY3B1X2xpbmssICZjcHVfZGV2
LT5pb19saW5rX3Byb3BzLCBsaXN0KSB8fA0KPj4gKwkJCShjcHVfbGluay0+bm9kZV90byAhPSBn
cHVfbGluay0+bm9kZV90bykpDQo+IFRoZSBzZWNvbmQgY29uZGl0aW9uIGlzIHJlZHVuZGFudC4g
SWYgdGhlIGxpc3QgZW50cnkgaXMgbm90IHRoZSBoZWFkLCANCj4gdGhlIG5vZGVfdG8gbXVzdCBo
YXZlIGFscmVhZHkgbWF0Y2hlZCBpbiB0aGUgbG9vcC4NCj4NCj4gUmFtZXNoOiBTeW50YWN0aWNh
bGx5LCBpdCBpcyBwb3NzaWJsZSB0byB3YWxrIGRvd24gdGhlIGxpc3Qgd2l0aG91dCBoYXZpbmcg
dGhlIGhpdC4gVGhlIGNoZWNrIGxpc3RfZW50cnlfaXNfaGVhZCgpIGlzIGZvciB0aGF0IHNjZW5h
cmlvLg0KDQpJZiB5b3UgdHJhdmVyc2UgdGhlIHdob2xlIGxpc3Qgd2l0aG91dCBhIGhpdCwgbGlz
dF9lbnRyeV9pc19oZWFkIHdpbGwgYmUgdHJ1ZS4gVGhhdCBpcyBhbHNvIHRoZSBvbmx5IGNhc2Ug
d2hlcmUgY3B1X2xpbmstPm5vZGVfdG8gIT0gZ3B1X2xpbmstPm5vZGVfdG8gaXMgcG9zc2libGUu
IFRoZXJlZm9yZSB0aGF0IGNvbmRpdGlvbiBpcyByZWR1bmRhbnQuIA0KSnVzdCBjaGVja2luZyBs
aXN0X2VudHJ5X2lzX2hlYWQgaXMgc3VmZmljaWVudC4NCg0KUmFtZXNoOiBZb3UgYXJlIHJpZ2h0
LCBjaGVjayBmb3IgbGlzdCBoZWFkIGlzIHN1ZmZpY2llbnQgYXMgaXQgaW1wbGllcyBhbGwgY3B1
X2xpbmsgb2JqZWN0cyBkbyBub3QgcGFzcyB0aGUgdGVzdCBvZiAoY3B1X2xpbmstPm5vZGVfdG8g
PT0gZ3B1X2xpbmstPm5vZGVfdG8pLg0KDQpUaGF0IHNhaWQsIGFzIEkgcG9pbnRlZCBvdXQgYmVs
b3csIHlvdSdyZSBzdGlsbCB1c2luZyBjcHVfbGluayBvdXRzaWRlIHRoZSBsb29wLiBUaGVyZWZv
cmUgaXQncyBsaWtlbHkgdGhlIHN0YXRpYyBjaGVja2VyIGlzIHN0aWxsIGdvaW5nIHRvIGNvbXBs
YWluLg0KDQpSYW1lc2g6IEkgc3VzcGVjdCB0aGUgcmVhc29uIHN0YXRpYyBhbmFseXplciB3YXMg
Y29tcGxhaW5pbmcgYWJvdXQgY3B1X2xpbmsgaXMgYmVjYXVzZSBpdCB3YXMgYmVpbmcgdXNlZCBp
biB0aGUgbG9vcCBjb25kaXRpb25hbGx5LiBUaGUgbmV3IGNvZGUgdXNlcyBjcHVfbGluayBpbiB0
aGUgbG9vcCB1bmNvbmRpdGlvbmFsbHkuIFBlciB0aGlzIGxvZ2ljIGl0IG11c3QgYmUgdmFsaWQg
b25jZSB3ZSBjcm9zcyB0aGUgbGlzdF9lbnRyeV9pcyBoZWFkIHN0YXRlbWVudC4NCg0KUmVnYXJk
cywNCiDCoCBGZWxpeA0KDQoNCj4NCj4gQnV0IEknbSBubyBzdXJlIHRoaXMgc29sdXRpb24gaXMg
Z29pbmcgdG8gc2F0aXNmeSB0aGUgc3RhdGljIGNoZWNrZXIuIA0KPiBJdCBvYmplY3RzIHRvIHVz
aW5nIHRoZSBpdGVyYXRvciAoY3B1X2xpbmspIG91dHNpZGUgdGhlIGxvb3AuIEkgdGhpbmsgDQo+
IGEgcHJvcGVyIHNvbHV0aW9uLCB0aGF0IGRvZXNuJ3QgbWFrZSBhbnkgYXNzdW1wdGlvbnMgYWJv
dXQgaG93IA0KPiBsaXN0X2Zvcl9lYWNoX2VudHJ5IGlzIGltcGxlbWVudGVkLCB3b3VsZCBiZSB0
byBkZWNsYXJlIGEgc2VwYXJhdGUgDQo+IHZhcmlhYmxlIGFzIHRoZSBpdGVyYXRvciwgYW5kIGFz
c2lnbiBjcHVfbGluayBpbiB0aGUgbG9vcCBvbmx5IGlmIA0KPiB0aGVyZSBpcyBhIG1hdGNoLg0K
Pg0KPiBSYW1lc2g6IFdpbGwgd2FpdCBmb3IgYSByZXNwb25zZSBmcm9tIERhbi4NCj4NCj4gUmVn
YXJkcywNCj4gICDCoCBGZWxpeA0KPg0KPg0KPj4gICAgCQkJcmV0dXJuIC1FTk9NRU07DQo+PiAg
ICANCj4+ICAgIAkJLyogQ1BVIDwtLT4gQ1BVIDwtLT4gR1BVLCBHUFUgbm9kZSovIEBAIC0xNTEw
LDE2ICsxNTEyLDE2IEBAIA0KPj4gc3RhdGljIGludCBrZmRfYWRkX3BlZXJfcHJvcChzdHJ1Y3Qg
a2ZkX3RvcG9sb2d5X2RldmljZSAqa2RldiwNCj4+ICAgIAkJY3B1X2RldiA9IGtmZF90b3BvbG9n
eV9kZXZpY2VfYnlfcHJveGltaXR5X2RvbWFpbihpb2xpbmsxLT5ub2RlX3RvKTsNCj4+ICAgIAkJ
aWYgKGNwdV9kZXYpIHsNCj4+ICAgIAkJCWxpc3RfZm9yX2VhY2hfZW50cnkoaW9saW5rMywgJmNw
dV9kZXYtPmlvX2xpbmtfcHJvcHMsIGxpc3QpDQo+PiAtCQkJCWlmIChpb2xpbmszLT5ub2RlX3Rv
ID09IGlvbGluazItPm5vZGVfdG8pDQo+PiArCQkJCWlmIChpb2xpbmszLT5ub2RlX3RvID09IGlv
bGluazItPm5vZGVfdG8pIHsNCj4+ICsJCQkJCXByb3BzLT53ZWlnaHQgKz0gaW9saW5rMy0+d2Vp
Z2h0Ow0KPj4gKwkJCQkJcHJvcHMtPm1pbl9sYXRlbmN5ICs9IGlvbGluazMtPm1pbl9sYXRlbmN5
Ow0KPj4gKwkJCQkJcHJvcHMtPm1heF9sYXRlbmN5ICs9IGlvbGluazMtPm1heF9sYXRlbmN5Ow0K
Pj4gKwkJCQkJcHJvcHMtPm1pbl9iYW5kd2lkdGggPSBtaW4ocHJvcHMtPm1pbl9iYW5kd2lkdGgs
DQo+PiArCQkJCQkJCQkJaW9saW5rMy0+bWluX2JhbmR3aWR0aCk7DQo+PiArCQkJCQlwcm9wcy0+
bWF4X2JhbmR3aWR0aCA9IG1pbihwcm9wcy0+bWF4X2JhbmR3aWR0aCwNCj4+ICsJCQkJCQkJCQlp
b2xpbmszLT5tYXhfYmFuZHdpZHRoKTsNCj4+ICAgIAkJCQkJYnJlYWs7DQo+PiAtDQo+PiAtCQkJ
cHJvcHMtPndlaWdodCArPSBpb2xpbmszLT53ZWlnaHQ7DQo+PiAtCQkJcHJvcHMtPm1pbl9sYXRl
bmN5ICs9IGlvbGluazMtPm1pbl9sYXRlbmN5Ow0KPj4gLQkJCXByb3BzLT5tYXhfbGF0ZW5jeSAr
PSBpb2xpbmszLT5tYXhfbGF0ZW5jeTsNCj4+IC0JCQlwcm9wcy0+bWluX2JhbmR3aWR0aCA9IG1p
bihwcm9wcy0+bWluX2JhbmR3aWR0aCwNCj4+IC0JCQkJCQkJaW9saW5rMy0+bWluX2JhbmR3aWR0
aCk7DQo+PiAtCQkJcHJvcHMtPm1heF9iYW5kd2lkdGggPSBtaW4ocHJvcHMtPm1heF9iYW5kd2lk
dGgsDQo+PiAtCQkJCQkJCWlvbGluazMtPm1heF9iYW5kd2lkdGgpOw0KPj4gKwkJCQl9DQo+PiAg
ICAJCX0gZWxzZSB7DQo+PiAgICAJCQlXQVJOKDEsICJDUFUgbm9kZSBub3QgZm91bmQiKTsNCj4+
ICAgIAkJfQ0K
