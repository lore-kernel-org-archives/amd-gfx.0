Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC0FCAC5B5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 01:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86BAE10E1DB;
	Fri, 26 Sep 2025 01:15:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0vB9Rjom";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011003.outbound.protection.outlook.com [52.101.57.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB7910E1DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 01:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3aN3YV26keQmKQ4pwO0OH2DiZ1YodHonLrTg5keAgyLp7sFEYuizlrJlzDZvU8Wdx4v0mS3G4SrgeC0UPT7kdjDpWQVA43TpV2OFikaVTsrcTDvpJBMEpbrPP/8wvGtQFbyoyKgvUMAqM3ErRjmPFPfdY3yspERLJyieGL0om2V7INj8ixRYDOP4nFgWzcrJeyMdtXIuNbqZJuR8rMLsd++C3ohkwTtLn9u20CoIjriWPiVyLtd982Uiy/EoJhBBA/JS1sNCEiV4c6aitXHijZJD+nTzjvcipQ/G4gIRKXxN8a83CJbSfoIRzxpbiPyGUR0l80z+Bi3R2XbwVXQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iNysbV2vFztU4dpxAyUDaS193ZJkfq5MJWIjiR9OKs=;
 b=VQ28AI2epT1lgVdi+yIOL0pkiio2xFmPvM+AwkPWpXXHkApyOT7lpj3ONcfKjxws/Vnjch1b6e973q2OR0LJigHUcntP6Tp+vG12ENDwE0jg9mp5z8QqpcjoGzSKbft9GxJyx7/Pch/1HNwwdkyjWBzQxQ0h0lqBwELHb4lNR6afCpM7rM5Ie2xLa5LmyvDcBp1bWE25ACE7Xgo8w5AdEWVUB6PPR76m+5bPuYy4qBGyqkZP3s/t5r4TroihQdQjeshbBO7QCYV6muP912+bk1wC9Nm4ao6htla60Kgj4zc1cLs+pP/5eY89Wvamg2LHDt1H4HEasXia1APAB8cDNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iNysbV2vFztU4dpxAyUDaS193ZJkfq5MJWIjiR9OKs=;
 b=0vB9Rjom8jlIDMBpLIuILvUEoOwUfd8AolHmIYNVUMXQAxOeoqna9rZGa2u+1FW8doy5KDqlrskMn6be0J0+Fbu1TYx3f/RiaNkT1suc64bj3XWCf6WNiJrWFhUe2kn+XuiTfWxiRFfwqyhjxDlTIUmmhm2vwad6o2A3PnoGFPI=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by IA0PR12MB8896.namprd12.prod.outlook.com (2603:10b6:208:493::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 01:15:37 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 01:15:37 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v4 1/2] amd/amdkfd: resolve a race in
 amdgpu_amdkfd_device_fini_sw
Thread-Topic: [PATCH v4 1/2] amd/amdkfd: resolve a race in
 amdgpu_amdkfd_device_fini_sw
Thread-Index: AQHcLWgTnPLagjuNFECF58wZePJndLSi7+WAgAFVpYCAAGElkA==
Date: Fri, 26 Sep 2025 01:15:37 +0000
Message-ID: <CY5PR12MB6369CEE4F7341EA964855FBDC11EA@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20250924152929.2234747-1-yifan1.zhang@amd.com>
 <ccc729b8-640e-6e71-3522-7208413990f0@amd.com>
 <08f80a38-2aa6-49fd-a16d-2b460f2a2403@amd.com>
In-Reply-To: <08f80a38-2aa6-49fd-a16d-2b460f2a2403@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-26T00:59:02.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|IA0PR12MB8896:EE_
x-ms-office365-filtering-correlation-id: 3d44f454-b3b1-4cde-6666-08ddfc9a336e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?eXhaQ0FmOHRjZm5xR0dKRVBBSVd1blo1aGdEYVNEcnYwV2tQU1dQbVJSVE9a?=
 =?utf-8?B?dGJockZNdm1LVFpUeEx5RTQrNllqcitVRjFHYjhXeER5WFgrcGF3R3prY0tN?=
 =?utf-8?B?RUJ0ZGErdDl2TFhwUVhIdXJJTGdzbFV5UnA1TlpxNmMwanVibUhZSVRXdDJa?=
 =?utf-8?B?eUQwbXZERVdrYTQxN0VBenpiVWFOalpwRGJRUU9JNUVyT3ZNc0hiY2NHMUIw?=
 =?utf-8?B?ZlV1dERibFA2Vy9aNkRpZS9NdHlhaUdvTXlqOENBdnhCTFhOMWpvVjJUZ0cw?=
 =?utf-8?B?K2grRWtJWjNQa3Qxc1JiN1o3RzhKWU53L0pYNUxrVmpJZXRoQ2x3ZTNzRlFn?=
 =?utf-8?B?REhjNjdLS0lybEJSYU9jUG9NNFlEN0FNbm1GVGlGbWlucUZ4U1I1K3YyM0d6?=
 =?utf-8?B?YW9GYUVvQngrTUlheTQ4bHBmNC9VYkV2cDAzeGlHcmttWDlvVnJzMmpMVUdn?=
 =?utf-8?B?RmNZc3ZMR2F0d3Z3dWVkOVZ2eHNudnZ3R25XT0s1UTR0NUIrNXZrYUY3ZWk2?=
 =?utf-8?B?Um0yamx2bUdJUE5pTGxram1aWlNsSVdQeGxvK01Wdm9JZzgzTDdEQlZpVm1t?=
 =?utf-8?B?VnJMenlIbjdWTkdFcDJGaGNJZytnRzA0WGxVVFV3K2lMcVE2eHg3WExDMWk1?=
 =?utf-8?B?VkM5OFRFYXA5Wkc2U3ZiRzFydnZpZytqakNvbHMzejVjOUxlNHBjM2lsOEVQ?=
 =?utf-8?B?Nno1dFdUR1JIRmRNRklmVUFzWTFiUXl6NGtFdlY0N3h4eGN4dTNxUVZLbzAr?=
 =?utf-8?B?LzlPL0xLWHVNem9icHRLMHl6U1ZrSzVvRDJQRzNwcDlHZUhlc1hkN3E2V3Vx?=
 =?utf-8?B?N0ltWTF1Z1VuYjQ0ZHRrLy9NdittQ05iWUNwa1F4WEhEbXNUbmRjZGNZZUZK?=
 =?utf-8?B?UFF3M2NWdGZZODIycXpLWnBzNWlERWYzZGJ6eTlHU21CL0ZUYXdIOGk3YTBL?=
 =?utf-8?B?cUpKaVhrb29WSDN3U1Q3cTRaMjA5T1J1c1RQNFFEVmd2U1g3Q0JOUVowdlRM?=
 =?utf-8?B?YmhDckdGY2tQcUl5Z2xMaTgxWks5SFl0dm00MzFoVzRacUFlUXkrVm1YWjV1?=
 =?utf-8?B?WHVSdmRkbzR2NkZhZUxmYm0zVGM3UWUxRkpzSUs5NC9aWC96Lzk0RW9lTEJv?=
 =?utf-8?B?cUVCUmtBVnJOU1kwVE4rVG5KTTJ6V0NWcjZsOGJ0NlFKb1lXQUp1aC81T1k2?=
 =?utf-8?B?QjRvMS9rKzVxZUhER3hoMld0empJdnBWVmpVRDhFZzRxYi83bFI0QlJRK2Zv?=
 =?utf-8?B?aHI0d1dkTGNHRnExdi9VcTM0UjNBRUNjVzBhLzNNSmVUbWJDNGduR2FSZ2oz?=
 =?utf-8?B?bG5ibkRLWWlLRklhMVMrQU5ITFBGeWFRWkFsZEQ4NGhrL2tzeW1xWTF1bXgy?=
 =?utf-8?B?ak1nWmZyZUZ6cVlqeG5BMmhsYWRLUjYwVEVhRUg2SzZYOWVob2hWdFRSSFpY?=
 =?utf-8?B?TzVwNDJGOHBOMGtPZjhhQUc4bTg5azc0K1pFODUwKzREdkFLOVdDcUk0ZldY?=
 =?utf-8?B?b0RRYjBEOURkMFZBTENaS2pCTC9hRjlPTTc1WDI5TlU1czUrVnR6K1g3bTFG?=
 =?utf-8?B?RWthMFJrbzlHOGp0L210dzRydU9iWGkrVXI0bHJkc2NOSTRBTGJ1dGtuMDAx?=
 =?utf-8?B?NGdFMytpeldxbnZGRG9ldWQ0WmdJMjFhdUFCeGZSMGVITXQyb2FEYkt0Y0po?=
 =?utf-8?B?RllOSVY5NHVvOElmLzNGTnhFdzBCalJ1cXdDWkN4RmRnZHY0akRNNzZjelh5?=
 =?utf-8?B?enRBTGx1TFJjbG55akhWWjJPSTdEQkJ4ZFZadGVqRlNIWTZSOW5hREUzM0Qw?=
 =?utf-8?B?UERVUjZDdExEYjFtSVduVnRxUlBEeUEzMGxnR3RKaWZPOE5xRDJHNWNSMHNE?=
 =?utf-8?B?QklZRFU2WFBGeG9LUTFSSmt1STRQNzljYjFnYzFHREIwbXIrZFpuQTJLMUd6?=
 =?utf-8?B?blNtTi9mM1JiTW94U3pKRVBua2ZQbTY2aDhYM0dlLzYrMXZhOC9ld1YvUWRH?=
 =?utf-8?B?RjJwTXhRVFFNTXErcVgxWkhLMjhzd1AxZmtYTkphQmwvcGYxSG5OR3MyWDla?=
 =?utf-8?Q?XZlHjk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGN1aGM1cjJkSThsNnFlZ0QyWG9PRTlTNGx4dGlpbmRzUVZlZVdSQTZhTUEy?=
 =?utf-8?B?TEFtdDljdXJ2bFdmak1FVW5sQ0hTQjRFY1FrQTVrbzd4M1duMnpVZkNDSmVl?=
 =?utf-8?B?K1dkZXJzYTE4bnhSeVFOU0J3d0svZzRCZjMwSVZaZFh6WmhwY2pPYnpYc2t6?=
 =?utf-8?B?NFFJbDBWTWx2M2gxMzVJeklIZGNxQ3NRSmU2NmVhWDE0SEVYS1E4SFZTV2hx?=
 =?utf-8?B?YmUxZEhzTXcxY3FGSHhraTNoaUhNdVQrT0l0Y3IyTlZjYVBYMkN4SWJqOUV2?=
 =?utf-8?B?YTA3c3lycG5TYUkyRmEzdGhsN0tDOGwrRVdDYXQxS3orN2tlTVNOY2o3QndG?=
 =?utf-8?B?bW0zRTk5alM1bEhyVlBXSVRsdGYwTkNIYWo5NnZsbllkM1J6aVVvZmNjemhK?=
 =?utf-8?B?a2J4cHJXY0R1WXhaenFPY1I4T1ZsdElsOHMrSFNBL2dsWGw2YmxPNFdPYUJn?=
 =?utf-8?B?MGpaL29vcVJmTWtkK3ZmaVhxTDZVY1BNNDBZNXJRUkZlMWNPSkhQbFltNWFi?=
 =?utf-8?B?Q1lHaGRRQWE5QmhuK2Y0ekFFMTdWUk11alkxWXVRaVBQUVV0VXpaU3JodVJF?=
 =?utf-8?B?ak1KRUtlUVpPM0tyVm5xd004dHlvQXJXWW1nelUwMVoyK1FiZjVnZHpkLzRL?=
 =?utf-8?B?Z3VPYjJPd0Z1aUo0TmQwVjFqdDVrTklpdDhhMVN5RUdyeVdDL2VpYWNoQWxu?=
 =?utf-8?B?MXZ1QW5uMHp4bCtadTk3V1hTZ3pDRVdqVE1uU0xBYVM3MlV3eHpmQk96SmJS?=
 =?utf-8?B?SzBleXhhYk1kVlhWcU1keS8xL2hxdXBvR1MxZGd5V202SWNyZVYyM0dkUnBT?=
 =?utf-8?B?all6S05IYldmMDB3TmMwMkovVlNnVWhRUTdXSXhobWRON0d0M1o2Z1hnY0c1?=
 =?utf-8?B?aStGa0NiSHF4L1FsSmJrQ0lRR2lRWDEvdWVCOWVEZ0Q4MlBTUEtyRi95NStV?=
 =?utf-8?B?WWFnS3M1VEZWQUZVNUg3TytTbnVvcUc0ZkZQVi83ODUvQ3VIOE5ObnNSVy8x?=
 =?utf-8?B?UUFZYjlJUXZiWHNQN1dUa0tSZnlmNWNLS2dlaXlqanQyVnpmeFEwSXhBZVVs?=
 =?utf-8?B?UHcwdy9xZTlvRi9XbS9la05PcUd6cG5XWHZQaklSZDArbGlsOUdGc2xqUGNV?=
 =?utf-8?B?RUtVZ2NYRUErdXNMc283WTBicVdzUGV5UXFEMnRUQTBiSVpVZVhXcjc2S1RR?=
 =?utf-8?B?Z01XUkwrRnptTDVBaitmL1R0eG1VM3ZMaVAzWmZyYVpYLzZRWEF0M0ZxZEFJ?=
 =?utf-8?B?ZmVLYnlmZUN5ZFIxcUNTeThDd01oSDFGU2dTWDg4N2ZUemsxSDhVYmNhbnVC?=
 =?utf-8?B?NE0wM1hhRG1hendnRkhOZHgySTErRThHVzY0N1FYMDlja1dMUS9GSmR5YVhk?=
 =?utf-8?B?RG1PdExVc0luREFkK1ZWdnZ6Q2w1VFhiSGNVVGpoV1A3MHdRckthaHVybHZB?=
 =?utf-8?B?ODFKSWJDVHArM3lIL01zLy9najBsSmg0ZCtNWUZpTmlnM1ZCVUVsc211alRL?=
 =?utf-8?B?ZTJZRi94K0xNeGtTMHNwOWdjNk5TOFNOTmd0NjBkelg4TFBYbWYyR3ZKb0ZN?=
 =?utf-8?B?dHdmOUtuUnVOSFdwYStRSGVYSi9ZMXF1MGFSRllqMElMbzdTazBzOTNOeHpx?=
 =?utf-8?B?N1JrRSszbHIvSVM5UnEvUG92UzhNWUh3Y3h1WXEwaFNmSE9pOElBQWZ0L0FD?=
 =?utf-8?B?dDV5d1JhczYxNmNCUmVWTTdjOTliOFhQQXRnYnFuT01UK2NLWm9CZmlScVRD?=
 =?utf-8?B?N0dFakkrV2M4eHBqYzdwQnpOYjlzR1VKUE9oOHI0SUV4SEFnRTM5TWdwWjFi?=
 =?utf-8?B?TGlvRkFaYnpvMG1nSFVoSUhINElPczkyVGFzcHdKV1dLV0pzb2tTWklaZ0xm?=
 =?utf-8?B?Nkg2R1poeFdPOXpXTmJwb3kvZk5JMEw1ODhvVGRoVVA1VTRnWjgwVGhaVEx6?=
 =?utf-8?B?dWhrd1RmM3hOYURSYmFnUDh3RlVtdlI5MDUvaks5ckI1bGlyWWdaZlJISWU5?=
 =?utf-8?B?Vzl1RUZyRUdVMjFxRzVZd3hNV3d3R01FMnZZUE9zMld4UGJ6VVJ6Nnc4MU02?=
 =?utf-8?B?MVh4KzhzdUNNazhSRVhDQXpaWDNENFkwQllMOUxUck5FN2ZPUHQ0VHE2Q3Av?=
 =?utf-8?Q?FPBA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d44f454-b3b1-4cde-6666-08ddfc9a336e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 01:15:37.3892 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMuGFR9Qpu5Sjwij8n7S8yZCGGNibT3X86zety3vGfRk66G9oaOumj03bRatqnFf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8896
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
Cg0KZmx1c2hfd29ya3F1ZXVlKGtmZC0+aWhfd3EpIGFuZCBkZXN0cm95X3dvcmtxdWV1ZShrZmQt
PmloX3dxKSBpbiBrZmRfY2xlYW51cF9ub2RlcyBjbGVhbiB1cCBwZW5kaW5nIHdvcmsgaXRlbXMs
IGFuZCBub2RlLT5pbnRlcnJ1cHRzX2FjdGl2ZSBjaGVjayBwcmV2ZW50IG5ldyB3b3JrIGl0ZW1z
IGZyb20gYmVpbmcgZW5xdWV1ZWQuIFNvIGFmdGVyIGtmZF9jbGVhbnVwX25vZGVzIGZyZWUga2Zk
IG5vZGUsIHRoZXJlIGlzIG5vIHBlbmRpbmcga2ZkIGloX3dxIHdvcmsgaXRlbXMuDQoNCkFuZCBJ
IGFncmVlIHRoZXJlIGlzIHN0aWxsIHBvdGVudGlhbCByYWNlIGhlcmUsIHNpbmNlIGtmZC0+bm9k
ZXNbaV0gTlVMTCBjaGVjayBpcyBub3QgcHJvdGVjdGVkIGJ5IGxvY2suIFdpbGwgYWRkcmVzcyBp
dCB0b2dldGhlciB3aXRoIHRoZSBpc3N1ZSBMaWpvIG1lbnRpb25lZC4NCg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hlbiwgWGlhb2dhbmcgPFhpYW9nYW5nLkNoZW5AYW1k
LmNvbT4NClNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDI2LCAyMDI1IDM6MTEgQU0NClRvOiBZYW5n
LCBQaGlsaXAgPFBoaWxpcC5ZYW5nQGFtZC5jb20+OyBaaGFuZywgWWlmYW4gPFlpZmFuMS5aaGFu
Z0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLdWVobGluZywgRmVsaXggPEZl
bGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBZYW5nLCBQaGlsaXAgPFBoaWxpcC5ZYW5nQGFtZC5jb20+
OyBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCB2
NCAxLzJdIGFtZC9hbWRrZmQ6IHJlc29sdmUgYSByYWNlIGluIGFtZGdwdV9hbWRrZmRfZGV2aWNl
X2Zpbmlfc3cNCg0KDQpPbiA5LzI0LzIwMjUgNTo0OCBQTSwgUGhpbGlwIFlhbmcgd3JvdGU6DQo+
DQo+IE9uIDIwMjUtMDktMjQgMTE6MjksIFlpZmFuIFpoYW5nIHdyb3RlOg0KPj4gVGhlcmUgaXMg
cmFjZSBpbiBhbWRncHVfYW1ka2ZkX2RldmljZV9maW5pX3N3IGFuZCBpbnRlcnJ1cHQuDQo+PiBp
ZiBhbWRncHVfYW1ka2ZkX2RldmljZV9maW5pX3N3IHJ1biBpbiBiL3cga2ZkX2NsZWFudXBfbm9k
ZXMgYW5kDQo+PiAgICBrZnJlZShrZmQpLCBhbmQgS0dEIGludGVycnVwdCBnZW5lcmF0ZWQuDQo+
Pg0KPj4ga2VybmVsIHBhbmljIGxvZzoNCj4+DQo+PiBCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIg
ZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAwMDAwOTgNCj4+IGFtZGdwdSAwMDAwOmM4
OjAwLjA6IGFtZGdwdTogUmVxdWVzdGluZyA0IHBhcnRpdGlvbnMgdGhyb3VnaCBQU1ANCj4+DQo+
PiBQR0QgZDc4YzY4MDY3IFA0RCBkNzhjNjgwNjcNCj4+DQo+PiBrZmQga2ZkOiBhbWRncHU6IEFs
bG9jYXRlZCAzOTY5MDU2IGJ5dGVzIG9uIGdhcnQNCj4+DQo+PiBQVUQgMTQ2NWI4MDY3IFBNRCBA
DQo+Pg0KPj4gT29wczogQDAwMiBbIzFdIFNNUCBOT1BUSQ0KPj4NCj4+IGtmZCBrZmQ6IGFtZGdw
dTogVG90YWwgbnVtYmVyIG9mIEtGRCBub2RlcyB0byBiZSBjcmVhdGVkOiA0DQo+PiBDUFU6IDEx
NSBQSUQ6IEAgQ29tbTogc3dhcHBlci8xMTUgS2R1bXA6IGxvYWRlZCBUYWludGVkOiBHIFMgVyBP
RSBLDQo+Pg0KPj4gUklQOiAwMDEwOl9yYXdfc3Bpbl9sb2NrX2lycXNhdmUrMHgxMi8weDQwDQo+
Pg0KPj4gQ29kZTogODkgZUAgNDEgNWMgYzMgY2MgY2MgY2MgY2MgNjYgNjYgMmUgT2YgMWYgODQg
MDAgMDAgMDAgMDAgMDAgT0YNCj4+IDFmIDQwIDAwIE9mIDFmIDQ0JSAwMCAwMCA0MSA1NCA5YyA0
MSA1YyBmYSAzMSBjTyBiYSAwMSAwMCAwMCAwMCA8Zk8+DQo+PiBPRiBiMSAxNyA3NSBCYSA0YyA4
OSBlQCA0MSBTYw0KPj4NCj4+IDg5IGM2IGU4IDA3IDM4IDVkDQo+Pg0KPj4gUlNQOiAwMDE4OiBm
ZmZmYzkwQDFhNmIwZTI4IEVGTEFHUzogMDAwMTAwNDYNCj4+DQo+PiBSQVg6IDAwMDAwMDAwMDAw
MDAwMDAgUkJYOiAwMDAwMDAwMDAwMDAwMDAwIFJDWDogMDAwMDAwMDAwMDAwMDAxOA0KPj4gMDAw
MDAwMDAwMDAwMDAwMSBSU0k6IGZmZmY4ODgzYmI2MjNlMDAgUkRJOiAwMDAwMDAwMDAwMDAwMDk4
DQo+PiBmZmZmODg4M2JiMDAwMDAwIFJPODogZmZmZjg4ODEwMDA1NTAyMCBST086IGZmZmY4ODgx
MDAwNTUwMjANCj4+IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAwMDAwMDAwMDAwMDAwMDAwIFIxMjog
MDkwMDAwMDAwMDAwMDAwMg0KPj4gZmZmZjg4OEYyYjk3ZGEwQCBSMTQ6IEAwMDAwMDAwMDAwMDAw
OTggUjE1OiBmZmZmODg4M2JhYmRmbzAwDQo+Pg0KPj4gQ1M6IDAxMCBEUzogMDAwMCBFUzogMDAw
MCBDUk86IDAwMDAwMDAwODAwNTAwMzMNCj4+DQo+PiBDUjI6IDAwMDAwMDAwMDAwMDAwOTggQ1Iz
OiAwMDAwMDAwZTdjYWUyMDA2IENSNDogMDAwMDAwMDAwMjc3MGNlMA0KPj4gMDAwMDAwMDAwMDAw
MDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwDQo+PiAwMDAw
MDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlTzdGTyBEUjc6IDAwMDAwMDAwMDAwMDA0MDAN
Cj4+DQo+PiBQS1JVOiA1NTU1NTU1NA0KPj4NCj4+IENhbGwgVHJhY2U6DQo+Pg0KPj4gPElSUT4N
Cj4+DQo+PiBrZ2Qya2ZkX2ludGVycnVwdCtAeDZiLzB4MWZAIFthbWRncHVdDQo+Pg0KPj4gPyBh
bWRncHVfZmVuY2VfcHJvY2VzcysweGE0LzB4MTUwIFthbWRncHVdDQo+Pg0KPj4ga2ZkIGtmZDog
YW1kZ3B1OiBOb2RlOiAwLCBpbnRlcnJ1cHRfYml0bWFwOiAzIFljcHhGbCBSYW50IHRFcmFjZQ0K
Pj4NCj4+IGFtZGdwdV9pcnFfZGlzcGF0Y2grMHgxNjUvMHgyMTAgW2FtZGdwdV0NCj4+DQo+PiBh
bWRncHVfaWhfcHJvY2VzcysweDgwLzB4MTAwIFthbWRncHVdDQo+Pg0KPj4gYW1kZ3B1OiBWaXJ0
dWFsIENSQVQgdGFibGUgY3JlYXRlZCBmb3IgR1BVDQo+Pg0KPj4gYW1kZ3B1X2lycV9oYW5kbGVy
KzB4MWYvQHg2MCBbYW1kZ3B1XQ0KPj4NCj4+IF9faGFuZGxlX2lycV9ldmVudF9wZXJjcHUrMHgz
ZC8weDE3MA0KPj4NCj4+IGFtZGdwdTogVG9wb2xvZ3k6IEFkZCBkR1BVIG5vZGUgWzB4NzRhMjow
eDEwMDJdDQo+Pg0KPj4gaGFuZGxlX2lycV9ldmVudCsweDVhL0B4Y08NCj4+DQo+PiBoYW5kbGVf
ZWRnZV9pcnErMHg5My8weDI0MA0KPj4NCj4+IGtmZCBrZmQ6IGFtZGdwdTogS0ZEIG5vZGUgMSBw
YXJ0aXRpb24gQCBzaXplIDQ5MTQ4TQ0KPj4NCj4+IGFzbV9jYWxsX2lycV9vbl9zdGFjaysweGYv
QHgyMA0KPj4NCj4+IDwvSVJRPg0KPj4NCj4+IGNvbW1vbl9pbnRlcnJ1cHQrMHhiMy8weDEzMA0K
Pj4NCj4+IGFzbV9jb21tb25faW50ZXJydXB0KzB4MWxlLzB4NDANCj4+DQo+PiA1LjEwLjEzNC0w
MTAuYTFpNTAwMC5hMTgueDg2XzY0ICMxDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWWlmYW4gWmhh
bmcgPHlpZmFuMS56aGFuZ0BhbWQuY29tPg0KPiBSZXZpZXdlZC1ieTogUGhpbGlwIFlhbmc8UGhp
bGlwLllhbmdAYW1kLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfZGV2aWNlLmMgfCAxMCArKysrKysrKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9kZXZpY2UuYw0KPj4gaW5kZXggMzQ5YzM1MWUyNDJiLi4wNTFhMDAxNTJiMDgg
MTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMN
Cj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYw0KPj4gQEAg
LTExMzMsNyArMTEzMywxNSBAQCB2b2lkIGtnZDJrZmRfaW50ZXJydXB0KHN0cnVjdCBrZmRfZGV2
ICprZmQsDQo+PiBjb25zdCB2b2lkICppaF9yaW5nX2VudHJ5KQ0KPj4gICAgICAgfQ0KPj4gICAg
ICAgICBmb3IgKGkgPSAwOyBpIDwga2ZkLT5udW1fbm9kZXM7IGkrKykgew0KPj4gLSAgICAgICAg
bm9kZSA9IGtmZC0+bm9kZXNbaV07DQo+PiArICAgICAgICAvKiBSYWNlIGlmIGFub3RoZXIgdGhy
ZWFkIGluIGIvdw0KPj4gKyAgICAgICAgICoga2ZkX2NsZWFudXBfbm9kZXMgYW5kIGtmcmVlKGtm
ZCksDQo+PiArICAgICAgICAgKiB3aGVuIGtmZC0+bm9kZXNbaV0gPSBOVUxMDQo+PiArICAgICAg
ICAgKi8NCj4+ICsgICAgICAgIGlmIChrZmQtPm5vZGVzW2ldKQ0KPj4gKyAgICAgICAgICAgIG5v
ZGUgPSBrZmQtPm5vZGVzW2ldOw0KPj4gKyAgICAgICAgZWxzZQ0KPj4gKyAgICAgICAgICAgIHJl
dHVybjsNCj4+ICsNCg0KS0ZEIGludGVycnVwdCBpcyBoYW5kbGVkIGxhdGVyIGluIHdxIG5vZGUt
PmtmZC0+aWhfd3EgYXQgaW50ZXJydXB0X3dxIHdoaWNoIHVzZXMgIGtmZC0+bm9kZXNbaV0uICBD
aGVja2luZyAiIGtmZC0+bm9kZXNbaV0gPT0gTlVMTCIgaGVyZSBpcyBub3QgZW5vdWdoIGFzIGtm
ZF9jbGVhbnVwX25vZGVzIGNhbiBmcmVlIGtmZCBub2RlIGF0IGFueSB0aW1lLg0KDQpSZWdhcmRz
DQoNClhpYW9nYW5nDQoNCj4+IHNwaW5fbG9ja19pcnFzYXZlKCZub2RlLT5pbnRlcnJ1cHRfbG9j
aywgZmxhZ3MpOw0KPj4gICAgICAgICAgICAgaWYgKG5vZGUtPmludGVycnVwdHNfYWN0aXZlDQo=
