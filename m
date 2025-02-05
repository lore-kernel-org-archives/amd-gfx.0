Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9159AC02194
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 15:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 821F210E7E7;
	Wed,  5 Feb 2025 15:06:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V8XveEav";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E917A10E1D6
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 15:02:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyEy9aPT4B2IK14CQrBAhHYc0/6bYjJ0qKxfgPSK8upUXRuWdkHqTAMBcNW9t1zhdQT2S6UXKEj5cSLdkulJu4n2c7/qGjvXsCY8FGCVUUi/cm1Xwz9Ht7Jsk2qUZTZPsmKPSzDG7ZT+bdzwXF98D8iaFDLxm2MIvJ9If9nvHVC4V4JLnOp3YuyFFkV4uf2HBt6+LHGKFFkEuYXjAyUsX8fIZCAbBg1rY6dELwEPTpoWaV3PaCtY9jQYgn11nIQBlpwW3S4p7iDMZe4A8TiHr0a3ojEgLmaT/OhEZPeNFsPkKEi8wTmjAUvdpVETyWUlkqUhht753fKTLgecr7Qmdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c49Luxhv77Ut1QtaJarabWWvvpqwD/dQDPZWxvRHiME=;
 b=p9BDNaEs9mqxBGJWSLHfBgothjDpeybz3iWg88lJKBTy/Eob32PHHlMuMGZH18AmFSm2to4FkRwTDOQnjo7I4Pu5H04Cm1LoTtO6v5qRjQMe4hULNeMtuKbMCq2TPvDB351/v1y5K8CAi3o9WMalh1UY2Q8vS3Z15UjqIcshoPTKvM3Jg+U3GRSDaRgRMNaTd1Iz1MsLYct7TZ5EwbMH7Qu/G5UtDQIc53/dhzm0eUxA9rR4WoWdSWAc977fbAEZKxiTK8wMVbwqwtvW90CMxxuoTOlpMbDy2XiqNkiy51WP+SMfLRC4JPeIktN6GKR+wp66zVje9gJ4MTvms/hMMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c49Luxhv77Ut1QtaJarabWWvvpqwD/dQDPZWxvRHiME=;
 b=V8XveEavxipq7Y8i5NNtC3XzRQq/gSAkhkV15OuLD7JRBBr2k78s0u4KSWSsDWVZkUC4RYBx5f4EkdWCmX9C7s4fEb/ElkoBElf+kngmChnuGRGn8cKQpMMFIJzL4LmutG7kIyRK4f3l3rInkXFWw0321LkZ3GD2X1UmXbJLb94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 15:02:37 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 15:02:37 +0000
Content-Type: multipart/alternative;
 boundary="------------vdAL2C1kQQkza2izYAFiWxGX"
Message-ID: <21ed8ad7-4f59-42eb-b12b-eeb740caad37@amd.com>
Date: Wed, 5 Feb 2025 10:02:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/44] drm/amdgpu/vcn2.5: convert internal functions to
 use vcn_inst
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-16-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-16-alexander.deucher@amd.com>
X-ClientProxiedBy: YQZPR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::13) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe8ee65-3a51-4873-2533-08dd45f620a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3g5WnBvcTdIbjBBMVdBbmx5REY4NGRLRm1PbFJuQzRUQWlFNlQ1OVpGbEVz?=
 =?utf-8?B?QnN4WUU4RHZrV2xCRm9ZUUJwcGhyNmJFL01LQWJSMGFCM3E5MVJ2ZDIvUUN1?=
 =?utf-8?B?YXdScGZRYit5WUpaeVF4ckNKeGsyekQwNURsQzhYeHhGUmdzVm5zMHFMZGtr?=
 =?utf-8?B?TjVYL295bTJBUHZ6cnpnbXZkR1UzSXl3aXJQUnRTMXZod1cvUlVqUUNqNlpY?=
 =?utf-8?B?SDhhelJwVm1UOW1nMVRCUkIwUXlZTkQ0K01WRGxjenJ0dERRZ3BjcFBmZ2l0?=
 =?utf-8?B?TmxIUHNmWkx2Q242T2FQeWh3QVdRWFhHSUsyQ0xLTVdxNENoUlNCQUFwOURS?=
 =?utf-8?B?cUdxdUZibzBveHBla3RxTThrVXVSZ0oxTmVuaGdjYWJaZHpweHR1TFErWWpG?=
 =?utf-8?B?WGsyZHc0TmxCRGZuTFZ4Z3pqVkZMZDRBNXk3dnN5aERTd0lDVmdmM3RmNUVo?=
 =?utf-8?B?bHl3WnRSeTNNVEs4ZTBWZ2U5MnhTQ3RyR2VUQSttSVFRSjRHRlhNamdxQ1Jt?=
 =?utf-8?B?UHdWYUU1Rks2OFVYSmlQVHNhdVQrOUJacGIyMW95SWZCR1psYlErcmFCZVZl?=
 =?utf-8?B?UlVqZWZkUG1LYkU1SkFnSHdERzFaYS8xMHJ3Rnc4UHc1d0NSV1NJVWo3ODBI?=
 =?utf-8?B?eDA1NURoUy81R1AxZURDWjB1cktsdzBwY0VPZ21uajZaT0l0eVRzSHdYdjR1?=
 =?utf-8?B?STNTRzNWSFNUM3NlR1ROVmVsdnZnYlV6NVRIVkkvVFBJUmx5ZHNEK2poVkpj?=
 =?utf-8?B?RjVtaUVNaTUyd1huNHRkakx1WHIxcGVkc0diN2tuRGZla1ZmWThieE11d3dB?=
 =?utf-8?B?NGpvQ3QxSVBYOGNpd01LS3B6SG1hZkRiTlE2eUNlZGRHUjFHQkN3dmVtYlBl?=
 =?utf-8?B?aEhnRUFZU1FXN2I3a0hPZXVVeFc0K1B2UHd5VkR4eTI1RkQyM3BJNVA5SnVX?=
 =?utf-8?B?cC9ibnZDN1pORFZiZDU4TmZGNnQxN0Z6c0k3WmQ3VXMwcld4OEV1ZTZ4aWtl?=
 =?utf-8?B?YTZDeWRlandUL3UwSWlIaE0xeHVuYTJkZElFbllyaGtzdUZyZHMxWDFxWk4x?=
 =?utf-8?B?cWxBdjIrbExDRDVVRjJCWk1ZNENNVXBVR2RlM3BmTlRNdlRKWGwxSzdZMlMz?=
 =?utf-8?B?SDhGWEYwdTVsSkVHY2QyRWlDUUh4N0JONGwyRVJmUldReXVzL1Frb29IM2VP?=
 =?utf-8?B?N0NxT0Njdms1QjBpb0VWdnZVM1p0OTRkWlBsbCtLSlcrWjNoRnpQUGg1OFI2?=
 =?utf-8?B?TWpzOTFYMzBTZ1VpaTByenMrbjFzOEdibE5tbG8rRlBqQjhwSGVia1ExTlZ6?=
 =?utf-8?B?bDVkNmZJWmxnRUJ2czh0bVpWa0JxUDcrRWtXdUwxM2pDTXNtM09rUCtVWXU2?=
 =?utf-8?B?M3ZOUmw0TDFTQWVlcVk5Qi9GRG54NjBVNGpZVUNhekZNZTNsa3FSemZzWDQ5?=
 =?utf-8?B?Z2pMejRPYXFrazBhdVB5YXAvQ0QzeFY3S0xqczhJNzhBT3FuNWhNdldWZ0t5?=
 =?utf-8?B?M3Z5SHdzb2thS2dkOFM3eW4wYlR6aGhMNVJySndYZ09nWE1sWEtHOHhweXl6?=
 =?utf-8?B?T0VwaVA5SllrQnkxNkNZQ2FLaDNROFZ5WisrdkM2cHY1K2ppbWFoSG0vWVU5?=
 =?utf-8?B?QWdhUXcrcWNkZ0tETDRvTURVV2R5US9VOFFMWVMvelpyTmZTZGRqU0g1ckZw?=
 =?utf-8?B?dlZ3QkFHMm4zSlVQbiswT0NFNE5hMEEvV1FGcGJ0WVBQU21tMWhWTDlHS2Zo?=
 =?utf-8?B?NTdoQ3pRanJzM2RYM0tKVWFFVy8yR3dQYmN0V0NyRkhsQXJJRzRoaXJENUx6?=
 =?utf-8?B?YkhuSElqQnJCYUJtQVQzYVhSRERGdnR1VHhjMGdVSlFCRE9nYldUMXlUSGJt?=
 =?utf-8?Q?ba8PwKKxUtsbE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUp4TFI4WkY0Wlk0Nnd1K05UdSsvTTBMbkJYMWpCR1g5REtxMFBCK0o3MFhE?=
 =?utf-8?B?ZGVNL3dBZmJyVC9CaVg4MXZsSloyZzUxSjNwRWVSSi8vSzc5SWplVE9kQTRT?=
 =?utf-8?B?dFJPZFVnaXpGQnFueSt6Y0JTcG9zc1lyOWhUV25mUEl0R3cvWEFKU3d3UzUx?=
 =?utf-8?B?YWs4d3p3R0FDZG4rdjl1Mk5LS2xWL1ZKWVpPZk5YRVc3MFlaUDl5Vmg4NllJ?=
 =?utf-8?B?WmtKZ2pYaE9XQ2NweklReHEzalJtZlZsOTltUmFqcFNaUUEwUDVrNTdjYkpI?=
 =?utf-8?B?THRzKzFuUDg1Qklpa1hkVWVpV0d5QTU2N2JPR3Q4dzFUZEVCbEczQnNzSFRo?=
 =?utf-8?B?UTVWeW1DZENZNjJvSmxoc0dGN1R1b2p0dlY5WmVhVlJ0S0p3N3ozdkZ4NVBK?=
 =?utf-8?B?WUZkNy9DSU12L2IrOExoV2FkNHFvM0Y3dzduUlo2WlVBQWhTdVR2NEgweTVW?=
 =?utf-8?B?UXgxQlZkNjJIYnV0b0hRQVo0aW5KZE5zWGs3d0owYjloVk1JNmgrcGU0WThI?=
 =?utf-8?B?bTRGUU9wc3REWFp2LzQwQStrWWVVRVE3Mks4TFNQaWhXRmlvZXVLMlA0N003?=
 =?utf-8?B?S2p4Zk10SURuYXppemlJV01RbTh6RVhxYW01Z1hOaHdobjcrQW9qcXpPUmVk?=
 =?utf-8?B?ZTlTU2M5ZXZabE4rWkVnclN4TkdoenlBTjN1U09MdjhVS2RwN2xyS1B4aXc4?=
 =?utf-8?B?UVRNYkphWXhxVmZnODBteVlKaEg4cEpVemRwT2c4UVFERGhvQ2ZZZUVIZWY1?=
 =?utf-8?B?V2hsYzdHZ1hFaFU4K1BUbjR1SDg5dDh0ODc3ZEQ3Si9FOEZtdmZRUW1ZNkRw?=
 =?utf-8?B?OXhCcFU0SmV0Vnpwa2d0NFZQYmJXSFZLaG5CNllXSXluYW1HcnlzOHhjTnAw?=
 =?utf-8?B?ZVlRUHBSRkhjWlJHdllZcUdsZjQ1Y01HbVp6S0tNQUUyeExEaGxlM212aXNk?=
 =?utf-8?B?emgwM1ZEK3IwZklPTThiL285NXVGZllBUTE0U1ZwSXRCZXFwd3FGN3BKTHcr?=
 =?utf-8?B?TUwrWFZGK3kzY2QxZ1hOQlVZZlVuY2cyNDhRa3RUbWdxMnZwRlZCM2UwZXNo?=
 =?utf-8?B?U1RUVkFxU0E5T3NsV1NMSDEyZjJPL3BqL0tCOXhDTThYNGM3anFqUlpSU0Nz?=
 =?utf-8?B?MUcrYUJhWWxzYzhnT2huQ0xLQXVSQzQ3VlVscXd3ak91eWt4VjZtRE40V01U?=
 =?utf-8?B?eG5qd1VjRWgwdS9IMk05YnZReW55d0ZqV1FkcG4xekxVSHhveTJpc0JRQ3pH?=
 =?utf-8?B?VXVtKzArS0RSZ1VqOXllbStuemE2MTBFZWRXdXZjRlJQUnNVWWUzYTZkay9z?=
 =?utf-8?B?Vmx2c1NjRnUxZUVpVjJYa0xKaVRNTDI1VlQyWnJVdjY4L0c5MGgvWC9rb3gr?=
 =?utf-8?B?dHJuUytxWEJJNlRzTG1ValFPZGpOMSt4cGR4VERRcVNXOFBKWmRNbU9zMFJE?=
 =?utf-8?B?N2Q1YTNhbHhmKzFJcDAyOXJEYld4VDBEZ0doWTlqSkRtMDVWWUpLWjZxZ0NU?=
 =?utf-8?B?ZllNZE81ZjJITTJVR283VnNFWTUwVExyWEVkREx5M1p5SG93KzU2S3FUZUZC?=
 =?utf-8?B?QnR2ZkltWm54Nm1GSU5xblRjYjJneEdJTEh3b2R2dWZzc2puRWVhOVhTS20v?=
 =?utf-8?B?Ryt1WjlDS0V6dVAya0tTZXBNUkM5YkxyUWk1dDcrTElkamlpbVlGTGY5UHRn?=
 =?utf-8?B?NXZUQmhUNkd0V3VzLzI2REFObXJGVk9PTWxmbXRGWTg4SVFFRllGVXhCSHkz?=
 =?utf-8?B?d2lvcHczWnRUczhhbEV1OVR4OExIamZoaDRpTzZDZmNFdXJBUVBhWTdpaDhy?=
 =?utf-8?B?aWFDL2FSK29tS25WbERSWHJVM2hHb3BLUUxrMTBoV1pQais4eFBtWGF0clMr?=
 =?utf-8?B?VExZUDN6bCtaRnVIZEMvOUt2YlBlbnFzanVsakdmN3hzVmJlZ2tVUUVnRXdy?=
 =?utf-8?B?VGxoVDhnRzJwTER0U21TNFlaYnJocmNaS1phWUxDMlZ4WFcvK3QxVDhwQXRG?=
 =?utf-8?B?OHdvK3dEWUMvaDQrU1ZYTWVSRElmbHFCcjZ2ODNaUnJKVCtBTzBiK1ZxaERX?=
 =?utf-8?B?RDFSSks3R00yMm10WHRpRDFHR3hWUlhJemd1V2hCWEt5RkxWQmtpVStxZkRK?=
 =?utf-8?Q?yiHe0GUbFykKPmA2WDRBJkOnq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe8ee65-3a51-4873-2533-08dd45f620a5
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:02:37.0663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncf2gC0lcvzVhcXG9S4HtP8uzJWo9aOiRpDZHPpTdu+1mipm8B+1pPxFt4OKBEq1z8gHu1zLbym2OH/nu60YGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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

--------------vdAL2C1kQQkza2izYAFiWxGX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> Pass the vcn instance structure to these functions rather
> than adev and the instance number.
>
> TODO: clean up the function internals to use the vinst state
> directly rather than accessing it indirectly via adev->vcn.inst[].
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 79 +++++++++++++++++----------
>   1 file changed, 50 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 4f9f3de023ffd..69cf42a4a3f18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -468,13 +468,14 @@ static int vcn_v2_5_resume(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v2_5_mc_resume - memory controller programming
>    *
> - * @adev: amdgpu_device pointer
> - * @i: instance to resume
> + * @vinst: VCN instance
>    *
>    * Let the VCN memory controller know it's offsets
>    */
> -static void vcn_v2_5_mc_resume(struct amdgpu_device *adev, int i)
> +static void vcn_v2_5_mc_resume(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int i = vinst->inst;
>   	uint32_t size;
>   	uint32_t offset;
>   
> @@ -527,8 +528,11 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev, int i)
>   		     AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
>   }
>   
> -static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
> +static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +					bool indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[inst_idx].fw->size + 4);
>   	uint32_t offset;
>   
> @@ -626,13 +630,14 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
>   /**
>    * vcn_v2_5_disable_clock_gating - disable VCN clock gating
>    *
> - * @adev: amdgpu_device pointer
> - * @i: instance to disable clockgating on
> + * @vinst: VCN instance
>    *
>    * Disable clock gating for VCN block
>    */
> -static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev, int i)
> +static void vcn_v2_5_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int i = vinst->inst;
>   	uint32_t data;
>   
>   	if (adev->vcn.harvest_config & (1 << i))
> @@ -738,9 +743,11 @@ static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev, int i)
>   	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
>   }
>   
> -static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
> -		uint8_t sram_sel, int inst_idx, uint8_t indirect)
> +static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +		uint8_t sram_sel, uint8_t indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t reg_data = 0;
>   
>   	/* enable sw clock gating control */
> @@ -789,13 +796,14 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
>   /**
>    * vcn_v2_5_enable_clock_gating_inst - enable VCN clock gating
>    *
> - * @adev: amdgpu_device pointer
> - * @i: instance to enable clockgating on
> + * @vinst: VCN instance
>    *
>    * Enable clock gating for VCN block
>    */
> -static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev, int i)
> +static void vcn_v2_5_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int i = vinst->inst;
>   	uint32_t data = 0;
>   
>   	if (adev->vcn.harvest_config & (1 << i))
> @@ -846,9 +854,11 @@ static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev, int i)
>   	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
>   }
>   
> -static void vcn_v2_6_enable_ras(struct amdgpu_device *adev, int inst_idx,
> +static void vcn_v2_6_enable_ras(struct amdgpu_vcn_inst *vinst,
>   				bool indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t tmp;
>   
>   	if (amdgpu_ip_version(adev, UVD_HWIP, 0) != IP_VERSION(2, 6, 0))
> @@ -873,8 +883,10 @@ static void vcn_v2_6_enable_ras(struct amdgpu_device *adev, int inst_idx,
>   			      tmp, 0, indirect);
>   }
>   
> -static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
> +static int vcn_v2_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
>   	struct amdgpu_ring *ring;
>   	uint32_t rb_bufsz, tmp;
> @@ -892,7 +904,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   		adev->vcn.inst[inst_idx].dpg_sram_curr_addr = (uint32_t *)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
>   
>   	/* enable clock gating */
> -	vcn_v2_5_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
> +	vcn_v2_5_clock_gating_dpg_mode(vinst, 0, indirect);
>   
>   	/* enable VCPU clock */
>   	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
> @@ -941,7 +953,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>   		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
>   
> -	vcn_v2_5_mc_resume_dpg_mode(adev, inst_idx, indirect);
> +	vcn_v2_5_mc_resume_dpg_mode(vinst, indirect);
>   
>   	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
>   		VCN, 0, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
> @@ -952,7 +964,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
>   		VCN, 0, mmUVD_LMI_CTRL2), 0, 0, indirect);
>   
> -	vcn_v2_6_enable_ras(adev, inst_idx, indirect);
> +	vcn_v2_6_enable_ras(vinst, indirect);
>   
>   	/* unblock VCPU register access */
>   	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
> @@ -1017,8 +1029,10 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   	return 0;
>   }
>   
> -static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
> +static int vcn_v2_5_start(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int i = vinst->inst;
>   	volatile struct amdgpu_fw_shared *fw_shared =
>   		adev->vcn.inst[i].fw_shared.cpu_addr;
>   	struct amdgpu_ring *ring;
> @@ -1032,7 +1046,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
>   		amdgpu_dpm_enable_vcn(adev, true, i);
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		return vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
> +		return vcn_v2_5_start_dpg_mode(vinst, adev->vcn.inst[i].indirect_sram);
>   
>   	/* disable register anti-hang mechanism */
>   	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
> @@ -1046,7 +1060,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
>   		return 0;
>   
>   	/* SW clock gating */
> -	vcn_v2_5_disable_clock_gating(adev, i);
> +	vcn_v2_5_disable_clock_gating(vinst);
>   
>   	/* enable VCPU clock */
>   	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> @@ -1091,7 +1105,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
>   		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>   		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>   
> -	vcn_v2_5_mc_resume(adev, i);
> +	vcn_v2_5_mc_resume(vinst);
>   
>   	/* VCN global tiling registers */
>   	WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
> @@ -1396,8 +1410,10 @@ static int vcn_v2_5_sriov_start(struct amdgpu_device *adev)
>   	return vcn_v2_5_mmsch_start(adev, &adev->virt.mm_table);
>   }
>   
> -static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
> +static int vcn_v2_5_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t tmp;
>   
>   	/* Wait for power status to be 1 */
> @@ -1424,15 +1440,17 @@ static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>   	return 0;
>   }
>   
> -static int vcn_v2_5_stop(struct amdgpu_device *adev, int i)
> +static int vcn_v2_5_stop(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int i = vinst->inst;
>   	uint32_t tmp;
>   	int r;
>   
>   	if (adev->vcn.harvest_config & (1 << i))
>   		return 0;
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		return vcn_v2_5_stop_dpg_mode(adev, i);
> +		return vcn_v2_5_stop_dpg_mode(vinst);
>   
>   	/* wait for vcn idle */
>   	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> @@ -1475,7 +1493,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev, int i)
>   	/* clear status */
>   	WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
>   
> -	vcn_v2_5_enable_clock_gating(adev, i);
> +	vcn_v2_5_enable_clock_gating(vinst);
>   
>   	/* enable register anti-hang mechanism */
>   	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
> @@ -1810,12 +1828,14 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   		return 0;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
> +
>   		if (enable) {
>   			if (!vcn_v2_5_is_idle(adev))
>   				return -EBUSY;
> -			vcn_v2_5_enable_clock_gating(adev, i);
> +			vcn_v2_5_enable_clock_gating(vinst);
>   		} else {
> -			vcn_v2_5_disable_clock_gating(adev, i);
> +			vcn_v2_5_disable_clock_gating(vinst);
>   		}
>   	}
>   
> @@ -1827,6 +1847,7 @@ static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
>   					       int i)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
>   	int ret;
>   
>   	if (amdgpu_sriov_vf(adev))
> @@ -1836,9 +1857,9 @@ static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v2_5_stop(adev, i);
> +		ret = vcn_v2_5_stop(vinst);
>   	else
> -		ret = vcn_v2_5_start(adev, i);
> +		ret = vcn_v2_5_start(vinst);
>   
>   	if (!ret)
>   		adev->vcn.inst[i].cur_state = state;
--------------vdAL2C1kQQkza2izYAFiWxGX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:57, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-16-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Pass the vcn instance structure to these functions rather
than adev and the instance number.

TODO: clean up the function internals to use the vinst state
directly rather than accessing it indirectly via adev-&gt;vcn.inst[].

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="markpsh7afcgm" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-16-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 79 +++++++++++++++++----------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 4f9f3de023ffd..69cf42a4a3f18 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -468,13 +468,14 @@ static int vcn_v2_5_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v2_5_mc_resume - memory controller programming
  *
- * @adev: amdgpu_device pointer
- * @i: instance to resume
+ * @vinst: VCN instance
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v2_5_mc_resume(struct amdgpu_device *adev, int i)
+static void vcn_v2_5_mc_resume(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int i = vinst-&gt;inst;
 	uint32_t size;
 	uint32_t offset;
 
@@ -527,8 +528,11 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev, int i)
 		     AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
 }
 
-static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					bool indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev-&gt;vcn.inst[inst_idx].fw-&gt;size + 4);
 	uint32_t offset;
 
@@ -626,13 +630,14 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 /**
  * vcn_v2_5_disable_clock_gating - disable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @i: instance to disable clockgating on
+ * @vinst: VCN instance
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev, int i)
+static void vcn_v2_5_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int i = vinst-&gt;inst;
 	uint32_t data;
 
 	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
@@ -738,9 +743,11 @@ static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
 }
 
-static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
-		uint8_t sram_sel, int inst_idx, uint8_t indirect)
+static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
+		uint8_t sram_sel, uint8_t indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t reg_data = 0;
 
 	/* enable sw clock gating control */
@@ -789,13 +796,14 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
 /**
  * vcn_v2_5_enable_clock_gating_inst - enable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @i: instance to enable clockgating on
+ * @vinst: VCN instance
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev, int i)
+static void vcn_v2_5_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int i = vinst-&gt;inst;
 	uint32_t data = 0;
 
 	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
@@ -846,9 +854,11 @@ static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
 }
 
-static void vcn_v2_6_enable_ras(struct amdgpu_device *adev, int inst_idx,
+static void vcn_v2_6_enable_ras(struct amdgpu_vcn_inst *vinst,
 				bool indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t tmp;
 
 	if (amdgpu_ip_version(adev, UVD_HWIP, 0) != IP_VERSION(2, 6, 0))
@@ -873,8 +883,10 @@ static void vcn_v2_6_enable_ras(struct amdgpu_device *adev, int inst_idx,
 			      tmp, 0, indirect);
 }
 
-static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static int vcn_v2_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	volatile struct amdgpu_fw_shared *fw_shared = adev-&gt;vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
@@ -892,7 +904,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		adev-&gt;vcn.inst[inst_idx].dpg_sram_curr_addr = (uint32_t *)adev-&gt;vcn.inst[inst_idx].dpg_sram_cpu_addr;
 
 	/* enable clock gating */
-	vcn_v2_5_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
+	vcn_v2_5_clock_gating_dpg_mode(vinst, 0, indirect);
 
 	/* enable VCPU clock */
 	tmp = (0xFF &lt;&lt; UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
@@ -941,7 +953,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		 (0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
 
-	vcn_v2_5_mc_resume_dpg_mode(adev, inst_idx, indirect);
+	vcn_v2_5_mc_resume_dpg_mode(vinst, indirect);
 
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
@@ -952,7 +964,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_LMI_CTRL2), 0, 0, indirect);
 
-	vcn_v2_6_enable_ras(adev, inst_idx, indirect);
+	vcn_v2_6_enable_ras(vinst, indirect);
 
 	/* unblock VCPU register access */
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
@@ -1017,8 +1029,10 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	return 0;
 }
 
-static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
+static int vcn_v2_5_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int i = vinst-&gt;inst;
 	volatile struct amdgpu_fw_shared *fw_shared =
 		adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
@@ -1032,7 +1046,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
 		amdgpu_dpm_enable_vcn(adev, true, i);
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v2_5_start_dpg_mode(adev, i, adev-&gt;vcn.inst[i].indirect_sram);
+		return vcn_v2_5_start_dpg_mode(vinst, adev-&gt;vcn.inst[i].indirect_sram);
 
 	/* disable register anti-hang mechanism */
 	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
@@ -1046,7 +1060,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
 		return 0;
 
 	/* SW clock gating */
-	vcn_v2_5_disable_clock_gating(adev, i);
+	vcn_v2_5_disable_clock_gating(vinst);
 
 	/* enable VCPU clock */
 	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
@@ -1091,7 +1105,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
 		      (0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		      (0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
-	vcn_v2_5_mc_resume(adev, i);
+	vcn_v2_5_mc_resume(vinst);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
@@ -1396,8 +1410,10 @@ static int vcn_v2_5_sriov_start(struct amdgpu_device *adev)
 	return vcn_v2_5_mmsch_start(adev, &amp;adev-&gt;virt.mm_table);
 }
 
-static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+static int vcn_v2_5_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t tmp;
 
 	/* Wait for power status to be 1 */
@@ -1424,15 +1440,17 @@ static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 	return 0;
 }
 
-static int vcn_v2_5_stop(struct amdgpu_device *adev, int i)
+static int vcn_v2_5_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int i = vinst-&gt;inst;
 	uint32_t tmp;
 	int r;
 
 	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
 		return 0;
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v2_5_stop_dpg_mode(adev, i);
+		return vcn_v2_5_stop_dpg_mode(vinst);
 
 	/* wait for vcn idle */
 	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
@@ -1475,7 +1493,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev, int i)
 	/* clear status */
 	WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
 
-	vcn_v2_5_enable_clock_gating(adev, i);
+	vcn_v2_5_enable_clock_gating(vinst);
 
 	/* enable register anti-hang mechanism */
 	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
@@ -1810,12 +1828,14 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 		return 0;
 
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &amp;adev-&gt;vcn.inst[i];
+
 		if (enable) {
 			if (!vcn_v2_5_is_idle(adev))
 				return -EBUSY;
-			vcn_v2_5_enable_clock_gating(adev, i);
+			vcn_v2_5_enable_clock_gating(vinst);
 		} else {
-			vcn_v2_5_disable_clock_gating(adev, i);
+			vcn_v2_5_disable_clock_gating(vinst);
 		}
 	}
 
@@ -1827,6 +1847,7 @@ static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 					       int i)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	struct amdgpu_vcn_inst *vinst = &amp;adev-&gt;vcn.inst[i];
 	int ret;
 
 	if (amdgpu_sriov_vf(adev))
@@ -1836,9 +1857,9 @@ static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v2_5_stop(adev, i);
+		ret = vcn_v2_5_stop(vinst);
 	else
-		ret = vcn_v2_5_start(adev, i);
+		ret = vcn_v2_5_start(vinst);
 
 	if (!ret)
 		adev-&gt;vcn.inst[i].cur_state = state;
</pre>
    </blockquote>
  </body>
</html>

--------------vdAL2C1kQQkza2izYAFiWxGX--
