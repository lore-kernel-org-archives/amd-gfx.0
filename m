Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA688C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 07:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7126E10E727;
	Thu, 10 Feb 2022 07:35:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C637B10E727
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 07:35:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4QT4oPlIiq8wp1EJAPEElQ5FMD6kyU2GxplZomjFJwIMcTLdqgsr2wsAqP1ochMuMxHGxzXtaiRrLS5hL75KR/R0D0UKMgBFJ44NnaPfhP3ZFOS9/FKljSwweWMZWY2Ge4cl6Cutt46eztO9dLhVANzTTR54Gb5KtqqZgqEYxeu1WajXA1P+jReAcmEdrq9YBHuTb4eQKpjbVNOyLQfBmh07ZiNnfpAVBrSlFn/Bua8V6HACkBq5XKTwtBVWN17/hXON0cp9AObYvY8EyR8b29yMZXSXVWOR9w+v8GP9k+Xt7jAQr8UmembxKrt9nifyqPIwpuFBR5v7nv3PjmSwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSd+ikVAiJ8akqqao+J8hDO0EkIfeY1Juy38w5j/RA4=;
 b=fed/3t/T88TrQNCMUkUw47sqzT1ZQt0gk3QnFODmN+hIJfbwfAaRjle+ab4ZWfgMPGxzE9HhgEJUTF/LH6nnWWbhGt/kzQyJLdNjSoYc48sQhK80mmkTs9i265vmGMAGTIzoKwSZonS+v+GXi7+Al5MRkT1tWR77mCoA0Rna8LpEgLUr1yCh93cwaNIg0LEcYtpUsl34lJCApYTie144/rJBcFbmUawQAxI3xBRt3Kh/T5uqCaZcaUoeIddvmyluzp1DXvlNaTGMpvgW5nNaP9vCIj/5ND5rVHs9UvcZbMqaju64NKdM1MFEdmhOMghd11itn9ycsFWWv0qCp+DPmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSd+ikVAiJ8akqqao+J8hDO0EkIfeY1Juy38w5j/RA4=;
 b=J+E2EhF7PnmlnpPIquInvcdC89cYmL1FhA3nTQzV2H8Fkj9NAqpL3ztSNpDJkcAvrmDJYJiomjnob+ZkKd8L3Zucrr4vqPRTBD6VWR1vCYyWfYHXwjeR/HYglCtEj5dnQn1g9llwCgkkEPrV/e/fKnWKFc/7/8n5rUOM9BMGGGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3892.namprd12.prod.outlook.com (2603:10b6:a03:1a2::11)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 07:35:01 +0000
Received: from BY5PR12MB3892.namprd12.prod.outlook.com
 ([fe80::5c63:88eb:f0d7:c523]) by BY5PR12MB3892.namprd12.prod.outlook.com
 ([fe80::5c63:88eb:f0d7:c523%5]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 07:35:01 +0000
Message-ID: <01cbfbe8-c08a-e7a8-7e23-bc1ccc5c32f1@amd.com>
Date: Thu, 10 Feb 2022 13:04:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: add reset register trace function on GPU
 reset
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
References: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
 <20220208081647.3025-2-Amaranath.Somalapuram@amd.com>
 <CADnq5_Pun3UPKJsTKEf4pu3R=UbbHAZDW5-=+pekTDx4TWsAEw@mail.gmail.com>
 <6a7ca5ae-6d78-b8fd-cba8-cd2dca4418f4@amd.com>
 <49e24f9f-4657-d3ce-e84e-abbaa56d3181@amd.com>
 <1b79efe6-20e9-5543-4b2e-fa09f97c8e9a@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <1b79efe6-20e9-5543-4b2e-fa09f97c8e9a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HKAPR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:203:d0::11) To BY5PR12MB3892.namprd12.prod.outlook.com
 (2603:10b6:a03:1a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa18ca7b-d262-4922-6e71-08d9ec67d884
X-MS-TrafficTypeDiagnostic: BL1PR12MB5996:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5996DDB15E0F89A5D43543ACF82F9@BL1PR12MB5996.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:400;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ea30IoleUCWO19Tb/UQhnHKNgJ8KgmkkZkhjiwPhqCdXYB69W630fROqZ8umDLLcTgQMocCWH/4lyhimvRw64bMe8z7pwPIbzKpZkTm+FPVXXx2qG0pFArvK5gMFEkh80xFTHsrCAG/tkznXsCPTNjVzSESTonLw0HVJjuOLwLzOj3q1b53Fx1RBDUAKaGdgnTYQ5Cc1aUbkFcTDMeOl9mIi3Lixuhk8nJ8KjiM8XwARyFyGj4PLyDGPcx1c8zV6DD0FiignJ79Qk1vNYrWnhyirHSQJhK3Kmx/5lPCQJ0zL1Io+UOFGs/ONxHi5FvNNbzyxoK1t8jUvzI+fa2kdTaEtk8FkvgXHtA+yMatOZUSULIadrTXq/RB9KBIv4V1A1/lwy94uFpGk8KN8x0D2QazWzv9PA/vnofkYvx7zzNd6187eeg3r6/moW601joSL78cNbP7qFz1PWd7MIjgxZnYJDpwWH35Oh3w0+cnMZaGke8vFye8MdAbKmjZuDFm1f1hyGXjg7atlfmCGFyVIwG+0+HP/rB4D2HcGRDEnVcPmIQLxDZrvHtnzeKheq9aVjeBBQaxBPDO89tRYx7aCHXVuBjfzAMNOWcqeJsT2Zr0WHXLdYSkPMNJhUJulPLVQk0522Bamm5YNJm8jOcj16Cqk+uCXO+tW7V1/+KrZCaxWv09Z/O2/OrPkWKRHS6kj9otxNJacCzKVxXj2qIssgdaoECElzNBSSJ2VOg4ioFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3892.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(54906003)(6486002)(66556008)(4326008)(186003)(66476007)(38100700002)(6636002)(8676002)(2616005)(26005)(316002)(8936002)(66946007)(83380400001)(36756003)(5660300002)(53546011)(6512007)(6666004)(6506007)(110136005)(31686004)(508600001)(2906002)(66574015)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVhMT09SbUt0OUVyU2lQZ3pGZGcxSENrLzdLVURMMXE4NXVEbXRSamxaTkpI?=
 =?utf-8?B?bElMRmE2MS8rSERrWmRpaDdDOUNCVVBUZXc4YjIwdlhuU1FGT2I3ZzlGdG1P?=
 =?utf-8?B?RW1BaWJXaDRMN2grUTB4bXdycDNjSEFHUTA0WDdWL1ZPTTMzOVYrSFpGZGtG?=
 =?utf-8?B?dEpoRlU1RHZFbW9PSUw1UXNBeFo5VDN0TzY5NU9aUm9uZmQyVDFZNDdpQjlC?=
 =?utf-8?B?UDhmQUhLYVF6S3dVTCt4NFJaaWFVQUtqcE9wY1VRQVYyd3kyNWZrNWNZWVFw?=
 =?utf-8?B?a2hBUWdDSWRLUmtvNldsTldSODEyd1J4Y3daMlh5WlBuUDMyY1FMOGtLUWdi?=
 =?utf-8?B?YlhPMWYvdVUzSklvUjVpQ1VkYTJwUmV1UUVNNEEzMU9jL3d6bmc0WForcmgw?=
 =?utf-8?B?Vno0YWoyRDJReTNJRXNuMU05cWpSOEwxMnVZNmJBOVhBYUVDdkJTeWdjOXpy?=
 =?utf-8?B?VjV1SVpYU0xxOEdMb1dmM1lFYW44ckZIZHpZM1VCUEQxQUJHakNmTWM3L1lZ?=
 =?utf-8?B?YmN2K2lSTm5uWGVFazE4ZldwcE41T0NJLzh1VklXNW1jTHFtamc2MWJERWhJ?=
 =?utf-8?B?Y2YzVTg1Szl0clptZXpaSXhkT2hhN3lURmUvS0FjU2VpZWZRMGdUT3lqNnFr?=
 =?utf-8?B?TXhFS1JiT2tTZW8xWG9pZWlLNFdXZGZGNU1vUUZqVG05Rm5Bb3I5R3NkZkoy?=
 =?utf-8?B?RVVkVWZrNGpWT1pTRXlCRllmRlo5MjBla2pFbFBna1NvTlN5blZRb0xseExp?=
 =?utf-8?B?Q29rc2pQbEV1ZmJYQXdEVUozSXlZUDh4ak9EVDV6bFpjVk9WcngvUTdvN1h0?=
 =?utf-8?B?d0hXTThoUHBZZkdGR2IvV2xDeXlhWGg4UVRkNURtVStyTUlZeVFmRDF0dVNC?=
 =?utf-8?B?dlJHdkRzS0lUWGpyOWFCQ0tUZVJWNmdVcGp0ajR6MkxMdjVoM2x0bEZqY2ht?=
 =?utf-8?B?Z2FpU29renE4YWRqK1FEN0FDQ2pMQ20zb0hDek1KMUFpQ0xWeFFPd1BqUm5F?=
 =?utf-8?B?OEdFVTRHOVl3ZGFwcGV3WFkyOHhESlRUUGxuTHZOaVlSYjl3eEV3ZnlabFFa?=
 =?utf-8?B?VUtOd1ZVS2h4ZDR0MmJUQzZHR0dnbGVqQUgrTXg4YU0rbHZ1NU5qRi9rM3pB?=
 =?utf-8?B?SVE2N2wxQmpjaVQ1Vy9JMGVTaGptR0U5Snk4MVREb2dtMk03OXJqOVFTV0Fv?=
 =?utf-8?B?YVFvM2RSNXcxaU5ZRit3RFpkRHF0TFVDOG55YUF0TWV5ZXVZZ0k3NGoreEcr?=
 =?utf-8?B?bFNXR0NNQTNzd0Z2VWszdS9NMlQ5blpZQXNiSzR4aGZGT0pvd0lMRGZvemhR?=
 =?utf-8?B?alE0bXQ2bmdDM3FyK2h3OWJ0anBEekJYb1puZmFGQ1pvSnM3WlFNK0dkVTJ4?=
 =?utf-8?B?TzhNQ3g1RDRKNFVQTjFSNlJ4ckROSHJHZitNL3UvYlJXaHlidG1uOTBJM0Zs?=
 =?utf-8?B?bTQrQUg1ay9uaG5iWVduQ3VIN01KOGJBSllZMkk2a09rN0dYaXFBMWdPTFZp?=
 =?utf-8?B?Rk5UZFhTSXVlZFdVdWpXQlowKzk2bzRPZWx2MmE5Q0FYTC9IeGFMbkJiTEFH?=
 =?utf-8?B?V0RwNGpUdnFpWGJNcE9udzdneWlrUDVUaURsUVpjRkNyT2hlL0FiN0dqMGwz?=
 =?utf-8?B?cXV1YlFZbVN3RnpLUDBidVo5V1RkU2ZCcktlRkJsRXYyUVBYcjBQQUJobFFR?=
 =?utf-8?B?ZWtwVE03VEZUMVZla2NxNmxoY0dub0RIRFpLZjFvNjRQbEdiUXdoanRLRldM?=
 =?utf-8?B?YTZaK1R1c0RSNVAvWnAvSmVvbEJkdTY1enM5bHVpWWxKTkkvb1lFWDRHL1A5?=
 =?utf-8?B?NlNyQ0o0b2kzTGNKbkJEcy81U3ZiWmJpUUxidTE5QjJvVUhiSW40T3lieFFD?=
 =?utf-8?B?OVBmNjRGRXBueklJeW1obllnbkVSV0tIcFpac2M0STUwRUJZbEEyYks3U3dr?=
 =?utf-8?B?WmxYbVdqMG5PaDZkVnVlb2luem9zNjFnSVdnekJtc3ZhMEk3UlBOeFMzblpI?=
 =?utf-8?B?Q3VWWVM1dVRBZlpUaWw4aThlNS85NXg3OVBZMXA0UVNiQUg1aTl1S0NMeWRq?=
 =?utf-8?B?L3Myb0J5NnVQeW5LSC9oaGdwUi9nVSs0MEhBUGRZZys0YlUxZXhSYjdXVnR1?=
 =?utf-8?B?Y0xhMmZSZVo5VVFpNHRHODBHYUpFYnpsZlQxM2hiK0h5enZqNTFjODFZN1N0?=
 =?utf-8?Q?ThA7DLPNAgI51IfwBmNO2gs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa18ca7b-d262-4922-6e71-08d9ec67d884
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3892.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 07:35:01.2667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzuAWPz839RYPh+/u/f9iAX0TvfJ1Z7ndqufjLvllI9VIlrHswv5bylJ76acAcd5oiM6V9K7NcYv5h7wsw+TTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/10/2022 12:39 PM, Christian König wrote:
> Am 10.02.22 um 06:29 schrieb Somalapuram, Amaranath:
>>
>> On 2/9/2022 1:17 PM, Christian König wrote:
>>> Am 08.02.22 um 16:28 schrieb Alex Deucher:
>>>> On Tue, Feb 8, 2022 at 3:17 AM Somalapuram Amaranath
>>>> <Amaranath.Somalapuram@amd.com> wrote:
>>>>> Dump the list of register values to trace event on GPU reset.
>>>>>
>>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 
>>>>> ++++++++++++++++++++-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 19 +++++++++++++++++++
>>>>>   2 files changed, 39 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index 1e651b959141..057922fb7e37 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -4534,6 +4534,23 @@ int amdgpu_device_pre_asic_reset(struct 
>>>>> amdgpu_device *adev,
>>>>>          return r;
>>>>>   }
>>>>>
>>>>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>> +{
>>>>> +       int i;
>>>>> +       uint32_t reg_value[128];
>>>>> +
>>>>> +       for (i = 0; adev->reset_dump_reg_list[i] != 0; i++) {
>>>>> +               if (adev->asic_type >= CHIP_NAVI10)
>>>> This check should be against CHIP_VEGA10.  Also, this only allows for
>>>> GC registers.  If we wanted to dump other registers, we'd need a
>>>> different macro.  Might be better to just use RREG32 here for
>>>> everything and then encode the full offset using
>>>> SOC15_REG_ENTRY_OFFSET() or a similar macro.  Also, we need to think
>>>> about how to handle gfxoff in this case.  gfxoff needs to be disabled
>>>> or we'll hang the chip if we try and read GC or SDMA registers via
>>>> MMIO which will adversely affect the hang signature.
>>>
>>> Well this should execute right before a GPU reset, so I think it 
>>> shouldn't matter if we hang the chip or not as long as the read 
>>> comes back correctly (I remember a very long UVD debug session 
>>> because of this).
>>>
>>> But in general I agree, we should just use RREG32() here and always 
>>> encode the full register offset.
>>>
>>> Regards,
>>> Christian.
>>>
>> Can I use something like this:
>>
>> +                       reg_value[i] = 
>> RREG32((adev->reg_offset[adev->reset_dump_reg_list[i][0]]
>> + [adev->reset_dump_reg_list[i][1]]
>> + [adev->reset_dump_reg_list[i][2]])
>> +                                 + adev->reset_dump_reg_list[i][3]);
>>
>> ip --> adev->reset_dump_reg_list[i][0]
>>
>> inst --> adev->reset_dump_reg_list[i][1]
>>
>> BASE_IDX--> adev->reset_dump_reg_list[i][2]
>>
>> reg --> adev->reset_dump_reg_list[i][3]
>
> No, that won't work.
>
> What you need to do is to use the full 32bit address of the register. 
> Userspace can worry about figuring out which ip, instance, base and 
> reg to resolve into that address.
>
> Regards,
> Christian.
>
Thanks Christian.

should I consider using gfxoff like below code or not required:
amdgpu_gfx_off_ctrl(adev, false);
amdgpu_gfx_off_ctrl(adev, true);


Regards,

S.Amarnath
>>
>> which requires 4 values in user space for each register.
>>
>> using any existing macro like RREG32_SOC15** will not be able to pass 
>> proper argument from user space (like ip##_HWIP or reg##_BASE_IDX)
>>
>>>
>>>>
>>>> Alex
>>>>
>>>>> +                       reg_value[i] = RREG32_SOC15_IP(GC, 
>>>>> adev->reset_dump_reg_list[i]);
>>>>> +               else
>>>>> +                       reg_value[i] = 
>>>>> RREG32(adev->reset_dump_reg_list[i]);
>>>>> +       }
>>>>> +
>>>>> + trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list, 
>>>>> reg_value, i);
>>>>> +
>>>>> +       return 0;
>>>>> +}
>>>>> +
>>>>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>                           struct amdgpu_reset_context *reset_context)
>>>>>   {
>>>>> @@ -4567,8 +4584,10 @@ int amdgpu_do_asic_reset(struct list_head 
>>>>> *device_list_handle,
>>>>> tmp_adev->gmc.xgmi.pending_reset = false;
>>>>>                                  if 
>>>>> (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>>>>>                                          r = -EALREADY;
>>>>> -                       } else
>>>>> +                       } else {
>>>>> + amdgpu_reset_reg_dumps(tmp_adev);
>>>>>                                  r = amdgpu_asic_reset(tmp_adev);
>>>>> +                       }
>>>>>
>>>>>                          if (r) {
>>>>>                                  dev_err(tmp_adev->dev, "ASIC 
>>>>> reset failed with error, %d for drm dev, %s",
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>> index d855cb53c7e0..3fe33de3564a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>> @@ -537,6 +537,25 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>>>>>                        __entry->seqno)
>>>>>   );
>>>>>
>>>>> +TRACE_EVENT(amdgpu_reset_reg_dumps,
>>>>> +           TP_PROTO(long *address, uint32_t *value, int length),
>>>>> +           TP_ARGS(address, value, length),
>>>>> +           TP_STRUCT__entry(
>>>>> +                            __array(long, address, 128)
>>>>> +                            __array(uint32_t, value, 128)
>>>>> +                            __field(int, len)
>>>>> +                            ),
>>>>> +           TP_fast_assign(
>>>>> +                          memcpy(__entry->address, address, 128);
>>>>> +                          memcpy(__entry->value, value, 128);
>>>>> +                          __entry->len = length;
>>>>> +                          ),
>>>>> +           TP_printk("amdgpu register dump offset: %s value: %s ",
>>>>> +                     __print_array(__entry->address, 
>>>>> __entry->len, 8),
>>>>> +                     __print_array(__entry->value, __entry->len, 8)
>>>>> +                    )
>>>>> +);
>>>>> +
>>>>>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>>>>   #endif
>>>>>
>>>>> -- 
>>>>> 2.25.1
>>>>>
>>>
>
