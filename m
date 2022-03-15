Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38B5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 07:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BA1B10E44B;
	Tue, 15 Mar 2022 07:30:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 886CB10E44B
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 07:30:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJRCbNj2RH0zPRQ/JxfedJoqfCUVyT5/72EbD/SYXK9svGVEmaO6oIUNMby2nwOzkWb16k4XoXhzGA4elPUMtyYaKEyIeAslv5CT3B3IhjbSph7Q07FcGaiR4A6eYl+tF9CqeE+l3rS0bz/qmRZfPsFTAmPr+d8q5j6XINx3comwHHELavBWc3FEj6stn/kleM7jfRcP8CgdO9+YSvWOmBEHnCRygUP9qoUUlxhdK1mEVxifs55Hqx6E/532YYeT5ruMJYffV5Xqye+klzuWNvSn8jb9jWjXDEH2EwdpgnDrgxKNUbLFaGbRGa0f32R1eo0iQORyhowpjZh5tZETLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iQ+jeuy7Go4LujVlP0Zdqfjc1nXqIg/UoQpQSlcS3w=;
 b=j+UidWeD4GyXqE357opbN3F2Iln6DeVKJIqADTSY9pdBZNGrPviXZOsTN++lE46DIbrvVcygkReCNxpPLiioeB7YWyms+j/Ddn3+MP4lYLweKgn40bhkA07+Sf9z3X2Bm1hcwZc5nDIHgFjlIkvY2PM+fNz1LuACxqS/5jvZVWO12wgAMar8chPAzXRz5d4lqf9766Cgeyoln9OSV0mLDwsaMZAqRTszez6/i7GsGttH4pZQf6pzfghJ4eqV+sSvzRxSLOv1HSII2CFeOJPx5yUNgmptRhKwPk2EfiNh7K/8DWzbepLMlQJpNIaA0rhW6pr1Mt01sDkjboDj8c7srg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iQ+jeuy7Go4LujVlP0Zdqfjc1nXqIg/UoQpQSlcS3w=;
 b=wkerUDaW5DMBnexPT70tHFlcX+Ef2TvQVNA0AhmqfH2PsbZILWDILwREODNAGJe0fLT0DPHEFvzPNgHxn8hs7h+Of4lbYQ7ii3to2jrstGWaZit5TV8B2G5rKIoDRVaZJtkUGn7vrKbqpieEOEedQcQpwYnWpScVK5p624zbRMI=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MN2PR12MB2864.namprd12.prod.outlook.com (2603:10b6:208:ac::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.25; Tue, 15 Mar 2022 07:29:58 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c5cf:8668:2fc7:afc4]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c5cf:8668:2fc7:afc4%7]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 07:29:58 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix pin count leak of PDB bo when unref
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix pin count leak of PDB bo when unref
Thread-Index: AQHYODvqyKZZe0HlGkyTgiiOSHs/C6zAClmAgAABkGA=
Date: Tue, 15 Mar 2022 07:29:58 +0000
Message-ID: <DM5PR12MB24691D6C766B70373845ACF9F1109@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220315071102.9773-1-guchun.chen@amd.com>
 <b0849888-2880-ef1f-67df-b6b89463b60a@amd.com>
In-Reply-To: <b0849888-2880-ef1f-67df-b6b89463b60a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05daad04-de72-486a-3acc-08da06559bea
x-ms-traffictypediagnostic: MN2PR12MB2864:EE_
x-microsoft-antispam-prvs: <MN2PR12MB2864048AAC7D423652AB8E5BF1109@MN2PR12MB2864.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9xUOb4dOiN5GA7aiABnrbHO9u7zrv9GyfA0MRb7oKhPQq5mxndLz58SvjotZC7cA7ZKUoKwSuTPcsQ6/zSu5I3x3B/cJDg2f7qUyYbOKlmonmhYaY8RYOnU2s11QMETUWBSMj+IB2CVuNNbqKvzpHI2Qz7Zemyx8hmJB3Q0ZK9kerLCLzpmXpOTZmQNxqW2kB1vi0yPtt9eFVVGQ5ZFuahdBObz2pp3prKBrthYwh88HL7wEO/KGCqGAoYaVtJoRGca3ru7PmnI9ygw0AxMVSIA+7CTJ7L5Sa1E9E+TlfopcpzkJU29pVI7zLHWYX0V7aJhzSiB9dxxbeXCTxxydYdeE3VFuGrYpZW3q4Ixp4u7bFB4QdBbIxxPcTAklygA2AZBLgNy1/URPLnzHPZm1OQVKle2bUSd2TaTVPu+SV5gvFenEE50xPTRN1WHZARaYAI3cgaq/vhRXgwkDJ0SiHzVTInuH5UOjDUMXv+NWGQweelDuFVJdrg3CX0YC3u/XOXpzSQf1hSFTEX4/isVJgpXmWzG2pie27Zp8b2w8VdbTxB8LJAOv7xjHK4BjU5i+x+F9JMntqSNv6bLJGaMkyRh6We0J86QZ8A1zln0CaI3PfZT1yu52sUUmNAhCzx2cn4bP4jbgu8BQHxN+JGcBGWPpMgQfX7WX7xjfkB9yZRqqFX/NQNoMvBnoXdjiv9/niZyQ33h2zVDICfmmZKLIFg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(6506007)(7696005)(9686003)(316002)(6636002)(53546011)(64756008)(8676002)(66946007)(66556008)(66476007)(66446008)(76116006)(71200400001)(508600001)(110136005)(38100700002)(122000001)(66574015)(26005)(38070700005)(186003)(83380400001)(5660300002)(33656002)(8936002)(52536014)(55016003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGYwS200TzhtL0N5aDJTYUNVVUZUVHgyR21VaGY2Y1p3c3RJZEFEenRuMnVL?=
 =?utf-8?B?UlUyUVZvckVKRGZENTVWdFh0Y0RaUnJhRTRXK3hlbnZrdlB3d0NrUGZucyto?=
 =?utf-8?B?dngzdW5JTzRTOGltNmRrcUtwS1Zqb2ZGa2pYcmhSbzFFUEg5eW9uMk9xMmpq?=
 =?utf-8?B?NFB5YUxHZ2RCaFVEblRDeFhiQk5DbkU3SHhDU2trQmNBR2c3UStydVQxREZi?=
 =?utf-8?B?L0I0Y2ROU2FybzBhQytOMC9ZVzV5ejN6d0lTZnRGRGtkamRqcFpodVhFeHpW?=
 =?utf-8?B?NUlVSGFZckM3bnE4ejREamNucGZpK2RBaW01dVFNOWo3eEFWSWRmbHJmdklC?=
 =?utf-8?B?aXh3bHZyV1V2NU12VFVKaWg2eU1KN1YxR2hOT2NoZjdiQk9mT3FOaktST3Yr?=
 =?utf-8?B?NWR0YUpGWUNCSkpUZTZER1hEOUhydDFDUVE5eXFkTE1TNWhKL1Npcml2QjNq?=
 =?utf-8?B?MEVmUFpwR3Z5di83eGgzNWRBSUJ1VEVrYUxab1dhUVBNMjFWQWhpSk9RSzBw?=
 =?utf-8?B?T3dzTVlHRkJjVmFLSThrVHg5OVpaZnVVOXhTR0RHSm84WFZZL08zNjJGZ3dt?=
 =?utf-8?B?VmRETjh4VkNTMnkzMmtZMGxWS0p5RlhNdUpTRXpISWhGdDR4R2dNR3pYU0Jv?=
 =?utf-8?B?a1duS2N4cnU1RHI0NCtXMnRERkNlc05wMUVBbkxHcjFnOW1MbVQxUEhOZnZV?=
 =?utf-8?B?cFpIRzFsc0kzNmZqU3IzeGxEcnhkODR2M2toMWtjZjVSS04wd1dXWGlOYmFs?=
 =?utf-8?B?ZTR4VktadnlFblVqMGUwbVUyc2Q5cDZSRHprOGh6N2owYlB4SEZQZTFUdTls?=
 =?utf-8?B?R2MwbEFTWlg1Y2U1SVowUkdnSW5OcUJVcC9vYi9VOHV3YjZ3RHg2TEM2MWRS?=
 =?utf-8?B?RXlFQ2tXRXI4bytVRDh6djRRczNqK00rZm1YNi9WQWNvUmx2cktVMTVWUjB0?=
 =?utf-8?B?ZVREeEowUG4zOTE3UzNWZ3dHQXZzRjVvaGJ0dzQ5azZpYTB1YnFLR3hqekkr?=
 =?utf-8?B?RmVvUUFRS3R1U2lVdE12aFRwWDIyZFhVNUpPVGJRakpLOERTSjB1WU05MCts?=
 =?utf-8?B?dHJqaW5LVFc5UFAyOVcxbGlJZXl6TWxxTjFVZkx1OTlIREJOUmlxRHplNTBR?=
 =?utf-8?B?dlgxWWx4dWdEOWJsTHJYYjlTWmQzZWZlS05iUEpEbVBJZm9zc0JSN2NCNENN?=
 =?utf-8?B?djVhTktFd1FzRzNPY3dvVGtQUFNVcU9PS0NQWThneUN4c0NnMm1LSG1aK3pM?=
 =?utf-8?B?dWhXMU5iTHhjcHpzNjJMc25DUmdSWis3L2QyMkNoSnJYd0pybXY2UktBdGJF?=
 =?utf-8?B?UkZjeGoySm9hSkxnbnJDcmd2YVZ1RVZDY0tHdURjWHZLQUFzT3k4U1RPT1Fj?=
 =?utf-8?B?L0x0RmR5SzNrSTU0bXdIN1J5NGpxNmcweG4zZllraXNLT1p2d2dJTlA0MCt5?=
 =?utf-8?B?MDBjaGVBaDNFUTQ2VWs0OWw0TExSV1lGMWdPTGtmK2lJSlhER2pRdGVmUUhw?=
 =?utf-8?B?N3F0M0haU2xJbUtZeEJISk9kVTg2MnNtN0ttcHBJQlQ3V2FxM21xdTFtUGtK?=
 =?utf-8?B?bThGTWR3dU5KckVydHI4VUNHU1E5ck9nUUd4WlRLNTRUTzlaTEloZDlraUYz?=
 =?utf-8?B?ME92VjhZODB1blZLMFVLR2FaTHh5dW1IVnM1cXBTNVVaYitoeXRNVFJmTW0w?=
 =?utf-8?B?UmRaOUNyNkkxeldrR2x5NURDQ1pUSEhwRGtXeHlTbk1kbGpyZkViY3BsR1B5?=
 =?utf-8?B?dlVaRy9yeXBDcjQzZjBVeWpTMC9Qa25nMjYzVjNaWWovV1A5cE5KSGNaVzhx?=
 =?utf-8?B?UFVHQ1QyeEFnNlB4elBnOWxLQVNEQmdRTjEwVW9HT3UyVkhhNGozaHRQVmMr?=
 =?utf-8?B?Rm1QMkZZYk5Cb2haQlE1RVNsMG1BY3NrV0ZlakxiWE5Dd1cvUHBhWkR1eHlr?=
 =?utf-8?Q?S8O0ZUCknyhbPW8ugtvx87UXDqTzkJyH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05daad04-de72-486a-3acc-08da06559bea
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 07:29:58.3683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Npprx14zJ/oW0/w5fFztgazZXYQqdRQW19Q/82vHHHxNRfSlRIJYwcvohI1h6l6UL/Ci/a6XpQuaYqKy5rvy3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2864
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

VGhhbmtzIGZvciB5b3VyIHJldmlldywgQ2hyaXN0aWFuLiBJIHdpbGwgc2VuZCBhbiB1cGRhdGVk
IHBhdGNoIHNldCBzb29uLiBIb3cgYWJvdXQgcGF0Y2ggMSBpbiBteSBzZXJpZXMgIltQQVRDSCAx
LzJdIGRybS9hbWRncHU6IHByZXZlbnQgbWVtb3J5IHdpcGUgaW4gc3VzcGVuZC9zaHV0ZG93biBz
dGFnZSI/DQoNClJlZ2FyZHMsDQpHdWNodW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+IA0KU2Vu
dDogVHVlc2RheSwgTWFyY2ggMTUsIDIwMjIgMzoyMiBQTQ0KVG86IENoZW4sIEd1Y2h1biA8R3Vj
aHVuLkNoZW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywg
SGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5A
YW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4N
ClN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBkcm0vYW1kZ3B1OiBmaXggcGluIGNvdW50IGxlYWsg
b2YgUERCIGJvIHdoZW4gdW5yZWYNCg0KQW0gMTUuMDMuMjIgdW0gMDg6MTEgc2NocmllYiBHdWNo
dW4gQ2hlbjoNCj4gVXNlIGFtZGdwdV9ib19mcmVlX2tlcm5lbCBpbnN0ZWFkIG9mIGFtZGdwdV9i
b191bnJlZiB0byBwZXJmb3JtIGEgDQo+IGNsZWFuIHVucmVmZXJlbmNlIGpvYi4NCg0KSSB0aGlu
ayB0aGUgc3ViamVjdCBpcyBpbmNvcnJlY3QuIFRoaXMgZG9lc24ndCBsZWFrIHRoZSBwaW4gY291
bnQsIGJ1dCByYXRoZXIgcHJvZHVjZXMgYSB3YXJuaW5nIHRoYXQgdGhlIEJPIG5lZWRzIGEgcHJv
cGVyIGNsZWFudXAuDQoNCj4gU2lnbmVkLW9mZi1ieTogR3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVu
QGFtZC5jb20+DQoNCldpdGggdGhlIHN1YmplY3QgbGluZSByZS12YWxpZGF0ZWQgdGhlIHBhdGNo
IGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+DQoNCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyB8
IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMg
DQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYw0KPiBpbmRleCA0MzE3
NDJlYjc4MTEuLmU0ZTdlNmRiYzZmYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ21jX3Y5XzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjlfMC5jDQo+IEBAIC0xNzIxLDcgKzE3MjEsNyBAQCBzdGF0aWMgaW50IGdtY192OV8wX3N3
X2Zpbmkodm9pZCAqaGFuZGxlKQ0KPiAgIAlhbWRncHVfZ2VtX2ZvcmNlX3JlbGVhc2UoYWRldik7
DQo+ICAgCWFtZGdwdV92bV9tYW5hZ2VyX2ZpbmkoYWRldik7DQo+ICAgCWFtZGdwdV9nYXJ0X3Rh
YmxlX3ZyYW1fZnJlZShhZGV2KTsNCj4gLQlhbWRncHVfYm9fdW5yZWYoJmFkZXYtPmdtYy5wZGIw
X2JvKTsNCj4gKwlhbWRncHVfYm9fZnJlZV9rZXJuZWwoJmFkZXYtPmdtYy5wZGIwX2JvLCBOVUxM
LCBhZGV2LT5nbWMucHRyX3BkYjApOw0KPiAgIAlhbWRncHVfYm9fZmluaShhZGV2KTsNCj4gICAN
Cj4gICAJcmV0dXJuIDA7DQoNCg==
