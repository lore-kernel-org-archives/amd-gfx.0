Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E601DC43334
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jul 2022 19:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8649C11A236;
	Tue,  5 Jul 2022 19:12:26 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A95B11BFF7
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jul 2022 19:12:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMi9PPcKLviBFNPw6yTaI9emAkiCDKS2RATwkxg4UJTj1hTikdeWnKwPnMLCy91panmcRua/JX51tosNjjfLdpBOXztHijCsOcHTDRgIRKH+vQonTZjgwlEpvVx1EYv9D9iGgmET3DWQNF8od7j4zOgDT8GYa0csDw0a6iBFWkSOMV/rkUe3BzVVryhgDcsTzzJlKLV26EckZ5HuweKRzMUhmcA1SXAbUeZjDjDtI+2E2Wun593ePuFKIJjukwc4OX1VBsrZRxzn09+7Upsh/duOIK2yEySKtdD5eOsNxdUeqmOqkahHI5wvvyz7rR4pD+tDFAl9+aKgYo0IGU4lYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cmxmu2j5C/NQ/UR7tH+wldNwmjRRYM++2HBIFUlVDJA=;
 b=gPpDNv7e2D7625QL2WEabs1tyf7gw5rLLbqyJan/aWg/HRSRsHMU9AeFHNvoV2R2pb2vmll6nyaFIrMEHGaFO4kMu9MBiVGn2x30soiqQt++MxOOgM8tbXD+FZmHzrJW9BT+Ql02f2JvSmSSyfWxcsTzsxriTjVVNnohgU/KlFoyjWY+/aijH9ouVtJRFI89PwIoQlfJ/IHAP+r8K7TycWCrFdN4tuhOMOS8QgR4t7pnER06iJJSZeFA1p0gKZlfhxqP8amyk/QNyy2lLTu1GLZGbIkvxKp4Rl5szn3NW9FF3Uf2jHICygZ5K1riRzAGrzn3FucIC5HN/ovs9IsdsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cmxmu2j5C/NQ/UR7tH+wldNwmjRRYM++2HBIFUlVDJA=;
 b=R1LBF/lW0+3i5XAvu/n1OuTZbw97bbibvfIrwbZzSHatrnQwa3zUPcwmajqBKpJtz3jIU8MfBp5+WMXWmpRcwhfFNVXZJgo27lnuacGi0Gum+znVPmEpAevdHmCJyF3E/bkJjhAF5ybYMGpJvwKvY069x23Km7qRFcpoyP1pSiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by MN2PR12MB3422.namprd12.prod.outlook.com (2603:10b6:208:ce::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Tue, 5 Jul
 2022 19:12:21 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::2d9d:f26a:77a4:c19]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::2d9d:f26a:77a4:c19%5]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 19:12:21 +0000
Message-ID: <f330f4bc-427d-c2de-fe14-745569e9e4de@amd.com>
Date: Tue, 5 Jul 2022 15:12:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] drm/amdkfd: Remove queue sysfs and doorbell after
 unmapping
Content-Language: en-US
To: philip yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org,
 Philip Yang <Philip.Yang@amd.com>
References: <20220611010334.23401-1-Philip.Yang@amd.com>
 <2f71d9b5-59aa-45cb-0245-7dc139f108b1@amd.com>
 <2a06bc46-1b6f-c3c3-a842-d49ea4980391@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <2a06bc46-1b6f-c3c3-a842-d49ea4980391@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0014.namprd14.prod.outlook.com
 (2603:10b6:610:60::24) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d449f20e-5a5c-4d67-7e62-08da5eba496e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3422:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5b58vqleKEH/Dap7+7bq/y+IBenmVi+vF4uIyD9mFDrs0QDIZWCE+1Yee11wXknezfkgNcW9mIPkf6F3B/sN+hxjlizZ6/xr9KVN5/+EJJjphFPbMti9QoHpNNHdMKMElEXbUev4tKEju+S+R+1P/av000LcnpuE29kLfa9uHl3X/qYzwMwnEpJeHyUZbZskK1z23eXIrLatI1zyrIWZJickpnmjRLqwvI9v224oGmhS5GT77tGQMfbl1onsXQ7TaBvas7QYpctMi/F6b90Squ6xLN1s9aIjOL65UN+Xtec+SVUGyiQfqwcPYjNXVEIgtUSMZuQv/7Q/Z1Y+tEQTNwhWNOVYHRpauHwSkzdqqc7pwBwxqJSk+eLiVJi6VfEXT5yCc116rXB54xE38slq26Us7ZX/O21H/cKamtRJjuBJPgJe8SNXMwhiAXNuiDANxcb4oRqFYK4Op73yDZD/RtgikV5d71sj0U/bA6BY6bT1HYWNcMhrIFqK+gKrQ0wNJ7mVC4+6kBGb5HKeQehhPty5JUPRf05fFak1AHYMEVrcwDX8LmWyRlJDKk6thmZMp78AmvyOj1PzV3cJXnFSfAZyDUQp6zmWilCmmAaHwgczapqDoP82jtsKximsclkj/XevutQPWw5Mqor0Ha6dn5VwNHOgohWJaKhZhcjxqeQeNYUb4j1HJQBPHulK9OZTkoJVDMzXOgrKG0Xug6ptWB5/T5Ox10bOtKleAoCiGim8wncBC/XXbbupydRP36E33ARMi3ejWt45YLAhb1SyGBSFcQZaijzvget29vyORqxDENRwICPuMGyvMj2jaJ4dKM+/GZ6ErTzKdQJeM5gaW80Zul6FuCRPE3DAjGoSrEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(31686004)(186003)(38100700002)(2616005)(36756003)(83380400001)(2906002)(478600001)(26005)(8676002)(66556008)(66476007)(66946007)(44832011)(6512007)(6506007)(5660300002)(8936002)(53546011)(6486002)(36916002)(41300700001)(31696002)(6636002)(316002)(110136005)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S04yeTU5NEF6Ry96b1lJcEZLem95WDA5NzNnTEx1Ujd3SFp6ZXR2bUk5Z0RC?=
 =?utf-8?B?SDBwd2I0d0pFV2RJNmR5N290MU1LOUpBeEpaSk91MEVPak1oekxmc1M0NXlx?=
 =?utf-8?B?UE5qZTFHRWNvTlFXTmg0UGo3Q3B2d3pPREV3MnAwSWZ5a1hSRmMvb2xvK2FU?=
 =?utf-8?B?QnN1SnVSTkpQaWNkTkwrNnM3LzhtelVxZmtFWktSWkN4NnRXVnlkSWV6U2Uw?=
 =?utf-8?B?cWF6cjBRZTVLa2JkaTFtUHd4bTBXM0I3N1FjaUpoSjFWUldLVXdSdVIyT2ZJ?=
 =?utf-8?B?amZFZWlvSE5vaTBOVmE1RzRya0RGV21qTU4zVDNGT24zSlVYNHBMSkpTdEp2?=
 =?utf-8?B?NWZmMXRldWkwT25WelZVZFAyZkwyejFzc1FXejhlMW9WTVhYVi9JQlI2VFhU?=
 =?utf-8?B?N1Y0MzlUcnhiNEptN2hLUjNqYTArbzdqbXd3YUw4ei9CMzNMWW9EMFhadWxS?=
 =?utf-8?B?NDJ0am5OMVpacWJwMEhZUzFzN3Y2czVaVEFEYVVZMlJoZXloNWF6WTlZc3Ur?=
 =?utf-8?B?eGxJU2dEcE1QdmR3Yy8zbEJlLzlLOUNZZmFjcXpyaWV3bWhlbUF0Q1V3SFNz?=
 =?utf-8?B?dXVjNWJjTHN3UGhhMTR3cjZPMWExenAvRWNaVlhlSkFiZjZOTjJhZU1TRVk4?=
 =?utf-8?B?YS96cS9wVklSa2dxNVdCVDZSWHB5clhiMnh2S3MvYVh6Y0hZdEFNaGk0c1Fy?=
 =?utf-8?B?ZWNxc2QwTG9MaEc5UDlnWkhCVkJ3clZRYVRNQ3JRQ25OZ1dTbTQ1U0tZUVVN?=
 =?utf-8?B?OEZVMjU1N3JVQThMbGRCeUxMMjV6QWVvZjZra09pQ2pRQVVUYUxUcmJlbC9O?=
 =?utf-8?B?ZXFIK3Z4Y3pXeEVOcGlHZ1lnMXlXQnNxU3Rra2VUMGg3YVNUU3RyVVpwVjhU?=
 =?utf-8?B?Y3phRHAyeGpGaUMxN2lES2hhcmJmOE53cmttWXpVM2E2LysxVXZyUUErQmh0?=
 =?utf-8?B?MG16VUlHYVRkQ1ZaZjI5cWN3TWNCaGx5ZnFyQVhVSGJZZkRwZ05hTE5HQWdH?=
 =?utf-8?B?SFVreWgrU2docm9meVZVMWVFdWFqUkh0VE5CTEtZTE9SdVYyTzRhSkYwTUhm?=
 =?utf-8?B?dkhvWk1sc2FqRnp3ajdmeDVEV0hGZ040a0dFZWNjZThtT1BOS2Q2SnZaVkJ0?=
 =?utf-8?B?RHc5L2h3RXRZZ3dtZUlGLzFHYVBFRXFSZ2xaUzk3ZVpTRUxQcDJNSFNmK3Ju?=
 =?utf-8?B?bkYrbGkzN3pHWEN1MmY4NkMxRTlRRk0vTXNaYm1XTHRYdFNpTzlFZGtLb1Ns?=
 =?utf-8?B?dFpTUTI3b3llQytHV2hmZHVMUzdkZm9VNEljOWFESXdVVUY2Ty9nZlNHanBP?=
 =?utf-8?B?Wnc1V0JySTVBdGx6bUlzbUd0RXFIZUlHQUkyRnNXWHp3N1o0ZTAyVXU4elpS?=
 =?utf-8?B?WDlneHNrckIwaUtiWFkyc2Zsb2hxNkFzOGJpbk1NSUVOVXptN0Fob1JjVUU5?=
 =?utf-8?B?ekJNbEJxbm9IZzFqVUVxSVl3ME1semFBRGVYMFBGZ1N0TlhwY1lqMldocFN4?=
 =?utf-8?B?MHAwdkd5QXRRT3IrbHlxZXUzdTgzdEE2QTlHa0JXb2IxODRydVpTdVN0ZUh5?=
 =?utf-8?B?MFFEME9lR1dYK3kzSnRsdW1RWmpSQmt3UUNKSzlaa1VxZ3dwQ2lnR1UreC9P?=
 =?utf-8?B?aUozREpWeHR6THZBTWlzM2tPTGV2Q2F1Z0w4SXhDV0VRSGRtNThPZlBFZDhE?=
 =?utf-8?B?WmxHYW9QVHVsY00wMlRrdUE5bGVaaXJXc1ZKT1Q4S0JKK0ZuQlZabjFCWU04?=
 =?utf-8?B?WVFFTThrUXNWMlhDRGJQOFRiRHpXYWdxT2lqa1l1ZndUcTVvS0Q1NDhLelNi?=
 =?utf-8?B?YnphRmI2Qk5sU0UvdnZ1R21yNEowM25XU1dFVkRoei94cUhYS3RVdWV1cEVU?=
 =?utf-8?B?TVVaMDZSSkZHWWUvMXREbEtJTXNkVmg1ZDJQUmxydFlHcVRMUkg0WHh1V1NU?=
 =?utf-8?B?R25rYk44bGJFNGU3RFEzTGlqb2dKSXcyUDVCNlA3enEzYmNjdW9QdEUzRkF2?=
 =?utf-8?B?VzlVQ2NDZWp6Mkc1RHM1NTJQemFzNWpJQ2NoMmswbTV2d3MxVGtPeTVMY1J4?=
 =?utf-8?B?WHBwWFk1a2lBYm1hSHc3Unlrc2lsZnV0TjE3cWhLemFzSWtjSHFPaDJzTmEy?=
 =?utf-8?Q?KzR96Y6d1kf+etfm7s8IGmYVv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d449f20e-5a5c-4d67-7e62-08da5eba496e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 19:12:21.6502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ARM3zUS4XBMHBvJZ/dW75pg+/0d5+EGWg3Idb8KmdOzUW37JEJj+proMtUBQ1EKApYEtXSk4IttazXSyZZOKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3422
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

On 2022-07-05 15:02, philip yang wrote:
>
>
> On 2022-07-05 14:48, Felix Kuehling wrote:
>> On 2022-06-10 21:03, Philip Yang wrote:
>>> If destroying/unmapping queue failed, application may destroy queue
>>> again, cause below kernel warning backtrace.
>>>
>>> For outstanding queues, either applications forget to destroy or failed
>>> to destroy, kfd_process_notifier_release will remove queue sysfs
>>> objects, kfd_process_wq_release will free queue doorbell.
>>>
>>>   refcount_t: underflow; use-after-free.
>>>   WARNING: CPU: 7 PID: 3053 at lib/refcount.c:28
>>>    Call Trace:
>>>     kobject_put+0xd6/0x1a0
>>>     kfd_procfs_del_queue+0x27/0x30 [amdgpu]
>>>     pqm_destroy_queue+0xeb/0x240 [amdgpu]
>>>     kfd_ioctl_destroy_queue+0x32/0x70 [amdgpu]
>>>     kfd_ioctl+0x27d/0x500 [amdgpu]
>>>     do_syscall_64+0x35/0x80
>>>
>>>   WARNING: CPU: 2 PID: 3053 at 
>>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager.c:400
>>>    Call Trace:
>>>     deallocate_doorbell.isra.0+0x39/0x40 [amdgpu]
>>>     destroy_queue_cpsch+0xb3/0x270 [amdgpu]
>>>     pqm_destroy_queue+0x108/0x240 [amdgpu]
>>>     kfd_ioctl_destroy_queue+0x32/0x70 [amdgpu]
>>>     kfd_ioctl+0x27d/0x500 [amdgpu]
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 4 ++--
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
>>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> index e1797657b04c..1c519514ca1a 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> @@ -1876,8 +1876,6 @@ static int destroy_queue_cpsch(struct 
>>> device_queue_manager *dqm,
>>>       mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>>>               q->properties.type)];
>>>   -    deallocate_doorbell(qpd, q);
>>> -
>>>       if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>>>           (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
>>>           deallocate_sdma_queue(dqm, q);
>>> @@ -1898,6 +1896,8 @@ static int destroy_queue_cpsch(struct 
>>> device_queue_manager *dqm,
>>>           }
>>>       }
>>>   +    deallocate_doorbell(qpd, q);
>>> +
>>
>> I'm not sure what this change is meant to do. I don't see an early 
>> return in this function, so deallocate_doorbell will always be 
>> executed either way.
>
> If app destroy queue deallocate_doorbell, but then unmap queue failed, 
> app will destroy queue again when app exit, deallocate_doorbell second 
> time will trigger the WARN backtrace.
>
I get that. But even with your change, deallocate_doorbell will still be 
executed if the queue unmap fails because there is no early return or 
"goto error".


> As queue_count and q->list is used to alloc ring buf in 
> execute_queues_cpsch, so this change causes regression on gfx9, I will 
> submit new patch to handle unmap failed case with MES and fix those 
> issues.
>
I think the intention of the code was to treat HWS in a way that does 
not prevent queue destruction. Basically, there is not point reporting 
HWS errors to the application because the application cannot do anything 
about them anyway. Eventually it will cause a GPU reset and the 
application will be killed. If you look at how -ETIME is handled in 
pqm_destroy_queue, you see that it finishes the job regardless.

However, this has always been somewhat inconsistent. With MES maybe it's 
getting worse because there may be other error conditions we didn't hit 
before. Are you seeing those backtraces on a GPU with MES by any chance?

Regards,
   Felix


> Regards,
>
> Philip
>
>>
>>>       /*
>>>        * Unconditionally decrement this counter, regardless of the 
>>> queue's
>>>        * type
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> index dc00484ff484..99f2a6412201 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> @@ -419,7 +419,6 @@ int pqm_destroy_queue(struct 
>>> process_queue_manager *pqm, unsigned int qid)
>>>       }
>>>         if (pqn->q) {
>>> -        kfd_procfs_del_queue(pqn->q);
>>>           dqm = pqn->q->device->dqm;
>>>           retval = dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
>>>           if (retval) {
>>> @@ -439,6 +438,7 @@ int pqm_destroy_queue(struct 
>>> process_queue_manager *pqm, unsigned int qid)
>>>           if (dev->shared_resources.enable_mes)
>>>               amdgpu_amdkfd_free_gtt_mem(dev->adev,
>>>                              pqn->q->gang_ctx_bo);
>>> +        kfd_procfs_del_queue(pqn->q);
>>
>> This part makes sense.
>>
>> Regards,
>>   Felix
>>
>>
>>>           uninit_queue(pqn->q);
>>>       }
