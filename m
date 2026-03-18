Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC56103E160
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 11:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7CAE10E3E0;
	Wed, 18 Mar 2026 11:45:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K5Q+YUFP";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D2810E3E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 11:45:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eH7X7wpgRi9FkETqIF/QOTWRW2LjUjaEC64N2uPAOXD/EpHaSe05F1QY60+y0Ov3le7ilfG9O8Su/cCbU5zWzl5xw19jIXEo2jXCkp5h4x2m8zYQcyLXLfjL/8wsAE858PvaNJ9SiIC7PFt9UURxE6JH1Y5YNMhl9Xp4/Pfdm2nPArNEW5DaacYaFO/Sm8LvId+4o4XZCkp0Qq3El2KPoENeUuFi4xI0nUIVXSZ0fNRnD3eRE4v7gT0awaIj1zvLMyEQTZ0MeU2ztsRNg5hPRG7qMzggD5lSZoiLcUtfetqcVY82ZKBjMeyFZy23DRaUs2n6Ey06d8CZWkSP1FVfqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUxFI94IybFxjX9MMea0LW9Q68+phEtxw1tAsLWpJ2A=;
 b=X7bKGXTSh/EGEq/VlyfkC/8dEiEzwX3qbmQvAnZZ5TYCDD72lei29+9kR3AvNR9Vlp9DrIsXJAD0/14GRA8F9zQNlq8Bx5L6NYGX5P7H16GPOHjWDwMS0NiJzOyAk+h6So0+xvUpsOGLaePc5Zy0RCgg/hsunX0O0+D1nsXJeBky94P4bSARSj6CCtKgvvsZZ9eyEkxkFFRZ8s+bkuWfcMmVLR4z7Q/IsO/XMcMJbC12TZFIxNOJP7jYhpO8I8ChbeedjoPHiiATyJV5R30H8M7tKRWdstx8PpANt4ypZm47FBjLXQEaqYTThZzzR+K3fFv370MEt2cX2Igv4ngy9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUxFI94IybFxjX9MMea0LW9Q68+phEtxw1tAsLWpJ2A=;
 b=K5Q+YUFPB7qeE7ERFxf6UzbYmBqjMdVheZwpC6s6+cr3CWRUYNA2A6Gyu3nPWpg0xPghQ+gS7Md+sppOdHl0pd0sNc/MkVOdfZOW858hnk7vc/YzmfDw/WP3RIKgRtuVfGgCZTEm8P+YpynJoe3WvFtyL0zmptxC1ecDRTPX9BY=
Received: from BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 11:44:59 +0000
Received: from BYAPR12MB2597.namprd12.prod.outlook.com
 ([fe80::bd10:5352:bf15:e02]) by BYAPR12MB2597.namprd12.prod.outlook.com
 ([fe80::bd10:5352:bf15:e02%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 11:44:58 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add support to query vram info from firmware
Thread-Topic: [PATCH] drm/amdgpu: add support to query vram info from firmware
Thread-Index: AQHctsSH54D3VJizYESzlbeoGFE7PbW0HZkAgAAODEA=
Date: Wed, 18 Mar 2026 11:44:57 +0000
Message-ID: <BYAPR12MB25979C4440EDF3F0AC2C0CB9E54EA@BYAPR12MB2597.namprd12.prod.outlook.com>
References: <20260318104609.1739924-1-ganglxie@amd.com>
 <6c4a19b8-ca0d-40d3-a9cb-fa9e28fc82c3@amd.com>
In-Reply-To: <6c4a19b8-ca0d-40d3-a9cb-fa9e28fc82c3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-18T11:44:34.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB2597:EE_|DM4PR12MB6111:EE_
x-ms-office365-filtering-correlation-id: 1154a408-3f78-4c40-8e3f-08de84e3c803
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|7053199007|18002099003|22082099003;
x-microsoft-antispam-message-info: ZcwYK2ffM5GWbYy8kxcRbcXi6t0xsIUjGUHKXUATgOCKYbyuPVtpbyrkCVQR6WhCcg+xQ5EvLC2Eq/oRF1qeP4+okx3yRjwSdxOftjYUWnn+CQf+aUsrVd8KMe02hoEQ56Mx2+Opgiu1Qx8HTCkfqXYcDz2bo4nTjlpmc/qe0Tf6gpls14OATcDNH9R2rkKBMqqMDADZph8Z8du5Hnk74XQYC100JnJ+0DyBg2pF5LRjQMPSh9Mjim7MIWV15AHzePafPYHbJPzQ7N+OgE/L17bJsb4WV52LQap21jHBSRgxp0FxKa7NrC6pBqbq1392xmQBpcp/yxjNeUZ8I0bjdD/tKX9yMyBogH7sD+ZubHnJ0ton8toXahs2c9j6kCbE81W286paTG/dk+7WhxPS450nscx3qqSa+4RwE9uW9Eg/rIwTNXDGcUTLcBQQEGX2NhWXvp1oOUVbA2XKWdXZ8gcaPwJgN7EY/hNyHje8S9u7tvkPkH6hiEP0suDyVP0NpQZydAZx3YUeOf5ZhQMA3Zk2zmywl46rfqz9v9pHJ7peppzNz7k5wjici5MbLH5/UU0Lh14mlQ2B27pyRqK5CFMcv/ZzqF1Ex2nNBtlDjnTI8QnIz8RMyilTQgtbA2e3V9XR90o9kvc6/nWdmRATMSIogMLnEnBVVInfX0+7BBVARIZ04Qz1LaRg3mt8k+8e/N6XLuOiNS0WTwrZrNLJtnyfVnwfclaPvK/YNtD304W8VLH8f9xGWnCusW8Bw62uJJ8NmbvMhEOq9lkEBer0OIL195xhUN+tG5e7i5pNjAM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(7053199007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b21JaGdiZThhUkEvNGNXajRDV0QraEcvQVhjUm01K3o5MFV5UzVVakQ5cDJC?=
 =?utf-8?B?cWZiWXlOVmpwdGQ0eVZpSnpJWFk0ZHhkRWNuSXptQmwwMnBYRUZCWC9YSGJG?=
 =?utf-8?B?bG95WUxCOXpHTnFuZXM5b0NETlZMQkRIVXpYQXpaVVVnTzZNYlJuUnJ6KzdV?=
 =?utf-8?B?SkMvS1hoN2EzaEN2M1gycUZDZ0Rmb2NVcTZtMlBxd25VWnJCb3BhblhqM1RK?=
 =?utf-8?B?TGlSN0RaQ0RDdVFpU3dxSk53QmFqT0VpS1J2ZWtnOU1qUk9SSHNYbEp5S1dI?=
 =?utf-8?B?cUdHdU1rV3R0eDVidVhpVzczaDJHVVAwSE9jNGgrNkRPNHQ1RmZDcWVnc0Ft?=
 =?utf-8?B?RUFOM3QwclVvRzczK3Zmc0t3dDBOWUhHMmdlYk1ZaGtGK0ZDTTc5OUtBTkxn?=
 =?utf-8?B?TVJZWkhjMkdkVE83TmVxVFBtZ1F3N00zNjlIRFVBNEF6SFpGc2JzNXBSM0Nl?=
 =?utf-8?B?MVlRMC9IMnk5RzFlcXNiWWJFYytqbEthWTdoYkt3U1pxOGJiNlJad256TmJw?=
 =?utf-8?B?c3JRVEtieXdZMjUyeElDcDFRdTNiTm1FYUZ5VjRnWXR4M2pxbWFoYVhpNEVI?=
 =?utf-8?B?cTNBbDY2L25hVWFvRVBGYVl6R3k2N0VmbjF6cnVHTGJvT1VKMFJIamh6Ym9s?=
 =?utf-8?B?alZGbk9EVXZRM3FLWXQwUWpuZCsvZXZDZ0d6WjUwU1pGMjBlaFJxQjBlTGJw?=
 =?utf-8?B?ZHRoWEVUWEVaN0FLcXI5VXhWeWVKMnVaYXpOM0M2ZVR5UG9GYUVQbkgyUFlE?=
 =?utf-8?B?TCtGc2Q5azUrSitDRjBoUlNNeTRuUU45cUY3SlBaQSt6Yk5KWmw1Wm0wT2tI?=
 =?utf-8?B?Z21yVlhncmlBWG9WeVowVmhOUytnc1VNY2QvSUJRWUdYeUxJdC93dEkzRk11?=
 =?utf-8?B?MStrQ2g4a3VBWk9MQzNsbWY5Z25YZkdvb2lLYVlwMVluWDBsdWwzcmtNVXI1?=
 =?utf-8?B?aXIvdVJ3NXgzamQySU9FMFUzcVdZdHVVYTF0Qm11djVQY05VNE9TcU84RExK?=
 =?utf-8?B?L29pakJCcjgvLzl4UEUzQ2wyZlU2UmdvWE9RaCtCUFM0OVkvak5uR2ZKYmxq?=
 =?utf-8?B?ZkJQWjlGZTk3RXUxUlVnLzZMdGpHeStUSDVnRlpQMUlDV0REdTgrdXg5bGJa?=
 =?utf-8?B?NTlYZEFaVDFzR0xJekFDYnY0cldCaDJZM1NleGliZ2dOM3RWOTh6VFltTi9z?=
 =?utf-8?B?dVRrM3plcStjVGh5Z2h3ejB3c1gvUWR0bzJ6c1hFalNFcUQ0TkhjdCtVK2s0?=
 =?utf-8?B?bS94eStvc3gxYnpQbTVKWVdzZVFmbmgwcUlEMExSbi9DVVlzaU4rNWZDMURU?=
 =?utf-8?B?bzJnVkpXSzlGZ3hXN2R6VVNmUFcyVDVyTjRPaGM2NjZSREF5QjNncEVVZ0pY?=
 =?utf-8?B?MzlBWGwxYzV5eGtsL3BPSjd2R3QvMytBek9tUXQxRnUxZjVDM09KRjhLWDdY?=
 =?utf-8?B?d2JzdTNBcWQ5S3I1QmhRLzYxNElHWU14RGlNblI5L1NuZE9ianczUGpBVVRU?=
 =?utf-8?B?dWJRVUZVZUMxYWU1OHkxNTh6YU5HZmdtekhTZU1meXJmb1Q1ZGRoUS83WkNk?=
 =?utf-8?B?RXVhSDBKTmJXM1RGNTlCbkp4OC9JbHdkUDhNcTMxV2dCbktUWDM2T0R3UlNt?=
 =?utf-8?B?UzhlMzM3THE5Zk1Vb0lnd3hHRFkyRzYwWlZROElra204dWpVWjAvSlVkb3py?=
 =?utf-8?B?UDczZmxjaUMwWFlvVHRmMUU3T2dZcit1T2ZOdkoyOGMxNUZMWndHZHl2ZUFQ?=
 =?utf-8?B?Nm1kdUNZb2wwVnFQQW5XN3oxdFVRbEtKUGM5dlRnUnVkZ1Zrem50dmlJNHhq?=
 =?utf-8?B?WHpzWkFGc2s3TXRaWGZGUkQ1bUt3c1JMYVZnV3lMeSttbnJHOGtHSUNTOEtL?=
 =?utf-8?B?ZGVWRGdHekpBN0cxZ3Fyc2gvbUFSL25ZWEdVRTlxNkZwd3FIUWtvMUhXWlVp?=
 =?utf-8?B?cEw3NXorUXY1dk9yM29iYm1TU01BSHg2bHAxU0ZMdUJoUSthaXJWdkxCeEJT?=
 =?utf-8?B?VXU4czViZ2pHclRmdFBhVitvNDhxNkR2YmxGTTllNGVSMjV0WUV2OVd3eHJE?=
 =?utf-8?B?RHVUZStlZDF5Z2srQWhRaVA3clNaU2YxNnBlSWlhSExycjkzZGV0aEI5Vjlq?=
 =?utf-8?B?SkFYSEhaaGFDRDZ1SmhiVm05eWdQRzZ0VzhGSHc2eGIvNUJyQXBFRnZKT3Z2?=
 =?utf-8?B?QmpRYlZhQ2lHV0pNWHI2SmJLMysyanQ2MVFrZTQxWDdEeEhRY2tmeUhSV3Nz?=
 =?utf-8?B?WnhQalcySGZObzV1U2xtNTVoYjJGRHZvY096Ni96ckZtTzdHM3dobXRqTnE1?=
 =?utf-8?Q?+53lPjO4PkNksOwveA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1154a408-3f78-4c40-8e3f-08de84e3c803
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 11:44:58.0695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1uNjDWbWAESOgrKxDMBS28QlrTq2IC5HM3OSV2FeKohUSURCWT1EKnBZtJlkGF8me14efugQUgOr+7Lb2WMEqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KVGhhbmtzLCB3aWxsIGRpc2N1c3MgaW50ZXJuYWxseSBhbmQgcmVmaW5lIGl0DQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQu
Y29tPg0KU2VudDogV2VkbmVzZGF5LCBNYXJjaCAxOCwgMjAyNiA2OjU0IFBNDQpUbzogWGllLCBQ
YXRyaWNrIDxHYW5nbGlhbmcuWGllQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBaaG91MSwg
VGFvIDxUYW8uWmhvdTFAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6
IGFkZCBzdXBwb3J0IHRvIHF1ZXJ5IHZyYW0gaW5mbyBmcm9tIGZpcm13YXJlDQoNCg0KDQpPbiAx
OC1NYXItMjYgNDoxNiBQTSwgR2FuZ2xpYW5nIFhpZSB3cm90ZToNCj4gYWRkIHN1cHBvcnQgdG8g
cXVlcnkgdnJhbSBpbmZvIGZyb20gZmlybXdhcmUNCj4NCj4gU2lnbmVkLW9mZi1ieTogR2FuZ2xp
YW5nIFhpZSA8Z2FuZ2x4aWVAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2F0b21maXJtd2FyZS5jIHwgIDYgKysrKysrDQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyAgICAgICAgICAgIHwgMTYgKysrKysrKysrKy0t
LS0tLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
dG9tZmlybXdhcmUuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hdG9t
ZmlybXdhcmUuYw0KPiBpbmRleCA3ZjQ3NTFlNWNhYWYuLjcxMmIwNTg4YTM1OSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2F0b21maXJtd2FyZS5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hdG9tZmlybXdhcmUuYw0K
PiBAQCAtMzk5LDYgKzM5OSw5IEBAIGFtZGdwdV9hdG9tZmlybXdhcmVfZ2V0X3ZyYW1faW5mbyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgICAgICAgICBzd2l0Y2ggKGFtZGdw
dV9pcF92ZXJzaW9uKGFkZXYsIEdDX0hXSVAsIDApKSB7DQo+ICAgICAgICAgICAgICAgY2FzZSBJ
UF9WRVJTSU9OKDEyLCAwLCAwKToNCj4gICAgICAgICAgICAgICBjYXNlIElQX1ZFUlNJT04oMTIs
IDAsIDEpOg0KPiArICAgICAgICAgICAgIGNhc2UgSVBfVkVSU0lPTig5LCA1LCAwKToNCj4gKyAg
ICAgICAgICAgICBjYXNlIElQX1ZFUlNJT04oOSwgNCwgNCk6DQo+ICsgICAgICAgICAgICAgY2Fz
ZSBJUF9WRVJTSU9OKDksIDQsIDMpOg0KPiAgICAgICAgICAgICAgICAgICAgICAgaW5kZXggPSBn
ZXRfaW5kZXhfaW50b19tYXN0ZXJfdGFibGUoYXRvbV9tYXN0ZXJfbGlzdF9vZl9kYXRhX3RhYmxl
c192Ml8xLCB1bWNfaW5mbyk7DQo+ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gICAg
ICAgICAgICAgICBkZWZhdWx0Og0KPiBAQCAtNDc1LDYgKzQ3OCw5IEBAIGFtZGdwdV9hdG9tZmly
bXdhcmVfZ2V0X3ZyYW1faW5mbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAgICAg
ICAgICAgICAgICAgICAgIHN3aXRjaCAoYW1kZ3B1X2lwX3ZlcnNpb24oYWRldiwgR0NfSFdJUCwg
MCkpIHsNCj4gICAgICAgICAgICAgICAgICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMiwgMCwgMCk6
DQo+ICAgICAgICAgICAgICAgICAgICAgICBjYXNlIElQX1ZFUlNJT04oMTIsIDAsIDEpOg0KPiAr
ICAgICAgICAgICAgICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDksIDUsIDApOg0KPiArICAgICAg
ICAgICAgICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDksIDQsIDQpOg0KPiArICAgICAgICAgICAg
ICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDksIDQsIDMpOg0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1bWNfaW5mbyA9ICh1bmlvbiB1bWNfaW5mbyAqKShtb2RlX2luZm8tPmF0b21f
Y29udGV4dC0+YmlvcyArDQo+IGRhdGFfb2Zmc2V0KTsNCj4NCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaWYgKGZyZXYgPT0gNCkgew0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192OV8wLmMNCj4gaW5kZXggZTM1ZWQwY2MyZWM2Li4wMjgyN2FmYWEzNjUgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYw0KPiBAQCAtMTgwNiw2ICsxODA2LDcg
QEAgc3RhdGljIHZvaWQgZ21jX3Y5XzBfc2F2ZV9yZWdpc3RlcnMoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpDQo+ICAgc3RhdGljIHZvaWQgZ21jX3Y5XzRfM19pbml0X3ZyYW1faW5mbyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gICB7DQo+ICAgICAgIHN0YXRpYyBjb25zdCB1MzIg
cmVnQklGX0JJT1NfU0NSQVRDSF80ID0gMHg1MDsNCj4gKyAgICAgaW50IGRldl92YXIgPSBhZGV2
LT5wZGV2LT5kZXZpY2UgJiAweEY7DQo+ICAgICAgIHUzMiB2cmFtX2luZm87DQo+DQo+ICAgICAg
IGFkZXYtPmdtYy52cmFtX3R5cGUgPSBBTURHUFVfVlJBTV9UWVBFX0hCTTsgQEAgLTE4MTgsNiAr
MTgxOSwxMCBAQA0KPiBzdGF0aWMgdm9pZCBnbWNfdjlfNF8zX2luaXRfdnJhbV9pbmZvKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgICAgICAgICAgICAgIGFkZXYtPnJldl9pZCA9PSAw
eDMpDQo+ICAgICAgICAgICAgICAgYWRldi0+Z21jLnZyYW1fdHlwZSA9IEFNREdQVV9WUkFNX1RZ
UEVfSEJNM0U7DQo+DQo+ICsgICAgIGlmIChhbWRncHVfaXBfdmVyc2lvbihhZGV2LCBHQ19IV0lQ
LCAwKSA9PSBJUF9WRVJTSU9OKDksIDQsIDMpICYmDQo+ICsgICAgICAgICAoZGV2X3ZhciA9PSAw
eDUpKQ0KPiArICAgICAgICAgICAgIGFkZXYtPmdtYy52cmFtX3R5cGUgPSBBTURHUFVfVlJBTV9U
WVBFX0hCTTNFOw0KPiArDQo+ICAgICAgIGlmICghKGFkZXYtPmZsYWdzICYgQU1EX0lTX0FQVSkg
JiYgIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkgew0KPiAgICAgICAgICAgICAgIHZyYW1faW5mbyA9
IFJSRUczMihyZWdCSUZfQklPU19TQ1JBVENIXzQpOw0KPiAgICAgICAgICAgICAgIGFkZXYtPmdt
Yy52cmFtX3ZlbmRvciA9IHZyYW1faW5mbyAmIDB4RjsgQEAgLTE4MzYsOSArMTg0MSw3IEBADQo+
IHN0YXRpYyBpbnQgZ21jX3Y5XzBfc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9i
bG9jaykNCj4NCj4gICAgICAgc3Bpbl9sb2NrX2luaXQoJmFkZXYtPmdtYy5pbnZhbGlkYXRlX2xv
Y2spOw0KPg0KPiAtICAgICBpZiAoYW1kZ3B1X2lzX211bHRpX2FpZChhZGV2KSkgew0KPiAtICAg
ICAgICAgICAgIGdtY192OV80XzNfaW5pdF92cmFtX2luZm8oYWRldik7DQo+IC0gICAgIH0gZWxz
ZSBpZiAoIWFkZXYtPmJpb3MpIHsNCj4gKyAgICAgaWYgKCFhZGV2LT5iaW9zKSB7DQo+ICAgICAg
ICAgICAgICAgaWYgKGFkZXYtPmZsYWdzICYgQU1EX0lTX0FQVSkgew0KPiAgICAgICAgICAgICAg
ICAgICAgICAgYWRldi0+Z21jLnZyYW1fdHlwZSA9IEFNREdQVV9WUkFNX1RZUEVfRERSNDsNCj4g
ICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPmdtYy52cmFtX3dpZHRoID0gNjQgKiA2NDsNCg0K
S2VlcGluZyB0aGlzIGFzIHRoZSBmaXJzdCBvcHRpb24gZG9lc24ndCB3b3JrIGZvciBNSTMwMEEg
QVBVLiBBbHNvIHRoaXMgZG9lc24ndCB3b3JrIGZvciBzY2VuYXJpb3Mgd2hlcmUgVkJJT1MgaW1h
Z2UgaXMgbm90IGF2YWlsYWJsZSBsaWtlIHBhc3N0aHJvdWdoLg0KDQpUaGFua3MsDQpMaWpvDQoN
Cj4gQEAgLTE4NDYsOSArMTg0OSw4IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfc3dfaW5pdChzdHJ1
Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykNCj4gICAgICAgICAgICAgICAgICAgICAgIGFk
ZXYtPmdtYy52cmFtX3R5cGUgPSBBTURHUFVfVlJBTV9UWVBFX0hCTTsNCj4gICAgICAgICAgICAg
ICAgICAgICAgIGFkZXYtPmdtYy52cmFtX3dpZHRoID0gMTI4ICogNjQ7DQo+ICAgICAgICAgICAg
ICAgfQ0KPiAtICAgICB9IGVsc2Ugew0KPiAtICAgICAgICAgICAgIHIgPSBhbWRncHVfYXRvbWZp
cm13YXJlX2dldF92cmFtX2luZm8oYWRldiwNCj4gLSAgICAgICAgICAgICAgICAgICAgICZ2cmFt
X3dpZHRoLCAmdnJhbV90eXBlLCAmdnJhbV92ZW5kb3IpOw0KPiArICAgICB9IGVsc2UgaWYgKCFh
bWRncHVfYXRvbWZpcm13YXJlX2dldF92cmFtX2luZm8oYWRldiwNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgJnZyYW1fd2lkdGgsICZ2cmFtX3R5cGUsICZ2cmFtX3ZlbmRvcikpIHsN
Cj4gICAgICAgICAgICAgICBpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KPiAgICAgICAgICAg
ICAgICAgICAgICAgLyogRm9yIFZlZ2ExMCBTUi1JT1YsIHZyYW1fd2lkdGggY2FuJ3QgYmUgcmVh
ZCBmcm9tIEFUT00gYXMgUkFWRU4sDQo+ICAgICAgICAgICAgICAgICAgICAgICAgKiBhbmQgREYg
cmVsYXRlZCByZWdpc3RlcnMgaXMgbm90IHJlYWRhYmxlLCBzZWVtcyBoYXJkY29yZCBpcw0KPiB0
aGUgQEAgLTE4NzUsNiArMTg3Nyw4IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfc3dfaW5pdChzdHJ1
Y3QNCj4gYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykNCj4NCj4gICAgICAgICAgICAgICBhZGV2
LT5nbWMudnJhbV90eXBlID0gdnJhbV90eXBlOw0KPiAgICAgICAgICAgICAgIGFkZXYtPmdtYy52
cmFtX3ZlbmRvciA9IHZyYW1fdmVuZG9yOw0KPiArICAgICB9IGVsc2UgaWYgKGFtZGdwdV9pc19t
dWx0aV9haWQoYWRldikpIHsNCj4gKyAgICAgICAgICAgICBnbWNfdjlfNF8zX2luaXRfdnJhbV9p
bmZvKGFkZXYpOw0KPiAgICAgICB9DQo+ICAgICAgIHN3aXRjaCAoYW1kZ3B1X2lwX3ZlcnNpb24o
YWRldiwgR0NfSFdJUCwgMCkpIHsNCj4gICAgICAgY2FzZSBJUF9WRVJTSU9OKDksIDEsIDApOg0K
DQo=
