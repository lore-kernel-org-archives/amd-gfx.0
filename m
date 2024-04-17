Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989F3C04FFE
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 06:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06414113198;
	Wed, 17 Apr 2024 06:06:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u+XqKRZG";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A26A113198
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 06:06:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bv+7TUfmE7piNthFBVzLo5ZTogfCp915Ex6hythdN5Lrkh4UGSOCO2lcKbDdBg/WuKwUuJP3h1fK5sbrIGHujaM7qcDPo4xIzjU5jb4vjwJEOXmSODtEjirDY+3wq1RPSoZjOmX6PaP1caPv/5gWspbiRrDR4/Xj1n1g60dnWicLMEef5Pr8UnWggG7CZJYrwOvZ4APimHKjHqj9+tn6mdMgw1SZCZifJPvxy0POb+ahsyadVCto6SxVpIjVMsJRB+5E2tyLwJVSQ0BqBN6GxzI5KVa9CCVfb9exnpiGsjl9Lfc2QOHEXESknskVpArGgaZrJIVRkeoX78brVIUAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kxVLtYz2t3aZBOHfzPW39YuXSRwC3iXX43BV4PPZZE=;
 b=THuHFjgW2qz/ZApELa1cZfIpBKYVfZ73Nq3N8mCTgzWQHMvrfTDLgKC6NTedNFew7G1wiW35LFHgoL2VRhx31dTlFftOEXhfEdDotXfJQmR28pYiV2lJpd+qmsSDfNaDA+9UMpquSr9V+gcP9QIUWDhhK5WHb3PDhpDJTM/FOux6GdL2OhXCc3rEOeUm8JGJQHL1kKPIIqlufNkO/7FuJZ93Bd9MHRbXb48FvOSbeWDi5hnwxQ2Ygj9WbJbUzeTmQf6+QNymOT2VSZuyTgPpo4yy+ZhfksWKciKDKp1ysbipIwclCZ//k4EuqBmlQdWuvIx5K/B85kZ7Z7A4voY73g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kxVLtYz2t3aZBOHfzPW39YuXSRwC3iXX43BV4PPZZE=;
 b=u+XqKRZG3AvTWO60AubM/ZFQ7/NpXTvIa1XWDSp+3+ooCx2Ld+4JEG4Y+ETFvMWVDuY6/TA+BXrjSKSGkb67vykZ20jgiadPW2DyQ5SSTxw8TOQgmRzXj9dkyDaDzAatgtd3ZcBujo3dag7yG+akVRf5iB11pCE6nn3E/yZbWz0=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Wed, 17 Apr
 2024 06:06:45 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7409.042; Wed, 17 Apr 2024
 06:06:45 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu/pm: Remove gpu_od if it's an empty directory
Thread-Topic: [PATCH] drm/amdgpu/pm: Remove gpu_od if it's an empty directory
Thread-Index: AQHakIuw9YkbG1DqCUaiXW8kV6tYybFr+bDA
Date: Wed, 17 Apr 2024 06:06:44 +0000
Message-ID: <PH7PR12MB5997CA49377E73DCB119260C820F2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240417055335.118441-1-Jun.Ma2@amd.com>
In-Reply-To: <20240417055335.118441-1-Jun.Ma2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SJ1PR12MB6172:EE_
x-ms-office365-filtering-correlation-id: e89533be-62b1-4672-7bb2-08dc5ea48f2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uAuBemQgdLnin2LARaqbaQiKTuxnVrde53KQn/PExiU17nqhY+hun76VlJpvZ4HRMFAC6KQasf/cTtyAdWPmGZzYyEV2g2PqfzXrhfuSjYF7bHLwJWVTUgReWzciQcBN9/l0SCPWtBJZxLP7QK2yxfGiUDthUJnUe2urziCI2NjZokbnI6YbO2Fd9jRuxSp2Dr4SEoeLvdBPCZ+Lk57k0OIAZ/4w1N4A0wfE1GKfvH7qLfXz1zD/i4gAJBSENRyNnLdmRL8tJXX9NXgkmMX+PWnnQaIWJgYeO2w+wgVkJ0T/mbIyls1CJ+yxOXfCYtFDUY0Blm2rrRypWtpd9Uts4E3y6/0THRsB2GwT4in04MT2PKlKKM+Au0Nfgso+ZrnhcI+LJLF1Gzh2xj+A2xor0zfhLHib6jg4lGC/7dUJni6RJxfDACqUSWuwTc93brHYDLOqOEqN/NDGYahp4X7H6qQRjoCvKxSMnQxfcaXlC4X2tej6h7nyACMmpzgWS27TOOZFnoMQheMosW4r10CZZNBng1UEjOf4sIPaFyRZ1mb5JW9X81ejUxUWmawQyGUZh7ZHskp7uF8VpEwLdCduOIQbx1dvySrKOJt2cLxXAknfJeH1ZEckwrP7pdEAWYVfiQlPL5fqWoWyOJJzTc6sr3H1nHnd0iGKeV4PkQdKNL2XhquhjEEFY5oxwWyfk5Bp8DxltLOeMz9vwmUBYm4iF5Vu8fsHC6Ct8OC/1WhbHts=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NGNoa0JBejBHeENIZnFyMDJicjZvbzkxSE1wM0hranpHdnR0R2xvYW5oWjlR?=
 =?gb2312?B?cmFHbEQ5c0ZVeVRrWTk2VG8xdGR1VEhQUHh1UkhPeDMxRUo2TDMwWjhpOUJ5?=
 =?gb2312?B?QXVTdXY4ZXZKVVRBcWp0RzhNc1BzVjJMdUVrQkhTM0pNZmIvSzR0NjNJdWRP?=
 =?gb2312?B?L1luanFjNWluK1dObzFsTEN0Tnd1TkhybmkvNktPNDdhNVFRSUxncnFUcUxi?=
 =?gb2312?B?UERwOHVSOGZwY2NHYXVLTnZ0S200amc3ajRscXg5dVg5QjNqa2wycUkxdDlG?=
 =?gb2312?B?RHpuTVM1RGt4QnRQY1gzMWZIZWFHK3BtaDBzTG5MUTFGSUt5SDBGM2pwamxC?=
 =?gb2312?B?MDBud3ZlYVN4V2lJWHR6RHlCVU1pV2w3a0pXT3BjbmtzQ1FnSUkrZW1kRk5r?=
 =?gb2312?B?U2ZJWXIzeGg2bS8yWGRSZUxRN1FxN1pFVzRmNlBha0ZxZVBtSEVvR1RLRmIy?=
 =?gb2312?B?WThoaDNIa3BlWmxad3d2RWgrTlBJY2M3QkpDWGVpaVZrTCtScFZVWFVEaHRI?=
 =?gb2312?B?b2ZWRW90cDMrZWhSaDhYQ09WOGkzTTF5RkZaM3Qwa2ZpeGNGVDNUc20ydXBO?=
 =?gb2312?B?TDEvSm9VbWY3TWJaM0hLbEd4Y0x0TThqWUpUQTJ4ZnlLalhoYjJ1UVNtZG9X?=
 =?gb2312?B?RGRiZVJzbmYzeE13U3Y5S09lZVFhV1BHTTZPRFRBNVJNaDk1LzFXcmhYTUpE?=
 =?gb2312?B?cHZCazVGWkpSMnhNNEtXQzlDalJVKzNzUXcyZWFZS1BjMTViRlhXVS8zUTdp?=
 =?gb2312?B?UFlwbXVtZ1pvUVlCWjUvZnFJcmZGTldzUElpMGtZeFBTOUhScEFzSGQyTXRo?=
 =?gb2312?B?WTBkRjdrZ3J3UXpBTzNNS1p5SkhhY3A1dUxSaFIzTXgrNXJ6cTdwQVJKbXhX?=
 =?gb2312?B?dmxsWnFPM05NZ1JBT2plM1pnZEpiQTFLdlZqbTUrdzlxMVdZOGtLS0tmWkwz?=
 =?gb2312?B?QkpXRzU5Y3h4b1VuY05mTG90V004ZGlkOEhjTkRTYy8rM05KdXFZYjkyMU1t?=
 =?gb2312?B?UFRxcUttNDVUdktCM1FpMUVmN3p1TUxLLzN6eGdFNlRkY1c2QUFMTitLUzFD?=
 =?gb2312?B?aHNEUFV4akZGUFRTWGVqbUpCUENSRXVCU01RM3hqdHI4YTgvc2ZqcnJ2QTlC?=
 =?gb2312?B?VXdVanFMTFdUVG16Y0dmS1dWR2Q0cGF3L3RQK1ljaVFQWXFTMWZkUWhhdkxq?=
 =?gb2312?B?RlVDUTg5UUc1bGdRcWZKYWF1NUthd0dEN21DRUZlMTBOcXRoY2VGNzYyT0U0?=
 =?gb2312?B?ZkZuWVVPR2JnUHc1Smg3cjFWeTNpZHRWbjFIYVBnQzRuamxtaHRjQlRRdENh?=
 =?gb2312?B?TE52bkdFWjBsUk4yU1FRd1Zxcmovc0FxRjVVR2ZRMlh5NUhGa1FxVndValdk?=
 =?gb2312?B?TXJNcktwRXRZQ0xvYklFMnhuUllBSnFobFovaDNlaXl0SXRBT3BEQTJFVllm?=
 =?gb2312?B?bXdnRXpSQ2hIZkN5cXN2U3E3ZUpWREo2c3FnUWl3Qk54TzMxSFpGWG5SMVRl?=
 =?gb2312?B?enF6dWhVdEZuczdtNFpXSU04VGpybSsyOWRCbHFGSXFXb0pjUHF3aGVLU2FI?=
 =?gb2312?B?QTNDRlVuWUduYUtGeXF2NEZoRjk3SDViSWZ4K1BIZXh4ajgybVlJUlUzQ0JO?=
 =?gb2312?B?Tklvd2tIV1pwTFhNQUVOYVVkeVZISmJLRU5IZEpTQlRQenNIYUxMdTJJQWlr?=
 =?gb2312?B?d21wSFVUbGJ0SWlNWDlIT3VBcVZPTFhEQTcxZVFkZDBuY043dTVTemZVNWpN?=
 =?gb2312?B?NGxKcEJOdTFDcnZKSWVvSkJRVTRKLzFLbCtMQm9SVzZXZEoyOE5UcU1CbHdG?=
 =?gb2312?B?WHJDZVp6TVZnTmJ1NC9xdEN4U0FObUpkc2pvTmlKZUsrS1ZsbHNLL3NCUnpY?=
 =?gb2312?B?UU92ZVowamVhQ213Y3VCSEM1dzB3WC9iUWU1Sm1PcldkV09Uc3o1d3dvZlhj?=
 =?gb2312?B?RXJEYlRMNkh0ZGMzb3M4Ry9yR2d3emdmWmo5SkxNVGt0RHdjL1JGejl1a2J3?=
 =?gb2312?B?SjhQcXZ3bWh3U0Jka0hoaWtOSVUwdm5BZ3o5RS9FRTV6S1R1alhva09ob2x1?=
 =?gb2312?B?Y05IL25sdDJzWnZVdE8rM2ozRXNyNWMwbUhQb251Y2JHcWE0V3grTUxZYlJm?=
 =?gb2312?Q?jTrA=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89533be-62b1-4672-7bb2-08dc5ea48f2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 06:06:44.9310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n5CLdEhJj/CCeNzEcLw/6QTIFjDdXl+ccWOXl1DCQsdbNXfIs8AQC9A/6+bWxK3+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172
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

UmV2aWV3ZWQtYnk6IFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCg0KQmVzdCBS
ZWdhcmRzLA0KS2V2aW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IE1hLCBK
dW4gPEp1bi5NYTJAYW1kLmNvbT4gDQpTZW50OiAyMDI0xOo01MIxN8jVIDEzOjU0DQpUbzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZl
bmdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPjsgTGF6YXIsIExp
am8gPExpam8uTGF6YXJAYW1kLmNvbT47IE1hLCBKdW4gPEp1bi5NYTJAYW1kLmNvbT4NClN1Ympl
Y3Q6IFtQQVRDSF0gZHJtL2FtZGdwdS9wbTogUmVtb3ZlIGdwdV9vZCBpZiBpdCdzIGFuIGVtcHR5
IGRpcmVjdG9yeQ0KDQpncHVfb2Qgc2hvdWxkIGJlIHJlbW92ZWQgaWYgaXQncyBhbiBlbXB0eSBk
aXJlY3RvcnkNCg0KU2lnbmVkLW9mZi1ieTogTWEgSnVuIDxKdW4uTWEyQGFtZC5jb20+DQpSZXBv
cnRlZC1ieTogWWFuZyBXYW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQuY29tPg0KLS0tDQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYyB8IDcgKysrKysrKw0KIDEgZmlsZSBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
YW1kZ3B1X3BtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9wbS5jDQppbmRleCBh
MjBlMDNlNjlkMzguLjBjMTNlNTUyMGU3NyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG0vYW1kZ3B1X3BtLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3Bt
LmMNCkBAIC00MzM4LDYgKzQzMzgsMTMgQEAgc3RhdGljIGludCBhbWRncHVfb2Rfc2V0X2luaXQo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQogCQl9DQogCX0NCiANCisJLyoNCisJICogSWYg
Z3B1X29kIGlzIHRoZSBmaXJzdCBtZW1iZXIgaW4gdGhlIGxpc3QsIHRoYXQgbWVhbnMgZ3B1X29k
IGlzIGFuDQorCSAqIGVtcHR5IGRpcmVjdG9yeSwgc28gcmVtb3ZlIGl0Lg0KKwkgKi8NCisJaWYg
KGxpc3RfaXNfZmlyc3QoJnRvcF9zZXQtPmVudHJ5LCAmYWRldi0+cG0ub2Rfa29ial9saXN0KSkN
CisJCWdvdG8gZXJyX291dDsNCisNCiAJcmV0dXJuIDA7DQogDQogZXJyX291dDoNCi0tIA0KMi4z
NC4xDQoNCg==
