Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C979DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 02:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84C636162E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 02:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 84C636162E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34EDF6EB35;
	Thu, 30 Sep 2021 02:38:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D97D6E2D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 02:38:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUv+hktmE9RPkdOL9TiLirzA6T7jdjmo0QOVh9/Y5AyG7o+lJacFwlgN7NGRxt5zYgfl4WCArhGCzLNU8CoVcPbP7fKHYIibCvc+Vvoo2jXuCPJVk+Ob9Kfpgr16LHV/W5zjIE/rL7g6BE22TpspZlmKaPqWvDpaGiSltzUzwZ1o1zmjzVTCv/a6ER0F5SyfZrK2WLTWtN9PnuxEBceb/nohqatXjh5n8irGXxgIuMZkOoXrekMNqQMHEd9rDe1BZ/OhMFPnPPrkOwZ1Joh4h88XPha6ZCU3iSi+b5F+GgKSbkqM//S7gukNdKy2gZPIrt8WV0F8DejmPJs2EGjkiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=6UZrmuRnugV4KkO6meMQ1o+uyoMY2/J/HQ2B5VBFoTk=;
 b=ds84jmFzAgZ7hroUx28A1AWKbbuSDG8TyRL6ViuFnNu9AzbdFiKzaev4n0b4NttHiphYdeQsCLMF3oxUPJW0/8FeB76HK5deUviwI+Tkk52cI11VZqtEppTsIVgG/anKYl5lwMZBdiDzuWPRJwun84a+W3UtcsjdmcoWJ7F0t3/2zFe3FYqy0KMzdTTPlJ8R+YKl1DZVTWVe0JcCVCc5aMi+IkPMF9Z0AyUI0g8YUj9c1PzvclRyuQOJkm+5VBmvqSu2Jvw8W5BSbbR4RrLjHtKUiZQ2CccDLWMk7KzJF/QPo48CqwFiaR7LdpheL/pFWfwfAO3c4e59Fgj0u3l+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UZrmuRnugV4KkO6meMQ1o+uyoMY2/J/HQ2B5VBFoTk=;
 b=OedrHhiq4Vj/bUB9rlb7+WJJcCT/5svgDZtJBmwaaTW5glyWiAsjvJ15iJ0+4MaPt1cV9LbA31ZCDZEToU+rC25JljyYoudLT1A0g/q+XGSIE3yo+IYUdSylzSfoUdYV1FBmo1UvgTJI82P0g8+Cx/lnwHk7AVjseu2MKEQ428Q=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR1201MB0202.namprd12.prod.outlook.com (2603:10b6:4:4d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Thu, 30 Sep 2021 02:38:40 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4566.015; Thu, 30 Sep 2021
 02:38:39 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix a potential cu_mask memory leak
Thread-Topic: [PATCH] drm/amdkfd: fix a potential cu_mask memory leak
Thread-Index: AQHXtQsmKTKeWYk0oU2s3x4JTRfj6au7IiqAgACGfTCAACdoAIAABimwgAAFYwCAAADfkA==
Date: Thu, 30 Sep 2021 02:38:39 +0000
Message-ID: <DM6PR12MB425032636CE5A8303F1E481EFBAA9@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210929082212.1806312-1-lang.yu@amd.com>
 <2ccb1777-ca8e-5a39-5311-3262c1cba608@amd.com>
 <DM6PR12MB425096E4B53642BEA55FDE25FBA99@DM6PR12MB4250.namprd12.prod.outlook.com>
 <10d28f06-42df-6b8e-6e44-a4c85ed92473@amd.com>
 <DM6PR12MB425018180CB2B71C7BBC0134FBAA9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <29e7070d-f36a-a904-e173-0de8a95a7d50@amd.com>
In-Reply-To: <29e7070d-f36a-a904-e173-0de8a95a7d50@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 554b0142-2283-4e34-066a-08d983bb6964
x-ms-traffictypediagnostic: DM5PR1201MB0202:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB02021E4A9FD9A5CE10B2C7D7FBAA9@DM5PR1201MB0202.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RuRknaM00Clq5bO4GUzBhGkAXiNm+wDHzeZZC9MOd1HetQZIOUfQ2AyQHgQOcQpZ20c6i9U76ZDNX9OgXB7YYcBLc5vxHneBna6W1rWuISjybP/EEfaRfcnLVSIy91Mc69gIcv82OKDZN5tlF8S/MTtPjME1KQveukqWsG5+KR+OfVIKJe4NxWh0jBMN6y1ISJlUMtfBKWPFfM0jr7uqTEuymQtgy0D/ABSir1N243FukHKi9uxOnd18cbsvTFm0+tehsxxaEn66Xf4ql8fo3/Ef3BaZhTFOvCV2h68T+902iTKk/jEtrsPkUrF/0m3p/9hvyCmFTYGKg0iijW/bhMDfJInmLrqrx8v7WlBfeW3hqPx+nEqB2HIEuJqE1a/QuA4wA2kjbd1TkSS6MnqQHjkf8sur2h5ueQ3ULfkBVtWyH+IEJGsikLf1Y3ipxYY+gUp8MGFldzLQA0B8Lf59qlEanPya69YgSfOiRtLt7r/rlD8iPc2olI4UWjoxZKG0tesF89ZN1CNJ7cfCbkYkZ7cb4kSiZ9i4VL7f9ZGxNtmvHB0CQUbbpWh/hnEYBdMdP6lE8dSvPD2nU1sm9bpYqvRkpwFibib0KMR0KrdXyjn6C0HnvLswm3Yz4lghCgHEYF9afGMJt8agDQGjVuA5dLKk9H0Wu1qi6UUzm5Cj71W9E1wVBEd0femHyrVapI4akzWJUvz/KyVoAzgEJ0Ii9w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(55016002)(26005)(2906002)(54906003)(33656002)(66946007)(86362001)(76116006)(66446008)(66476007)(38070700005)(71200400001)(64756008)(9686003)(66556008)(110136005)(83380400001)(5660300002)(53546011)(4326008)(52536014)(8936002)(7696005)(8676002)(186003)(38100700002)(122000001)(508600001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmp0aWFNZDM1MnU0MlpWRjIvTCtFcHVucXU0UGZkb3dXNFhUdjYwQitBQWhs?=
 =?utf-8?B?QlNQYmFHVzJ3bnlPM1daaVpLb1ZQUzQ4Qk1xa3RhR2ZQaHZINmR4dENITzJL?=
 =?utf-8?B?UWJKd0RPVDB6d2xnbVRmbjhudlNkMkpsVGV6elJ6MFFJVzJxbk1uM08rcmdB?=
 =?utf-8?B?ZTg4ZGpRWEx2TlBCalV2dGlvbVZJOG0rV2J6dk9sOGdOc0Q4QXRPTW1qdkps?=
 =?utf-8?B?RWpqWmVoQ2VzUnJIS3ZiZ3AvSGxQcnExOTVId3BrT1Buc0FQY2J1d0JKNkdI?=
 =?utf-8?B?aEhQczUxb2VEZG9vOC9yQ1ZqZ0d3dnBhM1F6WENWYm1DaUtXS08yK2dUdDZF?=
 =?utf-8?B?cWVqTmwzWUVzcUVqbHg2T2pEdTNzcEZFRlJYWjJtWjFZNE1VRk9IUmptTmFG?=
 =?utf-8?B?NFdrZGlaWmJHcUlpZWtrdGFjcnQwVFF1ZTRPYk5hRFpPM1RuS1J3TzJNMWo0?=
 =?utf-8?B?ODJBeVQ3SUtlSXkrSlBzdzY5Q2EvdVZwcWpncURXYlRwK2VGN0FPNG1CWUkw?=
 =?utf-8?B?NDcrQ0Fic25wVDVocmgzVkkvK1hiY2hzN1g2ckhhZ2xGVk5tM3pIcy8vU2Nj?=
 =?utf-8?B?MERxd1c1YXRrYTY1ZWlLRjFYR0VrVFFBaTVOZjI2eE12dHRGQ3gxWXdlTy9T?=
 =?utf-8?B?dnYrSWZzbXNEMGZYVWN2NjErYmVsNXFiUU0vN3JmMTh3SmRNcFkxL3UrWXc2?=
 =?utf-8?B?Vmx4TUx0WDRuZlF1K1NOVTJwVFRtSmJjNVM4YTEwYnpSbTBGcVdKdWJMbUI4?=
 =?utf-8?B?bEpKamw4M1lnOEpudW04UmJDMlMzRWxCQU1LQWZrcWg0UEpDTjlicTFWVkZl?=
 =?utf-8?B?WUpPQjhiTlM0SjdZOEJ1V0wyR0QxcnJiUUJ3UDBzYTNqYXdzbUVscG5GaWY4?=
 =?utf-8?B?VEgzbFU1RE16VThPT3ZPK2NKR2pkUmd2QWYwTEVJbklWZm5OMStyZCtOUEpB?=
 =?utf-8?B?VHVIbDBndWNPdUtMRDk0eUluZjFuSjF1aFZ6UVkyZUNZVkI1eGd4Y2pTQXVZ?=
 =?utf-8?B?TUE1TDhPaEJvS1MwYXN1NEc0SndNM201WCtJa3FpQXl3YXNFcUM5UnVtSSsy?=
 =?utf-8?B?aHlvbEk5QmNRaFRpQWMyTnJCN1RLWXhXVE13N1BnL3E5bThoeG9MWndpcnB2?=
 =?utf-8?B?WEJzbHF3a01JUGF4UlZjV0h2aVFjS25NRXkzWnJZVnhHUFY1MnJmUWJiYnUx?=
 =?utf-8?B?bVRNMmxnRFdSTy9PMWdFYVRpQUFwNHp1MHozenFjRDh2b2dJeFFTU1U2QjR6?=
 =?utf-8?B?K29DemFDeHlCQXJTV0dCRjJIbXV2VzBVZE5HRjNTSlBGcnJLSm83SmhSckdX?=
 =?utf-8?B?VU15Y1JJOVVhVWhseThzVG5yRDJOdDd3ODhZVWNjSGx4cjQ0U2xpZC9nYXkv?=
 =?utf-8?B?ODFPYUNOY3hGRVZENzBBRVdsdlFrQlNSbjNwMlJ4WUpLNHlFcnc0WDRmK0tV?=
 =?utf-8?B?RmozQ1RtZDZEaWRNdmdNd0NHcHV1WUxkVStUUDBmNWNDdlVnYW9kaGZXVFBM?=
 =?utf-8?B?bnlpOVVKeVZTZmU3ZVV0aytvMXQ3UFE2MXNZKzZBZkJIdEdZSGdhQUZ6Nk5V?=
 =?utf-8?B?TzRNeThvVUhKUkJCaEtjaVRqWnpXWWhNa2s4MGFJM3h6QzRIVExDeHQwZDEw?=
 =?utf-8?B?UUVZeHdQYXNHeTRHeHhSRjdqQzYvbWVYNmYzYmVBYVY2aHk2T0drdDdlQUFK?=
 =?utf-8?B?am5CMldaNklqYndpeTVKSDB3Qi91ekZDMGpDVU5yZnIzbllQQVVWaG40b0E0?=
 =?utf-8?Q?UG+UNHee0pKYmaYwSvynBHWaoKVvPM4idbG4Wll?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554b0142-2283-4e34-066a-08d983bb6964
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 02:38:39.9553 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06lH74bmHfMKMN7qZO574y30LQMIvXcGz81Kc0Ba55P+SZCxn3q7p+kztxnxAkOKGs239Df3qE+k7Q+NVQStzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0202
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEt1ZWhsaW5nLCBGZWxpeCA8
RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj5TZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDMwLCAy
MDIxIDEwOjI4IEFNDQo+VG86IFl1LCBMYW5nIDxMYW5nLll1QGFtZC5jb20+OyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KPkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgUmF5DQo+PFJheS5IdWFuZ0BhbWQuY29tPg0KPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRrZmQ6IGZpeCBhIHBvdGVudGlhbCBjdV9tYXNrIG1lbW9y
eSBsZWFrDQo+DQo+T24gMjAyMS0wOS0yOSAxMDoyMyBwLm0uLCBZdSwgTGFuZyB3cm90ZToNCj4+
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEt1ZWhsaW5nLCBGZWxpeCA8
RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4+PiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDMw
LCAyMDIxIDk6NDcgQU0NCj4+PiBUbzogWXUsIExhbmcgPExhbmcuWXVAYW1kLmNvbT47IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+Pj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBSYXkNCj4+PiA8UmF5Lkh1YW5nQGFtZC5j
b20+DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGtmZDogZml4IGEgcG90ZW50aWFs
IGN1X21hc2sgbWVtb3J5IGxlYWsNCj4+Pg0KPj4+IE9uIDIwMjEtMDktMjkgNzozMiBwLm0uLCBZ
dSwgTGFuZyB3cm90ZToNCj4+Pj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCj4+Pj4NCj4+Pj4N
Cj4+Pj4NCj4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+PiBGcm9tOiBLdWVo
bGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+Pj4+PiBTZW50OiBXZWRuZXNk
YXksIFNlcHRlbWJlciAyOSwgMjAyMSAxMToyNSBQTQ0KPj4+Pj4gVG86IFl1LCBMYW5nIDxMYW5n
Lll1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPj4+Pj4gQ2M6IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBSYXkN
Cj4+Pj4+IDxSYXkuSHVhbmdAYW1kLmNvbT4NCj4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRy
bS9hbWRrZmQ6IGZpeCBhIHBvdGVudGlhbCBjdV9tYXNrIG1lbW9yeQ0KPj4+Pj4gbGVhaw0KPj4+
Pj4NCj4+Pj4+IEFtIDIwMjEtMDktMjkgdW0gNDoyMiBhLm0uIHNjaHJpZWIgTGFuZyBZdToNCj4+
Pj4+PiBJZiB1c2VyIGRvZXNuJ3QgZXhwbGljaXRseSBjYWxsIGtmZF9pb2N0bF9kZXN0cm95X3F1
ZXVlIHRvIGRlc3Ryb3kNCj4+Pj4+PiBhbGwgY3JlYXRlZCBxdWV1ZXMsIHdoZW4gdGhlIGtmZCBw
cm9jZXNzIGlzIGRlc3Ryb3llZCwgc29tZSBxdWV1ZXMnDQo+Pj4+Pj4gY3VfbWFzayBtZW1vcnkg
YXJlIG5vdCBmcmVlZC4NCj4+Pj4+Pg0KPj4+Pj4+IFRvIGF2b2lkIGZvcmdldHRpbmcgdG8gZnJl
ZSB0aGVtIGluIHNvbWUgcGxhY2VzLCBmcmVlIHRoZW0NCj4+Pj4+PiBpbW1lZGlhdGVseSBhZnRl
ciB1c2UuDQo+Pj4+Pj4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBMYW5nIFl1IDxsYW5nLnl1QGFt
ZC5jb20+DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX2NoYXJkZXYuYyAgICAgICAgICAgICAgIHwgIDggKysrKy0tLS0NCj4+Pj4+PiAgICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzc19xdWV1ZV9tYW5hZ2VyLmMgfCAxMA0K
Pj4+Pj4+ICsrKystLS0tLS0NCj4+Pj4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9u
cygrKSwgMTAgZGVsZXRpb25zKC0pDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYw0KPj4+Pj4+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYw0KPj4+Pj4+IGluZGV4IDRkZTkwN2YzZTY2YS4u
NWMwZTZkY2Y2OTJhIDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9jaGFyZGV2LmMNCj4+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfY2hhcmRldi5jDQo+Pj4+Pj4gQEAgLTQ1MSw4ICs0NTEsOCBAQCBzdGF0aWMgaW50IGtm
ZF9pb2N0bF9zZXRfY3VfbWFzayhzdHJ1Y3QgZmlsZQ0KPj4+Pj4+ICpmaWxwLCBzdHJ1Y3QNCj4+
Pj4+IGtmZF9wcm9jZXNzICpwLA0KPj4+Pj4+ICAgIAlyZXR2YWwgPSBjb3B5X2Zyb21fdXNlcihw
cm9wZXJ0aWVzLmN1X21hc2ssIGN1X21hc2tfcHRyLA0KPj4+Pj4gY3VfbWFza19zaXplKTsNCj4+
Pj4+PiAgICAJaWYgKHJldHZhbCkgew0KPj4+Pj4+ICAgIAkJcHJfZGVidWcoIkNvdWxkIG5vdCBj
b3B5IENVIG1hc2sgZnJvbSB1c2Vyc3BhY2UiKTsNCj4+Pj4+PiAtCQlrZnJlZShwcm9wZXJ0aWVz
LmN1X21hc2spOw0KPj4+Pj4+IC0JCXJldHVybiAtRUZBVUxUOw0KPj4+Pj4+ICsJCXJldHZhbCA9
IC1FRkFVTFQ7DQo+Pj4+Pj4gKwkJZ290byBvdXQ7DQo+Pj4+Pj4gICAgCX0NCj4+Pj4+Pg0KPj4+
Pj4+ICAgIAltdXRleF9sb2NrKCZwLT5tdXRleCk7DQo+Pj4+Pj4gQEAgLTQ2MSw4ICs0NjEsOCBA
QCBzdGF0aWMgaW50IGtmZF9pb2N0bF9zZXRfY3VfbWFzayhzdHJ1Y3QgZmlsZQ0KPj4+Pj4+ICpm
aWxwLCBzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsDQo+Pj4+Pj4NCj4+Pj4+PiAgICAJbXV0ZXhfdW5s
b2NrKCZwLT5tdXRleCk7DQo+Pj4+Pj4NCj4+Pj4+PiAtCWlmIChyZXR2YWwpDQo+Pj4+Pj4gLQkJ
a2ZyZWUocHJvcGVydGllcy5jdV9tYXNrKTsNCj4+Pj4+PiArb3V0Og0KPj4+Pj4+ICsJa2ZyZWUo
cHJvcGVydGllcy5jdV9tYXNrKTsNCj4+Pj4+Pg0KPj4+Pj4+ICAgIAlyZXR1cm4gcmV0dmFsOw0K
Pj4+Pj4+ICAgIH0NCj4+Pj4+PiBkaWZmIC0tZ2l0DQo+Pj4+Pj4gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfcHJvY2Vzc19xdWV1ZV9tYW5hZ2VyLmMNCj4+Pj4+PiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVlX21hbmFnZXIuYw0KPj4+Pj4+IGlu
ZGV4IDI0M2RkMWVmY2RiZi4uNGM4MWQ2OTBmMzFhIDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVlX21hbmFnZXIuYw0KPj4+Pj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVlX21hbmFn
ZXIuYw0KPj4+Pj4+IEBAIC0zOTQsOCArMzk0LDYgQEAgaW50IHBxbV9kZXN0cm95X3F1ZXVlKHN0
cnVjdA0KPj4+Pj4gcHJvY2Vzc19xdWV1ZV9tYW5hZ2VyICpwcW0sIHVuc2lnbmVkIGludCBxaWQp
DQo+Pj4+Pj4gICAgCQkJcGRkLT5xcGQubnVtX2d3cyA9IDA7DQo+Pj4+Pj4gICAgCQl9DQo+Pj4+
Pj4NCj4+Pj4+PiAtCQlrZnJlZShwcW4tPnEtPnByb3BlcnRpZXMuY3VfbWFzayk7DQo+Pj4+Pj4g
LQkJcHFuLT5xLT5wcm9wZXJ0aWVzLmN1X21hc2sgPSBOVUxMOw0KPj4+Pj4+ICAgIAkJdW5pbml0
X3F1ZXVlKHBxbi0+cSk7DQo+Pj4+Pj4gICAgCX0NCj4+Pj4+Pg0KPj4+Pj4+IEBAIC00NDgsMTYg
KzQ0NiwxNiBAQCBpbnQgcHFtX3NldF9jdV9tYXNrKHN0cnVjdA0KPj4+Pj4gcHJvY2Vzc19xdWV1
ZV9tYW5hZ2VyICpwcW0sIHVuc2lnbmVkIGludCBxaWQsDQo+Pj4+Pj4gICAgCQlyZXR1cm4gLUVG
QVVMVDsNCj4+Pj4+PiAgICAJfQ0KPj4+Pj4+DQo+Pj4+Pj4gLQkvKiBGcmVlIHRoZSBvbGQgQ1Ug
bWFzayBtZW1vcnkgaWYgaXQgaXMgYWxyZWFkeSBhbGxvY2F0ZWQsIHRoZW4NCj4+Pj4+PiAtCSAq
IGFsbG9jYXRlIG1lbW9yeSBmb3IgdGhlIG5ldyBDVSBtYXNrLg0KPj4+Pj4+IC0JICovDQo+Pj4+
Pj4gLQlrZnJlZShwcW4tPnEtPnByb3BlcnRpZXMuY3VfbWFzayk7DQo+Pj4+Pj4gKwlXQVJOX09O
X09OQ0UocHFuLT5xLT5wcm9wZXJ0aWVzLmN1X21hc2spOw0KPj4+Pj4+DQo+Pj4+Pj4gICAgCXBx
bi0+cS0+cHJvcGVydGllcy5jdV9tYXNrX2NvdW50ID0gcC0+Y3VfbWFza19jb3VudDsNCj4+Pj4+
PiAgICAJcHFuLT5xLT5wcm9wZXJ0aWVzLmN1X21hc2sgPSBwLT5jdV9tYXNrOw0KPj4+Pj4+DQo+
Pj4+Pj4gICAgCXJldHZhbCA9IHBxbi0+cS0+ZGV2aWNlLT5kcW0tPm9wcy51cGRhdGVfcXVldWUo
cHFuLT5xLQ0KPj5kZXZpY2UtPmRxbSwNCj4+Pj4+PiAgICAJCQkJCQkJcHFuLT5xKTsNCj4+Pj4+
PiArDQo+Pj4+Pj4gKwlwcW4tPnEtPnByb3BlcnRpZXMuY3VfbWFzayA9IE5VTEw7DQo+Pj4+Pj4g
Kw0KPj4+Pj4gVGhpcyB3b24ndCB3b3JrIGNvcnJlY3RseS4gV2UgbmVlZCB0byBzYXZlIHRoZSBj
dV9tYXNrIGZvciBsYXRlci4NCj4+Pj4+IE90aGVyd2lzZSB0aGUgbmV4dCB0aW1lIGRxbS0+b3Bz
LnVwZGF0ZV9xdWV1ZSBpcyBjYWxsZWQsIGZvcg0KPj4+Pj4gZXhhbXBsZSBpbiBwcW1fdXBkYXRl
X3F1ZXVlIG9yIHBxbV9zZXRfZ3dzLCBpdCB3aWxsIHdpcGUgb3V0IHRoZSBDVQ0KPj4+Pj4gbWFz
ayBpbiB0aGUNCj4+PiBNUUQuDQo+Pj4+IExldCdzIGp1c3QgcmV0dXJuIHdoZW4gbWVldGluZyBh
IG51bGwgY3VfbWFzayBpbiB1cGRhdGVfY3VfbWFzaygpIHRvDQo+Pj4+IGF2b2lkDQo+Pj4gdGhh
dC4NCj4+Pj4gTGlrZSBmb2xsb3dpbmcsDQo+Pj4+DQo+Pj4+IHN0YXRpYyB2b2lkIHVwZGF0ZV9j
dV9tYXNrKHN0cnVjdCBtcWRfbWFuYWdlciAqbW0sIHZvaWQgKm1xZCwNCj4+Pj4gCQkJICAgc3Ry
dWN0IHF1ZXVlX3Byb3BlcnRpZXMgKnEpDQo+Pj4+IHsNCj4+Pj4gCXN0cnVjdCB2MTBfY29tcHV0
ZV9tcWQgKm07DQo+Pj4+IAl1aW50MzJfdCBzZV9tYXNrWzRdID0gezB9OyAvKiA0IGlzIHRoZSBt
YXggIyBvZiBTRXMgKi8NCj4+Pj4NCj4+Pj4gCWlmICghcS0+IGN1X21hc2sgfHwgcS0+Y3VfbWFz
a19jb3VudCA9PSAwKQ0KPj4+PiAJCXJldHVybjsNCj4+Pj4gCS4uLi4uLg0KPj4+PiB9DQo+Pj4+
DQo+Pj4+IElzIHRoaXMgZmluZSB3aXRoIHlvdT8gVGhhbmtzIQ0KPj4+IEkgdGhpbmsgdGhhdCBj
b3VsZCB3b3JrLiBJIHN0aWxsIGRvbid0IGxpa2UgaXQuIEl0IGxlYXZlcyB0aGUgQ1UgbWFzaw0K
Pj4+IGluIHRoZSBxLQ0KPj4+PiBwcm9wZXJ0aWVzIHN0cnVjdHVyZSwgYnV0IGl0J3Mgb25seSBl
dmVyIHVzZWQgdGVtcG9yYXJpbHkgYW5kDQo+Pj4+IGRvZXNuJ3QgbmVlZCB0byBiZQ0KPj4+IHBl
cnNpc3RlbnQuIEknZCBhcmd1ZSwgaW4gdGhpcyBjYXNlLCB0aGUgY3VfbWFzayBzaG91bGRuJ3Qg
YmUgaW4gdGhlDQo+Pj4gcS0+cHJvcGVydGllcyBzdHJ1Y3R1cmUgYXQgYWxsLCBidXQgc2hvdWxk
IGJlIHBhc3NlZCBhcyBhbiBvcHRpb25hbA0KPj4+IHBhcmFtZXRlciBpbnRvIHRoZSBkcW0tDQo+
Pj4+IG9wcy51cGRhdGVfcXVldWUgY2FsbC4NCj4+IFRoZSBjdV9tYXNrIGlzIG9yaWdpbmFsbHkg
aW4gcS0+cHJvcGVydGllcyBzdHJ1Y3R1cmUuIEkgZGlkbid0IGNoYW5nZSB0aGF0Lg0KPj4gV2hh
dCBJIHdhbnQgdG8gZG8gaXMga2VlcGluZyB0aGUgY3VfbWFzayBtZW1vcnkgYWxsb2NhdGlvbiBh
bmQgZGVhbGxvY2F0aW9uDQo+anVzdCBpbiBrZmRfaW9jdGxfc2V0X2N1X21hc2suDQo+PiBpbnN0
ZWFkIG9mIGV2ZXJ5d2hlcmUuDQo+DQo+WW91J3JlIG5vdCBjaGFuZ2luZyB3aGVyZSBpdCBpcyBz
dG9yZWQuIEJ1dCB5b3UncmUgY2hhbmdpbmcgaXQgZnJvbSBzb21ldGhpbmcNCj5wZXJzaXN0ZW50
ICh3aGlsZSB0aGUgcXVldWUgZXhpc3RzKSB0byBzb21ldGhpbmcgZXBoZW1lcmFsICh3aGlsZSB0
aGUgaW9jdGwgY2FsbCBpcw0KPmV4ZWN1dGluZyBpbiB0aGUga2VybmVsKS4gSSB0aGluayB0aGF0
IHdvdWxkIGp1c3RpZnkgcmVtb3ZpbmcgdGhlIHBlcnNpc3RlbnQgcG9pbnRlcg0KPmZyb20gdGhl
IHEtPnByb3BlcnRpZXMgc3RydWN0dXJlLg0KDQpNbW0sIGFjdHVhbGx5IGl0IGhhcyBiZWVuIGNv
cGllZCB0byBtcWQgbWVtb3J5LiBJdCBkb2Vzbid0IG1ha2UgdG9vIG11Y2ggc2Vuc2UNCnRvIGtl
ZXAgaXQgcGVyc2lzdGVudC4NCiAgDQo+Pg0KPj4+IEJ1dCBJIHRoaW5rIGEgc2ltcGxlciBmaXgg
d291bGQgYmUgdG8gbW92ZSB0aGUgZnJlZWluZyBvZiB0aGUgQ1UgbWFzaw0KPj4+IGludG8gdW5p
bml0X3F1ZXVlLiBUaGF0IHdvdWxkIGNhdGNoIGFsbCBjYXNlcyB3aGVyZSBhIHF1ZXVlIGdldHMN
Cj4+PiBkZXN0cm95ZWQsIGluY2x1ZGluZyB0aGUgcHJvY2VzcyB0ZXJtaW5hdGlvbiBjYXNlLg0K
Pj4gWWVzLCBpdCcgYmV0dGVyIHRvIGZyZWUgcXVldWUgcmVsYXRlZCByZXNvdXJjZSBpbiBvbmUg
ZnVuY3Rpb24uDQo+PiBCdXQgd2UgYWxsb2NhdGUgaXQgaW4ga2ZkX2lvY3RsX3NldF9jdV9tYXNr
IGFuZCBmcmVlIGl0IGluIHBxbV9zZXRfY3VfbWFzaywNCj51bmluaXRfcXVldWUgYW5kIHNvIG9u
Lg0KPg0KPk15IHByb3Bvc2FsIGhlcmUgaXMgdG8gb25seSBmcmVlIGl0IGluIHVuaW5pdF9xdWV1
ZSAod2hlbiB0aGUgcXVldWUgaXMNCj5kZXN0cm95ZWQpIG9yIGluIHBxbV9zZXRfY3VfbWFzayAo
d2hlbiBpdCBpcyByZXBsYWNlZCBieSBhIGRpZmZlcmVudCBjdV9tYXNrKS4NCg0KQW55d2F5LCBJ
IHN0aWxsIHRoaW5rIGl0J3Mgc3RyYW5nZSBhbmQgZXJyb3ItcG9uZSB0byBhbGxvY2F0ZSBpdCBp
biBrZmRfaW9jdGxfc2V0X2N1X21hc2sgDQphbmQgZnJlZSBpdCBpbiB1bmluaXRfcXVldWUgYW5k
IHBxbV9zZXRfY3VfbWFzay4gDQoNClJlZ2FyZHMsDQpMYW5nDQoNCj5SZWdhcmRzLA0KPiDCoCBG
ZWxpeA0KPg0KPg0KPj4gSXQgc2VlbXMgc3RyYW5nZSBhbmQgZXJyb3ItcHJvbmUuIFVubGVzcyB3
ZSBhbGxvY2F0ZSBpdCBpbiBjcmVhdGUgcXVldWUuICBBcyB5b3UNCj5zYWlkLCBpdCBpcyB0ZW1w
b3JhcnkuDQo+PiBJdCdzIG5vdCB3b3J0aCBrZWVwaW5nIGl0IHVudGlsIHF1ZXVlIGlzIGRlc3Ry
b3llZC4gVGhhbmtzLg0KPj4NCj4+IFJlZ2FyZHMsDQo+PiBMYW5nDQo+Pg0KPj4+IFJlZ2FyZHMs
DQo+Pj4gIMKgIEZlbGl4DQo+Pj4NCj4+Pg0KPj4+PiBSZWdhcmRzLA0KPj4+PiBMYW5nDQo+Pj4+
DQo+Pj4+PiBSZWdhcmRzLA0KPj4+Pj4gICDCoCBGZWxpeA0KPj4+Pj4NCj4+Pj4+DQo+Pj4+Pj4g
ICAgCWlmIChyZXR2YWwgIT0gMCkNCj4+Pj4+PiAgICAJCXJldHVybiByZXR2YWw7DQo+Pj4+Pj4N
Cg==
