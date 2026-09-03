Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBADC624A4
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 09:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB3BE10E397;
	Thu,  3 Sep 2026 09:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nQobaPNh";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013009.outbound.protection.outlook.com
 [40.93.196.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A19D110E397
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 09:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdEueUriFQegUxjalJpDLBze4yFHJ1QfSTBqnSdrVSjdN8rE5T19kQ31WQB+2u/3fLnNI5QdFpVgzL9ngSqrO7bq0xxM3tfsfRH0u+qvs+Ni+j62LgBrEKlV/gidEuV5T02fFSf/4GmJxDdWCnkBerLnvnWIdqg+Y/qJR51C+7/gT4ghLVmfgPIn+a1fAFt2ocknvwQWYhxZRHOgxU9HeVKQ88AmCDRWi1PrHjvGaAql0FgEPW+fW6vxoWYNAEmZd17+x77gRqWkiSeqCTdSXTzOOMlvvMYoF0O44SXkvC5+W9I8uDlPtd77eg6B6V596LIVW/TiE/B1zJZOip0chA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fscVGQz/hwq7QswGqlE1qW95PyVXlQGJ3guw/IG2PhI=;
 b=pkgesX6gOw0eGvM3248wdDNoxow54Gq9MEd7+LBZNvwSAmZWueCpwIxx4R+krZ3Zpbs37GfkVQ1tIKwrUuYaVAfK5QqaqnsCvrXT7C33cTQ51nv1hffP/9777hjMjPQJ3rwSStylr00RRl4BQ6eIYxDXq8F4EOEtJzSLtr7m5SrKKY4oAmgl2gMomgbLlk+QfvsrXRKNPJf1d4N/GNLyPtGl/N2YDJZJ7/pyS9kHt8E2W4TCsShmoO3xzlocJxcdb8eAwqojRB2gm9Ml1P0jhVrFpnSJjGWadT9kc3+Gqx6Lm1rtnD6F6/Ds6+WWUZNEXfuR42ImuynO4GYKwTpStg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fscVGQz/hwq7QswGqlE1qW95PyVXlQGJ3guw/IG2PhI=;
 b=nQobaPNh6YK1zRimQ30EG8/HYfq8XGHXVHEfRfAIvyDVrVcDxNsI+f83kMWToUL5Qz+tTJQFUwuQHjTwwKBJ6YeviJ3+UPmKkoIsY2dqAnp9IpUKLQ+xXSoKTroOpC4xvLZrtbFhgueGVn8knVckfF9iqNmI/dMW1jStqgc886E=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS0PR12MB6437.namprd12.prod.outlook.com (2603:10b6:8:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 09:34:22 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 09:34:22 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC PATCH 1/2] drm/amdgpu: Add kernel VMID trap handler
 infrastructure
Thread-Topic: [RFC PATCH 1/2] drm/amdgpu: Add kernel VMID trap handler
 infrastructure
Thread-Index: AQHdOuzHydv2vk0tFU2FDBmX3LtZaba7abOAgAAG84CAAATxgIAADCYAgAC6cICAAABbgIAAM8+AgAAm0JA=
Date: Thu, 3 Sep 2026 09:34:22 +0000
Message-ID: <IA0PR12MB82084C2DC47DCA5C20CE4E5D90B62@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260902150656.183333-1-srinivasan.shanmugam@amd.com>
 <20260902150656.183333-2-srinivasan.shanmugam@amd.com>
 <ae477cda-c0be-4a26-8aa4-95a836500e7c@amd.com>
 <IA0PR12MB8208E904460F474C4975950690B72@IA0PR12MB8208.namprd12.prod.outlook.com>
 <SA0PR12MB70916914036CA157754EAAC497B72@SA0PR12MB7091.namprd12.prod.outlook.com>
 <BN9PR12MB514657D40AC8B41594720A93F7B72@BN9PR12MB5146.namprd12.prod.outlook.com>
 <f2755b35-ef95-4067-b5bd-0a37ee1df457@amd.com>
 <de1313dc-62bb-42b6-a22e-4775260fd680@amd.com>
 <325f20ff-7944-4295-8d69-ad7f14c69c33@amd.com>
In-Reply-To: <325f20ff-7944-4295-8d69-ad7f14c69c33@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-03T09:27:56.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|DS0PR12MB6437:EE_
x-ms-office365-filtering-correlation-id: a44994b0-b450-4c93-0e5a-08df099e893f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: XfmP3jf+E41diHVPzs3tvTggfOi68BxboKxTS7ThfbVprGLsQWP8W3PQiGEF9DNXyP9ObjoIm0aGCvFC0t7IbrJAYO6tm5PcyO3Jn2Fpa4b66zL062Tyw5ZAeSsYzxY95wrsAyFptiY6slKVvLMm4ann+o5MiatlNULpJ/jUzU/6KejugckOAYsLMUpUJyVXyri+nz55fvoZCzW7h2K8JPudhtPoVCghyy6bf04RjkCyUijm7t9gWAhjITcgu06AEqiu2HuRelOb0pOaI5Y1q8Ga0Ct8PSYAxEu00HrHQgTJzdUh64JeEuZFrxApEAXSzqNT3yi5FIsXe14Nl/JguCY+I7aCUKN1iUW/HMHfcLBrWnJoUEXD1CEAKzn0euSvcXhYDD65PaT+YmSZqBr+1TzU0hBXYDVHSKjMCSu+/FNnJ05dlmTUneyE4JgMfr19T5rChnflUvDjUNMt/m4g4cc8MTGdmhV7VtGv1cgs9i2BnbWEZHN5t/RlLrUrJO//nozrj5Ditvppq+CM03hVIOti0dAIB/t3/Ge7TTnNdJXV029Gu8Ccs48KmE4pqRQyLcg2xOfuuhC3lcIkVLJ2Wbq2y/KzBO3iyff14UiitWBtkGv5yh5sCCJr8WN3A1Ne2shey2LCVKfIM/of3sqEyaMa47UyIHElJUzasAlrSJpyQDY/VOzsrQ0T9CF4BqdV+O+p/ic1CeyTBm3na277a8yOX5METiS9xmRfefPPEPs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk5TZVRrM252ODAzUmIzUnlRWDgyR0xJczlKZks2dUlEWXRFdjR1L2p3a3Ex?=
 =?utf-8?B?bDhpUjR0U1luMGlXdU1PcmtpV1Y0Vm4wV3JFby9UcHRRbnhWeWV6Umw3WElY?=
 =?utf-8?B?aXpGR3dVU3BRNVZDWE1MZ3VNUGZkYjlSemFtWDNBaDRtQytJaXE1NzN2WjAr?=
 =?utf-8?B?bTVhaGRRcGVYbVFEaUlXc3lBL1VveHJMMWg0VVFHMnpZRzhLTDczYzVBVWZR?=
 =?utf-8?B?a3JuY0V0MVZXRVJpWVpURGhUSmFydVZVT1JOZXpsRzBORmhtOHBNVS91S0Js?=
 =?utf-8?B?NmlVYlRtOHBzdDZNcDAxb2lZdDhXTFlQL0tFd3ljS3Z1dXMzdnhtM3N6eXhD?=
 =?utf-8?B?STNtbXpUSllVeEgxOThqOCsyZ0R3UElLZlBzaXlENmhvbDhGS0k1RmxKMzIz?=
 =?utf-8?B?WFI2RTZldVR1TmtkQlMzSXdsOHYySlQ1c1RTdUwrRlI1cEZNOFgrOTQ0YmFZ?=
 =?utf-8?B?RlNYeDRBR3BKYjhrS1JXOW5hZXpMSlJnVk9lOHhaSEQ3dmxOS05FdmxTV1lQ?=
 =?utf-8?B?ZFdqVlYydktYZ2pFWGJkclQ3Q1Y3T3AzNWNabkQ2dXczb2pFWWlvdnR3OHUz?=
 =?utf-8?B?NTFNUXh6RWZ1TnhkRXVCUE1QSjRWNnFDZnQ1RnNQSitkRk81QzNkT0tEMzd1?=
 =?utf-8?B?ZkN5Um9GckJKaDlTL2EzelNHSWN3L0x6aldKU280c3pCQkIwT0NkVDhGTHVB?=
 =?utf-8?B?bEhHc0tTaTBnQ1N0QzRmd0pHTmNWenBiUVUxanBqQkx1dWtzRGY2aE1UUjg2?=
 =?utf-8?B?RlV1T0ZMVzZUVVhBek9DMStMUTRlV2RWQm1uRWkxbGVoL2ZXaHFSVVZ2MTNi?=
 =?utf-8?B?ejVQQktyUHA4enpTeXl4Vm51ZFY0dTJwUzdQOGErOGpURGNpeGYwVE5TRC9u?=
 =?utf-8?B?SlIzMFFuZWFJaHNZV2lqUDdTYno0czlHUHd4UjJQbTE4TU5GcUtnRU54anRY?=
 =?utf-8?B?WGpVUnZXNVZTSE9oS2JFc0owbnJLYmI1OHNUWnFtS3RHeEx3T1IyT2g2ZzZU?=
 =?utf-8?B?enFoNkxucWNKL3l4YmQvZ2E1VXBaeDhQSnBPQXVuYzc5RUczbGhidlU3bDdR?=
 =?utf-8?B?UVBJN0dXMDRNcW53TFMrdlcwVFpvRzhIUVZXMkZ2K281dkZjbXh2NW0rWmUr?=
 =?utf-8?B?ekpQelRuNGlkL2tJL0VxYVVnQVQ2TUZQY05yQjhiZXdDTk5SeVc0ODlQb3Uw?=
 =?utf-8?B?QmZCamUyVGdEUmpScXdUVVM4OWJjcFQxdmVHUnZlRzR3ZFRSRnZoQUlzNUNj?=
 =?utf-8?B?dlBNQW9WNy9iYjlRdXNPVC9OTm9BUk5mSDhZb01Od05FZWVxRWhNSFc4Nk1i?=
 =?utf-8?B?ZjZYek5sZENpbkZvOHhmY0VHNzNDSWhHZHFkdHNwRnJraVpSOVBiendLZE5Q?=
 =?utf-8?B?Qmd2UEU5N1IxRTNVVk1qK1pjMzVabEV5ZkoxV3VxTHN3S3JNQldFZmhSL2Ru?=
 =?utf-8?B?L1NRbStuMy83a2tOSjdCelZqUEVJRHpGUnhYZDhBWHhlSWY1Tk5RemFUc255?=
 =?utf-8?B?YVB6OE1oRFgvYW84K1NQUmk0STlqVjNkL1dhU0txaWRnRU51NHVuVnVXQzFH?=
 =?utf-8?B?OHhVL2pPNmpQN0tmOGQydGFqR3Rkb0Zoa2VuS3ZWQkV1S3ZvUlNpTUcxQkc0?=
 =?utf-8?B?Q1E0bXZqV29xUWRCaTFtVVZ3THplVlEyRU9NUEFIV1NkMnFHMTAxeVkrL29C?=
 =?utf-8?B?T1RXMzYvWGJDTno3WE5IcE1raWNkZGhMQVlCVnE1WWxrRndOYWZEQXN6bEVY?=
 =?utf-8?B?NmdJNmdDUklKQmlXeW9qWC9mV0VLamhZc054TFYzYTRHMmdHSlFieUNKL0xY?=
 =?utf-8?B?V1BzcmVNS0lNSlBKMGRJbjllRUU1SmRLSVVSNjM0RFp0Ui9hUUN4RFVBdzhC?=
 =?utf-8?B?NTBES0VXWC84cnZkK1dqUzJkdHhkbWxjNDlZbmY2amhibnd5cHhZckZDQ0t4?=
 =?utf-8?B?TkZDY0NWclQxNGQ0MjEveGx3bDRMU2VSc0hzWWNLSnRyUDVjZUhCTDhvaUp2?=
 =?utf-8?B?ZUF2YzdydElmdVJ4QWhZVVl2VUMvZnB1cU54TzY4TUdlNTRvMkhwdDhyVy9C?=
 =?utf-8?B?YUdQZmFFYkxnYllkVWN2a0lINFluM0pWOHhrYzYyNTBmZXl4L0pZY2JIazU3?=
 =?utf-8?B?dDhxRUJPTlFHQi8rTUxNUlE0T0kya0dqMlBZOWhrTnYvQmxJeDRNTnNIUFd1?=
 =?utf-8?B?V1RjTHdzbU5nWnN0Tndpbi9aYzUxNlJQK0FOUnhVTzMrSmg2TUNNZ3ZzWm5V?=
 =?utf-8?B?aVF1OWlQMkxLVFNVZ3RrWjJJZXVUZFhkaWhyRG04eVlVNEREbENDT3E4bmVz?=
 =?utf-8?Q?8679wuAO8Qcv4s0QlJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44994b0-b450-4c93-0e5a-08df099e893f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 09:34:22.1001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TTFFK9DeP5xufGl7B5Xf4YMGHJm3ai2Tir5PUIG5Vq+y6PdRbIu6cmqLwKn2gElTtEROIwfQlq0I/i2P9+y+8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6437
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgU2VwdGVtYmVyIDMsIDIwMjYgMTI6MzkgUE0NCj4gVG86IExhemFyLCBMaWpvIDxMaWpvLkxh
emFyQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+OyBTSEFOTVVHQU0sIFNSSU5JVkFTQU4NCj4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFt
ZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1JGQyBQQVRDSCAxLzJdIGRybS9hbWRncHU6IEFkZCBrZXJuZWwgVk1JRCB0cmFwIGhhbmRs
ZXINCj4gaW5mcmFzdHJ1Y3R1cmUNCj4NCj4gT24gOS8zLzI2IDA2OjAzLCBMYXphciwgTGlqbyB3
cm90ZToNCj4gPg0KPiA+DQo+ID4gT24gMDMtU2VwLTI2IDk6MzIgQU0sIExhemFyLCBMaWpvIHdy
b3RlOg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAwMi1TZXAtMjYgMTA6MjUgUE0sIERldWNoZXIsIEFs
ZXhhbmRlciB3cm90ZToNCj4gPj4+IFB1YmxpYw0KPiA+Pj4NCj4gPj4+DQo+ID4+PiBGb3Iga2Vy
bmVsIHF1ZXVlcyBlYWNoIElCIGV4ZWN1dGVzIHdpdGggYSBrZXJuZWwgcHJvdmlkZWQgdm1pZCBh
c3NpZ25lZA0KPiBkeW5hbWljYWxseSBieSB0aGUga2VybmVsIGRyaXZlci4NCj4gPj4+DQo+ID4+
DQo+ID4+IEluIHRoaXMgY2FzZSwgaXQncyBhIGRldmljZSBsZXZlbCBUTUEgJ2txX3RtYV9ibycg
Zm9yIGZpcnN0IGxldmVsLiBUaGF0IGFkZHJlc3MgaXMNCj4gcHJvZ3JhbW1lZCBpbiBTUSByZWdp
c3RlcnMuIFdoZW4gYSBqb2IgaXMgc3VibWl0dGVkLCB0aGUgc2Vjb25kIGxldmVsIGhhbmRsZXIg
aXMNCj4gcGlja2VkIGZyb20gd2hhdCBpcyBwcm9ncmFtbWVkIGluIGtxX3RtYV9iby4gRG8geW91
IG1lYW4gdG8gc2F5IHRoYXQgZHJpdmVyIHdpbGwNCj4gY2hhbmdlIHRoYXQgdmFsdWUgZHluYW1p
Y2FsbHkgYmFzZWQgb24gd2hhdCBpcyBwcm92aWRlZCBieSB1c2VyPw0KPiA+DQo+ID4gRG8geW91
IG1lYW4gdG8gc2F5IHRoYXQgZHJpdmVyIHdpbGwgY2hhbmdlIHRoYXQgdmFsdWUgZHluYW1pY2Fs
bHkgYmFzZWQgb24gd2hhdA0KPiBpcyBwcm92aWRlZCBieSB1c2VyIGZvciBlYWNoIGpvYiBzdWJt
aXNzaW9uPw0KPg0KPiBZZWFoIEkgYWdyZWUgd2l0aCBMaWpvLCBzb21ldGhpbmcgZG9lc24ndCBh
ZGRzIHVwIGhlcmUuDQo+DQo+IEFzIGZhciBhcyBJIGtub3cgdGhlIHNhbWUgcmVnaXN0ZXIgdmFs
dWUgaXMgdXNlZCBmb3IgYm90aCBncmFwaGljcyBhbmQgYWxsIGNvbXB1dGUNCj4gcXVldWVzIGF0
IHRoZSBzYW1lIHRpbWUsIHNvIGNoYW5naW5nIHRoaXMgZHluYW1pY2FsbHkgb24gZWFjaCBzdWJt
aXNzaW9uIHdvbid0DQo+IHdvcmsgKGF0IHVubGVzcyB3ZSBjb21wbGV0ZSBpc29sYXRlIHRoZSBh
cHBsaWNhdGlvbnMpLg0KPg0KPiBJZiBJJ20gbm90IGNvbXBsZXRlbHkgbWlzdGFrZW4gd2UgZWl0
aGVyIG5lZWQgYWxsb2NhdGUgYSBCTyBwZXIgVk0gYW5kIGFsd2F5cw0KPiBtYXAgaXQgYXQgdGhl
IHNhbWUgbG9jYXRpb24gb3IgZ2l2ZSB0aGUgbG9jYXRpb24gdG8gdXNlcnNwYWNlIHNvIHRoYXQg
dXNlcnNwYWNlIHNvDQo+IHRoYXQgdGhlIFVNRCBjYW4gbWFwIGl0Lg0KPg0KPiBJIGRvbid0IHRo
aW5rIHdlIGhhdmUgZGlzY3Vzc2VkIHdoYXQgdGhlIGFjdHVhbCBwbGFuIGZvciB0aGF0IHdvdWxk
IGJlLg0KDQoNCkFncmVlZCDigJQgd2UgY2Fubm90IHJlcHJvZ3JhbSBTUV9TSEFERVJfVE1BIHBl
ciBqb2Igc3VibWlzc2lvbi4gU2luY2UgaXQgaXMgYSBwZXItVk1JRCByZWdpc3RlciwgaXQgY292
ZXJzIGFsbCBxdWV1ZXMgaW4gdGhhdCBwcm9jZXNzIGF0IHRoZSBzYW1lIHRpbWUuIFN3YXBwaW5n
IGl0IHBlciBqb2Igd291bGQgY29ycnVwdCBvdGhlciBydW5uaW5nIGFwcHMuDQoNCkZvciB2Miwg
Y2FuIHdlIGRvIHNvbWV0aGluZyBsaWtlIHRoaXM/Og0KDQoxLiBVc2Vyc3BhY2UgYWxsb2NhdGVz
IGEgVE1BIEJPIHdpdGggVk1fQUxXQVlTX1ZBTElEIHNvIGl0IGlzIG5ldmVyIGV2aWN0ZWQgb3Ig
bW92ZWQNCjIuIFVzZXJzcGFjZSBwYXNzZXMgdGhlIFRNQSBHUFUgVkEgdG8gdGhlIGRyaXZlciB2
aWEgdGhlIFZNIGlvY3RsDQozLiBEcml2ZXIgdmFsaWRhdGVzIHRoYXQgdGhlIEJPIGhhcyBWTV9B
TFdBWVNfVkFMSUQsIHRoZW4gcHJvZ3JhbXMgU1FfU0hBREVSX1RNQSBvbmNlDQo0LiBCZWZvcmUg
cHJvZ3JhbW1pbmcsIGRyaXZlciBldmljdHMgYWxsIHF1ZXVlcywgZmx1c2hlcyBUTEIsIHdyaXRl
cyB0aGUgcmVnaXN0ZXIsIHRoZW4gcmVzdG9yZXMgcXVldWVzDQo1LiBUQkEgYW5kIFRNQSBHUFUg
VkEgYXJlIHN0b3JlZCBpbiBhbWRncHVfdm0gYW5kIGNsZWFyZWQgd2hlbiBWTSBpcyBkZXN0cm95
ZWQgb3IgQ0xFQVIgaXMgY2FsbGVkDQoNCkZvciBrZXJuZWwgcXVldWVzOg0KDQpDYW4gd2UgcmV1
c2UgdGhlIHNhbWUgdXNlcnNwYWNlLXJlZ2lzdGVyZWQgVE1BIEJPIGZvciBrZXJuZWwgcXVldWVz
IGFzIHdlbGw/IFNpbmNlIHRoZXJlIGlzIG9ubHkgb25lIFNRX1NIQURFUl9UTUEgcmVnaXN0ZXIg
cGVyIFZNSUQsIGEgc2VwYXJhdGUga2VybmVsLWludGVybmFsIEJPIHdvdWxkIGNvbmZsaWN0IHdp
dGggd2hhdCB1c2Vyc3BhY2UgcmVnaXN0ZXJlZC4gVGhlIHVzZXJzcGFjZSB0cmFwIGhhbmRsZXIg
c2hhZGVyIGFsc28gbmVlZHMgdG8gZmluZCBpdHMgb3duIFRNQSB0byB3b3JrIGNvcnJlY3RseS4N
Cg0KSWYgYSBrZXJuZWwgcXVldWUgaXMgY3JlYXRlZCBiZWZvcmUgdXNlcnNwYWNlIHJlZ2lzdGVy
cyB0aGUgVE1BLCB0aGUgZHJpdmVyIHNpbXBseSB3YWl0cyDigJQgc2Vjb25kLWxldmVsIGhhbmRs
ZXIgYWN0aXZhdGVzIG9ubHkgYWZ0ZXIgdXNlcnNwYWNlIGNhbGxzIHRoZSBWTSBpb2N0bC4gRmly
c3QtbGV2ZWwgaGFuZGxlciBjb250aW51ZXMgdG8gd29yayBpbiB0aGUgbWVhbnRpbWUuDQoNClNo
b3VsZCB0aGUgVE1BIEJPIGxpdmUgaW4gVlJBTSBvciBHVFQ/IFZSQU0gZ2l2ZXMgZmFzdGVyIEdQ
VSBhY2Nlc3MgZHVyaW5nIGEgdHJhcC4gR1RUIGlzIGVhc2llciB0byBtYW5hZ2UgKGEgdHJhcCBo
YW5kbGVyIHJ1bnMgaW5mcmVxdWVudGx5IChvbmx5IG9uIHNoYWRlciBleGNlcHRpb24pIGFuZCBh
IHRyYXAgY2FuIGZpcmUgYW55dGltZSB1bmRlciBtZW1vcnkgcHJlc3N1cmUsIGFuZCBhIGV2aWN0
ZWQgVE1BIGlzIHdvcnNlIHRoYW4gYSBzbG93IFRNQS4pDQoNCkJlc3QgcmVnYXJkcywNClNyaW5p
DQouDQo=
