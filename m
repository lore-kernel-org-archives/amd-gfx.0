Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC06CA1013
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 00:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5315610E913;
	Fri, 19 Sep 2025 00:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TkX1YjzO";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011021.outbound.protection.outlook.com
 [40.93.194.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B86710E913
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 00:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKBQncQ2d91GKyW2R4KC6dLpAuXZM3VdZJBQkrlOBAn0tsAYrFyMO/EspRv5hRzmgvmTw5aiKaxSGgq638iw1ma4wvKDEMIP0+x+yXsenjkiqXCKjhQ5vOVyJam7fvGv70J6ArZIriRsUCUwYtjv/xqmfPyZcKTnov/c1q7hWUBEfsxkXWrsqkKcMuZohcky6HQlJyx820gWq53lTbrYuTb1EwIbgCbEA2CH564Ybsy8s8QRlurdmLhlyQJfAS+NmHXzL8LjffkIRKsxvNzHDGuWG/S+9jq6+bQxNELqUPZ4YF0IUUhAXKqjin11vVPw8FgJp8bgzOKLtcCCVu9YwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJQCVTZu6QqvIzKXgMzgWuaF2P9pSa37BZzKQb7L9hg=;
 b=aB9g/rHIA1V+wikjNslwmeotKzYwBnlXEtP8LpGS0JgY2Xw8AazVgyuQlz7++2OUIvnm4IwMpaYnQIPPAKZQcVjAfxGFxf7Q8wDWsUR2MgwW2Ej5s8TtreKGRtVsxjFmaSAHBEYlSpcykpPAlRouw7DPkQ7Wj07vsWuXd9gtg7OsiIRrOmPGE0fZZ8i/rfGfmTa0hkPmytBmhazNo+SZvdH4TKOnoohmzzRr9wmqWR6Y91zpN9NCK8VQdxaXWfgFaN6DUn7IFPS1qAEPG4fOcMSHmmNhDDjOlnJnAype06n1tupsZxzas9MMKCUP2JKwBzphdCWg4VGZclKEvw898A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJQCVTZu6QqvIzKXgMzgWuaF2P9pSa37BZzKQb7L9hg=;
 b=TkX1YjzOGOIiIcqzmXswTrtbOpRR8RL7bY8XguxG+y/qFWPcP8R1cnXhM/V2er6m8h0FrntbOfMq4ID4rp9+X5GdzHkWbLybS5wSTqqPEOBlbiGzDwdcRyez6+piCAL8BSOkzeILKzIJLAktqS0ujvqWiQR11qABWYpKp9uzcWQ=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by PH7PR12MB8826.namprd12.prod.outlook.com (2603:10b6:510:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 00:41:40 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%3]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 00:41:40 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 01/10] drm/amd/ras: Add amdgpu ras manager folder
Thread-Topic: [PATCH 01/10] drm/amd/ras: Add amdgpu ras manager folder
Thread-Index: AQHcKDy0N5Gp0FxsDUaDv7yXlYJ5n7SZXHcAgABO56A=
Date: Fri, 19 Sep 2025 00:41:40 +0000
Message-ID: <CH2PR12MB4215E8A43E8EF698865668C5FC11A@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
 <CADnq5_O4210XRs7w=C83JRCsiVXD=sckf4z_RGDHn0gig2MFKQ@mail.gmail.com>
In-Reply-To: <CADnq5_O4210XRs7w=C83JRCsiVXD=sckf4z_RGDHn0gig2MFKQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-19T00:39:56.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|PH7PR12MB8826:EE_
x-ms-office365-filtering-correlation-id: cb390074-3659-4784-af73-08ddf7154c4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QXF6M2NDc1pyUDNYN2dlRzdxbEtScWdpa25RKzdmMmJrcm5wSHV4Z05BMVhy?=
 =?utf-8?B?V29BQzFId3BpZ3Z1ajdETk95L2NzWlRNTmZwNXVkL1BYcmxpOXdaY1liYUMz?=
 =?utf-8?B?UDJ6ZXVHV1ptNVhhMXh5a1k5dFB0REROWTdTMUt0K3J3S3dVWTJydVBzeitD?=
 =?utf-8?B?eUtOemRoWThZUmg2M1h2ZTVRK1BiZ28zdkRHTjhuTTVqbXYzczVSWnVMUnhV?=
 =?utf-8?B?cmYwMHYxcTFxYkhqQzNQOEF4ZjR0NTBNVXdTQ25UTG10RTZpTGZXYmRRTmVx?=
 =?utf-8?B?TENaMFVoSHcrNEZQMlJtMHJ6VUJIMjQ0bG1Xd0k0Ykh1TEx4U0ZibjNDYlYx?=
 =?utf-8?B?MWRPWHRkTFFHYlBGVVYwOEt2dnVBdTA1S1M4VTU4SUxnUVN5K3hZcnc5MnRE?=
 =?utf-8?B?NkxoV3BVZlNaV2U4KzEwNjE3TkRLbDdMN3RrTmdnK2RnOElIa1J2WDVjT1Jq?=
 =?utf-8?B?aEpiLytVMHc2SmVOKzFrS291Q3Z5UGxvZGlQMU5IQVNJWFdqR0pISHRjWjl2?=
 =?utf-8?B?VWhUZzd6bzN6eCtkdGxnWDVkRUsrbDlRVG5RMVBmcDBHZ3hsaEx6NzA4Tld4?=
 =?utf-8?B?UmN0SVVWRDR2YUlLK0ZpZlp2aFVWbHUvQVR2OG1QLzJhWTlhenp5R2FHRWNs?=
 =?utf-8?B?UTdieVRoTFh6V3dKVC9aclZIOEFzd1pod25UUVFPYStFUXlwWFZkYlgrd1Jz?=
 =?utf-8?B?ei9MY1FncEhoQUlsMXh2alBKUmxFMFBacWJkTnNiaFh5Um11N2NYQ2ZtaDIr?=
 =?utf-8?B?Y1MzMHpjaFdwdUs0aXlnR3BESXJ4NU80QVozcW5wbSszK1Q0UDZhK25CSDAx?=
 =?utf-8?B?MW5vSVQ4ZjJ0Ukd3RklZQTBoZXlnNzdLTjZVbDlDeDJOYXlTQk1ia1dtZWJK?=
 =?utf-8?B?ekdPdGowVXhqa3V6T2ZYLzFwK0wybHVZeDJuQUhkaXBxcFdTOFJBNUNub25i?=
 =?utf-8?B?Yk14cVBtdWd2TStGampKdkZxTjVpNmFYaW9haXhxZ25sRlB6TE96enVIdUFU?=
 =?utf-8?B?VmJlUmYzMjRJd3F2cDJNUmxFQldieVZnMG1Od2xvc3crdnAyTHdlcmd0YWFQ?=
 =?utf-8?B?Q2dNdWxGVy91NkJLeW1Xd2h5WlFsVlVpMHh2VklLSk5oUkRWNHp6T29QOFp5?=
 =?utf-8?B?YWNDMU1IekJEOFlHZ3pYWi81TlozcUhFQzBLSkpJR3ludld0alRDY0FUY1Zu?=
 =?utf-8?B?NnowQ04rQWpTQ0kwZVUzbWx3aDRXT1ZTakRQRDU1SnFYOFlaQVBVQjA4TkEx?=
 =?utf-8?B?M3M1QTNYbUtFSDBQUmRCUlc4by9mWFplM3BhaUJ1VWM2SXB6Zjd5QXVwcHN3?=
 =?utf-8?B?dDNmRExyUGRPeE5NRXdPVUZzOTR2Sk1aYThQQldId3dZS2lLQ1BNY2JGY2l5?=
 =?utf-8?B?U3NaYitEaHBPYVhlbk5IUHFLU0ppQ2I5b2xpdjFhbUV0U1VFU1JNUkd6VU9C?=
 =?utf-8?B?WjRkL09icDhVWVNwbS8vOW5yWmpYTlFERlVvdkdJQ1R5d3paYXZwRmdlbDdl?=
 =?utf-8?B?N3JXUXZIUVA3MXR5WHA2RVdCZjhhYzU4eVRGNGo3NGNuaktrVnRoMkxkTDVo?=
 =?utf-8?B?SXFUZjR4a3A0TFo5bDZPK2JCMmUwSGdsQTJtNTdCM08yaktWbkhYTy9vYTVD?=
 =?utf-8?B?clJxQktqMmhmWUhOWW9MeWh0YjE4cDdxSnh3N0FLNUIvVFQxVXZ1a3BoWk1h?=
 =?utf-8?B?aXRTN1cxN3NOcmpDS3FlcmM5dkFRWlEraXFadnR4SThheFUzZzNZQnVRRXRU?=
 =?utf-8?B?SmJwMnIycERlRXlNeEFEcFR1RjFsU3pReVBoNDNpaTRzaXJxSTNXR2ZwRzND?=
 =?utf-8?B?YjZpSFpVRk93ZCtJaEZveVAxSGhFdmlJeWJRaUNlbVllUnFDUkNMYllLeUpT?=
 =?utf-8?B?dk5rM05iUkMwWVF2c3IwcU9NR2NEbi8vSDJ1U295U0RPU1pCUWtTRExYUVRS?=
 =?utf-8?B?ZlIwVjQwTEZPWE1NQVhqUGJiNFZWejZwVGhhNGF1TEhYeGN1aGFTVTZ5UldY?=
 =?utf-8?Q?pGn1BJKNsaHX7gRIRPT3t+K8oW9cCk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXpHMEtVVGJWUGJuRk5neUdjWkdTcHRxNG5uNGoyVElqQkZyVEY2NzBNMitz?=
 =?utf-8?B?MTlzWVRrL3IrK1NEUHp2akl4bW9sR3ExNld6bTBCSXlwc0NGMWIxdkNFcFJt?=
 =?utf-8?B?bUdiUGRJZVVKL1R6enNuczF3Z0k3SHlmU2I4ZWtkUzVEbmhIZE1WQ1doMXhV?=
 =?utf-8?B?TEVKZEhGbnRNN01aSUpndFFWby8yRVpQNkw5cjk2Z0VKTWs2TUFhQU83M2dy?=
 =?utf-8?B?ZGNoY1hzS3QrRTVPTnlZc1ZWWWowR0pLTDNyUUZhR0ltYmxFYU5LV2twQkMv?=
 =?utf-8?B?OXNBQ1NneW9xalBRYTNTT0hENVYxa0h2cWhlZU1lWFFkVTRkT2N5bWdIME5D?=
 =?utf-8?B?akx3RWgyQU8xUlp1OGxaT0E0U0h0eHloRVBiS09CNW83S0NGSXBGaWNXV05l?=
 =?utf-8?B?MVp1Yno3YjAzTW93Nmx5VDAzb1Zpejl2V1d3N3F5QUdtejI1aWlPS2RKb2pL?=
 =?utf-8?B?RXJBazdQT25pbzJza1NxUDl5VnhTZ0F5WkhFeGNWTDZGRHdFNS9BTFRiNWEy?=
 =?utf-8?B?OEJLd3kwL0tsRDB1ckc3dDUyekRLR2FZM2RxVTBTZkFxd0tJazV5M2thMGcw?=
 =?utf-8?B?VkFQSEE3QjZVWVAxR2JrWVJ2TjhlRWRKRGpUb2s4ZjBjZXBCc25qUzdiMmVU?=
 =?utf-8?B?ZFpCNk1mWWxScVhjSVBycnNIZFlxOVZRKzJMWWZOdWRodjJQU2kyMGdDZlBB?=
 =?utf-8?B?YUNFRENENEtidjlGbUJiL1VqQ1liT1crTDdxSEd0Q1ErTGVIVWhheDhNSkxK?=
 =?utf-8?B?UWw2dzhRT0RwMHlZZ21VNTlmaWFtY2JleThWNC9PcFhGSUc4dW5OWW9OYksv?=
 =?utf-8?B?bmdkOGR6dnhuMlNJK3NHSW11VGNnd3kvZmpDKzNqeDhqWVJ0V3BheGx6MEF0?=
 =?utf-8?B?VU00WDJIcDAxSExMcXdEeHZDZ1R1WkdVUkU1djh2aEZ3VzJaYlBHcTc2Vmoy?=
 =?utf-8?B?UEMydkZmYlhVMjMvTEFHY3R1eTZIOXdQRWM3SmlLbVk2aC9XVG9vY0Ftb3FK?=
 =?utf-8?B?ZVpOVE51RG9nV3dYVlo2Ym92VVQ2UEdjb1kzc09raEhqTGhBVHh5MEpVNjJS?=
 =?utf-8?B?eWxCZUlnaGxPOEVKM3ljZTNiV0M1aXBock9WVXVGc0hEUmdMajlOWDRuN25q?=
 =?utf-8?B?dWYyMW5GeFJUMHJDN1NXdVRTc2dqNmdZOVlxQXZPVExGYkFwdCtzYlFJVEZu?=
 =?utf-8?B?UDRmSUF1TzBia3NUUjE4T0U4eUhqVXdGWCtRVk4vZ2wzZkZmMWdkeGF5SGtN?=
 =?utf-8?B?OU54Nld6Nm9EVDZ6VUU0cWx4U3VTRDlMNEIvNXhLdE9pb3FJKzVvMFNBb0Rk?=
 =?utf-8?B?Y3hmb2Y5dkxNeVU3UHR1VG1oelBGSWcvRjZKTE9SdlpYZWlFL0FISDRjelps?=
 =?utf-8?B?bDVlbTlrMWw4Qmd6RnVuRndtVkFjN0p6cnJUOVpsUFZwa1NYQjdZc0NHZ016?=
 =?utf-8?B?SnlONEhZTXZLVllCUzExbXRMZmd5azlMUWpnUE9aV0lvZmxISEd0Mlh3elF4?=
 =?utf-8?B?TTBlV0JKdXZOU1loR2dIQk1lekhza0dkUDV6WUdwWHM4d2Exai9WNTFMWjNl?=
 =?utf-8?B?ODVHUS9IejBMYTlJdjg4dEVuSGs2cVUwUkJCNThTaXo5VS83UERCbnNuZE82?=
 =?utf-8?B?aEJBbXRFaFpwNzdqY1RxNjg1RWkwelNGbVhxbUFYanNGT3lXN1JGdDVXd3JO?=
 =?utf-8?B?dENNb0pvZEtlTW9HekxrUE1Gc3FpUjc1cUV1aVp3WWp6RTJZUHdvaGJPWExL?=
 =?utf-8?B?b0dPWVJoYlJLMSs1dFpsWWhCV2IrSk9kRnJnWjNoelgvQUl6NC9ndFpML3ly?=
 =?utf-8?B?bGNyUnV2N3B2Ykp1ZVk5c0cvd2dIeGU2SmVMNFVRWHJlOXU3N1kwSzliRU1Z?=
 =?utf-8?B?VVlvOC9zaGE2VVlGdkI3MWNXbWI4Qkg2bHhXN1FoN0NWcWZUOW9FQWlKV05y?=
 =?utf-8?B?ZXpuUHRjQ05kdXJFWjg0N1BhVkRMeXFlQnZpeldyeFUzVDNjRHN6aElxeWdQ?=
 =?utf-8?B?QnVXNnkwcmgwVVB6eWtmb29pZ21LTHVnRHdSbzNNVVlSOFlBRVVtc3QwczVO?=
 =?utf-8?B?MDlEN245UEhjaUlXTldoT3hXWWVmWTBHWGlZM3c1V1dPajRGY0c2TW43Sk1F?=
 =?utf-8?Q?7q4Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb390074-3659-4784-af73-08ddf7154c4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 00:41:40.2864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+dkU7fx1dt3cyJ+U45WWOAfK4NGtRYJrkYTU9NdJGb8yNWrJshOIRZk4aJ2heBzgnVXpFF1z69nUSVpuw+BGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8826
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
Cg0KT2ssIHdpbGwgc3F1YXNoIHRoaXMgcGF0Y2guDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NClNlbnQ6IEZy
aWRheSwgU2VwdGVtYmVyIDE5LCAyMDI1IDM6NTggQU0NClRvOiBDaGFpLCBUaG9tYXMgPFlpUGVu
Zy5DaGFpQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpoYW5n
LCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBaaG91MSwgVGFvIDxUYW8uWmhvdTFA
YW1kLmNvbT47IExpLCBDYW5kaWNlIDxDYW5kaWNlLkxpQGFtZC5jb20+OyBZYW5nLCBTdGFubGV5
IDxTdGFubGV5LllhbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMDEvMTBdIGRybS9h
bWQvcmFzOiBBZGQgYW1kZ3B1IHJhcyBtYW5hZ2VyIGZvbGRlcg0KDQpPbiBXZWQsIFNlcCAxNywg
MjAyNSBhdCA5OjU04oCvUE0gWWlQZW5nIENoYWkgPFlpUGVuZy5DaGFpQGFtZC5jb20+IHdyb3Rl
Og0KPg0KPiBBZGQgYW1kZ3B1IHJhcyBtYW5hZ2VyIGZvbGRlci4NCj4NCj4gU2lnbmVkLW9mZi1i
eTogWWlQZW5nIENoYWkgPFlpUGVuZy5DaGFpQGFtZC5jb20+DQo+IFJldmlld2VkLWJ5OiBUYW8g
WmhvdSA8dGFvLnpob3UxQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9y
YXMvcmFzX21nci9NYWtlZmlsZSB8IDANCj4gIDEgZmlsZSBjaGFuZ2VkLCAwIGluc2VydGlvbnMo
KyksIDAgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gZHJpdmVycy9ncHUvZHJt
L2FtZC9yYXMvcmFzX21nci9NYWtlZmlsZQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9yYXMvcmFzX21nci9NYWtlZmlsZQ0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcmFz
L3Jhc19tZ3IvTWFrZWZpbGUNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAw
MDAwMDAwLi5lNjlkZTI5YmIyZDENCg0KV2h5IGlzIHRoaXMganVzdCBhZGRpbmcgYW4gZW1wdHkg
ZmlsZT8gIElmIHNvbWUgY29udGVudCBleGlzdHMgZm9yIHRoaXMgZmlsZSBsYXRlciBpbiB0aGUg
c2VyaWVzLCBqdXN0IG1lcmdlIHRoaXMgcGF0Y2ggd2l0aCB0aGF0IG9uZS4NCg0KDQpBbGV4DQoN
Cj4gLS0NCj4gMi4zNC4xDQo+DQo=
