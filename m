Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73787F531E3
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 02:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E140B10E054;
	Tue, 14 Apr 2026 02:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F0gkFbAn";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30E3710E054
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 02:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCXFhzd3oq5C79Luy4aZPELovK4Ik+BZMWbI8e5b0aQkLsb6WbwT3SqmGcN1IFdQf79N5y3mSdyic4TxAvdDofHvK5tDQ4LRD27ipJWWW9yQdMhhuPlQ3q5BGOfy0rXgKQN8Chrrq+6jP/OvMD6zAAslG/9B/tlzoghmexWnuYNQ+6rcxEXae/2TjFpz8hsvR6QBfxNXhRZraISusOarC4jUIIMI8jrxunTNn4CbvTbaYBdkhGa2Gbo+35E+KwcXVLwLxWJZLAs/yo832PeKwoUnfzN+g+KvKWHiqFPULWTnZfszaYb3mKf/ziqSaUVPdUD04p1Ynmv1VXpKNejzKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73+Jqk53L0fq3JAK/wGbawvbpg8QRu/rvtYFbqg3qeA=;
 b=uzqGiofbmz8dWyjo/+6XUqN6XXR36kQ9Va/1VNJUswJsARhR98Qqolj4kIzNNPeXnA492H2NYC7+23J/Vr8C8F6Rw/OKPO/5ss4Q9nKzF9oUd156W8PVHzfbUU0l4Ufa0gUJuYHdvD7aXeDDi/eouz9dvFlyv1qOKdFrKVRZvWulybNiEn5wmHCBraHQlcdrhuN7/hpkujp0hmtWmjtn8LFf2VyRbZkHt3V4dF6Tzc7yN6nkVKGlMna1nq5F6Zvs5Icx+FRCenLQptE/nM6hR0tT6wHkqW2ShpNYz8V+dFvtl8PBzYksPMKJlN62vl0tLByBsaeNKo9Vjcldmr7lbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73+Jqk53L0fq3JAK/wGbawvbpg8QRu/rvtYFbqg3qeA=;
 b=F0gkFbAnKUJ+EDt5JbIsmxmWnL/B7yft5/SiBXmBctjtNriIaBAZDg3XH9UEaUWP+H6yGMf5+gyjNJLchcTbx5X543TdPCIwIiEgVdZJeJjKspe6MYSo2hT4q3eylu34eAIR/IoB06ZMAvLajvfZUPJaRGAm2n3n15KEBF6Ol4M=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.48; Tue, 14 Apr 2026 02:44:50 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%2]) with mapi id 15.20.9791.032; Tue, 14 Apr 2026
 02:44:50 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sdma7.1: add support for disable_kq
Thread-Topic: [PATCH] drm/amdgpu/sdma7.1: add support for disable_kq
Thread-Index: AQHcvUqXvu7th9+pq0OAgiSkWBt54rXNaioAgA/b3ACAAK4+cA==
Date: Tue, 14 Apr 2026 02:44:50 +0000
Message-ID: <PH7PR12MB600024A792B867BB964322D9FB252@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260326175140.52753-1-alexander.deucher@amd.com>
 <CADnq5_ONMWOCPR3wdWLEKPz7EeOHDS3ZMeFe9VD_5N5CXQ3Piw@mail.gmail.com>
 <CADnq5_N4_0bC-y1FPBq4tP0PpbT8OgDi9Rx3j+m78RTmDoQR-A@mail.gmail.com>
In-Reply-To: <CADnq5_N4_0bC-y1FPBq4tP0PpbT8OgDi9Rx3j+m78RTmDoQR-A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-14T02:36:04.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|DM4PR12MB6446:EE_
x-ms-office365-filtering-correlation-id: 4474ee14-6fe1-4834-a454-08de99cfccba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: zkoSBYTNHrGFpr+xLbUWi49ax5xGNPuh2Vlf1RK6LkFq+FOxVWMoTy+Kl8h/yffoxmgL/cIfudIhNcHF1Owxzp8idoPgnLQRE17wu19CJzSP3/fFwNfArAVwtIyU19a6YOL6rSzANSraLOPOmo3QPiuPi4neh4TEPcV/ZU3NEZOYbYJ+LmOiQcgl8tf0UELvTqrY6e7XP66GErJyXimAGR57YaJ11RfZlrbaBK31GPIrbdwNEGH/fUUDT8PNL7d0qSFcFo4gZ5/AJWs3MgD+1EGOH1ZlC2Tf1tJSRO8iS33CevcN0AyTfQVMolSah7yVGgIo/KqDkGygaxBUxO4FM1Nud0QikDAe3kxkz5seqKLZUN5wuEtTMutjHLoAIWLqJpHJrl/DP7nXiSE6jvu8wPz3MCWYeyes0/LgI9iCrrz/1HbcrteVrbIDJ4nyW4RBMpjPdn+zeSCR3q3CMRQaYXbgcPMPmHcuJ4nxnfLpuwiIvr6L12zHuSFPnSqvSVEcvqOzm71CSE3nPDO229GNrQonOmx+/aWb/Bs3Rtg96RRJ9gbHweJwS6TM7R/l/7MyWAo0BfIxL9v934aaGFFw99Gwf5SdKXlVDwCX6oeLJavjlYXzUo6ASNuKPuipCLRNohYytYtTsOuLqHP3QprUId7jEQ0h9ciX4uRUYE8U3kQrqPzY1ehcwm2Z2eAQ//mtBdDFS7YHKR8ZdHoS2xnrDLfSOq8PRzZbWt6ABWx6gyWeNT3OJZyZkON86bMxw34iIZUieNXqO2ljqzB8vl/CSJTq+gcPU/fXlvfQg5UkZy8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVZXUVdmS3dmYVhJb3lSc1haa1dCQ0JIa3RiMUxudVBtNCtJMlROQjF2aU5t?=
 =?utf-8?B?VTEzQWxjZlJhYkFGKzFMZndjSjJkOUdnWUN4ZW05d2l0TThnc1locUoyTlpR?=
 =?utf-8?B?dDhpbHlHd2I5NVJPU21zZy9uSk5CM1JWUytoOXJHMnA1TGdSNUhuRFVidkxj?=
 =?utf-8?B?Yi9HVVpJd3NUWGkwRVA4YTJ0aHBITEpBbFdZOWtIQ2gxQjBVUGcxYVdjekdx?=
 =?utf-8?B?WFhqU3R0T2NhY1I2R3psUmQyQXdrc0FaMmRzdmd3ZmtOd3k5d1RtaisyRjZM?=
 =?utf-8?B?eS9jZlplbWJDY3kzekMvNGlrRy9KVFdmRFBBbzB0c0hWT2xrNWxrWHdkVFFC?=
 =?utf-8?B?RnNpODdzZ3lXRVZSaG9qMHhWNEEvekc0VFVvL202SVRwalQ2L0VnaTdXenJy?=
 =?utf-8?B?VkJqUEpwWHdNMy9Ma3F5d3pNZHczdWdnRkM0ZE9mUWR2UkNZc25US0lielBw?=
 =?utf-8?B?VGNGOUhVd1p6SERPeDA2Z2JtaGEyRGF3TDl1YXVlYTdCZDdvaGhlaHhQVXU1?=
 =?utf-8?B?UzdiUlArdG1WT29JMU5EbnBDWm1xdkFTWWFDOENQOXNCQmhNcGlIWEdQK09F?=
 =?utf-8?B?WVh2Qit5RldkY3lMRWZQMXEwTjFkWEk0QXk3VmhUN0ExQUNXQlA4c3Q1Z1Bw?=
 =?utf-8?B?V2RYd2N5Wm5INmtueWh3R2dTWEJZU0xjMlhYdHNaOTFSL0JjZ1JGWXFSRlln?=
 =?utf-8?B?T0JQY0lkL3BpUGlYSk1CQVFnMmhKVktXYmRDN2pBNlBWenFJbFdock1CQ2tC?=
 =?utf-8?B?YzFUQktVMUhldFFoS0tBT0xrMjlQUlZ1RGsxM0ZBZ29QTDB1cFRPbzJSczZ6?=
 =?utf-8?B?WEhOZWpUK1BEVndKZUJZWnNUWU4xRTNpamFuN3VDM0pXSDY4MVgzR21CK1Jz?=
 =?utf-8?B?K09rZHE0UkcxS1Q2c2JPd0UyNnppOVJoZk16MFc5VzJ1ZXRKUmdpS0gydWUw?=
 =?utf-8?B?MFRZZlhWTkxIQlRoT21YNnhaQ1B6YUxxajlOMmNpcHd5b1pUWTNSL2pzV0hC?=
 =?utf-8?B?TVZtVXh4R01XRUR2bVR1Nmp1THNLR0Yva09NNzBkQzByZDdKbkUxQ1VxRFlM?=
 =?utf-8?B?UmR5emxLdVhGeXNsSnFGU0RlRXllSHBod0hkMGRBc3F0ZDVWTmdQeEVFT21P?=
 =?utf-8?B?ODNTWFJiVllSTHFIQmJ5ck1LTG42aUR5WmdsaDRnaWdVaGNDQ3RUSExuc0ZH?=
 =?utf-8?B?dUFZQ1o2SFFBWmtRTVg0RGo2ZjJlWjVUbitscURwY3luV0xtaFB0QXFYSjRt?=
 =?utf-8?B?QTkwSWk5Qnl4MUkrOGh2UnpiS1UvL29ZWklPMUllL1BoZFl5YzFHSlE5YmQy?=
 =?utf-8?B?dzFnQ1pLajJhNWNUd1FVQ2dXK1ZBVGczejhESEV4UFNDM0l4R3FSYSs0NEYz?=
 =?utf-8?B?ZVFQUVNwQUdCTEtrcGJGSWpyUEZZb0M1SVNnc3BFQTRMRTRrSGlpVGVHNldD?=
 =?utf-8?B?ZWg0aHF1ZGxsYkhiNVB5UlZtSjlKTkJJL0sxeUY5RysrQmMxMWJvbmlCMUpE?=
 =?utf-8?B?b3NTNE1Kdk5Mc3JNd1dvY25KejQ0dkJSc0NvYTJWTytNYWNLR0J5WDB2eEM5?=
 =?utf-8?B?UkJlbEhxZHlRY0g5bWFwTmJTMENUUUI3R1l0cHBxRTA1NEFyVXJYSHNJWnJ3?=
 =?utf-8?B?L2tTQXR0OHFNQ2FsTFFRYmkwMi9Qc20vTThGNWFmaGRLOExrbEFjOGRlb2NC?=
 =?utf-8?B?SHlUaEhDVTVvRmM4bEJvcklWaXlnR1lYUmFLNG54dXVQM004bEY3ZC9Nd2tQ?=
 =?utf-8?B?SXArQWE1ekZLZHR1T01lN213S2s5VldWY0ptRW1RT0FZMEZSU1FvemdZRThw?=
 =?utf-8?B?dmxubUwwM2MzOW9XWUNzTHhTQnJSTndBY0xqS0FUTmx2c3NXNDBBd085akdk?=
 =?utf-8?B?V1ZiTFZUOFR2QWdFeEdQTTZKaWlwa1Rvb3orVTM1cjQ3ejlSTXlUeTl1K1g5?=
 =?utf-8?B?N0ZmcCtFZHZ2VmpESTUwOXY0WGg4bEE1UkdYcHB2clNwdHRBRmJRUk5CQkFM?=
 =?utf-8?B?dmtCbVpaN1VFdDNaeis5dXZQbS8xc2dTb1Q5SzFkNm5DNm1ZZmQ1V0IyQThH?=
 =?utf-8?B?Zk13VFdxdDVHSlh2Wjc5MnUycEdBMVJuSWdtN1MxSS9vWEdtU3ovL1F6Q0xp?=
 =?utf-8?B?N2gzUzRxNUJhZ29wRFVKeko4d2NSUjRoZHlEYzh2UC9NZUtNZFZuRzU2N1Vl?=
 =?utf-8?B?NGw2QWF4czI5UmtBZmRJcmNIdHNtekliZy9DNmNxaFhnSjZTUk14UkR1WU1N?=
 =?utf-8?B?N0hDRU15czBBamtpZFBwb29JQW1GdmUrVk9mWFpWMnZoQkUreTc5eUlpLy9T?=
 =?utf-8?Q?JNX/TmN3tvBJfbdOFN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4474ee14-6fe1-4834-a454-08de99cfccba
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 02:44:50.4929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZjROWC4t5IN2/S0zr7vnpgXXBQ/AGRijydKKHQ7mTTjc45G/x7vjObFH41dKMDk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXgNCj4gRGV1Y2hlcg0KPiBTZW50OiBUdWVzZGF5LCBB
cHJpbCAxNCwgMjAyNiAxMjoxMiBBTQ0KPiBUbzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdS9zZG1hNy4xOiBhZGQgc3VwcG9ydCBm
b3IgZGlzYWJsZV9rcQ0KPg0KPiBQaW5nPw0KPg0KPiBPbiBGcmksIEFwciAzLCAyMDI2IGF0IDEw
OjAx4oCvQU0gQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOg0KPiA+
DQo+ID4gUGluZz8NCj4gPg0KPiA+IE9uIFRodSwgTWFyIDI2LCAyMDI2IGF0IDI6MDnigK9QTSBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IHdyb3RlOg0KPiA+ID4N
Cj4gPiA+IFBsdW1iIGluIHN1cHBvcnQgZm9yIGRpc2FibGluZyBrZXJuZWwgcXVldWVzIGFuZCBt
YWtlIGl0IHRoZQ0KPiA+ID4gZGVmYXVsdC4gIEZvciB0ZXN0aW5nLCBrZXJuZWwgcXVldWVzIGNh
biBiZSByZS1lbmFibGVkIGJ5IHNldHRpbmcNCj4gPiA+IGFtZGdwdS51c2VyX3F1ZXVlPTAuICBL
ZXJuZWwgcXVldWVzIGFyZSBzdGlsbCBjcmVhdGVkIGZvciB1c2UgYnkgdGhlDQo+ID4gPiBrZXJu
ZWwgZHJpdmVyIGZvciBtZW1vcnkgbWFuYWdlbWVudCwgZXRjLiwganVzdCBub3QgdXNlcg0KPiA+
ID4gc3VibWlzc2lvbnMuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc2RtYV92N18xLmMgfCAxMiArKysrKysrKysrKysNCj4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y3XzEuYw0KPiA+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y3XzEuYw0KPiA+ID4gaW5kZXggZjIwZTBmYzNmYzc0
My4uMDYxOTM0YTJlOTNhMyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NkbWFfdjdfMS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zZG1hX3Y3XzEuYw0KPiA+ID4gQEAgLTEyNjgsNiArMTI2OCwxOCBAQCBzdGF0aWMgaW50IHNk
bWFfdjdfMV9lYXJseV9pbml0KHN0cnVjdA0KPiBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQ0K
PiA+ID4gICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGlwX2Jsb2NrLT5hZGV2
Ow0KPiA+ID4gICAgICAgICBpbnQgcjsNCj4gPiA+DQo+ID4gPiArICAgICAgIHN3aXRjaCAoYW1k
Z3B1X3VzZXJfcXVldWUpIHsNCj4gPiA+ICsgICAgICAgY2FzZSAtMToNCj4gPiA+ICsgICAgICAg
ZGVmYXVsdDoNCj4gPiA+ICsgICAgICAgICAgICAgICBhZGV2LT5zZG1hLm5vX3VzZXJfc3VibWlz
c2lvbiA9IHRydWU7DQo+ID4gPiArICAgICAgICAgICAgICAgYWRldi0+c2RtYS5kaXNhYmxlX3Vx
ID0gdHJ1ZTsNCj4gPiA+ICsgICAgICAgICAgICAgICBicmVhazsNCldoYXQncyB0aGUgY2FzZSB3
aGljaCByZXF1aXJlcyBkaXNhYmxpbmcgdGhlIFVRIGFuZCBkcm9wcGluZyB0aGUgdXNlcnNwYWNl
IHN1Ym1pc3Npb24gdG8gdGhlIHJpbmcgYXQgdGhlIHNhbWUgdGltZT8gSWYgc28sIHRoZW4gaG93
IHRvIHNjaGVkdWxlIHRoZSBqb2IgdG8gdGhlIFNETUEgZm9yIHRoaXMgY2FzZT8NCg0KPiA+ID4g
KyAgICAgICBjYXNlIDA6DQo+ID4gPiArICAgICAgICAgICAgICAgYWRldi0+c2RtYS5ub191c2Vy
X3N1Ym1pc3Npb24gPSBmYWxzZTsNCj4gPiA+ICsgICAgICAgICAgICAgICBhZGV2LT5zZG1hLmRp
c2FibGVfdXEgPSB0cnVlOw0KPiA+ID4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4gKyAg
ICAgICB9DQo+ID4gPiArDQo+ID4gPiAgICAgICAgIHIgPSBhbWRncHVfc2RtYV9pbml0X21pY3Jv
Y29kZShhZGV2LCAwLCB0cnVlKTsNCj4gPiA+ICAgICAgICAgaWYgKHIpIHsNCj4gPiA+ICAgICAg
ICAgICAgICAgICBEUk1fRVJST1IoIkZhaWxlZCB0byBpbml0IHNkbWEgZmlybXdhcmUhXG4iKTsN
Cj4gPiA+IC0tDQo+ID4gPiAyLjUzLjANCj4gPiA+DQo=
