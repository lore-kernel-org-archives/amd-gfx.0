Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C99CC07E9B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 04:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AEE461019
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 04:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AEE461019
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F1586E3B2;
	Wed, 21 Jul 2021 04:20:24 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DABE6E3B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 04:20:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nr2sZWasPejE5l/RU377X8ZShoWlLShv/t9nNmb0jya17nancexQLwuQnFSuO/aHBArwUUak+1w54k8AwwodgjXDQMRyUzPfGkuVT1buwrm4CuYYSFfEIonxlzGuPqrk+e69m8X3j4zuhX6PWjKJSWSpG9S3l/y7u/yK5eYVrDnCYjkDoTPzsm9zViwnWUzWDD+2RwtaWD+roTIWl73AedSd8+MEWduxf7Y39eEUExtz6PvwawAAQeWWt5CuYGkPrTySVnP3gRKftXQtAH+BShgQAaK5akQk3Jz3T6jUU5Zpv4pc8+t+4tTS/iWvBNtxh5WtmdTYWaL7IfPX+aFNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjCBT/I/vk4fCtygBYIF5WaDfAurCmIuw3g/b2e0T3U=;
 b=Snz7XXS9ZOUEzRWyTASbBUfUSoQsXGlvL19TZYnJFkPl+4eS+4bU7OjeZhHusmrnSEI63LSW6O+X28SMHrhpK9f656FqjtH5qHH+mTxtwqbXH7MMxCGprSw/ney2ojvIQpC4MzmJ3uHoW9rwha74ddnWsKsdwj7pbR8/5xj26fwUYwuU+iZ2q9Ex7E/lAvLd01jUuwxfGBt/2pLKR3f3grrbShmLnzVYRTeuCYc2EvKK/HF1s/CmionfIa8w00wTmuY8kyORuZbvBOWoIRzyCI1YHTg2lltrYVdxIx7Kkpx/YwTsAzePTt/u2sFF2cR6SQDkeH2Z17g1MWloow7tng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjCBT/I/vk4fCtygBYIF5WaDfAurCmIuw3g/b2e0T3U=;
 b=cJAlspplS9x4yzUimzO/szHmKcQaylPul4bVXzF6rADC0LZz+IzV1yuv4fIVvEKwkH8ZGVwSh2OSVSe8jkEUtIaTuZ3D07ZsuyTbk4zZ7eM+RF9fOgNnVmRjc9nqJWu+mCvwAGfQvq6+HWMtaXmy/08g50I0HaE0cXyVSiLHwEc=
Received: from DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16)
 by DM4PR12MB5245.namprd12.prod.outlook.com (2603:10b6:5:398::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Wed, 21 Jul
 2021 04:20:21 +0000
Received: from DM4PR12MB5232.namprd12.prod.outlook.com
 ([fe80::9977:1325:c275:327a]) by DM4PR12MB5232.namprd12.prod.outlook.com
 ([fe80::9977:1325:c275:327a%8]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 04:20:21 +0000
From: "Chen, JingWen" <JingWen.Chen2@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: consider paging job always not guilty
Thread-Topic: [PATCH] drm/amd/amdgpu: consider paging job always not guilty
Thread-Index: AQHXfVbT/NRVDnOuQEuSGkwc1rFvF6tLxpsAgAEN9OA=
Date: Wed, 21 Jul 2021 04:20:20 +0000
Message-ID: <DM4PR12MB523221CE7C99EBB265A0FADBB7E39@DM4PR12MB5232.namprd12.prod.outlook.com>
References: <20210720110250.356504-1-Jingwen.Chen2@amd.com>
 <8bb33313-c9da-0008-e578-832e8ab9933e@gmail.com>
In-Reply-To: <8bb33313-c9da-0008-e578-832e8ab9933e@gmail.com>
Accept-Language: en-150, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c04afa9f-d369-4ab0-bf7d-af025b297ef4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-21T04:19:38Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9af0f12b-c192-48fe-4086-08d94bfedaa7
x-ms-traffictypediagnostic: DM4PR12MB5245:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5245B783AF3D4626B5BBC63FB7E39@DM4PR12MB5245.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VvCKyYpghAE8HVHPWMBOafx4pNoh8UjnwZQoCjqKr3VvQ2EjPLefnYAWterKAwaPy61PjIDFWF4H9QSgcg3HggWFGwgj9l7JIpoAhIMEZBXvDdRN41WIq6b5tRBSnepyDxrCCnj3+ZhZjTIvqUPVnw/pUPH7mM/btvpUcKmpzqPgPgYWWYTFiU1DquyRQgIOEjvIzPu73gYl/OKikFPCj661avYe4nycRr2loxMUQ2HCbOTeiUr2ds6ny1I9ZdJjmdYBp7I2YT/43Z+gsBh3pVEf10mDJMC7JPeGmKsxfjSzAsJWv//Xy41UcIzOfhlI8WhyRPrZSkI+D7lqEnxN+rBlBHB8E6aihwVzu1jbam0UsaP0Gim6RBSd01Mz9FyNQNKSBkVM8A5g6Kbs4z+L6HRC39zOrn3rsnlTzpM1gPrDezhtN/OdyaRO5KJ72TYz8BViquIZJPrOSs762op4aFBWUgoLmYMPKmWiAzKXPr8Z4Amr+CuuTKroFdqtEcNKJf5TG0d7MMrx384i6dlgil6QakytX5KPjaozSTBeesilT8iqNneLy7ssMvcSC2aua6RBzRMcbypOHs7D6jfCNg705ipEnjgtjzuK+MxpYUV/I5pR4rMO+bkARSAf8mszkuMELHwIImPhVEiQyc+HL/zuNdmxGf8fAfmU/nBfDAxzJ4V8t/Me/ybTsiXV60/aGHKIFIUpEvS+5p5I18tBzA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5232.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(122000001)(38100700002)(83380400001)(8676002)(55016002)(186003)(86362001)(9686003)(478600001)(53546011)(6506007)(71200400001)(7696005)(2906002)(316002)(4326008)(52536014)(64756008)(66446008)(8936002)(66476007)(66556008)(66946007)(5660300002)(54906003)(26005)(33656002)(110136005)(76116006)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXBUdExiL21JT2Y2eGpaV0d2dExYRTNueWRkcnV3MWVReEpoQTl5VWp3cGJk?=
 =?utf-8?B?blFaM2NNSE1rLzhoTWJsMjdRaFJia3dBVGR1ZnZSNW1xMk44WG9EWmZHMzFq?=
 =?utf-8?B?M1VlRit5UVhBK1JpMGV0TzhqUXZFSE1wcGpxWDRBM2VJYysvMXh3UWl1UlRY?=
 =?utf-8?B?Rkk0S21sOHNSeEkwZ0lTdURUajdwTm5yUXVWUFJaTGFhT2t4SUdxTlIvRXBn?=
 =?utf-8?B?QTZBSTZkeEYvYThHUTVDa3NPbUpqQjN1ZGpaOTJLS1M5VURSSVY5Ry96dkor?=
 =?utf-8?B?SmJOalJGTlVFUmZhQ3RBbnFSTW16TlVuQ3AwY3VuTDBVcHJuSEVta0wvVmJ5?=
 =?utf-8?B?Z2JScVFEcDNwc3lhWUVJaDU2alNXNU04M0o0YTRRdHRpa1U1NnVwZ3hjaHRj?=
 =?utf-8?B?aDAxaWc3ZDU2d3NicG9zWmVMQnc2RVVmTnFqNW51QU5FaUJmS1R4UUpXVm4y?=
 =?utf-8?B?MExRUnhUWndVM05XWHBsc0VuMG44NHBXL3dqT0x3Y2p5OWNxR0k5Vit5dzBI?=
 =?utf-8?B?ZjlPZG8wQVoyaVJtc2o0UFczWUszNUwvZzVlYzVwd0JtVXBLUDRWMWFYT25l?=
 =?utf-8?B?clRIMll5NmdoRDFzRmc4YzZldk4yTUxLb014WWJuSnNaR0dPaHNmUlhLWVVW?=
 =?utf-8?B?c0NCeE5jdElHV0V3MzZ6M2N1Y0FjTUNxaWppUjMwYzBaS09TWi84bU5HK3hn?=
 =?utf-8?B?Y0RmbFlDbHRsNmNvM1JmR2VvMWQvNFpkanNDSi9TRjRPV0tBVU00QnpxWUND?=
 =?utf-8?B?cXM5dDM1NGlpQi9xTXJQb01jQ3cydDExVFdCMzZlaDBQcG9uMEc5QWp6Z1J0?=
 =?utf-8?B?djBaVzNQb0l1OExLUVBURDJESWxicUp3ZGR6M25STTdnMnhZeDhxR1ZMNTlP?=
 =?utf-8?B?SFBYOWQzSDhnaDJSNDYxelhRd21aWmhuMGR5WFI4VTlqMk0yY0tidVVIVFk5?=
 =?utf-8?B?U3BuRFRxSVRMQXh0TjlaMWV5YUxFTklncktVTkJTRDQ0T1MvYTFkV0dlTFFT?=
 =?utf-8?B?aDM2OVN1YzJmYlNqQXJBTkdIUlhGU0hCbmZWUm9MZ0kzUVdKZDRKS0dJUXJK?=
 =?utf-8?B?T0h5S1RJNjZoM0hYTzlnWlZKRG5hSVgrQUVqcmZsNlFVSVEzZDBhbVBDektI?=
 =?utf-8?B?NHZkQllCTkFYUFAvK1VsZFdBazFmMzZyUGRubCtOcTNqRWZoTStIOVpvZFpi?=
 =?utf-8?B?R1FQZzdZaWNqdkZPOFE0a1UzRDBiMUt2SWJzSU13TmRUUGIrV1lWSkE1Um1U?=
 =?utf-8?B?SGR1TEFDZ1lzcnlPcXhRc0VNd2Joa0g3SWY3ZHpubXBTYlZYb2FEeWhoR2xh?=
 =?utf-8?B?TUVZMEhCVHhUbHFqZDVOaSsranlvV0ZNaGtEbk5vOWxFZkJPYSsxUVphN1Zu?=
 =?utf-8?B?QWZhRHU4d2RTNGVOeFZkNVFYTXBjRVp1NnVRZlE3NUl0QjdCR095NkJGcmp1?=
 =?utf-8?B?Wk9oZlEvQnFoaUM1NnBBLzFSN0NlVjFYbncrbkxMTGdWSUFTMlg2RWRPMFl3?=
 =?utf-8?B?cHh6U2M4VVVhUEtlYW10bU81SHY2RHFCQkx5N2JlSDB2SVBYYnUvdWtmYS9O?=
 =?utf-8?B?d2piY3BIcmVWbkhIU1pLRmJwZFZFSTdvMlZjTWhrS00vdStEZGo5N1NtZXJ1?=
 =?utf-8?B?U0RRcGJ2WGJLaGJMSGs5V3NvM2kyWGlOMmpZMFNmK1ZPN0dJaTZuTkhWK2FK?=
 =?utf-8?B?aEpNNEJGVFlyMEZUclBGY1hEOFEzSkdWdzR1VklGaE45Mitzbld5czljYWF3?=
 =?utf-8?Q?IxyODp7oQ+5pT22UdeFzKipeZ9QJrNbKyjY2bSD?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5232.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af0f12b-c192-48fe-4086-08d94bfedaa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 04:20:21.0820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aXg5M1G1HUYO6wP3E5gFHDFQf+0QKxCzlANmivm7BTWxeUQ4XnoqGq7G7ROgbsFf8hbkxTWslI3BImqY1or79w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5245
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgQ2hyaXN0aWFuLA0KDQpJIGhhdmUgdXBsb2Fk
ZWQgdGhlIGxhdGVzdCBwYXRjaCBhY2NvcmRpbmcgdG8geW91ciBzdWdnZXN0aW9uLg0KDQpCZXN0
IFJlZ2FyZHMsDQpKaW5nV2VuIENoZW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPg0K
U2VudDogVHVlc2RheSwgSnVseSAyMCwgMjAyMSA4OjEzIFBNDQpUbzogQ2hlbiwgSmluZ1dlbiA8
SmluZ1dlbi5DaGVuMkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNj
OiBDaGVuLCBIb3JhY2UgPEhvcmFjZS5DaGVuQGFtZC5jb20+OyBMaXUsIE1vbmsgPE1vbmsuTGl1
QGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL2FtZGdwdTogY29uc2lkZXIg
cGFnaW5nIGpvYiBhbHdheXMgbm90IGd1aWx0eQ0KDQoNCg0KQW0gMjAuMDcuMjEgdW0gMTM6MDIg
c2NocmllYiBKaW5nd2VuIENoZW46DQo+IFtXaHldDQo+IEN1cnJlbnRseSBhbGwgdGltZWRvdXQg
am9iIHdpbGwgYmUgY29uc2lkZXJlZCB0byBiZSBndWlsdHkuIEluIFNSSU9WDQo+IG11bHRpLXZm
IHVzZSBjYXNlLCB0aGUgdmYgZmxyIGhhcHBlbnMgZmlyc3QgYW5kIHRoZW4gam9iIHRpbWUgb3V0
IGlzDQo+IGZvdW5kLiBUaGVyZSBjYW4gYmUgc2V2ZXJhbCBqb2JzIHRpbWVvdXQgZHVyaW5nIGEg
dmVyeSBzbWFsbCB0aW1lIHNsaWNlLg0KPiBBbmQgaWYgdGhlIGlubm9jZW50IHNkbWEgam9iIHRp
bWUgb3V0IGlzIGZvdW5kIGJlZm9yZSB0aGUgcmVhbCBiYWQNCj4gam9iLCB0aGVuIHRoZSBpbm5v
Y2VudCBzZG1hIGpvYiB3aWxsIGJlIHNldCB0byBndWlsdHkuIFRoaXMgd2lsbCBsZWFkDQo+IHRv
IGEgcGFnZSBmYXVsdCBhZnRlciByZXN1Ym1pdHRpbmcgam9iLg0KPg0KPiBbSG93XQ0KPiBJZiB0
aGUgam9iIGlzIGEgcGFnaW5nIGpvYiwgd2Ugd2lsbCBhbHdheXMgY29uc2lkZXIgaXQgbm90IGd1
aWx0eQ0KDQpEb24ndCBzYXkgInBhZ2luZyBqb2IiLCBiZXR0ZXIgImtlcm5lbCBqb2IiLiBTaW5j
ZSB0aGUgUFRFIHVwZGF0ZXMgd2UgYXJlIHVzaW5nIGhlcmUgYXJlIG5vdCBldmVuIHJlbW90ZWx5
IHJlbGF0ZWQgdG8gcGFnaW5nLg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IEppbmd3ZW4gQ2hlbiA8SmluZ3dlbi5DaGVuMkBhbWQuY29tPg0KPiAtLS0NCj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA2ICsrKy0tLQ0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gaW5kZXgg
MzdmYTE5OWJlOGIzLi40MDQ2MTU0NzcwMWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gQEAgLTQ0MTAsNyArNDQxMCw3IEBAIGludCBhbWRn
cHVfZGV2aWNlX3ByZV9hc2ljX3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAg
ICAgICAgICAgICAgIGFtZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlvbihyaW5nKTsN
Cj4gICAgICAgfQ0KPg0KPiAtICAgICBpZihqb2IpDQo+ICsgICAgIGlmIChqb2IgJiYgam9iLT52
bSkNCj4gICAgICAgICAgICAgICBkcm1fc2NoZWRfaW5jcmVhc2Vfa2FybWEoJmpvYi0+YmFzZSk7
DQo+DQo+ICAgICAgIHIgPSBhbWRncHVfcmVzZXRfcHJlcGFyZV9od2NvbnRleHQoYWRldiwgcmVz
ZXRfY29udGV4dCk7IEBAIC00ODc0LDcNCj4gKzQ4NzQsNyBAQCBpbnQgYW1kZ3B1X2RldmljZV9n
cHVfcmVjb3ZlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgICAgICAgICAg
ICAgICAgIERSTV9JTkZPKCJCYWlsaW5nIG9uIFREUiBmb3Igc19qb2I6JWxseCwgaGl2ZTogJWxs
eCBhcyBhbm90aGVyIGFscmVhZHkgaW4gcHJvZ3Jlc3MiLA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBqb2IgPyBqb2ItPmJhc2UuaWQgOiAtMSwgaGl2ZS0+aGl2ZV9pZCk7DQo+ICAg
ICAgICAgICAgICAgICAgICAgICBhbWRncHVfcHV0X3hnbWlfaGl2ZShoaXZlKTsNCj4gLSAgICAg
ICAgICAgICAgICAgICAgIGlmIChqb2IpDQo+ICsgICAgICAgICAgICAgICAgICAgICBpZiAoam9i
ICYmIGpvYi0+dm0pDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRybV9zY2hlZF9p
bmNyZWFzZV9rYXJtYSgmam9iLT5iYXNlKTsNCj4gICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biAwOw0KPiAgICAgICAgICAgICAgIH0NCj4gQEAgLTQ4OTgsNyArNDg5OCw3IEBAIGludCBhbWRn
cHVfZGV2aWNlX2dwdV9yZWNvdmVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGpvYiA/IGpvYi0+YmFzZS5pZCA6IC0x
KTsNCj4NCj4gICAgICAgICAgICAgICAvKiBldmVuIHdlIHNraXBwZWQgdGhpcyByZXNldCwgc3Rp
bGwgbmVlZCB0byBzZXQgdGhlIGpvYiB0byBndWlsdHkgKi8NCj4gLSAgICAgICAgICAgICBpZiAo
am9iKQ0KPiArICAgICAgICAgICAgIGlmIChqb2IgJiYgam9iLT52bSkNCj4gICAgICAgICAgICAg
ICAgICAgICAgIGRybV9zY2hlZF9pbmNyZWFzZV9rYXJtYSgmam9iLT5iYXNlKTsNCj4gICAgICAg
ICAgICAgICBnb3RvIHNraXBfcmVjb3Zlcnk7DQo+ICAgICAgIH0NCg0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
