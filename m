Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBB0C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 10:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D07F10EEDC;
	Thu, 17 Feb 2022 10:09:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FC8A10EEDC
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 10:09:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idaIKk+HBezNGShbdcYj9dYp3fGtoW7JnsG/xJ3QBFE1a03BWa1DeTGD3kPuQekinfy9CdNyTBPRD7DDcVCDprX9kyowZgp20kFyPzCf/LFNAPMggMqs6SNjnwRkDOXZkFNHF9M8J5POszJw5boXJ51hcUfni5YTaNXcja7XvPXRyCCgcfZ9FqJNumJtUTMJbBsWhhCQyINWwIGXExvobXWcxpNTbP0E0alj8oY+7TNAQ+q3xq9mjgfkju6S2EdXSmg5xMRqh5Z35MiIzn3y6g0z9ZqK9B4HcA/zDslJM4Ukl6UqDyDtqCSESSOJRU2i93iKwUoG0Tc5ISbwnPJpNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jr6nZEr+muu26iFEPsFWw4XnsjKcdV85J7ACNaH5oY=;
 b=jnlEZPJi/EpxsN4lWsGPM1taOSbcEEdGoKFJtfylabZrq+X0CppQGkPS6wp8rS4q2IbRmna3D30Mt0ql3BojR7Gj+ReeG+nh0kucf+GH3SLgfjq+pFB/ujmYQ1qLL+nxGuuHKU9GSAxg7JH5NQbwM+oROj6F8touKoR9gmfRKfbMsCIOuA4nMqyQ4zHuvo/TCnZwDowjC93bB/8iA8xOkKn9Ez72sWXtolvZaMYLrWjlGUH84dBaLoWDXISEaoXoDqnG0+6XPNTfQaMUnPNmqXdXR3bQgG1466Amb9Ur2dZ06hmsXym1eAdFPjaXL2o0+im7tZOjf4BFh31j8DyjtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jr6nZEr+muu26iFEPsFWw4XnsjKcdV85J7ACNaH5oY=;
 b=1be4CpXfDKEcsKngg4Zu1PHUNvoCzrl0RNUFTjuNrZBZJzoiov0MWN7pP3K4dMwPUXIm3m+OefWXIaNJueUMBXtNKQ9vdw8Cs5te1Xx33dE7aD864F3qM0iqWZjFYHTOsngxER2SZQkcyCQVyQcOOSbmK1Ko/IOGmVGKWGVR6Wk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BYAPR12MB2984.namprd12.prod.outlook.com (2603:10b6:a03:da::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 10:09:46 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.4995.015; Thu, 17 Feb 2022
 10:09:46 +0000
Message-ID: <b8cb6a88-76ed-8326-5007-7eb066d1d692@amd.com>
Date: Thu, 17 Feb 2022 15:39:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v6 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Somalapuram, Amaranath" <asomalap@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
 <e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com>
 <ed1103b1-835c-e56a-3118-17bd60f0f5f9@amd.com>
 <d531c825-332d-036d-c4b4-5e2cf39edb52@gmail.com>
 <94eeed88-69ad-5823-0505-dc86b36c4007@amd.com>
 <09a4d26f-04be-2a84-343a-32166d21afd1@amd.com>
 <b19700b6-3f68-1654-a07a-371351fe3652@amd.com>
 <dedecd79-ca3d-7b1c-595a-a6e5e56d2161@amd.com>
 <60b40c93-0cee-dab1-b032-b52fd23ebd8e@amd.com>
 <0129eb0b-39b4-befb-094b-c282d1841c6e@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <0129eb0b-39b4-befb-094b-c282d1841c6e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PR0101CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::19) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd3a1861-7009-4f40-2081-08d9f1fd9fa8
X-MS-TrafficTypeDiagnostic: BYAPR12MB2984:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB29849D321A43E377D47BBFF097369@BYAPR12MB2984.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xu9ltQ0mHGzUfbv0Z9c5SMzVfI5cq83VsWLqOvSsMs8gV5QbUX8Z3WS7k5MOm1lRmLEKHfWSc9QhAwx7ycP1u8PKz5r1RCb4pfHLCpB8nQ//gfGxq3KBktsa1BQEaxUQII82eaCVZMpCBdzgkR9oIfP0+bbNjTd70nWra3TFRfE2gDerYM7pN4VGPb3n9q/2GrCxJvyAvfc73GiPnQ38OhjMWngNqFzTMrMs9R85dsepFhTaA7fbo1AC0nCqqYMP3Xxm+WoBIvBDsv2hdubR+obwE3TCkNb+eBQp86EzF0UzQFv7iw6bjZPWfxtWv3oWKr7eimAGFZF79tngdsdm4MNeyFuyYhKT2e9Gw+IwQJ3MMq6xaw+znvbl9chQHkR65MOz75U1JXZcd9YUfco/Waw0B+RaQsUwjqMzuPW/agF9SfZZcINq6jhdr06HfxqXXSoUVshqukAYPMeHolTwEdkQtG3A2n0OFmIQtZSfs5ijBgvCP4bY0ZZBAbuwplkbN58ZMM57XorY0EssHbMeWi7hWmOp4fx2lLGFWzdZGDQ8V5pIz9fII8cevQ1Ts+5bcw+AffR1kfiyDub7ZQP2BxnSf20iUP2E9JQkmKaIZ3v4NBhtdhC66mfQTeIRlmhlEgo31cycHzVl3qXPvyWr2qriFD4e0FyqaH4pcQ/GHzGZtYWTYnQokFFKw5S3/dlGU6TlKTa8ZXr+71sG9g1/rxKZZ7qwXSMOT0ysqZKs/ty+yhfd7FR+hA8pwaccAYVp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(66476007)(38100700002)(2906002)(8676002)(31686004)(8936002)(66574015)(66946007)(30864003)(5660300002)(86362001)(83380400001)(31696002)(186003)(26005)(6666004)(2616005)(6512007)(36756003)(508600001)(53546011)(6486002)(6506007)(66556008)(316002)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnllSzlQaDFHblRCK0RJamkwT09VMVNSYUtlRGRXWmg2aW9aYTBwc1lCNjNJ?=
 =?utf-8?B?ME4zbmhNRk9sbjNzMmVkNE16SG9JUlEzQy9Dd0JFWCsrTHhvZUI2TmMxelRD?=
 =?utf-8?B?ZmNmU2QxVmREbU9mMjBhN2RhUEhxdHZFN0kza3lwV3M2VGVXL1hPbUFhZFNu?=
 =?utf-8?B?QzBVZ0RqZ3d3Q2d0cG1mTXlRQzZ0ZTlKQ1NMR3hFMWg5RnYxU3FyaFJjZGRk?=
 =?utf-8?B?WG5pTC8xNlBaSGtJcEw0L21XTUNBVzNDWndpZlVWZE1YYSticCt0NXBvSkJn?=
 =?utf-8?B?TmFldEJVeHNuZ3NHSTdIQVBrRFFsQnczeGlWOEhLelgzaUFUK2E5UExzbDd6?=
 =?utf-8?B?NC80TEMwcnhGdXNPb1VkS2Z0dUE0UzVQZ2FxZGVvTWYrR2JKYi9Nc1pHQmlZ?=
 =?utf-8?B?a3dzbk52VWFWUFllZWFwQzBva1JxczN4SVk0cTVKRVBKeTVHVXhEMTR2VjRz?=
 =?utf-8?B?MGJwdUhFWk9lM1JLUTRGYks4R1o5bHRkTFJHeXFIWlBqUmFRZ2NZZlhUNXpl?=
 =?utf-8?B?bWdGSWd4VzR5T0FneDloUmZncXVXNkVlQS9yZkxObmwyQ2ttNjlKVW5DMWww?=
 =?utf-8?B?RzQvUm8wWCthRVN3ZW81LzZTNlVDZlU2L2thYzMrWUhSNnViQTh6YTFTTHlI?=
 =?utf-8?B?TXhuZDlKQVdRZUdCSnNnVVkvYlgwSVhvNlNKYldkTDlNSzV5aTdubU11S3dD?=
 =?utf-8?B?bGFqRiswbmMrMjJNcWNybnloTHY4a1dYQ3MrbDVkMmN2MlFFSzNKQWFKTjRU?=
 =?utf-8?B?QkRNWWxMZWY1N3pqcU82UG85M2pNNmxTSEl5MXVQMVBydURHZnl3UW1Dd0hj?=
 =?utf-8?B?dmFTTHJkM0FNeTJDdElGMFhSamoxeHlYaE91VU16K1RkRTRWMzhkZnJsSjhk?=
 =?utf-8?B?NWtUVmwvSllJeXVoaU9vL1pWb2NidEZyWG5NMXUxNFBBMlo0bEVpT25HNEx3?=
 =?utf-8?B?dTd1U3JFU1BvMWpMa244RzVJMUpwZDFqVnJwbDljK21uNUZSeTU1L3dIdjZ2?=
 =?utf-8?B?TmVJTHlqb0xFS1pjUkNmRHVzQTNqbDZXWDZoVnBpUjVEM1ExVlFhaFJ2WUlY?=
 =?utf-8?B?cGdacitCTldqTVYyMERqTHEwSVZMTDNNZXl6RUR5VjhHRFhXcHpQaXFJa1RF?=
 =?utf-8?B?Q0p2ckFEMU8yazFzdHoyb1BncFgrc3U1NXFsdzFFSHdXS3JEcFAwZm1McVIy?=
 =?utf-8?B?VmdwU2tOTWlxL1JocFVIN2R3NnBoRUgyVW9VZG9vWmEraThNRDU3MWtlWW50?=
 =?utf-8?B?WUE5R3BibDkzK281Q0V6OEpjWXVBVG5HazN2KzJMM3oxaDZoYUtMQjFZaXhy?=
 =?utf-8?B?aVU2SlpPWXpoUXF0RkF1eng0S283TXE3dnZ2bEc5YmJNbWliU0VYMlNZTzZz?=
 =?utf-8?B?QjVzYnlCZ0lzZXdqN1N4aDNtaXl4dHNDZkZhZlNyWlA5TURIUG03ejl1ajB3?=
 =?utf-8?B?alkxS252dGNveWk3NU1rTGVaMC8zWExjTzhsQjRtWERQYlBoNVJWYURCNzZj?=
 =?utf-8?B?WXV3bkZjczhGS1hwM0lIOGkyNWJ3MUZZT0gyaEN5RVFZTm5YTFBBOXJScGhh?=
 =?utf-8?B?bzNmTnNxa3k2dk9GTi81MVhiTXo2N3ZrazZBUE1kbHZ4RElWOXdQdVJ3d2xw?=
 =?utf-8?B?NDdPRjFDU1J4VUhFZVFtQ3hwcE9QQmtmZVRJTzdiR2tGU3FWY2xURVhma01Q?=
 =?utf-8?B?VFE1NTIwSEpRYXlQWUp2NzlUWFczakkwTFBkTm4wV0VmWTBnQUlhS25uTE5j?=
 =?utf-8?B?Ynh4ZGVKS2RxZ2E0NHFJb0RJeDJJWE1uY2Qra1k0aWtUWk5oQlF1T2krQUt0?=
 =?utf-8?B?ZVVGaVpkY3lCeFJqcmRJQklqVzZKY3lnZXB3MjRZWGdDeHYxVFM4c2h4bWZS?=
 =?utf-8?B?YTdpeHZWNUhtRlNsSWdpN3NkVmRuR1g2MjlrbnRvUHlsdGtBR0prNmNhb2lX?=
 =?utf-8?B?dkFOM01HaXRzMXp6bTlTeFFDMFlkNVpxVkVoWXh3OUhMb29ZRE5NYVFkY2lN?=
 =?utf-8?B?bHRMVHFRb2taOUJDR2NaQ3BXSU85dm52a0g4OUU0alp0OW9Xc2NBcmIwU1ZW?=
 =?utf-8?B?ZTFsVk9mK3FSK1dxZUtVTVpqNG1RN2svTm0zbVRGV3VVQWVDdU9aTlNsVnRq?=
 =?utf-8?Q?lGL4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3a1861-7009-4f40-2081-08d9f1fd9fa8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 10:09:46.1001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHGsZN8oenS9Vgu60uKNTsskhpk0JwCkJsg6UENMlMuBEHgOFHb1IcZDgmQxAFQc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2984
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



On 2/17/2022 3:34 PM, Christian König wrote:
> 
> 
> Am 17.02.22 um 11:01 schrieb Lazar, Lijo:
>>
>>
>> On 2/17/2022 3:18 PM, Christian König wrote:
>>> Am 17.02.22 um 10:44 schrieb Lazar, Lijo:
>>>>
>>>>
>>>> On 2/17/2022 1:30 PM, Christian König wrote:
>>>>>
>>>>>
>>>>> Am 17.02.22 um 08:54 schrieb Somalapuram, Amaranath:
>>>>>>
>>>>>>
>>>>>> On 2/16/2022 8:26 PM, Christian König wrote:
>>>>>>> Am 16.02.22 um 14:11 schrieb Somalapuram, Amaranath:
>>>>>>>>
>>>>>>>> On 2/16/2022 3:41 PM, Christian König wrote:
>>>>>>>>
>>>>>>>>> Am 16.02.22 um 10:49 schrieb Somalapuram Amaranath:
>>>>>>>>>> List of register populated for dump collection during the GPU 
>>>>>>>>>> reset.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Somalapuram Amaranath 
>>>>>>>>>> <Amaranath.Somalapuram@amd.com>
>>>>>>>>>> ---
>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++
>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 
>>>>>>>>>> +++++++++++++++++++++
>>>>>>>>>>   2 files changed, 100 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>> index b85b67a88a3d..57965316873b 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>> @@ -1097,6 +1097,11 @@ struct amdgpu_device {
>>>>>>>>>>         struct amdgpu_reset_control *reset_cntl;
>>>>>>>>>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>>>>>>>>> +
>>>>>>>>>> +    /* reset dump register */
>>>>>>>>>> +    uint32_t            *reset_dump_reg_list;
>>>>>>>>>> +    int                             n_regs;
>>>>>>>>>> +    struct mutex            reset_dump_mutex;
>>>>>>>>>
>>>>>>>>> I think we should rather use the reset lock for this instead of 
>>>>>>>>> introducing just another mutex.
>>>>>>>>>
>>>>>>>>>>   };
>>>>>>>>>>     static inline struct amdgpu_device *drm_to_adev(struct 
>>>>>>>>>> drm_device *ddev)
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>>>> index 164d6a9e9fbb..faf985c7cb93 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>>>> @@ -1609,6 +1609,98 @@ 
>>>>>>>>>> DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>>>>>>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>>>>>>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>>>>>>>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct 
>>>>>>>>>> file *f,
>>>>>>>>>> +                char __user *buf, size_t size, loff_t *pos)
>>>>>>>>>> +{
>>>>>>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>>>>>>> *)file_inode(f)->i_private;
>>>>>>>>>> +    char reg_offset[11];
>>>>>>>>>> +    int i, r, len = 0;
>>>>>>>>>> +
>>>>>>>>>> +    if (*pos)
>>>>>>>>>> +        return 0;
>>>>>>>>>> +
>>>>>>>>>> +    if (adev->n_regs == 0)
>>>>>>>>>> +        return 0;
>>>>>>>>>> +
>>>>>>>>>> +    for (i = 0; i < adev->n_regs; i++) {
>>>>>>>>>> +        sprintf(reg_offset, "0x%x ", 
>>>>>>>>>> adev->reset_dump_reg_list[i]);
>>>>>>>>>> +        r = copy_to_user(buf + len, reg_offset, 
>>>>>>>>>> strlen(reg_offset));
>>>>>>>>>> +
>>>>>>>>>> +        if (r)
>>>>>>>>>> +            return -EFAULT;
>>>>>>>>>> +
>>>>>>>>>> +        len += strlen(reg_offset);
>>>>>>>>>> +    }
>>>>>>>>>
>>>>>>>>> You need to hold the lock protecting adev->reset_dump_reg_list 
>>>>>>>>> and adev->n_regs while accessing those.
>>>>>>>>>
>>>>>>>>> (BTW: num_regs instead of n_regs would match more what we use 
>>>>>>>>> elsewhere, but is not a must have).
>>>>>>>>>
>>>>>>>> This is read function for user and returns only list of reg 
>>>>>>>> offsets, I did not understand correctly !
>>>>>>>>>> +
>>>>>>>>>> +    r = copy_to_user(buf + len, "\n", 1);
>>>>>>>>>> +
>>>>>>>>>> +    if (r)
>>>>>>>>>> +        return -EFAULT;
>>>>>>>>>> +
>>>>>>>>>> +    len++;
>>>>>>>>>> +    *pos += len;
>>>>>>>>>> +
>>>>>>>>>> +    return len;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct 
>>>>>>>>>> file *f,
>>>>>>>>>> +            const char __user *buf, size_t size, loff_t *pos)
>>>>>>>>>> +{
>>>>>>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>>>>>>> *)file_inode(f)->i_private;
>>>>>>>>>> +    char *reg_offset, *reg, reg_temp[11];
>>>>>>>>>> +    static int alloc_count;
>>>>>>>>>> +    int ret, i = 0, len = 0;
>>>>>>>>>> +
>>>>>>>>>> +    do {
>>>>>>>>>> +        reg_offset = reg_temp;
>>>>>>>>>> +        memset(reg_offset,  0, 11);
>>>>>>>>>> +        ret = copy_from_user(reg_offset, buf + len, min(11, 
>>>>>>>>>> ((int)size-len)));
>>>>>>>>>> +
>>>>>>>>>> +        if (ret)
>>>>>>>>>> +            goto failed;
>>>>>>>>>> +
>>>>>>>>>> +        reg = strsep(&reg_offset, " ");
>>>>>>>>>> +
>>>>>>>>>> +        if (alloc_count <= i) {
>>>>>>>>>
>>>>>>>>>> + adev->reset_dump_reg_list =  krealloc_array(
>>>>>>>>>> + adev->reset_dump_reg_list, 1,
>>>>>>>>>> +                            sizeof(uint32_t), GFP_KERNEL);
>>>>>>>>>> +            alloc_count++;
>>>>>>>>>> +        }
>>>>>>>>>> +
>>>>>>>>>> +        ret = kstrtouint(reg, 16, 
>>>>>>>>>> &adev->reset_dump_reg_list[i]);
>>>>>>>>>
>>>>>>>>> This here is modifying adev->reset_dump_reg_list as well and so 
>>>>>>>>> must be protected by a lock as well.
>>>>>>>>>
>>>>>>>>> The tricky part is that we can't allocate memory while holding 
>>>>>>>>> this lock (because we need it during reset as well).
>>>>>>>>>
>>>>>>>>> One solution for this is to read the register list into a local 
>>>>>>>>> array first and when that's done swap the local array with the 
>>>>>>>>> one in adev->reset_dump_reg_list while holding the lock.
>>>>>>>>>
>>>>>> krealloc_array should be inside lock or outside lock? this may be 
>>>>>> problem.
>>>>>>
>>>>>
>>>>> This *must* be outside the lock because we need to take the lock 
>>>>> during GPU reset which has a dependency to not allocate memory or 
>>>>> wait for locks under which memory is allocated.
>>>>>
>>>>> That's why I said you need an approach which first parses the 
>>>>> string from userspace, build up the register list and then swap 
>>>>> that with the existing one while holding the lock.
>>>>>
>>>>
>>>> Another approach would be to just protect debugfs write with 
>>>> down_read(&adev->reset_sem) or reset domain semaphore.
>>>
>>> No, exactly that doesn't work.
>>>
>>> See the down_write(&adev->reset_sem) would then wait for this reader 
>>> and the reader is allocating memory and allocating memory might wait 
>>> for the reset to finish => deadlock.
>>
>> I didn't get this part - allocating memory might wait for the reset to 
>> finish.
>>
>> down_write() is called as one of the first steps during device reset, 
>> and therefore device reset hasn't started. When you say " reset to 
>> finish", do you mean device reset or something else?
> 
> I mean device reset. Holding the reset lock prevents device reset from 
> starting because of the down_write() and core memory management might 
> wait for this before it continues allocating memory.
> 

Is this passed to core memory management by a component like drm or ttm?

I thought reset was mainly internal/contained to device level as we 
reset for multiple reasons and system as whole shouldn't be affected.

Thanks,
Lijo

> Regards,
> Christian.
> 
>>
>> Thanks,
>> Lijo
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Other than that if apps are trying to read and modify the list at 
>>>> the same time, probably we should leave that to user mode since this 
>>>> is mainly a debug feature.
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> S.Amarnath
>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>> There are 2 situations:
>>>>>>>> 1st time creating list n_regs will be 0 and trace event will not 
>>>>>>>> be triggered
>>>>>>>> 2nd time while updating list n_regs is already set and 
>>>>>>>> adev->reset_dump_reg_list will have some offsets address 
>>>>>>>> (hypothetically speaking *during reset + update* read values 
>>>>>>>> from RREG32 will mix up of old list and new list)
>>>>>>>> its only critical when its freed and n_regs is not 0
>>>>>>>
>>>>>>> No, that won't work like this. See you *must* always hold a lock 
>>>>>>> when reading or writing the array.
>>>>>>>
>>>>>>> Otherwise it is perfectly possible that one thread sees only 
>>>>>>> halve of the updates of another thread.
>>>>>>>
>>>>>>> The only alternative would be RCU, atomic replace and manual 
>>>>>>> barrier handling, but that would be complete overkill for that 
>>>>>>> feature.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> S.Amarnath
>>>>>>>>>> +
>>>>>>>>>> +        if (ret)
>>>>>>>>>> +            goto failed;
>>>>>>>>>> +
>>>>>>>>>> +        len += strlen(reg) + 1;
>>>>>>>>>> +        i++;
>>>>>>>>>> +
>>>>>>>>>> +    } while (len < size);
>>>>>>>>>> +
>>>>>>>>>> +    adev->n_regs = i;
>>>>>>>>>> +
>>>>>>>>>> +    return size;
>>>>>>>>>> +
>>>>>>>>>> +failed:
>>>>>>>>>> +    mutex_lock(&adev->reset_dump_mutex);
>>>>>>>>>> +    kfree(adev->reset_dump_reg_list);
>>>>>>>>>> +    adev->reset_dump_reg_list = NULL;
>>>>>>>>>> +    alloc_count = 0;
>>>>>>>>>> +    adev->n_regs = 0;
>>>>>>>>>> +    mutex_unlock(&adev->reset_dump_mutex);
>>>>>>>>>> +    return -EFAULT;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +
>>>>>>>>>> +
>>>>>>>>>> +static const struct file_operations 
>>>>>>>>>> amdgpu_reset_dump_register_list = {
>>>>>>>>>> +    .owner = THIS_MODULE,
>>>>>>>>>> +    .read = amdgpu_reset_dump_register_list_read,
>>>>>>>>>> +    .write = amdgpu_reset_dump_register_list_write,
>>>>>>>>>> +    .llseek = default_llseek
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>>>>>>>>   {
>>>>>>>>>>       struct dentry *root = 
>>>>>>>>>> adev_to_drm(adev)->primary->debugfs_root;
>>>>>>>>>> @@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct 
>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>       if (!debugfs_initialized())
>>>>>>>>>>           return 0;
>>>>>>>>>>   +    mutex_init(&adev->reset_dump_mutex);
>>>>>>>>>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, 
>>>>>>>>>> root, adev,
>>>>>>>>>>                     &fops_ib_preempt);
>>>>>>>>>>       if (IS_ERR(ent)) {
>>>>>>>>>> @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct 
>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>> &amdgpu_debugfs_test_ib_fops);
>>>>>>>>>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>>>>>>>> &amdgpu_debugfs_vm_info_fops);
>>>>>>>>>> + debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>>>>>>>>>> root, adev,
>>>>>>>>>> + &amdgpu_reset_dump_register_list);
>>>>>>>>>>         adev->debugfs_vbios_blob.data = adev->bios;
>>>>>>>>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>>>>>>>>
>>>>>>>
>>>>>
>>>
> 
