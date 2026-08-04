Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F439C5518F
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 09:44:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A3010E97A;
	Tue,  4 Aug 2026 09:44:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RNfa0CH3";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D2F010E97A
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 09:44:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/qX7U+ZWXyP94eOIO/Z1UhvwnwD0aKEeQEcodxxv55HyxkqX68ayj6uZi5C0TNW1vdal8wTts+ST8CkRRIvhhzpFD3jXNmqJiGLyume3wWvArIi4aFGtd+piSWll794dXb2rT417VSS6jqEj9mqsLEDhICvzzxZahVC8IBCNwNX2GEc9LrxaCu+0fW3iV8mC7dRzr4+i/D0EXq030pnsPKYpfXk4SKDZje3HBu61EzqrGgP1/rILDjDYLDH+IUIqcyZ6HHnDtruEjGnAwCXAtzFc9QdoPYNQ7KWzPI+tfk7J6/4J5H5hth/9W0I/kSbIT00qYbYtkFo4ToCbq2CoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/Jj9enXajEWsZPjkHlRVUc4oODYW/zlirSDhOONEIQ=;
 b=ZJd8nzgwU8DYx4/aBLaA/Qhkt37yA7vmMHe0LLNSrqUC1iQ5QCG3F/NXLSPXWXc2FJjSarbBvLa6s/HtimSE26P7aadpSU6wGb48jKUVrst4X5cwdzLiyalBRs9CS2/eA525GZK4/rFdn9A26U7WeniNRI7rcZjFIQPD+nedjXOqrGC8c+0a/IylQCiXVw5YDtEyWhsR1XGkeKk7Ugey93jpHVWldW6pL8Kiv5x6w7BKFHguIFig6LNty//QcgGAru7yLwD/O91ddbeKZCMC8+JPBVXzW6Ccnky/i84a0ILbCC93dNAX/+P2MeCrklXEl7ph9aVLc57K6JOavb3usw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/Jj9enXajEWsZPjkHlRVUc4oODYW/zlirSDhOONEIQ=;
 b=RNfa0CH36hT5muZiFPgHNYNzoPL4lfqbPNKEgx5mmOgMOUvG81DZnr+RtPogaKLoC3GppeLSlGtJKRX+7RenUGpUPH7PLW1Cjk8qxNv/HXQizlPrebCPCzwCGzHvH2rSbUBf+piZtNY3Bgl43USZ1eJFToF3fT/15HMuHh6/DI8=
Received: from IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 09:44:40 +0000
Received: from IA1PR12MB7661.namprd12.prod.outlook.com
 ([fe80::6e9a:f2bf:3d9a:2a3]) by IA1PR12MB7661.namprd12.prod.outlook.com
 ([fe80::6e9a:f2bf:3d9a:2a3%4]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 09:44:40 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: reject oversized IBs with per-ring packet
 limits
Thread-Topic: [PATCH v2] drm/amdgpu: reject oversized IBs with per-ring packet
 limits
Thread-Index: AQHdIzJNn3coV5px7EOYiCl6QDL5KLaMWkkAgAFKfbA=
Date: Tue, 4 Aug 2026 09:44:39 +0000
Message-ID: <IA1PR12MB7661EF0F9B2EE367BBBDDA9891D42@IA1PR12MB7661.namprd12.prod.outlook.com>
References: <20260803102416.3776005-1-candice.li@amd.com>
 <CADnq5_ONAK8PdFjTE85A6kCNTJ96bOiybMek_GgPKBL=yqHqVg@mail.gmail.com>
In-Reply-To: <CADnq5_ONAK8PdFjTE85A6kCNTJ96bOiybMek_GgPKBL=yqHqVg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-04T09:42:37.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7661:EE_|MW4PR12MB6755:EE_
x-ms-office365-filtering-correlation-id: 431c2463-b7aa-4e31-5ed6-08def20d011a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|10067099003|11063799006|4143699003|3023799007|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: me+KEkjWhGw1zx739C3z2PWkRHLScIu40IBTUMJQuVi6d/O7MFFvvgaiMkyAz/xp3HjvVYUtDhVid1oGAOLmNUmG2gH93ZZV9CU0FNAr5bolPoayge0vvM3VPkp80S7+BvOpKjWo9eBt4iMgzDn912I12QpkFw8KXGyzFsD1CYHH2yxoZlW+j5szg4uYUILmwTgm6GXMJr51nFrFI7RHMW1ZNfOTWeKEnrGGgspl/4jwhQGXslsQcPyGhT0m50DHmnuN8Gzrd5R6G046M4Mh5T2XEXeE8k5mLSEpd+6txShYRa1vNnqjlJLBlit0RQ94MdekFs8H74cJDoysQQFIJi0hUj3tIp/OVPcEC11mF5R6tlRNAR9xWI+uC8fe2MvSE/JRQOF9QfzL8H+70mjmmuo8jHGMOxsEK4o+1RXPi34eLphUlOtZO97AWg2yXEIYoflYsIcl8HxOe/csN6leQJAs/MOO7jadoM5l8iCUB1qZHwet5+D+t9yhnHUtB90rYqCKSPGE3LSAwuNRrlWCeYzKVBtGI0DnlV0U+7dI9qfrSU1eEAhIriiScnB1vTRfqsPE9LCbDCJ6C1GJ+XN91j5PCsOMX5ROy/YuStZsIMI+OHPOw5gV8yk5ukTmqudBty+J4uQ5a5egNwnbFRaFx26799rSNooGjTRz6Fvm3fUvVKNSZWB7MU4p+oS8rPISv2VaNHF704T8XZaB8smV6Zugg/FQuDamsK7CPqYn+Zk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB7661.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(4143699003)(3023799007)(6133799003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFJCQnU4QldZSGswVlVpdVhMWkxCaDMvZC9ZUzBMcDFUQXl0VFo3bHF5UkhU?=
 =?utf-8?B?Zk8wK2tZSXVvK1BqNkdYSEdsajd3b2RBeElEUWtEMlZ6WVZZZDZ0ckUybHh0?=
 =?utf-8?B?T1ZpejBBekt0MFlWbEhDTjJpZWpSNmkvdEdhcndpZzJnaFVUSzVjdXhvL2ZQ?=
 =?utf-8?B?ajdpV2hWaHg1WWtwTW1KS2pGMHpKeHVRTG9jVEhuaEVaWTZQT2YvdjdHYlE4?=
 =?utf-8?B?aDViK1NXNGRobTBOcWNlMzM1a0RiNnYzWmVpQkZZR1haWFZOYUl2QW95NmdC?=
 =?utf-8?B?WFI3OXF6eU55UWtNUnFYOENZZGdzT24vQTIwQ08vSzNGeG82V3E3QnBockNo?=
 =?utf-8?B?enplOWlRdk05Umd1STh2bEFRL0pmVTRsb0FadnRybjJ5bzZqeWE2K0srL1VH?=
 =?utf-8?B?Z0NuRmVZL0o4bjJsWjVKdFo3MmdzTDhOaU1yeEpBQzJBYmVjTUg4L2NYaEYv?=
 =?utf-8?B?Zi9UZmJjZjN0V1haam5sL2k2QTRTZzFKenJmelI3YUx1V0cyMEhJdTBCWFhO?=
 =?utf-8?B?bmI5QXZtc1BScU1ucWpEOHM4VDhZMFNYbUp0NlIzR3JKWnVvTENudUx1RDBt?=
 =?utf-8?B?RWVZSmZzZDFtQmozYUVBVFdZT2FxMFp2Yi9weXVRenZPbk0rREpKRGVNYWNo?=
 =?utf-8?B?Y2duZTVqSkE3NVlrQktoWldjSkVyNmNDdXpCNkJHQWNsY2JaT1pTREF4UE5N?=
 =?utf-8?B?cE1nM0dSR0srWHozTSttS0JOdGlPRk85SVgvZzlzeUxNbVk3cmRodWJkS2ZB?=
 =?utf-8?B?akZoeWJPVkppZWdOeEZpMkhPTFQ1cUxuYm5FNjl0dmtsNTJ0SmlHVE9Xdnl1?=
 =?utf-8?B?YXoxNGZFK25HRC9Ob1QvKzUvNExOTTR5ZkpkbEdIS0xqNjZCSUc2T3hTdkVF?=
 =?utf-8?B?dDY5MnFoN1BIN2kvTHkrWjRubTJzUy9iak5mdFV5dFR3S1RKaFlNazlhSnMy?=
 =?utf-8?B?bEtsdDdubFZyMURkaDFaVlNCTGJqcStvaFdkQUpWbE1YMDBvQVUwdS82amEx?=
 =?utf-8?B?dlZDMGZPN0wxV1djYWNsT3JZb1RJUThTTy9qUkZpZTM3Qy84OCtBWmlPdVlm?=
 =?utf-8?B?SWpmazFrTE1xQSs3a0ZoVGJFaHR6RzNQRWJlNkRjVmd2d2pPMFB5dys4ZmZo?=
 =?utf-8?B?OHU1OEIwTjBma1NRRVd6dThld2lybDBCMllybHVPeXVIVEpyNlgzVlVCQTAv?=
 =?utf-8?B?UmtyTjMwOXZ1cHZxb3prbTR5eGJtanpEYVFYR0czcWR5M1lzZVpDN1JTazFL?=
 =?utf-8?B?am9SYWxGeGhhaGkwbis4U0xDTFM1dVorSHhRc3pOd0lsclRKZEtIYTlPblZq?=
 =?utf-8?B?UUNGbGVsY1EzQ1VFalg2TkRXdW5abjBCVi84aU5pTWNBMTB6QUVuSmJjN3lT?=
 =?utf-8?B?RGgyRU5obzRQSUc0aUp5WXNrUG9IdmpTekNpREFFZGZHbk12eDdjdzVUaWU3?=
 =?utf-8?B?VHFRVzhaMDlKT1FyU2Z3THp5c3NrbFlPeTJHVHFvZG9MbzlVVjhWT3pCZkQx?=
 =?utf-8?B?Uy9UNkthSkJSc3NCbnBQbUFoaXU3NDl4M2pqMUtGV3RuYWp1Q1podzk3VE4v?=
 =?utf-8?B?UFEwVzRSWDNuOXJpM3hhZXVBVG16aU9jZlVWWjNDNm1Hc0l1aUx2bjFjc2Vv?=
 =?utf-8?B?SndlNDNHNWRSQW9NeWxFUDlXRmpqcWhETXY3azZHelVOM0JxZzB2TG4zSDEw?=
 =?utf-8?B?L2NyK2dhLzBWMnV4R3hKdURqaFNib2dRbnVZc2lkRVNpUnJUZnhjT29zQkpo?=
 =?utf-8?B?RmVka1hya0EzTWJlNnk0QlNlNDUxWHgxVk15Y2svY2syNUhoVjJnYzFpMXY5?=
 =?utf-8?B?enJBVGZyUk00OHdRV0NBUHBaZ0V0WWZBSFgzYmhuSlBFaGNlVXBaaU5EanVu?=
 =?utf-8?B?ZEFwOExpaUxhTGh4clErNmxnaGE4YStpbG1nNFNCK25KZHYvUXoybjFQWWlI?=
 =?utf-8?B?Tlp5RjF3LzgvZDU0b3crNmVQRzdPZnZoVWVLakNJY3Rza2FXYitEMFhIaTZV?=
 =?utf-8?B?a3FvVjg2cHFaRzNucHJGRGZMMEJHL1YyWGF4ZXBkS3pMUEpwVzRITTdLQkpQ?=
 =?utf-8?B?VEc3RnFIUFlBRG5Jd0Yyd1Q1VGVKNjM1VUl0Q3VDM1hjR1JRbUJzOWgrcmo2?=
 =?utf-8?B?Z0FIYUZMMFZpMC9oZE5yWEloOGNVSm10YXhhSk91eVBsSDhzeDNqcEp2YzZR?=
 =?utf-8?B?dEJTYzc5TFo2ZVpuMXBYWW1uZ2syYzBzdG9NdHNZdEx0Y2lhSEYvaDhwNWlC?=
 =?utf-8?B?cmFWVTgwV1kyMzZJcytnT2VHZXFtWkxEK0dtZkhaM0poMm9yOWlCN3h3UXJM?=
 =?utf-8?Q?2K25p0oxM5cgzBQumf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431c2463-b7aa-4e31-5ed6-08def20d011a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 09:44:39.9857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tWq0uKjtLFQBb6F4daK5j4I063JswVWaYQ0irnkYXccv0CQEzWJGWFpb5Y6irboC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755
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

QU1EIEdlbmVyYWwNCg0KR29vZCBwb2ludCwgdGhhbmtzLg0KSeKAmWxsIGtlZXAgdGhpcyBwYXRj
aCBmb2N1c2VkIG9uIENTLXNpZGUgaW5wdXQgdmFsaWRhdGlvbiBhbmQgZm9sbG93IHVwIHdpdGgg
YSBzZXBhcmF0ZSBzZXJpZXMgdG8gZW5mb3JjZSBJQiBsZW5ndGggbWFza2luZyBpbiB0aGUgcmlu
ZyBwYWNrZXQgZW1pdCBwYXRocyBhcyBkZWZlbnNlIGluIGRlcHRoLg0KDQoNClRoYW5rcywNCkNh
bmRpY2UNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hlciA8
YWxleGRldWNoZXJAZ21haWwuY29tPg0KU2VudDogTW9uZGF5LCBBdWd1c3QgMywgMjAyNiAxMDow
MCBQTQ0KVG86IExpLCBDYW5kaWNlIDxDYW5kaWNlLkxpQGFtZC5jb20+DQpDYzogYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGRybS9hbWRncHU6IHJlamVjdCBv
dmVyc2l6ZWQgSUJzIHdpdGggcGVyLXJpbmcgcGFja2V0IGxpbWl0cw0KDQpPbiBNb24sIEF1ZyAz
LCAyMDI2IGF0IDY6MzPigK9BTSBDYW5kaWNlIExpIDxjYW5kaWNlLmxpQGFtZC5jb20+IHdyb3Rl
Og0KPg0KPiBPbiBHRlggcmluZ3MsIGFtZGdwdV9jc19wMl9pYigpIHBhc3NlZCB1c2VyLXN1cHBs
aWVkIGliX2J5dGVzIHRocm91Z2gNCj4gdG8gaWItPmxlbmd0aF9kdyB3aXRob3V0IGEgbGltaXQs
IHdoaWxlIHJpbmdfZW1pdF9pYigpIGVuY29kZXMgbGVuZ3RoDQo+IGludG8gcGFja2V0IGZpZWxk
cy4gT3ZlcnNpemVkIHZhbHVlcyBjYW4gY29ycnVwdCBhZGphY2VudCBjb250cm9sIGJpdHMNCj4g
YW5kIGRlc3RhYmlsaXplIGNvbW1hbmQgc3VibWlzc2lvbi4NCj4NCj4gQWRkIGEgcGVyLXJpbmcg
SUIgcGFja2V0IHNpemUgbGltaXQgaGVscGVyIGFuZCByZWplY3QgY29tbWFuZA0KPiBzdWJtaXNz
aW9ucyBleGNlZWRpbmcgdGhlIGNvcnJlc3BvbmRpbmcgZHdvcmQgbGltaXQgYmVmb3JlIElCDQo+
IGFsbG9jYXRpb24uIFVzZSB0aGUgZG9jdW1lbnRlZCAyMC1iaXQgbGltaXQgZm9yIEdGWC9jb21w
dXRlL1NETUEvVlBFLA0KPiBhbmQgYXBwbHkgdGhlIE1NIGZhbGxiYWNrIGxpbWl0IGZvciBvdGhl
ciByaW5nIHR5cGVzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDYW5kaWNlIExpIDxjYW5kaWNlLmxp
QGFtZC5jb20+DQoNCldvdWxkIGJlIGdvb2QgdG8gYWxzbyBlbmZvcmNlIHRoZSBpYiBsZW5ndGgg
bWFzayBpbiB0aGUgcGFja2V0DQpmdW5jdGlvbnMgYXMgd2VsbCBhcyBhIGZvbGxvdyB1cCBwYXRj
aCBzZXJpZXMuICBUaGlzIHBhdGNoIGlzOg0KUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9jcy5jIHwgMjcgKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jDQo+IGluZGV4IGFmYzFjNjMxZDU1YWE2Li42
MTdmNTNmMTM1ZjM1MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2NzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nz
LmMNCj4gQEAgLTQyLDYgKzQyLDI2IEBADQo+ICAjaW5jbHVkZSAiYW1kZ3B1X3Jhcy5oIg0KPiAg
I2luY2x1ZGUgImFtZGdwdV9obW0uaCINCj4NCj4gKy8qDQo+ICsgKiBNYXhpbXVtIElCIGxlbmd0
aCAoZHdvcmRzKSBmb3IgcmluZ3Mgd2hvc2UgZW1pdF9pYiBwYWNrZXQgZm9ybWF0DQo+ICsgKiBk
b2N1bWVudHMgYSAyMC1iaXQgc2l6ZSBmaWVsZC4NCj4gKyAqLw0KPiArI2RlZmluZSBBTURHUFVf
R0ZYX1NETUFfSUJfUEFDS0VUX1NJWkVfTUFYX0RXICAweEZGRkZGDQo+ICsjZGVmaW5lIEFNREdQ
VV9NTV9JQl9QQUNLRVRfU0laRV9NQVhfRFcgICAgICAgIDB4N0ZGRkYwDQo+ICsNCj4gK3N0YXRp
YyB1MzIgYW1kZ3B1X2NzX2liX3BhY2tldF9zaXplX21heF9kdyhlbnVtIGFtZGdwdV9yaW5nX3R5
cGUgdHlwZSkNCj4gK3sNCj4gKyAgICAgICBzd2l0Y2ggKHR5cGUpIHsNCj4gKyAgICAgICBjYXNl
IEFNREdQVV9SSU5HX1RZUEVfR0ZYOg0KPiArICAgICAgIGNhc2UgQU1ER1BVX1JJTkdfVFlQRV9D
T01QVVRFOg0KPiArICAgICAgIGNhc2UgQU1ER1BVX1JJTkdfVFlQRV9TRE1BOg0KPiArICAgICAg
IGNhc2UgQU1ER1BVX1JJTkdfVFlQRV9WUEU6DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gQU1E
R1BVX0dGWF9TRE1BX0lCX1BBQ0tFVF9TSVpFX01BWF9EVzsNCj4gKyAgICAgICBkZWZhdWx0Og0K
PiArICAgICAgICAgICAgICAgcmV0dXJuIEFNREdQVV9NTV9JQl9QQUNLRVRfU0laRV9NQVhfRFc7
DQo+ICsgICAgICAgfQ0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IGFtZGdwdV9jc19wYXJzZXJf
aW5pdChzdHJ1Y3QgYW1kZ3B1X2NzX3BhcnNlciAqcCwNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkcm1fZmlsZSAqZmlscCwNCj4gQEAgLTM0MCw3ICsz
NjAsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV9jc19wMl9pYihzdHJ1Y3QgYW1kZ3B1X2NzX3BhcnNl
ciAqcCwNCj4NCj4gICAgICAgICBqb2IgPSBwLT5qb2JzW3JdOw0KPiAgICAgICAgIHJpbmcgPSBh
bWRncHVfam9iX3Jpbmcoam9iKTsNCj4gLSAgICAgICBpYiA9ICZqb2ItPmlic1tqb2ItPm51bV9p
YnMrK107DQo+DQo+ICAgICAgICAgLyogc3VibWlzc2lvbnMgdG8ga2VybmVsIHF1ZXVlcyBhcmUg
ZGlzYWJsZWQgKi8NCj4gICAgICAgICBpZiAocmluZy0+bm9fdXNlcl9zdWJtaXNzaW9uKQ0KPiBA
QCAtMzY5LDYgKzM4OCwxMiBAQCBzdGF0aWMgaW50IGFtZGdwdV9jc19wMl9pYihzdHJ1Y3QgYW1k
Z3B1X2NzX3BhcnNlciAqcCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7DQo+ICAgICAgICAgfQ0KPg0KPiArICAgICAgIGlmIChjaHVua19pYi0+aWJfYnl0ZXMgLyA0
ID4NCj4gKyAgICAgICAgICAgYW1kZ3B1X2NzX2liX3BhY2tldF9zaXplX21heF9kdyhyaW5nLT5m
dW5jcy0+dHlwZSkpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiAr
ICAgICAgIGliID0gJmpvYi0+aWJzW2pvYi0+bnVtX2licysrXTsNCj4gKw0KPiAgICAgICAgIGlm
IChjaHVua19pYi0+ZmxhZ3MgJiBBTURHUFVfSUJfRkxBR19QUkVBTUJMRSkNCj4gICAgICAgICAg
ICAgICAgIGpvYi0+cHJlYW1ibGVfc3RhdHVzIHw9IEFNREdQVV9QUkVBTUJMRV9JQl9QUkVTRU5U
Ow0KPg0KPiAtLQ0KPiAyLjUwLjENCj4NCg==
