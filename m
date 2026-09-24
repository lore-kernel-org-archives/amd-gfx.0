Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03840C98318
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 15:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E69110F683;
	Thu, 24 Sep 2026 15:40:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vzmAoXql";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013013.outbound.protection.outlook.com
 [40.93.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACAF210F680
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 15:40:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HA6lfOk4mEDK2VJtQohIQVgdZVRepDqxHwKVo57CfZo1aZSANTClek9812D4p4bwe1hEiBJ7r4b5RFABH1ePOuGcZrunKjydcgXMFLUuZtFATloroPYwG3Ifaj+/ZQIaZoMJGvbeN2CzbddJRoJ4E0KnEbDavR0cQeB60w7b4wcl9+iZgOtKxP7baNCjloKR5ik1rYBqmCXQBegZQqyi/EcJblkP6UwMOOuwM5QUOaEBQfu0sA26kE25kyL7TC+8AH99JCBmb1tUQ4bluV4krxm/gAlbXwoLP4Mb5HeRD96fRgYPR5qn8gVnPqg4mQKq8GwObZDGiJzeJ0e4lQa8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afUPiLgyngBrnLYmWuDKOJ5eexW3u5BE/H365gIodwI=;
 b=TVujfeCC0IrXCUkLuhMnywNW+3pPU2TQnhb77kQMiNMrCaSCAGk4CCAWFr6K/qTDSjPD8bcEqyrWbH1FCAK7hDCkzm0h2sX32C1TvSzRgjA48yvPFHkKcEJ0JWz8W3rICHpJqwVFskfhRd5SuCg2fh0xZLNZofa6/gdHmrO/Me2P45EE8GXW6rhn01j5zSUcBEDTzC4MpuZ9YcWkTBPGcRTV3hJmUyUD7AeBqlNy8JxkhGShLrYwH2wLhM2tS5uYvAD3G1SXPL0n5MAoTJmwFWKBPo20upv/OoW+1FwSO2Xt8nDsR26Fd9TI4ejv/XCIYK8MmWXK/D5JylbBDkEbFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afUPiLgyngBrnLYmWuDKOJ5eexW3u5BE/H365gIodwI=;
 b=vzmAoXqljVoJSWYVA31hH1Rtd44oCeP1HwDEDzCXkvqw0ciomHhfOnh0obUPMPRZ7gEcUkH5Pw9HrwnWsLikgywtFiyNDxUyaNs6iclod/SvFQZ67HDGhcnfdye9qS67yYQlSLdXtFw4O2P/EVqAyWah+cwUhZ+mq2RVg4ifUjc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 15:40:42 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 15:40:41 +0000
Content-Type: multipart/alternative;
 boundary="------------8Zg4P4QWNqF0i0cnGjFyAHOy"
Message-ID: <61ab80af-0a33-4660-9f80-13966c3583a2@amd.com>
Date: Thu, 24 Sep 2026 11:40:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 02/10] drm/amdgpu: add device-wide PMC config
To: "Zhu, Lingshan" <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
 <20260922093436.596947-3-lingshan.zhu@amd.com>
 <d3144b38-64a3-4bbe-910f-722912f9fc66@amd.com>
 <6394fa47-ec53-4e54-9cc9-bbd59b97f174@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <6394fa47-ec53-4e54-9cc9-bbd59b97f174@amd.com>
X-ClientProxiedBy: YT4P288CA0061.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::15) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: d778ec9a-8cb6-4656-3a89-08df1a52307a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|22082099003|18002099003|8096899003|4143699003;
X-Microsoft-Antispam-Message-Info: RsZIFAGvQtDl15uKNpgYHbZeeckOeYlsny+QJRSISgKKD2U+31XVnKaargQ4FmrMRk+mL3STKc5e+X1Pm/ChhWLbyAxy+h39gOSHasBqei4gbuxlQOT6pXtv6tacKhlLUeLolKJPZMpNM6+cSV4C9zSzczrz59LNIvXx55B2KLWAIEmt1/ptX0JET1qxQ2aXP7wPGqahD0R0lqUWcK+m5SowRY5djgTqzxFwRGli7EzGNnnTDT74NRVt20YKjl+oIHyYkMHSSZjrlyRjmMdaxFqIGJYq9zUp1d0oyVapglPZu7XKrQNc6KjgI0/T3/zh4pDUS2+BOq3NvLZAR2akzSvh85Fv/60QMSfeGO5yuG0oSBC57CIKDgKJ7Hc30hndmSiBvS7clhU8w88xEXKC5zL1UyBQUDxAdc/xGwDo95bq/v6ZbP8714LnwRDSZcKhYBJFXWtlrK+02j8FdLBptDUvGr/DOO3S18Mwm3PJRw5cenzK8DPHQBT3j+2YmssqUC5cxzC6SbEC8EkU+LnYl41O3Qujb3y7T53lBbk4mzNi0v9nzxa1ZMICz7YjdfalNkFOPgZbi6OzQcm3WoJXuApKDuBZ6SOOYMg7srpEKW6XtaR4UPI04yCxncjSA8GThQDFk3GLb1RAmPihjuxW44WlAJ26wwtqFnHkJYIonKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(8096899003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1dkSGdoU1d6RDBwc3licGhqVlNOamJ3YzF6alZLMVpxL0hJRC9JdGMveVhj?=
 =?utf-8?B?VHhrR1ZtQi9tUitveFRxaTZrSUxmRlRDVGlScTFScXNrR3dYbkhnb210dWox?=
 =?utf-8?B?YXNsRVVEbWNkbnRpRFZvS21qQVFoK2Ntd1NON1EyNHN5RW1ibWtzODdLdTJV?=
 =?utf-8?B?VS9GNXFOSnJ2Z3EvSWZkOCs5TmNsMDh5dHg3WmxEdG1HbUZtY1dkTGdjamE3?=
 =?utf-8?B?SmlnRzhFbUowMTk0RXFkN294eFhOZ1p1NmMyR3RxTklscUxnelpVVHlRTU55?=
 =?utf-8?B?ODVobEo3SWJueitMaXBsK2dveE8zb25hL0kzb1Y3ZWhWU2ZxMkJtSXFhaHhJ?=
 =?utf-8?B?a2RsV0lOV2c5OS9ZUnV2aWk2KzRvL2E0Z2pTOXQ0RUM3K2FkWXNrSm9oVDdV?=
 =?utf-8?B?TURvOCtGU1FnSmN3Vk5ITEpnYmJiamRVS2dIQVlNcnB2K3hFOGpXMHlzV0lL?=
 =?utf-8?B?VXVkeUV1SDYwbkR0cUNSem9iL1Y5NDI1Sm9CUndEM2ZyQlNTNDUrUjNqSGoz?=
 =?utf-8?B?c0pHZm91VWxFcnloQVBGZmtpRC9icnc0Q0UrdXJjNVdkcTlCdC9uMFhJcE5V?=
 =?utf-8?B?YXlCb1VyeGNYWjQvdE0yU2tNMjBERHh2bkJKcXBWMGVOaWxiYTkzUU5vSnpB?=
 =?utf-8?B?UlJpdmVMODR2Wi9VS2k0UnZHa2FTUEg2VEJ3UTg1aGRnR3RjYWFLcmdHQUVQ?=
 =?utf-8?B?UC93QlBsNkVTMDdZNFQ5bDlwZUpwWUltbGhaeGZkNnN2dlJRNmYxazhUZjRJ?=
 =?utf-8?B?OFV1VDVmeGlkdmNvV3dHWmRKa1ArMU83V0NxMjZxQWNtcDVtYUt2V2lVcGs3?=
 =?utf-8?B?L2pBeWU5VFB2ZUl5anRVai9PcnRXWW9ialdobmNYWEphWVlvRDl1NlZPVC9C?=
 =?utf-8?B?V1UxaWRUVmhUYjN3REpCbndZMFpuN2VzK215SGpLeEtIMXBwSE9WVHI1T3Nu?=
 =?utf-8?B?bktqbkJ0bnc1N1J3RHV6eEZIZUY0ZTRZbjlFV1NFOER3enYyQlJLNmR0M2hS?=
 =?utf-8?B?VDBrbWF5UjE1ZFl4N25XcmNRWWx4NFhMYjMxTnNheWpxQWV6TytIcStPWFVm?=
 =?utf-8?B?QlNYcndPaysvYk5lTXg1YkhHL3pzbHEwRjNhZzFLYUo4MUlxZE5HRkgvcUlu?=
 =?utf-8?B?c1VrMW5ONUhqUkc5RTIzSTRMSXQ4anlhS21qS0dXVkI5bmJia3F5MzdFOWdR?=
 =?utf-8?B?ZmRyc3kxMjN1V1pySEdEQnZWZ1l0RGl6R1ZjNXdMT2pxQXREcmxrWnBzNUty?=
 =?utf-8?B?ZWZyQTRFbnM1VktSSE96OUF1TGlGZzNRcFJoRFcveDJ6ZDVJcUR1b2FUbUND?=
 =?utf-8?B?NkEvSFNIb0hQYjJpVXg2c0M2U2JXTXlXYzVYelJaRlVDc0RqMFdCN3kvaVBn?=
 =?utf-8?B?QnMvaERCcnZJaUxndnRjaXpsSzVGOHRWT3NNY2syRFV0bEgrMTkrdWRLRyt1?=
 =?utf-8?B?cmcra000UHZWT284azc0b21SeTE5UHM5TUlVeXlBbEpuRFpyZWJFQ2hScTZw?=
 =?utf-8?B?UnlrZG8yTE5hcisxUnFEMHRhT2gxMjVtL21vUUh6L0ZjOWpBMUp3L1ZoWnZj?=
 =?utf-8?B?NjViQ1Y4a3hWSkU4TkdGS2F5anMrTTY5Q3JpQVROcnB4Rm9KN0hmdmhxMFIz?=
 =?utf-8?B?RzdZcFBFWXdjUzdqRENHbEFSQ1JBb0hHdWZiWGV6TWZsWnl2SUx2Z3NZcGlu?=
 =?utf-8?B?UWc5ODRKeTBUdFkyU1RObGFZekNRRWlyWVZ6OTdhWFJVOFJyMnRCbjZ6WUxt?=
 =?utf-8?B?aFBjS244bm1NdE53WVozUHhINlh1dFlUM2dDeklKWFVyc1hESk1QVEpLMnFC?=
 =?utf-8?B?ZVc4SVpzNnRaNXlnNkZkWTd6WnZHV1h3UW5SNUtpWnFEZzIzdjg2Wk9pOFl0?=
 =?utf-8?B?dGVlQmZVKzc3dGU5blU1MXlab3NhS0xGVHVrVmxBS0V3dHZvZlpMS0lleHVY?=
 =?utf-8?B?MnRaVjJVcVV1K3BjR2kzZkkvTWlIMjI4QXRsaGVHYU5ib1BwaXpFK2VhVjhI?=
 =?utf-8?B?dmdDU3dXVDZGMGV1RjRqVno0WS9QV2VYeVJ1OXZJT3RhUlVZbXFyMTZ3Y1g3?=
 =?utf-8?B?cWduZVVscEpsU2VyYmNsb0hPbWZ3bkptUm5lSXZhZXV0VWRYWFZQWDM5S3Ex?=
 =?utf-8?B?UjFzRzJlOXljS1B3UVp5dzJHdk8waGdTMGdKUzJLWWJIajFkaWtJYkh3STFF?=
 =?utf-8?B?cWQ2MVVDMEFRMWdJSlVyeGo1aERhR3ZXNG0xa3diaEwxMVl6T1lCMjdiMlZV?=
 =?utf-8?B?SVlkTHQzcTgxTExqZzBHdTlQSVdiNmhERlFZeGFwMEIyV2lOVzN4dHV6KzJR?=
 =?utf-8?Q?YxeKmSbqjUIhAg5utO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d778ec9a-8cb6-4656-3a89-08df1a52307a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 15:40:41.6865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3gTh+sXZNbyDU666MVSYjJ2x1wk9qPwYpXhT+vas/D39w0pol/BkwFmW4qgjR/J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470
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

--------------8Zg4P4QWNqF0i0cnGjFyAHOy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-09-23 23:23, Zhu, Lingshan wrote:
> On 9/23/2026 10:13 PM, James Zhu wrote:
>>
>> On 2026-09-22 05:34, Zhu Lingshan wrote:
>>> This commit implements a device-wide PMC config
>>> for amdgpu, which including the profiling owner,
>>> and the profiling enablement indicator.
>> [JZ] I think it should be render-node wide, not device-wide
> Hi James,
>
> It could be, but we don't have a requirement document defines the scope.
>
> But normally a profiler is a device scope,
> I see KFD profiler operates on all queues under the device queue manager

[JZ] One device could be split into multiple nodes with different 
processes running.

I am wondering if this is really we want.  Ben may comment on it.

>
> Thanks
> Lingshan
>>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 8 ++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>>>   2 files changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 8eff6b9ebe81..45897dca802f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -620,6 +620,12 @@ enum amdgpu_enforce_isolation_mode {
>>>       AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
>>>   };
>>>   +struct amdgpu_pmc_profiler {
>>> +    struct mutex        lock;
>>> +    struct drm_file        *owner;
>>> +    bool            enable;
>>> +};
>>> +
>>>   struct amdgpu_device {
>>>       struct device            *dev;
>>>       struct pci_dev            *pdev;
>>> @@ -818,6 +824,8 @@ struct amdgpu_device {
>>>        */
>>>       struct xarray userq_doorbell_xa;
>>>   +    struct amdgpu_pmc_profiler    pmc_profiler;
>>> +
>>>       /* df */
>>>       struct amdgpu_df                df;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index c924a55fd16f..74ed42e53264 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -3673,6 +3673,7 @@ int amdgpu_device_init(struct amdgpu_device 
>>> *adev,
>>>       mutex_init(&adev->pm.stable_pstate_ctx_lock);
>>>       mutex_init(&adev->benchmark_mutex);
>>>       mutex_init(&adev->gfx.reset_sem_mutex);
>>> +    mutex_init(&adev->pmc_profiler.lock);
>>>         /* Associate locks with lockdep classes for ordering 
>>> validation */
>>>       amdgpu_lockdep_set_class(adev);
>>> @@ -4244,6 +4245,8 @@ void amdgpu_device_fini_sw(struct 
>>> amdgpu_device *adev)
>>>       kfree(adev->pci_state);
>>>       kfree(adev->pcie_reset_ctx.swds_pcistate);
>>>       kfree(adev->pcie_reset_ctx.swus_pcistate);
>>> +
>>> +    mutex_destroy(&adev->pmc_profiler.lock);
>>>   }
>>>     /**
--------------8Zg4P4QWNqF0i0cnGjFyAHOy
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-09-23 23:23, Zhu, Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:6394fa47-ec53-4e54-9cc9-bbd59b97f174@amd.com">
      
      <pre class="moz-cite-prefix">On 9/23/2026 10:13 PM, James Zhu wrote:
</pre>
      <blockquote type="cite" cite="mid:d3144b38-64a3-4bbe-910f-722912f9fc66@amd.com"> <br>
        On 2026-09-22 05:34, Zhu Lingshan wrote: <br>
        <blockquote type="cite">This commit implements a device-wide PMC
          config <br>
          for amdgpu, which including the profiling owner, <br>
          and the profiling enablement indicator. <br>
        </blockquote>
        [JZ] I think it should be render-node wide, not device-wide <br>
      </blockquote>
      <pre>Hi James,

It could be, but we don't have a requirement document defines the scope.

But normally a profiler is a device scope,
I see KFD profiler operates on all queues under the device queue manager</pre>
    </blockquote>
    <p>[JZ] One device could be split into multiple nodes with different
      processes running.</p>
    <p>I am wondering if this is really we want.&nbsp; Ben may comment on it.</p>
    <blockquote type="cite" cite="mid:6394fa47-ec53-4e54-9cc9-bbd59b97f174@amd.com">
      <pre>

Thanks
Lingshan </pre>
      <blockquote type="cite" cite="mid:d3144b38-64a3-4bbe-910f-722912f9fc66@amd.com">
        <blockquote type="cite"> <br>
          Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com" moz-do-not-send="true">&lt;lingshan.zhu@amd.com&gt;</a>
          <br>
          --- <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 8 ++++++++ <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++ <br>
          &nbsp; 2 files changed, 11 insertions(+) <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
          index 8eff6b9ebe81..45897dca802f 100644 <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
          @@ -620,6 +620,12 @@ enum amdgpu_enforce_isolation_mode { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3, <br>
          &nbsp; }; <br>
          &nbsp; +struct amdgpu_pmc_profiler { <br>
          +&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock; <br>
          +&nbsp;&nbsp;&nbsp; struct drm_file&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *owner; <br>
          +&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable; <br>
          +}; <br>
          + <br>
          &nbsp; struct amdgpu_device { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dev; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pdev; <br>
          @@ -818,6 +824,8 @@ struct amdgpu_device { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct xarray userq_doorbell_xa; <br>
          &nbsp; +&nbsp;&nbsp;&nbsp; struct amdgpu_pmc_profiler&nbsp;&nbsp;&nbsp; pmc_profiler; <br>
          + <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* df */ <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_df&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; df; <br>
          &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
          index c924a55fd16f..74ed42e53264 100644 <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
          @@ -3673,6 +3673,7 @@ int amdgpu_device_init(struct
          amdgpu_device *adev, <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;pm.stable_pstate_ctx_lock); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;benchmark_mutex); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;gfx.reset_sem_mutex); <br>
          +&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;pmc_profiler.lock); <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Associate locks with lockdep classes for ordering
          validation */ <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_lockdep_set_class(adev); <br>
          @@ -4244,6 +4245,8 @@ void amdgpu_device_fini_sw(struct
          amdgpu_device *adev) <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pci_state); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pcie_reset_ctx.swds_pcistate); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pcie_reset_ctx.swus_pcistate); <br>
          + <br>
          +&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;adev-&gt;pmc_profiler.lock); <br>
          &nbsp; } <br>
          &nbsp; &nbsp; /** <br>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------8Zg4P4QWNqF0i0cnGjFyAHOy--
