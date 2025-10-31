Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4454CCF9EE
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 07:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F6E210E2B1;
	Fri, 31 Oct 2025 07:42:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cjQntLyY";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3120B10E2B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 07:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1jARnzG2ySRiJiBYUtbVRKN3ZtxOoDSO2I3AioWbRoVUrAu/T0zFV1ZALkW2Z2KaXgjVyBvVM0RJVwbe/SkkMGHogWxgyp0UQh7ElKYPPaVHEagJbtwII/dHRKEWQTODNrEAgpACgCjerXCIV9mCPyi/mSjMEjk3k1yAxKKY/T5J+X17MVUYEcb4g4p7ABvnft002X3z7/+Ihn4a2Remm0NdpRdURteChu72tCzF6k8XS33Vy35IV0vCiZ3N2Ni2To9xaqCsQku0Ie/moyuVafH8X1LA8ACu4cLEPr4+c1MEHBrLa1kdCXNbVVHtuWj7Y4dVJYvdMFbDpI7AS65OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pl8aLdPNQqyh3XMha/IR38CM5IwYC6DeL+RA1PzFELA=;
 b=Rb3PWlUa0l73CDhYMaQrlkyuc+x4R3wkD4UTXLBmW75XwDV3eSxzHvKvMqLLb2g1LtGfRZ6EetbnRpBvEvExdufbh7uL3+X6sgbnMX3YBczkX6fs/XJHoLOnUcZAfD6aXHiId0sAcqzavLbbrW5LiFZo4nJLfJO9p8iDnDi79T303Y4KB9ZI704zuTWoNET25ZIiHuw4hQxKv9W37r16QaR0hKO0E5MT+Pz8dT+/sDyTbhifr1i99cn8dMhUG7G/iQ+Rc3Vuvles0AnS9dfINmKXqEEmq23RFiCiSzYJ+JDEQ43c4rchbJwe+mPWj5jLEfZ+XdkgMIm+InpXZbCYvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pl8aLdPNQqyh3XMha/IR38CM5IwYC6DeL+RA1PzFELA=;
 b=cjQntLyYInLD0dLPQcx1kKHcOUvJM62TaOFNwwrx84v4+pyJF0dq7VYZEIRBJcJB2oEsL+31lF8C9pyXsG9QhjRlvLeDP6iKFR3umd1/aO2q2rN3BvwzU8KZB5QwUCISP9hb0bcZv6GnRqrDFwB5ip2HznrqgvjJZi5WIipVFwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 07:42:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 07:42:14 +0000
Message-ID: <a901ee14-81ce-4cfd-bdde-21eeb57fb965@amd.com>
Date: Fri, 31 Oct 2025 08:42:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Don't clear PT after process killed
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Gang.Ba@amd.com
References: <20251030190125.15969-1-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251030190125.15969-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5e1d53-9cdf-404e-f27f-08de1851022a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alAwa1d4NWNvMW5LRkluQ3BndHVKM3JmdUVtQnFBNjVyWXNDSStzd1A1UkIv?=
 =?utf-8?B?cCt6d1p4WW1saWlYaHArYlU5M2psTVp3R3V1V1hzb3Jia3hEOXNPMERxUGZV?=
 =?utf-8?B?VEJJSGRmVzc2TFBzcElIM0tod1Uwb1dqWWhYNUVLVGhwdlFPQU5iRnBCRWtN?=
 =?utf-8?B?Q0dtczgwS1lSdlM1Q2pYSkV1WUVSVjMzU1lndktZM1d2S3hJbXhNckxBdkRI?=
 =?utf-8?B?bVZsZXdPVGNyRzJsWXRQNDAyK3lIZjBUTlI5aTdEeDlQcStieWU5S2luQjlS?=
 =?utf-8?B?ZE9RUUhXUEp6YTNTU1hPRk9DbG9UZlUzczdRQXJKdUJNZERkcVNHUFhSclJN?=
 =?utf-8?B?NGRyS1lYcGxDbDBCYzEyQTRRYTZyMmx5aTBWa1VYWDh2aHVNcjdQSGlhVVhJ?=
 =?utf-8?B?Q3F0ODBDS1ZRaUpmNEFvOVRWTXNiQ0VJL3JEQkVpVzhzMXZPRE5RSnlZczM4?=
 =?utf-8?B?Z0lrV1pMZitzN2VFa3R6Z05kVGxpNnZSay9JNU11TEV2MDRMTldLNnMyV2Yx?=
 =?utf-8?B?ZnptNmZqZ3RRNEtzWmliaTE5cEhQU1BTZEU3cVJMZld5K0ZHcTloR1VRRWVQ?=
 =?utf-8?B?VXBQTE9uUUlWcU41VzdobWdlRkx4SnlCZEQyY3RvQno2dGNQSmN6U2JORXo3?=
 =?utf-8?B?bllycVpYaDZqT3o1OUo2UkRkcjZXUlIrNGlwVkFGTWhKVHJ1VEZDV2kvK1gy?=
 =?utf-8?B?K0JrVjRUY0pvcmx0dnVScHQyYytVR3VXT3JWbkVGY2NmaFZZaVVhb3dhL0hR?=
 =?utf-8?B?VkpVdkhHUDY1SmZjdVlLdzNiWEdUd24xRFdWSjBBSjRTbG9mNWI5a1JEUWh1?=
 =?utf-8?B?aG81endqanZtNXprbStDbEkvZm9IUEkzaVAzNXpPZStJZ0F1NmRzMDRVc21Q?=
 =?utf-8?B?UG1zVXkvaFFtUkJGOUxiU1FvT3dxQ3l3T1dzNHdCK25IeVFpci9UenBhUVJB?=
 =?utf-8?B?Ym85VWtoK3Vnak9TWEJwYXRrb1dIV0l1WjlkRTBiNjN0Uk00dXNuYXB4VlVu?=
 =?utf-8?B?MTlYOGdGYWpUeVEvMkF2QmpPOWoybHg2Q3ptaC9TOXBJdEQ0aHFuQ1lpcmFC?=
 =?utf-8?B?Z2tJUjFnay9iSFhJUGVQY0NYdjB0TTg1QjdWeGRXTXZqcWl3MUxWRUMxRzI4?=
 =?utf-8?B?c0xnRDQySmsveWwvajAweDJoekR3R3AvaGIxdXlMTCsxSUcvUExCS2RMSS9j?=
 =?utf-8?B?R1ZVaW5ZV1QyaDkvT1pDU2NmOGFTOTRvbDVWZ213RCt2ZVlwMVdHc2VoNTlu?=
 =?utf-8?B?clVVR2lQNVk3Y204M0JKWGt0dG9CR28vdVlNWE5odTdYRStFTllpSE9GTzRJ?=
 =?utf-8?B?bHhRZXZnTmhtRytNOVZqUVZuUnpBMHFPZnpmOXIxcS9lYzBrcUk3alBrb3l6?=
 =?utf-8?B?VTA5VXdkempzd1FsZ0doUUt0dlp5NlFBQnMraCtPVzVvN2NwT3JwMkx4ZktR?=
 =?utf-8?B?cEVJWDZPQS9vcEtlMHNZenFwb1l0aTgvQU96dGNpTlJWMDlwRjlvTWJIdEdZ?=
 =?utf-8?B?NGJtNjNnMVVBbWwrd1Z0MEpybTRIODFUcWJ1L0swWEVFOVFxRzR3eWF2OVJC?=
 =?utf-8?B?MDBNaWE3aWdTNW1mOSsxcjJUaFRKUVluaFoxSkdkMmo1VStZbHdPN3BBL3g3?=
 =?utf-8?B?aTY1M2xmcmU4cmtJZ1lmOWhlejh3dW5WY0JKdlUvUENtY3BPWi9ldW1JQmRo?=
 =?utf-8?B?QldlQkROWUhCcm9CTXdkaEkyYnVReVV4YkpVRjJlRzMxbGpEQjFHak5jcXpt?=
 =?utf-8?B?Z1JTM28vaHZIRGdLZC93MmUyNUlKN1h6ZGVqdDl0OG1aSkdxL3lSRjh6M3c2?=
 =?utf-8?B?QlhFQm9lY01UbzhUa0lBT1UxaHExNG9ydm91cWx3ZEpoOUkxN0VMWjNTdU44?=
 =?utf-8?B?eFBjQkk4SkxjL3U5YlF0bFhBaTBSQU82OGVEclY3cE1iNDRkWFg0b0NBZzlD?=
 =?utf-8?Q?Gh+rSpYjjVqjcxEKtV+Khg4dmQtD9V+O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2VuTUNGVmJuYkt6WThGRzJXR2lJQWw2T0ViRTdaTXZBZDhqNStVbzJzOWlZ?=
 =?utf-8?B?dVo1MUNjcFJxTFkzVXhUaldKNmFuTmpMUk5saTFscWIwNHVpZVpYS2NQaEVN?=
 =?utf-8?B?aEdsZ3d0YlZ2eFVMeUtzc01HSWlLdENOck96cy8vRFYwY1hmdFRQbHRvUzBt?=
 =?utf-8?B?a2V1OHBxbDdCZmpJMFVvLy9OV0ErYnZadlhUaklCZThoaGJ3SW5lci9EVEdv?=
 =?utf-8?B?OG4wNFZTdUl0bkhjRVo1eklaM25SY1hLdnFWa2t0YjNuOG54UVNnZVBWeTVa?=
 =?utf-8?B?Q1Z0bGFSUEluLytDd0FXQS9xS0FzYjN4ajJsaFJQVkY5MW5BRWtFd2IySXFB?=
 =?utf-8?B?aDZxMUp4MkUxWFNtdjAvbXZiNk8xTTFwc3N4WVFjeEZsT3NwL0o1QTB2T2Fp?=
 =?utf-8?B?QWlab1M2dGpNc1lhREdubk5BOUp2TVk0cmxzSnBqNCsrOFV0c1pFMlcyQUlY?=
 =?utf-8?B?NWNTYklhQnUyVDI5a2JyeDMvQVNhWmNKRWtKR3VzU0RXV25EMW15TDZqb0di?=
 =?utf-8?B?c1FyUnBrZ0NhNVpBR3M2SmVNYmJFcEJ2eGh2YktXVFM3TjI5L1Y1d00vOXhm?=
 =?utf-8?B?OGdMblRUQlJjOFZsV3IyaThMMmt2a1JBeVdjMmVDdUNvUW9jbFVBZ1lWUGpy?=
 =?utf-8?B?RzVGdWZsM1lUendlK0tDeGRxN2NoZG9RSjN4ZzlZQWxnMWk5cVBYMy90VzVl?=
 =?utf-8?B?WjZnMm5YZ2ZUQTVEaXV1ajBVdWlDQ2ExUFNiMWpyUVVmaFN6bWdwejNuY1E0?=
 =?utf-8?B?bm1HNWVpaVlWbk4wczFja1VPRXJZT0g2R1hvOTFyZ1VUbjArOHJ4aXNvYnl1?=
 =?utf-8?B?elJpaWFKZXMvcy8ydDBXZWVPVldYakQ3MWRvS1J5RnA4OFkvalVGUlJhb3hI?=
 =?utf-8?B?Ynd2cmViTDI1NkE1MkcvS3ZieHpmdm5QZjNHQzQva3NYWDBMWnRNd28xdDQ5?=
 =?utf-8?B?WUo5QVRHdEEyb096eDVHTUc4aXFTVGZNNG5TY2h5bjd4WWxxNTl2V3lxeGpC?=
 =?utf-8?B?SEVHV1BsWVhLRzkrWUxzZEdLRy8yNlhQREhQOS9zeFpoTjhaZSs0ZzE2Q3dB?=
 =?utf-8?B?MmltaGZIUE5iT245NjR6RFJocEcwK0swWGcrWFkySVBMeDZWZ01waFEvVGgv?=
 =?utf-8?B?YkVqZm1WM1YxK0c1Rk9CeHF4Qk5ha1dzRldTWEVKUzQvbmxJTXIrRzB6eGxi?=
 =?utf-8?B?L0t4dmphQ1VDQml0d1FNWkloS3NZYWx0RkNNRVhXSVptRmZxbnh5SC9jN3VR?=
 =?utf-8?B?cE1mY2N3dXR4anMrN3FZNDNzOERNV2xrQ2c2bDFMYmc5NnBEYk9WVDZmMW51?=
 =?utf-8?B?d2ZRSHd3TEJsZWxnNWhPVlcrTUpNblYyd2hIakFFT3dQVVNFY2lneTFZQkc2?=
 =?utf-8?B?dGVTWWk3UWxuR2ZGb1ZtZ1hzL2QwSkRyTkd2ZHZ5aXhEM2s5SXNmY0tlMEZJ?=
 =?utf-8?B?cjBtQ3pHcU5PNTdMZE9YZHIxM0VLcXh5V1E2eTFUejQ4WWtVOEd2UU1tVE5Z?=
 =?utf-8?B?dnE1Z1BKRURPVmZidmdrbVlicUhHU1pYUzVCSU9mWFdLbDFLdVpMdlNseFZK?=
 =?utf-8?B?T0dYMEQ5SlRJWmQ0N3Z2YjE5UEF5dE40MGtNb2JWNmczdWVWRSsyM0hPY1Nt?=
 =?utf-8?B?ZWltang3TXhJVjJNbnBvVlJ3clg4MFZQTngzbUFRcUo4YlU2VFo0WW5jS3cy?=
 =?utf-8?B?OFE5YXVOVWQ5UEpONU9tRVlKQmlCZjdvUE5JQVhsT245QkVuV1lQMFdBUzh5?=
 =?utf-8?B?OHlqZU51eHRZV3RhVXNKUk9sZWtZSEZPQXJYRzE0MmR5WUE1Y1M2bGcyQ2R1?=
 =?utf-8?B?dnhaOFVVUFVWZGNEdVZtWHAzekpxRmNRbWQ0TjJFeG5yRU9Cdit3SnNYZ1hR?=
 =?utf-8?B?djgvbUZRY1ZHakVwcTFoSWxoNXludzhudGtlMlFYc0tqQUt6anIraVpxdVdP?=
 =?utf-8?B?Q204OTdNUlpuZzMrakhQWm13bzZuM0I1SHZ4Q3dKRkU2T3V5SmpjUEZvV2NE?=
 =?utf-8?B?SStmTVp1Z2RpSkFiaWZabjZFOVVhUEl6SUh3K3ZBenZ0S2VvU1liR25IRDBS?=
 =?utf-8?B?VUF4VHdmQUQxTmVTa3NMRTljeHNzZE1kUTRjYjIxcXRad3BtTXVPUVd1NTZE?=
 =?utf-8?Q?a8vWgN6gKlb03uiWJWz39WUWF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5e1d53-9cdf-404e-f27f-08de1851022a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 07:42:14.4973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDaSPiYZN77onvOo1ZNKMawAUFSd9hW4wP1JrnXOQkCAb1wYmUwwuXQsrQ0nkcTv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
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

On 10/30/25 20:01, Philip Yang wrote:
> Move amdgpu_vm_ready check to inside amdgpu_vm_clear_freed, this removes
> the duplicate code, also removes the error message "*ERROR* Trying to
> push to a killed entity" when KFD release wq unmap_bo_from_gpuvm to
> unmap outstanding BOs if using SDMA update page table.

In general good idea to have that fixed, but the ready check should stay outside of amdgpu_vm_clear_freed().

Background is that there are more operations than only clearling the freed covered by this check.

Regards,
Christian.

> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 3 ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 9 ++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 2 ++
>  3 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index ecdfe6cb36cc..6e1a5b922eb1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1116,9 +1116,6 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>  		}
>  	}
>  
> -	if (!amdgpu_vm_ready(vm))
> -		return -EINVAL;
> -
>  	r = amdgpu_vm_clear_freed(adev, vm, NULL);
>  	if (r)
>  		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index ce073e894584..f6c297d62cfe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -373,11 +373,9 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>  
>  	amdgpu_vm_bo_del(adev, bo_va);
>  	amdgpu_vm_bo_update_shared(bo);
> -	if (!amdgpu_vm_ready(vm))
> -		goto out_unlock;
>  
>  	r = amdgpu_vm_clear_freed(adev, vm, &fence);
> -	if (unlikely(r < 0))
> +	if (unlikely(r < 0 && r != -EINVAL))
>  		dev_err(adev->dev, "failed to clear page "
>  			"tables on GEM object close (%ld)\n", r);
>  	if (r || !fence)
> @@ -387,7 +385,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>  	dma_fence_put(fence);
>  
>  out_unlock:
> -	if (r)
> +	if (r && r != -EINVAL)
>  		dev_err(adev->dev, "leaking bo va (%ld)\n", r);
>  	drm_exec_fini(&exec);
>  }
> @@ -766,9 +764,6 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  	struct dma_fence *fence = dma_fence_get_stub();
>  	int r;
>  
> -	if (!amdgpu_vm_ready(vm))
> -		return fence;
> -
>  	r = amdgpu_vm_clear_freed(adev, vm, &fence);
>  	if (r)
>  		goto error;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index db66b4232de0..febdd1b4286c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1543,6 +1543,8 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>  	struct amdgpu_sync sync;
>  	int r;
>  
> +	if (!amdgpu_vm_ready(vm))
> +		return -EINVAL;
>  
>  	/*
>  	 * Implicitly sync to command submissions in the same VM before

