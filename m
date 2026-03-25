Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B765BFEA83C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 09:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52B0210E6FF;
	Wed, 25 Mar 2026 09:47:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HgC8umN9";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2105E10E850
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 09:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMzWxB4PtaUQnujYtyQeTJ8F1mvvR+84VlQtSlHmmlJFCtft3dC0ZllSHY6aJxTKD4fxFV9qsnFNv0iMS0t2ZCOKDFKpxtNyq58GM8Rav1HIuQhaAI7zEj7HK3GoQkNwNxmaCmuiskf7qfRRHY1TVV4lRwKbJndMyAiacK6yFHtvgpmO/SaDe6ga9a5bphNPhTV6VBWX+GZjfVGz5nEyEe7wTG2Lcz2gVtRDQS05m9gWi/MpTnkVi4v0IP1NgxladwiaDVkfgcifnWFGPu9cD36qTJy6OSMsP+sDPlzhR59kzPTyJds7zrWWLgQ7R16AUseh+wP1t5rpLP0CFRCzQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5+l5SgmkNdTDOeOky1OEM6uHxUUKqhUPMp9zz56SnE=;
 b=xGGuATPGRP55Qsm3LjxWcPTuRxE+Cj0ujMxOoepj90GEyhJuz81eZZ3Wr1rW6M8NCgMWPGUQZXnQ1npeNJXbFovvKYMR/rdCU4BC6lOsoPdZ+IskgN2tQAIeZE1khXtfTuq2U1ZWeVFDvSTZto01i8IwDY1Q6lZhL6f0aF/yOPbF3gW2P6asQuZF8+pFO2THTZGlv41t+82zyFwZ+TQuNrRgsHbjRB32mY220zsN4RC36pxGh5Ayv0XotxwcpoQ65/tsQJycnfG7qEOaj4fLMWGbsoEQ5ZbRA9Xn/Kb5jdXqNc1Coka4UUh9Fu4E6Bng/ek2FOzFBhpZPsn30DJjyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5+l5SgmkNdTDOeOky1OEM6uHxUUKqhUPMp9zz56SnE=;
 b=HgC8umN9C9dgtBDjhywjcX9AOtaHBd+efAS2hQdGgwe5kC+40J9m8QJlkHaBOqFOMpKYeNJ8/+Vyizi1ZVgrcIbPD8Wr6aC5moNsgwiTun23dNdhzbSc22mX3Enz4PJnH999gt0+TQU/Io03mY0DCvsuaN06NrEctTvqYLR96hY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Wed, 25 Mar
 2026 09:47:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 09:47:15 +0000
Message-ID: <bb5bd80d-3a24-4cac-a33f-0aaa781a2780@amd.com>
Date: Wed, 25 Mar 2026 10:47:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: validate SIGNAL/WAIT ioctl input argument
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260323033023.3338683-1-Prike.Liang@amd.com>
 <PH7PR12MB600006CE3FC81B5FF6985A87FB48A@PH7PR12MB6000.namprd12.prod.outlook.com>
 <a089317c-cf9a-469f-a8d1-2aca8769d56e@amd.com>
 <PH7PR12MB600043837CC7A1E641E04380FB49A@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <PH7PR12MB600043837CC7A1E641E04380FB49A@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: d3053d3d-05c7-47a1-72f3-08de8a537f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|7053199007|22082099003;
X-Microsoft-Antispam-Message-Info: VgpG1+Ck2gs+KqzaXzE05SGZyJexXKej+FFOEeXsU0MWedaQvVck4JPCko9/nCtrMJ3Ac5PaK4VvHYDE1FRNuhX8PJO+sfrbTx22KAS3Fgd2ybYzaHTtBujuqtbD3DyNNrpOh0noF1NUOVd59lpo2JiFzUj4FJff9BDwxyFJXBFOxz6MQtdMLovIMbEX9ML1Z0+uGiNsom/zIsQhmQdbFkIKhlAfsih7rBM6Wm8/H/TFkEOQxYnfwsZ9AdvuHqOMsSYP33/+vSP7N4TV5o+w/cTjtR0N+IXIcIm19PAbO66S3jMH9Pa9yTCt7+7WIuFutjGhpfzHtDQjUNCgZBFLBYQAgt58kBFdif3NErye1KJcDBjg9OAD3pfKTjh4u85BJ37il2azmnbbdQiPNeXv0ItGXLxFyqtGAiYZCbnEyI5ULHn2K8uvpnkqnzJMtzp5Z/lOT2HYYME2PXW0oaUmtxD8YnIRmmDbxetbrWM3+G9fCvLPkf+MIB550sO0bAFgG35+5ldj82tiRyB7tmsVMRNx+KiCyeHdyrL3upSukXx0v6xqzAuXA5XdIkI7cpn6rApiejfqG0J9ZFE5qyB3AlDUvyo+v1dpDpbo5VmHutgrHrLoGfuOTaRQX/9UZb35SCTUAq8u+FZNT5mxyb6IixdGBUbrdM84hL4fnYfO4d2C327vkts2J+xJzCyHnfX7NRFip7NAecQfZ91ggjB9xZTb92vx4BOtoCpjRosVA/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(7053199007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFZVaVNhdjVJQ29xcjNMSlE4V3lvdDNIc2lMOVRTd3BrclE0dDBmTEpaSkU1?=
 =?utf-8?B?cS9EamJPOFNHc1hZd0RXTXMwaDc5Ykd3RXVXNFlZd1R5U0l1VjhmNGpBdVM5?=
 =?utf-8?B?Nkh2K0xPc0U0cFJCdnpaZGpCWXpqNVNzZmdoM0FLblpJSngzL2xUSy9wRG5z?=
 =?utf-8?B?RERUb1pFQnFOREZoYXpHMElDV2JacmNVTHpaeUwrendSUnI2cjV5TE5zQno4?=
 =?utf-8?B?dTIxSkF6cHZIZlViL284d3ZyaFN1ZElsSHVIV1lwNWNIbFg5d2U1QW5FMlJs?=
 =?utf-8?B?T1hKYkp3TzFTSmNVSXRoNlJKQ0g3NnIxa1o1bEZQd1VhdXo3eHkyWGhDZm5Q?=
 =?utf-8?B?V0hMbmI5NjdEMVZtMVdWeTJRQ25xNHJ5V2tJRitsU3dvd1FWWE50YS9PN2h1?=
 =?utf-8?B?ckxiQStOK1Nwckp5NTd5Qng1aHF5aXdjcDZIdkp5ZytLVFExM1RsZ21DWGl6?=
 =?utf-8?B?Vzh4U2tPYTVtb0szYnBOVDRleEtIQUpCWVpMTVlLczBjU1NVbHpPczlaUHd4?=
 =?utf-8?B?N1VtWWhpK3FaUnF5L1M5TnNYZXFEVi9iWmlGZjBac1NHNWNuQlF0Z3h1a1RS?=
 =?utf-8?B?R25uWlZobWhWcmxiek0yN1FHeXN1bG5yR3M0VE5hNldIcUlGRTNnMTZKVWRM?=
 =?utf-8?B?RjNXbkFreUFVeWxHWEhxbGRWMnZmU0RiK0h0REFVWStIUlRvWmZ0eENEdjlE?=
 =?utf-8?B?Ti94b0lWWlQ2VmxlMkM4Q3dqbWdzNGZ3RFNocSs0VndMd3NFS1pwcXdwdy91?=
 =?utf-8?B?bVNTS2l0SjVuRnNsTzkvaVVMRHZYYXZCTXA0VHFmeDMvSEV4bk0vWWlMMlhD?=
 =?utf-8?B?alFvK3JBQlNaRGhXemp0SzlnK3doN005cHZKOWhZMW95dGlESlhXeXN5Tmcr?=
 =?utf-8?B?Ukw2NmxJczVYZ3NwUHp1cDBlOUJYckttbEFkS2lYYlZaeEFFWmR3UHF2cFBK?=
 =?utf-8?B?VlpjYXJnMUhpaUp0UXBneFJKMXZTaENpUVVCN0NSd3MwSU9WcVkxNHBmT2dM?=
 =?utf-8?B?THo3N1FheU9XSDhZTnR1U0p6UzdEK0gxZGMyUWR3LzczS1ZaTThuNFNJK2dw?=
 =?utf-8?B?NEx6Z0VpaTdTUi8vR3Z1T291YkZwSWpOMTlTekVVOXJNSDVrUlZMSDdIZ2kz?=
 =?utf-8?B?cG1WMnRqZktJbXlLYVhFdU1MWGRMWXpLajRHNU11S2pVblRmMUdMemYya21N?=
 =?utf-8?B?MWtrWjRWWlhqSVRHVXBMenRFOHVRa2FPRFdKbmNSUzlxOUloaXlUT1I2TFBi?=
 =?utf-8?B?OW5FVHR4OEdTSWhrdXVhUmdEQUN5S0VaTFN3SS9Oek1sYTFKU05MQjF5NUo0?=
 =?utf-8?B?VE9ndGMyYUVWYVo4U1p3RFpEcU0xMDA2aDU4dTJqZ1NoeGhSelZyc2xTSHl2?=
 =?utf-8?B?K2lhSWFSOStiREMrektqMmcxa1VHZDlTL3NwMloxbmhSalZET044eVRqdElq?=
 =?utf-8?B?OXc5dUxpOWMwYXBkL1NyWmlkeTJydE94dEY4M25xSU5YUmZ6QVc2SktkTFdn?=
 =?utf-8?B?OEVPYnpoencyY2hTM0NUUzJGNDFIUURlQlVSVjZxd0ZyeFdtSGNOcWhmWjNJ?=
 =?utf-8?B?NHZ1NWFTQXpocENMUlJmQ1hRL1RBM1FSbS9ILzZXaGx1YXRuWWJEc1Z6Z2Z0?=
 =?utf-8?B?aFduUkhScDVBTW1Bc2s0TWNkNEpiY3lOTldkUWRYZzBGcDVoQ0tOTHI4bEVl?=
 =?utf-8?B?VmEvWlNnbElOaTJRNWFuWGVUWnFRL3hibDNTMHVOaHVaT0RvalJvT3R1YjR6?=
 =?utf-8?B?RDd4eEhtREIvRndKTDlaeko0K1FxSmpQQTBlbHkxdGtGVlh0U3N6eWdpSWo3?=
 =?utf-8?B?LzExN3A2TCtkTEVqVmFvdDJiVjB0Y0ZYcFUrSW95MXU3ZDVwc2c4NXNtU2xZ?=
 =?utf-8?B?MGVQU3h2cDJNa0ZycTk0bFY0K0pxOGlxMWh0bGdrNWlDWHB4REVidGo0ZitK?=
 =?utf-8?B?SElaemJ0U2dCVE81K0pKWXNzaDUwQUYwQ3J1Lzc1K1grOC9RQ250SEVNQUdN?=
 =?utf-8?B?UGVqV25CbmRJZ0R4Z25ud0F2UXlPL3NGd2J1bU9MaWJvQjFmV1ozbjk0MjA3?=
 =?utf-8?B?VWQvMitaWXFNaDJ6N1ludXAvZjd0b3B2U2ZrZThrYndsRFFhemVTa0pVbjlw?=
 =?utf-8?B?MDlia3BYT0tiZUpaTGZheXY3eE9uQ0thaVJRWWhkbVFER0pwZktzSzlkbkg1?=
 =?utf-8?B?cWdRdWw4YU5xQjlsbERWUG1nYUJUSG5McFEwZWljd0xrTFVGRXowY1JpdTYx?=
 =?utf-8?B?ejFtYVY1R1NlblNQai94VTlIRW05cmt0TjJBU0RON3RBd2lnei9ZSmhjUTdE?=
 =?utf-8?Q?4NPoiEjG2uhVIziRLY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3053d3d-05c7-47a1-72f3-08de8a537f37
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:47:15.7563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39zCpDR5Tc4rs4wYWhHKHHFbl2pBgmrrivgjt6ca4H7Ns2iphnUrkGuoIwOOOsUy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
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

Oh, you inverted the check!

I haven't seen that, but that isn't necessary and actually messes things up a bit.

A NULL pointer is handled by the copy_from_user() functions and shouldn't be checked here because that results in incorrect return code.

So we clearly don't need that.

Regards,
Christian.

On 3/25/26 09:56, Liang, Prike wrote:
> [Public]
> 
> Yes, we still need Mesa to handle the userq sync handle count  (num_syncobj_handles = 0) allocation correctly before the kernel can safely filter out invalid *_number = 0 cases. The change below is aimed at filtering out invalid handle cases on the kernel side, which helps reject bogus handles without breaking the existing userq fence signal/wait IOCTL behavior, as I’ve tested.
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, March 24, 2026 10:10 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: validate SIGNAL/WAIT ioctl input argument
>>
>> I don't think we can do this right know. Userqueues is still a beta feature, but that
>> would break existing Mesa releases.
>>
>> Regards,
>> Christian.
>>
>> On 3/24/26 14:40, Liang, Prike wrote:
>>> [Public]
>>>
>>> It's not too much change, so ping?
>>>
>>> Regards,
>>>       Prike
>>>
>>>> -----Original Message-----
>>>> From: Liang, Prike <Prike.Liang@amd.com>
>>>> Sent: Monday, March 23, 2026 11:30 AM
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>>>> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
>>>> Subject: [PATCH] drm/amdgpu: validate SIGNAL/WAIT ioctl input
>>>> argument
>>>>
>>>> Filter out the invalid userq emit and wait ioctl input arguments.
>>>>
>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>>> ---
>>>>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 27 +++++++++++++++++++
>>>>  1 file changed, 27 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> index f93da45cfa7e..7b2700a0c0ad 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> @@ -483,6 +483,17 @@ int amdgpu_userq_signal_ioctl(struct drm_device
>>>> *dev, void *data,
>>>>       if (args->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
>>>>           args->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
>>>>               return -EINVAL;
>>>> +     /* After the mesa allocates the input obj properly, then there
>>>> +      * also requires filtering out the invalid obj number.
>>>> +      */
>>>> +     if (args->num_syncobj_handles && !args->syncobj_handles)
>>>> +             return -EINVAL;
>>>> +
>>>> +     if (args->num_bo_read_handles && !args->bo_read_handles)
>>>> +             return -EINVAL;
>>>> +
>>>> +     if (args->num_bo_write_handles && !args->bo_write_handles)
>>>> +             return -EINVAL;
>>>>
>>>>       num_syncobj_handles = args->num_syncobj_handles;
>>>>       syncobj_handles = memdup_array_user(u64_to_user_ptr(args-
>>>>> syncobj_handles),
>>>> @@ -946,6 +957,22 @@ int amdgpu_userq_wait_ioctl(struct drm_device
>>>> *dev, void *data,
>>>>           wait_info->num_bo_read_handles >
>>>> AMDGPU_USERQ_MAX_HANDLES)
>>>>               return -EINVAL;
>>>>
>>>> +     if (wait_info->num_syncobj_handles && !wait_info->syncobj_handles)
>>>> +             return -EINVAL;
>>>> +
>>>> +     if (wait_info->num_syncobj_timeline_handles &&
>>>> +         !(wait_info->syncobj_timeline_handles || wait_info-
>>>>> syncobj_timeline_points))
>>>> +             return -EINVAL;
>>>> +
>>>> +     if (wait_info->num_bo_read_handles && !wait_info->bo_read_handles)
>>>> +             return -EINVAL;
>>>> +
>>>> +     if (wait_info->num_bo_write_handles && !wait_info->bo_write_handles)
>>>> +             return -EINVAL;
>>>> +
>>>> +     if (!wait_info->num_fences && wait_info->out_fences)
>>>> +             return -EINVAL;
>>>> +
>>>>       num_syncobj = wait_info->num_syncobj_handles;
>>>>       ptr = u64_to_user_ptr(wait_info->syncobj_handles);
>>>>       syncobj_handles = memdup_array_user(ptr, num_syncobj,
>>>> sizeof(u32));
>>>> --
>>>> 2.34.1
>>>
> 

