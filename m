Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2167CEC01BE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 10:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA28510E032;
	Mon, 23 Mar 2026 10:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CQw7SoFa";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012013.outbound.protection.outlook.com
 [40.93.195.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBDE910E032
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 10:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUwYr9kYTZRp99hjzhf1nxwAeUN0wYb0YO38H978qL1wh+G8B9Se39+w1hRBzOeeno9mhHw3eTCeq47xN4/BsLVczzXd22BdQuSwKX93L+MJcmgunhoN7phosncpX4Qceus9/K35YL9G/6aObZ6v6Ho/0BWALWFOsXZiPUKQfn2PRIatYaJ5uGV8nZXfpJhJ/4oPyE5bogtD7x+IPmZDL8IeQWn78q1quVUazWPHPXNPfoeVdZhLwYXN4Twbo1eMWzUvVf4wYfyUUezkmSP9XEV/b6h4Pq3rEpp2Fx88GmxRI58uYLo8N6w0pZMnI8WGmhjaNHk+U7Zcfdvuj9eyTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGajSyDgPXNuRUwhduqf2EnKWILjyVUadBfZA03C8nY=;
 b=sq5M6jiwD9EnXULjtdplWjnW2q73eFB043gNEc8Kop2tbWvefFK+kfp15viDwkj9axiNbRQqndYzIFgT0Sqk8jwXZELUSTH2S4tCTSMwOkkUTBS/HK2OyhRfhAlbt7G77LMXSCjcO36CqQzqHpP/VW6BzZK9kMAGWA4b63aVFFbiN32+HtIDXH6+AF5izO3Rr5nsjGoGSTv+pFi6oBDxhGLeseGlX7OWg17yCWohNEdRPi1anxBf6tpxAg+ulzIhKSuQwU7nzaXy9L/Roe6bshBXA1Ktsl+IwYCn/z2MT27zaKjTtxGB57nXEW0INLZns22GtXLIXVCxbgWNxGtbxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGajSyDgPXNuRUwhduqf2EnKWILjyVUadBfZA03C8nY=;
 b=CQw7SoFabyBFBgHE2BaKVwZlh/tuFfDbfiDxUIiQbBy5DO9sAXBffhONjI5C7GOSiTrwHwpQkbvBk2G6V59tkb7GBHFqibSg3cjFvmH5ryGXTPDjYlSJE0DE5YSY06ShXJD7gIlahRzYEXkp2F0/3x7GGvGtNzvHhu3p+BwEaFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB6447.namprd12.prod.outlook.com (2603:10b6:8:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 10:40:24 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 10:40:23 +0000
Message-ID: <61409574-bd9b-41c4-a6ef-f7c45067f290@amd.com>
Date: Mon, 23 Mar 2026 16:10:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: guard atom_context in devcoredump VBIOS
 dump
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260323065621.554621-1-Jesse.Zhang@amd.com>
 <08cef5ab-1874-4f34-b9b6-a4355bdcef58@amd.com>
 <DM4PR12MB5152D99D07A365D78DFC99CBE34BA@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM4PR12MB5152D99D07A365D78DFC99CBE34BA@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: f4cc6431-4b6b-48a4-2e0f-08de88c89667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 4G/g5j6VGQMO54wTyypHU9bXx1cMwdzwHY+KrqjT8f/hRGebJY6/yR+9Z6anRVLxKKRgpX/VPilK6m03jWiEIsXBFJxItTj95rqMBzWa4kpQ3Od8No8LSXvUGrtrIcjWptJaieoUT6Di2xulL0YkWuBComJMKxskPlRMsW5ldXv/uOBYUmudV0XpeX8ziLkftKfDz07TP8Jmoe9XCB0tGIbcKgpg+GNnyK6kPtXON4edkxLxbCVDNtjUOcpptGfN8Ft7NWnK5eHFBSJ1i0SnUiAbGIteF13nftd/E/qllQR0p3eyMqRa6hTXK9sfCi988AyUgnZYK/1TVIYziEc7ySnmtEFHtw3e1p/boFapS++fNMXayN77K7Hbgq/jfcTLT9kjU8R9p1i3pGAgS4XLtIGBnl2x8BcrApCQT+XBkjoGM8ndFmFM94cvcEWwKxE82/SLpUTr4t/Zlr7Dhov/k3wPzbmxUiH+I29TYxOZs56yrGfl6vcOonxO4qgDZHYg5FVMPim1UVR5i65EesLblVyNnEsHY2U8iTrwps0G3p97MHWheZeZtJ06dIO5o+z753WFdfe5EyUYukd+vtxDgPlQSlaV0u46rV0j8srY8nQgIseOQbVxFTPbDFtUXbjtseDpGPKtTjtjJH76lywzh11QiBpdXGqp/ehYVxRn8zvPNRzAOpOs9QcLOaVUf3afpDsv5F90MU1SrSM1CYeti6iXEt+83E58la3H8jC9Joc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkkvZWRjaFNtZU9SMDFsc3doaUhsWUJkWEM1MjdzWjFxaXM3WWZZbCtLditx?=
 =?utf-8?B?bjlsMUNMemd3UUlrblpjbjhkNzN4Vkk0b29WNlBqaFE4OUxydVBMR2lkQ1Iy?=
 =?utf-8?B?QlVXZU9rNzBoMjdkeU05VlhZRWNkbHpYaSt6OWludWNGamlTeEZxTmtvY0F1?=
 =?utf-8?B?R20xQjRVcWFTdG5QOVR3RElycUFzRE5xNC9JcGd0VU92ck1UUFp4UjU0ellx?=
 =?utf-8?B?TVRiRHZLVlAvQzhoNGNuVnRTREt5QlpuZDVHVXRqMjkxeElnR2hsYnNEQWdP?=
 =?utf-8?B?QS85OVVVbDFSUUN1WXVHTzk3SWVrQ2xGNzBwRzhGMks0dVFxNGExZnh3SEln?=
 =?utf-8?B?ZFdHUlJVR1R1OXcwYUJNQ1dnMmNxbkh2NkxEODVRSFBtZGVFTkxZa0JKdWkw?=
 =?utf-8?B?ZTdmWDU4R1djNHFXZ2prdWlJWXhjNklSN0VnNWt6a0tPaFlmblI5U3JRU0JF?=
 =?utf-8?B?WGxUbnNtNE9WdnBNcU1qbG43QjhOdjMwNHAyMHNLRDNibkJCRHM5OUkxOU9M?=
 =?utf-8?B?U2JwT3VZUlVJaElKbmduQVV0RjJaM1BicisxYnhNeXRXNXpKY25HOWNpODA5?=
 =?utf-8?B?by9XTzh1akV2UFd6TnRYQkNYQm13RnBzdmVicWNLSzNpd2w4N2VJMWRaelJ4?=
 =?utf-8?B?ZDcxNjAwem02MW5MWjRzUU4rcjBSeEQ4S2EyRWovTVRIZGJrZGtGT1pRbnZt?=
 =?utf-8?B?L0Q2RXVUM1kzK0NkalVBeXJNcFZZQWVkcDgwcnBDSXh4eTBYRXZkcXJYdEpv?=
 =?utf-8?B?ZnFsc0x3Y2tzZXMwZXg4dXpXeUlyNWxseG1WcCtrMndSQjYrQ3g2cG5xK0tN?=
 =?utf-8?B?SW1FSGtxL2Z0YXhIT3hPT3hwM0hDNTJrcnhPRE5JdnlmeW9sRTVCTkJvTUFW?=
 =?utf-8?B?Sk5yV29VZ0VLOTR3V1hmMFJGY0s5QUZGVWVEYVEwNkREalR6ckR4dkNoMU44?=
 =?utf-8?B?R1llUDJ5ejBXN2Juc1IwZkhuRWpTRDRaV1hlUUU3Z3VRRTA1d24vS29DRmpE?=
 =?utf-8?B?TDlpUXZ6dk1IdTlYRkJNS2lmaER5MG45cTQrVmEyWTRFb3Z6ckpZNHc2VzR1?=
 =?utf-8?B?UlYxU0dEdGNuUExrU1hzM21JRzZUQ2JKcUlxRGIvQXlBRzVBVG5CWnF0Zis0?=
 =?utf-8?B?dFZvbEF5TVhSdjR3ZlVsa3ZnbTNyeGlJSitPSW9LRmV3ZjdKN0l3Y1JBenFr?=
 =?utf-8?B?d1Bmdy9BcDhIdkJpcHU3SDg4TjFLYlhxWnhCWnk5eE5jbXA4RDZGaXRaeW5I?=
 =?utf-8?B?dUNpalEyMlI1cDYrYlBWWStGOVdPbmNSc0pWMjh0dmZXaFZwMkpYdEJKQVY4?=
 =?utf-8?B?M0tUZFRqNCtteVNlNHlkQWFhVlovMjA4ZFh5TUNRWHUxNkpIcElrWVpQSVRF?=
 =?utf-8?B?Y09rcG1LMEJVRG5EdVZBQ0FGQXJxNXpBMHBuTkxvN3lyYVpYUUZRNTlSWFE0?=
 =?utf-8?B?M3NLOFAwbFYzTjhNbXZ1SzkvS04rMHhSQnJFaUZKbllPQVdKZkZ6VEZsdUJr?=
 =?utf-8?B?K2JJcUZCSU8wd2xBQXNsMExsNy9XRm5hQzQvN3VON3dMbEIrTWlEWjhuVVBR?=
 =?utf-8?B?ZDdZQk5nSndGSmw3UWVHeVV3WFhhR2Zma2FpN2pZbGxKQ1NjOWxsVXBQd3Jv?=
 =?utf-8?B?MlQvMXIxeUlJV2VUaU5nWEJFZUZtOEtrN2Uwc2FmeXZsb3JKa1VkaE01aXdL?=
 =?utf-8?B?ZGR5V3JCQ2ZLaXRTazdzU0VCQWVZN0NJM29zekRkWmx3ZFlLVFA5c3JBajVh?=
 =?utf-8?B?VWRLWS96T09zQWhRMW9OT0F0dmtiNGwrS2ZDWG5DbVRQc3JxL1o5REZFTnhy?=
 =?utf-8?B?eWNGUnlieEdhUnNyYWdodld3cEtZKzFVOHYrLzFjc3ZCY3FKZkR3RG9mRjY0?=
 =?utf-8?B?R2EySEJuYmhldkY4eUpWZzl5NWZSdlNXdlBTK2pNZm9ycmRpc0JER3ZmVzlv?=
 =?utf-8?B?RVVVVXNKTXk1ODh1TDQzam9PUjdwTEdYSytTeVFPUVpDWUx1eHByaSs3Vlcz?=
 =?utf-8?B?MzVOSDRZVFRsQ2xpaVlvOTZnUFM4MzRkNE1mWHBiNC9hOEs0bXN2eUxWdjBz?=
 =?utf-8?B?cHczbitna3hPMkhhNWpydWtCWDdEZ1c0RU81NlJ2SlNiSFZzZFZqSjgwWk93?=
 =?utf-8?B?dE9tR2VWZHdYdUNHaGt5NW01TklGNHhibm5NZGMyd2VVUEEyYlpPamRaYmIv?=
 =?utf-8?B?MDY2enJKVlFyS0h3WktWRGFHVHZEL25OSkNDaHAzc2V1d3g1aTdNcnd2bVlk?=
 =?utf-8?B?TDdRdXVGcWNsNWdOMll5NDJmTlpyZkM2N2RHMlBocHJEZC9CL2J5Q2IxQkQx?=
 =?utf-8?B?VFVsY1J2Z29Ua1dlSWZ6R2JKWEgyTDB6d0ZSUU0xazZWVHArZXRLZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4cc6431-4b6b-48a4-2e0f-08de88c89667
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 10:40:23.5856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixCJ1LZMOurnikTROP42++2GQoh+9uvRGXYQj2vSnWaBwNf8Id/sNZfttnbGagsp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6447
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



On 23-Mar-26 3:46 PM, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Monday, March 23, 2026 5:57 PM
>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
>> <Lijo.Lazar@amd.com>
>> Subject: Re: [PATCH v3] drm/amdgpu: guard atom_context in devcoredump VBIOS
>> dump
>>
>> On 3/23/26 07:56, Jesse.Zhang wrote:
>>> During GPU reset coredump generation, amdgpu_devcoredump_fw_info()
>>> unconditionally dereferences adev->mode_info.atom_context to print
>>> VBIOS fields. On reset/teardown paths this pointer can be NULL,
>>> causing a kernel page fault from the deferred coredump workqueue.
>>
>> I don't think that this is correct, just checking for NULL doesn't fix the issue.
>>
>> We should rather make sure that we don't release the VBIOS information during
>> teardown before the dump is completed.
>>
>> Otherwise it can be that we manage to grab the pointer but free it a moment later
>> and then try to print freed up memory here.
> 
> Thanks Christian, good point.
> 
> Agreed that a NULL check alone does not fully address the race and can still
> allow use-after-free if atom_context is released after we take the pointer.
> 
> I reworked the fix to snapshot VBIOS information when coredump is created
> (in amdgpu_coredump), and the deferred formatter now prints from the snapshot
> instead of dereferencing adev->mode_info.atom_context.

Snapshot shouldn't be taken. Atom context will be valid till sw fini - 
i.e., till driver unload. Need to first figure out if a coredump during 
unload is expected. Now, if at all a coredump is happening, then driver 
should wait for the coredump to finish and then proceed with sw fini

Thanks,
Lijo

> 
> This keeps coredump output stable across teardown and avoids both NULL-deref
> and potential UAF in the VBIOS section.
> 
> I’ll send v4 with this change.
> 
> Regards,
> Jesse
> 
> 
>> Regards,
>> Christian.
>>
>>>
>>> Fix by checking ctx before printing VBIOS fields:
>>>
>>> if ctx is valid, print full VBIOS information as before; otherwise
>>> print a fallback line:
>>> vbios info       : unavailable (atom_context is NULL).
>>> This prevents NULL-dereference crashes while preserving coredump output.
>>>
>>> Observed page fault log:
>>> [  667.933329] RIP: 0010:amdgpu_devcoredump_format+0x780/0xc00
>>> [amdgpu] [  667.941517] amdgpu 0002:01:00.0: Dumping IP State [
>>> 667.949660] Code: 8d 57 74 48 c7 c6 01 65 9f c2 48 8d 7d 98 e8 97 96
>>> 7a ff 49 8d 97 b4 00 00 00 48 c7 c6 18 65 9f c2 48 8d 7d 98 e8 80 96
>>> 7a ff <41> 8b 97 f4 00 00 00 48 c7 c6 2f 65 9f c2 48 8d 7d 98 e8 69 96
>>> 7a [  667.949666] RSP: 0018:ffffc9002302bd50 EFLAGS: 00010246 [
>>> 667.949673] RAX: 0000000000000000 RBX: ffff888110600000 RCX:
>>> 0000000000000000 [  667.949676] RDX: 000000000000a9b5 RSI:
>>> 0000000000000405 RDI: 000000000000a999 [  667.949680] RBP:
>>> ffffc9002302be00 R08: ffffffffc09c3084 R09: ffffffffc09c3085 [
>>> 667.949684] R10: 0000000000000000 R11: 0000000000000004 R12:
>>> 00000000000048e0 [  667.993908] amdgpu 0002:01:00.0: Dumping IP State
>>> Completed [  667.994229] R13: 0000000000000025 R14: 000000000000000c
>>> R15: 0000000000000000 [  667.994233] FS:  0000000000000000(0000)
>>> GS:ffff88c44c2c9000(0000) knlGS:0000000000000000 [  668.000076] amdgpu
>>> 0002:01:00.0: [drm] AMDGPU device coredump file has been created
>> [  668.008025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  668.008030] CR2: 00000000000000f4 CR3: 000000011195f001 CR4:
>> 0000000000770ef0 [  668.008035] PKRU: 55555554 [  668.008040] Call Trace:
>>> [  668.008045]  <TASK>
>>> [  668.016010] amdgpu 0002:01:00.0: [drm] Check your
>>> /sys/class/drm/card16/device/devcoredump/data
>>> [  668.023967]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [  668.023988]  ? __pfx___drm_printfn_coredump+0x10/0x10 [drm] [
>>> 668.031950] amdgpu 0003:01:00.0: Dumping IP State [  668.038159]  ?
>>> __pfx___drm_puts_coredump+0x10/0x10 [drm] [  668.083017] amdgpu
>>> 0003:01:00.0: Dumping IP State Completed [  668.083824]
>>> amdgpu_devcoredump_deferred_work+0x26/0xc0 [amdgpu] [  668.086163]
>>> amdgpu 0003:01:00.0: [drm] AMDGPU device coredump file has been
>>> created [  668.095863]  process_scheduled_works+0xa6/0x420
>>> [  668.095880]  worker_thread+0x12a/0x270 [  668.101223] amdgpu
>>> 0003:01:00.0: [drm] Check your
>>> /sys/class/drm/card24/device/devcoredump/data
>>> [  668.107441]  kthread+0x10d/0x230
>>> [  668.107451]  ? __pfx_worker_thread+0x10/0x10 [  668.107458]  ?
>>> __pfx_kthread+0x10/0x10 [  668.112709] amdgpu 0000:01:00.0: ring
>>> vcn_unified_1 timeout, signaled seq=9, emitted seq=10 [  668.118630]
>>> ret_from_fork+0x17c/0x1f0 [  668.118640]  ? __pfx_kthread+0x10/0x10 [
>>> 668.118647]  ret_from_fork_asm+0x1a/0x30
>>>
>>> v2: add check !adev->bios and chang the log  (Lijo)
>>>
>>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 16
>>> ++++++++++------
>>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>>> index bbb5afd67b49..29078c08f264 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>>> @@ -192,12 +192,16 @@ static void amdgpu_devcoredump_fw_info(struct
>> amdgpu_device *adev,
>>>      drm_printf(p, "VPE feature version: %u, fw version: 0x%08x\n",
>>>                 adev->vpe.feature_version, adev->vpe.fw_version);
>>>
>>> -   drm_printf(p, "\nVBIOS Information\n");
>>> -   drm_printf(p, "vbios name       : %s\n", ctx->name);
>>> -   drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
>>> -   drm_printf(p, "vbios version    : %d\n", ctx->version);
>>> -   drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
>>> -   drm_printf(p, "vbios date       : %s\n", ctx->date);
>>> +   if (ctx) {
>>> +           drm_printf(p, "\nVBIOS Information\n");
>>> +           drm_printf(p, "vbios name       : %s\n", ctx->name);
>>> +           drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
>>> +           drm_printf(p, "vbios version    : %d\n", ctx->version);
>>> +           drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
>>> +           drm_printf(p, "vbios date       : %s\n", ctx->date);
>>> +   } else if (adev->bios) {
>>> +           drm_printf(p, "\nVBIOS Information: NA\n");
>>> +   }
>>>   }
>>>
>>>   static ssize_t
> 

