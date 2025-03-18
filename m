Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84402C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 13:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B3910E48A;
	Tue, 18 Mar 2025 13:24:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ps/zcwue";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E45910E48A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 13:24:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4lDY5YM07gl1O8NnjqmFB//iANhVvHAcZyhUMhrISjf2Pf5nyx6xVohhqc+nANR3Pc4b3jcifwgMwrZ7IbEigr6P8rfvHxmyzBwekltBoZR0z3mecqa6AJ7nJOCwqTh5WSSVMDITV5ERNhjrr5SBxT0CqPio1rTQE2/+BDvksvXNnBcZAmAEXigHGbPw39LvcRMMT+ikdSQLHa8w2h36iXF164D/uFvNYqAfJWvjytSgFT+dBD2JqqBQSkM4NoORwVo9vvT6x3FQLuSv9lcOUgEXFfRGf2XRS7DpOXVTeZ67hvuxMqgPstfmPMHA8Aa1TXOmvKTc/adeKUcw/HOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xh3NFll8jinqv4P0MVnPLLxZCxt5HeKsb56zmw/+r3o=;
 b=gk4432WEBIQCXA7YgZIjQDrMVSQJe0pr5G/x3riZVzJlTGqJ4syMUx9xvF+e3CLHWc0X6Oc9x3YRvZ1kzme3YVevliO6gc5myXGW8lQvhXJ1AuQT8S0vCPRcEz8gMIe1recDzccUujylj2nL6u0Th6wZNns9dmGGODw/OzaP8Scad9TxpFomhduVLAwzYHa0P+rSGlKsuZKiDZbA96IXjtNGG8xX32087oYzX0HEVv1Pu4Qlvcgd6lg+Aq6WVQaHDWFN60NEiE01GZ6x4ZJwzWvrZ2xRHlWVc9cKadWpyoDoVze34EUTV845oQ1fmRqoJ7Ctokfm/erVH/AFVbumyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xh3NFll8jinqv4P0MVnPLLxZCxt5HeKsb56zmw/+r3o=;
 b=Ps/zcwuenMKo4bDYYiyERRlIRyy5FXDuO24Pny1JYZs5rxLqO2VmEMxvFkWu5z8Voe7Xs8yUXx7Z8Na8fFHyNpdxygbEl16HV+iYYj+OdnBQ3gt4m94ZiF3hSz8GkPkuqEfkJGs3VEmHBzyU4lQ0BdymyThQJsabZ+EATV5CkIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Tue, 18 Mar 2025 13:24:02 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 13:24:02 +0000
Message-ID: <e85e722a-b7cf-461b-9c46-d313f942ecb5@amd.com>
Date: Tue, 18 Mar 2025 18:53:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: adjust workload profile handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250317144734.810595-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250317144734.810595-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fdb0619-f9fe-4059-ecad-08dd66202600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1lyK0QzSHVrSmFVaEd3Y0VsMnB0UnJTbVcxWXR3ZGNGTm53N2ZZTGFmZkd1?=
 =?utf-8?B?L1lycXNicS8zNjdPcmM3Y2VEbkZmbGRHcTJqUzBPRmdWZTJFN0tUUmpKVnhP?=
 =?utf-8?B?cCtmM2NObVVGTTR5enNSYllHRDAxellPdGlQbVVxeG1POVhwdCtWSHl4Ni9o?=
 =?utf-8?B?SlJEODJDejA3T3ZBVEZDZ0h1bXBvSE4xZ1llYXZIWlFoei96Y05sM2xLamJJ?=
 =?utf-8?B?bTB6WDBYZmFoY1FOUkpwaExhcTMwbEtpNldzVktqZUFQVlJVai9zQ3FIbksv?=
 =?utf-8?B?QnpmTGhXZ1RlY05kcEVxeFZRSklQNkV3enRLSENJQjBCM09tQXozR0RnaTJn?=
 =?utf-8?B?TnRPQmJLd1FqT0hHd2dzVTh4UjVycjJLWmdxYkxUN0FnRjJuei9YTXVuNFUx?=
 =?utf-8?B?S0R2WGNwQnJIaGYrQkJaK2kwcTg3eHBrVG81Rk1WTnU2OGJlbnNUR1czb1hY?=
 =?utf-8?B?NUU5Unp6RTdYbUJwMXN1YkRGZnZYbnZiS0xXWTJLeUpBTjZYOWRNazJkWW5k?=
 =?utf-8?B?NnkvdURTK0ZpNkhBZHUyZW8wbE5RMWU2NFh4cGIvL2R1UWdzMnY0eitVSElD?=
 =?utf-8?B?UGpGTmFReTNTeWJoa2FEWi9BR3lOM0x6TFdMSTlHeHYwQWtHb0dFWkZiM2NW?=
 =?utf-8?B?VzU1VTJRa08vU3p2eFZBa0FzYVhpSEdod0k0WEcyOVdWTlBEUDg2WGEwNXJa?=
 =?utf-8?B?eW1vVmRSUEFFM0wxK0NxQlVMOTY0bWJwZmVaeC9QSW9tZEgvUmU2TGhiaGU2?=
 =?utf-8?B?blFiZGJxeHgwZElPWTlYSDNjU2o3b2hyc1ZzamZVMkRuU1MvM1FraFJLd2tD?=
 =?utf-8?B?QS94eTBXcHYxd1N6WnNGdWpDM2RBYXJhNTl1cU1hVE5XUXhrYWJzdHdRNzJl?=
 =?utf-8?B?R0pyak55RXpHVlBYSDV1cVBleXl6WTY0VWF4RzROak1iTHZRYXp2ZVNqa3lV?=
 =?utf-8?B?aTFjTHArQ3ZCYzNpSDlkME93Y3R5OGVOWmNDU2hMSyt1K0pIWEs2R2FUQXBm?=
 =?utf-8?B?SnduakZsd3JCTy9ndG42YU9ZbWdwb1c1Z0xUVDAzUUJoc1FZUFl6Vkg1eHRr?=
 =?utf-8?B?T2hFUHlLWDh4TGVaU2RRWit5blpQUTRia1hXa1lnbHBPYkQ2elRObTU2V0Rl?=
 =?utf-8?B?ZXA3UWh4SjM3NFRjaXRUbEhET294WWU0MmYrbkpaQ0NpamI0eHhwS3hNakdR?=
 =?utf-8?B?Q3lhb0c0T3E2NENqZGthNjFra0pIK2tuRzA4cGhoOVVhZUc1b1FlQ3o5dTlB?=
 =?utf-8?B?RmJ6MUhLcURDbG9GbTdLQlEydkFHWG9BVk42MUZXTnJWdFNuQXJDMlROdzRX?=
 =?utf-8?B?clFrQWlvYXRpaVZ0Tm03cEFibDl1RlJNak11RmpFUjRWdU91RjFQYVhueThj?=
 =?utf-8?B?VU52cmtMa1ZNZjcxSHd0MEZIdENhS0FMOW1yV1lPS1VSOHhTZUhDU2JuSXJU?=
 =?utf-8?B?Z0xTSzlTS3FhTEFQZWduQnFFdVhoWlJUdEt5dkdFbnhLb1dSM3JFZmdkT2oz?=
 =?utf-8?B?N3R4cEpVS0Z0Y2dNSFpTa25MTDlpWDk3ck8zdVhiL0wrWHlCNkFiSGNzUXdF?=
 =?utf-8?B?UGthbE94NGNXT0ZxNk9qRXJ5cWE3SFNsUldtbGNYc3pjWTdrNzIxcGViZ1Za?=
 =?utf-8?B?bktyaFBSSFdsOWdZWEt6Ni9MVURUajBSVDNqdVhoNW5UN3c2c1lMeWtuTXB4?=
 =?utf-8?B?TGVIWllrcktPVVpQWVFzSHFrZmJYUkRjVlp2b01wejZHNmFNOHIrelNMUm1J?=
 =?utf-8?B?dE9TVzNXTXgzR2oydThYMi82aGxrUkhSU2JYbzIwVlNGbVpKU1d1Sm1aTzVD?=
 =?utf-8?B?UGU1VXQ0bUdnMldqWW9ySTZwVlg4dW5Fd1JvOGJzYVpTNXVIWGpCQXkvaG9Q?=
 =?utf-8?Q?9u+9U4iRZbPA8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2tuNWpUc1ZPeGpvRDM3dDhTZlEycUt3SmgrZWZTVUdRbEhYeEM0VFpJS3RM?=
 =?utf-8?B?RXZaVlJKaHNQYVNUUWFYQk1BKzZYUXpKRmdpR3d1OHpkb3hzbEtTMjlESzY5?=
 =?utf-8?B?N0h6ckplZVY4QlZIQWZWZ1JrTkRFWGVmdkdCRVl1NFdLMkRrcStSOXoyaEd5?=
 =?utf-8?B?aTVoSTJpdUg4UEhndTZhanVyMkduOWQ5cHdXNkx2bis3cVR0OG5Uc3dlS3N0?=
 =?utf-8?B?TGVlQW1TeVZ2SGVKV2VsaG51R0laTXdpNlR0RmFLekx2RmFoZ3NYaEZjUHM5?=
 =?utf-8?B?YkFuU1lrODF4eExDbGcxNXlIQTBQUnRFMTBTdkRidk1xMnJUbXZURHhZTVcx?=
 =?utf-8?B?WS9ENXNTZFJyTFRvekJyQlcyNnBYbU1Vd3JuRFZrSFhOUEZKRDVoSDZhUnBx?=
 =?utf-8?B?ckZCTWYzR011UHlCdm5OR3dtQjJGZ2R6NDU2M3ZrUmJ2YTFuUytjcTF0SUlO?=
 =?utf-8?B?T0R0eEo0dk9TRkhLalU3L1R5LzVnZDUrVVNISzRXTGVZdXdXMTkvUlR3dkRI?=
 =?utf-8?B?eElMbzZ5QmI3dnRFdVgvcjZoNEVhbUtXRWZMWDdCTzQvVmsrU0krcGpHMTFS?=
 =?utf-8?B?SVpvcHNDQU9VakxvaXpwbVJnK3pNMWR5NEtOOFB1OHhwajJIOWZVM0FWdjRq?=
 =?utf-8?B?bTIyZDl6MDJvbmt3U0pWL0RiNDd0dHNjUCtqbURqckNjY1JNWWFPSmo5NEpq?=
 =?utf-8?B?VUFQQ2c2TjJqcDJheUpTdFdoTHNJcERWQS9sdFVSSzdqb2FjWGpqM0FzazMx?=
 =?utf-8?B?dkU4ZEZodzlIMmtHNkUxMFlLczRQTUovQXlvbTJHVFpCY0pvdFpjcnltdTJq?=
 =?utf-8?B?enQ5WE92elNhT3VMKzc1UFdybngxYStVZiswN0dUdnJVdTI0SHlIWmJ6T3Vh?=
 =?utf-8?B?YTB1eFhMVUU3blRLYWduaEdjSFFlTHk4T0RaMk02d2JXeDlIOE1WNXVsMGV1?=
 =?utf-8?B?VEIzUkNVWmNBQ2VtcnZOZHpqREtHOW9wM2RFOFdIWlVHM0Y2Q1ZPZ095c0h6?=
 =?utf-8?B?bkowazVpRHF2MCtvYkdIM0tQV2d0TDhmNnZqVGNoUXZrY25aaEQ4VXRHTUMz?=
 =?utf-8?B?YkpoYy9UM25QSEFLM3pEdWRIMmt0S3BaSTJUNzBkYi9QcVgxTTk3elRuallE?=
 =?utf-8?B?MVlTS0RxMDM0QVdodHBuVzRnRGg4K3lmT3BYQlBVTnBnaEYveTZnNFNOcW1R?=
 =?utf-8?B?Q3hpdUlLekNmaUVMRWduTmFwUS9QejVId21uSW0ySGtnRG5BNVRxeGpZbm51?=
 =?utf-8?B?Q0tRdkpKbVJrbzlEbmo0NWkwVzBaUVdJU2E3UUNoTGFXa0pJemhQeUVrSDFF?=
 =?utf-8?B?SHB1d0JDcHNjMDEzMFlQMzZ2ZUFHdWN4cFNJdDBuaHFNQTJFcjI5dTNEKzUv?=
 =?utf-8?B?MHNNS1djWTRNbkY1Rnc5ZmlzdjZzWldGT01JdHVJMDRWU1ZjcnVOald2bXRv?=
 =?utf-8?B?ZE5PSjYxU00vMmR4OE42cUJPckZuSDN4am1NV29ZQkt4RFhZMGd4QU5IaDBq?=
 =?utf-8?B?VW5WcjA3TmlGV0pQL1VWZUZTeFpFeDlnRHpHVzVBdERyMGFVZFJZYnlkZDRr?=
 =?utf-8?B?dWpOSitKL1REM3FkbmRZTmNsSisxeXAvcFE0V0VnVEVkTCtmK2U4VzVZNmts?=
 =?utf-8?B?eGN4aTlEYmU4ZnF4U2lLLzFybm1oTUgxaUVlZzZockc1dlFpeldWUHJKSXFi?=
 =?utf-8?B?TjFjd3Q5K3NzL2lNK0g5RDRpTHl5UjRtbFBDektqY3NDYnNpdVFlMStsN3Mw?=
 =?utf-8?B?Y3Qvalg3dmtCQmJ4NWlHSjZ0cUxYY0g0UGVDQ1FDL05WV1VHcGJqb3N5ZThO?=
 =?utf-8?B?ZHRVSDg2UTZOdlBNSWpHSzZtOWk0KzM2SVhvZUdjSGdjQkU4bDV4QW9NeHlS?=
 =?utf-8?B?R0dyV1RFZkZUcWtJN3MvQWF0UWEzODV2UkEyRDRGZHFXc2lCMXMzdTg2ZnA3?=
 =?utf-8?B?c3FtZmFJcHNpUnk0QmtTUWNFYVN4OCsxbCsrZjN6WUpNcmZNNFVBMXpmZVpE?=
 =?utf-8?B?Z3c3eFJxck1IK2ExSEZTc3A4WGdEVTRJTEhJdnRJVEZZN1BSRzVxanR4V0xE?=
 =?utf-8?B?SlhvMWNwYlBpOGxjb1BKeGNJTEhlR2JIZHV6Mk9CTlVBTjVia09wM1Yrd1or?=
 =?utf-8?Q?HFk7j4CjhlPOA11Ul0wWlsRdS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdb0619-f9fe-4059-ecad-08dd66202600
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 13:24:02.2130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjAosMxtuDMj57PGC5SQcYucyF1GaqfkLR0yh9hQHj5Zg3dN1ay5LIjVui3gUrEp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008
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



On 3/17/2025 8:17 PM, Alex Deucher wrote:
> No need to make the workload profile setup dependent
> on the results of cancelling the delayed work thread.
> We have all of the necessary checking in place for the
> workload profile reference counting, so separate the
> two.  As it is now, we can theoretically end up with
> the call from begin_use happening while the worker
> thread is executing which would result in the profile
> not getting set for that submission.  It should not
> affect the reference counting.
> 
> v2: bail early if the the profile is already active (Lijo)
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 28 ++++++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 28 ++++++++++++++++---------
>  2 files changed, 36 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 6b410e601bb65..1991dd3d1056a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -460,18 +460,26 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>  
>  	atomic_inc(&vcn_inst->total_submission_cnt);
>  
> -	if (!cancel_delayed_work_sync(&vcn_inst->idle_work)) {
> -		mutex_lock(&adev->vcn.workload_profile_mutex);
> -		if (!adev->vcn.workload_profile_active) {
> -			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
> -							    true);
> -			if (r)
> -				dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
> -			adev->vcn.workload_profile_active = true;
> -		}
> -		mutex_unlock(&adev->vcn.workload_profile_mutex);
> +	cancel_delayed_work_sync(&vcn_inst->idle_work);
> +
> +	/* We can safely return early here because we've cancelled the
> +	 * the delayed work so there is no one else to set it to false
> +	 * and we don't care if someone else sets it to true.
> +	 */
> +	if (adev->vcn.workload_profile_active)
> +		goto pg_lock;
> +
> +	mutex_lock(&adev->vcn.workload_profile_mutex);
> +	if (!adev->vcn.workload_profile_active) {
> +		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
> +						    true);
> +		if (r)
> +			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
> +		adev->vcn.workload_profile_active = true;
>  	}
> +	mutex_unlock(&adev->vcn.workload_profile_mutex);
>  
> +pg_lock:
>  	mutex_lock(&vcn_inst->vcn_pg_lock);
>  	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index b4b8091980ad5..d716510b8dd68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -169,18 +169,26 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
>  
>  	atomic_inc(&adev->vcn.inst[0].total_submission_cnt);
>  
> -	if (!cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work)) {
> -		mutex_lock(&adev->vcn.workload_profile_mutex);
> -		if (!adev->vcn.workload_profile_active) {
> -			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
> -							    true);
> -			if (r)
> -				dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
> -			adev->vcn.workload_profile_active = true;
> -		}
> -		mutex_unlock(&adev->vcn.workload_profile_mutex);
> +	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
> +
> +	/* We can safely return early here because we've cancelled the
> +	 * the delayed work so there is no one else to set it to false
> +	 * and we don't care if someone else sets it to true.
> +	 */
> +	if (adev->vcn.workload_profile_active)
> +		goto pg_lock;
> +
> +	mutex_lock(&adev->vcn.workload_profile_mutex);
> +	if (!adev->vcn.workload_profile_active) {
> +		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
> +						    true);
> +		if (r)
> +			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
> +		adev->vcn.workload_profile_active = true;
>  	}
> +	mutex_unlock(&adev->vcn.workload_profile_mutex);
>  
> +pg_lock:
>  	mutex_lock(&adev->vcn.inst[0].vcn_pg_lock);
>  	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
>  					       AMD_PG_STATE_UNGATE);

