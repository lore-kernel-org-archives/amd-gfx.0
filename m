Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AFCCD5BB1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 20:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF8A10E1FD;
	Tue, 26 May 2026 20:24:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sPW0AXIi";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8598910E1FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 20:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRyUx0U+OIY8JWHZVrLDqk3s+mZ+qtqhcC/pH2F2chzHolIzdosMB8DoUuIIcOmc5w+2n111TMHIlQU9QkyWmgO23AH3HpLrQCC22eeZyjeKqPbgRyhLWQCnRM9ow1A3Zf84/OOEpZlVHiULOvyMB+jStJLVZKIduHXicKxiq91GB4RvK+F2HvbBCbR9WDjhyrylQ6mSAfKeCH1D0zi2uBhGZ+34bEX+F0YUte/ea4yFqaVxS7sNnY+N2p41/NGCOwooTgGtNtT8e+gx1dfL9RREYLyN22Mk7OGp0r3u2ICgvDHCB4CLoUMMtTESKFZqJKczqvr8UEOJ51ei2x+JSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQBUkT17ZKMjZ4xjQSetNm5gFiN3w7UfIgiorJns2DM=;
 b=Bf/Pvs964BZb3VQdakCo5+I9/82nvKx7Ql5OHBU44h4IYDiBeV0NwSzUqr0/q7tQR3CC0F/aHVqMLTReVSuZTpR1oG759dqD6nJrwIHl1RQ1q4UZYpG71oXlCYuEQ8njJ+7DjxjB0mqbnqRcb/UMDjYqujmEB3nqC21SwVyloyM6/y8a8Q5SPSHNtD+wa55nr/C3tnj1Rxlp6D1hMB+HTq2duhxPF5n49s1rdOZOOswy4f1hWOi89pw1Yr1TI+e0zmgml3kcFbXCiFwQr3YOVm9cMOponC1VQ7Pbn8gL52WtRiaLhv1eqGuPxvy8/Y4/CGwX+lY5rjUlTUMqu5e8uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQBUkT17ZKMjZ4xjQSetNm5gFiN3w7UfIgiorJns2DM=;
 b=sPW0AXIimcsDBwgldO+l4jl2REbFEfSxmGhp7ZDVrnQsvCv+hnTuw+FhVQWdBW/7bXrsHcf7f3ec3DBrqrWfWzITH9inclmP+7VhLPx7ugKCBgUzkuoGH09li0HkW83vqMBBed7WfzMvW7ouHgVxzWV4hfj4zFrxYyGmOY2VCMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Tue, 26 May
 2026 20:23:56 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2%5]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 20:23:55 +0000
Message-ID: <afccd40e-b860-4a5b-89dd-b72e008f6215@amd.com>
Date: Tue, 26 May 2026 16:23:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/42] drm/amdkfd: always resume_all after suspend_all
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, sunil.khatri@amd.com, Jesse.Zhang@amd.com,
 Shaoyun.Liu@amd.com
References: <20260522002048.98506-1-alexander.deucher@amd.com>
 <20260522002048.98506-2-alexander.deucher@amd.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <20260522002048.98506-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0089.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::26) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|SN7PR12MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: dba21c12-68c0-4000-c344-08debb64b5d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: vuzbabRNnrs6rtzO5gu1atuBBVBPvqnx1g6mqIBe8CWZEP0WiXFJHoTr7NOAdMDp/6JuAqcPJ+cFFa/SMxD2JIzD3YNWzF9Jh2/r4BVomQqDLcYaIth9SDwx5Y0HimvxRr7/FOucY0A1m7fzLiT1POsDqznW8wDFmU6sGYwUb+2wNNI1EcFuYnNXxL/aUmTSMY4sZA9ZiKpdGJo+ibUqSrEfks73h83JQ2bgGVp+PKQDVEYF4v4NkeeP54BT891hDj6VW0SSauoNNxCvgpzCFDUB+szCcx9/4GNGSZzwk2UJUPJwqL46/JWjOmrGgkCB3NyBeIc5D9S7URpRNoUXWf96VA8PlRo30ytG3gSr3R7Ps9AHd0alOzl5GzQDjFe1pVrcWn1K8k3tu+oqux2lQY+DK0+sjEEpaYLnBCXwhDhpoxZ/oJW+ZuE7lfiP8390fAO9u30RRDo5KqWAekz+5ookVVjEfABSvbPuFYQlNqorQLQ+VUwxjWwuWSLnAi5iM8HpftG7VPGb4Kz4xn65CRPEVYNY5E8Sy/GdU+USerjbaXS8HLpBPGEw9I07vuz+CJmaPrAJCZuEVnNLO1TWT2UncFzT1TMJqoFE5E08DW7SznWmlMn/GKKloOEVQxidstnjg9DC1cQk7jO6MWGzdNgG9LcDpy/ljogpsQImUxUKdXz//I/ThHWmM6FbGNxy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2daczJ6OXp2YWp4RHphRFJ1UTdCaUltZytHcDFyaytua0xLbUNyVEFuTlNm?=
 =?utf-8?B?aTZheDhlNDM2V2Ira1BGY0x6VDE1RUppS1haOTk2bFdNRTVTbXI2RmxaUWRR?=
 =?utf-8?B?TFg3WHV5M2Q2S2VkaUoxV0FFSURwdVdOY2s5WkNEWGtTMHdjSlBQeURTL21R?=
 =?utf-8?B?Q2oxd1NHU1JpcitEcjBKQU9tbXI2cDlYU29vQy9IQVI1RGJ2K1poZGduSTJZ?=
 =?utf-8?B?WHMwMVJ4Ujd0VmcwVzZuT2gvb0NrUjI3R1lSbk5FUlNCNGliSU9GMTZRdDB4?=
 =?utf-8?B?ZWFLWHZENXFIdHRjR04ydzh6Ri81MlljNE95UXdROU1MNlYzTTdId3RPTlRI?=
 =?utf-8?B?OTJuMFU1RTFxSTVZQmFESnNjSFhqUmxSY09oTzhQREdQc2lyYk82K0wzbHRm?=
 =?utf-8?B?WDRNdFBpR1c0SG9MZ1FxQ2EvazU5bzJRSzhleWcwYW5JUlJteWJpb2FpNkJN?=
 =?utf-8?B?d2tXSm9kdVFNWGdDcGR1c3IyeVhMaFdtLzM2d0JEbThiSnZDdDNPM3FiaWJs?=
 =?utf-8?B?MW5xU2I2VFZ4WFlRR2hLeDR2THhFcFR0ZXZ3dVBKejk4dVhEYUxsMjJ4azVF?=
 =?utf-8?B?L25oWjl3QVdJR29UcVZWMlQwRlBacG9xc2RDbmUvays3UkFDMVlCY3VCVThH?=
 =?utf-8?B?U2VaU3I5VU1kWGJwS3FBN04xSkNKbTlXQ1NXYy9qSGtFcTdrT2lVbzFYNGE1?=
 =?utf-8?B?MWE2c2M3c3VienVwTFRzWVRLMEswWi95ZVFQUGt0UTBPbUxyaUxUNS9rQUlo?=
 =?utf-8?B?ay9GdWVHR0FaNWFzWHFDbHBoL1lzVUhJOHMzMTM5b20xY3ZNVkZsYmlnc1Aw?=
 =?utf-8?B?RHo0V0FjT3RHTWNNamFJUHE5czZxOVpac0prL2RzZE9qUjZmTUlRR1RsUTBk?=
 =?utf-8?B?dy9HM1d3bU5vS012dHNwQzRiZ0o3R21xVytnSG82eU56WnZBbmpTeUZEWDBH?=
 =?utf-8?B?RmpFQ1F4TTVwNHpUZmtpN0ZNRDVFd2VPU0syWGJoMGJmUjNwb0dteTRIMlhz?=
 =?utf-8?B?QjIvTGE4azF5bFB0VVlNQWZSTWNxMWFjR24yWllvSlB5RzNQMStOcFA4N285?=
 =?utf-8?B?YnF0bGVOK3JpSFB5SDRVQzNTVHU1RFhaOUlCcCt5VTBpd2NHVlQ1aHdCZWlm?=
 =?utf-8?B?K0NQU0toVS9PU2MzN0VDSXdlK1NReEVLZDBicnpEbnQwT25WSTladW92TEZl?=
 =?utf-8?B?Z0F2WnRtejZ4Vm9pYWhxcVRxQjhjYUJXbDBYcU5aSUlydHN0L1NjKytwTXEx?=
 =?utf-8?B?YjBTVUR1QWk3Y3dLZ0Ezc2hib0FCYlJtTHFLdWVjdDczbGk3aFBoZG5paUhw?=
 =?utf-8?B?WW00a0JXTlMrM3FzUEY1UmVXR1lDamE4emFqOXRxZmpaUzdVM3djQkNKdHZk?=
 =?utf-8?B?dnBVMjR0NWI4Y3liS1pWVnlMVGpNUTFQejg1NGdjRmRTd0NtOTlUSVlzMjFB?=
 =?utf-8?B?NU0rWitkNzcwZ0lEekZqYmJYKzgxRHpKL3ZsUVJsODFaem0yVHVFaUlORU95?=
 =?utf-8?B?QzFWNUg2SEFmbDlXRGNhZlVhTUFJR3pHWHQzWk9LcWhDSWJodEFYS0FFRmNT?=
 =?utf-8?B?VnNiaFRIOVU2SlNPNmFxejV0Q2p0clYwWnpUUE9URW04Mm5WT0h6U25MTFJx?=
 =?utf-8?B?TWVzWkVjdjRmSm53WWxFaGQ2YUFNWTN4SitwcGNaR2xRMWdwNFRTQkpvS0sy?=
 =?utf-8?B?TktseCtucWdvcWNvOFJ0OW5lSGxMb1ZwZE5wK0JpcmFmQnErNmRtMC9WYzZZ?=
 =?utf-8?B?c0h2RWQ2NXIycmtIVzQ3YmVPNzVRVjhhdlBYZm5qaFRpME43SGtRSlV6SlZC?=
 =?utf-8?B?UWJYMTBGZnhsa21pOFZMbXNML3Z4TDNtMjBtaHpuN2lHNUZVaGdQNVZTRDhZ?=
 =?utf-8?B?cVlORHF1WXdxV0lwTjVXNDRjOWszU2d1WDJaeHlLV0lBLzJjL1J4dU9rN0Zk?=
 =?utf-8?B?emUwcnAwdDFENlVCWExqallDbUUwL2J3eENzRmQ1aVZyZTBaS3dHN3lmSFhJ?=
 =?utf-8?B?cVJGY1lIVGZOeE8zbEpIejl1SzdsRWdsQ2JKek53MDZMZVRhNVNJMjA4djF1?=
 =?utf-8?B?bmhVMllWZE1KaW5kNElJazZaWlFWdnl5V3pOaFdZM0krR2o4ejZSQTBGNjdN?=
 =?utf-8?B?NFZNZWxQY0VSM2FZV3E3eXZmTGpvR2NsSlE0S1lyajlUY2w3ME52SDBPeUtZ?=
 =?utf-8?B?WjVsVVB0ajJWMEppY1hrTU1ySERpTVpJZmJad28xWTJuYm1VTkFQR3hBejJQ?=
 =?utf-8?B?aXkxM3BjK0VGQnZYcm1rUGE4NEtGYVl6TjVyT0pEZHFFODZQUzQxT0d6cWtH?=
 =?utf-8?Q?cw2hzxi/F+CpmVJflm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba21c12-68c0-4000-c344-08debb64b5d7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 20:23:55.8032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUxpB7a1Vs5wK3EZ6Ln0hcKxVWcIHdXZLV+H4/myziChAjoBBAP0r7z4GkVv6cie
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345
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

Reviewed-by: Amber Lin <Amber.Lin@amd.com>

On 5/21/26 20:20, Alex Deucher wrote:
> Need to restore any good queues even if the suspend_all
> failed for some.  Always run remove_queue as that will
> schedule a GPU reset is removing the queue fails.
> 
> v2: move resume_all after remove
> 
> Fixes: eb067d65c33e ("drm/amdkfd: Update BadOpcode Interrupt handling with MES")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 20 ++++++-------------
>   1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index c351f7cff0553..08006ce8126c9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -3258,32 +3258,24 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbel
>   
>   		list_for_each_entry(q, &qpd->queues_list, list) {
>   			if (q->doorbell_id == doorbell_id && q->properties.is_active) {
> -				ret = suspend_all_queues_mes(dqm);
> -				if (ret) {
> -					dev_err(dev, "Suspending all queues failed");
> -					goto out;
> -				}
> +				/* suspend all queues will save any good queues and mark the rest as bad */
> +				suspend_all_queues_mes(dqm);
>   
>   				q->properties.is_evicted = true;
>   				q->properties.is_active = false;
>   				decrement_queue_count(dqm, qpd, q);
>   
> +				/* this will remove the bad queue and sched a GPU reset if needed */
>   				ret = remove_queue_mes(dqm, q, qpd);
> -				if (ret) {
> -					dev_err(dev, "Removing bad queue failed");
> -					goto out;
> -				}
> -
> -				ret = resume_all_queues_mes(dqm);
>   				if (ret)
> -					dev_err(dev, "Resuming all queues failed");
> -
> +					dev_err(dev, "Removing bad queue failed");
> +				/* resume the good queues */
> +				resume_all_queues_mes(dqm);
>   				break;
>   			}
>   		}
>   	}
>   
> -out:
>   	dqm_unlock(dqm);
>   	kfd_unref_process(p);
>   	return ret;

-- 
Regards,
Amber

