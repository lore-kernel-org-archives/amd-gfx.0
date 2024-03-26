Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E665EC54E67
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 16:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7873110EE2B;
	Tue, 26 Mar 2024 16:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xq2GpN3P";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2105.outbound.protection.outlook.com [40.107.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A8E910EE2B
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 16:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgDyZxBKNrhtzr5d6PW/jWgRhdxlPjNyYOOJdxbFpnN0/aHaKn4P42U/DDsDfY/Cx8HLT0nUkLUCG4tNQ/UrvwTtqXmj8LIDR2RlhpoNA9dZMHMgz3Y/K+L+0ZmJpEoztvBemCGITAkZ1ZKcf9FcojTMYWUwuskVini6fjyT3wJFcNJAjBila2Do+mZEdBbSfJAejazR9uDxAIf2uBsDI5DwbO/vlv1QMzqdAdVP6y4sXv44hhs9KIciz28g/JCXWv3ExsZ7i3TeEY0KyduVZ54MDHzJ27070q5o4WOxjZaiOwf/B/ITJ7MNXCn/GSd3O8M7atbhnUxOVFiHY8M+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHJjkdcHTwq+ZG8/fTyALQaSahLRTCxLhrT8AxzJGO0=;
 b=jsNKow47Yygy59QktjmCnxhXq6KkvbVw6D1OkQESNAXlctr/yDwq1xu9eJEhJisDCaOMqPaAkPtVw0gLoEP8rfcqg9kixpKehItzoZjz6knPVkhJ/KnyhYDf0nsaGSSdoT58boiXChlEmIn1FwZwO4l2UsMijgXc2U9XhX9eLueJWzF2y05p4v9QyvXny/exmlI6gMhge3YHZ7wF3eC2xUDQnaQOlqGAH/iVakn55iwjbslus5PB7ySX4/h7FxUUhEIlD8mKyW/RjfXPEblBk9G6yrIvq2j/qCM2zwCuYWC0PsfVK20Fl8TrkGF87Fv21YOGyXJZj6EO0M1QqntDuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHJjkdcHTwq+ZG8/fTyALQaSahLRTCxLhrT8AxzJGO0=;
 b=xq2GpN3PzkyAufiZZVkHW2POm7s2lsgJmmdAKqBOPhAdww9ZSIG5qPequRnZeTR8AEtjjhRJtzp6erQcjj7gZiLOyx92LEgqSYvHkB6nrCP/6i3J0HApXyyVLQ14oLMvRiDgmmIfDx+95MqHQeUNtv4+YxQUTak17Ba8naS/LzQ=
Received: from SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 16:04:56 +0000
Received: from SA3PR12MB7902.namprd12.prod.outlook.com
 ([fe80::6e7a:d7b2:7caa:e6d]) by SA3PR12MB7902.namprd12.prod.outlook.com
 ([fe80::6e7a:d7b2:7caa:e6d%6]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 16:04:56 +0000
From: "Alam, Dewan" <Dewan.Alam@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Zhaochen" <Zhaochen.Zhang@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Enable IH Retry CAM by register read
Thread-Topic: [PATCH] drm/amd/amdgpu: Enable IH Retry CAM by register read
Thread-Index: AQHadW4fEoUwVv7f3U+ZaqcdHus+sLE2EzsAgBQwP8A=
Date: Tue, 26 Mar 2024 16:04:56 +0000
Message-ID: <SA3PR12MB790204F7976709B88A9302BF8B352@SA3PR12MB7902.namprd12.prod.outlook.com>
References: <20240313174344.2580-1-dewan.alam@amd.com>
 <c0c126f3-c379-4a68-bb89-2c4aa505679b@amd.com>
In-Reply-To: <c0c126f3-c379-4a68-bb89-2c4aa505679b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Zhaochen.Zhang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2e5558d6-34b6-4108-998e-6b8786bf1e88;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-26T16:03:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR12MB7902:EE_|CH3PR12MB8483:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P/IX6ASQOQ2n/c0wZfcyWmO1d0dsEAr/epxpMX6iHTQDy4dBw3QR0XJWDt7qytG+pQrSujlEcXoYxnXVQo0lTI8j8IkFfG4OStipkV0Fb47nm/s6bXkQuUjuFXsTfyIpzZN1DCaZ3YBqlML6cnjmifx/5JEqZsCA/lrI/VC9DyEMvWHrDQsrY4rfvkGv+dNe7LPCWw6gigOjctsehOS1CLXYqMED8ZAKUvfFVZe+OCNSXaFBPLCTdtSPE5tkL4vH+algGDr6Koj39MkRmhnJwUvK2omhM9VMgIqYhKHKvSWR3asRZbgPV/mPucyRjcxw7VQg8FuPJhn2Vx/cakCJOI3TVPnECetUWp8nI/214OxCgPz1lOV7vDF9diffIAXtnVTZr8sNm7nCIKJ1GaWNEQZOA9prE6ACE9dXFrvYMo+9gek63pjT/kH2m6doz4nLXz9iWZm4pNP1fzhfHowNrEEWDqACMZqnSf2HVmuzRuVuqs2DuU7n/MW0iukugzf+k3ZxJ7i6zu/hJsNA3Ry3k0aO1ab/mYBHvizuklwBVnZEQcoEUtBgiuGPjRN8jBwH6T7uzxsYnI8BScM3NG3hXK3D9PG/u+1HrbwRjXgbzueZO2qgDy5DT5QrY6kR3BQD6KADh5HVxIwwvAxsHvBLRHauKZdiACI1OAi5DaNApy8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB7902.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUVFR2x2VVBNMGRtdkVyTGRlOGhSOVY1Ynl1dkhOb3IwcWdQQW1BVHZsNiti?=
 =?utf-8?B?TzRjbklhWGFoTlVVSDdFYTlISlU1ejhCdXRZNFBCcmFwRGIrUG1ONmlsWVBX?=
 =?utf-8?B?OUpTbS9HbzJjM2VvVE53VzlHb2VWbWxiQ0lnL1pCVCtFa05XcDJmYzJGRnJx?=
 =?utf-8?B?aG9wN2VpczdrdE9LMC9uSkZsUGlqRC94K0lTTmVPM3JackFpSjNZR1kvSlZp?=
 =?utf-8?B?aHF5YSttaGVnS213NUFZdW5aVHBicU0vUVE1RmZCOXpHSWc5SmRGWm5lZU5a?=
 =?utf-8?B?N0l4ZmFrcU1IM08ySWRwYW93MVRhdG4rZ1BuVGRHWVlES0doSmxqR0QwZU00?=
 =?utf-8?B?aGRBY2NTZTMrcWF0eUxDRE1WanVzSFJ5dWd2TlI3SlMya1Q1RW1wMUlSSTg3?=
 =?utf-8?B?YXE4NGZlTkxyS1A5eElGVDhqNWltOUFJVE1PYnJCbm04UXpOUHVjQWg2MmZq?=
 =?utf-8?B?RHFSOW9RSE1URDJzTVJhMzJ4QzFGVHBtdHFNSndMU0hPaUhaQWZNS2EwODhB?=
 =?utf-8?B?Zk16R09RWVNNU2FLLzhvR2JPSUhURlBtTU41UERpUi9wMC9lY0dSVHcwQ04w?=
 =?utf-8?B?TGhxdmFaaklzR3BvaXMwY2t6UXUrNjJ1ME1KT1BmaEZPSlR4SUc3WG40YzAx?=
 =?utf-8?B?dEdwcE40NlBrN3BxalNGTDV0TDZPeTRmcU5GQldUamtMMU9rci9pbXZuMWNB?=
 =?utf-8?B?RVFnUVdZemczWU9CL0NkRzd6SVRIa1RscUFaT3dLSFgvaGl0TmpYSU5Ldk41?=
 =?utf-8?B?Q0FTK2duZVhkYWp2cklpaktmcXovWVJKOGNwSmhyL3NRb0swQVpVTFNrendu?=
 =?utf-8?B?YTZQTmIyQnMyV3ZhU2ZOdVFqRTJzcmZhZUFzbThUcjM5bU9LL2lGMHRxWFRJ?=
 =?utf-8?B?c2txZDdqcGh6a2FUbko2QUEzbys1VUw4dmhaK01WdFUweDNvS25KbndzaTgx?=
 =?utf-8?B?YXRQa3p6N2tzREZ4aTFwUmk1VmpwVFEyWjBvQjcrRUVibUI5eXJVeDMwQjB4?=
 =?utf-8?B?Vkp0MzJnclBuUk14UWdtdnUyZHViQzNMaE9NSTh3T2pSYUdoSE5ZRi9zK1BU?=
 =?utf-8?B?RVhjNFpkODE4T1pua2U5RjROVHg0dDUwVmpCMVZpL0Nnc29zSVoxc0RYVHky?=
 =?utf-8?B?OG1XajZOVmN0aHFLVzc1WG1TVml0L0tZcmU4RGZzREFXS01LbExMOWVqKzVI?=
 =?utf-8?B?aVFUWUlIdXY1K1FkU2pJOERYMldLNFh2ODZ0VUh3OVFiek1zbzVWZlk2Qngx?=
 =?utf-8?B?Y1lKY1piNld6NVdhN0RYWUJETmwvZjc3R25jaUw5dFZPSkJLRE1Lclg0VEZn?=
 =?utf-8?B?QzBvUHJQSkg4T2xIRWY5LzRDZm05VHhqNHZxcVVXOVRQUk5VWUZuL05raGlX?=
 =?utf-8?B?cDNvSjhqYVVmWTJPOU9uODE5ZHVmWjZBZUhEQVRHQWJSQmthWkUwY2M5aTNv?=
 =?utf-8?B?VEJySFFvblAzWTFMMkFYbW1ES1dVQ1RwUWR1WkpESThEUU5kc29NU01tbG9u?=
 =?utf-8?B?cHdXV01WcFEvbDMrQVZDUGhGcjVOd3l0aWVVRW5qRmpKVFBUOEM4N2lGMWR2?=
 =?utf-8?B?SUJhVFpkc0tucjFGRU9GSFJGbVRiSy9RMXdxVFJia2EzMmQvY1ErNEJkMXJT?=
 =?utf-8?B?QkJ0ZFllb1IwamNzS21Pc2xQMjJ6UG9MSVRXZmViUFdRZExwblYwVVY5VHUz?=
 =?utf-8?B?MjBjM3dmU0I1Y0IxMGZTQWZ2ZHJDVHVYblNKd3lydFowK3luSCtEODRkUGU3?=
 =?utf-8?B?T1BDdkVsMlM4NzFRSWtpUG1EeHZ0UC9kT2hkUi9xdmMwaC9pYjNYK1lKd0NI?=
 =?utf-8?B?L1NDME5FMVF6OFdVc0xScmk4RTZwTHJ4bWRkZjNqUHA5bEJjS0R0dExkcFk3?=
 =?utf-8?B?RkpxK0RxU1NGVmd5dzYwZmlsblhtY2hZMW5vV2d0MTdRbU5Vc2hGWUxtTnl0?=
 =?utf-8?B?R3FYenBnWlMwNTE1dkJHcmM3RTlpUW5oYmJINTZxR0JoSHptQ3JuUHdNN2JJ?=
 =?utf-8?B?dWI1eHkzS01EUlRJZ1d6OUI4VmQ5cGtDbnJHamtuNC9LaVVzbmcrcmpyc3FN?=
 =?utf-8?B?SDE0V0Y5NnE2RHdmL21xTkxlZU85Mms0dnVDVjU3VVZPSFN0bnpiemZyTG1V?=
 =?utf-8?Q?nT5s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5072ed3-98bd-4a85-37ad-08dc4dae7b1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 16:04:56.4486 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hO+i9J8Hfzp47BTQsU8cebBfMZz7LgfPJwZbjvSCI8NngZgfc2Kl9SOxZRwYmfnXxi4x8GsZuk8QA+0Em8E1EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkxvb3BpbmcgaW4gK0BaaGFuZywg
Wmhhb2NoZW4NCg0KQ0FNIGNvbnRyb2wgcmVnaXN0ZXIgY2FuIG9ubHkgYmUgd3JpdHRlbiBieSBQ
Ri4gVkYgY2FuIG9ubHkgcmVhZCB0aGUgcmVnaXN0ZXIuIEluIFNSSU9WIFZGLCB0aGUgd3JpdGUg
d29uJ3Qgd29yay4NCkluIFNSSU9WIGNhc2UsIENBTSdzIGVuYWJsZW1lbnQgaXMgY29udHJvbGxl
ZCBieSB0aGUgaG9zdC4gSGVuY2UsIHdlIHRoaW5rIHRoZSBlbmFibGVtZW50IHN0YXR1cyBzaG91
bGQgYmUgZGVjaWRlZCBieSB0aGUgcmVnaXN0ZXIgcmVhZGluZy4NCg0KVGhhbmtzLA0KRGV3YW4N
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVs
aXguS3VlaGxpbmdAYW1kLmNvbT4NClNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMTMsIDIwMjQgMzo0
NiBQTQ0KVG86IEFsYW0sIERld2FuIDxEZXdhbi5BbGFtQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5j
b20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL2FtZGdwdTogRW5hYmxlIElIIFJldHJ5
IENBTSBieSByZWdpc3RlciByZWFkDQoNCk9uIDIwMjQtMDMtMTMgMTM6NDMsIERld2FuIEFsYW0g
d3JvdGU6DQo+IElIIFJldHJ5IENBTSBzaG91bGQgYmUgZW5hYmxlZCBieSByZWdpc3RlciByZWFk
cyBpbnN0ZWFkIG9mIGFsd2F5cyBiZWluZyBzZXQgdG8gdHJ1ZS4NClRoaXMgZXhwbGFuYXRpb24g
c291bmRzIG9kZC4gWW91ciBjb2RlIGlzIHN0aWxsIHdyaXRpbmcgdGhlIHJlZ2lzdGVyIGZpcnN0
LiBXaGF0J3MgdGhlIHJlYXNvbiBmb3IgcmVhZGluZyBiYWNrIHRoZSByZWdpc3Rlcj8gSSBhc3N1
bWUgaXQncyBub3QgbmVlZGVkIGZvciBlbmFibGluZyB0aGUgQ0FNLCBidXQgdG8gY2hlY2sgd2hl
dGhlciBpdCB3YXMgZW5hYmxlZCBzdWNjZXNzZnVsbHkuIFdoYXQgYXJlIHRoZSBjb25maWd1cmF0
aW9ucyB3aGVyZSBpdCBjYW5ub3QgYmUgZW5hYmxlZCBzdWNjZXNzZnVsbHk/DQoNClR3byBtb3Jl
IG5pdC1waWNrcyBpbmxpbmUgLi4uDQoNCg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBEZXdhbiBBbGFt
IDxkZXdhbi5hbGFtQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3ZlZ2EyMF9paC5jIHwgMTUgKysrKysrKysrKystLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDExIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMjBfaWguYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3ZlZ2EyMF9paC5jDQo+IGluZGV4IGI5ZTc4NTg0NjYzNy4uYzMzMGY1YTg4YTA2
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMjBfaWguYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMjBfaWguYw0KPiBAQCAtMzM3
LDEzICszMzcsMjAgQEAgc3RhdGljIGludCB2ZWdhMjBfaWhfaXJxX2luaXQoc3RydWN0DQo+IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpDQo+DQo+ICAgICAgIC8qIEVuYWJsZSBJSCBSZXRyeSBDQU0gKi8N
Cj4gICAgICAgaWYgKGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIE9TU1NZU19IV0lQLCAwKSA9PSBJ
UF9WRVJTSU9OKDQsIDQsIDApIHx8DQo+IC0gICAgICAgICBhbWRncHVfaXBfdmVyc2lvbihhZGV2
LCBPU1NTWVNfSFdJUCwgMCkgPT0gSVBfVkVSU0lPTig0LCA0LCAyKSkNCj4gKyAgICAgICAgIGFt
ZGdwdV9pcF92ZXJzaW9uKGFkZXYsIE9TU1NZU19IV0lQLCAwKSA9PSBJUF9WRVJTSU9OKDQsIDQs
IDIpKQ0KPiArew0KPiAgICAgICAgICAgICAgIFdSRUczMl9GSUVMRDE1KE9TU1NZUywgMCwgSUhf
UkVUUllfSU5UX0NBTV9DTlRMX0FMREVCQVJBTiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBFTkFCTEUsIDEpOw0KPiAtICAgICBlbHNlDQo+ICsgICAgICAgICAgICAgYWRldi0+aXJx
LnJldHJ5X2NhbV9lbmFibGVkID0gUkVHX0dFVF9GSUVMRCgNCj4gKyAgICAgICAgICAgICAgICAg
ICAgIFJSRUczMl9TT0MxNShPU1NTWVMsIDAsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIG1tSUhfUkVUUllfSU5UX0NBTV9DTlRMX0FMREVCQVJBTiksDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIElIX1JFVFJZX0lOVF9DQU1fQ05UTF9BTERFQkFSQU4sIEVOQUJMRSk7
DQo+ICsgICAgICAgICAgICAgfSBlbHNlIHsNCg0KSW5kZW50YXRpb24gbG9va3Mgd3JvbmcgaGVy
ZS4NCg0KPiAgICAgICAgICAgICAgIFdSRUczMl9GSUVMRDE1KE9TU1NZUywgMCwgSUhfUkVUUllf
SU5UX0NBTV9DTlRMLCBFTkFCTEUsIDEpOw0KPiAtDQo+IC0gICAgIGFkZXYtPmlycS5yZXRyeV9j
YW1fZW5hYmxlZCA9IHRydWU7DQo+ICsgICAgICAgICAgICAgYWRldi0+aXJxLnJldHJ5X2NhbV9l
bmFibGVkID0gUkVHX0dFVF9GSUVMRCgNCj4gKyAgICAgICAgICAgICAgICAgICAgIFJSRUczMl9T
T0MxNShPU1NTWVMsIDAsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1tSUhfUkVU
UllfSU5UX0NBTV9DTlRMKSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSUhfUkVU
UllfSU5UX0NBTV9DTlRMLCBFTkFCTEUpOw0KPiArICAgICAgICAgICAgIH0NCg0KV3JvbmcgaW5k
ZW50YXRpb24uDQoNClJlZ2FyZHMsDQogICBGZWxpeA0KDQo+DQo+ICAgICAgIC8qIGVuYWJsZSBp
bnRlcnJ1cHRzICovDQo+ICAgICAgIHJldCA9IHZlZ2EyMF9paF90b2dnbGVfaW50ZXJydXB0cyhh
ZGV2LCB0cnVlKTsNCg==
