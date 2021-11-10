Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BD2C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 23:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12CB861038
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 23:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 12CB861038
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 994B06E81F;
	Wed, 10 Nov 2021 23:36:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDE5B6E81F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 23:36:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmRcTRaP3LSsy+OJ7DQu2Xf0YoHVmrrSzcKaAaeKPaMCnU52EBQKMfiEBdABr+l5uJ5dC89pISIxQBBptGDYUbaiZyjJjckOsy1Fm9hqnlul+Ekr6YqbCYavdRqGBlAdsaMMMNeULi71N8yfG8tgLtBtondoUhX23md9tFXNnanG92hDX28su5rEAURRzVyIeA+4eYGDQCueOUZ/+UnODcnXn50onqEM/1Au4SjIxudegjCeQQChWB2tEnNOXsYLglgUf+ifFhtqDhPvXaTk4koHvSEBfOyzD9EFV/TW/dk3Nsx+f5zJFllvG36VTURO/XWL4cKx/it5HFzlhnd81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFHjhaRXJw2+aSVeb+wSES19cFB0eeGPXLMLM3InUlQ=;
 b=kfd7WyqmowCzFPW1xvAFXn9DBhC2HWK6vfn3NtdncOTTpYC8+4x5DnZ9MnslnDDwMawdPRZevgKd3/UA7Zcjit4ZJ42IQlSpRPZ433Va86wd/yDW0F57GrSgKDaDYzWUxz0/9J5qdiUWKSBO/Dgo/E/0sggwZvjiDMjC0ZTGF7ev2KNCaxOtVdQpgq/BaZpsXfu7z2WfI4zGnhvNOwgiN5RLGvNW633M+lAEYUQulAh7DKUUpzgsB+x/KXAiiL0sjpbW9OUdpfT3uERTJoH5Jn+KWjtrIJ2ra4qYFh8EZDXjLe77evncTT/3l1LJ3mHAtKtcRd8kYxVXwOxZUPQznw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFHjhaRXJw2+aSVeb+wSES19cFB0eeGPXLMLM3InUlQ=;
 b=bFH+K7ZfrouMb3BEgrI6z7YPrx3UwnRqoOtgHM2ma6ETkWAnIM/nNjHWcRUtclKB6lz/Xo+SGMHOB9R8TajAIivqGqgXUwjLFXJvuKxWJ3A7J5poa0FqyhrKcInXnlGpoqRWbvzwZ3kiz1Ep4JXTiLmSFeKGHj8AoffaL8pyIWs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 10 Nov
 2021 23:36:45 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3%3]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 23:36:45 +0000
Subject: Re: [PATCH 1/5] drm/amdgpu: handle IH ring1 overflow
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 philip yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211109230432.3947-1-Philip.Yang@amd.com>
 <1862b795-3401-b89f-089b-4b544957d150@gmail.com>
 <c5855126-de94-f2b4-c912-f386b6b47142@amd.com>
 <9e4e654f-8996-fc9a-0ec6-211a7c0ddf42@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <5e646384-ce7a-9a80-f97c-ae9592e39bbc@amd.com>
Date: Wed, 10 Nov 2021 18:36:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <9e4e654f-8996-fc9a-0ec6-211a7c0ddf42@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR0P264CA0164.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::32) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 PR0P264CA0164.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Wed, 10 Nov 2021 23:36:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 714838c8-8922-49d0-d723-08d9a4a2f4d7
X-MS-TrafficTypeDiagnostic: BL1PR12MB5144:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51442C15082B8428E945C84792939@BL1PR12MB5144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hd+3NKPyYx1kAN55d89FYRTvZ0FUi1WdMuSuiDwBiSZS7IcQPN/vKPBRpFNBxPKwuW+OxeM8xzrqMYgD8rUAec0xskJ9nWhDPNqeAMpypx+F1gUb6MpmiOBpcrtMe62bjPFNfTb7ZpfPcN/3//A9rjCwmCuaumcI84U/4PLtm5/PP4KzlX78GTwda3V6gmvyeJ16dKMwss9U2OsISB11QcEe/EBABqsVJ+6OE9JHKGKdWyvdW/j77U2FRvgWJbg0E3vADfmLsTaQ+YNYMVuP2zDUB2vaIBPVmZ3PMRqLOz1xFuN6br/puZ/hX5C4X8D9CXTBrn0j8fM8JCeyb5qd+asbIQdRiDE6A1ySdEQtIOBRGgTaHIRyvllV1DG+nwAKE6rX4fTrJnn5h1y46LgK1BIOlxI6OVRAk9ReH/XfIXNg7FgahR0weTCbb3FPTb3D4UAykrMsqDpGzKDO503Hz0yWsR/vFKUQLMq62SwAUpxIbyflWGmtkKllFkZu6jM5/3PdHTBNyY8rMCqa/5cOFOUZIHcTLxBTxGBh+H+n8HUPVk3yWzzh604kF8sRU24Rv/nNNMkwu8N5EXFKvVlAZJ0IaNyM+gVV3wS8fTbTynS4iTPA+RsG0MRPt9kZvEWvYguco4D1vE4SqLK8g6Lea1EvkfvQWOfSiStYmVi2AGCJ0tw2CH6bOHqbFUgSJ4MoKqisGdU3kUat6lYMMlskzJtjPFWpqJvYQAskrZ+ND0KfFarJaD0PoI2kIt91bBLx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(66476007)(956004)(66556008)(2616005)(66946007)(53546011)(6666004)(316002)(83380400001)(8676002)(31686004)(4001150100001)(36916002)(31696002)(38100700002)(26005)(110136005)(5660300002)(508600001)(36756003)(16576012)(8936002)(66574015)(44832011)(6486002)(2906002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDd0R0g5dU9MdWIvaExSNHJjL2xDUE5GbFArVzNDTHpLaHNCTnRSMWlkNVo3?=
 =?utf-8?B?UXd1RVM1Qjcyb0lXUU5kR01Ld21Rb2Zwb3BXQTZ4MGh6bzRPSUpLL0hZeWdp?=
 =?utf-8?B?ZUR2VFMvNTJOU3pybnI4MEY3MkhhRU5ZRHpGUXdqZElBbWhvalk5dWFueXJX?=
 =?utf-8?B?MDdoTzU4bHF4Q3E4UWEvWktDaUFjUnM5QXZ1c1E2RFVnQzJneUZlSHlXK1d6?=
 =?utf-8?B?d3NrYVNXTElrMXpjamVrV0UybC9DODZYa3U2emt1Ly9QVlY3Mzl1UlpnSWhH?=
 =?utf-8?B?S1FqS3dRMnhSR240UzFzSU9JME1DcDlsdU8xbE1BeStHUVFBNWNpUXVYZ1ha?=
 =?utf-8?B?ZHBUaTNiSUI1R0xTaGZOVnArMVdId1U2NzcrWGZiT1Y4TmVoSnQwNzhGYUVV?=
 =?utf-8?B?bmQreUlNc2ZPYjcwWFh3SGxSa3h5OFpVbjZXL3lTNVBiakpPSTNES1NHcnRM?=
 =?utf-8?B?TTNQTkt1RkszeUZUR0VQVUd3VmhSRkFqcy9EbmNSTVN5b1h6cUYyTVlnU1dh?=
 =?utf-8?B?WmoxYVF4SGNQOW1UT2NUZndFb3VhaVo4VG01VkIzZzZoQVB5cTRwVldYR1Zr?=
 =?utf-8?B?Q0lRWEY3VXFMMVNGU1B4WGRxd3g1c1U3SENPandzK2xvNXl0dmEvQUN1MWNB?=
 =?utf-8?B?M3kvV1haTXhsRjhpU3BQNW1iQ2I0TG1BeUpPQk4yRnl4OGZLR0RSK1dOKzJW?=
 =?utf-8?B?eG9Ndndua3JPRGN1M2hZb3ZsaFpGTFJ2N1lOYkx2d2c3SDVQTXh0R0wyWjlZ?=
 =?utf-8?B?UWNFb0M3dmN1dGRmendmYytGQ2NSWGh5Qmx1Yk41b2N5Mnd5a3JJY2dLMjNz?=
 =?utf-8?B?eDlIRWJvbDJ3R1ZoMmtxMmkwenNVVlFrd0ZPc09XUERVL0NzejVwMzhHNVFE?=
 =?utf-8?B?MWlmdHE3YnF5TUFoZ2dlc0RUOWFFS1V4TmpvTjMzem81cUticFV2RVZyamdj?=
 =?utf-8?B?TFhrUFdJeEZIM29EdnlMN0g2WkplZzhiNHBlTDZTemZkMCsxNGxTZTdOUFZ2?=
 =?utf-8?B?NjRqVCt0ZGhtRDM5cWp5QTF3Slg1WTd6azJzZ0tjcjdvRnpzY0k2bENJUlA2?=
 =?utf-8?B?VWdqS3NxMldDaWh1ZTlDR3dyZFBnRG91NXNMY1p1VUdUUjJKVFJJVGFqZkZC?=
 =?utf-8?B?UVczc3YvQkw5T2ppMnpOeUovektNUWNteUZzeXBwVWlhdkhmdE0yWUg3L25Z?=
 =?utf-8?B?M2Q0OGFKS0l2ZmhwdGF4TU14TG0rSk0weGlRN2p0b1B3L0FsMERpYnBHK2lN?=
 =?utf-8?B?eWp0WUFNdWUyZHRrZHRKMzh4YTZnaWFHN2lLVGVGK0JwM0NFMXlHVzZwWTE3?=
 =?utf-8?B?TTV5VXRFUFBZcXVCbXJaMHVHenBLNVlRc3lUK3Z0WHluN1Z1c0p2S2JZQmZi?=
 =?utf-8?B?OUtnQ2tkbmJyVWtqT2RXOEpUUEd5ZDE3Y0VCcWI4dExyTHRZUTVrSWdNT0JI?=
 =?utf-8?B?UWJrNzh2WEZIMWFyaW1KOWw5ZE5oOTl6NDRwK1h5NUMrNHpDdFpjbmU5OXBQ?=
 =?utf-8?B?K2VYQ3NkU1k5Vy9ybWl0TE1GRE5BdzNWeGY4MmxxOFJ3T3VkbTJlaGYzdDBv?=
 =?utf-8?B?TmYvdWFPdS9TTGV4MHRucFZ0SGJnTm9Pc2p4Um95WEZtMXY0WldJSGMvM3Ax?=
 =?utf-8?B?a01WZUFJRHMxRGk5cVpEaEZTRy9pQmV0Yy80TG1jT25ZRzAvaDZ1aXRIUnBm?=
 =?utf-8?B?NjJpMWZzWlJaUGpIVGRCaVEwVmdKTEwrak54Nmp5NnNnU0hMajQ0WExHQXJl?=
 =?utf-8?B?Qmhrd3RWelJvNTJ5YWptbDBWTTdBZlRFSkNQckcwcVd1ZUNrSDkrNVNKZjRa?=
 =?utf-8?B?MmFkZW1XMENIZE10Nk9LTVc5c1A1eTVXMHBTSXdzQ25SSUlHOU9Fck5ra0JJ?=
 =?utf-8?B?UmdudlhtdGc0STdCaDJwbU1HNTd5YWpmdzZaVGt3NERiUnNCM2RmdU1qRXNz?=
 =?utf-8?B?UVVpdW5GWEduclIyWCtNVitvRlM1UVk5ZGx6UWZsM3pNUHhhMEZQbGtCbW9V?=
 =?utf-8?B?TVQxU0pkNUxKNE42VDBlbks0YmF6M3VLQURlN1U3bHVWYktycXh5b0ZwR0FU?=
 =?utf-8?B?WUlZc2NmYis2U2hLUWI4MndhazlaQlZYeHRSdWJLbmlYeFFlS2tUOVhucHpp?=
 =?utf-8?B?amhVUGFrTTRTcDM5bVVrRzdQd0pxTHRIYk5hVEhuam5HRFpBSlJKMXVWQlBL?=
 =?utf-8?Q?nWNXmBFXSkU9OB6KTs2ccec=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714838c8-8922-49d0-d723-08d9a4a2f4d7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 23:36:45.4793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mncv9zaNyxdx4WS3xFysSx1VHtldeMzyxrlrcb5LI+Wc73VQ/hqOqxbMsLMk0dRTNbe1z3F1ir1iWCBTeJkWOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
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

On 2021-11-10 9:31 a.m., Christian König wrote:
> Am 10.11.21 um 14:59 schrieb philip yang:
>>
>> On 2021-11-10 5:15 a.m., Christian König wrote:
>>
>>> [SNIP]
>>
>> It is hard to understand, this debug log can explain more details, 
>> with this debug message patch
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>> index ed6f8d24280b..8859f2bb11b1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>> @@ -234,10 +235,12 @@ int amdgpu_ih_process(struct amdgpu_device 
>> *adev, struct amdgpu_ih_ring *ih)
>>                 return IRQ_NONE;
>>
>>         wptr = amdgpu_ih_get_wptr(adev, ih);
>> +       if (ih == &adev->irq.ih1)
>> +               pr_debug("entering rptr 0x%x, wptr 0x%x\n", ih->rptr, 
>> wptr);
>>
>>  restart_ih:
>> +       if (ih == &adev->irq.ih1)
>> +               pr_debug("starting rptr 0x%x, wptr 0x%x\n", ih->rptr, 
>> wptr);
>>
>>         /* Order reading of wptr vs. reading of IH ring data */
>>         rmb();
>> @@ -245,8 +248,12 @@ int amdgpu_ih_process(struct amdgpu_device 
>> *adev, struct amdgpu_ih_ring *ih)
>>         while (ih->rptr != wptr && --count) {
>>                 amdgpu_irq_dispatch(adev, ih);
>>                 ih->rptr &= ih->ptr_mask;
>> +               if (ih == &adev->irq.ih1) {
>> +                       pr_debug("rptr 0x%x, old wptr 0x%x, new wptr 
>> 0x%x\n",
>> +                               ih->rptr, wptr,
>> +                               amdgpu_ih_get_wptr(adev, ih));
>> +               }
>>         }
>>
>>         amdgpu_ih_set_rptr(adev, ih);
>> @@ -257,6 +264,8 @@ int amdgpu_ih_process(struct amdgpu_device *adev, 
>> struct amdgpu_ih_ring *ih)
>>         if (wptr != ih->rptr)
>>                 goto restart_ih;
>>
>> +       if (ih == &adev->irq.ih1)
>> +               pr_debug("exiting rptr 0x%x, wptr 0x%x\n", ih->rptr, 
>> wptr);
>>         return IRQ_HANDLED;
>>  }
>>
>> This is log, timing 48.807028, ring1 drain is done, rptr == wptr, 
>> ring1 is empty, but the loop continues, to handle outdated retry fault.
>>
>
> As far as I can see that is perfectly correct and expected behavior.
>
> See the ring buffer overflowed and because of that the loop continues, 
> but that is correct because an overflow means that the ring was filled 
> with new entries.
>
> So we are processing new entries here, not stale ones.

Aren't we processing interrupts out-of-order in this case. We're 
processing newer ones before older ones. Is that the root of the problem 
because it confuses our interrupt draining function?

Maybe we need to detect overflows in the interrupt draining function to 
make it wait longer in that case.

Regards,
   Felix


>
> Regards,
> Christian.
>
>> [   48.802231] amdgpu_ih_process:243: amdgpu: starting rptr 0x520, 
>> wptr 0xd20
>> [   48.802235] amdgpu_ih_process:254: amdgpu: rptr 0x540, old wptr 
>> 0xd20, new wptr 0xd20
>> [   48.802256] amdgpu_ih_process:254: amdgpu: rptr 0x560, old wptr 
>> 0xd20, new wptr 0xd20
>> [   48.802260] amdgpu_ih_process:254: amdgpu: rptr 0x580, old wptr 
>> 0xd20, new wptr 0xd20
>> [   48.802281] amdgpu_ih_process:254: amdgpu: rptr 0x5a0, old wptr 
>> 0xd20, new wptr 0xd20
>> [   48.802314] amdgpu_ih_process:254: amdgpu: rptr 0x5c0, old wptr 
>> 0xd20, new wptr 0xce0
>> [   48.802335] amdgpu_ih_process:254: amdgpu: rptr 0x5e0, old wptr 
>> 0xd20, new wptr 0xce0
>> [   48.802356] amdgpu_ih_process:254: amdgpu: rptr 0x600, old wptr 
>> 0xd20, new wptr 0xce0
>> [   48.802376] amdgpu_ih_process:254: amdgpu: rptr 0x620, old wptr 
>> 0xd20, new wptr 0xce0
>> [   48.802396] amdgpu_ih_process:254: amdgpu: rptr 0x640, old wptr 
>> 0xd20, new wptr 0xce0
>> [   48.802401] amdgpu_ih_process:254: amdgpu: rptr 0x660, old wptr 
>> 0xd20, new wptr 0xce0
>> [   48.802421] amdgpu_ih_process:254: amdgpu: rptr 0x680, old wptr 
>> 0xd20, new wptr 0xce0
>> [   48.802442] amdgpu_ih_process:254: amdgpu: rptr 0x6a0, old wptr 
>> 0xd20, new wptr 0xce0
>> [   48.802463] amdgpu_ih_process:254: amdgpu: rptr 0x6c0, old wptr 
>> 0xd20, new wptr 0xce0
>> [   48.802483] amdgpu_ih_process:254: amdgpu: rptr 0x6e0, old wptr 
>> 0xd20, new wptr 0xce0
>> [   48.802503] amdgpu_ih_process:254: amdgpu: rptr 0x700, old wptr 
>> 0xd20, new wptr 0xce0
>> [   48.802523] amdgpu_ih_process:254: amdgpu: rptr 0x720, old wptr 
>> 0xd20, new wptr 0xce0
>> [   48.802544] amdgpu_ih_process:254: amdgpu: rptr 0x740, old wptr 
>> 0xd20, new wptr 0xce0
>> [   48.802565] amdgpu_ih_process:254: amdgpu: rptr 0x760, old wptr 
>> 0xd20, new wptr 0xce0
>> [   48.802569] amdgpu_ih_process:254: amdgpu: rptr 0x780, old wptr 
>> 0xd20, new wptr 0xce0
>> [   48.804392] amdgpu_ih_process:254: amdgpu: rptr 0x7a0, old wptr 
>> 0xd20, new wptr 0xf00
>> [   48.806122] amdgpu_ih_process:254: amdgpu: rptr 0x7c0, old wptr 
>> 0xd20, new wptr 0x840
>> [   48.806155] amdgpu_ih_process:254: amdgpu: rptr 0x7e0, old wptr 
>> 0xd20, new wptr 0x840
>> [   48.806965] amdgpu_ih_process:254: amdgpu: rptr 0x800, old wptr 
>> 0xd20, new wptr 0x840
>> [   48.806995] amdgpu_ih_process:254: amdgpu: rptr 0x820, old wptr 
>> 0xd20, new wptr 0x840
>> [   48.807028] amdgpu_ih_process:254: amdgpu: rptr 0x840, old wptr 
>> 0xd20, new wptr 0x840
>> [   48.807063] amdgpu_ih_process:254: amdgpu: rptr 0x860, old wptr 
>> 0xd20, new wptr 0x840
>> [   48.808421] amdgpu_ih_process:254: amdgpu: rptr 0x880, old wptr 
>> 0xd20, new wptr 0x840
>>
>> Cause this gpu vm fault dump because address is unmapped from cpu.
>>
>> [   48.807071] svm_range_restore_pages:2617: amdgpu: restoring svms 
>> 0x00000000733bf007 fault address 0x7f8a6991f
>>
>> [   48.807170] svm_range_restore_pages:2631: amdgpu: failed to find 
>> prange svms 0x00000000733bf007 address [0x7f8a6991f]
>> [   48.807179] svm_range_get_range_boundaries:2348: amdgpu: VMA does 
>> not exist in address [0x7f8a6991f]
>> [   48.807185] svm_range_restore_pages:2635: amdgpu: failed to create 
>> unregistered range svms 0x00000000733bf007 address [0x7f8a6991f]
>>
>> [   48.807929] amdgpu 0000:25:00.0: amdgpu: [mmhub0] retry page fault 
>> (src_id:0 ring:0 vmid:8 pasid:32770, for process kfdtest pid 3969 
>> thread kfdtest pid 3969)
>> [   48.808219] amdgpu 0000:25:00.0: amdgpu:   in page starting at 
>> address 0x00007f8a6991f000 from IH client 0x12 (VMC)
>> [   48.808230] amdgpu 0000:25:00.0: amdgpu: 
>> VM_L2_PROTECTION_FAULT_STATUS:0x00800031
>>
>>> We could of course parameterize that so that we check the wptr after 
>>> each IV on IH1, but please not hard coded like this.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>       }
>>>>         amdgpu_ih_set_rptr(adev, ih);
>>>
>
