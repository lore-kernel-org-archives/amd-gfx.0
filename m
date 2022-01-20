Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8FBC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 19:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB18A10E6C0;
	Thu, 20 Jan 2022 19:33:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C835C10E6C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 19:33:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlWNnHt/xBb4+8pGgOW1NHddULEwd+O82X/0gmfGTTjxoGeqsd22orkrgZggMdEfPF7kpb8bv7XTqHyMx1q0zX5EudVowpaUCy6NjJ0013CJzBJfBwPHuiOAhAdyzYBwDuivk3GFlOlqYGXpjrVCt5hxvm6raoCJhiZuX2oajHOdSw1IShyro3nkYyltyEu2ZVkw9C5vqQhqMOXB9gMf1yuQQo3ujM0P5tyDbu1XPn5Qp22WAlrJEBUYyOjjwhon7BTYmdjyXd649Ne2yJb3g4RCxmT+j33kYaHmSgnZM2ue74Ys4UrkXmb3HlP/Q7fmB0WrrIANpgAlVtRJbZ61Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNRXQEftqobL9y00fgt97rk3u4Om5iDITznfgSsbkOs=;
 b=mHIoGjcDBlNFFZSXMSqbogjjFsZIhdAzK6Iqe6NQ/OS/6/0GYvj2qrpfAmXU01klCeGLv8n2l/f2NZQ7L3YsTdPTwPuETCIKupT7mtl1PPQiyQrYbEAt1gZvDLo+86rdqKXEjQRD/izHbtfLOHf3Sd6ExyUOzFKL11pI2xbWV64TtAbgUXPYoS8lnaCXPbb1iWIisiybe/oe3jzznkBuDPsPwU4fxzVuKSs7Xt6hWatpJlFDxMMXWm1v9eo4toUL1VD9FA+foS5Zd6qbZWuRnHxykOIiJR68wNc5VTGvhfXrTfADt0AkAjHr2hbL8NX/yzrEYdvLoluNfzLm0BlGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNRXQEftqobL9y00fgt97rk3u4Om5iDITznfgSsbkOs=;
 b=Y0nNaYUMqbRoGDgxNMpZBRdTEO9sQ6Lpzb9/HAS1DysXD8jPCTKl4YgprrcM7lXgchHE3Teb9xDrOrW28+B/AHQpf1tCUInClYxywbfR5zBB8AiuiFZVp5vdyOkbUQvdwVwSAZSQpW9Y5IVfJ1oKMFzBgUR2usSFBjmCl3TcpN4=
Received: from MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 20 Jan
 2022 19:33:25 +0000
Received: from MN2PR12MB4173.namprd12.prod.outlook.com
 ([fe80::37:59de:967e:5468]) by MN2PR12MB4173.namprd12.prod.outlook.com
 ([fe80::37:59de:967e:5468%3]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 19:33:25 +0000
From: "Mahapatra, Rajib" <Rajib.Mahapatra@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>, "Wu, Hersen"
 <hersenxs.wu@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/display: Not to call
 dpcd_set_source_specific_data during resume.
Thread-Topic: [PATCH] drm/amd/display: Not to call
 dpcd_set_source_specific_data during resume.
Thread-Index: AQHYBgFyW6apt73fO02h9f8bOAIVnaxcc1WAgAD8jECAAJGQAIAOWrVg
Date: Thu, 20 Jan 2022 19:33:25 +0000
Message-ID: <MN2PR12MB41731529058B7DD886A883E0F25A9@MN2PR12MB4173.namprd12.prod.outlook.com>
References: <20220110090652.3759559-1-rajib.mahapatra@amd.com>
 <44d54537-82b6-b1aa-c9a6-8dc6b16440e0@amd.com>
 <BY5PR12MB46434EFB35BC0F88E63B30E3F2519@BY5PR12MB4643.namprd12.prod.outlook.com>
 <bd73c50e-4a55-8943-d1d9-2b279d39e66f@amd.com>
In-Reply-To: <bd73c50e-4a55-8943-d1d9-2b279d39e66f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a5796c7-b27a-43ae-9f11-08d9dc4bba66
x-ms-traffictypediagnostic: MN2PR12MB4079:EE_
x-microsoft-antispam-prvs: <MN2PR12MB40794D75E516E94313F4260AF25A9@MN2PR12MB4079.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XD+OoBFBMIHMLMP+EH1ofIIpNUpCPEI2tE4GluhgfU2DqJQfPZt/lNiTdOcjzkFpW9WhvNHJ0J3NKccN6IkF6AgIdqh71z/L07Oh/VPmnJT0WLjRju8aOnCZJgWCN21u+wz0rtmWh3KUTsPC7BNoPihS2RjLkPd/zq5mgOakyaxi5kCGMLoj3nxW2XCmnCtYSyeEsIGkSWFGm8lU5QRjVrNsUmpycrJXDUd7QxDZZ3OcJhIzngn6/LPLasLwKem3GCA1TzORSu2w1OIf/YKmolid3osOTVo2NCLmucJRnXicnBjuNqAkOPrpp0tcU9veDb2pCuaG2L0lsbqSIJH3d6AKSSpoowfpy6vpqdTYxt3q9LfCCdqhztxSziaM9kTs9RdCWpH0Z+RXs9i5CrFMbdqF4WWgCfV/GVepIIwb59BeZRVOvrGwbTxfrSQMRUQ79eA8Tj7HYOtntL/1SwP424dw19W9YiVvoz6KJqYlb4+B0BS0qumHEdrRwSxtgqF4r4q1RhPUUSFh4xJ4wG8d4pR3suTBHJN7/A6A2tTOvhtYfSeF6brt2zijiFKOwMfUNq6Ko7RfZhe7JVhCqMw1AHNkwei4HGlQ738FE0xkj9DzWMtkA2aNO2PQ2KzDLdKSARl5yyr3m8eMbyUj5vXiYFKZsEF0y/vuNDLbetOs/VYSWi2e6lmulapd5lrIDejfIMUMKB/KjX9S02I+cChhog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(52536014)(316002)(8936002)(33656002)(110136005)(7696005)(71200400001)(122000001)(6636002)(55016003)(2906002)(54906003)(9686003)(6506007)(38070700005)(38100700002)(26005)(508600001)(55236004)(76116006)(66946007)(66476007)(66556008)(186003)(83380400001)(64756008)(66446008)(53546011)(4326008)(5660300002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3pyTTBBV3FlZEllUmlPUUVVaE5sWlhya0p4MEZrUlh3RVZmenZ1VENRT0Na?=
 =?utf-8?B?N01iVHNRY1JPUTVWakFIOGlOVTl2Y25QVXZxWHlxYW56WVBQdGJPWGU5NTg2?=
 =?utf-8?B?TU5OeDhjZlJRZklXaXRRQ2IrMXpvdDU5Z0JyWEhnYmtjV1dVNjJkcDRUazlm?=
 =?utf-8?B?NnJNT1VEUkFPTzV0VFFrNmV6NHVERTV0ZEtyV2xzM0dJN0g5T1FEcDVHOTBY?=
 =?utf-8?B?TExZM211N253R3JqTWdNeTY3MUlKNndBa0dLdnUwVTVXcjM5aXdHdERXeVRF?=
 =?utf-8?B?TThVd3RhQkJWN3NGWEF5aDlySXhjRnVXelIxTlhZNHdoVlNzb3ZNWUhPUmRK?=
 =?utf-8?B?KzhMOGtLRW9lMGlPdVRJeW9Zc0VHYXlGZ0V3V2F1VnNVMndpdWJZVFo4TWVl?=
 =?utf-8?B?ejYxYWRCcUNQUmx4UWNKQ2UrcFFDWHluZHZaenkrb2dJRmVkS0l1blhuRWw0?=
 =?utf-8?B?TVUzNDU5Q3p5YWRrNktzbUg3MFBDR1FwdzNVUy9RUTgrWXRzUEtDNnVnWVRx?=
 =?utf-8?B?NGYvVE8xZzNDSUVRNkhsYnVCOEdmczlUUE5wY3V1RUNXSGc2YmNPbVdjeC9L?=
 =?utf-8?B?Nzl0MFVqc1BHU1VQWi84anZjd2FwZ0FFWWZTY0NuMmhNT080TzNkUUp6SFR0?=
 =?utf-8?B?MFNwSlI5STV0UmpBeWx0cEtxandIdSt2dHh3VHhtRGVTWXJjUm0wNEovZUtK?=
 =?utf-8?B?bDI1WWRwM1B3QUVWSmNnMkNTUDBYZjBTRXgxY0Q1Vlh0VnFocGlsQUVCMEtu?=
 =?utf-8?B?Q042bmhlL0ZiQWdvb2R4VmxTYldOWWhVSldvUlBGbWlPUDk0N3B3TmkrMlpI?=
 =?utf-8?B?ZGR0cEVDbGtLOVhPdjhyV1o5aTA1YXJlR1R2UkcybnR4dkgzNjRhQ0NBQ2Iv?=
 =?utf-8?B?MDdXNlNRSnZETThnNFJFYWNyQVhZQ2RUaGF2MXR1ZnVvdU05RnY2Ynllc1Vy?=
 =?utf-8?B?VTllb0ZjdEkxblVjL0cwMFpHQjRjODlqdm5Cdkl1NUhwa2ZVRzdIUTBwZit6?=
 =?utf-8?B?OE8vS1VQYy94OEhsc1lRdmg5akF5RjFJTHJFRkRlOGFNZFJjM0g5QTQ3am5I?=
 =?utf-8?B?elRtempkdE9LTFpIR1BqRVE0OHJDUjFIQ0JFdzhTS3RpbVJSOEdzS21qRDJ2?=
 =?utf-8?B?Unc5VGdvbGY4ZXZUbklFT2JOT2FjYmdEWllCQ243TDFMYWh0N1VkdEJHN09m?=
 =?utf-8?B?TmVjZXB3YUIrcWIrb1R6SGZDU0phdCtRQkJqaGZtSmNRTlQyU1RlVHVUREFs?=
 =?utf-8?B?bno0SkFoeURTRUFJZ1VBTHR5TWJ4NklRK3B0Q2M5eVM3Wm9QaUFCWVUyZTZF?=
 =?utf-8?B?WkN5L0NqOTJOc3JBL1RhcCtMZC9TNWREZy8vcjY0OXVXbTMzM3hRNGlkZGhu?=
 =?utf-8?B?dDQrc0JnOSt0ZWl2WmJJbks2SGFpZzN2ZmFSSEx0L3lqb0xuSlZEZldUT3dl?=
 =?utf-8?B?VG9vTnp3K2p6RG9wR0xNY21TRWJEWGwxNnNWeCtUOGxTQk1ocU9qanE0YkZ0?=
 =?utf-8?B?dW9reENBTlA5djFDM0lTcTJEUWNNRUtiQVM4anJSa0VySHBqOTJzVThtay9I?=
 =?utf-8?B?aEU2RXA3dUEvTWUzZCtuWG0xb1pva0J6aHJ4V1hZcVY5OTJBOS8zN3cxVW1j?=
 =?utf-8?B?d1cyaWNHSXNIWjNoT2xKaTNUSjZzQm9IeGVZS2sxNFE4SUdGRTI2aWVQQk4x?=
 =?utf-8?B?VVFoWi9kVnlCYVJIRGNwN3I1S2F2RGJKK0pWMXhndVJ4U013YzJ3am85d3pF?=
 =?utf-8?B?QWpEUkdnZkJJR3RWdVpqTlFvY29nbXN1NFlMa1dXTUVuUFM2QXpyYk1IVVpM?=
 =?utf-8?B?eC9WTURYRlhqNWVvcm9IY01vQi94RUdVVTRmR01yRlZSc3hxVStoSmFLNkZ6?=
 =?utf-8?B?RG1FZ2xIaVc4L2tWaHJxSW9rSXhDWEZqRW1rcVZKV3pSQUpHZjVEV0FhaWJU?=
 =?utf-8?B?ZlBLK1dYbFo4THpGZjJNa2JVajdPZ2Rjb0JEN2dBT3pjVCtDeitCWmFaREVS?=
 =?utf-8?B?ZVN4NTFlWmg0ODBvditpMXFoTzI3MmFqVk11ZHdveTJvUUVVVE1WU2g2Nm5B?=
 =?utf-8?B?RzkzSUZ6czNPZ3BwYWpXTmFKSUkyeHRXTktQd1lGN3JsSC93KzAvVkVpQVMy?=
 =?utf-8?B?M21OTlNMTDZZMExJaW9aNjJTVldGa0Q2bHlRZnBDQzgxdThEODJwS2tuVDhS?=
 =?utf-8?Q?KlzX5o+KBqY12AGCelDbzCI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5796c7-b27a-43ae-9f11-08d9dc4bba66
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 19:33:25.6175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5RIv1XPVk6b1UPNIOc2fqpGLAXHfuscJa3Hyo4NQxjB3SrauW7p8m2Su8kJn6yIlQUzegunpRujZf+Xd9pF9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "S,
 Shirish" <Shirish.S@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgSGVyc2VuLA0KSSBhbSB3YWl0aW5nIGZvciB5b3VyIGNvbW1lbnRzIGhlcmUuDQpJIHRoaW5r
IHdlIGNhbiB0YWtlIHRoaXMgY2hhbmdlIGZvciByZXN1bWUgcGF0aCBhdCB0aGlzIG1vbWVudC4N
CkZvciBib290dXAsIHdlIGNhbiBoYXZlIHNlcGFyYXRlIHBhdGNoIGZvciByZXN1bWUgb3B0aW1p
emF0aW9uLiANCg0KVGhhbmtzDQotUmFqaWINCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IFdlbnRsYW5kLCBIYXJyeSA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT4gDQpTZW50OiBU
dWVzZGF5LCBKYW51YXJ5IDExLCAyMDIyIDk6NDcgUE0NClRvOiBNYWhhcGF0cmEsIFJhamliIDxS
YWppYi5NYWhhcGF0cmFAYW1kLmNvbT47IFd1LCBIZXJzZW4gPGhlcnNlbnhzLnd1QGFtZC5jb20+
OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpDYzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFMsIFNoaXJpc2ggPFNoaXJpc2guU0BhbWQuY29t
Pg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZC9kaXNwbGF5OiBOb3QgdG8gY2FsbCBkcGNk
X3NldF9zb3VyY2Vfc3BlY2lmaWNfZGF0YSBkdXJpbmcgcmVzdW1lLg0KDQoNCg0KT24gMjAyMi0w
MS0xMSAwMjo1MiwgTWFoYXBhdHJhLCBSYWppYiB3cm90ZToNCj4gZHBjZF9zZXRfc291cmNlX3Nw
ZWNpZmljX2RhdGEgaXMgbm90IHNwZWNpZmljIHRvIE9MRUQgcGFuZWwuICBJdCBpcyBjYWxsZWQg
ZnJvbSBib290LXVwIHBhdGggYWxzby4NCj4gSGVyc2VuIFd1IGludHJvZHVjZWQgaXQgaW4gcmVz
dW1lLXBhdGggd2hpbGUgZW5hYmxpbmcgT0xFRCBwYW5lbCBmb3IgTGludXggaW4gYmVsb3cgY29t
bWl0Lg0KPiANCg0KSWYgd2Ugc2V0IGl0IGluIHRoZSBib290LXVwIHBhdGggd2UnbGwgcHJvYmFi
bHkgd2FudCB0byBzZXQgaXQgb24gcmVzdW1lIGFzIHdlbGwuIFRob3VnaCBJJ2xsIGxldCBIZXJz
ZW4gY29tbWVudCBzaW5jZSBoZSBrbm93cyB0aGlzIHBhcnQgbXVjaCBiZXR0ZXIgdGhhbiBtZS4N
Cg0KSGFycnkNCg0KPiBTbyBoZXJlLCBJIGd1YXJkIGl0IGJ5IGNhbGxpbmcgc291cmNlIHNwZWNp
ZmljIGRhdGEgb25seSBmb3IgT0xFRCBwYW5lbCwgYW5kIEkgY2FuIGdldCBhZHZhbnRhZ2Ugb2Yg
YXJvdW5kIDEwMG1zIGZvciBub24tb2xlZCBwYW5lbCBkdXJpbmcgcmVzdW1lLiBIZXJzZW4gbmln
aHQgaGF2ZSBhbnN3ZXIgYWJvdXQgdGhlIGlzc3VlIHJlbGF0ZWQgdG8gcmVncmVzc2lvbiBmb3Ig
b3RoZXIgcGFuZWxzLCB3YWl0aW5nIGZvciBoaXMgcmVwbHkgYWJvdXQgdGhpcyBjaGFuZ2UuDQo+
IA0KPiBjb21taXQgOTY1NzdjZjgyYTEzMzE3MzJhNzExOTk1MjIzOTgxMjBjNjQ5ZjFjZg0KPiBB
dXRob3I6IEhlcnNlbiBXdSA8aGVyc2VueHMud3VAYW1kLmNvbT4NCj4gRGF0ZTogICBUdWUgSmFu
IDE0IDE1OjM5OjA3IDIwMjAgLTA1MDANCj4gDQo+ICAgICBkcm0vYW1kL2Rpc3BsYXk6IGxpbnV4
IGVuYWJsZSBvbGVkIHBhbmVsIHN1cHBvcnQgZGMgcGFydA0KPiANCj4gDQo+IA0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXZW50bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRs
YW5kQGFtZC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAxMCwgMjAyMiAxMDowMyBQTQ0K
PiBUbzogTWFoYXBhdHJhLCBSYWppYiA8UmFqaWIuTWFoYXBhdHJhQGFtZC5jb20+OyBXdSwgSGVy
c2VuIA0KPiA8aGVyc2VueHMud3VAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFu
ZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
OyBTLCBTaGlyaXNoIDxTaGlyaXNoLlNAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
ZHJtL2FtZC9kaXNwbGF5OiBOb3QgdG8gY2FsbCBkcGNkX3NldF9zb3VyY2Vfc3BlY2lmaWNfZGF0
YSBkdXJpbmcgcmVzdW1lLg0KPiANCj4gT24gMjAyMi0wMS0xMCAwNDowNiwgUmFqaWIgTWFoYXBh
dHJhIHdyb3RlOg0KPj4gW1doeV0NCj4+IER1cmluZyByZXN1bWUgcGF0aCwgZHBjZF9zZXRfc291
cmNlX3NwZWNpZmljX2RhdGEgaXMgdGFraW5nIGV4dHJhIA0KPj4gdGltZSB3aGVuIGNvcmVfbGlu
a193cml0ZV9kcGNkIGZhaWxzIG9uIERQX1NPVVJDRV9PVUkrMHgwMyBhbmQgDQo+PiBEUF9TT1VS
Q0VfTUlOSU1VTV9IQkxBTktfU1VQUE9SVEVELiBIZXJlLGF1eC0+dHJhbnNmZXIgZmFpbHMgd2l0
aCANCj4+IG11bHRpcGxlIHJldHJpZXMgYW5kIGNvbnN1bWUgc2lnZmljYW50YW1vdW50IHRpbWUg
ZHVyaW5nDQo+PiBTMGkzIHJlc3VtZS4NCj4+DQo+PiBbSG93XQ0KPj4gTm90IHRvIGNhbGwgZHBj
ZF9zZXRfc291cmNlX3NwZWNpZmljX2RhdGEgZHVyaW5nIHJlc3VtZSBwYXRoIHdoZW4gDQo+PiB0
aGVyZSBpcyBubyBvbGVkIHBhbmVsIGNvbm5lY3RlZCBhbmQgYWNoaWV2ZSBmYXN0ZXIgcmVzdW1l
IGR1cmluZyANCj4+IFMwaTMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUmFqaWIgTWFoYXBhdHJh
IDxyYWppYi5tYWhhcGF0cmFAYW1kLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYyB8IDMgKystDQo+PiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMNCj4+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jDQo+PiBpbmRleCBjMGJkYzIzNzAy
YzguLjA0MDg2YzE5OWRiYiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9jb3JlL2RjX2xpbmsuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2NvcmUvZGNfbGluay5jDQo+PiBAQCAtODkyLDcgKzg5Miw4IEBAIHN0YXRpYyBib29s
IGRjX2xpbmtfZGV0ZWN0X2hlbHBlcihzdHJ1Y3QgZGNfbGluayAqbGluaywNCj4+ICAJCSghbGlu
ay0+ZGMtPmNvbmZpZy5hbGxvd19lZHBfaG90cGx1Z19kZXRlY3Rpb24pKSAmJg0KPj4gIAkJbGlu
ay0+bG9jYWxfc2luaykgew0KPj4gIAkJLy8gbmVlZCB0byByZS13cml0ZSBPVUkgYW5kIGJyaWdo
dG5lc3MgaW4gcmVzdW1lIGNhc2UNCj4+IC0JCWlmIChsaW5rLT5jb25uZWN0b3Jfc2lnbmFsID09
IFNJR05BTF9UWVBFX0VEUCkgew0KPj4gKwkJaWYgKGxpbmstPmNvbm5lY3Rvcl9zaWduYWwgPT0g
U0lHTkFMX1RZUEVfRURQICYmDQo+PiArCQkJKGxpbmstPmRwY2Rfc2lua19leHRfY2Fwcy5iaXRz
Lm9sZWQgPT0gMSkpIHsNCj4gDQo+IElzIHRoZSBzb3VyY2Ugc3BlY2lmaWMgZGF0YSBvbmx5IHVz
ZWQgYnkgT0xFRCBwYW5lbHM/DQo+IA0KPiBEbyB3ZSBrbm93IHRoYXQgdGhpcyB3b24ndCBsZWFk
IHRvIHJlZ3Jlc3Npb25zIHdpdGggYW55IGZlYXR1cmVzIG9uIG5vbi1PTEVEIHBhbmVscz8NCj4g
DQo+IEhhcnJ5DQo+IA0KPj4gIAkJCWRwY2Rfc2V0X3NvdXJjZV9zcGVjaWZpY19kYXRhKGxpbmsp
Ow0KPj4gIAkJCW1zbGVlcChwb3N0X291aV9kZWxheSk7DQo+PiAgCQkJZGNfbGlua19zZXRfZGVm
YXVsdF9icmlnaHRuZXNzX2F1eChsaW5rKTsNCj4gDQoNCg==
