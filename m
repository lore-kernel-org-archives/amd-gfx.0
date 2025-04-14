Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1422C3601E
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 02:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7249710E44A;
	Mon, 14 Apr 2025 02:13:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mk8q6EU+";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D59B510E446
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 02:13:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNI92BmO0a3/psftadGlTwrg42Pm5Jg9+o1zJC5i/lxl1Mbgq7XnSHEZUsBdlBUcFtSg5yrtvnGpj8WNrWWJqrzSF9+4QwwcpVhS7dhtVkn4OolyvLudQDxj+ZPZj0AHecgcmu3RLcQBVJpdwomxGB11nPHtX/ABZV6ooFwOQIWtoZYNjHocIl6rhvNihJsGUPhOS04lM1j6pqZ6VjvnTMKaWxeABo2qUfIyTaP/8zxyEa8qBGC5c3uF43nzdDBZPhSXQJzfGc5RodnR1gKqfLwJQwxtqOck2GsNPfW17a3LjrHSA0tRFC2KBwOZGCSawbr/B5NgQJPwI66dVVQH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+IhZkWNYl5WO8RYNz9sN/dTYDh9ifskNSzBxJuJ/dk=;
 b=ATKrcXIxU5jBubJMPMBdXCyjjo+h7mGUyi1mUadAJ+H/PLZiqR0qDSgW25zputUtmMQUEbDQXj+oZ5yGLPJ3++/ZsgpZbPFzXSnhBP4TNplrwIPU2JEQMXugw+U5M5IL+u+mdWrMa6X7WNna4MevG+7B6jHYIxtcXswtEG/piT62lmj64adrgWcVv7rEBlB2R8umrLgTRKniUOyY1GczaCoxfu3nJ4pUmBrVmRc1izVTZSR7GgLlbxwG25JhxXgmBOsDhkICuxKO3xZK+5vr505FUmFRy9J0h6vSddD79e74NN4bjsapzpDIv3qzsT8AyDOSO9BoL3ONPtJtx4SrlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+IhZkWNYl5WO8RYNz9sN/dTYDh9ifskNSzBxJuJ/dk=;
 b=Mk8q6EU+FpFtkAZom474Uy5au5Xa2fW0AQq3efGeG18No2dWZZpWjyToLicsL1Uh4u7D3/sgtQEA+GrBl/A7IZNsw93tW2xd6VdZNnQc0dm+8KD54XTePDOEHRslTqDq6T7ZKGl28KgQjMokdzqXQCis1itGDfwP5Jo5vHFOEjs=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Mon, 14 Apr
 2025 02:13:26 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%7]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 02:13:26 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Clear overflow for SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Clear overflow for SRIOV
Thread-Index: AQHbqrVHou+4ww/Fa0ahQwkf8JozzbOecQEAgAP/GIA=
Date: Mon, 14 Apr 2025 02:13:26 +0000
Message-ID: <PH0PR12MB5417567E6A3E586F58895BAB8FB32@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250411074222.1055228-1-Emily.Deng@amd.com>
 <CADnq5_PHmcC_3NVuV=xCYv5VfaqDVufEz65yPK3_+Uh7mkV0jQ@mail.gmail.com>
In-Reply-To: <CADnq5_PHmcC_3NVuV=xCYv5VfaqDVufEz65yPK3_+Uh7mkV0jQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3cbb2d86-bf67-461b-b385-b6b305cab147;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-14T02:13:05Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|PH8PR12MB7255:EE_
x-ms-office365-filtering-correlation-id: 84b0fe47-40e3-4912-75ba-08dd7af9f0e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Mk5mR3R5cFFxOVBzQmt4MTB3YWxHSjhCYUg3eGRzUkE5bm5lckVPaVUrcUk2?=
 =?utf-8?B?RldzSmc5ZTV0eHhuN1ZKMlZHVXZpbVErM2hQSkJrRC9GOE1LcTZ0bzZxUFZ1?=
 =?utf-8?B?LzkwSHhRaC9RVnVENHo5OGZQd3JNdnhlOFlRdVczdncva0RlUU5jYW8zaktO?=
 =?utf-8?B?ZE0ySFNFckszSWFXZzNyQXJ5SUcrTXlScVNUdzZkQTV6SzNUNlJCYzRpaVI4?=
 =?utf-8?B?L3h1L0xXZGpmZ3JpeFU2SzZud1JFZjY5OUJMeHhYRFZYM2tYK2kvVmlXRTdO?=
 =?utf-8?B?ZWNqdndJSlk5anpMUkRjOXR6ekNXRjNKajhCVHpDZllzZHh1VjIxeVJrelpJ?=
 =?utf-8?B?VnhsTEZkS2ROZHZxNS9vNWl6SCtBa0pwNm5Vc2xRbmx5blJjSkZuTlhVNWdx?=
 =?utf-8?B?Yit2VTlOZFMrczZKMUp5NTV1ZCs3eU1WNk5iQW9hL21ZNlR3Y3BIejBFcktL?=
 =?utf-8?B?SUVLTVFidWluLy9jTHNoUFYvM0hCNVZ5aW9ZS0FhNVpUTmh4NUg1UC9TUjlE?=
 =?utf-8?B?QnA1UVFxc2s0S2tYRkVmemRZaHF6OEI4VDl1UXlhNFBFcjJPUWUrODhsZld0?=
 =?utf-8?B?ZmtKNEI1QUJFaTB5aUpZMXcyMlY2YXR0SEVsejBWVG83cmlXWVVpUjJkMm1o?=
 =?utf-8?B?a1BtZWpWVjh3cUQvclpmZUFkUk5OTWEwMC9iUEl2bGVjRHU2cGJGWW44QVQ1?=
 =?utf-8?B?Q21ieHJSU0lOelFrMTUrMHpzdGJXc1BoMHQ5VUI1c1ZFNXJiNmpldFZlZU42?=
 =?utf-8?B?WXZnUkdkbHZIK3NNTFRjYzdiZ016djZ5dVR6U1VwRnpkWHFpZ1UwdmlKYWIv?=
 =?utf-8?B?SElqMFJXdWw2Qmd6WStIZWtPRGVmU3k2dElnekxlcGlFR2FJLzBhUW9ieEEr?=
 =?utf-8?B?cWVLTjVSQmJrSTZLVWJDZmtCUUhjRVY5Ly85R2lJeHVaU0dqSm1JWnlxenpr?=
 =?utf-8?B?dnBESTZpWlpCQjhDTkI3T3d4SEhZM1RBeVdmQW5QYU1uQU83Ly92QWxTNk5G?=
 =?utf-8?B?ZmdIbU5kNEJ1bEtYSmFqWW9VMWNURDJVR3Z1ZEppUWMvd3dxMUZ0aWJFV1J0?=
 =?utf-8?B?RzdEbDQwWnJOcSt2QXdNQUpqR2pCUmRpckNuS2pCQ1laaW5KTkgzVWtoLzBO?=
 =?utf-8?B?dUhpTkZmcEJDaEdJYWtzN1VDOTM0OWxKZ3A3OElYczF6ODZGZHRZcTlBUzA5?=
 =?utf-8?B?YkdqeFpKQWE3bTRLNThNTzJNK2FlNCtxSDNPeHR4cFNUaStpTkZ5T3F5U1gz?=
 =?utf-8?B?cXRKTlVIUWJaTlJDbWNtTVdxQUlwWkdzUHFQQ1dSZmRXUDNoV2tGeG5abWVm?=
 =?utf-8?B?M0ZXVkJIUFk4aHdidHM1UHZiRnR6YnNPQXd1TGI3RVJJQTNyQXpXQ2d1RG15?=
 =?utf-8?B?bjE1UkxaRy9vWDM4Si9XaVBibzdxa0pMNXFEaVRnUkFrQ21kVDNIMlhKenA0?=
 =?utf-8?B?ZDV1NG1qMmhHazdESno1dXEwdUtkQ05aSXQ4KzJCaXJtTE5IUkVWYW4vSkM4?=
 =?utf-8?B?d1MzVUZQdW9OVFd3UWJxN3BkdjAvc2NFZkpJS0c3bUhTRHdhOFVNMlBONjhK?=
 =?utf-8?B?YkZzeU9SOUpkeFZaT2RtRTBEVXNpcm5Za0RaVG8vS0RTVjFYeGNSREo3ODZG?=
 =?utf-8?B?aHY3YjgwbmJwdWltUnZjMElHUnVLaGtMVkNCMCtLcWhST0ZwVFl6ZE9IaVZq?=
 =?utf-8?B?cUQyT3kzdjlXMGphdkxGNnB2dEJFSGEzWmFSLzNJRlErREx4MjArdTBhWEtY?=
 =?utf-8?B?SGgxWU40cUNubzNZaDQvOG9BUFFUV0JZcW5tN0xFN2tsQmFaQXFtNklxM0Ey?=
 =?utf-8?B?SXhZcDZSUS9VcE1WVDFERExHdThuZWlxYitra3Z5MUx5NEkwQ2tXdXVKeEN5?=
 =?utf-8?B?M082bHRzRFl3SE1qOTRsL1hwYlhzTUtxNjZGdkE4dlptOVU1dlB1YmdLbkNu?=
 =?utf-8?B?aHZ2VXIxVExPamFQSXFQTmVFOGVRUFVGYVNyVUJMRGF1VGVXL0pncERNSjg0?=
 =?utf-8?B?c1RxaWlZZzRBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0V1N2h2YVJ1dWZiblZwWVdhb2tQakFKM3BiUXJiMnJzSDVNTkxMS2ZsWjJJ?=
 =?utf-8?B?ZFhqa0JkSFE0WTF1M2NBbTU1ejdxZTZhVDVpQjBsQnhzVHU3ZEQzZlhCRUpk?=
 =?utf-8?B?NVFpMFM3c1pyRVdMTXVrYndnSC9jUm04S1V0NmZSelJwbFhDVi9xV2t4SElo?=
 =?utf-8?B?aitoSXhNTWYwRTJ5QmowWFJpWnNpN2x1N1hBY2UyU0FUS2FBL29Wd1l6Q1ZD?=
 =?utf-8?B?Y1BTTGdYQ3lSUzlHLzFyRFNjdWxWZ2hWMjJpd0ViZlR2MmE4NndEWWdSOEt2?=
 =?utf-8?B?bFVXWXJDaGdlYWhMQlh1RTIxUnB1Y3dHMWtBMjhSSHJTWkluaTJpQ3hwaFli?=
 =?utf-8?B?SFcxWG1CRWdraGRvR3AyaDZSeEl6TlNHVXRmWUdjS2NJbmZ6U2NYdXJLRmJL?=
 =?utf-8?B?R3dteE5BVE10TW1GVWV6Y2ljczJwZVdUZkw0b2dRblErWXVoV3Q2MEFFaHdN?=
 =?utf-8?B?bENlVXRqZUdqVk1pRXVCRDhxMUdCa0tjdWU3a2ROMFA4S2t2cVBubGdDMGRY?=
 =?utf-8?B?MTlkdUxLaVhxcHJWc1VMdkR4dHJDZnNjbGtBUm1wSm8xblZVN1QvOC95dUtF?=
 =?utf-8?B?elpicUZJVmpDMTZ5MHRiTkJaVFF5TGNBNDJISmFoSGYvMUNld25ST3hRTTFo?=
 =?utf-8?B?cVhJcEZUc3RmT1NnOTQrbGlTSlVSOFNkQis5aUxrVzRPR3dvWEdFRFZIckJD?=
 =?utf-8?B?T25KV09BSXk3QUcvMWdOejNGdFJNV2ZQVU8vbkdaNVkyQjU0RU10bGp0SDdl?=
 =?utf-8?B?L3dVLzIvWVgzZnpXRHFhNm13aE05Q3h2RnZpYzJkRGJqYkNocXExNWR0TjZt?=
 =?utf-8?B?bmkvU2RzeVNjTW9SUXpHai9qVW4vVzJiTC8rSk5WK2p3djZpaWQvUTVaNkdC?=
 =?utf-8?B?dW1mVHYyOTdUWVRnemo4WGxVY0ZUZndOdjJia2FIWHhOV0h4ZXk2ZzdrNTN0?=
 =?utf-8?B?OHFuR1NPYWFwc29hVGs0a2IxNWtQdnRZR3BhdjFPbUFIeXhycUh6enVDeGlN?=
 =?utf-8?B?akpNcHZVSnd3bGF2dERjU2pGSFB0ZTFTSWxvakdPNEE1UmJqSTM2Sm83L0xn?=
 =?utf-8?B?UmJKTzh1MEtwM1Z5SXhRb1ZJRHNmOFNGZGhrZ1MycVBreTVheGZRQmpQMUN6?=
 =?utf-8?B?aHhRV2pwMXJlUkNnUVNYekxvVUNCNVpzU1FhNUhLY1Joa1dxVjYxSXh5Nnhv?=
 =?utf-8?B?T0VpTlFnMWh3TjNMVWJlOXU5Wk9rMDFjWGxvYlUwem94OU1YWHlkVEh3d0VV?=
 =?utf-8?B?YnNoNzZUellxcWxxTkZrQ0txK0xONzNsMnFGbHRGY3JxVlA3STkwNmZvdkE4?=
 =?utf-8?B?QnMxYmx6a2VpWDdyUjZQZzl2ZUJuczFCR25BOVFIR1pIdGR1dnk2VnRBRit5?=
 =?utf-8?B?MUZ1Y1ppT3EvOGYrdC8yZUljaExDNDBjTGhpRmZIaG9veWk4anVrOC81YXJM?=
 =?utf-8?B?Y0VXUXdabHVzSmo0ellnd2Yrc1hLem9GUW1OL0N2UWlpRjIydWE0M08vT2Q1?=
 =?utf-8?B?ZEd4ZmEwcTNZZkpUQ0kvSUZSd2QrWCt5ZEZBN0xJZEdmalVtZU9ucThuZWFy?=
 =?utf-8?B?RjJtaG5CWFVMRHhlQTJ5Tkc0MFkzQWN4MVpIWDJJQ0I2dHdkcllxMlM1SU1X?=
 =?utf-8?B?dHIrZzlxdEtHZllRbS9OUTB0YURZOFpZUmxHbzZLNGNNd0Z0S0hHeXlGZGFo?=
 =?utf-8?B?RXV0bU9CandDN2RmTG5pR2dSb3F4bHArSlZ0S1hSWk5WVEhkU05mRTNTOTJV?=
 =?utf-8?B?Q0gzVTZKR21CSFlsVkdYb1F4N2k5V2N5cXQvYkM2QXRuY1YrK08va09SNkpM?=
 =?utf-8?B?cnRoMUtMb2lSb1E5RWZsdmJsRmJBR3dkZ3FyaitvaWdDMzVHdW4rR0NGV1R4?=
 =?utf-8?B?K1BxZWdDc2lEL2kyRlVLbDdRY29jUG8vQ0NTTEZGOXZtdDhPTGZITlZEc2NL?=
 =?utf-8?B?OGcyKzQrMVdPK0kwWG9wMlQxS1JyczY0Zi93OVU1aUlpOFdoY2hQS1lxQ0Ns?=
 =?utf-8?B?NWl1ODlvVjhVTk9wdnYxTVd5R09rSUY0Uyt2REN4Q1lvcDB1N25jWHdReDdG?=
 =?utf-8?B?OExQRVAyNUkvcVAvZDFpamNVMGJJWTJiSHhkSWdQdU9YMVBwTHREbnV4eTR0?=
 =?utf-8?Q?ZhCI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b0fe47-40e3-4912-75ba-08dd7af9f0e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 02:13:26.3249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DrojAyZ9d/d4WdXyuQ43yd61aTX0MJSu1VPnetvI7jRyUnzyAhE+d9sRePWSG1Pi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255
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
Cg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogYW1kLWdmeCA8YW1kLWdmeC1i
b3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXggRGV1Y2hlcg0K
PlNlbnQ6IEZyaWRheSwgQXByaWwgMTEsIDIwMjUgOToxMSBQTQ0KPlRvOiBEZW5nLCBFbWlseSA8
RW1pbHkuRGVuZ0BhbWQuY29tPg0KPkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IENsZWFyIG92ZXJmbG93IGZvciBTUklP
Vg0KPg0KPk9uIEZyaSwgQXByIDExLCAyMDI1IGF0IDQ6MDfigK9BTSBFbWlseSBEZW5nIDxFbWls
eS5EZW5nQGFtZC5jb20+IHdyb3RlOg0KPj4NCj4+IEZvciBWRiwgaXQgZG9lc24ndCBoYXZlIHRo
ZSBwZXJtaXNzaW9uIHRvIGNsZWFyIG92ZXJmbG93LCBjbGVhciB0aGUNCj4+IGJpdCBieSByZXNl
dC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBFbWlseSBEZW5nIDxFbWlseS5EZW5nQGFtZC5jb20+
DQo+PiAtLS0NCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWguYyB8IDEw
ICsrKysrKysrLS0NCj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5oIHwg
IDEgKw0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2loX3Y2XzAuYyAgIHwgIDYgKysr
KystDQo+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTIwX2loLmMgfCAgNiArKysr
Ky0NCj4+ICA0IGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9p
aC5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5jDQo+PiBpbmRl
eCA5MDFmOGIxMmM2NzIuLjFjOGE0MGQ1NzljNyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfaWguYw0KPj4gQEAgLTIyNywxMyArMjI3LDE5IEBAIGludCBhbWRncHVf
aWhfcHJvY2VzcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj5zdHJ1Y3QgYW1kZ3B1X2lo
X3JpbmcgKmloKQ0KPj4gICAgICAgICAgICAgICAgIGloLT5ycHRyICY9IGloLT5wdHJfbWFzazsN
Cj4+ICAgICAgICAgfQ0KPj4NCj4+IC0gICAgICAgYW1kZ3B1X2loX3NldF9ycHRyKGFkZXYsIGlo
KTsNCj4+ICsgICAgICAgaWYgKCFpaC0+b3ZlcmZsb3cpDQo+PiArICAgICAgICAgICAgICAgYW1k
Z3B1X2loX3NldF9ycHRyKGFkZXYsIGloKTsNCj4+ICsNCj4+ICAgICAgICAgd2FrZV91cF9hbGwo
JmloLT53YWl0X3Byb2Nlc3MpOw0KPj4NCj4+ICAgICAgICAgLyogbWFrZSBzdXJlIHdwdHIgaGFz
bid0IGNoYW5nZWQgd2hpbGUgcHJvY2Vzc2luZyAqLw0KPj4gICAgICAgICB3cHRyID0gYW1kZ3B1
X2loX2dldF93cHRyKGFkZXYsIGloKTsNCj4+ICAgICAgICAgaWYgKHdwdHIgIT0gaWgtPnJwdHIp
DQo+PiAtICAgICAgICAgICAgICAgZ290byByZXN0YXJ0X2loOw0KPj4gKyAgICAgICAgICAgICAg
IGlmICghaWgtPm92ZXJmbG93KQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byByZXN0
YXJ0X2loOw0KPj4gKw0KPj4gKyAgICAgICBpZiAoaWgtPm92ZXJmbG93KQ0KPj4gKyAgICAgICAg
ICAgICAgIGFtZGdwdV9hbWRrZmRfZ3B1X3Jlc2V0KGFkZXYpOw0KPg0KPlRoaXMgd29uJ3Qgd29y
ayBpZiBLRkQgaXMgbm90IGNvbXBpbGVkIGluIHlvdXIga2VybmVsIGNvbmZpZy4NCj4NCj5BbGV4
DQpUaGFua3MsIHdpbGwgbW9kaWZ5IGFuZCBzZW50IHRvIHJldmlldyBhZ2Fpbi4NCg0KRW1pbHkg
RGVuZw0KQmVzdCBXaXNoZXMNCg0KDQo+DQo+Pg0KPj4gICAgICAgICByZXR1cm4gSVJRX0hBTkRM
RUQ7DQo+PiAgfQ0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9paC5oDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5oDQo+
PiBpbmRleCA3ZDQzOTVhNWQ4YWMuLmZmNzZmMDJkM2U5NiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5oDQo+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfaWguaA0KPj4gQEAgLTcyLDYgKzcyLDcgQEAgc3RydWN0IGFt
ZGdwdV9paF9yaW5nIHsNCj4+ICAgICAgICAgLyogRm9yIHdhaXRpbmcgb24gSUggcHJvY2Vzc2lu
ZyBhdCBjaGVja3BvaW50LiAqLw0KPj4gICAgICAgICB3YWl0X3F1ZXVlX2hlYWRfdCB3YWl0X3By
b2Nlc3M7DQo+PiAgICAgICAgIHVpbnQ2NF90ICAgICAgICAgICAgICAgIHByb2Nlc3NlZF90aW1l
c3RhbXA7DQo+PiArICAgICAgIGJvb2wgb3ZlcmZsb3c7DQo+PiAgfTsNCj4+DQo+PiAgLyogcmV0
dXJuIHRydWUgaWYgdGltZSBzdGFtcCB0MiBpcyBhZnRlciB0MSB3aXRoIDQ4Yml0IHdyYXAgYXJv
dW5kICovDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaWhfdjZf
MC5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2loX3Y2XzAuYw0KPj4gaW5kZXgg
ZjhhNDg1MTY0NDM3Li44ZDNhZTg4Yjk2YTQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9paF92Nl8wLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2loX3Y2XzAuYw0KPj4gQEAgLTM0OSw2ICszNDksNyBAQCBzdGF0aWMgaW50IGloX3Y2XzBf
aXJxX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICBpZiAocmV0KQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gcmV0Ow0KPj4gICAgICAgICAgICAgICAgIH0NCj4+ICsgICAgICAgICAgICAgICBpaFtpXS0+
b3ZlcmZsb3cgPSBmYWxzZTsNCj4+ICAgICAgICAgfQ0KPj4NCj4+ICAgICAgICAgLyogdXBkYXRl
IGRvb3JiZWxsIHJhbmdlIGZvciBpaCByaW5nIDAgKi8gQEAgLTQ0Niw3ICs0NDcsMTAgQEANCj4+
IHN0YXRpYyB1MzIgaWhfdjZfMF9nZXRfd3B0cihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwN
Cj4+ICAgICAgICAgd3B0ciA9IFJSRUczMl9OT19LSVEoaWhfcmVncy0+aWhfcmJfd3B0cik7DQo+
PiAgICAgICAgIGlmICghUkVHX0dFVF9GSUVMRCh3cHRyLCBJSF9SQl9XUFRSLCBSQl9PVkVSRkxP
VykpDQo+PiAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+PiAtICAgICAgIHdwdHIgPSBSRUdf
U0VUX0ZJRUxEKHdwdHIsIElIX1JCX1dQVFIsIFJCX09WRVJGTE9XLCAwKTsNCj4+ICsgICAgICAg
aWYgKCFhbWRncHVfc3Jpb3ZfdmYoYWRldikpDQo+PiArICAgICAgICAgICAgICAgd3B0ciA9IFJF
R19TRVRfRklFTEQod3B0ciwgSUhfUkJfV1BUUiwgUkJfT1ZFUkZMT1csIDApOw0KPj4gKyAgICAg
ICBlbHNlDQo+PiArICAgICAgICAgICAgICAgaWgtPm92ZXJmbG93ID0gdHJ1ZTsNCj4+DQo+PiAg
ICAgICAgIC8qIFdoZW4gYSByaW5nIGJ1ZmZlciBvdmVyZmxvdyBoYXBwZW4gc3RhcnQgcGFyc2lu
ZyBpbnRlcnJ1cHQNCj4+ICAgICAgICAgICogZnJvbSB0aGUgbGFzdCBub3Qgb3ZlcndyaXR0ZW4g
dmVjdG9yICh3cHRyICsgMzIpLiBIb3BlZnVsbHkNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS92ZWdhMjBfaWguYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS92ZWdhMjBfaWguYw0KPj4gaW5kZXggZTllM2IyZWQ0YjdiLi4yYWQyMDk0MDZkMTcgMTAw
NjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMjBfaWguYw0KPj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTIwX2loLmMNCj4+IEBAIC0zNTAs
NiArMzUwLDcgQEAgc3RhdGljIGludCB2ZWdhMjBfaWhfaXJxX2luaXQoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAocmV0KQ0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gICAgICAgICAgICAg
ICAgIH0NCj4+ICsgICAgICAgICAgICAgICBpaFtpXS0+b3ZlcmZsb3cgPSBmYWxzZTsNCj4+ICAg
ICAgICAgfQ0KPj4NCj4+ICAgICAgICAgaWYgKCFhbWRncHVfc3Jpb3ZfdmYoYWRldikpDQo+PiBA
QCAtNDM3LDcgKzQzOCwxMCBAQCBzdGF0aWMgdTMyIHZlZ2EyMF9paF9nZXRfd3B0cihzdHJ1Y3Qg
YW1kZ3B1X2RldmljZQ0KPiphZGV2LA0KPj4gICAgICAgICBpZiAoIVJFR19HRVRfRklFTEQod3B0
ciwgSUhfUkJfV1BUUiwgUkJfT1ZFUkZMT1cpKQ0KPj4gICAgICAgICAgICAgICAgIGdvdG8gb3V0
Ow0KPj4NCj4+IC0gICAgICAgd3B0ciA9IFJFR19TRVRfRklFTEQod3B0ciwgSUhfUkJfV1BUUiwg
UkJfT1ZFUkZMT1csIDApOw0KPj4gKyAgICAgICBpZiAoIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkN
Cj4+ICsgICAgICAgICAgICAgICB3cHRyID0gUkVHX1NFVF9GSUVMRCh3cHRyLCBJSF9SQl9XUFRS
LCBSQl9PVkVSRkxPVywgMCk7DQo+PiArICAgICAgIGVsc2UNCj4+ICsgICAgICAgICAgICAgICBp
aC0+b3ZlcmZsb3cgPSB0cnVlOw0KPj4NCj4+ICAgICAgICAgLyogV2hlbiBhIHJpbmcgYnVmZmVy
IG92ZXJmbG93IGhhcHBlbiBzdGFydCBwYXJzaW5nIGludGVycnVwdA0KPj4gICAgICAgICAgKiBm
cm9tIHRoZSBsYXN0IG5vdCBvdmVyd3JpdHRlbiB2ZWN0b3IgKHdwdHIgKyAzMikuIEhvcGVmdWxs
eQ0KPj4gLS0NCj4+IDIuMzQuMQ0KPj4NCg==
