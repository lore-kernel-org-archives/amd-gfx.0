Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AA0C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 21:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7D1C10EBBF;
	Thu, 16 Jun 2022 21:10:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F20410EBCC
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 21:10:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmVr9ubJ81FvgV/TAQkBBdpTZOczeNtrM+j4y8F7qiKt9EJXuO/Mve4fTZBMi5sVQ+ZoUBw+0sb7d6s4lTnmUl2dvdTa4Ue70kfxCQ4SgVMu4I7olPtXXLHRie/RqWNxV+FwW4DIjzpImSgeBQ2CjDdybF4MF4tth1v7BQZyAEcAQU05Au418wxDWT7305ujqHYBXYqmn1DQi/Xfu4prukizVxdxbgdpevdCIagSCL35bLDK0GwzuLYE9O8+Lxs+EJUhyKdI1hA/QSscBkcW6e60vZnX1kdfRCl7e3uqekAWz7Fd0Xc+d0bCkF4SabylyB9FgehefQ4qzj2Lo6ajyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayOmrEFkCaLz63eoCoxJYH0/55q5e7hq5l/5PkyNv6k=;
 b=nz2jDVx6cjAvQvQrUeE54KSHgp8zBGa4Etue09jaCe6+RV9iHCm/0YVCtphXyRRgM/Z/dUXbmLGYpXdq5kix7ffSfB7D92tC4K59VNQ5DlqH69fHySnZHWqMtoxqjFzBV9inJexg9+5Tm/q9mm6B1TLfRoQQmP/ZUs6u139dL/UwWgxVP3BQUqz/zo0lBvPjkb1M74ppLa3xgQgzTVp5bZsvrSPQpHYHIUzIJsWSJ4kuWmYVSBZUEQWzeVUaSoZHKyPkWOEC58tuXB5DZ4/2rY3rjipEU9Gr0W9521oN1EA6KhzmKP53Nwlv+dshsrhpi181TWdFtbqaPBgPjHMjkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayOmrEFkCaLz63eoCoxJYH0/55q5e7hq5l/5PkyNv6k=;
 b=pa9Ozoepmh+LhXSzJNYOolm4YqVbjoqgiOumMRRp5F0kQ1SJu3RPnpm8jy0AYe8FYPF9SUCto+YN+ewhvCKE9SVFA714L4MIAXenloWTHBP3RPKCfpA4F0+DRH9Yt/v2g1Sq9LrZH4r48wZDeaOF/ANEcXuYAQ45HI6Kvj95oas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by BYAPR12MB2982.namprd12.prod.outlook.com (2603:10b6:a03:a8::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Thu, 16 Jun
 2022 21:10:46 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::85a:3075:1744:8317]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::85a:3075:1744:8317%7]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 21:10:46 +0000
Message-ID: <420b7655-a90b-18b6-306c-76533c30a4fe@amd.com>
Date: Thu, 16 Jun 2022 17:10:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amd/display: add missing reg defs for DCN3x HUBBUB
Content-Language: en-US
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220616210859.1054753-1-aurabindo.pillai@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220616210859.1054753-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:208:160::27) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 756262f3-5e36-40af-cecc-08da4fdcae90
X-MS-TrafficTypeDiagnostic: BYAPR12MB2982:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB298271200351AAB1F14840BE98AC9@BYAPR12MB2982.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJ3OnLTHoBt4wUKQJpCKfwZh6zJeHisLXB6937nUL7M9r1VbD3IfbVcZqgUCjgti9UJO8Th5TDBzrs5T+X1j7awzFwJLhz/k8x/R2FQdIRI0OS6FdsV2jBftZCUmC0zuWVHEJ6p88PgMGwQ1Q/QcbjpDPtQeSkcm/WdCnHZBWKDo9ZUrvPWkhRgfg8UBqysweFfqoZ0aYYDTdvYE38nCcv6slXe1ri5c0LZ3tQsNp577PG37E8wRhHhswnJ+vAb5X4UsC9a+M84y2AJaH3q4J4O7y35bsKx5y0rPuFZFYpMZ/pIoELg2Ewm85m93yayDGVBwWluv2U23DGV7F0EP+AtNdLJXOQpyXL1QM5jtXDBk0pvs3OuwDnfUa8ijbzMV/hV5BT1idxvedmsH+XmDow/xBgXIatjS2x5CLB7KwAOhiqN8Vj5aKIKlyhOzqUauVP79TtqLX7lJbN3CF15n+72O9ejurNgwwnCw2McutiDSGXUwL2E1gMv+SW4nwDWiYTW5new8+VyRD/iKeBmeiw2h9+gZcqJpHUQHmRKSvYGGI7eSumZdW8kVkaGkP3yivd2f57+or3Vhiaukpk7OP/OC5sUs4pZ5rJ0HlhzUfFBHaS4WxOGFk/tgi8ND2SQXZTH0g/YD8vA7il61XPh05Ekz+bn89a9PtQETjJUYGAy0eFC58y6/TEasf84RfFw+YI+YYa1lIXiNpvemSBfWR8ngUxvPvB2o0iTTLwMJ/bzMDJqLpRj7zXXCkclEFVhpcj06hg0++xo8g94DfOE3ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(8676002)(26005)(36756003)(31686004)(4326008)(2616005)(86362001)(6506007)(5660300002)(66946007)(6486002)(316002)(8936002)(66556008)(2906002)(498600001)(31696002)(66476007)(186003)(45080400002)(38100700002)(83380400001)(6512007)(53546011)(32563001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk8rMmhDSkFwbmRjV3VmalpoNjM1NUt5VFRVazdESUlyL0dvNlNGV0RRRnpT?=
 =?utf-8?B?eEZrZkNRclczTlpwRHltMVIxNmx4amE4UlA3Q2JMRDk1OWdoY014dGdiRGhG?=
 =?utf-8?B?NnltcnhkdzVhOGNRUkVGS2x6bm93NjI5OVRHdmZKOURKQzMwdDBuYTVsUXlS?=
 =?utf-8?B?MU5tT0JaRkliNU5GR1RPYnhuN1VGN0ZoMVFoMkRmN01ZTjhCNWhyZWQ0MnBE?=
 =?utf-8?B?VW82Q01Vb08vWTJyeVExZTlFaGQ5NTN1UkpjbzJWUk4rSzhrY3VOVzNnWkhq?=
 =?utf-8?B?OTlMTmE2Y3QxbDd1SWl5eVpveGMxVkc4SzRnU3UrNzMzOXlQWUJFck5NWTVk?=
 =?utf-8?B?bHZEcnNlcnVrNzdrYjg5WTczeENUeTZ3WmYrNVRpT1YzNTkxRUdiYjA5Umx6?=
 =?utf-8?B?TW5Rb3F0TURGSk02YmdzSUxpdGFCWWRaNHkra0xjVzZKU3BIR0ZKbEdubC84?=
 =?utf-8?B?TzI5RWYvcDZQL25YdlNSWmFnRkRYWloyd0JXWEpZeFZZVzZyNzNQQ09WWE56?=
 =?utf-8?B?VmRvWkFIYWNTc3pmRmN5eVpmbzM0elIwUEkzMjlsUWNEQmgwbkVOc1Jtc0Uy?=
 =?utf-8?B?ckVFVWg4YzlWVS9IN1R2cHVjQ0huZ3BLbUQrdHlUbll5VDFaYUZaOGhxMFhv?=
 =?utf-8?B?Wnc0Q2dJc2E1MnZoSTVycHZFSks0SkpIcE9UWS8zT3FRbnpnRnRQZ2hPV1k2?=
 =?utf-8?B?RkUySjNwSzJjNExQMXZHUG9SZk11cEFoRERwT09UZHM4cnR5Z09rYVk2WCt2?=
 =?utf-8?B?Nk9mUGVrZ0hRdW1nRnFFbWtRd1pKMUp3L1Iydi9IenNiUllSTEVXSkIvRXdW?=
 =?utf-8?B?OVBnSDVwai9yaG13RkM3UllibGpDYTI3TTRLdi8zd3VCRXpjTlh6OVAwcUFG?=
 =?utf-8?B?TEoyNzJzMWFtcEZvOGU5WHY2TDdqOUg3ODlKbThUSU5ITjk5ckdYTHpTd2pr?=
 =?utf-8?B?a3FRL1FLOWd4MStDSURHSFMvZnVFeUdrVSszU2d4VlVWZFhzK0FoVnI5bDJw?=
 =?utf-8?B?M1F1K2lxWHpzVFd6NFc4czN3eFZUZW9JbHQ2M0t0ZmNGd0lYcEpvQVNqcVA4?=
 =?utf-8?B?MlpkNjZHU3pxdHpEakZ2NURlTU43VkVLS29ZQnR6VGhkbW1DQ1FUcHdoWXRu?=
 =?utf-8?B?Z0VSWFY0Vmtad0J5VndKaGM3RHpKbkNtYlNPZGIrMUwrOVBiQk9xLzFjSjZz?=
 =?utf-8?B?YWVmM1JWYUxCZHJnU2phTHI2d2lNbldxU2hVQko4aTdlT2VsWGs3VVhKcGsx?=
 =?utf-8?B?ZCs5Y3l5SjJTalBBaUYvK3ZoQnZOUkt4cWQ4WStuMmpmYmltWE9Wb2s0WWk2?=
 =?utf-8?B?YkN1andGWmVaYW8rN0JHdjAvM1hVaWM3VllpNktVYmxJMmtqdWFkVDhZU1Zq?=
 =?utf-8?B?REZiUUIzcTlxdW0zb0hkeVRLY1V1Rlc3YkJvWUtBVEgrNmQyM1hnY05DM3c1?=
 =?utf-8?B?QkZMYUF0TFZzMGtFK1RTbEl3U2hxR3o0TVJML1N4UVU4OFJOd3lPNkUzelpi?=
 =?utf-8?B?azRYMk1CZldwNG5VS1pPUktkV29zb29QRFdEMksxaTlLUzBtdDQycmp1aGZq?=
 =?utf-8?B?RHZIMmRkL2k0UEVzcGFFdDl5QktZZ0NrQXUrMEtYSURWZHVVMGRMZ0R5UEli?=
 =?utf-8?B?dHZuSTR2QmFHOTA1UGJWWk9iUkJoc2ljNWdyS0hqOExBRXRZM2UzZGtzQ3p3?=
 =?utf-8?B?Z2lYM2taTWFHR1BMYlFVazlsTzg3b0orUk1zbzY0V21KVE45bzUrREN6YTVy?=
 =?utf-8?B?TkEyVUxkNXl1ZzNzWDFmVWcvdXJJRUxaMURPdndpYS9jZ3dMbXdxc1BwSzF3?=
 =?utf-8?B?K2RqMFdGdTNFVkNuVUpNMGtNbUZ3Kzh3eHU5cU1VU1FVT3F5dXNiOFRFSmcy?=
 =?utf-8?B?cXRDa09jeWRYaVYvd2RkWW1iQW90QzdaZG43TVZaWVlFMTBtcUlWc3FSQ1Zr?=
 =?utf-8?B?QnkyczlIZkV6Q2FZUFBEZHpZbm5rV2JsTTlGNTFOMk9FcUw1cStZUkwydzBG?=
 =?utf-8?B?bnZxREFodGRrSzBDS3YyOSs4ZExBbSs3cjRjVmY2bkVLZWJVRndVYWhNUWt1?=
 =?utf-8?B?WmF5N2xFVlM0bGdPUGRGdGhNcktTd2h5ZmEwKzQvYnF1ZW4vSVlONXlwVTNq?=
 =?utf-8?B?dDFad3hFMmJIN2YxKzZSSHpKb3VIdVFBU0xoUjl1a3FBeVFzWWh5NWhCWDZH?=
 =?utf-8?B?UEFEUVVzbFdKWXY2dGREOERzVS9MWVl6T2J3Q1FaMW8yUTk1Y0xjejdkeFZz?=
 =?utf-8?B?dXJUVmVXMktDUWVhaFpHVGErRitNakVjdDU2b2tYYTRWd0dGVXF6blliZUd6?=
 =?utf-8?B?b3lEMW1GRFRFVnNpMjd2dkNnQkZjNlR0b2hzVkFVWThmSWU4OXdoQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756262f3-5e36-40af-cecc-08da4fdcae90
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 21:10:46.7877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWHiaJgCowOKiLcChfl+qwTk1viLG31h2JqAdMsXkFTvyARiWDTu0v4cUka83IsNqmWvjsRVSHsSORLy2fviXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2982
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
Cc: harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-16 17:08, Aurabindo Pillai wrote:
> [Why&How]
> The omitted register definition caused call traces like:
> 
> [    3.811215] WARNING: CPU: 7 PID: 794 at drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:120 set_reg_field_values.constprop.0+0xc7/0xe0 [amdgpu]
> [    3.811406] Modules linked in: amdgpu(+) drm_ttm_helper ttm iommu_v2 gpu_sched drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopyarea drm i2c_piix4 drm_panel_orientation_quirks
> [    3.811419] CPU: 7 PID: 794 Comm: systemd-udevd Not tainted 5.16.0-kfd+ #132
> [    3.811422] Hardware name: System manufacturer System Product Name/ROG STRIX B450-F GAMING, BIOS 3003 12/09/2019
> [    3.811425] RIP: 0010:set_reg_field_values.constprop.0+0xc7/0xe0 [amdgpu]
> [    3.811615] Code: 08 49 89 51 08 8b 08 48 8d 42 08 49 89 41 08 44 8b 02 48 8d 50 08 0f b6 c9 49 89 51 08 8b 00 45 85 c0 75 b3 0f 0b eb af 5d c3 <0f> 0b e9 48 ff ff ff 49 8b 51 08 eb d0 49 8b 41 08 eb d5 66 0f 1f
> [    3.811619] RSP: 0018:ffffb8c1c04cf640 EFLAGS: 00010246
> [    3.811621] RAX: 0000000000000000 RBX: ffff96f2100d8800 RCX: 0000000000000000
> [    3.811623] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffb8c1c04cf650
> [    3.811625] RBP: ffffb8c1c04cf640 R08: 000000000000047f R09: ffffb8c1c04cf658
> [    3.811627] R10: ffff96f5161ff000 R11: ffff96f5161ff000 R12: ffff96f204afb9c0
> [    3.811629] R13: 0000000000000000 R14: ffff96f202b94c00 R15: ffffb8c1c04cf718
> [    3.811631] FS:  00007fe07c2e2880(0000) GS:ffff96f5059c0000(0000) knlGS:0000000000000000
> [    3.811634] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.811636] CR2: 0000559634ab57b8 CR3: 0000000120674000 CR4: 00000000003506e0
> [    3.811637] Call Trace:
> [    3.811640]  <TASK>
> [    3.811642]  generic_reg_update_ex+0x69/0x200 [amdgpu]
> [    3.811831]  ? _printk+0x58/0x6f
> [    3.811836]  dcn32_init_crb+0x18f/0x1b0 [amdgpu]
> [    3.812031]  dcn32_init_hw+0x379/0x6a0 [amdgpu]
> [    3.812223]  dc_hardware_init+0xba/0x100 [amdgpu]
> [    3.812415]  amdgpu_dm_init.isra.0.cold+0x166/0x1867 [amdgpu]
> [    3.812616]  ? dev_vprintk_emit+0x139/0x15d
> [    3.812621]  ? dev_printk_emit+0x4e/0x65
> [    3.812624]  dm_hw_init+0x12/0x30 [amdgpu]
> [    3.812820]  amdgpu_device_init.cold+0x130d/0x178c [amdgpu]
> [    3.813017]  ? pci_read_config_word+0x25/0x40
> [    3.813021]  amdgpu_driver_load_kms+0x1a/0x130 [amdgpu]
> [    3.813178]  amdgpu_pci_probe+0x130/0x330 [amdgpu]
> 
> Fixes: 7ea50d53 ("drm/amd: add register headers for DCN32/321")
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h          | 2 ++
>   drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_offset.h  | 2 ++
>   drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h | 3 +++
>   drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_offset.h  | 2 ++
>   drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_sh_mask.h | 4 ++++
>   5 files changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
> index 8d3ea8ee5b3b..3bae6e558971 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
> @@ -65,6 +65,7 @@
>   	SR(DCHUBBUB_DET3_CTRL),\
>   	SR(DCHUBBUB_COMPBUF_CTRL),\
>   	SR(COMPBUF_RESERVED_SPACE),\
> +	SR(DCHUBBUB_DEBUG_CTRL_0),\
>   	SR(DCHUBBUB_ARB_USR_RETRAINING_CNTL),\
>   	SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_A),\
>   	SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_B),\
> @@ -118,6 +119,7 @@
>   	HUBBUB_SF(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_B, DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_B, mask_sh), \
>   	HUBBUB_SF(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_C, DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_C, mask_sh), \
>   	HUBBUB_SF(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D, DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D, mask_sh),\
> +	HUBBUB_SF(DCHUBBUB_DEBUG_CTRL_0, DET_DEPTH, mask_sh),\
>   	HUBBUB_SF(DCHUBBUB_DET0_CTRL, DET0_SIZE, mask_sh),\
>   	HUBBUB_SF(DCHUBBUB_DET0_CTRL, DET0_SIZE_CURRENT, mask_sh),\
>   	HUBBUB_SF(DCHUBBUB_DET1_CTRL, DET1_SIZE, mask_sh),\
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_offset.h
> index 6f84ea5c006f..14c29ce4c7b3 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_offset.h
> @@ -1807,6 +1807,8 @@
>   #define regDCHUBBUB_DET2_CTRL_BASE_IDX                                                                  2
>   #define regDCHUBBUB_DET3_CTRL                                                                           0x04be
>   #define regDCHUBBUB_DET3_CTRL_BASE_IDX                                                                  2
> +#define regDCHUBBUB_DEBUG_CTRL_0                                                                        0x04c5
> +#define regDCHUBBUB_DEBUG_CTRL_0_BASE_IDX                                                               2
>   #define regDCHUBBUB_MEM_PWR_MODE_CTRL                                                                   0x04c0
>   #define regDCHUBBUB_MEM_PWR_MODE_CTRL_BASE_IDX                                                          2
>   #define regCOMPBUF_MEM_PWR_CTRL_1                                                                       0x04c1
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h
> index d42f91560bb9..0691e328d0f0 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h
> @@ -6348,6 +6348,9 @@
>   #define COMPBUF_RESERVED_SPACE__COMPBUF_RESERVED_SPACE_64B_MASK                                               0x00000FFFL
>   #define COMPBUF_RESERVED_SPACE__COMPBUF_RESERVED_SPACE_ZS_MASK                                                0x0FFF0000L
>   
> +//DCHUBBUB_DEBUG_CTRL_0
> +#define DCHUBBUB_DEBUG_CTRL_0__DET_DEPTH__SHIFT                                                               0x10
> +#define DCHUBBUB_DEBUG_CTRL_0__DET_DEPTH_MASK                                                                 0x07FF0000L
>   
>   // addressBlock: dcn_dc_dchubbubl_hubbub_vmrq_if_dispdec
>   //DCN_VM_CONTEXT0_CNTL
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_offset.h
> index e40a924c02ce..3bd8792fd7b3 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_offset.h
> @@ -1817,6 +1817,8 @@
>   #define regDCHUBBUB_MEM_PWR_STATUS_BASE_IDX                                                             2
>   #define regCOMPBUF_RESERVED_SPACE                                                                       0x04c4
>   #define regCOMPBUF_RESERVED_SPACE_BASE_IDX                                                              2
> +#define regDCHUBBUB_DEBUG_CTRL_0                                                                        0x04c5
> +#define regDCHUBBUB_DEBUG_CTRL_0_BASE_IDX                                                               2
>   
>   
>   // addressBlock: dce_dc_dchubbubl_hubbub_vmrq_if_dispdec
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_sh_mask.h
> index 23faa628cd59..e82dffc2b9b0 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_sh_mask.h
> @@ -6350,6 +6350,10 @@
>   #define COMPBUF_RESERVED_SPACE__COMPBUF_RESERVED_SPACE_64B_MASK                                               0x00000FFFL
>   #define COMPBUF_RESERVED_SPACE__COMPBUF_RESERVED_SPACE_ZS_MASK                                                0x0FFF0000L
>   
> +//DCHUBBUB_DEBUG_CTRL_0
> +#define DCHUBBUB_DEBUG_CTRL_0__DET_DEPTH__SHIFT                                                               0x10
> +#define DCHUBBUB_DEBUG_CTRL_0__DET_DEPTH_MASK                                                                 0x07FF0000L
> +
>   
>   // addressBlock: dce_dc_dchubbubl_hubbub_vmrq_if_dispdec
>   //DCN_VM_CONTEXT0_CNTL

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
