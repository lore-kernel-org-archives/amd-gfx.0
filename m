Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFC4C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 06:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 037EA10F0ED;
	Wed, 20 Apr 2022 06:18:13 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2041.outbound.protection.outlook.com [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14E8110F0ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 06:18:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXb+5s/QVKB1S0zTBne03U8o7LEP07g0hukH/PPxx07KW2fxiNRhGguS1Pd5yvF4du+YInjqgD3y8mXUMEteo1D53EslVsKgxfyQUri+QFLUJyo+pWNKAjRML/0uB+4rJlziZQaNRI3XxX7NGqiDAZV9AgGPXOJ6bngn6djktKDrVnQAS6xuvHNtvANlresx9EemMZEXgchKV3q+v8wzle1d9Ltb4S5yx6lORkHSqYLwufNFAQWENMED7qKaa3B8yhOPUuUTZmKv+yTsSp7Szwr1epzXbVuzDK8L4t9qb4c+MzBPRnvuMnwYMUA9H+nx1cY9BlIW6Q2YXHNFnr4IHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMY/ISUHw0p9H0YZNVEfehcCdc5nWZk1M6cVdL4w8q8=;
 b=Bt+mEoFjfpa5BemljOKkbBw1UIEErOio8pXjv7+wOKZ0lMmRqch+m119NMrCsxCwhqb0NBBDE90kW9I+Y0n1eRqqHSpsAh7B3h+PJlxBxwiTH/VbGZGd7gUEQ5N6oHmQEdMsTsIyG2L74ak+6N9UrU8/1CWKt4dk8yZGcqeol66wnMhLFiCo29iCjIxPmqK46EqisAiQUBR8g9FVvw0m3bohAK+8tcBGYRlQnMH8qKpFbpP5g6uUUkr/CO5XSsdEHQ66zXpc9MtMoacPoMTiT39F+U5mqwXTpUxu+AA1Qx3Fc1PnnwXIljGnaljxdF2Wz4lgQTRSZpldX9lVllFOgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMY/ISUHw0p9H0YZNVEfehcCdc5nWZk1M6cVdL4w8q8=;
 b=IlGmPjPjfFp1+m1yC+0pLbt4v0WmOgWHGQhOyh/4wDTUVxCQ6VourisiX1+rsgFPl3ASSB76DmobW3Rx8lKkSi/fma4kKU8gDfgUHz1u0DwzFAP1RYMAB2eFkj0XcSXEY/VkAlnHP7VDpFNjT4VytTj0yH2XyTkt0MfBFn1Owfw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4842.namprd12.prod.outlook.com (2603:10b6:5:1fe::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 06:18:09 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::a561:6b71:55fa:ed2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::a561:6b71:55fa:ed2d%8]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 06:18:08 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang,
 Stanley" <Stanley.Yang@amd.com>, "Ziya, Mohammad zafar"
 <Mohammadzafar.Ziya@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: implement RAS interrupt handler for
 poison creation
Thread-Topic: [PATCH 1/3] drm/amdgpu: implement RAS interrupt handler for
 poison creation
Thread-Index: AQHYVGo49RkYNVXphk2oXBzCEVa5T6z4MCeAgAAjb4CAAABAwA==
Date: Wed, 20 Apr 2022 06:18:08 +0000
Message-ID: <BN9PR12MB52572522C17FE66853F289EBFCF59@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220420035317.4008-1-tao.zhou1@amd.com>
 <4d7f8be2-dffb-1fb1-1feb-576e0ebb6f4f@amd.com>
 <DM5PR12MB1770E49B3B2520B4F84A1B99B0F59@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1770E49B3B2520B4F84A1B99B0F59@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-20T06:16:41Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5a51500b-e3fd-4ca4-ae98-3684f9c020a9;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c30a28a-71eb-4cd5-34d3-08da229589f5
x-ms-traffictypediagnostic: DM6PR12MB4842:EE_
x-microsoft-antispam-prvs: <DM6PR12MB484214FD936D07ACD8B2237CFCF59@DM6PR12MB4842.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mrH1m5Qq6amzlB+VVs8VTYNdj3Wpl57UEr7UiWKYzfs6Bo6A/1L7EP6V+fHme6QvfLOW2tgNNA8hVKrAUAJ8PatSL0p4FwewspQEvhYrkeMmAKgEtd0jn7UgrFLWzmz8KyQg/1oqS33TTWGnCVdkYhqsz+GQ1hE0ddIKtUAggw4QJ3HI9iZ/8pweWdh7uWAGydrxkCmY1b4UHeATCbUSDtGenFcA4HFvlzA4qfDRlBUQMb89ZJYVhqyVvaqx0T9ZSIz9YuLVqyDIHhMUOGhZjmPb8F7X9CAvx/opuySXVX7CljyrOGK+xkqUJpBNXMSMKQti0qTsGSKYVDtzcXxLeS3Lf4AUCC/PWqcPB7kgiQnXMRADvO3lDMCxr0tRy1OMuKDEUcDZFgkuszjx16fZZCdJvoFvoBBtDC9ZpAedlLVOTAdaS0MLGHsQ2yCEHKzqzcpGRLijhg7zVM/kRQqYrIc3//xSKsBMfchrx7IhKulR/yOgjwMl5T36j3n12wKJ625J+cEQ9EJTrWI/n3dBuKauJLF0WYVEYzw3ySfSVYg7a1ZQ6MBDnxb3/POHYjWH2ZXTqKZKz+xTCyxqdCNoXF7IvWk8lEo+EBZUvhRBs809eDFCb5SqFWdyxnez1ttQe+s2rVsRuDShtYA/Uq0uyFWixSdGnsBm6gpFXTKp2BpxF8Rhdjj8tG94InKQot971bAYaM+1BOn8tJkw+WxblMSFN51xgz8CHbAgTpn7Ldg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(186003)(83380400001)(26005)(316002)(6636002)(38100700002)(8936002)(5660300002)(508600001)(38070700005)(921005)(9686003)(7696005)(52536014)(33656002)(110136005)(6506007)(53546011)(71200400001)(2906002)(66476007)(66946007)(64756008)(8676002)(76116006)(66446008)(66556008)(122000001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEFUenVkblNvdnBweVFsY3VFWk4wQjhpOTkxOHhjSUdEZHEyTzhueGVKK20x?=
 =?utf-8?B?TWRDWFR5QWpKODg4QXRGZTNaZGgxYUw1bG1lalpLV1RiWTJEbVZad0Q0TitR?=
 =?utf-8?B?a2R3R3JrNHUremFWMXJES2I3RldvTmo0M3VoQk5yRjFxaS9EaXI0Sk1IWnlh?=
 =?utf-8?B?OVAwMGh1NWtMV3pRd0gxY1h1b3pIclJnQzVRQ2NOcTFLa0g5bENuOG1Sc051?=
 =?utf-8?B?Z0FhMk5vOCtXZzhiM2cxVmRZWGhmcXdPWEV5OTZQQWRJczZXZmg0TkhyYy9Q?=
 =?utf-8?B?c0tFOEdTN1hEbUVrcHJEV0hYY0p1eUtmK2w3RWZpWmgrR0l2Z3hvNUgwd2JE?=
 =?utf-8?B?TEl0S2cwdkdPNFdzdUVBd3F1RVNES3RidjU1bjVkbFpNOXJMODZKQnh3SzN0?=
 =?utf-8?B?V1VtbXdGVktTc0tkcE1PcStUekRyc29TZ1RlZHFycmxka21wYkRTRE5PREpH?=
 =?utf-8?B?MUo5MXUySjRuV01XL0RJakV0aU5DMjRGTnk4ZWpiQXRlU0JPNy9GMHVRNkpn?=
 =?utf-8?B?ZThOTkNYakRQc2E0SFZ0aXA5NzNVWlVmaTB6cnFHaUdGYjBDNFpwaGp0QUs3?=
 =?utf-8?B?cUo4OVZkSHpQbEJNVkN0dVRsRzlVc1B4WmdGMld1cGtLVmo4RGR1TWF4NEox?=
 =?utf-8?B?VE44WGE3V1dhZDRXTzFnbkZEaHg3aE1oNGVtTGFweklwNzQ1VTVXZEtkajho?=
 =?utf-8?B?WE50M0xLdTBYQlZ4UHdrOFY0MVRET0hING5YZkNjL2JFWUhzK3RLMmNENW13?=
 =?utf-8?B?Wm9lb2VYTWJYbnlUUzBtU3BsaFYvZE9uQWg3VTlHeFJqZW5DR2hiKzNORGUz?=
 =?utf-8?B?WDY4MlhXMGdtY25zTVNBSHAvRGN6UlB5c29yNWV5WE1ra2JudzFlVldCYUhL?=
 =?utf-8?B?N2FpeFE5c2dMWnJudVQ1cG52QWlaUVI5K00zSk9LQnluRHUwMXBkbzFqMHk3?=
 =?utf-8?B?L3Z3TDZiM2lNdzNTSW9MeTRYQ2N4dmwyMldnT05ETjY2Z3JDMS9Vald1ZDZn?=
 =?utf-8?B?N3dOV3RTK1ZCSlV6WTh6dXhhdkZ0ZnQ1T0J5bWZmcGYrYm53dHA0QnU5UUN1?=
 =?utf-8?B?Ni9iSEFDRy91T2VsTWp1NW5ETU4yZkN6MFRYdEhIU1psSlZmaXZPSHdLblJ6?=
 =?utf-8?B?VXM0VndQenRXUVg1M1J5Y0hMczlKNXhHNUtZL0QrWW45Ryt1L1pWcklXODVz?=
 =?utf-8?B?TlFoaXM3c3F5NitaaVA1K1FUWkE4WURmbFpaU0JkZ3BUNWp4Vzl2enNqY3ZS?=
 =?utf-8?B?NmVBdXZnM2ZaMzlQYjYvTEowdEdycnFPcTEzdCtYOUtMTnYxRytUay8rQThl?=
 =?utf-8?B?MExHeWFZcnAxcU54aG1udGwyZzhXRlBlN0dyKzFrbFJZUnBrdGNsdEREUnBN?=
 =?utf-8?B?enQvY1hIMG1wTDNUTVpjNHorTmRwTFl4VFV1Q2MzZlZOWHRsK2xKRUQ4VmZh?=
 =?utf-8?B?a1RnNEQxNDArN1A3eGRRWEN2TXlqN2JZSXppaXoyM2t3d2ZPZVlPMnJvZkpw?=
 =?utf-8?B?S3pkL3B5c0diLzllcjVEaW5kNFlYSlpTM3E2SFRJY0JsQTYrcFdRV1dmSkFy?=
 =?utf-8?B?QytFY25WM0tjRkg5ZXhQSjRocWVuUGhTNEVJN0REQXFNMGI2QXN3TkgyVVRJ?=
 =?utf-8?B?Tjd4dFR3OHhBOXkzY3BJWFM5YXNXL0pUMXhmclRIb0I0UzN2OHhSZC9oLy9z?=
 =?utf-8?B?d3JyNkN0KzBGRE9ETG5uQjF3V2U1Y3ZJS1F6Rk5HQTRTVmlEcWxKRjZKam9t?=
 =?utf-8?B?azZXSGo4RC9kL0VIcGpnTzUwTWxYRmJwQTl3RWUyMFJ5Q0o5aURQNzBQS1E0?=
 =?utf-8?B?S3hNcDYvMDhvc1lUZElzWHRFREtiNklJY0pIeTBrbC9XL2tjbW1mSnM3b3cw?=
 =?utf-8?B?TzAvTTJyMGgrNU9YT2Z0Umk3cVNmMEwvQnhUVFQ3NFM0cEpRbXhqM1B3cVRI?=
 =?utf-8?B?dEdhbkhhZkQxRTBvdlptdDNzMmwySVpVNzB5a25oQXVCVmtYK0I4UTF0aEpD?=
 =?utf-8?B?emRlREMyQkxoZ1ZOSklpMUJlUWlyNWtvMlZCQkhmeUpTTk1OMGRpSzlGNm1Z?=
 =?utf-8?B?Q3hUWnhkeG9WMVdSdUgzTUxMcGNRd2xoaS9SL0cxY2JWTEc3dktQSi9qNU40?=
 =?utf-8?B?S3hYQTJQU3liVFphbFhBcjB1bkpKQ1Vnbk5qVjB1elBINzBxeGVySllDTW5j?=
 =?utf-8?B?ZzFLcmZ0eGVhZHRHczN1R21vVmY0THFGTWt5Y0E2VTk0Uk85OEYxZTZMclla?=
 =?utf-8?B?eUQ2RGtNU1VJbnlMNldrV01GUVorUHFxcWpnTVVHT1h6cWl0Zk1vMk9RN1ZJ?=
 =?utf-8?B?UHNqL1dGL05pU1dNRjdlb2VrelpRSEtueXliekFsdGozMTQ5UUFTdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c30a28a-71eb-4cd5-34d3-08da229589f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 06:18:08.6050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUd9DElc/TcFZTRRhvfE6FPLbeb0gE3CZ7JbrjXSHNc9s3q5kCEAWUUAzP7Fu0SxyDJv6gHPOZBv6P3FLmV71w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4842
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

UGxlYXNlIGFsc28ga2VlcCB0aGUgbmFtaW5nIHN0eWxlIGNvbnNpc3RlbnQgYnkgdXNpbmcgImFt
ZGdwdV9yYXMiIHByZWZpeA0KDQpSZWdhcmRzLA0KSGF3a2luZw0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+IA0KU2VudDog
V2VkbmVzZGF5LCBBcHJpbCAyMCwgMjAyMiAxNDoxNw0KVG86IExhemFyLCBMaWpvIDxMaWpvLkxh
emFyQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWmhhbmcsIEhhd2tp
bmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFlhbmcsIFN0YW5sZXkgPFN0YW5sZXkuWWFuZ0Bh
bWQuY29tPjsgWml5YSwgTW9oYW1tYWQgemFmYXIgPE1vaGFtbWFkemFmYXIuWml5YUBhbWQuY29t
PjsgQ2hhaSwgVGhvbWFzIDxZaVBlbmcuQ2hhaUBhbWQuY29tPg0KU3ViamVjdDogUkU6IFtQQVRD
SCAxLzNdIGRybS9hbWRncHU6IGltcGxlbWVudCBSQVMgaW50ZXJydXB0IGhhbmRsZXIgZm9yIHBv
aXNvbiBjcmVhdGlvbg0KDQpbQU1EIE9mZmljaWFsIFVzZSBPbmx5XQ0KDQoNCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQu
Y29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDIwLCAyMDIyIDEyOjEwIFBNDQo+IFRvOiBa
aG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnOyANCj4gWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFlhbmcsIFN0
YW5sZXkgDQo+IDxTdGFubGV5LllhbmdAYW1kLmNvbT47IFppeWEsIE1vaGFtbWFkIHphZmFyIA0K
PiA8TW9oYW1tYWR6YWZhci5aaXlhQGFtZC5jb20+OyBDaGFpLCBUaG9tYXMgPFlpUGVuZy5DaGFp
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBkcm0vYW1kZ3B1OiBpbXBsZW1l
bnQgUkFTIGludGVycnVwdCBoYW5kbGVyIA0KPiBmb3IgcG9pc29uIGNyZWF0aW9uDQo+IA0KPiAN
Cj4gDQo+IE9uIDQvMjAvMjAyMiA5OjIzIEFNLCBUYW8gWmhvdSB3cm90ZToNCj4gPiBQcmVwYXJl
IGZvciB0aGUgaW1wbGVtZW50YXRpb24gb2YgcG9pc29uIGNvbnN1bXB0aW9uIGhhbmRsZXIuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUYW8gWmhvdSA8dGFvLnpob3UxQGFtZC5jb20+DQo+ID4g
LS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgfCA2MiAr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0
aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gPiBpbmRleCA0YmJlZDc2Yjc5YzguLjJkMDY2Y2ZmNzBl
YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFz
LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4g
PiBAQCAtMTUxNSwxMiArMTUxNSw0NCBAQCBzdGF0aWMgaW50IGFtZGdwdV9yYXNfZnNfZmluaShz
dHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPiAgIC8qIHJhcyBmcyBlbmQgKi8NCj4g
Pg0KPiA+ICAgLyogaWggYmVnaW4gKi8NCj4gPiArc3RhdGljIHZvaWQgcmFzX2ludGVycnVwdF9w
b2lzb25fY3JlYXRpb25faGFuZGxlcihzdHJ1Y3QgcmFzX21hbmFnZXIgKm9iaiwNCj4gPiArCQkJ
CXN0cnVjdCBhbWRncHVfaXZfZW50cnkgKmVudHJ5KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgcmFz
X2loX2RhdGEgKmRhdGEgPSAmb2JqLT5paF9kYXRhOw0KPiA+ICsJc3RydWN0IHJhc19lcnJfZGF0
YSBlcnJfZGF0YSA9IHswLCAwLCAwLCBOVUxMfTsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+
ICsJaWYgKCFkYXRhLT5jYikNCj4gPiArCQlyZXR1cm47DQo+ID4gKw0KPiA+ICsJaWYgKGFtZGdw
dV9yYXNfaXNfcG9pc29uX21vZGVfc3VwcG9ydGVkKG9iai0+YWRldikgJiYNCj4gPiArCSAgICBv
YmotPmhlYWQuYmxvY2sgPT0gQU1ER1BVX1JBU19CTE9DS19fVU1DKQ0KPiA+ICsJCWRldl9pbmZv
KG9iai0+YWRldi0+ZGV2LA0KPiA+ICsJCQkiUG9pc29uIGlzIGNyZWF0ZWQsIG5vIHVzZXIgYWN0
aW9uIGlzIG5lZWRlZC5cbiIpOw0KPiA+ICsJZWxzZSB7DQo+IA0KPiBJdCBpcyBjb25mdXNpbmcg
dG8gaGFuZGxlIFJBUyBpbnRlcnJ1cHRzIHVuZGVyIHBvaXNvbl9jcmVhdGlvbl9oYW5kbGVyIA0K
PiBpbiBub24tIHBvaXNvbiBtb2RlLg0KDQpbVGFvXSB3aWxsIHNwbGl0IGl0IGludG8gcmFzX2lu
dGVycnVwdF9wb2lzb25fY3JlYXRpb25faGFuZGxlciBhbmQgcmFzX2ludGVycnVwdF91bWNfaGFu
ZGxlci4NCg0KPiANCj4gVGhhbmtzLA0KPiBMaWpvDQo+IA0KPiA+ICsJCS8qIExldCBJUCBoYW5k
bGUgaXRzIGRhdGEsIG1heWJlIHdlIG5lZWQgZ2V0IHRoZSBvdXRwdXQNCj4gPiArCQkgKiBmcm9t
IHRoZSBjYWxsYmFjayB0byB1cGRhdGUgdGhlIGVycm9yIHR5cGUvY291bnQsIGV0Yw0KPiA+ICsJ
CSAqLw0KPiA+ICsJCXJldCA9IGRhdGEtPmNiKG9iai0+YWRldiwgJmVycl9kYXRhLCBlbnRyeSk7
DQo+ID4gKwkJLyogdWUgd2lsbCB0cmlnZ2VyIGFuIGludGVycnVwdCwgYW5kIGluIHRoYXQgY2Fz
ZQ0KPiA+ICsJCSAqIHdlIG5lZWQgZG8gYSByZXNldCB0byByZWNvdmVyeSB0aGUgd2hvbGUgc3lz
dGVtLg0KPiA+ICsJCSAqIEJ1dCBsZWF2ZSBJUCBkbyB0aGF0IHJlY292ZXJ5LCBoZXJlIHdlIGp1
c3QgZGlzcGF0Y2gNCj4gPiArCQkgKiB0aGUgZXJyb3IuDQo+ID4gKwkJICovDQo+ID4gKwkJaWYg
KHJldCA9PSBBTURHUFVfUkFTX1NVQ0NFU1MpIHsNCj4gPiArCQkJLyogdGhlc2UgY291bnRzIGNv
dWxkIGJlIGxlZnQgYXMgMCBpZg0KPiA+ICsJCQkgKiBzb21lIGJsb2NrcyBkbyBub3QgY291bnQg
ZXJyb3IgbnVtYmVyDQo+ID4gKwkJCSAqLw0KPiA+ICsJCQlvYmotPmVycl9kYXRhLnVlX2NvdW50
ICs9IGVycl9kYXRhLnVlX2NvdW50Ow0KPiA+ICsJCQlvYmotPmVycl9kYXRhLmNlX2NvdW50ICs9
IGVycl9kYXRhLmNlX2NvdW50Ow0KPiA+ICsJCX0NCj4gPiArCX0NCj4gPiArfQ0KPiA+ICsNCj4g
PiAgIHN0YXRpYyB2b2lkIGFtZGdwdV9yYXNfaW50ZXJydXB0X2hhbmRsZXIoc3RydWN0IHJhc19t
YW5hZ2VyICpvYmopDQo+ID4gICB7DQo+ID4gICAJc3RydWN0IHJhc19paF9kYXRhICpkYXRhID0g
Jm9iai0+aWhfZGF0YTsNCj4gPiAgIAlzdHJ1Y3QgYW1kZ3B1X2l2X2VudHJ5IGVudHJ5Ow0KPiA+
IC0JaW50IHJldDsNCj4gPiAtCXN0cnVjdCByYXNfZXJyX2RhdGEgZXJyX2RhdGEgPSB7MCwgMCwg
MCwgTlVMTH07DQo+ID4NCj4gPiAgIAl3aGlsZSAoZGF0YS0+cnB0ciAhPSBkYXRhLT53cHRyKSB7
DQo+ID4gICAJCXJtYigpOw0KPiA+IEBAIC0xNTMxLDMxICsxNTYzLDcgQEAgc3RhdGljIHZvaWQg
DQo+ID4gYW1kZ3B1X3Jhc19pbnRlcnJ1cHRfaGFuZGxlcihzdHJ1Y3QNCj4gcmFzX21hbmFnZXIg
Km9iaikNCj4gPiAgIAkJZGF0YS0+cnB0ciA9IChkYXRhLT5hbGlnbmVkX2VsZW1lbnRfc2l6ZSAr
DQo+ID4gICAJCQkJZGF0YS0+cnB0cikgJSBkYXRhLT5yaW5nX3NpemU7DQo+ID4NCj4gPiAtCQlp
ZiAoZGF0YS0+Y2IpIHsNCj4gPiAtCQkJaWYgKGFtZGdwdV9yYXNfaXNfcG9pc29uX21vZGVfc3Vw
cG9ydGVkKG9iai0+YWRldikNCj4gJiYNCj4gPiAtCQkJICAgIG9iai0+aGVhZC5ibG9jayA9PSBB
TURHUFVfUkFTX0JMT0NLX19VTUMpDQo+ID4gLQkJCQlkZXZfaW5mbyhvYmotPmFkZXYtPmRldiwN
Cj4gPiAtCQkJCQkJIlBvaXNvbiBpcyBjcmVhdGVkLCBubyB1c2VyDQo+IGFjdGlvbiBpcyBuZWVk
ZWQuXG4iKTsNCj4gPiAtCQkJZWxzZSB7DQo+ID4gLQkJCQkvKiBMZXQgSVAgaGFuZGxlIGl0cyBk
YXRhLCBtYXliZSB3ZSBuZWVkIGdldA0KPiB0aGUgb3V0cHV0DQo+ID4gLQkJCQkgKiBmcm9tIHRo
ZSBjYWxsYmFjayB0byB1ZHBhdGUgdGhlIGVycm9yDQo+IHR5cGUvY291bnQsIGV0Yw0KPiA+IC0J
CQkJICovDQo+ID4gLQkJCQltZW1zZXQoJmVycl9kYXRhLCAwLCBzaXplb2YoZXJyX2RhdGEpKTsN
Cj4gPiAtCQkJCXJldCA9IGRhdGEtPmNiKG9iai0+YWRldiwgJmVycl9kYXRhLCAmZW50cnkpOw0K
PiA+IC0JCQkJLyogdWUgd2lsbCB0cmlnZ2VyIGFuIGludGVycnVwdCwgYW5kIGluIHRoYXQgY2Fz
ZQ0KPiA+IC0JCQkJICogd2UgbmVlZCBkbyBhIHJlc2V0IHRvIHJlY292ZXJ5IHRoZSB3aG9sZQ0K
PiBzeXN0ZW0uDQo+ID4gLQkJCQkgKiBCdXQgbGVhdmUgSVAgZG8gdGhhdCByZWNvdmVyeSwgaGVy
ZSB3ZSBqdXN0DQo+IGRpc3BhdGNoDQo+ID4gLQkJCQkgKiB0aGUgZXJyb3IuDQo+ID4gLQkJCQkg
Ki8NCj4gPiAtCQkJCWlmIChyZXQgPT0gQU1ER1BVX1JBU19TVUNDRVNTKSB7DQo+ID4gLQkJCQkJ
LyogdGhlc2UgY291bnRzIGNvdWxkIGJlIGxlZnQgYXMgMCBpZg0KPiA+IC0JCQkJCSAqIHNvbWUg
YmxvY2tzIGRvIG5vdCBjb3VudCBlcnJvcg0KPiBudW1iZXINCj4gPiAtCQkJCQkgKi8NCj4gPiAt
CQkJCQlvYmotPmVycl9kYXRhLnVlX2NvdW50ICs9DQo+IGVycl9kYXRhLnVlX2NvdW50Ow0KPiA+
IC0JCQkJCW9iai0+ZXJyX2RhdGEuY2VfY291bnQgKz0NCj4gZXJyX2RhdGEuY2VfY291bnQ7DQo+
ID4gLQkJCQl9DQo+ID4gLQkJCX0NCj4gPiAtCQl9DQo+ID4gKwkJcmFzX2ludGVycnVwdF9wb2lz
b25fY3JlYXRpb25faGFuZGxlcihvYmosICZlbnRyeSk7DQo+ID4gICAJfQ0KPiA+ICAgfQ0KPiA+
DQo+ID4NCg==
