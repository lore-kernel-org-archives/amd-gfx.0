Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB935CC6B33
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 12:23:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D42610E18F;
	Thu, 15 Oct 2026 12:23:26 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013061.outbound.protection.outlook.com
 [40.93.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2DDC10E18F
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 12:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NonY4nzUdbJTEN4Lexz3VauhkF+H/XfrGR06RGEyQy1tP0kpcrku4LYl9CGFsXl3i2xnAaDu1aWg34bcNT1PeTNRtFgdeS7VkYHbjEq+0D04BLuXkqIT8oANGTlEBJKtGjjDBQnUtgZv+G8kfnQ4fgtmfr+15x6tkMBnpM5baxkf3ZFPOmteLz0GaHRxjH+2Xg2lTQIi1sLtypG8/N7cNuoVdD0gQDT/5jMPGyy2/0b+7XcVenq6x8YKXhng8XzFLNkDwsiG2RxhzfdYkd19h0i4wGEnxnwEvbq2/CuKcgNF8BP3bbTjelleZYhlffpxE1FhxhEY1RoFLknRXz2jDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKO7gLydnYqUh/Kp98/ZLiz1GXVulyOx+zLJhg5oOaY=;
 b=pbYNBFhhZXVMgwP8xB0Sikk8gl88U0Me+3xYVn7RoRpY0VDViz7uylMogaM5EJAKYDthgYHXXBJf24mfaI90HohhewxvYPs4ERHZk4pUdXTWBNff5Pye04dG5ZgKIgyDpdf5QGk64Jx07C4RFUbAQL8QxIDiTSkF8fBCmK1lY+4Zrr9qIDxsG4FT3kYq4aJWKuQnj+qd1NaD1dUSI0lV6aiO9aalVp8WXqvuXTpluiEalSc+pyaZaEjgl/UifNl5aaSzcGMYrejF9w9+CgXjQ4y3rLNqY/XN7sZ4mk+qq9+Dv4m4pbCpCtBHBhqlWicpxygqDfiRaG/ZJ8UR9oBiFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKO7gLydnYqUh/Kp98/ZLiz1GXVulyOx+zLJhg5oOaY=;
 b=5HugBGlEAJ/GdHtc/qt6s52nIdHSyh29YNBgc+AiaiikwZ8fd01A9+PtuR9aMwWAhva7KVdYUSyZ7Y9O21g3nVFDbNPftsw3+DreCm05Mdxa9TnTeNC/tzLsdE0qO/UE0glpsV59TlSfuEHoRsPfNAp13xhdNIgVIr4cO3EGxto=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 12:23:12 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%3]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 12:23:10 +0000
Message-ID: <34ee36a0-d0d3-43ee-9fe1-b0a666e44d64@amd.com>
Date: Thu, 15 Oct 2026 08:23:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc_v11_0: fix flushing mmhub by pasid
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20261014150521.2766488-2-benjamin.cheng@amd.com>
 <fa3027ae-12a1-4a9c-88b5-f63c929853a2@amd.com>
 <2c40d592-71ad-4bce-b9aa-1918d0e7dd6b@amd.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <2c40d592-71ad-4bce-b9aa-1918d0e7dd6b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0164.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::7) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b77ca2-5ac2-4056-2860-08df2ab71376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rTjn83D7Z5A9G29f/SFkG0r/tY7lkg6L0/4+m3u3kF6lMwAaJuFr3Inlc2utdjbNxVmk1QsyErdz94yOhjJpzfU9L/4AoItpmXWXiWKnWf1/sKls2ZXnd95SyD8kadWbO+NVFMT2N3qq2oDi3/Yx5rtEoZzjldGyAunavTT50UMgR78JX3/kGHYLM+PisW1sMtUi4CgYmVa74hHjui63Rw3I2AYjMpaJGjEI9iVsGfTaXagjZMAVTDEd4UOFZKnFFi+NnTAiT/IiXEVQ8YQOAX/QKXfEhCe970/mqRyGPJFs8RBJJp5uW4MqyCWtgE4OcdCYcvWd9i6OIjaPvUk9GpRk53zfmbM5BdrxEl35Qscr2Q2cF1Rg1fWWReLvUimK/tp7U2W/VCwFHJTtVqMQNqY/Ucj2QgJlq2IFvhThT0OnrdJXsh8PVvGDPD23+66tWbrGKwLEwnkdSlHhKbYPbdPWtxthieyg2houYEDfmlnvYuwoccwn07YgOWarH2hxb5qXomqK7idUVS9CmkknFE3djrf9bI3SnfmW0zC1/6Nyq5KHzfa8W5wqlr7HKkkyrpmqUapyDFAtag6Lcyo7YoarZ+astUrLjhkPp5rqqs9QkpEnEpChY1p8F7aau5hWFg+0X0G4dhL89dffuORmu8CJ0rp+MlIGb/WhBn2N0fc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enFibTc5Z3Jkbmx1c2llZjQ1bWxSclhLUVpNNVFJTk5hdHZPRVhXbVhmU1dL?=
 =?utf-8?B?VlZqcEZWeWpYY1BzQUxaZ2JQS3QrUmZHUWFqMVlzeWxHeWVGWk10MWNLeG8x?=
 =?utf-8?B?K3ZCSmU1cy9NMkQwSmE1WStiYmkwM3FWMk84NnMwUmROZEg4U05SeUFnODIw?=
 =?utf-8?B?L2VBcmQvVHBGaEJjVWFqZk5qTGpUcFd6VTUzZG53Y0pKZGVKdE1hTC95WGhv?=
 =?utf-8?B?eEJ0aTVpbWNwZlV4bVlHOVQ5ckw5bTQvNWxQMGxQSHA0UGdYZFl4VFJ1bTFW?=
 =?utf-8?B?cjVJZnkzZUo4SlQ4aGV3ZkNkOGZNV3VHSmhPTDlxUzd6VzhHYUtXRG9FTW9C?=
 =?utf-8?B?UmdNcWN1NU45aGtTeDFjMTRoNVE2bXpTaUZyb2ZEYVlsdEY1ZmhraEk4UFoy?=
 =?utf-8?B?U0FPOVQvTGgwWkUyRlZTbEtpN3JGU0MwOUlFQldadGo2SUo3MEcyL1psVWh6?=
 =?utf-8?B?NER0YVNWVVpQMG0zbUJZRHZTbjZHK3AvblZ6dWx4ZXVIcmJaWUpycGpFd0xK?=
 =?utf-8?B?MCttanBxZmhXVTl6MlhHY2pzS1BDVHl4V0R3YVF6NDNKVUs2cGtqeHhodnRS?=
 =?utf-8?B?dHJUSno3U2EzZ2JJOE1EKzE5TzFETE9ZZW41MHpMbHZ0WlJ1ZVNkWWdOV1RN?=
 =?utf-8?B?eHBUdFBwQmdvUlJ0RFJMTkNmdUdObjZNeXdTNHJDb1BndWhkU0g5OEE2Wnp4?=
 =?utf-8?B?SWVKQVRXTlEyVzVlTXlCS29xNjVRZE9EaXljZCtaMVkrYU9QUHFGSDg2QjUw?=
 =?utf-8?B?ZnpZZjN5Njk1L0J5ay81Y0dxazR0LzkrbHRmMUluTHZOZUJwanZoOTJWM0p3?=
 =?utf-8?B?S1diV1F5Wmg5bFRjQUd1dzB4blg5RkppeEE3ZzkrdnIyVkg0UjNvUEpsN2FU?=
 =?utf-8?B?QytJdFRZODRDcTBVUEFOaTNWem43UmplUnViRFdSeFM2U01LZmNDeDBRUVo4?=
 =?utf-8?B?UzZNcDNXbUs2VmRXdGVyVEs1c05UL0Jkb0VwTEd5emQwaTZqM3BtWjZWZ0ZI?=
 =?utf-8?B?WHdsY29pTGpjTU1HbzRkL0x1WVBGU2V4WXRPbmdQTW5NTlN6aE1hUGllaWYy?=
 =?utf-8?B?WU1MRkZGT05ZSHhHU2QzRDVabFhhQWJJYmFNWnZYMys0VC9BWktvYk9HNlpy?=
 =?utf-8?B?aUVLS0tra1Q2RmtWUXY3MCtNajZXbDlLKzY5L0lVVFI3SHB0WnFpcmNxWWIw?=
 =?utf-8?B?OEpXSkd0bHBhTWlZZXE0K0gwOVRFMkVpRVEyQ0k0UGtQUjlKckUrYndJOU5w?=
 =?utf-8?B?Rkx0VGE1RCtrV0xEMXJIazVITzFIUVUwcmM5d09WckdUaDZZUk1ZNmhyRHI3?=
 =?utf-8?B?UmFpVXJOL2JGTkNWNjNyb1NVNjZlM2x0QjBtOVp5NC80V2NEMEtVbnJsS3Ex?=
 =?utf-8?B?UlVEUHRKdThvSDY0K2NHa0NUcGZ5cVNmSHltSzBHckUzRituckVwSk4zTXRI?=
 =?utf-8?B?OGcrQWZteWFYWHJrUmtxRXd1SWplZGlWU2JXa0Uzay83OHRlUm1KZTZoQnQz?=
 =?utf-8?B?L3p4L0RIT2hSdEIyNGlaZWEweGlpaVg5dmYrY3lnd1pNeDhNdmxzNEVtTUNE?=
 =?utf-8?B?bUh3bHFIbE5wQ085L1BXTlp5YVcvc0FyLzFrTnpzSlNISkRXOE5raTlpZWxs?=
 =?utf-8?B?bHI4emdhV2ZaSjBqdk1Ebmk3U2J6MzNZSHJGaGhJTWVOSGZNTE93dHdYT25l?=
 =?utf-8?B?UitwUlhHRDZzUTdIT2lhNUdRMFRMUEtMcGk4NFRPTjMyd1d6QWphSWtrck5y?=
 =?utf-8?B?ZVBXYXRiUEJqalVqQWVnNGVqaHcrMU15SHhKTU9SWitRWmFjaUQ5RnREM2to?=
 =?utf-8?B?di9kMWZtNkpKN1FPT1hDS1hhcW5LM1liUHRwMnlOcVlOSHBodlI5TytBTVRh?=
 =?utf-8?B?VmJOYzBuMXFubXZaOXVHZUtiWlZaVVphZkxWRHpWajdpc0ZhbkxJZ2EzaUNw?=
 =?utf-8?B?SFhVblBDc2FBUVRPREZYNFFtMnNENSs4V3YxWm1lUkF0UkhkL0p4MFdQcHVN?=
 =?utf-8?B?NUhDMCtQaGNPTjJZQW0zTU5VcEtzVnJOREdWSmN1SGFKZmlyQ2JkcUxVSWpt?=
 =?utf-8?B?TlRLckdJenkrTng0UCt2TExWaHpDNzUxN1ppblVFa0ZabnJrcmc3a3VQWnVQ?=
 =?utf-8?B?RGFTWkc4NElUbU5VODZINW5oM3VQR3JoSXVHY1M5OGdNSXJDSzNDNjVFcmZu?=
 =?utf-8?B?ZyswNkgzN1Axb3F1Smg5anlsN1dBQ0xkM3Y5OXB4NENpOFRMbEFmT3NYUVh6?=
 =?utf-8?B?MWM4MWxJSCtlZ0hYRnFabXEwallEZmF4QjhhcHJjbW1ESmZBK291Z0hFendl?=
 =?utf-8?B?OGI4YkwvQlExTjdKSFA0UTZ0bitST1BPd0x1TitCM2hkMjRDQjJUUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b77ca2-5ac2-4056-2860-08df2ab71376
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 12:23:10.5875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UktrpxNeCzrfw7FglQZzhQiMUTpe26o/Zi8Jegl7ir62/rv/QaNun0yCOKyPzkFpxm6riN+FF3IqQNskpQ/DOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282
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


On 2026-10-15 03:16, Christian König wrote:
> On 10/14/26 17:19, Benjamin Cheng wrote:
>> On 2026-10-14 11:05, Benjamin Cheng wrote:
>>> Each vmhub has it's own vmid to pasid mapping, but the code was assuming
>>> that a gfxhub vmid would also apply to mmhub and flushing mmhub using
>>> the gfxhub vmids.
>>>
>>> Instead we need to find the vmid mapping for each hub individually and
>>> flush with that.
>>
>> gmc_v{9,10}_0 have a similar issue, but at least by my reading they won't be affected since only KFD uses it there.
>>
>> gmc_v12_1 might need a similar fix, but I'm not sure how it plays out with the IH_VMID_LUT_INDEX. I'm looking for some advice on that.
> As far as I can see the fix is currently unnecessary on gfx11 and gfx12 and only academically interesting on gfx9.
>
> The per PASID TLB invalidation is only necessary for VMHUBs which are used together with userqueues, e.g. the classic KFD user queues or the new ones for starting with gfx11.
>
> Both variants only support GFX, Compute and SDMA queues at the moment, so only on gfx9 where the SDMA is connected to the MMHUB we actually need to invalidate the MMHUB as well.
>
> Now on gfx9 the HWS always uses the same VMID for all VMHUBs, so the current handling is actually correct. It is just extremely awkward and not documented at all.


Right, I had this train of thought as well, thus why I did not send any patches for gfx9.


> We could argue that we are going to need this when the MM engines start using userqueues as well, but a) I currently don't see that in the near future and b) we then need to use the MES for the invalidation.


I agree that without the MM engines using userqueues this doesn't fix any functionality.

But currently all_hub=true for non-KFD cases, so we are unnecessarily flushing MMHUB when gfx userqueues are enabled, and also I'd argue the code is "more correct" with such a fix?

I am doing some internal experiments with UMSCH on GFX11 which would require this, but I can keep this local if preferred (won't be upstreamed in the near future, as you said).


> Talking about MES we should potentially remove this code altogether for gfx12 and rather make sure that we always use the MES packet to do this.
>
> Regards,
> Christian.
>
>>
>>> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 47 ++++++++++++++++----------
>>>  1 file changed, 30 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> index 709c3d1b9998..715ccce8e4eb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> @@ -204,10 +204,25 @@ static bool gmc_v11_0_use_invalidate_semaphore(struct amdgpu_device *adev,
>>>  
>>>  static bool gmc_v11_0_get_vmid_pasid_mapping_info(
>>>  					struct amdgpu_device *adev,
>>> -					uint8_t vmid, uint16_t *p_pasid)
>>> +					uint32_t vmhub, uint8_t vmid,
>>> +					uint16_t *p_pasid)
>>>  {
>>> -	*p_pasid = RREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid) & 0xffff;
>>> +	int reg;
>>>  
>>> +	switch (vmhub) {
>>> +	case AMDGPU_GFXHUB(0):
>>> +		reg = SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT);
>>> +		break;
>>> +	case AMDGPU_MMHUB0(0):
>>> +		reg = SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT_MM);
>>> +		break;
>>> +	default:
>>> +		/* There shouldn't be any other VMHUB. */
>>> +		WARN_ON_ONCE(true);
>>> +		return false;
>>> +	}
>>> +
>>> +	*p_pasid = RREG32(reg + vmid) & 0xffff;
>>>  	return !!(*p_pasid);
>>>  }
>>>  
>>> @@ -330,24 +345,22 @@ static void gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>>>  					  bool all_hub, uint32_t inst)
>>>  {
>>>  	uint16_t queried;
>>> -	int vmid, i;
>>> +	int vmid, hub;
>>>  
>>> -	for (vmid = 1; vmid < 16; vmid++) {
>>> -		bool valid;
>>> -
>>> -		valid = gmc_v11_0_get_vmid_pasid_mapping_info(adev, vmid,
>>> -							      &queried);
>>> -		if (!valid || queried != pasid)
>>> +	for_each_set_bit(hub, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS) {
>>> +		if (!all_hub && hub != AMDGPU_GFXHUB(0))
>>>  			continue;
>>>  
>>> -		if (all_hub) {
>>> -			for_each_set_bit(i, adev->vmhubs_mask,
>>> -					 AMDGPU_MAX_VMHUBS)
>>> -				gmc_v11_0_flush_gpu_tlb(adev, vmid, i,
>>> -							flush_type);
>>> -		} else {
>>> -			gmc_v11_0_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(0),
>>> -						flush_type);
>>> +		for (vmid = 1; vmid < 16; vmid++) {
>>> +			bool valid;
>>> +
>>> +			valid = gmc_v11_0_get_vmid_pasid_mapping_info(adev, hub,
>>> +								      vmid,
>>> +								      &queried);
>>> +			if (!valid || queried != pasid)
>>> +				continue;
>>> +
>>> +			gmc_v11_0_flush_gpu_tlb(adev, vmid, hub, flush_type);
>>>  		}
>>>  	}
>>>  }
