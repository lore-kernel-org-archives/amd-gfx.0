Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794A9C3DA41
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jul 2024 01:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CAA210E181;
	Thu, 11 Jul 2024 01:36:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5JqLw5p6";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4AF310E181
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 01:36:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLh7nPydryYM2cPwtzT0Q4lCLKGYS3MGtVNFqvlk+mPDctDCMWmopg13XQ6JzZXqeG6k1cXJwMiC/AUPW/mBZ4pQCVva49Q1SR0o5orKoqkcxfbvaGOqgF/kCvnFL5qBX0Fv2Y3fBj5nPDUXwsUKEdUGCois8aFywFKiOiLz1s/XoUY3MSDN3MNYXw1Rj2PIx2SPCS3u6fZmIJy+aovWbOn0QlApqKz5j2CuWEx3R5VmPFebT2Ka2CDpWGKCiUHNXY2uOIb4mUm1U4aOJvfK200K0zx5rTIDES5MsXVDOLgl5Z/YDusiCdrvHmOa5INUkbZ/mG7wURI1nNHQRSAjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdIoaZCafIQKDkDM4BsP9vKtpdCMb4t2tsaRNlSNVho=;
 b=XO+z3vEFmYLzxXz+66wrlShSPBsifyfDh2vTH9Ojm24vLbAh+DuufbrOGxd7ObSE4RUBP1hKVFaKyLNZQNw/ngcrWwkv7V2wk+DLnKALjedTbSQMBloaCkzWxiCzgMYD6134ELZN490XEAEumcjs74xx32GisMfmlHsj2wW8TrqaW035Hn1od7O/1nY4sW0eLLxz4DBMBuprwDHWAPmg69jnK8zw3w1ghIsI4LTzmyq3LrLyiEC46VVGcNnA7DldkIeZMhycL6ZQ8h7oObFt/vG+Xh6ixyirmg0KifXjk/gXoXDqlOOD7sHmHCCmpKwHNexd/FPSDRyR86Shi4rt5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdIoaZCafIQKDkDM4BsP9vKtpdCMb4t2tsaRNlSNVho=;
 b=5JqLw5p6Lm5u0j/gDOcz0yO5Ni/+XXc080CjEj/hCxDiS7azIfrarH7zeeRdNLCFCZLoHDe+QWxtuY7Giv561z81D1fCbVx9ZfhBFnkqGM9iuEXavYxDH3TUClysxfrEwnVLsXmI8366QcAEBiLqtkvSyigPw8O2EiztvwkLI7U=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Thu, 11 Jul
 2024 01:36:46 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%2]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 01:36:46 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Ma, Li" <Li.Ma@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/swsmu: enable Pstates profile levels for SMU
 v14.0.4
Thread-Topic: [PATCH] drm/amd/swsmu: enable Pstates profile levels for SMU
 v14.0.4
Thread-Index: AQHa0q2dMa8rBn0dAk+vkok2iEs1+LHv+hKAgADF5UA=
Date: Thu, 11 Jul 2024 01:36:46 +0000
Message-ID: <CH3PR12MB80742A1311D5713AF3B36756F6A52@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240710094258.1033943-1-li.ma@amd.com>
 <CADnq5_OnccCt9o=Zh6Vaqzgr95bibsV4DBoqmD+r3PtYJk76bg@mail.gmail.com>
In-Reply-To: <CADnq5_OnccCt9o=Zh6Vaqzgr95bibsV4DBoqmD+r3PtYJk76bg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=e1092026-ffc3-491a-a5d6-048853980071;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-11T01:36:09Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|IA1PR12MB8405:EE_
x-ms-office365-filtering-correlation-id: aaeb8c86-dabe-41b1-5171-08dca149ed54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bjNKb3pNdWlPVjV3YjdZMDQrTkQ4d1V2cUp1YXlPZFpjdXFzcEV2UExnV2JS?=
 =?utf-8?B?NkVCZFQzUk1lVEVJMTB6UnMrWXN3VGRyZENXb09yVkhUOXQzeGxaaFptMFZt?=
 =?utf-8?B?K2czcUxDbjdlQnUyZ29SeXlhczNkZUFycWlzVVJ6UVlISzdoNVk5Lzk4d2FH?=
 =?utf-8?B?clVkelpwcUw5K0dQNjRTanBiS3RRVEV6SlAwbjcwMmhOVlZDYnFTSVJFNVRU?=
 =?utf-8?B?Y2oycE5kZzdGU2JaUXFSVFNKT09sYU5yNDJOYk0rS095TzhMcmFGWkYyNmpz?=
 =?utf-8?B?WE1pMzI2R25BcDJzNnpjQlA1YUsraHFKRHNGUDZaR1hJaEFqL0xsb2tKTm9s?=
 =?utf-8?B?NG5HRTh5WGdEMitIcEpuRWV0SkowUzBvTjcyaEkrdXRRcmkraDh4a1UrcGVl?=
 =?utf-8?B?ZkFjK2MvbWNSYzJPeFY5MGpEamxwTitLeWdlM3F1eVFvVkpFZVdvVEUvZ1cw?=
 =?utf-8?B?Vk9XTmN1QXUvSTE0aTlGQzJLQnZaYVhuYXBRMytEeFhmd09PYVEyODMrRWhZ?=
 =?utf-8?B?aU9NNGlzSWN3YWsrVFk4NC9ScDF4NGhjRUEwcS9NUWxTMVdDTnVhQmlockcw?=
 =?utf-8?B?YXJmRVMyOTgzdTRhZEtFckoyTXhIV0JJOTZ2K3hIWHIzTGhTRVRYVktMVUxz?=
 =?utf-8?B?N1dQZ2pYd3FsNzJPcS9yaDlpUGFycWYzb1BXU3ovS1R0RDh3WU1UdXJ2STJB?=
 =?utf-8?B?VHNqaWo5NHl6Q3FvREh2bWFqbkg4QW50aXVsRmU3ZTNVWHpXWTZTNGQ0Y0t1?=
 =?utf-8?B?b3lZc0lreTJDNnZwU2o1NHlLVkNvMTJFcmowSjF4MUxyMEIxMGN2N2pGaG1j?=
 =?utf-8?B?UndHMmZKL1BtR1llbXBiNHdmenh1bExJWjdDcnljcmo0OGNic04vLzNRdk9q?=
 =?utf-8?B?YkE2a0ttcmo4cWIxZkZNVnVDbk5Yc2dxWXBBMDUzNVY5M290NHdZNklhRVZ1?=
 =?utf-8?B?SnlmUmo5SFV0Tk51RjYwT2FXSnoza0ttYS91NDg0Ymx3NUwwcDZJdmErNnR0?=
 =?utf-8?B?UkZmNnMwTGJiV29ydHI3NFpUVWZXUlRBcHp1M3F6bVFTZURZUTkzNVg4TlBH?=
 =?utf-8?B?NVlieUx4bnlzUW5PblVZOHRKR0pZNTdWWEt2T01yaHVLc2ppTkJ2OUw3QWEz?=
 =?utf-8?B?M3pEOFkzS3ZQbUd2bTlldytVSVNkV0NPc3Z5czNxeGUrY2hhUlhTVDZvYm1s?=
 =?utf-8?B?Zlk3Zkw4WlFEZzRrM2dzdXFXa2d5ZWhyMms1YkhXODJJVnF5RHFHcmZFYmFy?=
 =?utf-8?B?VzFGMWxOdld2WW4wVWE1eEpVNWhWU0NiSkV0ZStjVXliaGRXRW1kTWxDdW5q?=
 =?utf-8?B?MlhrLy83bzB0SGZkb3FmRFZqbmxVYWNCaFlWQ0pJV3Jlb1hOc0pLVUd2WUVi?=
 =?utf-8?B?MklqOXFLOUtleTNpaWxNQjFscDBPeUZMdytSTlVxUDJTSGVRVlk2VjM3azRs?=
 =?utf-8?B?MEtNaHVaWmFlQTNvWXcwV0NsR2VWdWZrT2lreGFEeUU0Q01lSjEyRjI1TXFk?=
 =?utf-8?B?YVRyRmdtczNDM1oxckFBbXl6dzlBUnpFNzF2cXVCNUJGZjRQZURmNEFsNlJI?=
 =?utf-8?B?bTJ2ZDhPMjZVTys0c2ZRczVVSmNSTkVaZE5NVEpac0drcEFibnBtN252TVg3?=
 =?utf-8?B?RFUyOHJGVXdnZTVIYWo4eWI4MnlWRkN5Wkd2QnNzYVVmYUx2RWRzUk1qMWZo?=
 =?utf-8?B?aERYaGdPUUYwSm94eWgzZGVhLzBHN1E1cnMwZ0ZHMm9KN0o0a2NqQVA3a3Ur?=
 =?utf-8?B?YThWYXd5c0I3U3IwKzUybzgxRmF0NjM5UUZTMjQ2ZVZFV2FqdzQvWS9McjRZ?=
 =?utf-8?B?bXN5dW5pdWxNdnFtdHBFNjhINXBXTUsySDFTTnZRSDhlUS9PYUFIOXZOaUtG?=
 =?utf-8?B?ZUU2WkRreUZqUHJSRWZTYjBkNTRJUlkrUGdBaXUya0tDUnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVBTOGZPcWdRYzVDSlZtVkl5UmI4ejl1Q3dCbTVvYlYvdXdQZ3I5cUFhWEJt?=
 =?utf-8?B?cFVaNDQyZnRoTzh0bWNMWDV6UDBNc09TR2EweHpzd3hsNjY5ejVEWHBNRExy?=
 =?utf-8?B?aTdjQkxnZW91TjVYNkk1d3VqOFgwc1hydjBWdUhJM0puRnZ6RTg5ZVFVOGpE?=
 =?utf-8?B?L2dlNWVjN0VacGQ1ME50R0lNSFlFZzZjUElCK3NhKzNGRVAyZ1FYdmNHNU5w?=
 =?utf-8?B?MURZaHZ0SWgzSUxPVDd1SHhldzJhZmpuaUg1T1F2T1UvUmNiSkoycE02TFI2?=
 =?utf-8?B?cURQU2RDdVpUdklmWUFSYSs2UzYwQVNiZ1dSNExFUTdJZTNsOW9iWEthVG5q?=
 =?utf-8?B?SUpadVVkajZSc3ZNWXB2cjB0Mzd0QzYwQnpxV2dnY0xaV1ZZVCtoWVQrM1Zq?=
 =?utf-8?B?dGdxdVRDZm04ZldMOWpONmJ4eFVhNkw3NzZ2clkwRXlqdUpyWllCZTBjN0Yw?=
 =?utf-8?B?VVVUK3FHQnNkam53VTBOOGtMcWppYkx1NDJPY2lKa2ZxVmhZRXROc1RSVVNy?=
 =?utf-8?B?QjJnTXJaNnFMVXVPQjQ5RzQyais4cHQzanF6SmYrWitwQklpZGwvaW0vbnN3?=
 =?utf-8?B?dXk5WW93VmFGa0pXa3VGb0Njbkw5VFhNSG1RTjErNHRYNU0ydy8rTjVWMHdR?=
 =?utf-8?B?dHZiTGhRM1VqWnhEQmFBUGdER1Ruc2tNaXd1QVhOV0VpeFNPaWFIK0l3bmRP?=
 =?utf-8?B?MWhPME5nQ0NIOXRycldXSFJ5RmhoRFJBK3hhdnp4QmE2eHdWbW9TMEFzWklj?=
 =?utf-8?B?WmNzdkJKdVBpVktXSGU4c3RCL1FxK0k0WENHYnpSVFNXTXQxNGpJRE5ocVJY?=
 =?utf-8?B?MDU4QzdLMFIwcUkxOUlOak9EWFNwU2djbTdkYmRXMzNLWDBYNE0zTmhPZC9i?=
 =?utf-8?B?dlczQ2FWMGJaN1R2WTB2SHQwQTNvSWlLN2xIOE05eGhSVTJDcG1Sc3h1UWhp?=
 =?utf-8?B?NlhkOGRwdG9NZkE1M1p3YWluUWJBMmhlV2lRTWtNd3l2bDZkaTNIUXlhQkNR?=
 =?utf-8?B?VUdQMVpDeE5jaDdhcUtOaGhscGN0d2R3NnBScmNjeVl4TE9sZDVZY0l0TEdX?=
 =?utf-8?B?eDVrNDY1U1BhVTlLR01SdDZZQjNnanZ2SnZWTHZpU01heHluZzBCajZ2bEN6?=
 =?utf-8?B?T1ZTNW83Njg4MitjZkl3US9uTCtocTU4RHlEY1pCUzExUVlhWGk0TU1KdEN0?=
 =?utf-8?B?NEJ3NzBpNG5DVTg0K25lYnRnM25NN1FZcXpzMkM0Zk93eitCVk9jaGhDTTZk?=
 =?utf-8?B?YXZLSFRneWpLWnB3SnNiZkJUN1U3UjNBY0FKWm9IUlJMZnhJcG9UaUtYYU51?=
 =?utf-8?B?akUra3RKaVhoQ2JJWmd4czBqYmdQSXhvcXpYOWh0S09BY2plZFZQYnJEcjVa?=
 =?utf-8?B?cjR3aU1kV1AyNitIRzlnYW1PUzNndjhWRmFaM01GUElaTzV3WHFNWWVyM2Nv?=
 =?utf-8?B?cTFWT2pvakxoOVpjb1REZ3lPaDh6NTNjNEJrRlhDWUZ3dStqOTVQT00vNzdo?=
 =?utf-8?B?T1lqK0t2angxb1dKK0lTd09yaEFCb0VTNVBhZXl1Ym8xajZhZ2VxVEc1UHZv?=
 =?utf-8?B?ZDJ4Tm9QN2FnNWhRR2piRWtIOEVsQm9iZ2pwWlI3b2E0RXZiSTE1OWJEbERh?=
 =?utf-8?B?STJlNHJjQkpFT1VPdTljS3crWkJxKzBlcS9OOVU4NlRsTmZESTVOOEozU3Uy?=
 =?utf-8?B?b2w0WWMzbXFLa3ltbEY1RHllRlFGS0VKdFdpdTJwQ21lZjNSWFV4eXcwYURo?=
 =?utf-8?B?ZnhadTFqWUVJYXJsYmExNlVzRGMvWUNRM1V4SFZobUdyWGVidW14ZXhyNHBN?=
 =?utf-8?B?SktZb3NBRC9UVkRncXZ5VVQrN0EyNnByNWlFZEVlQ1R5Um9SbjBDemdNWi95?=
 =?utf-8?B?cWNGQUZORk03VCswYmRRMlJTOGw5MTV5eDNhU2NjUTBXQStEUllKWERrdXBG?=
 =?utf-8?B?ZXlaOGVwOHEralI1aXl3VEVqOE5XVWVCZzMxVmluTjdsSmRyZldmVmxzOWkw?=
 =?utf-8?B?NEtrTGJzeTQzME9VK0VabkN6ajgxRUFSNEtiUnRBbGhKOXZienN3cU8wZnA3?=
 =?utf-8?B?UXJNcGpPcHN5YkY5WFYrWUZ5c01HaEFSKys2Vk5wb2NidVlGT09LUytVZ1Nw?=
 =?utf-8?Q?zWcM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaeb8c86-dabe-41b1-5171-08dca149ed54
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 01:36:46.5985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6WqoxfH907CaBDaRhNj9pmnIFLOPs9HhcyN9oQSu+MIFm/8tXy390nEvvMFGolaF/7lP58NEXHneDiDUO9majg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405
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

W1B1YmxpY10NCg0KVGhpcyBwYXRjaCBpcywNCg0KUmV2aWV3ZWQtYnk6IFRpbSBIdWFuZyA8dGlt
Lmh1YW5nQGFtZC5jb20+DQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIEp1bHkgMTAsIDIwMjQgOTo0OCBQTQ0KPiBUbzogTWEsIExpIDxMaS5NYUBhbWQuY29tPg0K
PiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEh1YW5nLCBUaW0gPFRpbS5IdWFu
Z0BhbWQuY29tPjsNCj4gRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPjsgWmhhbmcsIFlpZmFuDQo+IDxZaWZhbjEuWmhhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gZHJtL2FtZC9zd3NtdTogZW5hYmxlIFBzdGF0ZXMgcHJvZmlsZSBsZXZlbHMg
Zm9yIFNNVQ0KPiB2MTQuMC40DQo+DQo+IE9uIFdlZCwgSnVsIDEwLCAyMDI0IGF0IDU6NTDigK9B
TSBMaSBNYSA8bGkubWFAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBFbmFibGVzIGZvbGxvd2lu
ZyBVTUQgc3RhYmxlIFBzdGF0ZXMgcHJvZmlsZSBsZXZlbHMgb2YNCj4gPiBwb3dlcl9kcG1fZm9y
Y2VfcGVyZm9ybWFuY2VfbGV2ZWwgZm9yIFNNVSB2MTQuMC40Lg0KPiA+DQo+ID4gICAgIC0gcHJv
ZmlsZV9wZWFrDQo+ID4gICAgIC0gcHJvZmlsZV9taW5fbWNsaw0KPiA+ICAgICAtIHByb2ZpbGVf
bWluX3NjbGsNCj4gPiAgICAgLSBwcm9maWxlX3N0YW5kYXJkDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBMaSBNYSA8bGkubWFAYW1kLmNvbT4NCj4NCj4gQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4NCj4gPiAtLS0NCj4gPiAgLi4uL2RybS9hbWQv
cG0vc3dzbXUvc211MTQvc211X3YxNF8wXzBfcHB0LmMgICB8IDE4DQo+ICsrKysrKysrKysrKysr
Ky0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3Nt
dTE0L3NtdV92MTRfMF8wX3BwdC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L3NtdTE0L3NtdV92MTRfMF8wX3BwdC5jDQo+ID4gaW5kZXggNWQ0N2Q1ODk0NGY2Li44Nzk4ZWJm
Y2VhODMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUx
NC9zbXVfdjE0XzBfMF9wcHQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dz
bXUvc211MTQvc211X3YxNF8wXzBfcHB0LmMNCj4gPiBAQCAtNjksNiArNjksOSBAQA0KPiA+ICAj
ZGVmaW5lIFNNVV8xNF8wXzBfVU1EX1BTVEFURV9TT0NDTEsgICAgICAgICAgICAgICAgICAgNjc4
DQo+ID4gICNkZWZpbmUgU01VXzE0XzBfMF9VTURfUFNUQVRFX0ZDTEsgICAgICAgICAgICAgICAg
ICAgICAxODAwDQo+ID4NCj4gPiArI2RlZmluZSBTTVVfMTRfMF80X1VNRF9QU1RBVEVfR0ZYQ0xL
ICAgICAgICAgICAgICAgICAgIDkzOA0KPiA+ICsjZGVmaW5lIFNNVV8xNF8wXzRfVU1EX1BTVEFU
RV9TT0NDTEsgICAgICAgICAgICAgICAgICAgOTM4DQo+ID4gKw0KPiA+ICAjZGVmaW5lIEZFQVRV
UkVfTUFTSyhmZWF0dXJlKSAoMVVMTCA8PCBmZWF0dXJlKSAgI2RlZmluZQ0KPiA+IFNNQ19EUE1f
RkVBVFVSRSAoIFwNCj4gPiAgICAgICAgIEZFQVRVUkVfTUFTSyhGRUFUVVJFX0NDTEtfRFBNX0JJ
VCkgfCBcIEBAIC0xMjk2LDE5DQo+ICsxMjk5LDI4IEBADQo+ID4gc3RhdGljIGludCBzbXVfdjE0
XzBfY29tbW9uX2dldF9kcG1fcHJvZmlsZV9mcmVxKHN0cnVjdCBzbXVfY29udGV4dA0KPiAqc211
LA0KPiA+ICAgICAgICAgc3dpdGNoIChjbGtfdHlwZSkgew0KPiA+ICAgICAgICAgY2FzZSBTTVVf
R0ZYQ0xLOg0KPiA+ICAgICAgICAgY2FzZSBTTVVfU0NMSzoNCj4gPiAtICAgICAgICAgICAgICAg
Y2xrX2xpbWl0ID0gU01VXzE0XzBfMF9VTURfUFNUQVRFX0dGWENMSzsNCj4gPiArICAgICAgICAg
ICAgICAgaWYgKGFtZGdwdV9pcF92ZXJzaW9uKHNtdS0+YWRldiwgTVAxX0hXSVAsIDApID09DQo+
IElQX1ZFUlNJT04oMTQsIDAsIDQpKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNsa19s
aW1pdCA9IFNNVV8xNF8wXzRfVU1EX1BTVEFURV9HRlhDTEs7DQo+ID4gKyAgICAgICAgICAgICAg
IGVsc2UNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBjbGtfbGltaXQgPSBTTVVfMTRfMF8w
X1VNRF9QU1RBVEVfR0ZYQ0xLOw0KPiA+ICAgICAgICAgICAgICAgICBpZiAobGV2ZWwgPT0gQU1E
X0RQTV9GT1JDRURfTEVWRUxfUFJPRklMRV9QRUFLKQ0KPiA+DQo+IHNtdV92MTRfMF9jb21tb25f
Z2V0X2RwbV91bHRpbWF0ZV9mcmVxKHNtdSwgU01VX1NDTEssIE5VTEwsDQo+ICZjbGtfbGltaXQp
Ow0KPiA+ICAgICAgICAgICAgICAgICBlbHNlIGlmIChsZXZlbCA9PQ0KPiBBTURfRFBNX0ZPUkNF
RF9MRVZFTF9QUk9GSUxFX01JTl9TQ0xLKQ0KPiA+DQo+IHNtdV92MTRfMF9jb21tb25fZ2V0X2Rw
bV91bHRpbWF0ZV9mcmVxKHNtdSwgU01VX1NDTEssICZjbGtfbGltaXQsDQo+IE5VTEwpOw0KPiA+
ICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiAgICAgICAgIGNhc2UgU01VX1NPQ0NMSzoNCj4g
PiAtICAgICAgICAgICAgICAgY2xrX2xpbWl0ID0gU01VXzE0XzBfMF9VTURfUFNUQVRFX1NPQ0NM
SzsNCj4gPiArICAgICAgICAgICAgICAgaWYgKGFtZGdwdV9pcF92ZXJzaW9uKHNtdS0+YWRldiwg
TVAxX0hXSVAsIDApID09DQo+IElQX1ZFUlNJT04oMTQsIDAsIDQpKQ0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGNsa19saW1pdCA9IFNNVV8xNF8wXzRfVU1EX1BTVEFURV9TT0NDTEs7DQo+
ID4gKyAgICAgICAgICAgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBjbGtf
bGltaXQgPSBTTVVfMTRfMF8wX1VNRF9QU1RBVEVfU09DQ0xLOw0KPiA+ICAgICAgICAgICAgICAg
ICBpZiAobGV2ZWwgPT0gQU1EX0RQTV9GT1JDRURfTEVWRUxfUFJPRklMRV9QRUFLKQ0KPiA+DQo+
IHNtdV92MTRfMF9jb21tb25fZ2V0X2RwbV91bHRpbWF0ZV9mcmVxKHNtdSwgU01VX1NPQ0NMSywg
TlVMTCwNCj4gJmNsa19saW1pdCk7DQo+ID4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAg
ICAgICAgY2FzZSBTTVVfRkNMSzoNCj4gPiAtICAgICAgICAgICAgICAgY2xrX2xpbWl0ID0gU01V
XzE0XzBfMF9VTURfUFNUQVRFX0ZDTEs7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChhbWRncHVf
aXBfdmVyc2lvbihzbXUtPmFkZXYsIE1QMV9IV0lQLCAwKSA9PQ0KPiBJUF9WRVJTSU9OKDE0LCAw
LCA0KSkNCj4gPiArDQo+IHNtdV92MTRfMF9jb21tb25fZ2V0X2RwbV91bHRpbWF0ZV9mcmVxKHNt
dSwgU01VX0ZDTEssIE5VTEwsDQo+ICZjbGtfbGltaXQpOw0KPiA+ICsgICAgICAgICAgICAgICBl
bHNlDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY2xrX2xpbWl0ID0gU01VXzE0XzBfMF9V
TURfUFNUQVRFX0ZDTEs7DQo+ID4gICAgICAgICAgICAgICAgIGlmIChsZXZlbCA9PSBBTURfRFBN
X0ZPUkNFRF9MRVZFTF9QUk9GSUxFX1BFQUspDQo+ID4NCj4gc211X3YxNF8wX2NvbW1vbl9nZXRf
ZHBtX3VsdGltYXRlX2ZyZXEoc211LCBTTVVfRkNMSywgTlVMTCwNCj4gJmNsa19saW1pdCk7DQo+
ID4gICAgICAgICAgICAgICAgIGVsc2UgaWYgKGxldmVsID09DQo+ID4gQU1EX0RQTV9GT1JDRURf
TEVWRUxfUFJPRklMRV9NSU5fTUNMSykNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo=
