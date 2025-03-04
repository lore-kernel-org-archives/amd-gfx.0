Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FCCC021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 05:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7436B89220;
	Tue,  4 Mar 2025 05:49:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WbwaR//R";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD0B89220
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 05:49:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7kOsGE/6+28aR6EXn8BagehUqQAmxm4cuGSIjO0P+JRJkVLpC7IvrqYD4Gay2Biw0hNk4MoKkg25Fac3ZUaP+i1HE5Wjsud43KseLgjDJkbMw3bYsa5f3M3g1t/SysKVt9eD7jpwSrqAw0j1t+EQ9HP5FwY7H6j3ro0b22PWh+y32sc2SsTAadL5dpKEcTw4HWDH5kUITE7FI4jLXRkfBNe/trp1zg9be7SAAgwbCfpHc8LYX1YspkhrTAis3NsFLzyQb85UpifLN/R8ikpqZqhxyEALCOt41SbeUMJEUv6amjqN9Q6h3DTgQgdbAbfYF1s5hs/Ef+/UTbni04ahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dMw4G6ETGj1u0gfZ6EkGfNWc4Aa/6z/1RICL1uh07Q=;
 b=OEhzT4abVyGny/NUGuRu9u5Ejy93k/VQoZNHmBsxcjVzL+KtCRR0KpG9304FUonLuWA5LtaAC6+7GhQOWMsaE13Vj1X5/xg2sJrx/ttML1jWj1OCNyiGP4p1Vn0oczs13fcpHL2JV1KVC542mz7VjYi+kGKRRTn/rVvDRTN/qS45T53F5f0p2L2SCyunfrVjh67enVhM9G8wQEqr2sYcvHTvr1M/MWQ1hfL6K22gfEwOSfSpkFj/vwK+M22Rr3cCtd/dXoNeLmzVY1kqzYEl2UdSY8/Vc2xKrHWUAplf8tTioJxm90L4fDjTXhb0EynJ+1h2eiUejDe5IgXQBNarGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dMw4G6ETGj1u0gfZ6EkGfNWc4Aa/6z/1RICL1uh07Q=;
 b=WbwaR//RFt5Lep0TOTObfPE8tDwvMy4oiRiQ1kTLfDlG8P6qDR3cTa8Z09qZcT62OfA1Q1g6hdl3Tadxqrpi3U3HZrbgVK8f5hu4BE5gnko/4CNWw82UT2o/b88Hz/zwjQ9YI3f/E71/wiskioZfZNdmgursvCowDSHgbdHrkto=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 05:49:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 05:49:31 +0000
Message-ID: <c0fd1f01-ed4f-494d-8e9e-ae092a6ef1e1@amd.com>
Date: Tue, 4 Mar 2025 00:49:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: initialize svm lists at where they are defined
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250221092355.336312-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250221092355.336312-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1P288CA0030.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::43)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: c61d91ff-0a3a-4d14-1262-08dd5ae0557c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGFKcEhOVUx5MEk0YjRyOEUyZ3ViM1AzKzdGZUR1TGl5QkcrcXNtUlZNR240?=
 =?utf-8?B?SVRGak1Ya0R5aGk5dGlTU01tdElXdmtjU1NvcytiWENreElZTVRiM1Y3aFRk?=
 =?utf-8?B?WFk1eGdGQmlZbXVkUmpsSkhWVVdFWEVUeThiMFhRRDVuS210bzY1K2tZQS85?=
 =?utf-8?B?bVhHeUxsbXN1azN2emhiTjVvNkE2azZjcnRycE9Hd3p6bkc5TkVXRkcyYW5N?=
 =?utf-8?B?dFFacEJOU2s4MWxiTGtXWE9pNzloV0E4QnFNeUVRdWJSNWNQNG9jRkJUVWww?=
 =?utf-8?B?MlorN28xWVpwVU9FaGNiZlRDenpSazI4UlA4UUJ1b1RObEdnUnJKdSt1c0lC?=
 =?utf-8?B?QlpFZWNseWZGVEpOeU9wTjNrR2hnK3FkeW9ieGdaZWdaem1VRWo3VzB2ZDZ6?=
 =?utf-8?B?QnBpa0VBTjJoakpkLytRZURWdFA4VzZlcWlzWlJaSGVVVlVXbXZLVTRoYVRv?=
 =?utf-8?B?K21SYitJdnNuckRMVTBaNzhpZGkzbUl4ZkV5eS9PaHQxRXFQSzg0bTlxZ3BE?=
 =?utf-8?B?N3JGUVd1VEFOWU5zWDFOWjVoL3doM08rTUhSTkpCWXJDdDFMZ1hxSGJJam1s?=
 =?utf-8?B?ek5zd29BTHRMZkJkK3k2U0VZMzdRTXBpT0tuNzR0SG1CZlQ3Y2NTTlpJbVFU?=
 =?utf-8?B?VmRDOEdLcEhlaGRtSXVmV2Fka1N1NWJSaUlEMWxXNVpZRVdKa1haRTJlZHo2?=
 =?utf-8?B?aXdpVy9HTG5RK2ljQkFDa1h3UmFIZ0RCYmVkekNVeklWaXVZZHpQbDZLRGRO?=
 =?utf-8?B?OXVWbXFpbWY2YjAza1NhdmVBY1BzNVF1T25vUVlCNlRrYWRkMEIyN3Y4ejVQ?=
 =?utf-8?B?RFhES3YwdEsxUUtSNEs0cUc1UjRqWjNMYlFYVUJPNFNNVWgyTEowTVZqNGJI?=
 =?utf-8?B?d0kvMFIzYmdJVDBPbU9hZ0NZZGdyWldSS3pweUZuRkR6c1VXNzRvSmFZU2Ry?=
 =?utf-8?B?NUF4ZWxaTDBnUk1HSmYyWUV6Q1ZsYlA1eUJSQlduNVpEU04vWXVDUGk3eHNT?=
 =?utf-8?B?OTh4a1NZWFlFZjRRSHZTZnc0SXg1N0ZsZjNRWXJEZkN2UGhWenNWTDNXR3Nr?=
 =?utf-8?B?V1FISVdwVGRxMzgzWXp4NjN6WW1CaWw2ZzByNDQ2QUJkQi9GU3RsU3pYNzky?=
 =?utf-8?B?b1MvVm56K3pnZHNFUnhDT2tnVjR5OFVoVDdYNkFBV3ZuYVJyVDh1a3dzVXVL?=
 =?utf-8?B?MnpGUkpBSVRybVptZmlsWjhmNEpMWXdtejIvSnFWRHJGa3oyWEdDMWhuRExU?=
 =?utf-8?B?MmphajYvME8yQ2ZLcjdBekdkdUFUR3J5SWRzNXQyeVdpUHQrckxKaTZwc3Nr?=
 =?utf-8?B?ZWZDWWQwYmV3TzlPZ2o3Uk1icEN4MzNSaGhaZkNjWkFZOGxBYmpqMzl5UTZ1?=
 =?utf-8?B?L0VobHI0UVJTRnpzbkg2MCtKQUhIQ21iSEtuK2FITnl5WkpMUFNBUG9BTEtt?=
 =?utf-8?B?SVJCd0xBTmcrYWc1YnNObkVuT2RVeGV1RnF0dEhlcUJacVBMY1ErZkNUNkFY?=
 =?utf-8?B?NGtNY2I4S0wyVkRBTnlBUDdqTWluN2Q1RG4yR3duNzBYWmN1emREOGV5Wi9y?=
 =?utf-8?B?eG5ZVVhBRnpuTERWSUh4UFNxNVdSR0g1ZUFsK01NemovZVEzYlRtM3R5aXhl?=
 =?utf-8?B?ZFJ0Nkh6TXFzSTNISjF3dyt0Y0R2TlZHZkhqRk5XNWZlQ01OR1ROZWxXRm5N?=
 =?utf-8?B?c1lxdkNXckJVWUJRVGh6U0dEL3ZXeHhzVVRQSndFa2N6T1pWcGp2WVEwNHpP?=
 =?utf-8?B?OUFCRzhZMDlpQTg1Ym5jZjdJQjd1anlLTkpXTy9aL01KWkNwQ2l1bHp1QVBE?=
 =?utf-8?B?Q2dXcWpnNHE5TllLNzZuYUVSWFV3MVBXdThJK2V2WE1wb1ZsaHU4aTdHSUIr?=
 =?utf-8?Q?9+3y++svizzQo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmR0aGd6S0FqclJJZ3hYbTcrTkJKV2prWUg2ajROb3dQczB6Q2loaHJLckxX?=
 =?utf-8?B?dC95WmpCVUJWdTJONEZXT3RET3hoeHlQTEJEZW1Fazk5RThDUzlKUmhZOEtY?=
 =?utf-8?B?VHM4Um5hNzMxTzNYZ0piV1NVSndHR3ZpMHFXSENDRktzSU5SOXFFWDF0VG9S?=
 =?utf-8?B?ZCtmYms3ektPSGpDdVdEc2ltempNVlh4RW9kYjFNc1hRODl6MzZEVzdyVmg5?=
 =?utf-8?B?WXVSaWI4bEZraVkzYUVXakQ4ZjdrOEpUSjU0Rkk1MUc2SWNrZGc1YXAxZlNR?=
 =?utf-8?B?TEJJbDN1MUdncnE5N2NXQS9vL1lZWU81LzVnYWpobW5YaVl4TEJ3dkJPWk1w?=
 =?utf-8?B?TG9LRW14bDdMZ3RxNktsZG9TN0k1MFA2TVJnWGkvL21mbFByUENEOEhXOVJN?=
 =?utf-8?B?c2tPZ1N4dnFhQnJLVXZjbHFzR1J3MnE0NkkzaUd1S1ZodVZTQVM4YlZEU2d3?=
 =?utf-8?B?eG95eUsyNWRVK2RYSHcvRWN4NmZBZFlodGFlMzhPR3ZXVENIM0J1cGxYNVJx?=
 =?utf-8?B?eVlDS2c5SU54SzVZUzJjQktEMjUyZW9kRGVLcW11UDU0bjRTdmIwaGxjYmFM?=
 =?utf-8?B?QlV5ZVY1WnNoM2c5dHNzdUI1ZG9MekcvSmVuUUVYdVZQVU5JbUJXR24wWUUx?=
 =?utf-8?B?ZFN3TWtwYlJtM1hNNVB3NWYzN3FmcGJJSmtQRmFZekMrT0IzaU53cGEzb1R1?=
 =?utf-8?B?b214b3Bac0FZRDJiclBicHNUbVBDSXJHeEl4cjVscFF5cEpnT2FGTUJEOENC?=
 =?utf-8?B?b0Y3R081NEQzVW9LVVFLTXR5a3VrWVZSZ1JBSmpSNG5PZ1lpc3JVYnYyeTlS?=
 =?utf-8?B?djk3SUNjVEVncS9xd0ptYnZPclI2N25uckpjQW45elg4a0gvM1J5ODZ6cWVu?=
 =?utf-8?B?a0dQYXF4bFBkQXl0eHpLc1Vyc1RiVGlIWTVhSUtmU2ViUUlIeWRPL2piZjRr?=
 =?utf-8?B?TGNNa0Z4aE01RFQwK1kvK1FobUFxbjFzbHZUY0NOcms2VXhhSFA1UUpYOWJ1?=
 =?utf-8?B?ZGtkSGJCWHU5T0dwYm1CZ0Q3NzdSUkpSb3gwREl6aE9KQ1hnbzEwSVlHYnZT?=
 =?utf-8?B?UnpOUVJkQ3poOWJkREpSb09CQ3ZraGRlNXFnUEg4eHlEenY5cHlOVDZUckRj?=
 =?utf-8?B?UjBvZ3R3WlZnZldVb1hqUTU3cmY0K2IwTGtDazdWVzlhUDBXb3pqelp1QkZ1?=
 =?utf-8?B?Y0NLVGVLcEFLSzhpNDdDY1VHZGptaEF1OXdtT21yUFNMK0w5Vm1zVjk1bGhm?=
 =?utf-8?B?cWRwUEVSTWE2SWR6VTR6YlR5Nk1QMDB0WktEL3lxVXMzNlBrL2hGdGdiVGR5?=
 =?utf-8?B?RktxSE1tL0gvZGp0Mld2NnB6Q2o1Nlp0bTB2WG8vdElINUhmZVlrbThSeHJP?=
 =?utf-8?B?M1ZqbHJ0aUtVYi9sd2d6dWRuN2p3UTZkektUdzZ4S1NQc0J5bmN1UERXVmFP?=
 =?utf-8?B?dXBCamU2VnZIQkhxcktqZzBCMkV0ZHRNYVBEb1A2SVQ4a2s4eXFUMXBpdVFZ?=
 =?utf-8?B?d3FvYmVGeHJPbmFNS3NVNGl0WVV5VUxIUWtacGU5NWY1d292U0gxMXFHR0Nu?=
 =?utf-8?B?L3RpMkh3TFZ1VXZadG9GQUN3R3k0WnArT3I0bDlydnFqbjlzM1NVYWZiWHVm?=
 =?utf-8?B?ZzNrSGZwT3gyOHliRkZzR2xhbStNdEtONXpTanVvWVlUaFZZK05pWVNYenk0?=
 =?utf-8?B?RWNGWlF5ZDdreU9XdjFKdXYvK0RDamJYY2dnL2JqZ0JQbmtobjltVUJOUjJV?=
 =?utf-8?B?aEtsNUlFUnlMTkpETHgrblhxdEFMbFIzTU9FV21IU01wMVFUcHNGNUpBek1H?=
 =?utf-8?B?UXpzTGFBa1hjVlZSU1diSmN1VlNGNkR1TVVOZEF1VTQ3UStzdWV6dmhZeWZr?=
 =?utf-8?B?QXh0S3c2aC9iU0ZvNFMxakpmNlJiS2VnUWozL2NPc2RjYW4wRDZGVmZLb0JE?=
 =?utf-8?B?QnR3UDBINkE5cEZtaVN3TXZqNWRKSlArdzBRY1U2dHNNUGhvU20zbzBHT045?=
 =?utf-8?B?T3lvN0MvdG9OWnhJWjVhcFgvbmNGU0ZiTmJnZEtqemZQSWlwTjRTUEx2QlJh?=
 =?utf-8?B?MnMvUCtEMFBlSjN1SmRVZWxvUSt5S1VES0ZmcVR6T1FvUU1XbzIxSytxVlcr?=
 =?utf-8?Q?gy9l83AY/RNmr4XWqVJkbiOku?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61d91ff-0a3a-4d14-1262-08dd5ae0557c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 05:49:31.0878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAqSVhHdaIjRE9DdbW+q5Bl8bhmc4LK09buYpxAYMnV6LaKTLiN9Yd1IlaMBPh5ejuWDGbODZHV4pcq4OoPjAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736
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

On 2025-02-21 4:23, Zhu Lingshan wrote:
> This commit initialized svm lists at where they are
> defined. This is defensive programing for security
> and consistency.
>
> Initalizing variables ensures that their states are
> always valid, avoiding issues caused by
> uninitialized variables that could lead to
> unpredictable behaviros.

The lists are clearly documented as output parameters in the svm_range_add function definition. I think it's more readable to do the list initialization in svm_range_add to keep the logic of the caller more readable. One suggestion inline that would move the initialization to the caller without cluttering the calling function's code.


>
> And we should not assume the callee would always
> initialize them
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index bd3e20d981e0..cbc997449379 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2130,11 +2130,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>  
>  	pr_debug("svms 0x%p [0x%llx 0x%lx]\n", &p->svms, start, last);
>  
> -	INIT_LIST_HEAD(update_list);
> -	INIT_LIST_HEAD(insert_list);
> -	INIT_LIST_HEAD(remove_list);
>  	INIT_LIST_HEAD(&new_list);
> -	INIT_LIST_HEAD(remap_list);
>  
>  	node = interval_tree_iter_first(&svms->objects, start, last);
>  	while (node) {
> @@ -3635,6 +3631,11 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>  	if (r)
>  		return r;
>  
> +	INIT_LIST_HEAD(&update_list);
> +	INIT_LIST_HEAD(&insert_list);
> +	INIT_LIST_HEAD(&remove_list);
> +	INIT_LIST_HEAD(&remap_list);
> +

You could initialize these where they are defined by replacing the struct list_head ... definitions with

	LIST_HEAD(update_list);
	LIST_HEAD(insert_list);
	...

Regards,
  Felix


>  	svms = &p->svms;
>  
>  	mutex_lock(&process_info->lock);
