Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17A8C19F2D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 16:09:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0CA7B0DAA;
	Tue,  9 Aug 2022 16:09:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2040.outbound.protection.outlook.com [40.107.96.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB4832BD15
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 16:09:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE7eCybMBgf5obRfKAniaX2tUiktBhZaVWA/SW0/5FYPNTvxp0ni2S0xUQZoQfiqPZgCt5EUBtkLrBO9HrWQCqflSwEGnvhwgSVtxHzFo9fTCKJMBC2M5riGTII05qGwZLq+AjakXbYkLie4siKasqxMKGWIOoT2hgLKSv6XgM+RXaW4djpCHlJwWe+mabXUcGQHrXm9cZsCvFiHUgk2EuvfHwPuV8cgm8DnHM8SXWFThAlsmTiLDCaCwW3BNJ10WPzc3mKBTJnjdfiYzLp1whSuCY+f0APomW4YRbpP3ZT/iKFgPVCWTUt1vyRE2Nbf086qNmBe0jlTEOVjEevcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ejn1fONxRJAgH2xz98fvJwaweyxnpDmVfjAfNTLAoQ=;
 b=d5gvRbM8eez4LNTgdlRgJV4j8irSRxPS1XMIg83CB/WpUr0uGj3++DFysPJYLJbziJl5bT4Q4h0B45YEEoAB8jK/s7pS3ZM9dPnwlVOQNHKAzoalbPHTHyoH+LZJxg3SdRFlRSF17DPW4zq/yJg7oXi3i7RLq9x5e0+lYNfZav5f3VfajPMXeI7kkTLU0P0vsxnZt3M3H7ISJxEeAEN7lU4ojXnOIlSCZ+rq6FFXMG36OEq0mxVfuTgOCSTl94mQB+qGRI8BniJ7Sh2DlpKLBunbzBJhsfLD/EEyE8JvPYSk5oVABeGzcxs4PmhaspfD90mxmbvya05GiPfFNLV59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ejn1fONxRJAgH2xz98fvJwaweyxnpDmVfjAfNTLAoQ=;
 b=wAAQOVf0J0T4HxHav3FlwVTT0De6grrtrTQzTe0dBpE40DBH6ePqjBqy0XsT8h6JFFeu9/opR4F1ODLaI/YknAzOU6FztNN3C88uBJ0sPGUF2cT6g0FWoCj/g2pL4/z/Y2TAXiWFK95CdhiAV5siJaMJAJ9tafNHo8Oe7k0xCB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 16:09:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67%3]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 16:09:15 +0000
Message-ID: <8eaa78aa-1dd7-18a4-d3bc-0da6ab34d18a@amd.com>
Date: Tue, 9 Aug 2022 11:09:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/4] Fix S3 and S4 issues related to fbdev
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220809151008.20376-1-mario.limonciello@amd.com>
 <CADnq5_OTV8C8oSicO7=7TAGy1s9ZwX40Pi1XHYFCizw_UiO-8Q@mail.gmail.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_OTV8C8oSicO7=7TAGy1s9ZwX40Pi1XHYFCizw_UiO-8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b05be2b3-a75c-429d-4f69-08da7a21816b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4392:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U3Pzs1TfF8sQLAbYwKBoTMQQIkfp/WI71ZzXl93DDM6lZ4HnSYNB7QxWLLr9N2cYepEtSIbXdrWRjUmlAOmrxVYDF7PrCLqENPjv56WrR7UQl1Xj72gz4g0217tjI4Z5+39w2lAnsIkUPoCCSF3xJY0VlkhqG48EJstqTupRqJZvfwxQS9JSSCsrMAjp2GPnXkzMuW/XCK0+3wYRkftlySSUc4qihGZEeh02ED+78NAe7w/s4a5pYCtPR5qvIPoFxeH5xlgyMbse+qTNWm6nj6vMpmHGZzlfIBClKyi52dji9ecadUirZdDIhY+kn88lz/0EGLKu/MmaGiSsfgajoz5qzatDKsoHIOfW+UXsOMhbdTpXtgb7xcmsK4At5vASjOVRquOKKDr9OL845u5NpncEZdzKloss0sGRRyarm6Mp3y4S8ss/ngprxYA5ch8bvssTBbIp7qjnHqcB8BtNV4ClO0iWOGi0x7hs34Ws9DIgwAuQJfKM6+GZ0bVQOrLzzqLTgQCR6XhpyAgIx75gk8dxdfwxSWDjieISIdjCLzzz/jxBoWg+o4DW5ewj1btyXlWJXDeympShKxhm8hItEl8qVK+SwVrtd4DXBBpzUQsKqV0xMJTmrUHKwLO6iHG7gR1mKh2grKSjrQpu96IU80Lqbep5NYWTnr4e2urfjd26d4PJLXM/BmsDOFOkgzGVnBsC/gcINNPuSQN7yVZ2JEbJFKqVTV2+3SbjzheMrW6DgHhJazfDxoHewo6k/Cxk3emAMgY3ngPx5Lo8bA75m4y0aEUS5WmpKHGi7aTR6hl7WDgzPc0pPFrUGX6RNSPmFLVGs+O6wRfRfRb54cgv3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(316002)(6666004)(2906002)(2616005)(6916009)(478600001)(66946007)(36756003)(66476007)(31686004)(66556008)(4326008)(41300700001)(8676002)(5660300002)(6486002)(38100700002)(6512007)(31696002)(83380400001)(86362001)(26005)(8936002)(53546011)(6506007)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnJSbUtKS3JoVXBSZmFqUHBVV0dHVGtsaDErSWxHdkFNSkVEZVRqMmRVYkE3?=
 =?utf-8?B?NVZ4YVAxaHdDOVlVUnlHQ1RFRUZPWk83YVh2WGZ3d25RT3dEWS9XVlgyZnI1?=
 =?utf-8?B?OHpCS1QxbVA2MlJKOXMvaEtWVERwenRqQU1HSzBMbXMvZHJMbTVjT0RPNUZV?=
 =?utf-8?B?TjRDWUV6V2h1THpodFNxd1FqTWlVdjZrdzcxMVpySDZ1UzdDaWhtS0FOamJP?=
 =?utf-8?B?R2lYUVo0eVJ1VXREM3grSlVkUUlWRkYxQ3JiNDlDL2lXOWNzN3J1TUZvdHQ2?=
 =?utf-8?B?WVlLUk5ydStUTkxGcGFjdzRvM2ZKcVZCbGlqRC9BUW4rc1llNUNVZjlKYWRX?=
 =?utf-8?B?TFY5dUQzTUlMcTZoQmtkMG5LTW5ZV09OVnR2WUV4eUtNeUVvZHN0UDgwSDhI?=
 =?utf-8?B?aWgxTGY4RXIwMUYrRlVCclNZQWdUV3l4L01jUGFmaXk5MXc3cyt3MDR4ZG4x?=
 =?utf-8?B?SWNvOG5qVEs5anZtMUZId1NxcloxQ01VT1ZYM3JjTXhXdHZSZHVxd291K01N?=
 =?utf-8?B?VmFrbCtCRmd1L3p5a2NveG9RMXpOTWk5MU93T0d2YXR5c2Noa0ltQ2RTWmsw?=
 =?utf-8?B?NFZOZ2pDLzFnZEYzZVZIa21ob1RGOS9XUzgyT0ZHTlgxeXdlRHhxNmxuNE9n?=
 =?utf-8?B?ZWVPT3d2dlA4RWRCcUg5WSt3OW5aeWhQUnU4dW1vSDVGcGhZSW9ITVR1OWE2?=
 =?utf-8?B?M1R5UEhjZTlDRDVXU3NVaTFINWU4b2RyRHdCZHRTMk9TMkk2RG13SG8rNHdB?=
 =?utf-8?B?cEVRYVB1aCszaWdxaWJBMkFramhzSzRHaHJWUlM1aTg3REhCZmNtTCtjeDJl?=
 =?utf-8?B?MFFDVlh3L01CZmNVek1Dai9DZFpKcWd3eVkrNURCVUFBY2FPL0NBY01Ga2Ro?=
 =?utf-8?B?L05kTE9mWndqYXI4U1JaL1NDSDJSWUtDaHdQQk5CeHZBOWRidmtQb0g4bFVY?=
 =?utf-8?B?alB5U3c2Q1B3clRxMnBKWm5HR0tGWktEaDhKdDM1TEhHNXRVd1NEL3h4QjFC?=
 =?utf-8?B?YUNxVjlyR1lMSEVTalpGWTNYNEtNN2VzUzBHaFpvNVRPQjJCcnYvckcyRDBH?=
 =?utf-8?B?V2xBTmpST0VoQ2haMzRIMExoTDQrWWxKOUdIT1dmTVp2alBvemlpeURmeSsz?=
 =?utf-8?B?OGhtTG1VaVRxL2VrYnZIbUhZRVMyanVuZGJ2dnJBVmszaStGeEs4MFBBQ1cr?=
 =?utf-8?B?MUlqdjdlYmxsTnljaGhDQ1cxTGY1a05rbVQzaS9ocW42ZmhNUUhNUXJoakJG?=
 =?utf-8?B?WTNZNjJ3MVRvYzUrZlBqWkhnejIvTVM5WFZaNTJ1ZHU2OG94WWF0d2RJbFBR?=
 =?utf-8?B?RENnQVdIeDJ4WDJzd2xmaUo3bE9BdlFXaVpYTFFydHE4WlhNTEV3UEpvNDM5?=
 =?utf-8?B?TnM2RW9oSFlrdU9icWZyN0ZqVElQNTdzbFpPdTBLMVR4Q0Fja3JjZS9wOURL?=
 =?utf-8?B?aFp1dmUxdUE1VVM0UlFCZFdvWmJWWGlsN1lZNlZkWnBVM3JJMmJrK05CaGQ5?=
 =?utf-8?B?R2ZyMUh0c1FmT2RQSzBMUlZ6SVJWWFNRa0NrMEwrVEo4SWU1S3RGK20vYWRT?=
 =?utf-8?B?WHErOTk2MmllMUFQMDkrTkpBdFlrVmt4VnhhNjY0RHZKcjdQd1ZmZVRnWjRU?=
 =?utf-8?B?YWxkdStkT1V4S0RLVVpqK1l5RHY1VFhCdWpPL1d6TGEyK1NoN3BmcytSSGo2?=
 =?utf-8?B?bHBUdVU4bHVDSHJaT1AwQ2pSODEza0laeVVIYW9kN0VSUHNoWHdXVk9rUXJZ?=
 =?utf-8?B?WC9vRmxQSCttZkthOHA4UlNuZTFWQ0xCTVU3UGQvVitrWGlnNURSemlBNVFV?=
 =?utf-8?B?TjVHbXhhWDVKc0NEeE9Mczloai9remxhSGZrZ2NuM205UmRCVEZEL25MUXZH?=
 =?utf-8?B?a1NYQmo3MkpEaUN2VHFPWjFPVmVoV3B0S1FMT045MFZRa1dOUytmU1crR0g4?=
 =?utf-8?B?cHQ5QWpSaVpPM0hHNlBCUTg2RHMvTkJ3YzV3Nkg3K0szOUExT2xGWmpoVVRN?=
 =?utf-8?B?M1cyaDhmZ1JlZUhqRWgwMXM4RVVwT3c2MDF1bDR2c2dlc2ZDNjUreGFURUdi?=
 =?utf-8?B?TlNBWUdzZm5UMUFuZzBuQnQ1aWhrQ2FmNXBGVXdSdi9qdWpmbWR1T0JRb0w1?=
 =?utf-8?Q?nVTp4W66oPRl5rkRJdGIqD7hv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05be2b3-a75c-429d-4f69-08da7a21816b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 16:09:15.1086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ea830cF/J4nV1oP11pGHem/EvA/HLc1t5yhzcHSiB7FfG93HradoPbzmEGl1EqQVUU2ko54fTZtOv9QWAWph9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392
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
Cc: Alexander.Deucher@amd.com, Evan.Quan@amd.com, h.judt@gmx.at,
 Renjith.Pananchikkal@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 8/9/2022 10:50, Alex Deucher wrote:
> On Tue, Aug 9, 2022 at 11:10 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Moving to the generic fbdev helper introduced a regression in S4 support
>> on Hawaii PRO graphics cards.  A workaround commit was introduced to
>> avoid this S4 regression until the root cause could be found, but that
>> workaround commit introduced a completely separate regression on S3 on
>> a WX3200.
>>
>> This series reverts all the code to move to generic fbdev helpers to
>> fix both issues.
> 
> I'm not opposed to reverting this, but I fear we'll never get rid of
> this old fbdev code.  

Yeah, makes sense to me.

> What about just applying the workaround for
> hawaii as per the attached patch?  There is always the concern that
> this will lead to more workarounds, but I'd rather avoid touching the
> older asic support as much as possible.

Yup that fixes S3 for me on the WX3200 (tested on top of 040370564b68) 
and I would expect keeps the W/A for S4 on the Hawaii one working 
effectively.

Reviewed-and-Tested-by: Mario Limonciello <mario.limonciello@amd.com>

> 
> Alex
> 
>>
>> Mario Limonciello (4):
>>    Revert "drm/amdgpu/display: disable prefer_shadow for generic fb
>>      helpers"
>>    Revert "drm/amdgpu: keep fbdev buffers pinned during suspend"
>>    Revert "drm/amdgpu: drop amdgpu_display_gem_fb_init()"
>>    Revert "drm/amdgpu: use generic fb helpers instead of setting up AMD
>>      own's."
>>
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  12 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  43 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  13 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c        | 388 ++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  30 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  25 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |   3 +-
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +-
>>   13 files changed, 457 insertions(+), 74 deletions(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
>>
>> --
>> 2.34.1
>>

