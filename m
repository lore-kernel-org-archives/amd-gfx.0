Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940F8C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 16:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57EF56113D
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 16:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 57EF56113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 100ED6E182;
	Tue, 19 Oct 2021 16:02:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3CD16E182
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 16:02:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMrSt7p94kNFocuE2cDj9nBZeki3YkuJ+pdQAxUpNMwOKsSyJUoBQdsMM5g0h1gk9JiKsscgXyoMnaRov0xsnb+sL81CxrfF5llOSzybTS205PmMV1QIdc20e5BM5RcKjdwL3et2p7K8ClDSs8pHOTibEeymt55M52uNeyMBFkFIGzTFNc3QcNzyJ3AavHc6pOBHWKug7C2PcMX8Vy5xI4nsY35QgAanANXkZw0gpivdcjQxtk/tXVxwzkQrvI9LSyFFJnnoCTIWe+jjPnbekaUFkZ1xKi3MRc8tzbydBUfgb0SYgVxlWIcwVja+kt6vdGOLLLB+a+MPxy8Zip9l7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGgq6iAvfGCfrJAYzdm0vhurQqQ1eyQMTQAWzjCJj8s=;
 b=O/1VLX+cARGT4mqAkyEUJNHE3ecsypPZa+pv8F6hxu4k0Xzfgul4eRpjrMCAJWz8qIUlxY2DJBTHj+bIJ6cSNF5fqSUSZkjDhhGiMJsM5/3angoX4jIBUtkEU207dTxxPCWLJAxEfvUK2bvg8ch4yGdkwR2qupEJch/UG7cl3LjivsvrzQwEe8imm9Z/7bZ9VcrdZ64bNsxa51g4tbCws4oCEZs5QCykXjJG/yanHivNSg1X0KvFVgNFvYDN2V16+wrXbmXdIUwNYSMqo+qyA4uut6n9FmdFL0D3j6d9vFBFBwgF6vO+nGaZDp6K8D4sFndBWDRzlwSs8+nqUA5E0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGgq6iAvfGCfrJAYzdm0vhurQqQ1eyQMTQAWzjCJj8s=;
 b=iH/cxRtsB9UA0v+Wb6/9qH3Scs9RUshSCkmnZH+fnzrLtrSbdNOTlrNFyqzmcsvAlUubA97dCvH70P98SBRfpkxGSH9MZD93PxgBCkFrZ8AffaWKxW/ZRdL+kcjJDoTEEkQUZ3BPy0rBJUyUHVaNHIfhhGSZsbmO6c46gfCnxNY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM5PR12MB1371.namprd12.prod.outlook.com (2603:10b6:3:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 16:02:03 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0%11]) with mapi id 15.20.4608.018; Tue, 19 Oct
 2021 16:02:03 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: recover gart table at resume
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org,
 "Christian.Koenig@amd.com" <Christian.Koenig@amd.com>
References: <20211019132200.10352-1-nirmoy.das@amd.com>
 <28201f2b-e524-4192-bafc-29c5871fbb16@amd.com>
 <0865a77f-7a84-61c1-4375-f9b180616311@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <e6e1a30d-3278-684e-9807-788b30f24537@amd.com>
Date: Tue, 19 Oct 2021 12:01:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <0865a77f-7a84-61c1-4375-f9b180616311@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: LO4P123CA0040.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::9) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:a4e6:969e:ec:4698]
 (2607:fea8:3edf:49b0:a4e6:969e:ec:4698) by
 LO4P123CA0040.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:152::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16 via Frontend Transport; Tue, 19 Oct 2021 16:02:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a822d57-0f95-492c-2d99-08d99319cab2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1371:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1371E63F8783A5673C7AAE41EABD9@DM5PR12MB1371.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyjdnz8VivtEPda9vyuAt96TjxGHJC7NK9af56jLTdkHQytSIOaVvzVTqOk3SOlnuDpwbX11aXfzjTkvUZ/ZhbBdqKHXiK1O6VpAV05pke49d1uOKTlthqVo/AOuZFSfNFiQMqmftGdNScvws86w+D1ISng0VFKmEJn7XSNdphiS7Chde8VMsvWqTLU220zS1vbMrmpehgBWaTaTQnc4q2vyJwziz3pr1D/aw0Bso6D/UjA7HAWldQKYtvoDWm9bk1QYihoONEtxMmXZCLRXv8Pu8teG01eG0TQyzsdCNyz4pucchwj+sBnNZXVUTIV1Iz2u+ezfMz5aHCQlWzz/y1Dc1d1F0snU2GgwTcryM5QBU8cx+AgZelRn0zV0iozYhvhFnrlLCDXeCkc1dijiUxT2FSBDlj/1fBONoZXEt+CZtip4cCsvLtcvUIBK1BnVd36BpzHEg8WCLWs1MdRDKjulBq71V01xlXfDRQ6NP7s3T1x75DYJSqF66Q8jv/xzIxcCXjHc1Vh4DshV/i2OZkpmXtVEfDN7ROEvVwQ9CVDkl6glyNfK2OEE7it66WVN7y1TbjkiMytA1OXH9ktC+KUhiEdUhMilk0JQsuWnQZr21AKN1YTSoFXSiDBuOi6fkul46pFhcUpKZATs29/3FWxQ6799CLZPvmtWONA3qHoiLvwXFY/X7TqnzQ00rSx6uWplBXMhOy/dWEvIFYLOWPQsmIXJ0Qir3qgU3nR/gziKg1/w83RJ83xyWHg8C2aW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(2616005)(38100700002)(4001150100001)(316002)(86362001)(36756003)(8936002)(8676002)(44832011)(66556008)(66476007)(66946007)(66574015)(6486002)(2906002)(5660300002)(6666004)(186003)(31696002)(6636002)(31686004)(53546011)(508600001)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEFrOFVOR0JKVVNLd2lhcHdIeFFFUU5JdlYwWVpXcThyQTJ5NkhEQTR3SWcx?=
 =?utf-8?B?VzZRTU81WEZVdUo3VDhFYlM1aExxWWNFTmVpblA0ekR6OEw0eGprOWFGbElN?=
 =?utf-8?B?dGZFWVc0bC9BMzNMUXNhUlZpc3Q3cWIvWXNUckpqTVpQb0ptUFFKUzdhdFox?=
 =?utf-8?B?RmNkaGRQZXA1V0I5aEtUUW1FelhEZit5YzgzY0lSckkzRGw1Uis4VGJObndn?=
 =?utf-8?B?S0VKSTVoWXUwZysyMlp5bk94YlZxTnR5RmlXMVRlMEYrOUJJaXJFNkM5K1NZ?=
 =?utf-8?B?Q1JzS3ZQL2UxVVpnWEN5ZXdwNGxLZjFPM01BMExjUEdjN0Zqby9OSUc0dzJM?=
 =?utf-8?B?U0J1Y25IbjRvWUMxUDRkZ1pCL1JIOGFxdFdtVndRZ01pSGJLRG5vMG9mYS9q?=
 =?utf-8?B?d0ZUZDBqNmpxQTUyNlBhUXU1YmRzSkhKTVZvQW9ZQ0t5M2dqeFM4RW44Mjdx?=
 =?utf-8?B?eGJkZ3Y1ZUJjdEQ0UlJWd3ZCZnNoZ25RZXdNZHdoMzBURDZRZnYwSnlDd0lq?=
 =?utf-8?B?eS93RXBpNnZHQUN3Vm1kS3hQaEpKWTQrdGJCWENpVTd6Y0FkSEx2cmNBT3pw?=
 =?utf-8?B?L2tPcHA1Zm1rL3ZNNnlHYVBzVklNK3BCVXpZYTlRTjZMdkdkVzJDaEt2QTFN?=
 =?utf-8?B?V3gzTWJMUkZFenY0OHU3dlgwWmsxMFZTQkJEeFlIVGxtTEF2bEs2aTVoRE9y?=
 =?utf-8?B?ZTBmM2w5N2RjRi9JUEdld2xQSks5RktWdmhCRHRiRXRVZlVRb3krdjQ3SWJl?=
 =?utf-8?B?WmR0TDJHSmladGthcE5ieXJ0NExwU05aejhJZHJvS1dZV2Zqdno3SjA1YmpU?=
 =?utf-8?B?d3VGbllOQkYvcWE0S2o1Q05zN0JHNHdsVCtZd096anBlcWlUYW1KMTZyaHpi?=
 =?utf-8?B?RlFwam1NMGxnMFhhamxFelZxaEUyYmlWcDFXcGpuVkJ3cEV6Uk8zVlU3OEl6?=
 =?utf-8?B?Uyt5UXd1QUFBV1NwMnVLenBUY2hnRnpUNWQzeFhUNHIra0RhR3hRYnlQeXBR?=
 =?utf-8?B?dm5HV1kxUDNTME5yZmI1ZndCRm16TElsYXFoU1ZLbFZKTXk4OFN1ckVmSFhY?=
 =?utf-8?B?eXM1RTd3SW1hUlNiWUg4NXFrTEdjek9naFhSUWQ5OVJWL3pVUnVGUHE1UnIx?=
 =?utf-8?B?UVlkWFZLbWtMTWwxUjRNQldEVXBQTGcvSFN1RkFpVGs4WWoyQmFnc0lNbW9a?=
 =?utf-8?B?ZkRIdXQ3M3RVRWtIeXdGT0R4RVpjRUlNTVZMZlZvZ3BWb091SGhqRVdUM2Zp?=
 =?utf-8?B?NmVtdThDbVMvbWZEZUc5V3hMajF2ckxvemdpL3V3b0Z5d3dQRTJxUzlrdkla?=
 =?utf-8?B?eWpTK0ZhSWxXTkcvT1NiL2EzRHNUaTZKdWM1STgrUlNHLytXWU5RT3FaUUds?=
 =?utf-8?B?eWJBVG8yUXJ4L2pvUjd2TGdkNUlwZE1wNXdqS2pzeHZnR25aa1phNVdpSGFH?=
 =?utf-8?B?Y1hLR0VHQ0JHbnYzS0MxWXhqZ0dhNHNzeFJRdlZldllUV1BxdC94YXl6WTY1?=
 =?utf-8?B?UVdZYlMreHRKL3BGQWF5eC9EZzVOSHcvZHVnSkM0bWxUdHlxZWF0RjI0V0JU?=
 =?utf-8?B?NE8wL0pINW4yR2FHOWVKdEkyY0VJYmpRMjE4Y3d2c1FweEVQelh4Z25UYWk3?=
 =?utf-8?B?NG1JM0hmRUZndXNPYjVhK0djWnJVNTBhVmZHMjJPdHFORS9xRkgzdlJnelE5?=
 =?utf-8?B?aEIxbGFSNGZJMTBqaW04dnFaWk13UDVrZHRmTGV5ZmhHSU5FelFQZWpKWExF?=
 =?utf-8?B?ZFIzM1pXTG54cFBlK1FBeG9rbjl2TDdXa3Fyd1UwNUdEd2pKY2pyakpZZVFy?=
 =?utf-8?B?d1J1dS9wSTh1d2ttcDBKVDIrSTZPWElmOUpRMVdrYXZGZ2ZtS2lnanpRcGI2?=
 =?utf-8?Q?XHlbRFWxoiB4K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a822d57-0f95-492c-2d99-08d99319cab2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 16:02:03.5895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDQHZ1WfZhcAiuJoUUi1s7idWGeAeS9PAfcK+g22BRoye6E2Nx3Q/IquUJBYaL8tvlQ1pfqrdLIOo/xbrmUPDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1371
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2021-10-19 11:54 a.m., Christian König wrote:
> Am 19.10.21 um 17:41 schrieb Andrey Grodzovsky:
>>
>> On 2021-10-19 9:22 a.m., Nirmoy Das wrote:
>>> Get rid off pin/unpin and evict and swap back gart
>>> page table which should make things less likely to break.
>>
>> +Christian
>>
>> Could you guys also clarify what exactly are the stability issues 
>> this fixes ?
>
> When we evict the GART table during suspend it is theoretically 
> possible that we run into an OOM situation.
>
> But since the OOM killer and the buffer move functions are already 
> disable that is basically not gracefully handle able.
>
> When we just keep the GART pinned all the time and restore it's 
> content during resume from the metadata we should be able to avoid any 
> memory allocation for the move.
>
> Christian.


Got it.

Andrey


>
>>
>> Andrey
>>
>>
>>>
>>> Also remove 2nd call to amdgpu_device_evict_resources()
>>> as we don't need it.
>>>
>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 -----
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 16 ++++++++++++----
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 17 +++++++++++++----
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 16 ++++++++++++----
>>>   4 files changed, 37 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 41ce86244144..22ff229ab981 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -3941,11 +3941,6 @@ int amdgpu_device_suspend(struct drm_device 
>>> *dev, bool fbcon)
>>>       amdgpu_fence_driver_hw_fini(adev);
>>>         amdgpu_device_ip_suspend_phase2(adev);
>>> -    /* This second call to evict device resources is to evict
>>> -     * the gart page table using the CPU.
>>> -     */
>>> -    amdgpu_device_evict_resources(adev);
>>> -
>>>       return 0;
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> index 3ec5ff5a6dbe..18e3f3c5aae6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> @@ -992,9 +992,16 @@ static int gmc_v10_0_gart_enable(struct 
>>> amdgpu_device *adev)
>>>           return -EINVAL;
>>>       }
>>>   -    r = amdgpu_gart_table_vram_pin(adev);
>>> -    if (r)
>>> -        return r;
>>> +    if (!adev->in_suspend) {
>>> +        r = amdgpu_gart_table_vram_pin(adev);
>>> +        if (r)
>>> +            return r;
>>> +    } else {
>>> +        r = amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev,
>>> +                                TTM_PL_TT));
>>> +        if (r)
>>> +            return r;
>>> +    }
>>>         r = adev->gfxhub.funcs->gart_enable(adev);
>>>       if (r)
>>> @@ -1062,7 +1069,8 @@ static void gmc_v10_0_gart_disable(struct 
>>> amdgpu_device *adev)
>>>   {
>>>       adev->gfxhub.funcs->gart_disable(adev);
>>>       adev->mmhub.funcs->gart_disable(adev);
>>> -    amdgpu_gart_table_vram_unpin(adev);
>>> +    if (!adev->in_suspend)
>>> +        amdgpu_gart_table_vram_unpin(adev);
>>>   }
>>>     static int gmc_v10_0_hw_fini(void *handle)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> index 492ebed2915b..0ef50ad3d7d5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> @@ -837,9 +837,17 @@ static int gmc_v8_0_gart_enable(struct 
>>> amdgpu_device *adev)
>>>           dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>           return -EINVAL;
>>>       }
>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>> -    if (r)
>>> -        return r;
>>> +
>>> +    if (!adev->in_suspend) {
>>> +        r = amdgpu_gart_table_vram_pin(adev);
>>> +        if (r)
>>> +            return r;
>>> +    } else {
>>> +        r = amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev,
>>> +                                TTM_PL_TT));
>>> +        if (r)
>>> +            return r;
>>> +    }
>>>         table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>   @@ -992,7 +1000,8 @@ static void gmc_v8_0_gart_disable(struct 
>>> amdgpu_device *adev)
>>>       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>>>       WREG32(mmVM_L2_CNTL, tmp);
>>>       WREG32(mmVM_L2_CNTL2, 0);
>>> -    amdgpu_gart_table_vram_unpin(adev);
>>> +    if (!adev->in_suspend)
>>> +        amdgpu_gart_table_vram_unpin(adev);
>>>   }
>>>     /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index cb82404df534..1bbcefd53974 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -1714,9 +1714,16 @@ static int gmc_v9_0_gart_enable(struct 
>>> amdgpu_device *adev)
>>>           return -EINVAL;
>>>       }
>>>   -    r = amdgpu_gart_table_vram_pin(adev);
>>> -    if (r)
>>> -        return r;
>>> +    if (!adev->in_suspend) {
>>> +        r = amdgpu_gart_table_vram_pin(adev);
>>> +        if (r)
>>> +            return r;
>>> +    } else {
>>> +        r = amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev,
>>> +                                TTM_PL_TT));
>>> +        if (r)
>>> +            return r;
>>> +    }
>>>         r = adev->gfxhub.funcs->gart_enable(adev);
>>>       if (r)
>>> @@ -1793,7 +1800,8 @@ static void gmc_v9_0_gart_disable(struct 
>>> amdgpu_device *adev)
>>>   {
>>>       adev->gfxhub.funcs->gart_disable(adev);
>>>       adev->mmhub.funcs->gart_disable(adev);
>>> -    amdgpu_gart_table_vram_unpin(adev);
>>> +    if (!adev->in_suspend)
>>> +        amdgpu_gart_table_vram_unpin(adev);
>>>   }
>>>     static int gmc_v9_0_hw_fini(void *handle)
>
