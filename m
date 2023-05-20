Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B61C77B7A
	for <amd-gfx@archiver.kernel.org>; Sat, 20 May 2023 18:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAFF410E041;
	Sat, 20 May 2023 18:39:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FBD310E041
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 May 2023 18:39:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bx/JA+h7KwCUq4UwMUit5Qy/LTaYsOW5aR1bgKE+XlW6Oz2qsYRIfMWbTUaVrntCp/alcqbN7lXDxCsF6z+CIb9b4AuJY2GpeopT9lBsmPtC5/ioH+h2PVVbBSoh5BXjh1V2XCtd9eY0YEtz6R916/n2SpvocJjkcKGs8Vtlcs13VCwNcjNnn3IrATDVozSq2+42guXt8hTlQ8cz9mgERLVlzEP/a6SvgLId838qXlSxGRZmarVb5UdJIhwnmnhRgNSrD5EK1kewE4flSnN7r+z+iiugJIiq+wfrd0ky92VyIwGyGuusntgA2kpVIp6iqk7fOfD7Z22BSc6pkZNJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJdCmOpPetqnGhqnHoG565V7J1H+dZslebiUMuPyrhE=;
 b=EMcNKQqZzLCIazuaX3PjJUjwCwFUZzJMJw/f2GRe0BDUAhRXTvKNAc+6zRlcoXtgdN+nXxtOEx9Gi6j0rrXvm2RxgBPduAlm7Z6RjSKyAIGfwi1didlfla7UaXZf5nG7nfiNGbliWGRZB+mCxnGvzBhcJVztWmz3pVuWpm4YvX7Rt6q0ct8xq+gGPur43IqazGHkD0VGJi8NiXlg/+w13nrYwzLLaymrDLLI6N4mea5t8QSl/yWWda8J3Cv3CH7Gaq4Vt8mc/q0+9ae5KSM3zyCUIWm3I5FyVu5PHmkiHmsvq5zeQx+xY305usl47v/lsC/OHgM2Xk12AbvXcnAUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJdCmOpPetqnGhqnHoG565V7J1H+dZslebiUMuPyrhE=;
 b=arCKxLflNKG9kUPssoUKnwp14JetoYaGfVvVzRdxUXy4JZRdF3GVYRLcZJSiwPw1anf6J1vxGfBO4Vm5iW6AgJER1B9xJd7N0651AGUTUvfy0yCWbJvxXQ7m12fEMHK6DJ1Qpjbzz2TzwfAvHb5F5S4UR2kBYUb4H+EAlG7bxaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7413.namprd12.prod.outlook.com (2603:10b6:930:5f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.25; Sat, 20 May
 2023 18:39:17 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%7]) with mapi id 15.20.6411.025; Sat, 20 May 2023
 18:39:17 +0000
Message-ID: <f03a448f-1ba3-5d4a-a2a5-baba97b3ec1f@amd.com>
Date: Sat, 20 May 2023 14:39:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Revert "drm/amdgpu: remove TOPDOWN flags when allocating
 VRAM in large bar system"
Content-Language: en-US
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230520092518.1993-1-Arunpravin.PaneerSelvam@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230520092518.1993-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0458.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: f998e240-dcbc-47d3-4b37-08db59618418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5BTA/FxECqhg+Qg1u6O4aVFrs8z7Zzz8+Lo9a8Z9u0gobEzOeqgX8dr9dFuZXOmG3fVRhY5BqJr5//R593bTCRsTANOz4MsolR578QXEaUdRfvll+pNFfvgXS4mRdFoaXMULVSlNt7oOutuQKqlW6DVoo9fRZJGj5+xSLXiJUTJ7J809tjRy8cRNSAux/2pqe3h2tibYl0dAbolAiDLS/tDf5riLdq4wehIfUq9kYbtr7M91eqEydxNGQGRL11J0xTmc4U9pXDCyQaOMlEbGauvsgui/HaNmZdqEO38VUFPKVfQrUlXV9HPKkcMsbEzPStb6vPmaobR3Ud2ADSb84aeaj8Lej5jpOzuNthgfs+xxK6LjOIwFf4Fc1KAD769+xZMuhStoH/rnakTaWAG5agDm0JfW3wa5sM4886WEw82oqFk/w32Igb8GggsJj6xr6HEIZlnNmvCsk5WP56bDZgEiHdsoAShzeip/fFOTZqwUy8ri1J3Pa6z8yXFge6Hhcu3SzeFOZBh8xX4ZZ8jJoKTJ21kD619mBH+sWrNHPGImiKV03koh/wJrWNKFvsT8aFOttqxxJc9uF/5f7dl5zuwDu/1/BlfUvCx4AqWIP/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(31686004)(2906002)(5660300002)(83380400001)(44832011)(8676002)(8936002)(36756003)(66946007)(66476007)(66556008)(966005)(4326008)(316002)(6486002)(478600001)(41300700001)(6666004)(86362001)(26005)(31696002)(2616005)(186003)(6506007)(6512007)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qlh6M3VqZGcvcWJtczJFS293dEVqR2tpMEd2ZFRiYU5GQ0tZWjlFWTRrWm1M?=
 =?utf-8?B?RFNjbWQvZVhWRG5QeUZMeDVTV3VkVnVEa2NLcmNkTUJLeHhZS2s2SGVHVmZ2?=
 =?utf-8?B?cUFwSTZqbk5paTFkWEpmVDRZTzU4NXlYWGlPa0UzNHhkaCtWL0dsNWVFZ0Fh?=
 =?utf-8?B?TXZtQU0xTmR5RWh1a2xHOXhIbmszclF2UlVyVGxjUGk0dFljcEZ6QmpoeFMy?=
 =?utf-8?B?RkdFN0g0T3JWRXhCN2VlUWRaSit1YmhmdnhYTjk2WkEyRHhBYVVLa2p4Z2la?=
 =?utf-8?B?ZkdSd2JrWUJtbnFTalp5OWd3YTFLRDhwYkJXbzRoZlV1TXR3a3BuNURoYzlo?=
 =?utf-8?B?cXYrb0dNYWpTRFczNThBYmJqTERvdUFvSjFSeXNxeEFLeDJIVFg5OU5DUGVy?=
 =?utf-8?B?MGVTdkJUZ3lXTTFSQnpFa09zVCt5YmtSZ2w2QmFhZnZwUkRJckttZGllYmtD?=
 =?utf-8?B?Q2hhYlRJWUtyNm5JSi9lclRNV2RpV3AvOEtueWNqd3YxWU5pc0hCSnBBalBL?=
 =?utf-8?B?a2NTaUtYUjc4Y0FzZklxUXp6TVFNTkRNUG05d2tpN3JWMnluaFZWbElKODRu?=
 =?utf-8?B?M2pVMXIyd2EvbllUcFp5L2c1WlFtT3Z0Z1FCMzJ2MlNUYnIvbDN5T3lrY0xR?=
 =?utf-8?B?RkRDd0k5MGROYVJQb0U1WWt6MnorcTV0ODU1ZDRUaGN5eExLRzc1RlA3ck83?=
 =?utf-8?B?eE1KN3Y1UWE5RjB0NGNHRnNUTGdRSzNTUGttdGVoQzY0aEVPQU9kSEJLU0NY?=
 =?utf-8?B?dXVPVTdOMnJlbVh4a0huQVh5eHRDRHI5dWg4eVowVG5MQjN1TnV3QjRxRTFY?=
 =?utf-8?B?bU5yWGlzQjg5YkZ6VVl0YTNNY3pBY2ZCZTRudUhXd1NZUXIrRnFLTVdvekVQ?=
 =?utf-8?B?SGxFaHZ1eG1aVWkvK2ZzSVVVaGl4blRwUkRPTE15MnNPSmtvNW9IMXhWWUdC?=
 =?utf-8?B?ajlDYWtvcWN4N2gra2o4cDNlSkpZaFBIcHVUbjFnR25ldDRIWUtiWEZsTi9S?=
 =?utf-8?B?V3BhWERqQmltSENaQTlFdHV6aENBYzNuWHc3OEVSRUhDRlEwMWFJMzEwZlBZ?=
 =?utf-8?B?RUJLaENYN1hOeHh3VTBTQXhIQ2xuVm52VFhabWFtVUhyMGQzZG5PTVdUTGpn?=
 =?utf-8?B?Und0SHM1MDNCNU9DYTNWeUZLK2lFc2U1UnluWXRIZDRXandqZ08zOGUzeXFu?=
 =?utf-8?B?NXNLbG9VUkFpSmtsa1RzZkMrQjlrNGtKaHZPRTRDZTVBZnFDVWVrRXdtcEFp?=
 =?utf-8?B?MXBqSExIbDRLTjkvNkpicXRTdDNKTy9WelJjQ1V6VE03L2F5dHRJdFpCZzli?=
 =?utf-8?B?VTVKY3E0YU4vKzVESHZMS0Z3VTEwTHB2dmMxWWtkSEtMaVFmWWM3Z1ZhTG44?=
 =?utf-8?B?bGMrSk5SNlRRSDZndmxQUlRsWDRLUDk2aXVQZkliekZKZysya25qeGFWQXNv?=
 =?utf-8?B?QnYrRW5VWEVtSnNkajZINUZ5WUJMdE43VG5tTlhESGZFRzk0eGd0UUZUczZR?=
 =?utf-8?B?elZmMFEwTzl3OWNPQ25GYzJSWmc4K1NReUFxQkxSREZaY1d5WXBDc2Z5YjRv?=
 =?utf-8?B?RnhYY20vR0gvRm4zcFY4OWxOaUJ1S2VEWUc0SVFOZlVlMU15eUx0cmFHYUw2?=
 =?utf-8?B?NDRMbFkrNkZ2S2RQSHRmNzBGQkd2eno1Rm9CMThsaEtBWnNZVjd1WnI0MjFq?=
 =?utf-8?B?Qm14ZUwyRmg1MXAyaHg2UVJUazZUYlJZMXRZUStiajZXai9JZnNxNkk3Vlgz?=
 =?utf-8?B?L1FjYjc1ekhrS2FBdFh3RFFhdm9XZnVxQ0s5K2FRN2RrRmJ2TTB3UDZDSity?=
 =?utf-8?B?UWhmTmZJaExGU0l4Y0g1RC9YMCtPUFVPZGM0T1pSUzFQUnM0Wm8xK2h2ZGZZ?=
 =?utf-8?B?Zm53aFR6MXVNRWVPeklHTVZmWkRXVU5XK2hIZisvdElISkxzV0ZYSkJaS3Ba?=
 =?utf-8?B?T3g1VGtVQ2NHMTlmbXkvREtGU0l5TXM4MnA3NmlBZXhxNE1hRGVkbktKN2lX?=
 =?utf-8?B?aERXdUVDU1hsM1MxUnhCUjRBdzYzOHBSMmZ5WG1ydkwzaTB3RzZldGZsbU9D?=
 =?utf-8?B?NXNnNWF2RytwdFVVWkhJckcwR2RIMFMwOXROdEV6cWYwU3J6RkszQS9xa3BK?=
 =?utf-8?Q?EAOW07nraQd1/dKnfPpLpYFDQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f998e240-dcbc-47d3-4b37-08db59618418
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2023 18:39:16.8470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Th4vqGlQu4pWY/rzfFHrix9awsH23yVllXGUhzbuvUnEr0CPYmE7+uWag+Qnf5xKpd0m5TPlIQiBornEqxmNMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7413
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, shane.xiao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2023-05-20 um 05:25 schrieb Arunpravin Paneer Selvam:
> This reverts commit c105518679b6e87232874ffc989ec403bee59664.
>
> This patch disables the TOPDOWN flag for APU and few dGPU cards
> which has the VRAM size equal to the BAR size.

With resizable BARs it's not that rare.


>
> When we enable the TOPDOWN flag, we get the free blocks at
> the highest available memory region and we don't split the
> lower order blocks. This change is required to keep off
> the fragmentation related issues particularly in ASIC
> which has VRAM space <= 500MiB

If TOPDOWN has these general benefits, then would it make sense to 
allocate visible memory TOPDOWN as well, on large-BAR GPUs? Without 
knowing too much about the internals of the allocator, my intuition 
tells me that using only one allocation strategy has a better chance of 
minimizing fragmentation than mixing two allocation strategies for no 
good reason.

Regards,
   Felix


>
> Hence, we are reverting this patch.
>
> Gitlab issue link - https://gitlab.freedesktop.org/drm/amd/-/issues/2270
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 2bd1a54ee866..ca5fc07faf6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -139,7 +139,7 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>   
>   		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
>   			places[c].lpfn = visible_pfn;
> -		else if (adev->gmc.real_vram_size != adev->gmc.visible_vram_size)
> +		else
>   			places[c].flags |= TTM_PL_FLAG_TOPDOWN;
>   
>   		if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
