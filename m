Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE13EC6FA82
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 17:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 279A110E117;
	Thu, 22 Sep 2022 17:19:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78A6A10E117
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 17:18:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNcQNINASSVDRUPv1pS5HHMFSDWXelPCXYNDxd2kicyB1+3JKY83ZDvbvNXph5/tK8pYTRWugFSDJ2UdnyDcTnkx+lnTHZo8qwwa5Ka2l2bIjOH0lbvEg6ipmUokjOyEiK3MMYqVmWz8N/LxLDHH6GJO9kijTQyLlIAFXE7red2kMiCmZVmDoZomukTlKKHiJmNrjv73wsWhYA3J+fNJcmXwZHwZShdFgEOYaHMJJv+537Rji6itU6UFV8o8X+zjPcOPcGFfgrUbKKxAw6fefKXOZjg4Y5ufCLQXasy3ZvnkorZDQFc32HrcY+zZH42WY8uDfvoUerrCzGbNdlcGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QP6/KabKHprPGI8kJcng9Dxtgi5uC02vcULt3HDahNA=;
 b=Q4lXz6pPzVH5P/iGCVHX58svcDcjTDs/N+FIaSptFSlgmLJAOwGZXNjcNfQbFcTEuT4l6A1NfNZYOPIy3S1qRxLJHAycrT0NZo56/8BfZ0u5joS5BJnhJ/m98f7hU88QDZ58bGlRXiNB7JcNMZBpkM5rMv+wNXJn7ZOE4DgWpZf+PPeKs04wfjWy7IfMWkTySy+C5rssT/IQdlLEL73JfGVpKeknHVkuN1tlEvQM1GEa2q+S0AzF3jkGVvZhrMH9GAvc1rMuyaw1cXWLDub4k2n4hKfLvLXtfe2udFfWihNQyGqC2XOst4i/9WpE+wjSh1BHbtKPJHAPB8qUbhTE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP6/KabKHprPGI8kJcng9Dxtgi5uC02vcULt3HDahNA=;
 b=Bgb1yrokBbtankxQ0PNDDseB+IiZV622oTD7b2Sz9zchdThKeJCLKwoOgYPoMRNVnTRQpviCHe+rDAv+Qz+RbzF2mwXvYGryyX6MiEO1DBWscJtIFlmcWu2/6pWNlib0zz4xj9/SzWpGKlz3Mwk+K+5VBIYY+THRTdgKshE781g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH0PR12MB5219.namprd12.prod.outlook.com (2603:10b6:610:d2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 17:18:56 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 17:18:56 +0000
Message-ID: <aed3002c-96a2-f826-3963-97b3eef1ccef@amd.com>
Date: Thu, 22 Sep 2022 13:18:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: fix MQD init for GFX11 in init_mqd
Content-Language: en-US
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220921184700.617748-1-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220921184700.617748-1-Graham.Sider@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH0PR12MB5219:EE_
X-MS-Office365-Filtering-Correlation-Id: 92252281-b380-4dc9-80f6-08da9cbe8791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpHx5xo4z7NEtXjU/gOHUwE1SSs9atM85AqHxr6f3NZrZkPGmYbJpA9XYIou/0iWUygPRplcE/j4jfiKoO4n7z/gFzTgpBDqdGmD6MyASIVBVGYiWDf0Lr6ExmvqsP4BJMOcIxCU0Ire9gw4fEBOfNBqw0ZBsrpRYm27ge7Ts+rRalrSlT5FPwZ3we+R7AZ19HYX4nYPxeV+LolxIyiORtR1NpRh9gCioxXmrO6Lp4Tnkn50rRg6pp+CtFM9m9WcFZaSwQWz4oXwKoUDmuncN3TWmf5Qp4cwIm96SBjMSFObD/J/VgHnelI1xcVo/BRJ3Ybv7Hb7DIeA2Vo2DWOKKbCVXwOJLgTvyQHcAlcLhjl4Cqji0q3L1NBLc+1G8JR1AjSxa156Wvq5iF0uLJGGzltGNbVjQdoHwzCi1d13o3IHy/nOA9+6FFpZLCYODRVFTs7n4Hfk01fFDMlYlXIFQr13xMhQEXhXV+t5hYw1wPJucaoFBB0GUSuvVMZNVvOl/54iqLKuNsRerpz5nWZd782LGhPsWxYX1x4j3rRjo32fr8qGE/EM1qWg7inZ1RJVnnSbCt/AqJegAMkNpGd7d0jFZ5ZJxoCYaP03wUpLhQ0fHpx+yf8TzepyGf78aKb5JIM5Jcs0FFgEwxxrh8nsxlYnSRBPZzHEZgDoa+G+seXIsYo0yjxGIsclvpGeDMHnqi5RCqWrccuuiDmBjG0BPt/s4p8ivVHu3sH7IdwAxJC1n/EvMjcpfadiuPeNr4bV150w3qyrnFxBLgkdgTPD95ze6xOk9bw1ahAS8NzXAMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199015)(36756003)(66946007)(66556008)(2906002)(66476007)(44832011)(5660300002)(31696002)(86362001)(38100700002)(8936002)(478600001)(6486002)(31686004)(2616005)(186003)(8676002)(41300700001)(26005)(6512007)(316002)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzdUT1FyWFk5NC9rQnJkVzUvMTZlc2R4eGZkRnlqa2pLckUyWGxIZWRiUE9C?=
 =?utf-8?B?V0RnTVJVbUdLbWJUUit4NlFHRitFc2VKTzR2MUVNbXI2SmMvVUMwcDFKWHZL?=
 =?utf-8?B?RmdlYjgxTTJoVVRyczBxS3FGNDdabmYyQUJhMFhlRkwxSngrVFB3WGxLd3RD?=
 =?utf-8?B?TWR1WTBzZDhoNW5OMTRQSTZRZTAwUkd3R3hZM1FuWWhMcDBiSzRyN3JnUVI2?=
 =?utf-8?B?N1Q0bkYzQjZMTzdrcW4vQ0RFNVptRkZxTzFGRXFOYUxEeC9ZMTFCamgzVTYw?=
 =?utf-8?B?ekdTVmJRTDM0K0tQajFFazdrbnJmQ1c2VFF1R3JjMkoydG9TQkJnV1FzbEpt?=
 =?utf-8?B?amNHcytqUVpJT3EwYjdUc2NLVnhRdVdMallkRFFLb092cmR3TFh4RWwvYjR3?=
 =?utf-8?B?dU9pS05ZQkxKdG1MODFnOHhIWUh0Vm4vUDNxUzlzQ2V0SmNLU3MzZ1FmOWxF?=
 =?utf-8?B?VlpMMzNFbjJmTXZEMUdKTlYzUzVPV0pMR1ZLTy9WeGZJUFFUclFUZWFLcjhl?=
 =?utf-8?B?b0g5WnRnRGVSYlhMUCtWdXhOWUhlOWJERk5rUmN5aHBRbzB6NlJQOUk1Wk05?=
 =?utf-8?B?UDNuTFBvL2wwSmVzMWd5YnNqZ3pBVm9obTFLV3I4Y3VTYmkwdG5MZ0VnSDMw?=
 =?utf-8?B?U1E5ajJqVFNXY2pWWnUzSFNQQnBSQ0lOQWUzbFBIQkRpNUI1K2tDQ0h0eSt1?=
 =?utf-8?B?ajFXTGovM3VkcnA3ZTg0SVFqeU1Kd3pLam9ZbDJYR21NdDNsdnUzeGQwSFpS?=
 =?utf-8?B?dkd2T0EvVXlnandsOThENDE0SkNKY0lxME1JU3Y2NFRkdXNYbVZIdmFjTHdZ?=
 =?utf-8?B?V2FwK1lURWJvaHh3cTd4WUtzaktmL1R5WlVQZ3dUSlJMd2ZZR3dvQ3owaWla?=
 =?utf-8?B?TEZZUDN3YzVucnFmbjl3MnFVT0xLQzhyazVYbGlpcDRqQUJHcVprcnR1c1Rp?=
 =?utf-8?B?NmluYTBURUt2Z0J6VlBaWHJVYW54RWsyVEJQaWhkMjVsWno1d29HVHMyQmtL?=
 =?utf-8?B?QU9OUm1URHI1eWExRnN2MU1xT3VaVG1hZ082dThSMnBaSlM4ZzlRR0JhTjFQ?=
 =?utf-8?B?dlpsdG1adldpZVZFWnZMZjNxYXFTN2hRKzd1VlBTMVkwakhzSW82cnpCa2dY?=
 =?utf-8?B?eDNCa1FiaDhId3BkeVdOaEpFbDlmeHl2azVaUGtrdTJRb3hXSCtsQ0Vla1pr?=
 =?utf-8?B?QWFPblZtdGFyTVFiWXFTQ1YrcXFEL1RaVUY4NnI0bzIxVng5aDNXWGVBK0xF?=
 =?utf-8?B?VGpqYXNvMXRNUjFHT052Tk5xM2wzUTJhdjl0djdkMDZjUkVhUWtnRzByb2o5?=
 =?utf-8?B?MXg5V0h3YUlXV1BweGYxbytVSUFEMWZRM05ENDVwa2E5Vy9XSm5hY1dra2JE?=
 =?utf-8?B?akR6Y3lCbGIvOG9ENlVoZ3I4K0F4WWVzUkZYYTEvWm1aVXQ5UHYyQzZWNDdr?=
 =?utf-8?B?ZXFtYnYyZTRscVBmd1cyWllYcHdRTjkyMVhScFlmdFA2aEJVaUFMVkxJaDAx?=
 =?utf-8?B?SmNhUThJUEs4VE1ySTdmc3FobFhRTGpvU3ZFV0pVYlBDaW9ac1VrOG1lVkRy?=
 =?utf-8?B?Z3Fjc2ZHcHZYd1E5MDg2U04yb1VkZytFU0dKYkhSZDJtV0tRaDZ4UEgzNEdJ?=
 =?utf-8?B?YTM3NGgxUkNETmxGWEVsTkFRMmhYQU5PWW1SblZ2eTR5dUdFRHQ1VEpqZExa?=
 =?utf-8?B?bUVYVGpTbDFENGt5U3RUV2psZ0V3c0x1VGZWUkFxdUpNVXhuNDhKQnc1U1lL?=
 =?utf-8?B?WkRrVW82Qy9OR1JnekU1WVo1a1FqMjNLajltMFowbHllT1g5eUhKQU9aanRE?=
 =?utf-8?B?VnF5MlJMWG9mbTZIRWJWTDVrSS9IdzF2ckR3RGtrUGcrTm43ci93bFo5WGhv?=
 =?utf-8?B?M0xqTlljczJFOGdtT0taNnQyWkdLK2RkaitUWjFTQnJuUm1FbTVCUjlvQ2t5?=
 =?utf-8?B?YUd6SXYrdjdrd1E2VnA5NDE1UUcxR04zVTVvNXlacTlVdnVWa2xTSzZOV0VT?=
 =?utf-8?B?bjNQOWpEdnBZUnp4dWtDN2phRG1RL2h3N3NEZVIrb3E5MXpYeCtrbzRkVFVP?=
 =?utf-8?B?L2ZONUxVYUVYY0kwSkw1UXNuRWhBR3Q1V2p3dXY3dm8rMU9jemE0dWhDVWhD?=
 =?utf-8?Q?n2shfgqWkurJe6o2ojDw8EH7y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92252281-b380-4dc9-80f6-08da9cbe8791
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:18:55.9776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IN1wy2BaoeZszaXfHY/OvK9148XjeqJfMu27ddVTmSNc6BQ6o3jeHRrw5nGxJaPPBiYhlC13kAOvP1BBusx/Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5219
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

Am 2022-09-21 um 14:47 schrieb Graham Sider:
> Set remaining compute_static_thread_mgmt_se* accordingly.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index d982c154537e..26b53b6d673e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -126,6 +126,10 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>   	m->compute_static_thread_mgmt_se1 = 0xFFFFFFFF;
>   	m->compute_static_thread_mgmt_se2 = 0xFFFFFFFF;
>   	m->compute_static_thread_mgmt_se3 = 0xFFFFFFFF;
> +	m->compute_static_thread_mgmt_se4 = 0xFFFFFFFF;
> +	m->compute_static_thread_mgmt_se5 = 0xFFFFFFFF;
> +	m->compute_static_thread_mgmt_se6 = 0xFFFFFFFF;
> +	m->compute_static_thread_mgmt_se7 = 0xFFFFFFFF;
>   
>   	m->cp_hqd_persistent_state = CP_HQD_PERSISTENT_STATE__PRELOAD_REQ_MASK |
>   			0x55 << CP_HQD_PERSISTENT_STATE__PRELOAD_SIZE__SHIFT;
