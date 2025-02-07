Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3BAC0219C
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 15:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E4410EB51;
	Fri,  7 Feb 2025 15:31:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4bbmi0ZN";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9A0389916
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 15:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHSU8BFYApl2W/5aBYTTSUK163jSxeivsLqItNg5Sd/im91/Hjur6al0WCMBscjMUxwOoep2oSIrNXmUFme8vNICTzP8HIYBcY2UVXFYcuXUfpdS9UJRS5YKTSUxlGUH862ruQ1oGUPWJ5PraetWK3reeiXXbsfn7w6IXNg6SoWWI77yFORFgS7GtCP70GIWQ3QkPEII8pAw1NiOuICR9yfG+zOWxEk8k88h786GgD9kWUJiKnMaeB4EdShgWCH0LPYQmXKEZ+rsxwUPpPgK5xO13OKWwqNcnT3kuVmt/nlKxfygiQP+7t8HaVyd75r9vJ0FBJcWXvqZ+7DbKtRBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BD3Tqsjo0vUNa+ku55wnDwMMjLu3shCHnMjEqW5at0c=;
 b=QtOkLTT2Nn24/wC5aBXzzoDaoBFgs0XU1Yizxv18VuvnhpEFCpHQFbDPdsx2N9gT8cJ17uiWMBpg1bu0hZoUhBy9F0sjMT8Y7q7Rusc6jmh8DZ4WSSvJfX3FeJ0RI23pY6sw5C1EmEQIljMeLKPUe3wR1aYQ+8tQkNAfDp8QyfYK7WLBgzgKV+ws/OjDTJ/iWYYUzrGDuL6WaUOBABhVO3g7SJxQwhY05VqwCvPKS2jq2pivhm/tYsi/b1q63041lWBceHEpeApotWa6lVBWPz/BECIJtJSgKCNAs2PQznnUWCZLshBQkELm0aBvUXvx/IRLrlq+tykJFZpVx/vDlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BD3Tqsjo0vUNa+ku55wnDwMMjLu3shCHnMjEqW5at0c=;
 b=4bbmi0ZNJ8UL+dGkkvBSmdAr2RrlEeZhT8wasEtV6VO9kdzfhdIqQV80BAg6ctbh0ww9k579Xwvhq6TRsEGaeOPTVfnhZDVysaQI/KNQOHgxOgZq1FH0gHK29Qut4258uYzKebZ91vcRwkm+PHmiPzYJF65855/S0oWGnopm0DM=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by IA1PR12MB6331.namprd12.prod.outlook.com (2603:10b6:208:3e3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 15:23:18 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%4]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 15:23:18 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "cao, lin"
 <lin.cao@amd.com>, "Chen, JingWen (Wayne)" <JingWen.Chen2@amd.com>
Subject: RE: [PATCH V3 2/2] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX11
Thread-Topic: [PATCH V3 2/2] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX11
Thread-Index: AQHbeW7AioWoZ4+tQEybbqq9QVTonLM77HYAgAAGYPA=
Date: Fri, 7 Feb 2025 15:23:17 +0000
Message-ID: <CH0PR12MB5372CCCCF05135BECA30904FF4F12@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250207144352.920100-1-alexander.deucher@amd.com>
 <20250207144352.920100-2-alexander.deucher@amd.com>
 <2ca96297-db0f-4683-a46f-9621ea4bd60c@amd.com>
In-Reply-To: <2ca96297-db0f-4683-a46f-9621ea4bd60c@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c375030d-7369-464a-a602-1b9ba9417644;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-07T15:13:32Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|IA1PR12MB6331:EE_
x-ms-office365-filtering-correlation-id: 8a2bb8d9-25c7-40d8-30fb-08dd478b5927
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?R3I1c3Y1cWsvVmhtZFR1ektJNW1Vazd3UDMyTFlKYkF4ZjA0OGJOdEE5VTEr?=
 =?utf-8?B?cEFDWkVHZFZoQUlQNTI1WDhyd1BGeCtXK3dIb2hFanJWbkZJYkttc2FhY2t6?=
 =?utf-8?B?TzMvMDAvNjZvYSttL2Y0TWVNMkZrSFN1Y0hBK1Z2WVJvYVJPdXhudkJSNXc1?=
 =?utf-8?B?QXpHVUNOTWVjUUhWKzdGejMxaGJNUGhGNFBlNEtRcW1JODRJeXFBLzBaNGF5?=
 =?utf-8?B?d0FjRS8xVkh1UktZbHIxSFRUU0FCcGJwTTA0WTYvbkNCS25UUjJaejV3S1RT?=
 =?utf-8?B?UE9hRmpzS2ZWbWpobVlmVXM3RW96bFowZEo4VmdsZHFkaUR2UzhOUnhyWHR3?=
 =?utf-8?B?NzZNMVlpK0RURmhJSGZZUWF2TldLa2hRTHJVa2M0V25GMmJuZGwzY2FsY05N?=
 =?utf-8?B?RTBSWUo1Rk1rOEZYK3c4NG1KV09LVkQvblR4N01NUGY5T3h1RldrSzR3clE3?=
 =?utf-8?B?Mnd0ZCtsS0RNUTVoZDFXRC8vM0JCMEJOMnRhN0QvUW5CNHFOMXViV1lvNVUv?=
 =?utf-8?B?bm84ZnlzV0FXMkt0amphMS9qOVhDd3dnTUVDUDhOZ0RTbUxDTjdlMTZOUjZi?=
 =?utf-8?B?ZzFWdWhYRjZmYjZ4RnN1YXlMTmUrTXVJWHVIUHRPcnFmVVZ0UGJxVDlMeHBO?=
 =?utf-8?B?am5FMzd6anRlL3h5U0xGRm5WbVJOeXJxcGtFMWNQampXMm4vNDdLV3ZFVW1s?=
 =?utf-8?B?M2VaTm1kYVd0WTVvQ3BHRkt4SGJJRytFNW1VV0gvUFN1bzJBeHlIclJMQ1Yv?=
 =?utf-8?B?L3lIeGZTNGxpVkFzclRESC91RkY3UFJwZnlwb3RvWnRkNzVGdk5HQVZZTENB?=
 =?utf-8?B?clZ6MTEvVU9QTWRHNndhQ0JEeTN0cWVxVWFiN3FuYktveWVYMTV6Z05nV2xW?=
 =?utf-8?B?bUdTMUdNWXlQTkRzNlFiLzR1cTA0SmRJSHg0RTd4eTNDRE91U2pVVTdLbGhH?=
 =?utf-8?B?aTlsdHErOVdKa0F5d2w3c2djalBsU2oyTjNhamcrSGc2eTlETUFINEJDU0Np?=
 =?utf-8?B?MU9NVUlVZFdQYVlER0FNaHY4T3J4WnlpNXJhZW4wUEd1VDNja1Q3T0lRYXBV?=
 =?utf-8?B?d3pEL1BNcFVrZC9ZKy81OTRGTGF2QlJoVXFFVURQNm1ZdXZwQVUrOWtJN3BH?=
 =?utf-8?B?U1I3STJha3lFTGtFVjEzS3Bwc2ZZeDNaaWVMYk52c1pTNE1kRW53NTVJVnFq?=
 =?utf-8?B?K01xK1ZmbWNBbFpQbmMvdlZrOG10c3NYc2ZOZDIydFVPRlpwNER3RVRMWGs0?=
 =?utf-8?B?azU3em1tMUVsWDVtcHBlUGxTeVZEV2djTWl0Y2tqRHI0Y1Q0Q2dTUXVxNDlo?=
 =?utf-8?B?a3hWQWs4RGtlK1dQK0dXSjhkZmZIYjdFNXY0bWtXTXRUeDMxK2hzTHc4OGUx?=
 =?utf-8?B?ajdsL3JnVWV2alVLUXpteWx5d3JIME1uQlA4NWxQekh2c3ozaVRrcEJLU2M5?=
 =?utf-8?B?OGZnaDhtTWhONHlnY1NHUXNsVm1NaHpzTjgxcUZaNEJOUlR0VGV1TXpwSllJ?=
 =?utf-8?B?N1VOY1NQZFdocUpmMEF5bWxZM1lxcnkzSVZwSjY5emJEWExqU0tEUTV3RHpI?=
 =?utf-8?B?WFZtcHlZbmdqbG9VTG0xZllIME9CQ3hWVHlBeEkwcmtaczVKeC8yeGltYUx3?=
 =?utf-8?B?NFovM0p2cG5sd2NidnZmUzI3YlJwMjVVVWNVV0VoY0d1OGdGUzM2U1dPTDhm?=
 =?utf-8?B?OG5OSXl3VEFzeHRSdWhycjhyc0YvQk9JTnA3eXFkSUMvcnVyU1g5UUw3R3pV?=
 =?utf-8?B?YjBNbW42QVZNQk9aMkhkQjZ6OXp2Vy9tNWUxUU5pS2Y5REkzeTBYVjN3bkFl?=
 =?utf-8?B?YWQwY0FZbFhxNmk4RGJLMXJsS25PMk9FK0dweXc0cGkvbUJKb3VmV2hIOG1D?=
 =?utf-8?B?NlgyRC82ZmFadFljRDNSMWx2MGNRRW1wVkhhSjNxM2ZlZ1d3cE1XbGkyeWtq?=
 =?utf-8?Q?A+O+3yfEOeMVbdn40hREu8M+wcPbQAjn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTZRNlJXeG9hYTZubnlqcVBjVSs5OXg1K2ZTQkxtdTNZR1VKN2tLNzlOQzRV?=
 =?utf-8?B?eTcwYmk5YzQrYlhDQWd2UHkrYVFZc0NXRE1NL0VNNUdNZW9aajBacGRjY1Ix?=
 =?utf-8?B?MnU5RWNPckNlTnI1SFhCMEYvL2ZHYVlWNXdZL3hLaHoyWkg0QTY3TklGbkhz?=
 =?utf-8?B?bmJhUzRQSndhLzcxMkt0L2xWbmVSME4rT0w1WGgrZUdIQ2U5aDRtWUJOZXRI?=
 =?utf-8?B?OWRwWW1NMHNJN1BYdTFIckNSZ2l6WW1pMHNwUnNEL0M3aERGZHA4eVNIbCtX?=
 =?utf-8?B?OWRkeWNQY2ZodDV3U1JFVXcyL0luNnlEZEhCWGIxZDZmb2o2MHRCamoxS2tN?=
 =?utf-8?B?ekhmTXNZeVpaU3h0RWpsWXpVVG8xVStNY1NtNDJSTk5nc1c5MnFuMVNSOWY1?=
 =?utf-8?B?RjUyblBqalRKcE8ycXk2dXRJK04rMkhVTDBvc1ZEbzNHY2hVNG40dkc3WU9j?=
 =?utf-8?B?Z3J5MVdONlowVlBGV1loNzk5SERYZ1k1bzVHeVEzenlCazhYZHJJeGJxZWE2?=
 =?utf-8?B?anc5Yy95STE3d21PSVZXeENQTjBKcXVHelpGUFhWRm5hWlV3c0VkVmhMVlJG?=
 =?utf-8?B?SjFMN1BaREc1QnhMUTYxMlFkN0hudHhXMCsrcjB5bDAyMmJMMzA0U2lSNWVC?=
 =?utf-8?B?bFcwaUJ5K25xa3NXam9CbVhMZGs5eTJRdGF3YlZNQ3RjSzhWczlkaGpzZHFI?=
 =?utf-8?B?czRyUDc2ejRIVjJ2aFFJOEV6YTNkSUVHQkgxdkxBRUlaOW1KMDFOZ0lzWmtq?=
 =?utf-8?B?dlRxRlVaNXJoa1FXUlFjSGduUUZHYzZuaUZSQWN4a29qeVV6ZHRuQlNJZmI5?=
 =?utf-8?B?aFFTUkIxejlHSWdpVlE0ZE8xUkhuZ25uUFNUVHIyckxWbWJHQTRQYjhKOU9z?=
 =?utf-8?B?WS9oQXIvaWlld2s5ZGhBK0twQ2VzWUVkNm5Fd2lmZGRRb2VocGZnL0VHcW1l?=
 =?utf-8?B?MzlUTHBpV1ByZkpndE91cVRPUVpYeHJzV0h2RU5lSVFpb3YrelozT0ZNUWV6?=
 =?utf-8?B?QStvdEk2a0ZwYmkrOVlWTEgwSUxaMHF1QmI2NXJIZEV1TTV1SVFoQ2wzU0dO?=
 =?utf-8?B?YUdsRE9ncFFEekV3dVNrOTI3bStVeGJmdjNNK2pyb1BWa2wySndEV3UvZVZC?=
 =?utf-8?B?dURLNmljTGxmV3RiQnpkZFh3YUFpVDh2MkZhbzhFUzU2M0NkUzdPbEFnWnBB?=
 =?utf-8?B?U21iTjFlTTB0Uzg3UFE4MVpYYW9uODFTakp2TXcyTksxeFVXTXJWZWVhcVpC?=
 =?utf-8?B?TFNYTWhCckJma0lXTXN3NEczR01CY0NPQklqNkorNXZDMDB1V3lGME9jVmJl?=
 =?utf-8?B?MDJ0ZXBFMFBML0NHeVN5Mk96cEhLQkxLSDhyWkozTDU4SCtER1dtYTljbW1z?=
 =?utf-8?B?MU80dHRlUFVIWEoxM213Z1I2UG9vOGFFYVN5TFhoejJvdU4rMjdIa0U4L2Nl?=
 =?utf-8?B?SVBzSWxCWXRVdFIwdDI5NU9GbGJ3SDk4UHlkWHhYOTBDRE1FNW1XdEpGTUhB?=
 =?utf-8?B?czNaK0xGYU9PdUZRRkkvK2ZLSkI1RDJxMklaTDQ4cVVIcW05OWk4dGtPRFY3?=
 =?utf-8?B?aG9iZDc5OGZWenVoVXRNQWhXTVNXa1NaSG9tbFhaT2Z1ejJpR00rRWh3enlB?=
 =?utf-8?B?T21GQm1VZ0dFY3lFWUE5NDBQSWRGQjRiZ0h2ZEswOU5uNm90T0dtV3ZzMnBK?=
 =?utf-8?B?ZlpITHFTS29POHBEY2syNDVDa1NjVWlzTkxTUytPZUppQ3NUVDN4TGxjVDN1?=
 =?utf-8?B?SmRWZTJTL01vNTRzMnowSFoxTnp0YnpMUXI1bHlDc3NSTVM5WW5BcER1NGVo?=
 =?utf-8?B?bDZFSysrYk15TXkwdkxJNDl5RWs1bWpuTlRIVjV1cHhPV0QrYXlNeEpxY3dV?=
 =?utf-8?B?TDkxK0xVSHZ4N2JsbjNxRi9MQ2d6UEcySGlNU0ZXQllEZDRVbS9ER3JWYlRi?=
 =?utf-8?B?Q1NyNlFPZXBsRlVzcUU3THVQV0JReVJ5MTAvNUVEM08vcjFiWFkwbHRhRDR5?=
 =?utf-8?B?b3ZWc1o2Q1lSRjJ0ZnpkSEJFNk5yTlVnMGw0aS8zMit1VkwxNjRURHVTMnpR?=
 =?utf-8?B?OStrclpleE05WkVwVDFiNThyNUFGNmVvYUN1T0Y3ckc2WXJvOXhvWE4zWm0z?=
 =?utf-8?Q?UMcA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2bb8d9-25c7-40d8-30fb-08dd478b5927
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 15:23:17.7633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhhZfyzx1ysDosbmOv0+RT4Skimv98Qrci/xnIgcpFQeNktqb0CTK1DRX0HvXNMjZCdjL8FyY3fYzw+qbefjBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6331
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
Cg0KSSdtIG5vdCBzdXJlIHdoeSB0aGVyZSBpcyBubyBtZXMucmVzb3VyY2VfMV9ncHVfYWRkciAg
Zm9yIG1lcyB2MTIgLCBwcm9iYWJseSBzcmlvdiB0ZWFtIHN0aWxsIG5vdCBzdXBwb3J0IGl0IC4g
QnV0IHdlIGRvIG5lZWQgdGhpcyBjbGVhbmVyX2ZlbmNlX2dwdV9hZGRyIGZvciBib3RoIG1lcyB2
MTEgYW5kICB2MTIgLiAgV2hhdCBNRVMgbmVlZCBpcyBhIEdQVSBhZGRyIGl0IGNhbiB1cGRhdGUg
YSAzMiBiaXQgdmFsdWUgb24gaXQgLGFuIGV4dHJhIHBhZ2UgZG8gc2VlbXMgYSBvdmVya2lsbCBm
b3IgdGhpcy4gIEkgc3RpbGwgdGhpbmsgYWxsY29hdGUgYSBXQiBpbiBhbWRncHVfbWVzX2luaXQg
YW5kIGZyZWUgaXQgaW4gYW1kZ3B1X21lc19maW5pIGlzIGEgYmV0dGVyIHNvbHV0aW9uIGFuZCAg
aXQgY2FuICBiZSAgZ2VuZXJpYyBmb3IgdjExIGFuZCB2MTIgLiAgVGhlIG9yaWdpbmFsIGRlc2ln
biBpcyBmb3Igd2luZG93cyAsIGFuZCAgSSB0aGluayB0aGV5IG5lZWQgdG8gc3luYyBiZXR3ZWVu
IHRoZWlyIEtNRCBkcml2ZXIgYW5kICBGVyBmb3IgdGhlIGNsZWFuZXIgc2hhZGVyIHN1Ym1pc3Np
b24sIHNvIHRoZSBLTUQgbmVlZCB0byBiZSBhYmxlIHRvIGNoZWNrIHRoZSBmZW5jZSAuDQoNClJl
Z2FyZHMNClNoYW95dW4ubGl1DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBL
b2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KU2VudDogRnJpZGF5
LCBGZWJydWFyeSA3LCAyMDI1IDk6NTEgQU0NClRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6
IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IGNh
bywgbGluIDxsaW4uY2FvQGFtZC5jb20+OyBDaGVuLCBKaW5nV2VuIChXYXluZSkgPEppbmdXZW4u
Q2hlbjJAYW1kLmNvbT47IExpdSwgU2hhb3l1biA8U2hhb3l1bi5MaXVAYW1kLmNvbT4NClN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggVjMgMi8yXSBkcm0vYW1kZ3B1L21lczogQWRkIGNsZWFuZXIgc2hhZGVy
IGZlbmNlIGFkZHJlc3MgaGFuZGxpbmcgaW4gTUVTIGZvciBHRlgxMQ0KDQpBbSAwNy4wMi4yNSB1
bSAxNTo0MyBzY2hyaWViIEFsZXggRGV1Y2hlcjoNCj4gRnJvbTogU3Jpbml2YXNhbiBTaGFubXVn
YW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+DQo+IFRoaXMgY29tbWl0IGludHJv
ZHVjZXMgZW5oYW5jZW1lbnRzIHRvIHRoZSBoYW5kbGluZyBvZiB0aGUgY2xlYW5lcg0KPiBzaGFk
ZXIgZmVuY2UgaW4gdGhlIEFNREdQVSBNRVMgZHJpdmVyOg0KPg0KPiAtIFRoZSBNRVMgKE1pY3Jv
Y29kZSBFeGVjdXRpb24gU2NoZWR1bGVyKSBub3cgc2VuZHMgYSBQTTQgcGFja2V0IHRvIHRoZQ0K
PiAgICBLSVEgKEtlcm5lbCBJbnRlcmZhY2UgUXVldWUpIHRvIHJlcXVlc3QgdGhlIGNsZWFuZXIg
c2hhZGVyLCBlbnN1cmluZw0KPiAgICB0aGF0IHJlcXVlc3RzIGFyZSBoYW5kbGVkIGluIGEgY29u
dHJvbGxlZCBtYW5uZXIgYW5kIGF2b2lkaW5nIHRoZQ0KPiAgICByYWNlIGNvbmRpdGlvbnMuDQo+
IC0gVGhlIENQIChDb21wdXRlIFByb2Nlc3NvcikgZmlybXdhcmUgaGFzIGJlZW4gdXBkYXRlZCB0
byB1c2UgYSBwcml2YXRlDQo+ICAgIGJ1cyBmb3IgYWNjZXNzaW5nIHNwZWNpZmljIHJlZ2lzdGVy
cywgYXZvaWRpbmcgdW5uZWNlc3Nhcnkgb3BlcmF0aW9ucw0KPiAgICB0aGF0IGNvdWxkIGxlYWQg
dG8gaXNzdWVzIGluIFZGIChWaXJ0dWFsIEZ1bmN0aW9uKSBtb2RlLg0KPiAtIFRoZSBjbGVhbmVy
IHNoYWRlciBmZW5jZSBtZW1vcnkgYWRkcmVzcyBpcyBub3cgc2V0IGNvcnJlY3RseSBpbiB0aGUN
Cj4gICAgYG1lc19zZXRfaHdfcmVzX3BrdGAgc3RydWN0dXJlLCBhbGxvd2luZyBmb3IgcHJvcGVy
IHN5bmNocm9uaXphdGlvbiBvZg0KPiAgICB0aGUgY2xlYW5lciBzaGFkZXIgZXhlY3V0aW9uLiBU
aGlzIGlzIGRvbmUgYnkgY2FsY3VsYXRpbmcgdGhlIGFkZHJlc3MNCj4gICAgdXNpbmcgdGhlIHdy
aXRlLWJhY2sgbWVtb3J5IGJhc2UgYWRkcmVzcyBhbmQgdGhlIGNsZWFuZXIgZmVuY2Ugb2Zmc2V0
Lg0KPg0KPiBDYzogbGluIGNhbyA8bGluLmNhb0BhbWQuY29tPg0KPiBDYzogSmluZ3dlbiBDaGVu
IDxKaW5nd2VuLkNoZW4yQGFtZC5jb20+DQo+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+DQo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+DQo+IFN1Z2dlc3RlZC1ieTogU2hhb3l1biBMaXUgPHNoYW95dW4ubGl1QGFtZC5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzYW4gU2hhbm11Z2FtIDxzcmluaXZhc2FuLnNo
YW5tdWdhbUBhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+DQoNClllYWggdGhhdCBtYWtlcyBtdWNoIG1vcmUgc2Vuc2UuDQoN
CkknbSByZWFsbHkgd29uZGVyaW5nIHdoeSB0aGUgTUVTIGhhc24ndCBhbGxvY2F0ZWQgdGhhdCBp
biBpdCdzIG93biBtZW1vcnkgaW4gdGhlIGZpcnN0IHBsYWNlPw0KDQpEb2VzIHRoZSBNRVMgZXhw
ZWN0IHRoZSBrZXJuZWwgZHJpdmVyIHRvIHdhaXQgZm9yIHRoYXQgZmVuY2UgdmFsdWU/DQoNCkFu
eXdheSBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPiBmb3Igbm93Lg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+IC0tLQ0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTFfMC5jIHwgMjQgKysrKysrKysrKysrLS0tLS0t
LS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9u
cygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3Yx
MV8wLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjExXzAuYw0KPiBpbmRl
eCBlODYyYTNmZWJlMmIyLi5lMjJkMGVlNmQ4YTNhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9tZXNfdjExXzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9tZXNfdjExXzAuYw0KPiBAQCAtNzU0LDcgKzc1NCw3IEBAIHN0YXRpYyBpbnQgbWVz
X3YxMV8wX3NldF9od19yZXNvdXJjZXNfMShzdHJ1Y3QgYW1kZ3B1X21lcyAqbWVzKQ0KPiAgICAg
ICBtZXNfc2V0X2h3X3Jlc19wa3QuaGVhZGVyLmR3c2l6ZSA9IEFQSV9GUkFNRV9TSVpFX0lOX0RX
T1JEUzsNCj4gICAgICAgbWVzX3NldF9od19yZXNfcGt0LmVuYWJsZV9tZXNfaW5mb19jdHggPSAx
Ow0KPg0KPiAtICAgICByZXQgPSBhbWRncHVfYm9fY3JlYXRlX2tlcm5lbChhZGV2LCBzaXplLCBQ
QUdFX1NJWkUsDQo+ICsgICAgIHJldCA9IGFtZGdwdV9ib19jcmVhdGVfa2VybmVsKGFkZXYsIHNp
emUgKyBBTURHUFVfR1BVX1BBR0VfU0laRSwNCj4gK1BBR0VfU0laRSwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgQU1ER1BVX0dFTV9ET01BSU5fVlJBTSwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgJm1lcy0+cmVzb3VyY2VfMSwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgJm1lcy0+cmVzb3VyY2VfMV9ncHVfYWRkciwNCj4gQEAgLTc2NSw3ICs3NjUs
MTAgQEAgc3RhdGljIGludCBtZXNfdjExXzBfc2V0X2h3X3Jlc291cmNlc18xKHN0cnVjdCBhbWRn
cHVfbWVzICptZXMpDQo+ICAgICAgIH0NCj4NCj4gICAgICAgbWVzX3NldF9od19yZXNfcGt0Lm1l
c19pbmZvX2N0eF9tY19hZGRyID0gbWVzLT5yZXNvdXJjZV8xX2dwdV9hZGRyOw0KPiAtICAgICBt
ZXNfc2V0X2h3X3Jlc19wa3QubWVzX2luZm9fY3R4X3NpemUgPSBtZXMtPnJlc291cmNlXzEtPnRi
by5iYXNlLnNpemU7DQo+ICsgICAgIG1lc19zZXRfaHdfcmVzX3BrdC5tZXNfaW5mb19jdHhfc2l6
ZSA9IHNpemU7DQo+ICsgICAgIG1lc19zZXRfaHdfcmVzX3BrdC5jbGVhbmVyX3NoYWRlcl9mZW5j
ZV9tY19hZGRyID0NCj4gKyAgICAgICAgICAgICBtZXMtPnJlc291cmNlXzFfZ3B1X2FkZHIgKyBz
aXplOw0KPiArDQo+ICAgICAgIHJldHVybiBtZXNfdjExXzBfc3VibWl0X3BrdF9hbmRfcG9sbF9j
b21wbGV0aW9uKG1lcywNCj4gICAgICAgICAgICAgICAgICAgICAgICZtZXNfc2V0X2h3X3Jlc19w
a3QsIHNpemVvZihtZXNfc2V0X2h3X3Jlc19wa3QpLA0KPiAgICAgICAgICAgICAgICAgICAgICAg
b2Zmc2V0b2YodW5pb24gTUVTQVBJX1NFVF9IV19SRVNPVVJDRVNfMSwgYXBpX3N0YXR1cykpOyBA
QA0KPiAtMTYzMiwxMiArMTYzNSwxMCBAQCBzdGF0aWMgaW50IG1lc192MTFfMF9od19pbml0KHN0
cnVjdCBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQ0KPiAgICAgICBpZiAocikNCj4gICAgICAg
ICAgICAgICBnb3RvIGZhaWx1cmU7DQo+DQo+IC0gICAgIGlmIChhbWRncHVfc3Jpb3ZfaXNfbWVz
X2luZm9fZW5hYmxlKGFkZXYpKSB7DQo+IC0gICAgICAgICAgICAgciA9IG1lc192MTFfMF9zZXRf
aHdfcmVzb3VyY2VzXzEoJmFkZXYtPm1lcyk7DQo+IC0gICAgICAgICAgICAgaWYgKHIpIHsNCj4g
LSAgICAgICAgICAgICAgICAgICAgIERSTV9FUlJPUigiZmFpbGVkIG1lc192MTFfMF9zZXRfaHdf
cmVzb3VyY2VzXzEsIHI9JWRcbiIsIHIpOw0KPiAtICAgICAgICAgICAgICAgICAgICAgZ290byBm
YWlsdXJlOw0KPiAtICAgICAgICAgICAgIH0NCj4gKyAgICAgciA9IG1lc192MTFfMF9zZXRfaHdf
cmVzb3VyY2VzXzEoJmFkZXYtPm1lcyk7DQo+ICsgICAgIGlmIChyKSB7DQo+ICsgICAgICAgICAg
ICAgRFJNX0VSUk9SKCJmYWlsZWQgbWVzX3YxMV8wX3NldF9od19yZXNvdXJjZXNfMSwgcj0lZFxu
Iiwgcik7DQo+ICsgICAgICAgICAgICAgZ290byBmYWlsdXJlOw0KPiAgICAgICB9DQo+DQo+ICAg
ICAgIHIgPSBtZXNfdjExXzBfcXVlcnlfc2NoZWRfc3RhdHVzKCZhZGV2LT5tZXMpOw0KPiBAQCAt
MTY2NSwxMCArMTY2Niw5IEBAIHN0YXRpYyBpbnQgbWVzX3YxMV8wX2h3X2luaXQoc3RydWN0IGFt
ZGdwdV9pcF9ibG9jayAqaXBfYmxvY2spDQo+ICAgc3RhdGljIGludCBtZXNfdjExXzBfaHdfZmlu
aShzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykNCj4gICB7DQo+ICAgICAgIHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2ID0gaXBfYmxvY2stPmFkZXY7DQo+IC0gICAgIGlmIChhbWRn
cHVfc3Jpb3ZfaXNfbWVzX2luZm9fZW5hYmxlKGFkZXYpKSB7DQo+IC0gICAgICAgICAgICAgYW1k
Z3B1X2JvX2ZyZWVfa2VybmVsKCZhZGV2LT5tZXMucmVzb3VyY2VfMSwgJmFkZXYtPm1lcy5yZXNv
dXJjZV8xX2dwdV9hZGRyLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICZhZGV2LT5tZXMucmVzb3VyY2VfMV9hZGRyKTsNCj4gLSAgICAgfQ0KPiArDQo+ICsgICAgIGFt
ZGdwdV9ib19mcmVlX2tlcm5lbCgmYWRldi0+bWVzLnJlc291cmNlXzEsICZhZGV2LT5tZXMucmVz
b3VyY2VfMV9ncHVfYWRkciwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICZhZGV2LT5t
ZXMucmVzb3VyY2VfMV9hZGRyKTsNCj4gICAgICAgcmV0dXJuIDA7DQo+ICAgfQ0KPg0KDQo=
