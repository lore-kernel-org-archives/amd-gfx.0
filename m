Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8AFC44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 11:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A83F210EFE5;
	Wed, 15 Jul 2026 11:50:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P2P4M/c2";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AECA10EFE5
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 11:50:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rULC4oHilUxeYWVk8MxooxvPnw8TNEfWPCA5LwetrjjMsb0KsNvW3o6Lp8b04aK2z+vtyq0DGaZKFqjz6ZEKtDtC9IJ6P75TfMaAys5X4vb9Kv3D1QYbL9d8lfU2FFKDggq8qxNSkU0NNKNwn4hMvC/k6sgx7DOq9MUDforAIEmOLk9v52bv1WYBwiru1dDwj31d4IBcqtPVbYC7O7SNe1qx2IPj6egSB6aLl1E11Yqy/e6kJmAFvrG17Gmb+IYRo7AbZ2WP2t7/YZQ/mFqkZnSvvJV8bqiO3wmKsDX5wADKcnAzaetBg1Gzf6H0VXDQQ82R0CgwrIuPhy5+TDbbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6s+62jPzPZxdCS2fMkJGnK4QRK9KLKd/XJn9MQEKS4=;
 b=pQPxf8V0hut97lbpeYlgWCq/sFGlTaOz7+ZKjbC5dVc2Rfysopd/xuHZ/asaj7+N1s5seuIh4xcJVlr4xZEZZoegsl0MVug5kWp+6VzmddnXe8VMzurcZ6CLkWafEmLtNSOwzh/N5r6qqoW0PxdpPobB9QKLux+FRXh2n8fO40ovok3EcGnAM9PKYNHJ4dCOylgy8fLuEy49rjCu+lWT4gR+gT2UjSA5HWmlbDwLN3Iw6/bVExx40CRI5RtOqU827AqRIBo+m6N/R17KbiHR/Y3foVcCk5wo4QgLhq8tNUB0w0bWe6tD7FLg/7CLeYU1n1bhWjqynTVuOpccVcW2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6s+62jPzPZxdCS2fMkJGnK4QRK9KLKd/XJn9MQEKS4=;
 b=P2P4M/c28qqWVvckt4xkr2RLfBZJxcVUJC89KOQl0lBHGSWwhaOKHzVdof2kLlf8iXjXcG7Z/CpdQFur5wUgTATFDY8ONRUhe5VzW5yqhL8WUVYne99lgZtGRh+DFeX+YG+D78b4wFhOiEYh/Z3LOb6QhepQ7qYPwP6ZnBL4xXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7841.namprd12.prod.outlook.com (2603:10b6:510:273::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 11:50:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 11:50:14 +0000
Message-ID: <2e878f24-7e93-4236-b96a-802b5fda5d8f@amd.com>
Date: Wed, 15 Jul 2026 13:50:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] drm/amdgpu/gfx7: Fixup emitting SWITCH_BUFFER packets
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tursulin@ursulin.net>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <20260713125838.30607-6-timur.kristof@gmail.com>
 <fb4f5735-2ccb-4a75-8d69-d776b3f3bb84@ursulin.net>
 <7296917.jJDZkT8p0M@timur-max>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7296917.jJDZkT8p0M@timur-max>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddd5052-3b11-4fe2-e55c-08dee2673b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|3023799007|56012099006|11063799006|6133799003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MOui8StPC2kBXhJNoutYZ388vVQzfoS2O5MsDfBg/Ri2OgszvuyeR9TZ2UtBa/2atc3/gRLNOAja9N2QAjRMkENC3FdxTfpRLhdQkaTmPmC2iziHhrOcj50EXbxzBWfmjJ4G1DudHlpndoB39iIF0+QjriieS5S9oQaVQk8xJEr+nnp2jzbzf3p9WD3/4tY0Qlfvxl8qEEk1c+QMhUmmmUg/RB4QilxBh2eMDXB4wfx8eReovyckxZ3dNMI39aOQlAFcOmPJIanSKoXTQwa93P145k5Xnue2qORF6cCmuNez1y+Bd/57OjZTqi80aoRnAxJtQr2Gv6xPKnMUMh1OV9ZuJ1vtu9u//329tPmZNGHh72sleD/5yZ4EIzc3iXAFOi0vH7NKL/MfVYbkVFTEyezD+WCOEStXPV9uPpTfa3PWhM9n+HxgKzNMNEHHariGbp0WkzOmmamOZdATkg7z+UvdEnQlQU8ZYxRXDQQJeRWsqB1UvmfH8zBIAufJzDjQkQY7DzT6QNkfbfl1GZTNDcBWYPxd3/typUj76XfT3xyuCDD6QOWG4e0kTEjHYxbR4s2vuwmi8U8OU1Qxw612kf6EklLa1ll0vidnDsWrnEWzJ5va/zizyqjocHZA1fvXT3qouHysTaGJR9UIPA+eVbqDnH8aTxH+wJqrSXS3XHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(3023799007)(56012099006)(11063799006)(6133799003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHRFVmRZWUh3Nys2YTdUelFYSDJyRDJQa2JNZTZzSEVsU2lBdm9lMFpDWGJl?=
 =?utf-8?B?ZFF2QlNuMGNZZU4rVUM5c3lqNlFoRG05M215RWI2dWltYndtRHo1ZEFDVHRw?=
 =?utf-8?B?MTdBWE1QUEF1ajN6eHZaL2ZKRkdHQ1MyNzBBbGRmOWhOMXBlYUlRRml2cHB0?=
 =?utf-8?B?TjNhSTJkeW5TZ01WZkhRNjRza3dpUnd4aHNMRVhBSG1xQzNWL2dKUXJaRzVL?=
 =?utf-8?B?V2NZMGI0RHVoMVpzQXF6NktyR1JoOU8xL1dlVHJocUVkZEd0M0IvYVMrS0Rs?=
 =?utf-8?B?WEpvNHFsRHYwZ0M3cnRjV1FhTVAxMnlMYlB2VkRQaXZDemV2dE02a0Q1VUJ2?=
 =?utf-8?B?OGhIVmpkTk0rTllQaDlwTFRhZGp6cWIrcmtVVzBOMWNGNklBSDlEMzFxU09X?=
 =?utf-8?B?bXczR0tTU21aV2dudUcxUTFvWloxb2tFS3dJOEF2M2VFNTdXR2tIbWtEN1Zn?=
 =?utf-8?B?MFFsNnM4L0dEOUFTV0djam04K0RoblRkd0hkb0d4N1QvL2ZZR2dhTUlsNGY0?=
 =?utf-8?B?RUNoZEhGNjJPVGZRN3hHM3ZnWDYxemwxS3Z1YkNaZXZaQktSQ1EzUTQrSm9P?=
 =?utf-8?B?UTZaNVNPaFBuNXNOc0phM3NvVW5hcGMvdjBKbGJMdzkya1JkVEs5QlhRcUt2?=
 =?utf-8?B?VTIyMGQ2S1BMZUphK29yQW0vajFFaTRxa2dhQmd5UllhSmVkNzdJZjVPb0RR?=
 =?utf-8?B?bXZvVG53RFo5dFh0QVNOQ2VtUEVVa3NRZ055R296RUVqa0JrY3VHUUVVRXVr?=
 =?utf-8?B?WE5naVBKNENONmZHa2E2SWY1SmhsNUhIZTZWL1VTV09BYmdGbWx1bWV1ZktL?=
 =?utf-8?B?azMyYmdRbFczbTF0N0hxQngxRENyK0UvTW9kNy9TYnhEZUN0TldDRnRTbzBX?=
 =?utf-8?B?M21NTDFXYThGaU9lUnZwWTlRUmlYa0JobjlhZ3VUcFNpT2lsb1NGZUU3TDR4?=
 =?utf-8?B?dXpxUlpSOTIzRUMxdTVZWjVqcHpzbU5qUGg4cHh4RW44S0cwRjlscjUvZmdQ?=
 =?utf-8?B?R0NDa3dkMjRGWlc0TzRRUjFNbDR0akJiZExISTJzT2ZWbW1FTEhFc3Jpd1lt?=
 =?utf-8?B?ZDdmdDFTMFBaSUdhbGswUlJySG5YYUZKYXBMdzRPcVk3eGRXN2lnR3MzYmow?=
 =?utf-8?B?SlFrOTVJd08zRjdKdzc0TytodS9nV1RPS2UvZ2xOdExxdFluK2VJNWZTOEdQ?=
 =?utf-8?B?YXFsRGNjY2ZadkxLejRJMFVjYXloSXppbEMraEF6TDJxR1d0WkozZ3JCOTlR?=
 =?utf-8?B?bFlxR083UUJVNUZNVTFvZlZ0dFFsb2dPVnZERW9RUTdrcGdZWVIvUnZ0dTFp?=
 =?utf-8?B?U25BeGpPUTdmQ1Y3V1I1bmE3cnBycXVMWC9BWGNDdGgvTkYyQVA3QURkTkFW?=
 =?utf-8?B?cjJISkd0QXF5bXdHZitvbEs0dlFncXNVS2R2Y2REM09sQnE4NFRJNHZ3ek5R?=
 =?utf-8?B?SU5tam1pamJabm94Sk5sd0dMdi9JZlBRdVpSdGRiMFIrbUp3VXFnK1hXMHpi?=
 =?utf-8?B?SUZXNnFoWlRmTXJwalo1N0QybUw5UG5LcERpZG5DWklHT2pzcThXd1E0TXdy?=
 =?utf-8?B?dDBOaW9zWmNRQVR2RUFmZzdtSk1BeXUzWEUxc2hkMm9iUytvV2RicUV6bTZ4?=
 =?utf-8?B?cHlTWFI1UklEb2ZYL1MxQlhYY1I3NTdiaXFoWWtNdit3NE8rN0NUSFNaWnho?=
 =?utf-8?B?YzBPd0hFa0pabzE2VzYwLzRsTlprT1VLNjVZNmhiV2loWHlkRmJXUmRQMnVj?=
 =?utf-8?B?OVc1QnZRZDgzNzdoRlQ3eUZxd28vNjNpQmtYNTdYTi9mQkk2aEk1eXlvYm5s?=
 =?utf-8?B?WUlPQWxqZ0tMOG5ZTzBjQnNHc25vQkZna3IrWEcvb0svN3h1Smc5OEdkOXFL?=
 =?utf-8?B?VmJQdlZtZGx3aDZoTVJ5TlJCMVlZVXFsRWJIYXRkTElOd21JZmQ5OXhBYnI5?=
 =?utf-8?B?eTlEclJLQzJsdzcwNVZFWWpwTDQ2T2ozUFZXM2dWRzVBL1M0UldTNS9mRkZj?=
 =?utf-8?B?bk1FeTVVOTRhK3p2UmZheklzWlc0NG1xY1NyS2ZVdGJpRDc0TWw3Sng4ZjJo?=
 =?utf-8?B?bUJGTnZsOENFOHJrbjAwZG9UUjZ4ZCtCTnAva3ZBS0tRQnpEM2Mrc0hlK0I1?=
 =?utf-8?B?Zm5qanRaaEUvTDBFUXYvUHcwcmhqNTBQN1lsVWlSVDhLMHpUYmg2RXpKTTAv?=
 =?utf-8?B?OStkUVZJMVdMOGNBOER6dTBXMXd3aWtPODJIcXBSc2pnZzdUMFRRSDFhQzhX?=
 =?utf-8?B?TU5rdTY5eHlDWTZZdDI2dTFiQ0tPREJUdUN4UXRmRFBEZFQxZWI5czlnMnd2?=
 =?utf-8?Q?4UwuGmfXYd1c5s5Dhb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddd5052-3b11-4fe2-e55c-08dee2673b56
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 11:50:14.0107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFGq2IMV07pCxVNpOcXCmC6HQHvJSbk+sFUMVlbnjtAd2wyJh7jTxdSDYidjGBtS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7841
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

On 7/15/26 12:36, Timur Kristóf wrote:
> On 2026. július 15., szerda 10:56:38 közép-európai nyári idő Tvrtko Ursulin 
> wrote:
>> On 13/07/2026 13:58, Timur Kristóf wrote:
>>> Implement the emit_switch_buffer() function instead of emitting
>>> them duing emit_ib, emit_pipeline_sync and emit_vm_flush.
>>
>> during
>>
>>> Note that it isn't necessary to emit these in both
>>> emit_pipeline_sync() and emit_vm_flush() because
>>> amdgpu_vm_flush() already calls these when calling
>>> either of those functions.
>>
>> The amdgpu_vm_flush indeed does emit two switch buffers:
>>
>> 	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC 
> */
>> 	if (ring->funcs->emit_switch_buffer) {
>> 		amdgpu_ring_emit_switch_buffer(ring);
>> 		amdgpu_ring_emit_switch_buffer(ring);
>> 	}
>>
>> Comments are different though:
>>
>> /* sync CE with ME to prevent CE fetch CEIB before context switch done */
>>
>> Are you confident the two emissions are about the same thing?
> 
> Yes, I'm confident. One of the comments explains why the SWITCH_BUFFER packet 
> is emitted, the other one explains why it is emitted outside COND_EXEC.
> 
> This packet is interpreted by the CE (constant engine). The reason why this 
> packet is emitted is basically to make sure the CE can't start executing 
> packets from the next submission until the current one is finished.
> 
> (Note that CE is not utilized by any maintained userspace driver and is 
> discontinued in new GPUs. As far as I remember there were experiments to try 
> to use the CE in Mesa but it didn't yield any noteworthy perf improvement so 
> we just never used it. The old proprietary driver may have used it. It is now 
> also deprecated in the kernel.)

Absolutely correct, yes.

We could eliminate the whole switch buffer packet if we completely deprecate any CE engine support.

There was just exactly one Mesa release which made use of the CE engine but I've disable the CE support and put it behind a debug option quite a while ago.

If nobody complains in the near term I think we can make nails with heads and just remove all the hacks we have for this.

Regards,
Christian.


> 
> 
>>
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 32 +++++++++------------------
>>>   1 file changed, 10 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c index 0ceadb107d26..a93cc02c3400
>>> 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> @@ -2201,12 +2201,6 @@ static void gfx_v7_0_ring_emit_ib_gfx(struct
>>> amdgpu_ring *ring,> 
>>>   	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>>>   	u32 header, control = 0;
>>>
>>> -	/* insert SWITCH_BUFFER packet before first IB in the ring frame */
>>> -	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
>>> -		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 
> 0));
>>> -		amdgpu_ring_write(ring, 0);
>>> -	}
>>
>> Commit message does not explain why the change of ring buffer command
>> this creates is okay. Current flow is:
>>
>> amdgpu_ib_schedule()
>> {
>> ...
>>    amdgpu_ring_emit_ib
>>      amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
>>
>>
>> New flow is:
>>
>> ...
>>    amdgpu_ring_emit_ib
>> ... other ring commands ...
>>    amdgpu_ring_emit_switch_buffer
>>      amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
> 
> No, that's not what the new flow is. If you check the callers of 
> emit_switch_buffer() you can see that it's called from two places:
> 
> - amdgpu_vm_flush() emits it before the first IB when necessary
> - amdgpu_ib_schedule() emits it after the last IB when necessary
> 
>> Is this okay? Specifically due the above comment saying "insert
>> SWITCH_BUFFER packet before first IB in the ring frame" - is the "first"
>> part not important?
> 
> amdgpu_vm_flush() emits it before the first IB.
> 
>> Also, amdgpu_ib_schedule only emits amdgpu_ring_emit_switch_buffer if
>> there is a job. Currently it is always emitted.
> 
> I trust that the GFX8+ implementations are more precise and that it's sufficient 
> to emit this packet in the cases where the emit_switch_buffer() function is 
> called.
> 
> When there is "no job" that's a special case that is only used during 
> initialization (specifically the IB ring tests). In that case we are not 
> executing commands submitted by userspace but rather commands generated by the 
> kernel. So we can be sure the CE is not used in those cases.
> 
>>
>> Final interesting part is how amdgpu_ib_schedule clears
>> AMDGPU_HAVE_CTX_SWITCH after having called amdgpu_ring_emit_ib.
>>
>> After this change only gfx6 remains the user of that flag in
>> gfx_v6_0_ring_emit_ib. Everyone else only use it in emit_cntxcntl. If
>> gfx6 was adjusted too (later), amdgpu_ib_schedule could reduce the scope
>> of that flag to just the scope where it calls amdgpu_ring_emit_frame_cntl.
> 
> I also adjusted the same thing for GFX6 in the next series.
> Can clean up the flag later once both series are accepted.
> 
> 
>>
>>> -
>>>
>>>   	if (ib->flags & AMDGPU_IB_FLAG_CE)
>>>   	
>>>   		header = PACKET3(PACKET3_INDIRECT_BUFFER_CONST, 2);
>>>   	
>>>   	else
>>>
>>> @@ -2258,6 +2252,12 @@ static void gfx_v7_0_ring_emit_ib_compute(struct
>>> amdgpu_ring *ring,> 
>>>   	amdgpu_ring_write(ring, control);
>>>   
>>>   }
>>>
>>> +static void gfx_v7_0_ring_emit_sb(struct amdgpu_ring *ring)
>>> +{
>>> +	amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
>>> +	amdgpu_ring_write(ring, 0);
>>> +}
>>> +
>>>
>>>   static void gfx_v7_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t
>>>   flags) {
>>>   
>>>   	uint32_t dw2 = 0;
>>>
>>> @@ -3111,14 +3111,6 @@ static void gfx_v7_0_ring_emit_pipeline_sync(struct
>>> amdgpu_ring *ring)> 
>>>   	amdgpu_ring_write(ring, seq);
>>>   	amdgpu_ring_write(ring, 0xffffffff);
>>>   	amdgpu_ring_write(ring, 4); /* poll interval */
>>>
>>> -
>>> -	if (usepfp) {
>>> -		/* sync CE with ME to prevent CE fetch CEIB before 
> context switch done
>>> */ -		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 
> 0));
>>> -		amdgpu_ring_write(ring, 0);
>>> -		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 
> 0));
>>> -		amdgpu_ring_write(ring, 0);
>>> -	}
>>>
>>>   }
>>>   
>>>   /*
>>>
>>> @@ -3160,12 +3152,6 @@ static void gfx_v7_0_ring_emit_vm_flush(struct
>>> amdgpu_ring *ring,> 
>>>   		/* sync PFP to ME, otherwise we might get invalid PFP 
> reads */
>>>   		amdgpu_ring_write(ring, PACKET3(PACKET3_PFP_SYNC_ME, 
> 0));
>>>   		amdgpu_ring_write(ring, 0x0);
>>>
>>> -
>>> -		/* synce CE with ME to prevent CE fetch CEIB before 
> context switch done
>>> */ -		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 
> 0));
>>> -		amdgpu_ring_write(ring, 0);
>>> -		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 
> 0));
>>> -		amdgpu_ring_write(ring, 0);
>>>
>>>   	}
>>>   
>>>   }
>>>
>>> @@ -4954,8 +4940,9 @@ static const struct amdgpu_ring_funcs
>>> gfx_v7_0_ring_funcs_gfx = {> 
>>>   		7 + /* gfx_v7_0_ring_emit_hdp_flush */
>>>   		5 + /* hdp invalidate */
>>>   		12 + 12 + 12 + /* gfx_v7_0_ring_emit_fence_gfx x3 for 
> user fence, vm
>>>   		fence */> 
>>> -		7 + 4 + /* gfx_v7_0_ring_emit_pipeline_sync */
>>> -		CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 6 + /* 
> gfx_v7_0_ring_emit_vm_flush
>>> */ +		7 + /* gfx_v7_0_ring_emit_pipeline_sync */
>>> +		CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 2 + /* 
> gfx_v7_0_ring_emit_vm_flush
>>> */ +		3 * 2 + /* gfx_v7_0_ring_emit_sb x3 (from 
> amdgpu_vm_flush,
>>> amdgpu_ib_schedule) */> 
>>>   		3 + 4 + /* gfx_v7_ring_emit_cntxcntl including vgt 
> flush*/
>>>   		5, /* SURFACE_SYNC */
>>>   	
>>>   	.emit_ib_size = 4, /* gfx_v7_0_ring_emit_ib_gfx */
>>>
>>> @@ -4969,6 +4956,7 @@ static const struct amdgpu_ring_funcs
>>> gfx_v7_0_ring_funcs_gfx = {> 
>>>   	.test_ib = gfx_v7_0_ring_test_ib,
>>>   	.insert_nop = amdgpu_ring_insert_nop,
>>>   	.pad_ib = amdgpu_ring_generic_pad_ib,
>>>
>>> +	.emit_switch_buffer = gfx_v7_0_ring_emit_sb,
>>>
>>>   	.emit_cntxcntl = gfx_v7_ring_emit_cntxcntl,
>>>   	.emit_wreg = gfx_v7_0_ring_emit_wreg,
>>>   	.soft_recovery = gfx_v7_0_ring_soft_recovery,
> 
> 
> 
> 

