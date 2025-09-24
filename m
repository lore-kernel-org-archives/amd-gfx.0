Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0715CAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 09:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DB6D10E6C6;
	Wed, 24 Sep 2025 09:15:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JROjQgnQ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B17B410E6C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 09:15:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtQ5WzGDxP9oeUW2EnenUDiRRMLJQ/F03z90453+CSjlITCjjqaA/bjb2eZkzhNBiXDAJ8L2LBSTxCW12GeWmBHDUbnzOE/2zIKT3ecAPRCNbJjLxvOwvvW6l9LQXAy9cA+qhoIdNe8zGk1GKFeH/whZ1DV1PKKU/5fgiXUd4QpsO22m3R8qOyWuOQAKfPV7Wdt4X7ZjMgtt7Z0/pAp2k4yQSnAcvfzG1f9NT/xiThLPJ22RZ6feP/6LMFsZHw6xAFMGN/BlK6afPptTSavnVqYimZd9wYZfEnLE91mXVGaHPF9jpgmJALCgtFcHP/z8v/FwJABTxL5M0eApQSHdlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hdma6BnQ0RpsSRHIWLFAhaAOUrL6cr9+nSjOVANiqgc=;
 b=brRBfVUB2cXGZ5QhrU7fE4kYlP+VzNW1alnZw+Ev0bP5N4fXYWRvz6ItKxz044MiE0Y/4KZHt2FIRNCKXx9fkr1UZ8UpWFO6887DnDBQHfxOm8dEtkQfJ1sNjEPvb7SstXNcAHGJsIiDciiZaxRIT5wXAkdU7/wWPRs4qZAGwj07W8mpPteD+vTtkoXlwLqcAlTj1tlaEjv7y3x+iGOeaJ9YOz6QpwzImN/EqL5Bek0AHJn+tDLiePiUOX01Kw9rIR7+lUARWfcQEQr61C+uE6ki3/7GCQGiCa21a7cft79BfDvLcX8x4saYcQa7BcXQGmGbVeXjssSSI39xRlb+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hdma6BnQ0RpsSRHIWLFAhaAOUrL6cr9+nSjOVANiqgc=;
 b=JROjQgnQyYJDcofrfgXZx02IC0CD4FmORL3NBNdeWU3mfvaA0knnYW+YGvhP4/C11PKFH5Y5o9EWgvcginA8WPmQPoIe24etfrfge7agBdh0cMHRJwj7fJRcuPqWaw1WjwXBINl5ku+bYIv8BuZcJH2oKuunuA2YuUJzyw0JQh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6027.namprd12.prod.outlook.com (2603:10b6:a03:48a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 09:15:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 09:15:09 +0000
Message-ID: <413a4029-95d3-490a-92e5-f712ae1fd920@amd.com>
Date: Wed, 24 Sep 2025 11:15:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1] drm/amdgpu: use user provided hmm_range buffer in
 amdgpu_ttm_tt_get_user_pages
To: Sunil Khatri <sunil.khatri@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250924074517.3608226-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250924074517.3608226-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:208:530::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d69eb1b-435a-42bc-8740-08ddfb4adc1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anMzRGhRNmNwZmVWTjRCY1R4Qko3YUkvR0wvSnkzL2tXOElBN0FRbll0ckRz?=
 =?utf-8?B?ZjZLSzNEOUFYMXZJWm94TUtOMCt4a0RHc0p0SzMwOEdMZlEvK3ptNkVidWRm?=
 =?utf-8?B?MXBZM256T1Y5WXZ0bVFpZHM1NWNERGtJN2puTFlkTCtsUnlqeUxybU9pVFZI?=
 =?utf-8?B?YnBlbDNVd1B1ZjlMaytTM1pCM2JJaFN4eFUyT0tSZklsVmgybkNHT0xQckFP?=
 =?utf-8?B?cFBBMEhFbG81OU1ER0lRSHIrMkJlWWpVR3hCNkZ4VTJzN1UzRTh3aFVRRmFP?=
 =?utf-8?B?cC9PcTNPTGw1Q3BXT2pzY3ZiempGdUFFTHhWTzlvYTk3NmMyeG56YW5naWRM?=
 =?utf-8?B?Q0gzR0Z1bTBuWElhNXR2ZUZuQ0pwS3JLVjhxK1lRRkdqczR2eUJ5T2tNcDBX?=
 =?utf-8?B?YW05N1VEQnUxTjdnbjg4VVl6dnZ0U3lxdk9TaHV2aThEYWVmdlBRVnFReE10?=
 =?utf-8?B?RDZUSDBSN2lHZE5SbS9xdGduTER0K2NqQ3hlQnp5QmRaOTdYTnJuWUlrcHNX?=
 =?utf-8?B?RWZOZnBzS05QUzZLZEFzK3ArbjZBUmFBaiswMWRJUDJodERhQTF1eWIvS2hX?=
 =?utf-8?B?NGloNjgvcUgzTEgwWm51aGFOTzlldU94N3VHMytVOVQzWmdmTm1HaEZDRm5X?=
 =?utf-8?B?SGN6ZXJ0QTFWaGZKWXM4N2I4Kzc3L1RMdTY4YXplVzdSS3NtT1FKKzZQVVFi?=
 =?utf-8?B?OFpYTUt6SXZYc1dMaXNxekx2eHFnR1NiZHlpWi9pR0NJTEpreDRwR2k2Nm1J?=
 =?utf-8?B?b2tFcDY4V3VEaHlRSithMEhGUENodjkrL2ZIWGlnd1VVZ2hXdC9nZWhXYVFN?=
 =?utf-8?B?OWpIVldQeXMyUnMxZVhCTFVYQlBUK2gvb1R3a2VqWEFzVkJ0Q2kzSm1vM2JY?=
 =?utf-8?B?aGZUNTdEVWJ2VXB1THdqM1lKb0hvOG1UWnZYQndtWGNXUHFtaThRSURKekFm?=
 =?utf-8?B?R25UN21vTEhIWUZ0cGgxS2h4NmJnKzhyMnpiOGh5V21NbGEwclRpamRwN1ND?=
 =?utf-8?B?ejE5RUJ2cEZXeDFQYnZudzl2T0RRcGIxY2pyRHNvOWNGNUl0bW90UGpqT2Jh?=
 =?utf-8?B?Q21DT3BwREk0QjgzYUQxd0ptVjBDaFg1b0VROEpNZlhUVWQwMm9BdU8vbnRz?=
 =?utf-8?B?NDlQaWtLTU9CZW5QaGVnb1ZDcXRJUGh6RVBZSCtlSk5uOHQrOUlsUS95UEdk?=
 =?utf-8?B?MTRjM0dvMFEvcVF0cUNCalBpcVVna3h5WUx2TW41ZmVDdjhBWVEvVm12Y1ZK?=
 =?utf-8?B?V2JuV0QyL2NnZUZJVTByYTdralVOeHQ0ZjFDTVpPdmlsbDQ1NzFML0NGUGJw?=
 =?utf-8?B?SWRUSk5QUWlCakhWdmRKMVF5TWRab3ZRTnhrWGwvTTc3ZzgzK0xQcU8wOE44?=
 =?utf-8?B?WVBLM2Fackc3ZDdaOEwvZ2NMb0ltOEIvNnpMMC81RHFuUVlzS25tZk1pdzBP?=
 =?utf-8?B?ZmtSYzJsZXNsenBnM2c0TXJHRmE0UTg2bW84Wk5Lc2J4Y3BqSDR4SHdsUm1y?=
 =?utf-8?B?ZjcxRllPNXZSZjU4VEZHeWIyU0dObWtLTzRKRElaU2pLcU4yTmZmdU9Qay81?=
 =?utf-8?B?L3lJY2ZVTER1bTdUMFF0UFZMVUtQdmpTNEtzSFFhUDJvVXJPNjZCcXBLSW5m?=
 =?utf-8?B?dFQxZlBNS2pTT0xhV0g4bU9aSFdrWkJTcXd6dEtRQUhxaE42dzkrUmwzOGlI?=
 =?utf-8?B?UnVaeHZpMG0wNzQ4ZElRdHRBa2FOcVZyenZ6ZVd6QXF4a2NmSFYvRzFLKzV1?=
 =?utf-8?B?NSsrWmtHUm93WWptbHZKQlc1NFFJT2l2SWVzNTRmWDB3M0tXSkhaaVpzaWpz?=
 =?utf-8?B?ZWR5V2s5OHRSSDlNN1lhYXZIRWl0MmNaWnR3V0RJZXJoL3VJN3JtKy9LTWVz?=
 =?utf-8?B?cmxzdkVMS09IMkE5OXlVY3FMZCt5b0h4SHY2eW0waHlFNU1vUENFZksvUVBr?=
 =?utf-8?Q?OrJ9w9q+zEA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGlyWHlqYnpOclRNSTlNSVZOeHF1RUZXTlZPZVVmZW5UeEdJa2trWFc3aW9X?=
 =?utf-8?B?T0pwajFzUDQrTEprYU1ab1h4VTZkM3QvaEpVOUxxYTdpUGFMWWdpV0pDN2kz?=
 =?utf-8?B?WVVqNTNQdnhmUjJuOHpKWXQ0QXI2NjBJNmpsQnNMWk45TmV4dU5WQnhac280?=
 =?utf-8?B?SC9CS3REYW1pTmlOZS9kWGpRNFZ5V2JKRzg4anVnR0NrRjBDeDVWQ1JCMVoz?=
 =?utf-8?B?Y0krYS9xTi9EajQ5c3M2blRYTjB2dm1UdjRIV3drQ2lmeWdzV2VjdlJEY1JY?=
 =?utf-8?B?ZStWdEY2azNDQlQzaEh1MUc4cnJ4bXNHRHhVYjVXZ1pZeUJkcEwyNnRKdG9B?=
 =?utf-8?B?cUhlcmtCRGx0dHVMUDE1cGE3SFNVVVIreStwZDlicjVWTmJxZ2ErbitGdDFs?=
 =?utf-8?B?bWJqQlQwQjRucWxnWWNPdU1HeUlyOWFlblZMZDhhZi9raHYyeVl1WHdzOUo2?=
 =?utf-8?B?b3B0eUZ5L3REWDcxMi9WajY4N1RSRkw5VXhRR3hoQjlTRHRIU0hDQU9Ha3lj?=
 =?utf-8?B?ZEpYYWRPVFRuVzhiVG8xOUhZTWQ2Tm9WWTI0SkRLY1lCRE5jQ0d2YVg3WlYv?=
 =?utf-8?B?ckJySEV4WGVQZk9aa3hHWThETGlxUXEvc2lsTkpMNTJsYjNaQzJPVG95QWNT?=
 =?utf-8?B?TzBsVnVNaEFXMnJmcXR5UGhuSGVaMEU2d0FYS2t5Z2pGbkxrdG94SmpJaFdD?=
 =?utf-8?B?RUJXaGRJdEtmMncxL0d5NU9HQTRPUGRFSGIwVlc1V1pWRTFKZmswRkZpNjBq?=
 =?utf-8?B?bnlkcHQra1pSd3hjOVNub3Y1K0RIemVSUHBZVHJjbE1tU3JDZzlLTzNhWndV?=
 =?utf-8?B?Q3FZOElFSytaK1hoWCt2T3FZK0ZvdWZnN3NVYWd1ZXV1dFFsNUVLWDF3aW5p?=
 =?utf-8?B?d1ZBblhyRldWeS9YcnYzVzVYa281bC9XejNWd3Q1TW9jVUFUakpkdjJEc3NZ?=
 =?utf-8?B?eFc1NzVCK0FpdngrcWZjazhZQThXZ3RNbHhteXlLR0tjenhkVFNDazljUVNu?=
 =?utf-8?B?MjJOVTJqbTdoUGg0QnY2cXMyUDAzUVNBYklGWWhiZUErTGNYMzZSRUxFRm96?=
 =?utf-8?B?SUdJSFBUakdjL3Zxa0hlUFJyUk03YzIyVGMvZHl0ZnZOTk5xVnhPbXgyYnFD?=
 =?utf-8?B?ZklyRW1lY3RCdkJoVThhUVhZaTlwdEZ6SXR2YzFvRG1jazg0ZmJ4RjNDV0M4?=
 =?utf-8?B?SVdzcnJlZWdvb05paDRiTC9PbWlWR0RHMng3S0FnYU5tVVJ1TjRvcE1BUERz?=
 =?utf-8?B?T0JVSDdBaUJjNmV6ZTU2M01INEltcDY3RmhWT1BGZW5TeFVJdU1iNnRhQmZX?=
 =?utf-8?B?K1ZKZlJocmJXMERnMW5JdENiTmZsaTNPNUp2SmRqSG5RNjJKZlQxb01GaDFx?=
 =?utf-8?B?MWVBL1c0ZE9neUVuYkZ0bUdKYzZ1UUlsTnRXeDZCREgvTUVMMGl3aU1DQ3l0?=
 =?utf-8?B?YU1oZlBlaVJuaGIyMmwzVm1NZWpyelBFam50OHpncWtCaGpiV1g5MUExZS9w?=
 =?utf-8?B?MkEzcFA4Qk5qRDI4T0tjT0VWajdQb2N1b2VHR0pHaUdOVDlkbWdCMDNmdDBm?=
 =?utf-8?B?UHFiSnBwamd0S0dyZ0NlWGNRaS9kbmp2eEFZb2dpZis1Mko4QXdpdVdoR3Fv?=
 =?utf-8?B?bm5FdXdxK1JFVkp5Q2hlOVBQaUJQMHRqMUV2UW9Kd2EvWVppTXl1ZWhHbkFR?=
 =?utf-8?B?WUpPVG9RWXhuemdUTUFiQzRrV1NSQ2NwdHNjN2NkMHhkNzErR0swcnozV1FX?=
 =?utf-8?B?SFM1cTRyc3E1eDRhVThGbmE1dmNpWVdPd0luQlVVY2kwUDh1c2RmQ25DWjJD?=
 =?utf-8?B?U3lYbFJRMFdsa1V2MjN6WnJSRUFwekljbDU1WjMzMk5LQ0ViZ0VRWUlzdGk3?=
 =?utf-8?B?YkwrSldaUkpTRERKM0dub1FnTzgzS3ZOREdXSmpKREo5WGhlTjREQnBmcC9J?=
 =?utf-8?B?Z2cwNGtsVko3V2RTODF4MWUzT1BSQURwK0d2bDFNVWpVSlFJNUN0MWxBNzVQ?=
 =?utf-8?B?OVRwcGV1cml5TURXbkUrM2ptd1BxYWVyeHJjLzJsWXUwalhkODRjRVFKSWI4?=
 =?utf-8?B?dC92VW5uNTFxcTUxSDBBa0RYZTlHTERQV1pSdzZZeHBCa0g0SGNaK0dvc1J4?=
 =?utf-8?Q?qqR/NiTs33SjC9DGMuT9Y1k/h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d69eb1b-435a-42bc-8740-08ddfb4adc1d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 09:15:09.7288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdI9cNQ5afYDj3Y3iF1aZbMrhpKptxXLZcg1HCQhJ2PoN/4byZgH/F+QHb895tXg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6027
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

On 24.09.25 09:45, Sunil Khatri wrote:
> update the amdgpu_ttm_tt_get_user_pages and all dependent function
> along with it callers to use a user allocated hmm_range buffer instead
> hmm layer allocates the buffer.
> 
> This is a need to get hmm_range pointers easily accessible
> without accessing the bo and that is a requirement for the
> userqueue to lock the userptrs effectively.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 ++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 10 +++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c          | 11 +----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h          |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          | 11 +++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h          |  4 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  7 +++++--
>  8 files changed, 42 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 7c54fe6b0f5d..4babd37712fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1089,8 +1089,15 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>  		return 0;
>  	}
>  
> -	ret = amdgpu_ttm_tt_get_user_pages(bo, &range);
> +	range = kzalloc(sizeof(*range), GFP_KERNEL);
> +	if (unlikely(!range)) {
> +		ret = -ENOMEM;
> +		goto unregister_out;
> +	}
> +
> +	ret = amdgpu_ttm_tt_get_user_pages(bo, range);
>  	if (ret) {
> +		kfree(range);
>  		if (ret == -EAGAIN)
>  			pr_debug("Failed to get user pages, try again\n");
>  		else
> @@ -2567,9 +2574,14 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>  			}
>  		}
>  
> +		mem->range = kzalloc(sizeof(*mem->range), GFP_KERNEL);
> +		if (unlikely(!mem->range))
> +			return -ENOMEM;
>  		/* Get updated user pages */
> -		ret = amdgpu_ttm_tt_get_user_pages(bo, &mem->range);
> +		ret = amdgpu_ttm_tt_get_user_pages(bo, mem->range);
>  		if (ret) {
> +			kfree(mem->range);
> +			mem->range = NULL;
>  			pr_debug("Failed %d to get user pages\n", ret);
>  
>  			/* Return -EFAULT bad address error as success. It will
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 744e6ff69814..31eea1c7dac3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -884,9 +884,13 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>  		bool userpage_invalidated = false;
>  		struct amdgpu_bo *bo = e->bo;
> +		e->range = kzalloc(sizeof(*e->range), GFP_KERNEL);
> +		if (unlikely(!e->range))
> +			return -ENOMEM;
> +
>  		int i;

Don't mix code and decleration.

>  
> -		r = amdgpu_ttm_tt_get_user_pages(bo, &e->range);
> +		r = amdgpu_ttm_tt_get_user_pages(bo, e->range);
>  		if (r)
>  			goto out_free_user_pages;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 8524aa55e057..12f0597a3659 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -571,10 +571,14 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>  		goto release_object;
>  
>  	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
> -		r = amdgpu_ttm_tt_get_user_pages(bo, &range);
> -		if (r)
> +		range = kzalloc(sizeof(*range), GFP_KERNEL);
> +		if (unlikely(!range))
> +			return -ENOMEM;
> +		r = amdgpu_ttm_tt_get_user_pages(bo, range);
> +		if (r) {
> +			kfree(range);
>  			goto release_object;
> -
> +		}
>  		r = amdgpu_bo_reserve(bo, true);
>  		if (r)
>  			goto user_pages_done;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 2c6a6b858112..53d405a92a14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -168,18 +168,13 @@ void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
>  int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  			       uint64_t start, uint64_t npages, bool readonly,
>  			       void *owner,
> -			       struct hmm_range **phmm_range)
> +			       struct hmm_range *hmm_range)
>  {
> -	struct hmm_range *hmm_range;
>  	unsigned long end;
>  	unsigned long timeout;
>  	unsigned long *pfns;
>  	int r = 0;
>  
> -	hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
> -	if (unlikely(!hmm_range))
> -		return -ENOMEM;
> -
>  	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
>  	if (unlikely(!pfns)) {
>  		r = -ENOMEM;
> @@ -221,15 +216,11 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  	hmm_range->start = start;
>  	hmm_range->hmm_pfns = pfns;
>  
> -	*phmm_range = hmm_range;
> -
>  	return 0;
>  
>  out_free_pfns:
>  	kvfree(pfns);
>  out_free_range:
> -	kfree(hmm_range);
> -
>  	if (r == -EBUSY)
>  		r = -EAGAIN;
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> index 953e1d06de20..17d2db258016 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> @@ -34,7 +34,7 @@
>  int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  			       uint64_t start, uint64_t npages, bool readonly,
>  			       void *owner,
> -			       struct hmm_range **phmm_range);
> +			       struct hmm_range *phmm_range);

Maybe drop the "p" from the name here as well.

>  bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
>  
>  #if defined(CONFIG_HMM_MIRROR)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 901e0c39a594..9a93e101b67e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -705,10 +705,11 @@ struct amdgpu_ttm_tt {
>   * memory and start HMM tracking CPU page table update
>   *
>   * Calling function must call amdgpu_ttm_tt_userptr_range_done() once and only
> - * once afterwards to stop HMM tracking
> + * once afterwards to stop HMM tracking. Its the caller responsibility to ensure
> + * that range is a valid memory and it is freed too.
>   */
>  int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
> -				 struct hmm_range **range)
> +				 struct hmm_range *range)
>  {
>  	struct ttm_tt *ttm = bo->tbo.ttm;
>  	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
> @@ -718,8 +719,10 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>  	bool readonly;
>  	int r = 0;
>  
> -	/* Make sure get_user_pages_done() can cleanup gracefully */
> -	*range = NULL;
> +	if (!range) {
> +		DRM_ERROR("Invalid hmm_range pointer\n");
> +		return -EINVAL;
> +	}

Drop that extra check, that would be a coding and not an user error.

Apart from those nit picks looks good to me.

Regards,
Christian.

>  
>  	mm = bo->notifier.mm;
>  	if (unlikely(!mm)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 6ac94469ed40..a8379b925878 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -191,14 +191,14 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>  
>  #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>  int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
> -				 struct hmm_range **range);
> +				 struct hmm_range *range);
>  void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
>  				      struct hmm_range *range);
>  bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
>  				       struct hmm_range *range);
>  #else
>  static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
> -					       struct hmm_range **range)
> +					       struct hmm_range *range)
>  {
>  	return -EPERM;
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 273f42e3afdd..9f0f14ea93e5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1737,12 +1737,15 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>  			}
>  
>  			WRITE_ONCE(p->svms.faulting_task, current);
> +			hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
>  			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>  						       readonly, owner,
> -						       &hmm_range);
> +						       hmm_range);
>  			WRITE_ONCE(p->svms.faulting_task, NULL);
> -			if (r)
> +			if (r) {
> +				kfree(hmm_range);
>  				pr_debug("failed %d to get svm range pages\n", r);
> +			}
>  		} else {
>  			r = -EFAULT;
>  		}

