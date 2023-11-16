Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F89FC197A0
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 14:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D26E10E60E;
	Thu, 16 Nov 2023 14:51:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 180EE10E60C
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 14:51:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gipP2nV9MKhq1g2KfuJPFH1td7qkdGtd3nsSzCeL1LCgNecqQNVCcWRnWFk0qOiXr9a7KAunMZgXWm9zFZJShDxTlIPDbOnUXyxwLz49VVYapUmBGiiMXbKVvABlcj59+CTPrMjTbWS3unFeHgYIYoM+gXqLkC+plTjXzRLmjPk8+F54Bid7MrS6h9hs5F09wJLOcvAP3ImjvxIAWuIDjYhmITnSleBIwkea4o8ybNhijDnMT6pctzWLi4dCC8iWIhHVnXEn/5QF95AScCoWVU4cOf5QMq6S9oyqlHinFta2VpmH7fPalKwY7xNd/cWj3Qvm7dDr8tJHdfWrO0CFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okHfLAUn3h6ceTzaUF+ow+uy6JZuAIG5SW0GtnnPLsQ=;
 b=I2c0QwViy1d1bH/bXNbFQslp7VNWSsPZNUZDqGwYpTXUrTOaT+dxrWujkPXrksYof+rUTc6JbBgWe007qw9f1aNpacIdGkBCDRLj7nGdLhztmxciqqe16RUci77tONoyyGr8xgnBis6iF+rsZycTMb/sLf2px/c7kG1VjrrEFY6TpubLMGUliNL8bJnAHyt47cGPZRrwyZpgr9jgwpyY9wtFQr3louXIHdi0pomPfUfvCGLMi901IJuZZT4v8L/+qzdnk4B3RTBgTyXKT6Coy/mHwahIDCNTbTp1KbDD1fSIEzAWPNfSeTEnxeuf8hgl/syvwY+RqZm/4iO2+EadLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okHfLAUn3h6ceTzaUF+ow+uy6JZuAIG5SW0GtnnPLsQ=;
 b=bhoGemim3nUH90UvHEJZ9qJnPO9LuEanEKa42b7GORDuiHWp+ATOQB0PCEog0TutQFVT5NedGckYUVNc7wD7uGR1zXQMj63nV47vDsVjn/AFXTAwKa5tykeYeGVjE1ixg/R++Vr4dSvUR8/vPFpfh9ynBlD2O7hPfYHiPySSRB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 14:51:35 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 14:51:35 +0000
Message-ID: <9a988cdc-302b-4fc5-88e6-75de0e29ad25@amd.com>
Date: Thu, 16 Nov 2023 09:51:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] Support Host Trap Sampling for MI200
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::11) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|SA1PR12MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d2574f-ab2b-414e-a2c2-08dbe6b38784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SqFPAxEg1LQUPzrPs0v1gTRT+fZv2f+EDbZUgJAPjBtgZbwbPVeeWniYo9rb0h/GlueYDwYhgb7Nbe6RKZ8IedFtvKt38Ap3sYbnqmYHQ9ZBZphaPbW6XI1o3Zyy+MDFcSkJ4MpjK5hF/FX6HJQDWzbQpaa1YltULCzxmUuktUeKRWEWCYPIkAQWJ2ZKgH4+NDkW01xrRdJmSGMAgRP+lNhDj+aqJRVXSEeUBhvHVbTMEFoZdPGgfWSBuNMwdzckMbf6GluCcF1iPOeHhtOJ2U1fzLnuIyCHj4q2e7o+bdIR+4HyRJP0C7jsf/vlSSVJeKv0Y9pJvyzts1XkuRiH8GR5qr/DO1ZQp9YU/p9Frgjohv6YMYYIe5jChZ34xFKGEVel+dYOoFX0jTHnU90kSDGX4Ss3hgFjuT43zGjxUqAl7L9I7FOc/5Zi3vby9PevPaJHXtXwzO4ECmQz3ZKObgf4ZMwsfXct/Rrg/plDAyHnz3xB0UeISTdx6wgyalnvrgB69nfhbV7gotmVaqT5OlDRmNW5nqiLJmuFKBIkkVwD0g1Xo+edRFPz6tTZvPWQ5lbkyaUqwJuLcMfdC4PFNB+a1rFCZPZw5ko5QHEjeISzYwMrnlCCP8P5ycefmsszhTYawwdVfbiA2LOK7U6Y6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6506007)(6512007)(36916002)(38100700002)(53546011)(36756003)(2906002)(26005)(83380400001)(31696002)(41300700001)(2616005)(5660300002)(66556008)(478600001)(316002)(66476007)(6486002)(66946007)(31686004)(6666004)(8676002)(4326008)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yks0R29Ib0FkbEtLeDkvd2JlREpaOXFsODlRUTdZUFQ3MEhSbkJiei9YU0dI?=
 =?utf-8?B?cmNYU2JvTVRGTG03Um9oVTAyaStOd0o2dEJ2OERDQlA0OE13d0RxR0Vrcmh3?=
 =?utf-8?B?Wnd3RmxYUjhEQlJkTEl3Zi96L3F5cXJEWEtGdG5KQmR3MGJqZDhOODR2K2Zk?=
 =?utf-8?B?K2xsNFk0R1BSVU9aa1VNejk4VmdvZE83ZGEyZ2NXVW5FNnVFUldVcitVbVRO?=
 =?utf-8?B?dDA5anl0MklVT093Q2V5OHpZaDMrdHZUaEJZWnVzZFRkdlM3NW9tVEtPa3A3?=
 =?utf-8?B?NlF4OUF2RkZrMmJtalBNcWRGcXhhb2pXcHNMbS93clNuVlBwZkVFVEtkSlJQ?=
 =?utf-8?B?dkFLdmtNT3JlZk1zUFJ2TnF6TVl3MVA5NVFPL2ZTU1diR2pzQnVPbnAxQXZP?=
 =?utf-8?B?RW5tNDRUWWRTSDZrRnlDQlljWGhxRE5NMnd6TmJZMGNvczFESHhleGNZR1dO?=
 =?utf-8?B?NTU5UndwVEJicTUwMGt1aEtMV1E4ZXNFUDRNeUgrRC9ROVJrbm9SemtYT2dv?=
 =?utf-8?B?YVlXaVVOVlNXOUNFQkNHbzV4VzdRY0hVY1FuOUZiWW4zcVJXdTN0VXMxZy9U?=
 =?utf-8?B?d0FRRWhPSkRudVpoT254TkFrY0ZVNlYrckF4cXRGQjZxUjNJeHRScnFSZ3dn?=
 =?utf-8?B?UHBNZ3RSRnFiSHhTVkhORk9pb3k1aUJDSjAxNldaVGhWNTdRK21KZEd1SzJ0?=
 =?utf-8?B?Q1lyYktlY0djSEg4M2hNVWJNTWRmL01ZSWFUSTBVRXdCN1NPMEJBNnBGUW9K?=
 =?utf-8?B?NkdzNWhOSDl5a05RSCt2Y21hYVlGaVBZZjY0TUZOVjBHV3R2TVhBd2dEcW9j?=
 =?utf-8?B?T3JUODhUSE5EeEJTcGxyK2JYcG5GeVRUQ3Z3MUFwejhmN1NxcE8zRWdHQWJh?=
 =?utf-8?B?Sit0dWk1NEhVN3lHQTdoT3VNZnZDR1FsUzFNeldHckc1a1JmT0FDTXhqV3I0?=
 =?utf-8?B?R3M5Vk9zTE9vK05MM1UydGo2T0JSenpMY0NVU00waCtOaGZlb0M3STNzbnNo?=
 =?utf-8?B?UlVxREF5WHdJb0l3MThINXRYcEpvKzRvWGNzb0dFaFpIY2lPT0RqaVhsbTNs?=
 =?utf-8?B?dkpRNll0T1hPamZnY0tVU0xOTWJqZWozN2xaTnhseEoxTWsxSWdqd3l3ZGxC?=
 =?utf-8?B?c3d2TnZDcW83blNRZDJLZXZBKzU3QjVidTFLdi9MNWEyRFk0TGxRbTBEM3dz?=
 =?utf-8?B?V1FIUXZMV21FaEVlbDdNZ1VXSUVzT2FrMnp6a1JBMzRIZXBxTS9uMEV1aFpD?=
 =?utf-8?B?R3RDRG9JSHQvb1dHVEZ3Q1BVb0p1cW00UjdONEtKVzRRSE9ZcDF0bitmTE4y?=
 =?utf-8?B?ci9ZZHZkMWxqRmxmQk1GcGNqSDk1MFprRFBHVE90alBONFBPUCtBS0MrbGhn?=
 =?utf-8?B?dGdFbGpYUEVNcFoxU2ZGYVo5NVVkSDNybEJ0bnRrakFKNFVDODYvWmJ6QXNp?=
 =?utf-8?B?VkwwVEFDSnRsTUJHamRBWHh5dXpPZ09yVmQvZThhZ1JsNEFsWmZjcGJyMjNE?=
 =?utf-8?B?RC9qemJ6dVEybzJOeE9zNXRIWEhtc1BOODlHNk5iYVhzRnZNUmNxYnl0MC9q?=
 =?utf-8?B?N0NMcjV6bHZjYVhvWWp5OWN3ZktCOTlzVmpheHVkeEdYb0IrOTczUXRJTWhn?=
 =?utf-8?B?RmozVFdRcUJCZ0NtWmNGVEZoS1d6NVNMZy9lRERhQm5VTnpueTVuZDBGQmdM?=
 =?utf-8?B?UWMyZ3VXVkI4RVUrWXF3ZjFuYjVhWXlPRG9SOTYyMmNEM3MxbExBK3kwcEhv?=
 =?utf-8?B?YmQ5MlpOVTE2M1lFdDI5bmRyVWpscnpQNlprbjVoSEFYMStsQkxCbW5Na1NT?=
 =?utf-8?B?dG9TZlhTNmlYYUZ5VlpNZzZTOW0vWUxzWm1UaWpVdkJ2SldNNDEycDdCSHhX?=
 =?utf-8?B?blphd1phbkJ4K0VNMTV6dzdQb05oR3Y5dGNFUkVsalYzamtPajJaQTdXaXlK?=
 =?utf-8?B?eGNUdENpbHdsK1d0b04yUlRuK1pDeTVFbDMxZnBibmwra0RoZGV4cTc0RVdH?=
 =?utf-8?B?OTBaUHN2UUREdUZmaWQ4TGdGRHZyK0hHeFUxb1luMVRJUFN4S0lzc2QyQXF4?=
 =?utf-8?B?bUpBMldPSS82MlJJZFAyRk5OVkhXYmswVXBJcWtwUnlIb1hHTlpFTjl2QktR?=
 =?utf-8?Q?VXQV0lUydCNYUyrkdKi2SEOHP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d2574f-ab2b-414e-a2c2-08dbe6b38784
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 14:51:35.3118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: durKDIG4WtDWWdoJ5ch0yiTyhxfh2y7ajeH0qC3rRwU4OBfE+ZuLLByNPenJhpMQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping ...

On 2023-11-03 09:11, James Zhu wrote:
> PC sampling is a form of software profiling, where the threads of an application
> are periodically interrupted and the program counter that the thread is currently
> attempting to execute is saved out for profiling.
>
> David Yat Sin (5):
>    drm/amdkfd/kfd_ioctl: add pc sampling support
>    drm/amdkfd: add pc sampling support
>    drm/amdkfd: enable pc sampling query
>    drm/amdkfd: enable pc sampling create
>    drm/amdkfd: add pc sampling capability check
>
> James Zhu (19):
>    drm/amdkfd: add pc sampling mutex
>    drm/amdkfd: add trace_id return
>    drm/amdkfd: check pcs_enrty valid
>    drm/amdkfd: enable pc sampling destroy
>    drm/amdkfd: add interface to trigger pc sampling trap
>    drm/amdkfd: trigger pc sampling trap for gfx v9
>    drm/amdkfd/gfx9: enable host trap
>    drm/amdgpu: use trapID 4 for host trap
>    drm/amdgpu: add sq host trap status check
>    drm/amdkfd: trigger pc sampling trap for arcturus
>    drm/amdkfd: trigger pc sampling trap for aldebaran
>    drm/amdkfd: use bit operation set debug trap
>    drm/amdkfd: add setting trap pc sampling flag
>    drm/amdkfd: enable pc sampling start
>    drm/amdkfd: enable pc sampling stop
>    drm/amdkfd: enable pc sampling work to trigger trap
>    drm/amdkfd: add queue remapping
>    drm/amdkfd: add pc sampling release when process release
>    drm/amdkfd: bump kfd ioctl minor version for pc sampling availability
>
>   .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   11 +
>   .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |   14 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |   72 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |    7 +
>   drivers/gpu/drm/amd/amdkfd/Makefile           |    3 +-
>   .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 2106 +++++++++--------
>   .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm |   29 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |   44 +
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   17 +
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |   11 +
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |    5 +
>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c  |  348 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h  |   36 +
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   43 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   32 +-
>   .../amd/include/asic_reg/gc/gc_9_0_offset.h   |    2 +
>   .../amd/include/asic_reg/gc/gc_9_0_sh_mask.h  |    5 +
>   .../gpu/drm/amd/include/kgd_kfd_interface.h   |    6 +
>   include/uapi/linux/kfd_ioctl.h                |   60 +-
>   19 files changed, 1792 insertions(+), 1059 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>   create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
>
