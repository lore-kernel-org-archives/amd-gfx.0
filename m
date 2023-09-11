Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31798C71153
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Sep 2023 03:09:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85C9D10E0CD;
	Mon, 11 Sep 2023 03:09:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ED1810E0CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Sep 2023 03:09:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1VAAEHRlT6mU1v+MWDxloI9Jla52YbB3wyCfQp8FO78NW+RMYQjlD6cMI8PnXi7Usl4PH24viGMmKi8WEaYfqhmudc4rjd5y7AL1E4dO4rw+kW0IjShZxyzXU6vjf3L38a+Y4OiFcWPxNOlQleALoOmwhIb1GrLzNRUwC48LdYO3/8QT+cLpyDIcq9MIdO5SyuGzg3Ch+Y41BodtMKdJ4Rs22eaAg1pXG6PPiLTl8tcca5iGbUTYcp19EWo7fVmtT98+i11Czn9ZM+qTwxJ2W7yZkD4bQJXtK1ra0ypPkPYm+lIX1LB/442G4SlpPyTc/Wi678XkFwN+WceJoZM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyTd0xNlgf+8ofjZoPe9npbNVKbPRDHqO9LSBZLuMOg=;
 b=Vn/+zLtG2oQk5A2BXv9vkNSaKSQVle6mHSUNe/RaFR+Xu3vRAR/kg+cFi5zgOb9AKgBKZY0ElMRf9I0oIGqjAyF7CBX/OCXVHCEw8qgvqq5mt9GH4uSZGhCI89s9TqB8G0PU42ZbI8GCJEwRT7EMbmT0Fj68+Xz+j6ZpJ82+csQ5w7jGHcEuaaBCruAAKTCxk+5t2MnuRq7AQlKjRXBYS7j2P0HqtruyjjACZhhDFQHC7m8cqKgItYRcpPh1OGfA1/Tbe/FQgxfmZ98LCiCggpRmoaL5r3IY7E1h6GbHwCJbIVc2+kJPo4HkugP5r78bEEyYWFXcSz4fpmfaedjsFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyTd0xNlgf+8ofjZoPe9npbNVKbPRDHqO9LSBZLuMOg=;
 b=uPdQsyfWEoxirLnaGDY9/d2hzsOF4cIM/3Yxr7SuBtRcfOG8120Z6ECEmVNcLo9R1RT3YAhzSuu45mYS2xaJK458HvhI5r1BBf7kgSnBot7fgV3/9m670R9Ty/+IL7LY7Z+b3kjuYrui98SaxZUv9Fs64Azmk/MrOBWGOfz/Ee8=
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.33; Mon, 11 Sep 2023 03:09:33 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6745.035; Mon, 11 Sep 2023
 03:09:33 +0000
From: "Ma, Li" <Li.Ma@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add type conversion for gc info
Thread-Topic: [PATCH] drm/amdgpu: add type conversion for gc info
Thread-Index: AQHZ4TrzM02a557ZYEaELn56tUCYCrAOyk8AgAYth3A=
Date: Mon, 11 Sep 2023 03:09:32 +0000
Message-ID: <SJ1PR12MB607522AAEC0B849806A5BE68FAF2A@SJ1PR12MB6075.namprd12.prod.outlook.com>
References: <20230907032500.99796-1-yifan1.zhang@amd.com>
 <CADnq5_Pv6+5jwKuL54ghLqQYid66FCQxcUzT5mWihbSehiT+=Q@mail.gmail.com>
In-Reply-To: <CADnq5_Pv6+5jwKuL54ghLqQYid66FCQxcUzT5mWihbSehiT+=Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a4f6ecd1-adc4-46c2-9c53-709709dbdeac;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-11T03:07:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6075:EE_|DS7PR12MB6285:EE_
x-ms-office365-filtering-correlation-id: 6c751926-510c-45ed-c40e-08dbb2748599
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UuiDee4NhK2ouVvJC8YYwcTVCrxR84ReziDSSl46wZxjWpJrA9B6GGmXcCWocmQq4awZeAq0VwnFrWHbdndApCuL+s468kFAtoY8RC008LcAXDz6Oc8JhnfYQ3A6kVi6bICZh4GJVeJ0qFW+nseXkmQBdOdSFsuOcBqQGyxnzhWEVibCkNTq/KqHWQOsVkIkR1RxvD5/PKzN/CLsgUC4Eov+qOQg1+IF4c6yBIJbrycdVv2Y0Z4YTfhM05Onmq04Te+Moq4EzGARsNee1ZFClOt+DnsNOM1O111ApUkmtiDpXmgk4rGuS5t6dmRN5xuTWEpruloBiLBwRIQJPcPkY0AtVDp3d0ZTzon5uZCgrgKWktj14TbBjIzQoBMk8EUdLajRVTFaP2fr39EFv3K/k6QEfpTvhdGhYwmkmo0QZ2qSQA5eYBITJhnzigxD70nK54iMHPrY7N0PaqEFXRVajIDebE0O9TWTA9hd4kDrAlgXCSvsFP8/AssNcHRfacu7NcU2IwBIEF/XNGebGqq3e6CKkV4vbv5LbJKCk370Squn/l6oTHF+t65O+ad6cIiYaynB4f6Vdkn0eWf1vIEAvmlV0rGJpYYouwGUum4IikfHpd/erWUc7AhCaVDMA6eB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(186009)(1800799009)(451199024)(6506007)(7696005)(53546011)(71200400001)(9686003)(478600001)(83380400001)(26005)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(6636002)(4326008)(52536014)(41300700001)(5660300002)(8936002)(8676002)(2906002)(33656002)(86362001)(55016003)(38070700005)(38100700002)(110136005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXJHK1lWTm1mK2lyZ2hnbFgxQ1NLeWVqUlZMYnIvdmZPZTYrejBVRi9EUGpj?=
 =?utf-8?B?Vy9wcjEzOFI2alVRKzlSTFJuUlBuSWZScXhjTFJuS0Z5SHN2MWdJTjNvMTlF?=
 =?utf-8?B?Q0V3QUpZaTd3WjJTcC8vZzI0ZTJqZVFVR2V3T25LMmRjMDJQUzdzSHhGNWFu?=
 =?utf-8?B?Lzg0WDFWcnNteW56RWttTjRSVXNEUmhTeW1Yd1dCODZpV0lHSUxWZEEyWjdx?=
 =?utf-8?B?Wk5kRUNRYWhkRERFMzUrUmdTaWdJaGdQdlZYbnZZZjlMKzVXaHhJQzUxdlpG?=
 =?utf-8?B?MVRZMmw3b1FEQzBlQld4SDVPbkpBYTJPb3dESGtOdllkUC9aQjF4YW1HRGll?=
 =?utf-8?B?SGw3MmhNSDNDbFFqSWlWNy9oTGVmMjB0Y0RyVWVXRGQ5YUVKR3NjMWt1dy9F?=
 =?utf-8?B?T1ZzZ3JoUGk4bnZrd1ROelNBS08yMThRekVIRzZ1ZEs2a2xpOC9Dd2RNOTMw?=
 =?utf-8?B?OXFUYTdDWHVRVFNFMGZuMm90TUZqajVWQ1BNcDdURzJ1MFNObFh1WEgwOUIy?=
 =?utf-8?B?Wjc1SHl5WkFaaWhzdi9POElndUo4MGlCLzFpSEJrb1huY3BxQVRCMFUyNjVH?=
 =?utf-8?B?bFFxcS9YTVpQWnVLK1lma2NDbDA2ZUNVanZlMUpRUGhobGdHOHZjTUNEQlFr?=
 =?utf-8?B?ckxWVTZPc1lsNktrd0hGYXN0NFN5YTdKUytrckVoVkZjTFNTSjZpYkVEeDVi?=
 =?utf-8?B?blRsZkRocHBBWDRDTEhJRWZac0FtNUljanJyNEh3K1RuMGZpVkVUY2VJM3dy?=
 =?utf-8?B?RExHRk9HYk5IbTMrelA1TDVhS05vdGNIdU0vVjdHQloySnZ2YTdMVkptaUo2?=
 =?utf-8?B?c0ZBbFNGdlNRY1RDekhhYXZwWXE3L0tGSkUycm9pbFBvUGcyQWJuREU2VnpX?=
 =?utf-8?B?QXlKM3BtdjFwbnNvZkRzR2NQY3N2NEZ3VzdKYXcremhPWWE3a21MTW5nVHhI?=
 =?utf-8?B?R3JtanZZUGdLV01PUnNjdVNUdFNKSytOMEd2cEE3ZTZaTTVGOEd1SnAwdERV?=
 =?utf-8?B?R2REL3J5WTRzWHlmSXdOQUxkWjR3cmh3QmZiTjFuOTdlakhPd2E4bktDSDJM?=
 =?utf-8?B?QzI5R0xEREVOeG8rU1pCbVVaamxMOHozZTdMUUFLZGJUampCY2V3ZWFLcklO?=
 =?utf-8?B?YlZ1Mi8vL1hIaC9GdkV6aEZZN1BDdU5VTVQ0cU45aGJmQ0ZqczJkdm5RQU1Z?=
 =?utf-8?B?c1llWnNRY2hMOEo3Q3VkYzBnVEVWQm14cVg3SE5rbEJKM3VDK2M1VEQ0dXJq?=
 =?utf-8?B?Y2I1bXk3YmRUREZXUVdIcXFWdVFVelZaSEVvb2JJd09jZUxYZDhwUnhmRWI0?=
 =?utf-8?B?UkVBenpNS0IxRmxSSUJMc2tjdG5pbFh3WS91by9JampLSlovdHVpOEtMQWV1?=
 =?utf-8?B?SENaY3VHVTlhMGQ5VjhBMHJyVUxOZGJZdGMwRXlSaStmQmpZRUdUaU5VZndq?=
 =?utf-8?B?d3VVZDFoU05uQXhvM0lXTFFNODJrVGJHaGNvbVBwa1MxQkpSRDNWS25tRWFk?=
 =?utf-8?B?UUNJeGdSRzJURjdlajBFU0g5aGxrd0kydHgxcTFlMjRWWGlLY0tJL2NJZi9P?=
 =?utf-8?B?RDZ0cFZxWEtaYko5ZXNtK21FYis2amt6dXBQQ002SFVjdWVEcllXWkNlNGMv?=
 =?utf-8?B?TThISG5lR002TW04d1NIMnRKWGo2Y0JvVlpIUmpFVm1nTEc0M2VZSEVPM3Ba?=
 =?utf-8?B?Z0NNZitPSlg1NEFWdU1wM0dYMXRJV3ZpaUdKR2dzQUhpVTlLa2Jtd29ybnNX?=
 =?utf-8?B?OHgxU0sxZ2g4SGdHcnJiUUtGRkVZMVN5NldLZGt5VHArd2I1cDk2WkFYWU1p?=
 =?utf-8?B?bU5iRkdSQ3JDTzVxZjB2ZzRrT1lhNWdFbU15SFkzRldQanFsZzJtZWY3SXV1?=
 =?utf-8?B?WVJrQ0d0UWhINnJJS0thZzlFY0txUUdESzMwcS9NL3Zuc3dSOFYyaUJLMndH?=
 =?utf-8?B?MHdPM0hSSm9JTGJUWlZBNENzbVZZVVRoc1VtcnlWc0dxMlJiZXF1MS9qYkkx?=
 =?utf-8?B?Sy9qUXo2TmRyYldJZ0hHQ043dnE5NjMzbm5Za2VtUkxvVkk4VUtJNEw2NWZR?=
 =?utf-8?B?ZVowVFJRWjk3T1lHUUxDNGx1eWpPaXNCeGRXQngzUnMvSzZSNXBKWjJFU1gv?=
 =?utf-8?Q?ley8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c751926-510c-45ed-c40e-08dbb2748599
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 03:09:32.9999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34BOgGRUpjY42edxegMz7XKEXx3S5nLWR2me9XCB4JrV6aG6zhnlFycavxRjgLHu73RXbA0vBfar2aPPIIf1zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBMaSBNYSA8
bGkubWFAYW1kLmNvbT4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1n
ZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBB
bGV4IERldWNoZXINClNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgNywgMjAyMyAxMjo0NyBQTQ0K
VG86IFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFtZC5jb20+DQpDYzogRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENo
cmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpT
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBhZGQgdHlwZSBjb252ZXJzaW9uIGZvciBn
YyBpbmZvDQoNCkNhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJu
YWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBj
bGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCg0KDQpBY2tlZC1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KDQpPbiBUaHUsIFNlcCA3LCAyMDIzIGF0IDEy
OjIw4oCvQU0gWWlmYW4gWmhhbmcgPHlpZmFuMS56aGFuZ0BhbWQuY29tPiB3cm90ZToNCj4NCj4g
Z2MgaW5mbyB1c2FnZSBtaXNzZXMgdHlwZSBjb252ZXJzaW9uLg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBZaWZhbiBaaGFuZyA8eWlmYW4xLnpoYW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jIHwgNiArKystLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCj4gaW5kZXggNWQxNzll
ZGNjOGE4Li45YWIzM2IwYmJiYWQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCj4gQEAgLTE0MzksMTIgKzE0MzksMTIgQEAgc3RhdGlj
IGludCBhbWRncHVfZGlzY292ZXJ5X2dldF9nZnhfaW5mbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikNCj4gICAgICAgICAgICAgICAgIGFkZXYtPmdmeC5jb25maWcubnVtX3NjX3Blcl9zaCA9
IGxlMzJfdG9fY3B1KGdjX2luZm8tPnYxLmdjX251bV9zY19wZXJfc2UpIC8NCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgbGUzMl90b19jcHUoZ2NfaW5mby0+djEuZ2NfbnVtX3NhX3Blcl9zZSk7
DQo+ICAgICAgICAgICAgICAgICBhZGV2LT5nZnguY29uZmlnLm51bV9wYWNrZXJfcGVyX3NjID0g
bGUzMl90b19jcHUoZ2NfaW5mby0+djEuZ2NfbnVtX3BhY2tlcl9wZXJfc2MpOw0KPiAtICAgICAg
ICAgICAgICAgaWYgKGdjX2luZm8tPnYxLmhlYWRlci52ZXJzaW9uX21pbm9yID49IDEpIHsNCj4g
KyAgICAgICAgICAgICAgIGlmIChsZTE2X3RvX2NwdShnY19pbmZvLT52MS5oZWFkZXIudmVyc2lv
bl9taW5vcikgPj0gMSkgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT5nZnguY29u
ZmlnLmdjX251bV90Y3BfcGVyX3NhID0gbGUzMl90b19jcHUoZ2NfaW5mby0+djFfMS5nY19udW1f
dGNwX3Blcl9zYSk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPmdmeC5jb25maWcu
Z2NfbnVtX3NkcF9pbnRlcmZhY2UgPSBsZTMyX3RvX2NwdShnY19pbmZvLT52MV8xLmdjX251bV9z
ZHBfaW50ZXJmYWNlKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgYWRldi0+Z2Z4LmNvbmZp
Zy5nY19udW1fdGNwcyA9IGxlMzJfdG9fY3B1KGdjX2luZm8tPnYxXzEuZ2NfbnVtX3RjcHMpOw0K
PiAgICAgICAgICAgICAgICAgfQ0KPiAtICAgICAgICAgICAgICAgaWYgKGdjX2luZm8tPnYxLmhl
YWRlci52ZXJzaW9uX21pbm9yID49IDIpIHsNCj4gKyAgICAgICAgICAgICAgIGlmIChsZTE2X3Rv
X2NwdShnY19pbmZvLT52MS5oZWFkZXIudmVyc2lvbl9taW5vcikgPj0gMikgew0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICBhZGV2LT5nZnguY29uZmlnLmdjX251bV90Y3BfcGVyX3dwZyA9IGxl
MzJfdG9fY3B1KGdjX2luZm8tPnYxXzIuZ2NfbnVtX3RjcF9wZXJfd3BnKTsNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgYWRldi0+Z2Z4LmNvbmZpZy5nY190Y3BfbDFfc2l6ZSA9IGxlMzJfdG9f
Y3B1KGdjX2luZm8tPnYxXzIuZ2NfdGNwX2wxX3NpemUpOw0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICBhZGV2LT5nZnguY29uZmlnLmdjX251bV9zcWNfcGVyX3dncCA9IGxlMzJfdG9fY3B1KGdj
X2luZm8tPnYxXzIuZ2NfbnVtX3NxY19wZXJfd2dwKTsNCj4gQEAgLTE0NzMsNyArMTQ3Myw3IEBA
IHN0YXRpYyBpbnQgYW1kZ3B1X2Rpc2NvdmVyeV9nZXRfZ2Z4X2luZm8oc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpDQo+ICAgICAgICAgICAgICAgICBhZGV2LT5nZnguY29uZmlnLm51bV9zY19w
ZXJfc2ggPSBsZTMyX3RvX2NwdShnY19pbmZvLT52Mi5nY19udW1fc2NfcGVyX3NlKSAvDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIGxlMzJfdG9fY3B1KGdjX2luZm8tPnYyLmdjX251bV9zaF9w
ZXJfc2UpOw0KPiAgICAgICAgICAgICAgICAgYWRldi0+Z2Z4LmNvbmZpZy5udW1fcGFja2VyX3Bl
cl9zYyA9IGxlMzJfdG9fY3B1KGdjX2luZm8tPnYyLmdjX251bV9wYWNrZXJfcGVyX3NjKTsNCj4g
LSAgICAgICAgICAgICAgIGlmIChnY19pbmZvLT52Mi5oZWFkZXIudmVyc2lvbl9taW5vciA9PSAx
KSB7DQo+ICsgICAgICAgICAgICAgICBpZiAobGUxNl90b19jcHUoZ2NfaW5mby0+djIuaGVhZGVy
LnZlcnNpb25fbWlub3IgPT0gMSkpIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgYWRldi0+
Z2Z4LmNvbmZpZy5nY19udW1fdGNwX3Blcl9zYSA9IGxlMzJfdG9fY3B1KGdjX2luZm8tPnYyXzEu
Z2NfbnVtX3RjcF9wZXJfc2gpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT5nZngu
Y29uZmlnLmdjX3RjcF9zaXplX3Blcl9jdSA9IGxlMzJfdG9fY3B1KGdjX2luZm8tPnYyXzEuZ2Nf
dGNwX3NpemVfcGVyX2N1KTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgYWRldi0+Z2Z4LmNv
bmZpZy5nY19udW1fc2RwX2ludGVyZmFjZSA9IGxlMzJfdG9fY3B1KGdjX2luZm8tPnYyXzEuZ2Nf
bnVtX3NkcF9pbnRlcmZhY2UpOyAvKiBwZXIgWENEICovDQo+IC0tDQo+IDIuMzcuMw0KPg0K
