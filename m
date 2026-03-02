Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293CFD58E5D
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 06:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C005F10E198;
	Mon,  2 Mar 2026 06:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="svRihSQ0";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5398C10E198
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 06:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSYM1Vgl62/YkrqBflhq9LE9w/cjNw8G5ul3fVx/QMgiGZRqJCWMtw7XSjW3Zwsv9i+TdThYg5B3DcxUWZVZauivBGKxpr8I6VaUkVL7IeBLtvGoC7PhJIlRjPMY7H0apqDGpGepthKWLhw4KyCmnPL2+xB5w1JMU5NBEBMKrP+qYF2r7305IOn26KE2zsbAD1v6ZKK7nrYldthvCF4ovwJGevhEiDVX3CtdsCxq5TX1kOpbU6eD5HYic6hBFBUpF6PQri2L8SNYdOhJS6rjSb6Btos693S5ER+noxDqRyuQb3yCq1HTEUJoKk2EEKKgnWA8QReNNBVjm/plNGmeXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtHg+hSnLXEN/Jhn46tHH2vJkkUmF2N3bUfgIcFeqYw=;
 b=WF+CW8+/Cjr7FfrPhnH6bVuqiLJRHjWp3C8qzuX7FnpBdjUQpTCDWX2LrxfgseVEJJHQvZ+Yddr2CjESj6GFtbKmUuZ897JGp/kIbZMxlZBJFqLb0JrftPgIphxp/xvTrtA9P7C66rIXS1D6nKFkuj8iqJ7lYJn0xj3NihsqwhJrgjfDl40SSYEa+ycrdwjxA9OU1vqSRH/gXzJUWtVhGwLucCQMAB+DIZR3L9KaJUBIEwtZe5HO3eITQSjjtmQp9YUM2Y18uE+Otl7CZu05usmGV5MwFn45IyozWo/+4L5cP0/XE7uzkd0Z1VzJgTi69F9b9Q+kXsG8S5EBG7b/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtHg+hSnLXEN/Jhn46tHH2vJkkUmF2N3bUfgIcFeqYw=;
 b=svRihSQ0+REtSDbmV0jq1AkYX4uodNuPDkwnMNpBGlwNg7Pwm9jPB48k/JidqwqiFNSukTS/qoVJ2QdsCUOkKs1pi7LfAzDWcLqw2a607DvmXwavFZ+E0Vm4ECqh7I5t1wmbmXTKzkAL7rZGcfQ3XLyVOllBhoOlE2v8LU+a6p8=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Mon, 2 Mar
 2026 06:28:47 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 06:28:47 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid overflow when sorting pp_feature list
Thread-Topic: [PATCH] drm/amd/pm: Avoid overflow when sorting pp_feature list
Thread-Index: AQHcqguvHpNHzHU9wEe5XUrqdouSibWaxhGAgAAAgRA=
Date: Mon, 2 Mar 2026 06:28:47 +0000
Message-ID: <DM6PR12MB2972453AA557B2E090281111827EA@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260302061242.3062232-1-asad.kamal@amd.com>
 <7e5e915c-1f12-49ac-ae0e-752b5b158e52@amd.com>
In-Reply-To: <7e5e915c-1f12-49ac-ae0e-752b5b158e52@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-02T06:25:15.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|MN2PR12MB4357:EE_
x-ms-office365-filtering-correlation-id: ae9d4cf8-3fc0-4529-1a5e-08de7824f603
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: /ywWdHmsw/xv4mu/cr1tPj/jOV/1+zH0mv8CIkJdF6iPjkjS8Pir07Znx7JGXl6V7UsY7I6znSXNS5acNGxRiz97lzeJeZbcbPW8vE8mU9drNzbRI3AYEaoMmk+R6mYcRO1Iksg8R5Tp3KFt9pbe/ujVC5OR4ddOUp4sKT0DsB2Y3FKqNNWxk4ManNkLPWmPXt9GjRAoe5wcZ2t5ODRRbg91kbK8smmmRRPf52ZhCagQfPIzf3tmKWovUxmR0ddgeufLN1w8V9kIbvX0sfUumAAYSfpZxx2wac5ygHH1OrMqA6b7hbOkAYcuCDx7lcgL7eaugitA9q2Q8HK4ZlU+QQQQ/R/Y/72wlNQG2qNa8DmAZOeZSBfqCVF3CW5j2hk3Qh8S3D4yz6cpPHF7+EPg/oGMEu9jOB01I0Ozxyv25uyIeFFTyP084kI5AkH29HJK2yKn05iKpKG8bYlIM9M2X3jiAXxovHD1IjyPm055UN6C/tYWnzlDhA0YgX0X7IrydH4SkZS6J6Qhdx/VSrWpCWl+htF0jej4Z50rQQY6hD7mQzIGpp9ta2h5QT2BO7lpFE2g9g3PXJJMwe32JF0zILemzvfdMK8KYIIiT0SfSLWGRo2CofUxXymbIHrjHz5sHL/89o55lDVvbae/fVtjVOTddARpTAzLOPrHbRALoCKaBh2yGasZZylabwO1NQm2ZDOH7meVNR3ddTWqHN7Lc6HRopG71K1HB47SK18rKRzcfsRFCs1R8YTY19lXiczeIC/OZtOwzrtLabmcJAb2BzeOCkDbv8SZqmxEHClzDak=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE5VdHNLU2Nhc2JCSmh6Y1VxaFFVY2o2SkJCdWpnTWRvTUFYZFBWRG9xaHlL?=
 =?utf-8?B?RThWWmE2NlVIMWIrSlFLWHBLa1g4elZveEFsTWcyMjZBUEFVeUYwMk56UXpl?=
 =?utf-8?B?OEFZc2IrVERNZll2emtMZWRLOFI2T2h2QktsVkhjZVErbnlSMUQvbWZMcjRW?=
 =?utf-8?B?R2pBK29QRFd3YlJmdFJobjM3RXBLbGlvUWlWdzQrMGppMklMWXJGdFRDVm53?=
 =?utf-8?B?Mmh2SkZ3Q0RLNEJuSUtDekNSU3ZidnlKZ05Rd3dXRXpENmVTWkRWWGVTUDgv?=
 =?utf-8?B?VHhmbFQzaHBReUh1eS83TlhEd0hsY095aFk2cXJacERoTHZ5NERMbnYzWklP?=
 =?utf-8?B?eXhRSkNXeU03TEdEYkZEK3hxNGttTS9oTUlaUHR3K0pSRFY4aG1NbDZqWFhm?=
 =?utf-8?B?NEtCdjQrTFl5WGc4bVlMekZuWjNpMFZSeEVFMkx6WEg3eC9PUXRJTXVyNk5Y?=
 =?utf-8?B?N1JmekNkWjhMODRrcDRQY3BuNnVtTVFkMFJQcEF1NGJPOW5YYzFoN1hManhr?=
 =?utf-8?B?SDYwVy9lUE12OVpsTDNhckV4aHRtcG4zb2FlTXNFLzJmV3hYVGp4djN6RSs4?=
 =?utf-8?B?SjlKTFhIRmovbUZHY2dvVzMzODQrd3Y2RE5SYktTL05Na3pjbjFIV0ZKWVpu?=
 =?utf-8?B?dHNvSzRVdmVudTFYOEl2cGk3OTRRVHVPV3BIektxWHpkRUhTRHZSWi9IbjNl?=
 =?utf-8?B?TlQxYzhoQ0NRbFd4a1YxMnF6TEllSjVxbmtQTXpLRGM3cmh3czIzcEZWWWlF?=
 =?utf-8?B?UDk5aXRzQ2puKzY0Q3JMVGxqM2RYOXRjRW1WNkhRM250djRBL1VLT2VBZGxX?=
 =?utf-8?B?d3V1a241UVNLU3NLQ1dSemNzL3NHYThQR29PQkdkYXFCM3NLcmY3RTU2K3Zo?=
 =?utf-8?B?RU93eEhwb3gwNmJTUEJSc0VVendRbzM0LzBrY1Ztdk1xbjZHaGpZZ1pTS21K?=
 =?utf-8?B?QWp4L1JKZi9yY3VaejZTeW83QTdTcytnR1BGeTJ1RzBBb3JwTWRmKzM3Wi8x?=
 =?utf-8?B?bTlITXBPaWVHdmdKL1BnOXlicWdnbjVFMHdlSVNTa3IxTzVtWXhLcVpXRUho?=
 =?utf-8?B?U3lsck9ZenlSVURLQmF3cHJrYy92VWovQitiV29zV1BwT1RGWWp0RGVZczZS?=
 =?utf-8?B?eEJnS0I5cUQxUjE2MG1OaXBNdnNlTGM2V0ZQL1l5MUkyM3hreWtRYnBSN0do?=
 =?utf-8?B?b083YzRlYTF0Yzg2SHoyWEVrTjBrai85Sk1iOGRPcVNNV0c5dUVsaUlKTjRj?=
 =?utf-8?B?QTBsK0JpdThpSjQrT3ZnaStkNlhnRjBsYmhzMEUzWU5sRDdrdzBrNDd5TkF0?=
 =?utf-8?B?bGVLR050RnlPZGhCQWMrVVozVGowenZnWGxFNHEwc2xNVlJyenM1aFgxUGla?=
 =?utf-8?B?K1BmbTdibldFZDJmYWIvRGpIclVSaXdQaUZFbE5NdVA3L0cyOFVDS1RSbWZY?=
 =?utf-8?B?WUJWTXJxYWNJMTAwdVlQbHNZUWltbHVGdnpuWG1ITFJ0S0IxTktxOUVPSHpZ?=
 =?utf-8?B?aTRGWDE2eGFNTm1oTHlzak1CbmpBTzRoZytrMy9PUDYrWXcvd3lGNmZpYTlI?=
 =?utf-8?B?VVhCZ0pSMjJET1BhZ05IUW1NWVUzNWNkQXBXUjY1eTRnY0VZV0pyKytGQmFK?=
 =?utf-8?B?RUI2bU9JY0Y3UTl2L2srci8ydXVwZ3ViM1dBL0tiS2hCQ1d5OWRWN3JFdVhW?=
 =?utf-8?B?SjdOZEFXVWd6bnFIV1kzVDR0Ym5ITWVWMXFBQWdTbkJGREpNa3JvSUlIWXN6?=
 =?utf-8?B?OTJqRmpDZFpFMjBPdlNpNmYzL2FTZzZJRjN5VFc3MG9rd08rWi82WDZ4T0RC?=
 =?utf-8?B?YXlyTDQ3QXlmVUdHYjNsRnpZckh3bU1ZUWNOVFZZYi9YVGdoOXl6VnZjNTAz?=
 =?utf-8?B?Rys2VjNyNGJ4cVBzSnNMVDRGNXhEU2NjOW5oYXl4bkR3dEV6dDZUSGxrVE5C?=
 =?utf-8?B?SmlidDJzTUVZNWxoN3BSUHJXVlZZUDFGTTc1MTNlWndrMVFvU3Jickx0a1g3?=
 =?utf-8?B?V3Z3a2dqMTdtMURPYyszc1VsNDkyWlYrR1FQVmJHajdkc3puaGIyQ0V4VGls?=
 =?utf-8?B?MVVEdWcrT3ZscDJjM1pqWmpSYW9qYkNLeVhDUkRzWUFVNm5CdVExcG1nVFdm?=
 =?utf-8?B?MEJyWFRPNW1pNGdPUmNxcnd5Z2l3TERmVEs1VXpGMDVDTmtsYUFMN3h2MlQr?=
 =?utf-8?B?ZjV6VE1yUi9UR1cyeXJ4NHVQV0Ewa1hPcG9GcTdpQ2V3YTFTampudmpFZ1dZ?=
 =?utf-8?B?aUEzdmhIY1VqSW1SRXl6bVIzeEptc3d2RkM4RnAvcCt6M3EzTlRrcDN5WVdT?=
 =?utf-8?Q?caIlkFcbTs7xtejXVi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9d4cf8-3fc0-4529-1a5e-08de7824f603
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 06:28:47.4616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xsAowue3RpttMMr1VLx+KoA/jhY9KY4Xp566M16tyBjqXZ8VYThTzQvGVdLKnfZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPj4gbWVtc2V0KHNvcnRfZmVhdHVyZSwgLTEsIHNpemVvZihzb3J0X2ZlYXR1cmUpKTsNCi4u
Lg0KPj4gaWYgKHNvcnRfZmVhdHVyZVtmZWF0dXJlX2luZGV4XSA8IDApDQogICAgICBjb250aW51
ZTsNCg0KV2hlbiB0aGUgYXJyYXkgdHlwZSBpcyBjaGFuZ2VkIGZyb20gaW50OF90IHRvIGludDE2
X3QsIHRoZSBjb2RlIGxvZ2ljIG9mIHRoaXMgbWVtc2V0KCkgbWF5IG5vdCBjb3JyZWN0bHkgaW5p
dGlhbGl6ZSBhbGwgZWxlbWVudHMgdG8gJy0xJy4NClBsZWFzZSBtb2RpZnkgdGhpcyBjb2RlIHRv
Z2V0aGVyIHRvIGVuc3VyZSB0aGF0IHRoZSBzdWJzZXF1ZW50IGNvZGUgbG9naWMgbWVldHMgZXhw
ZWN0YXRpb25zLg0KDQpCZXN0IFJlZ2FyZHMsDQpLZXZpbg0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NClNlbnQ6IE1v
bmRheSwgTWFyY2ggMiwgMjAyNiAyOjIzIFBNDQpUbzogS2FtYWwsIEFzYWQgPEFzYWQuS2FtYWxA
YW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogWmhhbmcsIEhhd2tp
bmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IE1hLCBMZSA8TGUuTWFAYW1kLmNvbT47IFpoYW5n
LCBNb3JyaXMgPFNoaXd1LlpoYW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldhbmdA
YW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvcG06IEF2b2lkIG92ZXJmbG93
IHdoZW4gc29ydGluZyBwcF9mZWF0dXJlIGxpc3QNCg0KDQoNCk9uIDAyLU1hci0yNiAxMTo0MiBB
TSwgQXNhZCBLYW1hbCB3cm90ZToNCj4gcHBfZmVhdHVyZXMgc29ydGluZyB1c2VzIGludDhfdCBz
b3J0X2ZlYXR1cmVbXSB0byBzdG9yZSBkcml2ZXIgZmVhdHVyZQ0KPiBlbnVtIGluZGljZXMuIE9u
IG5ld2VyIEFTSUNzIHRoZSBlbnVtIGluZGV4IGNhbiBleGNlZWQgMTI3LCBjYXVzaW5nDQo+IHNp
Z25lZCBvdmVyZmxvdyBhbmQgc2lsZW50bHkgZHJvcHBpbmcgZW50cmllcyBmcm9tIHRoZSBvdXRw
dXQuDQo+IFN3aXRjaCB0aGUgYXJyYXkgdG8gaW50MTZfdCBzbyBhbGwgZW51bSBpbmRpY2VzIGFy
ZSBwcmVzZXJ2ZWQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFzYWQgS2FtYWwgPGFzYWQua2FtYWxA
YW1kLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IExpam8gTGF6YXIgPGxpam8ubGF6YXJAYW1kLmNvbT4N
Cg0KVGhhbmtzLA0KTGlqbw0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dz
bXUvc211X2Ntbi5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9z
d3NtdS9zbXVfY21uLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4u
Yw0KPiBpbmRleCBjNDcxYzBlMmNiZDEuLjMyNmM4NmI5MjBhMiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMNCj4gQEAgLTg4MCw3ICs4ODAsNyBAQCBzdGF0aWMg
Y29uc3QgY2hhciAqc211X2dldF9mZWF0dXJlX25hbWUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUs
DQo+ICAgc2l6ZV90IHNtdV9jbW5fZ2V0X3BwX2ZlYXR1cmVfbWFzayhzdHJ1Y3Qgc211X2NvbnRl
eHQgKnNtdSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2hhciAqYnVmKQ0K
PiAgIHsNCj4gLSAgICAgaW50OF90IHNvcnRfZmVhdHVyZVtNQVgoU01VX0ZFQVRVUkVfQ09VTlQs
IFNNVV9GRUFUVVJFX01BWCldOw0KPiArICAgICBpbnQxNl90IHNvcnRfZmVhdHVyZVtNQVgoU01V
X0ZFQVRVUkVfQ09VTlQsIFNNVV9GRUFUVVJFX01BWCldOw0KPiAgICAgICBzdHJ1Y3Qgc211X2Zl
YXR1cmVfYml0cyBmZWF0dXJlX21hc2s7DQo+ICAgICAgIHVpbnQzMl90IGZlYXR1cmVzWzJdOw0K
PiAgICAgICBpbnQgaSwgZmVhdHVyZV9pbmRleDsNCg0K
