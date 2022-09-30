Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD8DC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 14:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 671AB10ED44;
	Fri, 30 Sep 2022 14:54:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1976710ED44
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 14:54:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQbCBHu3Vj7tfg9OJ7M91bsZYatDQ0crkgp30MuRY2Fu3I+I/Sb/hyoMOrOOkC64XeNf6AFivZ7msrdNXuk6ZKufeAIayWsm1vNSbQkmBurgABau0jjcmwlU8ARGOF9N2SZAu/nROyou9tpZHAhMkrcHRJpG+Xsyi8wN442tpDH8UnTL/pcxpFhsAkYRls57ono+qO42ebn9i79Qcbfuyce1tmUwwbWdEB+IQhGOoS1E0seoBVl9cAMDBoYF0qlD3ZVD/wuda/YrgpMS0qoWttKPRy6XFABcKHLLQrqYnKI5xTiS1UyHIiB61mBm+sOeGIPg3O5bg5DPrZZ+btu7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuPtkaa6Gk0G8hmXEt26rVJPhS/KEBG0AdzDkyZEheA=;
 b=GqVNLn9BlK4vbZTn9E575WHLwoQoqjUjkSiaWjAUqZVyIMoo+tLbl+LvdW9MqDzl7aXBMzRJROZei32cQTZBEC0wN0HyxyrSalxHcVc94Z4An6iYtMxxkPLv+itahzWqjdx5O2EQt+E+jAtu/TogDH/8Ym/dCa/3pP6MnsoCztqJjwK9X+kZzLQ+oP8amF1bql3zSzkRHefUJ0EM7eMoEjYAUenzoOzdU5RzERb987XQaVS2oygye+Dl7hQoeqTuSPWsCOM+I+doRkOZCVMEf29ScBFNPMevRB5xUxmmw4176yavz1t7NS51tI4ij8z8Cgor2fMC4bQxk113snAKNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuPtkaa6Gk0G8hmXEt26rVJPhS/KEBG0AdzDkyZEheA=;
 b=T6NwDyEecJeQXfYLMlBPvZoREeMu0JYr0MjYWAjC43wRkb5zGGelzfLyDih3LVmwMkiWzrbXiy8qH91B0r6HRXjZ92jqI2VmV25TZfsL0wwyfkTxtaQ5Yij7fk31vhEU2SyKNQawgDv/+/YOdXNuer9yO+cajdIaFii6VJJN6G0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Fri, 30 Sep
 2022 14:54:34 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 14:54:34 +0000
Message-ID: <94456547-cc0d-31f8-602f-3ddeb2627149@amd.com>
Date: Fri, 30 Sep 2022 10:54:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] drm/amdkfd: correct RB_SIZE in SDMA0_QUEUE0_RB_CNTL
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220930061634.1531705-1-yifan1.zhang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220930061634.1531705-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: 327afa88-0074-4acd-a171-08daa2f3b03c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PNPEN7nPff/FwqqhpavBZPTWusi1SR48gHLWvwDNso6ZdSIqRpxKYp753qEVjCz8ifMlrQFPkoK3/jHv8lo6AyqwM8arQ2EFefk7iiEIMVi2zE87m17SPNGk1G1o1xspG9uhJm6so7hxuYcYYZC2LrhvW58THRrOPRrPX3WZIMdUeEwhPEBY+/cBUNpP5vpxZ+VGZJvOlLXAB3SKexmLsTM7iTB+MLIVDEv06qkC8Frz/3kEQxK5+LE/hhyFvop9SDst+Vbg+SJZ2VHr3UYY7QfdR7YDEQuXvd5J0CTREzpdmdnKHm/Du0edWZuLttYOwi68ZW+Q2VIJP0m32EGYtpHbpgUJTJ/r5gHLH7hnQXiW4dOH9LZw143iAR0SZpt1Bt0MoyPfmL37nV4IpCSG1vr7xlOo1enb8MsmLO21PxtgVhyc2PSl69mw7xqRW84M78w8/v88mivvX3ZyYj2mcZInYHxgOVf7g4tGMZYymJu0fffBg4s5DbyedXS6tTzaDvpsaa6UEbbYmkTCzrEz9wpYSB8T0Bf9Egb6Rn2LofUz3B8ZLbaiNi1hUIGPfKvWLSXqROiZArZG2woX0v9BSfnmmv4DnGlY1nwo9+x6to9RIcvO1ZviBTcvOJYB2+0Hjw2G1uokgHxJTRscpOoeuv7b32G/ac1zGarzJxjarBpEahx31g4ITrebyD+Slp8/xjOyJxi5aOSmH93aA6sjx06LzQ9QFWO1SzD7S8Hm4ObToyf8eWCSFGHGLIaoqxzqJIfIjc4eEuI5FlbziWcJsP1EvSyUhpwzyFVpJ9v2/jM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199015)(38100700002)(6512007)(6506007)(36756003)(26005)(186003)(5660300002)(8936002)(66556008)(41300700001)(66476007)(66946007)(8676002)(4326008)(31696002)(44832011)(2906002)(2616005)(86362001)(6486002)(31686004)(316002)(478600001)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVZRVlVPc3QwZStibzludVJJUHkvS01acmVGY0NETjdBSmxlNzlXOEVCaTNS?=
 =?utf-8?B?OEl1aVVLRjNVY1FHRFZDNk5RT0NJLzNWcmVVRlVaT2I0a2FWaFFZRWM5OStp?=
 =?utf-8?B?Qi9CNVNJcTgrV0pPdGdtSFNqbG5vY2t0cTJROStBZEFqcVh0ZmFvN1RnM3NH?=
 =?utf-8?B?OEpHMEhZdjhWOXg5c0wrYUQ3Uy9qV3R1NjJvc09raDZ1WFRodHZvTFJhMjZN?=
 =?utf-8?B?QUkzbEs3bURLcUhRZWdUTlZDWit3UEIxYXZkbWk5Q1VES2RwTEF6cXhocDFT?=
 =?utf-8?B?am9ScjhFZXpDQlFIMVI3d01ueElvWUxYZnVXY1RNcTBJaCtPamNDMXJIYlZo?=
 =?utf-8?B?eHhpTWJ5aklTenpBSzVZTjNuQm8xZ052Ty9EK1NRQkFJM2ZvQkEzTkMxQkI1?=
 =?utf-8?B?NkV4RWNiWHp4T09Wd0kyaC9WeWlZSCtoQlRKRWs0YUpTeGcvNjBBV1BhZXM4?=
 =?utf-8?B?YmYxcWRmek5EMFlBQmF2ZkxMbWhzbEt6TE9Qak5xVVpoaXFISVdkVzU3T0lP?=
 =?utf-8?B?dFh5bkt4RmJiNWVqdnI4dzdHYXV1aVRtekxESUJJQjNKY3lPWDNkVHVHbEJV?=
 =?utf-8?B?a3JCSkZGVE91Mjl5UmM2UXdrOXprUm0ramhCTzNJMS8xYkxxV0cxTmpQTlc4?=
 =?utf-8?B?MWIrU1liN2RWNGF6ejIrc3FFVzNFOERjWkR5YTBRSUdoRTcva2RDZ2VIemFK?=
 =?utf-8?B?M05vUC9iRzdhbWNlbHpNUWZMS3plcy83aVE0aVdrNjhkZExPellqaW1kNXNK?=
 =?utf-8?B?MzB6cXhjNU5mUExMVkVkR05UM0Y2NWdWWGprZjN3Q1lPY1M0UDltTHlMOHlF?=
 =?utf-8?B?bExvWlJBbERPeFlqNUUyVUx6eXhvSzJNbGg3bGJ6T3BMOGRiN2pKR0EwSkY1?=
 =?utf-8?B?MXQrNTZlU1YvVjA2NWI4REZkS2dQUHlsdlVmSmNZT29YSW9MUDhqRUYyR3Bq?=
 =?utf-8?B?dVhXdmNvY3JTb1o3SlBNakRYd200MkhUL2pubXEySzNkTUY1UjlMUjBOR2RY?=
 =?utf-8?B?R3VRTVRJdnh0cHNCOWhRRW1LenM1cGxMWXB3UkpLZUsxZTluRzR2U1VOS2hm?=
 =?utf-8?B?bXAyZ005U0lkSkdnT2dmWEF1TVF3UXlwY1dZazdPVlUxVkY3N0VqbGpXYUFt?=
 =?utf-8?B?R3Q3Q0p5RHY4TW1FQ0QxS0J6cFRyZDVYNXRUb0pFSkdYbHhmUFhYRmR2b25n?=
 =?utf-8?B?Ykdla3JDcTFIRGUwWlBnR2lwSjAwNElEOXdiWklzeHV5NHZCRzlYT2NFQ2Jr?=
 =?utf-8?B?NGw1R0lldTBaQXcva0xESHZ2cDlURnVXT25rNExlRU5KVERNWmFWQlFqRHpo?=
 =?utf-8?B?KzhQN2hmbk85dUxncmpjR3N3WEgzSWxnK2dRUHBsVktQNkQxekZyeDJ1MGpH?=
 =?utf-8?B?OEtmM09XWG0vNUJGNk0rbzVNWnMwTHNFVzlhdVVPUmhhNlJiaEg0S0FaUldw?=
 =?utf-8?B?dExZNkZmcFR2eXY0TVk5RzBkREZILzRuSWR1d1lRZ2F3bkloQTd0MlE5ZWJU?=
 =?utf-8?B?Z1lrdnBxdTN1R2NDRW9kZlUrV1QzcW5jZUJaNXRZdEptdHFubWUwdVMzdHBl?=
 =?utf-8?B?ODBJZGVYeFlFTGFob1MwT2JjaWMzTUxvSVJpM2tXRU1FU0tURTVYUXJWVDJQ?=
 =?utf-8?B?TXlMRnBiazZ5L0prakVRTWpLRlM1ZTRkdjVDQ0VOaWUxVTFTTUZVeW54Mmlv?=
 =?utf-8?B?dE83bjQ4ZzExcHdFZVZJVEdjSnBhb0Q1KzR6T0ZuMjEzWEFlWmhmeXNnZXFV?=
 =?utf-8?B?SzZldWNROE5QSXRGajJaeUlvWlZkNEJHNWIrd1JJc3J6OFVtTURJMCtoYmVy?=
 =?utf-8?B?OVJOR0ZxYnFHam9kVXJUYXhob1R1OHE5c2M4d0k5MDJaWHZUUFlESlBHbFZQ?=
 =?utf-8?B?QlQzM2p2OS9rQzVQUEtWQXRaUFo0ZHdaZXFYNkI1ZFF1T0tHNDE2cnVlREF3?=
 =?utf-8?B?NEhaWmNYNlkyK3FmOG5BamFOUjNHdG9JckxpVUNkSzZDcVZlMk9qZlJRNiti?=
 =?utf-8?B?UEEzeks3STBoL1lma1RyWlpWTWVzb3JwOWlyc3poYXFXUnVWZ0pDYXdXSTU1?=
 =?utf-8?B?RHNQZVNySTdpQlRMd0htZWZ5M2duMitqUDdJSzI3QXdqZzBGMTI1bDNBM01C?=
 =?utf-8?Q?VK+qvuBLGdUYYryUweZMx7uGr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327afa88-0074-4acd-a171-08daa2f3b03c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 14:54:34.5112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TH8jioSkY51nv/G9/WHo/aLfYUQBLf41iCSh8874na3BuZdnRsZ/MLGigREErrjL1p0p9dAlk6u/P1H+jRu9YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254
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
Cc: Alexander.Deucher@amd.com, ruiliji2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-09-30 um 02:16 schrieb Yifan Zhang:
> In SDMA0_QUEUE0_RB_CNTL, queue size is 2^RB_SIZE, not 2^(RB_SIZE +1).
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index d3e2b6a599a4..03699a9ad3d9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -329,7 +329,7 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>   	struct v10_sdma_mqd *m;
>   
>   	m = get_sdma_mqd(mqd);
> -	m->sdmax_rlcx_rb_cntl = (ffs(q->queue_size / sizeof(unsigned int)) - 1)
> +	m->sdmax_rlcx_rb_cntl = order_base_2(q->queue_size / 4)

I think these two are equivalent. ffs(1) == 1. order_base_2(1) == 0. 
You're not correcting anything. You're just writing it differently.

Regards,
   Felix


>   		<< SDMA0_RLC0_RB_CNTL__RB_SIZE__SHIFT |
>   		q->vmid << SDMA0_RLC0_RB_CNTL__RB_VMID__SHIFT |
>   		1 << SDMA0_RLC0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT |
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index 26b53b6d673e..451fcb9bb051 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -329,7 +329,7 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>   	struct v11_sdma_mqd *m;
>   
>   	m = get_sdma_mqd(mqd);
> -	m->sdmax_rlcx_rb_cntl = (ffs(q->queue_size / sizeof(unsigned int)) - 1)
> +	m->sdmax_rlcx_rb_cntl = order_base_2(q->queue_size / 4)
>   		<< SDMA0_QUEUE0_RB_CNTL__RB_SIZE__SHIFT |
>   		q->vmid << SDMA0_QUEUE0_RB_CNTL__RB_VMID__SHIFT |
>   		1 << SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT |
