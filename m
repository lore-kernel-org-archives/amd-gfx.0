Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2F7C48BEB
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 07:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6C6C10E156;
	Thu, 15 Feb 2024 07:04:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RQMyHOeA";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D235210E259
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 07:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQR2x7pN6CZVLkYM16El1buTYH8sD97BmQGDACtdj0EZppauYDjbmRvcjjeVI+fBN1iNZgEIeugqbXDrFw9kCcJx3SgScjLCVHtTac3FeOUVq6XzQpMegd5gl69vtz6QrIEuEtl66QkuG2paAgQGA9QOIj0y2beCVmonYU+XQWTb9WRoWkaJ9gvrT38s5xd+E2WrYJBl9BPnGGjkqWWa1+/AAriuSFKuYCrReRTxnTAbqXQXZ/bo2B1IcY+e+F61duiDzNc+cccEZrd23Apjyxfgc2lPxw3Frar0iYteT0lvjF9IO6IZVg4b0xdMtcXlcfbmdszNq+m8tlwINJE/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aW7tAPL8d+pwYQ2o1TAkbs53VmygjMrPYrELUXhhwcI=;
 b=WgVkO+7IB1kCcfi6VvwwUAyydzSTUtH3yJqeQ4ZUp7Cqthr0HID04UdEb3J41gXFa9bJZk+8Arx4v8SQSMQTeBGmgF5Jt62tlcTq5sbXslB8HGwDC9++t63Q4jOO0w3SVkDCE9AY5UsnmmY0upGTA3m1z7ggG4V3xv3PTuTY1FD/3neEPz5sg2jxqswVY6O7fjFfhUoAhKR5jSnETRA2pr4APlpEugM9LIHOh7CoYNUUAwXd48cL2PpON0ctMhyUrJut5Qrsg3AESfMee+fTh0StKUB//zCjYlhK77YM1JIHT7jfuQNCZEo3GWw/U2QEKkHTbpdVgnA5w9jFhMKiTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aW7tAPL8d+pwYQ2o1TAkbs53VmygjMrPYrELUXhhwcI=;
 b=RQMyHOeApkmalmXuLuCvAn7XvcIfNlLVKVbt/sXmLYhmI+dSp6A1kBbDDMuynFuP7sqd3spoUxEvr+c9uQDDO+l9m9YQbigux4J8UlRNcZX2QcPx1bFXC/Gp9p1Elr9sntlVkY5NjL8QwJHhEwBFiDMuhrzwlPC6m+oHa862RKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Thu, 15 Feb
 2024 07:04:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7292.022; Thu, 15 Feb 2024
 07:04:46 +0000
Message-ID: <b9dc0bba-424c-483d-8fa6-f1f249e9db4f@amd.com>
Date: Thu, 15 Feb 2024 08:04:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Reporting a use-after-free in amdgpu
Content-Language: en-US
To: =?UTF-8?B?7KCV7KSA6rWQ?= <joonkyoj@yonsei.ac.kr>,
 alexander.deucher@amd.com, Xinhui.Pan@amd.com
Cc: amd-gfx@lists.freedesktop.org, Dokyung Song <dokyungs@yonsei.ac.kr>,
 jisoo.jang@yonsei.ac.kr, yw9865@yonsei.ac.kr
References: <CAKc8oVXOjNZLcJWh0+a8E7ttYxoH8sGNcu-Z4YAyey2CnuTyQQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAKc8oVXOjNZLcJWh0+a8E7ttYxoH8sGNcu-Z4YAyey2CnuTyQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: aa75dc35-dbf6-43e5-f4ef-08dc2df46474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xy2WqnyvZnZIglE6Vn2AZoE1WNXkbX4hgKjZjGZHFNVGb3GwgRyvLkSc0Lm1zNl3Ur0krLMCb9G1FpBTJpM0QS8JrUiRqtjSWJpvrokckx+ByJF9WF0r3noJ1PNLe6YWebJf1yW705T8de7K8ae52hLyXW7cK3xGPOPaHDZEMyhYy6YR2DJORQWYqFdIfYRXjXXZYIQxLi40uHEQLM0T7RyQTJRC6hjoVTMIb0XzgSNZ9G30r9eKoYJWYN1oX31tPJissc+LjWAwRQoepminnOLyOmnVaS53JC3jIUAYOrx/q5ftDd0FN7d/8MC/d+OjtqHNkTQjOveQR2QMIWPfqwrTF8ec8X5ZogxuZVcnz0X9oAh+0DlUQIcx6m8qmZDDDkswdv09fAJjbS/q+2/72ljQpRdXBw0SYoS3WnqbU9WvxzymO6aWHyCvX1qu9AxyvasLmxlTfZc51Wsi0MwzL3OvDnfyHGzzoaiiMr77871q3gdMQF8QVXFuaXQAmt18ggETiCPM/SeSBef5a6GaMrB5e6lILZn4ku731YdEaYXRJOWSZJynYolcafmnFMpU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2906002)(83380400001)(6666004)(316002)(41300700001)(6636002)(2616005)(478600001)(6512007)(6506007)(6486002)(4326008)(8936002)(8676002)(5660300002)(26005)(66946007)(66556008)(66476007)(31686004)(38100700002)(86362001)(31696002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzY1ZU5oWnFHNDgzVEFCSk9OZjZUVXBzNEUwd1l2QW9OUW9HYXRxeVgzTVNv?=
 =?utf-8?B?dlBtMWpaMUNoT1krRnlFZit2ejRtaVpjWld1NysxZ3FQVEtZcHQ1Y0U3cXgv?=
 =?utf-8?B?NGpMb2FHa0VWQ3IxRXVOT2RCclh6V0JzU0g3ajdXNEc1b29tVXlnL3dFTUow?=
 =?utf-8?B?eGNkSXpIU3RESVF1eXUvMWd5a2lRZytzMlk5Q0hYVmpraVNReEZpQlRTWnhq?=
 =?utf-8?B?Q2w1eGUrMk0vRVVyZzRwK0JocWZpbXJPN1BBMDdNalk2dDdPYXFUTzZnUlNw?=
 =?utf-8?B?UnV0YjlEOC84TitBbjBVQmJCSDRCdnk3YkMvSGRtTnJ4WTBLWG0wcDZZOFln?=
 =?utf-8?B?elBVamFIcWZVR0pjUHgxSytDVzFFa2ttN3A1VFYvekdkZWE5QS8yamRNMmVZ?=
 =?utf-8?B?am05YU90N1ZNRWIwd3ZuMkROUzBOK3BGcWJXUlozZ01wMXFkc0c4SFhXNWU0?=
 =?utf-8?B?ajkvQXlRZjhQZFhoTnNIM2phLzc1NExScUh5bUZjWEp2SnJCWVVHNFpST1Mr?=
 =?utf-8?B?TmIwSmVXb1hSSzdGUVB4bkhBa0t0MklvV0FHOHFUc2llS29Sb0lYbjZ0b09q?=
 =?utf-8?B?S1hMQTl0Y0NpQjkxUWs0TVBvbVFvSmdLbm1oSVhHbFJIazF0czFCQ29hU0d5?=
 =?utf-8?B?UGZDbFJ1cVNTNU4ycTV0VGdrdWtmZ2o5WXcyV3VVOHFSUDYxYUtCcDc1cjdS?=
 =?utf-8?B?azkvczNoWndBT1VyUWNJU0YvT2FzZHBzVW5meS9qNDlwRUVtZXlkVEptTFc3?=
 =?utf-8?B?NjR6SDUrV1VJY1o3K0R4QTZuejVaRURPZXp5Nk1PTFBOUmRWRzdqKzRjSlY0?=
 =?utf-8?B?OFh5YnRNQmJCQStwcmcrYko2dWJNcllwdmJCZEVtdzF5Qks0Y1g2MXVISFZM?=
 =?utf-8?B?RFpCUGpKOW5zV21aQzRXUDlSS1gySjNHYzQzSnd1ZjNSdTl6R2JFckQrUTZC?=
 =?utf-8?B?OTZKRytTb0hYaTBkdDF6azdrQ2NxSnRzaFBGWTV0TTVnSFJLcEVzYWdSVGtN?=
 =?utf-8?B?WG8rdENZQ2toTHl1SGR6MzJJdkQvNFp2Znl2YzJadk5CdVpnMER3NW9LTm55?=
 =?utf-8?B?d04xcW1ocEo2T3RzblphbVFkVTEwb09NZnhLQVNjMlJIaDVGc2x3NDhCL1JV?=
 =?utf-8?B?ZVcvSEM1TmJxOStadlB0dmVNdFlldkxSOFZWd0NIVkZyNnJQMVFEYkxpd0RX?=
 =?utf-8?B?cHBybzNHNGIwTXgvR1VMMjdUd1VWTlV0WTZZblJvTzZMZ3F0cjRKNHlwa0w3?=
 =?utf-8?B?aXhqSWFYTXpkN25nTUVqMUZLSEExNXhOVjhYYnZjSmZiWE9yQkhMYWk1eHRt?=
 =?utf-8?B?OGtKWmFJc2FYYVk0WXNIeFhVR0dLaERuRDJLcmJ1eVdmSmJUQjZ3bm5pdVdV?=
 =?utf-8?B?eXFBZFZrOWFCVDhYNFNObEhCSEtpMTJCME9XODVLWnhKQ01ubk5jMHhwVGZx?=
 =?utf-8?B?Nk1BUlVIMmlDU0NZa212VVl5UzVqVTd2Q1hPNFhqZzRuVHIzVGYzNzR5UCtV?=
 =?utf-8?B?MFA0dGUxVGozcjNGOS9ET3dwaDhzSTk0MWJKcXQ3YnB1TmRtRXA3dXRrWlk2?=
 =?utf-8?B?L2M4VDN0alRGL2JxV29Na3ArNTE2NkZVaWJSN0IzaExndGhxL2w2VTZuN3dz?=
 =?utf-8?B?MVd2WTdkR2phQnZJYng2S2xQdGV4OExKYUJ5eVpOVStLaXRWRElMSzBHWHBr?=
 =?utf-8?B?ejFHcEFJR3ptT0JqOU55dnB1ajdVZTBPZXNsU240NVlOUnJHbllycG1GaTdX?=
 =?utf-8?B?U21DTU5GR3Y0VnUzQm1VWVl0Z0U5MG9Mbm84WXR1QVVxeW9ldWFibXduRGx5?=
 =?utf-8?B?YWlaeCt2c3kxd0xIckdMN29sYUN4WFowU2dXSkd1cmZiSElsRDBIZXVqaUJn?=
 =?utf-8?B?RFkxZ1FLOFZTME9hT2NIWDZyWUJ5WTFCWXBXMEdlbnl5M3BHeGZFdUtyeEky?=
 =?utf-8?B?bkx0a0tjK3AzdkphK0xQRlN1US83eEwrUVpBeWwzNmZYcUNIZC85YTJQWmpZ?=
 =?utf-8?B?Z0VQYWF2WWpSRGJhdlQ0cFRCQ0hCWVdtN3l4VmdMYnVKd3ZsLzhFUVVkVnFQ?=
 =?utf-8?B?QzdjZmlSUkRsK2I3em5sNkVPZ3l5YXdvZGlMbkhOSlYxeSs0QTlZKzFiMml3?=
 =?utf-8?Q?QaxaxSIue4i7U8GI4RM46UF8O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa75dc35-dbf6-43e5-f4ef-08dc2df46474
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 07:04:46.3055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAbCUjs8zzWxZkOTH6Lkud1jMInT6Me9KzuaNS8vxFvrHmivYec3rtcAUCBpOWkS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141
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

That looks like an incorrect error handling to me.

The invalid address is rejected and because of this we free up the data 
structures, but probably in the wrong order or something like that.

Going to take a look.

Thanks,
Christian.

Am 15.02.24 um 03:34 schrieb 정준교:
> Hello,
>
> We would like to report a use-after-free bug in the AMDGPU DRM driver 
> in the linux kernel 6.2 that we found with our customized Syzkaller.
> The bug can be triggered by sending a single amdgpu_gem_userptr_ioctl 
> to the AMDGPU DRM driver, with invalid addr and size.
> We have tested that this bug can still be triggered in the latest RC 
> kernel, v6.8-rc4.
>
> Steps to reproduce are as below.
>
> struct drm_amdgpu_gem_userptr *arg;
> arg = malloc(sizeof(struct drm_amdgpu_gem_userptr));
> arg->addr = 0xffffffffffff0000;
> arg->size = 0x80000000;
> arg->flags = 0x7;
> ioctl(AMDGPU_renderD128_DEVICE_FILE, 0xc1186451, arg);
>
> The KASAN report is as follows:
> ==================================================================
> BUG: KASAN: use-after-free in switch_mm_irqs_off+0x89d/0xb70
> Read of size 8 at addr ffff88801f17bc00 by task syz-executor/386
> Call Trace:
> <TASK>
> switch_mm_irqs_off+0x89d/0xb70
> __schedule+0xa62/0x2630
> preempt_schedule_common+0x45/0xd0
> vfree+0x4d/0x60
> ttm_tt_fini+0xdf/0x1c0
> amdgpu_ttm_backend_destroy+0x9f/0xe0
> ttm_bo_cleanup_memtype_use+0x142/0x1f0
> ttm_bo_release+0x67d/0xc00
> ttm_bo_put+0x7c/0xa0
> amdgpu_bo_unref+0x3b/0x80
> amdgpu_gem_object_free+0x7f/0xc0
> drm_gem_object_free+0x5d/0x90
> amdgpu_gem_userptr_ioctl+0x452/0x7e0
> drm_ioctl_kernel+0x284/0x500
> drm_ioctl+0x55e/0xa50
> amdgpu_drm_ioctl+0xe3/0x1d0
> </TASK>
>
> Allocated by task 385:
> kmem_cache_alloc+0x174/0x300
> copy_process+0x32d1/0x6640
> kernel_clone+0xcd/0x690
>
> Freed by task 386:
> kmem_cache_free+0x13b/0x550
> mmu_interval_notifier_remove+0x4c8/0x610
> amdgpu_hmm_unregister+0x47/0x90
> amdgpu_gem_object_free+0x75/0xc0
> drm_gem_object_free+0x5d/0x90
> amdgpu_gem_userptr_ioctl+0x452/0x7e0
> drm_ioctl_kernel+0x284/0x500
> drm_ioctl+0x55e/0xa50
> amdgpu_drm_ioctl+0xe3/0x1d0
>
> The buggy address belongs to the object at ffff88801f17bb80
> which belongs to the cache mm_struct of size 2016
> The buggy address is located 128 bytes inside of
> 2016-byte region [ffff88801f17bb80, ffff88801f17c360)
>
> The buggy address belongs to the physical page:
> page:000000002c2a61bd refcount:1 mapcount:0 mapping:0000000000000000 
> index:0x0 pfn:0x1f178
> head:000000002c2a61bd order:3 compound_mapcount:0 subpages_mapcount:0 
> compound_pincount:0
> memcg:ffff8880141aa301
> flags: 0x100000000010200(slab|head|node=0|zone=1)
> raw: 0100000000010200 ffff88800a44fc80 ffffea00006ca400 dead000000000004
> raw: 0000000000000000 00000000800f000f 00000001ffffffff ffff8880141aa301
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
> ffff88801f17bb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff88801f17bb80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff88801f17bc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ^
> ffff88801f17bc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88801f17bd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================

