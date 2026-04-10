Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A62F44868
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 14:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DA4810E97F;
	Fri, 10 Apr 2026 14:20:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ltOlx8y3";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B0310E97C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 14:20:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4Yyi1Dj32Ljndwee6ATk4X7537RcXQ/LcE9QpL3VhsYkfYvCbdilzmSZRvH0tiPkgLqxHEAIOGbh1yVxytL931Hi+XBtk5FcG6VzHtlue+WjmkDKion0QPqgT9nKgfg/8I5SLPYnisTXYg33WRIXNHCNyMF15K4AMmmdiDRlh6fTPMPwUz5rDqI0aXQtXOr/OUYpqzb16+qnmF+0HNgLZdf5R7gZpeuiGlT4LvrlgdHq4m06gY2uNi7FPR0pvo0b7NBG7Jvdtrz5x2jbxEuByjyXJ/ciPO9bwZJTKjyKi3UuufzamRM496JfEYxLa3wZm3/1dNGrM99MvXb12m8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/gXWkycgvPkFz2cyPj/zXXJRGR0twWRBvDomAXr4WU=;
 b=HVXhkm+kqZ2FPutAi7Wf5iRrFs+Cu0N62M6jJfrCLwQPku03so6Isl6Y3bqQA5Bmljv6/idP9nXoSayK91B0mTw14AflH2LU0E6nbkcQxpoRAUADu/wI9t2jTSBrIc2QY63x72klhVs/aXSfYt4NiDb9BsMEIM0mUrZgr0ftVKG+D/FN9UgYrqfp0eaca9fKKk3n8M/7xENW6TeIGA/bVbzD4dYtUIRK0v8qaSFd2mrwbl4gQRGNt0AATUFplJDQysWz6UMxnG4cJa5C7y/3YabQNyCBD+gt77YlJZ9HV584lhNdeuVNHgkqeiQCn9t4biFhuWGdJBxMwYW9avvFdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/gXWkycgvPkFz2cyPj/zXXJRGR0twWRBvDomAXr4WU=;
 b=ltOlx8y3Ddeb7NWrCe5yQw8sNf0p8zCgeHb6pbU9Bu7COqRGI5vpeayS4QdglLJAP/bh1ubDnc4yXSDhIFDxSeaVC9dLK6HEcfmkp0nGrJMqgTwZQaNwZFmOwEdVMBOjwPi5fsUoOHxBFDfLc6JCPYJz4pasL1Erty0jYDMQ/AM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB999071.namprd12.prod.outlook.com (2603:10b6:408:352::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Fri, 10 Apr
 2026 14:20:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 14:20:09 +0000
Message-ID: <b5573653-080e-460a-906e-cff8f3dd85a1@amd.com>
Date: Fri, 10 Apr 2026 16:20:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: fix NULL pointer dereference in
 amdgpu_devcoredump_format
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
References: <20260410013639.129917-1-vitaly.prosyak@amd.com>
 <20260410013639.129917-2-vitaly.prosyak@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260410013639.129917-2-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB999071:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4f736d-f8c4-48df-5c80-08de970c4590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: SZN23Vo3hxFt/RXAoLtfXBA3I+R9+fKQTHOrp3i8hXyJkv3hLC0fdt8WcAe/cdPIzhDJs0z/K5bU1Xlvy9zxhcEnuZobdnJ3qXxDeomhzrTUOnhzofgBRab7xJ7FY6IZBMUIv2V5Rpd5j3gDw1uQ0RYJNEQGihYwjCVmMibWiSUmiBAEQqrDm30peAXOHvF/1Zh424Ga6A0MTKrEsQ+p/durUal2JlOHDDAbDten+SE8n1P6/Pde7kprCH7jQbPof3sw36utSJqZfl1y9Kyqne7dbta/OLozA1/iEZ3giKjUPbt+2eCBMSwkKh7z5dOBQMd4SC7zUEw91wZ/C9VASiOWsTjyI3O2bQzpndJ71JSlUQ6K/9pu+12ITUD+uBee1+yIClrJ9wD5M4e1jMtdWAP9AYoUl2E5dL5Pee3zbebHv91k61Z/9+OOtm9MhnzY6h+RkuX0vVQEU1gzIXu4F0iyWbir6UfjqHxZknb1r9et8XydA/QWp5O/V+9ZHaEcvfz0X7JGkiuuYObzUwkK5APerqGHHsEnpk/vCkLp1tJeNYW0tw9Rx4RHqlzu+V+SVsGO69bXw7ulspOqnzE613xR3CZjBgWu5kVue9TvFNOXnckIvB1cNMBuFRSHKdPRRTt4sEq5dKtKy1i0FzDv4L2+jIu13VVVSHSxmitYeXbJesGBQO/3216qGYsWBtuOUmXAajNgPoSYaUkL19Ur8LEhDeJ9ugpDdeELkFRNol0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUkrTHp5Yk00d0JjOStyTGVJdlY4WWp4a2QvQUttdjFwajhJNU5Ecm52K0NO?=
 =?utf-8?B?b3E5NmhxYy9RY1g2Z2x4TU1KbytlamI0b0FCdnhYVHN4bU9oenhpUHQ3V01u?=
 =?utf-8?B?QVl1Y3ZDeVAvNytTeGZ1R0J6NDlkUFJjeUpMRm5IUHcvamR6NUhWZGpXQnU2?=
 =?utf-8?B?MUt4dmZVVWF5N0NFdmhFanI4cVE2MkRDV2tlTUhQNnl6cWRSSkpZaXl3bzNn?=
 =?utf-8?B?U0Z5czBaZi9UNFNhRzZLTDFDYXpPWmNGN3Jod1ZJR0ZIYk9TWDhqU3EzZ0VR?=
 =?utf-8?B?MTJKUnlqbmp5dUFxMEJFTDR2YXo4clNLZjlKZnl0ZDNsY2ZOTnFjdVdFa3ND?=
 =?utf-8?B?UlN6VE5yZjVLeVNabituRGQweE9Baitsemk0dlJ1YnFGdU40SGx4dkNqSVZ5?=
 =?utf-8?B?SnJwdlZldHcrZEN6UXNCMEsvM1hSQlhzYXNkZ2tLUWtLVWZic2RUOURxQUVX?=
 =?utf-8?B?VnN5dVpTcTFnc00yYmo5WWdhY29GZmxpRElQenE1SHF6WUxpZWNHdmRLOTNY?=
 =?utf-8?B?Tk5sTTVOZ3dIcGV6cDVxZEJYUlJrUWlqZWdzUmhwL0c5bGlhV3lHbWNQVzRQ?=
 =?utf-8?B?d2JqbURGRkxMdG9ZSmxwbndyN2w0TG1aTUkyNk1KVUtOVnVGc21UTHo5eXlN?=
 =?utf-8?B?dm9ncmNUQzVReENGYzlpMGYycGNFNmFWRUMwTTVpaUFXZjFyUXJ6WHdJSkUw?=
 =?utf-8?B?TVIxSHJEME11ZzdoZkpET21wdWxaTGlLQmJsMytxVGhEQVV3VllzQTF4Z0Vj?=
 =?utf-8?B?WExtNmtQS2RtcElwMTVHMXd4V2tVc29mVCtNV3VuOFVJVmVRY0pTdXpTVWEv?=
 =?utf-8?B?RWc0d2tGL25zcDU3cEU0RXVHWHE0NVpPczExS3hFankyRUJvMCthbHJySUp4?=
 =?utf-8?B?UFZkZUdYTitBWUJQdzJzMTJocitqUkZZU2lUVEIvdEdnMENzbzdMSWs4SFEr?=
 =?utf-8?B?UElGcnNoMWQ1bVBSemdZa2owWDZOQkdjNkhpaHNXZExmWUd0bFlnVThBaHh6?=
 =?utf-8?B?MDZjNVZhQmd6YWlIL1psYzljTEFWaWg1MXdVbi8vTExOM09XR0JBbDBUc0JK?=
 =?utf-8?B?RWZ6SjRCbGpqY05FTzVBQ3dMU21IQW9OUEdtdWlPV3hmYVRFMUh1SE9QcEps?=
 =?utf-8?B?UzNPaHVXbTNvdzdtYjVXNTBkMjE4eDVoUjBKTzIyOUZzTFIzRHV5ZjVHZEd1?=
 =?utf-8?B?YUNhcTZsa0dsb2ViYmZlZ2Y4YVlNMm5kUGxkSGxJV0liNjBKc2NtYUdlbXhy?=
 =?utf-8?B?MGg5MTh0V0FhbnJrZDNmRi9kOEdkTVZOYlQ2Zk5GR1greXR0K2VrbUhHYVRz?=
 =?utf-8?B?aWxhZFI2cmh2WUdvYlJiUHZ6M3MzRkMzWTRaRjlZYjJoWGlpS0xSb1FjV3Jk?=
 =?utf-8?B?cU5yajJMK2ZYdWdNdkFpTjJjR0ZRTU5lQ20yVkdPWXk4N1krU2RtSmc0eG5J?=
 =?utf-8?B?VDdrVlpRWVNpYUtNVEdlQjBEL1o2dURjWHExZHBqbDdGNkd4aWFTVWk1a0gx?=
 =?utf-8?B?VjVJNzMveGozQ0wvc2NUYkZxdVNjTDVPQ0loazVxTVhzR2NlSllodUhSTTBt?=
 =?utf-8?B?cmh3T3Z3d2F4ejV3UFNRc0QvMzVOSGVYRSs2MFUvbHhMSll4dHNzRk9hWWw0?=
 =?utf-8?B?bC9wYXFHck1oM0xCVFlNTWdmY3NEV1N6djdVUHV0dDBmTzhXTW1Ra1F4eGM5?=
 =?utf-8?B?KzBMUklES1dZVXlSaWdnOFR4MVlSKzYrVnhHcEFjOS9HZXRVa3BERUVFU2xD?=
 =?utf-8?B?UUdrUEd4c01ZS2RIalhFMDhUTjR6ckludGhrVkd1WDlqMDVQdlY4bWh0aEFR?=
 =?utf-8?B?czJCdjAzVGM0NU1yUHY2YkNtTDZVMWJtZHN4WTVGUjVvVTQ4SHN5N0lHbnpn?=
 =?utf-8?B?M0wvV3hVTmJ5L2lwRXRxZWR6RlpmRlhqaXJ3UmZVYlpRUjg2V3phTVZjVUZo?=
 =?utf-8?B?OExBS1ZtZUZjekUyeTYzai9NRm9xcXBWSTZtckMyYnQrRWMrOWhDc2t0Tmoz?=
 =?utf-8?B?N2E3RUJ6ZjhJTmNzcTlHZ2UvV1pzOEhmVWMwdjM4NTVjTHZ3M0hVVllmdTVO?=
 =?utf-8?B?OGpYb3pVZDYvZk93dXNmclp3QWoyOWppVUdHMnNRZVpvSXZWZHE2RUtHbFRJ?=
 =?utf-8?B?cFVtVkdNNEJHMTlNU2NjRngvc2RKOXN4WmRWeGdiUjN4SFF5TXM4TlB3a3R4?=
 =?utf-8?B?b21FOVdkeDBWdnUxaFBDeU1WcmRWMjBQVG02SjY3dU9VeDh5SXNvU09ISW93?=
 =?utf-8?B?SHY2cWwya1M0U2lWTkNFNVFvYXBxUEtFNGFiMFk2bHU4TVVET0pCSVNyejd5?=
 =?utf-8?Q?sb20lkMLmjce+Erowx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4f736d-f8c4-48df-5c80-08de970c4590
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 14:20:09.7865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnqr0HKYjp1lTHFYKnETUtfP8hO16Y8m270bf3OzRH/t+irgMrOREG+omKvfjkl1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999071
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

On 4/10/26 03:35, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> A race condition in the devcoredump code causes a NULL pointer
> dereference in amdgpu_devcoredump_format() when two GPU resets occur
> in quick succession.
> 
> The sequence of events:
> 
> 1. First reset calls amdgpu_coredump(), creates coredump1, sets
>    adev->coredump = coredump1, and queues the deferred work.
> 2. The deferred work begins executing (work_pending() returns false
>    since the work is now running, not just queued).
> 3. A second reset calls amdgpu_coredump(). work_pending() returns
>    false because the work is running, so amdgpu_coredump() proceeds:
>    creates coredump2, overwrites adev->coredump = coredump2, and
>    re-queues the deferred work with queue_work().
> 4. The first deferred work finishes and unconditionally sets
>    adev->coredump = NULL, destroying the reference to coredump2.
> 5. The re-queued deferred work starts and reads
>    adev->coredump = NULL. It then passes this NULL into
>    amdgpu_devcoredump_format() which dereferences coredump->adev
>    (offset 0 in the struct), triggering:
> 
>    KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>    RIP: 0010:amdgpu_devcoredump_format+0xa6/0x36b0 [amdgpu]
> 
> This was observed during the amd_deadlock IGT test where multiple
> subtests trigger rapid ring resets. The dmesg log shows four
> coredumps created within 120ms (at 102.377s, 104.424s, 104.492s,
> and 104.497s), with the crash occurring 13ms after the last one.
> 
> Fix this with three changes:
> 
> - Replace work_pending() with work_busy() in amdgpu_coredump() to
>   also reject new coredumps while the deferred work is executing,
>   not just when it is queued. This closes the main race window.
> 
> - Add a defensive NULL check for adev->coredump at the start of
>   amdgpu_devcoredump_deferred_work() to prevent the crash if the
>   race still occurs (work_busy() is advisory, not a full barrier).
> 
> - Guard the unconditional coredump->pasid = job->pasid assignment
>   with a NULL check on job, since callers can pass job=NULL (as
>   evidenced by the existing if (job && job->pasid) pattern).
> 
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Jesse Zhang <jesse.zhang@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 8edec416fe2b..5cfd9ecccdf2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -464,6 +464,9 @@ static void amdgpu_devcoredump_deferred_work(struct work_struct *work)
>  	struct amdgpu_device *adev = container_of(work, typeof(*adev), coredump_work);
>  	struct amdgpu_coredump_info *coredump = adev->coredump;
>  
> +	if (!coredump)
> +		goto end;
> +
>  	/* Do a one-time preparation of the coredump output because
>  	 * repeatingly calling drm_coredump_printer is very slow.
>  	 */
> @@ -499,7 +502,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
>  	int i, off, idx;
>  
>  	/* No need to generate a new coredump if there's one in progress already. */
> -	if (work_pending(&adev->coredump_work))
> +	if (work_busy(&adev->coredump_work))
>  		return;
>  
>  	if (job && job->pasid)
> @@ -511,7 +514,8 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
>  
>  	coredump->skip_vram_check = skip_vram_check;
>  	coredump->reset_vram_lost = vram_lost;
> -	coredump->pasid = job->pasid;
> +	if (job)
> +		coredump->pasid = job->pasid;

Sunil also send out a patch for fixing this which looked a little bit better.

Please sync up on the code and review each other patches.

Thanks,
Christian.

>  
>  	if (job && job->pasid) {
>  		struct amdgpu_task_info *ti;

