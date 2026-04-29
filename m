Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB16AFF887E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 15:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C77310F082;
	Wed, 29 Apr 2026 15:37:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J5+3wtFi";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F36210F082
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 15:37:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4+s1hQ1drDXHK5+C4nlga2AYmYQzR5GVKpT+PmLGDDOY2fu6PjoAax9ikn3Inm8aT598znoNRsKyzk2/CawkHQQX9aNoPaKlQ9PNREExxgfdu3Q4i9//QFS0sXjArkzyuSwHoqsuvE+B8jG8XfNBkvg4deZJpJbgJ5W3nLSk0SrvAHhQhzHdYa7TWlbRSWn4CgQaIvrY+ilBOK/Laby8nVjBpNAhUXQMUG9zXuGSAKfgVln5mkIQVlTVXk/aigc2dxLDobq1nZFjChhMHfA5MdROo3CeCVvH7wRk7U1ohs2Tb4Dx/rtc+YX4BADWkaUS//Afo3Kpmvsx8N2ocZFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3Ws2TcKq5omFM5v283Q8Kdq65AbWW67i9aog+XpwJk=;
 b=sQrVLRvPuUH7YqXS44TslZ5gVg2AcqiotttWU3PBPjTv3nhx5A6DH8uVra22iDIR4xcRFWqosWDC4AFOm0OQefE2fxc8JUgK0UHAhT/14nnZiTRtf/fyAix4pQfgy38GIDUkSSUySSXMwr5W8OH5DWVs67tzJ9YWFeN8p9BB4gyAy9I0rs12VI4/EBlDySVMXWXRzTgcvFfMcfg3mzqqx151BCYLrKKFpCtue8ztrdIXPnhKxmfcP2bfhmBZTBjEpC16tw+op3iCPFSNbyHkoOK2mkrRotQv1Fj3rgAiA2vcEQ57DJhYJ0CvxzAD8iUgPV6zYH0KxRwbD1yJfJrhkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3Ws2TcKq5omFM5v283Q8Kdq65AbWW67i9aog+XpwJk=;
 b=J5+3wtFixMalM1kIqJQqcRkhgFYz041QHezCe6f0sptcJcA1+ZfQbf7Av/V5pttm4Rlj9op0UW6bcltLNjWXELYPmErNetIW8cMkLMkKMtzLhgSOIGrDPSWPL76C4N//7fAJ61V4YGn74YFkA2DUvzSPsgXBRJSsweJPD8O+zpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 15:37:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 15:37:31 +0000
Message-ID: <b123f540-6871-44e7-9831-01357e160a3c@amd.com>
Date: Wed, 29 Apr 2026 17:37:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Adjust GMCv10/11/12 gart size
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com,
 candice.li@amd.com
References: <20260429123745.3930780-1-lijo.lazar@amd.com>
 <25f247d0-8484-40f6-b751-1b5f259cfa71@amd.com>
 <055c7635-425f-443e-afc0-40c3e0eaee1f@amd.com>
 <89fbce96-8594-4847-8032-cdd6f17fdbec@amd.com>
 <a27bede0-8d7a-4b59-927f-c1f43a61a753@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a27bede0-8d7a-4b59-927f-c1f43a61a753@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR22CA0013.namprd22.prod.outlook.com
 (2603:10b6:208:238::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: 834fe3e1-a8bc-49f3-5e42-08dea6053a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: VQwL7GLbiRSQpBveLuHO63Rjtuf5Hfd92u0EM4vhqzJv9fPZVNyVBfcrEkB4WFyO7GKKdgdoDO931SNn7mPP/x/8ZpQZ+JNOYZpbqYMjIlysJQJA+U6HfQscGOriCSVbRvYWRE37EpDC558l218j4gQA/S6S5jUUNbp2Wi+2rxXlMT7l/HYrIcApXpnmAyKnzRt5rRBkaBkD0L5RlrkglxpkQ+MAkwMczjmUMQO2sizTROddMKfCp0CioTYvTabcWiyQYo7ySAJlKUae1ZhuZYFmfgfbh9r60eli49+xxfDMSB8O4CLB5WqclN/cALC9dY0cQcINDF80SYzIfrwFYhAk1CcJRM17yUBKfgw5Av9CsWABtBMrTR6gWICOC8lCxouleDVufIB2VRS9/8/EmUoGvzRtA+DUq8bfI1PyiEKg9EyKy2ldIAc2SGUrqqixVXVBAV/uljjQXmwAxGunR2LKTQ8beynR4uXUOUHnT9bdJHIyFDvMDVYMkLJAE8fwWU8lpIhMuXiQQ9myT8lvjtN1qqDJiunpTirPqqvq7JB672WEg9xpxTqxqmJOXndKRov0GVwOyNUOiOKb9u/4k3EdI7c5yALQurrAnbho9sXTI1CSJuMU/iXo3CEj7JJEa/VUwEHWOKW6KIkpbxXLgIzab7+r6otGr6LVPas9PEczM77fL/BUWvAu+U6ADcqzH5lNXA0PgA0mDwJtKO6SVc3IcUPvtsW0HzXrfvH5jUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTJhVmpzNWpmQXBFaHNWNERobjBLZTB1ZU03ZmZUU1NLQnJEYk8rbENWa1JD?=
 =?utf-8?B?aTBzZGo1elBrOGsvNEhBcWxJcmlmY0RacHNRUTVuaFljcE5WVWVsYlNLUmpU?=
 =?utf-8?B?S3pXS3lCMlV5dFM2WmJvZ0g0MDFwZjlDcHJFNU43b25GbGFCSUpYanIxcm1E?=
 =?utf-8?B?RzkxbUdhclFrQ0dxT3V6MDR0V3VRZFQ3Zzh3Ukx0R1JzcHN4TkllV3VMcy8x?=
 =?utf-8?B?c0Jlb294RzR3dFFvM1o0bkltem14TkpNQm9lemlvQUVEZDF6TkN5Sjc5enZR?=
 =?utf-8?B?ZTErRm9CVW5ybkFZYXpYMGdnWW5XSGtLRzdnZ2FwM0xLeTBzaVRtL0NyS055?=
 =?utf-8?B?d3M1OVE1VnY0WlFERjNNSmFTQy9QTHY0bW5ISUFsS1IraGlmQkNLVmFSVThF?=
 =?utf-8?B?NVp1Unpoamw0Z3YyQjV6dDF2RmtMdjBxRThoWTgrMUxwRjhiR2w0K0lMN0Ur?=
 =?utf-8?B?c3VCc1pFZzVBNFByamlTeGhMTGlUR1ZLN3RXOTlvYzNjYSs5bmRyMjUya0ZU?=
 =?utf-8?B?OHNZMnNVcnhrY2tSQk82TkJQTVhkR2d5Q0lYS1REbWJhTGhFZmpvdHZqbXdW?=
 =?utf-8?B?WUdrMnFjTks5RDZWaWtrdFN4MWxkNXlRdzF1TlFtb3lvbXYyOVRKMVdGUWlJ?=
 =?utf-8?B?cCtvaGw5eFJtb1I3dys5cldpWGtDanhMcC9wd1VQTFhIVXBmT1A1OWFQMzBU?=
 =?utf-8?B?Rm80QnhPS0djbGY5UThRbUVHZVVKL3JrL2l2Q0lGcjc3dHlxVE11SjZiWk5H?=
 =?utf-8?B?bUtLSWltbU5CeDJHZFFnYjY5bXgxWCs1YWs3WkNTQkxqOGlkdWc1a3JHWlpQ?=
 =?utf-8?B?NWNxdDB5cHEvK0hURVZ0d2JLNWR2eHV1V1hvUmN1ZlFxWFQ2NVFJY1FyRTRn?=
 =?utf-8?B?RUVrUUFXYytLcUJoSnF3WXhpT3ZRSW9NRWcreHJXMkdJaFI4U1lHTlljeGk5?=
 =?utf-8?B?eTg3WkwrbmxNekhvbGZ6dUp5aDFhUjMwc1pKYndFbktjRDlsanZyeWM5cjlP?=
 =?utf-8?B?U1B0T25QQ2xDSG1LeDhjS1czWnRaditPc05DK2xLNjR3SDBuNXE3VWIybWht?=
 =?utf-8?B?UFZmZTB5UEg1R3pnZEQvUHMzV3BBemVUZkNRc0RzaS82Q0ZkUTRuTCt5NGRZ?=
 =?utf-8?B?c3dDNU5IbDROTVQzdWkxZHJxa0t2dXhFSzFldWhLSmRiL0dmenB3L0tLUU55?=
 =?utf-8?B?ZzdRSE9RWXJtQmlwNzR5a0wrS2t1YnNOUnNtUDZleTNTUERvWTRyNGNxQWlo?=
 =?utf-8?B?WlZQZ1A3L2wydmhUaW90OXlyUUZ5dFk1ZU1JK2dEbWt1b0hDTm1GeGR0Tmh2?=
 =?utf-8?B?Y3l4L3pPblloTUFJRGNBUVRWQ05IWncxbEZXQlJtY1FYYUpxODdYQnJnUlU1?=
 =?utf-8?B?OGx3V0RpUW1KVXNyUFhvR1F4Tk1NRzRBYUduR0JoYjRLQWJVbVQ5UFp2SHdz?=
 =?utf-8?B?c1hGR3BDZ3NrZjNFQjMycmg3TzhQR2NlY240azF1Z05mOHZKZVR1aWg0WFBz?=
 =?utf-8?B?RlZmRElNWGx4eVRhSVArUWZPbVNBOENhVnRoKzhYZWdiSXpzQkdCdElSREVy?=
 =?utf-8?B?amIvczF3cFVTeHo0bVFUTFdnZzdWTE9JeXMwR2RjVXJIWXAwK2dYL0UwQWgw?=
 =?utf-8?B?ZUVDL2kxb1RXWGVPK1RmVnhEYkxhSitocm1CRUdaL2dqSnJ1OTBMSmx1dExO?=
 =?utf-8?B?TU53bWVaSUhhUjNHUWFIdDVxeHkydGVWZEtRc014ZGNrQnl6amIyVVZMOFpG?=
 =?utf-8?B?OU41ZUNON0VsdnQ3UzhRaDBpWXNVdlVub05FZTNWUjZnbVFSMTF4Lys1VEpE?=
 =?utf-8?B?cHI2cXBpaU5YT2FzYUxJWDdiWnhrN0Q4bGhISENsdTV4b3pxcE5BUm5hZzBx?=
 =?utf-8?B?TWYvV1RuWVRwRitLbHh1UWdaVEtGWEMvaTJBVXNXRC9GaEJ1bC9ZeTYycnc4?=
 =?utf-8?B?N2EzdVlDR2ozOGx5bDkvS0xUSHA5aDBUWDdTckhJVU1Nc2NrNG9OTll2bWpN?=
 =?utf-8?B?ZlFPUSsySk1Qc2ZlQyt2dEFzQUNxN2s4QWxIYXRtMkdPR1Y3N01SY2duUWRy?=
 =?utf-8?B?Rm1HY2N5c3k5c2FyWndpdHJ1ektpUmY4K3FRZjVGMFNUVDhSZWZPYVR6bDJh?=
 =?utf-8?B?TENvV0s5MWM4UXVHQ0F1R2Z1SWpJYWtpbWF5ZjJhNEk5ZEJQa3NWbW9vQmNP?=
 =?utf-8?B?eTBtTUpnMTV0Z2ZzREdsb2FrNS81SzE2eVFaQlU2MnA0cTRnaU8rdllWK2lz?=
 =?utf-8?B?aEdaRGs5SC8xZlRlZ04zSG9ISXQrNzJDclUzZFpTTmhLQWRBV2xKUzFNdE00?=
 =?utf-8?Q?4pn/VJ8IKFIZXB3se4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834fe3e1-a8bc-49f3-5e42-08dea6053a1c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 15:37:31.6989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjaBcPLkFqn+KwT85/E433WcBRnWXc22Tbocf9cMvxXgUQ2SPOGs4CmXg0qVDjSP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875
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

On 4/29/26 16:08, Lazar, Lijo wrote:
> 
> 
> On 29-Apr-26 7:23 PM, Christian König wrote:
>> On 4/29/26 15:49, Lazar, Lijo wrote:
>>>
>>>
>>> On 29-Apr-26 6:17 PM, Christian König wrote:
>>>> On 4/29/26 14:37, Lijo Lazar wrote:
>>>>> Adjust gart size to account for space required for firmware private
>>>>> buffer allocation, if any.
>>>>>
>>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 ++
>>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 ++
>>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 ++
>>>>>    3 files changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> index e1ace7d44ffd..1c32e653a9ad 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> @@ -723,6 +723,8 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
>>>>>            adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
>>>>>        }
>>>>>    +    adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
>>>>> +
>>>>
>>>> That is pretty much exactly what we don't want.
>>>>
>>>> The SMU prv buffer size should *NOT* override the amdgpu_gart_size parameter.
>>>>
>>>> Instead we should disable the SMU feature when the GART size isn't sufficient.
>>>>
>>>
>>> This is not enabled by default. In normal cases, this size will be 0. This an extra allocation for additional logging from FW to system memory facilitated through a module parameter.
>>
>> Yeah I know. But we have cases were the GART size is explicitely specified for testing.
>>
>> Overriding that because the SMU logging feature is enabled is a pretty big no-go.
>>
>> When the user specifies contradicting module parameter we should fail to load the driver or at least disable the feature which causes problems.
>>
> 
> Do you mean to add allocation only when amdgpu_gart_size  = -1? When gart size is specified, it will simply fail driver load if there is not enough space.

Exactly that yes.

My suggestion is to add a new function amdgpu_gmc_gart_size(adev, uint64_t default) which updates adev->gmc.gart_size and either uses amdgpu_gart_size or default + adev->pm.smu_prv_buffer_size.

Background is that the adev->pm.smu_prv_buffer_size is actually not HW specific, so duplicating that in every gmc_v*.c is potentially a bad idea.

Regards,
Christian.

> 
> Thanks,
> Lijo
> 
>> Regards,
>> Christian.
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>        gmc_v10_0_vram_gtt_location(adev, &adev->gmc);
>>>>>          return 0;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>> index 94d6631ce0bc..2f6e338f2a35 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>> @@ -714,6 +714,8 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
>>>>>        else
>>>>>            adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
>>>>>    +    adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
>>>>> +
>>>>>        gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
>>>>>          return 0;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>>>> index 5bdd4b9b7893..e5096b9cdf50 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>>>> @@ -770,6 +770,8 @@ static int gmc_v12_0_mc_init(struct amdgpu_device *adev)
>>>>>        } else
>>>>>            adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
>>>>>    +    adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
>>>>> +
>>>>>        gmc_v12_0_vram_gtt_location(adev, &adev->gmc);
>>>>>          return 0;
>>>>
>>>
>>
> 

