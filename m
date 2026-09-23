Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E002DC982FA
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 07:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5490910E821;
	Wed, 23 Sep 2026 07:47:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ghl4KypR";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013021.outbound.protection.outlook.com
 [40.93.196.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A102C10E821
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 07:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4fQUOZV86gE2CHaK4hOwGUbXTsLXhLAOiUcxTdJxdO2Q+vhN8brfuI3LS3OGzzzJg0xDh41C2flJTZPlC8NPp+TQUZg1DgMwmoMCyRYEk/ZeVjAN4QN89AiTx3aU6j86vkdqq5VQA1bc30LIk/lBPMWawLossUxCKUt/WxfCIof/OQAbbuaF9BZRoCBITHKyN5cvAMV6e2wQ7pVIc+0o53OadAwQx3/DW1X/wMUX15op2TL/Z+1XRYV05AqZLE08hX3XwSlvBuGQgRi3reEkRd9rFA7QFtucshgK5DEHhaBSuWPPo05wKQryYr45aAOQi1HnI0z6OURFGPPUIzB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PscugomuiENdknB3uisrYrv9ugVZZmUzQeYBQnBSoTw=;
 b=NauAwxlYZJ7zblWdhEw9IOiFYOgudulkuLp6Xwe1+Y0scnyNJI7BzzjJt5a/Pph+BGa0s7fQwPZt66Hi10ggL0CXtXDD8bUQSUUDqTl3QGz3rETWrqMuP7TNfbHT/dGnRwaYkG5lso4OXPWQfEaeI1Zf9kwpGKpbbel6lzdyxuBFmCXvCUt+w58b2MeuxLDhDudBGdYJm2s5HOQ0luUJD8bzjN4cw+9+WmsDsrSW56ZJsSkw8Sf4QQqu5iONCELshm2n79tEm3wT5nrUSKFrUSOQvVfAvrLrDtt2fo4WkFWMBMZxWE034FwybeGGcj+GiDTdcokC3hPUF22/83DXng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PscugomuiENdknB3uisrYrv9ugVZZmUzQeYBQnBSoTw=;
 b=ghl4KypRCgaIJ416/R2NNVxa6kv0Sau7sxvTDB7qgFUQdh+RJxiQ9AYOJ4+enYF8WQ+bHYsq/2H1Nt1RnzxoV7ak1uv3MQW+HU5a9xiE0qgy85MzRkBDgfk0NQl1ADmnxUlGDNWsTu6BNFHPTvPD/zjnBKMYFMlXzuPkXLWniGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 07:47:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 07:47:39 +0000
Message-ID: <7b860b82-aab1-4cc5-ba20-8e4bd3a3a646@amd.com>
Date: Wed, 23 Sep 2026 09:47:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/amdgpu: add profiler UAPI definitions
To: "Ma, Bing" <Bing.Ma@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhu, James" <James.Zhu@amd.com>, Natalie Vock <nat@pixelcluster.dev>
References: <20260921200313.865829-1-James.Zhu@amd.com>
 <_Vw-t4UsQJK0Ic5kimqXtw@gmail.com>
 <d955f3a3-2f90-4e6a-bc9f-579df06e6402@amd.com>
 <E26TqGhRRCmT_3vybr_f2w@gmail.com>
 <CADnq5_MhUmRZeDKCVHPvq8z=UbJv3MEJZAOzBXjz5cFm46v_Zw@mail.gmail.com>
 <678a85fe-e544-4ce9-a19e-b9d71f250750@amd.com>
 <BY5PR12MB4179CBF382C5DA57975FB8BFFD822@BY5PR12MB4179.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <BY5PR12MB4179CBF382C5DA57975FB8BFFD822@BY5PR12MB4179.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 847e6143-5d8b-4b4b-c5bc-08df1946f0f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|11063799006|4143699003|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yzNZvBU6Q/wElCVOyPB8Kz5g+5N0DieZ2qsPkBw/0mwpht0DoJhiCNGaeYmcaG/nkS6mpjR0RLa1v04IrNC5o14bvDQK2q27ScjZ6VKBWPVwblT5Yx5tqHTXxJZ5YHmNSczXYsp07K2DeAaqKzjAYV/aecheMpcwy62E7reg/rRdu6mxkB2XwYIjcM/OpaolZJUDBWKDOpZruhyN4v7kkMIErU1tlS0H8zaQt8xH6bvTStGVUyoAE3xGaTlkMsHToXEsBnsSll0nFsJ1FSL7y2v+B7198EokwFhQoO16oDVxOqVMHwI/pcG6yykDjl+r2DAwN/ah3t4SVjlVASw+xYv3qdumBRFWg8FA8ZzVJY77fu3qZ0A+Zkexwb/sXT0VedEsfp/qWpy783YibglAOcFFJBsFLjPNyIyvJdEIqcSr4GiuM3oYbN52G2zSiMRtQjlRjSH9SN3AH9JgYCU9WpPaWNNwFBEISK6kTSPWprZOWJSMcI5atem8NL1TLpVe9Km250fS27voeiDxtFncK1BBTkEkAASShnxR2W+j3iDUMY6SRjyMY5g7BylkxmqvvYMh4NY7Ln2pU0BzqLTeacAae9vXloGi1K8E7MmYNdnfH2hR8TMkXxZ8IQkWgFg8e9m7sKrKnXX70BZePbLUU1TitqqSXPSQrXwj2sjuT/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGJrUU1sR3dXYVhncmpZejRRbjJYOHAyMkNOQnptRlNzQXAyTHdPZFBzcS8z?=
 =?utf-8?B?Y3R4NlZSdlRFaE5wOFFJS3hobEU2bmt4cFZiYW1wQjFudDh0WmhCU01EKzNa?=
 =?utf-8?B?Nm44MmJsdTkwWTFpS0c4ZUhOZmFFdzJkS3FLSEpLRlg3U0pKYitlN0czVjhm?=
 =?utf-8?B?b0xrRUtkYUkwSlhaRnRqZ1JheFNhTDJiVkVNbEhYbTZDMDZCLzNVTkJJT0dy?=
 =?utf-8?B?bEIvaUcxQjU1dnVkcjBMalpIVTZWNUV6REptMmNsTzV0bW5mWFZKNUJnZHRy?=
 =?utf-8?B?MlBXMXJjQWI4WkltVDZ2bDQvMjU1TWNSQXpoMnQxQ2tNWjlUNEtmU2VwcGdr?=
 =?utf-8?B?T0dpbDRVZVZZUDc4cjV6MncxTVJLa2FHd085RHpzTjNwRUh2MkdXckpucDZI?=
 =?utf-8?B?cHhhNndNd3k4dUk1TWRFY2JzeE9jUkc1R3dTQUg0TU5TTm9NZEU1TmRXQUNo?=
 =?utf-8?B?UEJtMzBGOU5VaW11SDZ5Q2hGSUdDcWg1L2xlZXBYeXpkamlRQ1BDVTFZcm5N?=
 =?utf-8?B?NVBKNlFWd0MrTUYyU1FxdCtwSSswV1k0ZWl0eFVCdjhRZE15UHhadWZJNGN6?=
 =?utf-8?B?ZnMxcDd6QjRmVWlNRjBya3RmYVQzMWdrN3lSYWJ3YVNpWGJzZFNQQ05hWEdQ?=
 =?utf-8?B?akVKZFNYdzRxSnd2MzdUVkhTL1kzbWtMcFNiZWpyTDMwaXdnQ0lrQlRjMEtS?=
 =?utf-8?B?cWpwa1FFMGZtY2lQQzlTdTNpekp6L1FFd3h4T0VHWTh0OHVEL0NnTVBoczds?=
 =?utf-8?B?ay9EVW43Z1htbzI1NkRQMGViMDhmdVdTTHliNkFEZk1KaUhTNlpyVzl1ZkZ3?=
 =?utf-8?B?TkVUTHdORlNRQVdzdVpLU3M4MVk2Y0VuSlZscFdtRE91TVZFaU5XOHJ4RkdE?=
 =?utf-8?B?Z0E5d2p3MCs0VXZrM3BmeTR2a3pXQ1BPanhEaC90TXpId1RJWlBYLytUUnRi?=
 =?utf-8?B?WkU3NXJFWTlPN2V5YlJSamhwUGlnNEhDbDAveEZzNTJCODZnQnQzZmUzb2R6?=
 =?utf-8?B?MS9KZ2VUK1FLY29SWnhSYmw4TlhWMmJDb2tmY2FSczJ6MFRHSDhlSXd0Y29W?=
 =?utf-8?B?SWU4TEtGZzJXaFBTRElEb1drbG9QV2YxZnUvaHd4Um1BSC9iRzRCSEF4S3Vz?=
 =?utf-8?B?ak5hc3JMeHlwMzBZVWJva1lyVHp6RGVObEYxYVpXRGh2UXlLTDMzbFd2bEM1?=
 =?utf-8?B?SU1QcStMSm5JMGFiaW5URm5nbGtMUmVSRkd1MVVKdU50ZnBDZEZyNVBzdGJR?=
 =?utf-8?B?U3M1K29xZUZXMGhQOE93MW83VjIwdnNaQkljd3VaQURSdTZxRXBaQUw4d2lI?=
 =?utf-8?B?REd4cjZCckQ1RnU1UWp5am9Sb1c4ZS9ITGgwSTREampLNW9YYWttZU5qSDY1?=
 =?utf-8?B?bUMwRnVnUlZET2xVdGI1Sis3M1ZrSExocDNmdE5zaFJSYk5Bd2d5bHQrcjNi?=
 =?utf-8?B?N1hhWjdrRno0RWJoMEtjS1QrWjRrM1hrTXozZE0yeTJ4aTg4d3BDSUJROE1D?=
 =?utf-8?B?djVMQThxUUZoOG1vYmttQnJhR3VMb2VuR2Yyb2Q2UHhpRXFneFFCRTFUdjRS?=
 =?utf-8?B?WEFRL3dBMENFTkVFenpRaEJDTVJRd0pRalRmVmpBdUNHUTc2d3B5dmwrUkto?=
 =?utf-8?B?cFN3WmttQWZseWJNYVNTdXFhalExTGNTb3B3M3haTFJhQnlDSWkweTM5M1Fk?=
 =?utf-8?B?azlIUGlrNWdzZkVqa1YxMHVENHg5cFVHWWZnWHNrclhXZ3RCT2Z2ZWlpMkdV?=
 =?utf-8?B?RDRQUWNxWVBXUE5CR25ybno1Sm9HMkg0d1BVeW1QdExQbU5NaTlmU1A0MlZR?=
 =?utf-8?B?cW1yY3BPSE9qUk8zZDdENHhBbDRrV0pwR2VBNUdCczBpbXBtNWdMRU8renNG?=
 =?utf-8?B?S1JQa3NQRXl4SGppQUg3cTRjUlgwNlQrVzZsUlJvK1hmMmdhQURwamRLTlR2?=
 =?utf-8?B?d2xlY3h4SGRFQVB2cGFlZlRMRWxZSUxnZUpFbkh3VXovSFdWS0NvUFA1MFM0?=
 =?utf-8?B?UU4zZE03K1Qza2hVUEJpRzd6c2IvdzE3R3B3a2h4dVRHR2l0M0pUU2RiMnQr?=
 =?utf-8?B?UEozUFpNSEwxdzNJUUNRaEpKNk0ycEVDM2k4cmZLSlpLUE4zU05pTkdtMitV?=
 =?utf-8?B?b0kzbDhkcU5ieisycVNGd3pZRjhydDhFOHlmRFYxOWZIWHZXa3B0bldYV3dL?=
 =?utf-8?B?MHFKb1ZucmZFYmZXdzlneW1vYWpKZHlDay93bGZvbWNPWXRBU1dFR3pPM0V6?=
 =?utf-8?B?MGZaQ1ZKM29pRytZZUl3amJBU29KTUk4S3hEWXBQeHJ1VkQvWWxTL3NvWE11?=
 =?utf-8?Q?fG+5PLCZLOhe65CEom?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847e6143-5d8b-4b4b-c5bc-08df1946f0f2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:47:39.1944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbDgcIZwiOesRkubjuC7Ue+JNArcVU6CDcqG6Qqd3etrA4u6A3JcF0MQFVcGO/WE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683
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

Hi Bing,

that won't work like this. The MES integration is part of the upcomming KFD/KGD unification.

That will probably take a coulple of month if not years to be completed.

Since this here is clearly breaking the already existing SPM support for Graphics I have to fundamentally reject the ROCm SPM approach.

I'm not sure why the ROCm SPM patches were developed in the first place, with the approach taking in that patches here that feature is clearly not going to fly.

I will sync up with Jenny and Alex on this.

Regards,
Christian.

On 9/23/26 03:20, Ma, Bing wrote:
> AMD General
> 
> Hi Christian,
> 
> Could you share a link to this TODO item?
> 
> I'd like to verify whether this has been addressed through MES. ROCm uses the user-mode queue, and its VMID is assigned by MES rather than by the kernel driver. If MES support is available, ROCm could move SPM support to user mode.
> 
> If this TODO has indeed been resolved through MES, we'll review the timeline for that MES support. Currently, ROCm SPM still goes through the kernel driver path, and we will need to keep using that path until the required MES support becomes available.
> 
> Best,
> 
> Bing
> 
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Tuesday, September 22, 2026 8:44 AM
> To: Alex Deucher <alexdeucher@gmail.com>; Timur Kristóf <timur.kristof@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Bing <Bing.Ma@amd.com>; Zhu, James <James.Zhu@amd.com>; Zhu, James <James.Zhu@amd.com>; Natalie Vock <nat@pixelcluster.dev>
> Subject: Re: [PATCH 01/12] drm/amdgpu: add profiler UAPI definitions
> 
> 
> 
> On 9/22/26 17:40, Alex Deucher wrote:
>> On Tue, Sep 22, 2026 at 11:22 AM Timur Kristóf <timur.kristof@gmail.com> wrote:
>>>
>>> On Tuesday, September 22, 2026 5:20:41 PM Central European Summer
>>> Time James Zhu wrote:
>>>> On 2026-09-22 11:09, Timur Kristóf wrote:
>>>>> On Monday, September 21, 2026 10:03:02 PM Central European Summer
>>>>> Time
>>>>> James>
>>>>> Zhu wrote:
>>>>>> Add the DRM_AMDGPU_PROFILER ioctl number and its argument
>>>>>> structures, the UAPI for GPU performance monitoring features such
>>>>>> as SPM (Stream Performance Monitor).
>>>>>>
>>>>>> struct drm_amdgpu_profiler_args carries an operation selector and
>>>>>> a union of per-operation parameters, currently
>>>>>> AMDGPU_PROFILER_OP_GET_VER and AMDGPU_PROFILER_OP_SPM. The SPM
>>>>>> operations and the layout of the destination buffer are described
>>>>>> by struct drm_amdgpu_spm_args and struct drm_amdgpu_spm_buffer_header.
>>>>>>
>>>>>> The ioctl number and struct layout are frozen here. The
>>>>>> implementation lands in the rest of this series and the ioctl is
>>>>>> not registered in amdgpu_ioctls_kms[] until then, so this header
>>>>>> change alone does not make the interface reachable.
>>>>>>
>>>>>> Signed-off-by: James Zhu<James.Zhu@amd.com>
>>>>>> Reviewed-by: Bing Ma<bing.ma@amd.com>
>>>>>
>>>>> Hi,
>>>>>
>>>>> Can you guys please clarify why this is necessary and what the use
>>>>> case is?
>>>>>
>>>>> Are we sure we want a uAPI for this? RADV has been using SPM from
>>>>> userspace for many years now.
>>>>
>>>> [JZ] current RADV SPM is for graphic engine. These patches are for
>>>> compute engine SPM.
>>>>
>>>> Thanks!
>>>
>>> Is there any reason why it can't be done in userspace for compute too?
>>
>> There's only one SPM so there needs to be arbitration to avoid
>> multiple applications trying to use it at the same time.  It also only
>> works on a single vmid at a time so the application using it has to
>> request a fixed vmid.
> 
> Yeah, we already have an API for reserving a VMID for SPM.
> 
> We also have a TODO item to make that available for user queues which then both ROCm and gfx can use.
> 
> So as far as I can see that work here is completely unnecessary.
> 
> Christian.
> 
>>
>> Alex
>>
>>>
>>>
>>>>>
>>>>>> ---
>>>>>>
>>>>>>   include/uapi/drm/amdgpu_drm.h | 124 ++++++++++++++++++++++++++++++++++
>>>>>>   1 file changed, 124 insertions(+)
>>>>>>
>>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h
>>>>>> b/include/uapi/drm/amdgpu_drm.h index 9e5fa6f53e59..285949d63eb6
>>>>>> 100644
>>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>>> @@ -60,6 +60,7 @@ extern "C" {
>>>>>>
>>>>>>   #define DRM_AMDGPU_GEM_LIST_HANDLES      0x19
>>>>>>   #define DRM_AMDGPU_PROC_OPTIONS          0x1A
>>>>>>   #define DRM_AMDGPU_TRAP                  0x1B
>>>>>>
>>>>>> +#define DRM_AMDGPU_PROFILER               0x1C
>>>>>>
>>>>>>   #define DRM_IOCTL_AMDGPU_GEM_CREATE      DRM_IOWR(DRM_COMMAND_BASE +
>>>>>>
>>>>>> DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create) #define
>>>>>> DRM_IOCTL_AMDGPU_GEM_MMAP  DRM_IOWR(DRM_COMMAND_BASE +
>>>>>> DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap) @@ -83,6 +84,7 @@
>>>>>> extern "C" {
>>>>>>
>>>>>>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES
>>>>>> DRM_IOWR(DRM_COMMAND_BASE +
>>>>>>
>>>>>> DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles) #define
>>>>>> DRM_IOCTL_AMDGPU_PROC_OPTIONS      DRM_IOWR(DRM_COMMAND_BASE +
>>>>>> DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options) #define
>>>>>> DRM_IOCTL_AMDGPU_TRAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_TRAP,
>>>>>
>>>>> union
>>>>>
>>>>>> drm_amdgpu_trap) +#define
>>>>>> DRM_IOCTL_AMDGPU_PROFILER  DRM_IOWR(DRM_COMMAND_BASE +
>>>>>
>>>>> DRM_AMDGPU_PROFILER,
>>>>>
>>>>>> struct drm_amdgpu_profiler_args)
>>>>>>
>>>>>>   /**
>>>>>>
>>>>>>    * DOC: memory domains
>>>>>>
>>>>>> @@ -1821,6 +1823,128 @@ struct drm_amdgpu_proc_options {
>>>>>>
>>>>>>    } kfd_sigbus_delay;
>>>>>>
>>>>>>   };
>>>>>>
>>>>>> +/*
>>>>>> + * Supported SPM (Stream Performance Monitor) Operations  */
>>>>>> +/**
>>>>>> + * drm_amdgpu_spm_op - SPM ioctl operations  */ enum
>>>>>> +drm_amdgpu_spm_op {
>>>>>> +  AMDGPU_SPM_OP_ACQUIRE = 1,
>>>>>> +  AMDGPU_SPM_OP_RELEASE,
>>>>>> +  AMDGPU_SPM_OP_SET_DEST_BUF
>>>>>> +};
>>>>>> +
>>>>>> +/**
>>>>>> + * drm_amdgpu_spm_args - Arguments for SPM ioctl
>>>>>> + *
>>>>>> + * @dest_buf: [in] used for the address of the destination buffer
>>>>>> + *            in @AMDGPU_SPM_OP_SET_DEST_BUF
>>>>>> + * @buf_size: [in] size of the destination buffer
>>>>>> + * @op: [in] specifies the operation to perform
>>>>>> + * @timeout: [in/out] timeout in milliseconds (in), amount of time left
>>>>>> + *           in the timeout window (out)
>>>>>> + * @bytes_copied: [out] total amount of data that was copied to
>>>>>> +the
>>>>>> previous dest_buf + * @has_data_loss: [out] non-zero if data was
>>>>>> lost (e.g.
>>>>>> due to ring buffer overflow), + *                 zero otherwise
>>>>>> + * @reserved: must be zero for forward compatibility
>>>>>> + *
>>>>>> + * This ioctl performs different functions depending on the @op
>>>>>> parameter.
>>>>>> + *
>>>>>> + * AMDGPU_SPM_OP_ACQUIRE
>>>>>> + * ------------------------
>>>>>> + *
>>>>>> + * Acquires exclusive access of SPM on the specified XCP for the
>>>>>> + calling
>>>>>> process. + * This must be called before using AMDGPU_SPM_OP_SET_DEST_BUF.
>>>>>> + *
>>>>>> + * AMDGPU_SPM_OP_RELEASE
>>>>>> + * ------------------------
>>>>>> + *
>>>>>> + * Releases exclusive access of SPM on the specified XCP for the
>>>>>> + calling
>>>>>> process, + * which allows another process to acquire it in the future.
>>>>>> + *
>>>>>> + * AMDGPU_SPM_OP_SET_DEST_BUF
>>>>>> + * -----------------------------
>>>>>> + *
>>>>>> + * If @dest_buf is NULL, the destination buffer address is unset
>>>>>> + and
>>>>>> copying of counters + * is stopped.
>>>>>> + *
>>>>>> + * If @dest_buf is not NULL, it specifies the pointer to a new
>>>>>> destination
>>>>>> buffer. + * @buf_size specifies the size of the buffer.
>>>>>> + *
>>>>>> + * If @timeout is non-0, the call will wait for up to @timeout ms
>>>>>> + for
>>>>>> the
>>>>>> previous + * buffer to be filled. If the previous buffer is filled
>>>>>> before the timeout, @timeout + * is updated with the time
>>>>>> remaining. If the timeout is exceeded, the function + * copies any
>>>>>> partial data available into the previous user buffer and returns
>>>>>> success. + * The amount of valid data in the previous user buffer
>>>>>> is indicated by @bytes_copied. + *
>>>>>> + * If @timeout is 0, the function immediately replaces the
>>>>>> + previous
>>>>>> destination buffer + * without waiting for the previous buffer to
>>>>>> be filled. That means the previous buffer + * may only be
>>>>>> partially filled, and @bytes_copied will indicate how much data has been + * copied to it.
>>>>>> + *
>>>>>> + * If data was lost, e.g. due to a ring buffer overflow,
>>>>>> + @has_data_loss
>>>>>> will be non-0. + *
>>>>>> + * Returns negative error code on failure, 0 on success.
>>>>>> + */
>>>>>> +struct drm_amdgpu_spm_args {
>>>>>> +  __u64 dest_buf;
>>>>>> +  __u32 buf_size;
>>>>>> +  __u32 op;
>>>>>> +  __u32 timeout;
>>>>>> +  __u32 bytes_copied;
>>>>>> +  __u32 has_data_loss;
>>>>>> +  __u32 reserved[9];      /* must be zero; pads this struct to 64
>>>>>
>>>>> bytes */
>>>>>
>>>>>> +};
>>>>>> +
>>>>>> +/**
>>>>>> + * drm_amdgpu_spm_buffer_header - SPM Buffer header for
>>>>>> drm_amdgpu_spm_args->dest_buf + *
>>>>>> + * @version:       [out] SPM version (0-23: minor, 24-31: major)
>>>>>> + * @bytes_copied:  [out] Amount of data copied for this sub-block
>>>>>> + * @has_data_loss: [out] Boolean indicating whether data was lost
>>>>>> + for
>>>>>> this
>>>>>> sub-block + *                       (e.g. due to a ring-buffer overflow)
>>>>>> + * @reserved:      Reserved for future use, must be zero
>>>>>> + *
>>>>>> + * This header precedes the SPM data in the destination buffer.
>>>>>> + The
>>>>>> reserved + * field maintains 64-byte cache line alignment (32
>>>>>> bytes total).
>>>>>> + */
>>>>>> +struct drm_amdgpu_spm_buffer_header {
>>>>>> +  __u32 version; /* 0-23: minor, 24-31: major */
>>>>>> +  __u32 bytes_copied;
>>>>>> +  __u32 has_data_loss;
>>>>>> +  __u32 reserved[5]; /* pad to 32 bytes (64-byte cache line / 2)
>>>>>> +*/ };
>>>>>> +
>>>>>> +/* Supported Profiler Operation */
>>>>>> +#define AMDGPU_PROFILER_OP_GET_VER                1 /* get profiler UAPI
>>>>>
>>>>> version */
>>>>>
>>>>>> +#define AMDGPU_PROFILER_OP_SPM                    2
>>>>>> +
>>>>>> +/*
>>>>>> + * Profiler IOCTL
>>>>>> + */
>>>>>> +/**
>>>>>> + * struct drm_amdgpu_profiler_args - Profiler IOCTL arguments
>>>>>> + * @op: Operation to perform (AMDGPU_PROFILER_OP_*)
>>>>>> + * @pad: Must be zero for input validation
>>>>>> + * @data: Operation-specific parameters (union)
>>>>>> + *
>>>>>> + * GET_VER operation:
>>>>>> + * Returns the profiler UAPI version in @data.version as
>>>>>> +(MAJOR<<24) |
>>>>>> MINOR. + * Input: @data must be zero (reserved for forward
>>>>>> compatibility).
>>>>>> + *
>>>>>> + * Design note: GET_VER is intentionally a parameter-free query
>>>>>> returning
>>>>>> + * the global profiler UAPI version.
>>>>>> + */
>>>>>> +struct drm_amdgpu_profiler_args {
>>>>>> +  __u32 op;                               /*
>>>>>
>>>>> AMDGPU_PROFILER_OP_* */
>>>>>
>>>>>> +  __u32 pad;                              /* must be zero */
>>>>>> +  union {
>>>>>> +          __u32 version;          /* GET_VER: out
>>>>>
>>>>> (MAJOR<<24) | MINOR */
>>>>>
>>>>>> +          struct drm_amdgpu_spm_args spm;
>>>>>> +  } data;
>>>>>> +};
>>>>>> +
>>>>>>
>>>>>>   #if defined(__cplusplus)
>>>>>>   }
>>>>>>   #endif
>>>
>>>
>>>
>>>
> 

