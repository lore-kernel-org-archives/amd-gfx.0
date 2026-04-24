Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04425FB44C8
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 08:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7582910F39A;
	Fri, 24 Apr 2026 08:01:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cmooOA5s";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F0610F391
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 08:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mm9/jrPpYPm6QxmgrEpakYsZATNGhpJ/NGWAdONFmLtb+sFNYLmpC510YRXCW0bErLGS8ZqAp7IzwOhmINo8sjpl+Aw2p21x6hT+nrhmewtxxMpEGw9p414CRjOI7x+0Dcu47gJOd37L9hj3mSAdSb0oq75PilX1X9ohYeG5sBJDVGWMYXquxAG2IYeutX9F7UDbHQ7gLtgB4FQMFmEX2ZDuTiFnwUGV2z3n4At/XBfwFGwLl/6EJMcVS7E/p7Wa72Ls85THfnbRHOOtA5xTuAbBmoL2DwrcdHpP428CJMbRC90VDBnX5R1O3wBFGYx4CZvRX23VDk20gpIdF0qp/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50NyDoCTRAfaPOJtI43KPi6LmnqTYI9jO5qVE/uuYLk=;
 b=i9KAVl43X6qnNrtxMwLNPClVuHiiuJDkjUvsDgtwjE0nc+xxwJktCsV3SGhDt1ezoK2hCRTrs0EK8RXKX/5SFLafckC6Jm4Jb09sXS8DdZvCeS/zp8CORzTOgtVm7yd+p32nexC2cbtdvtmhDo7Se04Qc+kcBvkcqcHA/0w4B+tQoBOky9wEpXYsMNizNDs/ACq25tsbUtAqqwsqRGDbPAw4QmQWV/PTitj8kBzit/YHfu/vrKiIAcOh1irrwMef21rBbg9+DnRZ5FI0GmBk84qOCSg1l5DDU2cv1Bc8EAKtKvqXelZTByAJ5N6MsfUdyRbv715Y8cOS2fCenpwkXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50NyDoCTRAfaPOJtI43KPi6LmnqTYI9jO5qVE/uuYLk=;
 b=cmooOA5s3VNfiYynYSZ12txh0bp4l0kr+8G2VSHVoK7wo0YKAL3iamGj4QIMbCyowhvj/9Xboecb9b3ST/Q7EwxhTA2EdoCFyqR2sN5T//IRW+VhnZoVYyYvA0USfb2kBo95iSN4pr9cYbJh+GlhAJG5J6h0so1QC4sy/ETVvXY=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 08:01:48 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%2]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:01:47 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 04/11] drm/amdgpu: rework amdgpu_userq_signal_ioctl
Thread-Topic: [PATCH 04/11] drm/amdgpu: rework amdgpu_userq_signal_ioctl
Thread-Index: AQHc0Y4iHpG8LFhUgEW+QQn0ZnfAubXsZzvAgAAS0wCAAVS4MA==
Date: Fri, 24 Apr 2026 08:01:47 +0000
Message-ID: <PH7PR12MB60002D0F42DB677AC0C2F40AFB2B2@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-4-christian.koenig@amd.com>
 <DS7PR12MB60051B45E53E61949D874CDDFB2A2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <03e6c28c-5c16-4e5d-8c26-a214f0aef012@amd.com>
In-Reply-To: <03e6c28c-5c16-4e5d-8c26-a214f0aef012@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-24T07:07:05.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|SA3PR12MB7860:EE_
x-ms-office365-filtering-correlation-id: 551ed96c-daf8-4e41-2564-08dea1d7bbde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: h7rcDmMYAQ5Av4SyANmKwzr5xDRQXg2X5VTrmeZoXadNoAhOlCjeoKuKXBCb/BgzsQctKtznaPbjwVHyX3QJ1n+mVoZqiHegB5GcOs72ujlGs7O4JWMNyj0rbnjRT4QM3eqz3UvkreOOX6DB09mG2n+B5RrOBGNGiPgG9hH4S55bpPQI/Ebq+rZ8y1sZ5lbevTRPb7uLPIH03vrD5133tVya8/fliOEHP1vB4NU+CePCwgIwObMssrrFTJLprS4nRDxV1ctUxLGWnta3PgWXtjtQdCpN5SOZuGSEFSFiZXIIaFz2Mj6uv6pDj2SxpaEhDJy/ppqRb10UBvhcisy+ENRxHDMc6zvadXXqmbnFKH+67WjQ8A42v7GtHa6R0wakUV+YOc7scCvTLwOsUTD1B5FAxhqaHx52XiSsv2hdt+U7OTSdyfx1Jn/0QVX4v9P3hNubtKXz6opjbi9Ke2gjsMnL3QypLBsBPvhExGwVZmLGqXVWr/C2yaremFqUmlFyiqCvRJA25IqcCHFW6UURBj7yB/8hylZ1gUvtXSNV1D3HlMKV3odaUyEMh9ol40e/igSQi3ZMkRy595xQmQZ6YzU4NKr6IqQYmJYetFzRnQpptIg11BMqyS6R3Rli97xnEKc/s5WNW/jf5uL9XTTdQ/oSrBcmjxBwA1BYmkpvZvCl+gm5u8xE0flLzNslADrGZ6PVknx+u0PRj9G0nZA+v3k3phbibZihNLeDJirCQZtU2WEBU2R7676UpSB5/A+WMgDFHTe5v9eZ4szKd5VQKoKHmEHU6hjgpRincJAX/og=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFYwS2NoMXEwSlZjdW5qNi9HaVVZYmo3T3pqZnVaMmVGRDc4ZDJwNi9JbWNk?=
 =?utf-8?B?alJudVJkR2RDYzgvc3RNcVNRQU5RdkVUR2JMbXlUNUtsUjhaSUdRTlo5TVUz?=
 =?utf-8?B?eThkVGVleWRacW9UTVhPcU9NdEhKaFJGS0FESVVCM0RwSVo5ZG9TUTNGVHda?=
 =?utf-8?B?MWhpZlJUSFNkbGhaNHcwcGt3TGxrRloySjB3SUQ4bVIvM2dGZnJPckF3bzVU?=
 =?utf-8?B?VlFRQngzK3NIOTFaaXJGdEFoOHkrV1NOQXNDaDcvd1pMUGdyRzlmZkFSeFdE?=
 =?utf-8?B?Y1M3R0ZHcnVzU3ZHUVNaRjVRdW5TQkpjSUY3ZlBNN05SYStlZ2J5RHVYNzYy?=
 =?utf-8?B?RWt3MyttSTRSbXFXaG1hMmhBZUFMWDFoQUYrcEpyS3FHYkc5dTVJZWlvc1BN?=
 =?utf-8?B?cmFsWVdXNU9JL05NNVR6cE80dGpzeXY3MDJVSDI5SlJDTlV5Wm1VWFRBMVZm?=
 =?utf-8?B?T1cxMDNEYjJBWFdzc0dMcW5XUWxWdE9aVS9ocUg4SlpJOEh3cDltb3A4c0hS?=
 =?utf-8?B?bk13bHgrQ05vWmROQkg2aEFOQXA3YVJlQ1cvbGFqc0EyeDAyRGZMSmUyak5D?=
 =?utf-8?B?Ym1ka0I5ZGdNWDJieGxqdXlOOWp2NUpYRmZPaEJVelZnSUY1Z1RuY3ZVaHZz?=
 =?utf-8?B?a0dXVEFBY3BVSUhQejZ6MUhlaSs4ZmpHalNCZ3BubVNlR1RQNGlhL2hnaldv?=
 =?utf-8?B?bHdBK25lYmtBMkRQcTlDcm03STVObERkcFJKelNzY3JMMm52WEZRNWhUbGQv?=
 =?utf-8?B?aitQc2N2SU41dkJvZHpZVjFoTWUwbmRCZFhQSUhJajlDKzZ0UWdkS1JwQ3BC?=
 =?utf-8?B?KzMvTldPdzFXQVlMVFczWGtHdkUzd0ZsMzhiaHorSWdBekxVaVdwRmJjUERI?=
 =?utf-8?B?aGlRdGFUbEVzSGJCQTkyZXV5TWg3R2dHd1diaVN2SENtb2I2eGlZUlNvaXE5?=
 =?utf-8?B?VkZYb1FtWGVrcVh3WWJZS2FFdkVUWFNJc3V5K2g5SVJlOXdmeWxSR1k5VEpp?=
 =?utf-8?B?YUNMSXdTTEU1RGVnVVRUanh0VzVjNjd5SHJnd2YwK2NXRE9JazlvZUNkb0M5?=
 =?utf-8?B?VmVYbmVaVkxRRVRHQ1JmV0psYjUxS1VVbml0ODJ6N0VZUVRwY0pQUC9Jam9Q?=
 =?utf-8?B?U1A2eWFYTlFNcHlOL3RXOXZCNnF2ZG1sY25zN2JodXlyTE9XWGFUVW5pNFBm?=
 =?utf-8?B?alQ0L25EdWIxcmFxdXF0bUw3bVFJZGNMbU9tY2thaGhEUUV0Wm9aQ0tBcWY0?=
 =?utf-8?B?VmozT1hBNkZFaFIyOW5PdXg0STI3WE52aW5IcDdUYk1GYmh5TXZBbkRtdWJR?=
 =?utf-8?B?V0FjTXVUcE9lYlpEMFJZcC9HdjdJOFM5S1N0eUZxMm9SVVRpNFozUFZRdkxK?=
 =?utf-8?B?SmdaUTVhZDFGSzB4bFN2RVRRbzJwcHlVK2wzK0poQlo3MXZVVkZvblJ2MGpK?=
 =?utf-8?B?TWdXKzFvcUc2U3RRVkRGanorUWRKUnZDZVh2VjE4eE1Odkw2QjE3VStKeWJl?=
 =?utf-8?B?eEY5YVhmUTdpMnMyUElFWGV1c0F0OElHRDUzRG94OEtRY0hUK01XWE5FZG55?=
 =?utf-8?B?L0srUTAxT2xmeGt5S1RuTGtXSUJrR2JndjRwMUQ4aUtBN2FyK0hBcFc2Mzlq?=
 =?utf-8?B?aGtIWjVsenFzK1pVOUhwVGpGc29BdHdrNE1rOEN3Vk44MGJhZ3pSSlBiRURL?=
 =?utf-8?B?OXJsRnRldGduRVk4VDBIWXhTZVBCcHhPTkQyK2NLOGR4cHNQTlFybEtXRCtY?=
 =?utf-8?B?NnNQWGUwaFVPUVlwenNiWkFobmxsWWR5MzVxbmxuM0dQeEsxc0F5NERrR2V2?=
 =?utf-8?B?OGxjbkt5QkNwWGRpQVErL2ZnelREamVhZndMb0ZmSjhRZUhQNjV3L3BlRENY?=
 =?utf-8?B?WElQbi9WMThEajNwcHRPK3o3ZEtyUTNJSjRYYmRNTVBuNkw3VGNHYldtcENj?=
 =?utf-8?B?R29vY1hqWThzb2c0SUV4cTRTRWVNdjk5Q2VSWnQzZVBWbzU1MWVJT1BBRW1l?=
 =?utf-8?B?M0w5VFhUSWkyTW43blBVUzY3bTRXN3FlMkVkdWl6UldzcklWZ1RiV096eUxM?=
 =?utf-8?B?aExKblYvM2RhbEZ6RVZLKzVLeGhQcExidDlUVUtSM3gxcDRoeXRoWWtTSDBV?=
 =?utf-8?B?OHJhOXp4alVkQUJqOEdlTld1S2Q5ZTJrVFhWUjFxbW9xRkFRWWx6eDRkaW1j?=
 =?utf-8?B?ZVY5dWVKTGhKK2NxaUtrNmQzNTFodExBMHZtTHNFejhhSlgwOTNJSU1BLzBj?=
 =?utf-8?B?ZGpJM2MyV0tvV2R2MVVEYjZRaU9aeEhSN3d4Z1p4VnlOeDJIYjRhcld0bE1l?=
 =?utf-8?Q?gcDqkod6m2pQIZCw5o?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551ed96c-daf8-4e41-2564-08dea1d7bbde
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:01:47.4499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CapEifbWVppmLbbEWhd/ZiXhXRuuFiFvpnf83cxZHEot14exrUqiOw3mNycJFsGe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860
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
YWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDIzLCAyMDI2IDY6NDggUE0NCj4gVG86IExp
YW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IEtoYXRyaSwgU3VuaWwgPFN1bmlsLkto
YXRyaUBhbWQuY29tPg0KPiBDYzogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdA
YW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
MDQvMTFdIGRybS9hbWRncHU6IHJld29yayBhbWRncHVfdXNlcnFfc2lnbmFsX2lvY3RsDQo+DQo+
IEhpIGd1eXMsDQo+DQo+IE9uIDQvMjMvMjYgMTE6NTgsIExpYW5nLCBQcmlrZSB3cm90ZToNCj4g
Li4uDQo+ID4+IC1zdGF0aWMgaW50IGFtZGdwdV91c2VycV9mZW5jZV9hbGxvYyhzdHJ1Y3QgYW1k
Z3B1X3VzZXJxX2ZlbmNlDQo+ID4+ICoqdXNlcnFfZmVuY2UpDQo+ID4+ICtzdGF0aWMgaW50IGFt
ZGdwdV91c2VycV9mZW5jZV9hbGxvYyhzdHJ1Y3QgYW1kZ3B1X3VzZXJtb2RlX3F1ZXVlICp1c2Vy
cSwNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBhbWRncHVf
dXNlcnFfZmVuY2UgKipwZmVuY2UpDQo+ID4+ICB7DQo+ID4+IC0gICAgICp1c2VycV9mZW5jZSA9
IGttYWxsb2Moc2l6ZW9mKCoqdXNlcnFfZmVuY2UpLCBHRlBfQVRPTUlDKTsNCj4gPj4gLSAgICAg
cmV0dXJuICp1c2VycV9mZW5jZSA/IDAgOiAtRU5PTUVNOw0KPiA+PiArICAgICBzdHJ1Y3QgYW1k
Z3B1X3VzZXJxX2ZlbmNlX2RyaXZlciAqZmVuY2VfZHJ2ID0gdXNlcnEtPmZlbmNlX2RydjsNCj4g
Pj4gKyAgICAgc3RydWN0IGFtZGdwdV91c2VycV9mZW5jZSAqdXNlcnFfZmVuY2U7DQo+ID4+ICsg
ICAgIHVuc2lnbmVkIGxvbmcgY291bnQ7DQo+ID4gV2UgbXVzdCBpbml0aWFsaXplIGNvdW50OyBv
dGhlcndpc2UsIGl0IG1heSBjb250YWluIGEgZ2FyYmFnZSB2YWx1ZSwNCj4gPiB3aGljaCBjYW4g
Y2F1c2UgYW1kZ3B1X3VzZXJxX2ZlbmNlX2FsbG9jKCkgdG8gZmFpbCBhbmQsIGluIHR1cm4sIG1h
a2UgdXNlcnENCj4gZmVuY2UgZW1pc3Npb24gZmFpbC4NCj4NCj4gSSd2ZSBnb3QgdGhlIHNhbWUg
Y29tbWVudCBmcm9tIGJvdGggU3VuaWwgYW5kIFByaWtlIGJ1dCBhcyBmYXIgYXMgSSBjYW4gc2Vl
ICBhbmQNCj4gdGhhdCBpcyBhY3R1YWxseSBpbmNvcnJlY3QuDQpUaGlzIHBhdGNoIGJyZWFrcyB0
aGUgdXNlcnEgZmVuY2UgZW1pdCBwYXRoLCBjYXVzaW5nIGRlc2t0b3AgYm9vdCB0byBmYWlsLiBJ
bml0aWFsaXppbmcgY291bnQgb25seSB3b3JrcyBhcm91bmQgdGhlIGFtZGdwdV91c2VycV9mZW5j
ZV9hbGxvYygpIGZhaWx1cmUsIGFuZCBpdCBkb2Vzbid0IGFkZHJlc3MgdGhlIHJvb3QgY2F1c2Us
IHdoaWNoIGlzIHRoYXQgeGFfZmluZCgpIGNhbm5vdCBpbml0aWFsaXplIGNvdW50IHdoZW4gZmVu
Y2VfZHJ2X3hhIGl0c2VsZiBoYXNuJ3QgYmVlbiBzZXQgdXAgeWV0LiBJbnN0ZWFkIG9mIGp1c3Qg
aW5pdGlhbGl6aW5nIGNvdW50LCB3ZSBtYXkgbmVlZCB0byBjaGVjayB0aGUgcmV0dXJuIHZhbHVl
IG9mIHhhX2ZpbmQoKSwgYW5kIGlmIG5vIHdhaXQgZmVuY2VzIGFyZSBwZW5kaW5nLCBza2lwIHJl
dHJpZXZpbmcgdGhlIHdhaXQgZmVuY2UgYXJyYXkgZW50aXJlbHkuDQoNCj4gPg0KPiA+PiArICAg
ICB1c2VycV9mZW5jZSA9IGttYWxsb2Moc2l6ZW9mKCp1c2VycV9mZW5jZSksIEdGUF9LRVJORUwp
Ow0KPiA+PiArICAgICBpZiAoIXVzZXJxX2ZlbmNlKQ0KPiA+PiArICAgICAgICAgICAgIHJldHVy
biAtRU5PTUVNOw0KPiA+PiArDQo+ID4+ICsgICAgIC8qDQo+ID4+ICsgICAgICAqIEdldCB0aGUg
bmV4dCB1bnVzZWQgZW50cnksIHNpbmNlIHdlIGZpbGwgZnJvbSB0aGUgc3RhcnQgdGhpcyBjYW4g
YmUNCj4gPj4gKyAgICAgICogdXNlZCBhcyBzaXplIHRvIGFsbG9jYXRlIHRoZSBhcnJheS4NCj4g
Pj4gKyAgICAgICovDQo+ID4+ICsgICAgIG11dGV4X2xvY2soJnVzZXJxLT5mZW5jZV9kcnZfbG9j
ayk7DQo+ID4+ICsgICAgIHhhX2ZpbmQoJnVzZXJxLT5mZW5jZV9kcnZfeGEsICZjb3VudCwgVUxP
TkdfTUFYLCBYQV9GUkVFX01BUkspOw0KPg0KPiBUaGUgY291bnQgc2hvdWxkIGJlIGluaXRpYWxp
emVkIGhlcmUuIEJ1dCBjb3VsZCBiZSB0aGF0IHRoaXMgZG9lc24ndCB3b3JrLg0KPg0KPiBEaWQg
eW91IGd1eXMgZ290IGEgS0FTQU4gd2FybmluZyBvciBzb21ldGhpbmcgbGlrZSB0aGF0Pw0KSSBk
aWRuJ3Qgc2VlIHRoZSBLQVNBTiB3YXJuaW5nLiBIb3dldmVyLCB0aGUgdW5kZXJseWluZyBwcm9i
bGVtIGlzIHRoYXQgd2hlbiBmZW5jZV9kcnZfeGEgaGFzbid0IGJlZW4gc2V0IHVwLCBjb3VudCBy
ZW1haW5zIHVuaW5pdGlhbGl6ZWQgKGdhcmJhZ2UpLCB3aGljaCBldmVudHVhbGx5IGNhdXNlcyBr
dm1hbGxvY19hcnJheSgpIHRvIGZhaWwgd2hlbiBhbGxvY2F0aW5nIGZlbmNlX2Rydl9hcnJheS4N
Cg0KPiA+PiArDQo+ID4+ICsgICAgIHVzZXJxX2ZlbmNlLT5mZW5jZV9kcnZfYXJyYXkgPSBrdm1h
bGxvY19hcnJheShjb3VudCwgc2l6ZW9mKGZlbmNlX2RydiksDQo+ID4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBHRlBfS0VSTkVMKTsNCj4gPj4g
KyAgICAgaWYgKCF1c2VycV9mZW5jZS0+ZmVuY2VfZHJ2X2FycmF5KSB7DQo+ID4+ICsgICAgICAg
ICAgICAgbXV0ZXhfdW5sb2NrKCZ1c2VycS0+ZmVuY2VfZHJ2X2xvY2spOw0KPiA+PiArICAgICAg
ICAgICAgIGtmcmVlKHVzZXJxX2ZlbmNlKTsNCj4gPj4gKyAgICAgICAgICAgICByZXR1cm4gLUVO
T01FTTsNCj4gPj4gKyAgICAgfQ0KPiA+PiArDQo+ID4+ICsgICAgIHVzZXJxX2ZlbmNlLT5mZW5j
ZV9kcnZfYXJyYXlfY291bnQgPSBjb3VudDsNCj4gPj4gKyAgICAgeGFfZXh0cmFjdCgmdXNlcnEt
PmZlbmNlX2Rydl94YSwgKHZvaWQgKiopdXNlcnFfZmVuY2UtPmZlbmNlX2Rydl9hcnJheSwNCj4g
Pj4gKyAgICAgICAgICAgICAgICAwLCBVTE9OR19NQVgsIGNvdW50LCBYQV9QUkVTRU5UKTsNCj4g
PiBXZSBtYXkgbmVlZCB0byBhc3NpZ24gdGhlIHVzZXJxX2ZlbmNlLT5mZW5jZV9kcnZfYXJyYXlf
Y291bnQgdGhlIGV4YWN0IGNvcGllZA0KPiBudW1iZXIgZnJvbSB0aGUgeGFfZXh0cmFjdCgpLg0K
Pg0KPiBJbnRlcnJlc3RpbmcgcG9pbnQuIFdoeSBjb3VsZCB0aGF0IGRpZmZlciA/DQpHZW5lcmFs
bHksIHhhX2V4dHJhY3QoKSBzaG91bGQgcmV0dXJuIHRoZSBzYW1lIG51bWJlciBhcyBjb3VudCwg
YnV0IHdoZW4gdGhlcmUncyBhIHJldHJ5IGVudHJ5LCB0aGUgYWN0dWFsIG51bWJlciBvZiBjb3Bp
ZWQgZW50cmllcyBtYXkgZGlmZmVyIGZyb20gdGhlIHdhaXQgZmVuY2UgYXJyYXkgY2FwYWNpdHkg
aW5kaWNhdGVkIGJ5IGNvdW50Lg0KDQo+IFRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzLA0KPiBDaHJp
c3RpYW4uDQo=
