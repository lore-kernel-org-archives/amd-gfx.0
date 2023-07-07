Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB05EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 15:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 267B310E5B5;
	Fri,  7 Jul 2023 15:45:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0970910E5B5
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 15:45:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSh5dY/yQ7D4j5SdBXDZIgLls0P1ANJhyLhkMpuhOWVqfR6NyoZT7RPf9eBO7/pULKCHHyLR906pyUZrTTBji4wQJ3wDHmkuqQWNDrzI3+ewqpMgA06HeakIKDgRxV4DyK3LUCd+50Owa3lwszG3uV8C5z2BhgjIzXW1+k9UREt28qScBB45kRexH8Tm5RPKhLG6RGODvf2Re6xT/eUz7NcyMxcy2PNNj+qrRKGfcqey08S0JXwu/BraRPtZMGBCtis51MorMADIofNrYOwzla75qTyMqhHOHTtqu+Czj9ZvFzTf1hmMCURH+1srIecE+/uNnxJpWxIGZ+KmgCktVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkrNEbLoyexuUjS6qh7Iv77ErfnsOqX/9UpUQrJ5m8M=;
 b=VZUAIBVuZVszk0VdNyykpRChXpektIPtP1lpk9hHu0YBTOpOL+neR2hNNf1mqaCmFOfzosCMLEKslg7jY/s3IuDlOJyoY4F0j61JlZ+VMbWMPkRY+lT4CxxPikXj9GtJTDOONupqPEal85owPweTiTyvOu4YO8QxI2KC1Y98B/TgEb3MkwqJXNUq4MZv2HF7ZFxuhdXSfrERbDxqwipuJpVfNsSt1H1sv6sX7emOiUGAHdaPjzGrnEVB0r8U1auWW5uGxatEsh6qKSvnX+LfxR6PJkc7IjfPzPtGMdt+yZ55zH4pXnQykQCW1pz+Cxs5Ub0vHbH130ch8ZVo+i54hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkrNEbLoyexuUjS6qh7Iv77ErfnsOqX/9UpUQrJ5m8M=;
 b=bcg9A6gau4r4h/StTsSCVoi6paewusZQguAGJZ254cFIgX3mSCpglTo279GVjox2yhIiExDdpYxC1O4IFishwmXT+45MJbtfDJEoMvmQANX+kQQ7uIGltJHtIRr5/AH6WuHDFdnxNYujtOHUbTD/3JH/zYX/sUY5D/vbr32z1jE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by DM3PR12MB9326.namprd12.prod.outlook.com (2603:10b6:0:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.8; Fri, 7 Jul
 2023 15:45:34 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d798:c26b:8d50:aa2c]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d798:c26b:8d50:aa2c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 15:45:34 +0000
Message-ID: <ab49d1db-c386-993d-67d5-b638dad121f7@amd.com>
Date: Fri, 7 Jul 2023 11:45:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/6] drm/amdkfd: enable grace period for xcc instance
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230706181918.189722-1-jinhuieric.huang@amd.com>
 <20230706181918.189722-5-jinhuieric.huang@amd.com>
 <CY8PR12MB74359A316EAE92978FA47386852DA@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <CY8PR12MB74359A316EAE92978FA47386852DA@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::24) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|DM3PR12MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f4cc8a-bc19-4277-13f2-08db7f013389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6J+B0PzX4C1dNrQww8lh+DXoH0DemGYerZjed1Pu/e7N9y+6L3Leevozwa7J5AEFAqBpmIcqSc1DbnBut23t3/5ttwJDTsKncHQEMxQE1JV1FJtcwqZMqMOfUnIXZgb0MLvxm3ho0fwqBndsdN3VNmcEth/KEkH7YkdWwahahvwpsecv7WecFaiL91SUSM4IYigLzHu6B+/fiTi6O2xe2tkypGTy7mWvH7qh3lifhWQAYpfFMc4RqxPxYtxnAAuC3HGcDxg47KnhavnQwtOyJsDFZDBuY+439mjncHf+MKPrlSPyflp07MqW4gw3d2ORslDQiu/Ulf38TgldaG9+l3oDOllKhlR2skVRLL/gtOE5DeZjDekPjbP4QPAeFrDF2LTJ/iNCHUqs7txeL4aMEe4ZApJjspZZmWGNuqTiGUs8luAfKEruE8y+amNQLcK1KXuFd+x9EAhNTWOc7X2qM5Wggu5utEuD4wr5bD06DZM+J60T2dkoi72nPKRb9f3VTn/fFqFhNVxr8AbshSFuqMJQVhc/By1vd3cJ+jGVULUYQXfo/nbORFGdVzbDUh8DrNSuRodhsdqqwCQ73ZJnruBmO82QTjZ8ueTxeG8yhqLJIXiwfG80Np9Veg8+97cYLQ38uKV/XSJ8O/0xZQxYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(2906002)(41300700001)(8676002)(36756003)(8936002)(31696002)(26005)(186003)(2616005)(5660300002)(6506007)(6666004)(6512007)(31686004)(478600001)(6486002)(53546011)(316002)(66476007)(66946007)(66556008)(38100700002)(110136005)(83380400001)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFltbDNKWllYL0xUUUFTQmhuNytkdUNOejJIMWtjaUpDTjFON2tNUUkvVzVF?=
 =?utf-8?B?Sjd4VWhuNE9ra1k3bTNIaVcxcVg0YUp4YzZMOGhVNk95MUk3MTIraU1YUS9t?=
 =?utf-8?B?VVh1a3JYS3VQUWwvMXJzQXlUMHpqUGlESDJLNk5kK01xNXhBODJSeVdzR1hT?=
 =?utf-8?B?bk85OVd0bDJHODRuUk11NGkvYmpUU05ZVlZkck4vNXQ2cDFGWUt2dkJHZ2xG?=
 =?utf-8?B?ZVV3dE9DR05UMTB4ckY3SU5keUh4SnNPU3N5ZnNYeGNzVmxKL3dvNm9pUlF0?=
 =?utf-8?B?cmtLaExRV1pyOHY5NWowQ2hOa3dFTlBUYy9jYzFodmY4OFFlN01zNExTZmps?=
 =?utf-8?B?ZS9lU0g3Mk84SVJkSjY2UTFRWk16WU9zNStZZVp2TlJmbmt4bEVQSUd0dW1h?=
 =?utf-8?B?NVBQcWhZeUJvcGR2L1RWVDhJMkxhLzBVelVZOHNJZmljUWp6S0xvc3BqOHdH?=
 =?utf-8?B?Rm5aV0VLTFE3QXZtZTZ1UmRRNndYSFVKL1NxbDgybzZ4QmNqUXZ0ZWM2ZXBM?=
 =?utf-8?B?NXNENDM0MDl2WkYyTStEM2FuZ1Fvek5TNFg0c05ZYXhNR2o4ajdxcUkySVRw?=
 =?utf-8?B?c3hDVWJPRTQ5YXA3K0Q5c0ZBL2owV1ZLSHNwUGhDQ2NVRHhIVWQyRHgwZ1d2?=
 =?utf-8?B?dFo3bUVGak1hcHZTSGR1a1hwSkQzYzN3L29LV3VwWER0VmdzdG9xMUF3b1ZG?=
 =?utf-8?B?eGlPMEpTTFJvVnU2dnRTYzIrSHhBa0R1elovK3ZpVjMzbkt3d2ZJS0ttMFRC?=
 =?utf-8?B?LzVFRktncUkrUXRpdCtnL2x2RHAxRW9JVzNNWEtFMTA5aFJFQnFORXJtRy84?=
 =?utf-8?B?ZHc4c2s2KzI0M0hKUWhwYXBQdG5jVXdsc3V0N3dsZFhmZzVTQWNxL0NwdXhQ?=
 =?utf-8?B?VS9RWHIwWHBIeko4c2FTT0l6dDFTQmo3c3d5RHpqczdWTTFVK3JxTmhsNHdo?=
 =?utf-8?B?RnpUNGNNTkp3WUhtQU9SN213SjJKTHBwU09EelY3ZlBubEVML1kyTHZ6dGxm?=
 =?utf-8?B?aWtzbHlvNmZPSFVrdmpGcnVhR0Y2Z3NBSzdvamxZcVJnTHlUbU5NeEF2bk8v?=
 =?utf-8?B?SjB6WUxKNE51bENkL3dqVElXU1dOanhiOFFGQ1ZVZ2VGVE9lTDhWS2l6d2ZS?=
 =?utf-8?B?Z0FBOXJVdktaSGEzTEdsS0NIbFFDVjg4Vnl3eXJ2aGxRYXlGQ0t6MXB4MjRJ?=
 =?utf-8?B?MWhEZk1LR0hGZC8yT3p4NXpQMVV4Q09Uak1UYUk4R2U0L013V0pianh0c3B2?=
 =?utf-8?B?ZVRWNWsxZnRhdWRyYWU2SGRPaW5sWUpqSlBKMitmOTYyeUM5aTBSdlRxZnlH?=
 =?utf-8?B?M0RhendCdDZudFBUMXhSdnN6M0w5aml2aGRON1B0OHhiZzRvaWYyZ0JpcXZX?=
 =?utf-8?B?a0pOQW9PZFo3YXJubFNEVHpGMTV3Z0VOZGQ4UytQRVcxQThLYXVuL0RUd0Zl?=
 =?utf-8?B?TDVsVUpUMDh3Y2VmeTRKME9yMXkxc0FId1pNMVRsckVjejNCQzNYVmh1bC9F?=
 =?utf-8?B?MGIwL0NkdFBjRDVkYnBDWXFQSG1lLys1ZFZYM3puL1hFbWgxelArZ2xoT3Rm?=
 =?utf-8?B?QUFYMlRNRndsVDFvKzBiZFNTUG9renQ4aitqVklKTU4yNktKemdpelc4dzhq?=
 =?utf-8?B?bVFLd2R2M2Y4UGltQU5YdzA1Q1U1NnRMbE9rSmJiMkZQU1A5TzRLdWJRQ0ho?=
 =?utf-8?B?eDRQVWd4SU1HMGpEZUJScURlWXFJbklEc01NSktVZFlVclVUWW8vYk5CODdn?=
 =?utf-8?B?ZmcyUVk5UUdJdE1nbERVWjhGdm9ITHU5eHVHM01VaHEwY3luNFJrSGxkSzFy?=
 =?utf-8?B?OXJRV3AxcVkzZ2pVM21JNk4wNm56R0FObC8xZGlsc2x2ZXNrM3Vvcms4c1Av?=
 =?utf-8?B?eDBvdXR6M0RpTzFhcFhPenIrR2dsV1NENnRxUXNrODFOQjk3Wjd5clBCMlVG?=
 =?utf-8?B?aUplRGJUTU5PbHNYeGhzT2RXcmtJWlNLUVZhWmtmWHE5amwzWHNHc201Z1Ez?=
 =?utf-8?B?L05PMWVEM2V5Vk96UGVHSGMyallRMDJGMmoyeXNiZEFmMkd4TjdlMm1ZRDk1?=
 =?utf-8?B?Tlk1UUEzc1lLaWlUZmtJb2d1Zm1pSkZMYzhRRnFTSEEwcEJXaTlrcklZeStF?=
 =?utf-8?Q?nZANEL0PoJgqK/fbhB+c6O3AD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f4cc8a-bc19-4277-13f2-08db7f013389
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:45:34.1672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqIxpwlzaTqynpYqdq+EAM04LOSUJAbchi3+ptEHdxNuazxp0C4JXMwvFk5fZ26Y0d8Sdy+w9A9FVGSRDHfS9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9326
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


On 2023-07-07 10:59, Kim, Jonathan wrote:
> [Public]
>
>> -----Original Message-----
>> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
>> Sent: Thursday, July 6, 2023 2:19 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Huang, JinHuiEric
>> <JinHuiEric.Huang@amd.com>
>> Subject: [PATCH 4/6] drm/amdkfd: enable grace period for xcc instance
>>
>> each xcc instance needs to get iq wait time and set
>> grace period accordingly.
>>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>> ---
>>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  9 ++++--
>>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +-
>>   .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 32 +++++++++++--------
>>   .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  9 +++---
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>>   5 files changed, 32 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index a2bff3f01359..0f12c1989e14 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -1606,6 +1606,8 @@ static int set_sched_resources(struct
>> device_queue_manager *dqm)
>>
>>   static int initialize_cpsch(struct device_queue_manager *dqm)
>>   {
>> +     uint32_t xcc_id, xcc_mask = dqm->dev->xcc_mask;
>> +
>>        pr_debug("num of pipes: %d\n", get_pipes_per_mec(dqm));
>>
>>        mutex_init(&dqm->lock_hidden);
>> @@ -1620,8 +1622,11 @@ static int initialize_cpsch(struct
>> device_queue_manager *dqm)
>>        init_sdma_bitmaps(dqm);
>>
>>        if (dqm->dev->kfd2kgd->get_iq_wait_times)
>> -             dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
>> -                                     &dqm->wait_times, 0);
>> +             for_each_inst(xcc_id, xcc_mask)
>> +                     dqm->dev->kfd2kgd->get_iq_wait_times(
>> +                                     dqm->dev->adev,
>> +                                     &dqm->wait_times[xcc_id],
>> +                                     xcc_id);
>>        return 0;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>> index 7dd4b177219d..62a6dc8d3032 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>> @@ -262,7 +262,7 @@ struct device_queue_manager {
>>        /* used for GFX 9.4.3 only */
>>        uint32_t                current_logical_xcc_start;
>>
>> -     uint32_t                wait_times;
>> +     uint32_t                wait_times[32];
> I think wait_times[16] should be sufficient.  We only get the hamming weight of 16 bits for NUM_XCC and I believe the xcc_mask is declared as a uint16_t in the KGD portion anyway.  We may as well align to that.
>
>>        wait_queue_head_t       destroy_wait;
>>   };
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>> index 401096c103b2..f37ab4b6d88c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>> @@ -374,27 +374,31 @@ int pm_update_grace_period(struct
>> packet_manager *pm, uint32_t grace_period)
>>   {
>>        int retval = 0;
>>        uint32_t *buffer, size;
>> +     uint32_t xcc_id, xcc_mask = pm->dqm->dev->xcc_mask;
>>
>>        size = pm->pmf->set_grace_period_size;
>>
>>        mutex_lock(&pm->lock);
>>
>>        if (size) {
>> -             kq_acquire_packet_buffer(pm->priv_queue,
>> -                     size / sizeof(uint32_t),
>> -                     (unsigned int **)&buffer);
>> -
>> -             if (!buffer) {
>> -                     pr_err("Failed to allocate buffer on kernel queue\n");
>> -                     retval = -ENOMEM;
>> -                     goto out;
>> -             }
>> +             for_each_inst(xcc_id, xcc_mask) {
>> +                     kq_acquire_packet_buffer(pm->priv_queue,
>> +                                     size / sizeof(uint32_t),
>> +                                     (unsigned int **)&buffer);
>>
>> -             retval = pm->pmf->set_grace_period(pm, buffer,
>> grace_period);
>> -             if (!retval)
>> -                     kq_submit_packet(pm->priv_queue);
>> -             else
>> -                     kq_rollback_packet(pm->priv_queue);
>> +                     if (!buffer) {
>> +                             pr_err("Failed to allocate buffer on kernel
>> queue\n");
>> +                             retval = -ENOMEM;
>> +                             goto out;
>> +                     }
>> +
>> +                     retval = pm->pmf->set_grace_period(pm, buffer,
>> +                                     grace_period, xcc_id);
>> +                     if (!retval)
>> +                             kq_submit_packet(pm->priv_queue);
>> +                     else
>> +                             kq_rollback_packet(pm->priv_queue);
> In the event of partial success do we need to roll back (i.e. resubmit default grace period) on failure?
The function pm_set_grace_period_v9 always return 0, and it is not 
complicate operation, it should be always successful. Partial success 
will not be the case we should care about at this moment.

Regards,
Eric
> I believe the default grace period is put in place for better CWSR performance in normal mode, so leaving fast preemption settings on failure could impact performance.
>
> Thanks,
>
> Jon
>
>> +             }
>>        }
>>
>>   out:
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> index 8fda16e6fee6..a9443d661957 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> @@ -287,7 +287,8 @@ static int pm_map_queues_v9(struct packet_manager
>> *pm, uint32_t *buffer,
>>
>>   static int pm_set_grace_period_v9(struct packet_manager *pm,
>>                uint32_t *buffer,
>> -             uint32_t grace_period)
>> +             uint32_t grace_period,
>> +             uint32_t inst)
>>   {
>>        struct pm4_mec_write_data_mmio *packet;
>>        uint32_t reg_offset = 0;
>> @@ -295,14 +296,14 @@ static int pm_set_grace_period_v9(struct
>> packet_manager *pm,
>>
>>        pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
>>                        pm->dqm->dev->adev,
>> -                     pm->dqm->wait_times,
>> +                     pm->dqm->wait_times[inst],
>>                        grace_period,
>>                        &reg_offset,
>>                        &reg_data,
>> -                     0);
>> +                     inst);
>>
>>        if (grace_period == USE_DEFAULT_GRACE_PERIOD)
>> -             reg_data = pm->dqm->wait_times;
>> +             reg_data = pm->dqm->wait_times[inst];
>>
>>        packet = (struct pm4_mec_write_data_mmio *)buffer;
>>        memset(buffer, 0, sizeof(struct pm4_mec_write_data_mmio));
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index d4c9ee3f9953..22c4a403ddd7 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -1400,7 +1400,7 @@ struct packet_manager_funcs {
>>                        enum kfd_unmap_queues_filter mode,
>>                        uint32_t filter_param, bool reset);
>>        int (*set_grace_period)(struct packet_manager *pm, uint32_t *buffer,
>> -                     uint32_t grace_period);
>> +                     uint32_t grace_period, uint32_t inst);
>>        int (*query_status)(struct packet_manager *pm, uint32_t *buffer,
>>                        uint64_t fence_address, uint64_t
>> fence_value);
>>        int (*release_mem)(uint64_t gpu_addr, uint32_t *buffer);
>> --
>> 2.34.1

