Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1646C47088
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Dec 2022 00:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F14A10E514;
	Thu,  1 Dec 2022 00:18:26 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BF8910E514
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Dec 2022 00:18:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBoVRRA1pey1FU1dHxvzLfyY3tjR9q1FhMcdH+JgATde7xVW2hKAXSMj2YhLS4fH/cTVVCjjJ7Qex2jWIcWO0qvybC3ZnPiT4HRNcs/m3dKazlpUJpx1ZM1vciAFV9drMqUA7NpbDBFLIZBBJ+vYQ+Wor9esmjtU8TwB5idGDQxTm5evyjhihwUIiX51kwtOTMSgEPCu0IRxqsny3FNBpBfAIvJE2dHGNf/z+a9V4v8czbWUjRIsFP/H+jkFvOnJZuqzWXLHP9kuaLsyHrBRe7iHPUZXFqbxjTDX3GQr3xLxixbQ6Y2/+XMoLejmKXr7EZu0/AtfvZjWjY1YNWw2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V89otiT3yXoonZJKbDxNE4vBgpuurPmPSpM+otAlW58=;
 b=dFerp47HhZCFpOl3a9rfnl3jUh6qYmImHzGXddHC/Wux14XnUJb99rhUnMshkPnCc4Ovs5AjHqwtJM4xop3hNwyHJLfhE3QZuw2FT3obcdH4IG21DdyZpOFz84GhR99wWIKkiiP6xbWRHlLNfh6T5PyYSQcQwkqzMRdpsO+2Ie/dWVY1YNbi2iibdFXZDCPHjWZ99gEWrmtSjRWjlQ/xYuGmbICbwrJN3nhkc01iy7+L4jEu0mUHnFCTAecr/BXBuj/uqSEb6gJztShF1TGjOGySXyqvqZpzESSdjTxDmNsRJHj3Z3IuLVSJ6yGTL+CuAiqNgbqnUcZmW0SfyOGLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V89otiT3yXoonZJKbDxNE4vBgpuurPmPSpM+otAlW58=;
 b=ez+zamW4DxvkjC1VWsI1aw8Ajaqr4FeHswZLH/toJfZzI0l20yDX5V8WDDPyQeBfpe2NjLjd37c5NlR2T5ObPjfHKjiYYiFJZHmUDtCg6fEF/WjMkraxovIpJAM2VZad++k3gAXNP/iBhlEQ2rU6jvEem7Xzgk2thT6jlXZ0z2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 00:18:22 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 00:18:22 +0000
Message-ID: <7eaa2766-07bd-361d-45a6-e1c6d63cdf9d@amd.com>
Date: Wed, 30 Nov 2022 19:18:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 05/29] drm/amdgpu: setup hw debug registers on driver
 initialization
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-5-jonathan.kim@amd.com>
 <45ae7684-c25c-1957-bf49-8e690ce883da@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <45ae7684-c25c-1957-bf49-8e690ce883da@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR0102CA0063.prod.exchangelabs.com
 (2603:10b6:208:25::40) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: d78d5f44-755f-41d2-36b4-08dad3318e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2SfWYxvFKzGX7zXU6Vznfqr4yyIOangbSl89vRM+/vktXEU3G+V0yprCISENCw92kr77yGa5x391fWH2f/MdwKu1qysclM/HtxNKyHa4RvUSOU1WnAxjiMNjfpKqIPFVkvUWfLIRXyfKAXaX3nHm3CLSiOFpndlC/sKRliJaK/MZ536sZ3laBT0oP2xD+ee6RhCrIK/ExnOybkbxZoWS/WHuG8TH6VBROhkVXYDwzDGH8SX+3ltCugpQYA8s/eeFuUDYIbLxPlm0GbRgLtWxa3oK3tBCiqlYyisC0zCSo2x3weVa1E3qDQ2ZVQUU90B+Gi+r7sN41gTto/LjfEBQ3kcuRggWeXQByf59+URHVurKb6iz2o6XgAiqXvIQCZqIB5+kw297bBlDFfalID+7UTsed7J1X+OaGg5AyT+/97xqj4iFhopTUD6x9fxVXqBDyOHM7nPKJ7Ly/g1ofeKN9XYTjMKrrbvm1AOvedDN807uGVPkJwTIUX3q+IuTVnVpBb5ea/q2Mj6qdg6bRCkvejA+RZ+MIjRb9EdomnREtUPAQqzDuq7QFaAlulqegV7ZOzNJfthJCDO0JROoCK2kSxFmYi00KY2nVgJp9jNJ7Jrf9+o9bOFms29eJuhLREJfTL0WAhqmlPVlYNK5Vony8gDdf3P4jWHalmltAE7bWrMPhj0Zw6WCQA8H9Hn65u5ZVrYQnSmcyy9oG07qA/Ucx88jfF2zLu7BsDijkwqd2xU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199015)(2906002)(4001150100001)(36756003)(86362001)(6486002)(31696002)(36916002)(478600001)(66556008)(44832011)(26005)(30864003)(316002)(66946007)(5660300002)(6916009)(66476007)(8936002)(6506007)(8676002)(41300700001)(6512007)(38100700002)(186003)(2616005)(83380400001)(53546011)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEhnZ2lxYUVZNzNxQ3M1bnBBeExSQzFoMndNYnJ1SVR5a1FNQ0lROHF6b2c5?=
 =?utf-8?B?NlNSN012UkRtVVEwNGxENHpISnlUU3poak0wd25wREZySW10MzhDeHlSblJO?=
 =?utf-8?B?cnBkM05yV2luRlp0cmd0WENQcGczSW16VnBJMzhhckRnYytaaG8wbjU1VkFU?=
 =?utf-8?B?cGtETEdwL1QrOXNWTCtnZDBvVThqSDNWUnpoUU1oc2xRaUVxTVNJNTJqRk9S?=
 =?utf-8?B?OE9XQVJnd0J2RTk4TkRuWmkyWWlCekpvTm1GeE4xMkNnT05Eb2xTTHJtR0wz?=
 =?utf-8?B?MExFK0JCcHJkKzM0aGk5R3FxMFY4aDlsVTcxcEk4aGNjODBqNUVvODlpWWpX?=
 =?utf-8?B?dGU0bWhNa0RhQXR3RGliU3M4OUFwQXF6WjFzTUlXZThCanM1emVnSEN5Y2ox?=
 =?utf-8?B?MWFHSm1pNUhaSFBmTDFxYVpXcVBzbXQzRlo4clBqV0wyVHJjdkRDMFV6NnRk?=
 =?utf-8?B?US9sZ2VkalIvVDFVRHJzVW9jU0dCeUg4bTJaVjZ1RnVSTVQwRnhISVJlbHho?=
 =?utf-8?B?dS9ueWtNR3dIQzdqVlhxdWZSNkkvYzF6YS80a3BwcVdqQjZudDlVWVNEenZX?=
 =?utf-8?B?T0pOS2xnU3ZtR0h6QU1iakpiZ2RtVU01N0RmSytwY2lSVlBwOEFTeHZpc1NN?=
 =?utf-8?B?M0ViYVBGdU5wajI2MHdYalRwVDlXcDF4QkNYVW83ckZrUlZ4NjRGaFU1ckFm?=
 =?utf-8?B?dEw3RXRpL21VYlNaZ3VHTnBpL0xIT2hlVVV0QTZ1UGFwNFovYzdOVVZNVTZa?=
 =?utf-8?B?TnVxTCs2R2hJTFBNczQybW5QbjRZOTFVNUtOK041c1BGbHQ2TW5ody9Fczdx?=
 =?utf-8?B?VTdMRnk4Qy9DVytTcFhadGgxYUlJSDdxeHJzM3g3Sm82Wm5jU2R3MUpmZ1dE?=
 =?utf-8?B?eGZ2VUVsbytHTUpNYUFKMFJBMEVYdlZtc0M5NlBhT2JCOFFDbU9NRkVqYWk2?=
 =?utf-8?B?T1p2MXQ5RmVBbTJjeGRiNW5kV0loaHpHU2drV0cyaG9xUnZ0ZUVQZmg5MExt?=
 =?utf-8?B?MC83TjRZcWt4NmdNN1YxcjZuQk9BOFQrREc0dkZ0NCsrUVJyemRSWS9DQVB1?=
 =?utf-8?B?YUNCZm5renhlNjJLcFNwZkt5RUZ3VnpvaEVmdWFFdEpmMEhJODBRcVRTelp2?=
 =?utf-8?B?WTNGNnpZSXVHTFc1eUVZN0xJK2ZMMDJZOFBuSDZwNFFqYXkrUSt0SHlPajls?=
 =?utf-8?B?bGVyRzNEa2l0bEM3djczd29EMWhuTk9NdXhrTTV0aFliRXVWQzRjcG5hcnJZ?=
 =?utf-8?B?bUJjdVBScnpNMGNFN1BsTFAvOFpOWU5EcUxMcVpaMkJCcTVWeStvdGxsQ2p3?=
 =?utf-8?B?OUt6ZGV0UTQvU09COEEzdUNkRXZGQlhNRUxkSTJkVm1JdUI5Y2gybEZCRjh1?=
 =?utf-8?B?MXc2MGsybFMxNFoyMEJiQlp2b1piV3hJa2ZrRysvVjQ1ajE4ZFNYWnFwVjlP?=
 =?utf-8?B?VXhXbDNaQng5VzY1WHUxcFdPMFBwUTBJOW9KQlZGeGdiWDV0enNDcm5IYVNw?=
 =?utf-8?B?cUhKbkM4T3FacGNLR0NzYWxyUmZudHYweTlIdk8zbWNpWFVlTkl4eUEyN1Np?=
 =?utf-8?B?L2FFL05KK2xSS2FCWGd1MFlyOWhEbEw5STI3MUpqRHZyalN6bWc0UjJVbGVk?=
 =?utf-8?B?MVBTUW95WVhGYVd1QmZXOUJUWVpwRjNtNWhtaVFiSmg3NVF2MzAxWThmOFZq?=
 =?utf-8?B?cm41eE5Qb2Y2RXAwa1NNRC9MUjJmNEFXMWNRRXJIYjg1V2d2SHFFRENJSG81?=
 =?utf-8?B?TU5kYk9mcUY1ZE1TYlltY1doaHdWOGFpQktSRUY2QlNsWDA1RjBCS0FEYTBQ?=
 =?utf-8?B?TGpCT2ljZ3FLUGRreE9wYWt2Mi9jRS82MC9vamxqUzJJbHJsWE9QN1AzYk1W?=
 =?utf-8?B?TXNvcnlqaXI4RTFZUnlxMzRHY2ppVUh2NWFlKzR1L01qckZYbVpDVEpvTmRR?=
 =?utf-8?B?WGpKTDJ6N1hVbG1DVEZmSi8vaDVjQ25uRDJ5c2trQVdEc0JTRWtNSjRrVVdL?=
 =?utf-8?B?d0c3dS9HN2RMNVJCNDlRTUpyU1F3eW5SOU0wd29US082aWVTVWtwaWtNNkhL?=
 =?utf-8?B?d2kwMWtZNGdoYjBmakJwSE1TT3Q2cEtndUF0MDhMZkNpVWx6dWhJMEUvdDBx?=
 =?utf-8?Q?MO95RZL3GYzIE6hiWUWxM7aEe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d78d5f44-755f-41d2-36b4-08dad3318e3c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 00:18:22.0452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/jFHew/2eUG/5CltiJyl34y3Vm1/WLer7fI7DloIPjfeATJ8YmWU9W9XWNbXmtVc6Ib6H0kijhGkfJ1ylAKEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282
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


On 2022-11-22 18:38, Felix Kuehling wrote:
>
> On 2022-10-31 12:23, Jonathan Kim wrote:
>> Add missing debug trap registers references and initialize all debug
>> registers on boot by clearing the hardware exception overrides and the
>> wave allocation ID index.
>>
>> For debug devices that only support single process debugging, enable
>> trap temporary setup by default.
>>
>> Debug devices that support multi-process debugging require trap
>> temporary setup to be disabled by default in order to satisfy microbench
>> performance when in non-debug mode.
>
> Where is this done? I don't think it's in the MQD setup because that 
> happens unconditionally on all GPUs.

If I understand it correctly, it's done by actually enabling the debug 
trap in patch 9 (for Aldebaran). For single-process debug devices, the 
debug trap is always on, as per this patch.

Maybe just add a reference to the Aldebaran patch to make it clearer.

Regards,
   Felix


>
>
>>
>> The debugger requires that TTMPs 6 & 7 save the dispatch ID to map
>> waves onto dispatch during compute context inspection.
>> In order to correctly this up, set the special reserved CP bit by 
>> default
>> whenever the MQD is initailized.
>
> There is a word missing here. "In order to correctly _set_ this up ..."?
>
> This patch covers GFXv9 and 10. Will GFXv11 be handled separately?
>
> Regards,
>   Felix
>
>
>>
>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 26 +++++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 30 ++++++++
>>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  5 ++
>>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  5 ++
>>   .../include/asic_reg/gc/gc_10_1_0_offset.h    | 14 ++++
>>   .../include/asic_reg/gc/gc_10_1_0_sh_mask.h   | 69 +++++++++++++++++++
>>   .../include/asic_reg/gc/gc_10_3_0_offset.h    | 10 +++
>>   .../include/asic_reg/gc/gc_10_3_0_sh_mask.h   |  4 ++
>>   8 files changed, 163 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index af94ac580d3e..d49aff0b4ba3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -4904,6 +4904,29 @@ static u32 
>> gfx_v10_0_init_pa_sc_tile_steering_override(struct amdgpu_device *ade
>>     #define DEFAULT_SH_MEM_BASES    (0x6000)
>>   +static void gfx_v10_0_debug_trap_config_init(struct amdgpu_device 
>> *adev,
>> +                uint32_t first_vmid,
>> +                uint32_t last_vmid)
>> +{
>> +    uint32_t data;
>> +    uint32_t trap_config_vmid_mask = 0;
>> +    int i;
>> +
>> +    /* Calculate trap config vmid mask */
>> +    for (i = first_vmid; i < last_vmid; i++)
>> +        trap_config_vmid_mask |= (1 << i);
>> +
>> +    data = REG_SET_FIELD(0, SPI_GDBG_TRAP_CONFIG,
>> +            VMID_SEL, trap_config_vmid_mask);
>> +    data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
>> +            TRAP_EN, 1);
>> +    WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
>> +    WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
>> +
>> +    WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA0), 0);
>> +    WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA1), 0);
>> +}
>> +
>>   static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
>>   {
>>       int i;
>> @@ -4935,6 +4958,9 @@ static void gfx_v10_0_init_compute_vmid(struct 
>> amdgpu_device *adev)
>>           WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
>>           WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
>>       }
>> +
>> +    gfx_v10_0_debug_trap_config_init(adev, 
>> adev->vm_manager.first_kfd_vmid,
>> +                    AMDGPU_NUM_VMID);
>>   }
>>     static void gfx_v10_0_init_gds_vmid(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 0320be4a5fc6..a0e5ad342f13 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -2337,6 +2337,29 @@ static void gfx_v9_0_setup_rb(struct 
>> amdgpu_device *adev)
>>       adev->gfx.config.num_rbs = hweight32(active_rbs);
>>   }
>>   +static void gfx_v9_0_debug_trap_config_init(struct amdgpu_device 
>> *adev,
>> +                uint32_t first_vmid,
>> +                uint32_t last_vmid)
>> +{
>> +    uint32_t data;
>> +    uint32_t trap_config_vmid_mask = 0;
>> +    int i;
>> +
>> +    /* Calculate trap config vmid mask */
>> +    for (i = first_vmid; i < last_vmid; i++)
>> +        trap_config_vmid_mask |= (1 << i);
>> +
>> +    data = REG_SET_FIELD(0, SPI_GDBG_TRAP_CONFIG,
>> +            VMID_SEL, trap_config_vmid_mask);
>> +    data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
>> +            TRAP_EN, 1);
>> +    WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
>> +    WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
>> +
>> +    WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA0), 0);
>> +    WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA1), 0);
>> +}
>> +
>>   #define DEFAULT_SH_MEM_BASES    (0x6000)
>>   static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
>>   {
>> @@ -4609,6 +4632,13 @@ static int gfx_v9_0_late_init(void *handle)
>>       if (r)
>>           return r;
>>   +    if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
>> +        gfx_v9_4_2_debug_trap_config_init(adev,
>> +            adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
>> +    else
>> +        gfx_v9_0_debug_trap_config_init(adev,
>> +            adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
>> +
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
>> index d3e2b6a599a4..cb484ace17de 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
>> @@ -117,6 +117,11 @@ static void init_mqd(struct mqd_manager *mm, 
>> void **mqd,
>>               1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT |
>>               1 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
>>   +    /* Set cp_hqd_hq_scheduler0 bit 14 to 1 to have the CP set up the
>> +     * DISPATCH_PTR.  This is required for the kfd debugger
>> +     */
>> +    m->cp_hqd_hq_scheduler0 = 1 << 14;
>> +
>>       if (q->format == KFD_QUEUE_FORMAT_AQL) {
>>           m->cp_hqd_aql_control =
>>               1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> index 0778e587a2d6..86f1cf090246 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> @@ -164,6 +164,11 @@ static void init_mqd(struct mqd_manager *mm, 
>> void **mqd,
>>               1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT |
>>               1 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
>>   +    /* Set cp_hqd_hq_scheduler0 bit 14 to 1 to have the CP set up the
>> +     * DISPATCH_PTR.  This is required for the kfd debugger
>> +     */
>> +    m->cp_hqd_hq_status0 = 1 << 14;
>> +
>>       if (q->format == KFD_QUEUE_FORMAT_AQL) {
>>           m->cp_hqd_aql_control =
>>               1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
>> diff --git 
>> a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h 
>> b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>> index 18d34bbceebe..7d384f86bd67 100644
>> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>> @@ -5190,6 +5190,20 @@
>>   #define mmSPI_WCL_PIPE_PERCENT_CS6_BASE_IDX 0
>>   #define mmSPI_WCL_PIPE_PERCENT_CS7 0x1f70
>>   #define mmSPI_WCL_PIPE_PERCENT_CS7_BASE_IDX 0
>> +#define mmSPI_GDBG_WAVE_CNTL 0x1f71
>> +#define mmSPI_GDBG_WAVE_CNTL_BASE_IDX 0
>> +#define mmSPI_GDBG_TRAP_CONFIG 0x1f72
>> +#define mmSPI_GDBG_TRAP_CONFIG_BASE_IDX 0
>> +#define mmSPI_GDBG_TRAP_MASK 0x1f73
>> +#define mmSPI_GDBG_TRAP_MASK_BASE_IDX 0
>> +#define mmSPI_GDBG_WAVE_CNTL2 0x1f74
>> +#define mmSPI_GDBG_WAVE_CNTL2_BASE_IDX 0
>> +#define mmSPI_GDBG_WAVE_CNTL3 0x1f75
>> +#define mmSPI_GDBG_WAVE_CNTL3_BASE_IDX 0
>> +#define mmSPI_GDBG_TRAP_DATA0 0x1f78
>> +#define mmSPI_GDBG_TRAP_DATA0_BASE_IDX 0
>> +#define mmSPI_GDBG_TRAP_DATA1 0x1f79
>> +#define mmSPI_GDBG_TRAP_DATA1_BASE_IDX 0
>>   #define mmSPI_COMPUTE_QUEUE_RESET 0x1f7b
>>   #define mmSPI_COMPUTE_QUEUE_RESET_BASE_IDX 0
>>   #define mmSPI_RESOURCE_RESERVE_CU_0 0x1f7c
>> diff --git 
>> a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h 
>> b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
>> index 4127896ffcdf..08772ba845b0 100644
>> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
>> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
>> @@ -19646,6 +19646,75 @@
>>   //SPI_WCL_PIPE_PERCENT_CS7
>>   #define SPI_WCL_PIPE_PERCENT_CS7__VALUE__SHIFT 0x0
>>   #define SPI_WCL_PIPE_PERCENT_CS7__VALUE_MASK 0x7FL
>> +//SPI_GDBG_WAVE_CNTL
>> +#define SPI_GDBG_WAVE_CNTL__STALL_RA__SHIFT 0x0
>> +#define SPI_GDBG_WAVE_CNTL__STALL_VMID__SHIFT 0x1
>> +#define SPI_GDBG_WAVE_CNTL__STALL_RA_MASK 0x00000001L
>> +#define SPI_GDBG_WAVE_CNTL__STALL_VMID_MASK 0x0001FFFEL
>> +//SPI_GDBG_TRAP_CONFIG
>> +#define SPI_GDBG_TRAP_CONFIG__ME_SEL__SHIFT 0x0
>> +#define SPI_GDBG_TRAP_CONFIG__PIPE_SEL__SHIFT 0x2
>> +#define SPI_GDBG_TRAP_CONFIG__QUEUE_SEL__SHIFT 0x4
>> +#define SPI_GDBG_TRAP_CONFIG__ME_MATCH__SHIFT 0x7
>> +#define SPI_GDBG_TRAP_CONFIG__PIPE_MATCH__SHIFT 0x8
>> +#define SPI_GDBG_TRAP_CONFIG__QUEUE_MATCH__SHIFT 0x9
>> +#define SPI_GDBG_TRAP_CONFIG__TRAP_EN__SHIFT 0xf
>> +#define SPI_GDBG_TRAP_CONFIG__VMID_SEL__SHIFT 0x10
>> +#define SPI_GDBG_TRAP_CONFIG__ME_SEL_MASK 0x00000003L
>> +#define SPI_GDBG_TRAP_CONFIG__PIPE_SEL_MASK 0x0000000CL
>> +#define SPI_GDBG_TRAP_CONFIG__QUEUE_SEL_MASK 0x00000070L
>> +#define SPI_GDBG_TRAP_CONFIG__ME_MATCH_MASK 0x00000080L
>> +#define SPI_GDBG_TRAP_CONFIG__PIPE_MATCH_MASK 0x00000100L
>> +#define SPI_GDBG_TRAP_CONFIG__QUEUE_MATCH_MASK 0x00000200L
>> +#define SPI_GDBG_TRAP_CONFIG__TRAP_EN_MASK 0x00008000L
>> +#define SPI_GDBG_TRAP_CONFIG__VMID_SEL_MASK 0xFFFF0000L
>> +//SPI_GDBG_TRAP_MASK
>> +#define SPI_GDBG_TRAP_MASK__EXCP_EN__SHIFT 0x0
>> +#define SPI_GDBG_TRAP_MASK__REPLACE__SHIFT 0x9
>> +#define SPI_GDBG_TRAP_MASK__EXCP_EN_MASK 0x01FFL
>> +#define SPI_GDBG_TRAP_MASK__REPLACE_MASK 0x0200L
>> +//SPI_GDBG_WAVE_CNTL2
>> +#define SPI_GDBG_WAVE_CNTL2__VMID_MASK__SHIFT 0x0
>> +#define SPI_GDBG_WAVE_CNTL2__MODE__SHIFT 0x10
>> +#define SPI_GDBG_WAVE_CNTL2__VMID_MASK_MASK 0x0000FFFFL
>> +#define SPI_GDBG_WAVE_CNTL2__MODE_MASK 0x00030000L
>> +//SPI_GDBG_WAVE_CNTL3
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_PS__SHIFT 0x0
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_VS__SHIFT 0x1
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_GS__SHIFT 0x2
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_HS__SHIFT 0x3
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_CSG__SHIFT 0x4
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS0__SHIFT 0x5
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS1__SHIFT 0x6
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS2__SHIFT 0x7
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS3__SHIFT 0x8
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS4__SHIFT 0x9
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS5__SHIFT 0xa
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS6__SHIFT 0xb
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS7__SHIFT 0xc
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_DURATION__SHIFT 0xd
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_MULT__SHIFT 0x1c
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_PS_MASK 0x00000001L
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_VS_MASK 0x00000002L
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_GS_MASK 0x00000004L
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_HS_MASK 0x00000008L
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_CSG_MASK 0x00000010L
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS0_MASK 0x00000020L
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS1_MASK 0x00000040L
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS2_MASK 0x00000080L
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS3_MASK 0x00000100L
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS4_MASK 0x00000200L
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS5_MASK 0x00000400L
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS6_MASK 0x00000800L
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS7_MASK 0x00001000L
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_DURATION_MASK 0x0FFFE000L
>> +#define SPI_GDBG_WAVE_CNTL3__STALL_MULT_MASK 0x10000000L
>> +//SPI_GDBG_TRAP_DATA0
>> +#define SPI_GDBG_TRAP_DATA0__DATA__SHIFT 0x0
>> +#define SPI_GDBG_TRAP_DATA0__DATA_MASK 0xFFFFFFFFL
>> +//SPI_GDBG_TRAP_DATA1
>> +#define SPI_GDBG_TRAP_DATA1__DATA__SHIFT 0x0
>> +#define SPI_GDBG_TRAP_DATA1__DATA_MASK 0xFFFFFFFFL
>>   //SPI_COMPUTE_QUEUE_RESET
>>   #define SPI_COMPUTE_QUEUE_RESET__RESET__SHIFT 0x0
>>   #define SPI_COMPUTE_QUEUE_RESET__RESET_MASK 0x01L
>> diff --git 
>> a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h 
>> b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
>> index 3973110f149c..d09f1a06f4bf 100644
>> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
>> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
>> @@ -26,6 +26,8 @@
>>   #define mmSQ_DEBUG_STS_GLOBAL_BASE_IDX 0
>>   #define mmSQ_DEBUG_STS_GLOBAL2 0x10B0
>>   #define mmSQ_DEBUG_STS_GLOBAL2_BASE_IDX 0
>> +#define mmSQ_DEBUG 0x10B1
>> +#define mmSQ_DEBUG_BASE_IDX 0
>>     // addressBlock: gc_sdma0_sdma0dec
>>   // base address: 0x4980
>> @@ -4849,10 +4851,18 @@
>>   #define mmSPI_WCL_PIPE_PERCENT_CS3_BASE_IDX 0
>>   #define mmSPI_GDBG_WAVE_CNTL 0x1f71
>>   #define mmSPI_GDBG_WAVE_CNTL_BASE_IDX 0
>> +#define mmSPI_GDBG_TRAP_CONFIG 0x1f72
>> +#define mmSPI_GDBG_TRAP_CONFIG_BASE_IDX 0
>>   #define mmSPI_GDBG_TRAP_MASK 0x1f73
>>   #define mmSPI_GDBG_TRAP_MASK_BASE_IDX 0
>>   #define mmSPI_GDBG_WAVE_CNTL2 0x1f74
>>   #define mmSPI_GDBG_WAVE_CNTL2_BASE_IDX 0
>> +#define mmSPI_GDBG_WAVE_CNTL3 0x1f75
>> +#define mmSPI_GDBG_WAVE_CNTL3_BASE_IDX 0
>> +#define mmSPI_GDBG_TRAP_DATA0 0x1f78
>> +#define mmSPI_GDBG_TRAP_DATA0_BASE_IDX 0
>> +#define mmSPI_GDBG_TRAP_DATA1 0x1f79
>> +#define mmSPI_GDBG_TRAP_DATA1_BASE_IDX 0
>>   #define mmSPI_COMPUTE_QUEUE_RESET 0x1f7b
>>   #define mmSPI_COMPUTE_QUEUE_RESET_BASE_IDX 0
>>   #define mmSPI_RESOURCE_RESERVE_CU_0 0x1f7c
>> diff --git 
>> a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h 
>> b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
>> index d4e8ff22ecb8..fc85aee010fe 100644
>> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
>> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
>> @@ -47853,6 +47853,10 @@
>>       // addressBlock: sqind
>> +//SQ_DEBUG
>> +#define SQ_DEBUG__SINGLE_MEMOP_MASK 0x00000001L
>> +#define SQ_DEBUG__SINGLE_MEMOP__SHIFT 0x00000000
>> +
>>   //SQ_DEBUG_STS_GLOBAL
>>   #define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0_MASK 0x000000ffL
>>   #define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0__SHIFT 0x00000000
