Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354DBC54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 09:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EC3D10E02A;
	Wed, 20 Mar 2024 09:43:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wAlZjmWB";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A828410E02A
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 09:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvMoGvVjsu8STHifnHlmVWCRoyWa1e+ZwVO5ye/MbjNviwqrcNiuJTXW3DbBdVzSLr8fBVg6mecD7Hssx8hmjG9tVXC/4qFhe6cf5ds6hLgV+Z/kkqi5DKEKwMuik73ZUSEYUM00TpPj/+OVKQxaiM+Ig/3jNNrqt8hc7zs/zkMNk/Nx+xyR36zV8i9fFTfEWrMX5wlKBNLRg+TsXLeh2ItNKRSUVI5fMDBox22tAg1UoxleIxCBsGR3vrQQ5AsECz1FGx9l/wdq2Xq7gEorNywdv0moNlji+TSQNRHxEtefg0nkkL93anb4FF/+JDjkLanlJbsr0uMePUHcyXvYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wvWAxm0AWCwajRFp7q2ewTBrqOc8UlOD+Yh8Kf3cds=;
 b=Ep67udg6asX9D4+qtXyKv1qt1c4hwt4y4B62JqWu9Vd+a/natFS2HJx4YW+Uf7vGE+ZLYamrOHOOAcgx7T+q5xZH/b+lXK3RLnajyftTuu7w3mxzC2WmtpiMioHRuh7aqa6fuNGXeJKYHcfk3nyLR/kPbOjAC+qATuVwl9eYj9bP1bYiTRAeTtOGQfKrWtG03xJa872SJJpQr5Rt9HufGZcz4dgiuDQBemJq9AbiucRlU+S19rLTCH+eLRYLpaW7S/PY7cmMpoRyqxOtwbCbmM22RWScZdLynCA4ajv85FK5mJJaOKLVSmbbH5FQuyICvxAdUupkJOuugmlB+LKwpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wvWAxm0AWCwajRFp7q2ewTBrqOc8UlOD+Yh8Kf3cds=;
 b=wAlZjmWBhvqFlo91F0+BHWmuFV7M0ydji1hbdgVmOzUiQiS0k2HDhG+sf6zzbL6Ps5HLA/WOkf0HcSenYhUsPSxH5/gY4KVNMgs08szS9QnWHiAjQXZCic+OwQu9Pm8nKttc9HLTeoJ4W9PFhAkE0ky8rMeaw+DRb01gpGY3gAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.26; Wed, 20 Mar 2024 09:43:27 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 09:43:27 +0000
Message-ID: <5d46d7bf-d487-4a60-9f73-7146947f989d@amd.com>
Date: Wed, 20 Mar 2024 15:12:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix format character cut-off issues in
 amdgpu_vcn_early_init()
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240320084513.3026222-1-srinivasan.shanmugam@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240320084513.3026222-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: f9022341-045a-4048-1cc2-08dc48c2318c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BtjieVBqTYVTM0fvc5P1qArDThcb9Sd3aYdcyUGxgx1m/poUlbWw3pceziVqJvOnb9etELNS0J9OmlefhYwrLHtz0PwwArUKK1qmjeklOblV7aDo6TE00V6rsvJ4MAzFaKuxzIvsQp74RQv6ZwBfQk8lkCETVbZ5XiXOEmB5kMjmbHIXMj2fRnDY7c2O5IK1fGyTw0KHzm5Hhu8kk5IPs2WCcPJoe0a9EulCofyge3/yRnN2KGiizOrKZTcu5FfFKSma6t+8e8L8M8ceEdYZ+HmxHOMwGvJex7/4705K0SGihAlU2uL0TlosZ6L9OgZW81kj6gNQ5xLhYpgw5mPRpFjUgeeSaAXN6t9uCopwCZdrLwTIrBtySD4WSbPNCrQ67GWOLy5n7lyule3vtpT6aoJfWiubXn0OmcLR6Kh4eaVcjau90wgAWWwt0PeU/F2efjrT2Mow8EJE7CgFIrCNohQublGt8KO99gFNU+JKoIUwf/tx2D77evdQrHerjHurG+Oz3+GKdgLmWNXYa7Pg/dl1cfZ2IxYnRO9/e4OHNWESGU8YJP4s3j2TfO+SydtIYm1VgftR12KAZxFdJAhQCvkGUvwx2uZMB2u44K1A7S6cGvy9hVf2lw/lbD2+2wVDp/yBKTs/vOCVEzZDoDR6dLJCGgINr1AcPTFjJPwJ/RY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cklDS0JSMlhzZVIvRko2OTlsYWFyYnhZSVlSYnRSWm1iRlVRZXFUVVI4K2lq?=
 =?utf-8?B?Y2FOZWU4ZVA2MWp5VzNRUU9ONEhEeFcxR0FpeWpXVmphYkRWOXRYeUlqYUxm?=
 =?utf-8?B?K1V5WVVqd2xlT2hROHd2VTRNaFhKd3BkU1lXazQxbkkvUFFRZ1ZZKzZIN1Q5?=
 =?utf-8?B?clBkRU5rbzQ5M2lGc1VVUkp3WVJsTXRWRW9NWDVVajdxSTExeVp1MzhCSklM?=
 =?utf-8?B?ZHU0Z2Znb3EyWldJdEE3dWdJUFdqbVlMdWdBTFlLU2N3R1NKQ0g1Mk5pSGRI?=
 =?utf-8?B?U3ZEUWhYSnp4eTk5Zy9PSHhmaDVMdDhSNDNEUzVjTmpJTWU5b1NUbGpVbFR1?=
 =?utf-8?B?VzVaVGhQK1J4UkV2eFdVMWR1cEpnWEN0Wk5OZ2pwdDdleEZTdTArcU5ERzhD?=
 =?utf-8?B?bUpGemxlVnhiQjN4Nm1TdmJwVk8vVGRlcDk3MUNOZUNITTFlSVN5UjFXL3JB?=
 =?utf-8?B?VjNVMXpVV2hJUDN2ZDRUOG9rQmZhcWdkRmlHNmU3SWNRbUlOOGMyQVMvN3Vu?=
 =?utf-8?B?YkdGeE1ZcW1KbytHTG5pUHZtSnlpQkpESnVBUUo5ZkRXcXFsYXVDRElVcnlY?=
 =?utf-8?B?MlhQYlRRWUVycWs3Qi8wQ1F5RTllaHFXcUVFKzV1SjMzMGZ1Zk1JK1dvSENZ?=
 =?utf-8?B?Vk15Q3k0N3l6TnN5OTRmTTRLOXIzMHpIcHNKVTBpZWJIUnBXQkRpWHJSells?=
 =?utf-8?B?ZmFCa0Q0NTVVbjk4L1ZHSC96VFhEREFMQ01YenptWXhKWTRIZzF2Y0J4SWcy?=
 =?utf-8?B?anZGR2p1cHlQT2RWRjdJelJTYWRodWpDTUg3MWFTNmJUa2pXY1cySXd2dVha?=
 =?utf-8?B?ZHN0Z3hFc2lxVjVmWjNhWm5vRkNHUEtIU2VaTm1SY2lZdXZsV0tJYjNTNENl?=
 =?utf-8?B?SytHcWtiV29xNjAyc0N1QXBZeTh2MEdrUVc2SHlieXQwU2c4UlFURk4zTFZ2?=
 =?utf-8?B?U3MyQ0dESkJGSnBYMzh2YXB4dGpjNU42ODZuUElScVR2d0JkQ0dSaU4weUow?=
 =?utf-8?B?ckJhQ0pSZ3p0M3BTK3NvQmIxMkdReWNzc01qeWFzSHZhRjFDRzczSHhmbWd0?=
 =?utf-8?B?K3RobnU2NXJCY1B0QWxFNVBjNWNGZVR6bTczelpKR2JPS2o5TU5yMFZxY29n?=
 =?utf-8?B?VHpHSFFQTmlSTVFGRytBb21BTXVWUXpmVFdsWUU0SkFJRXZnTjlXNjRMbGF0?=
 =?utf-8?B?LzAvR0NDSktiOVJFUHpHaS8xd2ExclFPVnhCaXJ2QXdsZXBjWklhTUg1eUpR?=
 =?utf-8?B?d29zdEtIOC9id1IxMzBybnoxSm5qYjJTTGhSMDB2Qm5UN1NmNnVhV1Z0cHZW?=
 =?utf-8?B?WnVQcVFEOXptdTNSUnhyUUpPUHRZZ3RCc3dzRWR2ZEk5Sk1HTVY0RjhBcjA4?=
 =?utf-8?B?bjNoODhRakJRK2o3OHNGV2ZiUHphNnJPVkhzODFJSzFjUHdEem5Ddzl2L21S?=
 =?utf-8?B?NlRoRDdkV0wydU1aa2tIREZhSlArQTBEd3JrQ3N3QmIyMm81UXd5NzdhZTNo?=
 =?utf-8?B?Tkh4U3pISTBjZU9kYUJnODVFY1FqRjlzdUVEcGhVc3l0VktBTldyYVozL3dt?=
 =?utf-8?B?YU1hWnNTY1I1QlNVVS9RajJLZkJncFhJc0kxcFRJRXV1SVdlQnJRZXZFOEVX?=
 =?utf-8?B?S2w5T2hUVVJVV2JQSFhNOEt3bXRiUWZ1QWMwUDhCUmRoM01ndlc0N2pMVFFX?=
 =?utf-8?B?ekxtTGVHQVV5aHc3aFFMOWNsTFVBcVVpTFdmSE5GMnpRQi9adUEzTkU1SHFI?=
 =?utf-8?B?TlgrM01iOVJLTlYrTWZQRTcvZVM3ZDFDQmEvdXIwdUlwNSt4VXhqOEErNC9I?=
 =?utf-8?B?MzlhdzlKcFlRdHYrTWUvNjNKVkorbVBOdmVyeUxpdTlnSDNwN1J6QjdxNk9a?=
 =?utf-8?B?eDN1YURuUVYvM08wanpuTHZtTjNaLy9pY2dBQUgwNWFQanNjTzgxbmZsdXNX?=
 =?utf-8?B?NmE5KzZXQWVvZXArZkdDUTNUTVB5WHRxRE5pYnBSQWZ2SndvYkVWTjkyNnYy?=
 =?utf-8?B?NnZFazdlMSttUEJwaE8rd0R4dE5pM0dvMmJLZ2ZpblREZURWbVdiMXBSTytZ?=
 =?utf-8?B?QmcrN0RCN0FQVTcwY2M1L3gwWnhmUXVpQkdjbDNYc1NCcUxZOS91NmFzMkJC?=
 =?utf-8?Q?QIDw4GLVFtHR3bXFWjvVoPNMN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9022341-045a-4048-1cc2-08dc48c2318c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 09:43:27.5872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxd3FvpxyXaD+pO1O3lYRA2ORNNrT5k9Ut/dLFmHmRnaxe2wu74cHr2LU2aGKOG1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142
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



On 3/20/2024 2:15 PM, Srinivasan Shanmugam wrote:
> The issue was present in the lines where 'fw_name' was being formatted.
> This fix ensures that the output is not truncated
> 
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c: In function ‘amdgpu_vcn_early_init’:
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:66: warning: ‘snprintf’ output may be truncated before the last format character [-Wformat-truncation=]
>   102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>       |                                                                  ^
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:17: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 40
>   102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:66: warning: ‘snprintf’ output may be truncated before the last format character [-Wformat-truncation=]
>   102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>       |                                                                  ^
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:17: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 40
>   102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:105:73: warning: ‘.bin’ directive output may be truncated writing 4 bytes into a region of size between 2 and 31 [-Wformat-truncation=]
>   105 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_%d.bin", ucode_prefix, i);
>       |                                                                         ^~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:105:25: note: ‘snprintf’ output between 14 and 43 bytes into a destination of size 40
>   105 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_%d.bin", ucode_prefix, i);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 9c514a606a2f..f994ee6c548d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -94,7 +94,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
>  int amdgpu_vcn_early_init(struct amdgpu_device *adev)
>  {
>  	char ucode_prefix[30];

Hi Srini,

Sorry, if I miscommunicated. Suggestion was to reduce prefix size to 25
as the max prefix length is possibly length of dimgrey_cavefish_vcn.

With fw_name[42] also, you may run into 43 bytes (30 prefix + 13 for
others) warning.

Thanks,
Lijo

> -	char fw_name[40];
> +	char fw_name[42];
>  	int r, i;
>  
>  	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
