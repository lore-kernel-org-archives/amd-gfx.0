Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9840C761A6
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 14:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7650710E6AD;
	Tue,  4 Apr 2023 14:11:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B55110E6AD
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 14:11:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzz27tvfWDjw8IzLLqBII67JSJrRAgMmJCLqFTpl2krkFZ4xzJUnH9ut0eARSoLtBeryrKo/OcYMrJAz4jDQO4z3oah4gJhBpxjvlZdRe3//I6S2RJo5hz819z+yDQ+TofUWbPyefHy6PZPUXSUeQN3IammZE8U9E8Z2MD/cQD8IK5iYINMqTixc7jFasz+DJ2mMUBU74phAhxH5FL07+of1RLTdbAqBt59Z9HCQqoSxSxVhM9KQq0NDaFVVIVfXzlBOWDijFrCN9By3uT2+sCJqoY60CO18BAWsdkgvERi3k+S+tkGPeiliZsZRX0CZGC1LOv8SqzTEhLjSN5cjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hY+NpY6/I7J/7tPNj8hTYGuQYnhI9mIKgEjabpkyX6s=;
 b=TJtwPFPQ5TMsA/NxW/4NAa4i6gY5YjBNFPW15Y2He+nKjOCNOgPH0skIpq9XndnANsCx4Jj/Ylf2fjWWsB6JKOwps40szWn8XGL1gNcpmdHtDXdC9oTPFQ/oCqHQPMC39nPy3G/H0bH+KUx45tiEePcvSDbgA8hwEewsj8Q/nU+10m7Mph+t31RPBUqhymwU+IVDG8oqu14T5SK+zJfiHLoLpdYe0V6UTeSuggMFIHQb6Qaf75ZeAYwpKItAGfriqhKWavAtx+EEmoC3QpSfuOFjRsdZlCAd24k/xPTRUC/VMhlNGOiCnxGMR5AFOZ6ZPhFB0Z9kWUzCmW4Pn+nqRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY+NpY6/I7J/7tPNj8hTYGuQYnhI9mIKgEjabpkyX6s=;
 b=Il+EAZh62TN1SzqtSIwh1gwOfixjKVDMZcsq9VVnli5bUskJ+33B2hALU29NrXHeRX9AieONu6SVEGAwlC2S4ZaujPBBR9IpJOEGjmkssfhLPY8RmQXpD1zM6QNg6ovsl5uGYMSBK3ocpASyIpo8X/Ivq/kUHLoALFQSukQmU+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 14:11:32 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 14:11:32 +0000
Message-ID: <91875e99-89f0-5a5e-03fc-d08d3240c869@amd.com>
Date: Tue, 4 Apr 2023 10:11:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdkfd: Fix dmabuf's redundant eviction when unmapping
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20230403175949.131530-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230403175949.131530-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 2880a42a-f3c5-4c57-6a23-08db35167e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OLFA0wkmbWbxXBmz/tIZKG4MoHjeBRW9qZtgawILgSXikB9Pe2GVd+xb5lojKj6xajTVxdhDM8jRkR2g003tf+abYxhzetJ0zmSeWj2kiD1ybet0FQuBltAhAW8vH+Vlc0etVIUacL2gcAiamYsFqLNzBWiqJp6HvoKEpdSNHXDJ/APMzAJDIEOYo2nfMPiLb26h77tGghRZb5T4GLy2Fd9+oyBB0KVq3in5lNxmrLUzi7CCmqxKp82nI2yQh4KED4LQ0VlNmk1f+COH8EAPYX5X5bLPsDLLtS8t8SJ4fGh14C0RI8MAcyL4iv67l8NIVa8RHysxmyavOOTyQZdUNexGo9gj9SpA4jp3kfPFu9HG2Wr4AcTq7fqKWo9zTgXg5DKehiIi+itKJWZ2Q7Q6T+pg9qLZQ7uGFtnxHXSPtMqTEkjJ6Att/jGftJrWwLjq8+P5WrVQgiqXNRJt/NcRhm67G0m/uVF0yPQQfkWvOucb0itAhG0cwJqmoPNVMRItSoqvEEuSgo4JIpQ2sJDvA5wDViy9hxYpupErJ9bjwPeoEuLYXbLFJoBPBfi+/wwNiYdKkv77MKVe3ZrV7nFcwWsGijamw3HPwdbxS2KRCwdMf99e9A2pIkI2+D8ZzW5AYbMQhy94iwijEcQ6wlRiCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199021)(478600001)(8676002)(66476007)(66556008)(66946007)(6636002)(5660300002)(316002)(8936002)(110136005)(44832011)(41300700001)(38100700002)(186003)(83380400001)(2616005)(6486002)(6506007)(26005)(6512007)(86362001)(31696002)(36756003)(2906002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFlLcFpGQVZGYys2QnR5L2FLNHltZXhzVlRuM1dNNDdjQm9pVTVoZnBhU1ZN?=
 =?utf-8?B?ako1OWFpMUxvKzk0dHZpR05BeWYwd215RzcvdVhNNkdEWFFoRmxhR3dhd25B?=
 =?utf-8?B?Z3NhQllVNGM5Z0EzT2lMYkQ5ZDdsTUE5c2lmcUl3TytqQXJiR1pVWTR3QkZQ?=
 =?utf-8?B?UTNMcVhTMVVHb2pqalE4QVBrbkR1ZEo4Vk8zRUczR21lZnFEZFRwa2dZTEhp?=
 =?utf-8?B?czdqYjBXSDlyWHJaNGQ0VnJiaUNlRXh6YmlUdFlIbzZlNzhsZHQrSmZBZ0dL?=
 =?utf-8?B?TnJ0SzBMeUhBR0VKYlpnRXpNMlhHZk1OTHQzb0FzSnJ5U09ZL1RIa0YwRFB0?=
 =?utf-8?B?aXkxTUR4VDY5SFlmUUxlRmErSjNTL3YwR3V0QlJuSlVQSjRnMlhUZXU1aEZP?=
 =?utf-8?B?VExWalVEV09PQnZ5WXlzYS9qVTJDWDdQSmVwZ0tRNi9pRjFuOHhlMlE2ZDRS?=
 =?utf-8?B?YzBadEdiRko3bVh2a2ExLzIrdnNhTWhoQW15M3o1M3ZURUl0RFBjNDJQS3No?=
 =?utf-8?B?c0pwbjR5OWpaVVZNQk5wRUxNWVNEbS9FanRKejdoUG1HRVR4NTRhYzl6SUl3?=
 =?utf-8?B?RE1xK3RaZ2lmaWVMd0VJZlpvYTNvWTZzN2dOZlZ1YktENXdEMUNyRDNSVThJ?=
 =?utf-8?B?Q0NMY01BeExWdXMxNzhaUWtieDRqVFMzN08yUkhJNlRzUFM4UWJRT0tPYUJR?=
 =?utf-8?B?M1lYM2h1ajhKUUJ5OXUwUzBSSTZhYzRiNFUvWE1xZnlEN21iSWRzdGVaakNs?=
 =?utf-8?B?MFd6dDUvRXg1dkl3SFVGY3BXOGoyakI0dWdkVEN2TVR5QSsxU3daV2llT0xy?=
 =?utf-8?B?alJ4UndBMTEzK0ZNNldLaDJZVVp1UUNWTzcrUFFrU3dkb2h2YlB3ZkxaTFNN?=
 =?utf-8?B?elJLZmw4T0oxZGtCUlJpR3M1bWtGRlhvdCthUkliODJYNFpMeDJaMjF6M1B4?=
 =?utf-8?B?blc0b29FSHZBWU9XYlN4cDFCUmJuVUU3Qi91VGRmZzNCQnptVUlxWU5mTU1j?=
 =?utf-8?B?NmZJV0pNMkZTQnVWVURML01sMVpGWWkxNU15TkRiQ1ZQRXVQaHM0blo4Q1lk?=
 =?utf-8?B?ZkVFZmFYSWFNeWZtR1gxT2hkVjN5OWZhUW4zcnBIN3dHZGRPWUZTOVpVbGZw?=
 =?utf-8?B?dVFOdmQ3cVprZEY3OFFSMFRCejF5OVAzM3VvRHc4bnRCUmsrTzRIaCtXWnhs?=
 =?utf-8?B?VVZsVnhRbmVGYmxjaVZrTGlWbXRlcE94ZVVTUjNETTlZTzJGYmp3cGFpb0tL?=
 =?utf-8?B?ZXhyTjJyWXB4bjJZRHZWbHpOL1JWVnFURXF3V2kyLzNnaUVMekRWRmZNdm9N?=
 =?utf-8?B?S1djS0Q5SFllVElmMEQ2b0x5NEVDOWhISnI0VWJMNDEwRVNZcTcxeDRoZFlT?=
 =?utf-8?B?OHlmd3pGRStMUVRKZGFDOWtVNUg1QU4rbXBQTUFCQ0JLVGNtQ1VhaUVXY056?=
 =?utf-8?B?NTN2aDhPUmJBeGRVRTVJT0V4QktsWEVabERsTis1V00va001S01SbG5KUkhZ?=
 =?utf-8?B?TUdGNlVDcHlWamNYNmdZaEEydjl0aERPenhpekpjdFF2RjF3UC8vWG02b2hu?=
 =?utf-8?B?MGcrTk5FbTJxTmFzRFVOOFNRUzNWdVIrUmI3aWx5OTRFei91Mzk4K0lRVDZq?=
 =?utf-8?B?TWZEWndGeTlPank0eVBzL2dBWWY2bDB6amF3YTErWFJaZUdlWksyM3ZxOXg2?=
 =?utf-8?B?eXJabWRLZDBtNWs1SUR4Q0lWbUlWb29qUFptUTBYUG5GRElHNHh5U1JrbHo3?=
 =?utf-8?B?TjduRFBYT01vSFQxVU8rSjlzalowellSUlM3VGdEVXRQUlJrdVNCSFQrd0FH?=
 =?utf-8?B?RUNuRmNXbVd4OXVZZnNPQzB6OURUc3MvcTNOYTJHMmtPTzR3b0ZKSjF4TjFt?=
 =?utf-8?B?cU5LY3RiVDRGVHNKNFpWNXVwaGFrYWhaTFo0eGlmVWRQcmk4R0ZYU3hDaGho?=
 =?utf-8?B?RWFTaWNDT001cWYyN0lvTWNBOEM2WFl0dmthU0lQa2VCRnFtV2czSjJJZlN3?=
 =?utf-8?B?eFdiV3JheFhsRk8xSnNQV1lHZmFycS8rdWlMTG82L09hTUhjcUFRYmdoK0dC?=
 =?utf-8?B?NE40Y212eG1aWE5WZCtPRkJVZGVvSnVrZEpPNTFRczluc1lZTnl1dyt1d3BF?=
 =?utf-8?Q?FA7C/M3ffYPInDrN6AljH1t09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2880a42a-f3c5-4c57-6a23-08db35167e12
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 14:11:32.5677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7y2M5uaK7IIP6LXEhPaSKxAoRTgjPYiTVLS3l4CkdGO+RD8V91M2TreE8Kw7slYcXneDiNCgN+MBC8LnqoMvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935
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

If we keep the BO in the GTT domain, it means it will not be updated if 
we validate it again later in kfd_mem_dmamap_dmabuf. This means we'll 
use stale DMA addresses when we update the page tables after evictions.

I think we'll need to find a different way to avoid triggering the 
eviction fence on the original BO when changing the placement of the 
DMABuf import here. If you need help brainstorming here, please share a 
backtrace from the eviction generated with the debug_evictions module param.

Regards,
   Felix


Am 2023-04-03 um 13:59 schrieb Eric Huang:
> dmabuf is allocated/mapped as GTT domain, when dma-unmapping dmabuf
> changing placement to CPU will trigger memory eviction after calling
> ttm_bo_validate, and the eviction will cause performance drop.
> Keeping the correct domain will solve the issue.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a3b09edfd1bf..17b708acb447 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -642,7 +642,7 @@ kfd_mem_dmaunmap_dmabuf(struct kfd_mem_attachment *attachment)
>   	struct ttm_operation_ctx ctx = {.interruptible = true};
>   	struct amdgpu_bo *bo = attachment->bo_va->base.bo;
>   
> -	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
> +	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
>   	ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>   }
>   
