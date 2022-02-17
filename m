Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C360EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 15:38:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DE1510EB18;
	Thu, 17 Feb 2022 15:38:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E24B210EB35
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 15:38:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2B3gTupl0SLfB0o0ASM0LVOaO7zha2bhPh2dQT+YKhc0ekXFcXsWCxbW1RZemEZmJY9r+GJZRtmSOEft1YmGTJt36HJ18cxsui46N5380bTotha03kIdJDqia327nXrrBNFEs74tJe3gHT4M+Nwez2Ip2FlFAIV8fPF24FN6SlszX/+fHAY9/f8SlwmIOkEygVANHkiKeItkZg7Hy6omL5dvO19A+Jvt7W7WgpaqCGKvLkYIACPDAGZlWz5oybCRK5/2Z8oTV7sdEswa+WhMBxjnanZlimhwhOYb718Ofa2HeFNZYHTVOBBHIfCZeBDf8tVBILJYsE9f5/KpgL3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVIv2kHT1/lK9TXRFwWBBOOG2KTr+1zhm8SqtzAZ/z4=;
 b=Gy5IjgjGW64dWy3FhXXSHxc3dCV4Df3Fn/ov7O83lvhcl6Y934/RSIbZhP+jTD4wy1P3Zau8c8zKtEYSGJIdKkxXg7BB9hcImMvMnNqs0k+Pfcn6xNAhl+6nVL52wF8hJNM8TljDB7Jzo7Z/4IelG5z2rtGcp/dNqpch97BpId/DkjrjiPKrVtct0fMAbMTRlequuIC79v3NFEySCboKHsimcWUS0SZUwbeZH78IRt/pYPR0/BozgqtqMJPBkb56U7HGT/37B0ZFTOU2jkO+TxcrIlbETBiBriJ88kLt0vI4lr+2e8Niozyjx6aMWK08X62zNbgarasln1O1gZ8PeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVIv2kHT1/lK9TXRFwWBBOOG2KTr+1zhm8SqtzAZ/z4=;
 b=g5NKCoiYABiojeLAKseVtrlhD7pyby1e2pmlKGRRNfsi1GMIM+IZKh0LTj4EfP2+rOd0mpn/xIhgdcYwQcCMnXxcVudfXwxidSBeEmGb0hprw/XPA3UNC7YwMlZyGuXnZjZxtH5Wt4heKCKxKdjgmM5HFdQU7oTDhPJzAGUqrSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM5PR12MB1147.namprd12.prod.outlook.com (2603:10b6:3:79::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 15:38:26 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.4995.018; Thu, 17 Feb 2022
 15:38:25 +0000
Message-ID: <b1a6b3fe-b13b-ad21-58bf-c1415494d876@amd.com>
Date: Thu, 17 Feb 2022 16:38:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220217142918.3624-1-Amaranath.Somalapuram@amd.com>
 <28251570-bd04-23ae-b199-e5e0f41db728@amd.com>
 <a60428c6-00a3-484a-c6c8-08959e91f889@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <a60428c6-00a3-484a-c6c8-08959e91f889@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR04CA0035.eurprd04.prod.outlook.com
 (2603:10a6:206:1::48) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b26077b-d801-49a2-41b6-08d9f22b89a1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1147:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB114736D08DBA0364AD62FC4283369@DM5PR12MB1147.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xAVm4yYsgyfPo3P0kwCZ+SHzhUJa/6/JzLCwYICEgjiq/tqybFc6JyGQBcid7G80VkCg0P3fOyWL6nT19x5xn6d/aOMbDNbm+I3QwqyxiSVsxp4dpFE2kGI6EkV3aA8Qj5s+jRums/ANyZxtgoQCXdfFqE2TDbgw9LRyNW6vkrdbJdyYamo1toLlHOnimbQMQ1q6vPLkrmyng+LxlSPQlQuL6Y8ncKYrzrECYqyevYhzA1uSqbyPklfLuaJ+j/AIRQAukiljA2Q298XJ/CA5LxZ4gP/RajMzEIYEQw/wknm74QUhii2r1nQCLojscLxeAidf8wt0gVPaEhXlVc2FhoFH5MjZlzBfpfFnRXy6+s9rIJBx2esIVYtACVkSAxUe7mAWRVqTNhHxfThMkZO/7W1K0C+GWIdZvvS5+K4vZMELLA9TVUdxbUdScqBoGswHhpZn3iJpq6JoRdY5YZdVTqYw4wupIg4QVtlK55FFctH7cX/OR9NVbQOUo51Pi9tOkrKhcVg4YqZmY+W/StPx7dDNOYbWfMFXgTVCQuvSqivg2F7wexiWcBTPBSBjA86s5tcLIcrfqVeujn/OiJZpoSTFxJv8GwbPONVy4YDi+Da7q1zhXc/2aUwir+6n43GGTpetGz2wV0+x4yWNp/aPCzhF47uRfcCLBja+GfuQ03dSNCMAUoN3WNV6jVegLwlbDLvI1DGIHOvq21cLb0dpTN8Bs6ppaPX6j2v4vElk14E0wZNntAYuEQOYB4Qx3Ef4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(53546011)(6506007)(8936002)(316002)(31696002)(2616005)(186003)(2906002)(36756003)(5660300002)(6512007)(31686004)(83380400001)(66574015)(38100700002)(508600001)(6666004)(6486002)(4326008)(66476007)(66556008)(110136005)(66946007)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enMvb1pFY2tZM2tRdDV6N0x1eHUzeElpYXFFb0FsMURuY0RsREMyZHBPY0Rk?=
 =?utf-8?B?R0VLNUdVd1BvZzg1ZFZFK1FiTkFHS0ZBYWlsdG1oVDR4MGswaGxDM0RlbWtH?=
 =?utf-8?B?TUNYTS9BMnltZEc5ODFXNVVMb1VZdHZnQVhxOHZlSi9zeVgvTGN4d09MaXVL?=
 =?utf-8?B?NnYwQ3BYYVpXMW1DdEVxMnN2L0pOU3RtU2ZJMnV1cm5yNDQwek5US2l1aVRQ?=
 =?utf-8?B?VUVLNmd6ODdaU0s1d2p4N3N3WkhjUllZVElwS1p6a0JBSkd4RDhVSnA5OXNo?=
 =?utf-8?B?Wnlub0tla1M1K3NVeU1nRkplNURQa3VKWjVXUytnNXVXcll5dXQyRkJFMGJu?=
 =?utf-8?B?QlI1U1pSYUlIQnFlUmRWQ0prWEt2dGc3eHdCRUYyellYZHZreGx2UkZyRlE3?=
 =?utf-8?B?MDVwckFOQ0VUajlLcUpFMUlHaWxwaHlEV0ZEK2lZSnM0Nkc0SFlPeDdwMW9j?=
 =?utf-8?B?RkJDTkhWay9PVjc4TTRjVUFCNFVLOWsrZUsxWmw0UUhJVmdzcXpwd2VIa3kr?=
 =?utf-8?B?MndvZk80Q05BZzBsdzlwZit2ancxT3RTcEdXV3JPVkJ5SCtFRWpBV29URUZQ?=
 =?utf-8?B?YS9RbE5uZjZlVWI2VXI4M1JGM25pQ2hrVzM1T2dVS3FadWROUld3WEVSS2Nm?=
 =?utf-8?B?dGluenZPaHNwcTE0a3R4VHozQVR6NTllSzVFWEFDVnNlR2l3T1RPaldtaFdq?=
 =?utf-8?B?V1hteko1SWRTc1JyRjNiQ2xIdUQ5NlJ2UFlaemM5NTB5NjYwaW1lL1BGdFZm?=
 =?utf-8?B?UXNqSkVXbVoxVFVwSDhIYlBnWkxjMERPbm1TdWdCcXZSYk5sdW5CbHVmVElE?=
 =?utf-8?B?RjlKUFV2MWVRSjJ3T0hocFh2UWFGaGpRMzhvcmJBdWthSzl3d0JtdFEwbkl4?=
 =?utf-8?B?QllzLzlNbkFGeUNZU1JDaitYbWQwVkZmUWNER0hNRXRiaGJaZ0d2MlZOTkl3?=
 =?utf-8?B?Z3hWTUROamFpTVY5aEVMSTlaR2ZCcWorR2ZjOHAxaEJ2b3R5eVRKRkhXeVd5?=
 =?utf-8?B?WTZFMkw3a1BndEFrNVI1amU2SDZZWVdYRU9RVlZ5aHNJUmxkOVFoS25XaGNx?=
 =?utf-8?B?VUdUTHZxdE1IbWxwc1AvcXdMT0xFWHMralNkOXAwVWRkN09kb09TdkwzbzBY?=
 =?utf-8?B?YVNCQXNjcFFpai9qRGpLSzZFN0hxQ2xwZzRsTXlBd0lremExZGptWnJ1Ujc0?=
 =?utf-8?B?OGdHbVo0NmxCRGxXUkwzRDJJVXZWZUxnMTc5cytWMmZqVG95bVFrZmxZOFZp?=
 =?utf-8?B?UlczSThnK0VyZ2EwZVUzQ05VWG1qK3NvNjk5b0YzMGRGUThDVVoxeEhuQXp6?=
 =?utf-8?B?U25FZEhIdVdJeXNIK2tHbUJmT0J6eTVIUWdBTG9FL3g0QlN2MXRJb1FhdlJ4?=
 =?utf-8?B?bVhER1RpY0FIY0NHdFFyYmdmRnRHMjk0WlZjY3hNdUNraGx4R0sxZ2RqQ1hj?=
 =?utf-8?B?Q1k1SysvWG9EVGpaam9YMWE5aDQwQjZvYmJNaGt4QTdISm0rclpPWXpSUFpp?=
 =?utf-8?B?N2J6cHFBeTJkY01NQ2NEWllpVlJpbElrTE1QOHNRcTZaVHFYbHhNVEpEMjdD?=
 =?utf-8?B?ODZvUUtJb0UyYnNRaklIK2VVUVA0ZlJKM3pxS1BzQTMyUHdiVS9TL0xRUEJz?=
 =?utf-8?B?MDBSOGlkTlp0dDJpTjFtZW92TTRwaTdJSzFPNTNvVmp5TWN6eGVIV0ZrR1FI?=
 =?utf-8?B?dFZ1ZzNXTnVqek0vc1RKVTRadkdNVE5kOXpWUm9TWFlhRHk4ZFUrOU5Jalpk?=
 =?utf-8?B?eTVRTFQ1N01ubjZPVkpiL3FPc1dSeFRKM1JKbkdzRXhweUUyRldrRXRTMWFh?=
 =?utf-8?B?RkxjU056NkVkZlRvQkw1YkRPSW8rUVpqYVRqdzlNbnQwRHRyQll5dXA5eDJ4?=
 =?utf-8?B?cHhVZDQrMmZVM2lFVi9kZCtYbVN2Q0FxNHZjeW9XUDZkRHFHMjhNNjdIR3ow?=
 =?utf-8?B?bzlLODMvZ3pFOFNPWFUrdmkyU1RsZGFUQmFrc2RaRUE4K2g3MnhteTA3L3Nj?=
 =?utf-8?B?enorTnhkd0ttdVhWeU9ZR3RhUTVWRWlFVndJMFpTVVVKOVlBcTJqMnJCQUNy?=
 =?utf-8?B?ZkREdjIwQ3h6eFBQWEpFSFl2QmtJS0dlRENIYjlabE5aSWxxdk51cmZlWGV6?=
 =?utf-8?B?RlBySi9WQ2drOFYzbHU3dStLQnJHVS9ielpmZDB6bUxmaDZJNmFDWHEyNDky?=
 =?utf-8?Q?Nd2dSAubuOlgLGbF/yFlM7U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b26077b-d801-49a2-41b6-08d9f22b89a1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 15:38:25.8229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJA/6II6svTug/hUndj2stQ1rxTqEEUp8h82HvSK6I7W3NeG1H7+Gom1NEyVjdwH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1147
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

Am 17.02.22 um 16:32 schrieb Somalapuram, Amaranath:
>
> On 2/17/2022 8:36 PM, Christian König wrote:
>> Am 17.02.22 um 15:29 schrieb Somalapuram Amaranath:
>>> List of register populated for dump collection during the GPU reset.
>>>
>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   4 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 112 
>>> ++++++++++++++++++++
>>>   2 files changed, 116 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index b85b67a88a3d..6e35f2c4c869 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1097,6 +1097,10 @@ struct amdgpu_device {
>>>         struct amdgpu_reset_control     *reset_cntl;
>>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>> +
>>> +    /* reset dump register */
>>> +    uint32_t            *reset_dump_reg_list;
>>> +    int                             num_regs;
>>>   };
>>>     static inline struct amdgpu_device *drm_to_adev(struct 
>>> drm_device *ddev)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 164d6a9e9fbb..ad807350d13e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1609,6 +1609,116 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>>> +                char __user *buf, size_t size, loff_t *pos)
>>> +{
>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>> *)file_inode(f)->i_private;
>>> +    char reg_offset[11];
>>> +    int i, ret, len = 0;
>>> +
>>> +    if (*pos)
>>> +        return 0;
>>> +
>>> +    ret = down_read_killable(&adev->reset_sem);
>>
>> Using the _killable() variant is a really good idea here.
>>
>>> +
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    if (adev->num_regs == 0)
>>> +        return 0;
>>> +
>>> +    for (i = 0; i < adev->num_regs; i++) {
>>> +        sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
>>> +        ret = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
>>
>> Uff, I'm not 100% sure if we can do copy_to_user without dropping the 
>> lock.
>>
> then I need to use kmalloc or krealloc_array.

Alternatively you should be able to safely drop and re-take the lock.

If the array is modified while somebody reads the list it's the fault of 
userspace and they can keep the broken pieces.

Just make sure that dropping the lock is after the snprintf().

Regards,
Christian.

>
> Regards,
>
> S.Amarnath
>
>>> +
>>> +        if (ret)
>>> +            return -EFAULT;
>>
>> But returning here without dropping the lock is certainly incorrect.
>>
>>> +
>>> +        len += strlen(reg_offset);
>>> +    }
>>> +
>>> +    up_read(&adev->reset_sem);
>>> +
>>> +    ret = copy_to_user(buf + len, "\n", 1);
>>> +
>>> +    if (ret)
>>> +        return -EFAULT;
>>> +
>>> +    len++;
>>> +    *pos += len;
>>> +
>>> +    return len;
>>> +}
>>> +
>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>>> +            const char __user *buf, size_t size, loff_t *pos)
>>> +{
>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>> *)file_inode(f)->i_private;
>>> +    char *reg_offset, *reg, reg_temp[11];
>>> +    uint32_t reg_list[128];
>>> +    int ret, i = 0, len = 0;
>>> +
>>> +    do {
>>> +        reg_offset = reg_temp;
>>> +        memset(reg_offset,  0, 11);
>>> +        ret = copy_from_user(reg_offset, buf + len, min(11, 
>>> ((int)size-len)));
>>> +
>>> +        if (ret)
>>> +            return -EFAULT;
>>> +
>>> +        if (strncmp(reg_offset, "clear", 5) == 0) {
>>
>> Please completely drop the idea with the clear here, that should be 
>> unnecessary.
>>
>>> +
>>> +            ret = down_read_killable(&adev->reset_sem);
>>> +
>>> +            if (ret)
>>> +                return ret;
>>> +
>>> +            kfree(adev->reset_dump_reg_list);
>>> +            adev->reset_dump_reg_list = NULL;
>>> +            adev->num_regs = 0;
>>> +
>>> +            up_read(&adev->reset_sem);
>>> +
>>> +            return size;
>>> +        }
>>> +
>>> +        reg = strsep(&reg_offset, " ");
>>> +        ret = kstrtouint(reg, 16, &reg_list[i]);
>>> +
>>> +        if (ret)
>>> +            return -EFAULT;
>>> +
>>> +        len += strlen(reg) + 1;
>>> +        i++;
>>> +
>>> +    } while (len < size);
>>> +
>>> +    adev->reset_dump_reg_list = 
>>> krealloc_array(adev->reset_dump_reg_list,
>>> +                        i, sizeof(uint32_t), GFP_KERNEL);
>>
>> Well that still doesn't looks like what we need.
>>
>> Here is once more the roughly what the code should do:
>>
>> unsigned int i;
>> uint32_t *tmp;
>>
>> i = 0;
>> do {
>>     tmp = krealloc_array(tmp, i, sizeof(uint32_t), GFP_KERNEL);
>>     copy_from_user().....
>>     i++;
>> } while (len < size);
>>
>> down_write_killable();
>> ...
>>
>> swap(adev->reset_dump_reg_list, tmp);
>> adev->num_regs = i;
>> up_write();
>>
>> Regards,
>> Christian.
>>
>>> +
>>> +    ret = down_read_killable(&adev->reset_sem);
>>> +
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    adev->num_regs = i;
>>> +    memcpy(adev->reset_dump_reg_list, reg_list,
>>> +            sizeof(uint32_t) * adev->num_regs);
>>> +
>>> +    up_read(&adev->reset_sem);
>>> +
>>> +    return size;
>>> +}
>>> +
>>> +
>>> +
>>> +static const struct file_operations amdgpu_reset_dump_register_list 
>>> = {
>>> +    .owner = THIS_MODULE,
>>> +    .read = amdgpu_reset_dump_register_list_read,
>>> +    .write = amdgpu_reset_dump_register_list_write,
>>> +    .llseek = default_llseek
>>> +};
>>> +
>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>   {
>>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>> @@ -1672,6 +1782,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>> *adev)
>>>                   &amdgpu_debugfs_test_ib_fops);
>>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>                   &amdgpu_debugfs_vm_info_fops);
>>> +    debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>>> root, adev,
>>> +                &amdgpu_reset_dump_register_list);
>>>         adev->debugfs_vbios_blob.data = adev->bios;
>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>

