Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D536FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 10:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6176D10E5AD;
	Mon, 21 Feb 2022 10:31:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA0CA10E5AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 10:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkkFk180Jf57jKDmKYY8u681RKNgkE2Ld3uohCPL63uV+YvYmSmJI0r01ybEGJYyn36A7Bj3DBm8qalAp1D1gv5/jBIaz+tzJjRZo7pbxccAh34kR2Ap48XHwpq1/8l09h3IHpx+UAayuIf8dFhIpSibHEzJZymZ2+2eZ6FSqhHmPFDsdqq4DIEYMapkhLpDAQ+kBp+pnwcqlVPlfcm8HGvxqf60mxhP08tQ0GSrneeOBJ5r6mv1pvmvv9K5tC3hHY8Sth9zyUQyKwLc5pxK7doaMDo24+pvlL2aMp/YcCca5hAKe0CCK8BxPcV+wpKPN47V9HnngZwRYTulPKd7pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ixonh78RAQq/e8kATkf0QCuVbNp9YcuyHSkPwCwUFbk=;
 b=mHAPXK7EZrW0e48NVUZ6A9KV8/qsksK9aYbDv5dE/t54YW0sHmoxe9OibopssLtZ1h0+4sf0HewejiAef34uRQwrPw51dAr9AKpM1f4KGFmQkUfJMw0nuNtTBgQjn5TMUeV63X5htq11y1rieZm8HlKjR06gFDKRY68vABNs4IlDfg3W0Qz7u+B2vgyCPtuNmb5VraZ/7HYobqStCVqif7FssXZkvdeC8j5yBUM93FaPgLXWcJq9jSciba0dF7KAlZssikp2yI+/xQ2RLzffjNxfD0Ay2pL28Su6nCMGra281CtOHxbUif9HhMyElok1xiObD7bBxqrlhTlozitYmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ixonh78RAQq/e8kATkf0QCuVbNp9YcuyHSkPwCwUFbk=;
 b=s8WIDbnawEik2E2N+Tt+IKoV3PeGSIwy2fq2RpYfk+F4h+5hXoY/X4w08Tvxr+5HqjSq1+EsHO0Pwlp2aGwBmninxl/24eSnnAI1QISdU3ni9jxtpeg7UtJ0+B6DHZ8NVnTOpjcN0EM6fhzbaShniJGry5ZVJ/14zAHJy8UQJ3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CO6PR12MB5475.namprd12.prod.outlook.com (2603:10b6:5:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Mon, 21 Feb
 2022 10:31:10 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 10:31:10 +0000
Message-ID: <e7264e6b-09a9-7d22-ff81-8dcc8f830be9@amd.com>
Date: Mon, 21 Feb 2022 11:31:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220221071540.2485-1-Amaranath.Somalapuram@amd.com>
 <a588e193-3509-73b3-b0d6-962c2b72dc4c@amd.com>
 <DM6PR12MB389702E53C862BAE2FA8B840F83A9@DM6PR12MB3897.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM6PR12MB389702E53C862BAE2FA8B840F83A9@DM6PR12MB3897.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR05CA0021.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::26) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f81c7fe2-f137-4361-fc54-08d9f52546a1
X-MS-TrafficTypeDiagnostic: CO6PR12MB5475:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5475C200F2BABB1C3A0BC6A1833A9@CO6PR12MB5475.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6bbCgyT7Jx/rGkX35nVcvw8GTnOoHzXCUTxHCyOufQdUNHWseZUDZM57KJGDfHrLJRKx5n8tqTcZepJvCNgMcsRYYgXToZ1jLwW/jrlXslYnQRLKdEO/3OXgREzV5qaDn7ZGhQ6rTYJukrITOY/U1aZWxDfHAW8Zuby9cByshsl5H99Twl0aDSA2+KIrtpkSJQdNNEFRPMmMthkhPtzy7EMJDKXmwMQ6nlA8pelyk1Jw9RFfWOx6YA5pk+T0BdEgwppoTF52P/ZXMjiUKA2W6lS76bM1DJlvcRx5gv6CIdXYOSdLEzqZAFgPm5gaPWogZqLp5WqGr2k8GNa5Xca1YxCCeFfunofx+JFxvWtupw6UyqKtkqPH1RLGmqiEBcX9msh6tFLLlXprzl6YmZOazTFAgVWRxf9FIoh+KCsTn6mTfVH3JwQR/xZinNXOY8xB9pMVdpVOd9liqIX3q2XPaPd84aOfSOKhtFI1W3Oyk+cxcUtDH5RV3iN7IL6P3X8nKH938pct2pYcvAAY5iu8IepIoa7qCTYCoDQg3n0QYoy56AHp1QCzlkk9JQOl/sWIDERJ5U5Zz+NgNG3SY5MX5Ue2jmifAZUuYaKB0r4LPU+dXNDspC0Nq0pIfVOlct0i1ArW6t1zs2nxnjdClamTPvjzPVyQ5YIbVZwVnXqU0ncR4AjHbp6WPoCCIpLC6v++3BLjhj9hnIYUQklqflHi7ZL92GfqOYH+9iIy9CGBq1n/0FHUEe5BiqE83BngB5b
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(31696002)(2906002)(2616005)(8936002)(38100700002)(186003)(26005)(86362001)(6512007)(316002)(66476007)(31686004)(66556008)(6666004)(83380400001)(110136005)(54906003)(66574015)(53546011)(6506007)(6486002)(8676002)(508600001)(4326008)(36756003)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkJFakVnSzN0WU11QVdMMHFsSEEzMlZSMEZpMWZBbktDaUtiYW1qZFZzNit4?=
 =?utf-8?B?R0lMcVdSc0NOSENZT2x1bHA0QjZnQzBIQVN2VGh2UjVhSnlkYXFZNlpJbE1R?=
 =?utf-8?B?RjRVSkVzMllpNk9jSHlPYW1rMnM0OE9Lb01XWVBtK0RSd1FlRjdDb3Qvb3dW?=
 =?utf-8?B?cWRDb001eW8vUzdKRlZNczZ0clRxM3JWeDJab1J3QW14NkVpWFFVM0tHZkRq?=
 =?utf-8?B?WlpzRHN2MmJ2a1hMZmxjZzZMNWRKeUlhYklKMjhncHJsNWE5WThTbWV5RWgz?=
 =?utf-8?B?T1RZYW5mMUdpNWJhY05leWMxMWxJbXlRTEpQOXBDaWhpTEgvSlVYR2QvTTRP?=
 =?utf-8?B?TUZBMklTUThuYkRhSXBkSENmMUJNQkZyRG1ETkszQ3Y5enc4MVZ5Mnp1cVNs?=
 =?utf-8?B?NkVzR1BSR3VaYVorL2FCbWtzSnZpZGlJZEFQakppRjl0RzdYZER3azg3SnZ3?=
 =?utf-8?B?cDFsQlZIV3NLUjY1SzJpWk03aU5VeThPSm9RWVRjMDVxVWN5dWRKMGlxTmlG?=
 =?utf-8?B?OTBKL3hHVmM2Um1iYlMzZlphUFBqNDU1Y2Z0Q1RyTU9jcnJEb0lpSVV2ODl2?=
 =?utf-8?B?WjlpZWpoRFhFbnNYSUtjNk9JcGpGRzQ1aHZBSm9oR2czajU5UnVUR1pyY3Nm?=
 =?utf-8?B?K2hUSXZ6bkJsRGNSLzdYbVVJdml6QzBhQ24zRGpDTDEwZm9kai9YemNxdE1m?=
 =?utf-8?B?SlJySEhsODV5L2k1S3VpSk56YVg0TzBkWXRRblEzUlV1ZW13ckpaWDJHZjJ2?=
 =?utf-8?B?UWU3MjZMOUdCVTFjRVNVZU5jUTY1Y0NPY0g3dERRK0JZY2huNTh3ajNHWjNX?=
 =?utf-8?B?b0FraGMzbXhXUUtjNGFQSFJXYUxnVWxVZ1U3ejRYRVFiS2N6cnp3ajZIOHRE?=
 =?utf-8?B?cVE3bWNNWHFCQXpUYzJTVGczdW5ISVUva3lZRHVYR0FIL05EMUs2WXdHKzRF?=
 =?utf-8?B?bGpRaFdsYXo5WEtnVFlMbjFJa3NQQmtSWnVUMG4rRFlpSW1wYmQyVWNiT2VR?=
 =?utf-8?B?dk5meEI0SG03S25lZDJCL0R4RzRxNldXdVUrbnVzenBTMzJyVVhYYU9XV094?=
 =?utf-8?B?WHlJQmNMbUtKa05KWGY1NVdpWUdzd29KOTdvdjdYdUd2aWxpWkh0czZrYnJz?=
 =?utf-8?B?TWVVZ1pXalkrNjFabDNRdmM5eThLSzhITERDMU4rVUxKb2RqUGZ3b01NbnZi?=
 =?utf-8?B?Tnc3MjdsTlJmQkdMZkNsc0VGRlAwckZRMzk4dGdUT1ZZeWVDNTBCS2djT2Z5?=
 =?utf-8?B?UVkzZVJHOFlaQzVnVzNiYVA1ei9YUDhmdzUvaGw4eFhsSlNyQXhJQzZJVGM0?=
 =?utf-8?B?c2IvMEtZY3JmQm1sbkFEcTB4NHBTTGlHaVVtR0d3dmVTSVBScmMrY2VGcW02?=
 =?utf-8?B?c1NWdGJvd2NQVGI2Qko4TEthd1I5QUMxMlRjcDV4cjZzd1pkeUVGSUVyeGxp?=
 =?utf-8?B?VVBISWxIa2lKN0dYeUNWUHNyWXJDT3V6SThuNHJIemx1MGV3OFdjdEhoRUNZ?=
 =?utf-8?B?K3NqcDdadXlnNUdOakZjc3hkcnFpQzBHRHdmUmJlVlhlRDMvV2RXR2prK0Nj?=
 =?utf-8?B?dWJNeEx5bE81dkhGME1laEVXYTFnZEduTER0cnkxbkZ4dWZvVWtCTkd4Q0s3?=
 =?utf-8?B?L3Eyc2g1b000bFFqUStITFFsdHBzYVN3Wm5ERHBNSUMwTHk4UW1VOE8yOWlj?=
 =?utf-8?B?VVFVTHZtUHJTbVBYQUgycWFETTdxYkovdithSWsvTkVuMDV6L3orYjk0cnJh?=
 =?utf-8?B?WUJxVmhxeVgyaEJpc0wxUGdqS0c4a2FJYUFsSVVEaDhQNC8vUUVZOXZqN3hv?=
 =?utf-8?B?RnlqdTBWNDl4YjhmZFY3ZWxmUHFzUWh2SHpYK3VOUVZKd1MzUmJ6TzhRaFpo?=
 =?utf-8?B?TGpjUHo5M0xDbDgvTUlaaUtFbHZhU3VTQVNqdllOSkVKemYxUkJJWlRHSDJp?=
 =?utf-8?B?NFpxL2dHTXQrdVBDVEs0RkJ0dnlPVmc3eC9QcVlmV2hHNFRnTGJpNFlKSjBE?=
 =?utf-8?B?M1VCWUY2QUptQ21OTk9iVXFlYzR5bU4wdERjN1ljOVFsRDdqd3BoajhseFZS?=
 =?utf-8?B?L2loYWxIS1JDOXhNdXhJZlpHQlZFSGQrSzZtOXNVek8xZDdVcXF5OEplWVJG?=
 =?utf-8?Q?3pag=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81c7fe2-f137-4361-fc54-08d9f52546a1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:31:09.8658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hohO0DjiIu8AlIoyEWUDbY0K//FH6spSSsh5UlyadnXfIQFEAuFn8/ug/D0RBFiv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5475
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

Am 21.02.22 um 11:06 schrieb Somalapuram, Amaranath:
> [AMD Official Use Only]
>
>
> On 2/21/2022 2:45 PM, Christian König wrote:
>>
>> Am 21.02.22 um 08:15 schrieb Somalapuram Amaranath:
>>> List of register populated for dump collection during the GPU reset.
>>>
>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   4 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 114 ++++++++++++++++++++
>>>    2 files changed, 118 insertions(+)
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
>>> index 164d6a9e9fbb..14ad9610f805 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1609,6 +1609,118 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>    DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>                amdgpu_debugfs_sclk_set, "%llu\n");
>>>    +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>>> +                char __user *buf, size_t size, loff_t *pos)
>>> +{
>>> +    struct amdgpu_device *adev = (struct amdgpu_device
>>> *)file_inode(f)->i_private;
>>> +    char reg_offset[11];
>>> +    uint32_t num_regs;
>>> +    int i, ret, len = 0;
>>> +
>>> +    if (*pos)
>>> +        return 0;
>>> +
>>> +    ret = down_read_killable(&adev->reset_sem);
>>> +
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    num_regs = adev->num_regs;
>>> +
>>> +    up_read(&adev->reset_sem);
>>> +
>>> +    if (num_regs == 0)
>>> +        return 0;
>> I think we should drop that cause it just avoids the final \n.
>>
> ok.
>>> +
>>> +    for (i = 0; i < num_regs; i++) {
>> That's pretty close, but one problem is still that it is possible that
>> the number of register becomes much smaller while this loop runs.
>>
>> Try it like this instead:
>>
>> down_read_killable(...)
>> for (i = 0; i < adev->num_regs; ++i) {
>>      sprintf(...)
>>      up_read(...);
>>
>>      copy_to_user(
>>
>>      down_read_killable(...)
>> }
>> up_read().
>>
> I created local num_regs to avoid lock ousted the loop. I guess you me
> to remove ?
>
> so we can hold up_read inside the loop ?

Yes to both. See num_regs and the pointer always needs to be consistent.

In other words you need to read both while in the same instance of the 
critical section:

down..
num_regs =...
up
...
down
x = array[num_regs]
up

That above is illegal since you read num_regs and the array in two 
different critical sections.

But when you do:
down..
for(i=0; i < num_regs; ++i) {
     x = array[i]
     up..
     ....
     down..
}
up...

You still have multiple critical sections, but the read of both num_regs 
and the array happens in the same one and because of that this is legal.

>>> +
>>> +        ret = down_read_killable(&adev->reset_sem);
>>> +
>>> +        if (ret)
>>> +            return ret;
>>> +
>>> +        sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
>>> +
>>> +        up_read(&adev->reset_sem);
>>> +
>>> +        ret = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
>>> +
>>> +        if (ret)
>>> +            return -EFAULT;
>>> +
>>> +        len += strlen(reg_offset);
>>> +    }
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
>>> +    uint32_t *tmp_list;
>>> +    int ret, i = 0, len = 0;
>>> +
>>> +    do {
>>> +        reg_offset = reg_temp;
>>> +        memset(reg_offset, 0, 11);
>>> +        ret = copy_from_user(reg_offset, buf + len, min(11,
>>> ((int)size-len)));
>>> +
>>> +        if (ret) {
>>> +            kfree(tmp_list);
>>> +            return -EFAULT;
>>> +        }
>>> +
>>> +        reg = strsep(&reg_offset, " ");
>>> +        tmp_list = krealloc_array(tmp_list,
>>> +                    1, sizeof(uint32_t), GFP_KERNEL);
>>> +        ret = kstrtouint(reg, 16, &tmp_list[i]);
>>> +
>>> +        if (ret) {
>>> +            kfree(tmp_list);
>>> +            return -EFAULT;
>>> +        }
>>> +
>>> +        len += strlen(reg) + 1;
>>> +        i++;
>>> +
>>> +    } while (len < size);
>>> +
>>> +    ret = down_read_killable(&adev->reset_sem);
>>> +
>>> +    if (ret) {
>>> +        kfree(tmp_list);
>>> +        return ret;
>>> +    }
>>> +
>>> +    kfree(adev->reset_dump_reg_list);
>>> +
>>> +    swap(adev->reset_dump_reg_list, tmp_list);
>> Just an assignment is sufficient here if you do the kfree before since
>> tmp_list isn't used after that.
> This is required. what happens when the function is called for the
> second time (the old tmp_list will never be freed)
>
> tmp_list is also freed as its can return from the middle of the loop and
> tmp_list  will never be freed.

The swap macro doesn't frees anything, a call to swap(a, b) just 
exchanges a and b. If b isn't used after that it's the same as a=b.

What you can do and is usually considered rather elegant is something 
like this:

r = down_write_killable(..)
if (r)
     goto error_free;

swap(adev->regs, tmp);
adev->num_regs = i;
up_write();

error_free:
kfree(tmp);
return r;

Since swap() exchanges the old array with the new one the following 
kfree() will always be correct. In other words in the error case it 
frees the temporary one and in the good case it frees the replaced one.

>
>>> +    adev->num_regs = i;
>>> +
>>> +    up_read(&adev->reset_sem);
>> This should be a down_write_killable() and up_write() to avoid
>> concurrent reads.
> I tried but some time it was deadlock while testing. (some on in driver
> holding reset_sem).
>
> Let me test it once again.

Try to enable CONFIG_LOCKDEP (under kernel hacking) that usually yields 
a nice backtrace into the system log when you do something wrong.

>> Apart from that the write function now looks clean.
>>
> do we need down_read_killable in the below function (second patch) ?
>
>
> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
> +{
> +	uint32_t reg_value;
> +	int i;
> +
> +	for (i = 0; i < adev->num_regs; i++) {
> +		reg_value = RREG32(adev->reset_dump_reg_list[i]);
> +		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i], reg_value);
> +	}
> +
> +	return 0;
> +}

I don't think so since that function should be called during reset with 
the reset_sem held.

What you can do is to add a lockdep_assert_held(adev->reset_sem); which 
will give you a nice warning when somebody calls this function without 
holding the lock.

Regards,
Christian.

>
>> Regards,
>> Christian.
>>
>>> +
>>> +    return size;
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
>>> @@ -1672,6 +1784,8 @@ int amdgpu_debugfs_init(struct amdgpu_device
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

