Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C605C531D0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 15:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 106D710E46D;
	Mon, 27 Jul 2026 15:41:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="exw+zQD9";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013027.outbound.protection.outlook.com
 [40.93.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D9110E46D
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 15:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEVyR2ZXGGtmtJyBRKdoRV0c9y+v31CmbMN90jPtBZB1hVhjEWULiipTjd2faC7YBgt8QCOJn341jJCX3einXkTIPcNTHASjiH8U3CePMvEfsW9jw5keILxp9IpP4qmcWkhNUlB0s92pTbatTrUGCyvpChXVnDW3lsxs1VGM4JutYQGyNMTntYcL9k+KxAaxVq/LVh4p++D9uAgXSsz0R7adfuUGb4u9/eJTO9igTELgamZB0JKbPXaHC4CQZbeUlWiD13AwEe5indbRquS9PIKg2jcYoo8bbGbt+f38r8jg3GK+U8tqrPJPe/PVjxANfQfSiPKIO1hcZ/B1ZfnlzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hR3a1TJQYvTYMPqCgVaWt/rRy08dHGDde60GFBadok4=;
 b=CRJS3oiWdHmLZGjntC3a+0QUs4EZ9lgzIMfPMv/0M1dON9d2fjvtnKfYWqLjYFi6fWp6xuPbnZ7iT12prIScDi06sIk9hIV2E1swuSvBTpzywyFDzm2PbBK9sezZEvkKUMsOZnIg+33u7WIAOmgEcYNmJsgTmcovIDZO2Z3prfoTAHuux/h7cGPB1wYM/CQ/7ZE8Y03mP0KzSOhtRe8SfgIZsdcd28DnFGISUDJWhJjmQO5E7Og3nxiQ9Q8I23Yk/qV6qmmS4vGF49UmFK3ekRMGGKnkiq0GRwNr64yFXJ0dwMDeWG17/RR0V6Puc8y2CGqlkGTzQRMP0ArwbvdmKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR3a1TJQYvTYMPqCgVaWt/rRy08dHGDde60GFBadok4=;
 b=exw+zQD9k1LpXT5fJCPS2rCWNv5RUjOFQwRClJ7tiwuTg+tr6uSYbCgNpXsw1FCo/qc9Rl+DMpT446eWj9MCfyV/8d1xMuOfoHlaoo51iP56CizThvsWitT8AuvpDsVGgscezEbRJlxmGTmYGiAY8t3ZTp6DoAjOAzMINmZEnnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 15:41:23 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 15:41:22 +0000
Message-ID: <fbdc607a-5213-4dd6-bb14-0b5f7f6bebe8@amd.com>
Date: Mon, 27 Jul 2026 21:11:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/2] drm/amd/pm/smu15: switch SMU v15.0.0 to DRAM-based
 accumulator metrics
To: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>,
 Alexander.Deucher@amd.com, Pratik.Vishwakarma@amd.com,
 Christian.Koenig@amd.com, amd-gfx@lists.freedesktop.org
Cc: Veerabadhran.Gopalakrishnan@amd.com, Suresh.Guttula@amd.com,
 Kanala.RamalingeswaraReddy@amd.com
References: <20260727153720.4111771-1-Shubhankar.MilindSardeshpande@amd.com>
 <20260727153720.4111771-2-Shubhankar.MilindSardeshpande@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260727153720.4111771-2-Shubhankar.MilindSardeshpande@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0077.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH3PR12MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd62eac-8035-4a7c-8552-08deebf582b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|10067099003|22082099003|56012099006|11063799006|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info: m1aLiZybhzhyKIgcU6gvSD9g/u9dMHrt7wyu/7QNOG5u+cbRERQEEwlPYRqnC/jBt+Tx6TtiEr0Kz30FFoUIhaHehb7uowaErPLKb7P8js+z3ly3Vgt0oyl1n3VNsc6/hs7pxmCCMIHQT32f/T2iXy+ZIID+S9jwotSdGosmdxckibuBD9uW1/mKLuiPAZOqSdO8Js11tug2lARd8qOM07lBxUuNMlUfvqWsQUpaYbZHkacKwyUzno8Zz59ebH5rnI2aLDo/PbIhORXWRCiYIrPjsCjdSFvItKGahy4i53QwbIdgV1MmpiZ+WwZQLEEY2m/2fBNdXTiXJ/BgPAG8yNLA4VZdzQkpReC6nodwvZIf2EayDf5Ga/q4tex0sL17p4Baf54Ub7/5abCqNOQqzqn3e1gIIP5Pcc8mD+4deDuicB8PeNwBkr+sZ1hshASgN1Bl34S7Fulf0+pK8+/rX2+zF0U0R9MLiKs//Upw5Rk9yjYXgU8UdSOvRnqqxWLp7MkuQxghyS//aGFOOciUxUA3hBfENWmu4zl0v5PWA89dIIZLNgL7NIZe3P78RJ0Yes/HWU65udolBxTAV6iT0jZRYNU66bju8+cWQaKhWY6E86E0SADBjRcQcyvFWAKhTPr0KuAKfCdCsIlJnmNLE4w0zf0/ELXM5jl20s0WyBs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(10067099003)(22082099003)(56012099006)(11063799006)(4143699003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0o2aGVCSFZDVUJxOTBKZ1IxUUNwWXkzZFBPYXN6Wm9PTitsU01qc1duQmlJ?=
 =?utf-8?B?Q3lKNkwzV2RCK29MdWpRMk81MStGWEtQOWN3Zm9HeGd0NkpJVVJWS3BvUnlr?=
 =?utf-8?B?TzYreFUxcmh5QWZQMTdoRUhOZER1V1g5TzVVaHJ6MEFORkdScGRHMmVVNEdO?=
 =?utf-8?B?eW5IREk4SWRSckZ6RWNyWVJua0ZHZTNIcEJ1YWc0YmlKTXEwcDBtWDFTeHFQ?=
 =?utf-8?B?VVdJTzBCQXdsUUtjL1U0YmhzUlcrbG9LNFZDQU8zYzRKbFIwMTdVQ0hBMWI1?=
 =?utf-8?B?WU15dlJ6ejhkRFo0Rk4yKzFkRU9KSlA4b1Izd200dCt4cU1OS3JSWllhVm1u?=
 =?utf-8?B?aXZoUVpFOG1ld29YSjJBU1k3OWs1dkttNU1QZXM4UDg4eTJSeFZ4MU5JN0Rn?=
 =?utf-8?B?eFZnWFR2eDcyb2JRRkxCN0lLa1FlM3VuQkFLSmFwbXNCR3RMamszaGdCWVBr?=
 =?utf-8?B?R250RXMwQjJ4OHdzTDY5ZGt5MjQ2TjV1a3hHZTNOd1h5d2RRNjFCcytqbjlQ?=
 =?utf-8?B?VU4wTG5lZnU3T242Sis1aURvOURvOGFibmw4akZOSVczTnVVMWhUNE9JS05D?=
 =?utf-8?B?M0F4N25kSXNvNFhaaDkzYzMwVW1MNUVSY3FuQk1UYjZqc1RtblpyTDFLS1RR?=
 =?utf-8?B?ZnJTYnhKWW5WZWtDcVN4UzhSWmdyY3BSYjRKdk5JWWFKUTlWbG1NK2dYQVI0?=
 =?utf-8?B?blZzNUVFWGRJL3c2Q2daTTE1OGFDSjV2anBUb3VZSDhxVW4yRnZQOFZyTk8v?=
 =?utf-8?B?OGtHRVVOWWhQYmNFaENBRnpJTUVwejcwd2xkYnVhNVJkR25ya2c2cjFBb0tQ?=
 =?utf-8?B?RVBZdWV1TVVkNUltdklKSGRpL3ExQWpEVHFsendwb1VUUWtlSkt5TWorcjJT?=
 =?utf-8?B?T0FhMyt1Q0pjQ09vK2tOVEhocGo2U3hDaFZ2OFltYXBEUmtTZCthSm1WTDB4?=
 =?utf-8?B?dEFlRHhzalBaUFZ5ZWRvaW0rRW9HREtMeW03WGlCUmJHSzRHNzU4cFp6RXZU?=
 =?utf-8?B?RUl0UmZxR0FTUmVzbHg2RUdNVzV0eVd0c21OckdXdmcxUk5jVVFXSUYxc25S?=
 =?utf-8?B?MjRuckw4aHdxSElaRThxV0p0R1V0ckd5dVVUQ2tIQ0EvU0tMbTkvTE5yMW9u?=
 =?utf-8?B?K2ppS3Ryd3lBRjAzYTZxOTRRb1FXZXlPWkU0WGp6R2lxSnNHYkVqRVRaZnA4?=
 =?utf-8?B?UGhuQWsvZmtUQnlRV21MdWZnZWFEM2VVN0ZNbGREak0wcjBXZWNsNEl5NTRN?=
 =?utf-8?B?VEY5SVlPVU9maVgrNDdaK1lWN1hvWW84eWEvSkdVbUtTY2RxZEQ3NWh3YVJ3?=
 =?utf-8?B?N0ZaTHpuazBmQnNjNm1GZUNXSHRLQm8xeC9CTWtnb09XQVdKOTJNWk5tNFJG?=
 =?utf-8?B?Zmt1RFZIY05BWm5DcEFjT3B3amlseDgvaXJYSEczVWtoRGFzK2hkRWhTWjdj?=
 =?utf-8?B?a2JlYzVMckxQMVppQTUzaEc2ZkJodzVZblNSY1owSUhxT2tNVDdDcXhvU3FQ?=
 =?utf-8?B?WTBsTGlRM3JTdEZsWVdwb2YwT0tPQ1FlT1hFaGhjMHptUi9qTStjeFIycTg3?=
 =?utf-8?B?dTZoc3BDNDRvK1dYUWlPRHcvOWgveFJUMnQzczg4QkI4NjJieUhJeVF5azFv?=
 =?utf-8?B?Y3BSck81NVFCRldocXFWUHE2bFh3Q003aXNkMGtrSWV4VFhXcHhnRE03d3ZX?=
 =?utf-8?B?eEE1bDBZeUx6cXYvZHRyRmRJM2UrSG9kSVpMU21CbG41bXdjN3JQU2ViS2J1?=
 =?utf-8?B?bXF2TGE4WGVWWEdlZjRid1BvQ00yWDJwSis1WHV3ZzdPL1d2Wlhab3A0M0xs?=
 =?utf-8?B?a3VreThYY2FUQTFuNmJDcEtUZGtVUVRSd2NOY2VtQ0gxWVNxeDJlMG5LWFE0?=
 =?utf-8?B?cU1uRThpR0xLNnk1VWxnSlFETHY0VWwzVGdJUXdKWGpza0xKbUh1cmo3MWpN?=
 =?utf-8?B?WDVadmM5akNnV0xXWXNyeHVET3ZSdXVRTmVmN2l5czhYV1prWFpKVExyUEFo?=
 =?utf-8?B?ZzFjZmJmVnh3K2tUWFVVanN3eVFoSDhjUHV2Y2hJQWkxREJnZDhlalFNajkx?=
 =?utf-8?B?bXVReDRzUlJKMVNobnY3eUF2cUZSdFRIYnZRV3BmVVhqSDdMdE05TEd2UTVv?=
 =?utf-8?B?Yk5Rc2RsUzBnMlFYczVGWXJqNXNzMXFXZUFlM21YbkVrb25VVVJWYVAyN29L?=
 =?utf-8?B?YnFiRGNmbWFsK2Z4VVo1bkR0Z1piZkhPKzhKSzRzWjlrdllNU0wwZzREZVQr?=
 =?utf-8?B?Q0FvM2dYUUhRSjJ1YnVpNUdGa2JLU015OGE1d1gzQnBpVlJ0d1VEcWFTdEwx?=
 =?utf-8?B?d05hVWFLTzdUYUhNek1PQnFkMTZmcVhXN0FYbzhMZkkvY0ludTVZdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd62eac-8035-4a7c-8552-08deebf582b2
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 15:41:22.7608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNO1SIzqhkXNU3kXZWCC43c+QapfIXZujMXUzFyxfuwUN/OSUpP5ASo3Zr8acsHs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344
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



On 27-Jul-26 9:03 PM, Shubhankar Milind Sardeshpande wrote:
> Replace the legacy SMU table-copy metrics path with a DRAM-mapped,
> accumulator-based approach for SMU v15.0.0, using a ping-pong buffer
> to compute averaged metrics from deltas between consecutive samples.
> 
> - Add GetMetricsTableVersion, GetMetricsTableLogSample and
>    GetMetricsTableLogDramAddr messages and their MSG_MAP entries.
> - Introduce SMU_15_0_0_MetricsInfo_t holding two MetricsTable_t
>    buffers, the mapped DRAM address, table size and pre-computed
>    avg_metric[] values.
> - Resolve and ioremap_wc() the firmware log DRAM address once in
>    init_smc_tables(); iounmap() it in fini_smc_tables().
> - Fetch samples into the inactive buffer, compute averaged clocks,
>    activity, power and temperature via wrapping_sub() accumulator
>    deltas, then swap the active index.
> - Rename the old get_metrics_table() to get_gpu_metrics_table() for
>    the gpu_metrics v3.0 export path.
> - Move AMDGPU_PP_SENSOR_SS_APU_SHARE, AMDGPU_PP_SENSOR_SS_DGPU_SHARE
>    to default case since they are not supported.
> 
> Co-developed-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> Co-developed-by: Suresh Guttula <Suresh.Guttula@amd.com>
> Signed-off-by: Suresh Guttula <Suresh.Guttula@amd.com>
> Co-developed-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
> Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
> Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
> ---

Series is -

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>   .../pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h  |   5 +-
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +
>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 293 +++++++++++-------
>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h  |  13 +
>   4 files changed, 199 insertions(+), 115 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h
> index bf216f83e689..9f627b5fef5b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h
> @@ -100,7 +100,10 @@
>   #define PPSMC_MSG_DisableLSdma                  0x1F ///< Disable LSDMA
>   #define PPSMC_MSG_SetSoftMaxVpe                 0x20 ///<
>   #define PPSMC_MSG_SetSoftMinVpe                 0x21 ///<
> -#define PPSMC_Message_Count                     0x22 ///< Total number of PPSMC messages
> +#define PPSMC_MSG_GetMetricsTableVersion        0x22
> +#define PPSMC_MSG_GetMetricsTableLogSample      0x23
> +#define PPSMC_MSG_GetMetricsTableLogDramAddr    0x24
> +#define PPSMC_Message_Count                     0x25 ///< Total number of PPSMC messages
>   /** @}*/
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index acf03838d49d..d6675b4ee9be 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -297,6 +297,9 @@
>   	__SMU_DUMMY_MAP(GetSmartShiftStatus), \
>   	__SMU_DUMMY_MAP(EnableLSdma), \
>   	__SMU_DUMMY_MAP(DisableLSdma), \
> +	__SMU_DUMMY_MAP(GetMetricsTableVersion), \
> +	__SMU_DUMMY_MAP(GetMetricsTableLogSample), \
> +	__SMU_DUMMY_MAP(GetMetricsTableLogDramAddr), \
>   	__SMU_DUMMY_MAP(InitializeGfx), \
>   	__SMU_DUMMY_MAP(SetSoftMaxFclk), \
>   	__SMU_DUMMY_MAP(SetSoftMaxGl2clk), \
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> index faa7d661f3bf..9da411bf2ad9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> @@ -33,6 +33,8 @@
>   #include "smu_v15_0_0_pmfw.h"
>   #include "smu_cmn.h"
>   
> +#include <linux/overflow.h>
> +
>   /*
>    * DO NOT use these for err/warn/info/debug messages.
>    * Use dev_err, dev_warn, dev_info and dev_dbg instead.
> @@ -119,6 +121,9 @@ static struct cmn2asic_msg_mapping smu_v15_0_0_message_map[SMU_MSG_MAX_COUNT] =
>   	MSG_MAP(DisableLSdma,                   PPSMC_MSG_DisableLSdma,				1),
>   	MSG_MAP(SetSoftMaxVpe,                  PPSMC_MSG_SetSoftMaxVpe,			1),
>   	MSG_MAP(SetSoftMinVpe,                  PPSMC_MSG_SetSoftMinVpe,			1),
> +	MSG_MAP(GetMetricsTableVersion,         PPSMC_MSG_GetMetricsTableVersion,		1),
> +	MSG_MAP(GetMetricsTableLogSample,       PPSMC_MSG_GetMetricsTableLogSample,		1),
> +	MSG_MAP(GetMetricsTableLogDramAddr,     PPSMC_MSG_GetMetricsTableLogDramAddr,	1),
>   };
>   
>   static struct cmn2asic_mapping smu_v15_0_0_feature_mask_map[SMU_FEATURE_COUNT] = {
> @@ -160,10 +165,37 @@ static struct cmn2asic_mapping smu_v15_0_0_table_map[SMU_TABLE_COUNT] = {
>   	TAB_MAP_VALID(DPMCLOCKS),
>   };
>   
> +static int smu_v15_0_0_get_metrics_table_dram_addr(struct smu_context *smu,
> +					SMU_15_0_0_MetricsInfo_t *metrics_info)
> +{
> +	struct smu_msg_ctl *ctl = &smu->msg_ctl;
> +	struct smu_msg_args args = {
> +		.msg = SMU_MSG_GetMetricsTableLogDramAddr,
> +		.num_args = 0,
> +		.num_out_args = 3,
> +	};
> +	int ret;
> +
> +	ret = ctl->ops->send_msg(ctl, &args);
> +	if (ret)
> +		return ret;
> +
> +	metrics_info->addr = ((uint64_t)args.out_args[1] << 32) | args.out_args[0];
> +	metrics_info->table_size = args.out_args[2];
> +
> +	metrics_info->cpu_addr = ioremap_wc(metrics_info->addr,
> +					    metrics_info->table_size);
> +	if (!metrics_info->cpu_addr)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>   static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
>   	struct smu_table *tables = smu_table->tables;
> +	SMU_15_0_0_MetricsInfo_t *metrics_info;
>   	int ret;
>   
>   	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
> @@ -173,7 +205,7 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
>   	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
>   		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>   
> -	smu_table->metrics_table = kzalloc_obj(SmuMetrics_t);
> +	smu_table->metrics_table = kzalloc_obj(SMU_15_0_0_MetricsInfo_t);
>   	if (!smu_table->metrics_table)
>   		goto err0_out;
>   	smu_table->metrics_time = 0;
> @@ -192,8 +224,18 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
>   	if (ret)
>   		goto err3_out;
>   
> +	metrics_info = (SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table;
> +
> +	if (metrics_info->addr == 0) {
> +		ret = smu_v15_0_0_get_metrics_table_dram_addr(smu, metrics_info);
> +		if (ret)
> +			goto err4_out;
> +	}
> +
>   	return 0;
>   
> +err4_out:
> +	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
>   err3_out:
>   	kfree(smu_table->watermarks_table);
>   err2_out:
> @@ -207,6 +249,14 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
>   static int smu_v15_0_0_fini_smc_tables(struct smu_context *smu)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> +	SMU_15_0_0_MetricsInfo_t *metrics_info = smu_table->metrics_table;
> +
> +	if (metrics_info) {
> +		if (metrics_info->cpu_addr) {
> +			iounmap(metrics_info->cpu_addr);
> +			metrics_info->cpu_addr = NULL;
> +		}
> +	}
>   
>   	kfree(smu_table->clocks_table);
>   	smu_table->clocks_table = NULL;
> @@ -299,7 +349,7 @@ static int smu_v15_0_0_set_default_dpm_tables(struct smu_context *smu)
>   				    smu_table->clocks_table, false);
>   }
>   
> -static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
> +static int smu_v15_0_0_get_gpu_metrics_table(struct smu_context *smu,
>   							void *metrics_table,
>   							bool bypass_cache)
>   {
> @@ -329,115 +379,142 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
>   	return 0;
>   }
>   
> +/*
> + * Fetch a fresh metrics sample into the inactive buffer.
> + * Returns 0 if a new sample was copied, 1 if the cached sample is still
> + * fresh (nothing copied), or a negative errno on failure.
> + */
> +static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
> +					SMU_15_0_0_MetricsInfo_t *metrics_info)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	void __iomem *cpu_addr = metrics_info->cpu_addr;
> +	struct smu_msg_ctl *ctl = &smu->msg_ctl;
> +	struct smu_msg_args args = {0};
> +	int table_size = metrics_info->table_size;
> +	int ret;
> +
> +	if (smu_table->metrics_time &&
> +	    !time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1)))
> +		return 1;
> +
> +	if (!cpu_addr)
> +		return -ENOMEM;
> +
> +	args.msg = SMU_MSG_GetMetricsTableLogSample;
> +	args.num_args = 0;
> +	args.num_out_args = 0;
> +
> +	ret = ctl->ops->send_msg(ctl, &args);
> +	if (ret)
> +		return ret;
> +
> +	/* best to flush before copy */
> +	amdgpu_hdp_invalidate(smu->adev, NULL);
> +	if (table_size <= sizeof(MetricsTable_t))
> +		memcpy(&metrics_info->metrics[!metrics_info->active_idx],
> +		       cpu_addr, table_size);
> +	else
> +		memcpy(&metrics_info->metrics[!metrics_info->active_idx],
> +		       cpu_addr, sizeof(MetricsTable_t));
> +
> +	metrics_info->active_idx = !metrics_info->active_idx;
> +
> +	return 0;
> +}
> +
> +/*
> + * Accumulators monotonically increase and roll over at their type width.
> + * Use the kernel wrapping_sub() API to compute the delta so the subtraction
> + * wraps modulo 2^n (correct across a single rollover) without tripping any
> + * wrap-around sanitizers.
> + */
> +static void smu_v15_0_0_compute_all_metrics(
> +		uint32_t *avg_metric,
> +		MetricsTable_t *prev,
> +		MetricsTable_t *curr)
> +{
> +	uint64_t counter, val;
> +	MetricsTable_IOD_t *p = &prev->IOD;
> +	MetricsTable_IOD_t *c = &curr->IOD;
> +
> +	counter = wrapping_sub(u32, c->AccumulationCounter, p->AccumulationCounter);
> +	if (!counter)
> +		return;
> +
> +	/* Accumulator-based clock frequencies (fixed-point /1024) */
> +	val = wrapping_sub(u64, c->GfxclkFreqEffAcc, p->GfxclkFreqEffAcc);
> +	avg_metric[METRICS_AVERAGE_GFXCLK] = (val / counter) / 1024;
> +
> +	val = wrapping_sub(u64, c->SocclkFreqEffAcc, p->SocclkFreqEffAcc);
> +	avg_metric[METRICS_AVERAGE_SOCCLK] = (val / counter) / 1024;
> +
> +	val = wrapping_sub(u64, c->VclkFreqEffAcc, p->VclkFreqEffAcc);
> +	avg_metric[METRICS_AVERAGE_VCLK] = (val / counter) / 1024;
> +
> +	val = wrapping_sub(u64, c->MemclkFreqEffAcc, p->MemclkFreqEffAcc);
> +	avg_metric[METRICS_AVERAGE_UCLK] = (val / counter) / 1024;
> +
> +	val = wrapping_sub(u64, c->FclkFreqEffAcc, p->FclkFreqEffAcc);
> +	avg_metric[METRICS_AVERAGE_FCLK] = (val / counter) / 1024;
> +
> +	val = wrapping_sub(u64, c->NpuhclkFreqEffAcc, p->NpuhclkFreqEffAcc);
> +	avg_metric[METRICS_AVERAGE_NPUCLK] = (val / counter) / 1024;
> +
> +	/* Activity (fixed-point /1024) */
> +	val = wrapping_sub(u64, c->GfxBusyAcc, p->GfxBusyAcc);
> +	avg_metric[METRICS_AVERAGE_GFXACTIVITY] = (val / counter) / 1024;
> +
> +	val = wrapping_sub(u64, c->VcnBusyAcc, p->VcnBusyAcc);
> +	avg_metric[METRICS_AVERAGE_VCNACTIVITY] = (val / counter) / 1024;
> +
> +	/* Power (fixed-point /1024) */
> +	val = wrapping_sub(u64, c->ApuPowerAcc, p->ApuPowerAcc);
> +	avg_metric[METRICS_AVERAGE_SOCKETPOWER] = (val / counter) / 1024;
> +
> +	val = wrapping_sub(u64, c->SystemPowerAcc, p->SystemPowerAcc);
> +	avg_metric[METRICS_CURR_SOCKETPOWER] = (val / counter) / 1024;
> +
> +	/* Temperature */
> +	val = wrapping_sub(u64, c->GFX_TempAcc, p->GFX_TempAcc);
> +	avg_metric[METRICS_TEMPERATURE_EDGE] = val / counter;
> +
> +	val = wrapping_sub(u64, c->STT_APU_HotSpotTempAcc, p->STT_APU_HotSpotTempAcc);
> +	avg_metric[METRICS_TEMPERATURE_HOTSPOT] = val / counter;
> +
> +	/* Voltage(mV) */
> +	val = wrapping_sub(u64, c->VDDCR_GFX_TelemetryVoltage, p->VDDCR_GFX_TelemetryVoltage);
> +		avg_metric[METRICS_VOLTAGE_VDDGFX] = (val / counter) / 1000;
> +
> +	val = wrapping_sub(u64, c->VDDCR_SOC_TelemetryVoltage, p->VDDCR_SOC_TelemetryVoltage);
> +		avg_metric[METRICS_VOLTAGE_VDDSOC] = (val / counter) / 1000;
> +}
> +
>   static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
>   					    MetricsMember_t member,
>   					    uint32_t *value)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> +	SMU_15_0_0_MetricsInfo_t *metrics_info =
> +		(SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table;
> +	int ret;
>   
> -	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
> -	int ret = 0;
> -
> -	ret = smu_v15_0_0_get_metrics_table(smu, NULL, false);
> -	if (ret)
> +	ret = smu_v15_0_0_get_metrics_table(smu, metrics_info);
> +	if (ret < 0)
>   		return ret;
>   
> -	switch (member) {
> -	case METRICS_AVERAGE_GFXCLK:
> -		*value = metrics->GfxclkFrequency;
> -		break;
> -	case METRICS_AVERAGE_SOCCLK:
> -		*value = metrics->SocclkFrequency;
> -		break;
> -	case METRICS_AVERAGE_VCLK:
> -		*value = metrics->VclkFrequency;
> -		break;
> -	case METRICS_AVERAGE_DCLK:
> -		*value = 0;
> -		break;
> -	case METRICS_AVERAGE_UCLK:
> -		*value = metrics->MemclkFrequency;
> -		break;
> -	case METRICS_AVERAGE_FCLK:
> -		*value = metrics->FclkFrequency;
> -		break;
> -	case METRICS_AVERAGE_VPECLK:
> -		*value = metrics->VpeclkFrequency;
> -		break;
> -	case METRICS_AVERAGE_NPUCLK:
> -		*value = metrics->NpuclkFrequency;
> -		break;
> -	case METRICS_AVERAGE_GFXACTIVITY:
> -		if ((smu->smc_fw_version > 0x5d4600))
> -			*value = metrics->GfxActivity;
> -		else
> -			*value = metrics->GfxActivity / 100;
> -		break;
> -	case METRICS_AVERAGE_VCNACTIVITY:
> -		*value = metrics->VcnActivity / 100;
> -		break;
> -	case METRICS_AVERAGE_SOCKETPOWER:
> -	case METRICS_CURR_SOCKETPOWER:
> -		*value = (metrics->SocketPower / 1000 << 8) +
> -		(metrics->SocketPower % 1000 / 10);
> -		break;
> -	case METRICS_TEMPERATURE_EDGE:
> -		*value = metrics->GfxTemperature / 100 *
> -		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> -		break;
> -	case METRICS_TEMPERATURE_HOTSPOT:
> -		*value = metrics->SocTemperature / 100 *
> -		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> -		break;
> -	case METRICS_THROTTLER_RESIDENCY_PROCHOT:
> -		*value = metrics->ThrottleResidency_PROCHOT;
> -		break;
> -	case METRICS_THROTTLER_RESIDENCY_SPL:
> -		*value = metrics->ThrottleResidency_SPL;
> -		break;
> -	case METRICS_THROTTLER_RESIDENCY_FPPT:
> -		*value = metrics->ThrottleResidency_FPPT;
> -		break;
> -	case METRICS_THROTTLER_RESIDENCY_SPPT:
> -		*value = metrics->ThrottleResidency_SPPT;
> -		break;
> -	case METRICS_THROTTLER_RESIDENCY_THM_SOC:
> -		*value = metrics->ThrottleResidency_THM_SOC;
> -		break;
> -	case METRICS_VOLTAGE_VDDGFX:
> -		*value = 0;
> -		break;
> -	case METRICS_VOLTAGE_VDDSOC:
> -		*value = 0;
> -		break;
> -	case METRICS_SS_APU_SHARE:
> -		/* return the percentage of APU power with respect to APU's power limit.
> -		 * percentage is reported, this isn't boost value. Smartshift power
> -		 * boost/shift is only when the percentage is more than 100.
> -		 */
> -		if (metrics->StapmOpnLimit > 0)
> -			*value = (metrics->ApuPower * 100) / metrics->StapmOpnLimit;
> -		else
> -			*value = 0;
> -		break;
> -	case METRICS_SS_DGPU_SHARE:
> -		/* return the percentage of dGPU power with respect to dGPU's power limit.
> -		 * percentage is reported, this isn't boost value. Smartshift power
> -		 * boost/shift is only when the percentage is more than 100.
> -		 */
> -		if ((metrics->dGpuPower > 0) &&
> -		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
> -			*value = (metrics->dGpuPower * 100) /
> -				 (metrics->StapmCurrentLimit - metrics->StapmOpnLimit);
> -		else
> -			*value = 0;
> -		break;
> -	default:
> -		*value = UINT_MAX;
> -		break;
> +	if (ret == 0 &&
> +	    metrics_info->metrics[metrics_info->active_idx].IOD.AccumulationCounter !=
> +	    metrics_info->metrics[!metrics_info->active_idx].IOD.AccumulationCounter) {
> +		/* New sample: active_idx already points to the latest sample. */
> +		smu_v15_0_0_compute_all_metrics(metrics_info->avg_metric,
> +						&metrics_info->metrics[!metrics_info->active_idx],
> +						&metrics_info->metrics[metrics_info->active_idx]);
>   	}
>   
> -	return ret;
> +	*value = metrics_info->avg_metric[member];
> +
> +	return 0;
>   }
>   
>   static int smu_v15_0_0_read_sensor(struct smu_context *smu,
> @@ -512,18 +589,6 @@ static int smu_v15_0_0_read_sensor(struct smu_context *smu,
>   						       (uint32_t *)data);
>   		*size = 4;
>   		break;
> -	case AMDGPU_PP_SENSOR_SS_APU_SHARE:
> -		ret = smu_v15_0_0_get_smu_metrics_data(smu,
> -						       METRICS_SS_APU_SHARE,
> -						       (uint32_t *)data);
> -		*size = 4;
> -		break;
> -	case AMDGPU_PP_SENSOR_SS_DGPU_SHARE:
> -		ret = smu_v15_0_0_get_smu_metrics_data(smu,
> -						       METRICS_SS_DGPU_SHARE,
> -						       (uint32_t *)data);
> -		*size = 4;
> -		break;
>   	default:
>   		ret = -EOPNOTSUPP;
>   		break;
> @@ -634,7 +699,7 @@ static ssize_t smu_v15_0_0_get_gpu_metrics(struct smu_context *smu,
>   	SmuMetrics_t metrics;
>   	int ret = 0;
>   
> -	ret = smu_v15_0_0_get_metrics_table(smu, &metrics, false);
> +	ret = smu_v15_0_0_get_gpu_metrics_table(smu, &metrics, false);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
> index 8365b9fea77e..8471ba1a353e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
> @@ -23,6 +23,19 @@
>   #ifndef __SMU_V15_0_0_PPT_H__
>   #define __SMU_V15_0_0_PPT_H__
>   
> +#include "amdgpu_smu.h"
> +
> +#include "pmfw_if/smu_v15_0_0_metrics.h"
> +
> +typedef struct {
> +	MetricsTable_t metrics[2];
> +	bool active_idx;
> +	uint32_t table_size;
> +	uint64_t addr;
> +	void __iomem *cpu_addr;
> +	uint32_t avg_metric[METRICS_AVERAGE_NPUCLK+1];
> +} SMU_15_0_0_MetricsInfo_t;
> +
>   extern void smu_v15_0_0_set_ppt_funcs(struct smu_context *smu);
>   
>   #endif
> \ No newline at end of file

