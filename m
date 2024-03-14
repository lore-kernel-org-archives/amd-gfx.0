Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBF1C54E58
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 01:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A186D10EC9C;
	Thu, 14 Mar 2024 01:33:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z+Y5y0Wn";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45BC210EC9C
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 01:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtR46+lav161lNk2cz+7OPEWYxU1GLhRYbKncIzTZMkFELOOlOMpVvLB2H+EHhEYAoa71bDV5K8djf4iTC2DpTwugIvjJcjncYz1ohU6lNRyLWtJcC/K+7zTiuLk4U5AfEWIPLkb68UWZ69IClgYKfEknJw9OdhBvdwuNb9lVKUNlnlv6K51a/ReOdRVmY8z/3hGHPTn48yLV+iaN30qyjkNyflM6nXN/RPMZKLAmDi3AQsclckkgy51V0pwManZReLqDbrxgi9dDYDmk2cPm3ps2e0cSkCDYsygm73iPGhQqP5VyZXc0CA/8y32+q1sB9KPIWMLgRKvIgXv4Uzltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOLbqw99CMWYs6xPXEICcKrXHd5wtLXvNY8YxfSGfw4=;
 b=iBmoLZ4yFCL7tYx6r/g83lX9IWSKAXoYkELjjfwWWpXvQfNujQhIA6dvnvgmnJW78Vr/3+eCFTQ1B2xuHhMV0x0ph1I18yvhGRiMldI1def6LG6V50WzFC6e3dFxGs/88PVChT7T1QXyfA4aWqMc6XB67u78/HPkg8MhLW3kgjOEtnW8NW8c2vChzcWc25TbLtbh1+SYhbRCE8KCynwmHcnYnqKiI5sbTWRez2Vqs5HS1PFGCiwGB26Fn83lF3tYrBamGqmt9yJ4f2hLOqqbJRfnZFugVIhC40CVmBNoLcatWM6q86maaswNWQDW1FOXnkfAXH4AJLrJt1+ZMZaF+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOLbqw99CMWYs6xPXEICcKrXHd5wtLXvNY8YxfSGfw4=;
 b=Z+Y5y0WnzZFkBrJWBB3ulJpPLrFrN67H9zXarUj/CHDzPkCAHwpizVXVSJyenjW3psskxmfvI6svUp0OmtjTz0yx6iV6TcNvO8OK1VkUk1YRxlzjIdLo5hy9IGrtXnG8gKh/LwyxK0LkjB1ru4sEd8Ybz18KSwLhnS6rHdmmAZ8=
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 01:33:47 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::950c:8c43:3454:884b]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::950c:8c43:3454:884b%4]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 01:33:46 +0000
From: "Lee, Peyton" <Peyton.Lee@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>, "Ma, Li" <Li.Ma@amd.com>, "Yu, Lang"
 <Lang.Yu@amd.com>
Subject: =?utf-8?B?5Zue6KaGOiBbUEFUQ0hdIGRybS9hbWRncHUvdnBlOiBwb3dlciBvbiB2cGUg?=
 =?utf-8?Q?when_hw=5Finit?=
Thread-Topic: [PATCH] drm/amdgpu/vpe: power on vpe when hw_init
Thread-Index: AQHadTtmZPKIR7z+KUKKDKPyWJhnTbE1pxOAgADLt0A=
Date: Thu, 14 Mar 2024 01:33:46 +0000
Message-ID: <MN2PR12MB4373845FF59F1ACC83AAEFC986292@MN2PR12MB4373.namprd12.prod.outlook.com>
References: <20240313114451.1592772-1-peytolee@amd.com>
 <CADnq5_OTwaLWJ9LiicJu-hO+WDF6fPB5PFQWzAqopyrDVn6R5Q@mail.gmail.com>
In-Reply-To: <CADnq5_OTwaLWJ9LiicJu-hO+WDF6fPB5PFQWzAqopyrDVn6R5Q@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=05ac1f45-a8b6-4be6-842b-edfacfa31099;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-14T01:26:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4373:EE_|SA1PR12MB8096:EE_
x-ms-office365-filtering-correlation-id: 49c7b5bf-bd65-4c8a-c188-08dc43c6cb10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MHUWa+XEB+n0APiyCFpnI5FpqlGGkV3jtzPzL78xrYTIBPhob3D7DiCON3x1MGEf5fe5JgFZ5tOybLbFzEbQ78VilWdg2wf2aMmvwr4WFnvEllNiv/IbYtTHwgNfySgjh5pRnQuVLQXF89q9U/MzzZk5mzP5O3lgxaB9LjRRhpJc7fBsPcUZV+j/t9SpNFAiM2sYpzVpnCruZx9Dk/o4gm1mNrpcKujAULEgOdZmHlqXEOR74QCmPQeY1G3qrf39G7YbgTMcB8KYkYB2hb+9UBnxVZdqdMeaGgD7srTdxkr0Lxv1t0LoDARCk6YM7oSNZZKJRS7VyLzx+tgqmq9P73C3Fqqhy1O0tXahrL99yq8L0UgujuJRUcCYJNDzgOkk9/D4EVdBo/ycD7rV4Zjt+iDKkBuklzasJY5BRKQrgEVcnQ+9sh1FCRlU4qCtovstpfruYzGWusVEXE/BgJ/EiYsYfQHvJMwmel+k5EaQ/WegNp551lg88ii5Ma2EPYsL7TlQf2X2pJM/xYU98/obfQ9YTHyZ49HSDllD0A9/VyIShYbOy77SP/sF/X8iU4985dAQz5aQuMUpG6/pRDgVA6KJWivAE+EQPUNpduZfg8elgIdPJ7r1p2LHDULD8GvV60xH4K9STZs4yQUyi4eYpzggd42qYRpBxplLPQVZRTNGHAxaaelEOAbc5h/NoE6drL4DXgYcYUqwAT9j2eokfE0NCeHy7HdyanepCflwsLs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:MN2PR12MB4373.namprd12.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUlCTWV3bXBnRkttL1lMS0ZBanIyZlpxZUxReTk3a2Z2ckJPRjc5MUsyMGFM?=
 =?utf-8?B?bTBDbWp6N1VvOFV3TnI1QWJadEZlaVJPa0x6UEF1Unl6SnlVNnQ0YTBSRFpB?=
 =?utf-8?B?czVqS255YjhvSWpFZkk3eEtBWWhVa0FzUlB2Ykk0UmVRZTZLM0ZXS0tkang5?=
 =?utf-8?B?MzFmQ2xCemJEY2RjTGFneWswMzlKc0hGck4xem94Y1grWjRzbUFPWnZvSkU0?=
 =?utf-8?B?ZVdjOU54WXhBd21PUE8wMldMZ2ltN0pJOHBVNkxZcGxTZ3ZHSFNMWXpYb3Fh?=
 =?utf-8?B?RjQ1L0k1VDd5TXZnRGhWQUthTzE5UDB6SWhTMThwQXhUblE3V0VxakRhL0FD?=
 =?utf-8?B?SGZCSzh5dExXaFZMVnI1VFdndXgwSXE1QStsdlRIanJOOERTV210YkF2UkVh?=
 =?utf-8?B?MzdUcll1RVhrY1FUU3pHWTBHQkVEdWo1TjBKdE9xQWRDU1dlYkswK3hZTXFO?=
 =?utf-8?B?U0UwOFhhZGxmWlBsb2h6S1FEakc5VjVoNXRYYkhsSzdUdmw4MUpvUGpUMDBp?=
 =?utf-8?B?SkQwMVdRbUpzYS9GK0QyMXRkR3lTODdBRC9wZGdCaDdtaitIeU5CNld3cVhV?=
 =?utf-8?B?aFVadTUrclhqYWg4UENHUE5waGRWY3MyMjM0S05BZHhlWW0zdlN5R0h6V2ZV?=
 =?utf-8?B?MHpPYnNPb3JhOGp4WmdWQWVQbHprSEJ0SDFjVWdLZDBrL015WlBOQzJjZDFB?=
 =?utf-8?B?Mzg0d1ZScnY5V3MwT2orVzFaUTdaVFBjb0pwSXkyOHZnclh3c2hoK1ZQMnNG?=
 =?utf-8?B?ems3YkllZWE3eXd0SXB2VkNDR3JPTkFUMk4xaElFQWY3Q3pHa0JUUGFGc3la?=
 =?utf-8?B?cjh5NG5ybitob25obTZUbCtTQmZxSmZVQ1hlOTNSR2xRNDgvMFBQbm1CRUE1?=
 =?utf-8?B?UEd2S29EcVhPcVA1djJCRnFySUczM1BPZlg5ZFlia3Q3a0REOVRRcUN5V1RO?=
 =?utf-8?B?WEQ0UXNOZmwrbWRDK3lNc1VzZDhZN3AzTyt3ckFOZmp2Uk91R0UvbUhYT3RY?=
 =?utf-8?B?eWQrS0Mrc0VGbElRbmdvQndjYlcwekZjc3JLb3hDYkJhMm5pV3VEMXRSOWVV?=
 =?utf-8?B?VjlXWTZTdGg5WmRDMzhBUUEvbzhCTWVKeHN0U2NKQzFEVkc0eHQ0a2UzRW9q?=
 =?utf-8?B?THNsN24yMnR5MEtRWnRyclo5YXVDcDN4QWp4ZDkrUHhsKzlNQjFjRmhxbXZz?=
 =?utf-8?B?L0hjZXUvTUkxYmk1MS9aMlpzSmhldzh5eTM5eEhDRDZ3MEtkNEgyZzZETnFp?=
 =?utf-8?B?cVdlMTdNd2ZrWFV2bHJiRWRZTC9WOXN2L2pzcTNzNmIrMEFCWGVIbGlhZGNq?=
 =?utf-8?B?SEprM0F4UFlZeXVIdmtNV1VnMGpqV0RZZWI1c0lydDVCUTNweDh3L3NqeUhC?=
 =?utf-8?B?cEFXUStJSHorNHBsaFp1ZHZyRWZJdTQxQ0ZlOS9FdFJwN0YvRHZjNnc0ZmZX?=
 =?utf-8?B?V21COE9randyZk1UTzVHbDh1NUdFaDdMWEdZQURpTFdzd1MrT290dWpteExF?=
 =?utf-8?B?Nnk3OHZpOVVGcW9NQWp4MjFrcWFVcysvNUg2VFRhalFlWERyRklNYUtwZUlk?=
 =?utf-8?B?RTFlTHN2dG14dVN1WmUwUS8xek9qNXhjNUo4YVFic1ZKZEtmQ1Aycjlpem1R?=
 =?utf-8?B?TWE3S0diT2xvVHJHYjZmMXJuNVJ6Q01MYmRWcGlTZ0c2WE5MaU1kbG1yOVF3?=
 =?utf-8?B?c1d0QThYc1lpcG1EOWlqRWpET09hWWMvT3JPY01pdDh4cUU0UDZGK283clNW?=
 =?utf-8?B?M25mT3RkMzFyaVBobWxIam5rMkN0SUhYb2FCT3RWYWd3aWc3cnJ1UmttWmZY?=
 =?utf-8?B?a2ZveDJYZDNhR1h3UmlhZmFwQ1l3K0VuUzY0OHJZV05hRGpRWk4ySUNrSXRD?=
 =?utf-8?B?elI3N3U1TnZHNUFINC94OXV0RytkTERyNDgwc0x0NWZhL3paTWpzYVV3TXls?=
 =?utf-8?B?dC9WNzh6VFFEZUIycFRyQysvOFErQ0puZ1k2V0pUUHZmVE42NkhyQkhFUGlV?=
 =?utf-8?B?VjlqaUptTWgvQ09tL0h3dXJaWTNIZzdwRnpKWmlCL0FTcU82RDJoeGl1bmZM?=
 =?utf-8?B?RE1VbjRGYUl0SXNBZWVqcm5LbWRXbmhBdys4TjlDbi9JYnVUY2cxNU9Kczly?=
 =?utf-8?Q?AKAA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c7b5bf-bd65-4c8a-c188-08dc43c6cb10
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 01:33:46.8670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hMMA8Zh75q7Z+k6XDcfjZjlUhPfFpZ6QmBva8y/9QI9/WyT/98igTn71cL1bAwQxnWmJ+HlsPAeuyEK3ONdtIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEFsZXgsDQoNClRoZXJlIGFy
ZSB0d28gcGxhY2VzIHdoZXJlIFZQRSB3aWxsIGxvc2UgcG93ZXI6IFdoZW4gdGhlcmUgaXMgYSBz
eXN0ZW0gY2FsbCB0byB2cGVfaHdfZmluaSgpLCBhbmQgdGhlIHZwZS10aHJlYWQgZmluZHMgdGhh
dCBWRVAgaGFzIG5vIGpvYnMgaW4gdGhlIHF1ZXVlLg0KVGhpcyBwYXRjaCBpcyB0byBtYWtlIHN1
cmUgdGhhdCBWUEUgaXMgcG93ZXIgdXAgYmVmb3JlIGxvYWRpbmcgZmlybXdhcmUuDQoNClRoYW5r
cywNClBleXRvbg0KLS0tLS3ljp/lp4vpg7Xku7YtLS0tLQ0K5a+E5Lu26ICFOiBBbGV4IERldWNo
ZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCuWvhOS7tuaXpeacnzogV2VkbmVzZGF5LCBNYXJj
aCAxMywgMjAyNCA5OjE3IFBNDQrmlLbku7bogIU6IExlZSwgUGV5dG9uIDxQZXl0b24uTGVlQGFt
ZC5jb20+DQrlia/mnKw6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywgWWlmYW4gPFlpZmFu
MS5aaGFuZ0BhbWQuY29tPjsgTWEsIExpIDxMaS5NYUBhbWQuY29tPjsgWXUsIExhbmcgPExhbmcu
WXVAYW1kLmNvbT4NCuS4u+aXqDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdS92cGU6IHBvd2VyIG9u
IHZwZSB3aGVuIGh3X2luaXQNCg0KT24gV2VkLCBNYXIgMTMsIDIwMjQgYXQgNzo0MeKAr0FNIFBl
eXRvbiBMZWUgPHBleXRvbGVlQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBUbyBmaXggbW9kZTIgcmVz
ZXQgZmFpbHVyZS4NCj4gU2hvdWxkIHBvd2VyIG9uIFZQRSB3aGVuIGh3X2luaXQuDQoNCldoZW4g
ZG9lcyBpdCBnZXQgcG93ZXJlZCBkb3duIGFnYWluPyAgV29uJ3QgdGhpcyBsZWF2ZSBpdCBwb3dl
cmVkIHVwPw0KDQpBbGV4DQoNCj4NCj4gU2lnbmVkLW9mZi1ieTogUGV5dG9uIExlZSA8cGV5dG9s
ZWVAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dnBlLmMgfCA2ICsrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZwZS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZwZS5jDQo+IGluZGV4IDcwYzVjYzgw
ZWNkYy4uZWNmZTBmMzZlODNlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdnBlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZwZS5jDQo+IEBAIC0zOTYsNiArMzk2LDEyIEBAIHN0YXRpYyBpbnQgdnBlX2h3X2luaXQo
dm9pZCAqaGFuZGxlKQ0KPiAgICAgICAgIHN0cnVjdCBhbWRncHVfdnBlICp2cGUgPSAmYWRldi0+
dnBlOw0KPiAgICAgICAgIGludCByZXQ7DQo+DQo+ICsgICAgICAgLyogUG93ZXIgb24gVlBFICov
DQo+ICsgICAgICAgcmV0ID0gYW1kZ3B1X2RldmljZV9pcF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUo
YWRldiwgQU1EX0lQX0JMT0NLX1RZUEVfVlBFLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFNRF9QR19TVEFURV9VTkdBVEUpOw0KPiArICAg
ICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiArDQo+ICAgICAg
ICAgcmV0ID0gdnBlX2xvYWRfbWljcm9jb2RlKHZwZSk7DQo+ICAgICAgICAgaWYgKHJldCkNCj4g
ICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+IC0tDQo+IDIuMzQuMQ0KPg0K
