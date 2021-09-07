Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A9AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 08:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D9A610FE
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 08:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 47D9A610FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D460989DC0;
	Tue,  7 Sep 2021 08:49:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A0F789DC0
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 08:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fz05XT4qfqIFzBIlPY/3/xUdJQxU/JkNJVasGnjrplp25TkLgTPD9nhTulxPVR4YcraX70PG/x7C0gAuyzRoQ5kheLzbNoTbfxzKXEc5YjvR8HZQLPBYF5TTha8Ubtfj3oaHnMR0JU3cnPJXKmXaa3fDh7T+G0brjhBFRGjKEwV9ah1QmxNyzpGIuUkM469jIixSv77D6zO8m7ktJ7oJA1TSYt5O0apFqqGHI0ScdepmM+fz0VYtHSlAT0jvc5yYNzZNIsV7NcMVpPnNn8R/vKuLw8tfY1NiD4R1plZ6SeMKQsYV5FoqxtIudwkSWm+WYtOKptQFO3iqQ/Ewislvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=JZDjld9lckrOvP5jW3XiyXyGNt6Iz+kx9rTGCXPs6ss=;
 b=nZgxbm9vIW1MltfY02SoX4Qb1Ioh8O+R7U7YXKbgyIwcjL0lm2D9LDDi24S7gQ68xAm+dDpoZsdGnWIMTa7hKlNJUkCDBo/KU/i9sM/MsIedVcoYv57LGhmOmDtYrK2C9OYzlV9MRYT9Vk1jNELkQuGs+VQ/MC7ljeCecuoqrAwOKOu1laTU/9MBbJEAt33ityqZbQ1D/eh5uOvFY1qrnckt4aD/6rcfflSizvMVXM6YTJHk6+lrC4lXSZukaY/Q931Uvy138DyujiUJkVdcCNZAufQjSo7cjdH9hlrnWD+usucpdvXt906CDN/PidiFmcxL4eMh0cLBsWZVNTVHcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZDjld9lckrOvP5jW3XiyXyGNt6Iz+kx9rTGCXPs6ss=;
 b=ewk5XMcCOCvSsXNBPGfkYJM9UI4ZWKHMiFT71w6xf6L99rMWUzplwGvIVIO9myhVp0pjFPu06MW4Rlp50LdMQIsxsfDlKyPUNpajDeFEgC8PXB6SKE5IQrv+3XCkOznK37rWtGlAkNU+o6OIOo69FFDkmpjzc8Oguc6IMVQbzXk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 08:49:35 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 08:49:34 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: fix use after free during BO move
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 michel@daenzer.net, amd-gfx@lists.freedesktop.org
References: <20210907081447.182532-1-christian.koenig@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <736477b1-6cb6-c849-3bdc-cdeed5a49dae@amd.com>
Date: Tue, 7 Sep 2021 10:49:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210907081447.182532-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR3P250CA0020.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:102:57::25) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f29:e200:a520:3631:3e0f:8bfc]
 (2003:c5:8f29:e200:a520:3631:3e0f:8bfc) by
 PR3P250CA0020.EURP250.PROD.OUTLOOK.COM (2603:10a6:102:57::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Tue, 7 Sep 2021 08:49:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5082ba3-3706-4768-cdf3-08d971dc6aa2
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5149833229EF5DDD4EFC77858BD39@DM4PR12MB5149.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H2fPRSx3cbcEbAcespBVXDC0OOjH/A4RbljsYLxYpCWjxZTpMHlm/ZA4J0oCMzndA6xB8za/nfkgpasTFacSSJPVnek7347olVdYbGq8WkLqVbFj8RvJsvVuCAq7VTLnoSUEHJJCgTrzBjeEtZqnwYt81x+VBDaqZso2cIjE9BFy3IcjWJo3WA+7vIgpGHOicexVfYbl1Sa3/2OLSFbEZ7ZOJeNQK51Ov/p6jcYhW2wadRiHQXJvwGVi+1su03MWi00AcRFflnk0r0DAIQBlxj7LLsnUyEC30H/nn2BffsWymsV+dQt0aqYoSbGARmB3EPJYjd3GN/RFUbotVhTqMCpaJm2NYmKJgqlnSqV12+OTSfbkLk7lYbF3dO5zLXjZMimbEB5ttKFrFTrGdpN9Z71VoFiHClOoORGaP+AMlHH69ZhhVRhuHZPoi0i+BLpF4Z9r9EhaCSfeXJ3PjKtk2h3hcVfbOLS/KkMfHkcJarh5Esoj3+9QYfdf1Oh+7TT86j9+sXM4dnafTSqCEPCeFsbxD/FHz+GgjpAGZMFHhTFxCKGjiE4srtV6gBDBTtFsYskEQP6O10zIYlNuU8e0+VkMuNO8AelCiQTw6MPb4RZREDuhxDaiq9bhMDCbsO2iJJVkoqaDrmtgvoeGlt3GCblDuPzQtzQsLbbJEjxRZWScPejkBfnXJtxf3HENqOcBeBgdZRznTcakFt/fP10mPZx+dWrV+XIOh0gDYgh8JmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(2906002)(38100700002)(6486002)(66946007)(86362001)(8936002)(5660300002)(52116002)(45080400002)(31696002)(66476007)(8676002)(66556008)(53546011)(478600001)(966005)(2616005)(83380400001)(36756003)(66574015)(31686004)(316002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T25WU1BQVE1mMVg1TEM5aFJWS1V2cGM4R1JTYXI2SjZMUmdJRGNrYmVDRmFO?=
 =?utf-8?B?d29LWVoxZ0VTaThCQ2Vob1NIRVZ4Tk4vbmI0akkzaWd2UVVScXlJNjVEcUZh?=
 =?utf-8?B?NjJwQ3BXVnN3YnhmQ2tqMlRGMlZ2QktxMTJuTmp4dmpiaWVtUStaWXFpNmNH?=
 =?utf-8?B?YlplYTU0bWUzRXNpSzVWZlVDcGNwOElSdXh3SVl6UXpPaDlUZmoyR0lGQTF3?=
 =?utf-8?B?dlJnVGdJRXNyZmdPRWF3ZENpaGFxUXplM3BabGgwdGFyenc1cGpxOWl3NHl4?=
 =?utf-8?B?Q2tKbmtsRG82MGtpRDNEU2Z2YkJoS0VsL1U4VDlzYXRRY0xQL1dUNWphTlNT?=
 =?utf-8?B?WlN3MUpKaExwa1U1bW44SDR0V1ZHcmJpZFY1bDlVTkwxcVN5NTZMOUFTRGZZ?=
 =?utf-8?B?dk5GMXRKTGx0SkIvR3JHaDcrNnpwR3JGeGdKZ1RuR3lyZ09jRTJJeS9mWWFC?=
 =?utf-8?B?M2dldHlPdi9ZMXVIYVJtNGErelhrYjY1SVBjNXpRYkJXZ0FoQklEVmdtY093?=
 =?utf-8?B?MFFkVU1pbS9tek5rUFR6U1JLazgwYjB4bWtvL2VYY0ZKY2NWSWNUSUlCSm9P?=
 =?utf-8?B?aHlSWHRwVHBwK2FYdUpBdmxuYy9FdlhRM0tkZ2VOdlUwTy9YK1RMbHFHUEN2?=
 =?utf-8?B?QVpra09OV1NYRU5EYXNEYzA1aWtBVDZURlBPUGUzVjkwRDR3aGxkbEZ4amFE?=
 =?utf-8?B?UzVKVTAyMFdyMzZ6ZC9GdWtFcnNwMkRlaWVzT3pvOTZGRGFOeWt0dmlLS09x?=
 =?utf-8?B?a3VVNDhyaldOZnZRZTluY2FEZ1BaQ2U5c0llYzZQejBDRmFMVjVtV2dEZ3By?=
 =?utf-8?B?bXJ2TDI3emczTXp6ei8vMVdYS29hQWpna29IaUdsaVRoVm8vQmNDakFlN1ZZ?=
 =?utf-8?B?QXA1WTM2NFRPL012QlRleFV5UGNTbXk3Y0RObUxQY1pULzdBOElEeUJmSkc4?=
 =?utf-8?B?d2p2V05nUVJkOHhEWWZKTGhwSHk2L1l2SldIVWRMMEgzM2w2RVE4TlF4VklL?=
 =?utf-8?B?NlVmWnFDeERlaXo0a01US0VVSXJ0a3NXdUJPSUFmRGhPaUJkcEVwRnR2endP?=
 =?utf-8?B?N0RFMTNIQnl0blBJT0t1eitiaTMyaXptNndvSk0yUDI5VUhQUkI5aHBVV2VU?=
 =?utf-8?B?WlBrSjVHd0R4TDgxSjNFOGtjZ0NkWGgvYTFoV2xWMEJ5ZTNnUWY3NnFwR1g1?=
 =?utf-8?B?TEFqbEFaR0tXQnYyK25WdG5FdTJudlBheVQ5SUZoRzQrNTBQRVFCSzR1NFc2?=
 =?utf-8?B?eThpQk5WVHRQQ1QrVUI4dVU0eVRoZzMrUGJBVW5ZYnhqQVg0Z25kYUV0eHVW?=
 =?utf-8?B?NWJwMkRHYVloeGJLVzdGeVBXM21IbHYyNUE1RDhmbERZYjZ5NTIxUUI0WGtS?=
 =?utf-8?B?ZWUybEdQTjROOHdRQnJuU0pnL3F0MW9Mb09TZ1JYWThWSmpabUQ1aWN5T3NL?=
 =?utf-8?B?aUViR1J3M1dMWmlXSGw1M0xlam9EaWFSNk5UUHJrUHhGZzMxNDF0UE00M3FJ?=
 =?utf-8?B?M1c3UStmZzNScFNtMnZZMlczcE4rYWIxaUJKQjc2TlN0cFdHbTFuemZaMW1a?=
 =?utf-8?B?amZOUm5EdG0ydTZ2WXErUVV4V2l0ZlkxcGI4V1BEcnFjMXFCR1hrWldEdksr?=
 =?utf-8?B?eHdrdE9RT21ITVRiWFhYU1cxYW1qUXpRdG1JU2lsWm9RdHhLSEFIMzQ4MWJR?=
 =?utf-8?B?V2hNZ0RXZEtxYVhYNG80dEhZSTB5amJFdzM2TnMwd3RCY2N6bUJ0SUlDZmpq?=
 =?utf-8?B?bHMzWTlocEtVY3JxTnd4dWNhNjRWbjRkazhrLzZ1cVEzNUNXdkNBTFZFOXFt?=
 =?utf-8?B?SHpVK1B0a2ZmNG1obklnVk04NER0ZDQ2QXJIbzBYaXRaUFFoTTVzVWNIckRL?=
 =?utf-8?Q?jp0P/1sWfXAIK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5082ba3-3706-4768-cdf3-08d971dc6aa2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 08:49:34.7056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paxIH0gOLIhpYXeWa7xKsrhNRW1KKJ+VSgN/6zMp46IfCkt+1iLgT7MAJEsk5d5inh1fLIudOEXS6yj8rk+aHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5149
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

  Acked-by: Nirmoy Das <nirmoy.das@amd.com> for the 1st patch and second 
patch is

Reviewed-by: Nirmoy Das <nirmoy.das@amd.com>


On 9/7/2021 10:14 AM, Christian König wrote:
> The memory backing old_mem is already freed at that point, move the
> check a bit more up.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Fixes: bfa3357ef9ab ("drm/ttm: allocate resource object instead of embedding it v2")
> Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1699&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7Ce76c4a0ac29e480fcf7108d971d79344%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637665992971099794%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=JttDenpA2ZII0Ttktn3HMVodWWU0kJoPVPvQ3%2BnN4sw%3D&amp;reserved=0
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 446943e32e3e..e2896ac2c9ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -513,6 +513,15 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   		goto out;
>   	}
>   
> +	if (bo->type == ttm_bo_type_device &&
> +	    new_mem->mem_type == TTM_PL_VRAM &&
> +	    old_mem->mem_type != TTM_PL_VRAM) {
> +		/* amdgpu_bo_fault_reserve_notify will re-set this if the CPU
> +		 * accesses the BO after it's moved.
> +		 */
> +		abo->flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> +	}
> +
>   	if (adev->mman.buffer_funcs_enabled) {
>   		if (((old_mem->mem_type == TTM_PL_SYSTEM &&
>   		      new_mem->mem_type == TTM_PL_VRAM) ||
> @@ -543,15 +552,6 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   			return r;
>   	}
>   
> -	if (bo->type == ttm_bo_type_device &&
> -	    new_mem->mem_type == TTM_PL_VRAM &&
> -	    old_mem->mem_type != TTM_PL_VRAM) {
> -		/* amdgpu_bo_fault_reserve_notify will re-set this if the CPU
> -		 * accesses the BO after it's moved.
> -		 */
> -		abo->flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> -	}
> -
>   out:
>   	/* update statistics */
>   	atomic64_add(bo->base.size, &adev->num_bytes_moved);
