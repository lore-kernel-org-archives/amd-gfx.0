Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEEEC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 16:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 093C710E190;
	Mon, 24 Jan 2022 16:50:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7213B10E190
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 16:50:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlTGwHyv/MUV4GxPjbRIvirAX6ObrXfCuTIxoRQaI9q/xFlZGMHEV21kwvPExVyIETB3eaGs21s929vr7bd7vUE3JID1IoQCzEebQTRZ4Y+J7+2iqpe/WeT6xzL4tbUCefy0EIVPNVJFQnLNpcmgvYnJsZf34FBsPaXt2rhMmGRYUjh0tPPn+zLrFZZZh3OnMRHJzT+mE8h7P1B1IIuPI8PBkzu2WayO7dsEP/gxV0YBNbPtU+T0NM+kf3IIe1NozjBtkfGk9kdDSJEALAj+UbvwbixUI62McOOnDHoBYJ1agwZW9c9WB0vngz3d+BffoZMNZLtkQkee2CzSE9zQew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1m61eQzmE63aG+oC4s14+hE8uj3pIDA9VRoRPIrOJlQ=;
 b=fbwgNQKAH/E2k1n0BShDs9e5KBUzVH35FnLz3ER8ji7tVFl/Z8EJJhmkbxrOpaz6jPsojtzK/RXxfmel2cP2BfpSZGr5Ga9Zr6yj74A11r7hKRPwAQl1f9Rt/4Clk+DBHlCucYw4xHaNR0rFOfYgK2AO40PcOp78bnD8gBDKoH8PBrakBm78SuoF9T1IC0ZRdgzhVEdJpNOzKodldE2LsICGvIaXfmjhBluV8+p8EdjUYBNzJXRyy+KdX+UFcz4j8xizdNuI9tkn66lsZ00mejV9pYpcrPxqrhhHz4thnVVIeTjxyxwFet27Dxu/Aa6LFm0cfDaryov0q46JgvxlSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m61eQzmE63aG+oC4s14+hE8uj3pIDA9VRoRPIrOJlQ=;
 b=ckPUihC5lO2zbolFl8pN7l1GYOOs5QwkLfE+JqNBcALc6qHt/C1HQZ58e1OMwOYC0l5R1tPUujGSl3wldhYdv+5Yi7/uZ3qXywltQ0imVmEiDR+JuP57YQ/b2ILeUIcrAL9jgrFaAGkMrMIZcCqA3lAPcD9yoZBvDcqMJwjZPUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SN1PR12MB2541.namprd12.prod.outlook.com (2603:10b6:802:24::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Mon, 24 Jan
 2022 16:50:53 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 16:50:53 +0000
Message-ID: <6c6a0dbf-21cc-c5bd-36ac-4e433f2a179f@amd.com>
Date: Mon, 24 Jan 2022 17:50:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
 <99e76deb-9f86-6158-9edf-5dd55c77a709@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <99e76deb-9f86-6158-9edf-5dd55c77a709@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR04CA0042.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::19) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87bd6cb8-2fdd-4156-ea07-08d9df59aed4
X-MS-TrafficTypeDiagnostic: SN1PR12MB2541:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2541973D49FE387ACD235D2BF25E9@SN1PR12MB2541.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOKrBXtlFOFvhEt6tTI7WXK6bPXngys8Di06TAUMKE/9J3xeqPiHaPEIB4bJcRYeqVVFu1wE4cr6jb1FLFXVw6h0OEp86OEoM689CcjGYrM0fxS86NlyIYqJxYRAlYu6htRdl410j4aVCvyroqx9JC0M3gelMKIX5Bnw47SETMrvAs0r++AzlKFfFsdiZlTknjrx3H4lOBYnBHH+T5rSSr9LQcBwco4XlcjhrdUkYy4ZqL1VCYaZurmjVsz4LQ0NymCi2d+cmTkw7QajoyB7PVZ4dzE9q+YPfulQHpUaP2JtHgQH4yokzAhD3B88VKfk7336lYcgfHa1BCkgvr3ho5uMcnu9Llt6o8JYosQHHwYMUortpfHAg+U5qCDSlj12nMIorr2hyPwE6R42WwaN9RNe4xAweAF0zOuIyxs4UQFrIgzw31txoqYyasGR3AKPv+OudS1IUEbF1HxD+NHa6Tn+a34MtsKlcYpJaxOVCzUPzychdNSbliUDRSAakTNUoJ5PBtHsu7zRVfSo5tNlHYJPi80rzD5euWz50vQyE7fCcAw6Bm2/hSSJRi8U0quVP+wayR6N6YuHttFEUuAke5zd9B+s38zn0qsrw84WlWHVWb0XCBdWiOyoNV0UhE2mQVS/F5Eas2qYIq70PfEmVswPDqgr4oG4XP16P3Ag0MTbP9YLR2+MGDqtWb2BPY2AF58j4hwuPq3eM8GTIsRkLH30b6Yq2ZX8V354JsATDNugZeTOpLF3nWlY1HGdsSry
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(6506007)(8936002)(6512007)(186003)(2616005)(83380400001)(31686004)(66476007)(66946007)(8676002)(2906002)(53546011)(4326008)(508600001)(31696002)(26005)(5660300002)(316002)(36756003)(66556008)(38100700002)(6486002)(54906003)(6666004)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWVQU3ZBNDlPMmtxazlvVWpNL3ZWeE9scXhBZ0lsMDNDODRkR01JVHpMUExP?=
 =?utf-8?B?VUlrcVF6R3FHeFIvMVEvcnVMY0hQd1VhN3FQbmJaQVFnT050alNtS0sxbFlM?=
 =?utf-8?B?dVQ4aUZ5WVI4clVad05leW9kQlBpR0hHRHNoZk5XbjNaZXlDTEpJbVpLVGJK?=
 =?utf-8?B?c2oza0tuMmZQSkRPV243bzdsWTFvbzVNZUlhdGZiWGhZY0tWcjZobnNUbVNX?=
 =?utf-8?B?WEJEaDBOandKR0lsOVNCSkF2UDZTY3lMVTlucHlrbWVCaFk0NFJ2TnFYVlpE?=
 =?utf-8?B?NGQzTEFmSkRvczB2ZlVqcndsbTZLK2xLYjZzUllWUlc4aVk2S3duK05ycm4z?=
 =?utf-8?B?Vys4V0FQRlZTZEpNSStXOWpLdjBsZkpnWEpickRUN3JLRFN1UjZMdEhsR05W?=
 =?utf-8?B?anJEQkRIeGhlZXUxSVh4c0haUGk2cFJyRWNiRlZrZWI0dWJyU2oycHhCYTNC?=
 =?utf-8?B?UGFweDA3SjcxLzRsVWZEVkVLaktxWXp6VnpZdmxabkJnaktzOGRTYk12SVFO?=
 =?utf-8?B?djlzMnRjRTZybmtDMjBGTGlucHVvUkpNUmpqM2xpOGh2ckhDNmR4ZjZ2eng5?=
 =?utf-8?B?ZnBOTms4aFNTcitFNW1PUzhEaGJvQU5pMUNiUHYzNEZKN1NLaUY3VEwvNkpw?=
 =?utf-8?B?akNhWk1oSXVBdEZaemlBZXUrOFNEemFnYWRlNHJqczI3ZmJOWk5BZUtLcC9i?=
 =?utf-8?B?WnRsMGNQLzgrUnFsMWlVWmpUMlRKUmdNRzlid2FhdmxjZ0hoS0E3REtDOU1V?=
 =?utf-8?B?MzhlUktHdTQrM1I4N3lIZy9mYUk1UDlwOUx1dUhVY25kRDNubkg1Q2VpVHNE?=
 =?utf-8?B?RzhMcFBBbjJkZ1JYM2lzZXpFMTVIYUF4NTdMR2prMHRWUlh6OHFxK3pwNW82?=
 =?utf-8?B?NklRZjU5Mmc3c0ZZbFE4QnF3K0o2Z1NHWGpsK0tOUk1tWUNUWUlCK3hRUzUx?=
 =?utf-8?B?K2kvWDNmaVZJYUR3bzFSSlBUZUN0UDQ3enNORFJTdW5UaGhOWUU4UmlCWDU0?=
 =?utf-8?B?RzZPVVFGY2x6RWt5cTdKbXFiZVRGbUxMVVEwWTlHVFFXTk9DYVVQR29FdEU3?=
 =?utf-8?B?WHFLVEl6Z3c5K090TlpPOFJtZ05VdXByZ1B3YWZqVzRub2tmY0tobURxSUNy?=
 =?utf-8?B?N0FjR2xCWTBSYllxQTdFL1BWZnlqd0ZEL2lXL3NZeW1EQ2w4VVE3L1c1OEpy?=
 =?utf-8?B?eUVBeG04UndzU1ZlMnJEbEdPTEdmYUU0NlVrNzIvZzMrckdhNDZzUHdHaDA2?=
 =?utf-8?B?cW9jQTd4ZHl4M2JHNkw5UWMraXVBMDVIajVmWlN2RzhVdWhqZ3RaK2ZZUXcx?=
 =?utf-8?B?cVh6eFNvMGM2eTVGUUhNMEtMY1BMS2wvQWpPNW5jOURCOTB2aWVFZE8rKzQx?=
 =?utf-8?B?dGZ3NjBHRVdCdjdFQVJkYmdBaUkwdVZPcmJRckxxOUhqbGtmdTVlRGRLOHZj?=
 =?utf-8?B?OWJhaWRVRVk3eVhHT2R6ZDhQOHFBUTZRL2FyZTJSbGp4TURGTGI2M0NhN2Iw?=
 =?utf-8?B?aVo1U2h2V1ljemFOb2l0L0NrLzBLOXp0RkgvWG55MzM5NnFMR3lETkFtblpq?=
 =?utf-8?B?NWVMVlNqeFhnc0FPSDJHM1oyWVp0ZUJLajZkQU82Tk8vTExJOXZyZm4zWmh0?=
 =?utf-8?B?R01pWXQ3WjU1QVk1Z0s0Tm1WNDFmZ0dhb1FvQVJmamZ6WHBIVGhNZ3o4c1Zi?=
 =?utf-8?B?NDRlU0FocWVTN2d2c29CWjBONWtEVWFBVEd0ajlnaTVvU1dRQmRuaUxYbXNN?=
 =?utf-8?B?OHdoS0NQZkRZMGdYTkpvbHVYMlVlbC9yMWovdUNPNjJTZWlNWW5ZZXJQTVRi?=
 =?utf-8?B?Z2J5WU54b21sdGswOUI3SHhYMDdCWlNxN2NBaFBuQ01xN25RTktQV1JIcXhN?=
 =?utf-8?B?NHQ4Z3A0anBKTjdSZmlsVEdhOGtPalpZN24yUXNkeUxBaW5mSGJicXNEaHJs?=
 =?utf-8?B?YXNZVVQ5dUdpbDNEQ2VYc25VRjZ5dUFVQ1l4Nm1Pdi9EamovK0JlMDdEaDdr?=
 =?utf-8?B?cE8xREVQYjlFWjlydlZ0YmZ6by9UekhkOEx6a2h6UC8yMGZaTXFNM0RDM3VJ?=
 =?utf-8?B?WGxmZWRuNHFPVDJTY2VEaE1wQmhpZ1FMRkhySWd6T1dSVS9NQlJLMTNmVENw?=
 =?utf-8?B?QmZ0VlRrRTFFUDNoR1NMT1k3Z1ZxR09nS24wNXh1WEIycjQ1RHc4UmhzRWt3?=
 =?utf-8?Q?LwU3Bg0vRQj7QP0+iqnUSIQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bd6cb8-2fdd-4156-ea07-08d9df59aed4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 16:50:52.9939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJJGL+EXL0JR4zsWOUH4LclSgfSeh3UeTD4wrWP28RBvvQ1bx88ClvvNghH0scE0LMi8U0Bt4X8npsq13VQFnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2541
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/24/2022 8:18 AM, Christian König wrote:
> 
> 
> Am 21.01.22 um 21:34 schrieb Sharma, Shashank:
>> From 899ec6060eb7d8a3d4d56ab439e4e6cdd74190a4 Mon Sep 17 00:00:00 2001
>> From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> Date: Fri, 21 Jan 2022 14:19:42 +0530
>> Subject: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
>>
>> This patch adds a GPU reset handler for Navi ASIC family, which
>> typically dumps some of the registersand sends a trace event.
>>
>> V2: Accomodated call to work function to send uevent
>>
>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/nv.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c 
>> b/drivers/gpu/drm/amd/amdgpu/nv.c
>> index 01efda4398e5..ada35d4c5245 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>> @@ -528,10 +528,38 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>>      }
>>  }
>>
>> +static void amdgpu_reset_dumps(struct amdgpu_device *adev)
>> +{
>> +    int r = 0, i;
> 
> Please don't initialize variables if it isn't absolutely necessary.
> 

Agree, @Amar please check this out.

>> +
>> +    /* original raven doesn't have full asic reset */
>> +    if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
>> +        !(adev->apu_flags & AMD_APU_IS_RAVEN2))
>> +        return;
>> +    for (i = 0; i < adev->num_ip_blocks; i++) {
>> +        if (!adev->ip_blocks[i].status.valid)
>> +            continue;
>> +        if (!adev->ip_blocks[i].version->funcs->reset_reg_dumps)
>> +            continue;
>> +        r = adev->ip_blocks[i].version->funcs->reset_reg_dumps(adev);
>> +
>> +        if (r)
>> +            DRM_ERROR("reset_reg_dumps of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +    }
>> +
>> +    /* Schedule work to send uevent */
>> +    if (!queue_work(system_unbound_wq, &adev->gpu_reset_work))
>> +        DRM_ERROR("failed to add GPU reset work\n");
>> +
>> +    dump_stack();
>> +}
>> +
> 
> I'm pretty sure that should be inside common code and not here.
> 
> In other words that is absolutely not ASIC specific at all.

Yeah, I agree. I think the initial problem for Amar was that some 
offsets were only valid for particular ASICs, but nothing is stopping us 
to make this in a generic function followed by a asic special function.

We might have to move the asic.fptr to a more generic higher level fptr.

- Shashank

> 
> Regards,
> Christian.
> 
>>  static int nv_asic_reset(struct amdgpu_device *adev)
>>  {
>>      int ret = 0;
>>
>> +    amdgpu_reset_dumps(adev);
>>      switch (nv_asic_reset_method(adev)) {
>>      case AMD_RESET_METHOD_PCI:
>>          dev_info(adev->dev, "PCI reset\n");
> 
