Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAECAC982FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 15:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2119F10E725;
	Tue, 22 Sep 2026 15:44:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qTXdfcaw";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A890310ED7B
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 15:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6Zfn9MeUHUWVJmZPhD+pool7TVqiNFQumCvciTrQfOk7LY1OkXjmGQ/Gs1M42jVacelOgog/8NXZg19Rx05npo5zNg60AO++8kokoHxz9d24KfybeaWg4ZqNfeq7bhIhmkhtE/AchLOGE9MZ8ifS9DItBiYtGrsjo8Cs4udVHihISlPnzxQwJHqRpphQiDQRCkRfATa4MhgZJI87wJabBVnCQIeq16pHYS4Xfg/nncixqp9zEiRWxIqA2ExbHuDvSAtynbWeTDqybfHpqDl4viuLDt6xLGsrCYyN7Ns7/5FcsPrDc3Mru7+tZq50gXBw5JxcUtEump52nb7F+lQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDdViEjVhUsWE03qRF5czvT1tgWl3qaN4uewlvN1w/U=;
 b=GfsQ119mSmQgXeZpsmuuk5tHiJ+GLov+N8NvYHeoirt+lG/Za9GBKPzlS3K5p0s0VYUA0FfOI5I+zW0HE3YconY7J3jBhbQXDNSuTq8at/vRXKeI3BL5qWyB2pG+a1MnP+zFdaYEgu375HaUt7hRpJz6QCamULPEesjdVDz9I/R9dvswfalKegGegPHNCHr4pA2yBFMBrTJD+U+YERfeiSBptBkraEf7YUFFZx8ypeQ5LiGfVEwic+E/qXwnzd0B+JUx3yRnbtZkXvlaVl4FdHxDihr0vTiA+ifNn6OEjyPz0HAiosyUSBr9zatF4sxwoY05GWhgMCABe5x/Cc7DBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDdViEjVhUsWE03qRF5czvT1tgWl3qaN4uewlvN1w/U=;
 b=qTXdfcawmrq7vTwm+NAvaL4+F8lBmqLTQWft5WKhubFh+FEsTJTE9nd+okZRNmyG1225WScl+Rw5uAN40QvDXsfyY8/r+hyR1DLl+qdeXDvTnVqz0560wuazeQXkpBcnfKziDphnjS/CYSwf1RW5Ype3l7P9r0CdebkarFT9K3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 15:43:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 15:43:59 +0000
Message-ID: <678a85fe-e544-4ce9-a19e-b9d71f250750@amd.com>
Date: Tue, 22 Sep 2026 17:43:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/amdgpu: add profiler UAPI definitions
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Bing.Ma@amd.com, James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 Natalie Vock <nat@pixelcluster.dev>
References: <20260921200313.865829-1-James.Zhu@amd.com>
 <_Vw-t4UsQJK0Ic5kimqXtw@gmail.com>
 <d955f3a3-2f90-4e6a-bc9f-579df06e6402@amd.com>
 <E26TqGhRRCmT_3vybr_f2w@gmail.com>
 <CADnq5_MhUmRZeDKCVHPvq8z=UbJv3MEJZAOzBXjz5cFm46v_Zw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_MhUmRZeDKCVHPvq8z=UbJv3MEJZAOzBXjz5cFm46v_Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: dc57ff31-d656-4134-3cdc-08df18c05131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: ImFaQuP0DgxJB5h9jDB5xNKZQ4OwFufmjbDF5+zEXFS73zsXK+GuvGN/m01aeh7j+7tyWKHo51SKa7oo76h1o3PaIwraDl2m1ywGEKzr4wdum8wxxYQevv+F9pz5TuUUHA6gj+vM2g/qbgtJ/WtuNarH0vgVVEnIj5nLFzmSIH8z2t9yY2dFEYbKO7hreiOQuATIHfBPlluscMZJy6KW8xEXRKau24OqG4Z+WFf+5rjvjrEhJHgo6DmeMu+J8WoGowqs2wuFNWKYIKS575VROviK7Ox1u+zyQbd7ByFkGVYfwV33RYIEgFDxuDn8MfE3VpFF+bhBMugLX8cT4oVqk3PXmxL72Wa4g9/0Z8gm48xt5enkP/ArDCMsWMEtnrItqgacol9z/lRN9OBIWrpX2G60dHhiLtF9zmXXD4NY0I0K5hODx/CurB3FCJJeO4EJwJg16+6sXSEGeMfr0f4wShHOKEkAmImjSSCFIhaYeOe2o0qocJ7nRTPSn/G36jtVA419V/rN8xsTfUoYISIx+GELiOkNlHnlpvpDlqDK3cUqf7R+LOuVH9mntVxIJ7SUDWqaxvzM+Ht2E89qEUVRjXZoCBwiesvApdvnZ0WD6DG1NWOjdZVcP8eGaSXoISgZpaXF+Q1X6NqADTI9GFXNM+risz8X5xDd38/WGbDnY4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXhGR3pDYmpodEVYQTExcHNRQVg5N2t1Q1BjWlF1bmpwSC8vSTBkSHplb3JH?=
 =?utf-8?B?MFE2RGJVSW5zdWxyd2pzWlRJc0F1TWVGWTc0RzdobXFCVkt2a1pSeVFTY1Jm?=
 =?utf-8?B?OGpzNTB0ejdpVng1QWJ3c090WXJ3ZU1JR1lzWFZEaWZPTUJaNFp6dzBrVDNI?=
 =?utf-8?B?d3gyVDA3cFhrL0ZVTFdPaDFxNUIyUHdCYnF0ZFE0ZG1TbU9WQVB6ZHRLR0Fk?=
 =?utf-8?B?bm0xODdZWTR3MnIyNHYyS3hHV1dRalhOQXA1ck03anhKSm1qWU9wVmFCd0h2?=
 =?utf-8?B?Wis4dml5bDJFR2NzNmM3N0RXR3FQNmhZOTJ1MHpZVzRqMnROUmFLQm80d0V3?=
 =?utf-8?B?NFA2dkgzVXJUV2NBbVpPbUdJYms5Z2FBa25XWGFER042UEZOR0VqZHBvKzhN?=
 =?utf-8?B?V1FRYnE1djY2MHV5T1loTWw3SWdUdmUwaWlUUEJXQkRRaGRWUk42dmIyb0hG?=
 =?utf-8?B?dkZTQW8rTTEwVE5KcHQ2SkhjZjZHRE4wWjhka3NYdFlXK0JvcThuS0ZNY0p2?=
 =?utf-8?B?WUg1Z0tnVzQ4dldvOTFIaHBtbmtQR2tuMFNlU1NVYmYrMWdRckF5NGp6ZFlE?=
 =?utf-8?B?L0pkRHZ5TmE3SXd1QlhTeXZUdzl3Y0RmM25jcTkvYWxrdVA0TGNGcHZXaHVh?=
 =?utf-8?B?RTc3dVRvZERYdHM2dSswYVo0cGlWVXdMNjkrOVhNVkRsaUxncDdYVHQ2QmxU?=
 =?utf-8?B?ZUdOM0M4ajhXK2tkeVlpeVI2VlMyUXBjQTc1TXYzUmtkYnQ2bjFYWUYzWDdZ?=
 =?utf-8?B?VStsZzNXbTNFWFRvM2tVTEY0U3U3eVFvNGJ2cjVuTEVlTnpZeHdReDVRZ1ky?=
 =?utf-8?B?WnJYTkQ0Z05yaHczbkpmM2pBVWZ6R2YxazhLQmVuK3BTZzl4NnpKUTVqRlRH?=
 =?utf-8?B?UkpJNnR4bDhKRktkY1lnZk1KNTRhRElOY1VoRXdhbnNPb3ZodDdPSzNsNWJy?=
 =?utf-8?B?emRaa2ZoaVMvRHJ4NWhtUHl0WDAxb2lBcmRtRWFMZ2ZqZGp0dVM3RVhNQWVC?=
 =?utf-8?B?UVpoUVh1VDRSL2pXYzRkZkdlL2tHOWFiYVNkUUlKcXFaY0ZZNGRFWE5TWUth?=
 =?utf-8?B?NnFMWFQ1dzhQSWZDTFQ3N0FXNTFzcWtVTFpyYUJ3YU9mM0Rjc0Frd21tTnZ4?=
 =?utf-8?B?a2NIYTNudEI1dFNKbWtUMTM4T3RLM2ErQ1Fsc29rTzlhWVVLanJjYUdzb0dG?=
 =?utf-8?B?WjdlNmtDT1pTTkhDZVFrU1ZxbGZvZ3dhSitsR1ViMlhKR1pBcEVYMndNcGtQ?=
 =?utf-8?B?NmZiMmJpS01vR1pTSjN3aFBoNCtaUEljVlhSRUJNTVJVMEUxUGRzbWJpUmxq?=
 =?utf-8?B?RksrYndOeEN5eFRJb1RQaDhCcWIrd2E4bW5RNFhtMVFQZ2VmckpraGhhS0NK?=
 =?utf-8?B?U2FTcVB3MDZoalI0eENtbmxZbVhZR1NVNXpKTmJPc2FVa2VUMjN3YjJYOThx?=
 =?utf-8?B?NE9WRXBGRjRYMFBVNDJzOHhHUjBIZWlXR2ViUmJYT3ZBVUROUHZ2aTQxbnpk?=
 =?utf-8?B?RCsyeVo4VjZXbFczU3JsLzEydkoyTkdUazlVbDg5Qkh3UWFLNTBkQ2x2c0s3?=
 =?utf-8?B?alR3TWp2MHpCU0RLQm1hN1BRbU9sbnoraHV5RlFaelh6dWNtOEdYMDczNmR4?=
 =?utf-8?B?RjhYc2p5bE1QU080M1FmcUx4N25CUGtLUVNNU3MwRmpGaFphZDg0K2UyR1Vw?=
 =?utf-8?B?L3p0QkVqckw1Snh2UlVuY3ZtQ3FOQUNybFd5a3Y0YlgvVHorSzA0ZmNNK1J5?=
 =?utf-8?B?am1EZDVwNEZmenpzZTE0NHp5N2ZNQ2UrUEN5WExTb2d6ZER1cm5FUm5IZDdo?=
 =?utf-8?B?RE5RNmpnYS9Sa2RtMnM3K2VZNEtXL1htVlVBcTRUVGNzMlN5N05qU1RscmhZ?=
 =?utf-8?B?cmVzem9sdXpuRFlIbmVpV3NMamlTUTZ1YmtIRHZWbWUrK3ZGbGVha3ZzNGNh?=
 =?utf-8?B?THJUN0YvL3Jzc1dhOWhFNkxqcVNSQkRObHF3TDVzSklNRmVVb0sralRKaU9v?=
 =?utf-8?B?bERkMGdNZGFBbFgwRjJZUlRsekMyVjl0STVFQUtUMDJoRzdUOTRQOEs3bEhR?=
 =?utf-8?B?Q1hpZU1BV1ZmWHFYUXhIQVp1dlJPQjUwWWFRTmRWOVM3VkkremVMMWgwRkFL?=
 =?utf-8?B?Y25TT01PRHZHek5SYTZHaDNENTE5OUZwRTBFb1dYZHFQUEhkTlAzaE1lbGN5?=
 =?utf-8?B?WHhuMXRvRDh5NExxVlVvVCtzREdNZ2lwTzdLOFBYVkR2Q0xNczQvNEJMR29m?=
 =?utf-8?B?Z3RscFFWNDNNUkJmdHAzaDJtVWRKbnNvSDhJWjNpQ292T0lmNkdyTlhubmY1?=
 =?utf-8?Q?6JUdOugWzSctpXytJT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc57ff31-d656-4134-3cdc-08df18c05131
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 15:43:58.8022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEEVdYNLvjL1tcZb2b3twYd6dFHOJC3w8Osy1SupsQIZA/KZAsGAK8MyXf+GfzkV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554
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



On 9/22/26 17:40, Alex Deucher wrote:
> On Tue, Sep 22, 2026 at 11:22 AM Timur Kristóf <timur.kristof@gmail.com> wrote:
>>
>> On Tuesday, September 22, 2026 5:20:41 PM Central European Summer Time James
>> Zhu wrote:
>>> On 2026-09-22 11:09, Timur Kristóf wrote:
>>>> On Monday, September 21, 2026 10:03:02 PM Central European Summer Time
>>>> James>
>>>> Zhu wrote:
>>>>> Add the DRM_AMDGPU_PROFILER ioctl number and its argument structures, the
>>>>> UAPI for GPU performance monitoring features such as SPM (Stream
>>>>> Performance Monitor).
>>>>>
>>>>> struct drm_amdgpu_profiler_args carries an operation selector and a union
>>>>> of per-operation parameters, currently AMDGPU_PROFILER_OP_GET_VER and
>>>>> AMDGPU_PROFILER_OP_SPM. The SPM operations and the layout of the
>>>>> destination buffer are described by struct drm_amdgpu_spm_args and
>>>>> struct drm_amdgpu_spm_buffer_header.
>>>>>
>>>>> The ioctl number and struct layout are frozen here. The implementation
>>>>> lands in the rest of this series and the ioctl is not registered in
>>>>> amdgpu_ioctls_kms[] until then, so this header change alone does not make
>>>>> the interface reachable.
>>>>>
>>>>> Signed-off-by: James Zhu<James.Zhu@amd.com>
>>>>> Reviewed-by: Bing Ma<bing.ma@amd.com>
>>>>
>>>> Hi,
>>>>
>>>> Can you guys please clarify why this is necessary and what the use case
>>>> is?
>>>>
>>>> Are we sure we want a uAPI for this? RADV has been using SPM from
>>>> userspace
>>>> for many years now.
>>>
>>> [JZ] current RADV SPM is for graphic engine. These patches are for
>>> compute engine SPM.
>>>
>>> Thanks!
>>
>> Is there any reason why it can't be done in userspace for compute too?
> 
> There's only one SPM so there needs to be arbitration to avoid
> multiple applications trying to use it at the same time.  It also only
> works on a single vmid at a time so the application using it has to
> request a fixed vmid.

Yeah, we already have an API for reserving a VMID for SPM.

We also have a TODO item to make that available for user queues which then both ROCm and gfx can use.

So as far as I can see that work here is completely unnecessary.

Christian.

> 
> Alex
> 
>>
>>
>>>>
>>>>> ---
>>>>>
>>>>>   include/uapi/drm/amdgpu_drm.h | 124 ++++++++++++++++++++++++++++++++++
>>>>>   1 file changed, 124 insertions(+)
>>>>>
>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h
>>>>> b/include/uapi/drm/amdgpu_drm.h
>>>>> index 9e5fa6f53e59..285949d63eb6 100644
>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>> @@ -60,6 +60,7 @@ extern "C" {
>>>>>
>>>>>   #define DRM_AMDGPU_GEM_LIST_HANDLES      0x19
>>>>>   #define DRM_AMDGPU_PROC_OPTIONS          0x1A
>>>>>   #define DRM_AMDGPU_TRAP                  0x1B
>>>>>
>>>>> +#define DRM_AMDGPU_PROFILER               0x1C
>>>>>
>>>>>   #define DRM_IOCTL_AMDGPU_GEM_CREATE      DRM_IOWR(DRM_COMMAND_BASE +
>>>>>
>>>>> DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create) #define
>>>>> DRM_IOCTL_AMDGPU_GEM_MMAP  DRM_IOWR(DRM_COMMAND_BASE +
>>>>> DRM_AMDGPU_GEM_MMAP,
>>>>> union drm_amdgpu_gem_mmap) @@ -83,6 +84,7 @@ extern "C" {
>>>>>
>>>>>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE +
>>>>>
>>>>> DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles) #define
>>>>> DRM_IOCTL_AMDGPU_PROC_OPTIONS      DRM_IOWR(DRM_COMMAND_BASE +
>>>>> DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options) #define
>>>>> DRM_IOCTL_AMDGPU_TRAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_TRAP,
>>>>
>>>> union
>>>>
>>>>> drm_amdgpu_trap) +#define
>>>>> DRM_IOCTL_AMDGPU_PROFILER  DRM_IOWR(DRM_COMMAND_BASE +
>>>>
>>>> DRM_AMDGPU_PROFILER,
>>>>
>>>>> struct drm_amdgpu_profiler_args)
>>>>>
>>>>>   /**
>>>>>
>>>>>    * DOC: memory domains
>>>>>
>>>>> @@ -1821,6 +1823,128 @@ struct drm_amdgpu_proc_options {
>>>>>
>>>>>    } kfd_sigbus_delay;
>>>>>
>>>>>   };
>>>>>
>>>>> +/*
>>>>> + * Supported SPM (Stream Performance Monitor) Operations
>>>>> + */
>>>>> +/**
>>>>> + * drm_amdgpu_spm_op - SPM ioctl operations
>>>>> + */
>>>>> +enum drm_amdgpu_spm_op {
>>>>> +  AMDGPU_SPM_OP_ACQUIRE = 1,
>>>>> +  AMDGPU_SPM_OP_RELEASE,
>>>>> +  AMDGPU_SPM_OP_SET_DEST_BUF
>>>>> +};
>>>>> +
>>>>> +/**
>>>>> + * drm_amdgpu_spm_args - Arguments for SPM ioctl
>>>>> + *
>>>>> + * @dest_buf: [in] used for the address of the destination buffer
>>>>> + *            in @AMDGPU_SPM_OP_SET_DEST_BUF
>>>>> + * @buf_size: [in] size of the destination buffer
>>>>> + * @op: [in] specifies the operation to perform
>>>>> + * @timeout: [in/out] timeout in milliseconds (in), amount of time left
>>>>> + *           in the timeout window (out)
>>>>> + * @bytes_copied: [out] total amount of data that was copied to the
>>>>> previous dest_buf + * @has_data_loss: [out] non-zero if data was lost
>>>>> (e.g.
>>>>> due to ring buffer overflow), + *                 zero otherwise
>>>>> + * @reserved: must be zero for forward compatibility
>>>>> + *
>>>>> + * This ioctl performs different functions depending on the @op
>>>>> parameter.
>>>>> + *
>>>>> + * AMDGPU_SPM_OP_ACQUIRE
>>>>> + * ------------------------
>>>>> + *
>>>>> + * Acquires exclusive access of SPM on the specified XCP for the calling
>>>>> process. + * This must be called before using AMDGPU_SPM_OP_SET_DEST_BUF.
>>>>> + *
>>>>> + * AMDGPU_SPM_OP_RELEASE
>>>>> + * ------------------------
>>>>> + *
>>>>> + * Releases exclusive access of SPM on the specified XCP for the calling
>>>>> process, + * which allows another process to acquire it in the future.
>>>>> + *
>>>>> + * AMDGPU_SPM_OP_SET_DEST_BUF
>>>>> + * -----------------------------
>>>>> + *
>>>>> + * If @dest_buf is NULL, the destination buffer address is unset and
>>>>> copying of counters + * is stopped.
>>>>> + *
>>>>> + * If @dest_buf is not NULL, it specifies the pointer to a new
>>>>> destination
>>>>> buffer. + * @buf_size specifies the size of the buffer.
>>>>> + *
>>>>> + * If @timeout is non-0, the call will wait for up to @timeout ms for
>>>>> the
>>>>> previous + * buffer to be filled. If the previous buffer is filled before
>>>>> the timeout, @timeout + * is updated with the time remaining. If the
>>>>> timeout is exceeded, the function + * copies any partial data available
>>>>> into the previous user buffer and returns success. + * The amount of
>>>>> valid
>>>>> data in the previous user buffer is indicated by @bytes_copied. + *
>>>>> + * If @timeout is 0, the function immediately replaces the previous
>>>>> destination buffer + * without waiting for the previous buffer to be
>>>>> filled. That means the previous buffer + * may only be partially filled,
>>>>> and @bytes_copied will indicate how much data has been + * copied to it.
>>>>> + *
>>>>> + * If data was lost, e.g. due to a ring buffer overflow, @has_data_loss
>>>>> will be non-0. + *
>>>>> + * Returns negative error code on failure, 0 on success.
>>>>> + */
>>>>> +struct drm_amdgpu_spm_args {
>>>>> +  __u64 dest_buf;
>>>>> +  __u32 buf_size;
>>>>> +  __u32 op;
>>>>> +  __u32 timeout;
>>>>> +  __u32 bytes_copied;
>>>>> +  __u32 has_data_loss;
>>>>> +  __u32 reserved[9];      /* must be zero; pads this struct to 64
>>>>
>>>> bytes */
>>>>
>>>>> +};
>>>>> +
>>>>> +/**
>>>>> + * drm_amdgpu_spm_buffer_header - SPM Buffer header for
>>>>> drm_amdgpu_spm_args->dest_buf + *
>>>>> + * @version:       [out] SPM version (0-23: minor, 24-31: major)
>>>>> + * @bytes_copied:  [out] Amount of data copied for this sub-block
>>>>> + * @has_data_loss: [out] Boolean indicating whether data was lost for
>>>>> this
>>>>> sub-block + *                       (e.g. due to a ring-buffer overflow)
>>>>> + * @reserved:      Reserved for future use, must be zero
>>>>> + *
>>>>> + * This header precedes the SPM data in the destination buffer. The
>>>>> reserved + * field maintains 64-byte cache line alignment (32 bytes
>>>>> total).
>>>>> + */
>>>>> +struct drm_amdgpu_spm_buffer_header {
>>>>> +  __u32 version; /* 0-23: minor, 24-31: major */
>>>>> +  __u32 bytes_copied;
>>>>> +  __u32 has_data_loss;
>>>>> +  __u32 reserved[5]; /* pad to 32 bytes (64-byte cache line / 2) */
>>>>> +};
>>>>> +
>>>>> +/* Supported Profiler Operation */
>>>>> +#define AMDGPU_PROFILER_OP_GET_VER                1 /* get profiler UAPI
>>>>
>>>> version */
>>>>
>>>>> +#define AMDGPU_PROFILER_OP_SPM                    2
>>>>> +
>>>>> +/*
>>>>> + * Profiler IOCTL
>>>>> + */
>>>>> +/**
>>>>> + * struct drm_amdgpu_profiler_args - Profiler IOCTL arguments
>>>>> + * @op: Operation to perform (AMDGPU_PROFILER_OP_*)
>>>>> + * @pad: Must be zero for input validation
>>>>> + * @data: Operation-specific parameters (union)
>>>>> + *
>>>>> + * GET_VER operation:
>>>>> + * Returns the profiler UAPI version in @data.version as (MAJOR<<24) |
>>>>> MINOR. + * Input: @data must be zero (reserved for forward
>>>>> compatibility).
>>>>> + *
>>>>> + * Design note: GET_VER is intentionally a parameter-free query
>>>>> returning
>>>>> + * the global profiler UAPI version.
>>>>> + */
>>>>> +struct drm_amdgpu_profiler_args {
>>>>> +  __u32 op;                               /*
>>>>
>>>> AMDGPU_PROFILER_OP_* */
>>>>
>>>>> +  __u32 pad;                              /* must be zero */
>>>>> +  union {
>>>>> +          __u32 version;          /* GET_VER: out
>>>>
>>>> (MAJOR<<24) | MINOR */
>>>>
>>>>> +          struct drm_amdgpu_spm_args spm;
>>>>> +  } data;
>>>>> +};
>>>>> +
>>>>>
>>>>>   #if defined(__cplusplus)
>>>>>   }
>>>>>   #endif
>>
>>
>>
>>

