Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F896C369CB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 15:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 415A710E6D0;
	Wed, 23 Apr 2025 15:15:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h/Hq4fOh";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 167B910E6D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 15:15:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUKIitv/rg3ZMonNCDbw78DKL0lxsMDQiH06PLATdpxPzBCOn6tSZEgMVQaNjoLylfoiffXptzmEmusR8ESJRtnEQQxvtZn9Ma99/szY34JkwP2cz8ieubP791fUKiw2xTPswgbJEv1ccLcsMoVefPtX2ZdPzFMS5l5NYQA/UOYCQuo9UmfzQzxR7y2zjgcPGvpx2yxUQREm3jGOzCbxMGHyC1S4NlNaMDNxn2pHCpEP48ND7lUX/vRIJ6g36mYbzKhSd8lOdtokEFQJgrQjWSxmdG83LhUliZlw572yQCJv0ciP0pCtAOkNiG999PtCvGLeG3+woAk6mBKQEfJzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zq+nHso+IshhS+5U9VqAGYkVTywODJczkOTmyXpwBw=;
 b=AUBwwcrwM+Y7drXxc10mriG0a2JP2FYBTFADef4r9zguOrSs77a2Z7xrXuokJ4z79gVp6jE3qtkt33sYNLibqQ0E91juvezYvqor6DoKAe2z4FzWXZajAALsCMeTW0LfjoqZA5Yn0/+g2lmV57/rHiswKr6BA7zvyRJJ9NSYXunVryVn9ck5Otu+dKY04v+dWtSxJwDcAZaZIIFg3vjRNq978/yp+iPdvljguPY0gnQrKRRwcIcfXQIKHF7OEa5Z07qUCd92iJCpixYdqMi7zWwDtVlyfr8BJA5xeu2gAyANlF4Kdycf0ZnCXDKNuxIErHBvbJYKDqOzwulgAms3vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zq+nHso+IshhS+5U9VqAGYkVTywODJczkOTmyXpwBw=;
 b=h/Hq4fOhLzDMRC/hDnxGzxvh40QHyUz/2IFNnuHTJk3LcLv+U70R5j0gL25J2szhi7vha4m7QmqTbrxzzKMk5PmajJFQQBt16QzocCHuxu35sNDWw6w7OL1B11Pek+Pp/NEI+2qp7UHd62A7tVzXi9yAF2ZiJwrQIRiTebhVsh0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8925.namprd12.prod.outlook.com (2603:10b6:a03:542::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Wed, 23 Apr
 2025 15:15:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 15:15:43 +0000
Message-ID: <82c12ac4-42df-4269-8c18-36a0dda49828@amd.com>
Date: Wed, 23 Apr 2025 17:15:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: properly release the eviction fences
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250423132604.4002242-1-Prike.Liang@amd.com>
 <20250423132604.4002242-2-Prike.Liang@amd.com>
 <337da064-628f-4746-8609-e17c2d0b7d56@amd.com>
 <DS7PR12MB60051B77DF6F131F4754500CFBBA2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB60051B77DF6F131F4754500CFBBA2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0331.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e91443a-c1d8-4a3e-d015-08dd8279b711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHhzOEZlVHNRTFk4U1AyemhTMTNpc1NXSzJBR0NFc2xOTFEwM1g5Z2VxbENS?=
 =?utf-8?B?TG0zYnhEdWpxaC95NHQ2dTRUN3UxUFAxZjZ3SFd5aG9nMVd0cUtkMFJxTCtp?=
 =?utf-8?B?UlVWNkJCUFJYSHU1U0N1RlRaVmNzQ0VzQnFjUGVJTjYxbFZjY2dHci9YVWpB?=
 =?utf-8?B?WGJMc1FrSkxPaS80MVpncXpmVmI1YmVyZTFzRkwydEI3bG11K0FmTTdjZTRi?=
 =?utf-8?B?alFmeTZvMU5nSVZSTzlYbXRtemlTekxBeHowb2swTXdObzJJcUxFVGJKRVpV?=
 =?utf-8?B?anNzZGVueFRjV3FEaW5wanM1TzFnYzZ0TG5tbm5MMEZQd0tRaWF1cEU3YVVw?=
 =?utf-8?B?aUpWeFBMYWx3UWgrZXZ6b3MvNlBYMHV0aTVjWkVVNkg0dzVGaDExWXR6RGhh?=
 =?utf-8?B?MEhJZGdJTHlpNmRaUWg0bTVSelBvRU9Mcm5ZUHFQUmpweDlUcW5KWWEyR2NU?=
 =?utf-8?B?YklTU1hzR3o1RmlndUVaWlNSZzVYYUtERkxPZldtdjRQYkxka0NwUFZBUkNa?=
 =?utf-8?B?RG1BWHFvRzhQVzBNZzRHT3R5YmErcWJSQXJLN0dGZzREYWFJMyt2RDdhWFly?=
 =?utf-8?B?eCtIdVplMmlCc09Mb3BsUGN1d2sxWkIwRS9iZXFsdllwVVpFbWxpL3FEaGdq?=
 =?utf-8?B?eFd4em1WNGVVOHYwZ2FZa2kyMTlEbnl3c09seDgzd3Fja2FvbjRIR0tLNnlt?=
 =?utf-8?B?eEF4RVJOUVQwWWFESmNtbVdrb29ZZG5Gd3Q0WTV6SGV2TEhiUVN2Yk51Q1lW?=
 =?utf-8?B?eWxib08ySHZFcG4yQlFBODF6d3M4aVk3NlplZlk2V3BBVDNsRmEzeVhXNnFZ?=
 =?utf-8?B?dGJWbHZZTVM1M2V4S3FlQVZXQ3N6L1B2SnV2SUYvaUpsMlJJZUR1RVgveWY0?=
 =?utf-8?B?T2dheE9pdjVUR1ovU1VqRW9aL2JqMGE1aGszdmFnbmM3dUNWK2Y0Z0hYUnlC?=
 =?utf-8?B?M21iNGpPbS80TVdJblZoSXR5MlNOWURXVDFNNEV4ZzdwVGEyQ3lLdU81Q0du?=
 =?utf-8?B?OWp6S1R2OGVwVmh2MzFnUG9sejJoMytTT1RLeEpHUDFCOHJsNHV3MTIyZUp5?=
 =?utf-8?B?M2tRSnd3RnRha21ocWVMLzU2a3NpU3dLdWM5MUp5TG1LdHVvekZsRHpoNllv?=
 =?utf-8?B?R0dhTjNuVnd4ZjQwRG42TjJEMFpSRHZSck40Y2tER2VzaVVBWXR5V3ZZdkFZ?=
 =?utf-8?B?N0MxL2JtUXJONGYzalBXd2hnUWMwZXBkQXhkVXZpa095ajJFQy8xcUhsdEp0?=
 =?utf-8?B?UHY4ekJaZkpOQTdhY2FmdXZXQUlKUmhJUHViSFk2QnBkbnhaNnlQb2NTaVhJ?=
 =?utf-8?B?QXllVk5IZHRCbDlQRE0yNTRtRTdaRlp1YUNjNVVHalNXMEMramNBSW8wRWFx?=
 =?utf-8?B?eGlpMjg1Rlh1R2xoa25tV1U2aFRWVTIyYXlPQ0p1MnlGVHJBNUZ3Y2Y0Vk9H?=
 =?utf-8?B?R1g0NVB3UFpKVHVnemlQeGI3NlhTYUlJZlNWVnlGS2p1dXhlSkFSckpQTlQ3?=
 =?utf-8?B?enR0VlZlWkNMZ3laTHl5a1p6bXpNV09tOTZ2QzhVZmpJTm9zSjNONWdTVjc3?=
 =?utf-8?B?MHVUY1RRbS8yK2xpVjEzM2J1VWtUd0dSZzBpeWZPV1FLemdlZlVhaXl2UU5v?=
 =?utf-8?B?QzJsaE9KQ244SmQyV09ZcUVIVkR3WWt0b2g5dDhYYzkrLytRbW9LWTJFYTgr?=
 =?utf-8?B?dVVvTFhLeElvZUtxUDdwVHdqbnRrZ0w3RVlyMUJtMDlVSjFkNmlteEc1UFoy?=
 =?utf-8?B?NDlqRmduK0xBRTYrZTFJaWhQNXJENUtNUWlpekNHSjJSVm1iQU5mMWRWV3pr?=
 =?utf-8?B?d3E4SllTcVRISVBJaVp2bmdteWpwMm5oMS8wQ0FEZGY0SlZBZytOSVRHLzhJ?=
 =?utf-8?B?cmxOTHF3TlZDUnV5cG5LY2tmbmkzMm1RQ3VwZEx0Sk9kY2k0VTY5NUNsL3BW?=
 =?utf-8?Q?iPayBaOYi3U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXRNZlMvY2pJdEIvMTlveDhaR0NGMGxXWlRsY2gyMmJySE9WK3RJV05uWTh2?=
 =?utf-8?B?bk82N2s4WGRaWlAzTWJIUVlieTZyK0xYNWYwTk9LOFVKeU9XZWw0WUhlT25s?=
 =?utf-8?B?NHpUWGdNbTAzdFJORkt6WEs0SEJuNXhSd2JJMFJTRTN3Q0xEUGZ0UHgwc0Ux?=
 =?utf-8?B?YVlwRWNqL1R4aVAxZGVINkcxVDIxZkN6WEhEZzVlZkJqbGxGd0pyb1phWnh5?=
 =?utf-8?B?OXRCRER6UzJJZkwyTUVscWpqQXNjdHVrU2tQNlRCNnhUeW50dFpjY3l4alB1?=
 =?utf-8?B?VlNSMU80eXZXK0NVVnEvdmJQYTBnQnQ1b2dEV21ERlF5L1FpNmxaLytYcFJN?=
 =?utf-8?B?NEhtcFliclNtOUJZRjYzdSs3VmFGYStYTXdNWlNrL0hETUJ2cGpaNDdUWHFW?=
 =?utf-8?B?STVqcUdjY3daS1ZHS2Q5TjZraWNtUHI2TUduVGZmQldkR3p4N2VydkFtRUc3?=
 =?utf-8?B?ZStBS1RkejNZbnNsbnAxaW10SWRJekYzVi9pK1ZVQ2V1U2pmYkRDSTBtbmRI?=
 =?utf-8?B?blM2MU5zdlBkb0JTS2wxVHFQZWtmWURmLythRTR1WENLVzJ5cDBXVUFIYmZO?=
 =?utf-8?B?a2w2VVhNTlQ4aWhSSGhkajhTZkNMQTRVM2lFcTQvTVdYaVkxZXBxSStUNUhz?=
 =?utf-8?B?TGRzRVNXc2lDVWQwWlNLRFp4VUNkRm1sUFE0V2d0Y2JmWEZiRDNMNm51OHVP?=
 =?utf-8?B?SUQwd1piY0pMMEdFSXhhbW1ERzVvRkg3YXZxaHQraGIrT1V3YW9TUjBJVVR1?=
 =?utf-8?B?cWlZb1NjZktmTHVvOGhEbzRpaW9QM2M1M0xmTThoSzFNdmhXckVUSWZ6bm8y?=
 =?utf-8?B?U3ZXUkNUdnc4V3ZuVUhpSElaRlFWWDdQZ0l2bVdrTWkvKys1U0QxbmtPa2Fy?=
 =?utf-8?B?NzNuN3JwbFZ0UlB3UlpwQWxTZ2tlSWJzK0tMOGpJWG1ESFY4RThIa0ZDQkQ5?=
 =?utf-8?B?Z2k3MWU1TjRBb3pveEl2Ly9leW5pNkk0dmpXOVBkeHFPRFNzTE1iYmxTRWFp?=
 =?utf-8?B?V0xVMmNTWVRHa1AxcENON0lWOUNoVDluS3pMR0VycmdKd2JGWjk0Q0RJc3g4?=
 =?utf-8?B?OXFoWkZuWks1SmQ1THo3Z1pEKzVtK29mUnRreTlFUDBmekROdGZXdEp3bWRK?=
 =?utf-8?B?ZU5lMHNvblBadHlVS1hXRjhDZzlOS1JHbmdOUzhNc0F4MWJpdWFZTS9SWWVO?=
 =?utf-8?B?S3VSc043eE1DOFFLU2ZRRG5NSTR5ZlQwdEtGWDVMaUNreVNNMFBLM3ZpbklV?=
 =?utf-8?B?ZTFoTTM4emZsYytRYmVOUzR2Q1diYk9iWDhOdStWTjJ5MWxKMXBJb1RtWitB?=
 =?utf-8?B?WDBxbU92RkFmb2tnbXF3Q3Z5VXVTVXVqS2xQdU04Q1FJQUdjYStOOUNWSHVE?=
 =?utf-8?B?ZE93N2pGV3R5OW9pV1NEbnlsemNxNW0zOXl3Sy8wdGRVL0JRY3FucmloTERU?=
 =?utf-8?B?T0FyQkxVT09YOFhsTHNpTzJCYjQ3d3RpUGlYRDM5Z050eHFFdldTSHV1ajZM?=
 =?utf-8?B?V3BLN21FaklNc0lSZzBDelBVN0dzZGYxMTlkVTR2dmpKclVwZzB4c1RNODRq?=
 =?utf-8?B?TUk0azZsZnZMNnpyeXlQeUhHREJJNEt5UllKc2pvRlM4N2MzcndEb05yU3ZQ?=
 =?utf-8?B?Z2NZY0k1QzFlME1ZeEtvVENtbzZwSFhWOWFpcThadGdIRFJ5bUNZV2hDMjlG?=
 =?utf-8?B?djhDTTYrYm90WkNYZFVmL0t3bzN5V2tpMGlCT0JWOXJGczRaNzUza2VJako0?=
 =?utf-8?B?RFFVRWVYRlgwNnlreENRamNiaUJremdnK2lYVmxHanlWTDhGVTNyNmhmVURx?=
 =?utf-8?B?RUlwdlBObjBoMnVaZGdXUUloTzVvNGx3a205c1pJRUdZemdYSlYxaDZWQ1k5?=
 =?utf-8?B?cjNRRCtvZWxZYWlTd0pJS2lQVE5nWlY1Qy9DaUN0YmJOMDhOVE5BZ0FEZ3JX?=
 =?utf-8?B?TFRKVGE4d0R4c0FUMXlLSmprTHVlL1FUTEZ4WjVLNDFkcGwwVWNGNzhseGtN?=
 =?utf-8?B?TnFVVmx6WkVKSW5IVHNrTCtEeTJIdTl3eVJhUjlPUCtNTG9WZGxaeCs3RHhn?=
 =?utf-8?B?T2Q1eDNjaFo4eWtXRVA2bGxZb0FBVTJ3Nmt6MHpDTzVrNEhRS2JpT0pTWHk0?=
 =?utf-8?Q?5QmKkNJ5Ar4bInzdmchzxx4Rv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e91443a-c1d8-4a3e-d015-08dd8279b711
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 15:15:43.3097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQAAfz30EEAHgEHAC1SphxK4GIZ+LyPQrY97b9iM6M5rmmrsQYhr7fgfXMkQotiP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8925
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

On 4/23/25 17:05, Liang, Prike wrote:
> [Public]
> 
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, April 23, 2025 9:58 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 2/2] drm/amdgpu: properly release the eviction fences
>>
>> On 4/23/25 15:26, Prike Liang wrote:
>>> The following cases require releasing and deferring the eviction
>>> fences properly
>>>
>>> 1) Detach the old eviction fences before attaching a new one.
>>> 2) Drop the eviction fence init reference.
>>> 3) Correct the attached eviction fence reference.
>>> 4) Free the eviction fence when the attached BOs are released.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 53 +++++++++++++++----
>>>  .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  2 +
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  1 +
>>>  3 files changed, 45 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> index d86e611a9ff4..a47db865c530 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> @@ -70,11 +70,6 @@ amdgpu_eviction_fence_replace_fence(struct
>> amdgpu_eviction_fence_mgr *evf_mgr,
>>>             return -ENOMEM;
>>>     }
>>>
>>> -   /* Update the eviction fence now */
>>> -   spin_lock(&evf_mgr->ev_fence_lock);
>>> -   old_ef = evf_mgr->ev_fence;
>>> -   evf_mgr->ev_fence = new_ef;
>>> -   spin_unlock(&evf_mgr->ev_fence_lock);
>>
>>
>> That is certainly incorrect. The new fence *must* be made public before attaching
>> it to the existing BOs.
> Here the new eviction fence also will be updated in the evf_mgr before attaching it to the vm hold BOs, but it looks much better as before to cache and update the eviction fence outside of the VM hold BOs iterations attached fences.


Well I don't care if that looks better. This is simply technically incorrect.

It's a must to switch out the old eviction fence for the new one or otherwise somebody could try to attach the old one to newly allocated BOs while we are attaching the new one to the existing BOs.


> 
> 
>>>
>>>     /* Attach the new fence */
>>>     drm_exec_for_each_locked_object(exec, index, obj) { @@ -82,6 +77,16
>>> @@ amdgpu_eviction_fence_replace_fence(struct
>>> amdgpu_eviction_fence_mgr *evf_mgr,
>>>
>>>             if (!bo)
>>>                     continue;
>>> +
>>> +           /*detach the old eviction fence first*/
>>> +           amdgpu_eviction_fence_detach(evf_mgr, bo);
>>
>> That's completely nonsense. The old eviction fence is signaled at this state and
>> doesn't need to be detached.
> 
> By using the amdgpu_eviction_fence_detach want to drop the old eviction fence which added the Bos before, so instead of confusing here and drop the old eviction of the BO directly before attach a new fence?


You don't need to drop the old fence. See the old fence is already signaled and just waiting for cleanup. Trying to replace that will do exactly nothing.

Regards,
Christian.


> 
>>> +
>>> +           /* Update the eviction fence now */
>>> +           spin_lock(&evf_mgr->ev_fence_lock);
>>> +           old_ef = evf_mgr->ev_fence;
>>> +           evf_mgr->ev_fence = new_ef;
>>> +           spin_unlock(&evf_mgr->ev_fence_lock);
>>> +
>>>             ret = amdgpu_eviction_fence_attach(evf_mgr, bo);
>>>             if (ret) {
>>>                     DRM_ERROR("Failed to attch new eviction fence\n"); @@ -
>> 89,9 +94,10
>>> @@ amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr
>> *evf_mgr,
>>>             }
>>>     }
>>>
>>> -   /* Free old fence */
>>> +   /* Free the init eviction fence which was referred by the dma_init*/
>>>     if (old_ef)
>>>             dma_fence_put(&old_ef->base);
>>
>> The comment isn't really helpful. Additional to that it's valid to call dma_fence_put()
>> with a NULL fence to we can drop the extra if check.
>>
>>> +
>>>     return 0;
>>>
>>>  free_err:
>>> @@ -189,7 +195,6 @@ void amdgpu_eviction_fence_destroy(struct
>>> amdgpu_eviction_fence_mgr *evf_mgr)  int
>> amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>>>                              struct amdgpu_bo *bo)
>>>  {
>>> -   struct dma_fence *ef;
>>>     struct amdgpu_eviction_fence *ev_fence;
>>>     struct dma_resv *resv = bo->tbo.base.resv;
>>>     int ret;
>>> @@ -205,10 +210,12 @@ int amdgpu_eviction_fence_attach(struct
>>> amdgpu_eviction_fence_mgr *evf_mgr,
>>>
>>>     spin_lock(&evf_mgr->ev_fence_lock);
>>>     ev_fence = evf_mgr->ev_fence;
>>> -   if (ev_fence) {
>>> -           ef = dma_fence_get(&ev_fence->base);
>>> -           dma_resv_add_fence(resv, ef, DMA_RESV_USAGE_BOOKKEEP);
>>> -   }
>>> +   /*
>>> +    * The dma_resv_add_fence() already refer to the added fence, hence in
>> this
>>> +    * placement needn't refer to the armed fence anymore.
>>> +    */
>>
>> Please drop that comment.
>>
>>> +   if (ev_fence)
>>> +           dma_resv_add_fence(resv, &ev_fence->base,
>> DMA_RESV_USAGE_BOOKKEEP);
>>>     spin_unlock(&evf_mgr->ev_fence_lock);
>>>
>>>     return 0;
>>> @@ -224,6 +231,30 @@ void amdgpu_eviction_fence_detach(struct
>> amdgpu_eviction_fence_mgr *evf_mgr,
>>>     dma_fence_put(stub);
>>>  }
>>>
>>> +void amdgpu_remove_all_eviction_fences(struct amdgpu_bo *bo) {
>>> +   struct dma_resv *resv = &bo->tbo.base._resv;
>>> +   struct dma_fence *fence, *stub;
>>> +   struct dma_resv_iter cursor;
>>> +
>>> +   dma_resv_assert_held(resv);
>>> +
>>> +   stub = dma_fence_get_stub();
>>> +   dma_resv_for_each_fence(&cursor, resv,
>> DMA_RESV_USAGE_BOOKKEEP, fence) {
>>> +           struct amdgpu_eviction_fence *ev_fence;
>>> +
>>> +           ev_fence = fence_to_evf(fence);
>>> +           if (!ev_fence || !dma_fence_is_signaled(&ev_fence->base))
>>> +                   continue;
>>> +
>>> +           dma_resv_replace_fences(resv, fence->context, stub,
>>> +                           DMA_RESV_USAGE_BOOKKEEP);
>>> +
>>> +   }
>>> +
>>> +   dma_fence_put(stub);
>>> +}
>>> +
>>>  int amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr
>>> *evf_mgr)  {
>>>     /* This needs to be done one time per open */ diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>> index fcd867b7147d..7e6c55a334e0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>> @@ -42,6 +42,7 @@ struct amdgpu_eviction_fence_mgr {  };
>>>
>>>  /* Eviction fence helper functions */
>>> +#define fence_to_evf(f)  container_of(f, struct
>>> +amdgpu_eviction_fence, base)
>>>  struct amdgpu_eviction_fence *
>>>  amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr
>>> *evf_mgr);
>>>
>>> @@ -66,4 +67,5 @@ amdgpu_eviction_fence_signal(struct
>>> amdgpu_eviction_fence_mgr *evf_mgr,  int
>>> amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr
>> *evf_mgr,
>>>                                 struct drm_exec *exec);
>>> +void amdgpu_remove_all_eviction_fences(struct amdgpu_bo *bo);
>>>  #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index dbe57996a481..6d3eacffbcb9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -1322,6 +1322,7 @@ void amdgpu_bo_release_notify(struct
>> ttm_buffer_object *bo)
>>>     amdgpu_vram_mgr_set_cleared(bo->resource);
>>>     dma_resv_add_fence(&bo->base._resv, fence,
>> DMA_RESV_USAGE_KERNEL);
>>>     dma_fence_put(fence);
>>> +   amdgpu_remove_all_eviction_fences(abo);
>>
>> That's a really bad idea. We only did that for the KFD eviction fence because we
>> didn't had any other choice.
>>
>> For the user queue eviction fence we should rather do that in
>> amdgpu_gem_object_close() e.g. when amdgpu_vm_bo_del() is called.
> 
> Thanks for the suggestion, will further check it here.
> 
> Thanks,
> Prike
> 
>> Regards,
>> Christian.
>>
>>>
>>>  out:
>>>     dma_resv_unlock(&bo->base._resv);
> 

