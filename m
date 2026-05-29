Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8164CD6E49
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 18:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FC8311239C;
	Fri, 29 May 2026 18:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JEkuL+OA";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B63211239C
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 18:12:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZJGO/ovxflmvLsLaE8nkPGQTGOLqgSD5gmMtVA+sblha9ckAfYcjwrqaiKMu4OkzDPSKk+O0y/VDCyS0vH0E5mH39yYOB+9WI7nFgRH9fzMC7wUzI+Lu7WC/UBobJrmu9Vdl1QvhqmoRh43frulyOY8hw6gnoqHW5ChNknSwYM5c9IHiexjz4KTt7EHevacSS89ZlABQJpP4pXUbXAkaCDcV7eoN7wxNNqttGGYa/Gl9Iq3Uucykq5gDuSIn8zKonZDxvGJx5GaL27y49iZ6HRfgwVBJnVcKcWmSdccdmqD8ySpVCsc/JFTrppY8D66P2WDu7uUOsGEMLhQP+YgGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFDWgvWV70rRQeCdCCrkaqgEoWFZUQN6GjoNMuD/a5U=;
 b=F732jnUrQ/VQu6N/K6mayw84TbmGHyPQ0obpRByRMQ/fVD2vDswg0Y5vZP23jMmy9ENjafa5m739zLL/vm4hQprp69Rr/p3ljSb3WdJnkucrla6LDP/WTWjJ66v02AVbS4Up9dTHw5xDliXH74jkM2vT7xhHjzMXbq9OXeNKjpS1GrUck9S8n/LdpzSm0+BIgKTNoOZbA9m0ljnmc4hkvqC2aAP05dBsMuZVdhRWxau0lNc7gjE12+yQ+rk3X+YBoTCPro7RfwkgyJbx52CjQDuOISE2A8lN+d+gDWDuxP8AAinBPGl5qXFPRmOMmI59wSmPXCq010K5ieM8E26lhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFDWgvWV70rRQeCdCCrkaqgEoWFZUQN6GjoNMuD/a5U=;
 b=JEkuL+OAVoh5QKzywGiFp+NENcGu61dTf9eRQFdvkVNKy8wWFIuZH2T/h+V4Es0PX5AJAdYq8xoIJa4jdl3vjmnwThu2btmfdcOUyyskTTcgP3/17JZddT73cQUvexZLSEg2KJTto2X9vJFmj1ItPzQFOwS/IQrGb+KL1yIRjaE=
Received: from DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 18:12:05 +0000
Received: from DS0PR12MB7536.namprd12.prod.outlook.com
 ([fe80::6a2c:d797:8fa4:72ce]) by DS0PR12MB7536.namprd12.prod.outlook.com
 ([fe80::6a2c:d797:8fa4:72ce%3]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 18:12:05 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v1] drm/amdkfd: Fix buffer overflow in SDMA queue
 checkpoint/restore on GFX11
Thread-Topic: [PATCH v1] drm/amdkfd: Fix buffer overflow in SDMA queue
 checkpoint/restore on GFX11
Thread-Index: AQHc7sYthKTfrX4MA0iMQXMyAGGCOLYjzHOAgAGCsvA=
Date: Fri, 29 May 2026 18:12:05 +0000
Message-ID: <DS0PR12MB7536C28EB15A90F180933D30F5162@DS0PR12MB7536.namprd12.prod.outlook.com>
References: <20260528171917.45575-1-andrew.martin@amd.com>
 <CADnq5_NOfe=bc0dsekVT0pC0oCm-cLUODJ8mxLSWHnUNb7JQ0A@mail.gmail.com>
In-Reply-To: <CADnq5_NOfe=bc0dsekVT0pC0oCm-cLUODJ8mxLSWHnUNb7JQ0A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: alexdeucher@gmail.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T18:09:53.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7536:EE_|MN0PR12MB6272:EE_
x-ms-office365-filtering-correlation-id: 36e591a8-c376-4850-f3b7-08debdadca69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|11063799006|4143699003|56012099006|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: IMOf5sC9aUvHWV2tKqvyDlY2KVk7B2vR38gH1XHuGZ8F+BmwcPBdYRGUdMqByXEe6HHbFJDc5gLJOfrXs7HKvQnW3iXYpZigpz/kogfGGP1oOC1o2cb+j7Vc7kKWJaEDchg3F3z/8geBp5owWedySVrMd2sdmotyKaiOSiwKIhQl0WCvEcFWQKAtIN36iPMkZk4HSUuabxLCxD+5UfxOkMr5BJ0NnkNdNfLx6lQ1E1u8ZyEkpC4SYILhGgXE2vV6L0ZkH7pSesPVXOaZnN4ShrXOtnL/iCSXU8Hdvw1mPqFOjazh0qnNZz6eeBjhdey4F5fCVir7Wscy2CjS76fwXM8LcUr+fxS3eTbEIDXaV0WBTeqIIe2KL4L5zrtidy0vFajKysgPyxw7+P0V71CkJB6qr0ehyPdCVJjQxlXVfsC2trUORJn1NzKHqmAdbMVEv5pnlCN8+WVpTztLk/h9QQFXGpxsUcek5C18E7wxhxJH4/UaI/QX3wbPK6TApoLXoVjqtwH1VLAX6Pl62ZQ6L7lszlloGOE5OTBVAHegD4JiAEiUmRrwTHV5VZtqlzMQs+3nVfyqa85+y13hnoq8wXn4mft0c9SHEPwblfjsfSJdk8c+IUrMZ6mV6kOBD0vrM6DE16RP1mM+gS6IBVBEb2QcSsvws3XzjDZQjRYFncsfuNwlM8hB9lphESGfpj01tTGItyhqm2ptQCMAQFPpjD91F2ImvVbclcxejcY2jY9bh2V2dJrtwuF7BG7U1/vl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7536.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(11063799006)(4143699003)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWtyNzh2NjZvKzZxTlpuOHpKcGowL3RDRlE4N1FJaGl4dDlsR2pmV1lsWnlw?=
 =?utf-8?B?NDI5WHlYVGNWUmp1SnBXazlGV1VEWjNiS1UvQ0Z1SndGKzdxNXJ5ZW81bGxs?=
 =?utf-8?B?amNEUDM4ekdlNURsWTBxNmo2UlJleHp0ZzA1SFlJL2xZU0JhekNiU0tFakFJ?=
 =?utf-8?B?WDJ6eS9MSm5mQ1hYek4rd0ZWNG8rSkJZcFBNN1pnMTV0aGVFR0thOGdBc2h2?=
 =?utf-8?B?ZlNpN21oV2hVMHZFWW5hcnpFY1VhWHh6anB5Y3AvSG1weTZ0emxLbFlQSFhs?=
 =?utf-8?B?RDNZRGtwdVFUV1Z1TGcyVDF2T0Z2WkUrMTdkWEhENURRZ3p3VlZoSFdHQkcv?=
 =?utf-8?B?bkJmU3RpdWo1ZHRzWi9kVjFuQitvUFB0RHNqaDQrUVdEb3BoTzNRUDRWSXNv?=
 =?utf-8?B?VFVqRW91VUxYaHYvSjNnaGxsN1lBRnlqc1grZmVDT0doeFVPKzJNZlg5ZEhn?=
 =?utf-8?B?V2ZMTFpmKzNXWmMyTkVseWhOOUwxaTI0MFhZblhBRnhPbmF5VkFlVFRUbDNW?=
 =?utf-8?B?YmoyMmRnWTZFWnNXL3VzTzVVTUhjeGRGei85M2hxQ2tseTVhRVM5b1FnTjdK?=
 =?utf-8?B?Z05xaE5RQ2Y0d1dYRVEva2V3eUg4aWJvdGdIb1lTK0dPRnJVRGY2UUp4MmdQ?=
 =?utf-8?B?blRremo4Z3lxNkdRblBSbms3c0xzOUcwUFRzYk9RY2dxVUpQWVd6YnFTTVdI?=
 =?utf-8?B?M1ZHSWtOZy9uK1REa0pITWpjOTdGSkR2c013NG9rRDFOU2JpNnVITVZvUm81?=
 =?utf-8?B?S1lxVlZOSUhKVG9CSW5LUjk5Y0cyWW5aUXJ5VjZkSVRMYzhiekdJTHBYbVJW?=
 =?utf-8?B?UnY3M1NzbFVUMUJtb0J5cDFSQXA2eUp4aGRJdXpJMXdoK1FLdFpYWnZ3V3Rh?=
 =?utf-8?B?UVRiM2VaMjJZREJJcnpzVEVOa0hOb3lpNXdJK0wvV0RnYTVNYTE4dFhwQWZW?=
 =?utf-8?B?N05pM2FVLzdNb1dlUU5mdVl3eUt4UisvTDNGSVpzK0FBWUpjVkcwNVZmLzJr?=
 =?utf-8?B?R3luVnNPb1pIdEZDeks4WHVJeU5LWFhOeXA4RTNnQ2VramlDa1BXenByMis3?=
 =?utf-8?B?a3laRUo3MThoeHdXRjZrMytDMy9jRUd4RExnS3g2aVdsYnY4Z0o1dTFZaDZq?=
 =?utf-8?B?QXBaSmNma0N6bGZ3ME9vU3ZpVU85M1JPRWs1SmRWcDd6KzYzc3hFb1pXMTYy?=
 =?utf-8?B?dFVwOE95b1pOSHZnQ2FVbGc2blNWMXhrcVgxdWZoMXNsbmNoaWlJclJUVklG?=
 =?utf-8?B?c1JXS1FZOXZmWTZ1ZmR1d1o2WE1hZVpGSEd3Wm1lR0NMcFBsVWEyTjlHeFY0?=
 =?utf-8?B?MGFXWHRtWHB6enArTzJ1Y1R3bnVYVGgwMWo1WFBqWDBRZnpVRGV5ZWNOeVM0?=
 =?utf-8?B?QldHRXZGVVJxdXhyUUNkazNOdWRrVmFRbWhIWTlacmZGdkxKNXFETFoxZnEz?=
 =?utf-8?B?WThrZFNMS2hDY3Q5RUFUeFppWlZ6YXJPeElnTkRPdWpYaFlCZUF4QlFLOXNs?=
 =?utf-8?B?eGpUMnFuYnRuaWhnMUVKRkRmSlBUL2hBQXZLbFM0dUFJdnlaR0FsaVpsTjlz?=
 =?utf-8?B?ZHZLOTJmVWpEbXJXbkYzNGF4b2NWRXFXN3Q3dGJIbjhHWWRIb2VOSlpkRFV3?=
 =?utf-8?B?dndSNUdwdE9IOW9SaWRPK0hmdGhHaldIRzM4Yk5raE5ZMUpFSEhtV1hpdVNz?=
 =?utf-8?B?WGVvT3N2YmJTVDN2a1ZxZ0cvRWVoejZCdjhlc2NXdTVqQ2Z5SjVUSmM2Z3JE?=
 =?utf-8?B?cmc3eFpjaHVXeklFd1hKUzhtbWtDMW1Lb2NqOGR4c2VaZkFhVDVFRGd1aXRT?=
 =?utf-8?B?QlB2Z3ZMd2pBSGtiRGx0Z3g5UCtOamI5M2Z2UHBESHJRM1dTSVMxOE4zNWJT?=
 =?utf-8?B?N3paSUZNZUg4V3pRa3UvU0piZzc0VlNuVE8xb0c2eXF5bU9aMDB5d1RUaWtt?=
 =?utf-8?B?bVRDUjNNeC9uOHZ2aXI3SEZtU0tVOTlZaUlaeG1VU3UwYnRNQ3hGZ1hjRVhm?=
 =?utf-8?B?cTYzcnducTZFYldnOU5LNTU4WU9FVC9LOEF3ZUMycDZrd2NOb2JTdmtHeXBV?=
 =?utf-8?B?RGtKY2hLVTlidHVVa2RoblBrQTVnZUJxUmxhTXJOMC9Bc2VWQUFLTnJtV0Zv?=
 =?utf-8?B?QUpZMHh2ZmFUYXQvQmwyaTZraFN5bFBVRkt2a0NqUjhNZ1l1OU95SWdUK3NL?=
 =?utf-8?B?a0NUT00xUjczMTRyb3VJQzQvWW1ZQmdFc1lQTlljYnN3NW5ON29pWnNiSmhY?=
 =?utf-8?B?RWk1cnUvUnBnM3dQK25COEgvUEJXYW0vOHZIeSs3aWY3ZHM2MnptZ1l1OUwy?=
 =?utf-8?Q?/Tpnvw1uPulC84T/HO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7536.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e591a8-c376-4850-f3b7-08debdadca69
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 18:12:05.5700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v2d+eG/+sBrXONZa+eKmTVG51f52ZtcNx0cxRtFLgDcik7AnFZlsqR7fYSi8fxX28hlvC93/8c9uyCYi3Dj1iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272
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

QU1EIEdlbmVyYWwNCg0KR3JlZXRpbmdzIEBBbGV4IERldWNoZXINCg0KVGhhbmtzIGZvciB0aGUg
QUNLLiAgV2FpdGluZyBmb3IgdGhlIFJldmlld2VkLWJ5Og0KDQoNCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNv
bT4NCj4gU2VudDogVGh1cnNkYXksIE1heSAyOCwgMjAyNiAzOjA2IFBNDQo+IFRvOiBNYXJ0aW4s
IEFuZHJldyA8QW5kcmV3Lk1hcnRpbkBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gZHJtL2FtZGtmZDogRml4IGJ1
ZmZlciBvdmVyZmxvdyBpbiBTRE1BIHF1ZXVlDQo+IGNoZWNrcG9pbnQvcmVzdG9yZSBvbiBHRlgx
MQ0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFs
IFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywg
Y2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIFRodSwgTWF5IDI4LCAy
MDI2IGF0IDE6MzTigK9QTSBBbmRyZXcgTWFydGluIDxhbmRyZXcubWFydGluQGFtZC5jb20+DQo+
IHdyb3RlOg0KPiA+DQo+ID4gVGhlIHYxMSBNUUQgbWFuYWdlciBpbmNvcnJlY3RseSBhc3NpZ25l
ZCB0aGUgQ1AtY29tcHV0ZSB2YXJpYW50cyBvZg0KPiA+IGNoZWNrcG9pbnRfbXFkL3Jlc3RvcmVf
bXFkIGZvciBLRkRfTVFEX1RZUEVfU0RNQSBxdWV1ZXMuIFRoZXNlDQo+ID4gZnVuY3Rpb25zIHVz
ZSBzaXplb2Yoc3RydWN0IHYxMV9jb21wdXRlX21xZCkgKDIwNDggYnl0ZXMpIGluc3RlYWQgb2YN
Cj4gPiBzaXplb2Yoc3RydWN0DQo+ID4gdjExX3NkbWFfbXFkKSAoNTEyIGJ5dGVzKSwgY2F1c2lu
ZyBhIDE1MzYtYnl0ZSBvdmVyZmxvdy4NCj4gPg0KPiA+IER1cmluZyBDUklVIGNoZWNrcG9pbnQg
b2YgYW4gU0RNQSBxdWV1ZSBvbiBOYXZpM3g6DQo+ID4gLSBjaGVja3BvaW50X21xZCgpIHJlYWRz
IDIwNDggYnl0ZXMgZnJvbSBhIDUxMi1ieXRlIFNETUEgTVFEIGJ1ZmZlciwNCj4gPiAgIGxlYWtp
bmcgMTUzNiBieXRlcyBvZiBhZGphY2VudCBHVFQgbWVtb3J5IHRvIHVzZXJzcGFjZQ0KPiA+DQo+
ID4gRHVyaW5nIENSSVUgcmVzdG9yZToNCj4gPiAtIHJlc3RvcmVfbXFkKCkgd3JpdGVzIDIwNDgg
Ynl0ZXMgaW50byBhIDUxMi1ieXRlIFNETUEgTVFEIGJ1ZmZlciwNCj4gPiAgIGNvcnJ1cHRpbmcg
MTUzNiBieXRlcyBvZiBhZGphY2VudCBHVFQgbWVtb3J5IChvZnRlbiB0aGUgcmluZyBidWZmZXIN
Cj4gPiAgIG9yIG5laWdoYm9yaW5nIE1RRHMpDQo+ID4NCj4gPiBUaGlzIGlzIGEgY29weS1wYXN0
ZSByZWdyZXNzaW9uIHVuaXF1ZSB0byB2MTEuIEFsbCBvdGhlciBBU0lDIGJhY2tlbmRzDQo+ID4g
KGNpaywgdmksIHY5LCB2MTAsIHYxMikgY29ycmVjdGx5IHVzZSB0aGUgU0RNQS1zcGVjaWZpYyB2
YXJpYW50cy4NCj4gPg0KPiA+IEFkZCBjaGVja3BvaW50X21xZF9zZG1hKCkgYW5kIHJlc3RvcmVf
bXFkX3NkbWEoKSBmdW5jdGlvbnMgdGhhdA0KPiA+IHByb3Blcmx5IGhhbmRsZSB0aGUgc21hbGxl
ciB2MTFfc2RtYV9tcWQgc3RydWN0dXJlLCBtYXRjaGluZyB0aGUNCj4gPiBwYXR0ZXJuIHVzZWQg
aW4gb3RoZXIgTVFEIG1hbmFnZXJzLg0KPiA+DQo+ID4gRml4ZXM6IGNjMDA5ZTYxM2RlNiAoImRy
bS9hbWRrZmQ6IEFkZCBLRkQgc3VwcG9ydCBmb3Igc29jMjEgdjMiKQ0KPiA+IEFzc2lzdGVkLWJ5
OiBDbGF1ZGU6U29ubmV0IDQtNQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuZHJldyBNYXJ0aW4gPGFu
ZHJldy5tYXJ0aW5AYW1kLmNvbT4NCj4NCj4gQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4NCj4gPiAtLS0NCj4gPiAgLi4uL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfbXFkX21hbmFnZXJfdjExLmMgIHwgNDANCj4gPiArKysrKysrKysrKysrKysrKyst
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRf
bWFuYWdlcl92MTEuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9t
YW5hZ2VyX3YxMS5jDQo+ID4gaW5kZXggNGQ4Y2Y2MDA4YTc3Li5jZTBmNWU4ZTVjMjkgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Yx
MS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2Vy
X3YxMS5jDQo+ID4gQEAgLTM1NSw2ICszNTUsNDIgQEAgc3RhdGljIHZvaWQgcmVzdG9yZV9tcWQo
c3RydWN0IG1xZF9tYW5hZ2VyICptbSwNCj4gdm9pZCAqKm1xZCwNCj4gPiAgICAgICAgIHFwLT5p
c19hY3RpdmUgPSAwOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgY2hlY2twb2ludF9t
cWRfc2RtYShzdHJ1Y3QgbXFkX21hbmFnZXIgKm1tLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdm9pZCAqbXFkLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdm9pZCAqbXFkX2RzdCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZv
aWQgKmN0bF9zdGFja19kc3QpIHsNCj4gPiArICAgICAgIHN0cnVjdCB2MTFfc2RtYV9tcWQgKm07
DQo+ID4gKw0KPiA+ICsgICAgICAgbSA9IGdldF9zZG1hX21xZChtcWQpOw0KPiA+ICsNCj4gPiAr
ICAgICAgIG1lbWNweShtcWRfZHN0LCBtLCBzaXplb2Yoc3RydWN0IHYxMV9zZG1hX21xZCkpOyB9
DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCByZXN0b3JlX21xZF9zZG1hKHN0cnVjdCBtcWRfbWFu
YWdlciAqbW0sIHZvaWQgKiptcWQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3Qga2ZkX21lbV9vYmogKm1xZF9tZW1fb2JqLCB1aW50NjRfdCAqZ2FydF9hZGRyLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHF1ZXVlX3Byb3BlcnRpZXMgKnFw
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgdm9pZCAqbXFkX3NyYywN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHZvaWQgKmN0bF9zdGFja19z
cmMsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCB1MzIgY3RsX3N0YWNr
X3NpemUpIHsNCj4gPiArICAgICAgIHVpbnQ2NF90IGFkZHI7DQo+ID4gKyAgICAgICBzdHJ1Y3Qg
djExX3NkbWFfbXFkICptOw0KPiA+ICsNCj4gPiArICAgICAgIG0gPSAoc3RydWN0IHYxMV9zZG1h
X21xZCAqKSBtcWRfbWVtX29iai0+Y3B1X3B0cjsNCj4gPiArICAgICAgIGFkZHIgPSBtcWRfbWVt
X29iai0+Z3B1X2FkZHI7DQo+ID4gKw0KPiA+ICsgICAgICAgbWVtY3B5KG0sIG1xZF9zcmMsIHNp
emVvZigqbSkpOw0KPiA+ICsNCj4gPiArICAgICAgIG0tPnNkbWF4X3JsY3hfZG9vcmJlbGxfb2Zm
c2V0ID0NCj4gPiArICAgICAgICAgICAgICAgcXAtPmRvb3JiZWxsX29mZiA8PA0KPiA+ICsgU0RN
QTBfUVVFVUUwX0RPT1JCRUxMX09GRlNFVF9fT0ZGU0VUX19TSElGVDsNCj4gPiArDQo+ID4gKyAg
ICAgICAqbXFkID0gbTsNCj4gPiArICAgICAgIGlmIChnYXJ0X2FkZHIpDQo+ID4gKyAgICAgICAg
ICAgICAgICpnYXJ0X2FkZHIgPSBhZGRyOw0KPiA+ICsNCj4gPiArICAgICAgIHFwLT5pc19hY3Rp
dmUgPSAwOw0KPiA+ICt9DQo+ID4NCj4gPiAgc3RhdGljIHZvaWQgaW5pdF9tcWRfaGlxKHN0cnVj
dCBtcWRfbWFuYWdlciAqbW0sIHZvaWQgKiptcWQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgc3RydWN0IGtmZF9tZW1fb2JqICptcWRfbWVtX29iaiwgdWludDY0X3QNCj4gPiAqZ2FydF9h
ZGRyLCBAQCAtNTM5LDggKzU3NSw4IEBAIHN0cnVjdCBtcWRfbWFuYWdlcg0KPiAqbXFkX21hbmFn
ZXJfaW5pdF92MTEoZW51bSBLRkRfTVFEX1RZUEUgdHlwZSwNCj4gPiAgICAgICAgICAgICAgICAg
bXFkLT51cGRhdGVfbXFkID0gdXBkYXRlX21xZF9zZG1hOw0KPiA+ICAgICAgICAgICAgICAgICBt
cWQtPmRlc3Ryb3lfbXFkID0ga2ZkX2Rlc3Ryb3lfbXFkX3NkbWE7DQo+ID4gICAgICAgICAgICAg
ICAgIG1xZC0+aXNfb2NjdXBpZWQgPSBrZmRfaXNfb2NjdXBpZWRfc2RtYTsNCj4gPiAtICAgICAg
ICAgICAgICAgbXFkLT5jaGVja3BvaW50X21xZCA9IGNoZWNrcG9pbnRfbXFkOw0KPiA+IC0gICAg
ICAgICAgICAgICBtcWQtPnJlc3RvcmVfbXFkID0gcmVzdG9yZV9tcWQ7DQo+ID4gKyAgICAgICAg
ICAgICAgIG1xZC0+Y2hlY2twb2ludF9tcWQgPSBjaGVja3BvaW50X21xZF9zZG1hOw0KPiA+ICsg
ICAgICAgICAgICAgICBtcWQtPnJlc3RvcmVfbXFkID0gcmVzdG9yZV9tcWRfc2RtYTsNCj4gPiAg
ICAgICAgICAgICAgICAgbXFkLT5tcWRfc2l6ZSA9IHNpemVvZihzdHJ1Y3QgdjExX3NkbWFfbXFk
KTsNCj4gPiAgICAgICAgICAgICAgICAgbXFkLT5tcWRfc3RyaWRlID0ga2ZkX21xZF9zdHJpZGU7
ICAjaWYNCj4gPiBkZWZpbmVkKENPTkZJR19ERUJVR19GUykNCj4gPiAtLQ0KPiA+IDIuNDMuMA0K
PiA+DQo=
