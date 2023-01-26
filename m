Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE7FC61DA2
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 14:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C5C610E910;
	Thu, 26 Jan 2023 14:28:29 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B5010E910
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 14:28:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTKrGys9dF72tOebaEjnO9vk/GfVpX8gTwHlMK+dNK5bVSq9pdS3Z0T5zzgnHZ9NTJcGH4bE9j8p9/swY/ZX8KUrOLAlSmRj3SUtHnDWbe7XInHmxtaBYjXsJMwDGOIzWcquIJL7xN5AbfjVr+ZYzM+ybA22zAFB8FonHG8PktNJrYw4fcxfFAoJqWBHISk1C9DZjBXeLiY0gEXGrx/8luVzaTyv6PHnahtThfM377iEoU7VT3DQTChgQ+PL3ahwoNXSprKGnK2Rb2XPrMeo8wJIlnWfAmJGO/3p1NmtqF8gwPEi/UjfB3+gIIGlNVurdKJHyJs60QwqfL7hMslSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgthDBAIyVAG4YVepic7m8jCAI+0vyHCfWYAwbFIEQk=;
 b=eu53ps0oB3oOKS/n60z5yT7KSVAi8pMiUcU5z7JULzM0oFSBoWrl3AiuEJkwBjMtYeLC1dc6u4NVUPj142bdj5AjzgP6+Mi+KAFX5VjJX3IhkozhPZjgDY0Vt1iJlUzOTgnGlL6Ld5I0FXzzpeUGV7W6+Hff8Y0+YCBWXIK3mdI/uIaxypdtJhSBqvCaF+DaA8F03FsvibaHAc71SsxbJRckJBLBwT2RL1c2MGdNkkDhzgFcnYx7zNDZv87irgRh/M9gKV+oJL2H7H8uC7b+ygKRV0UgeCQxvjnlIegJ7ue+ZvoN0VltfrPFFVNcpm5V7sZi1OwR7Vbm63lOMGS9oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgthDBAIyVAG4YVepic7m8jCAI+0vyHCfWYAwbFIEQk=;
 b=RQJ7Y93mn6ev1CwP1NNokPZAvIBNjmeROiP5NKRUBR+XWnAGd9d9uyyZRxh8uYzItjPjIMKomAlANuOhl1lw4LIAMYLii7eNn465aH9YGdAhoaIp2wg6OIAWPF0TqDeMe2HlnWnSyWxTgWjCgtqm16zrvlArqC4i3CwtotZW5O8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1897.namprd12.prod.outlook.com (2603:10b6:3:112::8) by
 PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22; Thu, 26 Jan 2023 14:28:23 +0000
Received: from DM5PR12MB1897.namprd12.prod.outlook.com
 ([fe80::d588:bc04:8f3b:9546]) by DM5PR12MB1897.namprd12.prod.outlook.com
 ([fe80::d588:bc04:8f3b:9546%7]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 14:28:13 +0000
Message-ID: <5fdf26a1-2ad7-51f3-2eb7-cc2e9813a4a5@amd.com>
Date: Thu, 26 Jan 2023 09:28:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] drm/amdgpu: use pci_dev_is_disconnected
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, yipeng.chai@amd.com
References: <20230125171630.112605-1-vitaly.prosyak@amd.com>
 <20230125171630.112605-3-vitaly.prosyak@amd.com>
 <967c2b94-8985-e25e-787e-1f959b13b71f@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <967c2b94-8985-e25e-787e-1f959b13b71f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::19) To DM5PR12MB1897.namprd12.prod.outlook.com
 (2603:10b6:3:112::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1897:EE_|PH7PR12MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be9843f-d614-4a4b-c05b-08daffa98e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AWAzlQLencqZL/DW+ybELBILu1990FR0ChDmJxK4t0/2c0XjmXdzCMldqLdfne9mnLKH7Yzu9v6JAgxG7Rm99Y5eKX9DfK/Kx14jXwE+Q9n23CosjQSo9n5HqJOHQHpoBFN0M3pNP4vPVFPH0yhUcSFMDsZVisCyX7uDrVE3opxc2knR4f9UEGi3t+65ONu2p+cvqqkB5MXbWmfFwjmJRkSgqT4UtFAAD3+NlbPM7eOYBwn3HWKAZ0uvKLkHyXTmt8dSKg1j6Dtb+yN58530A0FOofd7bwHlyaPR49vHzvFMt3+Kzll1sA7l7K7g1P/7sHDZeUHf8ovi3DKl5K33ONIegjgoX06KXlgIIB54yLtU7NHQLxRf8l9aW563eTM4CLsOQYLLXhZ+TwZaPwUaOOBi7LZHW8F0XIjuu1tuuKwWlWzErW3QJ3q8AyvTIQD7rGhgwimw5zbQxRWFSCkVAcMMRTR7asQ0iQoDyFQcWOhHMc/tzTpveQ0e4G0vPquhkIG++DdhStJMXTmNrsWc2LdghqUmFTCOE4v65XyxMjMencD4kT3z5WHpruh0Iyz4Ze1gmncxKXKK9yXiMdG7GWHBKZ7TmaIYtVcXFQy6+26FTwGgHlWMC4WwytlC1tgrOa/OGwkYXELMJ4LvHHjOgQbAMuNoB/HI/WSXCL+6BMpRx1o18xq9wsIx6oFyrryLQ66f5Cron0Lvak+m2VYEGjZ2MERN0o2i0V785QzW8hw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199018)(36756003)(31696002)(2906002)(83380400001)(66574015)(316002)(6636002)(6506007)(478600001)(6666004)(53546011)(26005)(2616005)(186003)(5660300002)(6512007)(8936002)(38100700002)(66946007)(66476007)(41300700001)(6486002)(8676002)(66556008)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zi9jM1Yzc1AzaGFCcWt4YytyZnZjWXpEdjZ2Y01hRWZheXNXRzZUR0RTQTdh?=
 =?utf-8?B?OW1Kbm1TcEFydlQ0bVlhamxzL3JlUXVBYWVjRlg2dkJCQ1ovc2x1MlcwaDZt?=
 =?utf-8?B?MW9oT3gyRlZqY0FxT3pvcHkxcnVKQzg4NHFKbDVWcEdnQWMxMWtkeHJ5SVRQ?=
 =?utf-8?B?c3B3ZTNNQzhERnBmYVM3UVNDQXEwM1lvSjM4NmhRQ1hDQUdlOERZMXpFOHB4?=
 =?utf-8?B?MGlkZm4wZkxFOWdiWXp6cGFNb2MvUTBHV0llLzMvNzJuYWw5NURiMVpMVHdK?=
 =?utf-8?B?RlE5Kzg2SzZYWFFzL25FelFvWXkyVHJZVEJSMTNYK1JFU0JRNWFmN3ZBd1VN?=
 =?utf-8?B?MzNqWWJEMW0vMnJBSGpkazdscklGZndiN00wY1VFRTh1RjVzVjFSVG1pcysx?=
 =?utf-8?B?S2lINkdlTDNpQUJ6Q2paUkVQVVY3WEFIU29udkY1cXg0S3lCSDlMVk5BQ0lT?=
 =?utf-8?B?aU50UnhhSGlOd2pEbFRkck1NRlJ6cGU2dE9KdnFsQWUvSU9mUHFkaEhEY09j?=
 =?utf-8?B?SG52TlNFZURqOVhjaW5iWHlWN25pb2VwR3lJZUlpL2cwTEZuQkNPcld5T3VT?=
 =?utf-8?B?Z1IvUXlmMmd6dm1UUGZWZ0pIVnBiOW1YYkM2NW1pNXpPOTlnMEg0WVZTdHdo?=
 =?utf-8?B?Z2d1S29YMGZORld1TVVFeHNneVc2SW5TMDRkR2twcGJjaUFzK1R0Q1F4d3NT?=
 =?utf-8?B?V2R3OER1OS9hUlVCRXR1MVJhUTZFa1REU0JyWEMwU3lxM0lLZ1YvZjdFWm1D?=
 =?utf-8?B?VnJncnVGc0NObzYrdEVNeFZGWTY4eHRUUmV0U2ExZW5RTzhWdldwVGtEUlJ3?=
 =?utf-8?B?K2lObjF5Wm5vR09XZXpZVGQwWThDbjZrRU1EbUFQMGxJZzluNG9PWTB4bWtL?=
 =?utf-8?B?d3dJOWF1UmFMNE04RDdYM1lmYXNjblJjeXBVSWc4SzBUdDNnOURqbTZhVm5a?=
 =?utf-8?B?endsUlBrTlo5ZERMcUYyNERhQUhmMXhpWU5ka25hWjgzY2dIcDRxR3NhU0xB?=
 =?utf-8?B?SUt2OEQwS0ROdFluMGxFeUpyV1hrZEoyaTBFTVNJQUJRZUd2dURGanZKOWVW?=
 =?utf-8?B?TTh3NVYwQVRnUEVkSml3WFNDdlhwNGxJeTV1bHl5Qi9FbHAyWExtODViUHk1?=
 =?utf-8?B?MFYycDlYVXRvSi9URGdFMytPRkQvMW54YTJOeVcxcUJZWW5CSGZ1VU1XSmR4?=
 =?utf-8?B?YWJQSk1CQ1R0VVRXY0RvSlViWk4veUZsWU9QTUx1THFINmYvazhlQlNHbEV6?=
 =?utf-8?B?VjZSYlJ2RHV0Wkd2bE9VRTFBMlFVR3FydFBmK0VXc20vODNRNE50ekdUUHhw?=
 =?utf-8?B?UE1zVk11ajRUTGtOV01LOGNXM2pGVHJKV3dyUGRRM2JTclZpT2F5RmZEekVm?=
 =?utf-8?B?a0N4eG9BYTU0NFZENDBINm8rVk5Lbjh2N2Jmb3JTNzlEaW1yWmhnbmVkMmhR?=
 =?utf-8?B?Z2JvUjYvS2dvaXMyVzdaSndzSWxndXZuQWJYZExEaTNPNllQd09rN0hDR2dV?=
 =?utf-8?B?QTRPbGloR3VhaTV5Q0FtNGQzY0hhZlg5Nlc5ckQvQTdoS0ZzTks4NEpscnZx?=
 =?utf-8?B?VjdzSUt4aWcvRXBNR09Cc0V3aTdtdWgxcTY3aG9pN2ZNSURmL2VkdGFHVCth?=
 =?utf-8?B?eDdvaHFWd1JFYXpRREREdGNxSkZ1WTBMRDk5MUx3Y2xiSXdQWVFQYmNQd1pa?=
 =?utf-8?B?RXp2VzJiUUFReWlDRTBORk9VZjlIMlIvQXhRNE9PVU9RUnEzaW5RWDdoWmVD?=
 =?utf-8?B?R05ONG5yNSt0OThoZlhyK1dGVGFXNzNhUFFCdnAzdzJQMUdWYk9KbXkvL084?=
 =?utf-8?B?SnJpcy9jNU5BdEw1bEludHhvdk9uZEU2d0JDTzNwMEEwTnJwdDdPQUt5K0x2?=
 =?utf-8?B?c2FvRnI4bFBPTXh1Vk95OEtma1NxSzI0WW0xSmkwNTI4UUhCWlo1Zm82Y0xz?=
 =?utf-8?B?V3FCbmhBRHU3bUtoKzk5VHl3ZXJNcXhxZWNaRlNqN3dKRzkrWkp0b1BOZVJL?=
 =?utf-8?B?aUFsRitrVkF1a1d4RUUwbE8xaHR3ekVQWmxXczYxMlFQbU1iRTBHVFpFM3RP?=
 =?utf-8?B?MlBYc3M2NE50dTZuaTg2R3JZa2FRR1VrNFc3QjJwYzRxbXliaTcrTFpmUmRX?=
 =?utf-8?Q?1gmSpKAkARWvNIUItoVS04gUD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be9843f-d614-4a4b-c05b-08daffa98e24
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 14:28:12.8488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qohXbAR3ccuGd0ITlWCDNSeAxkPfj8rSbj45u4Y2zADFVpaC1Qx4gHW9+5dGVInZGgsFYsZ2zOyXPRHdCPS6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7820
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


On 2023-01-26 04:20, Christian König wrote:
> Am 25.01.23 um 18:16 schrieb vitaly.prosyak@amd.com:
>> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>>
>> Added condition for pci_dev_is_disconnected and keeps
>> drm_dev_is_unplugged to check whether we should unmap MMIO.
>> Suggested by Alex regarding pci_dev_is_disconnected.
>> Suggested by Christian keeping drm_dev_is_unplugged.
>>
>> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
>> Reviewed-by Alex Deucher <alexander.deucher@amd.com>
>> Reviewed-by Christian Koenig <christian.coenig@amd.com>
>
> Did I gave my rb with this include path below???
Explicitly there was no RB, but there was a private thread which does 
not include this include.
>
>> Change-Id: I618c471cd398437d4ed6dec6d22be78e12683ae6
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index a10b627c8357..d3568e1ded23 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -78,6 +78,8 @@
>>     #include <drm/drm_drv.h>
>>   +#include "../../../../pci/pci.h"
>
> That include path looks more than suspicious.
>
> If we want to use pci_dev_is_disconnected() outside of the pci 
> subsystem we should probably move it to include/linux/pci.h

Alright, I would drop this patch until the  It would be a separate patch 
to create a new:

include/linux/pci.h  with the following content:
#if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_PCI)
bool pci_dev_is_disconnected(const struct pci_dev *dev)
{
     return dev->error_state == pci_channel_io_perm_failure;
}
#else
bool pci_dev_is_disconnected(const struct pci_dev *dev)
{
     return true;
}

#endif

I am not sure about enablement  of amdgpu when PCI is off in the config, 
but this is related to move pci_dev_is_disconnected into separate file 
and receive review from PCI system/.

>
> Regards,
> Christian.
>
>> +
>>   MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>>   MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>>   MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
>> @@ -4031,7 +4033,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device 
>> *adev)
>>         amdgpu_gart_dummy_page_fini(adev);
>>   -    if (drm_dev_is_unplugged(adev_to_drm(adev)))
>> +    if (pci_dev_is_disconnected(adev->pdev) &&
>> +        drm_dev_is_unplugged(adev_to_drm(adev)))
>>           amdgpu_device_unmap_mmio(adev);
>>     }
>
