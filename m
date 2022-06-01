Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2508C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 14:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 325F310E496;
	Wed,  1 Jun 2022 14:57:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2346D10E496
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 14:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoxwE3Dm4VJJaYHzmdGv6trutIRxXBWdSJF0HfP65RKUczsxANfJI5RqQlWpCaRDGsvRJJmMoH7U5othvlxjZBw9GqESnHuaaWt6xM4RBNFFtZmcTKQJvcCO8HEHFJffc422QCQWtL1sKyi5deTn6zp8Ux0mLUSUU15oAn1oHYHB8ZtqAhhp+yayXNEulC5Di6kJsumnLJYZ1zrS8PnCSB3n5wRzIoHHYnCzDfMPQGOmgiGAiIr7y1dyTm4GM3Z6cUAT4/r/EINKJlCZ0C7u2e2GYgq4nivGBdtBj4PafVASYiRTf4+bU0svuI+r/8N4hl2OprRLZ86Ta4voygYXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+vuVXBpJEHDrd6BflR63W4mNXMoyNh7Gpqx6wvMloA=;
 b=Km3l8brLGptYrgSvWB+O4a4vVCsQ8uA/FFqSpmIViu5WEC+IpWp4aXdAKNWYKzTj/PHr2KBBQ1R+An/E/y98eHpHg7TO3hk+YEqCREdbqJSBE/EhG9EP2lDDPd6zZJRpQCB8TjHblHtJUslHzbO2BSmjTYXbqlrWEhWx3FYDj4ES1XjYquuc9Xpy+wVA4/dJrM3UkrJZR/52E3q8iif4FwRzUPvpSin/tgqwDxRy18bAIbPBipOeFltUhdwJq8BTKOF48wKQsovsPW0tu55nUm6cy33DCUeQvZGzGuTNZNE+fZ9qs+bl6+8AJU6VZG/7gjkSxHtQ4eKprMh33/h8pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+vuVXBpJEHDrd6BflR63W4mNXMoyNh7Gpqx6wvMloA=;
 b=zAvoSvtFSIfeRGpQ4C654KLXHxEfvu6n7CNs1YXlFP+tQM6q4g/BYU5zsYbDBJ7Qi0W8POrU3y6Wrk4TQMfXeo9De3E4U1s4kbS0AOB+fuDiXT6XQiU3esMqTecXnob14Dk12GCszOMRp9ijK/BfBru4+PT4dnogDujKF1DJzKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BN9PR12MB5081.namprd12.prod.outlook.com (2603:10b6:408:132::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 14:57:11 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::f85e:63df:8fde:b620]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::f85e:63df:8fde:b620%5]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 14:57:11 +0000
Message-ID: <ff9cb55d-e492-18fd-2aa1-a7b72d03d273@amd.com>
Date: Wed, 1 Jun 2022 10:57:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/3] drm/amdgpu/swsmu: use new register offsets for
 smu_cmn.c
Content-Language: en-CA
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220526180027.3044740-1-alexander.deucher@amd.com>
 <20220526180027.3044740-3-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220526180027.3044740-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::6) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dc550a0-1afc-4f7d-3524-08da43df01d4
X-MS-TrafficTypeDiagnostic: BN9PR12MB5081:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5081A95FA37C5F032DDD086399DF9@BN9PR12MB5081.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Zgi5sJDua3yHfvZGueQkkIfG7N+DsfZItVNPpXPjOTWHWYUXTZgBsgWexVPsnIAGDd00CqYYDmG3SGXS5SjomDqhEQZyVM1u9fA51NM3SYwlj3psDIAVfUs94bmqjZyEKvnn2zU/PzPvRRoUKlvm13sKn5pFUaMuJPbtsqYrnv84p36DNn34jTrQSewNg7vP7dY77qaHYFs9tcJaoN1ScW3MKto9q//bGEPjKYPtCdyscT3XIW/Y8mwKJGBRLlCyuACIZVPHaj3t/ftO3jQttcuemVT7+xsb0JY1K2XX7EUry9m+KXQqvMQZBzfzs95J/5f3LTpk67fB/yplGxu4GiHkUy0nxh7Tka6NYmY4Plh1MwUqzGKImaIAezfZeWd6vhVlJDqtU8q0X05eCFu3W1sbwQVgQ1I0z7AoEgpX9l2M8EeZdrSdE4gdJIHOA8ll7mhIMM1OeDHa0Y1WdvxXNOn2GUrOcv/6LpHtsDrAq96YqZWvZBY3L17N1DADusc/rMbmJNLGEEAlWA62fVzEgKtq/NVISN6cQY8r21UjZGHexRB8aLTRWVgpIzdfITZ/tULRfVGVqVQZTX2khQb0h8iEv5+vg0y8CFAP6TJKBc3M6xZqzvZmWrMomMGhnOgKH1sj2RXfCxJt9FjnhqMR1SPOeZvVCAe1JOS06175S8vkEynkLwV5k+VS2D6D5sJXmcFcjgIv8Lx7mAyw0evcM2iDBrk6ixlJfWI2ltTrAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(31696002)(86362001)(2906002)(6666004)(26005)(6486002)(6512007)(83380400001)(316002)(6506007)(8676002)(508600001)(44832011)(5660300002)(31686004)(66946007)(36756003)(8936002)(2616005)(66476007)(66556008)(38100700002)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHNtVS94WmR0VVhkYXBUV0JpcmwycnhBaHlnTk9FZ3RYQnJkejg4anZ0NHVs?=
 =?utf-8?B?aFR4Y0E4eUlkMlVGWm9aeEVRd3lxcmtNUkJhNTZpKzB5NnI2N0J2QWREbkFD?=
 =?utf-8?B?bUZmZG9yNUVMOWxPL1gvY3lnR0xlV3RHQUlHMjR2K2tXamJRRUhQYnIvZXRq?=
 =?utf-8?B?ejUwNmZqaTFzWDloYS9mMXV1ampmSlJYSm96UGxJR25ScG1NbjBPbU5CZnBm?=
 =?utf-8?B?V0tBelhmYTFaTXNad2RxOHo1aU1DYjFSV2pzZTIza29OTC9XbExGTWtqN3p3?=
 =?utf-8?B?M1M5ZlI4cU0xSVUzbUtjRlJBYUFaallleTAycy9kYzd4Yk1WR1ovWk4xK0I4?=
 =?utf-8?B?eGhzTXBiZmNRSUFFWjVVY1E1MlhEQ1NXQkUrUkpNY0w5b1lIdm83WlVZKyt2?=
 =?utf-8?B?T1JENVVVSVk2cUdkRlNSaENsREZZTlJ1QWx4SmRsSldTV0RSV1RvSm90TmpJ?=
 =?utf-8?B?eEkxTUorK2Z1ZkRYNlRJRGl5Z0pMMzB4K0RHV0FBUHBoY0ZvSDArejZCMTAw?=
 =?utf-8?B?RzFyNTFXbVZkN1ZKMEdoU0JlNU1HQkVMOVFZYzdWa0pvWndZa3lRWklMaXBN?=
 =?utf-8?B?a0x6N3RuUk82ckg3dlVCWFoycHBpQW9iNzRCU0JsUFF4bXZXZ0NjaEpaQjRm?=
 =?utf-8?B?ODZlM1ZiSTNMbW1TVjNaQ3ExRHAwNHpYZFJDSE5uTXBXMHpYa3VERytiaUY1?=
 =?utf-8?B?UU9iNnUwQllRK21taFltQWsrNTlvZFh0Q09WbUtUWHlMVS9GbHJia1hSYko0?=
 =?utf-8?B?ckp2ZDdrM1ViK0VIVGcxYTVjUzVndzNvdnVVRXZKM2pGR2JpRnRaSHBrT05n?=
 =?utf-8?B?RkpZeStCdXVYRUJrNnBxanNYV1E1Q0UrYWFmN21WeS82TmZsV0hyU0JJckw4?=
 =?utf-8?B?ZG9JTmlJNTlLclh0Ly9BcHhjOStCVjFwWG5RUGNiVmE2bDd1OXhLS3dxYXgx?=
 =?utf-8?B?ZDRUT0s2aFJEb3BRa1RYMGJaVFRmUE1nQzVtOW44N2R4ZW1heGFaMFVSNUt6?=
 =?utf-8?B?Y1NNbyttUG1uTGMrZGhScnpsSWt3RUJPY2svcE1SelVYL2ovOUJQYjVneGc5?=
 =?utf-8?B?ZlVtWnNRV2V1YkRYNzhlU0x2eFRXSHovcG9aMmJiQldSYm1YZDY3V2RqRUhW?=
 =?utf-8?B?cG1rZENteDZpblEzOEVjZFg1aTdlSFVnUTM5SkZHOGp3THVNUjBRWVBLVWFl?=
 =?utf-8?B?QVJnOWJyS2ZtTlVwclIvUHZlRVZVZ0I1VGJjYnpBdlN3RVhNUVk4RDdUVDI4?=
 =?utf-8?B?YWVYWURjUEZFOEdNQnRDQnRKSTB1TUtQUTNKZWdFQVdNbGJmS0UwZkhJOWY5?=
 =?utf-8?B?b0JPY21OVlZXd0Q4c1lNc3ZTdW96S0JFVUtkd2hEeXRvWHdLZWpHMW9uWnNi?=
 =?utf-8?B?cmVFT3BoMTVkZ3c1WDhzcVZEWVlrRVZ0Zk9KV3V6VkVucklab3VRa1lKdS9j?=
 =?utf-8?B?VlZIRFdNTVJYVVV5WkwxelNqYjVuRG9QTUYycnZYZHB3NUlEUVFDTUJhQWpP?=
 =?utf-8?B?NU95ZzF5akMwYkhlTGVqQUQxdmhCQ3gwUi9Wb1NuQ1ZkcmgyMFJjWFF4dDRD?=
 =?utf-8?B?TUlPOTZ1am1oTXdDaWhxSWJ5SlpNWWxLRFhvSmhpN0FIVVVJUk0rS2grNnNi?=
 =?utf-8?B?NW1PL09zdDlaVkZZdUVaZ1JFU3RML2pUWUZDSjNaWklBQWFRMEs0UDdRSEVu?=
 =?utf-8?B?L3RiUlhXNHk1cGc4NTlEVGpQOGhCSVNjR2JCaXdqYVg1dW0rb0l3WEsrUEZR?=
 =?utf-8?B?WEVsTVAvaDlFV2h4RGh0VEkwdzdRdG9OYVZLRndLZXhYT2Z2eTFQMmlPYVc4?=
 =?utf-8?B?ek40Zi83R0xmUTBkS3dWdjhic0tYd2JZcDgzbXlqbGJ4MDdJQWloV3FWMEx3?=
 =?utf-8?B?R1hDSGNOSHpTcm5SbkhjeFFiVlZ3c2V5ekdlbUI5U3hVcVY4TWJnckRnNElx?=
 =?utf-8?B?anRKSUhYcG9HNzQ4SWpJbmVXbnlFMWo5bTZCdm5YcVUyUnZUbzRNaitCKzJM?=
 =?utf-8?B?YUVqN2duNUhBdFkvV0JqY0RhSjFUN0ZtaW9HVjJJbnpEZjQycXZvS0NJcWs4?=
 =?utf-8?B?Sk9qaGYyT2lBV1FhRWpyditvNU9nQmNDNlYySFZYWjZiVVY4SFUzeVV0Nk1n?=
 =?utf-8?B?Z2ZhSlhHK0pNOHZOYU9yRDR3bjhXbU5OQnc1Y3RGdWYrMWNGV2F2VTBWT0d0?=
 =?utf-8?B?Vk12bnFlNC9XQWFTR1VzM3BDUGU3ZmZvWTJIcFNhNjJtczVaSlovcTJJZjJ0?=
 =?utf-8?B?K25WS1NUWFVLMEF3MVEwMGc3VnZxckI5NUhjSXJ2NDNDd1hYTEcrcUk4d0wr?=
 =?utf-8?B?M3hmbG5ibjllb3ZPWmxrcVJLMnpTVFJLQmR3bFZLNExCMmFhTUxHdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc550a0-1afc-4f7d-3524-08da43df01d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 14:57:11.5361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/eSbgrpqus6TTyUNlR1QVOgT9r2FL7kOBVBhXvHbnOpu3x9Wy4o4vOYY1My0g7t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5081
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

Yes, this is a good change--abstracting the SMU messaging registers for ASICs.

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2022-05-26 14:00, Alex Deucher wrote:
> Use the per asic offsets so the we don't have to have
> asic specific logic in the common code.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 77 +++-----------------------
>  1 file changed, 7 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 5215ead4978f..53cd62ccab5d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -37,40 +37,6 @@
>  #undef pr_info
>  #undef pr_debug
>  
> -/*
> - * Although these are defined in each ASIC's specific header file.
> - * They share the same definitions and values. That makes common
> - * APIs for SMC messages issuing for all ASICs possible.
> - */
> -#define mmMP1_SMN_C2PMSG_66                                                                            0x0282
> -#define mmMP1_SMN_C2PMSG_66_BASE_IDX                                                                   0
> -
> -#define mmMP1_SMN_C2PMSG_82                                                                            0x0292
> -#define mmMP1_SMN_C2PMSG_82_BASE_IDX                                                                   0
> -
> -#define mmMP1_SMN_C2PMSG_90                                                                            0x029a
> -#define mmMP1_SMN_C2PMSG_90_BASE_IDX                                                                   0
> -
> -#define mmMP1_SMN_C2PMSG_66_V13_0_4			0x0282
> -#define mmMP1_SMN_C2PMSG_66_V13_0_4_BASE_IDX            1
> -
> -#define mmMP1_SMN_C2PMSG_82_V13_0_4			0x0292
> -#define mmMP1_SMN_C2PMSG_82_V13_0_4_BASE_IDX            1
> -
> -#define mmMP1_SMN_C2PMSG_90_V13_0_4			0x029a
> -#define mmMP1_SMN_C2PMSG_90_V13_0_4_BASE_IDX		1
> -
> -/* SMU 13.0.5 has its specific mailbox messaging registers */
> -
> -#define mmMP1_C2PMSG_2                                                                            (0xbee142 + 0xb00000 / 4)
> -#define mmMP1_C2PMSG_2_BASE_IDX                                                                   0
> -
> -#define mmMP1_C2PMSG_34                                                                           (0xbee262 + 0xb00000 / 4)
> -#define mmMP1_C2PMSG_34_BASE_IDX                                                                   0
> -
> -#define mmMP1_C2PMSG_33                                                                                (0xbee261 + 0xb00000 / 4)
> -#define mmMP1_C2PMSG_33_BASE_IDX                                                                   0
> -
>  #define MP1_C2PMSG_90__CONTENT_MASK                                                                    0xFFFFFFFFL
>  
>  #undef __SMU_DUMMY_MAP
> @@ -99,12 +65,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,
>  {
>  	struct amdgpu_device *adev = smu->adev;
>  
> -	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5))
> -		*arg = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34);
> -	else if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 4))
> -		*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82_V13_0_4);
> -	else
> -		*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
> +	*arg = RREG32(smu->param_reg);
>  }
>  
>  /* Redefine the SMU error codes here.
> @@ -150,12 +111,7 @@ static u32 __smu_cmn_poll_stat(struct smu_context *smu)
>  	u32 reg;
>  
>  	for ( ; timeout > 0; timeout--) {
> -		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5))
> -			reg = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_33);
> -		else if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 4))
> -			reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90_V13_0_4);
> -		else
> -			reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
> +		reg = RREG32(smu->resp_reg);
>  		if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
>  			break;
>  
> @@ -177,16 +133,8 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
>  
>  	switch (reg_c2pmsg_90) {
>  	case SMU_RESP_NONE: {
> -		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5)) {
> -			msg_idx = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_2);
> -			prm     = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34);
> -		} else if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 4)) {
> -			msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66_V13_0_4);
> -			prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82_V13_0_4);
> -		} else {
> -			msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
> -			prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
> -		}
> +		msg_idx = RREG32(smu->msg_reg);
> +		prm     = RREG32(smu->param_reg);
>  		dev_err_ratelimited(adev->dev,
>  				    "SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
>  				    msg_idx, prm);
> @@ -280,20 +228,9 @@ static void __smu_cmn_send_msg(struct smu_context *smu,
>  {
>  	struct amdgpu_device *adev = smu->adev;
>  
> -	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5)) {
> -		WREG32_SOC15(MP1, 0, mmMP1_C2PMSG_33, 0);
> -		WREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34, param);
> -		WREG32_SOC15(MP1, 0, mmMP1_C2PMSG_2, msg);
> -	} else if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 4)) {
> -		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90_V13_0_4, 0);
> -		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82_V13_0_4, param);
> -		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66_V13_0_4, msg);
> -	} else {
> -		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
> -		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
> -		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
> -	}
> -
> +	WREG32(smu->resp_reg, 0);
> +	WREG32(smu->param_reg, param);
> +	WREG32(smu->msg_reg, msg);
>  }
>  
>  /**

Regards,
-- 
Luben
