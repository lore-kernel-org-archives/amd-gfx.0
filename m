Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40F1C369BA
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 07:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C82010E866;
	Wed, 16 Apr 2025 07:25:17 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on2118.outbound.protection.outlook.com [40.107.255.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D4EA10E042
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 03:12:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODPj4F/fvJCtWePMYPkPtaOZYtkJSpRXS9vGRmr3dnz46T9f9BMz5H7TGIIFqkJxWSnGOqYE6vuhShbcIx2xKIwAdXco1S90XpX4W1fR4vj/DeWCMF9ucr9wgLvJy/JkhTd1hbY/U9OrtfrDWmqkMwJHk8jw5l+uNfhowneSW9CeEodPezFcgpLwZVWlL6kUGry+n/uRixklpGcOiUo1odQXFbD9CJ1+G/OOxaz7EpvLkW+dGRHHvFZfo7exoWNtprTcb3GswURljSw0GKTy+oVV4O2aUusJOmNsJ5UxoyUKGzYZirr7I3vqYz+kEYfkYDGwHi16r33/VA0EN0Aq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cL06V36B6KkvYkJPZP4XPLYRhAevV+yabKtupRkz8tU=;
 b=KlgIS9E+Izx6N0j4dpeVi3rxsAiZnhHXYO4HWAKNbW04jer6MgOtuPr7qFI5a/wydZGyrKfnWlKEgW2nlwMiS6ysnQpZd6fA/y2QFUGLaMjXeXjO7FtgvYmGmCWr9C4rky+g1boXo0oITSuk0FMfTnr1Uxa/IYMIH8Wkb9G2zhdAMeMNHl/izB8YjkvD0O1Un+LAjxFa+AxvuLxI40l+Z67KJCn5dFLu51Dq1WaZkd4OEuWoAWXvCnIi0MmbQ5Z3pWZiLXuUGtOH9BV1VCj2zaJwtkMruPnI4bg/xpsBeN9GErOIEuLgnFhFPmpyjh1MzXJYurxU14wT3vObq+R2mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 PUZPR06MB6187.apcprd06.prod.outlook.com (2603:1096:301:107::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.35; Wed, 16 Apr 2025 03:12:08 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 03:12:08 +0000
From: Fugang Duan <fugang.duan@cixtech.com>
To: Alexey Klimov <alexey.klimov@linaro.org>, "alexander.deucher@amd.com"
 <alexander.deucher@amd.com>, "frank.min@amd.com" <frank.min@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "david.belanger@amd.com" <david.belanger@amd.com>, "christian.koenig@amd.com"
 <christian.koenig@amd.com>, Peter Chen <peter.chen@cixtech.com>,
 cix-kernel-upstream <cix-kernel-upstream@cixtech.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUkVHUkVTU0lPTl0gYW1kZ3B1OiBhc3luYyBzeXN0ZW0gZXJy?=
 =?utf-8?B?b3IgZXhjZXB0aW9uIGZyb20gaGRwX3Y1XzBfZmx1c2hfaGRwKCk=?=
Thread-Topic: [REGRESSION] amdgpu: async system error exception from
 hdp_v5_0_flush_hdp()
Thread-Index: AQHbrjQsyP3jhAPl60GLV5n21BS/cbOlnd8A
Date: Wed, 16 Apr 2025 03:12:08 +0000
Message-ID: <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
In-Reply-To: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|PUZPR06MB6187:EE_
x-ms-office365-filtering-correlation-id: 839cedfa-a674-4064-1ca5-08dd7c94790a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dTJRSkpHcUZ4TE93Q1FuZGV5UTVHbjhEdUxCVHRvN1RzN2ZLeDhUSzZZY2lu?=
 =?utf-8?B?UG9LaXFHZ2kwVkNBOU1UNzNJK2JEbWwvQkVISFdIR3h5UlZzV2hlVk1DYUt4?=
 =?utf-8?B?b1ZoQXpjK21BSlJydU1TWG9wOUNtaEl5UThaN2NiVkZwSmdDWURZWlFZNFZ2?=
 =?utf-8?B?Nk4zVlEvRWRaajRsWm9qNWZsR2NCWURidTdzTWwrczZ1Mm5wQXMzWnlkdVVI?=
 =?utf-8?B?TXZPSmE3QzVCekZRKy81SzJvRm9UeGJQNUhWWjl3MTFmU1Y0aWhVMk5mRlpn?=
 =?utf-8?B?a0h4bUZYZU5SRXhXaGJXZjl5Sm9oKzZhRVhqNHlBYlBFc3c5RDdHRnpwS2RX?=
 =?utf-8?B?eWhUVmR2NXNod2V5WVR5bUppZVBobWN1aWNTQklpZkt5UnArOVBBbDR2dk1H?=
 =?utf-8?B?NTlMYlMxMnB5ZDVYOEF2a25EVGxyTllaWFRoTW12dWdnODgwK3Q4N0JyNjJZ?=
 =?utf-8?B?bjNpbkxHZSt0QUlhYU4zcUhjZlhCZk5ycXVtUDZHamsvenZmdmpUbEpoM3BR?=
 =?utf-8?B?ZDVGZEJHRXM0MTBJUlJCZlpLSVF5ZEMydDQyMU1rdlZxVlZzbGdNSWZLVEoy?=
 =?utf-8?B?a1FKSDc0d0hhY21uaXpleHRyZzdrNG9uY3NRZSt0K0ZvZERNY1FubWtybC85?=
 =?utf-8?B?KzVPN01UVDh6K3JJeUMrSHB5aXhWT3pNb3JWc0xIeEJTYWZ4bXQyTDd0cTVs?=
 =?utf-8?B?Qjc0bkRkSzFTTjNtRUVITFJaeW5XbVp2MnhnQkRFWnh5U0VEN1JpT3NEZW5j?=
 =?utf-8?B?Vi8yOENKRGpLWCt2bXpJSUZlWmFuS2tNcGF3MjZ4eTFWWDlYLzluSmlyd0hV?=
 =?utf-8?B?eFZMYXd3M1ZyaC9QQ2ltVFFBN3FibURrcUE4QUxvdWkyVTJLQ1VCTXNNam9N?=
 =?utf-8?B?REpNYnFiQWJESHZyanJlU2pkeDJnSFBCS29DOVpLak00YzdydUFHSi9XRTM5?=
 =?utf-8?B?M1NHK1JuTmNmMVc1cWNGVmlBdFFCKzhvSmdaZk1xZ3hjRVU2cHp1MzhUNmc3?=
 =?utf-8?B?RHNQcEIrSTVZU09KQndjMDFtMFAvRGRqOUhqeUJnRit5dEhwYzIxOFhaN0tS?=
 =?utf-8?B?SXdiUnpLZWhhSVl0MG1pMnZKOE1LeG5EUVZPeEhQemdRaCtFUnZDcGozb2t1?=
 =?utf-8?B?cnhaa1VLN292T294SmQxWHI3VEVyb00vSTFIdUpBOThSUzZnOVMzWXZObmVq?=
 =?utf-8?B?Z3o5Qlh5T1l2ODd3Q1R1YjZvZ0dRYjBYcTRMOEpJOUg1QStHVk9sZnl3RGNi?=
 =?utf-8?B?Y0FicEVwTDAyWGpzakxBZ1dCNnNkUzlZcWtZYnM5RFhRaDBmRWpYU3htTmxN?=
 =?utf-8?B?aWhUaG5BVXNqNFRvdXNaUjVwbnR2UjJUV3ZxMEJxZlhKVGRKNTYzSHIzeG1o?=
 =?utf-8?B?OEJTell5Q2psd0laVFd1UkE4OHdFY1JyWVlDcHFvRks2V2FnVVl5cHpKdS96?=
 =?utf-8?B?MllpM1FvRDh4cWxFMDhTY25DektLVkg1d0NXNFJvVVVXZ1JnVDlqSThUem5q?=
 =?utf-8?B?TzlOd1JMRUdvNDE2dXI0OFBrcGdoZ2R5UnNpOHRGSmQ3NUExdTBUSi9qMm1F?=
 =?utf-8?B?KzJrbWZiRk1JVjliampaRjVzdnQ4a2xleGJ1WFlHNmYwQU5MeXFHRUpKYjUr?=
 =?utf-8?B?emExUTJYWGFFVTJ0cDNPdVpLa1dwVlJMSEl4Z1FYQm94SFNsMlN0bitzbDhL?=
 =?utf-8?B?akkrWHBaNWVhSVBuaVlkNEtwVmRPbC8wRVNPaFJPR0dxeDd0NS9YaHlxT0g3?=
 =?utf-8?B?OXdQL1R1U2UwZEJReTJ1bDc2WmxUV3B2ZGhjc25LckRxdU9TWFdvWWRqYTcx?=
 =?utf-8?B?MVQ1N1YwWXRBZ3VuN1dvd3BwRWxJVjJFbXp2c0tKZTN0QTNoRXY4WGd2cG5h?=
 =?utf-8?B?MFdsKytpTEFhOGFkVlVpZkR2NUNMeTZtOVFYb1R5VGZnbnlrMkk1dDUxWGZX?=
 =?utf-8?Q?L3q+5Cn98+c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnhTMXVCdk5DTGcwYjdGQkU0dUpkL1g0NEk3TG5XNHJGeS9qWnUvWGdKcDA5?=
 =?utf-8?B?UlpVUE13V3YxU2hOOXhEb0VCZEo3S1ZGTjRwdnRRSjZlWlNVVGxNeTFZVy9p?=
 =?utf-8?B?UWJTcnh3WXM1M2w2ZHYxbEkwdW5zcXVsN3BjaDRmckRVRm1ScHdwWkl1VE1Z?=
 =?utf-8?B?VGVEanVwV1d3M21mMDBnNjlzWEMwSGJEYnpYUlhoTnF6M1lyeHorVVdVTUN4?=
 =?utf-8?B?bmVaTmRMNWtzYjdGbzA5NVZmQ3ZMV1lkekdsYlBob095UVhTZFYvVDAyQm95?=
 =?utf-8?B?K292TnJrRE1aWWhVR0lnUEF3L0ZtdlZLMHo2bjlJV0Ira29jNXg1b3JOYU1y?=
 =?utf-8?B?Q0FSQ09TSjZvLzJNMnBPbTBhbXpsV0NoUUR6Kyt6Z1lyODhVVXlFMTN3N1NQ?=
 =?utf-8?B?eXBLYk0rd2IvdjJWbnRobWQxZjY3Y0lvTkdZN1hLRHZ6eFZBcE93N2owOGdT?=
 =?utf-8?B?dHAzcHVRc0Q5YnYzRHBXRmQ5c1FTK0xiYUZTR3VoeDlLTisyT0haM0lCM1E2?=
 =?utf-8?B?TGRoNG40VXQza1gvN1dHbHM4dlFMZmk5dmlWbEIxSkthNFdzWklzU2g3Ly9l?=
 =?utf-8?B?TE40YXA4WHNZN3h1RGYwSGppRW9kOE9hVTBZU3JuM0FjTCtkMEx1TXZnVldT?=
 =?utf-8?B?V05hcHQ3UlN2OFN2MWxTblpkVzAvM3lWUmJiT2R4QXNlK09QWjBYVEJ1bWxw?=
 =?utf-8?B?ZHlGNWxsV0pqR0s2NHM3V1dXTkY5MlhyNlA2N2R2WUZvRlVMQUxRZFpCQWlB?=
 =?utf-8?B?c2ZNeURjRS9yZ1BLTWxRTDEvSVh4U3B2UllyblRzSjN3aVJhZ3htYnR0S2Fl?=
 =?utf-8?B?a2pSZFVCOEMya29jMERxR2RyQmVMQ1dySndKYUViSkYvc0Z3S2ZabjFYRXdv?=
 =?utf-8?B?aEZwUno4eitjSHZvWUVMVTFyRGkxQnZDRUtXcHAxMlRFTmovdW0yVTNseXRI?=
 =?utf-8?B?R3lYQi92M0szZ3BaZnlwOXNvSlg4UytJTHRRTXM3V3p2MzI1YWFodEhJQmpV?=
 =?utf-8?B?a3orMU0yTlNqb2RrOEk2SUhibnovV2ZCQURZaWRsWk9Fb25kaUxTcFYyYnI3?=
 =?utf-8?B?Y2dqR2EyV3YyUTJnWUhzelBrdm9EM2pQSUJQWUtUcHdFR0pLMjdTVGFIaTZR?=
 =?utf-8?B?d1VhN3BWNitZQnlQV0M5UzdZMHpnUGpJelV1WkduZXF2cmZnejliaU5rUmJV?=
 =?utf-8?B?RnZWOHU3RDRtVExwRDAxa0Q1UWFxZVl6TnN0R3MxaFNiZTV4QzZKSXpGaGFi?=
 =?utf-8?B?Ync3NTRjdUZ0eHA1QXpIS1ZvV1BWM0JHM1FJL2VFMnFpY3NXRG04RHBVUzFx?=
 =?utf-8?B?Tjd6dkhQMUpVTCtmazB0MlkyUTVWU3R5Q283d1RaVklmUFA0L3RIN0VDd2xO?=
 =?utf-8?B?a21aaWdnLzdjbE1DMmZkK25yeFI4STNhKzE3U2o1cnpOZ3BiYnlNNXZ1c3B2?=
 =?utf-8?B?aFNiRHJ4enZyTzI4WHJTZm9MWG00N0RwUHBrQWV2MXF3c3dKL3VTd2t0aTJE?=
 =?utf-8?B?VGhocy91QU1JamhGQVhoRjJ1byt4N0g5UnJwb1JuOFYrUkxlSlpNb3B1M0pa?=
 =?utf-8?B?Z2crWVJlOUZnd2MwMDFIcUovaXpaVVVIdE9hUXU2WG95UzZOQ2phVEE4Qndw?=
 =?utf-8?B?OHNKNjdZN3YvNXhkWG4wSmRGTWEvRlN3UW8xcmVuNXdPVXhudTQyNVJzS2JM?=
 =?utf-8?B?bys2QXZuQTZEckdaNHo0SUhBYmczRjd3Z292WXY3cE9RK1F4TkpuYkNUYkJm?=
 =?utf-8?B?S2g3STJZZDBoSC9kM0tiNFVBcFkzeVFQNit2UDdjS2R3elllUzVKajcybi9i?=
 =?utf-8?B?dEJWS2hycHEvSzFDdktEdjZGOVdsYTZ2bHd0Q3BKR2pvaXdxRzZqTUNNcXBZ?=
 =?utf-8?B?QVpxS0ZFTGRGRmIvZXVJbW9DZ3hHVGs2cHZwSGpqenFreWlMb2VYc1RSeDI3?=
 =?utf-8?B?eTlDRDdlN2Q0MnRDQW15Wmp3V1pGTnJwNmJEUmRCZXM3T1g3a3JBbHVhSTRq?=
 =?utf-8?B?UlN4VEJvNnFIcWI5bnZiNGRRWUtBUnRhaEtlUE16VVRLeXNIdGhwdkkvYTd1?=
 =?utf-8?B?ZmZOVjVWSW4wT3ZvZ0RHZE0xV2ZqbVllckdPbHpURlN5dHoxQjRDc1ZtL3h5?=
 =?utf-8?Q?Pb1EaiA/ppZSrm0KM16y7oNIP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839cedfa-a674-4064-1ca5-08dd7c94790a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 03:12:08.3864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQKZbVIUYv+KbJBY2QwcE3CSqDYHeoXAc+WJpwJGnxwpX66hSaTta0xbcE+iQW+dXsnpTb/Da8LkBd5QUjSRcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6187
X-Mailman-Approved-At: Wed, 16 Apr 2025 07:25:00 +0000
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

5Y+R5Lu25Lq6OiBBbGV4ZXkgS2xpbW92IDxhbGV4ZXkua2xpbW92QGxpbmFyby5vcmc+IOWPkemA
geaXtumXtDogMjAyNeW5tDTmnIgxNuaXpSAyOjI4DQo+I3JlZ3pib3QgaW50cm9kdWNlZDogdjYu
MTIuLnY2LjEzDQo+DQo+SSB1c2UgUlg2NjAwIG9uIGFybTY0IE9yaW9uIG82IGJvYXJkIGFuZCBp
dCBzZWVtcyB0aGF0IGFtZGdwdSBpcyBicm9rZW4gb24gcmVjZW50DQo+a2VybmVscywgZmFpbHMg
b24gYm9vdDoNCj4NCj5bZHJtXSBhbWRncHU6IDc4ODZNIG9mIEdUVCBtZW1vcnkgcmVhZHkuDQo+
W2RybV0gR0FSVDogbnVtIGNwdSBwYWdlcyAxMzEwNzIsIG51bSBncHUgcGFnZXMgMTMxMDcyIFNF
cnJvciBJbnRlcnJ1cHQgb24gQ1BVMTEsDQo+Y29kZSAweDAwMDAwMDAwYmUwMDAwMTEgLS0gU0Vy
cm9yDQo+Q1BVOiAxMSBVSUQ6IDAgUElEOiAyNTUgQ29tbTogKHVkZXYtd29ya2VyKSBUYWludGVk
OiBHIFMNCj42LjE1LjAtcmMyKyAjMSBWT0xVTlRBUlkNCj5UYWludGVkOiBbU109Q1BVX09VVF9P
Rl9TUEVDDQo+SGFyZHdhcmUgbmFtZTogUmFkeGEgQ29tcHV0ZXIgKFNoZW56aGVuKSBDby4sIEx0
ZC4gUmFkeGEgT3Jpb24gTzYvUmFkeGEgT3Jpb24NCj5PNiwgQklPUyAxLjAgSmFuICAxIDE5ODAN
Cj5wc3RhdGU6IDgzNDAwMDA5IChOemN2IGRhaWYgK1BBTiAtVUFPICtUQ08gK0RJVCAtU1NCUyBC
VFlQRT0tLSkgcGMgOg0KPmFtZGdwdV9kZXZpY2VfcnJlZysweDYwLzB4ZTQgW2FtZGdwdV0gbHIg
OiBoZHBfdjVfMF9mbHVzaF9oZHArMHg2Yy8weDgwDQo+W2FtZGdwdV0gc3AgOiBmZmZmZmZjMDgz
MjFiNDkwDQo+eDI5OiBmZmZmZmZjMDgzMjFiNDkwIHgyODogZmZmZmZmODBiOGI4MDAwMCB4Mjc6
IGZmZmZmZjgwYjhiZDAxNzgNCj54MjY6IGZmZmZmZjgwYjhiOGZlODggeDI1OiAwMDAwMDAwMDAw
MDAwMDAxIHgyNDogZmZmZmZmODA4MTY0NzAwMA0KPngyMzogZmZmZmZmYzA3OWQ2ZTAwMCB4MjI6
IGZmZmZmZjgwYjhiZDUwMDAgeDIxOiAwMDAwMDAwMDAwMDdmMDAwDQo+eDIwOiAwMDAwMDAwMDAw
MDFmYzAwIHgxOTogMDAwMDAwMDBmZmZmZmZmZiB4MTg6IDAwMDAwMDAwMDAwMDE1ZmMNCj54MTc6
IDAwMDAwMDAwMDAwMDE1ZmMgeDE2OiAwMDAwMDAwMDAwMDAxNWNmIHgxNTogMDAwMDAwMDAwMDAw
MTVjZQ0KPngxNDogMDAwMDAwMDAwMDAwMTVkMCB4MTM6IDAwMDAwMDAwMDAwMDE1ZDEgeDEyOiAw
MDAwMDAwMDAwMDAxNWQyDQo+eDExOiAwMDAwMDAwMDAwMDAxNWQzIHgxMDogMDAwMDAwMDAwMDAw
ZWMwMCB4OSA6IDAwMDAwMDAwMDAwMDE1ZmQNCj54OCA6IDAwMDAwMDAwMDAwMDE1ZmQgeDcgOiAw
MDAwMDAwMDAwMDAxNjg5IHg2IDogMDAwMDAwMDAwMDU1NTQwMQ0KPng1IDogMDAwMDAwMDAwMDAw
MDAwMSB4NCA6IDAwMDAwMDAwMDAxMDAwMDAgeDMgOiAwMDAwMDAwMDAwMTAwMDAwDQo+eDIgOiAw
MDAwMDAwMDAwMDAwMDAwIHgxIDogMDAwMDAwMDAwMDA3ZjAwMCB4MCA6IDAwMDAwMDAwMDAwMDAw
MDAgS2VybmVsIHBhbmljDQo+LSBub3Qgc3luY2luZzogQXN5bmNocm9ub3VzIFNFcnJvciBJbnRl
cnJ1cHQNCj5DUFU6IDExIFVJRDogMCBQSUQ6IDI1NSBDb21tOiAodWRldi13b3JrZXIpIFRhaW50
ZWQ6IEcgUw0KPjYuMTUuMC1yYzIrICMxIFZPTFVOVEFSWQ0KPlRhaW50ZWQ6IFtTXT1DUFVfT1VU
X09GX1NQRUMNCj5IYXJkd2FyZSBuYW1lOiBSYWR4YSBDb21wdXRlciAoU2hlbnpoZW4pIENvLiwg
THRkLiBSYWR4YSBPcmlvbiBPNi9SYWR4YSBPcmlvbg0KPk82LCBCSU9TIDEuMCBKYW4gIDEgMTk4
MCBDYWxsIHRyYWNlOg0KPiBzaG93X3N0YWNrKzB4MmMvMHg4NCAoQykNCj4gZHVtcF9zdGFja19s
dmwrMHg2MC8weDgwDQo+IGR1bXBfc3RhY2srMHgxOC8weDI0DQo+IHBhbmljKzB4MTQ4LzB4MzMw
DQo+IGFkZF90YWludCsweDAvMHhiYw0KPiBhcm02NF9zZXJyb3JfcGFuaWMrMHg2NC8weDdjDQo+
IGRvX3NlcnJvcisweDI4LzB4NjgNCj4gZWwxaF82NF9lcnJvcl9oYW5kbGVyKzB4MzAvMHg0OA0K
PiBlbDFoXzY0X2Vycm9yKzB4NmMvMHg3MA0KPiBhbWRncHVfZGV2aWNlX3JyZWcrMHg2MC8weGU0
IFthbWRncHVdIChQKQ0KPiBoZHBfdjVfMF9mbHVzaF9oZHArMHg2Yy8weDgwIFthbWRncHVdDQo+
IGdtY192MTBfMF9od19pbml0KzB4ZWMvMHgxZmMgW2FtZGdwdV0NCj4gYW1kZ3B1X2RldmljZV9p
bml0KzB4MTlmOC8weDI0ODAgW2FtZGdwdV0NCj4gYW1kZ3B1X2RyaXZlcl9sb2FkX2ttcysweDIw
LzB4YjAgW2FtZGdwdV0NCj4gYW1kZ3B1X3BjaV9wcm9iZSsweDFiOC8weDVkNCBbYW1kZ3B1XQ0K
PiBwY2lfZGV2aWNlX3Byb2JlKzB4YmMvMHgxYTgNCj4gcmVhbGx5X3Byb2JlKzB4YzAvMHgzOWMN
Cj4gX19kcml2ZXJfcHJvYmVfZGV2aWNlKzB4N2MvMHgxNGMNCj4gZHJpdmVyX3Byb2JlX2Rldmlj
ZSsweDNjLzB4MTIwDQo+IF9fZHJpdmVyX2F0dGFjaCsweGM0LzB4MjAwDQo+IGJ1c19mb3JfZWFj
aF9kZXYrMHg2OC8weGI0DQo+IGRyaXZlcl9hdHRhY2grMHgyNC8weDMwDQo+IGJ1c19hZGRfZHJp
dmVyKzB4MTEwLzB4MjQwDQo+IGRyaXZlcl9yZWdpc3RlcisweDY4LzB4MTI0DQo+IF9fcGNpX3Jl
Z2lzdGVyX2RyaXZlcisweDQ0LzB4NTANCj4gYW1kZ3B1X2luaXQrMHg4NC8weGY5NCBbYW1kZ3B1
XQ0KPiBkb19vbmVfaW5pdGNhbGwrMHg2MC8weDFlMA0KPiBkb19pbml0X21vZHVsZSsweDU0LzB4
MjAwDQo+IGxvYWRfbW9kdWxlKzB4MThmOC8weDFlNjgNCj4gaW5pdF9tb2R1bGVfZnJvbV9maWxl
KzB4NzQvMHhhMA0KPiBfX2FybTY0X3N5c19maW5pdF9tb2R1bGUrMHgxZTAvMHgzZjANCj4gaW52
b2tlX3N5c2NhbGwrMHg2NC8weGU0DQo+IGVsMF9zdmNfY29tbW9uLmNvbnN0cHJvcC4wKzB4NDAv
MHhlMA0KPiBkb19lbDBfc3ZjKzB4MWMvMHgyOA0KPiBlbDBfc3ZjKzB4MzQvMHhkMA0KPiBlbDB0
XzY0X3N5bmNfaGFuZGxlcisweDEwYy8weDEzOA0KPiBlbDB0XzY0X3N5bmMrMHgxOTgvMHgxOWMN
Cj5TTVA6IHN0b3BwaW5nIHNlY29uZGFyeSBDUFVzDQo+S2VybmVsIE9mZnNldDogZGlzYWJsZWQN
Cj5DUFUgZmVhdHVyZXM6IDB4MTAwMCwwMDAwMDBlMCxmMTY5YTY1MCw5YjdmZjY2NyBNZW1vcnkg
TGltaXQ6IG5vbmUgLS0tWyBlbmQNCj5LZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogQXN5bmNo
cm9ub3VzIFNFcnJvciBJbnRlcnJ1cHQgXS0tLQ0KPg0KPihiaW9zIHZlcnNpb24gc2VlbXMgdG8g
YmUgNDUgeWVhcnMgb2xkIGJ1dCB0aGF0IGlzIHRoZSBzdGF0ZSBvZiB0aGUgYm9hcmQgd2hlbg0K
PkkgcmVjZWl2ZWQgaXQpDQo+DQo+QWxzbyBzYXcgdGhpcyBjcmFzaCB3aXRoIFJYNjcwMC4gT2xk
IHJhZGVvbnMgbGlrZSBIRDU0NTAgYW5kIG52aWRpYSBndDEwMzAgd29yaw0KPmZpbmUgb24gdGhh
dCBib2FyZC4NCj4NCj5BIGxpdHRsZSBiaXQgb2YgdGVzdGluZyBzaG93ZWQgdGhhdCBpdCB3YXMg
aW50cm9kdWNlZCBiZXR3ZWVuIDYuMTIgYW5kIDYuMTMuDQo+QWxzbyBpdCBzZWVtcyB0aGF0IGNo
YW5nZXMgd2VyZSB0YWtlbiBieSBzb21lIGRpc3RybyBrZXJuZWxzIGFscmVhZHkgYW5kIGRpZmZl
cmVudA0KPmlzbyBpbWFnZXMgSSB0cmllZCBmYWlsZWQgdG8gYm9vdCBiZWZvcmUgSSBidW1wZWQg
aW50byBzb21lIGlzbyB3aXRoIGtlcm5lbCA2LjgNCj50aGF0IHdvcmtlZCBqdXN0IGZpbmUuDQo+
DQo+VGhlIG9ubHkgY2hhbmdlIHJlbGF0ZWQgdG8gaGRwX3Y1XzBfZmx1c2hfaGRwKCkgd2FzDQo+
Y2Y0MjQwMjBlMDQwIGRybS9hbWRncHUvaGRwNS4wOiBkbyBhIHBvc3RpbmcgcmVhZCB3aGVuIGZs
dXNoaW5nIEhEUA0KPg0KPlJldmVydGluZyB0aGF0IGNvbW1pdCBeXiBkaWQgaGVscCBhbmQgcmVz
b2x2ZWQgdGhhdCBwcm9ibGVtLiBCZWZvcmUgc2VuZGluZw0KPnJldmVydCBhcy1pcyBJIHdhcyBp
bnRlcmVzdGVkIHRvIGtub3cgaWYgdGhlcmUgc3VwcG9zZWQgdG8gYmUgYSBwcm9wZXIgZml4IGZv
cg0KPnRoaXMgb3IgbWF5YmUgc29tZW9uZSBpcyBpbnRlcmVzdGVkIHRvIGRlYnVnIHRoaXMgb3Ig
aGF2ZSBhbnkgc3VnZ2VzdGlvbnMuDQo+DQo+SW4gdGhlb3J5IEkgYWxzbyBuZWVkIHRvIGNvbmZp
cm0gdGhhdCBleGFjdGx5IHRoYXQgY2hhbmdlIGludHJvZHVjZWQgdGhlDQo+cmVncmVzc2lvbi4N
Cj4NCj5UaGFua3MsDQo+QWxleGV5DQoNCkNhbiB5b3UgcmV2ZXJ0IHRoZSBjaGFuZ2UgYW5kIHRy
eSBhZ2FpbiBodHRwczovL2dpdGxhYi5jb20vbGludXgta2VybmVsL2xpbnV4Ly0vY29tbWl0L2Nm
NDI0MDIwZTA0MGJlMzVkZjA1YjY4MmI1NDZiMjU1ZTc0YTQyMGYNCg0KVGhhbmtzLA0KRnVnYW5n
DQoNCg0KDQpUaGlzIGVtYWlsIChpbmNsdWRpbmcgaXRzIGF0dGFjaG1lbnRzKSBpcyBpbnRlbmRl
ZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB0byB3aGljaCBpdCBpcyBhZGRyZXNzZWQg
YW5kIG1heSBjb250YWluIGluZm9ybWF0aW9uIHRoYXQgaXMgcHJpdmlsZWdlZCwgY29uZmlkZW50
aWFsIG9yIG90aGVyd2lzZSBwcm90ZWN0ZWQgZnJvbSBkaXNjbG9zdXJlLiBVbmF1dGhvcml6ZWQg
dXNlLCBkaXNzZW1pbmF0aW9uLCBkaXN0cmlidXRpb24gb3IgY29weWluZyBvZiB0aGlzIGVtYWls
IG9yIHRoZSBpbmZvcm1hdGlvbiBoZXJlaW4gb3IgdGFraW5nIGFueSBhY3Rpb24gaW4gcmVsaWFu
Y2Ugb24gdGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgb3IgdGhlIGluZm9ybWF0aW9uIGhlcmVp
biwgYnkgYW55b25lIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudCwgb3IgYW4gZW1w
bG95ZWUgb3IgYWdlbnQgcmVzcG9uc2libGUgZm9yIGRlbGl2ZXJpbmcgdGhlIG1lc3NhZ2UgdG8g
dGhlIGludGVuZGVkIHJlY2lwaWVudCwgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSWYgeW91IGFy
ZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGRvIG5vdCByZWFkLCBjb3B5LCB1
c2Ugb3IgZGlzY2xvc2UgYW55IHBhcnQgb2YgdGhpcyBlLW1haWwgdG8gb3RoZXJzLiBQbGVhc2Ug
bm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIHBlcm1hbmVudGx5IGRlbGV0ZSB0aGlz
IGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGlmIHlvdSByZWNlaXZlZCBpdCBpbiBlcnJvci4g
SW50ZXJuZXQgY29tbXVuaWNhdGlvbnMgY2Fubm90IGJlIGd1YXJhbnRlZWQgdG8gYmUgdGltZWx5
LCBzZWN1cmUsIGVycm9yLWZyZWUgb3IgdmlydXMtZnJlZS4gVGhlIHNlbmRlciBkb2VzIG5vdCBh
Y2NlcHQgbGlhYmlsaXR5IGZvciBhbnkgZXJyb3JzIG9yIG9taXNzaW9ucy4NCg==
