Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C82C4829E
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Feb 2024 20:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE0B310E55E;
	Mon, 12 Feb 2024 20:10:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jwyhC/6l";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1446110E55E
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 20:10:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtRIZOOdv/nQfNHRvrGDOaKmjL+UXzwkkmoGTL0y8xAVMUPXwDo3Q5LbkmU2d+ZZg/80oVlWONbuk9tZph6DGusPDkpCtiq9CtpD+BIqg1JKhY7Ig1sbkq3xLbAo/qlNBO1IXhDavM/LdYnDE8PjRca+GHIoCx/buCa1izgVhSDg9iJS25k3CsSOhUsvhiOu5wpnRYbxxRgosY5nEoyNuvwelguM6uR5Xs8F4s4IxHQwjIjtPIW+UXhr5mbD7jg0c8E0dKkAC7Sysk3/To5Vp8d4m6r+UI/vAe36UD6uQ94N39tecbEjsv4yxOWOnacQkYgqT/KVoeWwAGqtia5bSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iu4aAJ0m6hDM1vYHzS063WdliJDnKKbfX/vI2jXhi9U=;
 b=ENTH2rrPuHwZzGwwJyh/SeoWE12HUqy43/+bQt+aMmNflJ3FaT1oBCeELIDuP2T7AsX5IvnA4nWHO3q7guomw2PflfIGUUr/rG3ZWyu3pOWDuKvNe/EBiM8WRlGhcGCLHyvaMrkIHDqIIrGpTzill6ZTPIs+HmQoFUl4S4grppOWtdfRqS2p9nBnAIvaNzhSNrFEUGuRWkXeIfUQaJ+lsD3vr2OvV6gX87dXeJ0i2VspF+puMXqiu3htlIOuX2g4/FnqXgKIRMx2WrsbHE1XQ412S6OinOM8fZLHF+SyROF4sCz67UITgYXoA5j7NfV3iRtXLDrVZakS+/NFwWMl/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu4aAJ0m6hDM1vYHzS063WdliJDnKKbfX/vI2jXhi9U=;
 b=jwyhC/6lnq+k79+QjgV48JUOF9AOV1fWeWCH4dwytYQaXRhIwUXA2cqMCzsPm9wNzY/pGmLMulHRqEvB0d8Ru7/409jsBCD4JqdhNp4MrUnGPKdb6sZdGPBpTjvo1S+L6kIV+PD2UC5Wh5O9qJBpXmZYXhKzlsHhkyrs6e3YLqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Mon, 12 Feb
 2024 20:10:08 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::30d9:d8a3:7238:bbaf]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::30d9:d8a3:7238:bbaf%7]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 20:10:07 +0000
Message-ID: <8b88ff30-078a-4c55-8ab3-6a1304f8a60f@amd.com>
Date: Mon, 12 Feb 2024 15:10:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/24] Support Host Trap Sampling for gfx941/gfx942
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com,
 vladimir.indic@amd.com, david.yatsin@amd.com
References: <20240206155920.3171418-1-James.Zhu@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::28) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|CY8PR12MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 097fcdb3-c49e-407b-f2d0-08dc2c069b62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ebohvzdcwKSa5HCKkhzDaCmsTL9nWYD7ty/VC8cRoZWzllfMa4sN/b46lXNJdhS29Gz//GrU+lZkyytScDLeX22G4CK1b7DDbhixj5N264GvxCjsb1yJmZ/f9gjj2hEy58m54eFPF+BAqRwFx25NblGzv2t8X1smu1Uu4o38F44Al8aWXUAdvZBjDczjcj6VFxrKU7df0gVaxyKuQrNh5tm08DZruJ/adEnfHKJCfLDpb4jd1/gMbLpoWRN2JWmK8D05IKkqFExjOw0Bwdl6RF2UPZ9yUwLMIAYf+BRQMY4rCDqkogiD5GEhQd1VGhAj5n1MHUymwIYhKdSILCct8VOw1Bo8fHlYqu4Xy8TaXw7ZYEoX0YDlOIDKGv/ZEoF6hS4fwjT23xdlAnbUYDXxf44AbbNQvf5o5iIpMvBKJKC/9VrTy1QQR/vRMWEqjR/OAD28OznjlcdezCJAgwh9Lgm3WIHSk0rqBte/rG/DTYfwdtTOJ2GyhIoxTl9P0OrPw8+vjDRv+Dgb3e+2jnA5VjBdfMzPTNPfLQBr75M6bYrjpFf5oOqP44b9r4eRkTWT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6486002)(316002)(66946007)(66556008)(66476007)(4326008)(6506007)(6666004)(478600001)(2906002)(5660300002)(8936002)(8676002)(31696002)(38100700002)(36916002)(2616005)(53546011)(6512007)(83380400001)(26005)(36756003)(41300700001)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlhqVnZkVVRXY25sODBTd2V3OFJSUk9xTG9iWCt3KzBEQ2ZaUFl6Wlp1NmJI?=
 =?utf-8?B?QkVlV0NVMzhuQlBkdTJ0Qy80c3pyL3NuL1BQWisvd2duQWtybzlLbDd6MW9N?=
 =?utf-8?B?NXBlcmF4ZjFUc2Y5aGdJcit4QTVGVUsxczVDYWZKclNQK04xQWduQVdqVzln?=
 =?utf-8?B?cTVjRU4yczRnSVJDaTd5RUZ5dTNlN2FISVBnZDdZQjJYQ2V4bEhyR1doOGRR?=
 =?utf-8?B?TjM1aEtPT2NNRmZCYjJ4amoxSkZmQ1dGek0rdTMrZEFEc1RtTjJKOWc5R1NS?=
 =?utf-8?B?U1g4WVJoVXdmZjhLdGoxRm9aMVhkZzhWc2huNUFWR05mVmdtdXk5MXd3UmFG?=
 =?utf-8?B?UnIzTXlTNFg5QWZXUHZQYXQrd0d5L2tMS1h1d3o4WG5zV2dQL09lMm5peEd6?=
 =?utf-8?B?TWJDMUFtWTBMWUNSRFprcjZSbjlOUEZYcGc4TzhMV2Ria0I1cTRxT0hQcTJD?=
 =?utf-8?B?U1dFbDVLTjRMZUw3L3hnSmxCZlk5RllwbSttNzhPRDhVWjhBemhad0FRdE5S?=
 =?utf-8?B?UTFhbFQyQXFHMTVQamVzNUlFRlZIVGpHcFV6Zm9YUDdKd05xejY5ZWZ2dEVy?=
 =?utf-8?B?Y3JXS2NCR3lUWkhuSTRXVFkxclpZYUZXK0I4NWJCQlhTZmhqcFpXOE1xZzJS?=
 =?utf-8?B?M0JFYnhXTm0rZ3d4YkUrWGdNaG5tU1NBNXN5cnYrSHU5a09nZkZJVCtubnUz?=
 =?utf-8?B?OWdTdkFCYTJDQ2hPT01GdjFIVFB1OHo5ejJHZGkrQjc5eTBMQVBhdkZSTElm?=
 =?utf-8?B?blc3TlVoRzU2bjBybkV0OWJELzNBRGFCZFBUaHBmaHZjbkR0enY5RWtsRzc5?=
 =?utf-8?B?ejJGNWczbGUxVmEyTTUxdmFXTW9aL0g3em9kMklBWFhXV2dKMEE4NXBmWDlu?=
 =?utf-8?B?NmoxY0lNblZJTUJ5VlF1MnI2c2N2MzVWQzQ5aVF5bTliNzlOblZkZnBDenVN?=
 =?utf-8?B?aWl3MGVrbHRFTDI1Z2tTTW1ZSklxRzdiZ1NOSjNJS2lzVGhtSFA1N3dWOTBQ?=
 =?utf-8?B?eTBJNTNFR2JsMVpXQ09wWVUrSXhycTFmdU5mQzZCbitFS0dOSlJrMG45RDV5?=
 =?utf-8?B?dWhTZ255SEVYdUd2SUNCaTh1dGpTWUJzZ2ZkY1hBKzU4NmdraU1WM0kvc1Aw?=
 =?utf-8?B?UkFOTjNjNXUzMi9XaXFDNDlsSi9FcTQ0MWEzbFg5TmlTNVd2RytoVGJHRUVY?=
 =?utf-8?B?VnQ4aUFpdjJIMXdCRXgrWXU3bG5kRllZRHFnT1BPM1hZa0hJZDlBTUl5akFh?=
 =?utf-8?B?bUtwNmRaNERnSi9HKzRkU0h5U3pEK2NrNjVQUm1qdzBSWno0NVJqRUJzR1J4?=
 =?utf-8?B?UkpHR1hFRW5SSHk0SVNkS1RQdW9hd1d3ZnJ0TEJpd3JzUjRRN0xSeWpPa3Vy?=
 =?utf-8?B?eDMxdVV4M096L3orblkwemNKYXVadVZ3S0FhZEV0WG9vMGgwb093aUFuSGtn?=
 =?utf-8?B?cVVEVjdCRmdoUFRoSmVJOHREWDRGeDB2c2tkSHNtWm5jWjRpQ212ZzN2VWcx?=
 =?utf-8?B?UlRFa2Z1cDY5cXhRdno2RlpIcVk2bFBlQTUwNHZpUWZiVnRRb3VqeGtWYjFt?=
 =?utf-8?B?QnYyODlHWVZyUVFNbEFFUVptanZBU1R3U1Vsam40aXNDNlcwUTM3ZUErZUFU?=
 =?utf-8?B?SGVUVGNpbU1OQ0lQaTczWmwyakV4Y0F3MkZNbG10VVkra1FaVGtScFlUNkJF?=
 =?utf-8?B?cFVFMkhwZkw4dDBpdEFBcEpBRWdkSGp4WUFSNmZRd0NORmk0Q0FhWUJSN3NI?=
 =?utf-8?B?enlEZFl0M1MzZVdleXNmeXYyODhMcWVEUjVTZVpkZjc4RlV4YWR0U3N6dnlq?=
 =?utf-8?B?UmFsWFNkTkg0bFJrdkFzc2w4NDdPTDArUVR6cjRnQUI4MWxDZERjYVhIQWpp?=
 =?utf-8?B?Y0h0MW01czNCU0lENDBEZUR1VC9aMEsxSElSVkZtUEtiK1hCdnR2RndYKzcx?=
 =?utf-8?B?cDFVc21WcmJITW1hR1JFSm9wa3pVeWZiQVpIVEErdC9jL2JFNVViSSt3UlZl?=
 =?utf-8?B?UnFPV3gxeFA2eFkrSHQ5Q2hldERaZUIwK2U3aHRhUmJ5WjVHNUIyTkdDWGJ2?=
 =?utf-8?B?akMzaFdwMHpUM2hxZlVuWGNBVFhTSyswN2txQmpVcDM2Zi9CM3ZCWHFpWlFq?=
 =?utf-8?Q?uY5AMG63KHEhMFw1sqPSHAPkM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097fcdb3-c49e-407b-f2d0-08dc2c069b62
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 20:10:07.4535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEXJtwuVoke9W21/NwDTBRL0M2xID/c6kBhBaaD9whkEkzpca6Uuh/SEXFyyoW4N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435
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

Ping .....

Best Regards!

James Zhu

On 2024-02-06 10:58, James Zhu wrote:
> PC sampling is a form of software profiling, where the threads of an application
> are periodically interrupted and the program counter that the threads are currently
> attempting to execute is saved out for profiling.
>
> David Yat Sin (5):
>    drm/amdkfd/kfd_ioctl: add pc sampling support
>    drm/amdkfd: add pc sampling support
>    drm/amdkfd: enable pc sampling query
>    drm/amdkfd: enable pc sampling create
>    drm/amdkfd: Set debug trap bit when enabling PC Sampling
>
> James Zhu (19):
>    drm/amdkfd: add pc sampling mutex
>    drm/amdkfd: add trace_id return
>    drm/amdkfd: check pcs_entry valid
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
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |   75 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |   26 +
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |    3 +
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   14 +
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |   11 +
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |    5 +
>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c  |  426 ++++
>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h  |   35 +
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   46 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   32 +-
>   .../amd/include/asic_reg/gc/gc_9_0_offset.h   |    2 +
>   .../amd/include/asic_reg/gc/gc_9_0_sh_mask.h  |    5 +
>   .../gpu/drm/amd/include/kgd_kfd_interface.h   |    7 +
>   include/uapi/linux/kfd_ioctl.h                |   64 +-
>   21 files changed, 1914 insertions(+), 1080 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>   create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
>
