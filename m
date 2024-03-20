Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A124FC54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 15:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E819E10F17F;
	Wed, 20 Mar 2024 15:37:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aHJpLs+V";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1124B10F17F
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 15:37:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuGesUbyn8PSq0mkCVMtAZsptOCbg2jq0EILYwAHBK3QzMKotHOm1n5Q+/UwYqmaHF3AxTuDeCi15wyCygRBNIajzpVNAsxaLsRAhOMT/JNqqngZPpOYHHkoHoEo9KcBsQgx0BVp9rvResQ8yyke1akYqPS1/7P8JveCNs1Kei+uxIspQf6DoVpp2mPtwVNTRETKdoXL9eIA4e62AcEzo6U5GzIjhAPncht+tTwu4oVCPEf9Rm42qu+mVWa7+gJWr9P89pV64abhcMOgEuRLiEVR8IIn7Ngy+4vxGDf9WwOuvmknfLnp8ECsyCcvlR+dkKmAHEm05TBtTS75K3uRAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cxhn1vxshmqhtVHvPfHwJtv6kg7Rrg7nZPFHTG0EVM8=;
 b=NGLOvb0Dc8Z4gbzup9aZHFVLZukfJiZPnDdoirrFWmTKrykIQl/b1HF2uVmr82zHQXlTV2WNLw5PMCR1dXx3fqYNqsSBOoWEwmesQ1vrmjsYsfHVJVKXwvBZ5lIvONxHf9g7uJHEiV4l/U2zT1fzky1F0VXOxS97JVXKmVQIQIkPgfABoEmWK8kmzHrHhhA5LkbYkMnmYd7LoQieMFCUnlwykgFz+r3UozfB0G2au4cKvZ4yXhzXptj2r7tm9CP8oqY6mkU/7B94mPmQmeP5oTjplo7byPvymK+fBwkVckjJM28Ep03uaPHW93ayjXieTkYh7Hef7D+J6sVZEJgeog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cxhn1vxshmqhtVHvPfHwJtv6kg7Rrg7nZPFHTG0EVM8=;
 b=aHJpLs+Vhqx1RfrmTbDQFEMBSGVMeB3FB9vqtVYrks1fap1XsZ6BNag1hu3fGJUP233bK3wzVKp6pyy3VgcaGLg2X++Z/g/NA0ogs+kSAW8VkCY+Cl1J9slVCnGvu2K5OsoyYublI2ULCyhjnK6k3VmfEO+1YZfO3MRZufCxC/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 15:36:58 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 15:36:58 +0000
Message-ID: <184fd2ea-edf8-46e4-9e53-05fccc45015c@amd.com>
Date: Wed, 20 Mar 2024 21:06:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix format character cut-off issues in
 amdgpu_vcn_early_init()
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240320084513.3026222-1-srinivasan.shanmugam@amd.com>
 <5d46d7bf-d487-4a60-9f73-7146947f989d@amd.com>
 <db154f26-6af1-41b2-a3ec-a4fd2afe0d5b@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <db154f26-6af1-41b2-a3ec-a4fd2afe0d5b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::33) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: d698700a-fd3d-438a-0be6-08dc48f393fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGCBgl9IHo6CC1yJjEcS3XJ/BEyzqr38Fwm9SyKcRMCSdtsprBvMUrTcbRHqE1EeCgMFhAKA03BlP9yGnic3xNI8L0dh6xffovfWlz2sN51WaYZKt9JZBOUHGOxOiPWWXVCkL9ToCdq4uwnICnodrwHcaSzEnM0HPr9fJKZMJSzGVQJxyRxso93TwpTnwqh2+QCeoalMpDFLsfHPyk7xUM2k4N1/6opXWB0WuaOssfp7FA6WpSZypQkJNIKiUqpXFDHdSvkyketTdjlL0z5e792U/Xw1XhBAQ5qdP5OJyxa9RwSwX4Kn/gLrKe34IVAyz6jYK36XiqNyUDiXV1HREIa3QxQWIg2/y0ye5cX4OzAYE9pbABYIDySPwrckVCzByS7HkRHVR/pwkNEhE+l6Z7wUGwkaNaNPYYY0HnNWEzPH5z79eV7rWGcRD89fZxV0oGO5At3ZgeEuJPfhn+hwCzPj2rNjM7cW5CXTxA3BPbL6u5BEmFm+rcul9/IbS2zD4fHs2w/N+2omJDZHT3RG9jSm1gdhuqN+tHsEhOPMWckPrzPSmRMoqS57VgcHg/KXzKjMSLOHJHKzTqWTDLZH2qj3OEApfFyoXQV9+XBz2IbhgBNaEyTHlCtvr35kWXyabq2XZwOpNI+GsHbcnUDUiev4RqH4wDMIL43Py7sxncs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlA5bDBoazE5Nm9jZlFJejRrSTk1ck9BVzc5Sm9oMkV2VlNmSEgzdFVnazZa?=
 =?utf-8?B?YzFkWEhLYXNhdkRYbGpVcXhYY21Yd2dEenY3V0VCTm1YYXg2K0p4THV1SThL?=
 =?utf-8?B?Y2FvNWRZMVQya1l4ejhvTFFmNXpYRGJocWtaM0VFRnA3RTl4VWQ2TGdqVnYy?=
 =?utf-8?B?VXFweVc5Ky85N2ZqNXdGSW4xK2ovUis2ZjFWUytGSFVGWksyc3ZreTlRWitL?=
 =?utf-8?B?ZWRKdnkvK1RTMUMrWFVxU2lCOThuaHRRNm1YeE9Ea1RIZ04vWG5lUzl6bG42?=
 =?utf-8?B?RVl6Y2NFcWJIbnI2ZzFObjJZa0taTysrWWtUM2pqUlQzN0RuQ3FPQXZUclI0?=
 =?utf-8?B?U1lEYmE5Z0lhbFBSbHZoNm9SWXJlWkZjQzM0YUZJN2R0aDVaMEFJRm1KR1VE?=
 =?utf-8?B?NXJ5VHBRYWdXbEwrTUJUZTVyaVVZaERjbTAyVXVZai9VWVJyczdqUy9EZVRH?=
 =?utf-8?B?MkJteks2aExjeU1vUmZsNC9IMWpmZUFXN2NrVlhjd0ZkUEIrV0NBWldwNHRZ?=
 =?utf-8?B?dUVrN2t3MUREV3FuYnlFY2xCRTFCampoNWFYVTc1VmtFYk1HWllscFU4b1FZ?=
 =?utf-8?B?VDNCZ2hLTksveWpzTjFoQ25GR011RGkvYkg4MkZHVkxNVXNrWnNJdk80eU9J?=
 =?utf-8?B?U2FqbStWSmhlVVZJK3B1MmpVdUltLzBwbnRKWEl1Qm1pUEdZbEdyTmhTV2VK?=
 =?utf-8?B?TmdWZlJ0UnJva0FxQzR3U0tBVm5QMzdZNXlBY0pJbVdVamdnUGk0dndMaW5o?=
 =?utf-8?B?ajhjZlhpaFlUdUpHbGFWbTk2ejh3NjRuZFF6ZktmMEZqaXlsanBqclRITDdT?=
 =?utf-8?B?dHV6WWkxME9GQVY0N2xnWHdBYUN0MEd2U1IvSEljd1MxUFRlL3FhTDhvM2ti?=
 =?utf-8?B?RFBIS3RGMGZHYWlZQ3dNQ212dVZjR2FuVDZqUVFpaVk0aExVWGMrR0hGRnlo?=
 =?utf-8?B?bm9ET2JFSkJUZkNHSEEvbDlxeVAyamdEdDJYUW9WbVpmTkhrUkRZcnZRNmVq?=
 =?utf-8?B?RlIrRmMvMnN5UWRqdjhyQm5sL3p4TlB2U2xQRkJ1QVY2Q0w0T3dKSXpBSnBP?=
 =?utf-8?B?eTZZcmxlaGxwUDV6NGhDNkxqNmRIblJMV05CdmJVdlo1U1JXbWFEaC9lN0wz?=
 =?utf-8?B?Vk51ZHV4elBsRUY3RGRhTTJpUWJXQ1paOTlqbjdVdklaVU4rd3E4dkJUUjV4?=
 =?utf-8?B?VUpPNklaRnloVXRYSXdleWNmeklaNEp1SVo5WU5XbUNwd2lDRVpKYUFOMldO?=
 =?utf-8?B?RTljY0RRNHdNbVdHS3RLWEZpdG1JTkpQN1phWGs2YmRKbitzSmVUL3A2WVll?=
 =?utf-8?B?NG9CVUZaY0FYaFE2Z2FQTkhKQzV0emdnSHNPSnRZeStJSzFzMWVqNWJqN3Ay?=
 =?utf-8?B?RGQySCtvWnNpWmNYRXh2U2Nsb1RpSFM4ZzNuUmFzd3locU5ZcTU1SXlZMWJ1?=
 =?utf-8?B?QS9MQVYrcCtwMnZrNVFCcTBBSnVUSmVKb1lNZUFYbTlza29UeXlrbEZNQk1L?=
 =?utf-8?B?dUR1SVVVcm9mSFZlbWtzVE1xc0tpbFg3dFhzbG9XYWU5Rlh3ZktNU2xrSWsw?=
 =?utf-8?B?c2E5OFpidTk1cllXVDY5STBFSFhhUms2NDRZYi9rb0VtSzEzSkp4VHZVVlhF?=
 =?utf-8?B?bjlNNTRGTDN3c24yVS83aFNRWGg5c3NhQXdkSEV4VHJQUnFKQStvN0FoVmk2?=
 =?utf-8?B?WEFQRU9CNGxpS0FBcVl1Sm9iUW5pa2g3VXlGR3QzeWdiTzVFakNRd2EvMkxj?=
 =?utf-8?B?QTNkKzFYampoSytuZnhjNlp2UXBoVzdyWVZwQThrWkNycnpNTURvdjN1Q3hU?=
 =?utf-8?B?czJQdUdSblB0dGZCVkFFem53dmI5SkxUMlRGOXBQR3ZFdStBN29UNkFlNzhE?=
 =?utf-8?B?NFQ0RytkU3c2THhtNlR4c054WUlaQzlLSFppZ3hqRzRrdWdqc1JtdlpKenlD?=
 =?utf-8?B?QzhuNzhGZGRVR3VkL3FuWEY0UDZwRm1TUGhXRmhDaThaeG1Od0daZWIzV3Fz?=
 =?utf-8?B?RzJSQ0k2SnRkb0dDMlRac3BMZnREYmd6aFR5QXR6bG9SMzFCcExmK2lZTWhs?=
 =?utf-8?B?bDZCS0t4cFE3emV0R0pkT2RORDE0VjhmOGVSdlVBVEFtV1cyRnVscmJnZTJN?=
 =?utf-8?Q?W3oKhqy+3WgjGBokFAmxqGmF6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d698700a-fd3d-438a-0be6-08dc48f393fb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 15:36:58.1558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1bjarUsx/TV2V4SpfUKUgCcUzwVFcfC9kGth/4d2EDJ11Qmf92GGipO0xr+eYH8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763
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



On 3/20/2024 8:28 PM, SRINIVASAN SHANMUGAM wrote:
> 
> On 3/20/2024 3:12 PM, Lazar, Lijo wrote:
>>
>> On 3/20/2024 2:15 PM, Srinivasan Shanmugam wrote:
>>> The issue was present in the lines where 'fw_name' was being formatted.
>>> This fix ensures that the output is not truncated
>>>
>>> Fixes the below with gcc W=1:
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c: In function
>>> ‘amdgpu_vcn_early_init’:
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:66: warning: ‘snprintf’
>>> output may be truncated before the last format character
>>> [-Wformat-truncation=]
>>>    102 |                 snprintf(fw_name, sizeof(fw_name),
>>> "amdgpu/%s.bin", ucode_prefix);
>>>       
>>> |                                                                  ^
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:17: note: ‘snprintf’
>>> output between 12 and 41 bytes into a destination of size 40
>>>    102 |                 snprintf(fw_name, sizeof(fw_name),
>>> "amdgpu/%s.bin", ucode_prefix);
>>>        |                
>>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:66: warning: ‘snprintf’
>>> output may be truncated before the last format character
>>> [-Wformat-truncation=]
>>>    102 |                 snprintf(fw_name, sizeof(fw_name),
>>> "amdgpu/%s.bin", ucode_prefix);
>>>       
>>> |                                                                  ^
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:17: note: ‘snprintf’
>>> output between 12 and 41 bytes into a destination of size 40
>>>    102 |                 snprintf(fw_name, sizeof(fw_name),
>>> "amdgpu/%s.bin", ucode_prefix);
>>>        |                
>>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:105:73: warning: ‘.bin’
>>> directive output may be truncated writing 4 bytes into a region of
>>> size between 2 and 31 [-Wformat-truncation=]
>>>    105 |                         snprintf(fw_name, sizeof(fw_name),
>>> "amdgpu/%s_%d.bin", ucode_prefix, i);
>>>       
>>> |                                                                         ^~~~
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:105:25: note: ‘snprintf’
>>> output between 14 and 43 bytes into a destination of size 40
>>>    105 |                         snprintf(fw_name, sizeof(fw_name),
>>> "amdgpu/%s_%d.bin", ucode_prefix, i);
>>>        |                        
>>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> index 9c514a606a2f..f994ee6c548d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> @@ -94,7 +94,7 @@ static void amdgpu_vcn_idle_work_handler(struct
>>> work_struct *work);
>>>   int amdgpu_vcn_early_init(struct amdgpu_device *adev)
>>>   {
>>>       char ucode_prefix[30];
>> Hi Srini,
>>
>> Sorry, if I miscommunicated. Suggestion was to reduce prefix size to 25
>> as the max prefix length is possibly length of dimgrey_cavefish_vcn.
> Hi Lijo,
> 
> my mistake, the fw_name size must have been 53.
> 
> How 53? -> The size of ucode_prefix is 30, so the maximum length of
> ucode_prefix is 29 characters (since one character is needed for the
> null terminator). The maximum number of digits in an integer is 10.
> Therefore, the maximum possible length of the string written into
> fw_name is 14 + 29 + 10 = 53 characters.
> 
> On the other hand reducing ucode_prefix to 25 from 30:
> 
> 1. The length of the string "amdgpu/%s.bin" is 12 characters plus the
> length of ucode_prefix. The length of the string "amdgpu/%s_%d.bin" is
> 14 characters plus the length of ucode_prefix and the number of digits
> in i.
> 

> If ucode_prefix is 25 characters long, the maximum length of the string
> written into fw_name is 14 + 25 + 1 (for a single digit i) = 40
> characters, which is exactly the size of fw_name.
> 
> Is that this solution assumes that i will not be more than 9 (a single
> digit)?. If i can be a number with more than one digit, should we need
> to increase the size of fw_name accordingly.?
> 

With 25, fw_name size required is 24 (no null char) + 13 (rest of string
including null char) + 1 (digit). 'i' is assumed to be a single digit.
(We don't need to calculate this, that warning already gives this
calculation).

Assumption is we won't be having more than 10 (again, no random number
usage for suffix, only single digit usage) variants of VCN FW that needs
to be loaded for a single SOC.

> 2. If you reduce the size of ucode_prefix to 25, it means that it can
> store a version string of up to 24 characters (since one character is
> needed for the null terminator).
> 
> For example: if tomorrow, if we get something like
> dimgrey_cavefish_smc_xxxyyyzz - then in this case yyyzz would be lost?
> is that in "amdgpu_ucode_ip_version_decode " &
> "amdgpu_ucode_legacy_naming" , is that are we always ensuring that it
> will never be longer than 24 characters?
> 

Newer FW naming follow the syntax vcn_xx.yy.zz (IP version), and that is
not more than 25 chars.

Anyway, you may use 50 for fw_name or adjust prefix size - both are fine.

Thanks,
Lijo

> Thanks,
> Srini
>>
>> With fw_name[42] also, you may run into 43 bytes (30 prefix + 13 for
>> others) warning.
>>
>> Thanks,
>> Lijo
>>
>>> -    char fw_name[40];
>>> +    char fw_name[42];
>>>       int r, i;
>>>         for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
