Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78270C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 12:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D7E410F329;
	Thu,  2 Jul 2026 12:03:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MKf8XBnf";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB0B10F329
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 12:03:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNOCJC23oizhUDiJXMUWezZbIBeKfulybyAgspwZcdCyH7ktffhqV2RZcZmzINUnpMpg+ZdyCO+GxJcrMgOX0CzNf3GxLA135TCGgod50lMsqlCLnmWkIrPrU6lnMSqa2MRuGxvrZp93iLqH6AX00wDHbPWnPTEQmfMpkkXpNjLQ5hPIp+dWw4XzQiascxQyNFq8poRmxM9UiS13Zog+CCj/Aw5e+E1hOiuq5ONYICBabaMyQ+K0X78G71QLJLdReLfGlqIAEYCpFWGYqhkQ7FYyJfv0y7xAgWAjWEDiLBZGtSUE17UCnUC005p5cWaTyMEYIsO7Pi86QWaENz3APA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qC2hDbffNhIL5Z7dpqFDAbRIc2BwF4jGgjSHuN/J/UI=;
 b=hRKc4g2hk7nKDZXxPXzS+yvCetu0nM0yjFPUfTtDh23wW1Sj0TD3tYjiq8MPFppFyU7qZeVer1w5CJmduXuthiOnoyvx7XQGiMdgG0hHITtMNbciebM0mZHiuqyqPGmKKrS0z0jz3mr7ey6JXcvePu26V4rHcUkIs8wXdFEkxG7M8GuW+eKZhFdn5vU24QihS7RhcuV1BR3YPv4r+1riy1qpyT7Chls6Mbnwvw1vDCOsO/J0TIFgyJ0ev5DPWF6m1dUE2/eF8b651LXbmgBCOrr8jXBn+qcu8nxJoSW0c2DC/amZaOcPfqZgZomqR9bSAXfmvPbxEZ9/fRMZiKwjuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qC2hDbffNhIL5Z7dpqFDAbRIc2BwF4jGgjSHuN/J/UI=;
 b=MKf8XBnfLpvmhV3V8JvBcBGZU3CRQETqCcb64swVb7733WV1n6P56OrU/mKoaW8zZrkBagJIOrcPF0zIFxXEz24Rms5adr+s9WqaoSWSi05OIyLFG6GA/Xo18I4/ONr2RnJSqz0iU6nj53WHjuBegzExOeoBAmyMABDkzLoY0OA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7466.namprd12.prod.outlook.com (2603:10b6:303:212::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 12:02:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 12:02:55 +0000
Message-ID: <d03ddb99-56fa-4b33-b2a5-61a9af4e4e6d@amd.com>
Date: Thu, 2 Jul 2026 14:02:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] drm/amdgpu/gfxhub: Enable retry fault interrupts
 when needed
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
 <20260701161721.85681-3-timur.kristof@gmail.com>
 <be24281a-465b-420b-9279-a749ebd79ba1@amd.com> <2821958.vuYhMxLoTh@timur-max>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2821958.vuYhMxLoTh@timur-max>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR22CA0014.namprd22.prod.outlook.com
 (2603:10b6:208:238::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: d2efd34a-8f63-4d78-d29a-08ded831d9ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|4143699003|11063799006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: P+pOCdLMN2AGU138QMktPTycylGRIfKDeGAyfFPHUz0XGH5L/nhwo/SJV1BUNIdjcU9aexSDU//auH8nonxZWukFHuD8ImY6kBEL1FrxUSp2aRRaar5Anzy6Mf/1BQKuN8vFzS59yYRWrx5K1G1WxQWP6/NymQjTOPDaYLkObhB2ASHhteGdBZ6QMGcfYXwPtfkBHGr+NIgHCGbkWwtAGpGmaeH0hka+9dvDSGcZLY2xstswhhEIGfoQK9EaQ0iB1YqODsNCGpbTa4RF6kooOtlFlQTyQS8KjNUCp6Dh4H1H94JGsf/TGcmS3KaP5D20nqbNTX09Ps0VIR6Mz+jhpkY0TjzT62Fu7SlgVXD26spdy6iZwt7+ryb7CA+S7pshALIgrcG4HYbN+U0q3nc9SuwX2+QiLs9aeSOdQ9h2jbtFtkLf9Dq6wXP2v52UihIZo7r4HfE6UhByTGrVGBu26fH4xgjwkHCRENcjPomWiu1gl7x5+lRfpxEqJONT5BIIxLpgDumOj6TISTJLMPY6QdMd3iLtiILykctLQKeO+Is/tIHSpL1k1wLI92axITIAQtedJqEpViWOGaTsGqw9dzBatY7XsvDqiqZR5guIRd/YyO5zLgQRNF1Wl9G5bHrr2YXVYajdJXnzI7XR2POrBSdRXbEYdOAvXRlPYswyyBMqvrS63pWb1uEBJzn366IXORFFYER0WAVj/BCcnT3psA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(4143699003)(11063799006)(921020)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVZrSjVyVS9RdVQ2bDFMNlRRMmVnb3Nla280MlpnUUx3aWhpdlNxdWlBalM4?=
 =?utf-8?B?WlBnSFdsM2JVb1M3ak1XbDQ4ckQ4eE4vYm9wQWM3NnVJN3cxOHQyWC9YRXFn?=
 =?utf-8?B?NkdOVU5vTmUxUlBtTTlLK0NUd0hPOElyeDZ0Ni92blJnQnY4RHYyT09mZzdW?=
 =?utf-8?B?cmN4bFZ4dElaTndGdUsza3JIM1FQK2k4OG9Na0xJdTNXOFVqV3dLZlRpZGwr?=
 =?utf-8?B?V09IbFpWM1gwTENxV3lHZ1R2dHhjTURDQWdOSzRRMldnc3JXQ3dUVm1QQTRx?=
 =?utf-8?B?aHhicHFWOVA0QlpkRjYrb0VtYXI0dzQ1VHBGaWtIUEZ3bXpEdXpVc1NnV0dP?=
 =?utf-8?B?ZC82cUN3amRnQlREdkxTeU83UE9FSTg2di9MV0MvK2pWQ0pSb0JIR0R4MjJL?=
 =?utf-8?B?T2ZYL0UrWnNXcWk3dXJXYkRhdDJnanVQcEo0MHhnb0tsbTE0cXJyUkNydFp4?=
 =?utf-8?B?SkNMNCswb2tJeEplKzI5T2ZwL2pXNVpPNUxUZmU4WFRXV1pGQU04N0JWc2dw?=
 =?utf-8?B?cVFuYnZtNU9yTzlTLzlzTVU3aWNkc01raUw4cnp2MWVFanZCdmVPZ3VVczg5?=
 =?utf-8?B?QkNjd2ZnS2ZYU3dFNXlUUURxQlFGQ3pTRWxBa2JYcTJuNGNVejNsNGpSYzBO?=
 =?utf-8?B?R0ludGdJRlJLclYrbCtMbVhzU0tlck5wWTFGU1NobE1UZG5PTGFGRE9aeUhS?=
 =?utf-8?B?QjJXV1FlSXFzaU9sNlF4TTZvc2wxMW52NG5JckJvUmFCY0NRYktzKzFGNlFI?=
 =?utf-8?B?MFlUNXNpV1RFbkJKOEZ5VDVYTksxZUtoU0hMOUxzR1UzNjR6WEdxdU1QYmtx?=
 =?utf-8?B?ZTk4NU83dnFmTEdVa1d5ZkJ1OXNZZzBHN0UxNGI2ZEpNZlhZOGwxSGtOajlY?=
 =?utf-8?B?T0gwNWNqVFFVQk4wTWdrc1l0ZisrZEdCajBsc3NYSjh3UXYvNFNHKzcrR0FV?=
 =?utf-8?B?YmF5UHh2UWhHTDFNNWJGRWVybGxEcHVldzV6UW8yRW5TclhKby9BZW41djYx?=
 =?utf-8?B?U1FSVy9KN1lyK2xJVkRsb0ZMV3dDRCtNMnBDSThxS3hRRUN6bCtKRTBBSWVD?=
 =?utf-8?B?OTRPYmhlV0swVW81SUcrc3o3a3VIeGh5dHVoYnNLd3JBYUk0dFhKMmNKUWF6?=
 =?utf-8?B?TndGMFNGNUc5S0FwM0xhK21ZUkk2dVRIbjR0UHdtNE1PVFBvMG0yblI2c3Zn?=
 =?utf-8?B?d1BRenVldnlnUHZmSEJsOSsrb3dpMzZQSk45YUpWcVIxNmtjL3hDQWpjN0s1?=
 =?utf-8?B?cE16TE96SUs1amw2ZmxzbmFhd3hRYVljcFFGRUFraG5xSFZuNkg1QnJKdDYr?=
 =?utf-8?B?WFo0SDR3LzVqUlA3d2lMVndnNXRYVERmU1h6NDZzSE1KOXNtQXFtS2FQT2tm?=
 =?utf-8?B?SFR2TUU5NTdDU2FnVmlwU3p2ZjVia2hEMHQrWWU3SnNYc2I5UjJ1dmh4Q0tB?=
 =?utf-8?B?V1c4L3pGa0NaYjJMdnNreVhzeGxhUERONURwNUF1STZLZVBMckRTaS9JeDJ3?=
 =?utf-8?B?TGEwaUdHK1dXMTdQbEQ4b1V0a2ovTjE5a2RiZmJFOURQNkk3K3laQWI3Y3d3?=
 =?utf-8?B?SFZzZC9vYTUwcVlUbXU4QVJhTUpJcWliMDZXKytNbzg0QUd2YmJoYkhsTHhQ?=
 =?utf-8?B?TW1qd3lBSGtsWjhwK0tXZDA5cWRLRncxNlpwR3dOak1FZDFUa3VhSjdjaFN5?=
 =?utf-8?B?Y25CVmZEeG54V082bEhTTEhzY3FQOCtPK216WENXT3gzRXliMzE1R3EydEsw?=
 =?utf-8?B?Z081NTJwMG52eTlqOUlEangvT1RSZGdXcWJHRndPUnp0dXZqdFo4bzhZWHZj?=
 =?utf-8?B?YmZCL0hPMm40UFhBZHlobE1vOHRKWGZlanQwWmVaMUxWSlE3RjFRNGZSNnlF?=
 =?utf-8?B?YmN0UW1iaFlMNlJsZXpBNGJheHBUS1U2aS9Cdm5WVUcrR2p0WmlUUFNDako3?=
 =?utf-8?B?enB0WVBwbGFFcUdNb3ZtZFY5eWhlWE5iVHlVY2F3SDhqSXd1V0x2YUZNZjdC?=
 =?utf-8?B?ejhnc1VBZHE3cmdDZVYxeFNONkQ3SFExMVdTcDlhNHJmTWVWSkM5U3czNm5T?=
 =?utf-8?B?ZWNmcllyd2lwOXFEQ05CNCtodzVyUGRpdzRWRTZCL1ZQNHI3RFpjU2Z4Vm9V?=
 =?utf-8?B?N3ZCWTFQd2Y4V2c3OUx0aDUzdVd5ZzFBR294RFo3bkMzaHlhcTE4eXNZUndx?=
 =?utf-8?B?U3hHUjlEbHN6WmR3d0JzZnhhWmtTUWFYb1hRbXpMVEJsa0pjcVBBK05pSmVJ?=
 =?utf-8?B?T2hwK09wRXhOb2hycjRPNStDUkNVUFlxdXpVR1ZHWC9iaHVEM2xlQktYS25Y?=
 =?utf-8?Q?INDQ0FylWVlo1+KYBV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2efd34a-8f63-4d78-d29a-08ded831d9ae
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 12:02:55.2440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ce24gtl1RWEV6BdhtfXePfrVhzgcTrCTuIwlqHASKi4hennuJzol7dCP4S9HA/oM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7466
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

On 7/2/26 11:14, Timur Kristóf wrote:
> On 2026. július 2., csütörtök 10:10:10 közép-európai nyári idő Christian König 
> wrote:
>> On 7/1/26 18:17, Timur Kristóf wrote:
>>> Enable retry fault interrupts when initializing the GFXHUB
>>> system aperture registers according to whether retrying
>>> page faults is enabled in amdgpu (ie. amdgpu.noretry=0).
>>>
>>> Needs to be done for each GFXHUB version at once,
>>> because none of them actually enabled this interrupt.
>>
>> Thinking more about it we are clearly missing something here. The retry
>> fault interrupt itself should be enabled all the time.
> 
> Why would it be enabled all the time?
> I haven't seen any retry faults on neither Navi 3 nor Navi 4 without enabling 
> the ENABLE_RETRY_FAULT_INTERRUPT bit.

As far as I understand it the GCVM_L2_PROTECTION_FAULT_CNTL2 is actually a debug register for the fault behavior of the GC block.

In other words you can for example turn on interrupts for PRT accesses as well to debug those.

According to the register spec for Navi 44 the ENABLE_RETRY_FAULT_INTERRUPT should be default 1 and always be set under normal cricumstances.

>>
>> IIRC only the RETRY_PERMISSION_OR_INVALID_PAGE_FAULT bit in the
>> VM_CONTEXT0_CNTL register should be set or cleared by the kernel driver or
>> firmware to control if the HW retries the access or not.
> 
> That is clearly not the case on GFX12.1 and I haven't seen any indication that 
> it would be different on GFX11.x and 12.0 either.

Mhm, then either the FW or golden register settings for that register is not correct.

That we set ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY to one is rather strange as well since we don't use that feature in the Linux driver.

My suggestion is to always set the ENABLE_RETRY_FAULT_INTERRUPT in GCVM_L2_PROTECTION_FAULT_CNTL2 no matter what the noretry flag says, but I'm going to ask Alex and our ROCm people about that again when I have time.

Regards,
Christian.

> 
> 
>>> ---
>>>
>>>  drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 9 +++++++--
>>>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 9 +++++++--
>>>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 9 +++++++--
>>>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 2 ++
>>>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 9 +++++++--
>>>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 9 +++++++--
>>>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 9 +++++++--
>>>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 9 +++++++--
>>>  8 files changed, 51 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c index
>>> 652eea6eae4a..ef20eafd59ae 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
>>> @@ -155,6 +155,7 @@ static void
>>> gfxhub_v11_5_0_init_gart_aperture_regs(struct amdgpu_device *adev)> 
>>>  static void gfxhub_v11_5_0_init_system_aperture_regs(struct amdgpu_device
>>>  *adev) {
>>>  
>>>  	uint64_t value;
>>>
>>> +	u32 tmp;
>>>
>>>  	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
>>>  	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, adev->gmc.agp_start >> 
> 24);
>>>
>>> @@ -180,8 +181,12 @@ static void
>>> gfxhub_v11_5_0_init_system_aperture_regs(struct amdgpu_device *adev)> 
>>>  	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>>>  	
>>>  		     (u32)((u64)adev->dummy_page_addr >> 44));
>>>
>>> -	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
>>> -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
>>> +	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
>>> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
>>> +				 
> ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
>>> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
>>> +				 ENABLE_RETRY_FAULT_INTERRUPT, !
> adev->gmc.noretry);
>>> +	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>>>
>>>  }
>>>  
>>>  static void gfxhub_v11_5_0_init_tlb_regs(struct amdgpu_device *adev)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c index
>>> 6cbf837d50dd..ec3ff4dec674 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
>>> @@ -158,6 +158,7 @@ static void
>>> gfxhub_v12_0_init_gart_aperture_regs(struct amdgpu_device *adev)> 
>>>  static void gfxhub_v12_0_init_system_aperture_regs(struct amdgpu_device
>>>  *adev) {
>>>  
>>>  	uint64_t value;
>>>
>>> +	u32 tmp;
>>>
>>>  	/* Program the AGP BAR */
>>>  	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
>>>
>>> @@ -184,8 +185,12 @@ static void
>>> gfxhub_v12_0_init_system_aperture_regs(struct amdgpu_device *adev)> 
>>>  	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>>>  	
>>>  		     (u32)((u64)adev->dummy_page_addr >> 44));
>>>
>>> -	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
>>> -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
>>> +	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
>>> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
>>> +				 
> ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
>>> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
>>> +				 ENABLE_RETRY_FAULT_INTERRUPT, !
> adev->gmc.noretry);
>>> +	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>>>
>>>  }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c index
>>> bfe247b1a333..27d7f7cb903f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
>>> @@ -91,6 +91,7 @@ static void gfxhub_v1_0_init_gart_aperture_regs(struct
>>> amdgpu_device *adev)> 
>>>  static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device
>>>  *adev) {
>>>  
>>>  	uint64_t value;
>>>
>>> +	u32 tmp;
>>>
>>>  	if (!amdgpu_sriov_vf(adev) || adev->asic_type <= CHIP_VEGA10) {
>>>  	
>>>  		/* Program the AGP BAR */
>>>
>>> @@ -134,8 +135,12 @@ static void
>>> gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)> 
>>>  		WREG32_SOC15(GC, 0, 
> mmVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>>>  		
>>>  			     (u32)((u64)adev->dummy_page_addr >> 
> 44));
>>>
>>> -		WREG32_FIELD15(GC, 0, VM_L2_PROTECTION_FAULT_CNTL2,
>>> -			       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 
> 1);
>>> +		tmp = RREG32_SOC15(GC, 0, 
> mmVM_L2_PROTECTION_FAULT_CNTL2);
>>> +		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
>>> +					 
> ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
>>> +		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
>>> +					 
> ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
>>> +		WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL2, 
> tmp);
>>>
>>>  	}
>>>  	
>>>  	/* In the case squeezing vram into GART aperture, we don't use
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c index
>>> fbdf46070b38..ed9a64bc5aaa 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
>>> @@ -176,6 +176,8 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct
>>> amdgpu_device *adev,> 
>>>  			tmp = RREG32_SOC15(GC, GET_INST(GC, i),
>>>  			regVM_L2_PROTECTION_FAULT_CNTL2);
>>>  			tmp = REG_SET_FIELD(tmp, 
> VM_L2_PROTECTION_FAULT_CNTL2,
>>>  			
>>>  					    
> ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
>>>
>>> +			tmp = REG_SET_FIELD(tmp, 
> VM_L2_PROTECTION_FAULT_CNTL2,
>>> +					    
> ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
>>>
>>>  			WREG32_SOC15(GC, GET_INST(GC, i), 
> regVM_L2_PROTECTION_FAULT_CNTL2,
>>>  			tmp);
>>>  		
>>>  		}
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c index
>>> 9ea593e2c719..152b2735d360 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>>> @@ -151,6 +151,7 @@ static void gfxhub_v2_0_init_gart_aperture_regs(struct
>>> amdgpu_device *adev)> 
>>>  static void gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device
>>>  *adev) {
>>>  
>>>  	uint64_t value;
>>>
>>> +	u32 tmp;
>>>
>>>  	if (!amdgpu_sriov_vf(adev)) {
>>>  	
>>>  		/* Program the AGP BAR */
>>>
>>> @@ -178,8 +179,12 @@ static void
>>> gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)> 
>>>  	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>>>  	
>>>  		     (u32)((u64)adev->dummy_page_addr >> 44));
>>>
>>> -	WREG32_FIELD15(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
>>> -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
>>> +	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2);
>>> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
>>> +				 
> ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
>>> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
>>> +				 ENABLE_RETRY_FAULT_INTERRUPT, !
> adev->gmc.noretry);
>>> +	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>>>
>>>  }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c index
>>> 30b90d35abd0..83c2ddbbd292 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
>>> @@ -154,6 +154,7 @@ static void gfxhub_v2_1_init_gart_aperture_regs(struct
>>> amdgpu_device *adev)> 
>>>  static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device
>>>  *adev) {
>>>  
>>>  	uint64_t value;
>>>
>>> +	u32 tmp;
>>>
>>>  	if (amdgpu_sriov_vf(adev))
>>>  	
>>>  		return;
>>>
>>> @@ -182,8 +183,12 @@ static void
>>> gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)> 
>>>  	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>>>  	
>>>  		     (u32)((u64)adev->dummy_page_addr >> 44));
>>>
>>> -	WREG32_FIELD15(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
>>> -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
>>> +	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2);
>>> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
>>> +				 
> ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
>>> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
>>> +				 ENABLE_RETRY_FAULT_INTERRUPT, !
> adev->gmc.noretry);
>>> +	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>>>
>>>  }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c index
>>> 9e6a6e13dec0..90bbb2fe4884 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
>>> @@ -150,6 +150,7 @@ static void gfxhub_v3_0_init_gart_aperture_regs(struct
>>> amdgpu_device *adev)> 
>>>  static void gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device
>>>  *adev) {
>>>  
>>>  	uint64_t value;
>>>
>>> +	u32 tmp;
>>>
>>>  	/* Program the AGP BAR */
>>>  	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
>>>
>>> @@ -176,8 +177,12 @@ static void
>>> gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)> 
>>>  	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>>>  	
>>>  		     (u32)((u64)adev->dummy_page_addr >> 44));
>>>
>>> -	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
>>> -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
>>> +	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
>>> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
>>> +				 
> ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
>>> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
>>> +				 ENABLE_RETRY_FAULT_INTERRUPT, !
> adev->gmc.noretry);
>>> +	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>>>
>>>  }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c index
>>> b3b1085c7cd3..1b3c067ab48c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
>>> @@ -153,6 +153,7 @@ static void
>>> gfxhub_v3_0_3_init_gart_aperture_regs(struct amdgpu_device *adev)> 
>>>  static void gfxhub_v3_0_3_init_system_aperture_regs(struct amdgpu_device
>>>  *adev) {
>>>  
>>>  	uint64_t value;
>>>
>>> +	u32 tmp;
>>>
>>>  	if (amdgpu_sriov_vf(adev))
>>>  	
>>>  		return;
>>>
>>> @@ -181,8 +182,12 @@ static void
>>> gfxhub_v3_0_3_init_system_aperture_regs(struct amdgpu_device *adev)> 
>>>  	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>>>  	
>>>  		     (u32)((u64)adev->dummy_page_addr >> 44));
>>>
>>> -	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
>>> -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
>>> +	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
>>> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
>>> +				 
> ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
>>> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
>>> +				 ENABLE_RETRY_FAULT_INTERRUPT, !
> adev->gmc.noretry);
>>> +	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>>>
>>>  }
> 
> 
> 
> 

