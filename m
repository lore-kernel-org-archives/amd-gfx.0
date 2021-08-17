Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D5AC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 09:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5258660FD7
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 09:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5258660FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC2C66E112;
	Tue, 17 Aug 2021 09:13:39 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9BE56E112
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 09:13:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmXuz/cCfSenHOzPxQabdNWZ/r4ZFDoep6W/IboJ/tft9GisDghaOu1c99I8grAIgYxDlnHqik8Y0h+j6VeROHbS3YUSh0KRyNdkVN1zuLEkEtZX1Ykn89SeZymn9lfKP4K3Ucuk4xLs+nsbKHDIhJbtpQ+aUBohLZ5Tbmoxe6vWE/VhMeNpduT5N0+9cunfSfbmvroEOOFc4ahpK7c+i2NB3caHez0HiXjECtVbmsSRVIKasBIGpX97CtTELvKyArY6IZ2tPwZytLLgZ2cVgcY5bY/92K7L5Dazh1ZGHJitzVlCqzzbPpLEiehGS1UkwIQzw3ONkM5N8p/64Fi+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqoaVf7kM6GWzVl0AosAgaPwSELSoVgNTkf4Nq0xUEo=;
 b=CJqvjQUT2mXABhtoV/DiYfhs267TOalHTxn+MYi/4o2E3cgYQs3gIrGOP/RtuCJQ/F1AMggZ7q+40LByLFEn7w4VPrJnq+/puCIigqSThzAWKgEKqPZ7yWXEFbuEXBssizIRSMdTjuRrtq2fXVWagJIwFq13kV6rz0w5ys3hUKI2vugAHWmi+UAccSkYC03a9j7hSF5FzRbTsE3LTnUIx2jdv0TKe3vBN/cDl7kJnn5Y3QDQDBDZ7OKveYes20ZTgK3D2apU5b09GG7R7+vgyr+Vsrh1wfGZGqPnrOYM0jmvKTGEqjOs8f5ORJTb/BWckKOERlb20Wu9BfKsEL5e1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqoaVf7kM6GWzVl0AosAgaPwSELSoVgNTkf4Nq0xUEo=;
 b=nbN1CKm0m81sboVcXYCtC594LMEfelcBWIpDjgNzRmgdZSwHdiTPMmBwpXiSY7gjnuoRu3W567w38V1a7NYaEXW6M5uBsPrX1rg8Qn+wuxvQOoHncdqvqTtOGTGcf7aqJ+Cr7514rWUPTvEDFZoEbzecX+f6lUBlgXzauG+KqHc=
Received: from BYAPR12MB3416.namprd12.prod.outlook.com (2603:10b6:a03:ac::10)
 by BYAPR12MB4632.namprd12.prod.outlook.com (2603:10b6:a03:110::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Tue, 17 Aug
 2021 09:13:22 +0000
Received: from BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::f5f9:93c:a602:61ff]) by BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::f5f9:93c:a602:61ff%7]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 09:13:22 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: fix KFDSVMRangeTest.PartialUnmapSysMemTest
 fails
Thread-Topic: [PATCH] drm/amdkfd: fix KFDSVMRangeTest.PartialUnmapSysMemTest
 fails
Thread-Index: AQHXkPTdXfZHOKoAzEK/mfa3YdiQpKt26OYAgACFMrA=
Date: Tue, 17 Aug 2021 09:13:21 +0000
Message-ID: <BYAPR12MB3416456181F4647D8DC2920CC1FE9@BYAPR12MB3416.namprd12.prod.outlook.com>
References: <20210814101213.3936141-1-yifan1.zhang@amd.com>
 <8595f09a-48b2-7f8c-037c-91c9d74cc271@amd.com>
In-Reply-To: <8595f09a-48b2-7f8c-037c-91c9d74cc271@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-17T09:13:19Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d1bd150c-829e-464e-9643-9e67a7111560;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65284599-9c0a-4622-1f37-08d9615f42e2
x-ms-traffictypediagnostic: BYAPR12MB4632:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB46328AE330BE87641F46F5DDC1FE9@BYAPR12MB4632.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rzn+NhSOmpXEJeleXo8v+BjOmbtVAoP6X5F9/bfEfhU06VenRx3ZdqMQscpsLXbgKytRf9ir5HaQ5TP4F/TlC98g0GUBgR+0BkYZWKi1MNmwKeyG0xJycBfDxRCF+QRammz8IInHPqLaMDyQYt00tihGCMuY5fKpWJo2gLDSvaAJCvDmNHZ0v1612OryhEES9YGeQu2MO+bwEzLBL4q78BJ2uMt2VkmBXw5ekldrdv1j9AKbGJtxMYrbUy26x5TG0B4syrptZR9780MXa/9GWxreiO5ItUdnplCMnFzxn9AR2T7KI9GMqg2m2U78+216267AMhotRjZUv1x/4nB9wIwPskpXTWZXsrHQCUJcle6VH6Jx5vbQyoDvNh0iDjmC6Pr3EjWZH5S4aJO9wxN4fwEPs7OHkAdw5yR4mMJddkQ81I8IX/pYV8HQl28qYJtASALsGS7PQeNbUiRC69b/EqkL2nKdnLviPTHeYj8TQMBQklgxUNV+l/hcFSlzJsT37F1xe9yq9JiWn+3+rG6E8Oxpxymk72yIZRuOOiIcfHXqPpPNuxKO3nespzDG1y925+Czxd/i4gMsJGXmdpE8BmgdoIvJolubNJ77VABObNYTzjYikkzRadjw1q/T2h3XJONEeioOyB7udPt9haTBMiV7QHeuBsaXuNjF/Pauds67H1CRGqQN3nSEz4ESnUhUjDmJ7zCU/eJUMBqFviHU0hiKEx6vcxZrfVwx5xfKKE0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(316002)(55016002)(86362001)(71200400001)(83380400001)(9686003)(66946007)(110136005)(66446008)(76116006)(66556008)(66476007)(64756008)(33656002)(38070700005)(7696005)(5660300002)(26005)(2906002)(478600001)(8936002)(186003)(6506007)(53546011)(52536014)(122000001)(8676002)(38100700002)(213903007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkVqK1JMNllrR3dZeCtWdFliaUdMOFppM1BjWG1zOE93aURxMk5saWQrSGdZ?=
 =?utf-8?B?WDNtOE5tRTBnQ3J0aWNMVG95dHFSRW5sV0VDVUFvZXd6cWFCaEVDY1FENU9I?=
 =?utf-8?B?ckxRRi9Tek9BUmtoS1hIeEZ6aFhlRXQ4eWhlejJPYTk4eXRJYXhCakQyajYw?=
 =?utf-8?B?NWJxOVk1NHlWdkt3WW5ZSWxzTTRkeFpIUURQaUp4YmpzUEo1S1QwbVJ5TG1S?=
 =?utf-8?B?UkpTT2JhRVlqamVOUzYrSXNldjRXRU9yWlpwSUR4QXhzemhyNlJRdjczTHFt?=
 =?utf-8?B?SlJjdTNXMitJZm45cHk2WjhVUFNPVkRRcTBhVnhlajdJbERvTVh5QTdsZlRn?=
 =?utf-8?B?RUZVd2tod0lrU215cDB4aitxSVUzbU9od0Nkdy9RcmZOQWpPUXVEbjR0MXEy?=
 =?utf-8?B?cmlSV01BVi90ZEF6RUpDZEhjY2hRTUNZZXgzdUNuZEZ0MTQzWVhFZllnNXRh?=
 =?utf-8?B?YWJSUEh3Ny9uVENYTkxodmM4dTVKVWRsZWNjb3NOcmQ0b2VkTS9VSmx4cjBp?=
 =?utf-8?B?YWhkTUJyM0poSU9NOFMvS2duUWU4Y3M1TytxTE9lREYyYVRGcHF2ZG9mRFRH?=
 =?utf-8?B?cW5RSHFiQ0tCcUU2cE80ZitaemFpYmJXcFByamxuaHJoRkpEbjIzUDZncjVs?=
 =?utf-8?B?Vi95VDJidGRoQnZpMmw1OWg5dW9WM3hkc1RhKzR6YjVSRTZGRlpXNjhyVmZj?=
 =?utf-8?B?VUw3Q0ppTWs4bUVNNHkyRmVydmxzNjdjaUJSMnJNcndTMG9ZSkFQUnIvRkN1?=
 =?utf-8?B?bVRwNTRKemRSK1BpdHFQS0U2M0t6ZG9YNWZ2NlNyQUVHaHlSK0xjUXJqQkEx?=
 =?utf-8?B?Z0NjY1FxUDVTRVVFTUdaUkQwNW1NSnplSy9vcXJTVXRnUjFRNFE3VWF3Z1lw?=
 =?utf-8?B?ZWpqWEpUZCtocHBIOCtoWXJrR09RbkRHSnYyL2QyVGRuNHdBUzlweGUwMFFs?=
 =?utf-8?B?djhIdmR3VnhIcWZhYnB3b1JkbGpVN05LcUgzaktuT2pXbTR6TWRQTFZGSXlK?=
 =?utf-8?B?c3RFSnJIT09LelkzOVR1aTdYeG9HRjlZOG84S3g2bC9rRU1BMmM4ckFxRjJG?=
 =?utf-8?B?eEVUUWExK0lJdmprV3ozR2lwck1ERTdhWmUwOWhLZHg4WWFWellkWHFaUHhK?=
 =?utf-8?B?d3BBOWJteEM1cmlUdGxzWXY0WFFaN25oMVBnaG83bzA1azJjZ0R4Mmd2ZDMv?=
 =?utf-8?B?R21oZXJYeVJUc3NqLzB3Wnp1OW82TWkreVpZd3dlK3ZlK1pvUjhuNzd4N2VM?=
 =?utf-8?B?dHM5aTJNS3VVRVpYdXFWY2JIbmd0NTVEbllBT0wwNVVraWN4eTROSHMxWjYz?=
 =?utf-8?B?MXB6Z1FEOWZ0YVBHOHYvcC9HTUtGRSsrVFlHaFRRVEduNUJpNVhVU05td3VI?=
 =?utf-8?B?TU9NbFJpQWVsdDFocjIyRThKTVEvUWZjOVJnWVkwZ1ByNnNxblV6YVk3dWs1?=
 =?utf-8?B?Z2o2aWx0OVo1UHdzcVlCZFRlOThWNUJ6NWdCTk5yeWJOREpWdG03NkloZERB?=
 =?utf-8?B?S0xiMmRRbzUwTHlFTTl4QVA1RVkvaGhURDBCOFo4dXRiYi90VjVnWHlVTzRr?=
 =?utf-8?B?OTM1TXMrUHNXTW1SRDZHZWFRRm9LUXZkQy9wWTNtWkxSaFhzYUdoNHJXVkgy?=
 =?utf-8?B?NUJTbXg5SHplZkFzYml2WWRrY012TVNrbFZoQkNieFhqSGJwbDVtWFBQL0dw?=
 =?utf-8?B?WlltT0t2SzFwdjhzdC9naXdXSlNTOEM0WWJqYzlBRVF5KzJ0a1B6dFJ4Wjl4?=
 =?utf-8?Q?iH6yja9YFt9ddtdCrjW/eqr7U/G/KpKDktS/g2+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65284599-9c0a-4622-1f37-08d9615f42e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 09:13:22.0139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7PhqTCvhj3zh09oeRExlOJbPxs5ZOkjgx5nKMcINAhpXH1YuON/PV5Iq81DmaLig
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4632
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgRmVsaXgsIA0KDQpUaGFua3MgZm9yIGNvbW1l
bnRzLiBJIHdpbGwgc2VuZCBQYXRjaCBWMi4NCg0KQlJzLA0KWWlmYW4NCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4gDQpTZW50OiBUdWVzZGF5LCBBdWd1c3QgMTcsIDIwMjEgOToxNiBBTQ0KVG86IFpoYW5n
LCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGtmZDogZml4IEtGRFNWTVJhbmdlVGVz
dC5QYXJ0aWFsVW5tYXBTeXNNZW1UZXN0IGZhaWxzDQoNCg0KQW0gMjAyMS0wOC0xNCB1bSA2OjEy
IGEubS4gc2NocmllYiBZaWZhbiBaaGFuZzoNCj4gWyBSVU4gICAgICBdIEtGRFNWTVJhbmdlVGVz
dC5QYXJ0aWFsVW5tYXBTeXNNZW1UZXN0DQo+IC9ob21lL3lpZmFuL2JyYWhtYS9saWJoc2FrbXQv
dGVzdHMva2ZkdGVzdC9zcmMvS0ZEVGVzdFV0aWwuY3BwOjI0NTogDQo+IEZhaWx1cmUgVmFsdWUg
b2Y6IChoc2FLbXRBbGxvY01lbW9yeShtX05vZGUsIG1fU2l6ZSwgbV9GbGFncywgJm1fcEJ1Zikp
DQo+ICAgQWN0dWFsOiAxDQo+IEV4cGVjdGVkOiBIU0FLTVRfU1RBVFVTX1NVQ0NFU1MNCj4gV2hp
Y2ggaXM6IDANCj4gL2hvbWUveWlmYW4vYnJhaG1hL2xpYmhzYWttdC90ZXN0cy9rZmR0ZXN0L3Ny
Yy9LRkRUZXN0VXRpbC5jcHA6MjQ4OiANCj4gRmFpbHVyZSBWYWx1ZSBvZjogKGhzYUttdE1hcE1l
bW9yeVRvR1BVTm9kZXMobV9wQnVmLCBtX1NpemUsIF9fbnVsbCwgbWFwRmxhZ3MsIDEsICZtX05v
ZGUpKQ0KPiAgIEFjdHVhbDogMQ0KPiBFeHBlY3RlZDogSFNBS01UX1NUQVRVU19TVUNDRVNTDQo+
IFdoaWNoIGlzOiAwDQo+IC9ob21lL3lpZmFuL2JyYWhtYS9saWJoc2FrbXQvdGVzdHMva2ZkdGVz
dC9zcmMvS0ZEVGVzdFV0aWwuY3BwOjMwNjogDQo+IEZhaWx1cmUNCj4gRXhwZWN0ZWQ6ICgodm9p
ZCAqKV9fbnVsbCkgIT0gKHB0ciksIGFjdHVhbDogTlVMTCB2cyBOVUxMIFNlZ21lbnRhdGlvbiAN
Cj4gZmF1bHQgKGNvcmUgZHVtcGVkKQ0KPiBbICAgICAgICAgIF0gUHJvZmlsZTogRnVsbCBUZXN0
DQo+IFsgICAgICAgICAgXSBIVyBjYXBhYmlsaXRpZXM6IDB4OQ0KPg0KPiBrZXJuZWwgbG9nOg0K
Pg0KPiBbICAxMDIuMDI5MTUwXSAgcmV0X2Zyb21fZm9yaysweDIyLzB4MzAgWyAgMTAyLjAyOTE1
OF0gLS0tWyBlbmQgdHJhY2UgDQo+IDE1YzM0ZTc4MjcxNGY5YTMgXS0tLSBbIDM2MTMuNjAzNTk4
XSBhbWRncHU6IEFkZHJlc3M6IDB4N2Y3MTQ5Y2NjMDAwIA0KPiBhbHJlYWR5IGFsbG9jYXRlZCBi
eSBTVk0gWyAzNjEzLjYxMDYyMF0gc2hvd19zaWduYWxfbXNnOiAyNyBjYWxsYmFja3MgDQo+IHN1
cHByZXNzZWQNCj4NCj4gVGhlc2UgaXMgcmFjZSB3aXRoIGRlZmVycmVkIGFjdGlvbnMgZnJvbSBw
cmV2aW91cyBtZW1vcnkgbWFwIGNoYW5nZXMgDQo+IChlLmcuIG11bm1hcCkuRmx1c2ggcGVuZGlu
ZyBkZWZmZXJlZCB3b3JrIHRvIGF2b2lkIHN1Y2ggY2FzZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTog
WWlmYW4gWmhhbmcgPHlpZmFuMS56aGFuZ0BhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgfCA3ICsrKysrKysNCj4gIDEgZmlsZSBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX2NoYXJkZXYuYw0KPiBpbmRleCAzMTc3YzRhMGU3NTMuLjk4MmJmNTM4ZGMzZCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jDQo+IEBAIC0xMjYxLDYg
KzEyNjEsMTMgQEAgc3RhdGljIGludCBrZmRfaW9jdGxfYWxsb2NfbWVtb3J5X29mX2dwdShzdHJ1
Y3QgZmlsZSAqZmlsZXAsDQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiAgDQo+ICAjaWYgSVNfRU5B
QkxFRChDT05GSUdfSFNBX0FNRF9TVk0pDQo+ICsJLyogRmx1c2ggcGVuZGluZyBkZWZlcnJlZCB3
b3JrIHRvIGF2b2lkIHJhY2luZyB3aXRoIGRlZmVycmVkIGFjdGlvbnMgZnJvbQ0KPiArCSAqIHBy
ZXZpb3VzIG1lbW9yeSBtYXAgY2hhbmdlcyAoZS5nLiBtdW5tYXApLiBDb25jdXJyZW50IG1lbW9y
eSBtYXAgY2hhbmdlcw0KPiArCSAqIGNhbiBzdGlsbCByYWNlIHdpdGggZ2V0X2F0dHIgYmVjYXVz
ZSB3ZSBkb24ndCBob2xkIHRoZSBtbWFwIGxvY2suIA0KPiArQnV0IHRoYXQNCg0KVGhpcyBjb21t
ZW50IHdvdWxkIG5lZWQgdG8gYmUgdXBkYXRlZC4gVGhpcyBpcyBub3QgZ2V0X2F0dHIuIFdoZXRo
ZXIgb3Igbm90IHVuZGVmaW5lZCBiZWhhdmlvdXIgaXMgYWNjZXB0YWJsZSBpbiB0aGlzIGNhc2Ug
aXMgYSBkaWZmZXJlbnQgcXVlc3Rpb24gZnJvbSBnZXRfYXR0ci4gSW4gdGhlIGdldF9hdHRyIGNh
c2UsIGEgcmFjZSBpcyBjYXVzZWQgYnkgYSBicm9rZW4gYXBwbGljYXRpb24gYW5kIGNhdXNlcyBw
b3RlbnRpYWxseSBpbmNvcnJlY3QgcmVzdWx0cyBiZWluZyByZXBvcnRlZCB0byB1c2VyIG1vZGUu
IEdhcmJhZ2UtaW4gPT0+IGdhcmJhZ2Utb3V0LiBObyBwcm9ibGVtLg0KDQpJbiB0aGUgY2FzZSBv
ZiB0aGlzIHJhY2UgaGVyZSwgdGhlIGNhdXNlIGlzIHN0aWxsIGEgYnJva2VuIGFwcGxpY2F0aW9u
Lg0KQnV0IHRoaXMgY2hlY2sgaXMgaGVyZSB0byBjYXRjaCBicm9rZW4gYXBwbGljYXRpb25zIGFu
ZCBwcmV2ZW50IHRoZW0gZnJvbSBtYXBwaW5nIHRoZSBzYW1lIHZpcnR1YWwgYWRkcmVzcyByYW5n
ZSB3aXRoIHR3byBkaWZmZXJlbnQgYWxsb2NhdG9ycy4gU28gSSdkIGFyZ3VlIHRoYXQgdGhlIHJh
Y2UgY29uZGl0aW9uIGlzIG5vdCBhY2NlcHRhYmxlIGhlcmUgYmVjYXVzZSBpdCBoYXMgY29uc2Vx
dWVuY2VzIGZvciBWTSBtYXBwaW5ncyBtYW5hZ2VkIGJ5IHRoZSBrZXJuZWwgbW9kZSBkcml2ZXIu
DQoNCg0KPiArCSAqIHdvdWxkIGJlIGEgcmFjZSBjb25kaXRpb24gaW4gdGhlIGFwcGxpY2F0aW9u
IGFueXdheSwgYW5kIHVuZGVmaW5lZA0KPiArCSAqIGJlaGF2aW91ciBpcyBhY2NlcHRhYmxlIGlu
IHRoYXQgY2FzZS4NCj4gKwkgKi8NCj4gKwlmbHVzaF93b3JrKCZzdm1zLT5kZWZlcnJlZF9saXN0
X3dvcmspOw0KPiAgCW11dGV4X2xvY2soJnN2bXMtPmxvY2spOw0KDQpUaGlzIHN0aWxsIGxlYXZl
cyBhIGJyaWVmIHJhY2UuIFRoZXJlIGlzIGFuIGVhc3kgd2F5IHRvIGZpeCB0aGF0OiBVc2Ugc3Zt
X3JhbmdlX2xpc3RfbG9ja19hbmRfZmx1c2hfd29yayBsaWtlIHRoaXM6DQoNCglzdm1fcmFuZ2Vf
bGlzdF9sb2NrX2FuZF9mbHVzaF93b3JrKHN2bXMsIGN1cnJlbnQtPm1tKTsNCgltdXRleF9sb2Nr
KCZzdm1zLT5sb2NrKTsNCgltbWFwX3dyaXRlX3VubG9jayhjdXJyZW50LT5tbSk7DQoJLi4uDQoN
ClJlZ2FyZHMsDQrCoCBGZWxpeA0KDQoNCj4gIAlpZiAoaW50ZXJ2YWxfdHJlZV9pdGVyX2ZpcnN0
KCZzdm1zLT5vYmplY3RzLA0KPiAgCQkJCSAgICAgYXJncy0+dmFfYWRkciA+PiBQQUdFX1NISUZU
LA0K
