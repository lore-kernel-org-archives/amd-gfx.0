Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34975C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 13:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8DFF10EA91;
	Fri, 11 Feb 2022 13:16:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB7510E12E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 13:16:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnyZnAgMC67YQnsFtuYqVysA21NQyDKl/t71wwExpf0RZhlTkq0LKIh7zHz+wT4vcsd67b4qk6lL5cOnTmok6Z/VDA+yTVgLLp+xizR0IZmSiaErQECxoGtXGVuX5dIwb4e2ZbU6yWkSx4rcp5vW5oQuyMofwn8TesKKUTG9kAhHWRNqtrfN05T2hkLqhGHLmO6NIGKeop66GsYz+8eA1t5sdbYlkEE90/FS3uKk6M6XVCd3t0Dy5K4HdhGdyFG84xJi8eXmxWo7Uknjh37/zHL5pS8HTc/hFry4QAWBBFaPbz7wyRvfiLWP3LMwd4cF/tWIkR4y+GtsdRoolBf1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTge5JxBLsng/98vFUDqUgZa3ndLxzHCGV8NIZMgTJk=;
 b=Mauic167DiBp7I6j6/NddqlCN2jyIiVqtapB+cKqp/KvMd2udEaegbdqH0c2mB9q+fwCv95jSbYwregd6Tu7O8l+K3ar3v+zyJWeCQ8dJnyYEhyPb5L+iBWo3/IKk9gCJscE6XVtZ3yqHEfxfZwNR7n0FJVfHot6q8KmwqOPV6EXB+c/0mSp4Zupoy0Rr/Z4fOacu8joWjULb2dB4j8bE2XCOF72D4fIAci4y3QVLviETG1G5Gmc8CmslQf0M5VN1B0cYl2IEyQzquGFb/F2J0Tp08lh89fl7aOk3jZCug3JCXLMZ1/LUYfSn2wZE9+Qjh10Sh57pztuEdVRqfaqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTge5JxBLsng/98vFUDqUgZa3ndLxzHCGV8NIZMgTJk=;
 b=YpKPNOf73+SURX5FnMPq3HgGQ7jPLPohDzwib2ZHWypnd/cqlfAHYV9LfgP+4dMnXXgX5CrFeUEBcjCnazdg/BpNpXRVaA4J73igo3rNeTdzSIcKUS1JLV2cZO97n8uLErxoIjhNYSnMwe7TStWuePp2ImFKLPmNSnLayfafg4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by BL0PR12MB4883.namprd12.prod.outlook.com (2603:10b6:208:1c6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 13:15:57 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d%2]) with mapi id 15.20.4975.014; Fri, 11 Feb 2022
 13:15:56 +0000
Message-ID: <00ed810c-b474-d1ca-81ee-ea362d709a32@amd.com>
Date: Fri, 11 Feb 2022 18:45:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220211114740.10904-1-Amaranath.Somalapuram@amd.com>
 <a7c372d6-0ea5-a41f-88c5-77784ebe0811@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <a7c372d6-0ea5-a41f-88c5-77784ebe0811@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2P15301CA0001.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::11) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77c7bd5d-e81f-4594-20c6-08d9ed60a358
X-MS-TrafficTypeDiagnostic: BL0PR12MB4883:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB48833AB2A4DECDB2A4BAC3A2F8309@BL0PR12MB4883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJnqBLRGJqbR56wLqOANRY0LgK6pOsSaHLlpL5dmIzeRtJdydQxD4FLa/1Rr980vNq4a08Ha2Ym+fDjIUtG1nX1djJH4BWu0gIOmF2cDm2O1gVbJpokw4Ry5X76OU68g6Wryx9BVnlcGDng5vwuay+E/TRtU/dIpimmiQN0aXpzhkqlLQdy1+sBAcY42/DGwSE8yIhDi9bLo8ySXSxI+DyoRfHZjEGm2+WeFVZKFXdEd2nHVfY8c460X/PkImAKGEpsUR2w8SIWWlbWhWoHX1AZApSyIgE5ODd3sXwxVNDi8MTRy+/yL0yNg1KXwlOy9orMy6OipM3Ki0U0dhM8L73tmsCHs/Be6IEFG8B5i5veXsixzYJdcOXvvxdV75/9/vctvuMccMl+i8ZrTA9eCTyNIU7b3aog36PEaKEYAhFVhkTmTv3eFWfa1YtFI66rc9LXiHVei7u4s2XORUh0NTkJg2+0TrJLz2CZjFWfTuX4ClrKcKKyQy2oTdvigM5KoeK97Fiu4kCihWHEpKvuaNbUZXh+LVQrpKMz6FI8UTiWvPAebCcZb7QKRg3963q0rna3UTUJOb+RMbIv8iImJhc726UtmooqXjRB5JNeLDK2docaeNTS3SIatK0Fpva72CyoDWk2jUWL3jhXQZMv9m/Lphq7JF3Nvsw8RlKhTCeA6EGWeQimjawvjJE7co8ulOa/qV4V48lUrCi2UsYBqXXrJP8udcXkHAOuNKARx68o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(31696002)(26005)(38100700002)(66946007)(6512007)(66556008)(4326008)(66476007)(8676002)(186003)(6506007)(5660300002)(8936002)(2616005)(110136005)(2906002)(6486002)(31686004)(316002)(508600001)(36756003)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGk3RjgrOFZKdXdBajU4V2RCZktvQllWYitjNENFQ0RlTUt6SkxXZDFMeDEv?=
 =?utf-8?B?Y1EyVmEzQVdDUlh4R2taTTZVWEVQMDB2NVRrWjNZcFlHUGUzMTlyMDFCOEor?=
 =?utf-8?B?VlFHL2Z6YlpEN0ZXdXNnc1ZBd29hVmpoMjdPSjg2V1czMUZaN1NFa3kvSUJx?=
 =?utf-8?B?WGFzRXlxaFRpRjdDUm00bmhwSitMemJzZUx5dFlDRXo0SkQzcjR4SXAyNjF6?=
 =?utf-8?B?V2V0cjN2V2FudlFvY3JvU1JwVkhOV1pXT3F3d3N6Z2VSeE1kcHpESVQzK1RS?=
 =?utf-8?B?Z1h5SEd1NzQ2dmhHb3JuQ2IwdzFsU2kzTEJ2Wk1wdS9idjZvdngrcWdxUW1x?=
 =?utf-8?B?Q3pEWHJQNW50MUMzOCsyM0M3U003SUJBd3FUb1pjTUVOYmpFK3JiNjFseDhR?=
 =?utf-8?B?K1ZseUJ3ZDQ1NWJ3Znk1VzV5R0xxc05WamxjNCthbk04VnI4ZWthVk5ja2hu?=
 =?utf-8?B?aGljeXJkK3lYQUpKNGFVSEFsWXRhZWdzcVl1Z080dHpUa2YydWltNkhCMWlD?=
 =?utf-8?B?K1NKZjVuNTVGeEdCYjZ3NjloSlY1TE9NcHlsR2NsdkFuM1lZcEsySEZyYnA4?=
 =?utf-8?B?MXdjWkZVSVJRcjVqOHlqYmtGeTY2Zmw4b3h4R1dRRDBYZDdDbk4zSlhORmda?=
 =?utf-8?B?enE5bTdocnYxWVFBWHY5VktjU2lvRVhrT2RoRTJ1VUQ5WmxDREU0WDMzK3pU?=
 =?utf-8?B?TTdXbW9DcU9TU0xnQVdyb3hBQ0FlT1c2VHhTVnMzUmcwVUk2UnVTOUF2eWtL?=
 =?utf-8?B?MStsK2hjOVFHSlcxb2QyNG1XWUs1ZTh6SzJLeDI5SUY5Zkl0WDI2TUhySVU5?=
 =?utf-8?B?R1Qrb2hkUzcwWk1rVXJ6cnBsWmZlN3k0TTk5TGN6N0xOWHJJOXBpZ3o0LytW?=
 =?utf-8?B?Z3ZkSFhQKzB6c2tGY2tSRjJUSVlmNk04MFl1bUFqNVZoYTR4Sm1aNTNSK1NV?=
 =?utf-8?B?bERrWkVzaGduZHJDZ3Q4Vy9DMXQwTnlSdG9QTWVTYmtSbXp5YmtsQ0Q1ZFBy?=
 =?utf-8?B?bHk4SElLSGxCb05OWjdHemdzNE1LUHdJcHZJTjNlQ0RjUHpOSFplMkpvL0E2?=
 =?utf-8?B?NTBZd3BiQVd0TzBxZDBOSElYVlVoUStGTmVzYStJN1ZiVXFmU2kwVVA3blZC?=
 =?utf-8?B?ZWRPei84MlBrcHQrVWpFa3BNc2p4UDZGSFp6QzVmVmREL0cwK3d3dHBna2NU?=
 =?utf-8?B?NUFPNDFvRGZ3dEs0bXF2K2NDRXpHam9ZaW05cGNSdENSdTZBWmJiaCtwd2lG?=
 =?utf-8?B?Y0lzRnZGZkhldUZFQXN1dmlHNmRzVjJqei8yalE4L0pWL20wdlpRNEpPWDFO?=
 =?utf-8?B?WEw2ZDJ5NjhhZmhZYWgyTVNSOFZ4RG5ld2ZndVFNUUt3MHRmUFBaUFJSU05U?=
 =?utf-8?B?akdVTFkvZGlqd2Z6UHF2aWNaNTFQRWtTUGo0QUp1dFdFTkxlRXVJKzhMcGpC?=
 =?utf-8?B?WlQrbmtWcTd5K2Yxb1liRFRxNVdCSzlPSGw0QVFoVUJvWklzTkt5SXlFNUpD?=
 =?utf-8?B?OHFIRVVBV2FFeUtVOXM0b3lUYXhOeUppcm92WHJQNkQwQXgyNkRpUFNKVnhr?=
 =?utf-8?B?aTFFQThhUWRxbWwyamVlQ1ZwSHdoSThEaTQwN3grM1R5RWZBczB1ZkJVY2ha?=
 =?utf-8?B?ZUJKb0x1eG9QMjhEQTJwU3FZc3dXUkkyOHZJeWJtejNaeUw1QzBpbGJuUUNx?=
 =?utf-8?B?Mnh4VTlUSGRYUm9ZQzFuUGdGS29lN09IUlBGUkN6MXZjUVM2RStTeGFkbjc3?=
 =?utf-8?B?eEVadmlReXVPOVhRc0pMQ0ExWG1ZS0ErazhaUW9XMk9WcU1sbHRQd21BNkVl?=
 =?utf-8?B?OTRobVQwR2JGYzNqR25SSFdtMVlrdmRoR2NyWXg1UGVZbTJsTEJ3L2VFdFYz?=
 =?utf-8?B?MmRYRWVPVEtxZ1I4V2VYSEtyY09vQWVJOEsyNjFVNFdnYWRvcjAzOU5wbWtr?=
 =?utf-8?B?QzlyUWZWR2docFdrSmY3UWJYdWtYOGgwTk5NQXRiYzd2QmY2K1hzTjJBcVNS?=
 =?utf-8?B?TFFUOU5CK1V0ZFRhTGxBc2FxY3JJUGRSdTRtS2VkMm1hbCtWRXhrdFY1R1RQ?=
 =?utf-8?B?ejRGZENoOVRnY256K2oyazRZSEl2WDZQVmRGd3daSmxmUFUybW1aUnFnN04y?=
 =?utf-8?B?WEJpMnBTUWdXMkFmWWFucmRkSzU3Qk81d1BXV2pseEZVNGR5cUE2QzIreG51?=
 =?utf-8?Q?hN+4bSoyskeGo0JAOL3vXwQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c7bd5d-e81f-4594-20c6-08d9ed60a358
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 13:15:56.6646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e97BPVXWWEnwqOKO2UhN1aBB30lXukJsQVEQUKYmXnb9Xsz+YhzYru1EGN/okeswdjudDdjTPZ5qU8If5C0VRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4883
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


On 2/11/2022 5:22 PM, Christian König wrote:
> Am 11.02.22 um 12:47 schrieb Somalapuram Amaranath:
>> List of register to be populated for dump collection during the GPU 
>> reset.
>>
>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 61 +++++++++++++++++++++
>>   2 files changed, 66 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index b85b67a88a3d..b90349b86918 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -813,6 +813,7 @@ struct amd_powerplay {
>>     #define AMDGPU_RESET_MAGIC_NUM 64
>>   #define AMDGPU_MAX_DF_PERFMONS 4
>> +#define AMDGPU_RESET_DUMP_REGS_MAX     128
>>   struct amdgpu_device {
>>       struct device            *dev;
>>       struct pci_dev            *pdev;
>> @@ -1097,6 +1098,10 @@ struct amdgpu_device {
>>         struct amdgpu_reset_control     *reset_cntl;
>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>> +
>> +    /* reset dump register */
>> +    uint32_t reset_dump_reg_list[AMDGPU_RESET_DUMP_REGS_MAX];
>
> Using an xarray or just dynamic allocation with krealloc_array would 
> probably be better.
>
> Regards,
> Christian.
>
I can use krealloc_array,
Then in the second patch i need to use kmalloc (or hard-code values) for 
this: uint32_t reg_value[AMDGPU_RESET_DUMP_REGS_MAX];
We actually tried to avoid  dynamic allocation during reset (second patch).
Also AMDGPU_RESET_DUMP_REGS_MAX getting used in trace function.

Regards,
S.Amarnath
>> +    int                n_regs;
>>   };
>>     static inline struct amdgpu_device *drm_to_adev(struct drm_device 
>> *ddev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 164d6a9e9fbb..fb99f3d657a4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1609,6 +1609,65 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>> +                char __user *buf, size_t size, loff_t *pos)
>> +{
>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>> *)file_inode(f)->i_private;
>> +    char *reg_offset;
>> +    int i, r, len;
>> +
>> +    reg_offset = kmalloc(2048, GFP_KERNEL);
>> +    memset(reg_offset,  0, 2048);
>> +    for (i = 0; i < adev->n_regs; i++)
>> +        sprintf(reg_offset + strlen(reg_offset), "0x%x ", 
>> adev->reset_dump_reg_list[i]);
>> +
>> +    sprintf(reg_offset + strlen(reg_offset), "\n");
>> +    len = strlen(reg_offset);
>> +
>> +    if (*pos >=  len)
>> +        return 0;
>> +
>> +    r = copy_to_user(buf, reg_offset, len);
>> +    *pos += len - r;
>> +    kfree(reg_offset);
>> +
>> +    return len - r;
>> +}
>> +
>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f, 
>> const char __user *buf,
>> +        size_t size, loff_t *pos)
>> +{
>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>> *)file_inode(f)->i_private;
>> +    char *reg_offset, *reg;
>> +    int ret, i = 0;
>> +
>> +    reg_offset = kmalloc(size, GFP_KERNEL);
>> +    memset(reg_offset,  0, size);
>> +    ret = copy_from_user(reg_offset, buf, size);
>> +
>> +    if (ret)
>> +        return -EFAULT;
>> +
>> +    while ((reg = strsep(&reg_offset, " ")) != NULL) {
>> +        ret  = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
>> +        if (ret)
>> +            return -EINVAL;
>> +        i++;
>> +    }
>> +
>> +    adev->n_regs = i;
>> +    kfree(reg_offset);
>> +
>> +    return size;
>> +}
>> +
>> +static const struct file_operations amdgpu_reset_dump_register_list = {
>> +    .owner = THIS_MODULE,
>> +    .read = amdgpu_reset_dump_register_list_read,
>> +    .write = amdgpu_reset_dump_register_list_write,
>> +    .llseek = default_llseek
>> +};
>> +
>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>   {
>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>> @@ -1672,6 +1731,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>> *adev)
>>                   &amdgpu_debugfs_test_ib_fops);
>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>                   &amdgpu_debugfs_vm_info_fops);
>> +    debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>> root, adev,
>> +                &amdgpu_reset_dump_register_list);
>>         adev->debugfs_vbios_blob.data = adev->bios;
>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>
