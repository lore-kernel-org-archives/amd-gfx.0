Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1838BCA5FF1
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 01:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97DCC10E9DD;
	Mon,  5 Oct 2026 01:25:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wYWN0FPa";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA27410E9DD
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 01:25:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8aAd9dWM3LoJP6rxwYi3wBCOtvTqLzPDeynFvxmAoXoWD6bUw8qReHWa121iQcqKd7mAPbCtGA5dOYqJOd6XTNpIoZNfdF1hbqo7eO9aBFv4qi/uk3FMvyDWsrCoj6gY8r7KkcVA2SgxgjbLlWlQTSfSRDGwJ7SD9Qh2a36M7w6H0yWybrh21uVx15zUNFN6Vytc2vEkEInmLVp+mPHhcv+uHGyMqArSRqutOPw1Fwn+i95INkqDTpLmt97wH20QqJHYDggxvEZ1YBtlz8m7FWyLIfKV5DNQ+7tZaELY9Z7P+9xb6kbTWNTTLHnP8in4Id6njFODM4i9ybgWacKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfrYIby/2YWYgCBdBLSaEcexgFzl5Nqlk95mubqsVuA=;
 b=kY+vktrU6zFXrtaYv2+GFYZ5nDCx0txgT7Zl+LGmcRlRV08q53HEr2twM+E7oD5zd4TaKxW3+G6qzDHn/AhbRci63abgSNC+eREBEu2o/nz6uQftlIzxlR4PIiHByE8liTy499+imefXkAjVM+Zzxu1Cya2aS4kqY2fwzL0qTfkpMBSaLurmgOnjyrvJG+xUy7+0p/x2isznjUQLFwfPAU44hjRc/GgI9a3nGwz4/zAVCBHUoHs/0TN5O3Eyp1OAa6CJt0ATOAufM0bA5Ya+yoUjuI5Sbvsdzvqya3vPPMHNBvE7OKPthAJhylJfOCDJk2VjSottNoo9dgYHK4AkhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfrYIby/2YWYgCBdBLSaEcexgFzl5Nqlk95mubqsVuA=;
 b=wYWN0FPaWJQFEZgXzppsfSLNbi1L6sIDKI9anN02oP8BVbQx/g/W92LzAMiaWW3tVNKt9vrxPd70/FqnL7RSa4s+bo03TcypDkqe/q6KdP2wT2k6eTQBhAhQsIlmuSG4GRO7BsE3T6pXg0s4IMa+8e7DbfbSAdwZRMWKhp3PTNo=
Received: from DSWPR12MB999127.namprd12.prod.outlook.com (2603:10b6:8:36c::7)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 01:25:10 +0000
Received: from DSWPR12MB999127.namprd12.prod.outlook.com
 ([fe80::54e1:5b6e:4c39:d7b2]) by DSWPR12MB999127.namprd12.prod.outlook.com
 ([fe80::54e1:5b6e:4c39:d7b2%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 01:25:09 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Melissa Wen <mwen@igalia.com>, 
 "airlied@gmail.com" <airlied@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Francis, David"
 <David.Francis@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "siqueira@igalia.com"
 <siqueira@igalia.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 8/8] drm/amd/display: copy function name into
 dcn_optc_lock_unlock_state trace event
Thread-Topic: [PATCH 8/8] drm/amd/display: copy function name into
 dcn_optc_lock_unlock_state trace event
Thread-Index: AQHdTGmwup8wpBBYCkuMV+9KRq3pZbbfFt6AgA8TXBA=
Date: Mon, 5 Oct 2026 01:25:09 +0000
Message-ID: <DSWPR12MB9991270405E033D4C1F2F49B5C89962@DSWPR12MB999127.namprd12.prod.outlook.com>
References: <20260924211410.867686-1-mwen@igalia.com>
 <20260924211410.867686-9-mwen@igalia.com>
 <f21d5d36-9ced-4e03-a9a7-752d1f4cb9d9@igalia.com>
In-Reply-To: <f21d5d36-9ced-4e03-a9a7-752d1f4cb9d9@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-05T01:24:16.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR12MB999127:EE_|PH7PR12MB5855:EE_
x-ms-office365-filtering-correlation-id: 005c3994-9472-4ff4-8b28-08df227f7f16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|921020|38070700021|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: t77X7OcT1voKBdu3HqQX+QhCpTNFQCxYai0cP4Z+aA6NBw4NhBX0/STcCm1gUhD2XoOG1gQ4NmIdvU/fbAaKgiPXF83sJxWd1XyMJZpk3IBX8kmUB5hNdJDM12qHkZ3p6/N6CcKJ+GtkGWcTGbKQ8oTZ6sZZ3QVDX963lncsZsh+MqHWLQQXaqjnhghJV+zFTwnb2peeyenKlSTuU3OyOIKntmm3jdfh4HdDEhKX5/Qm+rV7Ey4CA9F0zW4CItpVRvu+0sZpIE6LTaHmErqgK0ABgsUR7QGsaHNbELpHna5q892nlN150vsbvI0Oi6ERlbbMDkm3eWL4fxdWD+7Mmx/zjw1fe1rl8YgipTIvjmjxoChCx/pvjMEjO17hof0t9O2MZW4pJjMjdpOoher52TDUrfq6SjycpxP87g71vBvJ0Olp6KV9yXiyrk2GHRKQr47HFOfoTXKD6x8S/K9vXmpnzr3t3z9TErErPpHqiu8hHnTJDpXhTWPwQGwl1QqXrLnLUzq3AI4EeO7AgvVFp9a/Cu7Zw4muuYZhc7qJGxxwZtsvZBIqGlzPhvvCnnf3Guedl6g4LcTFhFSd8d3xSw9MiRnzyrGNOYjmljjgKZFu+X4/wPYHj9cjSWD7MkJlsPpX3Hmf0VaAQ7t3AnLvcUMt1Z8yN7VVsvgCSMCGuXunNaSxggstU8DO8psyXIGQn3WSQ7iX6OzwY8p4UKxGjfp3osxMLnUnDQ7uAuQ/f4vVcop84Ze1IaBN0Mh2b/cs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DSWPR12MB999127.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(921020)(38070700021)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZU9MRUg2VnhMV1lqNEMzYnNsU2k3YklBVXd4eDRXNVZvczhmNStiU0Vqa1p3?=
 =?utf-8?B?b3Bobyt1bnF2eWt1eFZ6MHZnaGF1a3lZZDQrSDByc0ZucVJkdzB0SHl0cVFH?=
 =?utf-8?B?TzMwTnRoWjQzYUw4b0JWYzl5QXJZSWxlMVZFN1hFUytPQkh1YmlRTm1vd3NB?=
 =?utf-8?B?MUZtUG4wK25SZVlGdTlieUwrbzg3ZldwNnNBWDVnTCtUc3Y0NjNBTFM4YlJK?=
 =?utf-8?B?WFFleG00aHg4bXNmSUREUnFQejRmSjJHNXpvR2gvOGdlYWU1ckdXVUpnaFdI?=
 =?utf-8?B?YUZrM1F3MWFxS1NWU2diMjNwU2M4MHh0R0FmQmtXaWdOOXNtVWlTVk1hMWRq?=
 =?utf-8?B?SkNsNmtYTEsxQzdjbjZBUmZ6TlZPTlZSQXdtUWEzZVVwVzdyTEtrV3lLaExT?=
 =?utf-8?B?b3BRSWFjSHZHdDFBUitpNWJoWXhvcHBWYjdQNmxuUmdXdGFkL09XZm0rekYy?=
 =?utf-8?B?bVhjVEN6SDZzQXBQZkJDQlFnS3dqcVdCMlcyaHRkaVFJK0EvNXlsUVdUNGZ2?=
 =?utf-8?B?UUkwU0tnU0dXcnl0a2NWclNaMHNjNnFWSEN3Y3RTaDUxZnVjTlFra25UOHlV?=
 =?utf-8?B?ckdIUEU1anBxUUFsRGNQQitFcXVzZDlLWHZia1B3OFRuQmhnMVJPWkF4TXNI?=
 =?utf-8?B?azZiQ1NqeStsY01CZmtndjlQcmhJdW55ZFJiQmx0a2JsS1BrK2RTRTN3bXNK?=
 =?utf-8?B?WkhZREovOEY3Wkx5ZnVtVzIwaXhOMzZ4S043ZFREV1J1OTdMQ1QxUk9QQ29y?=
 =?utf-8?B?cjdjUGZaQk9hQ1RiOHYwRllYZkQ3YlNVelA5VmR4bkdDV1ZtdXdvSzNsSTdo?=
 =?utf-8?B?TjUrK0FsV3kyUU1nWUhaRU9udk9LTkVjSktGRVVJNjBET3NRZENkRUVKVVls?=
 =?utf-8?B?VlJUQTd1SkFSdE9Odnl4TW55eFpmSEQ3VXpURUpOMHUxS0hKT0FhWldzVDdw?=
 =?utf-8?B?a1k0eWJPeStYV0ZWS1U4QTZENERWT3FFalVaTnk1djhkZG1NWWlQYkdyTy8w?=
 =?utf-8?B?ZElDQ2VydGw3K0tKMHlFNDJ1NDZqbDcvZFN6QkVCMlRsSG5wempBV1cxNWZr?=
 =?utf-8?B?RW1ET2FpVzNtTC9GdDhOc1J4WVZia1BscUNZamJaeFQyTTJPc1pQZTBIeVR5?=
 =?utf-8?B?NTZnT016Rk84QjdBNEZkQnFtbGhjN2N3Q3h6dnNFcEZEbEUzcCs4M2U0T1dt?=
 =?utf-8?B?WFZEbDdBZ1lJRG4xRUdZcG5TcWZvai8zbyt2Y29UNDVvTHI4bzh1S0tqN1dp?=
 =?utf-8?B?Mm9oR0Exb0hGSDR5TFI3ZUczN2lJTGFQVlRpRUQyVGlod2VhL09Bc2JodndC?=
 =?utf-8?B?UU5qS1MveVZ4U2NJcURmdU5LMmJhdEhnYm9uQi9adElFbUt2R2VJRzJkRU1V?=
 =?utf-8?B?bEVMRGVuZlhKZlRjaHhHMExqaHhoSmVuL0Q2cW4ycEgzUG05c0NNV3VXRGIy?=
 =?utf-8?B?SDYxMzdxbUZyaVNraE5zekpMcGRoelBITUdZRmxXM2RyMHhyY3ZveXJkNkow?=
 =?utf-8?B?cHRYWVgxanNuQU1pNncxYis4LzBTUDZTb3RsTjI5UnJFRC9HSXBQMkpxVUFZ?=
 =?utf-8?B?Yzl5N1lBVFhldlVoSVZPS1haVFBMQUttcmJlU0drc1dqMHJUYkt3TEdodGR6?=
 =?utf-8?B?eUlzZ2o0cFFkaFVSbjZLWS85T3hFY0NnVjhnQk8zTmdNTThockQxRkpRZG95?=
 =?utf-8?B?QzZXNUtoQTNxa1FMdlRXbTIvS3BIMnYzYTVHRW40TXNYTEQ4cTNPNkRSMnRW?=
 =?utf-8?B?MDIwejF4V3lJUGUvMm0xaDNuekFhYUc2Z0k2emI4ZS82ZDliTkxjZlpxODQ4?=
 =?utf-8?B?cVRpUytJMFZoWHhZNXJERWYzVmdaaE84SzlOOEszS1ZHT1RtanBGa243UGt2?=
 =?utf-8?B?WmFaeEs4UzZ1WnJEdG9XWFQrWm1PN2NoT245K3Y5dGJUdmNEOWRERmhBK2VE?=
 =?utf-8?B?NkRVZWx6UHJ2eWFvM0RxUysrSlI2VVk3RDFuckJ2QTZJcGYxRkZBcmZsWUtC?=
 =?utf-8?B?ek80MTZnWTVNU0J6L1k3TFNGajNkZDFWU3ZtWmFVTmdWdjlJMXF2eHdpTnRU?=
 =?utf-8?B?RERXRkdOWkNvWDlSalRQWUpRbXhTRUVrSjVydTNEaUtEVDJpN3hXT2s3elor?=
 =?utf-8?B?N3FPT285SUk3QTc5TzMwNjdVMUN5cmJPb0tRT2NFWXd6NVk3Nld4SEx1VXI5?=
 =?utf-8?B?eXI0STJUUlRsbXpZNklUZ2w0M1ZQdWJ1R1BMN21lellVUVFERkV3VnpvcHI1?=
 =?utf-8?B?VDVNWFJUOHJlRzhmczVIYmU5dTUvaFdySkM5UGdkMkFNRkJnNzREMmo3SHpw?=
 =?utf-8?Q?DQCSTtzi2nDn0u2XDV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DSWPR12MB999127.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005c3994-9472-4ff4-8b28-08df227f7f16
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 01:25:09.7685 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jrzrb3yT4YKSIEMtNDXyicRZpVVMBs5cpuXdT/jvPP5OZJP9/dWsMpSUn++N45eJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855
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

UHVibGljDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8
YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIFR2cnRr
bw0KPiBVcnN1bGluDQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDI1LCAyMDI2IDY6MjMgQU0N
Cj4gVG86IE1lbGlzc2EgV2VuIDxtd2VuQGlnYWxpYS5jb20+OyBhaXJsaWVkQGdtYWlsLmNvbTsg
RGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgUGlsbGFp
LCBBdXJhYmluZG8gPEF1cmFiaW5kby5QaWxsYWlAYW1kLmNvbT47DQo+IEtvZW5pZywgQ2hyaXN0
aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBGcmFuY2lzLCBEYXZpZA0KPiA8RGF2aWQu
RnJhbmNpc0BhbWQuY29tPjsgV2VudGxhbmQsIEhhcnJ5IDxIYXJyeS5XZW50bGFuZEBhbWQuY29t
PjsNCj4gc2ltb25hQGZmd2xsLmNoOyBzaXF1ZWlyYUBpZ2FsaWEuY29tOyBMaSwgU3VuIHBlbmcg
KExlbykgPFN1bnBlbmcuTGlAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnOyBrZXJuZWwtZGV2QGlnYWxpYS5jb207IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggOC84XSBkcm0vYW1kL2Rpc3BsYXk6IGNvcHkg
ZnVuY3Rpb24gbmFtZSBpbnRvDQo+IGRjbl9vcHRjX2xvY2tfdW5sb2NrX3N0YXRlIHRyYWNlIGV2
ZW50DQo+DQo+DQo+IE9uIDI0LzA5LzIwMjYgMjI6MTAsIE1lbGlzc2EgV2VuIHdyb3RlOg0KPiA+
IFVzZXJzcGFjZSB0cmFjZSB0b29scyB0aGF0IHVzZSBsaWJ0cmFjZWV2ZW50IHRvIHJlYWQgYmlu
YXJ5IGJ1ZmZlcg0KPiA+IG9ubHkgc2VlIGEga2VybmVsIGFkZHJlc3Mgd2hlbiBwcmludGluZyBj
b25zdCBjaGFyICouIFVzZSBzdHJpbmcNCj4gPiBtYWNyb3MgaW4gZGNuX29wdGNfbG9ja191bmxv
Y2tfc3RhdGUgdG8gY29weSB0aGUgZnVuY3Rpb24gbmFtZSBpbnRvDQo+ID4gdGhlIHRyYWNlIGV2
ZW50Lg0KPiA+DQo+ID4gRml4ZXM6IGYxOTQzYTUxZjBmOSAoImRybS9hbWQvZGlzcGxheTogQWRk
IGV2ZW50cyBsb2cgdG8gdHJhY2UgT1BUQw0KPiA+IGxvY2sgYW5kIHVubG9jayIpDQo+ID4gQXNz
aXN0ZWQtYnk6IENsYXVkZTpjbGF1ZGUtb3B1cy01LTUNCj4gPiBTaWduZWQtb2ZmLWJ5OiBNZWxp
c3NhIFdlbiA8bXdlbkBpZ2FsaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fdHJhY2UuaCB8IDYgKysrLS0tDQo+ID4g
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1k
Z3B1X2RtX3RyYWNlLmgNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vYW1kZ3B1X2RtX3RyYWNlLmgNCj4gPiBpbmRleCBiMmYzODY1NGU0ODkuLjdmMDVmNzNlNWIz
MyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2Rt
L2FtZGdwdV9kbV90cmFjZS5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG1fdHJhY2UuaA0KPiA+IEBAIC02NjAsNyArNjYwLDcgQEAgVFJB
Q0VfRVZFTlQoZGNuX29wdGNfbG9ja191bmxvY2tfc3RhdGUsDQo+ID4gICAgICAgICBUUF9BUkdT
KG9wdGNfc3RhdGUsIGluc3RhbmNlLCBsb2NrLCBmdW5jdGlvbiwgbGluZSksDQo+ID4NCj4gPiAg
ICAgICAgIFRQX1NUUlVDVF9fZW50cnkoDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgIF9f
ZmllbGQoY29uc3QgY2hhciAqLCBmdW5jdGlvbikNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgX19zdHJpbmcoZnVuY3Rpb24sIGZ1bmN0aW9uKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICBfX2ZpZWxkKGludCwgaW5zdGFuY2UpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
IF9fZmllbGQoYm9vbCwgbG9jaykNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgX19maWVs
ZChpbnQsIGxpbmUpDQo+ID4gQEAgLTY3OCw3ICs2NzgsNyBAQCBUUkFDRV9FVkVOVChkY25fb3B0
Y19sb2NrX3VubG9ja19zdGF0ZSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgX19maWVs
ZChpbnQsIHZyZWFkeV9vZmZzZXQpDQo+ID4gICAgICAgICApLA0KPiA+ICAgICAgICAgVFBfZmFz
dF9hc3NpZ24oDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICBfX2VudHJ5LT5mdW5jdGlvbiA9
IGZ1bmN0aW9uOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgX19hc3NpZ25fc3RyKGZ1bmN0
aW9uKTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgIF9fZW50cnktPmluc3RhbmNlID0gaW5z
dGFuY2U7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICBfX2VudHJ5LT5sb2NrID0gbG9jazsN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgIF9fZW50cnktPmxpbmUgPSBsaW5lOw0KPiA+IEBA
IC03MDAsNyArNzAwLDcgQEAgVFJBQ0VfRVZFTlQoZGNuX29wdGNfbG9ja191bmxvY2tfc3RhdGUs
DQo+ID4gICAgICAgICAgICAgICAgICAgIm1pbl92X2JsYW5rX2ludGVybGFjZT0lZCB2c3RhcnR1
cF9zdGFydD0lZA0KPiB2dXBkYXRlX29mZnNldD0lZCB2dXBkYXRlX3dpZHRoPSVkICINCj4gPiAg
ICAgICAgICAgICAgICAgICAidnJlYWR5X29mZnNldD0lZCIsDQo+ID4gICAgICAgICAgICAgICAg
ICAgX19lbnRyeS0+bG9jayA/ICJMb2NrIiA6ICJVbmxvY2siLA0KPiA+IC0gICAgICAgICAgICAg
ICAgIF9fZW50cnktPmZ1bmN0aW9uLA0KPiA+ICsgICAgICAgICAgICAgICAgIF9fZ2V0X3N0cihm
dW5jdGlvbiksDQo+ID4gICAgICAgICAgICAgICAgICAgX19lbnRyeS0+bGluZSwNCj4gPiAgICAg
ICAgICAgICAgICAgICBfX2VudHJ5LT5pbnN0YW5jZSwNCj4gPiAgICAgICAgICAgICAgICAgICBf
X2VudHJ5LT5vcHBfY291bnQsDQo+DQo+IEhtbSB0aGlzIG9uZSBkb2VzIGhhdmUgdGhlIG1hY3Jv
LT5mdW5jdGlvbi0+bWFjcm8tPmZ1bmN0aW9uIHRyaWNrIHVubGlrZSB0aGUNCj4gcHJldmlvdXMg
cGF0Y2ggc28gdW5sZXNzIEkgYW0gd3JvbmcgZnVuY3Rpb24gbmFtZSBhbmQgbGluZSBudW1iZXIg
YXJlIGFsd2F5cyB0aGUNCj4gc2FtZT8gSWUuIGl0IGNvdWxkIGJlIGNvbnZlcnRlZCB0byB0d28g
c2VwYXJhdGUgdHJhY2Vwb2ludHMgYW5kIHdvdWxkIGp1c3QgbG9zZSB0aGUNCj4gKHF1ZXN0aW9u
YWJsZSkgbGluZSBudW1iZXIuDQo+DQo+IFJlZ2FyZHMsDQo+DQo+IFR2cnRrbw0KDQoNClNwbGl0
dGluZyB0aGUgdHJhY2Vwb2ludCBhbmQgcmVjb25zaWRlcmluZyB0aGUgbGluZSBudW1iZXIgY291
bGQgYmUgaGFuZGxlZCBhcyBhIGZvbGxvdy11cC4NClRoaXMgcGF0Y2ggZml4ZXMgZnVuY3Rpb24t
bmFtZSBkZWNvZGluZyBpbiB1c2Vyc3BhY2Ugd2hpbGUga2VlcGluZyB0aGUgZXhpc3RpbmcgdHJh
Y2Vwb2ludC4NClRoYW5rIHlvdSwgTWVsaXNzYSBhbmQgVHZydGtvIQ0KRm9yIGFsbCBlaWdodCBw
YXRjaGVzIGluIHRoaXMgc2VyaWVzOg0KDQpSZXZpZXdlZC1ieTogUm9tYW4gTGkgPHJvbWFuLmxp
QGFtZC5jb20+DQoNCg0K
