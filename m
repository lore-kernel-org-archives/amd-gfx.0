Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7C4CC6B34
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 08:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD1F1121E3;
	Thu, 15 Oct 2026 08:33:09 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F22710E0FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 08:33:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSwR8a8/AxIsmwYlQbgqLvxKPdzH1vU+CVUn1h/olpmSlwYdNNPrbYd94rHwLPP31FQs5ecZ/O/yNJsl3WyrIEG1rADA9bZJT6JmNT/N8oISOihZeH3V7JUY/yJmZJNzzen8Inpr8X5zJD+pLVd+tnxArShrIYPD1ZaSUr3z6qCtYB0/8YX8jHM2h2ulj3g4NH4cse6taurGwu7G25Z77TXj5SYTvgamhusg2hEPqjlz9UldxGteVkmOva3Y48eCAhJFPOnlUeY3d3/V2o9YLFkAG6FCZWfTbG+C6eXwDJE6bitZ0fFhH5ryZ34c1BesnqDEEdn00XFISgK65P8t2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtWT2h8gCOSUpnH6u+JFnapMod/CCYt2BJiwA/Vidu4=;
 b=V5OJUCvfPVoER9zh5KYF7XyeJLallgVUf9XipVHmc+hluLC8xopVQYMOtkKA8lyV+jwqRNIlZACjKztKqy46ekWnMGY5h8hbErEX6n5xJ53Zx1LtOaK+qGe46XDqGXJdNKBdImehg2ZshOsEANmpCGQTcfD5M5vUR/71N/z50oWIqPf9UlNmEerzFiPgIgfvDNvbjpVihBJVGuTGlbikQJ2rBqCR2TnHP3vDy2k8ZwD3vMhQ/vScSvfSyxnjfAErTWxCNArbKSuVeMcePmEMA7O9wVhkuu/oz6eRufGOncIBVKFw+hkzpe/5HNi+DBh9y5x1nWyYPz0zZm2wr7E5Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtWT2h8gCOSUpnH6u+JFnapMod/CCYt2BJiwA/Vidu4=;
 b=0EXtq53bz/dYU/a1KKLDqDOe+CrC01Ua6lIfwJ1lCRkTP1irMeoiHxfZmLMqSAE0erHrY6i9yrwzqKM+oYXZRMtHxEysk4bHEzP77H3G7toMqz/k0Aks1+Iy8mdb7mGyzW9EPoKyq/FNfxTDNPQqUcSgyGzxkvJ3EtAipTIJuow=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB999107.namprd12.prod.outlook.com (2603:10b6:806:4a2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 08:33:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 08:33:00 +0000
Message-ID: <43e70032-cfa2-4202-a8b2-6472fca5552a@amd.com>
Date: Thu, 15 Oct 2026 10:32:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] drm/amdgpu: skip VKMS mode-config helpers during GPU
 reset
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Prosyak, Vitaly"
 <Vitaly.Prosyak@amd.com>
References: <20261013082457.2492273-1-Prike.Liang@amd.com>
 <20261013082457.2492273-2-Prike.Liang@amd.com>
 <2991b037-fa46-4d33-a6b7-c7783c92b105@amd.com>
 <PH7PR12MB6000696BA9F3E5C409CC2ED7FB9C2@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <PH7PR12MB6000696BA9F3E5C409CC2ED7FB9C2@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB999107:EE_
X-MS-Office365-Filtering-Correlation-Id: a9007bf0-987a-47c4-c9a9-08df2a96ec1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: k6XED/O0XufYHvqiRLLQ75Ge5F5ImcoxueV0tiPfOQhERM4EjRIab8P/9YNChjVllzFHDWiLjpS6tr62Gk51cURTNYzMY4Wj/66HL9LHocM3/XUBUE2bt7WlY9+0r0C/TGvj9sU/C5nRXIJKU3Fpg/N/UxVOBZ0G6RPKpym5aYMUb9FrBnAmGw5PMoplcFTj4vY404DLsOpFi5pc+pXx9s8oDPRzQSUPIU7ijUPDMYUOn5LigIoUfiIx1g329Vr23y/k2v9rEhWxY3y+5mMRu3EhpgJB/dMKV6/IQcPde6ClIsAneFpiJF63/94vMohBOmqFYablPLPv0s4VJLFXRU8JT8rbYITWi4ekphxyTwhnaxiUIlW/2MrOOU6jrbcal6iZHIGX2vJ6ezX46TvWONttC1fYbgwdzI25WcyR3kFj4uP/bmS0gmZt6oV+GGfOUio+OC3M7evGnegeRFyZfTAKFrcEPAWGN8J/V2ZWK5rDgE/pozuKKDaUbAJ5TFHQSTu7EdQfk1UDqxZrKKTYpWDMyHjpPlxFK4MwHTDvqY5/AEe4ZY4icUsd6I1Wi2VnRgMXc4HyFFcboHG6s+Pl/Ao/kGhU36gciGtFXnQAl8XtrWmQzu1pzKZvS9GRCLzkfGRxzAPe0z2YFqE75/uLKwviJZzPouMzaLlW40+OUjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1JlZEtEb0lEUFpXVHNwN1VmeHRESGFzUW5Ja0JNUFc2MWNEYzVwNFNXL2N1?=
 =?utf-8?B?U1RFdUpUbzNBKys3TXdEQ1dSTWNQSU1KcjlDc2p5cmQvTUNBWHY0SVI4YzN3?=
 =?utf-8?B?a0dkVE5DN2Q2VkhYMld1SUVqc3Bvc3pRZnkyTU11eStLazRXU25EcnRoVG84?=
 =?utf-8?B?R3FvWVZvYW43WXJ0UDVoeXhxV1Exck5JS2x4elBrV2g0ZGZOaFhqWmdHdUpJ?=
 =?utf-8?B?SWxreDFBdStUemhFOW96QzE4T09WdW5Xb0QyaTVOb0VQOGNCMTAvdURjUmxN?=
 =?utf-8?B?RithdUgvVmQ4TnlwajYrZW5IQnhhaWZhSVQ4SG5sR1JYQTNGaEdrTFZOaFlm?=
 =?utf-8?B?aUlmVEUzbTBkWStPY3hDUUR1WjVTYjJGR1h6YUFaNWQvMGhkT0QxNVZlY2NH?=
 =?utf-8?B?aHpiSjV2Rmgrcng0eFdNUmxPdG4zU3dDVWowdHRsRmh0cUorUE9EbGxoRGhK?=
 =?utf-8?B?QXowYmU2TkVYS25Ca3ZpQ1J4cDJUTXBOckdjWTF1ckphRU54UzRuSTJXNGlJ?=
 =?utf-8?B?VURCQmFKVlAxSE05UGx0M2EzU3ltckErUkhmdTd6OTUwUHZLczNkWFlqbUdy?=
 =?utf-8?B?dGdBQVhnNXF4UzBYNUlUaVZ3YnZFNitVL1lpeEw1OTRxNFU5cGhHMzBHbmR2?=
 =?utf-8?B?c0FKbWtFV0dJaktUa0I4VEg1Q2IyYlJjL3dpSHJuVi9nSUtLNURHQWZKMDRI?=
 =?utf-8?B?bWVsWFc2NWUzZlF3V1p0SzNDeWJBbk9kZkdicjhRZHZMQUNGcFZ3Wi8vZVVD?=
 =?utf-8?B?WTdEZXRRb0VqcUVycFk1Mnd0TU1tbDJIalRkME0rL2s2MFEydXVzQkVMM2or?=
 =?utf-8?B?SWlmV1lJRllSa0E4QUo0ekRYVWdwZzAvaWxJWmV2dnNiR3ptbEx2amdRcHZh?=
 =?utf-8?B?dFJMQUNZSXNkK1NmVHc1SnByZ1JNb3pWUGxHemlic3BHazVhL0NNUmNrS1JX?=
 =?utf-8?B?dElqeGpxQnNDSUZXcW1NRTF6Q3BKcDdmUS9SdzEvTkNscU5GbUJFTHQzOXZN?=
 =?utf-8?B?aWZqZ3BDSDBmL3dEdDhwM0Y2RU9xOEczNlFvQnkrK3E3aFJjVE5MS0tmdEFl?=
 =?utf-8?B?bVMvMEh0NFBkeDVXU1AyMkRPYzVma2tPekFrVWIrTmVrdllBdGFqSWZpb2p3?=
 =?utf-8?B?MENQcVJlaWZzVW8xa2NtQU1CMjhBY0NyRUdzc1BLdEpLME5aTXlGUml5UDB6?=
 =?utf-8?B?ZGZpcUJ4VHkycmN2S0ltQmx4VzdOa01aWU54dXduY3dBNytGK29XMHh3OXpj?=
 =?utf-8?B?NXp6a2JMNmdzenNpYm9xR2xEd1Nla2cyL3k2by8vV2tPL3pDeDl0V0EzQUlK?=
 =?utf-8?B?RHZkRDlGdGxoaWp1SStVTjR2b2FobWYwTzk1bXUyNDdRcm15ajJobEJ4b2g4?=
 =?utf-8?B?Sk9KTFBkYTFOM0UvUEtuVXhkZDJQeHV3OHo3RHNMM3h6Mkw2ZVhlVUlJZ0FP?=
 =?utf-8?B?SGowUTkrcFdUZ2VGS2plOU9TSHNEa05UTHkrd2hpc2F1ZC8zbjM1VVVyVkpP?=
 =?utf-8?B?SWpZM1N1NGxCV0JyQmw3NGs2Rm5KN0NLZDNWWTd1K1EvVURIVm5KSmpaN2ZD?=
 =?utf-8?B?S0dJN0hyL1ljVGZCOXRvQUE3NFh2aDlORFlYU2lOZmZaTloxUDhUN2lUK1RO?=
 =?utf-8?B?UGtDVW1QL0VDRzA2WmpMeWFQL0FqUHA1VjNjZURaRms1L21NejFKQjNoc3lU?=
 =?utf-8?B?WTNKZEdpVHBod1pjdkhUUUtoT0ZYV2JPMVBwdHV2R1VOb3VScTVDMmJpRzFU?=
 =?utf-8?B?Z2txbzhRRUU5Qlo3SlF3c1hrbTdib0J0SDZPanZBNU9DSkg4Yi9xSHcwa04z?=
 =?utf-8?B?S2lzVjZGM0dOa0tTM2FLR003eGpHQ0ZGSnNWM1lBenlmbHhMQ2NFOG1peWhC?=
 =?utf-8?B?VEFCZERKN3Bveko1T1VpdW1sbWNxa1hKbDdQZlBzNlloTlIxUDZ3U2VNSUIv?=
 =?utf-8?B?TFpZSi91WDdLYVRENEkreUlOeVBPUUFYNHFPV2pTVWt1TWxZcEdlM2JWOXV1?=
 =?utf-8?B?Y3I4Q0dDbGJFMTQrRkRkWmJlVGlFdStNTXlIYVQvRUtCWWp5aXVnLzZERktx?=
 =?utf-8?B?M1lMbGhuY1cwNVFpV2xtT1RZU0U1MkVzSFUwL0NBU21pcXNhZzJmNVFQZy9N?=
 =?utf-8?B?K0luN0oxUlVNSllidDNoczhFTVQvdTVNWXkwR2dPclVLUkpqd2dadDNIN3Bm?=
 =?utf-8?B?RisvOW5JbTdFeklxdDNmbjBJWVV1ZWRRb2FpRklDWlJZTHpmNVhPdVBmNExh?=
 =?utf-8?B?NnJsWHhNYjcvbTQzZ2JmakFzWFgrQTFwSTk2OTVMWENleEwxV2p3Mkh2Wm9s?=
 =?utf-8?Q?Rn7HJqQMsZa34LPs5C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9007bf0-987a-47c4-c9a9-08df2a96ec1c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 08:33:00.6570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOXfx/TqkWqDUOMSfq00YKlLkMZOtpeZzT9zPf+zW0HFmOYkeJRmoN94K07iTtqO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999107
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

On 10/15/26 05:45, Liang, Prike wrote:
> AMD General
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, October 13, 2026 5:28 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
>> <Lijo.Lazar@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
>> Subject: Re: [PATCH 2/9] drm/amdgpu: skip VKMS mode-config helpers during GPU
>> reset
>>
>> On 10/13/26 10:24, Prike Liang wrote:
>>> GPU recovery already notifies DRM clients. Skip the VKMS mode-config
>>> suspend/resume helpers during that internal reset to avoid duplicate
>>> client notification and atomic-state handling under the reset lock.
>>> Keep ordinary system suspend and resume unchanged.
>>
>> Clear NAK to that as well.
>>
>> The amdgpu_in_reset() function can only be called from inside the GPU reset itself!
>>
>> It is *NOT* allowed to skip any operation outside the reset depending on this.
> 
> How about moving the drm_mode_config_helper_suspend()/resume() calls for
> VKMS into the system suspend/resume path (amdgpu_device_suspend/resume())?
> VKMS has no hardware state a reset can lose, so recovery doesn't need them,
> and that can drop the amdgpu_in_reset() check entirely.

I'm not an expert for the VKMS stuff but that sounds like it makes sense to me.

Regards,
Christian.

> 
> Regards,
>    Prike
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>>> index d6b51b3f216b..a49c7dda4c4e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>>> @@ -491,6 +491,9 @@ static int amdgpu_vkms_suspend(struct
>> amdgpu_ip_block *ip_block)
>>>     struct amdgpu_device *adev = ip_block->adev;
>>>     int r;
>>>
>>> +   if (amdgpu_in_reset(adev))
>>> +           return 0;
>>> +
>>>     r = drm_mode_config_helper_suspend(adev_to_drm(adev));
>>>     if (r)
>>>             return r;
>>> @@ -505,6 +508,9 @@ static int amdgpu_vkms_resume(struct amdgpu_ip_block
>> *ip_block)
>>>     r = amdgpu_vkms_hw_init(ip_block);
>>>     if (r)
>>>             return r;
>>> +   if (amdgpu_in_reset(ip_block->adev))
>>> +           return 0;
>>> +
>>>     return drm_mode_config_helper_resume(adev_to_drm(ip_block->adev));
>>>  }
>>>
> 

