Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCB9C35274
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 18:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0712E10E696;
	Thu, 21 Dec 2023 18:00:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A3AF10E696
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 18:00:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8M8TcU4fZ414KmziXeMpztanbSMXK6/e1DkxIocVU7agDOFm6RK5kDOnoX7ZPz9YLzNH9uK5PGgtQl4RAV5Yr2gxJhdMQOE4rBMigDQhTEcz5k/pK03pXa70FgoO1qVm85L9/2WBuEmY0PSNNtkaK4sGsfGemNAQqmkx1tN5+HaJIr3qCZnBj2nus8OKMWNbb7AQcr0DYL5RowWjIJYWxXu95JEgGkXWHj64PaRiAB3r2IBbKZMuVCwRZWEG0ZwvyfOQl1U+TaKjfglKW7Ox+fBtSygPONME02Ygiho6lQRsTXP+SBne5L7SqqUXwxc0RwvadqYG1zjEsRca5Jh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48LalAqTvf69HxKIlt7Ge7972oWdgTAPY0am9DlhYYI=;
 b=RcohnkpGcUYZNcitQCr19gqOPxzG5FUKqOxvrsYSAishz2TDLPsqYIP6E22aEGTRW01um7VrMDcTQw4fBVGnKIxJW+pPVgUGnZkM1KJi0Qn8W2cMJeKm50HavZllcOfjd5to1+/YvNEQRY7O/v1dt7D+m/c2c8eOjoqDS/JSawi21J61JOjDSVidzfLu2JqeSsQf2EniuH1lW13yWgwepPYGvJYsThOVvI3TrDgaqiOhymfT0644taIVhs/iFKy9YPanKMK6ctH8b3fcPgmCqP+EaWcXx4cB0xMgp1i3UEiXsmT4YtB3Jd0duBElV6Lmcr1xrHMOR/muFkvw0L3niw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48LalAqTvf69HxKIlt7Ge7972oWdgTAPY0am9DlhYYI=;
 b=OCqbGnf6xOatqkN5iFefDvy95gUpvQ949bR4c/TDW+z+76yX/8+6sPvS5zZBF+z0DrutrE/NzKLTMQ56Vn5o6tZa8am3p4wHA5kDeM9+EBqm8Q7shY7AfvJFiqHUiezlqhQ3xoccYdUQ6MI8hNsX5CRcbDUldYet+4mGUb1V2oA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6825.namprd12.prod.outlook.com (2603:10b6:303:20d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 18:00:35 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 18:00:35 +0000
Message-ID: <257cfdd8-17ea-44ef-bd41-fb2f03232e76@amd.com>
Date: Thu, 21 Dec 2023 13:00:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix type of 'dbg_flags' in 'struct
 kfd_process'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
References: <20231221173949.1403999-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231221173949.1403999-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d878289-a839-46bc-0459-08dc024ebb18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EnS9/B8Z0k7UEF2RyVWwP6GjRMdwrTyG21DVvQYAyilxCD9Z7FselOVrBAnEm1m+x4DOVW9aHI1y/Cd4Aebw6UdOhOYJrPa8SrvPBM8r64kfznWhxFp0D/jyEd2V3eH471YVf6lsltQCWgTLtqQ4Xme9TAalcwwGAsce/gz3Oxki1LNYCOWdWMj7BU1OPbCV3mnO5nLEywk90RPKMqLJ30nMt8UGd7bRqY+STF7zB52hs/sQxiESconm5kDWeGOKDOY355VDFqN54Svf3jDWEQbQjclx0jmyT9XOHoc72LNVvUvpLHc5/9zL+Qiyi9sGXVhiiYTiWjRwHvIf8TF1lyrJLDf/FMO2/EjmIEkXl3iiQsHGDy0vfOK3yuGB8SodJCALFCuUg2Y5rGXy6MsAnXGGkairKy+rgS/1wB8Iun6fGH9hSOFwub9IMBZKR8H4hIFJTk4KTeXztpEw7gUhhjBEF/8jXzBcDs0WhXwe/o2LyFCJRboXREkhZ2EgiNqF7Dc93vwV+GYMJjhK5UgRt5bLmQ2BoHr/9Ur5byNGSgD1PBRpN9gznLi9GpiR+m+SFL2tKpA+lXGZlUD4r5MBQmAqjDt8BMp8LVISegGgOgUqil7vNCBcdWosEitlTVhq+J4ILxCSvzS2+f3f4yRRsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6486002)(2616005)(53546011)(5660300002)(26005)(6636002)(316002)(66574015)(6506007)(31686004)(6512007)(110136005)(83380400001)(66946007)(66476007)(36916002)(66556008)(478600001)(8676002)(8936002)(4326008)(2906002)(4001150100001)(86362001)(38100700002)(41300700001)(44832011)(31696002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzVkKzI1d25FKysraFpkL015a1NDbU5JcXR3Z3RDVDVRa3BzMmVJb2Q0NEFQ?=
 =?utf-8?B?TWJJdmY5RVY5TVRpVHh1ZzZtQXo5UUZMYVd3cjBkQTFKQ3BQUVlXVlROd2dM?=
 =?utf-8?B?RWdYOXp6N0t2eEo5OThiYjM0b2V1cUZPTWZxbWxOYWNsTUlUYTVTSGNvWE9y?=
 =?utf-8?B?TG1RQkgwSXBCUVRkZXJSTjZtdzBueTZSYy9HSXYrZGs0Vkp4NUpSZmVlYkFG?=
 =?utf-8?B?aTFGeENmazhkOFJoWDdaVXQwcTE2T1FRZEk3R0E3TWZtRWZaZzg4RTNoQlVl?=
 =?utf-8?B?b0wrWXZtditxb0V0ZHBqM3kxNVhUeGdBYml6L3Z3aytPVFM0NGkvczJYQ3pL?=
 =?utf-8?B?Yng3YU1QdWhKRk5FSTJzZnRjdjB1OERwWVJSTVMza2RGRXNvWDJPVFBZT2VJ?=
 =?utf-8?B?T214N2hsSEwxczROelM2elEzWm9pcnFncEltd0tYTVZ6UUNsSlBPMUR2bzdh?=
 =?utf-8?B?MUsxU1ljWC9sQjRNMlZwODZyRENpazJNRHR2Y2h0YXpsTlJ4TktXU3JCVzZS?=
 =?utf-8?B?WDlueVJvZHprR3ZDMnlrdFVTME1MMktGV1pCcTJqTzdseUNTV0JxZHVnNmQ1?=
 =?utf-8?B?NjRwbUVJbXE3N01yL2cwMlVZaTh4cEhJOW9IVGNtZmxLM2NWdU12K24rN2R5?=
 =?utf-8?B?QWdOdWJoREdrdDg1WGkwckhsSDFhNHpCeTEzby9GU2czNytROHZhOWNLU1My?=
 =?utf-8?B?NGF3WU9ydzB5eEpJYUJDQ2hnN0Nnd1BuKy9IR3BYdUVBMVl3T213MlVMcUlk?=
 =?utf-8?B?WW03RXM3ZFgvQ1RxeHQwaVg3dnJYTmRhU2lvY2ZtaXVYckpBUGpZSHh2L1ly?=
 =?utf-8?B?RW1JSEI4NjZ6TzYxcnMrTDM4N2orVi9hMFR0a1lRUUp4SW1QN25DZ1RlRCs5?=
 =?utf-8?B?d3JvamhjTDd4b0RyWTArQTd0S2ZWVElySy9qMVZkeCtoV2JpR2Z2T1FDY0ow?=
 =?utf-8?B?MnVlYnlNQ0RsZ3FZejRhWklvSkNGNmZlMGExWjVmV2JpbXh4VzluR3NaajN3?=
 =?utf-8?B?VUd5cVpUUmRWQVZjRysrbXJpTU1TQncrZEZIL0JXNGRIaUF6YnE1aVlTclor?=
 =?utf-8?B?Q0lycDF1NG5zUjV3aURMc3VOdzg1dzcxajNRcVAyaW96eHYwRU9YRWp4bWFC?=
 =?utf-8?B?Vk9pSjArNmQzbzdwVytYMFp0aVlMZkJsbDN0OTVIQm5iNFY5enRmZytlZ0c2?=
 =?utf-8?B?SWRwWkRXTldDL2lMMzRkYlNHNmo3b1A1NmdlM29sKzFJc3cxcUJsV0pxWG9s?=
 =?utf-8?B?NHk0ZThmR3RSWUpTeTB2K2l0UGNVMmVlbHhpc2VKd3RnVVk1T3hHME5vc09D?=
 =?utf-8?B?cUpzZHBZai8zdHNDV242WWdJbitGNVBIOXF3Tlo4K1FhU1J4TEgvSXVFaStp?=
 =?utf-8?B?eFkyUnFIOU4yVXJHZC9jZ1BxQ1d5NzF2ZVhBZUh3R04zb1JPaWp1VzBqZW8z?=
 =?utf-8?B?SlJGV0xDbVVGTkxpVUNZTFRrV1VicU50MTFxK2FHY0ZXNCtjUkNiNHd3Kzhm?=
 =?utf-8?B?c0Z2YmlYdWJGRWd4cGZWVlJSTjU3Yk5yQXFnaU40YjdDUVpkdGhrUExUajRh?=
 =?utf-8?B?Q1U0S053NnFHTjdFTmg3eHdzVm1YRllOSHd3ZHVFY2NFSTdVUEJYazFtc1Zu?=
 =?utf-8?B?V1ZXeVBJdjU2bURMRUdDRjBmeStpeVN5c1piQzlGZkpCb2tCZFpyampVUndi?=
 =?utf-8?B?cjQ4U2dKWHNJNzVNdFprenE0NnRrdFpRYkVBcVZhVEQ2NTd5cVF0QjBscnFj?=
 =?utf-8?B?dXY3dmprM1QzenhRMFhHTVpwOFZrc0tCZTNhYWlVcjhkWTJHUXcvUTU4MjVJ?=
 =?utf-8?B?SlVRaFlRZnN0SlI4V2NjTHdEdGNLeW5BWklvQS9iVHJWWWJ5T0t5OGxNOVZH?=
 =?utf-8?B?OURpcVg2dHFkbjRiVnYxK0dtd2NtY3pNa0ZzYUdkcXJuaFZPaEloYlphUEtD?=
 =?utf-8?B?S2hjUnd1SksyTmJaTEhwMGFkS0puNk9CS0RrZEsxSlR3cDBodnVsT25PYzQr?=
 =?utf-8?B?bmhVRFg2QUlNS0g0OXdnbDJJb1RvTnlhRE94MURYRys4NStzdzVKcE82NVJH?=
 =?utf-8?B?Sy9lVjF3Y3JteWdXb2lLTlA5cnpHcTlKZTRoL1Yvc3lMbkZCSWQ2QXliMG5K?=
 =?utf-8?Q?Wgrcps8D60uLPAKEncN5r8/ic?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d878289-a839-46bc-0459-08dc024ebb18
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 18:00:35.1196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPKzwi+E+LWklZKerhNkM9+pMYm4jbds3NurSeZFkF/92iOWKTaduVKTFlZ9Y9a40iBd9yBOp2MmWe4iFuiLAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-12-21 12:39, Srinivasan Shanmugam wrote:
> dbg_flags looks to be defined with incorrect data type; to process
> multiple debug flag options, and hence defined dbg_flags as u32.
>
> Fixes the below:
>
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_packet_manager_v9.c:117 pm_map_process_aldebaran() warn: maybe use && instead of &

Please add a Fixes-tag:

Fixes: 0de4ec9a0353 ("drm/amdgpu: prepare map process for multi-process 
debug devices")


>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 45366b4ca976..745024b31340 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -970,7 +970,7 @@ struct kfd_process {
>   	struct work_struct debug_event_workarea;
>   
>   	/* Tracks debug per-vmid request for debug flags */
> -	bool dbg_flags;
> +	u32 dbg_flags;

For consistency with the rest of this header file, I'd prefer we use 
uint32_t here. Other than that, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>   
>   	atomic_t poison;
>   	/* Queues are in paused stated because we are in the process of doing a CRIU checkpoint */
