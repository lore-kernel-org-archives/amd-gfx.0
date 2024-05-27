Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D584C25B74
	for <amd-gfx@archiver.kernel.org>; Mon, 27 May 2024 19:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A6AE10E02F;
	Mon, 27 May 2024 19:02:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mrmoc/r6";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D580410E02F
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 May 2024 19:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKeNd8Emc6HitfCEc7s+nrbJGyprcMhpB/JM5wphlrYx5E2SL7g/Uspz6Kg0hDri70q0xBMDWObXMPHPVVmYIcZCeK0lBVQv3UvMwuUOfS9FsF5HSNR3AKu1saJuMynYcksfdHPkwGGzFdkXluPCr1iSQttiLEJSWvTtPdCOJTlkY8rZzmr79TeoR0IkB4sxpPzMWzy8ExujV7kpkpkpIZRsCDMfIBl8g1PEc7wrv1ShEagSNyeV39owNjR3XHePBu6qrzalzmDybnGwjZobgO9xbagN0LxrIBOdmppmuNjO520IRYZ6649sV3HGGjOqBMfzUn8bW/xRdb3+dBaUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tj/nvKiIhwR96RRo6oWa3Abo0V0OxjILfhXWj+p7+UI=;
 b=oLRim0Pfz1skLyLcm5qR2j7eNHotJD9h8M2DmvOk1vdaRs3OMIrWQ459l+gvCuTcWOdVH/xVVhoRimM2lvZka7uct4QZhglBLUizpB/kQ0uNvPK1M7tHJHhYXp88kZAThKMcajePPTHrRKklaPfogC7sHHJU5wJCmD9nFtlqnHsQsmNm8B4UV2aHY/HM5BB4bmxVPjWWWSKH7NVCzOznV4mCTMUU+h/D03RJVj4d1s5KKfduUi4hHMNNMhjtqfujsIdA5suUxO2h4GkzRckuNQPhQB0QlIjNR0fGguGispcLiEihnepCzvXrwt7uy7qNM8rc7/5aVY+yIzK7TBuvsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tj/nvKiIhwR96RRo6oWa3Abo0V0OxjILfhXWj+p7+UI=;
 b=Mrmoc/r6Ji7GqwVSADZIsx4WKcrHukY6yc9NGaNLkl9HYc/9qT1Bn1dzxEk2WszgZv0dnQUQKj1Q4xls+Gfm+0g4SFye1RmZZG9zArhijLihI0Uvi57kwYewPImk1IiPnYfqIjMiKe2JRiE/R491p0t61LK7eCteyFGynF93YQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 19:02:49 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 19:02:49 +0000
Message-ID: <10603bd8-7f6c-4a5f-a5f6-c493cc8df64c@amd.com>
Date: Mon, 27 May 2024 15:02:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: simplify APU VRAM handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240524140807.3186797-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240524140807.3186797-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0217.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: bda739f2-5b16-49bd-d8ff-08dc7e7f9a60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGkveTJMOG5JSVFNY2lRRmFuSThnb0NVa3lHK05vU0pVSXZDTjJmSXBqVE5E?=
 =?utf-8?B?SmZucmVjT0ZDTFdBVjY1QlkzZVZ2VVJINTFFRjRXV0N0bDR4L0h4VVIyeEs0?=
 =?utf-8?B?NGF2WHJCUFVNMERoRzUxU0k5U3pmdFMwd1NSMkUrdWEvU2hqMDE5RUJVQzBh?=
 =?utf-8?B?RHhRQ2N5c2FXdW15U3dMcWtMcXhtMlJZSzl1QXR3Mkp5WVhqVjdaTGVubm5W?=
 =?utf-8?B?bDZYZkFCR3NzLyt1c1VKOFRhNVFSVmpYK2o0TWNwT2tZTTEwVkJveWo4L1M4?=
 =?utf-8?B?VkNxUGR3OFFGcHN4TmdybUNpSEZ6UVl2azlRNktiaXZiYjM1eFBjK3lvamVo?=
 =?utf-8?B?eTlDM0hobGVLTmdWMk8vVWdLbFNtMjBxajBIWlQxRXlrZmZzTGppdG5XOXFj?=
 =?utf-8?B?a0swa21nY1hGd1VLeU9pUjZVMGxMaFQxREFlQjB6bWl5YllwanNxTHhrNEJV?=
 =?utf-8?B?SHZsNFJUYWtRV3o1NFhJTk1YODE4a05XUExWNXNQWUpwLzFZUys4dk9YQ1lJ?=
 =?utf-8?B?ZFV3a0FyNmwvN3IyaHVsSVA2bERuY0xjTVJPSCsrMnZSS2JRY3BTQnQwSDg4?=
 =?utf-8?B?Y3JCOEp4N1A3WEFTeE1WU2RueGRhOCtST0xGZWM3RzF5Q2p4N3lUMG1wZGd6?=
 =?utf-8?B?KzQwY2hKdnlLOEVBWFlRZXBHNXJ3UUQvWTB3YUJBTEZqNmlnblRLaFpNYlc4?=
 =?utf-8?B?eEt2Y1JlZHYxR05uS3BFMnFxNHVSVkFLbXlRMFBiWlRQVkEwZEUyTklmODlB?=
 =?utf-8?B?UmYyV1hUK050bWlRZU1jUzA0T1A1dTlCeDJNTUkrd0F0YnBkMy9pWG04YTVp?=
 =?utf-8?B?TVBJOXI5Vis2QUsvS1czRzJKdFJIQ3dmb09kTVRpU3ArMi9vU2g0aGV4Tm1T?=
 =?utf-8?B?RlhNVGVtdjNKQ3pnU1dsSUtGbkdBajQ5ZGxNZTNkRExwUU9vM1FUN0VHWUtJ?=
 =?utf-8?B?bDhYQ0tLVzN1UVNrWG14WEd2UGs4SFZ4dGdjZk45elo1WlRDTDdzUDJ3MGVU?=
 =?utf-8?B?ZGt1V0hjelNxZTlqYlcxNGJ5cHFGSTZ1L0FzRzlISXZOdUlpRXV0alBRdmJi?=
 =?utf-8?B?bW9nZUdReWhoUFE1K3BDNk5vMGM1ZHY4ZXA2WnBvKytnbXVPQmdab0ExVG0r?=
 =?utf-8?B?akJwdDJobUtQQkJlSWRWWVdMbHVjZ0lrRnRodU9uVUdDY2xqeEx1U3E1T3Vv?=
 =?utf-8?B?eUVkbGFSaEFhQWNSOHlmMVNQUG5vMTRROWNYZnhCRW9uaGlRaVQ1ZXhXdkc0?=
 =?utf-8?B?SWlpbjhnSGxudHJObFFVUWszelJlYXRNMW9RT2FJd0VvcFJHK3RpcDI4SnZL?=
 =?utf-8?B?QTNxWEtQdGt6d0dsc3V5SXdiRndPaUsyN0tRQ29wUm5PaFpYYjRmZWtrZEVD?=
 =?utf-8?B?MWNQZEIvZ1RsVWt4N0hoK0RJaWptYTB4eDJwa3hMUUdoVzIxMDNNQ3dqWXIr?=
 =?utf-8?B?Y3ZhQlVpRGdkSTU5bnVsa2NjWEY4WGx5RGxXc0xtZUhxRXhod0EyWGV1L0pD?=
 =?utf-8?B?SG9ZOVFOZVJJOFc0bU12MXg4QVRGT1o1NU15akxmMEIyQ1JSQm9CVngzZXdl?=
 =?utf-8?B?ckR5Z1lvWHpURnF1ZWxoMGFZUmxNakFUQnhia0ZabHA3M3VqU3BsM0t5SlJt?=
 =?utf-8?B?Mjg3enFJcW1uenlQNXNNaUpZbENiaWZ4cXhRNnpiVGNHWVgrVEtkZk5URVAx?=
 =?utf-8?B?VHdxbFE2MmJvQUtuQ2VZZ2VvTjRLZGlBaW15K2tlUkYvWmVhWVpmRUhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU9raldLK01aYVh6dFd1d2swcUQ0dDRuN0dGUWtWYVZWbUVNb0l0TlRQczF0?=
 =?utf-8?B?QU9sS1JvaG40V2FKeExhVm15aGdZaFpTT0R6bHlqZGFIUTRTZmpvTnJVdklS?=
 =?utf-8?B?bDNxUXBLNzZ6TEhhMk9iSTI4dk5KeUt4TkMrM0FtYWFWUlBPaUZDOGJrUkw4?=
 =?utf-8?B?YVptajJ2bnduNGFaT1JEZHFjOGlDZm1xWDJpMlhzdUIrOURiZzhEQTVNbVJV?=
 =?utf-8?B?WTQ0d1JFNGYvRmVqQmtJU21Bb2RZekpEOVhZdFJINmN2b096RGt0L0lUTzRy?=
 =?utf-8?B?ZTQ1bS8zZEhNOVUzMFp4ekVKY25JYTBYMStrS0FsSW5ma1IwOWNHK0hEV1pq?=
 =?utf-8?B?bFU1SUtaUnJ3KzF1T2JQR2lVM2pmeG1FYXREenFrbEE2Vy8ySXRnNHl5M3VP?=
 =?utf-8?B?NXVZd3ZIczBtdjBZd0JGM05EblRibHczb1ZDY2hYRmltaVNya29INkZZRUgw?=
 =?utf-8?B?UVgrK29XbVUvN25BczZJcEJMRXE2R2pINjNteG8vT0IvejY2QWRZQWdteS9L?=
 =?utf-8?B?TmNrYU5YRGV1c254TjZaMUZRNUFkY1FZUlA5ckFQWVEzd0F5bndldlRlbk9T?=
 =?utf-8?B?NTA1NGN3TlNTc3Q5TUh2WXhmZFpyS0JHZTVVQ3RGbHlVbkRQR0tUVGgzVmZB?=
 =?utf-8?B?bzBXeW1QeGJOaEJ0Qjk2S1hsOXhiUFh6bUF3K01WbzFid3NoL1dqMVZVeWpn?=
 =?utf-8?B?YzFWL1ZxeWhpMWJ3c3FOYnNsbDFXWlBmOGV2ZjB2WmR5UnZ2ejNUem1jY2FX?=
 =?utf-8?B?SmozNEJQTmNQcGdQS29pbWpBOWNaa0lVR0hpR3F5c0lQdlIzT21WSFZwTmht?=
 =?utf-8?B?KzBqRDFZU2l3NUVEUmc3c1hQMGx4UlErRzFTamN5dkNyQ2ZPcVpSR0xwWEVD?=
 =?utf-8?B?SnNuSkc4Vjg4dHJSdzhJenFUU3Mwb0NJaXJORXNwdGZZR1lYYXpIbDdRcUtx?=
 =?utf-8?B?SkZFZUQ3V2J2ZG9VaWQ3N1RONUNhTU9vQXZFUkdiM2lhd0JDUVhTYXpkbVE4?=
 =?utf-8?B?cHZ0WlVpTXVwb0FtUXIxZmlMY1EwRDljMjFtYXNJbVZwTDdCQkR3TDA0U2Rk?=
 =?utf-8?B?L3pLVTNkRGp3NWJHVEdOVTFKbHNFVlNXbnpHb2xJTkN4cm5oUlRyYjZsa2xq?=
 =?utf-8?B?WDVHZEhhbXMrc3V4TjFMVkd5cEpHS0hUSzI0Q2lHdGkwTzRnTHJXMTJtYi83?=
 =?utf-8?B?NHJNdkU0eVNmL1lIYnpEWDI0RXNpaVNvdEIvM09IYzFaU2x2dGhZeDhYSzJ0?=
 =?utf-8?B?K05XV3pOenRML2EvRU9VSHpRNXRTOVEyV1p3eHhJU3hoZk5lQlRZdGlkWnB5?=
 =?utf-8?B?SWN1ZXMxNmxOWGVOMHJRM0x3VW15U1JIeDE4cThrWi9sbk9JNVZyVWhLZjBI?=
 =?utf-8?B?NFFyWGhuVFNYTTFweHdBQjNqaGs5QmErMDVtR2pDZ2dSaTh6ZzJsRUZPOFVJ?=
 =?utf-8?B?RE1Yc1NsMkNDcG5RWHc3WVMva3RVRVFGbFJrRk5ubmJySUYxK29WMldzTEE1?=
 =?utf-8?B?ako5YlZ5NVZ5R09Ua0RUUTB0OUh5RVMrWC9RZHYxcFo1dVhCYjROTWVNbXZR?=
 =?utf-8?B?NCs3UWpJN0l4NFMxZDkvTEV6UzRibUJLdnBhd1dSeFM0SjVYK0duU0d6U0Ey?=
 =?utf-8?B?cHBKU3B1SlJLREx1L1k3V2dzNzhad2FGTG5SWmtoanBTbnprVWZ3UlBCY2dn?=
 =?utf-8?B?Yi9wNTZLS296TllaRFVMQTYxZ2tNRUd6cFg4OGM0bWNGU01XMXF4cnRublI1?=
 =?utf-8?B?cWJPV1ZvdENXcXRmS2s3SUQ2bUNHU2hkYXJwMFNSbm9NUTJsRWZZTVB1MTBt?=
 =?utf-8?B?RmZyNk1Edi9FMEo4b0J4S2toOVk2K2dKb21QVlpDTXQvbUZXak1iN3ZuMnRG?=
 =?utf-8?B?ek4wdWpHOVpDZVFZYUdCV2tnZWFGbXoya2pWNXFMTHBvY3hSdUdRTG1aOFNu?=
 =?utf-8?B?cHRiNEV5OHQ5NWk1NmxIMCtETThiWG80dzFMcTJpNkJVbDhkZ3psUnp2cEF2?=
 =?utf-8?B?WmovcGt1eHNDZjBKaVRRaEo2L0V5ZkVmV2czMWY4bkhrcVF1RnBmcTFhemov?=
 =?utf-8?B?NjRCNUFFWHR1NGVWRjQ0QjVQekpxajltWWJwb2ovYm40SUVxVll6TWlNUjBU?=
 =?utf-8?Q?vUVWw7sLqnC7Dt4eDA98Da6jw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda739f2-5b16-49bd-d8ff-08dc7e7f9a60
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 19:02:49.6656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5NKQRKTIz5C+BbfdOiUV66TYWFRiQY+ora8UiG+hbXTwf/symf24jOHGnKXW8qZsb5o7flDJDNaZ2NjM/fcVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9004
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

On 2024-05-24 10:08, Alex Deucher wrote:
> With commit 89773b85599a
> ("drm/amdkfd: Let VRAM allocations go to GTT domain on small APUs")
> big and small APU "VRAM" handling in KFD was unified.  Since AMD_IS_APU
> is set for both big and small APUs, we can simplify the checks in
> the code.
>
> v2: clean up a few more places (Lang)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

This is a lot cleaner, thanks. I was looking for something like this 
when I reviewed the original patch but missed it. I found it now in 
amdgpu_discovery_set_ip_blocks (I think).

Acked-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 ++++++++--------
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c         |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  6 ++----
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h             |  1 -
>   4 files changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 336eb51c4839..3af00b57cd8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -196,7 +196,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   			return -EINVAL;
>   
>   		vram_size = KFD_XCP_MEMORY_SIZE(adev, xcp_id);
> -		if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
> +		if (adev->flags & AMD_IS_APU) {
>   			system_mem_needed = size;
>   			ttm_mem_needed = size;
>   		}
> @@ -233,7 +233,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	if (adev && xcp_id >= 0) {
>   		adev->kfd.vram_used[xcp_id] += vram_needed;
>   		adev->kfd.vram_used_aligned[xcp_id] +=
> -				(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) ?
> +				(adev->flags & AMD_IS_APU) ?
>   				vram_needed :
>   				ALIGN(vram_needed, VRAM_AVAILABLITY_ALIGN);
>   	}
> @@ -261,7 +261,7 @@ void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>   
>   		if (adev) {
>   			adev->kfd.vram_used[xcp_id] -= size;
> -			if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
> +			if (adev->flags & AMD_IS_APU) {
>   				adev->kfd.vram_used_aligned[xcp_id] -= size;
>   				kfd_mem_limit.system_mem_used -= size;
>   				kfd_mem_limit.ttm_mem_used -= size;
> @@ -894,7 +894,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   	 * if peer device has large BAR. In contrast, access over xGMI is
>   	 * allowed for both small and large BAR configurations of peer device
>   	 */
> -	if ((adev != bo_adev && !(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU)) &&
> +	if ((adev != bo_adev && !(adev->flags & AMD_IS_APU)) &&
>   	    ((mem->domain == AMDGPU_GEM_DOMAIN_VRAM) ||
>   	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
>   	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
> @@ -1682,7 +1682,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
>   		- atomic64_read(&adev->vram_pin_size)
>   		- reserved_for_pt;
>   
> -	if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
> +	if (adev->flags & AMD_IS_APU) {
>   		system_mem_available = no_system_mem_limit ?
>   					kfd_mem_limit.max_system_mem_limit :
>   					kfd_mem_limit.max_system_mem_limit -
> @@ -1730,7 +1730,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>   		domain = alloc_domain = AMDGPU_GEM_DOMAIN_VRAM;
>   
> -		if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
> +		if (adev->flags & AMD_IS_APU) {
>   			domain = AMDGPU_GEM_DOMAIN_GTT;
>   			alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
>   			alloc_flags = 0;
> @@ -1981,7 +1981,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   	if (size) {
>   		if (!is_imported &&
>   		   (mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM ||
> -		   ((adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) &&
> +		   ((adev->flags & AMD_IS_APU) &&
>   		    mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_GTT)))
>   			*size = bo_size;
>   		else
> @@ -2404,7 +2404,7 @@ static int import_obj_create(struct amdgpu_device *adev,
>   	(*mem)->bo = bo;
>   	(*mem)->va = va;
>   	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) &&
> -			 !(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) ?
> +			 !(adev->flags & AMD_IS_APU) ?
>   			 AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
>   
>   	(*mem)->mapped_to_gpu_memory = 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 4816fcb9803a..8ee3d07ffbdf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -1023,7 +1023,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 1))
>   		return -EINVAL;
>   
> -	if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU)
> +	if (adev->flags & AMD_IS_APU)
>   		return 0;
>   
>   	pgmap = &kfddev->pgmap;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 28c2c1b66226..407636a68814 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2634,8 +2634,7 @@ svm_range_best_restore_location(struct svm_range *prange,
>   		return -1;
>   	}
>   
> -	if (node->adev->gmc.is_app_apu ||
> -	    node->adev->flags & AMD_IS_APU)
> +	if (node->adev->flags & AMD_IS_APU)
>   		return 0;
>   
>   	if (prange->preferred_loc == gpuid ||
> @@ -3353,8 +3352,7 @@ svm_range_best_prefetch_location(struct svm_range *prange)
>   		goto out;
>   	}
>   
> -	if (bo_node->adev->gmc.is_app_apu ||
> -	    bo_node->adev->flags & AMD_IS_APU) {
> +	if (bo_node->adev->flags & AMD_IS_APU) {
>   		best_loc = 0;
>   		goto out;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 9c37bd0567ef..70c1776611c4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -201,7 +201,6 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
>    * is initialized to not 0 when page migration register device memory.
>    */
>   #define KFD_IS_SVM_API_SUPPORTED(adev) ((adev)->kfd.pgmap.type != 0 ||\
> -					(adev)->gmc.is_app_apu ||\
>   					((adev)->flags & AMD_IS_APU))
>   
>   void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
