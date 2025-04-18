Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE9FC369AB
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 08:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B60A10EB79;
	Fri, 18 Apr 2025 08:14:40 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11022141.outbound.protection.outlook.com [52.101.126.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FE2E10E3E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 00:30:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewOCSjnfiA7+1fOgTZI5kSVoAyQNoqiubrFaNXzQ3abN4ZxRhHmm7H6PoSqEulo4NaaJS2obbLmO53OQuxxfl2iVQoNt+uT0CxLEQWfdyELFN3kGT8uTSeXeuZtIUgA1xOv5EVPMeNoVop5ynqPYur2uEzb3ET8b7Ci7nnPDb3gRFWJ/oL3e1QjaHiJt71Rn2q7CxESmIXUyTssL5GDPQvm3e5UtL8UlNsjslliMUxR3s2AmSpwWPXXWhdIZlhtAzQLnB4t/1OEiWFSRq7TCdJS9IEvB4X14iLKIawpcZpNlM46jtMN3IY3q9y6WSRj2AoDNzT5S/bJnyMJvxoRwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcJMTKdMkm4TTHn2p9JVheq4q3Od8GznN+gTnTu3ew4=;
 b=pRHU43igYRQs51oOWXs2G0NSKINxR/kR1LM/zOAI0CBUY1sEWgArG1w61hhfUOlcmZmNmNEynm0689XzhTsXrvy7B/G/N/Pqdjjc58+cf775Pb/WP3uTLdRN/wuOskSC7UIQw6BkLQZ3RhDszOex1oonDqbpnhlon4pK0QMqLDgus8+mzDT3eXxe/RhEXhb98g8+Uvey/TQ0HeAOhWgrgIpYQ23B4RTzvFUCyXwCpYTmUNIaB0gPtCchnx0Cm/qgWC1kEBRowH1Ix7JhIF1s9VcFpHF3b4IyqGUZYDasPPnjLjCQZNsEsyYsZlpFnutMTZZC03aehxNAoEVKGEPgqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SI2PR06MB5386.apcprd06.prod.outlook.com (2603:1096:4:1ed::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.46; Fri, 18 Apr 2025 00:30:20 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 00:30:19 +0000
From: Fugang Duan <fugang.duan@cixtech.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: Alexey Klimov <alexey.klimov@linaro.org>, "alexander.deucher@amd.com"
 <alexander.deucher@amd.com>, "frank.min@amd.com" <frank.min@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "david.belanger@amd.com"
 <david.belanger@amd.com>, "christian.koenig@amd.com"
 <christian.koenig@amd.com>, Peter Chen <peter.chen@cixtech.com>,
 cix-kernel-upstream <cix-kernel-upstream@cixtech.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtSRUdSRVNTSU9OXSBhbWRncHU6IGFzeW5jIHN5?=
 =?utf-8?B?c3RlbSBlcnJvciBleGNlcHRpb24gZnJvbSBoZHBfdjVfMF9mbHVzaF9oZHAo?=
 =?utf-8?Q?)?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUkVHUkVTU0lPTl0gYW1kZ3B1OiBhc3luYyBzeXN0ZW0gZXJy?=
 =?utf-8?B?b3IgZXhjZXB0aW9uIGZyb20gaGRwX3Y1XzBfZmx1c2hfaGRwKCk=?=
Thread-Index: AQHbrjQsyP3jhAPl60GLV5n21BS/cbOlnd8AgACKPQCAADjdgIAApZ2ggADQmoCAAL0tMA==
Date: Fri, 18 Apr 2025 00:30:19 +0000
Message-ID: <SI2PR06MB5041A0BB912EBBC0032A94B8F1BF2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
 <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <D980Y4WDV662.L4S7QAU72GN2@linaro.org>
 <CADnq5_NT0syV8wB=MZZRDONsTNSYwNXhGhNg9LOFmn=MJP7d9Q@mail.gmail.com>
 <SI2PR06MB504138A5BEA1E1B3772E8527F1BC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <CADnq5_M=YiMVvMpGaFhn2T3jRWGY2FrsUwCVPG6HupmTzZCYug@mail.gmail.com>
In-Reply-To: <CADnq5_M=YiMVvMpGaFhn2T3jRWGY2FrsUwCVPG6HupmTzZCYug@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SI2PR06MB5386:EE_
x-ms-office365-filtering-correlation-id: 52e25540-e001-409c-bad0-08dd7e1032e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aXU3S1VCMW5uOVFpbzVSZnYvakEwdkFFWU9YL2VQaGVwelhQNENIVVV4SzlF?=
 =?utf-8?B?eVNvVWIyQSsyUUFEdDB3NC9LZlZxd0FVTGhJSTV6WTZVZzRSLzlyODBKNXls?=
 =?utf-8?B?aTVxNWlVRmRRSUJlcmFxVXJhSHRMek5rb1FIRTBoR1RGSktrTit2WERQVmZ2?=
 =?utf-8?B?dFpBV21ESEEzNEdQRjRGb3ZJTlVadjFCK1I1QVBvT3NXbXcxRVB2VlFrSEQ1?=
 =?utf-8?B?bWxYU2RSL1BuenMrWTZyKzJSMWNoZmQ0WmFucXNNRndseG9VL2kzZzFlRmFS?=
 =?utf-8?B?a3hyUEkwdHBrcnpjTk9UdCs4b0pkeGh3b1RYY2pkdlFuUkljcy9jUHY1THBN?=
 =?utf-8?B?TmdWYVRKY0JUcEhWU3hIekxaSjEvaXBaSTRYZVhJeHZQZVUvVS9qcUJiMjdz?=
 =?utf-8?B?bHAvZlBCazkxaCt1QW1pSlh1Z1Jrd1NKNlV5Z1BxaS8zeGFkNGdrajdXTGkw?=
 =?utf-8?B?QS83WisvRUhKMlphVlhEWU1YZ01YVmN3M21uOG0xMG43VHNxeUdpRFZCYWpL?=
 =?utf-8?B?ditpY3hDMmEwV1kxanBXRHhDbmZKRnUwNUowYmQrUk9peDFBNDM2QVo5NUYw?=
 =?utf-8?B?VW9rZjdTQnBnQi9kWjYzUnZuQ0tGNzhNUVlTbkNGNEh4MFRGT09vbDhKSWFN?=
 =?utf-8?B?RnpTV0tYWHgxTjFENDZLZXFKcUdCZEhKVFZiSUxNUHlvWkxiVGpITUsvczRo?=
 =?utf-8?B?a3V3ZlFQd3NwOW1RcHFCTU1DcTFPZVQ4bk9FWEdyWmRrcjAxY2k0Qktyd3Q0?=
 =?utf-8?B?UVpmY2dIRUVEamZySDR4WUlTUlhLU1NEL0wzSWZ6NmUza3AvOEprOU0ydDRv?=
 =?utf-8?B?Q2hENjJ5N3Nqd0c2MWpSQ2RiQVFJbjdsVEc2YW1qTms2YVlUaXVUcytIZXRw?=
 =?utf-8?B?MWQ1TGhpTlRUbGFsRE1Hb3FyRTZtbU84RC9GZU9DMWVvSmFQUHoyYVBFaGlW?=
 =?utf-8?B?bk9WdXJiU0RPamFiM1ExSEFyRlVQMmRJOERCUTFGN1lNbEl4SE9mekk5WXln?=
 =?utf-8?B?ZGRDaWVNMWN0ZEtzUnJBcWw2Wjl6SFpGaXFsdmtFUndZamM0RjJYMEtLV3A3?=
 =?utf-8?B?YmJZdW9lQWVTUk9uYVV4UG1GRkhvaWsvNElSeXZ1czUrZGxMQlVBY2VaVjk5?=
 =?utf-8?B?T1UvNFAvd0t2WWZOZjh3cFN2aXZ3Q0tDeUpBWjN6MGF3YWVvUmY5OGdxMjdH?=
 =?utf-8?B?UkY2eVl4K2RoUndOTklETU92QTNKamF2TERvYStDY1RvWWlDT2k2V2RDWlp4?=
 =?utf-8?B?ZE8xaVN5MkhpS1paVGJydDQ3eWs3U0lGMXR1TW12WHh6K0NNRGFKZ3pVYk5B?=
 =?utf-8?B?SWVZNnhHaVh5cERZVmI2SE8vQzdjM0NZRnZIMWJlTzk3MXNFS2FQcU5HeDU2?=
 =?utf-8?B?eWlYWE5NeHo1ZENKOTdkeXcrL0FYN0tWRXpyR0tDeGJlaHV2c1kzTWs5WjlH?=
 =?utf-8?B?Zy8xbmtXMU55Sy8wbzYyS3UvdlREMW1QUVAwZXVsTlJuSng5TVJUVy9RaUpZ?=
 =?utf-8?B?d05zSVkwRE9NREh6RW5qaDUzMnZhZGtyQ091RVZDU0dzZUFUNHZFMGZwbjdt?=
 =?utf-8?B?T3YrVDZUT1J3dE1wMWdFVWJPRGlyWDlXdkY1VC96OVM4MVRPcklXSFNkbjFp?=
 =?utf-8?B?aVZPbldMQWE0Y2ZHbnhBaGVXczJJK0dVcjFYSHh2cUM5TGxrUGRRdng0YVhq?=
 =?utf-8?B?OEFreFo5NHpYLzFGRTFnSU1zNjZSRXlKNVZ1RTZMOE1SbFVGVEVEUW5HaTh5?=
 =?utf-8?B?YkJ6V3hqM2hrUWVaZGVDQm5FUTRUQm1sZ2JBNHdwSVFWMUdFc0ZQM2M2aWph?=
 =?utf-8?B?eWtSMHY1dUg2amVpR04zREdGYnZEdCszMThrVko2NG41TG4zY0NiZTVWSC9X?=
 =?utf-8?B?MGc1Y0RNdGV0V1pzcUFyQWVYYmU3YU83WTR4emdxbHpLNGJZK3BZWjRqVTI3?=
 =?utf-8?B?bDF1Rkp2c1RWak5TZUhiRFhueXlSTStGN0VLVUZDSGtHdWVGU2VabmJSNm05?=
 =?utf-8?Q?AAzAVIw7YZbIAqFmWneVxrZkGLzgxc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWdTUGwyZXc3K3RqWVhJRnJRS0tsZ3NOQzh0RnIzL29zRW9vV0tKQkZLNGN2?=
 =?utf-8?B?alhVVXZaZ0U2T3QxMkR4cE91WGhEY3JaSmNmSWdMcUVkUHloTGNGU0d0UEVr?=
 =?utf-8?B?cExETUs2a0xDQ0JXb3ZkbS81L2RlN1QyRUY5UkdVd2NkMmNCaGpjbHcyaENu?=
 =?utf-8?B?MldXTnJtZUJNRXdlRS9POGp6MHBraVNzYkxCcGxEaUNRaWhmZHd1VXdRTE5M?=
 =?utf-8?B?YUxHcnVPLzM3dXZqRDU4N1hSVW85QW1aRnFBd2ZFRTJYTTJpKy9KNTZBZ2NY?=
 =?utf-8?B?SmFZOXN2RlBNZXkwZW15TE1ZNlprUStmVFUveGg2MnlVUG8yUHQ2MzNCdUlx?=
 =?utf-8?B?VVFVZmJzU00yTkpLSFU1RWJXRTBJNGkyb2t0UkY2NTVVU0FGY0IvMXdmTTV6?=
 =?utf-8?B?aWZvS1h4b2dCYVN5T1dUbFJCYWROZWJkK093MlpzT2NLdGpmNHZwSHhTWVBp?=
 =?utf-8?B?eXliSUdFSWdJY2w4ODJ4bS85czB0VXM3b0NPR0p1ZW9nVmsydklSUFBZZDNR?=
 =?utf-8?B?UGNJZWtVTlFuUFV3M0pJUlBEU2JkUVhWZ1B3cmZ1N05PREg0dXBUVTJhMHFP?=
 =?utf-8?B?NTRWZzBUVEtKdzQrTjRUQytxTExSbmhnRzJXZ242QlI4US9XV0VKOXNvVlNT?=
 =?utf-8?B?OWt5SjBxcEdQaGc1UG9TT1gwbTY5bXBZUy8waEswaFlPek5uQmZIaTVnMEZC?=
 =?utf-8?B?MDBkeU9qeWdCWE1LNXRVc3RSZ2VvVTByYXQ4OHVVWC82U0l4RTNDRElYMDZn?=
 =?utf-8?B?VXJyZmhnNEZmaGZHV2YwanU4VHlZVVRFTGtXWGgzeFRkMmUrVXFoamNEbEtQ?=
 =?utf-8?B?OU9EUFp2ZkJQRWhwOUdMTEc4RGpURHloU2FYamFFZ3N5ODA3d1M2ZnZPcmJm?=
 =?utf-8?B?bjl2bnBCWFhPRmVZUklIVys1NnlmeWxaYlBmejNEN1pQemR6K0hxd2NWbzBO?=
 =?utf-8?B?TElwL0xxSFpSc0Q5aHRrelh2cWs4a3pzdm5YdTVSdXRQM1hkdStPNDlNQzVT?=
 =?utf-8?B?aWl4TlJGZHhmZjJ1MTVLbk1iVXJDTGVaZFM4N1VZT3I3WWtCc2t0ZEtTaEcr?=
 =?utf-8?B?VmF4Y0JsdzVUR2pwTUtHR2hFU21ySmlOcWE4L3J3MWo0cDcxQW0vK3FPNXpw?=
 =?utf-8?B?cWxwRGVibTJSVnh6L0JjemtqemI3bUtXQXNwV1ZxNkRwT2JndnJoK0hvTVhG?=
 =?utf-8?B?ODR5emhkbWFOTzkvVWVsWElSRzVDUStTSWl0TkNRVDNWTW1kMndNV09hdWx2?=
 =?utf-8?B?ZU4wQXkxa2RON29YbC81MkI3Sk9SNFFGUG1mYTc2dEFTZ2tsM00zY3kxSTNW?=
 =?utf-8?B?a2daeUZtTVRBak9VbnZhR29pYjNzQlFvSlZlYU1TRzQ3akdtOEdDYWMvd01E?=
 =?utf-8?B?VXo2YURqYURKWGVnanVRQlozTFNac0U4MlhZNGxRaHUzelRPd1dRWW5DMzA2?=
 =?utf-8?B?QlZvYmZxUEJDbkYwamh1b3dsZVJBYnV0NTdKSzkvRkJUd0NOY0ZzV2hkcXBl?=
 =?utf-8?B?VExqRldVV3FwV093aFRlRVBnVWhEUWQ1SHlzaE95SUxqRWNLSk9lU0xRczJj?=
 =?utf-8?B?dmtBT3VSaTB0WE95N2U0YU50R3B0UlFGVkFvZFJZSXd0elJqdFpOTFVkTEV1?=
 =?utf-8?B?RVlkNjc4WmhTZzRqR1JhaW9vaXZWRFZ4VndsWGgyeTh2d0xyT3kvRW1XbmlY?=
 =?utf-8?B?Y28wMjI1dlhFYW1jVlNaUUpwMGRpVDBKa0VvYjBlakpJYnprYTVPZngxcDNW?=
 =?utf-8?B?RWpLVWNGdHVwckN0Uk41OXpqV1hwUHRhOVpvQ29Ncll3VVd3d05KZDJuL092?=
 =?utf-8?B?Z284SEtmbXZmNTZ5UHI2eDZhMDVpTk1kbzRPaUI3T2htdFFleHZaTWRobkNT?=
 =?utf-8?B?NlJpZEFjQ1NueWRvL0ZyNXBiYkZYcnErM2IvRW42N20yNnBIeCtQUHMvMHpC?=
 =?utf-8?B?MlRxUnZON3RmNTJ0WkxDb0M1OUdJOFplcHY1THRaTnEweGhHdEYzVVhwQXlJ?=
 =?utf-8?B?K2w4b0ltODl6UnZIZXNlMHRsT29CNnlhNXhTL04vckxqTTBlTncxSUFqUEd3?=
 =?utf-8?B?OG9nUndPTFNKVXZwSURHd29sWWtzeXNwV2ErcW1aSyt6M1ZDVnNuN0QwRWZn?=
 =?utf-8?Q?UzGEOkpuwAKtD1MmzMwz2uwnd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e25540-e001-409c-bad0-08dd7e1032e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 00:30:19.4571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3tva1w5JjNfjxxpeElv12TSNEWsWnCD4Kvm6qAkBr97fVPOdQTrLA4D9DkzF//kqpxTp+VCwA6oj/YEjVc4kUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5386
X-Mailman-Approved-At: Fri, 18 Apr 2025 08:14:36 +0000
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

5Y+R5Lu25Lq6OiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4g5Y+R6YCB5pe2
6Ze0OiAyMDI15bm0NOaciDE35pelIDIxOjA4DQo+T24gV2VkLCBBcHIgMTYsIDIwMjUgYXQgODo0
M+KAr1BNIEZ1Z2FuZyBEdWFuIDxmdWdhbmcuZHVhbkBjaXh0ZWNoLmNvbT4gd3JvdGU6DQo+Pg0K
Pj4g5Y+R5Lu25Lq6OiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4g5Y+R6YCB
5pe26Ze0OiAyMDI15bm0NOaciDE25pelDQo+MjI6NDkNCj4+ID7mlLbku7bkuro6IEFsZXhleSBL
bGltb3YgPGFsZXhleS5rbGltb3ZAbGluYXJvLm9yZz4gT24gV2VkLCBBcHIgMTYsIDIwMjUgYXQN
Cj4+ID45OjQ44oCvQU0gQWxleGV5IEtsaW1vdiA8YWxleGV5LmtsaW1vdkBsaW5hcm8ub3JnPiB3
cm90ZToNCj4+ID4+DQo+PiA+PiBPbiBXZWQgQXByIDE2LCAyMDI1IGF0IDQ6MTIgQU0gQlNULCBG
dWdhbmcgRHVhbiB3cm90ZToNCj4+ID4+ID4g5Y+R5Lu25Lq6OiBBbGV4ZXkgS2xpbW92IDxhbGV4
ZXkua2xpbW92QGxpbmFyby5vcmc+IOWPkemAgeaXtumXtDogMjAyNeW5tDQNCj7mnIgxNg0KPj4g
PuaXpSAyOjI4DQo+PiA+PiA+PiNyZWd6Ym90IGludHJvZHVjZWQ6IHY2LjEyLi52Ni4xMw0KPj4g
Pj4NCj4+ID4+IFsuLl0NCj4+ID4+DQo+PiA+PiA+PlRoZSBvbmx5IGNoYW5nZSByZWxhdGVkIHRv
IGhkcF92NV8wX2ZsdXNoX2hkcCgpIHdhcw0KPj4gPj4gPj5jZjQyNDAyMGUwNDAgZHJtL2FtZGdw
dS9oZHA1LjA6IGRvIGEgcG9zdGluZyByZWFkIHdoZW4gZmx1c2hpbmcNCj4+ID4+ID4+SERQDQo+
PiA+PiA+Pg0KPj4gPj4gPj5SZXZlcnRpbmcgdGhhdCBjb21taXQgXl4gZGlkIGhlbHAgYW5kIHJl
c29sdmVkIHRoYXQgcHJvYmxlbS4NCj4+ID4+ID4+QmVmb3JlIHNlbmRpbmcgcmV2ZXJ0IGFzLWlz
IEkgd2FzIGludGVyZXN0ZWQgdG8ga25vdyBpZiB0aGVyZQ0KPj4gPj4gPj5zdXBwb3NlZCB0byBi
ZSBhIHByb3BlciBmaXggZm9yIHRoaXMgb3IgbWF5YmUgc29tZW9uZSBpcw0KPj4gPj4gPj5pbnRl
cmVzdGVkIHRvIGRlYnVnIHRoaXMgb3INCj4+ID5oYXZlIGFueSBzdWdnZXN0aW9ucy4NCj4+ID4+
ID4+DQo+PiA+PiA+IENhbiB5b3UgcmV2ZXJ0IHRoZSBjaGFuZ2UgYW5kIHRyeSBhZ2Fpbg0KPj4g
Pj4gPiBodHRwczovL2dpdGxhYi5jb20vbGludXgta2VybmVsL2xpbnV4Ly0vY29tbWl0L2NmNDI0
MDIwZTA0MGJlMzVkZg0KPj4gPj4gPiAwNWINCj4+ID4+ID4gNjgyYjU0NmIyNTVlNzRhNDIwZg0K
Pj4gPj4NCj4+ID4+IFBsZWFzZSByZWFkIG15IGVtYWlsIGluIHRoZSBmaXJzdCBwbGFjZS4NCj4+
ID4+IExldCBtZSBxdW90ZSBqdXN0IGluIGNhc2U6DQo+PiA+Pg0KPj4gPj4gPlRoZSBvbmx5IGNo
YW5nZSByZWxhdGVkIHRvIGhkcF92NV8wX2ZsdXNoX2hkcCgpIHdhcw0KPj4gPj4gPmNmNDI0MDIw
ZTA0MCBkcm0vYW1kZ3B1L2hkcDUuMDogZG8gYSBwb3N0aW5nIHJlYWQgd2hlbiBmbHVzaGluZw0K
Pj4gPj4gPkhEUA0KPj4gPj4NCj4+ID4+ID5SZXZlcnRpbmcgdGhhdCBjb21taXQgXl4gZGlkIGhl
bHAgYW5kIHJlc29sdmVkIHRoYXQgcHJvYmxlbS4NCj4+ID4NCj4+ID5XZSBjYW4ndCByZWFsbHkg
cmV2ZXJ0IHRoZSBjaGFuZ2UgYXMgdGhhdCB3aWxsIGxlYWQgdG8gY29oZXJlbmN5DQo+PiA+cHJv
YmxlbXMuICBXaGF0IGlzIHRoZSBwYWdlIHNpemUgb24geW91ciBzeXN0ZW0/ICBEb2VzIHRoZSBh
dHRhY2hlZCBwYXRjaA0KPmZpeCBpdD8NCj4+ID4NCj4+ID5BbGV4DQo+PiA+DQo+PiA0SyBwYWdl
IHNpemUuICBXZSBjYW4gdHJ5IHRoZSBmaXggaWYgd2UgZ290IHRoZSBlbnZpcm9ubWVudC4NCj4N
Cj5PSy4gIHRoYXQgcGF0Y2ggd29uJ3QgY2hhbmdlIGFueXRoaW5nIHRoZW4uICBDYW4geW91IHRy
eSB0aGlzIHBhdGNoIGluc3RlYWQ/DQo+DQo+QWxleA0KPg0KQWxleCwgaXQgaXMgdmVyeSBzb3Jy
eSB0aGF0IG91ciB0ZWFtIGRvbid0IGhhdmUgdGhlIEdQVSBjYXJkIGluIGhhbmRzLg0KSXQgaXMg
YmV0dGVyIHRvIGFzayBhbWQgZ2Z4IHRlYW0gaGVscCB0byB0cnkgdGhlIGZpeGVzLg0KDQo+Pg0K
Pj4gRnVnYW5nDQo+Pg0KPj4NCj4+DQo+PiBUaGlzIGVtYWlsIChpbmNsdWRpbmcgaXRzIGF0dGFj
aG1lbnRzKSBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eQ0KPnRvIHdo
aWNoIGl0IGlzIGFkZHJlc3NlZCBhbmQgbWF5IGNvbnRhaW4gaW5mb3JtYXRpb24gdGhhdCBpcyBw
cml2aWxlZ2VkLA0KPmNvbmZpZGVudGlhbCBvciBvdGhlcndpc2UgcHJvdGVjdGVkIGZyb20gZGlz
Y2xvc3VyZS4gVW5hdXRob3JpemVkIHVzZSwNCj5kaXNzZW1pbmF0aW9uLCBkaXN0cmlidXRpb24g
b3IgY29weWluZyBvZiB0aGlzIGVtYWlsIG9yIHRoZSBpbmZvcm1hdGlvbiBoZXJlaW4NCj5vciB0
YWtpbmcgYW55IGFjdGlvbiBpbiByZWxpYW5jZSBvbiB0aGUgY29udGVudHMgb2YgdGhpcyBlbWFp
bCBvciB0aGUgaW5mb3JtYXRpb24NCj5oZXJlaW4sIGJ5IGFueW9uZSBvdGhlciB0aGFuIHRoZSBp
bnRlbmRlZCByZWNpcGllbnQsIG9yIGFuIGVtcGxveWVlIG9yIGFnZW50DQo+cmVzcG9uc2libGUg
Zm9yIGRlbGl2ZXJpbmcgdGhlIG1lc3NhZ2UgdG8gdGhlIGludGVuZGVkIHJlY2lwaWVudCwgaXMg
c3RyaWN0bHkNCj5wcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBp
ZW50LCBwbGVhc2UgZG8gbm90IHJlYWQsIGNvcHksDQo+dXNlIG9yIGRpc2Nsb3NlIGFueSBwYXJ0
IG9mIHRoaXMgZS1tYWlsIHRvIG90aGVycy4gUGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyDQo+aW1t
ZWRpYXRlbHkgYW5kIHBlcm1hbmVudGx5IGRlbGV0ZSB0aGlzIGUtbWFpbCBhbmQgYW55IGF0dGFj
aG1lbnRzIGlmIHlvdQ0KPnJlY2VpdmVkIGl0IGluIGVycm9yLiBJbnRlcm5ldCBjb21tdW5pY2F0
aW9ucyBjYW5ub3QgYmUgZ3VhcmFudGVlZCB0byBiZSB0aW1lbHksDQo+c2VjdXJlLCBlcnJvci1m
cmVlIG9yIHZpcnVzLWZyZWUuIFRoZSBzZW5kZXIgZG9lcyBub3QgYWNjZXB0IGxpYWJpbGl0eSBm
b3IgYW55DQo+ZXJyb3JzIG9yIG9taXNzaW9ucy4NCg0KDQpUaGlzIGVtYWlsIChpbmNsdWRpbmcg
aXRzIGF0dGFjaG1lbnRzKSBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0
eSB0byB3aGljaCBpdCBpcyBhZGRyZXNzZWQgYW5kIG1heSBjb250YWluIGluZm9ybWF0aW9uIHRo
YXQgaXMgcHJpdmlsZWdlZCwgY29uZmlkZW50aWFsIG9yIG90aGVyd2lzZSBwcm90ZWN0ZWQgZnJv
bSBkaXNjbG9zdXJlLiBVbmF1dGhvcml6ZWQgdXNlLCBkaXNzZW1pbmF0aW9uLCBkaXN0cmlidXRp
b24gb3IgY29weWluZyBvZiB0aGlzIGVtYWlsIG9yIHRoZSBpbmZvcm1hdGlvbiBoZXJlaW4gb3Ig
dGFraW5nIGFueSBhY3Rpb24gaW4gcmVsaWFuY2Ugb24gdGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1h
aWwgb3IgdGhlIGluZm9ybWF0aW9uIGhlcmVpbiwgYnkgYW55b25lIG90aGVyIHRoYW4gdGhlIGlu
dGVuZGVkIHJlY2lwaWVudCwgb3IgYW4gZW1wbG95ZWUgb3IgYWdlbnQgcmVzcG9uc2libGUgZm9y
IGRlbGl2ZXJpbmcgdGhlIG1lc3NhZ2UgdG8gdGhlIGludGVuZGVkIHJlY2lwaWVudCwgaXMgc3Ry
aWN0bHkgcHJvaGliaXRlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwg
cGxlYXNlIGRvIG5vdCByZWFkLCBjb3B5LCB1c2Ugb3IgZGlzY2xvc2UgYW55IHBhcnQgb2YgdGhp
cyBlLW1haWwgdG8gb3RoZXJzLiBQbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkg
YW5kIHBlcm1hbmVudGx5IGRlbGV0ZSB0aGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGlm
IHlvdSByZWNlaXZlZCBpdCBpbiBlcnJvci4gSW50ZXJuZXQgY29tbXVuaWNhdGlvbnMgY2Fubm90
IGJlIGd1YXJhbnRlZWQgdG8gYmUgdGltZWx5LCBzZWN1cmUsIGVycm9yLWZyZWUgb3IgdmlydXMt
ZnJlZS4gVGhlIHNlbmRlciBkb2VzIG5vdCBhY2NlcHQgbGlhYmlsaXR5IGZvciBhbnkgZXJyb3Jz
IG9yIG9taXNzaW9ucy4NCg==
