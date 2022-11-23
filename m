Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01113C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Nov 2022 01:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BC3310E4CB;
	Wed, 23 Nov 2022 01:45:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1343A10E4C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 01:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Flgq8cWoxskSnEIuB37K2zMlorcj8Vdk48GevcaDzj84skU9zXJEyuub0Z+rwlW/5AmzvMj4U+Bg6Lo2PZvMrHCSXmuZWTGjrk0yM4Dm2kUQzI4+1TKSYUR5TMmiUOX5t/1xlwmEpFlbsTPwT6kh1MeODzQBrzLCJYUX78C2HBk82hRWjIZC55+BJIdynT0lu34rPJ+CqQDrjOZtALOOR3EVpTlhNFOTd6Gxqe+Lzg08qmUC+JJJS80sUtZyzXNy2wx78bgnq5L//rWPqfwLtoSEA9sRwZ3kDzU6SMd/ahMcV0SFZqoIFhJ2bz0wJnMVMlo0tYc+vK9ugPKBIPQWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfG7D/q/TAgeCBUMoehbPZ0FbFtl9gPB7FXrJN349lM=;
 b=dePDI8m5gKF18uWUiw2IT5Ob1voNYkDRBlUDCVv1e4lVgoIMA+1lPm3Mbu+X7bNuQxQ1UPXziYtYnnZphnEr4lBGY4KgBdUt2UVdGlFJCcAWfFev0YjAZd3Ns5PF8zXJ7lasuzYaiB4ycC9X736JALj2uDs1vreFJH8O6UyqlmQPd+rMAGOKsW9CyOxqx6VHH+CXdCmzNpLFPyeo7ASFBbxTuG6Ll4e/UJILM9QB4Y1CZPXkuXjvKuE4VuWhPlkOxnD1qcq7QvxLqCb8xLHLjSYeqzO+yv7eNzgCB2765MIQzUf/b6scjatFQ8RJdXMr8EEXWrkunoYwLZy+nVKVbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfG7D/q/TAgeCBUMoehbPZ0FbFtl9gPB7FXrJN349lM=;
 b=3smQu9OjF0gHQGWUWKf7LGlZ/EmDJo2YLQwOe7kn8Yaq0NLdLEA+1q4FOD/o3Zw8emMfe04nalHsG7gVJPvlkoHkx+7DWHnnrnxQir9ZeW+fDWZ/E5emOxQdrKn6A3tc2Yy2pDds8YcSNNj40bBhLyRqZfJbfjDoPCjP/Q5y4Bc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 01:44:56 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 01:44:56 +0000
Message-ID: <b39574a3-47bd-e278-382e-390e7df82c08@amd.com>
Date: Tue, 22 Nov 2022 19:52:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 16/29] drm/amdkfd: add runtime enable operation
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-16-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221031162359.445805-16-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0059.namprd07.prod.outlook.com
 (2603:10b6:a03:60::36) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: b9773b1b-3d40-4907-ec75-08daccf4532b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XylVxbw4sbC+PlpKIKLStG4xtSgbPeizV1/gwKVle4rWsgjXOh4u5R1zHaf2Hn6nNZ45pRWG2jU9FKOjUPMP4I5ilLOBAju5IqD8ItX+AJD3VpV6zF/5s0rO/6OQCfWdf3WLBFo6PGaiThOcY0yLR5Y7qgtFTvb6+Okq4VxVUCsX/oAZ/Rr6/LZIw9PNAQU23psMiw44kO+AIwf2EJW0ty23pZtUS/ZveeZIkT9hHngrQQ+ni9erCHxpmBNbAAQK+beAQOpc8OpU/V4nDBVDFXtqWW+qhFRgp6yTmwKKQ/RjbcZqh6NdYC1f8G7lqHXG999+mo2uynhMsVCU6lxIlkcK2bDFZj2/KtJKAv3M0W+EmfNbIXANMA4ADrRzw6dkMebdqI4x4/2pOVqzA3JXqRPwc4PJTxkAlGQbwdjUrjGqlyztMJEb97v789hqV0uhIUedTHAnefxR84jguhc0YFYRecfim4vM0bRJXaZf4hMIgzS7O+dOAo/ct6VxxxfVdIQtO5G8QDjX3LoDH3frq3nZeZhtiUInazNMjorA/CpK4bhzb8zCGEbgkQS/O4xlmFrtzDzrMZB410Io3OIzqxRtdy6mwXcetXL49mKdRcLJK0nB+mjAMXfqhp3aCFepeLNnxhNZdeZs7lh1/KwLF7+NpgD6cddE37cOsg8yrJ6uReMM1Sw2mq37jvioZ8e6v70XaKO1lsqra9mJw7ZhcjrYvtW6ChwME7JlZ17gVajObI4+9an1xCUC4fQJDn+E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199015)(66946007)(83380400001)(36756003)(26005)(6512007)(66476007)(41300700001)(316002)(6506007)(2616005)(53546011)(66556008)(8676002)(6666004)(6486002)(44832011)(38100700002)(2906002)(186003)(478600001)(4001150100001)(5660300002)(8936002)(31686004)(31696002)(86362001)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXl3RjhNNXZ1dFlKMDJ5eDJPcUVGSTJzWDJFaE53MXZVdlNkS21rd2E0R3VM?=
 =?utf-8?B?MlEzY1hraVZ5bnVsYmJ2T1JVNytUVHVtWlVGN1J3V2c2VWI4U2V0Ti9rNTA2?=
 =?utf-8?B?SDNPUEtFMlJudHpncFpGSXNoU0NRdFBHRnlRK2dFQm1PeVAwQ3Q4aGJrK2ZX?=
 =?utf-8?B?YWF0bm1PY2c4N2JQd1UxTFk2QktQaHJhbmlBeFl3cFlBQkRoYkVaRFBwWnRp?=
 =?utf-8?B?bFJUSTc5Ymh2YWllcHNwdXM3L1hrWU5rdDk1dWRlQXplMGE1TEc2VTlrVyt2?=
 =?utf-8?B?QVhRa25MbEExSnQ4Z1dUN2J4eEVLaUkxcnhVYUJLRENJT1Q5V281cnNDTXhJ?=
 =?utf-8?B?YTc5RWR2U0VBdDVFbGl3SE4rUWRKNlpLNjR3YWJ2THYrV2UyR0RoOW9MS1Nu?=
 =?utf-8?B?SllnbG1SV1JabTZHM0crOXpYaFNqZkNsVWovWHZObGF2WDFwNmxBUDZLaWVu?=
 =?utf-8?B?N3k4VWxtYWxLUHdVQzBKeUJiNlRtMmZObkpLd3pOVXBsYkNQekFlY2tSTUVI?=
 =?utf-8?B?ekpORGtvejRJTUEyeXRRQXBkM2VDbU16NXRhc05EM2xIREJZQUlReGVOVE00?=
 =?utf-8?B?SmRDUzJQV2pRUjB5SXZxRnJKRXlTUElPVEJMYzFlVlpsa0hrY2hCTnNkcXZj?=
 =?utf-8?B?bU1KelRNWTAxR1dOdXJMYlpvT3N0dVpqcnpNV1B4NTU5c05tSG51UDhETzY4?=
 =?utf-8?B?QXBoZytwNlFWQXlYNlN0RkY2cXdNZnJVblVpRFVVTGdOWk5LVWF5S3Z1V0Fw?=
 =?utf-8?B?YWJ2MUEwM0tYTlo5aXN2RS91WjQzNUhGS3VUdGxZMlA5bGZLYUZ5Z2RQbG1h?=
 =?utf-8?B?eE95NzZzT2dFclVocHU4MmxzOVQ2K0hDaS9kZ09YUnhwdStIaDZYNkxIdFp5?=
 =?utf-8?B?aHJ6OCtoYVBvTjVhTkN2WTFxUUluVG9OZjh2QVliY2VjUk90NmFGdGJ1clVl?=
 =?utf-8?B?TDZwd25LR1NYQWdsR3dsbVRoR0M4cGtJRTB2MkdYNGdUc3RvbC9hcmRVQkpK?=
 =?utf-8?B?eVVWUWoyQlJDbmE3N2UxMjJNKzRTUHdZckd2Um1RdjYrQWw4NEJxckFYakRE?=
 =?utf-8?B?UXZKTy9aakZzcG85aUtmMC82Qk5mdTFUS1pyWW5oTWNHbDR0ZENEM0tOdmZV?=
 =?utf-8?B?MitTUHo3VHJFOUU2aExYTkVzeXM1S3NZSFlRWXZRejVUVzJ3WllLMW5tVnJY?=
 =?utf-8?B?QTY4aWxzOVNlZ2lKa245cmJKR1JOTFJzNUw0T3cvejhWZ0lka09HMzZmY1ZL?=
 =?utf-8?B?VXBhTlZUQ2pibTZiUmp1bFR5QUFWS0txUlR2U0RURFZCek14VlJpUUFTYUZs?=
 =?utf-8?B?bVFkNzNJNTlpVTJyMkQ1L3NHai9OYTh4YWt5K0tOa2V5R1psbXVBdEpyQXBH?=
 =?utf-8?B?Nnh2RXVpVEl3Q0xUZDRrUzhmQXNXZ0t0S2ZlRkNybjlEUzBZV3VZUUtzYzlz?=
 =?utf-8?B?aUxITVMxVDdvTUMxMEUzRFo3Q2FzdnFQU3Jqak1RS0VST1lUUi9WYVVOSE1Q?=
 =?utf-8?B?M2lCazdBczB0NVRWY0Y3SnJPdzJ6T25XUWNteUNjZmRzRUhNU1Z6dVZQZ1JI?=
 =?utf-8?B?L0RGcFZyUDM3Mi9SWU5oLzRpbHZMalVMTUFBclByWVEyU1VGTG80L2RBNVVu?=
 =?utf-8?B?cU5TaTh3Q2NLUzRLbXFZbmp5dFJNY3BCb3pDUFBpQWhtVE5TUXZ5VC84d0FT?=
 =?utf-8?B?N1JVd0ZKUTRNRmFzT21odHpsbkJzWGhBVEFpeVlic2Q5bEUxVkxPSXhOWEV5?=
 =?utf-8?B?VzJublZVc2g0QzhzL2tjamErd0JaRFU1VlI5Z3hIV1NROWVHTTB0V01EYnR0?=
 =?utf-8?B?cnRjZXVmbXJ4Z1pkUWdHNEVmOE9leTRMZGlxWEZYOG92R2FVWFF0ZmVZZnB1?=
 =?utf-8?B?d0JncjFFeXg5WnNYWjJ2cjh1d1pkV0k4NzZYd0RoWkJmVTZ6ejFIVzBRZkF0?=
 =?utf-8?B?c2NTbithUGszSUVTeWo5MU54aXNPWktGNG5va3UyVWdkWGtmWjZyMHY4ZzZS?=
 =?utf-8?B?M25hUmgzZFRYdkxBNlFiN0ZWR0tLSVhrQWw2ZnROTDFYVmdzOEFhK1V5T3ov?=
 =?utf-8?B?aHJwK25MQWtXMUVFS2NjZHM4UHBwNnZmaVpiS3p1VU1obU1xdm84OXhXU0xQ?=
 =?utf-8?Q?FzS+Y26cveSnKdj3nyQrIndrq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9773b1b-3d40-4907-ec75-08daccf4532b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 01:44:56.7069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mk8WvmDKHOJl9559RrOvBBXOPJy2RtXpewnoohS3yK25gvCiS4hXG4kFcmUr6O4Ckh82AHEOuasmREn92rh3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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


On 2022-10-31 12:23, Jonathan Kim wrote:
> This operation coordinates the debugger with the target HSA runtime
> process.
>
> The main motive for this coordination is due to CP performance overhead

I wouldn't call that the main motivation. The main motivation for 
synchronizing runtime enable with the debugger is allowing two different 
use cases:

  * Attaching the debugger to a running process (when the runtime is
    already initialized)
  * Attaching the debugger on process creation and waiting for runtime
    initialization so that all queue creations can be intercepted.

That just happens a good place to enable ttmps as well.

Regards,
   Felix


> when enabling trap temporaries via SPI_GDBG_PER_VMID_CNTL.Trap_en.
> This overhead is unacceptable for microbench performance in normal mode
> for certain customers.
>
> ROCr allows the user to bypass trap temporary setup through the
> HSA_ENABLE_DEBUG environment variable.  As a result, the debugger has
> to consider two scenarios.
>
> For the first scenario, if the runtime enable of the target has already
> occurred prior to the debugger attaching, then the debugger will go ahead
> and setup the trap temporaries whether runtime has requested them or not.
> The debugger will be able to query the runtime status on attach.
>
> For the second scenario where the debugger spawns the target process,
> it will have to wait for ROCr's runtime enable request from the target.
> The runtime enable request will be able to see that it's process has been
> debug attached.  It then enables the trap temporaries since it now
> knows it's in debug mode, raises an EC_PROCESS_RUNTIME signal to the
> debugger then waits for the debugger's response. Once the debugger has
> received the runtime signal, it will wake the target process.
>
> In addition there is an additional restriction that is required to be
> enforced with runtime enable and HW debug mode setting.
> The debugger must first ensure that HW debug mode has been enabled
> before permitting HW debug mode operations.
>
> With single process debug devices, allowing the debugger to set debug
> HW modes prior to trap activation means that debug HW mode setting can
> occur before the KFD has reserved the debug VMID (0xf) from the hardware
> scheduler's VMID allocation resource pool.  This can result in the
> hardware scheduler assigning VMID 0xf to a non-debugged process and
> having that process inherit debug HW mode settings intended for the
> debugged target process instead, which is both incorrect and potentially
> fatal for normal mode operation.
>
> With multi process debug devices, allowing the debugger to set debug
> HW modes prior to trap activation means that non-debugged processes
> migrating to a new VMID could inherit unintended debug settings.
>
> All debug operations that touch HW settings must require trap activation
> where trap activation is triggered by both debug attach and runtime
> enablement (target has KFD opened and is ready to dispatch work).
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 144 ++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c   |   4 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |   2 +
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |   1 +
>   4 files changed, 148 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 4b4c4200d8fb..27cd5af72521 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2655,11 +2655,141 @@ static int kfd_ioctl_criu(struct file *filep, struct kfd_process *p, void *data)
>   	return ret;
>   }
>   
> -static int kfd_ioctl_runtime_enable(struct file *filep, struct kfd_process *p, void *data)
> +static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
> +			bool enable_ttmp_setup)
>   {
> +	int i = 0, ret = 0;
> +
> +	if (p->is_runtime_retry)
> +		goto retry;
> +
> +	if (p->runtime_info.runtime_state != DEBUG_RUNTIME_STATE_DISABLED)
> +		return -EBUSY;
> +
> +	for (i = 0; i < p->n_pdds; i++) {
> +		struct kfd_process_device *pdd = p->pdds[i];
> +
> +		if (pdd->qpd.queue_count)
> +			return -EEXIST;
> +	}
> +
> +	p->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;
> +	p->runtime_info.r_debug = r_debug;
> +	p->runtime_info.ttmp_setup = enable_ttmp_setup;
> +
> +	if (p->runtime_info.ttmp_setup) {
> +		for (i = 0; i < p->n_pdds; i++) {
> +			struct kfd_process_device *pdd = p->pdds[i];
> +
> +			if (!kfd_dbg_is_rlc_restore_supported(pdd->dev)) {
> +				amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
> +				pdd->dev->kfd2kgd->enable_debug_trap(
> +						pdd->dev->adev,
> +						true,
> +						pdd->dev->vm_info.last_vmid_kfd);
> +			}
> +
> +			if (kfd_dbg_is_per_vmid_supported(pdd->dev)) {
> +				pdd->spi_dbg_override = pdd->dev->kfd2kgd->enable_debug_trap(
> +						pdd->dev->adev,
> +						false,
> +						pdd->dev->vm_info.last_vmid_kfd);
> +
> +				debug_refresh_runlist(pdd->dev->dqm);
> +			}
> +		}
> +	}
> +
> +retry:
> +	if (p->debug_trap_enabled) {
> +		if (!p->is_runtime_retry) {
> +			kfd_dbg_trap_activate(p);
> +			kfd_dbg_ev_raise(KFD_EC_MASK(EC_PROCESS_RUNTIME),
> +					p, NULL, 0, false, NULL, 0);
> +		}
> +
> +		mutex_unlock(&p->mutex);
> +		ret = down_interruptible(&p->runtime_enable_sema);
> +		mutex_lock(&p->mutex);
> +
> +		p->is_runtime_retry = !!ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int runtime_disable(struct kfd_process *p)
> +{
> +	int i = 0, ret;
> +	bool was_enabled = p->runtime_info.runtime_state == DEBUG_RUNTIME_STATE_ENABLED;
> +
> +	p->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_DISABLED;
> +	p->runtime_info.r_debug = 0;
> +
> +	if (p->debug_trap_enabled) {
> +		if (was_enabled)
> +			kfd_dbg_trap_deactivate(p, false, 0);
> +
> +		if (!p->is_runtime_retry)
> +			kfd_dbg_ev_raise(KFD_EC_MASK(EC_PROCESS_RUNTIME),
> +					p, NULL, 0, false, NULL, 0);
> +
> +		mutex_unlock(&p->mutex);
> +		ret = down_interruptible(&p->runtime_enable_sema);
> +		mutex_lock(&p->mutex);
> +
> +		p->is_runtime_retry = !!ret;
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (was_enabled && p->runtime_info.ttmp_setup) {
> +		for (i = 0; i < p->n_pdds; i++) {
> +			struct kfd_process_device *pdd = p->pdds[i];
> +
> +			if (!kfd_dbg_is_rlc_restore_supported(pdd->dev))
> +				amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
> +		}
> +	}
> +
> +	p->runtime_info.ttmp_setup = false;
> +
> +	/* disable DISPATCH_PTR save */
> +	for (i = 0; i < p->n_pdds; i++) {
> +		struct kfd_process_device *pdd = p->pdds[i];
> +
> +		if (kfd_dbg_is_per_vmid_supported(pdd->dev)) {
> +			pdd->spi_dbg_override =
> +					pdd->dev->kfd2kgd->disable_debug_trap(
> +					pdd->dev->adev,
> +					false,
> +					pdd->dev->vm_info.last_vmid_kfd);
> +
> +			debug_refresh_runlist(pdd->dev->dqm);
> +		}
> +	}
> +
>   	return 0;
>   }
>   
> +static int kfd_ioctl_runtime_enable(struct file *filep, struct kfd_process *p, void *data)
> +{
> +	struct kfd_ioctl_runtime_enable_args *args = data;
> +	int r;
> +
> +	mutex_lock(&p->mutex);
> +
> +	if (args->mode_mask & KFD_RUNTIME_ENABLE_MODE_ENABLE_MASK)
> +		r = runtime_enable(p, args->r_debug,
> +				!!(args->mode_mask & KFD_RUNTIME_ENABLE_MODE_TTMP_SAVE_MASK));
> +	else
> +		r = runtime_disable(p);
> +
> +	mutex_unlock(&p->mutex);
> +
> +	return r;
> +}
> +
>   static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, void *data)
>   {
>   	struct kfd_ioctl_dbg_trap_args *args = data;
> @@ -2721,6 +2851,18 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   		goto unlock_out;
>   	}
>   
> +	if (target->runtime_info.runtime_state != DEBUG_RUNTIME_STATE_ENABLED &&
> +			(args->op == KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_OVERRIDE ||
> +			 args->op == KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE ||
> +			 args->op == KFD_IOC_DBG_TRAP_SUSPEND_QUEUES ||
> +			 args->op == KFD_IOC_DBG_TRAP_RESUME_QUEUES ||
> +			 args->op == KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH ||
> +			 args->op == KFD_IOC_DBG_TRAP_CLEAR_NODE_ADDRESS_WATCH ||
> +			 args->op == KFD_IOC_DBG_TRAP_SET_FLAGS)) {
> +		r = -EPERM;
> +		goto unlock_out;
> +	}
> +
>   	switch (args->op) {
>   	case KFD_IOC_DBG_TRAP_ENABLE:
>   		if (target != p)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 87a23b1d4d49..ae6e701a2656 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -176,7 +176,7 @@ int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
>    *				to unwind
>    *		else: ignored
>    */
> -static void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind_count)
> +void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind_count)
>   {
>   	int i, count = 0;
>   
> @@ -238,7 +238,7 @@ int kfd_dbg_trap_disable(struct kfd_process *target)
>   	return 0;
>   }
>   
> -static int kfd_dbg_trap_activate(struct kfd_process *target)
> +int kfd_dbg_trap_activate(struct kfd_process *target)
>   {
>   	int i, r = 0, unwind_count = 0;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index 8aa52cc3af17..e31c9bb0e848 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -28,6 +28,8 @@
>   void kgd_gfx_v9_set_wave_launch_stall(struct amdgpu_device *adev,
>   					uint32_t vmid,
>   					bool stall);
> +void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind_count);
> +int kfd_dbg_trap_activate(struct kfd_process *target);
>   bool kfd_dbg_ev_raise(uint64_t event_mask,
>   			struct kfd_process *process, struct kfd_dev *dev,
>   			unsigned int source_id, bool use_worker,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index b69f2f94a50e..9690a2adb9ed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -943,6 +943,7 @@ struct kfd_process {
>   
>   	/* Tracks runtime enable status */
>   	struct semaphore runtime_enable_sema;
> +	bool is_runtime_retry;
>   	struct kfd_runtime_info runtime_info;
>   
>   };
