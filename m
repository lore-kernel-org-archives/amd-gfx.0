Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422C8C54791
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 13:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAE8010E931;
	Wed, 13 Mar 2024 13:31:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nnwg0MlB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83F8E10E931
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 13:31:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwKKxFK0+ohHetnyQqSlTV73ecoKX1ye10/0bhkqEJKiBFn/Wzx5rEgR4opa3trnc2aAFSaIgF+0ueXzwu0K3JfpNtvMz6TTCyrzKYsiC5N27nxgPKBqw/mHGtNuvBMR45IPL2Sg7M2KMo/u2YzROaFuoU908TSkBx5x9lGw1AuJBpN74wxk46UMiAAvlWayovkF4mAlt5ly3yKUbQcsa24ELEnkRyunGvsRxcc9EMXpzbaKRqJ5Qe704wnXS5hyZlHwmqlaZGXoEh7OJgDG5OFg7dxpFtT5XuQKmWkLpEWOiK2sGmL1rAgXebadPZ/MegWWjmywrML6H5RhA8RMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZmP/5MM9oVNvz3OSVvszZoodrXsnZNEkgM3qv8TStk=;
 b=dk8s+ugRVlqAJN7YByRfy1Tn8YxVvAUmEqiwb0o3YAirmdZMPv11pHuKAW/dOmRFkN6wxhLDHHPjA8hpAle9oPguyK6f3uRroCM7CALVf1a2s+NYDZ1zfTOJWDCBLeH8ZNj4fyt+jd7MjHzlmu2TUcEDb0WKS4sdHlCitKS4X0ygo0ajdOnWXyiYpOEtx9wNmksXfJSQkAuCVJkAyQ9fL1ZImd8lXzgn1JTMg/qOTR0JpA233qlE4H7hshHUTqtY85fZ1LK6hmvihJpsDcEQY1qPu5WZbtBiSuuNReH2G29aLw3+dRJicsyO1GDeYhoBpn4+XaGiCJddudhDIHGTkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZmP/5MM9oVNvz3OSVvszZoodrXsnZNEkgM3qv8TStk=;
 b=Nnwg0MlBtR0TNAYZxGKFX3GRW29u7c7Y1eC1ndXy81HFTzvU7/t5+7L3Y9qhTGHegzpBno9ltl9XABosR2THGbmp4jmwuptTJj/lD3qNhvMqRFxRfUc/xtvZggPo+HbZPLZXP+/qBVNHIrtsVoUdKwam0SYmtVwKWaecBq5Arq8=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.18; Wed, 13 Mar 2024 13:31:28 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::6503:7457:78d3:b2f4]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::6503:7457:78d3:b2f4%5]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 13:31:28 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Get min/max vfreq from display_info
Thread-Topic: [PATCH] drm/amd/display: Get min/max vfreq from display_info
Thread-Index: AQHadIPadXwtjTY/rkS6QgTbCp9HNbE0MmuAgAAIjICAAXEKwA==
Date: Wed, 13 Mar 2024 13:31:28 +0000
Message-ID: <DS0PR12MB6534D40B1F20BEE12A69DA949C2A2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240312134728.14046-1-harry.wentland@amd.com>
 <CADnq5_OsR1VpobKpDLhr+uKSBT05MUs42B1_PbazRT=P7AyASw@mail.gmail.com>
 <97384480-823f-47c2-8d9d-53d6ca4b890b@amd.com>
In-Reply-To: <97384480-823f-47c2-8d9d-53d6ca4b890b@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1a120670-828c-4070-8b8e-c28dcf031323;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-03-13T13:30:09Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DM6PR12MB4481:EE_
x-ms-office365-filtering-correlation-id: d09afc9d-212b-4d54-8016-08dc4361e371
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fLHK1aTR/rBl3dy9j0yKflN5l2kgY3vVlkh6JnevzB+ZXRexrca7LYjnopvQDi1UuR5CUvHDhZbfg2WJUojM6UvkoNWD3WBzYF8/EoYSy6UcIFyo7V8Au65JOKym3nAitURcp95kLEE9yPkFCmC438wvfJcNpOyQoAzUw/wERUgXbxRSsV5YE+g4uevif12U10vKQB37LubQAK3/cvEwhQvJFnaA829g3rQibhq76/7BT82nMONaoCkD2o6jJbXOV/FcnvwUqgT/bkgtqI3Vq0qML00Dnf/s9SNwjX6ocWCoRLAdcpylGKHZhuIO2MrWKIkvCShCr6rDyhX66GUZ4iTFx+KqzHjBklf1ym+6ck5O/xONhmyY8Sf6Saha1D6TtBhLzDmZ+SBqqg8F4CA8t4fahYtoEttSb6RnL4rDdIP4zjOgpSV0AKEhBFtoe1/Cux9z/lvqWuJXBXgYFtKn4KgdC3ongVZR1Y7F+ylkI8hLfbTgdZK2TSLvEcPFutPFTtqJUYbMwtkyHYXnad1wp+yELNNBKRkvzedegM4d8HOGorfUaQcQVzzS0KvxJZFvf0p2ZKd5DEAq8kCxNxsDijWAygVyiGeMFmRUQFZrJyxAFrhx7/Mj2Exl8wQcT44CWipVOm3PK8R4YjR4I8HaTNcLOUoHHu/gp3bNPBUCiA2WxZw9UBdAl6jcxTJ6xpLerNH5716uc8w3bfFVMmouu6VYznxTEkTlXQkw5nbZqEI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlZDc2crenFHeUY3MWsrMHZOSXZVWWZ3MW14Wjl2LzJncGVrYlBSZmppaEdE?=
 =?utf-8?B?V3NrKzM4QzNuK0MrNUI3SG5LY2p4TGNIdDNFenIwQWJIYk1CUEVwdGZUL09B?=
 =?utf-8?B?d3NlSnpqY2FlS1JoZmpIeEdMMXVJNFYzUXlBck51cWJYRSt0MnMvRkxzazdy?=
 =?utf-8?B?NWttL0c4WTZRRjdsZHliUkp1QmVnSjZHMzF2Y2FTbVJtMk4vQXJJM3FRMnN0?=
 =?utf-8?B?MUkyNitMV0gxdGJoQlVGRkYrQkZHZ1VwNUR5emZqcVdxb0NDalNZQ1c2VUJw?=
 =?utf-8?B?RUNocnJ1aHcvTnFPUkdnMFllc3NSeTkxcWVwdmZqL29wY3lxRUZLbjJidHhO?=
 =?utf-8?B?Z0RkYTdkYkx2cEhvejZiODU3dS9TcW52RTRtTzk4bitiWGYwUVhNaVJnd2sw?=
 =?utf-8?B?bEo4d2huQVBZODNYeWZpbW8wRUJFSzluMDFacHBudGUxWGNtQm9IYkQzMUxh?=
 =?utf-8?B?SmFVWkYwNVRNQTd2RGgxbGFiOFZHdnBMTFg1eG9qY3hEbmNYY3Rhd1RqRVRq?=
 =?utf-8?B?R1NPQ0g3aUhISmpzQjhXSVJwOW1lSHVCekNBVnhnZ3ZDWTgyUWU3aDVkbEdT?=
 =?utf-8?B?VFgycVFTQUJSSGVqQkluQ2hscjJ4UDNpT0d3UVJrV1VZSGlaNmhCVlRQTGZM?=
 =?utf-8?B?QkdNQXFqU0g5TEpNcE03bFhJRituMkUvbUxpTi9DS2VvSlBSVGZwVmxMamNL?=
 =?utf-8?B?UVVLWEhMZU1NeVZmNGNBVmhKSzNtNjVveS9KdXRROG9PTzRubUljT1o4V0Fm?=
 =?utf-8?B?amF1bnVMUFd1czhvcVdCTUhIbW5rWFBjbHlBdm1XNFJJQlgzM1JhYmVvdmpw?=
 =?utf-8?B?LzAva2UzaHVuTkdOUEFxb090TzNiVVVsV2ZXUGZCRG1jbzFpRFRqTVhaQlVK?=
 =?utf-8?B?Umh0SzZUa2RkYnJFd3V0NWRWWGRRN3hNd3dqZjlRajBnMTFsNjRlUkdzeHl3?=
 =?utf-8?B?Q25RbFQ0T1RXZ3g4aHlzMTkzME92NThKMVhBMnNCMGZVczdGSXNTcnYyNHZp?=
 =?utf-8?B?c3ArTHVnVEdTSlZNcTNZRXF0Tmp1S3E4U0FxZnpyUE40VzUvTzQ3dUZabk1t?=
 =?utf-8?B?OSsxaE9HNzBCeU1Ed1U2QVlVeFR1VmZGN0VtVnRYRGd1YW9qRnRlMUNrWXI4?=
 =?utf-8?B?cE1vVUdmMlZuVkdWTWZhcHRGakFFbXhLaDdrQ1FweVkxbXVUYXhpN1pvQjRR?=
 =?utf-8?B?WWYweGtKVkZNUFVWQngvVVplSU5CY3MzUUdkMndGeHVvY1FndGkrOWF6L0dD?=
 =?utf-8?B?MmZZNDNMb2R2S0tsd1lKRmFzZGxzWGJ1SWNOZG1BWUtFRFU2NzZVVDF4UzFl?=
 =?utf-8?B?cExKY0ZKS25TbWtteXM2bm5sai9BSWVQT2tnb0RvMU9jSFBUQU13VmhJa0E3?=
 =?utf-8?B?cTkzNDZxQnJicFBSazVja1RSU0dUeXFvV25VY2w2UmxrVDJReitsQmNYWVRs?=
 =?utf-8?B?bTV5YlNGeHpYZzFaVDBqVkhpTlozVVFSUTFTUXdRTk0zSkdxenJHSzZwcEJ5?=
 =?utf-8?B?MFplUTZCTVNzSEVJcHkwa3U1TS9BZFI2Ym95MkppVTJ4cWhrSUd4b0JRREZE?=
 =?utf-8?B?bFFqcXEzWVNJYW1rTUw4V1NUdGxreC9NdXpENzJUMkNqVDJoekRjaTZjZGNC?=
 =?utf-8?B?MEhuNEdGZmlReHdRZ01RT2ROemxTcWM5cnljZmdyMmcxay9OT2dkTVc0dlBE?=
 =?utf-8?B?SnlySjB3d2I3cjRkR2FRUU5keGFldzhjWkc0MDJMVnZZcWZJWmFISURUc1h4?=
 =?utf-8?B?SmwrSHJlTUpIbTdYQU55VkJyZGJMRFM5VnR6RVVoU0lmTVdUdGRVWExxS3Bs?=
 =?utf-8?B?WTFSZ3dLanp3TTlqd21rRmdLbjRVOW05WXREcm1EWVU2ZjNVckpFNFcycitW?=
 =?utf-8?B?U0JYOEVaWThJZUNWR2x4Z1ZqWVYrMENkUURKdXVhaXhzTjZMQlYrTlJQOVNK?=
 =?utf-8?B?TGxQZ1FSbjNqZFJhOE4zZ3BybzdHMU9HNXByTm1XeVVVVGcrcThFZUIvTDNH?=
 =?utf-8?B?K08wVUF3bmYvWGYvYWtMUVFmS2RybWpSRmk1dGhuNnNYQ1BqbkYwVG5qZytY?=
 =?utf-8?B?Mld4aHNGNXNtUGVhbVB2T3FXZTBnT21mY2lxZkNkaFU0ZmZJeUlZRENHZUQx?=
 =?utf-8?Q?g2RE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09afc9d-212b-4d54-8016-08dc4361e371
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 13:31:28.6424 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bPAUEaN+vOIWnR2AQmgES3VbU7EaG2bJz/XDZhVl+36TgoCEPNXD4ll9S5bAsQFaBw4NG36sA+Rqcikdxv2V6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
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

W1B1YmxpY10NCg0KSGkgYWxsLA0KDQpJIGNhbiBjb25maXJtIHRoYXQgdGhpcyByZS1lbmFibGVz
IFZSUiBmb3IgYSBSWDY4MDAsIGFuZCBhIFJYNzkwMFhUWC4NCg0KVGVzdGVkLWJ5OiBEYW5pZWwg
V2hlZWxlciA8ZGFuaWVsLndoZWVsZXJAYW1kLmNvbT4NCg0KVGhhbmsgeW91LA0KDQpEYW4gV2hl
ZWxlcg0KU3IuIFRlY2hub2xvZ2lzdCAgfCAgQU1EDQpTVyBEaXNwbGF5DQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCjEgQ29tbWVyY2Ug
VmFsbGV5IERyIEUsIFRob3JuaGlsbCwgT04gTDNUIDdYNg0KRmFjZWJvb2sgfCAgVHdpdHRlciB8
ICBhbWQuY29tDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZngg
PGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBIYXJy
eSBXZW50bGFuZA0KU2VudDogVHVlc2RheSwgTWFyY2ggMTIsIDIwMjQgMTE6MjkgQU0NClRvOiBB
bGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZC9kaXNwbGF5OiBHZXQg
bWluL21heCB2ZnJlcSBmcm9tIGRpc3BsYXlfaW5mbw0KDQoNCg0KT24gMjAyNC0wMy0xMiAxMDo1
OCwgQWxleCBEZXVjaGVyIHdyb3RlOg0KPiBPbiBUdWUsIE1hciAxMiwgMjAyNCBhdCA5OjU34oCv
QU0gSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+IHdyb3RlOg0KPj4NCj4+
IFdlIG5lZWQgdGhlIG1pbi9tYXggdmZyZXEgb24gdGhlIGFtZGdwdV9kbV9jb25uZWN0b3IgaW4g
b3JkZXIgdG8NCj4+IHByb2dyYW0gVlJSLg0KPj4NCj4+IEZpeGVzOiBkYjNlNGYxY2JiODQgKCJk
cm0vYW1kL2Rpc3BsYXk6IFVzZSBmcmVlc3luYyB3aGVuDQo+PiBgRFJNX0VESURfRkVBVFVSRV9D
T05USU5VT1VTX0ZSRVFgIGZvdW5kIikNCj4+IFNpZ25lZC1vZmYtYnk6IEhhcnJ5IFdlbnRsYW5k
IDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDcgKysrKystLQ0KPj4gIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0KPj4g
aW5kZXggYjFjYTBhZWUwYjMwLi5jZmZiMjY1NTE3N2MgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQo+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQo+PiBAQCAtMTEy
NzgsMTIgKzExMjc4LDE1IEBAIHZvaWQgYW1kZ3B1X2RtX3VwZGF0ZV9mcmVlc3luY19jYXBzKHN0
cnVjdA0KPj4gZHJtX2Nvbm5lY3RvciAqY29ubmVjdG9yLA0KPj4NCj4+ICAgICAgICAgICAgICAg
ICBpZiAoaXNfZHBfY2FwYWJsZV93aXRob3V0X3RpbWluZ19tc2EoYWRldi0+ZG0uZGMsDQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFtZGdw
dV9kbV9jb25uZWN0b3IpKSB7DQo+PiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAoZWRpZC0+
ZmVhdHVyZXMgJiBEUk1fRURJRF9GRUFUVVJFX0NPTlRJTlVPVVNfRlJFUSkNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGlmIChlZGlkLT5mZWF0dXJlcyAmDQo+PiArIERSTV9FRElEX0ZFQVRV
UkVfQ09OVElOVU9VU19GUkVRKSB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGZyZWVzeW5jX2NhcGFibGUgPSB0cnVlOw0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgZWxz
ZQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVfZG1fY29ubmVjdG9y
LT5taW5fdmZyZXEgPSBjb25uZWN0b3ItPmRpc3BsYXlfaW5mby5tb25pdG9yX3JhbmdlLm1pbl92
ZnJlcTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X2RtX2Nvbm5l
Y3Rvci0+bWF4X3ZmcmVxID0NCj4+ICsgY29ubmVjdG9yLT5kaXNwbGF5X2luZm8ubW9uaXRvcl9y
YW5nZS5tYXhfdmZyZXE7DQo+DQo+IERvZXMgdGhpcyBuZWVkIHNwZWNpYWwgaGFuZGxpbmcgZm9y
IERSTV9FRElEX1JBTkdFX09GRlNFVF9NSU5fVkZSRVENCj4gYW5kIERSTV9FRElEX1JBTkdFX09G
RlNFVF9NQVhfVkZSRVEgYXMgd2VsbCAoc2ltaWxhciB0byB0aGUgY29kZSBiZWxvdw0KPiBpdCk/
DQo+DQoNCmdldF9tb25pdG9yX3JhbmdlIGluIGRybV9lZGlkLmMgYWxyZWFkeSBoYW5kbGVzIGl0
LiBJJ20gYWN0dWFsbHkgd29uZGVyaW5nIGlmIHRoZSAiZWxzZSIgYW5kICJlZGlkX2NoZWNrX3Jl
cXVpcmVkIiBjYXNlIGlzIHN0aWxsIHJlcXVpcmVkIG5vdywgYXMgaXQgZXNzZW50aWFsbHkganVz
dCBkdXBsaWNhdGVzIHRoZSBkcm1fZWRpZCBjb2RlLiBCdXQgSSBkb24ndCB3YW50IHRvIHJpcCBp
dCBvdXQgaW4gdGhlIHNhbWUgcGF0Y2ggYW5kIHdpdGhvdXQgYSBiaXQgb2YgdGVzdGluZy4NCg0K
SGFycnkNCg0KPiBBbGV4DQo+DQo+PiArICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugew0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlZGlkX2NoZWNrX3JlcXVpcmVkID0g
ZWRpZC0+dmVyc2lvbiA+IDEgfHwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIChlZGlkLT52ZXJzaW9uID09IDEgJiYNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlZGlkLT5yZXZp
c2lvbg0KPj4gPiAxKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIH0NCj4+ICAgICAgICAg
ICAgICAgICB9DQo+Pg0KPj4gICAgICAgICAgICAgICAgIGlmIChlZGlkX2NoZWNrX3JlcXVpcmVk
KSB7DQo+PiAtLQ0KPj4gMi40NC4wDQo+Pg0KDQo=
