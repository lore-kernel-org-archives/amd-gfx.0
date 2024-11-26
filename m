Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B83D3B9A7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2024 15:37:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF3D510E13A;
	Tue, 26 Nov 2024 15:37:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HEw7pT/9";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0632E10E13A
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2024 15:37:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6PoTbq8/u5MKxX9cMAJtt0aqE7pg6/4tpqje+xt/HirmX0Q2jg3EDu/Zx9Y7UBheP1Hql7TrttoI52LrYzlaQY1/wYqBq6Y0hy4RalcmAdGJIOeM+Og8YUSQJgD7KD4SahGDpwOLo3Eq/iV2QrsCH3J3hRNH5ST0Kt2snoouv72jhCKcT5J5gfJc2CjFhO/2lLE1MKHkkepaTSqdrO9gwyvPTA42zlNEmBYu+3vVuMwWCbepmfs0KXm+RNq0SG3xxNNHo5gJz6HTbOkjIoT9Fok0TWSKmVStVIv/DVCukyGPcP+Ms12jp2+PSgfRC+UXLQYCBrdDmjIFAyoA/8jdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmVqRNW+aTxO/zNRuMpWPU4Ashc5T7+7iCMH5G0t6ao=;
 b=qMYLED5Dl3boAEvdepFXAgBUx/6DMIzifo8WwDA98rpjr9+RdMG+iKUAsHSCyHU1U2tRaFCLribuS3Q31NLcQ6osNIRj9Wg+pc6de6pC8nYxm0PutpTnntNednbZbqOkskfhTh6opMpyE/+Y3B0NfNHTAp7Kfd5UJqqk8ZKx1lH5A4VkWHf6LJQNzPS6vCfjMoHoqa1y8N6wb/VlLultqvQI2lEJA+kXdt4nwl7pgBrzDSFSjKXVCPziwUdPXwDjBViPIn0Vfpa6GShtsQT0uK5/nNK621+6Wqek4Z+znEJJECsIIysMyKS1ZZ00iCjV3me99u5uDKvbR4frGMu0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmVqRNW+aTxO/zNRuMpWPU4Ashc5T7+7iCMH5G0t6ao=;
 b=HEw7pT/9j9KtuUbDhfDKeJrkGLaw3ENqSeluXboEJaVzx31x/ru4Z/7t35NRqwCYTBcYvBYDdt+8rjKc6jIivV7Nz3rwnNRPaB7MJAOTyNUaAEvvhxnIwfaE068fEawyU2BxCi5C13S+9dLGsGRq93ZBLcEksobhLC269Ve43T0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.18; Tue, 26 Nov 2024 15:37:36 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 15:37:35 +0000
Message-ID: <414f787a-9e39-43de-a1be-9b4e3a62ed03@amd.com>
Date: Tue, 26 Nov 2024 21:07:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/amd: Add Suspend/Hibernate notification
 callback support
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
References: <20241124190001.2633591-1-superm1@kernel.org>
 <20241124190001.2633591-2-superm1@kernel.org>
 <2ab89895-64a3-45fa-b6a9-37407ef6e3ab@amd.com>
 <4c939f50-a1c0-4476-9a16-ced6e6102aa2@kernel.org>
 <0cce0ffc-2844-4fbb-9f8f-76d812d2936d@amd.com>
 <bb6af227-6e20-4e9c-b105-74b7bb44f435@kernel.org>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <bb6af227-6e20-4e9c-b105-74b7bb44f435@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PEPF0000017C.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::47) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 258910d8-7e3d-4a57-839e-08dd0e304005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkxsY2RnRVhmYzRiQnJmUGlCOWVtMitRa1BLdHBDWmRIWVhjL1VHSFdRVWps?=
 =?utf-8?B?c2ZvRTdKNFc3eGpUdktvMjhRS2poOVRlNnJMbDFPcDVRN1Z5akU3SGRKQ2Ja?=
 =?utf-8?B?ajVKdXV4Y1pSZFhjUnNrWUk2aTN5djVxeS9LRVBGY2lzY0NoWUNxZHFWaEtr?=
 =?utf-8?B?YllVNnZNdjhYbzhncDZrOE1OYndBM1VPelBJU3JJTHp3cDl4RDZmRUpjVXhM?=
 =?utf-8?B?VlgzUVhkSENDSkpLWEcrKzRjR2xQM0NWQTRhUGkrY1MxdTFuVS9TdmxZaGJR?=
 =?utf-8?B?SXBwUUtlRk96aTRsRndsMkpPekZqbXNxdHB3SDg4NzhHK3plWnNKZ2l6Zm04?=
 =?utf-8?B?K0JveFM3S2lCa1BtVEs0NExMQ21NT3F5VFdJaWplYkNSS2dpbi9DbWFtUDgy?=
 =?utf-8?B?Ulk4RE1KRnZURVhVVExFU2FJOGJxQ2ZxaExRRVpqMDBZcmdXQXllbllWWEZ2?=
 =?utf-8?B?Tm8rQ0lJUmpZSUZuL21pZ1ptTmZpVXVWQjZ4OHhNdDFHM2NyQ0xlUjd6QXZv?=
 =?utf-8?B?MmVHR1hmV0JRdVMrR1hwRjA3QTFQc1cwaS9WNFhmRGlFOUIvQmtwQkY3bUVI?=
 =?utf-8?B?a0cyZE5SNEFPdFN5N0E1VFZFUWNGdm1GR1pLczY1NXZVZEZUWmNXVU1ZNmkx?=
 =?utf-8?B?RXlRQkl5UHp0b0htcU5RSnVCRmsvVE4yQmM2SFN0YVIvVU5EOCt2UlB5TVhs?=
 =?utf-8?B?L1dmSTZUUTlhR3VjenRtcTAxdWlBbVBLNmNPYStDblFMMkFEa3BNaERBWDho?=
 =?utf-8?B?M2tWWEJ1WThBQ2dLUVNrOUg1Tmp3amxkY2pCTFJFTEc2cmhmN1UzdmJRT1lG?=
 =?utf-8?B?dTlhUlpXbDd5cEFnS0l4VHY4SEZLZGsxdkZEYnE1YnZtbE9NUUxxU0djWjlQ?=
 =?utf-8?B?TEVTTDcySGpuK0xHb0ZPejgzZCt5UVdEMkpSOGNQa1hFZDZSN3R3dHZscmNK?=
 =?utf-8?B?RjY4WWcxMUhHMmJqQ2VIMDhCb1p0Unh0eGhrczI1M1MyS0JmbFAyRVpkeUM3?=
 =?utf-8?B?enpmaEhjY205N2ZhY3VrUDJUSnU0ckZHMUxKZWw2K3RGWnlCNEp4ZWEyQ1N0?=
 =?utf-8?B?VDkxOVNYUWVUeUl0TXNDU2hDWHNpaHhMQktGSXdSUUJsMXlrUXdZUjMzbmwv?=
 =?utf-8?B?SGlWQThXOGM1VXBmbkJXOUNFdXBWbkxhcEpmdkJjRWN0bVlTQ0prZkFlay8z?=
 =?utf-8?B?Z3RGQ2hKbEVjSTJvSmdUa3FrRVVUOUE1OU96SC9vdW1QQWEyUHN3dkpndUg4?=
 =?utf-8?B?Z0J1RUlDa243SStyV3crdmsxNERsQXRQb2g5bVZuKzVVN0YxM28xR3R0MGRO?=
 =?utf-8?B?SGJFNDB2MzhCcENHZFREczdXbGdnbUZIaTkzajRueUNIaGVwTlFaQXltZ2VY?=
 =?utf-8?B?TXBMOEtLcEtLK3Y0VGtuRWdTM3psMkg0aU01R05RNzQ5ck5HZjQ3YWtVaU5C?=
 =?utf-8?B?a0p0K0NXZE9MeDZsMGV3N08rbFh4anJCOGtpWnBmV1JVOUdFOCtzSitJVnNC?=
 =?utf-8?B?WUJwRHJWZ2pJRUZnR2RkdHhwTVVXblpDOFFTZEZ6SkJLZzZncCtNZGI2bVRW?=
 =?utf-8?B?bStvMFhCcTVDUldZWUVycXpPZi8vOXJCN1ZQZThVYlp3WGlRSW5LanliaWlu?=
 =?utf-8?B?dVdDaFlEcnJFZ3FvU2JMU00xRkM3RnZndlpqYS9LMEpVOWNrTVduVzhPT0pF?=
 =?utf-8?B?MlIveG5nTnJFem9MMElIRkRQZkpKL0Q3V29KNVhpdStlcFJKbU1WOGFlNWxT?=
 =?utf-8?Q?jvW/JINx9GYBL0rjQc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTdoRkNmUzJlbTlxV25keXN5UFV0bWwzbklKRjFuWnhvNERWUUxWRTRseml1?=
 =?utf-8?B?aDBQU1pJRkFTNGRHeWI0R2dNdnFyVGFMTzM3a2s3aEpsVzVFeXQ2NE5ZcmxK?=
 =?utf-8?B?VlVvK1NyRStHUnhLcDEvYmpmZzM5WXUvZytUTFZJSzJkZkdDNXozSUdCRmIx?=
 =?utf-8?B?ZFJNcjBxdWk4a0VaWmZmKzNyODNaR25ldFhVYWo4ekZxVE40QWhhekRkQlFh?=
 =?utf-8?B?QzBJLy9YcWJweWFNL3BCZ1dWeFVGdGJuT25ZWWl1UmZmTUR6cHlGWXgzUjlp?=
 =?utf-8?B?L05KS2JrNUl2ZWhsaGNDK0ZDUHJ0TlBuOXJEdjJlOWNCV0ovaXllR3JudStl?=
 =?utf-8?B?MTlUK3N0SnpmSGxLNjNEVys2Z3hKWHlNTk04REVHVml4Nks2K3FwVXVjelBk?=
 =?utf-8?B?Vzl4a1BDb2hRNytRaGVpZERTRExLNDRYUEowa3BDTU0xOUtLdU9SVjBLUWRu?=
 =?utf-8?B?S1Jwc3BWT3Jucm92ZmVjelJXdlNyNVNRUjB2OVlhSmxOUFJHMVZyOTRVWmMy?=
 =?utf-8?B?VzVDU3NCRHVEcklPQTdFeUcxdDJyMlNxZEtEaytNb3I1bEMrSThPNVl6OXY0?=
 =?utf-8?B?K04yYnV0ZEpNSlF5UnpYWisrTTRTRHY4ZWQvYWFqcWRYYXg3eWh0WkN1OWdq?=
 =?utf-8?B?YVg0ZFZpZmxuaFkvZFIrL2xNamRmZFU0MGwwcWpKdTBzMUxOVWdFMXFZdmVx?=
 =?utf-8?B?SFZuSXZxZEE5Szg1N2hLUkQ3RUNpbStzWFlYYW5abi82TFo4T3dMeGUyT1RE?=
 =?utf-8?B?RFE4M1NPVkRyelNwY015V1c1dWdHVDRlMUorQUYzMFNVN0gvemJrNEFSQVk4?=
 =?utf-8?B?SkNHdnNEMDM3bnRLeTdOTnhjRE5id2lrTEdJcHM4K3crYk90OHN1UXB2K2pX?=
 =?utf-8?B?N0NONE9laG1TZm0rTjVjNEFMSkRPOXE0SGxYVm5yWDM5NTdsaVBLKzQxWWJo?=
 =?utf-8?B?eWdtSmtVU3NnRjBoVXdHYXFYbHY3UDM5N3g1TGZ4d2FaMysrVXNQclNtRUFT?=
 =?utf-8?B?ZU4xSlEzMzNGQVRjSDAvM3R2alNkd2Z6SGxuS1IwdXZwUTIzaE1IYW0ray9X?=
 =?utf-8?B?VG1xUGRVNitOZTlBTFl0M25JdURZaWdCZE5WSWlDQ3JraWhzbTRycEdpaXV0?=
 =?utf-8?B?aDNYeEpRclVXODBGTEx2Wmw2UURCNVE3V3ZEOFM0akxwMVZwcHFMdEcyeG52?=
 =?utf-8?B?Zm9Ja3lEZitPc2NPQ054ejJBdVhCNklIeXVJWjdHSDNZSms3b1hCejJuQmJO?=
 =?utf-8?B?bThOMmdUejRjRzhyYUt1QzVaelc1M2pGQVhKdXpjSkJIa3J0RTA4NjQvTTVj?=
 =?utf-8?B?aWNCdVNWS0QrSDBxM05KdmtTSHhZamh1UXFtNC9NTVJVUzBtK3JRUTVMSDNB?=
 =?utf-8?B?RU5FQmplN2NsY2NJT0YxOTlUTHRjTEtwVjNONEFwbW1wcGUvOGltOEtjdDNu?=
 =?utf-8?B?dmxjSWVFZm5pd0Ntb1Q4bTFDYTAyM2UrVDF5bnFwSXRwTC90SjNPeVhiZDk0?=
 =?utf-8?B?UzBFN1FnelhJT2t0UmkwWWFCUlFqV0FuK0xtdWl3clRpS1hzMmVBNEZDbzhM?=
 =?utf-8?B?M2FJYlBiWVIxLy9xOEViZzIrUG55cjZnTS9SSElpajZ6eUNkTDVrbEtPUTY3?=
 =?utf-8?B?STB4NzBpZlRlc2NoaTEzVWluSHROZ2piZ3dUSDdDcmxtWVBMQkZxZjVmdklx?=
 =?utf-8?B?bXhiWmpETjRkMXJOMmRoTUVUR3U0UlFkV0RQYmN5bEhNTWNTbkVpa29IeW5u?=
 =?utf-8?B?eDVPbWhrNEQwcnhwOGdlb0VVUmZ2ZS9YQXk0d2xZd1BmWWRGYkRvdnd2c3Bl?=
 =?utf-8?B?c0pDdURYTy82SWNqOVhGWE5Xa1NhalRjNVA1M0JJRXlIa3VjVTY4ZXhwckNz?=
 =?utf-8?B?VWlFS29XcUp1YmlHMkM3dHV0SzR6bzdKV2pPNDBzWjhTWlg1U2tLUlB3N1pN?=
 =?utf-8?B?bDFkNmxBTmFMY0ExL0xmNWR0UFJxd2FSQ293WTRyTS92Lyt6WU5tVlBMLzR4?=
 =?utf-8?B?Y2pUbmdlNVVyd0tzckJ4NTFnL1NQbUpkT2VxT2x5aHgrYmVjZktCY3MzbXVH?=
 =?utf-8?B?TkdtUWhjaW15U1RPZGFOZlpLTnFCa0Q2ZCtnREswSWpxNDU4SDF3MmpHUDlI?=
 =?utf-8?Q?Fjcj2U3LM2ZIRhn7ZUccfQUJn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258910d8-7e3d-4a57-839e-08dd0e304005
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 15:37:35.5707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEuiwrJFVVOfsKtLhn2aDGln/K34hQSykH7PrvyYBDr7f3+EFu4Wbfeht9gxwM1e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592
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



On 11/26/2024 7:50 PM, Mario Limonciello wrote:
>>>> Based on https://gitlab.freedesktop.org/drm/amd/-/issues/3781
>>>>
>>>> What if this callback takes care only of suspend case and leaves the
>>>> hibernate case to dpm_prepare callback?
>>>
>>> Then hibernate would fail under memory pressure.
>>>
>>> My take is this failure with hibernate is a userspace problem (whether
>>> userspace decides to freeze the tasks or not).  I think it's better that
>>> we /try/ to do the eviction and notify them if userspace should be
>>> changed.
>>>
>>
>> Hmm, the logic is kind of inconsistent now.
>>
>> For dGPUs, evict is required for s0ix, s3, s4 and attempted twice.
>> For APUs, evict is required for s4, but attempted only once.
> 
> Well the logic was inconsistent before already.
> 
> But FWIW it will still be attempted a second time for APUs.
> The call sequence is:
> 
> 1) PM notifier
> amdgpu_device_pm_notifier()
> ->amdgpu_device_evict_resources()
> 
> Eviction for dGPU and APU in S4.
> 
> 2) Prepare callback
> amdgpu_pmops_prepare()
> ->amdgpu_device_prepare()
> ->->amdgpu_device_evict_resources()
> 
> Eviction for dGPU only.
> 
> 3) Suspend callback
> amdgpu_pmops_freeze()
> ->amdgpu_device_suspend()
> ->->amdgpu_device_evict_resources()
> 
> Eviction for dGPU and APU in S4.
> 
> So yes it's incongruent that prepare() doesn't include APU S4, but the
> problem is you won't know at prepare() time whether it's S4 AFAICT.
> 
> Or is there way to tell at prepare() for S4?
> 
Now this notifier comes in before that and tells that right?

BTW, I didn't realize that there is a max of 3 attempts now (didn't
notice it being called in suspend also).

Thanks,
Lijo

>>
>> Thanks,
>> Lijo
>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>> +    case PM_SUSPEND_PREPARE:
>>>>> +        r = amdgpu_device_evict_resources(adev);
>>>>> +        adev->in_s4 = false;
>>>>> +        /*
>>>>> +         * This is considered non-fatal at thie time because
>>>>> +         * amdgpu_device_prepare() will also evict resources.
>>>>> +         * See https://gitlab.freedesktop.org/drm/amd/-/issues/3781
>>>>> +         */
>>>>> +        if (r)
>>>>> +            drm_warn(adev_to_drm(adev), "Failed to evict resources,
>>>>> freeze active processes if problems occur\n");
>>>>> +        break;
>>>>> +    }
>>>>> +
>>>>> +    return NOTIFY_DONE;
>>>>> +}
>>>>> +
>>>>>    /**
>>>>>     * amdgpu_device_prepare - prepare for device suspend
>>>>>     *
>>>>
>>>
>>
> 

