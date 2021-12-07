Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6630BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 07:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCE818BC8D;
	Tue,  7 Dec 2021 07:40:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0BCC8BC8B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 07:40:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAtpdI/aWO67/uEOkmub53JaAtTTl76LGyzyQBeQX/sbwrcD7nrIa2Piy+EYa6GOcLtLW+DxeZ61GROxtgNeZlkLknsEXb9hWlj+G8QRYssMIRZEZiX8gETXV8ita81O0z6JDNzsGZ9vDL3APHhMBn82VrsfIBxJYct88RcXDAocVqFpPC3TYXxCarE/FPO1LT84q4X6DKvHCOsEp9LfNq3KI+vAX92hPWkfVl5QP0AqGM3E6vDRXOpRrYxXOHbGbbzRPztpFogpENWXBgSh3SBo8Bm7ox7Wph1toAVbLNRmoo308HR12IVL4fPr1YI1S3Rguri+jItS0JZX9QhtJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayWGs3T0Ik+S5zgT5yViyW/x42AdCF0PRtxPSzfD2fA=;
 b=AZBWAM+qv56sMNRLSVuRHT35EFhWrbjsVWyfKs2xqe6eDYPcMt6XPpYgIHUHAs88Z7A9pptdYLxotlKG9f/w39nFgL1GoYnepz0xci32my+1Ismw+yv7FEJrsG87x0rp1YsuppFz86hIW3luxAQ29KwUDpivn4YgdhawGQGiMGyU3WP3wc+Op47R5PeuaxSYhEmAWpPFFSj4wzeDttXWJNq8rhCy3pMlN0HcQVHzuBYljsL7ZGEXDzCscZkFYDONOE1uJu/PO7i6GD8ONfwPXK5n5xDOxrQ98QWLh3xMCupbajxU4u7A24cjofmb/GQdKrqXL5vd2UZQz10Q0pNcYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayWGs3T0Ik+S5zgT5yViyW/x42AdCF0PRtxPSzfD2fA=;
 b=dXq1V8b7niFK8RMAzPgPzw3zvW4Be8NWod97NA2hjQIsav2NZN4tgbDIezeYjz2QREBoMtE5eDKUdu5l7ghvO5kDTc2ESIC3YsecArheBNOaialnjjNs9UwYJLT54dbnTI/9p2i1Vi1NG30wobZe3rZXf92pJSlJV8Uew3pQIUg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4988.namprd12.prod.outlook.com (2603:10b6:5:16a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Tue, 7 Dec 2021 07:40:25 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4755.021; Tue, 7 Dec 2021
 07:40:24 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: don't skip runtime pm get on A+A config
Thread-Topic: [PATCH] drm/amdgpu: don't skip runtime pm get on A+A config
Thread-Index: AQHX6ow26UqxvGY2l02X+RiFlqjqt6wmRj1ggABVvACAAAmXwA==
Date: Tue, 7 Dec 2021 07:40:24 +0000
Message-ID: <DM6PR12MB261917D411F14C76089BA492E46E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211206084551.92502-1-christian.koenig@amd.com>
 <DM6PR12MB26194050848510738D3DF81CE46E9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <462b2fbf-2d14-cc49-1b48-56b80b68b3ba@gmail.com>
In-Reply-To: <462b2fbf-2d14-cc49-1b48-56b80b68b3ba@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-07T07:40:21Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=671424b5-447e-42f2-993d-eada726daadb;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d38b8351-d416-4160-2d1c-08d9b954d4e3
x-ms-traffictypediagnostic: DM6PR12MB4988:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4988907C0F587E5CAA2864AEE46E9@DM6PR12MB4988.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9aYqSCVXXK+uOYXKHWziUO/MrzNjceBvGiJsLwOEL17AifmYI1Y5cv17/bzTIpKGBUPUGc6iiEzQ2Yab4Im5TdzTvqcOwGCWzanLgnULJj2y2z/0XjHfsh1Cr9CxZE9EuMPbFVga/pdlnyuT6U/Nqzowd5DH3aIMPLb1PiB7/SqCQcKcPzLkyzGgJPTHqUbGsNwsZGL7JKFSJO5MS72h+Gcpp+vzkXAypzd5+fDkO15Vge4dF82Md2+7i6yrSdvPd5R3uajfvwSjd/P1XlhJM86LfJYEmsfQEKescuj46FgfFqN8BnbbD0875EWm0YoT2mKkBay/oi6fhEHxNFBQ+kI7OVp0ygxJMcHFd2zzuUYjuzca1CJ/kHjiA+eo1S5tpsBXjBqAojYEo6y6BejobMGUI/9srCRPZ84P4voU+0xZuXNvK8sXhf42hSwslynipj6KExMZI9QcxvTNpHYB2xPWMSSMndPsJ8IHIs9E+AY69l5X/PGhmYJyTjR/ZfX/P6xS7tC55EUhhZdw03wEASsUf3uMpl7urOJfRHumK6wgy+RghHvI66CHGHaq4BKM236+zQZFSQTtdEalSOj/9J3BNYrqgvjpyc+Yg+i+fO+pcwBzP0dDgxtFKXC3pLlq6GC8+7zok7xhTVmlyjKKrjnVJqj1l+aWWlTOTgCRBenJf4TW9kwNw83KjFeRauFdlHEMlL2Yr8HHqTmauj6Kew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(55016003)(2906002)(86362001)(76116006)(26005)(9686003)(8676002)(4326008)(186003)(33656002)(508600001)(8936002)(6636002)(64756008)(66446008)(71200400001)(122000001)(83380400001)(38100700002)(110136005)(66556008)(316002)(7696005)(52536014)(66476007)(66946007)(5660300002)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDc1SjZQSDZ5VVdyTThzZDB3MHFONTl6TzRGVDNHUDlWYkkybC9GUWNaM0Jm?=
 =?utf-8?B?SU0zbkEybjl2TTh5M2w1Rk91OXJtQ2tJUjJ0dEJQMjBIRkkyV0NHVEI1ci9u?=
 =?utf-8?B?c2o2blowblJPSWJFc0hxMHBBaEtmNHNkcnYzWDhNZ2tyVEJZWUNTcTFjeGtp?=
 =?utf-8?B?UTV5OFJqeEJ5N2VPOHRQLzJWMmxsZ2MyYnNpcVFqMG96ejNXRmg2M2JnSnlx?=
 =?utf-8?B?VjU5MDd1M2NyTkk4RitBUi9QcWdMUnRRVlJiVWdQYk1ydVhDQjMrQlNoaEV6?=
 =?utf-8?B?SnpDZzgzSkdYdEZvWHBnczRhTmZBQklYWWMzOXcxL2xXb3NMZk9TRXd3RnhM?=
 =?utf-8?B?dzU2MUxmajVaUVYyWVZKQm5yMXo5SHoxVFdVZmd0dHFObjFON3RzMGhWN2lK?=
 =?utf-8?B?bkZhdG02czRTS0h6U1JSOGprTzlKNUdrZ1hxTTBTSEFLMGF1TjZreUtDVVZj?=
 =?utf-8?B?QTJ2MW5EbzR6ZFp4b3V4SmRxZkZodytrWjdlSXp1MnhIQU1pOUhDdC9zSmVY?=
 =?utf-8?B?MXlHMXF3QW5ONVF1RndUUUJaek9sS0E1NnhCTmsxaXpwbFUrTnRRMnJScjZX?=
 =?utf-8?B?Q3RWbUtjeXp2TFlyNHJjQ1piSkpySmhlcTg3ZkNiTFloais2alJ1NDdKaU5I?=
 =?utf-8?B?WVRDTUpPTlppNnRabE5Gd3RZQ0o2NGRVSGUxZkV3L1l0RHRBNDBnTlNENi9t?=
 =?utf-8?B?TjVmRHFtRjFoQ3BNM1ZIM0hFTVo4cE01aVJrZXRrZWticTU4WUlrRDZZVDBv?=
 =?utf-8?B?dUYrVkZqWDgwVUx5Y0JyU2pXL0pBV2UwZ0QwUWx6bDVBS0FyRVd0c3VSaHRN?=
 =?utf-8?B?QW5QMGJCcW14a0xPRDFJYlEvS3dxVlQ2c2dzQWV3NUhOT254eHBjYUR2MjJa?=
 =?utf-8?B?QXlPYmFsYUxNYjQxOUdockpjVnpRRlJKNWwyMzEra3RNSmlNdHVVNEhHTWZZ?=
 =?utf-8?B?bXE1aUZPVHR2emprQzJxTU1pVVN4QjF5NEx3NkdrQ0w0L0NteTh4T2VpcWF2?=
 =?utf-8?B?a2JOQ3l3TmVKN0V5ZHF1aDFWakJSdXR3RnJhYkNQL2VNajkwVzI5NWFLRHVz?=
 =?utf-8?B?Z2FlMUx5SkxqeWVBMVhKQVFsQk1BNFlMUkY5bFMxN1NaMGJ2TXZLaitpc1Jj?=
 =?utf-8?B?RFU3aldaUVlGNit4cHdvNDh3Rlg4dkljZjMwTytSWUxyRTdISUpNTVhZQy9B?=
 =?utf-8?B?MVlNa0E3UzVnYWlmS1dqMEFUcDR2NmVLZlZpb3dmLzdHZ05qRC8rQmxCSDUy?=
 =?utf-8?B?RXRWbVpwS3Q3VnU1VlJ6MFpocTROZUVhYm9jTzlmWS9MZkF3UjcraDlTTjFW?=
 =?utf-8?B?Y1BjUlBFRStOYUhBcEhvWDFDOFF3dzFUREdzUGJJNDJtRXMxeS9UYzRvR01V?=
 =?utf-8?B?N0djc1liWDFoTVlBOXczSDI1b1NjaWlvZGZjOW94ZlVtMDNPWUgyY0dCaWp5?=
 =?utf-8?B?UHZVQlNRWXR3VlczUThoY0ZGVXJxNHZNL2VvZGlzNHhkbWxzSjAxNG9Jd01z?=
 =?utf-8?B?NjJIdWViRWhGUERGTDU1M1JxTlByRUZCblZrK293Rkp6cWNXY2JuQVRSWkMr?=
 =?utf-8?B?Yy82T2pyVnIzWTNNeVRHdERkbEVjNkdnbXFZZmY3NnpFSVFMS3RDcFR2MjQr?=
 =?utf-8?B?OGM3VlpCZHhIWkpKaVlma0E1Qkg1TEVlcllMdnFIQ2VkZGlqNHVhZkI3SDlm?=
 =?utf-8?B?dVo0NmlkeTl2M09hZVh5aHZkektLZlcrcm9Pc212M2x0MFN2aHBBTkNqS0hh?=
 =?utf-8?B?dkJxOGtmSDhubjh5am9rSTB2dXV5d3didEVOUWI1Yk1kZlJWdTdDSEZPNTA0?=
 =?utf-8?B?S0RtMVZZcldTcFdxR3pDT1ZtbGlXL0Z2MnBUUEU3aFBjd1RwVHNOVy9FQllJ?=
 =?utf-8?B?Ny8zdFZhV0F3czRiTElkdlRyS1VKYzUxcTd3SkI1T3VSSWEvZDUvWHpHOFQx?=
 =?utf-8?B?SEVhNFlJbzhZcEU2cy9lYm9yTDdLVmxGRmhsU1V1dEwrOGtIVmFnc0FZc25z?=
 =?utf-8?B?cnQ3MU1tWTNLUUdxaVNaaXFjREp3QXJsVGI1QlhqclJaUkVrU3dkZW5wbWhx?=
 =?utf-8?B?NDhiTHB5STZRSllXeHBJT0ZjenNlMlFsZmljb2FqTmg2elJ4dDJDb3UzUmQx?=
 =?utf-8?Q?CWcg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38b8351-d416-4160-2d1c-08d9b954d4e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 07:40:24.8935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ePwAny7y5w5j5BjmKXqZnf+eeeP2ww616l3ESbep3+Vaq1smTpyDgbkZyCayGtX1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4988
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFp
bC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDcsIDIwMjEgMzowMyBQTQ0KPiBUbzog
UXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBkb24ndCBza2lwIHJ1bnRp
bWUgcG0gZ2V0IG9uIEErQSBjb25maWcNCj4gDQo+IFlvdSBhcmUgbG9va2luZyBhdCBvdXRkYXRl
ZCBjb2RlLCB0aGF0IHN0dWZmIGlzIGdvbmUgYnkgbm93Lg0KPiBhbWQtc3RhZ2luZy1kcm0tbmV4
dCBwcm9iYWJseSBuZWVkcyBhIHJlYmFzZS4NClllcCwgSSBjYW4gc2VlIGl0IGluIHRoZSB2YW5p
bGxhIGtlcm5lbC4NClRoZSBwYXRjaCBpcyBhY2tlZC1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5A
YW1kLmNvbT4NCg0KQlINCkV2YW4NCj4gDQo+IEFuZCB0aGlzIGNvZGUgd2FzIHdoYXQgdGhlIGNo
ZWNrIHdhcyBpbml0aWFsbHkgZ29vZCBmb3IuIEp1c3Qgc2tpcHBpbmcgdGhlIFBNDQo+IHN0dWZm
IGFzIHdlbGwgb24gQStBIHdhcyB1bmludGVudGlvbmFsbHkuDQo+IA0KPiBSZWdhcmRzLA0KPiBD
aHJpc3RpYW4uDQo+IA0KPiBBbSAwNy4xMi4yMSB1bSAwMjo1OCBzY2hyaWViIFF1YW4sIEV2YW46
DQo+ID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCj4gPg0KPiA+IEl0IHNlZW1zIG1vcmUgam9i
cyhiZWxvdykgb3RoZXIgdGhhbiBidW1waW5nIHRoZSBydW5wbSBjb3VudGVyIGFyZQ0KPiBwZXJm
b3JtZWQuDQo+ID4gQXJlIHRoZXkgZGVzaXJlZCBhbHNvPw0KPiA+DQo+ID4gCXIgPSBfX2RtYV9y
ZXN2X21ha2VfZXhjbHVzaXZlKGJvLT50Ym8uYmFzZS5yZXN2KTsNCj4gPiAJaWYgKHIpDQo+ID4g
CQlnb3RvIG91dDsNCj4gPg0KPiA+IAliby0+cHJpbWVfc2hhcmVkX2NvdW50Kys7DQo+ID4NCj4g
PiBCUg0KPiA+IEV2YW4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJv
bTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVo
YWxmIE9mDQo+ID4+IENocmlzdGlhbiBLw7ZuaWcNCj4gPj4gU2VudDogTW9uZGF5LCBEZWNlbWJl
ciA2LCAyMDIxIDQ6NDYgUE0NCj4gPj4gVG86IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbT4NCj4gPj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+ID4+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogZG9uJ3Qgc2tpcCBydW50aW1lIHBt
IGdldCBvbiBBK0EgY29uZmlnDQo+ID4+DQo+ID4+IFRoZSBydW50aW1lIFBNIGdldCB3YXMgaW5j
b3JyZWN0bHkgYWRkZWQgYWZ0ZXIgdGhlIGNoZWNrLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+ID4+IC0tLQ0K
PiA+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMgfCAzIC0t
LQ0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYw0KPiA+
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMNCj4gPj4gaW5k
ZXggYWU2YWI5M2M4NjhiLi40ODk2Yzg3NmZmZWMgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMNCj4gPj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYw0KPiA+PiBAQCAtNjEsOSArNjEsNiBA
QCBzdGF0aWMgaW50IGFtZGdwdV9kbWFfYnVmX2F0dGFjaChzdHJ1Y3QgZG1hX2J1Zg0KPiA+PiAq
ZG1hYnVmLA0KPiA+PiAgIAlpZiAocGNpX3AycGRtYV9kaXN0YW5jZV9tYW55KGFkZXYtPnBkZXYs
ICZhdHRhY2gtPmRldiwgMSwgdHJ1ZSkNCj4gPA0KPiA+PiAwKQ0KPiA+PiAgIAkJYXR0YWNoLT5w
ZWVyMnBlZXIgPSBmYWxzZTsNCj4gPj4NCj4gPj4gLQlpZiAoYXR0YWNoLT5kZXYtPmRyaXZlciA9
PSBhZGV2LT5kZXYtPmRyaXZlcikNCj4gPj4gLQkJcmV0dXJuIDA7DQo+ID4+IC0NCj4gPj4gICAJ
ciA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoYWRldl90b19kcm0oYWRldiktPmRldik7DQo+ID4+ICAg
CWlmIChyIDwgMCkNCj4gPj4gICAJCWdvdG8gb3V0Ow0KPiA+PiAtLQ0KPiA+PiAyLjI1LjENCg==
