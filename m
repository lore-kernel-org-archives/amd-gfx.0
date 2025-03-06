Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FA9C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 19:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93D3110E11A;
	Thu,  6 Mar 2025 19:31:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fBZ+kWRy";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 459C710E11A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 19:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnmImOi1oMwN63QawfjRVo4CQ1GXNFKlfplB9yG74SoA9sygyfgUjVoUBh4lUs0Dd+wKHsshXrmL5xeH4KPvM8zZd7Mkv2wf1FGwHvS7oijP3+skMYgfD5wubZqrsXSjccbnD9NBNA25YakJheVydvTUZox69ftmXEh5w9a06wjmVRe7jTaV3dORvyKPlAI4g6Lg130AW7eDYvqKSFmSk3/RjL5SK3Ga1kjc+9eAXdNQCnFSLpCw8nMhdBTajyih/tlMWFN3JG5E/QpEOYr7AlDPm+NhPCJw3etOyX3mwS0a27+3pruBMj/f4p64Z8KcNV/jtViICuS70qmEaB+nZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNGhzcrHTiAQzF9mu3kAe1c0zPkj2MhPeAwYEv7ZeO0=;
 b=JMJTRLr3HhvWT+9Cr7wdjmoPwflXhd7F5gYt6EbXuczLIUkMAzmhQo7Sqb+Vz9BqW7iRp+gxTpy0tiI/WIBfRDw90LpFoXp4LGhv42g1BgAKdQ5nhEHCYi2ElA1E5AeWHz8AtuonGKTjmmjxnvVjxRvWm+W4R0q8IgkQizFZRxOHnGPTofuJ94Apf+aygeSNhHlNVntFGXlNwzi0F9cw676QG38ASS1vrEGKvGAq4nKAGR/TRBOPzOJun1VgzNN2N8gQRgm9bVVViEO5ZX6nfmZNrpBvs0r+ghMdeXeJgSFk4YSsq9TdVpNdYvl71SeXzfC1yXzz2NsqD3HeJeM8Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNGhzcrHTiAQzF9mu3kAe1c0zPkj2MhPeAwYEv7ZeO0=;
 b=fBZ+kWRyDI6yBQQTTFm2br1ipmg0DozJQ1G3HI5bZNMMqavIxI6U5daGzFMJ7CbwBqBVsivXzCRHg2589Pin2OryD+tYhpBTlxW8ZuO09yPXdQY0cY1FX1tDfJqK0UlTAsBzSlTfjjZrnFm++sXE4BFZvT70sxff1HuZEvvvuwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7617.namprd12.prod.outlook.com (2603:10b6:610:140::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 19:31:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 19:31:09 +0000
Message-ID: <858ce1da-673a-4cef-a1d3-c062a9ffa64c@amd.com>
Date: Thu, 6 Mar 2025 13:31:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd: Fail initialization earlier when DC is
 disabled
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250306185752.50871-1-mario.limonciello@amd.com>
 <CADnq5_NUZwNK_h05mbAD7iba1JjDj=CtQ5=fRb_0VDpgaFzG6g@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_NUZwNK_h05mbAD7iba1JjDj=CtQ5=fRb_0VDpgaFzG6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:806:121::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: d5dc4e71-ca5d-48fc-faf8-08dd5ce5726f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHhENklscXNxVUFUbzVuT09pckVvY25UWmF6UjhKdG9iL241S2J2djlZL1J6?=
 =?utf-8?B?eXZMQmF4a0c5YWszRXprN01Ld1NwNFYyOUJoTEhndXYzRjdHcW51Z3JoR2NF?=
 =?utf-8?B?Zy9CdjF1RWpmTnRENys3blI2TTd1WFc2WFVuOFEzUXdBVWdCdTZ4U012dVpY?=
 =?utf-8?B?REJFZi9VVDBDc3dueWFweDRpN2wzV044NTl2YVRlaVViQ0FYd3hsL1ZJYW1M?=
 =?utf-8?B?T3U5ZGpVa01DaDNKQmJmMEVJNUYrZmVvZ2JjU1U2VWl3ZUxOQmFPTXNtcFdo?=
 =?utf-8?B?SGw4T3l3R3VDd3pFdWxDZE5RejAvTkxmMk1qV29NWGx6MHppNXdBL2hrTmFO?=
 =?utf-8?B?dEZmTm0wQnVjdEFURmRERUVnUFlNU1d3QVo1VlJQS0Z4NEtFOWgxazRNc1I5?=
 =?utf-8?B?UUszOG5OWnU4anlRRVNITkJJKzZKUzAzejNzQ2lUNld2cm9ZSlJ6MDdpc2VF?=
 =?utf-8?B?Z054MThNMGhuRTFkc01tMHhGZDNBQzQ1eDFvNE16MERuT2RWYlVBKzVua0Vy?=
 =?utf-8?B?T3BDSmYvdXdJc0sya0tQdzYwUnA0UVpSRUhVbHdqNElZZzRnSmhNN1ZYb05O?=
 =?utf-8?B?S25oakdKRG5LTmhKbW9IcXo2ZUgzS2NMQlJqQnN1WkN5YzE1eDcwakVCQ1B1?=
 =?utf-8?B?VlQ5eHlsditZYStRRDhWcmZReGtMMjZHeFBhc3FvV0dTcnFzclBVcVJzdkh1?=
 =?utf-8?B?NWpublBpOVFCMGRDd2N6MkFVWE5aVW5JalVvWTlaazZiQlZZaUhjQjRKbC9S?=
 =?utf-8?B?eU0wazVkZTltblplZUtiWWZaVEV2dVlQSVdpVTlmTG1adkNFN0xESlg0M3Nr?=
 =?utf-8?B?cUN3RVVJT0tadk90RlpZdjMxb3lHY1VYNkFLUUZiTGQ2NFZmbWJwWDRPYjV2?=
 =?utf-8?B?QllMSWw3ZzE0R29MMFd4dCtHRDN3cjlvdVJKSENtaXpTc1FhVExFeFlTZUZa?=
 =?utf-8?B?UEtpb3lLV3ZpZ0IvYjJWemJiUkQwU0h2SFNZTnhERkw0bHJOMUM4SWlMVFhz?=
 =?utf-8?B?Z20wb2xwSVFFUnA2QWpPZmgxMjhjSnlaZ21rN2ZEajZTd0ttVWd0Yzc5SWVO?=
 =?utf-8?B?N2M5VUZ1dzh2b3puMUFXcXBsYXduRExGYzNtaXZua0pOMTUxNEVPYUMzeEFP?=
 =?utf-8?B?bCs1UGlXWlhrSDZzR2hUQnE5NDBqQUZTTk5aNk9jV2QzRGJTY0lYdFVzN0JT?=
 =?utf-8?B?VVYzOXd4VjVJQkErWFhIQVJSOEVwRWtkWVJsWDUrSVZjNnhCSDZyZ2FOT0JH?=
 =?utf-8?B?M1p4N1lBZDRJYTlsN2lXaEcwU01BazhQbTVmeDJ5aEx2bGVMNVBONGZlejRO?=
 =?utf-8?B?aFA2ZUF4TC82WlVWQzlTWmQ1bk56VHFRQzNVVCtVTjNHN0J5RGJtQ2FweE1S?=
 =?utf-8?B?TnI2bVlLZUFpZmxJSEFDWmZaR25BS0xqOGV5a1BLU1ZkMzBKNktTU0FMSTN2?=
 =?utf-8?B?blI2L2hCUUJuMFBZTkdkOURrTDgzKzc2ZGpaY2FYeTREZi81WnhzVlJHTkZM?=
 =?utf-8?B?aVJkYm14UWV5aklxQ3l4UGVyTEpkek55ZmdPbGpObEVwTmQ2SHBCamFkUWZq?=
 =?utf-8?B?d1ZaOHhtY0pSa2pFcWVFdXpkVnozVVpGQ0RSTDJKelg4cGJUYjBKOHlIai8v?=
 =?utf-8?B?ZzVyY2hYR3pTb0VBT3poRHFqS205STJNcW1SSEVaZ2MxVEtHWG1CUnFiUklw?=
 =?utf-8?B?SitOS2tEK1ZpaGE5djlnVDJWZkxBYmpiK3dCQ09aQzJ0RFErTGxQNmZqTStS?=
 =?utf-8?B?WTlwVlZCcXE4ZGduK1RhelEvRXBRcWluZlNrOFByM0NnOFlCNzVLNjFoMGhK?=
 =?utf-8?B?Rk9LMEhiSnZzZEFIWVFRTVk5Sy9waVVtK1U2NkVYWDhJVGUxUTA0KzdiVzRO?=
 =?utf-8?Q?PcTiBN54HAWZS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1BjRThLc3A4Y1YycEZzaXRNYWZuclJhd0lpY3JTS1U0dGs0cENzVTZxZjBE?=
 =?utf-8?B?N0FnTTA3cG5LRzRSVDZGaEh6RWpUaHR4MlZONGZLejB6VkVHczZSN255aEpH?=
 =?utf-8?B?ZHN2N0ZIVHkxZzNRSzNvTkJLQTBmbVJCMkNXUWNISWEwaU1PTDdZVVErQ3BB?=
 =?utf-8?B?b0F3RDN6bGNCR1lOY1UvRXJmTC95TnRKeDNyaERPdzBLaXJRU3RGdEgxSTV5?=
 =?utf-8?B?b3RTOWE5VG5vTHVpSjB5Nm5CcGRlcU9FS0dFeGZDRHJzRU44SVQrKzRaWExr?=
 =?utf-8?B?bHlFN0p3YVY4aDZzSHR1OWpIK3lNd2NSakNmOVlyRXRMRDJqeGxDTGY1NDh5?=
 =?utf-8?B?OTA5ck9RWUx3MEVjZDNZTDAxMGVBRE52RVk0Ukc1QStudCtGNWNGOWhPZktC?=
 =?utf-8?B?cDhYTTU5N0JWWlR6WWErb2pZTkpyOUFINzJyaXlPZ244Snl3UTZmOTJKSG85?=
 =?utf-8?B?WE1QZU93SVlZTTVLRGxmakJwUmF0bGp0dXcwcGRnME9mekJTYjNVQXIrWVZT?=
 =?utf-8?B?NTV6QTl1ajhmdHFIVGtHbXpQa1Nma2tMbEhlOXk0WHpXWVN5K3V4YStzVi9i?=
 =?utf-8?B?aGRacHhxWVJoWm9sMEwwVkRMM2FUeXFITStCb1ZiYUZvdjBabENKUlYyOTFX?=
 =?utf-8?B?ZU9DRkMzb3lnb2xIRWphUU1Sam5XYldpNUFqdkoxelVDa05HR3BhY2tIcHVu?=
 =?utf-8?B?ODFNQ0tMZlh2eFAwa3l0QVpFdVN0ZnNvekhGVFgyUVM3czI4WEhjZ0hZR1dw?=
 =?utf-8?B?REpqUHErbmdrU05TNGVNODVGcGw5cGJ4RjdIU05HUU4rakR5YklYYkptUzNr?=
 =?utf-8?B?STZyVFhhMS9wbGtMTnVvbmlWNGVJNnlMc2x1aEpveHdIR0JydXA4ZTY5Ukpy?=
 =?utf-8?B?NWpIZ0JQcUhLWm0rM2VBODhUOXErbmpDREVLdlRGOVZMcVAvV0RLMkZHSFNX?=
 =?utf-8?B?YUd5US9JcTVnOFVlQmlPWnh0bXNVZitIY09YdU5uMzlXdjc1VTduQkNOdnlU?=
 =?utf-8?B?SEpVRUZlVjlMVEtmMjZkN0lvZm0vcWh1NG9HTW9HUExsamt3c0U2bWdDK2FD?=
 =?utf-8?B?dkhpQ0wzeDEwbEoxWVJKT2lheXA4Mm94ckEwQjVpN0hrZlBGVFRReW81cU0w?=
 =?utf-8?B?T2lXMFZrdzRNQVlQazhqT20vS25WM2p1QnlJcUFydkJaWkJOUDRhbXM2MktR?=
 =?utf-8?B?czhVMnQ5eGZrN0V6MHJ5RDl5d2FkZkZhdjZzRnpzVm1oYTc3YkJGNm4yL0tW?=
 =?utf-8?B?cmdJWEEwck85V0NobE40UmVxcWZrOERyaEJKeWZKMktkREFPWVZrQkdpa3FZ?=
 =?utf-8?B?NTFyZUN6eVFMTWpQZG5ZcktKb0VQMlVYcnJUM1Zkc3dlUHVhbEhPdzBwUnRZ?=
 =?utf-8?B?a2daaFM3N3htM2sxbkN2VFdzUEkrTXVGK2lORG1iUU1yVkZLZWVsWmhWUDZ3?=
 =?utf-8?B?am1OcytlVHl2RXg0OXkweVMrQkJvMnJkeTVBVGt0amp2ZkRwYUVrNzhFQWlr?=
 =?utf-8?B?RmdDcWs0NkVWSlRVeENOelJMU0t3ZVhXSndTRG5vOEt3T0t0b0ppZUZJYzUz?=
 =?utf-8?B?L2NGRlhTM0M1WVZtdmZVNVhiUlFyNGs5dVU5WFA1SUZBTTZ4QXd0d216ZTRw?=
 =?utf-8?B?ZFhIWjVQL1pvRUFIS2toQy9XUUFkZ294dnBvS2tFR0FFY3pKeVpReTZKRWVB?=
 =?utf-8?B?RjRBQnhBeUFoWHV4LzlKTmVDcnV3SWpMT0RoUHVEMmdBUmx3RFMyNWFvRDc0?=
 =?utf-8?B?VW1kTk1aamlTWnFHcWRicFN4NXhhaWhmNFMxcEtjL0NPWlptVVB5dTg0UEQv?=
 =?utf-8?B?cS9mWjJoMFR2ZVBheUNndzdkRG5pTXZKMDIzQnV2K0pCNktmSUtQTTBWWTNL?=
 =?utf-8?B?YzY3VnpYcE0vTU9uTE0vbm5ydlpWb05lY3BTeU4zcUdMSUxJenlCd0s3clp4?=
 =?utf-8?B?RmU0NFZiTlF6ejZ1cEVwa2ZQNmdMc0Vrbm55RXoybE84Q0JHRUVFd0NZVjJz?=
 =?utf-8?B?YU5SL2NpanUrRFRzSmVNeDErMG9PSmNGR3dmblEzbFdCUHBsTGx3aDRiZjYx?=
 =?utf-8?B?TjZ6czdkOUFhMGdadHFnZjExbG1lU1Y2eU83MGFhcGdYMHlZTjRLdnZBNlBB?=
 =?utf-8?Q?lwflRfsa4/XMFUqeJIj0RSxWb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5dc4e71-ca5d-48fc-faf8-08dd5ce5726f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 19:31:09.5667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dewHjpX37K4NvnXn6NGLznZVOtwq0LRu74icuVBx7TFQGZ4M7eEPNBVTsUgZJO8IsQvlcYqkBdB+OvuPborzuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7617
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

On 3/6/2025 13:19, Alex Deucher wrote:
> On Thu, Mar 6, 2025 at 1:58 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Modern APU and dGPU require DC support to be able to light up the
>> display.  If DC support has been disabled either by kernel config
>> or by kernel command line the screen will visibly freeze when the
>> driver finishes early init.
>>
>> As it's known before early init is done whether DC support is required
>> detect this during discovery and bail if DC support was disabled
>> for any reason.  This will ensure that the existing framebuffer
>> provided by efifb or simpledrm keeps working.
> 
> I think there are a couple of corner cases we need to handle:
> 1. if adev->enable_virtual_display is set.  The user has configured
> virtual displays and hence they want to use them rather than the
> actual physical displays.  This is useful with GPUs in servers or for
> early bring up.
 > 2. If the board supports DCN IP, but all it's been fused off due to> 
silicon flaws (e.g., adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK).
> In that case, we don't want to fail.

In that case I wonder if it's better to use 
amdgpu_device_asic_has_dc_support() instead of 
amdgpu_device_has_dc_support() which should cover both of those concerns.

> 
> Alex
> 
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2:
>>   * Update commit message justification
>>   * Add correct "default" handling
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 46 +++++++++++++------
>>   1 file changed, 33 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index a4258127083d..24f532de6322 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -2139,10 +2139,6 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>>                  return 0;
>>          }
>>
>> -       if (!amdgpu_device_has_dc_support(adev))
>> -               return 0;
>> -
>> -#if defined(CONFIG_DRM_AMD_DC)
>>          if (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
>>                  switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
>>                  case IP_VERSION(1, 0, 0):
>> @@ -2166,39 +2162,63 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>>                  case IP_VERSION(3, 5, 1):
>>                  case IP_VERSION(3, 6, 0):
>>                  case IP_VERSION(4, 1, 0):
>> +                       if (!amdgpu_device_has_dc_support(adev)) {
>> +                               dev_err(adev->dev,
>> +                                       "DC support is required for dm ip block(DCE_HWIP:0x%x)\n",
>> +                                       amdgpu_ip_version(adev, DCE_HWIP, 0));
>> +                               return -EINVAL;
>> +                       }
>> +
>>                          /* TODO: Fix IP version. DC code expects version 4.0.1 */
>>                          if (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(4, 1, 0))
>>                                  adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 0, 1);
>>
>> +#if defined(CONFIG_DRM_AMD_DC)
>>                          if (amdgpu_sriov_vf(adev))
>>                                  amdgpu_discovery_set_sriov_display(adev);
>>                          else
>>                                  amdgpu_device_ip_block_add(adev, &dm_ip_block);
>>                          break;
>> +#endif
>>                  default:
>> -                       dev_err(adev->dev,
>> -                               "Failed to add dm ip block(DCE_HWIP:0x%x)\n",
>> -                               amdgpu_ip_version(adev, DCE_HWIP, 0));
>> -                       return -EINVAL;
>> +                       if (amdgpu_device_has_dc_support(adev)) {
>> +                               dev_err(adev->dev,
>> +                                       "Failed to add dm ip block(DCE_HWIP:0x%x)\n",
>> +                                       amdgpu_ip_version(adev, DCE_HWIP, 0));
>> +                               return -EINVAL;
>> +                       }
>> +                       return 0;
>>                  }
>>          } else if (amdgpu_ip_version(adev, DCI_HWIP, 0)) {
>>                  switch (amdgpu_ip_version(adev, DCI_HWIP, 0)) {
>>                  case IP_VERSION(12, 0, 0):
>>                  case IP_VERSION(12, 0, 1):
>>                  case IP_VERSION(12, 1, 0):
>> +
>> +               if (!amdgpu_device_has_dc_support(adev)) {
>> +                       dev_err(adev->dev,
>> +                               "DC support is required for dm ip block(DCI_HWIP:0x%x)\n",
>> +                               amdgpu_ip_version(adev, DCI_HWIP, 0));
>> +                       return -EINVAL;
>> +               }
>> +
>> +#if defined(CONFIG_DRM_AMD_DC)
>>                          if (amdgpu_sriov_vf(adev))
>>                                  amdgpu_discovery_set_sriov_display(adev);
>>                          else
>>                                  amdgpu_device_ip_block_add(adev, &dm_ip_block);
>>                          break;
>> +#endif
>>                  default:
>> -                       dev_err(adev->dev,
>> -                               "Failed to add dm ip block(DCI_HWIP:0x%x)\n",
>> -                               amdgpu_ip_version(adev, DCI_HWIP, 0));
>> -                       return -EINVAL;
>> +                       if (amdgpu_device_has_dc_support(adev)) {
>> +                               dev_err(adev->dev,
>> +                                       "Failed to add dm ip block(DCI_HWIP:0x%x)\n",
>> +                                       amdgpu_ip_version(adev, DCI_HWIP, 0));
>> +                               return -EINVAL;
>> +                       }
>> +                       return 0;
>>                  }
>>          }
>> -#endif
>>          return 0;
>>   }
>>
>> --
>> 2.48.1
>>

