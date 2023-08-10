Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43942C001DE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 21:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B011810E035;
	Thu, 10 Aug 2023 21:27:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7126B10E035
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 21:27:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XN6BzYsVDB/07Xt8fKZP6Y55gEV7ffjgLAG6ACShz406dUEDxhB3LAe3EUp9OhHyjoqwE2SOlPLtHna5ll2ga47ov+xlrioTqElix/2Cf1jchjMiEf/jzv2MpfgRG+C5glayrUyTsyBfxSy07zTxtk8WYJbIsV9zOB28MAZTvdY4FTe8zwJFZV5x+uROcg2lT6cpZma2GpyZEw5BWFfmjGB9AifNkU7CXOsmXfTTht+lUTTHWm3Xv/XjAB68Kz1uHCkUSLgr3VQtfz+1jQm0uLD/rG6K0sVALSuzIECXzCZdscUFnDTiSFYyc9aELLBubx7hIRWcnlUqdrPB8Sa+XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oE7jgOyaBFQybc//Ctp7mn50oFoc9ZbnIKAIJ+gR1o=;
 b=ITXnWWcsZAZSq85pNMYAJgprB6YJcWEgQi3Mm9m1qg/mgk5sMfIu5bxVMmvd/HpF2UXoShv9t4icUpGeFxZWbYtnw6hUeCH9M5IMzNjRPcFYXmaWqpsqRAzB4adM+kgcw639+WSGtA0H7LYnw9Y3bRC8e7M5AsptAoqzP6LG9PLNtCMMrUyux7qIvH5CDkANHLva5uxcANF7jW6Cm+tFmFt/bjrXNyOdAaYO6maWFQcZZjBAZ8aNz1gWVxgXc00YYmamf5CNj7nNISOLcRudB1pXOxPcRo5SfI6R5GIvyLL2N8DbvSFd1lCQYXFv+HpZASv4LDVFtrAWlpZlNFNWIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oE7jgOyaBFQybc//Ctp7mn50oFoc9ZbnIKAIJ+gR1o=;
 b=1du+UdEIr9cVaq9nhysboLIyB8fhcOMxkbwYClG6saB88oE8rNI7dbobHE1M6NejH3GSslLx4g7kwB1Bc27FbflAPIBa6a6CIuIHiUo4r4Irysu375zWmwMTquCjwK2VKkEaJT5VuqngDt/Oc9kine/da1Tn55AaP8VF6PqMv3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 21:27:02 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::4d2a:6792:2239:9e72]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::4d2a:6792:2239:9e72%5]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 21:27:02 +0000
Message-ID: <520e316e-19fd-e96d-8009-019d6716968d@amd.com>
Date: Thu, 10 Aug 2023 17:26:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] drm/amdkfd: fix address watch clearing bug for gfx v9.4.2
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230810204744.195416-1-jinhuieric.huang@amd.com>
 <0a20bc13-312c-15b2-ea40-33cce76bb8eb@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <0a20bc13-312c-15b2-ea40-33cce76bb8eb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::14) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: c56ac3fa-f3ea-41d5-2e2d-08db99e8897d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0zVfQGxkw516tfadOpxecCwoewRHx5+ibl7b4fyQeENdMEc3fDYpvC3h55Yvu8lrpTOBafA1ogAnQDW/UR/v4Or3BUr/PMth147lovQl0Zsq36ZZ8CtKTpS2ONLIZOGY1GkNVTX438rKC+FwtasZC+f5+hxsIcNscwkRY/fjkSR3W5CzTACNBSh82GlhWYjmyXGejFOnYdzdPrr+STRT4lLQlapKtoI4ou/zpQq9vYJGDdMQWkUxbZ9fjGS9TXiykdJItwu3QnTfD4DY868xhYbNKcm4A+YU5VIWiRfoOGbG8w44IXNKgHEtumlTbzbWxCDlcU3uWWPcHWyGubJV6zOfYHbu8C8VoXJxCT+w4weeFrdhzDWNfvGnJgp3a4U4LhOX8ecaUvPKaR66W0M5FkEqWAMabWEVGhDgYllUqwaZK5VCRm1k289yo8xQoNZOApR5sgDLs7wlpL6AExoDirMOrmAsE8mKtcoKbJ21eVArl+K/3mOG59zpRwweIOoMNWLEROeqx42Sm60nrjsrQMlFlf/xZl7wdGfMqRfJEw5hkfH1tJO1E+dO1tdot5q4V+wgCFoWq5xgrTaVmlm0grWYCSxjHYWDtOB+zotdUuBogkZs3FuhJmDIvnl2+CKaZKAQBxpwoj0lmNlXt1t+6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(1800799006)(186006)(451199021)(6512007)(4326008)(66556008)(66476007)(66946007)(6666004)(316002)(478600001)(6486002)(31686004)(53546011)(8936002)(8676002)(5660300002)(26005)(6506007)(41300700001)(86362001)(31696002)(36756003)(38100700002)(2616005)(83380400001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkk5U1BGRFRYTmk4ejZCbUhkbklycjRIbHBpT01Ra09oRU1rTXZ0Y1ptS1JO?=
 =?utf-8?B?R2szV2h5MUpIcGE4bFJyUWVxWWhsOUsvSjlIMXd3NGh0UUZnbGNlY3pqRFFw?=
 =?utf-8?B?a2d3QnUrdFU0clc0dWdwajhxbjlOWEJPUkxYOStQUkJoNHcyTEI1UzBJUkh6?=
 =?utf-8?B?N0FQL1FpdkRqeCtpbEp2VHN3SVAyR3pvbElSb2NTbVBiZ3pTcm81eWxHTGNH?=
 =?utf-8?B?SDIrQ25UemtTQmxMUlVxUmx6MmQ0WmQ0aXNteWg3d1Z0ajNiOE9iTkZSQWtx?=
 =?utf-8?B?eklOcmJ2YlVSZ2ljSjhJUDBnZy93TTJrWFkycnpCZ2NsV3lyWkREMllhOU1D?=
 =?utf-8?B?MW9IdnBXSTJYVFdmT0pkclBXU0lSRm91TTNuemxwTDVGaXd1ODg2M0VKZDhT?=
 =?utf-8?B?NFIvNDdlWXBwMTNOdThOWjNWbGVwSkxKMC8wb2xLRkd4WFk5ZFF6YUFIelBx?=
 =?utf-8?B?SWNpSW9UOS9BbkZ3Q0MwbklWWXUxZ0daVUpOcE5LNXNodzlsTWVYa2phZWNk?=
 =?utf-8?B?SW5nTlZqazlQN1dHU3BMNTgvcDB3dkkvTjl1SWU1akh3SUl2Uzc5bzJ0VVJ3?=
 =?utf-8?B?QU1lQTd3bEZIRWZwcUpZcnRUcVZCN2FiM1JUSVpXQ2NWQlRhaGtyUlp1M3k1?=
 =?utf-8?B?OENOMVJ6Ry9jcWphdVNyZG5rSlVDNTJRbGlMS01XQW9TU2ppeVM3dVk4K3Vj?=
 =?utf-8?B?ZDcrV3J2MCtZOWo1THhhVjMvaUFyRmZoWXQ3STRpMFJDSEtmQjhybEZXSHBR?=
 =?utf-8?B?K3VmQnJBUzB6eUsrQ0VqOXZNYkRob1RYb2FHVThJWWFvYUkvR1lKTUx1dDdE?=
 =?utf-8?B?M01sOXVaTmZCbmZEQjRIMXhKRWFYTm43dWcxQjBmZU1idDJkM0ZDdldsNTVs?=
 =?utf-8?B?UktmTkYwUit4MlZUN1QvY01FWlFHOUplZ0pPQkk0cXd0Zzlyckl1QWtrS2kv?=
 =?utf-8?B?Uk9mZ0hoQW82Und0VmMzWUhuS3grVUVVQlZzSjJRUk9hU0M5U2NLcWFCYVFG?=
 =?utf-8?B?QkkxcktWcnpabE56T0hGRGZQYXFkZnZHbU5VSm50L0FwWFg4aU8zYlFBcjlE?=
 =?utf-8?B?U0tyRjlycDhzeWkvcCthQUphUHlMUjN4WURUSnliZmJDLzVNKzQ2K0ZOYU1o?=
 =?utf-8?B?b084WXIxd0ZoWXN4R1FWV083LytCbm5xTWIzeGpDYXM0T3E0SjlaenU3SFRa?=
 =?utf-8?B?MmgwdE5MRkZkZHJBcEVCSkwzc2JCbTJncTdVSTBtYUdiYWNNY0d6OHB2clBY?=
 =?utf-8?B?dnNacWtEZlBEWGtkQVdGNnA0YXhWM1RDdUFVdHU1c0pZL3BESGs3dDl1eVgv?=
 =?utf-8?B?TUZ6WVR6VGVYcVN4L0c4UkhGNkl4WVV1cXpZZFRkalJlYmNQbmloWGVtL256?=
 =?utf-8?B?T2grcVJvVWtFaFBDY2RaVXlweTJxVXoxNElQOGdlN1dpanE5cG55dytCQ3Y1?=
 =?utf-8?B?eE03SXZKa2lZbHM3M1FNbXU0anh0S1djM0gzNmhwMlZwU0RaQklxb3FOWUVw?=
 =?utf-8?B?QzV1NURCak1MNGpZbGF5Q3BtN0I1elVrUi9mbUg3ajUxaTNWeHVhenk5YWhV?=
 =?utf-8?B?UkpVVHhqd00zZk8raXJjVkZxVUpnbmR1UHBiVkxhZXZZWlBCM0VPQnpGZ2dD?=
 =?utf-8?B?Z0FBRi9mSTJKdXJwc3hPTENTOHkvZDJMSks2bE9GYUZpQmNpaEdxMkgycTlI?=
 =?utf-8?B?Z0k4dk1BOW9iVnRsUkU3bVowdVZGampsVEtuQnJGS2pET05PbWJnZUovN29U?=
 =?utf-8?B?WFRPUVVVbUR0dUh5YUFGRUl2YnR1eHc4UzJ1MEZ5c2J6UktBMjNDY05hMFlz?=
 =?utf-8?B?L1pWdjZPQktkM0tsYmYzaysxRXZPVVljT1loZm1XMGIvZFViTkhWNW90cDN1?=
 =?utf-8?B?cmRIbmJ4M21BSDgzMnZFeXE5clFEZXNnWjB0eUluYnUzZkljRUFYL09QL0pK?=
 =?utf-8?B?aUVsY1FwODRmTENBcjFVOEl0TVNReDBBak9tVnltK1FYZG01RFAzbEc5dEZw?=
 =?utf-8?B?aXQwMWg3eThzcEFWOHJyM1B2Z2JtalRHWlhrR21CQmoraWlnUEp4U3VkTDdI?=
 =?utf-8?B?MHluSk5xNm1Fb0NNQzlsUE5MU1lmL04wYkM2SHRtVkhzSUZEMzJtcERLYk5k?=
 =?utf-8?Q?VS9PXWcZcucIIenEdbHCHbc5V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56ac3fa-f3ea-41d5-2e2d-08db99e8897d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 21:27:02.2946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LK7N5sXopSOpVFcRhJgQm5izEuGwWWsSONavHFcvE35gz7Iqwiz3SEzi6brT5G5MKUjLTXRcvPU8Y7DuVJBbKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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
Cc: Jonathan.Kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yes. I will send out the fix for gc v9.4.3 later. Thanks for your review.

Eric

On 2023-08-10 17:02, Felix Kuehling wrote:
> I think amdgpu_amdkfd_gc_9_4_3.c needs a similar fix. But maybe a bit 
> different because it needs to support multiple XCCs.
>
> That said, this patch is
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
> On 2023-08-10 16:47, Eric Huang wrote:
>> KFD currently relies on MEC FW to clear tcp watch control
>> register by sending MAP_PROCESS packet with 0 of field
>> tcp_watch_cntl to HWS, but if the queue is suspended, the
>> packet will not be sent and the previous value will be
>> left on the register, that will affect the following apps.
>> So the solution is to clear the register as gfx v9 in KFD.
>>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>> index e2fed6edbdd0..aff08321e976 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>> @@ -163,12 +163,6 @@ static uint32_t 
>> kgd_gfx_aldebaran_set_address_watch(
>>       return watch_address_cntl;
>>   }
>>   -static uint32_t kgd_gfx_aldebaran_clear_address_watch(struct 
>> amdgpu_device *adev,
>> -                              uint32_t watch_id)
>> -{
>> -    return 0;
>> -}
>> -
>>   const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>>       .program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
>>       .set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
>> @@ -193,7 +187,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>>       .set_wave_launch_trap_override = 
>> kgd_aldebaran_set_wave_launch_trap_override,
>>       .set_wave_launch_mode = kgd_aldebaran_set_wave_launch_mode,
>>       .set_address_watch = kgd_gfx_aldebaran_set_address_watch,
>> -    .clear_address_watch = kgd_gfx_aldebaran_clear_address_watch,
>> +    .clear_address_watch = kgd_gfx_v9_clear_address_watch,
>>       .get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
>>       .build_grace_period_packet_info = 
>> kgd_gfx_v9_build_grace_period_packet_info,
>>       .program_trap_handler_settings = 
>> kgd_gfx_v9_program_trap_handler_settings,

