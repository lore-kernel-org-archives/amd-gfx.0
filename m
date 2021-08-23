Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA53EC432BE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 15:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23E661371
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 15:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B23E661371
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42B0E89FF6;
	Mon, 23 Aug 2021 15:15:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A523389FF6
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 15:14:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PS2zWCdMIbfH16NBtglWXQGGfBdQEWOtS8i7E0uaYOp1SbnYFi2vyifHhCCxfVRuqXurV2/ynq/LJ5sBYwBgVnrUPxJdMAqv3dWMhV+NcnGsmt5tOXWlgM5Y0iA3x6+qOOtNtnPXDtNsgWyIp9+alCp7MEJBHavAve12oF25pfD5mhB9xiz+VjWBXwuoG/C534F5S28LqcuQaH3P9GWxNupxkFgV2ysrsJSLnHQ5u+xlRVt7jmMmx8aZKVnV/Ci9QzGBNato2kkCugmjG8PRLBl966oGzWbntA2XZGhMZdpeyeBBxurW69XSlzu4PTKBbTJ/PFeUNqj8/UaZDhTp6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OAUTij4pFrKn/KF5awrPZ5Wu0+gWpQcaBEZFUBac6Q=;
 b=BqOfVeHDLmfM9wcYf7DXlwNqRXvlJBQBthVlU+yXid1Zh9hqr/E4+b3IkugWDJtR8R2yszE7MIlaytSb6bSXaPbcc2JzPV/DKrBPr3dtrWY6EfgwWI9zgR9zPDNG4hblLeRg5AERAZ8+mhy7eQuB4S9OK6UAttpP6PeFUdPMILxq//mN+S3WdK9osXqA3L7lrhQiYVsOP4OS5AGdTtTR6BJlhipG2izs5p5oAkeuKSdypsyH4P+Y5BI1qVyrVsLG9K9Z6QNROTUdfo7WAEO9M1pMpHn3Zd8wSTzx9e6yZwqpc8vFYI/HbgsmSV/9AJjSwlhEo2aVqQJ7lFYZw/e49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OAUTij4pFrKn/KF5awrPZ5Wu0+gWpQcaBEZFUBac6Q=;
 b=B4aMtSI317imvk40vINTjoFgCsIUJBaGxUgA3/IJnYCpZ6y+uT9B9Y8MogyBwX3ruof++aBZtLw6+RD1b+vLz26Fv6c36dG9leVDbFFn1ossm4vDMrE0AV4F+AGHM15w+yDUofJtp/eRi8Whbhc2cMeI9Ejpvl5hwjbyrnVFv6A=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2352.namprd12.prod.outlook.com (2603:10b6:802:25::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Mon, 23 Aug
 2021 14:41:43 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::17c:7262:446:f400]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::17c:7262:446:f400%5]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 14:41:43 +0000
Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3
 test (v2)
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 Mike Lothian <mike@fireburn.co.uk>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Gao, Likun" <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210802051602.23822-1-guchun.chen@amd.com>
 <9b28973f-d71c-8ca1-32f3-e7dc23563a70@amd.com>
 <CAHbf0-HNwJvmv=D6KDQrNcmaCbtqj0cCZLgE9bWnSoMNBuqS+w@mail.gmail.com>
 <CADnq5_MtY6jHG+VUuuz_Wz2Ka9Tm7p+B-C37SQvwPhhAeLvcVw@mail.gmail.com>
 <DM5PR12MB24697A60CC00D98F946F753DF1C49@DM5PR12MB2469.namprd12.prod.outlook.com>
 <3bc094dc-c453-4b06-23ca-4b53e427c060@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <2e3f376e-b88b-867e-2dec-06bbe0029d7b@amd.com>
Date: Mon, 23 Aug 2021 10:41:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <3bc094dc-c453-4b06-23ca-4b53e427c060@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::46) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:305a:82c4:9c5:cbec]
 (2607:fea8:3edf:49b0:305a:82c4:9c5:cbec) by
 YTOPR0101CA0069.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Mon, 23 Aug 2021 14:41:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93193b65-90c4-497f-29c4-08d966441fc9
X-MS-TrafficTypeDiagnostic: SN1PR12MB2352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23529418DDC2E0D35FF93CCAEAC49@SN1PR12MB2352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPyPr386aNPc3kYU62fN3QLBpcKOUf5x/GxeNzipAvnky1zM81s9dtthcPxCdHdECNvSQZymq/zuzOIIDTda8BOTXrgjtqEHWd+eJqJ9hWdKh348X4nR6uIl9xC+kF2QYQmHOrlQb3/S0AkzzBBJvanLiD50KuZ6ylndYaGNEyO9QHjOSJwR1VaVxNOKkWJkMUW688VjzHOA9EWdN7F4O9GsA/Pi2iUG2nYLuSaFFOH8F7N0oWsroxa+LJspnxjt6MUHwlL8aLQ8N3jW8e+ijMnYO+oJYjJXNusWqi6UrdYVN5yssLD2FzrbnHHTnVnFtvxZOXb+MVMvthwOdI5A3raV8buAMNOmEFRB0rGBhZRaA5L+4JvxjFmp0svU6ZhdVAsORsjbS2eDT2azvNK/UY7w6ig96iHQJJ0MNzQI1HJ8Vpt89LK7lnIgfx8p6Sf8zZ+CFjODAQZiZ02xXynWdocWHLi/hIkZln+9A0HHoiuvkdOFAD1rul2ouBQ+VTUoEOLLX4TteZthmIst/J9uozeFFne7cfnITD6yqoEdW4Swi2iBUftPBnd5Tgml6azhdoG1AikuEY7WshpSS5uyeyCptMmoMVeZy6Pg6ZhKTCdfRgwQMBjX0s6M2mKf5zZDYrqD/jQwFuhvSi6QFtcMnxslXA5XB3cewbEBop5YWXsM1MBsjWRxBt/wAdJYYYRRGq1Ezc60xEnkcmGItPmva5e43f3MPb7l5zqWmOc0+T8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(186003)(8936002)(38100700002)(36756003)(31686004)(53546011)(6486002)(66556008)(8676002)(66476007)(66946007)(478600001)(4326008)(316002)(5660300002)(110136005)(54906003)(44832011)(2616005)(6636002)(86362001)(83380400001)(66574015)(2906002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3NhODZhNHRKN28yNVA4VnN0T0lQalY1WVBuVnlsNmJFTHFDMkR6R2lYRnBJ?=
 =?utf-8?B?TG1pN3BURkhEY3JmWkxNOHROanUxS0FBbUlUVno2L2EwbnRDU1FrYkNWQm1K?=
 =?utf-8?B?bDFFZEtpKzNLR1dhKzZ0enVDY1JiYml3eVNTZzNlbVQ2WDJwZjhWUkcwUHA4?=
 =?utf-8?B?ZFc3dmFFS0RlYUl2ZDVjaWVIK2lUQkF2b2Z0TkxuTVBRTVNFd1d5Q2NJZTlD?=
 =?utf-8?B?MG5KeEx0VGJIcU15NHJxUFF2a3VlQ0xWTnBaM2pTMkc3Ti9renJMdmdHc3Vl?=
 =?utf-8?B?T09QT2daREZRemtNTTNhR25CQlp0b0ZMTzBpajFSUEJwdjZpZTY2bUlzSFlv?=
 =?utf-8?B?QmQ0YnFOS3g4ZFduVnNzamx6N0JVTEtCdWpPSWJ4TGZWbDlkNHZwUWFtRFg3?=
 =?utf-8?B?MWxST0ljMVFvNkJEMHlodWZwVW5JM0tCa0dWdkdobzlLT05JelV1dkhLTXh6?=
 =?utf-8?B?WXVpOFJXVFFjODRqbGRuN01BNHYzUHR3RFZUOHhwcmkrUi9BVVduUzNKWUVo?=
 =?utf-8?B?VUZBbm1OQ3Q1Mnk5L2dHZStXQ1FPbjJmVFFHUW04R0dGYnl0aFc1NXhiSy92?=
 =?utf-8?B?T3Q4QU1xT0hrZVRxVHdCellEMFBncXBOcXJTSVVHOHh0YytnS0YzZ0NXUTJ6?=
 =?utf-8?B?QTNXbThpb0lDSVVGMklGZ3JWZmEyZExiMFFNeVFGQzJLdmJQSUdJK0YxSkNy?=
 =?utf-8?B?NUt2V0s1dGJmK2M4VjdJdkRTQU9ZU3Vpd2NrbGxlUWgxVmRPYlNjZkVybXBz?=
 =?utf-8?B?c1FlYXlyaXJJUlBDNG5UR2gvN2xndWlUR2ZVNHE2Sm41QnFiYWk5WjZweity?=
 =?utf-8?B?eU1BSEIwbFNNaFJPZ3cxbWNMVlFSRVUwUVRUcmpRYWtRWjh4TlYrbXpocGNW?=
 =?utf-8?B?ampzaWt4Umw0WUM1VkFNNW5XU000RktFbTZ6NFNZUzQvT3hTVUVLOEpndFU4?=
 =?utf-8?B?eVBIeG0rcXpPcnZMLzRnTW1KbHd1YWZWVU1JMm96b0ovSWRhaFFicGVCR0hK?=
 =?utf-8?B?amRUakNnTEllcnFsQnQ0Y1ZwcnNRSkc3MHhndzYyaVRnWmdVSE9kM1NZZ21w?=
 =?utf-8?B?UmhGcjN0WnhEK1VvZHZpMHdnd3VNc040OW5TVC9VcFNkT280Qk0vbjZGMDFL?=
 =?utf-8?B?UTdORkJkUW9kWDNkQkREcEl2MlI0cEFPMnJyMXFFOGJ5V0VhRkhKOEVsekp4?=
 =?utf-8?B?WUJqNTRKNkFxR2NSc2thV3BLa2lGRUhlRWFrMnE3dVVSWFk5bFcxUkJzempp?=
 =?utf-8?B?R1V4VGdCVXZpQ1liU3BvUkRxa3FrL1l3aFRaM3pOWC9uWE1VdUc3U0ZPWTdO?=
 =?utf-8?B?NHAxSGNpRzJxU0NLNUE0TXRwQ0pMcnRoaFNhMEZHbWVBaXNyWFF3QUFDUzFX?=
 =?utf-8?B?MTFxbkRIc21EYkpScm12Ym90TUQ3SHZBREFGWFErV0xwRzN5ZWc2RG12elFv?=
 =?utf-8?B?VzBwQzNvYzJFTmRPRTJ5eVhJNnUvcm5kZHJwRTg3d1I0NGRoczZQZDhpTFB0?=
 =?utf-8?B?THJWZStOSW40dmNxaUxqeExQZ0RJaTMyV29ucTBwdTQ5dzNjYkJUS056a3do?=
 =?utf-8?B?MGloQmZIOGpUS2cyNGoxMWRnMXQ2UktUcXRkWXFFNklDRGR5LzZ0bWZFS0Ri?=
 =?utf-8?B?VnA1bFMrSVNrMCtyUHdpdXQxaEpFdzZJRW9qWnNUMzZXUTlxRmVUblVLQ0ZX?=
 =?utf-8?B?Z3NFaHZkOEIrdW10ZmFpdmhCd1RxWTB3a0kwQkM2UlhQOXVTaFoxV3BRbXkr?=
 =?utf-8?B?LzZSWWNSblNRMHhqVkl5WFpsbHc5Mk4vdWt4T3A1S0kwd1Q3ekx3bm52Q2ky?=
 =?utf-8?B?T3NzMW9tQTQ4K29LTWh1c2JsMlB2UHoxV2pnYWlScmNGWjNNSnBoVXpLa2Zi?=
 =?utf-8?Q?PUiX0ttxzmdN0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93193b65-90c4-497f-29c4-08d966441fc9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 14:41:42.9670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apyw3hlTbNh+yqQosAAHyhpaXFHMdEmSQ/KY7I16Im1Qm5tE2pu87W2PLzvjL81fC+yslKcdQDG/q2KMysIfkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2352
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


On 2021-08-23 2:50 a.m., Christian König wrote:
> Good mornings guys,
>
> Andrey has a rather valid concern here, but I think we need to 
> approach this from a more high level view.
>
> When hw_fini is called we should make sure that the scheduler can't 
> submit any more work to the hardware, because the hw is finalized and 
> not expected to response any more.
>
> As far as I can see the cleanest approach would be to stop the 
> scheduler in hw_fini and fully clean it up in sw_fini. That would also 
> fit quite nicely with how GPU reset is supposed to work I think.
>
> Problem is that this is currently done outside of the fence code for 
> the at least the reset case, so before we restructure that we need to 
> stick with what we have.
>
> Andrey do you think it would be any problem if we stop the scheduler 
> manually in the hot plug case as well?


As long as it's 'parked' inside HW fini - meaning the thread submitting 
to HW is done I think it should cover hot unplug as well.

Andrey


>
> Thanks,
> Christian.
>
> Am 23.08.21 um 08:36 schrieb Chen, Guchun:
>> [Public]
>>
>> Hi Andrey,
>>
>> Thanks for your notice. The cause why moving drm_sched_fini to 
>> sw_fini is it's a SW behavior and part of SW shutdown, so hw_fini 
>> should not touch it. But if the race, that scheduler on the ring 
>> possibly keeps submitting jobs which causes un-empty ring is there, 
>> possibly we still need to call drm_sched_fini first in hw_fini to 
>> stop job submission first.
>>
>> @Koenig, Christian what's your opinion?
>>
>> Regards,
>> Guchun
>>
>> -----Original Message-----
>> From: Alex Deucher <alexdeucher@gmail.com>
>> Sent: Friday, August 20, 2021 2:13 AM
>> To: Mike Lothian <mike@fireburn.co.uk>
>> Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Chen, Guchun 
>> <Guchun.Chen@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>; 
>> Gao, Likun <Likun.Gao@amd.com>; Koenig, Christian 
>> <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; 
>> Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver 
>> fini in s3 test (v2)
>>
>> Please go ahead.  Thanks!
>>
>> Alex
>>
>> On Thu, Aug 19, 2021 at 8:05 AM Mike Lothian <mike@fireburn.co.uk> 
>> wrote:
>>> Hi
>>>
>>> Do I need to open a new bug report for this?
>>>
>>> Cheers
>>>
>>> Mike
>>>
>>> On Wed, 18 Aug 2021 at 06:26, Andrey Grodzovsky 
>>> <andrey.grodzovsky@amd.com> wrote:
>>>>
>>>> On 2021-08-02 1:16 a.m., Guchun Chen wrote:
>>>>> In amdgpu_fence_driver_hw_fini, no need to call drm_sched_fini to
>>>>> stop scheduler in s3 test, otherwise, fence related failure will
>>>>> arrive after resume. To fix this and for a better clean up, move
>>>>> drm_sched_fini from fence_hw_fini to fence_sw_fini, as it's part of
>>>>> driver shutdown, and should never be called in hw_fini.
>>>>>
>>>>> v2: rename amdgpu_fence_driver_init to amdgpu_fence_driver_sw_init,
>>>>> to keep sw_init and sw_fini paired.
>>>>>
>>>>> Fixes: cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequence
>>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>>> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 ++---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 12 +++++++-----
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  4 ++--
>>>>>    3 files changed, 11 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index b1d2dc39e8be..9e53ff851496 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -3646,9 +3646,9 @@ int amdgpu_device_init(struct amdgpu_device
>>>>> *adev,
>>>>>
>>>>>    fence_driver_init:
>>>>>        /* Fence driver */
>>>>> -     r = amdgpu_fence_driver_init(adev);
>>>>> +     r = amdgpu_fence_driver_sw_init(adev);
>>>>>        if (r) {
>>>>> -             dev_err(adev->dev, "amdgpu_fence_driver_init 
>>>>> failed\n");
>>>>> +             dev_err(adev->dev, "amdgpu_fence_driver_sw_init
>>>>> + failed\n");
>>>>>                amdgpu_vf_error_put(adev, 
>>>>> AMDGIM_ERROR_VF_FENCE_INIT_FAIL, 0, 0);
>>>>>                goto failed;
>>>>>        }
>>>>> @@ -3988,7 +3988,6 @@ int amdgpu_device_resume(struct drm_device 
>>>>> *dev, bool fbcon)
>>>>>        }
>>>>>        amdgpu_fence_driver_hw_init(adev);
>>>>>
>>>>> -
>>>>>        r = amdgpu_device_ip_late_init(adev);
>>>>>        if (r)
>>>>>                return r;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> index 49c5c7331c53..7495911516c2 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> @@ -498,7 +498,7 @@ int amdgpu_fence_driver_init_ring(struct 
>>>>> amdgpu_ring *ring,
>>>>>    }
>>>>>
>>>>>    /**
>>>>> - * amdgpu_fence_driver_init - init the fence driver
>>>>> + * amdgpu_fence_driver_sw_init - init the fence driver
>>>>>     * for all possible rings.
>>>>>     *
>>>>>     * @adev: amdgpu device pointer
>>>>> @@ -509,13 +509,13 @@ int amdgpu_fence_driver_init_ring(struct 
>>>>> amdgpu_ring *ring,
>>>>>     * amdgpu_fence_driver_start_ring().
>>>>>     * Returns 0 for success.
>>>>>     */
>>>>> -int amdgpu_fence_driver_init(struct amdgpu_device *adev)
>>>>> +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev)
>>>>>    {
>>>>>        return 0;
>>>>>    }
>>>>>
>>>>>    /**
>>>>> - * amdgpu_fence_driver_fini - tear down the fence driver
>>>>> + * amdgpu_fence_driver_hw_fini - tear down the fence driver
>>>>>     * for all possible rings.
>>>>>     *
>>>>>     * @adev: amdgpu device pointer
>>>>> @@ -531,8 +531,7 @@ void amdgpu_fence_driver_hw_fini(struct
>>>>> amdgpu_device *adev)
>>>>>
>>>>>                if (!ring || !ring->fence_drv.initialized)
>>>>>                        continue;
>>>>> -             if (!ring->no_scheduler)
>>>>> -                     drm_sched_fini(&ring->sched);
>>>>> +
>>>>>                /* You can't wait for HW to signal if it's gone */
>>>>>                if (!drm_dev_is_unplugged(&adev->ddev))
>>>>>                        r = amdgpu_fence_wait_empty(ring);
>>>>
>>>> Sorry for late notice, missed this patch. By moving drm_sched_fini
>>>> past amdgpu_fence_wait_empty a race is created as even after you
>>>> waited for all fences on the ring to signal the sw scheduler will
>>>> keep submitting new jobs on the ring and so the ring won't stay empty.
>>>>
>>>> For hot device removal also we want to prevent any access to HW past
>>>> PCI removal in order to not do any MMIO accesses inside the physical
>>>> MMIO range that no longer belongs to this device after it's removal
>>>> by the PCI core. Stopping all the schedulers prevents any MMIO
>>>> accesses done during job submissions and that why drm_sched_fini was
>>>> done as part of amdgpu_fence_driver_hw_fini and not
>>>> amdgpu_fence_driver_sw_fini
>>>>
>>>> Andrey
>>>>
>>>>> @@ -560,6 +559,9 @@ void amdgpu_fence_driver_sw_fini(struct 
>>>>> amdgpu_device *adev)
>>>>>                if (!ring || !ring->fence_drv.initialized)
>>>>>                        continue;
>>>>>
>>>>> +             if (!ring->no_scheduler)
>>>>> +                     drm_sched_fini(&ring->sched);
>>>>> +
>>>>>                for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
>>>>> dma_fence_put(ring->fence_drv.fences[j]);
>>>>>                kfree(ring->fence_drv.fences); diff --git
>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> index 27adffa7658d..9c11ced4312c 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> @@ -106,7 +106,6 @@ struct amdgpu_fence_driver {
>>>>>        struct dma_fence                **fences;
>>>>>    };
>>>>>
>>>>> -int amdgpu_fence_driver_init(struct amdgpu_device *adev);
>>>>>    void amdgpu_fence_driver_force_completion(struct amdgpu_ring
>>>>> *ring);
>>>>>
>>>>>    int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring, @@
>>>>> -115,9 +114,10 @@ int amdgpu_fence_driver_init_ring(struct 
>>>>> amdgpu_ring *ring,
>>>>>    int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
>>>>>                                   struct amdgpu_irq_src *irq_src,
>>>>>                                   unsigned irq_type);
>>>>> +void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>>>>>    void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
>>>>> +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
>>>>>    void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
>>>>> -void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>>>>>    int amdgpu_fence_emit(struct amdgpu_ring *ring, struct 
>>>>> dma_fence **fence,
>>>>>                      unsigned flags);
>>>>>    int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, 
>>>>> uint32_t *s,
>
