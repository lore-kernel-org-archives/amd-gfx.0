Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95870C79F9E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 06:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 080CA10E45C;
	Mon,  7 Sep 2026 06:48:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WrfvbZt6";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011068.outbound.protection.outlook.com
 [40.93.194.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB9ED10E45C
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 06:48:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3TlOfVx8c3qUYKFltXTo9HCVQrTLQtktrQgfwLewljOm/kT6E/c25U/ZVqfnG5FhacfCJavr5BOD9w/lUOkX6SY0vK+YsQqBJXpsPyYP1XaHaTPTTE8M0VzdtuY+JU3CQrNo8pFQoP/z26Lv2scc+DBPUW/I2XaRVXBx9iZwbl9YdhdTYi0oslxFRFdx/6dTjR1nWCTR5lC/Lnql+UNQek4kPtbXcQHI9vr+3MCXUv4xbuI7ESRarGX8BptWQQ3ksFaXA//6YNGx/XDt4jiensTPENWnnA9kJJnBzQFHUmdaI4l+ksjdNlicqXFWu5ChL11eZ32gYhv0hjAyLWC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQWy5VUnJ+IOfqyvEvjlnrX7VUcK+AawQt2Ex1Nwq1A=;
 b=m34yEV2AHR4/PVSHarftVl6hCbFUUTKVs8t2nbyellWMv+/0YT9O9GXeenhEwY9MZNL5xDO6zYJHaUyu7/hQrcGZibkE05pg3HzBQr3QZdRZYLgjtYW0ZwV/8TFWW5ASA1Q3BdQc+pwPY+cKTZ6U8UVmS3UDpXJv25CeVPZPUR7arBAMNLc1KySwDVbu6Ecr2/DzYczH5Ka4SQhpfrfV7uwHrs7FpyIVfQ0ID3xhqRjyNsRllQE7Fh78kK9IaAjq+9Tr+YVGm35TTb3rXemVCRIca0M+KneUi656X26kFDH7YB70BtdcJJHVoGTN/NBUR2wK4wjPml1BvkykQY/QHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQWy5VUnJ+IOfqyvEvjlnrX7VUcK+AawQt2Ex1Nwq1A=;
 b=WrfvbZt6fTGFQPGBtXKgVT5uC1db/zrtUIN0TxIseBdfQ0oul1Bd8H6X0eXbs4p+mA0fTrDKHlv8o9J18bKsGxktGmUj1BlTQF2f6em75eGy7u7WBswuOlC3tnflEera9UbRa0qJBYzlRtGnJS1iG1+uwyARZIgvfD8j68zrjLE=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DSVPR12MB999172.namprd12.prod.outlook.com (2603:10b6:8:38b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 06:48:50 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 06:48:50 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH 01/18] drm/amdgpu: Remove separate guilty compute userq
 reset
Thread-Topic: [PATCH 01/18] drm/amdgpu: Remove separate guilty compute userq
 reset
Thread-Index: AQHdOtmkANncSu4ssE6FaZb7xvPsjLa9PxOAgAVunuA=
Date: Mon, 7 Sep 2026 06:48:50 +0000
Message-ID: <DS7PR12MB60053CFA7E34A479CCF78168FBB22@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260902125001.621629-1-Prike.Liang@amd.com>
 <CADnq5_Neiu-GKP_xoahHVo2kk0deyU-Q11=DTF1gHRUhXAU9JA@mail.gmail.com>
In-Reply-To: <CADnq5_Neiu-GKP_xoahHVo2kk0deyU-Q11=DTF1gHRUhXAU9JA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-07T06:25:37.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DSVPR12MB999172:EE_
x-ms-office365-filtering-correlation-id: 077670bd-399e-4df8-3a34-08df0cac1326
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: eEWHGX1AXw/3xcWeQH4Z866OtqMHqiIHm0N+2utASGq1daz91kp//jY0cO3Q4iWri1UyHFvbky6yU5h1xxyGKwkgDMlzYE+I579cfq4zQ3BS847mM3F7xVda+FqDMCtP3PwtpN/IvK/B+zVs19mhNwKixWlS+olgNekLvSpd0BV5We8zqFs/3osBMA42MuiOlBZwMgly32GFfd5w411K+CekCVvSGYCFj9vvaLe4pIIXJyhQGt7zaG/S+Mf+AwaCtFFtAPzcLj+Bi9MNpvKoPnsjTmtKfWIWgilM1INUbAxbyzVLwpoTuJg5ttPjlybrtRa2t98+DeppxIxG1VL68SscGRK9qWd7sgYiX0DGv8zgyP8yz6DfwNbwiN0My1A+MHMMOVL9jl5bwx5qel9LYuA5GWFvoGeQmlSVVuGl7OjMWxRJcCtcyPRPeLc/oDjuvimJX03Se5ys0SRF/qlh7i+A44BWpDBVadct9/QKHkgTCP4uMZX4PQn72fIho7AJNwz3WEO/Iq6/aMDT3WID+eoPBmbGfZQ0qL3vzGXxek4PM+HEM5/bW3MzBatjdhLcsfm3XJaB+ebR6M1Pyh3xKJ1TXbpFBBACeEgjRLHqemromIG6yRMtTtRKC750FRaNAEpPNAXx5HnsuAfA47ToyBGlMwVg8HGfYR3tF+2jEeI/rujtDU3yCItgUNqcDmcaNxqcWS1vGYXxiA4IYKs8rNdCSlIEXUGKPZYo8EeoioQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2QwVmpJMkZDcExTOWx6eDJGY0hFSi9QY2ZVc0hYOTRuRE41dnR4Y2txUzRr?=
 =?utf-8?B?MzZvZ2pyYkRSWG81NVgvVUJMVGRZMGYrYTh1eHdoT1dkVmJId2VUZmgxcHdi?=
 =?utf-8?B?ZDhESUl1dlpPMG5pR2VUaEtaZ2ljL1lTYWlQckNESFpsaEF6S2tycXFIU3Fh?=
 =?utf-8?B?R3p4dDJXdUFSYlJQLzAzc045Y1hSeG1MbzJwcnM4Vm00SzBEM2V2YWI3cnZU?=
 =?utf-8?B?Wnpya2krTlFXK3Rnb1hwOVAzcEo2eHJVUGxJN2l4R0VWN1p5bU93S2JnOThX?=
 =?utf-8?B?RHFoSENUOHFNYnd2NkZnejM4UnhUUnV0aHh4SmJ6ZUZYVnE4OFFOS0dBUEMv?=
 =?utf-8?B?N1hvS3VrWWh4ZHhEckh4NkU2RWxycWdzM1pNQlpjd2RLd3FiSFhHNWthMll0?=
 =?utf-8?B?ZlZlVHE3YXRGOU5aRndDRFEvTVFqQTJNWTJKbTNiREJTR3o0SVJsZnhaTEgr?=
 =?utf-8?B?VE5OMVZxdGs5OWVFOWRvWnIxNzIzOHJzMzJBNTN0STAraEtMYnREUi9odXNH?=
 =?utf-8?B?TkVoNkloaUtkd0syb0twUnJTYzBDbnZkR2Jqbk9vTnFYcHFXaGhKREt4M3Fk?=
 =?utf-8?B?QjdFUzNEVWdxQXE2ZGl0SkJMand6b0R1amFoeFJaL1NzK1RuNjhHTVBic3BD?=
 =?utf-8?B?WGEreElPQmRyRHZzMWc0bFhsVmRweDMvUjVqSTRuMjN2OVQ0dkw0ZXhyZHNr?=
 =?utf-8?B?Z0ovWWt0V1QwTWJJN3VuVlNBUGlyK3pqbFR4SUVzeGVCTFlmTmVKMnZFSFZh?=
 =?utf-8?B?TU9Oa05ZNWZFTVdaNC9Ea1lQUk5xeGdoRkZOVnJqaHlMQ0lkaVV2bjVXNCty?=
 =?utf-8?B?SVE3R0R4NVpRbG1xNEZCNzlCbTFnWHVLS0dyaDJMb3JhVXN4Y1hYWmg4MEJ0?=
 =?utf-8?B?VnpLQXBVL1lmK200QzdpbG1QZmFhTDgvdWY2MEx4bDYxamtLVUZMY25XOHdR?=
 =?utf-8?B?SllpY01XUnFiTGRFZFhxRWtad2xuY3VUN3VVOWUwc2RwWU5Zb3AxMUFhdDRQ?=
 =?utf-8?B?b1Bzd1pVZXNGeHE3WTl1MWVzc1UyaVFMV3BQaDNlYUxBMDFzalNZM1hFdXdB?=
 =?utf-8?B?QUVGMXVzQ2laU1B1T3FKUlQrYTNMM3dISjBBV0doQkN6T2pNTGl0TFNWTjNx?=
 =?utf-8?B?Zk1TTE5CSFphbHdVNkNCTTNwcG53TGxwZVdVVDNLT0thRitvSi94RHJqZDk0?=
 =?utf-8?B?YjBqb2MrOE5LZzBwV1lTdmxtdjlXRjVXTjhONndYVDFJalJXbFNKVFg2aEJz?=
 =?utf-8?B?RlltTjFqa0hFYk9YYkdIYm5ZUFZZTHJKdEpYSTFuYTNMQUp2OVRuN3Z5Vnhw?=
 =?utf-8?B?ZjVzTHc2Q3hvQU8zYWN3WkhYMlEwMTY4bWl2L2tmMnRXMGUydW84dE9XQ05L?=
 =?utf-8?B?MWM0Y0R1SENqNE8zc3hrbkxnY2xlZU5RbmxqK3MvVzJYd205K2w3T1NSYTdW?=
 =?utf-8?B?ZmtMZFZtZ1lxN1VCWVhja0lBZkZuWU9BTFFJcXBYbGMwWFUvelF2STkycDJ5?=
 =?utf-8?B?Uys5dnQ0NkdsQ0UyR1E2aENpbmR2eGtreWtLTUNmSjVsZnlLRk1RSWgxV0t4?=
 =?utf-8?B?ZnVlWG5lTWRPeTNjVUxJTUhSdGdTRGpzTFB6WXNzTHU3L2crV1luWWc2b0xR?=
 =?utf-8?B?T0tuN1NsNS8xV1BhN3k1c1dyQnpCN3ZDOWdzdzR0eHJDbTh5TnJ4R2ptOHhE?=
 =?utf-8?B?b01wSE93TjRlNCs3cWtxSENWNXBZV2pRU3h2anZVRi9FUG8rRDBIU21YK3Zz?=
 =?utf-8?B?YUJ1RjRvK1I0NVpXaEI4alZOOFRsM0RjOUU2bVl0TmhjMUdDSjlXRnFQemRy?=
 =?utf-8?B?dHhDK1o2T1RqalJURGJNdlZlM3FYaXpZV1pCR25VZzB4aFM4eHB3WGZML3pu?=
 =?utf-8?B?TWlNblY4Nkx6RTM5OGRCK1BPbHl3VElpdHhvRWZvZklVR3JqZ25Ma1dCLzlt?=
 =?utf-8?B?ZjhWVWc4Y3h6YXpXeEJOUTB2Y2M3S2JaNVFWbzc0NnpkV0dyTEwySUhpSHhD?=
 =?utf-8?B?ZGlWNXZJUXNpNmowdmhPcjRjMU1iSFoyMUtsQzFmQ0lzdGZ2dXpra0lIenc3?=
 =?utf-8?B?WVF3bUpPTjNnemgrbmRFdnhUR0dGY0M4REx3SWZKelB3Zkp6V25tTE53eXk0?=
 =?utf-8?B?NWdvZmNISEMvc0F3eFU1cEVHNVpqdGhmVEhMYWxNZE1LWWtpWndvNFdZN09B?=
 =?utf-8?B?Q0J0OGtwaWlSQ05TaVkvMFlueU9sc1lwdGE1VkdMdnNlcFA5QlFESHpOL0dH?=
 =?utf-8?B?a0dQUHhjd0VZa3NGVGJTNldzaHR5REtQSXcramVtNjJrVGljU2Z0aXozdnpW?=
 =?utf-8?Q?5mubtILwKsEt37UzF3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077670bd-399e-4df8-3a34-08df0cac1326
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 06:48:50.4823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fE2Cy28Y2hJwqwCWSxjm6YXoijuBP0AyBvnE9GjN7YOGdVSjK3DkiGuRzCBSSHRG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999172
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

QU1EIEdlbmVyYWwNCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+
DQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDQsIDIwMjYgMzoyOCBBTQ0KPiBUbzogTGlhbmcs
IFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+Ow0KPiBQcm9z
eWFrLCBWaXRhbHkgPFZpdGFseS5Qcm9zeWFrQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMDEvMThdIGRybS9hbWRncHU6IFJlbW92ZSBzZXBhcmF0ZSBndWlsdHkgY29tcHV0ZSB1c2Vy
cQ0KPiByZXNldA0KPg0KPiBPbiBXZWQsIFNlcCAyLCAyMDI2IGF0IDg6NTDigK9BTSBQcmlrZSBM
aWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBhbWRncHVfbWVzX2Rl
dGVjdF9hbmRfcmVzZXRfaHVuZ19xdWV1ZXMoKSBhbHJlYWR5IGRldGVjdHMgdGhlIGd1aWx0eQ0K
PiA+IGNvbXB1dGUgdXNlciBxdWV1ZSBhbmQgcmVzZXRzIGl0IHRocm91Z2ggbWVzX3VzZXJxX3Jl
c2V0X3F1ZXVlKCkuIFRoZQ0KPiA+IGFkZGl0aW9uYWwgcmVzZXQgdmlhDQo+ID4gbWVzX3VzZXJx
X3Jlc2V0KCkgaXMgdW5uZWNlc3NhcnksIHNvIHJlbW92ZSBpdCB0byB1bmlmeSB0aGUgY29tcHV0
ZQ0KPiA+IHVzZXJxIHJlc2V0Lg0KPg0KPiBUaGUgcHJvYmxlbSBpcyB0aGF0IGFtZGdwdV9tZXNf
ZGV0ZWN0X2FuZF9yZXNldF9odW5nX3F1ZXVlcygpIHdvbid0IHJlc2V0IHRoZQ0KPiBxdWV1ZSBp
biBzb21lIGNhc2VzLiAgRGV0ZWN0X2FuZF9yZXNldCgpIGF0dGVtcHRzIHRvIHByZWVtcHQgdGhl
IHF1ZXVlcyBhbmQgaWYNCj4gdGhleSBmYWlsIHRvIHByZWVtcHQgdGhleSBhcmUgY29uc2lkZXJl
ZCBodW5nLCBob3dldmVyLCB0aGVyZSBhcmUgcXVldWVzIHdoaWNoIGNhbg0KPiBiZSBwcmVlbXB0
ZWQgd2hpY2ggYXJlIGluIGEgc3RhdGUgd2hpY2ggd29uJ3QgbWFrZSBwcm9ncmVzcyBzbyB0aGUg
cHJvdGVjdGVkIGZlbmNlDQo+IHdpbGwgbmV2ZXIgc2lnbmFsLg0KPiBUaGF0J3Mgd2h5IHdlIGhh
dmUgdGhpcyBzcGVjaWFsIGNhc2UuDQoNClRoYW5rIHlvdSBmb3IgdGhlIGRldGFpbGVkIGJhY2tn
cm91bmQuIFJlZ2FyZGluZyBhbWRncHVfbWVzX2RldGVjdF9hbmRfcmVzZXRfaHVuZ19xdWV1ZXMo
KSBpbiBhbWRncHVfZ2Z4X3Jlc2V0X21lc19jb21wdXRlKCksIHRoaXMgZnVuY3Rpb24gaXMgb25s
eSByZXNwb25zaWJsZSBmb3IgZGV0ZWN0aW5nIGh1bmcgcXVldWVzLCBub3QgcmVzZXR0aW5nIHRo
ZW0uIE9uIHRoZSBNRVMgZmlybXdhcmUgc2lkZSwgYSBodW5nIHF1ZXVlIGlzIGlkZW50aWZpZWQg
YnkgcmVhZGluZyBhbmQgY29tcGFyaW5nIHRoZSBNUUQgc3RhdHVzIG92ZXIgYSBxdWVyeSB0aW1l
IHNwYW4uIEJlY2F1c2Ugb2YgdGhpcywgdGhlcmUgaXMgYSBwb3NzaWJpbGl0eSB0aGF0IGEgc3B1
cmlvdXMgaGFuZyBkZXRlY3Rpb24gZ2V0cyBzY2hlZHVsZWQsIHRyaWdnZXJlZCBieSBhIHVzZXJx
IHNpZ25hbGluZyB0aW1lb3V0LiBTdWNoIHRpbWVvdXQgY2FzZXMgbWF5IG9yaWdpbmF0ZSBmcm9t
IGEgbG9uZy1ydW5uaW5nIHN1Ym1pc3Npb24gb3IgYSBzbG93LCBoZWF2eSBxdWV1ZSBleGVjdXRp
b24uIEZvciB0aGVzZSBmYWxzZSBwb3NpdGl2ZSB0aW1lb3V0IHNjZW5hcmlvcywgd2UgY291bGQg
Y29uc2lkZXIgcHJlZW1wdGluZyBhbmQgcmVzdG9yaW5nIHRoZSB1c2VycSByYXRoZXIgdGhhbiBi
bGluZGx5IGlzc3VpbmcgYSByZXNldCBvciBhbHRlcm5hdGl2ZWx5LCBoYXZpbmcgdXNlcnNwYWNl
IHNraXAgZW1pdHRpbmcgYSB0cmFja2VkIGZlbmNlLCBhcyB5b3UgcHJvcG9zZWQgaW4gYSBzZXBh
cmF0ZSByZXZpZXcgdGhyZWFkLg0KDQpJIHdpbGwgaW52ZXN0aWdhdGUgZnVydGhlciBhbmQgZHJh
ZnQgYSBwcm9wZXIgc29sdXRpb24gZm9yIGhhbmRsaW5nIHRoZXNlIGZhbHNlIHRpbWVvdXQgY2Fz
ZXMuIFVudGlsIHRoYXQgaXMgZmluYWxpemVkLCBJIHdpbGwgZHJvcCB0aGlzIHBhdGNoLg0KDQpS
ZWdhcmRzLA0KICAgIFByaWtlDQoNCj4gQWxleA0KPg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
UHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYyAgICB8IDUgLS0tLS0NCj4gPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3VzZXJxdWV1ZS5jIHwgMiAtLQ0KPiA+ICAyIGZpbGVz
IGNoYW5nZWQsIDcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ2Z4LmMNCj4gPiBpbmRleCBhNmY5NWZmNDdkMjQuLjVjM2JlODUxYWM4
NCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4
LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMNCj4g
PiBAQCAtMjM4NCwxMSArMjM4NCw2IEBAIGludCBhbWRncHVfZ2Z4X3Jlc2V0X21lc19jb21wdXRl
KHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+ICAgICAgICAgICAgICAgICBkZWZl
cnJlZF9lbmRbbl9kZWZlcnJlZF0uZmVuY2UgPSBndWlsdHlfZmVuY2U7DQo+ID4gICAgICAgICAg
ICAgICAgIG5fZGVmZXJyZWQrKzsNCj4gPiAgICAgICAgIH0NCj4gPiAtICAgICAgIGlmICh1cSkg
ew0KPiA+IC0gICAgICAgICAgICAgICByID0gbWVzX3VzZXJxX3Jlc2V0KHVxKTsNCj4gPiAtICAg
ICAgICAgICAgICAgaWYgKHIpDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7
DQo+ID4gLSAgICAgICB9DQo+ID4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgbnVtX2h1bmc7IGkr
Kykgew0KPiA+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKmhyID0gTlVMTDsN
Cj4gPiAgICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV9mZW5jZSAqaGYgPSBOVUxMOyBkaWZm
IC0tZ2l0DQo+ID4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMN
Cj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+IGlu
ZGV4IDdmMzM0ZjcxOGNkOC4uODNhNDM4ZDhlMTE3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+IEBAIC0yNDksOCArMjQ5LDYgQEAg
aW50IG1lc191c2VycV9yZXNldF9xdWV1ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiA+ICphZGV2
LA0KPiA+DQo+ID4gICAgICAgICB4YV9mb3JfZWFjaCgmYWRldi0+dXNlcnFfZG9vcmJlbGxfeGEs
IHVxX2lkLCB1cSkgew0KPiA+ICAgICAgICAgICAgICAgICBpZiAodXEtPnF1ZXVlX3R5cGUgPT0g
cXVldWVfdHlwZSkgew0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGlmICh1cSA9PSBndWls
dHlfdXEpDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAodXEtPmRvb3JiZWxsX2luZGV4ID09IGRiKSB7
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1cS0+c3RhdGUgPSBBTURHUFVf
VVNFUlFfU1RBVEVfSFVORzsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlm
ICh1c2VfbW1pbykNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=
