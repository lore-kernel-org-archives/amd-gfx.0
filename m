Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B670E77184
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2024 10:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A1F710E4E4;
	Thu, 19 Dec 2024 10:41:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V8lQ79cz";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D25410E4E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2024 10:41:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQYX7DA7Jvzd+BuFy+tLyGlfDH07dLXPfcSHnHu76kzsO6HTOmuW93wch2NhmrM8uKNkxMzwb2SDQJKjdLKbjEikBODPz6batiX9dYymT4feu54Q2LrThi+sEBgiO1EHrqnEeJGUmF6H1/iiFEUAUdAA8J/D8kYQZKkRyTMk1+yeXDvC1Q1mg+aaA9AuvOmbQdXMHTZS1mNf5Hvn+PuzzET6pW8pKVmi7szgLrJANgUadFRafdws76TSx/iNjYYAnBpiJxyZrozqvYoHDufu60/SJ5RpKOEIWtzTiqIq0uyTHqw0JWsZLLsbWFP9RlRbvDJNTa5m1sl77YtTyaOyGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTFhX+PX2kvLwJpVwrrgqX/QO/1p3dgpeQJDODKo670=;
 b=cMv2Q/G8BrFIi/4wp5ItCSwahZy7HGG4jxuLJ0J7hdwLi/krtuAkN+g5EE17ox6Ioe8Tk8Fha9IrW/rr6bhL0Y/QSKeYdbv+bKt2t2C87gkduCISFBzqdYQg2wtCasA5CMn06lzwTyjusKBEPkC290h/MaHUnagTPvw6hHFpv5vDxyjpq5pcqYqnzQukNwvmVnh3mctqBzgMbo0+CwflM0Yh9870hF9CSMu3MNJJl3iipeMEC7fZCh0y/gR/WjiWexc+M6u/UWeF6VKnIyWuZRcOV6HOyj4IseY1HgeTpF7Jc2CY7hvNDS6PR8a9FF2Im4OhPoF3jl9WNuh8FKL8iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTFhX+PX2kvLwJpVwrrgqX/QO/1p3dgpeQJDODKo670=;
 b=V8lQ79cze34kgUV+HYHBowehBLSNcG3GVj8xNoQ5xJvTqluqfhT4NaWfuoHBbfd0RGc5tPsnRx+GuuAZk9wG7K/f72fwCa0FKpQbNHNOrR/6JP6rU1mUE+MeJM42FHVXsmaguaHEn7jccV8iRcwBYcaZvbT187Am/wpzi6atzRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9118.namprd12.prod.outlook.com (2603:10b6:408:1a1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 10:41:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 10:41:39 +0000
Message-ID: <22a8d1c2-712c-4c16-a296-81fe342bdfde@amd.com>
Date: Thu, 19 Dec 2024 11:41:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm/amdgpu: Fix out-of-bounds issue in user fence
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241219103824.630689-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241219103824.630689-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4f33bf-aa42-49a8-0f73-08dd2019b81a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTVrVGpsZGg1RlFrTnhsb3FURVU4MzVMS3ViWmlNeE1UT05ZZnI2ZHMwMnhq?=
 =?utf-8?B?WkY3N2xLWGNqWWdqMk1GZ29OaVBmYlI0TkNBVVJRbElpd1U4VFVoOW5MbWJa?=
 =?utf-8?B?VHdlM29qSFcvdzBiN01acXYwNk1kdFFIaDcrazlOVDBWMldEYlAyalgvTUs3?=
 =?utf-8?B?eDMwak1EeU1SQ1BSaTZXM05NaUZKYmVKbEYrQ0NuY1lvM2JVY3lzUE15eXVr?=
 =?utf-8?B?djFmNjR0eG9KYW8vMzNUSzFrdi9hVzI2M1Y5RU5GKzBlUk5iV0U1VU5hekhK?=
 =?utf-8?B?dCswOWFHSytkTWI0Y0M4bW04Y0F0RzR5Q2lqc0cvSnFycFBrTWJxNHl0b0tZ?=
 =?utf-8?B?MVBoOXVsdzN0SWpMd0lrVllRRFlrTFo0TVhKMDVxdmtkT2VGbkdiRDF2c0dL?=
 =?utf-8?B?d29qb1FYYURnbGJZbmxQWXd6ZGFibmV2U2JYd0h0QXlrUmV0ampSYmcrRWV6?=
 =?utf-8?B?Vy85ekpLcmZOdE90WHBLMWtjNHZ3UGtCK1FwK3hERUFIa3p3aXJKS2hYTG5u?=
 =?utf-8?B?SnhZL0ptNDg3dmwrQUFsRWVNaktIYkdWVlU0bk1nM0N6a21mSWREbVN1bHRJ?=
 =?utf-8?B?SmFmT0krK0lXa25xYTVyQVA3eUxEcllYanVrellXNDRVbi9pc2dhYi9tdW40?=
 =?utf-8?B?UVl2U1ZDdWZaczRqWU56cENyaEpBSE5SS2dFajQzU1l5eDB0MXl2Z05BcFk2?=
 =?utf-8?B?ZjYxRmxWd1pNWVNpTHFKeHFmUjJpQkhqYTM2QzZ4Y3hUQ2VHV1VKVXRlWXA4?=
 =?utf-8?B?MEhleEZzcHRscFhMTUFKSVVQajM0eFRpWmlhRWNLZ3d6WmJUcVdtMDcvUXF1?=
 =?utf-8?B?SjZjZ3pQUWVCeWtFY2JtSEtJOUpBRTZEUjNuS3F4TnVtenU2Y0xkcUNyckdm?=
 =?utf-8?B?Vzl4SmVPRm9UU2pmRjdxV3llOTlmTE02c1NZQ25GTE9uOFNmYUpqblBibm1w?=
 =?utf-8?B?eUFJRWZCblJJR1hxdXUybEpCM2p4Q1dmZFBwUGRvQzdzZ1hrTXFqaUgxb0Rr?=
 =?utf-8?B?cHdtc0l5cDMxS01mcHNMSkd6NTlPUk5FVFBBOUIrZStHKzVtWUFzR1RsdXJk?=
 =?utf-8?B?VnpKS0xUMG1HOHFnYUEzdWVMZ0xIWEM0ZjRMUnViUjNUU29Md0FOOEJYcGFo?=
 =?utf-8?B?dHlhMDJkVExYUlNFTGVqYTZpYUxNdDBCQjE0eHVlM3B3QitMakVQcFo4YURu?=
 =?utf-8?B?ZlBqWHlKU3c5MVJ6TW80VFc0RVhCQmlsNEp3NHAxNC8rdjM1RkRwOVVlemMv?=
 =?utf-8?B?TFlXZDdnVGlJWmM5NkRQd0lGNFUzUy9DNGVpTERxUVYxN2dzMGlidks1WEVM?=
 =?utf-8?B?TjU3dlk2ci9paTdEeXVDUU5NeVJab3d2TXJqZktlOGR5QWFLdldodFpGZVlt?=
 =?utf-8?B?Z0wwTVNCakRNVVF2dHVMNVFVK3lmL3paN0dpM1lJMm1uN3FLbStxSm96cGFU?=
 =?utf-8?B?RWt4MFJJcGdFRjBKcWlYc2dCbEJURkg0VFhPcENxODdGRVNTNUJuUGtQMFRy?=
 =?utf-8?B?bWpLTWppNnZLckkzVzFsYXQ5eCtEYmdLOW1kWmtIZGx2c1hNNktDcWV0V1pH?=
 =?utf-8?B?RlJFUWZoK1l6VzJTUU9nbUJudDJYRkFXMnZid0NEWStQR1RSTDdESzQwSWlj?=
 =?utf-8?B?UW1lSUNhTkROOVh5ZTRvRWo0REpBVTJjcmNMTkUyL01NZElQcHErNjVQejg4?=
 =?utf-8?B?WjZDYVdURVNlT1EwTzhRVVlRWWgzb2tyTWZMbTAzelNScy9PbGE1d3ZmamJ0?=
 =?utf-8?B?eVY3Vk1GcUZiYlpOUVh6UktodWl3V1k0RHNoZXBuaENRVlhXakpQSWZsRHlE?=
 =?utf-8?B?Sk5LUC9hMmYvUU9RdGpsbGpkM0MxdkExTGc3N016UHN1NmwvU0hQZDZMdUZa?=
 =?utf-8?Q?Q+caPE3aJAZAg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTk2K0tHanRyL1QzSHdPM0dXajNoSEE2U2pXNExaK0xPR3Z0aXV6dW84Y2R3?=
 =?utf-8?B?d2tkOHNGR21oVWFLUS85UjNiYUlmL1g3SXJwZFdpdFNQUnRheFUvL0d0Qksv?=
 =?utf-8?B?Z2ZwUzVHcWF4V1VUSURxOVdJRGl1Y3BRelhFczRmcm1aT1RUQjdBVCtndDRV?=
 =?utf-8?B?UU9mZ29sdUNVWHQzT0h4VzNPZzZ5WE0yTHZScGkrQ2JmL3pGSTgxRDY0TDE2?=
 =?utf-8?B?UGlNMk5tTzZQV1J3UmlTTE1UMlIwcnYyTUtRcVgxSDdpVUxFa2dRRHBHT1Nm?=
 =?utf-8?B?UlNUY2VBRWEzMnNucUZCMTFRT25va0ZYOUNubWc1dGZjOVNidENRTHJUcHJB?=
 =?utf-8?B?VGN6RTQzSEl3ZzJWb3E1YlBzYVZGbmd6Ri84ejZ5SWdWOWpRTEVyTjNUQ1R1?=
 =?utf-8?B?NHI3QkhMcit0QmJ3UDNmcHZuRnRYM2JVK3hGaDZnTExrWkNhNFYzTnloZDYy?=
 =?utf-8?B?ekp1MXFpbXkwelFldy85eUxRRGk4MWtlNURCOU1xUHEzZ21sTE9YVnlvaWhI?=
 =?utf-8?B?SHluakJSRE8zQmZ1SEhlOVFXNmFGL0V4a3AwZ2EwQm1UdDU4L1M3RUlXZHhn?=
 =?utf-8?B?a1hIclRQcCs0Nm5FY0c2eDV2amxmYU9mbVNqaWVyc3hlNW1FREJlMkZKVEV0?=
 =?utf-8?B?UVBrc2Z1OW1zV1FuRkNTYmNkNEVqRGZudDdxdlV5OXhEZUFzcWg3OGpjdTJG?=
 =?utf-8?B?RHZFK0hnZHBrektZWkd4M1dsdkQyUUI3SkUxemVhc2lRQXdvYzVlZzF4VG9p?=
 =?utf-8?B?c0Jqc2tmVGpTaUJRMmhYMzFjUzZzMURaZFBaVFB2djNwLzEzVXl2SVVmK1dI?=
 =?utf-8?B?ekJpTEN0djAvQ2RWeVZxcjVPb0xMS0s0N2dxdXR0UWZqeE5PdTlOd2dEa0o2?=
 =?utf-8?B?VkFlMHh0QngyVWZMUnBKc1dIdDZRQkY2SDlXOGdGMkdHWndUSEFlNy8yMGpn?=
 =?utf-8?B?SStaV0EwWWs2bnBnK1pBTE9uQWJ1ditFU1k3bW9HTllOclJXTUtXTHBtZHFJ?=
 =?utf-8?B?Vis4VDByUndtbm9jbEFFZUN4ZWZFNERZL2RnalVCVE5pc1BRRzBmWHdEcjBh?=
 =?utf-8?B?UStTb040Q0NyanNyU0tXYXFoRVlEYjBuTjhmUXpWQmdZRlJTVktRYUtzUVRi?=
 =?utf-8?B?VjlkWmVtTkpmOWU3SDZHbEFlWm1qaExQZHNHRGVZcUx4cXJKU0RyWlFNQ3BO?=
 =?utf-8?B?ZTlqeXpKaTFjUjZnVGNPT0FjVlF3TW5ORjd0VHJhNjVPdEZlNkhmTTc2U3Vv?=
 =?utf-8?B?WXYzSlZORzZYdFpzcHB2VDBCQWplT1ZBK25HYzJmb1N4dkdQRm5icnRCcTdx?=
 =?utf-8?B?aitSamc0NE5DODFONEFJNjhMY0Q1VDVFck81UFAycGpBRzZuT05KbXBjR0Jo?=
 =?utf-8?B?SXFYSW1ieC9MbEZOWnNXVTZqaEpDc0ExL1BXRUlyS0VqVFlKZmk2VHNhZGdG?=
 =?utf-8?B?L3poM0VwM3NaMi9wVWV6NFJKaCtpQThwdHB0bCtzNThVWGE0WDJtNEl3b1c1?=
 =?utf-8?B?TFAxdElSTVI5Q002bkkrTHJ1Q1FFS1poQWZNVjBJQTVBNUNEZ2ZuRGtacmFx?=
 =?utf-8?B?WWJTaG00Rk9KY0FIcVFzR2NId1dTb2tQVGhNSkpxYzk2dS9Hc2ZtRGh1c21Q?=
 =?utf-8?B?QlROVDl6aTNnNHkwYTVMWkdPRzBqbHp6Z1hpRm5UK2VSU3gvZitjOWtJOFJx?=
 =?utf-8?B?SnFDbDNYMHE4S2M1ZFNVTjBUbnhtdUxnQkhMVnZnNm9Cek9sMmdMTmdqa3Rr?=
 =?utf-8?B?OG5VRkVWNWowdUZTMThsdTVyWlp1azEwNkFzU2RFamwzcTluMHhHWWk4NTA5?=
 =?utf-8?B?TTdBeUJjSjc0T0hvalFmY0JTS05CUXZlakVEL0dHSUNIcUw2UVFFUEZaVmNV?=
 =?utf-8?B?L0Y4Nk9PeTdxL0xVb3lMVFNuRG1rRHlGbmw2WWlkSUR3YzhCbzJnKzdYc2k3?=
 =?utf-8?B?OTAvSXA1bGh5RXgzOUFzSFJGVG1VbHN0ZFdvS3o1MmdRNUtZTXRBQUt4dkhW?=
 =?utf-8?B?aURvRmw1L2NLUEtkZTBoU0M1ajZub3BHWVZmVHM2WFZ6Z0NHNlFzR3JoNno5?=
 =?utf-8?B?WkcrUkhaYUhWNVY5RUtlRkhsb3MzN3FZMnJneXVBY3kwT3R5QS9MUlRBYUlO?=
 =?utf-8?Q?lgI1dLedKPf0k1pQqUVc2Y3Ss?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4f33bf-aa42-49a8-0f73-08dd2019b81a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 10:41:39.2945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmzgZYaHV7NU8zxIpWJQ7KnXabUEDEZLNMiKiYhMsthfreYTQnxeuR7sGd0s/Euh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9118
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



Am 19.12.24 um 11:38 schrieb Arunpravin Paneer Selvam:
> Fix out-of-bounds issue in userq fence create when
> accessing the userq xa structure. Added a lock to
> protect the race condition.
>
> v2:(Christian)
>    - Acquire xa lock only for the xa_for_each blocks and
>      not for the kvmalloc_array() memory allocation part.
>
> v3:
>    - Replacing the kvmalloc_array() storage with xa_alloc()
>      solves the problem.
>
> BUG: KASAN: slab-out-of-bounds in amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
> [  +0.000006] Call Trace:
> [  +0.000005]  <TASK>
> [  +0.000005]  dump_stack_lvl+0x6c/0x90
> [  +0.000011]  print_report+0xc4/0x5e0
> [  +0.000009]  ? srso_return_thunk+0x5/0x5f
> [  +0.000008]  ? kasan_complete_mode_report_info+0x26/0x1d0
> [  +0.000007]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
> [  +0.000405]  kasan_report+0xdf/0x120
> [  +0.000009]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
> [  +0.000405]  __asan_report_store8_noabort+0x17/0x20
> [  +0.000007]  amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
> [  +0.000406]  ? __pfx_amdgpu_userq_fence_create+0x10/0x10 [amdgpu]
> [  +0.000408]  ? srso_return_thunk+0x5/0x5f
> [  +0.000008]  ? ttm_resource_move_to_lru_tail+0x235/0x4f0 [ttm]
> [  +0.000013]  ? srso_return_thunk+0x5/0x5f
> [  +0.000008]  amdgpu_userq_signal_ioctl+0xd29/0x1c70 [amdgpu]
> [  +0.000412]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
> [  +0.000404]  ? try_to_wake_up+0x165/0x1840
> [  +0.000010]  ? __pfx_futex_wake_mark+0x10/0x10
> [  +0.000011]  drm_ioctl_kernel+0x178/0x2f0 [drm]
> [  +0.000050]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
> [  +0.000404]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
> [  +0.000043]  ? __kasan_check_read+0x11/0x20
> [  +0.000007]  ? srso_return_thunk+0x5/0x5f
> [  +0.000007]  ? __kasan_check_write+0x14/0x20
> [  +0.000008]  drm_ioctl+0x513/0xd20 [drm]
> [  +0.000040]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
> [  +0.000407]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
> [  +0.000044]  ? srso_return_thunk+0x5/0x5f
> [  +0.000007]  ? _raw_spin_lock_irqsave+0x99/0x100
> [  +0.000007]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  +0.000006]  ? __rseq_handle_notify_resume+0x188/0xc30
> [  +0.000008]  ? srso_return_thunk+0x5/0x5f
> [  +0.000008]  ? srso_return_thunk+0x5/0x5f
> [  +0.000006]  ? _raw_spin_unlock_irqrestore+0x27/0x50
> [  +0.000010]  amdgpu_drm_ioctl+0xcd/0x1d0 [amdgpu]
> [  +0.000388]  __x64_sys_ioctl+0x135/0x1b0
> [  +0.000009]  x64_sys_call+0x1205/0x20d0
> [  +0.000007]  do_syscall_64+0x4d/0x120
> [  +0.000008]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  +0.000007] RIP: 0033:0x7f7c3d31a94f
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 43 +++++++------------
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  3 +-
>   2 files changed, 17 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 2e7271362ace..4289bed6c1f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -122,10 +122,11 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   
>   void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
>   {
> +	struct amdgpu_userq_fence_driver *stored_fence_drv;
>   	struct amdgpu_userq_fence *userq_fence, *tmp;
>   	struct dma_fence *fence;
> +	unsigned long index;
>   	u64 rptr;
> -	int i;
>   
>   	if (!fence_drv)
>   		return;
> @@ -141,8 +142,8 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
>   
>   		dma_fence_signal(fence);
>   
> -		for (i = 0; i < userq_fence->fence_drv_array_count; i++)
> -			amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
> +		xa_for_each(&userq_fence->fence_drv_xa, index, stored_fence_drv)
> +			amdgpu_userq_fence_driver_put(stored_fence_drv);
>   
>   		list_del(&userq_fence->link);
>   		dma_fence_put(fence);
> @@ -221,34 +222,24 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>   	dma_fence_init(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
>   		       fence_drv->context, seq);
>   
> +	xa_init_flags(&userq_fence->fence_drv_xa, XA_FLAGS_ALLOC);
> +
>   	amdgpu_userq_fence_driver_get(fence_drv);
>   	dma_fence_get(fence);
>   
>   	if (!xa_empty(&userq->fence_drv_xa)) {
>   		struct amdgpu_userq_fence_driver *stored_fence_drv;
> -		unsigned long index, count = 0;
> -		int i = 0;
> -
> -		xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
> -			count++;
> -
> -		userq_fence->fence_drv_array =
> -			kvmalloc_array(count,
> -				       sizeof(struct amdgpu_userq_fence_driver *),
> -				       GFP_KERNEL);
> -
> -		if (userq_fence->fence_drv_array) {
> -			xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv) {
> -				userq_fence->fence_drv_array[i] = stored_fence_drv;
> -				xa_erase(&userq->fence_drv_xa, index);
> -				i++;
> -			}
> +		unsigned long index_uq;
> +		u32 index_uf;
> +		int err;
> +
> +		xa_for_each(&userq->fence_drv_xa, index_uq, stored_fence_drv) {
> +			err = xa_alloc_irq(&userq_fence->fence_drv_xa, &index_uf,
> +					   stored_fence_drv, xa_limit_32b, GFP_KERNEL);

That is even worse than what was discussed before. Now you have two XAs 
and the second is incorrectly using GFP_KERNEL.

Regards,
Christian.

> +			if (err)
> +				return err;
>   		}
> -
> -		userq_fence->fence_drv_array_count = i;
> -	} else {
> -		userq_fence->fence_drv_array = NULL;
> -		userq_fence->fence_drv_array_count = 0;
> +		xa_destroy(&userq->fence_drv_xa);
>   	}
>   
>   	/* Check if hardware has already processed the job */
> @@ -300,8 +291,6 @@ static void amdgpu_userq_fence_free(struct rcu_head *rcu)
>   
>   	/* Release the fence driver reference */
>   	amdgpu_userq_fence_driver_put(fence_drv);
> -
> -	kvfree(userq_fence->fence_drv_array);
>   	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> index f1a90840ac1f..3283e5573d10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> @@ -37,9 +37,8 @@ struct amdgpu_userq_fence {
>   	 */
>   	spinlock_t lock;
>   	struct list_head link;
> -	unsigned long fence_drv_array_count;
> +	struct xarray fence_drv_xa;
>   	struct amdgpu_userq_fence_driver *fence_drv;
> -	struct amdgpu_userq_fence_driver **fence_drv_array;
>   };
>   
>   struct amdgpu_userq_fence_driver {

