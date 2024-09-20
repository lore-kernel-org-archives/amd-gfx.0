Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B1BC78820
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Sep 2024 10:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D61B10E804;
	Fri, 20 Sep 2024 10:37:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="28/NCZIq";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81BF410E804
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 10:37:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+zDKZhmLYUA2VJ4DVKzlytam1q9ywxMkYbWlTuPi3FzhQHkaywGU93oJSbqfoOiD6afe03izs8BP8cbr5I4xy5qCcJ1KsG7CP4DkpC26qnZFNnVDS1Mf3Bxd4zIEEFksUlSULBU3MtNOjS70Tbnnrjgr8zgiGGc9iS3YjD+DdNL3fdPh9OeRzhLy6/l1eUiIv+775RtP4n9JaCeNZIVwL7WbR+/aJJtTf5KmZg9Nah0FCoPy2ECUv651Vw8turxDIiLB76MJGX4R8L85vpovy+MzhUn9P6PaLzTzbobP3qhMkqit00Mew5H5EDDZ/sieH6//DoS0ASzl08z4ubPfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVfuU6AGjxJDOuT/tb9aShoRCweBPqGNdCpipuCSaEM=;
 b=mlFDQRnViWOzhl0ro6r2m6WEJuzDJiSMuZ3yEPGDdm5hDuxGhSy2/wq2hBYh7M8yfM1vacjW26313B912ACNAfs/O9jBMldpJvJW7yrYwR46KQVhau40t1efNXT1mgO3Fe48QlmCI1h0wTNHT2EBxm2ThWUVQYm6ZRmV1RJXYToYDRuXXrV+1cnc/3pYbrxA0gSPjOlyIvsPVsAMgWGyLVwC5OVKkqlgpbgggBA9zjpkSlYutT9nlVc21vL5T6gMkt/Q3EJliJnq0BVj4p3qlvESwA7QXoWMaOMvtVmt3qvscyRAWevf6swpMI7eIhrYMqmvzBz63VpP4Z8+3ylOrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVfuU6AGjxJDOuT/tb9aShoRCweBPqGNdCpipuCSaEM=;
 b=28/NCZIqLNEEsqtdZt47Hs+YcPnPA48PtuCcnaHgVhw7UaxXCBbDvLjqiuHUsps6af5MbqVuVSO7p7w0qiOWZeajCP8ncTYVJHrw7aWod5GR7xAsIE5lloQXVqKxgDi6mpxgMn8p/bUIqUpCbE8YaNpGCm8xWAEsR/GHSMUJFGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 10:37:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7982.012; Fri, 20 Sep 2024
 10:37:18 +0000
Message-ID: <9f5c66b0-47e3-4e94-9ebf-6c87f8b500ac@amd.com>
Date: Fri, 20 Sep 2024 12:37:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd/amdgpu: Reduce unnecessary repetitive GPU resets
To: YiPeng Chai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, Candice.Li@amd.com,
 KevinYang.Wang@amd.com, Stanley.Yang@amd.com
References: <20240920073607.109275-1-YiPeng.Chai@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240920073607.109275-1-YiPeng.Chai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0386.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5cd315-74ff-4612-db38-08dcd9603395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clptZEN3RGdob0hJQjlzYS9KWXdiRXVOVTcwcytZaWRxYnpMdmNJL3g0RUtC?=
 =?utf-8?B?TmNHVEM0T3F1YkdtM0tydWlLdkNtVUt5bTJReHkwczlqTlM0VjBQcVZDMzZv?=
 =?utf-8?B?eERBbmpTOEkyd2NsS3I3SkNjekVvNmNhYTNLRmQwTFVNVnFvdnV1c3NrNUQz?=
 =?utf-8?B?SzRMZHlvNytVNGpGemN3cjl2UVpMNy80MENkbHpUTmh0Kyt2am9tWmkrQ2JH?=
 =?utf-8?B?bzJYZHBnRWw0QWxWSVpyQ2ZFRHYrQVNBQmI1cWZZOENzK2Z1SkNudXk1V3Vs?=
 =?utf-8?B?SEsrOENzQnZYS0MwblhTellqL0VURmc1MWlBWXVzckZpdHRYTUhoOFAxK2pE?=
 =?utf-8?B?NHhPamRmbWFReEFJTzRZckkwOE4ydGhzeXVzYzJJQnZPV2xVbWlONzk1OEpt?=
 =?utf-8?B?OWNNclRKUkR1WTdWWXpjeWFDZzNmNkNFNXlFVzg4S3NNSHppR0wwd1J2TFhI?=
 =?utf-8?B?M0p1elQ5TmpIZkhqYWQwaXJCa0ZBOWFsODJJaFYvK2JRSWdkbS9Dd1BjbG5z?=
 =?utf-8?B?bXRucFlIb25PRm1xZndHdGVWZ1FvZHQyNUgzS090emtPbTFnSGdvOWRxWHpB?=
 =?utf-8?B?aHc5RDVQMzVIRmR5Q3NnbFF2Y3lKRjVwcVVkNWVzbEhTc3ZJekovb0p0M0Zi?=
 =?utf-8?B?aWp1enZEMkh0ZkREWkN4SUNaUFdVdGJqeHVkWk5WUjZFaVdZdnFuYUlIazdx?=
 =?utf-8?B?V0NLNlNqQk5FVnlSQkdlYnhaa1BNcjBvcmNuZzh1VVNwNVlHZkhsK3liaWZ6?=
 =?utf-8?B?cUlnSUpmOVZ1Z3VqM2t6cGloczkvN2hyWndEeGZCTU92dVZmdFZLWDZ3UXVW?=
 =?utf-8?B?YkdwYjNNdXpoNDluSGVZRkxsU3VvT3QwTTlhWm9YSlQ4V1VURUswT0J1a1N5?=
 =?utf-8?B?OVloVXVIVzlzOXF4VzlxS0V3ZTVVcnJLeEE0aTF1a2tOSjRpZGVjaWhGTWFI?=
 =?utf-8?B?aW9aNzVlaS9taVlHUkkyL3hVR0dDa3NYV0tLVXcreGpwL1lweHp2RFltYzFq?=
 =?utf-8?B?ck55dGJ1MDMxQjNXUm9rbE0rTWgrUVNGMUNyaHl4bk1Sb3lYZDhiRlIwNG5R?=
 =?utf-8?B?QjZmMkkreHNUcmxLKzZYL2VkYXZIYUtEb0F0UUdIc1lBZGN4cE14SVpnL2w1?=
 =?utf-8?B?Zjk2eW9OdGlLdHFab0toQ3JzdjZSbjVjN2t1dFUxcENFazNBbWFXYVl3ckpY?=
 =?utf-8?B?OTdwckxhY2s1Zzh5TWVCckEyR0hWS1BRa1krMHZVS3RVa0R1b2QvY0F1NTls?=
 =?utf-8?B?MTZrSXhWelJ3SXZpb1JCVHdRWkViTm8rY0xqQ2RYbEpXd2Vsb0FiMUxNQWN3?=
 =?utf-8?B?VHFzbThTSjNEcVlmckVWT2dPZmRvTC9LcGt0NHFDZFRqdG5id2huSzlseVhp?=
 =?utf-8?B?aVd3Z0RyTTVqeGtwV1ZqdUZRS3gyS3pJTjlyclkrQU1mdmpoVTZlcTdwVzN2?=
 =?utf-8?B?aFZiWWlJR3ZyU3lLTzhkODN5bHhDa2QvdEIrMERtYUhGcXNMRU9IV0tXdFlF?=
 =?utf-8?B?ZHhrQWo2andyN3NwVEdMOTlwUmdiWTd2QXBQNzRkWGUwb2hRdVBoejZheEFQ?=
 =?utf-8?B?cENjVUdBS21IakhvZzg2WFpaaDh2M1ROajlPM2lIYnhST3cxbEo0WW9TaXkx?=
 =?utf-8?B?NHdJQVdJb0pQSW1GbmpsbzEwbzkrU1A0eU1GVmdmV3FWajczdzlub28wT1Ix?=
 =?utf-8?B?bmVmRzNOUGNxbGl5YlZRdjNSWVEvYzFvazIzS1VwNWYxMHp0Y1ZHN2tjZlZG?=
 =?utf-8?B?MkdtY3M2MjNDb3JUcUR2M1hFYTlpMitUNHorRjMwSUUvRE5yOTRqWjdFaHhV?=
 =?utf-8?B?RW1vL0RiWnNxM0U2clMvQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXdRVTVFVXF6bmlpZVgrQlNCL2hBSGU1UnFEVHhEYzhpQTdyd0FWR1ZNU3h6?=
 =?utf-8?B?OTNWK1AwNVNBZFpwa1pOeG1HZlFQZTRhZ1ZUc3puVGhvZEh2QkI2VzJEMDgx?=
 =?utf-8?B?UnZqVHFPbTM1R2lUaUc4dTVnYjBJRkZGOFRvQ0lOWGF3a01CT3o5NzliVDVG?=
 =?utf-8?B?WXNMbWpKL0JFUi91eHZrNklKdG9kREQ1TUZTZVEzRzVjQUFpQnhqSTYybm5n?=
 =?utf-8?B?WHFMZzF0cnBRUGUzZW5udmJWRDQyUkVKSFBjMTV6ZGtKZUpPZVpsSCtlM2xD?=
 =?utf-8?B?TVBvVjB2Smp4UnJncEZtWnNhMmdaaXo0K0pzcllKVWVnRE9CVkFCd1piRHpZ?=
 =?utf-8?B?UVl4Slo4M0NsKzhScFJRbHpsMnVoYi9EamVxSXIxS0Fyc1AwdXhYS0g2NlJU?=
 =?utf-8?B?WElaYWFhU0IwcnVVY0dIazFuVExwbmRpL0NOVHpjcWRBRm5SSXJuYlVscGZ6?=
 =?utf-8?B?b29sZnMzNVdHT2hjOU1mZ3hGREg2aVhuWE5hZmtvdTFKMXFaZlNBV0tlTm5U?=
 =?utf-8?B?ei9wRk9BQmpWVXp6ejBWZlUzMDdpbHlLN3JxbmNiYk5ZZU4rSzcxb1NBZ3Zy?=
 =?utf-8?B?REovMU5JaU5WMWx6WHg0UFBhdXpuY0xtRlZDcytTc21xRnNKWUVsUE5tQUNO?=
 =?utf-8?B?aEthWVZJdlhUeGZZOVBjRTViYnZ1NU8vd2RDaHRyVlcwb1lQb3lDdElZSjd4?=
 =?utf-8?B?a3QxRmxwaGw4U05RdmRwWHVlSVBqL05tR204LzdkcTZoWVhpeGt4a1ZmWmhG?=
 =?utf-8?B?Z0pLamdpVmdIVFI5ZlVRODBycy9JNllSZ3FMeWpGbnlsdHkvdWljYlFrZDNF?=
 =?utf-8?B?dHI2TGQyY0xsZnBMQVd5MEZ4aDRKSEl2OGsvZXhzaTU2ajVJT1J3allSS3Qr?=
 =?utf-8?B?NjdjSWpyYWNiY1d3WlkrU1lSMndESEU2Zlo0WS9sc1lmbFdRc0RYczdtWmVT?=
 =?utf-8?B?YjJ5Y3FoRHFCNXdCcDdrVkJXeHNPWEt6enlINTFrOEVsSm95TjFReThUTjNX?=
 =?utf-8?B?MlNsVzQ3TjkrbUJhQmVwWSsydGFEUTBVSnUyenN1cUpsUU1KRzRzUFM2RE5H?=
 =?utf-8?B?eFdxRFZlRUtrb2ZBQ1JnMW5Ya1JTMldMdUFaV3lRSjZ4UTV0QlRBUUdWVXlZ?=
 =?utf-8?B?WkZGRm9yeHhVcVRySGgwa3NVTnF2TTdEaEhPOFk0Q2Fqell1ZnF2d3ZrN1ZI?=
 =?utf-8?B?TGZSMHZsOGNJaVZmQjBZS0s2d0pqVFo5bFdVbWRGWWU2bkxCWnZsTE5CVDVP?=
 =?utf-8?B?WlZ4TkhFY3h0YWN1WDU2cEFUakROb1J5SkZEYjgrOUhCdHNISkV1WTJwSFht?=
 =?utf-8?B?VmpGRTJVekE2YUYxTGMvaEd3djRsVVhMc0diQ0tub2JFcWwvSXBoUDlJZlE1?=
 =?utf-8?B?MC8wRFZyc3dYQnVpbysrUk1pbTZaSkRhVHNKSG9nNmZVbFgzUmhWVVZtcVhM?=
 =?utf-8?B?dUhlSm02cTJWZ0lQY2ZkcVNFUWgxcVBCZCsxaUYxaVMwVysxV2c0UkNHTWZi?=
 =?utf-8?B?K2F6MGFVd0x4QWFNYnEvVHU2WU81R2R0eUcwTGRTV2s2dGMrVHovdSs1dFp3?=
 =?utf-8?B?cS9Wa2NteVJuVnZGNE0reWlvbWtIQ0tjeSs2L29QYlllcGZKQ1dzUVJnZjVY?=
 =?utf-8?B?L1VVcHR6Vlp3RHRERlBsWktmQkNnRzNzNktQaWpzeWFZTEJ6TGxqc0dwUnJJ?=
 =?utf-8?B?dy9iL2lQT0p1cjVsQSsveVBVTWNlSFVpL2VkbnBFdUQxM1hWZ0E2ZVQvbWNw?=
 =?utf-8?B?clY5SjJGa2ErcVZObW1aTHQyMXZxWU1LVzJTNUxMbjhhVFJyNWNHd1RuOWRE?=
 =?utf-8?B?VGNoRG5OMmdKQWU5NUEyWUxIZmtEM1N2SXVBd3FWVXc0QVYvWWFqU09iVVhp?=
 =?utf-8?B?QnRRdVV4STV5V3crZXBaNlEwUDl5OE95OURxQ0tMenhqY011OUtLcWpxZ0Fj?=
 =?utf-8?B?NzBLOVNpcW80RXdSU01VZEZ3VGxDajkyaUVrZ0RBYllXS3NSOHd6Y1YvWk15?=
 =?utf-8?B?Z2JaQmxKVHNhU0JTZFJHWVcxN1lSWHg0TjdpZmFHejV3d09yR1htck5NSzJQ?=
 =?utf-8?B?VExCa1FZditsQm9WMXlDaWFEMnJCVUpYL0JscXUvMXQ5QWlvNWpvUlF3a2w1?=
 =?utf-8?Q?GOVk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5cd315-74ff-4612-db38-08dcd9603395
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 10:37:18.7175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjKSpYf0L8YojAcMCKJdLyfHuP7HhKUXjvEnXVsxcCUhewfzyYPSMQtoWAdDAqyV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146
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

Am 20.09.24 um 09:36 schrieb YiPeng Chai:
> In multiple GPUs case, after a GPU has started
> resetting all GPUs on hive, other GPUs do not
> need to trigger GPU reset again.

Please drop any such handling. GPU resets in a hive are serialized using 
a single thread workqueue.

If you want to prevent multiple GPU resets you just need to cancel other 
queued up resets before or after resetting the hive.

This handling here just duplicates this logic and is therefore a clear 
NAK from my side.

Regards,
Christian.

>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index dbfc41ddc3c7..7d48541b03d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -4306,8 +4306,27 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
>   		ras->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE1_RESET;
>   	}
>   
> -	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
> +	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0) {
> +		struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
> +		int hive_ras_recovery = 0;
> +
> +		if (hive) {
> +			hive_ras_recovery = atomic_read(&hive->ras_recovery);
> +			amdgpu_put_xgmi_hive(hive);
> +		}
> +		/* In the case of multiple GPUs, after a GPU has started
> +		 * resetting all GPUs on hive, other GPUs do not need to
> +		 * trigger GPU reset again.
> +		 */
> +		if (!hive_ras_recovery)
> +			amdgpu_reset_domain_schedule(ras->adev->reset_domain, &ras->recovery_work);
> +		else
> +			atomic_set(&ras->in_recovery, 0);
> +	} else {
> +		flush_work(&ras->recovery_work);
>   		amdgpu_reset_domain_schedule(ras->adev->reset_domain, &ras->recovery_work);
> +	}
> +
>   	return 0;
>   }
>   

