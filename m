Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3459BC531C7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 06:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E4EB10EFAB;
	Thu, 23 Jul 2026 06:47:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wiFs+ij/";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8192210EFAB
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 06:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAFaHyqhoq4V44zbrVhGBDm7vDRGy0M6CuNJZJo5+Q/WeUZOCIBWPzFANHLMXfGL3oSAtYycMEh6rJ8JrGI+zfta2XWnQpmUMmJVhWn/R42Dw9HBXTnelu2guUhfy5vsG6DM+7biSwcPp/ntWf9qFzaK1BSsZOjcGGbktCSQlC3+4urrOcxlNuTTOEXcPk9id6EBTOX/+h3R2+pxppC4HjJHNszYrMFGGCL3vneuAq2wWt/xho8Q8P6D3iPOVu/2QOg8oh0CzpzTJ1UewTaJC38Y8p7VAo7dTBr+ULZXhBuMv8Sjj4MEhCvEwOqdNdZcTtNn74A36sPReu7Y5PBnHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlMNNhHBjUyzCmtq791UJRkOwAoWabuFp8fGhVupz30=;
 b=YRYILoo5ecWGV4d4o0deQgZUC0e81s57IZKq0OOBUJ/bks9Qyu9r462YwDqGJuU5LK77zwCe/rjpYnkMyngfWDbPDihnALdV82OETEiLFOo6pTx7gVWjt0CfJEHBE4pqx5Df9tKbzfn92VZ6OWH6SJyp1N+J0bzf8ermfnPiGDNo5D1Toc2edaCALlmENZrfXdpQz5dqCWrn+Eq6REOAw1voMBidPBPX5lLHM6sukZyj0zp4mIfFALruelZGB1OnU3dkOeHAKkcBKFZvffnBkBk99ThRfCF0V5WxabtAxyWqS8fHP7whwzut763zDxa3CX7qrmMYZjN7GnW/AE6a9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlMNNhHBjUyzCmtq791UJRkOwAoWabuFp8fGhVupz30=;
 b=wiFs+ij/4IEriBX4qUwbnJR5SKfbMSkHOozL/4biT282x3YUcgEqE8pF8NE3F+c6aGrJ82+fitq3hdGVzNQhUQmARm8DOYG0WYTP5KmHxAA4t8wPcj3E/elVi06uFUxVt7Tf37QJVt3FSRcNqRIrDWtUKVdj855w6sqoFQdnCjs=
Received: from IA5PR12MB999275.namprd12.prod.outlook.com
 (2603:10b6:208:602::9) by LV8PR12MB9358.namprd12.prod.outlook.com
 (2603:10b6:408:201::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 06:47:01 +0000
Received: from IA5PR12MB999275.namprd12.prod.outlook.com
 ([fe80::52c3:39ec:6eb1:919]) by IA5PR12MB999275.namprd12.prod.outlook.com
 ([fe80::52c3:39ec:6eb1:919%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 06:47:01 +0000
From: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>
To: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: enable mode2 reset for SMU IP v15.0.5
Thread-Topic: [PATCH] drm/amdgpu: enable mode2 reset for SMU IP v15.0.5
Thread-Index: AQHdGlfP6aQid/ssRE2Z8tz28fSzNrZ7BYOA
Date: Thu, 23 Jul 2026 06:47:01 +0000
Message-ID: <IA5PR12MB999275B95D9AFD757EFAD742F680C02@IA5PR12MB999275.namprd12.prod.outlook.com>
References: <20260723035951.3793144-1-Kanala.RamalingeswaraReddy@amd.com>
In-Reply-To: <20260723035951.3793144-1-Kanala.RamalingeswaraReddy@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IA5PR12MB999275.namprd12.prod.outlook.com
 (15.21.0245.008)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA5PR12MB999275:EE_|LV8PR12MB9358:EE_
x-ms-office365-filtering-correlation-id: f3772206-be0b-48f0-4c7d-08dee8863364
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|11063799006|10067099003|56012099006|18002099003|22082099003|8096899003|38070700021;
x-microsoft-antispam-message-info: sylG+xITRYVoiVFZAgoyE8vMotxA44sXY5NmDQlr5KbWeb5UmEHkC0AbJpdiXEZvxpozHXKtrWGmJUBWC1UojaURfOO3sey/0ae0BzSK8UApxF2u9q6MTbM4Pgj7MkSYYQVCsDqWwnoeDeOXtNiufUGvoHiXLzdxrDiT+9A4ieQeJxWY9Ky7wKd7Mw6JnEDXofFdaqScEUtKBTzrYn3GAwKY0uFBVzH0Sjh+Oo/Xvctr01znttFsk9mXv/dJB9sAIuIbn4KHeDs8CLmXEtTIw4iekIxLYQcHb7jKL9HH9eRpOdQadmiqTgVvfEqtIbYsWHV8IZif39TZ+w0rFVFtkFRlaJ0WrmG+Q8dA5cc0KqZanzNxkELqee8y56rXsHsEmmxCcVFhzNKsI3Vql8Ak+FkgDu+KhTpPkBF1NqvCEiryUb1aWhTAMUtf1C+/5WuaQlPiNzuRnKhMlpRMGPoTEbTVP7efsYLf09Bq+apGVdnkjj+omnhkR1x0GWaEx9UK1Op0sSRrnLuAAGb1wdUiJYQwad1isHPXCn4l1camvV5jnP6Z2hOsBF0PRu4brElKNh7yKTbtDMkYdRIJ+ZrhciOTLbHzWEmM4ZnIUqnXlwuyh/r52FB2t001qjGKHn5mdi7fUS9KS0MsR4X5TqmyxzdpizyKQwPFNsYO/AOV5v2wVXi0Prx9IqLnSLx6o0VaclfEESYU2WRLXVlm41dJ8YFjHg2ZriTsy2gESf6dpWE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA5PR12MB999275.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEM0UklsdjFjc1Y3L1QvSlBGTVVLZWJOZThScnZHMEtySVhYeiswSENWZjlH?=
 =?utf-8?B?dTBlYjIxS1pVeURNOHZ3M21vbExWdU1BWStxc1hQcVlxcHFWaUVPd01zaEVJ?=
 =?utf-8?B?enRpbHZHUTdkeFl3Z0FheXJBVFdHNWRMamp4YTRwWlJJU1d3bXdjYnJiRi9m?=
 =?utf-8?B?dmVEeEx0MkhWUGVLb2dIVEVOTmViekl2cmZ1Z1ZFSXdqWDhYRktJaXdGUnUz?=
 =?utf-8?B?RVN3MHBILzd6MWdGU1RLSDd0TXhNN2NRYnNTR29Nc1V1eXJLay9sYkpKSndX?=
 =?utf-8?B?elJLUVZYR2x3c1ZEaStjUndjNk5qNnhHZjRDeVdmVk9JdklhQ2UzN3pqeXNN?=
 =?utf-8?B?OVR4Q0hTVXh1SXhXb1I3MlFMQkt6NmkwVWlPb0hnaDlNSmx4cHplRjVHMy9C?=
 =?utf-8?B?b2hHaXVqdDVNSlo3SVBXQUk1eCt2L3hOU29RM3M5alBXcDg5UVVKT2FQMEVS?=
 =?utf-8?B?eThWRzM3TWxNSEZqUmZjbktJR1ZjK2wweHJxejN3bGZyQ2lKRUZyeTAwdlVV?=
 =?utf-8?B?S3ZUMDgrV0tWNHNsMFJNSUZpSWc2cGNHRVdnVGU2bWxWNXE2UG0wTTRScVQw?=
 =?utf-8?B?WmpXSE9lalBJWEhuY1ZGVGZxZ0xDYVR1M3lFa0JteDJXRms1a0U3cDJWQ2hL?=
 =?utf-8?B?bHpQKzNPM2pSUVhyLzd6UjBLVktZOWNxMDdLZythcjZJOGcvOGNhTUN3NUVz?=
 =?utf-8?B?S2Qrb1NZQStBUzRobzE3d3RWeTFwaXovMXc5UmdvVnFDSGlDM0k4MGZlbUxu?=
 =?utf-8?B?SWVKYk0yS3BlWEd4N3pIQUViNmMwOGZjRlVtSnlIOG9QVzdSenZHb3VrNE5l?=
 =?utf-8?B?dVhTNFVjY2JucVJHekFzZkR2RGNZYm5lOHlsYVdqeEY0a2toQ1AzU1BvajRm?=
 =?utf-8?B?WHd4a3AzNk9aWkxwOVhTK0dDWnBZdk15YWtPUEFpZ1VBeENqazdXK2pCNU1t?=
 =?utf-8?B?MExPamlqMFcyK3ZEcThpSmhxU21mcktsNUdTMTF5dzlrT1ROVFVIcnh5SmpW?=
 =?utf-8?B?ZFo2SzI4Vzd4a0dOMmlYRGl6ZFhVWXVOUEpKL1I4VUNsNE95TTNubmRyazJv?=
 =?utf-8?B?cEVjYzNHWDNsYUJxSnBmK25ZUDdHMG9TeERvcm8rc0Q3NldnMjBVenJJSktx?=
 =?utf-8?B?WUd2RDY1UmtXRlFZVWU1ZDdObEtCdzUySGYrM1hPbUV4MTEwOWVPcFpzb0dJ?=
 =?utf-8?B?d3pGZkpJTHRRdEJiZ3NoN3BlQ0E0OHdQY2F1NlRZdThtQmxvVm10dHkrdU1W?=
 =?utf-8?B?bnU4TDVFMlIvaHdJTGNVek5LakZPZ0lGbncvQkkvVG1JeHlFaWJNRDBNWDA4?=
 =?utf-8?B?anY3OXJYeTVsTGM1Z2RPb0tyRUFDd1Y3ZGllUVdPY21CMGhmMnAzTHZFQUdG?=
 =?utf-8?B?MjNGRUNNcGRwUlhNZWI3c2ZxN2dDQTB1SkszUjMyQkdMcElPTXFNQzl5bXJw?=
 =?utf-8?B?WVlGTkRDOUZRemFFZFR4MjJOZEdMdGVrOXVXeVR0QlZYeGozRU11ZDd1Mnhs?=
 =?utf-8?B?QktqaDFzcGE2UlpaRVM3Z2VMMnc4MElDTFBhQWVrQjlLTVUvVWU4K3pXcjZI?=
 =?utf-8?B?MjVpd1dvb1l4SGZZL1p0czlYcUNVb29BVjFNejFHNkhLT1pZOGptazhrLzJV?=
 =?utf-8?B?U250dHlqZWFwbFFoMXBZWUU4UGl5bnRVdEFxdmF5QjV0cU1lQTNZZXdmR2tD?=
 =?utf-8?B?ZmpOQnRuZnNXWXRlTHdNMUVQYUYybEl2N1A3N0xvQVRQZ2ptOXVQby9YVjVo?=
 =?utf-8?B?RDlRR2l3YWFoRXZpMFJYa2FTM1FzTWtkRzJWZjRjcDhPMENXTmI2ZXFnZkRC?=
 =?utf-8?B?M3U5RUdmTmJ5MDJJdU0yNTdOanpEL2p1NEFnRFkycHJpV202QnZXdWk0eW53?=
 =?utf-8?B?MVl1aFlpK2haMzdzNDJySkN2YWVROGxlV1cvRFd0cFFiTzIvMk1ya3VLb0E1?=
 =?utf-8?B?K1Q3alc4NDU1dlBaZGlDL1BkbFppRGQ3WUFxQlRYL2hQZjVyNkFPMFJQeG95?=
 =?utf-8?B?VWVKR1AxZFh0cXgyWHI1RkhZSkFpQm9CbkRBZnIya1dzQjZnNzRUZ09aZWZi?=
 =?utf-8?B?K2hnT0NuY3pwTHVncGtpRGx2cU5RdHQ1WlVJOGxqRVB5eEFzR3Q3MERGK1F4?=
 =?utf-8?B?alRLdDhmd1hIRHNPdHo5bkVKWjJ4d1ExSDdpcDZKMEFCMmdwOGdZYWtVOHI5?=
 =?utf-8?B?MHdnbnd3M3lwZWg0SkRsNGFoWHl4ZERhb0dNa09mUWFWamFNWnJxMk85M3hZ?=
 =?utf-8?B?enRBeTVJVzlXQ2gyeTlnSHRHSEhjNno4K3ZOT05FaFZRemxZVzhqV1kwYTkx?=
 =?utf-8?Q?34ICl7H0fQwaDQ9k8K?=
Content-Type: multipart/alternative;
 boundary="_000_IA5PR12MB999275B95D9AFD757EFAD742F680C02IA5PR12MB999275_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA5PR12MB999275.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3772206-be0b-48f0-4c7d-08dee8863364
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 06:47:01.8039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rYwgqKToJWobTaoSjS1O0O/WHyVrdb2eacUVvS57gf9ipXSaMenSr8HD5ex6gtY4Kv2r6lSKfXhKs6nXt/g3+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358
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

--_000_IA5PR12MB999275B95D9AFD757EFAD742F680C02IA5PR12MB999275_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQpPbiAyMy0wNy0yMDI2IDA5OjI5LCBLYW5hbGEgUmFtYWxpbmdlc3dhcmEgUmVkZHkgd3JvdGU6
DQoNClNldCB0aGUgZGVmYXVsdCByZXNldCBtZXRob2QgdG8gbW9kZTIgZm9yIFNNVSAxNS4wLjUu
DQoNCg0KDQpTaWduZWQtb2ZmLWJ5OiBLYW5hbGEgUmFtYWxpbmdlc3dhcmEgUmVkZHkgPEthbmFs
YS5SYW1hbGluZ2Vzd2FyYVJlZGR5QGFtZC5jb20+PG1haWx0bzpLYW5hbGEuUmFtYWxpbmdlc3dh
cmFSZWRkeUBhbWQuY29tPg0KUmV2aWV3ZWQtYnk6IFByYXRpayBWaXNod2FrYXJtYSA8UHJhdGlr
LlZpc2h3YWthcm1hQGFtZC5jb208bWFpbHRvOlByYXRpay5WaXNod2FrYXJtYUBhbWQuY29tPj4N
Cg0KDQoNCi0tLQ0KDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjEuYyB8IDEgKw0K
DQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCg0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3NvYzIxLmMNCg0KaW5kZXggNzEzNzQ2YTc1ZDFmLi4xZjlhOWM0NjM3N2EgMTAwNjQ0DQoN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmMNCg0KKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjEuYw0KDQpAQCAtNDA3LDYgKzQwNyw3IEBAIHNvYzIx
X2FzaWNfcmVzZXRfbWV0aG9kKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KDQogIGNhc2Ug
SVBfVkVSU0lPTigxNCwgMCwgNCk6DQoNCiAgY2FzZSBJUF9WRVJTSU9OKDE0LCAwLCA1KToNCg0K
ICBjYXNlIElQX1ZFUlNJT04oMTUsIDAsIDApOg0KDQorIGNhc2UgSVBfVkVSU0lPTigxNSwgMCwg
NSk6DQoNCiAgY2FzZSBJUF9WRVJTSU9OKDE1LCAwLCA5KToNCg0KICAgICAgICAgcmV0dXJuIEFN
RF9SRVNFVF9NRVRIT0RfTU9ERTI7DQoNCiAgZGVmYXVsdDoNCg==

--_000_IA5PR12MB999275B95D9AFD757EFAD742F680C02IA5PR12MB999275_
Content-Type: text/html; charset="utf-8"
Content-ID: <C4F454A6607ECA42A181075FD3247775@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIg
Y29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRv
ciIgY29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTUgKGZpbHRlcmVkIG1lZGl1bSkiPg0KPHN0eWxl
PjwhLS0NCi8qIEZvbnQgRGVmaW5pdGlvbnMgKi8NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6
IkNhbWJyaWEgTWF0aCI7DQoJcGFub3NlLTE6MiA0IDUgMyA1IDQgNiAzIDIgNDt9DQpAZm9udC1m
YWNlDQoJe2ZvbnQtZmFtaWx5OkFwdG9zO30NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6Q29u
c29sYXM7DQoJcGFub3NlLTE6MiAxMSA2IDkgMiAyIDQgMyAyIDQ7fQ0KLyogU3R5bGUgRGVmaW5p
dGlvbnMgKi8NCnAuTXNvTm9ybWFsLCBsaS5Nc29Ob3JtYWwsIGRpdi5Nc29Ob3JtYWwNCgl7bWFy
Z2luOjBjbTsNCglmb250LXNpemU6MTIuMHB0Ow0KCWZvbnQtZmFtaWx5OiJBcHRvcyIsc2Fucy1z
ZXJpZjt9DQphOmxpbmssIHNwYW4uTXNvSHlwZXJsaW5rDQoJe21zby1zdHlsZS1wcmlvcml0eTo5
OTsNCgljb2xvcjpibHVlOw0KCXRleHQtZGVjb3JhdGlvbjp1bmRlcmxpbmU7fQ0KcHJlDQoJe21z
by1zdHlsZS1wcmlvcml0eTo5OTsNCgltc28tc3R5bGUtbGluazoiSFRNTCBQcmVmb3JtYXR0ZWQg
Q2hhciI7DQoJbWFyZ2luOjBjbTsNCglmb250LXNpemU6MTAuMHB0Ow0KCWZvbnQtZmFtaWx5OiJD
b3VyaWVyIE5ldyI7fQ0Kc3Bhbi5IVE1MUHJlZm9ybWF0dGVkQ2hhcg0KCXttc28tc3R5bGUtbmFt
ZToiSFRNTCBQcmVmb3JtYXR0ZWQgQ2hhciI7DQoJbXNvLXN0eWxlLXByaW9yaXR5Ojk5Ow0KCW1z
by1zdHlsZS1saW5rOiJIVE1MIFByZWZvcm1hdHRlZCI7DQoJZm9udC1mYW1pbHk6Q29uc29sYXM7
fQ0Kc3Bhbi5FbWFpbFN0eWxlMjENCgl7bXNvLXN0eWxlLXR5cGU6cGVyc29uYWwtY29tcG9zZTt9
DQouTXNvQ2hwRGVmYXVsdA0KCXttc28tc3R5bGUtdHlwZTpleHBvcnQtb25seTsNCglmb250LXNp
emU6MTAuMHB0Ow0KCW1zby1saWdhdHVyZXM6bm9uZTt9DQpAcGFnZSBXb3JkU2VjdGlvbjENCgl7
c2l6ZTo2MTIuMHB0IDc5Mi4wcHQ7DQoJbWFyZ2luOjcyLjBwdCA3Mi4wcHQgNzIuMHB0IDcyLjBw
dDt9DQpkaXYuV29yZFNlY3Rpb24xDQoJe3BhZ2U6V29yZFNlY3Rpb24xO30NCi0tPjwvc3R5bGU+
PCEtLVtpZiBndGUgbXNvIDldPjx4bWw+DQo8bzpzaGFwZWRlZmF1bHRzIHY6ZXh0PSJlZGl0IiBz
cGlkbWF4PSIxMDI2IiAvPg0KPC94bWw+PCFbZW5kaWZdLS0+PCEtLVtpZiBndGUgbXNvIDldPjx4
bWw+DQo8bzpzaGFwZWxheW91dCB2OmV4dD0iZWRpdCI+DQo8bzppZG1hcCB2OmV4dD0iZWRpdCIg
ZGF0YT0iMSIgLz4NCjwvbzpzaGFwZWxheW91dD48L3htbD48IVtlbmRpZl0tLT4NCjwvaGVhZD4N
Cjxib2R5IGxhbmc9IkVOLUlOIiBsaW5rPSJibHVlIiB2bGluaz0icHVycGxlIiBzdHlsZT0id29y
ZC13cmFwOmJyZWFrLXdvcmQiPg0KPGRpdiBjbGFzcz0iV29yZFNlY3Rpb24xIj4NCjxwPjxvOnA+
Jm5ic3A7PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+T24gMjMtMDctMjAyNiAwOToy
OSwgS2FuYWxhIFJhbWFsaW5nZXN3YXJhIFJlZGR5IHdyb3RlOjxvOnA+PC9vOnA+PC9wPg0KPGJs
b2NrcXVvdGUgc3R5bGU9Im1hcmdpbi10b3A6NS4wcHQ7bWFyZ2luLWJvdHRvbTo1LjBwdCI+DQo8
cHJlPlNldCB0aGUgZGVmYXVsdCByZXNldCBtZXRob2QgdG8gbW9kZTIgZm9yIFNNVSAxNS4wLjUu
PG86cD48L286cD48L3ByZT4NCjxwcmU+PG86cD4mbmJzcDs8L286cD48L3ByZT4NCjxwcmU+U2ln
bmVkLW9mZi1ieTogS2FuYWxhIFJhbWFsaW5nZXN3YXJhIFJlZGR5IDxhIGhyZWY9Im1haWx0bzpL
YW5hbGEuUmFtYWxpbmdlc3dhcmFSZWRkeUBhbWQuY29tIj4mbHQ7S2FuYWxhLlJhbWFsaW5nZXN3
YXJhUmVkZHlAYW1kLmNvbSZndDs8L2E+PG86cD48L286cD48L3ByZT4NCjwvYmxvY2txdW90ZT4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJtc28tZmFyZWFzdC1sYW5ndWFnZTpF
Ti1VUyI+UmV2aWV3ZWQtYnk6PC9zcGFuPg0KPHNwYW4gc3R5bGU9Im1zby1mYXJlYXN0LWxhbmd1
YWdlOkVOLVVTIj5QcmF0aWsgVmlzaHdha2FybWEgJmx0OzxhIGhyZWY9Im1haWx0bzpQcmF0aWsu
VmlzaHdha2FybWFAYW1kLmNvbSI+UHJhdGlrLlZpc2h3YWthcm1hQGFtZC5jb208L2E+Jmd0Ozwv
c3Bhbj4NCjxvOnA+PC9vOnA+PC9wPg0KPGJsb2NrcXVvdGUgc3R5bGU9Im1hcmdpbi10b3A6NS4w
cHQ7bWFyZ2luLWJvdHRvbTo1LjBwdCI+DQo8cHJlPjxvOnA+Jm5ic3A7PC9vOnA+PC9wcmU+DQo8
cHJlPi0tLTxvOnA+PC9vOnA+PC9wcmU+DQo8cHJlPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zb2MyMS5jIHwgMSArPG86cD48L286cD48L3ByZT4NCjxwcmU+IDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKTxvOnA+PC9vOnA+PC9wcmU+DQo8cHJlPjxvOnA+Jm5ic3A7PC9vOnA+PC9w
cmU+DQo8cHJlPmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjEuYzxvOnA+PC9vOnA+PC9wcmU+DQo8
cHJlPmluZGV4IDcxMzc0NmE3NWQxZi4uMWY5YTljNDYzNzdhIDEwMDY0NDxvOnA+PC9vOnA+PC9w
cmU+DQo8cHJlPi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmM8bzpwPjwv
bzpwPjwvcHJlPg0KPHByZT4rKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5j
PG86cD48L286cD48L3ByZT4NCjxwcmU+QEAgLTQwNyw2ICs0MDcsNyBAQCBzb2MyMV9hc2ljX3Jl
c2V0X21ldGhvZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik8bzpwPjwvbzpwPjwvcHJlPg0K
PHByZT4gIGNhc2UgSVBfVkVSU0lPTigxNCwgMCwgNCk6PG86cD48L286cD48L3ByZT4NCjxwcmU+
ICBjYXNlIElQX1ZFUlNJT04oMTQsIDAsIDUpOjxvOnA+PC9vOnA+PC9wcmU+DQo8cHJlPiAgY2Fz
ZSBJUF9WRVJTSU9OKDE1LCAwLCAwKTo8bzpwPjwvbzpwPjwvcHJlPg0KPHByZT4rIGNhc2UgSVBf
VkVSU0lPTigxNSwgMCwgNSk6PG86cD48L286cD48L3ByZT4NCjxwcmU+ICBjYXNlIElQX1ZFUlNJ
T04oMTUsIDAsIDkpOjxvOnA+PC9vOnA+PC9wcmU+DQo8cHJlPiAmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcmV0dXJuIEFNRF9SRVNFVF9NRVRIT0RfTU9ERTI7PG86
cD48L286cD48L3ByZT4NCjxwcmU+ICBkZWZhdWx0OjxvOnA+PC9vOnA+PC9wcmU+DQo8L2Jsb2Nr
cXVvdGU+DQo8L2Rpdj4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_IA5PR12MB999275B95D9AFD757EFAD742F680C02IA5PR12MB999275_--
