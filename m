Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC872C5B572
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 17:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D01010E8CF;
	Mon, 17 Aug 2026 17:55:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="myXXvO+s";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D27AA10E8CF
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 17:55:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=at+v+xyhhiwNQ0I/toIm4h91Lq/tRBGOv79E2qjk4YHoZGdLsANaj+ivkzURBYoi/CJL2lsqk316QhGCpjQqp2K6ICx5vgMixvcvBte5BtiAnU72aA1QNS0WcGt8aQLbKxYOBD584qOYOQTCpY2kKbMGMZYrIrApMy/iW//zoIKVGI1h1WJ0LQnxdvUkjyehjd/Tgs8iG+8wjBW9apRmEDhT6u7q/0vie0Nxejr5qI94RKYc1ig68NH5M8gYMTOeJcdPuvfdFYPQukONW9I8jqjl54i8kwAPLN9b96dbyXzTawJBFcF1qP2MWWVdyDjx8UceVlCnDrzD2hU+5dDuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDY/3+v6F0b6jADNRbmg/cKkE7s5yuvdhjPrsUtrYb0=;
 b=lOU5vuLQnl6fpgYe9ey1ICs+myy/HapmheUeg1qhvg6jCfRS9+mAldr9OiSkTOtQOJm2QL7zdImu9dzIPEfnhMGTdXzo9EpWWjertwAh6Yd6FS4oCxi3tyEqNs2BL4abGsP/ITOqW4ZHlPeRrewyhQwHp1clt7nokQv6oBax68+M+Cs8uab8qfjo5oWK1nMdikp4I37Fdz/0+fdNojLTQGcsxFZkIOubUB+E3NUvEUOvj/k/oiUdIA8fiVy2rYK3cXUO1f7gtvZxjf6k/3rT2RiZskYV/IyaT192VPsFnQ+XjB6DEUD6pRxP5YhKEL/tZhnQ3GgamYKZ2uKVZCxLSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDY/3+v6F0b6jADNRbmg/cKkE7s5yuvdhjPrsUtrYb0=;
 b=myXXvO+swNgiyvyFusCOVWWYDz5LWvu13kljmWMs/YFmwEBUmHtIaUs6iWBcb780B/Hn2prd3MdbtMW9ptaIkqO+3T6N/oEDn7WYsmK6hAruaI0au73/YByweyNgMzWsqJ6VN8RPTDvgGD/KBkh2ii9KfU1dluwuOFjdUd1dbFc=
Received: from BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 by CH3PR12MB9100.namprd12.prod.outlook.com (2603:10b6:610:1a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 17:55:45 +0000
Received: from BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a]) by BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 17:55:45 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix smu messages after system resume for smu
 11.0.x
Thread-Topic: [PATCH] drm/amd/pm: fix smu messages after system resume for smu
 11.0.x
Thread-Index: AQHdLhGJgKJ/Kve6N0muyU09lzooWLaiO/WAgAAwYIA=
Date: Mon, 17 Aug 2026 17:55:44 +0000
Message-ID: <BN9PR12MB5211B34822FC23B79CE2C5EE82A72@BN9PR12MB5211.namprd12.prod.outlook.com>
References: <20260817062728.2535467-1-kevinyang.wang@amd.com>
 <CADnq5_PhiEzW7eA311hSyCo=ve1Bx2dBUEf3LArLbPTK2s==Ww@mail.gmail.com>
In-Reply-To: <CADnq5_PhiEzW7eA311hSyCo=ve1Bx2dBUEf3LArLbPTK2s==Ww@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-17T16:19:53.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5211:EE_|CH3PR12MB9100:EE_
x-ms-office365-filtering-correlation-id: 4da2453a-5c32-4add-fbd2-08defc88c291
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|6133799003|38070700021|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: L2Yy5XscOvGdYNTxWkKbwuDunGvWvYgjUmII4HVQPXVdzn/aiUHQmnRI2RdQaNA9oysoc1rL7HZoG9GyipzpeJthcJRY3kJUyLLLpd7ZkYEJL6lN/KYrpkqYU6fN7h4hwdTNeVrW6O86IS/yVpqw0oziG4VCq1RkcrYm81Tb/7StbwmC0ya5/0xYVX4KXDINKMdA+j3T/jqqz56oTPI8IPMb098UHmGShr49/GZHKVF+w1PG0mUQTb/Tdq2L6a4uSodSBMX3nAUfIw+tGmQBg82Iu5vlRx+dXVw+4DjUAbz/BTgdMF69N7+Sf3YwgLNyuuVtLybgPpWKE6rRCYiUiSFlea89YalVzoo9jHJ0wNyU67mTwViNQhvZJvrO1qAGLdrmdzkGLg9Gl1XdXV46snaO4KMZZ/BzEdFYbT8tFzXh3cCGmCkU5jp7x/9jEZq7kmXHQ2oJ2StZsdw7MiKwaK/U6x05Fj2o44C7EJE74ftMtWM0onmgzdFjxESGiV7C9P8dXt20h0KnRpfGXlG5WSvMl6f+Zt3lRdw5pLVeoImN1QVSCwJ6+rXRlREN3zd42IsmShdATWG20xlog/Y3h4YVwDPpPkSeMiUGHv0wAe8uQuQGm2Qm4QBxwo4JNF/jhB8lUmIGUuvZav1RWoHEinjHGILgV7kD26MQUS+wl7k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5211.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(6133799003)(38070700021)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aCtjRFY4K2x1NXpLdzk1MUFJM09LTldMcEdEMzN2M2ZodnJ2Unc1Rjd3SWQ5?=
 =?utf-8?B?NGp0MWplRVBvTkZTN1pkVGQyZ094aTArNEhJMlZUZWFPVURZdXZCdlRHTkJN?=
 =?utf-8?B?NzJnUVFkbXhIVktoV2k0TW12Q05oS0dFKzk1MERSelJUL2RMdy9FMWpybTE2?=
 =?utf-8?B?UlpSOVdRbnFsL0Y3NVRwNmRGb0dIYjRBeVJaaTNPUUtLWllSR3dIOWdMQitV?=
 =?utf-8?B?dU5wTUY1ZitqTUZPM1RXZ0VUQ0lNOElwMlBhNmRCWlhzTUhIQWtIKzVxcXM4?=
 =?utf-8?B?UzQzTkd1cy9SVjZLeEJXL3ZrdUtWc0V0cDBzd05lWlJQck51SDJVVXkzWXlU?=
 =?utf-8?B?Z0wwVjNnZkFXSlN0Tm5yWTJycllQTTJVUXZkaEJ2VnUzdVJQbUhlbzUwVzVx?=
 =?utf-8?B?L09YYzFQdUgrNDF4S1dlSm4wZmkwZkFJeG9hZktsYVhuNUhsVjQ1LzhyUGVJ?=
 =?utf-8?B?b08ySFhlc0FXdGwvUGljNUdvcXVUZGN3b3RBQzJMZWtaZkRiRmNLUS94b0FH?=
 =?utf-8?B?NlZKOXBBSURLVDQySkZ2TUFlZnE3c2ZWeGJDZUsxODBRdDRXcHpVRnoyaHBq?=
 =?utf-8?B?MHVxa1llOEZtRU9MeUNUMFAvTFc2c3k1L3JNMmk2RVZ5M05NWnRsdU4xaGxX?=
 =?utf-8?B?WUswM0Jacnlnc2dVdDZEQWJNak93UXYrMDErTTd0U0k2THYxYW9nUXRXa3dh?=
 =?utf-8?B?Y1BrT2Z4cUdwZlRWQnMxc1k1akJpNGZkNWFCaGlzTkhBbGx4bVl3YS92cExX?=
 =?utf-8?B?S28xM3l5NFVhcnJ1K1JQeENQMGd6bHMvWjVXVFY5S29aSEdFRWxjQTU5N1dL?=
 =?utf-8?B?ZGxVSm5tcnlxbm12TXhDQzB6UzJhWTA1MFhKekN4KzJzTTNCanlHWEJ4UzQ0?=
 =?utf-8?B?RTdkNEk1ZXNPeDVqcW1UK2lYQURSbnlucmNlN0FORVFEc2ZkMDg5bGlJRmQy?=
 =?utf-8?B?MXVCTDQxMUl2djNqUWM0eDBueVRsRFpyaVE0TXN5NjRBaG1Zdk5hcjB3VkxD?=
 =?utf-8?B?SXJrR1hvNjNSR1hraERoemViaDVyN2xuc3NiOUVYcGpFOXZhb0FZV3l2aXRU?=
 =?utf-8?B?V2xNcFBLdWNSa2VCWS9YcmJrYnBKOGdEWHVjbkRZMWlVanpLZkx6eDZGZ0FL?=
 =?utf-8?B?dHRMM01ZVmtUYVRSYkJ4YkRGZlI3RDFCc3huOGZXamtQYk9nRkx3L0dTV2tM?=
 =?utf-8?B?YXpBcGh3dGVxalREKzBQeTZ1bnU4R2syVWpZZDFSNGdBdGtoYkhZaGlKOGNO?=
 =?utf-8?B?eVlJcS83SUVUOXh5ekZNUlhoaHFmK2NIY1RMR2t0ZHFCMW5QSzFjUEVFS2I3?=
 =?utf-8?B?cFdKeC9oN2grY2FOTkg1OXVUNExuMnAxSjI4cVprMlhCaTJnVU9QK2l2aFVF?=
 =?utf-8?B?TVhabUxIeU1PaWtaMlNpeVR1NWQ1cDl3b21rOFkxYU82cUo4enVxczMzQm9T?=
 =?utf-8?B?WTFkQ2UvbVVWTGN0THpQUFZQZzNPMzRFYUdpN3JFd2pXQXpmYW9XR3ZuVjhk?=
 =?utf-8?B?a2U1aDJiajIzT25LUmlhNHZ6V3FIMWNBUHpLMFZ6TVYxM01HN2ZselNYWkhM?=
 =?utf-8?B?bWFScGxBY1lzbDJ4alN6cnFQdENCVWNsTlRlMzZNRGUwOGg2MU5SSFJ3YWVS?=
 =?utf-8?B?b2IrYXVyelVBaExrOUxHNWRiMUNYMlBwajlMZDNTUytzUWZ1dmQ5Wi9Daytu?=
 =?utf-8?B?R3AzOGhVVkQxeWpzTzZic3RqWVlaVmJKamhxdDlFRy8vdjVHR0d1enM0TDlY?=
 =?utf-8?B?YmU5YzcrNGxCNit1Q0NyaGwxYUwwa09Vazg2ZFBqQTh3UjdueEdNRm1qNE9a?=
 =?utf-8?B?ZEFhNFhTL0ZtRHpFZkd6UVJkbzE3eGQ5SnczUnBxVHovZERvKzl6RkdDL0Jr?=
 =?utf-8?B?ay9tTk9GMElDam9XTzgyYVpCWlpaYnlnVUdPV1U1cW5vS3dYV2NUYzBwc0wz?=
 =?utf-8?B?WlZUb3lpWXFVYXlYeWovSnAvRFlXZXNTcnRJUmVONm9hSlFlblAxOGFmSDhM?=
 =?utf-8?B?MlVxVHRHYjBYYXp3cXk4QzVPK0FTaE9jUjEzZERMbWpLaFdXYVBwNng4bXVu?=
 =?utf-8?B?RGVpckM2S08xV3lwUmZpZTZ6ZXRDQjl4MTB3eFFtU2p6R2VoZkNxTkpVK1Jo?=
 =?utf-8?B?RVpELzY1b0hUVDlMMkNOcm56NTdMa1hmK0x6WWUrQmZ3d2dqYlpINVcwMHRo?=
 =?utf-8?B?ZGE3SnJ5cGhMTGIvcEk4UE9ubEhSN3BzNGpCb1cxaG9lck45SWx6eVNkT3gv?=
 =?utf-8?B?K1U5MkxFeFk4MVN6eC9DY2ZRcEI3WGxiWCtQekRLbURYeVd2SVlORm1TRTkz?=
 =?utf-8?Q?/SrtdYb9zhpZzwWl0k?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5211.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da2453a-5c32-4add-fbd2-08defc88c291
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 17:55:44.3202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTi5xiVgsLaAC22p+plpZ8EzNt/0lAWaqY92JFdAN5hyo/yxqCLik1NuCwnG9Ahn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9100
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4
IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBBdWd1c3Qg
MTcsIDIwMjYgOToyNyBQTQ0KPiBUbzogV2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5XYW5n
QGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwg
QWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcN
Cj4gPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IEZlbmcsIEtlbm5ldGggPEtlbm5ldGguRmVuZ0Bh
bWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL3BtOiBmaXggc211IG1lc3Nh
Z2VzIGFmdGVyIHN5c3RlbSByZXN1bWUgZm9yDQo+IHNtdSAxMS4wLngNCj4NCj4gT24gTW9uLCBB
dWcgMTcsIDIwMjYgYXQgMzo0NeKAr0FNIFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNv
bT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBTTVUgMTEuMC54IGNhbiByZXRhaW4gYW4gdW5maW5pc2hl
ZCBjb21tYW5kIGFjcm9zcyBzeXN0ZW0gc3VzcGVuZCwNCj4gPiBjYXVzaW5nIFNNVSBtZXNzYWdl
cyBzdWNoIGFzIFJ1bkRjQnRjIHRvIGZhaWwgZHVyaW5nIHJlc3VtZS4NCj4gPg0KPiA+IFByZXBh
cmUgTVAxIGZvciB1bmxvYWQgZHVyaW5nIHN5c3RlbSBzdXNwZW5kIGFuZCByZWNvcmQgc3VjY2Vz
c2Z1bA0KPiA+IGNvbXBsZXRpb24sIHJlbG9hZCBTTUMgZmlybXdhcmUgYWZ0ZXIgUFNQIHJlc3Rh
cnQgYmVmb3JlIHJlc3VtZSBzZW5kcw0KPiA+IGZ1cnRoZXIgU01VIG1lc3NhZ2VzLCB0aGVuIGNs
ZWFyIHRoZSByZWxvYWQgc3RhdGUuDQo+DQo+IEFja2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+DQo+DQo+IElzIHRoZXJlIGFueSByZWFzb24gbm90IHRvIGRv
IG1wMSB1bmxvYWQgZm9yIGFsbCBkR1BVcyBpbiB0aGlzIGNhc2U/DQoNCk5vLCB0aGUgdW5sb2Fk
IG1lc3NhZ2UgaXMgcmVxdWlyZWQuIFdpdGhvdXQgaXQsIHRoZSBkZXZpY2Ugd2lsbCByZW1haW4g
aW4gYSBoaWdo4oCRcG93ZXIgc3RhdGUuDQpBbHNvLCB0aGUgY3VycmVudCBzb2x1dGlvbiB0cmln
Z2VycyBhIHBvc3QtdG1yIHBtZncgcmVsb2FkLCBhbmQgdGhpcyBzdGVwIGlzIG5lY2Vzc2FyeSBm
b3IgdGhpcyBpc3N1ZSwgYnV0IHRoaXMgYmVoYXZpb3IgZGlmZmVycyBmcm9tIG90aGVyIEFTSUNz
LA0Kc28sIEknbSB0cnlpbmcgdG8gcmV3b3JrIHRoaXMgZml4IGlmIGEgYmV0dGVyIGFwcHJvYWNo
IGJlY29tZXMgYXZhaWxhYmxlLg0KDQpCZXN0IFJlZ2FyZHMsDQpLZXZpbg0KPg0KPiA+DQo+ID4g
Q2xvc2VzOiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL3dvcmtfaXRl
bXMvNTYyMA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWWFuZyBXYW5nIDxrZXZpbnlhbmcud2Fu
Z0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcHNwLmMgICB8ICA5ICsrKystLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcHNwLmggICB8ICAyICsrDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
YW1kZ3B1X3NtdS5jIHwgMzgNCj4gPiArKysrKysrKysrKysrKysrKysrKy0tLQ0KPiA+ICAzIGZp
bGVzIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQo+ID4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCj4gPiBpbmRleCAwNGY2
ZWJmMzFjY2EuLjVjMDA2ODNjMWVkZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcHNwLmMNCj4gPiBAQCAtMzUxMiwxMSArMzUxMiwxNiBAQCBzdGF0aWMgaW50
IHBzcF9sb2FkX25vbl9wc3BfZncoc3RydWN0DQo+IHBzcF9jb250ZXh0ICpwc3ApDQo+ID4gICAg
ICAgICBzdHJ1Y3QgYW1kZ3B1X2Zpcm13YXJlX2luZm8gKnVjb2RlOw0KPiA+ICAgICAgICAgc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBwc3AtPmFkZXY7DQo+ID4NCj4gPiAtICAgICAgIGlm
IChwc3AtPmF1dG9sb2FkX3N1cHBvcnRlZCAmJg0KPiA+IC0gICAgICAgICAgICFwc3AtPnBtZndf
Y2VudHJhbGl6ZWRfY3N0YXRlX21hbmFnZW1lbnQpIHsNCj4gPiArICAgICAgIGlmIChwc3AtPnNt
dV9md19uZWVkc19yZWxvYWQgfHwNCj4gPiArICAgICAgICAgICAocHNwLT5hdXRvbG9hZF9zdXBw
b3J0ZWQgJiYNCj4gPiArICAgICAgICAgICAgIXBzcC0+cG1md19jZW50cmFsaXplZF9jc3RhdGVf
bWFuYWdlbWVudCkpIHsNCj4gPiArICAgICAgICAgICAgICAgaWYgKHBzcC0+c211X2Z3X25lZWRz
X3JlbG9hZCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBkZXZfZGJnKGFkZXYtPmRldiwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJSZWxvYWRpbmcgU01VIGZpcm13
YXJlIGFmdGVyIE1QMQ0KPiA+ICsgdW5sb2FkXG4iKTsNCj4gPiAgICAgICAgICAgICAgICAgcmV0
ID0gcHNwX2xvYWRfc211X2Z3KHBzcCk7DQo+ID4gICAgICAgICAgICAgICAgIGlmIChyZXQpDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiArICAgICAgICAgICAg
ICAgcHNwLT5zbXVfZndfbmVlZHNfcmVsb2FkID0gZmFsc2U7DQo+ID4gICAgICAgICB9DQo+ID4N
Cj4gPiAgICAgICAgIC8qIExvYWQgUDJTIHRhYmxlIGZpcnN0IGlmIGl0J3MgYXZhaWxhYmxlICov
IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3Au
aA0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5oDQo+ID4gaW5k
ZXggZDgwYzg1NzkzZTNiLi4yMDMzOGNhYTQ5MjEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5oDQo+ID4gQEAgLTQ0Myw2ICs0NDMsOCBAQCBzdHJ1Y3Qg
cHNwX2NvbnRleHQgew0KPiA+ICAgICAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBib290X3RpbWVfdG1yOw0KPiA+ICAgICAgICAgLyogZmxhZyB0byBtYXJrIHdoZXRoZXIgZGYg
Y3N0YXRlIG1hbmFnZW1lbnQgY2VudHJhbGl6ZWQgdG8gUE1GVyAqLw0KPiA+ICAgICAgICAgYm9v
bCAgICAgICAgICAgICAgICAgICAgICAgICAgICBwbWZ3X2NlbnRyYWxpemVkX2NzdGF0ZV9tYW5h
Z2VtZW50Ow0KPiA+ICsgICAgICAgLyogU01DIGZpcm13YXJlIHJlbG9hZCByZXF1aXJlZCBkdXJp
bmcgcmVzdW1lICovDQo+ID4gKyAgICAgICBib29sICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNtdV9md19uZWVkc19yZWxvYWQ7DQo+ID4NCj4gPiAgICAgICAgIC8qIHhnbWkgdGEgZmlybXdh
cmUgYW5kIGJ1ZmZlciAqLw0KPiA+ICAgICAgICAgY29uc3Qgc3RydWN0IGZpcm13YXJlICAgICAg
ICAgICAqdGFfZnc7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dz
bXUvYW1kZ3B1X3NtdS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdw
dV9zbXUuYw0KPiA+IGluZGV4IDU1OWFmZGM1ODE1ZC4uOGQ0OTlkOWE4NmRmIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jDQo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMNCj4gPiBAQCAtMjE4
MiwxMiArMjE4MiwzNiBAQCBzdGF0aWMgaW50IHNtdV9zbWNfaHdfY2xlYW51cChzdHJ1Y3QNCj4g
PiBzbXVfY29udGV4dCAqc211KSAgc3RhdGljIGludCBzbXVfcmVzZXRfbXAxX3N0YXRlKHN0cnVj
dCBzbXVfY29udGV4dA0KPiA+ICpzbXUpICB7DQo+ID4gICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiA9IHNtdS0+YWRldjsNCj4gPiAtICAgICAgIGludCByZXQgPSAwOw0KPiA+ICsg
ICAgICAgdTMyIG1wMV92ZXJzaW9uID0gYW1kZ3B1X2lwX3ZlcnNpb24oYWRldiwgTVAxX0hXSVAs
IDApOw0KPiA+ICsgICAgICAgYm9vbCBuZWVkc19tcDFfdW5sb2FkOw0KPiA+ICsgICAgICAgaW50
IHJldDsNCj4gPg0KPiA+IC0gICAgICAgaWYgKCghYWRldi0+aW5fcnVucG0pICYmICghYWRldi0+
aW5fc3VzcGVuZCkgJiYNCj4gPiAtICAgICAgICAgICAgICAgKCFhbWRncHVfaW5fcmVzZXQoYWRl
dikpICYmICFzbXUtPmlzX2FwdSAmJg0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGFtZGdw
dV9pcF92ZXJzaW9uKGFkZXYsIE1QMV9IV0lQLCAwKSA+PSBJUF9WRVJTSU9OKDEzLCAwLA0KPiAw
KSkNCj4gPiAtICAgICAgICAgICAgICAgcmV0ID0gc211X3NldF9tcDFfc3RhdGUoc211LCBQUF9N
UDFfU1RBVEVfVU5MT0FEKTsNCj4gPiArICAgICAgIGlmIChhZGV2LT5pbl9ydW5wbSB8fCBhbWRn
cHVfaW5fcmVzZXQoYWRldikgfHwgc211LT5pc19hcHUpDQo+ID4gKyAgICAgICAgICAgICAgIHJl
dHVybiAwOw0KPiA+ICsNCj4gPiArICAgICAgIHN3aXRjaCAobXAxX3ZlcnNpb24pIHsNCj4gPiAr
ICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMSwgMCwgNyk6DQo+ID4gKyAgICAgICBjYXNlIElQX1ZF
UlNJT04oMTEsIDAsIDExKToNCj4gPiArICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMSwgMCwgMTIp
Og0KPiA+ICsgICAgICAgY2FzZSBJUF9WRVJTSU9OKDExLCAwLCAxMyk6DQo+ID4gKyAgICAgICAg
ICAgICAgIC8qDQo+ID4gKyAgICAgICAgICAgICAgICAqIFRoZXNlIFNNVSB2ZXJzaW9ucyByZXF1
aXJlIE1QMSB1bmxvYWQgYmVmb3JlIHN5c3RlbQ0KPiBzdXNwZW5kLg0KPiA+ICsgICAgICAgICAg
ICAgICAgKiBUaGUgc2h1dGRvd24gcGF0aCBhbHJlYWR5IHJlcXVlc3RzIGl0IHRocm91Z2ggbXAx
X3N0YXRlLg0KPiA+ICsgICAgICAgICAgICAgICAgKi8NCj4gPiArICAgICAgICAgICAgICAgbmVl
ZHNfbXAxX3VubG9hZCA9IGFkZXYtPm1wMV9zdGF0ZSAhPQ0KPiBQUF9NUDFfU1RBVEVfVU5MT0FE
Ow0KPiA+ICsgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgIGRlZmF1bHQ6DQo+ID4g
KyAgICAgICAgICAgICAgIG5lZWRzX21wMV91bmxvYWQgPSAhYWRldi0+aW5fc3VzcGVuZCAmJg0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIG1wMV92ZXJzaW9uID49IElQX1ZFUlNJT04oMTMs
IDAsIDApOw0KPiA+ICsgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgIH0NCj4gPiAr
DQo+ID4gKyAgICAgICBpZiAoIW5lZWRzX21wMV91bmxvYWQpDQo+ID4gKyAgICAgICAgICAgICAg
IHJldHVybiAwOw0KPiA+ICsNCj4gPiArICAgICAgIHJldCA9IHNtdV9zZXRfbXAxX3N0YXRlKHNt
dSwgUFBfTVAxX1NUQVRFX1VOTE9BRCk7DQo+ID4gKyAgICAgICBpZiAoIXJldCAmJiBhZGV2LT5p
bl9zdXNwZW5kKQ0KPiA+ICsgICAgICAgICAgICAgICBhZGV2LT5wc3Auc211X2Z3X25lZWRzX3Jl
bG9hZCA9IHRydWU7DQo+ID4NCj4gPiAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gIH0NCj4gPiBA
QCAtMjI3OSw2ICsyMzAzLDEwIEBAIHN0YXRpYyBpbnQgc211X3N1c3BlbmQoc3RydWN0IGFtZGdw
dV9pcF9ibG9jaw0KPiAqaXBfYmxvY2spDQo+ID4gICAgICAgICBpZiAocmV0KQ0KPiA+ICAgICAg
ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+DQo+ID4gKyAgICAgICByZXQgPSBzbXVfcmVzZXRf
bXAxX3N0YXRlKHNtdSk7DQo+ID4gKyAgICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAg
ICByZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiAgICAgICAgIHNtdS0+d2F0ZXJtYXJrc19iaXRtYXAg
Jj0gfihXQVRFUk1BUktTX0xPQURFRCk7DQo+ID4NCj4gPiAgICAgICAgIHNtdV9zZXRfZ2Z4X2Nn
cGcoc211LCBmYWxzZSk7DQo+ID4gLS0NCj4gPiAyLjU0LjANCj4gPg0K
