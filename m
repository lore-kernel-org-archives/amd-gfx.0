Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B22CD5BD5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 16:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 175EC10F497;
	Thu, 28 May 2026 16:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L5yO+FEL";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2327110F49C
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 16:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnEuDhHmakh6fF/GE1DtpfLqm6yfNcGT68ndBaSo5JDWQPBwytWT3Qd28n5aJurt01VZtgNnMbcNgWpkDLfT/VpNe7R1H9ODAmPPXunt4EjJX46o6zqjXyrfX/IkXhRnijz4lSYqV+g8H3azQT72Kq92OShdQ6VK5SPiblxMywrrlBcnENnXuE07ZJwOEjBwNgnNlZFvddzymYVp/XO/YQYpHXc5ur1/4+Wgf38LSTojaJTKkDCfcbZPIPWwBevDKdjNjpQJR+zmKsu8dKw5fmqCznb81neI/zdM9OHitg4ufbhQNA7P1tXAcfclN2Yi/eNTREl3ZYTjjCw7lDwOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ASxnBqcW1+Jfq0dKDqv7p1H+MRlW9HsmkjLm9TEcfc=;
 b=DMRGsyORgnVhCdsEw8Nczv2OXA6RsLDITNlC7L0omoLQEF8YpzmWSIkpNQLnwyREysd6wNl/nPzmJjq1mXNVujgADoVcxajNQB9X0azVO3YNi/dyK543VxU09P4rvc/Gulmc7T1HO/0+AuGsYXk1h6ZY1I/4ZQSKgVTaTc+xorb87ldE02nTmXVzYtC8pt4595YD4mbcZvWsMc7v2WKL442EujTVQFBPIXX6H4nNR7J68je0I6M8dGO/Kq5n013wmGxTOOYjBNUGcZPwnZW0IApvGCTMY9MexVRDy0stTP92cd/BxOOKd3slKrkNsThZy/FL6deo/5WigYuYuCr1HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ASxnBqcW1+Jfq0dKDqv7p1H+MRlW9HsmkjLm9TEcfc=;
 b=L5yO+FEL+nol0u0I930LTOfgZYOFVxST8F8GIOkZAsSt2KJ7Zlf8hk/L/TdwT30ts9+4rytQMV+sb5Fz91/7Nx0Ss/ZqKKEQb9Lp8LUQaXauHX/5hbVB3A3xV0oFm1KKfl8zS96xCLv1bpnsCJeX45UFBmmZqnku5nX3NP8B7b4=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 16:54:23 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 16:54:23 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sdma7.1: fix support for disable_kq
Thread-Topic: [PATCH] drm/amdgpu/sdma7.1: fix support for disable_kq
Thread-Index: AQHc7hGEarArh2AWuUmQ3Gj3y7cCmLYjhgWAgAAi4/A=
Date: Thu, 28 May 2026 16:54:23 +0000
Message-ID: <BL1PR12MB5898C6181FD47C0577AF80C885092@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260527194603.3976381-1-alexander.deucher@amd.com>
 <CADnq5_Pi8=99aTiNP2zj6jdR8072_W4b4+CNbMc86M1q8qRQ_w@mail.gmail.com>
In-Reply-To: <CADnq5_Pi8=99aTiNP2zj6jdR8072_W4b4+CNbMc86M1q8qRQ_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-28T16:53:35.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|PH0PR12MB8125:EE_
x-ms-office365-filtering-correlation-id: 0d4d1af7-cdb4-40dd-39e7-08debcd9c520
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: kvyU3/34nkq6bqvXDKC14ch8CZbqyzVmoi1xdsVzkWNdtb36i0TxaTnhlHX7ChnHxzwoXIVBpGwyUr9glttAzLIPGJtNGgP5R85+iqcFGZiQ6pwFbQZDG71blllOBmKiw7eh86UgkmVQI1RQuxVErWi56cGBfE0gz2F+/2PmgS8HkVU8yh8ZEmMXZMW27oSwBNJfJHXUDlZU2eRdkI6QrH572dQXbBxQSvC4mNJikBDl9ghTcV7gix5kN0fkMSrr5kAaW41IiuWlcUBmy3NffzvcZYlhUgk23nt3bQD+xKCNs06IRTLgXH5UVCDyOCOrC/xD4VAeWb1tSdUXZWg/Wk38LkOVUNfvH1yp8jJ0s8TvgoxOEDEHjYPqg8su3I2staShU0Jv6pPj/HER0t91uuwaPRYlPl/EMuVN5XkcUmus0meR7RG270C6OAH2Ydv1iIg2Lm5nl3DaZkUEbW3vhcRwr4ml61o02Ju0F6e/O+/oGss/RgzPoDHJGJADP9TStHq5eF0/d5thdhnEgDlVBLaxp7sRq4WP7BmC9rZT9iDb02mS7HyDeqiH+iAXleCcuYHt4Bslu4VKnBTIEY9DR1YiQr0l1giiRWYG0Etuzz/StJL7Y2aykS8iKQxAvGa5j8w3Po3OtNqpyrq8G9z5XUrQG79FHu5rKMeWvyuXMWCEtIe/XiisHDiGcawYi+FJa5KhKHGt6Inl5IlkHACTDVLzLWgx7pPTdpQqdK/lq0zdvSB2aTCpyN/8BOVnrZf+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjNZL091dGpmNmhKenk4V3RvMUpxMC9uRjZQRlhZRGhEZCszb05aSGVQaVov?=
 =?utf-8?B?OWFLY09WOXBBVThwdHFjSytsRjdzUCt1TWdGSGtHNDFWaWl1b1V5OHVGVksy?=
 =?utf-8?B?Y2l2cWpQOXV0RHV5aExsRUFiRC94OE5jZXBEWGtpclo0a3hhakpRamZQRTBE?=
 =?utf-8?B?cEVaN2hBVS81T3FLVFRWb0M1TUVhdkMzM1JOZlhadjU2M3pLRktxeWRNVFNj?=
 =?utf-8?B?LzZTcytNZEF0a3AvVGk5clowVTJJQVVJZ2xPMjd1R0pSazV4YVE4WmRMZnpu?=
 =?utf-8?B?b3Vrd0wrSngrK3JGbDQxOW1wSmpKOE9YOEhPQnFJck01enZiMFFMdU5IbG03?=
 =?utf-8?B?UDFRMDdrUGdlUXdhNnlVUkZoUXJUcjgvUVhGSGJ2ZUhCWWlXL2dNSFlTa0Fr?=
 =?utf-8?B?Z0VPRUV5dDB6V2V5eFl2SjJod3BObkRIbHpHcXdVS0orWTcyRVZETW5HdFlH?=
 =?utf-8?B?V05OUnZlRXFUUDI2UFcwWFF4dTd4U2N2ZzFpZjdHcVZwcTZGSFY2RFh5SDJO?=
 =?utf-8?B?Nmx3V29UMm5OQ3Q5MHZ1VTVoQ0w5RXRYakdOMURncHAvSHpGdDJ0TDdRczNR?=
 =?utf-8?B?V2FnYTYyZDYrNGlmVzczeWdGVUh5Uk0reEFSUGhCem9rcGxKRzhhY21wSSs4?=
 =?utf-8?B?NjNIWXgvR2lwM3RFMDl3ZFRsdXlJK2pjYTNjc3lhamlqWXBlK0RxRjJwNXRx?=
 =?utf-8?B?SENoeWNXSHZmcUZFRS9aZWlhLzVDcUFRai9XeUxTeFZteVZtQWN5dDAvN1ZW?=
 =?utf-8?B?MUs4SWw5bHFrdWZHZ3Y4YmNWbTJWQmtGR3pLS1YyMkNwZ2w5TmxXV1dBbDlx?=
 =?utf-8?B?NXNKKzNPcWxtUDhqWXdMc2RaSWxaUk9iSHpMN2xxVE9OWlZqZmhsdHVVSXZJ?=
 =?utf-8?B?WklPQ1ZTcVhHRVVnM1p2eUtaTVhXR3lkRVdmZDV2NDl5TkRhRmdMRGZMNE9D?=
 =?utf-8?B?TDF4bEpEdmtKQVR3ZTB1NFl5cHQrZDZYVnlSZWpXU3JZWG1jaEFEL0F0VmFn?=
 =?utf-8?B?eU53MGx3R3d2R3loaWJYYjBOY3Z3Z2lzWGFjWmNSR2Y0V2hDdC83UTJPTHNp?=
 =?utf-8?B?cTRZM04wa3RvS0pVN3dwaWUwUk5McnJnVEkxRnNQOHdkRnM1azkrNG9XN0xz?=
 =?utf-8?B?VnRTQjkwbGpTd25MUVhqU2VBbmxkaDFLeENjRDJDbWJwaFZwREtwbXdvdEVj?=
 =?utf-8?B?UzNUNmdUNUdXL203NTQ0TXRRakhGTkJpSCtQM1M4djFySk9lSWFLU0pkT0pt?=
 =?utf-8?B?R0pkQXFWK2ZKV2FHcjBOcFRvMUN6RG5oRXFxU3Z0NzkyK3Nya3VjcVIyNGlq?=
 =?utf-8?B?ampUSC9UamdRb2lLRjhhdHlwbmZUNzhmc3dweFREeWc1eC9EaEkxVHVvUFdW?=
 =?utf-8?B?cTFjOGhQNHZpZmlwM0w4T2sySkxXbHhXV2p0OExLck5ITDEwY2M3ZjNWbnBV?=
 =?utf-8?B?Ymh0U1RmSmxJb0NrQ29oWmN2S1RnamFYZTVUY2VJZytZR2pySkF2aitJZ2xr?=
 =?utf-8?B?T3V2TlR0TlNMWmlJYUtielJxTTNGTFo1VUxRTVoxd1IwaldOMTQyMUNRNGZB?=
 =?utf-8?B?Y1VDaUhWbFlBQTFtcUNBbGVST1VPc2hMbmkxUDZialNDanZncVNwRkVSMGM3?=
 =?utf-8?B?MVVZUXJMYVRZNEQ1U1FRejg4dDEzYVAwRXdxV29kdWlZQ3RtTXMrVFB3bjRL?=
 =?utf-8?B?azZheExsM0RtOHNiZmdRTXZVaDQ0RmdvOWF3cUNaMTZNbitMelBYMG51TTU3?=
 =?utf-8?B?RXRZUkh5TGR0RU1uSGxIT1F0dFM1VUpjdkd1dlNCL3V1SjRKY3BzS0lrby9I?=
 =?utf-8?B?YVlMaDNVQWpWdUV3Y3prcGVJVXFyZmNxWWptVmVLb1ZLUThuOFRtOElIVENN?=
 =?utf-8?B?bmM4WkwrOG0rQTZpbE4raEQ5eDV0RWpkcjZub3lSenB6ay8wRXM1dkoyVUVp?=
 =?utf-8?B?dENEWmQ3ZWNNYkV3bzgvdDNYdGlScUw2WWU0Zi9WMHlHWGlvSVljZFp4MHFU?=
 =?utf-8?B?RUM3dG93MUVmMjA4TnlBKzJOdFlDRk9uSVZzcFduWDd5Y2tROEFwNmcxbGFj?=
 =?utf-8?B?c1FMa1VuZEZ3aGQ2eVBYaDM5eGJnVStjRGU4UWllUFB6VnB0dkZmTHpITUJC?=
 =?utf-8?B?MFkzMktLVUVCZHlCekNQNjB3Nzk0eTRmdy9Bc3V4d2pNR3VIMnVFNmhGL0tz?=
 =?utf-8?B?ZzBzRmtuSlpQWDNlWWQvc09ENDBkOHFxYW5OZUViQnpLd21CQ1AzYlJ6dkd2?=
 =?utf-8?B?S0ZLR1pjQTRrc1pUTnZtM0RFNWxqSGd2Skh2aEpKYkgzcXhhOFN1SDNVeHgw?=
 =?utf-8?Q?FW77cg8XL3UZ0OFKT7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4d1af7-cdb4-40dd-39e7-08debcd9c520
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 16:54:23.3865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SVdCO1GfzhxpkeAh+Mr5hU2gkbU3HEhLtjDjivCZ8OGQbvkkz+BYyBI/HtZ9vX55HWTwF+SSrHJkk0CAnib7Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125
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

QU1EIEdlbmVyYWwNCg0KUmV2aWV3ZWQtYnk6IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNzZWxsQGFt
ZC5jb20+DQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1n
ZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBB
bGV4DQo+IERldWNoZXINCj4gU2VudDogTWF5IDI4LCAyMDI2IDEwOjQ5IEFNDQo+IFRvOiBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1
L3NkbWE3LjE6IGZpeCBzdXBwb3J0IGZvciBkaXNhYmxlX2txDQo+DQo+IFBpbmc/DQo+DQo+IE9u
IFdlZCwgTWF5IDI3LCAyMDI2IGF0IDQ6MjTigK9QTSBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gU2V0IHRoZSBmbGFnIGluIHRoZSBy
aW5nIHN0cnVjdHVyZS4NCj4gPg0KPiA+IEZpeGVzOiA4MGQ0ZDNhNDViODYgKCJkcm0vYW1kZ3B1
L3NkbWE3LjE6IGFkZCBzdXBwb3J0IGZvciBkaXNhYmxlX2txIikNCj4gPiBTaWduZWQtb2ZmLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjdfMS5jIHwgMSArDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjdfMS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc2RtYV92N18xLmMNCj4gPiBpbmRleCBlMWMwYTRmZjBlN2ZmLi5jZDk2Njg2MDVhNTAx
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjdfMS5j
DQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92N18xLmMNCj4gPiBA
QCAtMTMxNSw2ICsxMzE1LDcgQEAgc3RhdGljIGludCBzZG1hX3Y3XzFfc3dfaW5pdChzdHJ1Y3QN
Cj4gYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykNCj4gPiAgICAgICAgICAgICAgICAgcmluZy0+
cmluZ19vYmogPSBOVUxMOw0KPiA+ICAgICAgICAgICAgICAgICByaW5nLT51c2VfZG9vcmJlbGwg
PSB0cnVlOw0KPiA+ICAgICAgICAgICAgICAgICByaW5nLT5tZSA9IGk7DQo+ID4gKyAgICAgICAg
ICAgICAgIHJpbmctPm5vX3VzZXJfc3VibWlzc2lvbiA9IGFkZXYtPnNkbWEubm9fdXNlcl9zdWJt
aXNzaW9uOw0KPiA+DQo+ID4gICAgICAgICAgICAgICAgIGZvciAoeGNjX2lkID0gMDsgeGNjX2lk
IDwgZmxzKGFkZXYtPmdmeC54Y2NfbWFzayk7IHhjY19pZCsrKSB7DQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgaWYgKGFkZXYtPnNkbWEuaW5zdGFuY2VbaV0ueGNjX2lkID09IEdFVF9JTlNU
KEdDLCB4Y2NfaWQpKQ0KPiA+IC0tDQo+ID4gMi41NC4wDQo+ID4NCg==
