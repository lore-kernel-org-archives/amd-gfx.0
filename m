Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8354FC282D0
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 01:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B5CB10E02A;
	Wed,  5 Mar 2025 01:34:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y6SaETr5";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7623910E02A
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 01:34:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMzqal9wt2eXNh9gJ1UKjYty6awsgGKIJ282jr62k+A0xeNfkykGinoaHjMcbipEXWNHXnhBkCWE/CPZACyLvm2NNWszyAoaxQUKU7D0A/LWLcIH9Sxce0oFfsgU5A8FLRf+Wg3e5Vkdu1okxD6eUZWYmdhwSZxM5bfogxwE3jxQphual7kMig07xCXM7tWfyU3zlJBO70YzEO7CisBhEthXndPjxbH5DFoXgA8bsBaetW95pKZ80X0MbzCag7fndhmm58p3QJ9ZM+C4OgpIN9KjGmXg3m+ikkghyBuStU+8XP1NfcgGEpslGYryMTszHgIvv2GSVTerfXJ83B8ugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7CDB3QkXfxjAZ142yrFI5IFSMVWMmdmerAsOhpqgRo=;
 b=h95mjahsGWgRzm2yHAiugmABNjrcp36kMmIUKloruQGDCb8VjMGvh/2gPHKXKOuVc5lTrf1VrUk1BMa8Q/+HVdZAxBCSl8ihgl5vhTNo8xkPKosqmgZLaaWr8ZJZTN6eHUbcIL9H8Ke5A3YdkUxaLfnvL/pjNNFQGtPg41i/UTEclRtoky9OgzAXq18nh+KIMsHGMGsvPbL5HkvRCpN19UYtNZmjTzlZAQCL6iz60FxdB/tc9SgYzMQX0K/hb0Wixv4NlEKsB8Pd1AYiGRcQ2H4nb4P/BjolbIpL0JluRYVrQ+2J2scrlTvloZglEWTExYLLcb1+YsQxkhvPCswP5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7CDB3QkXfxjAZ142yrFI5IFSMVWMmdmerAsOhpqgRo=;
 b=y6SaETr50TH2JI/TKHzFrsNTEP/M2FSHI8qQoBfxSbvJ/DF1KwdjZZiyfJI3rnIUKuW/KEZ+4YUVv6SWRViQnB0RlXUfANmGEBVAYejYpsRXO7aa4Xa+V66m3497G8FdiKx3owM9/AK2PJnaukNLeOTYH1w59z0hHHtIKaBGaic=
Received: from CO6PR12MB5411.namprd12.prod.outlook.com (2603:10b6:5:356::5) by
 SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 5 Mar
 2025 01:33:53 +0000
Received: from CO6PR12MB5411.namprd12.prod.outlook.com
 ([fe80::fa8f:8242:338b:869f]) by CO6PR12MB5411.namprd12.prod.outlook.com
 ([fe80::fa8f:8242:338b:869f%6]) with mapi id 15.20.8489.030; Wed, 5 Mar 2025
 01:33:53 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix missing drain retry fault the last entry
Thread-Topic: [PATCH] drm/amdgpu: Fix missing drain retry fault the last entry
Thread-Index: AQHbjB+FPY6Kk3TRzU+s74T6IZlEjrNiJOmAgADvLoCAAK4UsA==
Date: Wed, 5 Mar 2025 01:33:53 +0000
Message-ID: <CO6PR12MB5411E003E6EA54AA632A50618FCB2@CO6PR12MB5411.namprd12.prod.outlook.com>
References: <20250303093448.3190674-1-Emily.Deng@amd.com>
 <PH0PR12MB541759D007BBD47B23176CE58FC82@PH0PR12MB5417.namprd12.prod.outlook.com>
 <caa35da4-4280-7486-447f-f80294b248eb@amd.com>
In-Reply-To: <caa35da4-4280-7486-447f-f80294b248eb@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fd08f160-fcb8-4bf2-80ac-50becb63a3ef;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-05T01:23:32Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5411:EE_|SA1PR12MB6775:EE_
x-ms-office365-filtering-correlation-id: db2c7e24-1383-4829-3dd9-08dd5b85c9fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?NWlVTlJPeHlNdzZiQzFWTzBuWG15U1d3bXJrWmFJWVBJZnFuSE1zbDBoZ1Zv?=
 =?utf-8?B?ZnpwWUdvbXZhMTVKdFN0SXIrRGFsSUVDblNzOFQxVU05Wk9ta09CMWlldXRl?=
 =?utf-8?B?RW9WbW8zWDgrM3krc0Y4N1hrQWdHS2pDV0dYNEVJVUZyMW5wRHArdG5oVkNy?=
 =?utf-8?B?Q2FkbUhSTkYrTitkRUJZUU9kZG54ZHlQWjNOTjRORWlEWjM2K2J5b1JUYW80?=
 =?utf-8?B?T0tndmU0NEdxYUsvQ2lZVm5DUW8wZkVZQ2NIUDRGL3FjNnQyWUNNZWRZWTVD?=
 =?utf-8?B?bFppR1BrM09Tc2FId0ZhbXFuZGZlVU1Qd3RwN0kxSDl5cms4WUN6dG1SbzVB?=
 =?utf-8?B?U2JqU2s0WUFqZU1Jbk9SZXdmRkpoRC9vY0QzajRWVjRaenVuUVM5OFYrWGl0?=
 =?utf-8?B?eVAxZzdzeFBkbGJjTzhuWlhZWWhMemhkakhIc2M3d3pNSTVyYXV1UVF5cStE?=
 =?utf-8?B?NEFHUVM3RktIbHkrSXlxbXNzUTJUNVhSbGVTdndkQjZ4UXZieTJTTHdQZnNr?=
 =?utf-8?B?UDlDQTVaMG9UVnJITFJadXkySzQ5aVRKSkRwdCt0aEo0WitVclJpNWpDcmpr?=
 =?utf-8?B?aVdnbDF6TytHVDRQZE5La1RJczk4YWVzVXlKQnk0VGtjektrNDlpdkFBdkxp?=
 =?utf-8?B?eGdCZk83dGwvOEFGR0J1ZlRZeEJBUU5aSm9lbTJVS0tpbVhONlRJVGtPLzBY?=
 =?utf-8?B?NGFyWENKUzZaaXhNUElnSExJTDYzcHQrVVNrLzFwWDR6Ynp6RXZ4eGU5c3pF?=
 =?utf-8?B?a0RBWVVnQkxGVmhTMnMrRFVPMkFzclR3eFVXMUtlZnllUGxLNTZTbVluc3hC?=
 =?utf-8?B?Mkw3SndyRVpld21odGNJSm90V2xZYXVwZEVuVmkrQThWWnphc0l6WVFyUjM5?=
 =?utf-8?B?TDQrZjFiZVc1SkFPZStJNVpDWnl5R1dVc3VOTkZ2eWtXR2xBenkyOWphSjh4?=
 =?utf-8?B?VEF0bExCQjB3eTJrK24yWEhlalJxbldHdTczRFoxZytLdmZ5TUpzWVI5SlBi?=
 =?utf-8?B?cWZZaytkSkRpZTh1dWtZS3FOZDJjQlJQTHkwQ0lnSjhSOHZ2eHhiVnVwcFF3?=
 =?utf-8?B?SmRHZDZ6VkJ1NkZTWGpSSDBKSDZhVFFwemlRN1RKN042T254azJlRnM1VEJH?=
 =?utf-8?B?dkZOU20rWm4rSS9jL0IwT2g4UUJYbENEYmVFOFVrYkRlYzZvdWNaSkpCZUNt?=
 =?utf-8?B?TXRiUHI0NmRscTZDR1huYkZGWjFvNWRQTkVwU3h2bFdmMnAzSFljK2tVMGpz?=
 =?utf-8?B?bU1VVERDQkZEWGxmRy85WUYvVW4xYXRyamdYa1V1Z1c5U25EcWU2TlJEcFRk?=
 =?utf-8?B?SkN0ZkZwU0t0dVpiV0l2TzNqQjhuenZ0M1g1STlmZWd6MW8wbk5TTUNPUEFa?=
 =?utf-8?B?QStJczZUODY2SXBhekZTcmJYTno2cXQxam1LT3VvNjNkRDE1V2ptRWsrVWx1?=
 =?utf-8?B?T21BNzBEdHI0d3ZxZThiRTFZbG5RWER6bDhIcy9aQzc1bEw1aEo4NmMyY1BV?=
 =?utf-8?B?M3A3RlNYb0NVQjdsbWhMZkd0S1BpYTNvcFczTkFYL1ZhQVpHZ0grbkp5d1J2?=
 =?utf-8?B?NGtJY3U2N1hVZG0rVUJTOGtTczlmMEdsdUJOSVUxTENDQTEwSnpNSVhYZFMy?=
 =?utf-8?B?dStQQ01DK0JLeDVvK3pHQTl3MDBiL1pRNXM4d2xuT3Q4OG1MMGxJOUkrTElI?=
 =?utf-8?B?azQvUFE1TUE3Q2lNcTByUm9xUjVjc2w2Q2VvR1BWRTU0RUFlQXdidFRwZWdv?=
 =?utf-8?B?Vlkxc1p3engrY2I1cHNjdFlBQ2VoMk1aNnNpNlpHVnRlbmp2algyaDRaL1lp?=
 =?utf-8?B?OWlwWEZWbTFPa0ZtaGJITlNWWlBtU0IyNHNiem1mVURPdGlkb1NOWDRNMUtX?=
 =?utf-8?B?bGRrL3BQb29aaW00TTd1eWt0U0FkUXpSVjZSWjE3MEE1ZXlzajFSeFBTcDJp?=
 =?utf-8?Q?W2bABJx1VKX44+TazSAAM2C/ZWq0T2YN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5411.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MktBa2M4VkpKcisxU1JKZ3FoZklvSFNVQXVNYUZxS2diOEh2eTJTRUlFTFJO?=
 =?utf-8?B?S0pCSVpub3p4aHluMDNHSGIvREZNTWI4SzlRTFFQNTBKRDBBbkFGZXR5SGl3?=
 =?utf-8?B?SGtDMHlVajM2empXcERsdi9QOXNsemRWME91aGdsQU0wT2dPRVp6TE1uNU8z?=
 =?utf-8?B?Q0x4Q0owQVdTQ200VkVSMmpDZlVvV2NlVkxHWGpieFBvRW9kUVVWKzRwOWY3?=
 =?utf-8?B?S3E2M3NkYW93YzVqZ1VlRGt3OHV5c2ZINEkzOWJ6dFZoK0tlc2w5bnZJZlRI?=
 =?utf-8?B?dXR3ZXRFV1FnQm9SbHZOZWtrTmx0M1FqbzBxcXJZRlhhSFNGZEFRWUo4VjZH?=
 =?utf-8?B?RHBYeFhQWVFUNFk5TWl2cUpkVEpvSzdOVFhHU2NXS2U4MGdkRDlTcnUwdmJJ?=
 =?utf-8?B?MlVwMHl6RVlaaStCK2p1emhnL0Y5RDlpNnZzdmJjbGNnTzBDRDFOdzhsVHhy?=
 =?utf-8?B?Y0IxUDY5SWMrMkg5Q1JXYVkyR0xiaUNSanhuRVlkUmNTLzFpTWsvb0ZmR2dx?=
 =?utf-8?B?WG81LzFxeUZsc2lzbHhTa0sxcit2Y1lPWXBCSmpQWUZjakJ4RTZIcEZxTnF0?=
 =?utf-8?B?M0xaTmlRU2VqK2QxS1BIbmxuUE4yV0w5QmxORWU0ZHpNRm0yV2hKVHg2Tzhl?=
 =?utf-8?B?bVBTWStyUUUxdTgxNkgrU1RlY0theGI0ZHBvRFlZMW9NY0xMZG16MjN5SHI0?=
 =?utf-8?B?YStkdkxlNWtCQnQ3WmgrbmNaekxZeWNVejN4am9OT1pMekpqMjZrRzBRenda?=
 =?utf-8?B?ejhDUWphb0FkWkZKaURnV0dGWmxsN1o0Tm85dzdxKzEwL3VKUDlTOE94UkZy?=
 =?utf-8?B?M2xnUnoraVhBVDRJa1laOVlmVFlMVWNrUUI1ejBsaGlJd2Vyb0xicEpTQlBw?=
 =?utf-8?B?M0JjSGlLM1dyTExnck1UL1VhNG5rbnZjMVNEeDFJTmptcHJSOEdpQVcvbk1l?=
 =?utf-8?B?Uy95T3ZwdG03Zm5FRjZLQmQ5VFoxQWt0WE9aSGI4NDhpeDlxcXdicFMvVTYy?=
 =?utf-8?B?czgvMDBHME42eS9ubzlwUUdJZHBJLzRnTThQaE5CcXBRT2tXcU1OOER6R3BK?=
 =?utf-8?B?eUdvcW9uazYzOCtnU3VLcVY5bkMrZWUzQ0ZJMUR0eGZNdTZHSm1zWGxlYmd1?=
 =?utf-8?B?YVM1eVNyM2g1b2FSYkVsOGgrQllWS0xjS1RiaDFUV3c0bnVKVXFtdEt4UGJM?=
 =?utf-8?B?ci9qNHJVbGtjSU5BbGt0c0JEaHpBYmZDbmZCUFFmVmhpek9FN2RLZFpyejJ1?=
 =?utf-8?B?dTNtK1R4bkRad0ZtMVR1RFlQRlNIVHRQQ1VLRXdXb1ROOUlUSllLTnp6Wlpj?=
 =?utf-8?B?T2wwUjhUZUhOaW9RMStTWWZCRGs1WjZSREZDalQwQW1JZG1zMWpud1lSSlBQ?=
 =?utf-8?B?aWdWZzBNNW9HdVBOVmwzWm9RQXNEZ0h6djRkdDZhbGoremMvZk80aXZDYUR3?=
 =?utf-8?B?OERZZXMxUlUyUnZEZEFXTFFzRjU3dllUS1FoMml1eTBGYklJYlJHcnhUWFUz?=
 =?utf-8?B?enhNU3NvcjhoTjJjdjlVVS95Q1A2UE1PS3NWa2UzUDROYmZUYjdaVHVPdUFx?=
 =?utf-8?B?SUUxd1NkWW1xWFBwUk5IVVFFa1k2Y21qbzN3UnVNczFDSWFJSXk4N21NeDBp?=
 =?utf-8?B?OHRhQlprR21CZm5OK1pJMDFKVVNrQmdmSlY3cysxcGNqU0EwcDNBZit5R1BM?=
 =?utf-8?B?aFdwRFpDMG9rQlZzZWRlRUNkdmROTWRaK2d1d3UySEV3d3B4aFk4WUNyam93?=
 =?utf-8?B?a3l2OS9vU2NmY0xsb2NQRFN5Sjc3c1l5eWtTRDlGam42b2REcDRrQ0NTQ0dC?=
 =?utf-8?B?SklMRGExSm5xYkUyTmtDZ3V0emhsOUxKNmtvSDdXdHZCOXBzMENLZkxnNEpk?=
 =?utf-8?B?SDlWbERKWDZNREd5cXdqRmpaeldscnF0ekJ0R2lnWmNSUzJSSHVGRVFBc09U?=
 =?utf-8?B?ZVZvU2ZYS3RVNnljUC92aXlENEVOZHRHRlB6VitYTDlNQUpVQ2FaeUg3bDhN?=
 =?utf-8?B?NzhzZVJua01Ld2N2N3VEWk5LMUdiZnhIUTFQWFhMM1JiOVZzaS9Eb1Rnd3Zx?=
 =?utf-8?B?Z0lLZXVNcHVZVHZjd0dKd2lRMUZrbVQ0NFduOUh1MFFUaWcwUXF4NkNxOExX?=
 =?utf-8?Q?Po08=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2c7e24-1383-4829-3dd9-08dd5b85c9fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 01:33:53.3744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06EZU8c4PhnXs/LtrHQiyCnNcTn9Af6bz759SzB+QUmFij1JqkRRQmFyeC2RBhO0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775
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
Cg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogWWFuZywgUGhpbGlwIDxQaGls
aXAuWWFuZ0BhbWQuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIE1hcmNoIDQsIDIwMjUgMTE6MDAgUE0N
Cj5UbzogRGVuZywgRW1pbHkgPEVtaWx5LkRlbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogRml4IG1pc3Np
bmcgZHJhaW4gcmV0cnkgZmF1bHQgdGhlIGxhc3QgZW50cnkNCj4NCj4NCj5PbiAyMDI1LTAzLTAz
IDE5OjQ0LCBEZW5nLCBFbWlseSB3cm90ZToNCj4+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBB
TUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+Pg0KPj4gW0FNRCBPZmZpY2lhbCBVc2Ug
T25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4+DQo+PiBQaW5nLi4uLi4u
DQo+Pg0KPj4gRW1pbHkgRGVuZw0KPj4gQmVzdCBXaXNoZXMNCj4+DQo+Pg0KPj4NCj4+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEVtaWx5IERlbmcgPEVtaWx5LkRlbmdA
YW1kLmNvbT4NCj4+PiBTZW50OiBNb25kYXksIE1hcmNoIDMsIDIwMjUgNTozNSBQTQ0KPj4+IFRv
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPj4+IENjOiBEZW5nLCBFbWlseSA8RW1p
bHkuRGVuZ0BhbWQuY29tPg0KPj4+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogRml4IG1p
c3NpbmcgZHJhaW4gcmV0cnkgZmF1bHQgdGhlIGxhc3QNCj4+PiBlbnRyeQ0KPj4+DQo+Pj4gRm9y
IGVxdWFsIGNhc2UsIGl0IGFsc28gbmVlZCB0byBiZSBkcm9wcGVkLg0KPj4+DQo+Pj4gU2lnbmVk
LW9mZi1ieTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPg0KPj4+IC0tLQ0KPj4+IGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5oIHwgMiArLQ0KPj4+IDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5oDQo+Pj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWguaA0KPj4+IGluZGV4IDdkNDM5NWE1ZDhhYy4u
NzNiOGJjYjU0NzM0IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9paC5oDQo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2loLmgNCj4+PiBAQCAtNzYsNyArNzYsNyBAQCBzdHJ1Y3QgYW1kZ3B1X2loX3Jpbmcgew0KPj4+
DQo+Pj4gLyogcmV0dXJuIHRydWUgaWYgdGltZSBzdGFtcCB0MiBpcyBhZnRlciB0MSB3aXRoIDQ4
Yml0IHdyYXAgYXJvdW5kICovDQo+Pj4gI2RlZmluZSBhbWRncHVfaWhfdHNfYWZ0ZXIodDEsIHQy
KSBcDQo+Pj4gLSAgICAgICAgICAgICAgKCgoaW50NjRfdCkoKHQyKSA8PCAxNikgLSAoaW50NjRf
dCkoKHQxKSA8PCAxNikpID4gMExMKQ0KPj4+ICsgICAgICAgICAgICAgICgoKGludDY0X3QpKCh0
MikgPDwgMTYpIC0gKGludDY0X3QpKCh0MSkgPDwgMTYpKSA+PQ0KPj4+ICsgMExMKQ0KPg0KPlRo
ZSBjb21tZW50IGlzIGNvcnJlY3QgYW5kIGN1cnJlbnQgY29uZGl0aW9uIGlzIGNvcnJlY3QgdG9v
LA0KPnN2bV9yYW5nZV9kcmFpbl9yZXRyeV9mYXVsdCBkcm9wIHRoZSByZXRyeSBmYXVsdCB3aXRo
IHNhbWUgdGltZXN0YW1wIGFzIHRoZSBJSA0KPmNoZWNrcG9pbnRfd3B0ciB0aW1lc3RhbXAuIERv
IHlvdSBzZWUgR1BVIHBhZ2UgZmF1bHQgd2l0aCB0aGUgc3RhbGUgcmV0cnkgZmF1bHQgYWZ0ZXIN
Cj5wcm9jZXNzIGV4aXQsIG9yIHdoYXQgaXNzdWUgZG8geW91IHdhbnQgdG8gZml4Pw0KPg0KPlJl
Z2FyZHMsDQo+DQo+UGhpbGlwDQpUaGlzIGNvbW1pdCBhaW1zIHRvIGFkZHJlc3MgdGhlIHBhZ2Ug
ZmF1bHQgaXNzdWUgb2JzZXJ2ZWQgd2hlbiBydW5uaW5nIGtmZHRlc3Qgd2l0aCB0aGUgZm9sbG93
aW5nIGNvbW1hbmQ6DQoNCnN1ZG8gYmFzaCAtYyAiZXhwb3J0IEdURVNUX1JFUEVBVD0xMDAwOyBl
eHBvcnQgR1RFU1RfQlJFQUtfT05fRkFJTFVSRT0xOyAuL2tmZHRlc3QgLS1ndGVzdF9maWx0ZXI9
S0ZEU1ZNUmFuZ2VUZXN0Lio6LUtGRFNWTVJhbmdlVGVzdC5SZWFkT25seVJhbmdlVGVzdCogLS10
aW1lb3V0IDEwMDAwMCIgMj4vZGV2L251bGwNCg0KVGhlIGlzc3VlIGlzIHNldmVyZSBiZWNhdXNl
IHRoZSBwYWdlIGZhdWx0IHRyaWdnZXJzIGEgY2FsbCB0byBrZmRfc2V0X2RiZ19ldl9mcm9tX2lu
dGVycnVwdCwgd2hpY2ggc3Vic2VxdWVudGx5IGludm9rZXMga2ZkX2RxbV9ldmljdF9wYXNpZC4g
QXMgYSByZXN1bHQsIHRoZSBwcm9jZXNzIGlzIGV2aWN0ZWQsIGxlYWRpbmcgdG8gdGVzdCBmYWls
dXJlcy4gVGhpcyBjb21taXQgcmVzb2x2ZXMgdGhlIHJvb3QgY2F1c2Ugb2YgdGhlIHBhZ2UgZmF1
bHQgdG8gcHJldmVudCBzdWNoIGV2aWN0aW9ucy4NCg0KRW1pbHkgRGVuZw0KQmVzdCBXaXNoZXMN
Cg0KDQo+DQo+DQo+Pj4NCj4+PiAvKiBwcm92aWRlZCBieSB0aGUgaWggYmxvY2sgKi8NCj4+PiBz
dHJ1Y3QgYW1kZ3B1X2loX2Z1bmNzIHsNCj4+PiAtLQ0KPj4+IDIuMzQuMQ0K
