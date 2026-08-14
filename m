Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7561EC5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 15:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D25C10F67C;
	Fri, 14 Aug 2026 15:13:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ypTYF/CX";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B620610F678
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 15:13:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBQ8TWXEnsuOEYHP3DEHd8ikw0WxB8FYAqMYixsjyx1DpWW/3Pbo0fLO4XT4HXpQrirzIg90dgMbdJWM2BroiL6W1WoWC3BPCIDdf3v5Q2EL8D6aTRSh3/E1JUKYqUQGoxKjSqqek1nfjx6aQcNa7gBfegBeQ156Lv9XyesGgh8hgjcCwPm3qVQhNAFoHkliuPXch8ZGBimurvz7w4S2aUqoKWAiwZOqYjCPKSHp4jIBnqwkkMd8QtWX7YPHsaqQuLepCNnS2lUXGzvWyqTMdD5KsHLc2YvWR2snlahORCMTVKB2J+S8CZw8n3qgKiUyVBtCAwiKiMI+AzOOka9TPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWXsy45A3O+ccOV30a3VJr0PtDqqGZ/huYCOUDdNsWA=;
 b=Nv1xg4e3DZd7RutUxtpM6WBvbF7z0Q93nbqUitp+4IOrBwQEaeyK0yUv0DnccseSSLg3YRg0O6jr32tOsnqaGUKO/81CAWhW+Ot9MFHZlW5Oca21QK/ycyZnBl9PeTYlvPVgbUC472WG0Nk3dA2u5/S7hN2Ge4sieF1GdKgvxMmIL1yHQAaPXGyiSb4jczD9p1uGn6CcVAaoKC6PjaoD/eHAvTw3+JnQuyWtrgbptQDh9tCFzEZEC9cEHeUjUsd8EO/rx8Y8nHCz2ppVJhlvZJjn/rNkLiq/sAMZzM3kSKm7cz+yM/kvfdsR569X7cfyvVZw533KCBAAs0i5SEofzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWXsy45A3O+ccOV30a3VJr0PtDqqGZ/huYCOUDdNsWA=;
 b=ypTYF/CXDxesvOl/drf6VwYp3DHv5k4o7AjFmYT8oJoKyA4E4YhbQf2SOwWAQapihIu6/lskpyZV5rNtjOxc3/eV90UGEr2JTZaex8w/jHbgnrrgZLZkoIQ4pg38urDEETP9P9BdHWsscPRokUb6jZkryCyEp+4zQaMRwtJOmmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 15:13:50 +0000
Received: from SN7PR12MB6767.namprd12.prod.outlook.com
 ([fe80::ef05:8207:37d5:53]) by SN7PR12MB6767.namprd12.prod.outlook.com
 ([fe80::ef05:8207:37d5:53%4]) with mapi id 15.21.0292.024; Fri, 14 Aug 2026
 15:13:49 +0000
Message-ID: <53b535e4-c078-421c-9dcf-930220926465@amd.com>
Date: Fri, 14 Aug 2026 17:13:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu: Implement insert_end for VCE 3"
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260814145448.11178-2-david.rosca@amd.com>
 <CADnq5_PL-XC6_Y2au9OQxsD6xRm4dYqPX0xGh7PeLkHHTDf0FQ@mail.gmail.com>
Content-Language: en-US
From: David Rosca <david.rosca@amd.com>
In-Reply-To: <CADnq5_PL-XC6_Y2au9OQxsD6xRm4dYqPX0xGh7PeLkHHTDf0FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::27) To SN7PR12MB6767.namprd12.prod.outlook.com
 (2603:10b6:806:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6767:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: d39d7766-42fc-4e0a-e269-08defa16a4ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|11063799006|4143699003|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jbvk232b4GsxqO4+7BuoaP41OmCq81sHz6nsEywHU6+kVlOsdCDUOOvS8i5Qwp4X1xhCfZ71HOFNTDYJzW3ldwrApFlzVrIIOVCpPsYXNGBonXKxU0jyE80T/9gEwNukUwdtDDuAbmV8LusBcoLLzFciCMWKdPOO7Ahewz+kBMBAklJcy9f/+XBTNI/fV4YpB1/h6PF8RCKoko7Ea/prm0q3QeRd90gC9Au/hZXCRGpRE1gjku78eUA+2z9qgxDhI58E9ku5MdDTtQScMZcIcQ876S6LQpeEh9ByWit/nmZNxuqNwqbqh26wDVugOlv1TsptCXeSUQoED/TmLYncjJuY1djBXaZP8gH8fOKpx0VSwejjzsJJUjyX0+ZzEeGK4TeHwANExWx5MVKBuxqrlYnmhqtpJBVUAgp+8yNdd04sITw3ymN+vM+F5/D3L0+P5w4AAytPwXKNH/9dGwKppAXt1eZuKx7Y9QAi/BsOIaldmo1vWoImql6UhbnPxlVJvHLjpElr0zw1hj1NJSo/VEM0fpb5bgX4wzV90OypfaaN0q6r6d6OlLz7RJtWwpbq7JKoT/j0Il6f87R8R8WWugGBT+3Z2/H/qzSq6JZkOQgmq6mIKBFRkLd4IkMO/E9dY8BTPVnOt4EUXMOqYaYUYk2E0uSARiQr3TSqRojIBEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(11063799006)(4143699003)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE1iQkFuSStZVDRRYWlyNWZqTWY1Z2piUm40R3luQlpXcThLK1dGckw0YjJw?=
 =?utf-8?B?YjFid0pyM1d3bjVjY0M5cEFnV2lHelVkdndFeG42YkJSM2xQWE1xcmpRa3Vq?=
 =?utf-8?B?R2RaR3dpdG9rUlJUTjNKczlmRXRLMG5tb2N3VkpXZmk3dW8zeGFGckFzaEdr?=
 =?utf-8?B?QVJ2M3JidTAxejgxS3RuV0RxR2dTM0ZibW95T1F4c0Z3cyswdGhtSy8zK3Bx?=
 =?utf-8?B?TSs1dDBxamg4RXRKSGhwR0FCZStNRlo3QUhBVFJ4U2hJVXpqNm1senNWQVVS?=
 =?utf-8?B?dFBncFEzQytGbHVrZ3ZDUUJqaEtjeW93YTRHc3ZOL2pBeGd3RnBnaWZCTXN3?=
 =?utf-8?B?RXFDMzRHd2ZVOUxIb2dxM2RtYlZkWjZseDFOOUg3QU5RRldqV3Y0d1pRMm5W?=
 =?utf-8?B?clF3ZGprajRQMWxiTWE2L05SbS9ZRlorWVFFQ0FmWjBBRnU1Q2lSZUplS00w?=
 =?utf-8?B?ZkdvL2YwSmJ4Wkxic3ozazRpVUdlbWtjTGZBSzRGYUtYYnl5dE1yL3pWRUgw?=
 =?utf-8?B?Y2JGL3VRQk9ucERuN1E0RGU4Z21xWk04eGViZXRqVUducWR5Tmt0a2ZVYzcr?=
 =?utf-8?B?b3BvUlF1U0RWRVJDd3hWblpXVDVzUmZaWEF1aFhiT2FjSXVtUDJhTk9KUzdt?=
 =?utf-8?B?a0hBL1NGUTlNWTlUcEZ3cjBCK1ZMN3Z0S0xRNVovRjVkdVhNemxnQkxqS01S?=
 =?utf-8?B?MXdzeVdiQlRyS09pbUZ1TXZWcndjQkwwTWU0elBYVnFQUnFKbFV1czMyL3Ja?=
 =?utf-8?B?cG1aUkVXV1FubE1OUXNQNUdUTnVzSDVXUHRrak0wbFFUZ3dGU2QvTUtyejN1?=
 =?utf-8?B?aHpHWE9obGtxRVNDL2xmaldpZk1kNzVaQ2xFUkJjdnNEdFFCb2JGYmxrclNW?=
 =?utf-8?B?L3hoMlI1c0E1a1pkL3g4V0lkK0lLMFhuNGc1SzdtaXdiTHpwb3pyQzFzOURP?=
 =?utf-8?B?QU5OaXZTWGtkb1VRTjNlSlh1Q2F5RFBqN2U1V1RYTmg5VUtWdEI0Zm0rTVY2?=
 =?utf-8?B?RmJrRTVmdUIzU1RhWFplL1RKNTE3bTgremcwNUxoek9kWm1ScFI1NkJZZmZQ?=
 =?utf-8?B?TkpIeHU1QVgvN2V1Tk1JM0UxREFmbmdqYncvTlJZUjhyYUQ2eGgwVDU2NWdL?=
 =?utf-8?B?Z3lzNzZOVVRLQkF5NmZpZXdXRG1jdmdWSXNlUy9lOXY0V3d6cEtkblo1djYv?=
 =?utf-8?B?WlExOWhIemp2dXVFSkh0L1JvNnNtc2t3WHN2SmV3MU9haWJnT2l0L3UweWVD?=
 =?utf-8?B?R1NaR0xjYlgzUDBlWEtXMngvM1h3SzNyYy9HdXhvU1phYlFFM3E0UEhQMnBk?=
 =?utf-8?B?NENJeEhBUzJMeThTN3lpODRxa2xMcnl3VFpQbzZQcVN1NS9zYzFncTJFNm5M?=
 =?utf-8?B?UnFaQkd1NVNuU2VZT2xQOVdlSkxZSmRWQ3RlS0MwVFFYS0Q0RldPTC8rZHhw?=
 =?utf-8?B?N2UyV2dBY3phYi9QRXI0eG9PaCtoYldkTzhXTVhNSFhILzByNGJKcnQ2SG1K?=
 =?utf-8?B?S1BkMlZqcFpOdWFOakxscW44NEsvSFVvZ3lWMXRFSVdyV095alhJSW43NmRK?=
 =?utf-8?B?NUFQUTdWc3JLcEcvSTZLLzFxeXZZMWRWNUl2VTg3RmZCOUJKd3RqMlo5Skov?=
 =?utf-8?B?RHE0MGZWeHVuM2QwRzVQYVBKWHRlbEN2TnUyb3piVVNpUnhEZ1ROK2JDeGZz?=
 =?utf-8?B?MzZtR0RlK3kxYnJCYkdmMVFBd2NCWDc3ZXNPRUFBeVVqc29aRlVWdDBZa3p1?=
 =?utf-8?B?TG5FTk1KTEx0V3RZbXcvS0lncXBxZU9aNzFSUWluL3RiL2U3VUIvbnpMRTRS?=
 =?utf-8?B?bmw2aTlhT1N4U045YkVFeWdCUnRMTnBPY0NXd0dxOGlNTlN2U0d0WklqdHov?=
 =?utf-8?B?TlZtTzhNVWI3bVY2bXhlTEl6TTRFNUNDc0ZBSlVKMExaY0dWTUtJZDZlTU4w?=
 =?utf-8?B?ZUlDdm1PeGh2Y2lGQXBDL01KbGVkaHVKS1pITFh1K081MzZPVWJJbjdpcy84?=
 =?utf-8?B?SGM5Qy8zTG5OMzhrY0RsVi9iNVVMZDRkSUN2NC9ZZURFaE9qdUtOc3BldXdR?=
 =?utf-8?B?WktVdHB3cW1PamU4dkhvS09iWjJjZndMVkoxMWk0ZFYwdXpqL2Y2MnNWUTJ4?=
 =?utf-8?B?dE0xend4VFpMRFluVWdmODVyNURqNzZ6ZGM5T0JMUmozd0ppR2d1VkpaNlhW?=
 =?utf-8?B?WUIvVGI4elkzNzRvcWRFclg0YnVlbDdMOGpHdFRtaEhjRkE1K3d6NjZwZFdu?=
 =?utf-8?B?cWlyNGRBQmorZjF5MnNWczhiU1RKa0FwT2orOFJNN08xQVU3N0oybnRmTFdC?=
 =?utf-8?B?REtONHYyVHluK1V4eUV6UGRWUzhCZnU1WWdZS1BiejJkQlk3bUhOZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39d7766-42fc-4e0a-e269-08defa16a4ab
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 15:13:49.3787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycyv36iowVhY9w58UwOe9f8atOxLgiFdmdvgXlDUT0+NDdyi95+9yDcXEi+I2rk5IxeadLPAOlZxUpn9v5E9cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
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


On 8/14/26 17:08, Alex Deucher wrote:
> On Fri, Aug 14, 2026 at 11:05 AM David Rosca <david.rosca@amd.com> wrote:
>> This doesn't solve the issue, VCE still hangs in some cases.
>>
>> 4959138b6461 ("drm/amdgpu: handle GDS and SPM without a VM fence")
>> fixes the regression, originally introduced in
>> 83a8dee2bdfb ("drm/amdgpu: always emit the job vm fence").
> This doesn't make sense to me.  GDS and SPM are not supported on VCN
> in the first place so they would never be emitted for VCN.

The issue was the extra fence when only pipeline sync was needed.
With 4959138b6461 ("drm/amdgpu: handle GDS and SPM without a VM fence") 
the fence is not emitted in that case.

David

>
> Alex
>
>> This reverts commit 7591335141a06d5b176510054576d9c64519f348.
>>
>> Signed-off-by: David Rosca <david.rosca@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 26 ++++----------------------
>>   1 file changed, 4 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> index a9497e2e07f7..9f4e88440c0a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> @@ -809,23 +809,6 @@ static void vce_v3_0_ring_emit_ib(struct amdgpu_ring *ring,
>>          amdgpu_ring_write(ring, ib->length_dw);
>>   }
>>
>> -static void vce_v3_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>> -                       u64 seq, unsigned flags)
>> -{
>> -       WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
>> -
>> -       amdgpu_ring_write(ring, VCE_CMD_FENCE);
>> -       amdgpu_ring_write(ring, addr);
>> -       amdgpu_ring_write(ring, upper_32_bits(addr));
>> -       amdgpu_ring_write(ring, seq);
>> -       amdgpu_ring_write(ring, VCE_CMD_TRAP);
>> -}
>> -
>> -static void vce_v3_0_ring_insert_end(struct amdgpu_ring *ring)
>> -{
>> -       amdgpu_ring_write(ring, VCE_CMD_END);
>> -}
>> -
>>   static void vce_v3_0_emit_vm_flush(struct amdgpu_ring *ring,
>>                                     unsigned int vmid, uint64_t pd_addr)
>>   {
>> @@ -835,6 +818,7 @@ static void vce_v3_0_emit_vm_flush(struct amdgpu_ring *ring,
>>
>>          amdgpu_ring_write(ring, VCE_CMD_FLUSH_TLB);
>>          amdgpu_ring_write(ring, vmid);
>> +       amdgpu_ring_write(ring, VCE_CMD_END);
>>   }
>>
>>   static void vce_v3_0_emit_pipeline_sync(struct amdgpu_ring *ring)
>> @@ -900,19 +884,17 @@ static const struct amdgpu_ring_funcs vce_v3_0_ring_vm_funcs = {
>>          .set_wptr = vce_v3_0_ring_set_wptr,
>>          .patch_cs_in_place = amdgpu_vce_ring_parse_cs_vm,
>>          .emit_frame_size =
>> -               5 + /* vce_v3_0_emit_vm_flush */
>> +               6 + /* vce_v3_0_emit_vm_flush */
>>                  4 + /* vce_v3_0_emit_pipeline_sync */
>> -               5 + 5 + /* vce_v3_0_ring_emit_fence x2 vm fence */
>> -               1, /* vce_v3_0_ring_insert_end */
>> +               6 + 6, /* amdgpu_vce_ring_emit_fence x2 vm fence */
>>          .emit_ib_size = 5, /* vce_v3_0_ring_emit_ib */
>>          .emit_ib = vce_v3_0_ring_emit_ib,
>>          .emit_vm_flush = vce_v3_0_emit_vm_flush,
>>          .emit_pipeline_sync = vce_v3_0_emit_pipeline_sync,
>> -       .emit_fence = vce_v3_0_ring_emit_fence,
>> +       .emit_fence = amdgpu_vce_ring_emit_fence,
>>          .test_ring = amdgpu_vce_ring_test_ring,
>>          .test_ib = amdgpu_vce_ring_test_ib,
>>          .insert_nop = amdgpu_ring_insert_nop,
>> -       .insert_end = vce_v3_0_ring_insert_end,
>>          .pad_ib = amdgpu_ring_generic_pad_ib,
>>          .begin_use = amdgpu_vce_ring_begin_use,
>>          .end_use = amdgpu_vce_ring_end_use,
>> --
>> 2.43.0
>>
