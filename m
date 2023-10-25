Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB8DC07545
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 11:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8262010E599;
	Wed, 25 Oct 2023 11:27:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 492CF10E599
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 11:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgmAqehAPrjFFbiU7BXJTKEp+R+wc35bqOytxVrAA9NnwRw2ZUbXZqwXxdy4vrh/dtAtyCENwAMnn5u8V73IR/pY2mPk+suMSgr6Cbycw64YRD86EeCGgV8bo9hNThG4HP8NOGsT8Dld4Hm/ZnuSsTUFHsffIMtDS4AdC9HwoDB1T6aHnAu2JXeK/GDyxjKOedC1enFdudH3rYPomivFUraZoDah2oR5Oln1a32mQdxzEhw+GxZx47q4MMmRp42LtbKCt6ngLiFSroXnYJ5hnQmP6c1dsFIBKm0ZeCkQFXUzNfMSF0uXYOCqSrEb0U/CurI0oQGtgWOxIDh9LxUn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Z0p/AoAwpDGrNfI4ah0CA/3N/vA9VVlZbisBYWTg/o=;
 b=a01NQS6Tte5K5M+vRX3EHrui1yL47QGTH8XxliuT91Okdc27M34yGeFwkVVF1b+Mx5Z0BUlTnwshN6iqgIvBh0rvIoRs9BvVjsFKpRCx0NC+3Ob1PnoS0tezWaiSPOjCM4EQP2GtYYjAB65KT44K6Cr/VFSfT9m/dDqcuneJg1SQW7j3QwDWFf9sQL/AjEDlfNeGx9xY0nBqnoSigbIiUkBp7k42BSETw/uQG233pbgyMCuyCBpZ/vRDi6Gy5j1RSDlUxZehNkxrOOADifzJx+SWE3ndVzA388c15dzIgkpTyF+ykcI1czBNX3VQQMi0g6zHRRquDgwpO3LlmiD/tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Z0p/AoAwpDGrNfI4ah0CA/3N/vA9VVlZbisBYWTg/o=;
 b=GL/HjR3HxW7Jby6HC8dqZyq5rGAhGpGmMb/Wbp0oZC3epXZJ14UPgeedHc+rHCNK5FfzKV+4HT8tHBKU2knLtg4L5z4lPywYE6SGbPO5ZxBROs3THbjVVDelan/EIyuep7a7m7m3eJmuRt3CkE4RX3mOjIKf4cvQeNrVg3Q8sAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SN7PR12MB7883.namprd12.prod.outlook.com (2603:10b6:806:32b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 11:27:35 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::737e:9615:922a:d3d4]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::737e:9615:922a:d3d4%4]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 11:27:34 +0000
Message-ID: <f68e701c-518d-9782-7da6-2f62f4aaa368@amd.com>
Date: Wed, 25 Oct 2023 16:57:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 5/6] drm/amdgpu: Add new macro WREG32_RLC_XCC (v2)
Content-Language: en-US
To: Victor Lu <victorchengchi.lu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231004005616.108476-1-victorchengchi.lu@amd.com>
 <20231004005616.108476-5-victorchengchi.lu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231004005616.108476-5-victorchengchi.lu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::19) To SN6PR12MB4621.namprd12.prod.outlook.com
 (2603:10b6:805:e4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SN7PR12MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a05ebda-0de3-41f3-f242-08dbd54d61ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXui7cIdimgU/QekRNOcG+6S3rkZUA+pPK9AfpMv3CuewxTz//FoR9e4ykgEg4tcSv+2vfWqUa+BhPbwdi4qlVn/LXa3W8Wz/JTk4BgWYdGve4jw2NihfgCseQMBW/fussye3od4Z1lAOXHOnazk3iREpwZgrjcSLksNMJtlDIr5+miz+B9+4yXKNNkhGtfnZLPxayVY2hX23a1fFx4n0zR/23TTWHWX+7gfaWqks+1jl1yKLvbS+3m2iIqSBEBopM+tInzV9qpdZMpO7zaCAZaXKRpW73D30lGt1TDcj82EcmEMHJsuTepHLJSFDyQy7UCgFfwefsnaf2be49XUkxndNMFKohiYF5J9HLn4Nb8nfNbCExFRz1UPVZJ0xVCOsjch5H89YOOYFVaZZgzfXK34kvE+U/odhul6QS9j7bLsAQAJQO1L26VgmvoAhQ9RklWLL0dVBay71eP6tKfn/Ol4smhG2AEOSZ/YLaqVqrWK1w6ti73q56jGTpo7o6mxOT3bmRTTjeNNA7XGMu9PpZYXjfBx46BYhMxv+FEgU5WORQqryEEf+xueC7rRoogDbaxmoxKtHiyiI/Fk3cN0sFLhnfbMDoOnb6JhJdiOL2hBXCl3dN4o8SG4zmVsMzu408z1evSr/zS8AIxs8fc8YQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(5660300002)(6486002)(86362001)(66476007)(41300700001)(66556008)(66946007)(478600001)(31696002)(6506007)(6512007)(316002)(6666004)(8676002)(36756003)(38100700002)(8936002)(4326008)(2906002)(2616005)(53546011)(26005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFhPMVRFVVNBdVVLODdhSlhLRjhrUW00V2w4djI2ZXRrYytaMis3eE1BL1JE?=
 =?utf-8?B?QlZtMVRCaHRCcEVhd2xUVm5LMkJMYXZPRFRxQkJkalZ1QjBvOHVucnVzTUVn?=
 =?utf-8?B?MzNxTXBZYnAzQ1pMQzFwWitSQW12STZKSTlWMTloRFR4VEcyc2x6OWRBa2Jk?=
 =?utf-8?B?UW5ncnR1MDdsMTNlMVd5RzR4TjRlYkNVU2Fzd0FXcnV4R1k2Qm5LMEtmQU1m?=
 =?utf-8?B?bi9EcDFKdlRCUGN1ditCY0kzWG8wKyt1S0V1NGVocENOZ2tJU3pJNUcvNjhL?=
 =?utf-8?B?U2ZpamswcWFjek5IeXllcTBBNUVUUUlvUzBsSzdHSnF5OU5wVDhMd3BTbGNF?=
 =?utf-8?B?ZkxjSUMvRXNKRHlvRUlhZ3NCNWdkSWVBcFE5QTMzeHd0MVVpYVNsWFlQd3FH?=
 =?utf-8?B?Y1M1M1BuVHlHbTZ2cXEyZ1pBQm9hcmh1VWg2by9KWUVaL1ExNklQWlMwZEQx?=
 =?utf-8?B?KytxcnpqYnMydTNWNEkzVHl2eFZZOUQrL3Q2UUVUUkRkcFF5cHZpSDMvTzJV?=
 =?utf-8?B?a2Vra0xmblRkb1AvWmo1VllPd0JPUnZpVkRwZzkxdmo1eHZNN0ozL1Uwc0dx?=
 =?utf-8?B?NmlBOEFRcHd2RkVRUGdVUnFwSHpBZjVXVXk3UWt4SzBSNjZsSyt4L0NUeU5v?=
 =?utf-8?B?NVhWOWRuTFBxSVplY2JDUDlwVWtlb1Q1UnJRY2lYREk4MGgyTWlrU3lkS3k4?=
 =?utf-8?B?bzdyT1JsQkY0ZDlnV2ZUNloyc2E1RmQ4bmcyOUhmNWtYVXpFUzU1dTZRbkxV?=
 =?utf-8?B?Nkg5RHBDV1BUUVIrZUZmL2RNMW9JSWxVUG5tSEQ3OHZUdjRsWDNzSzNBcU9p?=
 =?utf-8?B?RFIzVFkvSHlUaENMT20xTW5JZkR1eGpoSzFuOWVUK1FMMWlOT2pTUUFPbmVy?=
 =?utf-8?B?cldYMHpjUHl6cE9OL0twbnRJRllvOXFtcy8vc3lNTVhZZERXY1JlV29ZTkx3?=
 =?utf-8?B?Vmo0dE1CM2taSlZ3NWZVSDB2cFdRZ1hiUG5TK1BUSWswNlRCZURpT0FCclBK?=
 =?utf-8?B?ekRoK2ZFZWNBcjZRYkhvK1FBekhlcjh4TGVnZVdYcjVRYmRVZENkRlJwbnBu?=
 =?utf-8?B?NHhtbHcvNzZSYzF0WW1xSWZVbUphUFduWlBEMFZkYnUvQUFJMnp3VUhmRWph?=
 =?utf-8?B?ME4yWk9FRXZHTlJGVENxTnZVdjg0S2svR1cyRnBCVVEvcVJSTG5xT2lvN2F5?=
 =?utf-8?B?Q2VNZXpQM2tsWHVpN0FPQ1VReDdCOEgxSEpLSjlrS1NNM3k0M3hlcGYxdElS?=
 =?utf-8?B?cmVWUzdvdU9VNHBpK2luU1k4VzUxc2NMVWhqMHhmQXl4TVdUZW12WjMrTTJh?=
 =?utf-8?B?bmJ0VThuU21IeDVPLzhRZzNrOFlrL3AwbUpRSHFvUHdOZnZVMW4zT2VMQ1hR?=
 =?utf-8?B?YjFCa0lCV3NTbnN5N0JGbk5KQlg1aWgyUmNQM0Noa3lZUElKMjhjUmdTSFEz?=
 =?utf-8?B?V2taSkZVTGx6RFVFcDdJa3BUS1FtS3FtQ3N1bks4Ti83YTJtclZvQk5Hd0V6?=
 =?utf-8?B?QnJuQ0trNGdiL1hTUldVYmNOS3AwTTA2TEJObUVNbGhzRzVwalJ6NkRxWHNY?=
 =?utf-8?B?bkQ0bUkzOGR0Yk1mUnVUTVUzZGNUV3lXYnNmUlVaMUI1blZPOGJBYmg4bDhw?=
 =?utf-8?B?MTlUYy9Mb1l1WkNOclFUMU5TZW0vOFN4bURKYXk5QmluTHFyank5QTljN1Nm?=
 =?utf-8?B?WjRjSDMxRGdQMDRxQ3ZKblMwZkNCNVlTS3lDZmZ1c0hkUWJpZ0JBNnZUNEQ5?=
 =?utf-8?B?bDZ1cVZEajFqNTR5Z0tTWmEvdU11YnJGR2xGZGF1cDFNRkxUT0Exc3NtaXQ3?=
 =?utf-8?B?MTdZRjcvSWpaeVQvVFRVaEV1eVBRTnFmVFBaUzlnNFA2NmhRU2lEQlIvTnFw?=
 =?utf-8?B?ZFlWUitTODJtOTF0cDhFNk1ra053M2VZM0NtZTV2UkEvRnJNZkQyWEZNZ2ov?=
 =?utf-8?B?WDUrd05FQXlvSk1pZDVnU0ZLcTJYQjJtaktPZHhIdVhEKzZPSnN1eStoemRZ?=
 =?utf-8?B?ZVNMN3JGOWV5MzFYd01uaXBvTWxWUUUvdS9oWXdrTjM0bE10N1RuZWgxQUdn?=
 =?utf-8?B?dW9zUzQzaksxNkNicFB2ZWdCaXZqODh2TlhMSXk5Ujg3anB4T2Uxanc0ODI0?=
 =?utf-8?Q?hRCgO+thsdCtgufEPl0cvcHKu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a05ebda-0de3-41f3-f242-08dbd54d61ad
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4621.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 11:27:34.4422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXiGfqAb23Y5mfjcox61onaJ0RnYy9P1KHlnsC3Y22TtoAg0yxxWeE47ZwhW36b7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7883
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



On 10/4/2023 6:26 AM, Victor Lu wrote:
> WREG32_RLC does not specify the correct XCC so the RLCG interface does
> not work.
> 
> Define WREG32_RLC_XCC to be like WREG32_RLC but include a parameter to
> specify the XCC.
> 
> v2: Add new macro WREG32_RLC_XCC instead of modifying exiting WREG32_RLC
>      macro
> 
> Original v1 title: "drm/amdgpu: Add xcc instance parameter to *REG32_RLC"
> 
> Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
> ---
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 41 +++++++++----------
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 34 +++++++--------
>   drivers/gpu/drm/amd/amdgpu/soc15_common.h     |  8 +++-
>   3 files changed, 44 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index 490c8f5ddb60..084dbc41b579 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -300,14 +300,14 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
>   	hqd_end = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_AQL_DISPATCH_ID_HI);
>   
>   	for (reg = hqd_base; reg <= hqd_end; reg++)
> -		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
> +		WREG32_RLC_XCC(reg, mqd_hqd[reg - hqd_base], inst);

To avoid too many macros causing confusion - better to define 
WREG32_XCC/RREG32_XCC keeping in mind cases like these.

Use the existing WREG32_SOC15_RLC/RREG32_SOC15_RLC for accessses like below.

WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), 
regCP_HQD_PQ_DOORBELL_CONTROL), data, inst);

Thanks,
Lijo
>   
>   
>   	/* Activate doorbell logic before triggering WPTR poll. */
>   	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
>   			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
> -	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_DOORBELL_CONTROL),
> -				data);
> +	WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_DOORBELL_CONTROL),
> +				data, inst);
>   
>   	if (wptr) {
>   		/* Don't read wptr with get_user because the user
> @@ -336,27 +336,26 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
>   		guessed_wptr += m->cp_hqd_pq_wptr_lo & ~(queue_size - 1);
>   		guessed_wptr += (uint64_t)m->cp_hqd_pq_wptr_hi << 32;
>   
> -		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_LO),
> -		       lower_32_bits(guessed_wptr));
> -		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_HI),
> -		       upper_32_bits(guessed_wptr));
> -		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_POLL_ADDR),
> -		       lower_32_bits((uintptr_t)wptr));
> -		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
> +		WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_LO),
> +		       lower_32_bits(guessed_wptr), inst);
> +		WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_HI),
> +		       upper_32_bits(guessed_wptr), inst);
> +		WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_POLL_ADDR),
> +		       lower_32_bits((uintptr_t)wptr), inst);
> +		WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
>   			regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
> -			upper_32_bits((uintptr_t)wptr));
> -		WREG32(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_PQ_WPTR_POLL_CNTL1),
> -		       (uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id,
> -			       queue_id));
> +			upper_32_bits((uintptr_t)wptr), inst);
> +		WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_PQ_WPTR_POLL_CNTL1),
> +		       (uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id, queue_id), inst);
>   	}
>   
>   	/* Start the EOP fetcher */
> -	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_EOP_RPTR),
> +	WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_EOP_RPTR),
>   	       REG_SET_FIELD(m->cp_hqd_eop_rptr,
> -			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
> +			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1), inst);
>   
>   	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
> -	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_ACTIVE), data);
> +	WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_ACTIVE), data, inst);
>   
>   	kgd_gfx_v9_release_queue(adev, inst);
>   
> @@ -494,15 +493,15 @@ static uint32_t kgd_gfx_v9_4_3_set_address_watch(
>   			VALID,
>   			1);
>   
> -	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
> +	WREG32_RLC_XCC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
>   			regTCP_WATCH0_ADDR_H) +
>   			(watch_id * TCP_WATCH_STRIDE)),
> -			watch_address_high);
> +			watch_address_high, inst);
>   
> -	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
> +	WREG32_RLC_XCC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
>   			regTCP_WATCH0_ADDR_L) +
>   			(watch_id * TCP_WATCH_STRIDE)),
> -			watch_address_low);
> +			watch_address_low, inst);
>   
>   	return watch_address_cntl;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 51011e8ee90d..2a4f1a1b2196 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -91,8 +91,8 @@ void kgd_gfx_v9_program_sh_mem_settings(struct amdgpu_device *adev, uint32_t vmi
>   {
>   	kgd_gfx_v9_lock_srbm(adev, 0, 0, 0, vmid, inst);
>   
> -	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmSH_MEM_CONFIG), sh_mem_config);
> -	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmSH_MEM_BASES), sh_mem_bases);
> +	WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmSH_MEM_CONFIG), sh_mem_config, inst);
> +	WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmSH_MEM_BASES), sh_mem_bases, inst);
>   	/* APE1 no longer exists on GFX9 */
>   
>   	kgd_gfx_v9_unlock_srbm(adev, inst);
> @@ -239,14 +239,14 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
>   
>   	for (reg = hqd_base;
>   	     reg <= SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI); reg++)
> -		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
> +		WREG32_RLC_XCC(reg, mqd_hqd[reg - hqd_base], inst);
>   
>   
>   	/* Activate doorbell logic before triggering WPTR poll. */
>   	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
>   			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
> -	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_DOORBELL_CONTROL),
> -					data);
> +	WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_DOORBELL_CONTROL),
> +					data, inst);
>   
>   	if (wptr) {
>   		/* Don't read wptr with get_user because the user
> @@ -275,25 +275,25 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
>   		guessed_wptr += m->cp_hqd_pq_wptr_lo & ~(queue_size - 1);
>   		guessed_wptr += (uint64_t)m->cp_hqd_pq_wptr_hi << 32;
>   
> -		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_LO),
> -		       lower_32_bits(guessed_wptr));
> -		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI),
> -		       upper_32_bits(guessed_wptr));
> -		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_POLL_ADDR),
> -		       lower_32_bits((uintptr_t)wptr));
> -		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
> -		       upper_32_bits((uintptr_t)wptr));
> +		WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_LO),
> +		       lower_32_bits(guessed_wptr), inst);
> +		WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI),
> +		       upper_32_bits(guessed_wptr), inst);
> +		WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_POLL_ADDR),
> +		       lower_32_bits((uintptr_t)wptr), inst);
> +		WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
> +		       upper_32_bits((uintptr_t)wptr), inst);
>   		WREG32_SOC15(GC, GET_INST(GC, inst), mmCP_PQ_WPTR_POLL_CNTL1,
>   		       (uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id, queue_id));
>   	}
>   
>   	/* Start the EOP fetcher */
> -	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_EOP_RPTR),
> +	WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_EOP_RPTR),
>   	       REG_SET_FIELD(m->cp_hqd_eop_rptr,
> -			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
> +			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1), inst);
>   
>   	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
> -	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE), data);
> +	WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE), data, inst);
>   
>   	kgd_gfx_v9_release_queue(adev, inst);
>   
> @@ -556,7 +556,7 @@ int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, void *mqd,
>   		break;
>   	}
>   
> -	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_DEQUEUE_REQUEST), type);
> +	WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_DEQUEUE_REQUEST), type, inst);
>   
>   	end_jiffies = (utimeout * HZ / 1000) + jiffies;
>   	while (true) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> index c75e9cd5c98b..19b233189e73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> @@ -110,6 +110,9 @@
>   #define WREG32_RLC(reg, value) \
>   	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_RLC, GC_HWIP, 0)
>   
> +#define WREG32_RLC_XCC(reg, value, inst) \
> +	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_RLC, GC_HWIP, inst)
> +
>   #define WREG32_RLC_EX(prefix, reg, value, inst) \
>   	do {							\
>   		if (amdgpu_sriov_fullaccess(adev)) {    \
> @@ -140,7 +143,10 @@
>   
>   /* for GC only */
>   #define RREG32_RLC(reg) \
> -	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_RLC, GC_HWIP)
> +	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_RLC, GC_HWIP, 0)
> +
> +#define RREG32_RLC_XCC(reg, inst) \
> +	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_RLC, GC_HWIP, inst)
>   
>   #define WREG32_RLC_NO_KIQ(reg, value, hwip) \
>   	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_RLC, hwip, 0)
