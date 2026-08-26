Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91D7C61DC2
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 09:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FACF10E28B;
	Wed, 26 Aug 2026 09:40:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QF7wYefF";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB8B10E28B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 09:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nU9Uju5o6WU+3oihLbFLXfa0g3+7ePdENfIWQooIlzqzqeItndYI4HmK6+uLJA5mBOhkpvvrdnJ2TomdxW9dqlpoIeHdH8wEwVz6Vy+IJribaY02UVvDl9o7Bz/Q3xGQdlESXZwTRc6m6sV7MJwHea4YNhDOURdS1cpr5aIl0kLEWiWp2GPVx4KSvKLsf0BaiE83tXHz2hOr4dRmgT3V5/HXiPelOfS4Zm/r5i0Grbt1Ye2vF4/5vqrVrYBtyB6ERR6nMvq7UefLEMN1sMounKCiZREQk7o94xsQaDHoFHv99EXGWbRLgy6FNrYOqNtyEU7bT7pQanfXhwNowZKtmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4J57lTXi1aAitB3W/zwAeG3jjyUe+9Yo36VHxlUNWE=;
 b=k1tnoALeRCk2FyhuiO9J619aOyVsm8aHfY3Yl4umbHIs3wYQ4VrzHP6XZsOcufCBPF4ZYsf4ky0iyQy2VwB9zdXrthVkEkL4tKdYFVATfC23yT4eay9h/wnhQos5KxaP/ImEC42klGWc6iQzranqgoQXVaaUTWO/AbWI9v7HVSTEE2AhdGaWjNNrRfr65lX8+q4I93GuxCnpYWkI9KLjc4Fw+1gB5fFY9eqw5VzN5e/vrbmq59Cm7bbrP9YjSRRq8CC8TqDFO7VU7I4n6g++1MIVIQpUIzqV3o+Q0PbCYh9xufSmeIe9TIn3OZLBiYVriE35OD2IVcSfPoztRRpDwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4J57lTXi1aAitB3W/zwAeG3jjyUe+9Yo36VHxlUNWE=;
 b=QF7wYefFlEU99CbrqtQt7CQAwam4NYoPZluhImxa6Xb8cxC9LzpssvNOZeOeD7t0224wYibhv7jBykl04KaJMigs6WyoxgX+8rA5L0BTpoDs8OR3kQ/bRIXuFLdGAThsk6scC33wcOilShVhqF+mjI40sFzPiPbGGn72ObQhKRA=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SJ2PR12MB8846.namprd12.prod.outlook.com (2603:10b6:a03:549::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 09:40:21 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 09:40:21 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yuan, Perry"
 <Perry.Yuan@amd.com>, "Ghosh, Prerona" <Prerona.Ghosh@amd.com>
Subject: RE: [PATCH v5] drm/amdgpu: bind BOs when the eviction fence is
 attached
Thread-Topic: [PATCH v5] drm/amdgpu: bind BOs when the eviction fence is
 attached
Thread-Index: AQHdNGbr5Ymh+UT3w0mK2ppFSX8jTrawCTsAgAAHgvA=
Date: Wed, 26 Aug 2026 09:40:21 +0000
Message-ID: <CY5PR12MB6369330C3CCC4735451CEAEFC1AE2@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20260825075346.536983-1-yifan1.zhang@amd.com>
 <7fdf5073-24be-4460-8018-eb2090584b15@amd.com>
In-Reply-To: <7fdf5073-24be-4460-8018-eb2090584b15@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-08-26T09:25:09.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SJ2PR12MB8846:EE_
x-ms-office365-filtering-correlation-id: 373871d8-0405-438d-db98-08df03560be6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|56012099006|5023799004|11063799006|4143699003|38070700021|10067099003;
x-microsoft-antispam-message-info: NPrF4hoQMB7576LQuUSisMn5jTfog9cod/VNwoqPtmK3aO8fFeNZGXZyb8C6BCr7MMpfYYH2i1AHtLQKc5x5NjhjCtJsJawnswez81oSSh7ehSLX1W0i+0dfLxLYSHxXInVti+BtQf9VfJnzf8W7JalUdgDPXmCpdzvMI2v3lIKP00AMwfX+HanYIDAN/ISwEJQu3wIVa3kQZA5zSJrH/m512RLabZ3RiFWzUNhlNdSAWU1QLbFSsWSsqIkx+kowjKNevPtNfu2+t+jheC7SuhqY+3gZ5nt9zp+nP1kHLNrkxYxMZXNEXrEKlUwHOW4LIHOV2Ze6SIjBA/Fq28zUKAQzuZ664xH7aEblwbmbdh+Kk301n50vqlG7KJ2jXuVe/vf2opkESDFLDYXpngHv8g78kdwhTVFQhGdfx2OQHdrP0a7niU/WyP0izTEUQrfALKnyJ2Onp13s9WWN95mA/Kxorq8PeuRl81NmWT1rVkaTkjNzoYCbVjA5XDZS9XrSyU5RiJv4aw1C7QTtj+RpXL6oJXZtCe36mQiy+zYzMHhbhB2f3BFgfs6zTX2eBRp46XBjtY0Dx4MVgLfrErOIsWzij5+Rp52kt3WaFf1PsWLxQjVZONbxu8KYbL2CFpN4dKki9FTJGV0MTKtuGWq4R9Ja84RM88RxXnIBDqRiGoj4UUFEsni/lSmCGM3VBMJ8Bkar9Oa3bytQgGJF+09bC0mHTHVd2HymlNs5gV8/lS0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(4143699003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2RIcmdIOGlYbVZ6Y2ZHa1JhTzhUL1R1WFJOK21HUTBtSGxrbHpVenhXOE93?=
 =?utf-8?B?V0RYWGdBOFNpaTgycjdndjZvb3RITGlIWGZtTEwzaTRISHlSbFV5Wk1LcCtX?=
 =?utf-8?B?WHc2L1lLc2QwR1pHY1g1T0plWmdpVUJTVGloUTBBcTJ6L2xSTUV4V3VWSWR4?=
 =?utf-8?B?RVYyNXNPQy8wMUZUTkpZVkdhRFFsbTBDN3hjM2s5L0lFUWltRTd6TzI0SW5p?=
 =?utf-8?B?YVRiUVR2SWdxL3JSVTY5Qm82elk0ZlltdjZLM25ObiszQ1lHSUF5anBlY2pE?=
 =?utf-8?B?TG8vdmVPYzZ1Z3pFQkpnczRnQ0FQQWNwVTk3MVdBWGI2VXJOdnJNYWg2Q25t?=
 =?utf-8?B?WlBNcnlZM2I4NTl4SWRpQnNSWmlJaFhEN1RzaHhaN1hXUnlQajk5b3RyTU9R?=
 =?utf-8?B?T1EzWCtWQVVIcytiejUvMTlOSlpzRGU5WklVM2U2bFcxUU1FbW5qZ3ZKRDNx?=
 =?utf-8?B?NnloVlNpRWVmM1R1T1g2clVtRXFtclJ2RWY1aUVkVzMyUnNKM09ma0pET0Y1?=
 =?utf-8?B?enluSWlzYW1JMmJhQmVvcG4wbk1Sbk5ySmlKQ0NZb05qaHdlN3hJazFxVGQr?=
 =?utf-8?B?NmgzTklSLzdHWENmY3piTlVLemdyTUg5V1RTY0RvWHIrQVppenRnbnRjYnBl?=
 =?utf-8?B?R3A0K1E2YjZDZVh6UGpBeUw2WVRRbXVPeGp2emplcExWSDJRb0FyajRYVllm?=
 =?utf-8?B?c1oxTUlVV2s1WFFCalFIeDBMMTRhcmdUbndPUk1zMlAxK3BZalZuaFVpRm1n?=
 =?utf-8?B?ZmFaUFQzalRBc0JlQUtYZkhQdnBIVUNqb1ZGcmp3S3RyYkk1aHlXRGhaU2xq?=
 =?utf-8?B?Zm9vTDNNK0lHUHA0dzBIa2gzL1pweUFkK1dvTWlvSFNOVG9zb2cxa0t5dy9o?=
 =?utf-8?B?WWM3YXZVSkFtVEgwU25oa3djNk1Ba1R3aU96U25LTm9lQWpFd1RrVi81Ull3?=
 =?utf-8?B?K2kxRVdIcUF6c3BLZWVNME1qaWgrdGhlclVCbDZwN0wzaUhvell1S21GK2FR?=
 =?utf-8?B?NTBaUWFlM2hDR1puek5maDhTRnAvRTFsb2RZQ0NOekk2dEgycU5UWnN6M1JR?=
 =?utf-8?B?WUJiOWp6ZldVVmxsSXZJZnRvUG9KY3lsSmZwVVdNeFVNUE04NFdHY2F3b1Zk?=
 =?utf-8?B?QnQ0aDdRWHZQRFE3cWpleGpSbWN5aFluWnJaVm9MeFMyY3ZCbXVzc0xjNURH?=
 =?utf-8?B?a2ZGNlRud0JqY21ubEw5RmJxTjZzY0htTTlsME9zSTZ1WlhGZXZOeXlUUXE2?=
 =?utf-8?B?TDAxcGJXOHlTckw3cDlNOVc3YWh5WnFnTjIvb3ZpS3V3WSsvcmFDRnNuQlo3?=
 =?utf-8?B?WXF2NS9FQnU0QytXMUVwNFdpNDhGUmV5ZEJ3cWlTN2xnMFRMMStheVl5UTA0?=
 =?utf-8?B?WHQvc1RMTTNuVTEyMExvbGFtOUlzb2cwN0V3eHM2NjE1VGVBaEFvOTNaV2xn?=
 =?utf-8?B?cDVYU29NVHZ5Mk9TTms5LzltaHoyRWpxUHMvUEVlYS9FS0x1K0gyMDZscU1I?=
 =?utf-8?B?c3B4dXYxajNnWUZSclN0aWF2TTNZNGVwQXBWb2Jzdlg4OGpsVUMzNnFYK2dy?=
 =?utf-8?B?Tk5BZ0lOSEo5K3grVWN3LzJ0THloQ2hGeTNaUHVqYTBjb0xRWUVTQVpxN3Bt?=
 =?utf-8?B?QXdad0NycE80V1ZzRCt4QzlRazhCK0ZYeHNPdXdSSUJJUWJtUk5QRkwxeU1H?=
 =?utf-8?B?ZVdJd3VzYmZaYmYvaHYzRFNaM0drRlBBc3BydUhzQ2lsNlAwd25QTEFpYjFh?=
 =?utf-8?B?SkJjR3UxMVZMNmdXemNiRzN6VzlRcDR4a3NHc3dsbmVFc3JzZXR1a2d5eDBT?=
 =?utf-8?B?QSt3cVhrcU1vWWt6T2dmZmljRXVTZXQzQ1JHWUd5R1lZNzlSKzNYUldRZTg1?=
 =?utf-8?B?UElCRU1sY2JYdWlOTkpFY0hkSVRudzNsYXVCZFdpNm5MNDZQaDNXeE93WlY4?=
 =?utf-8?B?ZTlBeVVCQlVhNVlGNXcwRWREN2FvbE41VEFBUEIvUzVvNGRZZzBrQTN2cEw4?=
 =?utf-8?B?czZRZnd3bWljL29QbTU0YTBXTUtaT1ZnaXU1UTZXdWkvUVR6UEF5Y3AvN1p0?=
 =?utf-8?B?TTFjMmNOZ3NvRGl6UitBbjAwTmhMa0x0S3E4RWJCWVNQV2VEZFBuZDhlcmZw?=
 =?utf-8?B?Wmk0N2hIZmk4Rk05RVNyckdPV201aHkwRitMT2kxU29iajhWTklBLzdBcVJn?=
 =?utf-8?B?ZEpkcUVvaGNwYUZ6YTh4QlZ3aklObmlEa1oxaXd1Sjd3UVhIY2VoTDNpU242?=
 =?utf-8?B?M2ZpYmZUV2J4SzdRL29BWnRUc0RudWFFWVp3Z0QxaFlpem4wcFhrbUFjbldY?=
 =?utf-8?Q?DPd4vmP2OqmcBXvMrJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373871d8-0405-438d-db98-08df03560be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 09:40:21.1382 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fGlknWjZX3tbgYw33vf1XB7jDLEuAolkp8BdWePvt4RwPhwEW9LmhmMlKLocVK4k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8846
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

UHVibGljDQoNCkhpIENocmlzdGlhbiwNCg0KVGhhdOKAmXMgYmVjYXVzZSBldl9mZW5jZSBpcyBp
bml0aWFsaXplZCB0byBhIHBlcm1hbmVudGx5IHNpZ25hbGVkIHN0dWIgZmVuY2UgaW4gYW1kZ3B1
X2V2Zl9tZ3JfaW5pdCgpOg0KZXZmX21nci0+ZXZfZmVuY2UgPSBkbWFfZmVuY2VfZ2V0X3N0dWIo
KTsNCkFzIGEgcmVzdWx0LCBkbWFfZmVuY2VfaXNfc2lnbmFsZWQoZXZfZmVuY2UpIHJldHVybnMg
dHJ1ZSBpbiBhbWRncHVfZXZmX21ncl9hdHRhY2hfZmVuY2UoKSBpZiBubyB1c2VyLXF1ZXVlIHNl
dHVwIG9yIHJlc3VtZSBwYXRoIGNhbGxzIGFtZGdwdV9ldmZfbWdyX3JlYXJtKCksIGFsbG93aW5n
IGl0IHRvIGJ5cGFzcyB0aGUgdmFsaWRhdGlvbi4NCg0KQmVzdCByZWdhcmRzLA0KWWlmYW4NCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJp
c3RpYW4uS29lbmlnQGFtZC5jb20+DQpTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAyNiwgMjAyNiA0
OjU4IFBNDQpUbzogWmhhbmcsIFlpZmFuIDxZaWZhbjEuWmhhbmdAYW1kLmNvbT47IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPjsgWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IEdob3No
LCBQcmVyb25hIDxQcmVyb25hLkdob3NoQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHY1
XSBkcm0vYW1kZ3B1OiBiaW5kIEJPcyB3aGVuIHRoZSBldmljdGlvbiBmZW5jZSBpcyBhdHRhY2hl
ZA0KDQpPbiA4LzI1LzI2IDA5OjUzLCBZaWZhbiBaaGFuZyB3cm90ZToNCj4gRnJvbTogUHJlcm9u
YSBHaG9zaCA8UHJlcm9uYS5HaG9zaEBhbWQuY29tPg0KPg0KPiBETUEtYnVmIGltcG9ydHMgYXJl
IGNyZWF0ZWQgaW4gVFRNX1BMX1NZU1RFTSBhbmQgbGFuZCBvbiB0aGUgVk0gaWRsZQ0KPiBsaXN0
LCBzbyBub3RoaW5nIGJpbmRzIHRoZW0gZm9yIGEgVk0gdXNpbmcgdXNlciBxdWV1ZXM6DQo+IGFt
ZGdwdV92bV92YWxpZGF0ZSgpIGFuZCBhbWRncHVfdXNlcnFfYm9fdmFsaWRhdGUoKSBza2lwIGlk
bGUgQk9zLCBhbmQgYW1kZ3B1X2NzIG5ldmVyIHJ1bnMuDQo+IEFNREdQVV9HRU1fVkEgdGhlbiBw
cm9ncmFtcyBQVEVzIHdpdGhvdXQgQU1ER1BVX1BURV9WQUxJRCBhbmQgdGhlDQo+IGZpcnN0IEdQ
VSBhY2Nlc3MgZmF1bHRzLg0KPg0KPiBhbWRncHVfZXZmX21ncl9hdHRhY2hfZmVuY2UoKSBpcyB0
aGUgcmlnaHQgcGxhY2UgdG8gZml4IHRoaXMsIGJ1dCBpdA0KPiBvbmx5IHZhbGlkYXRlZCB3aGls
ZSB0aGUgZXZpY3Rpb24gZmVuY2Ugd2FzIHVuc2lnbmFsZWQuIEF0DQo+IGFtZGdwdV9nZW1fb2Jq
ZWN0X29wZW4oKSB0aW1lIHRoZSBmZW5jZSBpcyBzdGlsbCB0aGUgcGVybWFuZW50bHkNCj4gc2ln
bmFsZWQgc3R1YiBpbnN0YWxsZWQgYnkgYW1kZ3B1X2V2Zl9tZ3JfaW5pdCgpOyBhIHJlYWwgZmVu
Y2Ugb25seSBhcHBlYXJzIGFmdGVyIGFtZGdwdV9ldmZfbWdyX3JlYXJtKCkuDQo+IE5hdGl2ZWx5
IGNyZWF0ZWQgQk9zIGhpZGUgdGhlIGJ1ZyBiZWNhdXNlIGFtZGdwdV9ib19jcmVhdGUoKSBhbHJl
YWR5DQo+IHZhbGlkYXRlZCB0aGVtLg0KPg0KPiBWYWxpZGF0ZSBpbXBvcnRlZCBCT3MgZXZlbiB3
aGVuIHRoZSBmZW5jZSBpcyBzaWduYWxlZCwgYW5kIHVud2luZCB0aGUNCj4gYm9fdmEgaWYgdGhh
dCBmYWlscy4NCj4NCj4gdjM6IHZhbGlkYXRlIGluc2lkZSBhbWRncHVfZ2VtX29iamVjdF9vcGVu
IChDaHJpc3RpYW4pDQo+IHY0OiBmaXggYW1kZ3B1X2V2Zl9tZ3JfYXR0YWNoX2ZlbmNlIGl0c2Vs
ZiBpbnN0ZWFkIChDaHJpc3RpYW4pDQo+IHY1OiByZXN0cmljdCB0aGUgZXh0cmEgdmFsaWRhdGlv
biB0byBpbXBvcnRzIHNvIHRoYXQgcmVzaWRlbnQgYW5kIHBpbm5lZA0KPiAgICAgQk9zIGFyZSBu
b3QgbWlncmF0ZWQgb3IgZmFpbGVkIG9uIGV2ZXJ5IEdFTSBvcGVuDQo+DQo+IFNpZ25lZC1vZmYt
Ynk6IFByZXJvbmEgR2hvc2ggPFByZXJvbmEuR2hvc2hAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogWWlmYW4gWmhhbmcgPHlpZmFuMS56aGFuZ0BhbWQuY29tPg0KPiBBc3Npc3RlZC1ieTogQ2xh
dWRlOmNsYXVkZS1vcHVzLTUuMA0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jIHwgMTEgKysrKysrKystLS0NCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyAgICAgICAgICAgIHwgIDkgKysrKysrKystDQo+
ICAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZpY3Rpb25f
ZmVuY2UuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9m
ZW5jZS5jDQo+IGluZGV4IDRjNWUzOGRlYTRjMi4uYzJmOTM4MDUxMWEzIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZpY3Rpb25fZmVuY2UuYw0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZpY3Rpb25fZmVuY2UuYw0K
PiBAQCAtMTAxLDExICsxMDEsMTYgQEAgaW50IGFtZGdwdV9ldmZfbWdyX2F0dGFjaF9mZW5jZShz
dHJ1Y3QgYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX21nciAqZXZmX21nciwNCj4gICAgICAgc3RydWN0
IGRtYV9yZXN2ICpyZXN2ID0gYm8tPnRiby5iYXNlLnJlc3Y7DQo+ICAgICAgIGludCByZXQ7DQo+
DQo+IC0gICAgIGlmICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKGV2X2ZlbmNlKSkgew0KPiAtDQo+
ICsgICAgIC8qDQo+ICsgICAgICAqIEltcG9ydHMgYXJlIGNyZWF0ZWQgaW4gVFRNX1BMX1NZU1RF
TSBhbmQgdGhpcyBpcyB0aGUgb25seSBwbGFjZSBhIFZNDQo+ICsgICAgICAqIHVzaW5nIHVzZXIg
cXVldWVzIGJpbmRzIHRoZW0sIHNvIHZhbGlkYXRlIHRob3NlIGV2ZW4gd2hlbiB0aGUgZmVuY2UN
Cj4gKyAgICAgICogaXMgYWxyZWFkeSBzaWduYWxlZC4NCj4gKyAgICAgICovDQo+ICsgICAgIGlm
ICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKGV2X2ZlbmNlKSB8fA0KPiArICAgICAgICAgZHJtX2dl
bV9pc19pbXBvcnRlZCgmYm8tPnRiby5iYXNlKSkgew0KDQpUaGF0IHN0aWxsIGRvZXNuJ3QgbWFr
ZSBtdWNoIHNlbnNlLiBXaGVuIHRoZSBmZW5jZSBpcyBzaWduYWxlZCB0aGVyZSBpcyBubyByZWFz
b24gd2hhdHNvZXZlciB0byB2YWxpZGF0ZSBpbXBvcnRlZCBCT3MuDQoNCldlIGFyZSBzdGlsbCBt
aXNzaW5nIHNvbWV0aGluZyBoZXJlIHdoaWNoIGV4cGxhaW5zIHdoeSB0aGF0IGRvZXNuJ3Qgd29y
ayBhcyBleHBlY3RlZC4NCg0KPiAgICAgICAgICAgICAgIGFtZGdwdV9ib19wbGFjZW1lbnRfZnJv
bV9kb21haW4oYm8sIGJvLT5hbGxvd2VkX2RvbWFpbnMpOw0KPiAgICAgICAgICAgICAgIHJldCA9
IHR0bV9ib192YWxpZGF0ZSgmYm8tPnRibywgJmJvLT5wbGFjZW1lbnQsICZjdHgpOw0KPiAtICAg
ICAgICAgICAgIGlmICghcmV0KQ0KPiArICAgICAgICAgICAgIGlmICghcmV0ICYmICFkbWFfZmVu
Y2VfaXNfc2lnbmFsZWQoZXZfZmVuY2UpKQ0KDQpUaGF0IGNoZWNrIGlzIHN1cGVyZmx1b3VzLg0K
DQo+ICAgICAgICAgICAgICAgICAgICAgICBkbWFfcmVzdl9hZGRfZmVuY2UocmVzdiwgZXZfZmVu
Y2UsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRE1BX1JFU1Zf
VVNBR0VfQk9PS0tFRVApOw0KPiAgICAgICB9IGVsc2Ugew0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dlbS5jDQo+IGluZGV4IGY3NTRhNGEzYTFjMi4uMzExOGIzMDM2NTY0
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jDQo+IEBAIC0y
NjQsOSArMjY0LDE2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2dlbV9vYmplY3Rfb3BlbihzdHJ1Y3Qg
ZHJtX2dlbV9vYmplY3QgKm9iaiwNCj4gICAgICAgYm9fdmEgPSBhbWRncHVfdm1fYm9fZmluZCh2
bSwgYWJvKTsNCj4gICAgICAgaWYgKCFib192YSkgew0KPiAgICAgICAgICAgICAgIGJvX3ZhID0g
YW1kZ3B1X3ZtX2JvX2FkZChhZGV2LCB2bSwgYWJvKTsNCj4gKyAgICAgICAgICAgICBpZiAoIWJv
X3ZhKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICByID0gLUVOT01FTTsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgIGdvdG8gb3V0X3VubG9jazsNCj4gKyAgICAgICAgICAgICB9DQo+ICsNCg0K
VGhhdCBzaG91bGQgcHJvYmFibHkgYmUgYSBzZXBhcmF0ZSBwYXRjaC4NCg0KUmVnYXJkcywNCkNo
cmlzdGlhbi4NCg0KPiAgICAgICAgICAgICAgIHIgPSBhbWRncHVfZXZmX21ncl9hdHRhY2hfZmVu
Y2UoJmZwcml2LT5ldmZfbWdyLCBhYm8pOw0KPiAtICAgICAgICAgICAgIGlmIChyKQ0KPiArICAg
ICAgICAgICAgIGlmIChyKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICBhbWRncHVfdm1fYm9f
ZGVsKGFkZXYsIGJvX3ZhKTsNCj4gICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0X3VubG9j
azsNCj4gKyAgICAgICAgICAgICB9DQo+ICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAgICAg
Kytib192YS0+cmVmX2NvdW50Ow0KPiAgICAgICB9DQoNCg==
