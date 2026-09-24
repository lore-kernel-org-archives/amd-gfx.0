Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EBAC9830D
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 03:24:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9137510F29B;
	Thu, 24 Sep 2026 03:24:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dwsm/wxt";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011000.outbound.protection.outlook.com
 [40.93.194.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ACE310F29B
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 03:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3JBD/wAtR3RWZBChpdkO2mkh2tqJRPUHa0fLJ9vUXAPQsXd+zlVtxUWmb7HaHf2otjQO9SW0GrUaGsESYoGSaBgtJ9kGAJ99xHOg9e8X4bqQpkTa7VfxYf3edlkhi7/9FHkQDtDeG6LvAoMLgzo6kt/gTJs6M07yCzihOsh58QauzwTNACe0ksGjWQjWG+UM14OsVVs4QUTqnV2beawXoJlgSIKnUvlSf9oDEUn5hE16DItdBL49BWnY4OgkKJAdxKV1JPL7iftAybSeIoasY8+84aWVMCg2u17j9AfDrEpuyQICNAfcSSUWFCltj7JA7t96k4DxU3woV/1avgAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0zOku2J8ks8AjFgN5P1Nd9tlB6nHDwq/dQKTFu0pF4=;
 b=mBIs7ezM0pWjoxOGh+wUxOPCxNvHsbSYMINbJujbydoxMm0WjGALqI0Z3Kn7/M3y7eTQwwCQDMjowgTj7om6FCwHpwA6fjH52HE58dWhomSY4cmrXba/0ASmU3Hytkac/3stWtMDpKFi7PrVbXree/S3lthuh0gDAqlp5MDUZTp8vHQaS1t83ZHCz+GI6pFjGeiyY2rKsTE1Aje6/Uyz1MoiK8jF7eqvgtTmRLsCDwU66Ha+ozZzcTEN++lAYi/EidfuMFulKgYTQuW4KDbjmgV2AEJ9O7W4nCcEc/yKEs8zrVwRblEbXrV06E9sK9jWKZ/8nKjRk5JbntVX9daIYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0zOku2J8ks8AjFgN5P1Nd9tlB6nHDwq/dQKTFu0pF4=;
 b=dwsm/wxtjaeAnQNmI0BPl5ew+4IY6xDzXIYRPge/pDZrCN2IbpeEmXzJ2BHX54HYb0SwstpGQFn3ugHMmbTGVWmA54lnP0JxvCdYfthOjKtasSClcI35DNrrISrVkgJd60f0D7R1U2gQ1kO+CFvYJeUMx5MEJkmhdw/sUvRy07w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) by
 DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.18; Thu, 24 Sep 2026 03:24:25 +0000
Received: from DS7PR12MB9475.namprd12.prod.outlook.com
 ([fe80::4371:c924:8800:2587]) by DS7PR12MB9475.namprd12.prod.outlook.com
 ([fe80::4371:c924:8800:2587%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 03:24:25 +0000
Content-Type: multipart/alternative;
 boundary="------------FR7RSvCRZyP4lp7F341okSqQ"
Message-ID: <6394fa47-ec53-4e54-9cc9-bbd59b97f174@amd.com>
Date: Thu, 24 Sep 2026 11:23:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 02/10] drm/amdgpu: add device-wide PMC config
To: James Zhu <jamesz@amd.com>, Alexander.Deucher@amd.com,
 felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
 <20260922093436.596947-3-lingshan.zhu@amd.com>
 <d3144b38-64a3-4bbe-910f-722912f9fc66@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <d3144b38-64a3-4bbe-910f-722912f9fc66@amd.com>
X-ClientProxiedBy: JH0PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5d::8) To IA1PR12MB9465.namprd12.prod.outlook.com
 (2603:10b6:208:593::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9475:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: ae647b29-a2ee-447e-60d3-08df19eb54b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|4143699003|10067099003|11063799006|56012099006|8096899003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JgBXbbZsaIBvTMANPOzlmVw53yVfboYM71r8YxQ3HXSCgU83g6j+5uAKCnfaotVtGCIBc9HDFOOhiCrLcFXuQuAiHT9cEnEX5DJ0/agiVaM1phg0mek5avaH+cxxsw51sQW3Bi7r1Wj00+XiWWksUGz5BJGiQyDLt+SkZp+Pet6re5ZlxFeDKRFQhbMse/9LWENcMuS+Feb4Dv2jZjNx9hmOo9ZYwHt0+6iaByjoL33FPEjcKUAX4xpdUF56UCAJUnXzUMm9u5BalAyWhsUNxFMa5F14FMaTFQ70ayMYYX89mC/s62awvvjoTiBsrVAuqjZhaR/SuXstdA2K4BgzY/+4HY7N8BHK0tDRjH/4G3gCKS5BNbhxhLfqEkpthmgD9pxLwn/hrFm74AuVYmVksgvKfvZKt1zHtyhcYLnmCEaaUYS8yteckbMgTZWbZ80dU/4sYkW0pcQppXDMTGdVlvHhWU2qApc9S9+tDPCzqKa8eKsxooUg/8q3YBhimydhOrgsONlrrJg7qWD8dPWkkTbR46f1GW2LwE1tobZFr5d8nOc3lN/mIvStQUEJNIzqARXsDuegQcdpqGxBAm44XGhfWx9UUa69ZxH/p+NhjpjLUyvsEAiGx2ABa4qO7bwFCI7nditBsB1FPc1LjYNVx5FDOwmCdVZZgViKV8rSy9c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB9475.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(10067099003)(11063799006)(56012099006)(8096899003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjBDTXlkR2F0NTdxYjA3UllFTk9DYWpVTmk3Q0lFc2g5dVNmdG45a3k4NzZL?=
 =?utf-8?B?THFnYk55RFYvNVhNb0RhYWIzNjZuNWtDU0wyU3lLWjB4NjYzUTF3K1QwWmRC?=
 =?utf-8?B?TUxDbVcyb3JLRzh5NTNaRkhzQU96Q3pucm9pQ3ZvblRBWHFCTk40QmxoVlQw?=
 =?utf-8?B?aC9vVDFyOVNtSk5ieTZoOWpnaVFaZkpDYUppeTFnQ3d0V0M2dkZmaEJFQlNW?=
 =?utf-8?B?bFBNcVBIREV1RFQxTXkwV2hXZDRPN0xtRzlGVkhJV3IweThabVZDcHdncE8z?=
 =?utf-8?B?dm1NVkJwN2dMUktsSzVHMTV3OFNtWXhpNmh5UlFtRGNEcnFWZjU3d3g3ckNF?=
 =?utf-8?B?TUtRZEdLNXNBeE5FK3Z3YmEwNXNmWFBCU3o0d290RERSQ0NMcVRYUm1PTDZB?=
 =?utf-8?B?N3FUV2RRclYrT0d5NmVwL0g3QmVrVXJVc3NacUw1RGJRcmR1Q1dVRmJ4S1E0?=
 =?utf-8?B?bHBzSXZZbnFWOTR4WVBsdHV4Njh3Y2I2NFZibmFnUEN2S1I0d1RYTEREaXkr?=
 =?utf-8?B?UWN1dlp4eXFBOVoxblVUcTRTNkVnVkFrNmRMZk5tN0E2RXRPK3g1eVB2OWtv?=
 =?utf-8?B?UEVTckxjUGMyNmZjOXZjUllaMGtOdHZMcGptdFRPTyt6L29OK2Z1ZDJ6OU5T?=
 =?utf-8?B?QjRSTTVab3BCTEpPRjBSc3RtWGlVSDdLYTRQdGFwNUo3eURhQ1JNbEx3SWFC?=
 =?utf-8?B?QXROLzlMdHZkaE1Yam5pdDlNL284ZmRsb3AyVVQ1a2wzRmdwZFNnc3N4cGts?=
 =?utf-8?B?Tk44YzZsZml5c09xNEdTMDhsMVhqWmVvNWorZkZWdkRLSkNlQVM4UFFmSXZW?=
 =?utf-8?B?U2V4NlE5Ukx4YTIweXkyalYvRm5DM2c5OGplb2lXekFCeVFVeUxObEViVStJ?=
 =?utf-8?B?K2JjTVkvUk9OK0taQis0VUxQbk41OWpoSlY1TUNnenloUFYvaXl3NUhtN0hs?=
 =?utf-8?B?bWxqcnZpVzNDU0RrOCtKaWp4TVlQcWl1a3JhTWxEbk8wcXlqRGNrYVkyRmJN?=
 =?utf-8?B?Wk1iOVlkeS9UQnE0YitRUUIzcm5uTVFCSXV5Ui9pL0t2NlEwZS9sZU9aN241?=
 =?utf-8?B?eEZacHJZc09QanMzNXFsLyt3bmN2Z0F5aitnU0t5RzVpRkx2Y0ljMHZqK3U4?=
 =?utf-8?B?eHkwL082VU8yVjBzTmNuSVlqbEpCSWFsbjlJSlVQeVR3ZTk2YlhoSExnTmhR?=
 =?utf-8?B?NlpMcWptdG4vcG1RcXQ0cU84WDhLYmxNN2NxNDdScE9VaHNKb2tiSUJ0Q1hT?=
 =?utf-8?B?NXlmQm0rRUhnY2NSZmU4cjdHaStnVjc4bzFnZU9TNCtFeGNSRkJxclpWUVox?=
 =?utf-8?B?R01tY0swSXhRamU2eFJrd2NKZXU0Nk9oZit5NFRVWXpkdHhObk9PaGNqT2d3?=
 =?utf-8?B?R2pnYTN4YVJnRG5MOGlRdENwYzBjaXo3RDF5WlBpZE1TdkRZK2JrQ3h1eERr?=
 =?utf-8?B?M1I5VlQ3VWVpdjNkSng0S0FjMnlkaElMZ1RqSzdURlB4aC9yT0hBM1NocUg5?=
 =?utf-8?B?WWFDMmdYQXR0UFRqK01DMUMrc3BUdGdEL2piNFV0Q1M0RW00MFNRU0U2UVNM?=
 =?utf-8?B?QmFPaUprWk02bFQySnlqWnp0QytTZGtDWktPVlp5enRjdkVoUEtSeTJCRkV5?=
 =?utf-8?B?RlNjZ0c5RDZrbE9ndEw2QW1PNGtLR1ByN09mU1V2Y20wSnVjbzZvRWRWYVdo?=
 =?utf-8?B?ZHkxdEpWQnQ2TXlDdU9BU3VJdDZZNHA3bG5ueS9hdXpEeXUzdlBBc3dHZ01x?=
 =?utf-8?B?K1RJaHJzVyt2cHAwUFhaS25meGcxRUtXWWd1S2xDVEQzeXNhRDBRSG11T1Bw?=
 =?utf-8?B?UjVwTkFneTJJKzRoVVFVcmgvb0ZtOWRpbElYSWM4N092L1hIcHhWWGJnVDFp?=
 =?utf-8?B?YVBPd3V5bEZyWnROUksyTWsrWGdKR0xrclA0RzVZOUdvUUMzZDh5UXZOWkRU?=
 =?utf-8?B?ZjNYM1hNZmxVSUdidWZBTDBnUDJnUGVxcTk0eEpIb1BzSm1qektHME1UakYz?=
 =?utf-8?B?ZjBmOTUzVW9BV1Fkc2NWRHExbVQ1UmV3REpPSGk5VTYyZ0xKZ1dwSEtDUW9D?=
 =?utf-8?B?aWJYMXhVWWxPc1gwQkZCcGRBTTN4Y2pPamU5akY4dk5LcnBJSzY5V0FVc0Rl?=
 =?utf-8?B?cnFhS1JONnlNcm9EdW9wSnNidFIrSDcrMUU0M1JhdkxQMHgybE55QngrZG1M?=
 =?utf-8?B?SGIwUFFMOURpTmlRK1NiWlo3UTI3TXl0VzdCWlprN3c1OWZKYUF4V1hsaXZJ?=
 =?utf-8?B?ZXJ4ZE9mSE5uZEdrcXREY3VOUkowb1o2Y2xSMGdURzZqaER3cG92ZzlwSGhX?=
 =?utf-8?Q?nk2a+9Lf6JIhScX0Ga?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae647b29-a2ee-447e-60d3-08df19eb54b8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 03:24:24.9958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyJEAau5RfvoSxd6ptqUgqKkKM/1+4lHDCkbc4imfXr42rGkuowEZGQz8nVHZV/Kp1ZeE99WTwzMRUwRaTjK8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
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

--------------FR7RSvCRZyP4lp7F341okSqQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/23/2026 10:13 PM, James Zhu wrote:

>
> On 2026-09-22 05:34, Zhu Lingshan wrote:
>> This commit implements a device-wide PMC config
>> for amdgpu, which including the profiling owner,
>> and the profiling enablement indicator.
> [JZ] I think it should be render-node wide, not device-wide

Hi James,

It could be, but we don't have a requirement document defines the scope.

But normally a profiler is a device scope,
I see KFD profiler operates on all queues under the device queue manager

Thanks
Lingshan 

>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 8 ++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 8eff6b9ebe81..45897dca802f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -620,6 +620,12 @@ enum amdgpu_enforce_isolation_mode {
>>       AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
>>   };
>>   +struct amdgpu_pmc_profiler {
>> +    struct mutex        lock;
>> +    struct drm_file        *owner;
>> +    bool            enable;
>> +};
>> +
>>   struct amdgpu_device {
>>       struct device            *dev;
>>       struct pci_dev            *pdev;
>> @@ -818,6 +824,8 @@ struct amdgpu_device {
>>        */
>>       struct xarray userq_doorbell_xa;
>>   +    struct amdgpu_pmc_profiler    pmc_profiler;
>> +
>>       /* df */
>>       struct amdgpu_df                df;
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index c924a55fd16f..74ed42e53264 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3673,6 +3673,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>       mutex_init(&adev->pm.stable_pstate_ctx_lock);
>>       mutex_init(&adev->benchmark_mutex);
>>       mutex_init(&adev->gfx.reset_sem_mutex);
>> +    mutex_init(&adev->pmc_profiler.lock);
>>         /* Associate locks with lockdep classes for ordering
>> validation */
>>       amdgpu_lockdep_set_class(adev);
>> @@ -4244,6 +4245,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device
>> *adev)
>>       kfree(adev->pci_state);
>>       kfree(adev->pcie_reset_ctx.swds_pcistate);
>>       kfree(adev->pcie_reset_ctx.swus_pcistate);
>> +
>> +    mutex_destroy(&adev->pmc_profiler.lock);
>>   }
>>     /**
--------------FR7RSvCRZyP4lp7F341okSqQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre class="moz-cite-prefix">On 9/23/2026 10:13 PM, James Zhu wrote:
</pre>
    <blockquote type="cite" cite="mid:d3144b38-64a3-4bbe-910f-722912f9fc66@amd.com">
      <br>
      On 2026-09-22 05:34, Zhu Lingshan wrote:
      <br>
      <blockquote type="cite">This commit implements a device-wide PMC
        config
        <br>
        for amdgpu, which including the profiling owner,
        <br>
        and the profiling enablement indicator.
        <br>
      </blockquote>
      [JZ] I think it should be render-node wide, not device-wide
      <br>
    </blockquote>
    <pre>Hi James,

It could be, but we don't have a requirement document defines the scope.

But normally a profiler is a device scope,
I see KFD profiler operates on all queues under the device queue manager

Thanks
Lingshan </pre>
    <blockquote type="cite" cite="mid:d3144b38-64a3-4bbe-910f-722912f9fc66@amd.com">
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
  </body>
</html>

--------------FR7RSvCRZyP4lp7F341okSqQ--
