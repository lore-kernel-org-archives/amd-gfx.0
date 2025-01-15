Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D505C02183
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 09:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EA5C10E4EF;
	Wed, 15 Jan 2025 09:38:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rQsa3aqF";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 425D510E5AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 09:38:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRT3pkr1KwGjlH24zcsow1yAgEW53xNNBzBKNTGJhs885ZAYNSwReo0DJ9bOtmSNGCJY/bgud/una5ES5ymDzRJTcQ8Jd7wYWMRbrCnnT1J1TC9np4GtE0Hp8KVzU6Dc/dqriAsPw2aepKlbq5VOz4adJd9bzh4Y37+xkIFNDWyqdhYhkEXNdfwX+ShyZBjWMqbGDVUu0NMBww4b0M1+mWgN63/0qTR0rtCmTmR0fno+N3GDiPi/Vl7jbBQBDco0SJn4RCQcijCS6SoGWACnj12We8XYz1PktCQgN2nwseGPJzMyAEiig3kyYH66PPG8+DnQwdrtL+d66m381P1Q2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2rRr9ZvTI0+yk5tNdw90c9wgtvQlSGPF9BhtWQ0Fv8=;
 b=Lr40E0UQiK+P92MSw8MeQW9JrtwropOavMzFqJd0fpKvfMOTF38CdU+tUavNT6cDi8YuDPlaoqmPZCrVqx/zdokf+QOgrDWeSCNTSlseCc3Pem+F+dwTUSAGc5ONKNBn7Otk6C4SfYii3Z6sgVFgpNNiPaw7B8gEKaAuJn2Wy/JZz9XXWKtQbS0DbbxlzNYK6OGvAdiIuublym17+gLlzJWo2WSPIiX/sLLuTnlsqYCebjlzqKKc1MW4uupJ2UdKtGqHmk77qrWF5ZUBtR+LGDoaEcShuE5Ui9NcBjQaK07pU2J2Sqiauf9ZkdZq3zqlDD8UyuSQ+2kz54sBIIy3rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2rRr9ZvTI0+yk5tNdw90c9wgtvQlSGPF9BhtWQ0Fv8=;
 b=rQsa3aqF7UEze1W0QTJFigyu/ccb9Nm4NerMcSjy0sO59pkl1hEXfqeHQxqyHd2qUJZS0+hoemzY6Mfnf7YyiSvlHdQv7LdVer898IGdk/EajPYw8hbunuvvpUYHaYhnSPGcvc4yz4vRuruH1MKdyivBhEkgTPAXqVqLgDI4Ipk=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 09:38:27 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 09:38:27 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>, "Zhu, Jiadong"
 <Jiadong.Zhu@amd.com>
Subject: RE: [PATCH 3/3] drm/amd/pm: Refactor SMU 13.0.6 SDMA reset firmware
 version checks
Thread-Topic: [PATCH 3/3] drm/amd/pm: Refactor SMU 13.0.6 SDMA reset firmware
 version checks
Thread-Index: AQHbZu6Xdr+byUy4Y0WBc4WeDLw97bMXf3QAgAAUydA=
Date: Wed, 15 Jan 2025 09:38:27 +0000
Message-ID: <DM4PR12MB515201135DB6869D665289F1E3192@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250115014035.3681642-1-jesse.zhang@amd.com>
 <20250115014035.3681642-3-jesse.zhang@amd.com>
 <398c7b66-4727-4bf2-88bc-6ce5a2442678@amd.com>
In-Reply-To: <398c7b66-4727-4bf2-88bc-6ce5a2442678@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=33a6f936-d46d-436e-8777-191240710bcd;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-15T09:37:11Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|BL1PR12MB5971:EE_
x-ms-office365-filtering-correlation-id: 5cf9c330-ad93-4adc-4bbd-08dd35485d13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?YjNQOTNmZzRZQzdXMUNIQWNrOURyS0hzdDBWMTNpOTlZVkRJaUF6TksvNDl6?=
 =?utf-8?B?WjNuNjhjS1BwT0lHVGh2ckN0MnczSHViRVZ4OGZ2eFJsVHFDOTQwcnpCZHAw?=
 =?utf-8?B?ck5iTU5peG1hczlGWml5UEk2ZUpTNWVaQmo1Z1ZNbjc1Q1BPWW1BRE1SZEpK?=
 =?utf-8?B?N3FqUTJ6cnpaRnZhaGJKaGRTVDJqSXBub3E4S0VqaG11dDhucVFHcEo1UHBj?=
 =?utf-8?B?MlpJUzlRd2xKTUlOVDkyMTFoR245QkFXeHhHWUVQU3lrWDZ1d0VQbG9Zbjda?=
 =?utf-8?B?ODNiQWtLaW4wSi81cTJwZjJWSWQvekFrWEhHeFpYK3JWUHVKV1hZbnMvdmZZ?=
 =?utf-8?B?R3RFN0cxZFVMeUtRM1IxdjFGNjljRGR2emxIYmhUemVCY05nY3RaWkppR0RZ?=
 =?utf-8?B?WWd5dSt1bFBrbnlCeDltTHRGWVNtK1FMelRwM0NpMXduQkNVMWV0YitLOGM1?=
 =?utf-8?B?Z2EvR2E3aW1Zbk8wVmUvUDJsRXdsQjRnWXlkaUtQcURWYkxwZ05mRFF0VWRw?=
 =?utf-8?B?aURjWnNCWDZqUk5rWnVtZ0J4Z2FyczJkOGVGQ1dCNjNoRmVyYURUK0M5OEFF?=
 =?utf-8?B?ZGNkQXVGSDlQcnNraVI4dHA5Q1l0eDl2bXYzQitTV2krd1B4VXQ3aC9NdXN3?=
 =?utf-8?B?Z0lwbjAzRGhJWm4wRzVqRjJJUVJvNXFvSXYwMEdHUzRybzA1RDJTYzh5M2lk?=
 =?utf-8?B?YkgyNGErK2hHODB4Yis1ajA2dXJFVDZLZUk1a2NjemowQWhPUW5DNEdqYjFz?=
 =?utf-8?B?WFRtWW4yQnVVcURpOFd3RzVqVnIrQlIxd1lhWk03cDVvRUcyQzJ3N2pUM1hM?=
 =?utf-8?B?cTVnOFFzN01WM2hqSEF3ZFo1K005blUwWCszTENyM285Y1hNSFFqcG5RUHl3?=
 =?utf-8?B?bGRtMHFNejVhSnlKbjR2cXJPK3NDL1doaWFxUTdDWEt3K0ZMOFpBTHpBS1ZK?=
 =?utf-8?B?UEtIRDM1cjAxeFUvd3I5RDI5SVRKbWc5c2JZVXVuRVNHUzZDTjhPZStNRWlB?=
 =?utf-8?B?Y09rRjRLSkcyeDVpVzdEamExcHo1QjN3NDRXc0ZVSnNKSldkdDNpNEd5ZjNW?=
 =?utf-8?B?RjJVZ1ZEZnUyQVNydDd0cCtKOXFtOUZpNUx5VGVOZTl4QUNlT2gwSzB4OW50?=
 =?utf-8?B?WHg1VDhJekNmekU2ZnFodEdkdFVtSU5ETkRGZTJjOXp6a3dHS0RlaVZGOTZh?=
 =?utf-8?B?RU5TVDlJUkN3d3NTanh6ODBYajIzTHVKUFQ0RzlDQnQyUkh0QVJFMmRORThs?=
 =?utf-8?B?cE4ranFOcm1OelM0Rkh1b1RNMUlicndKc0hJSlFiQ2lsbi9qV3JDNC9qR1JQ?=
 =?utf-8?B?K3NCdWV3dkNZR2psOE93TlBlLzVzM1ZPZ3cwcWtoQkU4K2VSRWM1Z25XY3Jx?=
 =?utf-8?B?NDhBTkpTeWk5VzRlRnRYeFNVQ3dXcEc0WTVnaHYreTUrSGh4N0NCUVZyLzE0?=
 =?utf-8?B?U081TU53NVZkcUk1UVBiT0V3bkt4WDBEeC92ZEVra2U5NEdCQlFQODk4RWVX?=
 =?utf-8?B?Vi9oYUJ2V0V0dVc5b2dDQU1QRCs0ZEJLZFJLSW9wRFFLaHdsNWFFVlBMTkto?=
 =?utf-8?B?ODN1cFNxeGZGRytQMTBNQ0YrWFdVUTZ4Sjc3eDVnNm1PdnJKNVpxa2hNdzZH?=
 =?utf-8?B?NEZmUmNJVFl5N09vS0JnMzNrWlJkMU90eXFEWG5INnZCSUU5UkhnZzV6UE5M?=
 =?utf-8?B?b3liZ255d0NpRWxJR3Y5SDV3L2UvbU1NYzFHc2ovR1MxSkpGYldrbkVOYlAw?=
 =?utf-8?B?R3FmZ3ZpOXhLUWlENGRha1pxQTdsM3g2bkpRL1NnYnFqTTh6SERjeTJiNGkx?=
 =?utf-8?B?Q3ZFQ3YwTG1LMS9BRitLQWdWbW13NHhTUXhESXlSbDdHbFhpajJoRk9rNzdq?=
 =?utf-8?B?b2FtV1lkcHJDamRqVGpLWGJONlZaaEh1TWFWaFRQSzEwYXRVM24rNzJGeFhm?=
 =?utf-8?Q?66CWpGpsF4axvlbxwPhCV/PKVZDIm9br?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1V4bGNtVllPUzNsS3J0ZnRMem9JRlhoRFp1UzhtVm40bzJtS2NQbEc0WXdU?=
 =?utf-8?B?R3JLaWFvdjF4RGVGY1ZUcE9OOTE2T2pUWFVjM1NxRGJYck5PU3BrTnN2Z2d1?=
 =?utf-8?B?ZTA4ei9OY1lvbi9Ya25lQ0ltVjlEMkNZUzg0YXBUVkdvb0JLNFMvcXdHUEIz?=
 =?utf-8?B?cnFKVTJCQlJIWWJEN21uWHBVS3RWRFl4aEN4bXhzNnhDRXphQStISUE3c3hN?=
 =?utf-8?B?QjFFWTdnK295OW5IWkhUOFl0bHZkNElGOXpYcWR3VHRLQk90anU4L2VhYm5p?=
 =?utf-8?B?RFpsb2NoNC9VR2tzcitDazBhUFZyTWVsa2dENUZrUTZDMFBleFFXeUg5MzU2?=
 =?utf-8?B?Z2plWFduOE50dTh3TUFlbWJwZ2R6azc2MmR3a2lZMU5sTzNUMW9uRm9SWXhU?=
 =?utf-8?B?QjJRSDB1NElxc2N6S0Z5MTVMV1c5NnczWFl2MnJ1czBDcXdnTWNRWkpOeVRM?=
 =?utf-8?B?K0xnVVpWWXJad09JZlgvVmptdVAybmZmOHFsUGlIZEx5NE9BajZBakdybWVx?=
 =?utf-8?B?bHljdDVKRUIvalBVOFQ5a2xUU2grQTVkS0dIbkFFaW9xVW5Wa0UvbW5zaG5H?=
 =?utf-8?B?elgzeWZrWFBkRFVwQXBSTFU0Si9pWGtma2tacTlIR0dOQmEyRlh4ZTBzdGxh?=
 =?utf-8?B?OG12dnNwUXF6Q2kvY3BndEJJbDB3WmlFQmltVkNlYSt5TTNiMXpYOTg0N0h1?=
 =?utf-8?B?b3AxcEc0MFlBNkd6bC9xSnRuVWVrVmtDYnF0bGpXbkZoRDllZzZKNDRJalI1?=
 =?utf-8?B?MC9mNk1sckZMN3FickpoM3ZCWk9sRzVoWnNMOVJOc3FYZ0NQQS9Uc2NPVEUy?=
 =?utf-8?B?QUduWXhJQjdlNzBFUHhrSkxWNjVNc2liMTJNNzd3enpTTXUzNFNRTkg5bjJp?=
 =?utf-8?B?bTJnaGdKbDQzQmQ0OC9tTmNicWNUdUk4RitUM2hQNG5YNEdhdUJkMDhzR0hs?=
 =?utf-8?B?d21Fak9qVGRFNkdxZ0hicGp4TTlsMHRlaThXdmF5ZXFJb2M2Ynh1WDdiUVJ3?=
 =?utf-8?B?UmRsa3dzempLaWQxZlNaTStlenVzZk56ckprRHRMTTRVRUh3VWtkRURSZVZG?=
 =?utf-8?B?aUZ4Y1VlMm9INjRldEF0ZUhHOWpIbFlsTXhacnFNblQzWW9nV3ZBb25EM0FJ?=
 =?utf-8?B?dTkzUFNPVmlqMXU0QXN6b0U0K0dMNXJWcTk5aExmWG1vcitxeEJWTmJqZXNN?=
 =?utf-8?B?TDg2dis3eG5VSEQyQUhlRit3bXN1eFhZb3dJb3VEUGpWK1ZjOURrRkx6K0hS?=
 =?utf-8?B?T012SkJiWGlubTAzbnoya3VGWUJOaEtwSkpULzBsVUhhM1hWVTFFdmM3U2Y0?=
 =?utf-8?B?VW1oLy9YNTg2cm9hVkVHdUx1MXgvZldoK3BXa1JpbmpWUTVKS0JuUlR6bTJy?=
 =?utf-8?B?OUk1c2FVMml2R3poUWt2a3FmalJLbUhoblBnU3RmeStTZG8xdGdLcHFsakha?=
 =?utf-8?B?cXZrTThxYlNZTUpBTVY1SldVMVh2dytzNnVsajVXL21INTJyVU1oaFhhcFlT?=
 =?utf-8?B?QUl1QkhnVUhrcWl2N0Mrc3pONi9HWFVMNHpWa29sQ3dyc1FmaUswVzBHcjAw?=
 =?utf-8?B?ZDB3d2xIdnpJRjdzbmZPWGU2RTd2bGlqRVQwMkpqTWE2L1VKNEJEQnJlbjd5?=
 =?utf-8?B?bG0wNzBTaHNvTUZEbVJHaHRWWjY1ckNmYjVHVWE1dk1ma2hSeHFoSkVKbi9r?=
 =?utf-8?B?TmhMNTBMOElyMnYwM1NURjc0NUhBYnBEbHlNWlNNUnVJYVNtZ0RTeVEyVkxS?=
 =?utf-8?B?dUFkTktkSDdRN0V3UkJtcy8zVnpUaDhjY2VrQ2gwVkFiSzQyMUJhVzdJYjZY?=
 =?utf-8?B?eUZ2dEU5RldySnlXNzR2THE3b3k1ZmxHakYveG5qSVNQdzBnaUdpUXlQcEZX?=
 =?utf-8?B?dXJsSmVvMTduZC9DeXp5dUY5THdCY3hVUW8yVEJSZGxGbjFlSDg4WFR4ZFVK?=
 =?utf-8?B?cjVRZ2tkWnU0Q1ZLbTUrZE9oWlRyRktrSEhzK1U3eHZ3UzhMWDNXRGxVck90?=
 =?utf-8?B?aC9jKy91UlIxY0h3cjhoMGxuNmx1bTRsV05qVHZSRCsxbS9WNnZIbFhISlQ2?=
 =?utf-8?B?WHVCRmIvbFdlQkQyT1UrZllLR3duUzlBVWZpby92SFhodTdqZ0pBMzVKdzVB?=
 =?utf-8?Q?eCUg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf9c330-ad93-4adc-4bbd-08dd35485d13
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 09:38:27.1750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fCudT3eISS4Bx7mimFERSzrtcvw5yeYHYn3j9ykKi24gB3chjlYkwFE2+CPMTElMq9y86/TYGTqmaRGDWzF6eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxh
emFyQGFtZC5jb20+DQpTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMTUsIDIwMjUgNDoyMyBQTQ0K
VG86IFpoYW5nLCBKZXNzZShKaWUpIDxKZXNzZS5aaGFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29t
PjsgSHVhbmcsIFRpbSA8VGltLkh1YW5nQGFtZC5jb20+OyBaaHUsIEppYWRvbmcgPEppYWRvbmcu
Wmh1QGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gZHJtL2FtZC9wbTogUmVmYWN0
b3IgU01VIDEzLjAuNiBTRE1BIHJlc2V0IGZpcm13YXJlIHZlcnNpb24gY2hlY2tzDQoNCg0KDQpP
biAxLzE1LzIwMjUgNzoxMCBBTSwgSmVzc2UuemhhbmdAYW1kLmNvbSB3cm90ZToNCj4gRnJvbTog
Ikplc3NlLnpoYW5nQGFtZC5jb20iIDxKZXNzZS56aGFuZ0BhbWQuY29tPg0KPg0KPiBUaGlzIHBh
dGNoIHJlZmFjdG9ycyB0aGUgZmlybXdhcmUgdmVyc2lvbiBjaGVja3MgaW4NCj4gYHNtdV92MTNf
MF82X3Jlc2V0X3NkbWFgIHRvIHN1cHBvcnQgbXVsdGlwbGUgU01VIHByb2dyYW1zIHdpdGggZGlm
ZmVyZW50IGZpcm13YXJlIHZlcnNpb24gdGhyZXNob2xkcy4NCj4NCj4gU2lnbmVkLW9mZi1ieTog
SmVzc2UgWmhhbmcgPGplc3NlLnpoYW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgLi4uL2dwdS9kcm0v
YW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF82X3BwdC5jICAgfCAxNCArKysrKysrKystLS0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3Yx
M18wXzZfcHB0LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92
MTNfMF82X3BwdC5jDQo+IGluZGV4IDY1MGFhOWQwNTQ4YS4uNWE1NzQyNTcxZDI5IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF82X3Bw
dC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18w
XzZfcHB0LmMNCj4gQEAgLTI3NDUsMTEgKzI3NDUsMTUgQEAgc3RhdGljIGludCBzbXVfdjEzXzBf
Nl9yZXNldF9zZG1hKHN0cnVjdA0KPiBzbXVfY29udGV4dCAqc211LCB1aW50MzJfdCBpbnN0X21h
c2spICB7DQo+ICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gc211LT5hZGV2Ow0K
PiAgICAgICBpbnQgcmV0ID0gMDsNCj4gLQ0KPiAtICAgICAvKiB0aGUgbWVzc2FnZSBpcyBvbmx5
IHZhbGlkIG9uIFNNVSAxMy4wLjYgd2l0aCBwbWZ3IDg1LjEyMS4wMCBhbmQgYWJvdmUgKi8NCj4g
LSAgICAgaWYgKChhZGV2LT5mbGFncyAmIEFNRF9JU19BUFUpIHx8DQo+IC0gICAgICAgICBhbWRn
cHVfaXBfdmVyc2lvbihhZGV2LCBNUDFfSFdJUCwgMCkgIT0gSVBfVkVSU0lPTigxMywgMCwgNikg
fHwNCj4gLSAgICAgICAgIHNtdS0+c21jX2Z3X3ZlcnNpb24gPCAweDAwNTU3OTAwKQ0KPiArICAg
ICB1aW50MzJfdCBzbXVfcHJvZ3JhbTsNCj4gKw0KPiArICAgICBzbXVfcHJvZ3JhbSA9IChzbXUt
PnNtY19md192ZXJzaW9uID4+IDI0KSAmIDB4ZmY7DQo+ICsgICAgIC8qIHRoZSBtZXNzYWdlIGlz
IG9ubHkgdmFsaWQgb24gU01VIDEzLjAuNiB3aXRoIHRoZXNlIHBtZncgYW5kIGFib3ZlICovDQo+
ICsgICAgIGlmIChhbWRncHVfaXBfdmVyc2lvbihhZGV2LCBNUDFfSFdJUCwgMCkgIT0gSVBfVkVS
U0lPTigxMywgMCwgNikgfHwNCj4gKyAgICAgICAgICAgICAoKHNtdV9wcm9ncmFtID09IDApICYm
IChzbXUtPnNtY19md192ZXJzaW9uIDwgMHgwMDU1NzkwMCkpIHx8DQo+ICsgICAgICAgICAgICAg
KChzbXVfcHJvZ3JhbSA9PSA0KSAmJiAoc211LT5zbWNfZndfdmVyc2lvbiA8IDB4NDU1NmUwMCkp
IHx8DQo+ICsgICAgICAgICAgICAgKChzbXVfcHJvZ3JhbSA9PSA1KSAmJiAoc211LT5zbWNfZndf
dmVyc2lvbiA8IDB4NTU1MTIwMCkpIHx8DQo+ICsgICAgICAgICAgICAgKChzbXVfcHJvZ3JhbSA9
PSA3KSAmJiAoc211LT5zbWNfZndfdmVyc2lvbiA8IDB4NzU1MDcwMCkpKQ0KPiAgICAgICAgICAg
ICAgIHJldHVybiAwOw0KDQpJIHRoaW5rIHRoaXMgc2hvdWxkIHJlcG9ydCBlcnJvciBjb2RlIGZv
ciBub3Qgc3VwcG9ydGVkIHJhdGhlciB0aGFuIHJlcG9ydGluZyBhIGZha2Ugc3VjY2Vzcy4NClRo
YW5rcyBMaWpvLCB3aWxsIHVwZGF0ZS4NCg0KVGhhbmtzDQpKZXNzZQ0KDQpUaGFua3MsDQpMaWpv
DQo+DQo+ICAgICAgIHJldCA9IHNtdV9jbW5fc2VuZF9zbWNfbXNnX3dpdGhfcGFyYW0oc211LA0K
DQo=
