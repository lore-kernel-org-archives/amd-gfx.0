Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006D7FD5307
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 07:45:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88AC610EA50;
	Fri, 27 Feb 2026 07:45:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SzC9n+YE";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8900810EA4F
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 07:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diWUfuDUDwOK4Ld1+UusCwEQcoCcGaRscnDJJCl2UbTMp6RvoE5stF9rk6Rdw9XI6Vu/03JoAIkYK6GBe4gNkPZxCSNFEhmcjVZY/9yd/aqXK5/BtC0YuB/gGITf1m24vEYipwxzSWdCPdJIDOwf+XJKNFj1xW3Wn8jzu9/hS37DvMHtPsfMHepiy6O+KwcZtMr1qMX87UQQ8vEplDNx1zCgQ3xSzl9aVhY0Y4nz7dCE/LG3oqTNCkg3aQx2nzoxJRNA41iBxQnUd1dAnp0S2Qhm5y5Um4UgWxHd650cbErofNNWHT6E70lbn2NZKgmOgTYGGjq/6OnOLYUWx1AHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/6mFvIMTYntwa/MyBS5lJwUSP8vZDsgY0Ua0ee17Rs=;
 b=md61ixfDllFO6JP6cHkZiRDuiFsNtvdIbgqKLXXDhIjLQ6ggHHA2vzguALu+KbXGzAfHl43MSWF+q3qdlkw9aUYgDj419x+6mRd9hSGki/d5c/CnKVuJk1ITIZ74Y0vK5mKwLynFFF85pwct9JyXlzRzSbWEAD5E2XwE7rlUATWsS1J+QyhIRU3dOkNafDdwO8GylfaqlUwe3UzoMGfValQVLOMuCUFwUoEdaFIOQtVpeQb3t8CBdXeK1d0ZLiQJPKmPBJXzRnISnvjsHyJBcs454zJVbGDRFrkkS1ySz0SuHUeHk1DK2wmFFsC8cy8nsQgPRvYbTCHIhZ17KYp8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/6mFvIMTYntwa/MyBS5lJwUSP8vZDsgY0Ua0ee17Rs=;
 b=SzC9n+YE7fYMJSABbh+R4CxcHlCeKl11Dn1g9WN2IlkStAoCeMktD5RcriyVGL+GDPaCPwyr4vEkHW9ocOLQOli4KB4VGdMH7YH5FAv0kM3pyGQwSIQgnqCfvZSbDAhRe8N5F45W+TpkHHYgTrsXw3m2qVyNrX0skdPmjDb5WkU=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.14; Fri, 27 Feb 2026 07:45:40 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 07:45:40 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: restrict sensor load values to 0-100
Thread-Topic: [PATCH] drm/amd/pm: restrict sensor load values to 0-100
Thread-Index: AQHcpjny217/7Nl9CES1HXuG3NSqnLWTUUCAgAAnDYCAAoKpoIAAD6yAgAAgqwA=
Date: Fri, 27 Feb 2026 07:45:40 +0000
Message-ID: <DM6PR12MB29725599B2FE50BD48D442238273A@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260225093406.498727-1-kevinyang.wang@amd.com>
 <96885b73-a1fc-4b3f-a35e-0177a415a331@amd.com>
 <CADnq5_O4u+v9f5XNFipKHPa1qC6tEr0k4ppZXX0tUqrAjY8PXQ@mail.gmail.com>
 <DM6PR12MB2972FEFE85BC8F6C684E25068273A@DM6PR12MB2972.namprd12.prod.outlook.com>
 <5accd44a-5795-43cc-acf1-a8467038b7a2@amd.com>
In-Reply-To: <5accd44a-5795-43cc-acf1-a8467038b7a2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-27T07:37:08.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|CY5PR12MB6321:EE_
x-ms-office365-filtering-correlation-id: 35a7ef4d-6e13-4c00-e07a-08de75d4345f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: fYL30w8ZHYUpZpADaWQGbhC/3NVHOrLAtzoQaG5XC5I4D/6izJbupnXg+qSWUzG+ShHsGK7JwSIF+jMNPCn0993CRCofZzGsKn+yL0E77vl5NKCh8CHLUu4NVxDPBtCaHP2YSm6iTA32dNe2KQ3ANbyH6uSubpGRBsbRylNun2fYXUJCZmYs0yFN84UL9F2Hk9jlPtWkjH/GwYMCFYqOUNCgitfhAqtJSQowdOjxasgiY80CcLILgxODO0URXoNEI2Yz1yVXykWtWkXePUk2p14sfAG1W/Gz+2bLPqbUwqyQOk2Q/jSZFrbzNztkNVdF9yNgA38g5Ax+K6mW9UtlJAqI56+lGWRz4zJXbsMnnQpPCBOSp5AAVqz9ECcGHrQ+WPki54adQg1HaFueXQLjLugBOmps6KMCAxlc+qlqnvkp8T1UwSJGRkzV2rGiiE9nHF67FM7Ak9jiceZF8/eJpxtmDBnVuFrsH7bR4TdevrSrY1DkNtuqpCoaFF5DjH3giL6v3CO+OMqPpBoXLhWKT3OUPbCp9aQ4MvT4iOr4DO00b+S0emxQOka+9gJ2vy4C0cZWIwOi1eVDdf/rp94KGR3LPnuUPBPJW7YhZoICv46B5mMEXke0B8n4ASGjDGyZtam8stqqARDvHqEXI7yr4uvcR9XAkEUKC4KMGiyrbcCEeT/KfUmPZFVWo4ZbaTpxTl16z+EgCEPx3lovk9ZJz6VMHE/6ggJX17EsFGDU9tSVUge9jmS3OJfNFkR7VVRM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QW9pTHA1VmFxVGFvL09uUE4yQW9QcnpTTlYvbE9WcENNOW5wV3ZSV3dhN3pi?=
 =?utf-8?B?VWxaR3dpaFpiRWpRaVJzZ0tzcVpvaHg0Rk8wcC8zcEgxbjNMRFFDa0RwdVpq?=
 =?utf-8?B?dzRkSVJEL0ZyZUdnTGZlS0R6dExXQVUzaGNGZlNJdDNpaDZZZ3Z4Q0ZvcDVk?=
 =?utf-8?B?Nzgrd3FncUdiL1JXU0QvOU14cGFrZlhOakM2SHRpTVdBajFTZWNJL0ZvOURN?=
 =?utf-8?B?YmVOUkRmMnN3YmlDZjBCdUpadXdtc0hTUGt6UzRFVkV3dlVtd1lCdFlaZVM3?=
 =?utf-8?B?bmxyUE96Z1VRUjRBcXgzTWVncE55Q3RNRU42UUorNy9JUFVwTVdyNkJmUFJR?=
 =?utf-8?B?V3UvaXhnVElCRXpoYnN1QmJEZS8rVmt1VWQ3dlp1cFd3UktZeTBXeXdNaU8w?=
 =?utf-8?B?Ny9ZRUhoRW93OElwTlRZalR5UmV5eExkQzRMd3U1Y01wRXY0MmhPTzhOelJB?=
 =?utf-8?B?RW1CT3Ivdzk1eVlJSy81WVNyZVFwbnNvbTZaWWpTemZuWWhkZS8wRC83RkJ6?=
 =?utf-8?B?TFBLaUhXTkgzdG56SE1ibjZXa2RQdDJYVURFdWFVa0dnSkppRVF4RTVjSWN1?=
 =?utf-8?B?QUk0RjhsY0o3VUY4Tm1YSmVWK1N2NXE2T2xuM2NRbGN0U1QxeVVpZjhGM05J?=
 =?utf-8?B?cFJBMkZrMHVDcjVja1RsVE1SVzBWb2NMTHdIUW9VNlpNczlMYk1WRXhZVkE5?=
 =?utf-8?B?SWxIa3N4NXZDOC9DZyt5Vk9iQ01nbGNOS0tWblRxeW94MFhRRXpqMWZtQjBN?=
 =?utf-8?B?cWNTaXpnVTA3QWVRVk8rOFZxV2Y4TzRIbWxhTTlneitNeGY3ekRQU1RhL2oy?=
 =?utf-8?B?L2Q1enRnRDVHcE90UmFaNG5mVGFDTXdpN0tma0ZPdWF3R2xhTFRNWkhVUk5y?=
 =?utf-8?B?QnZ6dWk1SDhVaWV4cFdNYUtRWE9aQzFZNlJzY1NlK0xxSWlRTTBHZ3F2Ym1w?=
 =?utf-8?B?WThWRTZPbXNWc3A3U2ZSczlLY3hGSTA0SGdpOHkyZ2NCc0dpWDZtNTZ4Sk01?=
 =?utf-8?B?amZlNFhrRTFaT2o5NlB5REhNcldKUitsMkQ1ZUpsMmY5YkFuQmZva3FJL0Qr?=
 =?utf-8?B?RGM5YUkvSW9ORnlZeWFOdU1RbDh5cERYbm12VGxob0llYVZpVC8xRzVnNm9U?=
 =?utf-8?B?cllXWHArcFNKMWJQU3E5WGlnWmd5L3FhOXhzR0YwUTBrTWFNTGx2M1hab1N5?=
 =?utf-8?B?c3cyVjBZYkFEMER4WVdocTduaVZDRGM5TjFvdXpOaUI5Qm5GaGdMTi9Ta2Uz?=
 =?utf-8?B?RU1hWG92NE5rYmREQUVKUW5aQzV0d09GRUkxMjI2VVNKMTZXTHd0L2NCdmd1?=
 =?utf-8?B?aVpGdmNaVHpDb0R5eE92NS9MME9LalpzWEZsTW43VU5GN2k4U2JDLzF1dlhw?=
 =?utf-8?B?U0srNUYvamxzc1VzQm00YkNPWlR3enFURGRYcWxvVllrQ0VVbC95OWpUNjIy?=
 =?utf-8?B?UHR5TlZvaEVqZjVJcmhoZ3JTckhub2RlUTM3RU9ZZXNYeVhmOUIxdEoyUmla?=
 =?utf-8?B?dFBULzkxdXQ2MEtpNW9zY2pqZksveTZVQjBYc0RoaFBGSVFLdndXblo0b1lQ?=
 =?utf-8?B?V2crSXRaSnRsaVNlRDk2ZXgwNXNFUmpJU1dtblVjNXlnSCsxRGR1ZTV4K25Z?=
 =?utf-8?B?VnhaZEhtZ0o4enh0NHJ5aGpja3RLSzJsOTRiNGNPYXhzUk5jNC9nQzhSUUN0?=
 =?utf-8?B?d2h2ZVVVYTdaSzkzY2dOWEFWVlFlL1ZVakQxeU9FVm9VcnJXUkE3dlFOZzUy?=
 =?utf-8?B?aWFHYi9pL3NQbGNiTEZ5SHlzZXUwQk1ZbUtrWFhYU3NVU1VTTDRGRnhhL2dz?=
 =?utf-8?B?QmdJdWVQOWs5cGw2aWtkTVZCc3pEd0pZQVIzeWR3VzVGMks2N1IyYjhVU0xC?=
 =?utf-8?B?RHY4akt3WnRpbHQwaWRhM3dXTGVuVkdRUkYwdngyd1l3WUtzUVNCc0xXSDFl?=
 =?utf-8?B?dEx3cVpZbDd3U0plQTJ6YnVPQ0hjTU9OZURXUTJpT2JUMzhwek1YaENicVp1?=
 =?utf-8?B?S1lZWkk4eUxEN2xZaG5KQktneGk2cU5pL3BHN0M5SXkxVVp6NjJkdTRjN0N1?=
 =?utf-8?B?UlFESGJQenVLajhsVHQ3M3plazBtUnpJaUZkWXczOGZJMjQ0QUpsZndZOXNa?=
 =?utf-8?B?MmZrdXQ5dFZrZDZtbVdkbSsrVEtkSENmMWtSRlZ6MVY0THhZeFRDT3lZV3Qz?=
 =?utf-8?B?YUNOVXYveVQ3MEUxKzBpY2JjeFZFd2llWStXNldiQldyd2ZRQjJDNWRRb2cr?=
 =?utf-8?B?VHlOaVQwSVUwOXY4c05qenBoNi9hWnlocWwvSG1GamxrV0JETWVqUCtuSEtI?=
 =?utf-8?Q?1o3ohHyO915qVsthaS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a7ef4d-6e13-4c00-e07a-08de75d4345f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 07:45:40.5359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HoNqmI8u1znwKN4QNTIQecd3LE5Bxb3fCmSFr65925/aX/z2IzUwt2AhPl9hcFc9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321
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
Cg0KVGhpcyBpcyBub3QgYSB3b3JrYXJvdW5kOyB5b3UgaGF2ZSBtaXN1bmRlcnN0b29kIHRoZSBp
bnRlbnQgb2YgdGhpcyBwYXRjaC4NCkFsbCBBU0lDIGxvYWQgc2Vuc29ycyBtdXN0IGJlIGNvbnN0
cmFpbmVkIHRvIHRoZSAw4oCTMTAwIHJhbmdlLg0KSW4gb3RoZXIgd29yZHMsIHRoZSBLTUQgZHJp
dmVyIG11c3Qgbm90IGJsaW5kbHkgdHJ1c3QgdGhlIHZhbHVlIHJldHVybmVkIGJ5IHRoZSBmaXJt
d2FyZSB3aXRob3V0IHZhbGlkYXRpb24uDQpGb3IgZXhhbXBsZSwgaW52YWxpZCB2YWx1ZXMgbWF5
IGFyaXNlIGZyb20gaXNzdWVzIHN1Y2ggYXMgbWVtb3J5IGNvcnJ1cHRpb24uDQoNCkJlc3QgUmVn
YXJkcywNCktldmluDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KU2VudDogRnJpZGF5LCBGZWJydWFyeSAyNywgMjAy
NiAxMzo0MA0KVG86IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPjsg
QWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBGZW5nLCBLZW5u
ZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQv
cG06IHJlc3RyaWN0IHNlbnNvciBsb2FkIHZhbHVlcyB0byAwLTEwMA0KDQoNCk9uIDI3LUZlYi0y
NiAxMDoxNCBBTSwgV2FuZywgWWFuZyhLZXZpbikgd3JvdGU6DQo+IFtBTUQgT2ZmaWNpYWwgVXNl
IE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+DQo+IFBpbmcuLi4NCj4N
Cg0KUGxlYXNlIHJlc3RyaWN0IHRoaXMgd29ya2Fyb3VuZCB0byB0aGUgYWZmZWN0ZWQgU09DLiBP
dGhlcndpc2UsIGlmIHRoZXJlIGFyZSBib2d1cyB2YWx1ZXMsIHdlIHdpbGwgZml4IGl0IGF0IHRo
ZSByaWdodCBwbGFjZS4NCg0KVGhhbmtzLA0KTGlqbw0KDQo+IEJlc3QgUmVnYXJkcywNCj4gS2V2
aW4NCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVy
IDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMjUs
IDIwMjYgMTA6MjQgUE0NCj4gVG86IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+
IENjOiBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT47DQo+IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29t
PjsNCj4gRmVuZywgS2VubmV0aCA8S2VubmV0aC5GZW5nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0hdIGRybS9hbWQvcG06IHJlc3RyaWN0IHNlbnNvciBsb2FkIHZhbHVlcyB0byAwLTEw
MA0KPg0KPiBPbiBXZWQsIEZlYiAyNSwgMjAyNiBhdCA3OjE04oCvQU0gTGF6YXIsIExpam8gPGxp
am8ubGF6YXJAYW1kLmNvbT4gd3JvdGU6DQo+Pg0KPj4NCj4+DQo+PiBPbiAyNS1GZWItMjYgMzow
NCBQTSwgWWFuZyBXYW5nIHdyb3RlOg0KPj4+IExpbWl0IEdQVS9NRU0vVkNOIGxvYWQgc2Vuc29y
IHZhbHVlcyB0byAwLTEwMCByYW5nZSB2aWEgY2xhbXBfdCB0bw0KPj4+IGVuc3VyZSB2YWxpZGl0
eS4NCj4+Pg0KPj4NCj4+IElzIHRoaXMgYSB3b3JrYXJvdW5kPyBJZiBpdCdzIG5vdCB3aXRoaW4g
cmFuZ2UsIGl0IGluZGljYXRlcyBzb21lDQo+PiB1bmRlcmx5aW5nIGlzc3VlLg0KPg0KPiBMaWtl
bHkgZm9yOg0KPiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vl
cy80OTA1DQo+DQo+IEFsZXgNCj4NCj4+DQo+PiBUaGFua3MsDQo+PiBMaWpvDQo+Pg0KPj4+IFNp
Z25lZC1vZmYtYnk6IFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCj4+PiAtLS0N
Cj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9wbS5jIHwgMjcgKysrKysrKysr
KysrKysrKysrKysrKystLS0tDQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9hbWRncHVfcG0uYw0KPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVf
cG0uYw0KPj4+IGluZGV4IDkzODM2MWVjYWUwNS4uODZlZjFmZmJmMWRkIDEwMDY0NA0KPj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCj4+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9wbS5jDQo+Pj4gQEAgLTE0MTQsMjAgKzE0MTQsMzkgQEAg
c3RhdGljIHNzaXplX3QNCj4+PiBhbWRncHVfc2V0X3BwX3Bvd2VyX3Byb2ZpbGVfbW9kZShzdHJ1
Y3QgZGV2aWNlICpkZXYsDQo+Pj4NCj4+PiAgICBzdGF0aWMgaW50IGFtZGdwdV9wbV9nZXRfc2Vu
c29yX2dlbmVyaWMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZW51bSBhbWRfcHBfc2Vuc29ycyBzZW5zb3IsDQo+
Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpxdWVyeSkNCj4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICp2YWwpDQo+
Pj4gICAgew0KPj4+IC0gICAgIGludCByLCBzaXplID0gc2l6ZW9mKHVpbnQzMl90KTsNCj4+PiAr
ICAgICB1aW50MzJfdCB0bXAgPSBVSU5UX01BWCwgc2l6ZSA9IHNpemVvZih0bXApOw0KPj4+ICsg
ICAgIGludCByOw0KPj4+ICsNCj4+PiArICAgICBpZiAoIXZhbCkNCj4+PiArICAgICAgICAgICAg
IHJldHVybiAtRUlOVkFMOw0KPj4+DQo+Pj4gICAgICAgIHIgPSBhbWRncHVfcG1fZ2V0X2FjY2Vz
c19pZl9hY3RpdmUoYWRldik7DQo+Pj4gICAgICAgIGlmIChyKQ0KPj4+ICAgICAgICAgICAgICAg
IHJldHVybiByOw0KPj4+DQo+Pj4gICAgICAgIC8qIGdldCB0aGUgc2Vuc29yIHZhbHVlICovDQo+
Pj4gLSAgICAgciA9IGFtZGdwdV9kcG1fcmVhZF9zZW5zb3IoYWRldiwgc2Vuc29yLCBxdWVyeSwg
JnNpemUpOw0KPj4+ICsgICAgIHIgPSBhbWRncHVfZHBtX3JlYWRfc2Vuc29yKGFkZXYsIHNlbnNv
ciwgKHZvaWQgKikmdG1wLCAmc2l6ZSk7DQo+Pj4NCj4+PiAgICAgICAgYW1kZ3B1X3BtX3B1dF9h
Y2Nlc3MoYWRldik7DQo+Pj4NCj4+PiAtICAgICByZXR1cm4gcjsNCj4+PiArICAgICBpZiAocikN
Cj4+PiArICAgICAgICAgICAgIHJldHVybiByOw0KPj4+ICsNCj4+PiArICAgICBzd2l0Y2ggKHNl
bnNvcikgew0KPj4+ICsgICAgIGNhc2UgQU1ER1BVX1BQX1NFTlNPUl9HUFVfTE9BRDoNCj4+PiAr
ICAgICBjYXNlIEFNREdQVV9QUF9TRU5TT1JfTUVNX0xPQUQ6DQo+Pj4gKyAgICAgY2FzZSBBTURH
UFVfUFBfU0VOU09SX1ZDTl9MT0FEOg0KPj4+ICsgICAgICAgICAgICAgdG1wID0gY2xhbXBfdCh1
aW50MzJfdCwgdG1wLCAwLCAxMDApOw0KPj4+ICsgICAgICAgICAgICAgYnJlYWs7DQo+Pj4gKyAg
ICAgZGVmYXVsdDoNCj4+PiArICAgICAgICAgICAgIGJyZWFrOw0KPj4+ICsgICAgIH0NCj4+PiAr
DQo+Pj4gKyAgICAgKnZhbCA9IHRtcDsNCj4+PiArDQo+Pj4gKyAgICAgcmV0dXJuIDA7DQo+Pj4g
ICAgfQ0KPj4+DQo+Pj4gICAgLyoqDQo+Pg0KDQo=
