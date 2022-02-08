Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188A0C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 13:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE10D10E3B2;
	Tue,  8 Feb 2022 13:39:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED4D10E3B2
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 13:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnr6O9fiL3JUOSQkh3GKLYfamk8+BEbRPsuUzWL4nWs3YptezUfu218xsJbx/PwUAquyRfmBU+1JnwPFGek528XtZML4BVZpXJft2Vbgi03SDa2XaH8bA52cFTQcJ5Ccm2Dz9bm6D4xUiR9MDpbhJeDgoxoSlLCe0eIT4ZJmH6F4OkpTD8FaE8l8Txgfwmb4bEwKwsOeXOQVkukRQl94qpiQm0neORzYXsfj5XkDuA7g1Nq0HjghH0hJrWONMFzYTTacsA5ZxHx34cok1PZOMg6xGSyyWXG8RYG5Eiy3z736RZKTMQPriiOLCWXCHaF8SAfOMGahkUEXeAdCfRuPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DK5EPyDX/HVf/yF1Kvs6xgWqvf1t3zTFuUT7+CH7G3o=;
 b=GssVlRcftWV/kjX2Z3ZEm8Z5xT9AxHtqWjemM4gNxd4lPD0IOM0WcenGQnAlXmw1ZrfaQBFcm7ZPt3qpr2kQ+mK6RE9J0I48p+9mfzVJXdMUXd/MPKzBChdCJm+ZE3+lOmFtIyHZOnsIrYpYL0Rt3PU0glsBzqgL1J4yJDvziLd9KTSSX9lE7U/zV7ffiO7lmpLeSmb/oPHPMf9TEDYLwF7W11eH7lYHVYKCg3LAibEPcUIdndh2qY4vpgkpvU5/eN72+W0VmeVS+liUgOG+T+rzgTEF51oo5LKUE2oAJwjEBY2LqSca+Jpk7WkPcmIdWczaLWa0ER8sMs+7x70R5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DK5EPyDX/HVf/yF1Kvs6xgWqvf1t3zTFuUT7+CH7G3o=;
 b=VaNwAr+RTpdEBg1L7s9lBbjvlG4tFwknebaqidiRZFu9bMjuv0PIe8poZU54m+jjQpfekA61yJq2+dnWeF47T5GoED4ttJY/y1dIt2IKHoUJr01UoRaCCNv00aXxLaRaHwpc7VSESMYlKixwTQXMp3UKdS3wtlBGuk3/0kzHTs8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by DM6PR12MB3867.namprd12.prod.outlook.com (2603:10b6:5:1cf::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Tue, 8 Feb
 2022 13:39:23 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::e8ac:d90:95b4:f70a]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::e8ac:d90:95b4:f70a%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 13:39:23 +0000
Message-ID: <52c555ab-ec80-bcfc-5811-270b3b23c5c8@amd.com>
Date: Tue, 8 Feb 2022 19:09:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
 <385688f4-2165-ba58-8928-5774a44044e7@amd.com>
 <e700ecfd-1935-7545-f962-b6decd4377c5@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <e700ecfd-1935-7545-f962-b6decd4377c5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR0302CA0024.apcprd03.prod.outlook.com
 (2603:1096:202::34) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54d94248-7b5f-4945-3217-08d9eb086ac3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3867:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB38679EE342ABE2FE53AFB0DAF82D9@DM6PR12MB3867.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aEoLJ/MZBIOL2rz2UcaoUnHz1g88iqfFxbbOjY2JVx9ScEZXoYsn31qecavJmdg5HA9TEu/wC0eth55TiUoaYO1qHPUbh8/wjGUqpHZr4kRvaxWVLR6lLq0YxXwWLpg150S5kw1+i+32d6ltPgD62uOw8DOcASf4utc8xfM/4kHew0qgLcV0nv9qVACJG1Ncxe2EXYlLW1fKgUGh6Z1XubuIjoKL+yn12N2qqqb3eImtJOruzgY+YFCpQDWAzFqH8KCeLiwEPJ8o1gJCTp7Jq5/7ANFsGcMfQ0uEjJTl/7sQRXyokP0/bNKXu7jf8k1hmvEJdY2QR9RDgfJ7OcshJlfJi2Rf2fFX5lJzPRGonAGi8ok0VBH2ndGd3rORhUZFG/zgNHTHRjgab/1YRxprhgVwVqIN81XFrg8h8MGaXBl/Z04Qg4dHZJb66ahudmGV22UCjR/iVLp2dW0ZFS+vvWGXm3ZDnaE4RKO+ZvCgRng30p7IYtoJbC0W+mIO3K62u0d05/KeyRAIzvojVeAc2+IWTQ2aUY7vIX+iI8ObOYDQ8+t+Rlfl5RCv7ahrEzYS+nsZ9IaQH9XHjGC0d4cs82XG1CqUkrWKKhBp1pY16Ihix6EIZTFljOJiBuoV3fC74rc/APr4l8mWsSqqJScnCP2ybH+zhbrChGbOI3Z7g3Dkio/7Xc3Mu74laaNfEAdmc8N5wljv8pwWjMpDcJ8/z02WQX9vdm5fTvoPSrSAcRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66574015)(83380400001)(4326008)(36756003)(26005)(186003)(31686004)(2906002)(38100700002)(6666004)(5660300002)(53546011)(6506007)(66946007)(2616005)(110136005)(508600001)(66556008)(8936002)(66476007)(6512007)(316002)(31696002)(8676002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTVXS2ZwK0l1THVhV2hJUk5KbUtNZlBWUWxZc04vSkJ5K2hTb0JlOTIvZ3pl?=
 =?utf-8?B?QUorM2JuanpVQmNOYmpRK1Z3Uk9HMVdGU1cvSFZQNmlRZ1o4SWp4cTRJQmFD?=
 =?utf-8?B?dlJKdktTZlR6WThJbVdyeTFUekhDKytqL0g5TlRGeU5IVGZUTmEvM3pGUnVB?=
 =?utf-8?B?UU9QSDRGWUlMUll3VEJoTkdteVJJa0NzTWVETFhxa1QvVHgzM2RxSFdjM3hB?=
 =?utf-8?B?eTVNQ2E1NEQ2S1oxclVpYVhiMmFkOFBpVGdaMTNiUjBocWRIamdBdG9KWEk3?=
 =?utf-8?B?WHN2T3VvYVhCU0dzbDhCbm84OStEakUwaTZrMFhuRmJQblVFQjhoNUJwdzYz?=
 =?utf-8?B?VzZwOHVTMzVTczRpUWVBNUY2a2t5em04bWlRdGZkUE5KRitvVy9yNzlJSm94?=
 =?utf-8?B?bGNNejNNbDlZTjRsYVVpV1pmNzFEK3M3TXluZUZBMElqOHFUV3NTb1h5ZTNp?=
 =?utf-8?B?SVRlbm94M0tCRG1jR0JGZGR0TkNTeGdOUmVaaFhtL0hlcmhvOC9DZVgwRk5l?=
 =?utf-8?B?UjhtQUVHNHk3dmZPc3poL09rd1g0S1NPcFZXcWpObE1kZzh0Zk5EYmFORUdR?=
 =?utf-8?B?YU5mNXpXdGFic29IcTZWd05VMzZrZmh3bHcybm1wTXlPSUtYWkxUalIxeW5U?=
 =?utf-8?B?eHplK0xLejR0cTVEbkpEZXlJRmJrK0toV3dQTHQ4UVdpQlJkaVU1Y1dRUlBR?=
 =?utf-8?B?QWJaZTFRdk9SYW8vNzlrVFptMzltMTJzdTBHNjZvTnZ6ekQ1cjJkQ2ZCdDUv?=
 =?utf-8?B?L1BsQ1QxVkNHenhYMjhqSldXQ3k3YkZhSElNWXZlNUpjVmFnc2lBRStld3FN?=
 =?utf-8?B?bVpHanFHTjE1MjNJeFkxc3phdXZmWkJ5VUhwMUFPcXNIRFVsWHZUTHRhT3Np?=
 =?utf-8?B?NnE0Q3ErdEhqWllRUTN4U3ozQkFqUU16NUdqRG5mTWxydE8rS0tlaUE4bjM0?=
 =?utf-8?B?V29hb3hmRTdkUk5RaVhHcXEwSFUwdDBPMnl5cnFzaVFzWFV5ZitSaXhEMlZa?=
 =?utf-8?B?MVhTNStjVWZPV3BOSDhOUTh3OXZhT09jSkhRbWNzVXc0KzJ4SlJDdjY2WjNq?=
 =?utf-8?B?ZDh1YUFIUEo1UXRoVDhuVklDS1R3ZUhickJSU09GVkFTM3lDOEltMCtoTlB2?=
 =?utf-8?B?dzBLNkhwamFBeVdqeStmYlM2TDdHbEFsZHMwMTJheUI2MEw1dEdFSUdGTUtS?=
 =?utf-8?B?YXVWVFNTc3ZWeW9DYklhOHc4dDR1UVk4dTNaNWVZNkU3RmxOdG92RUJVYWxx?=
 =?utf-8?B?OStWSDNHbHBiMVNEbFlSckkzVzRSS2o3K25IN0dVUHZxNVMzejRGSVNDb0pH?=
 =?utf-8?B?WWJ3aE5IMy9IMmt0L0NqeFFkNmh2MVdVVG13VzNhTU4wTDBRUUNISWh5Q3lF?=
 =?utf-8?B?RWFFWnkzMkhjK2tjVUVDRTRCMERVaGxHZHY5dUZ3dzJ1ZEdyOXNsQkwvVzJt?=
 =?utf-8?B?eWYxb3ZIZjN3c1NUeXZWS29QR25YWFBRSWptMTNzeVhodDhWSGprWE85ZmJz?=
 =?utf-8?B?dmlTeWt5dzNra1ZlMmdNRXJIYzhPcUtoYWdGdHFYMVF0SmQ5Q1BHOEJpU256?=
 =?utf-8?B?WTRGQVdRQUs4UWtCeDJkUjBwRmg0N1pUbGMzOGhKTlh6QSsrQUE0V2FYajhX?=
 =?utf-8?B?U3hrY21aTjZvQ3hXZlJaSURLaDFqOWFlYnZQNjdsQnVsYU82cEpIOWVkSS9S?=
 =?utf-8?B?cGRPTStPQ3YzTVRyVEtSdDg5NURVSFVOR0h5UlhzVzFKSnpGTXlNK2FLS2tz?=
 =?utf-8?B?WGc1M2FWcVhaYmR4ZXpWcElIWXB2NGhOaUhrVmw4blFWSlFNWTY1dHV5cFlG?=
 =?utf-8?B?QktIdzR5eXdLbjh0d2NhYkFKY29jOFUvc1o4QTdsMEIxazl1NlptUXRYL2d0?=
 =?utf-8?B?MEZLYWJSNmZJajJGQmcvOExYTit3U2I4Nk1IeG1GUWxpaE1TV3JBckpyb1po?=
 =?utf-8?B?bFF0Z01WdDVLZGEwbEV2WDBsby9Xc2tleG56cHZvSXc4NzJVZ0RyaE0rQUth?=
 =?utf-8?B?TVB4YXhSSjY2aDRqNFJzL0hOSEdOWFJQYy81VGgzR3o1cXBuMWc4VU52VUZP?=
 =?utf-8?B?algwcGhIcUdLRmpZakRFNXJ3VjF4WnVoUk1HSUJYVGY4VWErbk9SbHdCSzZ6?=
 =?utf-8?B?cEthYlBvL3FxN3dIcGovaFpnV1BaS3dGSHB4anV1WWtrQlp5RFJOMlI4Vm9L?=
 =?utf-8?Q?g8pB+zB0XKnXC0N+bR7TiY4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d94248-7b5f-4945-3217-08d9eb086ac3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 13:39:23.6984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKlIO7ubESFtBPUeSS894QQkvoFnEibJQFOuZONpOlOlKCckkkSJgss3dvlMjDivk/Adm19MzfOBQ0h1Hhb4ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3867
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/8/2022 4:43 PM, Sharma, Shashank wrote:
> I thought we spoke and agreed about:
> - Not doing dynamic memory allocation during a reset call,
as there is a redesign debugfs call will happen during the application 
initialization and not during reset.
> - Not doing string operations, but just dumping register values by index.
I think your referring to the second patch which happens during reset 
and no string operation in second patch.
> NACK !
>
> - Shashank
>
> Amar,
> Apart from the long comment,there are a few more bugs in the patch, 
> which I have mentioned here inline. Please check them out.
>
> - Shashank
>
> On 2/8/2022 9:18 AM, Christian König wrote:
>> Am 08.02.22 um 09:16 schrieb Somalapuram Amaranath:
>>> List of register to be populated for dump collection during the GPU 
>>> reset.
>>>
>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  3 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 60 
>>> +++++++++++++++++++++
>>>   2 files changed, 63 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index b85b67a88a3d..78fa46f959c5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1097,6 +1097,9 @@ struct amdgpu_device {
>>>       struct amdgpu_reset_control     *reset_cntl;
>>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>> +
>>> +    /* reset dump register */
>>> +    long            reset_dump_reg_list[128];
>>
>> I don't have time for a full review, but using long here certainly 
>> makes no sense.
>>
>> long is either 32bit or 64bit depending on the CPU architecture.
>>
>> Regards,
>> Christian.
>>
will change uint32_t.
>>>   };
>>>   static inline struct amdgpu_device *drm_to_adev(struct drm_device 
>>> *ddev)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 164d6a9e9fbb..dad268e8a81a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1609,6 +1609,64 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>> +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>>> +                char __user *buf, size_t size, loff_t *pos)
>>> +{
>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>> *)file_inode(f)->i_private;
>>> +    char *reg_offset;
>>> +    int i, r, len;
>>> +
>>> +    reg_offset = kmalloc(2048, GFP_KERNEL);
>>> +    memset(reg_offset,  0, 2048);
>>> +    for (i = 0; adev->reset_dump_reg_list[i] != 0; i++)
>
> This loop termination condition is incorrect, why are we running the 
> loop until adev->reset_dump_reg_list[i] != 0 ?
>
> What if I have 10 registers to dump, but my 4th register value is 0 ? 
> It will break the loop at 4 and we will not get all values.
>
agreed, i try to avoid one more variable in adev
>>> +        sprintf(reg_offset + strlen(reg_offset), "0x%lx ", 
>>> adev->reset_dump_reg_list[i]);
>>> +
>>> +    sprintf(reg_offset + strlen(reg_offset), "\n");
>>> +    len = strlen(reg_offset);
>>> +
>>> +    if (*pos >=  len)
>>> +        return 0;
>>> +
>>> +    r = copy_to_user(buf, reg_offset, len);
>>> +    *pos += len - r;
>>> +    kfree(reg_offset);
>
> Also, why are we doing a dynamic memory allocation for reg_offest ? We 
> can simply use adev->reset_dump_reg_list[i] isnt't it ?
>
> simply
> for (i=0; i<num_of_regs;i++) {
>     copy_to_user(buf, adev->reg_list[i], sizeof(uint64_t));
> }
>
> Or without even a loop, simply:
> copy_to_user(buf, &adev->reg_list, num_regs * sizeof(uint64_t));
>
> - Shashank

it will not be in user readable format for debugfs, (if non readable is 
acceptable I will change this)

> +
>>>
>>> +    return len - r;
>>> +}
>>> +
>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file 
>>> *f, const char __user *buf,
>>> +        size_t size, loff_t *pos)
>>> +{
>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>> *)file_inode(f)->i_private;
>>> +    char *reg_offset, *reg;
>>> +    int ret, i = 0;
>>> +
>>> +    reg_offset = kmalloc(size, GFP_KERNEL);
>>> +    memset(reg_offset,  0, size);
>>> +    ret = copy_from_user(reg_offset, buf, size);
>>> +
>
> We are not allowing user to write into the list, so this whole 
> function can just be a NOOP.
>
> - Shashank
User only update the list of reg offsets on init, there is no predefined 
reg offset from kernel code.
>
>>> +    if (ret)
>>> +        return -EFAULT;
>>> +
>>> +    while ((reg = strsep(&reg_offset, " ")) != NULL) {
>>> +        ret  = kstrtol(reg, 16, &adev->reset_dump_reg_list[i]);
>>> +        if (ret)
>>> +            return -EINVAL;
>>> +        i++;
>>> +    }
>>> +
>>> +    kfree(reg_offset);
>>> +
>>> +    return size;
>>> +}
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
>>> @@ -1672,6 +1730,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>> *adev)
>>>                   &amdgpu_debugfs_test_ib_fops);
>>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>                   &amdgpu_debugfs_vm_info_fops);
>>> +    debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>>> root, adev,
>>> +                &amdgpu_reset_dump_register_list);
>>>       adev->debugfs_vbios_blob.data = adev->bios;
>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>
