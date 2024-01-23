Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7115FC47DDB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 16:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B51D710E068;
	Tue, 23 Jan 2024 16:05:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8973110E4EF
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 16:05:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbAv4xVGhjv818ulbstuJTcbDsZKCKKMVJf9go2w/R8OrYJFvHp6yGA8YuykTJVXbpergspGYoF3fH0AmcVrOyoWI9hrjrAl46xfbqGINjW4lsGS85AY6kHWbAC+SosMRRfvT28x7tsZkl9DbQpLlONP3uZPUeWf7Fk61S3PgidRObXk8bCNiFilUVtgMm8C6dVd//fIifEyoACL30MreBIDYa3QvtK9yvdXGGBf1J4Tw7g2xNAfEJhpNZ8l/8+dmW3RMLHXf/KX67Ua1uh+bI8EZb+PqOGE6maXfLQgQnaUjovYlfsg5o+64opLI4ItrGhxThR716eG3RsWmv6SKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIvitleD4olZcIBM4rxWu45VCfuCQLZtPGcgJzMYtwU=;
 b=HKQWa2COmYG+FzryO6045vw7T5UDUXEKVTCpbwmeRQQU8CJLBM769x0c8YxhGHxluF51lJ6UwoSVqRaqTIRoACat3pPB9QSLEkiDKZp3AEJ8Ar4IDBq07mFcKii4bDrEsXN0W3TmwNVp06NMusl7W4unEVkz0XZGTwXdnUHN9yswrh9G9/pPWYFndveWx3o4IifHBGi4x7a+/n0rq8WQntkdT9uRCm0W5i1EpxIN4+0BTBWb8iEUXzsSeWcpReNtK+8sYZc4sHqlG3hZ5WgEX1grXWhUAANiSnAc315f5y+fye4GcYy5aStpamQezBVsHQABGius01fhTdzXtr2s7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIvitleD4olZcIBM4rxWu45VCfuCQLZtPGcgJzMYtwU=;
 b=X036wW9MM0Dxyd29g5UnkI8I7OdGXZcpIzW0M6cb12lumAp3PGbw2TEbq1KFutRpBFKcuZfx/O6mWKBUn5jv0laVC3FnxAE0GFblSyT1iqB6du1P78AtpTa35+gzZEZsAQnnhSdyDCMwCOx7MviKEaTR235sR6EJqSb/N7ahlVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 16:05:31 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3f6b:792d:4233:f994]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3f6b:792d:4233:f994%6]) with mapi id 15.20.7228.022; Tue, 23 Jan 2024
 16:05:24 +0000
Message-ID: <bf82e605-a513-4ed9-aa35-e7b743d0a6da@amd.com>
Date: Tue, 23 Jan 2024 11:05:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix a potential buffer overflow in
 'dp_dsc_clock_en_read()'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20240123150129.496102-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240123150129.496102-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0205.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::27) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: d35a7d64-997c-4369-ee84-08dc1c2d1be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fR0eAbz/WjDk/GMwC32jpFj2tOxSkGwlbpRWv1zwN2ERvk1eyxUKgP9oWV0DAzHJyyWwzdsflXRCsEuquGb95/uoXnAcVpEoo3ZHXcMxf14fMaUm0Mw2Z/j2N05mMdfORbcOTwQ7SAZz2cZ0X6upozCc1eGNrpKWSqXS14b0uAXfLqCD7lgLXApO8zZxUyDXavlEvX8SCH2/AYAsQ8wvdAV+/vUoLjLP9za1jpbh2Smj7F/UPTQp68U8iDJH5N3Qq36JzhXPAj/abrcr1BD5Y1pXSlZT/G5D78kr6T835/s1fiY1bE1WbH798zMZ+u3TsFIqsmNdG8MUpSWRDgRT+VNftGL2hQPh5BWiC2I6bDZqfCSWbINSlSbxE/hGZ9JJbFdM+nw/vE13PISst1vF4nGzA5+t2qRbzhl2zXm3zDFLYswHvZanrTAp8pXD6c7VJK0SP0dTwM9LRG2gBMTMKTUFpFBrPfKNf1mnz2EgeQMH5/ETPtbB9yR2oP4t7of4ZsRFZEs6sa5H3YVAiB3pPcCDMwSwL8DUCXjrJ7yT3YQ5yWs2rPvUffg/Hzz1XS8zRdI6bi3TJ7ZB4oMDFu+BkBruZcmphB4KQwWyBZ8uLJ4Ne+xYyiIcuqQhhkWHLZZLgl6lc/tK+xo3uH4Zmw+n9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(38100700002)(83380400001)(36756003)(31696002)(86362001)(26005)(54906003)(110136005)(6636002)(66556008)(316002)(2906002)(5660300002)(4326008)(66946007)(44832011)(8936002)(8676002)(2616005)(66476007)(6486002)(478600001)(6506007)(53546011)(6666004)(6512007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzhUY1o2QU9uVlQyOVZtM2FYNU5kczNoQmY3MnRya3EzSCt3dE5qS2ZTWm1o?=
 =?utf-8?B?WnVwM29hNEU3d0xaSW1sRkRlNmhpNWVtZ2t6eHpDWnIvZ205Q1h6ZmtwRStL?=
 =?utf-8?B?SllmVjFsb2ZpQ0RLTXRMWXpoRXVwUWFMSHdaNGJQRHNZZmpnQmc2eHdqd2lQ?=
 =?utf-8?B?TU55YWtXNmNSVG5JcXZHQUQxL3JFRWNCb2VLVjNDZVdOTUpnWVNEL2d3bjJj?=
 =?utf-8?B?cDJMU2lyaStkSHVGRGNiNFVGQmE0QTVnckIyNFdtenRKZWtDVGplYWsza2V4?=
 =?utf-8?B?K2lsM3pFdE80NVUydTJ5RHZvNDNZVm04THJIYVZmRUtXeXZDYkJkb2tEakRs?=
 =?utf-8?B?SEc3VlpGaW9PQU9aK1pGNGkrR3hMM3Y4K3dtZnUxYVB6RDI2cWZabm5PK0xQ?=
 =?utf-8?B?dGQ2MDU4TVg5Z3hNbllBMXJyRlc0Z2ZKbFJ4L3o0TktGWStGdzM3ZVlsMEts?=
 =?utf-8?B?QjVmVjFObUpLTzJ2MmEzcDgrOUFNczE5SlFhMGUrTVF4Uy90VFU5eXp3L2Mx?=
 =?utf-8?B?RWMwTEJVMFBDcW1nVHdJR1FpV2VKV0d4dGU1NFBvVnRNc1U4TkFyWlhaMlRu?=
 =?utf-8?B?QnBReTZwWlFiWGtJRGR5Y2VheW55WmE2cHd5ZmxtNzduT0lka3hVVk1NMkJY?=
 =?utf-8?B?bzdIdEVDb21FMGcvaW9PdGNXeEh3MHN1dVVKU2dBZkZXUzFRMjE5L2Q0dTBH?=
 =?utf-8?B?U0JUUGdnTFFnU1ZZTU1iM1dPU21TNklCYjQvRGxiNG05aXFuYVIyeDF0QWZK?=
 =?utf-8?B?bjhMbTRFM21lNm1xYkpvU0ZuMEw3N0prMWJQWkpiZXdaRkZBRFlXVjBjNDVF?=
 =?utf-8?B?Nzl6WUpiUjhJMmJkdDgxWWkyclNmVTZkUXUyOHhQUEkvMHFoc3ZZY0lTWXln?=
 =?utf-8?B?QzdRWlh4aWJqdExRWVZHZ2pZcGFvdGtBNlJqOEIzcFRVdXhpNy9UenFoeHB4?=
 =?utf-8?B?aG5mM1kyMmwrbklrdzlSRk9CcXJ1YW5KZ2xLSU9IU0pWVWV6dm9iQ296T0Jw?=
 =?utf-8?B?WVVuTExJVDlJLzFOUGNRUUdVbmU2SFBVTXV5YlRnTngveVl1TnVQNEllZlQ3?=
 =?utf-8?B?Ri9ZdHBELzVLL3lPSEhGVUxWV2xEY1V2Q1FLVzlGdWZFRWp0S0o3SmZjaVRD?=
 =?utf-8?B?Ujk3dGpxVlhyUEM4WDZxM05MWmd5YWc2cHpHbVJQWjNtbFZlc2VRY3dHUzN1?=
 =?utf-8?B?eG9kUTd1Y3JIRzl4VXlWUzc4WEZjLzl2cUczTHRJbEJHZktQdG5TeDEyV2xm?=
 =?utf-8?B?TW53SlpNUjVXT0V5ZUIzdWpWQzNPanRBTXdKYWtEQitKczRSWGZRVy9QY3Jo?=
 =?utf-8?B?cTlvTGJRdEpIam1oclJnNDUydFlsMmdTS0tZQjRGNEwwNm9XZVFLclFYdXJL?=
 =?utf-8?B?NFgyQ0NkQWFOeUR3dnZzNlV5S2o2N2hoNTJWc1NBMGY1TVk3d2J4UnlhaUtD?=
 =?utf-8?B?ZlBHYThzS0IrNndrUVFQN1FnYVM0WEtadjVpcFMxRHRzQ1ZaR09CRzRGeGtt?=
 =?utf-8?B?d2NVN1NIWVZmdmVwZ1cxck81NlYyS2JRRnM4T1pUNDcxdGs3TkZuamFSOEtu?=
 =?utf-8?B?QWFTYWVVd2dxczI0VldjTEdHZ3MrNENQQUVlb2treldtRzNWS0JwQWl1eUJ2?=
 =?utf-8?B?c3BsT1Y0OHVOWlRKY21EY2RNcjdzNitXNTRuSEhhRzVodjRmbi9OTk01Y2Jq?=
 =?utf-8?B?SG9nOWk4ZUFBNzRzbnQzakZ1ZHl4TmNHK0RPSVU0NXRIbk1xa3QwL0I0LzFZ?=
 =?utf-8?B?WjdLTkdKZE9ySnpmV2JERVd1S0RTWU9sNkNzWkI4SSs4YTljTkF2YlMzdUZQ?=
 =?utf-8?B?VmRML0NzVDlsZWFMQjJkUFFOTDd4QUdUcDNQNEZMMS9UelVOZkg2VFRFd05X?=
 =?utf-8?B?cjhMRjk4ZHNlSGNwL2JKSS9lOVNzLy9hU0VCT2RlY3lKdzdMam50RGllVkFN?=
 =?utf-8?B?RXQzOU9XTlNna05pVVovS29vWjVGYnY0YlNGUjNyZTdXSUtBbnUvY1JvUEpM?=
 =?utf-8?B?bUJqalcwekVXRlovNWVRYmIxTzBFSlY0TDU3NzNzVVRzVHJEVVUxenRRZ0pt?=
 =?utf-8?B?UHc5bFM0Y2ZyaUpybXpIZC9McTVKd3ZYaUZKSzQ3WUlLbHlBekc5RFQwdjJy?=
 =?utf-8?Q?VIE4KiyIKlHaPe91Z7hH8E7Ki?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35a7d64-997c-4369-ee84-08dc1c2d1be1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 16:05:24.8609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTLfrosffWCfS70367aEG1qLv9S8mq/xKknPgUqH24FgV5X0/G4DcTmBiPuOcxfvjDBmC0SqcrBApc0Mnl8ctw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385
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
Cc: Alex Hung <alex.hung@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2024-01-23 10:01, Srinivasan Shanmugam wrote:
> Tell snprintf() to store at most 10 bytes in the output buffer
> instead of 30.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1508 dp_dsc_clock_en_read() error: snprintf() is printing too much 30 vs 10
> 
> Fixes: c06e09b76639 ("drm/amd/display: Add DSC parameters logging to debugfs")
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 68a846323912..85fc6181303b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -1483,7 +1483,7 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
>  	const uint32_t rd_buf_size = 10;
>  	struct pipe_ctx *pipe_ctx;
>  	ssize_t result = 0;
> -	int i, r, str_len = 30;
> +	int i, r, str_len = 10;
>  
>  	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
>  

