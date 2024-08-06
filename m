Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FCFC52D70
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 20:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E8710E3F9;
	Tue,  6 Aug 2024 20:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ODwGHFxd";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D588B10E3F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 20:30:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9VwNXi/cZ7A0HptqPJDDnBfFhsmF0RBgMvT7dr4ZGmlVXPR998MQbDmab2e0rHnclEKN68ZEUFBUjNtEnykokB8wT1XlHY6kf31fdz1IydsBZ++/hMbdnzbWuaSwlwtM8tFxb10SY6u1d8dSgkQ+ZvMzKB9GOlstKBC55g2U2OO8peWo8x9+ujZi/17pwD0yk5P/ZN6ULU7+38cZSXhW11DvWBMeI/fDC0L0xQdYEnHGO/zew3A50cKpVyVbzwvMvmzbw6AU0m5ISZ2mZ8PNoA2ZzNeElSr7UZ4wvKNO55/82gUJG5AeMcSzbyaEYueHxDUQ1BJ1rEGvkSU6Nqznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pO69J4Cb5Ryvh8q3Gf+mEarmmsrDx/kAyoxnFxEIN8=;
 b=q/L13ctnrmV12NVnXcst9W1QmhkMkcwoQ6byydQIPB8tuXTummXzLKgt0j0fDFnTzzqJA8rw0DKg3M6hlv6AG1k+TwX7xCj/iNRFthcgik7gLM2F4JfDs2svzqp0mkC/Of8a1dvazZzdOGrQnhO42mHNS0MB09LsISpjo8oyjUpEgBFTS+ll4JtsU75Y2xICJv0ZJgvqC21XpqPb3S4j+PSzILZoJn3jRBTvs00299POS2Akg1Uz2JtFLB44sL58Vdn8j/eTE1M6APO0BU1MlssLMdsaWlcvosHVDjvsLZV+M5FZKvw3SjsnR6H8mqtdb4Njy36WnRU6Ve0QDGADkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pO69J4Cb5Ryvh8q3Gf+mEarmmsrDx/kAyoxnFxEIN8=;
 b=ODwGHFxd6R+Olb7wxOyxNrYTj+edIU8wMeL6xyXmSjZSDF6k2GwFoo1GJ6QQkDCTDCiJTv7DiYwab3s46WRNsnlEUNN6tdXzRSVcjDfFTU29/JeOw6gU24ttb1PZSmBh6oCAkQR3CSqQOf0oVnL1NMBjDmKE/XGE8Dq9w+BjIaI=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 20:30:41 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9%6]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 20:30:41 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Yao, Yinjie" <Yinjie.Yao@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Update kmd_fw_shared for VCN5
Thread-Topic: [PATCH] drm/amdgpu: Update kmd_fw_shared for VCN5
Thread-Index: AQHa6DgxDBjGmXfVlUKVWMESnRCwKrIaocAAgAAMWiA=
Date: Tue, 6 Aug 2024 20:30:41 +0000
Message-ID: <SJ1PR12MB6194EF5C0F08D1BD1FFBEDDB95BF2@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20240806193805.200607-1-yinjie.yao@amd.com>
 <CADnq5_O7YrofePwd0gSL1o3p_2sd4sgAHxfByCWxbWMerMZbnw@mail.gmail.com>
In-Reply-To: <CADnq5_O7YrofePwd0gSL1o3p_2sd4sgAHxfByCWxbWMerMZbnw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f7a7b25c-9e47-4c9e-b63c-937f6e0dda05;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-06T20:29:00Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|SJ1PR12MB6314:EE_
x-ms-office365-filtering-correlation-id: 5a6f3c10-0479-49c5-a27d-08dcb656a427
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?anMzRitlT2grblljZDhWL2hRcHRUYXlrMkFUQ2ZDSHk3ejM4L0tSQVYrWUpZ?=
 =?utf-8?B?bkgxaG0yaDR2MFhpc0VtRzdUaGUrSXNxdmlvSjFqQ0wyQXRPZG1iTzdsYkxJ?=
 =?utf-8?B?R3ZONDk4UXhJMnhLV3JsTElldUVzeS9IaVNjUHhwUUhWKzVUVWFxejNTMzYz?=
 =?utf-8?B?Q2ZrMTZaaTZ0dCtuMU0zVGlrZDdOUW1ZNi93M085QlNNRjBnWHE2WVVmNXZy?=
 =?utf-8?B?SGt1YitKYjFZUDNGUVViSVIyNGdySEhuSElLMUxWZzNDNVk2dkxLV0lWZnQx?=
 =?utf-8?B?S3FuQ3FadmZpa2k0Wk1tZUFwSndseXladWo0a1hqcFhmN212OU4vQWpoQVk5?=
 =?utf-8?B?emtlekFJSE4ya3U2b3BzM0pFbTFIQWx0TGlOUHFKbmRjaE9lVkcrek1iYTBp?=
 =?utf-8?B?NkFTTjUxdnVZaEFFVzcyQTJYbnkydFZLRkw2NjJvdlhtd3ZZRUtaUXNXWFY0?=
 =?utf-8?B?MDBFbzZGS0JNVFBPRmNmWTJBWlo3TnpETnhsRk1VRENkMVlkUUhrVHc4TEc3?=
 =?utf-8?B?d3pJZXg2dkZmTnRzcVFmWGVUeFNidXdjZEdUai9WNm9OZ1o2TmpjUVU2UzRG?=
 =?utf-8?B?cUFlOVBkeUZsZ3RzQWNFOG9wN2hFak91N3Z4RDh3eE01MmM4Q3hURGlEL0Nx?=
 =?utf-8?B?ejJSVERLRU5LaUtBZ05iWDJnMUEzVW1wMkJPOGlMYUJZWXpNVnJZaVRORTc5?=
 =?utf-8?B?c1NhYkdNcm1PM1VPMEIzY3RXWTc0ZDNLSzhlNmwyM2d6Y1lwK2l2M1Y1WTZ2?=
 =?utf-8?B?RTRJc3c0cFZLYlR2VVN1ZS9lR2MzaHhlaTd4OExOYnUramcxZmI3U0ZsQWR6?=
 =?utf-8?B?QXkrSTcrWFpoTGgxTkd5WnBLQ0xmSERzdmFneWdzd1NISEZ5Q0tYVHVjUVRJ?=
 =?utf-8?B?R0RFUWlxL2RveXpQNlBCZlN5WkwwWjJ1dHhDaVVDL1JsdW9DZ0Z0ZFo0NGgy?=
 =?utf-8?B?QTdrTmVEbW53dlVDZmhsb0lyb0pjSUUwSEIzRlh3WktRcGhDNGFidU5aTG4x?=
 =?utf-8?B?dVhKbXI4UmdFYnRTdGJJY1ZJcE0rcHlNUXpncXhMOFRVeCtUSTJSNnFYSUlm?=
 =?utf-8?B?MEwxWDZzeHZ3WWZEOHhVN1FacWYwQ3YzWWJkMnlDN2xwRXF6Z3FpTVdvbE5Q?=
 =?utf-8?B?bGxFak1keFdheklvdW9nRzAvaWFzLytGZll3d1ZOdDNybVRwVk1kaDZ0VWcx?=
 =?utf-8?B?L3Bia1FORkZMYXVIQ1AyajY2eC9pbzBQWE5MMzl0Z0l0Wjdha29sN1huMDAy?=
 =?utf-8?B?cVRGZUNoSjNUdjJTbDAyK08vR0JpRVh1NmlKVjFoMm01VTJ4ejhKODIvbWp2?=
 =?utf-8?B?d2tONG45MTh6SmRMNzVNb0xHb3lmSzBoaDFBdUtreUQyUU9DenZjQnRrM1pS?=
 =?utf-8?B?QmtTZTNpUXZlZFYyMGMvNVNIeVRSbTMzeEkxckp3NmJpcXlvVERVdmtQYXJy?=
 =?utf-8?B?UDFMc3RNaHMxakY1cjZON3ZKVEhPcWJ3dnZnQThmbFB0OVU5UnoyYmI5Ukly?=
 =?utf-8?B?M2VLdFBBd0Jjc3ZqbWlvU1NsZm85azNCSU52WVlSamxQeUpQZCtETVZPdUFX?=
 =?utf-8?B?dGorYWRwWVlsMU4yemVjRjVNelNsR3pOSFZGNWUvbGxuemJwV2w1bk9mbnQ3?=
 =?utf-8?B?RWQyMC90WkUydXpESFl1SS9pQ0NScjVjQWd5MmFvaklpYytQZXFWQk9aNWw0?=
 =?utf-8?B?dzFNMEFvR1I2SzRZbEIzRDhMSlErMURwNzdxY2xhYTBJVytMQ042bHVWNGIw?=
 =?utf-8?B?dnBCczNVNGJWeklFMDBsdWVTMzRyMkRBdHphUUU0RDMvU1NYUUdZa3ZSZkMw?=
 =?utf-8?B?TXZIdElSUERoZmxacHpYLzFLVnRnZGlnMDJJaFVSWnJGQjhTdWlDRXdCZHA3?=
 =?utf-8?B?V21WZ3k2RmF0YTYwWGNpUXhCVDU2RzIraFZQUWg3ZjNTNFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0ZTeWhmRXVzYmNaRHpWQ3NaVHZ1UnVBbWNuMmlhNENiOXowQVRxN25YV1hj?=
 =?utf-8?B?cmk3QWpnN05nb3FpT0R0MlFjUi9ibmNMQXJjUldxVnJlTkQ5QXk4ZGp3eVV2?=
 =?utf-8?B?ZFhTNzlPcVFVNm56YTBXMnRteHN3d0ZtdHdZNDZ2Y0RMSFZKUnVJZHE2UEln?=
 =?utf-8?B?aXQ2YWV5TUdlbUxFSjZaaTZYTXZ2eFE1VTVnS0dVUnRZWGRyekRPVHVBa2lT?=
 =?utf-8?B?bkprUnZxd3dQcjZ3eGE1L0hQNUNCR3BGWm41c2JYSUxKS0ZlV3hmNDNzTWNG?=
 =?utf-8?B?ck03QndPdDZjOC9LMjVKV1NIWTEvdlZDQUMwTHdMZXhpb3psMDVaOU0yRUxl?=
 =?utf-8?B?eGlXSjVSRjNjTldqaHUxK0QvZkRzU25seTN6TG1zeDZidXhUUFBwY1U0WUor?=
 =?utf-8?B?OTRWbWdKdklySkw3NmxLcDI3UGsyZXluK3FTUXlEZWloVGJuU2RGa2lnTUVW?=
 =?utf-8?B?SjQvQ0luUS9vbkk3ZlNIcFJmS2dkKzlWWWdGWEZXSm43Tmc4MTlSWUxmRTZT?=
 =?utf-8?B?YmlENndDb2xVNlV2QXVUa3JVUDdSdmpRNmtudzV2U3JIMjNVYURNVGwweGpz?=
 =?utf-8?B?NHZvZ1lHMlZlYjZjdk0xK1o3d1kzMEhpOUs1K05LaUt2UVZ1S3Zsa2QwT1Y0?=
 =?utf-8?B?R0FEMjgxbXFTaDUxeENqWG9jTlBRL2lUbGZySENEcW1PUUNQenJ1Z0Y3ZE8z?=
 =?utf-8?B?Ym1yZG1mTkxCcFF0eEpuRDhvS2dMZERZVEk0bnhnRXYrRDAyOVBsYmdVZ1VC?=
 =?utf-8?B?bGxrclR3UWFaUnI0b0RwYSsvaW1GYmhwWnA2ZHdJQzZ4ZitKdStJdHpQYnh3?=
 =?utf-8?B?aWpvQSswc0xlajRGY0kzZGdsUUpVSitYWFZwMlVWQ2JsKzViRmVzMFNCY05k?=
 =?utf-8?B?ZlE1aTJ1K1hVR1gxZy9KZk9uT3VmeEljd29wbnNHWC83VjI1dEV2U2JCNmtj?=
 =?utf-8?B?d2lFOE1PV3c3UjQyZGt4enhkMm1vWDFvZEh6L2sxNlpHalR6NElzN28xcTBG?=
 =?utf-8?B?MWoyR2V3K3RBT1RDUm1jTHFqaER1WmFrYjk5enBHOVh1UFNPTEVJcjRNdng0?=
 =?utf-8?B?b251WkFmSU1VYkNPTjBGaVMrUk1mYU5BVWFlbDJRL2N2OTRZV2JSMW5JKzln?=
 =?utf-8?B?eHhTaWtDdkJRSCsyZEFXTmF1dWZIOWRzVmNTKzg1bDB2ZTV4TTR5NURWa0Jm?=
 =?utf-8?B?OEN0ZGt0VWlrTlEzT1pTTGNnOXZlTVdxTXMzTHA5VUhGYUtQK3ViUndTaTdO?=
 =?utf-8?B?dnhoK05RL0t5M3oxWWUycmVmQ3l2dGRxcC80NUJ2OTN1S1pDZjNUTkV1bDlN?=
 =?utf-8?B?VEhLdzJUbVY1VnFsWXNOQzVTcEwyQVg0NHRkeFllcDJGdmlYQU9SeGgrOE5S?=
 =?utf-8?B?MmFJdkcxSy9qZHBtTlJJaE1JOWQ0d2EvMDhMME45elVkWkVMV0NiNlRwTU5z?=
 =?utf-8?B?aFVObEtsNVdCV1l0bnQ5bVRQRWg3eXdCRFZETzlxM2VtcnNhTEtYcnA2Vlow?=
 =?utf-8?B?MWxrZXI3NitUOXRDWWJHWkxSRjJ6SHBMZytIYVl6WXRlWjBqaU9EdDVVRGlh?=
 =?utf-8?B?NHQyakwyYUxPakJ3dkpvUVkyUlJ5cUxOVmZ3U2J0aG9BTHRnSEQ2SXpHYzlp?=
 =?utf-8?B?SFZEZEN6M1Flais0WHRjNmhVZ0hpOXlySTJlbGkwczRJb3dzekJXZnNGM0hi?=
 =?utf-8?B?T1JTRVQ1clR1bEdHRlc5aTRwK053RzF2QTEvMkJIank5aHlpcGRjZjRVb1Y2?=
 =?utf-8?B?VnFiSnBpeld6SkVSMFpMcHNrMjVwSGJOYXhianIvQ1FQNW5XOUZiNjZYMTNx?=
 =?utf-8?B?cWNPRXdEQVlyTUNCTHJtN2IvNitiVjJrelI0NU9mdmY4ZEJEemJXQXpFdGxr?=
 =?utf-8?B?UCtjMmNuNjlOZlVkSitPdGVQejZhdXg1eGFhaU5ianZBdVY4eElHMk1WbHNE?=
 =?utf-8?B?V1RHaFdRVTdQWEZ6UVlpOHdTemY4eEZaT2tBbGliS1NZOTdTMzYrbGx5K2t1?=
 =?utf-8?B?V2NOZEJZVHozbjhSUEp2UUFlL1hwcUNiTEVFZi96akxkSGx0V3FBT21DVWMx?=
 =?utf-8?B?VEFYeVRwVHhYM1V0SFBLamlnUXNlTHpINDk0YWVvZHZwOVJMYjk3bHQ3UUxI?=
 =?utf-8?Q?0Riw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6f3c10-0479-49c5-a27d-08dcb656a427
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 20:30:41.6915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HR0p+rxyc60zpdwA8RIHU2q5b1pcFCehnkcGhobqC1OvCJlJ5pfOqwvKXcHy7aFb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314
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
Cg0KSGkgQWxleCwNCg0KUHJldmlvdXNseSB3ZSB1c2VkIHBhY2tlZCBhbmQgZm91bmQgb3V0IGl0
IGRpZG4ndCBtYXRjaCB3aXRoIEZXIGludGVyZmFjZSwgYW5kIHRoZSBvbmUgd2l0aG91dCBwYWNr
ZWQgd29ya2luZyBhcyBpdCBtYXRjaGVzIHdpdGgNCkZXIGludGVyZmFjZSwgdGhpcyBzb3VuZHMg
dHJpY2t5IHRob3VnaC4NCg0KVGhhbmtzLA0KUnVpamluZw0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQpTZW50
OiBUdWVzZGF5LCBBdWd1c3QgNiwgMjAyNCAzOjQ1IFBNDQpUbzogWWFvLCBZaW5qaWUgPFlpbmpp
ZS5ZYW9AYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS29lbmln
LCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRl
ciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpdSwgTGVvIDxMZW8uTGl1QGFtZC5jb20+
OyBEb25nLCBSdWlqaW5nIDxSdWlqaW5nLkRvbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGRybS9hbWRncHU6IFVwZGF0ZSBrbWRfZndfc2hhcmVkIGZvciBWQ041DQoNCk9uIFR1ZSwg
QXVnIDYsIDIwMjQgYXQgMzozOOKAr1BNIHlpbmppeWFvIDx5aW5qaWUueWFvQGFtZC5jb20+IHdy
b3RlOg0KPg0KPiBrbWRfZndfc2hhcmVkIGNoYW5nZWQgaW4gVkNONQ0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBZaW5qaWUgWWFvIDx5aW5qaWUueWFvQGFtZC5jb20+DQo+IFJldmlld2VkLWJ5OiBSdWlq
aW5nIERvbmcgPHJ1aWppbmcuZG9uZ0BhbWQuY29tPg0KDQpBY2tlZC1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KDQpCVFcsIHNob3VsZCB0aGVzZSBzdHJ1Y3R1
cmVzIGJlIG1hcmtlZCBhcyBwYWNrZWQ/ICBJIHN1c3BlY3QgdGhleSBzaG91bGQ/DQoNCkFsZXgN
Cg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oIHwg
NSArKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zj
bi5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oDQo+IGluZGV4IGYx
MjdlY2NmNTlkNy4uMmExZjNkYmIxNGQzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdmNuLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Zjbi5oDQo+IEBAIC00NjQsOCArNDY0LDExIEBAIHN0cnVjdCBhbWRncHVfdmNu
NV9md19zaGFyZWQgew0KPiAgICAgICAgIHN0cnVjdCBhbWRncHVfZndfc2hhcmVkX3VuaWZpZWRf
cXVldWVfc3RydWN0IHNxOw0KPiAgICAgICAgIHVpbnQ4X3QgcGFkMVs4XTsNCj4gICAgICAgICBz
dHJ1Y3QgYW1kZ3B1X2Z3X3NoYXJlZF9md19sb2dnaW5nIGZ3X2xvZzsNCj4gKyAgICAgICB1aW50
OF90IHBhZDJbMjBdOw0KPiAgICAgICAgIHN0cnVjdCBhbWRncHVfZndfc2hhcmVkX3JiX3NldHVw
IHJiX3NldHVwOw0KPiAtICAgICAgIHVpbnQ4X3QgcGFkMls0XTsNCj4gKyAgICAgICBzdHJ1Y3Qg
YW1kZ3B1X2Z3X3NoYXJlZF9zbXVfaW50ZXJmYWNlX2luZm8gc211X2RwbV9pbnRlcmZhY2U7DQo+
ICsgICAgICAgc3RydWN0IGFtZGdwdV9md19zaGFyZWRfZHJtX2tleV93YSBkcm1fa2V5X3dhOw0K
PiArICAgICAgIHVpbnQ4X3QgcGFkM1s5XTsNCj4gIH07DQo+DQo+ICAjZGVmaW5lIFZDTl9CTE9D
S19FTkNPREVfRElTQUJMRV9NQVNLIDB4ODANCj4gLS0NCj4gMi4zNC4xDQo+DQo=
