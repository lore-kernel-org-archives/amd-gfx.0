Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EDCCD98E2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 05:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECA5710E93D;
	Wed, 17 Jun 2026 05:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pyNEn5H8";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5124410E93D
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 05:59:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGTpuVGcgzCcM7CuuFtJfeGPqS5h9/F8GJD5hJp77zKIwmEmt1xfPysjvJYLIZouuQzG6DLkvBd6gV+JZb0QOm7vgtSl68RFPAhaSdjciS7SzPiigYWDJLNA4X6698CYmkVRqwjymdi0WJlsD1lUqRyXu6fKpmWdwsGQzq/vHGbnayY8702ckwQ+hEdO7BrcPtxw1GafrWkiR0UPgLIaFUiW5T+7zpeK896XMDXWc0652xHqIdfIMUTT+8ZGqqvMdScFmFOVaaTSnkxrETXJZk7/2cHDJ+OmrNRJnW5lhlVOs3ZqdPr43y1Ci1/mbMI7IBy14iZ7X1gl9PtGEVDqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6VsoIjwrNRlVRNOePP1jJiTIypZju+Df7bk4WxurcU=;
 b=o8GLmTUibG2Z7zgxMtMqVcuVGcl06yF2hn1OBdBRm1TmA8/W/uQAmzWRijQ3yw7qFqC30cE7MlWWy5rAAgT1VgxakufuTQWcoFQFD9zVrX9uY/CQmmG4krTcTKmT9U7qdDHuqME3+EtTtOwmR7in+Ww7RwbVSykJaKBWRX2s5cdflNPd3e7OBi0GNFGUGwMfCvHPAdBJqQ45WBKWv/6on/3MIbI1TlEptTKINPQs+36I1AUbhh/0kbDTPCB6zywvZaWQ6IAbihDFYpHUdEfl8O8xQ6bgY4s1q0kyJDi9RGTGF3Vfx/sWZyk5KDfOatn3ZPR3zQvo2bZZZYVkJdHSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6VsoIjwrNRlVRNOePP1jJiTIypZju+Df7bk4WxurcU=;
 b=pyNEn5H8K7xZr1ozsVG8hIswrcTqe7UbnfY48og4Es4wPznw3bBlpEQrq6rbQvAzMj0sYlGrS9EvlCrhFgRtmtiKz+dWuIZ+8XFDWojOaAg5i48eR8oPG1apgvhJ40L+VLjrTuEnPB2S0IHAxr7+aIcRlx7WnhFaA9SFIVpqnWQ=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by LV8PR12MB9334.namprd12.prod.outlook.com (2603:10b6:408:20b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 05:59:15 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 05:59:15 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amdgpu: Signal GPU_RESET EVENTFD notifications
Thread-Topic: [PATCH 5/5] drm/amdgpu: Signal GPU_RESET EVENTFD notifications
Thread-Index: AQHc+i++bYDNGGozgEuENc49oBFRCbZCOkSAgAANmHA=
Date: Wed, 17 Jun 2026 05:59:14 +0000
Message-ID: <IA0PR12MB8208AD2E2E8B8363030D514990E42@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
 <20260612055226.2879270-6-srinivasan.shanmugam@amd.com>
 <4872460d-f5bc-4031-93e3-63650ec04479@amd.com>
In-Reply-To: <4872460d-f5bc-4031-93e3-63650ec04479@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Christian.Koenig@amd.com,Alexander.Deucher@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-17T05:57:02.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|LV8PR12MB9334:EE_
x-ms-office365-filtering-correlation-id: b3d9d4eb-5704-4c7a-9d10-08decc358fd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|4143699003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: cQSKkjFHAYzKyG0pkMxyg2PELB3Dc43S2grBVDQybVjy2mqyniLbrjNpSWQWydg7iP5L/iVNvgNfOOnP7sxUkdJl2xKrOlGuvrJAe3bHDziFf6SyRRlaG/QjWJILL3uGjykMoghfCXSxYD7QkP7Qp47lSLl9n4j00OPyy6czhu0RIlyciS8VJaikmStAXnbc5PPJW1mVMc9V+5R5Whd/vqOkGlTUKq0Zcguqip9d8LhZOfZO80Yv05E/eMMv5xMaUg0E9MruRbuslEBtkOlNO5eVqTZshfjuTS8nc/RQV4FnCre4tQ1KlD5ZcqtHT5xXYSH7hEixB295jUzeFWZ0Qbn6bb5yti5eFPo2Pr9PhUKnakSCiyjUGiv5QLGFj4kFsTOu3LpBL4GcUg6PGSOdA+lV2cLTs0XhlHVA/9yp2CUp1u9LHj6RYOmyhFKmpqm8GoC+6smonOKg/bUtMHcgQ+c3+J/lTdsfRbGWT6hIWjEiKyGjwS43QhuPsdOQ0FnXiKzLqTVcU0XL1OdsyhwdHuKNbmcdfPFUxnQ4sR/ribL8JRyFSXcM9RSObb6Ba4dzKLeInbA+tp6vQ8T/es/j9nlcJgEJvtNQdtbgKLJIhjXhClFP1nnPdouKQjSuy03iXZGSx3+eMR2vFWmkjvy3Q53qX9QXgEgzkRAx9gwr/gmftKyVWoqIbZfH+HABICdMUGJjXagK1aHrhDdXjuI8WplthdOZkopkjMhyHvEBl4KeCE1qN6sre+/0C9OA/wd/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(4143699003)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3YrUHB1cDV2ZGFiNmFhQ3ZwdGJsaTJadEwxVE5QTFM0TnBGM3Yvdk9iNG9r?=
 =?utf-8?B?dW9uTVRMTFdrSWJYSVd1V1hyWWlnNGtuOUpQRWVIM0puZGFkTjgydmlYNTNn?=
 =?utf-8?B?QU5OWWg0U0FDTDVFSTM3bDQwQ1U5cFNDKzhuZ2g0UmwzZ1lHWjZWdHN0eWRw?=
 =?utf-8?B?ajVJSkZ6WTlLWGdPR2pZQlhlRUt6RVZMNjIvcG53amxkV09Dc1Nadm0xNHh6?=
 =?utf-8?B?V0NRZzJQMG5taVNISHFOWEpFVTBJcHhJZTNDdjZURmc4QmRLSE03NkVWSHdP?=
 =?utf-8?B?dnBoeTlzd3V1YXVwZzhUbVpVM0RLMzhKVzBzc2NKU2dxbjJuNmlCM0ZqaXVy?=
 =?utf-8?B?T1FDU2JNR21rbExxUWZHUk9ZMmN6MFFPMGpZcnZSVUViZFZTclBFMlFuVDY5?=
 =?utf-8?B?TnBtdmRzQXBiTm9iZ0t4NmZBd1phWU56R0dqZjR2NG9DWnFLRmFLN2o3MlRD?=
 =?utf-8?B?TU8rQ1hubXN6RktzQkZOeDBiS2grbUhhK1pic0phb2RQTXNhNXRhV2hBd241?=
 =?utf-8?B?N0JrVmw1SVEzb2VsNEd0Ui9sdFNpNEVKQm0vUTYrOTRHcGNTNDVIcUVmeEpx?=
 =?utf-8?B?SkJsSU1SZWdZcWVJZW5YM3E5YjZLRjU5bnc3Y1U0MmxaMjhXem04RU56NVgw?=
 =?utf-8?B?TzJ4S200WVBDanoyTDM0RTdmOXAzam9rV0xlY1lIbWpBQWlybEJ0UFFYYWxk?=
 =?utf-8?B?QTZSNXl5MS83R0lkbjE1ZXZRWkJBS2JCVFdtRmNHQ21kOHMrb0FqcCtzaUxO?=
 =?utf-8?B?Z0E5OHc2U0loK016WXRUTS90YmY3ZUlZbDFnT1NFd0RaN3ZpSTB4TzRUWTJJ?=
 =?utf-8?B?UWNCdUs5Y1dFY2xzU210d0I4VlFEWGJVZGhCdWlJSUhLSjlEQVRDbXdVRjdR?=
 =?utf-8?B?anJwcXByeWlkL2dpUVdmOFlmNUV1d1BuTXh0b1E5a2VaWStJODVEYUhaMXZC?=
 =?utf-8?B?aU5rL21HMTkvWm83OUQvL2V3T3V5amdRMkNHazdjQ1plUnh6ZnU2ZGQwUGVp?=
 =?utf-8?B?WVBkWlVJZ1I3R1hlVFllYjRWNEVZLzJ4Uk9xY3BZRXlZcmVyQTZmeWJhMjk2?=
 =?utf-8?B?Unk0UWJJQU9XTW0vQVZvSFJCL21tT3VLVkVCeWs3RmJ0T211dEQ1OG9vNk5a?=
 =?utf-8?B?RUl6c3BablRWcXQvK05qK1FXQ0E4bVNyellHdWlnSGtyR3NOeVhTbkROeXI2?=
 =?utf-8?B?NjFRTnBQRTNrWTFrTW1QblNGTkd5QS9pV29FOHpmekQ3SkUzQnI5Yk5TZUpu?=
 =?utf-8?B?c21XR2YwcjBkU1F3UG9DUXA1SXB3eWh4VlhIMWo5R2REWVg2OEhNWEF4M1dS?=
 =?utf-8?B?ODFvR0Z1dEkxTzFZUkJuT2FYc2htRnhaTmE5UjZ4dTJFU1UzUmFibW41QTdt?=
 =?utf-8?B?RkhWK0ZSY1JPVVh5aWExcVQ4VTY0cnBqbDkxOXE0akYyS0JwSFh2ZFNUZ1A0?=
 =?utf-8?B?U1pQYzViL3AvNnVKWXhlUnpRMmtwWDVLS1FqVTZJengvdE9raXJ4OVFncXZU?=
 =?utf-8?B?QnFiNlF3Wm5iV3NnMXlxamdzU1ZoTDA5RjNUNEFOVXZKT2N4SnRLVFV5WHcz?=
 =?utf-8?B?NlhkZVdEd0dIK0FXV202YVVNdk15dlBzVnBHN1hyWEhlV1Vaclh0WnFMajlW?=
 =?utf-8?B?V3BvR1NkUnBZTHp2dlNJckI1YXlLc2lvSmdMY0FXWDBidFRucit3MmxoMEVH?=
 =?utf-8?B?b3JLZHAweHpJMUFHeDlZOUMvMkxuRFF0VlRVSFE5OUowUnBYUVN1TlZxWXFr?=
 =?utf-8?B?bmFuMUEyL3JEUWo5Z1RaaTcxTWN3U1RkUjhQUzQvTTVFVUEzQmZ1dFBGYUFV?=
 =?utf-8?B?UnFKejdCcXRKSmFyUkxpQ0lLOG5heWJWckZEYlB6Z0NEMGhOVnRPYU4rdHpD?=
 =?utf-8?B?Wkw0WUdSV3BGdnVlaXRTcFlTWDlMZFlRRHBGSkNnVk1RL3R4a3lRT3BWOHJr?=
 =?utf-8?B?dlFJZjBZQ1ZacmtaNzNadFk1Mlh0UUlnN0hNUzZDeXkwSzNpZUljSGQyRlB1?=
 =?utf-8?B?eEtaVlgrK3UrYzV3SEtOZDJWVkZSMDF0a2ZRblJXUjlUNG90VmkvZGJ4ZkNs?=
 =?utf-8?B?b1p6clpDSy9HRDNYamVMbzUyU1F0c2VELzB2bnN6RVVQaEhRcG01Rml0OWlX?=
 =?utf-8?B?bWdzTjdsMTBRZlg4N0x2Y2RucW1ibmFaUW5PZ3hWdUJaeklkU2Zwckt6RFMw?=
 =?utf-8?B?bmhJcG45MHM3YXg3ZnJ1WmVSa0JaRjR4S0g5S2lNdTI4MUJHeEcxbUp3bGRH?=
 =?utf-8?B?eUM5bUhEN2huWjE3aGIvQTY0Vnp2SE1Nc2JvVytwWG1kOURsb0YxMFJ0QThZ?=
 =?utf-8?Q?hSpxRY5tQAeOE44Ea2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d9d4eb-5704-4c7a-9d10-08decc358fd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 05:59:15.0891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4CWdbGcjueHhUWtltwxi2vi2njqoeyou3R8rJaBX6Rjvor3Qj5x9r9/FTaxudLkW4L2fgdKlsk/tDkp7Rj+XKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9334
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
ciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMTcs
IDIwMjYgMTA6MzggQU0NCj4gVG86IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5T
SEFOTVVHQU1AYW1kLmNvbT47DQo+IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmln
QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIDUvNV0gZHJtL2FtZGdwdTogU2lnbmFsIEdQVV9SRVNFVCBFVkVOVEZEDQo+IG5vdGlm
aWNhdGlvbnMNCj4NCj4NCj4NCj4gT24gMTItSnVuLTI2IDExOjIyIEFNLCBTcmluaXZhc2FuIFNo
YW5tdWdhbSB3cm90ZToNCj4gPiBTaWduYWwgR1BVX1JFU0VUIEVWRU5URkQgc3Vic2NyaXB0aW9u
cyBmcm9tIHRoZSBHUFUgcmVjb3ZlcnkgcGF0aC4NCj4gPg0KPiA+IFRoZSBHUFUgcmVjb3Zlcnkg
ZmxvdyBhbHJlYWR5IGRldGVybWluZXMgd2hlbiBhIGRldmljZSByZXNldCBoYXMNCj4gPiBjb21w
bGV0ZWQgc3VjY2Vzc2Z1bGx5LiBVc2UgdGhhdCBwb2ludCB0byB3YWtlIHVwIG1hdGNoaW5nIEVW
RU5URkQNCj4gPiBzdWJzY3JpYmVycy4NCj4gPg0KPg0KPiBJdCBzZWVtcyBiZW5lZmljaWFsIHRv
IHNlbmQgYW4gZXZlbnQgYmVmb3JlIGFuZCBhZnRlciB0aGUgcmVzZXQsIHJhdGhlciB0aGFuIG9u
bHkgb24NCj4gc3VjY2Vzc2Z1bCBjb21wbGV0aW9uIG9mIGEgcmVzZXQuDQo+DQo+ID4gR1BVX1JF
U0VUIGlzIGEgZGV2aWNlLXNjb3BlZCBldmVudCwgc28gbm8gcXVldWUgb2JqZWN0IGlzIHVzZWQu
ICBBbGwNCj4gPiBwcm9jZXNzZXMgdGhhdCBzdWJzY3JpYmVkIHRvIEdQVV9SRVNFVCBvbiB0aGUg
ZGV2aWNlIGFyZSBub3RpZmllZC4NCj4gPg0KDQpNeSBvcmlnaW5hbCBpbnRlbnRpb24gd2FzIHRv
IG5vdGlmeSB1c2Vyc3BhY2UgdGhhdCBHUFUgcmVjb3ZlcnkgaGFkIGNvbXBsZXRlZCBhbmQgdGhl
IGRldmljZSB3YXMgdXNhYmxlIGFnYWluLCB3aGljaCBpcyB3aHkgSSBvbmx5IHNpZ25hbGVkIG9u
IHN1Y2Nlc3NmdWwgY29tcGxldGlvbi4NCg0KT25lIHRoaW5nIEknbSB0cnlpbmcgdG8gdW5kZXJz
dGFuZCBpcyB3aGF0IHVzZXJzcGFjZSBpcyBleHBlY3RlZCB0byBkbyB3aXRoIGEgcmVzZXQtYmVn
aW4gbm90aWZpY2F0aW9uLiBGb3IgdGhlIG90aGVyIGV2ZW50cyBpbiB0aGlzIHNlcmllcywgRVZF
TlRGRCBpcyBvbmx5IHVzZWQgYXMgYSB3YWtldXAgbWVjaGFuaXNtIGFuZCBXQUlUX0VWRU5UIHBy
b3ZpZGVzIHRoZSBhc3NvY2lhdGVkIGRldGFpbHMuDQoNCkRvIHlvdSBoYXZlIGEgcGFydGljdWxh
ciB1c2Vyc3BhY2UgdXNlIGNhc2UgaW4gbWluZCB3aGVyZSBvYnNlcnZpbmcgYm90aCByZXNldCBi
ZWdpbiBhbmQgcmVzZXQgZW5kIHdvdWxkIGJlIGJlbmVmaWNpYWw/DQoNCkhpIEBLb2VuaWcsIENo
cmlzdGlhbi9ARGV1Y2hlciwgQWxleGFuZGVyOiBBbnkgb3BpbmlvbnMgb250byB0aGlzIHBsZWFz
ZT8NCg0KVGhhbmtzISwNClNyaW5pDQo=
