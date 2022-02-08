Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BC1C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 11:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 916EA10E600;
	Tue,  8 Feb 2022 11:13:34 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2040.outbound.protection.outlook.com [40.107.101.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F07910E600
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 11:13:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+4our3U7AazdkO3I5o47FhWbPt5P0wSpn095znXLg6kWePhv8b9bIG6I7OMGrN7EU9uTZBs2Xo2gvSgu6wCY2+Nnu6wNprjotBCE7XC3wPngt6y2WehevPnIxpcvG0/QpgESOksjWsG+Oe4253+EY8CW6srP/QeyGM1eux64koBiTDMv89JQBjKsP4noB/0NsVwUGTmsL8AiukWHFGtYmDwNebOYPQfwOn3gPpE8Ax86CYxE6FWPD8FWJBWQvje0wlUbopWmcDUL+4iBfwiJ+0N35bGrL8w4wzEfpVlV7BSgEEAWI8Hypyt1tqADQyIqS7s+CDVhxwVkX+QShXo8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHwtfxa/Qorx+8xUEVbTkvmgbZN0eLcauhufvQAmYBk=;
 b=hCJjLXGyhXkPBnhfhYTigUQv1CR5HkijoC4nmXeSGN9iiuoIHY1kgK+R74VN5dwbeh2otyF0CqV09zodTt+m9dDU8DLS8+dM1HbUsckr+kt+7Hkk7CfpIKkF81EQ4gVEL4FkHhaLKLU5YUb/fbNGV64NjWOZF41k/tMgg13DhxZrL9uZAsDHw+gPAPQpwqLKVogy3DcTrqVJSZTNOlXJvaN6c8qiqWzsP8th0pt9yHcgu1rsOF2sxESZWRxCsmP4f0xHW4fMSjHuoVbdSjTh3Wl0Jkj9vfxyQ2BKpLUN/CKnJYpt64Fx8CU72B6aXXpQDmJdmchJ8o6QC3TIUln/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHwtfxa/Qorx+8xUEVbTkvmgbZN0eLcauhufvQAmYBk=;
 b=JfkcxL3WHAWt6kR3NaVSNj8JZAHJakYrdE5bJZstgSgU9eexSv/RQc0lAMoao9IUZv5ZmY5pMV/3mNBYGqH2lG/YJTv0cE8Zrea+/IzaZG5YKbGoIcn1T7egB7+p/Q/Qp6vYRBZ07Vx3UOJjoS4yaajxdsKFxbmHctVK5ylwm7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BYAPR12MB3430.namprd12.prod.outlook.com (2603:10b6:a03:ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Tue, 8 Feb
 2022 11:13:31 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4951.018; Tue, 8 Feb 2022
 11:13:31 +0000
Message-ID: <e700ecfd-1935-7545-f962-b6decd4377c5@amd.com>
Date: Tue, 8 Feb 2022 12:13:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
 <385688f4-2165-ba58-8928-5774a44044e7@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <385688f4-2165-ba58-8928-5774a44044e7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0601CA0036.eurprd06.prod.outlook.com
 (2603:10a6:203:68::22) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f49e8685-7953-4825-f810-08d9eaf40a37
X-MS-TrafficTypeDiagnostic: BYAPR12MB3430:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB34305F51C6C2864D4D2A7ACFF22D9@BYAPR12MB3430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /cP91oq9U6WFI8akHlkLtjG92L7Di0rT3YSV/72hpMzXtZMcX2jw8ZbpH1nTrllMw6zT3nO5JxjfMHCPg5QCBlhRQdRcZTgNVlEwigu0UZf943pyk1rJuVfcXXOO6mut0eJNj/5J0qPo90JVR+9zh7YsL1vf5UvhD4sU8hpnKoWCElHQVVRbS1s2Sx6b2j0M+4Umc7E8RzuH2ZF341FhPlhn80FZkJyFwA5mbcwuVkjBUZqzU8ToH3aERw4TLB/BVXYZ1B3wNFMQhNiBeInusMEDesI8a8bnXxY2E9rnHiA/P+uoe5BDYEoWkg4rPwTYTbVP6myQw3wV+Q9AMHj8NGjLXsZCl2Z5DkbFRJ99Wf8/Ffr88yETW0psDD4tnsiHzjL1s/n3+Hzw4MEF4/h3/Wlxr3jMQxz8FAew6Hwq2T2VBNqPbkb/3VtwJA9lyi+tIgNcDQ3Y+UEwA9UEDrzMSc5RWH5XK36fJoxkFaKTWG0SHVrdxdfkAFZ3LcdqJFg+zDNKt8RbwLGw3UVjGiQwjbegzK+erHEPuMbaU0p/aPU4FqbikBYEF/2FrekI5EZ6qRDu77zuX2M+P3RrbyML5Z7PBldOaw441Y2YcPeOYQtlC3hgeYOZmRLmrCdmtOxEzPCIpC1e5Akpb9vawDCgRrvCNsZf0V549jUtmfxFVJL4wUo65herAA3W139u2Jjws0X5obTzu8Db+9PsUlwQN4Vy0hMf0SXFIt2R4naRaK1Q8mNtkT5oiM2a8g4ZfSnD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(6512007)(8936002)(4326008)(66556008)(66476007)(38100700002)(66946007)(86362001)(31696002)(316002)(53546011)(110136005)(508600001)(6486002)(6666004)(6506007)(186003)(31686004)(2906002)(66574015)(36756003)(2616005)(26005)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEcrRDY1UDVPSGVMcjJDei9XekVHNUtlUUhrR3Y4dy84U09GUXdxSFpLVjZE?=
 =?utf-8?B?REFncGZGaTJhK2ZocUVnSlZRWk5KM0ExNytRamI2LzlGakYvYVUvUnhaajhP?=
 =?utf-8?B?MVMyU0NUQTBhNGpySDdIMGJFZVRmUFBtN3I3cS9EQWRSZmQrZTlYTlJsU2h6?=
 =?utf-8?B?b1F1MU5ZclkyNnNaRDEzS1FhdEpZeUFvQWxxWnYyWHFYOTA0U0RnQ0ltcnB0?=
 =?utf-8?B?K1EzNnFQT3FnTUxVSDRrOXM3b0dSVnVNdDBpTENFcTJZTjd5ZnluSDZraEhj?=
 =?utf-8?B?eWpFKzhYa1E4YnpNeXNBb215cFNwWXZEeFVJMXJTamFCbEpJZGx0NHlFd1Vk?=
 =?utf-8?B?REFIYldGZWxxRjlsZnZlZVRrV3NORENaVEp3WU5tckowckRvV1FCR1NpYkdx?=
 =?utf-8?B?N2txaXArVm5oaVNEU2FaRmpqdmxoVXlqdHlOUHVRTWZhNlJjQnRYVmJJZXEz?=
 =?utf-8?B?bVB6SHU4c010SHhqRDV5TEJPUGd3QjEveERZTzNRVS9NSkczWWx1K0NqQWtj?=
 =?utf-8?B?bGpJTjJWUVVVMlpPa1NuK3FqVkxibXFVNnh2b2p4UTgwRjVHRVkyZ0xxVjhq?=
 =?utf-8?B?bWhkazMwRm80bWoxTTZsWHBNYm9CZXdFc0oyMkx3R3FNZHp6bVVmS3VPb0xP?=
 =?utf-8?B?bzNpOUNIbEd2SDk1R3VKYjQyVHJERW9hejkxQ0RhQ1FMUndTbHBaU3BzTXQ1?=
 =?utf-8?B?U25Dd2U1eGVJSjlwWGI2eXdiVTJ4N2lpdFlNS3IycDZkcVRsSTZYQWZIZ2hw?=
 =?utf-8?B?VzdhYUlHcEN0aDdhUVhzZUZERmF0S3hDN3JLWm02VEphclFORVY5LytCMDR3?=
 =?utf-8?B?MisxNmUvK0pBcDFNMXIyaDBPLzNzSm5POHovRFhjNWJ2bU1KQzNlb3ljZWZ4?=
 =?utf-8?B?YUtob09OZDRNR0VNSFBGazlsWE1VeWNuUTlocFg4SGc4dVgxa3Z5OXkzb2dz?=
 =?utf-8?B?ZTJqaVhaUEVJRlV1eEI4cnJCZDlWZ0h1RmhqNkZZUmtzTUFJNmgwZVVlQW15?=
 =?utf-8?B?dWlDL0tVandlVFlnVi9NdFNqQUpOMHhRVjdrT2l3N1FLdzI1UXZSS0xWM3lz?=
 =?utf-8?B?MnZ6cGNRVlpGQ3Nqa3NwV09udzJPSVJIcFd2Q1gyRGs1STg1WnZjRmVVT0NU?=
 =?utf-8?B?R3VBdm1ra1hwamVHVEVCZmlvUzdOa2ZqNVR5bW14VGVpclhrRERtcjZsaFNt?=
 =?utf-8?B?MDBhQUF4ai9BMlM3SlI5bGhHcWRSSFQ2a085N1l0VFhFR1g5Y1BoakpVaWxX?=
 =?utf-8?B?SWtHQjQvZVFLelVZVXYrOWdxRGRyR0FZZWw3cjc4RmlHNW90SnYvQkdKM041?=
 =?utf-8?B?YWF1M3RkdlRJOVRhbnFFQVFLMGovSEF1bnhQczRPODVSbHBNclV5MVhyUUVP?=
 =?utf-8?B?TGQwckNYdzhmUE9WdVVsaGp1QkFEdTNPOEdDNEtoMlRXeG1ZcEE3QjdQOGlO?=
 =?utf-8?B?NDB5Qi9PcHVQSllxVTg2dWVLb3hFdkxMcHZVaitrenlIaGtMd2oveG9QVGZi?=
 =?utf-8?B?WVVDd3VmNnZSTEdLSXFCT2dGbFpuNXRlRVlGRTZKQmlITjRIaXBlVE91VFpB?=
 =?utf-8?B?UjhxMVptYkk2MmcrOXZFVGxHbTFtR3N0bWxjVm1yaWVBVFh2bTBRWkg0NVdZ?=
 =?utf-8?B?RUFZYWp1dzYwSnpIZlA4RENDSC91dzNaNjEzYXBjUWVvV1R5cXlrVnZWc25z?=
 =?utf-8?B?VEpDZWFsWDhpYWRrbjZmbkxUTW16RExkNmh0LytGRkFPMEVuS2gyakZzVHRH?=
 =?utf-8?B?dXh1K252eXVTVVppS3JEY2NIR0t0cDVERGp4WWR6LzBqT25rYW1uVW9IVUhw?=
 =?utf-8?B?bEE3THd0NlRCMG52NXk2ZGtqWTNpSVd3b3hjVjhCT2I1NWJNbUdGRXJKTzBw?=
 =?utf-8?B?bFE0M0RwY1o0bHExWDV1TTRtc1U4M1lrTlN3NHo5UjB1cWg2cHhxZEhidmVQ?=
 =?utf-8?B?T1VwUHE3ZTVBcDB5aXk4RUxybTE1dFYyTFdRMkk4UHJRRTVnTkdIbmhuNStu?=
 =?utf-8?B?eTdXa1F2WUYvMzhHZ2FQTTZlcWprVFFJOXgvUmk4dVErTXMvRlFHRlRzbkNa?=
 =?utf-8?B?Qk1FUFVRaEk4SUh6ekVBTDBlWS9tSjFwSXl6eDFxeGY3VlFPS0hNM0VoZ2ZM?=
 =?utf-8?B?VEx6RXFIZnIrTGlsZ1lPdWc2MkdEemQ3ODFyYlhyeU03bkNncWxiNUNHT2dq?=
 =?utf-8?Q?F9SncWjZs94AEUWUuJdcPlk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49e8685-7953-4825-f810-08d9eaf40a37
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 11:13:31.6182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqB/fi47Alo+YmHdrs5crA4jxhuy+Yye6EUK99LDEy+0179KUze7+nC511s92E9BD75JR4I+DWoztOGDfY+SHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3430
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


Amar,
Apart from the long comment,there are a few more bugs in the patch, 
which I have mentioned here inline. Please check them out.

- Shashank

On 2/8/2022 9:18 AM, Christian König wrote:
> Am 08.02.22 um 09:16 schrieb Somalapuram Amaranath:
>> List of register to be populated for dump collection during the GPU 
>> reset.
>>
>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  3 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 60 +++++++++++++++++++++
>>   2 files changed, 63 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index b85b67a88a3d..78fa46f959c5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1097,6 +1097,9 @@ struct amdgpu_device {
>>       struct amdgpu_reset_control     *reset_cntl;
>>       uint32_t                        
>> ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>> +
>> +    /* reset dump register */
>> +    long            reset_dump_reg_list[128];
> 
> I don't have time for a full review, but using long here certainly makes 
> no sense.
> 
> long is either 32bit or 64bit depending on the CPU architecture.
> 
> Regards,
> Christian.
> 
>>   };
>>   static inline struct amdgpu_device *drm_to_adev(struct drm_device 
>> *ddev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 164d6a9e9fbb..dad268e8a81a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1609,6 +1609,64 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>               amdgpu_debugfs_sclk_set, "%llu\n");
>> +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>> +                char __user *buf, size_t size, loff_t *pos)
>> +{
>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>> *)file_inode(f)->i_private;
>> +    char *reg_offset;
>> +    int i, r, len;
>> +
>> +    reg_offset = kmalloc(2048, GFP_KERNEL);
>> +    memset(reg_offset,  0, 2048);
>> +    for (i = 0; adev->reset_dump_reg_list[i] != 0; i++)

This loop termination condition is incorrect, why are we running the 
loop until adev->reset_dump_reg_list[i] != 0 ?

What if I have 10 registers to dump, but my 4th register value is 0 ? It 
will break the loop at 4 and we will not get all values.

>> +        sprintf(reg_offset + strlen(reg_offset), "0x%lx ", 
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

Also, why are we doing a dynamic memory allocation for reg_offest ? We 
can simply use adev->reset_dump_reg_list[i] isnt't it ?

simply
for (i=0; i<num_of_regs;i++) {
	copy_to_user(buf, adev->reg_list[i], sizeof(uint64_t));
}

Or without even a loop, simply:
copy_to_user(buf, &adev->reg_list, num_regs * sizeof(uint64_t));

- Shashank

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

We are not allowing user to write into the list, so this whole function 
can just be a NOOP.

- Shashank

>> +    if (ret)
>> +        return -EFAULT;
>> +
>> +    while ((reg = strsep(&reg_offset, " ")) != NULL) {
>> +        ret  = kstrtol(reg, 16, &adev->reset_dump_reg_list[i]);
>> +        if (ret)
>> +            return -EINVAL;
>> +        i++;
>> +    }
>> +
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
>> @@ -1672,6 +1730,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>                   &amdgpu_debugfs_test_ib_fops);
>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>                   &amdgpu_debugfs_vm_info_fops);
>> +    debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>> root, adev,
>> +                &amdgpu_reset_dump_register_list);
>>       adev->debugfs_vbios_blob.data = adev->bios;
>>       adev->debugfs_vbios_blob.size = adev->bios_size;
> 
