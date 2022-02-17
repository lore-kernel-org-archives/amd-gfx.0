Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C13C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 15:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF93110E56E;
	Thu, 17 Feb 2022 15:32:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2D0110E56E
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 15:32:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNzeDZnvk5f5WMsZ+k4dY5AzmoN6EvlfAGreUj3jROnn5GGpAOWiGnVkDrgcitqR/T29/YUXb2OzhkrbyKiY+Fpjd0H7AFcsgecIwUE6w1MHbvlx+SC5nJG/wRlZdzN8pBxtyocVeFo+jJ8Bd8Q0JUbjMZ0G/0X82oivm234TKlZkrrgkxk0r0lj9Gn3ZCTmQMSKP8/n0T2NuuFpoeppb2eXlzDwlWn8W4c0rIZo7ADO+XJmwu9X25tboNsdHIB3g80gZxWve7UjAM7e/TRNTv5C/vbhd4aqKHoK+Dp+2XB9YUvQQSmplzxpnEUFED4fzlP1VJgcEAEYi2w6xTF3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vz2npzmw/A6WFTogS6gIGpwOg1OhpbM2uJA4Y7cRsY=;
 b=a3jYIt2RJA8dySSf9lfmfvsePIklfnlEfkpPbFK7ejOOYnaLvabZTroAwCaC/PIqeKqxTh0j94As0MZmkeQaBCKTECDtOjgNs72NGoWRbYLxLgHsaFLvsGa5kNfzanXdcPLWScR5OCmqaUV04EIf7q6iM19l0Fq+GtRvDppDTyEddVhqz84TenMWHLKU3wf9d1uvIp0IgBv0ILIC6jNPw35PL78apOwTvlZp+8CpzLBmDxF1xIb8iqjpjVB69Fxr5wCeZy4U9SdWrw/jBhN7ntMwAwl4SMykPedGneVUaiYBZ/b6OWBEARW7syZV4j+MOVudavQOZsQ/EMIKKGYEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vz2npzmw/A6WFTogS6gIGpwOg1OhpbM2uJA4Y7cRsY=;
 b=kSOyw2/bliJE8x3RGY4cD4hFFxJwCR0oQhwrBpL82L1GojAqsxC4eoefaNq+Lh4wBRP+fl0ZfoXhe9+0VG8JjleR9BKVeSOA9MhGpor43tAICdEQS3oDja/SBzJ5vX//hSSzSbRaVqUzTz82AFPwIh/LpTVP6dXRheBZnDTZw3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Thu, 17 Feb
 2022 15:32:37 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d%2]) with mapi id 15.20.4995.018; Thu, 17 Feb 2022
 15:32:37 +0000
Message-ID: <a60428c6-00a3-484a-c6c8-08959e91f889@amd.com>
Date: Thu, 17 Feb 2022 21:02:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220217142918.3624-1-Amaranath.Somalapuram@amd.com>
 <28251570-bd04-23ae-b199-e5e0f41db728@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <28251570-bd04-23ae-b199-e5e0f41db728@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0111.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::27)
 To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d0b20b7-0289-4b14-7f39-08d9f22ab9e5
X-MS-TrafficTypeDiagnostic: BYAPR12MB3205:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB32057A31D4A2DD50406E6F93F8369@BYAPR12MB3205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kHxKzG2MWIVsbm2gzbHitf5d3u5suE0fWsoFqaxLk+YBQloy7GLIcq5FJ5y9ttSjpt5BQ9UDT5luhCr8cXYUq1+OuQPqPDfiIfp7Yz5N9dJCnRY7B1OJUa4hcVkxJxsxpjmAGQ5VVxJfQ97PBLMX7XpXS4cAEtg3i1oV/RxdUp81GvJDbpbcywM8rg3Scmbtysy7daE/JBMX0+0Zd1lRtMXV4WiK4IDQz2jObrx3zyRI71K2JYvu1jsZI0ujvMmMaZQwXvV9TfRTgHd/WsQCYcdS3fU+/cd0ggK4evq0oSClS24XD7K2VxM1nz+HS5F9zfB6tr7MpUvTPEWlhWfmID6c5iLwbnqZJ/SXBCcjjicTEdh0dxYhOJm7j1uvmIuKwZ4eB/vfUO5mooF6IOGytJPYro1DMtJgbdYl/wcl3Jmx+a2UXFG9cDcIiTiPzOfYs7rUL1ncDa4RG4ADKeK3Qx/XKTQA8ez3OhGZVp6YA8ALSuJx0CPdoDtn3ORucWZ/UqCIhzY2KTXfgO8uUt4LYOe3qeTocu//eZ7JDSBc5lYt/20uHnyOlA2jTnbWFz4Q0eIUmxviGKdmVzsGVuJS2Rgq9Zx7mNEzPADXKA2fAzSBiwOUGCfH87sqQVlez8TKDerreK2ZLSqd2+R7UVdaenlN70ugW9bPU1PAP1pRnX+6y3x6yUvJvkc8z916rn8SclMr3uuAgWZzjwsIPv66ZVuSF42v66egWWZi8XEeoXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(186003)(53546011)(5660300002)(6506007)(6512007)(38100700002)(36756003)(2906002)(4326008)(8936002)(31696002)(8676002)(83380400001)(66476007)(66574015)(316002)(66556008)(2616005)(508600001)(66946007)(6486002)(31686004)(6666004)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFZYWmVYUUpWcGFXSjIyOWxlWmZWeDZScXpCSVV5YnZ2aGFpdmNoUWU5LzEz?=
 =?utf-8?B?ckFDUnFVQ3VyWS9GTnBLNGwzU2RnRzM1VW9GZTRpUlBLdXBHTFJuOTFxNmtT?=
 =?utf-8?B?Lzd1TDNQUS9nZm9oYldpSmRHK3ZQMHIyeVdSQXRHMG5TeVBFazdDMDhpejFY?=
 =?utf-8?B?dFNoVFVDeXJoa3JsVDV0b1VXYVY4YkZ5TUVkYVNidmFONUdleFg2ZVhGaElP?=
 =?utf-8?B?MUlEK2dQd3cxcFhhWi9ib2RRR0krYVNvdVhjQk9rd1lsNnNBOVU1QVhXZkZ3?=
 =?utf-8?B?eHhXMHlXYzRzNGo2VmpWWDBBNXNWWGxyRkxrK015Y2g5Wk1qZE9VeXVWVW5F?=
 =?utf-8?B?dmNYVzA3ZFN2a2lTUXdNbEUwVytWRnhpa1VUVkxSSkt4WXBUMy92TTdmbm04?=
 =?utf-8?B?dHlOeGNzMDNRV0hNYXU1RmhOOGNKalRKZ3dFcWRZTXgxR0hMWURJaU82b1RH?=
 =?utf-8?B?azdhZHBKWS9yR2JrUTFPWEcvM1lvUHVFQ0w1YTdsQWxDMnV3NlNULzQwL3Fs?=
 =?utf-8?B?UE1sOGNFcERrRzlqc1R1Q0RKaHdCb2hMZUh1dnhNdTlzZ2xNb0JMQ2hSUzNJ?=
 =?utf-8?B?aXdZSHpKY0NYdWQ1cWswbnZRczdiblVYVEtnbVNtV2JOemVZYittdVBBYk9R?=
 =?utf-8?B?WDMxNmhOc2E5STB3QWNSWTZhWk1kOVZWSGRLS281cnVnWE91SlNjQThsR0d3?=
 =?utf-8?B?aGdFSUh6R2FWcDR0dXhQU0czRVhNT2ZaV1RTV1lqRnA0V0tQTUZ4djZHd2N2?=
 =?utf-8?B?OGhjNm0vL3kvNllZQkdkNVJyTE10aE5mcWtFWWtsM0NJSVFvR2dpVVNjR09n?=
 =?utf-8?B?NzdDRWJ6M0FBaDhSRXk3eGZCanR1NTlXR1E0TW1kckJXZENSdlVDWTJCTHZQ?=
 =?utf-8?B?VEpPT2N0aDh0S0xOUDQ0aGNxWFZPM3FndGVFR1I3dWZDT25jQ2tBMldPbFFC?=
 =?utf-8?B?OEg2WERVeTMwb205OTRkRytVNkc4cGYwTVFybS93S1BTQ3NOVzZJMzRyeHdQ?=
 =?utf-8?B?YVNWNzQzazJBYytwTXh2REIyZWlxdGtqVXBFc3ZXMEpoNFMzdFU2MFhua1VF?=
 =?utf-8?B?U2grcEUvL1dJZzlxL0h6bm9FRVAwWmVvd1pjWDIyQ0hQWEdPOVEweDJsQldY?=
 =?utf-8?B?VUNBUE0rLzNtcDRQRkpWVGt6TjZVRDhqdk5tQmVtQkppOWt6SWMrV0kxQTJT?=
 =?utf-8?B?Vjk4NHFicTY4SUVFbjZzR2lRRGhQN2hjOFlMTGoyZmd1MlJzVm1tSFJ0QnlO?=
 =?utf-8?B?aVRGNjBKbXNIRGs5QnV6MFRqTTgyOGhPWldZTTBodlN4bFZxSGdnaG5mUHJY?=
 =?utf-8?B?SGJIUTltWktOVjA0ZVVlK0F3ajdOM0F3MU1GVVhBcmllTDg0NVZ5Z1hzZE14?=
 =?utf-8?B?bzBnVjZTSGlJMXd0THpXaUF0T3VJbWwxWWhVMWVjMGZ6Zm5nKzNKbTBtOFdZ?=
 =?utf-8?B?WDgrN21YVFNDTStjUzdjdnBTZDFGWmhJSE04TGkvSmgzbXdkeDlJSTJ6ZSsy?=
 =?utf-8?B?ZXYxMUpqczY0YnZyb0dXbzJrMjVJVDdGbEQ0c2RTbXpDMVhaYUNKc0VyMmN5?=
 =?utf-8?B?VUllcVFiZVJRUmpmeVR2ZkM0dGZicVBiRnB0eHMvUVlicmdTMG9TWXpOQk40?=
 =?utf-8?B?c2R0SDFtaHZmTlFxcnRUS1gzRDVjUEUxMGV2NjJiOC81ckNadkoxVm9IVlIz?=
 =?utf-8?B?S1NhVHhxL01xWFhxWS90UVFUR0NoQi80eFNIME93SE5MSHQxSjFXMnlCRm9I?=
 =?utf-8?B?MlJmdkRtTVBMbHZDdnZmK3VaRjZnTkJwVUJZekUybGdNVGRoUmdpcjNPQk9s?=
 =?utf-8?B?QzRmY2E5K3FsblpnZmN2ekVYQ3Q5djJJUGRJblZCZkJid0VmVjFoTE9VbTA2?=
 =?utf-8?B?eU1YN0kvVmZLNHZOeFN3S1N6OVlERWdtVlFqUzFkV1ByUDhUT1pJQmlOTXh2?=
 =?utf-8?B?VDEvM2Z2Z0dZQm9pSmIwS1lVeTNuVlVOU3ZiRzJZV0Z5UlpnOGI0M0hTMmxq?=
 =?utf-8?B?ZUpKQXFzUHgvTVNwWm9IVitYeUtlbFgxZWJQYWtPcmZWTUpJZTNrZmUwZVhE?=
 =?utf-8?B?MlpKbml0RGVEcWppNjEySDhOUlo0TGZMNE1LcWdmanNoU3Q1OU0yS0xoTk5Y?=
 =?utf-8?B?UUdLTXQxZ2hDNGtna2w0cDZ4Ty90UitwTTBDYnRZQldzdzRpQzQ4K2FHcmky?=
 =?utf-8?Q?K+A4tmxMYDoY9Zpf/A7nGao=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0b20b7-0289-4b14-7f39-08d9f22ab9e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 15:32:37.4759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRtlXzb4Gev9pV6AFGN6Ibatxz0zHOmDeFl4/pF12rH3H4KgYNJO27sER1aoagYu4BsGzNgSN+0bmEs9VbAg6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3205
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


On 2/17/2022 8:36 PM, Christian König wrote:
> Am 17.02.22 um 15:29 schrieb Somalapuram Amaranath:
>> List of register populated for dump collection during the GPU reset.
>>
>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   4 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 112 ++++++++++++++++++++
>>   2 files changed, 116 insertions(+)
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
>> index 164d6a9e9fbb..ad807350d13e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1609,6 +1609,116 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
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
>
> Using the _killable() variant is a really good idea here.
>
>> +
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (adev->num_regs == 0)
>> +        return 0;
>> +
>> +    for (i = 0; i < adev->num_regs; i++) {
>> +        sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
>> +        ret = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
>
> Uff, I'm not 100% sure if we can do copy_to_user without dropping the 
> lock.
>
then I need to use kmalloc or krealloc_array.

Regards,

S.Amarnath

>> +
>> +        if (ret)
>> +            return -EFAULT;
>
> But returning here without dropping the lock is certainly incorrect.
>
>> +
>> +        len += strlen(reg_offset);
>> +    }
>> +
>> +    up_read(&adev->reset_sem);
>> +
>> +    ret = copy_to_user(buf + len, "\n", 1);
>> +
>> +    if (ret)
>> +        return -EFAULT;
>> +
>> +    len++;
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
>> +    char *reg_offset, *reg, reg_temp[11];
>> +    uint32_t reg_list[128];
>> +    int ret, i = 0, len = 0;
>> +
>> +    do {
>> +        reg_offset = reg_temp;
>> +        memset(reg_offset,  0, 11);
>> +        ret = copy_from_user(reg_offset, buf + len, min(11, 
>> ((int)size-len)));
>> +
>> +        if (ret)
>> +            return -EFAULT;
>> +
>> +        if (strncmp(reg_offset, "clear", 5) == 0) {
>
> Please completely drop the idea with the clear here, that should be 
> unnecessary.
>
>> +
>> +            ret = down_read_killable(&adev->reset_sem);
>> +
>> +            if (ret)
>> +                return ret;
>> +
>> +            kfree(adev->reset_dump_reg_list);
>> +            adev->reset_dump_reg_list = NULL;
>> +            adev->num_regs = 0;
>> +
>> +            up_read(&adev->reset_sem);
>> +
>> +            return size;
>> +        }
>> +
>> +        reg = strsep(&reg_offset, " ");
>> +        ret = kstrtouint(reg, 16, &reg_list[i]);
>> +
>> +        if (ret)
>> +            return -EFAULT;
>> +
>> +        len += strlen(reg) + 1;
>> +        i++;
>> +
>> +    } while (len < size);
>> +
>> +    adev->reset_dump_reg_list = 
>> krealloc_array(adev->reset_dump_reg_list,
>> +                        i, sizeof(uint32_t), GFP_KERNEL);
>
> Well that still doesn't looks like what we need.
>
> Here is once more the roughly what the code should do:
>
> unsigned int i;
> uint32_t *tmp;
>
> i = 0;
> do {
>     tmp = krealloc_array(tmp, i, sizeof(uint32_t), GFP_KERNEL);
>     copy_from_user().....
>     i++;
> } while (len < size);
>
> down_write_killable();
> ...
>
> swap(adev->reset_dump_reg_list, tmp);
> adev->num_regs = i;
> up_write();
>
> Regards,
> Christian.
>
>> +
>> +    ret = down_read_killable(&adev->reset_sem);
>> +
>> +    if (ret)
>> +        return ret;
>> +
>> +    adev->num_regs = i;
>> +    memcpy(adev->reset_dump_reg_list, reg_list,
>> +            sizeof(uint32_t) * adev->num_regs);
>> +
>> +    up_read(&adev->reset_sem);
>> +
>> +    return size;
>> +}
>> +
>> +
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
>> @@ -1672,6 +1782,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
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
