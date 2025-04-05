Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168AEC36010
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Apr 2025 07:18:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB3F010E010;
	Sat,  5 Apr 2025 07:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YOUhM2LN";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D4BE10E010
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Apr 2025 07:18:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhXvu+NLm8CFoiT9eRk/dusQJlnGnTLOwzq/GYm2iO7zSvvrzfS9sgfhBuusdL2r51kMkb+HkEtlmhMUJCNH+579gNkuWzOEKMXaxw/etDO7bwG4YsBHJ+DdGQ2NFLIhFjKQyeJ4OrDBxxR+nBLMPQR1gCwCZGHg3h4FehiLDR3xCN8XAU2ZbJFot1K95DxgNQ+gHxwF9XfPInHwKUOtY0GYAGwHgY5w4EOujGhRdwsKY8MRAz93QTHhHaOp8AE5lJBDatWkOyEs9F2fho8HBQkKHkea8jZ/l+TF+Ce/5yyQdJsUzZMZMqbArbhBHjTjlwuuk6IBKlpV3lOCXAAlLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzhpNkGKau65mCgKxkzfjphxk7ZtUcgYQWxSYjjpcrQ=;
 b=lzlsAog8RFqgZEifggDF6ubCD5CpOBbdRsUljP7kVFCoE9F55/SjUMYHkkFxnuaizNeIm6+FTia3niJJfCExCJTXKdqGVl1P1VUiC8ifNS6aU9XE3RoGCkjuathztCWSylZGpgsi4Wo5rlI4Aa/K6G/d3r7mo3CEVI2zAINtLRmYPizyoHFL88sVSAbAZUg8VS3VuzHEylTIkoJtCRX4yHDdeasgydQ8SQfRgjI9k5rJvbQtUVCuSn8LeD5ZfxgSKBfj15L0knLggPEgmSTbYCWRjjoDyOcnFycsIXZPFuv+yXejeFn3UxWBh0kYpxUug51aflto83thguXG4MoVNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzhpNkGKau65mCgKxkzfjphxk7ZtUcgYQWxSYjjpcrQ=;
 b=YOUhM2LNbT2j09igQkmRejI8Q0Ve6G2DkJ9IQFBlqglSaQkr0okvloJDmu+WT4F+NTaegRoZoJiR/Cx8MVJGiWADal0Gx4wr9QElQccSIhM/TlCgihctGTVY4liZ8pbk1stkKeej6r237mv9/qV41fBPWiQAnCY0l/+wv4R+Xtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Sat, 5 Apr
 2025 07:03:09 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%3]) with mapi id 15.20.8534.045; Sat, 5 Apr 2025
 07:03:08 +0000
Message-ID: <e3c8a39f-9df9-42ae-ba42-ee5f32c6407c@amd.com>
Date: Sat, 5 Apr 2025 12:33:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: use a dummy owner for sysfs triggered
 cleaner shaders v3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250404141607.1451-1-christian.koenig@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20250404141607.1451-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0086.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:268::11) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 430399f2-5170-42f6-9f38-08dd740feb65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0o5RmUwTDM4dnNYWVhweVgwV21UajFNRDlJd3hNcVNoSFgvQTNCcjNsVXFj?=
 =?utf-8?B?VUFOdTJJTkp4MHFwOEp5aHNIZWVTelYwb3RKOHFJYjd0ZFFXQlFRU1ZBbVpV?=
 =?utf-8?B?UTQvUkdnbWtnMmZ5VjdhNDVlMG9HUWRFNEdpRS9UcitSSXg0RFJwcGljYzN6?=
 =?utf-8?B?MEorS3k1b2xJOVlTbCt1dktYYkhpYnlsUmpuZ0toc0orV0tTKysyVkI3RWE0?=
 =?utf-8?B?aG9idDJqWWRlekxRUlZ6dXE4WTBrd0hUVklPcGdtZmx4b3BFMGZuNHdTcFN1?=
 =?utf-8?B?c1VPdVVFTHZ1SzByQ2NybXBMN3hRSGx6SnRNbHFBYk5HeU9kTDZ4c0d5Y2Na?=
 =?utf-8?B?NHg5SElOL1RNSGhpaDZqdk5BVndjaHNQQkErZVRKMWZ2bC9EYTUyZ1pXVFVO?=
 =?utf-8?B?RHNwdVVpd2Uvd3QxNWRFTHRyRUtOVm1IaGw3UGVXZXdXZlY3ajJ5QUpjTGx4?=
 =?utf-8?B?TmEvTGQyTTNVVTk1NVdBWDQzSGEvK3Q2aFJzRE1KelUwelVnRllGOXN3aEgz?=
 =?utf-8?B?a0puVU4rR242RkNMdlRCWTdzN2Z3YWdyZEdxeXNIdWEyNkU0YVoyb2dVbDFk?=
 =?utf-8?B?RmQzQ0VSaWV5eTI4QWFFNkxnaG1Kc1lPNG9yRDArS0FNcUhLTTNVN0lVYnJn?=
 =?utf-8?B?bHZ0aENoSVA1N09pbUoyQlFHUmJRN01waGFzMnplemFNKzNVNmpZT2RsZlAw?=
 =?utf-8?B?UlV2K3BEZGxCNVl0SkhpM05jb0ZycTZTaTZVeFdUSmlESml4Rmt2eUV1WWhR?=
 =?utf-8?B?SnVHMzJGMWdxY3h1N014anowUDB4SjdXS3FQdTFjQkE5cXBCb0lpUjB5QlpC?=
 =?utf-8?B?S3paMkVNckVxTG1Bci9SVWV5MHgzamwzMVZYZ2RHY3J5TnFjYUVubEkvSGJy?=
 =?utf-8?B?ay9qR2lKNzQvRUtKWEx1SEpWSHM5NXBXVW1TenVkVVB6OTJzc0xCaUp3YmxD?=
 =?utf-8?B?TVU1Y2tlRUxpMCtIUlFucEFkNWNrUGlqN05QRFh2ZmNzclBKa0xaZ0ZJbWtS?=
 =?utf-8?B?TFlzK3pjNnFlZGh5WFVZSk56OWxNQU9NYlNyakdHcWxGb0g1cGVTWWN4Z0d0?=
 =?utf-8?B?WmRBTXJpYW9WakJCRnY3c3pNbjVhdUdpYVAwNkg2VHZrMWRlTUxxWmFFSXZU?=
 =?utf-8?B?bk4xeU5HZ09OSXZ1RmwvQzBMRURvV2poMVZTVEtncHVPMlVjakdRTXZmMkRQ?=
 =?utf-8?B?SFo5bml4RlFsanJlTmRnelNhTUdZSUp5WDB1T1RtbWhLYnprb05UL1gvK0hN?=
 =?utf-8?B?bGd2VSttK1ZVaVhkNWNGUmdITWttNm9iOTQ3Q3B4dUl5NTg4NHMvS3MwUVU0?=
 =?utf-8?B?SHpBbDAxdDZGR1g4RUNRL0ZGeFIyZmhOdisyRU4wZkRsV0F6MXNweSt6Zk5F?=
 =?utf-8?B?M1VpaFIwR0k5VlhGN0tnb05wM201V3J2bG1qVVJXUjlDRGw2ZEdleWhMN1li?=
 =?utf-8?B?NTlqYktvczhZT1MxZW5KK1c0d2N2eWorUUEwT2txWUJHK3hFeHE0NDRsNjE0?=
 =?utf-8?B?STdIVzNzVkF5RjZJUkR4d0w3UHBER0JDY0FUSDk1aTdnVTJNU3FuNU9JMzcz?=
 =?utf-8?B?V21vekx6bW83U1VFWkZKWDJlTERCK0xzR3puSFJJSVYxMVNKdEF0eTIwZ1Ny?=
 =?utf-8?B?eWVob3g1VjNzUUQzYzlqdjNPR0srR1dtRFUza1lQZWJpSjN1WFVZKzl5TjhP?=
 =?utf-8?B?eWJVWjhqejBxME5tUXp1QktIOFhCM3BpRFJkMHR5NjF2cU90dWxXb3BxcUsy?=
 =?utf-8?B?Mno0MkhBZmJnWmtDTFdmbXNMb1o1MFZKd1BDY1hYaDNRcWduWnRwV0JpSHJT?=
 =?utf-8?B?YWU5MEJ3WlZkQjNWVC9STG0xNkd6eWp6TDMxTzRxcSthbk0yallKZUh0OTZz?=
 =?utf-8?B?SjNBVEh4WHZLUWxMOWNjdmkyRGJBUmJybkg3TjdFRFFrYVVRY2I1THhaTnNX?=
 =?utf-8?Q?MGZ5i7oOhys=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHZ5ZnZkRml5L05iQVhiV2phaHg2bjZmR0hYZERaU3NiWUtyM2hqWFByUWgv?=
 =?utf-8?B?NlFuS2NDRkJ1V0NwS3Z2RE1rdU9VeFVuVlE5L2hGY2o4T3J4dStOM1d2OU8r?=
 =?utf-8?B?bnFqM3lEd2kzTnZ3Mm1hMFdsYVNFYlQxRUczczVobmNhbVZ2aENsOUlHVG1O?=
 =?utf-8?B?Uy9nclJ3eUQxeVhvR0xvVG83K3A2Y1IzeVZjemE4MVB2NVh4N0JpdElmaDdh?=
 =?utf-8?B?aWdya3JKVGY4cnJiYXA2WktxbGtoMGNCZ2Q0YVBJRzRwQVNFcjBjRWs3eDZQ?=
 =?utf-8?B?RHpWSU1vK0paR0ZFVkhhRFBHd2tNOHREOVMySlBwb3hUTGpwK3gzSGlnQVJT?=
 =?utf-8?B?WSswclUwdjU4ZjRjb2hIMWFTRjVGV214aDdyWC9KR0tsdDBKQzVnempkUXlM?=
 =?utf-8?B?ZFBqdVl5bEtUUzlKSFlJaCtiTndqK2tZTEV6Z2E3RDRyMENzQVpJSG04OUJ4?=
 =?utf-8?B?dGFGY1c5WCtHckRpVWxYQTdMcXVzM1RqWWJoR3ZFYzAvbmZtNU5hKytsR2dm?=
 =?utf-8?B?eC83VCsvbndPdmY5aWt2Tmd5WHlkbngzQmp5Z0h6QmsrbENPN3VramtaSHY5?=
 =?utf-8?B?YndsR05xeDY3Wm0wZXo1c3NKdW92SmxXOFQ1c0xUeE8vcGtHMDJHTmRpNktQ?=
 =?utf-8?B?dEpaN0tJL25vbzJXdytGMUsvaHduMGRuQnAxbUZ5OWpyaCtnTHR6RThKSE1s?=
 =?utf-8?B?SW1vVVd4V1pGQzRLZkNGZ1NuR1BoK2hSaWhORWlzRmRkTVpuVzcyODlOVEZC?=
 =?utf-8?B?OE85SU5MVXE4anE0bE5GZ3hMTkNETlF2aTVqVUpHeXRLSG5hOGVuRkhWbGV1?=
 =?utf-8?B?MTNENk1GeXIzb1N2SVJ1RDlDWXJiTlowSUVKUzlzWk1KamI4VWlTK2lWdDJU?=
 =?utf-8?B?K3lrazk5dVZrNWVocGpZZWw0UTdnVlVkbUxYYkhkSjZnM1A1Ny9Gb3NWa2Jk?=
 =?utf-8?B?OUpLUGx6UDVPaDNVL0RSN213NDhCQ2xaK25kMW9tdkY3eXBaNjhCOXB5eUJJ?=
 =?utf-8?B?VmYzS0tleEhOam82d280blluV2RrQTY1aWdka0x0M21Rc1dOTU1PWHRKVlZQ?=
 =?utf-8?B?MlpFN1BWcUM1OENGY21pc2NPa3ZQSEJHNEFneGw2cHR4eXovNTc3VEJLQUox?=
 =?utf-8?B?cjFuVnE4RlBTK29JV0Z4MVJtQjRPbzhtZ2pEUnVOTk0vYThjcFRBOFpoVUtt?=
 =?utf-8?B?Sk83L3ZrcmNNek9sbVZQSFVKVnpJR085R1ZYOHhyeUxjVlUyUmNZcVFFOGVK?=
 =?utf-8?B?R0IyQjhPbFFBRUxTb0ZMUTVZblFQN05DdjJLZ0NDQ1JRQ1Yya3V6VzBLaFYr?=
 =?utf-8?B?NDVvUldNZ2pkZDlqUVNqN05OQmJ3eUpLdHBkbmc5aWs4eGprRno5NkpmMDBy?=
 =?utf-8?B?THQ2a3FHVGwwdU5HRnR2ZkxPa25HR1RhdEpjOXl2Q0ZxVlliK1g4bUdzc1I5?=
 =?utf-8?B?WVlSdmpYelN6ZHFOQXBma09taEVQZ1YxYnZRSHFLeXFsTjhIU2ozSVJoY2Q1?=
 =?utf-8?B?NTUxM1ZJT2RwMVpzcm1sQ1pxQ0FaTE1WSUJ0cXAxZDFtbnE0S094Q0ZRLzVo?=
 =?utf-8?B?UDVRd0ZBSGlDUENHSUJnUm9kZ2FzZ2lTMDYzOFNDU0tEd2ZGOVNCSkJSNTVI?=
 =?utf-8?B?VG1EbHFJZ1RtS2dKa29jbXFxbFRCQkxsV1NzNVdDcHFZa25saFAvSlU0UzdS?=
 =?utf-8?B?RnN2QkI4TmlZTVh3MVZLRk9TZHdFbWtIQ2pPNklxQkM3VzRYa29JZlVNQ1h4?=
 =?utf-8?B?WUd3S040NTBZNVNJS3FPNlpFaGlIR2RRaVFCVzJMcHhrQWVUYzVoaG1MdXdh?=
 =?utf-8?B?Vm04UnpKaUx0a0Fza05Ob0dxaFF5Qy9SNCtlUUdxbUUvdFJmWjZxTWpkNzk5?=
 =?utf-8?B?T0JMNWNhVFUrbHI1bzE4ZzFUTXJVUk1nZ0NnVWY3SmpDYVI4SHNGcnZKdmRP?=
 =?utf-8?B?NUhtT0E5Sk5MZ1JGT1VWbmxaTG1DajJaMDl5aUo3SUhVL0FRZXhmamFvZHJ0?=
 =?utf-8?B?VGJ0WmtuQTRNNFp1eXRqKzVBNVJ4M0lVQjFNVWlwVlIzcVliV0pkaGZzWVh0?=
 =?utf-8?B?ak9mY0JSbUNQTDF1dXgxQ1Z1SXZ0SllMclUrT3p6bytIaCtGTW9sQTFzQ0cy?=
 =?utf-8?Q?smPLvXFgSDzaPNNVN3H+XXHZ2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430399f2-5170-42f6-9f38-08dd740feb65
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2025 07:03:08.3172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNhS5FvMJPbQQ8MBztzJNvXytrAhcOFHqTg8HW0B5kvEOiRCOTZYvqrQcw6S98GFRJ9deu5h4iw9B2K8JcANWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464
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


On 4/4/2025 7:46 PM, Christian König wrote:
> Otherwise triggering sysfs multiple times without other submissions in
> between only runs the shader once.
>
> v2: add some comment
> v3: re-add missing cast
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index f64675b2ab75..76237961a08f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1439,9 +1439,11 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>   	struct amdgpu_device *adev = ring->adev;
>   	struct drm_gpu_scheduler *sched = &ring->sched;
>   	struct drm_sched_entity entity;
> +	static atomic_t counter;
>   	struct dma_fence *f;
>   	struct amdgpu_job *job;
>   	struct amdgpu_ib *ib;
> +	void * owner;
>   	int i, r;
>   
>   	/* Initialize the scheduler entity */
> @@ -1452,9 +1454,15 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>   		goto err;
>   	}
>   
> -	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, NULL,
> -				     64, 0,
> -				     &job);
> +	/*
> +	 * Use some unique dummy value as the owner to make sure we execute
> +	 * the cleaner shader on each submission. The value just need to change
> +	 * for each submission and is otherwise meaningless.
> +	 */
> +	owner = (void *)(unsigned long)atomic_inc_return(&counter),
> +
> +	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
> +				     64, 0, &job);
>   	if (r)
>   		goto err;
>   


Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

