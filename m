Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69449C4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 17:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D76B910E4B5;
	Mon, 11 Dec 2023 17:35:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B05D110E4B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 17:35:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHVBE+cpdN5f/Qbqilf77nWEcohObvJ3ZHeX+IJKgyBhnM6wHulKydASpfUNS2c8+bZICjSsHt6ij4iqqZFJY5j1i81fCKvjwcJyN0XXK0IVCA25QyCUu6susDulnhIKn38vS4F4g8rNamPG131ottIE8nRF8jtNjxUNRFLLAXlCsH1YdHptK/u0ZZK1i+Zn9rZ9okV4qlLDlU9hOzD2FDC9zD4U/48ztF27BLW5Jw3LuXPWfCPkQ2sHtvELRsSnUxXZ+pG1QNWFKs3xb8RJbk2ks1fAVKW+mrXyJYpmc9bds/4mxuTB4NaGsQUVE77Rmrouzfhjqz+UDKkk5zg5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvK/+XdUuwzV3IyNvdrld4gQuAu0GRQiC/QhHgVDJSA=;
 b=bpBG7IHPXb7sg1EEkDDK+3dzaukFF6YXm9ZSH6u3SBZ9nVA258qaYlpDfRCHgUCfmGljXUUjaMIAGy3T2jEy20n6anD0xuVqLzJ2vDKFPPNzUocoXAQA3gv31p8AlVyTn5LceBKregfLv+StWCx72LZlm6ot2X7RiKN04kjmQ9Mah1N6DflpvKEO5i87Cw/SvI9AQ3OK5p0A5YVQfJb6YMfNIYvqe8RUfpfqtoIpOYulqfx7pvTaj71ZTaEgbWe99+iZTwpq7x2MseHxZnx+w6PgoITrnevKzYDDhQxnDURGnprsv2I/9vM8QhfoGfQa9fHyXiw+XR2Nge07rRXrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvK/+XdUuwzV3IyNvdrld4gQuAu0GRQiC/QhHgVDJSA=;
 b=Psssl2a64Y1aNb2U17dddrd1mMNlH10/G2tz44Q1/BnoSoW4fj7Z8akveo7LDqTbHLVKbqqKJvdoUeRO/c83fXjpDP4PWnw1wXbg+UX/AU4zvaj03+LBdclV/5yZpdh15IE+5LXSEN0J6dsNj4YUAWY7AlKCsPv8h68hWSlySm8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 17:35:25 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 17:35:23 +0000
Message-ID: <31d29323-fa16-4d07-9212-cbe27cec75ce@amd.com>
Date: Mon, 11 Dec 2023 12:35:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/23] Support Host Trap Sampling for gfx941/gfx942
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231207225422.4057292-1-James.Zhu@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20231207225422.4057292-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::13)
 To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 445fc0b7-ffc8-43f3-c7ae-08dbfa6f8e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OElW00Du3HwU/KTT2hoXHEToDemuXJV0ibyU2qA2tadNTaJVeetJfj49bO/4Ri1dGXwOxgyJzjm8ZSSi8RIZJbGwKmwG4JXtFp006di0Tb9dHSXHCCPtb5RioGyx5rW1cZKH6PLIrxpesm2Zfgbf5aoZvws1/oPhJK6E8qZOfDya/ftQOtI3KD4EulIACv6jqiXcUZEHs+gDvnoKe5Wll4iVMOhhfQd+HeiqZ4k5lxQDi/L3JGp23gvWBiLKiiIQIuR/fceLvafozUw5KL768076y26fKlCEGG3oKhWqWchbgwkdbWvstFLapBg+aV2SOQyB3Sh4MTssK2XfVBZ7iRb6F/Hd4hUpo5h1ASH5C7Er1V48HWGJK4tL/+xgjte7pwneIjlsPJCVhxLI2tvZC+oKq1e8D/MxGCcEHwS4RNbmGJKtLOcKlbbs8//1LMgjUf4m3Eq4+gtKajYe9m1O9yMTcHikjzgN/mvDln94AzJBWPuR//+mlhXsyKhIpXp255k3p7WOjCiQWopn1zShgQDVTcPzwEUZcJDqGgfBdBU2X5F+ofNMjV6rydMr/cq7FQEpfCyoKoeKolloh6Kfvqfnuc6mOY10kQfoITDS9ef6rtWbIuFZmZK/YjX4bMk4y2/HdibBIujMrTrykobueg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(26005)(2616005)(36756003)(38100700002)(31696002)(5660300002)(83380400001)(53546011)(6506007)(6512007)(36916002)(316002)(66556008)(8936002)(8676002)(66946007)(6486002)(66476007)(4326008)(41300700001)(2906002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVNRSUdRZCtXblpoanY3RXZpQXNYeFM2d0xVeGgyb0lFcXZwY3JmZWMybDd0?=
 =?utf-8?B?SCtsK0NZeWxhNGFKSmI3Q08rSzRDdHVJYWQ2ZmE1eFNBdERXTGxGc09ZSmNh?=
 =?utf-8?B?U3RveUcrOFlpRFJZRExURW9qUFNERVAzWkRQTmZlT1BNVzA2VjJ1NFEwK1VY?=
 =?utf-8?B?cExpRjdzdE5BWkZ5M2hCcVJBTEVYcUVzVEg3Wm1pdzdVYmc1dnhTS2NaRy9q?=
 =?utf-8?B?MGx6OFpxYjQ1WG9YM0paM2phSHI4NkVTUHJzdVhxTnRUeGd0aS9oem5qcEFI?=
 =?utf-8?B?T3RxZGEzTTRSd1ZuUWZBQm85UWF0VDVhZkpkbzNGdGdHbXc1anRORjFmVy9q?=
 =?utf-8?B?cm1yZTRUREg5WG5zR3ZtUEtMcXl5YytiaEFzOTQvUGVqeks1MXFwb2sza1A3?=
 =?utf-8?B?RXd6b1dvL2l1OEZPaTNVYXJLM09lZ1lpVnpxT2NFT2pGSS9FUklFVHIvSGlO?=
 =?utf-8?B?N0lidTE2eUNZM0pjNElCZmUyeStPRmRURUg4dkpqSi9jZzd6SC96RTlXV1N6?=
 =?utf-8?B?Q1RIYk5NNkVZWHRiVmUvWUhvdDFJRUpVbFZ6enhhZXFkcmVhWUlHbS96UmIv?=
 =?utf-8?B?dmZJRU5XdVFEVUFLQlVuNmRnKzJyKzNSb2VZVEE4MFpQeXBXbURzS0xXbFJr?=
 =?utf-8?B?TFJZTWRHY25nOU1OeU0xSkFRSjFTRmhiNHNTa1V4QlVuTGhjdXJEQzNFQ1pr?=
 =?utf-8?B?MXFWMnlmOHdXenF5MnlDdkU1c0IxNC9CdDlJdDF4VW9ubkkzRitqT2JnSGZU?=
 =?utf-8?B?aTNvaHZXeU40ZVJydWhtUHg2WFpnckdlUUgrbVJSYkc4ZlFsVXdubWw4cTQx?=
 =?utf-8?B?clliUGNWYmpIazh1VUpkQkFqRnRSdkhYbGFHSGV5SjVmam1UVXc0VWRoek5n?=
 =?utf-8?B?dUc0U2FhMVdZdzBvYlpySVRqV3NGNVRmaVpWakRWOTA2V1dGMjROUmNMV3VK?=
 =?utf-8?B?RUxVb3NxYmxZN3ZsYTd2d1JzN21XT0IxR3Z0cDQ0aHF2ZmppcjJ6ajFXTzRG?=
 =?utf-8?B?K2o3R0hxRDVOdnV3Wmw1ZHVOTTU0K3QydWIvOGlhQVBUQ3JiMUtEZENrUURj?=
 =?utf-8?B?MkovcjdTcXBLbVphQ0R6bDBJQkxIOWZJNFBXTHlSSzJJVmJZV0JNNVdsV2Q5?=
 =?utf-8?B?Mm9xWnM0RzN3V09BKzNiLzZ2NXZDMCt1Ny8yLy9yRUwyUWdteFp6UGtjc0dF?=
 =?utf-8?B?Rm15Wm9wTGJ0YmZuZHVMSFJpMHpKQ1EwZWRyQ0o2cmNwYmRyVkYxaldQSHpi?=
 =?utf-8?B?RkxKVkZ5QzYyRzZvRlV5ZUNtczFrTys3dWxYa2pkKzB5SHpRYWpza2ovNWxZ?=
 =?utf-8?B?ckR3KzZDNGJ0N3hDdzRFeGFWZWRUcFd6M3luY3ArU1pySFM1YnpmWWlNVEdx?=
 =?utf-8?B?KzZUMTNBaGV4a1hBckh0dGtPTVdHaE5OcjA3Yy9yODBPQmJPWGRVN2E2emZ6?=
 =?utf-8?B?dUJvLzJyZGxwb2plNTFDSWI2YjJaeDlUSFk5SUlpYzkvS2VwQy90bHIwdC9S?=
 =?utf-8?B?RE05MmxnNDNWWGpuSHdnNzJGQ0RqRUJnaVA2cjVUSWpaajVreEtYNjhsYWx1?=
 =?utf-8?B?eUNsUVZqaVh0cTZsazFHVHlFQVBhRHR2Y0RKWmxIQ1ZscE8rTUxmNXBtcFdF?=
 =?utf-8?B?ZFpjdWdneFVHZnhkNGhjcGREYWpPdzVGVW1JWG93bWE5dEZJeWtPVmNCNHB6?=
 =?utf-8?B?N3dIWDJ3Vm1wSllEOTVnWUJsK09DMEY5c29JMm1hQjFYZEs1T1VqbnphOXhC?=
 =?utf-8?B?cFA3TEhsdUZybnFEUTZTdVphN3A3Qy9TcmJUeS9peWxDM3lnenRDQ00za08r?=
 =?utf-8?B?VXhhVjdWelhNZUIzRG94TVVkMzZvS3dQZFhWeFVBK1BtUHZkbFlyaUxuRkFk?=
 =?utf-8?B?elNYRHhaMEtRL2NIRmFhTWRZNXJ6SjV3TVc4ZXB0dEpZeW5mNTZFaWNvUTRo?=
 =?utf-8?B?TkFPYkVCQ25xRlpwRVBDOG1oM3l3VzA4cWJsNUxJZ1RvM1pCWDdNeVZZLzNt?=
 =?utf-8?B?SXJxSEVoQXF3RjNWQkZnQnpjNGpKZjRuWmR6NVEwZGEyQ25CQmZyMVIrY1JK?=
 =?utf-8?B?N1RlNjRkVnNwbjlOZ3FYbGhnN3JYMGMxN25EMUp1M1NTMEF2dGU5eElSejZt?=
 =?utf-8?Q?n/NfTDq7DuKozEeWVeo82amfD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445fc0b7-ffc8-43f3-c7ae-08dbfa6f8e1b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 17:35:23.7891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWF2ARDCI7/d9cOrzVpEQCfMk6RmaMuGf+6UHTo2A3Od+zYYYGmxMU3pYPreKi4v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520
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

On 2023-12-07 17:53, James Zhu wrote:
> PC sampling is a form of software profiling, where the threads of an application
> are periodically interrupted and the program counter that the threads are currently
> attempting to execute is saved out for profiling.
>
> David Yat Sin (4):
>    drm/amdkfd/kfd_ioctl: add pc sampling support
>    drm/amdkfd: add pc sampling support
>    drm/amdkfd: enable pc sampling query
>    drm/amdkfd: enable pc sampling create
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
>    drm/amdkfd: enable pc sampling stop
>    drm/amdkfd: add queue remapping
>    drm/amdkfd: enable pc sampling start
>    drm/amdkfd: add pc sampling thread to trigger trap
>    drm/amdkfd: add pc sampling release when process release
>    drm/amdkfd: bump kfd ioctl minor version for pc sampling availability
>
>   .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   11 +
>   .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |   14 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |   73 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |    7 +
>   drivers/gpu/drm/amd/amdkfd/Makefile           |    3 +-
>   .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 2106 +++++++++--------
>   .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm |   29 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |   44 +
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   14 +
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |   11 +
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |    5 +
>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c  |  372 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h  |   35 +
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   43 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   32 +-
>   .../amd/include/asic_reg/gc/gc_9_0_offset.h   |    2 +
>   .../amd/include/asic_reg/gc/gc_9_0_sh_mask.h  |    5 +
>   .../gpu/drm/amd/include/kgd_kfd_interface.h   |    6 +
>   include/uapi/linux/kfd_ioctl.h                |   60 +-
>   19 files changed, 1813 insertions(+), 1059 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>   create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
>
