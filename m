Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EDFC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 08:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1FE60724
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 08:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2F1FE60724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B024B6E323;
	Thu, 12 Aug 2021 08:49:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5118A6E323
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 08:49:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoTgz3FnQPgkHy+JWdwdfYIgABFCmp7Z2HnQDHorZk9koT36QPGB/U8hYBqeYpeBQz79aQ01rz5U5z7UYTjsqkkii4R5bDhEPCRP5RllBQfhWK5Fa4pgi3MxREtmhQKEXCWkuZt9w1QkXH0QpcTKxtvU4JwOkMJ5iOEXezAEcTFx64XaEPLsC+l4k593sGQBlBaP27edOorQxj+h1UauccpYowz57Oe2iow2iN3GWGgXekCRSaJdhisiquVZiVQ4n6UkOFEnbOk8Iufp/dYyOyA42oV/RBz+X6F8XHgY3IKBJ+aWUvTQ4lDp9RC1nHHmUVhJSRxJeo1b4OZMnCl95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ROL5ppKGgzSqNHyrSekmcz8fPWry7IlDH1RsuSl5Mg=;
 b=bG3JRsznVcoveLz4rCLGKYAEpJdD8rpGmtip3MAnRhYhjhIWpMFM7qbbpR1xea6oflPPjaOoKtTqvC2BwS255MtkoFAyKuUrc88N+Ii2dTC+pYw6LP/Z//8nN/mFRhJ1Dz7npFgmQX1/dnvG6EyyNiRmy1Yw+kALasbqfVKONKIyG0aBeYKb9Ae1cbTosHBTrHK8NlP5wtXfhIfTkgg/Imuvy65jd4K90s+2yAupxaECb7m/3ixFVD5og5jy2BV2BhdxZBRaAjWMndK/KpP71tcBj5KHjLB+VkTrh8YIz6bR0zDdXxNr1FHW4mMZpTcWPqe8eKc963XG9tGBYv7aug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ROL5ppKGgzSqNHyrSekmcz8fPWry7IlDH1RsuSl5Mg=;
 b=Imcmhbr8OBleMQ7nPy47fuYZlqcJWZTbwQdwd6LbS5rZWUUu+VD3ewpTHAmN7ST1W4S2PpwVOSDFzBQmKo6i6/W/0jPF4wWfEx87vYK653a7Y9wqc8ApMsyazxJ4oxEf1dE5mGCF1XMO+k1faVmKnglKRtgNxqBrBO+7pQS9JaQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0026.namprd12.prod.outlook.com (2603:10b6:4:52::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.13; Thu, 12 Aug 2021 08:49:44 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 08:49:44 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "nils.wallmenius@gmail.com" <nils.wallmenius@gmail.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>
Subject: RE: [PATCH V2 2/7] drm/amd/pm: record the RPM and PWM based fan speed
 settings
Thread-Topic: [PATCH V2 2/7] drm/amd/pm: record the RPM and PWM based fan
 speed settings
Thread-Index: AQHXjy7A9dMvhryQnkCSvw1ma4llt6tvYaoAgAALkUCAABJ2AIAADzDg
Date: Thu, 12 Aug 2021 08:49:44 +0000
Message-ID: <DM6PR12MB2619A7E4EDC9872AEB8D50D7E4F99@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210812040110.1293682-1-evan.quan@amd.com>
 <20210812040110.1293682-2-evan.quan@amd.com>
 <f63b688e-81bd-a6a7-4a27-f1d3140559bc@amd.com>
 <DM6PR12MB26190C2DBBCBDE6AF4835F7FE4F99@DM6PR12MB2619.namprd12.prod.outlook.com>
 <3285485e-2beb-4147-fa68-e0fc6636e158@amd.com>
In-Reply-To: <3285485e-2beb-4147-fa68-e0fc6636e158@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-12T08:49:41Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=501c5714-8b06-41ec-ab28-542516680223;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9eb751c0-58e1-4907-1afa-08d95d6e21db
x-ms-traffictypediagnostic: DM5PR1201MB0026:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0026E09FD9F7C2AF7EE5480DE4F99@DM5PR1201MB0026.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qRJYrZGNpNPStuNcU1k+YimocA/v2kVNmc0MrTj30hKxfkhHWQhToeVTnNQstwHXMfU9sZCkNnb2wyKd5feqYdq6H16dWyUSlGgNNtuhd1zqL2NPoe1L1HWZl42PvCdf5CRebGMRVWcDGRqIqUHMlNrXXDeOvcXogkiyn3enfEMqPWWEQFJgGIVemLH1mnN2VyXs1rk0oEwP0VlPGynr0IvXPoA9TvVUKE9lgYhrHpJzXrPhlX0l7uePCL5yEPQ+xN/TQ7Qb8dw+yNqvh4JS9j1dKHUhQqe+W/oMg5xRH2wZz+vAVNb/ZiSSM5cBlmycTEpPDb/JVYaNhJ1vcpN3Bvo8cNbx0LVgO/M1IBkRoBfypXZF6ZquDHL3YR5H6Vqyv9bzfeliJ1haqKRquYG0iP8po/2ZCa9Tw3aSD9YFCz8xyQC/X+GoAZIey0lphiLJSQI+tq4y0dTSUbVo8CyROP+WbAF4n3s9p61NOO3ezzqig1qIWIxR38LR9YdDhvgcIDNIVMEfqf7JZnPrVohDh7o6N2whfea/LQhlxCVaU3f5NL1Th6g5YnUAPtN1NRKkSHK4vjlb+tCSXGkXokL8jMrcQGKi+Di3m0AT+fdwTIiAjiREG61+qzdtwpbJrrVVc8+600MFCjrfn6rJwDuI+jJoX5rjMzbIEbN6uJcelT/tpJ91Qiv1tBXqXhQxEgfoeJuPRtkuszU/S6PUfS2MTQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(38100700002)(55016002)(66946007)(122000001)(66556008)(64756008)(66446008)(66476007)(6506007)(186003)(4326008)(53546011)(38070700005)(316002)(76116006)(54906003)(8676002)(2906002)(110136005)(71200400001)(478600001)(7696005)(9686003)(5660300002)(83380400001)(52536014)(8936002)(86362001)(33656002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWt5UzFtMm04MmRZbGhMZmNJYWZ4YllFeGZ6TWFVVTNKSm5WVXlEU0RMTlhv?=
 =?utf-8?B?QklNWmMvSlV0UGJNVkpJV2RNcHExV3VKSTh5U2lUQUlvdVBiL25wOWI0c3F0?=
 =?utf-8?B?Qk9JYVROeXhJbTBuWFNJc0hJYWJKb1F2S2ViRUJEeVJ5NDEvbWo5SVVQM0Rw?=
 =?utf-8?B?NUhkeHVYb1NjakN3UEN6RW1zNnVwUTQxSEp5dHNmTU9QY2FGbHpIa3U2cHNr?=
 =?utf-8?B?dTdBTnZkc01LOHRxVzQzTnNRdnd5c0o4TnpvTlJVcitxbGVMdGdCVFBuemRD?=
 =?utf-8?B?eTloSVlOaE1qOEJ1N0ZVS05Qb1JjYWlJaUYwWFdkQys5R1FLYllyazhFVFFY?=
 =?utf-8?B?YnZCMUlEdnVKd0tzeEJsYWVpN2NBeDdDRjZGRGp5MWtmbUFGRldEcEJLSEFp?=
 =?utf-8?B?UjJwUHpGUjcrV1ZxS3o4NUk5aWhpN3RtM3JseE1URjZPMUEzNEREbGwzeFF1?=
 =?utf-8?B?alBZS2J5dE1IWXB1ZENTa2JObWhhTFVLeGE2SU4vdUdzWGxsd2hzb0tqaGwy?=
 =?utf-8?B?TzhkY1pxZDdRSktSb3VRaUYxNU1ZR1VxeU43a3AweFZoNlVLQlhySE94SEJE?=
 =?utf-8?B?NStOVXN5dW1qSFQ4T1ZoMEhaa0NOb2Fidis4YkJoblNZMWdQcU9PUG5Iem1w?=
 =?utf-8?B?cWk5b2dIV1EwTE1wb1lnNmt4SzRsN2VPb1FWaTVrZHM2WFh2bHZ3OWUvd0hx?=
 =?utf-8?B?S014Ry94YlQ1eXJBbkd4QWVpVkxmMmxLZDE5eTYrcXNzUFNwNXc1THVoRXhk?=
 =?utf-8?B?SmJkeFNTcnVPeEFqdEZYalJxWmxDbFAwdzQ4SG0vbE16VzkrbWZPbkR0VGRI?=
 =?utf-8?B?UWozQURQL1lkUXlGUmlTYnRBczIwQXN1MTkrNVV0YXFMalk1YkVCVGVUOE5H?=
 =?utf-8?B?cTNsdDFXTmloOE9DcUNmZloxRWUwNCtRaDFYV0xEbmFWS1JTZnZNeU16WXdO?=
 =?utf-8?B?NE04VEZON241VXVOR08wckd0Y2dGUTlkWUJjSVE1dHlWdVRLc1dVSng1Z1ph?=
 =?utf-8?B?MjNKdldwR0FDSUhIek1RTEhJamtSaWpIUUo1K01CaFAwMVlzdGkxR09rT2J2?=
 =?utf-8?B?Um5VdUJXOUlZUGRPZVdVWUlsa0p0aCttS1NVVTd5d2p4ckZwTzJURW1rZk8v?=
 =?utf-8?B?d1lzaGMrYnBidlB4U2x2S2wyOXU4RGFmWEUxLzQ4TG5aVGwyWFNPTWdrekd4?=
 =?utf-8?B?alZXRkNEb1FCRXhuaXdRK0NCSEFsV0RSeElFYlhmNG1XcGRKQU0wQXZjMDNF?=
 =?utf-8?B?YmFTd3ZxbWZaaUp1bXhFMWpxNkMzeEF4NDhwYU9tMHhCY00ybUkrbFAxR2V6?=
 =?utf-8?B?Z2NZcExsNS8yaFltWWpZZUlYQW5BWjJOUW5QQTF1L0JlWlMyN0FiTlNSYldH?=
 =?utf-8?B?cE1IVzd5S3BBc05IbmY2R2VIemkxV2xza0IrTTY5UWFRWUFRRUFxWnY4dkR5?=
 =?utf-8?B?WnBkOHlwejVXdm5PdzV5ZUNoaEVCNmJFQTM0Si9kNmlwbE4xdFJDSEFOeEF3?=
 =?utf-8?B?UGZ6MGJ5YjA0a0JySm9tUHdPVFZiWEwxUVR3NDA1cG9Ockx2WWk5MzVqNGg3?=
 =?utf-8?B?R0J4VnBXWHJIRmMxK242bFAzNm1QZFBydVFWbjdHYXBIa2tKU2tGdXJuV0pp?=
 =?utf-8?B?UGxGRC9QaVF4djdWMkhSUzBGMENnYzZPYUM3a00ya3MwNEtDYUtnVzlRTXBG?=
 =?utf-8?B?a3dvVVFFbDE3NmYxakVCUEk3cERnMnVBcG1BbTQyalErTXp6S1hwenVCVXJj?=
 =?utf-8?Q?IeixeCadxc810KEMgDM0WXTKQkZrYFlzNmwpfqX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb751c0-58e1-4907-1afa-08d95d6e21db
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 08:49:44.3659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SK7OIFRn2Y7D+LIyJiYaCKNdeJJuUNfMjqhEWlcVIjnKtX9yUCfTP6CLBPh0O1L3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0026
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
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIEF1Z3VzdCAxMiwgMjAyMSAzOjUzIFBNDQo+IFRvOiBRdWFuLCBFdmFuIDxFdmFuLlF1
YW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBuaWxzLndh
bGxtZW5pdXNAZ21haWwuY29tOyBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMi83XSBkcm0vYW1kL3BtOiByZWNvcmQgdGhlIFJQTSBh
bmQgUFdNIGJhc2VkDQo+IGZhbiBzcGVlZCBzZXR0aW5ncw0KPiANCj4gDQo+IA0KPiBPbiA4LzEy
LzIwMjEgMTI6MjEgUE0sIFF1YW4sIEV2YW4gd3JvdGU6DQo+ID4gW0FNRCBPZmZpY2lhbCBVc2Ug
T25seV0NCj4gPg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
Pj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gPj4gU2VudDogVGh1
cnNkYXksIEF1Z3VzdCAxMiwgMjAyMSAyOjA1IFBNDQo+ID4+IFRvOiBRdWFuLCBFdmFuIDxFdmFu
LlF1YW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4+IENjOiBu
aWxzLndhbGxtZW5pdXNAZ21haWwuY29tOyBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5j
b20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMi83XSBkcm0vYW1kL3BtOiByZWNvcmQg
dGhlIFJQTSBhbmQgUFdNDQo+IGJhc2VkDQo+ID4+IGZhbiBzcGVlZCBzZXR0aW5ncw0KPiA+Pg0K
PiA+Pg0KPiA+Pg0KPiA+PiBPbiA4LzEyLzIwMjEgOTozMSBBTSwgRXZhbiBRdWFuIHdyb3RlOg0K
PiA+Pj4gQXMgdGhlIHJlbGF0aW9uc2hpcCAiUFdNID0gUlBNIC8gc211LT5mYW5fbWF4X3JwbSIg
YmV0d2VlbiBmYW4NCj4gPj4gc3BlZWQNCj4gPj4+IFBXTSBhbmQgUlBNIGlzIG5vdCB0cnVlIGZv
ciBTTVUxMSBBU0lDcy4gU28sIGJvdGggdGhlIFJQTSBhbmQgUFdNDQo+ID4+PiBzZXR0aW5ncyBu
ZWVkIHRvIGJlIHNhdmVkLg0KPiA+Pj4NCj4gPj4+IENoYW5nZS1JZDogSTMxOGMxMzRkNDQyMjcz
ZDUxOGI4MDUzMzljZGYzODNlMTUxYjkzNWQNCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEV2YW4gUXVh
biA8ZXZhbi5xdWFuQGFtZC5jb20+DQo+ID4+PiAtLQ0KPiA+Pj4gdjEtPnYyOg0KPiA+Pj4gICAg
IC0gY29kaW5nIHN0eWxlIGFuZCBsb2dnaW5nIHByaW50cyBvcHRpbWl6YXRpb24gKEd1Y2h1bikN
Cj4gPj4+ICAgICAtIHJldXNlIGV4aXN0aW5nIGZsYWdzIChMaWpvKQ0KPiA+Pj4gLS0tDQo+ID4+
PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfc211LmggICB8ICAzICsrKw0K
PiA+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMgfCAyMg0K
PiA+PiArKysrKysrKysrKysrKysrLS0tLS0tDQo+ID4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDE5
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL2FtZGdwdV9zbXUuaA0KPiA+Pj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfc211LmgNCj4gPj4+IGluZGV4IDE4MzY1NGY4YjU2
NC4uMjk5MzRhNWFmNDRlIDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9pbmMvYW1kZ3B1X3NtdS5oDQo+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2lu
Yy9hbWRncHVfc211LmgNCj4gPj4+IEBAIC0zNCw2ICszNCw4IEBADQo+ID4+PiAgICAjZGVmaW5l
IFNNVV9GV19OQU1FX0xFTgkJCTB4MjQNCj4gPj4+DQo+ID4+PiAgICAjZGVmaW5lIFNNVV9EUE1f
VVNFUl9QUk9GSUxFX1JFU1RPUkUgKDEgPDwgMCkNCj4gPj4+ICsjZGVmaW5lIFNNVV9DVVNUT01f
RkFOX1NQRUVEX1JQTSAgICAgKDEgPDwgMSkNCj4gPj4+ICsjZGVmaW5lIFNNVV9DVVNUT01fRkFO
X1NQRUVEX1BXTSAgICAgKDEgPDwgMikNCj4gPj4+DQo+ID4+PiAgICAvLyBQb3dlciBUaHJvdHRs
ZXJzDQo+ID4+PiAgICAjZGVmaW5lIFNNVV9USFJPVFRMRVJfUFBUMF9CSVQJCQkwDQo+ID4+PiBA
QCAtMjMwLDYgKzIzMiw3IEBAIHN0cnVjdCBzbXVfdXNlcl9kcG1fcHJvZmlsZSB7DQo+ID4+PiAg
ICAJdWludDMyX3QgZmFuX21vZGU7DQo+ID4+PiAgICAJdWludDMyX3QgcG93ZXJfbGltaXQ7DQo+
ID4+PiAgICAJdWludDMyX3QgZmFuX3NwZWVkX3BlcmNlbnQ7DQo+ID4+PiArCXVpbnQzMl90IGZh
bl9zcGVlZF9ycG07DQo+ID4+PiAgICAJdWludDMyX3QgZmxhZ3M7DQo+ID4+PiAgICAJdWludDMy
X3QgdXNlcl9vZDsNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9zd3NtdS9hbWRncHVfc211LmMNCj4gPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9z
d3NtdS9hbWRncHVfc211LmMNCj4gPj4+IGluZGV4IGUzM2U2NzMxMDAzMC4uMTMxYWQwZGZlZmJl
IDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVf
c211LmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3Nt
dS5jDQo+ID4+PiBAQCAtNDEzLDcgKzQxMywxMyBAQCBzdGF0aWMgdm9pZA0KPiBzbXVfcmVzdG9y
ZV9kcG1fdXNlcl9wcm9maWxlKHN0cnVjdA0KPiA+PiBzbXVfY29udGV4dCAqc211KQ0KPiA+Pj4g
ICAgCQlpZiAoIXJldCAmJiBzbXUtPnVzZXJfZHBtX3Byb2ZpbGUuZmFuX3NwZWVkX3BlcmNlbnQp
IHsNCj4gPj4+ICAgIAkJCXJldCA9IHNtdV9zZXRfZmFuX3NwZWVkX3BlcmNlbnQoc211LCBzbXUt
DQo+ID4+PiB1c2VyX2RwbV9wcm9maWxlLmZhbl9zcGVlZF9wZXJjZW50KTsNCj4gPj4+ICAgIAkJ
CWlmIChyZXQpDQo+ID4+PiAtCQkJCWRldl9lcnIoc211LT5hZGV2LT5kZXYsICJGYWlsZWQgdG8g
c2V0DQo+ID4+IG1hbnVhbCBmYW4gc3BlZWRcbiIpOw0KPiA+Pj4gKwkJCQlkZXZfZXJyKHNtdS0+
YWRldi0+ZGV2LCAiRmFpbGVkIHRvIHNldA0KPiA+PiBtYW51YWwgZmFuIHNwZWVkIGluIHBlcmNl
bnRcbiIpOw0KPiA+Pj4gKwkJfQ0KPiA+Pj4gKw0KPiA+Pj4gKwkJaWYgKCFyZXQgJiYgc211LT51
c2VyX2RwbV9wcm9maWxlLmZhbl9zcGVlZF9ycG0pIHsNCj4gPj4+ICsJCQlyZXQgPSBzbXVfc2V0
X2Zhbl9zcGVlZF9ycG0oc211LCBzbXUtDQo+ID4+PiB1c2VyX2RwbV9wcm9maWxlLmZhbl9zcGVl
ZF9ycG0pOw0KPiA+Pj4gKwkJCWlmIChyZXQpDQo+ID4+PiArCQkJCWRldl9lcnIoc211LT5hZGV2
LT5kZXYsICJGYWlsZWQgdG8gc2V0DQo+ID4+IG1hbnVhbCBmYW4gc3BlZWQgaW4NCj4gPj4+ICty
cG1cbiIpOw0KPiA+Pj4gICAgCQl9DQo+ID4+PiAgICAJfQ0KPiA+Pj4NCj4gPj4+IEBAIC0yMTc5
LDcgKzIxODUsNiBAQCBzdGF0aWMgaW50IHNtdV9zZXRfZ2Z4X2NncGcoc3RydWN0DQo+IHNtdV9j
b250ZXh0DQo+ID4+ICpzbXUsIGJvb2wgZW5hYmxlZCkNCj4gPj4+ICAgIHN0YXRpYyBpbnQgc211
X3NldF9mYW5fc3BlZWRfcnBtKHZvaWQgKmhhbmRsZSwgdWludDMyX3Qgc3BlZWQpDQo+ID4+PiAg
ICB7DQo+ID4+PiAgICAJc3RydWN0IHNtdV9jb250ZXh0ICpzbXUgPSBoYW5kbGU7DQo+ID4+PiAt
CXUzMiBwZXJjZW50Ow0KPiA+Pj4gICAgCWludCByZXQgPSAwOw0KPiA+Pj4NCj4gPj4+ICAgIAlp
ZiAoIXNtdS0+cG1fZW5hYmxlZCB8fCAhc211LT5hZGV2LT5wbS5kcG1fZW5hYmxlZCkgQEAgLQ0K
PiA+PiAyMTkwLDgNCj4gPj4+ICsyMTk1LDggQEAgc3RhdGljIGludCBzbXVfc2V0X2Zhbl9zcGVl
ZF9ycG0odm9pZCAqaGFuZGxlLCB1aW50MzJfdA0KPiA+PiBzcGVlZCkNCj4gPj4+ICAgIAlpZiAo
c211LT5wcHRfZnVuY3MtPnNldF9mYW5fc3BlZWRfcnBtKSB7DQo+ID4+PiAgICAJCXJldCA9IHNt
dS0+cHB0X2Z1bmNzLT5zZXRfZmFuX3NwZWVkX3JwbShzbXUsIHNwZWVkKTsNCj4gPj4+ICAgIAkJ
aWYgKCFyZXQgJiYgc211LT51c2VyX2RwbV9wcm9maWxlLmZsYWdzICYNCj4gPj4gU01VX0RQTV9V
U0VSX1BST0ZJTEVfUkVTVE9SRSkgew0KPiA+Pj4gLQkJCXBlcmNlbnQgPSBzcGVlZCAqIDEwMCAv
IHNtdS0+ZmFuX21heF9ycG07DQo+ID4+PiAtCQkJc211LT51c2VyX2RwbV9wcm9maWxlLmZhbl9z
cGVlZF9wZXJjZW50ID0NCj4gPj4gcGVyY2VudDsNCj4gPj4+ICsJCQlzbXUtPnVzZXJfZHBtX3By
b2ZpbGUuZmxhZ3MgfD0NCj4gPj4gU01VX0NVU1RPTV9GQU5fU1BFRURfUlBNOw0KPiA+Pj4gKwkJ
CXNtdS0+dXNlcl9kcG1fcHJvZmlsZS5mYW5fc3BlZWRfcnBtID0gc3BlZWQ7DQo+ID4+DQo+ID4+
IFNvcnJ5LCBtaXNzZWQgdGhpcyB3aGVuIHlvdSBwb3N0ZWQgdjEuIEVpdGhlciBSUE0gb3IgUFdN
IG1vZGUgaXMNCj4gPj4gYWxsb3dlZCBhdCBhIHRpbWUsIGlzIHRoYXQgcmlnaHQ/IElmIHNvLCBz
aGFsbCB3ZSBtYWtlIHRoZSBwd20gdG8gMA0KPiA+PiBhbmQgcmVzZXQgUFdNIGZsYWcgd2hlbiBS
UE0gaXMgc2V0IGFuZCB2aWNlIHZlcnNhPyBUaGlzIGhlbHBzIGR1cmluZw0KPiA+PiByZXN0b3Jl
IHdoZXJlIG9uZSBpcyBub3Qgb3ZlcndyaXR0ZW4gd2l0aCB0aGUgb3RoZXIuDQo+ID4gW1F1YW4s
IEV2YW5dIFNvdW5kcyByZWFzb25hYmxlIHRvIG1lLiBCdXQgSSBzdXBwb3NlIHdlIGFsc28gbmVl
ZCB0bw0KPiBwcm9tcHQgc29tZSB3YXJuaW5ncyB3aGVuIHVzZXIgdHJ5aW5nIHRvIHNldCB0aGVz
ZSB0d28gbW9kZXMgYXQgdGhlIHNhbWUNCj4gdGltZS4NCj4gPiBJbnN0ZWFkIG9mIHBlcmZvcm1p
bmcgdGhlc2Ugc2lsZW50bHkuIFJpZ2h0Pw0KPiANCj4gTm90IHN1cmUgb24gdGhlIHdhcm5pbmdz
IHBhcnQuIEZvciBleDogdXNlciBtYXkgc2V0IHRoZSBtYW51YWwgbW9kZSwNCj4gY2hvb3NlIGEg
cHdtIGJhc2VkIGZhbiBzcGVlZCBhbmQgbWF5IGxhdGVyIHN3aXRjaCB0byBhIHByZWNpc2UgcnBt
IGJhc2VkDQo+IHNwZWVkLiBTaW5jZSBpdCdzIGRyaXZlbiBieSB1c2VyLCB3ZSBtYXkgbm90IG5l
ZWQgdG8gd2Fybi4NCltRdWFuLCBFdmFuXSBIbW0uIEhvdyBhYm91dCB0aGUgZm9sbG93aW5ncz8g
QSBub3RpY2UgaW4gdGhlIGRlc2NyaXB0aW9uIHBhcnQgZm9yIHJlbGF0ZWQgQVBJcz8NCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL2FtZGdwdV9wbS5jDQppbmRleCAwNGM3ZDgyZjhiODkuLjExMmVlNWY1ZDg1
NSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCkBAIC0zMTc0LDYgKzMxNzQsOSBA
QCBzdGF0aWMgc3NpemVfdCBhbWRncHVfaHdtb25fc2hvd19tY2xrX2xhYmVsKHN0cnVjdCBkZXZp
Y2UgKmRldiwNCiAgKg0KICAqIC0gZmFuWzEtXCpdX2VuYWJsZTogRW5hYmxlIG9yIGRpc2FibGUg
dGhlIHNlbnNvcnMuMTogRW5hYmxlIDA6IERpc2FibGUNCiAgKg0KKyAqIE5PVEU6IERPIE5PVCBz
ZXQgdGhlIGZhbiBzcGVlZCB2aWEgInB3bTEiIGFuZCAiZmFuWzEtXCpdX3RhcmdldCIgaW50ZXJm
YWNlcyBhdCB0aGUgc2FtZSB0aW1lLg0KKyAqICAgICAgIFRoYXQgd2lsbCBnZXQgdGhlIGZvcm1l
ciBvbmUgb3ZlcnJpZGRlbi4NCisgKg0KICAqIGh3bW9uIGludGVyZmFjZXMgZm9yIEdQVSBjbG9j
a3M6DQogICoNCiAgKiAtIGZyZXExX2lucHV0OiB0aGUgZ2Z4L2NvbXB1dGUgY2xvY2sgaW4gaGVy
dHoNCj4gDQo+IFRoYW5rcywNCj4gTGlqbw0KPiANCj4gPj4NCj4gPj4gVGhhbmtzLA0KPiA+PiBM
aWpvDQo+ID4+DQo+ID4+PiAgICAJCX0NCj4gPj4+ICAgIAl9DQo+ID4+Pg0KPiA+Pj4gQEAgLTI1
NTIsOCArMjU1NywxMSBAQCBzdGF0aWMgaW50IHNtdV9zZXRfZmFuX2NvbnRyb2xfbW9kZShzdHJ1
Y3QNCj4gPj4+IHNtdV9jb250ZXh0ICpzbXUsIGludCB2YWx1ZSkNCj4gPj4+DQo+ID4+PiAgICAJ
LyogcmVzZXQgdXNlciBkcG0gZmFuIHNwZWVkICovDQo+ID4+PiAgICAJaWYgKCFyZXQgJiYgdmFs
dWUgIT0gQU1EX0ZBTl9DVFJMX01BTlVBTCAmJg0KPiA+Pj4gLQkJCSEoc211LT51c2VyX2RwbV9w
cm9maWxlLmZsYWdzICYNCj4gPj4gU01VX0RQTV9VU0VSX1BST0ZJTEVfUkVTVE9SRSkpDQo+ID4+
PiArCQkJIShzbXUtPnVzZXJfZHBtX3Byb2ZpbGUuZmxhZ3MgJg0KPiA+PiBTTVVfRFBNX1VTRVJf
UFJPRklMRV9SRVNUT1JFKSkgew0KPiA+Pj4gICAgCQlzbXUtPnVzZXJfZHBtX3Byb2ZpbGUuZmFu
X3NwZWVkX3BlcmNlbnQgPSAwOw0KPiA+Pj4gKwkJc211LT51c2VyX2RwbV9wcm9maWxlLmZhbl9z
cGVlZF9ycG0gPSAwOw0KPiA+Pj4gKwkJc211LT51c2VyX2RwbV9wcm9maWxlLmZsYWdzICY9DQo+
ID4+IH4oU01VX0NVU1RPTV9GQU5fU1BFRURfUlBNIHwNCj4gU01VX0NVU1RPTV9GQU5fU1BFRURf
UFdNKTsNCj4gPj4+ICsJfQ0KPiA+Pj4NCj4gPj4+ICAgIAlyZXR1cm4gcmV0Ow0KPiA+Pj4gICAg
fQ0KPiA+Pj4gQEAgLTI2MDQsOCArMjYxMiwxMCBAQCBzdGF0aWMgaW50IHNtdV9zZXRfZmFuX3Nw
ZWVkX3BlcmNlbnQodm9pZA0KPiA+PiAqaGFuZGxlLCB1MzIgc3BlZWQpDQo+ID4+PiAgICAJCWlm
IChzcGVlZCA+IDEwMCkNCj4gPj4+ICAgIAkJCXNwZWVkID0gMTAwOw0KPiA+Pj4gICAgCQlyZXQg
PSBzbXUtPnBwdF9mdW5jcy0+c2V0X2Zhbl9zcGVlZF9wZXJjZW50KHNtdSwNCj4gPj4gc3BlZWQp
Ow0KPiA+Pj4gLQkJaWYgKCFyZXQgJiYgIShzbXUtPnVzZXJfZHBtX3Byb2ZpbGUuZmxhZ3MgJg0K
PiA+PiBTTVVfRFBNX1VTRVJfUFJPRklMRV9SRVNUT1JFKSkNCj4gPj4+ICsJCWlmICghcmV0ICYm
ICEoc211LT51c2VyX2RwbV9wcm9maWxlLmZsYWdzICYNCj4gPj4gU01VX0RQTV9VU0VSX1BST0ZJ
TEVfUkVTVE9SRSkpIHsNCj4gPj4+ICsJCQlzbXUtPnVzZXJfZHBtX3Byb2ZpbGUuZmxhZ3MgfD0N
Cj4gPj4gU01VX0NVU1RPTV9GQU5fU1BFRURfUFdNOw0KPiA+Pj4gICAgCQkJc211LT51c2VyX2Rw
bV9wcm9maWxlLmZhbl9zcGVlZF9wZXJjZW50ID0NCj4gPj4gc3BlZWQ7DQo+ID4+PiArCQl9DQo+
ID4+PiAgICAJfQ0KPiA+Pj4NCj4gPj4+ICAgIAltdXRleF91bmxvY2soJnNtdS0+bXV0ZXgpOw0K
PiA+Pj4NCg==
