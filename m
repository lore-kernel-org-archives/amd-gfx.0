Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F519CD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 08:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4503510E1CA;
	Tue, 26 May 2026 08:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XxxNgH3c";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4714410E1CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 08:25:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLc7HzYoM7d0j7quWZwZs7Ag8/+T3z5/EbcRtgxw+6EJkjgSV+ElMQJzbiZQYnAehxVbfN2bzaSaiL9Ftv+dFM4ebDkaj3X5xAnnvLhfx2X7AwiQZhaR4+fQ0TrofEQo8nGYLoy0RXpXYmsEm4h1vkGlAWtViJkJUFM1EnjfNunvvsR7tVI3of08bsEe9k8boYUPrV0enhhvuK4cuiyMjbNT015NtDsJvLpXJ0GHB9gPB7le6Q2/zIKp+cYkBbsFhFaOn6SBkolllEo3AdrBs/rtMrF5AY2yT2TN2dQiGR2+ccCchdK3sGy68iwcZLNe+Wcz7Tc2nRLFGxoTkaHgxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWTLJZZBbQqqnZzDXsRxkOiE1vNpy2MQVK/Ibc5BaRE=;
 b=DOPeKCims5iQ+ixoGVjhgFfAjSWreBk56+iDPW1c8Dth520uNoqAnTtQCTo0yeo/7prVNGAToepDihnRDNP6nRwvmVuYtUImAtcJM38Zv20ru04EG7DtAYWytZqNQUHLcy/4l98KKvjr08M6WZ80Q05MJtbSHXM4OmYW7ZAA1pVMF0SSfLhQztkVE5RMH7lr6DpFLJ1ecWrMzY4Fh2XTbL+SkURfC+bb/M0dsmTjE8GKCh9E2HIR3D8xLo2Jg4zwsZ2vdLp3eRjl+Sf0pztnCal4uWaBjhGlKpZLo4Xf1w4d5F5J3MpIq3IxJoPCOlcY7E297RQc/AK76FqiwbhA9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWTLJZZBbQqqnZzDXsRxkOiE1vNpy2MQVK/Ibc5BaRE=;
 b=XxxNgH3c2V8gI30cMGT2y/mSL7EZ5mIsqMHN4kPrK0MmvAXGqhbxEva64+381YN0ICpzokVCycLjSHpocKJ+TVFyd4qWKLRSUEcYyUo7dLibs9zqXl4jFKK2vEqFKGboaObJ1BCEOdyL/fPqbrgDGAJP81dHxacgbRgq11ao9DI=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CY5PR12MB6299.namprd12.prod.outlook.com (2603:10b6:930:20::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.19; Tue, 26 May 2026 08:25:24 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 08:25:24 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: improve the userq seq BO free bit lookup
Thread-Topic: [PATCH] drm/amdgpu: improve the userq seq BO free bit lookup
Thread-Index: AQHc7LuRhPhRSnESN0ihmW5u1Btx1LYf9ecAgAACy5A=
Date: Tue, 26 May 2026 08:25:24 +0000
Message-ID: <DS7PR12MB6005B5B40553ABAC2AF2DCA7FB0B2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260526025830.50987-1-Prike.Liang@amd.com>
 <e8bde6cc-2866-4cf1-a998-4ec6f98f1ac3@amd.com>
In-Reply-To: <e8bde6cc-2866-4cf1-a998-4ec6f98f1ac3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-05-26T08:24:40.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CY5PR12MB6299:EE_
x-ms-office365-filtering-correlation-id: 3589bdb1-c683-4a4a-c5ab-08debb00558c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|4143699003|11063799006|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: XevYP9MXEzoxhQ82Vdn5jRcyk9PNyTwgV1f53ygNf4BClimivOsUhr8CHEXfJSNXYpyEHzO4t9W371pzDUyb2jzlhWhFpreDjRofylawq1qVxq4ZlbITi6ll1Bp/xM/a4Q5XvduiBsteZ1i8z4JVHrbp3YvkamAQFeiZFbco/qhPbXbowQZPi++DCBkM98Ah6czk0AynuJ+SsFX1igGh1y8cTYumXxr7xKq+Vtn/2OAuNJxJnStaQ717Ox7GVEIrj00aTGYqMQIalS+CSiMNQYTAKksUp/Qwf4a8Qo1BYobCEll+92d1ugmAo6tXcHJ2h7ssdbhrha74WGxvTMBhX/qduA++DjsZC1vdJwRh6aWgefib7MzPMQ3T/Zut5FncO2g6xOjgyArUF5Y2nTE2HF3IgQLc2QJxYMl6Td4FSZpmhirtcYsDdAoaLfLNFqtWd/mcd76ndYcShKvbElouW1UNzM2pfkX4sG6zihweaD+msw0HOJuNdcig3f4uGFoWd/CA5QNGGTc0OGcvbrCtUzpb01kQ2pAyiVbqvtpsCbOhUy4HJ04k1+q7GrLk0//eQcAPTHTMxB7pe7aXu2Eb97KP6FCBshm/+Lyb0Evd6Q4J/jzO1AD9tTGSxzPnrqP6iz1LoMOY5aaCJA1nSkVhoU92Y05Oga0dGFht+M5E3HFp3LbG1pjl05QewDOfUs2PzTSuc5XJyEBD69e6idSZN1yNg4scioBAWBJyBRiwDomMDlYsGiVgIy6A87KSKNnF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(11063799006)(22082099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkRaRGpiajRITjBTNzR4Vm41TEVtRFI3MHJ1TmtmQVo3Mmh4YlVUdTVtZXRV?=
 =?utf-8?B?cGt3NG50ditZdGZZMUVBRk5XMHRSRnZ0em9TN0ljR0ZZTWxDVkFnRFloSk00?=
 =?utf-8?B?Uk8rTk1CRnUwaExTZlR5eUgxdkx0VTltZTRyMytmRlpnaWl3RDN4S3Z3citS?=
 =?utf-8?B?Uk94TEJtTGR0bXhkOCtpK3puYnAwRCthSW9PampCM3pvQjR1ZE95Qk5jS3F1?=
 =?utf-8?B?bXduY3BoQldYVXk3eHJPMWt1Z3F2MmIraTM0VTVEdzZxcmVJVm9OaFFNQUV4?=
 =?utf-8?B?UDRWTEJ0S29qMUpHbWYxd0pxSWRZeEkvL2orZEJlbC9weWNFRmp6Qis1UWt3?=
 =?utf-8?B?aVNDQWZIRFgwNEsvYVU3OCtSdjFWREtwUFI3QTdFTzlEbXVKL1VjVzgyRERy?=
 =?utf-8?B?K3U5Qm9Nb3pDWG5lR29qNHVRQVR3NXprQmQyTE1PQzdHZlJSajZ5bktRd1V6?=
 =?utf-8?B?aFNjQUtJbEZONkFkTDd4N2pzV0xFQnI3RXBWdllLOGZKSXZ6bXcvSElLZUY0?=
 =?utf-8?B?QjFpRmxwTHpwaVF1K2d4UlpjSThGSVFlWDcxNmZHVlFoMWxza1NqdUNEb3Jn?=
 =?utf-8?B?a2FFMjhsRkF2T2g2a0xHK1RaOWZqWk1ldDBCeWV6anArcjU3SEVqNEVlNXlu?=
 =?utf-8?B?aThpU2JpY2Z6WitUQWxKZTlkT2JNckRGeWFUNTBBSHd6L2szVUVMS3FGYTc3?=
 =?utf-8?B?YUpKZkxzclZyYjJOdmhyNWx0TmF4VEtXTWxHS2EySDJKU2piaFA2WG5JdGkv?=
 =?utf-8?B?UlBMTW5TYlVSV0tnK2JVV0srQ0lkZWZYU3dISmhCalF2R2dMTHBHeVU4VFgx?=
 =?utf-8?B?cHE3WUlhTkIrR3QvUjdSWUhzeGdSRHBhWnppUmp1Y1dYdVlyTGRpNnF4dXY0?=
 =?utf-8?B?citIaVpOREgzKzFrUFkxaWJ6U0NzUHVzdGdWdUFUOGZBTGdscEJLNW1vd0gx?=
 =?utf-8?B?TlJsalB6T1RRNTZTTzBWK3M1dnkyZHFmVzJzRFNvM0dxVEllU0hpdUo3TVV0?=
 =?utf-8?B?Z2EzNFY1UmUzSG1tQnZpWFQ5OGF4Q0RZaEZFcEZIc3JKbi92UTFXb3RyQlF3?=
 =?utf-8?B?cHk0THc5RndTMEFIZjNYYzkwbjVnSTVuaSs2OEdyV2ltTXBnT0pHTURqc0Y3?=
 =?utf-8?B?cFBxZ2hjaytxQWdXSnpaQWRUeVJwbkpLVjV3dnBMOFJOMTlYbTRXVGpEdjZD?=
 =?utf-8?B?aTNHNi80ajNkVlJlWnpYaWpaMnBQTVVlK0dDS0EwOWNXQVltV1NwSkxFMkJY?=
 =?utf-8?B?OFhnNzBFMk1SWEVZTzl2VjNiSDFGaGVpVGpKSUJQV09wbmtyWVlHL05Ta1Za?=
 =?utf-8?B?U1c5S1lHYmYwelhCdXNRQWtQSXI2T1c2U0g4M01SZUs0aTN5eDlsNjhjM1R3?=
 =?utf-8?B?V0QrRVdNaWxTMmd6RWJGYnU0bTJzQ0lZRERUazRVb0cwNUNGWTNkYkVDZzdk?=
 =?utf-8?B?NEdQaFdYRkV5Ri9iNFhiSURRdWgyM1lQMzdjTGlYTkg3U09UUVFCb0pXUXkw?=
 =?utf-8?B?QlNDeVZ1TjNibFlzN3B0aEFhOHo2Ym41b1lnaXVXLzNyMHJseEIzRWQwQ2or?=
 =?utf-8?B?UWMzdnA2bTREMW96dmJhK1pQbC9WblNDbGJiajBBZURQRmJlVG9YWERrOFJx?=
 =?utf-8?B?Z3lXeUloeWF5RnNFTTlGMExtbW5QdUVoSUVqc05EM3hZN0VGcUVmMGVsYTd4?=
 =?utf-8?B?bnplUUtxK2JXSVkyajAzVWhpaERYNE04VVRNSzJNNmJsdmdmT2xvemlja2N5?=
 =?utf-8?B?aWpnUnlySVdLSklZdHpmMWVMMnNyeGZSZCtyeStacVFyVDArMkN3U3MzamFX?=
 =?utf-8?B?VEZNblFmVHVIT1E3YkFFc3B5Q2FWeUtuMklFOEdHdEk0cm9VMGFPaXI4REcr?=
 =?utf-8?B?ZGthNVZ3QmVYZVJFK3NoRjNsOEdpWGVmZHorcGt6Z202MHJzbE1JRW5pTTVD?=
 =?utf-8?B?T3ovVHMxeDJmVXBIQVFqMENaSkdQMHdxYTBSMXM1QWl3TExoZzE2S1FxMUQy?=
 =?utf-8?B?cFRNSzhEeVBvaERadlhLVDVkVzFlSGNqaFdra2JRN1ZPRG1lOHMvbzdrZlpC?=
 =?utf-8?B?Ly82TkM5bEhsQVpETnhPZndWTkhvdHJtQmJOTzlHNnh6V2ZSeFQ4VHhXdU1s?=
 =?utf-8?B?V2hmV0NwQ3duVy9zUEliRjd3RDdOcytDV20rclBDbjlyUVR1YlVRWW4yVzdy?=
 =?utf-8?B?VFBSTWtRS2JzMXN0TGFFcGVwcVh4eGZqamVpUXkrV2dVaEtGVGh1SU5tdzRI?=
 =?utf-8?B?UkEwRDBQa3lqOXM1bnZoVzdrc2lyd0o0MTlUS01qZG4yRlY1WldKWnpuSlk2?=
 =?utf-8?Q?jOrYYBMw/Z9q72asW3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3589bdb1-c683-4a4a-c5ab-08debb00558c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 08:25:24.2273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +4nlMzt7xUlz5W2DwS2KaKe+OC6QmRL87iVeRTPvEW7HZNSnbU0JT9+43r98Grni
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6299
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

UHVibGljDQoNClJlZ2FyZHMsDQogICAgICBQcmlrZQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5j
b20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAyNiwgMjAyNiA0OjE1IFBNDQo+IFRvOiBMaWFuZywg
UHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBpbXByb3ZlIHRoZSB1c2VycSBzZXEg
Qk8gZnJlZSBiaXQgbG9va3VwDQo+DQo+DQo+DQo+IE9uIDUvMjYvMjYgMDQ6NTgsIFByaWtlIExp
YW5nIHdyb3RlOg0KPiA+IFVzZSBmaW5kX25leHRfemVyb19iaXQoKSB0byBsb2NhdGUgdGhlIG5l
eHQgZnJlZSBzZXEgc2xvdCBiaXQgaW5zdGVhZA0KPiA+IG9mIHRoZSBjdXJyZW50IHdhbGssIGZv
ciBtb3JlIGVmZmljaWVudCBiaXRtYXAgc2Nhbm5pbmcuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3NlcTY0LmMgfCA5ICsrKysrLS0tLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zZXE2NC5jDQo+
ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc2VxNjQuYw0KPiA+IGluZGV4
IGY0YmUxOTIyMzU4OC4uNjM3NzFkNmQ0NjZlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zZXE2NC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3NlcTY0LmMNCj4gPiBAQCAtMTc1LDE0ICsxNzUsMTUgQEAgaW50
IGFtZGdwdV9zZXE2NF9hbGxvYyhzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiA+ICphZGV2LCB1NjQg
KnZhLCAgew0KPiA+ICAgICB1bnNpZ25lZCBsb25nIGJpdF9wb3M7DQo+ID4NCj4gPiAtICAgZm9y
ICg7Oykgew0KPiA+IC0gICAgICAgICAgIGJpdF9wb3MgPSBmaW5kX2ZpcnN0X3plcm9fYml0KGFk
ZXYtPnNlcTY0LnVzZWQsIGFkZXYtDQo+ID5zZXE2NC5udW1fc2VtKTsNCj4gPiArICAgZG8gew0K
PiA+ICsgICAgICAgICAgIGJpdF9wb3MgPSBmaW5kX25leHRfemVyb19iaXQoYWRldi0+c2VxNjQu
dXNlZCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT5zZXE2NC5u
dW1fc2VtLCBiaXRfcG9zKTsNCj4NCj4gYml0X3BvcyBpcyB1bmluaXRpYWxpemVkIGZvciB0aGUg
Zmlyc3QgbG9vayBoZXJlLg0KDQpUaGFua3MsIHdpbGwgZml4IGl0IGluIHRoZSB2MiB2ZXJzaW9u
Lg0KPg0KPiA+ICAgICAgICAgICAgIGlmIChiaXRfcG9zID49IGFkZXYtPnNlcTY0Lm51bV9zZW0p
DQo+ID4gICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT1NQQzsNCj4gPiAtDQo+ID4gICAg
ICAgICAgICAgaWYgKCF0ZXN0X2FuZF9zZXRfYml0KGJpdF9wb3MsIGFkZXYtPnNlcTY0LnVzZWQp
KQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gLSAgIH0NCj4gPiArICAgICAg
ICAgICBiaXRfcG9zKys7DQo+ID4gKyAgIH0gd2hpbGUgKDEpOw0KPiA+DQo+ID4gICAgICp2YSA9
IGJpdF9wb3MgKiBzaXplb2YodTY0KSArIGFtZGdwdV9zZXE2NF9nZXRfdmFfYmFzZShhZGV2KTsN
Cj4gPg0KDQo=
