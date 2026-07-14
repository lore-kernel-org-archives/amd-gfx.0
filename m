Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2300BC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 13:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F0510ED3E;
	Tue, 14 Jul 2026 13:32:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gXfQeHSB";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012030.outbound.protection.outlook.com
 [40.107.200.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24E2D10ED3E
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 13:32:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3pCINHyvhTZuy/hxeVa7hkDDHGoJThIB6GK0eTh1x+9hiXPNHM1U9IWg0Dc3HQjr+J3qJERGqSKptHAeME2LQ1JkP0Eqtfvd59Vj3/QLVua+u7zQCtJUwH1OZq+C8FLPqR+DXgJNt6NG1Mlv7wXC91dzTVZYl1dK4vcJ2FbyvyfHvmOJKIk987TrRvvSxMQBj5kCrbxLzVXiJn0ipboMS6YK0NE6/jkrpJ624LXom2z0PCWBKt8kP7P9cot+TQcjhko+UVmJIX+4l/++ZWEuTxevlY5GhHgHr5uuWXOhRPDSP7rqa4JAkXA/t+jUIz40K/o16QIajIdQk5ulJ9wMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDazqrTZuiVUMQ9JUKGxF5JB7fTtUg9mEXwbvLIHusQ=;
 b=yO4EOpLCUvOsniZ6c6fSE0jxE/UAH7ynLki7l13VHdvqRHE33fB0KEpp62MUjqQiTaN/EsoMZ/C8KTnRDcm4toeXKYG0t2mSZ6O2/bVIocpldknYrsR2Hpt6YQ6tHGt2ILOjB0igY6HeJVSKNWR6FQsMTNQfQluQV6yYHuBSeYVKpkHKaX1S0wbeQH03CXbD4O+3HfRuaK++kM4hcc90wrMpr+82GmUBGPYFcsOEVqVa+CBha9fhjkSgkkaQsvj1Pqp1Ma6pEZhHmcqHfK/4yLHeU573WBaoUNGF52fNpedBbnX8xRFabGdrOyAyNWt2HWwV4hv6z9ol9RwjoWU98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDazqrTZuiVUMQ9JUKGxF5JB7fTtUg9mEXwbvLIHusQ=;
 b=gXfQeHSBk0X6RdVVyZwMcncAXoiVhZilHtMHr7swSSZiE1Kd/7VqWkNYVQME2gy34qMo3NoNwV9YVHC3GamzTQ9UO1govel8Wudj1k5FskePNZPGkMqBuvzkm2WSiqSGJdLeREMQraNNUmGIwDA+73X4FHbvm/6Zl4PNG5PL7cE=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 13:32:43 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 13:32:43 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Liang, Prike" <Prike.Liang@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>
Subject: RE: [PATCH] drm/amdgpu/userq: properly account for resets
Thread-Topic: [PATCH] drm/amdgpu/userq: properly account for resets
Thread-Index: AQHdEwemLj48Zo5+FEGWvILeBy4uu7ZsZOoAgABfvQCAAAuG2oAAAbiAgAAybUA=
Date: Tue, 14 Jul 2026 13:32:43 +0000
Message-ID: <IA0PR12MB8208EB469D4C2403243D321C90F92@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260713203850.650426-1-alexander.deucher@amd.com>
 <IA0PR12MB820888C41AF05BAA5C2CA57090F92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <3656074a-1a01-49f6-8f7c-129ab379f129@amd.com>
 <IA0PR12MB8208F00938342B8FD8377E0090F92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <9d575350-c3a2-4e9c-b842-b2a68678914e@amd.com>
In-Reply-To: <9d575350-c3a2-4e9c-b842-b2a68678914e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-14T13:32:17.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|SN7PR12MB8817:EE_
x-ms-office365-filtering-correlation-id: a7f4e120-0e07-431d-5c77-08dee1ac624e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|38070700021|6133799003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: Z6gP+MoCrquN+yvULFtxu4AVitH16aU9U3Bdwt1opys4vvUZo6T8Io6VQQ8O7xeiY9tlKM1GvLAHlLDZqcwI7VVwC8VpC58tR9f+slk7QYwoAeFuuRQVzlb20yHDy0xjbjBNYyyJHxvRX+FXaUp4YZT6NUHZKupWVg1EybmgokVtdW82Js9mrkPQlBZ1HuCYg5lXRRONpEs2ZjhfGPIZ6UASK7aIrBp/dWS0mTaiQHWX8pmngB+k1QbFxpeoOpg++A1K8WWbw59pMyJCBIyELVyerf0O870BOn9Qq0F6S6bZpanynfVm5DXNg+v7jj4agyM1RF5I9JDaAWotRtJvxbdQKAUl4Zn5EbViABE4uYxP958xWBBPzQhAQTCWIgJ+0CPpELO2CcqtQc5421KhJJS8B8fWDfADqCfOVC4QvCTeTxd34o1rUacwIJ7fM5S/EjEcpV46IOyKjXqtVaXwmIiGA7Pyv9lLDRoPID/soLKGp37WXpsyVfMsqq+gvzkFQwLsQYeVK30H3pM28i+QTuPB3Imn+SmPEtiVbufFFvQEt95yFkXMBhEvfYluGi2InNkjMrBq4dbpPt0VtojZHEF9VArDqlXarBhD3WXz0Cp0eWC2oEPXdyVsjI9OR7tBnRyoQqnZ/BNyyHw77mlElgsrxNcNXFM6IVjJvSsCZj0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(6133799003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkFDb2U2K0JEd3RrbndES1lTYkNNQ3NhRmxFT3J6RjdXc2RjNERrQ2tibG9Y?=
 =?utf-8?B?UDRnSEY4YXJSUWNtS3B3c3dQN3ErS0dBdWdXcSs1SjU3TEdJZ2tNaUVSb1VQ?=
 =?utf-8?B?enVxSWVsUUxTRldrL0VLaWZIWmZhbnpxeTVwZ05pS2J5cUdHVXl4VE5vKyt4?=
 =?utf-8?B?bUlCVndMcVc1MmRpcU1tN3hKTy91d0dnVXVUd2hrbEpYUW9lSWltL3JjZHNm?=
 =?utf-8?B?TDdqVHlncnVuNEhpNlZ1eWdmQ1Z4VGRPMXdtdTd5ekJsK3NjbytNODRialNT?=
 =?utf-8?B?MkE0QVlPMHBvMEFuM0FoUFhGYlhuQnk2K1MyRmVTa0RtR3N4ajlmRkRvTHRz?=
 =?utf-8?B?ODNBTmJXakhjeHdreW9UL3hzQ1dGQ0VrRStDd2J2eGVzOERyZTNQeHRFK2xH?=
 =?utf-8?B?VVRIWElRUU54NmIyNE5SM1Y3L0dJNzVqSXV2dG5ROW5rSTVMZjdaYXk3bHZH?=
 =?utf-8?B?c3RhNnlUREozS1RhMVYvM1ZHbFhPUVJEYnpyaG90bXJ0Nko0R2R5am5rdXBt?=
 =?utf-8?B?TjdQQVQ1UGZubldvdWNHWm5OdDljWktFM3gxR1N3Ny9oc25QU2xYYnJNTWVa?=
 =?utf-8?B?Sll2QjlsYW9yZElvWlkxWEtNRXNaZFVlMXlsOWZOY0lSK29yRHBkdWhpMnJJ?=
 =?utf-8?B?VmdYdDQxOThMMUVWMWtFam9RY29iTkV5OHU4dWFDdkhLZjdFQ2N4ZWwwOUgr?=
 =?utf-8?B?VHRTYzlWS1Z2VUFTWmZGbkRXeEdGN2FUM0Nqd1BIWjNCek5ndVBLYU5DQmdW?=
 =?utf-8?B?SVh5Ly9BbUpLbzFIVFdCREQvYjZhTDZUMHhhUnp4OWFvV205OE5SSjBvQnZW?=
 =?utf-8?B?TFo5QmkxOG9NZHhPMWhWZHV2eFFnU1VnZExqQlZEWEdvc2ZqOHlXTDVBTVhZ?=
 =?utf-8?B?V2tNTldaZzF6UmlaOXRRd0N1NDhONHpaQllkamxGZzViQnM5WEtUSzcxaXNa?=
 =?utf-8?B?dC9YNSt5MkpERThCTEM2bmJ6a3JENldOWWI2MCs1cVorZ1U2N0NxcmZrMStp?=
 =?utf-8?B?bTIzOUVFZmVQOVJva21KdEtHS2V2YlgwOEZLdERGRThmNm5NSi9FVFJodkNF?=
 =?utf-8?B?NnMzeGVrNlFFN25SbGhwOElidmc3K3ZXTGdKUlgrcG5LRzV5Si82dGgwOHpj?=
 =?utf-8?B?NDVEaW1OdlFydmZLekppUENGU2l3clRXOEtqaG90RllIdWJsdVBQZUZLS1NI?=
 =?utf-8?B?N3NZdzJQVTZXTEdxSmJ3RXRMUlplTlZKY2FKbis1NkJMbUN0c1Q3Z0FFUjBj?=
 =?utf-8?B?cjZqbEpyaFM4M21PcXlINUovTEFoTmkySlhDeEtWc1FDdWF6UVhrd1paakdP?=
 =?utf-8?B?L01wS1ZwcEJkQjl0OWhOWktkMDV2d01lODdGMWh1Q3U5Zi9peVkvcDR5NEc5?=
 =?utf-8?B?QUdmR1M3TUhMdDRpK0o2d0VRRXI4L04wSWJWMlAzOWxVbnE1Q042K0FEY2pS?=
 =?utf-8?B?b1pCdU1DZFRLYzZyQzdkMFVMUFUzeFVPUnhSdFhUbVU0TUtUM2Y3OThsdUVG?=
 =?utf-8?B?b1pqQUtBN0Yxb3ZPTDI5OFhIZ0U0M3hHUTNxU2dyeEVxeUllNm5ocmJMejRN?=
 =?utf-8?B?UGhCQVhkdG9EVFE1bHZ4T2pibWVVM1o2d2l5bTUrREtrWS9xWlc2bDVlZFAz?=
 =?utf-8?B?UWN2SEhYbXZOL2grWDE0TWNhNm44N0IyQ3JVQWpYSVRXWUVNQTZ5M3ZhdDNL?=
 =?utf-8?B?SnlmU0c5MVRMdnlSYkI4T1JoTHpFN3NEQWcxR2IrMXBRc2VjT2owTUEzM2Fi?=
 =?utf-8?B?WW5OWnJQazdqWDRkVGVackNjWnF1bkZYWmkzaGN5K2kyM0lrT2dhWG1qN3lY?=
 =?utf-8?B?aWNJZHdKSGQ0L0I5d2RiVHpuKy8rRWNsdHdnTER0YzNtMk0wRkozVFd6dGo2?=
 =?utf-8?B?Vml2QUpLWkhENVdONmwrWllpTXFlMG1USHNyMzlhaytRLy9GYk9oZjdzRlVI?=
 =?utf-8?B?ZEU2Mm95THZWYzFNRjJIdXlMdWlQdWdoR01GS1RmSFBDeU1uOTJHNUJGY0dU?=
 =?utf-8?B?cFloc3AvL3ByNHEwcW45WWtPMEJLRVVZZW5uZVphNHpuckdHRWlEaldyOW9F?=
 =?utf-8?B?T2xwaHltSGUvUGRvSHB1THJyckVzUGtzeHFIdGFXdHF6ZENIelhzWTM1c3Ex?=
 =?utf-8?B?cjlhRGxaY3NkMHJoaWNKMFowNC9ieWhiamQyRHVrblh3a0YxUC9oYlgyczEy?=
 =?utf-8?B?bXZPL3Q2Wk5oMVU2U1ZYclpGMHZaWUF2M2VsMmwrcjRQTHB1emsxZ0tJMng4?=
 =?utf-8?B?WlpvcFJLd3lUUVEzbWRUaVVCM3I5VVNQeWdtT25tYk4rSXNueXNCekRleisw?=
 =?utf-8?Q?lIIl6gvPt4fXJOv7+u?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f4e120-0e07-431d-5c77-08dee1ac624e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 13:32:43.3007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YrrF+0ha3BTFixJX+f1jqAPYIeFC8Ue1SibnFsjnPgelPcA/M853YQHe77gJJNHFflzwCG7QPuBBu8NrGNhJew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8817
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXph
ciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDE0LCAy
MDI2IDQ6MDIgUE0NCj4gVG86IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFO
TVVHQU1AYW1kLmNvbT47DQo+IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogTGlhbmcs
IFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgS2hhdHJpLCBTdW5pbCA8U3VuaWwuS2hhdHJp
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHUvdXNlcnE6IHByb3Bl
cmx5IGFjY291bnQgZm9yIHJlc2V0cw0KPg0KPg0KPg0KPiBPbiAxNC1KdWwtMjYgMzo1NyBQTSwg
U0hBTk1VR0FNLCBTUklOSVZBU0FOIHdyb3RlOg0KPiA+IEFNRCBHZW5lcmFsDQo+ID4NCj4gPg0K
PiA+DQo+ID4NCj4gPiBHZXQgT3V0bG9vayBmb3IgQW5kcm9pZCA8aHR0cHM6Ly9ha2EubXMvQUFi
OXlzZz4NCj4gPg0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAtLQ0KPiA+ICpGcm9tOiogTGF6YXIs
IExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gPiAqU2VudDoqIFR1ZXNkYXksIEp1bHkgMTQs
IDIwMjYgMzoxNDozNCBQTQ0KPiA+ICpUbzoqIFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklW
QVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47DQo+IERldWNoZXIsDQo+ID4gQWxleGFuZGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4g
PiA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQo+ID4gKkNjOiogTGlhbmcsIFByaWtl
IDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgS2hhdHJpLCBTdW5pbA0KPiA+IDxTdW5pbC5LaGF0cmlA
YW1kLmNvbT4NCj4gPiAqU3ViamVjdDoqIFJlOiBbUEFUQ0hdIGRybS9hbWRncHUvdXNlcnE6IHBy
b3Blcmx5IGFjY291bnQgZm9yIHJlc2V0cw0KPiA+DQo+ID4NCj4gPg0KPiA+IE9uIDE0LUp1bC0y
NiAxMDoxNiBBTSwgU0hBTk1VR0FNLCBTUklOSVZBU0FOIHdyb3RlOg0KPiA+ICA+IEFNRCBHZW5l
cmFsDQo+ID4gID4NCj4gPiAgPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiAgPj4g
RnJvbTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPiAgPj4gU2VudDog
VHVlc2RheSwNCj4gPiBKdWx5IDE0LCAyMDI2IDI6MDkgQU0gID4+IFRvOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZyAgPj4gQ2M6DQo+ID4gRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPjsgU0hBTk1VR0FNLCAgPj4NCj4gPiBTUklOSVZBU0FOIDxTUklO
SVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPjsgTGlhbmcsIFByaWtlICA+Pg0KPiA+IDxQcmlrZS5M
aWFuZ0BhbWQuY29tPjsgS2hhdHJpLCBTdW5pbCA8U3VuaWwuS2hhdHJpQGFtZC5jb20+ICA+Pg0K
PiA+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdS91c2VycTogcHJvcGVybHkgYWNjb3VudCBm
b3IgcmVzZXRzICA+PiAgPj4NCj4gPiBXZSBuZWVkIHRvIGluY3JlbWVudCB0aGUgcmVzZXQgY291
bnRlciwgZm9yY2UgZmVuY2UgY29tcGxldGlvbiwgYW5kDQo+ID4gc2V0IHRoZSAgPj4gd2VkZ2Vk
IGV2ZW50IHdoZW4gYSB1c2VyIHF1ZXVlIGlzIHJlc2V0Lg0KPiA+ICA+Pg0KPiA+ICA+PiBtZXNf
dXNlcnFfcmVzZXRfcXVldWUoKSBoYW5kbGVzIHRoaXMgZm9yIGNvbGxhdGVyYWwgZGFtYWdlLCBi
dXQNCj4gPiB0aGUgY2FsbGVyIG5lZWRzICA+PiB0byBoYW5kbGUgdGhpcyBkaXJlY3RseSBmb3Ig
dGhlIG9yaWdpbmFsIGd1aWx0eQ0KPiA+IHF1ZXVlLg0KPiA+ICA+Pg0KPiA+ICA+PiBTaWduZWQt
b2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+ICA+PiBDYzoN
Cj4gPiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1kLmNvbT4g
ID4+IENjOiBQcmlrZQ0KPiA+IExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPiAgPj4gQ2M6IFN1
bmlsIEtoYXRyaQ0KPiA+IDxzdW5pbC5raGF0cmlAYW1kLmNvbT4gID4+IC0tLSAgPj4NCj4gPiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYyB8IDcgKysrKysrLSAgPj4g
ICAxIGZpbGUNCj4gPiBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkgID4+
ICA+PiBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dXNlcnEuYw0KPiA+ICA+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2Vy
cS5jDQo+ID4gID4+IGluZGV4IDZhYTc1ZGEyN2Y5MTIuLjVlMTI2MjYzNmUxZTkgMTAwNjQ0ICA+
PiAtLS0NCj4gPiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+
ID4gID4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+
ID4gID4+IEBAIC0xNDYsOCArMTQ2LDEzIEBAIHN0YXRpYyB2b2lkDQo+ID4gYW1kZ3B1X3VzZXJx
X2hhbmdfZGV0ZWN0X3dvcmsoc3RydWN0DQo+ID4gID4+IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+
ICA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHF1ZXVlLA0KPiA+IE5VTEwsIE5VTEwpOyAgPj4gICAgICAgICAgICAgICAgZWxzZSAgPj4g
ICAgICAgICAgICAgICAgICAgICAgICByID0NCj4gPiB1c2VycV9mdW5jcy0+cmVzZXQocXVldWUp
OyAgPj4gLSAgICAgICAgICAgICBpZiAocikgID4+ICsNCj4gPiBpZiAocikgeyAgPj4gICAgICAg
ICAgICAgICAgICAgICAgICBncHVfcmVzZXQgPSB0cnVlOyAgPj4gKw0KPiA+IH0gZWxzZSB7ICA+
PiArDQo+ID4gYXRvbWljX2luYygmYWRldi0+Z3B1X3Jlc2V0X2NvdW50ZXIpOw0KPiA+ICA+PiAr
DQo+ID4gYW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0aW9uKHF1ZXVlKTsN
Cj4gPiAgPj4gKyAgICAgICAgICAgICAgICAgICAgIGRybV9kZXZfd2VkZ2VkX2V2ZW50KGFkZXZf
dG9fZHJtKGFkZXYpLA0KPiA+ICA+PiBEUk1fV0VER0VfUkVDT1ZFUllfTk9ORSwgTlVMTCk7DQo+
ID4gID4+ICsgICAgICAgICAgICAgfQ0KPiA+ICA+PiAgICAgICAgfSBlbHNlIHsNCj4gPiAgPj4g
ICAgICAgICAgICAgICAgZ3B1X3Jlc2V0ID0gdHJ1ZTsNCj4gPiAgPj4gICAgICAgIH0NCj4gPiAg
Pg0KPiA+ICA+IEFmdGVyIHRoZSBvcmlnaW5hbCBxdWV1ZSB3YXMgcmVzZXQgc3VjY2Vzc2Z1bGx5
LCBpdCBkaWQgbm90IHVwZGF0ZQ0KPiA+IGdwdV9yZXNldF9jb3VudGVyLCBjb21wbGV0ZSBpdHMg
cGVuZGluZyBmZW5jZXMsIG9yIHNlbmQgdGhlIHdlZGdlZCBldmVudC4NCj4gPiAgPiBtZXNfdXNl
cnFfcmVzZXRfcXVldWUoKSBhbHJlYWR5IHVwZGF0ZXMgZ3B1X3Jlc2V0X2NvdW50ZXIsDQo+ID4g
Y29tcGxldGVzIHRoZSBwZW5kaW5nIGZlbmNlcywgYW5kIHNlbmRzIHRoZSB3ZWRnZWQgZXZlbnQg
Zm9yIHRoZSBvdGhlcg0KPiA+IGFmZmVjdGVkIHF1ZXVlcywgID4gYnV0IHNraXBzIHRoZSBvcmln
aW5hbCBxdWV1ZSBiZWNhdXNlIGl0IGhhcw0KPiA+IGFscmVhZHkgYmVlbiByZXNldC4NCj4gPg0K
PiA+IFdoYXQgaXMgdGhlIHJhdGlvbmFsZSBvZiBzZW5kaW5nIG11bHRpcGxlIGRldmljZSB3ZWRn
ZWQgZXZlbnRzIG9uIGENCj4gPiBwZXIgcXVldWUgYmFzaXM/DQo+ID4NCj4gPiBUaGUgcXVlc3Rp
b24gb2Ygd2hldGhlciBkcm1fZGV2X3dlZGdlZF9ldmVudCgpIHNob3VsZCBiZSBlbWl0dGVkIG9u
Y2UNCj4gPiBwZXIgcXVldWUgb3Igb25jZSBwZXIgb3ZlcmFsbCByZWNvdmVyeSBzZWVtcyBsaWtl
IGEgYnJvYWRlciBkZXNpZ24NCj4gPiBkaXNjdXNzaW9uLg0KPiA+DQo+DQo+IEFsb25nIHdpdGgg
dGhhdCwgYWxzbyBuZWVkIHRvIGNvbnNpZGVyIGlmIGRldmljZSByZXNldF9jb3VudGVyIG5lZWRz
IHRvIGJlDQo+IGluY3JlbWVudGVkIG9uIGEgcGVyIHF1ZXVlIGJhc2lzIG9yIGJhc2VkIG9uIHJl
c2V0IGV2ZW50IHJlY292ZXJ5LiBJdCBjb3VsZCBnZXQNCj4gaW5jcmVtZW50ZWQgbXVsdGlwbGUg
dGltZXMgaW5zaWRlIHRoaXMgLSBtZXNfdXNlcnFfcmVzZXRfcXVldWUuDQoNCkxvb2tpbmcgYXQg
dGhlIGN1cnJlbnQgZmxvdywgYm90aCBncHVfcmVzZXRfY291bnRlciBhbmQgZHJtX2Rldl93ZWRn
ZWRfZXZlbnQoKSBhcmUgdXBkYXRlZCBvbmNlIGZvciBlYWNoIHN1Y2Nlc3NmdWxseSByZXNldCBx
dWV1ZS4gSXQgd291bGQgYmUgaGVscGZ1bCB0byBjbGFyaWZ5IHdoZXRoZXIgdGhleSBhcmUgaW50
ZW5kZWQgdG8gYmUgdXBkYXRlZCBwZXIgYWZmZWN0ZWQgcXVldWUgb3Igb25jZSBwZXIgb3ZlcmFs
bCByZWNvdmVyeS4NCg0KVGhhbmtzLA0KU3JpbmkNCg0KPg0KPiBUaGFua3MsDQo+IExpam8NCj4N
Cj4gPiBUaGFua3MsDQo+ID4gU3JpbmkNCj4gPg0KPiA+DQo+ID4NCg0K
