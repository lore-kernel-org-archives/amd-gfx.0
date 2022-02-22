Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF833C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 15:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E79610E805;
	Tue, 22 Feb 2022 15:45:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5A6610E805
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 15:45:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO/84GSWOlL8r1elSJ4nsLKHqjxxWaOMUQMwZsJha8yAYLfWvzVhmdjWUXWIV4y3NOS7HBYWyRHxIof1wGSCSWCEZywNlRQWm6X4gWsH+XIWA4aCaaHX8+xMxb9JAFUlttMqPyHDHd5R0n44wuIxp3WIJHgDlxbENlUV7ls0xKMvVv9s06rU9LfS9iJncSoEaAE1WtQ+lUeD67BV+yPbj6iXH/JEOhTMdqKWO3Wd7FqRVLTVpYu+OsecMRICvNBgMln/F+PUmmrWpP9ij+IKsHkMtYZ2WMQwT4MjE3urvqJFsJQZ3XfgeStmYTGuF5CESsYYtQmSex0jJbwri40+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPHyj1TjucvwmAeQwWk0QWrjDO1XF0D81f5HDNWBeG8=;
 b=MoI7KGPq9/MTP5/FS/yItUxVpi+mLjGl5QuVZfh1KB7kPiRq7Kxr0Nuh90+pU5pv2oz/b3JJnpoYonSrbE4suDtc2fY48IRui5bPthLslrneR4Yb+P52+MgVNY7kTILFOws8nyJW5SkPBowyQvsxjwcT1+JNE7fwCmdsnL8RYth8bEtipggYs1Q7W0P9w93VZ6e+XHQPnzPYxIpOD+dnh1HkqO8ajIgRYeNFKym15wB/3u8/i3Gn0bluq8p8t4xYTpmkoNnDMAsLm7jF5BH8HnZjjzlbl2VJf7DCozv+h76xwmOG9CJzYs6JeGMVf8X1oGQxYXbKN2aPCDqGrJML1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPHyj1TjucvwmAeQwWk0QWrjDO1XF0D81f5HDNWBeG8=;
 b=K4BtGjh5r4qk2/G0NRQfE1ll1KzB+r7D3NWHbZw06vvkuTfWR/nFMilnw04tD7NU6s9NP5lkpsbCRCCQxz7NIqcBXmc7zZevzYpq0Oy7VuBGIY9TMzvTogrbMrIjP4oLmcZS0ejmbkViVIhszGe6HiapqDEUd4Hupy1y7rai+hM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3892.namprd12.prod.outlook.com (2603:10b6:a03:1a2::11)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Tue, 22 Feb
 2022 15:44:38 +0000
Received: from BY5PR12MB3892.namprd12.prod.outlook.com
 ([fe80::5c63:88eb:f0d7:c523]) by BY5PR12MB3892.namprd12.prod.outlook.com
 ([fe80::5c63:88eb:f0d7:c523%6]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 15:44:38 +0000
Message-ID: <5b01bf2b-4a3e-5985-3d3e-3f3d589ff694@amd.com>
Date: Tue, 22 Feb 2022 21:14:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v12 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220222153433.11464-1-Amaranath.Somalapuram@amd.com>
 <4fbd2956-c3f1-182d-fa4d-84206771bb30@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <4fbd2956-c3f1-182d-fa4d-84206771bb30@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::20) To BY5PR12MB3892.namprd12.prod.outlook.com
 (2603:10b6:a03:1a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4570e58-70d4-4042-6381-08d9f61a3ba2
X-MS-TrafficTypeDiagnostic: DM4PR12MB5987:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB59876C11ACB15599655B92A1F83B9@DM4PR12MB5987.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xAe4uWkLZQ1EL6WEMJQuZ5UUw7GffQWzfEzMjPo48sj05ZToFguzXVdvcBuAj0W8pDwpK9MPIoVoE7oMfvNeNc6HX/sM5oQbpwBvXAOX6jsgzuWWVBs3gJGJjSf+GWZHoFzvhapPXZzOsxqoqByCZ1O8Q++/SDB6IC5M4lwVOoGGN04c958jeEfXDHyGGdgBUGA5BTkd5Id08c7D5PH2XEsOidYHuj41RMvuMvKNzW2SRKMVMSFKdmfsUfF7gMyII7ru4fUlsWLxew5Wm/K5FFQ8ozrkHyWZ68PG90jwWOAgL+zDnrAlIW3PIhps181pIFI58WifpijTiaWGjxMqLIEQrW1XhTskwxEFlw739+f7gnvLOwfYlrRvPfM+k42VmgFLlhnP+zR79lHjEmT7j0OOFSft5rKmpcP4sShJhOzErCa/TbmHMx3m2yHsiBcoURvYVA0ezDvWIt406ro/ICwfuXy/0tdjysGxL29SAVE213i/cfvb34kdW9e7dcuOuEUWiWDM6reAoMl2fqtXKoNL+/gPjAyztv9sYeU3MO9OBS0dbCnmklAjGI41vH96x5JtgjLGYynjcnO4H/pNhysl9oN/3Gr3S7hSRY2Jmb4RtyTjQ9obJoxV/Rytpzkk0bwmk8ggfLRqpCzHOhfTHvFyb/tQYwrYmd6W2dtLJtMUwOEvDym/wtMR+mAq7NuayGUG1IFNJBTTtpJifWc8HHlKiMA/bI7nTxm9sgt7P3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3892.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(508600001)(31696002)(5660300002)(8936002)(8676002)(6512007)(6666004)(6506007)(4326008)(26005)(186003)(2616005)(53546011)(66476007)(66556008)(31686004)(316002)(110136005)(36756003)(2906002)(6486002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmVLZUtCYU5OVGlrZCtvWkQxOHBmR2t5M0NRZ3Q4SjJaNlVIUTJ6d2NmQTc1?=
 =?utf-8?B?cFd2R2xyWi82RWo2M1pqUXNsWnB0OWlhbVBXOFliY1RtWERoT2R4cTZzNi9N?=
 =?utf-8?B?eEhkQzVpMG9zR0RQMWx1ckRCUUxVaSs3d05JdEppTi95ZU1xbVBNM1hnYlZK?=
 =?utf-8?B?NGx4UmhFUWJwRWdSYVViVDNkOGtmREt4cEl4WEtmU2hBbFdXc1BSb3BGeHEv?=
 =?utf-8?B?WnF2VklLZlNOYTZvWC9YMUtKeWZrekxiWk5yU1QyVUlOM0VidUNIcXlUaCtX?=
 =?utf-8?B?NVkvUTNNcytQYjhZdmF2UTMwNkQ1M3BhTG9odHRydWdsUS9ndEYwM0NSeEVy?=
 =?utf-8?B?YVd5NnIyb3EyR2g0bTdDVEZLMGIrWTl2Y0VLbFB1TVZld2U0aFB6YTZHbjI0?=
 =?utf-8?B?UVlzbEdBaHZFNmsxTnRwWjZ5OGllVkNaaUhPbko3Vmg3dHQvUzdBZjd1UnNi?=
 =?utf-8?B?UVJKbUpCdG9RU0JJbHdNdGdNQmJFR1ZyMXp3WFhRRk1GQ0N6dlFmOUF6WWtr?=
 =?utf-8?B?SE4rVmtERzgwNDRJa2xFSk5yVFRiVXlUUVFQbmhlam5lTjVoT3JpYzVFM3pK?=
 =?utf-8?B?Qys4VmFvVnFiY2pKOUZRRnU2aTBWZkxaZS8yQ1JCU2ZDRGpITVdLUEFEanBF?=
 =?utf-8?B?NlpqTVYxa3dpbUN4MDVoTXJlcnZ1aVZiYXVIa05mVnZ5UEUzTU8xaHBFVDd0?=
 =?utf-8?B?MExGQzVUZGYrMUlJS1NCWjU2ekRIenh6UjI5Q2lsVzBHRVJSbnN0ei9LMkti?=
 =?utf-8?B?NDJvdTJrQ3ZJYVFsVkw4cDJyUTZncExYdlJJVVo2a2JEK2k1RnRPTEVJRDR0?=
 =?utf-8?B?SzliRDJZZTFqb0Y1bXBSbkNXVDdCQVBTTkREUVVWQnFVdDh0bUlyYkUxUmty?=
 =?utf-8?B?eHZENVJiT1QvOHI1SjkrYzNJSk1xN3lETE0zZHFqUEpESHhQKzhkVGp0S3Rj?=
 =?utf-8?B?d0dvcjhjOVk1R2lERjBNS28rdENjS1dCTkptWDNtSWxpbWZxM09admdTNTFZ?=
 =?utf-8?B?R3NScWRjeDNONEVsYlpiVHNhWXk1RzQ0RGU5SGFMOG5RSUl5K0RTSkNTWHp1?=
 =?utf-8?B?YTFWMzI5ZlB3NWpRdHhZZUcvSHZIVTBrekVicTMvUlY1U2hTZ3pDYkxKa1d1?=
 =?utf-8?B?QjNndXovTG91K0NKVGJUUHlvUnpJWHNscFRna2FzRUdaUDY3ZVpRT1BkSlFL?=
 =?utf-8?B?czVVRUJsQlorUVN4bnFJdHcwMCtKSGxKd3RYMW9aRzQ1MUxNZjlTQWVNSVhN?=
 =?utf-8?B?eWpyb3pjVEtuR0l6VE1JQW42eE1nQm5lR0VDVFZ1NHFHT1NkWXhvMGVuVUZu?=
 =?utf-8?B?U09DcWc4ZzdFS0NvTHRWL2hYVy92YjU5ZXRwRXRrMVhtSVgrM0tGUU1uMDN2?=
 =?utf-8?B?VnJCTmdxb3JPT3VtNXBzZ21VdGp1TjJiWFZPZW9PK2pUbjBKNUVMZGFuUDRn?=
 =?utf-8?B?UTBBYnEyR3lhTXhVOG43RmFyVEJKVGQ4YzhNL0h5aFB6RktlcFRtdlZaT3Qy?=
 =?utf-8?B?ZVI0N0pVOWpaZExVUkIvR1VZYzBwYTlPUmlsSVJydjhSa3lWNkpVWFpVbFpF?=
 =?utf-8?B?czhkOWM2RGQ1cWEwS2l2bFFOMjc2K2RoU0IzWjlmZlliK05YN2l5TEw1UDJW?=
 =?utf-8?B?akhFTnova2ZiU2J2Q0ZpRXlRU2pYTWxCU3E4RUZFdjlkcDdXRHNKa1c3dG1X?=
 =?utf-8?B?cmZ0anNMcFBqR2UvQmRJeHpLcVhkcjMvcGM3UkF6TUVESFoyM2E3TkNmaTE3?=
 =?utf-8?B?Q2p3NVV5dThsOXY1dFJ2MUMvWndTeEUyZTRPQUs2aG13UlJtc0hTVFB3M2tG?=
 =?utf-8?B?Nlc1UmxPN0I4ZEtUa2dhT3hHcmEydU9iWG54c3o2aDliRGhDK1NJL2hUQ3V0?=
 =?utf-8?B?TUpQOGpiWmlXYjNpQXIxS1ZDYlZXaWVqZTlPcDVpMU9WMG1kQXdGNFF2OWhw?=
 =?utf-8?B?ZVc4SWxRN1laSWhkT0E0ZXlWeTlHdzV0aXljdTBtc3QxRlFVQ1NPM0oxUlpX?=
 =?utf-8?B?UC9Yc08zTW9xWDgwYS9wWFpkVXJRajNsOTVoZmIyYVBUUU9SdmtjV01wZkNj?=
 =?utf-8?B?djgxTmM5MFYyN2hCMGdHSTRITUMvR3UwSUxoaXV3ZUg2YnBtZHVac1pJSDNO?=
 =?utf-8?B?U0NQTkdpQmNLd2JsdDNSbDhUQVljaDBCdEVIQnlkM1N2RnREUlE3aE9GT0F3?=
 =?utf-8?Q?ERBxn0VdkopdEDAiYxDQlR0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4570e58-70d4-4042-6381-08d9f61a3ba2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3892.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 15:44:38.3466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hP/W2R6i3bzjvKhv9fg1DT9NQbBZsGvo52xpjMhQP2WK5TZSp6cXnrz9Ifx4w6NAxtBTWwffQmDj00lJmDrEMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987
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


On 2/22/2022 9:08 PM, Christian König wrote:
> Am 22.02.22 um 16:34 schrieb Somalapuram Amaranath:
>> List of register populated for dump collection during the GPU reset.
>>
>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 83 +++++++++++++++++++++
>>   2 files changed, 87 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index b85b67a88a3d..6e35f2c4c869 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1097,6 +1097,10 @@ struct amdgpu_device {
>>         struct amdgpu_reset_control     *reset_cntl;
>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>> +
>> +    /* reset dump register */
>> +    uint32_t            *reset_dump_reg_list;
>> +    int                             num_regs;
>>   };
>>     static inline struct amdgpu_device *drm_to_adev(struct drm_device 
>> *ddev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 164d6a9e9fbb..0cc80aa1b5ec 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1609,6 +1609,87 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>> +                char __user *buf, size_t size, loff_t *pos)
>> +{
>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>> *)file_inode(f)->i_private;
>> +    char reg_offset[11];
>> +    int i, ret, len = 0;
>> +
>> +    if (*pos)
>> +        return 0;
>> +
>> +    ret = down_read_killable(&adev->reset_sem);
>> +    if (ret)
>> +        return ret;
>> +
>> +    for (i = 0; i < adev->num_regs; i++) {
>> +        sprintf(reg_offset, "0x%x\n", adev->reset_dump_reg_list[i]);
>> +        up_read(&adev->reset_sem);
>> +        ret = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
>> +        if (ret)
>> +            return -EFAULT;
>> +
>> +        len += strlen(reg_offset);
>> +        ret = down_read_killable(&adev->reset_sem);
>> +        if (ret)
>> +            return ret;
>> +    }
>> +
>> +    up_read(&adev->reset_sem);
>> +    if (ret)
>> +        return ret;
>
> That if and return now looks superfluous.
>
>> +
>> +    *pos += len;
>> +
>> +    return len;
>> +}
>> +
>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>> +            const char __user *buf, size_t size, loff_t *pos)
>> +{
>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>> *)file_inode(f)->i_private;
>> +    char reg_offset[12];
>> +    uint32_t *tmp;
>> +    int ret, i = 0, len = 0;
>> +
>> +    do {
>> +        memset(reg_offset, 0, 12);
>> +        if (copy_from_user(reg_offset, buf + len,
>> +                    min(11, ((int)size-len)))) {
>> +            ret = -EFAULT;
>> +            goto error_free;
>> +        }
>> +
>> +        tmp = krealloc_array(tmp, i + 1, sizeof(uint32_t), GFP_KERNEL);
>> +        if (sscanf(reg_offset, "%X %n", &tmp[i], &ret) != 1)
>
> Does this also work when we write the registers separated with 
> newlines into the debugfs file?
Yes. tested with with both.
>
> Regards,
> Christian.
>
>> +            goto error_free;
>> +
>> +        len += ret;
>> +        i++;
>> +    } while (len < size);
>> +
>> +    ret = down_write_killable(&adev->reset_sem);
>> +    if (ret)
>> +        goto error_free;
>> +
>> +    swap(adev->reset_dump_reg_list, tmp);
>> +    adev->num_regs = i;
>> +    up_write(&adev->reset_sem);
>> +    ret = size;
>> +
>> +error_free:
>> +    kfree(tmp);
>> +    return ret;
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
>> @@ -1672,6 +1753,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
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
