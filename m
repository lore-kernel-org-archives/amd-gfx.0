Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C59E9D831
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2026 04:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 541C710E151;
	Mon,  6 Apr 2026 04:20:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xo38fcnz";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E1810E151
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2026 04:20:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktrQO7lseSA0ZNKRAeKricS86piwc8zpPtXDRwbT6pjhsT7c4iPZK9reiBXu4yRY5WuyHXe8pJSpIzi3RJTCMs9lMoHWQWrsN/kQ19NrbDlMx7FyWB0z6wd2uF4O3lxB+P4LTBiVhfvV37qWs3nqjSFzH36/0kA4oW4c6203yLG87XfgyCyepVF1ATg05ShHK7xXH9bz02ZMd5nMkl/E2ccPjzIaqMy/4xW5NAROr1FypySwJ1E67OxizyB76H5Eo3qMZJ5u5tE+KAiXKJj/IpmpYdSCfno1toPhkFyxXt8YRr5uOID27LFxkpvCmR5qTkNTZ4jp75vCwS28hK8dGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RUtmbopGu1xn3BMSXRR4DC3k6SDoaLjsoieGKoH8E0=;
 b=tF7WGasrkGqV66U3pKsEKqKGcRSVpA2P1fhSgAPmJU+PmpeedwH21MLx48ANcmtD8L1v8OC0uYmHLUQ86fdjj8K4RqaHFxN7Y9LM9K2mXRdJZq3P+toB/ISSUPtBs92MeLEjZCz4UtA572a9Z2gYzycNpJw6Hh1tW/0hO42QBuLm7iEoY9rSdmgc2icqFdEng2Fid7bE0b3hkRpwSpQ0gtyEunCm+Ps0hju5huu8rNzW1BK21rFb3mM80X5XKc0B5B+roF8ZE2JQ1y6p1xX47RaeQTP9Gte2qTeh0AsYOutxbKb2Ljf9KoXVpVgYMpi0CZSBNXJc9eQhzxipNzA/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RUtmbopGu1xn3BMSXRR4DC3k6SDoaLjsoieGKoH8E0=;
 b=Xo38fcnzqbdo/k5yncD0Cw9IHo/SFhTGL/OiO/beVZhYNBUlRhZrfaJd83URfDUsbTSQJaPzItiLSBkIa7Qvb4H/KP1nYfzDLDgD2Dy23ypG6PMqgaMqLa6SmsEC8F2EwLIYYSjFIATuns62uP1NHWhUfBhIWS3hV436VsiwRJ4=
Received: from SJ0PR12MB8165.namprd12.prod.outlook.com (2603:10b6:a03:4e4::6)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Mon, 6 Apr
 2026 04:19:37 +0000
Received: from SJ0PR12MB8165.namprd12.prod.outlook.com
 ([fe80::1499:6598:d339:f12e]) by SJ0PR12MB8165.namprd12.prod.outlook.com
 ([fe80::1499:6598:d339:f12e%5]) with mapi id 15.20.9769.015; Mon, 6 Apr 2026
 04:19:37 +0000
From: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Ramalingeswara Reddy, Kanala"
 <Kanala.RamalingeswaraReddy@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Use SMUIO 15.0.0 offsets for TSC upper and
 lower count.
Thread-Topic: [PATCH] drm/amdgpu: Use SMUIO 15.0.0 offsets for TSC upper and
 lower count.
Thread-Index: AQHcwRQh1PEAzgwAh0azoDB4dMGXzbXIp2KAgAkrfQA=
Date: Mon, 6 Apr 2026 04:19:37 +0000
Message-ID: <SJ0PR12MB81653E7EC2F2BFF1BC3B5924805DA@SJ0PR12MB8165.namprd12.prod.outlook.com>
References: <20260331134129.1688799-1-Kanala.RamalingeswaraReddy@amd.com>
 <CADnq5_NCdRSOAYuS29ny5A1TN9qzt0oPG0AtC2TeLDFKJ47P3A@mail.gmail.com>
In-Reply-To: <CADnq5_NCdRSOAYuS29ny5A1TN9qzt0oPG0AtC2TeLDFKJ47P3A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: SJ0PR12MB8165.namprd12.prod.outlook.com
 (15.20.9769.015)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8165:EE_|SA1PR12MB7149:EE_
x-ms-office365-filtering-correlation-id: b963238e-27c4-4c89-26ca-08de9393b6f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: HYwIh66CjLKCn0Mgn0jMCjLAMuy4toX2tafjJFUYOMoUp26mTYH6TQzZA6Mzi+RouyZRUpyjupSB8AbsD4j2T9ULqGUH92RoUwgFybc3rIuEHOxMLe9szyVqe2qahpshg5AxcQ+XlxJ4DoiRpduYC9Iuf/PgMQ2Fotgtn0AJ5ZuupDZkWaqrwTTVuEtcu6KU0ZeNUf3vJNf2q9Kbq0nAAEq/a5Gg1ucTb37jd38XIPFkSFGeLMSRnftLLfHvZZdwJXv0VaPe2Xg4L6crVsB6fgZYi8W7mCEA8rwGtC3NbsksHCLUx4MZzfM1lGJyxXOHz0mLO2ZyoKg+4zWGJn6c//3LmUSYgn/4KprHBn/3bbFpSisHXHAlNmJmofSdWtTS3W8DReW38CiQaqCuu10PENXeuWGDpOIzbcRWY3pywP0FEpP4YYPYIceQpkY9hJzo79dN3PVSKIDpBpp73aoMik+r+UlzHDQW0ZEtarQBFD+lJJMUEtNc9dw7bYdui7j/nC/N3n8g/QwKvWpEGqOwlPQA3VtpbJ0ZUJybSIMakr66OWmk05HkSvyuHH/5eXbZ/bqW8D9GZ2N+lMEVKNVHcgFEuHqxHVjgUaYhFx6do3ce3HkpLonh5f7xsc4wImOYcabxPY8KzAIHKqKZcmn+BskgUbqgpFcuxr5m14jJPIzcLHLKSczAh1DT4A1jdBVJeDoA8GFu3O5irsEOUyJoYydkKPOwiZvIToIB98HjN2OSz44OVUKQfjwoU5UsZ/VzhqlFioIdYPjA3G5dZdmrM04JPIK3Ae9nqk0BoKGQ2wg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3Jkc2VleXJmVGsrc0hJZitVdzdXM0svNU54NHhHSkNiZFJxWlhIQXFKYTNT?=
 =?utf-8?B?N1pMdFNPWFdzTjFJNWdoMUQvQUU5RTk5a0pmKzdyZW9VZWpBa3dNSWcwLzZF?=
 =?utf-8?B?a1V3RHZpdktRS3IvMGJoMzdGYSsxOWtNS0J0Q1VERGNXNmhlTTFHYWdEeFRk?=
 =?utf-8?B?WVhSRVI3VG5ETFo0UlBZay9zNWhXRXVaaWtjQUJrTUZGUjA3OU1tbzRZTCtI?=
 =?utf-8?B?WU4rUGhOa05OVVBhTWxvQ09NLzFmMFVpamtXN3QwN2JzSXgvOEtJSlM3RG9w?=
 =?utf-8?B?WXk1cFFMQkdTVVRqdUhleUZ1ODRGWkhzUjhWc1VZWjJuT3IvdU9TYTE5K0lL?=
 =?utf-8?B?T2FEWVFtSUs0d3crcWNxWjQ3azl6dEY1aEhBa3NkY1hjUmpVZzFxRkZQalB1?=
 =?utf-8?B?MUYrek5qOFkxcldCOWRLQXhlbmJQOVd6SGZodUswRjVBcWRnZ2FFdFFSRDRK?=
 =?utf-8?B?VHp3TGJVVkR5cG5SRzNvKzdod0JFeXAyUWtMVE0rK2RGbTh5VUhpY2RjVE9p?=
 =?utf-8?B?N3ZxM0I0ZlhjYk1lSkN2aTdTYjRNS1dJa3ZKK3Fsc0NsQ05XTU9FTkJFK0JS?=
 =?utf-8?B?dTdYSHd4Yjl5QklQZXRvaWdFNGtLV3d4dHA2aUpLT1dNdGRNN00xUk5LL3dv?=
 =?utf-8?B?QmYzK2pkOXhzQUV6VnFJWXN2SEl1dmVFQzZjaHdjZElrdVdCczIzSVBraGZ5?=
 =?utf-8?B?QzYwalYra2dKbTBpZG1BSEdZcGpkOUtCZDNqTk4rVjdsMzV0eVBpbkNGQjVO?=
 =?utf-8?B?SnYzU2VWYy9nbGxqNjFBSE9DUHlJVWxCUzZBcnZtYWRvREdRcE9JVk5QbVNS?=
 =?utf-8?B?OEkvOGpYWTNoSEx0ODI0Q3ZpL1phOGY2RjZwWlhwbmJWdEdjbUwyems4ak1n?=
 =?utf-8?B?VGtLb2E0c2RPeWE3MjE2ZzFEMnRGcmdVcjBCQWNxRHpQUThZYVRKR3Jram9k?=
 =?utf-8?B?RUJxc2QyZlNlMDhLRmwvdUdWdkZGOEtFRDlJN0JFNkl2empVc2Z0TG9KSnZP?=
 =?utf-8?B?Z3c1M1gvSUV6VDJKdXRtdHhGU2d0TXpCdU04c09nczYvV1JxQ1RqNE5qNmtK?=
 =?utf-8?B?SU9sRjZ1dm0xRWRSNE5ML1RWOEx2OEwxL2txYjBFOXRPMUlZY0NZWlBkYUZJ?=
 =?utf-8?B?aU5CNkR6Mkp6N2Z0REo4czFJekJtTkV4TXVLenF3S2hkblJ1cDZnQTNoSFZV?=
 =?utf-8?B?L3dnZlp0TGIxcTkzSi9XMWxIb2c1KytDZkV3LzhGdVV3Uk1sQS9ZbnlCbjRl?=
 =?utf-8?B?amhtclViejBPSEh4YVNBeHY2NnlvejRhc0gyNWRsQ2k3MlYyejlQVUY0T2Fw?=
 =?utf-8?B?WFhBUXIvM0lGM3ZqRkFSK1lnVlN5VWo3ZVpTaDlLaVhEL0FDN012VFl1bnpH?=
 =?utf-8?B?ZUxHbm0wOXBpWkVNUm40eHJxeUZ5VkkxRXVURmd6U1ZtMkJBQlZ6ZE0wTDlY?=
 =?utf-8?B?a1dOc1dGVlBJZGZ3dksvUTcxOHQ4L05xdzRpV1hMT3cyU0xVcGlWVVFFRVBm?=
 =?utf-8?B?K281NEUrWTVlcmZ6Y0FKSG1XTi9naHdZdWQ0amR5Z1owZ09Nam54RUhTOXU4?=
 =?utf-8?B?SWJlcmVIQjM1UStPY3piMWx6WjlKRlh1MXMyN0NRalFuRVhOWTBTKzVsZWFE?=
 =?utf-8?B?UlBkckdGMHRzalBlaUdEbHNnK3RwT25OR2NFbXNXUlcyYmV2YTVTK21mbWZD?=
 =?utf-8?B?S290NWVoalROUHduaDVtYS8zR0IrMXZHeTdxV0pyb1F5aURLd2JhRHdVK3Ns?=
 =?utf-8?B?Rk1xWVZyaXlOUEZZSTErWkZZMVRielZTdTZJeXBJcnV3WnpvUjU2ZVc0SzNy?=
 =?utf-8?B?Z1lKZDJYUy91ZmFUNUNBbnp4aUFDWksyWHFoTmVkWmlQSzUrSkdkSWJkbUF3?=
 =?utf-8?B?R0x5blVIM2ZZcEZQenhuWHpoVXpWVFAxQnZ5TEpXdmMyNmVZSnBzcHZYVDVB?=
 =?utf-8?B?UzAvK3R5WHZBN0J6VFNPeHJJU3I4RHlySHk5cFRXNTRxLzZoQkhTSGZuSXpx?=
 =?utf-8?B?TW1nQWdNdjh6RlZIbGc4aW9BM0h3VGIwNjljSTZzb0UwcE12bGxwL08xaDM0?=
 =?utf-8?B?bktQNlFsY3hWamErZzREWjl5SFZoNFhPMUxuUVJpajdidEZDbWw2YnpXRlNw?=
 =?utf-8?B?T1gySnRkcE1ZVHhtQmFiSnFNY2srU1hoaUZ6Z3o3Q05YOEU5NFNGajRSRzUx?=
 =?utf-8?B?K0M1ck5XV0RqNTJOWUthL1NtRlIyalY0bEZGMG1ic0pWZjVwUTZUVmpBeXUr?=
 =?utf-8?B?Ym5jWjRzRWdEZytQOVlZb3VDTXZTc1ZtYm01aTd5VHNZeHZwRkNvcUdJVWZy?=
 =?utf-8?Q?OMBTh29BLtWeCvnevP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BD3B24E6A0E824F90BA2440CA0DF677@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b963238e-27c4-4c89-26ca-08de9393b6f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 04:19:37.1585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5CMZzparPLJhhXuK4muCTTHHZ89DcL/OQX8mu2TGm9lD2JDJzjPEvya+KzLS8S6bTDSeX/JXksJhD/WRiwEHfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149
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

DQpPbiAzMS0wMy0yMDI2IDE5OjE2LCBBbGV4IERldWNoZXIgd3JvdGU6DQo+IE9uIFR1ZSwgTWFy
IDMxLCAyMDI2IGF0IDk6NDHigK9BTSBSYW1hbGluZ2Vzd2FyYSBSZWRkeSwgS2FuYWxhDQo+IDxL
YW5hbGEuUmFtYWxpbmdlc3dhcmFSZWRkeUBhbWQuY29tPiB3cm90ZToNCj4+IERlZmluZSBhbmQg
dXNlIHJlZ0dPTERFTl9UU0NfQ09VTlRfVVBQRVJfc211XzE1XzBfMCBhbmQNCj4+IHJlZ0dPTERF
Tl9UU0NfQ09VTlRfTE9XRVJfc211XzE1XzBfMCBmb3IgVFNDIHVwcGVyIGFuZCBsb3dlciBjb3Vu
dC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBSYW1hbGluZ2Vzd2FyYSBSZWRkeSwgS2FuYWxhIDxL
YW5hbGEuUmFtYWxpbmdlc3dhcmFSZWRkeUBhbWQuY29tPg0KPiBBY2tlZC1ieTogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KUmV2aWV3ZWQtYnk6IFByYXRpayBWaXNo
d2FrYXJtYSA8UHJhdGlrLlZpc2h3YWthcm1hQGFtZC5jb20+DQo+DQo+PiAtLS0NCj4+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMgfCAzMSArKysrKysrKysrKysrKysr
KysrKystLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3YxMV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjExXzAuYw0KPj4g
aW5kZXggYWUzOWI5ZTFmN2Q2Li5hNDA0NzlmYjAwZjkgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjExXzAuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMNCj4+IEBAIC02NCw2ICs2NCwxMSBAQA0KPj4gICAjZGVm
aW5lIHJlZ1BDX0NPTkZJR19DTlRMXzEgICAgICAgICAgICAweDE5NGQNCj4+ICAgI2RlZmluZSBy
ZWdQQ19DT05GSUdfQ05UTF8xX0JBU0VfSURYICAgMQ0KPj4NCj4+ICsjZGVmaW5lIHJlZ0dPTERF
Tl9UU0NfQ09VTlRfVVBQRVJfc211XzE1XzBfMCAgICAgICAgICAgICAgIDB4MDAzMA0KPj4gKyNk
ZWZpbmUgcmVnR09MREVOX1RTQ19DT1VOVF9VUFBFUl9zbXVfMTVfMF8wX0JBU0VfSURYICAgICAg
MQ0KPj4gKyNkZWZpbmUgcmVnR09MREVOX1RTQ19DT1VOVF9MT1dFUl9zbXVfMTVfMF8wICAgICAg
ICAgICAgICAgMHgwMDMxDQo+PiArI2RlZmluZSByZWdHT0xERU5fVFNDX0NPVU5UX0xPV0VSX3Nt
dV8xNV8wXzBfQkFTRV9JRFggICAgICAxDQo+PiArDQo+PiAgICNkZWZpbmUgcmVnQ1BfR0ZYX01R
RF9DT05UUk9MX0RFRkFVTFQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAweDAwMDAwMTAwDQo+PiAgICNkZWZpbmUgcmVnQ1BfR0ZYX0hRRF9WTUlEX0RFRkFVTFQg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDAwMDAwMDAw
DQo+PiAgICNkZWZpbmUgcmVnQ1BfR0ZYX0hRRF9RVUVVRV9QUklPUklUWV9ERUZBVUxUICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDAwMDAwMDAwDQo+PiBAQCAtNTIzNCwx
MSArNTIzOSwyNyBAQCBzdGF0aWMgdWludDY0X3QgZ2Z4X3YxMV8wX2dldF9ncHVfY2xvY2tfY291
bnRlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+ICAgICAgICAgICAgICAgICAgYW1k
Z3B1X2dmeF9vZmZfY3RybChhZGV2LCB0cnVlKTsNCj4+ICAgICAgICAgIH0gZWxzZSB7DQo+PiAg
ICAgICAgICAgICAgICAgIHByZWVtcHRfZGlzYWJsZSgpOw0KPj4gLSAgICAgICAgICAgICAgIGNs
b2NrX2NvdW50ZXJfaGlfcHJlID0gKHVpbnQ2NF90KVJSRUczMl9TT0MxNShTTVVJTywgMCwgcmVn
R09MREVOX1RTQ19DT1VOVF9VUFBFUik7DQo+PiAtICAgICAgICAgICAgICAgY2xvY2tfY291bnRl
cl9sbyA9ICh1aW50NjRfdClSUkVHMzJfU09DMTUoU01VSU8sIDAsIHJlZ0dPTERFTl9UU0NfQ09V
TlRfTE9XRVIpOw0KPj4gLSAgICAgICAgICAgICAgIGNsb2NrX2NvdW50ZXJfaGlfYWZ0ZXIgPSAo
dWludDY0X3QpUlJFRzMyX1NPQzE1KFNNVUlPLCAwLCByZWdHT0xERU5fVFNDX0NPVU5UX1VQUEVS
KTsNCj4+IC0gICAgICAgICAgICAgICBpZiAoY2xvY2tfY291bnRlcl9oaV9wcmUgIT0gY2xvY2tf
Y291bnRlcl9oaV9hZnRlcikNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgIGNsb2NrX2NvdW50
ZXJfbG8gPSAodWludDY0X3QpUlJFRzMyX1NPQzE1KFNNVUlPLCAwLCByZWdHT0xERU5fVFNDX0NP
VU5UX0xPV0VSKTsNCj4+ICsgICAgICAgICAgICAgICBpZiAoYW1kZ3B1X2lwX3ZlcnNpb24oYWRl
diwgU01VSU9fSFdJUCwgMCkgPCBJUF9WRVJTSU9OKDE1LCAwLCAwKSkgew0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgY2xvY2tfY291bnRlcl9oaV9wcmUgPSAodWludDY0X3QpUlJFRzMyX1NP
QzE1KFNNVUlPLCAwLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJlZ0dPTERFTl9UU0NfQ09VTlRfVVBQRVIpOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
Y2xvY2tfY291bnRlcl9sbyA9ICh1aW50NjRfdClSUkVHMzJfU09DMTUoU01VSU8sIDAsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnR09MREVOX1RTQ19DT1VO
VF9MT1dFUik7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBjbG9ja19jb3VudGVyX2hpX2Fm
dGVyID0gKHVpbnQ2NF90KVJSRUczMl9TT0MxNShTTVVJTywgMCwNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICByZWdHT0xERU5fVFNDX0NPVU5UX1VQUEVSKTsNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChjbG9ja19jb3VudGVyX2hpX3ByZSAhPSBjbG9j
a19jb3VudGVyX2hpX2FmdGVyKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
bG9ja19jb3VudGVyX2xvID0gKHVpbnQ2NF90KVJSRUczMl9TT0MxNShTTVVJTywgMCwNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ0dPTERFTl9U
U0NfQ09VTlRfTE9XRVIpOw0KPj4gKyAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+PiArICAgICAg
ICAgICAgICAgICAgICAgICBjbG9ja19jb3VudGVyX2hpX3ByZSA9ICh1aW50NjRfdClSUkVHMzJf
U09DMTUoU01VSU8sIDAsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmVnR09MREVOX1RTQ19DT1VOVF9VUFBFUl9zbXVfMTVfMF8wKTsNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGNsb2NrX2NvdW50ZXJfbG8gPSAodWludDY0X3QpUlJFRzMyX1NPQzE1KFNN
VUlPLCAwLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ0dP
TERFTl9UU0NfQ09VTlRfTE9XRVJfc211XzE1XzBfMCk7DQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICBjbG9ja19jb3VudGVyX2hpX2FmdGVyID0gKHVpbnQ2NF90KVJSRUczMl9TT0MxNShTTVVJ
TywgMCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWdHT0xE
RU5fVFNDX0NPVU5UX1VQUEVSX3NtdV8xNV8wXzApOw0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKGNsb2NrX2NvdW50ZXJfaGlfcHJlICE9IGNsb2NrX2NvdW50ZXJfaGlfYWZ0ZXIpDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrX2NvdW50ZXJfbG8gPSAodWlu
dDY0X3QpUlJFRzMyX1NPQzE1KFNNVUlPLCAwLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcmVnR09MREVOX1RTQ19DT1VOVF9MT1dFUl9zbXVfMTVf
MF8wKTsNCj4+ICsgICAgICAgICAgICAgICB9DQo+PiAgICAgICAgICAgICAgICAgIHByZWVtcHRf
ZW5hYmxlKCk7DQo+PiAgICAgICAgICB9DQo+PiAgICAgICAgICBjbG9jayA9IGNsb2NrX2NvdW50
ZXJfbG8gfCAoY2xvY2tfY291bnRlcl9oaV9hZnRlciA8PCAzMlVMTCk7DQo+PiAtLQ0KPj4gMi41
My4wDQo+Pg0K
