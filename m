Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DAFC77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 05:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F2B310E05A;
	Wed, 17 May 2023 05:07:20 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F3610E3A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 05:07:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwF9BuhIhAsGRw6cghsskmlThWfpAVIHOMgGlPrRqw6CZht94ttfN4Om+4GJuFU7T8C3CDlP6Lf2kXf+oO4FBEHEvjvP+Euj+YWwGtAT8JRCfJ8dWte2S7oqZqqG4LffFXGFuIaFMy0M558lyAwZ0AjlHifwQeDvq7mdKH2eCLTh12gW3rjjAEDCtFc1f7d3Ujq5QCePPDVfvpwXd/GpjR36/uz62/q+ZwT7GkCr2SC30m2HxQAd1P4MdYeCU2AuCg+ep3rfStMHvvw7q0UBuMJ7hdPhkVmit/nQKvcza9wlDt+peab37t875CXJY/dByIqsGIlk7LYvCvVX2Egp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFK54YICeS4kS65T1z3ZW1vPCnqWuaZ/b61yKjqQIYs=;
 b=c3ab4Rk9i7/dxHB7FnIF9hv0FinOf7NW0tuHCaQbv2eNcHA/RJm/Nyu+mh8+kxSSs7Vg26lBG7xSjd25C6BgWj4XMAvqX+LRqbuO6+c+dLuDGUEcSm2HN6B21wlb7H2/Fsm873BN2yZ5gFX3vfvMZjPVs6ixZpsSIC7QSxYvGqPUu6upIGPwMuq7bXbGjS+iHoJ5p0a5avMaZb/fWvkcQuZECsTIggoFzCgHRdgzZWTk9i+pvcnnEoMknOWx6iOvXZSTF+71Yf2g/L/Z2rF5+wgv0pzGUX7bCcLbTIMtrf+sb69n6gJuMQ/caKFTndTP4Shj8iWEx3jYX/AeUboYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFK54YICeS4kS65T1z3ZW1vPCnqWuaZ/b61yKjqQIYs=;
 b=HNtNliFcNjSLv6f7PJ0xuXRE/jdToWvCib3zRAcoDu7YZ1k5mgTTlLCvqpDw5z1pjn9gZ7a5psFWrkhKfBljvBDbV6Zt890e7RfZKXxAP8u32fi6UXM2IG7g0XphuzVpO7BGohBdSUJMd6xgc1w+4VHwfWrnCabuHDzegLjvrIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 17 May
 2023 05:07:15 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431%6]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 05:07:15 +0000
Message-ID: <c4d8fe46-2a0e-9947-e96e-e30507725f9e@amd.com>
Date: Wed, 17 May 2023 10:37:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 0/3] Fix DCN 3.1.4 hangs on s2idle entry
Content-Language: en-US
To: "Limonciello, Mario" <mlimonci@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230516233420.2087-1-mario.limonciello@amd.com>
 <89d0c8be-d118-1b02-0406-835557d712b1@amd.com>
 <55fbad92-010a-f7bd-6a90-ac105acb38eb@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <55fbad92-010a-f7bd-6a90-ac105acb38eb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::16) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aaf5577-16b9-4095-d21a-08db56949484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GUxqIHVSQSqoDUc07toSUJtttxQU5qnpN5C03iyV3kaf8AggbrW1SzhvYZKZE3W7yFw0dqeejTYvll4Uj2RWy4hZeOy+jxp6jbzNlKuRo9y2p93+DhJ+2b4JLhcC3nASMBEupI8U+Ri8Ga4XZDGaZXl17pbwf5K3B02P++FdbuVWmQwlaYTTdLsPxgbsktMiqBXZz2jd2m6EHPY7MEtpPxB4v7asBOegPkQlhCMArRzxCogP5LGQzi0oo0luT29IfbAJK+8jRS/fKK9bQDpPRISbjbJ/PYCRilP4fahtPrWLIDXkSRMn1Zjyjf9QuLOL7vfPSkmzgMnkQtIhAR1lwkYea0RDko+xf+7HGqxs0LlhlBT7S9YIWNbeB0x6C6IJVYiIj3Z1SPKSw8RssEvSZnKe6F+UQuqwp+sRyglYkY5CvDhEJzDXzqpry3BmrFX87ypXOhOjZgLrktLNvK3B+qxe/2M6tWVHt9TGs1YLqQU3h5Li5N3+35MwqzHXvxpEJ9oaZE5w7dt+aRzGu2G2hqrIJILk97vfagNvkCfDMpZQtUV/uUBCLY6AYK7tzR4ck388L6ZKqFiZqf6Swe8A/zfRQ3FEkg37Gw31jUj9BDuRWze8NSgwNcT6A6RWdgCPb1xFkTyAyQp0NQCoMmrKkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(2906002)(6512007)(66946007)(66556008)(83380400001)(38100700002)(31696002)(2616005)(110136005)(6486002)(186003)(36756003)(26005)(478600001)(53546011)(6506007)(6666004)(86362001)(66476007)(31686004)(316002)(8676002)(41300700001)(4326008)(5660300002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2VRMG1oTVdoSk02YmxNZkhtcTgxaEJYMFc3Q0dQczZldG03WlJrNWhyaEJO?=
 =?utf-8?B?TzRsOStqcDdYNEpQaTk4RzZOS2hMMXJoNENRdzVpUkZsS3dmMGh5MFpwK1gv?=
 =?utf-8?B?bFRlYkRNVUhITE5ySGhPc1hweWJBdWNjMklDNUJGSXlpbnVUN1FVUDlMR21h?=
 =?utf-8?B?QXNvc0REamxlcWlvTHNNRTdRbXk1Vm9ZV3JWVmNPZFNkVnJGbkhnSXduSUlM?=
 =?utf-8?B?a0huZUhKU0lqY3dqc0QxVDEyMGkzVTlGeVh6RkNlZVUvbUI5VWFudWM2dkI2?=
 =?utf-8?B?SEdmcWZnUEVzM2orUjNRYjhPdjdXanJTdkJ1d2ppSjhLb3Njd0FFVThDTTh6?=
 =?utf-8?B?OWZXUHpMTGRaZStjTGZnZTI0NE0vWlc3cHcza3RPeldvRjlSSndxa1hDYU9C?=
 =?utf-8?B?dDJ4N0NEcGljLzBYNFZRNU5taGQzaUJwR0ZzV1VTVkp5aXJCeDkvWHV4ZG9h?=
 =?utf-8?B?NzlNQ0NXT3JnbmtHSWlyL3lKVFVScUs3OURCNnNnUHRiODZsSVdCalduTzBE?=
 =?utf-8?B?ajZ3UFhrMDBaaVhEMWRUcXkwV1lTaUFkS1JtenRVVlhWZ0dWcUVvWjZhWERG?=
 =?utf-8?B?RHAxNnVtOVhINVJHZjBKaytVYm8zcTNSZnRTQmlia1g0czJXMjNYcjlNUlJH?=
 =?utf-8?B?MXlWS0F3Nk9PMjdMYVkzd2M1U1V1aU8ySmdUVmgvc1NSZmhocUh1dE5PNjZu?=
 =?utf-8?B?QlMxakQ3eHg2UFEySzZicjVCMjd3Z2hFbnNNVEF4MEdIcUJXUndWQkxmd3Mv?=
 =?utf-8?B?YXFmZVF0VnN1QjM4VHUyVitaNzFTZG1mdW1VNDRGMllHaEtXNjZtTFJWWUVF?=
 =?utf-8?B?NjYxcHRRNkwwdjYvVkhoWktudU1hV0pNY3Q4d3VFRlpET29WM2owbTh3b0pn?=
 =?utf-8?B?ekhOOHltRmxwZTAwWU9yTUZqcmZlaVlGQWk3NGI3Mk8rNDQzWmVSRWdVVCtW?=
 =?utf-8?B?OThaT2xVaWUydGk1ZXdmM0FHYXQ5U2VoV1dpOHVrM0lkL2dnU2tkM2RKMCs1?=
 =?utf-8?B?RExoREtPTElidEQ0UUpvUFlCcDU3Yk56bDVERHJ6Q2oxNE9KU3JvbmVjc2th?=
 =?utf-8?B?S0R0ZnQwMzM2Wk1nQllUeGZiaE5PYjNnMmN4bXB1U3krMUNRNnhXRmxWWVFq?=
 =?utf-8?B?R01RZUlRc1poQXNvMWpnWHhxbTl5YzA3cjM4WUxRa1lsa0xkZlpEeEljdklG?=
 =?utf-8?B?RGVTTTFmTnpFN0xydW5tdHVBd0l0ZFBEMjRTaVM2M3hiTnZxeTZ1endlc1BG?=
 =?utf-8?B?MmN2MGgyK2t4bUpnOW1tZ0lFSUxLVjNhSXU0R0hxRkVMNkczQ1JhcmlldDcw?=
 =?utf-8?B?K20vTTk5cVJlM0tuN2Mya0MvUHRyT0szSTZGU3p3L2g2bld4N0hMVk9XWWFL?=
 =?utf-8?B?bjRYcWpUZ21TSG9WOUJhY1FuVFhHNjZGNmJIWXM1bmtwaGxrdXdVQUxKNUho?=
 =?utf-8?B?bGwxRHlpZGsxSUVIaDJxSmplYWxjR2JUN0tZOVk1SjhPd1pWdVVpbVhVbW9W?=
 =?utf-8?B?cWQ3UFVwRUZOOFY5R1dNNlBRbXVLcEFNWWlrNFpLWXl1MEFIV3lvc3RoMHFz?=
 =?utf-8?B?aVNiWFNLNElwanJXYU91dWtiWmNGR3lucGxqbDJ3eVRLR0hNS3pIQ21COTc5?=
 =?utf-8?B?RkVXdUtNMjdud204MUVEQ1BmNUpEYjl5WFdCWVMxaUtuWHVvRVJKaXd1OXA2?=
 =?utf-8?B?ZHFnaStmQksrbXFFZ2hWcUtnTXFTZnlURmJub0NKbVV3MFpVVkxaTGZOS3dF?=
 =?utf-8?B?Mzg5cHNQN3VNUXh5NWRoZFZFRkdra2NHMmI5akZVUURMRytDUFFudlpFOWNq?=
 =?utf-8?B?RHhnSGVxNzB5ejM4ZENHOFQyV1R0YnU5czUxME1iZFo5QkpvVktYcFR6d3Jy?=
 =?utf-8?B?K0NiODNXRHRqTERGTmRHZWRuWldLSXhQV1pEKzBUSjBHaHdNQzZqRFJGMmda?=
 =?utf-8?B?MCs5SGtsM3FRbEd6TEllTkdxTEVVNjFlSGU2dHVrb0NLaFVzL1pTVG5RT3lw?=
 =?utf-8?B?L00rSkJVWTd2am56Q0NNTUNhcUJKSTNWbkI3UXMwNWpXd1FFblNnak1uQkpx?=
 =?utf-8?B?WGM4RUwxcThLSnM4TzhORkZ3dkRGczlvZXhGZFRtd2Rkc1FxSlpnME9TRVNO?=
 =?utf-8?Q?FOni/cpbITJzCKmY7cBvAEF8T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aaf5577-16b9-4095-d21a-08db56949484
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 05:07:15.3759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uO/dm9u/E4FUYb4qunzbIZsf0yUhNt7jCrnuGe29DbiCjm8PYFfFlh2DgZ8anA4/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979
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
Cc: anson.tsao@amd.com, Juan.Martinez@amd.com, richard.gong@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/17/2023 10:25 AM, Limonciello, Mario wrote:
> 
> On 5/16/2023 11:43 PM, Lazar, Lijo wrote:
>>
>>
>> On 5/17/2023 5:04 AM, Mario Limonciello wrote:
>>> DCN 3.1.4 s2idle entry will hang
>>> occasionally on s2idle entry, but only if running Wayland and only
>>> when using `systemctl suspend`, not `echo mem | tee /sys/power/state`.
>>>
>>> This happens because using `systemctl suspend` will cause the screen
>>> to lock right before writing mem into /sys/power/state.
>>>
>>
>> A couple of things on this since this mentions systemctl suspend -
>>
>> 1) If in s2idle, it's supposed to immediately signal and not schedule 
>> delayed work
>>
>> 3964b0c2e843334858da99db881859faa4df241d drm/amdgpu: complete gfxoff 
>> allow signal during suspend without delay
> 
> It looks like dead code to me now actually.
> 
> amdgpu_device_set_pg_state() skips GFX, so gfxoff control never gets 
> called as part of suspend path.
> 

Ok, that means schedule happened sometime before. Can we remove this 
code also as there is a flush anyway with patch 1? Also, is there a need 
to call GFXOFF forcefully on S0ix suspend (any chance that gfxoff is not 
scheduled)?

>>
>> 2) RLC is never stopped on GFX 10 or greater.
>>
> System was hanging before this series.
> 
> Patch 3 "alone" matches this behavior as described above to skip RLC 
> suspend but two problems happen:
> 
> 1) GFXOFF workqueue doesn't get flushed and so driver's request for 
> GFXOFF can happen at wrong time.
> 
> 2) If suspend entry happens before GFXOFF is really asserted lots of 
> errors on resume. IE:
> 

Is patch 3 really required?  Does it make any difference?

Thanks,
Lijo

> [   63.095227] [drm] Fence fallback timer expired on ring sdma0
> [   63.098360] [drm] ring gfx_32772.1.1 was added
> [   63.099439] [drm] ring compute_32772.2.2 was added
> [   63.100460] [drm] ring sdma_32772.3.3 was added
> [   63.100504] [drm] ring gfx_32772.1.1 test pass
> [   63.607166] [drm] Fence fallback timer expired on ring gfx_32772.1.1
> [   63.607234] [drm] ring gfx_32772.1.1 ib test pass
> [   63.608964] [drm] ring compute_32772.2.2 test pass
> [   64.119173] [drm] Fence fallback timer expired on ring compute_32772.2.2
> [   64.119219] [drm] ring compute_32772.2.2 ib test pass
> [   64.121364] [drm] ring sdma_32772.3.3 test pass
> [   64.631422] [drm] Fence fallback timer expired on ring sdma_32772.3.3
> [   64.631465] [drm] ring sdma_32772.3.3 ib test pass
> [   65.143184] [drm] Fence fallback timer expired on ring sdma0
> 
>> Wondering if the code hides something else because of the timing.
>> Thanks,
>> Lijo
>>
>>> This causes a delayed GFXOFF entry to be scheduled right before s2idle
>>> entry.  If the workqueue doesn't get processed before the RLC is turned
>>> off the system is hung. Even if the workqueue *does* get processed, 
>>> there
>>> is a race between the APU microcontrollers and driver for whether GFX
>>> is actually powered off when RLC is turned off.
>>>
>>> To avoid this issue, flush the workqueue on s2idle entry and ensure that
>>> GFX is really in GFXOFF before any sensitive register accesses occur.
>>>
>>> Mario Limonciello (3):
>>>    drm/amd: Flush any delayed gfxoff on suspend entry
>>>    drm/amd: Poll for GFX core to be off
>>>    drm/amd: Skip RLC suspend for s0ix on PSP 13.0.4 and 13.0.11
>>>
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 ++++++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 18 ++++++++++++++++
>>>   drivers/gpu/drm/amd/include/amd_shared.h   |  1 +
>>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  |  4 ++--
>>>   4 files changed, 46 insertions(+), 2 deletions(-)
>>>
