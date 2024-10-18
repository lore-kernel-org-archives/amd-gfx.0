Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BC4D3E189
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 19:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D45610E0DC;
	Fri, 18 Oct 2024 19:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q/UHIIlb";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24CD510E0DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 19:14:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNyYGqS0I1POOk137CNCfziFq5Z9/kWabqDWTpH054NRIV18cBitxCNr0Z5b2cRCtZ8jd+UwWmEmDcIOBPaoGQgkxkJLMDF48JVZ6ZucBxyQxBoiv4QQ3kPh8LE/gtwmzxQQF3AiHHhVhKGL7CdCsCmiPOoUWmmE30Z4Wu4YDx8ieGj9slR28EyZ8kgGKByq1Tfu2uKhtO47R6CDgHj/hoXfGF9Fj9yLCco+sLMZckaXQhufS0vRXihtz3yFr/XFoRsYXWK5/YCSEYG+oPe7q+D5bLaI+zOBeaxIZSeBQ494Ek/DIY7VQZlzgPvbpC/XL0zpLE73Q2CtA98Gbxl33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMYSfp7I7YTyepDa4o0VlhIVqOQijb/Bhaa/HHK7pbA=;
 b=mvINEdGTCy2WWd0ryH/y4teBF+xV044lp3IV0ChI80E1eXHqfaqjJV20fN3cmeCF1Z0QbxMDF1erF3UzjVO6f1iZazophO74J7JCE26MEvIlviUSYAw6uc9AEdWCVrsxnxty4gz4FXm/sgGQMz21hD+AHteZXv0MrshGxKyJ8kYQK/KXhXHoZ37xmKBXqONB9Qz7+1yKTuzbFhI5KcbGYtpshq0dBMNdpAAC73LHEtX4dQLgpEU0D1GkVyz7PuPEqcY7841r321Aeahdr94w0LT7Xb4J7XWjF3zYfujqRzWpzzgr4wouymJqeEgsOEm7k9uZXWG1b2XeVlAvnH9RfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMYSfp7I7YTyepDa4o0VlhIVqOQijb/Bhaa/HHK7pbA=;
 b=q/UHIIlbf4Hx1P2FyDddxxWPCzSQRr/MfuDAnpX3fUMytiDebd9imv4wNyD4U3AK/rwRmSL0vkrzePdZ4XTTGxb6XUNf5C7fCI4MbHcfY9FweMBFN9NxyDmMB7K2aVI7JGGp8d1+WwcC+1ksSVIvVEXpd/7O2bOIFrjmZ3ZmW/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 19:14:17 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 19:14:17 +0000
Message-ID: <f80e5f38-8235-4c73-89d1-c62991fe052d@amd.com>
Date: Fri, 18 Oct 2024 15:14:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: change kfd process kref count at creation
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20241011144155.120290-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20241011144155.120290-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0284.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: f7bb1221-6bfd-4c0a-b98e-08dcefa90fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFZhZVVmemVnY1NWRCs5eTFxV3NNU3hLdEVXTzJJRjY5eEFjZWNHUHhyanAz?=
 =?utf-8?B?YTZzRHAxalVzV3pNb3ZKVG1Pb2lqY0lUYW1XSkwwS243L3U2Q3RUWVdYa3U3?=
 =?utf-8?B?dnhVY0FKWGFPSkZYTmVpU254SVZjWkRFL1lpblFNaXVYOS95T3JuTFFoWXBD?=
 =?utf-8?B?MzA1bm9iczhzVDdubGRZd0Vxa3lCUm5vcUlsbjBPZXo5VVF1aWRydFZMQUk3?=
 =?utf-8?B?UGNsT0pGd3hCTU1KSVJiekNxNTBRZUZicHhmMzlvKzF6Lys3bUN4bkFiRWlV?=
 =?utf-8?B?eGsxTEVlVFRhWDZzaSswS3IzWWNHekN0NDhDTjU5V25TNTVueGtnbGdYWk9j?=
 =?utf-8?B?ejN3dEcwdW9tZ3VZN3R2TGhabEVNamtHQ1dtM3pjWWpQdXkvMm8vbUFVNG9w?=
 =?utf-8?B?dEpyRmJDbG9tRU1XMlBtNTEzLzZLSm53cXk2QVhUVk5xVUVFTlN0UGV5UWV4?=
 =?utf-8?B?TkNveUozQlNwbXVlU3kwTDBMdC9IUjdWVHhCbkVZZnNRVzR2emhYS0xYYyt2?=
 =?utf-8?B?Y3NZNldlS0o1aGhQK1VtWWo0bnkwT1lCVE5IdHc4YmVzRHhETjV3aWNzOWty?=
 =?utf-8?B?M0UzdFRORjZBRnNrOGd4VlN5VC91eGIxZEtyMkZUVnc2aXh4TkplckZHOEU4?=
 =?utf-8?B?aGhIQmU0SDJ1bDRpcjJBVlk2NlgrQmhlT2ZMdE1NaWh5T0dXTHRMaENuVUZM?=
 =?utf-8?B?SFl0N0E2WFRBcmRvcUc1TUxGK01SSTFzeEd4TlovN2JEN040VG5xK3A2VVVT?=
 =?utf-8?B?dWE1Z1JXaXJUSkdMRlpPSjEwUHUyR1dpUENzTDBVTmRjQVBSNURoSUtmN09T?=
 =?utf-8?B?Mm1aWG5YNWxGd2JqZWdIVlN0T0ljY211Rk9nUmZ1S3poRGppb1RNOGYyRjAv?=
 =?utf-8?B?Q2RwUmx4K1ZIMkErOVFhMkJBd3R4aFd6ODdhay9hYlJ2dkRTc1YvaFdJUTZw?=
 =?utf-8?B?SGZCWkFMY2pQdVlNY1JGN1BuQ1VUdzBUV3hDOG1sNWRwRms3OUdXOVZZanFn?=
 =?utf-8?B?UGhhMDJscml1ZWxwbTZRR1E4S3VQaFFyb092bnlydk1BQ2k5QUJFbWF3QkhF?=
 =?utf-8?B?NzJYL0ZYYncwNkIySjNoMGNFSWlJOXcyK0ROZEY3dEZRMVJhUGx0RTdqdlh0?=
 =?utf-8?B?ZWN4aXBNTE5VcHFVTS9FUW5XaEJRU2dXS1BCY1QzakIvYmZtYjE1MXhzdHZ4?=
 =?utf-8?B?SnlsYzZCdlZIRUtVSzF6bDhseGMydzhhZmQwY2x5WEY5VURLNllXckVmRHZW?=
 =?utf-8?B?bTlVckw3bXlDQmY3WTFoRVAwNlVYM2JxMkppQ3JiR05nZ3hKZktxM2tiUUlw?=
 =?utf-8?B?K0cvdE5wMUdlaG9PY0wyYjIwZHFRcmtuZ3BXYXI4K2VFWGFwRW5aNTFwcGdi?=
 =?utf-8?B?Zzk2NXFnMy9UcGFVUGhwdEVyWFpyN0E1d3I5SWNPQ2QxYmVacTVmYXhSRDRl?=
 =?utf-8?B?QmxrMTFnVjdHR1NldktJODVyUUNrNXZhZDg0c0dadDArSVB0OFVLc3NJK3c3?=
 =?utf-8?B?eVJLcHg2eUF3VllhNWpxaWsxR3pKVXRuUTdDRWI2ZXhwK0lmTEo1Y3lhYkNC?=
 =?utf-8?B?cjZHUDRrV0JPTWtacVR5QzFmNHd3ZzhDVUtwb3NhckpoYWI1enZqVG5wMlk1?=
 =?utf-8?B?RFlHak45RVlGVElnOUFtaEMrNjdobVJWNzY3MkZXaERuV3FuMk1qYUpXRTRR?=
 =?utf-8?B?MWtuZkFQOXNMWlVpTW5EM1J4T0tLaHp4VHp2Q1kyZHRjTUNjaXMvcG1WblU5?=
 =?utf-8?Q?+2x5vXFVPJf1x3+I3ddcRqARFHCcWoD5SjAcP0C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejJ3TU9mS3ZNL0x1YUI2cEhLdzlUOGhRTGdadnBBNERKY3J5aHpXTkRTeTdG?=
 =?utf-8?B?ZkJpRTV3V1ZTYmIxbGpCdkorUHVyM2ZnQ2lYY1h2ci91Y1lKenROMTRhRWJj?=
 =?utf-8?B?OW1jN1Rvc1phRC9xa1NoSTVFc3ZzMFVLQ0xwTTNhZkdyZ0FaNnJkSlR5SUZJ?=
 =?utf-8?B?YllnOEYxTm5LWk8yblQ4SE00a0h5TUM1OGwzZEk3S3daWHlpK2o4NmZQSkNN?=
 =?utf-8?B?c2hLb2I5eEhjczI3eVJTS3FrSC95M0dCbGxUTnRqWjJJWG1rVFRndW5Cc2N2?=
 =?utf-8?B?NzBlR2dndU5lRTNLaWkxNDNmeml2cUw4RDl3MkJrdVc2T0xwdWNHUm9idlo0?=
 =?utf-8?B?YUpzM1d1elMyVjFUYnNoQlk4aXJUZnEwNHViTEl1NllweVpGcjI2WWRRNUwz?=
 =?utf-8?B?eWFLYUNmd29OQjFWQVRVMWFBSGdOQU5vOExUOTJrazBFbFNSWTg1S0VUUllM?=
 =?utf-8?B?SjJ4VWlwMHErcmZwWllLRWtyUy9BcDVmQ2FDNGNvVHl2c0xmTDAwQXB3L2k3?=
 =?utf-8?B?NXFHNjkzOW52Z1hETzZxZDBSb242TFFVVFNaUUNUTEx1L2VuZTlCeHFkTlNN?=
 =?utf-8?B?ejk0WWUrNUgyWll6eUtOdmQ5aE9IQXRZRWNYeXlPQWxSejlwZklOT3N1QkMv?=
 =?utf-8?B?dVptTS93N3BLWm90SEVlazFlTjlXY3RpdVV2ckhablloWGdCa2RoNVQ3YURJ?=
 =?utf-8?B?RkRJbFkrWjUyaTNuS0REU3NrMkgwaVhER20yYUsxd0NQS3BzV09jWVNlY29L?=
 =?utf-8?B?T2NyQXZKcmwxbmNkZzBVZTJ2NFExOSt6SERrUUkyTWkxV3JsTFpoMERGMm5U?=
 =?utf-8?B?R212bSt4UU1tVWdONldOTms4QWxSREw3VUdrOVJNd0VJN3FwSlozaUd0cC9K?=
 =?utf-8?B?dnRCbzhSeVNuTUUrRWtRdlZmUE5XWnI5UTR3OUg3RGowNFlZYldzbDl6WklW?=
 =?utf-8?B?MXcvallxRmRDTjFYbmc2OGVwUlo2dzRzNWFpMGVKaGdJZkxvMndoT1NRTTVO?=
 =?utf-8?B?NjM1ajBuNGJpM0t3NTlrM3NYbzRsbk9HS29sdCtlNjRhRmRGeXZ6TGJNakZG?=
 =?utf-8?B?NE4za3pzb1hGcklwaGRJcVhvaktQT3J2SzRlcW40Rm9GMmQrRlVlWmlYOFVs?=
 =?utf-8?B?NGd3L0JmTGNGNmQ0OUs3VUswdGt1MEtMSFBPaVpnQk5yM3lYcjlpMkxEajdy?=
 =?utf-8?B?aHNGY09hZDRSTVJDRy92ME80QTQ2Zi93WnlISjkwbWlmQ0w0TnlzSFZtcHBk?=
 =?utf-8?B?cXo0T2Q4bVU3L0VQOHRoOXc5NG1rblZlQkZoWWEyaXN0U2NCYzFHSTRXOFJp?=
 =?utf-8?B?Y2k2Z2xCaENIdFZ5ZDlJL2FJVjZWNTRGeGQ5TEwwYk5uWkRObTVhdkJGZ1Bk?=
 =?utf-8?B?MUpUZndvSXZOVWNBU2VmNVM2d0JMay92TlhlQjRxSkl6U2svaFhyKzk2cnQx?=
 =?utf-8?B?UUZodm5LTEJHaU5OYWJDaGFNNDU2dW9KYlB5MGVNNmYxSnBBdlRVOHlaNEZG?=
 =?utf-8?B?UGxId2xXbytoYTdyL3VJR3FUWEd0a1lka2QwVy81TWREM3I0UDFEZmZTSHF4?=
 =?utf-8?B?TGZ2WWIrRmNkdmxwSjBUOThqaUZEL2NJbmV0SDMwcUZnTVk0cjU0ZWV3WEZV?=
 =?utf-8?B?dzA4eUhMN1A5TDRKUEV0cnljdFZhNkR0Qlk0dHZzcGpaM3ZnTkFORnBpa05k?=
 =?utf-8?B?S1FEL0pOYnFoMU5UOGQ5UXRzRHJHQi9OZUdLZlBHcFYzM1A4aUkxMUFsejhS?=
 =?utf-8?B?ZmI1VDY1cGNSbTlJeGw1SE1seHVJK09IcE5SdUdSa3V2cHlMcUlEeEpDVDJJ?=
 =?utf-8?B?T1lPTUh4ZkhxbHh2VDNTTDQ0RndFU25ocE80TmxFenNMNkgzZVVxSGVIZEYr?=
 =?utf-8?B?UUNRVVdOelU2UTMzZXBJMC80c3V6cVRsODI1cFYyRlQ4dS9laTBrU0dENTh1?=
 =?utf-8?B?MmdOU1IwdkVpSTRMU2I5Lzh6ZWNleWFSR3pnNm1PUnpKUmY3d25kcERzZU1F?=
 =?utf-8?B?eUhTdTJjQy9pV1lhcnh3bHQ3K0dnQjRNZHFCSFM0ZU1zbmJ6OWtjYkltN1NK?=
 =?utf-8?B?VDNVaFZNWWtIbGR0V29ZSDhmMVNCdCs0VmtMZ25OcVZNRGJMRmI5eDE1NGF4?=
 =?utf-8?Q?rDJLwcjP02ksQi1jYGGcnqEFC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bb1221-6bfd-4c0a-b98e-08dcefa90fc1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 19:14:17.3957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxdvb3lxBUqzjkYUz3cFKhBSGdfrUo+VSUaUfwpJ3g5jnxiecfP/vVAAoCicINDArIVWR5laoRrA7t95yjhKGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715
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


On 2024-10-11 10:41, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> kfd process kref count(process->ref) is initialized to 1 by kref_init. After
> it is created not need to increaes its kref. Instad add kfd process kref at kfd
> process mmu notifier allocation since we decrease the ref at free_notifier of
> mmu_notifier_ops, so pair them.
>
> When user process opens kfd node multiple times the kfd process kref is
> increased each time to balance kfd node close operation.
>
> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>

Thanks, this is an elegant solution, IMO. The reference returned by 
kfd_create_process comes either from find_process or create_process. And 
the extra reference that gets released by the free_notifier gets 
allocated by the alloc_notifier. I think there is a race condition, 
though. See inline.


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index d07acf1b2f93..78bf918abf92 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -850,8 +850,10 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   		goto out;
>   	}
>   
> -	/* A prior open of /dev/kfd could have already created the process. */
> -	process = find_process(thread, false);
> +	/* A prior open of /dev/kfd could have already created the process.
> +	 * find_process will increase process kref in this case
> +	 */
> +	process = find_process(thread, true);
>   	if (process) {
>   		pr_debug("Process already found\n");
>   	} else {
> @@ -899,8 +901,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   		init_waitqueue_head(&process->wait_irq_drain);
>   	}
>   out:
> -	if (!IS_ERR(process))
> -		kref_get(&process->ref);
>   	mutex_unlock(&kfd_processes_mutex);
>   	mmput(thread->mm);
>   
> @@ -1191,7 +1191,12 @@ static struct mmu_notifier *kfd_process_alloc_notifier(struct mm_struct *mm)
>   
>   	srcu_read_unlock(&kfd_processes_srcu, idx);
>   
> -	return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
> +	if (p) {
> +		kref_get(&p->ref);

This should be inside the srcu. I think you could use 
kfd_lookup_process_by_mm instead of open-coding the SRCU locking and 
find_process_by_mm. This does the lookup and reference counting safely 
already.

Regards,
   Felix

> +		return &p->mmu_notifier;
> +	}
> +
> +	return ERR_PTR(-ESRCH);
>   }
>   
>   static void kfd_process_free_notifier(struct mmu_notifier *mn)
