Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B64C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 08:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F385D89361;
	Mon, 13 Jul 2026 08:40:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dDwA86MQ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A3CF89361
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 08:40:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r23MJBawcHuhEH/rBvFr+79nzMqHET0Ynq6eoOCFRMmPEIIin2nA+QC171wjbj2Iqf2HD0WcO33FlMBSFQGQfIl4PxfT5u1pjNaT9+CC/tBJIlc8BnhBkDLdxKtN+CEj8DYfP60+LY1ffmZn80uYsp8OojMgfL2oqpSvMu3QgtQXU9Gb0nuow/h/2aCOXcAEB7Z0669rVTTLKPiAuPh3ozFhSoMbVNQANYnriBeoJB86kHxY0F9urYbYiMOKRETglGMHKcZ2i/p0p8bzDtp4O/1uIULIeTl1Ffg7sytqpBL+mrPZ83XiDqk3z2Jl77VID7AJ3PaTkkLoMU2r/fg68g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZjsUM8thcrIeWqRGNMHESF99hLjhuooBqW4xIzlSBI=;
 b=d153chSAJ1B5qiHXXVZ/3YV2u5QFlwqlHPOD8HBA7vpnjQ9RyHAQipXirjcqsdexX+62zikfkQPEWcVCTiCIfL8t0k2PR+4AUJLRmSKZWuw1uQjo1QnZpmbCwy91wmxYwvG1s7jqZ9M3Qo5WMCNad2iwOSHGlmTXVkUaWkfTm9iUQ8+SLwYIqJkFxGoiZFJ61L2D+56jKwOpH31Of94YNE2OaL9vhyVSJfiquo0iuBWL3rurCq0gN12lQe1S7nyk9aqdfb7FAINrTPSOqVuPEp5QNNLUtTKT8555tCL26uDHyQcMxru2OF9nOP/oFwig2Gmf2R7HmUJOoWwJLBN8Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZjsUM8thcrIeWqRGNMHESF99hLjhuooBqW4xIzlSBI=;
 b=dDwA86MQtryjZKTN2cxvKfuTfsSRjYS/Fwj/aFrYqkmqWCvnCKpJ1P/PZjLmgRc0wqjL0RX4lmewC2R5fnPD7HbaXxB/W+b6DuPLpccJsLxVGmEQh+vRSE+KtL5K7EBQh4T/KwoDivhpKfT+iCx62VlPD/oBUBTIOh4F39YXvPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 08:40:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 08:40:39 +0000
Message-ID: <43c2ca71-c468-41f1-adbc-cc170109de14@amd.com>
Date: Mon, 13 Jul 2026 10:40:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Print vmid, pasid and more task info in
 devcoredump
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
References: <20260711112108.8980-1-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260711112108.8980-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: c8eadc34-467c-49b4-2800-08dee0ba6a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|3023799007|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: CHWWtdTBsN+LQDOFmzvn7M3AUx5z3jMW962L5WoJahc2a0y1KFah0PO0McSsJjJaGXffGuhgGaIY+D/hvNMaomH9Rz0hNJdE3XG5vn3r4VyKpCSANoRt62Xyy5g1hC6saucAdlBgfBw8Zdrb8Z7DkZysSgQws3AOhEpHdQXGZ+RXSFq0r1oIIWveFubEBPkAtf+oU3sNgk5QKEdXvS2etH+OuB0JdhsiJTxI4pbibP8VEyUjLqQ9nmy45JKf78YaomWCgwnY++oepXcs/9QS+ZL+7F0Ix4JvffjEbQEBDhG2bJnLjADY04qKVB33pfYzzjcXbWU+htCpeHIj90jzG+mY1Zfsc/LUVQMy1s9ItxBF8itJhZEwXST1pAX31EqaSNJCn3FmQz/xGwT/3uJnwP937QdlfxSR3cBmpvvbKT30Ti9SApjoWJppeaQNP75LmtfVI5CTTH1qdpC9Hci9t25+9dxBxJr4IX0al8HpoDhPenTCYL75jmRSikBieKdg4GA4srkGyEjgLjHDI8Eb7/TH0ozQmxTcfW20xBkRv/mT7jwgv8n4cHwwgORfMlTP9oj1yOesndZrKr/P3RP6zg+D8m239KQvBawBAvF+MG6YgwY7SrYixCiCFQvOqGQDNzDCQcmJ8RCn0IiUtWNpsK0t+05wYjDCn8bEbnY96Xk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmU1c3ZFSFJOaGhZbGpWbGx2U3RuZFBESEx4ZWRvcG9PRVVXQjBFMWRnNGlr?=
 =?utf-8?B?L1FQVXRUYVdOV3RubmcvY2czVDh4TFA5S0t3S1o2amM2bmNPOGo3d1dSMWhR?=
 =?utf-8?B?RC9ISUZQK243NVFlVU4rdmh5MTBaVEliNXNIT2hzRzlhS2RST2E1NWRibW1X?=
 =?utf-8?B?Y0t5ejdFZ2xOTHZiT09ZbGt0QmxDWHVLVkpDbCtzaHE1dDhXTFY1Y2ZmNVcw?=
 =?utf-8?B?T0N4R1Z1bGVyUWNjSFd4TTdTd3RjYkpycUJRMkZrMG5VK05VSmFXTmwxKzdG?=
 =?utf-8?B?YlJLQUlodEJ1bm5vM1VwQUxtUTNKS1BLSmFHc040Y21DeVdNeGx6eVJSOTkw?=
 =?utf-8?B?aElJdUF4V1pJOXNVaGpHUVNlYXp4RmJjakxDYUhiQUZsZXk0UExFNVZQaUJT?=
 =?utf-8?B?Ykx1MlZCSjlZcEFFM3N3YVFXUXFraTBxZWJTUm1BWTVIUXNzejc5UC9NcU5v?=
 =?utf-8?B?bE9kUkQwZ1RpVndGZ2VNZllTaEQ1NjBHWUVoa2NMUjkvS1BRSHQ5TXZOMm55?=
 =?utf-8?B?OFhtT0ZBSVMrblpUaS92UnpheTJzOVkzZE5Zc0JZaTNiSzBwUVE1UDRFNFZI?=
 =?utf-8?B?SnNEbnRudENvbTZzWENYdGs0dksyU0hWMGFvQldscVhERk5taDRZTGdIcExR?=
 =?utf-8?B?TmFoa1piRVNsOUx3MWZ0VUVFZnUzcTdWWS9PdnpCVmgzWVpYMjlYSnNFVHk5?=
 =?utf-8?B?ak9oNWpDTVFoM003K2huaCtrMmFSTVk1STV3WitMZDVMSW9uMjhvQnlzdlNY?=
 =?utf-8?B?alpaR2k5TDc2U3phSXZQYU5qUS9vaHgrQ09iR29VckxtWlZFcnFqbUM5Um5W?=
 =?utf-8?B?T2FmWXlwWkcvL3NJWVhCUG91YmxxQlYzU0VlOEVDQ3d3aDQvdlgyTHlMNDNs?=
 =?utf-8?B?U255VlAzb1VKYStML1hWdUszMnkyeGlnU2pSTUdNOWJvenRZM2VGTzNNSTJR?=
 =?utf-8?B?NkYyV0pWM3I5czVuN2EwOHRQN1pINU52Z1NmYTJlOWR6VG9qVHovSlVyc1Zp?=
 =?utf-8?B?blBCZTB4ZVJwd0x0RllHUTU1UER2TytaRkVucDJnSXdoZGdTZWxQdklQUE5U?=
 =?utf-8?B?Qy9KSFBqN1ovZVpsS2hxT24wcVBHa3NmVWxBRmhRL0ZVWmVNZUE4U1FKUXV5?=
 =?utf-8?B?MEVMSWRPY3JVRnNUd2pJRnNQQVFRSlVEWUN3Z2tYTURpVW1CR2doZXNlRXVO?=
 =?utf-8?B?dGJBQjhpR2RDbXdoT3lPZEZzWmxjSGxNZGY0NzBIZXFXQllGWnNqMmM4WHc0?=
 =?utf-8?B?dFl3QjVnUEZ5T09ZeGVmRkR6L3kvdWZjTWtZSnFRWTFPalAyeEN2Vzd2VlN4?=
 =?utf-8?B?Yis4KzdqR2ZDbkU4V3NPTDNrNi9LVFdOMnpxbkhaR1lvcklMY29GNUJEdU9Z?=
 =?utf-8?B?UHJ1OUk0UnZ6ZXE3ZnByS3J6WVNUVmpwOUJaSGZncmN1VEErc3pVdjJjQmtV?=
 =?utf-8?B?WEJ3eXYwTENiSnRUTTB4VG9sYmV6ZW1nQUdJVGt4aTkyQzdVTVV2bWY2SlFD?=
 =?utf-8?B?OVlCN0NFR0FPWUJMT3BIcHYyYUg2NmlSTWhzbENTaW9XcWY2b01ITmFJRm1S?=
 =?utf-8?B?Smxsb1hibHhHaFk3ZjlhOVc2NzY5b0FzU1BTOUdaUHZQNU9OM0lvbkNXR00z?=
 =?utf-8?B?eTVydk9LWnI1SkVLVG5uQmJ5WDNIZzd4TUFLRUh3alZ4ZnAwRTloQXF5eVh6?=
 =?utf-8?B?OUJlcXJZU2pQdFUwakQ3OUY4WktwYjZtMk9zS2hUZW9Va3UyZXJOaVh4N0xE?=
 =?utf-8?B?ZXV1ellzL3JtUTNKcHpvdWs0REtVOWVlMC9sVEtCSnFhOE1CMGtDS1BPTEoy?=
 =?utf-8?B?MEQ2TnFNdU9kY2ZYQjdyeEZOb0V2ZlppRnR1MDRFNFF5R1NrV1lJZTM4Q3lq?=
 =?utf-8?B?b3l1bGdoU0g3Rjk3THF1eXNkaGRDQmRIK0M2bnZDS3dkT1MvZUV2K0tiY2pT?=
 =?utf-8?B?U04wL1hWcWNhTFV5VHZBT0ZkeHl2U0RTUWdWdXZLSjZuSHoyMWE2Q2xxcXA1?=
 =?utf-8?B?TDdpeGhEWTVjcjhnMStSa05yUk9qUnNUT1o3bURORURDeXkwVGtodHN6T0Jx?=
 =?utf-8?B?TnJ2WEMyTzhRTWtVNTVDdnYwRW05dUpMbVZZbTY5TzJtR0FVWXZnSzFvOFgv?=
 =?utf-8?B?K01laGhXbytrV0oyTUprUHZQTGFWcnVtUjhDb2FGaEV0aFlrbXpHa1JWemk0?=
 =?utf-8?B?OGtmcGdnMEVQa2xLQUVwK1AvOWl0TmRuM21HUWRCa0tITzRJZkdzUUtyZ2w5?=
 =?utf-8?B?RWVtTXA2NTBLeWhJRmJhaGpHMHlKU2lDQTljMTl1UWt4MzhUZkFzOWg2R0ZW?=
 =?utf-8?Q?LYKio11j+C1pvd+DAA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8eadc34-467c-49b4-2800-08dee0ba6a34
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 08:40:39.0734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZSi03kNPF5/WR738X6fecMjLa1LD84fP5D7UWz1tfCCtDCCFgBxnIabWA6B/70Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602
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

On 7/11/26 13:21, Timur Kristóf wrote:
> These are in the dmesg logs but are missing from devcoredumps.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 7 ++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 4fd0df3aa70d..aaf091b7f9d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -356,10 +356,14 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
>  	drm_printf(&p, "kernel: %s\n", init_utsname()->release);
>  	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
>  	drm_printf(&p, "time: %ptSp\n", &coredump->reset_time);
> +	drm_printf(&p, "pasid: %u\n", coredump->pasid);
> +	drm_printf(&p, "vmid: %u\n", coredump->vmid);
>  
>  	if (coredump->reset_task_info.task.pid)
> -		drm_printf(&p, "process_name: %s PID: %d\n",
> +		drm_printf(&p, "process_name: %s TGID: %d thread: %s PID: %d\n",
>  			   coredump->reset_task_info.process_name,
> +			   coredump->reset_task_info.tgid,
> +			   coredump->reset_task_info.task.comm,
>  			   coredump->reset_task_info.task.pid);
>  
>  	/* SOC Information */
> @@ -563,6 +567,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
>  			amdgpu_vm_put_task_info(ti);
>  		}
>  		coredump->pasid = job->pasid;
> +		coredump->vmid = job->vmid;
>  		coredump->num_ibs = job->num_ibs;
>  		for (i = 0; i < job->num_ibs; ++i) {
>  			coredump->ibs[i].gpu_addr = job->ibs[i].gpu_addr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> index 2371e20fc68b..63f27337c09a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> @@ -63,6 +63,7 @@ struct amdgpu_coredump_info {
>  	char				*formatted;
>  
>  	unsigned int			pasid;
> +	unsigned int			vmid;
>  	int				num_ibs;
>  	struct amdgpu_coredump_ib_info	ibs[] __counted_by(num_ibs);
>  };

