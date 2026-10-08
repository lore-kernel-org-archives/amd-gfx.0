Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52640CA600A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 07:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5AFC10FCEE;
	Thu,  8 Oct 2026 07:50:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ar957dDI";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012007.outbound.protection.outlook.com
 [40.107.200.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7FB610FCEE
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 07:50:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaWozzU2zuk6IkkreDW7rxq6/nQlBVc5+AFeuqClr8qECDZ2bfbz5cjcQczpnj0RMQbH7LN6tJ69vzWsqa51FeAUm2UD1sDgtB0eqSAWP3Wo0zAA4IhjjWowCne7gv/zgYSu/72r5KZc+XtqLHHrMpF8Y6Q5Cfhv0lSzJQiXEYRSjNHuIPcT/WVzMDdV7cNbchVulPxe9FuJAAVME+pOjSz8hqd7cajy5yYhdcIE3Kp1X1JMq1Dyv+fBcaOeyEikovOhJ8Wf7LR9LCF4zsMGIyBbE6smn31gx7nz8aCytXVxE4RFvjGEkqd/vfWHVLtMrfWbFfdsyQpuZokdo3FrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2FlfIHcTJxToAL9A0YV1KQwC4h7Bsm31J5rsw2vNu8=;
 b=arLxklA3M0ezrTFJDknvDBfZzJirqkgg0jRW1BCGgU96JunXzTk8A/lQ0hKRIyFZ49j3Gx+NzdyCl71FGp/rpFoMt1Tb2H0jdVASVTV09781zN77XJGTpAIogH6hDakFfBGH0/yErm60g0R5L/FubQzCn5wxhdL0/PnEBJ3HjuaKP4yHy2D4IzpGlkYToaT85bcL/+g4BXJvASqZu51dXJKYu+qttJrox5PsresTiqA1ASstSL+csbmsR1PM/d2WCiGhUnaiXpraV5bQv/3JlF5TQNFAiAlRMwxXKzSDkK63K0aHmvf5JRkwN9cVARQhSUYiECPNqJoaslToHbb2/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2FlfIHcTJxToAL9A0YV1KQwC4h7Bsm31J5rsw2vNu8=;
 b=Ar957dDIAEbLVcI42rKYjxlCvyk1Y/+mgoq8IeVxU5uBH3SxqaEAEW2NyCsG34EPwm9tbrfT4R0MXr/PsWIcgwfEoOeewAlOinKAUeXmWbAJ4VmyLmhYjaZkfPNUwxaWbFk9JE22DulZ1Km+CecOtMxyimpcCvaZsRK3knhYsw0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by DS7PR12MB8276.namprd12.prod.outlook.com (2603:10b6:8:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 07:50:49 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 07:50:46 +0000
Content-Type: multipart/alternative;
 boundary="------------iJeku7Bew1iY8shIVh3YdaYI"
Message-ID: <c96bc906-c6aa-479b-84d6-75ec1816e853@amd.com>
Date: Thu, 8 Oct 2026 15:50:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 02/10] drm/amdgpu: add device-wide PMC config
To: James Zhu <jamesz@amd.com>, Alexander.Deucher@amd.com,
 felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
 <20260922093436.596947-3-lingshan.zhu@amd.com>
 <d3144b38-64a3-4bbe-910f-722912f9fc66@amd.com>
 <6394fa47-ec53-4e54-9cc9-bbd59b97f174@amd.com>
 <61ab80af-0a33-4660-9f80-13966c3583a2@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <61ab80af-0a33-4660-9f80-13966c3583a2@amd.com>
X-ClientProxiedBy: TYCP301CA0013.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::16) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|DS7PR12MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6cd7c5-5989-4f38-bffd-08df2510dce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|10067099003|8096899003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: C9KkPoToLJhw+aeLPTxpXov/C9YvEKxURjw6r6xZscahJR4kzSlEcF5iXWCtJNor6KQe7DV/LknooAMMazIKbuiK4nYXW7M3HeAOq2Jlqd8HHiFvLlT689f4N/pwLLSYKPlr0xTlZP0Qq7JzD6vgcnb54W06mEK/BJGQNvKlOQ2/qDsuk7M0IrWV9ERrB7uG5B0gCU2mPk2UYjCnULQ7uyVD8oplydpvUx8LJqBUOSZiS/Am7AMb+kJfnwJXOURUonVBsKR9g7vUl1h7JLoini4UeoO6APDvOwIzlPb5E/qfex3g13FgCli87pPSJa5IWvNgfUQCbPSwl3zx2DsHGpx0wg5z24XxSKKoPkRsWHXsJs6Flf16+bv8CZgfvMA6MI9JPNrng7/wgZ1DUVFeOIIiNmRqvcwV8/pffR4TPsXxiaVn2rPC7HRD/PkwdExzxiCyA3K3SJAZ8ce4dL6iejAmZnJhwtV+RMgv/T9qyMO8012OOCCCVFSi23oe/zEQKKBvLxTbESEXtZ6OwOD0Z7clb0xw3xur3lX+dhAYDMW0UXw5ayZtg5djl4UQprIKsHsO4ysCBZrpl/Qs3LK47NJZ+8yiP1BY2mygrJ2Jq4PFZNVREmtVPZjBDvtrw8ySDBDzKcUaoi1lVAU35trtMQsE2eF+xK5Ile89oC5Rr+8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(8096899003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDhYUnVkelRjaE0wUmJaWnRvb2VSOTI2d1h1elRpcnVtQWFLcEJ5d25mT0VT?=
 =?utf-8?B?a0dJaDRjTHBkUjdCYk52Z2I2YXhIMmpyVmdFbE1RT1J2b0J0QjJKS2tuREpq?=
 =?utf-8?B?bGViUWVuRThPMXloUjJuaExzNlJVV0d3cU1sbkdFcUQzeWQwZXQ5cDF5cVQw?=
 =?utf-8?B?MWszRGIzTjFhYmlvRGZBMXRkMDRMQjdNbTZZVHpBaHhtNFhhRllJczdMejgw?=
 =?utf-8?B?eHZoaTB6MG9kdi9QYXl3T0RsZU5DM215bEFrODV6M0Z1UHlYTjJrQlVuTmVG?=
 =?utf-8?B?VmVRRDh6UVowbXplYUtUNTd1LzlTcXBDZnpvUlhxVFNNeXF3VFk3WWcxaXRK?=
 =?utf-8?B?Y3Q3M1BnNHRTVkZRZDk0Wi83TG8wWjdqdFRsaVlMWU5MWExnVFlEbURUYzY1?=
 =?utf-8?B?QmgrKzMyY3IvcDF6UVBZd0pWN1FRUEswOXQ2RThSRVZmTnpTTkt3N1ROMVlK?=
 =?utf-8?B?OEdnTTZMQk96L0w1SmxSVWNxaTF2RVRwWmc4WEw2azJscVZkNXNYYUQzY1l1?=
 =?utf-8?B?ZXZrMEZEZ3lXdzZITGVVSVNDK2RoTDlncVBQQTJnd2ZCb29HY1BYTXVCVzIx?=
 =?utf-8?B?WDJTcG9vMm9uejZlb0cwOWg5eEE2NTliV3VIMGdBNEt5MTRGZEhMcVFFM1J1?=
 =?utf-8?B?TnN1bmNDd2FuK0ZEZFdKdlBHanFyOGNBQjFwcEQzUXJiV1dSUHlrVlZtaTg3?=
 =?utf-8?B?ck54SXVJU2o1L3hTWTZHT1Z4NGJLQXhNSTFBWTMybVdJdCsvSDZnK0wxNVNv?=
 =?utf-8?B?Ky9nT3FOSlA4T3RRZEJBM3V2KzF0aWhacjlIRllWMEV3a1haSmtnY2JxanJR?=
 =?utf-8?B?S0Q1Z0lhMGtEZWRid2tqdEJhZFk2aTcvTjQzb2F2MlNLUXMvTmMwdUJrY0NX?=
 =?utf-8?B?WkM0VEJGNzd3eFpNdGhJV1hra1NiNkc4dlFJMWVhR1hCc2hJYkFWekZxdzVR?=
 =?utf-8?B?QkRPWjd5RzE1S0NUNzgydCtJeGMwQktqK09FTjNHbjMzTUxmei90aUMxWHZl?=
 =?utf-8?B?alNDYkdSYUJKZkx5N3VJWEFFQnM3a3dwcUgzTGJ6OVowejFwN2NqaWRaenR5?=
 =?utf-8?B?WVRmWTB2NVY1a0hIR2cxb054aDZwZUFqK1V2WE5TQ3IvaGFrVythd0pwNDZK?=
 =?utf-8?B?MTNlaExGSUE4NXVwbnhmLzZHa0hhckpsZit3enl4RFFEWldFVVVLNmNTU1NP?=
 =?utf-8?B?a2FlaUJtZkVNd1RaYUtzd0oyS1QrUlcxdUVpY3VkVENlYWk2Z1BCL2dDMTJW?=
 =?utf-8?B?MmhFcmxZakFDbEw2clJyUWh5WnBJTDY0dlpsOG1TbWgzQThQL1dYRG9OcFFG?=
 =?utf-8?B?NXNwaWdDQzBhcURXZnoremVHLytNRS9QaGRvQk5jOWRHUHVlS0tBdFJ5RWVX?=
 =?utf-8?B?Q0xWVW9NQjN1UDhFYmxsMk9adDFIOXpnNGxKQUJIWndVVGNXVS9jcmVUODhZ?=
 =?utf-8?B?dDRQNk8vemkwUU03UE9MV3dCMGR4dS8ydjdZMUlHN2FkT2hTN2V5bitJM0Zt?=
 =?utf-8?B?cGd4L0xsSmxwb0p3Y1ZOZk1NbU9UcCtpTWdHNUduRC9PTEtndStaM2pSbFR2?=
 =?utf-8?B?L0xsK2JOS0s1SHFhU09WVi9qdEY4eWpwZlNTT0wzTklrSU0xRzltc2REekNJ?=
 =?utf-8?B?eUM4OWVrR2VaeE05MytDMmtCWkY4OWN6OFJSN1Jpd3loVlUzU0d4NjJZUCtV?=
 =?utf-8?B?aWV6UXdoTXhycDd1eWpMdi9WK09ZNVNjRGM1T3NhYkVMaS8zVFFmcWxYSGpw?=
 =?utf-8?B?NmZJUzM4TEVuQ1lOVkJzcnFMWG5vSjJWQUU4N2tPWDdEYVp2elpqSVkvL1E3?=
 =?utf-8?B?blVaM2VpQzg4aVM5bkJnS2cvRE9nbFlHTnlkd2M2S3habHFiMEZha0puWGNz?=
 =?utf-8?B?M1RMTEJaeUdXRHZGOVJ1YzVtRVNiV0RFWEhBYjUrTVM3SlRnVkkveGovcGEz?=
 =?utf-8?B?YlVRVnZoNWRsUlZSbXM4MSs2MFR1NjRUMmZ1MFB2T0RQOWw1bEsvamhjeVls?=
 =?utf-8?B?dVZVSURVV000RCtFR1IxRDM1K0o5VVJUYUc1czA4Y1RNVkw3WFhFU1l3UDIy?=
 =?utf-8?B?WmNlWDBscTQ0SVRFUG01ZFQvTytoZnFvd3p6aXpNOWZWRVB3Wll4SHdiZ3hZ?=
 =?utf-8?B?WXZPTEZJUlZFMFdDMmlXejh5N3h5ZEQvVDBxa2lUUlhIV2NxVGZXOEFEV2Mr?=
 =?utf-8?B?Rzk5MW5sWlJhNjVMYlV6c0xVSUFoR1E3QVhLbXN4b2ZDNDNmS2Q4S3FnSXIx?=
 =?utf-8?B?UjdZVHVIZWFiR0dCZTVIRWJ4TWxxd1pEZm43dWZmY1ZvZDV6dXBVNEd2U3FR?=
 =?utf-8?B?OHVUQmVNWmo0YjJ6eFcvL0tRbW45TkJHSktCUDB0OC9XeThZcno0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6cd7c5-5989-4f38-bffd-08df2510dce1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 07:50:46.6818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwX3DD0SZ2mopokw0iOwognORSQ54Z/q1WxFg1xv1avCOpyxRNYeYgQofqjEVUhuQ8XZ62J8c7i3gZYwaaj9mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8276
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

--------------iJeku7Bew1iY8shIVh3YdaYI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/24/2026 11:40 PM, James Zhu wrote:

>
> On 2026-09-23 23:23, Zhu, Lingshan wrote:
>> On 9/23/2026 10:13 PM, James Zhu wrote:
>>>
>>> On 2026-09-22 05:34, Zhu Lingshan wrote:
>>>> This commit implements a device-wide PMC config
>>>> for amdgpu, which including the profiling owner,
>>>> and the profiling enablement indicator.
>>> [JZ] I think it should be render-node wide, not device-wide
>> Hi James,
>>
>> It could be, but we don't have a requirement document defines the scope.
>>
>> But normally a profiler is a device scope,
>> I see KFD profiler operates on all queues under the device queue manager
>
> [JZ] One device could be split into multiple nodes with different
> processes running.
>
> I am wondering if this is really we want.  Ben may comment on it.

Hello James,

Sorry for the late reply, it was mid-autumn festival and national holidays.

In my understanding, there is only one set of PMC registers on the device, so it should
be device scope.

Thanks
Lingshan

>
>>
>> Thanks
>> Lingshan
>>>>
>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 8 ++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>>>>   2 files changed, 11 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index 8eff6b9ebe81..45897dca802f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -620,6 +620,12 @@ enum amdgpu_enforce_isolation_mode {
>>>>       AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
>>>>   };
>>>>   +struct amdgpu_pmc_profiler {
>>>> +    struct mutex        lock;
>>>> +    struct drm_file        *owner;
>>>> +    bool            enable;
>>>> +};
>>>> +
>>>>   struct amdgpu_device {
>>>>       struct device            *dev;
>>>>       struct pci_dev            *pdev;
>>>> @@ -818,6 +824,8 @@ struct amdgpu_device {
>>>>        */
>>>>       struct xarray userq_doorbell_xa;
>>>>   +    struct amdgpu_pmc_profiler    pmc_profiler;
>>>> +
>>>>       /* df */
>>>>       struct amdgpu_df                df;
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index c924a55fd16f..74ed42e53264 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -3673,6 +3673,7 @@ int amdgpu_device_init(struct amdgpu_device
>>>> *adev,
>>>>       mutex_init(&adev->pm.stable_pstate_ctx_lock);
>>>>       mutex_init(&adev->benchmark_mutex);
>>>>       mutex_init(&adev->gfx.reset_sem_mutex);
>>>> +    mutex_init(&adev->pmc_profiler.lock);
>>>>         /* Associate locks with lockdep classes for ordering
>>>> validation */
>>>>       amdgpu_lockdep_set_class(adev);
>>>> @@ -4244,6 +4245,8 @@ void amdgpu_device_fini_sw(struct
>>>> amdgpu_device *adev)
>>>>       kfree(adev->pci_state);
>>>>       kfree(adev->pcie_reset_ctx.swds_pcistate);
>>>>       kfree(adev->pcie_reset_ctx.swus_pcistate);
>>>> +
>>>> +    mutex_destroy(&adev->pmc_profiler.lock);
>>>>   }
>>>>     /**
--------------iJeku7Bew1iY8shIVh3YdaYI
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 9/24/2026 11:40 PM, James Zhu wrote:</pre>
    <blockquote type="cite" cite="mid:61ab80af-0a33-4660-9f80-13966c3583a2@amd.com">
      <br>
      On 2026-09-23 23:23, Zhu, Lingshan wrote:
      <br>
      <blockquote type="cite">On 9/23/2026 10:13 PM, James Zhu wrote:
        <br>
        <blockquote type="cite">
          <br>
          On 2026-09-22 05:34, Zhu Lingshan wrote:
          <br>
          <blockquote type="cite">This commit implements a device-wide
            PMC config
            <br>
            for amdgpu, which including the profiling owner,
            <br>
            and the profiling enablement indicator.
            <br>
          </blockquote>
          [JZ] I think it should be render-node wide, not device-wide
          <br>
        </blockquote>
        Hi James,
        <br>
        <br>
        It could be, but we don't have a requirement document defines
        the scope.
        <br>
        <br>
        But normally a profiler is a device scope,
        <br>
        I see KFD profiler operates on all queues under the device queue
        manager
        <br>
      </blockquote>
      <br>
      [JZ] One device could be split into multiple nodes with different
      processes running.
      <br>
      <br>
      I am wondering if this is really we want.&nbsp; Ben may comment on it.
      <br>
    </blockquote>
    <pre>Hello James,

Sorry for the late reply, it was mid-autumn festival and national holidays.

In my understanding, there is only one set of PMC registers on the device, so it should
be device scope.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:61ab80af-0a33-4660-9f80-13966c3583a2@amd.com"><br>
      <blockquote type="cite">
        <br>
        Thanks
        <br>
        Lingshan
        <br>
        <blockquote type="cite">
          <blockquote type="cite">
            <br>
            Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 8 ++++++++
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
            <br>
            &nbsp; 2 files changed, 11 insertions(+)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
            <br>
            index 8eff6b9ebe81..45897dca802f 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
            <br>
            @@ -620,6 +620,12 @@ enum amdgpu_enforce_isolation_mode {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
            <br>
            &nbsp; };
            <br>
            &nbsp; +struct amdgpu_pmc_profiler {
            <br>
            +&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock;
            <br>
            +&nbsp;&nbsp;&nbsp; struct drm_file&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *owner;
            <br>
            +&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable;
            <br>
            +};
            <br>
            +
            <br>
            &nbsp; struct amdgpu_device {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dev;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pdev;
            <br>
            @@ -818,6 +824,8 @@ struct amdgpu_device {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct xarray userq_doorbell_xa;
            <br>
            &nbsp; +&nbsp;&nbsp;&nbsp; struct amdgpu_pmc_profiler&nbsp;&nbsp;&nbsp; pmc_profiler;
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* df */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_df&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; df;
            <br>
            &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
            <br>
            index c924a55fd16f..74ed42e53264 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
            <br>
            @@ -3673,6 +3673,7 @@ int amdgpu_device_init(struct
            amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;pm.stable_pstate_ctx_lock);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;benchmark_mutex);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;gfx.reset_sem_mutex);
            <br>
            +&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;pmc_profiler.lock);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Associate locks with lockdep classes for ordering
            validation */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_lockdep_set_class(adev);
            <br>
            @@ -4244,6 +4245,8 @@ void amdgpu_device_fini_sw(struct
            amdgpu_device *adev)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pci_state);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pcie_reset_ctx.swds_pcistate);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pcie_reset_ctx.swus_pcistate);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;adev-&gt;pmc_profiler.lock);
            <br>
            &nbsp; }
            <br>
            &nbsp; &nbsp; /**
            <br>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------iJeku7Bew1iY8shIVh3YdaYI--
