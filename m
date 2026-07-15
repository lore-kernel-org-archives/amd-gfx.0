Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5784C44507
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 02:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E3B110EE83;
	Wed, 15 Jul 2026 02:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jY6LMEW2";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6604A10EE83
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 02:02:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdTYaTgIadwIZxTAXs0mMbkRoetg3s1b/SstHzIMmN1PkVa0zIJguRVPK+CVLOpDmSro+VsFiBqiQIdQv1zFbQQ4BPluj1SkaxOVx8BWOuYVKrwjnMQF2/m3CUkqJW8eu6V3BasqkBLc6n6MIod+Wo/GuULz/GNx5GE9O+Q2NelygrdcarKMHgWzItzowIAdfAn4xSW0CpWbHqQ9w7Fhnk1mZiJBEtlYK/BBzAd0gX4SbTwM0xaKVeRa3yuGt9mRIgTsdir60xzHshTeWG+1DCf/nrThZngJAlz9O4odpp02Mv5y4JRMagFVYYPxh+K8vhg4SXQLYl//14W6jqr4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCwzXJcFI1aLN/9f+gS+VHBLM7TMWs/2lTEoD3+Qb+s=;
 b=paptb3F0XHvIgCfb1hFAxzhYDzAEf4mVDdgkHxyBtb9uXSdiz7YOV3NXNWp1Z8tqy2ZR/85IW1K1+jTx0NzfbBMNEeTMU4G8UF7fiDVap7iEzHQVUUazh2eSj/mgAIf5Nl0WZxxeOVEDSBPi4RZSEdbcWTuJnD3kdA16ypmeGQWzlpV6HmY/X0eBcdoTnqwBp3W3g37d2+zF+87u6oJaBbZ5mtWPaybclWCP295GDWXythYvLMcs1hC1wbtolNflMhPwRPGxcavmRCL5jNSnbj1BIrZX5QoNhV88An2OL7mvwGTYW9Ypb7gk9zkPI1hXKyuy6F8IGmQUI4t0WOA8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCwzXJcFI1aLN/9f+gS+VHBLM7TMWs/2lTEoD3+Qb+s=;
 b=jY6LMEW2MT1U2CUVF8oewtM03EUg65pCVptP64DYkXQiwXPQ6t2Y7jdNeD1KheX7uGLwRGBfAvl5j4AY8sC68mVUMX/XHPI2xPJ2goGLwUyt7BsXAZRKxJtQbdYgRcBMzB+/5erxaAs7JAxLX9Qdq7Utu5iG9qRgOj0Ui6C/L6s=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA3PR12MB7781.namprd12.prod.outlook.com (2603:10b6:806:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Wed, 15 Jul
 2026 02:02:14 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 02:02:14 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "SHANMUGAM,
 SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>
Subject: RE: [PATCH] drm/amdgpu/userq: properly account for resets
Thread-Topic: [PATCH] drm/amdgpu/userq: properly account for resets
Thread-Index: AQHdEwem2ibSw3o1iUqkIFz+zu3sh7ZsTuHggAA6JICAAICugIAAxy2Q
Date: Wed, 15 Jul 2026 02:02:14 +0000
Message-ID: <DS7PR12MB6005B10D8CB237EE1D0CC9C3FBF82@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260713203850.650426-1-alexander.deucher@amd.com>
 <DS7PR12MB600589F9C41083DA5506725BFBF92@DS7PR12MB6005.namprd12.prod.outlook.com>
 <DS7PR12MB6005FB0DF535C58EAA3DC93BFBF92@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_NtsmdSgmzJrFcv4dCaBdDwAoWEZ2RrRQgGdXqaXGOd_w@mail.gmail.com>
In-Reply-To: <CADnq5_NtsmdSgmzJrFcv4dCaBdDwAoWEZ2RrRQgGdXqaXGOd_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-15T01:44:25.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA3PR12MB7781:EE_
x-ms-office365-filtering-correlation-id: b3850952-463e-450e-c27c-08dee215172e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: pw2r2FGdzJZz3fZ301usWeQpN8YGjq5p1JRRW/+ld+jWgX3bUFIglmWUvb8B9lZy5XQVvRaCtOp3mhAoeeZk0xYa7dvcLf8k9bO+FQa14IU30sEB9I+oDGWsE5aryeca3tp7+WpXFcwxv9TqNFF6zNHsV/ckYv6pv2PAHTm59Mc1yXDKGIoUe6N32EzjzEOveevaC/77YyjuilZqk8uHe7nqWDEt6QXOMpZR6ZaPVD575p+2b2XhVcRzBu/T6Rywj4Hd+/WvnJaqDu84o4fVh6EotTIzZYCyFHAJOj5Qe5wSkqwyq322qLZNHuq5IaG8vRHVPIBsymyp2ISq8IWPCj0Wo7A9Xiwid2XPZHftfPyBC2m/nVUkfqjf14M/1iY0+DQIyZ4VDBx5DW4Skl9GGBm/ijDeY0BBwChERglxcTag4jxatYHoWENWGHvqupTlZUgT7vSeUr9BUrp1JX/G0w2gXTyiGCTH+whGlgVBDcQtRP+QhTAXOpHv4UQKkO4vRFE1tcWHzGu/AR6093G85vtSwPeAq/mCy1wL1qo4O23QC4E4MHHqXSR7fc/x6pEvfIvxwe7iak5Ri1MSo3+fLSjCb7YT/aOmrkBhBicSMdoAQ1PisGy1c3cWnqhECLxip2kl4/EoiyaCHjUE0fo/x9iu5hzK+AfXYlzeijcg/Yu8Kv4+q1xvoxX7wqdwIv9CKeEtlGKAP6AC9GBZjnRzaebrqMGjR6rKuLczaazdwfw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(38070700021)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clZwaTZ5THE1WmtYamhxbUprU2Q0RjNCdXN5ZmNyQWJtdVZMNXhFcXE0empT?=
 =?utf-8?B?Znl6RzlCL2psWTBVeFJ3cDlpL2prZjVwSkQzQU42bXRzaGFFdm05L0xFU2li?=
 =?utf-8?B?bkZUSkd0YmlRcWUvQUwzU2E1Rk4yV3AvMUpyTkF5ZVFvU1RPNUY2MFhFZGZp?=
 =?utf-8?B?Mk9DZzVYUnNUZGhrVUd1VmRLaVF4cGtOMVlPSnNXTGVCcFBoWnQ3TG9PQm9q?=
 =?utf-8?B?KzZWMkh2M1JEMUFNTGZyd1l2T21PSXNyTGxzUWJLTzdZZzQzT001WFZQRkxK?=
 =?utf-8?B?dVU2NGZqdlh6OTl4M1U4U2d3eG9IdGl0ekRuSG5QS2tQWit6SG5ZcUFNYkxl?=
 =?utf-8?B?eUFoN3krTzd3QzhHVzlxY3hTV29NVTFVWGlMRFh6VVR4Q0RyWmFLaWM2UVJW?=
 =?utf-8?B?NXFZZzVhMzdieHJDQitUdDdOSUJDN3RBNmw2RlNWcitGOGpkcE1SRXM4TXN3?=
 =?utf-8?B?Q3dwLzhQeC9xUC9IakVOTnRPdTJ3UHAvc3hsODBZQWZyR2RkMkhMVG4xaUhm?=
 =?utf-8?B?dDhSckluQWhOMXUvcnhpUWVldTY3ZDJoQTVyb0dwRmtMNmRjUXdQbGlnNmlR?=
 =?utf-8?B?RUgxWklscEptSDhseHNHNXRnMk9kNk5oZ0hDWTRnY2hQOHUzZ3N6b2Y2dko2?=
 =?utf-8?B?c1RqODdMZS84MC9nZElDR0V4UkxDQzVGMUhLVE56OW5xMnZ4eWEzYUltRTlh?=
 =?utf-8?B?SW00NlRKQUF4U0ZHZGcrSVdnc3BwTUtOc3AxSFJmWmNUSXhPOG5TVUgyQTRY?=
 =?utf-8?B?N3laRkYyWWkxVEFYU0NjOEw4VE1jUlAwTmY0YVNkZWFJczhrUWtWaHM2UFVn?=
 =?utf-8?B?ZHpiWmQ4SndFcFFXaHFnNFRQY3F1VDBMNFVwbTUyNHZwSWp5Z0tiZFJ5STBG?=
 =?utf-8?B?WU5acm1TL3c5VjZReW51QTRTSlBmWVNPYVBubXlUbjJ5VmZIbE8zbjgxK0Jw?=
 =?utf-8?B?UTNlOXVHQ2NqUUxwREptY1lQcjJmTnJaVHBDcm5zUEFKZDgycGQ0c1Q3bHBT?=
 =?utf-8?B?NHRnVkpRUHUvUDlnYkdJQmczdVE3MFJ0VHErQTFJbzhpcXNuV1ZZYXdXVXFE?=
 =?utf-8?B?ZmprMndtQWdVUE1IMkJpMGNlaDVkYkFZOFZkNWZLVjhSYndXWUExTnRpNnlv?=
 =?utf-8?B?VEJHVmZneTRFUGk4V09DSmlQYXpuc0pQQy9FU3V4aWJXT0tlUnhXbGNPbitQ?=
 =?utf-8?B?YXhJYUJUelN1bnpaOWVlZWZiN3B6OVJ4UlVtaUZ6b1d4ZUM2WS84UHNhQ2FZ?=
 =?utf-8?B?TEZKdTFYUStaNi92SXlXRFRVWWZvZTIwakFxdzd6a010NFcrcTQ0NWtLVmEw?=
 =?utf-8?B?cmhVZXR5OTZCRk91Um11aGRPemNYUnNJekpPMVhmci92Wm05K0w2VkNXSzdl?=
 =?utf-8?B?bXlsRTZnN0MvVmFBa20rMWg1T0NLQ1NMNVUvVDdGRldHS2l0VmdmTVlFYVlJ?=
 =?utf-8?B?N0J4bm5xa1VGaE1CeVk3Qlg5OG80WlF4cGQ0ZnZQU3FYSjRpTWdoL3p1Q1h4?=
 =?utf-8?B?U1dYK1RGWUFnRnJ0RlJPcWF3SFVsZGprVnYwM0sxZFlSdVBXc25FK2ZxcnZ6?=
 =?utf-8?B?Y3Z2bmdHclVqTEZZQ1Fwd3JMQ1FCa09YTC9JditUcGN3eVdUUTFZcjN2djZR?=
 =?utf-8?B?T2JtakxTZlRTSnVPZkFOai90YUxTeE5TS1JWQTl2bUgzRHAzMnljY25yT0No?=
 =?utf-8?B?QjNJaEY4M2hsQmV2N0pQWFh6SG1KM1kwYzY3SVB4aEx0YmNxM3FuVWFWcVBG?=
 =?utf-8?B?MEdZQ0pvRDdxV3ppRTlkdFBmNWhQOHZOV3g5NTduK09YZExmSmFoR0pzN3VB?=
 =?utf-8?B?YlEvcmNGakZyOTc1UDFRSWp0T3BTbGRuSk5zU2tKUElPbG9GeUp6TDNITzVr?=
 =?utf-8?B?ZzY0SElmYXZibVpOcm5aNGcwNXBqTnBiVm9ROHJEQk96ZVlyYk5YVnltb1I0?=
 =?utf-8?B?UTlWa20xL1dVMEdUcHlqNFJpQmNyQzdyTVIxQ20wU1FQNlNRSFJoZGEvU0My?=
 =?utf-8?B?MDRrWm9yUkF5Y0YrdVVkNXR4aTFXN2JWVW8vZHQ3dXd6TmFlOG53MTNBdXl2?=
 =?utf-8?B?QXBZTk1XYlNuL3QwVmdpdmgxWVNoNDVjeklJVGV6SHRIQUF0MEFXdmZCc1JU?=
 =?utf-8?B?UVo2amVEWXJNaW9oa200NkFMeERpaE5XaUFqeTVvcHJmY3RVM0R0dTlnSHJ4?=
 =?utf-8?B?S09RS01sTzc3K0VodlBXNXhhUUs0aTgyNE1CSmhGNDdNQXVlTXZ6Tk9ubHFD?=
 =?utf-8?B?ZjhrdzBkZkx2VS9BYlc4YnlKVW1FeHZ6a0UyTnR5V0w4MjlMeEVUUFArckty?=
 =?utf-8?Q?fefrZSzo8vK7Yez4M9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3850952-463e-450e-c27c-08dee215172e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 02:02:14.3936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T0kSsWmrwjjhTx/nRdnPXxz8f3lkeE1bTihlq6sX0ZhDU70USoBljh97U2b6L+Vt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7781
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

QU1EIEdlbmVyYWwNCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+
DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMTQsIDIwMjYgOTo1MiBQTQ0KPiBUbzogTGlhbmcsIFBy
aWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
OyBTSEFOTVVHQU0sIFNSSU5JVkFTQU4NCj4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+
OyBLaGF0cmksIFN1bmlsIDxTdW5pbC5LaGF0cmlAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gZHJtL2FtZGdwdS91c2VycTogcHJvcGVybHkgYWNjb3VudCBmb3IgcmVzZXRzDQo+DQo+
IE9uIFR1ZSwgSnVsIDE0LCAyMDI2IGF0IDM6NDTigK9BTSBMaWFuZywgUHJpa2UgPFByaWtlLkxp
YW5nQGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQU1EIEdlbmVyYWwNCj4gPg0KPiA+IFJlZ2Fy
ZHMsDQo+ID4gICAgICAgUHJpa2UNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiA+IEZyb206IExpYW5nLCBQcmlrZQ0KPiA+ID4gU2VudDogVHVlc2RheSwgSnVseSAx
NCwgMjAyNiAxMDo0OSBBTQ0KPiA+ID4gVG86ICdBbGV4IERldWNoZXInIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPjsNCj4gPiA+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4g
PiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgU0hB
Tk1VR0FNLA0KPiA+ID4gU1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47
IEtoYXRyaSwgU3VuaWwNCj4gPiA+IDxTdW5pbC5LaGF0cmlAYW1kLmNvbT4NCj4gPiA+IFN1Ympl
Y3Q6IFJFOiBbUEFUQ0hdIGRybS9hbWRncHUvdXNlcnE6IHByb3Blcmx5IGFjY291bnQgZm9yIHJl
c2V0cw0KPiA+ID4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gUmVnYXJkcywNCj4gPiA+ICAgICAgIFBy
aWtlDQo+ID4gPg0KPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiBG
cm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gPiA+IFNl
bnQ6IFR1ZXNkYXksIEp1bHkgMTQsIDIwMjYgNDozOSBBTQ0KPiA+ID4gPiBUbzogYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPiA+ID4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFNIQU5NVUdBTSwNCj4gPiA+ID4gU1JJTklWQVNBTiA8
U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IExpYW5nLCBQcmlrZQ0KPiA+ID4gPiA8UHJp
a2UuTGlhbmdAYW1kLmNvbT47IEtoYXRyaSwgU3VuaWwgPFN1bmlsLktoYXRyaUBhbWQuY29tPg0K
PiA+ID4gPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHUvdXNlcnE6IHByb3Blcmx5IGFjY291
bnQgZm9yIHJlc2V0cw0KPiA+ID4gPg0KPiA+ID4gPiBXZSBuZWVkIHRvIGluY3JlbWVudCB0aGUg
cmVzZXQgY291bnRlciwgZm9yY2UgZmVuY2UgY29tcGxldGlvbiwNCj4gPiA+ID4gYW5kIHNldCB0
aGUgd2VkZ2VkIGV2ZW50IHdoZW4gYSB1c2VyIHF1ZXVlIGlzIHJlc2V0Lg0KPiA+ID4gPg0KPiA+
ID4gPiBtZXNfdXNlcnFfcmVzZXRfcXVldWUoKSBoYW5kbGVzIHRoaXMgZm9yIGNvbGxhdGVyYWwg
ZGFtYWdlLCBidXQNCj4gPiA+ID4gdGhlIGNhbGxlciBuZWVkcyB0byBoYW5kbGUgdGhpcyBkaXJl
Y3RseSBmb3IgdGhlIG9yaWdpbmFsIGd1aWx0eSBxdWV1ZS4NCj4gPiA+ID4NCj4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+
ID4gPiBDYzogU3Jpbml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5j
b20+DQo+ID4gPiA+IENjOiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPiA+
ID4gQ2M6IFN1bmlsIEtoYXRyaSA8c3VuaWwua2hhdHJpQGFtZC5jb20+DQo+ID4gPiA+IC0tLQ0K
PiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMgfCA3ICsr
KysrKy0NCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiA+ID4gaW5kZXggNmFhNzVkYTI3ZjkxMi4uNWUxMjYyNjM2
ZTFlOSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3VzZXJxLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3VzZXJxLmMNCj4gPiA+ID4gQEAgLTE0Niw4ICsxNDYsMTMgQEAgc3RhdGljIHZvaWQNCj4g
PiA+ID4gYW1kZ3B1X3VzZXJxX2hhbmdfZGV0ZWN0X3dvcmsoc3RydWN0DQo+ID4gPiA+IHdvcmtf
c3RydWN0ICp3b3JrKQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHF1ZXVlLCBOVUxMLCBOVUxMKTsNCj4gPiA+ID4gICAgICAgICAg
ICAgZWxzZQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgIHIgPSB1c2VycV9mdW5jcy0+cmVz
ZXQocXVldWUpOw0KPiA+ID4gPiAtICAgICAgICAgICBpZiAocikNCj4gPiA+ID4gKyAgICAgICAg
ICAgaWYgKHIpIHsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICBncHVfcmVzZXQgPSB0cnVl
Ow0KPiA+ID4gPiArICAgICAgICAgICB9IGVsc2Ugew0KPiA+ID4gPiArICAgICAgICAgICAgICAg
ICAgIGF0b21pY19pbmMoJmFkZXYtPmdwdV9yZXNldF9jb3VudGVyKTsNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICBhbWRncHVfdXNlcnFfZmVuY2VfZHJpdmVyX2ZvcmNlX2NvbXBsZXRpb24o
cXVldWUpOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgIGRybV9kZXZfd2VkZ2VkX2V2ZW50
KGFkZXZfdG9fZHJtKGFkZXYpLA0KPiA+ID4gPiBEUk1fV0VER0VfUkVDT1ZFUllfTk9ORSwgTlVM
TCk7DQo+ID4gPg0KPiA+ID4gSWYgd2UgZG8gdGhlIHVzZXJxIHJlc2V0IHBvc3Qgc2ltaWxhciBw
cm9jZXNzIGhlcmUganVzdCBsaWtlIGFzDQo+ID4gPiBtZXNfdXNlcnFfcmVzZXRfcXVldWUoKSwg
c28gZG8gd2UgbmVlZCB0byBjbGVhciB0aGUgZHVwbGljYXRlIHRoZQ0KPiA+ID4gY29kZSBpbiB0
aGUgbWVzX3VzZXJxX3Jlc2V0X3F1ZXVlKCk/IE90aGVyd2lzZSwgdGhlIGdwdSByZXNldCBjb3Vu
dGVyDQo+IHNob3VsZCBiZSBpbmNvcnJlY3QuDQo+ID4gPiBFeGNlcHQgdGhhdCwgd2UgbWlnaHQg
aW5wdXQgdGhlIHdlZGdlIHRhc2sgaW5mbyB0byByZXBvcnQgdGhlIGd1aWx0eSBwcm9jZXNzIGlu
Zm8uDQo+ID4NCj4gPiBBcyB0byB0aGUgZmlyc3QgcXVlc3Rpb24sIEkgcmVjaGVjayB0aGUgY29k
ZSBhbmQgZm91bmQgb3V0IHRoZSBndWlsdHkgdXNlciBxdWV1ZSBpbg0KPiB0aGUgYW1kZ3B1X2dm
eF9yZXNldF9tZXNfY29tcHV0ZSgpIHdhcyByZXNldCBzZXBhcmF0ZWx5IGJlZm9yZQ0KPiBtZXNf
dXNlcnFfcmVzZXRfcXVldWUoKSwgd2l0aCB0aGlzIGN1cnJlbnQgcmVzZXQgc2VxdWVuY2UgdGhl
biB0aGlzIGNoYW5nZSBpdA0KPiBtYWtlIHNlbnNlIHRvIHVwZGF0ZSByZXNldCBjb3VudGVyIGFu
ZCAgZm9yY2UgY29tcGxldGUgZmVuY2UuDQo+ID4NCj4gPiBCdXQgd2h5IG5lZWQgdG8gcmVzZXQg
dGhlIG9yaWdpbmFsIGd1aWx0eSBxdWV1ZSBzZXBhcmF0ZWx5LCBzaG91bGQgdGhpcyBndWlsdHkg
cXVldWUNCj4gd2FzIGZvdW5kIGJ5IHRoZSBhbWRncHVfbWVzX2RldGVjdF9hbmRfcmVzZXRfaHVu
Z19xdWV1ZXMoKSBpbiB0aGUgTUVTDQo+IGZpcm13YXJlPyBJZiBzbywgd2UgbWF5IG5lZWQgdG8g
cmVzZXQgdGhlIGd1aWx0eSBxdWV1ZSB0aHJvdWdoDQo+IG1lc191c2VycV9yZXNldF9xdWV1ZSgp
IHJhdGhlciB0aGFuIHJlc2V0IHNlcGFyYXRlbHksIHRoZW4gd2UgZG9uJ3QgbmVlZCB0byBhZGQN
Cj4gdGhpcyBjaGFuZ2UgYW55bW9yZS4NCj4NCj4gV2Ugc3RpbGwgbmVlZCBpdCBmb3IgZ2Z4IGFu
ZCBzZG1hIHF1ZXVlcy4gIFRob3NlIGRvbid0IGdldCByZXNldCB2aWENCj4gYW1kZ3B1X2dmeF9y
ZXNldF9tZXNfY29tcHV0ZSgpLA0KDQpZZXMsIEkgd2lsbCBjaGVjayB3aGV0aGVyIHRoZSBvcmln
aW5hbCBndWlsdHkgY29tcHV0ZSBxdWV1ZSBjYW4gYmUgaWRlbnRpZmllZCBieSBhbWRncHVfbWVz
X2RldGVjdF9hbmRfcmVzZXRfaHVuZ19xdWV1ZXMoKS4gSWYgc28sIHRoZSBzZXBhcmF0ZSBndWls
dHkgcXVldWUgcmVzZXQgdmlhIG1lc191c2VycV9yZXNldF9xdWV1ZSgpIGJlY29tZXMgcmVkdW5k
YW50IGFuZCBjYW4gYmUgcmVtb3ZlZC4gVGhlIGNvbXB1dGUgdXNlcnEgcmVzZXQgcmVmY291bnQg
YW5kIGNvbXBsZXRlZCBmZW5jZSBoYW5kbGluZyB3b3VsZCB0aGVuIGJlIHJlbG9jYXRlZCBpbnRv
IGFtZGdwdV91c2VycV9oYW5nX2RldGVjdF93b3JrKCksIGNvbnNvbGlkYXRpbmcgdGhlIHJlc2V0
IHBhdGggaW50byBhIHNpbmdsZSBmbG93Lg0KDQoNClRoYW5rcywNClByaWtlDQoNCj4gQWxleA0K
Pg0KPiA+DQo+ID4gPg0KPiA+ID4gPiArICAgICAgICAgICB9DQo+ID4gPiA+ICAgICB9IGVsc2Ug
ew0KPiA+ID4gPiAgICAgICAgICAgICBncHVfcmVzZXQgPSB0cnVlOw0KPiA+ID4gPiAgICAgfQ0K
PiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjU1LjANCj4gPg0K
