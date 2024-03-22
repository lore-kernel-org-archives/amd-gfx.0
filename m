Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1574C54E71
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 12:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CD8310E9C5;
	Fri, 22 Mar 2024 12:52:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rjcgwKcW";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24A9C10E9C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 12:52:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkxMHqeunI1zsEXgRxsqA3T0XG6ECP+ketTep7bF0QKNX3Z9zU9cKtYnpKvUdyCX1m+/cRFPPJs3S3c0O2jtJezA5TCTsKvhzSl+XFz/D9kA+kUYP0jQXW4qillSQLp+MpbFFxsK8brjWNs9IK0Rwi1um19uQzojgVxzkvV0lCpY/i7qH0RdpQi7YtRf9ofgnYzZpflCYHNsG1aFDqqyjgiHL8eLJhPThqbFKZR43eW7b6vq3a+yp6tnV56SOm/z7NQ1+uzibsAv6Y6DWpTotXBH7fY8f85/71k4Kd/RH9XYr7WRWJewqZT+ScApV4T6cnDSsHcsZ4aMKgLL/xllLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsC2vAz1vOJNw6ELEeInwN/1Fzu5/mH1mCnnIfKPkAI=;
 b=dBoP+bHW8KGeVIVnXi3lWTciANnrrrR6RwlVyNsQXsynTP/n5+Yi1FIY2YJiEDdiLD1HtvQNjnCYQR1t5THBiqDNCvwU+rnVt+t0oB2IA9JbT7v7yVPRoQ++zaGtNQFBIfR8uGV5oxIkr44DtO0QhXqN3Fy8f2iMHlFvKEIYXmOLLGRHwGgm4JxzMQHrAs7mmXb2GCykMq8150SCTe9deCh7TrjQIxWji+Nbz3/v+/8UB7abqkFzhypzXI3OnrbZaXD3nPXb1sU85QCSpTMoAgkCenGJZCGLGGPZLowQsP3WuCeTSVpc+I+MojH+dDp7VkjRRgku+ywwpLYvJ+35sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsC2vAz1vOJNw6ELEeInwN/1Fzu5/mH1mCnnIfKPkAI=;
 b=rjcgwKcWW0YRyfcmaXlc/7BeZJp2xD3SrHsvfkt6Bp9vVHehrphLHE3FFSJwtMH5VG3885Y7l+CZzWg3vVsL/vDe4idCu83+nu0OWEmsnW77ipy6RIRW1DfK4Rjac8e3Y0FM1Mv6cekoM8j6U9/gs2WNrhnywObkQAJXLn5hAgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Fri, 22 Mar
 2024 12:52:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 12:52:17 +0000
Message-ID: <d15f26ce-ee98-40c7-87ba-b1c1f0b50722@amd.com>
Date: Fri, 22 Mar 2024 13:52:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix the list movement
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240322111445.2162-1-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240322111445.2162-1-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0059.eurprd03.prod.outlook.com
 (2603:10a6:803:118::48) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: b42f157f-bc74-4d48-783d-08dc4a6ee758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D/hfz90Rcmf62tCqRZNH4oMgAh44pJ/z2d6/yZuqLTvvzBhJs2W4lEWF5FyZNyCqT3OCposhlRsSL7TMygTL3etfWFLHBPI0G6vdY3f5GkHMdqXK+pp21N1sHdDqrj9iGNRcPs5/wfs4jNCt4RCc07DmuH0O6oeiHUZL5vOKO8Qpw1wKh/mYVrG+BnoMa3ZIktDd4CqZ/USu3RtBr0NwJ+BTZPk63ihU42TGpVJWst/SZQ5UBgRZ3nVJwJ6jcTRt6qOrDmtNQ3SM6csJ0ZrU0gFDCd68bdTEV5/v0R6SfD7c4opz9PbSZCsF/mwWLpHCMREnOyeN0/IIsQaJf2iBnxQ8MqrKop/xjkrsNpI0JUliW4jgP5504K8zg20E3QJeg4KS9AQQ1kh3cVHWAwSoTogW4lEjR8l52YTLYdJ7YR+mZlqiJRXvTOuRB3AKT16UF00JSWfxQABVK4dnbhTrCrCYKvHTm1qiNwfv90fMDxZjpb5T3TYIus+TIJ+V1ZnchQdd2wD0VXpE7ZlYTsgac0z2zNaMeWSIxhIrAZs4K/f8WquX3UEWvD2yqplWbCFWcy+K3Bq5DyjTBfYfMDveP34sL326cY/ta+o2nM43Enjp4eYnvsDTaj/IuNHIVc/k4PdsWhvFeAM2ntTObl8wwLWAvdlWgw47ToPBdfFAfn4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkQ1dW4rSEw0RlRxWHlBdTZWdk9ocXV5UnVmcVA3cFNVNTZDb0tkdm9JT09y?=
 =?utf-8?B?WS9BbUFHWC9vUERXMFhZSCt1ZnFDOVp6cVZlMUtBaXNKdUJMV1VySGxHRlNl?=
 =?utf-8?B?N0lZSnoyeDg3dVlKdG5UQy9sOFVGaFh6WU1UeG9iSXlpTVlrZUZDdXlOQ2pS?=
 =?utf-8?B?bzIzZTIzVlBvUk1pc3pxVkl6VU1UcHlEaElXZzVMbkl5ZkJoV3N3ZnlUb2lV?=
 =?utf-8?B?NFcrRlZyeVlHYjVWdTFuN1NtYnc5THo0QlZsTTZLU0RiZnlPTWRkci9wVzRr?=
 =?utf-8?B?UmlsNWlGSUNnWWN2NS9nVTdOMjN4REplbWl0T3QxKzhQNTFaR2I0Q2NZRnNP?=
 =?utf-8?B?Rml5WWxzQ0VOT3Z0VGpFWVR0d1FjS2x1OXBLa3d5c21mNVNhTXFHd2JyZ2Yv?=
 =?utf-8?B?bUdzQlJXYTRoc0lhK3l3QXpTRWMreVhsbUxmQWgvcW9vL0xJaGVMeGZCSFlS?=
 =?utf-8?B?d3l2U1dHZnZSNnVCSUZLYjFpUFFSTGp2TXp3SWk0Y1c3WWlldFoxZkFNc2ln?=
 =?utf-8?B?MVBrZW1YWHJ2bzNlcExOL1RnNkg4eHpvTUp3aDkrUkVmZHBrcWVzUEVCUVJt?=
 =?utf-8?B?RDRicEdOZUVWZmdVZGpnNlczbEtJbkZxeEd5ekMyS1ZMeVZCd2twd1BBcTFJ?=
 =?utf-8?B?STdYTlgrUTdnRkVrcDZnU3NzL0s1cTV5WWxvbU8raUorN05JMnFpWEc3YUFO?=
 =?utf-8?B?R0MzVXpYaEZLWGtpVWd6dFQyL3JFNFZtbWMzdXFTdlZUYmdQQ0hUK1pZRjhK?=
 =?utf-8?B?c0RKSkgvV1Z2R3A3UWx5VlhBdEJqejhUSnIwcHpPREVMbHBEWFVRMW9SczAy?=
 =?utf-8?B?Y09qZ01LNHozdERSNHRTcWY2T04zOFQzL1cwcVpoTXhXOFpaTzVWT0toVVdB?=
 =?utf-8?B?ZEJ4RjNWUW9nVmNZcGp5Z0hJK0ZSNkJNcVhZbS91TmNOeVB3OCtxdVBXb01w?=
 =?utf-8?B?NG82RlpmaytWU2doTmtoOUgwdUw2ZkRKVXJIVGYvMHFOUU1rQk9VQjd2dTVL?=
 =?utf-8?B?b3lZVk5OS0NuUmNaNXdDcVNXb2lXYnVtTnY5d1BEQThkKzRlUjhUZVg5MGxw?=
 =?utf-8?B?OTZSaWRjMXUzbzh0SnVXWDlVNTdIV2xxK3lNVnRMelBNVmcvWDg1YnZ5WDJQ?=
 =?utf-8?B?algxa3ZFbXpseVh4R2RtdjBnQldXMEpUMVhta1M4V3hVRnMrQjljaGxNS095?=
 =?utf-8?B?ZWhXdUdVeXZYV3VCRk4reXhlc1NNODMvNmNDaEhJQzc1Sk5hWUtIUzV0a3Jo?=
 =?utf-8?B?WllqMWtYOWFNUWtaZjBIZ2t2MHdhVUZlNDVpaEMyRHRLVnpYanhndUdpSVBz?=
 =?utf-8?B?ZzZIRU5GOWJoNTlJRTEycmJ0OEFGc0owcDVZOUxlV3ZBeHJkMGExa1k2TTZ5?=
 =?utf-8?B?UFdORXl6eFZaZ0k4NndoZE1HdGhnZ1NLV1VuNzVWSnBSdC9QN2JGaU1nY2pz?=
 =?utf-8?B?cU9YdjZzWDVoZ3g2akxTQWtqZmVOakR1TmVCQUtUL1dSelZoUzBhMjZsdysy?=
 =?utf-8?B?Sm5zNDcrVWNOb1k2enA3ZUc3RUlmVStLZHNqemJCWG0xMlBVRHdqQ3lKL0Ew?=
 =?utf-8?B?WFREdVRMU2pDYlY1Y1ZVN0VZVk1VM2FwNGdDRkVXczB5cjJZeTlmMHFCWlhJ?=
 =?utf-8?B?cHowUWlnU1ExRVZTWUpEVEMrY1lyQ1JIOFFGVHE3YTJGNnhGd2svM05EUVpQ?=
 =?utf-8?B?cGswai9JcnhLdWxhOHZ3MmRxZ1JBNkVwbzdBeHpsRjBLT3FDV2pMcnZkYkJF?=
 =?utf-8?B?dnJqc3kwWURlUldUdnhLK2hJY3NCdkQrVDRCKzVGY2RCT2pRS2IweXNSMGpv?=
 =?utf-8?B?ZW1LcjY3eFpmTy9uWjdpS3oyZzJvK3FSV0RrcUFoYTBvTlBnZ1FTakUzTXlx?=
 =?utf-8?B?QWFrSmpoMXVzYUdvZFhZTHdteTY5MUVTejFGQ0JCZERSNTVneDJja2pVdVVY?=
 =?utf-8?B?b1ptVTBya3JmdnJ4Nk1IV2Nrckl3Vms3dUFqcFQxT3d0Tm1UTlNRanJsMWds?=
 =?utf-8?B?VjlGYUVFNUg5TnlJbDNVNU8vaDFqaFhxWVYrQ3VaVXBKTmFHV2RrMzFHUVdx?=
 =?utf-8?B?UEhyYUpTMUxEMmpxLy9BaFluUUFBWWNaYjh3RVRQMm9LcmdDekVEdmJXYkpT?=
 =?utf-8?Q?LQ/s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42f157f-bc74-4d48-783d-08dc4a6ee758
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 12:52:17.5464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4n5kOUQUoBMZ7rKLqEfxPrl8D9jTsuFwN0Jm+hjIZYMLQVriulHWxpAQu6qO8lLZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089
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

Am 22.03.24 um 12:14 schrieb Shashank Sharma:
> This patch adds a fix for list object movement, which was
> introduced in the TLB flush series.
>
> Fixes: 0a29a49f3ed4 ("drm/amdgpu: sync page table freeing with tlb flush")
> Cc: Christian König <christian.koenig@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index a0a5b955a4b4..7fdd306a48a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -641,7 +641,7 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>   
>   	if (unlocked) {
>   		spin_lock(&vm->status_lock);
> -		list_splice_init(&vm->pt_freed, &params->tlb_flush_waitlist);
> +		list_splice_init(&params->tlb_flush_waitlist, &vm->pt_freed);
>   		spin_unlock(&vm->status_lock);
>   		schedule_work(&vm->pt_free_work);
>   		return;

