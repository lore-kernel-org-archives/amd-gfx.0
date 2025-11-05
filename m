Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F02CCFA04
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 08:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 445C510E6C6;
	Wed,  5 Nov 2025 08:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RYNfAK6f";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013061.outbound.protection.outlook.com
 [40.107.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE32E10E6C6
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 08:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=id8XloepHnjCRWyYI2j8nSDL90vuKU5aSk/pWRLGQFGFLNV+WT0tcYlSOS9X2pQLVHXJVq97WKK7Hj4R8dnGIXKgQtp4+UztwJ7hEa+fW0JAu0jxcVFmR7+qytW5g4KKFWSDS0HDd1Tdt/sehs6JTStjn0gh0v2QP6PBzKQdetwvfYKDIQ6HeHoAmgeuHnWL2ipE5ZIWFeiKg7vpnPqmjxw0Dgx8s0kGjSDaCmJj/olP1nYmPEserZ4MWUFSnb8iRE1CBy1VaYqe7Vx2pJQG0wcB76bNSWEDZadGveDA+CrHbq3w8ZdbfhNP6huileFlGTbs6k6oQDGSFIScJKJz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17WXkwOsusgAgcf5QCvv/BHE0nP4CC5zE1gej1lVoOc=;
 b=Nn10rUmNLxk0X5fNpbYjw1RH3c3gyTs1icgTVLe0Y5RLV8PfIxFGJBprSMLJQGNwzKie4z5FdhBjTA3myS+wIB1+THLexWYdFb9CKCCsqx22rew4z85suFZp74PaidB3gkqQfhMKbZclaFj5ODEFZdSt0FSPocsRjEGZlGvCYo8Ic8Ht5J/1y+/uPd9ZrQa214b3BnQy0zg20QNfXy3lyX6gbvjRGuE/Wvu20GYJYuEUzrRxGjSO3DATDSGWb/vMdGQhMYFANYxrzJ71Glb9i6k0THDWuPmgk/IFKfUEylvuLNsA/ZS9CmlExZbBLaDkvxvbE6kJFAOJUiKUMk/8qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17WXkwOsusgAgcf5QCvv/BHE0nP4CC5zE1gej1lVoOc=;
 b=RYNfAK6fqhAa/J+g89pXMrgyN/ry36PHj7mJZeGNFHafJC2+m4+MJ0APqsuSJekmrQzknZbEMDOGpDb7vf5iNGYFb899GglSkmarw3u1FMJeRqReYJmyEfIZrAvvFeaIxWICioh1z4TNMCqASdZoMFWcaIdA1pajOeKzoB9PrE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB999081.namprd12.prod.outlook.com (2603:10b6:8:2ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 08:31:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 08:31:34 +0000
Message-ID: <1d2bf595-d3be-4613-b515-8de3bde7a5bf@amd.com>
Date: Wed, 5 Nov 2025 09:31:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: rework the userq tlb flush
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20251105061630.4146604-1-Prike.Liang@amd.com>
 <20251105061630.4146604-2-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251105061630.4146604-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB999081:EE_
X-MS-Office365-Filtering-Correlation-Id: bec0b2af-ffa9-412c-1492-08de1c45ba5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWdhZk1QMWdPeGFYM0dnRVh3Y3gvRnFKcE8wNXkwWlJtWm4welJpS3ZCYk1Z?=
 =?utf-8?B?ZHBPcTNCQm5COVRlYXVEMEhlZGRpOUhYd3Y1WUw1U2hlbGpNK2FCbFAxbElY?=
 =?utf-8?B?T1lKckc3d1kwWC9wQ1FGUGNXMHYrNld6RWQzOXd5SFh5M3RWaUxxUSthd1o5?=
 =?utf-8?B?eFoxWTMrUjArbTlvVFFGNGg4bERlV3N5d3NwbkVObHFiNHdyaGkwdjlwa2dm?=
 =?utf-8?B?THJmMzZrUGZ3b0RtVGtzaVFkN09OMnc0U1RzWjg2STllOVFMYmc4dlhmT0Rn?=
 =?utf-8?B?V05OLzZIVXo0K1VHLzdab3hXekpEbkNudGI5WERwbFBFZUdYTFRmYUR2RXF6?=
 =?utf-8?B?R2pGazRUOVZVMlpDOUJMalNncVc0MHVIbDhDVENRSEV2WWcwaHJtNEIzRkx3?=
 =?utf-8?B?TkJmN1FSTTgybWVhTEUrSEQvYmZmcjczMUFCOG1sdXJlQnRqZ0p3TUozSndw?=
 =?utf-8?B?UGVpeEY0cTJhd1NkSFg4dHd0TnVQcHdzVWJEeHB2N3pid0hxVTM4QWhwYzVx?=
 =?utf-8?B?ajJpQU1Fby91Nkk1WG5ZUTNaRVlmVlQ0L0l5cUVQNUIvQVBaYTJQWWl0UUFl?=
 =?utf-8?B?MzBYTS9yV0huT0NSSm00L2ZROE0veHJRcVR3NjFkMXJFbjhsektXeDV6M0E2?=
 =?utf-8?B?UEhsUGY0MkhYakQxd2tDbUluOUowRS91c1ZxdGhGSzh3azU2OGFoMXk4QlJ5?=
 =?utf-8?B?TUZHR2hiU0NIMXJ6bi80TFkyUmY5Zjgrb1YxYktYcUxSa3JZaERvdnEwRGpm?=
 =?utf-8?B?U0tVVjQ0eHFMcTZtbnBsRVBZT3dBMCtRWG4zUjdaQmljZUVSbHZ0VzJRUnlC?=
 =?utf-8?B?NU5aaHcwSGk0UWhKZWlpemwwaHpoQWVPbi90UUlHcHFOUVpOVzkxSW05WFdH?=
 =?utf-8?B?TW5mSHdLMUNjbzM0WVFyc2tSTUptT21hL3V2N2FTRVk5cVhwSHpwa2VNQTVD?=
 =?utf-8?B?cWRXQWdabFpXdEVrY0c1eHV3YVVUZ0h5ZWRpNEdIUWtxK1pOQW5Va1E3K1VZ?=
 =?utf-8?B?OWRuMnd0bVpOc2lHY2FIQmJkc1o1M2lOSnJSNXRNQmV4eU9oTnlvTkZxOHp2?=
 =?utf-8?B?dTFuMXUwaXppNW1wQ2Rsc1MzbXQzQ1RyNFJKS252eXdVM054ckc1ZDJlR2xO?=
 =?utf-8?B?TU9UVXpQV0dZVS9reHZVbGZGNzZYRWF3ajNxYlJIODJzT3FqVmdqYTZNajhs?=
 =?utf-8?B?ZXhrbkxYbGY2aGxiVEpXb1pjbGlzWmlRckl2b1g1dzE1TW9iNXA4cmluU3ZN?=
 =?utf-8?B?cnpoQUtyYkJCUGVWbjlYcTd2N1BkanBEcGc1aEVIZ3FQUWZDSDhIVmRHbGlP?=
 =?utf-8?B?eTBHQUdqbXh2RjVINDZLb1VteVd2UERWWXJjcmFvSWloUWpQbU02clVGTExu?=
 =?utf-8?B?RlBPSDNsN2hPMG1BRXdTUWY0NVNVNnFrVHBEa3VCOG1vQmJsRWxTa2lRVEk1?=
 =?utf-8?B?QXcvMVJVWVA2Tjdielh1Q1lldkhjQzIxMFp2T3BYWk5qMGF4YlI4aGZvbHE2?=
 =?utf-8?B?dWtFSHFOempQTHk1bSt0b2Fic1JhWVhoaS9la0NwMDRWTjh0L2JIeGY1WnFq?=
 =?utf-8?B?ZCt1ak94NGgrYktXWEwxZnpnbW9ObFFZRDZEeWpIL1FYT0VCV2ZyRUY1THpq?=
 =?utf-8?B?c1B4QVJtSWZtSUhFdmxjbTI4VjZrSVMxTHhwQ1cxRzZoNmkyeUlHbk1XWGVJ?=
 =?utf-8?B?QjdpQTcwZmVTWnVueEJaYlpZekRrMmErSGxuOVlHWUdOODBTdExaMGN1dlpC?=
 =?utf-8?B?RjdOVm1TSDMxZm5jSUpoTmNQdWhIdmpDOGhyTXBrbElKUDlSWjFoS0djVVlq?=
 =?utf-8?B?dDNaNUsrcHJHclp3RWVJVU14NlNqcFVhU1AyUzhXeXpWbU1RYk1BU3FYWkhG?=
 =?utf-8?B?N1VTZElsT0dhMisvTkNOYTVHTGpJbEtUTDlaTWptTytTTHQyYzhHMUdiS0ti?=
 =?utf-8?Q?MgDCrCWZlzHMWBS/c77U1EHItju/nwBl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUtoU3ZjTEhIZ0lLa3FNZER6RDdBMDJqd1N1ZkdOa1hUNkc3L09yMlBHaGNI?=
 =?utf-8?B?M1ZPYmVYaGgveS9EYkNTRHhHQ3hXMDFFYnNxOHV4Vm4xUjBjMk9CMW1GaW44?=
 =?utf-8?B?T0dYeTc4bldKRzc1NFJrOWh5SkxhWk1JcFRBUTN1bW1xVGh0WmQ0OU1GUm54?=
 =?utf-8?B?dUZhMlBnYVZ3UmxzNDBHTkJ0NlF0WFVQRmpMUGdQcGhlbERieXNhLzA1c1V3?=
 =?utf-8?B?c1NiZjlKRjBjR0R1SHA0T09MazZ3WmJKVGYramQ4MGh6OSsyUnRyQ3ZMWDJw?=
 =?utf-8?B?WnVMT0VrYUVTQysyb2ZzczF3cHN0cDFQcTc0VDNYUmVwMGFVc3E5TklFUDRW?=
 =?utf-8?B?WUNJVDRtd1FWN1NJUXN5SUhGNXJSc0QySkpCaWpQL3pkTlJvWkt0V2tlQ0Rk?=
 =?utf-8?B?WGl1TVlwRHlwVkhRckZoc0RaUTdOQTRRMWtaZkpGQWVDTkdmckF0TG9pQTRM?=
 =?utf-8?B?RHg0SVpkVC9SR2g3Y1JJMXZyTlZjVDJPRWx6TEQ4Zlc0SmhqQjQ0a3loVHhj?=
 =?utf-8?B?Y25JbXh0YllBRnVQNWpxQnBIK1JVenB5YTY2ZXJrYitoVlF1aXhtV0VJTmlJ?=
 =?utf-8?B?YTdWL3d2aGd5Nnp3UUJBNCsySGdYeTFUOEdja1FEOTFMN2Z3TzZGMXg4U0NY?=
 =?utf-8?B?WCtFUHVOR0Vyc1dSZzJDNUJLN0NISnhzUzA4ekg3N2g3ZWVBL2RBRFlRandJ?=
 =?utf-8?B?MmgvelZQeExhKzhmRHVuYjBkQ05rVk5ORG1MWEFSRGg5T2YxMlcxNGIzRTla?=
 =?utf-8?B?eDhqZFN5SVlIVUIybjN5b25qbFI2MU9aMDVnTU9yTlFkQkNoNHRacDRsdUlD?=
 =?utf-8?B?RkhXNmVsbU15aDJWTi9LWkpFSjQ0c3VkRWRDU1F4a0dpWUJlWDRlcXFUV2h4?=
 =?utf-8?B?QUZtYjlXOXJodjY2UGlGbGhyK3g0c0U3VE9XbHBFb3FzV3h2K2VWdGtDQUov?=
 =?utf-8?B?YVlLYWVWbkZJbTk3K2tJcDV2SG92SlNiS2I0Qm1oeDB1NlhpczJ3N29saUtn?=
 =?utf-8?B?djJ5TFo2SHFOUHVsc0xJSjFJVVNsc1d5L250NTdKMkpxdnpoNVFYdG9XVjA3?=
 =?utf-8?B?OFJEd05TK244OEpuU0pWaUQrK045bElKTXBSbGJsTmw2VnJYc0lLOXNNRTFx?=
 =?utf-8?B?c2dMR1BQYkxiNGxnZ1FYNGxDdE9UaTg4bGhBMlhESE9nZmFrWm5ESHJIYWY3?=
 =?utf-8?B?MVc1bzRNWW5rMTlIUHR0RG1Uc2ZLMzVOMHdKRk5oNHA4Yjc5SHlRL2x6WXI2?=
 =?utf-8?B?Q25YeUxIMDVRVXNZTnhVTHZJODNIZStuQVBwWkc3WDhnS1FYZERXUlIyU0Ju?=
 =?utf-8?B?dXNlb0VWdkJVc2xGM1ZZN0J0bStFQTdjM3UyeWJMNzg0eU44ZzVZQ3NNdURQ?=
 =?utf-8?B?bDFBcktpdlFKTEd3ME5pczdqdytuSVZGUm1Rd0w2eFhTVDZTNnl2QlVuZHVq?=
 =?utf-8?B?RGpvKzBpNnRmNURtcyt5dGNSTmpzOUtvbm9Ybk1FS21OekI2UTBpa2EzTzM3?=
 =?utf-8?B?cGN4VUUwOGl3c2xWRU1hNlNOOWhGV1Jqai9aUVVoRVl4N05LcVZTOVYvUTNB?=
 =?utf-8?B?TVFRRXZZTS8rU29rUmliWTIvaVhJWThUSnN5d3pENFpiQWJ5QUJoZWRuSjcx?=
 =?utf-8?B?TzNETUw1Q3Ryc0xhbDVDdUg4Ymx5bDF0N2lzRm5FUU9RckcxMURnQ2dBRjhU?=
 =?utf-8?B?a2MxTWFBT2dJb0ZTeHJJMHptY2UzUU5OUDdiYmkrTi9lYVlCNHo4Y1R6UmtU?=
 =?utf-8?B?Tkk0Q21SQ2RlL2hoYmlReGdYVnVZayttVmx2WWVNMTJyQkJ5WUVScjZHY1BG?=
 =?utf-8?B?Y2R4c25Ba3R6cjI5ZWJkeDdlTU8vbGVhaGtXZm1xVlFLUXpUUGU5SWJpQ09l?=
 =?utf-8?B?ckpUZzc1cEJib21HYkZ2S3RuWUhOMHhVZm9UZ2w4RTVBOC9yOHJnemhYTkVJ?=
 =?utf-8?B?QUxGVC9HMENndVJ2SEMrNUJFSDQ2UE0zazZNS2w0OE1oU0xBWTI1WlFuc3oy?=
 =?utf-8?B?VmRkM1RzSnUvZkFnOHVXYlpvdER1SGZsZG1iN1FLeXJVMFVYdWhhVU50VVlF?=
 =?utf-8?B?SEgrYmEvYlIxSUphNm1SUUtHYUxmcjRUTnZ1NjJMcnVuME1WYTA0cWF4MlZk?=
 =?utf-8?Q?fFDAwjkFJeQ8e81FtRem8ovuj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec0b2af-ffa9-412c-1492-08de1c45ba5c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 08:31:34.1426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5wD7z/9iXr6Mylp4V9qSIwQp8xR7es/WNWJnJh3Xh2IozwStR6vcwJQQEEWI5Z4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999081
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



On 11/5/25 07:16, Prike Liang wrote:
> The userq TLB flush should be performed after
> the vm update complete and input fence signal.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index a8bb3f1b8649..01707d72d982 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -384,6 +384,7 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>  			return -ETIME;
>  		}
>  	}
> +	amdgpu_gmc_flush_gpu_tlb_pasid(uq_mgr->adev, queue->vm->pasid, 2, true, 0);

Please drop that one, it doesn't seem to make any sense at all.

>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 48a64d828eb8..1537f0b6b712 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1062,7 +1062,8 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>  	}
>  
>  	/* Prepare a TLB flush fence to be attached to PTs */
> -	if (!params->unlocked && vm->is_compute_context) {
> +	if (!params->unlocked && (vm->is_compute_context ||
> +	     vm->is_userq_context)) {

Just drop the is_compute_context check here, don't add any new checks.

>  		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
>  
>  		/* Makes sure no PD/PT is freed before the flush */
> @@ -2792,7 +2793,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>  	amdgpu_bo_unreserve(root);
>  	amdgpu_bo_unref(&root);
>  	WARN_ON(vm->root.bo);
> -
> +	amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);

Please drop that one as well, it doesn't seem to make sense.

Regards,
Christian.

>  	amdgpu_vm_fini_entities(vm);
>  
>  	if (!RB_EMPTY_ROOT(&vm->va.rb_root)) {

