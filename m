Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF3DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 11:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B526610E634;
	Wed, 16 Feb 2022 11:10:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE1DF10E5D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 11:10:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz3L9Ep/DSg6ViRU/RkQz90CRW19y0UUWRtITMc4uw+w7B4Wfzt0ZsnLhGkfz3+VHTkWqujgMEfhsZsklU5SfPVzFd3Mogy3O7KP6rnsN26kJC1CCJp3aVUxVuiThiQKoqX90Zp++wn26YqhCzlJpAyBBxmLWP8gJz4aSRwShCMH9WuIR2hnim2a96q9XIiH42NELyZnhcI9kPP6B4dGzqjh5CM5PLObF+1g9A2J//CamPnqyabFZbE4lEVxqejylfQ1aOUFC+K+7BGwP3oszd6UlzcqkjYU8K5Pk6BAqhGq86B5F2W4hFi+KSNowvMnDaWOXVG7TlJAYIFgyIKXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rzSn9vDaCZ+pGPoopYXHc0rhaSHQyluXdgWNSWFSfU=;
 b=WDbC6GyxTqgAv2n2qCvwz3/odnAGHIlPvwkst6s7iXMARuJcRpvikR6MNpujN++bMoQkEFrtpF0VFbnHY2wRcgLwqzACuadWeyB4CTfL7JPtlf702ZQoiQwb1JmxBXwwOoilzx7llSzxM11CnxTXutvulIcaIhARdDWFItNwp40dB08LnXqAACZXxG2NkyXh8TAyjBEFiBITjmntCjdoz4mbb4ESL6soNX7gjLisOMQobHVShLtv8pu+65WCDQPA2OeoXR42fMCnbU9YWXcX3cFN5ANkH3yQ+9c8W7BoMSkz4OxntAn7C7kk4JnDlwtwo/MvA01e1r5r8DJbtESWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rzSn9vDaCZ+pGPoopYXHc0rhaSHQyluXdgWNSWFSfU=;
 b=zFe46UUGYwJhw0KkPK5eKIY36mIRCFlhBcW7PRuFaiYXZe75x4RFYk/oazFW/JcqCXMaMnmo+Q02N0ubXYROqId7q6Y5aG80bEhMIikDxGMFyGMLiAXx92zmh3ckcOzan1zFSckid+220SgbLQ4xJTO3t7LalmHa2MBgc28bBU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by DM5PR12MB1516.namprd12.prod.outlook.com (2603:10b6:4:5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Wed, 16 Feb 2022 11:09:58 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d%2]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 11:09:58 +0000
Message-ID: <9c3942f5-aaa2-da81-962a-a010bb093002@amd.com>
Date: Wed, 16 Feb 2022 16:39:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
 <fa563eb7-a0df-cbda-004c-23b10e882a6b@amd.com>
 <392e1b15-8bbc-91cf-ab86-9d28aa0b716e@amd.com>
 <1021c2e4-22bb-1e94-1a91-c4d7cd915b49@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <1021c2e4-22bb-1e94-1a91-c4d7cd915b49@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::23) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd5d44bf-a3d7-48a9-b288-08d9f13cde95
X-MS-TrafficTypeDiagnostic: DM5PR12MB1516:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB151650849CA1DE90DE2D8C1DF8359@DM5PR12MB1516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2xgwqnkMLNSvNZtQyAh7c4YeM5xCKd7pVz9ujHEACoq6MeH3EFSZSqHlZup0di91nwTWz3tVUNyNGair8J6ARA4CsS7NMgquswpX8IJaT8n6qFoTsX8t89kBIWjp5Pq9BCPQrjdsXWYQ4QUbXYhGGX+3BB/AjKpdoybsUOljQMQ19QdRZo0As4ha+l5nCAzsGYEK23HZ8mtdPe8scfpHdXD/182S1r6x/ruMqdufr2mkeiDUX9bRHFYq5/0OJ3P0STFZx7JhL2+EHJ5kFvKtyvTWM4Xb2JwsUQR20jDmO9jIbyBXF05numdgIuwBokYEp6BYoezQ+Hcv3hWZAsxsGCiKPetmqx8nmBJGjNdG8B8F6nSI8H0LfKgUm4fZObMqtke6j8oBZw0mGcSL6AEqOYFwew89dC5YeoWjv1H3S+ygY9x3F4ygXb8TXFMIrR87mW1aHwe91k2zsZ+5vaFfoHRiouGVp5ZaVr3cmsoPNuE753hpXxe/v3aEIUwL7nkf35zOTPg9HvpDeY6Woyg3PVUe1WPV7olE0obUN5Oi3EQTu879v0avRRiG2Vs2cn/mrAPQQOHG23G4fkdgWRRmgtxQZR9L+V0jJwY1norLsP6HOWrCmPZuPNQIQ0xy2aZ5kU4K6SNrJuDqxNsOUBYf0446Jf+3MDu2LL/WrhZzvevovEwuB9VVjlydsAA48jkBY3TY9+CZtGyc4YHckp1yyWr+bwXMK/gwOHMt/mOWavE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(83380400001)(316002)(8936002)(66946007)(2906002)(8676002)(31686004)(36756003)(186003)(5660300002)(26005)(66476007)(66556008)(110136005)(6486002)(6666004)(53546011)(2616005)(6506007)(31696002)(38100700002)(508600001)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0EwVGgvelFSMHdLdG9vdmJNei9RZDRob1hwbzhEVTdBOGpqY0FoYldHVWdm?=
 =?utf-8?B?SHp5bVBLbnFNRVpkcG1sNlIrTnFyb0pGcmpHRzBsekFzblAxOTdOVTlkSHVn?=
 =?utf-8?B?T3pJRHhBRVhFblRrb0FrR21WTmNoK3ArZGtheTczTFd3TG1wenJRTXJReGEy?=
 =?utf-8?B?a3ZFbXZ2RTRLQS9xNjJlU3BReGFpWEVTUmJwRW9zY09ieE8wanZFUE1JVVhB?=
 =?utf-8?B?TnUxSzFicnAzbEgvQW1tMFpMSitKNjROaW5ic2VReGFEK2hiemw3QXBha3Fh?=
 =?utf-8?B?Vkd1Y0ZvTDNZT1JhKzl6cVcyWE4rNVBRb052RVptdGgwY295bCtDN2M4cFAr?=
 =?utf-8?B?ZjFUSCtTZjdKOU43TEROSGdvNWdzNTBuTitoQjRuY1IrRFpydDdWRkxYMGJu?=
 =?utf-8?B?S1hjdDAxdVZ6bWdzcGFEK2FJQnpTS1lBdWxUWVlZU2FNN1FzM05veGxrb3Vr?=
 =?utf-8?B?WmhQb3RETFA4MDc0MmF1VXN1U0ppdTNNTVdWTDFQK2RWTHZ6VVY5bkJZOS9J?=
 =?utf-8?B?QzdkWTFmb21veSt6RmlSYTh6TjBhREZENE1UUXNmcWVOZjZOZHU3MVAvTjNE?=
 =?utf-8?B?OUIxTVY3VDNSUERPQU1pc0s2REJseFVOdmJEWE5tem5hM2hvZzVMRjBwa2lN?=
 =?utf-8?B?VkNTQnV5MEphSk5QcVkyT0VJZGZuL0pRdDI3ejlRa2RaYjVCcDd5WTV1ZndR?=
 =?utf-8?B?b3d2VkxTU1d4b2tZOGVvZUQxVzFlZGFWU2RNZTYzcTNwN0FQSVJ0UDByY3lG?=
 =?utf-8?B?RjRwZ3ZuQ01vQkFWUnhxL1g2QWx0QkFPaU1TMnBodWZxVTNrNnlCbEptZys2?=
 =?utf-8?B?dk43WWJVVjRrbEprVFFKN25HYm1hd2QrNE5oUTJPWnNoK05yTDZINTRiUEdt?=
 =?utf-8?B?S3pIYkk3QkVYdzhyVmU1cmw2dVVRNDU4SmVoN3Zkd3Ria3psMi92dXpYcUFL?=
 =?utf-8?B?Y2owT1JMRlNiT0xmdEJyS1ZCSmNWWVZQSXYxVEdwaklSRjk4T2VtMTVHa0My?=
 =?utf-8?B?Y3AxblVTZ2hQWW5xZXp6dXU4OStrMDNJSHovblFkVXRLMldkVm5IQmpod1BW?=
 =?utf-8?B?WUFoUnBwMWRaZUVFSFZJcmZQK2lDQkdxdXRnek1XRTFRSlJkanJKaTJ6TlU0?=
 =?utf-8?B?cmszdU1PRW8zbklUM2NoL2k4dm9zTU1sYUNmTmdlcDB1K28xMjU5QmtEZzU1?=
 =?utf-8?B?akx0cmR1UWZwcjVEdTNjcjNvYjVQTnJoTnFXV3BaSHJHLzBBRWlMaEUzYW9x?=
 =?utf-8?B?ZFpoOGZadUd0azZpeGtlbW1MdE81ZWZUMzF2NHdML1RIcG9ZbGdwNEtJOHVJ?=
 =?utf-8?B?TUtYL3pTeUtnRXlnWGRtOWdSUHpuSklWM2REdkdoSVFxamI0OUNmVUk5Yk5K?=
 =?utf-8?B?VzZnckkyYkNJcllKZGlTN1QyTzdYQmlZanJsNWhZOHlrcTlBWHF5Tno1aHha?=
 =?utf-8?B?ZlBzbXk5MXhzTVZuTElqSmxVNVFEaS9CK2FiRXgrWUtRV2hwbERwZGkxbGdX?=
 =?utf-8?B?bzdTSXAxVW1ROHhOOVRMUGlrZlBEWkwxMzNYS0ZRL0xhdGduQ2tCTy9IckI0?=
 =?utf-8?B?ZkJsM3czRTRQVSt2VkdqcnpMeUpJWkp0TGpGM0VmSEhaTG5XVmRBVy9NdEZK?=
 =?utf-8?B?T2VyR3I3Rm4vREJ4TlRPczFockxyK291UDExV2ppbEtnRmFnd3VUbnhlZ0do?=
 =?utf-8?B?T2RySjZvVnpWbzJGdGF1Z0pMR1JYR2VBMm5uNnVqTnQrZjFIUEY2cUJydlBE?=
 =?utf-8?B?Yk1FdS9lMFJuUFBZVWxZYnM5bnl0TzMwbzZUdTUyN3pRRzlXYStzZkNlOHFq?=
 =?utf-8?B?WCt4SW5KMHlPRGhoenFkYkhMSy9LUDZsQ2FCdW0za0xXeUgvbGVHWjhVNHcz?=
 =?utf-8?B?Sld2dTdCQVhuTER0VlEzK20xNGtvT080RVRvVmV0bEtFSTlocENrU05Fd3di?=
 =?utf-8?B?TDNTamh2MzV2VkxTcVNTdHlQMHJZMWs2eWRHU2FmZlM5bFZCT001bmQ1YU44?=
 =?utf-8?B?NUFJL2hXRXFGMW5wVXF6cHdyenNhUC85eGI1Vkw3Q0VNTkY4VmJjSEUrTnVF?=
 =?utf-8?B?bUdlbjlqeHFSQzA2a2l3OXB1R3J6MWlQV2tQZE8vdkVpY3Zka0JHMzNOdVJs?=
 =?utf-8?B?Q0hQbERqWGZRaHA2NmJjWjM0OTlxbmtpYmJDbWlHTGUyRE5CY0hyMTJEYmJl?=
 =?utf-8?Q?YIF/Y+zCbFg+EkaJprkwTts=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5d44bf-a3d7-48a9-b288-08d9f13cde95
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 11:09:58.8382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60VRTGhOcX+d1N0GxxG3dbHN0dW7nPf+AOCJZG/ilcU5sktI108zZjPCNyd8a1OluWxgjZoN5W7uFf+QWhUA0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1516
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/16/2022 4:13 PM, Lazar, Lijo wrote:
>
>
> On 2/16/2022 4:04 PM, Somalapuram, Amaranath wrote:
>>
>> On 2/16/2022 3:45 PM, Lazar, Lijo wrote:
>>>
>>>
>>> On 2/16/2022 3:19 PM, Somalapuram Amaranath wrote:
>>>> List of register populated for dump collection during the GPU reset.
>>>>
>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 
>>>> +++++++++++++++++++++
>>>>   2 files changed, 100 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index b85b67a88a3d..57965316873b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -1097,6 +1097,11 @@ struct amdgpu_device {
>>>>         struct amdgpu_reset_control     *reset_cntl;
>>>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>>> +
>>>> +    /* reset dump register */
>>>> +    uint32_t            *reset_dump_reg_list;
>>>> +    int                             n_regs;
>>>> +    struct mutex            reset_dump_mutex;
>>>>   };
>>>>     static inline struct amdgpu_device *drm_to_adev(struct 
>>>> drm_device *ddev)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> index 164d6a9e9fbb..faf985c7cb93 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> @@ -1609,6 +1609,98 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>>>> +                char __user *buf, size_t size, loff_t *pos)
>>>> +{
>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>> *)file_inode(f)->i_private;
>>>> +    char reg_offset[11];
>>>> +    int i, r, len = 0;
>>>> +
>>>> +    if (*pos)
>>>> +        return 0;
>>>> +
>>>> +    if (adev->n_regs == 0)
>>>> +        return 0;
>>>> +
>>>> +    for (i = 0; i < adev->n_regs; i++) {
>>>> +        sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
>>>> +        r = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
>>>> +
>>>> +        if (r)
>>>> +            return -EFAULT;
>>>> +
>>>> +        len += strlen(reg_offset);
>>>> +    }
>>>> +
>>>> +    r = copy_to_user(buf + len, "\n", 1);
>>>> +
>>>> +    if (r)
>>>> +        return -EFAULT;
>>>> +
>>>> +    len++;
>>>> +    *pos += len;
>>>> +
>>>> +    return len;
>>>> +}
>>>> +
>>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>>>> +            const char __user *buf, size_t size, loff_t *pos)
>>>> +{
>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>> *)file_inode(f)->i_private;
>>>> +    char *reg_offset, *reg, reg_temp[11];
>>>> +    static int alloc_count;
>>>
>>> This being static what happens when it is called on a second device?
>>>
>>> Thanks,
>>> Lijo
>>>
>> I tried to avoid adding to adev. It wont work for multiple devices.
>
> Hmm.This is not friendly for single device also. Some one could just 
> parse a text file of reg offsets and do
>     sudo echo offset > file
>
> This will overwrite whatever is there. Instead you may define a syntax 
> like
>     sudo echo 0x000 > file =>  Clears all
>     sudo echo offset > file => Append to the existing set.
>
> Taking all offsets in one go may not be needed.
>
> Thanks,
> Lijo
>

0x000 can be offset for some registers !
This is application responsibly; any wrong data should clear the list.
Application can read back the list for confomation.

Regards,
S.Amarnath
>>>> +    int ret, i = 0, len = 0;
>>>> +
>>>> +    do {
>>>> +        reg_offset = reg_temp;
>>>> +        memset(reg_offset,  0, 11);
>>>> +        ret = copy_from_user(reg_offset, buf + len, min(11, 
>>>> ((int)size-len)));
>>>> +
>>>> +        if (ret)
>>>> +            goto failed;
>>>> +
>>>> +        reg = strsep(&reg_offset, " ");
>>>> +
>>>> +        if (alloc_count <= i) {
>>>> +            adev->reset_dump_reg_list =  krealloc_array(
>>>> +                            adev->reset_dump_reg_list, 1,
>>>> +                            sizeof(uint32_t), GFP_KERNEL);
>>>> +            alloc_count++;
>>>> +        }
>>>> +
>>>> +        ret = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
>>>> +
>>>> +        if (ret)
>>>> +            goto failed;
>>>> +
>>>> +        len += strlen(reg) + 1;
>>>> +        i++;
>>>> +
>>>> +    } while (len < size);
>>>> +
>>>> +    adev->n_regs = i;
>>>> +
>>>> +    return size;
>>>> +
>>>> +failed:
>>>> +    mutex_lock(&adev->reset_dump_mutex);
>>>> +    kfree(adev->reset_dump_reg_list);
>>>> +    adev->reset_dump_reg_list = NULL;
>>>> +    alloc_count = 0;
>>>> +    adev->n_regs = 0;
>>>> +    mutex_unlock(&adev->reset_dump_mutex);
>>>> +    return -EFAULT;
>>>> +}
>>>> +
>>>> +
>>>> +
>>>> +static const struct file_operations 
>>>> amdgpu_reset_dump_register_list = {
>>>> +    .owner = THIS_MODULE,
>>>> +    .read = amdgpu_reset_dump_register_list_read,
>>>> +    .write = amdgpu_reset_dump_register_list_write,
>>>> +    .llseek = default_llseek
>>>> +};
>>>> +
>>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>>   {
>>>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>>> @@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>>> *adev)
>>>>       if (!debugfs_initialized())
>>>>           return 0;
>>>>   +    mutex_init(&adev->reset_dump_mutex);
>>>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>>>>                     &fops_ib_preempt);
>>>>       if (IS_ERR(ent)) {
>>>> @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>>> *adev)
>>>>                   &amdgpu_debugfs_test_ib_fops);
>>>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>>                   &amdgpu_debugfs_vm_info_fops);
>>>> +    debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>>>> root, adev,
>>>> +                &amdgpu_reset_dump_register_list);
>>>>         adev->debugfs_vbios_blob.data = adev->bios;
>>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>>>
