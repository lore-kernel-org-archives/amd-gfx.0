Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FA3C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 07:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 076B310E96D;
	Thu, 17 Feb 2022 07:55:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6C5410E96A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 07:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUtpREF/qOVRYZJHONWuXT7neyAvBqLv5SIuWhIh9QKBNTkSf9l63CHWvSdiXLVFLDhMetc0Uahyj8UpKbYlTraEccE5J5YF5J1FqJeeCuiP+6Xz+XgWf4J3l5oxupt/pBilFxSFZHuadyu5TVdQ89+jHji/7aNHV6JXb3n7PRWt8jFv5sgpdr3jbj8bfhQVtcSNdJMJia59t5UGWI2l3Bw6SjEsDBNYFqJZLYz2pLzAI64P0cFuepOTDX0Fek8Rm1HItIVXynzgARmaemRu7TIFlN8x4g/gU2S67bu0PN6ul0j9Mz1HvrjSXhZujO1qw/Y33VNencpttgvR/buMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sggsCWoXbnfkVPthos+ITLLsu3v4FeCaYdGCTMNGfgM=;
 b=aDUb649E0W/VmZh3OI40Z8iTfSNHhlDr8lJnGMrEZwIqX1tcFu2rUGPzey0NgLGK4V/MCgaCOIoOm4mglB8EHMYKyjk1tc7DRsVFlIRseN0B/JcJBt0+VDIdsjxmdbG3JD8OlcDvq749MWun9iFioOXzmwfhLnxqbYurQPsUF4zS+fNrPXU0neTNsXyCe4GWcvOEENyiYZDzaaXWCoit0i7EA5EFDRLDz9BOeguPuwHA4BtwT+Xv4htAs9tMJJU69E94Uu8TeMFYNmZTzrt0HIx6c+OZYsf6mmhfTjl/4rlV5wkxLOlSfFR0c83deP+fkHI+W6lJfUILwFxgwuqyww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sggsCWoXbnfkVPthos+ITLLsu3v4FeCaYdGCTMNGfgM=;
 b=DW03QGOqUJJ9Ek/HzUwR9m/7X3eBH0kxAUXQeqn0NdAmVaIU06fgNAiUuPsUD40CIiSEEo3XyihNGvkJu9JtzC/Eg3QVTCNBI5MISef/4D1YItDDSy1Mv3EnXEvszuvQ06JE4WJbeo8/M0pbhaojwEsCP9u41rxTSMtdcauaoyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by DM5PR1201MB0171.namprd12.prod.outlook.com (2603:10b6:4:56::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 07:55:11 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d%2]) with mapi id 15.20.4995.016; Thu, 17 Feb 2022
 07:55:11 +0000
Content-Type: multipart/alternative;
 boundary="------------zXaBe5V2v0E15G0V07XdCYlN"
Message-ID: <94eeed88-69ad-5823-0505-dc86b36c4007@amd.com>
Date: Thu, 17 Feb 2022 13:24:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
 <e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com>
 <ed1103b1-835c-e56a-3118-17bd60f0f5f9@amd.com>
 <d531c825-332d-036d-c4b4-5e2cf39edb52@gmail.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <d531c825-332d-036d-c4b4-5e2cf39edb52@gmail.com>
X-ClientProxiedBy: BM1PR0101CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::34) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05875687-9009-43f5-7d9e-08d9f1ead258
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0171:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0171E8AF84406776FD55229CF8369@DM5PR1201MB0171.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNLj7XUNRjh5+1j7Gl0XWra8EJckWHDAqvgt2/+1plOeTMEh6cTVvDcJhoYk4KcuvtxkaDNqrT6TcJ5zKBb9POY/wWkldhcnsd1b/VhsVjU72tbAwv1elAPml0rFRtGttcv636O47/rAE5tIjgiY6zTVucln0+/1nD1aEskcMAqA1hHH+/8/cycw0hfu3OR9ZlZd74lQWrsEkrdinYKGMLH27SoFK8h4YGe93COrxXDg1zoHDSefXlv7V5eExUmHd41rGtEwU+7Eb720LYdM5QEEDpos/KZsgeZSgXWgLXtyceJznyjT7p+nWDUoGQjd9Bt6jyya2zm9v1W5rTCV4vxLJQrtXV08gKJyw1qeeS52VWEPDCHVxDnFiUGNT3WxQcqQZWY3c/jAkvfNXzXNU3Q10og3vXlZ4acS3waFmISBUdR0QkD1pIadkkJfIQzUzwM7iguLM56NLBe3j36RoJT+/tcIZwCwRYwIcIJS6DmJjCyAQKD5IE65A6AbjEGE1pj0Vqq81yOpgG8H9HT6F+MxsXxpBa+/1jXfhg4+gC3RNusCcg1TZhpCzIvaYYb+ewDDeQN5aOxUXCaRg32a6dBQUdRF70RKpXkEvt9BxBPZEd72ZCZrm60Ea0yzMYjluQA19exHwxh65AyRsK7cqCiFXNHOef3t2Pq+5RkhRVy5eEy+Dcqo2WqvyIMFAFXNu4+IZCxN6717ZGZVcl5Qei9YwMbdeFxPp6plkmYbVDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(31696002)(31686004)(110136005)(6666004)(2616005)(6512007)(83380400001)(8936002)(6506007)(6486002)(5660300002)(66574015)(30864003)(38100700002)(36756003)(33964004)(66556008)(8676002)(4326008)(66946007)(66476007)(2906002)(53546011)(508600001)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUhrQktjZXVxcEMyVW9WZzJzUmp6T1M0MDJmUjhLZlAzSFJtVXZlcTQ4Mk03?=
 =?utf-8?B?SDhzMlRFdngya3FYTzg4dHd4ZkxGVXJaUm1SRmk5U3JjNUhjSS9RcUQ3N3k3?=
 =?utf-8?B?ZkFJdGpWNzh2L2xMcTRzaDF1SHdnelpoS1VERXF5ZWJSajNHanFTcGFIYzFT?=
 =?utf-8?B?ZVRxbjgvWnJKUzE2c2xsaGNoNDRtbEVKRFVZaWZPczlGU1k1M0VPYjFrVTlB?=
 =?utf-8?B?ZVVGL21OMTc1a3lGUkFUQ1dmdytvR3ZUQkFGTFh5YWdsSHJVT1J5ZFB1eUov?=
 =?utf-8?B?aUZrZnl5MUQ5aWcrcTEyeDhRaTh6QllpMFhldzlheXEwbEZac2kxQVNHZlVP?=
 =?utf-8?B?SHluZ0hlYzJaUlBvOXYzWWk3b0JLclNrbTJoWU11VXlqVnVrdkRIL2pjaVFT?=
 =?utf-8?B?Z0hzOTJ6UHJIc3dhYmR5cmdMS1RwbVE4NGlWeXd1eVpQOGZ2VTJ0SnZIc2ZO?=
 =?utf-8?B?STlxdHRYMDRWZVA0bmJQNUxIbHc3OU9XZE83MnFzSnNMTzdkV0poRHNvRVhN?=
 =?utf-8?B?aG54YnhCa2ZFaldjaHlQdEdEUksvaHBQZ0JBR2hkMVdIRHppbG1NcGJHOVI2?=
 =?utf-8?B?aFRnYm16d3ZabEpnWkVFbU10bmQyOEE5TlZDMVpXMzBpZjc0OS9uTmtwdFRM?=
 =?utf-8?B?cVEwSXhyMlhoQUN1ZTB1dE9wZVpoY3FjZDFIaHk1RmpVb1o1OERkQ0lUYm5h?=
 =?utf-8?B?SmpLajArWkhHTVRPS0kyME9sNkw3NnZqdkthUng4NzczbzZIR3AxVFR5QkJ6?=
 =?utf-8?B?TDJ1bnZyclNQL3VmeHF3bWV5Q28vTjRBcGFRWEJHR2V4eDFtV09DNFZhS1Ni?=
 =?utf-8?B?eHhXRkVMb29tOU1mT2Ixek1kcFVwZVlmTDVkT0VEM0xMQ1E5Vi9ITUI3TjJj?=
 =?utf-8?B?L3dpbTNXMFZHRks1Zkl2ZUxGOFcwVC9oYjRpQWVDTWtaekNPUWVkSGNKZVdM?=
 =?utf-8?B?WWMvRlY3Y0ttT1R6RnN2Wit4aDJaajB5M09nRVpwQWNUUCs4dUE1dHRhcGlT?=
 =?utf-8?B?bmx5VjNza1ZFWnEwTDRhM0ZmbzJ3eU9oQ0syV29zTytSb3duYTJYYjR6Q3JQ?=
 =?utf-8?B?WGNUS1JyWjFMQ054TDNOQi9aOExVTklrY2VXMFZncDkrRVpia3gwYy9YUWdG?=
 =?utf-8?B?OHUyckFDOUdGRUhEeEgvcFlpZ0FJdW9aOWxnQTRkbGdvNGw1TC9pNWpzVGhN?=
 =?utf-8?B?RXNjS09mMEtmbUhPYlBpRmhBRmZyRnNtZW1rUHJIS2w3cnJ1VmxHSnBBUU83?=
 =?utf-8?B?RXpQWWNvT2k1VzlQbzFicXlXTk1saUpVTzJJd2MzbllaSTVyMVhMN2QreHZZ?=
 =?utf-8?B?QWl4cFVxUVJHUW9halJYQ3UvbVFrdDY3Yk9pY1NxNzYxN0dhR1FjQ1cxcVli?=
 =?utf-8?B?Q2p1YjdtNmd1MGpHZ3NGKzJCTWUvMzcwT2VDUHN0Zi85Q093U3VBK3BXaHRp?=
 =?utf-8?B?K2Z3OC9XOGdMbVlNSXlEWVl1akFveGtJVzZLWXdzYkRab2J1S1NIcU5FNUxZ?=
 =?utf-8?B?R2p3QnMxVlhJc1FVbXU3dHg3OGlvNWMrZ0Z1UWVWelFBRysvb1U0WUpIWk85?=
 =?utf-8?B?YXZWNS91NU5wOFpTemo1Y1Blb29nQXV6YkJjMGJUM1pwZXBmakFBZHp4SEFi?=
 =?utf-8?B?MUFDV2ZYK05Ld0xuMjBtMlVycU5ZOG5iUG1haVRUeXZmbm00TlRQMjhMSEpj?=
 =?utf-8?B?MzlBUU5pQUcyVXVCN2k2L08vekdaQjVZRGZVM0lqanZwYUNPWXFwaHVMZTQ0?=
 =?utf-8?B?RTFCSUw2QTVIczloNlVZcDM4c2xrT0c4VFZzSGVFaUZLTEdaNVVjUzVCTDVU?=
 =?utf-8?B?TWFwdTE4T2h5RGwyT05DdXhJbFowbmlQa0hCSjk5WVEyWnpKTDR0TXhjaExh?=
 =?utf-8?B?aHUzeTNPWFpuYTNiUjlQYUtmdit2dWxpNXJHek9rK1pUby9ERncxV2xjK1Jo?=
 =?utf-8?B?aFJxZnpETXBQcHEvQ2FYQlFmdzhsM1hRZXE1cDMzTUFUbEhuVitPNEd5dTMy?=
 =?utf-8?B?ejQzdTBWekRNaFdyMkNOa2E3VndsNlp0OXl6c05YdGdNSVc5cmlpSVpZOEl1?=
 =?utf-8?B?QVhZd2kzMUMySEVHRk5DTHZmMDNxcVRvWXllTUlFV1Zkc0FGT25SOUQySWtJ?=
 =?utf-8?B?S0huaWo1K2dsMXdhQnBwbG9jTktBNTFlQ0tELzJidUdQK3BNTU9EZUpmTkhm?=
 =?utf-8?Q?7fpEwZYkDDGTJRxTGZahPmc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05875687-9009-43f5-7d9e-08d9f1ead258
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 07:55:11.0010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8u4U08JQBsY1k9X301vUrYeQ/b/ixleT+Qzcz8M9c34EO6VGEFTN1PDFLn8+NjJRkgHkjQd6MSkUjnuh3a5fZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0171
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

--------------zXaBe5V2v0E15G0V07XdCYlN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/16/2022 8:26 PM, Christian König wrote:
> Am 16.02.22 um 14:11 schrieb Somalapuram, Amaranath:
>>
>> On 2/16/2022 3:41 PM, Christian König wrote:
>>
>>> Am 16.02.22 um 10:49 schrieb Somalapuram Amaranath:
>>>> List of register populated for dump collection during the GPU reset.
>>>>
>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 
>>>> +++++++++++++++++++++
>>>>   2 files changed, 100 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index b85b67a88a3d..57965316873b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -1097,6 +1097,11 @@ struct amdgpu_device {
>>>>         struct amdgpu_reset_control     *reset_cntl;
>>>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>>> +
>>>> +    /* reset dump register */
>>>> +    uint32_t            *reset_dump_reg_list;
>>>> +    int                             n_regs;
>>>> +    struct mutex            reset_dump_mutex;
>>>
>>> I think we should rather use the reset lock for this instead of 
>>> introducing just another mutex.
>>>
>>>>   };
>>>>     static inline struct amdgpu_device *drm_to_adev(struct 
>>>> drm_device *ddev)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> index 164d6a9e9fbb..faf985c7cb93 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> @@ -1609,6 +1609,98 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>>>> +                char __user *buf, size_t size, loff_t *pos)
>>>> +{
>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>> *)file_inode(f)->i_private;
>>>> +    char reg_offset[11];
>>>> +    int i, r, len = 0;
>>>> +
>>>> +    if (*pos)
>>>> +        return 0;
>>>> +
>>>> +    if (adev->n_regs == 0)
>>>> +        return 0;
>>>> +
>>>> +    for (i = 0; i < adev->n_regs; i++) {
>>>> +        sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
>>>> +        r = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
>>>> +
>>>> +        if (r)
>>>> +            return -EFAULT;
>>>> +
>>>> +        len += strlen(reg_offset);
>>>> +    }
>>>
>>> You need to hold the lock protecting adev->reset_dump_reg_list and 
>>> adev->n_regs while accessing those.
>>>
>>> (BTW: num_regs instead of n_regs would match more what we use 
>>> elsewhere, but is not a must have).
>>>
>> This is read function for user and returns only list of reg offsets, 
>> I did not understand correctly !
>>>> +
>>>> +    r = copy_to_user(buf + len, "\n", 1);
>>>> +
>>>> +    if (r)
>>>> +        return -EFAULT;
>>>> +
>>>> +    len++;
>>>> +    *pos += len;
>>>> +
>>>> +    return len;
>>>> +}
>>>> +
>>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>>>> +            const char __user *buf, size_t size, loff_t *pos)
>>>> +{
>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>> *)file_inode(f)->i_private;
>>>> +    char *reg_offset, *reg, reg_temp[11];
>>>> +    static int alloc_count;
>>>> +    int ret, i = 0, len = 0;
>>>> +
>>>> +    do {
>>>> +        reg_offset = reg_temp;
>>>> +        memset(reg_offset,  0, 11);
>>>> +        ret = copy_from_user(reg_offset, buf + len, min(11, 
>>>> ((int)size-len)));
>>>> +
>>>> +        if (ret)
>>>> +            goto failed;
>>>> +
>>>> +        reg = strsep(&reg_offset, " ");
>>>> +
>>>> +        if (alloc_count <= i) {
>>>
>>>> + adev->reset_dump_reg_list =  krealloc_array(
>>>> +                            adev->reset_dump_reg_list, 1,
>>>> +                            sizeof(uint32_t), GFP_KERNEL);
>>>> +            alloc_count++;
>>>> +        }
>>>> +
>>>> +        ret = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
>>>
>>> This here is modifying adev->reset_dump_reg_list as well and so must 
>>> be protected by a lock as well.
>>>
>>> The tricky part is that we can't allocate memory while holding this 
>>> lock (because we need it during reset as well).
>>>
>>> One solution for this is to read the register list into a local 
>>> array first and when that's done swap the local array with the one 
>>> in adev->reset_dump_reg_list while holding the lock.
>>>
krealloc_array should be inside lock or outside lock? this may be problem.

Regards,

S.Amarnath

>>> Regards,
>>> Christian.
>>>
>> There are 2 situations:
>> 1st time creating list n_regs will be 0 and trace event will not be 
>> triggered
>> 2nd time while updating list n_regs is already set and 
>> adev->reset_dump_reg_list will have some offsets address 
>> (hypothetically speaking *during reset + update* read values from 
>> RREG32 will mix up of old list and new list)
>> its only critical when its freed and n_regs is not 0
>
> No, that won't work like this. See you *must* always hold a lock when 
> reading or writing the array.
>
> Otherwise it is perfectly possible that one thread sees only halve of 
> the updates of another thread.
>
> The only alternative would be RCU, atomic replace and manual barrier 
> handling, but that would be complete overkill for that feature.
>
> Regards,
> Christian.
>
>>
>> Regards,
>> S.Amarnath
>>>> +
>>>> +        if (ret)
>>>> +            goto failed;
>>>> +
>>>> +        len += strlen(reg) + 1;
>>>> +        i++;
>>>> +
>>>> +    } while (len < size);
>>>> +
>>>> +    adev->n_regs = i;
>>>> +
>>>> +    return size;
>>>> +
>>>> +failed:
>>>> +    mutex_lock(&adev->reset_dump_mutex);
>>>> +    kfree(adev->reset_dump_reg_list);
>>>> +    adev->reset_dump_reg_list = NULL;
>>>> +    alloc_count = 0;
>>>> +    adev->n_regs = 0;
>>>> +    mutex_unlock(&adev->reset_dump_mutex);
>>>> +    return -EFAULT;
>>>> +}
>>>> +
>>>> +
>>>> +
>>>> +static const struct file_operations 
>>>> amdgpu_reset_dump_register_list = {
>>>> +    .owner = THIS_MODULE,
>>>> +    .read = amdgpu_reset_dump_register_list_read,
>>>> +    .write = amdgpu_reset_dump_register_list_write,
>>>> +    .llseek = default_llseek
>>>> +};
>>>> +
>>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>>   {
>>>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>>> @@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>>> *adev)
>>>>       if (!debugfs_initialized())
>>>>           return 0;
>>>>   +    mutex_init(&adev->reset_dump_mutex);
>>>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>>>>                     &fops_ib_preempt);
>>>>       if (IS_ERR(ent)) {
>>>> @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>>> *adev)
>>>>                   &amdgpu_debugfs_test_ib_fops);
>>>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>>                   &amdgpu_debugfs_vm_info_fops);
>>>> +    debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>>>> root, adev,
>>>> +                &amdgpu_reset_dump_register_list);
>>>>         adev->debugfs_vbios_blob.data = adev->bios;
>>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>>
>
--------------zXaBe5V2v0E15G0V07XdCYlN
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2/16/2022 8:26 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:d531c825-332d-036d-c4b4-5e2cf39edb52@gmail.com">
      
      Am 16.02.22 um 14:11 schrieb Somalapuram, Amaranath:<br>
      <blockquote type="cite" cite="mid:ed1103b1-835c-e56a-3118-17bd60f0f5f9@amd.com">
        <p>On 2/16/2022 3:41 PM, Christian König wrote:<br>
        </p>
        <blockquote type="cite" cite="mid:e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com">Am
          16.02.22 um 10:49 schrieb Somalapuram Amaranath: <br>
          <blockquote type="cite">List of register populated for dump
            collection during the GPU reset. <br>
            <br>
            Signed-off-by: Somalapuram Amaranath <a class="moz-txt-link-rfc2396E" href="mailto:Amaranath.Somalapuram@amd.com" moz-do-not-send="true">&lt;Amaranath.Somalapuram@amd.com&gt;</a>
            <br>
            --- <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 ++ <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95
            +++++++++++++++++++++ <br>
            &nbsp; 2 files changed, 100 insertions(+) <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
            index b85b67a88a3d..57965316873b 100644 <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
            @@ -1097,6 +1097,11 @@ struct amdgpu_device { <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_control&nbsp;&nbsp;&nbsp;&nbsp; *reset_cntl; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE]; <br>
            + <br>
            +&nbsp;&nbsp;&nbsp; /* reset dump register */ <br>
            +&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *reset_dump_reg_list; <br>
            +&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n_regs; <br>
            +&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_dump_mutex; <br>
          </blockquote>
          <br>
          I think we should rather use the reset lock for this instead
          of introducing just another mutex. <br>
          <br>
          <blockquote type="cite">&nbsp; }; <br>
            &nbsp; &nbsp; static inline struct amdgpu_device *drm_to_adev(struct
            drm_device *ddev) <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c <br>
            index 164d6a9e9fbb..faf985c7cb93 100644 <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c <br>
            @@ -1609,6 +1609,98 @@
            DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL, <br>
            &nbsp; DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL, <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_sclk_set, &quot;%llu\n&quot;); <br>
            &nbsp; +static ssize_t
            amdgpu_reset_dump_register_list_read(struct file *f, <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char __user *buf, size_t size, loff_t *pos)
            <br>
            +{ <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct amdgpu_device
            *)file_inode(f)-&gt;i_private; <br>
            +&nbsp;&nbsp;&nbsp; char reg_offset[11]; <br>
            +&nbsp;&nbsp;&nbsp; int i, r, len = 0; <br>
            + <br>
            +&nbsp;&nbsp;&nbsp; if (*pos) <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0; <br>
            + <br>
            +&nbsp;&nbsp;&nbsp; if (adev-&gt;n_regs == 0) <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0; <br>
            + <br>
            +&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; adev-&gt;n_regs; i++) { <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sprintf(reg_offset, &quot;0x%x &quot;,
            adev-&gt;reset_dump_reg_list[i]); <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = copy_to_user(buf + len, reg_offset,
            strlen(reg_offset)); <br>
            + <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT; <br>
            + <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len += strlen(reg_offset); <br>
            +&nbsp;&nbsp;&nbsp; } <br>
          </blockquote>
          <br>
          You need to hold the lock protecting
          adev-&gt;reset_dump_reg_list and adev-&gt;n_regs while
          accessing those. <br>
          <br>
          (BTW: num_regs instead of n_regs would match more what we use
          elsewhere, but is not a must have). <br>
          <br>
        </blockquote>
        This is read function for user and returns only list of reg
        offsets, I did not understand correctly ! <br>
        <blockquote type="cite" cite="mid:e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com">
          <blockquote type="cite">+ <br>
            +&nbsp;&nbsp;&nbsp; r = copy_to_user(buf + len, &quot;\n&quot;, 1); <br>
            + <br>
            +&nbsp;&nbsp;&nbsp; if (r) <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT; <br>
            + <br>
            +&nbsp;&nbsp;&nbsp; len++; <br>
            +&nbsp;&nbsp;&nbsp; *pos += len; <br>
            + <br>
            +&nbsp;&nbsp;&nbsp; return len; <br>
            +} <br>
            + <br>
            +static ssize_t amdgpu_reset_dump_register_list_write(struct
            file *f, <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char __user *buf, size_t size, loff_t
            *pos) <br>
            +{ <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct amdgpu_device
            *)file_inode(f)-&gt;i_private; <br>
            +&nbsp;&nbsp;&nbsp; char *reg_offset, *reg, reg_temp[11]; <br>
            +&nbsp;&nbsp;&nbsp; static int alloc_count; <br>
            +&nbsp;&nbsp;&nbsp; int ret, i = 0, len = 0; <br>
            + <br>
            +&nbsp;&nbsp;&nbsp; do { <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_offset = reg_temp; <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(reg_offset,&nbsp; 0, 11); <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = copy_from_user(reg_offset, buf + len, min(11,
            ((int)size-len))); <br>
            + <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed; <br>
            + <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = strsep(&amp;reg_offset, &quot; &quot;); <br>
            + <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (alloc_count &lt;= i) { <br>
          </blockquote>
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            adev-&gt;reset_dump_reg_list =&nbsp; krealloc_array( <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_dump_reg_list,
            1, <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(uint32_t), GFP_KERNEL);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloc_count++; <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
            + <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = kstrtouint(reg, 16,
            &amp;adev-&gt;reset_dump_reg_list[i]); <br>
          </blockquote>
          <br>
          This here is modifying adev-&gt;reset_dump_reg_list as well
          and so must be protected by a lock as well. <br>
          <br>
          The tricky part is that we can't allocate memory while holding
          this lock (because we need it during reset as well). <br>
          <br>
          One solution for this is to read the register list into a
          local array first and when that's done swap the local array
          with the one in adev-&gt;reset_dump_reg_list while holding the
          lock. <br>
          <br>
        </blockquote>
      </blockquote>
    </blockquote>
    <p>krealloc_array should be inside lock or outside lock? this may be
      problem.<br>
    </p>
    <p>Regards,</p>
    <p>S.Amarnath<br>
    </p>
    <blockquote type="cite" cite="mid:d531c825-332d-036d-c4b4-5e2cf39edb52@gmail.com">
      <blockquote type="cite" cite="mid:ed1103b1-835c-e56a-3118-17bd60f0f5f9@amd.com">
        <blockquote type="cite" cite="mid:e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com">
          Regards, <br>
          Christian. <br>
          <br>
        </blockquote>
        There are 2 situations:<br>
        1st time creating list n_regs will be 0 and trace event will not
        be triggered<br>
        2nd time while updating list n_regs is already set and
        adev-&gt;reset_dump_reg_list will have some offsets address
        (hypothetically speaking&nbsp; <b>during reset + update</b> read
        values from RREG32 will mix up of old list and new list) <br>
        its only critical when its freed and n_regs is not 0<br>
      </blockquote>
      <br>
      No, that won't work like this. See you *must* always hold a lock
      when reading or writing the array.<br>
      <br>
      Otherwise it is perfectly possible that one thread sees only halve
      of the updates of another thread.<br>
      <br>
      The only alternative would be RCU, atomic replace and manual
      barrier handling, but that would be complete overkill for that
      feature.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      <blockquote type="cite" cite="mid:ed1103b1-835c-e56a-3118-17bd60f0f5f9@amd.com"> <br>
        Regards,<br>
        S.Amarnath<br>
        <blockquote type="cite" cite="mid:e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com">
          <blockquote type="cite">+ <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed; <br>
            + <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len += strlen(reg) + 1; <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i++; <br>
            + <br>
            +&nbsp;&nbsp;&nbsp; } while (len &lt; size); <br>
            + <br>
            +&nbsp;&nbsp;&nbsp; adev-&gt;n_regs = i; <br>
            + <br>
            +&nbsp;&nbsp;&nbsp; return size; <br>
            + <br>
            +failed: <br>
            +&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;reset_dump_mutex); <br>
            +&nbsp;&nbsp;&nbsp; kfree(adev-&gt;reset_dump_reg_list); <br>
            +&nbsp;&nbsp;&nbsp; adev-&gt;reset_dump_reg_list = NULL; <br>
            +&nbsp;&nbsp;&nbsp; alloc_count = 0; <br>
            +&nbsp;&nbsp;&nbsp; adev-&gt;n_regs = 0; <br>
            +&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;reset_dump_mutex); <br>
            +&nbsp;&nbsp;&nbsp; return -EFAULT; <br>
            +} <br>
            + <br>
            + <br>
            + <br>
            +static const struct file_operations
            amdgpu_reset_dump_register_list = { <br>
            +&nbsp;&nbsp;&nbsp; .owner = THIS_MODULE, <br>
            +&nbsp;&nbsp;&nbsp; .read = amdgpu_reset_dump_register_list_read, <br>
            +&nbsp;&nbsp;&nbsp; .write = amdgpu_reset_dump_register_list_write, <br>
            +&nbsp;&nbsp;&nbsp; .llseek = default_llseek <br>
            +}; <br>
            + <br>
            &nbsp; int amdgpu_debugfs_init(struct amdgpu_device *adev) <br>
            &nbsp; { <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dentry *root =
            adev_to_drm(adev)-&gt;primary-&gt;debugfs_root; <br>
            @@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct
            amdgpu_device *adev) <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!debugfs_initialized()) <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0; <br>
            &nbsp; +&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;reset_dump_mutex); <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ent = debugfs_create_file(&quot;amdgpu_preempt_ib&quot;, 0600,
            root, adev, <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;fops_ib_preempt); <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(ent)) { <br>
            @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct
            amdgpu_device *adev) <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_test_ib_fops); <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;amdgpu_vm_info&quot;, 0444, root,
            adev, <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_vm_info_fops); <br>
            +&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;amdgpu_reset_dump_register_list&quot;,
            0644, root, adev, <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_reset_dump_register_list); <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;debugfs_vbios_blob.data = adev-&gt;bios; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;debugfs_vbios_blob.size = adev-&gt;bios_size;
            <br>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------zXaBe5V2v0E15G0V07XdCYlN--
