Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC96106FD97
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 07:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4582110EB05;
	Fri, 13 Mar 2026 07:25:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V0NKHrMu";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012068.outbound.protection.outlook.com
 [40.93.195.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1454810EB02
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 07:25:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlVLb4s19Lp1M0nKeJqUI7joZntuhavtCSFwe83PfHh7YbhdZp4G+CGMrp8GtTbi7HMUBsab8bHfElijhsWmXxzJNLq8bldJzZHqY1YrNqmhWwZcF7glE6SYE8Vs8lVAU9WARy8Y2mDCPY3Lr08/8OtBA8wdolATtgX2XGmL/JCzalOLW5Qsaef73l5gHp1nxDysPe6k08DyEg5TlMW9/fKroFEiFw1ZHbSTH1MpT2xgZI/DiniuxsfncnM81dxjELmCloAyf3odIYrgU7QtKADVshudLBOUIgVs0mutiFsZsxZp+QFj8Ev27WnhDz3srnUzVvTu3ea4yup+B6tplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=In5whX4N83WlLhO8ztR2Phbx3GmMR3M774GscCzh4dU=;
 b=B2ZCjYzzSJOv4ARZd02t6U+2d5uZY/o6tvbcKSg7OZX7SoRBKiQRQY2lMPBA/IFItnDmiDnv507DMtuiGraYiW2EQA01G88pwk436toXOPhguRCFnbzktZouOtoTsKtEqYDjy4IeOo/gkH+6C9SYd6mZCuOTQpp3wo9D9rpZYjxe4kktUTAEJWGqrOuS8uFaLx3a33aFAW0qfKMUdjOojyBDYavHmL/y2yDRCt+Ge74gNeE+paM5//8EGB5urOIJ5eN1CuRpJAQUDIc1/8gaXChJOWkfpzpzkRhXrjJWb2LJqinGStqXCJYRKN2i/ylosr+wkkQnpBwlwP/0/aKAUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=In5whX4N83WlLhO8ztR2Phbx3GmMR3M774GscCzh4dU=;
 b=V0NKHrMuzjxEWp7+6HnhTTyh7EB5moU6y8l3PD97oOOo5smAyoQtNjElJLj4yvwrdy1rm3Ev3C0zcpSUN7qr1LISDBJC2B/mHlJ8zZw5L73bNz6T2g5dfeao525hs6RE219hH3qbuggIY2Ba4h+vXdbPH2UfQlxHWdn+5RPGOUo=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by CY1PR12MB9651.namprd12.prod.outlook.com (2603:10b6:930:104::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Fri, 13 Mar
 2026 07:25:21 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%2]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 07:25:20 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "tursulin@ursulin.net" <tursulin@ursulin.net>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Mohan Marimuthu, Yogesh"
 <Yogesh.Mohanmarimuthu@amd.com>, "SHANMUGAM, SRINIVASAN"
 <SRINIVASAN.SHANMUGAM@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 03/11] drm/amdgpu: fix amdgpu_userq_evict
Thread-Topic: [PATCH 03/11] drm/amdgpu: fix amdgpu_userq_evict
Thread-Index: AQHcsMH/lpU+/nIEbU+KLCnRSSmwQrWsE4CQ
Date: Fri, 13 Mar 2026 07:25:20 +0000
Message-ID: <PH7PR12MB600084A0A97A664DA864A4F9FB45A@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-3-christian.koenig@amd.com>
In-Reply-To: <20260310191327.2279-3-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-13T07:25:11.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|CY1PR12MB9651:EE_
x-ms-office365-filtering-correlation-id: c7386813-6505-46c1-ee5c-08de80d1af11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|921020|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 0pJOFey1MaDZWwKl2fPBXDHTJET/Fh1xsAODXLgbnWAfLMVxApW6USigPF+PoLvFP0H9CJ8Pm08Mev3PckM8rq4Zw5ck8m/n0Ch2Rpui43GLMmnCJHpIajP0WM+LhI6GXB7ulQ/jaC1ZxMXapQDEr/wHeUyukGJfXWNwNrfgFVNcigYCl9iV9feWxfv9mx7FGU1WtqXzRywwJFI+TNzlvKtz1PbQejuI9Lwt3S7kabET9jmOBu2eFskwmGfgdjTcAtTnS8VNx3nB57sY+yr2B72PcvYsRXOOkd4d7BhUXitqJxdco1N0w6k+euXF4zBXMEp6eGAlTtmvtuB6VyP5laUZWEFmgfF49wzGe2TSQ86s8WEI4SDYdXJ6qmCpWDwicRuge80pBisZIDyyorOl8yly8nsJk63gagYq9nvvOUMd/pnH+iAN4eZmJcpKb/cfiEq0bA7wuwRgADApgp8+swZRGUIBOOamH4SftVmslSeB9GB1vQ3lw9p7e8IIGjxXQpv/iV4ddDSM9A/ypf9krru7tU7qtlBZOYq6Xq9sBVdDsQLMTl3k/rcgpnMAokA3HdJrlcFKpKhiq9ji9/4yqusy0GWpETCzCJmrXFTOZe4Nt09j30O+rfZAqjuPcL7jFrplKt7vdg/BZrSpHE8Miba5Axc6o/BxYyYqBqO6F/92lJIfpljYGAyjtKWPYZFgJyx58omeHzbhoxcEHAX8sOlwuqq61H4BweR23TVnaAWmwK40TAL862jmTRqbv9znqHK65Rhr2ZJjIG8Whsdbk/E/xYuRIv5epF1htkpd+JAwPNP8xZS7XbNShfVpzKv2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amk5NklvQ0VwWWVublU1YjZQaytXQm9WWWtuNmh1M1EvcmF4UERNWDMvMjRS?=
 =?utf-8?B?M2pucllGak1VcVRnc0dpK3N4NlVnb0NtSkEwYVAwcjNCVTd5S1d0ZXh0UUov?=
 =?utf-8?B?Z0t1bzVnek5YNWVVc21SdHpDNm9uTG1ocEQrNDFpL0hMdjN0aXlTM0dOeWdX?=
 =?utf-8?B?QXpSbzNQcWVFSHA5RlRBNkZLNmVKd2dNS3ZHalkwRkY3TjRwNGxCVWcwd1Np?=
 =?utf-8?B?Y0xvZ3Zzd0g1Z3RSdVYxc2IyQlZQcEgxTlBtOUU4NjBqVWV5Z1M1TFM0TWtx?=
 =?utf-8?B?Z29RV1lCMGpsNTRrS3BzN0U0QjJGaEhkV2M1eUZmaGV4NnpvZnozeEhLVkM1?=
 =?utf-8?B?bHIyeERyYTlDZm9GamtnWkh5RmxvYUQ2LytMNmZRREJteStXdlcvMFZWM2Fv?=
 =?utf-8?B?a29FbFNHcUtBQnFYR3RqcnBzekIzTExVbWQ1NUlra0liN2dDR2lZYlFoVi9E?=
 =?utf-8?B?NVVyUGV5RExNOEcyWTBoRUNYOXI2amNEdFhZN1pGdUs1NFkweTJhN3p0RG42?=
 =?utf-8?B?cDZqYm41ekNuQWFsTkp4YlFrV1FETVNzZXVGUnVVeDJYV09OQTQ2Z3l2Vnk3?=
 =?utf-8?B?UTlCR1Q3MktFRi9UbG1ueXI4YlBqZ0tLY0VKY2dzT0NvajdOWWVZckNWYmMr?=
 =?utf-8?B?dU8vVTNnSE8wdnBudUs0YzZmUVg2dWxZbHZydGlld3RXL1JUR0J3U3YwRy9O?=
 =?utf-8?B?NW5nMDRNVXFkeThqSWJPbXhLRG1NakN0aXdrMjczUUx1WGpPYnd5MU9jVDhD?=
 =?utf-8?B?R2wrSWY5TnNoQmliUS9mVHJhRFR4bFluU0k5QmlMVjhSSytDalE2YXoxZXVV?=
 =?utf-8?B?NUladGh0NkxoZTRaNENmcTJKQmxaUEx1UUx1amJrSUxyaEVLdDl5eTRHVjhG?=
 =?utf-8?B?L3dscU9RZWlQaHU4VHlNYW1UaXdrQ1lEUk9mYnBjSWNHVmxzYUNHY0dhQ1lp?=
 =?utf-8?B?eThITjgzVzY2MFh1cHNzY3UrRE1kNjZ3czlIOW4xT1QwRTFMNXZVMHBEWGN3?=
 =?utf-8?B?TjRTamtMVEI5L0JDMjhHTG91dmJ2Z0d4VktXcVdEeGkzc29zaFRaS2piZmZ5?=
 =?utf-8?B?eWRqY0cydFI4TThscXRGZkxZeStFWUtDQ2RrR28yZ3VITGJQTTlNY3BlaHNU?=
 =?utf-8?B?YTc5cXMxd1ZucE4vR010VzJHNFVaYWszaUxGRVFtVzJMSmJmOGlWNlhsMFhL?=
 =?utf-8?B?Mks2MDAvYkJRSG1idjE0ZVZjdlZWRHlVQU5EaGh2ejNuaDJ5K2xTUmt2bVZ0?=
 =?utf-8?B?SEhZLzd0K2E5cWVyV2NrY0Q1d0Z4dTJ0WVI2dnJ5eTA3RU5uSk1qSkJCL0xp?=
 =?utf-8?B?bmQ3UnlWUWZ0SGVJbCs0SmhieVRJZHFCdmlIMFM1UnR0MDI5TGRlMTdWaEdj?=
 =?utf-8?B?VzNuVHJ4V2FUNExPQmZDQ3dNT091cUpLZXdXb1VnZG9SWTlTajJ6c2Z3N1Vv?=
 =?utf-8?B?S1IvZ29FalBCanZkS1JGeEFJb2lFQkY1eEdzdVJVbm1od3pvTStKckVYZHkv?=
 =?utf-8?B?d3E4NG5ZT2N5NnhyMnVHdXVPWGJRcGROWlQyY1kvdTlEWnZkUlpKQm1FWFE0?=
 =?utf-8?B?a3BBc2ZKVk1TajArc0FsU2NCNEpIZU00UEhDRUNqUEtUaVQ5eVJZQzUwdlZJ?=
 =?utf-8?B?WXNPSC82VnM0RXZDOWxuTCtzOE9FcEN3M0ozTzRGR3Naem4zSDZmU2ErODl1?=
 =?utf-8?B?VUJ0WU96Q0dWQzFuQXVld3JReGhTRmFqaHNCdWx6b0hmdmVBUEovdWVzUmFX?=
 =?utf-8?B?T0ZlSWp5RzFleFZiSDY0WmpiaHpkM2F1WGJqaytxdUx6SWJRaGNmb2dZM2pC?=
 =?utf-8?B?V29jNjU4ZGIyM0R0YWxHUnkzb2lzR0FkN0VlZWQxYlpxVGlQOTFUWGdtcUFn?=
 =?utf-8?B?RHJQdlNJS2dWRmJkMWRoTjFKdStPSEZFeWlPZHB2WFA2eGJYY251eDlQYzFU?=
 =?utf-8?B?V2ZOMTlvQ1hWYWtIM0JKVmpwekoxMUFab0Fzb0daUDMzaHExbWZHTTFYRTZU?=
 =?utf-8?B?ZEhybFBqdWdzVlB4OWQ3ZVJ6dFhKa0dPWThMTlJBS003bjhCcU1XWmZZVVlu?=
 =?utf-8?B?UW5qRHptenJ4SWtOc3NLRU9YUHRGSWx5cHZGMVVPZndxaUhmMlltV2FBZTNW?=
 =?utf-8?B?WHFMM3Z3eHNRMlg3VzdWUVEzcFdsTzEreW1iMjdEdnc0d0xHNkJwQjNvc2VM?=
 =?utf-8?B?V3JzN2NkckRFenBtV1FjVyt0akFiZ2RYR0lvU2p3dmY5NXJDWXVZeUNoaDZT?=
 =?utf-8?B?ekhmSWRENktOc01PeUx4U1cyTXptWWRRdGd0WjZEV0JBMm1aOWVLQ3hiRWhi?=
 =?utf-8?Q?/dy6sUq4habLS6zwPi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7386813-6505-46c1-ee5c-08de80d1af11
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 07:25:20.6739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUCJnKcPjuTcQYRoj0iVq7NCRQuHN6BD5durovuJZKV+NvR7qNTtcmwKdkwCp9/2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9651
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

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29t
Pg0KDQpSZWdhcmRzLA0KICAgICAgUHJpa2UNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWls
LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAxMSwgMjAyNiAzOjEzIEFNDQo+IFRvOiB0
dXJzdWxpbkB1cnN1bGluLm5ldDsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPjsNCj4gTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgTW9oYW4g
TWFyaW11dGh1LCBZb2dlc2gNCj4gPFlvZ2VzaC5Nb2hhbm1hcmltdXRodUBhbWQuY29tPjsgU0hB
Tk1VR0FNLCBTUklOSVZBU0FODQo+IDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPjsgS2hh
dHJpLCBTdW5pbCA8U3VuaWwuS2hhdHJpQGFtZC5jb20+Ow0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggMDMvMTFdIGRybS9hbWRncHU6IGZpeCBhbWRn
cHVfdXNlcnFfZXZpY3QNCj4NCj4gQ2FuY2VsaW5nIHRoZSByZXN1bWUgd29ya2VyIHN5bmNob25p
emVkIGNhbiBkZWFkbG9jayBiZWNhdXNlIGl0IGNhbiBpbiB0dXJuIHdhaXQNCj4gZm9yIHRoZSBl
dmljdGlvbiB3b3JrZXIgdGhyb3VnaCB0aGUgdXNlcnFfbXV0ZXguDQo+DQo+IFNpZ25lZC1vZmYt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gUmV2aWV3
ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYyB8IDkgKystLS0tLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiBpbmRleCA2
NTc4M2Y5NTg0YzUuLjg1YWRjNTNlYjUyMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gQEAgLTEzMzEsMTMgKzEzMzEsOCBAQCBhbWRncHVfdXNl
cnFfZXZpY3Qoc3RydWN0IGFtZGdwdV91c2VycV9tZ3INCj4gKnVxX21nciwNCj4gICAgICAgLyog
U2lnbmFsIGN1cnJlbnQgZXZpY3Rpb24gZmVuY2UgKi8NCj4gICAgICAgYW1kZ3B1X2V2aWN0aW9u
X2ZlbmNlX3NpZ25hbChldmZfbWdyLCBldl9mZW5jZSk7DQo+DQo+IC0gICAgIGlmIChldmZfbWdy
LT5mZF9jbG9zaW5nKSB7DQo+IC0gICAgICAgICAgICAgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5j
KCZ1cV9tZ3ItPnJlc3VtZV93b3JrKTsNCj4gLSAgICAgICAgICAgICByZXR1cm47DQo+IC0gICAg
IH0NCj4gLQ0KPiAtICAgICAvKiBTY2hlZHVsZSBhIHJlc3VtZSB3b3JrICovDQo+IC0gICAgIHNj
aGVkdWxlX2RlbGF5ZWRfd29yaygmdXFfbWdyLT5yZXN1bWVfd29yaywgMCk7DQo+ICsgICAgIGlm
ICghZXZmX21nci0+ZmRfY2xvc2luZykNCj4gKyAgICAgICAgICAgICBzY2hlZHVsZV9kZWxheWVk
X3dvcmsoJnVxX21nci0+cmVzdW1lX3dvcmssIDApOw0KPiAgfQ0KPg0KPiAgaW50IGFtZGdwdV91
c2VycV9tZ3JfaW5pdChzdHJ1Y3QgYW1kZ3B1X3VzZXJxX21nciAqdXNlcnFfbWdyLCBzdHJ1Y3Qg
ZHJtX2ZpbGUNCj4gKmZpbGVfcHJpdiwNCj4gLS0NCj4gMi40My4wDQoNCg==
