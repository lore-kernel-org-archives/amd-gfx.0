Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080F5EE6420
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 06:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B0810E5C4;
	Fri, 15 Sep 2023 06:50:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F328610E5C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 06:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6oualXrEgi7tHZCX6GnqWte29mxrGsore14ZEUeKcPEY0d8r4fejaJ6cOkrI6sy+6+m9rMkHIk5zwpVOZyVXXniEQn0gJNDY9ep1OmB2VDmy2jrOukXWI2OaIJklWbxSAb2W/Pvqa2+RRGoo0bMBqqHpQFXNx5ZdT/zMCAMs0L9qL3bz3MgXFK7/YPB+yuFpMuHQZnA2sbRSsmH4e+LHs24r6y9lnRULkNcczFBDtCoX9y6txK6/AaIpxr9Kz9qF76YpddHZvB1Ab3uQgDj7vooFoxOh1CZb6Dn/AqubFdH8gAVEB4/QgTttfommvunqVJs17JUdn5z2GkJ8WHIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moqH0aDWndyxPe8o9UjkoTvehP7PANyM2z/69EbhHFk=;
 b=W0hh0+9T2Jr3o3a6BtBe2V0jwrRWFfdb1PxsGUrRVVaX2ak7gFmdZClKoqTcLCtoK0vwD7We8DLsPmm3swGDrUMwXofKFFcFezA/mTYreJ0+7unzHwLaeMZXGOOP7cXPHO5gaGcA744nCMmAq5JocA5v2+5fR8ZhUDID0vQr9m1m45m63nFMCUJD80UjSZmKp9nM6Y9a3QC4DQpeOKBbfB5WjDb8Pj3UtcI55VDLqOwNXc7QmS7S+8iJxbIdStC3H7avfP5zFTrdWbE8LxXy4EtvJ8uoo3YXwxYfyRcdpH/lMT3i7jgzlIqf7xNUR6WJVt/hHKL51ENE8fIJT51E8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moqH0aDWndyxPe8o9UjkoTvehP7PANyM2z/69EbhHFk=;
 b=M10ja95kX+Y4NCeslrbWyQ2/tze2beE38JodkBztH8K783w2U2achmnH09R7uvWPHbuDvEJWNg00rSkT4EePGqVip/2Cxhoz9wj6MTlReZKJWUbi5YEet1yJCKDs2Oa+ZLpn0KShu4HLA9lPa812svQQy/7Mr4eGVLxOPRlGsac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 06:50:14 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::55cb:215b:389e:eced]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::55cb:215b:389e:eced%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 06:50:13 +0000
Message-ID: <81a73442-2d27-eab8-4dec-cb1a6d179ab3@amd.com>
Date: Fri, 15 Sep 2023 08:50:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdkfd: Use gpu_offset for user queue's wptr
Content-Language: en-US
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Sharma, Shashank" <Shashank.Sharma@amd.com>
References: <20230915025213.2463291-1-YuBiao.Wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230915025213.2463291-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:408:fc::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: efb852b5-b9e5-4b7c-7f5c-08dbb5b802eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: idMM1316XUrhJ6ujjNUR7kzebv9KUla7XFJTrsfKX/Y4taH3qrhIV6UVz0uQWITn6zbrTE++xcti7/qbWKALnFQUTen/kmzXGxWhzzjayurbFM/mlxD7L2eakxa8C26SSD0zTdICPYAmfBZuh7GHU804bZZMhmweYZd36enAGF7Nno3c1wgFbx9aLyaYxiubCpUQJ4vmPR2IPi/j5kRIVxwg35rw4HmxYDII8eCfQKygMwpdQiOcYh23c5iRVweg2KvQzw/6Xu6ibMB+vMHRKVGMKX7ZTDHWJSF/t2OG+/Q+/lOBi7wnVQp66KUJwDGk0AcPia8vY8RNASFXTZhev3Q2RE+JqS7nSSTkFzuPHaMzvaKRhs/h2atPX3CJWbxyF5/HnzQjJjxpGukzbgMg/Tt5FVcD+XwMotIH0nI3q4K04JtcM7anbRkgWGN25DyAR9nn4aYsvP4pNhFiyIzlqsADa08dz3mPzPTg7cmBTZIq6WKV/J+aSfWZgF5t4hqCKjlesopvv5j+RggbMzAWByWWdCzvVq4iClp414CBouGsVGtCU4W1ZBgmjZ6clJLbA4o2ZrbIYTzWJdnPIInNkh7a1tSBhINqn3lRFdnJ5fBOEmtO9L/QM/nBkZd6b9m0oKr72cUSSOVi12uC7BNjTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(186009)(451199024)(1800799009)(41300700001)(8676002)(8936002)(4326008)(31686004)(316002)(6636002)(110136005)(5660300002)(66946007)(54906003)(66476007)(66556008)(2906002)(38100700002)(83380400001)(36756003)(66574015)(6512007)(2616005)(26005)(86362001)(6666004)(478600001)(6506007)(31696002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yjh2QjNsa0tXOFhNdkc5THdEV0xldk5HQ0RZQkNkTUszYmRWTFZxVHBNeGVj?=
 =?utf-8?B?elV3ZW5rRFlhTjQrdjBYRW5mT2kyV2FxMzZWRXQ3RzdsOHZSVlZST0NhU0hh?=
 =?utf-8?B?TEQwTkRlNHk4QkpjaWZzR1JvVUtwMDNvR0JXQnQ5YjBQck80THd3MGdsdGFG?=
 =?utf-8?B?MFNYVDd3T1UyK2QwaTRiUFRuTStEQitkcVh6WFlTZXp5V2thaVBSOThuc3Vk?=
 =?utf-8?B?dFJTdjEwNFNjbU5COVRCaXBIVll0NEpQdENyU2R2OHN1aE5Ha0dtN2FSUzFT?=
 =?utf-8?B?QzhWM09PWlBBU2k5b2pUY2pteGRMY2loclE4QlVZU2R6alJ0VWRpdVQ3L01n?=
 =?utf-8?B?ZmdQNXVwekM4ZmtYcHRNNExSaVJZVU84SW1wRDdEcmdBRWhaTjJPeHlMQjBu?=
 =?utf-8?B?QldvWFprU2E5VWx2TGR0cWtIZ0RwMEZOUDBXM0VrTE8zaGdRTDNib3NVa1VP?=
 =?utf-8?B?ZlVtUXVPUWlBNnQ4clI5V1VORjJyUmFyMHhWWHI4SUljQXFGdGxuNys5MTUy?=
 =?utf-8?B?S3BzYnIwM1BxV0UrU21BaVpjSmdzWHN4ZjR6dERoOHFzYzNNblVUY0lrbVRw?=
 =?utf-8?B?Vnc0TG5ydUk0Uk5icUtKeHFxdUZCZFF5eG1SczlGdVp5Q3VCNk1ZWVdmMU0x?=
 =?utf-8?B?K0ZwaDEvM0pCZTRVZ0lNMlBtUkdFd3JNV0lOOU5NMnk5WWVoNUs1OGd0eS9G?=
 =?utf-8?B?VzdtUkxwNWp5WlprMnRXMlhxOGFJZkJLdG55N2FwRi9xb2J0QnNvM2VtcFpL?=
 =?utf-8?B?d0RiNTlqU1k2OEpDV2pTbFd1bnVlUklnZmZ0WUp4ODBzdWh5MVBEbVcxcmZs?=
 =?utf-8?B?cCtSc3RTTEdUdkw4UTRPWEVqdWsra1JzS0tCM2lRTEl2QnE1ZmhWK0gvaDlj?=
 =?utf-8?B?S01tcTdBTWF0T0UrN0Qwd0JURitFb25rZ0x4QzlyNUcxTmR6aWMxQ2J5Y1Rt?=
 =?utf-8?B?cklXOVBKZHBSYXd3ck1IajN5QldERVduSnZ1STBBZUM4YmprcHNOQ2hzamI5?=
 =?utf-8?B?SGJkWndxNkQ3NC9za3FGU3VmVGhTREZGVHZESFM0Z0hFeHpsd2Z4eHRwSllC?=
 =?utf-8?B?cEl5QWdybTN6aVl0OWMxanBBY0llOHBxbW9JN2VaL3dxYXZIY2hlU2p1WEcr?=
 =?utf-8?B?clFOVFFCMWtRWExZd2kwdHBYaHc0NEFDQTRxemdGQjYxeUlubEM3TFdYdkVY?=
 =?utf-8?B?TnV4WStpd2xVR1dXK3g1R1NpbU1HdExMbU4rTjRXUldnelFQOFAzRmpMNkpH?=
 =?utf-8?B?ZmVDTEpnZmp6UGJUOTI2ZVF1b21tMlVnOHJRZ2FraExFOTEvMFM0UmQrU2dt?=
 =?utf-8?B?eGRrMWQ3b2pLWTJYekxVTmlIbzM4SjBZNVlEeGxXcEJ1eTRxSHlrNWFpU2Q2?=
 =?utf-8?B?VERRenA5RGRKTjdpNnpPbVZsRnVaSTBNd0VBSGJBSzVHWmZQTTlSa0UxVnUr?=
 =?utf-8?B?SEpKZTJJNlorVEpVSEZDSXFwRUhwZlVHL2luWXFBSkVDa29EM2dZMnkxSmlW?=
 =?utf-8?B?UW01aDhPMjQvQlFCRVIrWWNUMzRIK3pTWWNuOHdHMGgxMktsQUllYlJSMDJT?=
 =?utf-8?B?cWkrcTJXelI2SSsyUkV2N3RTazRIN3Q4QkgxSEwyQjd1bWdXdzJrTFRkQVR3?=
 =?utf-8?B?QVBzTER6dk5qOHZROTBzMFJ3Zk1kQ3JUOXgzazBKOVBJWjMzVktxYmJRTkw5?=
 =?utf-8?B?SGJBcU92Q0FTbXNZR3p3cEc0SC82TEZ4UXBpVWFFRzVNcTZGamJoU2hmcURV?=
 =?utf-8?B?SzdMQ0hQYmxwUEVTd0FQVTVKMGpjS2ZueXQ3RFJUZmZyVXZyOHZwWVdTb0VR?=
 =?utf-8?B?dWgwQldrZ2RXN2ZiLzk4VVBkZE02Q1VEV2FDYUpOb3F0WlJzQnRoQ1MvNUEr?=
 =?utf-8?B?U205M0IvSVdaL0swdlI0bUpnMlZCbi85NGJWN05aM3BjNzJQTk1ZTlRCbE82?=
 =?utf-8?B?RXJXamxudWJvKzBiL1NOdTJYbGx4K3FOYmV0SW10b0ViVVBEazV2T3FMbnAz?=
 =?utf-8?B?V2tuSzhSZ3l2cVlMRkt0Qnp3ZVpUaEl2N1A2bVRud1FmL2ZENmpRSGYycEZv?=
 =?utf-8?B?TG1KaWNnU09lZlM1K1JPekw1dU9taTRWR2dVazMyY2cvbkRFRlpvYVM2RGhr?=
 =?utf-8?Q?Q6Fc1z+6qGKAwP5ga1tPNY9ft?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb852b5-b9e5-4b7c-7f5c-08dbb5b802eb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 06:50:13.2459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cx82mnNg9aeQ6KbSx428wIHizl+tLS5NpGeDB+iRD3K6O6sqafgAvqfBjbD/h+8E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Monk Liu <Monk.Liu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.09.23 um 04:52 schrieb YuBiao Wang:
> Directly use tbo's start address will miss the domain start offset. Need
> to use gpu_offset instead.
>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>

Felix and/or Shashank should probably take a look as well, but of hand 
that looks like the correct fix.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 77159b03a422..36e7171ad9a7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -216,7 +216,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   
>   	if (q->wptr_bo) {
>   		wptr_addr_off = (uint64_t)q->properties.write_ptr & (PAGE_SIZE - 1);
> -		queue_input.wptr_mc_addr = ((uint64_t)q->wptr_bo->tbo.resource->start << PAGE_SHIFT) + wptr_addr_off;
> +		queue_input.wptr_mc_addr = amdgpu_bo_gpu_offset(q->wptr_bo) + wptr_addr_off;
>   	}
>   
>   	queue_input.is_kfd_process = 1;

