Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B549CA0EF8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 21:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0133E10E7B6;
	Wed, 20 Aug 2025 21:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j/Mdsuwt";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B38310E7B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 21:08:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnP2hcKucuMPPu44Zzkhe1UBjV6EVCzCZOn58FVP4LvOJPOoFbtT0rAKYPxf2wDZGynjPqe6m5I8fx6RLzRr9AAqC/JUcnWb7R7I+khFhryrfUCr4L1D+ZA/fdUMccpjxltyVMVEQfSnRa34h9/5vrO0RXrrl3I4eDH3nqf0iqlDemSqjqllVR9A6B7s915td8pIL6OV/PkQxJoxVN+NLWlxKaYXzgD21j4jy+MuKetqRdDY6ZUfXg6gElnGVWYJ/gACZKj33i1i1KEKXtK+S9Gcb5JkS18ZiyipxzDakR8/xmd8GyDfxGg9y2KEHW2Pjlm4Zl4uHj8h2IW65yxmrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDvwLXleWrc+NXjelg4kT/ueHiclFjpttLlgBkT4kjQ=;
 b=X4KJLrIVrSCii6MQ92z6ysOocerGCA5mCKpcs9BMwKFAwgMMxHSVZnvEP7oPJbXghxlRUZ6XtWuKc0pja9kq1q4EfOPJ+WXCNH6DvQALPM0RNswdJj3ekud9Po1L3AYjDRwDTQZ1Swb9JZSfL6bBa6W/jZJalYQ7zHg8D+HxP+4SmKU0cgA4Jva6ODvHSweK+PbB70Z47QGw+6LkhKANX/pOtC/YX5/BcyyMnglrvgRRchHuzkVybpGZ+PqgqbWFNmweJq1htL4i44Jpt8kvh7i8CmPAP+NNY/KNwjNIg6g5olExbYnlIxUjAvIo34OfG9RKLDaQBRIfoFs7cW5yaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDvwLXleWrc+NXjelg4kT/ueHiclFjpttLlgBkT4kjQ=;
 b=j/MdsuwtaSQ7G1k+x/f/TWNuuRIvH5HKhcHEJqmXmQwS5Pa5Ig/HirVlMbmoXdZvaudrgL8GDrfZO9bpxpBILzV5klXDI4vs4gg/rbdcLGbkNg0HUicIG0aGGiH7Zy61KeEg/ZetDs9Hpf9S0dLag3Nyx1QiFBqhfMigJBpmQTg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 21:08:15 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.9009.018; Wed, 20 Aug 2025
 21:08:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC PATCH 4/7] drm/amdgpu: Add mmio_remap fields to amdgpu_device
Thread-Topic: [RFC PATCH 4/7] drm/amdgpu: Add mmio_remap fields to
 amdgpu_device
Thread-Index: AQHcEcZBP5O+rknIiEy4OTevG3f967RsCEMA
Date: Wed, 20 Aug 2025 21:08:14 +0000
Message-ID: <BL1PR12MB5144D6009B4CDB9327AA805EF733A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250820113254.3864753-5-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250820113254.3864753-5-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-20T21:03:51.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ2PR12MB7991:EE_
x-ms-office365-filtering-correlation-id: 398129f4-f2d3-4b1f-dd10-08dde02dadcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?U0RaVWxETEYzSGJRcUYxQ3VWRGx5RFRWdXQ5UmZaekF5Y2tNNkNOTkw2bzJt?=
 =?utf-8?B?dk9uOVJJQTkva1lXQ1hvclh1aDR2SXlBRzhpQURZaEFVNk9DOW50RzUveVU5?=
 =?utf-8?B?bVpraVFvZUlaVlRvWUUyWnJDMyt5cWNGYVZqQnd3Z0RQN251QkFOZjA4aWxw?=
 =?utf-8?B?NkxpRGRXRVVzVVNPSlE3WnVENXJpWk50ZzFJWHRMdU5GOGx1MElqVGpOdmFK?=
 =?utf-8?B?alh6cmRycXRZWmZWa3I0YnB3N2I4RnQzb3hFZmlxS3FBb0N1TkwzM045V0s0?=
 =?utf-8?B?UzhZQkxkcy9sWmlJN05JWW9ibTBpZFdKMEg4M1JXYUNPbXBXTTVnbWNNYW11?=
 =?utf-8?B?dG1XWGxub3Uxa3lpUmpic2JickJqTjVDeDl5WUNYb2RIOXNmSDZxNVZNUmMw?=
 =?utf-8?B?RTdOT0hvUGZjZ2V5aTg3M2Y3OTNBbzJEMlhaYlhpNk0rQ0JqM3RCRE9jcHdw?=
 =?utf-8?B?dkdwNUM2Y3lHb3BBN1dTc1BPWE1yRDhjcEMwS3hpMlBjUkFQdE9aY082djYx?=
 =?utf-8?B?U0lUbFowc3VNTUx1aDVVQzBXdm9QdHJpeHRUaUw5eUVVVFlzOFdzU2NwRWNH?=
 =?utf-8?B?MExRa09aUDdQQ3R0djBVK3pSNCtQU0ZBTFFlMUN5NGNBY3c1M2E0SEFUL3Bj?=
 =?utf-8?B?VnhTb2JHL0hNMEhtOHJzTDJYZ0c2RXQxWFQ1aGhPQ3YxcXFLdHlqOFlXMmV6?=
 =?utf-8?B?bkphajRsbHliZHJ3ejdxSFRDaXZhZEhFSnhMREhTQldwWHJqMll1ZVBQcHRT?=
 =?utf-8?B?SlVETlpIaGR0ZlF0R0xmeFA1TnZSSTFtNkRJUGRPTjVQRHBubnpkdHo0Y3V0?=
 =?utf-8?B?WGxZSTdKVFpOQVJ4aExMYVlrQjdGTVpQMytBQWJMdTBGaGdPaHNHb21rOWps?=
 =?utf-8?B?d0Z0dGNXUEpiRmloeklQcWdKK0xUblA5SkJhd09GakhpWTNNTitBbWZhUDY0?=
 =?utf-8?B?aDlPSi9lQlRIejh4OEUzMCtBZ1hxUVFhaGRsYTI3VVg1TmZxSXk5T2lwb3Bt?=
 =?utf-8?B?OGsrbWV5R1MyZmJudExOdDh0ODdxbmNQS1BSSkFyODg0TEhiZEU5ZEVVZFBU?=
 =?utf-8?B?bXM0UkpsSjRCQnk1RmpWOXdXeW9vcTFGWGVrQ2QvN2Q2Qkp1eDM0OHVjdENB?=
 =?utf-8?B?TG9BdkNXS2trcEZ6eEltdFVKUDRVUlVQK1hXT1lha1F4eU1NbU1iSHhTNGhN?=
 =?utf-8?B?bjhHczJYUzRwRXFXY1hySWdqMGd2aUc0M20xUzRHTjdpRDJvTXNBK05ZMzA3?=
 =?utf-8?B?UVpMNlpaTnlKWkUwUkxTYzdFd0pCV2JoQkx4WHUwQWFvSWNZV3psc2NySUFk?=
 =?utf-8?B?RGxIbk5WM2daZEptNXhVZDJHMkd2ZExQTnVlY0NxWjN3MUJXZmhpdDNnZStE?=
 =?utf-8?B?b3BCVU9TNnVaaUF2MmRYTEJ5OFBjRWd1RHhDOURBWjhwR3g4ODVMVWx3M211?=
 =?utf-8?B?SUxPcFB2TE1IK3NUUE9SZ0t5Nkx4OGVuaXZJV1M5bHJ5Nmt6b0dFMDlTZ1VR?=
 =?utf-8?B?Z2VRamVXdWpBQ01iV0tlMUdMK091cFBmS3hKUm1pTGVtYS9vc3M5WksvS0ow?=
 =?utf-8?B?UzlSd1REVEM5aW9idTNLc3pPS2g0cWtLRlF6bEVOM0toSU4vV3NWUENGb053?=
 =?utf-8?B?VU1NaVU0amJjSjlpZkRKNjh5L3lvVkpmRFMwRWd5NVhnT2J2LzFNWVpUYkp4?=
 =?utf-8?B?ZW9NYmMzb2t3TEtXZG4yU2pUT2tRMUJBd09sZXlEcy9BemVCbmMyMHhmcW1P?=
 =?utf-8?B?K0JPRVZoelh1RXZabzlWbjVZSHNGeGNOeVROMnFHQjE5T1BsT1FkY1VHb25s?=
 =?utf-8?B?Y3g5bUhTeUYxOWFmb3dsbCtiZjhMbGt4MGd3NWd0MnEyTmhqczN5OUMxWXhG?=
 =?utf-8?B?T29TZGY2aGNBQTRHN2doRzRiV1JaYThuODJCVEl2TXlDbkJtb0FETUtsQWJC?=
 =?utf-8?B?U1pOSzgwOVN0TmJVMTZPY3lqbGorOGljTGVwNk9FL0x1VndrMUtzaFlCaExk?=
 =?utf-8?Q?lV6QQyfECs9RDHjWdr4tig895hztds=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVFJTURWd2pVbHJGYllIKzM2NTVSVllwYUFwbHUvaWFkcWdjbERqbzJ4S0wv?=
 =?utf-8?B?c2ZSY3J1MWVzb3k4TkthekJsOCtwSk9KaFFUeEVqWGdJa1EzTjlPV1YrNXky?=
 =?utf-8?B?ZlQzSEthNmNObldKckpFSGZJKzVSOWRVVEwzRjk3NWg2MTBEdXdCMDVKcXVJ?=
 =?utf-8?B?cUhKZjk0aEZPdzdWSWxuci93a3BpSVlvcklSYlVTenFvMDA1RGF6Y0M5ZnVh?=
 =?utf-8?B?bGVkSWxDZ3p3cXFiMXVUL2hpOVExSGdwa01WSnRhRm9PYTFxbmp3Slc3RDlM?=
 =?utf-8?B?UzdSTnBvajYwQUF1aXk3WHdOdGF5Sk9QZTJySWNubmV6NnhCN25hWmZJUC9Y?=
 =?utf-8?B?V3UyYVcvS0JreUowV1pnV3poNHlyZUJQZ1JDWDB3My9FcG5mbzNnWGNHWENK?=
 =?utf-8?B?cm9Va1hsMHBBZitQbHkxdGJmTGFuL0syQkpZQ0hxeTQvNFV6aEJqeVNYd1ln?=
 =?utf-8?B?OFN6V0ZEZXBQQkJwaFNjcU9NZER0aHhXYUR1RkFIeDZjMmJISHpLanJrREh5?=
 =?utf-8?B?K09SKzFyM0taMlJKcWNsS2haNWFDMnVSZGxBUVV0cTVjcER6akJPamFMc1F3?=
 =?utf-8?B?a3ZOSDUzRUtOcUluTHlyMTlHVTZ0dS9QSGdBN2lKSkphcDQ3bkVJSVdBTUhm?=
 =?utf-8?B?Q1RseldMTmNlL21XclJYN0FJRkFPUjZOcGU5YTQ4VUs0bXdPZ2RuWDZ0YzRh?=
 =?utf-8?B?NUgrcCt1TzRZL0FxOGlGem1kMkZOUlZhU1Z5SkNLeUVTZ1ZCWlZqL2JnSHFI?=
 =?utf-8?B?dCtTK0JCUElLa2xlZzVseXhQZ3ZMMm44bmFNdG5LMjlsZTZBekZEYWp0WlNM?=
 =?utf-8?B?MXpScDBJWWpwdHA2MmdzaU9jMmJqQnlEUjlpR25pREQ5RHc3Q3R5STlaalM2?=
 =?utf-8?B?bGN5czhTQytmbkdJOUxuNnFLSXcwWGhGVUQ0aHUya0VnQlRMeDJhMzF5cWZa?=
 =?utf-8?B?SklPTUhNV2JLc2VITTJZdVVuK2pjZkVFREhhTWxjME1HNmdqVXQxSHhCeDlB?=
 =?utf-8?B?QTBCZVV5bWhRaHo1UW1GWHJwNWt4U3dGNzFiSEJmT1JjNkQzU0hlazVEK0wx?=
 =?utf-8?B?TVp0dEFpWWdMMVBDbDNza2VkVk1aVzhnR1lIOWo0UERQZnJic0VCUHkxdm42?=
 =?utf-8?B?aERETEhRZXg2N0o1cGR6Rzg4ZkR0TTJzTjRqM2p6NCtTSzZVdWVGaHU0ZzJH?=
 =?utf-8?B?dVVIYlViSmM1b3Q0SnlWWkhZeUJBRGJBTWwxR1RZeVgzbU1ydmViYm5NT01T?=
 =?utf-8?B?QlZGclpab0gydUhMMjFDVzhRdXg0Z3NRNmZzMnh6L1VvTW5CUjA2c3M0VFlO?=
 =?utf-8?B?MzFRMk5YdU4vK2NHVUUzNWZZUFBCQmZxQytiQm9qSGN6d0Y3L2Q5MkZuODhU?=
 =?utf-8?B?c0RacHJ4MEJDRk9lSkwrUDQ3TmdLZ2drY3FGWFQ0SzVXaCs2dUczVkVxM3R3?=
 =?utf-8?B?MWpJV0tQeWJCaVZpSnpnalFwakJ3UnJDckZJWnV1Qm5ZTmpOQkp2K1ZXRnE0?=
 =?utf-8?B?OWNzNkNRNVBSWGdOa3J5TWkxVkVhcHNGNVNONG9WaDNjdlRZRllUemh0Zzcy?=
 =?utf-8?B?ZWkvUmRzM05NQk9YSXNlU0dJeE5Vb2ZtZW44UjhCU0dRRGdFQ0ZTRkF1ekZL?=
 =?utf-8?B?UkdVdGNLZHZMalJiOW10bVlYSXZMSHFma0hKMDdpNTkzbFFnWnBVbzN2VkUz?=
 =?utf-8?B?S080ZGNJV2lyV2JXSFZyOEpRMDBJWnNaQzVFWXc0S1AxTFkxMVhEc0Erbi8x?=
 =?utf-8?B?cW5KRVd5ODFlY2Z2anNRWGhTeHI4QjRTUFJQOGEyZXc2c0l3RUtZbVJtV0hk?=
 =?utf-8?B?cnNBVFhiVXlvdndCTWZFRmhGbFR1NjJ0ZVFPWDBodmZMdWloRTZkWHl0K0l3?=
 =?utf-8?B?OHhpQlc1SUU0NmcwQUdPZUhOMGIzeFNJTTFEOHNweXBMc045VVlXUEhkc1NM?=
 =?utf-8?B?OGkweWp3cUFrc29MNTZjTGw3NmRKMWhZKzh1Nks4b0ViVkpVMEV0Q2hraHJM?=
 =?utf-8?B?K3RHS0VCWnFVajBKOE4rQjRkaTg5am1sUVE1U3k3M041alFEclB5cllibTVW?=
 =?utf-8?B?UlNXK1pibXBEWVIyczM5dGVuVGEvUEl5OEJ3aDE2T0tzQlBzcmIxbE94Tmgz?=
 =?utf-8?Q?Mww8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398129f4-f2d3-4b1f-dd10-08dde02dadcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 21:08:15.0197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxa7KvS+PpfZMiv2ui7Oyh4iRlQQ3DegjIZalNZq2uMdhGjQhWLzeCnT3wpe+jW7R1N5IyZIn1hAcpFdIqNsxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTSEFOTVVH
QU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgQXVndXN0IDIwLCAyMDI1IDc6MzMgQU0NCj4gVG86IEtvZW5pZywgQ2hyaXN0aWFu
IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZzsgU0hBTk1VR0FNLCBTUklOSVZBU0FODQo+IDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29t
Pg0KPiBTdWJqZWN0OiBbUkZDIFBBVENIIDQvN10gZHJtL2FtZGdwdTogQWRkIG1taW9fcmVtYXAg
ZmllbGRzIHRvIGFtZGdwdV9kZXZpY2UNCj4NCj4gQWRkIGJvb2trZWVwaW5nIGZvciB0aGUgcmVt
YXAgcGFnZSB0byBzdHJ1Y3QgYW1kZ3B1X2RldmljZToNCj4NCj4gKiBtbWlvX3JlbWFwX2JvIChz
aW5nbGV0b24gQk8pDQo+ICogbW1pb19yZW1hcF9iYXNlLCBtbWlvX3JlbWFwX2JhcnN6IChyZWdp
c3RlciBCQVIgYmFzZS9zaXplKQ0KPiAqIG1taW9fcmVtYXBfb2Zmc2V0IChCQVItcmVsYXRpdmUg
b2Zmc2V0IG9mIHRoZSByZW1hcCBwYWdlKQ0KPiAqIG1taW9fcmVtYXBfc2l6ZSAoUEFHRV9TSVpF
KQ0KPg0KPiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0K
PiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1kLmNv
bT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCB8IDcgKysr
KysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiBpbmRleCBkZGQ0NzJlNTZmNjkuLjZjNDc3NTk2NjE3
YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gQEAgLTEwMzgsNiAr
MTAzOCwxMyBAQCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSB7DQo+ICAgICAgIGFtZGdwdV9ibG9ja193
cmVnX3QgICAgICAgICAgICAgYXVkaW9fZW5kcHRfd3JlZzsNCj4gICAgICAgc3RydWN0IGFtZGdw
dV9kb29yYmVsbCAgICAgICAgICBkb29yYmVsbDsNCj4NCj4gKyAgICAgLyogPT09PT0gTU1JTyBy
ZW1hcCAoSERQIGZsdXNoKSBib29ra2VlcGluZyA9PT09PSAqLw0KPiArICAgICBzdHJ1Y3QgYW1k
Z3B1X2JvICAgICAgICAgICAgICAgICptbWlvX3JlbWFwX2JvOyAgIC8qIHNpbmdsZXRvbiBCTyAq
Lw0KPiArICAgICByZXNvdXJjZV9zaXplX3QgICAgICAgICAgICAgICAgICBtbWlvX3JlbWFwX2Jh
c2U7ICAvKiBSRUcgQkFSIGJ1cyBiYXNlICovDQo+ICsgICAgIHJlc291cmNlX3NpemVfdCAgICAg
ICAgICAgICAgICAgIG1taW9fcmVtYXBfYmFyc3o7IC8qIFJFRyBCQVIgc2l6ZSAqLw0KPiArICAg
ICByZXNvdXJjZV9zaXplX3QgICAgICAgICAgICAgICAgICBtbWlvX3JlbWFwX29mZnNldDsvKiBC
QVItcmVsYXRpdmUgb2Zmc2V0IG9mDQo+IHJlbWFwIHBhZ2UgKi8NCj4gKyAgICAgcmVzb3VyY2Vf
c2l6ZV90ICAgICAgICAgICAgICAgICAgbW1pb19yZW1hcF9zaXplOyAgLyogYWx3YXlzIFBBR0Vf
U0laRSAqLw0KDQoNCkFsc28gbWF5YmUgcHV0IHRoZXNlIGluIHRoZWlyIG93biBzdHJ1Y3QsIHNp
bWlsYXIgdG8gd2hhdCB3ZSBkbyBmb3IgZG9vcmJlbGxzIGFuZCBkcm9wIHRoZSBtbWlvX3JlbWFw
IHByZWZpeC4gIEUuZy4sDQoNCnN0cnVjdCBhbWRncHVfbW1pb19yZW1hcC57DQogICAgcmVzb3Vy
Y2Vfc2l6ZV90IGJhc2U7DQogICAgcmVzb3VyY2Vfc2l6ZV90IHNpemUNCiAgICBzdHJ1Y3QgYW1k
Z3B1X2JvOw0KfTsNCg0KQWxleA0KDQo+ICsNCj4gICAgICAgLyogY2xvY2svcGxsIGluZm8gKi8N
Cj4gICAgICAgc3RydWN0IGFtZGdwdV9jbG9jayAgICAgICAgICAgIGNsb2NrOw0KPg0KPiAtLQ0K
PiAyLjM0LjENCg0K
