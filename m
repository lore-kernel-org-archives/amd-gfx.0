Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570F7C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 07:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CED76103C
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 07:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1CED76103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90B776E090;
	Wed, 13 Oct 2021 07:06:12 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990AE6E090
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 07:06:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/Hl31+o6FnwVumCknlnSeBrFle6oWpZ0GGUwlL9G3ikiuVKJvr1vyzNOcp+73wc1HM+9k7C/qPeOxb3cuYnJ9tUrTdKzAjzvW7/DiJKi3lFdMeQbZB5EPuBoJlD/yfLpmXG0vRmi7qnUQ4XlJrTJOr0YIh5C6KcIN0PdSNj8yX8WVD5QKaTe2ycQFvsX2XC+ucf3Ox9LWTsjaj+8tX8HIb8HKobl/7xosE0uLEZtNfv6xvE3HcPjBLqYJXvViCoV/p1cYzP7eJI+iNGUPX/8cWM31q3k/B/Qhax62S2tXvJnDDzKrqglaE18H1sB8HwNyUxOYjuxltL/+6SUcTTVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqcgKMauBRShBsJKOrwwwRSmSFGf4pR3kqj9slciFJA=;
 b=oHcM7R7vQfFCyqSgnOyvuAgtNsgHTRI2/jfpsriPf3K0vQfBP7zQtYFR1undc/NzJUlFvPjFXeFdGRQhfvP1NDdhpEnAOicR0fmZMKecDwcs1qK5i26J8W1w3yvevDBGHnoiijlDz0935w8jqfSl94Myknj+ptwTcVTkHROZO+/VH0IhqRzHjpeLwLK5LRbXytl3sHupJkwbtGXK7bubK2YtU8/J5wnshTVhNbmK8Cr4CHfBNWHy8B2/ZyB+28PaoIMDrvG7qeEDMC3qX6jCMzscD2MxEZUIzAP4qOAsyI03cVpsufx9DzoZnfymLxqATu552ZSVSTCXSTfWoKWwow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqcgKMauBRShBsJKOrwwwRSmSFGf4pR3kqj9slciFJA=;
 b=WwX35hPNbH2YArdUoXvh+pVKSL1fG5GT0367Evi78r28o3xzQPye1kOC+ve06LxauQ9ci85BjynmyNcFsjVQKMAkveQ7ymwMI2MdkxXZxyhJZvmU6IJN0/VEpDbSdMwfvy4J8jner5kt5u+zGkZY4m4OAcm9stv8GUwDKZuPaAE=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4987.namprd12.prod.outlook.com (2603:10b6:5:163::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Wed, 13 Oct 2021 07:06:09 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5%6]) with mapi id 15.20.4587.029; Wed, 13 Oct 2021
 07:06:09 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Tuikov, Luben"
 <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 0/5] 0 MHz is not a valid current frequency
Thread-Topic: [PATCH 0/5] 0 MHz is not a valid current frequency
Thread-Index: AQHXv9/26Aazo+zq7k25iwVqG7vigqvQUc0AgAAu+yA=
Date: Wed, 13 Oct 2021 07:06:09 +0000
Message-ID: <DM6PR12MB26199D9A65F3FBD851EB9FBFE4B79@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211013031042.53540-1-luben.tuikov@amd.com>
 <858da53c-7937-3ebf-360d-f20f30f825d9@amd.com>
In-Reply-To: <858da53c-7937-3ebf-360d-f20f30f825d9@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-13T07:06:03Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e052b2dc-09af-47f0-92c9-1845a5abb2e0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba06bcdb-ae45-473f-eecf-08d98e17eed6
x-ms-traffictypediagnostic: DM6PR12MB4987:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB49871FD3EC781A31F89D3693E4B79@DM6PR12MB4987.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R28U0Kh28o/SvaUJABoGSkOfW/eRUSWnGlf/KR0FwfIpVHJ1Te8oqiMPQsRPArEeYHvsjB9EkbO0L7ppBpHUgqbx8kXFVwc1kIJOChu3YJX/aiagykuY+b+OO5+UCWbgQQVT98jXZAhYFIsYaU7yye2HUEu51xR3O4U5wZnIq2Euizi/8BVLTChICMruqivJKaYQfWAyUh/r9XEKyi/FF3DUrV4RANbEy9CYF2jx116EQIjHuEC/ent7IkE6AxWa2iu1OxXCnKWFRYwg6fkRuJ4EiVVbHLesFO22wWsS2/AwVC9/V4TslVGHLaWRmQm5MsQYPE0V8iQCvGF50MLRPe+q69SfDsMoKkjT3YEuIrs6ErC91dmPw/J2ViFx7WEunSyqjgYf9DAtL8u9+AvgTMK7yNhLfBhu7nmi6hTSKvabKGxv1ifs18EUr+9QHyxX3D42qhp4KoQyyseSx+7qW5m+KaVTz3fJLpdnrTo9/OJC8nOMl9X1j4E6P6JSsj2wyyVouyYm4wuz9UonFN8wls170YJOGH5100At7W0LofJeARK9qARJ/Q9n2RfEmxDkJ3juCr3wbCbYroOTRS9m8+963voJIsABBhToDpYOaB9+AaLUlrJkuBM7o73cp2BgrmgYb1zC68zx3iFMgtaBk8ORfD2LU/KV2TJB/nSdOVg20RVz5GQaLz+/kV9WiK1PdqY5imyjlTXa2WcXZoiwXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016002)(71200400001)(8676002)(26005)(64756008)(66446008)(38100700002)(83380400001)(8936002)(66556008)(2906002)(122000001)(38070700005)(9686003)(66946007)(66476007)(508600001)(186003)(7696005)(76116006)(110136005)(52536014)(33656002)(86362001)(6506007)(4326008)(316002)(5660300002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVoxcGErM3hPOXhPZEM1MGtlUTRwQXdqcklJK3NoeVJTdU1Cb0FSMHAzZ0JE?=
 =?utf-8?B?b3g1c2NiV3RGaGE3VE9rUVdjVDBDTmJsS1hXUThRQ2lNV25MUlVYeEIyaEpl?=
 =?utf-8?B?cm1vMlByZEdIak1pM2NtN1NZYmtSRjlqc1NXTDh2QlhreGZJaHZHa2k2c2I4?=
 =?utf-8?B?RjRBZWFyV1o0R2xwL0kxMytHcW5DUFlxVjhYa0VuMUcxbk1HRkp3ZGZwa1lT?=
 =?utf-8?B?WjB1cVlNeW1DMnh3MUU0ZXZUS0tkL21TR3lqWGU3emsxUm5vRFpEcGlpN1Zi?=
 =?utf-8?B?L3pwUW1ZU1BnVXhPM1htUFFPZ1ZJRkUxbDhOeHlxOXBsMDYxTkZzNmxZK0xm?=
 =?utf-8?B?M05QWDNGU1pidi9DaW52bVU1TmhVSnI1UE8xZlFGRW5FYkNiSThmNU1rdk1B?=
 =?utf-8?B?VWJaQnlSdVU3SUgxWkdEcXVIeVRvQ2d4Z0JVUFptZUw1eUZ3V24wNm44T1JX?=
 =?utf-8?B?dDBrdm42WlliNmdQcmYzcWpKcHcrWU4zSGZnL2svdXY2SjRaUzhxYW9ZM1VQ?=
 =?utf-8?B?NmliZ1RuQ3RRRXlDeHJ3ZEVZWm9zd3l3WG1LSmN6VWNKSXl2L2VDdGZwdzBB?=
 =?utf-8?B?d1JtQVdzeEE5UnZnalFqRWQzM0FlVWNrUHlzTWlzK21qYlhvMVRCTmYwZ3Yz?=
 =?utf-8?B?NHc5YU0vSXpOK1BNMzVRQVNISmxaVGRCL3RaWnd0WU5oNjdLcG1lemlqL3pW?=
 =?utf-8?B?dVVGT3JhOUZpeFcySUR6dHNaM1A5dUFYK1dCRVQxaE1GeEpRMmY0TVNEcmpi?=
 =?utf-8?B?bE9tNlFLczV0K1Rjb0tRNEJqVUdmcEQ5eXFEcmJsNHB5NWZpQk5WWHZQQWR0?=
 =?utf-8?B?RDhndjRXTkJEN1JtMElIYTBsL3hsb05sdXM3T0t1aE9uS2x1OWlCa0xBejky?=
 =?utf-8?B?VEg0UlVGU1ZsSnNlZDVmajhWSGRXMk1vN2pKdWkxUG9rU2ppK1ViZ3lqbk94?=
 =?utf-8?B?ek0xaVIxd3I5MHk0bFc4N0pXaFlSU1pmZWJpdk9RYzhzT29LZ0FUK0hyK09t?=
 =?utf-8?B?VmVTenI2ZEFzdW5Ec0V5aFpSa25KUXFyREJFdHBGSmo4elNPellFWUN6cHlj?=
 =?utf-8?B?L3lkd0pLNFZQTkZ1ZnJBdEVjWGtQemtGY1JLdkVyL1BQVWR4RkR1Qi9pb0Ju?=
 =?utf-8?B?R2xlS3VtTEhCTVpNeHJibHA3SWpzeE9JaUsvOG9saXRva1N3djZaVGNhaDlU?=
 =?utf-8?B?czlyYVVCNDlWTUhXR25iV0E2SXIxdnZnNUlMSkhaMnMzV2lZSzdPQlpwYWJm?=
 =?utf-8?B?R1hDd05ZRlhpeHg4UEZhRi8vaW1rNmZ1d3VHNWFNWHlFRk9SRjMyY3JXUk9W?=
 =?utf-8?B?ZHk5SURCQWV3QUdHSGh6UmVvZ3g1eFk5QjQzdWpjUUx2YnRFS1JHeFVvdSt2?=
 =?utf-8?B?WG1jQWNaNGdxWnUxcUVVeVphYVozUVFTZWFHN3dMbjVmZnlDNm5RWFlFS3hC?=
 =?utf-8?B?UmhXUFNJL0g1MUxKWWFINENYczJZMHd1Zmx0aGhPMlVGLzlBUWp5VGphcEdu?=
 =?utf-8?B?QmtmWXRhNm1FK0xJUEdEeHZGZDRqWEhWWlVUZ3pnSU1TbStCZGl2Q1lEV2NQ?=
 =?utf-8?B?eE5DdzJXZkdLNktrU0krTjMxM2ZoWkUvSXNELzRVNG1RNUVtNm0wU2dtU2ZQ?=
 =?utf-8?B?UWF6emdYbmQrd05BR3k2bTcrNVl1anM1RXZQUG9sL0RpUkc2TUcvMSsxWlhw?=
 =?utf-8?B?Q29VUUVXcGcxVExJcHdyVDlzRnIvcGtYZngwQlRZdWpFWXVMeEFpdmp3NE03?=
 =?utf-8?Q?W1Yp8fX1Gjsk4a1cjoZbiifzevBK4a6Z7gZkvYG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba06bcdb-ae45-473f-eecf-08d98e17eed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 07:06:09.0412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: liYxEWdfuWWrNZFliH4WTQPv2IBx/fcfYmTKfb7iq9JtsiVkCAwoeqKQqtS98I2+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4987
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSSBhZ3JlZSB3aXRoIExpam8uIA0KUmVwb3J0aW5n
IGEgInJvdW5kIHRvIHRoZSBzbWFsbGVzdCBvcGVyYXRpbmcgZnJlcXVlbmN5IiBqdXN0IG1ha2Vz
IHVzZXIgbW9yZSBjb25mdXNpbmcuIA0KQXMgcGVyIGRlc2lnbmVkLCB0aGUgZnJlcXVlbmN5IG1h
cmtlZCB3aXRoICIqIiBzaG91bGQgcmVmbGVjdCB0aGUgY3VycmVudCBjbG9jayBmcmVxdWVuY3ku
DQoNCkJSDQpFdmFuDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1n
ZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0K
PiBMYXphciwgTGlqbw0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMTMsIDIwMjEgMTI6MTQg
UE0NCj4gVG86IFR1aWtvdiwgTHViZW4gPEx1YmVuLlR1aWtvdkBhbWQuY29tPjsgYW1kLQ0KPiBn
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC81XSAwIE1IeiBp
cyBub3QgYSB2YWxpZCBjdXJyZW50IGZyZXF1ZW5jeQ0KPiANCj4gDQo+IA0KPiBPbiAxMC8xMy8y
MDIxIDg6NDAgQU0sIEx1YmVuIFR1aWtvdiB3cm90ZToNCj4gPiBTb21lIEFTSUMgc3VwcG9ydCBs
b3ctcG93ZXIgZnVuY3Rpb25hbGl0eSBmb3IgdGhlIHdob2xlIEFTSUMgb3IganVzdA0KPiA+IGFu
IElQIGJsb2NrLiBXaGVuIGluIHN1Y2ggbG93LXBvd2VyIG1vZGUsIHNvbWUgc3lzZnMgaW50ZXJm
YWNlcyB3b3VsZA0KPiA+IHJlcG9ydCBhIGZyZXF1ZW5jeSBvZiAwLCBlLmcuLA0KPiA+DQo+ID4g
JGNhdCAvc3lzL2NsYXNzL2RybS9jYXJkMC9kZXZpY2UvcHBfZHBtX3NjbGsNCj4gPiAwOiA1MDBN
aHoNCj4gPiAxOiAwTWh6ICoNCj4gPiAyOiAyMjAwTWh6DQo+ID4gJF8NCj4gPg0KPiA+IEFuIG9w
ZXJhdGluZyBmcmVxdWVuY3kgb2YgMCBNSHogZG9lc24ndCBtYWtlIHNlbnNlLCBhbmQgdGhpcyBp
bnRlcmZhY2UNCj4gPiBpcyBkZXNpZ25lZCB0byByZXBvcnQgb25seSBvcGVyYXRpbmcgY2xvY2sg
ZnJlcXVlbmNpZXMsIGkuZS4gbm9uLXplcm8sDQo+ID4gYW5kIHBvc3NpYmx5IHRoZSBjdXJyZW50
IG9uZS4NCj4gPg0KPiA+IFdoZW4gaW4gdGhpcyBsb3ctcG93ZXIgc3RhdGUsIHJvdW5kIHRvIHRo
ZSBzbWFsbGVzdCBvcGVyYXRpbmcNCj4gPiBmcmVxdWVuY3ksIGZvciB0aGlzIGludGVyZmFjZSwg
YXMgZm9sbG93cywNCj4gPg0KPiANCj4gV291bGQgcmF0aGVyIGF2b2lkIHRoaXMgLQ0KPiANCj4g
MSkgSXQgaXMgbWFuaXB1bGF0aW5nIEZXIHJlcG9ydGVkIHZhbHVlLiBJZiBhdCBhbGwgdGhlcmUg
aXMgYW4gdW5jYXVnaHQgaXNzdWUgaW4NCj4gRlcgcmVwb3J0aW5nIG9mIGZyZXF1ZW5jeSB2YWx1
ZXMsIHRoYXQgaXMgbWFza2VkIGhlcmUuDQo+IDIpIE90aGVyd2lzZSwgaWYgME1IeiBpcyBkZXNj
cmliZWQgYXMgR0ZYIHBvd2VyIGdhdGVkIGNhc2UsIHRoaXMgcHJvdmlkZXMgYQ0KPiBjb252ZW5p
ZW50IGludGVyZmFjZSB0byBjaGVjayBpZiBHRlggaXMgcG93ZXIgZ2F0ZWQuDQo+IA0KPiBJZiBz
ZWVpbmcgYSAnMCcgaXMgbm90IHBsZWFzaW5nLCBjb25zaWRlciBjaGFuZ2luZyB0byBzb21ldGhp
bmcgbGlrZQ0KPiAJIk5BIiAtIG5vdCBhdmFpbGFibGUgKGZyZXF1ZW5jeSBjYW5ub3QgYmUgZmV0
Y2hlZCBhdCB0aGUgbW9tZW50KS4NCj4gDQo+IFRoYW5rcywNCj4gTGlqbw0KPiANCj4gPiAkY2F0
IC9zeXMvY2xhc3MvZHJtL2NhcmQwL2RldmljZS9wcF9kcG1fc2Nsaw0KPiA+IDA6IDUwME1oeiAq
DQo+ID4gMTogMjIwME1oeg0KPiA+ICRfDQo+ID4NCj4gPiBMdWJlbiBUdWlrb3YgKDUpOg0KPiA+
ICAgIGRybS9hbWQvcG06IFNsaWdodCBmdW5jdGlvbiByZW5hbWUNCj4gPiAgICBkcm0vYW1kL3Bt
OiBSZW5hbWUgY3VyX3ZhbHVlIHRvIGN1cnJfdmFsdWUNCj4gPiAgICBkcm0vYW1kL3BtOiBSZW5h
bWUgZnJlcV92YWx1ZXMgLS0+IGZyZXFfdmFsdWUNCj4gPiAgICBkcG0vYW1kL3BtOiBTaWVubmE6
IDAgTUh6IGlzIG5vdCBhIGN1cnJlbnQgY2xvY2sgZnJlcXVlbmN5DQo+ID4gICAgZHBtL2FtZC9w
bTogTmF2aTEwOiAwIE1IeiBpcyBub3QgYSBjdXJyZW50IGNsb2NrIGZyZXF1ZW5jeQ0KPiA+DQo+
ID4gICAuLi4vZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvbmF2aTEwX3BwdC5jICAgfCA2MCAr
KysrKysrKystLS0tLS0NCj4gPiAgIC4uLi9hbWQvcG0vc3dzbXUvc211MTEvc2llbm5hX2NpY2hs
aWRfcHB0LmMgICB8IDczICsrKysrKysrKysrKy0tLS0tDQo+IC0tDQo+ID4gICAyIGZpbGVzIGNo
YW5nZWQsIDg2IGluc2VydGlvbnMoKyksIDQ3IGRlbGV0aW9ucygtKQ0KPiA+DQo=
