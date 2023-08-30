Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A57C83F15
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Aug 2023 15:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3214A10E552;
	Wed, 30 Aug 2023 15:40:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FBE610E552
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Aug 2023 15:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oy03Cf1usqQjVZAQPEKZ45xhIgOPIu7Y23ew2kYaymcc4rfIs26otzo+VTgoD4yUxF2na62mkIRbsciYvBHjPr3nElwSWmK9y9/iFSCMcMkzgKWC4sR4br7cedhRfUu7995Pj16SJqGefJ2JKX67w/R/f6a7UIS+5ouru+7BKocrN/eEt6ReY/GuqNhn1k6y4OK+jEoolxkPjz23ZhSgSWOIpoavRuRzuDC5INKEJRaKuoV1y9Qg8uIIptHlCDzvg4Hb7gnFOzhSxMWd3u9l4jN/5wb3TYdBwI0M/8nPztW2m5lRn89JkbvLzEgx9ve9bEfXnSuNQ3eXnDa/S8pwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6K+1aNUq+wlhP0TmAqzJaS4mSr/Qg9a5tXm9LDsyexI=;
 b=PiydpUJ8c+JCMyjC5MXM061ughgK6hQj5Jk+cucw6ksimJ3rCZrhYgHY4AEQAlWA/MM6gXmnbVcCO026TLmzPsVrOHsE2ferPgbwdIHLOCTqj6meKDWXF8n2IQooTKWXUI4ObguDtq4PxUC35XbYhRR5jRc66/+WRWB9JX6NbN+xrz/fJo/dxKL6IfRv7txMEOXcggDb8SkIE3414IeF8DfARVXD4C+xxtwa8H0B3qoJeL4iHwnGl9oLp14em3GhCXZiNPbz/5sHy1+J3ZWUkfngvWjOVbHSPC/Tz4wR+kbQ57JsgBo8uehQy0g2UQ8s2pZPTL8H6Xbfi78IGkwP7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6K+1aNUq+wlhP0TmAqzJaS4mSr/Qg9a5tXm9LDsyexI=;
 b=ykl0tBUUMUOWEmwi11V1G42bTr7mQth3vW5eOoF8OkC1o2OIIlsMcS6NkQpgy/X92i+jUTIcPVs8gdjSiUvFcYXLtu55qRVEt1qcNtjlSAJuQfzjBL/75D/+trtqEDnotfaQClSypyiLOdXEydKQY7XhWm+rWIJ5rCQW9TMbNnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5892.namprd12.prod.outlook.com (2603:10b6:8:68::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.35; Wed, 30 Aug 2023 15:40:29 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 15:40:28 +0000
Message-ID: <fd0f5630-de59-cb8b-4c4d-fb077cabdfee@amd.com>
Date: Wed, 30 Aug 2023 11:40:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: Fix unaligned 64-bit doorbell warning
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org,
 "Sharma, Shashank" <shashank.sharma@amd.com>
References: <20230829161614.93007-1-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230829161614.93007-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: ca51c5d4-9947-406b-b242-08dba96f6fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p8ahMHtPs+FupegccaL85jEJhkz3pwxw6jyahZr0G1EP5oPVFA/czeQezu2VI+ayKRjuBo1iJDh80VjFgWcloXyjjKDyhKOL0uaaXAaE5rjR8vr3KBFYqg9+4JIXk5pNlJBSLmVLUY+WOIZ/oaFeUns4s8tZCyQPiAuLzBLvs3t5iFGQXl8pbrUqgYhHW5Y1bUvD69iyiWg6OymW8pm19r9cyJ4Qghh1La2sYU7eWZEG30prRKg6emYajHXyOIOL63GfJZ26tVaeW8pNa/PS0Bt4noc3RkjkeOD3jbJqPm8u40M9XX9aK6ao11mthJGFQHbHIi2zYB5IDU3pAUD5QE9R+/tFJ+N9hflX2BdJt7lCmujjIp4aVvTEJIU1+iJyIFB2/mxPPRWJ/w7Z6dyKjVcxu8p5iO5JogGc/6j/U1UkHmX+Tybx8NFPjMGBBgmwjStgxEOqRskR7imFmaV66aUl2nCgaX63gAa1mvZszBscJZN1sutCeROiSDXbSY4KqeS61TinCpzAH9LXglqd9LNMDjbgdWWBeEX7DQk0eZ/WW9Qv4LM9dvZ8GkaOXtYNOJdyhZorziIjIdtTSh+dRO/XbeD34UVds1MplcTZvHR/APAD8ZmyCDRwQ+khB7geyB9T/8GNjGjiabgr5WIoxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(1800799009)(186009)(451199024)(8936002)(66946007)(31686004)(478600001)(110136005)(53546011)(6506007)(36916002)(66556008)(66476007)(6486002)(6636002)(316002)(38100700002)(41300700001)(6512007)(5660300002)(8676002)(44832011)(26005)(36756003)(31696002)(2906002)(83380400001)(2616005)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djBPVzJVaUJTYTZLQ0EycHp5ck1FWG8yc3EyUXE4NmRiallKN2dJMjUwSm4v?=
 =?utf-8?B?OGg3VTRSVlh1WGJHYzU3TkNaTUJrZ2l5RkZ4bndsRFI1cjRnTThTWXFMbWZh?=
 =?utf-8?B?L3NaU3ViWHZ4RWl5VFNOOXFKRkw4S1g2eG1CeTVUcHJoazZHNEJCTFhUL3VB?=
 =?utf-8?B?MHFjNVk4emtIWGxYeWtReXNnSngvTGY3TGRCZ1BQMkIweTByblcwaElSZWl1?=
 =?utf-8?B?cnQvVndDSjdXc0FkZTBISVZ2bnorUVVzelFxSjI5NHliUkxhWkY2MjZMSmlB?=
 =?utf-8?B?WVBnUXVvOTVaQVRSYWE5U0VCb0EwR3cvOFRUWmNWSzdhQUdOckJVSFJTcVpj?=
 =?utf-8?B?ZHcvOStaSkltc3FHNUNENmwvZFFhRXJVck9xVUkraVh0SDUvWWc3cTFHeE91?=
 =?utf-8?B?YnNObmQrY2pBYWRmSjIzVFlzMFI0bnMxY0s0MVYvUkVUNmZGZ3V6L0lRaXRL?=
 =?utf-8?B?dVhYMC85aEhRcm5tb08yRzhKVTFGalF5RGIwK2xnY0tNUzAxVGV2RFhjYXZ3?=
 =?utf-8?B?TVhkekZDTkhPU2cvWDlzTGNxc1ZYZDRmVVlXaVE5UGZPL0hmMzRsNnErbCt3?=
 =?utf-8?B?NmZrZk0yS0Vkc3VPc0wxYXVuY0Ntc1hxSGltQThFem82SWFYbGNqZUlmbFJk?=
 =?utf-8?B?S3ZLUElHOVNyODJEVENLVmp6YkZ6a3FPeHdDQnhEeVF2QkpmZXlIclQ4KytO?=
 =?utf-8?B?cE80ZG9GQTJCWGFidlVoWlJpeFhvc0hHckE1ZHNLVlJVQTB3TW9UVTFyZnhu?=
 =?utf-8?B?eW5kVVZ2aUlDeE5pRlpaM2ROVzhDbFh2QjFDZnVlRjk3amVyaXdqU2RZdVcw?=
 =?utf-8?B?RncvU216cXp2YjBoeEkwOXdiZzFNSEtic09aT0U4K3RYbzFWWXgxbGM1VzJz?=
 =?utf-8?B?TzVHS3JNMDZreHVTRGhlQmd0YlR2SXdSUXFTc0loVnVkWFdKWVpBdjFEc2k1?=
 =?utf-8?B?b2x1dFhZenhvNkRnTWRjSTYzWFA5ejhnVGlmNkl2TDVFV29tNnNuRVd0V0NJ?=
 =?utf-8?B?SXQ1VjJLcEtrNGRkNmZNU2ljYkg3a29TcXVwU3gybFB5ODhFVkxWRDM4YU80?=
 =?utf-8?B?bjZDdEFKdUluMm9kbWNCKzlIcTMzZjBJR25RSXlpWGRnWjhJd2d6Sk81U3lL?=
 =?utf-8?B?MTU4ZExhd0lDcU0yNzF5a0Izem1oRk9jMnlzdnhNWUIxU3F4UHVDRjBzeUVW?=
 =?utf-8?B?OEVsQW55YnZKbTZ1eXdkSGF0VFZKaHkwK1lIVEZEZW5FQkhLZUxhYXVabnlE?=
 =?utf-8?B?OG5oYjNNUE5rQkI1aWtTbXB6blpQWFI2ZEZIcE55TnV3Tzg0REZUb2VxcWFS?=
 =?utf-8?B?SDE2M09MZjJ4TVVGdXBtQ1lJVitYRjFkUStwenZnWlhxSG44V3JJTVhPOSsw?=
 =?utf-8?B?RFd2YXVYbkVpeWNGeXFoNGFEcEVXUjN6MUdqSEhVTGcxNVowUVBiMHBQdm9y?=
 =?utf-8?B?Y0pNZkNYY21CTVloMytGMVp3MWxPeDdsTG9kN09mcTRSNkZwRno4VGUxMnB3?=
 =?utf-8?B?RVdJVy9vVmx1TWNkUlRTa01Sck5TcUxhMXozcjVTYzJ1QVdyNjN3anZSQ2tm?=
 =?utf-8?B?c2xBbkNkK2JrYy9YQjcvczdhRGJrTTdqbWxIQlgxOVZRZEJ4anhNdWEwRS9y?=
 =?utf-8?B?N2RxRWJUc3ROek94bVdqKzh3L1hjTGM5MlBlQ20xMThMMmhrd21tbnhMVkov?=
 =?utf-8?B?aEh3VDlpYkJDN1hURGJKbGQra21pdTdSTXg1TDZRVUp6NVBUckY2U20wbjl4?=
 =?utf-8?B?UStnRndYNHpPN1hSWnp1RHBraERFYzA4RXJ6cTNIRlkxQmpTWGQrRThiNHdN?=
 =?utf-8?B?ZVNPM3VTaVV3bnF4Nm1BaTR3dW90YnQrTGlJQ0VDWklsNlI1dm9LbUNXVVdU?=
 =?utf-8?B?enhZdzZGOTNkR0d0OHVHalZuZ1k5UzVlVEJGNmtJZktoT0Y5M2RnNElwcUJQ?=
 =?utf-8?B?VUJLT0JoVmtGSkM2NEtpTWw5amc5VjlKVHVnNVQzRTVSSW01aXBUWVk0SHJn?=
 =?utf-8?B?QlF3a0JsZDdvbEdxZ2dCUW5RY3h6VGQ2QXJmRnFTMEd5MXZQd3RoRjRKSXdK?=
 =?utf-8?B?R3lwWmNRZ3hPaHJNMTVQWnUzYkl5NUFUaDRDdGZpdlhsUHRkM2srYXE0Unlp?=
 =?utf-8?Q?4qcwJkwv7bQXsfBBEYR/A5OyA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca51c5d4-9947-406b-b242-08dba96f6fe9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 15:40:28.8868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9NcblCiFbh+dh5x8WaK0ockMQ8Q5E78tFiY5/vaBNG6I5FYw0XATynup+e/lRztG0USj9D6xMRl97bUp/vZsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5892
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

+Shashank, FYI. I believe this is a regression from your patch 
"drm/amdgpu: use doorbell mgr for kfd kernel doorbells".

On 2023-08-29 12:16, Mukul Joshi wrote:

> This patch fixes the following unaligned 64-bit doorbell
> warning seen when submitting packets on HIQ on GFX v9.4.3
> by making the HIQ doorbell 64-bit aligned.
> The warning is seen when GPU is loaded in any mode other
> than SPX mode.
>
> [  +0.000301] ------------[ cut here ]------------
> [  +0.000003] Unaligned 64-bit doorbell
> [  +0.000030] WARNING: /amdkfd/kfd_doorbell.c:339 write_kernel_doorbell64+0x72/0x80 [amdgpu]
> [  +0.000003] RIP: 0010:write_kernel_doorbell64+0x72/0x80 [amdgpu]
> [  +0.000004] RSP: 0018:ffffc90004287730 EFLAGS: 00010246
> [  +0.000005] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [  +0.000003] RDX: 0000000000000001 RSI: ffffffff82837c71 RDI: 00000000ffffffff
> [  +0.000003] RBP: ffffc90004287748 R08: 0000000000000003 R09: 0000000000000001
> [  +0.000002] R10: 000000000000001a R11: ffff88a034008198 R12: ffffc900013bd004
> [  +0.000003] R13: 0000000000000008 R14: ffffc900042877b0 R15: 000000000000007f
> [  +0.000003] FS:  00007fa8c7b62000(0000) GS:ffff889f88400000(0000) knlGS:0000000000000000
> [  +0.000004] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000003] CR2: 000056111c45aaf0 CR3: 00000001414f2002 CR4: 0000000000770ee0
> [  +0.000003] PKRU: 55555554
> [  +0.000002] Call Trace:
> [  +0.000004]  <TASK>
> [  +0.000006]  kq_submit_packet+0x45/0x50 [amdgpu]
> [  +0.000524]  pm_send_set_resources+0x7f/0xc0 [amdgpu]
> [  +0.000500]  set_sched_resources+0xe4/0x160 [amdgpu]
> [  +0.000503]  start_cpsch+0x1c5/0x2a0 [amdgpu]
> [  +0.000497]  kgd2kfd_device_init.cold+0x816/0xb42 [amdgpu]
> [  +0.000743]  amdgpu_amdkfd_device_init+0x15f/0x1f0 [amdgpu]
> [  +0.000602]  amdgpu_device_init.cold+0x1813/0x2176 [amdgpu]
> [  +0.000684]  ? pci_bus_read_config_word+0x4a/0x80
> [  +0.000012]  ? do_pci_enable_device+0xdc/0x110
> [  +0.000008]  amdgpu_driver_load_kms+0x1a/0x110 [amdgpu]
> [  +0.000545]  amdgpu_pci_probe+0x197/0x400 [amdgpu]
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

This should have a Fixes tag:

Fixes: cfeaeb3c0ce7 ("drm/amdgpu: use doorbell mgr for kfd kernel 
doorbells")

The original code before that patch used "* sizeof(u32) / 
kfd->device_info.doorbell_size" instead of "* 2". May be safer to 
restore the original calculation to have the correct doorbell size on 
old and new GPUs.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index c2e0b79dcc6d..b1c2772c3a8d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -168,7 +168,7 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
>   			"     doorbell index    == 0x%x\n",
>   		*doorbell_off, inx);
>   
> -	return kfd->doorbell_kernel_ptr + inx;
> +	return kfd->doorbell_kernel_ptr + inx * 2;
>   }
>   
>   void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr)
> @@ -176,6 +176,7 @@ void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr)
>   	unsigned int inx;
>   
>   	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr);
> +	inx /= 2;
>   
>   	mutex_lock(&kfd->doorbell_mutex);
>   	__clear_bit(inx, kfd->doorbell_bitmap);
