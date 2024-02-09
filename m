Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657D8C4828F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Feb 2024 07:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAAFF10E926;
	Fri,  9 Feb 2024 07:47:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VZLOsuvB";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56DF010E847
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Feb 2024 07:47:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScMDTcJUaQhMGTC5W+wTg/ZypcRmcOD3QG61Z1vIApWLN7vwbzwRcxpM4q+e7RKM7MRD3lC9dra6MiCM9lGh7b0OAGS07vJh3iOqo5VsaWfG0EViAI6TKHdsgJDPUAFbaxYynlakdZrMZAXHore5YK+DaMS4B2NAhaV4eHOXzDhkXpAXJ3fbrpslG7aOQMiuF79jbB2hzZYZAP3ql1tZysbnTLr18VHEEaCV8T0/+859rEl7X1sxDQtNu4gDQrouKfvU3kdSoj7a0nAEdKYmNLIFa9d5JxTmE01DH+LAvcx5XUwKTDMPw/eVpBoA/mxXCtasC7ShMBfVp9wpBeiLZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIsKf9MnAL6jZiuUm2VXrZSQ/uuus9gp/j6oowK7bKQ=;
 b=igiWxxkMRwxXelNWl7PcGxq8ZglXJrqs+d2qJ8H/MLCY93uMXdLwD6sNnLBEANI2SRlc8opnQdtv/kLyDcZ+0c6bq1rebjLbXYKBsCv4jEgJGofMQ29pZ3lNbzDyN3cYXaUABuN98imN/HeQ2z6k0MyyDCfmdIrb9RACY0EoMsV4IjcEe4axAFpvvBWQ+vuBmoM//xxDaFHsLePj3sdaKussdE4qO2HC9/iVmJIs/T8HBbTiaQFPaAveCYe8vKn1m0yZB/nYrXAbI9FlVCnqTEolAaJ8xptXvNex4UMw5TfBauFi8mXqK63g3JyVy+Jl48rzm6CqMA+5agbcIWauJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIsKf9MnAL6jZiuUm2VXrZSQ/uuus9gp/j6oowK7bKQ=;
 b=VZLOsuvBwwh15Kye3ZRaeyVE+NQzrymqqm3oLKjWVl9CSo5v9SOeiHxKhsQXjNnpXyf9NaAeqodbsKWfA7ZUp4hYnUvsFpeiKKgoY0JVz6aOhTOh1/kopDljPfDO8eMEhDgjpyT8aqRis0MaxuUanYrDrpKEQnY4Rp8/1fTGO4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Fri, 9 Feb
 2024 07:47:40 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::3639:e4bf:a222:7dbe]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::3639:e4bf:a222:7dbe%4]) with mapi id 15.20.7270.016; Fri, 9 Feb 2024
 07:47:40 +0000
Message-ID: <47b42341-8f08-48d8-aa5f-36568a06744e@amd.com>
Date: Fri, 9 Feb 2024 13:17:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Allow setting max UCLK on SMU v13.0.6
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com,
 Le.Ma@amd.com
References: <20240209063446.330452-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20240209063446.330452-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 7865a80d-b0d6-4443-2c16-08dc29436443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UXsdb6U3RrLFdBEXWVXuPLGHlpPjK+SAVCWwlSGJ7/w7F9CDQdOT9JMHNp0geBpyjc+a+1eKktsRKgBpJ8L1yrXzYSzdic3h1qBExQrNLmKKdkYk/L4E9bT/ScDeuFGiotJMwLKlM0GsPiSjym1FSFPeYH5dYte1CNuXsS3M5ZMvQlH5eyK6m6ZPrmDUfBSDpGShaJbRWuc+/ElMy0UuWBIEooghwlUDCDSc+U3kuQSoHICNER0HUDaW3FYubk8upAATLQNU/2JXPKEPR0+YuZeXHme2bZmyegK7U4JmawrXUuzJ8TELA18QQiM5EyF8alK5lqkWZ0LyBbFyoK2ZZl0RH5ACkrBfp1czbB4JNti/SGN/Gf5dxIqDFHfsv1TtXe/VEkyVJFM1uHXrRCT4zj4aZuAztV1RBy14LaN6/YWuInm1kwg9RmhiGD0VxccRlBzZJMmvMSjp/6ZhhjxvGKCDUKWq8+sVkXuEJck2YM0UTB7fLmREQmwXQmhWcCyZW8lVRks2GlHfLrQrqur5F56D9Qm3Rz799xs+W4iobDQtpdwA1D9wpKhclVP4LLkT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6506007)(83380400001)(26005)(6916009)(4326008)(38100700002)(6666004)(5660300002)(66556008)(8936002)(316002)(66946007)(66476007)(2616005)(8676002)(478600001)(53546011)(86362001)(6486002)(31696002)(6512007)(36756003)(41300700001)(31686004)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajk2alp1c2k3bWRLNzE1N3ZsYzhZczREQXlBVXh6QTRBRjExVVFhT05oVU5q?=
 =?utf-8?B?eXNjZTcwb21KOXp1R2hEVlJSaG5PNklYczBVUDJGUkhkVDRPaEVaMUQ0VzZB?=
 =?utf-8?B?VjNmSnNNRmd2b2VxY2NNajdUV2pqM1c2MnRSSEgrYWdYT0h5a3FJM0tTclVQ?=
 =?utf-8?B?Z3E1d0F3NmxNRzY5WlN5K1ppc0xlWVB3VjM0c2JlWHVPVkpsK0Y3ZmliRGx0?=
 =?utf-8?B?dGllN09CQTBpZHRpV2VQQWtCMVVCV2hoOTVLaXNUVVJqS0JlU0hoaGNteWpr?=
 =?utf-8?B?M3lteEw3R0RzQmFtMUdFWnVwbXRHb1Rkc0RUeUNWRlhCd2JoWmhPKzRSMnUw?=
 =?utf-8?B?cUpYZVpHMUgvY3J5a09XVU5kUzYxQ1JOdGpYZ2ZFVmZTb2sydndrVFJCWk5k?=
 =?utf-8?B?UGRFQ0EzVS9zNkhEbmlHN2RJSExEdE1sSDgzR0wxYVJHNzFzb2wvNDJoK1Jk?=
 =?utf-8?B?VURjNm5Ray9KMFAyTHNMcnVHcmN2VDZKdlFLaFBFWnZPTjFWTEJZVWVRUzYy?=
 =?utf-8?B?cmJ3b1BWVldlSWlTcE5rWEpYWG5WUVJIcGhUZGJtYWVhSG9ZVVhhejhtdUpL?=
 =?utf-8?B?bEdpWTE1NUtHZzZtODV1eURxSjMxQWxXbFlMVHhKNGM0MlJxU25OZFEwZXVZ?=
 =?utf-8?B?TDBFUlc1VGhkR2dVa1ZrQ0V6aXpjcW5wL0lFQjlWenNvWmFBYTJESWE2bHdt?=
 =?utf-8?B?UWl4d210QWNlMEdvVDNJV05vYzhONkpybjM4Qy9UcVIvRWRSaDdiOEQ5KzR5?=
 =?utf-8?B?cWJzQTIwVE42K081UW9LanBmSEZncDJmQy92cUZBZVF6blYwenoxeU9YSXJ5?=
 =?utf-8?B?eUovTUpSeUxITzFXZDVMbHNscC9oUjV2WFVwTmRqVEFZMFliZkFGSzJ3Zmtx?=
 =?utf-8?B?Wi84ZkZhK1ZiekQ1VXNIejRHeGEyS2QyWGZVZDJiZXMyTVlsQ2YyL0tiNHRF?=
 =?utf-8?B?WWRtbDhaVjdQWU1peWZqQVlUeFlGZktPaXBkaDdLNnRNWWJRRXhzQkdORWhU?=
 =?utf-8?B?R2tvWGV3RDFXUTdIOStmN2M5RHJsNDVaazdFL0RPNk9sakFhNE80c1FjRDVi?=
 =?utf-8?B?T3prZVB2Ny8zMDhWM0xIUFRGa0N5WnhKR290R3RrYXBvQjV0aFNxaFFJN3kr?=
 =?utf-8?B?eTRhZ1paWlF2NzRPTEdWRDVZYkplbVZCVHZJSFlBdGt0ME5EYlB6aDFOSVk3?=
 =?utf-8?B?bjNncllyYjRVOE00c2xyZHJ3TlVHYTdnYjBMR1NBZWhmb0N2U3llUnJxSlVj?=
 =?utf-8?B?eDhRckdZRXdQRXFWbkxJOG5ZbDNIa3hwZEZnNXFWTlcxYStMVS9hVmtjYitT?=
 =?utf-8?B?R2NzWlBrRU8wTTBJaTJpUlN4TDJMQ2trVGZtVy8rSHRxc3BhYkd0bkRucmVi?=
 =?utf-8?B?bjFUZ2NJcmhEOFlFNGN2L0ZOOTQrTXN0cUh6c3VHRWtrZjNhdGJzMmVGQlIw?=
 =?utf-8?B?TktxZHp2N1gxM25pejVqSk5nM2dZVldEK01DUkhxWVQ1RDJnSE5URDFzb3ho?=
 =?utf-8?B?SWEyMkd4bmVlUys4YzBqcVZUNXQ3cXdFamdZaWgySzFOZlk3aVJpSGYvemxj?=
 =?utf-8?B?SXl4ZncyNnFIbDF5SFdxMjBVMDVyQk9iS3FBUGFQWWZkWTkvZVFJbThmT04x?=
 =?utf-8?B?aWtrUmFQcjdXc0dwU1p3YzdQS2MxZWdjZkRRc01VZHYyV0ZsRGI0YVZMTWdX?=
 =?utf-8?B?ZzFNZk1mVFJvKy9VMFlzbFZsSDBoTWpKWndmT21uMVJDYmdRdHhFQjEvZ2VR?=
 =?utf-8?B?Z3Ivc2hXQ2VSbnRWQUJHU25ZZTMvendLRUtwVXNrS3prL1lLaDd6RXlvSy9w?=
 =?utf-8?B?ZHpPdWxNY0p1VFBNSnpYVzZra0hHc0tHaWRQcmZUcHNDQWVhZm1pVFV5bHVr?=
 =?utf-8?B?cW45OXZWYmZqMW8rRFRHQ3k3UzhNRXljUEdNVGQ1ZmtxMnpuYmc1K2dVVlkw?=
 =?utf-8?B?M1VaaWFSZXlhV0V6SERtRWdHak5Nd21yRnIybHJBeUc5blpQSWFaNjE2Q3B0?=
 =?utf-8?B?eU5lUm55VDBDN09wbU9FcUFHaG5KMUhOV0tBVnYrK3FWbDZhTE04SmFjS1Nq?=
 =?utf-8?B?LzJpWnZGUnJ2UnkxUXFxblhod210R1V5MUVQN2lvVnkreXdsMTNlYWs0RFp1?=
 =?utf-8?Q?JmYwQuBlbZpAUVoSmtaBLTJRF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7865a80d-b0d6-4443-2c16-08dc29436443
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 07:47:40.4896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/kKmvHXkJvCcna/AKVDAVZMI1n8x7mK295vYS7YHrAsQ3aCTNvoGIMh64Ts8KR2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781
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

Sending another one, please ignore.

Thanks,
Lijo

On 2/9/2024 12:04 PM, Lijo Lazar wrote:
> Allow reducing max UCLK in MANUAL performance level. New UCLK value
> should be less than the max DPM level UCLK level value.
> 
> Ex:
> echo manual > "/sys/bus/pci/devices/.../power_dpm_force_performance_level"
> echo m 1 900 > "/sys/bus/pci/devices/.../pp_od_clk_voltage”
> echo c > "/sys/bus/pci/devices/.../pp_od_clk_voltage”
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 103 ++++++++++++++++--
>  1 file changed, 92 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 03873d784be6..9929981ff6c5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -1578,6 +1578,8 @@ static int smu_v13_0_6_set_performance_level(struct smu_context *smu,
>  	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
>  	struct smu_13_0_dpm_table *gfx_table =
>  		&dpm_context->dpm_tables.gfx_table;
> +	struct smu_13_0_dpm_table *uclk_table =
> +		&dpm_context->dpm_tables.uclk_table;
>  	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
>  	int ret;
>  
> @@ -1604,6 +1606,15 @@ static int smu_v13_0_6_set_performance_level(struct smu_context *smu,
>  
>  		pstate_table->gfxclk_pstate.curr.min = gfx_table->min;
>  		pstate_table->gfxclk_pstate.curr.max = gfx_table->max;
> +
> +		/* Min UCLK is not expected to be changed */
> +		ret = smu_v13_0_set_soft_freq_limited_range(smu, SMU_UCLK, 0,
> +							    uclk_table->max);
> +		if (ret)
> +			return ret;
> +		pstate_table->uclk_pstate.curr.max = uclk_table->max;
> +		pstate_table->uclk_pstate.custom.max = 0;
> +
>  		return 0;
>  	case AMD_DPM_FORCED_LEVEL_MANUAL:
>  		return 0;
> @@ -1626,7 +1637,8 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
>  	uint32_t max_clk;
>  	int ret = 0;
>  
> -	if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK)
> +	if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK &&
> +	    clk_type != SMU_UCLK)
>  		return -EINVAL;
>  
>  	if ((smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL) &&
> @@ -1636,18 +1648,31 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
>  	if (smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
>  		if (min >= max) {
>  			dev_err(smu->adev->dev,
> -				"Minimum GFX clk should be less than the maximum allowed clock\n");
> +				"Minimum clk should be less than the maximum allowed clock\n");
>  			return -EINVAL;
>  		}
>  
> -		if ((min == pstate_table->gfxclk_pstate.curr.min) &&
> -		    (max == pstate_table->gfxclk_pstate.curr.max))
> -			return 0;
> +		if (clk_type == SMU_GFXCLK) {
> +			if ((min == pstate_table->gfxclk_pstate.curr.min) &&
> +			    (max == pstate_table->gfxclk_pstate.curr.max))
> +				return 0;
>  
> -		ret = smu_v13_0_6_set_gfx_soft_freq_limited_range(smu, min, max);
> -		if (!ret) {
> -			pstate_table->gfxclk_pstate.curr.min = min;
> -			pstate_table->gfxclk_pstate.curr.max = max;
> +			ret = smu_v13_0_6_set_gfx_soft_freq_limited_range(
> +				smu, min, max);
> +			if (!ret) {
> +				pstate_table->gfxclk_pstate.curr.min = min;
> +				pstate_table->gfxclk_pstate.curr.max = max;
> +			}
> +		}
> +
> +		if (clk_type == SMU_UCLK) {
> +			if (max == pstate_table->uclk_pstate.curr.max)
> +				return 0;
> +			/* Only max clock limiting is allowed for UCLK */
> +			ret = smu_v13_0_set_soft_freq_limited_range(
> +				smu, SMU_UCLK, 0, max);
> +			if (!ret)
> +				pstate_table->uclk_pstate.curr.max = max;
>  		}
>  
>  		return ret;
> @@ -1740,6 +1765,40 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
>  			return -EINVAL;
>  		}
>  		break;
> +	case PP_OD_EDIT_MCLK_VDDC_TABLE:
> +		if (size != 2) {
> +			dev_err(smu->adev->dev,
> +				"Input parameter number not correct\n");
> +			return -EINVAL;
> +		}
> +
> +		if (!smu_cmn_feature_is_enabled(smu,
> +						SMU_FEATURE_DPM_UCLK_BIT)) {
> +			dev_warn(smu->adev->dev,
> +				 "UCLK_LIMITS setting not supported!\n");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		if (input[0] == 0) {
> +			dev_info(smu->adev->dev,
> +				 "Setting min UCLK level is not supported");
> +			return -EINVAL;
> +		} else if (input[0] == 1) {
> +			if (input[1] > dpm_context->dpm_tables.uclk_table.max) {
> +				dev_warn(
> +					smu->adev->dev,
> +					"Maximum UCLK (%ld) MHz specified is greater than the maximum allowed (%d) MHz\n",
> +					input[1],
> +					dpm_context->dpm_tables.uclk_table.max);
> +				pstate_table->uclk_pstate.custom.max =
> +					pstate_table->uclk_pstate.curr.max;
> +				return -EINVAL;
> +			}
> +
> +			pstate_table->uclk_pstate.custom.max = input[1];
> +		}
> +		break;
> +
>  	case PP_OD_RESTORE_DEFAULT_TABLE:
>  		if (size != 0) {
>  			dev_err(smu->adev->dev,
> @@ -1750,8 +1809,19 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
>  			min_clk = dpm_context->dpm_tables.gfx_table.min;
>  			max_clk = dpm_context->dpm_tables.gfx_table.max;
>  
> -			return smu_v13_0_6_set_soft_freq_limited_range(
> +			ret = smu_v13_0_6_set_soft_freq_limited_range(
>  				smu, SMU_GFXCLK, min_clk, max_clk);
> +
> +			if (ret)
> +				return ret;
> +
> +			min_clk = dpm_context->dpm_tables.uclk_table.min;
> +			max_clk = dpm_context->dpm_tables.uclk_table.max;
> +			ret = smu_v13_0_6_set_soft_freq_limited_range(
> +				smu, SMU_UCLK, min_clk, max_clk);
> +			if (ret)
> +				return ret;
> +			pstate_table->uclk_pstate.custom.max = 0;
>  		}
>  		break;
>  	case PP_OD_COMMIT_DPM_TABLE:
> @@ -1771,8 +1841,19 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
>  			min_clk = pstate_table->gfxclk_pstate.custom.min;
>  			max_clk = pstate_table->gfxclk_pstate.custom.max;
>  
> -			return smu_v13_0_6_set_soft_freq_limited_range(
> +			ret = smu_v13_0_6_set_soft_freq_limited_range(
>  				smu, SMU_GFXCLK, min_clk, max_clk);
> +
> +			if (ret)
> +				return ret;
> +
> +			if (!pstate_table->uclk_pstate.custom.max)
> +				return 0;
> +
> +			min_clk = pstate_table->uclk_pstate.curr.min;
> +			max_clk = pstate_table->uclk_pstate.custom.max;
> +			return smu_v13_0_6_set_soft_freq_limited_range(
> +				smu, SMU_UCLK, min_clk, max_clk);
>  		}
>  		break;
>  	default:
