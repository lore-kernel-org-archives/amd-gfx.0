Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A3CC6FA82
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 17:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EEC210E129;
	Thu, 22 Sep 2022 17:26:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2E7210E129
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 17:26:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BecOzNoT+o2xomHpI4mrdTc0ngh1g+PtZB4VvzHTv9fzOSEQHJTx6IfpKzX5+QU1OgZXqOoCvkiWIiXXbPFCOG5kswMryliixZJ+euNyM1sW9US4lUE0eDTtivqMFkY1Zahyd1Bj/RtZ5OmJwNeZvlm6RuJJNSkQPOZN0WROPsZKJ6Os7vMeKsejzkFpEyxceYiEZZzb7Y1s1cjdG+4zsbH4GKYhTYdVi1VAXBdMi38v6NVTsNApzbYeNbOxQtifIYlMkiZkPf1DMzP2R+LB1LqYNoFj81SrDvqHmHPF8QcKEZIMgpOixbXicxeKS4xdPJpCvhXqIle5zNTJB+sE+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXMsErhG8ibS07F/QEmo4AXc1koO2OkUJ3M2GJzhypw=;
 b=Ify8AwOg27zJgWU+jdPk6M3YX4OpJGEqlIfCBrm4CD8M0HuUQ96IRnKDWAR2ugk3lZeN8RkN3PHK0y9vBI7Fl5vz2DcbgUBrZFV83Ha9kz7GC8EIyBIWOnze/97Z/fCyB4p5JC9Bi6Tjhi9w+J9zCuE5UBS71SJ5rKklD6z12K++DZFY6K/h20svtNwiaoeglyrzZ9U/+3gDLXmEyv6qkr2VdP5Cxag2xY3Y4nRMMXpzvwtAQwZ6Bm5L234kflkwnwQVB1r1cmJhiLvCrK2Un8aPgEG3zMc4nrEqp6jceBkUHh7bY5OHTYuOClDEAxlxtmzdqyxl3KZVkRfcXoQXnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXMsErhG8ibS07F/QEmo4AXc1koO2OkUJ3M2GJzhypw=;
 b=cNdjxsYL8tYbOBjF3U3kskQzRsWk9IWcYvfOU7myoB6PAozclMuLewZWh+64dFC3B38eWBLmjwooL39vIEYOUzFS+chXrDCGiD9riYNXUT0JFtnoFO6/kFCSvBkugRmlDDWxGjXMDjiOfrliPlHxIqlxmAegy6tQO88qBdramOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 17:26:01 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 17:26:01 +0000
Message-ID: <f0681a35-ca32-60c9-fa66-34779ccd55a2@amd.com>
Date: Thu, 22 Sep 2022 13:25:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: pass queue size and is_aql_queue to MES
Content-Language: en-US
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220920142935.215819-1-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220920142935.215819-1-Graham.Sider@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2a62bb-6f23-4d8e-d6f1-08da9cbf8504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4V4rOxhWySKJeO0ObAmfCUZLXqp3BSStof4j+XsqQOH0PigGEFeqTMho+U1N/C2oJJcOzIpKqJeUnmJbuNm4yKpTm0lDJSBn2nJ++suCyVAIaL326SK2+Pi8D9Jrk9Gw2BU+0vwQzeHM9cpUvKgILFM5RmWG78SQvs4mKebJMiYAtkUezFsWMCdJDcmlASe2b/4guackG3KP5fh0L+FtbosihRJuvIc2Isvq+tTgEKORX4Dhdo1lgDyTNT6XZjSA8PheGe8U/uZMqtGd6g8CBU2ZEmLgzgu29GbHEzn8xAvnGNbEfX/j/hAAUy4l02rE0rLFD8w8g9VYyhGJ7+AfEpBkXAqcEId8wUyJ177bgyIvKZad5KJ5HJBWoa7U6tXcpzx21YG0Y7KH3VS1Ti3AgtuYlwhQ06BtRsGwlpv17nWjS9uOdG+PhDJPFbF1KWMZabP808qUs4Fj6aYNGBguCLk6rjiaQp44H5drcvhU7ywuHFxJ5r0M6fS/rOw+y3B4yyU2UbpZ+ol4hoWuTNbnxp5rp9NxAK/EL1TErtAH34zXy4O0wqvTqm15H1qwLp5C45QMiV1g8g6L7GiDHX6vNApNdI9MVbHl3ylMkZC0ZUKrvn965jVrnMh2BwCDgzqhwLPWzP5kFuZkfbGUZCcccw9M2ZBiSoupVOjkRLJU8uHJPHzwD5T8qtzRRA8nAKHCj/u4d/lc4B5KyZrPWFLg1Ht4zSYTiNLVQDJ5LwOBKjR0I95eijyGu8wYzRgFar9NwB/rh23n4E0V/nzpnB1thOrSCKjdD7sSEfV4Z6r3K/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(36756003)(6506007)(26005)(31686004)(86362001)(66476007)(66556008)(41300700001)(66946007)(8676002)(4326008)(6512007)(6486002)(31696002)(38100700002)(83380400001)(186003)(478600001)(2616005)(2906002)(316002)(44832011)(5660300002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3VaWmZiNHJDVEZ3ck9Vb3dhRXRRR0svL1phNGVDNjBCZ2FzUkZRdVNHVUdC?=
 =?utf-8?B?S0NtS3ljdC9SS254aE9nYithRTFmU0hFU09LQS9EQzFLdHcrYjhZOUp5UjNu?=
 =?utf-8?B?NFJScG5rSTg4c2FnOUFYYWlHNkJRQThqd2FQSnhuK2FoNVRhWXNrUEoxcmZZ?=
 =?utf-8?B?SmZWS29GcmRkaVppR0cxSno2cEc5ZU05Z3daWWdRaGV3YlR2ZVc1Um1WVjlH?=
 =?utf-8?B?Rzh6aWk0ZkNwRTRQYUloWjFkUFNGL0Q5V3hMaDNEV0xBM2JVTkJqZ1lyT2lW?=
 =?utf-8?B?eHB1QUZGTWJhUCtjY1lIYkg3RXRDdTVJamtVN0xVY214QWRJN1REN2pHeG5k?=
 =?utf-8?B?WXRuVlRLRm1oZ29saEdSZkhZb0FuYzFLVkExZFRkR0VDekwrZTdKN2lrVjIr?=
 =?utf-8?B?WmtNUnkrcVNOMGtiOU52UERUa0UrNE9qMWpQK2RkcVgxNHVhb1FYVlpxSlhk?=
 =?utf-8?B?cWZRRGhtR2JKbG91S3dlQVJOUXFrb29ScnZWNFJDM1ZjYTZlM0tSeEE2d3JG?=
 =?utf-8?B?K05TVzVLMWZwV1VOdUFhT3o4QXFsWkttU2FBY1lQY2htUHdkMmdDdm9kMzhz?=
 =?utf-8?B?UmhDTVdwV21iMW5BVUQycktJYTBGOEdHZ1hJQjF0UFRjandUMnVERzNtMU1n?=
 =?utf-8?B?S0NLWUo0VEVVbUdZRTNhaDJod2YvZUFXZ1IwQ3VJU1Uxbmk5K2tuT3VCTDhZ?=
 =?utf-8?B?WklsbzBOelZrQ2dQLzV0eDI1eko0VmVkdTRycDl1U0IwV2F3S1VGeWd0Y3Yz?=
 =?utf-8?B?b25PVkd1NWsvdytWdkJPdGV4WTlFdHlxdi8xb3R6MzF2MEg0UmsvTnVuaXBv?=
 =?utf-8?B?cm5xcDhuVGxEY295WEVFWXdyYXZzQzdHdG9KaXJ0Wlo1U20vSDJYZ0R4QXps?=
 =?utf-8?B?bkg4YmdGamFvSXVjQW82dVVqdWQyL3RhUC93cHFBRkhJTStoNkJnV1FGSkgw?=
 =?utf-8?B?aER4dVpmWndORDFBMWZPYUs0U1RKcXNhNnM5V0p6Wm5DMTVNbDBkd3hURHov?=
 =?utf-8?B?MjBlZEJQMlJ1RnZvQS8vNUJYcXNoVWxPb1BWR0owUGp5VXdWNE1RazFlc1RP?=
 =?utf-8?B?dXhyV3pwSkdEa1d1WTQwOWlGQUp4elZieUxQVmJIbTFJL0hUbnNCZzRzWmFS?=
 =?utf-8?B?MGRUK2lkYXZXRFQ3VXNuSXpCWW1xSFlkZktDNm5hQmcxVUFSUkk3bmIyNW42?=
 =?utf-8?B?RVV1ZUErazkzN1dtVHJ3TDEySXBHTWtrOE5nR2xGUmw1b2ZSQ002RlBiS1BF?=
 =?utf-8?B?WE9jUjBCQ2NmRGtFV3lubVVna2hBTXo2TXRzbWN6M041ZkdRMWhhNVhQd2N5?=
 =?utf-8?B?MjBjV0NDREt1NVhXZEx6aTZla0p6K0ZLcWlUa0NpZ1R5VWZnajNObXh4Y3I1?=
 =?utf-8?B?VUNjbk9mM1cxeWVCTWFOdVdDU01nSkoxL3BtWW1sTkk3bnJaRjZHdHYyRXNN?=
 =?utf-8?B?MURMdWJDdmRabXFydCttVzNzSXpNU0Z1UVl6d1c1WHBJdVdjZWRXZGVydWln?=
 =?utf-8?B?MzRFbC9vWkZhM1A5L0RCbkhVdTlCQjZJTjNKbzJUd2pnekVzUG81ZGltM1ln?=
 =?utf-8?B?WXJ6aDhDTFJOUnVJWGZKVVhPa3BDNmkxa3JKK0ZPWkZDTTlYWkJsTU9GcWhh?=
 =?utf-8?B?VHpYcUxaQ2NQd1pmSnkxTXpJazNWN1FrTWszV0lyekVMTU1qRHlEd0tIOVBS?=
 =?utf-8?B?YVg2cW85UHhORHRtTFAwc1hHYUxrN3FvczBqUFFJR21Ed2c2TXlUZld1VEw5?=
 =?utf-8?B?aW4ycm1JdWhrME92b3lrdE52K3M2T2VZQU02WnJxM0R3VGFaK3MvVUdYa1Zh?=
 =?utf-8?B?VS9ZU0FOam54TEZDdUx5TUhTTWtKZXZvWENMRy9jbmNGdld2Zkh1dHdENjVy?=
 =?utf-8?B?Rlp5MjFEMFhnUk84ZktNNWZkOVpBZlhkUm9MMkNpWFFWYzlWZTkxWklTbk04?=
 =?utf-8?B?Tzh5UTJsQ3NpN2VtYWRnaGEzUTBKcktlbVFnNWhQay90aGJKUElGdVF6WU9V?=
 =?utf-8?B?WDZoSE1PNkdCTG5zMUFZaXVCNUpNWHYwdkNBTDBqRE56Q2dVZ0V5ZitxNVM5?=
 =?utf-8?B?bzFWS3ZUYXVJV285Q1Q0OEJSYmFrVTZHcmM5SHRPMldzanAySEhYbnhpOGM3?=
 =?utf-8?Q?DAq3IM7zwbanWB7Mz+KyANmWs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2a62bb-6f23-4d8e-d6f1-08da9cbf8504
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:26:01.5874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bt9XNVKwvAQi+ZGEVFfp5eNgUpWhx8BH1l5zefhl6R3/huBf/qHiBMIxOWu925mhAWKP9epWu9j62wgI4mdMqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843
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
Cc: Jack.Xiao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-09-20 um 10:29 schrieb Graham Sider:
> Update mes_v11_api_def.h add_queue API with is_aql_queue parameter. Also
> re-use gds_size for the queue size (unused for KFD). MES requires the
> queue size in order to compute the actual wptr offset within the queue
> RB since it increases monotonically for AQL queues.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
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
> index e83725a28106..8644b212cf4b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -205,6 +205,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	}
>   
>   	queue_input.is_kfd_process = 1;
> +	queue_input.is_aql_queue = q->properties.format;

This would be clearer:

	queue_input.is_aql_queue = (q->properties.format == KFD_QUEUE_FORMAT_AQL);

Regards,
   Felix


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
