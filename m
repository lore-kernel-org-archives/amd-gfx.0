Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCBAC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 15:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D7E210FCBD;
	Thu, 14 Apr 2022 15:13:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6EB10FC5E
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 15:13:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhZPJ2NIW5Ye8PpGWXwAflenIebkeWHPLwdpaYQg/ovfSOhVNuGKzdQdy1vmZiOWEwCEd7kg2H+pkLKPzepiLaGyQQ2DidY7CardITSXdD7ZenSqv4pqLd6t6UJ27Sfu0Fpx4TAY/J0Mw4swuf/YTChgsdqLBMh5+RwpRmjkfKoG898o2+1aLnHk59L9jiAvr8c3oxI09wNXolBF6kFI+9vujwgOT8tSlk5f7PLhxCV9WRkdb2yDd/6W7Bgr8c1SQv6XvufxVs46MwEzI6unr6uxuCrKQeC/3xEF3w3Hoe6h+ELEXOVdM3xO7OfktKeAZZOGdUgrat7CWLZ8I2xNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jV69ySGOhYi6kYtYXbFNiYH7g33jgf/yB52NZ1yxBiY=;
 b=dCm/1NUvtrceNDLS/k2VvVw4w8Mw1s/ts2tKrn4wzrCiqu1pbuapDrudPcprsk3EwtxUNPzLQgiwV4jCzNV8EQQSp6CAvNT3BYJYAp+Dk5o0KVR10Ql1Yys6GWEhqMWlnUUsam9+jKcq6wP2Ojx0FWxPZZYxMB7kTDTZmf3yFpbHn69JnRzVtHQd8BAoWK8W10lcoOFgagaMIj9RK+ADjVF1Ko9OWo55BSON076rLx8n6PVPfvX1d/Qb+WSW1pJw5dBhdAyMhefjSHHSztwZY0I82ISeV1fqt5oQHIw7Nybmid3MpfRBBGWYBTzzyvRhrwkFcsdG+O8GK6rwrYwu0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jV69ySGOhYi6kYtYXbFNiYH7g33jgf/yB52NZ1yxBiY=;
 b=iR1voAtg+XqRNHfZFyOweCAs8zNGOW14BBrjvL8mJkB2f9ywX9UDmEmBRWgiDwym+5MrIpUfVfNeYkId2R89MPnvA2xedm0XJx/7wJ0esTGPHG4YyY14127Yh9zyb0IGKbmzekWkOmHZsnNS1bbBliV92GHtsWaPiinvdfJH5n4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BY5PR12MB3971.namprd12.prod.outlook.com (2603:10b6:a03:1a5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 15:13:18 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4%9]) with mapi id 15.20.5144.029; Thu, 14 Apr 2022
 15:13:18 +0000
Content-Type: multipart/alternative;
 boundary="------------WJR1QU8ceapkU4YTimBdjiqu"
Message-ID: <42927224-900a-8548-80c4-13cda4d3f867@amd.com>
Date: Thu, 14 Apr 2022 11:13:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [EXTERNAL] [PATCH 2/2] drm/amdkfd: Add PCIe Hotplug Support for
 AMDKFD
Content-Language: en-US
To: Shuotao Xu <shuotaoxu@microsoft.com>
References: <20220408084544.9313-1-shuotaoxu@microsoft.com>
 <20220408084544.9313-2-shuotaoxu@microsoft.com>
 <03483a49-5cfd-3e41-955e-e0e4dee78a74@amd.com>
 <08212428-471E-4C1C-9037-9AE16E9BA356@microsoft.com>
 <5c22aa65-f75d-bc05-e210-f28533d9f0f8@amd.com>
 <5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com>
 <c771861c-f25c-1953-3cb7-f805ddb11aa3@amd.com>
 <B7970589-ACF6-41F3-8622-1C0F705F3EE0@microsoft.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <B7970589-ACF6-41F3-8622-1C0F705F3EE0@microsoft.com>
X-ClientProxiedBy: CH2PR18CA0058.namprd18.prod.outlook.com
 (2603:10b6:610:55::38) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01468382-ea4d-4a8f-f6d7-08da1e294e0c
X-MS-TrafficTypeDiagnostic: BY5PR12MB3971:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB39715315728924BC136814A8EAEF9@BY5PR12MB3971.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z+hKR3ptmAkO9CUevnwx92td4bDgks4nFq0dz4XTwwfW+MzWt2a2wDTeXewPoum0562wwPtkSYjsvuNXlajjtT3tZ2XO6XD9R/8SgUg5QZSt8D4FJcv2atownctnNnX7RaxJMH3dY06sBMPJigprtzg2ro43I9VcVdqkr5jPIuSq3ZGYrAnJwHGy4LuMieh05jmrnbjhIzobuawv4rWXkmNrwnVDr6V17pxxdbYpqatAJsoqATwVNgD/Il+3WTzjhM5lk6UxLefRfcEvFvdfPv3yGn2skxptLCnay/ixfEySq7p0Md86+ZnKHkprJf2My7I9gAXcyryhN0Ap1ZmPlXT7AtsE5rjIhUvBytGV81RbXaAS27tP4jdUYVeYhMvCzRY+oLbBXO9lQ0GEkrnPf7qMu5P/dLyAczQGmgnSLIeW0QV3u16Pg4c/Z/XyI4UqrxkgQTUKPL0o9b/jChnRbUpeVCQiaNUFHn4SSDRLkeNLZrnUTmKQDZsLkF4wY3Jv6c8ZcuKX2xGHhMsItgP9EUqsZ3quqe/CJTkDJEHyTNoaES8NGJ2O8RAJHTTJm4aTi6zStj5h4AlGbRDGPNlOfW/ibvvL/lUjsUQ5YmbtleOWwKYg+22MxPzSLDM85h78YQdL2qmOu9MVAAeqYBsgg1VvvAaB6jo6bd8g8BNH74UMGsFOU+vE5sRnpBT0Io3lNLo5yd1ghj+M1dVd8r9LKcjJq5yOBRTnUOLF++NlCKa1YzGZV9mX6huihnQcaqirz8T12QEGL4EFpPQiQwOUSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(66476007)(166002)(44832011)(8936002)(30864003)(54906003)(66946007)(31686004)(6916009)(316002)(86362001)(508600001)(8676002)(4326008)(966005)(31696002)(5660300002)(6486002)(38100700002)(6512007)(6506007)(45080400002)(2906002)(33964004)(53546011)(186003)(36756003)(83380400001)(2616005)(45980500001)(43740500002)(579004)(559001)(10090945011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzlKM0tKZ1VFbElOeGlWK1pyTEtQTkxqaDhSYi9McXA3K3RSbXJlUHZieC9P?=
 =?utf-8?B?dTQvaGhySTZYMG5rdVluMnFDU3crRHByd3lEQ1NJUlpwYmtKSFNyR0JrSTlB?=
 =?utf-8?B?Z3VQQTNTZDlHcGJBVXA3alNRVEZZSFBpM09tK1RESkQxQnFBeVB0TFBiQ1RO?=
 =?utf-8?B?MlpOQjd5SS90dXZTdGRuWE5FQUh1YXhneHRRdDlZOGFrVHRLcFhkcG9MQlln?=
 =?utf-8?B?dGVMakdQN0ZRWDNDVUJ0QXNSM01iWTEyUnhwNnVLZFVpMjd1Y29VYjVEYk9G?=
 =?utf-8?B?dG0xZnJKOGt1NDJUZ3JhT2VxOGFSMHJOY1lCSlI4eWJIOWhlRkxVZ2tHc01s?=
 =?utf-8?B?MGhJb0ROVWpjTDJreGgwbUdyT1hodUlxS1ZTQy9IZ2NZSkJMTi9qSHovMmtM?=
 =?utf-8?B?c3d0aTJJR1JYRnJqRHJVTll4Nm9vSEZLN2UraGtQcmw5bFRMWkxqUFNuTzFm?=
 =?utf-8?B?K1JITWhnUGV4K0ZHVlNVdlN4WVRUb3ZEM09iTnI4WlJBYUthUVAxRmZFb09O?=
 =?utf-8?B?dXh0UWtXaFZEdlNtM201cXhnMUJnOUtRM1JyOHYwUE5ydGc1YmdFY0lLYVdh?=
 =?utf-8?B?SVFEY2Ira2phQXZxSEJLZVRoNGRxbXdxNzc0QWN3a2sxWXc0bW1mbFdsRnRy?=
 =?utf-8?B?OFVXL2w0YVJURWxGYmFQUWhzbXE5bUdCZnhzdk9KWkIrYktVeFIwaHBtTnJy?=
 =?utf-8?B?N2ZhY0MvQTVKNDBRd2dZdjBVM2NFVzhpSzYrZXVCM2k5dDlCZk8zVmREL0V4?=
 =?utf-8?B?RG9ZUGxyU1ROSFJVRm5hMDhoYTUydUY1RklHWXR4TkpRanZBZG15cnNuS1Ny?=
 =?utf-8?B?Vnk2QkpzNHdCUVVoWWR2cVN4WE9RR094VWRRa1hJOFRGSzYzcFpGZDlWTEtL?=
 =?utf-8?B?VlJBVEx6K05EUTVFbUE1bVNYamxweXJnUFpaZW9kVVdSSGlDOWFSYU5NdDha?=
 =?utf-8?B?dmdjMk1OZzU5NGV6WWhOTlp6RXliSm01cE5ZSytGenNFYU4rSGJiQzJ4bSsy?=
 =?utf-8?B?UThWeDZvNVVaODhUdXRwYkVNaXdmMS9qdC84dkhBeDNYS3BUeFE3WWlReUI5?=
 =?utf-8?B?aC9YM2Y0ZUpRZjJadC9iZXE5N1QwYmdiNG9sSW5MelFxSWhaeXU5YjNvTWd4?=
 =?utf-8?B?TlRsV0FQQ0VZT1hCNGh3elpPaEdURXc5QVYwRkt2QWpMR0pWUjlUYjhMbTI5?=
 =?utf-8?B?eDFSYkhOdnFpZmlkM0I0eG9jSk9XUDgyQWpPbDlJUmhHM2VvSWh2dlVDVUZv?=
 =?utf-8?B?Z1BYTUw1NkhjSENoSEd1KzVMQzdpMjZQNzVuL1Y1bTJxZyt0MEJVRE9JU3VE?=
 =?utf-8?B?S3dyWEN1cEl5enNaa1RleFplVDRaam5nUGxEM21DZDJDWFJEeUVnVXUwa0Iv?=
 =?utf-8?B?MS8vbTAwSWFyQnhJQmhtYUR1dlU2MjFMUUlVNmFEVm42aGtMTUJZQnczUElZ?=
 =?utf-8?B?VTkvMU5BbWVTc3NSeWhhRnFkZHdQRk9abDVYWjJQeWtnNnJDbHZFUjZjeVZz?=
 =?utf-8?B?RGtIaytZZ1lKSkg5OE16a2s4MnA0bkhCTXJkcHVsS2UwSithYmdxbnVIWHVE?=
 =?utf-8?B?YnZNYm5EenlEM095SkNEN1VRUVZEeEErMUJUbFVIaXhJSTVVM1lZZGlGZ2ps?=
 =?utf-8?B?b0dONm1SU21MeU9QeFI1Y1ZWSmNsbjcyMzZGYTJWeVp5M3Nodk5iQXlZeFQ4?=
 =?utf-8?B?dHZCYU9ackpTYkNPbHlXU21YU0pFWEQ3ejIwVG5xS0hYTGFjNlN1anRub1dB?=
 =?utf-8?B?bldBUUMrTGkwU0d2Qk8vemF6US9vNVdNZFZCV3pDOFFGd00vUWhhbVl2d2ZU?=
 =?utf-8?B?T1dYb1pFMTNQbW1SeWFyWW1qdk9zSXd3a2ZwN2h1ZzlPeGEzN0xEb3g2UTNr?=
 =?utf-8?B?bFZBRTZ5UDVRRHZ6dXY3UjBEeTFCYUozdDNpemJiSXJpUTNZYVdXWHJhOTUr?=
 =?utf-8?B?TXdUZXNiK2hSMW4yc0lqT3A3Y1NyMGwvQ0FDa1NZODNsTTI1QkRQVU9EUUVG?=
 =?utf-8?B?UzhNRW5GV3YxajRodVltU2lCaGZvUkJPUkVINkY1OFlJekpHQ3RzekoyK09t?=
 =?utf-8?B?ZlB0ZjNudktpbXFvL2ZxRVgxU1MrditoMVRMWGRQcmJPaTlSTENnaWd0dS8x?=
 =?utf-8?B?VEtNWjRDeDZEN3Y5QjBGbUtCeWVXcGJjUmx5RTF2NGtlc2o2QWRWUUJaaENL?=
 =?utf-8?B?MXozWDNjcVZMUERteHd5azNWYlFsNE14c2hmV2ZJQ1lveTdCN1U5Vjdldndo?=
 =?utf-8?B?QkhVa1FUT1luRWVJQkUxeXI1L0lKRVpHbGwybVR1SHBSZHBKZC80Ykl5UCtY?=
 =?utf-8?B?OXdLMFk0c3FFYU9IWHA3czlIZ3hvemlnNXcyZXJlUmVpV0pxVCt5ZlBaSzlS?=
 =?utf-8?Q?YaETUXOiH7hIDYpPjmaLrsCAvgp+cdXWn0b5gIbLvlUls?=
X-MS-Exchange-AntiSpam-MessageData-1: wEATGNDFcaOhtA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01468382-ea4d-4a8f-f6d7-08da1e294e0c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 15:13:18.0030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uyCwWo8eOYEJDp7v1tkma1e3WaT5gk8KzPhRknzMvlVywTNF6ouNru2YOZ304nQePJAUPXvRriuCRTOIK4RhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3971
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
Cc: "Mukul.Joshi@amd.com" <Mukul.Joshi@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, Peng Cheng <pengc@microsoft.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Lei Qu <Lei.Qu@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>,
 Ziyue Yang <Ziyue.Yang@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------WJR1QU8ceapkU4YTimBdjiqu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2022-04-14 10:00, Shuotao Xu wrote:
>
>
>> On Apr 14, 2022, at 1:31 AM, Andrey Grodzovsky 
>> <andrey.grodzovsky@amd.com> wrote:
>>
>>
>> On 2022-04-13 12:03, Shuotao Xu wrote:
>>>
>>>
>>>> On Apr 11, 2022, at 11:52 PM, Andrey Grodzovsky 
>>>> <andrey.grodzovsky@amd.com> wrote:
>>>>
>>>> [Some people who received this message don't often get email 
>>>> fromandrey.grodzovsky@amd.com. Learn why this is important 
>>>> athttp://aka.ms/LearnAboutSenderIdentification.]
>>>>
>>>> On 2022-04-08 21:28, Shuotao Xu wrote:
>>>>>
>>>>>> On Apr 8, 2022, at 11:28 PM, Andrey Grodzovsky 
>>>>>> <andrey.grodzovsky@amd.com> wrote:
>>>>>>
>>>>>> [Some people who received this message don't often get email from 
>>>>>> andrey.grodzovsky@amd.com. Learn why this is important at 
>>>>>> http://aka.ms/LearnAboutSenderIdentification.]
>>>>>>
>>>>>> On 2022-04-08 04:45, Shuotao Xu wrote:
>>>>>>> Adding PCIe Hotplug Support for AMDKFD: the support of hot-plug 
>>>>>>> of GPU
>>>>>>> devices can open doors for many advanced applications in data center
>>>>>>> in the next few years, such as for GPU resource
>>>>>>> disaggregation. Current AMDKFD does not support hotplug out b/o the
>>>>>>> following reasons:
>>>>>>>
>>>>>>> 1. During PCIe removal, decrement KFD lock which was incremented at
>>>>>>> the beginning of hw fini; otherwise kfd_open later is going to
>>>>>>> fail.
>>>>>> I assumed you read my comment last time, still you do same approach.
>>>>>> More in details bellow
>>>>> Aha, I like your fix:) I was not familiar with drm APIs so just 
>>>>> only half understood your comment last time.
>>>>>
>>>>> BTW, I tried hot-plugging out a GPU when rocm application is still 
>>>>> running.
>>>>> From dmesg, application is still trying to access the removed kfd 
>>>>> device, and are met with some errors.
>>>>
>>>>
>>>> Application us supposed to keep running, it holds the drm_device
>>>> reference as long as it has an open
>>>> FD to the device and final cleanup will come only after the app 
>>>> will die
>>>> thus releasing the FD and the last
>>>> drm_device reference.
>>>>
>>>>> Application would hang and not exiting in this case.
>>>>
>>>
>>> Actually I tried kill -7 $pid, and the process exists. The dmesg has 
>>> some warning though.
>>>
>>> [  711.769977] WARNING: CPU: 23 PID: 344 at 
>>> .../amdgpu-rocm5.0.2/src/amd/amdgpu/amdgpu_object.c:1336 
>>> amdgpu_bo_release_notify+0x150/0x160 [amdgpu]
>>> [  711.770528] Modules linked in: amdgpu(OE) amdttm(OE) 
>>> amd_sched(OE) amdkcl(OE) iommu_v2 nf_conntrack_netlink nfnetlink 
>>> xfrm_user xfrm_algo xt_addrtype br_netfilter xt_CHECKSUM 
>>> iptable_mangle xt_MASQUERADE iptable_nat nf_nat xt_conntrack 
>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 
>>> xt_tcpudp bridge stp llc ebtable_filter ebtables ip6table_filter 
>>> ip6_tables iptable_filter overlay binfmt_misc intel_rapl_msr i40iw 
>>> intel_rapl_common skx_edac nfit x86_pkg_temp_thermal 
>>> intel_powerclamp coretemp kvm_intel rpcrdma kvm sunrpc ipmi_ssif 
>>> ib_umad ib_ipoib rdma_ucm irqbypass rapl joydev acpi_ipmi input_leds 
>>> intel_cstate ipmi_si ipmi_devintf mei_me mei intel_pch_thermal 
>>> ipmi_msghandler ioatdma mac_hid lpc_ich dca acpi_power_meter 
>>> acpi_pad sch_fq_codel ib_iser rdma_cm iw_cm ib_cm iscsi_tcp 
>>> libiscsi_tcp libiscsi scsi_transport_iscsi pci_stub ip_tables 
>>> x_tables autofs4 btrfs blake2b_generic zstd_compress raid10 raid456 
>>> async_raid6_recov async_memcpy async_pq async_xor async_tx xor
>>> [  711.779359]  raid6_pq libcrc32c raid1 raid0 multipath linear 
>>> mlx5_ib ib_uverbs ib_core ast drm_vram_helper i2c_algo_bit 
>>> drm_ttm_helper ttm drm_kms_helper syscopyarea crct10dif_pclmul 
>>> crc32_pclmul ghash_clmulni_intel sysfillrect uas hid_generic 
>>> sysimgblt aesni_intel mlx5_core fb_sys_fops crypto_simd usbhid 
>>> cryptd drm i40e pci_hyperv_intf usb_storage glue_helper mlxfw hid 
>>> ahci libahci wmi
>>> [  711.779752] CPU: 23 PID: 344 Comm: kworker/23:1 Tainted: G       
>>>  W  OE     5.11.0+ #1
>>> [  711.779755] Hardware name: Supermicro 
>>> SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 2.1 08/14/2018
>>> [  711.779756] Workqueue: kfd_process_wq kfd_process_wq_release [amdgpu]
>>> [  711.779955] RIP: 0010:amdgpu_bo_release_notify+0x150/0x160 [amdgpu]
>>> [  711.780141] Code: e8 b5 af 34 f4 e9 1f ff ff ff 48 39 c2 74 07 0f 
>>> 0b e9 69 ff ff ff 4c 89 e7 e8 3c b4 16 00 e9 5c ff ff ff e8 a2 ce fd 
>>> f3 eb cf <0f> 0b eb cb e8 d7 02 34 f4 0f 1f 80 00 00 00 00 0f 1f 44 
>>> 00 00 55
>>> [  711.780143] RSP: 0018:ffffa8100dd67c30 EFLAGS: 00010282
>>> [  711.780145] RAX: 00000000ffffffea RBX: ffff89980e792058 RCX: 
>>> 0000000000000000
>>> [  711.780147] RDX: 0000000000000000 RSI: ffff89a8f9ad8870 RDI: 
>>> ffff89a8f9ad8870
>>> [  711.780148] RBP: ffffa8100dd67c50 R08: 0000000000000000 R09: 
>>> fffffffffff99b18
>>> [  711.780149] R10: ffffa8100dd67bd0 R11: ffffa8100dd67908 R12: 
>>> ffff89980e792000
>>> [  711.780151] R13: ffff89980e792058 R14: ffff89980e7921bc R15: 
>>> dead000000000100
>>> [  711.780152] FS:  0000000000000000(0000) GS:ffff89a8f9ac0000(0000) 
>>> knlGS:0000000000000000
>>> [  711.780154] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  711.780156] CR2: 00007ffddac6f71f CR3: 00000030bb80a003 CR4: 
>>> 00000000007706e0
>>> [  711.780157] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
>>> 0000000000000000
>>> [  711.780159] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
>>> 0000000000000400
>>> [  711.780160] PKRU: 55555554
>>> [  711.780161] Call Trace:
>>> [  711.780163]  ttm_bo_release+0x2ae/0x320 [amdttm]
>>> [  711.780169]  amdttm_bo_put+0x30/0x40 [amdttm]
>>> [  711.780357]  amdgpu_bo_unref+0x1e/0x30 [amdgpu]
>>> [  711.780543]  amdgpu_gem_object_free+0x8b/0x160 [amdgpu]
>>> [  711.781119]  drm_gem_object_free+0x1d/0x30 [drm]
>>> [  711.781489]  amdgpu_amdkfd_gpuvm_free_memory_of_gpu+0x34a/0x380 
>>> [amdgpu]
>>> [  711.782044]  kfd_process_device_free_bos+0xe0/0x130 [amdgpu]
>>> [  711.782611]  kfd_process_wq_release+0x286/0x380 [amdgpu]
>>> [  711.783172]  process_one_work+0x236/0x420
>>> [  711.783543]  worker_thread+0x34/0x400
>>> [  711.783911]  ? process_one_work+0x420/0x420
>>> [  711.784279]  kthread+0x126/0x140
>>> [  711.784653]  ? kthread_park+0x90/0x90
>>> [  711.785018]  ret_from_fork+0x22/0x30
>>> [  711.785387] ---[ end trace d8f50f6594817c84 ]---
>>> [  711.798716] [drm] amdgpu: ttm finalized
>>
>>
>> So it means the process was stuck in some wait_event_killable (maybe 
>> here drm_sched_entity_flush) - you can try 
>> 'cat/proc/$process_pid/stack' maybe before
>> you kill it to see where it was stuck so we can go from there.
>>
>>
>>>
>>>>
>>>> For graphic apps what i usually see is a crash because of sigsev when
>>>> the app tries to access
>>>> an unmapped MMIO region on the device. I haven't tested for compute
>>>> stack and so there might
>>>> be something I haven't covered. Hang could mean for example waiting 
>>>> on a
>>>> fence which is not being
>>>> signaled - please provide full dmesg from this case.
>>>>
>>>>>
>>>>> Do you have any good suggestions on how to fix it down the line? 
>>>>> (HIP runtime/libhsakmt or driver)
>>>>>
>>>>> [64036.631333] amdgpu: amdgpu_vm_bo_update failed
>>>>> [64036.631702] amdgpu: validate_invalid_user_pages: update PTE failed
>>>>> [64036.640754] amdgpu: amdgpu_vm_bo_update failed
>>>>> [64036.641120] amdgpu: validate_invalid_user_pages: update PTE failed
>>>>> [64036.650394] amdgpu: amdgpu_vm_bo_update failed
>>>>> [64036.650765] amdgpu: validate_invalid_user_pages: update PTE failed
>>>>
>>>
>>> The full dmesg will just the repetition of those two messages,
>>> [186885.764079] amdgpu 0000:43:00.0: amdgpu: amdgpu: finishing device.
>>> [186885.766916] [drm] free PSP TMR buffer
>>> [186893.868173] amdgpu: amdgpu_vm_bo_update failed
>>> [186893.868235] amdgpu: validate_invalid_user_pages: update PTE failed
>>> [186893.876154] amdgpu: amdgpu_vm_bo_update failed
>>> [186893.876190] amdgpu: validate_invalid_user_pages: update PTE failed
>>> [186893.884150] amdgpu: amdgpu_vm_bo_update failed
>>> [186893.884185] amdgpu: validate_invalid_user_pages: update PTE failed
>>>
>>>>
>>>> This just probably means trying to update PTEs after the physical 
>>>> device
>>>> is gone - we usually avoid this by
>>>> first trying to do all HW shutdowns early before PCI remove completion
>>>> but when it's really tricky by
>>>> protecting HW access sections with drm_dev_enter/exit scope.
>>>>
>>>> For this particular error it would be the best to flush
>>>> info->restore_userptr_work before the end of
>>>> amdgpu_pci_remove (rejecting new process creation and calling
>>>> cancel_delayed_work_sync(&process_info->restore_userptr_work) for all
>>>> running processes)
>>>> somewhere in amdgpu_pci_remove.
>>>>
>>> I tried something like *kfd_process_ref_release* which I think did 
>>> what you described, but it did not work.
>>
>>
>> I don't see how kfd_process_ref_release is the same as I mentioned 
>> above, what i meant is calling the code above within kgd2kfd_suspend 
>> (where you tried to call kfd_kill_all_user_processes bellow)
>>
> Yes, you are right. It was not called by it.
>>
>>
>>>
>>> Instead I tried to kill the process from the kernel, but the amdgpu 
>>> could **only** be hot-plugged in back successfully only if there was 
>>> no rocm kernel running when it was plugged out. If not, amdgpu_probe 
>>> will just hang later. (Maybe because amdgpu was plugged out while 
>>> running state, it leaves a bad HW state which causes probe to hang).
>>
>>
>> We usually do asic_reset during probe to reset all HW state (checlk 
>> if amdgpu_device_init->amdgpu_asic_reset is running when you  plug 
>> back).
>>
> OK
>>
>>
>>>
>>> I don’t know if this is a viable solution worth pursuing, but I 
>>> attached the diff anyway.
>>>
>>> Another solution could be let compute stack user mode detect a 
>>> topology change via generation_count change, and abort gracefully there.
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> index 4e7d9cb09a69..79b4c9b84cd0 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> @@ -697,12 +697,15 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool 
>>> run_pm, bool force)
>>>                 return;
>>>
>>>         /* for runtime suspend, skip locking kfd */
>>> -       if (!run_pm) {
>>> +       if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
>>>                 /* For first KFD device suspend all the KFD processes */
>>>                 if (atomic_inc_return(&kfd_locked) == 1)
>>> kfd_suspend_all_processes(force);
>>>         }
>>>
>>> +       if (drm_dev_is_unplugged(kfd->ddev))
>>> + kfd_kill_all_user_processes();
>>> +
>>> kfd->dqm->ops.stop(kfd->dqm);
>>>         kfd_iommu_suspend(kfd);
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 55c9e1922714..84cbcd857856 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -1065,6 +1065,7 @@ void kfd_unref_process(struct kfd_process *p);
>>>  int kfd_process_evict_queues(struct kfd_process *p, bool force);
>>>  int kfd_process_restore_queues(struct kfd_process *p);
>>>  void kfd_suspend_all_processes(bool force);
>>> +void kfd_kill_all_user_processes(void);
>>>  /*
>>>   * kfd_resume_all_processes:
>>>   *     bool sync: If kfd_resume_all_processes() should wait for the
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index 6cdc855abb6d..fb0c753b682c 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -2206,6 +2206,24 @@ void kfd_suspend_all_processes(bool force)
>>> srcu_read_unlock(&kfd_processes_srcu, idx);
>>>  }
>>>
>>> +
>>> +void kfd_kill_all_user_processes(void)
>>> +{
>>> +       struct kfd_process *p;
>>> +       struct amdkfd_process_info *p_info;
>>> +       unsigned int temp;
>>> +       int idx = srcu_read_lock(&kfd_processes_srcu);
>>> +
>>> +       pr_info("Killing all processes\n");
>>> + hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>> +               p_info = p->kgd_process_info;
>>> +               pr_info("Killing  processes, pid = %d", 
>>> pid_nr(p_info->pid));
>>> +               kill_pid(p_info->pid, SIGBUS, 1);
>>
>>
>> From looking into kill_pid I see it only sends a signal but doesn't 
>> wait for completion, it would make sense to wait for completion here. 
>> In any case I would actually try to put here
>>
> I have made a version which does that with some atomic counters. 
> Please read later in the diff.
>>
>>
>> hash_for_each_rcu(p_info)
>>     cancel_delayed_work_sync(&p_info->restore_userptr_work)
>>
>> instead at least that what i meant in the previous mail.
>>
> I actually tried that earlier, and it did not work. Application still 
> keeps running, and you have to send a kill to the user process.
>
> I have made the following version. It waits for processes to terminate 
> synchronously after sending SIGBUS. After that it does the real work 
> of amdgpu_pci_remove.
> However, it hangs at amdgpu_device_ip_fini_early when it is trying to 
> deinit ip_block 6 <sdma_v4_0> 
> (https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L2818 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux%2F-%2Fblob%2Famd-staging-drm-next%2Fdrivers%2Fgpu%2Fdrm%2Famd%2Famdgpu%2Famdgpu_device.c%23L2818&data=04%7C01%7Candrey.grodzovsky%40amd.com%7C37a2503747384d07944608da1e1f37ee%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637855416726313174%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=FBdaleltc3PbJRmaWr8D3gxU7zuZ7n%2Bcu7J2yUrzD1I%3D&reserved=0>). 
> I assume that there are still some inflight dma, therefore fini of 
> this ip block thus hangs?
>
> The following is an excerpt of the dmesg: please excuse for putting my 
> own pr_info, but I hope you get my point of where it hangs.
>
> [  392.344735] amdgpu: all processes has been fully released
> [  392.346557] amdgpu: amdgpu_acpi_fini done
> [  392.346568] amdgpu 0000:b3:00.0: amdgpu: amdgpu: finishing device.
> [  392.349238] amdgpu: amdgpu_device_ip_fini_early enter ip_blocks = 9
> [  392.349248] amdgpu: Free mem_obj = 000000007bf54275, range_start = 
> 14, range_end = 14
> [  392.350299] amdgpu: Free mem_obj = 00000000a85bc878, range_start = 
> 12, range_end = 12
> [  392.350304] amdgpu: Free mem_obj = 00000000b8019e32, range_start = 
> 13, range_end = 13
> [  392.350308] amdgpu: Free mem_obj = 000000002d296168, range_start = 
> 4, range_end = 11
> [  392.350313] amdgpu: Free mem_obj = 000000001fc4f934, range_start = 
> 0, range_end = 3
> [  392.350322] amdgpu: amdgpu_amdkfd_suspend(adev, false) done
> [  392.350672] amdgpu: hw_fini of IP block[8] <jpeg_v2_5> done 0
> [  392.350679] amdgpu: hw_fini of IP block[7] <vcn_v2_5> done 0


I just remembered that the idea to actively kill and wait for running 
user processes during unplug was rejected
as a bad idea in the first iteration of unplug work I did (don't 
remember why now, need to look) so this is a no go.
Our policy is to let zombie processes (zombie in a sense that the 
underlying device is gone) live as long as they want
(as long as you able to terminate them - which you do, so that ok)
and the system should finish PCI remove gracefully and be able to hot 
plug back the device.  Hence, i suggest dropping
this direction of forcing all user processes to be killed, confirm you 
have graceful shutdown and remove of device
from PCI topology and then concentrate on why when you plug back it 
hangs. First confirm if ASIC reset happens on
next init. Second please confirm if the timing you kill manually the 
user process has impact on whether you have a hang
on next plug back (if you kill before or you kill after plug back does 
it makes a difference).

Andrey


>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 8fa9b86ac9d2..c0b27f722281 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -188,6 +188,12 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device 
> *adev,
> kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
>  }
> +void amdgpu_amdkfd_kill_all_processes(struct amdgpu_device *adev)
> +{
> +if (adev->kfd.dev)
> +kgd2kfd_kill_all_user_processes(adev->kfd.dev);
> +}
> +
>  void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
>  {
> if (adev->kfd.dev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 27c74fcec455..f4e485d60442 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -141,6 +141,7 @@ struct amdkfd_process_info {
>  int amdgpu_amdkfd_init(void);
>  void amdgpu_amdkfd_fini(void);
> +void amdgpu_amdkfd_kill_all_processes(struct amdgpu_device *adev);
>  void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
>  int amdgpu_amdkfd_resume_iommu(struct amdgpu_device *adev);
>  int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm, 
> bool sync);
> @@ -405,6 +406,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
> const struct kgd2kfd_shared_resources *gpu_resources);
>  void kgd2kfd_device_exit(struct kfd_dev *kfd);
>  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm, bool force);
> +void kgd2kfd_kill_all_user_processes(struct kfd_dev *kfd);
>  int kgd2kfd_resume_iommu(struct kfd_dev *kfd);
>  int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm, bool sync);
>  int kgd2kfd_pre_reset(struct kfd_dev *kfd);
> @@ -443,6 +445,9 @@ static inline void kgd2kfd_suspend(struct kfd_dev 
> *kfd, bool run_pm, bool force)
>  {
>  }
> +void kgd2kfd_kill_all_user_processes(struct kfd_dev *kfd){
> +}
> +
>  static int __maybe_unused kgd2kfd_resume_iommu(struct kfd_dev *kfd)
>  {
> return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 3d5fc0751829..af6fe5080cfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2101,6 +2101,9 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>  {
> struct drm_device *dev = pci_get_drvdata(pdev);
> +/* kill all kfd processes before drm_dev_unplug */
> +amdgpu_amdkfd_kill_all_processes(drm_to_adev(dev));
> +
>  #ifdef HAVE_DRM_DEV_UNPLUG
> drm_dev_unplug(dev);
>  #else
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 5504a18b5a45..480c23bef5e2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -691,6 +691,12 @@ bool kfd_is_locked(void)
> return  (atomic_read(&kfd_locked) > 0);
>  }
> +inline void kgd2kfd_kill_all_user_processes(struct kfd_dev* dev)
> +{
> +kfd_kill_all_user_processes();
> +}
> +
> +
>  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm, bool force)
>  {
> if (!kfd->init_complete)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 55c9e1922714..a35a2cb5bb9f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1064,6 +1064,7 @@ static inline struct kfd_process_device 
> *kfd_process_device_from_gpuidx(
>  void kfd_unref_process(struct kfd_process *p);
>  int kfd_process_evict_queues(struct kfd_process *p, bool force);
>  int kfd_process_restore_queues(struct kfd_process *p);
> +void kfd_kill_all_user_processes(void);
>  void kfd_suspend_all_processes(bool force);
>  /*
>   * kfd_resume_all_processes:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 6cdc855abb6d..17e769e6951d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -46,6 +46,9 @@ struct mm_struct;
>  #include "kfd_trace.h"
>  #include "kfd_debug.h"
> +static atomic_t kfd_process_locked = ATOMIC_INIT(0);
> +static atomic_t kfd_inflight_kills = ATOMIC_INIT(0);
> +
>  /*
>   * List of struct kfd_process (field kfd_process).
>   * Unique/indexed by mm_struct*
> @@ -802,6 +805,9 @@ struct kfd_process *kfd_create_process(struct 
> task_struct *thread)
> struct kfd_process *process;
> int ret;
> +if ( atomic_read(&kfd_process_locked) > 0 )
> +return ERR_PTR(-EINVAL);
> +
> if (!(thread->mm && mmget_not_zero(thread->mm)))
> return ERR_PTR(-EINVAL);
> @@ -1126,6 +1132,10 @@ static void kfd_process_wq_release(struct 
> work_struct *work)
> put_task_struct(p->lead_thread);
> kfree(p);
> +
> +if ( atomic_read(&kfd_process_locked) > 0 ){
> +atomic_dec(&kfd_inflight_kills);
> +}
>  }
>  static void kfd_process_ref_release(struct kref *ref)
> @@ -2186,6 +2196,35 @@ static void restore_process_worker(struct 
> work_struct *work)
> pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
>  }
> +void kfd_kill_all_user_processes(void)
> +{
> +struct kfd_process *p;
> +/* struct amdkfd_process_info *p_info; */
> +unsigned int temp;
> +int idx;
> +atomic_inc(&kfd_process_locked);
> +
> +idx = srcu_read_lock(&kfd_processes_srcu);
> +pr_info("Killing all processes\n");
> +hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
> +dev_warn(kfd_device,
> +"Sending SIGBUS to process %d (pasid 0x%x)",
> +p->lead_thread->pid, p->pasid);
> +send_sig(SIGBUS, p->lead_thread, 0);
> +atomic_inc(&kfd_inflight_kills);
> +}
> +srcu_read_unlock(&kfd_processes_srcu, idx);
> +
> +while ( atomic_read(&kfd_inflight_kills) > 0 ){
> +dev_warn(kfd_device,
> +"kfd_processes_table is not empty, going to sleep for 10ms\n");
> +msleep(10);
> +}
> +
> +atomic_dec(&kfd_process_locked);
> +pr_info("all processes has been fully released");
> +}
> +
>  void kfd_suspend_all_processes(bool force)
>  {
> struct kfd_process *p;
>
>
>
> Regards,
> Shuotao
>
>> Andrey
>>
>>> +       }
>>> + srcu_read_unlock(&kfd_processes_srcu, idx);
>>> +}
>>> +
>>> +
>>>  int kfd_resume_all_processes(bool sync)
>>>  {
>>>         struct kfd_process *p;
>>>
>>>
>>>> Andrey
>>>>
>>>>
>>>>>
>>>>> Really appreciate your help!
>>>>>
>>>>> Best,
>>>>> Shuotao
>>>>>
>>>>>>> 2. Remove redudant p2p/io links in sysfs when device is hotplugged
>>>>>>> out.
>>>>>>>
>>>>>>> 3. New kfd node_id is not properly assigned after a new device is
>>>>>>> added after a gpu is hotplugged out in a system. libhsakmt will
>>>>>>> find this anomaly, (i.e. node_from != <dev node id> in iolinks),
>>>>>>> when taking a topology_snapshot, thus returns fault to the rocm
>>>>>>> stack.
>>>>>>>
>>>>>>> -- This patch fixes issue 1; another patch by Mukul fixes issues 
>>>>>>> 2&3.
>>>>>>> -- Tested on a 4-GPU MI100 gpu nodes with kernel 5.13.0-kfd; kernel
>>>>>>> 5.16.0-kfd is unstable out of box for MI100.
>>>>>>> ---
>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 +++++
>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 7 +++++++
>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>>>>>>> drivers/gpu/drm/amd/amdkfd/kfd_device.c | 13 +++++++++++++
>>>>>>> 4 files changed, 26 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>> index c18c4be1e4ac..d50011bdb5c4 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>> @@ -213,6 +213,11 @@ int amdgpu_amdkfd_resume(struct 
>>>>>>> amdgpu_device *adev, bool run_pm)
>>>>>>> return r;
>>>>>>> }
>>>>>>>
>>>>>>> +int amdgpu_amdkfd_resume_processes(void)
>>>>>>> +{
>>>>>>> + return kgd2kfd_resume_processes();
>>>>>>> +}
>>>>>>> +
>>>>>>> int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
>>>>>>> {
>>>>>>> int r = 0;
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>>> index f8b9f27adcf5..803306e011c3 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>>> @@ -140,6 +140,7 @@ void amdgpu_amdkfd_fini(void);
>>>>>>> void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
>>>>>>> int amdgpu_amdkfd_resume_iommu(struct amdgpu_device *adev);
>>>>>>> int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
>>>>>>> +int amdgpu_amdkfd_resume_processes(void);
>>>>>>> void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>>>>>>> const void *ih_ring_entry);
>>>>>>> void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
>>>>>>> @@ -347,6 +348,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd);
>>>>>>> void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
>>>>>>> int kgd2kfd_resume_iommu(struct kfd_dev *kfd);
>>>>>>> int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
>>>>>>> +int kgd2kfd_resume_processes(void);
>>>>>>> int kgd2kfd_pre_reset(struct kfd_dev *kfd);
>>>>>>> int kgd2kfd_post_reset(struct kfd_dev *kfd);
>>>>>>> void kgd2kfd_interrupt(struct kfd_dev *kfd, const void 
>>>>>>> *ih_ring_entry);
>>>>>>> @@ -393,6 +395,11 @@ static inline int kgd2kfd_resume(struct 
>>>>>>> kfd_dev *kfd, bool run_pm)
>>>>>>> return 0;
>>>>>>> }
>>>>>>>
>>>>>>> +static inline int kgd2kfd_resume_processes(void)
>>>>>>> +{
>>>>>>> + return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>>>>>>> {
>>>>>>> return 0;
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> index fa4a9f13c922..5827b65b7489 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> @@ -4004,6 +4004,7 @@ void amdgpu_device_fini_hw(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>> if (drm_dev_is_unplugged(adev_to_drm(adev)))
>>>>>>> amdgpu_device_unmap_mmio(adev);
>>>>>>>
>>>>>>> + amdgpu_amdkfd_resume_processes();
>>>>>>> }
>>>>>>>
>>>>>>> void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>> index 62aa6c9d5123..ef05aae9255e 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>> @@ -714,6 +714,19 @@ int kgd2kfd_resume(struct kfd_dev *kfd, 
>>>>>>> bool run_pm)
>>>>>>> return ret;
>>>>>>> }
>>>>>>>
>>>>>>> +/* for non-runtime resume only */
>>>>>>> +int kgd2kfd_resume_processes(void)
>>>>>>> +{
>>>>>>> + int count;
>>>>>>> +
>>>>>>> + count = atomic_dec_return(&kfd_locked);
>>>>>>> + WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
>>>>>>> + if (count == 0)
>>>>>>> + return kfd_resume_all_processes();
>>>>>>> +
>>>>>>> + return 0;
>>>>>>> +}
>>>>>>
>>>>>> It doesn't make sense to me to just increment kfd_locked in
>>>>>> kgd2kfd_suspend to only decrement it again a few functions down the
>>>>>> road.
>>>>>>
>>>>>> I suggest this instead - you only incrmemnt if not during PCI remove
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>> index 1c2cf3a33c1f..7754f77248a4 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>> @@ -952,11 +952,12 @@ bool kfd_is_locked(void)
>>>>>>
>>>>>> void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>>>>>> {
>>>>>> +
>>>>>> if (!kfd->init_complete)
>>>>>> return;
>>>>>>
>>>>>> /* for runtime suspend, skip locking kfd */
>>>>>> - if (!run_pm) {
>>>>>> + if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
>>>>>> /* For first KFD device suspend all the KFD processes */
>>>>>> if (atomic_inc_return(&kfd_locked) == 1)
>>>>>> kfd_suspend_all_processes();
>>>>>>
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>>
>>>>>>
>>>>>>> +
>>>>>>> int kgd2kfd_resume_iommu(struct kfd_dev *kfd)
>>>>>>> {
>>>>>>> int err = 0;
>>>
>
--------------WJR1QU8ceapkU4YTimBdjiqu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-04-14 10:00, Shuotao Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:B7970589-ACF6-41F3-8622-1C0F705F3EE0@microsoft.com">
      
      <br class="">
      <div><br class="">
        <blockquote type="cite" class="">
          <div class="">On Apr 14, 2022, at 1:31 AM, Andrey Grodzovsky
            &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
            wrote:</div>
          <br class="Apple-interchange-newline">
          <div class="">
            <div class="">
              <p class=""><br class="">
              </p>
              <div class="moz-cite-prefix">On 2022-04-13 12:03, Shuotao
                Xu wrote:<br class="">
              </div>
              <blockquote type="cite" cite="mid:5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com" class="">
                <br class="">
                <div class=""><br class="">
                  <blockquote type="cite" class="">
                    <div class="">On Apr 11, 2022, at 11:52 PM, Andrey
                      Grodzovsky &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
                      wrote:</div>
                    <br class="Apple-interchange-newline">
                    <div class=""><span style="caret-color: rgb(0, 0,
                        0); font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">[Some
                        people who received this message don't often get
                        email from<span class="Apple-converted-space">&nbsp;</span></span><a href="mailto:andrey.grodzovsky@amd.com" style="font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        orphans: auto; text-align: start; text-indent:
                        0px; text-transform: none; white-space: normal;
                        widows: auto; word-spacing: 0px;
                        -webkit-text-size-adjust: auto;
                        -webkit-text-stroke-width: 0px;" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a><span style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none; float: none; display: inline !important;" class="">. Learn why this is important at<span class="Apple-converted-space">&nbsp;</span></span><a href="http://aka.ms/LearnAboutSenderIdentification" style="font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; orphans: auto;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        widows: auto; word-spacing: 0px;
                        -webkit-text-size-adjust: auto;
                        -webkit-text-stroke-width: 0px;" class="moz-txt-link-freetext" moz-do-not-send="true">http://aka.ms/LearnAboutSenderIdentification</a><span style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none; float: none; display: inline !important;" class="">.]</span><br style="caret-color: rgb(0,
                        0, 0); font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none;" class="">
                      <br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">On
                        2022-04-08 21:28, Shuotao Xu wrote:</span><br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                      <blockquote type="cite" style="font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; orphans: auto;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        widows: auto; word-spacing: 0px;
                        -webkit-text-size-adjust: auto;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                        <br class="">
                        <blockquote type="cite" class="">On Apr 8, 2022,
                          at 11:28 PM, Andrey Grodzovsky &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
                          wrote:<br class="">
                          <br class="">
                          [Some people who received this message don't
                          often get email from <a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">
                            andrey.grodzovsky@amd.com</a>. Learn why
                          this is important at <a href="http://aka.ms/LearnAboutSenderIdentification" class="moz-txt-link-freetext" moz-do-not-send="true">
                            http://aka.ms/LearnAboutSenderIdentification</a>.]<br class="">
                          <br class="">
                          On 2022-04-08 04:45, Shuotao Xu wrote:<br class="">
                          <blockquote type="cite" class="">Adding PCIe
                            Hotplug Support for AMDKFD: the support of
                            hot-plug of GPU<br class="">
                            devices can open doors for many advanced
                            applications in data center<br class="">
                            in the next few years, such as for GPU
                            resource<br class="">
                            disaggregation. Current AMDKFD does not
                            support hotplug out b/o the<br class="">
                            following reasons:<br class="">
                            <br class="">
                            1. During PCIe removal, decrement KFD lock
                            which was incremented at<br class="">
                            the beginning of hw fini; otherwise kfd_open
                            later is going to<br class="">
                            fail.<br class="">
                          </blockquote>
                          I assumed you read my comment last time, still
                          you do same approach.<br class="">
                          More in details bellow<br class="">
                        </blockquote>
                        Aha, I like your fix:) I was not familiar with
                        drm APIs so just only half understood your
                        comment last time.<br class="">
                        <br class="">
                        BTW, I tried hot-plugging out a GPU when rocm
                        application is still running.<br class="">
                        From dmesg, application is still trying to
                        access the removed kfd device, and are met with
                        some errors.<br class="">
                      </blockquote>
                      <br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                      <br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">Application
                        us supposed to keep running, it holds the
                        drm_device</span><br style="caret-color: rgb(0,
                        0, 0); font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">reference
                        as long as it has an open</span><br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">FD to the
                        device and final cleanup will come only after
                        the app will die</span><br style="caret-color:
                        rgb(0, 0, 0); font-family: Helvetica; font-size:
                        12px; font-style: normal; font-variant-caps:
                        normal; font-weight: 400; letter-spacing:
                        normal; text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">thus
                        releasing the FD and the last</span><br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">drm_device
                        reference.</span><br style="caret-color: rgb(0,
                        0, 0); font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none;" class="">
                      <br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                      <blockquote type="cite" style="font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; orphans: auto;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        widows: auto; word-spacing: 0px;
                        -webkit-text-size-adjust: auto;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                        Application would hang and not exiting in this
                        case.<br class="">
                      </blockquote>
                      <br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                    </div>
                  </blockquote>
                  <div class=""><br class="">
                  </div>
                  Actually I tried kill -7 $pid, and the process exists.
                  The dmesg has some warning though.</div>
                <div class=""><br class="">
                </div>
                <div class="">
                  <div class="">[ &nbsp;711.769977] WARNING: CPU: 23 PID: 344
                    at
                    .../amdgpu-rocm5.0.2/src/amd/amdgpu/amdgpu_object.c:1336
                    amdgpu_bo_release_notify+0x150/0x160 [amdgpu]</div>
                  <div class="">[ &nbsp;711.770528] Modules linked in:
                    amdgpu(OE) amdttm(OE) amd_sched(OE) amdkcl(OE)
                    iommu_v2 nf_conntrack_netlink nfnetlink xfrm_user
                    xfrm_algo xt_addrtype br_netfilter xt_CHECKSUM
                    iptable_mangle xt_MASQUERADE iptable_nat nf_nat
                    xt_conntrack nf_conntrack nf_defrag_ipv6
                    nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 xt_tcpudp
                    bridge stp llc ebtable_filter ebtables
                    ip6table_filter ip6_tables iptable_filter overlay
                    binfmt_misc intel_rapl_msr i40iw intel_rapl_common
                    skx_edac nfit x86_pkg_temp_thermal intel_powerclamp
                    coretemp kvm_intel rpcrdma kvm sunrpc ipmi_ssif
                    ib_umad ib_ipoib rdma_ucm irqbypass rapl joydev
                    acpi_ipmi input_leds intel_cstate ipmi_si
                    ipmi_devintf mei_me mei intel_pch_thermal
                    ipmi_msghandler ioatdma mac_hid lpc_ich dca
                    acpi_power_meter acpi_pad sch_fq_codel ib_iser
                    rdma_cm iw_cm ib_cm iscsi_tcp libiscsi_tcp libiscsi
                    scsi_transport_iscsi pci_stub ip_tables x_tables
                    autofs4 btrfs blake2b_generic zstd_compress raid10
                    raid456 async_raid6_recov async_memcpy async_pq
                    async_xor async_tx xor</div>
                  <div class="">[ &nbsp;711.779359] &nbsp;raid6_pq libcrc32c raid1
                    raid0 multipath linear mlx5_ib ib_uverbs ib_core ast
                    drm_vram_helper i2c_algo_bit drm_ttm_helper ttm
                    drm_kms_helper syscopyarea crct10dif_pclmul
                    crc32_pclmul ghash_clmulni_intel sysfillrect uas
                    hid_generic sysimgblt aesni_intel mlx5_core
                    fb_sys_fops crypto_simd usbhid cryptd drm i40e
                    pci_hyperv_intf usb_storage glue_helper mlxfw hid
                    ahci libahci wmi</div>
                  <div class="">[ &nbsp;711.779752] CPU: 23 PID: 344 Comm:
                    kworker/23:1 Tainted: G &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp;OE &nbsp; &nbsp; 5.11.0+ #1</div>
                  <div class="">[ &nbsp;711.779755] Hardware name: Supermicro
                    SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 2.1 08/14/2018</div>
                  <div class="">[ &nbsp;711.779756] Workqueue: kfd_process_wq
                    kfd_process_wq_release [amdgpu]</div>
                  <div class="">[ &nbsp;711.779955] RIP:
                    0010:amdgpu_bo_release_notify+0x150/0x160 [amdgpu]</div>
                  <div class="">[ &nbsp;711.780141] Code: e8 b5 af 34 f4 e9
                    1f ff ff ff 48 39 c2 74 07 0f 0b e9 69 ff ff ff 4c
                    89 e7 e8 3c b4 16 00 e9 5c ff ff ff e8 a2 ce fd f3
                    eb cf &lt;0f&gt; 0b eb cb e8 d7 02 34 f4 0f 1f 80 00
                    00 00 00 0f 1f 44 00 00 55</div>
                  <div class="">[ &nbsp;711.780143] RSP:
                    0018:ffffa8100dd67c30 EFLAGS: 00010282</div>
                  <div class="">[ &nbsp;711.780145] RAX: 00000000ffffffea
                    RBX: ffff89980e792058 RCX: 0000000000000000</div>
                  <div class="">[ &nbsp;711.780147] RDX: 0000000000000000
                    RSI: ffff89a8f9ad8870 RDI: ffff89a8f9ad8870</div>
                  <div class="">[ &nbsp;711.780148] RBP: ffffa8100dd67c50
                    R08: 0000000000000000 R09: fffffffffff99b18</div>
                  <div class="">[ &nbsp;711.780149] R10: ffffa8100dd67bd0
                    R11: ffffa8100dd67908 R12: ffff89980e792000</div>
                  <div class="">[ &nbsp;711.780151] R13: ffff89980e792058
                    R14: ffff89980e7921bc R15: dead000000000100</div>
                  <div class="">[ &nbsp;711.780152] FS:
                    &nbsp;0000000000000000(0000) GS:ffff89a8f9ac0000(0000)
                    knlGS:0000000000000000</div>
                  <div class="">[ &nbsp;711.780154] CS: &nbsp;0010 DS: 0000 ES:
                    0000 CR0: 0000000080050033</div>
                  <div class="">[ &nbsp;711.780156] CR2: 00007ffddac6f71f
                    CR3: 00000030bb80a003 CR4: 00000000007706e0</div>
                  <div class="">[ &nbsp;711.780157] DR0: 0000000000000000
                    DR1: 0000000000000000 DR2: 0000000000000000</div>
                  <div class="">[ &nbsp;711.780159] DR3: 0000000000000000
                    DR6: 00000000fffe0ff0 DR7: 0000000000000400</div>
                  <div class="">[ &nbsp;711.780160] PKRU: 55555554</div>
                  <div class="">[ &nbsp;711.780161] Call Trace:</div>
                  <div class="">[ &nbsp;711.780163]
                    &nbsp;ttm_bo_release+0x2ae/0x320 [amdttm]</div>
                  <div class="">[ &nbsp;711.780169] &nbsp;amdttm_bo_put+0x30/0x40
                    [amdttm]</div>
                  <div class="">[ &nbsp;711.780357]
                    &nbsp;amdgpu_bo_unref+0x1e/0x30 [amdgpu]</div>
                  <div class="">[ &nbsp;711.780543]
                    &nbsp;amdgpu_gem_object_free+0x8b/0x160 [amdgpu]</div>
                  <div class="">[ &nbsp;711.781119]
                    &nbsp;drm_gem_object_free+0x1d/0x30 [drm]</div>
                  <div class="">[ &nbsp;711.781489]
                    &nbsp;amdgpu_amdkfd_gpuvm_free_memory_of_gpu+0x34a/0x380
                    [amdgpu]</div>
                  <div class="">[ &nbsp;711.782044]
                    &nbsp;kfd_process_device_free_bos+0xe0/0x130 [amdgpu]</div>
                  <div class="">[ &nbsp;711.782611]
                    &nbsp;kfd_process_wq_release+0x286/0x380 [amdgpu]</div>
                  <div class="">[ &nbsp;711.783172]
                    &nbsp;process_one_work+0x236/0x420</div>
                  <div class="">[ &nbsp;711.783543] &nbsp;worker_thread+0x34/0x400</div>
                  <div class="">[ &nbsp;711.783911] &nbsp;?
                    process_one_work+0x420/0x420</div>
                  <div class="">[ &nbsp;711.784279] &nbsp;kthread+0x126/0x140</div>
                  <div class="">[ &nbsp;711.784653] &nbsp;? kthread_park+0x90/0x90</div>
                  <div class="">[ &nbsp;711.785018] &nbsp;ret_from_fork+0x22/0x30</div>
                  <div class="">[ &nbsp;711.785387] ---[ end trace
                    d8f50f6594817c84 ]---</div>
                  <div class="">[ &nbsp;711.798716] [drm] amdgpu: ttm
                    finalized</div>
                </div>
              </blockquote>
              <p class=""><br class="">
              </p>
              <p class="">So it means the process was stuck in some
                wait_event_killable (maybe here drm_sched_entity_flush)
                - you can try 'cat/proc/$process_pid/stack' maybe before<br class="">
                you kill it to see where it was stuck so we can go from
                there.<br class="">
              </p>
              <p class=""><br class="">
              </p>
              <blockquote type="cite" cite="mid:5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com" class="">
                <div class="">
                  <div class=""><br class="">
                  </div>
                </div>
                <div class="">
                  <blockquote type="cite" class="">
                    <div class=""><br style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">For
                        graphic apps what i usually see is a crash
                        because of sigsev when</span><br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">the app
                        tries to access</span><br style="caret-color:
                        rgb(0, 0, 0); font-family: Helvetica; font-size:
                        12px; font-style: normal; font-variant-caps:
                        normal; font-weight: 400; letter-spacing:
                        normal; text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">an
                        unmapped MMIO region on the device. I haven't
                        tested for compute</span><br style="caret-color:
                        rgb(0, 0, 0); font-family: Helvetica; font-size:
                        12px; font-style: normal; font-variant-caps:
                        normal; font-weight: 400; letter-spacing:
                        normal; text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">stack and
                        so there might</span><br style="caret-color:
                        rgb(0, 0, 0); font-family: Helvetica; font-size:
                        12px; font-style: normal; font-variant-caps:
                        normal; font-weight: 400; letter-spacing:
                        normal; text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">be
                        something I haven't covered. Hang could mean for
                        example waiting on a</span><br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">fence
                        which is not being</span><br style="caret-color:
                        rgb(0, 0, 0); font-family: Helvetica; font-size:
                        12px; font-style: normal; font-variant-caps:
                        normal; font-weight: 400; letter-spacing:
                        normal; text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">signaled -
                        please provide full dmesg from this case.</span><br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                      <br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                      <blockquote type="cite" style="font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; orphans: auto;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        widows: auto; word-spacing: 0px;
                        -webkit-text-size-adjust: auto;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                        <br class="">
                        Do you have any good suggestions on how to fix
                        it down the line? (HIP runtime/libhsakmt or
                        driver)<br class="">
                        <br class="">
                        [64036.631333] amdgpu: amdgpu_vm_bo_update
                        failed<br class="">
                        [64036.631702] amdgpu:
                        validate_invalid_user_pages: update PTE failed<br class="">
                        [64036.640754] amdgpu: amdgpu_vm_bo_update
                        failed<br class="">
                        [64036.641120] amdgpu:
                        validate_invalid_user_pages: update PTE failed<br class="">
                        [64036.650394] amdgpu: amdgpu_vm_bo_update
                        failed<br class="">
                        [64036.650765] amdgpu:
                        validate_invalid_user_pages: update PTE failed<br class="">
                      </blockquote>
                      <br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                    </div>
                  </blockquote>
                  <div class=""><br class="">
                  </div>
                  The full dmesg will just the repetition of those two
                  messages,</div>
                <div class="">
                  <div class="">[186885.764079] amdgpu 0000:43:00.0:
                    amdgpu: amdgpu: finishing device.</div>
                  <div class="">[186885.766916] [drm] free PSP TMR
                    buffer</div>
                  <div class="">[186893.868173] amdgpu:
                    amdgpu_vm_bo_update failed</div>
                  <div class="">[186893.868235] amdgpu:
                    validate_invalid_user_pages: update PTE failed</div>
                  <div class="">[186893.876154] amdgpu:
                    amdgpu_vm_bo_update failed</div>
                  <div class="">[186893.876190] amdgpu:
                    validate_invalid_user_pages: update PTE failed</div>
                  <div class="">[186893.884150] amdgpu:
                    amdgpu_vm_bo_update failed</div>
                  <div class="">[186893.884185] amdgpu:
                    validate_invalid_user_pages: update PTE failed</div>
                </div>
                <div class=""><br class="">
                </div>
                <div class="">
                  <blockquote type="cite" class="">
                    <div class=""><br style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">This just
                        probably means trying to update PTEs after the
                        physical device</span><br style="caret-color:
                        rgb(0, 0, 0); font-family: Helvetica; font-size:
                        12px; font-style: normal; font-variant-caps:
                        normal; font-weight: 400; letter-spacing:
                        normal; text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">is gone -
                        we usually avoid this by</span><br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">first
                        trying to do all HW shutdowns early before PCI
                        remove completion</span><br style="caret-color:
                        rgb(0, 0, 0); font-family: Helvetica; font-size:
                        12px; font-style: normal; font-variant-caps:
                        normal; font-weight: 400; letter-spacing:
                        normal; text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">but when
                        it's really tricky by</span><br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">protecting
                        HW access sections with drm_dev_enter/exit
                        scope.</span><br style="caret-color: rgb(0, 0,
                        0); font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none;" class="">
                      <br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">For this
                        particular error it would be the best to flush</span><br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">info-&gt;restore_userptr_work
                        before the end of</span><br style="caret-color:
                        rgb(0, 0, 0); font-family: Helvetica; font-size:
                        12px; font-style: normal; font-variant-caps:
                        normal; font-weight: 400; letter-spacing:
                        normal; text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">amdgpu_pci_remove
                        (rejecting new process creation and calling</span><br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">cancel_delayed_work_sync(&amp;process_info-&gt;restore_userptr_work)
                        for all</span><br style="caret-color: rgb(0, 0,
                        0); font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">running
                        processes)</span><br style="caret-color: rgb(0,
                        0, 0); font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none;" class="">
                      <span style="caret-color: rgb(0, 0, 0);
                        font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">somewhere
                        in amdgpu_pci_remove.</span><br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                      <br class="">
                    </div>
                  </blockquote>
                  I tried something like *kfd_process_ref_release* which
                  I think did what you described, but it did not work.</div>
              </blockquote>
              <p class=""><br class="">
              </p>
              <p class="">I don't see how kfd_process_ref_release is the
                same as I mentioned above, what i meant is calling the
                code above within kgd2kfd_suspend (where you tried to
                call kfd_kill_all_user_processes bellow)
                <br class="">
              </p>
            </div>
          </div>
        </blockquote>
        Yes, you are right. It was not called by it. &nbsp;<br class="">
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <p class=""><br class="">
              </p>
              <blockquote type="cite" cite="mid:5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com" class="">
                <div class=""><br class="">
                </div>
                <div class="">Instead I tried to kill the process from
                  the kernel, but the amdgpu could **only** be
                  hot-plugged in back successfully only if there was no
                  rocm kernel running when it was plugged out. If not,
                  amdgpu_probe will just hang later. (Maybe because
                  amdgpu was plugged out while running state, it leaves
                  a bad HW state which causes probe to hang).</div>
              </blockquote>
              <p class=""><br class="">
              </p>
              <p class="">We usually do asic_reset during probe to reset
                all HW state (checlk if
                amdgpu_device_init-&gt;amdgpu_asic_reset is running when
                you&nbsp; plug back).
                <br class="">
              </p>
            </div>
          </div>
        </blockquote>
        OK<br class="">
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <p class="">&nbsp; <br class="">
              </p>
              <blockquote type="cite" cite="mid:5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com" class="">
                <div class=""><br class="">
                </div>
                <div class="">I don’t know if this is a viable solution
                  worth pursuing, but I attached the diff anyway.</div>
                <div class=""><br class="">
                </div>
                <div class="">Another solution could be let compute
                  stack user mode detect a topology change via&nbsp;<span class="">generation_count change, and abort
                    gracefully there.</span></div>
                <div class=""><br class="">
                </div>
                <div class="">diff --git
                  a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
                  b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                <div class="">index 4e7d9cb09a69..79b4c9b84cd0 100644</div>
                <div class="">---
                  a/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                <div class="">+++
                  b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                <div class="">@@ -697,12 +697,15 @@ void
                  kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm, bool
                  force)</div>
                <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return;</div>
                <div class=""><br class="">
                </div>
                <div class="">&nbsp; &nbsp; &nbsp; &nbsp; /* for runtime suspend, skip
                  locking kfd */</div>
                <div class="">- &nbsp; &nbsp; &nbsp; if (!run_pm) {</div>
                <div class="">+ &nbsp; &nbsp; &nbsp; if (!run_pm &amp;&amp;
                  !drm_dev_is_unplugged(kfd-&gt;ddev)) {</div>
                <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* For first KFD device
                  suspend all the KFD processes */</div>
                <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if
                  (atomic_inc_return(&amp;kfd_locked) == 1)</div>
                <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  kfd_suspend_all_processes(force);</div>
                <div class="">&nbsp; &nbsp; &nbsp; &nbsp; }</div>
                <div class=""><br class="">
                </div>
                <div class="">+ &nbsp; &nbsp; &nbsp; if
                  (drm_dev_is_unplugged(kfd-&gt;ddev))</div>
                <div class="">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  kfd_kill_all_user_processes();</div>
                <div class="">+</div>
                <div class="">&nbsp; &nbsp; &nbsp; &nbsp;
                  kfd-&gt;dqm-&gt;ops.stop(kfd-&gt;dqm);</div>
                <div class="">&nbsp; &nbsp; &nbsp; &nbsp; kfd_iommu_suspend(kfd);</div>
                <div class="">&nbsp;}</div>
                <div class="">diff --git
                  a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
                  b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
                <div class="">index 55c9e1922714..84cbcd857856 100644</div>
                <div class="">---
                  a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
                <div class="">+++
                  b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
                <div class="">@@ -1065,6 +1065,7 @@ void
                  kfd_unref_process(struct kfd_process *p);</div>
                <div class="">&nbsp;int kfd_process_evict_queues(struct
                  kfd_process *p, bool force);</div>
                <div class="">&nbsp;int kfd_process_restore_queues(struct
                  kfd_process *p);</div>
                <div class="">&nbsp;void kfd_suspend_all_processes(bool
                  force);</div>
                <div class="">+void kfd_kill_all_user_processes(void);</div>
                <div class="">&nbsp;/*</div>
                <div class="">&nbsp; * kfd_resume_all_processes:</div>
                <div class="">&nbsp; * &nbsp; &nbsp; bool sync: If
                  kfd_resume_all_processes() should wait for the</div>
                <div class="">diff --git
                  a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
                  b/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
                <div class="">index 6cdc855abb6d..fb0c753b682c 100644</div>
                <div class="">---
                  a/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
                <div class="">+++
                  b/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
                <div class="">@@ -2206,6 +2206,24 @@ void
                  kfd_suspend_all_processes(bool force)</div>
                <div class="">&nbsp; &nbsp; &nbsp; &nbsp;
                  srcu_read_unlock(&amp;kfd_processes_srcu, idx);</div>
                <div class="">&nbsp;}</div>
                <div class=""><br class="">
                </div>
                <div class="">+</div>
                <div class="">+void kfd_kill_all_user_processes(void)</div>
                <div class="">+{</div>
                <div class="">+ &nbsp; &nbsp; &nbsp; struct kfd_process *p;</div>
                <div class="">+ &nbsp; &nbsp; &nbsp; struct amdkfd_process_info
                  *p_info;</div>
                <div class="">+ &nbsp; &nbsp; &nbsp; unsigned int temp;</div>
                <div class="">+ &nbsp; &nbsp; &nbsp; int idx =
                  srcu_read_lock(&amp;kfd_processes_srcu);</div>
                <div class="">+</div>
                <div class="">+ &nbsp; &nbsp; &nbsp; pr_info(&quot;Killing all
                  processes\n&quot;);</div>
                <div class="">+ &nbsp; &nbsp; &nbsp;
                  hash_for_each_rcu(kfd_processes_table, temp, p,
                  kfd_processes) {</div>
                <div class="">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; p_info =
                  p-&gt;kgd_process_info;</div>
                <div class="">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pr_info(&quot;Killing
                  &nbsp;processes, pid = %d&quot;, pid_nr(p_info-&gt;pid));</div>
                <div class="">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; kill_pid(p_info-&gt;pid,
                  SIGBUS, 1);</div>
              </blockquote>
              <p class=""><br class="">
              </p>
              <p class="">From looking into kill_pid I see it only sends
                a signal but doesn't wait for completion, it would make
                sense to wait for completion here. In any case I would
                actually try to put here<span style="caret-color: rgb(0,
                  0, 0); font-family: Helvetica; font-size: 12px;
                  font-style: normal; font-variant-caps: normal;
                  font-weight: 400; letter-spacing: normal; text-align:
                  start; text-indent: 0px; text-transform: none;
                  white-space: normal; word-spacing: 0px;
                  -webkit-text-stroke-width: 0px; text-decoration: none;
                  float: none; display: inline !important;" class=""><br class="">
                </span></p>
            </div>
          </div>
        </blockquote>
        I have made a version which does that with some atomic counters.
        Please read later in the diff.<br class="">
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <p class=""><span style="caret-color: rgb(0, 0, 0);
                  font-family: Helvetica; font-size: 12px; font-style:
                  normal; font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; text-decoration: none; float: none; display:
                  inline !important;" class=""></span><span style="caret-color: rgb(0, 0, 0); font-family:
                  Helvetica; font-size: 12px; font-style: normal;
                  font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; text-decoration: none; float: none; display:
                  inline !important;" class=""><font class="" size="4"><br class="">
                  </font></span></p>
              <p class=""><span style="caret-color: rgb(0, 0, 0);
                  font-family: Helvetica; font-size: 12px; font-style:
                  normal; font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; text-decoration: none; float: none; display:
                  inline !important;" class=""><font class="" size="4">hash_for_each_rcu(</font></span><span style="caret-color: rgb(0, 0, 0); font-family:
                  Helvetica; font-size: 12px; font-style: normal;
                  font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; text-decoration: none; float: none; display:
                  inline !important;" class=""><font class="" size="4">p_info)
                    &nbsp;&nbsp; <br class="">
                    &nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;</font></span><span style="caret-color: rgb(0, 0, 0); font-family:
                  Helvetica; font-size: 12px; font-style: normal;
                  font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; text-decoration: none; float: none; display:
                  inline !important;" class=""><font class="" size="4"><span style="caret-color: rgb(0, 0, 0); font-family:
                      Helvetica; font-size: 12px; font-style: normal;
                      font-variant-caps: normal; font-weight: 400;
                      letter-spacing: normal; text-align: start;
                      text-indent: 0px; text-transform: none;
                      white-space: normal; word-spacing: 0px;
                      -webkit-text-stroke-width: 0px; text-decoration:
                      none; float: none; display: inline !important;" class=""></span><span style="caret-color: rgb(0,
                      0, 0); font-family: Helvetica; font-size: 12px;
                      font-style: normal; font-variant-caps: normal;
                      font-weight: 400; letter-spacing: normal;
                      text-align: start; text-indent: 0px;
                      text-transform: none; white-space: normal;
                      word-spacing: 0px; -webkit-text-stroke-width: 0px;
                      text-decoration: none; float: none; display:
                      inline !important;" class=""><font class="" size="4">p_info</font></span>-&gt;restore_userptr_work)
                    <br class="">
                  </font></span></p>
              <p class=""><span style="caret-color: rgb(0, 0, 0);
                  font-family: Helvetica; font-size: 12px; font-style:
                  normal; font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; text-decoration: none; float: none; display:
                  inline !important;" class=""><font class="" size="4">instead&nbsp;
                    at least that what i meant in the previous mail.&nbsp;</font></span></p>
            </div>
          </div>
        </blockquote>
        <div>I actually tried that earlier, and it did not work.
          Application still keeps running, and you have to send a kill
          to the user process.</div>
        <div><br class="">
        </div>
        <div>I have made the following version. It waits for processes
          to terminate synchronously after sending SIGBUS. After that it
          does the real work of amdgpu_pci_remove.</div>
        <div>However, it hangs at amdgpu_device_ip_fini_early when it is
          trying to deinit ip_block 6 &lt;sdma_v4_0&gt; (<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux%2F-%2Fblob%2Famd-staging-drm-next%2Fdrivers%2Fgpu%2Fdrm%2Famd%2Famdgpu%2Famdgpu_device.c%23L2818&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C37a2503747384d07944608da1e1f37ee%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637855416726313174%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=FBdaleltc3PbJRmaWr8D3gxU7zuZ7n%2Bcu7J2yUrzD1I%3D&amp;reserved=0" originalsrc="https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L2818" shash="EB2/NmIDxiErtBtyih/irqtozZF9gQENs53MuIUA9XCdWismupBtNvUDcK8Lb5R+ZDzoiW/ZPcYbF4heDWzSRaJ9AJhvmC2723gxxYKAqxInevDmIOhdpFC17ijrfbnrM0eHrEtGgO/AlVjEPBiX+xafHURLJUhHFuQO8J2xTSk=" class="" moz-do-not-send="true">https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-dr
 m-next/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L2818</a>).
          I assume that there are still some inflight dma, therefore
          fini of this ip block thus hangs?&nbsp;</div>
        <div><br class="">
        </div>
        <div>The following is an excerpt of the dmesg: please excuse for
          putting my own pr_info, but I hope you get my point of where
          it hangs.</div>
        <div><br class="">
        </div>
        <div>
          <div>[ &nbsp;392.344735] amdgpu: all processes has been fully
            released</div>
          <div>[ &nbsp;392.346557] amdgpu: amdgpu_acpi_fini done</div>
          <div>[ &nbsp;392.346568] amdgpu 0000:b3:00.0: amdgpu: amdgpu:
            finishing device.</div>
          <div>[ &nbsp;392.349238] amdgpu: amdgpu_device_ip_fini_early enter
            ip_blocks = 9</div>
          <div>[ &nbsp;392.349248] amdgpu: Free mem_obj = 000000007bf54275,
            range_start = 14, range_end = 14</div>
          <div>[ &nbsp;392.350299] amdgpu: Free mem_obj = 00000000a85bc878,
            range_start = 12, range_end = 12</div>
          <div>[ &nbsp;392.350304] amdgpu: Free mem_obj = 00000000b8019e32,
            range_start = 13, range_end = 13</div>
          <div>[ &nbsp;392.350308] amdgpu: Free mem_obj = 000000002d296168,
            range_start = 4, range_end = 11</div>
          <div>[ &nbsp;392.350313] amdgpu: Free mem_obj = 000000001fc4f934,
            range_start = 0, range_end = 3</div>
          <div>[ &nbsp;392.350322] amdgpu: amdgpu_amdkfd_suspend(adev, false)
            done</div>
          <div>[ &nbsp;392.350672] amdgpu: hw_fini of IP block[8]
            &lt;jpeg_v2_5&gt; done 0</div>
          <div>[ &nbsp;392.350679] amdgpu: hw_fini of IP block[7]
            &lt;vcn_v2_5&gt; done 0</div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>I just remembered that the idea to actively kill and wait for
      running user processes during unplug was rejected<br>
      as a bad idea in the first iteration of unplug work I did (don't
      remember why now, need to look) so this is a no go.<br>
      Our policy is to let zombie processes (zombie in a sense that the
      underlying device is gone) live as long as they want <br>
      (as long as you able to terminate them - which you do, so that ok)<br>
      and the system should finish PCI remove gracefully and be able to
      hot plug back the device.&nbsp; Hence, i suggest dropping<br>
      this direction of forcing all user processes to be killed, confirm
      you have graceful shutdown and remove of device<br>
      from PCI topology and then concentrate on why when you plug back
      it hangs. First confirm if ASIC reset happens on<br>
      next init. Second please confirm if the timing you kill manually
      the user process has impact on whether you have a hang<br>
      on next plug back (if you kill before or you kill after plug back
      does it makes a difference). <br>
    </p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:B7970589-ACF6-41F3-8622-1C0F705F3EE0@microsoft.com">
      <div>
        <div>
        </div>
        <div><br class="">
        </div>
        <div><br class="">
        </div>
        <div>
          <div>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c</div>
          <div>index 8fa9b86ac9d2..c0b27f722281 100644</div>
          <div>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c</div>
          <div>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c</div>
          <div>@@ -188,6 +188,12 @@ void amdgpu_amdkfd_interrupt(struct
            amdgpu_device *adev,</div>
          <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>kgd2kfd_interrupt(adev-&gt;kfd.dev,
            ih_ring_entry);</div>
          <div>&nbsp;}</div>
          <div>&nbsp;</div>
          <div>+void amdgpu_amdkfd_kill_all_processes(struct
            amdgpu_device *adev)</div>
          <div>+{</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>if
            (adev-&gt;kfd.dev)</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>kgd2kfd_kill_all_user_processes(adev-&gt;kfd.dev);</div>
          <div>+}</div>
          <div>+</div>
          <div>&nbsp;void amdgpu_amdkfd_suspend(struct amdgpu_device *adev,
            bool run_pm)</div>
          <div>&nbsp;{</div>
          <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
            (adev-&gt;kfd.dev)</div>
          <div>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h</div>
          <div>index 27c74fcec455..f4e485d60442 100644</div>
          <div>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h</div>
          <div>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h</div>
          <div>@@ -141,6 +141,7 @@ struct amdkfd_process_info {</div>
          <div>&nbsp;int amdgpu_amdkfd_init(void);</div>
          <div>&nbsp;void amdgpu_amdkfd_fini(void);</div>
          <div>&nbsp;</div>
          <div>+void amdgpu_amdkfd_kill_all_processes(struct
            amdgpu_device *adev);</div>
          <div>&nbsp;void amdgpu_amdkfd_suspend(struct amdgpu_device *adev,
            bool run_pm);</div>
          <div>&nbsp;int amdgpu_amdkfd_resume_iommu(struct amdgpu_device
            *adev);</div>
          <div>&nbsp;int amdgpu_amdkfd_resume(struct amdgpu_device *adev,
            bool run_pm, bool sync);</div>
          <div>@@ -405,6 +406,7 @@ bool kgd2kfd_device_init(struct
            kfd_dev *kfd,</div>
          <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>const
            struct kgd2kfd_shared_resources *gpu_resources);</div>
          <div>&nbsp;void kgd2kfd_device_exit(struct kfd_dev *kfd);</div>
          <div>&nbsp;void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm,
            bool force);</div>
          <div>+void kgd2kfd_kill_all_user_processes(struct kfd_dev
            *kfd);</div>
          <div>&nbsp;int kgd2kfd_resume_iommu(struct kfd_dev *kfd);</div>
          <div>&nbsp;int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm,
            bool sync);</div>
          <div>&nbsp;int kgd2kfd_pre_reset(struct kfd_dev *kfd);</div>
          <div>@@ -443,6 +445,9 @@ static inline void
            kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm, bool
            force)</div>
          <div>&nbsp;{</div>
          <div>&nbsp;}</div>
          <div>&nbsp;</div>
          <div>+void kgd2kfd_kill_all_user_processes(struct kfd_dev
            *kfd){</div>
          <div>+}</div>
          <div>+</div>
          <div>&nbsp;static int __maybe_unused kgd2kfd_resume_iommu(struct
            kfd_dev *kfd)</div>
          <div>&nbsp;{</div>
          <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return
            0;</div>
          <div>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c</div>
          <div>index 3d5fc0751829..af6fe5080cfa 100644</div>
          <div>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c</div>
          <div>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c</div>
          <div>@@ -2101,6 +2101,9 @@ amdgpu_pci_remove(struct pci_dev
            *pdev)</div>
          <div>&nbsp;{</div>
          <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>struct
            drm_device *dev = pci_get_drvdata(pdev);</div>
          <div>&nbsp;</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>/*
            kill all kfd processes before drm_dev_unplug */</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>amdgpu_amdkfd_kill_all_processes(drm_to_adev(dev));</div>
          <div>+</div>
          <div>&nbsp;#ifdef HAVE_DRM_DEV_UNPLUG</div>
          <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>drm_dev_unplug(dev);</div>
          <div>&nbsp;#else</div>
          <div>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
            b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
          <div>index 5504a18b5a45..480c23bef5e2 100644</div>
          <div>--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
          <div>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
          <div>@@ -691,6 +691,12 @@ bool kfd_is_locked(void)</div>
          <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return
            &nbsp;(atomic_read(&amp;kfd_locked) &gt; 0);</div>
          <div>&nbsp;}</div>
          <div>&nbsp;</div>
          <div>+inline void kgd2kfd_kill_all_user_processes(struct
            kfd_dev* dev)</div>
          <div>+{</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>kfd_kill_all_user_processes();</div>
          <div>+}</div>
          <div>+</div>
          <div>+</div>
          <div>&nbsp;void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm,
            bool force)</div>
          <div>&nbsp;{</div>
          <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
            (!kfd-&gt;init_complete)</div>
          <div>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
            b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
          <div>index 55c9e1922714..a35a2cb5bb9f 100644</div>
          <div>--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
          <div>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
          <div>@@ -1064,6 +1064,7 @@ static inline struct
            kfd_process_device *kfd_process_device_from_gpuidx(</div>
          <div>&nbsp;void kfd_unref_process(struct kfd_process *p);</div>
          <div>&nbsp;int kfd_process_evict_queues(struct kfd_process *p, bool
            force);</div>
          <div>&nbsp;int kfd_process_restore_queues(struct kfd_process *p);</div>
          <div>+void kfd_kill_all_user_processes(void);</div>
          <div>&nbsp;void kfd_suspend_all_processes(bool force);</div>
          <div>&nbsp;/*</div>
          <div>&nbsp; * kfd_resume_all_processes:</div>
          <div>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
            b/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
          <div>index 6cdc855abb6d..17e769e6951d 100644</div>
          <div>--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
          <div>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
          <div>@@ -46,6 +46,9 @@ struct mm_struct;</div>
          <div>&nbsp;#include &quot;kfd_trace.h&quot;</div>
          <div>&nbsp;#include &quot;kfd_debug.h&quot;</div>
          <div>&nbsp;</div>
          <div>+static atomic_t kfd_process_locked = ATOMIC_INIT(0);</div>
          <div>+static atomic_t kfd_inflight_kills = ATOMIC_INIT(0);</div>
          <div>+</div>
          <div>&nbsp;/*</div>
          <div>&nbsp; * List of struct kfd_process (field kfd_process).</div>
          <div>&nbsp; * Unique/indexed by mm_struct*</div>
          <div>@@ -802,6 +805,9 @@ struct kfd_process
            *kfd_create_process(struct task_struct *thread)</div>
          <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>struct
            kfd_process *process;</div>
          <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>int
            ret;</div>
          <div>&nbsp;</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>if
            ( atomic_read(&amp;kfd_process_locked) &gt; 0 )</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>return
            ERR_PTR(-EINVAL);</div>
          <div>+</div>
          <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
            (!(thread-&gt;mm &amp;&amp; mmget_not_zero(thread-&gt;mm)))</div>
          <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return
            ERR_PTR(-EINVAL);</div>
          <div>&nbsp;</div>
          <div>@@ -1126,6 +1132,10 @@ static void
            kfd_process_wq_release(struct work_struct *work)</div>
          <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>put_task_struct(p-&gt;lead_thread);</div>
          <div>&nbsp;</div>
          <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>kfree(p);</div>
          <div>+</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>if
            ( atomic_read(&amp;kfd_process_locked) &gt; 0 ){</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_dec(&amp;kfd_inflight_kills);</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
          <div>&nbsp;}</div>
          <div>&nbsp;</div>
          <div>&nbsp;static void kfd_process_ref_release(struct kref *ref)</div>
          <div>@@ -2186,6 +2196,35 @@ static void
            restore_process_worker(struct work_struct *work)</div>
          <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>pr_err(&quot;Failed
            to restore queues of pasid 0x%x\n&quot;, p-&gt;pasid);</div>
          <div>&nbsp;}</div>
          <div>&nbsp;</div>
          <div>+void kfd_kill_all_user_processes(void)</div>
          <div>+{</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>struct
            kfd_process *p;</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>/*
            struct amdkfd_process_info *p_info; */</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>unsigned
            int temp;</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>int
            idx;</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_inc(&amp;kfd_process_locked);</div>
          <div>+</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>idx
            = srcu_read_lock(&amp;kfd_processes_srcu);</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>pr_info(&quot;Killing
            all processes\n&quot;);</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>hash_for_each_rcu(kfd_processes_table,
            temp, p, kfd_processes) {</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>dev_warn(kfd_device,</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>&quot;Sending
            SIGBUS to process %d (pasid 0x%x)&quot;,</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>p-&gt;lead_thread-&gt;pid,
            p-&gt;pasid);</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>send_sig(SIGBUS,
            p-&gt;lead_thread, 0);</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_inc(&amp;kfd_inflight_kills);</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>srcu_read_unlock(&amp;kfd_processes_srcu,
            idx);</div>
          <div>+</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>while
            ( atomic_read(&amp;kfd_inflight_kills) &gt; 0 ){</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>dev_warn(kfd_device,</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>&quot;kfd_processes_table
            is not empty, going to sleep for 10ms\n&quot;);</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>msleep(10);</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
          <div>+</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_dec(&amp;kfd_process_locked);</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>pr_info(&quot;all
            processes has been fully released&quot;);</div>
          <div>+}</div>
          <div>+</div>
          <div>&nbsp;void kfd_suspend_all_processes(bool force)</div>
          <div>&nbsp;{</div>
          <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>struct
            kfd_process *p;</div>
          <div class=""><br class="">
          </div>
          <div class=""><br class="">
          </div>
        </div>
        <div><br class="">
        </div>
        <div>Regards,</div>
        <div>Shuotao</div>
        <br class="">
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <p class=""><span style="caret-color: rgb(0, 0, 0);
                  font-family: Helvetica; font-size: 12px; font-style:
                  normal; font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; text-decoration: none; float: none; display:
                  inline !important;" class=""></span></p>
              <p class=""><span style="caret-color: rgb(0, 0, 0);
                  font-family: Helvetica; font-size: 12px; font-style:
                  normal; font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; text-decoration: none; float: none; display:
                  inline !important;" class=""><font class="" size="4">Andrey</font><br class="">
                  <br class="">
                </span></p>
              <blockquote type="cite" cite="mid:5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com" class="">
                <div class="">+ &nbsp; &nbsp; &nbsp; }</div>
                <div class="">+ &nbsp; &nbsp; &nbsp;
                  srcu_read_unlock(&amp;kfd_processes_srcu, idx);</div>
                <div class="">+}</div>
                <div class="">+</div>
                <div class="">+</div>
                <div class="">&nbsp;int kfd_resume_all_processes(bool sync)</div>
                <div class="">&nbsp;{</div>
                <div class="">&nbsp; &nbsp; &nbsp; &nbsp; struct kfd_process *p;</div>
                <div class=""><br class="">
                </div>
                <div class=""><br class="">
                  <blockquote type="cite" class="">
                    <div class=""><span style="caret-color: rgb(0, 0,
                        0); font-family: Helvetica; font-size: 12px;
                        font-style: normal; font-variant-caps: normal;
                        font-weight: 400; letter-spacing: normal;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        word-spacing: 0px; -webkit-text-stroke-width:
                        0px; text-decoration: none; float: none;
                        display: inline !important;" class="">Andrey</span><br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                      <br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                      <br style="caret-color: rgb(0, 0, 0); font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; text-align: start;
                        text-indent: 0px; text-transform: none;
                        white-space: normal; word-spacing: 0px;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                      <blockquote type="cite" style="font-family:
                        Helvetica; font-size: 12px; font-style: normal;
                        font-variant-caps: normal; font-weight: 400;
                        letter-spacing: normal; orphans: auto;
                        text-align: start; text-indent: 0px;
                        text-transform: none; white-space: normal;
                        widows: auto; word-spacing: 0px;
                        -webkit-text-size-adjust: auto;
                        -webkit-text-stroke-width: 0px; text-decoration:
                        none;" class="">
                        <br class="">
                        Really appreciate your help!<br class="">
                        <br class="">
                        Best,<br class="">
                        Shuotao<br class="">
                        <br class="">
                        <blockquote type="cite" class="">
                          <blockquote type="cite" class="">2. Remove
                            redudant p2p/io links in sysfs when device
                            is hotplugged<br class="">
                            out.<br class="">
                            <br class="">
                            3. New kfd node_id is not properly assigned
                            after a new device is<br class="">
                            added after a gpu is hotplugged out in a
                            system. libhsakmt will<br class="">
                            find this anomaly, (i.e. node_from !=
                            &lt;dev node id&gt; in iolinks),<br class="">
                            when taking a topology_snapshot, thus
                            returns fault to the rocm<br class="">
                            stack.<br class="">
                            <br class="">
                            -- This patch fixes issue 1; another patch
                            by Mukul fixes issues 2&amp;3.<br class="">
                            -- Tested on a 4-GPU MI100 gpu nodes with
                            kernel 5.13.0-kfd; kernel<br class="">
                            5.16.0-kfd is unstable out of box for MI100.<br class="">
                            ---<br class="">
                            drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |
                            5 +++++<br class="">
                            drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |
                            7 +++++++<br class="">
                            drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |
                            1 +<br class="">
                            drivers/gpu/drm/amd/amdkfd/kfd_device.c | 13
                            +++++++++++++<br class="">
                            4 files changed, 26 insertions(+)<br class="">
                            <br class="">
                            diff --git
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br class="">
                            index c18c4be1e4ac..d50011bdb5c4 100644<br class="">
                            ---
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br class="">
                            +++
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br class="">
                            @@ -213,6 +213,11 @@ int
                            amdgpu_amdkfd_resume(struct amdgpu_device
                            *adev, bool run_pm)<br class="">
                            return r;<br class="">
                            }<br class="">
                            <br class="">
                            +int amdgpu_amdkfd_resume_processes(void)<br class="">
                            +{<br class="">
                            + return kgd2kfd_resume_processes();<br class="">
                            +}<br class="">
                            +<br class="">
                            int amdgpu_amdkfd_pre_reset(struct
                            amdgpu_device *adev)<br class="">
                            {<br class="">
                            int r = 0;<br class="">
                            diff --git
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br class="">
                            index f8b9f27adcf5..803306e011c3 100644<br class="">
                            ---
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br class="">
                            +++
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br class="">
                            @@ -140,6 +140,7 @@ void
                            amdgpu_amdkfd_fini(void);<br class="">
                            void amdgpu_amdkfd_suspend(struct
                            amdgpu_device *adev, bool run_pm);<br class="">
                            int amdgpu_amdkfd_resume_iommu(struct
                            amdgpu_device *adev);<br class="">
                            int amdgpu_amdkfd_resume(struct
                            amdgpu_device *adev, bool run_pm);<br class="">
                            +int amdgpu_amdkfd_resume_processes(void);<br class="">
                            void amdgpu_amdkfd_interrupt(struct
                            amdgpu_device *adev,<br class="">
                            const void *ih_ring_entry);<br class="">
                            void amdgpu_amdkfd_device_probe(struct
                            amdgpu_device *adev);<br class="">
                            @@ -347,6 +348,7 @@ void
                            kgd2kfd_device_exit(struct kfd_dev *kfd);<br class="">
                            void kgd2kfd_suspend(struct kfd_dev *kfd,
                            bool run_pm);<br class="">
                            int kgd2kfd_resume_iommu(struct kfd_dev
                            *kfd);<br class="">
                            int kgd2kfd_resume(struct kfd_dev *kfd, bool
                            run_pm);<br class="">
                            +int kgd2kfd_resume_processes(void);<br class="">
                            int kgd2kfd_pre_reset(struct kfd_dev *kfd);<br class="">
                            int kgd2kfd_post_reset(struct kfd_dev *kfd);<br class="">
                            void kgd2kfd_interrupt(struct kfd_dev *kfd,
                            const void *ih_ring_entry);<br class="">
                            @@ -393,6 +395,11 @@ static inline int
                            kgd2kfd_resume(struct kfd_dev *kfd, bool
                            run_pm)<br class="">
                            return 0;<br class="">
                            }<br class="">
                            <br class="">
                            +static inline int
                            kgd2kfd_resume_processes(void)<br class="">
                            +{<br class="">
                            + return 0;<br class="">
                            +}<br class="">
                            +<br class="">
                            static inline int kgd2kfd_pre_reset(struct
                            kfd_dev *kfd)<br class="">
                            {<br class="">
                            return 0;<br class="">
                            diff --git
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class="">
                            index fa4a9f13c922..5827b65b7489 100644<br class="">
                            ---
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class="">
                            +++
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class="">
                            @@ -4004,6 +4004,7 @@ void
                            amdgpu_device_fini_hw(struct amdgpu_device
                            *adev)<br class="">
                            if (drm_dev_is_unplugged(adev_to_drm(adev)))<br class="">
                            amdgpu_device_unmap_mmio(adev);<br class="">
                            <br class="">
                            + amdgpu_amdkfd_resume_processes();<br class="">
                            }<br class="">
                            <br class="">
                            void amdgpu_device_fini_sw(struct
                            amdgpu_device *adev)<br class="">
                            diff --git
                            a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
                            b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                            index 62aa6c9d5123..ef05aae9255e 100644<br class="">
                            ---
                            a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                            +++
                            b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                            @@ -714,6 +714,19 @@ int
                            kgd2kfd_resume(struct kfd_dev *kfd, bool
                            run_pm)<br class="">
                            return ret;<br class="">
                            }<br class="">
                            <br class="">
                            +/* for non-runtime resume only */<br class="">
                            +int kgd2kfd_resume_processes(void)<br class="">
                            +{<br class="">
                            + int count;<br class="">
                            +<br class="">
                            + count =
                            atomic_dec_return(&amp;kfd_locked);<br class="">
                            + WARN_ONCE(count &lt; 0, &quot;KFD suspend /
                            resume ref. error&quot;);<br class="">
                            + if (count == 0)<br class="">
                            + return kfd_resume_all_processes();<br class="">
                            +<br class="">
                            + return 0;<br class="">
                            +}<br class="">
                          </blockquote>
                          <br class="">
                          It doesn't make sense to me to just increment
                          kfd_locked in<br class="">
                          kgd2kfd_suspend to only decrement it again a
                          few functions down the<br class="">
                          road.<br class="">
                          <br class="">
                          I suggest this instead - you only incrmemnt if
                          not during PCI remove<br class="">
                          <br class="">
                          diff --git
                          a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                          b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                          index 1c2cf3a33c1f..7754f77248a4 100644<br class="">
                          --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                          @@ -952,11 +952,12 @@ bool kfd_is_locked(void)<br class="">
                          <br class="">
                          void kgd2kfd_suspend(struct kfd_dev *kfd, bool
                          run_pm)<br class="">
                          {<br class="">
                          +<br class="">
                          if (!kfd-&gt;init_complete)<br class="">
                          return;<br class="">
                          <br class="">
                          /* for runtime suspend, skip locking kfd */<br class="">
                          - if (!run_pm) {<br class="">
                          + if (!run_pm &amp;&amp;
                          !drm_dev_is_unplugged(kfd-&gt;ddev)) {<br class="">
                          /* For first KFD device suspend all the KFD
                          processes */<br class="">
                          if (atomic_inc_return(&amp;kfd_locked) == 1)<br class="">
                          kfd_suspend_all_processes();<br class="">
                          <br class="">
                          <br class="">
                          Andrey<br class="">
                          <br class="">
                          <br class="">
                          <br class="">
                          <blockquote type="cite" class="">+<br class="">
                            int kgd2kfd_resume_iommu(struct kfd_dev
                            *kfd)<br class="">
                            {<br class="">
                            int err = 0;</blockquote>
                        </blockquote>
                      </blockquote>
                    </div>
                  </blockquote>
                </div>
                <br class="">
              </blockquote>
            </div>
          </div>
        </blockquote>
      </div>
      <br class="">
    </blockquote>
  </body>
</html>

--------------WJR1QU8ceapkU4YTimBdjiqu--
