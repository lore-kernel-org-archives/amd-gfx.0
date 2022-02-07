Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09001C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 15:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98E6710E29C;
	Mon,  7 Feb 2022 15:00:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B1FB10E29C
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 15:00:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rmkuw/bubtTdf37ydBAiL+mpEQAS0RKDzmj61tNVyGH/sgPkq+BuDd8lRocUqYafyIjGN+iCN+Mc8U/F8Ztg8i4cSJP44Z203v0cu4y6FLt46QYM01AT24oUl/cnSOdWtQspdKUVihTLeXX4evJwZrrL92JJQdLimJen9xcfxrmo6An0SsDJ7qwchwin8sPgXqaT6PUiXMdtuDyEM5366buC4ttxaa6WbCP35nxBPMIoVnX3kAiA+mAxAwFNsSGtXzpyWy/bydgR2JyYDL/a2CXhA7ZVdUqk1LxtjC00b0yoTDNoZi4UeH8BqU3CgpV1iieBNBJ3+UnAlVDm0nzbng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTcypYGPN+H6ZBmWW91CGVdGu4Tvv/j4459sqcfvHbo=;
 b=l1NZp/cbGZXB6xyTA3KTy2aTvxQw1xhfpF0ObvWX4MXKwjD3oH4xQnniA4ilm02N7v7gcQX+n52IAiOEf3JoqS39Yi8z5yBvX4EWmLFCR/umC69JOzZ2PGEj+avws5nkUNW1VQygJXUvCjsdlu0Pf3XGCzYt0lIdGzXP6A4WVVCPswY9Af9+MOPuLk6xJDsLBuQh+y6mBhsFvGTQQoI2XSuyod34m52KxUXIe0vRZ/K6wpPkKTiegY0fhxN9qupuJ2oedrlnwhziGaXopUocsSI8jzhchSm68fsZQYLk1PkJW3rjgVM2O46jiFn4hRVfmc//RkP0s0ECeE7jZiZzBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTcypYGPN+H6ZBmWW91CGVdGu4Tvv/j4459sqcfvHbo=;
 b=2Nqr5GiOC0eIimHXyTdaq6oYdxjJNKtKvrvtyVpwP9rr11ZQ9OkGkaiRe7bkzlJeET8mVPXGDK38hero57hQVDAOKGsxnWx7D+XduBG1kNoadJCFX3/8s95jJZKQ8+znHnkOQhwzb4qJt9BXnIVwtXfHJP4b8/GKiwvnUMKYncg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by MWHPR1201MB2476.namprd12.prod.outlook.com (2603:10b6:300:de::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 15:00:14 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::144c:ceeb:e458:1424]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::144c:ceeb:e458:1424%4]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 15:00:13 +0000
Message-ID: <ec08555f-4e14-c74e-80d0-db8b101854c5@amd.com>
Date: Mon, 7 Feb 2022 10:00:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Vega20
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20220121161648.14729-1-jinhuieric.huang@amd.com>
 <CADnq5_MpZS7z7tjRXzXmGv7Dq6+O96a=89JY1TQ15=b7+bziKg@mail.gmail.com>
 <DM5PR12MB2469C8132EB95A22A8091EB8F12C9@DM5PR12MB2469.namprd12.prod.outlook.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <DM5PR12MB2469C8132EB95A22A8091EB8F12C9@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0070.namprd02.prod.outlook.com
 (2603:10b6:207:3d::47) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74d8970c-0635-47be-5aaf-08d9ea4a8b55
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2476:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2476D1DC19C8D5BF45D3FD4C822C9@MWHPR1201MB2476.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: md5jgMVvu8Jk3mByjiRX2n5uuX5D5X1Xq2WCbmpEf6G6QAFLiHE8nKiKpthR6JYez44ww0aLFwEy2QwE5okQqVQWBCzsz7LDe8KIhI0hNgNUoiJRaaBAkyk5rpLknipKv8tkj5hcEO2JKVbhdEG1K1ih+8CPPfcYxzflGaZ/ovVVuMC6OLzdHDi6wn3pO6L5nZB2DWc6oYBO7/BL16fhzOxtqoTRuRpsVCrcYdyxfUuD8eYH82YsaJPc2HOPnF8ESMxVyBfEpbK+ltMH1vw+36+KJZXTI3psN+UD8N62uGVQ+GRh6/w/PDb2yt6831D43rKB8Mgrb160kNInI5WzP0slkvdZTW5J+TzoQRRm3loI3r4MHiLrmu2NE3YL02kE2kH+E7QNW1N7fQs8f0u8sstAihwCm2rKeIDWETrtTUvZZpdhNkrQ5hwEmW2NXdYsx3FAhYRgn6G++JPSneM4M5J9VSRexO3AJD8DrsLqdKKAjRxlzGJ1p2ErlofLjEhELmVG0NXsSx5Tu2NYjfYVf+NkB85kYum2ro/L/04xtioCZB5Qe7FkOiJxAJJisjdLdh12xhRzMXhXv2oSTEzwxZsEM2dc3hWxaQXJoQrFq27z/e1Diot+zQ6AP3622Mds0D8s4kCkD7Anaxabv+RW0n3wXwh6gYC1NpnprVO/vHz4bafko71nKcYBB5lCjzEcpeLLg2J4CdW7fBAIBN5NutJpjWQ91CZvIs2CLhFSuazbD6Bh5FpuL2VuAs+qPDlaiFnzn/yqJB/Pxsl5PoPsAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(316002)(6666004)(66946007)(53546011)(6486002)(2906002)(508600001)(6512007)(6506007)(66476007)(66556008)(8676002)(8936002)(5660300002)(4326008)(86362001)(31696002)(38100700002)(36756003)(2616005)(186003)(83380400001)(31686004)(16393002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnZoQnVLaDgwdFlOT1VBTDMxR0MwT3ZjMTJZN2trSUF3ejlkbTVybGVtQzhv?=
 =?utf-8?B?UzBkdkc4cXRmekd1WW43RVB5WmpZYllld0dleXhkcEpCa1M5cFJCR0IwK0Qr?=
 =?utf-8?B?UkRRazY5ZGlPMENYclZwakxWcDh2RzFqRTlGTEYxcU1lN2V6ckVWQTR2S0hm?=
 =?utf-8?B?Z3RueTNvN09Qby9OZ2dYdi9rRkdnWVFmdlpwQU1jbmpxUys2cUNjdDVDb2Zw?=
 =?utf-8?B?ZVpmU3Y3NmJ1WmVqSVg5ZmxEK1JKTGZjVzZ0UzhFOWt0U01jbmJ3NEZWbGZl?=
 =?utf-8?B?UERFbTRPRVJLSU43UnhVbmpZK2xSWnQ5aGZXYW9UaGVVVEhOSVhPVkZ1TUcz?=
 =?utf-8?B?aWxsVWFSMXY0bUpQdHV2cUYreVFXQ2d0WHBLWUJlOWFveFlMdlQ5aGlpL3NO?=
 =?utf-8?B?SzcxckdQR1ora2xUSnBRaDIxZ3A4SmRzYjdJQVNhSXVITWN0UnVTdVI0aldt?=
 =?utf-8?B?V3NvUnI4Y1dUczdvMG1lY2hod3hJaFhDV214SnNzV3hFamE1NDcrWS94SWhK?=
 =?utf-8?B?Vm9iSHoxWTFWWGdnQVptNUtRTU5abDl5citBZmZqZjZoa05CVkVuMVlFcWtI?=
 =?utf-8?B?MDR6OWpEQklRMjVaM0xxcld6U2pSaTRTalczMmZ0aGtJbGUyTk5HTVcxVFhP?=
 =?utf-8?B?dzNvY2N6SEM2YWZqblpoZkd2cktKT2FIbXhFcmtlUmtPNHMxUWwwV2plMDRw?=
 =?utf-8?B?NFZ4VEdaYmlod0xtNmNWUVNNUW1NUDl5eVVNcG5UZXZuUktTUTlNMWpWMjFr?=
 =?utf-8?B?ZldLWGVMbFhWaWN2TFZWcElGaXNjTlZkR2N1aXhkWkl0QVNYZ1lveEFRemh1?=
 =?utf-8?B?cEdtMS9GMzc0ZU91TjNSWGhJWkYrSzQrSUtXQ3dmeHNkQ1BNaVltazQ2aE9L?=
 =?utf-8?B?V29Ya0JVOHFPY25IZW9XWjNiclljeGh1QS9qRGR0T2ZUdFQ1djhKeVpmRndl?=
 =?utf-8?B?bVpUQ2lKNHl4QnJPWHg0K05jQnlIS1gyRVgrbW96aGpMeXhlS2tKYWxZZ3FY?=
 =?utf-8?B?M0ZWZk9nc3VpcFZ1ZjBzT1NsR1R3WnAyc0hjVTFhVHNFdnNsRmxHcWJuQ0dK?=
 =?utf-8?B?WEZhS2QwMEx6TjNnZS9tbTl6M1g2UHNkMklyY2tyM0EzYVFhREFZRWczMzRR?=
 =?utf-8?B?UFNPb2lVSzRpeE82d3NLa2dmMWZyR255a216UFZwdHh4dHl3dUdkQUJUeEZY?=
 =?utf-8?B?bzdZd1BqWGs4ZjAxNXFUcHVPcmY5cjR5aEtKZDBGbGIvejY2L3FQbXhkUThI?=
 =?utf-8?B?SnMzYkwxR0dEcDM4RXVnS3l6TTJQTDB3RW5vZ0ltYko3aWt0MHRzanUzRDYw?=
 =?utf-8?B?eTdBN0hhWHBhYnRKZDhPdHZOMXFqYzlCOHkrWkgveFY3WVNuMUp6MGs1eHZ1?=
 =?utf-8?B?NHErTXNqS2lkOU5iUWw5RjN1UTJ2ckphenVhV0JMQXRYSXdoSEhSSG40VHBR?=
 =?utf-8?B?aGlqd291dVBEcUJxbWNuU1dVT1lNMUZtUVh3bDhJNXZPTUhJaERtTzVJNjZx?=
 =?utf-8?B?b3hIWWsxdktXWE5pMitEQVdJQzdHNHRQMFBreFJ3MXk4eDJKRXpjZGMvclo5?=
 =?utf-8?B?VHduREhDd0lmL0t2RFhxUzZwdmFnK3QxaS9vUy9jdVZrdkVYcVRVNDMzRGI2?=
 =?utf-8?B?cXg3V3o5TVhhWVRscnU2dG5mOVI1aUhjeTl1M2s4WnQ4d1BldXZIYVdWQmNo?=
 =?utf-8?B?aGpFR3VXeXZhRnVidFFwODQweTYzK1FZeEtBMjJ4WVo5YWlERWlXRktQK1pG?=
 =?utf-8?B?UmNNSit4bW91QUhjVWpoQjR1NVhpMFpzK2lETSt0cGM0Nkw3bExBblZZVVoy?=
 =?utf-8?B?dFlMODhXdVhpOFlyNTU0WUU5NWNyUDd3NVJFWDhyVzNTKzlaUmdGTHU5UzNW?=
 =?utf-8?B?YkRrc2x2dThSakRmOW5QQ0RsV3RqaWp4eUcyNHdldEh1S0xNZTFIRXVpdUE2?=
 =?utf-8?B?T0lCbFg5VHpWS3hrVUJjYnVZWFFYMU03MTRxNWxvbWIrM0M4bE1kUXBJTHds?=
 =?utf-8?B?SXVLeElnd3N3RlVDUkZCQk5wU2J3YVFYMlRzNUIvN0RCWUZBT1J2VDBraFhS?=
 =?utf-8?B?ZXY0SW5JVVpxQU43NU9YcTdVUk96enNLaUdnNDlQVVVaNWs2RmhBUXdURjNI?=
 =?utf-8?B?ZEV4U2lkWjdjdUx4dHh5dFlFOHhsalJ1UitJcXR2eGo2UmVDU1RCVm91aTd6?=
 =?utf-8?B?UTdWaDhzaEFzM01QVE4zSWQ2eklJUDdjTTZxNUdpaW16VXVKKzRXbmFOK1BC?=
 =?utf-8?Q?tnQ56Roc+576KgLo5u4C4n9v6v5PAg7qFWOgapnAvY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d8970c-0635-47be-5aaf-08d9ea4a8b55
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 15:00:13.8085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRb9UQ7JFl938iGhXPPur5AZHXE1E7C//nCKUx3D9b1aIOZ88oM6zbRG8Hv7wf66TnGm7UIOyLEJaNA5uiS1WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2476
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Guchun,

SDMA FW team confirms MI50/VG20 doesn't have the same bug as MI100, 
which cases asic hang issue when running RVS test. If this change makes 
KFDMemoryTest failed, please fill a Jira and assign to me.

Thanks,
Eric

On 2022-02-07 08:01, Chen, Guchun wrote:
> [Public]
>
> Hi Eric,
>
> Are you sure that there is no FW requirement for this patch on Vega20? KFDMemory test failed by this commit.
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
> Sent: Tuesday, January 25, 2022 4:08 AM
> To: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Vega20
>
> On Fri, Jan 21, 2022 at 11:17 AM Eric Huang <jinhuieric.huang@amd.com> wrote:
>> It is to meet the requirement for memory allocation optimization on
>> MI50.
>>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> Assuming there is no firmware version requirement, the patch is:
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 5b8ae0795c0a..d708f1a502cf 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1582,7 +1582,8 @@ static int kfd_ioctl_free_memory_of_gpu(struct
>> file *filep,  static bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev) {
>>          return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
>>                 (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
>> -               dev->adev->sdma.instance[0].fw_version >= 18);
>> +               dev->adev->sdma.instance[0].fw_version >= 18) ||
>> +               KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
>>   }
>>
>>   static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>> --
>> 2.25.1
>>

