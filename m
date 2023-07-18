Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E598EB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 21:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A753510E0A7;
	Tue, 18 Jul 2023 21:17:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9027910E0A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 21:17:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fms8XGA9ioLyzfu/WZuFSCJ+gf0ARzNAl0vx5N8uVRN90kofBg7pDZHGyg71a/gvbkVJ1MND/YB0Kw+6BVTy9X9l9IWB4KNYlcHb7BReyX14F3cy7OMfyO1HJeSDlT5QEsW+1nhbiJF78jN8+lWKkzXWpKyaYLHjOY0+OE2sp8Yt5Tebv7tydHufWNOKcRRu2bD3176AcXNwGfwZqn/vPd3xs0zUjA5TqXps/2UOFv5Nvx76ySI9b5gtykh5vpVPZisYIREF1Ax65x7WfRkca4jjBRgKSzN5v19RLmD9t3c/K2N5u8Yy26UeEG3UiLJs+5YbEVe5D+fQuIbasdLQ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKimjEGypffxPsj+Q3g3Z0hq4u6zJydnErqjONzOskA=;
 b=LE6lSTMiMCtWfUT1UWqwEvFoPTo1UbyHN+rYSQI1FOmCUMkjnAA7zoWRd4phJ5dS2sOyCg4vP9j5zF4VPaV4UjPZqYMEPglYO8RJ80j36Hznx2VJ36AdHH+YS6VpoiNkiCdG8mmI+bLNvKKoXFMgkulS3lv7V7VCaR1ZMrttobwXxToau/UGTHiOObkOOBpQQcLLZCDVTFWNPCCn5TdoZkKJsMkeMQYlG2C4Jasc2NQP5SqaBRzDeeX5qnKw/y2aXTlZ2fFHFyxH0jDiXP2+Y+yPU3iqThUMirPk1nzyb77s5VzTKgByFgq/o0ShjMMbiiq3AbEIxqhLTWpIFMnDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKimjEGypffxPsj+Q3g3Z0hq4u6zJydnErqjONzOskA=;
 b=Ovu+O5SnFTSi80s32uxrJxdhvinXyAY66vuFwJDHNr8u3GxRz9+DXgvdyFsVxmrii4KGcTyXq3aiP6MVd06qmTW8QHze8EU/BlctUpZUu681MMnQ2HnQ2kbWQQdr/ePiOKLymvbc8pX6usWuWDO83eNo7bkmxapoHRAtNNPwfv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 21:16:54 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 21:16:54 +0000
Message-ID: <a532afc8-1526-e580-24c8-2781dfb1820b@amd.com>
Date: Tue, 18 Jul 2023 17:16:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] drm/amdkfd: enable cooperative groups for gfx11
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230714093759.3246343-1-jonathan.kim@amd.com>
 <20230714093759.3246343-2-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230714093759.3246343-2-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0157.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: bda7a353-6165-45bf-abff-08db87d44f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1FAlUmAZ3O/EVdHtexNaplqh374UswS2/J0ExhXaMBr83sjmLjaTlpOkY5xx1h2kRRv8GEflMXmv9pAy2LEnKFgI8PGN556yuTymSDI+5OsvfwFVZoewhe5tHQtdU2vRaegV+KEEe6FTk4ZiQEWK61KPpAd7jmDb0DYzdQljMsKm49DnHY03did2pAtfbAyn8YyQza83nra0kzxcozxBD9t9OxwPprf3KSPDU6oq9hPmG8wVCZ4d7iAjnY/1YtEE7KmhyspJfS3YGvJgU/RUskAUHl84pccc3i3gG9dSGlqgSAvRFKWZUR3f6PPRv8q8l91ugrNiGgzfgosQ4vlWXmys5lwETHQuce9GXwqNgDRRt8vnjxOQ2vusQZ19PL8f1VPPfOikP9TU8BT2BP6F6Ki1H0iTdcgtf4cyyopVuE9JY6WGQ/3KT0zJK9K5nrGMBv12Ml0Av1APKF5bpEC04VOfdqECV0ErURxW8G/2OjDvXM7I53ZYz/ghZKXrCpg/OeVpZo0Ux2UE6gWz2S+DAjgfFKlap9pKwP5K48J7an3ayrDrM9NDn/ga8ngkFE9z+x96CRgBLDbXdO9axeR3LHCYWdXLEGMlT8RbpCdfShqJtt9Dl8bKQtOowbzVV3IM41LtN79DOHPQl5f8Jh53zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199021)(31686004)(83380400001)(478600001)(186003)(86362001)(31696002)(2616005)(6486002)(26005)(6512007)(6506007)(2906002)(66946007)(66476007)(6666004)(38100700002)(36756003)(66556008)(44832011)(41300700001)(8676002)(316002)(5660300002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVp5a2VtNmFuQWt3cHdRRk9MV3k2KzV2VlR4cW9jUmNUVFRsNGlXeTBpVXcr?=
 =?utf-8?B?WU95RHZLWituZDlpZGwyaDZmbDhtQS9rd2F4dzdrZDRObXZpYWJWb0l0UVRG?=
 =?utf-8?B?K0drNWVFcnpsck1kd3VOZGZXdUJhTDB4c1IwdStjZHFyaFRFcFlYVHBWd0NM?=
 =?utf-8?B?QnpTOURYNUp2Y01uWEE0RmlRNHgraXIrTkh4aWZSb01tK3Q2eVU5eVh2eUJ0?=
 =?utf-8?B?NnpxTGtwb0k3Nk1BTnAvbE56eWxZNVh6MnJZNDhGc3BSdlorZ3RSWlhtbjRJ?=
 =?utf-8?B?TE1oRkFPbzhWY3FhalVxR1JNbTQ0ZkNDcVF0SFdackMxTmtTaC9QSm5UZWox?=
 =?utf-8?B?VUJTeW9CV3o3MmN1b3JSRjhoakdsV25SUXZ2RWRLMjNVZ3RKRFZHOXAxeEtG?=
 =?utf-8?B?TVcxbGNITDBWbGlKQmVPQnJ5T1A2VzJGNUFHTGxnbE5nbkxrQXhCS0RQNkVy?=
 =?utf-8?B?N0kxMDZKQ3lCU3pLOFpXdSt6Q3ZJclZpS0FQdUJVcjdIVEdCaC9HZkZWUFpU?=
 =?utf-8?B?OGtYU1hNMjZDTjRqM3Jnak4wTmpYZndPTU1jNEYvYjZIUTVVa1Bib1NZcnNw?=
 =?utf-8?B?SVdqQTZ0b0pReENtWllmWTMyRzM5YVB3VmxXWVdvbFNaU0t2WXNZMHNHd1BQ?=
 =?utf-8?B?OXFRYTJzaXZiRGRDUFI3VDduWnR5Wks0dHA3WXBuR1FnY3dhbS9LNmdZMmky?=
 =?utf-8?B?SDhXNHJ0dXR5d29waHhaWGlmQ3RZSTA4cWZMb0RCb2dHZVY0WklDMkhoWDNo?=
 =?utf-8?B?VE5DS2c0NGFIS3Btbk5YQjV0VldPdFNINEtBSDFiWmh5anVHVXo5QTJpaFFo?=
 =?utf-8?B?bnhHNkk4djVueU5wZ0pnNnZKSkprTGlweWRLa01pOVhuM0ZENWRnK1hNblJJ?=
 =?utf-8?B?bmVMQmdiQTNWUDgxOGRheGpRUm1DbjVlYng3akRZcjJDVkkwTmZRRE1pcEx1?=
 =?utf-8?B?UTlHN1hEOTBCRlozMXFRSmU2czJDVmpXbnhBTjRESlFQUlI0eG9LcVUwOTFt?=
 =?utf-8?B?RFM2SGhTUkJIN0UrRHB3Ymo5eS8wbEM3dDEvdU85ZStXeERXMkx2NHZtZXM5?=
 =?utf-8?B?ZVF2bU1PTmV4Wlh1a2o5Qk1OcGYzdWlXanI4L3FOblNBRUFQNnVwSTB1MFY1?=
 =?utf-8?B?RkJLWTdWTzJJaFlmT1ZEcVBmM0s2THVaL2Vvckw5bWY3U3p0MnVUSkxpQi9E?=
 =?utf-8?B?Y0pHak95ZVVuT0E2bzdPWERVeGNueEcyTGw4amR6RU9BUVNWT2l4VjlWWlc4?=
 =?utf-8?B?T3B5Sisza3d2WkVJdi9XUkM4UjQ1dnZkUEl0SG96alB1WHJRam4yZ1UyMVIw?=
 =?utf-8?B?ODUzUmNSS2pDL0tIS3NPa1ZTUU5pbUE5ZUpibmhpTXlVd3BuY3JIay9Ia25B?=
 =?utf-8?B?eEYrZkdFQTRJRW51dXdtaEdWOHdmL2tFTDBVbTVVb2JsOWk1QUo2VXlrTVpF?=
 =?utf-8?B?QkRsZ0pRVCs2MWtVY0RQWkttcTJqMzQwYlpnVkpabXZQaUpJM004Rk5BcStk?=
 =?utf-8?B?c0RUcmpnRGxlekZxOCtZdG5qU25jbWw2aGFrTS9BOGhNbzZxYVVvVUpYWUM5?=
 =?utf-8?B?ekJxTU9FdmFDTjVXUUhpRzlQSy9oV3hwNW43TU9sb3VCKzhza2RWa1FTVloy?=
 =?utf-8?B?SDlEcytvcGhiaDBWNkFQY1BiZnJCbGhoMlo1NGlsUlBzeEpldDBTcHN5ZGQy?=
 =?utf-8?B?MnBSbGltTk5wU2tZTzJybng0aS9BYUZkanZML01WU2FPOFVQYWRKaml5aGZr?=
 =?utf-8?B?QnhZWW9aYzg5Z09WOFVuRWZ4T0pNVzY1U1FLSEI5cVBreEtoVC9OTEZxSmxG?=
 =?utf-8?B?OXVYN1VNUHEyK0tGWWUzWEZBTThCekRURmNjaVYxSzNCMUZ5NngrVU5OZjNx?=
 =?utf-8?B?b1lFK2tzTUpLVXErbTJTa3lYQmhYZmUwMzEvRnF2a09vcFB4VkJOelMybDBR?=
 =?utf-8?B?eE9xYmNvMTFDZFJRdHFZZG5pQ25yT1hmYnlScUptU1QxL0dDQXZRY05EcUI5?=
 =?utf-8?B?ZVFLc0VJRUNwTURZa3JGYUh1NlhUWm1BNk80Y09idnJKV3ozZ29iandyU2Rx?=
 =?utf-8?B?bnQzTmY0cXE5YnZzck5Va1U0U2pobWFGOUwwZmVpalJOam1ndGU0d2FHUFJM?=
 =?utf-8?Q?Kv319iCjeboKfY/ldo3tzFd91?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda7a353-6165-45bf-abff-08db87d44f86
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 21:16:54.1455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NREEPSENaaBBgzPk9F6a+fAYJBN361uXteFHNwVeLJnRNSxT2dyIo1GncBkBVXq+roEp+GZ3pzc5muyOGWDrgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771
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


Am 2023-07-14 um 05:37 schrieb Jonathan Kim:
> MES can concurrently schedule queues on the device that require
> exclusive device access if marked exclusively_scheduled without the
> requirement of GWS.  Similar to the F32 HWS, MES will manage
> quality of service for these queues.
> Use this for cooperative groups since cooperative groups are device
> occupancy limited.
>
> Since some GFX11 devices can only be debugged with partial CUs, do not
> allow the debugging of cooperative groups on these devices as the CU
> occupancy limit will change on attach.
>
> In addition, zero initialize the MES add queue submission vector for MES
> initialization tests as we do not want these to be cooperative
> dispatches.
>
> NOTE: FIXME MES FW enablement checks are a placeholder at the moment and
> will be updated when the binary revision number is finalized.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Some nit-picks inline. Looks good to me otherwise.


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c               |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h               |  1 +
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                |  2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c              |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c                |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c               |  6 +++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |  9 ++++-----
>   .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c    | 11 +++++++----
>   drivers/gpu/drm/amd/include/mes_v11_api_def.h         |  4 +++-
>   9 files changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index e9091ebfe230..8d13623389d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -638,7 +638,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
>   {
>   	struct amdgpu_mes_queue *queue;
>   	struct amdgpu_mes_gang *gang;
> -	struct mes_add_queue_input queue_input;
> +	struct mes_add_queue_input queue_input = {0};

  Generally, it is preferred to use memset to initialize structures on 
the stack because that also initializes padding.


>   	unsigned long flags;
>   	int r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 2d6ac30b7135..2053954a235c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -224,6 +224,7 @@ struct mes_add_queue_input {
>   	uint32_t	is_kfd_process;
>   	uint32_t	is_aql_queue;
>   	uint32_t	queue_size;
> +	uint32_t	exclusively_scheduled;
>   };
>   
>   struct mes_remove_queue_input {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 1bdaa00c0b46..8e67e965f7ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -214,6 +214,8 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
>   	mes_add_queue_pkt.is_aql_queue = input->is_aql_queue;
>   	mes_add_queue_pkt.gds_size = input->queue_size;
>   
> +	mes_add_queue_pkt.exclusively_scheduled = input->exclusively_scheduled;
> +
>   	return mes_v11_0_submit_pkt_and_poll_completion(mes,
>   			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
>   			offsetof(union MESAPI__ADD_QUEUE, api_status));
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 40ac093b5035..e18401811956 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1487,7 +1487,8 @@ static int kfd_ioctl_alloc_queue_gws(struct file *filep,
>   		goto out_unlock;
>   	}
>   
> -	if (!kfd_dbg_has_gws_support(dev) && p->debug_trap_enabled) {
> +	if (p->debug_trap_enabled && (!kfd_dbg_has_gws_support(dev) ||
> +				       kfd_dbg_has_cwsr_workaround(dev))) {

Indentation looks off. kfd_dbg_has_cwsr_workaround should be indented 
one less space. Otherwise you may be incorrectly implying that the ! 
applies to it.


>   		retval = -EBUSY;
>   		goto out_unlock;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index ccfc81f085ce..895e7f690fd0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -753,7 +753,8 @@ int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
>   		if (!KFD_IS_SOC15(pdd->dev))
>   			return -ENODEV;
>   
> -		if (!kfd_dbg_has_gws_support(pdd->dev) && pdd->qpd.num_gws)
> +		if (pdd->qpd.num_gws && (!kfd_dbg_has_gws_support(pdd->dev) ||
> +					  kfd_dbg_has_cwsr_workaround(pdd->dev)))

Same as above.


>   			return -EBUSY;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 0b3dc754e06b..9f4f75fd2fb2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -508,6 +508,7 @@ static int kfd_gws_init(struct kfd_node *node)
>   {
>   	int ret = 0;
>   	struct kfd_dev *kfd = node->kfd;
> +	uint32_t mes_rev = node->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
>   
>   	if (node->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS)
>   		return 0;
> @@ -524,7 +525,10 @@ static int kfd_gws_init(struct kfd_node *node)
>   		(KFD_GC_VERSION(node) == IP_VERSION(9, 4, 3)) ||
>   		(KFD_GC_VERSION(node) >= IP_VERSION(10, 3, 0)
>   			&& KFD_GC_VERSION(node) < IP_VERSION(11, 0, 0)
> -			&& kfd->mec2_fw_version >= 0x6b))))
> +			&& kfd->mec2_fw_version >= 0x6b) ||
> +		(KFD_GC_VERSION(node) >= IP_VERSION(11, 0, 0)
> +			&& KFD_GC_VERSION(node) < IP_VERSION(12, 0, 0)
> +			&& mes_rev >= 68)))) /* FIXME: Placeholder version */

Can this comment be removed? You should know the correct MES version 
before submitting this patch.


>   		ret = amdgpu_amdkfd_alloc_gws(node->adev,
>   				node->adev->gds.gws_size, &node->gws);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 761963ad6154..7e8bc7328a79 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -237,10 +237,9 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	}
>   	queue_input.queue_type = (uint32_t)queue_type;
>   
> -	if (q->gws) {
> -		queue_input.gws_base = 0;
> -		queue_input.gws_size = qpd->num_gws;
> -	}
> +	queue_input.exclusively_scheduled = q->properties.is_gws;
> +	if (q->properties.is_gws && dqm->gws_queue_count > 1)
> +		pr_warn("Runlist is getting oversubscibed.  Expect reduced ROCm performance.\n");

I'm not sure this message makes sense for MES. There isn't a "runlist" 
in the same sense as with the old HWS. And the scheduling algorithm of 
MES should perform better, so maybe we don't need to warn about poor 
performance.


>   
>   	amdgpu_mes_lock(&adev->mes);
>   	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
> @@ -250,7 +249,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   			q->properties.doorbell_off);
>   		pr_err("MES might be in unrecoverable state, issue a GPU reset\n");
>   		kfd_hws_hang(dqm);
> -}
> +	}
>   
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index ba9d69054119..139c6b58bb7e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -123,7 +123,7 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>   	if (!gws && pdd->qpd.num_gws == 0)
>   		return -EINVAL;
>   
> -	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3)) {
> +	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3) && !dev->kfd->shared_resources.enable_mes) {
>   		if (gws)
>   			ret = amdgpu_amdkfd_add_gws_to_process(pdd->process->kgd_process_info,
>   				gws, &mem);
> @@ -136,7 +136,8 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>   	} else {
>   		/*
>   		 * Intentionally set GWS to a non-NULL value
> -		 * for GFX 9.4.3.
> +		 * for devices that do not require GWS but require the formality
> +		 * of setting GWS for cooperative groups.

Change "devices that do not require GWS" to "devices that do not use GWS 
for global wave synchronization".


>   		 */
>   		pqn->q->gws = gws ? ERR_PTR(-ENOMEM) : NULL;
>   	}
> @@ -173,7 +174,8 @@ void pqm_uninit(struct process_queue_manager *pqm)
>   
>   	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
>   		if (pqn->q && pqn->q->gws &&
> -		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3))
> +		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
> +				!pqn->q->device->kfd->shared_resources.enable_mes)

The indentation looks off here.


>   			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
>   				pqn->q->gws);
>   		kfd_procfs_del_queue(pqn->q);
> @@ -455,7 +457,8 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>   		}
>   
>   		if (pqn->q->gws) {
> -			if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3))
> +			if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
> +					!dev->kfd->shared_resources.enable_mes)

Indentation.

Regards,
   Felix


>   				amdgpu_amdkfd_remove_gws_from_process(
>   						pqm->process->kgd_process_info,
>   						pqn->q->gws);
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> index 0997e999416a..b1db2b190187 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -275,7 +275,9 @@ union MESAPI__ADD_QUEUE {
>   			uint32_t trap_en		: 1;
>   			uint32_t is_aql_queue		: 1;
>   			uint32_t skip_process_ctx_clear : 1;
> -			uint32_t reserved		: 19;
> +			uint32_t map_legacy_kq		: 1;
> +			uint32_t exclusively_scheduled	: 1;
> +			uint32_t reserved		: 17;
>   		};
>   		struct MES_API_STATUS		api_status;
>   		uint64_t                        tma_addr;
