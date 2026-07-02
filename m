Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A572C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 12:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B973D10F31B;
	Thu,  2 Jul 2026 12:18:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JrxIOVjO";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2D7E10F31B
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 12:18:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PysjXt4+Fym4V98xksebT0YyEqq1r0mh4NLhBruS7a9RKgPXsIHQjWwgaNKI15grTRBeQoq4RxrqHKmfHtlHxpd130SL1eohlGhb0DL9NT2iLMvJ9NJuJcug5egsDq/p6aegCrsDrNfQwMnBaR6oaCfC1C3dB0JrKCJfb9DVmzDaPBsJ+WDh83Ym/7FCgyu/Gux6r6wpt+W6PQq2pEE1t4g0dNgtbFw2bfK3odmvYlAvmRMlLEJ+HNzR5xdbB+Hsj0NMVqRNIM7aqFCJeC5SwPpTJiIzFDp2FQo22DSTuyRgLYDzK6yeHlGjdmMa/gKZMjPwMrnuUJhrQqB5nA2gBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHNltuVHLXqAMR4NZnE0m92gFCTJZ+W3ueaSlcl9dwQ=;
 b=GO5YUd7AqEDTuXhghYbAPsbLP0OryRgOtJ/x84ASpVTfzt/dvuDOeFTIL2maym/aSD4zqVk076mriuuUX4gaEqJ4R+oaFYNm7k7VWUzrjIZMy6e1Kyic6xP1EWygxKcWvznrgusTZWf4Y0JxYH3t2e6bfF3uJqJiW4MZXD3FKRpxDhMhZX1m54j9Kf0fgcE6/FbMNVwXKlUUNT2tuLsJbrGpSU88iEy507IFhCbkDSELTnmC6GhdhDR0TObpvXHGAJVaJOcLnc/ud9Z2GTpdD4ruliI9xZ9JnHbPbt6/p0JEpQVoOOmcKc5JFyEFZf9hX7Jk10wIN/vRJK59RGNMgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHNltuVHLXqAMR4NZnE0m92gFCTJZ+W3ueaSlcl9dwQ=;
 b=JrxIOVjOi3S7+gDwRmr/7oly1GpI19HwHWFf0/oKgFnHE2xOuOMoyqMdhc68m9wBoc9WKMpJp1OPopwDisVd+PQ2920/vl3JAEXnzrQ6hj9NW9FnL2KgMGMyEhMzzcGte75dG5Q257+odiJ+rgncPSW0ul/xx9oUh56inpKiEP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DSVPR12MB999192.namprd12.prod.outlook.com (2603:10b6:8:496::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 2 Jul
 2026 12:18:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 12:18:51 +0000
Message-ID: <24718594-f84a-46a6-8c27-ec6729647554@amd.com>
Date: Thu, 2 Jul 2026 14:18:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] drm/amdgpu/vm: Use init PTE flags and NOALLOC in
 amdgpu_vm_handle_fault()
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-11-timur.kristof@gmail.com>
 <44f84ba4-e91d-4cf0-bf82-635b03e668b6@amd.com>
 <27457954.1r3eYUQgxm@timur-max>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <27457954.1r3eYUQgxm@timur-max>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0399.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DSVPR12MB999192:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b05581d-cace-4b3d-9d87-08ded8341344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|4143699003|921020|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: V+WvrFDcgaE136S5wa5bsVMkt6PL1uIzUkON07e6P7QgS8vAH3kk1qb6Vj4ZuH8RB1JAOBIghS6JivQMdXh4/vtuA96ABHJPsk/CqyXkscrx/3UXhlHYrp1UUQsQizwPUU+1L8snrH5vN1+WhnSv56ZjEBVTBZtBq1jIMn+ODUWgJx4mvrHiK5mrtVuHwdWw5sRKfPFKjAuP7+JKPMZ70IwfwJ2WfPzL5GJqTsrAmIoC4SIYOA8TkMTAuoBFMvrOsILWDXwwVNqmws9T5yGPkOC7fY6DTVlr4BFFgWxOvr2qlJSdbDRM5GMzVl1N7ES3hgwncQzqa0xXBK/spxKcX1n1CVqnldJ21nictIKhLRinbrNm8D2XX9k+s8DSu6X6EilIBvOYiTVirD0515kGSS+kbJkohtbzU/o1P2q81fMdO/oDhLIA/RxuzgP56LucgUA+s5/3NPFSZ6NBQ4Ea4Ah2WsX2QIxFaJgv0YA9dj59T+kAhQspwc2Wq/EF8sGPm7I2DK4B5u6tKSLSKmKOxHDG0Ouo6yGpcU8bki/8wsLo0B3UhcyDxmo2t1+zhkavR/psOq7mBiAdoCry5SgmHz5mlshkYtxYQIcSgUsViliQmEphAB18ohBXGINg2C8a2+l6Avj+Y7GT/+1vmWXkK0bnXHy6nrHDa9nwlai0DuLA67Vhro4zZZrY93YzQBUsAJ5GK3QHjyWacCO6i0Twmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(921020)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHFIRFVWQWE1ejhuaGRjUmdDblMrTWlrdUxhMVMrQmppbXdvVERJM0RFVE1B?=
 =?utf-8?B?VVV1V3QvY0dkdW54MmdIZ3JFR1BBTU9ZNk9QRmlKU0FOM1o5UEhpOFQvRHdz?=
 =?utf-8?B?U095Rkx3Z0owNGJDK0xIMkVNaU5aakFxdWJpdzlMVzFqY2tlcE8rMGQ0YTNt?=
 =?utf-8?B?VWtOUUhWc2xHWHpPeUtnS2JwYkJHb2dJWDhlNGtGSlphdmZaM0V0VG5WcGI1?=
 =?utf-8?B?cHFiUnY1N05PL3JFUnQ4QkpSdkQwRHMweHNhRVFBV2RKdmVrTG9kNllKMHcx?=
 =?utf-8?B?QWRDdTlWQkw5dEI2V3pwUjh5VDVTNHF5eUtZYUY1L3lVVmVkUFRSZitTK1FT?=
 =?utf-8?B?Qk51QjN6TmU1Tzh4R0EyNU5sT2hvUGcwTHYzYitFdWMxQ3p5b2w0N21BT080?=
 =?utf-8?B?UFh5Umo2ZHZGbWRxK1pYRk1aSzZzOTFzdmRBMmVLWGx1dUhUZ3ZsMnAvL25p?=
 =?utf-8?B?Y3NxY2k0ZW5tTEJ5bS9LK0ZjbHNkTUhaejlZZUxGVnYyMzJHZVE5aERCcXFp?=
 =?utf-8?B?Vk1FQVEzMmFsS1lVdk9HdlEvS0Q0b0I0UW9veVN1VklYNHgySGR6ZGplN2w1?=
 =?utf-8?B?dHkyaWpuclZxUnJlWkFVUVc2R3VsSmVDUldGajNpc2VpbWZVQWE4ayswNE1O?=
 =?utf-8?B?TWZPcGtkRHhjbHR1OUcvUjFtLzM4aFhpY3dWMVZJSkxvTWRTRlZxWXVPQTFm?=
 =?utf-8?B?bkY2eE5UbDlqZnB4aGhybGpxckUyTDRxaUJUcE45MXJnc1pBYmVVaUJmSDRu?=
 =?utf-8?B?Rnp5RnJUWS9EL0IrK0YvZXdQa2tpSFU4NFpubDhTRG5PdVhUR1B5Q01EZEJa?=
 =?utf-8?B?NW5SMTQwejRxeE5NcW9naFdVOUg2S0VheDNkVk8yN0g0cE9ISGRrMDBFbS83?=
 =?utf-8?B?Vk53WDlqYTdKaXBaZHZyNlg1OEF4eDNSQy92ZTZWOWplS2FMNUNDMEd6eEl6?=
 =?utf-8?B?czZseFN5UnFGL25rcDhGN0c5N3Q4S3ovNVhxSXlUUGZ6KzVxa0UrV2hZZ210?=
 =?utf-8?B?UXVPT2VCVTlOekpnNWhzSHNoa3lQZWEvSVh1cXNsR1hiR1dQRW8wNkZDYUFE?=
 =?utf-8?B?NUU3bCtGekJXNndpOWlHZTNnVVltMlhod1J4c3hxR0JjNDVvS1hSSDVSLzZM?=
 =?utf-8?B?aTNpYVRybkQzUmV5UU9PU1N6ZVpXWk5MclF6NUZZemh6OHV5a0tXNlVUN29y?=
 =?utf-8?B?V2dsRVJoeEFwZXlKVmNPWGVmSFFXaVhLbUZvYmRpNWZUM2xXR3JMcW9vc09Q?=
 =?utf-8?B?ZDc3NjdtWkd2YzFIT3N3QzYxcGErbUgxSlZpeU9uMWlrQmE3aHk4SzdhL0tl?=
 =?utf-8?B?OUhpdDlHQk80ZE5WN1VyOUN5amxNNHZ6NHJIQVhoeUMwdGxPVGVneXBvVTNi?=
 =?utf-8?B?ZnNpRFZpV2JIYzAyRmM4RStTSUVJTlFCSGlOeHl5Wjgyc0RadmpFWkJxelJN?=
 =?utf-8?B?VUlJNVdLNG9DS3NweDhxZmVyV3p4aGI3ejZWMWpiUmdiMzdib3pNYVRpME9w?=
 =?utf-8?B?L0IxSXAwMHplVXc1OWkvZWsvNnBLZTZZKzRDQ1ovd2MyM3pYVWc1YW9ObTVy?=
 =?utf-8?B?OU84K2w5b1d0QzhvRFNSMjJOdXlQbGE5OGFrQWhFdWlaVjR1cnBEa091UGR1?=
 =?utf-8?B?bk50eTVyeHFkaUtCUmx6NW5OMjJaTnZtcWlzMXZsd3UxSDZkdnBmNHdXMEV2?=
 =?utf-8?B?ZzVaLzVidnovNzNBODc5RkRNVm1hSFVKSFlwTVg0M1FhT3hnK2hCaytwVnli?=
 =?utf-8?B?Nm8zUHV4TmM4eDd5S2FGRldlTURFcVNPUUZPQmNhSVRndVA5TU9FL2hwN2xD?=
 =?utf-8?B?Mk5qTE94MENISGYyM1pmZzhUbEw3Rkh5OVp0a3hpN3ZRVmVqVmZ1VmNuWkpJ?=
 =?utf-8?B?V2kya0F0WXl1Z2N3YnlMRU9KM3RlWG9wSW1mSi9QK2tBQ25zTm94TVpkTkhv?=
 =?utf-8?B?aTYvZU9QSDdYb1F1RWtMd1pJM1hLTDBJWnlQdGkyTnV6Wmp4M0xYSG9WUkhx?=
 =?utf-8?B?UXU0VmEzSk9HTnN6RWZad1NGeUpwcEovVmlESlJ4UWdNd1B1cFRnbVJvbUl1?=
 =?utf-8?B?ZzJ5RG52RjVFbCtOUDhjNGsyOEluY0wycndtajZ3czlTc3VFZC9Rd2tSNVY3?=
 =?utf-8?B?ek1LWTErbGZ2bFRTRS9oemxJakNTRTU4Y0N5U0MzWU1id1VTR0VLMmgwTmVO?=
 =?utf-8?B?Umt0ZmhDc3F1ZU9zVldHSnZlUVBRSmRjR0NYZTBQVmI4UmoyR2lDZThVRmNs?=
 =?utf-8?B?bVZZcnB5UWRFaU8zeEJPV3JKUzFHZ2xjdVVON0ttSEkweTZQQTZOWHRyNDM1?=
 =?utf-8?Q?1Xx0Mrezw94SyDvLYa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b05581d-cace-4b3d-9d87-08ded8341344
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 12:18:50.9602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: br9kaxT4r3ZmwsTFI3VMWjBZgBq0DjSJ2SqU/vwjRvkoRChGVuKT1V4lpBg6Euyj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999192
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

On 7/2/26 13:28, Timur Kristóf wrote:
> On 2026. július 2., csütörtök 12:22:23 közép-európai nyári idő Christian König 
> wrote:
>> On 7/1/26 18:17, Timur Kristóf wrote:
>>> PTE_IS_PTE seems necessary for handling retry faults on GFX12.
>>>
>>> For reference see:
>>> amdgpu_vm_pte_update_flags() that explains the problem
>>> svm_range_get_pte_flags() that uses the flag on GFX12
>>>
>>> Also add NOALLOC on GFX10.3+ as we don't need to allocate
>>> the fault handling PTE in the infinity cache (MALL).
>>>
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index 32719f31b6c9..a915d061085f
>>> 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -3044,7 +3044,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device
>>> *adev, u32 pasid,> 
>>>  	}
>>>  	
>>>  	addr /= AMDGPU_GPU_PAGE_SIZE;
>>>
>>> -	flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
>>> +	flags = adev->gmc.init_pte_flags |
>>> +		AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
>>>
>>>  		AMDGPU_PTE_SYSTEM;
>>
>> That doesn't make sense the PTE flags should be adjusted to the device
>> specific flags by the callbacks.
> 
> Can you please elaborate on what is it that doesn't make sense here and why, 
> and what you recommend to do instead?

I had to dig up what the problem here is as well. We use the ASIC specific AMDGPU_PTE_* flags directly.

Instead we should use the AMDGPU_VM_PAGE_* flags and then call amdgpu_gmc_get_vm_pte(adev, vm, NULL, in_flags, &out_flags) to translate the AMDGPU_VM_PAGE_* flags into the ASIC specific ones.

This will automatically add flags like AMDGPU_PTE_TF and AMDGPU_PTE_IS_PTE etc...

>>>  	if (is_compute_context) {
>>>
>>> @@ -3054,11 +3055,14 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device
>>> *adev, u32 pasid,> 
>>>  		flags = AMDGPU_VM_NORETRY_FLAGS;
>>>  		value = 0;
>>>  	
>>>  	} else if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_NEVER) {
>>>
>>> +		/* Don't allocate this PTE in the MALL */
>>> +		if (amdgpu_ip_version(adev, GC_HWIP, 0) >= 
> IP_VERSION(10, 3, 0))
>>> +			flags |= AMDGPU_PTE_NOALLOC;
>>> +
>>
>> This doesn't make sense either, mall allocation for the dummy page should be
>> perfectly fine.
> 
> I think we shouldn't waste space for this PTE in the MALL.

Hui? The PTE doesn't enter the MALL, it is the dummy page which enters the MALL and since it is only 4k it basically doesn't waste much space.

Regards,
Christian.

> 
>>
>>>  		/* Redirect the access to the dummy page */
>>>  		value = adev->dummy_page_addr;
>>>  		flags |= AMDGPU_PTE_EXECUTABLE | AMDGPU_PTE_READABLE |
>>>  		
>>>  			AMDGPU_PTE_WRITEABLE;
>>>
>>> -
>>>
>>>  	} else {
>>>  	
>>>  		/* Let the hw retry silently on the PTE */
>>>  		value = 0;
> 
> 
> 
> 

