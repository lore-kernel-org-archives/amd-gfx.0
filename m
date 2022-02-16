Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA503C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 13:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E67410E289;
	Wed, 16 Feb 2022 13:55:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1CD310E289
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 13:55:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QX/CZJlpdtIfaX9tiK81r8F/kyUN+cFXWlFhgp7ar66QXE2bR5XuF4svqU9spgM2OGD0AINktyviDx4XHrN7JchFqNYQShf7HwQm9NXYaorf4BYCE3YmpmjFH7lEJqDOknfAU2hlUqddzmbD1c/jI93rvW8huJ0Op8nDvkoEvPCc104/huJ8Kgz0GUtFvdWSCR8w4kSDTH/2rDwYkF+fWgTFM9dSb97D2IL3nlQuNv/2H7UIf3bpIS7AzhndedqUsO3wMzyTDEbaxjr0We2VTR+UFeTJR2IOk6fQGtrozgjkpTD7IcbECVt2DOsAAJukOoZ42vMykKHQxzhKiaco4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzgVBjXqzsEvxXy5KSbXB08bQJ3JYVwCCc1hw2fSrE0=;
 b=Wk8KuJ2GpiwiTPVNakOt9d0/ruFzBuv2fUAfKGed/p2heAuODN8/FfuQ5x+7KiAXmHiBr2Drbgs9CdQ/4QkUXDSKy6ymo7KfRAjuCPjH+cv5zhnNWPkXQctJa2eWd2bbTmjtoI/hfv2aeKzZKfKcQ9k2SNjUpE/cIqUqC8iZfuexdcjTJPHq+wEu4CBHJBloyL9Mi18RkH8sG1nQK5CLV/r04G2uDGyKAkvbbBGrtVXRxq58X4/HqYWs+HPDidFcie6HxaAl4qMlHxNDAuQUiYBUoxddIezCEjgmWPAAFOSrxAQH1O6i2ctFu3CxnhsZKk2ik/Hke0ZhfDNb+ai6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzgVBjXqzsEvxXy5KSbXB08bQJ3JYVwCCc1hw2fSrE0=;
 b=x4WkzVRJN/wBb8/vlhlAwFw8jzkXYaXHrq4prBg5NpGpbMJcTBTsH0o+PePIRPNM33WG0gEAp05GwOtfndtuFP4y4ChRpqKrT5t4K/Q04uAZrUz9AWUm8fXvefbCaZ3X0ocwn/pDgF4ZdIijM4P+wF1h3Q3jUrt9M0wkG8XHf6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by BYAPR12MB3591.namprd12.prod.outlook.com (2603:10b6:a03:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Wed, 16 Feb
 2022 13:55:19 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d%2]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 13:55:18 +0000
Message-ID: <ab2c3bcb-4b2d-7372-7bc9-7362f12aeef2@amd.com>
Date: Wed, 16 Feb 2022 19:25:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
 <fa563eb7-a0df-cbda-004c-23b10e882a6b@amd.com>
 <392e1b15-8bbc-91cf-ab86-9d28aa0b716e@amd.com>
 <1021c2e4-22bb-1e94-1a91-c4d7cd915b49@amd.com>
 <9c3942f5-aaa2-da81-962a-a010bb093002@amd.com>
 <2577088d-a863-f5ed-8b8d-2060b7286a3a@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <2577088d-a863-f5ed-8b8d-2060b7286a3a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR0101CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::23) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5099a25d-3229-4a42-d648-08d9f153f76b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3591:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3591197271BD9050CC29691FF8359@BYAPR12MB3591.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5i0S4W2BplOHrprjmOr0j+H4tdAQJXH6NnAO6XlF9CR6ugnJIwCWD2j8M2SK+bQeziFPdHUUnWNC6q7kwZgOfm8A8pMO0OSJDYyYBMJueRIz7Yf/73qw3IPEKrpBcugbRmuoKkxsTvmRcyV7RGzAJHjc9ourulNWzPdVn1LFDBFsKL1EYxCM0zCrngI8DRsybW3MSsRrKCTHjNlPHZ8ZPXRfQYbAYmHwKQkGgfw3ZCt+BUH9cGzUQc8fTg888nopf77jHP5httAruS2wk1A+UQqP9PuzBpwmJFhoJo75Zd8fsajKVwCSkEiKcfTNgJLTcytnEfkZv1Ksc0t0SW1jWyS2n7NIzcY2oP3ywEWjrik41HvebQaeY5OX7X4oIkQLxX8CXrnbRiOd4x5qQ3pGEJybMxuEP68MbuMjSX8CK86jvg4vxTApGJ8cuReV0XJCPkWcF/oOHepLoM/XdEmsWAjrDLj2oqCLBDcX+V/ddL9A1uF0zuWPFXIOBIUXAwQWBfZZv98U0m2iF3QjW6GzzzZzFzfIno1XLvcN58DMtayB2brg7PAY0uhgunX5R+/AezN9yI0e1OR9DXX1n2DcJCxZLgMFhWvnSkh+wLenRS/c+JFWmevnmBI2FoXlbkZ/ItnECU1F8kND/ylotbq3YqauoKtkYXe5HDAgE690S+0gqqE68y68VZdOin8i/SUb3H/9MOTcfGWcyPo6vwu0+zBGLHYpfbAraT5sJfjCo0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(6666004)(2906002)(186003)(316002)(8676002)(5660300002)(66556008)(4326008)(83380400001)(53546011)(508600001)(6486002)(26005)(66946007)(38100700002)(6512007)(31686004)(31696002)(36756003)(8936002)(110136005)(6506007)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmdOMnEzaE5hd1J2WW10QTE5d2VoSFpLMUduWTI5dEFnNkxjQjFLa0FrTmhv?=
 =?utf-8?B?c2Q3OFArQURpQmpRZGo3QW4rOVIzR0JlanZtYkIzbFQrU093SUpqc3NmZ2o5?=
 =?utf-8?B?WFlGUFdPaGt1L0ZqZ1FsaUt4KzA0WHczVTIza29KeTVuMlRqVFNralAwQ3Js?=
 =?utf-8?B?dmdqRlVjOFR6RVloc2Q1TG1zYXE5M3NOaHphbmFXM0twZWhBYzB3ZHMxVTRa?=
 =?utf-8?B?aFFFZDNnbDlyd05USUpXTUZnMnpWL0Q3WnllQlVqQU01bjg0WTlFUDZHVGNE?=
 =?utf-8?B?V1dGdkRUclg4TTVIR3hLS1Q0RFRVblNOOUVwVDR4U1d2MHFnWEhLNkhOTWIy?=
 =?utf-8?B?VmJrS1RObGdnNllDTHAyUktRN1docldvcVN5SHRsV0RKNlBZS09sVlNtOGRK?=
 =?utf-8?B?VFFvemJoUWVPdm5KTDdPSC90L3dGY1BhTlV5NWlacjVtRTQ3VkZBME9Fbmk0?=
 =?utf-8?B?dHpyYzVMZVhCZ1Z1N0dMVU1XS3ErSTVsRnJiZG1YL3I0bXdtajZnSFVpQ0ht?=
 =?utf-8?B?QmtkYWhQbU1Rb3ZqUFFiY1pKa3pCSE9JN2FrZ2Z4NEF1MjlwVVBoREpjQ1Bj?=
 =?utf-8?B?NGxLZjYxNzVxN3hpYmhkYnlFS3MwM3NwNzF1T2YzQU9DYWxPWDh5MTlmTU84?=
 =?utf-8?B?TjFVTU13aXhGdVBOaG1wakprUlk4NlZwbUdEZWptRFhraE44ODZYM0orV1h4?=
 =?utf-8?B?NGRScjIyWFl5ZXQwa3VVQWJFVVgzM1hPUmxac08vdUtsTkU0RzhIUURiY0k3?=
 =?utf-8?B?aHdaSlQ3czhXbFVZNWY1RWIvMkh4RFRReTkxMklYS0FmYW9tU3BKQ1BCM2Z6?=
 =?utf-8?B?aHVHa3FBM1pGTWFrLzZpQjNOUEJwb1pycUdCUHBjc25QTHN4eENpZkhxOEtG?=
 =?utf-8?B?ditGTHNjeWRvZkVnYmltUjlUODlDSU5sQ3UrYTNPTzZJM3RYZS9Qbmx5c3h5?=
 =?utf-8?B?d0hTQmhQZ2tCQ2hOV2lleElGb2JodCs5Qk8wZkt0RUorL3RtTE85enEyekFx?=
 =?utf-8?B?cEpBS2wzRHNQMmtOR0JjM29nS3V2bkZQRDlWWitVWnRrU21wV1lBUlpRTEFH?=
 =?utf-8?B?QmpBYkxFYmViK1Z2WnZ4em9jTERBbGtwZmc3b2VGVElpY0tGbHdPazU1S2V0?=
 =?utf-8?B?ZXRDM3pudGQzRzh3dzNmdHV4N0Vhb1l2dW44Q0VZUzVCVkIyZzJOUUNNN243?=
 =?utf-8?B?WUx6YjFCQWRkSk9PQ0xtVDk2RmVabjIvK2pwQ0E1YnVEWGVaQVlpZ2l1VlBq?=
 =?utf-8?B?ckZ2TU9wY1kxNjEwL2lDTW9mL0wxalJZQVdmallySTZlUTVyN0dJZEl6bTho?=
 =?utf-8?B?L05mMTR2STE4aGZXUmt0ZnlRazc4SUVZN1ZqK20wY0JOS1Bua1EyVnZYOGhS?=
 =?utf-8?B?Uk1vaG5Mamc1c2NDSnJoZytJSUVBSlhrODZQdHdOUk5mUXA3ZCtRR3E1YUlI?=
 =?utf-8?B?aHh6NVZkMVlYUHU3c3JpdDh1SjV2MUdNL2JRVkQ0UjZzS0dBc1NCamxjZUli?=
 =?utf-8?B?VEE2Y0l6Y3pnNlhmeG1FZmk1WHNOUW1hWVZzcnJJZVVEcXJZMEljN2RVZjEw?=
 =?utf-8?B?RGQrS2RpallFemcwSmFscnZNMlhHNzh4a29OdThxREVsUXFuQXJSQTZVZTJh?=
 =?utf-8?B?Nm9IMGY0YzlwejkrZWUvOUxRd2I0TE1NdU1ZYlpITXA5RGtrdW01VHhQRnNz?=
 =?utf-8?B?NUQxcGJPM2NRd3VYcEh3RTlJTzhtdDBZTXRFSUlKYzBYM0hMUFlxK2ZVYTQr?=
 =?utf-8?B?czhGQlRCS2ZRRGowY3RHVytpMkdCc1ZyMlhWc3R0b0orZFFRSlJ2WnUvcmpN?=
 =?utf-8?B?K0w3dVh1eUxPVkplR0NwWDN1N2pwWFhxSDZPZnpuN2NHc1JEYVl4dXgyVnFO?=
 =?utf-8?B?Qnh2enExMmoyR0pHcks1cVBIamxPWDluT3EyUTVWeHRrYkhGbFJwdmh6Rm1F?=
 =?utf-8?B?T1Rwa1N5WHVQU3pMZENUZXM3UHdqRkIxbTZZc01hZzh3K2l2M0NzeVBURXVV?=
 =?utf-8?B?REo5RFZwaFVFWHl3RjdYeVdSUlB6Yk42aC9SQ0xvLzJPOERBODlRTGtkaUNs?=
 =?utf-8?B?eVdVUTE3SXRZWWNEVzJNL1BGcC9hWTdxUXpSWnhwNGE3TnJFdHFwbnNmV0to?=
 =?utf-8?B?NkRYa1NGZlRvemFTWUZnNGhzMXNFNVA1TEpJMFQwTXJ4b1RNWWhVd2U4cE9P?=
 =?utf-8?Q?rHdTD7ctgRFWHd5JqWfGYtg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5099a25d-3229-4a42-d648-08d9f153f76b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 13:55:18.8848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kRqx0RSYcEa+tfmQPGBl9iU/l5KYDmXxgSzhcPiWXfyDa00YMoCDW1635HCfYDYU2HHwrEuzyexPWzNdcYqIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3591
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/16/2022 6:47 PM, Lazar, Lijo wrote:
>
>
> On 2/16/2022 4:39 PM, Somalapuram, Amaranath wrote:
>>
>> On 2/16/2022 4:13 PM, Lazar, Lijo wrote:
>>>
>>>
>>> On 2/16/2022 4:04 PM, Somalapuram, Amaranath wrote:
>>>>
>>>> On 2/16/2022 3:45 PM, Lazar, Lijo wrote:
>>>>>
>>>>>
>>>>> On 2/16/2022 3:19 PM, Somalapuram Amaranath wrote:
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
>>>>>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct 
>>>>>> file *f,
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
>>>>>> +        r = copy_to_user(buf + len, reg_offset, 
>>>>>> strlen(reg_offset));
>>>>>> +
>>>>>> +        if (r)
>>>>>> +            return -EFAULT;
>>>>>> +
>>>>>> +        len += strlen(reg_offset);
>>>>>> +    }
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
>>>>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file 
>>>>>> *f,
>>>>>> +            const char __user *buf, size_t size, loff_t *pos)
>>>>>> +{
>>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>>> *)file_inode(f)->i_private;
>>>>>> +    char *reg_offset, *reg, reg_temp[11];
>>>>>> +    static int alloc_count;
>>>>>
>>>>> This being static what happens when it is called on a second device?
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>> I tried to avoid adding to adev. It wont work for multiple devices.
>>>
>>> Hmm.This is not friendly for single device also. Some one could just 
>>> parse a text file of reg offsets and do
>>>     sudo echo offset > file
>>>
>>> This will overwrite whatever is there. Instead you may define a 
>>> syntax like
>>>     sudo echo 0x000 > file =>  Clears all
>>>     sudo echo offset > file => Append to the existing set.
>>>
>>> Taking all offsets in one go may not be needed.
>>>
>>> Thanks,
>>> Lijo
>>>
>>
>> 0x000 can be offset for some registers !
>
> It's indeed a valid register called MM_INDEX register. The register 
> doesn't have any meaning in standalone.
>
>> This is application responsibly; any wrong data should clear the list.
>> Application can read back the list for confomation.
>>
>
> It needs to be done by user app anyway. This is more about how 
> convenient the interface is. Probably you could switch to a user 
> standpoint and try to add some 20-30 registers to the list. Then steps 
> needed to add a revised list.
>

For clear we can send text “clear”
On next write should we replace or append ? (I think with "clear" append 
is better option)

Christian which is better ?

Regards,
S.Amarnath
> Thanks,
> Lijo
>
>> Regards,
>> S.Amarnath
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
>>>>>> +            adev->reset_dump_reg_list = krealloc_array(
>>>>>> + adev->reset_dump_reg_list, 1,
>>>>>> +                            sizeof(uint32_t), GFP_KERNEL);
>>>>>> +            alloc_count++;
>>>>>> +        }
>>>>>> +
>>>>>> +        ret = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
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
>>>>>>       struct dentry *root = 
>>>>>> adev_to_drm(adev)->primary->debugfs_root;
>>>>>> @@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct 
>>>>>> amdgpu_device *adev)
>>>>>>       if (!debugfs_initialized())
>>>>>>           return 0;
>>>>>>   +    mutex_init(&adev->reset_dump_mutex);
>>>>>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, 
>>>>>> adev,
>>>>>>                     &fops_ib_preempt);
>>>>>>       if (IS_ERR(ent)) {
>>>>>> @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct 
>>>>>> amdgpu_device *adev)
>>>>>>                   &amdgpu_debugfs_test_ib_fops);
>>>>>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>>>>                   &amdgpu_debugfs_vm_info_fops);
>>>>>> + debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>>>>>> root, adev,
>>>>>> +                &amdgpu_reset_dump_register_list);
>>>>>>         adev->debugfs_vbios_blob.data = adev->bios;
>>>>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>>>>>
