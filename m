Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B00CAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 10:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95C0510E6DD;
	Wed, 24 Sep 2025 10:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YsynFQm+";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8049510E6DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 10:08:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xbsq8TCtA9NfCOuvPAggrYuDrDBkUSsAIMz5jmbJsX+HXBbFjfUQJGuy6Hcz6hW61qLGifmm6vuikXg1/ozX8a287DHwHgFXyu7Y7BgmJ2Q+ejavllirIKTJLYtIAWNlVHKjmwpzVeWbKJExUV8JmMlCUo7TlbM/3wXmKw+SG6ER4xntjnsoh1aXwrqShTMQKsgakVkOSbRMSw9qNpEip1ae/JJJ8ED9FTG+lmyHWpegjcG0Rf1jtlXK2BIbnK00htUULKmsA5Ti/i8fD4BGiX4revIuMDI7J1UZShNIsAisI9gwVSvxT8wtNidwAoMlugWR7d2lYZgguT4H1ZYYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kArXWi5piuqF9Hou5MW3bBpxFQ0Kd2/FcxHLzE7gmjg=;
 b=HSs79GiwqruJ9AtGgS2b5LrHRvRyt4Mn9eAiwSwlmQev7mIZj6jk7Tz5dp6XHRHXYcFfRDm3VnAxOOzo7PB1z3II7wd+vRdx/z+NxZ//v6aCu8OZ427YKosNWQ9ibrnyizZqkk2adJn1kGn4NhjRUg1bySeqDz+qqgY5F4vg6qjB4Zjgryg8tevCJXUVi8UyniQkPOECFsEc1fOnbtU2O0FbrGrqq9hlsR/9iemNnLvemBndtBNbRvQXv4IjedpVEcz7sG9YicfoF5XmoLl0P6WjtJF3ZrCGIgj9vaomwsB0sqMuNSur5KyCCowLBRCP+nnHDxto/NISn4QCCe1+Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kArXWi5piuqF9Hou5MW3bBpxFQ0Kd2/FcxHLzE7gmjg=;
 b=YsynFQm+7OLz9iXGg8MlP5yURYmOfYcXJrr/4NoF1qQphbxM3k+8T9yvL94NnVtCynMyFJ/XDWWB9Zwyvmfi9IiRpTFSFONGR2gHtsXQvro5fs3u6ZKjm9l6vLaRHUvbfrVHIOB7p9f/eDmyfYR01663ZKKvxT9lEOVF+cRPNhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 10:08:25 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 10:08:24 +0000
Message-ID: <85153db5-5efd-4139-90d7-e18ee422a639@amd.com>
Date: Wed, 24 Sep 2025 15:38:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1] drm/amdgpu: use user provided hmm_range buffer in
 amdgpu_ttm_tt_get_user_pages
From: "Khatri, Sunil" <sukhatri@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250924074517.3608226-1-sunil.khatri@amd.com>
 <413a4029-95d3-490a-92e5-f712ae1fd920@amd.com>
 <5d082ebf-2df1-4919-8c48-9593d27ecb3a@amd.com>
Content-Language: en-US
In-Reply-To: <5d082ebf-2df1-4919-8c48-9593d27ecb3a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::7) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 7722b258-4cc9-42ac-4b4e-08ddfb524c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDJoaU5Lb2N4T2RoVDdqZ2djUEU2dkoyRHM4elhVN1EzK252dnk2eSt4QXlM?=
 =?utf-8?B?bjY1YVRNZ0Y3T2VFY0czVVFEeU5CYU8vSVNwZHVUK0x2OUdFbXp5NkxwczhB?=
 =?utf-8?B?TlNVZ2VPd3BVWi8rTHFNOXArd1ZrS2djWEUySlZZbUtLYzIzUjEyN052WlpP?=
 =?utf-8?B?OHB2RVRsbkdUOXQzNjJnZi8xQTZwVUJIUUJEVU93QXpsVmxPWHUxTG84aFNT?=
 =?utf-8?B?eDJ5U0g3NGFuNjNFR09nckJpczNnRnhaU0lBUFVGZDVVZC9BQTViTUpnejli?=
 =?utf-8?B?elIwMWFBaTZMOVh6b2twN1V6SG9FVlNtYjAvejZkMy83ZG5NTktmMTduTGVk?=
 =?utf-8?B?N3U1cXhVd2lWLzNUOUZ3OHhqenQxVTlzSHZlSkJTcE92eUxHaGZHQ1hhTklJ?=
 =?utf-8?B?c3RrV3BFY1ZFYTlNMnE1NU5ldFlLYXB6cDEvYVl1SzU3NEY0U2d2TWVTcWk3?=
 =?utf-8?B?dExIMWdpRmR4dEhZdkx1RXNkckY2M1dydE9ZM202VXAvcU5icm1UK0tYNFRL?=
 =?utf-8?B?eHV4WWxyOWZXL1BMUi8vRW5EYlhzVGNMTVFqa0JjS2tQUGVPdnpYSUpJd2Iz?=
 =?utf-8?B?UW1JUVdlYVA3enFoSVVGbkhTbjZPT0xVeUZYeUV1V3diNHE2WDFsY3duKzNa?=
 =?utf-8?B?SmIyTHdqSndGSlFwdHQyd0ZQNFJGVmJvZnhXbVdKMWliZjZPeVczNktScHdz?=
 =?utf-8?B?bHN4dFRrNGF1dllYU2lFODdnRjhubEp0aVpLTFVWMUFOaWE3eTREeFFOUjBS?=
 =?utf-8?B?eEF1Z0RCcmZONkg5RTZJL0c2d0ZudnhuUTluV2E4NmloRFZveUxFMmdNdkhV?=
 =?utf-8?B?djNKMTdPMzFYd3VmemdudWJOdHBRU2x1NjFJYklTaE5pV25sMUNtSW9VWGNh?=
 =?utf-8?B?VElVaThyWk1VQiszQXdjTktFVm5hWHpwbnl5bVdYbmJBdGZEYmpXUHhPMHlU?=
 =?utf-8?B?aGhIajJuTVY1MWNmdmVHOUNaZVM3dVB3bEJSUE9lT0xCZXhMZHlzbHhtMkh4?=
 =?utf-8?B?VjVyRXQ4bFcrNmcwK0c4bnhzZUtDWTJ4STlVQ2xXMEJLTHdqcHR4eWIwNThz?=
 =?utf-8?B?V0dSYnRDYTIyL2VRNkdJMENaSEQ0eEs5a25CckROSjQ0dU04N3dwOEU0d1I5?=
 =?utf-8?B?SmFVSjJudm84WHhNOXRtdjJ6cW53M2twclAxZGJTaXZNaXdNT0lyMjdaODgy?=
 =?utf-8?B?Q3NMTzlvRjVCT2VDRmlKclJidHQvTWpiTjdpTFZnYVM3MHhuakJCUXFXM05y?=
 =?utf-8?B?bzlOQmpicUZ3M1BRcXRoRW1OdGdzZ0hhZHdyNlNiVlo1UitSVjRNZnV5T2d3?=
 =?utf-8?B?MVk5R3A2dmdaQ3FSaExES1cxMFViRkp2c01maG9nOURORVZuL2tVMGhLNkgy?=
 =?utf-8?B?N3BUMUd5S29nZkRyb2puL00yUzhmd29oNEZmYWgwNEljeWpPL01YYWJ3VG1M?=
 =?utf-8?B?T25BUmpUaEhSWFhBRmx0dWVqbFdKMUxyK3RuZ21DaGpjR21kcEVYT0pjdTV2?=
 =?utf-8?B?T05lYmJGZWZSbGZ0MER5MG56alp0azJJYnZOTTFISFdDVithcTM4ZmFGRHYw?=
 =?utf-8?B?eGVaVGdEME5FY3U2OXhZR05ROVBJWXp2Y2tEVVhXR1VYQ0N2aFRsK1F4RjFw?=
 =?utf-8?B?cnZtVEZLckZRZ0o5MzNLcHZiejJMNWY1MzBuZ0hnQjlNZGEraFB3cU1MUUdU?=
 =?utf-8?B?aXZsR29oK1R4MXNnQ0R5THUwK01xVE9YSGYxeFB5UDB0Mk5QWlZOaTN0R016?=
 =?utf-8?B?dEV5bE9LOTdnbXZEdTQvOFRtSkEyV25xSDhXMlpWbkNPOVM3Y1RNakhMK1lN?=
 =?utf-8?B?a0ZVeGU5M3Y0dGRvVEhzRWRLTjFETGx1Z3QwekxGUmhRaGJNQkhoWmNXcElX?=
 =?utf-8?B?Qk9PRm1mZmRZbjdVTXRLNmd4NURtR3FIYUgzU21rQ29LV1l4djRHYzhzeUdH?=
 =?utf-8?Q?19f5jgchXPM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXgyZGtIN3BCUHFNSkFSb1JnMHAyYk45R1d5UGZOdzZYMHViRTlybHB3NTBl?=
 =?utf-8?B?dVErRVZrblE0dHZRZ1FIRVBYc3JVN0xQWEIyOXdsbHZDQ3NvK2ZrOHpjOTZF?=
 =?utf-8?B?NWprdXhPdzVBQndnNks2UDRVRk5Eb1lhMHZLYUFmNG5USDE1YWtIVHNwQUU3?=
 =?utf-8?B?SXNJT1poREhtQStKSEhrWnVPa2lvZVl2OVdvbWJOci9mcjIzc3B1eW9pZzBy?=
 =?utf-8?B?LzA2NFMvTS9ZdzRKTmlyZEZ6NVl3TWJTWGR1WkVxMWpDbUg3YU5KbmE3R2wx?=
 =?utf-8?B?RzlBcjVHa2pPQ2NlTEJZZlJ0Sjkrd1piMHl3WDZzVm1nRDhweWF3TEJ3ZVFv?=
 =?utf-8?B?MlJhOW9jMXhvblp6WW14YmVHTU5RVUxPb1pPbEtWem5NTG1WYjRGS1AxWHVt?=
 =?utf-8?B?NDZPLzM5all4dHM3KzhsUnJlVmR6Ri85UEROVmVMQ1p0WE1EWlc2NXBwdTJT?=
 =?utf-8?B?VGhjMWtKMnBEVkdxNndKZ3FZQ2RvNDVyVkRkNzkxRGpjNnV6NHU1WCtpM1B4?=
 =?utf-8?B?OTRQbzFOVW9aMVo0SmVMbU1RMzRCbE1tWEt4d0tYRVhreXdoMmFmNzdNSHF3?=
 =?utf-8?B?akU0UFlqMkZHbzVLSndyK0thY29jR1F1OFZHby9XeHV6V2w0Q2FTM1haVGhp?=
 =?utf-8?B?VFVyYTBHbkdRREVSMHhFblJ2ZFZia1A4NVZZVDBnZUkwMkE4K1ZSMkdVam14?=
 =?utf-8?B?aWZxbVNyUGk0bFpCYzJPZDF6YjYrLzRCSjRvZTFCQWZKbXY3UUJXczFTTm5y?=
 =?utf-8?B?czNLNnBlVW5qb0Ntays2VytuR0hScDZhUkZqKzNCY0w4ZmlSYkpVZjcwMFFr?=
 =?utf-8?B?QVdMdWtUNXlmRFNrajFDNndrYndWaGQ4Sm0zOFUwSk1OVktoZUZLVWtUMExm?=
 =?utf-8?B?YkhLa0h4UUEyUms1TGNRbWhpcUkrR2JZT0JwenFpYnQySjE1TnNnMG50aUF4?=
 =?utf-8?B?QU50SWFvSVJJUnJyVjJ4UGxKZTh2ZHZ3VmFXMHVGM0ljUHJpVkgyWmhzY0wv?=
 =?utf-8?B?ZEc5MnZtUXFzUXhuWXNzbkJ5Y0hrU3VoZy9XSnkydFd5SVB0SWkwb2RxdzNE?=
 =?utf-8?B?S1F5a3czODBib3ZkSjRJcmNibGE4bDU3N3ZidE10NExiaFVTM28wZjdXUVdo?=
 =?utf-8?B?SEFDcENmMkxPT2EzYTlyck9NLzZ1bnBKSkswNnRUTE1YYklEL3RQMTJ2RE80?=
 =?utf-8?B?WWNqVEExOWNEdjl0bnhMM1pydkJuenkzQzhNRHVIYkszaDFLRmdUMzBMUjZB?=
 =?utf-8?B?OXRXcTk1Ry8vNlQyYmdMNmlleTNtUTlDZkV5c3dETE5iSUsxZ3hnZTVmNS94?=
 =?utf-8?B?VVhGUGtuY1hoZDMzK1JDc3laS1JBVm4rSXZsOGpEZEx2MXdlQWZadDdGMnF4?=
 =?utf-8?B?RmdtemU2RXB2dHdkNXdVNms1dFcyQWFPeXRtQktOcTUzOWRvWmpYL052Q0Jk?=
 =?utf-8?B?N3FZcE9iYXdxS0pOUG40Z205S0liS3cyVDlUQysyOHJsdmRpRFh6ekZxclpY?=
 =?utf-8?B?MU1FM0hnUFdOTE9LaFFXaE5SR2gvQzZQWlJhdkFWMWdIV3RMdUtmMUN0dXNH?=
 =?utf-8?B?Yk85ajZPdEVxWVhFZ1Z1eFlNdm5pV1c3eWtEWUxKM1YybEw0M1puSVg0eDU3?=
 =?utf-8?B?cGt5T0xQZDF4bGdVUDRBN2JUcEx4azFCNDFiUFZUb3psUE5WNE5GMGJPOENn?=
 =?utf-8?B?RUFZRWxyZTRzNVJZTzFRYmVSaFVTUGFOeG9PZGc5eXprdWdiNnFxb05HL0Vl?=
 =?utf-8?B?NTd5N0hYYXhCdzBOYnFCN29zbStnR3NIM081SWIyVUYzYWlpZW1uU3JZZjFs?=
 =?utf-8?B?LzlnRmM1NCs3dUZCbU9vYnA4R0VXY0hjS20vc1hTdytNQzhiVzB0bWQ1VTF3?=
 =?utf-8?B?OVIvaHdUTU41d2hFcFpJZUFyeFNjNG9DOStTZ09xUWYxdkxNS1VmTFZDWUNT?=
 =?utf-8?B?SXpkQ0QzUUZDWk5MbXhUbWk3ZmFhcDdFQ3lzQVMvMjd2QUE5TldkUVFNOURP?=
 =?utf-8?B?aC9ZUlpSc3ovK01RTmVucVlsR0t1ZmtaQytkbDc2TUtWalpvbldTRGVFSWxN?=
 =?utf-8?B?ZkFMWTY4STJaWGJiZzRscFJzUURWdXhXd2ZKNExJSlhWOTRscHJSaVVnVzBN?=
 =?utf-8?Q?QqjeWszixW1n8yqvSUmAETCak?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7722b258-4cc9-42ac-4b4e-08ddfb524c8e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 10:08:24.8196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhzVReOy6+tzidngagw1EunuYPy7gJWHkXWJ4kDFGWg77lGFxYMEdSe6rXWDaOcyyzEC87bBYWHWVdUguUBsQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
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


On 9/24/2025 3:16 PM, Khatri, Sunil wrote:
>
> On 9/24/2025 2:45 PM, Christian König wrote:
>> On 24.09.25 09:45, Sunil Khatri wrote:
>>> update the amdgpu_ttm_tt_get_user_pages and all dependent function
>>> along with it callers to use a user allocated hmm_range buffer instead
>>> hmm layer allocates the buffer.
>>>
>>> This is a need to get hmm_range pointers easily accessible
>>> without accessing the bo and that is a requirement for the
>>> userqueue to lock the userptrs effectively.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 
>>> ++++++++++++++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  6 +++++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 10 +++++++---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c          | 11 +----------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h          |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          | 11 +++++++----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h          |  4 ++--
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  7 +++++--
>>>   8 files changed, 42 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 7c54fe6b0f5d..4babd37712fb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -1089,8 +1089,15 @@ static int init_user_pages(struct kgd_mem 
>>> *mem, uint64_t user_addr,
>>>           return 0;
>>>       }
>>>   -    ret = amdgpu_ttm_tt_get_user_pages(bo, &range);
>>> +    range = kzalloc(sizeof(*range), GFP_KERNEL);
>>> +    if (unlikely(!range)) {
>>> +        ret = -ENOMEM;
>>> +        goto unregister_out;
>>> +    }
>>> +
>>> +    ret = amdgpu_ttm_tt_get_user_pages(bo, range);
>>>       if (ret) {
>>> +        kfree(range);
>>>           if (ret == -EAGAIN)
>>>               pr_debug("Failed to get user pages, try again\n");
>>>           else
>>> @@ -2567,9 +2574,14 @@ static int update_invalid_user_pages(struct 
>>> amdkfd_process_info *process_info,
>>>               }
>>>           }
>>>   +        mem->range = kzalloc(sizeof(*mem->range), GFP_KERNEL);
>>> +        if (unlikely(!mem->range))
>>> +            return -ENOMEM;
>>>           /* Get updated user pages */
>>> -        ret = amdgpu_ttm_tt_get_user_pages(bo, &mem->range);
>>> +        ret = amdgpu_ttm_tt_get_user_pages(bo, mem->range);
>>>           if (ret) {
>>> +            kfree(mem->range);
>>> +            mem->range = NULL;
>>>               pr_debug("Failed %d to get user pages\n", ret);
>>>                 /* Return -EFAULT bad address error as success. It will
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> index 744e6ff69814..31eea1c7dac3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> @@ -884,9 +884,13 @@ static int amdgpu_cs_parser_bos(struct 
>>> amdgpu_cs_parser *p,
>>>       amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>>>           bool userpage_invalidated = false;
>>>           struct amdgpu_bo *bo = e->bo;
>>> +        e->range = kzalloc(sizeof(*e->range), GFP_KERNEL);
>>> +        if (unlikely(!e->range))
>>> +            return -ENOMEM;
>>> +
>>>           int i;
> This is an already existing code and i would like that to be changes 
> in a separate patch that i would push along in V2.
>> Don't mix code and decleration.
>>
>>>   -        r = amdgpu_ttm_tt_get_user_pages(bo, &e->range);
>>> +        r = amdgpu_ttm_tt_get_user_pages(bo, e->range);
>>>           if (r)
>>>               goto out_free_user_pages;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index 8524aa55e057..12f0597a3659 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -571,10 +571,14 @@ int amdgpu_gem_userptr_ioctl(struct drm_device 
>>> *dev, void *data,
>>>           goto release_object;
>>>         if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
>>> -        r = amdgpu_ttm_tt_get_user_pages(bo, &range);
>>> -        if (r)
>>> +        range = kzalloc(sizeof(*range), GFP_KERNEL);
>>> +        if (unlikely(!range))
>>> +            return -ENOMEM;
>>> +        r = amdgpu_ttm_tt_get_user_pages(bo, range);
>>> +        if (r) {
>>> +            kfree(range);
>>>               goto release_object;
>>> -
>>> +        }
>>>           r = amdgpu_bo_reserve(bo, true);
>>>           if (r)
>>>               goto user_pages_done;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> index 2c6a6b858112..53d405a92a14 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> @@ -168,18 +168,13 @@ void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
>>>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier 
>>> *notifier,
>>>                      uint64_t start, uint64_t npages, bool readonly,
>>>                      void *owner,
>>> -                   struct hmm_range **phmm_range)
>>> +                   struct hmm_range *hmm_range)
>>>   {
>>> -    struct hmm_range *hmm_range;
>>>       unsigned long end;
>>>       unsigned long timeout;
>>>       unsigned long *pfns;
>>>       int r = 0;
>>>   -    hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
>>> -    if (unlikely(!hmm_range))
>>> -        return -ENOMEM;
>>> -
>>>       pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
>>>       if (unlikely(!pfns)) {
>>>           r = -ENOMEM;
>>> @@ -221,15 +216,11 @@ int amdgpu_hmm_range_get_pages(struct 
>>> mmu_interval_notifier *notifier,
>>>       hmm_range->start = start;
>>>       hmm_range->hmm_pfns = pfns;
>>>   -    *phmm_range = hmm_range;
>>> -
>>>       return 0;
>>>     out_free_pfns:
>>>       kvfree(pfns);
>>>   out_free_range:
>>> -    kfree(hmm_range);
>>> -
>>>       if (r == -EBUSY)
>>>           r = -EAGAIN;
>>>       return r;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>>> index 953e1d06de20..17d2db258016 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>>> @@ -34,7 +34,7 @@
>>>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier 
>>> *notifier,
>>>                      uint64_t start, uint64_t npages, bool readonly,
>>>                      void *owner,
>>> -                   struct hmm_range **phmm_range);
>>> +                   struct hmm_range *phmm_range);
>> Maybe drop the "p" from the name here as well.
> Sure, thats sounds better
>>
>>>   bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
>>>     #if defined(CONFIG_HMM_MIRROR)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 901e0c39a594..9a93e101b67e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -705,10 +705,11 @@ struct amdgpu_ttm_tt {
>>>    * memory and start HMM tracking CPU page table update
>>>    *
>>>    * Calling function must call amdgpu_ttm_tt_userptr_range_done() 
>>> once and only
>>> - * once afterwards to stop HMM tracking
>>> + * once afterwards to stop HMM tracking. Its the caller 
>>> responsibility to ensure
>>> + * that range is a valid memory and it is freed too.
>>>    */
>>>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>> -                 struct hmm_range **range)
>>> +                 struct hmm_range *range)
>>>   {
>>>       struct ttm_tt *ttm = bo->tbo.ttm;
>>>       struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>>> @@ -718,8 +719,10 @@ int amdgpu_ttm_tt_get_user_pages(struct 
>>> amdgpu_bo *bo,
>>>       bool readonly;
>>>       int r = 0;
>>>   -    /* Make sure get_user_pages_done() can cleanup gracefully */
>>> -    *range = NULL;
>>> +    if (!range) {
>>> +        DRM_ERROR("Invalid hmm_range pointer\n");
>>> +        return -EINVAL;
>>> +    }
>> Drop that extra check, that would be a coding and not an user error.
>
> Sure i will do that and push v2.
>
> Regards
> Sunil Khatri
>
>>
>> Apart from those nit picks looks good to me.
>>
>> Regards,
>> Christian.
>>
>>>         mm = bo->notifier.mm;
>>>       if (unlikely(!mm)) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index 6ac94469ed40..a8379b925878 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -191,14 +191,14 @@ uint64_t amdgpu_ttm_domain_start(struct 
>>> amdgpu_device *adev, uint32_t type);
>>>     #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>>>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>> -                 struct hmm_range **range);
>>> +                 struct hmm_range *range);
>>>   void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
>>>                         struct hmm_range *range);
>>>   bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
>>>                          struct hmm_range *range);
>>>   #else
>>>   static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>> -                           struct hmm_range **range)
>>> +                           struct hmm_range *range)
>>>   {
>>>       return -EPERM;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 273f42e3afdd..9f0f14ea93e5 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1737,12 +1737,15 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>               }
>>>                 WRITE_ONCE(p->svms.faulting_task, current);
>>> +            hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
>>>               r = amdgpu_hmm_range_get_pages(&prange->notifier, 
>>> addr, npages,
>>>                                  readonly, owner,
>>> -                               &hmm_range);
>>> +                               hmm_range);
>>>               WRITE_ONCE(p->svms.faulting_task, NULL);
>>> -            if (r)
>>> +            if (r) {
>>> +                kfree(hmm_range);
>>>                   pr_debug("failed %d to get svm range pages\n", r);
>>> +            }
>>>           } else {
>>>               r = -EFAULT;
>>>           }
