Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCFEC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Dec 2022 14:23:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB00710E5CD;
	Fri, 16 Dec 2022 14:23:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2D6010E130
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Dec 2022 14:23:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyMEwDfie95LIa5nlg6vAgZb9ew9rb9cjNHtMsUXBbw1B57xwbXQL1TVqAyKImfYa/B19TVSXVwQNViJQDl2LjTERsOb5YdkXetbBIkY6fLykhWBZqlEIpqthat8GzEEvv27sQkj9hxoVcvWpCB5VJUoGl+DZ3tiYn4b3XNNqLMN5H9bB1mkzspv2iFhTMk8y+M2xDvOTCsdL4jUepLOsQ4gwTtispE0VKhLkOUhXzbvLnqTY3B1l3sOWLzljGu2i3UyoM7vQLklpZCG/jPaGNWXTydGCNC1ZsPkPO3C+5xO6vgvsuVX5epueqUZTkbwrPuSXwaP7DN36Rg+BVgmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bb2qjFN65uIV5O7/UdTgoeeyR7A07uMnfi37i/YPE8=;
 b=LavNTn01oaJb39PxUlK19j7qpETt9JVJx3gTDey6hXNWl6WmDxOLzyePjn/0N7Erx58nbd3Sxjl1jiJawD4oOW15xWeGiHbGcgPdvTVJ/PUuOhm1tH4RoA8gT4TJqboD0okGXxVisW3WJrY/Mr2EsLILhje/E7JHSc3W50ki7QYO+ObrEJ8aTcLPCxCKRxfKrotKmPM0u9xI5o7C5Qx6zRBthVb4nK65YI8N8sJ/y8FsIKdgRSik/Z83bxIfS5/VNSEcmMOjUZZ4oRF1LM+FvZ22rLIdRxaIDA0FyB+H/weWiNMLeHTg4gTBMTE3f3OkTS53AeeOg7fFtlL2ujUa8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bb2qjFN65uIV5O7/UdTgoeeyR7A07uMnfi37i/YPE8=;
 b=FvEgSV9Y/lfaQGqR7k9gFY2WkLNc58a+NbRUFB8ZqTtYwqTGuUwKgZQlg+DqZgK7YkaNJb6CAOun2XCzpcJnRQID/Lz3Ou5nFKJoC/XeYDqOukhJm7oKrRZ4ZP6gE90gzO1o4V89MLve2c0BVusJ9UOg+xZwF9qtjGP2n+/ZtOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 14:23:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5880.019; Fri, 16 Dec 2022
 14:23:37 +0000
Message-ID: <53d66c18-7569-893c-8371-032c077f99ea@amd.com>
Date: Fri, 16 Dec 2022 08:23:36 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/7 v2] Improve S0ix stability
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221215221059.509565-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221215221059.509565-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d72210-b6a4-4f88-b87e-08dadf711f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mghqO+bzhqrGt8fpUhl/0LcqFBZXVulq2GpZpGwP+ybajuDVplYtKt9vBc449iDpBoUgK6ZKD4UggGEIozSqlNsAxwpHIPPcepDXuM5YX8SmaDRsLbds+FxYpV7hlGs/M1YzY4Ue88U4iilGgfRtKu93Xfk7M7L+1FhUmoAsKH1WFuBF7aD7/ZYgM8USCZn6kfMi1q9wpFMLJxin2nTjdVuWQPiJqvEarDjGCnvjYjyaUIJiVFSP3jvAMfccdHdmsmjgTbtGbrGTRwVkU1uRv0FumttKEXhmJNw+CNTtHZvxehlAVq0VEkD/eln051bojNphhv9UVJ8O1hD3J6nduU5QsCGbD1WEV+e+2/+PCp1EtD0ux2SsUzuYIgGM+fspqO7cNhlcxsKh28tqFT8qWi5p1V6s+mclagdLHb9WczhMvEoScqfPZw/3k0/uaXlkMgQFSo4yaGdCqeViexVmUBcT/T0EmoWdnNq7jVvmDShW/p32m6Vk6YMx/0AcJLV3Q8BWa+w+6P4/PXFNgLOSIASxM7DtjM1rMn2ofy+yYOT+ypOliIsA41ZZcTfMXl6bXRJOD8xbZNLQXIxNx9EJpncCLpDahukDvtnqVtqNw7CgKlnveENJ7bo1y09xiUPccdn0yaKi0nIxNzotdsddcturL4cERoiOXA0bQ/G+w04e5jGRBnCwkKY7b9yWpZarX2qTrNK2B5zE5K7fxtLrd+O3W5Iha3vBj4Vv0rNbHyWIYURKASlR5ApMNb7UKX2B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199015)(36756003)(31686004)(66946007)(2906002)(6512007)(26005)(6486002)(8676002)(66556008)(478600001)(2616005)(31696002)(6506007)(41300700001)(8936002)(83380400001)(5660300002)(186003)(53546011)(86362001)(316002)(38100700002)(66476007)(32563001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rkx3YVJVWUEva1RZUk5DY3N4MDRnc0M5MTJqY2owMkg0ejJtMGNkbVlHN0Mw?=
 =?utf-8?B?cG9kSVBKQTRhT0xsQ2crZHBWQ0czenlqcmJsOW1QQ0ZlOGREd2xLaEo0NnJG?=
 =?utf-8?B?cldkTlNQanA4VldFeEZQWjRtaElFUWtxVmNqU1BBOGdnYUFMS2pTY2E2cGVx?=
 =?utf-8?B?a1pjVDluMnhyT3hvMXZJbngycXhvVFMvamlOTk1VWjI3S2M4RnJpT1JMQ042?=
 =?utf-8?B?NVV4cEVYY1g0WFpoajZxUHN3M2RvdEsvWnpoQmpjRHdZUys5eE5OdWQvcnJu?=
 =?utf-8?B?YUdUWjBRY0ZUY0JONTBkaEltVTZLTXluNWhoOFdra2IyQzZzNFpqNUY5bk96?=
 =?utf-8?B?TlRFQ0M2ZGRpM0dOVGRFTE9EZVJPWGpyTTQzTUo4dHpyNURmck1UanJHWmRG?=
 =?utf-8?B?QmtUamVpRzMvanI5STRsUFQ1ODRWTEd6cE50Q005N0NWaTBZblVyeWFRN2Vx?=
 =?utf-8?B?NGFOT2E1SW1NMzlMVUNsQkZPeTZpeE55ZStBWFFWWVdWM2FSenp4ZDZNNVR2?=
 =?utf-8?B?SE5YcS84SUNteUg4K1ZlZHNRQ0p6ODQ5N2kzMC9oeDNQMFVHTlZuUUZYNUc5?=
 =?utf-8?B?ajFBenJaWStxNFdZWGNQNTk1NDIwWDNkMkp0UlJoeGFab0hPcjRTczgrRndV?=
 =?utf-8?B?cHBGZ0xLb2VhbzJNTDdrRytpSzBjejRqeDBQMXRtQXgwTkNPRS9yeFB0QW5x?=
 =?utf-8?B?dFptbW85WDF0b0pRM1RSUDNNOEZxZXhZY0ppN3o0Z3NGem4vTUlkUEJSc3ds?=
 =?utf-8?B?cHNEZjE3d2k3bXlkTmI1akZUbU83UG5EYnpHaWRTem8yNExXRlREcUIzeHhE?=
 =?utf-8?B?TmZrMWVWZ05EQ0hxaVFJbnhCUnhVUXg0emF3b2NpUlp5Zi9EajJVSnVtb2Zy?=
 =?utf-8?B?K0xDYnUyeUJCRmFlbUZPaEhoT1N6RDdIVXYxdjExY3pDRlcwSFN3YlVHaUZV?=
 =?utf-8?B?V29wMGkxM0FvK24rbVM0ZGhJTjNwTVgvYzZ0b0tSWUYxcEJoenF1ekZFYSsx?=
 =?utf-8?B?dlFBV2tacnNiMXNWeFBveWk5WjJxQzBVTmRjMitNdnFzOG9PT3d3NW5DS1Ro?=
 =?utf-8?B?MkNBMnJoUUdTaUJhMUtJK3lBRkF6NDNab2hwWEx1L2RDblZKRlBkK1R5TWVK?=
 =?utf-8?B?S1hIYTBnNnpjbXJ0N1duL3lrWmxkVGVVbnRTQTAzMkxNajJoeVFxajRMcjds?=
 =?utf-8?B?bjNyMUZMOS9qTFRtUFYvZUxvVDF1QWVkSWF5U3NWcWt3aTNzV1E3Y0FhTjE2?=
 =?utf-8?B?VSsvQ2s1ZDRkM2N2a284Y3M0SnBLd0o5TmZmTnNtb0VnVnp3a0hkOTg3RXVB?=
 =?utf-8?B?a1MzQ3E1bWlBdEJqK0N3NjdSV1dwOTAzcDhsL2lDUWtLQ2hjVjVKREozYVkr?=
 =?utf-8?B?bFM2YStzMjBXVzcxVU9EcU1SaDlMZEZ2b3U4N1gySVpHVFdhY2Q4RTBWdnVJ?=
 =?utf-8?B?TnF0NjNsUXhlTTErbGV5MUVqYnd3djhISkZBeC9YUEwxWU5QUE0vdk8rTlpM?=
 =?utf-8?B?eFNwclhVMEJoNFNwU3d2Y25rSXAyeXgwQWdXUkVPL1BOcHoxUHZkM2tSSXZr?=
 =?utf-8?B?RXQ4czJJd1hsK2N0MUVnNGdUQW5QVEY4Q0Rnb09obW5YY0JneFl0a3lpS0V0?=
 =?utf-8?B?VGFJL1NxTDh4azdDTllYa0xTVWc2TExrRCt3NGRDMEpFejNodmlyeUF5OGNY?=
 =?utf-8?B?dklJSFhadDAraGorOUU2QXIwZWkxaXlKOHQzTXd2SkU4Z1Q4dmd1WlF3UWM5?=
 =?utf-8?B?NmwzaUNxQTYvdEJUR0t2V0MyMFRhdktHME5pNEpnYUY5UGluZ2NRbTlxMDZH?=
 =?utf-8?B?VDJSWUJ3N1VvNFlDZkNENDNMdTE3aU9DaXQ0Tm90Yy9YVld3bWlFZnNxczFl?=
 =?utf-8?B?L1E1U3RoMVRteDNFa2JuMjM5ZG8vT1JsMmQxOHA4RVZkdEVtWWFWbUx0b2NR?=
 =?utf-8?B?aitoT2xEeE9CcVVXU25oQ1NrSXlaZURaKzlOVWNud0s3NXg5SGpvcllSdk1v?=
 =?utf-8?B?YkdnWHVWcCtIQS9wZnlYVTMvTjlxeVhDVGNWSWlHTWM1YWg2TjVqSE5XSEFV?=
 =?utf-8?B?Z2RpOGwwemNrelFadGg1U0dScStJM3pKS1J3K3dGL0Y5TDRhWStyTzlNa0hx?=
 =?utf-8?Q?nH2wdjlOe75COi5pAFXfI8gTA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d72210-b6a4-4f88-b87e-08dadf711f68
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 14:23:37.9320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yhyLVztyyAWZj4yzblFvSxfJuDiPWYW4m09eDYt01iOXEeSQXuQmt/h2qdEvBxrt0elbLuXu6yAyYGRzLmiMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317
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

On 12/15/2022 16:10, Alex Deucher wrote:
> This series improves S0ix stability by avoiding touching
> registers that should be handled as part of gfxoff.
> 
> v2: add comments in gmc code to explain why we can
> skip the vm fault state setting for gfxhub.
> 
> Alex Deucher (7):
>    drm/amdgpu/gmc9: don't touch gfxhub registers during S0ix
>    drm/amdgpu/gmc10: don't touch gfxhub registers during S0ix
>    drm/amdgpu/gmc11: don't touch gfxhub registers during S0ix
>    drm/amdgpu: don't mess with SDMA clock or powergating in S0ix
>    drm/amdgpu: for S0ix, skip SMDA 5.x+ suspend/resume
>    Revert "drm/amdgpu: disallow gfxoff until GC IP blocks complete s2idle
>      resume"
>    Revert "drm/amdgpu: force exit gfxoff on sdma resume for rmb s0ix"
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 ++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 36 ++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 16 ++++++++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 36 ++++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     |  8 -----
>   5 files changed, 83 insertions(+), 45 deletions(-)
> 

Series is:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
