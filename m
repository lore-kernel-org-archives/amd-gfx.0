Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC30C8300C
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 04:29:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E66710E0DC;
	Fri,  9 Jun 2023 04:29:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CB7310E0DC
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 04:29:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHyXYW/3hH6FPkt6BA33ekeTYIEg5hUF4opiFDuMBIUTWskqUsTTgykgFvfkEy/8H5SLw/O2dLd0whXdtCE6kGmbeMzQaSf5XXvnsUVLWlDwp045Rzdx5ZEMWE9pZ0xX1rSNKksFgjaMn9pGbCFYUghRqEuPMtezEZJJBGlckLX25iAjkmKD7Ow3djWotFjzvN2bfl/ptzd77crwNCX8rHATSlTpRoZsWtaQtgQfvpvD1WG/72j5i8OsKDuOhFuqHu8wHj93vfEbv6sN3DSKCqwNrLJ1NYq10Ds/K6QJheFTc6K6H3PyMEOgbY/jz0AlWz5RXOdyQXzEgxuKOFKgVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MjO8zsPuRoAwGTaYB1L2kdL9H5liyF2icZFOpBq5zc=;
 b=WTCcrvdn9p+DxQxv1syY35P5rSE8BBhG95Uw9umqMIzZSMUVO8l4wGMlBNCCdA4hYWiXCZ6o7Ugg6zd1rLD6gwA1lXbzRS8qyBO7JFSaWph6/bN8m2ODUVKOqj7+LAq/OiiaUWvEw+nAO4fVAhGYkNMpCl1UlLCZiCXG7D1i73nCN8zq2VXJ4j80Ipgs+6JBdjzQL22kK7J/qdGNbIYUvOS3WtMV5uVXo+L7pO3JlMoQb8Tw55vrgGee6o7+sOjWlYppxchw189sBPKB+v5D65tKgpSjVU0Iq5RXkG1AqIhjKAPzMN1nxBxm/TBen/LhHZOm5r0AXV2HyDjUr1bTvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MjO8zsPuRoAwGTaYB1L2kdL9H5liyF2icZFOpBq5zc=;
 b=Lh2pw8ZgHLfLZFAfXt8FB3hjHlycau6AEHnMoJpB7VWPtaK5kao6HzQ7oBmY2vVMhN3rKr5xba+JirjysMVCdhQvEqVujVu41f63mhtvsKrJXSs9/b6VlYKEQfyIexOP+qT0gVhUoabh5MjMh78lJo8kdNUChd9BkQ5Zr7/Qf3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 04:29:48 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0%4]) with mapi id 15.20.6477.016; Fri, 9 Jun 2023
 04:29:48 +0000
Message-ID: <adca14a6-722a-8013-22fb-eaf51ba88d7f@amd.com>
Date: Fri, 9 Jun 2023 09:59:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amd/pm: workaround for compute workload type on some
 skus
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20230609025544.4179487-1-kenneth.feng@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230609025544.4179487-1-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::15) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 51dc3548-dd64-448a-c9c5-08db68a22871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xJ6Rr5M+qCbJ9dG9bYl9VUAmFi1eLpYmne9y52NTibDJjBiPd8xSb62hy19dsQMyfTbsvQOjjTDHMIUQDZjgBbrIupJ3wIZzxpeOAGkRdcVsPdESiGz5ge9f4qodSb6w+Vre6Ae7HBN2dp5KOtQWfOkqxHCoFg8DOvSKh2iXtCcGwAqShknM7/YtVI6oxLekSvcGtxH/iFT2I8dAtJZrwy8HRHniChR1SzD4puXoPJGbN6YP0q6dklhEG8RlXTzTlFWJjJCtDLEKDI1JB/VGuDL8IjGSxGshxRhziVPSmAVTFQbhVV+aOMoBTtID8CUBqcQ2Qxg98vDlS5uiGmYyR4fXPeOJgQegwaeeBLMH4dUJPwy+sp/0BAmWERlhJOLk6uWs8tylOgxul37La2UHa551msxE4zT74DulZWU4rarHAZLmxPxzxbDoqXfyJsbsgG4/qMSkTNjjErUxCyueNlUYyYu5kBPsJCOlFKgFxJaHYMXe7CwfMOErpPH1GM2wV7SHm6EnmlNb7GvIq/7GToeVUvCTQKohjhNXPZh/jR1GQjnDNe/rENAEF2ShYUCbYaNmvz2VU85vihvcTPsSW2rEeIaPl8WJ3fV+FMv8nZZiji9zIsbCALe35W2qXEyT5hk+RhYp4nzih01QD2/BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199021)(8676002)(2906002)(31686004)(5660300002)(8936002)(41300700001)(316002)(66476007)(6916009)(66946007)(66556008)(478600001)(36756003)(6486002)(6666004)(53546011)(186003)(31696002)(86362001)(83380400001)(2616005)(6512007)(26005)(6506007)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QllsbjgybUp4ZG9uT2VJaUNmcVJBRXlwMzJCc3kwaGY3U3QrbUpjRDR1MTMy?=
 =?utf-8?B?TEhGcHdFWHU3Ry9mQWQ2dmdmbVVRenJYTDZ1T1JaM2d5QUtzUlB3RFo1clZP?=
 =?utf-8?B?NTNWSFFjTmpveFVSbjQ1VGxyazF1VzFITW1JYjNxbnkxYnZJVGpuUjZ3eWsr?=
 =?utf-8?B?Y1NmSU1KUVF0SG1DaVorT3duck8vdEdaSitKNlVCWGxWR0pWQ25PWWdYWG41?=
 =?utf-8?B?bVRYa3cwSWZ1bElkUU1QVGtUY3VZeUpENGFOK3p0NHlVS1kvSzJtb3Jzamts?=
 =?utf-8?B?c3RQRUNENFhuUGRVUXM3LzM1VVAzSUl6dU4rNkNSYWE3UjF2cFdDTEhmTlRr?=
 =?utf-8?B?ZlU0Y3k3WUQ5cFRhNEFnUW1aNlhkbk8ydU44cEdMdnpLMnZrc3N5aFRpbFVP?=
 =?utf-8?B?TTVvM01BUXVyWm85RWZoMWNVbHZCWjlubW9ERUpua2pGa2o2WENWbW1KWE9O?=
 =?utf-8?B?UUs5MGNnSmhybVpmNnRyMXhhOVo0OGRRUXBKMTJmUjlORDJqNC9TSS9JdFBo?=
 =?utf-8?B?OG1pVlFDNDBQZ0QrVXVvaEE2eVdJMzY0amZFeDIrL2llQjlTeEdIWjQyVEZX?=
 =?utf-8?B?S0NDVk00NlpkYjNBNUhRdWNxQ3p3SkVtRmRPM09LeFVnczcrckp2VDMreUlq?=
 =?utf-8?B?Tm9laTFZVDVma1lMeFBXR08rY0xXb29kU3FuSkRMQ1RwKzZiN2NtSGNQcnFN?=
 =?utf-8?B?RGhORDJFd3luUkxsczc0T3Q0Q2NSY3hWUVF4NjFtcDNnaGV1KzBVZlhDZUU1?=
 =?utf-8?B?aTZhcnBYY0xqcmpyUjhlVVJlTkVjcTN0ZTR5dFdoMGZrSlhEbHdybDdndXEz?=
 =?utf-8?B?T0dMcXU2eGJKRWxkdWZKemRmM05DU3Fnd3FIRUNrOUxpUDdVNDllbDBqTnNh?=
 =?utf-8?B?ZXo1dktWRFhadG9qU1NoQU9uT0wwUVQxek9xckxkZnVScy9pZ3E2MG5UMzQy?=
 =?utf-8?B?cmRJUmx4eTR0ZXpRV24rUWVDM1I4RDdmZXRmMTZwMkUrbjYvckpKVStNQWky?=
 =?utf-8?B?d3J6bE1FRGc4QXllT0ZnL0Y1clJ6Y2lUUXhGOTlBMGNDdEpvSzN0TGFhRXZJ?=
 =?utf-8?B?eStCNjd0K3Zjc1lJWVNkcmRTOWtNK1VGK2VzN3p6SHBsYi81U29MMEkzQWl5?=
 =?utf-8?B?UDNzMDdKaVFQSlFWMW5oWGk5MStPYmFQMEtGYVRkRGFaVjh3ZmNjL2RCZ3Qy?=
 =?utf-8?B?dnh4TDk4TVZWdjlhc1llN0RzcmI0WHZmZHJyaVhZenluc0dYVDJJZkwra1la?=
 =?utf-8?B?bEdwaG12OWs3TExwZmt4YmNLN0R0aFVnL2U2R3hUVGJ3NGNSa3YyK2Z5MWNN?=
 =?utf-8?B?RDVEb1ZFQTBxSzRGWktKVjlDR2xlb3lzczVSTjNyRmZFYW1sRmZTcERhUEpO?=
 =?utf-8?B?MGdzeHhDYzE2K3IzYnJ6c1U3SndpTGMzV29DN3I4QWM2UmZGT2lxUHFpcDNY?=
 =?utf-8?B?LzFoK3B5Mitkb1FSdXVCQUZWWTNvY3lKTWYrVyszeEg0S0kvdmRiZUhYeGZJ?=
 =?utf-8?B?RjZuNVU5RER5Unhsb0V0Uk9nd05ONXBxRUZmRzh6NXZwbmNpZ3B4eGxVNFAz?=
 =?utf-8?B?TlZKdVRXOXhQV1pibVJjd1A2VmY0elZNZHpGUXZ3Yi9ZU2JrS2tUTFNtM1Iw?=
 =?utf-8?B?VUY3dWcrb2JWRmdtbmFTOHFTUzZ6Y0h6dGx5eDZ4Y2VoY1BPOU5EckV0MHll?=
 =?utf-8?B?eVMzb2xSdndrclFtZEpTd0hVWFlWbnRmU0xucERKdWp6eG94QUFvZ2xYYThF?=
 =?utf-8?B?Y0xLRDdmR2JVc2U1a0J1ZCtQTy9uUWxHSkxWeXYvWXhPYXg5aHhSbGNLVEt4?=
 =?utf-8?B?Sk1KbEpidm5oSmhKbC84ZmxpdHc3eS84MUpxRDhLT0lNeVFyTkg4NW0xdVV5?=
 =?utf-8?B?YlF3aFNPSjNkcGxLVEFaUWRDVzllN1V5TS9iV0V2RmVMQkE4Q2dDRkhyQlVY?=
 =?utf-8?B?MGxxd0VQQm5tbC9YMXpLbnRFSXFRUVNtcnU4S2MxQzVxSDFJOTNlckJLR2tw?=
 =?utf-8?B?d0dvT0hHaThFN3kwRHY2SENxSTBLT2dzR1ErN3ZOSTkwYlNlT3A0UUExZmNM?=
 =?utf-8?B?OFV1UndGNVBpbE43cmZBSjd6clVOV0lFdVBTbHgyUndVQjlSS2o4TktIdlll?=
 =?utf-8?Q?J+FGXJw2Z9iPZLCELpztInGmr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51dc3548-dd64-448a-c9c5-08db68a22871
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 04:29:47.9297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBHwFHNoybUq0DBvU5u26tk//mIhwmIqiM35UoCRbLU6rSL9pXKW6wk/UYro6dKN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
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



On 6/9/2023 8:25 AM, Kenneth Feng wrote:
> On smu 13.0.0, the compute workload type cannot be set on all the skus
> due to some other problems. This workaround is to make sure compute workload type
> can also run on some specific skus.
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 26 +++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index e2265f50bacc..6e8acd021ee6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2179,6 +2179,32 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>   		}
>   	}
>   
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
> +		smu->power_profile_mode = PP_SMC_POWER_PROFILE_CUSTOM;

Though custom profile is used to set compute profile as a workaround, 
shouldn't this be set to COMPUTE to indicate that the current profile 
set is COMPUTE?

Thanks,
Lijo
> +	}
> +
>   	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>   	workload_type = smu_cmn_to_asic_specific_index(smu,
>   						       CMN2ASIC_MAPPING_WORKLOAD,
