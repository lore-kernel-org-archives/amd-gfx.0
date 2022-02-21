Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FA7C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 14:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA1B10E397;
	Mon, 21 Feb 2022 14:28:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFB5010E397
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 14:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mwv8TmLuCrjBsJdcd8ibo07VZUy78lJP4Tk1I7z8Q5h5lXBazWfsIwPWLPXiNuT+iqhmK0sPHx0Lzt8qbuSLH8z8z0XV7t8cZ/z44yNAIYWRB7oS7EqblCkcJUHJ6mXmQaWbU18gyeP9zRG98LE/TzaUjbNHOdzkPemfyk6UkPVNkk8JrlhkTIzyaTFvNu7rMWNoZWCvNU4dnWVvd5n7bfoe8K3pkQbpIg6PxSNc0V1z+riMcsomsasrUguAT1qPmgcNCG1DeA2wjedtFDVxPvkx1cyfEsxtrbNjSIDYR5JhJvmgpHlVZPjThopHbKMmvfZz82mak7cv3Q7CSqJU3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wMNPnZ0rwrmDL8emIcRfkubwRqFuruLa7afdKnw+7I=;
 b=JkzOGVCRdYfOS6SVIqyy7auh721ziP9/fnQ48ZjSfVTyy4VX/gSLB1jNKXyWboi1iVNwUxsbglGv+wu2HtyJhG1DlYPKFmZIQ8ZeZCMSGwM8O3SnFhOVi2PcL7h6r1k/25oYetacZ37o3Q0SvjhOSuwXCXDoIdZGvT+1JGcKyg+fmN7aHMnEvcOsUG4F5Rc0U/ejqtB6z5BJV3i/BW1EJoAkS6WUGxLWjjmcFgMuErtIYUqHpnbTQRI8jQ1bgKz1An/03kp851SJCvsLx1TZiUD3pbvLF0O8HoGKL023MIlWLxKWAMiL2Mzi8sDn1BQ9Y3orYuNK/vzcOP+pPFeSeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wMNPnZ0rwrmDL8emIcRfkubwRqFuruLa7afdKnw+7I=;
 b=hN6Geu6wpQCAa5cPcudZw2Fq3hJbteUAlUrQJUs8cvqF27gNuz3zljBuWgLeTBlODzyVrQOnRu9pddhfRnl+ny/uL0ZRbkAi6DGPGECHDNgK0nRcgRTfZyqg03m+mgrGWt3DqLby0vGk0QJ93QLxD6Su3Yy6xA027hg9tAVNFiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 14:28:39 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 14:28:38 +0000
Message-ID: <c4eff3b2-fa00-1bd4-09af-3f8258228c84@amd.com>
Date: Mon, 21 Feb 2022 15:28:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220221133411.12544-1-Amaranath.Somalapuram@amd.com>
 <3a66af2c-edd2-cc0b-1caa-8fa989b94a02@amd.com>
 <DM6PR12MB389730FB7E38A62EA781C141F83A9@DM6PR12MB3897.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM6PR12MB389730FB7E38A62EA781C141F83A9@DM6PR12MB3897.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0602CA0004.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f9d615e-b085-4837-a643-08d9f5467394
X-MS-TrafficTypeDiagnostic: DM6PR12MB4058:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4058FE3ED55F817FFA0C624D833A9@DM6PR12MB4058.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aHh4cccugyBVq9JY/rPoLIFt/6ay/R1sLwmoday1DLomoenSyWVS6tPT/K6GARQxKPmcULKG71AzMb0uvDKFJvdtkn1VR2ibbPUnY8uW7YOkHIHL4K9+Bj+CdzFFPQ0DSUtUap9tFprVyedvBYzTggYgJszMdiMV8x4hzHwnquUqAZS9a3QiZVKF2nEdEg48KuzT/FaR1wvn8j7L/P3e08t6MqYcbev6I0blRzv7s1P74Kjr0+ht2Mqem6byglaggTAUm238yPi3NNxozRSfEYjcfe5vXJAokc8k3wbFKuxU65t+d+VD3JpG17nqjIadnYUSKE/P8phEa99a6dLtkF4YB8yCXcSIzuJgKOlsj8BrjW7HwSvOfybhm3AhUTn8/3i+jvSXGcI6BzNLVkPCsO9GAfUMUoqIbZYi48eJqxjR1Tos7cEnhivodX3Ml2eORwfKuZE08O4SNFbx4IsgMpoBoU3FdahhdwHPJ+/dqGG1HQ/W4gElxS9RgrEdmLsx45nDeQ4yWbO8aHnIIZh1OzL2KvvUrRRNSgM4koJOwwwMC4V0ZxMDQb1NqkrGyqZuZAGLd/AfDsuXsMbruwq9x2A5ZNpfgXrco85pLf1WclPiNUpI1kqAMw9/WN2Cgh3JA0dT6CKoF0msal9p+d00oBnZNSW3yyf8YH8TZ6zG8VgzSR7WXBzs9DiQb6IKBlVVNAnRCjqj9o14hJqejVW5Ppk+Cy/sW8VNCKHK6uxa7y41HG0u5siX7LBeb/qU1Tv1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(66574015)(54906003)(66556008)(31686004)(6666004)(83380400001)(53546011)(8676002)(508600001)(36756003)(4326008)(66476007)(66946007)(6506007)(6486002)(5660300002)(2616005)(2906002)(8936002)(31696002)(316002)(6512007)(38100700002)(86362001)(186003)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0p0NU9sM0dEMW83NWM3aUphcHBrU3krWTdTOEpXSER6ZzFSWUx4VlUvT2p1?=
 =?utf-8?B?d0FvNlJzU0s5VitRWGNqZVVrSHNNeDZ2MXgraW9sa1hXRlpSam5KVDJ2Vnlx?=
 =?utf-8?B?R0h2NVc5WXhkQnh1RjIwTE02eW94WWJUMWJrYnhkRU1seU9GUWZ2VGh4TEx4?=
 =?utf-8?B?aVJIY3ZzTTN5bXpZSmdKRzh4aERCcUx5QlJTZGdsRmFCWW1vZ3ZTTTFIbmlv?=
 =?utf-8?B?SVJFRzhuK2JyakpTWlpTNFc5TmRGME1iZ1pyUitLUlNjRlhsTVNGRzhYT2RN?=
 =?utf-8?B?TkFjOUtUN1c1YWh2ZENLMWQ5bUptbGF3OFllOGpKdzYvbUxOTTBraHhWSi9u?=
 =?utf-8?B?NGQ2dkJFVElPMmdoTlFCK0hJcFJleGkxZ1RQMjBOblFrWlFZVkE4SExhcWJm?=
 =?utf-8?B?MnI3a2xLb1NYVFhWZzFxYlU0MW83LzN2ZUYrRE5NMTAxMnBSUlg2ZEtlTUdC?=
 =?utf-8?B?YmNkNVpneG9WNWFKWDBNVUsxVkN0b1NEMENyN04wMjh3aE1JR2o5anVXby94?=
 =?utf-8?B?VllDV2dNNGQ5bUFoeUd4eWYxakJwMmRJYUdHMDArZGg3RVo2eldPOG9QWnI2?=
 =?utf-8?B?MTRCY2xpYVZUWEk5cVBoYnhBdUhlcXpzZGF5d3NHK0NXOHJ6S2U5Z2NocTM4?=
 =?utf-8?B?R21jcDdpa0Rvdlo3akxxM1hTOWYrd2VTaXpOUjd5dytQcisxQSsvNUVlbHk5?=
 =?utf-8?B?SnJlSEVHZmM5eHFpbHdaeTh6U0N0d2ZCQUlpTzhaQXZ5QVlNZzAvNUg3Wlo0?=
 =?utf-8?B?dExiRnV2dGw0TzQvL0s0elJOdUt3UmxJbFZxTUpMNEtHSHlFYnFQRGJKUkJ1?=
 =?utf-8?B?QktweURHeHU2RGJCMWFVY01NTnVmUXRuSFRoVmFLTmNacWNOZ3dzNVBNeXNl?=
 =?utf-8?B?U0tOc1Z5OFVQR0lXVWFtSjFNUG9GOWdxYzJvMldlUDJOK2RRVmdiSlYvR1hl?=
 =?utf-8?B?dkZ6aFNMOW01RGxOZjRvMkRNNTAwRUgzMW9DTkRXSkRDY3JFR093TFJaZXJm?=
 =?utf-8?B?c1R2NDFWbTYxdmRDS0xLUHB4dmVIUXdJdXpSVGNkY2FsbWlTVkQvUXJlWFJs?=
 =?utf-8?B?RW5FTHhmN2p4cjZ0cElCYmluR2Rya1RGamhBcU1FcmxkbmtWWE9vYWU1OGlW?=
 =?utf-8?B?UnFUL3JHd1FXQS9mYUxtNnFKRlZ0ZFBVcmJBazY1Q2h6eCsrL1F4ZC9ZbjJR?=
 =?utf-8?B?ZkFTUklxOGVFbitMTHpqb3d3b2VxOU15Vksza3NHWXZudU9VNmtQR0hiVHhH?=
 =?utf-8?B?d1B3dG5tb05tN3hHZU9zVFZMeWdFTWRpUGhTWkZaUjZpZGdXR3FJOGsyakxX?=
 =?utf-8?B?MEJGQ1dzWmxLdzI2bVFUYS9ESmYvcXNsaGIvSkVmWDhnOEFkN3ZnRDYwc3hW?=
 =?utf-8?B?WFBwY000TUthOGpLOGFGaEIwdVpPSU44cXlCaFFqdk1UbGNHSDVhY0dMQlpW?=
 =?utf-8?B?bzdEeVZRSDhUZWhaYldPTjkyTHNTdWFTL09yZ09oMVE0NEo1aHlPUnBwTk1K?=
 =?utf-8?B?KzVNQzdBdTU4RTJnejVsaXVJNFJlME4zbk5xVFJYWElvNzNZT3dFS1ZjbFJ2?=
 =?utf-8?B?OUFmbi9uK3Z1UHdSVFdGRHhlczN0SGxmQ3ZPMmZjaWJScjlCdFJ2Vml2U0pk?=
 =?utf-8?B?NVZnOC8wYzNyV0hjQ1hxTjcvaDd5SGhqS2N0MSt1anF0eXFuY1pMT1hGQ042?=
 =?utf-8?B?RHpIQlBHV3AxeTNQNnlrN2dWNlZWb3VIWHg4REVkSHFPUzlMdWN4ei81YUh3?=
 =?utf-8?B?bytyM3VUZEVFb1JaSmNYT09pQzBFR3p1Q2IrelhyMi8xWlJCSy9OTkZiWkZR?=
 =?utf-8?B?L3RDSUtobndRTWVDNFNCb3NGN3BKTEpNYzNyL3ZFdkJaM29rYTNBcTZ0cGtV?=
 =?utf-8?B?cHlaYzhmYUQ1NGI3L1VCVC8yVS9yU3habkZqM3VpSXE0Z0NKK3FsR3NDRG5U?=
 =?utf-8?B?VVFuOGpaQ2FmVWNZcUhuenBnaWU2dzlnL092Y0poeit3a01pdE1qNURNdktX?=
 =?utf-8?B?bUE0TlVoNEFWU0lWMUtoM0JkSXFMcUlBVWd6T0VZdGdpaEh2dHRjb0ZnUmkv?=
 =?utf-8?B?R21HeFp6TGhGYnVKcWlxT0V2aERjc0cwWkszK1hVWFd2OW8wQ3ByNkpSd2lT?=
 =?utf-8?Q?xDhA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9d615e-b085-4837-a643-08d9f5467394
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 14:28:38.8710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxwJDKvTM8+iSZHnPwniSvcA4gRawD03bzPQYsCJPu6XeQZ4BgwYhOc+NHLrsKzf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.02.22 um 15:19 schrieb Somalapuram, Amaranath:
> [AMD Official Use Only]
>
>
> On 2/21/2022 7:09 PM, Christian König wrote:
>>
>> Am 21.02.22 um 14:34 schrieb Somalapuram Amaranath:
>>> List of register populated for dump collection during the GPU reset.
>>>
>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 96 +++++++++++++++++++++
>>>    2 files changed, 100 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index b85b67a88a3d..6e35f2c4c869 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1097,6 +1097,10 @@ struct amdgpu_device {
>>>          struct amdgpu_reset_control     *reset_cntl;
>>>        uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>> +
>>> +    /* reset dump register */
>>> +    uint32_t            *reset_dump_reg_list;
>>> +    int                             num_regs;
>>>    };
>>>      static inline struct amdgpu_device *drm_to_adev(struct drm_device
>>> *ddev)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 164d6a9e9fbb..69c0a28deeac 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1609,6 +1609,100 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>    DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>                amdgpu_debugfs_sclk_set, "%llu\n");
>>>    +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
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
>>> +
>>> +    if (ret)
>>> +        return ret;
>> We usually don't have an empty line between function call and checking
>> the return code.
>>
>>> +
>>> +    for (i = 0; i < adev->num_regs; i++) {
>>> +        down_read(&adev->reset_sem);
>> That here will just crash because we have already locked the semaphore
>> before the loop.
>>
> unfortunately it did not crash. Sorry I misunderstood your earlier comments.
>>> +        sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
>>> +        up_read(&adev->reset_sem);
>>> +        ret = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
>>> +
>>> +        if (ret)
>>> +            goto error;
>>> +
>>> +        len += strlen(reg_offset);
>> And here the down_read_killable() is missing.
>>
>>> +    }
>>> +
>>> +    up_read(&adev->reset_sem);
>>> +    ret = copy_to_user(buf + len, "\n", 1);
>>> +
>>> +    if (ret)
>>> +        return -EFAULT;
>>> +
>>> +    len++;
>>> +    *pos += len;
>>> +
>>> +    return len;
>>> +error:
>>> +    up_read(&adev->reset_sem);
>>> +    return -EFAULT;
>>> +}
>>> +
>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>>> +            const char __user *buf, size_t size, loff_t *pos)
>>> +{
>>> +    struct amdgpu_device *adev = (struct amdgpu_device
>>> *)file_inode(f)->i_private;
>>> +    char *reg_offset, *reg, reg_temp[11];
>>> +    uint32_t *tmp;
>>> +    int ret, i = 0, len = 0;
>>> +
>>> +    do {
>>> +        reg_offset = reg_temp;
>> I think you can just drop the reg_offset variable;
>>
> strsep takes only pointer as input, this is workaround.

Ah, now I see what you are doing here.

Please don't do it like that. Better use memchr() instead.

>>> +        memset(reg_offset, 0, 11);
>>> +        ret = copy_from_user(reg_offset, buf + len, min(11,
>>> ((int)size-len)));
>>> +
>>> +        if (ret)
>>> +            goto error_free;
>>> +
>>> +        reg = strsep(&reg_offset, " ");
>>> +        tmp = krealloc_array(tmp, 1, sizeof(uint32_t), GFP_KERNEL);
>> That must be krealloc_array(tmp, i, ... not krealloc_array(tmp, 1, ... !
> I thought it will append (if not it should have crashed or some kernel dump)

No, krealloc_array works similar to realloc() in userspace.

You need to give it the full size of the necessary space.

Regards,
Christian.

>> Regards,
>> Christian.
>>
>>> +        ret = kstrtouint(reg, 16, &tmp[i]);
>>> +
>>> +        if (ret)
>>> +            goto error_free;
>>> +
>>> +        len += strlen(reg) + 1;
>>> +        i++;
>>> +
>>> +    } while (len < size);
>>> +
>>> +    ret = down_write_killable(&adev->reset_sem);
>>> +
>>> +    if (ret)
>>> +        goto error_free;
>>> +
>>> +    swap(adev->reset_dump_reg_list, tmp);
>>> +    adev->num_regs = i;
>>> +    up_write(&adev->reset_sem);
>>> +    ret = size;
>>> +
>>> +error_free:
>>> +    kfree(tmp);
>>> +    return ret;
>>> +}
>>> +
>>> +
>>> +
>>> +static const struct file_operations amdgpu_reset_dump_register_list = {
>>> +    .owner = THIS_MODULE,
>>> +    .read = amdgpu_reset_dump_register_list_read,
>>> +    .write = amdgpu_reset_dump_register_list_write,
>>> +    .llseek = default_llseek
>>> +};
>>> +
>>>    int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>    {
>>>        struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>> @@ -1672,6 +1766,8 @@ int amdgpu_debugfs_init(struct amdgpu_device
>>> *adev)
>>>                    &amdgpu_debugfs_test_ib_fops);
>>>        debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>                    &amdgpu_debugfs_vm_info_fops);
>>> +    debugfs_create_file("amdgpu_reset_dump_register_list", 0644,
>>> root, adev,
>>> +                &amdgpu_reset_dump_register_list);
>>>          adev->debugfs_vbios_blob.data = adev->bios;
>>>        adev->debugfs_vbios_blob.size = adev->bios_size;
> >

