Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3063CD6E57
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 11:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75BF010EF85;
	Tue,  2 Jun 2026 11:25:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LRbkB1B9";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC2110EF85
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 11:25:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kjxe7uiDNArB91o/CZ3vm+SYxSsh+CeulDBP9/dHRXoA2ZMGY7POZcIdwgZ8FgPxqlUqNAgYaBjnPicagIH8i2UeomLZrf7XQGm6U/y7JPRgqwYJwPV5+jhIJILNDY5kQrLhbod/fqkGijk/XwNxOqDhnFCyPQ1hvgmkSX7uG8E3gVLDMRs6QStm22fF6CMN8Y0uSjk7b358LcSXoY6c9BjSdLClfmmB+AJqkuLO9AxWLZh6ygsyLJj7EsGef7ICw+T8uSqKhRFyx/BBA4apylG+gpGwcB6Akz7XowWJz49rgDRLzv2zyiIjXbTBvBYsbTLV51qxn6gRDKJsLxMOKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4acDUvjkeckWLLwhpMNr3Mz5kjVYbUGGKtdFQMfYtO0=;
 b=EilCuplSuH+y6e9uo1tz4/xMz2+dD1frG7kYso675LZ5pTuq5X1Kjet/xXeXDsEHEQZ+zj05wMsqSnj4hORVQvSfMEGsAW+58JdmuK2BVda5R1sR64wldie+EotNoihxQyeXnPuaETMUftgsHTn4pWrUybh2vKEykFS+FvcRikDjWX8/Ok20ZnYcc5N3P1Gc/weJ4cM7r6iU2hluYTMxibD/4bbuMM4UW5EDJdNt4Xpt5amDf5C6bBIPZPcOTgyz3DD9jNmyLwxnpjRFsIm13Wb9gIFgp3uwv956Z2ytU30KN5lMkfd61mQz8F5w/XqX37EGMAoeOvbsRZyX8Fg9eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4acDUvjkeckWLLwhpMNr3Mz5kjVYbUGGKtdFQMfYtO0=;
 b=LRbkB1B9RxWXRuZH4muRVAXeReLaxmQhqG8X8sM8M4wYznww2bPc8JjuUjfQP6tiOaO+/JvDsBgF6qtBR+B3S6BkCconivYvMGMsLXMWIfh3+pXg7ls/MXcmH6ZMTAp4DEPCfrwUPVPF8DVpHWVHhU5bjpGHeZQJG6YCVGXQmLk=
Received: from IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 by LV9PR12MB9805.namprd12.prod.outlook.com (2603:10b6:408:2ee::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 11:25:27 +0000
Received: from IA0PR12MB8895.namprd12.prod.outlook.com
 ([fe80::904a:1cfc:7595:522]) by IA0PR12MB8895.namprd12.prod.outlook.com
 ([fe80::904a:1cfc:7595:522%5]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 11:25:27 +0000
From: "Hosur, Priya" <Priya.Hosur@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Gopalakrishnan,
 Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
Subject: RE: [PATCH 1/1] drm/amd/pm: smu_v14_0_0: use SoftMin for gfxclk in
 set_soft_freq_limited_range
Thread-Topic: [PATCH 1/1] drm/amd/pm: smu_v14_0_0: use SoftMin for gfxclk in
 set_soft_freq_limited_range
Thread-Index: AQHc7RKTwY2ypZgtJUyvUNJ6nKyG07YrKN9A
Date: Tue, 2 Jun 2026 11:25:26 +0000
Message-ID: <IA0PR12MB889546B03A3AC1DA68CCB606F3122@IA0PR12MB8895.namprd12.prod.outlook.com>
References: <20260507080137.841442-1-Priya.Hosur@amd.com>
 <20260507080137.841442-2-Priya.Hosur@amd.com>
 <CADnq5_OmROsjeOQa89TDM0oeM4Qa-ikKa7JPfwzOiK=DwmKiQA@mail.gmail.com>
In-Reply-To: <CADnq5_OmROsjeOQa89TDM0oeM4Qa-ikKa7JPfwzOiK=DwmKiQA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-02T11:18:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8895:EE_|LV9PR12MB9805:EE_
x-ms-office365-filtering-correlation-id: 03ffabcc-421c-49c2-9dfd-08dec099a55f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|4143699003|3023799007|18002099003|22082099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: zLvPc3sUNJEg6cFbh3nTPmHV9Lo26haPjgdlGfURX7KfsFAnC0J9Akl+QS9F28jEni8cL8XJsF6zWKk8HlwnYaIo2wBCJwtX4jK9d3gZ1012TyJFjC+1nGX1+TO0FT+qs0D+M7mmTHnWjW9mrY2JeGIj/26wxdE/o5faw4atj7PRFU8XTK0wjsByJDwdCeassr7F+NBNVFOVtgA27LNSHECj/UvNudZVdDIhO77pSjBq9VM8dZ1fBf1YLvKUfhArtstieTEfJcwEDFrd7erLaHqo0RelcXfvMb+ZH5hkVwed1nwXEzYBGubqk6/B1KLPY9cHrpL3n8UlU8sckez6HramRE3lch4Vqyr9fe6SHJfgqU8PvhpJSfy+aenZPxpz0OURaiaI6Bfpu9iXp4rygGBeQTnyIIg/6NUGX0cs9/ghYFdTbM3qneFyB3V1Phql//3LYR1/1CO0K7UF92r/E/JUpOQCiC/NmreHx64Mipg+TLYXS/s0YWIagrsYLWDyYpg3t9UxfP5qiHufq/5vkL6IIRBq8K+KsJooIZSKvUGR4rKAX7OqatkZMCfpj0rDbVXSqTsJCvB3Tle5erT2c6qocFJaROjWLyaEQang6+66AJKwy1vk5lA+73ma4KSnikbCp8IgzxGbR+BoNOj9dOgvJs7LQ5rH9o1Wsjp4F5MdBK0FLaK5575ItqK1th47ETrIQIpP4p1UaP52D8UqCUhIv4gVEaMyjxpd7cHL+xLwWrx5gVV2EjMqNUgjgNwh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8895.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(4143699003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnNsZ0FzZm8rTXljaktuMDVPOGw3QXBEb081S3RBeVQ4UXd6cWp4c2d2aU93?=
 =?utf-8?B?M3Q2MHEyUWxPbXBPZEtLdy9wQWJYN1ExVXp2R3VnTVZwblJaRFlhNDVrOVA2?=
 =?utf-8?B?cmRabjRFMnd1alZ3VkhOWXVyOGVUWC83aW9YL3E4blFqVVkvZkorZUlPbm9U?=
 =?utf-8?B?WlU4LzN0RW1XMkVtVy94QmM2RGt0RERxendNaG5zMC9mdDhqWnVuWTVreFNR?=
 =?utf-8?B?eGtERVV3L0Zqa3cvSkQ0a2NFWUlHQWVrTngzck9vdDdMaVQ3TFZ1VnptbHVY?=
 =?utf-8?B?STZSNFJpTlN6bDBjT1huRXpDWTl1NnFnSjJGbVA4YWxEaEFVMDcvWnkwNWdK?=
 =?utf-8?B?eitPRU04NGcxa3BzSkhJeUxIT0lBNzIyMjlvVk1UVXE4MFhyYjBjRUFOdDdL?=
 =?utf-8?B?QTQya3BjQUF4aW83SGxYM2lBQnZjRnZxc3ZEdUo1cHhpY0lRdEdFM25ycDRn?=
 =?utf-8?B?UlZsNWhVMWtJZForNnoyK0JkQ1pmQVdxcld5TE9aZmg2TmZaVEplSWJqbERS?=
 =?utf-8?B?U20zeG5KTDNKWTdaY1Jqa28ydXdTYzR1dXJoTUh0eXM0R2YxU2g4bGJyUGdU?=
 =?utf-8?B?Vmw2N1ZiRllQVDFBMU9IdTZYdkVWMzh6NjJsRDlxeVpqbEpuOUVSMGZ1cld5?=
 =?utf-8?B?OC9idEkxc1lVR2xIVnpZK1REWDl0eHA1clliS25ZNTlscXRoUmF0TXFvbVRj?=
 =?utf-8?B?TDNOKzhlVG80VWluM2EzSkxwQ3g4cVA5eFBzMkFlc2NtM0ZEMDFWdk8xYUJ4?=
 =?utf-8?B?MEpwOWtSVWFwdC9EVkhFWkZaOU5jQ3J3WUEzaHFZVE1peGNXblMraHkrR3Fn?=
 =?utf-8?B?Y0pZdnY5Q3dESTNTSDNkb09xZHZ1VnZ5NFEyc3g4SzBncFM3MHpIa25oOGxr?=
 =?utf-8?B?OEVpUy94NUJnT2taZTVtdG1kVXgvUkdCbXo2ZTVBQW43SEh3V1prS2NNbDhT?=
 =?utf-8?B?VHJCRTR5aFVYK2ZOWDRqVzBPQ3dpTXEzbXVFY1owNjdiVEo3Z0RvRDYyb2ZW?=
 =?utf-8?B?OWlmS0t4czdwN1JRL3YraGNZbmlEQTVNN2YzdXM3SWp1TDdMc2JPbE92N3d2?=
 =?utf-8?B?ZXlua0ZnekJ0dnkxRloyQmhZY2NkUnYyeW14ZGlRdXFkMm9ZaTFzejlneWhE?=
 =?utf-8?B?VGRZZ0FtdjBaZUZrTXd3NFZSeTZOSG9mUGZ4MXRQTzdiaFA1TkVUSS8ydUgx?=
 =?utf-8?B?Qm80YUtnWlpGU0pTUUs5eFlXbGFFUExTTS9CSUlZem5YTXc0RjE1V24zT0Fx?=
 =?utf-8?B?TExjSlNJbjhlQW82aitJb2t4UHduVmJ4QnBQOVBpU2luQkpGTVJlMnBwWWQ0?=
 =?utf-8?B?TVo2KzRJZWJReDlEL29EMURCQTZyV0hhZU8vTjkvc25oalpCZFNWczVCdXdw?=
 =?utf-8?B?WUY5eHNwVitHa3p3RElQb0dpbTRra0dxdzByTjVBMW9GZWVlSmJPWmR1SGtD?=
 =?utf-8?B?RmovSE9IK0hUOU1uU3FpNnRZaFZ4ekh2UEYvaVpzdU9MaC91Znh3dEozNDRj?=
 =?utf-8?B?WDBPRXg3VS9MNUI2RXlLU3l6SFArUWlYeEZyWDFzcG82MXJkdG96NGUvUUl3?=
 =?utf-8?B?enFHbURsMzRSZTNSNHhsWnBNbUdpb29UUWRKcUtzbC9GOWQ5Y3RXYzVyemNj?=
 =?utf-8?B?d1JUVVFjVVdZMWZaM0thRFRyd0pqenJSTURlek1DeDlqbjcvaFdCVEQvZlpl?=
 =?utf-8?B?SW5iUDFtTDdibDRKOUJxNG50QU5kcVN6VW9aYTl1NDE2cm1sUEs3b2tLYmhk?=
 =?utf-8?B?Y280MEJhTGVYR0lvNTh3K2ltTHV1YUx5aTNIRllWdUIxcmJ3QThoREs1dU5B?=
 =?utf-8?B?OFhxL0VzWGpKZjV0ZlVReFgzRzdEZ1ZNM2xXeWdsdDVWVVcvQ0FiWS9sblor?=
 =?utf-8?B?b3cxZk8rZWN1R0JKTEk3TDdvRkVxR3hMbXpBdWQvNlBiMTF2RWczUmV6Mm5r?=
 =?utf-8?B?d0pnSTVHSHFqcGRQMUwydG1iV1kvYzB1NVFrcUxWNmF3Z3lSSEpPc0Rvdmt0?=
 =?utf-8?B?ellHaGlmWjA1Y1NuY2svdjZtNWxiS0I2cWJlR0JBZFJGQTZ0eExPUi8yMVdK?=
 =?utf-8?B?a1piTG1XeHA4aHIvR0llcTNVVzRmVDlwWTF3aDEvQTFhT0hpL0ZxRjlXNVl3?=
 =?utf-8?B?MG1qeE9GbVZWMzdEM1BXbEtMbXcvNEN5RjZzYlg1THp0WjYrd3B5NnBzTmtt?=
 =?utf-8?B?MU1Yc3RJcFlpS2swcFc2ODVobTNJbUx5dVpqbGg0N0VaSXdFZUxjWUY2USt3?=
 =?utf-8?B?ZTE2bzRXVFJmYWY1TFdRS0V4RWt0b2lab1htUnZUYVVKbFlodDM5N1BXQmZY?=
 =?utf-8?Q?BCkVt3mLAGt0N2WMfB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ffabcc-421c-49c2-9dfd-08dec099a55f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 11:25:26.9618 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9B0kczTNrruyZaUM4V/nTOYFOR4bfdoyO7qB+t4W8RDoi3czCLXtHCNQbvLLXvuhXgNZC7At/6jGyRDesGT+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9805
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

QU1EIEdlbmVyYWwNCg0KSGkgU3Jpbml2YXNhbiwNCg0KVGhpcyBwYXRjaCBoYXMgQWxleCdzIEFj
a2VkLWJ5LiBDb3VsZCB5b3UgcGxlYXNlIHBpY2sgdGhpcyB1cCBhbmQgYXBwbHkgaXQuDQoNClRo
YW5rcyBhbmQgUmVnYXJkcw0KUHJpeWEgSG9zdXINCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KU2VudDogVHVl
c2RheSwgTWF5IDI2LCAyMDI2IDY6NTIgUE0NClRvOiBIb3N1ciwgUHJpeWEgPFByaXlhLkhvc3Vy
QGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IExhemFyLCBMaWpv
IDxMaWpvLkxhemFyQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29t
PjsgVmlzaHdha2FybWEsIFByYXRpayA8UHJhdGlrLlZpc2h3YWthcm1hQGFtZC5jb20+OyBHb3Bh
bGFrcmlzaG5hbiwgVmVlcmFiYWRocmFuIChWZWVyYSkgPFZlZXJhYmFkaHJhbi5Hb3BhbGFrcmlz
aG5hbkBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAxLzFdIGRybS9hbWQvcG06IHNtdV92
MTRfMF8wOiB1c2UgU29mdE1pbiBmb3IgZ2Z4Y2xrIGluIHNldF9zb2Z0X2ZyZXFfbGltaXRlZF9y
YW5nZQ0KDQpPbiBUaHUsIE1heSA3LCAyMDI2IGF0IDQ6MTnigK9BTSBQcml5YSBIb3N1ciA8UHJp
eWEuSG9zdXJAYW1kLmNvbT4gd3JvdGU6DQo+DQo+IEluIHNtdV92MTRfMF8wX3NldF9zb2Z0X2Zy
ZXFfbGltaXRlZF9yYW5nZSgpLCB0aGUgZ2Z4Y2xrIGZsb29yIGlzDQo+IHByb2dyYW1tZWQgdmlh
IFNldEhhcmRNaW5HZnhDbGsgdG9nZXRoZXIgd2l0aCBTZXRTb2Z0TWF4R2Z4Q2xrLiBVbmRlcg0K
PiBwb3dlcl9kcG1fZm9yY2VfcGVyZm9ybWFuY2VfbGV2ZWw9aGlnaCB0aGlzIHBpbnMgSGFyZE1p
biB0byBwZWFrIGdmeGNsay4NCj4NCj4gSW4gUE1GVyBhcmJpdHJhdGlvbiBIYXJkTWluIGhhcyBo
aWdoZXIgcHJpb3JpdHkgdGhhbiBTb2Z0TWF4LCBzbyB0aGUNCj4gZmlybXdhcmUgdGhlcm1hbC9Q
UFQgdGhyb3R0bGVyIGNhbm5vdCBjbGFtcCBnZnhjbGsgdmlhIFNvZnRNYXggb25jZQ0KPiBIYXJk
TWluIGlzIHNldCB0byBwZWFrLiBSZXBsYWNlIFNldEhhcmRNaW5HZnhDbGsgd2l0aCBTZXRTb2Z0
TWluR2Z4Y2xrDQo+IHNvIHRoZSBkcml2ZXIgc3RpbGwgcmVxdWVzdHMgcGVhayBwZXJmb3JtYW5j
ZSBidXQgdGhlIGZpcm13YXJlDQo+IHRocm90dGxlciByZXRhaW5zIHRoZSBhYmlsaXR5IHRvIGNs
YW1wIGdmeGNsayB1bmRlciB0aGVybWFsL1BQVA0KPiBwcmVzc3VyZS4gU29mdE1heCBoYW5kbGlu
ZyBpcyB1bmNoYW5nZWQgYW5kIG5vIG90aGVyIGNsb2NrIGRvbWFpbnMgYXJlDQo+IGFmZmVjdGVk
Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBQcml5YSBIb3N1ciA8UHJpeWEuSG9zdXJAYW1kLmNvbT4N
Cg0KQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0K
PiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTQvc211X3YxNF8wXzBf
cHB0LmMgfCAzICsrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9z
bXUxNC9zbXVfdjE0XzBfMF9wcHQuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211MTQvc211X3YxNF8wXzBfcHB0LmMNCj4gaW5kZXggYzc2YjFmMDc4ODVlLi4yZmUwMDZkZTky
N2EgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTQvc211
X3YxNF8wXzBfcHB0LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUx
NC9zbXVfdjE0XzBfMF9wcHQuYw0KPiBAQCAtMTIzMSw3ICsxMjMxLDggQEAgc3RhdGljIGludCBz
bXVfdjE0XzBfMF9zZXRfc29mdF9mcmVxX2xpbWl0ZWRfcmFuZ2Uoc3RydWN0IHNtdV9jb250ZXh0
ICpzbXUsDQo+ICAgICAgICAgc3dpdGNoIChjbGtfdHlwZSkgew0KPiAgICAgICAgIGNhc2UgU01V
X0dGWENMSzoNCj4gICAgICAgICBjYXNlIFNNVV9TQ0xLOg0KPiAtICAgICAgICAgICAgICAgbXNn
X3NldF9taW4gPSBTTVVfTVNHX1NldEhhcmRNaW5HZnhDbGs7DQo+ICsgICAgICAgICAgICAgICAv
KiBTb2Z0TWluIGxldHMgUE1GVyB0aHJvdHRsZSBnZnhjbGs7IEhhcmRNaW4gd291bGQgb3ZlcnJp
ZGUgU29mdE1heC4gKi8NCj4gKyAgICAgICAgICAgICAgIG1zZ19zZXRfbWluID0gU01VX01TR19T
ZXRTb2Z0TWluR2Z4Y2xrOw0KPiAgICAgICAgICAgICAgICAgbXNnX3NldF9tYXggPSBTTVVfTVNH
X1NldFNvZnRNYXhHZnhDbGs7DQo+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAgICBj
YXNlIFNNVV9GQ0xLOg0KPiAtLQ0KPiAyLjQzLjANCj4NCg==
