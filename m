Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6F7C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 20:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D3C810E288;
	Tue, 18 Jan 2022 20:14:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33C1510E288
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 20:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILSl16Ul4Uo/zPBucvkp7F/m9SUY0G6ZJy5g70BpHXYD4qxdCmgmcges7jieZwlh04iyBwy0ouOlTP4vfik1q2W/vfUq7v5mv7LxqWqKqBOAO7RrCcFUat81FNVNgriLbsLo8c450dUR7adilf6Lt/0Piq3w7mjrrbGuF03J5qVUICnP5M916AtkP8K5MgZSBzCXwCuSgNviaY+k2c0uDXwco5TaSmHXlL6apBt1C969Z4hxGt8NyERfVRzazg/u6E7cR7bCuubg5YB+LsXmxLKRhSc9tGevoZFWzUS89vxfgVm/KyIPG1iAZbASIoseXqS2epcJDyg30Ot0kzq3wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOD8nZsQM0xt8DFBcJ4cIOC9WYy2jy3lWotjKA+CR6c=;
 b=JAIO/+sVjnw6Epxw1zeFbCTyPgQhEy902EcFJS2wzT/wTN6126S/ix/VXmxDFTvW6Dom9vAo6NbpGlMHULNc11sEXKB1GkmhhlE7trsECfQ/0R95Ps48jZDQize5kUJvXjYSDZObkOYoQkII80E/oGaldcmi2bAez7HZ4lICAxUGQJ4+MLmzkEO2di1Slgdsvtai+umxC3/xMoHW4+RYgBHvEtSwC3pvGenfK3zVk8tnPb06B/x3npqWvytwUlOot0N5HTP2elGrgPKaCIapmVAya2UoKSzxquFaXLEnk9dDMWD8nrztWd1bWd1w3jN1dnJo251cp6BYImRsHPTHNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOD8nZsQM0xt8DFBcJ4cIOC9WYy2jy3lWotjKA+CR6c=;
 b=gqttLOHa9CdH0U+kNcRrVYfhVEyXl2JbQ2Exm2suw4pQd+3V6RVpxpXw5kfCsRiNxGrBmd2C1Ej2PUGDliTDgKHBPfcLXokYqlOZraNLFnPT4XfkRklZjIxsBubKK7CaX1VbHH4DtllSnPZXwqBjreaoxiCYOf1cGl9F7RSp4Xk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by BYAPR12MB2709.namprd12.prod.outlook.com (2603:10b6:a03:6d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 20:13:57 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::144c:ceeb:e458:1424]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::144c:ceeb:e458:1424%3]) with mapi id 15.20.4888.013; Tue, 18 Jan 2022
 20:13:57 +0000
Message-ID: <f182bb24-d2ff-f1e0-1a20-4b71b665d558@amd.com>
Date: Tue, 18 Jan 2022 15:13:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, "Russell, Kent"
 <Kent.Russell@amd.com>
References: <20220118161552.11122-1-jinhuieric.huang@amd.com>
 <CADnq5_OVpDd7O+q=9N8j14dwa-+2PqKjmDvKv6JkQGiiuQDYSQ@mail.gmail.com>
 <2f7705db-d5ac-3e7c-a991-79634c0b9f8c@amd.com>
 <DM5PR12MB1308EAE234EBFD55B3374B3085589@DM5PR12MB1308.namprd12.prod.outlook.com>
 <CADnq5_N4i9+FfzUGD8UWrVjc-9rs78PEzMW9wpWeqe4JqQnvfg@mail.gmail.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <CADnq5_N4i9+FfzUGD8UWrVjc-9rs78PEzMW9wpWeqe4JqQnvfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0001.namprd18.prod.outlook.com
 (2603:10b6:208:23c::6) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 467a046d-c63e-4ff9-3f93-08d9dabf0e69
X-MS-TrafficTypeDiagnostic: BYAPR12MB2709:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB27090CADFA0B430063DD4AD882589@BYAPR12MB2709.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UtPSzqCn1cz+/IDgVEGxz7R1xlJ3QZ/7n0Q9RdRm35Zb2z64iHlgaUm+BOsjBnnzsYQj9sn4SpENlVdCNdDs8cnsDE/A3FiHxEa8thqblLLbu9sk9brrQ8WlvlcdByYfX0LhWweuBa3wtWkSrkh34mBSjtbGPbFjDpR62l/7Q/3fquih7xJr/Rij4muH9kC52UsJZA+0aPz3JOozl6ieHvstC6s7rqRepa+maxIgoIpk6pzvXc2ce5KNY0i9azIPLe7C3d83bBayx9avkihTMI1GszoXCEQdZx4jKCH+NZPPBTrH6r5wuaEHmfIk5v8ofyraoZLwwwcTQ4fNBGuWOwjZj30cZO3uN5FdgLXxcuvpYl7xMyRhQax4rhYsNgdrPf7QevasdQl1qcgFnoX50SR7Go0oXMYtcJUZ4/kU9bbiG5gx2EBzozmbR4rK3tlsLjnc6Ut5z9UXTQ/r4/W/e3OOE61QJiwji6icioN35tD0d8VmWf6FQPlTQzL3uEswy1RcJO5+YfUKCa5twE5C2OWlgm80nvcL8nT9Fjqa3Dctk85Ix0maEca9Z+LTVL8DNhRN4BNHDyvcd5yMviaDDKk5kZOFhnuO1A8J0/p4rUsuvjhAwSoL9jvkitMOffHhCh9LZwHwxJuyleVUnuxUHezysl2bDMjOhH+iEF/hj5fS5NTGkaaLId9G3lZidPHdJZZy63k504azTxmJo4YRw2JoohMFnKQz1oSGY9B6YuGhGbXDvjZ7m+m3B6Z/AD+0DD+UbGkTV8z4SxiZIgwT1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(86362001)(6506007)(316002)(110136005)(66946007)(66476007)(66556008)(38100700002)(31696002)(2906002)(6512007)(8936002)(6636002)(6486002)(4326008)(53546011)(2616005)(8676002)(6666004)(186003)(508600001)(5660300002)(83380400001)(36756003)(16393002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkswZnR0dW5sa2F1VGZlUnZIQkt1d3EyeC82a1RpZXFIUEh1K2hOSFBvOTYy?=
 =?utf-8?B?bTVwNzVRSCtEOCtvZVZKNEU5aTlPVDdHM3VKUTd6ZEpsbURTQVpFWkZsaXo3?=
 =?utf-8?B?U3NsbUZGN01wNXNSdnY1SDdLbkVvQkpmV0ZVU0p1aVowQlB2bUIyT29pSjFs?=
 =?utf-8?B?Sm1PVkJkOEUxWWoyNHJsdzZhR2diWi9LRXFzTEV4dXAyM2xLVWNhUW55Nk9J?=
 =?utf-8?B?cEM1aWk3aVlRSm1IQXZtNkdmbnRnZ3FML1B4QU5HNFZqWUpMRC9kZnp1VUV1?=
 =?utf-8?B?S0h2M1JMNm4vNTZ3TXRJTUhWTzZFZ2VFSVVUUUJrdUQrbXYzbU90ZHVzWFE3?=
 =?utf-8?B?UXJiVjRlL3F4Qk1GWVhVckd3TXBGYnB5MlBMeXBYbm1NT09sNnczTk1VUnNW?=
 =?utf-8?B?ZFZxN0FTa3NYdjFlT2hvbUxvNitMQ3krZGxSRml5TE5sMmcxbUJtVEx3K09m?=
 =?utf-8?B?OHkxZHlIb1lLTkRpKzdLaHhqTjEycm9ZQUdUOEdjKzVCZDdGOU1ZcU02dGsr?=
 =?utf-8?B?VTRVQ003UHpoeTR0bnpDNUZnZHJtY0dUYUNndmx0dnU0ekdDWmc2Yk9wWEtx?=
 =?utf-8?B?TStEOFRmdTg1djBtTVZWTFhVeVB2VHBxbExmbFJadDQzc00xbFk3YlhZdDh4?=
 =?utf-8?B?RDlBckE4UFhWTzkxR2ZTQWtGTWZSbkorNXA2VzA3MkJjeWMyaW9iTnhybjhE?=
 =?utf-8?B?SGVuU1pYdkNoWnFPalZ2Y3doUGhadWhoOTZMaVZaV2RYTHR6SWVnQ2JDYndj?=
 =?utf-8?B?MitjT2g3YnpwRVBwM3Q1MDlaWmZCSVZyTkNhSm82aFM0TnpVYXQxQUR3YzVr?=
 =?utf-8?B?QmllQUh4U3hybGNqWjVwUUJLandGQUo4bG1WTjhDUk1wSnNmRE9sQmp0VENp?=
 =?utf-8?B?N1k4UkNiNExxVHdEQWY0b0s2ak50SXo0ZkxyaU1aVE1nMFdPUHFSZnI4VnRY?=
 =?utf-8?B?UVFZLzBtNnMvRFdOaVZoOVRocDZZSDBCcTVvM0xSY04xQTVBUWtvVjJVZXJ1?=
 =?utf-8?B?ZjhiS0FDR3FSZ1g0eTk4VFA2cjU1V2U3VnZUMUU0NlFCZll1MDdSaE5BRnZZ?=
 =?utf-8?B?TzVPTG9PZjBEZGt3SFhVa0Joa204ZjlWN2Q4OXlyUjNIVlhFcWo5bVVUT1hv?=
 =?utf-8?B?ODlXNHFaS1R3YklieXFkS25IWE1Ia0YrWVVpQTJpNlI2OEo4MUNHb3FYM0pV?=
 =?utf-8?B?L3B3YjFRTHV1ZTRUNnVRMmVic0lRQnRMNUUxcGRrOEZlSmZsMVJ2VWlDaksv?=
 =?utf-8?B?UWpSN2QrdXVKWkc3SllPaHVqT09qaENNOWhFN3dEeW0vVTM4aUhKVTdxY1Yz?=
 =?utf-8?B?NmlTeXdva214MkEzVWRGQ1JhWjJCUC84M29td2ZyVVNsTXB3RXNMa2x3aWJk?=
 =?utf-8?B?bTJFeWVybVZhRnNUdkNhNzVVSFR3QzUyY2cweEoxaFNNOS9Sc1BrLytGVnpj?=
 =?utf-8?B?QWdQS1o1Qk8wOVNrbFlDOVFVdzNnR1psZTQxSWtwem1CTEJvNGFYMExIbTJX?=
 =?utf-8?B?NjFUMkRINDZVN1Rib2F3Z2ErUk9OdXc3UnV2THdray95dC9BMHJ6YU5yWHJQ?=
 =?utf-8?B?TmoxdEZsYnpzMG1DalNVVnFxcHQ1aUtEUVNLUkhSN09ORkNDc1lRb2I5dWJs?=
 =?utf-8?B?ZFdhUWtCMG9SQVE4SDhLOGt1d1R0TWJNUnE4b3ZEUUpHeWxxQlRqRlp1UFZj?=
 =?utf-8?B?dTZEb0RyU2xtQVYrcDBWdTJONGhRTjdwTU1xSVNqRTR0Mm1PdW9uRWpza1N6?=
 =?utf-8?B?R1J1aENsRHlIK1lCc3lzMjB1eFpGby95Nk8wcXd1a2prUjMxVDdiZVFtMWRY?=
 =?utf-8?B?amlaczNucGlDbUN2R0l2b3UxbmtqV2lkdnZjanVXQ0VWUUxQNGpDVW5OVmFT?=
 =?utf-8?B?UmtPeHpjbVVYNEtYaHF4WG54eEhub3dvZXU1c0pQYUJScHk3TnU1Y1pGNmg0?=
 =?utf-8?B?ek4xVldWMm5Da2dxVmIvcHp1MW1LWVA1MkNvTWdLdkh6MW00RGdPanJGNGlz?=
 =?utf-8?B?YkNhQTl5K2FZMnYyaElGMDVXS2E4U3BVSU9BQlBQOFZNNlIwL09PeDl5dStx?=
 =?utf-8?B?UENQOGc5RTYzOXovVVFGVktxMjh2NzZkdnpYQ05vbkwxSVVzR1I3YnlBQ3NB?=
 =?utf-8?B?ejB4TDB0R3Y2YWYvZTJMYy9VZ1JHNlZYcGtvaFNvSjFCRXhyUm8vRUlYNW40?=
 =?utf-8?B?MWpUeWErT0FBVXpZdXRXb2d6M0lSK1hUQ2lKam5hb0R6dWNQcEc3RkRnM3J0?=
 =?utf-8?Q?qcIH4puvRjUxFfgLvwCBs7tfTyog2UFUb5t9gvOunI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467a046d-c63e-4ff9-3f93-08d9dabf0e69
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 20:13:57.0022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0dZnXKNLtqO90eevTAi6WzlX57Q/FiesGCi5HNBML/bQLJ5p2cha2x7Lvq+k3bLNX+7zmgFCTM5J7dAteonVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2709
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

I understand Alex's concern. I think usually we only check the version 
when a feature is only available in a specific version, and other 
version or newer version doesn't have.

In case of FW fix, we assume the driver and FWs have to be synchronous. 
If we have driver backward compatibility for FWs, there must be a lot of 
redundant codes for FW version check. So this patch and SDMA fix will be 
pushed into ROCm 5.1 release branch at the same time.

Regards,
Eric

On 2022-01-18 14:35, Alex Deucher wrote:
> On Tue, Jan 18, 2022 at 2:27 PM Russell, Kent <Kent.Russell@amd.com> wrote:
>> [AMD Official Use Only]
>>
>> I think what he means is that if we are using SDMA v17, this will cause issues, won't it? Should we check that SDMA version is >=18 before enabling it? Or am I misunderstanding the fix?
> Yes, that was my concern.
>
> Alex
>
>>   Kent
>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric Huang
>>> Sent: Tuesday, January 18, 2022 2:09 PM
>>> To: Alex Deucher <alexdeucher@gmail.com>
>>> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
>>> Subject: Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
>>>
>>> The SDMA fix is generic and not in a specific version of FW, so we don't
>>> have to check.
>>>
>>> Thanks,
>>> Eric
>>>
>>> On 2022-01-18 11:35, Alex Deucher wrote:
>>>> On Tue, Jan 18, 2022 at 11:16 AM Eric Huang <jinhuieric.huang@amd.com> wrote:
>>>>> SDMA FW fixes the hang issue for adding heavy-weight TLB
>>>>> flush on Arcturus, so we can enable it.
>>>> Do we need to check for a specific fw version?
>>>>
>>>> Alex
>>>>
>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 +++++---
>>>>>    drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 3 ++-
>>>>>    2 files changed, 7 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> index a64cbbd943ba..7b24a920c12e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> @@ -1892,10 +1892,12 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>>>>>                                   true);
>>>>>           ret = unreserve_bo_and_vms(&ctx, false, false);
>>>>>
>>>>> -       /* Only apply no TLB flush on Aldebaran to
>>>>> -        * workaround regressions on other Asics.
>>>>> +       /* Only apply no TLB flush on Aldebaran and Arcturus
>>>>> +        * to workaround regressions on other Asics.
>>>>>            */
>>>>> -       if (table_freed && (adev->asic_type != CHIP_ALDEBARAN))
>>>>> +       if (table_freed &&
>>>>> +           (adev->asic_type != CHIP_ALDEBARAN) &&
>>>>> +           (adev->asic_type != CHIP_ARCTURUS))
>>>>>                   *table_freed = true;
>>>>>
>>>>>           goto out;
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> index b570c0454ce9..ef4d676cc71c 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> @@ -1806,7 +1806,8 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file
>>> *filep,
>>>>>           }
>>>>>           mutex_unlock(&p->mutex);
>>>>>
>>>>> -       if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) {
>>>>> +       if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
>>>>> +           KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1)) {
>>>>>                   err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
>>>>>                                   (struct kgd_mem *) mem, true);
>>>>>                   if (err) {
>>>>> --
>>>>> 2.25.1
>>>>>

