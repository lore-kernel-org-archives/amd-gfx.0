Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94C4C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 04:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B8410E477;
	Wed, 31 May 2023 04:52:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C35210E477
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 04:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUb5p5rHzcro7vJFc81KuvR4jvSW+vW/nfnw5E568BXWouOZKE7/YSzHgp2XSNWImUAehD02tkYDMCIpAebZAHewEfrqjz27EnrqvDAdx9mRhThi7h4fUV5Uwc7fNLaqHI8uu0bfTgWQhFbasjrelrGZTVpfoH5knA7+ksk/6avf2UOMsR7M7fly+sH+1mBZh9o3QQKuF7gtrLKnBYldD2euheiD+OVQNGt2C+HrXPxS5w22VaozwSGf69vhvGW1dorUjfmO9QC8QehJVQVmg9t/yC+KyYCUe9q0MAjnKX/0gHjd3Xs+NDCzubXRq4EquGboCKc+X2o5cXpACT0a/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEMlN9W1WYO+TZxNDTvXGdkMuQUVNBW3bHpuYdYHm90=;
 b=Ouo6/rVJwAmIsg3xgHitZmzptokVaDhVHgHNeLXEwRf65/EntvQFHogn/Q7gz+MiGWXbhmFjBtx91uSiupS+Li8TMFLygZKYDporOw+ADRhJBvI5jQLMQq5rbdn72YX/MDRuqtJOh641EIQBxOqrUFIuGUMp5YVd0ax/FXJMbZZfmSVUXbyOgypuQB5dLdvZAzfZ89OkTVaRbi/Y4fV7QUeI8uSQMqvv/IyXO4sbQ0r5dLnDJHVJAjR/ODUpgY1IUddORb/PcsJTCD7rzXSRxZ5guwemNqm9fEKEj4UiwlUaTycT6gYYFixIVjoLqtz35NiPxa8abS/our8PIMAJsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEMlN9W1WYO+TZxNDTvXGdkMuQUVNBW3bHpuYdYHm90=;
 b=BosqvxsF7EjUrwNRTj5M9SoOvH1uaBYkwRf/jaGffGP7i1fCqCjXBSroetA4rO8B9q94adXMeZ5ecIiuuoz/yDr+SpcHliS8yGSwxrpjvxmYA4DFkNMM/bKXG7Dckr07aaJlxhthD+gGpHkrx3TfV1l9jO2JVF3KZkB7aj/MalY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 04:52:53 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da%5]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 04:52:53 +0000
Message-ID: <512a57de-ff51-c75c-fe0c-99dabc301a62@amd.com>
Date: Wed, 31 May 2023 00:52:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix MEC pipe interrupt enablement
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230529135813.566730-1-lijo.lazar@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230529135813.566730-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::10) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: ef81fe2a-2b44-4beb-0226-08db6192e467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FifSBGUk6y10/OpeAZZnpYoNpHK+RI7LRpUY/rEaRt32dThfr0Fc+ioYfvddXEPIks/xMUHfl/xUZUnJoAH0SPm/3nC6jbShX50Zh6btvcw6tXq+Lno5fO35yJ71//oa5SYpWf1GKNLoWJibSbt2WsFAgJStwhqN7/+OoexJRuqaDvrzClMuDCwQ2SNU+9fZuRZj4erj3SzFUT79SR+YAy7gxMpYxdr3NCkoXf1khIzJ7vqOKJkubalz9SYCFOldOupcMw7nbEUHwpHagtzQby6zu5czRK1kKT/tjkYnDP+V2zdHBrDCwe2CtHmEEkMGr/0ZQJNeH+m0AjQuMQanKztQxs4AAkxYSp1A632ZMCAjlPThENUkoKvxG0x6HyqKs1ErExOgy4orfb0Nyivbz6r6fX1Elpw2jOYu13+ClI+sWwi99+WbKb78PpIij5EBw3eh7uruxXmMga+k6f8/MW/3qcHKhFthD5kQJrnEW9XnoRx4eLU1HE8Tvwkf52cvrsh6JsByx5mb45nzRtwUO69mzb12sTaWLze4zC1CtIP3z1emtyA0YNQy2LE8MQwdndOKMH4OVTeILFCDMRp5sIp55390DIzas6PmMUM6w5dhzguiah+MSqwSlWPZiWFXt1lHyHgwl0jetIWwCPV3Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199021)(6486002)(36756003)(83380400001)(2616005)(38100700002)(31696002)(86362001)(6512007)(6506007)(26005)(186003)(2906002)(66556008)(66476007)(4326008)(66946007)(8936002)(8676002)(316002)(44832011)(5660300002)(31686004)(41300700001)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE1ZTFQ0VkZ4cmNpZW9VKzdVd29KN20xTys1Ujlkczdzd1pidmxBL25yMFk5?=
 =?utf-8?B?RWdLeG5jLzlDWFdraUp6K1ZXRVJUT0lTMGJWS24wVEx1dlNMcm5aNSt4cE96?=
 =?utf-8?B?K0s3YkZoekFWZUpoWHFCTm1TdGY2d0F4Zk9KTDBoTjZzdlg5cjdkVTFuTjBG?=
 =?utf-8?B?TXUyM0NadkFSS3RxRXlKWVJhNW1jeXZKTzdwSFVUQTRIVTVWYlRoUUxDWngz?=
 =?utf-8?B?YUVuU0xUdU82MU8xVEFvZ1h2WnpRUFhOWm9KUW9VU0R1dWkwK2E0b3c0b3Bi?=
 =?utf-8?B?UnQvbzFJcS8rZS9oZStWUUhTTzVRNitoYTYvZ0V0L2VqYlpxdURSVnl4enJO?=
 =?utf-8?B?c255Vm4zK04xenVnWG1ab0ZyeWRWSjVTQVIvbDlCam4vdkpRZFpsRDB0T1ZE?=
 =?utf-8?B?czZyZmdJa3hGd3hFRW5nRjhPVTRUSEVpLytkd1A1QUVpMEN3OGI1RHJ4WklV?=
 =?utf-8?B?UFp2S2NvNFZPUm5GQnpjQ1VYY1dhWHpJSmlyQyszOW00bGtNMC9JL1hYZ2ta?=
 =?utf-8?B?aGFZbWNYc0lWa2pueFRmS0tabTlURkdWVEdoQjVwUy9nYklDSzl3alBPeWxX?=
 =?utf-8?B?K1RGd3ZYZGdxYW9aY2pZeUJ3c25aT0Fma05tMndNQ25DS2g5K241bm9xZzBO?=
 =?utf-8?B?SjRpZ0tuNTVtVlFqT1dHcDB4R21lemZMcFpGZ3VHYldGK3h3VFlNZkxtYXBR?=
 =?utf-8?B?UVcwazlGN2RLR0t2L0x4QlZoUHZCUFdjZmc5TWExQjI3RlMzLzJvTTFyRHFw?=
 =?utf-8?B?NkNMbTNDN0xNckh6aDJtbUJLUVBzbVZ2RTZTY21aYW5INnhaL01xZlYvK01S?=
 =?utf-8?B?ZnA3YlB5WXlKQXRxK3lLZVBMWXJrb1pud3lTbTZKQkE2NWZESkJDWTFMaHJw?=
 =?utf-8?B?eEZnK3oxQnBMRWhNclBJVEU3SzZ0VzBLYTBMdW5uNG5CREpBZFJTa1BCd2xa?=
 =?utf-8?B?U0F6Ry8xVElXSmFZU3lQRGRWT1FueU52amVjQ0VDZlBTdUFUQTNRNTFwT09W?=
 =?utf-8?B?bCtLZjJycm5STis2S2lSOEJYajhQV1FuVHN4K1UwdmtYNlZYb0M5V3Z2b3B5?=
 =?utf-8?B?bU45RTZyNFZZd0JTS3BJRjlXRVZvT1VxSWtxeDhiWVFhV3RWYjJNRzBIM3NQ?=
 =?utf-8?B?aEREWGk4SG5VTkdVQUJMVmxvbkFJbE1WVFhiL1A0MkNaRUlhYjF0dGhWek1z?=
 =?utf-8?B?d1JSZFlTdXl1bUlRVUZxMmtJaGlKNmtMYy92MXFMT2FGci9NcW44YlFMaHZK?=
 =?utf-8?B?M3B2ZVhISmJ6TDB6dFNPVFhWYVdqZ29Wb09aVzBRUDZDYWVmbGFDN3NGQXc1?=
 =?utf-8?B?WmhQNVhWNDh3ajZNd2NXWFdtR2dPMy9OTVN4Q0F5V2NiY3crbTkrZjg4STh4?=
 =?utf-8?B?RjdlajZ1ZXFHME9Yd2NxZThjeGwrdU5oZkNXWXpqMXBoaUVHK3h4TVFncXJn?=
 =?utf-8?B?TjQvcWJhdXpVNGh3OFB5VWx2bkRiWW9iZSthd1B2cFY0TGlEOGZ2VnJ3RnlV?=
 =?utf-8?B?WjBOSmVFdmJHb3djb2VkS3VVUEJiQzlKa3loUXE5ZmRvaGFZRzZXbUpNMGM3?=
 =?utf-8?B?K2M3MDl5MFlQek9UQkdUQ1F1VWhmQ083QzN4YWVkMjNXN0l6Q3dXT3FIaTA3?=
 =?utf-8?B?cmxGdnFjOGxDMWFBNWF0U20ybmxLWFgvMG40a2ZYaEVmdmpjK0xrNjc0S3Ux?=
 =?utf-8?B?TFJlT3NVSnY1SEV3dnNpQ1FWbDdXTjJmUGJCY1R3U1RYUG8wVi9wL0tRMUxM?=
 =?utf-8?B?dTZSQlROeHV1VC9ycHIvcGRZVDUwM1FIUzlsemFUS1FLR0w5SVhMSnIxOVYv?=
 =?utf-8?B?TVZNUG1keFZweHdnTGZtZXQrSHFRZFhsNFY5MWRldi8wYTJSSzNzWDJ2LzFs?=
 =?utf-8?B?SGRBUEZIT3VBNWVVdW01UlVPY2Rac0VGZGIxR3dIQVY2aDc5bldUSkhQbVM4?=
 =?utf-8?B?Qy9kZ2lTOFVReTFzUmNmV3g2MlN2Um02R29vNUU2Y1BuNTM4azZlTDA3bzRD?=
 =?utf-8?B?KzNkeGFBVEZXamwzS3JCMjVWcWlNckRJN0FtZEhyaE1Qcyt2NEVwVmV3QkhV?=
 =?utf-8?B?ZlNxYThRR0hXN2JwNGhXQlRSK1A2K3BCOGFWU3lIK2lLV0FWUDlpc1FZTmRk?=
 =?utf-8?Q?dVSqutq9KWvlhTgk0I1tGkFwd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef81fe2a-2b44-4beb-0226-08db6192e467
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:52:53.0731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qB4HIHDgEmGx/wZ1bdv295yQ1QME3d0FKxr4jDnlW4Pu97G4FO9e153673wOI8I6x8kFEgjZQ10mom/EoHlYmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877
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
Cc: Alexander.Deucher@amd.com, Mukul.Joshi@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This quirk of for_each_inst has caused problems more than once. Why not 
use for_each_set_bit to implement it? That one doesn't have side effects.

Regards,
   Felix


Am 2023-05-29 um 09:58 schrieb Lijo Lazar:
> for_each_inst modifies xcc_mask and therefore the loop doesn't
> initialize properly interrupts on all pipes. Keep looping through xcc as
> the outer loop to fix this issue.
>
> Fixes: 7b04c90a48b1 ("drm/amdkfd: Use xcc mask for identifying xcc")
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 493b4b66f180..80cddb46657f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1274,11 +1274,12 @@ static void init_interrupts(struct device_queue_manager *dqm)
>   	uint32_t xcc_mask = dqm->dev->xcc_mask;
>   	unsigned int i, xcc_id;
>   
> -	for (i = 0 ; i < get_pipes_per_mec(dqm) ; i++) {
> -		if (is_pipe_enabled(dqm, 0, i)) {
> -			for_each_inst(xcc_id, xcc_mask)
> +	for_each_inst(xcc_id, xcc_mask) {
> +		for (i = 0 ; i < get_pipes_per_mec(dqm) ; i++) {
> +			if (is_pipe_enabled(dqm, 0, i)) {
>   				dqm->dev->kfd2kgd->init_interrupts(
>   					dqm->dev->adev, i, xcc_id);
> +			}
>   		}
>   	}
>   }
