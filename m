Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BB0C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 05:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70C1B10E659;
	Tue,  8 Feb 2022 05:30:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C077910E658
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 05:30:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QN5gdX2gtwqxrUkakvezwcdqcmhmKHRF7nR2R9Qy0YhYTa5XxDcXUxIGFS22AP3+mxI76FdrsXtgQNDAo+g5I+GFdBL4H2h3f25RoiyhukhxgbniqQLMGLK5g6oZe6oHHvY6p0UmyfiutS94mh6u9LK3No3IHT2I8zxTN8HQYsNfFirmyaavDdl0Y1j/2akE7q73l6wqvAZVLvxBx5s7zgJLrFajd0qrtu8KLZtHIfiUeRZ3Nd2vL+day3/y5RLCTj1KmTYm9nz67EtQlFlnEu23xYsTC879UQZCrMH4STwXab2FEBeCKCz5h8hsNgRMje1YoOorua7CpCBUdYLWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2VPQByQ2neShF+4/ipUh1GrC1zgy4MZJoWvOwUSwbQ=;
 b=QNnnr3ElH8uLuKkMD76an5aeHBfc+XT9E0+T9visbZcNsUV9wkSdCXoVANNmXYjm9QHLXWPEglILrAwssZXwMr7wpJtKBIEdWtb7magMGCPFjQQ5pAC/L5/pRBEI8Th2p3+otU/nzHNfHKuUao0ma5XZdZNzjF6L8mlX97s4S4TKXYoa3X7Mgss25Q6bztRfs+yOv2EeYvgHxUcB1VKvpsakhnjt5Uz/dDH0USqebgxLkd5t4GYQn0U8jAC8gTrgvirOU9IHNfZEeQHjAZNOOJbRz3Ic/kq5o1ouQ1fqR+wwmBvIzVCRWBZK9CPeQ/BxYjR5xQLy1+9JHx4lf0CD8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2VPQByQ2neShF+4/ipUh1GrC1zgy4MZJoWvOwUSwbQ=;
 b=q6o5llqLZ0S9wsTd5J7O8Kz3PfplxWj6dCHpq/FFHQFX6rk3AqYP6l4rP046Ik/+CpJbrJIsLHOeOiP5WBro0ojPgOyW7upcTiF0fNpLriHx+flL95+DiM5xuD3VH+/x5RMcTMsonmRfgTGclfNMJmUCfBVpsEvY5xGUJazTByw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BY5PR12MB3762.namprd12.prod.outlook.com (2603:10b6:a03:196::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 05:30:01 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d0d1:eba5:5729:c636]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d0d1:eba5:5729:c636%5]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 05:30:00 +0000
Message-ID: <841740d3-63fd-83bb-424d-a987a5a7420f@amd.com>
Date: Tue, 8 Feb 2022 10:59:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: disable GetPptLimit message in sriov mode
Content-Language: en-US
To: Yang Wang <KevinYang.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220208043027.127195-1-KevinYang.Wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220208043027.127195-1-KevinYang.Wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::14) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1a5c49b-94e1-4b5b-744c-08d9eac40cde
X-MS-TrafficTypeDiagnostic: BY5PR12MB3762:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3762219B31739436C6A632A5972D9@BY5PR12MB3762.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z4a9q9ocMnivcqr7lppdPoSUAvdQi8PkELx9kEK+bIVYIC0b9mpT4CTSnX4KgnIkMln7ePzIaGJkNgxOSN6aLRrt7mFGxZ9N2WHCI5f7HXXMdrIBpMTJABDYInwN4qX2cIrLpEdARaoH8Ad1/8F8lCg0v9ss8EdG0oJFmVvr+fu+YB3vQpklygZ+Ff9pGZr8QGmjkqVdPNfzY8Bg0I2capcB+ItYjQ2+kS11ix+RD+hroLK8dPfikRUw5q8zRiV/ZFwlYy6LUnauqD57iDFzlKaUu8ywfiAWWTnUmM6feZbaCDWkG81sk0bj2QZf+K4wLOVOhi/Vj0b4WWtrO5WcXXw+AbjbpLQ22sWBvFfNATmwrHpSoFMP98DQVb0l/YHziT38P5jTvCIG3FVwgjgJsTCRQ5GVHH7iKyuFfgzE3ZuIM+GqiHmjCxLLNzfr8OiM2cShOy2D0YZwziRJc7Z1Fq9/OoLxS8B7XE8n+TVBH+ryt0HxeJub3qklbHRuPJRf+7EeoxE5Y2Q5qN92o/aceBMg/6sOU1wrAiZOlOz9Zbozr0c2MtebdJIhD/5zn2psUC1P5R6stLzL2QZkeKqYhyq4CXu33i3DArpoZ0NBhYK7a9TH14+BVsSfuRCwhMk1K8VrdipTbsYuPLmOyXl9xXnrmkp3S+f7tPHWkubs/2tdzkXyOGr/sCvjZTAfi2PyxyQ4x0cC6kVylYilXKsBBwRPqMlKQ9yUXQhjbYL78XDUg7fdSE+hzXiA8ArXxq6I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(15650500001)(26005)(53546011)(186003)(2616005)(31686004)(36756003)(6506007)(83380400001)(6512007)(38100700002)(66476007)(66556008)(8676002)(8936002)(316002)(2906002)(508600001)(4326008)(6486002)(6666004)(66946007)(31696002)(86362001)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cldRelVZOEFQSXVLblB2eFhhZWpTUjV6elJWMEp5QWZuZUJPUmF1OW5HOFNZ?=
 =?utf-8?B?UEVQbzdZWFd6QlJnL1ZEdkl1TFp3S0hhWE5sbU9nWUwwYzVWUVlyYmJoSjFh?=
 =?utf-8?B?MFc5MHpSMldKRVVaOHJHQ3RhdnozL05hSWNFb2VXZ1NNbmFtTE9NZVg4MnNL?=
 =?utf-8?B?Ukd6aEVmclpVVjFJMHJzREhiR2xFRkViU0ZCYjluRFpzQjNyNno0UUE0d0xn?=
 =?utf-8?B?TGdxWXZyZ1k1dVMwWjFKUDZpY0E1U1MvMWVJd2RVekpXcEVsU0k4TGFINUQx?=
 =?utf-8?B?L3VKM0JNNC9YcGRXekVDTlJBSGZycXdIL0x3N0huRlFJVkJMdXU5ZEdFVk5B?=
 =?utf-8?B?bisvMTFXNWtYTXo3NkNVeGNiOFczSnNEVzlOM3p6Yk1uMHFMQnBPUGJ6M0tB?=
 =?utf-8?B?Y1JaY053eDNRKzlodFhJRVk5VkpSRGtJeWdHWGFlZHVpZFBmQmwwSmhOb2h6?=
 =?utf-8?B?WTFRTFB3SitBUVRTME1KYng3Q0NOakx1OHl5R2txaWxnMmVqbjV0c0lLYlo2?=
 =?utf-8?B?TCtiSnh4aXloYVpBN0g0eFhFdnNjaVBnNUhGWlo4dVMyY0lxdXhzK0h2UG9h?=
 =?utf-8?B?a2U4REVKR05tWDg4Tjc3bmtvQllVR2pQQW93cW5nb1JEcUZhMkdUanJORk5I?=
 =?utf-8?B?ME94aFRmVFpKbGdrOFBnVVdRVTIrY3NXLzZCM0hSaGlsa0dEQkdLbk9DRXFu?=
 =?utf-8?B?c0FxQUtPZmQrOC94b2p5TUk3bGhERExORjBENFJ6N1hIdklJSW5BanBlNWh3?=
 =?utf-8?B?VHFWd0NpWFp3a1dtZVNxWlcvbWV6ekRpU3NlUUxQbDViTzFFdmlJWDY5akM2?=
 =?utf-8?B?WXYyOHh5VXRHeElZb1BBNmFSTXNSckYreFJnNDFURW9Gd2R0NTVwTW44V1Zs?=
 =?utf-8?B?Q0tCWmFZOTZaRERiOE0zdkhLRXJTSnR1R2JSeFgrd0xzZTlyM21GREtDeXo2?=
 =?utf-8?B?dklwOTg0VVpMVTFiUis3REk0V3JMVUlhWk5hZ3VaVS9YZU9PNDFQUUc5OGdx?=
 =?utf-8?B?V3ZmS25EOU1tb2V3VEZBdG81UmVOYmdIc0hXbXUvdFpjUytvdzZQSEgzMFFU?=
 =?utf-8?B?VEJYeXBTcHRud0VaVnovd09oMU5FUUxVU0JUWmdSNkdyS0FtcU10YmF3bUI2?=
 =?utf-8?B?OFZJTWNpREZGUXpkaTNXejBjNmkrdGcraE1ZNlVjUFNWbWkwbUo0UkI2VzRO?=
 =?utf-8?B?WUFYMitITzkzSkFobXhXUTdkMThKRTM3bFBuVk4ycXg0MVlTU1J6OEtKTGky?=
 =?utf-8?B?a1JRMlpZc0RUT0RyU2pjMGdyYlFCM2EzL3o5amw0OTN0RkVKZWo0VFZId2RP?=
 =?utf-8?B?RWRwT0FZb3pjQXBPWVBleWtRSTFmRHZMUFNTMjhKRU9CODdKZzRCZFZKQ3RJ?=
 =?utf-8?B?aFcwNUNzdXpOUVpEWWtZbWpQcWpRa0tHUmhqNXZCaWNoamdjb2pZNVoydHFn?=
 =?utf-8?B?RUpqTm9zTklMWnVWc0tzcCs2WVArYUgxeWZxWVJ0Z1luUnJOVktIS2Mwalkw?=
 =?utf-8?B?YnNIT2FNVy9BblRWQUJ2amJmNWFTZFZ0MGxlQ3BvNzhzS3JIakRFR21MYSty?=
 =?utf-8?B?UTg4OFFZalRzTm1SUVNLd3RQbTZVUWhTaDlkdzJhQXF5WVRUeTlnK2xubHFm?=
 =?utf-8?B?dUZhaW84MGxZaHlYMEUzWlRSUS9SVDNydEFiMkR1Ry9vQnlMR2RCWjRpbzRq?=
 =?utf-8?B?Q003V3NuRHRaaTNnVFVRa2ZJMTA2Wlh1STd4KzlGZDJsdEZyVkQxWCtWTUdD?=
 =?utf-8?B?NnRkMWlJWE8rQWQzOHBlZHM4VXJQVWZZU3N4S0hIOVFLQWxQT0ExbHhXQUFC?=
 =?utf-8?B?S2NLZldoNzFURWxFVFM2dFFuWk9jTjNyTkwvVHM0Ky9oNituQ0lqOGdsYkww?=
 =?utf-8?B?TEcraUNSQmJldTl5MDNBdlIrU1JjS2tST2ErV294SGdzWElla3BQTlRHV3lV?=
 =?utf-8?B?MVpwYmFIKy92SmRzMUZaQk5yRWZoZk1uV2NBWU5Sa0lIVGVvU3MxM0tTWnY3?=
 =?utf-8?B?TFhaakI2akFSYnZlTDAxTWxPOFh0TG5Hejk0b3ZKVXhiNlJxenRVM0tQV0Iy?=
 =?utf-8?B?aysyWEkrY0NHbStoZVRPcm4xN3dnOVRQS0dicWpaaE00YjRvR1NMN1dKcWc4?=
 =?utf-8?Q?vyXo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a5c49b-94e1-4b5b-744c-08d9eac40cde
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 05:30:00.5342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cg9qKGMp5+rlbSLLlWQ9sypZdxi0JDWbU+VIzA3muB9CRTuCOVOKfuc78ZfMyaJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3762
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
Cc: Kenneth.feng@amd.com, Marina.Nikolic@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/8/2022 10:00 AM, Yang Wang wrote:
> the pmfw is not allowed GetPptLimit message in virtualzation mode.
> 

Maybe rephrase as - "PPT limit cannot be queried from VF".

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Fixes: 3e4a01689daa ("drm/amd/pm: Enable sysfs required by rocm-smi toolfor One VF mode")
> 
> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 804e1c98238d..2a7da2bad96a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -140,7 +140,7 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
>   	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload,         1),
>   	MSG_MAP(AllowGfxOff,			PPSMC_MSG_AllowGfxOff,                 0),
>   	MSG_MAP(DisallowGfxOff,			PPSMC_MSG_DisallowGfxOff,              0),
> -	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 1),
> +	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
>   	MSG_MAP(GetDcModeMaxDpmFreq,		PPSMC_MSG_GetDcModeMaxDpmFreq,         1),
>   	MSG_MAP(ExitBaco,			PPSMC_MSG_ExitBaco,                    0),
>   	MSG_MAP(PowerUpVcn,			PPSMC_MSG_PowerUpVcn,                  0),
> 
