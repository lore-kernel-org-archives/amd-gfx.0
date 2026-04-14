Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC83AED7B84
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 08:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3164510E5A7;
	Tue, 14 Apr 2026 08:15:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BkTAE2Qa";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B040410E1E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 08:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fpn22amr5A76pQ5HrtJekKgLl8lyuQWNsXwITTQRUuj3aChknQukfD42IK15dbU4MRRgxJgB9lx8ziSJk3wvqxwGf+FtWkFRq6/ex2yikvcLjxEga7vnh9LUhZjy0VVGuRpVzbNqaBbNJGSCwQzL4NXcQGiamo/V6en2QrCIx1CfizhaFgzdXxioExwmteLPSNxomWcOZBafTSGMYM4Cw/CGJtIBcFu1dmNWWkbSSU2u1PTtpi/kLBxe3zv3XdvOM7SkpUdvtrqgfvqjW1pwj3RovRYhuj2pgZ6Of9t1AEA0Bw3q1mS2DjPfyzRJj50ufkJY6r6mJfAytJ7ih0XP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/F/rI85KdlBK4QvS7EQY0g31Q7G+P8yu9pkFJ2cJ3UA=;
 b=aX3N07ETTpv9FLXtC6/X5pvJQe5+BPziXEtdxHtM9w/Myr8RutksTYVHjCHl0ydpcwI5KkQAD7zX3UeN7kilpUCy21qBfAEPtfxH0piu1Izk4CCUqQntlmphuZEiyP2IejdBQ/jvL55WNcWgPMmmyfxC4NJc3VY3L5uUkOrmtUQb1sJozx/D6P0un4lRwPeZEUI7iItlWvfo/pjNg+6fBV3jp13ZuApFiwqnVCOI0ESLBr39vz4NYJLFN0aQQTtw1UkYJ/epYgiiMC1epxIAagu7M9mLa7aSmxfAoqLn+LydmihAlrzLiXD6VJePaC5KipwzaBF53Am00laJz6xQAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/F/rI85KdlBK4QvS7EQY0g31Q7G+P8yu9pkFJ2cJ3UA=;
 b=BkTAE2Qa2RHQXIAiWF21ncyi80UQHiQc6b77Zu4bJ7RFYLIG1j0gnoXNVS4sUKm9yGZYCU/AvIWJO4a0y7wubRE41UajbnWbzbDNe5Fhv9nio+7dAc2NehXxQ7GElq94IXlACdCV2SMlZYVk9qdIOYQXfT+eDBQ/szXLQTYC0xc=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SA1PR12MB999253.namprd12.prod.outlook.com (2603:10b6:806:4dd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 08:15:05 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:15:04 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix error handling in
 amdgpu_vmid_alloc_reserved()
Thread-Topic: [PATCH] drm/amdgpu: Fix error handling in
 amdgpu_vmid_alloc_reserved()
Thread-Index: AQHcsiKCfscOOWmMgUO2BghvpNUWILXeaTCw
Date: Tue, 14 Apr 2026 08:15:04 +0000
Message-ID: <IA0PR12MB82089B134430654A11B4528990252@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260312131625.1839044-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260312131625.1839044-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-14T08:14:49.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|SA1PR12MB999253:EE_
x-ms-office365-filtering-correlation-id: c392f475-3f4f-4a1a-f8e5-08de99fdeef1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 2I9IRUS6GNo0yM5JB2O5kv0byRKPL9CV9luOaN3gr6yIvZISD4ZiBWc+i5+4UoCELJ4p35A1mkOqIkhY+tmR8UQjw5pnBCbxITKD5tPx0I9VSN0TTFSIyXv0vl1sk2Fn7Bdt8VQ0RBEsRk8ihQX9uCENnbPPIEbcNxfKOudtpJku14HHCM2OtltMtM4agxkCoPTKULobC5vm5e68Vy0b3NMEVt4KBQ11MxYS0Oj2LL3NvdiuqRuGJXeewKnFHACSlCrcBnZHzgAbVvagsb8vAxVGJvrdoPIbXlceJgDzYw9/bFu0zV2+gIBV/mT2/ctTXrnLZz34CSwIME2ksvNLRN/RUEEBMyv6xSIq1RwYBQ5b0dBjT7Tyc2B4hRN8HhEzImxCdNNQhJT5O/oH/5K7erLm/xCLpM+2ULPMNBfadDnc1jnaPblci6OT253GEvYzmA0vdSebpVqA2Jml6/ygYqbDm6OUxXkhTezO536j0fBphz4pDtEO8AzAu4v9reVKUpt5COXEeA4g7NONGOmbb8N/W85qNtoOcQuwn3zOBPqI4VKjH4zSKru9Lec7KXPzjkD+z/oc/0OSgV5KRdbNHP1Qm8f6gCAKNnfj66Rj/P/AW3mZiqA4SrtLFfr5osWZxKqA3M2RBqdZYSUp9Iu8i7H+231XQ/3wHEcTEK//Ud07xU7WanwU+u2urGOWSxk7qaxL0FJWfLhE9JkzT/vvcRzXBsh4jYTH3DBwcj2EeYH8rwlT1BtTPmD3CjFcagTslXR8+ZttJfIuor6KdvpCNyE325UuJsbkBRfV+bIbh4k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3NpYmYwQXMxOXF2aVZZME1hTkxVQVF3amhoTEZkMyttcURyNjB2SVBsZSsz?=
 =?utf-8?B?ZXJXY25Ma0FVeUFtYUxWWXdsMFdpdGhmWTRqa2pMZkZJeWxNNENBWDNzd0VO?=
 =?utf-8?B?ZWZRU2x5SUlwVzd5WThZd3pPWitSQ0x3SXQxWVdjZWdIaVc3L3JPRWZlclF3?=
 =?utf-8?B?bmZkTGxsTjZLcUdtOHV5MmhubkJoM3Fwc01sSlRYSWlneFp4UzdzZGdRc1R1?=
 =?utf-8?B?OVZSWWM3NlBPTDNSTVBWeUtYck84ck43T1NrajR2ZXp0d3FNZVY1QnQ5NkxV?=
 =?utf-8?B?TVdtd1BnOENMKzNvWTAyb3BmdUtDSE1MWkFlUTdWWmJNZGx6MWJZQ0RYZ0lx?=
 =?utf-8?B?VFBoUGh1M1k2QmVpYnlQOEJnZ1Q5NGJLK3RHZ0FlWWZHY0FEdG1LaWFEY29a?=
 =?utf-8?B?OUpRZ293K0h6aE9CZW9pNEJWUTFjTlYyaFBEd1hGcVROMmRLSDZVcGZlRHB4?=
 =?utf-8?B?am94N1daUXJBNlMyK2hESm9MeVVPZmZUUHhSWGJDbWdWRkNLZmRtRTJXUTVD?=
 =?utf-8?B?allBTVBSL0djQWxxbTd4OEJ4dnRFKzN3bzVoYVhyT1dTYXcrNXVmR0xXZlZU?=
 =?utf-8?B?TGZpdEk3cFdhVzhmL3J3enI1WEpHa054eDkrbTdmeVI1eWduQkFBamlGVG4v?=
 =?utf-8?B?K24yOCtCSWYweGdYSFNaQUwrejBXdXNkdTZzZjlPNjNQY0JYbXhBa01nYWVR?=
 =?utf-8?B?L3FvVTd4YVZWZGlpb25CYTRsMXdJODMxaG5wYjl3MmRyTjVSa1lwTFJldnNI?=
 =?utf-8?B?eDZFWUYzOGxaUmQ5Z01MMXJlcUc4akVCbm1HZGNZUHBFU1laYklkaDJzQlZw?=
 =?utf-8?B?eHZrc054M1dvOCtFNE1PelhvUER2NHo0dzVBQ2V2d2NJM0ZUWTFOQ2hhWkho?=
 =?utf-8?B?Qm9rSk9Kbm9yWkRhSjZZNVpBYy8vTTNBN2JGQzNITkRoMmlhYmlEUTluSFV3?=
 =?utf-8?B?MEZxSjlBTi9PaVZVVFJVU1RSZDZUM1h4amVRNng0eHB0alpCN2doblpjaUxH?=
 =?utf-8?B?R1pLRGZoamRxWkhxa28xTlUzbU5mWis4Ykp6UDFIVWs2SHo2L1l5T2NDQlQ2?=
 =?utf-8?B?ejhack9yYVBBQ3ZIMUJXeWZDKy8wSjFVVEVYY3Nqb25rTDlsS01lVlVaakRy?=
 =?utf-8?B?T1NweFRodkxyWWw0WCtHbkp4elZUdDg1WFY1eUsvdVdIcWZ3aHI5SEluaUx5?=
 =?utf-8?B?WVJUdFdoR3ByUEhMSkQzd1gvN0xvUkFwOGdaSldJK0JrelZkMWMxelBSUzla?=
 =?utf-8?B?ZmlCMmQzWVpCanRqbnR4NXhTSis5SlB3MDZwT0YwYzFXVEFVZkZXQk9qdDJL?=
 =?utf-8?B?RlBXTVcxQ3hWa1Y4SG9HZ1FuUndGbkxGc2V4S0xCa284NVZ6VllKMmN1M1Ni?=
 =?utf-8?B?WFg2MkdjcU1GRXhzU3BqclRrQ3dhOFJDNnV4dVFoMUJrVFZhRWtqalNIcmpz?=
 =?utf-8?B?bGR6dHMvYThrQmNWdENlYlBZa2tUem9kNTZTM0xPVGthaGJMTDRtNGxaRUoz?=
 =?utf-8?B?aFNkZkEzdTRkd3dCYitKSXM2SXN0SlZRa1hFbXFWaVVuNnpZT0I0THhJdXFV?=
 =?utf-8?B?S011VkFSTUwzTldsRGZBb2pEMXp0dUdpa1JzWnJMeUNGa2lBbzdtOXA5TXJx?=
 =?utf-8?B?M2YwV0NPNm1rSzNDRmhhWlExczBLbzVaUFArUmsyNUdlYm01b2dvckcyZVN6?=
 =?utf-8?B?bHBJY3lRZ3RlRTJrZlQ4SkMxVlc5ZnhHYWoyR2Y4RzZRVFNCa2RpNWpUOE40?=
 =?utf-8?B?SG9ScytRVjk0a0x2TTRLQ2ZuZ1JEMkFzMGJlUXpNbGFNMElUSnV0Q2hBVnhQ?=
 =?utf-8?B?dXJ0ZWk1Q1F5dml0c1M2cFpQQ29UK1FTNUFWUGRCRUJOUjZGa1NCNXpodFVp?=
 =?utf-8?B?TFVPaG4ya2JzK3hZTS9mVEJydHpGTnJYbmZkeFg4OHpnUVNTWEVPRVNoVkQy?=
 =?utf-8?B?Q2pJd1ozTWdiN2VWcDJmQU9tUENJM2oxK2tnR09WWm1OTERsSTQ1ODJLRXlT?=
 =?utf-8?B?YjBLWC92RnlsQllsMDV4bGgxb0c0VTJkeFZtTk5hemhPb2NnUUpnWElSOE1i?=
 =?utf-8?B?aWg0MEdSTDdJL1FWcGE0eXFrTzBlVXVDbHU0NGYyaEFxR2w4TmJiSTI2eTJ2?=
 =?utf-8?B?U3JVY1JCOHo3MXp1VHJnTksvUXp1Y2c5YTk5L2UwRjlhUmdtTkdzbGloNEF4?=
 =?utf-8?B?aEt5Nzl3YXFTMmZaTm1JSGNrTTc3NHE5bTZONWx6eEJ1RWdhcnY0eTFGK2Ey?=
 =?utf-8?B?YTF5Yklhck9DK0U3TVUyOTg2TmxGWklQeU12bkhRUzg2TUd3NGVvcVNWK25S?=
 =?utf-8?Q?Mpe9NI8IASR3qAiRRM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c392f475-3f4f-4a1a-f8e5-08de99fdeef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:15:04.7286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z2ZhyKZuCXz0vyNxsZAkoUwB62SntiVG/e0bnHJSNGcpm8EdQojqMindVYN3BCdtZOSOkd5LyPQotV/8aQP3Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999253
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

W1B1YmxpY10NCg0KUGluZyE/DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPg0K
PiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMTIsIDIwMjYgNjo0NiBQTQ0KPiBUbzogS29lbmlnLCBD
aHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0K
PiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnOyBTSEFOTVVHQU0sIFNSSU5JVkFTQU4NCj4gPFNSSU5JVkFTQU4uU0hBTk1VR0FN
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogRml4IGVycm9yIGhhbmRs
aW5nIGluDQo+IGFtZGdwdV92bWlkX2FsbG9jX3Jlc2VydmVkKCkNCj4NCj4gYW1kZ3B1X3ZtaWRf
YWxsb2NfcmVzZXJ2ZWQoKSByZXR1cm5zIHN1Y2Nlc3Mgd2hlbiB0aGUgVk0gYWxyZWFkeSBoYXMg
YQ0KPiByZXNlcnZlZCBWTUlELCBidXQgcmV0dXJucyAtRU5PRU5UIHdoZW4gdGhlIG1hbmFnZXIg
YWxyZWFkeSBoYXMgb25lDQo+IHJlc2VydmVkLg0KPg0KPiBCb3RoIGNhc2VzIGluZGljYXRlIHRo
YXQgYSByZXNlcnZlZCBWTUlEIGFscmVhZHkgZXhpc3RzIGFuZCB0aGUgcmVzZXJ2YXRpb24gY2Fu
bm90DQo+IHByb2NlZWQuDQo+DQo+IFJldHVybiAtRU5PRU5UIGluIGJvdGggY2FzZXMgZm9yIGNv
bnNpc3RlbnQgYmVoYXZpb3IgYW5kIHRvIGZpeCB0aGUgU21hdGNoIGFib3V0DQo+IGEgbWlzc2lu
ZyBlcnJvciBjb2RlLg0KPg0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWRz
LmM6NDcxIGFtZGdwdV92bWlkX2FsbG9jX3Jlc2VydmVkKCkNCj4gd2FybjogbWlzc2luZyBlcnJv
ciBjb2RlICdyJw0KPg0KPiBGaXhlczogOTBlMDllYTRjZmQ0ICgiZHJtL2FtZGdwdTogcmV2ZXJ0
ICJyZXdvcmsgcmVzZXJ2ZWQgVk1JRCBoYW5kbGluZyIgdjIiKQ0KPiBDYzogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5t
dWdhbSA8c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWRzLmMgfCA0ICsrKy0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9pZHMuYw0KPiBpbmRleCA5Y2FiMzYzMjJjMTYuLmQwZGVkYWM2MzBi
MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lkcy5j
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYw0KPiBAQCAt
NDY3LDggKzQ2NywxMCBAQCBpbnQgYW1kZ3B1X3ZtaWRfYWxsb2NfcmVzZXJ2ZWQoc3RydWN0IGFt
ZGdwdV9kZXZpY2UNCj4gKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLA0KPiAgICAgICBpbnQg
ciA9IDA7DQo+DQo+ICAgICAgIG11dGV4X2xvY2soJmlkX21nci0+bG9jayk7DQo+IC0gICAgIGlm
ICh2bS0+cmVzZXJ2ZWRfdm1pZFt2bWh1Yl0pDQo+ICsgICAgIGlmICh2bS0+cmVzZXJ2ZWRfdm1p
ZFt2bWh1Yl0pIHsNCj4gKyAgICAgICAgICAgICByID0gLUVOT0VOVDsNCj4gICAgICAgICAgICAg
ICBnb3RvIHVubG9jazsNCj4gKyAgICAgfQ0KPiAgICAgICBpZiAoaWRfbWdyLT5yZXNlcnZlZF92
bWlkKSB7DQo+ICAgICAgICAgICAgICAgciA9IC1FTk9FTlQ7DQo+ICAgICAgICAgICAgICAgZ290
byB1bmxvY2s7DQo+IC0tDQo+IDIuMzQuMQ0KDQo=
