Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1198EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 10:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CCEE10E559;
	Fri,  7 Jul 2023 10:42:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8113910E559
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 10:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjEbv9ZIR2CL9uLmdNmgG9Zn23IOlVhMWNgr6TpBr0R04QgKOGm98bVK9a7qQARhthrjtn8Vl4aqWRxqmGKPrG8warRov131wKVKCkA6Ecmn9gmiY3j+rE1IfBfwpY9VrBlgwc1oC6AhQLqdiY0ht52ks41juuCqYHSatBSS05JmS8qdyOTweFeHPCX6j1GEEbLoMZaTnWu1noR3vTm5SiSMsQg1N0H95fwClWh7Snux4RwytHji1djPHcENLDvVcv8Deh+b6j5rlDcIAQ9pyt6Tds2XYV5NXFvOgRicp1ft9cvCPnm6vRq68k0qa3CxNDYLuCkRLxEoIQq0CHdWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1nQHZ+nV9APo3fdGV3br/sTI7OS0fWf/4aEy6SBueg=;
 b=Y/5dmf4+TVwv1xR0A+K+4c21/xzTM5c+4Rn6QLxLnIhwLHHmN298elDFap28Sd4obenyHUj35JSp+j4xZ93N+/CPFebspF8r0Nx5+mEmYZLUF3uxntws+xcw2plE9q+pXitSyRIgjMLuR8Frh5TCR72SUiQeLhqhy9rlgxI7pBDlJ04/l0h+q5jjx0FXjK8wTFgg3A4/iZWjF0ehFolSglOAPZGsWgkixnvSFAeDH5xV5dxMjx3WMXR9rLMev4K3gtIvIGQAC8ob5KTSv+lrNwSJd1HJZCmLQWyjoQ9miAGoU8TjyPMkvtcJCJcXy3oNfXmkzacXlS6r+kQUCXxiaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1nQHZ+nV9APo3fdGV3br/sTI7OS0fWf/4aEy6SBueg=;
 b=NkC5ieBka0t2kLRq30FCe3k1mz6pXqvYENBfr8zBnr18qy13OaeR4Art6VmRRMeweWYs9TpHQU5AuRPnwHztVUumS5FzKu3mwQuG/d49NJo/amOUPnVPyXx2BRPoX+Mve4a92iXyws+TdMUadI3nRwt97FhdpFL0YHi+dI5SMnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 10:42:40 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0%4]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 10:42:40 +0000
Message-ID: <d861bfc9-f424-1fc3-788c-73d103d333c9@amd.com>
Date: Fri, 7 Jul 2023 16:12:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] drm/amdgpu: use psp_execute_load_ip_fw_cmd_buf instead
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230627044833.3668402-1-Lang.Yu@amd.com>
 <20230627044833.3668402-2-Lang.Yu@amd.com> <ZJ09bLtx8ANXl0wl@lang-desktop>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <ZJ09bLtx8ANXl0wl@lang-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0240.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::17) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 9191a42f-a16b-48af-4bf1-08db7ed6e2ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhDCLA3wRRQuH42u3WEDGiJOqiA00/bLoyLpnW9JhY0Terz5TORizBv91ma2ZswIh6kw9y+c5ng4a/h6U7iBsjyZRrsdVEH68ziRAC27+OICzvp9hEvX4PVRK0MoIWc9ze5ocgWUxOFNqB5xeP7wxrx3TZMZ7QBKeMqSskYDVjpnKCDU6e1UlALfK+BAb0cCrhHEMW13w4zWoUVk+7KXcHOwwuZYTI+PysNiRMh4otstITr13qUni2YOr2vCPFdPs+y1C0D5SnpMobLXOYnvLCZdO8jThXyBVGwxF+7uxuKR4Jx0N+ncFKnl6iJxdpZkBCA9kD7GG9R07FL01J48cXSn2hTQMj8ZNFDQ0S4hk5xpa8O5U9TnOW2VnU1Ad18ijqcdyrT0RR3IfTSyupsf2NGj8Dz2wui9cnsM5cmyWPIris+jlh8Gb5oNWlaoK+RyU/4B2ME/bWS5hb+t2trasJj+Ayxh0lwpTpQpDNAe0RaEJT2UnsukL3GNGQXG0oOLbJv+WcfD+HbYMUFvjgTz3HCobxZDRD6/93H532iBM8CHpPzyCdrUZi6j41kBd8DIvJXvMmbeDRRspvfi+NVey1F2NZz7UuIlPaat/wccyKI7LWiocNXW2DcfbjgOeZYV53/NNo85wxWnoHS5jkE0HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199021)(478600001)(6486002)(6666004)(26005)(53546011)(6506007)(6512007)(186003)(2906002)(41300700001)(316002)(66556008)(66946007)(66476007)(5660300002)(8936002)(8676002)(38100700002)(86362001)(31696002)(36756003)(83380400001)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUc1eXpUQU0yVjArTWdOYlhyMFlaS3h1c3p0U0pqR09ZbDlMdGFUL3Ztdmkz?=
 =?utf-8?B?K1R2dzU5ZzNOcXRmYnZNd2w2bE5qeXFLcEZlSUg4S2hJd1dHamxwVXh5VzBK?=
 =?utf-8?B?KzVyOW9lNEYxSTZzNUNzLzUvNkRiWnprVVh6SUlTN3B0eGxvQ2N4WWdJZTI3?=
 =?utf-8?B?T2tDSllmZWtPWnVrSnU4cll6L3I3bENkczRHMWExdmdGTk9BTU1LUlJBdFU3?=
 =?utf-8?B?MnhaTFZyTm4xN1FuTUs3U3E5NENUQkQvNTN6dmp3dnBTU1g4bGJDdTNsekV3?=
 =?utf-8?B?SEVWTU5Cd2hXZVhkOHYvY3ZMeCtsODIveVJUdWtJc1R6UzdMeWg0UWJlWkk4?=
 =?utf-8?B?cXpLekNET0VRME1KY0gvNlpLcFlJaDNKNHJIT3ZUaHZUY2RiditQdGVBOCs2?=
 =?utf-8?B?Z2MweUc1dUtkZ253dW11eEdiSW15NnZsT1lwdG1wM2djbllNa25IVnF0c01G?=
 =?utf-8?B?bDZlYnQ0VklhMVNsMGtHSHFlQ3haNEdNOGVFSEx3RE5tY1ZOazdVOVU5WkZx?=
 =?utf-8?B?UldOaFJWRUtsWCtXNmQ4UnlJTndtZlNwbnBxQm01RmJ5VHlabFNYYktnVCtJ?=
 =?utf-8?B?eVhab2hYdElXZEFXSVFMbW9BVGFaMjdPSllsZ2dzQk9NM01xVWhmTVJRdnR2?=
 =?utf-8?B?dGw5K0VqdVUrNTU2WUYxdTFqSFhFSmQzMHhjb3FTVG1RNmtBdFFUN0x4SWI5?=
 =?utf-8?B?SzhxRDg5a1RHOEFVTk5zS280czZOQysvaExSYnl3WjZyVjIrKzRhQ2prMlFX?=
 =?utf-8?B?R2dYZ1o1ZjNUYzFRTzhVRFZ2T0p2ckU3TFdwWSt6aUZNdjV4ZFp6MG9PRGRl?=
 =?utf-8?B?K2pFYmpDQ1JrTU5FQlc1Y24vanJ6YnJkZ3NuamcwNFJuWjlid0YzZGRjM1Nl?=
 =?utf-8?B?bTl6T1hkTmVDWUJ3MEhNMkNRMkdRS29mcVdJYUlYYnVHUzhPU2dtVXNVczJI?=
 =?utf-8?B?YndidDZaSU8zRzk1cjdnbGpHdCtwdk5OWlpLUmFBZzNwd2ppUkVCaWh3SmRK?=
 =?utf-8?B?QWZZeVpVV09qeFR0cTBHelhYZUUwK2lWT2RRczFxVmNmNXRVbnEvcmpLRzda?=
 =?utf-8?B?cnYrZThPTTRkYjdocitlc0RHY0Zwc3kvb2JISWxnWUdURTVnTVY1T0hvQ0hE?=
 =?utf-8?B?a2ZFRXNud0Fnc2pCYkRCSGF6M1l0bmJ6cVJZZkxZcUhhdkN4eDQ5UlFHeFJj?=
 =?utf-8?B?SXFuTjhRU20vV1ZEdkRpaHlhNDFXbmhGbGFQUDg2ak9iQm9nYlFEb0dMNmhD?=
 =?utf-8?B?ZGxGQjMxRkFFVUQ4RkpZaUs4c2VFbDJuZHJCczk4T2I0S3JiL1VxaHd6dldq?=
 =?utf-8?B?c0pOTURlTDM5YnppZi9DTEhYcFFVejBrZjV0Q3ZxdFh5Vm1TaFVWUHNvS2pn?=
 =?utf-8?B?L3NReFlsaG1EN0tES1k3UnJwT0JlcEtaTXdONWtlUENsUVlzNFA3cldtcWZl?=
 =?utf-8?B?YVBReE5KbWtwRnZGOU1RTSsxeHhoaDBFbzVBZ1F3cU1USGpXczlFdnZSTS8x?=
 =?utf-8?B?cXZiNkN4ckc1dmE3bW1vVERIcTBwMFdJSmVTS2MyaXRTQ2hwMERIeGtKc1k5?=
 =?utf-8?B?QjNvZXY0blRXaCtuNGNxZXlQdWNYUFd1eWdQS0NuU1Z4bWYwamFLSWJLNXlI?=
 =?utf-8?B?NzZkSVF3UG9RU1RydU0ySFRxa044cDN2ZEUvNE81aE5LbXRDY3lqS0pZUzZv?=
 =?utf-8?B?Rm5YR2dZOC9qVnBFM0pBVDBrQWlFbFloZ2c3RUttVG5pdUtVbmlXWmpqTjZY?=
 =?utf-8?B?VmxkckFZN1d3Nk1QZDY2SHFZTUNwdE1CaW9RaEpOT2hyOWh5RXdkdU8xM2Mw?=
 =?utf-8?B?TFdzWHI4ZGhiYWJlcG5KMjVUUlBDZmFENE9zM0YyRU42QWl2Mkh0UGRSTU13?=
 =?utf-8?B?ai8rL2FIWUozb0k3ditoR2p4NVpNZ1BUdEdhS1dUSWV3cEVpb1ZTRUViRXll?=
 =?utf-8?B?eGdMOUF5NkFNL0RscmJkQW42b015anlWQ1FJSTN1Q0JmUlAyWDJKMzk0Wld4?=
 =?utf-8?B?YVA2NWV6bGtNY2hGMk10MkJTM3VJQkdweHRKSzNGSXhQS2dMdm10SG1XTlhD?=
 =?utf-8?B?MzVzSlU4Y2NkYTVyL21DelprRW5kbWZ2OUZDa0w1ekcrSndMVDhlN1BoaWp3?=
 =?utf-8?Q?xOe0dorbPIUcsAIwJ571WwaIT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9191a42f-a16b-48af-4bf1-08db7ed6e2ac
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 10:42:39.8214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkuSJFWWe/dSkdZx8fjOPtXfEWmmH74j4bLUDpuvmZzZDBmPekbXbUF5QchG+hgH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696
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



On 6/29/2023 1:44 PM, Lang Yu wrote:
> Ping.
> 
> On 06/27/ , Lang Yu wrote:
>> Replace the old ones with psp_execute_load_ip_fw_cmd_buf.
>>
>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 31 ++++---------------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 --
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  9 +++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 +---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 +---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  4 +---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  4 +---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 +---
>>   9 files changed, 20 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index a1cb541f315f..b61963112118 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -2474,21 +2474,11 @@ int psp_execute_load_ip_fw_cmd_buf(struct amdgpu_device *adev,
>>   	return ret;
>>   }
>>   
>> -static int psp_execute_non_psp_fw_load(struct psp_context *psp,
>> -				  struct amdgpu_firmware_info *ucode)
>> +static inline
>> +int psp_execute_non_psp_fw_load(struct psp_context *psp,
>> +				struct amdgpu_firmware_info *ucode)
>>   {
>> -	int ret = 0;
>> -	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
>> -
>> -	ret = psp_prep_load_ip_fw_cmd_buf(ucode, cmd);
>> -	if (!ret) {
>> -		ret = psp_cmd_submit_buf(psp, ucode, cmd,
>> -					 psp->fence_buf_mc_addr);
>> -	}
>> -
>> -	release_psp_cmd_buf(psp);
>> -
>> -	return ret;
>> +	return psp_execute_load_ip_fw_cmd_buf(psp->adev, ucode, 0, 0, 0);
>>   }
>>   
>>   static int psp_load_smu_fw(struct psp_context *psp)
>> @@ -2946,19 +2936,6 @@ int psp_rlc_autoload_start(struct psp_context *psp)
>>   	return ret;
>>   }
>>   
>> -int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
>> -			uint64_t cmd_gpu_addr, int cmd_size)
>> -{
>> -	struct amdgpu_firmware_info ucode = {0};
>> -
>> -	ucode.ucode_id = inst_idx ? AMDGPU_UCODE_ID_VCN1_RAM :
>> -		AMDGPU_UCODE_ID_VCN0_RAM;
>> -	ucode.mc_addr = cmd_gpu_addr;
>> -	ucode.ucode_size = cmd_size;
>> -
>> -	return psp_execute_non_psp_fw_load(&adev->psp, &ucode);
>> -}
>> -
>>   int psp_ring_cmd_submit(struct psp_context *psp,
>>   			uint64_t cmd_buf_mc_addr,
>>   			uint64_t fence_mc_addr,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>> index bd324fed6237..e49984a9d570 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>> @@ -459,8 +459,6 @@ extern int psp_wait_for_spirom_update(struct psp_context *psp, uint32_t reg_inde
>>   			uint32_t field_val, uint32_t mask, uint32_t msec_timeout);
>>   
>>   int psp_gpu_reset(struct amdgpu_device *adev);
>> -int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
>> -			uint64_t cmd_gpu_addr, int cmd_size);
>>   
>>   int psp_execute_load_ip_fw_cmd_buf(struct amdgpu_device *adev,
>>   				   struct amdgpu_firmware_info *ucode,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> index d37ebd4402ef..1805cd042d34 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -1257,3 +1257,12 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)
>>   
>>   	return 0;
>>   }
>> +
>> +int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx)
>> +{
>> +	return psp_execute_load_ip_fw_cmd_buf(adev, NULL,
>> +		inst_idx ? AMDGPU_UCODE_ID_VCN1_RAM : AMDGPU_UCODE_ID_VCN0_RAM,
>> +		adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
>> +		(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
>> +			   (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> index 92d5534df5f4..3ac5ad91ed08 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> @@ -414,4 +414,6 @@ int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev,
>>   			struct ras_common_if *ras_block);
>>   int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
>>   
>> +int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx);
>> +
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> index c975aed2f6c7..74cd1522067c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> @@ -881,9 +881,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
>>   		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>>   
>>   	if (indirect)
>> -		psp_update_vcn_sram(adev, 0, adev->vcn.inst->dpg_sram_gpu_addr,
>> -				    (uint32_t)((uintptr_t)adev->vcn.inst->dpg_sram_curr_addr -
>> -					       (uintptr_t)adev->vcn.inst->dpg_sram_cpu_addr));
>> +		amdgpu_vcn_psp_update_sram(adev, 0);
>>   
>>   	/* force RBC into idle state */
>>   	rb_bufsz = order_base_2(ring->ring_size);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> index bb1875f926f1..79d40203c952 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> @@ -912,9 +912,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>>   		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>>   
>>   	if (indirect)
>> -		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
>> -				    (uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
>> -					       (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
>> +		amdgpu_vcn_psp_update_sram(adev, inst_idx);
>>   
>>   	ring = &adev->vcn.inst[inst_idx].ring_dec;
>>   	/* force RBC into idle state */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> index c8f63b3c6f69..9e1570648b6c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> @@ -1037,9 +1037,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>>   		VCN, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
>>   
>>   	if (indirect)
>> -		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
>> -			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
>> -				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
>> +		amdgpu_vcn_psp_update_sram(adev, inst_idx);
>>   
>>   	ring = &adev->vcn.inst[inst_idx].ring_dec;
>>   	/* force RBC into idle state */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> index 2db73a964031..4febc7629512 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> @@ -993,9 +993,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>>   
>>   
>>   	if (indirect)
>> -		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
>> -			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
>> -				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
>> +		amdgpu_vcn_psp_update_sram(adev, inst_idx);
>>   
>>   	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> index 5d67b8b8a3d6..ce8c766dcc73 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> @@ -778,9 +778,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>>   		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>>   
>>   	if (indirect)
>> -		psp_update_vcn_sram(adev, 0, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
>> -			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
>> -				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
>> +		amdgpu_vcn_psp_update_sram(adev, inst_idx);

This patch breaks this usecase. Here it has uses a specific UCODE ID 
(here it's always VCN0_RAM), but the buffers are different. In general, 
instance ids cannot be associated with the UCODE ID to be used.

Thanks,
Lijo

>>   
>>   	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
>>   
>> -- 
>> 2.25.1
>>
