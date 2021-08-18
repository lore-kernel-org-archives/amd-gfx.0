Return-Path: <SRS0=PfTh=NJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4B5C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 08:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BDC660E09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 08:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5BDC660E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B5376E4C9;
	Wed, 18 Aug 2021 08:45:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9C7E6E4C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Aug 2021 08:45:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIhvRyU50y3g5Zw7hQ6580G6sBKd9fG2Y/uDzT+sZoiIzsT5Fbob08Qf9Ywy1WRJqpcPl9m5gx2kdXzmOntLRU4WICP08q8+3FCyWsyDcpwqErQbi35/3zEpncHRCI51WxPFW2RRXuRAuShweml5MEnE0W/RnVg7j5LVI/BEfCEG+XJCTy+k+podDtbj6ayRIvAUFnYG3azYgULywA1hwbeKwamYqoZqmt0T2NfCvzOhSgvLhSXUxfGPtklMy5P8fd+elI/+DXWHJf9ExpdUaedxOOA5Gn1dXkqranWUtnN4iObqb1QfRaeTKMDyUE9SHg04kkUD/++WK5pxqwp7fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijhpKGR3jviJZFAwAvTRFCsJ0aJ/LJ6VUGMB0uR1niU=;
 b=VLJ+bl/aPxuoj5sg0N4+YZITz7tZFRfGF652t2HPEpXjUtzL/K78KkBznfBMCi+I3pmWc0JieAOZvRl8rxjeiq5XwWZmLhsBd5mZdjCI3/g7butoVThUZ+y1qWm5GtTzKPh5k49i6nP/q7c1v9u56wy8yKnXdV7c52Kgpp3+Y6yyQvfthnCAoogcYiAd3UbvzNpp89ng+7eSNrjuUqP1MPGnnCtFE44voD1NXoln5ZQ0XvIvfgWruV/1DA/EM8S2jvy8dhH43W/xVUUkMf3zkdRiPvU5jtPe6WIhP6hIttAEfMMzozWoy9m2WLCB2s50qW7YLJpXrR0pGRhJqgrZpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijhpKGR3jviJZFAwAvTRFCsJ0aJ/LJ6VUGMB0uR1niU=;
 b=rS8z6caw68okNQzP6FIJQdheN6Njctv321ywWhV+F4rnUd/6zx+ePsc6RiAjeqWF/VkfAfFDRh2311EhEbdISytJx1Rbp8WihtKDRsWipThNmQc1A9LXIBLb9VoxS+8i0A53n1TKR+Ez5oxs0WEADpuO7uV39HCfJRFdGb6qNCg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4960.namprd12.prod.outlook.com (2603:10b6:5:1bc::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16; Wed, 18 Aug 2021 08:45:45 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 08:45:45 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Liu, Leo" <Leo.Liu@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: properly powergate Polaris12 UVD/VCE on
 suspend
Thread-Topic: [PATCH] drm/amdgpu: properly powergate Polaris12 UVD/VCE on
 suspend
Thread-Index: AQHXkzLBqks1LrJJAUud/oBDlwP35at3TFGAgAAjcPCAAAmSAIABc/2g
Date: Wed, 18 Aug 2021 08:45:45 +0000
Message-ID: <DM6PR12MB26190AACC7D8882455FD0819E4FF9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210817064005.1437328-1-evan.quan@amd.com>
 <374e0b56-e81f-b4c6-ae97-0ade2c0f5b36@amd.com>
 <DM6PR12MB26198C4D8A712DE7E7EC0580E4FE9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <2bb2f248-41ab-9c39-0881-c4ea97a7813e@amd.com>
In-Reply-To: <2bb2f248-41ab-9c39-0881-c4ea97a7813e@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-18T08:45:42Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d5d30071-bccf-4e36-86f2-2557767f8ed6;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecff5d3b-1833-400d-fb50-08d9622491fb
x-ms-traffictypediagnostic: DM6PR12MB4960:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB496042CF1CFE726435F1C369E4FF9@DM6PR12MB4960.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n5/p4P6aEaNmH7SI0jkMofiZPjJk/b7y41acxkG/HQPFUe8axgnf+vxEVU10yx6+V72I3142dqgvSmjYpu7EqpKLM5mU47XXX/q97xKG729cM0wmEEf1rj5hw1v6le+D63TVbFAO68/vZor6VB/it9RllFQDGIdwzAKE7t2nt5gWL2wKzhj0P9j6DiUP/bri2smevmy4sGrISldxzG9knh+rauspZtD58EJ8vi1rBUt+BRxnVLHfaWq75ZKIRBfWQ44s+yQGmxricqrG4o3CwgOFATwrnQcDmaloiLgM7M1RciQMHU64m9sXO2hWLs37N9oNCMKogdpO4yi70DtCvIS0ojUcgZ7ndoPlGVYHm6VQZuEImevHXoRjuV8/WynaYRsLCPwptKIi3fzZ6Hv7YejjUOe24e3OGGVTu5pVcyjuw25lh3xkeKhZeaLZXoX465zM+Jjrpo6sZYEfvadBZnfMSPFF9dLtUWxONDWh5BqnGVapNYNQCauOvHxqieu7IfnzjkybCqtnE2PMwRZ8+//pvn2+EGGjYpsWSrkSlgLCz46DpVXhFIpbdFsLjZQdB8bO/x+O3laBpk1BzWNVf0ZpmcNlK4t+HMyL+U0/ZfunpVK0tkGnBPgCX5yq6vL+5+NRkoPWiWtXl6DrW+dnUV5n6etxX+QOotjHiREJlsp5aKnN87rzQVzXUl8bCdNd4ofaUd181rlAGfOSnHCWSQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(2906002)(53546011)(6506007)(122000001)(38070700005)(7696005)(38100700002)(478600001)(5660300002)(83380400001)(52536014)(110136005)(54906003)(15650500001)(6636002)(316002)(4326008)(55016002)(9686003)(71200400001)(26005)(64756008)(8936002)(66446008)(66556008)(76116006)(66476007)(66946007)(8676002)(86362001)(186003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTdqK3NidWtKbm9idkNleGZGUlVRN2J6ODZrUkZuUy9pNTR2cktHY3RaY2lJ?=
 =?utf-8?B?OFNqcWgvM1lqS1pLWU9IOHVhL2lUdVBCTVVpSFhPMENDdFJ4NUpxcnEzSmor?=
 =?utf-8?B?RS9zMEU5MnJ4dGlnY3hwamV5cEMxY3pnZ2JqOGF5Z1lpclpLRlhNMHlLRTJp?=
 =?utf-8?B?K1AzZUttckp0TUo1amtPZWt1RHVYZStwYS9tTFFlYlFVUE5KZ0hpOUJsd1p2?=
 =?utf-8?B?VVZCdlJWZFBsbXd3WnhLRXdCdjZIOXVNNDNZOWFIbURuUGZEQklsTDd3STE3?=
 =?utf-8?B?d3d3V1VJMmluZTFWWngwVFlQTnZxOWIrbkcxVlNDWjU2SEo1WUk3cHg0TWlJ?=
 =?utf-8?B?SFNmQURtWnk2dm42VGdZdUE5Qk9MWjIwZVk5dXpPRzEzZzZzVFdLNVNWUGdl?=
 =?utf-8?B?aHpRVEJGdVBsMTk0TTFMcFBwdng4SHhBV0xrd1FxQUI2OTF2cWQ5SGhXZk41?=
 =?utf-8?B?NVdXNzJyTDg5MndUSENwOGlpTlcwbkpvUXhmbERENDRqRzB2SGZTWXhCQWx5?=
 =?utf-8?B?bjlaeXJBdEM1czNzaGMyOWpKeHNsY0Vwbk9LMml4S3RvelRBT0gzeitrK3ZH?=
 =?utf-8?B?dW9iMS9tV3M3NGI5NzJ4RE91dDdzVGhKRHRCblJIRWJUc3ZhS3ovbUxXYmpl?=
 =?utf-8?B?VXhqa1hXNHdFQjNXOXpjajJadVc3V1VQSzZXRVZFWTVwdUNINUpwTUV0elpl?=
 =?utf-8?B?T2cvbTYxZnhpeWtjNmlCdk5UYTJ6ZmxMNmREQ0pBSHFWbXE2Z0huQmIxWkFv?=
 =?utf-8?B?MnZiRE1YNjljNlFuVHV4UTQ1KzRzeVhxUkY0QVpzckNUc0Y2NXowUjFFS2I5?=
 =?utf-8?B?VUwxY2xqSVJtTEc4YnkvTHkyT2xDeFZGR25DbUxBUjc3L1FqSnhGaWcxMmJa?=
 =?utf-8?B?OWlLZmNvRVp3SEU4RmhzNGV0bzdHV1U0L1pYbVoyS1VzRFhzV3gxSWpYNjRx?=
 =?utf-8?B?T0JoY1BzU2YrVVVsZVdnMXV4MytlKzJna05BaitUR1Z2M3cxYVBqSVJRaTNY?=
 =?utf-8?B?Rm9XN1Z2NDNQR1hYczNKSzBDRTl5Ym1iOExvei9OMkRYS1FoTi81UXYxM0lu?=
 =?utf-8?B?Mlg4YmpnaHg4VG4yeGxaYkV3cnFjNng5OGVzVkxFa1BpWHh0V0RZSXNCQ29s?=
 =?utf-8?B?SCttbXVjcTdNT2Y0RUgwVlBvaGpJTEliZHFFNnVmMENiL0xVVnR3dkpCZFhn?=
 =?utf-8?B?UWFDbzdGU2FwUEZYRWhleitRR1FwVWtQS2hUM0JaamQyYVNyZkFVWWUvQzNu?=
 =?utf-8?B?RXJwTVdTK0lvaElUQTZ0NUNwb0N5WnRKc1dmMEQ1VldMM2d0VVdIZld2a1I1?=
 =?utf-8?B?OXJFb1Zwa0FvUFM0ZTl0cWdYOWRNbDJpdVMrUmhxNDdyRzhoTFdBc0Zic3Jq?=
 =?utf-8?B?NStoSjQwUzRVbWp1QzdkbmREWnJEOFc1VHBOTDc4Q3k1dUwvSmVqVDVESThw?=
 =?utf-8?B?YkxKN0JaNUxwNnJoeWQ4U2tna2RvQWlwUzdxOGNDaEw2RHdpTlZ5aG9DdmlM?=
 =?utf-8?B?a2RTZ3FUVkp5UlNZRklBNjRVaUlUbHdXUjJHL3V2V3lCTUtlMWgrd3ZSM0ls?=
 =?utf-8?B?UDk5ckhxVlFhUm5lYXZyQStib0RDZWVwNnhuRnIxQ080aDZBekx6OVdtQi9k?=
 =?utf-8?B?SnUyVGpjeWtjaFIwY1E2RWFJQ1l3a2dGZzUzdy9VTjVvcEpRK2tTaDdzMnRk?=
 =?utf-8?B?WGNjZ01pY0dVdUc5ZWJwVDN6MGhXYkxvRi9LWlFVYnpBSTlSTGc4UmhWSlE4?=
 =?utf-8?Q?8Nak/6e6fcrKD7GIkyo3AvZ5QRnI9w0ch8xvUA+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecff5d3b-1833-400d-fb50-08d9622491fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 08:45:45.6041 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A5bW+iLFA763V5BvSV4KRCMCDPcLuOE7xYYZ4PRHy9zhyDT3tewBf4JIDml7u5Sr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4960
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
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogVHVl
c2RheSwgQXVndXN0IDE3LCAyMDIxIDY6MDkgUE0NCj4gVG86IFF1YW4sIEV2YW4gPEV2YW4uUXVh
bkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IExpdSwNCj4gTGVvIDxM
ZW8uTGl1QGFtZC5jb20+DQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+OyBDaGVuLCBHdWNodW4NCj4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+OyBQYW4s
IFhpbmh1aSA8WGluaHVpLlBhbkBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0v
YW1kZ3B1OiBwcm9wZXJseSBwb3dlcmdhdGUgUG9sYXJpczEyIFVWRC9WQ0UNCj4gb24gc3VzcGVu
ZA0KPiANCj4gDQo+IA0KPiBPbiA4LzE3LzIwMjEgMzoxMyBQTSwgUXVhbiwgRXZhbiB3cm90ZToN
Cj4gPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5XQ0KPiA+DQo+ID4gK0xlbyB0byBzaGFyZSBoaXMg
aW5zaWdodHMNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9t
OiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBB
dWd1c3QgMTcsIDIwMjEgMzoyOCBQTQ0KPiA+PiBUbzogUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFt
ZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+PiBDYzogRGV1Y2hlciwg
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgQ2hlbiwgR3VjaHVuDQo+ID4+
IDxHdWNodW4uQ2hlbkBhbWQuY29tPjsgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT4N
Cj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogcHJvcGVybHkgcG93ZXJnYXRl
IFBvbGFyaXMxMg0KPiBVVkQvVkNFDQo+ID4+IG9uIHN1c3BlbmQNCj4gPj4NCj4gPj4NCj4gPj4N
Cj4gPj4gT24gOC8xNy8yMDIxIDEyOjEwIFBNLCBFdmFuIFF1YW4gd3JvdGU6DQo+ID4+PiBJZiB0
aGUgcG93ZXJnYXRpbmcgb2YgVVZEL1ZDRSBpcyBpbiBwcm9jZXNzLCB3YWl0IGZvciBpdHMgY29t
cGxldGlvbg0KPiA+Pj4gYmVmb3JlIHByb2NlZWRpbmcoc3VzcGVuZGluZykuIFRoaXMgY2FuIGZp
eCBzb21lIGhhbmdzIG9ic2VydmVkIG9uDQo+ID4+PiBzdXNwZW5kaW5nIHdoZW4gVVZEL1ZDRSBz
dGlsbCB1c2luZyhlLmcuIGlzc3VlICJwbS1zdXNwZW5kIiB3aGVuDQo+ID4+PiB2aWRlbyBpcyBz
dGlsbCBwbGF5aW5nKS4NCj4gPj4+DQo+ID4+PiBDaGFuZ2UtSWQ6IEkzNmYzOWQ5NzMxZTBhOTYz
OGI1MmQ1ZDkyNTU4YjBlZTljMjNhOWVkDQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4g
PGV2YW4ucXVhbkBhbWQuY29tPg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGlu
aHVpLnBhbkBhbWQuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS91dmRfdjZfMC5jIHwgNSArKysrKw0KPiA+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmNlX3YzXzAuYyB8IDUgKysrKysNCj4gPj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwg
MTAgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS91dmRfdjZfMC5jDQo+ID4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3V2ZF92Nl8wLmMNCj4gPj4+IGluZGV4IDRlZWJmOTczYTA2NS4uMmZkY2U1NzJiYWViIDEw
MDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y2XzAuYw0K
PiA+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y2XzAuYw0KPiA+Pj4g
QEAgLTU1NCw2ICs1NTQsMTEgQEAgc3RhdGljIGludCB1dmRfdjZfMF9zdXNwZW5kKHZvaWQgKmhh
bmRsZSkNCj4gPj4+ICAgIAlpbnQgcjsNCj4gPj4+ICAgIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsNCj4gPj4+DQo+ID4+PiArCS8q
DQo+ID4+PiArCSAqIElmIHRoZSBwb3dlcmdhdGluZyBpcyBpbiBwcm9jZXNzLCB3YWl0IGZvciBp
dHMgY29tcGxldGlvbi4NCj4gPj4+ICsJICovDQo+ID4+PiArCWZsdXNoX2RlbGF5ZWRfd29yaygm
YWRldi0+dXZkLmlkbGVfd29yayk7DQo+ID4+PiArDQo+ID4+IElmIHJ1bm5pbmcgaWRsZSBpcyBh
IHByZXJlcXVpc2l0ZSBiZWZvcmUgZ29pbmcgdG8gc3VzcGVuZCwgdGhlbg0KPiA+PiBzb21ldGhp
bmcgZWxzZSBpcyBtaXNzaW5nIGhlcmUuDQo+ID4+DQo+ID4+IE90aGVyd2lzZSwgdGhlIGhhbmcg
bG9va3MgbW9yZSBsaWtlIGEgcGVuZGluZyB3b3JrIGxhdW5jaGVkIGFmdGVyDQo+ID4+IGhhcmR3
YXJlIGlzIHN1c3BlbmRlZCBhbmQgdHJ5aW5nIHRvIGFjY2VzcyBoYXJkd2FyZS4gQXMgdGhlIGhh
cmR3YXJlDQo+ID4+IGlzIGdvaW5nIHRvIGJlIHN1c3BlbmRlZCBhbnl3YXksIGRvZXNuJ3QgaXQg
d29yayB3aXRoDQo+ID4+IGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYyAtIG1ha2luZyBzdXJlIHRo
YXQgbm90aGluZyBpcyBnb2luZyB0byBiZQ0KPiA+PiBsYXVuY2hlZCBsYXRlciB0byBhY2Nlc3Mg
aGFyZHdhcmU/DQo+ID4gW1F1YW4sIEV2YW5dIFRoZSByZWFzb24gd2UgY2hvc2UgZmx1c2hfZGVs
YXllZF93b3JrIGluc3RlYWQgb2YNCj4gY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jIGlzIHdlIHRo
aW5rIHRob3NlIG9wZXJhdGlvbnMgcGVyZm9ybWVkIGluDQo+IGlkbGVfd29yayhkcG0gZGlzYWJs
ZW1lbnQsIHBvd2VyZ2F0aW5nKSBzZWVtcyBuZWVkZWQgY29uc2lkZXJpbmcgdGhlDQo+IGFjdGlv
biBpcyAnc3VzcGVuZCcuIFNvLCBpbnN0ZWFkIG9mICJjYW5jZWwiLCBtYXliZSB3YWl0aW5nIGZv
ciB0aGVtDQo+IGNvbXBsZXRpb24gaXMgbW9yZSBwcm9wZXIuDQo+IA0KPiBCdXQgaXQgd2lsbCBk
byBzbyBvbmx5IGlmIHRoZSB3b3JrIGlzIHNjaGVkdWxlZCAtIHNvIGl0IGRvZXNuJ3Qgc2VlbSB0
byBiZSBhDQo+IHByZXJlcXVpc2l0ZSBmb3Igc3VzcGVuZC4gSWYgaXQgd2FzIGEgcHJlcmVxdWlz
aXRlLCB0aGVuIHRoZSBleGlzdGluZyBjb2RlIGlzDQo+IG1pc3NpbmcgdGhhdCAoc28gdGhhdCBp
dCBnZXRzIGRvbmUgZm9yIGFsbCBjYXNlcykuDQpbUXVhbiwgRXZhbl0gSnVzdCBjb25maXJtZWQg
dGhhdCBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoKSBhbG9uZSBjYW5ub3Qgd29yay4gDQpJbiBm
YWN0LCBvdXIgY3VycmVudCBkcml2ZXIgYWxyZWFkeSBnZXQgY2FuY2VsX2RlbGF5ZWRfd29ya19z
eW5jKCkgY2FsbGVkKGUuZy4gaW4gYW1kZ3B1X3V2ZF9zdXNwZW5kKCkgb24gdGhlIHBhdGggb2Yg
dXZkX3Y2XzBfc3VzcGVuZCkuDQpUbyBnZXQgdGhlIGlzc3VlIGZpeGVkLCBpdCBoYXMgdG8gYmUg
ZWl0aGVyOg0KMS4gZmx1c2hfZGVsYXllZF93b3JrKCkNCk9yIA0KMi4gY2FuY2VsX2RlbGF5ZWRf
d29ya19zeW5jICsgYW1kZ3B1X2RwbV9lbmFibGVfdXZkL3ZjZShhZGV2LCBmYWxzZSkgKHRoZSBq
b2IgcGVyZm9ybWVkIGluIGlkbGUgd29yaykNCg0KQnR3LCBJIGRvIG5vdCB0aGluayBmbHVzaF9k
ZWxheWVkX3dvcmsoKSBpcyBhbiBpbmNvbXBsZXRlIGZpeC4gU2luY2UgdGhlIFVWRC9WQ0UgaWRs
ZSB3b3JrIGlzIGFwcGVuZGVkIG9uIHJpbmctPmZ1bmNzLT5lbmRfdXNlLg0KU28sIGFzIGxvbmcg
YXMgdGhlIFVWRC9WQ0UgcmluZyB1c2VkIGFuZCBlbmRlZChpdCB3aWxsIHNpbmNlIGF0IGxlYXN0
IHRoZXJlIGlzIHJpbmcvaWIgdGVzdCksIHRoZXJlIHdpbGwgYmUgYSBjaGFuY2UgdG8gZ2V0IHRo
ZSB3b3JrIHdhaXRlZCBhbmQgY29tcGxldGVkLg0KDQpCUg0KRXZhbg0KPiANCj4gPj4NCj4gPj4g
VGhlbiB0aGlzIG1heSBiZSBhIHBvdGVudGlhbCBpc3N1ZSBmb3Igb3RoZXIgc3VzcGVuZCBjYWxs
cyBhbHNvIHdoZXJlDQo+ID4+IHdvcmsgaXMgcGVuZGluZyB0byBiZSBsYXVuY2hlZCB3aGVuIGhh
cmR3YXJlIGlzIHN1c3BlbmRlZC4NCj4gPiBbUXVhbiwgRXZhbl0gRG8geW91IG1lYW4gd2UgbmVl
ZCB0byBjaGVjayB3aGV0aGVyIHRoZXJlIGlzIHNpbWlsYXIgaXNzdWUNCj4gZm9yIG90aGVyIElQ
cz8NCj4gPg0KPiANCj4gWWVzLCBpZiB0aGVyZSBhcmUgY2FzZXMgd2hlcmUgb3RoZXIgSVBzIG1h
eSBzY2hlZHVsZSBhIGRlbGF5ZWQgd29yayBhbmQgY2FsbA0KPiBod19maW5pIHdpdGhvdXQgY2Fu
Y2VsbGluZyB0aGUgd29yay4NCj4gDQo+IFRoYW5rcywNCj4gTGlqbw0KPiANCj4gPiBCUg0KPiA+
IEV2YW4NCj4gPj4NCj4gPj4gVGhhbmtzLA0KPiA+PiBMaWpvDQo+ID4+DQo+ID4+PiAgICAJciA9
IHV2ZF92Nl8wX2h3X2ZpbmkoYWRldik7DQo+ID4+PiAgICAJaWYgKHIpDQo+ID4+PiAgICAJCXJl
dHVybiByOw0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zj
ZV92M18wLmMNCj4gPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3YzXzAuYw0K
PiA+Pj4gaW5kZXggNmQ5MTA4ZmEyMmUwLi5mMGFkZWNkNWVjMGIgMTAwNjQ0DQo+ID4+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjNfMC5jDQo+ID4+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjNfMC5jDQo+ID4+PiBAQCAtNTAzLDYgKzUwMywx
MSBAQCBzdGF0aWMgaW50IHZjZV92M18wX3N1c3BlbmQodm9pZCAqaGFuZGxlKQ0KPiA+Pj4gICAg
CWludCByOw0KPiA+Pj4gICAgCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBh
bWRncHVfZGV2aWNlICopaGFuZGxlOw0KPiA+Pj4NCj4gPj4+ICsJLyoNCj4gPj4+ICsJICogSWYg
dGhlIHBvd2VyZ2F0aW5nIGlzIGluIHByb2Nlc3MsIHdhaXQgZm9yIGl0cyBjb21wbGV0aW9uLg0K
PiA+Pj4gKwkgKi8NCj4gPj4+ICsJZmx1c2hfZGVsYXllZF93b3JrKCZhZGV2LT52Y2UuaWRsZV93
b3JrKTsNCj4gPj4+ICsNCj4gPj4+ICAgIAlyID0gdmNlX3YzXzBfaHdfZmluaShhZGV2KTsNCj4g
Pj4+ICAgIAlpZiAocikNCj4gPj4+ICAgIAkJcmV0dXJuIHI7DQo+ID4+Pg0K
