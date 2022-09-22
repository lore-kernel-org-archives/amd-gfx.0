Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF894C54EE9
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 18:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5225410E029;
	Thu, 22 Sep 2022 18:54:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98D8F10E029
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 18:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMifjhE4e6CXItZBCvJsiyQ/zw60htfhfLv598F1nXtqVcj0TnsaKcsVR9WppKiB4P5yb2lbk3tR7IHYTjBoulqU6WuESXc8cCza7z2WQqiWqk9KnJpZ2jVP1CY5kImm0QVZ06hthyXFSC6aShqZE6IKqU/ovAh7oUe8rDMJJEwwBHnZ84pd15wwkL0BOyYjOCM7qBlpfubIJqr8gAHd4j/fEHYyDkERu9YKSOuCpdOOfTNPdu9EWuAP2vgMjm/OJoYlq32LGq4hdSKZ+m9r9/dm1i/L5PWpW6C971oE527uzb4hJFg4UVAIUs3tkHIHQARwxkoeV4i97RmTKxChAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPMiPNxBHYUC5inXOuMu8bpPOWaTkYtkelB/o/n/mKI=;
 b=KnI+wv80solNWnXDWTd2jmKwJH0+Q7n/VUBbqc5BAPTPfbMbVaiE5Rw56BevKJu2cTOvXphnN6yW6KCDWc7WYABcy27WwxlRWSVuoCao3K74bBdWZVX9E5s1Xgj85VqOJrLKFbaWZ8Ychrwjgzg+A3S6ehiERQ3b9GeD67YpDD1HzMsGgePaq9VidDWbs7yhAT1dv0IEIrFjmbhlCd2NmVnwwM604UoVMy7UReJzz5njbSfLTbV1zcdTJFFXoNgO6uL4W0kK5hl3jx0q43vSSq3lURI7kQfKNxtjqVInUsLt1MsascIhiG+PlCaDF8/wnXZmDX0DnE7hFqILlHdYBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPMiPNxBHYUC5inXOuMu8bpPOWaTkYtkelB/o/n/mKI=;
 b=KLpD1QtQ6cYuZ3VuOFJgM6HSpEkwGncgEPoS/vOZWk6Ox6daYBKhysyhnI3sYZGrMG5/jXICYj5eHW+qmcT/3OyQAYXEsMOr7NeH/4HNMhU1kb3heyFD7EWJbWlBFyhgKxbsE6WU1ac0J6x2qmup58sAdPbYEjOzaM5J7dJ0bTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 18:54:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 18:54:53 +0000
Message-ID: <fc744a20-24f7-799f-7fa0-bc040aa4fc68@amd.com>
Date: Thu, 22 Sep 2022 14:54:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] drm/amdgpu: pass queue size and is_aql_queue to MES
Content-Language: en-US
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220922180219.814212-1-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220922180219.814212-1-Graham.Sider@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a51f9e-06de-43bb-9e17-08da9ccbef06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPioaUN4QYmBD2eXCjYF5+yo9lKRIo1XwjvmXnbHtlSdPybDLaHcTjpB2yhoYqmFTlJJ51opyC8xdrAO/FEwFwCQzFac01Wn5mjbX5VuXYwSt9o/OXI+S8E5GwhxKx1PNnITunPcYqP0l7tR29VkBqPbKw4nZq/Im+0GXG7/bJS0tApNDXhaf4WQ0p6DbJPeAUk+vtx5T529rq/xJBZmGHjUGg02RuJZF8BrLZcoWUR3SzJGmtRzFf/tz5V55z2nBa6RWNIbb30sLYjEJiAMEfy3wGbCcm2z2nGVnrp5YpLsX0GWa+VXrkEM1MTd3OuDNdJPFbxh/wSW/ty9/9/NzAjcAa1P1MwZcFKlhggnB4qVBOJkPpx3C+HKNXNyqemeZLfm/IFXUerdtrespokLkLvV0sTj6G7vfG0baBz6/VaJlKkj38rCovLPvV8dOg5Jd2B9UgtFhKOZxHs7B6BUic/JPwb3pZmi+YO4cbVQ0HDkZ4mNxBTzbAhSap4psE4ASaHmpMrCPj58LxSOrkJGtfEqSuu4yRtAs5tYBgSbRRQ2no5f3iYOlhr1nUgASeDP+Q2OxWLJSv/bVjAqpF/TFap7ezHzkiONRgYSRIkJ8e0rxZ6f+nOLFTNIIkx8vvW4gW0SGPGSteQCTYzL4HVCoMsLSP0AZlRFZQlbpuyLjFI8cr8ERh21QqCckFLs5mCLUcC20xiHJc8imhCMh8W1TZ6rTMekm9W+0NPRmSWh23N/asVko9GnOHVqwoDBSH0vVFz7etsp2lQZdKD5uICntSsmjMZt8TsIe6+IEXaaIaA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199015)(66476007)(31696002)(86362001)(6486002)(316002)(8676002)(31686004)(5660300002)(66556008)(44832011)(66946007)(36756003)(26005)(6512007)(41300700001)(2906002)(186003)(6506007)(8936002)(2616005)(83380400001)(478600001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTRTclhzMVdWd3V0K3MzQ2wrOVlnNzZ3bTNnOFllZDhXcVBKYXpSNUlKeksw?=
 =?utf-8?B?U01jZm1iZzQrcUFjWUsyZ0pYZkZQUnZmZCtxRGxPaXlSZnBnVGVXc3FycGJn?=
 =?utf-8?B?TkJ6a3k4QUJ6ZVhrdEg5RW1qcXpYL1oxbHBBQ1Q3OWFrREY5cis1bXVKM2RR?=
 =?utf-8?B?K2dqNHJBSjVTK1hoa0RuaW1idU5HU2FZbkNRWXdrM0JuSkJNYjlBbkY0VTdr?=
 =?utf-8?B?OXhHOEEwa2FnZzRMTWV1V3JsYkxIVlJlc3FoMmo5Y0ZTYnIxZklaU0F5TXlF?=
 =?utf-8?B?VTJ4V1JRdnYrM2J6QmhtcHozbEd3aFZhUnRiNVBGMnJFb1FoampyU1ZBNnUx?=
 =?utf-8?B?ZmYwWE5ZUzBTR3dYWGp4clFuMjFnVkp5TFhjRGNPWjA3amRncWhjNjBZQlpa?=
 =?utf-8?B?SkdQR0R0WWRlcmdYL2U4aUhHV3NXeDR2a1gxK0FFQkJHVkpiSkhGYThSeGZD?=
 =?utf-8?B?dWRmaHNsVzlzRXNmL1ZoQ3JDcUowclgxb3FNaWhlN3I3Y0g2alBjZnJ6TTZh?=
 =?utf-8?B?RWZTV2Z1U29PZ3V6Vk5Gd1pQU0wwU3JENDNrY2ZRdlJGOXFDcW9zZGRCeXNC?=
 =?utf-8?B?Z3pBNjhKSmdFSnIzQjRrWCtiaTRuajJjaXBySXBORnhodXBKTldKM1p2SlI0?=
 =?utf-8?B?a09Ca3NpWmFVQVhXM0MxOWNDSVNzVGphYm01TlN6YWNxbzZDRGxldExTdXBw?=
 =?utf-8?B?b0gySVlhQ3RTME9lZ3plSWJKZWRoRStPeVdWZDJVclUyS3hTWGNuTmE5djZj?=
 =?utf-8?B?QlRWNy9kZGhBeHduaXpWbS9iU1FaKzduM25LN3hwWkd0QXZISHBiZ2k0L1d6?=
 =?utf-8?B?T01tQ2JtQ2VyVkJaOXJncnk5TTVSV0E0bEszc1BETlBabHdaK2czQnlMZUQv?=
 =?utf-8?B?SmVlWEZTV21RVzc4UlhLVGl6TkxEL0ErRzB6UGgwQXNGYVRqU1VMRDByWFpk?=
 =?utf-8?B?Z1pTRnlMQkFZOFBTT3ZLOGt3WlBrMWJycStONFJGL1hJbUlhRXRtNEVXcFds?=
 =?utf-8?B?V28vZStmN3N0Yk1QWkM2eTBrcVlCeDBpRDNBYmxlQm1TRGdHWnJTb2ZNTUh2?=
 =?utf-8?B?b2FZa1lZdzlqOFlQVUppM2VveDB6RXMyd2RrUDhhcGZ6NG5HcWZzUHhjK2RT?=
 =?utf-8?B?V0pEZWI4eXp2eFQ5Wi9GYmt5bEUwUThESUluRWcrVzVKUkx4a1F6QjJGbmpF?=
 =?utf-8?B?ZDdMSmpxTkVFNWlYVjh3YU43aHd5U0ZQZHlJY29JdTVzWFJDOVk4TjlQQ21N?=
 =?utf-8?B?WUVRRFRBZmdQNTl0YnFicXl4VDBYWkViNWZKOUM3bDNXWnFRKzl4UUtBUzFC?=
 =?utf-8?B?Zmt1ZGkvRmhwam1YSnBJV3JhSDNPT2N4WVNXSTI0YWxSYmNoeC9UdGJTVW1r?=
 =?utf-8?B?VCt3MSswMnpwU0FtNllRemliOFA1WWpKSUFJL0RaakxrbWJkVWx2YVpLUWJ1?=
 =?utf-8?B?NitiMDQzdzQxQi9FWWxNVi9ONGhUY3dVVUVxM1d6YzZ4S1Fqcy9vYVJRQ1hy?=
 =?utf-8?B?THBVQ3pXNnpvZTRwTGdhblpDaEM0V0QwRGVYT2xFdnd4NVdxdXAvTEZYcUxR?=
 =?utf-8?B?NmZyTnkzdndUQlJ3VStQbVlOak5lL3F5cnV2RWQzbW1hSzBqYVpHUUtLbTZP?=
 =?utf-8?B?WUNUc0RsOVgrYS9wRXNCM0NZYXN4R0MxUU15UFJmUUlCdXBWU2RjdW16VGZK?=
 =?utf-8?B?WVpZS2ZiK1dRTDZUVmFuSHpaOGQ2UThCZHh5L0JqM3NpWHB5QWlIK2FkSkl3?=
 =?utf-8?B?Y0xNdXphK3g3azJKWlpNbFIzQmI3U3hHaktQZ3dQeUpYd0psYWtRTWxHbXR4?=
 =?utf-8?B?T1ppNlkrSHFaeEJmWkdlclowSGJFWklzdDF2cGJ5dnRFVlAzQjlYWFdpVllr?=
 =?utf-8?B?aWsreTlscFFHdTdXU0VTY1g1elJobCtSaUR1Zy9yYkYxSmw0Qkp2RWZzenNz?=
 =?utf-8?B?d0FQSDlFSldJZDRvTGJEUzMxZ2Yrc25oRi9hR2ZaM0ZZVHBhUkxXR0M0Vktp?=
 =?utf-8?B?QXh5ZCswd1VsM2VLR3Nvbkg1MHJubWVLRDVqWTg4VkZwUTFoTXpLMGM4TU1F?=
 =?utf-8?B?dm11bHJTb0o5UE4rbngvaXB1NzhkeXdVM3MrSkZUNnM5YWV2a1Znb21ZcCt6?=
 =?utf-8?Q?ghRkWOkz6i49ucE98qiW4iqbc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a51f9e-06de-43bb-9e17-08da9ccbef06
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 18:54:53.0234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/SSQxzUpOFtVagCxTp5Qa9uYtkc2dqs4OfGhqePN8kkKRK3u6S26PTtOSUJYT80OZ06Y9y2Cp3BVXQSaEEqSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
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

Am 2022-09-22 um 14:02 schrieb Graham Sider:
> Update mes_v11_api_def.h add_queue API with is_aql_queue parameter. Also
> re-use gds_size for the queue size (unused for KFD). MES requires the
> queue size in order to compute the actual wptr offset within the queue
> RB since it increases monotonically for AQL queues.
>
> v2: Make is_aql_queue assign clearer
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h               | 2 ++
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                | 4 ++++
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 ++
>   drivers/gpu/drm/amd/include/mes_v11_api_def.h         | 3 ++-
>   4 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 7b46f6bf4187..ad980f4b66e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -222,6 +222,8 @@ struct mes_add_queue_input {
>   	uint64_t	tba_addr;
>   	uint64_t	tma_addr;
>   	uint32_t	is_kfd_process;
> +	uint32_t	is_aql_queue;
> +	uint32_t	queue_size;
>   };
>   
>   struct mes_remove_queue_input {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index b64cd46a159a..5581e03fc956 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -187,6 +187,10 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
>   	mes_add_queue_pkt.is_kfd_process = input->is_kfd_process;
>   	mes_add_queue_pkt.trap_en = 1;
>   
> +	/* For KFD, gds_size is re-used for queue size (needed in MES for AQL queues) */
> +	mes_add_queue_pkt.is_aql_queue = input->is_aql_queue;
> +	mes_add_queue_pkt.gds_size = input->queue_size;
> +
>   	return mes_v11_0_submit_pkt_and_poll_completion(mes,
>   			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
>   			offsetof(union MESAPI__ADD_QUEUE, api_status));
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index e83725a28106..007a3db69df1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -205,6 +205,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	}
>   
>   	queue_input.is_kfd_process = 1;
> +	queue_input.is_aql_queue = (q->properties.format == KFD_QUEUE_FORMAT_AQL);
> +	queue_input.queue_size = q->properties.queue_size >> 2;
>   
>   	queue_input.paging = false;
>   	queue_input.tba_addr = qpd->tba_addr;
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> index 50bfa513cb35..7e85cdc5bd34 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -269,7 +269,8 @@ union MESAPI__ADD_QUEUE {
>   			uint32_t map_kiq_utility_queue  : 1;
>   			uint32_t is_kfd_process		: 1;
>   			uint32_t trap_en		: 1;
> -			uint32_t reserved		: 21;
> +			uint32_t is_aql_queue		: 1;
> +			uint32_t reserved		: 20;
>   		};
>   		struct MES_API_STATUS		api_status;
>   		uint64_t                        tma_addr;
