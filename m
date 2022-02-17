Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAD3C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 09:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82A6010EBC1;
	Thu, 17 Feb 2022 09:45:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF2EE10EBC1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 09:45:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWh7O/agiYHINTMJ00x/2GVhqEfVd8PX1ZiRn6crRK92vDU4fbsHINsCAx5BIH8a+NjwCvQtTPT1+2JQRJeUObrzNDrk2a99mtI2SYvT1PRZi8g9OKhSGvSsT7Ls1ihAbYTRJMF9ngO2EDzLn69TBYjZ4uKSbSVQoTbuAgS0H/gZHDlFS1M1hrrEdsXBFCZ7eUf1WYTkubo3akHvkI7rTyz+c2dcwzkrixYyE33YthYTMGmBh9tozQJWdL5HzI7p2RjJBa1x8ClGZY9KDN42Mxy9vgMUJQPGG4qdAhSIuu1zXDpWe0qeT+nFCXHdYaUzCB2LR1gvSa0BcP/fRCG+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWrrf6wXmX07vbogyKa8oceQ5z2BepFVgMm/UFvmSnM=;
 b=avd7c90K5jWOH6oQKq32H2fHiOcHpwLEyb4xZYGoLfLVefhxC8WvvIind6eMJvktYysByo/ugzCQT8dmtr8if7Aw2axn1m7f/M8rbyrjRU8nn9xq5OLYZ4nREx2jXjewKWrou1SBGLtFlGmGWmf/z4nTDy569GZO1CQfSX3M31onNt7JI915xvyZwTNXqdQQ2MDHCgVCXdegkQ7XrxVNoiwBShNZM6peEYsayiAGOSI68fyigPccmgW026LcGtGDb2528EAzSFtAWAD3sSrzPo6QGdZgDoPLHGtbVjKIRxJZGO0IsACTJpKdaYbotNJ03ge28XlR6QoSdq66gGCNFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWrrf6wXmX07vbogyKa8oceQ5z2BepFVgMm/UFvmSnM=;
 b=Yz/Wdwq5AJPfZAqIWNbnTSunPxanMa6DZziLBuA80yNff23Sp4qDeeXUDB4oT7cYMSd7+HpIWoF4xjdVfCqa2FfubXOhdtU7YzS+gEuDFuVO10KDjSEdR+1NPsWKt9hdJgmagvzFT8MeipudqfkReXqrtcMX4UJmalCYKW1J8ug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Thu, 17 Feb
 2022 09:45:09 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.4995.015; Thu, 17 Feb 2022
 09:45:09 +0000
Message-ID: <b19700b6-3f68-1654-a07a-371351fe3652@amd.com>
Date: Thu, 17 Feb 2022 15:14:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v6 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Somalapuram, Amaranath" <asomalap@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
 <e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com>
 <ed1103b1-835c-e56a-3118-17bd60f0f5f9@amd.com>
 <d531c825-332d-036d-c4b4-5e2cf39edb52@gmail.com>
 <94eeed88-69ad-5823-0505-dc86b36c4007@amd.com>
 <09a4d26f-04be-2a84-343a-32166d21afd1@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <09a4d26f-04be-2a84-343a-32166d21afd1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PR0101CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::20) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad20b2ef-df1f-4d24-de0a-08d9f1fa2f4e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4230:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB42306D9050D82F36B23F9C6597369@CH2PR12MB4230.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +KYyW6SvU4PbwdQuZSMMP6FzXdIrOMPis6tkJR0qJfMXj/zLmvyRztOBDHThEoncL/JlntaTaMGDRgyk9zurotDeJJZnG9vyDeR1L60io9KXQSWINo0g5gmuiKPwsd3rrpK08vxN017n39d0epriP7ntiSJUXxcyTetfv7HdCzKtKiO952RhKDmsbnF5GoyMgiTvwLvbhGqJ74XK7DA++6/4DaGfVHNRxLLhbLJ/mm5V243OOwx0xgbi30efASPgxt0lrz+Zx89d0Iv/H/C87eBw7zyK6HbhceMGTTFnWoBymsIno1j7D8MX3PtB/EiRCG5lzr5WMO7Fkl9+ug6BYYrHszuVX+vRPY7kZ2i5414SqC796/oybhl08UzbauXEDOJ4LXkcvgjFGW3jzgUs7cVEh0+2njoGV+mG34efweaBiTfL03pNm/ZpPfX0SxUblL3EuYK6Cw2DBKQv5X+AFjPnA7PaJSyIVZcfGrMbo3nssWt1iN0WswaTXdSsXD5EtYZj2EelDRuFX//jmvOYLQxZ0p3DeQk15g13Q7l9aUCWQT0bVV9aGY8sOAsNGDqPNWo2GVMT6dzz9EoZqrBQhwS6J6tmuY15jezttdLVl4plSUSTazHsuF+6KtQarbFC2QTajzz2e2n571QONvyeSlveuWQxYWK4d/XjBVFILfeeQ6wvGcZerTGbssvWk16KdOOXMydBKevjliw9RDVIWQ6v0I4USKLOGC3dIEOSmMGUzvOFJZqTk7RTuCqBQpWz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(6512007)(53546011)(8676002)(508600001)(6666004)(66574015)(66556008)(2616005)(66946007)(110136005)(8936002)(26005)(83380400001)(316002)(4326008)(186003)(6486002)(86362001)(31686004)(2906002)(31696002)(36756003)(38100700002)(5660300002)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2I3TGozWlV0SHk2azZDc3Y5OGVLRDdlQnYzbDJlRzcwang2aUJPeHU2WGVj?=
 =?utf-8?B?WmxxVi9GR2pnWlVtOTV1b0JrQXYwdzk5QXJ4cHRRcDBORVl2UmxBdmxJU1Nj?=
 =?utf-8?B?UnVLU1R0eGFydGVKbUY2MVRjY3FIQkJGQ3lhR3R3ME5xR0dPRW94UUJ0a0JB?=
 =?utf-8?B?TXpGM0phZ0dHZUFxQnhhU040Vks5eDFSa0w4dEdBNkFyRmN3RVhBUEcrczkw?=
 =?utf-8?B?YSt6bGZyaUF1cEs2Q3JSM3ZNcE5nOGREbkZvQkZjTE5jZEZnMnQ5VzFML25G?=
 =?utf-8?B?Z2pZVDBZaEdOTWViZHorOWRCRXdhVVFubnpjMkNna0ZOcDlPSE9zN1JuNjRT?=
 =?utf-8?B?WTQvQ0czYkx3bENjY05QeFBxQ1BuRTNhOHNvekVvZnQxMk5lU0hsbVpxUENN?=
 =?utf-8?B?QUwxUHFZbHFDdktpbmlPQXIxd2dvemdiQnpjMXc1ZldrYitQQjh3WTg0ZnpO?=
 =?utf-8?B?UEgyYkI2QVVnZWcwV2tqRnV2ZGJ2THQ4SndwR1lNR1JZaWVKN0hNeE1Ld0M2?=
 =?utf-8?B?MkdSVDdveUh4TDZnQkNOc1hSekVxSlJ0OUhvZk5FVUZ6bzdObjBObWlHV2JE?=
 =?utf-8?B?RlFncC9kTDhlTmVmSTU5STZOU21YeGt2V1FGbE1SbnFpS2dtNDlMNU5PYmky?=
 =?utf-8?B?dWp2TzdtS2g2eldiUE5RbkVGK2VTWGJwU0FIQlhaTUV6dXVPTzJ6SG1yUC9x?=
 =?utf-8?B?Q1g3Mm9wSmF1SktPNCtmRG9CMFcxWXI3MkUwQ1FFaEo0UktwQlRJUmdYeWNH?=
 =?utf-8?B?d2Z5STZGNndnL3BIQnNCQTFXNk1ZVXQ0QzZSbVpSZXBNZ2lZa3RSdy9lRDQv?=
 =?utf-8?B?VmFtTWxLZUM1QmVkU0VHdWQ0M3lFU21XdVMvZEVoSXdjUmJTV0hkZklpYk1k?=
 =?utf-8?B?Vng4Nnlaa2FETnZYWTJFVWlndVU2aWd2ZmkzQkU2Z1RYNDFTTStUbkZiM1c4?=
 =?utf-8?B?cGZnbnlpKzl4Y2t5WlJPaVRqYjVSVWVZL3BHSHJsNXhtSXVYd3BLcEVGNE5O?=
 =?utf-8?B?aWIyMHk2M1hWMlo0MzU1OG1RcHlia2hVdEtsK0EwaTJBOWZZN0RBdkZEN0g1?=
 =?utf-8?B?RjdURzZ1WnQwMEtMNGVSNkJJTVlwakFEU2hKWTNVMjV0ZXhnZ1NBaEJKYlhq?=
 =?utf-8?B?YTE5OVB1TEgrRjlFTWNhblF4QzNGcHA2NmZsQmZqVkgydjJhQ3BPeW9ZaFUx?=
 =?utf-8?B?c1pMZG8wZDJsZmtQc0FwTlFtSHRhUENsTHZuZjhBU0QyVDQ5YUd2cmdWL2xY?=
 =?utf-8?B?K3AwOG1PMXUwaVFkMGd2R0ZVMjN2cnB1eXhoZEJOaDVISXdnS2VtSTYvN1dR?=
 =?utf-8?B?dDhtWWc2UEp2SGM0NjNBS0FoV0ZtVlRJdzZlN0l2RkxxY2pEQjcwTllkYWtO?=
 =?utf-8?B?c1VpNkIveXRnejRBTlp4NjRHS2p2cHk4Z1RhbVhiSDgvMzg2ZWxURmNzbnNP?=
 =?utf-8?B?S0RuVVdTRWVTTWlNbzZHVEU0dHFvQkZtQThjMngwVXRhbmNmNm5SODFKMnZ0?=
 =?utf-8?B?OUJ6dlB3amdFbFZuVHJHajczMjkvaU1GYzhGaURodzJSQW1mWlIwaG5XSWRl?=
 =?utf-8?B?bzQrcGRWVlNPY01BZStvVlI0NGxjMjZXVjdoZUNmV2JidEMrQ0VFeVR0TGVN?=
 =?utf-8?B?QVVtVEVjTFUyamI5V0JkZEpmdlg3ZHRWUzRJNW9wcnR3ZlRCbXRFalRKZ2ZD?=
 =?utf-8?B?ZzRGMnZ4N3hzRnN3cmxMWEZhSUNGbW83OTYybnBKMkZQNFpCU2tRZ2FKR2pX?=
 =?utf-8?B?c0JKNThET2J6ZUd6SWhqbkpjYmpQZ1F0WG4wWXJUZ2xkMld2MjJnQXpiQnk0?=
 =?utf-8?B?L2dTK2ViODhQSm5YanVWYVBSYnZRRDI1dTVvRXUrVk5pVzlJQUp5MVJ5WnM3?=
 =?utf-8?B?MHFyblE5bGttQ2xhejJTWGJnUEROQTVnQUd0VzY1cHc1QXR4Z1dRcVJTOG5K?=
 =?utf-8?B?dGhoNjBrNmZrWHdEZTE0VkZBa3I4eU9QWGoxNmNrZDBtWTM2ZXlkNTJwbzJM?=
 =?utf-8?B?WFhuNmRMd2JUM05SNFVJZUhLM3l5enkrSGI0ZzBST1g3azJlQlVYc3E1emdx?=
 =?utf-8?B?Yzloc0p4ZVA0SEpYMkdvQkZGbEc3UTJXdjVFSTlhZ0R4UVIxOXhiL3dWNmNX?=
 =?utf-8?Q?0p14=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad20b2ef-df1f-4d24-de0a-08d9f1fa2f4e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 09:45:09.3232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wsHB0Rnj6GgRLkJX402qInZdZLwEKSnuk8aa4cuPVwdkhWd5B91qoWW8AGGcmZh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230
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
Cc: alexander.deucher@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/17/2022 1:30 PM, Christian König wrote:
> 
> 
> Am 17.02.22 um 08:54 schrieb Somalapuram, Amaranath:
>>
>>
>> On 2/16/2022 8:26 PM, Christian König wrote:
>>> Am 16.02.22 um 14:11 schrieb Somalapuram, Amaranath:
>>>>
>>>> On 2/16/2022 3:41 PM, Christian König wrote:
>>>>
>>>>> Am 16.02.22 um 10:49 schrieb Somalapuram Amaranath:
>>>>>> List of register populated for dump collection during the GPU reset.
>>>>>>
>>>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 
>>>>>> +++++++++++++++++++++
>>>>>>   2 files changed, 100 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> index b85b67a88a3d..57965316873b 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> @@ -1097,6 +1097,11 @@ struct amdgpu_device {
>>>>>>         struct amdgpu_reset_control     *reset_cntl;
>>>>>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>>>>> +
>>>>>> +    /* reset dump register */
>>>>>> +    uint32_t            *reset_dump_reg_list;
>>>>>> +    int                             n_regs;
>>>>>> +    struct mutex            reset_dump_mutex;
>>>>>
>>>>> I think we should rather use the reset lock for this instead of 
>>>>> introducing just another mutex.
>>>>>
>>>>>>   };
>>>>>>     static inline struct amdgpu_device *drm_to_adev(struct 
>>>>>> drm_device *ddev)
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>> index 164d6a9e9fbb..faf985c7cb93 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>> @@ -1609,6 +1609,98 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, 
>>>>>> NULL,
>>>>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>>>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct file 
>>>>>> *f,
>>>>>> +                char __user *buf, size_t size, loff_t *pos)
>>>>>> +{
>>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>>> *)file_inode(f)->i_private;
>>>>>> +    char reg_offset[11];
>>>>>> +    int i, r, len = 0;
>>>>>> +
>>>>>> +    if (*pos)
>>>>>> +        return 0;
>>>>>> +
>>>>>> +    if (adev->n_regs == 0)
>>>>>> +        return 0;
>>>>>> +
>>>>>> +    for (i = 0; i < adev->n_regs; i++) {
>>>>>> +        sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
>>>>>> +        r = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
>>>>>> +
>>>>>> +        if (r)
>>>>>> +            return -EFAULT;
>>>>>> +
>>>>>> +        len += strlen(reg_offset);
>>>>>> +    }
>>>>>
>>>>> You need to hold the lock protecting adev->reset_dump_reg_list and 
>>>>> adev->n_regs while accessing those.
>>>>>
>>>>> (BTW: num_regs instead of n_regs would match more what we use 
>>>>> elsewhere, but is not a must have).
>>>>>
>>>> This is read function for user and returns only list of reg offsets, 
>>>> I did not understand correctly !
>>>>>> +
>>>>>> +    r = copy_to_user(buf + len, "\n", 1);
>>>>>> +
>>>>>> +    if (r)
>>>>>> +        return -EFAULT;
>>>>>> +
>>>>>> +    len++;
>>>>>> +    *pos += len;
>>>>>> +
>>>>>> +    return len;
>>>>>> +}
>>>>>> +
>>>>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>>>>>> +            const char __user *buf, size_t size, loff_t *pos)
>>>>>> +{
>>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>>> *)file_inode(f)->i_private;
>>>>>> +    char *reg_offset, *reg, reg_temp[11];
>>>>>> +    static int alloc_count;
>>>>>> +    int ret, i = 0, len = 0;
>>>>>> +
>>>>>> +    do {
>>>>>> +        reg_offset = reg_temp;
>>>>>> +        memset(reg_offset,  0, 11);
>>>>>> +        ret = copy_from_user(reg_offset, buf + len, min(11, 
>>>>>> ((int)size-len)));
>>>>>> +
>>>>>> +        if (ret)
>>>>>> +            goto failed;
>>>>>> +
>>>>>> +        reg = strsep(&reg_offset, " ");
>>>>>> +
>>>>>> +        if (alloc_count <= i) {
>>>>>
>>>>>> + adev->reset_dump_reg_list =  krealloc_array(
>>>>>> +                            adev->reset_dump_reg_list, 1,
>>>>>> +                            sizeof(uint32_t), GFP_KERNEL);
>>>>>> +            alloc_count++;
>>>>>> +        }
>>>>>> +
>>>>>> +        ret = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
>>>>>
>>>>> This here is modifying adev->reset_dump_reg_list as well and so 
>>>>> must be protected by a lock as well.
>>>>>
>>>>> The tricky part is that we can't allocate memory while holding this 
>>>>> lock (because we need it during reset as well).
>>>>>
>>>>> One solution for this is to read the register list into a local 
>>>>> array first and when that's done swap the local array with the one 
>>>>> in adev->reset_dump_reg_list while holding the lock.
>>>>>
>> krealloc_array should be inside lock or outside lock? this may be problem.
>>
> 
> This *must* be outside the lock because we need to take the lock during 
> GPU reset which has a dependency to not allocate memory or wait for 
> locks under which memory is allocated.
> 
> That's why I said you need an approach which first parses the string 
> from userspace, build up the register list and then swap that with the 
> existing one while holding the lock.
> 

Another approach would be to just protect debugfs write with 
down_read(&adev->reset_sem) or reset domain semaphore.

Other than that if apps are trying to read and modify the list at the 
same time, probably we should leave that to user mode since this is 
mainly a debug feature.

Thanks,
Lijo

> Regards,
> Christian.
> 
>> Regards,
>>
>> S.Amarnath
>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>> There are 2 situations:
>>>> 1st time creating list n_regs will be 0 and trace event will not be 
>>>> triggered
>>>> 2nd time while updating list n_regs is already set and 
>>>> adev->reset_dump_reg_list will have some offsets address 
>>>> (hypothetically speaking *during reset + update* read values from 
>>>> RREG32 will mix up of old list and new list)
>>>> its only critical when its freed and n_regs is not 0
>>>
>>> No, that won't work like this. See you *must* always hold a lock when 
>>> reading or writing the array.
>>>
>>> Otherwise it is perfectly possible that one thread sees only halve of 
>>> the updates of another thread.
>>>
>>> The only alternative would be RCU, atomic replace and manual barrier 
>>> handling, but that would be complete overkill for that feature.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Regards,
>>>> S.Amarnath
>>>>>> +
>>>>>> +        if (ret)
>>>>>> +            goto failed;
>>>>>> +
>>>>>> +        len += strlen(reg) + 1;
>>>>>> +        i++;
>>>>>> +
>>>>>> +    } while (len < size);
>>>>>> +
>>>>>> +    adev->n_regs = i;
>>>>>> +
>>>>>> +    return size;
>>>>>> +
>>>>>> +failed:
>>>>>> +    mutex_lock(&adev->reset_dump_mutex);
>>>>>> +    kfree(adev->reset_dump_reg_list);
>>>>>> +    adev->reset_dump_reg_list = NULL;
>>>>>> +    alloc_count = 0;
>>>>>> +    adev->n_regs = 0;
>>>>>> +    mutex_unlock(&adev->reset_dump_mutex);
>>>>>> +    return -EFAULT;
>>>>>> +}
>>>>>> +
>>>>>> +
>>>>>> +
>>>>>> +static const struct file_operations 
>>>>>> amdgpu_reset_dump_register_list = {
>>>>>> +    .owner = THIS_MODULE,
>>>>>> +    .read = amdgpu_reset_dump_register_list_read,
>>>>>> +    .write = amdgpu_reset_dump_register_list_write,
>>>>>> +    .llseek = default_llseek
>>>>>> +};
>>>>>> +
>>>>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>>>>   {
>>>>>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>>>>> @@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>>>>> *adev)
>>>>>>       if (!debugfs_initialized())
>>>>>>           return 0;
>>>>>>   +    mutex_init(&adev->reset_dump_mutex);
>>>>>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, 
>>>>>> adev,
>>>>>>                     &fops_ib_preempt);
>>>>>>       if (IS_ERR(ent)) {
>>>>>> @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>>>>> *adev)
>>>>>>                   &amdgpu_debugfs_test_ib_fops);
>>>>>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>>>>                   &amdgpu_debugfs_vm_info_fops);
>>>>>> + debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>>>>>> root, adev,
>>>>>> +                &amdgpu_reset_dump_register_list);
>>>>>>         adev->debugfs_vbios_blob.data = adev->bios;
>>>>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>>>>
>>>
> 
