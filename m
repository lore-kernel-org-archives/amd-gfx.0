Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A367CA5FB1
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 14:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F57310E04F;
	Tue, 29 Sep 2026 14:56:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BgJyN55i";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3610F10E391
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 14:56:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2oAKku2zKQtK5VBdoaZckSetFfTH7n7uvUZTqPta9MnDPcRM8QV1zHDwVO1unLNhkkIyUNDXvKEC8KCAeKJcQ1lMnw3Ifd9ST4UmN4sai1V7SMAsaKHjr+HXbSP0QpWiFB99vmOnC0IPhRXmbT95BSRLDmoCBOwVAXsZ61RZgFPOrX5s7YavkVzSKzx50MNbhrbNse/3SDtul/V59KUIehJdBeFfsdPWLTk1xy2IiiOk0hAGayeN+HZr2kfvk9PHawmxoZwy9Q3sgsJ8ufmzgCJEnZuMU+IU6IXg9uBpZQAaB2NvH1R6h7XuYd9JnxsVk+Hke8WYfdFVQhaFdGDzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=em1SRO2Ngz3d4bFpWqwH8tn1rXPV2Ngglv70XLGHw1g=;
 b=nGJXbwUmE6/E+8rZRRbzBRgU/OXQYgwhfOywHNUcg2XKcy6G8IzH0TKVOJYKFW6npZCAnEuG95UPSLkWXAkAhubchM8nF7hxWiuVmvuLdpKqWpFm5QjWuSxHHnMAC0F95TW8dcsEL2gxFkPmYoqSB8ZOE+RdNIhzubKpEV+G+MXJqu4/dYkU19WibK6UtJN4nu+vBIBvNQFnkOKWSw+VOsxeqToZV5gAgX+bIGZOp+aCvbHVEDt/W/wYIcXLsJLU/bGN+KICbStbyVOjRkHDiFHMmoNLTWU5Qg/uMkVea5aqZeUETIJJO/0D50gRsAMHu2XuHJ/POBdrFu3NQx2/AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=em1SRO2Ngz3d4bFpWqwH8tn1rXPV2Ngglv70XLGHw1g=;
 b=BgJyN55ivnvneK264rrW1f9mvF7NBbMf4XxB3cuiIRNYlrwg7Jj3VBTnI+pZHlhy06ZnwGySkIR1vzEP6+WEtvYrESm8Ul7fBg+UbXAIGNIkH3ew4R1E0EMWE+9Q8O9eBbGHO9N/eWzhKiUE81bxcDs9CoCpXBuiSkZjng3YHWg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by FT1PR12MB227580.namprd12.prod.outlook.com
 (2603:10b6:170:e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 14:56:28 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 14:56:28 +0000
Content-Type: multipart/alternative;
 boundary="------------MlgOcjfWq0q3d49pXxbhcoRw"
Message-ID: <3233a346-d95f-49b4-9193-769e04493d8d@amd.com>
Date: Tue, 29 Sep 2026 10:56:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] drm/amdgpu: use spm_vmid for the default RLC SPM
 VMID
To: amd-gfx@lists.freedesktop.org
References: <20260928185756.2382322-1-sunil.khatri@amd.com>
 <20260928185756.2382322-9-sunil.khatri@amd.com>
 <fb63b082-0430-4711-b68e-d2eac63db26c@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <fb63b082-0430-4711-b68e-d2eac63db26c@amd.com>
X-ClientProxiedBy: YT4P288CA0080.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::15) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|FT1PR12MB227580:EE_
X-MS-Office365-Filtering-Correlation-Id: 85674373-0d23-4d35-c03a-08df1e39d6ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|4143699003|8096899003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iy141molHqgpAho+ojr7JcyaCebj/Mm7GeqafW3y90p6yk2iMcSrLJCYI1c9XJ90FI1P2vgwPxflX61Nf+qzOAJRhqUNF8PkS3S5+Ta+UUN2Dx2QSDW2VZIc9oDV43PPiFPqCpyj9+OFZNdOt8NyIpvnet9GqBdUJao9vfID3VV8lFXZ6vpqvME1Lcz1N3MsfU8ryOhg2rQA30/ww0Rsx+EOwG7/kleqyXQx7t+j1ophY1uA7iTVr1o2NY3wUdhSFIdk3AueQavbj4bl5OMCmGpnrAhoCQY70iYT85VHkgZECNSKiIAzvR7tozkW5vEp34ma5ti02gtuO4QNs1RunXD/xRz7HMuZBCWbl8SerQHVyVEJkBOJhfaCD7MNxIdHoiBPCjYPKsDUz3K1UTWEsfQnKW3K4zdmdVso9orIDM/4l2moAfAfdoP2czgAY1ywe1j9pl19b74wClORY6GVKZd+O1pCaxmzG1y+MVj0rvPVuLd9WwHD1PTbaCfY7egwOquzOxAsubxkQhyAj85Sr/f3Qu8e8uYGsMb8G5ifOol9nmR2rGwOcZIYs/iYoGnLUM450JyW+QOPoJkTVdM+NaDWXFYa00CQ542Z84OKOGQ8cDcMoSd9Q2USLp7XJznQ8JBgkomDngE8c4l9/DzYn4Hd4mcTlLBKGT4zZeAnmIQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(8096899003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWhHVWh6TjZXaEkxanV4TURWV0p0SnJNWFpDTHNaUUdERWJEZU91bENKWERl?=
 =?utf-8?B?c0FhbFhpRDJ2MExudjE1NnlaWnVQZ2dNT0dUeGI1dmk2NjZsc243YkNVMGFn?=
 =?utf-8?B?amtqbDBvWUp1dG9wZmlaM0Rtb1J1WUlBRjExSC9vTmkvSHYrR2RtL1hSNTJZ?=
 =?utf-8?B?cUNqTEV3Q0o1T21NckdnemIzUW4yYTdwMGNUbXBsUk90SEsvelJWekU1dFlO?=
 =?utf-8?B?N0xXV1VtRjZyUjVvZGtyM3Q0dUtWcHM2ODE3b3Z1MnVITTJ1M3NlM0RrdUoy?=
 =?utf-8?B?U2RyM1FmbXFsMk1aeEFVdzY1Ym05dVVTVWxaY2xlQ3c4VGJYd3pXVlMxTXdN?=
 =?utf-8?B?dCtaemtHa2JGZ3hXRjRLcFZiRFlnb045bExQMnZHU2ZIOVJJSmdNRnUzRktM?=
 =?utf-8?B?bkhoUFExdWxXcE9pdjQ1SjQ5Tm9UVVlCTE8xSjZGTmtaOFhhR2xyeTQySDBB?=
 =?utf-8?B?L0RWZkV2YWRvRWp3QUl2ek5jRlovelZBQ1hzL1pUV0FMcXNiN1ZHSlUxK1c5?=
 =?utf-8?B?MEl0ampvQ0x2aG95Z3JWdnAyQU1oRjJPaDNMYWlueGZ4L2c4NjR2MWRRb2Nv?=
 =?utf-8?B?cFJXSzBJc29leFYyZTRJY08rWTZrbFQ0WjdvT1QxSVU0MnplemNlbEUxRC96?=
 =?utf-8?B?Sml0V0ZMaUlSeFhUMWw3YkpvZjB0TUZ5cmR1ci93Qk9QMmdybmFKWm1ZMFc5?=
 =?utf-8?B?T0h5bFZkRGNra0xwL25KZUUvZUtUZCttVkNsZHpUbWxVU1JpS3p2WC93R0ND?=
 =?utf-8?B?YTVVQlhoWjd3MjB1Vy9panRvem1jWXpVQWs5TU8rVDlzVXQxQUhpL2pQSXlB?=
 =?utf-8?B?bW1mdndWeENFMWlHZGYvdjhGZVlmYVRiN1QrWkdQSEtxTVpjdDR3eEM0NENu?=
 =?utf-8?B?cE5sd2ViN1hXUHdRNTJOdTJkRXhRb1BIT3BFZ1E4ZDltanFrNm9qVFlNN092?=
 =?utf-8?B?L2l5aUdxOElVTS9mdDRVeVltK3ozeU5xcVZFaHVFaDJKY0FLZEVSWXZ4bWl0?=
 =?utf-8?B?UWt6SDFscmFGL09ZTGZZamJQaGJYSmZTc1lETmoyQm0vOHlvekkxMERYaG0w?=
 =?utf-8?B?UTMyb0JFakUwQ0huVnZtamJBbzBseTNqWFlkdjRVRGU0WFQ4elJ5VHpnSkJt?=
 =?utf-8?B?aU5EZGJKR3pKQUI3SzRDQ0xPRVphSkVBQ0dFd2ZRKy9SSWtKdy80bDkwR3Jt?=
 =?utf-8?B?MXFDYkRzVVB5VU1lUDhwNTJkTVRoYnZocTFtQnB6WFZDTUEyTEFNdThvWVJO?=
 =?utf-8?B?VEVkK3VRSEF3RDNqcjl2aG5wUlVEemF0dExvamQ0bkVHSTNYaU5sVmlqV3VB?=
 =?utf-8?B?YUtkT0VuckdVR0Nsc3U2R2dVQS8zRmVrMGVuOFJRUFkwK1R6Z1RCeTNkenRF?=
 =?utf-8?B?L1hBN2dnMVQ3dkZTV084NmQ4NU96ZGV2MnFwclRWclpGcGE2MFJrSWpBYmFx?=
 =?utf-8?B?WWFBSHZINTIyTHBOdHRkTWtWMVRTc0U4REZjZFVEbGJiQ2JxTWJqaDh6REJu?=
 =?utf-8?B?NmxVbjlBeFlsdmwwNDk4NU9DTk9ybm1iSWplR3J4S1h4NnBrZGo2ODhCU1dV?=
 =?utf-8?B?NWFKQ01aWWw3L3NPb0k2aUtBRlVWa3JLSTJHdXVHQTlyeUxQUXVrS1VkSW9I?=
 =?utf-8?B?bU83RTRaNUVlUlJUSHVYdC9yTWx2R0J4QkhzaTBKQWlWWWVySmQ5Z0JpN0hq?=
 =?utf-8?B?bGx5MFRlSklHZEdWU0JuRjZTN3R0SkltTHZ5Y1ZCQ3ZoS1RkQi90Z1FTajdE?=
 =?utf-8?B?Mnd1ZUlVb0NqandrRkN5dkRMUEphVjBNTkIyUWdXZ1h5a256MGxWMElURnFC?=
 =?utf-8?B?cTBUdUJkVDl3c2UzU1p5U2EyaE8yVDBtM2JUS2ZJTUpGMnZPQlJ0UFVXZWpm?=
 =?utf-8?B?bUF1RG1qWjhsM05SOHZrZUZKVFJYQWMvZVllZUlKVkx1UjUvbVpwNkZwdzJC?=
 =?utf-8?B?TXQ0THVvalBia2puakpCR0ZFMVNqM09KNXJkejhkQStNZEJnVHk1bEx2UlZ0?=
 =?utf-8?B?Ynh2K3hYUG5rU1ZKbU53Wm11WjZEMGdIWnRIaXpMQzRWcjRTUENIS0pxWkg4?=
 =?utf-8?B?cVJ1RkRqRFpoQmVtWldERkVGWklhc1pRSWJuMzVFZWFPNnZ1SjUycmt1L2Fk?=
 =?utf-8?B?YXhnSXJ1Ym5wdFNRT1FoMC9GTm91T0FIeTJvUExERytwNFdaUWJzUGRGZWtZ?=
 =?utf-8?B?YktaUzBad3BaTHJJK1gyN2FaWkpYOXJyZFQ2T0RYNDFaUktPY1M2SXFiUjU4?=
 =?utf-8?B?aFVBWDR5NVBHL3RDOHRVVkR3bndDNEF5TEU0ajJ4dk5rOXV6bmxsWFNVbHRm?=
 =?utf-8?B?bWpJUUdWdXpXZDFncGpwMlVZdElpUUVCcCt3RjZ1STdtL0hGRFBQZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85674373-0d23-4d35-c03a-08df1e39d6ef
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 14:56:27.9315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10cFQxEVsudAGjT2DPDUAzae4umS0AxEYk/IoA6oEJC9bBqIDB5a4nkTaLcAYLhOlGhagmJGgsYAYfjONP6v9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB227580
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

--------------MlgOcjfWq0q3d49pXxbhcoRw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/29/2026 8:04 AM, Christian König wrote:
> On 9/28/26 20:57, Sunil Khatri wrote:
>> The RLC bring-up paths programmed the RLC_SPM_VMID field to a hardcoded
>> 0xf as the idle default. Now that the dedicated SPM VMID is tracked in
>> vm_manager.spm_vmid, use it directly so the idle default matches the
>> VMID the reservation path hands out.
>>
>> No functional change: spm_vmid is the top VMID (0xf) on all affected
>> generations (gfx7 through gfx12).

I don't see the full series for some reason so pointing it out here.

We are reserving and using VMID 15 for NPA VMs currently on GFX 12.1.

Currently, we are using it only on MMHUB. But this may change in the future.

So maybe refrain from using the same VMID 15.

Also, since I can't see the full series, please look at 
gmc_v12_0_sw_init() on how we are reserving the VMID.


Regards,

Mukul


> You also need to remove all the calls to adev->gfx.rlc.funcs->update_spm_vmid from amdgpu_vm_flush() and amdgpu_ib_schedule().
>
> Regards,
> Christian.
>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
>>   8 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index 33403e16df5ca..88f9f0b0bf524 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -5583,7 +5583,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
>>   
>>   		gfx_v10_0_init_csb(adev);
>>   
>> -		gfx_v10_0_update_spm_vmid_internal(adev, 0xf);
>> +		gfx_v10_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
>>   
>>   		if (!amdgpu_sriov_vf(adev)) /* enable RLC SRM */
>>   			gfx_v10_0_rlc_enable_srm(adev);
>> @@ -5615,7 +5615,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
>>   
>>   		gfx_v10_0_init_csb(adev);
>>   
>> -		gfx_v10_0_update_spm_vmid_internal(adev, 0xf);
>> +		gfx_v10_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
>>   
>>   		adev->gfx.rlc.funcs->start(adev);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 7bfc8cbdcad85..036d1b7ade4e6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -944,7 +944,7 @@ static int gfx_v11_0_rlc_init(struct amdgpu_device *adev)
>>   
>>   	/* init spm vmid with 0xf */
>>   	if (adev->gfx.rlc.funcs->update_spm_vmid)
>> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
>> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>>   
>>   	return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> index b75512e7b1db6..4caa43ff50a1b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> @@ -773,7 +773,7 @@ static int gfx_v12_0_rlc_init(struct amdgpu_device *adev)
>>   
>>   	/* init spm vmid with 0xf */
>>   	if (adev->gfx.rlc.funcs->update_spm_vmid)
>> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
>> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>>   
>>   	return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> index 91764f2e5ad01..a3d72cbaa6cf1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> @@ -1848,7 +1848,7 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu_device *adev,
>>   	int r;
>>   
>>   	/* init spm vmid with 0xf */
>> -	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, 0xf);
>> +	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, adev->vm_manager.spm_vmid);
>>   
>>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>>   		gfx_v12_1_xcc_init_csb(adev, xcc_id);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> index 549d1239e326b..04ee7e1725a94 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> @@ -3252,7 +3252,7 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device *adev)
>>   
>>   	/* init spm vmid with 0xf */
>>   	if (adev->gfx.rlc.funcs->update_spm_vmid)
>> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
>> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>>   
>>   	return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> index ab4123ddbb942..61ba71b57b8e2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> @@ -1274,7 +1274,7 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device *adev)
>>   
>>   	/* init spm vmid with 0xf */
>>   	if (adev->gfx.rlc.funcs->update_spm_vmid)
>> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
>> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>>   
>>   	return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 1678015ce5a97..4862d17a58237 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -3240,7 +3240,7 @@ static int gfx_v9_0_rlc_resume(struct amdgpu_device *adev)
>>   		break;
>>   	}
>>   
>> -	gfx_v9_0_update_spm_vmid_internal(adev, 0xf);
>> +	gfx_v9_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
>>   
>>   	adev->gfx.rlc.funcs->start(adev);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> index 01ed1701c781a..add8099cf8e05 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> @@ -1395,7 +1395,7 @@ static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
>>   {
>>   	/* init spm vmid with 0xf */
>>   	if (adev->gfx.rlc.funcs->update_spm_vmid)
>> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
>> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>>   
>>   	return 0;
>>   }
--------------MlgOcjfWq0q3d49pXxbhcoRw
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/29/2026 8:04 AM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:fb63b082-0430-4711-b68e-d2eac63db26c@amd.com">
      <pre wrap="" class="moz-quote-pre">On 9/28/26 20:57, Sunil Khatri wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The RLC bring-up paths programmed the RLC_SPM_VMID field to a hardcoded
0xf as the idle default. Now that the dedicated SPM VMID is tracked in
vm_manager.spm_vmid, use it directly so the idle default matches the
VMID the reservation path hands out.

No functional change: spm_vmid is the top VMID (0xf) on all affected
generations (gfx7 through gfx12).</pre>
      </blockquote>
    </blockquote>
    <p>I don't see the full series for some reason so pointing it out
      here.</p>
    <p>We are reserving and using VMID 15 for NPA VMs currently on GFX
      12.1.</p>
    <p>Currently, we are using it only on MMHUB. But this may change in
      the future.</p>
    <p>So maybe refrain from using the same VMID 15.</p>
    <p>Also, since I can't see the full series, please look at
      gmc_v12_0_sw_init() on how we are reserving the VMID.</p>
    <p><br>
    </p>
    <p>Regards,</p>
    <p>Mukul</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:fb63b082-0430-4711-b68e-d2eac63db26c@amd.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
You also need to remove all the calls to adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid from amdgpu_vm_flush() and amdgpu_ib_schedule().

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 33403e16df5ca..88f9f0b0bf524 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5583,7 +5583,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
 
 		gfx_v10_0_init_csb(adev);
 
-		gfx_v10_0_update_spm_vmid_internal(adev, 0xf);
+		gfx_v10_0_update_spm_vmid_internal(adev, adev-&gt;vm_manager.spm_vmid);
 
 		if (!amdgpu_sriov_vf(adev)) /* enable RLC SRM */
 			gfx_v10_0_rlc_enable_srm(adev);
@@ -5615,7 +5615,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
 
 		gfx_v10_0_init_csb(adev);
 
-		gfx_v10_0_update_spm_vmid_internal(adev, 0xf);
+		gfx_v10_0_update_spm_vmid_internal(adev, adev-&gt;vm_manager.spm_vmid);
 
 		adev-&gt;gfx.rlc.funcs-&gt;start(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7bfc8cbdcad85..036d1b7ade4e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -944,7 +944,7 @@ static int gfx_v11_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid)
-		adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0, NULL, 0xf);
+		adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0, NULL, adev-&gt;vm_manager.spm_vmid);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index b75512e7b1db6..4caa43ff50a1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -773,7 +773,7 @@ static int gfx_v12_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid)
-		adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0, NULL, 0xf);
+		adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0, NULL, adev-&gt;vm_manager.spm_vmid);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 91764f2e5ad01..a3d72cbaa6cf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1848,7 +1848,7 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu_device *adev,
 	int r;
 
 	/* init spm vmid with 0xf */
-	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, 0xf);
+	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, adev-&gt;vm_manager.spm_vmid);
 
 	if (adev-&gt;firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		gfx_v12_1_xcc_init_csb(adev, xcc_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 549d1239e326b..04ee7e1725a94 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3252,7 +3252,7 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid)
-		adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0, NULL, 0xf);
+		adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0, NULL, adev-&gt;vm_manager.spm_vmid);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index ab4123ddbb942..61ba71b57b8e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1274,7 +1274,7 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid)
-		adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0, NULL, 0xf);
+		adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0, NULL, adev-&gt;vm_manager.spm_vmid);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1678015ce5a97..4862d17a58237 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3240,7 +3240,7 @@ static int gfx_v9_0_rlc_resume(struct amdgpu_device *adev)
 		break;
 	}
 
-	gfx_v9_0_update_spm_vmid_internal(adev, 0xf);
+	gfx_v9_0_update_spm_vmid_internal(adev, adev-&gt;vm_manager.spm_vmid);
 
 	adev-&gt;gfx.rlc.funcs-&gt;start(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 01ed1701c781a..add8099cf8e05 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1395,7 +1395,7 @@ static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
 {
 	/* init spm vmid with 0xf */
 	if (adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid)
-		adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0, NULL, 0xf);
+		adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0, NULL, adev-&gt;vm_manager.spm_vmid);
 
 	return 0;
 }
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------MlgOcjfWq0q3d49pXxbhcoRw--
