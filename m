Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8BAC5AD7B
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 16:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6FBD10E920;
	Mon, 10 Aug 2026 16:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GnbB5mFd";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012005.outbound.protection.outlook.com
 [40.93.195.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD89E10E920
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 16:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFfQ6Cr9vuVWFUVwFrdvPc5GIw/o/ViOf92dJAtLl3wlitVD53Tkb5Hn+TcP3gRZH/7gS93zEb1il4ARUMHHuxdDthsWtXqtSGCuYDHp2rk6OhzQPo/DtLyqgSOEqR3G5I6GJo0YRAfhQSDBoprucgkVt0gW6PXxNVQh/U+tPR2yhMdv+jFE9YAjNNSMdR08e4BqtondgorMJ90uRI4Wa00z3N+4/izT4wsBIF1TvENlskvEuAJj/WrQrLXsgVu0oTuJtetgr5C9DfA7Skv34sLSfpxTr6Ma7DdrJMAJuG223KnvsuXAmLPUIFiZbipbNCZWH9YoToiBkh+VD6/Ohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCo5yTVmEsco0uirNSSSiMicqpoax2SYFKyOq1Z2/70=;
 b=O5DBDES7yxInGrqVGxc16yDnvEIkzvPT7d+VSSS+Lqz6sEfBtGfBYJsrtlZkexsYa5xDUbK5fnHOc1V1RI2bcGNVRr/hiqMzkHlNeVD7iw1zx0/AbQkwAshvFPvPw9F7ryXNEhQsRLK44qZIYKBOzvr8eSvQNAu0VR3TNiLjOwZrUrKRwno57upKcSTNlq+3p8vqq3AEtqQnETJeF4qM4gTNAjZQWf2qPv0uVtgyajr7+RFZKwJfiRyz8LBBRfp2GPDOL1O8Sy7T8y3nt7mE3+Ol3yJegqjZNOyW1XwVzUFklieHJE35h7jwrMfbKDiV3ZAq6DAvg/OqIC4P6dJZ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCo5yTVmEsco0uirNSSSiMicqpoax2SYFKyOq1Z2/70=;
 b=GnbB5mFd0kQiNKVNg4gzrfk7lmzDK3MQyVxmCo462O5++9jU7FOpsq66thqWI/F4hBWMs1xMUmWJ5Y+/aH8dPSMNLnN89k+Y0yG/jP28F2BTCi6abtUrgcajYBPwmY0kV96qWTFBQoyIMMcPr8LXybWLaS0O9i4z1AIun/NhAGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8)
 by CY5PR12MB6060.namprd12.prod.outlook.com (2603:10b6:930:2f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:21:42 +0000
Received: from SN7PR12MB6767.namprd12.prod.outlook.com
 ([fe80::ef05:8207:37d5:53]) by SN7PR12MB6767.namprd12.prod.outlook.com
 ([fe80::ef05:8207:37d5:53%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 16:21:42 +0000
Message-ID: <13c173d2-11e5-4480-81c5-dc5b4d995631@amd.com>
Date: Mon, 10 Aug 2026 18:21:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: fix missing check in vm_flush()
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260605221853.903153-1-alexander.deucher@amd.com>
 <20260605221853.903153-2-alexander.deucher@amd.com>
 <CADnq5_MOVBmf5Y6mPumdjiTRx-ffJROo2vsc7QmoV6pbzijNEA@mail.gmail.com>
 <CADnq5_N8WgGpn15uBynApdkqJdnSaeOFXUyzpG8Q3_3iyHcK1w@mail.gmail.com>
Content-Language: en-US
From: David Rosca <david.rosca@amd.com>
In-Reply-To: <CADnq5_N8WgGpn15uBynApdkqJdnSaeOFXUyzpG8Q3_3iyHcK1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0267.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::22) To SN7PR12MB6767.namprd12.prod.outlook.com
 (2603:10b6:806:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6767:EE_|CY5PR12MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ef50fd-b6cf-4f61-13b1-08def6fb76da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: aCwKFGza6qAGTebPX4OY30SMf3YVOGx0kgxL3ErsanqFhSLAsPOip7ENXkEV8iDfo5nHYn3Nw/CeWKrH/7+OlNWq3QculLdszhqryxV5BeMMg90+XL4nSixgdUR92kAwLhw6nxeN0QC2A6GdQqrO73yXvaudlUobbDZk1ULSbbd1DVAuatBPKmfjN1LDeSuvf65aADY3u7LxMy2l7TCS5HylP5BXwihD3I7ujXwS6QVa77rIVQBXNiDjD9WUvrQ1Tw8f6FZO1IiQ/uxXVJVN9gixFOMQnTkzYRh9921R6u5VlxpH9Ov3TL0R6MOiNBLa3o4C4BIoMsF12UiRizmcK7cRw151artggWsPJMBSf3OwPt0hf+kRW6Ke3YZEFAnA2dbJauDWlOJw8lOBwBbXmOMbsVZlgLcVRLry02tvQU/MK4/5fXM7Kb5SB0oBceScN5CyQ+Y1NNB3JPmwFOY1/geEwmq3PYmcQt1H8hTZ5YzHLoEZUUtNaTfSShX6oIhkO2K3qTU+WsAX+zz+LafZCR8m9tG4ZQHQTy4vUqrmapzAWPvccnEv3VOZT23M8LWGYsvQvrmXCDdbXP3jvK9IWkunuCZPyWIYZ+r85hxzHccY8MVsMTd5WRWCBA9ac+V1OjtMlbx4RWhOb4493P7bQifcMCKZ4sMrLvmUpZikXZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlZIMlJnN1FKV0dGSm9NQ2JmSSsvVGhsZFpwRGtITjZNbjJoRWtyRnIxZ29h?=
 =?utf-8?B?QWZzZW0vNU5ZeVZCd3liWit5Z1FlMjd1Z0F5YTRKRFE2bU8zTnA2K0xZMFdq?=
 =?utf-8?B?cnBBSG1YZjVlOWtDbHZtaStMcVZVZW1XeGRDWVh1UDZybFBDNEVyMG1IZElH?=
 =?utf-8?B?RzdsTHgwNDhPaitmT2Z6NVFIVURESzZqdlhMbWhnQ0htNWRvR1dTK1JWZHdw?=
 =?utf-8?B?aFlCaGgwUEJIOUJoOVMzbzVJaWdDUXV1aVNEbEJRaHhSdEplODNMOTJ3Snh6?=
 =?utf-8?B?QUxpSVlpMHZONWFxcVFaM3N5cTZFeTIxbVJtOWhJcHh3SGdxWjJWaXd1VmVF?=
 =?utf-8?B?R09VZDFPanhGVDZ1b0dtV3NTeitWV1BOTS9FUUN6N2RZb0psb3ZKVFhCemZN?=
 =?utf-8?B?azFYMzdqRHNlejJ3MTBrT0J1Q3c2bVNEUkRkYjJHdVJPeGF2MkV1UklQZ21E?=
 =?utf-8?B?N2VZbEYzMmlTQWxRSWRIWkw4SFRYMXBDYXlwRnF6SjlwR3RaeTArYXhvNWoz?=
 =?utf-8?B?blUzalpJZXV5Y0p6QnZsR2xqaTB1bVIvMGdadTRNME9OMTFWTDJOUzdRZTN2?=
 =?utf-8?B?eDhmamNmS3pSNm5QRC84bDEyYXVmQnkrZEhSdSs3THFJbEY5KzFNalRQc2Rx?=
 =?utf-8?B?VVdZdDdETFVUdW9rbmR5SG9QamhRbHMrVURKUHV5T3hQYXpvZktPMlZERWll?=
 =?utf-8?B?YXZPa0hhZDI3d1pEMmd6WFB4dktpaFlsbWVxMWRYWHh0aHRvUllLMWlPTVkw?=
 =?utf-8?B?YXBaN05PMmVhekdwL3hpSjZ2TzQvY0xOazliNytrQk02WVJ1SC8rVTZPODFR?=
 =?utf-8?B?S0RTaVh2c1NqM1pLYmIzcFVZSzBuMnFDVFlGSGdrUmdWdzJ3L1BydElkUGFj?=
 =?utf-8?B?cmlDaVhLVHl4OEI4QVFkSGp4czRHR0ZwT0dKLzkzcm1WYTVBdURGOU1wUXAw?=
 =?utf-8?B?RDNOSG1USXN0dzl1K3hQeVd2akR5bW9NYS9KdFROeFZZNlhsWEE3OXIrK2xG?=
 =?utf-8?B?NmdhYm9KRVdPLzRsRWZLTVpnaHA1WU5HeWRNOVJnL0RncHRnNjBaVnpkWlRn?=
 =?utf-8?B?aktMa3QwY0cvcldTY1RUekNMTGlIdmkrVGxiL2pTZTZpN1hMRTcwbWl0OEZK?=
 =?utf-8?B?R3I3RUQ3NER2RGc3Z3BMYzdIc05IZWtpWTVkYWlCR1ZHV0h3WlFTeXBuMXV0?=
 =?utf-8?B?Rzl3d3hWREhBOHlEcW9WNjYzZy9ZcEgxL1lqODB1dm5ESi8waXpSUTU3L0Yr?=
 =?utf-8?B?SWdzUk8wWVowWTRML3FYUWZoRmc3ZnhSTUhkb1IxS0gwSDhkMStJWVZ5Qlhl?=
 =?utf-8?B?WkRDWlo4cVJYOGpmT0U3NElzQWJxNlArL01ST21DR25KRGFZRXp1cGZBYU93?=
 =?utf-8?B?cFRpTys2S1dmeEZhZXIrZ2dQWUZTb013ZG0reVhNMDdDWXh6cmswNFBIcElN?=
 =?utf-8?B?UEFlRGhHenlYMUM3ZC9LWHdNTXFtTmh4NFprZ3R4ZnA4YWpPbUFoSzhMYWVr?=
 =?utf-8?B?dld3M0dtNnNoT2tTWElpSVUvdC9xZDRpOW9Kd1h1a1dxcm9hSDRMWXdQRENL?=
 =?utf-8?B?c2ZJSnNUMHZLcjdZMVV2VlJqRGh3WDJBZ05UT3VxWXczczdKaWJDYzZlN09R?=
 =?utf-8?B?NmphM09mcjlZWnJsL0FBWGhDWWdzQ3JLSGNSN3QzSTNNYU9TZnZZTmdEZExr?=
 =?utf-8?B?eTZHRE9ncVJYZC82Tk1NcGROZnJDWVNMZGZyOFp6anM2NlQxODkxblMvTGMz?=
 =?utf-8?B?SEhETVl2YTRyN1plRi9iYWRYaHp2OExBSFJ6Vk94VkwzeTVJM0c4SUZnbVhR?=
 =?utf-8?B?UG1nbFVtb3V1OVc0VU53Vmt6SE9XeWVoSzBXNVdFc1VyUktYNFNBaFRNVzJX?=
 =?utf-8?B?bHdEMDVRekNsbGZmcHcrVFZHQ0lJZzFBb1dTSkhpQ1l2Z2FhNit1OCt5V1VU?=
 =?utf-8?B?V1kybXNVbW1UWEp5SC9QcVlLOG9VNUdVeGhEUE5tVlFITkZLS243M215a2pk?=
 =?utf-8?B?T3lQY0lKaWNVTFZiWDdQVUpYYlAzSjVSdFpWa3JZRUNxYm1zMmF6OExCS3Ft?=
 =?utf-8?B?eGVybUZrWllJVVRFNGVITUJ2MnZaWDFTd0ZsWCtGamQ3bWtNMXZ4Q3dVWnJs?=
 =?utf-8?B?SW1QYjFvNSsvZ2hMSmdicGNWNkhPUExOZ1BRdGxxSm0xRDVFYzZHejBMYjJ3?=
 =?utf-8?B?ZlNVSldaaXpKT0wxSVpjQUZBcUdDQnFoN0FpRzR2VG5lcWcyZTY0WGxaQU8r?=
 =?utf-8?B?eFppQ0ZTMEI4OXFFSGtYVmFxckVlaDErSXhRTEJXU2dPMERCdi93MERqSUdx?=
 =?utf-8?B?WnpaVWtrT2gxQ21FVzhlRGdZYk93c2MxZ2NHRjdmUUJxNGFvdjhoZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ef50fd-b6cf-4f61-13b1-08def6fb76da
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:21:42.6053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kK5+7e8ixHTx2T3pQRz+ORvhFA6pXMFF7eilm/9Bu3OxwQq5zOypGeGfHcWDqopnEfbkm0Iianve9eL6DRHUCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6060
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


On 8/10/26 17:58, Alex Deucher wrote:
> [You don't often get email from alexdeucher@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> + David
>
> Ping?
>
> On Fri, Aug 7, 2026 at 9:04 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>> Ping?
>>
>> Alex
>>
>> On Fri, Jun 5, 2026 at 6:44 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>> We shouldn't return early if we need to emit spm update.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

It may be better to move
+       spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
from the 3rd patch here.

Reviewed-by: David Rosca <david.rosca@amd.com>

>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 7e0e2281719b1..13031e4b6f1d5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -809,7 +809,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>>                  &job->base.s_fence->scheduled == isolation->spearhead;
>>>
>>>          if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
>>> -           !cleaner_shader_needed)
>>> +           !cleaner_shader_needed && !spm_update_needed)
>>>                  return;
>>>
>>>          amdgpu_ring_ib_begin(ring);
>>> --
>>> 2.54.0
>>>
