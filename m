Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43935C53219
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 07:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE30510EADF;
	Wed, 29 Jul 2026 07:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fynR8+o8";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ED7C10EADE
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 07:54:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4f3d62KCbtkjDZ5bwoJuk8YyPNOtiE/O5/TIqDd70OnOcCVqOinpE+AhUygN9EXe80EFmRhzWJuoHgCz8aD32eveiQ+KHtlHQHJkWzkyW5V6ZfBk73cR61f+bkDi9WFLl++/lAqjCOlM2oxU3OckXU/2lHHov+L9JVRFTX/aVX+REtL9h/jbXMZtInvWrPiMQmXid6guP0LxTo9UbqqYsPxBHNg+8OgxoGNyfaZKo9QU2YaO8FRo2oGiziLDIdG+lvI9S5zoZNZwFHISrZX3mebuNlEv18cG6mCJYVw+OIcRSw4TgQiWB5LGtI/PwMIBLYfLr5/Bzq0Qbxcr3ARKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIJDyiQuOTk4tPBN5k9vrCG0xCIgMMKF6HX1i9G4CHM=;
 b=c4FdK3CwclWODPMbgAB0HzoieErmdb/upxqYfSMKzTdG4w0CZz3yigmNL4jDIYGnj7E30ujjUIZuQeaYvdP43wee/n5QytEM0/8peweDu+4zAMS364md6sZ7GBpVXVBfPYs7HOaXaJP3BiSRfkXDEWZWQmcV8QLAji+78eOw4lmLP0o4WSxu5iyiHEh/Cr2GmjQPUaIIvqYYKlahjzfrVNgpCwUAs6VRU3djoM89ZQLNiWDhNqw+/Vexek8Yf8oP3lPEx/jsH+KcEl4KIw38ACu18Ms6LTng1gDzV5dYBlsTElJyjqHU0N8HWylNhDe3prH/JAPtFSaxXJB0Ztom4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIJDyiQuOTk4tPBN5k9vrCG0xCIgMMKF6HX1i9G4CHM=;
 b=fynR8+o8aSEK9toQVl+1pGQA3BJRubqWsgxpHNlPXtcCXdab5gzk+PKoSheNCO7VAO0Aju+0/qo2XnacJeKqk4BAajbs2n8XxwGC6p0wfOf9bkNV1nu8pnOPOzSR2dvUp5Fj1bbrJfWEcHa87QFJ9ftchVZCXusvF+7W5z+e+lw=
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Wed, 29 Jul
 2026 07:54:39 +0000
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::9e49:aeba:9265:f46e]) by SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::9e49:aeba:9265:f46e%3]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 07:54:39 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: remove obsolete gmc ras helpers
Thread-Topic: [PATCH] drm/amdgpu: remove obsolete gmc ras helpers
Thread-Index: AQHdHyv+1eePcHF2tkOvCWtKfRSCcLaEIBSA
Date: Wed, 29 Jul 2026 07:54:39 +0000
Message-ID: <SJ0PR12MB6967E63A033A2532E25319409DCA2@SJ0PR12MB6967.namprd12.prod.outlook.com>
References: <20260729072906.14285-1-Hawking.Zhang@amd.com>
In-Reply-To: <20260729072906.14285-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-29T07:52:32.4507586Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6967:EE_|PH7PR12MB8427:EE_
x-ms-office365-filtering-correlation-id: e1d4aa61-001c-4217-dc5a-08deed46a439
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|366016|376014|11063799006|56012099006|10067099003|18002099003|22082099003|8096899003|38070700021;
x-microsoft-antispam-message-info: qqFHaSCD/WyX45UakXJHtJvSTJVMeeMilbi7bKOVkm/PWyP+gb1+Z9EUDkfMebUW1XipcdmBAQEGNT6ilx9lp3JQxPmUF4wpuG6z/5K70NbWca04cqLAq5bANeK62S1C8b4WT9adRXn4q88gAeMLx7GukhNZtmgqUQ1xAC0v7IebVOUwW7shpIWaGWzZI+4lBtTJHaib9PoHwm/X/aaYLOQ3U2AAMqnG0ztQxMZveefBMzxSTQrzxqj8VQ4N5HVcUle2MFtBgYy3X2BE9rp6En3IBPv0KA5uDLqKTKqCIP1uGLO4WQGs3OA7va56AUv1y30OX4AUACMeh5+O3gBjzibwpdnJ4Ck+CRdVOk7leEXYAokpmI2UoIwm0s6SqqPtToD7aMw/mqUJWbzTx4jV58QHBYwplLMNw7Xir78DfUtbOn1+vLCicYE6XeSEusu6CyVXxA5b65mrHn65KrKZ7+66iLOipUJKPxkN2NQ8slvhXc+UJIumo+lR8EqVKb0Q9Pak5XrpXrX7ccBTUUI7bdpcUI4spSu+fW1a1R9RL91zdD8PSS+gMccVT91UG0O+YzhwYQHHHa1S+CG/B6G3TFpb9SJ5/VV1+3oXXykIVfHIDPNnC7A0q5DxuFLVZWXkts1cWAEbnlMaBiy1H1q/J4YDIAcNmQZq0qo29wS9BmfIAYYcAeNfVqX35v2Pfjpf3h0EHk60j9tYq4vK4jo+BEJR6sqBZu0x1LQzv36Ewx4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SJ0PR12MB6967.namprd12.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?K1FBOUd0S1M4STN3R0phK3R5OUFYVG0vTzVBS2ZQaUZZRUdNUVNCS1RuUDRi?=
 =?gb2312?B?T28wNGN1MlA4a0FFalpjRk5SVFVKSU9McXVCbE5iZVdxekhrYmg5Y1k1bmFF?=
 =?gb2312?B?YUpLSDJacXBVWUpFZ2tQbzlRdjhBNDJhNUZHbU8xc1VzWWE4M1oreThEU3Nz?=
 =?gb2312?B?d1I0dC9LTk5HblhyVVVBaEVaWm9ObjJHVW1KY2M5UDVlWEFHdEtNb2xJNTNL?=
 =?gb2312?B?UmZRM3g5NnErR09RbHliSnF4VUVBSy9EOVQxcVVvbENUYUNselpRMHFMbVlJ?=
 =?gb2312?B?cFE3MHFPZXNFUkRGTVlaT1BjNU9xcEtyOWE3d296OUo4SStYODVvQUhkdDdR?=
 =?gb2312?B?VEVYampVT05DSm5UTHhDdGN4WnFvOG4zVkNLbkZacmxrWTFjdGZlekVZWEFP?=
 =?gb2312?B?U3M4S0RGdENaWlh0TWFPNjlUY0UxMk1GbmoyNitydzNNcS9xMWgxV0JXOVpK?=
 =?gb2312?B?NmpBNzJhUkZ6STFQZVRGTlNNT0o1MHI3VnNDNDhyOHU3R2wwQzdZSlMrWGhS?=
 =?gb2312?B?T1FyenU3ZGJEZUtPME9QRDJnU01QUzJEdW5zYkdnQjMxQUtIS3FiMmltcVlY?=
 =?gb2312?B?YUZUalFJSVRYYTN2ZzZZSmJWWkh2dU5lS0lCcGZXUmxzcUt3MGIvUVFxU1ow?=
 =?gb2312?B?QmV1T1J6Z3I5QzFTOUJBU28xZjBkY2JMdFZZMXl6bHFSU2ovMEhiK1padzAw?=
 =?gb2312?B?MTE5UzZNdXNlQy9QcFo1NDEvR1RSUGtWY29OckpjQkZZc1pwd0VNY1Z4VmhK?=
 =?gb2312?B?SExIVWQ4ay8rOWgvYTU0RGRWUWMzZ2NUZTZRQlpYV24zdkFJeDFRZitCeExt?=
 =?gb2312?B?bHYxR29mQ0lLZ05sY2VnT2JNU1dBSDlXK2pFUFV6SldvekVlN2lDMmI0K29N?=
 =?gb2312?B?T3JPcm1xbEthUVlLazAvWVQwQjdnLzJqdU1ZQ0Y3czZ3V2ErcFRxQnBpS2p2?=
 =?gb2312?B?WmlzNzcxWkdyRGJVYzZubXRuWlNtZjZMT0tLbExvQWZINGdNS2d6d3pRa0JF?=
 =?gb2312?B?REo2c1hQRFBPTzV4aE5Odmlha1dPRTBlemw1V016WUpXSzhYZWhXYlQzTmNS?=
 =?gb2312?B?NjVSZGRrTndldVlLQzJBd1pBQmJScnNuR1VxdExCZ2Z6TmNPdWFTN1RzdEZX?=
 =?gb2312?B?Y1ZDTXJhQjNnb01BLzFQd0w1aUM0VUc5NUtOOVpNNm9YaitBWm9WNDNDWmZO?=
 =?gb2312?B?Skh6dkJTZUIwaUs4dlJSWmwvWGZCejg1VDVWaTRlZnVaL2dmNnVXME85eGFE?=
 =?gb2312?B?c2pxKzB3Zk5iYjFQSkMrSVlDQTgwSTR3UDZrcGxjYjF5S0NCSU9kS0h2aS9v?=
 =?gb2312?B?RWt3T2hwSDV5N0FxOGRjWVp2L2RYSE4xYkQ4dWhBeTlTcG9qSTVraUg1bEUv?=
 =?gb2312?B?VUp5UmNacmpwbklQbFl5MjJKRGUyU1NOdjVNaFl2bjljcFZzalZMUEE4cW1W?=
 =?gb2312?B?Nlk4ZWRXd2QrOUF6ZGVSOHNUOTFZU2xoUldlbWFYQlVMNnJxc09NOGNEaEd4?=
 =?gb2312?B?MDFUaHJmQXA4cjlNS1o2enFwRDBKdk16c0plbWdSMVJMZjhyU0xuRW94WW1Q?=
 =?gb2312?B?YmFFaUJ1Ym9maCtqdTlsK2IwN2VJNnRDSkxuRTZZZEpwQ1QwTnhtV2N1YTdP?=
 =?gb2312?B?b2FBcURKRzZoaDFUY1dYK1NNaW1IMFRxeHBUMHZFYkdoTllTenVMZ2JscThM?=
 =?gb2312?B?ZUJtQXNNbE0vS0h5TjUxdVJYem5SUXZiWk8xTE5LdzB5VFlJWTJ2eU5iQXdF?=
 =?gb2312?B?b3JacG9lTW9SZ3NqR2JhU3dSNkNVYlVaTnl2aWEwaXBlMVZyUXoxZlpqQkZJ?=
 =?gb2312?B?b2RpdTFsOTN0RWI3RGQ5aEJBbVpnMnhzMXRJaSthRE1XVDhQZllGY29aVmly?=
 =?gb2312?B?ampidHVnbzZpSUlRbnlvRXluSDI5S3NwRm11V29JVzlwYnJ3QTNOV3F5amtX?=
 =?gb2312?B?dDIwSGppRGdyalQxeDhoREUwSStVb1hFdDQxQm1lTUc1S1NnK2JEblljOHJj?=
 =?gb2312?B?QWNJdDlyT1dnamV5bXNNaCttcmg5b0p5a3VQcEFrc2ZZVUZhbjZad0hqSWty?=
 =?gb2312?B?UkhyS1pSdTRzbHBMSnh4RWo2NU5HczN6MUxUTGs0cm5jQW9wcFhsVGtDSUlS?=
 =?gb2312?B?UklaOFY2UHZMMElmdldBSDRZMmp3cUNSWlYxS1FSdWwwM3NWdEhJZUl1Y0tP?=
 =?gb2312?B?TlJTODJ3Tmc1VUlTNmZBbGY4RTJyNXhkeGtxYkIvZlNROXFBMldveElidXpr?=
 =?gb2312?B?TlpvZk85cGFjb3gvWVBQZGdzS2o0eExITVpXMFJSZHdid0JmRWRuaSs2eUJB?=
 =?gb2312?B?aElEeTFjeE1rNFRyVUdYbmZCVEcvZWswbSs3L3dQRlFRTTMwT0RrOW5vQjRZ?=
 =?gb2312?Q?A96AtwuvL1+MGx/mhQVA80JYRwYQto+cvvZQGiAMcPU/G?=
x-ms-exchange-antispam-messagedata-1: GRxLaZiMv1KjSg==
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB6967E63A033A2532E25319409DCA2SJ0PR12MB6967namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6967.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d4aa61-001c-4217-dc5a-08deed46a439
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 07:54:39.1855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: llsvLTYjBxaGpofkz/hC9IZuQKJKkNoYNwKwACCgooSKEccEDOb0bqpEwnQPklXGOpkctMEAmTMV00/faJR90w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427
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

--_000_SJ0PR12MB6967E63A033A2532E25319409DCA2SJ0PR12MB6967namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

QU1EIEdlbmVyYWwNCg0KSGkgSGF3a2luZywNCg0KVGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUu
DQoNClJldmlld2VkLWJ5OiBDZSBTdW4gPGNlc3VuMTAyQGFtZC5jb20+DQoNClRoYW5rcywNCkNl
IFN1bg0KDQq78cihIE91dGxvb2sgZm9yIGlPUzxodHRwczovL2FrYS5tcy9vMHVrZWY+DQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBaaGFuZywgSGF3a2luZyA8SGF3
a2luZy5aaGFuZ0BhbWQuY29tPg0Kt6LLzcqxvOQ6IFdlZG5lc2RheSwgMjkgSnVseSAyMDI2IDE1
OjI5OjA2DQrK1bz+yMs6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZz47IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPjsgU3Vu
LCBDZShPdmVybG9yZCkgPENlLlN1bkBhbWQuY29tPg0Ks63LzTogWmhhbmcsIEhhd2tpbmcgPEhh
d2tpbmcuWmhhbmdAYW1kLmNvbT4NCtb3zOI6IFtQQVRDSF0gZHJtL2FtZGdwdTogcmVtb3ZlIG9i
c29sZXRlIGdtYyByYXMgaGVscGVycw0KDQpSZW1vdmUgdGhlIG9ic29sZXRlIGdtYyByYXMgaGVs
cGVycyBpbmNsdWRpbmcNCmFtZGdwdV9nbWNfcmFzX2xhdGVfaW5pdCBhbmQgYW1kZ3B1X2dtY19y
YXNfZmluaQ0KYW5kIHRoZWlyIGRlY2xhcmF0aW9ucywgYW5kIGNhbGwgc2l0ZXMuDQoNClNpZ25l
ZC1vZmYtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCi0tLQ0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYyB8IDEwIC0tLS0tLS0tLS0NCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmggfCAgMiAtLQ0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jICB8ICA0IC0tLS0NCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nbWNfdjExXzAuYyAgfCAgNCAtLS0tDQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ21jX3YxMl8wLmMgIHwgIDQgLS0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dtY192OV8wLmMgICB8ICA1IC0tLS0tDQogNiBmaWxlcyBjaGFuZ2VkLCAyOSBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9n
bWMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYw0KaW5kZXggM2Rh
NTAxMzJjNWQwLi4zZGM4ZmFhMDkxZDcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ21jLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9nbWMuYw0KQEAgLTYyOCwxNiArNjI4LDYgQEAgaW50IGFtZGdwdV9nbWNfcmFzX3N3X2lu
aXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQogICAgICAgICAgICAgICAgIHJldHVybiBy
Ow0KDQogICAgICAgICByZXR1cm4gMDsNCi19DQotDQotaW50IGFtZGdwdV9nbWNfcmFzX2xhdGVf
aW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCi17DQotICAgICAgIHJldHVybiAwOw0K
LX0NCi0NCi12b2lkIGFtZGdwdV9nbWNfcmFzX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpDQotew0KLQ0KIH0NCg0KICAgICAgICAgLyoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZ21jLmgNCmluZGV4IDNjYTE4N2Y1YWRlOC4uYzA4ODQ3OTdkZDU0IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oDQorKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmgNCkBAIC00MzgsOCArNDM4LDYgQEAgaW50
IGFtZGdwdV9nbWNfaGFuZGxlX3JldHJ5X2ZhdWx0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgbm9kZV9pZCwNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCB3cml0ZV9mYXVsdCk7DQogaW50IGFt
ZGdwdV9nbWNfcmFzX3N3X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOw0KLWludCBh
bWRncHVfZ21jX3Jhc19sYXRlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOw0KLXZv
aWQgYW1kZ3B1X2dtY19yYXNfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7DQogaW50
IGFtZGdwdV9nbWNfYWxsb2NhdGVfdm1faW52X2VuZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dik7DQogdm9pZCBhbWRncHVfZ21jX2ZsdXNoX2dwdV90bGIoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsIHVpbnQzMl90IHZtaWQsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWlu
dDMyX3Qgdm1odWIsIHVpbnQzMl90IGZsdXNoX3R5cGUpOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ21jX3YxMF8wLmMNCmluZGV4IDZiZTIwMDBjODI2MS4uYzcwNjU3YmMwODliIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMNCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jDQpAQCAtNjQwLDEwICs2NDAsNiBAQCBz
dGF0aWMgaW50IGdtY192MTBfMF9sYXRlX2luaXQoc3RydWN0IGFtZGdwdV9pcF9ibG9jayAqaXBf
YmxvY2spDQogICAgICAgICBpZiAocikNCiAgICAgICAgICAgICAgICAgcmV0dXJuIHI7DQoNCi0g
ICAgICAgciA9IGFtZGdwdV9nbWNfcmFzX2xhdGVfaW5pdChhZGV2KTsNCi0gICAgICAgaWYgKHIp
DQotICAgICAgICAgICAgICAgcmV0dXJuIHI7DQotDQogICAgICAgICByZXR1cm4gYW1kZ3B1X2ly
cV9nZXQoYWRldiwgJmFkZXYtPmdtYy52bV9mYXVsdCwgMCk7DQogfQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nbWNfdjExXzAuYw0KaW5kZXggYzQwZDljNDY3MjA0Li43ZTYxMmY5NDczNDkg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjExXzAuYw0KKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMV8wLmMNCkBAIC02NDYsMTAgKzY0
Niw2IEBAIHN0YXRpYyBpbnQgZ21jX3YxMV8wX2xhdGVfaW5pdChzdHJ1Y3QgYW1kZ3B1X2lwX2Js
b2NrICppcF9ibG9jaykNCiAgICAgICAgIGlmIChyKQ0KICAgICAgICAgICAgICAgICByZXR1cm4g
cjsNCg0KLSAgICAgICByID0gYW1kZ3B1X2dtY19yYXNfbGF0ZV9pbml0KGFkZXYpOw0KLSAgICAg
ICBpZiAocikNCi0gICAgICAgICAgICAgICByZXR1cm4gcjsNCi0NCiAgICAgICAgIHJldHVybiBh
bWRncHVfaXJxX2dldChhZGV2LCAmYWRldi0+Z21jLnZtX2ZhdWx0LCAwKTsNCiB9DQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEyXzAuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTJfMC5jDQppbmRleCA4NGM5MzM2NGQyMjAuLmIwNTQ2
NWRjMzBiNCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTJf
MC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEyXzAuYw0KQEAgLTY4
MiwxMCArNjgyLDYgQEAgc3RhdGljIGludCBnbWNfdjEyXzBfbGF0ZV9pbml0KHN0cnVjdCBhbWRn
cHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQ0KICAgICAgICAgaWYgKHIpDQogICAgICAgICAgICAgICAg
IHJldHVybiByOw0KDQotICAgICAgIHIgPSBhbWRncHVfZ21jX3Jhc19sYXRlX2luaXQoYWRldik7
DQotICAgICAgIGlmIChyKQ0KLSAgICAgICAgICAgICAgIHJldHVybiByOw0KLQ0KICAgICAgICAg
cmV0dXJuIGFtZGdwdV9pcnFfZ2V0KGFkZXYsICZhZGV2LT5nbWMudm1fZmF1bHQsIDApOw0KIH0N
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jDQppbmRleCAxZmNjMDU5NGZkMGEu
LjExOTI2ODI3MzUzMCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dt
Y192OV8wLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMNCkBA
IC0xNjQwLDEwICsxNjQwLDYgQEAgc3RhdGljIGludCBnbWNfdjlfMF9sYXRlX2luaXQoc3RydWN0
IGFtZGdwdV9pcF9ibG9jayAqaXBfYmxvY2spDQogICAgICAgICAgICAgICAgIGFtZGdwdV9yYXNf
cmVzZXRfZXJyb3JfY291bnQoYWRldiwgQU1ER1BVX1JBU19CTE9DS19fSERQKTsNCiAgICAgICAg
IH0NCg0KLSAgICAgICByID0gYW1kZ3B1X2dtY19yYXNfbGF0ZV9pbml0KGFkZXYpOw0KLSAgICAg
ICBpZiAocikNCi0gICAgICAgICAgICAgICByZXR1cm4gcjsNCi0NCiAgICAgICAgIHJldHVybiBh
bWRncHVfaXJxX2dldChhZGV2LCAmYWRldi0+Z21jLnZtX2ZhdWx0LCAwKTsNCiB9DQoNCkBAIC0y
MDYzLDcgKzIwNTksNiBAQCBzdGF0aWMgaW50IGdtY192OV8wX3N3X2Zpbmkoc3RydWN0IGFtZGdw
dV9pcF9ibG9jayAqaXBfYmxvY2spDQogICAgICAgICBpZiAoYW1kZ3B1X2lzX211bHRpX2FpZChh
ZGV2KSkNCiAgICAgICAgICAgICAgICAgYW1kZ3B1X2dtY19zeXNmc19maW5pKGFkZXYpOw0KDQot
ICAgICAgIGFtZGdwdV9nbWNfcmFzX2ZpbmkoYWRldik7DQogICAgICAgICBhbWRncHVfZ2VtX2Zv
cmNlX3JlbGVhc2UoYWRldik7DQogICAgICAgICBhbWRncHVfdm1fbWFuYWdlcl9maW5pKGFkZXYp
Ow0KICAgICAgICAgaWYgKCFhZGV2LT5nbWMucmVhbF92cmFtX3NpemUpIHsNCi0tDQoyLjE3LjEN
Cg0K

--_000_SJ0PR12MB6967E63A033A2532E25319409DCA2SJ0PR12MB6967namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
Hi Hawking,</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
The patch looks good to me.</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Ce Sun &lt;cesun102@amd.com&gt;</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
<br>
</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
Thanks,</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
Ce Sun</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, =
-apple-system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" id=
=3D"ms-outlook-mobile-signature" dir=3D"auto">
<span style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robo=
to, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">=
=BB=F1=C8=A1
</span><a href=3D"https://aka.ms/o0ukef" style=3D"font-family: Aptos, Aptos=
_MSFontService, -apple-system, Roboto, Arial, Helvetica, sans-serif; font-s=
ize: 12pt;">Outlook for iOS</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> Zhang, =
Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> Wednesday, 29 July 2026 15:29:06<br>
<b>=CA=D5=BC=FE=C8=CB:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.=
freedesktop.org&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Sun, Ce(Overlord=
) &lt;Ce.Sun@amd.com&gt;<br>
<b>=B3=AD=CB=CD:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>=D6=F7=CC=E2:</b> [PATCH] drm/amdgpu: remove obsolete gmc ras helpers</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Remove the obsolete gmc ras helpers including<br>
amdgpu_gmc_ras_late_init and amdgpu_gmc_ras_fini<br>
and their declarations, and call sites.<br>
<br>
Signed-off-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 ----------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |&nbsp; 2 --<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp; |&nbsp; 4 ----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c&nbsp; |&nbsp; 4 ----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c&nbsp; |&nbsp; 4 ----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp; |&nbsp; 5 -----<br>
&nbsp;6 files changed, 29 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c<br>
index 3da50132c5d0..3dc8faa091d7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
@@ -628,16 +628,6 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)<br>
-{<br>
-<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.h<br>
index 3ca187f5ade8..c0884797dd54 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
@@ -438,8 +438,6 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 node_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool write_fault);<b=
r>
&nbsp;int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev);<br>
-int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);<br>
-void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);<br>
&nbsp;void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vm=
id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vmhub, uint32_t flush_type);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c<br>
index 6be2000c8261..c70657bc089b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
@@ -640,10 +640,6 @@ static int gmc_v10_0_late_init(struct amdgpu_ip_block =
*ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gmc_ras_late_init(adev);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_irq_get(adev=
, &amp;adev-&gt;gmc.vm_fault, 0);<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c<br>
index c40d9c467204..7e612f947349 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
@@ -646,10 +646,6 @@ static int gmc_v11_0_late_init(struct amdgpu_ip_block =
*ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gmc_ras_late_init(adev);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_irq_get(adev=
, &amp;adev-&gt;gmc.vm_fault, 0);<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v12_0.c<br>
index 84c93364d220..b05465dc30b4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
@@ -682,10 +682,6 @@ static int gmc_v12_0_late_init(struct amdgpu_ip_block =
*ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gmc_ras_late_init(adev);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_irq_get(adev=
, &amp;adev-&gt;gmc.vm_fault, 0);<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c<br>
index 1fcc0594fd0a..119268273530 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
@@ -1640,10 +1640,6 @@ static int gmc_v9_0_late_init(struct amdgpu_ip_block=
 *ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__=
HDP);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gmc_ras_late_init(adev);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_irq_get(adev=
, &amp;adev-&gt;gmc.vm_fault, 0);<br>
&nbsp;}<br>
&nbsp;<br>
@@ -2063,7 +2059,6 @@ static int gmc_v9_0_sw_fini(struct amdgpu_ip_block *i=
p_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_is_multi_aid(ad=
ev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_sysfs_fini(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_ras_fini(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gem_force_release(a=
dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_manager_fini(ade=
v);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gmc.real_vra=
m_size) {<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SJ0PR12MB6967E63A033A2532E25319409DCA2SJ0PR12MB6967namp_--
