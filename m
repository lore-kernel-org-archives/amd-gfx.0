Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA75C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 13:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D232C6EA0F;
	Tue, 30 Nov 2021 13:57:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D8916E928
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 13:57:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfggGn1iKThJR+HWYO8lT8qfIVk2BKNRHYcxbj1rgcn5ZQ+MhTtRRITiT00QY9o4blEv62rGZd6zmU7P4itkFFsE2rsT5RCE2T/e97o9+w2JOBod9GTyJ7nwWw6g+h9cCGYaiqohPi8FAg3aeibrfWbyLpwKtowtqpal3bcG2CEzQF3ORwVCDvcLxjoE5ymv0qyzPQ19WqaF8lXcU+Xg5MK0KTrUVjzJ1J5uUaPW/nYio1lsSc8Np7xKQWIWRzFVr7ehvCqMm7EBIWakTsX3klWtGFRiaVEwCxQ1BcJ47yJ1sVilXMmvVhhzHIu6noAch5ECpt3fgk9qJCskwJPOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=At8O3OZASaTYfjN2MDXkd5MLgXmMT1yYpztZjLuSKFY=;
 b=SHxeVdYrYcqRPsO1FHqxtd4o4nxa9j1f/RCAXl1R/pYoPe3j9otDGcjy2PdW478tx0IKYn2m/xqtFN9Le3W0Cq8lExLuDzeP7TPQalQsSXeATKTuc15kc4s+p6RgTdZspgusXmWlrJYZr6qlSQv6AuCx2stSc1nCHgo9dZ4JwJEF9n8Q7sO/RmJHv8WheUXlCZljEEuDhpQA3ZCtCcNJwaM2v9cLnAV0o1XL4gvn9Y9dYUTAWn+T61YUgXzV9dEXEXoUAauJMgwbrnj0T96Ck1K0QNBsnsgY997yYi8twpMBsDdGj5749ONjP534GqEMib9eUaZCXBC9gMYlS4bkoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=At8O3OZASaTYfjN2MDXkd5MLgXmMT1yYpztZjLuSKFY=;
 b=4QyVNsVl1y/KHAx3Ny9Y9/S+nj42hCamgBcCmREJaRdsZpVpwVp05w9wztbUK5w8jXxD6YBTSsR98fo2j5rvoyo1eVLbuZQZRApH3o1C0/byUefY6bhczabZcOEU3ot0JKMJ99vAGcjwu3F8lpy1wDOmMDgzpEKVLH7uvQuzfS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 13:57:46 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 13:57:46 +0000
Message-ID: <3b2043b0-8bff-645e-9117-b8215def294a@amd.com>
Date: Tue, 30 Nov 2021 19:27:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH V2 13/17] drm/amd/pm: do not expose the smu_context
 structure used internally in power
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211130074259.1271965-1-evan.quan@amd.com>
 <20211130074259.1271965-14-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211130074259.1271965-14-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::30) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:25::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 13:57:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a876077-cb12-4e96-ac2a-08d9b40962dd
X-MS-TrafficTypeDiagnostic: DM6PR12MB2601:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2601F64DA95FAF525058248797679@DM6PR12MB2601.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ZcY2rNUq3ShBqOfPJfvE9bjvKS8MeyaPxDXhnNrVu340JwKGySnNpO9zfd+dZ7I5XtWu0DMIlTnOO2h13mF2Fy8gxdRUbKcA7LCmLFtjfubPDBdLGWTslnsQ50vOp8Bz6NkWoZRVE7M+wxcatV6Wq1GsizACO37fp25qGNFIYEo9vyHAJouSmF4TV2SFDfWdnHLULmnaXQKOI2dJoccsPOQjXMZMkTEJCmMor9YTRhQPZGI1/bk9azx75ISAKfiWiFtkYlpiNcLbwvk2uNWhn7BxSCpKHeZf/fMHcN0vVw2NHoQWxwLokSBZsuU9GDt0/XGIrj/Ww2f/CfA6DrzwuzQ9csJKkJerA5DSnSy++DVJrDE6gir4lZb2Pt+LXC+NCL+2v5miQg/AyrxLctvtHXn0/YTTbgRma0x2zCrHuqRMQKxy7avqbQSigRkVuS7BQ3CeDrSRhFocbNBgycylKiyh/6suDBf4E49cmnQt332XZTVc1VhMNrABuMQJS0BdTdoQ1NT8hjGyG76Jd6Wb32J1bu5xaZapt6qSTEC8o6eZAjyg72gKMWASsZKthvaidwLDJqsHomb9Gd5vd64HF0BAWNobbHvkAI+35l3OkmVw4Q1V6EqtZDmlLSVpSz4JSBNjxrB3PsmAVz8XTftmpj84+HAdV7adspC94oSTjXNgwZupC1EZ4gLmximQqu035uvCdKUcQYilyGI784Pv3+vsdde0LyJZvhIwqKNXQKvuGVhHcLceSKh6yEdjpU4/Pk35Z0QbFGdC7IIHOkDsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(31696002)(5660300002)(186003)(6486002)(956004)(16576012)(2616005)(30864003)(4326008)(508600001)(2906002)(8676002)(66556008)(31686004)(66476007)(66946007)(86362001)(8936002)(36756003)(6666004)(26005)(38100700002)(316002)(83380400001)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDFoWnc1ZlpCd3JoRnVvQ01yQk5mVlRrUyt5dEdnTHpTeHF5WVpzR0ZIV0lF?=
 =?utf-8?B?NGxwM0Z1RS8vemEzd1FzejQ5UmdVZ1EwcU1GOEtScGpxZU1sNG4zek9MQUd3?=
 =?utf-8?B?RHVMaXIyRjNVV0libXIweVl1cVAwOGNzUjNaTWNZcWpYUEcxOTkzYWdQeXFF?=
 =?utf-8?B?UjhkakdpSDRqNGVHdDJtWjRVaXpQYnVVVG1HMGJPT013ek9vMlNrK2h6bDVQ?=
 =?utf-8?B?UGF5VlNENHJBU2NZbUU4MVJ3MW5GUk5iaWl4Z1A5SUZ2N010Y1pkbjFqclZJ?=
 =?utf-8?B?TWFHZ0NFUmpCcGdDejZqdXJhQzVRckVuZlVLdlQvbXRVYXMxL25zYzBMMXU2?=
 =?utf-8?B?WnVHdkQ2bWN1UHY1STBobFhrdVhyTHVUMnhEcWpENXowUEdNM2hYM2FwVFZt?=
 =?utf-8?B?TUtqU3ZjVGoxZGdWRm1xMXJjWVZLZ0J3cjNZdzF0blh3QXkzcjVOWTBFa3Ny?=
 =?utf-8?B?VGdRbVc0M1hoTkoyZW1NempybFN3SGZIcFR0aW5mS3c1ME1BTGJycVpLKzNO?=
 =?utf-8?B?YW4wUTNmYjFXeUVNczFvWTY1MVNMSlNFQVpTSjdFck9tTjB3QlIzVW5HRTgy?=
 =?utf-8?B?NTcvYUdLVDNoTElXTUpyTVBsSHBYT0l2azdGdmE0ajlCZDZMdkVWdE05bzhL?=
 =?utf-8?B?U3lTQ0pvb1Q1OVQ5MExHVVd4ZTJWcDVWa3A0eWY2dVp3TWZ4VXVmODhOQXBt?=
 =?utf-8?B?a3NrMEZXT0NRVldDdVEvcVBaeW85b0dVVUpuMTZ3ZXpTOHFPdWdDOWNhdFp3?=
 =?utf-8?B?QjIrVjYweXRWakRnOTFNZWZPcEpjVlVkNFZORndKWHVZRFBTMnBYQTQrQ0ww?=
 =?utf-8?B?VDVtNWlvU2pOTzM5QjhYMm5VMUgvTkd6YzlyajlwUzlsVUlCaUNDT2tZUGYz?=
 =?utf-8?B?andyekJZNFBhVmtwL29qR1FaQ1ZHSHhzS2VvU0IwWkZMbTFUcFpVbmdORU90?=
 =?utf-8?B?Nzl6UjBHTG42MVBiRVkvVFhUZHZOWEpnTmQwUGZ0S1VoUllhQzZQWTE0Yk1u?=
 =?utf-8?B?VVJUNzBRL1c2L3EyV1JFeXJmN3RnR0hQNzFDOVdzQ01pZGhmSDlsQ24zbnpq?=
 =?utf-8?B?NEZXM1phSi9SUjJJMkM5ZDRNeTdmOHM2UzFWTWZ6VGRGQWN0aDVlemIvaXI4?=
 =?utf-8?B?akhxQ0RUZlQwRUlHQm5Xc3lPNGdEL2YvVG93K3dEN0hUTjZJdElDZ3lTR1dM?=
 =?utf-8?B?MithSmJWLy91RXQzUnhHTzRtNUdYNDFUL0RFcVB0WjRMRk5MOTFjazdGUkZK?=
 =?utf-8?B?SkpkWUlvaCtIQUZhMDZuNXpDb0p5SHBBWGFualJlTnhxN0JONkdsSU5oMmFy?=
 =?utf-8?B?VU4zMitNMW9UVlZydDljbVJ5dmhVVlhUTnlWSWxUdER4dVdFY0lhWm9KMDh4?=
 =?utf-8?B?TmI3ckR3bEtGQzJ0Q0xKUWMwclBsMWZZNHZLZDN0Tk9UbXRrbzJ2MlAvSHBv?=
 =?utf-8?B?djJkajBCamo5b1NlaEhlamJjWEVOV3ZVT0p4MzFQQkl5RUNCNFphTDNWSWR6?=
 =?utf-8?B?cStDd0MrMERNazVxekJ1Q0NRQ1I2Q0ZWYXZuMDZJNitmT3lLRERuVlVZcGdr?=
 =?utf-8?B?and0RG5EbjdWL05MSm5ZTGpZQ3ZnOCtGdCt4d0hmdTNENlQ1cFY0eDRtRXVK?=
 =?utf-8?B?SFRIQm9zbEVnRUtPWnVtQ013RjNaZkE2d2o4bzlDU0dBZ0J1Y25zUTY1Wncr?=
 =?utf-8?B?R3ZGZUpUWk1FUHRGWU9VUmFNTFY5OUpqYzVCUk5ZQXJzemJDY0k2WnJYdG9W?=
 =?utf-8?B?NTFDY1NEc2VlUktIZDhuN1ZkV1N0NjdIVkcrdTVyRWFVQzRCUHBEUUdMbllu?=
 =?utf-8?B?MHNoY3FSTE9LMDBaem9XN1NobmRFbEQ2L0JTajBZVVVnQTA1VGxGT1JBNUFx?=
 =?utf-8?B?alRWdVQ2aXdoWjdmREFuUHBQK1ZnOUMwOVZJZ1pZSS9VVERIZmhJdm00OExm?=
 =?utf-8?B?UEluVUxqOEIwQURKcElZeVVxNlY3SysrcGg5cEVEZmYzOWVialZ2R1ZGUGdQ?=
 =?utf-8?B?NlFlUTlXRlA3SXZXUTZTclc2SmR2U0dNWjRqZ2s0VjRmYUZBQmtMWTVvbTgw?=
 =?utf-8?B?YkczRXRSN1ZDbE1qZUxEWUhHcjRBMU0wWkUrNVZHRzB5RUtzdUN3R2ozdnRl?=
 =?utf-8?Q?uVMs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a876077-cb12-4e96-ac2a-08d9b40962dd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 13:57:45.9973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQn8urp4saeBkCQuZlxhGZF9kBNt4z4qIw7nODKFvwhZYGzEF+ckemoZ4NSuLkG8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2601
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/30/2021 1:12 PM, Evan Quan wrote:
> This can cover the power implementation details. And as what did for
> powerplay framework, we hook the smu_context to adev->powerplay.pp_handle.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I3969c9f62a8b63dc6e4321a488d8f15022ffeb3d
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  6 --
>   .../gpu/drm/amd/include/kgd_pp_interface.h    |  9 +++
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 51 ++++++++++------
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       | 11 +---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 60 +++++++++++++------
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  9 +--
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  9 +--
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  9 +--
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  4 +-
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  9 +--
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  8 +--
>   11 files changed, 111 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index c987813a4996..fefabd568483 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -99,7 +99,6 @@
>   #include "amdgpu_gem.h"
>   #include "amdgpu_doorbell.h"
>   #include "amdgpu_amdkfd.h"
> -#include "amdgpu_smu.h"
>   #include "amdgpu_discovery.h"
>   #include "amdgpu_mes.h"
>   #include "amdgpu_umc.h"
> @@ -950,11 +949,6 @@ struct amdgpu_device {
>   
>   	/* powerplay */
>   	struct amd_powerplay		powerplay;
> -
> -	/* smu */
> -	struct smu_context		smu;
> -
> -	/* dpm */
>   	struct amdgpu_pm		pm;
>   	u32				cg_flags;
>   	u32				pg_flags;
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 7919e96e772b..da6a82430048 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -25,6 +25,9 @@
>   #define __KGD_PP_INTERFACE_H__
>   
>   extern const struct amdgpu_ip_block_version pp_smu_ip_block;
> +extern const struct amdgpu_ip_block_version smu_v11_0_ip_block;
> +extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
> +extern const struct amdgpu_ip_block_version smu_v13_0_ip_block;
>   
>   enum smu_event_type {
>   	SMU_EVENT_RESET_COMPLETE = 0,
> @@ -244,6 +247,12 @@ enum pp_power_type
>   	PP_PWR_TYPE_FAST,
>   };
>   
> +enum smu_ppt_limit_type
> +{
> +	SMU_DEFAULT_PPT_LIMIT = 0,
> +	SMU_FAST_PPT_LIMIT,
> +};
> +

This is a contradiction. If the entry point is dpm, this shouldn't be 
here and the external interface doesn't need to know about internal 
datatypes.

>   #define PP_GROUP_MASK        0xF0000000
>   #define PP_GROUP_SHIFT       28
>   
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 8f0ae58f4292..a5cbbf9367fe 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -31,6 +31,7 @@
>   #include "amdgpu_display.h"
>   #include "hwmgr.h"
>   #include <linux/power_supply.h>
> +#include "amdgpu_smu.h"
>   
>   #define amdgpu_dpm_enable_bapm(adev, e) \
>   		((adev)->powerplay.pp_funcs->enable_bapm((adev)->powerplay.pp_handle, (e)))
> @@ -213,7 +214,7 @@ int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
>   
>   bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev)
>   {
> -	struct smu_context *smu = &adev->smu;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   
>   	if (is_support_sw_smu(adev))
>   		return smu_mode1_reset_is_support(smu);
> @@ -223,7 +224,7 @@ bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev)
>   
>   int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev)
>   {
> -	struct smu_context *smu = &adev->smu;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   
>   	if (is_support_sw_smu(adev))
>   		return smu_mode1_reset(smu);
> @@ -276,7 +277,7 @@ int amdgpu_dpm_set_df_cstate(struct amdgpu_device *adev,
>   
>   int amdgpu_dpm_allow_xgmi_power_down(struct amdgpu_device *adev, bool en)
>   {
> -	struct smu_context *smu = &adev->smu;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   
>   	if (is_support_sw_smu(adev))
>   		return smu_allow_xgmi_power_down(smu, en);
> @@ -341,7 +342,7 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
>   		mutex_unlock(&adev->pm.mutex);
>   
>   		if (is_support_sw_smu(adev))
> -			smu_set_ac_dc(&adev->smu);
> +			smu_set_ac_dc(adev->powerplay.pp_handle);
>   	}
>   }
>   
> @@ -423,15 +424,16 @@ int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_versio
>   
>   int amdgpu_dpm_set_light_sbr(struct amdgpu_device *adev, bool enable)
>   {
> -	return smu_set_light_sbr(&adev->smu, enable);
> +	return smu_set_light_sbr(adev->powerplay.pp_handle, enable);
>   }
>   
>   int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, uint32_t size)
>   {
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   	int ret = 0;
>   
> -	if (adev->smu.ppt_funcs && adev->smu.ppt_funcs->send_hbm_bad_pages_num)
> -		ret = adev->smu.ppt_funcs->send_hbm_bad_pages_num(&adev->smu, size);
> +	if (is_support_sw_smu(adev))
> +		ret = smu_send_hbm_bad_pages_num(smu, size);
>   
>   	return ret;
>   }
> @@ -446,7 +448,7 @@ int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
>   
>   	switch (type) {
>   	case PP_SCLK:
> -		return smu_get_dpm_freq_range(&adev->smu, SMU_SCLK, min, max);
> +		return smu_get_dpm_freq_range(adev->powerplay.pp_handle, SMU_SCLK, min, max);
>   	default:
>   		return -EINVAL;
>   	}
> @@ -457,12 +459,14 @@ int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
>   				   uint32_t min,
>   				   uint32_t max)
>   {
> +	struct smu_context *smu = adev->powerplay.pp_handle;
> +
>   	if (!is_support_sw_smu(adev))
>   		return -EOPNOTSUPP;
>   
>   	switch (type) {
>   	case PP_SCLK:
> -		return smu_set_soft_freq_range(&adev->smu, SMU_SCLK, min, max);
> +		return smu_set_soft_freq_range(smu, SMU_SCLK, min, max);
>   	default:
>   		return -EINVAL;
>   	}
> @@ -470,33 +474,41 @@ int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
>   
>   int amdgpu_dpm_write_watermarks_table(struct amdgpu_device *adev)
>   {
> +	struct smu_context *smu = adev->powerplay.pp_handle;
> +
>   	if (!is_support_sw_smu(adev))
>   		return 0;
>   
> -	return smu_write_watermarks_table(&adev->smu);
> +	return smu_write_watermarks_table(smu);
>   }
>   
>   int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev,
>   			      enum smu_event_type event,
>   			      uint64_t event_arg)
>   {
> +	struct smu_context *smu = adev->powerplay.pp_handle;
> +
>   	if (!is_support_sw_smu(adev))
>   		return -EOPNOTSUPP;
>   
> -	return smu_wait_for_event(&adev->smu, event, event_arg);
> +	return smu_wait_for_event(smu, event, event_arg);
>   }
>   
>   int amdgpu_dpm_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value)
>   {
> +	struct smu_context *smu = adev->powerplay.pp_handle;
> +
>   	if (!is_support_sw_smu(adev))
>   		return -EOPNOTSUPP;
>   
> -	return smu_get_status_gfxoff(&adev->smu, value);
> +	return smu_get_status_gfxoff(smu, value);
>   }
>   
>   uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device *adev)
>   {
> -	return atomic64_read(&adev->smu.throttle_int_counter);
> +	struct smu_context *smu = adev->powerplay.pp_handle;
> +
> +	return atomic64_read(&smu->throttle_int_counter);
>   }
>   
>   /* amdgpu_dpm_gfx_state_change - Handle gfx power state change set
> @@ -518,10 +530,12 @@ void amdgpu_dpm_gfx_state_change(struct amdgpu_device *adev,
>   int amdgpu_dpm_get_ecc_info(struct amdgpu_device *adev,
>   			    void *umc_ecc)
>   {
> +	struct smu_context *smu = adev->powerplay.pp_handle;
> +
>   	if (!is_support_sw_smu(adev))
>   		return -EOPNOTSUPP;
>   
> -	return smu_get_ecc_info(&adev->smu, umc_ecc);
> +	return smu_get_ecc_info(smu, umc_ecc);
>   }
>   
>   struct amd_vce_state *amdgpu_dpm_get_vce_clock_state(struct amdgpu_device *adev,
> @@ -919,9 +933,10 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
>   int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
>   {
>   	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   
> -	if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
> -	    (is_support_sw_smu(adev) && adev->smu.is_apu) ||
> +	if ((is_support_sw_smu(adev) && smu->od_enabled) ||
> +	    (is_support_sw_smu(adev) && smu->is_apu) ||
>   		(!is_support_sw_smu(adev) && hwmgr->od_enabled))
>   		return true;
>   
> @@ -944,7 +959,9 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
>   
>   int amdgpu_dpm_get_num_cpu_cores(struct amdgpu_device *adev)
>   {
> -	return adev->smu.cpu_core_num;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
> +
> +	return smu->cpu_core_num;
>   }
>   
>   void amdgpu_dpm_stb_debug_fs_init(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 29791bb21fba..f44139b415b4 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -205,12 +205,6 @@ enum smu_power_src_type
>   	SMU_POWER_SOURCE_COUNT,
>   };
>   
> -enum smu_ppt_limit_type
> -{
> -	SMU_DEFAULT_PPT_LIMIT = 0,
> -	SMU_FAST_PPT_LIMIT,
> -};
> -
>   enum smu_ppt_limit_level
>   {
>   	SMU_PPT_LIMIT_MIN = -1,
> @@ -1389,10 +1383,6 @@ int smu_mode1_reset(struct smu_context *smu);
>   
>   extern const struct amd_ip_funcs smu_ip_funcs;
>   
> -extern const struct amdgpu_ip_block_version smu_v11_0_ip_block;
> -extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
> -extern const struct amdgpu_ip_block_version smu_v13_0_ip_block;
> -
>   bool is_support_sw_smu(struct amdgpu_device *adev);
>   bool is_support_cclk_dpm(struct amdgpu_device *adev);
>   int smu_write_watermarks_table(struct smu_context *smu);
> @@ -1416,6 +1406,7 @@ int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
>   int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc);
>   int smu_stb_collect_info(struct smu_context *smu, void *buff, uint32_t size);
>   void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
> +int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size);
>   
>   #endif
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index eaed5aba7547..2c3fd3cfef05 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -468,7 +468,7 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
>   
>   bool is_support_cclk_dpm(struct amdgpu_device *adev)
>   {
> -	struct smu_context *smu = &adev->smu;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   
>   	if (!smu_feature_is_enabled(smu, SMU_FEATURE_CCLK_DPM_BIT))
>   		return false;
> @@ -572,7 +572,7 @@ static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
>   
>   static int smu_set_funcs(struct amdgpu_device *adev)
>   {
> -	struct smu_context *smu = &adev->smu;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   
>   	if (adev->pm.pp_feature & PP_OVERDRIVE_MASK)
>   		smu->od_enabled = true;
> @@ -624,7 +624,11 @@ static int smu_set_funcs(struct amdgpu_device *adev)
>   static int smu_early_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	struct smu_context *smu = &adev->smu;
> +	struct smu_context *smu;
> +
> +	smu = kzalloc(sizeof(struct smu_context), GFP_KERNEL);
> +	if (!smu)
> +		return -ENOMEM;
>   
>   	smu->adev = adev;
>   	smu->pm_enabled = !!amdgpu_dpm;
> @@ -684,7 +688,7 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
>   static int smu_late_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	struct smu_context *smu = &adev->smu;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   	int ret = 0;
>   
>   	smu_set_fine_grain_gfx_freq_parameters(smu);
> @@ -730,7 +734,7 @@ static int smu_late_init(void *handle)
>   
>   	smu_get_fan_parameters(smu);
>   
> -	smu_handle_task(&adev->smu,
> +	smu_handle_task(smu,
>   			smu->smu_dpm.dpm_level,
>   			AMD_PP_TASK_COMPLETE_INIT,
>   			false);
> @@ -1020,7 +1024,7 @@ static void smu_interrupt_work_fn(struct work_struct *work)
>   static int smu_sw_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	struct smu_context *smu = &adev->smu;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   	int ret;
>   
>   	smu->pool_size = adev->pm.smu_prv_buffer_size;
> @@ -1095,7 +1099,7 @@ static int smu_sw_init(void *handle)
>   static int smu_sw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	struct smu_context *smu = &adev->smu;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   	int ret;
>   
>   	ret = smu_smc_table_sw_fini(smu);
> @@ -1330,7 +1334,7 @@ static int smu_hw_init(void *handle)
>   {
>   	int ret;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	struct smu_context *smu = &adev->smu;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   
>   	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
>   		smu->pm_enabled = false;
> @@ -1344,10 +1348,10 @@ static int smu_hw_init(void *handle)
>   	}
>   
>   	if (smu->is_apu) {
> -		smu_powergate_sdma(&adev->smu, false);
> +		smu_powergate_sdma(smu, false);
>   		smu_dpm_set_vcn_enable(smu, true);
>   		smu_dpm_set_jpeg_enable(smu, true);
> -		smu_set_gfx_cgpg(&adev->smu, true);
> +		smu_set_gfx_cgpg(smu, true);
>   	}
>   
>   	if (!smu->pm_enabled)
> @@ -1501,13 +1505,13 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
>   static int smu_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	struct smu_context *smu = &adev->smu;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   
>   	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
>   		return 0;
>   
>   	if (smu->is_apu) {
> -		smu_powergate_sdma(&adev->smu, true);
> +		smu_powergate_sdma(smu, true);
>   	}
>   
>   	smu_dpm_set_vcn_enable(smu, false);
> @@ -1524,6 +1528,14 @@ static int smu_hw_fini(void *handle)
>   	return smu_smc_hw_cleanup(smu);
>   }
>   
> +static void smu_late_fini(void *handle)
> +{
> +	struct amdgpu_device *adev = handle;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
> +
> +	kfree(smu);
> +}
> +

This doesn't look related to this change.

>   static int smu_reset(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
> @@ -1551,7 +1563,7 @@ static int smu_reset(struct smu_context *smu)
>   static int smu_suspend(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	struct smu_context *smu = &adev->smu;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   	int ret;
>   
>   	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
> @@ -1570,7 +1582,7 @@ static int smu_suspend(void *handle)
>   
>   	/* skip CGPG when in S0ix */
>   	if (smu->is_apu && !adev->in_s0ix)
> -		smu_set_gfx_cgpg(&adev->smu, false);
> +		smu_set_gfx_cgpg(smu, false);
>   
>   	return 0;
>   }
> @@ -1579,7 +1591,7 @@ static int smu_resume(void *handle)
>   {
>   	int ret;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	struct smu_context *smu = &adev->smu;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   
>   	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
>   		return 0;
> @@ -1602,7 +1614,7 @@ static int smu_resume(void *handle)
>   	}
>   
>   	if (smu->is_apu)
> -		smu_set_gfx_cgpg(&adev->smu, true);
> +		smu_set_gfx_cgpg(smu, true);
>   
>   	smu->disable_uclk_switch = 0;
>   
> @@ -2134,6 +2146,7 @@ const struct amd_ip_funcs smu_ip_funcs = {
>   	.sw_fini = smu_sw_fini,
>   	.hw_init = smu_hw_init,
>   	.hw_fini = smu_hw_fini,
> +	.late_fini = smu_late_fini,
>   	.suspend = smu_suspend,
>   	.resume = smu_resume,
>   	.is_idle = NULL,
> @@ -3198,7 +3211,7 @@ int smu_stb_collect_info(struct smu_context *smu, void *buf, uint32_t size)
>   static int smu_stb_debugfs_open(struct inode *inode, struct file *filp)
>   {
>   	struct amdgpu_device *adev = filp->f_inode->i_private;
> -	struct smu_context *smu = &adev->smu;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   	unsigned char *buf;
>   	int r;
>   
> @@ -3223,7 +3236,7 @@ static ssize_t smu_stb_debugfs_read(struct file *filp, char __user *buf, size_t
>   				loff_t *pos)
>   {
>   	struct amdgpu_device *adev = filp->f_inode->i_private;
> -	struct smu_context *smu = &adev->smu;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   
>   
>   	if (!filp->private_data)
> @@ -3264,7 +3277,7 @@ void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev)
>   {
>   #if defined(CONFIG_DEBUG_FS)
>   
> -	struct smu_context *smu = &adev->smu;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   
>   	if (!smu->stb_context.stb_buf_size)
>   		return;
> @@ -3276,5 +3289,14 @@ void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev)
>   			    &smu_stb_debugfs_fops,
>   			    smu->stb_context.stb_buf_size);
>   #endif
> +}
> +
> +int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size)
> +{
> +	int ret = 0;
> +
> +	if (smu->ppt_funcs->send_hbm_bad_pages_num)
> +		ret = smu->ppt_funcs->send_hbm_bad_pages_num(smu, size);
>   
> +	return ret;

This also looks unrelated.

Thanks,
Lijo

>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 05defeee0c87..a03bbd2a7aa0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -2082,7 +2082,8 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
>   			     struct i2c_msg *msg, int num_msgs)
>   {
>   	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
> -	struct smu_table_context *smu_table = &adev->smu.smu_table;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
> +	struct smu_table_context *smu_table = &smu->smu_table;
>   	struct smu_table *table = &smu_table->driver_table;
>   	SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
>   	int i, j, r, c;
> @@ -2128,9 +2129,9 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
>   			}
>   		}
>   	}
> -	mutex_lock(&adev->smu.mutex);
> -	r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
> -	mutex_unlock(&adev->smu.mutex);
> +	mutex_lock(&smu->mutex);
> +	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
> +	mutex_unlock(&smu->mutex);
>   	if (r)
>   		goto fail;
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 2bb7816b245a..37e11716e919 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2779,7 +2779,8 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
>   			   struct i2c_msg *msg, int num_msgs)
>   {
>   	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
> -	struct smu_table_context *smu_table = &adev->smu.smu_table;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
> +	struct smu_table_context *smu_table = &smu->smu_table;
>   	struct smu_table *table = &smu_table->driver_table;
>   	SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
>   	int i, j, r, c;
> @@ -2825,9 +2826,9 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
>   			}
>   		}
>   	}
> -	mutex_lock(&adev->smu.mutex);
> -	r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
> -	mutex_unlock(&adev->smu.mutex);
> +	mutex_lock(&smu->mutex);
> +	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
> +	mutex_unlock(&smu->mutex);
>   	if (r)
>   		goto fail;
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 777f717c37ae..6a5064f4ea86 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3459,7 +3459,8 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
>   				   struct i2c_msg *msg, int num_msgs)
>   {
>   	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
> -	struct smu_table_context *smu_table = &adev->smu.smu_table;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
> +	struct smu_table_context *smu_table = &smu->smu_table;
>   	struct smu_table *table = &smu_table->driver_table;
>   	SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
>   	int i, j, r, c;
> @@ -3505,9 +3506,9 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
>   			}
>   		}
>   	}
> -	mutex_lock(&adev->smu.mutex);
> -	r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
> -	mutex_unlock(&adev->smu.mutex);
> +	mutex_lock(&smu->mutex);
> +	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
> +	mutex_unlock(&smu->mutex);
>   	if (r)
>   		goto fail;
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 28b7c0562b99..2a53b5b1d261 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1372,7 +1372,7 @@ static int smu_v11_0_set_irq_state(struct amdgpu_device *adev,
>   				   unsigned tyep,
>   				   enum amdgpu_interrupt_state state)
>   {
> -	struct smu_context *smu = &adev->smu;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   	uint32_t low, high;
>   	uint32_t val = 0;
>   
> @@ -1441,7 +1441,7 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>   				 struct amdgpu_irq_src *source,
>   				 struct amdgpu_iv_entry *entry)
>   {
> -	struct smu_context *smu = &adev->smu;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   	uint32_t client_id = entry->client_id;
>   	uint32_t src_id = entry->src_id;
>   	/*
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 6e781cee8bb6..3c82f5455f88 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1484,7 +1484,8 @@ static int aldebaran_i2c_xfer(struct i2c_adapter *i2c_adap,
>   			      struct i2c_msg *msg, int num_msgs)
>   {
>   	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
> -	struct smu_table_context *smu_table = &adev->smu.smu_table;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
> +	struct smu_table_context *smu_table = &smu->smu_table;
>   	struct smu_table *table = &smu_table->driver_table;
>   	SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
>   	int i, j, r, c;
> @@ -1530,9 +1531,9 @@ static int aldebaran_i2c_xfer(struct i2c_adapter *i2c_adap,
>   			}
>   		}
>   	}
> -	mutex_lock(&adev->smu.mutex);
> -	r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
> -	mutex_unlock(&adev->smu.mutex);
> +	mutex_lock(&smu->mutex);
> +	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
> +	mutex_unlock(&smu->mutex);
>   	if (r)
>   		goto fail;
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 55421ea622fb..4ed01e9d88fb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1195,7 +1195,7 @@ static int smu_v13_0_set_irq_state(struct amdgpu_device *adev,
>   				   unsigned tyep,
>   				   enum amdgpu_interrupt_state state)
>   {
> -	struct smu_context *smu = &adev->smu;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   	uint32_t low, high;
>   	uint32_t val = 0;
>   
> @@ -1270,7 +1270,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>   				 struct amdgpu_irq_src *source,
>   				 struct amdgpu_iv_entry *entry)
>   {
> -	struct smu_context *smu = &adev->smu;
> +	struct smu_context *smu = adev->powerplay.pp_handle;
>   	uint32_t client_id = entry->client_id;
>   	uint32_t src_id = entry->src_id;
>   	/*
> @@ -1316,11 +1316,11 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>   			switch (ctxid) {
>   			case 0x3:
>   				dev_dbg(adev->dev, "Switched to AC mode!\n");
> -				smu_v13_0_ack_ac_dc_interrupt(&adev->smu);
> +				smu_v13_0_ack_ac_dc_interrupt(smu);
>   				break;
>   			case 0x4:
>   				dev_dbg(adev->dev, "Switched to DC mode!\n");
> -				smu_v13_0_ack_ac_dc_interrupt(&adev->smu);
> +				smu_v13_0_ack_ac_dc_interrupt(smu);
>   				break;
>   			case 0x7:
>   				/*
> 
