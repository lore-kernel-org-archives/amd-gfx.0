Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8F6EF8FEA
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 13:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E9610EA40;
	Wed,  4 Mar 2026 13:57:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yzXW964B";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013005.outbound.protection.outlook.com
 [40.93.196.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FAB810EA50
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 13:57:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=my72XMSiyQbOnpefA4qR2txPy9V7UfORehBR+BEg2jlHsi5gCbDA8IGoiwR0Vb/e0ebEFA5Y3Gqlj64VjHNY3g9kWDZsjYpC8Q1MJt++m78O6ZFjKD7POFgrKOgX4Z9zAdFVHgIidrNGXBixQFdTprFSbyTcb+GKm5mJ9KSTyO8htmsJL8zKcp8NpYvb4Zf9ye5wiA7HuORLOaibEpF63vz/tKowLnA+SVpukAZ5eThjKV2KTPpsHLWQ1b/h+IpJBE6S5chHWHgky82IQJnm3NJCHLNHWhNkgpz4sLyES/ABMNTA1x293k7Kp4lRffEDeLlAeFBpQ6TlKQW8NRJeyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppXj+nWRoBEVj0zCgOVTKrT7eHTlljueHPX8Ui9pLeo=;
 b=UWKeZ2znLKwK05MBTuC5qdlHOitAIT59bW8/o9oDV4qyum2x1mhetB1mHGgnIltoR28ajmpjwfSCJh9H+k9DtTvMo0M60SKlSqQj1p4ApGVSaEgXlgBF+bPG5wgWF8CVASvdT3pNmUvscEbvrAQYXl05IsaC5HCO1X7S/bnt4ZorcWox+bhnspNN43OAyg2Ku8oK0bWNYCq/BhjkmAeA0koBFFB0kOqLKn2O17YFs3InTEOaiuOFQL6F7hCqlsgi+Pqx5HZXqa0z74ft2McwAg2dg55589FdHT3v+hajJerqb9UsEcCJkT01kfWsAsCNx7QIcFbIfIIAqKpQD18RxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppXj+nWRoBEVj0zCgOVTKrT7eHTlljueHPX8Ui9pLeo=;
 b=yzXW964BdkAq8y/c5nqRyqXemgfFp4f9okcCgRx0CysRaGbHtCG6QmqNGXb20S3u99Ell1zUGq/1TKS6o8ulfP9MTMx75OV9/qsloIIz7872cEpcSiucWVfMpbkZOI5+JndTd7a80JqGiulMZmoLPDxehYRtwNmiSrvuPQbxkr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY1PR12MB9674.namprd12.prod.outlook.com (2603:10b6:930:106::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 13:56:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 13:56:59 +0000
Message-ID: <bae8f0a1-2dba-4286-ae28-78f0a3c63faa@amd.com>
Date: Wed, 4 Mar 2026 14:56:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu: attach tlb fence to the PTs update"
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Prike Liang <Prike.Liang@amd.com>
References: <20260304135425.18729-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260304135425.18729-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0256.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY1PR12MB9674:EE_
X-MS-Office365-Filtering-Correlation-Id: 645daa12-e4c7-4e17-42fe-08de79f5e7a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: MQ7MSPOZJRnrgNmuBgdgZDy+VoqtCy8wVLmycIZVGHsL6IsiyWU9NbitWUHjub4PyoFSCRjYt+RswFiDNQaGA+8Rzj74DuabbyFssbsOimvRaOCU1WPsNRPisnsTG4sgmNUtMGkc/oAUUflWtQFDjke3jCyz6xaFNf3Zh4p23nEi1EaIeM+11mD2waMGz08YDzs95mFXV0BgSGzFr1/EOBCi5RucaZq8syCCTPGpSkXHGr0QOehIE+XdDfjbuVNayHUZNOIY150VjJkcr0pdPXgD6+C3S46dGsjXb2u4nelkLBtx7rfuQqmV4JZFUv8oWVtQpv4o2fl7xcz8HmOThwNxG27ZokyyA7td1eDRDm4KWU2N7xGGnTQ009kbZyqxvWrSm8XsQJ4ZFfVVW0l0tetk9naUjwnZGz12gSQmaLOpmxUM/+47PcId1kJmi1z6/LiQ9SiyGbFxAJGyRGF8D7jddS/RsXBJFZbKICVk2ekCLWSLSv+DYlgb0mKmUl4RJu9/Ef9PMIqUpP1CTQn9GDaraL0LORekSqdl3ZNycMTk6YYqd2ppkD8ChAi/HiYIoudXf7qf++LGhDMp3e+FFCmFRzpq48dOgMj+DmNYVrGe1FUfRvuSAeszPO8F8mn0/dkXkNnB7QfYdThk9C5oIMl/gEQuKIIoXzerQxHS7lY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnljUTRVaVNQcWx1WXVSdjJvZ2NzU1M0TCtCUFJBdkNhd1lUOEFyVDNHWTJU?=
 =?utf-8?B?bDREN2JIalpEUmRzMnlRZkl3enhSYUt4Smt5RE5xbGsyM1RFTytxZ0tlWHBF?=
 =?utf-8?B?UGNzYlFWZGFrQ0tGYkM0TG53Mng2bHgxeFovamhDcERRK2ZJZ0NsL3BSV0Jp?=
 =?utf-8?B?Q0ErbjM5NlFod0pBcGh6K0FMMTlBUS9lekFkcHhkMGN4YlBSUFpwbEhwNUdQ?=
 =?utf-8?B?YXZON1J2bER1WmFuNVUyT0h4YzhDekIwTHkvMXRhQnZGL3gwcFBFcjBoOEds?=
 =?utf-8?B?V0pDM2djVTZrb2ZGWWM0emtpb2cyTVZUK3FodDdjM0xvMlFVMkhHMlFlcmQz?=
 =?utf-8?B?a0lXOGlWaEQ3QVJsZHV3aWdQcjZhajhQVzFZaDl3czJNVGhMaEY0NzliYXcy?=
 =?utf-8?B?RVNQR0FGbG4xVkZHWUIyRndqVFVpME4zWDgydzM5VFVxTU1tS1pPQlZmZ3RB?=
 =?utf-8?B?UnB2MnFlYmFxajFja3ZtYnZCMUZRQ3V3M0RDaEJLU0wwZGpUeG0ySjFVS2dJ?=
 =?utf-8?B?ZlVpZ0J4R3VJdmxSY0N3alhvaVhBbWQxQUVJRHFLK252OG5VZmNyb3pTb0xD?=
 =?utf-8?B?Ylo5VlJocjF3S1lCcGxiWERYUVBVakc1c0xHTjBEbFZtYlZRelpTY3krZDhB?=
 =?utf-8?B?dklWOWpjTk1RR3BNMGgwU2VyaGxNb29uOTdhT2dTZ0UzbG9EZEo1VzZiRC93?=
 =?utf-8?B?dStoMytBak5DbW9UZklXMHBrdTBZd3lHWVFSN2VKUDRVYkxrMUd2bisxRnBy?=
 =?utf-8?B?dWMxRTE0MkV2QU9GTG42WEZianR0K0Z4TFVIaTFMTFlXalNKY2ZCYWh2Wk5n?=
 =?utf-8?B?eXgyMTJEQ1U4ZGVYa2dsTExxYkJiQllub2Y1T2J2TERSbnFjcFBJTDdvWW5a?=
 =?utf-8?B?Nno1eWk1SlZpM1U0R0c3eTFBYzhFcG92YmpQSGwzbWpmYitUMWc4STJhQVUw?=
 =?utf-8?B?aEVHODMxVzNOOUhCYzRGYmtnRGxTdW8rWFlpZ2w0bzFmbG43aWp5blNXalRr?=
 =?utf-8?B?NDJ0Zjd4MXZiZUY0eW5QWEFRTzdiUTRNdzcwdm1WR2ZPZDBPenRVUndjTlVp?=
 =?utf-8?B?RzZyOGFtMC9UN3k3UFpRVTRYSHAvMjdvNlI4cDl2SVprMWk4ZGt5cFIwSWJP?=
 =?utf-8?B?ZjRYazRRZzZsOGc1Wlc3ZVZOdzJyTzdweDBmSHBIUXRBRkJrMzM0UXRDQ053?=
 =?utf-8?B?MXpKa1JleEpjN0MxclRRMGxZdDM5aks5NkhtSTR4QWhLZU9tZmYvaHZOeDZr?=
 =?utf-8?B?Q2dJRElFQUFLOWI3aldxSFQ3U3YxR1VVWTBvbGRZVVdkZm1laFF3ZHhmL3dk?=
 =?utf-8?B?VGFhM2Z3NnhiRWwwNnUvdCt5Vms5OGxERnAyc0I2YUJBMDlGK0FZK3RTYjNG?=
 =?utf-8?B?QjFGL0J1REJrelFKalkvc2tVREl4RThKc0FvTzkybDdyTUwrSFNhWk1aUjl0?=
 =?utf-8?B?cW5HQ1pWaHVaMUtaQ2FPa3BmMnZVY1VUand5cHFGTlVEV25IVjBHbWxMNGRj?=
 =?utf-8?B?WU8vL29tL2UrSGh5UlhCS3NCMUZQYU00aUNwMmxnbWFWQUx0STEvQjhpd3hD?=
 =?utf-8?B?Sy9CNXZtL0RORnovSWkySGJKbDNJMkZJV3dqaWlwWGNtZVc2VG9Ka01Iekht?=
 =?utf-8?B?K29LajExV00rMEJxTGlZcFFnakVCUi9sZDhyNkplWHRCMlZwUkZNc1IySTFl?=
 =?utf-8?B?YTFIVklDWEdqakhJbHp4RWltN3NIQ1h5dWdnL0F5RVpzSXhVdVVzVGpWMHor?=
 =?utf-8?B?VUU4cVZBdUNEREl2cnVqbEJLTTNVY1NSa1J4SEFwU0JXSmtXSGc4cG5ZQTRX?=
 =?utf-8?B?TzhsVEY3ZnZraVA2MVU4aGZVcDRwbFl4Z1dEb0lkRGM2ZmtudjVDbjEwTEtS?=
 =?utf-8?B?RDBsbk5SK3dQMnJldG42K0N5dHdtS3pQa3JaNHJLNjgyZTdmaElOOWEyWFFq?=
 =?utf-8?B?VzdhTmNMSEoraGM2ZUt5cFVyaXhIUy9NK3JwUUNXUzBGdXd6UnlNZFVod1Zw?=
 =?utf-8?B?MGdYTXZxY2JsNzQxNUplWk4yUitnQzNPQlo1Y0RtRWZKWVJmMmwwMHRSQ245?=
 =?utf-8?B?Z0V0NmdMSS9rU2VxUXBpNFpKdDNzaHZnRnh5ZkwyNnQ0ak1tbkhyQkRzNk1r?=
 =?utf-8?B?cWZVa1RVeEtYM2hIaG5ENithbEhBMyt1RDk4NDI0czNLUHBtdksxVnlTZ1Zv?=
 =?utf-8?B?ZTQ3dGZLd3hlOUpZenhxMjlXSFgzb2ZWMUNDZVJDM3BGM1p2VEJmN1RuOWRy?=
 =?utf-8?B?dDJmKzN5RmNvNVQyVFVydE15ZHhZZ3FzTWJZaDRGaDlhUllpeEJpVUFqcmdN?=
 =?utf-8?Q?bbSvGgwfGX4vt0U7FU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645daa12-e4c7-4e17-42fe-08de79f5e7a1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 13:56:59.6715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8SjxFlTKsdt4bQFMEbr5jz4rDuLAshib76HsotwXYfKuR2GSOLGbvKuj/runIZM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9674
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

On 3/4/26 14:54, Alex Deucher wrote:
> This reverts commit f3854e04b708d73276c4488231a8bd66d30b4671.
> 
> This causes framebuffer corruption after suspend.

But prevents massive memory corruption with userqueues.

I have strong doubts that this is related to the FB corruption in any way, it will just change the timing.

Regards,
Christian.

> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4798
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Prike Liang <Prike.Liang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 01fef0e4f4085..25b1d679ba262 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1073,7 +1073,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>  	}
>  
>  	/* Prepare a TLB flush fence to be attached to PTs */
> -	if (!params->unlocked) {
> +	if (!params->unlocked && vm->is_compute_context) {
>  		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
>  
>  		/* Makes sure no PD/PT is freed before the flush */

