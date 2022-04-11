Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C462CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 15:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF2F10E7BB;
	Mon, 11 Apr 2022 15:53:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DC5210E65B
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 15:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SB4Zd+kZ9Ah4YsQfX4GBHEtXcALge4GdAYhMwl/Eo16CuCsl5gDSFsEPhvqNkknz5dGHCcf6YMsOmxSKJrLex8im3hJfRJqSxz9c2PhL968UE6pok/niztIlye/4W1ZTH7cAQJy4Y9cVzZE6/I3JSFscLQ3KFy8BkBPwSUOD/tb4gnyRhp/gHTqPBm6umvjYDkohNVsPm5MAEUK4hfk0ChqR8GOgxIhN2a9dioQ1eiDMi8K6/91C3b4Iv4PHPmR8DMy6WJIKExIhv6VXLKPbe4nIIA3ZBHh/rllfV/U/i1XhXoM8MEps9MrGLni0fRSXk0mYJW2AyesT24rMXpwDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOm2C4H1J27vwwoP6ZdpGL0Q8E/4rZfAnV/Lq1Ro2FQ=;
 b=ci4BPgtqEThKVSayIlKtpM9s2j0Ugpoi7BjeyRklkU+xgFGKMWQ5mtCReJ5jPIFBlR6orhpB2riWmMRo+eE3A7Rzr86sGaq3M7BvbaxDVZb/m6toCZ+EJuNuSwdVuOEWwQoPVsbJywI45v5MLNAosFKOc/w3/awY6KcCDFONitCvA/ZrZmvgON+CXx3jEnjJDXI+OPQIbhzZSTYMcZcRrll4JzmAxUp/YITGMI+IQBWh/kPD0MxbppYkGpQV1N3lnBNJkEoShfyBohwA5G+JJrANbe0hrJ4Nc7FWxT9GSXq5zOs4Pvl9YsXnb18AZIUKxCy/eganN7XnVtJIzmSW7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOm2C4H1J27vwwoP6ZdpGL0Q8E/4rZfAnV/Lq1Ro2FQ=;
 b=xiJuwYkX2k1A+QXRHrHlJIyAtja2ORebP94zTIzsEznJ47hKe71hz4PyAPBAAlnBecj6mgytaSNDSQIJfzN1cuZ+PcgHVyR3l/TEzWrFDHq+xHEYKZi9osk7RlWR1nNPgHgTdQoUe1xv4zv3IGH9pOnXRT7gtA610gv3UCPEgeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CH2PR12MB3861.namprd12.prod.outlook.com (2603:10b6:610:2a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 15:52:43 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4%9]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 15:52:43 +0000
Message-ID: <5c22aa65-f75d-bc05-e210-f28533d9f0f8@amd.com>
Date: Mon, 11 Apr 2022 11:52:40 -0400
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
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <08212428-471E-4C1C-9037-9AE16E9BA356@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::30) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 483849b0-881e-49ce-b522-08da1bd350ac
X-MS-TrafficTypeDiagnostic: CH2PR12MB3861:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3861257044EDE788AF5D877DEAEA9@CH2PR12MB3861.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZK55GuCvXlieedB+JKZJhGzKCL3nmw7CgTjvtGEw1Bx1y8tAWUNmCBSeujrYqteSLfvugvxRcdde66i4C23rBMSqdaCnGXCQen5BI2p1dePkzsvlw8LD3tOEUJ+4o9IMNXClDt3xFeeBH6+shpHxhnHeR5PgBKhx1WaJhK6bF028nM8eTf7XWSLB4Uja7oiPqTXZ1Kvs0Qd2bIkSbW0LaNx5vdYbEK0/Gw+UhttjytR5XIuKe7YkidG8nYMtbVcbOlNc2JF3XMw9Q4ZyLpNWdSvcsYaXIgktOwyBnhVuQb+UcLsYX3w94uwD4qwfcXacgywd6l0h6gCl7wn3qLBOGnl0Ic8DzYhWw/KCTD5bb5my1HYrhzon1q5giQIhAu/0bZcGWeMltSTBCkXURRCj84lr27dYIFio3TE23h4/IsIv37gO/zzn1IdO82V04llGIwPWWKScWp8IKW21EYvGMsvIkKv7Pa/kREg1oAvtbvwe/RxPFyVO9imdzFJNAO2YmHBjluLciRSQryljfe0zTJnvFkVXHFPKbUMht3NPz3osItgipu0YVT7G2bW3d8jHHblCOpvOta3FA7fHckkJb45qie85PiIwHpUeUnBUGSQYoEJweum0kx5i18FBOzj4SIQWdSAO6l20CuVn4EHLh83cLnvg7KfMEOWsODlchpozXgcBnA6TO09n3YdeYKHh4nRqf3aUcjPO0Fa+2O39oEA95sBmKKekJVB22PBnHTO/wnh5FGUM7XeglgNS4V9cn5QJ+BLM+rDHtx2PYLrYdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(31686004)(86362001)(31696002)(508600001)(8936002)(36756003)(186003)(53546011)(6512007)(6506007)(2616005)(6486002)(966005)(5660300002)(4326008)(66946007)(316002)(38100700002)(44832011)(66556008)(54906003)(66476007)(6916009)(8676002)(2906002)(43740500002)(45980500001)(10090945011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmIyOHVialZvc2J5QVdQcDkxYktyazhmNzRCVUR4bjdnV1NtamxNV21wemh4?=
 =?utf-8?B?MDBiR3lwaW54Z21qUGJXcjhJeUtkU2ZIL2VQaHVhbHlueVdBY0ZWdlMwVEtJ?=
 =?utf-8?B?ZzNmWFpUOUlPYkR5VTNtUDJHKzcyYUl3dXFSa0RKTFVWa2UxMnUzeHBudlhu?=
 =?utf-8?B?UUZvQzVlM2JjVXFLaU5QS3Y0bnVYNG1DSG50RzNBODdqbHEvTS85LysvU3lK?=
 =?utf-8?B?ZFNqSitkQ0g3WFRkckp4NmV3dEtDNzBXeXAvUU5tWDEzZUdiVjBZUlBreExm?=
 =?utf-8?B?T0tjMkdiUkdqejhMczcvQzJNdUlhMkhrZk5mYzNTK3JtSlpXTUVIcEhKaWM4?=
 =?utf-8?B?dFN6bkJnSDVqdytXSFVKM2FONTVUYmRPcitiOEVVYmpIREtVYk1maTc4SFZZ?=
 =?utf-8?B?MXAzM1ltRTc2RWRyY1lMNUVYN0ZYMTJ0cWtYdkE2NEtjSVZPQUFWdjZKZG5s?=
 =?utf-8?B?SHJZVUkxcVpZM0JyZUUyT0VhOVdvWWhRaE42a3VSL2JXWHRRbzhDS21UY2Zy?=
 =?utf-8?B?VVJmbE5zaXZnUG10M1dBRGE5OFo3eGtBMU9keEhTNUd6bmxpZ2JhcTAvVnJa?=
 =?utf-8?B?WHNIVzhRR0U4QUVLZzR0MWU0MVErMmJueGN1VXBzYkNKSmc2Q2I2aHpEZkRR?=
 =?utf-8?B?UmZ5M2lVMEtIeU9xSGVOTUhQeGk2cVlLZGtyU0dKRGZNaXpyMGkyWDlMS01B?=
 =?utf-8?B?c01zQnFmcHFEQlErUDd2SzB4ZmtvdUVDbFpZeFpyQXhCeEo4VnVVWDBHM1Fm?=
 =?utf-8?B?eTNhRklIWG1PaVFuUnRRalIwRzdQRTcrQTFlVEVvQTJCeXMrY1JRZFdEbklI?=
 =?utf-8?B?Y1ozWWo5S1AxMTErU09CLzJyR1ZzVGZsSjlwamwxbE11RG0vdS9kWkxMYmZW?=
 =?utf-8?B?czB0dEVNSmEyWW54Unhsa3lBV25sc2NPY2lEWFc0Vi9YVWxoUVh3c0dLYWla?=
 =?utf-8?B?YTl4bVFtVXpGdkVJeGt6Y0lTNVltV2NHdHd3YUxPZlB0M2RuVmUraExJY2JM?=
 =?utf-8?B?dkhmOXE1ZURMV0VJYWJXc3JBOVRnS0lXa05IRnBYT3N3bmxoSmc4Wmw5NW54?=
 =?utf-8?B?Qm1GZXk4Z3I5OUtiY1FjVU81SmtySWQ5Y3IyTnBFeGxCREtONmk3cjFqMldi?=
 =?utf-8?B?UTFjSVBLbm12QmZLaHZOUFhqMWlYeWRib2pRejF1RFZ4b1l4SUxIU2hEKzhX?=
 =?utf-8?B?endSZ0VrMHBacERSQVBMbzFmMlNSRnpJejN4ZU13cEI5OEJ1NkZ6NWxLOFJ5?=
 =?utf-8?B?dldrSWFvcU12MHkwS0xscDFHdHJYbTJybFVFRUhhNTRKM2x6UTJ0b1cyVjlq?=
 =?utf-8?B?K0NVNlhkRWRxcDVHbWt3U2tsQklBeVpqdVZsa0pIYUZtUXlwaGdCcDJBYmpy?=
 =?utf-8?B?OEQ1M3U3UllveEdyN0syUE14WjJPc3JmSi80NmpMbGJvdkhpV05IdUVWUDgv?=
 =?utf-8?B?YjhoTXdlblplNkM0Y0pMNzV2VlNGWjJEZkhYaUJnUVZvL1QwNzFJamlHdFdt?=
 =?utf-8?B?MlUwVUJ2R2c1SmkzTkpTSmoyUXlaZ0wza2d2cTJML3lHWVd5YzVvODBoT1Aw?=
 =?utf-8?B?UTV3V29yeE5BMmxER1pWV3Erc1pnR1dMUWhxN2lIMGgxUFBPbElaTHY4YzMw?=
 =?utf-8?B?ZUdFUUo3SFhTTHpOaW5HMFlrVnBTR0c5ejRDWEY0L21IbzFwRCt4TmdLN2FR?=
 =?utf-8?B?REFUbFhyWDRMZXI2Zmc1dUFwWjJSRDdjVHUwUTk5MlJvU1d4VGd2R1hhUm9p?=
 =?utf-8?B?LzNSQm1nUU9iNUxCcW0wMjY5aFZBK0g1ZFNEbTAzeDlOSWgwQW41aFFLOHVy?=
 =?utf-8?B?cWoyT2R2aUdmdXRla3pvcWIzUDZpMGY4eHBFODhIQzJ5LzRwOUNZUXpueXd4?=
 =?utf-8?B?Y0VMckFJbXJTTllEVHRqa3VldDNFN3BCblJ3YWR1NUYzUHBUaVVSNERsQVhC?=
 =?utf-8?B?MktsY0JEeitXVjlXeUxpVVZhWG5KdHFwMlB5bXJHdzh3amtlSjVGcE44TmJj?=
 =?utf-8?B?ZEg1ZDlrMVdnUEI1bytXY3dhemZwa1l6RlZCc2g3SmlnMkEyVEJHbXczS0xC?=
 =?utf-8?B?VVR4TWJNRnVMVzNoVllpYWtMSjIvTnNIdC9aUS8xTkVmejFhVERKRi8xN1Bo?=
 =?utf-8?B?WkQxWG1PVThVb2p3ajc4N1duNlVoTXp0ViswSTBKcHppMjc1Y0kzZWJPYUpZ?=
 =?utf-8?B?c0VsaDh3aU1ZcEtFSHMzd21qWUZpcUtTYmNPOUVSa2lGZ3JqeTVONWR2QTFn?=
 =?utf-8?B?NlYvbCs5VnBPbzA4Zk9iM2xSSm5VTlNoL1JTL0pjRzk5L1BGWHBSK0xpdXBj?=
 =?utf-8?B?d3lpWVVCcS9NaHYvZVYwYWtwYTh3TjJQQ3o3SEFzVjh0aXhLVG9hYklHUFY0?=
 =?utf-8?Q?Zap+OWzvaGAtC92D0YqYUmtZj+z7CBekXj+vD1HqVsF5I?=
X-MS-Exchange-AntiSpam-MessageData-1: 6FjjSd/ai5ec4A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483849b0-881e-49ce-b522-08da1bd350ac
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 15:52:43.3141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWfPXKngKCaIzz3P3d9wYFcPhvTz6KKNs49aneIf2eY0Ixd+FlLDcnXpEAK9YSQZfWOxjz7D4vV0crNEroX/tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3861
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


On 2022-04-08 21:28, Shuotao Xu wrote:
>
>> On Apr 8, 2022, at 11:28 PM, Andrey Grodzovsky <andrey.grodzovsky@amd.com> wrote:
>>
>> [Some people who received this message don't often get email from andrey.grodzovsky@amd.com. Learn why this is important at http://aka.ms/LearnAboutSenderIdentification.]
>>
>> On 2022-04-08 04:45, Shuotao Xu wrote:
>>> Adding PCIe Hotplug Support for AMDKFD: the support of hot-plug of GPU
>>> devices can open doors for many advanced applications in data center
>>> in the next few years, such as for GPU resource
>>> disaggregation. Current AMDKFD does not support hotplug out b/o the
>>> following reasons:
>>>
>>> 1. During PCIe removal, decrement KFD lock which was incremented at
>>>     the beginning of hw fini; otherwise kfd_open later is going to
>>>     fail.
>> I assumed you read my comment last time, still you do same approach.
>> More in details bellow
> Aha, I like your fix:) I was not familiar with drm APIs so just only half understood your comment last time.
>
> BTW, I tried hot-plugging out a GPU when rocm application is still running.
>  From dmesg, application is still trying to access the removed kfd device, and are met with some errors.


Application us supposed to keep running, it holds the drm_device 
reference as long as it has an open
FD to the device and final cleanup will come only after the app will die 
thus releasing the FD and the last
drm_device reference.

> Application would hang and not exiting in this case.


For graphic apps what i usually see is a crash because of sigsev when 
the app tries to access
an unmapped MMIO region on the device. I haven't tested for compute 
stack and so there might
be something I haven't covered. Hang could mean for example waiting on a 
fence which is not being
signaled - please provide full dmesg from this case.

>
> Do you have any good suggestions on how to fix it down the line? (HIP runtime/libhsakmt or driver)
>
> [64036.631333] amdgpu: amdgpu_vm_bo_update failed
> [64036.631702] amdgpu: validate_invalid_user_pages: update PTE failed
> [64036.640754] amdgpu: amdgpu_vm_bo_update failed
> [64036.641120] amdgpu: validate_invalid_user_pages: update PTE failed
> [64036.650394] amdgpu: amdgpu_vm_bo_update failed
> [64036.650765] amdgpu: validate_invalid_user_pages: update PTE failed


This just probably means trying to update PTEs after the physical device 
is gone - we usually avoid this by
first trying to do all HW shutdowns early before PCI remove completion 
but when it's really tricky by
protecting HW access sections with drm_dev_enter/exit scope.

For this particular error it would be the best to flush 
info->restore_userptr_work before the end of
amdgpu_pci_remove (rejecting  new process creation and calling 
cancel_delayed_work_sync(&process_info->restore_userptr_work) for all 
running processes)
somewhere in amdgpu_pci_remove.

Andrey


>
> Really appreciate your help!
>
> Best,
> Shuotao
>   
>>> 2. Remove redudant p2p/io links in sysfs when device is hotplugged
>>>     out.
>>>
>>> 3. New kfd node_id is not properly assigned after a new device is
>>>     added after a gpu is hotplugged out in a system. libhsakmt will
>>>     find this anomaly, (i.e. node_from != <dev node id> in iolinks),
>>>     when taking a topology_snapshot, thus returns fault to the rocm
>>>     stack.
>>>
>>> -- This patch fixes issue 1; another patch by Mukul fixes issues 2&3.
>>> -- Tested on a 4-GPU MI100 gpu nodes with kernel 5.13.0-kfd; kernel
>>>     5.16.0-kfd is unstable out of box for MI100.
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 +++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  7 +++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 13 +++++++++++++
>>>   4 files changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> index c18c4be1e4ac..d50011bdb5c4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> @@ -213,6 +213,11 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
>>>       return r;
>>>   }
>>>
>>> +int amdgpu_amdkfd_resume_processes(void)
>>> +{
>>> +     return kgd2kfd_resume_processes();
>>> +}
>>> +
>>>   int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
>>>   {
>>>       int r = 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index f8b9f27adcf5..803306e011c3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -140,6 +140,7 @@ void amdgpu_amdkfd_fini(void);
>>>   void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
>>>   int amdgpu_amdkfd_resume_iommu(struct amdgpu_device *adev);
>>>   int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
>>> +int amdgpu_amdkfd_resume_processes(void);
>>>   void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>>>                       const void *ih_ring_entry);
>>>   void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
>>> @@ -347,6 +348,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd);
>>>   void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
>>>   int kgd2kfd_resume_iommu(struct kfd_dev *kfd);
>>>   int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
>>> +int kgd2kfd_resume_processes(void);
>>>   int kgd2kfd_pre_reset(struct kfd_dev *kfd);
>>>   int kgd2kfd_post_reset(struct kfd_dev *kfd);
>>>   void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
>>> @@ -393,6 +395,11 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>>>       return 0;
>>>   }
>>>
>>> +static inline int kgd2kfd_resume_processes(void)
>>> +{
>>> +     return 0;
>>> +}
>>> +
>>>   static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>>>   {
>>>       return 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index fa4a9f13c922..5827b65b7489 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4004,6 +4004,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>>>       if (drm_dev_is_unplugged(adev_to_drm(adev)))
>>>               amdgpu_device_unmap_mmio(adev);
>>>
>>> +     amdgpu_amdkfd_resume_processes();
>>>   }
>>>
>>>   void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> index 62aa6c9d5123..ef05aae9255e 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> @@ -714,6 +714,19 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>>>       return ret;
>>>   }
>>>
>>> +/* for non-runtime resume only */
>>> +int kgd2kfd_resume_processes(void)
>>> +{
>>> +     int count;
>>> +
>>> +     count = atomic_dec_return(&kfd_locked);
>>> +     WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
>>> +     if (count == 0)
>>> +             return kfd_resume_all_processes();
>>> +
>>> +     return 0;
>>> +}
>>
>> It doesn't make sense to me to just increment kfd_locked in
>> kgd2kfd_suspend to only decrement it again a few functions down the
>> road.
>>
>> I suggest this instead - you only incrmemnt if not during PCI remove
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index 1c2cf3a33c1f..7754f77248a4 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -952,11 +952,12 @@ bool kfd_is_locked(void)
>>
>> void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>> {
>> +
>>         if (!kfd->init_complete)
>>                 return;
>>
>>         /* for runtime suspend, skip locking kfd */
>> -       if (!run_pm) {
>> +       if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
>>                 /* For first KFD device suspend all the KFD processes */
>>                 if (atomic_inc_return(&kfd_locked) == 1)
>>                         kfd_suspend_all_processes();
>>
>>
>> Andrey
>>
>>
>>
>>> +
>>>   int kgd2kfd_resume_iommu(struct kfd_dev *kfd)
>>>   {
>>>       int err = 0;
