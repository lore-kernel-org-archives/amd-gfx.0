Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282D606A31E
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 15:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hvxxSInq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94F8810E10E;
	Mon, 26 Oct 2026 15:54:38 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012021.outbound.protection.outlook.com
 [40.107.200.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 372A610E10E
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 15:54:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTVvBOeyim9QGIAmR8h/oeVtt0YAVcSHbf8Oe8NpzUlsyzbibqTlHFjosq07E+LSHbRx5qfiph9xH98dHu7/LAyHr7gsAIJcBxhX7Yq6RL+j5tSktYRfqK6aYUYwJWm4U3enavREh1cBXaknFlU8J5ruMP11cSL32eJihFDxjI1bFULLO99P+KMhtEtrysP2TMre8YNZdq33bgifkOyPs76dZqVBWjWVflMldWXz3Ejf+nQdsyfkTT1jIBS708w7iKN74OskC2Jryh2Q9wyCeTY0oc4AbJS5GQFIlNrLfEp1s4RM9vc3idPfuvTOsp8WXqCNUgkoIOr3FjQPO8xEDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gij2k8OKjozhZtHVCOfZ+5vorRT4Xe5y7ecMnXnuPt4=;
 b=AQWaa4VQQSbuLiGYoSNkTZn2rPtcWif935v6eDDuy7mSuyBqUArZ8Sm3DipJWzMOjdyGWxCQ4dAWf8vpq20fdjzdarXyAI/66dkUdFQURkjQp25lXMvWEVuwiliJu0uxMU0ISGJAmJNlY//xTSco1Quip7h0zND9xlPX+FdDEJhMPUve0PpBd3eY8BoDg1VYQN2YPxbb6yp2mihlgCa7OtSRjmFqQLiRNYQkXIluxUliVvuHrkVfXx6OpHbcu/LM6YrZCBEnfoSNTFYykmBc4yzJJVnRQ6QmRYrijQkgQz1j3B3dLdyKWRj4KB5Bmo7w0qI0kOW143EuO91j78FJig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gij2k8OKjozhZtHVCOfZ+5vorRT4Xe5y7ecMnXnuPt4=;
 b=hvxxSInqHOPUpNovLcQ8n9cYYLFSsrFr8xf6/o08qj9pWVTgz4NmbzgRx5/dfmES/hsxInXBIJAKjyxq3I4u+5aLdKpGTtN5KOJ9E4qB0sUiF8e9NC8TkG594Dxilo0kSnVzfXE2XksE5F3JoLaEGGoMYpq5eJdP36U4VGAnqLA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 15:54:28 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 15:54:28 +0000
Message-ID: <d3c0cac5-f44e-4fea-a99f-db0f40f9f840@amd.com>
Date: Mon, 26 Oct 2026 10:54:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: reset dGPU on resume if it kept power across
 s2idle
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Patel, Maharshii" <Maharshii.Patel@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>
References: <20260924203756.2771789-1-Maharshii.Patel@amd.com>
 <BN9PR12MB514689CD438188AF0AD61E37F7642@BN9PR12MB5146.namprd12.prod.outlook.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <BN9PR12MB514689CD438188AF0AD61E37F7642@BN9PR12MB5146.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0171.namprd04.prod.outlook.com
 (2603:10b6:806:125::26) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e5853a-9f16-47d2-ddcc-08df33796a6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|261026140227099003|11063799006|56012099006|4143699003|261021121427099003|10067099003|261009223027099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: PUfMJiRiywmaFFeuci2T9/p7B3BQsMFnuvANavPFE4hyifP8nAGHZcYNnH50yQPeDdXoXb+D8fjF15N1UAEmo+bLVxdZ4cwr/l4Ihr8LxFzLAD4M9wsF/Vt/vJDGSPTqP/9ZvQKQj47KJWX/uh9SdVVqy/QREQOSAqt6DW8l0YSO2L5P5tRJ7UlflNvaQISD0l2K97zhb3A/MerlCVzO7K8/aXwg7MF1ToZ/CTl3b1r4T34ta4nU0JPHc/PQnMJ82sbqvr4deKGrnPB93FokGAI9QBmekKyn4VcHv85JUj+Zk8F8X98qMFucWWxMEtSmX2evktoghPSjgz9e2Xw6gXOd+XgO4PDfQ3bmOM/D5zO2W6M2ZFu3T/DWiA1xn6qSYyu4L1g92OCifplMRtU8qL7aiNWGp8hUIrzno5GXEq3ZABXget3bl8uruNo6yyfYCfKkkwAx0aaqimTOEkIOR0o68kMvzlNEHi64A3XAhAx9LqFJ9tf10Q69h/Xj1qGuUMCW+pncrhTntEP+IiepcwjwKYkQxiMu0uTty9yzTnI+FSW4e8/1pOtui7CH8HPVzADq5Sy1tOmJAje++um+sulD3JFYh/ASGrTvkxd47+innOlYKICPklsMKOd6+ewA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(261026140227099003)(11063799006)(56012099006)(4143699003)(261021121427099003)(10067099003)(261009223027099003)(261022105027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0RpbUFzclR2aitUNGlRVUZtWTkrMGxDcUhueW10NkN6QVE0aU9nNmdlMHpV?=
 =?utf-8?B?Mkx3bm5LcWE1TDBkdUlOY0lUWmJiT0tWQWgvcElUb3ZsTk1VKzNiWm9DTzIw?=
 =?utf-8?B?R2tIdzc1ejQ4UkJOTzE1N1FMcHd6bnZ4QXBCdjhvWWtId0FFOG9VU29rOHRt?=
 =?utf-8?B?UWswNWtYOUxGQkZlQkRsRDhoSDBwM3RINnIvN1Njem9YZCtqenN1MEdjRUJU?=
 =?utf-8?B?VlN5T2R5MWNOVE5iQ3NLSUhWN0p1bWlybU1qRk9ibWJlVjhxc20yZ215Snow?=
 =?utf-8?B?K1BwTnBSZTlnTEt0V2V5Vy84cXRVTlc4Wm5iZlZ1ZDJCcWNwakpQVmZVc08y?=
 =?utf-8?B?YzJhZHNmWS9TL3pzaStsakJrZnh1ejU0M0RwUzVOV1lwcFd1OW1BbVhLdEM4?=
 =?utf-8?B?aWROMUxZVjliNVkzaFErSVY3MmdIci9XQXhwdTQ0QVRvUW9DTFRpWkEwUjJx?=
 =?utf-8?B?bmtFYUVTbkxsTTBBaHJIS2NZNytFNkhlYVdpMFFkc3ZVcXRqUEhhZW5TbGUz?=
 =?utf-8?B?YTA5VUJXekZvdURDcWxFUHJMdVg2TGozZ045ZVZQaWNqMHBRWkQ3MGpEa1pp?=
 =?utf-8?B?YW1iUXJJeDl2MTFVTEJDUitDYi9DQUxlRzJ3UkR4U045eU5uUm5kb2JLdnM1?=
 =?utf-8?B?aFkweEd4WEVpc3l4VElSVHBSZkVlOVU4dm8vM1A0K2N6VnVNL2FEeUMrekhY?=
 =?utf-8?B?VWZ5YllNRTFBYWhRbHprY09VZldSNXFuTXJabUYvVkRwQ3Byb2pCbU1KMnhI?=
 =?utf-8?B?ZU1tM20zcTNWekFYeFU2U3RndmxyaVRlMzVZdkJwMzRmTjdPaC9OQmoxa3VS?=
 =?utf-8?B?aXh2c3NDSjdUOFUxbUh2cEg3cFFyeUd0VjhDNmw0c2N5YkpuTjI4TDhXRFJV?=
 =?utf-8?B?MGloTWJ5UXF2blg2WkR2dnAvL05GZjBwZHpnU0VFd2Ryd3h4N0NzVzA5dGJu?=
 =?utf-8?B?VVByNGtMOXRPRTRuVWhzOUJpSlhlZ0Z0aURLeVlnRWxmWTMyUVdaZEIrejNx?=
 =?utf-8?B?aEUvOUU0dE9TS3ZGLy9XQzk2aW1YQlU1VU5WMS9sazBWN1FJTGlId2VjVjdE?=
 =?utf-8?B?ZG9kcm5peHJ5d1lDaEYrWWpRZEJMRTY2TVNCbkl1bUVlR1FPdnYxVWdOakpO?=
 =?utf-8?B?c3hwekdUV1VyYTZJc2NTODgxMlUzUXpnMjE2bURKNVJsWDRlMm5RVTJiWHlY?=
 =?utf-8?B?eWR0WHVLZ3k3ZSt1cldqdE5YUTkvenVkZ1hLbWpocUNza2M2blBFUGVyb0hr?=
 =?utf-8?B?OEg4cG1HRGpic01rRXdyMTFXaHB2dnA4eWJnMXRIbUlkZXVPMzc3WHJ6cmY4?=
 =?utf-8?B?cVlNWU8ycHplWWtMalZHVnVwcUlDeWxCWGg0ZEdCTTBIQkxhdithU3RuYVpl?=
 =?utf-8?B?T1NkYTlHMmQ5V2RZa3UzYUEyZkhPQTBXeWxxN3RhSFJDaHk3S2ZLOThhUDJL?=
 =?utf-8?B?YmV2OUV0NDQ3YWx3eUNIQkoyWm5BcEVwbHk1cFREYkdKUmF1aXIwS25LU1VZ?=
 =?utf-8?B?L3Q5OEFockhpZFhNVUdncFdtb285eUtndkdRa1ZoRGhwTllUZVhRckt1b2s2?=
 =?utf-8?B?aDkrd1h2WEoyMm16TThRWkhoSERzUXlia3VvVWlBbExjeFdSenpPL1pJcE10?=
 =?utf-8?B?endFb2pWRVlmTjRuc0ZlOE1seGdOR1Jua01QTEJKVVBONkpBTGdQN3BFTmxL?=
 =?utf-8?B?c2tIWDNneE5qcFhSNkh3bS9hOXdNcFVRdFhWWEhEa0d2WndHMEdxUEtCT2Fj?=
 =?utf-8?B?MnFpaitadmZmUUxHajYrSDlCVnJuK2gvLy9vZDN0d3FYU0lBRmN0RU5JWi81?=
 =?utf-8?B?bXBjQllPY0trL1VuNVBDMDI1clRwa0phTEtxTjVkbURkc0hxWnhDVUt1K1Fn?=
 =?utf-8?B?ek90V3JxbWhnaWkyYUJHZ2hjQ2tzK2gyUjZCQ0ZoQjdJSytYUHV1V1BLaFRz?=
 =?utf-8?B?V3JiL2dPRlRiWEFmbjJWQ2tkRk15bTZTbTZTNVl1MmpDMjVSU3dTTEhZV2tt?=
 =?utf-8?B?aEVXem5Yd0xRc1ByOXNiaVR0ZTlpL012Y1dUdXZTQzkrTXZTVWZXT1g1bDdR?=
 =?utf-8?B?NDUxbVdoa3ZrUTJGWlZWSDR5VmlaOThpSkU1OXlRaENIWlBsZUdHMjJnVmVk?=
 =?utf-8?B?c1BEcEJhb3hiN0Q3NFFwbm0rbGQxbSt0RHhrbTl1aExPY2RkNzNRWU81VGNY?=
 =?utf-8?B?MWdWeTFyUis4M1MrNk5QT01JQ2p2SHVLaGhLNWYyR3dOY2x2SVZKbDdhRnVk?=
 =?utf-8?B?OVpydmdaVWVWT0RhUW9uUHFQVGFBNzhuUFd6b1ByRWtSakR3K29ic3JoZmJZ?=
 =?utf-8?Q?f/+UpKZx2ygx7EPhvD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e5853a-9f16-47d2-ddcc-08df33796a6f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 15:54:28.2933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykRkrBEzXp1PwsGDstlWoaGocrrhZwYwojvs5UGI5LEb8Z/1SIzludxKAhGuDBNktb4N5EkcRsNAI/8XnKNqZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/23/26 09:48, Deucher, Alexander wrote:
> Public
> 
> + Mario
> 
>> -----Original Message-----
>> From: Patel, Maharshii <Maharshii.Patel@amd.com>
>> Sent: Thursday, September 24, 2026 4:38 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>;
>> Patel, Maharshii <Maharshii.Patel@amd.com>
>> Subject: [PATCH] drm/amdgpu: reset dGPU on resume if it kept power across
>> s2idle
>>
>> dGPUs take the S3 suspend path even when the platform suspends to idle, but
>> amdgpu_pmops_suspend_noirq() skips the ASIC reset for s2idle. On desktops
>> the GPU also keeps power in s2idle, so it resumes without having been reset or
>> powered off.
>>
>> SMU 13.0.0/7/10 and 14.0.2/3 skip smu_disable_dpms() on suspend and rely on
>> the PMFW to clean up on reset or power loss. With neither, the PMFW still
>> holds its pre-suspend DPM state and stops responding when resume sends
>> EnableAllSmuFeatures:
>>
>>    amdgpu 0000:03:00.0: SMU: No response msg_reg: 6 resp_reg: 0
>>    amdgpu 0000:03:00.0: resume of IP block <smu> failed -62
>>
>> SDMA ring resets and mode1 recovery then fail as well, leaving the GPU
>> unusable until a power cycle. soc24_need_reset_on_resume() does not catch
>> this, as it only detects aborted suspends.
>>
>> Do the skipped reset in amdgpu_pmops_resume() when the VBIOS init state
>> survived suspend, i.e. the GPU kept power. S3, and s2idle platforms that cut
>> power to the GPU, are unaffected.
>>
>> Tested with this change applied to the amdgpu 6.19.4 DKMS driver on two
>> Radeon AI PRO R9700 (gfx1201) on an Intel Z390 system: s2idle failed on the
>> first cycle without it and passed 16/16 with it; S3 passed 10/10 with no extra
>> reset.
>>

Can you please check /sys/power/suspend_stats/last_hw_sleep after you've 
resumed with and without your patch?

I am guessing it's 0 without and non-zero with?

> 
> This should probably use the runtime pm path for dGPUs, otherwise the GPU will be on the whole time consuming power if the platform doesn't power off the port.  Can you try these patches?
> https://gitlab.freedesktop.org/agd5f/linux/-/commits/dgpu_s0i3?ref_type=heads

Makes sense to me.

> 
> Alex
> 
>> Closes: https://github.com/ROCm/legacy-rocm-build/issues/6684
>> Assisted-by: Claude:claude-opus-5-5
>> Signed-off-by: Maharshii Patel <Maharshii.Patel@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 9c5e93c..b9be88e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2703,6 +2703,24 @@ static int amdgpu_pmops_resume(struct device
>> *dev)
>>        if (!pci_device_is_present(adev->pdev))
>>                adev->no_hw_access = true;
>>
>> +     /*
>> +      * A dGPU takes the S3 path even for s2idle, but suspend_noirq skips
>> +      * the reset there. If the platform also kept the GPU powered (VBIOS
>> +      * init state survived), the PMFW still holds its pre-suspend DPM
>> +      * state and times out when resume re-enables features. Do the
>> +      * skipped reset now; resume will POST the card afterwards if needed.
>> +      */
>> +     if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev) &&
>> +         !adev->no_hw_access && !amdgpu_acpi_should_gpu_reset(adev)
>> &&
>> +         !amdgpu_device_need_post(adev)) {
>> +             dev_info(adev->dev, "GPU kept power across suspend,
>> resetting\n");
>> +             amdgpu_device_lock_reset_domain(adev->reset_domain);
>> +             r = amdgpu_asic_reset(adev);
>> +             amdgpu_device_unlock_reset_domain(adev->reset_domain);
>> +             if (r)
>> +                     dev_err(adev->dev, "reset on resume failed (%d)\n", r);
>> +     }
>> +
>>        r = amdgpu_device_resume(drm_dev, true);
>>        if (amdgpu_acpi_is_s0ix_active(adev))
>>                adev->in_s0ix = false;
>> --
>> 2.43.0
> 

