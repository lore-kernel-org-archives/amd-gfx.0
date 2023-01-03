Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C5BC3DA7D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 10:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BDE910E3C6;
	Tue,  3 Jan 2023 10:00:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8198810E3C6
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 10:00:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPPSmluxJTaCZ13vny/QsFTdq9VKd9bEE+jGhBJNYyTaaHOxPz6I15oI6KhOBpXtuuCNVAdtnmODyna4cdXK1zATVWMo1ltnddzmX6NNYUttqbJwYVypI82bDNgVbIS1ARyHFHIniADTD9Omxv0q0WIHLwiAoma5sjRQfq8daYAVi+BIHP9BejTlbSrXGUBIW/BzArOG4PVQDmmS+33KrLFOoqFsOC7rBZIffk31PnKC8he+PTzEL1FhysEuXUlvPNCW0BW0zfTXcJyklh6JPDOt/2DQc2J69vts1jCltJZpf2T7oXGwuEFH7OqgsqjlHdsJMCmDP3FttzJ1fHFsmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSI4AnjmdtO7boCLbyuM4JGRKsZLz3Jy2zWT+XIkYYU=;
 b=PLcI7+wY8BbvtGEdH1VlYLoe2qlfYLfzatadp0DdsUNglQSvdJpidRNh6NGdWdPmlpJfaxw6/oGSBaG8OKj92IA3ygEP4RWitxxemPZFITNZTS/oGiLd/Fkwdr+szxG3Cf0OvSn61HwwKj7sIKo+wnG/s04S+AHNl4Utix9iZwAKVPy5fgVdfOBgQVwDwXLmU2SbqHhqlhM+jSszLSGRpdsftMwzvBdE20g9zIyyEzXXZE8bP4fN8D5QHji2qmxeHTQADIcmiUfYN/KDgyqx+h2k2lZjsxTngx56UTc+LhnNhcg0h0Nx2P/aQ99PhQB5zwFXx1On35pYJ6exYCEaHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSI4AnjmdtO7boCLbyuM4JGRKsZLz3Jy2zWT+XIkYYU=;
 b=FEz8Hdzg6uIdnrScCAxJrmHDnb3/UCBGBMq1Rj7Xy5BC0tloeavFBjP+5H8K2xgxe0/dLfkrMXPk0zGrm7hxSPuFuMfgq6jQ2tQtd8SiWwmjC6aDZp3MKP6eK0sNJGM2QNoSBs5IjF1c90nddguB7QXYH3Y6XnqfHpGeBTSPzvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 10:00:35 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367%5]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 10:00:35 +0000
Message-ID: <fdaeef41-cdab-e364-5d99-4366d05ead43@amd.com>
Date: Tue, 3 Jan 2023 11:00:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC 0/7] RFC: Usermode queue for AMDGPU driver
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <CADnq5_MuJdXE3CjuibmiW72bPFfAN1YCr20tUpayf9fnn+DXZQ@mail.gmail.com>
 <9a7aad24-e3f6-cffa-bf3d-e1ade6c9c29c@amd.com>
 <7f0343c1-ac6a-4966-89e6-95d3bc3d8056@gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <7f0343c1-ac6a-4966-89e6-95d3bc3d8056@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::15) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 34afff09-600b-4afe-0e37-08daed715b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBd5xX+x3mW+g/Q2anHlNKNFodqz1ntwPI8RxNn6kD0Nx90mVipy64daY0oPP+Uxv16wpRQr3A0zsNhcPirPvLgeyRag7dObMyOSwYKiFJfoYSSpiFgVeKPpkg8KZXlYJxuAwSFKHXcRd6WWBHJP+uhFgLvAwXuN9wMiLFEw6fqZ4ZVlDhVNujRKJDs1eHbHE7X1bgmDdq8D8lbuU/BSjhw5tdww7IxWbpFK4Z9OvbTF2LAWntsbLjMBcjVk2cOQWWVWGYTZE5N208Bq+fQBWRrMnzr0nZEVlvfhljQ6VXE5PdrXg3cvLs9LeQ9/xG2W6QEW+dE9x0VJX1TdnPf6EmK+3w3hmw61OO9fxfXvaLegmYj+tHoFHt9a6dezCe179RYHYLg1llT/W9sHzyURm0hJ6u+KdJOhTnAH1L0CguAf5zVaJz2s2luztcjdEBiDxeqIx254gef84p55F/nrUndChTJLraUrDc1N8FegjTdrDGl08Exfjc3sua0tgvChbsu+vyuBu5qKAdfvZVjOWM+gf9mna7Xu2KvRnpqnFYOD54anpOI7vjt8slvFHXNwRP2Wb9CNE+bc2IfeJCid8ADyl6H69uqGZGqfag/r6PWDfKLZRFrwsKgSBHzFSTLeRizQ+RmThgaafSpCdD93HoLCTyrh2xjAnyGNUaPSfzVkeaxM9f4fvVcKPLMQLYA1EV3gwBpBkz+CxWcpLTekkgeURM7WoB+JHSGH0Bbe7awx2uEFzSzY1D+HaRoxfIuX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199015)(41300700001)(31686004)(38100700002)(86362001)(8936002)(66946007)(66556008)(5660300002)(4326008)(66476007)(8676002)(83380400001)(2616005)(44832011)(6506007)(316002)(6486002)(2906002)(110136005)(53546011)(54906003)(6512007)(186003)(26005)(31696002)(36756003)(66574015)(478600001)(6666004)(22166006)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGV4REFtUFFuRFp1S042aUlUbGxwZkNlQWZNazR1QkpwTmVMRXBEY0lXZ1lX?=
 =?utf-8?B?dFptSmd4UWNiL2FNbzJLK2hzK0lZTDkvTVlqcEJwZmpkYURjeDM3amluSUxF?=
 =?utf-8?B?bmljOEtpeE8zK1gxWVc5MExXVDdDSTN2M3IxLzZqV2NZYmtnblVzS21zRmR4?=
 =?utf-8?B?RUhmT1dQdkk0WVJPbjYycHErbUlmTFlQeU81NnYvVWFjd1JwYkhWYTNiVWlk?=
 =?utf-8?B?WUxGeHZnNllrRlYzMERIVkxSS0hGelVQWG1JenlLUkI4WmFwWXZrdHpYOEtz?=
 =?utf-8?B?UUs5aFA0aFQyYlBoZkQ4VVRqRTlFbVc2NnBaOFloTlVrMzNqR3NXNHV3TVh3?=
 =?utf-8?B?U2MrQlVkcXJteUxvKzB5bnJiYU9IamRoTmJXVHFhMEJyamFmV0FRdldWSmhL?=
 =?utf-8?B?aG5uOXhXSkFmWWhlcy9uNlFKRGVWWjMyZ1pOMnU1TzBHZ1hjOWJlS3RhTWVv?=
 =?utf-8?B?WFJVWkNod0hxZ0NlbFBtYXhIL2wrN2pjZ0hlcHZzbW9KU1FCYTVIN2dDMnRq?=
 =?utf-8?B?cnNYS0prcWhhYVlIQzFHYVNzUkhrRWtlbGR4TjFZL01VL3hRLzNYMmUwN3Fm?=
 =?utf-8?B?S285bzVZS2pSd1NZZnQwbU1wbzBDUndrZGdwcHpyTC9nQWN4SGNqRlpIejVm?=
 =?utf-8?B?WXpuNEkxZTEwZE5WWXlJVUM4bTdwdlVOT2dCYjJCTUM4ZC9Gdno0OXZEYXpU?=
 =?utf-8?B?aXg3SGl2YWFlUEZBNVdxNVBPRGQrTHR4R3RyZGtrQTlQb3RmaGdsZGZCZGw1?=
 =?utf-8?B?ZDE3SjJ6b2pvejBwdjBrc0IwbFFsSWljSW1pVUQ4UklkY2NkSTJIZTJGeUxl?=
 =?utf-8?B?R0RXRXlTd2VoMUJNVGQxQTF0R1pncXIyQzdKSUtENXljR0I3QmZ5YXcydDNu?=
 =?utf-8?B?UHUwOW10R2xIeUlpRWZZVDBnT0JlZTczaGhLYktXdmF2aTQvQ3B5elJaeW5N?=
 =?utf-8?B?OFdPLzRPUUt0VlJiQ3piSFlCQ0QybkZYQ25PMkY0TXhLamJHYkhYN3g5dkJJ?=
 =?utf-8?B?RmtmOCsxMUx5ak9tMzhhRmdNUjl1RHFkTk9LcFpFdjErZ1cySXoxT0UrU01U?=
 =?utf-8?B?OTc5UGhjUzVWcEdxRUE3US9ZYzZUZHFNdHhLaGVUM1RDNDRLRTBIUTMyYUh3?=
 =?utf-8?B?K2dYT2VjaStyWVZXaXFtV3R4UUE2aFNRTm9ZS3VuRmt1NHYvRFNHWXcxQW1T?=
 =?utf-8?B?SWVYMmQwbHFiYWdKRU5RdktNaVFSM2hyVzNqdW9zeUlxOTVLc0J6aFNxRTVE?=
 =?utf-8?B?OFBoODZBbDVkdzNPbE1ycm9UWjdOTVZHQmFYVjJtUmp6WFBPcHYxVEpBRHRk?=
 =?utf-8?B?VnAzYmZPS0JmbDJvWkNkbUZHMmpBbWpISzFmZnBOdWx2ck5iSm10cUdKeUlF?=
 =?utf-8?B?K25MR1k4SlFsVmZIVkkwbVozSUt2bVdFTFNqMy8vR1A2Rmg5N2oybkFvRlFM?=
 =?utf-8?B?YzRBWHEzak51MWVGSzhGMkIyVFJNNTZvWlp2UENQSHBBT1dRVmlBcnNGMkV6?=
 =?utf-8?B?UUZlWlR2WEc3NnZ6cHQ4bnQrZzlPczhTcjY4OFFXNlhscGlNb3Ezek44TkhE?=
 =?utf-8?B?NkZBV0g0ZGhZV2NSTHZTdHJDWk15ZzlvaHc0ajFEUjNjSTQzWDZ1NFNwSTBC?=
 =?utf-8?B?NmZ4RVUwd3YxdzZqYVJMVXJoZ2hwbEpzZ1dDVXNOS29tdWYzbFNYblN4WG1B?=
 =?utf-8?B?cE9NRFUrekpXY29JbnJNTzNSS0twdkxTZGlNcG53RG1zNUI5UHYrL1hUZlRR?=
 =?utf-8?B?TG5oSG1Md3R2TlQwWUxUUEc0RzFlK2ZsNGx3MDF5QUNBS3NUNHJqOGpsaEh3?=
 =?utf-8?B?Z25McnJhbkNUVkVDZzQ5YS9SZ29HbEFZR3JxSUp3MDFJODJ6VWNCalpSaW94?=
 =?utf-8?B?UDBsaDZOdkMveDZkRXRXTVJCUU03eDUxTThGS2d1NVBIaWE5c2NxeTdwS0hi?=
 =?utf-8?B?UDNFa3F4ZEFnVVBGRmZudVNLL2pJSDNFbGc2anBibEJ3cUlubVorNm9sQzd2?=
 =?utf-8?B?bnVtT2ZoUXdRbFBleFdRM3U4bWZMbldXMUU3cDZMeUNDRFdWcFp0Q1NIcmt3?=
 =?utf-8?B?RVdOWVJESVR6cnh6Sks4eGpOaHZJUlBEbGNOelVmb3VCU3dSbGlMVWl2K3E4?=
 =?utf-8?Q?9DG3uC8mm+B9tPHr3nPDMUezI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34afff09-600b-4afe-0e37-08daed715b65
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 10:00:34.9751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjPtIkhqMAWc5J0TjE5NQBfvS6soGLNkli4YqtcLsc//ExlHZr75xNO6KZgXb6WjcTHIb0c6yjz6WULu9M3+cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 03/01/2023 10:47, Christian König wrote:
> Am 03.01.23 um 10:43 schrieb Shashank Sharma:
>>
>> On 29/12/2022 19:02, Alex Deucher wrote:
>>> On Fri, Dec 23, 2022 at 2:37 PM Shashank Sharma 
>>> <shashank.sharma@amd.com> wrote:
>>>> This is a RFC series to implement usermode graphics queues for AMDGPU
>>>> driver (Navi 3X and above). The idea of usermode graphics queue is to
>>>> allow direct workload submission from a userspace graphics process who
>>>> has amdgpu graphics context.
>>>>
>>>> Once we have some initial feedback on the design, we will publish a
>>>> follow up V1 series with a libdrm consumer test.
>>> I think this should look more like the following:
>>> 1. Convert doorbells to full fledged GEM objects just like vram.  Then
>>> update the GEM IOCTL to allow allocation of doorbell BOs.
>>> 2. Store MQD data per amdgpu_ctx.
>>
>> If my understanding of the comments is correct, we are having 
>> conflicting opinions here on where to save the MQD data. @Christian ?
>
> You need something like an amdgpu_userq object which holds the BO with 
> the MQD the hardware is using as well as anything else necessary for 
> the queue.

And we will be storing it into fpriv->amdgpu driver_private area 
(probably by using something like amdgpu_useq_mgr or similar), similar 
to amdgpu_ctx_mgr.

- Shashank

>
> Regards,
> Christian.
>
>>
>>> 3. Create secure semaphore pool and map RO into each GPUVM.
>>> 4. Add callbacks to each IP type that supports user mode queues.
>>> These callbacks should handle the IP specific MQD initialization and
>>> mapping/unmapping details including allocation of BOs for the MQD
>>> itself and any relevant metadata.  The USERQ IOCTL handler will look
>>> up the callback based on the IP type specified in the IOCTL.
>>
>> Noted.
>>
>> Shashank
>>
>>>
>>> Alex
>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>
>>>> Alex Deucher (1):
>>>>    drm/amdgpu: UAPI for user queue management
>>>>
>>>> Arunpravin Paneer Selvam (1):
>>>>    drm/amdgpu: Secure semaphore for usermode queue
>>>>
>>>> Arvind Yadav (1):
>>>>    drm/amdgpu: Create MQD for userspace queue
>>>>
>>>> Shashank Sharma (4):
>>>>    drm/amdgpu: Add usermode queue for gfx work
>>>>    drm/amdgpu: Allocate doorbell slot for user queue
>>>>    drm/amdgpu: Create context for usermode queue
>>>>    drm/amdgpu: Map userqueue into HW
>>>>
>>>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  14 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h       |   1 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 486 ++++++++++++++++
>>>>   .../amd/amdgpu/amdgpu_userqueue_secure_sem.c  | 245 ++++++++
>>>>   .../drm/amd/include/amdgpu_usermode_queue.h   |  68 +++
>>>>   .../amd/include/amdgpu_usermode_queue_mqd.h   | 544 
>>>> ++++++++++++++++++
>>>>   include/uapi/drm/amdgpu_drm.h                 |  52 ++
>>>>   8 files changed, 1413 insertions(+)
>>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>   create mode 100644 
>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_secure_sem.c
>>>>   create mode 100644 
>>>> drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>>>>   create mode 100644 
>>>> drivers/gpu/drm/amd/include/amdgpu_usermode_queue_mqd.h
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
>
