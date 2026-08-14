Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C51C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 07:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0287710F356;
	Fri, 14 Aug 2026 07:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0aOWeWS2";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4447810F356
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 07:32:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNFTZ/cFPMLoC7OvIXlWyse+ZkzS3gUFK54MIvctcjmw5HwOWIvtpPHyEvNSNMVkC3cSdnWT73RZW2ZG2NOjg3OTJCERO0JmA0dNKf+mRCAMhSgjO4wkkHMpN97b6QAvFPAf5TlmutlHTKUwpqvll/Z6Ggpc3otDZ7V832pEvVoS75CpkzeDpmRkH+KbM86xqwBgsrQpYvpFjwqvgAMwFbxjMkydhCP4fZoVeXkCeDR9iSq/bqLV3VVFP7fInrEyzx4t71PzOS9D1vXUtmGSrv/7zkxyxdinmD98kZpF13glLtiNYQ5qytWvQPCnwP051h7KgI8ZIqd9cZ+tKQZG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPS+OK6BQs9BvQsDxu+4y+OWcvkRdJpl9AmoJZ17C3g=;
 b=mopD04vTyTYRxlX2qUFvgiOMpSYO74VGdXfyb768btrokP6NAMI9ftCAqkihMNOqHR2el5RcwxmKXadGgDl+pNxen3Z0V0Kq8rH4KIP70Bcf3udl+btIvjfqUXSTKVtsUdJINhv0Qi5qBT/oMab4oFN0J1pRkXcqBUws/FSse8xYD1ffyYoTZnIFUhBOMm6xXY6zcIvY4k3KwegLhrwVH/ytqT3L3Zjcd0UWD0WnaOcvP5s17ZzQSkhjX6U+5BdFP/VIZkkHrPlXiQtqwpCvcXCwqLBN4Dyg/OW0+WRibxhV4UvgJ2GwiwlvFHWR/HeRKGwQXV6zR7dloAwa2xzNVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPS+OK6BQs9BvQsDxu+4y+OWcvkRdJpl9AmoJZ17C3g=;
 b=0aOWeWS298obn6WpphkGyAKSe4gIFZuv9LJQk4hlT3tv05kkaxPb9+6pWdDA4EtN1Ih3Rx90qHn47hyAe5TMolTMyYHrMNFYOQScDloT8bRLqPISlVM8sQZSqOMTtL3Jg7CqO2QWUnyWZCQoZ1C8Ise0TwWmP5NyVlatXLMa6ts=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 07:32:13 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 07:32:13 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yuan, Perry"
 <Perry.Yuan@amd.com>, "Ghosh, Prerona" <Prerona.Ghosh@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: bind imported BOs when they are opened
Thread-Topic: [PATCH v3] drm/amdgpu: bind imported BOs when they are opened
Thread-Index: AQHdKio6WTemUBpq5E+S0zWGxAeus7abz3+AgAFYUMA=
Date: Fri, 14 Aug 2026 07:32:13 +0000
Message-ID: <CY5PR12MB63698D85D82F0D649474BDE5C1DA2@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20260812071414.1066241-1-yifan1.zhang@amd.com>
 <99f2ce1e-5b81-4fa7-90be-d3ed251440fb@amd.com>
In-Reply-To: <99f2ce1e-5b81-4fa7-90be-d3ed251440fb@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-08-14T07:32:02.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SJ1PR12MB6339:EE_
x-ms-office365-filtering-correlation-id: cb56592c-4cb2-4d6c-56cc-08def9d6289c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: eYb1pe3JxmiqeWla2lUEymA6XQ7i7EcQSebto5HqMEIcMoYMtvEdwutldvFYPtvZCTfDTen//KVFpa0AssV7oGEU9q0P3WQr78Ljy/xrcFXbYf8YKci+ErMLIPi4jH41dzTXqguPyaQjjQaEJ2ScuDBdzSzNoE67RrLxAHe1HUnj7B282XvPxM3Mn7CdQXYTPgfOxEiuu0uwdIGw1Yy2shSc4sSoNs+Qo7rq8FYjgObPpVfjF56LvdSfHUsj200pHatbvQBrsGqk/qyWMLKDUyZvMKykxg2bA1ljmASz9mm238ywiMbrXrqXBkeJ/qVr9YWkkNgbP247HBisK0bawVXB/J09QfFxhe8W65inORjCapuJHw9rv5exJXAnWROa7OsaI+TCa5iflJsvK+ZleAuSQyreu0HLj/wPKPACjWXaj4pEeITelSkhNl+uAXYtFfqfDKi7gVfRAgQqsqxYwyes5qUPdVWSQKYZZMGO1PVwZcLS5Ov8xfKaM+H7pl3qv4zKecDoIJ7V9zgqZlGtz/CHlkl+AI609d5xP7J8wVmQPciZm73GzMhw9X4syN9J2O19SDFX8i+Z6eY6v2MviEBo2xfas711vL/lfhHSiJVFJIGVg6Z6xzw5sjccAzfAcGv0MlK3eWgy7p809VRrP47YD4OmD5AG2XxeJCgPiWxXKtkjz2gFzRE78KLS3/h1LOritenXU+h8PF9/+c3QUSmO37Sb+RnuscoeYhN+JUM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1ZIWUFTSnFqNm1wWkFKRXkzZFJqcmM4UE1HNjNzbUdoa0ZCWnpuMVI1cERv?=
 =?utf-8?B?QXcyZWUyL1N5Mk9mRnhXYzRqSFp2bmUxMlFZZUhtdTl3c0ZONEdvWjJXelpv?=
 =?utf-8?B?YVBlUVZMSmxlUnVoU05wOXJaK09FaU9hTmpHclIyaFhHYnQ1SkpjMitReGlV?=
 =?utf-8?B?L25wN2VyRGlNUkoxZElxYjhhM3ZGcVFITUhrV1U2c1dQWHM4cHVHcDVEblJq?=
 =?utf-8?B?S1pzVGl6MnVhTS9oUkpuYVQrUHFmcFBUNTBWM3owME8wQlBIRGhaZXZrZHBI?=
 =?utf-8?B?RW9xN3MyaTlrQTVrczdyNXRMZTc5RTR1M0pQc0lQblhjVW1jWkthbXcxMmU0?=
 =?utf-8?B?clZiQnJJdGNrWm9KQjlFM3FiOUlnQ3BHV1VlWG1yaG9rdmNYeGJCSHJZeFlz?=
 =?utf-8?B?dHY5MFR2SC9uMWxxTGdDNWxKMG5ETjgzQUpCMTYrcUtIdXA3ZkZSVGxjOVZL?=
 =?utf-8?B?R09JWmxNYUEzaVZaNFVCSTR4YjJLREt6ZVhkVXVNUERtYS84ZmJoWjhWTitF?=
 =?utf-8?B?MXQvOFo1eGVTTWM4OE5uSU9BNmR4a1lhRG1ublVzTWR4MlhFandpZFdlYmhu?=
 =?utf-8?B?K0dDUGtTU09ySy90VUw0ckd5VUlBR3V4LzY3S2RZN2JxT0dway82TlJWcXZi?=
 =?utf-8?B?L05xS2JzSXYvRG9ZSWt1b3ZYeU5oNU5CaTVrb3VhTGsyOENjQkZzTEhUODJE?=
 =?utf-8?B?TFVvdVhVbmNhck9Vb0duMCtCcmcvYkdOOWQ2Z25GcHhQRmFIeVdzYVBDdU1s?=
 =?utf-8?B?bzVPbjJwRkZmU25hZm1ha242TWdZTnJzb1RCUGhERklpSkdCUHNMZ2JUa3dM?=
 =?utf-8?B?eHJKQ1pibkZzbEs1V1YxQm82V0dTZ3phWUpsYTRuUkx6aFJ0TW1CN0VqVnVU?=
 =?utf-8?B?YmEyL3V1eUhzeUZFNVZWbkJCZVJXTHRsa3lrREJoSUlmKzVmSkljcGlsSjFO?=
 =?utf-8?B?YmZBRmN1d3hETnV3SUFKb0FJVFlFK2pUa2paWEpaRmN5c1M1VGpDRG9LaS9w?=
 =?utf-8?B?SVg0azNUWGs1N0RaYmYxZjJ1L3lBOERBNTFuR203ZFdzVW9hSEVpbDJsdWUr?=
 =?utf-8?B?bk01YXdod1ZKSnBxYU1kc2U1V0J5QlpJTWZYQk5ML1diQzNHNlU4Y0dMQ0Fh?=
 =?utf-8?B?b3gyZkpSMG9NVmY3RXhYT2dnU2hqRkIvTjI4M3lrWXFpU1NmakVXWUlHcm9x?=
 =?utf-8?B?U1QxZ0ZlMy9SdDBnOVQ1MXVCZ1lTWE5VaUkwL0tvRHpuR3dNVnJWSGUydkVZ?=
 =?utf-8?B?NEhKMFMwQmZud0NyYVFhbVNZMm5vcEV2c09FeSt5eitHNFdIUTlBelJ3WERs?=
 =?utf-8?B?K1VzMndIN2ZZZGFpV3VLYksrQnFaaXFyakhCdWtqeEIzTjFwWE50Q1lpWHFL?=
 =?utf-8?B?bU01aS8zak56MTdtN205clVaL3JQOHJrajBTaGJkWDRWKzloUEhpcXZPdDAz?=
 =?utf-8?B?ekFpWnpQWHBoMnBGQWZUSVdCanRkL3FuY2l5Mm1wMHpRQ0RKbjY3WWRVTDVT?=
 =?utf-8?B?eXFCNFBsb2lqSnpaaGhUYkhYQ2pTK0laMlZsOUtZUnFDL3RaUHBiYWM1UEsr?=
 =?utf-8?B?ZTkrOGIveVRiR0VsMFkyRUlSNHprQTRnT2JHVUQ3UldRSG43NnpncGpJRDlx?=
 =?utf-8?B?N1lUd0dlREVmdW1VY0J6NjYzODdkVHhlcTN0WFE0aWwraE9naFB3TGVYZWJG?=
 =?utf-8?B?am8vOFBQMkxnbm5iWUtWcVhpdDRwQXpyUWhkY1cxckVTdUNQY2ZpZ3NBRzNo?=
 =?utf-8?B?N3QwLzNsbWJLaEkxMk5rK000dUk0QkVnOHZVL3ZNcnBibkhDOEFIL3JSMFZo?=
 =?utf-8?B?VjMvMU9UOEhwOGgzR1lCTCtzVlhKMkNxZGtOSDdYMTFBWlR1S2Y3aS9ITUpi?=
 =?utf-8?B?L1AyNytLRytzR3lPNHRiZU5hVjhyN05LNW5nS2FCOG9uVEpMRzFiamJ5ZjNP?=
 =?utf-8?B?RVl4WFlDWm5Qc0pySy9iSVNwYzBiVVg4byt5dFZqTlFaYnRmdEpoTktYbSt4?=
 =?utf-8?B?dTZab3JrMTBkOWNrclQyVlJLcmlPNWRqbDBYUmJSNEt1U1cyd0NTTVRXSWRs?=
 =?utf-8?B?bUJuUm9YU3AvOEJCY3ZiSnBCMTgyYjVTWEEzS0JLTm5HQ212TWlKNEdibXlh?=
 =?utf-8?B?ZnVPMHBkT2JMdytGeWc1QkQxdUF6YUUrOXUyaEdsNkFqMzNQRW16VFZsS3gw?=
 =?utf-8?B?eVk0c1hZOVpQNGhVaVhQWFU2eFNRL1R1N1liWWtJanVpVkxmVUc4d0pQSlJ0?=
 =?utf-8?B?OWUzTzhNbWpNRUpoc0lXNURDR005UDlOOUJTcWozNHhha3NhUEpnLzZ3WWZ4?=
 =?utf-8?Q?OYsOBo4M9AnjumO0CF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb56592c-4cb2-4d6c-56cc-08def9d6289c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 07:32:13.2811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2eJ4S7wIPylRdh+2ZtaKFI6KFoOJSTp/LUzB2uhrLolcF/IcNeWxBBuYPbt41D7v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339
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

UHVibGljDQoNCkhpIENocmlzdGlhbiwNCg0KSSB0aGluayB0aGF0J3MgYmVjYXVzZSBhbWRncHVf
ZXZmX21ncl9pbml0KCkgaW5zdGFsbHMgdGhlIHN0dWIgZmVuY2UsIHdoaWNoIGlzIHBlcm1hbmVu
dGx5IHNpZ25hbGVkLCBzbyB0aGUgdmFsaWRhdGlvbiBpcyBza2lwcGVkIGF0IG9wZW4gdGltZSAt
IGl0IG9ubHkgcnVucyB3aGVuIHRoZSBmZW5jZSBpcyB1bnNpZ25hbGVkLCB3aGljaCBpcyBub3Qg
dGhlIGNhc2UgdW50aWwgYW1kZ3B1X2V2Zl9tZ3JfcmVhcm0oKSBpbnN0YWxscyBhIHJlYWwgZmVu
Y2UuDQoNCkkndmUgc2VudCBhIHY0IHBhdGNoIHdoZXJlIHRoZSBmaXggaXMgbW92ZWQgaW50byBh
bWRncHVfZXZmX21ncl9hdHRhY2hfZmVuY2UoKS4NCg0KQmVzdCBSZWdhcmRzLA0KWWlmYW4NCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJp
c3RpYW4uS29lbmlnQGFtZC5jb20+DQpTZW50OiBUaHVyc2RheSwgQXVndXN0IDEzLCAyMDI2IDY6
NTMgUE0NClRvOiBaaGFuZywgWWlmYW4gPFlpZmFuMS5aaGFuZ0BhbWQuY29tPjsgYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20+OyBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgR2hvc2gs
IFByZXJvbmEgPFByZXJvbmEuR2hvc2hAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNd
IGRybS9hbWRncHU6IGJpbmQgaW1wb3J0ZWQgQk9zIHdoZW4gdGhleSBhcmUgb3BlbmVkDQoNCg0K
DQpPbiA4LzEyLzI2IDA5OjE0LCBZaWZhbiBaaGFuZyB3cm90ZToNCj4gRnJvbTogUHJlcm9uYSBH
aG9zaCA8UHJlcm9uYS5HaG9zaEBhbWQuY29tPg0KPg0KPiBETUEtYnVmIGltcG9ydHMgYXJlIGNy
ZWF0ZWQgdW5ib3VuZCBhbmQgbGFuZCBvbiB0aGUgVk0gaWRsZSBsaXN0LCBzbw0KPiBuZWl0aGVy
IGFtZGdwdV92bV92YWxpZGF0ZSgpIG5vciBhbWRncHVfdXNlcnFfYm9fdmFsaWRhdGUoKSBldmVy
IGJpbmRzDQo+IHRoZW0uIE9ubHkgdGhlIEJPIGxpc3Qgb2YgYSBjb21tYW5kIHN1Ym1pc3Npb24g
ZG9lcywgYW5kIGEgVk0gdXNpbmcNCj4gdXNlciBxdWV1ZXMgbmV2ZXIgcnVucyBhbWRncHVfY3Mu
IEFNREdQVV9HRU1fVkEgdGhlbiBwcm9ncmFtcyBQVEVzDQo+IGZyb20gYSBUVE1fUExfU1lTVEVN
IHJlc291cmNlLCBpLmUuIHdpdGhvdXQgQU1ER1BVX1BURV9WQUxJRCwgYW5kIHRoZQ0KPiBmaXJz
dCBHUFUgYWNjZXNzIGZhdWx0cy4NCj4NCj4gVmFsaWRhdGUgaW1wb3J0cyBpbiBhbWRncHVfZ2Vt
X29iamVjdF9vcGVuKCkgaW5zdGVhZCwgd2hpbGUgdGhlIEJPIGlzDQo+IGFscmVhZHkgcmVzZXJ2
ZWQgYnkgdGhlIGRybV9leGVjIGNvbnRleHQuIEdyYXBoaWNzIGFuZCBjb21wdXRlIFZNcyBub3cN
Cj4gZm9sbG93IHRoZSBzYW1lIHJ1bGUsIGFuZCBhIEJPIHRoYXQgY2Fubm90IGJlIGJvdW5kIGZh
aWxzIHRoZSBpb2N0bA0KPiByYXRoZXIgdGhhbiBoYW5kaW5nIG91dCBhIGhhbmRsZSB0aGF0IG9u
bHkgbWFwcyB0byBmYXVsdGluZyBQVEVzLg0KPg0KPiB2MzogdmFsaWRhdGUgaW5zaWRlIGFtZGdw
dV9nZW1fb2JqZWN0X29wZW4gKENocmlzdGlhbikNCj4NCj4gU2lnbmVkLW9mZi1ieTogUHJlcm9u
YSBHaG9zaCA8UHJlcm9uYS5HaG9zaEBhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBZaWZhbiBa
aGFuZyA8eWlmYW4xLnpoYW5nQGFtZC5jb20+DQo+IEFzc2lzdGVkLWJ5OiBDbGF1ZGU6Y2xhdWRl
LW9wdXMtNS4wDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dl
bS5jIHwgMTQgKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25z
KCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z2VtLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMNCj4gaW5k
ZXggZjc1NGE0YTNhMWMyLi4yNjEyMThjYjU3YTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ2VtLmMNCj4gQEAgLTI3MSw2ICsyNzEsMjAgQEAgc3RhdGljIGludCBh
bWRncHVfZ2VtX29iamVjdF9vcGVuKHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqLA0KPiAgICAg
ICAgICAgICAgICsrYm9fdmEtPnJlZl9jb3VudDsNCj4gICAgICAgfQ0KPg0KPiArICAgICAvKiBJ
bXBvcnRzIGFyZSBjcmVhdGVkIHVuYm91bmQgYW5kIGxhbmQgb24gdGhlIFZNIGlkbGUgbGlzdCwg
c28gbmVpdGhlcg0KPiArICAgICAgKiBhbWRncHVfdm1fdmFsaWRhdGUoKSBub3IgYW4gYW1kZ3B1
X2NzIEJPIGxpc3QgZXZlciBiaW5kcyB0aGVtIGZvciBhDQo+ICsgICAgICAqIFZNIHRoYXQgc3Vi
bWl0cyB0aHJvdWdoIHVzZXIgcXVldWVzLiBBTURHUFVfR0VNX1ZBIHdvdWxkIHRoZW4gcHJvZ3Jh
bQ0KPiArICAgICAgKiBQVEVzIGZyb20gYSBUVE1fUExfU1lTVEVNIHJlc291cmNlLCBpLmUuIHdp
dGhvdXQgQU1ER1BVX1BURV9WQUxJRC4NCj4gKyAgICAgICovDQo+ICsgICAgIGlmIChkcm1fZ2Vt
X2lzX2ltcG9ydGVkKG9iaikpIHsNCj4gKyAgICAgICAgICAgICBzdHJ1Y3QgdHRtX29wZXJhdGlv
bl9jdHggY3R4ID0geyBmYWxzZSwgZmFsc2UgfTsNCj4gKw0KPiArICAgICAgICAgICAgIGFtZGdw
dV9ib19wbGFjZW1lbnRfZnJvbV9kb21haW4oYWJvLCBhYm8tPmFsbG93ZWRfZG9tYWlucyk7DQo+
ICsgICAgICAgICAgICAgciA9IHR0bV9ib192YWxpZGF0ZSgmYWJvLT50Ym8sICZhYm8tPnBsYWNl
bWVudCwgJmN0eCk7DQo+ICsgICAgICAgICAgICAgaWYgKHIpDQo+ICsgICAgICAgICAgICAgICAg
ICAgICBnb3RvIG91dF91bmxvY2s7DQoNClRha2luZyBhIGxvb2sgaW5zaWRlIGFtZGdwdV9ldmZf
bWdyX2F0dGFjaF9mZW5jZSgpIHdlIGFscmVhZHkgaGF2ZSBhIHZhbGlkYXRpb24gdGhlcmUgZm9y
IHRoZSBleGFjdCBzYW1lIHJlYXNvbjoNCg0KICAgICAgICBpZiAoIWRtYV9mZW5jZV9pc19zaWdu
YWxlZChldl9mZW5jZSkpIHsNCg0KICAgICAgICAgICAgICAgIGFtZGdwdV9ib19wbGFjZW1lbnRf
ZnJvbV9kb21haW4oYm8sIGJvLT5hbGxvd2VkX2RvbWFpbnMpOw0KICAgICAgICAgICAgICAgIHJl
dCA9IHR0bV9ib192YWxpZGF0ZSgmYm8tPnRibywgJmJvLT5wbGFjZW1lbnQsICZjdHgpOw0KICAg
ICAgICAgICAgICAgIGlmICghcmV0KQ0KICAgICAgICAgICAgICAgICAgICAgICAgZG1hX3Jlc3Zf
YWRkX2ZlbmNlKHJlc3YsIGV2X2ZlbmNlLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIERNQV9SRVNWX1VTQUdFX0JPT0tLRUVQKTsNCiAgICAgICAgfSBlbHNlIHsN
CiAgICAgICAgICAgICAgICByZXQgPSAwOw0KICAgICAgICB9DQoNClNvIHNvbWV0aGluZyBkb2Vz
bid0IHNlZW0gdG8gd29yayBjb3JyZWN0bHkgaGVyZS4NCg0KQ2FuIHlvdSBrZWVwIGludmVzdGln
YXRpbmcgd2h5IHRoYXQgZG9lc24ndCBzZWVtIHRvIHdvcmsgZm9yIGltcG9ydGVkIERNQS1idWZz
Pw0KDQpUaGFua3MsDQpDaHJpc3RpYW4uDQoNCg0KPiArICAgICB9DQo+ICsNCj4gICAgICAgZHJt
X2V4ZWNfZmluaSgmZXhlYyk7DQo+DQo+ICAgICAgIC8qIFZhbGlkYXRlIGFuZCBhZGQgZXZpY3Rp
b24gZmVuY2UgdG8gRE1BQnVmIGltcG9ydHMgd2l0aCBkeW5hbWljDQoNCg==
