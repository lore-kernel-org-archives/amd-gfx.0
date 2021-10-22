Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D4EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 03:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEFE461A0C
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 03:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CEFE461A0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24FB86E5B0;
	Fri, 22 Oct 2021 03:45:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9EB86E5A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 03:45:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRtEJliSwyjMfCgzuGZ5maBGEwk2dNcoCBUTS5xZyZWIgMJROOtVRDIzXlc7p5Mvbop/zMKu6AV2QUhqTTJJkOPgIK1EAqrgLAjYxuNQxzZLbuU3xrNSUYodpqadOlcH8qcF0+lhHlKl3mWW+7aI+7X21r/bJecmyyseekoMskTtUZkyZ/2Re7daXB9qns8fVj2NH7nflU3fT0FsH57GTBM7pj4PBW/XIMx7dKyOp0zukLCSN67RvaSOnZSVM9pYtkYSzBWL14HQj/QJnKMIQu+QaarwnMetWQysUEqkrXULCsOs5Hb1o2BbTp6Wcs4qfGnKM4aWqzjNlNa45rrP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0UWOPj+SzDKEPv6cq9k1wfyD4i8RKHioMZHSFWBViY=;
 b=Z5U24mMJtUGaUuwBUjb/OwYwRHlgJRNkpQZ21jQnAFbII2ZKxlBBV1++XvDLavO54EPuShyG2oVZPEYg+WxafUttMCzUUx61jywGzlQHPViNUzE5mClztGB2a2rKNzjh0LTlIh0I9wJyZ/VbdQO43R+E9NwC2C71VbcoDdgccNoTJ+oJLziSkzd43IjMcllJdOo8kbf2K3aMs/193kL7fTIdFAyNPCSpLOUgdfep/fAF/DK43qgWWnw2QaRwh5xvQ5J1NAW6XH0nQGV9QCvGCYdTBn6PW9+2b1PgmWqKcyvcnOWYr/R6sk/S892/+Ayic42lFKipFHkr3QailovRqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0UWOPj+SzDKEPv6cq9k1wfyD4i8RKHioMZHSFWBViY=;
 b=kKjJRUXaGiUEvcxlo3YzRAK5gU/UyHYbQtn1m9ETC8F0ttaIrsXNAtxLyI556nzuPWaXMMNMVmrZ/6htLcMtpZByb3PXReM9zp2aCmXKWcE50Si8q5b74+X4VH+/5ZF9arSkyZKg44w2QZkwm8Gs0Xsb/DuTYbzG9Fpb7sof8sM=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3691.namprd12.prod.outlook.com (2603:10b6:5:1c5::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Fri, 22 Oct 2021 03:45:10 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4608.018; Fri, 22 Oct 2021
 03:45:10 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/smu11.0: add missing IP version check
Thread-Topic: [PATCH] drm/amdgpu/smu11.0: add missing IP version check
Thread-Index: AQHXxP5cGBLewLsCSkqEzYlPJFln7qveXTuAgAAHFjA=
Date: Fri, 22 Oct 2021 03:45:10 +0000
Message-ID: <DM5PR12MB246947E7CF935CACE91B9AD1F1809@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211019153051.306142-1-alexander.deucher@amd.com>
 <CADnq5_Mpd3fnMx+vgNdgqrinB1dJPSE7mRnKitTh_ebcbBEdUg@mail.gmail.com>
In-Reply-To: <CADnq5_Mpd3fnMx+vgNdgqrinB1dJPSE7mRnKitTh_ebcbBEdUg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-22T03:45:07Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=93259510-82f6-493b-bfc4-a5d7da81a630;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1a5b564-d0eb-4da5-8ab1-08d9950e58d4
x-ms-traffictypediagnostic: DM6PR12MB3691:
x-microsoft-antispam-prvs: <DM6PR12MB3691B10D38925E3805D40EB7F1809@DM6PR12MB3691.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gc9jXYgHsuhvTTxKTk7IiHxw0tmFS1wHFy8/1y+uukQX0fjtnzI/sbNrkYd+bE1337pd1qTYySwRCrauVj/Fn9QA5QcMJSiU32m3JjJT291Hid3JH0U/Au4do6lwgmXQEUU8e0OXVUG/uNFR8JovBKAXxJEnGb+hbgQ4T55QMkzJQarK7HA8dl4N/bV+iUy/QH52wPceEfSYCzGBfxVHAiMw2KbMmsUjRsyu6Qn6ZkwZ29Ecnj8s3LTwKE3FcKg9KGSMSm0CMP2HuaMPRxDoVP2jYEiz9gYJVaH8Tw6vgANTkd70aaWHZBkqlp0UCQnwfRTJVNhMjyEZTzCogA5kuKoEGTZWAhm4AKX7HDjc1hvdo/bkJsYau0sjFRZb+XS3i0mnnlVEsZv/uAFno/1l7Djq3Z4QVmRXquU0NBxj9GgdCPmETT2gNJLj8kpuBq6ZbOmUG0HjkAhVZcVa4j9RvudnuiU4Pz6LaroZZnfwvYMjUFoIaTvEF+phIVk/gtxzMC4TlgVQXwV6Tv/rok40NhdCXftEjZdfuBjQUWIz7CYUrxx39QyVj9zupfHRijtrEySECNVaVbB9AL4i1vGRsl9IjRka58cHAbqW2ktqAM0hZNFJVPSliYmdqaCNcwxBnKaQg2Vs/sbGQLij2RxRYBHTwuZ7C1yFQ9mXITPBYL/PKyRuUtUQ5p7ynRYeJ7dTiwMwZfIIeLDhpgUKU8k0Vw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(110136005)(52536014)(8676002)(38100700002)(122000001)(4326008)(76116006)(64756008)(66946007)(316002)(66556008)(508600001)(66476007)(66446008)(71200400001)(33656002)(6506007)(53546011)(2906002)(5660300002)(55016002)(186003)(26005)(83380400001)(6636002)(7696005)(86362001)(9686003)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjMwTmxLR3ZBZ1E0azdORDVtQUE5aEJiTHM2dHhmZ0xnSER3VUp4M0ZWMnBG?=
 =?utf-8?B?RHB6OUx2YkQwN3hFK1g4dmo3My9QVlViOWVRaFhPdHUxU1FmdGZDaVJXeFNi?=
 =?utf-8?B?VDRmZEVvOUJ2TjNja0VaMnpabkNscXczVU5QN1FxUUtTQ1p6R2hNN2lnRWhE?=
 =?utf-8?B?M3VPUVYzY0lneWZ5VjJiSHFBQjlpSTVqVGNGYmVkaWdCSG9RY0VUQitUSkpE?=
 =?utf-8?B?QTN4cnVPbFMrS0tjckgrcWRueXN4U2swS3lpTzZQNjlaV3EyV05GNXEzYWYr?=
 =?utf-8?B?Sm1DN3RBdXE2S2NYVmJYM0p5TThlbXRWTGxKdmtnRjZPMngyVjIvNXArV2Vw?=
 =?utf-8?B?SFZIaVF2TWZ6ekxnOEx6bGFmZm5KUXBtK1UyUjN0ZDFyNm1rOVhHcVpIdmZL?=
 =?utf-8?B?OWxSWXpNMGtpQWo5QytDcVNpTTZoUzNQSHJBWmQrYm81N01xVEhrWUx1Vmh4?=
 =?utf-8?B?MVpSd2RLMVhXSHRSOVpLblVGU1NpOVRzcUpzYnRieVZYRTIyb2VldmM5dDIr?=
 =?utf-8?B?aDJKWUkzZWJkQml2Ujdia3o2OFFQU0VwN1pBMjRXS2wwS29pYzkwcTllSUpI?=
 =?utf-8?B?a3F2ajVTZ3BVNjRKNzliazN2RnZDVVJkMWM3Uy9yN0ZHSjJveklUcDZzdDY0?=
 =?utf-8?B?RGNzeExHUWFVc0xuQU9FS0tjN0F5UE9uSXA0WFdZRzlGbFNodkZHWDNCQlh0?=
 =?utf-8?B?cmhGMzhJeWxUZGhXM3MrREdpZ0NUL2dqT283NElJYU1FRnVIOHNMUnBXWjBx?=
 =?utf-8?B?TXR2cXk4MmhwaVMwY2FpdjJHci9kc05TblpLTVY0YjZ0UjkzSnRiZnpVQ1Fl?=
 =?utf-8?B?TXkzb1d1MWdjcTJRZFphZjY2UkMveDR3aldxN3JrUjVvVmRqbGE1YjI0UzJI?=
 =?utf-8?B?a0dwODZVUmxwRU1TMWVQTkZqdk1SbzFZdHFneWtGMzdZVURTM1BkbFJwTDRD?=
 =?utf-8?B?UFJUMW95OGdCTnM1T2pCaENxbXVXS2M2V0lqOStpSlllQWM1ZjJFSnRSYjJ4?=
 =?utf-8?B?NE4wV3UvbW02T0NnNjBNcUs2Sm8yTHBYTnp0bU15Q0VRdDFBRWxMRmx5d1Q4?=
 =?utf-8?B?YlEzRjZaWlhRbWNVaXRwd3dnNmc2d1BNalo5TU1HYWdQc3l2MSt1OTlEZjVu?=
 =?utf-8?B?Q1pMcXcveXpZYXIzRUxsNnoxek1WTEYwQVN0RUdpdnlIMzhDd2VvdHY4QnEz?=
 =?utf-8?B?YkJmcWpIbm5IYXYwY1pSckhIanVHRnpBTUZuODVBdXk0SzhtVWpPdEN5dnBw?=
 =?utf-8?B?blpEL25KQTAycStKQnFqSm5vQVZDN0h3SmVPdnJLSm5INC90dTI1RVJoYnhH?=
 =?utf-8?B?MVF1R3dla2RGZnFDeUkwOFp1aXFSTi9URVRxQXVnR2VnVHNBWVUrQU5FTmZR?=
 =?utf-8?B?amRJQUhONGdiK24vaUVBQU5zL2RhODZPcUhhamJqczNHNkJ4UlNzS08rdElJ?=
 =?utf-8?B?bVZ4T1BjZjc2UkUxck5OVjNKRDF2SnVDdmNlUnJFcTg4cXM1cHU5WmpDcHg3?=
 =?utf-8?B?SElCRE1KaGY0L01SNnFHa1hDREhtcE5RQjdlU3Y4emZDbFRURXYzRkN1T1ln?=
 =?utf-8?B?Y1VFWkx0YzNONEJ3ZjVWREE1b0NCVWZuTTNHa0tOTG14ZG9La2JsL3NiNGdk?=
 =?utf-8?B?dTJPMkk4bnIrRTMvclZ4a2d6KzBMQW1TWCtWMldpbDg0ZWtSRndRdmVKZm1P?=
 =?utf-8?B?Y0QyYW5aY1oxMjNud3ZRZ2JUMVlDc3NsSzlRdElLNmIzTW81V2ovQVluK2hI?=
 =?utf-8?B?V3RkQ0VoZDd0OE45TTBjM3BqL3Q2ZGNmNm9MMGJkVzI1djZDb2dVY0xHbFUx?=
 =?utf-8?B?MkpXM25ack9XRW5PTndkcitkbGVBQituOTUwOFJpVFRoU08ycGxEWlJTaWtJ?=
 =?utf-8?B?YjNpT1V2eW53bElxQVUvekFqaTdFbFJOb293bzlraVFvaGVEWm82a21BZ3lw?=
 =?utf-8?Q?Wn6xY4nTO4g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a5b564-d0eb-4da5-8ab1-08d9950e58d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 03:45:10.0771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guchchen@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3691
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

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29t
Pg0KDQpSZWdhcmRzLA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9t
OiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhh
bGYgT2YgQWxleCBEZXVjaGVyDQpTZW50OiBGcmlkYXksIE9jdG9iZXIgMjIsIDIwMjEgMTE6MTkg
QU0NClRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpD
YzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NClN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGRybS9hbWRncHUvc211MTEuMDogYWRkIG1pc3NpbmcgSVAgdmVyc2lvbiBj
aGVjaw0KDQpQaW5nPw0KDQpPbiBUdWUsIE9jdCAxOSwgMjAyMSBhdCAxMTozMSBBTSBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBBZGQgbWlzc2lu
ZyBjaGVjayBpbiBzbXVfdjExXzBfaW5pdF9kaXNwbGF5X2NvdW50KCksDQo+DQo+IEZpeGVzOiBh
ZjNiODlkM2E2MzlkNSAoImRybS9hbWRncHUvc211MTEuMDogY29udmVydCB0byBJUCB2ZXJzaW9u
IGNoZWNraW5nIikNCj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211
MTEvc211X3YxMV8wLmMgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9zbXVf
djExXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvc211X3YxMV8wLmMN
Cj4gaW5kZXggNWMxNzAzY2MyNWZkLi4yOGI3YzA1NjJiOTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvc211X3YxMV8wLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9zbXVfdjExXzAuYw0KPiBAQCAtNzU1LDYgKzc1
NSw3IEBAIGludCBzbXVfdjExXzBfaW5pdF9kaXNwbGF5X2NvdW50KHN0cnVjdCBzbXVfY29udGV4
dCAqc211LCB1aW50MzJfdCBjb3VudCkNCj4gICAgICAgICAgKi8NCj4gICAgICAgICBpZiAoYWRl
di0+aXBfdmVyc2lvbnNbTVAxX0hXSVBdWzBdID09IElQX1ZFUlNJT04oMTEsIDAsIDExKSB8fA0K
PiAgICAgICAgICAgICBhZGV2LT5pcF92ZXJzaW9uc1tNUDFfSFdJUF1bMF0gPT0gSVBfVkVSU0lP
TigxMSwgNSwgMCkgfHwNCj4gKyAgICAgICAgICAgYWRldi0+aXBfdmVyc2lvbnNbTVAxX0hXSVBd
WzBdID09IElQX1ZFUlNJT04oMTEsIDAsIDEyKSB8fA0KPiAgICAgICAgICAgICBhZGV2LT5pcF92
ZXJzaW9uc1tNUDFfSFdJUF1bMF0gPT0gSVBfVkVSU0lPTigxMSwgMCwgMTMpKQ0KPiAgICAgICAg
ICAgICAgICAgcmV0dXJuIDA7DQo+DQo+IC0tDQo+IDIuMzEuMQ0KPg0K
