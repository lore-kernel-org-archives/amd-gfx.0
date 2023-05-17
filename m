Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59FFC77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 06:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33AAE10E3AD;
	Wed, 17 May 2023 06:24:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA6610E3AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 06:24:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6/FS6MstPdtXLBNI1MKeOtwrv0TbxiU1Fg4+++vUgTHvkqtLZnDIySV0MilwaL1AQ1JjZOi9QkmfSMFalpr5Mz570+iAJwf2klXCP9zqfkgXdpB/bfX8gX9itP+3yCxYeswx1n1Kre+XZ+dmr2nMZETY7BTLaaxkju0oxjYi/9vQqkmZ9wWc9U5QT119Lz9byIrCvTfZ2stNQ5H8yk/+jtxmRUONFCQi6gG6mcv3G4Q4N8cnFrgUuor7IgUnJV02y74sGG4KPsM9P+HF/+G5n/U/nwcXEOgFr04cMaDdfh1R6KqWIDW0rfptUt90od1QcXwZXTwtNgfOxUP/30Zpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpmuQrqV+dPBxsQ3SRyjPZ27zIh2YgijoWD8ToIZDXI=;
 b=VsGFX2OrxhysycfxbEgiSdmVq6IzYEJl0JS6g+U/rrYUT89gwJbvS61j05TIlQoEBAqlmvwBoxz3MsifXIUmwR2Ug3pqmW6zuYu1WQ52C6UhGaUv4xqsfA+boEj+nMxaYESYV7FDwjKagDbtcA3ZmF2zGTUtkEFjFpt2T8CDOB5PrbOb9QR76AJfTNgbCEglDdMCiw+CxiLlMrMwlhXYEVJsgeUGcz5ggSbyPSBPJwxgBSvMahf040Mh1G3PWtNV0IMvGL3PteLwy8R3GnZpR+K9tAqCKyU40duSS+1cpzlPoOVNGh+W1ojIE48PMtP8wL6wCUO03BZj2WIRrESGog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpmuQrqV+dPBxsQ3SRyjPZ27zIh2YgijoWD8ToIZDXI=;
 b=3DpU/Zvl7nWsK5VgnMXicUbQgU82jqCTc8I0xf6vkcyTALp/TbELHcSEcvB4KaO92huukScOTieqeFRjC2V3mu1wq8vIScP3I7b5He2atyRYImhne0nmXGiiennuyyyHiqu6Kt8MibGOpywWPlKlBykqVFEBxk6iMF2B8Xf7LP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 06:23:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 06:23:59 +0000
Message-ID: <816b60b4-f75f-a53e-4712-a2bdc169c729@amd.com>
Date: Wed, 17 May 2023 01:23:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 0/3] Fix DCN 3.1.4 hangs on s2idle entry
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, "Lazar, Lijo"
 <lijo.lazar@amd.com>
References: <20230516233420.2087-1-mario.limonciello@amd.com>
 <89d0c8be-d118-1b02-0406-835557d712b1@amd.com>
 <55fbad92-010a-f7bd-6a90-ac105acb38eb@amd.com>
 <c4d8fe46-2a0e-9947-e96e-e30507725f9e@amd.com>
 <f073ef0d-0204-dc1e-0165-991866897eb8@amd.com>
 <80f4ad3f-d297-f97b-3647-4358ba2e687d@amd.com>
 <f95fda88-518d-f8a6-f8a8-3b8930cb7364@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <f95fda88-518d-f8a6-f8a8-3b8930cb7364@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:408:f8::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: d74526b4-b5dc-4134-b92e-08db569f4cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ClBccz2AVsc2SOyQYMmSUlhahOdtpeH4KZ5x3fgpZEG6p7XyoTeRuCR+1F3wRLpwmLpEpEsFlG+Wkq4LEI81fCyJ7eKp/ZNR+sh/WQhE5e62UJe0ZaO0cgsC2FETxoeegwa1nY3QmT+scD1kYEDAOvvvrhiJFB5VyuOMuesc70d/70juX2N+zKqx0Nz/GaWZr8ZUduVOz81ZRsG5FDpT/zLreHqufCA/XuaZaf55mceTJ6SOhx6I8pQNuPi3v0X3mhu5ccFWRnE0D5RU4TAKknLqP48tgXImZjJaLy7UFcFDMrlH1MV9gMGMo+tIPzimnhiDYcFVmUnJ6o1muYIW4VwyZ3NIt4qxQ1vsBgZutrcWdoLuKSGDwM+TXpzsVuKDAlimWrxc91jdf6ijzQKiw5F/4lrrRwjUHQJLumukasP8m5dWnYtHqH2tGeSjKirx+wb16S0cfJIznd9f6Ha0tb8wT1jFAswk8vXD9PFY+jPVaJ+7QwEqN6NFWBdf7/bE/R1j+ZxZZ7qNjuTUHlFiZVb6pX8qOfC8fb2/onMwEBzbP1dYKkkQCcRcGMlOcp3ytSrsa25a7Iv/0UqXTwqa+f3Ru8/IemgqMr6O12ZSyyNMt4n1ZtlKQjhVLcDqBd0TzlGIaDrCaNT+0onkb2fuVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(8936002)(5660300002)(83380400001)(186003)(26005)(6506007)(6512007)(31696002)(86362001)(2616005)(38100700002)(41300700001)(8676002)(6666004)(6486002)(316002)(66476007)(66556008)(66946007)(36756003)(4326008)(6636002)(478600001)(110136005)(2906002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0pDTDJPa3FxallLZnlzMnhGaDc4dVNRK0FHOHZhbGR4MitycktSditvNFNu?=
 =?utf-8?B?Qk8zUUtaSFZqSk1YL29vQ3hVUXpQNkpHOTFkWkkrVzdjdEFLS3h4WENqUnRk?=
 =?utf-8?B?VkhKNkFnQ0FWcUtmeHVKNDFEWVljdC9ZYkNNK2ZpMmFweGRZVStza3FtcVdT?=
 =?utf-8?B?elVyU3pJNkI3MnYzUStDQWxJWXVaLzFEWXVPWDd1cFlzU1hEMkVsSWV4QVJx?=
 =?utf-8?B?UUpHMC82blZFYTJOSVROSGNDQlNHTFphcVh5R3FFemU3SjhwaEhqWThTTGZF?=
 =?utf-8?B?RDVYZmNMWlJNSUJDM2FPMFZLdlYrWnljKzVyWVBNVG9sQ0dqWGx2bU9LeDN6?=
 =?utf-8?B?akpEMk5ET3o3bWhTNURkb3VONEpWaGJIQjNyeFpPczd5RnQ2cjVNTmVHY0RC?=
 =?utf-8?B?cW9DTWJmYitQeGxEaUh4WXEzcTA1UDQ4cmVqUkFQZ08weXJYMVdSMnpRd0Nu?=
 =?utf-8?B?RXVwbmdxeHllenVNbUZSY3hDM0VnMU9PZ3VlU21GZzdqYW8zQTJSS2VGOGRk?=
 =?utf-8?B?ZG1OWkdoc2doYSt4dUE3WVVnajdnL015U3BwRllPQzhXbTY1UFgyaDlpdG5m?=
 =?utf-8?B?bk0rbTgybGVPdmZxMy9jM0QrQ3VHK3RhRUhHU1hMRGtkRE0xSE1MWGJ3Ukla?=
 =?utf-8?B?NFFxNXZ6YzZWUEdXak9HSkJvZTlsb1FpYXozKzNQa0gyZ0ZBSzhHUWMxdThG?=
 =?utf-8?B?MmFSeGVEREFpOXkxTG5GQVoxV2Z5VVhXamRaeTR1MVc4b3RrdjhaOCtVRi9L?=
 =?utf-8?B?aTBrYzN6RnNwRGZsR0pweUQvOUs3U3QwVVd3V2VwWjhKcVJNVHRhK1EwNnNw?=
 =?utf-8?B?WStvNlZOWC9SU0g3bkc2a2tnU2RiYW9LMUFVaEd0QVRabHA4cTcveXl4Umxo?=
 =?utf-8?B?cHFpWlVBZEY5SGZHcjJPOWFXNEYxek10MUZIVUZ0R3lTdkpzSVpUY2pVYmpu?=
 =?utf-8?B?L0FCYmJaUTVxZXM3ZDVxMFBYU0MzQ01oNGJuTWY3bzlCaGhUajN2WmpyKzZS?=
 =?utf-8?B?blljR1F2cFlpSzcxd3ByejJmcWhSc1ZBR0FKL3hsRGk3Ukd0Vi9mMysyTWUv?=
 =?utf-8?B?a3lheEVEeUg4VDYzU3k4ajFVZEZiZmdrRHk2eURyWXZySWhoS2N1eXRpTG5K?=
 =?utf-8?B?K2NCbHlSR28zaC83aGFGd2QyLytqZlpSUHhBZkNESjgzcUxCRWZyRnJNV3Fr?=
 =?utf-8?B?WEpYTjM0b3hndTRIK2hQYkQvWmtwU0FIeEl1SWMrYy82OHpYR0UweFF4Z0M4?=
 =?utf-8?B?c0txT3luT0ZqZHlaa1ZFdWI0M3I0QXlTM1FXUXFQSzMvUTBva2ZXclBkVlpC?=
 =?utf-8?B?YXFRTGFITFZOWEVjVDFlaVljQU5aN0NzWnJ3N0l4Z1ZIMy9YbUx5ZkkxcVhQ?=
 =?utf-8?B?eDdkWDMvMVg2TkhhdzN3ZWNMV0wybzFmbUtoWUhsRFdzNEVuclpyREUzY1dY?=
 =?utf-8?B?TmkxMEpPd1pvWFgzMExXQkJ1dFpMaTlhd3hPNVhKMEx2RmozQmJNOHRFbUJS?=
 =?utf-8?B?cUMySGY2SHNIWTVGYUcwVUNMWDFLV2JsR09DRWtJTEFLcTgwNEkwMVd4WGVy?=
 =?utf-8?B?SmxwdmN1R0pDVXUwWjB3eEU3U091dTlBdjJ3ZUtERkpNSXNFTmdkZHF6UWUr?=
 =?utf-8?B?eWxZQzg1SXBrd1RlaHk3dmJtTFFJOGR4ZlpPT1lYUmQ5cVZnWmErUjlBVG5t?=
 =?utf-8?B?dHF5a2dxbEhuYmNTNmxmTHo1T3crREcwM2NhZmZDYks3VlRwK3laNjJYRmMz?=
 =?utf-8?B?ZHBZazlRNnBNZURCMjdiaWpnOVNuOGNjVS80QWVDSjJWM2g0QXB6NWxJc1Fl?=
 =?utf-8?B?RGE5Kzcvd3MwWHhnQ016Qnd3UmQ2T0xrNnREaUJ2NnpLb1VhV3phc3R0U2Vn?=
 =?utf-8?B?V1dYWGxjZld1V3hhZDJmYTlzRlM1SnEzTTdrU0dLOVFiUmVYUXJwaFltaE9S?=
 =?utf-8?B?d0hSZmc4OTFhbGc5WUpZd0FXY0F1S21mblNmS092UkJFNWhuRndlRVdZZTI0?=
 =?utf-8?B?RWE1UjNxZ281N0RwZU9GQWx2UldXWURNK2tEN1EzWENuMlpWc1F4M000S3V5?=
 =?utf-8?B?My9VMFNIRldTcEFhWkduQUJzUm9uaEhhMndpcDgvMHdHNjBjWkhJY3F3Sjlv?=
 =?utf-8?Q?SO7RCB4TvcsBZbd/JGz2Q8S1v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74526b4-b5dc-4134-b92e-08db569f4cbc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 06:23:59.2243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctXfC7J4u89HW/BCMWJGn7QkMNMiIX3D+ZwYON+MOSm9OZX56/oSRrt0yjhCmZhEC/51KbsO86WrHrJq8c194g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735
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
 amd-gfx@lists.freedesktop.org, Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


>> I think we replaced this with golden timestamp value which doesn't 
>> require GFX register access.
>
> Ah yes; through
>
> 5591a051b86b ("drm/amdgpu: refine get gpu clock counter method")
>
> This wasn't part of the kernel this was originally reported on.
>
> I suspect this would significantly decrease the likelihood of it 
> occurring. I'll confirm it.
> I do think that patches 1/2 still make sense though because gfxoff can 
> be triggered other ways too.
>
Confirmed that by adding:

5591a051b86b ("drm/amdgpu: refine get gpu clock counter method")
and
ea27ee2bea6b ("drm/amdgpu/gfx11: update gpu_clock_counter logic")
the original issue goes away.

I will still refine my patches and send a v3 up though as GFXOFF can be 
triggered other ways by userspace and we should avoid this bug.

@Alex:

Can you please queue up ea27ee2bea6b for this week's fixes and include 
the tags:

Cc: stable@vger.kernel.org # 6.1.y: 5591a051b86b: drm/amdgpu: refine get 
gpu clock counter method
Cc: stable@vger.kernel.org # 6.2.y: 5591a051b86b: drm/amdgpu: refine get 
gpu clock counter method
Cc: stable@vger.kernel.org # 6.3.y: 5591a051b86b: drm/amdgpu: refine get 
gpu clock counter method

>>  Here is the function calls with the patched kernel:
>>>
>>> [   32.720456] amdgpu 0000:c2:00.0: amdgpu: set GFX off state to 
>>> enabled, count:1
>>> [   32.720457] amdgpu 0000:c2:00.0: amdgpu: broke gfx_off_mutex for 
>>> gfx_v11_0_get_gpu_clock_counter+0xa8/0xf0 [amdgpu], 
>>> adev->gfx.gfx_off_state is 0
>>> [   32.760475] PM: suspend entry (s2idle)
>>> [   32.768996] Filesystems sync: 0.008 seconds
>>> [   32.769310] Freezing user space processes
>>> [   32.776527] Freezing user space processes completed (elapsed 
>>> 0.007 seconds)
>>> [   32.776530] OOM killer disabled.
>>> [   32.776531] Freezing remaining freezable tasks
>>> [   32.777528] Freezing remaining freezable tasks completed (elapsed 
>>> 0.000 seconds)
>>> [   32.777531] printk: Suspending console(s) (use no_console_suspend 
>>> to debug)
>>> [   32.817853] amdgpu 0000:c2:00.0: amdgpu: Delayed work to enable 
>>> gfxoff
>>> [   32.817857] amdgpu 0000:c2:00.0: amdgpu: 
>>> amdgpu_dpm_set_powergating_by_smu by 
>>> amdgpu_device_delay_enable_gfx_off.cold+0x29/0x46 [amdgpu]
>>> [   32.818142] amdgpu 0000:c2:00.0: amdgpu: broke pm.mutex for 
>>> amdgpu_device_delay_enable_gfx_off.cold+0x29/0x46 [amdgpu]
>>> [   32.852099] amdgpu 0000:c2:00.0: amdgpu: smu_suspend: suspend called
>>> [   32.852101] amdgpu 0000:c2:00.0: amdgpu: smu_disable_dpms: called
>>>
>>> Without patch 1 the delayed work doesn't get called on entry ever.
>>>
>>>> Can we remove this code also as there is a flush anyway with patch 1?
>>>
>>> Sure.  Do you think it should go into patch 1 or on it's own?
>>>
>>
>> Preferably in patch 1 itself as it explains why it was removed.
> OK.
>>
>>>> Also, is there a need to call GFXOFF forcefully on S0ix suspend 
>>>> (any chance that gfxoff is not scheduled)?
>>>>
>>> If using "echo mem | sudo tee /sys/power/state" I've confirmed that 
>>> it's already in GFXOFF.  I don't think this case should happen.
>>>>>> 2) RLC is never stopped on GFX 10 or greater.
>>>>>>
>>>>> System was hanging before this series.
>>>>>
>>>>> Patch 3 "alone" matches this behavior as described above to skip 
>>>>> RLC suspend but two problems happen:
>>>>>
>>>>> 1) GFXOFF workqueue doesn't get flushed and so driver's request 
>>>>> for GFXOFF can happen at wrong time.
>>>>>
>>>>> 2) If suspend entry happens before GFXOFF is really asserted lots 
>>>>> of errors on resume. IE:
>>>>>
>>>>
>>>> Is patch 3 really required?  Does it make any difference?
>>>>
>>> No; patch 3 isn't really required with patches 1 and 2.
>>>
>>
>> My preference is to drop patch 3 and not to have an additional place 
>> of in_s0ix check.
> OK.
>>
>> Thanks,
>> Lijo
>>
