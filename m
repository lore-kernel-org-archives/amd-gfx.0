Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17FCC25B47
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 09:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E58C10E95D;
	Fri, 27 Oct 2023 09:21:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 517F210E95D
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 09:21:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcEd9gnc/dNCMfODMIAn4gMVoglMaC5TNps5nTKZZUF2RPpWiSd+Jc8Fz/+M+prJIC5mP8KpIqfsUFTFf1OG9VUfwWjf+5/r4Ta8Lv5BGVMLHBzoyVkMdIC7kPtbfR21Sg9KZ7WwAsSgT75sJvp1P++GTQHnHGn9bZ/eYW9SlKw+oYkIDwAmsh6nF7jeq3q5ixLVx4TzbKBEh6Hfg69azFj2DZ0tQtJeWr7XdRL9jsWz9Mhg17eh3h6TnRe4c08PGbVNvL9Nw5GQuenElxE9tgOvHQVuXEPr93PZ118d7ODqxV4lVEmykWLpGf5oJy4uAZgiSdB+r2Hq+AFwOzQu9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nN4UO+0Uv32gyz00xn1jvBfHe608cicFk7fFtC+pftI=;
 b=hs9UW2MEGskceZuOCpF2ZL/QXWFUcEwQE2jheMq5Mz+yoIsTGGLN2kNFhW9bylRgVar/WlsXj/O91+0qo1H6jZuRn+gdUPkdxv2jPGVP0H7oW25foXXv84pxHu02HGMO+X1ckM6qMSxPD85ewiDRlJsduXAv7bIEcHKRsFzNBrF6GSc325syK5Xp+i67/Hr24TgJrjjI6eryPf2YfwEPa2wAFy9IifDWBrtyFSUU4m05Zi/8FD4pIkWjfS8Svdyrbp/s6jqBykTv4lChsEO07wn9CfjKDfYc9ezjvOj+P9NfnfDapa463fqBvlHvcODJhpc5UnjMXEc+3VSbfCnsDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nN4UO+0Uv32gyz00xn1jvBfHe608cicFk7fFtC+pftI=;
 b=eDGPupziz380esSei7o/ALFSDIVrvm44xUVaBFoB1/ZO+ZzNJL7BJMkEHhWGgvG/exMjuFcazjTuaYEzXGvTDoxSO7UDv0H9w+VcVtmMBNGVpTjMpK46JVw+BlLO1/5bx9OWqzazpKRnxw+w8qb4R6pyu1ATMElPQT//B6E2fso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4621.namprd12.prod.outlook.com (2603:10b6:805:e4::10)
 by SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 27 Oct
 2023 09:21:51 +0000
Received: from SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::3410:5919:f369:d9ca]) by SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::3410:5919:f369:d9ca%7]) with mapi id 15.20.6886.034; Fri, 27 Oct 2023
 09:21:49 +0000
Message-ID: <3ef27e68-be40-fce4-1f04-680ee74833d8@amd.com>
Date: Fri, 27 Oct 2023 14:51:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/5] drm/amdgpu: Add xcc instance parameter to
 *REG32_SOC15_IP_NO_KIQ (v2)
Content-Language: en-US
To: Victor Lu <victorchengchi.lu@amd.com>, amd-gfx@lists.freedesktop.org
References: <f68e701c-518d-9782-7da6-2f62f4aaa368@amd.com>
 <20231025205242.40490-1-victorchengchi.lu@amd.com>
 <20231025205242.40490-2-victorchengchi.lu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231025205242.40490-2-victorchengchi.lu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::11) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB4621:EE_|SJ0PR12MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ba9c355-3038-4fb9-8855-08dbd6ce24e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+Sa/BhA+dbPt+N8W/2cGx0rsIL5j0vuooVsBjoG2ZJC0+S5eZmbIuHNgNkMBlcV+9JILHBy0tnf02KvtBR3wA9rc0al9wAdLCc+Lpl4qgq3U7e1yK7XcF6x3L/k0o63DkxF6gOKfiLyzxuQijjmQmQdpdtL26tdJTA2+XjkK/Ic0i3DF3AUVtabByHbL2rXc3+ltH13IlO5z65NhAGhlRHOzHYVEASDk2onleMIlfeGlHk5G72O3IuHexbQL8pdZZ2elzuS8YW8zQRwz0jAXkSB+rFFlZrLj65GcdO2mvyguP98o/8J6SO0C+kZMx7dkNhNef4E+cguxhaAXCtAedogqi9GhHRyQW/YZUBp6c/rLPpaLlwmlazwJsy1vMOBZ6h+lb/JCEF4xRRkXSRP4nOB0d9e0FriIM/WDbgEO/cP8CYaxeYfnxA8LrCeWT82YZQ+V6emNgXoWXth3DompoCx8mmSEQSyR1O6noMmQorjoG8bwt9wRA3ply9ZHakLffWVhG4J/1uuo5StrQZ2fJ9xByGzqL/Rst1n9+z9whBs/TC5oD2seQ9Sh5hwlDOuIvZ/DwmaJLaR0sVKLJgpfjOAhaSIklnT1lK8jtHGTrhpX4zRH+Et9BdcsnaBuqAGmZNYkY6J+siiFYFD681okQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4621.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(316002)(31696002)(66476007)(2906002)(38100700002)(86362001)(478600001)(66556008)(66946007)(6666004)(2616005)(6506007)(53546011)(6486002)(6512007)(83380400001)(4326008)(41300700001)(5660300002)(36756003)(8676002)(8936002)(26005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnNONkMwWktMZXdEeXpJYVJtU0dzTktEM1RHMnMrejkweEpyVnRwUzRoUTE0?=
 =?utf-8?B?UzNYUStWUE1zVkN6cExZblNNYlFxZTFZZ3BrVGl2dlFpTHErYlIrSk9hMjlz?=
 =?utf-8?B?N2M0Q2pnRG1HL01UeVJRdkdxV3JlSXRFdzhYd1FSVk5mUVlYVTJqQXphSTNE?=
 =?utf-8?B?VVRlSkkranlXSGFwVFJvakR0MzlpR1ZmT2pJTDJ5YVY5TVRpUTVXdk1DSURo?=
 =?utf-8?B?ZDhoNmIweHpmWGtNcjdjTWpCV2MvQytDd1Z0QjdTaG5WQ3VYejNjT3dGaW9P?=
 =?utf-8?B?cTdGMmVHOEpTTFZySDV1a1hSdEpLNkxsZ1NvUldXbFZMSUwvWDlaNUhqNDhh?=
 =?utf-8?B?NjM1Y0N4SDlIOVVFcEJ2NjVVVWVWTlEzemJsYmZOMGN6dUREWVc3R2RBOEdQ?=
 =?utf-8?B?KzFydFRldFFJOUdlWHoxVEFuNDcvZEdEMWR4L0d4N2xpRE9NYXBXc1VVb1p2?=
 =?utf-8?B?VVFFSFRZTGVpTmJzSDAzMnZma1ZRSll0VmttZDZnSktsUjE4OWMzMDRkZHRr?=
 =?utf-8?B?NWJZWXNEUXhWbGk5emdxcGNxeWtyRldFNkQvR1pKK3psZ1B1alEwNHBhcUFs?=
 =?utf-8?B?N090N3VPdVBJdGNlTDNiZDFaakhpT3hXSGlaeDdMYURrVEExbktXbmI0MExQ?=
 =?utf-8?B?cXBxQlgyYm95V09oWG5aN1ZwRU9HLzEwc0RlMTRNYjRwaFkyVVRJMUlIcm93?=
 =?utf-8?B?UHRxdUFDODFPT2RGZGtINk00dDhIVDBxTkYvb2YrUVFTSVFTTXJISFZmaEJ2?=
 =?utf-8?B?aWllS09qbGo4OTV6T0NKdHlWRGdRelVvVlZrT21tTGYzNmN0dzV4ZWZKQVVD?=
 =?utf-8?B?U0dTNGsvVmlIKzhaQURmN2xqUEVidDlncm9sK1lHVGlYNTcxYXlUMUIydkVy?=
 =?utf-8?B?Q2dSd3RrOHEyMGd6aEN5OUZwRVR5U25iOUNSRlA1SENYb1ZDVHN3ZDBheDFU?=
 =?utf-8?B?Wmw3emhEVDU5Zi9ZSlgwTEVnSTZ6Rk5PdG5HK0hEeU9uQzZIOXFJR2sra1FM?=
 =?utf-8?B?eDMvc0QzSlVnSTYwVzFoR2drYXBJL01JZ3RRQlNaTUdIWUcrZjZVajN5ZUk1?=
 =?utf-8?B?L25lcFIxMitNbWVuQ3RnNjQzTFdMNWJDOENyWlJpbXJnVG5rMWZqU2pjOUxx?=
 =?utf-8?B?cmNUMWlFS3JMU3Fydi9tODZFR3BHb0ZZdWYrZGtyWS8vZTkrcjlDd1RRTGhq?=
 =?utf-8?B?SHhZdkRFSzM5aEpSTFhZL0NRaUJhY2wyejRXZGFlR0NzZ05zZ1F2NnlUamox?=
 =?utf-8?B?aUVqaVBYWUE3RDllbjZRb0VZdC9yenFHWkhBRThtVzJNdlZqU1Rtem1yYTVi?=
 =?utf-8?B?eDIzY0o4SzVrKzhVc2poOHkyTG9lRWJPMHovbEF0bFVBWm1IcjdSTXRTOE5h?=
 =?utf-8?B?RzdxODljYWc3Q2ZjQ1JEcVRMZENOZGxmUFhldVlNWjR6Y3I2alRibURNUjEx?=
 =?utf-8?B?RzFGdVQ5UzcxRENZSENCcGorcWlqTXpaUGgzNThwbEFqaFZXQ2lqOHU4cmc2?=
 =?utf-8?B?cDNmNlRoaUt6VklsZjR3N0plMDJBMmFCdlIrNS8rcWw4cDdJQzhLK3g4MkZD?=
 =?utf-8?B?VU1RVEtNa2NMTXJubERyY0g2MU5DZ2U2QWw3Y2xrMExJU3l1c2N6MjYwRXpv?=
 =?utf-8?B?NFJDdzZWdTFBaVBUaEltRVE5bGhZb1AxeXlmNkZsUGRBRThkSnR3YVZiV0pQ?=
 =?utf-8?B?YlZzRC9NbXF1cGNBMGNxelVxWHVRdGxJVWFRc3ZJT3FNT3pwYmdhOThJRk85?=
 =?utf-8?B?Ty9HV3B4cTk3MmxiRVpUUHFpUTNaNUNiQ0lsTWlSa1A0Ym5xMjBPa0lhVkJR?=
 =?utf-8?B?cjlobzVwZGVoVzdEbW1JZnMxQzIxNzR4UzJybWcyV0tQdTgxOS9BVXVwRFhK?=
 =?utf-8?B?SU1xa3AxUFo5UHhkMzAwNnRpVnB4ZnlLbktiTkVKek1aUUJXbVltbDB5ellG?=
 =?utf-8?B?dW9ENTBrTWNNNnhBYXhFVm5UcFNlSVg2MDBwZmpVRThxNEZ5ZkZWNlpKUmQv?=
 =?utf-8?B?OWEzVGFCUHJVY0NnNVdIVmxoSC9YdzNQb05Ra3NRTEUzdjM1WFIwcnVaOURH?=
 =?utf-8?B?VUZVMkoyaHFjMGJPZ2lyQWt4RzM3MzFYM01JR0ltSFV6UHA1VjdPZ3RDUG9G?=
 =?utf-8?Q?jVkGuB3PRFpcx9UGaBBARdByw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba9c355-3038-4fb9-8855-08dbd6ce24e7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 09:21:49.4794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRLJ2/MZLGjO6Ahw3T/5+oGFlnKNyGrHTN3Pq/SXE3+lsEJfBOildH5SLfjsInKq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832
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
Cc: davis.ming@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/26/2023 2:22 AM, Victor Lu wrote:
> The WREG32/RREG32_SOC15_IP_NO_KIQ call is using XCC0's RLCG interface
> when programming other XCCs.
> 
> Add xcc instance parameter to them.
> 
> v2: rebase
> 
> Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 16 ++++++++--------
>   drivers/gpu/drm/amd/amdgpu/soc15_common.h |  6 +++---
>   2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index fee3141bb607..b7b1b04b66cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -856,9 +856,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   		for (j = 0; j < adev->usec_timeout; j++) {
>   			/* a read return value of 1 means semaphore acquire */
>   			if (vmhub >= AMDGPU_MMHUB0(0))
> -				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem);
> +				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, vmhub - AMDGPU_MMHUB(0));

The parameter expects xcc id, but this doesn't return that. Only a max 
of 4 MMHUBs are there. To get corresponding xcc, it needs more 
calculation. If xcc doesn't matter for MMHUB registers, use the first xcc.

Thanks,
Lijo
>   			else
> -				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem);
> +				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem, vmhub);
>   			if (tmp & 0x1)
>   				break;
>   			udelay(1);
> @@ -869,9 +869,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	}
>   
>   	if (vmhub >= AMDGPU_MMHUB0(0))
> -		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req);
> +		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, vmhub - AMDGPU_MMHUB(0));
>   	else
> -		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req);
> +		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, vmhub);
>   
>   	/*
>   	 * Issue a dummy read to wait for the ACK register to
> @@ -884,9 +884,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   
>   	for (j = 0; j < adev->usec_timeout; j++) {
>   		if (vmhub >= AMDGPU_MMHUB0(0))
> -			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack);
> +			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, vmhub - AMDGPU_MMHUB(0));
>   		else
> -			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack);
> +			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack, vmhub);
>   		if (tmp & (1 << vmid))
>   			break;
>   		udelay(1);
> @@ -899,9 +899,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   		 * write with 0 means semaphore release
>   		 */
>   		if (vmhub >= AMDGPU_MMHUB0(0))
> -			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0);
> +			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, vmhub - AMDGPU_MMHUB(0));
>   		else
> -			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0);
> +			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, vmhub);
>   	}
>   
>   	spin_unlock(&adev->gmc.invalidate_lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> index da683afa0222..c75e9cd5c98b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> @@ -69,7 +69,7 @@
>   
>   #define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15_RLC__(reg, 0, ip##_HWIP, 0)
>   
> -#define RREG32_SOC15_IP_NO_KIQ(ip, reg) __RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ, ip##_HWIP, 0)
> +#define RREG32_SOC15_IP_NO_KIQ(ip, reg, inst) __RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ, ip##_HWIP, inst)
>   
>   #define RREG32_SOC15_NO_KIQ(ip, inst, reg) \
>   	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
> @@ -86,8 +86,8 @@
>   #define WREG32_SOC15_IP(ip, reg, value) \
>   	 __WREG32_SOC15_RLC__(reg, value, 0, ip##_HWIP, 0)
>   
> -#define WREG32_SOC15_IP_NO_KIQ(ip, reg, value) \
> -	 __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ, ip##_HWIP, 0)
> +#define WREG32_SOC15_IP_NO_KIQ(ip, reg, value, inst) \
> +	 __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ, ip##_HWIP, inst)
>   
>   #define WREG32_SOC15_NO_KIQ(ip, inst, reg, value) \
>   	__WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
