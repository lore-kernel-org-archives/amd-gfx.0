Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95BBC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 02:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A048C10E39D;
	Tue, 18 Oct 2022 02:13:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E2FE10E39D
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 02:13:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjrHwfJrQTbUu58ZGNlsAC5tyxQnkSocD+WnwRkmWysbXPOWCAyW96glSo6PnCKZuqEhuog8w2TmW4ncPjHdbXzzt9nIuLOzu0bo1kD4VN4n7eyq2rKrOAQdJ+wx9Fbe/cujc3OBXS8EZKqdOneYjum4e0TmKFK5SyjGtuXIL9BPpRTrb/xkcNiYqdnuKx0Bk2CQfTpq1eqYu4fs8e2R5fHE5qYgLqW2Jc29twssbbaAJ2gqTT9rMAEQKRNHgLItmmCxo+rjFoJYDFtj/S/ec4QI3KgLJ89UrjT7b8UOMIcjhw7MuBiebNcFjTOjezOPDONhyp5JrC1KZXi1AKYMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIe/G0iD++bzU3W6Mx17ZUX+VJikD7nYE6Rx8Tol/w0=;
 b=dNsYLY99wm/vFrK+PrVv/UjwXLw1EQizLG6vCNOjbjQg62AUHOu3aPPZdQLZ7ROf0uV9d4LAFLdMWPFGk12dUMrPSQCU5JLXjRQAyKHGVovVhSsAUIODiip5FwlYk0xQoTTs29ntYOZmwu1qU4nKxU1kjizK+MkGxGIuJABxUkuRWCZOGOvyjx7IJrN2hUXJghcdhDn5mDUtR2ZchQSGEoKICJbr2xnwvaV0edjg2JqBePikjaUBXKiE2MKDM65xjxSigvrTLQx97zrveEercucELc41vNDI9neO7AYbkYIGGUH4P3E+aRTfZdul7HbfznDurey86/t+D68Sjwyirw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIe/G0iD++bzU3W6Mx17ZUX+VJikD7nYE6Rx8Tol/w0=;
 b=s01wzSXg7uHsLGmVQVWcO/kYeRwbnKCFe4mH+AqJ8vTwZqrknda4AE6VR9fG96sKUY9k05A2zaTVMZgjc5n4ZhlXyndCzRiDc4rtwO1XoSamoi/3MkFLOq2LlCtrBxhFQt1vKCPl0Ci8deIev4tddQ4Wn6vqr/TVB0VT3wtjjhs=
Received: from DM6PR12MB3035.namprd12.prod.outlook.com (2603:10b6:5:3a::24) by
 PH7PR12MB6881.namprd12.prod.outlook.com (2603:10b6:510:1b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 02:13:39 +0000
Received: from DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::180b:27cd:cf18:beea]) by DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::180b:27cd:cf18:beea%7]) with mapi id 15.20.5723.030; Tue, 18 Oct 2022
 02:13:39 +0000
From: "Wang, YuBiao" <YuBiao.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdgpu: dequeue mes scheduler during fini
Thread-Topic: [PATCH v3] drm/amdgpu: dequeue mes scheduler during fini
Thread-Index: AQHY3334+c5gsCtSNUCiToo08qyqCK4NeG4AgAX22KA=
Date: Tue, 18 Oct 2022 02:13:39 +0000
Message-ID: <DM6PR12MB30351DA7C68A127C06AFBB8AE5289@DM6PR12MB3035.namprd12.prod.outlook.com>
References: <20221014033419.3461246-1-YuBiao.Wang@amd.com>
 <6271b033-04d8-31cc-2518-7613b65c64b9@amd.com>
In-Reply-To: <6271b033-04d8-31cc-2518-7613b65c64b9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3035:EE_|PH7PR12MB6881:EE_
x-ms-office365-filtering-correlation-id: dc865b27-2c46-4385-6474-08dab0ae5f40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y+g4p66mXV5+s0xwASj+YOSxHLRuYT4zbHHNRAvPtgqXhhFoQ6qyKJtsRbx1Nd8YQ2KnI57EbGI8XLqSPWrRY9HL9VrnNyMmtfLcnPBjQEOBBMcYP5f7iCZG6OhoDiVm9EotluPxzH9croapiJm/oXP6v4IIPug+2H58FLIePRmLCXfw2BHjc3ZTjrGdgsS9+/RkXFc7M2d/HJng/OeMMz5cU4U955gCZjSnY7qvGPPgUHXbuBDsa/4vGjLYx+2iNDlFPz7h9N0uNDTita6+wKtASEmrQPj0EDBaQ5xFsraKlErJ5ktHkYuUPnXJcDlFp3iQYimLwLP5p947YZp37c8zP/pHvA7Y20NC0vemQczCg3zKp2f0w/SIOcBh6+CJ3k9aeDsGvSNeN6bxa0YR9SldTcwmGySW5BArLrR8B+wKkUM38laxkZTH39NZvL89ry2lW1D8UeH85w1k86OJBZTSyoqZPkd/DG0ujViE2jVDjzNRmjf44TnDpW5xN1bOAXMEBwVxoT1uFaetEz5ZVkGomJIAKQ4HMiBdsSHF+mWDs2fHTOIjZPdsLCDWpKxV9iH0Bi/V522oRMedzK+31R5lP6IdgLlLtTfp4s0iwjOxK8hy7MKAylkp1PUm52wIx5t1BQ5FJaNBSDQHdD2I5+lOtYUKF1G/RKEuPb8FStl7yqs0fZNCii9/FdrNGQOXmcbHHgPU74uBieNsBlhZcJadBl2XqMr+5iCtq0Z3ZcDTI2mc49yHzLPWaRfYufEA8LoliQRBYe/UzzmTycWsMw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3035.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199015)(186003)(83380400001)(2906002)(55016003)(33656002)(26005)(8676002)(66446008)(6506007)(7696005)(64756008)(41300700001)(53546011)(4326008)(86362001)(38070700005)(54906003)(316002)(66574015)(66946007)(122000001)(38100700002)(9686003)(66556008)(8936002)(76116006)(5660300002)(66476007)(52536014)(110136005)(478600001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUZ0M21qYjF1RVlyVVhhdGpmNW5sYWhJbFRNbWlqcTkyaEdTenpITDczZWRi?=
 =?utf-8?B?TnZ5RVZkWGJUUFZianYxU1RhNDFhU254dFl4VCt2M0hicmE4eU9FSWZTZXdk?=
 =?utf-8?B?MmZwT01JRVdkU0ZsaFc2bThvSTJ2K282U09yL3I4eUQzVUQ2Vyt1eExZSVY1?=
 =?utf-8?B?aXJwMlVuQWxJYlB0bVJRT1JaY2VUem1iNzA4aEdadXlqVFpZbisxanoxUGxC?=
 =?utf-8?B?TzRQczRPUmFvbWVJK1FlREcxK01UQTJETmdtOTgwdmlSOXFYcVVmRklOVjd3?=
 =?utf-8?B?WkN5aWtWdExrL3NWTHZaRkhUTzQ4Mktkc01FdVVuMUhJdlZJL3MvWjVoYkQ2?=
 =?utf-8?B?d0QrY1pXS1llNnJmV3AraktiNTQ5emxQdTE1cE8vcnhXcWRKblZGcGVMTmMr?=
 =?utf-8?B?THhSb3d0RkZ4TmhGUUovMGdPUHhQZUZIbmhJVW5OZnJKL2g4eEFkTW9Ma3Bl?=
 =?utf-8?B?OW9LOHdURmo3eHJXejI2VnJNb1dyelpYZitKVmJjVzBlWkVwcWI5eERVOGVn?=
 =?utf-8?B?WHlGb2JsdTA5eWFVVHNYNzk0dUMyT25xZW9RcGw0eWM0WHlLb1l3SmxzN1Fm?=
 =?utf-8?B?MEtSV011K1A0WTg1VTN4ckNTU1lUekNyWEZrelduMTErU0xLWUZKTzRZOXR2?=
 =?utf-8?B?NFF5WTAvRFRIaEtOZjRKd2RwczNhdFRzZmxMQXZ1SjJUdWVzbDlZS24vQ0ZL?=
 =?utf-8?B?dmN5YU90djZlNGZJUDVnOWFrS1Bkc0VpSlViTXo3NG0xempuR1h4R0VKbHpx?=
 =?utf-8?B?NFBXWFpJMGpFWFZnbEVHVHAwazFxY3ozUmVYZ1lJaERTS013d1BDL3c2alE3?=
 =?utf-8?B?ZUxSZENyNTgraFlPY0dRWk5LakJjTXczT1VXTGNOeE92L1BLRktuSnQwLzFR?=
 =?utf-8?B?cklSZGE5NDhoUEJjVjh0QXFwZE5GalczTFBqd1hJaGR4ZWF1SHRuOTg0MHFk?=
 =?utf-8?B?WHZnVnVzNmh3RGEyTHJvMkE5Ri9aZGxmMkxFWk5lSFROV0NieTVNL1J6eE53?=
 =?utf-8?B?UENVVnFZaXI3YmRTeGlUV1c4dkNVNEwvUG1HK3h0Q2pBSUoxUW1USHNtRStl?=
 =?utf-8?B?NDQ4d28yTnZQeWtENElTLzFPazQ2YzhyV2Q5Q0tVTjNlRmY4K3gvbmNuYlBX?=
 =?utf-8?B?SENJQVN0Q1M5Unc3R05NWFRzMytjUmwrWjdsbVRWYVZER0tYQVpWM09YeWJu?=
 =?utf-8?B?VDhGSTlUWHQ0emZSdmRsNUl2YzVucFRPaUJUWmF3NjBqNXJEVnYrRE1XbVBS?=
 =?utf-8?B?djFsWmtCeWNDNGo2Z3dkMlN6d2tQbWxCQnRKSWxnQitzdDJmQ1BxNXo0bGJp?=
 =?utf-8?B?STZKb3F6QitIdkVPbUhGWmhWVWJuUFhaU1RCWmJaNnBpbDlxeTVCSGNLWWlP?=
 =?utf-8?B?UmFPODNOUnRieXFMNndySHRKbXRoWEdzWVlvVm4zdmlrcGhVbDJ3TFM5aU90?=
 =?utf-8?B?MlVNKzV4TmNGV2VuMGhRSWZXWlRYajlGR1ZHRTJLTE1YeVdPYU1jb2Jwbm95?=
 =?utf-8?B?dmZnc3prM0Y5b0pFQUoybXpJMDY0VWdqaFlJcU5nb1JUcE4yZ2h2aytZZXdh?=
 =?utf-8?B?b1VSblZJUTcyREZ2VDJ4OHdJRVFvdXlsKzZZVUVadHp4TzNOVVVVQ0pOcjZ5?=
 =?utf-8?B?WU5WVzUwS3k5dFFlYVVDUERNQThSNFZKaVAvM0RFckdKbHdPa0VnRzdlQlp4?=
 =?utf-8?B?Q1ljRDJSNnZtWksrcWVsditGT2ZOVkQrOHVKVlBiZmx5eGJvSkppVTlVVVc5?=
 =?utf-8?B?MnNLZ0xaTjJzZ3E2dktMQjYvYTM5U1p0Vkk0dUpKYWFUbGhVZWFzRjFabE5u?=
 =?utf-8?B?VitNWHRET3k2SjRSZnp5c0NlNS9Qdjl0SUdhUUJYT2FXTkhLNzR4cXFta2Vs?=
 =?utf-8?B?R1VXKzJqQ3J0YW5NTWoyRjZCNGJ6aHdFYkYyMC9pcWRrQVllQm9KSjNBNkpl?=
 =?utf-8?B?dDFJNVNLWHBMZGRKOGJjQktwdkVkVmlRN3NvTFU1bCtlWGt3dHlZRlI1RVlK?=
 =?utf-8?B?TWpWdGdzRGpzNkxHekZ5UlI4a01Hdjh6QVZKd3dJVk5DRzlHT0poWlkvUUU2?=
 =?utf-8?B?MEcwaFlIQmZ1c3NuSk5SVUtvK0pDaEZyYnpxaEFUS2t4cnV0bXcxN1d1SHd6?=
 =?utf-8?Q?TP31gbpv93cpAomGYjaX/5v32?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3035.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc865b27-2c46-4385-6474-08dab0ae5f40
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 02:13:39.4575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utu1cMTq10LkOUosJGDvho4ylohqutMhFeZ+Kid8pxnCZTqPPccLBtr1+wVowo6zqFeZau7aC8e8Rg3BnwaWkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6881
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Liu,
 Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQWxleCwNCg0KQ291bGQgeW91IGhlbHAgcmV2aWV3IHRoaXMgcGF0Y2g/IFRoYW5rcy4NCg0K
QmVzdCBSZWdhcmRzLA0KWXViaWFvIFdhbmcNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+IA0KU2Vu
dDogRnJpZGF5LCBPY3RvYmVyIDE0LCAyMDIyIDM6MDggUE0NClRvOiBXYW5nLCBZdUJpYW8gPFl1
Qmlhby5XYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IEdy
b2R6b3Zza3ksIEFuZHJleSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT47IFF1YW4sIEV2YW4g
PEV2YW4uUXVhbkBhbWQuY29tPjsgQ2hlbiwgSG9yYWNlIDxIb3JhY2UuQ2hlbkBhbWQuY29tPjsg
VHVpa292LCBMdWJlbiA8THViZW4uVHVpa292QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIg
PEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBYaWFvLCBKYWNrIDxKYWNrLlhpYW9AYW1kLmNv
bT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBMaXUsIE1vbmsgPE1v
bmsuTGl1QGFtZC5jb20+OyBYdSwgRmVpZmVpIDxGZWlmZWkuWHVAYW1kLmNvbT47IFdhbmcsIFlh
bmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCB2
M10gZHJtL2FtZGdwdTogZGVxdWV1ZSBtZXMgc2NoZWR1bGVyIGR1cmluZyBmaW5pDQoNCkFtIDE0
LjEwLjIyIHVtIDA1OjM0IHNjaHJpZWIgWXVCaWFvIFdhbmc6DQo+IFVwZGF0ZTogUmVtb3ZlIHJl
ZHVuZGFudCBjb21tZW50cyBhcyBDaHJpc3RpYW4gc3VnZ2VzdHMuDQo+DQo+IFtXaHldDQo+IElm
IG1lcyBpcyBub3QgZGVxdWV1ZWQgZHVyaW5nIGZpbmksIG1lcyB3aWxsIGJlIGluIGFuIHVuY2xl
YW5lZCBzdGF0ZSANCj4gZHVyaW5nIHJlbG9hZCwgdGhlbiBtZXMgY291bGRuJ3QgcmVjZWl2ZSBz
b21lIGNvbW1hbmRzIHdoaWNoIGxlYWRzIHRvIA0KPiByZWxvYWQgZmFpbHVyZS4NCj4NCj4gW0hv
d10NCj4gUGVyZm9ybSBNRVMgZGVxdWV1ZSB2aWEgTU1JTyBhZnRlciBhbGwgdGhlIHVubWFwIGpv
YnMgYXJlIGRvbmUgYnkgbWVzIA0KPiBhbmQgYmVmb3JlIGtpcSBmaW5pLg0KPg0KPiBTaWduZWQt
b2ZmLWJ5OiBZdUJpYW8gV2FuZyA8WXVCaWFvLldhbmdAYW1kLmNvbT4NCg0KQWNrZWQtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCg0KPiAtLS0NCj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbWVzLmggfCAgMyArKw0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jICB8ICAzICsrDQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMV8wLmMgIHwgNDEgKysrKysrKysrKysrKysrKysrKysr
KystLQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9t
ZXMuaCANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbWVzLmgNCj4gaW5k
ZXggYWQ5ODBmNGI2NmUxLi5lYThlZmE1MjUwM2IgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tZXMuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfbWVzLmgNCj4gQEAgLTEzMCw2ICsxMzAsOSBAQCBzdHJ1Y3QgYW1kZ3B1
X21lcyB7DQo+ICAgCWludCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKCpraXFfaHdfaW5p
dCkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOw0KPiAgIAlpbnQgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICgqa2lxX2h3X2ZpbmkpKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsN
Cj4gICANCj4gKwkvKiBkZXF1ZXVlIHNjaGVkIHBpcGUgdmlhIGtpcSAqLw0KPiArCXZvaWQgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKCpraXFfZGVxdWV1ZV9zY2hlZCkoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpOw0KPiArDQo+ICAgCS8qIGlwIHNwZWNpZmljIGZ1bmN0aW9ucyAqLw0K
PiAgIAljb25zdCBzdHJ1Y3QgYW1kZ3B1X21lc19mdW5jcyAgICpmdW5jczsNCj4gICB9Ow0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMgDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMNCj4gaW5kZXggMjU3YjJlNGRl
NjAwLi43Yzc1NzU4ZjU4ZTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92MTFfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
MTFfMC5jDQo+IEBAIC00NDA2LDYgKzQ0MDYsOSBAQCBzdGF0aWMgaW50IGdmeF92MTFfMF9od19m
aW5pKHZvaWQgKmhhbmRsZSkNCj4gICAJCWlmIChhbWRncHVfZ2Z4X2Rpc2FibGVfa2NxKGFkZXYp
KQ0KPiAgIAkJCURSTV9FUlJPUigiS0NRIGRpc2FibGUgZmFpbGVkXG4iKTsNCj4gICANCj4gKwkJ
aWYgKGFkZXYtPm1lcy5yaW5nLnNjaGVkLnJlYWR5ICYmIGFkZXYtPm1lcy5raXFfZGVxdWV1ZV9z
Y2hlZCkNCj4gKwkJCWFkZXYtPm1lcy5raXFfZGVxdWV1ZV9zY2hlZChhZGV2KTsNCj4gKw0KPiAg
IAkJYW1kZ3B1X21lc19raXFfaHdfZmluaShhZGV2KTsNCj4gICAJfQ0KPiAgIA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMV8wLmMgDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMV8wLmMNCj4gaW5kZXggYjQ4Njg0ZGIyODMyLi5l
ZWYyOTY0NmIwNzQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21l
c192MTFfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTFfMC5j
DQo+IEBAIC00NCw2ICs0NCw3IEBAIE1PRFVMRV9GSVJNV0FSRSgiYW1kZ3B1L2djXzExXzBfM19t
ZXMxLmJpbiIpOw0KPiAgIHN0YXRpYyBpbnQgbWVzX3YxMV8wX2h3X2Zpbmkodm9pZCAqaGFuZGxl
KTsNCj4gICBzdGF0aWMgaW50IG1lc192MTFfMF9raXFfaHdfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldik7DQo+ICAgc3RhdGljIGludCBtZXNfdjExXzBfa2lxX2h3X2Zpbmkoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpOw0KPiArc3RhdGljIHZvaWQgbWVzX3YxMV8wX2tpcV9kZXF1
ZXVlX3NjaGVkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsNCj4gICANCj4gICAjZGVmaW5l
IE1FU19FT1BfU0laRSAgIDIwNDgNCj4gICANCj4gQEAgLTEwNzgsNiArMTA3OSw3IEBAIHN0YXRp
YyBpbnQgbWVzX3YxMV8wX3N3X2luaXQodm9pZCAqaGFuZGxlKQ0KPiAgIAlhZGV2LT5tZXMuZnVu
Y3MgPSAmbWVzX3YxMV8wX2Z1bmNzOw0KPiAgIAlhZGV2LT5tZXMua2lxX2h3X2luaXQgPSAmbWVz
X3YxMV8wX2tpcV9od19pbml0Ow0KPiAgIAlhZGV2LT5tZXMua2lxX2h3X2ZpbmkgPSAmbWVzX3Yx
MV8wX2tpcV9od19maW5pOw0KPiArCWFkZXYtPm1lcy5raXFfZGVxdWV1ZV9zY2hlZCA9ICZtZXNf
djExXzBfa2lxX2RlcXVldWVfc2NoZWQ7DQo+ICAgDQo+ICAgCXIgPSBhbWRncHVfbWVzX2luaXQo
YWRldik7DQo+ICAgCWlmIChyKQ0KPiBAQCAtMTE1MSw2ICsxMTUzLDQyIEBAIHN0YXRpYyBpbnQg
bWVzX3YxMV8wX3N3X2Zpbmkodm9pZCAqaGFuZGxlKQ0KPiAgIAlyZXR1cm4gMDsNCj4gICB9DQo+
ICAgDQo+ICtzdGF0aWMgdm9pZCBtZXNfdjExXzBfa2lxX2RlcXVldWVfc2NoZWQoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpIHsNCj4gKwl1aW50MzJfdCBkYXRhOw0KPiArCWludCBpOw0KPiAr
DQo+ICsJbXV0ZXhfbG9jaygmYWRldi0+c3JibV9tdXRleCk7DQo+ICsJc29jMjFfZ3JibV9zZWxl
Y3QoYWRldiwgMywgQU1ER1BVX01FU19TQ0hFRF9QSVBFLCAwLCAwKTsNCj4gKw0KPiArCS8qIGRp
c2FibGUgdGhlIHF1ZXVlIGlmIGl0J3MgYWN0aXZlICovDQo+ICsJaWYgKFJSRUczMl9TT0MxNShH
QywgMCwgcmVnQ1BfSFFEX0FDVElWRSkgJiAxKSB7DQo+ICsJCVdSRUczMl9TT0MxNShHQywgMCwg
cmVnQ1BfSFFEX0RFUVVFVUVfUkVRVUVTVCwgMSk7DQo+ICsJCWZvciAoaSA9IDA7IGkgPCBhZGV2
LT51c2VjX3RpbWVvdXQ7IGkrKykgew0KPiArCQkJaWYgKCEoUlJFRzMyX1NPQzE1KEdDLCAwLCBy
ZWdDUF9IUURfQUNUSVZFKSAmIDEpKQ0KPiArCQkJCWJyZWFrOw0KPiArCQkJdWRlbGF5KDEpOw0K
PiArCQl9DQo+ICsJfQ0KPiArCWRhdGEgPSBSUkVHMzJfU09DMTUoR0MsIDAsIHJlZ0NQX0hRRF9Q
UV9ET09SQkVMTF9DT05UUk9MKTsNCj4gKwlkYXRhID0gUkVHX1NFVF9GSUVMRChkYXRhLCBDUF9I
UURfUFFfRE9PUkJFTExfQ09OVFJPTCwNCj4gKwkJCQlET09SQkVMTF9FTiwgMCk7DQo+ICsJZGF0
YSA9IFJFR19TRVRfRklFTEQoZGF0YSwgQ1BfSFFEX1BRX0RPT1JCRUxMX0NPTlRST0wsDQo+ICsJ
CQkJRE9PUkJFTExfSElULCAxKTsNCj4gKwlXUkVHMzJfU09DMTUoR0MsIDAsIHJlZ0NQX0hRRF9Q
UV9ET09SQkVMTF9DT05UUk9MLCBkYXRhKTsNCj4gKw0KPiArCVdSRUczMl9TT0MxNShHQywgMCwg
cmVnQ1BfSFFEX1BRX0RPT1JCRUxMX0NPTlRST0wsIDApOw0KPiArDQo+ICsJV1JFRzMyX1NPQzE1
KEdDLCAwLCByZWdDUF9IUURfUFFfV1BUUl9MTywgMCk7DQo+ICsJV1JFRzMyX1NPQzE1KEdDLCAw
LCByZWdDUF9IUURfUFFfV1BUUl9ISSwgMCk7DQo+ICsJV1JFRzMyX1NPQzE1KEdDLCAwLCByZWdD
UF9IUURfUFFfUlBUUiwgMCk7DQo+ICsNCj4gKwlzb2MyMV9ncmJtX3NlbGVjdChhZGV2LCAwLCAw
LCAwLCAwKTsNCj4gKwltdXRleF91bmxvY2soJmFkZXYtPnNyYm1fbXV0ZXgpOw0KPiArDQo+ICsJ
YWRldi0+bWVzLnJpbmcuc2NoZWQucmVhZHkgPSBmYWxzZTsNCj4gK30NCj4gKw0KPiAgIHN0YXRp
YyB2b2lkIG1lc192MTFfMF9raXFfc2V0dGluZyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpDQo+
ICAgew0KPiAgIAl1aW50MzJfdCB0bXA7DQo+IEBAIC0xMjU3LDkgKzEyOTUsNiBAQCBzdGF0aWMg
aW50IG1lc192MTFfMF9od19pbml0KHZvaWQgKmhhbmRsZSkNCj4gICANCj4gICBzdGF0aWMgaW50
IG1lc192MTFfMF9od19maW5pKHZvaWQgKmhhbmRsZSkNCj4gICB7DQo+IC0Jc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7DQo+IC0NCj4g
LQlhZGV2LT5tZXMucmluZy5zY2hlZC5yZWFkeSA9IGZhbHNlOw0KPiAgIAlyZXR1cm4gMDsNCj4g
ICB9DQo+ICAgDQoNCg==
