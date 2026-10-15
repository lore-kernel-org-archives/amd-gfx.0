Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF81DCC6B34
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 12:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7108310E5F3;
	Thu, 15 Oct 2026 12:51:28 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012065.outbound.protection.outlook.com [52.101.43.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B00F10E5F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 12:51:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xtk+esQpV1O+dyT3orV63P4c4Ke6QkWse0vt8xq7pSKY5d3DxXhLML6u030DMBdSGnmEPkNvXvT36VH3TUlN8JZDo1oxaMd94NcPbmiEY+I4ddQGH8wKU38mVNfd7oN8jQkKeC3hAbNIYYXWy6a89ydWGpWdl4MsZtETNrsecwajNj3ENY0SwjfmLSINUkO6B2LhF7OhWms9Iz2zLcMnlz/Kex6EXoIDmtAJlASrCj4x7a+mbAp1aQfCBo/NqHju8NqMdOizCF6xvOhZtO23WqPAIFHDVdPolSuMMkOKuVXfOxkgvBlFa/hPcThjFMTCY2IN/PO7bKHG0BAs8/OXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTKZtb6qID0+B3uYbXVuFJrQmwQYRqYwaWE1ssSTzIg=;
 b=GXkypd9EOzyu5qC+jMSHV/WxDvvx0s0sfsSpB8YZR+i9uZtnAqIrh6MzTeLm7AfdFBo+q1sIPExr+ziEBHnh4xcl0UMazW//APmcyi9CLW71/y8RBqHAoMw86m2wQgjJQOCrv14yo6h5vQErFMdCuYaPzckd1NHLXEMmRkVyahB9t0TTwtSAuDF1YwdvdIZ/20pjXzXJXU0YVTk++trzn/e9pvCKNhhZC/i89Ffi2wSMFkYhiepjZRoWidALvkRMQ5Q4awghjppF8v48EtZ79GKghIkKl/YUfeWcLzLDL3NVL4DMIXvhXFY5gXr2QR1CoMHmJ3d/3zy6eLWSmOAOSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTKZtb6qID0+B3uYbXVuFJrQmwQYRqYwaWE1ssSTzIg=;
 b=0sDrSnGZ3W+vkOLglqUZsJkH3Vu+bEbWJ29tNddpLF+jWPZ8Uxi7jVlY9UfdIM++PgyBhpf4fCSKq8Ii5hEs4e9RMfjPHJ/K4zagsgbfIAVNnNeyg3ndMLZzkVGJVZQ4g6Q6YhP8PGMzxNJthSaCCh8HlVRrt/kXri/cqdh0xTw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 12:51:20 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 12:51:20 +0000
Message-ID: <6186854a-8b0a-4552-a7a1-f641faab9700@amd.com>
Date: Thu, 15 Oct 2026 07:51:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: prefer exact bus match when selecting VFCT
 VBIOS image
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Reza Nikzad Chaleshori <rezanikzadch@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Min, Frank" <Frank.Min@amd.com>,
 "Luo, Zhigang" <Zhigang.Luo@amd.com>,
 "Wang, YuBiao (Ethan)" <YuBiao.Wang@amd.com>,
 Oz Tiram <oz@shift-computing.de>
References: <20261014080523.186533-1-rezanikzadch@gmail.com>
 <BN9PR12MB51465FA6B74D63574BA3CCB6F79D2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <b6c30a27-4f8a-4c84-b227-0c54e5bf39b6@amd.com>
Content-Language: en-US
In-Reply-To: <b6c30a27-4f8a-4c84-b227-0c54e5bf39b6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:806:24::33) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 84af5811-b1c6-4085-39d8-08df2abb026b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|4143699003|22082099003|56012099006|18002099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 4m1IT/3kFPDkdEIFQQkI+cl8P2eqdLpfAMENjpOR0KWtGjS+uQdxpB5LUzIWkLjBb25P3kXCfXqK+b67sPWr3oBHGQ2phS7mjM3bE9EN/73gEBIvGAcCgm3baN962Fq6L4b+bf3DD+v5Zhu+jXc79J4ONMjFfx95kuzqVsV0ooUzZQT2FhV+kYq0MPYdBZiwlbK/48u/Lpq23Mmt/ygCVxmk6ixinYyvgWkrLJbH0FeeWM8D8j4yn2YAaRkF0OR8+r+HfYAK/1o9LVf/w7ILZgnRQJ/vmP/9WOcuAalM+QfF+JV/eKuzirL2vFgviEYoVj99imEIH1+Cd++v+0watKZYTuWU54AObEwXnibchN43EE2z5lfqf0UBrJcAC/LUYMl7cipg5kWMywL4u15JDlyVthQdl8wH46rxhEhFKFFJ+96FxKs9+8WisTdckE/EKMiBC5nLaatAOUceoUa0WsYKcdB6sNiSYiJOKCAjeUCUS+u3+KZjQn3SMo3gPkYaTzsysiIHuZk0RFehIjTFI9H7hIKrQ7j1NFiWcfiuJnsOuu8Ae7vwX2fbKZH5dSxc8Io+cs+hq3eIUk+yCdS56IqVZpFewD59PI/EBV7rQragjjdD/82YVGElMKTgZ65y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(4143699003)(22082099003)(56012099006)(18002099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU9YZkZtdUQxalo0Q3FxQWRsaFhXQ2s4bFRGSVZiK0VXNnp5ZkE4STdMck53?=
 =?utf-8?B?anQxTmVzeVdyZlV4VzZaY0hlSFZ2RnFBRjlzSzVvWmRQYVdMZkNqZnBwWmpa?=
 =?utf-8?B?dUJYZFJKc1c3cGdaTVdPazNDZXNlYjFpLzJpVVBGYktXcFlxNmZHbkpDMmZH?=
 =?utf-8?B?cFRXbHJtN1VzWFNNSEo4T3VzeVJSbDk5cDVTRXU1a3pJaXBqZHJnVG5vVVBK?=
 =?utf-8?B?V2dvZ0lsbThqKzZFWGNjZU1pYytGb05meHpEc1BseEdUTmZSYWtheEVtNmlh?=
 =?utf-8?B?QldlYkM3cW5ucjhuVlhCV3hvTEo1QW9NTy94cko4NzY3ZnIzbzJiTWpTZEhs?=
 =?utf-8?B?L2MraHE0SSt4YWtSMmNsVjcvbTRRWmUxMGl1eHh0QzFGK3AwNzh4bUJyLzlv?=
 =?utf-8?B?akJ0WWNVbHF4ajVyckNTSjB3U3R6b0lBRWpBMkFpOCtGNC9HYjd5bktiRVlR?=
 =?utf-8?B?T1duZFZuVkN0dFpIMEMyTFZ4QzJNNXpkbmpNSUtmeTFFRFM1RmQ4VHlCbU5l?=
 =?utf-8?B?V254Zk9ZNUZNSW40MDJiK0RBcEhMN0lNdElyS2Y4WlJjYk9YNk5OZGNMSFRF?=
 =?utf-8?B?L2lUaW5zNjNRdlRoQ1cxdWRJMnV4L1lkY2xjcm5XR2lLTUNodXBRRjRNUm9q?=
 =?utf-8?B?VFZJNEFLZnBQazVIVTY4WGo4bUV2SVBhcE13RkVnZktLb0VPN1ZGTnRTM1pl?=
 =?utf-8?B?T0xvMTFndWs4ajNQUWt1UEdyeEhQMk4rT0Q5RGJQb2Urd1lWUXIxYUNxRVhZ?=
 =?utf-8?B?WW8ySXFadlNNMTQrWWJOdzUwTTFzczl6eTg3VDBES2RlNXRGeHpwWTZ4WWR1?=
 =?utf-8?B?aEpvVkhOODFxbHcxaUladUZuZjA5NkkwRWJCa2x0QkFYUkd5Z1NuOTk0NlJU?=
 =?utf-8?B?UGQyejVZTjVxSGpab2RPai9yclozbElnTWR0Wmp4b0NnazBEbzBwNThUUElY?=
 =?utf-8?B?aFpUSEpYOUNIdSs3WEhoMHZBVXRvTjNWelhpS1owWVJWdTUrOGJzQjJlY2Fi?=
 =?utf-8?B?SXVidHpGYlBPdjFYUG9DeUhQdVNGYkZIendmOGdLYkRMUGhsOGRYTXNtRHA1?=
 =?utf-8?B?UTdNbjZkall6U2ZwMTE3eVRuYnZpa21kZHBkcWY2S1djbnBrTktFZEdpOWll?=
 =?utf-8?B?SitoSVFPR2NIci90TVQ3bDRZSCttbFlqaW9aM2RlWDluL1Z1ak9icmpnYXJI?=
 =?utf-8?B?cW9XT3J6VDJFUjFxejJRdk5XeGp4R3FvWXhuYkFFUTc1SjdjUWd6ci85RERF?=
 =?utf-8?B?ZG9ZcHFCQ2gzRUNVZnAxL0hyLzhValVZMkNzbmhpQTFOQi9QZC9PVDZDVkky?=
 =?utf-8?B?a1dKa0hUSDdpOUttQTNYRU9zc1B5TUpXWFB3MzZCTUtsUUw5bElIOXZuaHdq?=
 =?utf-8?B?SW5McVp1Y2dIMjRTVVdwdEhsME1JMTVOVFc5bmZzUEU2eVFsWUJqQlZ1MjFw?=
 =?utf-8?B?QzBlZjJBb2VLZmhMdWVoRE8rcE5lNUg5TEtBZ2ZHYzJaY1FINUxhYzNLV0Zj?=
 =?utf-8?B?Y1dCR0EvMlBveVV2c2h4RFFnUjJ0cWVJMEtFSVFKV2kwQjdVM09uYlByME11?=
 =?utf-8?B?V0w5TWVHTnk1V2Zld2xIbmRiaXlQWWozMG5uRStNSjdINHNDcnU4WjluTkFV?=
 =?utf-8?B?Q2hrQU5VKzQ4RXk4eVRhb21tWklydXFBT0t2eUQ3L1RTRzJGMHJsaUhnMmVN?=
 =?utf-8?B?eGhGM2FESUFqYTRMZEI2eWUxWTBIZFZqbEtaTnBRODd3ay9TSnBzZnY4Z0tS?=
 =?utf-8?B?cDAxZW45VWx3T0dqdHpYaWpmUUlrcEY4Y3VtQUJqS1R0WGU3dm4wY2MzOGRO?=
 =?utf-8?B?Sy9qMXRhWkdsODdoWUVFaGE5ZlViaUNDRVA4aUdobDN0S21EUStDb3hLNGlp?=
 =?utf-8?B?QnJPSDY0VWhDSWNjREZhZFEwOXNNU296UzlYclhqWkNnaWVWRWtnWlpvZDM4?=
 =?utf-8?B?dExFdnpnNlRXMFhzL3RpZFkzNlliL1JRc3o2WmpVMDgvRkgxRng3NXRKbndq?=
 =?utf-8?B?blpOY21GTFFtQnl2VGhHNFdkSWNpeW54UkdUSzVmdDY3OERjMEdYQzNlczRU?=
 =?utf-8?B?VXdGRVZFUGZFQWRZQW1EaE9MdDdpaVE1enh5ay9MSzRZZEc0WEt2NmNZRUFL?=
 =?utf-8?B?dDlRQjZFL1Q2c3FOVnRHWEFXeHhhMzBGT1ZWVWIzUENzQVNlK1oxQUUvLy9X?=
 =?utf-8?B?eGRoWXJEaFhudk4za2YycVFhMjJVQkxPa3l3L2lnOThCSlU5YWowUDFveTJU?=
 =?utf-8?B?T1dhaDdpUlJWNTYvQnB6R0ZlZmYxbXdvU0swdUJsUmU4QW8wY1NRL0M2Zndt?=
 =?utf-8?B?cXY1S0EyTldjSzdVV1hkVm1ib25wcGhWTUFKNisxV2JNTkEzbGFjUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84af5811-b1c6-4085-39d8-08df2abb026b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 12:51:19.9681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gf/WuKmX/rbqvwM58UdUHw78z5SB/mXQu4rhndPUnkW7twQ5HnPnJI+z5K586H9qXJHmzTnNENCWeHXaYj02xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
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



On 10/14/26 21:52, Mario Limonciello wrote:
> + Oz Tiram
> 
> On 10/14/26 17:19, Deucher, Alexander wrote:
>> Public
>>
>> + Mario
>>
>>> -----Original Message-----
>>> From: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
>>> Sent: Wednesday, October 14, 2026 4:05 AM
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona
>>> Vetter <simona@ffwll.ch>; Zhang, Hawking <Hawking.Zhang@amd.com>;
>>> Min, Frank <Frank.Min@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com>;
>>> Wang, YuBiao (Ethan) <YuBiao.Wang@amd.com>
>>> Subject: [PATCH] drm/amdgpu: prefer exact bus match when selecting VFCT
>>> VBIOS image
>>>
>>> amdgpu_acpi_vfct_match() accepts an entry whose bus number differs from
>>> the runtime bus number as long as vendor, device, slot and function 
>>> match.
>>> The caller takes the first entry that matches and stops.
>>>
>>> On systems with several GPUs of the same model (e.g. mining boards) 
>>> every
>>> card matches every entry on vendor/device/function, so an earlier 
>>> entry is
>>> selected for a later card even when the table contains an entry with 
>>> the exact
>>> bus number. The later card then runs with another board's VBIOS 
>>> (different
>>> power/clock/memory tables) and can fail to initialize, for example 
>>> with "UVD
>>> not responding" and a fatal error during GPU init.
>>>
>>> Search the table first for an exact bus match, and only if none 
>>> exists fall back to
>>> matching by device identity.
>>>
>>> Reproduced with two RX 580 (Polaris10, 1002:67df) from different vendors
>>> on an ASUS B250 mining board: VFCT holds entries for bus 1 and bus 
>>> 12, the
>>> card at bus 12 was given the bus 1 image.
>>>
>>> Signed-off-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
>>
>> I think I'd prefer to just revert the change the loosened the 
>> mapping.  The loosening was done to fix when someone sets pci=realloc 
>> on the kernel command line.  I'd consider that to be more of a corner 
>> case and presumably even that would potentially break on a system like 
>> yours anyway.
>>
>> Alex
> 
> Oz,
> 
> Just to double check, it was pci=realloc that caused the issue right?  I 
> seem to think so.
> 
> Another way we could do this is to only do the soft match when 
> pci=realloc was set on kernel command line.  I think that would help 
> both cases.

I've posted what this would look like as this patch.

https://lore.kernel.org/linux-pci/20261015124843.203905-1-mario.limonciello@amd.com/

> 
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 71 +++++++++++++++-----
>>> ----
>>>   1 file changed, 46 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>> index f9315e047..d42485e6b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>> @@ -441,10 +441,15 @@ static bool amdgpu_read_disabled_bios(struct
>>> amdgpu_device *adev)
>>>    * the bus numbers disagree we accept the entry if the device identity
>>>    * matches.
>>>    *
>>> + * @exact: if true, only an exact bus number match is accepted.  The
>>> + caller
>>> + * first searches the whole table with @exact set, and only retries
>>> + with it
>>> + * cleared when no entry matched exactly, so that an earlier entry for
>>> + an
>>> + * identical card on a different bus cannot shadow the correct one.
>>> + *
>>>    * Returns: 0 on match, -ENODEV on no match
>>>    */
>>>   static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
>>> -                               VFCT_IMAGE_HEADER *vhdr)
>>> +                               VFCT_IMAGE_HEADER *vhdr, bool exact)
>>>   {
>>>        /* Vendor and device IDs must always match */
>>>        if (vhdr->VendorID != adev->pdev->vendor || @@ -459,6 +464,9 @@
>>> static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
>>>        if (vhdr->PCIBus == adev->pdev->bus->number)
>>>                return 0;
>>>
>>> +     if (exact)
>>> +             return -ENODEV;
>>> +
>>>        /* Bus mismatch but device identity matches (PCI renumbering 
>>> case)
>>> */
>>>        dev_notice(adev->dev,
>>>                   "VFCT bus number mismatch: table %u != runtime %u,
>>> matching by device identity (vendor 0x%04x device 0x%04x)\n", @@ -474,6
>>> +482,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
>>>        UEFI_ACPI_VFCT *vfct;
>>>        unsigned int offset;
>>>        bool r = false;
>>> +     bool exact;
>>>
>>>        if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
>>>                return false;
>>> @@ -484,38 +493,50 @@ static bool amdgpu_acpi_vfct_bios(struct
>>> amdgpu_device *adev)
>>>        }
>>>
>>>        vfct = (UEFI_ACPI_VFCT *)hdr;
>>> -     offset = vfct->VBIOSImageOffset;
>>>
>>> -     while (offset < tbl_size) {
>>> -             GOP_VBIOS_CONTENT *vbios = (GOP_VBIOS_CONTENT
>>> *)((char *)hdr + offset);
>>> -             VFCT_IMAGE_HEADER *vhdr = &vbios->VbiosHeader;
>>> +     /*
>>> +      * Pass 1 looks for an entry whose bus number matches exactly.  
>>> Only
>>> if
>>> +      * there is none does pass 2 accept an entry that matches by 
>>> device
>>> +      * identity alone.  Without this, on a system with several 
>>> identical
>>> +      * GPUs an earlier entry would be picked for a later card.
>>> +      */
>>> +     for (exact = true; ; exact = false) {
>>> +             offset = vfct->VBIOSImageOffset;
>>>
>>> -             offset += sizeof(VFCT_IMAGE_HEADER);
>>> -             if (offset > tbl_size) {
>>> -                     dev_info(adev->dev, "ACPI VFCT image header
>>> truncated,skipping\n");
>>> -                     goto out;
>>> -             }
>>> +             while (offset < tbl_size) {
>>> +                     GOP_VBIOS_CONTENT *vbios =
>>> (GOP_VBIOS_CONTENT *)((char *)hdr + offset);
>>> +                     VFCT_IMAGE_HEADER *vhdr = &vbios->VbiosHeader;
>>>
>>> -             offset += vhdr->ImageLength;
>>> -             if (offset > tbl_size) {
>>> -                     dev_info(adev->dev, "ACPI VFCT image
>>> truncated,skipping\n");
>>> -                     goto out;
>>> -             }
>>> +                     offset += sizeof(VFCT_IMAGE_HEADER);
>>> +                     if (offset > tbl_size) {
>>> +                             dev_info(adev->dev, "ACPI VFCT image
>>> header truncated,skipping\n");
>>> +                             goto out;
>>> +                     }
>>>
>>> -             if (vhdr->ImageLength &&
>>> -                 !amdgpu_acpi_vfct_match(adev, vhdr)) {
>>> -                     adev->bios = kmemdup(&vbios->VbiosContent,
>>> -                                          vhdr->ImageLength,
>>> -                                          GFP_KERNEL);
>>> +                     offset += vhdr->ImageLength;
>>> +                     if (offset > tbl_size) {
>>> +                             dev_info(adev->dev, "ACPI VFCT image
>>> truncated,skipping\n");
>>> +                             goto out;
>>> +                     }
>>>
>>> -                     if (!check_atom_bios(adev, vhdr->ImageLength)) {
>>> -                             amdgpu_bios_release(adev);
>>> +                     if (vhdr->ImageLength &&
>>> +                         !amdgpu_acpi_vfct_match(adev, vhdr, exact)) {
>>> +                             adev->bios = kmemdup(&vbios-
>>>> VbiosContent,
>>> +                                                  vhdr->ImageLength,
>>> +                                                  GFP_KERNEL);
>>> +
>>> +                             if (!check_atom_bios(adev, vhdr-
>>>> ImageLength)) {
>>> +                                     amdgpu_bios_release(adev);
>>> +                                     goto out;
>>> +                             }
>>> +                             adev->bios_size = vhdr->ImageLength;
>>> +                             r = true;
>>>                                goto out;
>>>                        }
>>> -                     adev->bios_size = vhdr->ImageLength;
>>> -                     r = true;
>>> -                     goto out;
>>>                }
>>> +
>>> +             if (!exact)
>>> +                     break;
>>>        }
>>>
>>>        dev_info(adev->dev, "ACPI VFCT table present but broken (too 
>>> short
>>> #2),skipping\n");
>>> -- 
>>> 2.53.0
>>
> 

