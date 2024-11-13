Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEB0D462A1
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 13:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5DDB10E702;
	Wed, 13 Nov 2024 13:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wefJ2i0v";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E93CC10E702
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 13:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrjfDezwD7E5SDyjTB3VfKNYj+Pr11i1UNY06RTHGte2SBXSLLihX97T/mV3MDjOiGTB5wA8kRTYC1WMPCc0CyA2kxdH+5P2sU18tTs2cUIZFDMxXwycJr27UfnBe2RNm0F65/U147Cpx/zOKfpPrAFUmvvbmFPKu9LUHD4mxtVXRqr6pWZ248fOIvIZ9OsCBZfNZR//uh637nb+KAamDpaHsyjmiRBAhqyT2nXn3EjqZ2/AnrOzo+4GVriHbg4hwxxmS2EMu+f+bAahSylIAkQyuVAzjcFXHZXV376IZFR7jWsHvB11wQl/IRBhxE8oSVG5hJE608fdIJfbZqC6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBpjnAqvaIHWVSwRjGtG65676DIU5p5tfhDqifMGoyo=;
 b=IBppGrOb7hOIL1t25xdX4+t9x4yud+uv0Sx4S37K8eTTOymlP5XrRV0DcT1MJOutfVybpTIjoMyDbvB2yNlsYUob/yMzZzXleB6xMe2PeIp29CURpDkQjhAmqTVPIggpD4hh3TXScBhV6X3CTF4ofJ5r6boqw17B8L1+Sbt9fQss+QN8iJkF7Rgeqol3L+8ySFxSmbFeOrvNbdUbmlKyvdEju/nWPi8cq8AU5Ln3Sbek7d4UgVs5aq/tmFSrz8D9ppoqVSK0AalUIlx2i7PFgdOHqlnKogNYwVtgHAsN7TZ/f+O4cJHDNfQ0mwcGaNkAO1rQQYI9tPiv3WpFnEanYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBpjnAqvaIHWVSwRjGtG65676DIU5p5tfhDqifMGoyo=;
 b=wefJ2i0vZs6gzX10RJdPf89oyKaiz0ir1/AftKoUYJj/cqhhHkpesh2OMYfUBzqPhk6xq3A8X9kuhWz7rlD8dGSXx7zMoqAaIKk/LtuyQhoQH/+ZrzZ9f+2gTjqD3EpAOcubwfAKjmCHM4+znnQ1Q0iJIPAlB31Gel2oUGRnAwY=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 13:53:15 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%5]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 13:53:14 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
 <ckoenig.leichtzumerken@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v7 4/4] drm/amdgpu: track bo memory stats at runtime
Thread-Topic: [PATCH v7 4/4] drm/amdgpu: track bo memory stats at runtime
Thread-Index: AQHbM4cm2Qy9C3gimkGj8UdltocsKLKze08AgABz2+CAAPuMgIAAGtOAgAAUi4CAABqaAA==
Date: Wed, 13 Nov 2024 13:53:14 +0000
Message-ID: <SA1PR12MB85999903EC92F7A1329D741CED5A2@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20241110154152.592-1-Yunxiang.Li@amd.com>
 <20241110154152.592-5-Yunxiang.Li@amd.com>
 <5d1c88a5-9802-4bb7-b76a-5e501847ced1@gmail.com>
 <SA1PR12MB85998D24DDB5EB93AE88E5A1ED592@SA1PR12MB8599.namprd12.prod.outlook.com>
 <92be210e-b552-45ee-9322-1944a4bfd325@amd.com>
 <cc63f0ef-e152-49fc-90d9-ca695a8918f3@igalia.com>
 <eed6b35e-912a-4d7a-ac18-643d571f6e03@amd.com>
In-Reply-To: <eed6b35e-912a-4d7a-ac18-643d571f6e03@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=54b06e48-4208-4be8-ab47-6aadbea76a64;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-11-13T13:13:54Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|DM4PR12MB5940:EE_
x-ms-office365-filtering-correlation-id: a80cef3b-7603-46f3-209e-08dd03ea8520
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Ky9IVFV0QzVOaFMxQ3ZxTXBEWXhuSGtYZ2o4NlBYV0REZkNkL2ltb1NyUUFX?=
 =?utf-8?B?alZ5UDVYVEtFb1VlT1ZFeHdQTGlkZ29uRUFkaVdVOFc0Y1diV3Y3eXlxZ0p4?=
 =?utf-8?B?Q3B3bmRWL2g0NHVhZ2JCQ2NnbG02SHczcXpUV0NWWXF3MXRseHZvcjhYZ3lS?=
 =?utf-8?B?cWVTTm1QNWNMeXJBS2RKandUQkV3ZmR5MVlWeURvelNwMU9SVkxtU0NVQXVk?=
 =?utf-8?B?QTBlaHVMc3dTSFNrYnpuTjBhQVh4bnluV1VTY1FyWUhSbWw3SlJUZVVseHFo?=
 =?utf-8?B?aEFmZy9QMEpJUkFKMEp1QVFZb01jODhOMmZibU5pL2gvcVoyZXg3NFErYmFy?=
 =?utf-8?B?dEdYMTJ3RHlydWdpMjVhaExHNE4vSzVLaHduRGk0cHdnUEtjcjZZZjJhU3R0?=
 =?utf-8?B?ZnpLRE82RWZXc0NWM2tOVVA0NjhERHlYQVZhdmtyMmpVdkhDV1FpMGZvOWZ5?=
 =?utf-8?B?MzZnVHZQVkRwbnhLaFVoSW5pYmd5V2lHZFpVSDJJRFhsL0pucTlzVkdhYlQ3?=
 =?utf-8?B?MDVWWjJBRG56ditKZEpaOWRrbGJHcTlsZFJ3eUdOUFBDbTVWMHFwcWlkNjZG?=
 =?utf-8?B?cTlXVzRGMWpsRWlYYk40WE5rdE1GaUhqdjZkRXNTSUkyd2xBQTc2MmtSM1pq?=
 =?utf-8?B?elBQYUI3bGg0YnEyUGNCeDdiYWVtUmRlbFhnWkR0elhnY1J5a1R1Q292aGF5?=
 =?utf-8?B?azdBRjFDVTJIT2NzcVVlWFNhb1NVY2dnLy9VcXNQWDNTVlF5Q0h3bDBJVTY4?=
 =?utf-8?B?djBGb0hudURRZXNBQzdWQlFkaWtuRXN5eUJYM1N3U1FRY3FRcGMrRW5hWTNn?=
 =?utf-8?B?bEtLd0RSZ3pmcnNETDZEVjFkeCtJOVhrNkVrUER2Q3A0Z1BJSDdNaWJzVG1Q?=
 =?utf-8?B?T1FrOGlDWExvdG9oVmN4S2E4bW5MWnRHTExGVUdGeDVEcURUNENhaVZ0RUhu?=
 =?utf-8?B?K080aVo4eG5JWDI5WTU5anowOHJldXJIYTFPSWtKWUY3bmZDaTZPS1U3c3Ur?=
 =?utf-8?B?YjZOenBXL244biszSzB3d0RyMXBLUGp0UGxXSjJkR1BHdXJOVzJybm9JcHpk?=
 =?utf-8?B?eXJzQ3pYWUk3eXhGYjVWZzdTMHN3SjFoMlBqb0xFajIzMmpHQkJNbkJPeEIz?=
 =?utf-8?B?ZklVcmN5SllBcDJ5OWdpSG9DSXNkUXZmbEVEbFBTbm5XOG1PRG9Eb2NDYmkw?=
 =?utf-8?B?SWtBMDI0N2dtWHQ3MDBXWHdlTGNlU3g5OHczcGRVTGI4ZmZtKzdCZ0VSQ2hL?=
 =?utf-8?B?ZVJVQlhzYUtCU3JFbFdOeXJpRlkxZ0tKU3M2azV2Z2J0QlRNVWhzbWlUV1Ix?=
 =?utf-8?B?Q0pYWm1ETmgvWXZnRE1qK0xzczZpaFdVYlFSUHY3SWk0T2RkY2toMTRRc0VT?=
 =?utf-8?B?VVF5ZG1BS1JzUlVlaks3N0E0WE9EbjdWcEVjWmZtK1haek9nbXN5RGxvaml5?=
 =?utf-8?B?REMxOWVOUmx1TElscU9pcUZnQWZXcUF5eUhER2lqemJNN1Rrdk5WeXVrcElJ?=
 =?utf-8?B?RHdXT1ZwajBPOTZQdlJDbHZ3UUR6b1ZYUGZFdFZ0ZktaMXhhMm9KS2ZqbFE2?=
 =?utf-8?B?a3plYTNTWlN5WEMyOFMyZjNSSjlwd0wwVUpyZ2UzM0RZRlpDSko3bUVhcm1U?=
 =?utf-8?B?VFE3YkRaY0liTlJ6Zm5nakhTTmRFa2N1TjZ1SUp4N3YzVjlKcjJYVERKdVNG?=
 =?utf-8?B?eE04VjRXbnBBNG41M3Ixc21Sc2NKaWNQUElLREdTSGRXMVZIQ0QrQ1p5Wlh1?=
 =?utf-8?B?eVdZZzkwb3htVDFOc1gxQUxtN1NReXVLNmo2QnBBRkdnS2w3VGx5eExOeVZ3?=
 =?utf-8?Q?8rnDuB8TuwILGWaBATziNr/KGzh8DM0KBXPEs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU9XQTl0MTFCd3NrZ0MweFdhdWhFcjJZemUvMUNjWmp2NkVjQjByTHVIc3BQ?=
 =?utf-8?B?eXlGWmFIalg2VFA0NU5IdjZ5WHVmUWd4Z1hBaC90bWM1ZFJzanRZVjA5ZlhC?=
 =?utf-8?B?TWdkT04ralVrMVRCM204NXVVN1cwRmF4YS92QmJZUWdDeHNadVphcnI4TlVm?=
 =?utf-8?B?dGR4YTVpZVdDd0hJbmJRS21wYXI1alRmelZaaVhiQ0dLOXViUjh6MjZJNVBP?=
 =?utf-8?B?Z3NNdWlCVVJ0eGFkRlFoaVdoYnpIR3M4R0czY2NMZmthWEZHME11anRjdURv?=
 =?utf-8?B?QzM5WnF2QU1uanFYdUQ5RlY3MjUvSVMrelQ4cUV6SjROdEhDMGdZcG8ralI0?=
 =?utf-8?B?SHUvdGVsc0NXMDdsM05tdzVLdHJGeCtsbTZURWZTREszKzkvV0t0YmVEcFl2?=
 =?utf-8?B?N2pKM1lMcGZ5L1hoclVpVlF1Mzl1UTJkUHNLd3lweHdiTkFFUDdVai9tampE?=
 =?utf-8?B?c1VBamxaZEJHQlB5RXRReGU0elFUTE5Pc0ttTGdaRWZ5cnA5Q3YzMCtjM1px?=
 =?utf-8?B?cnpONnIwWjhNZDRFT1FJRXZ2eHZpV0pvV2FlMURndW9VR2l1QVhhR012UFdz?=
 =?utf-8?B?aWVKYkpxbkpSU3hrMDhiMlVOSFNQT3pvbThEUnFZVVJQQUZ6L1AvZjcvQi9S?=
 =?utf-8?B?VGpMSHBJalVLQWFMYURSelNyZUJYY0NsTUMwK0s2V3dYenNsc1pIdGkzdno3?=
 =?utf-8?B?TEh1ektkLytMTDYzdnZZUmxiVmtlbkhPVDc2N3M5WWs0Mmp3QUxLaStJV2hE?=
 =?utf-8?B?U3NNT3NkTUhEZngrdVlma001OUhhcElVSnlQai9ucmk1MC9MVkRMZWs3WUxw?=
 =?utf-8?B?WVdQUTVVa2Y3N01EV2grT3VXZUNjTXZaRGw4R1Jsc0FvVzZKMmZwSlVGRWRD?=
 =?utf-8?B?TXk0bXRQbmdMTDdGLzZGNDlDQ0JMSC9yVDh5c3ZaV2krVmdpUjVTQkFHQzVH?=
 =?utf-8?B?YzlsZFJwZWE5VUUwV0pvdlFIbnZDOWFkVUtVaEtEMHdZMytrY0I3WW82bk9L?=
 =?utf-8?B?ZWE0aUkyUDU3aWpMR2ZiVjRKRXEvb2JFSkV3dGhoR3QveDRvOTlVa0xFK0Jm?=
 =?utf-8?B?MDRFU0lwU0JGeDh6SHUxeHptRHVDcGUzWjVmR0J4WitUbndIdFVBWHBldThn?=
 =?utf-8?B?QW5qK002c1M4VDVXVm9oMkVWV3VTbXlyVHA4VGlKOWt1RTBrdlc1TTdxOG5M?=
 =?utf-8?B?ckNXRTZPVkxHamxJZElBM3Jza0VqSkNqZSszazBQYklvaFl3ZHFCMWttaUJl?=
 =?utf-8?B?MXZzVUpnT29QSngwNHRESngvOStZbzVUWGcxbWhDU0YwVlYzT08zY0hDSUhW?=
 =?utf-8?B?aWY3bEo3TlcxdFpudFJXV3YzRFlRUkRVdDVsVEN3enozcHkzc2xPbnpqWjNn?=
 =?utf-8?B?OHVBRUFPb0Z0OTB5WDlISTA1YVlVK21PZS9HOUY5QmxSU2ZNYmtWWURnYXF0?=
 =?utf-8?B?eEhueEpYcy85NWdIcGxoRVlkU3BJUUZvTHE2TU1CMWY0NG9DdFpYTTQzME1m?=
 =?utf-8?B?NjVnR0NNWE9BdDhrRzZpZGgzVlVJWE1qMVorMjhKVTV2VTVkYW9ESDlPSWN1?=
 =?utf-8?B?Z1FqMks2aEVxcFBNZUFVSzJ6Um1KRkdBMUppZUs4SUFya3RZcTVMMXY4SmEr?=
 =?utf-8?B?MCtqMzdoMTFXWU92eUd5QXBpWTh1ZGhBYUUzSVZHQmRJNzFNRlZWVUxtbDl0?=
 =?utf-8?B?Wnl1SVRRMkV0amFySjAxTWhrOVFLWkRjMlFGVkh5K21PekI0Y1JuY1NDaUxE?=
 =?utf-8?B?aEhHd3AxYjNsUmNHUHd4dzEzalhVb3k2Uzg0UlN5dE5Dd1RxV2t4S3FZVFZk?=
 =?utf-8?B?NDc2bjNDSkx6SitSU09VeU5KeENGeGpOTFNIYkZmYzlGRHZ5bzVuVWxFVnlV?=
 =?utf-8?B?Z29LQUFDUVMvSUdyYnFMWExFMERFUDBuOHVCbTJtYWoxRm1LeHRRdEZSN09Z?=
 =?utf-8?B?d0J5N0NhOWNQZDFXZ1doSGUrNkFYR0FMZ1g4aXlwVlBWUnduWGFmOFp6TTRt?=
 =?utf-8?B?RlpNbkJJM0drMXpTOVBQRlc5L0ZxcHgxWlZFMmhreG5mcHRMcXF1V2ozZ2Yy?=
 =?utf-8?B?SmpvZ20wK1NvTE9ObStpQjcyOHhPRnpLMWR5WVhlQ0VReGFWQWpwRnlFaHp0?=
 =?utf-8?Q?5LxA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80cef3b-7603-46f3-209e-08dd03ea8520
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 13:53:14.6631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /rWjpkj2pwyw7IbePe4EEEUNXHXMv9cN5XGIAoeXTHIRvqANBJEXb83MNmCY6cVRlUKcR4hPZ9NVg4lOZ+1T4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940
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

W1B1YmxpY10NCg0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDEzLCAyMDI0IDY6MzkNCj4gQW0g
MTMuMTEuMjQgdW0gMTE6MjUgc2NocmllYiBUdnJ0a28gVXJzdWxpbjoNCj4gPiBPbiAxMy8xMS8y
MDI0IDA4OjQ5LCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KPiA+PiBBbSAxMi4xMS4yNCB1bSAx
OToxNiBzY2hyaWViIExpLCBZdW54aWFuZyAoVGVkZHkpOg0KPiA+Pj4gW1NOSVBdDQo+ID4+Pj4+
ICsgICBzaXplID0gc2lnbiAqIGFtZGdwdV9ib19zaXplKGJvKTsNCj4gPj4+Pj4gKyAgIHJlcyA9
IGJvLT50Ym8ucmVzb3VyY2U7DQo+ID4+Pj4+ICsgICB0eXBlID0gcmVzID8gcmVzLT5tZW1fdHlw
ZSA6DQo+ID4+Pj4+IGFtZGdwdV9ib19nZXRfcHJlZmVycmVkX3BsYWNlbWVudChibyk7DQo+ID4+
Pj4gQWdhaW4sIGl0J3MgYSBjbGVhciBOQUsgZnJvbSBteSBzaWRlIHRvIGRvIHN0dWZmIGxpa2Ug
dGhhdC4NCj4gPj4+Pg0KPiA+Pj4+IFdoZW4gdGhlcmUgaXNuJ3QgYW55IGJhY2tpbmcgc3RvcmUg
dGhlIEJPIHNob3VsZCAqbm90KiBiZSBhY2NvdW50ZWQNCj4gPj4+PiB0byBhbnl0aGluZy4NCj4g
Pj4+IEkgZG9uJ3QgaGF2ZSBhIHByZWZlcmVuY2UgZWl0aGVyIHdheSwgYnV0IEkgdGhpbmsgaXQg
c2hvdWxkIGJlIGENCj4gPj4+IHNlcGFyYXRlIGRpc2N1c3Npb24gdG8gcHJvcGVybHkgZGVmaW5l
IHdoYXQgZHJtLXRvdGFsLSBtZWFucy4NCj4gPg0KPiA+IFRvdGFsIG11c3Qgc2hvdyB0aGUgdG90
YWwgc2l6ZSBvZiBhbGwgQk9zIHdoaWNoIGV4aXN0IGV2ZW4gaWYgdGhleQ0KPiA+IGRvbid0IGN1
cnJlbnRseSBoYXZlIGEgYmFja2luZyBzdG9yZS4gVGhhdCdzIGhvdyBkcm0tdXNhZ2Utc3RhdHMu
cnN0DQo+ID4gZGVmaW5lcyB0aGUgZmllbGQgYW5kIHRoYXQgaXMgaG93IGFsbCB0aGUgb3RoZXIg
ZHJpdmVycyB3b3JrLg0KPg0KPiBJbiB0aGF0IGNhc2Ugd2Ugc2hvdWxkIG9ubHkgbG9vayBhdCB0
aGUgcHJlZmVycmVkIHBsYWNlbWVudCBhbmQgbm90IHRoZSBiYWNraW5nDQo+IHN0b3JlIGF0IGFs
bC4NCj4NCj4gQnV0IHRoYXQgbWFrZXMgdGhlIHRvdGFsIGlkZW50aWNhbCB0byB0aGUgcmVxdWVz
dGVkIHZhbHVlLCBkb2Vzbid0IGl0Pw0KDQpZZXMsIHRoZSBpc3N1ZSBpcyBub3Qgd2hpY2ggQk8g
bmVlZHMgdG8gYmUgY291bnRlZCBidXQgd2hlcmUgdGhleSBzaG91bGQgYmUgY291bnRlZC4gVGhp
cyBnZXRzIG1vcmUgY29tcGxpY2F0ZWQgaWYgd2UgY29uc2lkZXIgQk9zIHRvIHByZWZlciBtdWx0
aXBsZSBwbGFjZW1lbnRzLg0KDQpJTU8gaXQgbWFrZXMgc2Vuc2UgdG8gaGF2ZSBkcm0tdG90YWwt
IHRvIHdvcmsgbGlrZSB0aGUgbGVnYWN5IGFtZC1yZXF1ZXN0ZWQtIHdoZXJlIHdlIGxvb2sgYXQg
Qk8ncyBwcmVmZXJyZWQgcGxhY2VtZW50LiBGb3IgbXVsdGlwbGUgcHJlZmVycmVkIHBsYWNlbWVu
dHMgd2Ugc2F5IHRoYXQgdGhlIGltcGxlbWVudGF0aW9uIG5lZWRzIHRvIHBpY2sgb25lIG9mIHRo
ZW0gdG8gYXZvaWQgZG91YmxlIGNvdW50aW5nLCBidXQgd2hpY2ggb25lIGlzIHVwIHRvIHRoZSBp
bXBsZW1lbnRhdGlvbiBhcyBsb25nIGFzIGl0J3MgZG9uZSBpbiBhIGNvbnNpc3RlbnQgbWFubmVy
LiBEb2VzIHRoYXQgc291bmQgcmVhc29uYWJsZT8NCg0KPiA+DQo+ID4+Pj4+ICsgICB0eXBlID0g
cmVzID8gcmVzLT5tZW1fdHlwZSA6DQo+ID4+Pj4+IGFtZGdwdV9ib19nZXRfcHJlZmVycmVkX3Bs
YWNlbWVudChibyk7DQo+ID4+Pj4+ICsgICBzaGFyZWQgPQ0KPiA+Pj4+PiBkcm1fZ2VtX29iamVj
dF9pc19zaGFyZWRfZm9yX21lbW9yeV9zdGF0cygmYm8tPnRiby5iYXNlKTsNCj4gPj4+Pj4gKw0K
PiA+Pj4+PiArICAgaWYgKHR5cGUgPj0gX19BTURHUFVfUExfTEFTVCkNCj4gPj4+Pj4gKyAgICAg
ICAgICAgcmV0dXJuOw0KPiA+Pj4+PiArDQo+ID4+Pj4+ICsgICBzcGluX2xvY2soJnZtLT5zdGF0
dXNfbG9jayk7DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKyAgIGlmIChzaGFyZWQpDQo+ID4+Pj4+ICsg
ICAgICAgICAgIHZtLT5zdGF0c1t0eXBlXS5kcm0uc2hhcmVkICs9IHNpemU7DQo+ID4+Pj4+ICsg
ICBlbHNlDQo+ID4+Pj4+ICsgICAgICAgICAgIHZtLT5zdGF0c1t0eXBlXS5kcm0ucHJpdmF0ZSAr
PSBzaXplOw0KPiA+Pj4+PiArICAgaWYgKHJlcykNCj4gPj4+Pj4gKyAgICAgICAgICAgdm0tPnN0
YXRzW3R5cGVdLmRybS5yZXNpZGVudCArPSBzaXplOw0KPiA+Pj4+PiArICAgaWYgKGJvLT5mbGFn
cyAmIEFNREdQVV9HRU1fQ1JFQVRFX0RJU0NBUkRBQkxFKQ0KPiA+Pj4+PiArICAgICAgICAgICB2
bS0+c3RhdHNbdHlwZV0uZHJtLnB1cmdlYWJsZSArPSBzaXplOw0KPiA+Pj4+PiArDQo+ID4+Pj4+
ICsgICBpZiAoYm8tPnByZWZlcnJlZF9kb21haW5zICYgQU1ER1BVX0dFTV9ET01BSU5fVlJBTSkg
ew0KPiA+Pj4+PiArICAgICAgICAgICB2bS0+c3RhdHNbVFRNX1BMX1ZSQU1dLnJlcXVlc3RlZCAr
PSBzaXplOw0KPiA+Pj4+PiArICAgICAgICAgICBpZiAodHlwZSAhPSBUVE1fUExfVlJBTSkNCj4g
Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICB2bS0+c3RhdHNbVFRNX1BMX1ZSQU1dLmV2aWN0ZWQg
Kz0gc2l6ZTsNCj4gPj4+PiBBZ2FpbiB0aGF0IGlzIGluY29ycmVjdC4gQk9zIGNhbiBiZSBjcmVh
dGVkIHdpdGggVlJBTXxHVFQgYXMgdGhlaXINCj4gPj4+PiBwbGFjZW1lbnQuDQo+ID4+Pj4NCj4g
Pj4+PiBJZiBzdWNoIGEgQk8gaXMgcGxhY2VkIGludG8gR1RUIHRoYXQgZG9lc24ndCBtZWFuIGl0
IGlzIGV2aWN0ZWQuDQo+ID4+PiBJbiB0aGF0IGNhc2UsIGRvIHdlIGNvdW50IEJPIHdpdGggVlJB
TXxHVFQgaW4gYm90aCBWUkFNIGFuZCBHVFQncw0KPiA+Pj4gLnJlcXVlc3RlZCBmaWVsZD8gYW5k
IGlmIHRoZXkgYXJlIG5vdCBpbiBlaXRoZXIsIHRoZXkgZ28gaW4gYm90aA0KPiA+Pj4gLmV2aWN0
ZWQgZmllbGQ/DQo+ID4+DQo+ID4+IE9oLCBnb29kIHF1ZXN0aW9uIGRlcGVuZHMgb24gdGhlIGRl
ZmluaXRpb24gb2YgdGhlIHJlcXVlc3RlZCBmaWVsZC4NCj4gPj4NCj4gPj4gQWNjb3VudGluZyBp
dCB0byBWUkFNLmV2aWN0ZWQgd2hpbGUgR1RUIHBsYWNlbWVudCBpcyBkZXNpcmFibGUgYXMNCj4g
Pj4gd2VsbCBpcyBjZXJ0YWlubHkgbm90IGNvcnJlY3QuDQo+ID4+DQo+ID4+ICBGcm9tIG15IHVu
ZGVyc3RhbmRpbmcgdGhleSBzaG91bGQgZ28gaW50byB0aGUgVlJBTSByZXF1ZXN0LCBidXQgbm90
DQo+ID4+IGFjY291bnQgdG8gZXZpY3RlZC4gQnV0IFR2cnRrbyBtaWdodCBzZWUgdGhhdCBkaWZm
ZXJlbnRseS4NCj4gPg0KPiA+IFNlbWFudGljcyBvZiByZXF1ZXN0ZWQgYW5kIGV2aWN0ZWQgYXJl
IGtpbmQgb2YgYW1kZ3B1ICdsZWdhY3knIHRoaW5nLg0KPiA+IFNvIHRoZSBxdWVzdGlvbiBpcyB3
aGV0aGVyIG9yIG5vdCB0aGV5IHNob3VsZCBrZWVwIG1hdGNoaW5nLg0KPiA+IE9yaWdpbmFsbHkg
dGhleSB3ZXJlIGxpa2UgdGhpcyAoSSB3aWxsIGVkaXQgb3V0IHBhcnRzIHdoaWNoIGRlYWwgd2l0
aA0KPiA+IENQVSB2aXNpYmxlIGZvciBlYXNlIG9mIGNvbXBhcmlzb24sIGFuZCB3aGljaCBoYXZl
IHNpbmNlIGJlZW4gcmVtb3ZlZA0KPiA+IGFueXdheSk6DQo+ID4NCj4gPiAgICAgICAgaWYgKGJv
LT5wcmVmZXJyZWRfZG9tYWlucyAmIEFNREdQVV9HRU1fRE9NQUlOX1ZSQU0pIHsNCj4gPiAgICAg
ICAgICAgICAgICBzdGF0cy0+cmVxdWVzdGVkX3ZyYW0gKz0gc2l6ZTsNCj4gPiAgICAgICAgICAg
ICAgICBpZiAocmVzLT5tZW1fdHlwZSAhPSBUVE1fUExfVlJBTSkNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICBzdGF0cy0+ZXZpY3RlZF92cmFtICs9IHNpemU7DQo+ID4gICAgICAgICB9IGVs
c2UgaWYgKGJvLT5wcmVmZXJyZWRfZG9tYWlucyAmIEFNREdQVV9HRU1fRE9NQUlOX0dUVCkgew0K
PiA+ICAgICAgICAgICAgICAgIHN0YXRzLT5yZXF1ZXN0ZWRfZ3R0ICs9IHNpemU7DQo+ID4gICAg
ICAgICB9DQo+ID4NCj4gPiBTbyB0aGUgcGFydCBhYm91dCBhY2NvdW50aW5nIGFzIGV2aWN0ZWQg
d2l0aCBkdWFsIHByZWZlcnJlZCBwbGFjZW1lbnQNCj4gPiB3YXMgdGhlcmUgZnJvbSB0aGUgc3Rh
cnQuDQo+ID4NCj4gPiBUaGVuIGFmdGVyIG15IGNoYW5nZXM6DQo+ID4NCj4gPiAgICAgICAgIGlm
IChiby0+cHJlZmVycmVkX2RvbWFpbnMgJiBBTURHUFVfR0VNX0RPTUFJTl9WUkFNKSB7DQo+ID4g
ICAgICAgICAgICAgICAgIHN0YXRzW1RUTV9QTF9WUkFNXS5yZXF1ZXN0ZWQgKz0gc2l6ZTsNCj4g
PiAgICAgICAgICAgICAgICAgaWYgKHR5cGUgIT0gVFRNX1BMX1ZSQU0pIHsNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICBzdGF0c1tUVE1fUExfVlJBTV0uZXZpY3RlZCArPSBzaXplOw0KPiA+
ICAgICAgICAgICAgICAgICB9DQo+ID4gICAgICAgICB9IGVsc2UgaWYgKGJvLT5wcmVmZXJyZWRf
ZG9tYWlucyAmIEFNREdQVV9HRU1fRE9NQUlOX0dUVCkgew0KPiA+ICAgICAgICAgICAgICAgICBz
dGF0c1tUVE1fUExfVFRdLnJlcXVlc3RlZCArPSBzaXplOw0KPiA+ICAgICAgICAgfQ0KPiA+DQo+
ID4gSSBtb3N0bHkga2VwdCB0aGUgc2FtZSBzZW1hbnRpY3MuDQo+ID4NCj4gPiBUZWRkeSdzIHZl
cnNpb24ga2VlcHMgaXQgdGhlIHNhbWU6DQo+ID4NCj4gPiAgICAgaWYgKGJvLT5wcmVmZXJyZWRf
ZG9tYWlucyAmIEFNREdQVV9HRU1fRE9NQUlOX1ZSQU0pIHsNCj4gPiAgICAgICAgIHZtLT5zdGF0
c1tUVE1fUExfVlJBTV0ucmVxdWVzdGVkICs9IHNpemU7DQo+ID4gICAgICAgICBpZiAodHlwZSAh
PSBUVE1fUExfVlJBTSkNCj4gPiAgICAgICAgICAgICB2bS0+c3RhdHNbVFRNX1BMX1ZSQU1dLmV2
aWN0ZWQgKz0gc2l6ZTsNCj4gPiAgICAgfSBlbHNlIGlmIChiby0+cHJlZmVycmVkX2RvbWFpbnMg
JiBBTURHUFVfR0VNX0RPTUFJTl9HVFQpIHsNCj4gPiAgICAgICAgIHZtLT5zdGF0c1tUVE1fUExf
VFRdLnJlcXVlc3RlZCArPSBzaXplOw0KPiA+ICAgICB9DQo+ID4NCj4gPiBJZiBubyBBTUQgdG9v
bHMgZGVwZW5kIG9uIHRoZSBsZWdhY3kgc2VtYW50aWNzIGZvciBldmljdGVkL3JlcXVlc3RlZA0K
PiA+IHdlIGNhbiBjaGFuZ2UgdGhlbS4gVGhlcmUgaXMgc29tZSBvdmVybGFwIHdpdGggdGhlIHN0
YW5kYXJkIGtleXMNCj4gPiBhbnl3YXkgYW5kIHRoZSBmYWN0IHByZWZlcnJlZCBtYXNrIGlzIHVu
b3JkZXJlZCBtYWRlIHRoZSBvcmlnaW5hbA0KPiA+IGJlaGF2aW91ciBhIGJpdCBwcmVzdW1wdHVv
dXMgdG8gYmVnaW4gd2l0aC4gSW4gc3VtbWFyeSBJIHRoaW5rIGl0DQo+ID4gZGVwZW5kcyBvbiB3
aGV0aGVyIHdlIG5lZWQgdG8ga2VlcCB0aGUgbGVnYWN5IHNlbWFudGljcywgb3IgZXZlbiB0aGUN
Cj4gPiBrZXlzIHRoZW1zZWx2ZXMuDQo+DQo+IEFzIGZhciBhcyBJIGtub3cgd2UgZG9uJ3QgaGF2
ZSBhbnkgZGVwZW5kZW5jeSBvbiB0aGUgYW1kZ3B1IHNwZWNpZmljIGtleXMuDQo+DQo+IEJ1dCBJ
IG5lZWQgdG8gZG91YmxlIGNoZWNrIHdoYXQgZHJtLXVzYWdlLXN0YXRzLnJzdCBhY3R1YWxseSBk
ZWZpbmVzLg0KPiBNYXliZSB0aGF0IGRvZXNuJ3QgcmVhbGx5IG1hdGNoIHdoYXQgd2UgaGF2ZSBp
biBhbWRncHUgYW5kIG90aGVyIFRUTSBkcml2ZXJzIGFzDQo+IGluZm9ybWF0aW9uLg0KPg0KPiBU
aGFua3MsDQo+IENocmlzdGlhbi4NCg0KSWYgd2UgZ28gd2l0aCB0aGUgYWJvdmUgZGVmaW5pdGlv
biBmb3IgZHJtLXRvdGFsLSwgSSBjYW4gY2hhbmdlIHRoZSBhbWQtcmVxdWVzdGVkLSBmaWVsZHMg
dG8ganVzdCBtaXJyb3IgZHJtLXRvdGFsLSwgYW5kIGhhdmUgYW1kLWV2aWN0ZWQtdnJhbSBjaGVj
ayAicHJlZmVycmVkX2RvbWFpbnMgJiBhbWRncHVfbWVtX3R5cGVfdG9fZG9tYWluKG1lbXR5cGUp
ID09IDAiLCB0aGF0IHNob3VsZCBjb3ZlciBpdD8NCg0KVGVkZHkNCg0KPiA+DQo+ID4NCj4gPiBS
ZWdhcmRzLA0KPiA+DQo+ID4gVHZydGtvDQo+ID4NCj4gPj4+Pj4gQEAgLTI2MTIsNyArMjcwNyw2
IEBAIHZvaWQgYW1kZ3B1X3ZtX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gPj4+Pj4gKmFk
ZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtKQ0KPiA+Pj4+Pg0KPiA+Pj4+PiAgICAgIHJvb3QgPSBh
bWRncHVfYm9fcmVmKHZtLT5yb290LmJvKTsNCj4gPj4+Pj4gICAgICBhbWRncHVfYm9fcmVzZXJ2
ZShyb290LCB0cnVlKTsNCj4gPj4+Pj4gLSAgIGFtZGdwdV92bV9wdXRfdGFza19pbmZvKHZtLT50
YXNrX2luZm8pOw0KPiA+Pj4+PiAgICAgIGFtZGdwdV92bV9zZXRfcGFzaWQoYWRldiwgdm0sIDAp
Ow0KPiA+Pj4+PiAgICAgIGRtYV9mZW5jZV93YWl0KHZtLT5sYXN0X3VubG9ja2VkLCBmYWxzZSk7
DQo+ID4+Pj4+ICAgICAgZG1hX2ZlbmNlX3B1dCh2bS0+bGFzdF91bmxvY2tlZCk7IEBAIC0yNjYw
LDYgKzI3NTQsMTUgQEAgdm9pZA0KPiA+Pj4+PiBhbWRncHVfdm1fZmluaShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwNCj4gPj4+PiBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSkNCj4gPj4+Pj4gICAg
ICAgICAgICAgIH0NCj4gPj4+Pj4gICAgICB9DQo+ID4+Pj4+DQo+ID4+Pj4+ICsgICBpZiAoIWFt
ZGdwdV92bV9zdGF0c19pc196ZXJvKHZtKSkgew0KPiA+Pj4+PiArICAgICAgICAgICBzdHJ1Y3Qg
YW1kZ3B1X3Rhc2tfaW5mbyAqdGkgPSB2bS0+dGFza19pbmZvOw0KPiA+Pj4+PiArDQo+ID4+Pj4+
ICsgICAgICAgICAgIGRldl93YXJuKGFkZXYtPmRldiwNCj4gPj4+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgIlZNIG1lbW9yeSBzdGF0cyBmb3IgcHJvYyAlcyglZCkgdGFzayAlcyglZCkNCj4gPj4+
Pj4gaXMgbm9uLXplcm8NCj4gPj4+PiB3aGVuIGZpbmlcbiIsDQo+ID4+Pj4+ICsgdGktPnByb2Nl
c3NfbmFtZSwgdGktPnBpZCwgdGktPnRhc2tfbmFtZSwgdGktPnRnaWQpOw0KPiA+Pj4+PiArICAg
fQ0KPiA+Pj4+PiArDQo+ID4+Pj4+ICsgICBhbWRncHVfdm1fcHV0X3Rhc2tfaW5mbyh2bS0+dGFz
a19pbmZvKTsNCj4gPj4+PiBQbGVhc2UgZG9uJ3QgbW92ZSB0aGUgY2FsbCB0byBhbWRncHVfdm1f
cHV0X3Rhc2tfaW5mbygpLg0KPiA+Pj4gSXMga2VlcGluZyB0aGUgdGFza19pbmZvIGFsaXZlIGEg
aGF6YXJkIGhlcmU/IEkgY291bGQgY29weSBvdXQgdGhlDQo+ID4+PiBpbmZvLCBpdCBqdXN0IHNl
ZW1lZCBhIGJpdCB3YXN0ZWZ1bC4NCj4gPj4NCj4gPj4gQWgsIG5vdyBJIHNlZSB3aHkgeW91IGhh
dmUgbW92ZWQgdGhhdC4NCj4gPj4NCj4gPj4gSUlSQyB3ZSBuZWVkIHRvIGZyZWUgdXAgdGhlIHRh
c2sgaW5mbyBiZWZvcmUgcmVsZWFzaW5nIHRoZSBQQVNJRCwgYnV0DQo+ID4+IHRoYXQgaW5mbyBt
aWdodCBiZSBvdXRkYXRlZC4gTmVlZCB0byBjaGVjayB0aGUgY29kZS4NCj4gPj4NCj4gPj4gRG9l
cyBpdCB3b3JrIGlmIHlvdSBtb3ZlIHRoZSBtZXNzYWdlIGZ1cnRoZXIgdXAgb3IgZG9lcyB0aGUg
cm9vdCBQRA0KPiA+PiB0aGVuIGJyZWFrIHlvdXIgbmVjayBiZWNhdXNlIGl0IGlzbid0IHJlbGVh
c2VkIHlldD8NCj4gPj4NCj4gPj4gVGhhbmtzLA0KPiA+PiBDaHJpc3RpYW4uDQo+ID4+DQo+ID4+
Pg0KPiA+Pj4gUmVnYXJkcywNCj4gPj4+IFRlZGR5DQo+ID4+DQoNCg==
