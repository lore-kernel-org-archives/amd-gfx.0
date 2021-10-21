Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4269C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B82C60FD8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7B82C60FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D93506ECCE;
	Thu, 21 Oct 2021 16:47:58 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2077.outbound.protection.outlook.com [40.107.100.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E0C6ECCE
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 16:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecj4hxujvjWv5VI/FAc2nLmbi+evYs5GkVufKLPHftU51bS42c38bMWclKKNjih/gq+LGsFG942+Raejq+vC5U2iO+OZT/D9BOm6jskzScszZr3BT068+O8mbHW9Q66QajQZCLr2LM5OFgyyv/pmAS09yIx1dH0EX9uv2LSWWDwRusMMvpNlvkq26UM8a1TynuWmhV+ooGfAK3iNUNwW83Qo6KpZ5nTpAPmuOA/wCgsYRVBJg0p36OrOHXBfgRHiUwWdBn9lIL/dFNBj9JxtzEEu0YqdsraGT+xUFtHZD72L8oVxDf7cnGacQkXHt4lZ+MG38agJLicChoveGt1XKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpTcLnPgYoKXN0wPtbZj7IyoiU73EQZi1sR3H7WUuYc=;
 b=ndARWrjWgbaZyEnkbUbR4uauEO8y4O2cIY21FE+6Y+9gYg/bdNT/38shIEZeW1oBFrCzqK9AVRPiQXmlbUxwGTtGemnDEn3pxud5ktvDff3Zm7hshB1y1U1Z2gPAukuY/95glPj/ddtBYeOnZQ6nneDGlB0n1oMOncsJChGQrCd7SDUHNqCrrBc0m/0w5NM/eULfBK4qyXL8YPWpbgVSMAJLAEIEHJq58QNGaFxcigb7GspJmYvcWKzq5/rZ1CsKBhfG29N6Z/NushiiWWmaDVXrn+0LUhDEyU7cIQlvcioaq75YwsHhsfqRHkSVWbnApwjg+UskgA0H4Wt9EY0Cow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpTcLnPgYoKXN0wPtbZj7IyoiU73EQZi1sR3H7WUuYc=;
 b=jrAi8+hr9IhXnajSBtA0DwvNulOr8VbTRBZvMwdRgdwthlii7wPatpvrp0sBIlzlEFIV85vgFK8sxa0jcAxgRposeajymG/82poaM065uQYjp1u4xVdptvfbKXnS6ICIV8yd27zSnWTK7QGL4PiJlRWFym6XyDqpR2p7gf+DX1U=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Thu, 21 Oct
 2021 16:47:55 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::40cf:e859:88c4:9b5e]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::40cf:e859:88c4:9b5e%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 16:47:55 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Warn when bad pages approaches 90%
 threshold
Thread-Topic: [PATCH 1/2] drm/amdgpu: Warn when bad pages approaches 90%
 threshold
Thread-Index: AQHXxpRcZJcw4+jan02Y6lho4fdIravdpicAgAACogCAAACywA==
Date: Thu, 21 Oct 2021 16:47:55 +0000
Message-ID: <DM6PR12MB3324522EA8DECF3AE8C533DF85BF9@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20211021155711.1191830-1-kent.russell@amd.com>
 <50f764cb-64f1-5b36-7e14-1c560784b7ea@amd.com>
 <df069bd3-76cd-4662-b4c3-23e6e17c77d6@amd.com>
In-Reply-To: <df069bd3-76cd-4662-b4c3-23e6e17c77d6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-21T16:47:53Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1507ddd5-aec5-4924-b8f4-53dc51ee1cee;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0ba88e7-f744-4c0c-ea66-08d994b2880f
x-ms-traffictypediagnostic: DM6PR12MB4481:
x-microsoft-antispam-prvs: <DM6PR12MB4481C5CF3DAE7195D603A8EF85BF9@DM6PR12MB4481.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q1SKyzrqDwCYF9RGpxhDR188Gqbo1bHtJnVNAlJwQoXevCuBl6WYcG3RcgGDR9PYJOvuuObrJHJj/Ks0sODDcvWZPkwYvfLVHUDea8UuDVgFnwb9tRA+27FgQqAVBEAFUIFre6YID8s9m9rVwxRIUixi3pkM9ZO5kogjJgGid4c4S/gnfqonr0gCKLCOmdcuB7xRPP7eMzG7sW7rGhsRSMa5Ydp8sZsgIUjhJ3qdx/7LuPK/+0FD/U0ryqrX627HV9feU71yUM5pY1siM5JvakGAjbPNohbDc//31by/p7e7WtHXtKv+k2xqtXJsmQoMJts/WoXRmRN3CEdBCZK+vHZcM6f3jiAi5HelvkK1OC0IBhmPvwNIz4O6TLmvEsEf/QVd5oDUOHk13tGjo04FcjghVtXvpcwRLZ1fAUa9PmtV/jqp61v4JWM1NoAgg99f/2vfDwiwLQsGmlQLYLm9UE8uk5lwpcqwcZIY+X/HRnGYYhXdh7k1WDjWsDRJ/ZxJ4ps1KVydIw6+v1ogKgHOkxzmEMUyNIBcxqKaQAXf5x68aIUUff3n1uAxVei8jELXMc/ZORgPP8rG8URQU6+/GvphgXg/E/68rKbyNoXGcxJq3FBOdtEm5HBQWNvBD/Npzl4+esMxB3VRsGLoXz/b87MxjSPsKYf9Y7CrSb1enOHvTHE0b5p/QEtHxEEqGQmvMZ8jni3UMYMAXioy9jqvAw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(53546011)(83380400001)(6506007)(316002)(4001150100001)(8936002)(5660300002)(66446008)(110136005)(4326008)(52536014)(38070700005)(8676002)(7696005)(66556008)(66476007)(66946007)(64756008)(2906002)(55016002)(9686003)(71200400001)(186003)(86362001)(122000001)(38100700002)(508600001)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTVkZjgrSGtVck9SRkplV2ROdmo4aGtndStMK3AyaG45bVFyN1huRFZxSGNL?=
 =?utf-8?B?bWx6UTlON2t1b3pEVTZjSXUxZ1RkQzNSM0NyellXdzJyb1pBZXZLMkIremF2?=
 =?utf-8?B?Vi9SK3ZOVll2a1NGNTFEQjFuZllvNWxELzRqTzl5RlRIODVoa0lxYzRCOGl1?=
 =?utf-8?B?aGNjU3ZYZVU0M1NGOU5jV1BFY0VBdkJWOXlONW5rWDVkQndIMnhDbjF4a3lU?=
 =?utf-8?B?cHZtb1M4K1M0eHhLbERYY2RJR1c5Tm1nTVdwd1dGWmh0d3hBU3BLbWd1QVFN?=
 =?utf-8?B?ZHpKZUFQa2djZjFOOXRZZE02VXlLckVwQjdUblRkb3RFdlJ4SjhCd0F0TDBx?=
 =?utf-8?B?T2c4elFMZ0N1d1RqR3doOEFtMlRlYWszajNlaUdCS1NBd24wWFJubUpDNS9h?=
 =?utf-8?B?RWJ5aWdzeXdGUzdWRmtyWUtPamx1QnhLYVozZnNJMnpEMDlrZENBcHJzVGdT?=
 =?utf-8?B?OTRaUTFZdDdSQW5jYUhrWlByTC9waG4xYU0wM0wyUlBvRUh6TUtialFIeUE5?=
 =?utf-8?B?bnNiZ0Zmc2xSUFBac1o2OURIRDUxZkZzbGNsZmpHR2NuOFhoVlhBZkFJQzJM?=
 =?utf-8?B?T0JwdlhkcmZUYzZwRzk4MXNSRGFZMW5PbW9xaGtkSjVLYnFIUmxXQWc5MHlj?=
 =?utf-8?B?djhZV29pbHJLU04yb083bktuSTJCNDlyYWZYNFFPTlZHZWQxYTNnaDBXU0Zn?=
 =?utf-8?B?RGlXRklGdXFvVTlFalRad0dJakhyZk1HWldycG4rRXhsbUdtNys3UjhYSDZB?=
 =?utf-8?B?THpPNGtvSU9xR2Rna3dNNm5aZXorWFhYWklEWGNHMHZHcVZGbVBpOThvTHFL?=
 =?utf-8?B?YzVBajdvNk5WNWtPSUx2Qi9aTFBOajZyOXB2c3EyR1RuNllhRldVSGsvOHNI?=
 =?utf-8?B?WnA2WERxajdRL25oZ2ZJakJydWkrVXRTZjQ5SGQ5UHJmZjJNakdBQ1R3dmlz?=
 =?utf-8?B?WGRrQTgvemxoSDd4dm1IenIzWnM0Zlc0aDhtd0kvT0RKcGRJMUlTTnRqZ0Er?=
 =?utf-8?B?STZxcWtoWGgzdmd4d0huR2hiRDhLK1J4MTBkTSttd0lXcDJZTWFBREp3OWd1?=
 =?utf-8?B?cEhRRzFBZjEyOUx5NWVoNXIxVk1oVE9jdC9IOHFkQ0xFQ1ZYRW1rNGp1aE05?=
 =?utf-8?B?M0tsa0dBYUtPWXlZejBtcGpza1VQc0FtVmtuSEcyZEdtVTd1WHN0Vmw4QlYy?=
 =?utf-8?B?NFo4UFpCemZUTDE3Yzc5MWlxQ1kzeWdKcDNtd3JoOHZJSldYbUpyNGtPcFRG?=
 =?utf-8?B?MUhBdDRDZFVmNzJqSVpMU3RvbDNHTno2M0dRVERYL1pVVGV1djZmRTBLTHpk?=
 =?utf-8?B?UnNYak5BWjZwd1BpNGJTbDhUbDN5NHJ0cTJGSC9Ba2dRSzRseVNTT2Y4bGRm?=
 =?utf-8?B?bzdzWmh2dEpQTXVGL1MrQUVERkxGNkpIZkdSVFV5M1luSnd0c2JlRzJONVBr?=
 =?utf-8?B?UUo1MHRRU1lCNDVVNjhMc1kvdEM4SGxPSG8vZHRFSjFzOUwvb05lZjNSWFVo?=
 =?utf-8?B?N2VmWVBndEVPZmNtZndUV2ZjTGMvOGV3M3psRXhqK2FuVlFiemRXdVdRVnRI?=
 =?utf-8?B?ck1wR0JJQk1melBSTUtSYnJLVHdGL2VlSXpxK2p2M0t2bHVFd1RIMzFDZlJv?=
 =?utf-8?B?S1FPcERGOWJNa3c3bmdPaEZwOSsyRW54WXg1K0U2K1gwbVU0encva1UvM01B?=
 =?utf-8?B?dHRPd2dlZXlJeFBBS2dYak9UQ3FlcjdZYk5OY1ZsaVF2NGY3RWN1RHBPSXln?=
 =?utf-8?B?NDlWTjZJQ1VkbStITGR6dTBwWWZNU0ZvcFR3N05RZnRjQ1pqRXJMYmxZSjgy?=
 =?utf-8?B?eVlTZ3pVZEtsQ2RYbitTbVNNZ1hEelhGZDEwUXhESTY0WFdSeXY2Yys0bmpK?=
 =?utf-8?B?WWEyM1R5Q1dPaXhFa3YzVVhVdGFIOExPd3JzRStpNmlsVFZYOSt1UVpXMGZT?=
 =?utf-8?B?YVRmUGZBUUN1ZnZibG43MFQ0cS9kVHJ5enUrbXFtMDRLM1RxTzdoQk1QUlcx?=
 =?utf-8?Q?d3pr/wz7YspW07GKLA5wzSu3oSrdXU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ba88e7-f744-4c0c-ea66-08d994b2880f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 16:47:55.6420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krussell@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
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
LS0NCj4gRnJvbTogVHVpa292LCBMdWJlbiA8THViZW4uVHVpa292QGFtZC5jb20+DQo+IFNlbnQ6
IFRodXJzZGF5LCBPY3RvYmVyIDIxLCAyMDIxIDEyOjQ1IFBNDQo+IFRvOiBSdXNzZWxsLCBLZW50
IDxLZW50LlJ1c3NlbGxAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+
IENjOiBKb3NoaSwgTXVrdWwgPE11a3VsLkpvc2hpQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMS8yXSBkcm0vYW1kZ3B1OiBXYXJuIHdoZW4gYmFkIHBhZ2VzIGFwcHJvYWNoZXMgOTAl
IHRocmVzaG9sZA0KPiANCj4gT24gMjAyMS0xMC0yMSAxMjozNSwgTHViZW4gVHVpa292IHdyb3Rl
Og0KPiA+IE9uIDIwMjEtMTAtMjEgMTE6NTcsIEtlbnQgUnVzc2VsbCB3cm90ZToNCj4gPj4gZG1l
c2cgZG9lc24ndCB3YXJuIHdoZW4gdGhlIG51bWJlciBvZiBiYWQgcGFnZXMgYXBwcm9hY2hlcyB0
aGUNCj4gPj4gdGhyZXNob2xkIGZvciBwYWdlIHJldGlyZW1lbnQuIFdBUk4gd2hlbiB0aGUgbnVt
YmVyIG9mIGJhZCBwYWdlcw0KPiA+PiBpcyBhdCA5MCUgb3IgZ3JlYXRlciBmb3IgZWFzaWVyIGNo
ZWNrcyBhbmQgcGxhbm5pbmcsIGluc3RlYWQgb2Ygd2FpdGluZw0KPiA+PiB1bnRpbCB0aGUgR1BV
IGlzIGZ1bGwgb2YgYmFkIHBhZ2VzLg0KPiA+Pg0KPiA+PiBDYzogTHViZW4gVHVpa292IDxsdWJl
bi50dWlrb3ZAYW1kLmNvbT4NCj4gPj4gQ2M6IE11a3VsIEpvc2hpIDxNdWt1bC5Kb3NoaUBhbWQu
Y29tPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBLZW50IFJ1c3NlbGwgPGtlbnQucnVzc2VsbEBhbWQu
Y29tPg0KPiA+PiAtLS0NCj4gPj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXNfZWVwcm9tLmMgfCA2ICsrKysrKw0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jhc19lZXByb20uYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yYXNfZWVwcm9tLmMNCj4gPj4gaW5kZXggZjRjMDVmZjRiMjZjLi5jZTUwODkyMTY0NzQgMTAw
NjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVw
cm9tLmMNCj4gPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19l
ZXByb20uYw0KPiA+PiBAQCAtMTA3Nyw2ICsxMDc3LDEyIEBAIGludCBhbWRncHVfcmFzX2VlcHJv
bV9pbml0KHN0cnVjdA0KPiBhbWRncHVfcmFzX2VlcHJvbV9jb250cm9sICpjb250cm9sLA0KPiA+
PiAgCQlpZiAocmVzKQ0KPiA+PiAgCQkJRFJNX0VSUk9SKCJSQVMgdGFibGUgaW5jb3JyZWN0IGNo
ZWNrc3VtIG9yIGVycm9yOiVkXG4iLA0KPiA+PiAgCQkJCSAgcmVzKTsNCj4gPj4gKw0KPiA+PiAr
CQkvKiBXYXJuIGlmIHdlIGFyZSBhdCA5MCUgb2YgdGhlIHRocmVzaG9sZCBvciBhYm92ZSAqLw0K
PiA+IFRoZSBrZXJuZWwgdXNlcyBhIGNvdXBsZSBvZiBzdHlsZXMsIHRoaXMgaXMgb25lIG9mIHRo
ZW06DQo+ID4NCj4gPiAvKiBXYXJuIC4uLg0KPiA+IMKgKi8NCj4gPiBpZiAoLi4uKQ0KPiA+DQo+
ID4gUGxlYXNlIHVzZSB0aGlzIHN0eWxlIGFzIGl0IGlzIHVzZWQgZXh0ZW5zaXZlbHkgaW4gdGhl
IGFtZGdwdV9yYXNfZWVwcm9tLmMgZmlsZS4NCj4gPg0KPiA+PiArCQlpZiAoKDEwICogY29udHJv
bC0+cmFzX251bV9yZWNzKSA+PSAocmFzLT5iYWRfcGFnZV9jbnRfdGhyZXNob2xkICogOSkpDQo+
ID4gWW91IGRvbid0IG5lZWQgdGhlIGV4dHJhIHBhcmVudGhlc2lzIGFyb3VuZCBtdWx0aXBsaWNh
dGlvbi0taXQgaGFzIGhpZ2hlciBwcmVjZWRlbmNlDQo+IHRoYW4gcmVsYXRpb25hbCBvcGVyYXRv
cnMtLWRyb3AgdGhlIGV4dHJhIHBhcmVudGhlc2lzLg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBM
dWJlbg0KPiA+DQo+ID4+ICsJCQlEUk1fV0FSTigiUkFTIHJlY29yZHM6JXUgZXhjZWVkcyA5MCUl
IG9mIHRocmVzaG9sZDolZCIsDQo+ID4+ICsJCQkJCWNvbnRyb2wtPnJhc19udW1fcmVjcywNCj4g
Pj4gKwkJCQkJcmFzLT5iYWRfcGFnZV9jbnRfdGhyZXNob2xkKTsNCj4gDQo+IE9uZSBtb3JlIG5v
dGU6IFRoZSBjb2RlIHVzZXMgImRldl9lcnIoKSIgZm9yIHRoaXMgdmVyeSBzaW1pbGFyIG1lc3Nh
Z2U6DQo+IA0KPiDCoMKgIMKgwqDCoMKgIMKgwqDCoCBkZXZfZXJyKGFkZXYtPmRldiwNCj4gwqDC
oCDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgICJSQVMgcmVjb3JkczolZCBleGNlZWQgdGhyZXNob2xk
OiVkLCAiDQo+IMKgwqAgwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCAiR1BVIHdpbGwgbm90IGJlIGlu
aXRpYWxpemVkLiBSZXBsYWNlIHRoaXMgR1BVIG9yIGluY3JlYXNlIHRoZSB0aHJlc2hvbGQiLA0K
PiDCoMKgIMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgY29udHJvbC0+cmFzX251bV9yZWNzLCByYXMt
PmJhZF9wYWdlX2NudF90aHJlc2hvbGQpOw0KPiANCj4gU2luY2UgeW91ciBtZXNzYWdlIGlzIGVz
c2VudGlhbGx5IHRoZSBzYW1lLCBzYW5zIHRoZSAiOTAlIG9mIHRocmVzaG9sZCIsIHBlcmhhcHMg
eW91IHdhbnQNCj4gdG8gdXNlIGRldl93YXJuKCksIGluc3RlYWQgb2YgIkRSTV9XQVJOKCkiLg0K
DQpBZ3JlZWQuIExpam8gaGFkIGEgc2ltaWxhciBjb21tZW50LiBJIG1heSBmb2xsb3cgdXAgd2l0
aCBhbm90aGVyIHBhdGNoIHRvIGNoYW5nZSBhbGwgb2YgdGhlc2UgdGFibGUtc3BlY2lmaWMgRFJN
XyogbWVzc2FnZXMgdG8gZGV2XyoNCg0KIEtlbnQNCg0KPiANCj4gUmVnYXJkcywNCj4gTHViZW4N
Cj4gDQo+ID4+ICAJfSBlbHNlIGlmIChoZHItPmhlYWRlciA9PSBSQVNfVEFCTEVfSERSX0JBRCAm
Jg0KPiA+PiAgCQkgICBhbWRncHVfYmFkX3BhZ2VfdGhyZXNob2xkICE9IDApIHsNCj4gPj4gIAkJ
cmVzID0gX192ZXJpZnlfcmFzX3RhYmxlX2NoZWNrc3VtKGNvbnRyb2wpOw0K
