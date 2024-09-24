Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F630CF9C6B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 13:28:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5BCF10E6D5;
	Tue, 24 Sep 2024 13:28:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IdfoNCjz";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28EE010E6D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 13:28:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTbL58sHXa2PBI4QRFVjvPpQDznDYa82VJ6fQSAIGtizJ5eUHXk/Hu4gHBCSm7gjjQeYl21dyU2HMik37KCsDH/+DJgedjECJZ7TeV6Jx5EzrPXkHJfnCU5SeX4NzQ20bNAxjVzC16Knewv0Feozdpp9h/QvOLbBU9M82NVcyIXLfsFTX8Auvs4LFU6blOD6CgTzHc0SwwKZeR3yv04ko4RNabfhtFOHDQ7EA0UVYrpU8DWZ951s4dobTVQRJZpAUQxzo1+ef/9aBhlMeTyqJuieEyXz5vSwfgJqrSJvbeCNaM1+sNJUdXVlgx1ZqREO9SMDtMSrqfoLjDdCRgC6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O16lu85eUZofkYXmpy9IEvOlubu04J+jMMfxoZlhMqc=;
 b=QO6aD5w77KothybOQIQt3EO6emTxu1gwUOAOFDxyPP+g8DrbNSEDgJoDPJ4xU5SzoiIEoaNBY7dQk+qPSGJ1VqiGAsg/bbDvXMPbrnBanE4AHW2WgeBN5MKwmwWhqR6a7W1kwVWhNNLEdj1MeJJ6C3xOP5sRrfAQFWdSgmzsROjKb/csRX6BjYnO395m2YF50W7poFjot7SmRv55cp57it0Y4EZUiN6GxdQYQtkHjf7tzIb1r2UvgxdttA567cifGDJON2eJa2VAO5g5gVYwtvvldWDHCwRLBDMxVQOxkwTd1uqRt1I1BwXWRiRGmx4fdqbjU0brRRduc/AFmqAbOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O16lu85eUZofkYXmpy9IEvOlubu04J+jMMfxoZlhMqc=;
 b=IdfoNCjzsQg0l2Psk0kht3J8no+PlF7ANNddL4A+O15Asf3eO6FPsiLdhUOLLFRrxGnAWS7PteKMLFSOz9F0FrQKLGxLnHJ6TFzZvb4AO4w7cMikRbRMY3hWCFdnshqTVBhddIMbiLLzTA98IKwuH+EibadG5gB4woc3Z8c1igM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB9001.namprd12.prod.outlook.com (2603:10b6:806:387::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 13:28:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7982.012; Tue, 24 Sep 2024
 13:28:17 +0000
Message-ID: <dd88ca84-5390-4681-b2e0-4809ec4b846d@amd.com>
Date: Tue, 24 Sep 2024 15:28:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add amdgpu_device reference in ip block
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240924125739.831544-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240924125739.831544-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: 0529fae8-7d41-41bc-9130-08dcdc9cbfcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2dDMHZPK3pDTFhJUjZpUzRFaW9HSG5mbVhqQWZvcWVwMHQxSUhqNVh0aGN0?=
 =?utf-8?B?dGlsc0p1YkR1YU5Ia3FqbUpBVnFTNXpNZU96RnFtSktEcmM4NXl5aXpJM1Bm?=
 =?utf-8?B?MVk3aUg2ZVNGNUNMRExjdUhuV3ZjZnpWR3ZzaEh1emVuYlNINkN1bCtBRk82?=
 =?utf-8?B?VXFlNitjZ3BKRndrSGwzRXl1bnVQbFVUOHRKQ3dRS0k0RlJydHlCY0RXUmR6?=
 =?utf-8?B?QlNFczFZS2lNWjdDcWF0QlErSXJ2YXVSRE5oRGt6YVB3eFpmTnR4RDNXQjhQ?=
 =?utf-8?B?UzFzcXV4bmFuYVk2cmFjN2lqT3VLejAzTTVBaW8yVGJmRFdienYvQWtFNUdq?=
 =?utf-8?B?U25jRGo0c3pXSkdEU2NWYlJtck1RZWtpYjRGOHFDV0ZCaDFPV3IxSWxIZ2dv?=
 =?utf-8?B?ZXpSeXkzY0JNZnpwNEE4V2pGd09qWVFpNytZeGVuZk5ub1lJV2d0cFZ4WE9C?=
 =?utf-8?B?aTMraFFldzFmcEwwdGNFUUE5cWg4YzBHT2tnbFpNL3RDdGxvTUFHUWx6ZWV3?=
 =?utf-8?B?UTVwUTkrRlNva09WdENMMGtiQU9SM2V4ZGEvQlFBWUsrSVk5RkFmejM3TGZC?=
 =?utf-8?B?bGxuRm1ldlZ6VHZLcm1HeEFPZDN5TXFRNXlFaFpsaU5WRkJsK3ZOMzZOWTdU?=
 =?utf-8?B?QzdjZWlKMGVzUHdMMW5yK3d4em12ZEh5OUpRZ2lnRXlsNjVKVVY3OS9HcWRw?=
 =?utf-8?B?L2FVZVB2cnR6MXNreTNidTE0SVVmaU5wTE1TWG02bURySFpUclJmL3ZsTG5x?=
 =?utf-8?B?U3ZidFNlcnc5cXN6a2wrVWNxZHNoQ0FTalVRalA4L1BLK3FURC9oRHozZ0xJ?=
 =?utf-8?B?YXdmNjhYNC80T3M4K0NUSHVpUUw2b05WeGR3dG5WMnY2bGRtdEw5MlJ6djNB?=
 =?utf-8?B?R2JYUnVZczhBTzFLWm82VlZFd0xkUUVPZ25ObXd1eFZLeGtHZ3FzMGRMZm1I?=
 =?utf-8?B?OUgxUHJ4cndtbTljV0ZteVRRZVp1OUNOOEY5WGlOeUtDSDFHd3lDczhmZTYw?=
 =?utf-8?B?Ry9DZGxQNG5TVTZsdXVMaVVaOUNzZTM2bDlTZHJiaWp1c2tkRGZqMXA2Z01D?=
 =?utf-8?B?ZzlNSXArdVR4c2RsZ3BpNzBnbnBPSnl3ZDBTWnBQVVpvbGJrbk43YXpiSGhX?=
 =?utf-8?B?NFoyZGU5Q0VGL1BGTGsrc1pMOUZseXQwQi9XTHNMMElRSzhnVFR6TTlYVHFN?=
 =?utf-8?B?YkhSWWp0Tjk3dndXcVZ3b0krWjdOZ2ExV214dW4rQUN3ZDVNUENFeGJNS0RR?=
 =?utf-8?B?ZGpsT092Sk9zS2lDa1pXZEQrODZuSTdpVEEzMmM4RXp3OStESWRUVkwwNTlU?=
 =?utf-8?B?QlgwNzBvd0lNS0pIbWwwaUtiNGhnWFBIZ0J4WjV5RUZTemdqTldUSXJ0dysw?=
 =?utf-8?B?NUlBTXluL1hnZVhGK0tPTml3MmdEVUJDVDBSeE0yMUFPVnNlcEcyTGEzNFRZ?=
 =?utf-8?B?aVRMYXNHbFRZbWFHdEZoRWtpL0FCa3AvZGFJYjV6TnpDSndCcmtBcHNlU3l2?=
 =?utf-8?B?RENSeE41ZTNZUFl2Zjc5dHczMVc2UHJkTEZpbVNUNlExTG1OS1VUZXZ1QXRs?=
 =?utf-8?B?cjByM1FYc3c3UEJWRVk4Tm5NcGRLMVkzUWlLK2NVRFEvL1ltemZPaW5TRUZL?=
 =?utf-8?B?WXhocnpheW45dDVsUHpKMUVXRHI0OVJBa05ySTFFMlJ3YndLZDVxc2NBZkZV?=
 =?utf-8?B?RzJiWm1VTGhpSllHbnNIaU1sSkxnajN1aU1WRDBlTkFpZFN1WWR2dXZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0VLNTdVVUVaV0pSYkNkZXBuV0xWdjZOUWVOVytsK095ZHNVZTlsNlRWRzlj?=
 =?utf-8?B?cENhcjNvZE5reUYyYVdXRWxCUi9DTE9nZ2xhQnFoUEhEYnFFaWNtQXR0a3I5?=
 =?utf-8?B?Uy9jbitiMzlhVFdIY2ZXRVZHSGY4Zlovd0VPbDd5dEFobG9Da2ZNY1V2R1BD?=
 =?utf-8?B?MWdZQ3JqczJONkt5NDlkLzJ5dXRVU1d3cUloZ1BlUUo4M20xYXVqYzBIaThE?=
 =?utf-8?B?L3FtRTNXMGErai85dXpHR0RzTzA4RzlsNmRRWVEvTTc4SVBHWjBTREtkOWho?=
 =?utf-8?B?Ty83b3V2V25vNkhsRHZWbGRvVlRXSWtGVWllSHRvKzBWY1N3Q3JxbXhjTlFh?=
 =?utf-8?B?TjJBNU11Yk1nYXBEQlNDNkY5RzRsejlFd1piM3pQTzVZOUlJWUU3bUM0ci9s?=
 =?utf-8?B?akVuTy93NFQwRVpadEFZZ3l6YlpERE5VRU1vYjJiOHhpelppWmttVWdYdXV5?=
 =?utf-8?B?R1JpVmQzNG1rTWJJa0padUF4cG1JVllSWTZjS1ViaFp2RHZySkw5TitDYlRv?=
 =?utf-8?B?OXBiaFdLdmQ2UkZRYmd3UTNlQTJ4SkZna2ZSaXg1RVhYMnI3STdHQnpUajQv?=
 =?utf-8?B?dEhNOXJQMkJSY1Z2Z0pVVjdJZFlhSjB4YUc5YlVSdnR0Y2NIZlRNaDcxNUpJ?=
 =?utf-8?B?SS9qbnFPTzZiRDJZWHpJV0pmSUdxZklsOG5YR3pkK1VrU2R2aEdOWmVzS3lH?=
 =?utf-8?B?cWVjUUI5MTNLTGZ5SVFDZFRXYnpDbDlVNS9PL0pOUjMrbE9KOWdPS0JTYm4x?=
 =?utf-8?B?dWJ2eTJUbU5PU0ZNODMrNFJMTXk5T3FoSTlqSllGeGpwWTNUd3dGNFYrTTdG?=
 =?utf-8?B?Qm9JY0FmemVyM2creUF5U1hFNkFXUVZZRkRSd2NCZWNCTlhRV1RFdEhlOEdO?=
 =?utf-8?B?dTd1UWZNRzR4YStXM0tVNCtnVDJrZThDSnc3bWxnNFEwQ2phWG8zUzAyZmFN?=
 =?utf-8?B?b0s0R1Y1eldVSEwrbTR3L1RIamZQVTBwUm8zMjM0WHFEMDkxNzZYMHgyWUto?=
 =?utf-8?B?SFB4LzRWTHlLNHVFRjVSaEJXcEFiaHp6YlhBY3NPaEx3NWN0K0loMlU2bVFR?=
 =?utf-8?B?ZUZjcXdvZDQ5MDVUZG8waVlnVmdmaFBjbEV2MDdRd0JBUGpQN1NMQ2NRTTBx?=
 =?utf-8?B?L2t1UVBHRnZnalkyMG9FMHdDNTA5RUN5dm41c1pMVDZwcFJlb0NOcUE4YUUy?=
 =?utf-8?B?YU5BbUtXeTZaUkdTanJJdW9NRytpaDdWVDRQZ2tMbDlaTU5JTnVzYXVVdWRY?=
 =?utf-8?B?cmJqWUdhUUYzWnhSZ2t3ZG9ON3ZIYUpRbGt5M1dyZnlINDNxZVhVZlkwcmJy?=
 =?utf-8?B?SlBUZnVZTVN4NGxXeUMwdXJ1emdBREVUWkkvKzlDdEsyR3NDQXhPRzVzUnRP?=
 =?utf-8?B?Z2dMdEJCSWdaWlpicHQ2ODg3L0w2aTFITTE0MTNLYXVGMWFMTU9oaDhUWG9m?=
 =?utf-8?B?alMwY25lZnplRmhMVGtQeWtKd0hwNE13WUhSd1ZFYXFJMW02eGFudWNYSVli?=
 =?utf-8?B?bXFaM2kzeDFTNkFtazVLOURpS3QwQ3Myb29lZ0FJS3hBamZVbENDY24vSHJN?=
 =?utf-8?B?akJReXJVaXhES1ZmcS9CT0VJM2J6bEhOc3VUNGQ5aFl5SWMydW4zR2YyU0RY?=
 =?utf-8?B?RUQ5KzY2RDR0UGZsaTVIVy95OWF2Z1oyOFI5Y1R0UkVtaVlqMk53Z1JoSkE0?=
 =?utf-8?B?K3VCM05MRC9EZVhUbU9iSWtPSG9ydk1ram03ZDVWR0lpQkR3dlhFVjNOMlhY?=
 =?utf-8?B?Y0xwNmFWWWpRNktIaHg1SjF0S1Q4ZEFRTSsxclRhWkJSekE2NHVHN2lGS3ZF?=
 =?utf-8?B?NnFQMXdYOGZnMG5mSmM3T1FrbHJYWm5zUW9HckhnT2REeWJsblRES015M1cw?=
 =?utf-8?B?MDEvQWJvL3REKzg5OXNSaVRuTTNEekJ3QkUzM1I3TVlKcDJUUCtxeUE1VzFL?=
 =?utf-8?B?K2RvRUFKN2tXVmNDWUhsSnZOQ1Fnc1p5dlJrelJ2VjdnT0g1ZWo1WU5ZdGgy?=
 =?utf-8?B?WGw4RWhuTnhReWN6TmR4UmQ4Vm5vYkdiM2FaSEo0VDlkTUpYOXRTUzduRkFy?=
 =?utf-8?B?S2VJRllLKzduazNHWUZnKzRvSGcraTVvS2tYbTlOSEZwTmNUV2NaRCs0LzAr?=
 =?utf-8?Q?1nxXOC8XCjexzsLxNszh/dVrm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0529fae8-7d41-41bc-9130-08dcdc9cbfcd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 13:28:17.3528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLZOcSvvkJXqcdEHgPAHVvDUnIGVBfSuBlxYyU4E1pWng+h9ojsxO+b129WxtO4Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001
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

Am 24.09.24 um 14:57 schrieb Sunil Khatri:
> To handle amdgpu_device reference for different GPUs
> we add it's reference in each ip block which can be
> used to differentiate between difference gpu devices.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
>   2 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5b06c052ffbc..c83207a01763 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -391,6 +391,7 @@ struct amdgpu_ip_block_version {
>   struct amdgpu_ip_block {
>   	struct amdgpu_ip_block_status status;
>   	const struct amdgpu_ip_block_version *version;
> +	struct amdgpu_device *adev;
>   };
>   
>   int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index dee57f15719e..c4d4fbcfca7a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2337,6 +2337,8 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
>   	DRM_INFO("add ip block number %d <%s>\n", adev->num_ip_blocks,
>   		  ip_block_version->funcs->name);
>   
> +	adev->ip_blocks[adev->num_ip_blocks].adev = adev;
> +
>   	adev->ip_blocks[adev->num_ip_blocks++].version = ip_block_version;
>   
>   	return 0;

