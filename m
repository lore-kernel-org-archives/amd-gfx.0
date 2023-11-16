Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9409AC47071
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 09:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 213D510E25E;
	Thu, 16 Nov 2023 09:37:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CBCA10E25E
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 09:37:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5oYGKJxf1hLuc5wVj3xg5QN00uumLvt2VkHHKTdaCt/3FhW4QLo7mHPeEy1QaV9AYVzksxnAoQr2cafXezh6HBDoLumwGsfaqTt2EwWobG+BDwxOa6VGiMkmkSAYYci8y7ZBIMKdPY+Z0DF/gE0VW84bSA6+n8GcPXa9h0azWDvUlWLFKirzPCafIi+ThbKR0BExsT8GZ3cJhGC89f08o8X+ffsqWHIUNYldq+eWZpWvyp6LosCz/6xYpPBhTyDeZ5MTjLqequooRoNUzwWQME9p4WLHkIRQ98zJtdE5iU0vC1Ova0a2CuGYTXPdvzU4iubI31+eQMrs4BCTIZyIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHuIPmOqRK8NauHBENTCSj1sy5rHENkPbGIFi9fKQIw=;
 b=gAANCK768eUnx9YZVV0Ba2MyIZdNzKJGT65SPYtec4QE1qr7kIH9zisLvVQ+8Zi4GrkAwq1InnQpDj7oR/ZTqONrpuRXRCZicJoAPzcB53GuchpPzXJ3hIgIWDRjEhVu5z8XRDizXrUpAxivZV5FfkbU0uy7Qf4Xsmskh50nayMrNEZt8HSA7CW9nxHLUr1EZvihrO/2ZHNWavomWJV+B1hFIBuKsO93DD06qT3ML+P77AYHixnutdD+PakFJ6kfSDBZz7jVSkUrxEm/r6rzwC46609SX5Osq/XhybBuii9opfTARHprAITFn4ZTIJk2cnqlqxI9jlgEE6m3R/RXfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHuIPmOqRK8NauHBENTCSj1sy5rHENkPbGIFi9fKQIw=;
 b=osQ3L6Ox8pjhSSwl7b/dQBa2LdbY9NfkUWdeN3uVsrUtlTzFuxb8pSh+TBnjWhFBO50HN7XsKPn1fMSPNQf3eOnlhT3b7Wrj+FoVu6rz6pp11g2A/3rN+JBOdkmXsC+cPbfMDi0TyKligovg9KkeyYitVNfD5BAv+wpeUoj0Agk=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 09:37:19 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b%3]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 09:37:18 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix AGP addressing when GART is not at 0
Thread-Topic: [PATCH] drm/amdgpu: fix AGP addressing when GART is not at 0
Thread-Index: AQHaE+TMEOy6LCNe6UqIOtkLiBXRErBzotaAgANdNwCABbhicA==
Date: Thu, 16 Nov 2023 09:37:18 +0000
Message-ID: <CY5PR12MB6369A027501FDC20699E31C7C1B0A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231110144701.1895397-1-alexander.deucher@amd.com>
 <59668638-00ce-4407-a0c1-47200480fe8f@amd.com>
 <CADnq5_O49zWhVhCopXFTC+9ijepy4iuV6vMbogP6+O8GWrZZOw@mail.gmail.com>
In-Reply-To: <CADnq5_O49zWhVhCopXFTC+9ijepy4iuV6vMbogP6+O8GWrZZOw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5e5b3fbb-c486-4db2-ac37-0406e9f8b84d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-16T09:34:35Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SA0PR12MB4495:EE_
x-ms-office365-filtering-correlation-id: 13f96f8e-0926-4011-bfed-08dbe687a065
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cw+jhC1j+I3jAuzhsq7jTsBmqY1roLBbcZ8Uc7oMT72Lwxks+zrlanwk494u8dr5Uc53+86v8UtWIGqgQdzcivukw7gH06v1g6KHUvb6Kj7Czw+AVxnIcTANV1c+sqR9id1VO+hp8S2hGP9rZR0HPqj5F9UBD58kq+U0VCLVX3SGpqdDKJmDna8KPbyKEfa2WtenCNykw6npFzSfOSoCTfbojUIojt3gBOtZFl79UqzjjHUOcXT6Ca+nLdmx47NuSDBWi/nMIH6O5ftZLVRiM5w/1cQ6/9tKE5NlLopHmzx2xdi/ltmW0jtZIyfFSQIo9lIOxp7z8TWPrnqHQd6wC0NPZHzSGdn9SzlIIPiJ7zbI8/How4KouLGUqTwFHntSw5d3LH+RGq732NiN0zLU25TlrNNzsjkRz+Ljt+c8P4HPPhYtMJrMlsFbgOXAPtpft1PQRYXg6T6T1owHryWbLWqfwWC7/an0px3DacWrKkrJtRsq3nKTPvGtxEGt7Jtr9eJm2OFCb/govmDdA4yh9f41+qHpZzY5YZ5ojvSJNa8uq+qB+5gGMIRRHlA47ajQYgOJAohNbz/E3/xdHacnaJ/AV/NfZWDIq/mjsmSs1njnQg0vphT7XZzKPt4NzB5N
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(7696005)(52536014)(66946007)(4326008)(110136005)(6636002)(66476007)(8676002)(54906003)(76116006)(316002)(64756008)(66556008)(8936002)(71200400001)(478600001)(66446008)(41300700001)(33656002)(86362001)(5660300002)(2906002)(38100700002)(122000001)(6506007)(26005)(53546011)(9686003)(83380400001)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aG90ZE9NQ0pyYnBINzhsaVRlYkRTT3ZTTERwQ2xkb1JPM2hOMVlzRzBKbnUx?=
 =?utf-8?B?bGxFVUFwRzJrY2tCSzEyY3hmWk41SVFKblQ3K25GL01ISHVyVmVoeXhrRFR5?=
 =?utf-8?B?eHRTQzBRZ3NhVDZEOXJ0MU5IdkYzeFhzUE5aeFR2SFFJa094Y0NOM1dNb044?=
 =?utf-8?B?d1BUZjRtTk5XYSsyT0d2UmpnMTNia0czNk1VWnBxNlNIVVF2eDZOZ1dTbHhX?=
 =?utf-8?B?VzVPWHJCdGxhaFFKSSs1QVYyYWEyMy96Q1RQRTg5dUhpVVRHdlViSVF6aEJ2?=
 =?utf-8?B?c05Ia21DQ3p0MlFJOEpIT1VwUHNvay9MOU5EYlZsM0hsVTM0OHFmWU5wOTdS?=
 =?utf-8?B?Y2JjaTNWMzc3MXdScVFsZnJHeGsvRjJaNHB0WjErMWdHQ25XTFdYampNY2xw?=
 =?utf-8?B?MjJnOXFtUFhpYTJYZnhCNmJTSTN0K1lmS1VwM09PZTdZT3J1Rkl0aDhRN3Vn?=
 =?utf-8?B?TFQxSVdIa2dvZVNHSVpUbVBGN2JIVTZRdm0rRzJFRWJXN0pHZ0VlN1JtK0ds?=
 =?utf-8?B?TCsweXF6aExhR0NvWFV3b04vTk5UZUNHZDNMbTdnYmpicktqalhnOFBoSnda?=
 =?utf-8?B?d3pKTUlNdFNjVkU4RkREVmxEZllVdkJSVFg3OEkwLzNuU0h3TmRRdmZiMG9Q?=
 =?utf-8?B?dnovQUIyb0VUZy8vY00wS1NqN1B6R3JmS3JxNUhYdm9HQlBZK2RpTjBaTlhr?=
 =?utf-8?B?ak9ET29lTlE5cHMrNHc2REltbC83NDRtTzlCK2JBbzVSd1BwT0pUZnRiTTdu?=
 =?utf-8?B?bk5OeTJCcUdIcFdBK2R4bzdGSUdOSjA4VzJ4cUNJMWxzV1R1c1QwSHNNSTdr?=
 =?utf-8?B?TnVCclk5UFNJbGtMWW85STF6eUhDMXRDMkoyY0RqTSt3QzVTb0F6dmFjZ25m?=
 =?utf-8?B?MW1Ic3NLR1gxb1RINkJuZ2hUQWhzTVl6Zkg0VmczT3JOcDllRUFjOFJmTHNu?=
 =?utf-8?B?UEZsNWY2UEl0N1VpMVFlTXoybTlZNVd2aElPejN5UlhwWlBWTzJpKzYwTTlC?=
 =?utf-8?B?T2tQeTR0dGViaElvVzlYeWxUendsK21wTExWL2c3ZjVDNTY1aWZaeXpiR1J6?=
 =?utf-8?B?ditHaitNT0N3ZU1GdktDUS9Ncm1zaE9YMkNCdG40UVpuSHpqWkpieUJ5NHJw?=
 =?utf-8?B?cmhuRWw5dmswL2Iwck9UMlpzLzdXWVBNS1grZWN6WmhUbExaTWpNSHFOSFlE?=
 =?utf-8?B?cmJWYlFEODRNd1hFK3hncU1tcktmaEVaSFhxeFpMV2FHUC9hU090TSt1cGIr?=
 =?utf-8?B?UnNYeGxsY3NSclp3SHJkSkNJVjliZGswQ1owdWYwNXRmRmpvWnBFN2Z0eE9j?=
 =?utf-8?B?NFdFWnJNTW9ScWgyMTc4Q0p0SkZzOVdsWXUxWndsVFQ1dEd2ZFlOWndweGsy?=
 =?utf-8?B?SFFqUWR4ek1UUk1NUVgyN1VQaVNDdERjTXRCYVdGRS9CVm5QWHNDSVhNcjJF?=
 =?utf-8?B?UEkrbjNZR1lENzRwZm53ekN0TTUzV21lclY1T0loZ0Rlc2V5VVhzcnUyUWV3?=
 =?utf-8?B?SWZOM3VERXoxYmxUN0xMeHIvUWhPeC9YeEJYSlN5OWVWSmRIWkxIRjdubDMw?=
 =?utf-8?B?TlozVU5MVTF1bnV2OTZXWHp3RzROdWd6UWJERUZNS3cwck9NSGtRa1BZMm92?=
 =?utf-8?B?bmxrRTF4RTFLemJzOCtLVFJvWmlpcVB1NXIrMk83TXlMdk9HcHYzbTM1cTRt?=
 =?utf-8?B?RjdJR21sbTF1R3RjM1g3Mjl3MlIvMmhzY09DQUpLVDU5VmRobFljbm9RNjNB?=
 =?utf-8?B?TVM4TnJ3MnJrYUxHSGVlblFSZXVIYS9NNzE2cjdyb1VoY2MyakhEYy90M0lG?=
 =?utf-8?B?NkJOS1N2ckVkVXVaM2dzMGh6eDhBZFM5RmNwRmRwSHczVTZTYkJScStJVGdv?=
 =?utf-8?B?Y0tLY3NyQlpHeDdDZmtuMFFjMHJFL3hCcFVEb3pDTGJMUVF1azBNNS9pbTVV?=
 =?utf-8?B?VzBlL05BSG5pemlZaTRGVkMrcXZkYncvZU4rT0xoY3RMb2tUK0lIUjVYQ1dr?=
 =?utf-8?B?Qy9ISGFkZlB1Yjd4M0pnaW5RRTkxSFN6SmlaS1JlR0tteGVTa0MrTy9BY2ZS?=
 =?utf-8?B?TENhQ29ZSFF4Mk15RWtyUkFGSXIzWjB3Q1FQZXVWc1p6WWdHaFQ2dTRUOXpj?=
 =?utf-8?Q?upk0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f96f8e-0926-4011-bfed-08dbe687a065
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 09:37:18.8853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ca6voU5kuPPg0wyoLLk1BX6fCm78NW17mSrQRXtu/ZYjG7Rp3c1ZEeFxRjjuiaL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Jesse\(Jie\)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClBpbmcuLi4gdGhpcyBwYXRjaCBz
ZWVtcyBzdGlsbCBub3QgbWVyZ2VkLg0KDQpCZXN0IFJlZ2FyZHMsDQpZaWZhbg0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFp
bC5jb20+DQpTZW50OiBNb25kYXksIE5vdmVtYmVyIDEzLCAyMDIzIDI6MTMgQU0NClRvOiBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KQ2M6IERldWNoZXIsIEFs
ZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnOyBaaGFuZywgWWlmYW4gPFlpZmFuMS5aaGFuZ0BhbWQuY29tPjsgWmhhbmcsIEpl
c3NlKEppZSkgPEplc3NlLlpoYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0v
YW1kZ3B1OiBmaXggQUdQIGFkZHJlc3Npbmcgd2hlbiBHQVJUIGlzIG5vdCBhdCAwDQoNCk9uIFNh
dCwgTm92IDExLCAyMDIzIGF0IDI6MTfigK9BTSBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBBbSAxMC4xMS4yMyB1bSAxNTo0NyBzY2hyaWVi
IEFsZXggRGV1Y2hlcjoNCj4gPiBUaGlzIHdvcmtlZCBieSBsdWNrIGlmIHRoZSBHQVJUIGFwZXJ0
dXJlIGVuZGVkIHVwIGF0IDAuICBXaGVuIHdlDQo+ID4gZW5kZWQgdXAgbW92aW5nIEdBUlQgb24g
c29tZSBjaGlwcywgdGhlIEdBUlQgYXBlcnR1cmUgZW5kZWQgdXANCj4gPiBvZmZzZXR0aW5nIHRo
ZSB0aGUgQUdQIGFkZHJlc3Mgc2luY2UgdGhlIHJlc291cmNlLT5zdGFydCBpcyBhIEdBUlQNCj4g
PiBvZmZzZXQsIG5vdCBhbiBNQyBhZGRyZXNzLiAgRml4IHRoaXMgYnkgbW92aW5nIHRoZSBBR1Ag
YWRkcmVzcyBzZXR1cA0KPiA+IGludG8gYW1kZ3B1X2JvX2dwdV9vZmZzZXRfbm9fY2hlY2soKS4N
Cj4gPg0KPiA+IFJlcG9ydGVkLWJ5OiBKZXNzZSBaaGFuZyA8SmVzc2UuWmhhbmdAYW1kLmNvbT4N
Cj4gPiBSZXBvcnRlZC1ieTogWWlmYW4gWmhhbmcgPHlpZmFuMS56aGFuZ0BhbWQuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4N
Cj4gPiBDYzogY2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgfCAxMCArKysrKysrLS0tDQo+ID4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgICAgfCAgNCArLS0tDQo+
ID4gICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2Jq
ZWN0LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0K
PiA+IGluZGV4IGNlZjkyMGE5MzkyNC4uMWIzZTk3NTIyODM4IDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0KPiA+IEBAIC0xNTI3LDEwICsx
NTI3LDE0IEBAIHU2NCBhbWRncHVfYm9fZ3B1X29mZnNldChzdHJ1Y3QgYW1kZ3B1X2JvICpibykN
Cj4gPiAgIHU2NCBhbWRncHVfYm9fZ3B1X29mZnNldF9ub19jaGVjayhzdHJ1Y3QgYW1kZ3B1X2Jv
ICpibykNCj4gPiAgIHsNCj4gPiAgICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGFt
ZGdwdV90dG1fYWRldihiby0+dGJvLmJkZXYpOw0KPiA+IC0gICAgIHVpbnQ2NF90IG9mZnNldDsN
Cj4gPiArICAgICB1aW50NjRfdCBvZmZzZXQsIGFkZHI7DQo+ID4NCj4gPiAtICAgICBvZmZzZXQg
PSAoYm8tPnRiby5yZXNvdXJjZS0+c3RhcnQgPDwgUEFHRV9TSElGVCkgKw0KPiA+IC0gICAgICAg
ICAgICAgIGFtZGdwdV90dG1fZG9tYWluX3N0YXJ0KGFkZXYsIGJvLT50Ym8ucmVzb3VyY2UtPm1l
bV90eXBlKTsNCj4gPiArICAgICBhZGRyID0gYW1kZ3B1X2dtY19hZ3BfYWRkcigmYm8tPnRibyk7
DQo+DQo+IElJUkMgeW91IG11c3QgY2hlY2sgYm8tPnRiby5yZXNvdXJjZS0+bWVtX3R5cGUgYmVm
b3JlIGNhbGxpbmcNCj4gYW1kZ3B1X2dtY19hZ3BfYWRkcigpLg0KDQpZZXMsIHRoaXMgd2FzIGZp
eGVkIGluIHYyLg0KDQpBbGV4DQoNCj4NCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0KPg0KPiA+
ICsgICAgIGlmIChhZGRyICE9IEFNREdQVV9CT19JTlZBTElEX09GRlNFVCkNCj4gPiArICAgICAg
ICAgICAgIG9mZnNldCA9IGFkZHI7DQo+ID4gKyAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAg
b2Zmc2V0ID0gKGJvLT50Ym8ucmVzb3VyY2UtPnN0YXJ0IDw8IFBBR0VfU0hJRlQpICsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X3R0bV9kb21haW5fc3RhcnQoYWRldiwNCj4gPiAr
IGJvLT50Ym8ucmVzb3VyY2UtPm1lbV90eXBlKTsNCj4gPg0KPiA+ICAgICAgIHJldHVybiBhbWRn
cHVfZ21jX3NpZ25fZXh0ZW5kKG9mZnNldCk7DQo+ID4gICB9DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYw0KPiA+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jDQo+ID4gaW5kZXggMDU5OTFjNWM4ZGRiLi5hYjRh
NzYyYWVkNWIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3R0bS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0
bS5jDQo+ID4gQEAgLTk1OSwxMCArOTU5LDggQEAgaW50IGFtZGdwdV90dG1fYWxsb2NfZ2FydChz
dHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvKQ0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuIDA7
DQo+ID4NCj4gPiAgICAgICBhZGRyID0gYW1kZ3B1X2dtY19hZ3BfYWRkcihibyk7DQo+ID4gLSAg
ICAgaWYgKGFkZHIgIT0gQU1ER1BVX0JPX0lOVkFMSURfT0ZGU0VUKSB7DQo+ID4gLSAgICAgICAg
ICAgICBiby0+cmVzb3VyY2UtPnN0YXJ0ID0gYWRkciA+PiBQQUdFX1NISUZUOw0KPiA+ICsgICAg
IGlmIChhZGRyICE9IEFNREdQVV9CT19JTlZBTElEX09GRlNFVCkNCj4gPiAgICAgICAgICAgICAg
IHJldHVybiAwOw0KPiA+IC0gICAgIH0NCj4gPg0KPiA+ICAgICAgIC8qIGFsbG9jYXRlIEdBUlQg
c3BhY2UgKi8NCj4gPiAgICAgICBwbGFjZW1lbnQubnVtX3BsYWNlbWVudCA9IDE7DQo+DQo=
