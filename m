Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC39C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 19:43:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F5660F5A
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 19:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 40F5660F5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C406789AB6;
	Wed, 27 Oct 2021 19:43:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 038106E560
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 19:43:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKCM8WncmrXngATxT3MVswrWgUWYw1V92CaW3iNZ1fuVnwhtkAC1MfxOdT8FdGCHnhB6JTpX+cqJsOdxQwWFnHq7nqNoa7dRFFmcT5Lb/YheUPMynVToIBgkr6KWrk/oSDZPl7n9B5hNtvdT1/eP5GuwIQqQ+ASRELT3wm+gp89FDxTUo9Gf7fojcmVO0J+fVDMq5cJ7ckmgQtXm2YhsPPZGxLh9rlM5ny5ImlbpOttXoMZJTp5+NYsoT+T2sirCc7oFe5cRUXJJ8qnem9a17Pp48VdZqbzg636GqvcXBSsGxBnuPEZf4JZbh542J1tvUgL4/G3FsBjN0GuaSay0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asc5RnnI8Uc3wUmP4K+DYx4ACcTHlGoG8YzagOCZdqg=;
 b=Aa/QUo0Z1dNXYsePkW65SC8i3XRFICblMSSF1hNq5mKBxyOBicFhmkQC8ArKQMkkjlW5hQZluSZziVRQ4sPej+nr/pZCuGdBU8QIzljZt/MrAhqdSOeIlEVKFuToaDFA3f50WiTNhQi817mel2mJUBLZWyDByFdfa216s5gXabIgazV4DumU+NONa3q3qvxCkHClRn8hcSV9cy5qa1edQcfO5yPhup8MTEyC6jmddeuEzhp1JIQMgS6yHzArvgnbL3BH60kJEOLMJ78KLPXEn109j9NnuBKfFepIJ8bgoIQaq7B8+WZpHrfiGs0TP74MQNOZIaGR/obWnDunM+YvkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asc5RnnI8Uc3wUmP4K+DYx4ACcTHlGoG8YzagOCZdqg=;
 b=V2d5nqQeANUTykSOfdO/Kso2hb+Y3qBv0hZEnYluCrULzvAUGrjvH3RuhiZ5VO72ZJll1tJtGQd0p+rhzy6c6nuc0rcqMtNyftUPpLOvV7Du9SyKolLwSMmd9D5QdHFcF33u0DWYpbbk+dGtS4LClvPrDbWbsl9jF15dA16IReg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1943.namprd12.prod.outlook.com (10.175.59.135) by
 CY4PR12MB1368.namprd12.prod.outlook.com (10.168.169.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14; Wed, 27 Oct 2021 19:43:25 +0000
Received: from CY4PR12MB1943.namprd12.prod.outlook.com
 ([fe80::28c0:a6b8:eb2f:5a79]) by CY4PR12MB1943.namprd12.prod.outlook.com
 ([fe80::28c0:a6b8:eb2f:5a79%9]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 19:43:25 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: fix potential bad job hw_fence underflow
To: jingwen.chen2@amd.com, amd-gfx@lists.freedesktop.org
Cc: monk.liu@amd.com, horace.chen@amd.com, christian.koenig@amd.com
References: <20211022033354.1318362-1-Jingwen.Chen2@amd.com>
 <f8a0000f-453c-82c0-f197-9030640cd52f@amd.com>
 <a96a2691-4e8b-8eb3-1566-f15301043adb@amd.com>
 <f2b72ae4-93ca-61c5-68cb-19b7fca4c063@amd.com>
 <fe55f902-1473-dc8d-3011-808fc93c7e5c@amd.com>
 <9df71fc3-9862-59c0-56d6-9e325d15192b@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <3c7449a2-a6ef-28a6-ca0a-7c749ca3f093@amd.com>
Date: Wed, 27 Oct 2021 15:43:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <9df71fc3-9862-59c0-56d6-9e325d15192b@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::35) To CY4PR12MB1943.namprd12.prod.outlook.com
 (2603:10b6:903:11b::7)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:9448:e1a0:ef19:2ba6]
 (2607:fea8:3edf:49b0:9448:e1a0:ef19:2ba6) by
 YT3PR01CA0117.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:85::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Wed, 27 Oct 2021 19:43:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26c07ab0-72cc-4c90-069f-08d999820a75
X-MS-TrafficTypeDiagnostic: CY4PR12MB1368:
X-Microsoft-Antispam-PRVS: <CY4PR12MB13680D83502F3AA718CACAE5EA859@CY4PR12MB1368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tTZtqSTzI0Ndk2TaXw4zEnTQzHHf4sIq5M8leq6CVqPHTErjXCVYHoVPp8epvY1Gc/XLbJF6y5yp2jV3hYqej163I1Oz4Pw2EjoLn904/iJbFJcxMSrhI0PN/03Nua7agEd+UPAmZIIgaN508OotI54aSxszr5kHM+scLIwOzV8infNFlDuCpmFg9WjpRvW38pvRI+/CIPOhTIMWbwpV63ouxqk08DYOOrLqNlqCxLpmxz5HTK7eZmvgmduNq/nzsbPKbetWkxD3+fTQzcC5nyC9RRlal6iF2oLBbIeF8RsNvrYPrm2GCeCPlB1yuNuu7OEU41m6RKqTrnjMiQOl+WlGj2jJ+Of8nVbL2v3hhlLkGS6NXYeSNse1kkMfUZ72TXpQkVRTzWv7mAiZrzJ9v7NVR5fJ1OTEZ6CL0ey92fNWTKH7BSDuOZKwWUIOzxfIjzw0cCgQ2vXpuEMvNg2JO74fRrtajhicB5NPw0r5k+Pj2b6Pr8IpWO6QTFHA4P9Ry22+L0ike/2zNRQCDaUwj9MKy5ZAKTV23PMyfe/Frmp3Ns24bT0finCgm+VUH2bZMD6lDglkOBd1oNKC8bQkw0A+n4yn6id1lGIS5/ien29cK7xe51R0fSSl9L6wAoV/Vwn8lzzvVGdyr7skI00v18RbVm/ahawGQ7pJo3N6ibVRFkRM65e+qR6h5/OzMoJnVaXXP7eUIKYoZsXG19h/iX42mX7qzith3PKWYsnYnRnRc3zGT6IW/7nEO7/g7LoMz/EKtTlUc0mtcT+XMVflLl5N1M3lse5c25xA8jS+SqQhQpxzIh0YHmcWvjbYaZ3w
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1943.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(31686004)(6486002)(66946007)(66476007)(316002)(66556008)(508600001)(53546011)(8676002)(83380400001)(186003)(4326008)(36756003)(5660300002)(31696002)(2906002)(8936002)(38100700002)(966005)(86362001)(4001150100001)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekhTNWVPRHdGQ0hVY0txeDhtR2E0RlQ5U3RFaDY4a1RnYm9QNmtjdjlDSDFu?=
 =?utf-8?B?ZlJIS29MZmZFNWdZS3NJSUtHZzJjcnRiNjBGTnZuTnFpUEY0cmYwUUQ0c2Nl?=
 =?utf-8?B?Y3pFYlhvb0FtcjJrMS9wUHFnZDdRN3N5Rmxack1OeEN1eWRtanlFeU9Temcy?=
 =?utf-8?B?Z2NOaHlDY01aSy9PcFU2OGlKcG9hL09teTlKQTRHeVY3N1RDUnFjS2REZGxr?=
 =?utf-8?B?WmwrU2xibFpqNVFUenh0bFptQUZpa0VKVCs2SG40a2FyUCt3K1U5MkRSNyth?=
 =?utf-8?B?clo4Rmg5TEMrSFBVNkZTNU9aM1JnaG1oSzhQakQxWHZROGVlYnd0djF5czlv?=
 =?utf-8?B?T1UxQUF6RHBXczFYeTNqVld5aUh2anlGTi9DZUQ5R0tmVXA2S3BhRUc2YzZM?=
 =?utf-8?B?dmQrQzlSYmRXZGR4WW94SWErUUhLOFR5R1R3bGw3QkhsekJzTTUxNW5JWEZC?=
 =?utf-8?B?elRvNzIwT2NWaGtsWmZ0RFpqd2N1MkZhcEdtQ0NlNmhLenFkeEpuWlcvZUpu?=
 =?utf-8?B?Mlg2UUdSeDR6Kzk5OUFsd25hb254cHJWZVplQ0o2VDVNc1lNWmZlN3dVbU45?=
 =?utf-8?B?UFM3TDMybE9xbGt1TlYrK2JlYVRuM2V3anIwRXphZyt2NVB1UVdVMXZnS3VV?=
 =?utf-8?B?ci9zUmtWN09JaWU3MUdsSjZ0MG9BSjlRbU5PT0c5SFNnKzNXdjlXQ3htWnk1?=
 =?utf-8?B?MENkYWN6TGhPYnB5dDZRcnFSVHo2ellqenFDaWxsZlpZUzFXMWRsM2R4QTg0?=
 =?utf-8?B?ckRyZ0tGUHV6RTN4NCs5eFN6YXZRYVlrYUZqRk5sUTFpakRBVERtSWJBVlV3?=
 =?utf-8?B?YUxEN1dvRGRzL1ErZk1yd3lWMHUyT2FkYlc2YXlPU3AxallVVVJqRnU5UEtw?=
 =?utf-8?B?YnNSMWJMcG5UZlo1UlQ1RzFQVk5hQ3Y5am40R2NiazAyak5iNUNBbUNBTk5B?=
 =?utf-8?B?QUs3N2tSdElCYjl4VWxvUW5NNUU1MGFsTWRZZkZtN2pRdEM5c3lVay9iZE1o?=
 =?utf-8?B?RUViaVJQUS9OY2prcGNXWU9pdDFGckMyZWFnU1VkR05DWk1jc25YejdSYVJY?=
 =?utf-8?B?NjIvWXV5QmdPdXVETWw0K0pDVzNMRTBNYk1WZnFWMGMvd1dOMDcwcnhrQ3JM?=
 =?utf-8?B?MFlIV1ppNjNsZ1B6T29TT3NMUG9wOTFEVmRqNSszMmtPVGdiY2ticlAxSUo5?=
 =?utf-8?B?aXdhaVdLRUdPTTFIdng0VHhxeHhyNElSNkxUZkNiZWptNU1QT0dyZHloRVFF?=
 =?utf-8?B?dXhzdmptSnM4M2Y0QzFoekRpV2hUdWpQWXhIQklkUUUwN1Q3Ni9hQXY0aEpE?=
 =?utf-8?B?UGRWV0FBQlFLQm4xaUxxVW1tdUJKaTI5R2RrSk5kYTdmMGZ3Q0M0aERacllG?=
 =?utf-8?B?Um9kU0psWTFMK1l0OWxCalV2VllDK1RuMUsxRG5MVm8wTjMxendJMjJpUmh5?=
 =?utf-8?B?cy9NNHBnZkJ6bmN2OWczTk1PczE1Qmw4WSsrNzhRbmpmQVhTTTRXbmlSd1dy?=
 =?utf-8?B?NVJDWnBFTllLVEtFYzZPazEyRytqNlZraG1XSFhYTkkyNDJjOUJrSFQ1OE5K?=
 =?utf-8?B?Ri8rUkxNMHBRTm5UOUUrMXVkNmFhR1M2WlhkRENyTkZkU2V3am5ua3Y0M0lz?=
 =?utf-8?B?aGlsTmlhenE3aE1waE5MbjBIZHR5Tll0bzhwOU44Wll5alZMbXNLRjZrMzAz?=
 =?utf-8?B?WWxVVTFEcDl4TkxieUwzb1o5QnFzQzhwWjJGL3RwWVZveGRnV2RRSlFiVGtU?=
 =?utf-8?B?cEc3YXJtSjRkdXZLN0gvRWhDb3YyWDdJVHVPSUJJaUJucDcyeEdBcmdTa2ds?=
 =?utf-8?B?d1NDd21FTm5xajYza1RQWmJUaU9jYnF3ZmwyUnNqVlcwMWJQREJsc0ptOU9j?=
 =?utf-8?B?eFEyRmo4a2UxSTF3TkVWb1JaaFh4N3FmR2hMZU9xWFB6bnloNXFkc1Q1ak96?=
 =?utf-8?B?ZVhVU0srTXdSSUM2ajZhOUZTcjhlOFVoL0VDQ3pYVkJEK014aGlIUnhpeHBD?=
 =?utf-8?B?c21CMVUzdXRGcTdLRWF0M2R2aThxUWtLYVZWbDl3aDhVNGdyWlU0Wk9qZ2Nz?=
 =?utf-8?B?bE04N2Z3TFNKWkdYT0pLTFQ0TDgwU292TnhPK2xtSkFSN1NoMkUxRThJelBO?=
 =?utf-8?B?ajZRMjJwRmJPaFJJNUg3YlFBRFRuNlFjb2d4blNhZ3lZTWFheDdhQ1BPbCtz?=
 =?utf-8?B?RFJiQ1o5NDlqWU1tUStDeHlzSDM0aXBSVEp6TXV4aEFPT093U05YNzNVbCti?=
 =?utf-8?Q?/Qsm8ste23KXbJD7DKCiCc87HRjH55K53x463BTUrU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c07ab0-72cc-4c90-069f-08d999820a75
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 19:43:25.1294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZlCMsBOkbTBfk5A3DiWf6Q4wLOi4Vb3pyGUIY1hqcmustndUb/BUH66McjAELAr+5zlrrJhrZRgAXNNziMjFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1368
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


On 2021-10-25 10:57 p.m., JingWen Chen wrote:
> On 2021/10/25 下午11:18, Andrey Grodzovsky wrote:
>> On 2021-10-24 10:56 p.m., JingWen Chen wrote:
>>> On 2021/10/23 上午4:41, Andrey Grodzovsky wrote:
>>>> What do you mean by underflow in this case ? You mean use after free because of extra dma_fence_put() ?
>>> yes
>>
>> Then maybe update the description  because 'underflow' is very confusing
>>
> will do
>>>> On 2021-10-22 4:14 a.m., JingWen Chen wrote:
>>>>> ping
>>>>>
>>>>> On 2021/10/22 AM11:33, Jingwen Chen wrote:
>>>>>> [Why]
>>>>>> In advance tdr mode, the real bad job will be resubmitted twice, while
>>>>>> in drm_sched_resubmit_jobs_ext, there's a dma_fence_put, so the bad job
>>>>>> is put one more time than other jobs.
>>>>>>
>>>>>> [How]
>>>>>> Adding dma_fence_get before resbumit job in
>>>>>> amdgpu_device_recheck_guilty_jobs and put the fence for normal jobs
>>>>>>
>>>>>> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>>>>>>     1 file changed, 4 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index 41ce86244144..975f069f6fe8 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -4841,6 +4841,9 @@ static void amdgpu_device_recheck_guilty_jobs(
>>>>>>               /* clear job's guilty and depend the folowing step to decide the real one */
>>>>>>             drm_sched_reset_karma(s_job);
>>>>>> +        /* for the real bad job, it will be resubmitted twice, adding a dma_fence_get
>>>>>> +         * to make sure fence is balanced */
>>>> But that put in drm_sched_resubmit_jobs_ext is for the previous parent fence.
>>>> fence = sched->ops->run_job(s_job); returns a new HW fence and the put drops the refcount on the old one.
>>>>
>>>> Andrey
>>>>
>>>>
>>> Hi Andrey,
>>>
>>> If I remember correctly, after we embedded the hw_fence into amdgpu_job, there will be not fence replacement in amdgpu_job_run.
>>
>> Right, I forgot that... What about removing line https://elixir.bootlin.com/linux/v5.15-rc6/source/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c#L265 ?
>> What if you make dma_get_fence unconditional instead ?
>>
>> Andrey
>>
>>
> Hi Andrey,
>
> I have tried this and this will cause normal jobs cannot be free(lacks a dma_fence_put).


I can't see it  - can you point me where in that case you get unbalanced 
refcount ? As far as I see for a a normal job
being ran in amdgpu_device_recheck_guilty_jobs the refcount on hw_fence 
is  -

drm_sched_resubmit_jobs_ext->dma_fence_put -> refcount decrease by 1
drm_sched_resubmit_jobs_ext->amdgpu_job_run->dma_fence_get increase by 1

In total refcount didn't change until now

Next,  dma_fence_wait_timeout completed successfully because the job is 
normal and then you delete that job from pending list and call the
free_job cb which drops remaining refcounts on the hw_fence.

I am probably missing some  dma_fence_get since you checked it on a 
device but I wonder where is my mistake ?

Andrey



> I have figured out all the get/put
>
> for sched_jobs and only the bad job lacks a dma_fence_get, other jobs are just fine.
>
>>>>>> +        dma_fence_get(s_job->s_fence->parent);
>>>>>>             drm_sched_resubmit_jobs_ext(&ring->sched, 1);
>>>>>>               ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched.timeout);
>>>>>> @@ -4876,6 +4879,7 @@ static void amdgpu_device_recheck_guilty_jobs(
>>>>>>               /* got the hw fence, signal finished fence */
>>>>>>             atomic_dec(ring->sched.score);
>>>>>> +        dma_fence_put(s_job->s_fence->parent);
>>>>>>             dma_fence_get(&s_job->s_fence->finished);
>>>>>>             dma_fence_signal(&s_job->s_fence->finished);
>>>>>>             dma_fence_put(&s_job->s_fence->finished);
