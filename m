Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B41DC7EE25
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 07:35:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF5510E63A;
	Fri,  9 Jun 2023 07:35:18 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31E5C10E63A
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 07:35:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwSMIUmQKNQbz2R/6w1MyOxGI5vKdQYh+WBSK2N2VxQIBS5AIT8QUdobwxUe8JNUPZi2BGb0hZE+f6BV4MU5UBD6AuD0A+KwTFlSRA5D8wtfV3TYjbrP8D69GLRXpp4e44ABR/9QjslkOAc7Z1y9QfoGPnan2BceuB/KVEDutWF1KUsXs/NLQeR1sKXpTiJvcu66y1b56mg2eleutbXTDBQqIXJW5q1sQm+KYExKGv25zyfcn3mipRc7Fm4+j5dzx5PimX/zyF3ocxwVcOZEvffqmjt/j9hYTZv8YLVdv5moMId3AKlPprt6lVkSlFDHZDwipCE66apCvOc00hYUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nugVt/u53dvpZlyDEwFzCs6pUensEB20xNVSH+x5tLs=;
 b=QlLJMaYKd2nUCgRTco5WpXr8mnfH190iYOEkhU+WB1duuPdlyurJhf/GoLytCRlbtrYObr/E61KAjVOT6lVJwJc05ZQSHtnK/SPQqhYaoMYgLELb2uEf2Dm45ad8QYfUa1NPLEEK/kpZ4KSISIPYqusdUzHiNyNdRxPnTUpgbCkssUX4plqtBhZUPah7aobgYi4fBHWrBs51Vbiei43AeddDENhBCsgISqd/2UDlkgh8qdB+IVyCaI2+e1RHJq3wUGzKT9DMBkVMklH+3kTgKdv8HDUrbU3mVW56ZuLIyWq+v8R+CE7O9m3q0t4lJklKqN3UB1tB1JTUjh3ogoIURQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nugVt/u53dvpZlyDEwFzCs6pUensEB20xNVSH+x5tLs=;
 b=LknufdiEpdcBpIK6iymMRWCHyN1Xyh1ohrybSlh2fgebUaYGC90Fj25JK8qDDCXCNc1ZAoTxWIOwmjNJgg6CW0IKwjAIQRpkDl95IIGWsyk/S/kH9HyFWP9a3tjv7WcH6t36YRxcVLqO7/qsOgsWc8y1hwY9vnYxnlIbteS9xMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Fri, 9 Jun
 2023 07:35:11 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0%4]) with mapi id 15.20.6477.016; Fri, 9 Jun 2023
 07:35:10 +0000
Message-ID: <52ef34a0-43f2-13d0-f665-df0a2466dcb3@amd.com>
Date: Fri, 9 Jun 2023 13:04:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] drm/amd/pm: workaround for compute workload type on
 some skus
Content-Language: en-US
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230609063834.4184499-1-kenneth.feng@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230609063834.4184499-1-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::12) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bbe5cc7-99d7-4797-a798-08db68bc0d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCz4q58GN/SwOL/DYuCnvk4mFQ+L0nvZVxBItiRZSZnbWLXtZTzNvwruInpxIqOPu+E1uhHeeSAXU7WNf/o3TAZkIQZpKZ+8+Mf9+ipC3da6xdAOem4rcpJC21NzCsBUAWGCUlDncUxFuyrb7Hz3t3tYubb6AGCmDWw8K6EEIeYG1GRKYQkgYYXXS5sA+Q3ttVhLqWkM/6DBak4Ad1J1PlWEdqRUbc2icvKibWk+sxnpPQjxmahoSuk/jx71+TsulEIkXKTwgqyud7RILh2KfYMdsd19SEYmP9e/f+0MWOxa9cTm45vA66GvNfZ90AXV728HO7BAvddXkGdBPOFhuI1RwzIwA1z/VAa2YAX9fJsfcoF3Q61KvqPuht+A3zlLVBmWLJePtfA8hIlH7uGl/33PgNsEekPYPtRj0g/LyKFL3Oyv8/G5lXt5to/FjhSwe9u9yuULHiuloKIuQ6tde9WzUHRGF49y88Txm56802sk+Rg1X2vlLRor48lpq9s73vvYBNxK0GbBwob+CvTdkKB2pGqpeugEUD9Pvrd8gu4N0X8oR6AIlTzFpb86tRd+Mz/k/54EcU36B9E9UbpG+yyBllMyGqU8QAf0vCYvRIs1eoPpmh775yygRNY6g0B0rUy0kM3PXKTp1qOhDPBrnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199021)(478600001)(2616005)(41300700001)(31696002)(86362001)(83380400001)(26005)(2906002)(6506007)(6512007)(53546011)(31686004)(186003)(5660300002)(6666004)(8936002)(8676002)(36756003)(38100700002)(66946007)(316002)(6486002)(66476007)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZCt4eE1UV2I1Z2t3ZGVkTWd2U1JCdWF3bmRmOXJCRWkzRXhsOExOMHFVV2F4?=
 =?utf-8?B?MHlubUNxVHRXb2EwSW1aem1qMDVrM2IydXFCTFd5WGMzeTJvenVrNzV6NHVB?=
 =?utf-8?B?WDh6cnY2bEQrWkFsOU12ZHVidUdqT0NFNzk5SlJsT2I1OXI0SHArWVNsVWVa?=
 =?utf-8?B?ZG9FMmVIdXl5TG80QlRBWWRYZTgwZTZIZkI5c0F6ZWp1VDRLS0NoUVFWMmRG?=
 =?utf-8?B?Q28xQkUxMVdmWjhyRCtFbmVtUUZ1T01weHdqK05TS2NUZTZmd0RWQUpKWWNU?=
 =?utf-8?B?WFVMS3NqbGRyNFp4cnhzRTI2ZkN2a0ZNK0MwR2w5QUFOOXVGS3hOOWp4WFNR?=
 =?utf-8?B?SDVDYzN0NkIxbzd2N2MwYWxwSmx2MmtWekFEMHIzVjIxa1kyV3VIYnZuMFFM?=
 =?utf-8?B?aDBNNlZkVlZuVXZYVENvNy85WDlNeERjWW5VTVdhL25aOGFPdFJiTmtQN0d2?=
 =?utf-8?B?MFRhZG1VU0ZuNklDSG1IQWNMNXZ2eHhCU1l0d3phOGdnVnU3OG5JaEc4WVMr?=
 =?utf-8?B?OUREaGVGci9YWFl6cjliSXNGK1U5V1VQQTdJUW1VdGNxTG1NUlcwZXovZXRX?=
 =?utf-8?B?aU5aU2tBb3VBQi9YdDc0UU5nMVFXek1WczdjWTdFeksxdjVFdTEycUE3bkt3?=
 =?utf-8?B?S1dCRGtHbys1MzRsQWREYjZsSFFMaXpacVZpeXpQR2FlRERnY0lBTWVmR1hN?=
 =?utf-8?B?WlJSSVpTcXpyYms1NnFXZmtWTWgybVVPaGtmMHo0Z0F0RS9xUWNMTW8zQjhY?=
 =?utf-8?B?NW8wcDVFR2x5OUpxc1BNQUp6M2thdG1rQUx5RkMrWkE0OUlVaDREOGk1S2M4?=
 =?utf-8?B?YklZcThQVjZ3aGhyZEJXWXR0RGROaHBOVUxkY2RyMWpzc1dYQ0cxS2x2ZVF6?=
 =?utf-8?B?NzA5T3d4SnJJNjZjdlcrN1luZTVkczVQamFZWjBrSzB0NlpQZFk0VXk4ZHBL?=
 =?utf-8?B?Mk5Sb2ZSSkJmT2lPV2NhV3czTFBpTitVSldlY0hpMmxJYlBuMXlvMm4yVCtD?=
 =?utf-8?B?UTFxNWlodWNTVG5mWW1uK3dFQnFCVnZqV2dqa3ZDNVRtUEdRd0cyL3FDQ25G?=
 =?utf-8?B?Mmc3YWl0SkhyQlF2cStrYmIvb0NHYkQ3L2U2THVETm1sYjVSSTVkczIvUGJi?=
 =?utf-8?B?K0d3NlJBK0Q0aU5rdXI4cWxuRzAremRFUkJDc3hrc1hwRGtNTUdqcTdvS3k2?=
 =?utf-8?B?Y3hGbVdxbkpzUjJucDNWTUJFeGw2OEhUMThweXdLNWhEZHY0WTJ4aTFyWEQ2?=
 =?utf-8?B?SjVINUVpSEM1MStCYTUvYUJpeUVBMForM3pvS0lXSTA2Q3lDaDFJZTN3dmtW?=
 =?utf-8?B?djFoVDBJS2lRU1RCY0ovdU9RckllN1pESi92N251RXpRMDl5bHNrWmJvaFAv?=
 =?utf-8?B?Y2Y1QW1Hd3VkMi84ekYvK3g3NDBHQmd4SXNwdkg2TGZVdWo2NUlDNGZDRGJt?=
 =?utf-8?B?U0JlUWZDeFVCTVNBb2E5bjhTT1pwQXNvcGJTdEd1RlpTaGZHTWNSQ3Fyamls?=
 =?utf-8?B?MU5TNVd0bTJGUGVXd2t2dEhMZzVLTEZ6Z1l3MHZVaUN3NmNRRFIvSzJSVnox?=
 =?utf-8?B?dFhDeWJsUXpxNTVuR0dvZktxQ2FhTGdPWFVpWEdKdVJPYWhmWmRkUzBpL0Jv?=
 =?utf-8?B?ZjN4REpkZjE3VzUyaytqaGdpTDV4ejNPWmdkTTg3cW9DWTNvRG1rSW1reE9j?=
 =?utf-8?B?d1VTYUExbTJlSE1lamNKUDV2VTJIeExHRXJUbTBsRk1hT3pISG5mbmJ2VVpF?=
 =?utf-8?B?MlFFWVl5Z05HZjVSWFpYZ29HL2Vwd0E1aWNCYlNabTVWMlZpNDR2YmplMFNm?=
 =?utf-8?B?eDZLZG1QaUJEbnNXZVlFdEYwRHRQNTM3RkRkYjVzNGM4S0lvdTY2QS9jbW5P?=
 =?utf-8?B?Tmh3bEUyS3NDMVdoMVlRRFdUZWV1UkVuNnNETndvMVVLKy91VElhQmgzYW5E?=
 =?utf-8?B?Slpna3VSQmNJdWUxU2N6MkM1dzlPeitKaEtab1dKWTVLWnhrR29sc1RCY2F2?=
 =?utf-8?B?KzVCOVE0TnJPZWVqRHI0Q1hjN0g0a2UyUWc3alk0RGgwVXFrZEdiZmpsb0tF?=
 =?utf-8?B?WTBkQVViNUdWb0V4eHFyMS9RbGVLdFdzcTBHcDZCUEQ1UG9YT1cwMzYrMUxi?=
 =?utf-8?Q?7IH9VSqv266n+BYmYxcyBnADo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbe5cc7-99d7-4797-a798-08db68bc0d92
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 07:35:09.8017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9x/WQ37VUx5aYAlyQ0RZvBmVA7ezl5maqP1H0VxJOmVYSwEjapK8iSCgOtpZGXM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
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



On 6/9/2023 12:08 PM, Kenneth Feng wrote:
> On smu 13.0.0, the compute workload type cannot be set on all the skus
> due to some other problems. This workaround is to make sure compute workload type
> can also run on some specific skus.
> 
> v2: keep the variable consistent
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

Acked-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 33 +++++++++++++++++--
>   1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index e2265f50bacc..5e9e507a710e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2179,10 +2179,39 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>   		}
>   	}
>   
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type = smu_cmn_to_asic_specific_index(smu,
> +	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE &&
> +		(((smu->adev->pdev->device == 0x744C) && (smu->adev->pdev->revision == 0xC8)) ||
> +		((smu->adev->pdev->device == 0x744C) && (smu->adev->pdev->revision == 0xCC)))) {
> +		ret = smu_cmn_update_table(smu,
> +					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> +					   WORKLOAD_PPLIB_COMPUTE_BIT,
> +					   (void *)(&activity_monitor_external),
> +					   false);
> +		if (ret) {
> +			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> +			return ret;
> +		}
> +
> +		ret = smu_cmn_update_table(smu,
> +					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> +					   WORKLOAD_PPLIB_CUSTOM_BIT,
> +					   (void *)(&activity_monitor_external),
> +					   true);
> +		if (ret) {
> +			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> +			return ret;
> +		}
> +
> +		workload_type = smu_cmn_to_asic_specific_index(smu,
> +						       CMN2ASIC_MAPPING_WORKLOAD,
> +						       PP_SMC_POWER_PROFILE_CUSTOM);
> +	} else {
> +		/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> +		workload_type = smu_cmn_to_asic_specific_index(smu,
>   						       CMN2ASIC_MAPPING_WORKLOAD,
>   						       smu->power_profile_mode);
> +	}
> +
>   	if (workload_type < 0)
>   		return -EINVAL;
>   
