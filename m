Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1481EC7115C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 16:32:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4EFA10E776;
	Wed, 25 Jun 2025 16:32:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AC3GNu4d";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17FE110E776
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 16:32:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKV+eSMcf1jzh3VeuG1V08b2R1P9+j9HuN7HuA+ut8YNnevl4JBzNTxakY1j5O254BpYZz/azJKWlY7FgqeTOjrS/7vb1Aq3jgoQoel4HjQQ0nz67BuJBdAFtzCUQVv7ffuTq5q5NWqZwlfQXPnWm1hpBIiSPo2E7YDBFlg3hSZf5qmkxznyN0RQNEYpWIYk35qmF3ty0oL8DOGCYb1ho5XouQJoUJ/2zGULu+QRsrCferQ8ox3xkR1uXQKwWYPm0qjHoQbcD5WEDh31x2ynKQiItkItP/9zOZprVL81bAJ2zVdHAQGyjvD/TGLlXt3qm7Ri0vdCFxs3r3NiOq/K6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MOIBjOq88ETmGojobMLwJcPSzWMZE9NHn58MRpR40Q=;
 b=NAWJJUzBg+gppZQH1qtFUvtWHa+EZIHC8T0Qrjh7J7V8aWmBJIx5B4lSRlP7KKniy/Y+Zd9JfO0M47UD0BMOK4p7RvTwYq8Fnaj/ztdqH61pnQcmmhmP6j2BD8V1XSRtKKIlJToUYDkM+xyhiEs9O84dXCTwqNtdxUPrYVDvNunT0kQ7FAE1n418YTf+zNH9Jp7rOgHP662xwjWOJ0cb1y3rJOS7Rn7gdy/A0QWwgZW88BBPR+ReKVthBHqgAcShEw6NRe4SoTYCl2Pg784CGTwYSHIh5wx/19X5B3qm7VlC9fNWdFQ7SDFXljlP6EK+J5sFzrkMJXm6xrm8OF4NIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MOIBjOq88ETmGojobMLwJcPSzWMZE9NHn58MRpR40Q=;
 b=AC3GNu4dE1IgNStyUvTWCWiQfCZpBNqdjDYBxIa3+VuzUPeHOo5hXeIcYYvXt5NEzPrD9LbkDE4lB1lxIeuoOY1MfqKu+Nqn9NI13jWHPhcyfjKzgkW2CDbeRy0FrcAktnBwubjhL5gokl9PKdr1t+CW1pe5BUZHlP0OVfFpOe4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 25 Jun
 2025 16:32:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8857.016; Wed, 25 Jun 2025
 16:32:27 +0000
Message-ID: <994fa40e-5c02-4bf0-a4ff-2b7836f219bb@amd.com>
Date: Wed, 25 Jun 2025 12:32:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: revert "Implement new dummy vram manager"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, rajneesh.bhardwaj@amd.com,
 david.francis@amd.com
References: <20250606125723.7822-1-christian.koenig@amd.com>
 <20250606125723.7822-3-christian.koenig@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250606125723.7822-3-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0079.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY3PR12MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: b80e11f2-b8ff-4e7b-6305-08ddb405defd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnNuSXVIQU1uYUpwZXU4czRwWFZCZTlla2toczNUS0tvVjdidnVramc3WTEx?=
 =?utf-8?B?U09ONU1kbDJ2NzNLRituOUNOeGpYZDVsbXBPWEhLcS9SM2JVQlprTzVyWE5S?=
 =?utf-8?B?OXp5eER5YnRPZDVuSXhRWEptdGV0THVxSGRLVUtucTh3YlhaUjhnZDNyVThx?=
 =?utf-8?B?bzZERXZoMHZrZUZ4V01XZFYrU0JQUm5lNXNwMS9DOXNiMjdoZVY5RG45N2Iz?=
 =?utf-8?B?SVhiaUhBMU44TXZFYkFxZzlNazJPNVBQc2hGMmlNOG55a2h0TGJNSS82aENF?=
 =?utf-8?B?eElxNjF4b1cvZFdDeWVRUWZpSW1VSVJIUDcwSTNyR1p3aEkyckdsZDFYY21j?=
 =?utf-8?B?aGNYRTlwcytKT2VVbnQvRFJaWTRlSFdiMkNaSTllc1I2SU9QM0dUVTJSaUNp?=
 =?utf-8?B?TXVXWHROamplQUtad0tYNGNPU3NhNjA0WWU0RlpuWXAwOXB6MFpqT3FYZ2l6?=
 =?utf-8?B?RFhXZVhVdjdITm12WXArR2xFcll0M2hyWjFybUhmYWNYS05zU1Q1U2ZJVUZW?=
 =?utf-8?B?OUxsa05ja0ZuZXVEeC9UT01aU0xaOWViOEZ4MUxhYmxBNE1xRDZUVmZqVHhl?=
 =?utf-8?B?bC90OVZkOFVsMDM4NlpPNlFoSEIvL1A4UkJRdzhBbWRaK051YVhzMW41REpk?=
 =?utf-8?B?Z2pVRlNnZnlxWVZReWlReVl4azhDcU41U3YyUU1VaGs2dHpsSkhHeXE4NU95?=
 =?utf-8?B?MlppdU8vSWRHbEF0T1dKU0hDRm10ckRRcXpzWU5DTTZqaFJPNTk0WWI1Y2Nq?=
 =?utf-8?B?ODNtaXFaRFJqdDRoYkY5V1B6QzNiRWs5aG5CTmJRVzRQbHJvVHFYa3NMMWpN?=
 =?utf-8?B?cDRHMU5UNWJxZHBXV1ZpWVh6bkEzZDBoU2lVN0Y1VnpJVEYvZDZ6eVRyRTBJ?=
 =?utf-8?B?MERyS0ZMeVgyL2I0OXE2MDlQbHdQNGl1R0xLVFNmYmNTN3c1bFBmVUxyTE1H?=
 =?utf-8?B?emxRZFpQaEgrc1ByRnU0dTdQbGdOMzFBdHZ5YnZkdVpld0REd2RaL250NmVD?=
 =?utf-8?B?ckpYbEdCaXJPUEFNOFN4VTI2amhFYU9Id09GQjdMUi9wYUkyaHRNWERZeURS?=
 =?utf-8?B?NkN1REVEVXlvNEJxWndDOWNsRGdqV0lFVmJabUZ1NlJ3ZVNCaHJXZWs2TFNI?=
 =?utf-8?B?dVd2TzFneEtnbStxRXc5cDZTZmFDYmNTTklMY3d0SWd5QTZ0RHg3UEtPclJ3?=
 =?utf-8?B?cTJNSVJaVUNaZXpObmNkUlIxM05rcGM3VkxGd3YzRFB1eDZ5T00xV0ZnTGJC?=
 =?utf-8?B?d0E2K0lpMHlvYnppY2t5V08zb2kvamR2ODZLbW8xNEVtUGNSOXV0aDJLVFFy?=
 =?utf-8?B?NEg4dFlqdDVGaktZS1Z0dHllVEk2b3pTOW9YbWxJbDQ4UHNobTZocmhTQy9n?=
 =?utf-8?B?clRubTBITWxQLzdFcTlaaGhGMTVRaFFIbUMwYWxrdHJnSnVmdXF3SkJrZGVa?=
 =?utf-8?B?RTVOSDNOYjNLNGNDc0Y3Sk9uTlg4WDVrYi9lZ1JlVnNWSGMrMVpWdmZ5RnN0?=
 =?utf-8?B?QUhSR0JGQXRaSkNoYWFIT1FORlNibXkxbmRzZXBNZEZ3ZFFKWGl3MzhDeDJG?=
 =?utf-8?B?alZYRU50dHN4Z3Q2bEtFd2xqcmd1ZU5DSXlHYXVYUzVYZFVpWHlUM1pxOHdh?=
 =?utf-8?B?YVJuUnVXODlGUDd3ajRtSnB5OFZWQkd3emF3TjRLQytJb29UQ0ZjTytUMnE4?=
 =?utf-8?B?clZiWi85T1JFU2dZSGwzQVpnR25RVGlHdmtaYll2bDlzNi9VZnozeEtnYndB?=
 =?utf-8?B?NUhGN0loZUlhMVQ1dld5WTNPQWFmYlNlcUFQczdkbnBUTmdPUHZkMmxUc3hv?=
 =?utf-8?B?bDR2WUtBOVEyYmYxTGxrVVlEbGlvRkZCY2ttT05mQ2k1WnJNOFpIWDBpODlC?=
 =?utf-8?B?M3lZUFltUTErL0NaaGlIOWRQNnN2SnFZSUpnZHB1WlFTVDUxQWdpeXJKUkhZ?=
 =?utf-8?Q?vma4dj6W4LI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDhHZzQ1Yk1sTmNnalpVRDFhQWk2QVdKK1N6c2JGNCs4TlllYlpkUjRVR0xX?=
 =?utf-8?B?MmhEV01sQzY5U1FHY3pWRUs3ek1rUzdsNVNDUjVCU3hLRHVIOS9IV0V6Z2lS?=
 =?utf-8?B?eFRtcWxVY2J3T3pUSy81a1NoSWp5OWVHbWZyd1ZsTUpOTTR4M1lJcDdLZ0E1?=
 =?utf-8?B?ZXkvYUJPR0FoeVI3QzJOZnJQZThmZ1lmTWdUZTNwb0FBUis4VHNLOXIzL1Ew?=
 =?utf-8?B?Q1VoQ2hISUNQQ3BKTnF0ZGNIcDBtTXRsMElsclhFRGpOKyttY25KZllrQk5X?=
 =?utf-8?B?eFh0T25HYWlIVHJ2YzlMK0FoQVMvbzhSNm0yMW91b3drSUVRZXpBMVRGZzBM?=
 =?utf-8?B?QWFMaHhYeVVHdmpVc3ZzdkZ5bFhtQ3hTWFdGS05iUEVhL2RVUHdTQnV5Mzlp?=
 =?utf-8?B?LzZKakFxbTdYZkNHRFJNa2s2bVBKUVFyU3ZOY1RRam5TTnM0aXhYV01lNnRE?=
 =?utf-8?B?blFXQ01mNjdrVnk1SGtJd1dvNDNXd3FDeXY0NHMwQUYzUGxWMUx6Z2ZBNFdm?=
 =?utf-8?B?NE0wTUJVNHoxenlvWDM0cHZaZzVEbzFtaVlZWC9UN2MvQzhkRGc4RVZkYWg1?=
 =?utf-8?B?bHpEMVRrWlZWeWZQNGx4bERsYXVvS3k5UDRsUzNzajJLc1hKVlFYRzJCV1NE?=
 =?utf-8?B?N21iYlJpdklwUXdSZk1QNUpEdzJzZEdlQVNLcE9MMlpOeU8rcjlSVEtYbUcz?=
 =?utf-8?B?SGFlVmk0dzRsd29Hb1NCbHpYMExpL2NGRENkL2EyQ2lzVk5QU3VJSm1IcEpo?=
 =?utf-8?B?dTNkc0U1bWlBS01CS05udmtJc01rd095YnZHekdYS0kzRk1hdGM1SHVWWG40?=
 =?utf-8?B?ZzZQd1JjVk1rRzBiVWo2cnJlV3RyWjZCeHNnQ3NXN1l6bjU2MVRMVkx2bXpL?=
 =?utf-8?B?b21mK0E3MUNORS85ZklFcHYrRkJqTlYzeWxXOTZVSHo5NDBqQjhqb3VCMk5F?=
 =?utf-8?B?U3JvVVQ4U3RuNU5ZZ1ZhdEZCMjV4TXQ0SVpIZGpodHNKV1FOWjVrQk5TR3NQ?=
 =?utf-8?B?SkNqczZ4UGN3MFNmOFhzS1dvUTltbGZLZEFyZEJBc3NvNk9IM3hTbFVhTyt6?=
 =?utf-8?B?NkZ3M0kxdExZUUpTV052RWpFZjNkcGFySGgvMU5qcUR2QnBYemhqVVZwOVNu?=
 =?utf-8?B?aWNXaFdqN2hzV1lzSllXNkV1ck5kSUJESGwxRUhBNC9icFM5WDNZR2FkR1ZV?=
 =?utf-8?B?cDJFWjFHMkRPMnJ2ekxOUktWblpMMjhwTkJVZ1hTMGNDd243M3c0VHlYQnlD?=
 =?utf-8?B?aGVKbWFJWndWOTRXVENnM3pHOVhYZnVEY2I4WFhjSHlNalJpajVVaXJEWWUw?=
 =?utf-8?B?RXh5K21QRy84SFhJR2RLY1VuUEJMQTZaVU1YS0ZLdHlybXh0YmxQSFJOU1d4?=
 =?utf-8?B?eUwrVGJmZVVGWjl0SUhsRnBsT001aXg5bkpPbnJuZjl6YjJKYThLK24vOHlx?=
 =?utf-8?B?WkY0Y2RIV1Q5MnR4QjN0Zkt0WWRmZFlIay9RTTdjMnhYVEpkb1FiU0V4Q0Vo?=
 =?utf-8?B?TGc3RWFTSC9nMExWV2hDQ0RUeGhCaE52TklyWHh1a1V4dGs3enVwMzBidHQw?=
 =?utf-8?B?WW13bXQ3Wm11QSs4TTlDWGRKRFRZcUJOTXZvdm5rOHJudDBoOEZSVzJNV0RL?=
 =?utf-8?B?ZWxrZVk1NDlXZzErVk5teWZXM0tQc3JzdmIyMlhWcU42UUtpVFp2elJjSHd2?=
 =?utf-8?B?M0NrRXU1bTFIYytSVnZmNVRtd1JsL1BveGNrbGpPdGdveFFJQnFWU05VSkpM?=
 =?utf-8?B?UzdRakI0VWVtRzdXVlZTR09wSjk1WmRGZ2hqdHgybWRETEd0VjRIYWU2bW45?=
 =?utf-8?B?NmkxcVkrdXhHeVJHdzdlbWxFcW1RcXQrV2ZFSEt1YTFlTm5EaUFoNHk1Q0lY?=
 =?utf-8?B?L01qdHhCYWp2aVNVdjNIK0xwN2ZZSjNMY0RYRjJDUFArOGJEaXBENVZnZFVG?=
 =?utf-8?B?K3BDOUowZmliTmRqQ1JTeS91cHVxL3FmbzNxWXBSK05JejZ3R0puZGVGUFl4?=
 =?utf-8?B?NEYva1BQWE01S05GbFlJZ3hRNS9oVnltWThnbTQvOHp3NFhXdWRpWjY4dlky?=
 =?utf-8?B?OGFGUzkrcXllVm52a05GK09iUUVOZ2NzUUxXbUM0YThabmF5SVVpMHlMODFG?=
 =?utf-8?Q?DmiPT9rSZWTlGVh8VgrqYJZEd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b80e11f2-b8ff-4e7b-6305-08ddb405defd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 16:32:27.0102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58B6lRqk/veWN2QBfrp+CxPtQk4xF1YxHE/7uTZc+i0N7n+FRkid1WRVphbknyBn39bCo2Iv93BW2upgbRm6fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9630
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


On 2025-06-06 08:57, Christian König wrote:
> This is should be unecessary since a VRAM manager isn't mandatory in
> the first place.
>
> It could be that we have some missing checks inside AMDGPU or TTM but
> those should then be fixed instead of worked around like that.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>

Acked-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      | 15 +++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 61 ++------------------
>   2 files changed, 13 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 9c5df35f05b7..db7980105953 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1875,11 +1875,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	}
>   	adev->mman.initialized = true;
>   
> -	/* Initialize VRAM pool with all of VRAM divided into pages */
> -	r = amdgpu_vram_mgr_init(adev);
> -	if (r) {
> -		DRM_ERROR("Failed initializing VRAM heap.\n");
> -		return r;
> +	if (!adev->gmc.is_app_apu) {
> +		/* Initialize VRAM pool with all of VRAM divided into pages */
> +		r = amdgpu_vram_mgr_init(adev);
> +		if (r) {
> +			DRM_ERROR("Failed initializing VRAM heap.\n");
> +			return r;
> +		}
>   	}
>   
>   	/* Change the size here instead of the init above so only lpfn is affected */
> @@ -2078,7 +2080,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   		drm_dev_exit(idx);
>   	}
>   
> -	amdgpu_vram_mgr_fini(adev);
> +	if (!adev->gmc.is_app_apu)
> +		amdgpu_vram_mgr_fini(adev);
>   	amdgpu_gtt_mgr_fini(adev);
>   	amdgpu_preempt_mgr_fini(adev);
>   	amdgpu_doorbell_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index abdc52b0895a..2032310446e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -396,45 +396,6 @@ int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
>   	return ret;
>   }
>   
> -static void amdgpu_dummy_vram_mgr_debug(struct ttm_resource_manager *man,
> -				  struct drm_printer *printer)
> -{
> -	DRM_DEBUG_DRIVER("Dummy vram mgr debug\n");
> -}
> -
> -static bool amdgpu_dummy_vram_mgr_compatible(struct ttm_resource_manager *man,
> -				       struct ttm_resource *res,
> -				       const struct ttm_place *place,
> -				       size_t size)
> -{
> -	DRM_DEBUG_DRIVER("Dummy vram mgr compatible\n");
> -	return false;
> -}
> -
> -static bool amdgpu_dummy_vram_mgr_intersects(struct ttm_resource_manager *man,
> -				       struct ttm_resource *res,
> -				       const struct ttm_place *place,
> -				       size_t size)
> -{
> -	DRM_DEBUG_DRIVER("Dummy vram mgr intersects\n");
> -	return true;
> -}
> -
> -static void amdgpu_dummy_vram_mgr_del(struct ttm_resource_manager *man,
> -				struct ttm_resource *res)
> -{
> -	DRM_DEBUG_DRIVER("Dummy vram mgr deleted\n");
> -}
> -
> -static int amdgpu_dummy_vram_mgr_new(struct ttm_resource_manager *man,
> -			       struct ttm_buffer_object *tbo,
> -			       const struct ttm_place *place,
> -			       struct ttm_resource **res)
> -{
> -	DRM_DEBUG_DRIVER("Dummy vram mgr new\n");
> -	return -ENOSPC;
> -}
> -
>   /**
>    * amdgpu_vram_mgr_new - allocate new ranges
>    *
> @@ -879,14 +840,6 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
>   	mutex_unlock(&mgr->lock);
>   }
>   
> -static const struct ttm_resource_manager_func amdgpu_dummy_vram_mgr_func = {
> -	.alloc	= amdgpu_dummy_vram_mgr_new,
> -	.free	= amdgpu_dummy_vram_mgr_del,
> -	.intersects = amdgpu_dummy_vram_mgr_intersects,
> -	.compatible = amdgpu_dummy_vram_mgr_compatible,
> -	.debug	= amdgpu_dummy_vram_mgr_debug
> -};
> -
>   static const struct ttm_resource_manager_func amdgpu_vram_mgr_func = {
>   	.alloc	= amdgpu_vram_mgr_new,
>   	.free	= amdgpu_vram_mgr_del,
> @@ -919,16 +872,10 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>   	INIT_LIST_HEAD(&mgr->reserved_pages);
>   	mgr->default_page_size = PAGE_SIZE;
>   
> -	if (!adev->gmc.is_app_apu) {
> -		man->func = &amdgpu_vram_mgr_func;
> -
> -		err = drm_buddy_init(&mgr->mm, man->size, PAGE_SIZE);
> -		if (err)
> -			return err;
> -	} else {
> -		man->func = &amdgpu_dummy_vram_mgr_func;
> -		DRM_INFO("Setup dummy vram mgr\n");
> -	}
> +	man->func = &amdgpu_vram_mgr_func;
> +	err = drm_buddy_init(&mgr->mm, man->size, PAGE_SIZE);
> +	if (err)
> +		return err;
>   
>   	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
>   	ttm_resource_manager_set_used(man, true);
