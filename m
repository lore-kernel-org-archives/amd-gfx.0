Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51865C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 21:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B62AC10E81D;
	Thu,  8 Aug 2024 21:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5H+rQY+f";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1077710E81D
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 21:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKjUo0RBEoZ4jMthGRDZ79nTWM03IQcFSoaBtPxoXg7u4bW3NIfwvR92PZcvyYMK72k5zSC36nsl4+9YFHlajcT08FFTn4gQI2RkTkukkb6dYj5dmw8JLUkMhfMR1hGHD9x5mnPIdkUZurg1q0I51i8RaxLtEUZg5uOx7ub/Qsx8dHVYPQ5ik474DB/bACIyEwyS8yzN70amg9M4Su7qmcdDQc8SG/I82c7wKAEL+zAshFW2U4c0qRHvT+drfwItz+LemSmlmscfH2RGm8aE1GMm/qv5s4yg3vGjrwCsqimkL1Qh1Jrzp0p9z0IqvB3gZ59+YKg3uYkpQgE1x5UmKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmpFEBYpwOIT1924fTxz3gJMQyHdlHkkc2q/eNfQMXE=;
 b=v2C8RPsKSnvlwyTFBu+bwP/VfXr5SnwUBvbFn0MVctp584ROAvBjtwMAHNh22IvouVpQZ1VkG6UYvUHvUvDtDix6eEDv/5triF3ppvtoxvs6GDi79y2CUbw9r5TCmC8tmxSNOZOezzN70Ycyi0J9DyAWfqXAsob22Ir+eCouV+zSuJx1wU5Ewk0GXMX3Kgd3p8u3qoaNkrivHDw/afoAQ7vLTu3XMwoPKfOHi7aw81e+nn6dCo2dSBfoqpz8XDxVIrV7N59Hw/08/bOPN1mLDA8Hanmz7GIF3X0fheWw0szqiU/bhGYa4G/JAKArx1Ts3JggGkFJDbDEOOkyj0TH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmpFEBYpwOIT1924fTxz3gJMQyHdlHkkc2q/eNfQMXE=;
 b=5H+rQY+fjP8x3tmt3jf0gNM6B3tAPnMZgqu7uQlyBcCesSXgBAn6WPU84EYVUi4Zdqo7TaGqg3nIl133pm045OPlRLGF1EJQLWcXU3bZcLsUS99Ufv0YrvI7w41Efe9Ab4k+GwoNOJ5a7F1jDvCvFWkhbPz5dygx7COBAD0ghUY=
Received: from SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20)
 by SN7PR12MB7856.namprd12.prod.outlook.com (2603:10b6:806:340::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Thu, 8 Aug
 2024 21:33:25 +0000
Received: from SJ1PR12MB6292.namprd12.prod.outlook.com
 ([fe80::745c:1e06:be67:94af]) by SJ1PR12MB6292.namprd12.prod.outlook.com
 ([fe80::745c:1e06:be67:94af%2]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 21:33:25 +0000
From: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Luo,
 Zhigang" <Zhigang.Luo@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Block MMR_READ IOCTL in reset
Thread-Topic: [PATCH] drm/amdgpu: Block MMR_READ IOCTL in reset
Thread-Index: AQHa6bsq3i6bpH3tbUa7uE4xhAtcbLIdwQ0AgAAesrA=
Date: Thu, 8 Aug 2024 21:33:25 +0000
Message-ID: <SJ1PR12MB62927A1D7AEE22A419EF41828BB92@SJ1PR12MB6292.namprd12.prod.outlook.com>
References: <20240808174808.854282-1-victor.skvortsov@amd.com>
 <CADnq5_PJamzCwdzo9XrRkr8QrfeM_1ePzEzxd=MJPC+Me8ah8Q@mail.gmail.com>
In-Reply-To: <CADnq5_PJamzCwdzo9XrRkr8QrfeM_1ePzEzxd=MJPC+Me8ah8Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9ccd7293-53fc-409e-b513-e5cf67d5dc0e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-08T21:26:17Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6292:EE_|SN7PR12MB7856:EE_
x-ms-office365-filtering-correlation-id: 63f8758a-3f9d-48b5-7206-08dcb7f1bc54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V0QxUjJpckJyNGV2ejI0c2V2SmYzSnNGdmxFaUFSOU1NMUxZSEJ2MXdhVUlC?=
 =?utf-8?B?SS9KZjhpTDBtRHdHZEE5Qmlvdnp1MUtULzlNeGtMOE01N0c2NWR5REIrbkhp?=
 =?utf-8?B?NXk4NEIzVDlaeE9vdEszVFp4L0pJQU4xK0liMnVPQUt6Vk05dFpOQkExYytO?=
 =?utf-8?B?RmJINis3bVdKUmdaNXRoL2wwcFgzb0VBRjhCbjFiRlZLc3JQeUhwVTVEMGVY?=
 =?utf-8?B?K04rTEE5Z3Nxelh0a3NQT0l3Lzd4V01zd1Q2bUdyNXRvelFHWTNTZXhKaHly?=
 =?utf-8?B?ZDRJRWJmMFQ4S0pYYzZETzhRUDVkc0VySWVtaElFTmlxNXNySEduWm1HM0ho?=
 =?utf-8?B?U1FOekVmNVNFbW9iUnB1K000TEhDYmFneXk2cEYwbnpXb1RKNEhoc1NpNmJC?=
 =?utf-8?B?ZDJ6N1lGQ2lMdUFwUzRTWGswSHU1NDJqR0hJWFpmTDZkdGFGUDRIWFowcVJY?=
 =?utf-8?B?Qk8ySlVUNzRrcnZkSHBoeFFFY0IvcmY4dmhMMmxVY2Y4WWZVdmVQZCtxeUhq?=
 =?utf-8?B?UGp5blU1eHlNWFlROURMRnROR3l3dWZETUJDWXJveVRPdWcreUpNb3AxWUNp?=
 =?utf-8?B?ZDg4OGJqc0NxQlhUZlY1OVd2RG93cUlaM0RQQlp0d2laSER2K2V0RnQ5MEVI?=
 =?utf-8?B?NVpRRHBPZDA1ZCtPaVZjYUNvMXRmem9DZVFEaU1iem1JMGttMTd3dWtNOHRz?=
 =?utf-8?B?bWFQckNETXpUTjEwWjBJVE90RDJXb1BvT29FN21kSml0Zi9qWG9tM1c2dDVE?=
 =?utf-8?B?bStMRlpSeDBWN3p5VVJUYWtHdS9JbGpoeWhqNTV6RTliYTVhemJoTndJTmxj?=
 =?utf-8?B?TTE4UTlnNUlNaytNb216Rm5kdlR4ZXkyN2tPR2w2TUtnMm04emM3QlY5a3U1?=
 =?utf-8?B?ZVk0QUdueGxHREJVNktBYndrNFhCSDUvVzlIdTh1cm5IS2RndkJycTEwTjhy?=
 =?utf-8?B?OGFCNG5JQ05weU0wVDNOTUxIRkg5M2VkYnVlS3RMdURNTmkwTmh2L21IYjNW?=
 =?utf-8?B?MlhVWCtJbHRxVFVpOW93eGFoZWJwbHJKcGlKS21QWnkrckxVSW14VGVIOUhQ?=
 =?utf-8?B?dUNCRVdGMC9DYXV2Y05FWi9Ma3FMOGdpZmFrVFVNbHhQTGxrM2Qwa29WNDZN?=
 =?utf-8?B?cjhvNGdpK0lQOVFxOTZqdlZuSCtWaWF4Mk45RmdXNHJMVmNtRHdXdE94ejRI?=
 =?utf-8?B?Mk5zL3VBY2t3YSt2Wm1lQWw1QUVZQzdUQkdIaTY4OGgwWXFwZVRDN0pTSVVs?=
 =?utf-8?B?WXVuQXBxUVVtdnlTczN0NnkvRE9OcUJudEcxY3d5UnR6eXVLNlR3dGJnUlJj?=
 =?utf-8?B?R3F0Ym9OVmxoaFFzVk4yZ2ZzNFh4THdXcXNWVlNiQ2wyQU9xdGhpWk5oWEx2?=
 =?utf-8?B?U0ZDSVhuT2J0RXNJMDVDL0VxKzc4MENSVm5NemlFSzJVUWMyTmlQZnMzUWRJ?=
 =?utf-8?B?b3dGejFKbXgxSXNnVGVVemdUaENXOExVbjZZQzJWWkU1cmJsaTQrQVpwY1pP?=
 =?utf-8?B?VW1HN2JlcnQyTEh0dW5LSmpDQkM0bHlKTGpnNkhRUVc3ZVkwWE9OcFZaMk80?=
 =?utf-8?B?a2VuZXdVZzQ1YWJZcDNyMXk1OTFEczJUZ0QxN3h5dXlZMUNjME5ONXJaeFJE?=
 =?utf-8?B?REVlcTFqTENOODZjMCtrRFUveDVvQjNFQ1hxc3VWTGM4S21RU0hzckw1Ti9y?=
 =?utf-8?B?ZVA5QWJraXRkMllGeDlqZkorUTZpV2V6SWVaajAxRUF6dmoxVEJmdmk0R1U5?=
 =?utf-8?B?bndwVG5LKzRadUZiLzEwUHkzL3o2U2xpMFVWOTdLa2pyUzJVWHRmYU5Na0J0?=
 =?utf-8?B?R1RCTW9mVmJwWThmdVJlT2hHOERDRHVnQ0pvcFJxUUNPTjN0OVdlREFYdDk2?=
 =?utf-8?B?dTNES3NBVmZGNnZicU1IMGNTcUlhU0pBT0tPN3RYRlE0Qnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6292.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VU1sL2FDbDFGeGNnUmRmZ3FzUlAyQlM4aVNaWnE2Y1J1WnRIcmpNYy9HRzRE?=
 =?utf-8?B?akMxR3JzczVzU3FpMExKd1JvLytHQlVwYSt2VGMvb2dtbW5aSENnSjZkb2s4?=
 =?utf-8?B?VlFBYXorZytWcTBYSnZ0SWpjRUlIVnU5MWVrUHgwaHF1WEZBcnc4cWYrallJ?=
 =?utf-8?B?VWZPZHIxc1YyMDFSaEtFOTZrM0J1UHp0ZjBqWlVxSXREQlF5VWx2MGtTbHJq?=
 =?utf-8?B?czhRUDZPaUlCYm8zeTd0dEQ4WWRYTHFoYjlNd2xjNzF0dzhaV2VkK1IzbGVs?=
 =?utf-8?B?UXZES2VRQmF5U2V1bTk5NWdVN0pyYXM3Q2gyek5zcVFFN0ttbSs4aG1SVWU0?=
 =?utf-8?B?L01pVU9aNEFZaDBXT0xybGlzL1NSbkJaZXg4MEducmxUaWsxU2RuTUdaaTBS?=
 =?utf-8?B?dis3c1ZuZ0FPdldDQXBTWk81a2F5UVAzSDcxaGovRS9OcE55dStjZy9RRHFt?=
 =?utf-8?B?c2Y5NDBaRGV2d3d3WW9yWlFaeVF5RWVDalU4OGhjdTJKREp0T29uVWJIKy82?=
 =?utf-8?B?ZjIyVEs2RG9xUUNnMFk3SWFCZ3F5cFpaZVk3N0dadkVkakFDemJkSjI1MDBk?=
 =?utf-8?B?OGZFaUU1ZzIzUlZaMC9kdlhHa3JzT0lQK1YzbmhzU2NXMTlQaHlKeC9vdzhF?=
 =?utf-8?B?c0FuUE4zRW80Y3B0aitjMGNiZEpuMGg5bmMxRmltNm9UdmhoaVFNWlFBMDRu?=
 =?utf-8?B?V0phNkJlYjVwWXY1c1d4eVNpSEFwM2J6cWdqRjlpTHdIcHBNaGV4cGd3ZW5N?=
 =?utf-8?B?c054NEh2M2RSTDNGNFZrQ1dUWmEydmpoMjhzNGcvTk12NE5NS2VHbGppbE5N?=
 =?utf-8?B?ZDNsY3ZHWno2dXZYMlBEMHdCKzU4T0l1MDFWQ0dKQ3hwZnRUeVUwS1Vxcjli?=
 =?utf-8?B?OXF0cm8zYi9MblV5OXVNamRSd05XS1JyYlNhSTFrV3hDZHIxYjBSTHh3ZVhq?=
 =?utf-8?B?emgyYnpEUlFWRzR5cUMwRG9oTGZPVndQRGpGdzBjYnJJMkJPeTRVaklydE9V?=
 =?utf-8?B?MzZ2cVREZ1F1LzJZbFVCcms2R251bk83cDQwSHVaN0VodUkxTW9KZDZ3RUt2?=
 =?utf-8?B?cWsyT2xXUlFuc2hQemI3eElDWVZNMHlrSEY5RmRmdm9vbWYrc3JxT1BZRWdC?=
 =?utf-8?B?MTMyQU45ZW5TVmRvY3FhWVNRRnRzUVRaNUlvZGpraVBubXgvaGpFSHdVeFV2?=
 =?utf-8?B?M1IySkRLQTVjWEg2TitXemtpZnZFSUdjNENUaG1rWVFxdDdxNUtVY1JxVGpU?=
 =?utf-8?B?Sm1nM0paOTMrNzgzbFJRRmFnamxPY1VraUZ5WllSRk1kNmc2M3NLN1QvbVJh?=
 =?utf-8?B?czlzaG1EWHUzQVhuU2wzbG9JUTJzbi9iTFdEVk9xSkhDN29RN0R2eWoxWU5r?=
 =?utf-8?B?TEFDdjBHOWZrVURzQkh3dUJRSUdJa0FUWlFiTHRlbjNqNUV2dTJRdXpvVDlw?=
 =?utf-8?B?U1UyL1d0bjRFR1BiNUtGVmNTT2ZPa0hIRUVhUTJrSzFUSk9oRmdqVytPTTAr?=
 =?utf-8?B?MWd0d0pEWnNUWGI0ZVY0MjZzK3hPYndSNm9pSW55aHp4cVpJZjNVV0RsZm9R?=
 =?utf-8?B?R0pKNzdVdkxJOTB3YkJaVkU4VjFLWFNuSktyL01MQkZXRDhCZCsyQ2VKUGRG?=
 =?utf-8?B?MXpsS0JUZS9OM0tOc1I5S00vUHRNVllocEF0WGh1Tk1rTEFJRVlDWWViSm4x?=
 =?utf-8?B?Ni9RTE9qV0FLT0crNm50WnJob2lkM3FEYnQrclcwODAxUlA2RzBDV3B3dXZz?=
 =?utf-8?B?UXVOVXVyVjFTd1RyR3g4eGpHbjY1REc5VFZhbkQ1di9pYXl4aGhhUGM1ZXI5?=
 =?utf-8?B?VHFCVE5kb2U3TXFLNDMwMlFYUjV2MUlGdm1oUmlXbkFBQVFkaWhJa0MvSzQ5?=
 =?utf-8?B?TS9NZU9CTU1xcUt1QlpnbnZVOWgvcWtKWnp3d0Y4bXlnckduNHFhS09pR1Ri?=
 =?utf-8?B?YlpMSTBlUmxFeEtWZGF2cyt5TncydGdxbWEycmdyU2ZnUGk2bTVadHJXQkVN?=
 =?utf-8?B?anAzNEhKNFQ5Vk8zZ3VnazN2bTJXZEFTdm4wNWxMeDNkVkJMNUl2YWZ3ZHNq?=
 =?utf-8?B?eXFGMFBDNHU2dm54MTR6L0w0aU1OYkQ3TUM3NnlTUTJKamhHVm9zSkxHK3h4?=
 =?utf-8?Q?xQkI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6292.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f8758a-3f9d-48b5-7206-08dcb7f1bc54
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 21:33:25.3991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tU9Yvut+Jf7cJQz4uCqBq5ydnbwRIH8nfFdY4sHxXe2q5grFS5mEkgXt/H5h528/8l7of5/dMz2rwfByAM4JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7856
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
Cg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNv
dXJjZS4gVXNlIHByb3Blcg0KPiBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xp
Y2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIFRodSwgQXVnIDgsIDIwMjQg
YXQgMTo0OOKAr1BNIFZpY3RvciBTa3ZvcnRzb3YNCj4gPHZpY3Rvci5za3ZvcnRzb3ZAYW1kLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiBSZWdpc3RlciBhY2Nlc3MgZnJvbSB1c2Vyc3BhY2Ugc2hvdWxk
IGJlIGJsb2NrZWQgdW50aWwgcmVzZXQgaXMNCj4gPiBjb21wbGV0ZS4NCj4NCj4gV2hpbGUgeW91
IGFyZSBhdCBpdCwgeW91IHNob3VsZCBwcm90ZWN0IEFNREdQVV9JTkZPX1NFTlNPUiBhcyB3ZWxs
Lg0KPiBUaGF0IHF1ZXJpZXMgUE1GVyB3aGljaCBkb2Vzbid0IG1ha2Ugc2Vuc2UgZHVyaW5nIHJl
c2V0LiAgQSBmZXcgbWlub3INCj4gY29tbWVudHMgYmVsb3cgYXMgd2VsbC4NCg0KSW4gZ2VuZXJh
bCwgYWxsIFBNRlcgcXVlcmllcyBhcmUgYWxyZWFkeSBibG9ja2VkIGJ5IHBtLmRwbV9lbmFibGVk
IGZsYWcuIFRoaXMgZmxhZyBpcyB0b2dnbGVkIG9mZiBpbiBwcmVfYXNpY19yZXNldCwgc28gZ2Vu
ZXJhbGx5IEkgZG9uJ3QgdGhpbmsgaXQgd2lsbCBiZSBhIHByb2JsZW0uIE9ubHkgZWRnZSBjYXNl
cyBJIGNhbiB0aGluayBvZiBpcyBHRlggY2xvY2sgZ2F0aW5nIHRoYXQgaXMgc2V0dXAgbGF0ZXIg
aW4gaHdfcmVzdW1lIHNlcXVlbmNlLiBCdXQgSSBkb24ndCB0aGluayBpdCB3YXJyYW50cyB0aGlz
IGxvY2suDQoNCj4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFZpY3RvciBTa3ZvcnRzb3YgPHZp
Y3Rvci5za3ZvcnRzb3ZAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2ttcy5jIHwgNDQNCj4gPiArKysrKysrKysrKysrKysrKystLS0tLS0t
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
a21zLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYw0KPiA+
IGluZGV4IDI2MGNkMGFkMjg2ZC4uMDM4YjQwMGJlNDM3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYw0KPiA+IEBAIC03NzgsNiArNzc4LDcgQEAgaW50
IGFtZGdwdV9pbmZvX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQNCj4gKmRhdGEs
IHN0cnVjdCBkcm1fZmlsZSAqZmlscCkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA/IC1FRkFVTFQgOiAwOw0KPiA+ICAgICAgICAgfQ0KPiA+ICAgICAgICAgY2FzZSBB
TURHUFVfSU5GT19SRUFEX01NUl9SRUc6IHsNCj4gPiArICAgICAgICAgICAgICAgaW50IHJldCA9
IDA7DQo+ID4gICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBuLCBhbGxvY19zaXplOw0KPiA+
ICAgICAgICAgICAgICAgICB1aW50MzJfdCAqcmVnczsNCj4gPiAgICAgICAgICAgICAgICAgdW5z
aWduZWQgaW50IHNlX251bSA9IChpbmZvLT5yZWFkX21tcl9yZWcuaW5zdGFuY2UgPj4NCj4gPiBA
QCAtNzg3LDI0ICs3ODgsMzkgQEAgaW50IGFtZGdwdV9pbmZvX2lvY3RsKHN0cnVjdCBkcm1fZGV2
aWNlICpkZXYsDQo+IHZvaWQgKmRhdGEsIHN0cnVjdCBkcm1fZmlsZSAqZmlscCkNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFNREdQVV9JTkZPX01NUl9TSF9JTkRFWF9T
SElGVCkgJg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBTURHUFVfSU5G
T19NTVJfU0hfSU5ERVhfTUFTSzsNCj4gPg0KPiA+ICsgICAgICAgICAgICAgICBpZiAoIWRvd25f
cmVhZF90cnlsb2NrKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSkpDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIC1FTk9FTlQ7DQo+ID4gKw0KPiA+ICAgICAgICAgICAgICAgICAv
KiBzZXQgZnVsbCBtYXNrcyBpZiB0aGUgdXNlcnNwYWNlIHNldCBhbGwgYml0cw0KPiA+ICAgICAg
ICAgICAgICAgICAgKiBpbiB0aGUgYml0ZmllbGRzDQo+ID4gICAgICAgICAgICAgICAgICAqLw0K
PiA+IC0gICAgICAgICAgICAgICBpZiAoc2VfbnVtID09IEFNREdQVV9JTkZPX01NUl9TRV9JTkRF
WF9NQVNLKQ0KPiA+ICsgICAgICAgICAgICAgICBpZiAoc2VfbnVtID09IEFNREdQVV9JTkZPX01N
Ul9TRV9JTkRFWF9NQVNLKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgc2VfbnVtID0g
MHhmZmZmZmZmZjsNCj4gPiAtICAgICAgICAgICAgICAgZWxzZSBpZiAoc2VfbnVtID49IEFNREdQ
VV9HRlhfTUFYX1NFKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFM
Ow0KPiA+IC0gICAgICAgICAgICAgICBpZiAoc2hfbnVtID09IEFNREdQVV9JTkZPX01NUl9TSF9J
TkRFWF9NQVNLKQ0KPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gKyAgICAgICAgICAgICAgIGVs
c2UgaWYgKHNlX251bSA+PSBBTURHUFVfR0ZYX01BWF9TRSkgew0KPg0KPiBLZXJuZWwgY29kaW5n
IHN0eWxlLiAgUHV0IHRoZSB9IG9uIHRoZSBzYW1lIGxpbmUgYXMgdGhlIGVsc2UuDQo+DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVJTlZBTDsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBnb3RvIG91dDsNCj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ICsNCj4gPiAr
ICAgICAgICAgICAgICAgaWYgKHNoX251bSA9PSBBTURHUFVfSU5GT19NTVJfU0hfSU5ERVhfTUFT
Sykgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHNoX251bSA9IDB4ZmZmZmZmZmY7DQo+
ID4gLSAgICAgICAgICAgICAgIGVsc2UgaWYgKHNoX251bSA+PSBBTURHUFVfR0ZYX01BWF9TSF9Q
RVJfU0UpDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4g
KyAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAgZWxzZSBpZiAoc2hfbnVtID49
IEFNREdQVV9HRlhfTUFYX1NIX1BFUl9TRSkgew0KPg0KPiBTYW1lIGhlcmUuDQo+DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVJTlZBTDsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBnb3RvIG91dDsNCj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+DQo+ID4gLSAgICAg
ICAgICAgICAgIGlmIChpbmZvLT5yZWFkX21tcl9yZWcuY291bnQgPiAxMjgpDQo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gKyAgICAgICAgICAgICAgIGlm
IChpbmZvLT5yZWFkX21tcl9yZWcuY291bnQgPiAxMjgpIHsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICByZXQgPSAtRUlOVkFMOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8g
b3V0Ow0KPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgcmVn
cyA9IGttYWxsb2NfYXJyYXkoaW5mby0+cmVhZF9tbXJfcmVnLmNvdW50LCBzaXplb2YoKnJlZ3Mp
LA0KPiBHRlBfS0VSTkVMKTsNCj4gPiAtICAgICAgICAgICAgICAgaWYgKCFyZWdzKQ0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+ICsgICAgICAgICAgICAg
ICBpZiAoIXJlZ3MpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRU5PTUVN
Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ICsgICAgICAgICAg
ICAgICB9DQo+ID4gKw0KPiA+ICAgICAgICAgICAgICAgICBhbGxvY19zaXplID0gaW5mby0+cmVh
ZF9tbXJfcmVnLmNvdW50ICogc2l6ZW9mKCpyZWdzKTsNCj4gPg0KPiA+ICAgICAgICAgICAgICAg
ICBhbWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYsIGZhbHNlKTsgQEAgLTgxNiwxMyArODMyLDE3DQo+
ID4gQEAgaW50IGFtZGdwdV9pbmZvX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQg
KmRhdGEsIHN0cnVjdA0KPiBkcm1fZmlsZSAqZmlscCkNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5mby0+cmVhZF9tbXJfcmVnLmR3b3JkX29mZnNl
dCArIGkpOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAga2ZyZWUocmVncyk7
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVfZ2Z4X29mZl9jdHJs
KGFkZXYsIHRydWUpOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IC1FRkFVTFQ7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRUZB
VUxUOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgICAgICAgICB9DQo+ID4gICAg
ICAgICAgICAgICAgIGFtZGdwdV9nZnhfb2ZmX2N0cmwoYWRldiwgdHJ1ZSk7DQo+ID4gICAgICAg
ICAgICAgICAgIG4gPSBjb3B5X3RvX3VzZXIob3V0LCByZWdzLCBtaW4oc2l6ZSwgYWxsb2Nfc2l6
ZSkpOw0KPiA+ICAgICAgICAgICAgICAgICBrZnJlZShyZWdzKTsNCj4gPiAtICAgICAgICAgICAg
ICAgcmV0dXJuIG4gPyAtRUZBVUxUIDogMDsNCj4gPiArICAgICAgICAgICAgICAgcmV0ID0gKG4g
PyAtRUZBVUxUIDogMCk7DQo+ID4gK291dDoNCj4gPiArICAgICAgICAgICAgICAgdXBfcmVhZCgm
YWRldi0+cmVzZXRfZG9tYWluLT5zZW0pOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0
Ow0KPiA+ICAgICAgICAgfQ0KPiA+ICAgICAgICAgY2FzZSBBTURHUFVfSU5GT19ERVZfSU5GTzog
ew0KPiA+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgZHJtX2FtZGdwdV9pbmZvX2RldmljZSAqZGV2
X2luZm87DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0K
