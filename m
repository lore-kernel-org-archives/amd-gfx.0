Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811F3C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 11:28:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EA5E10EB25;
	Thu, 17 Mar 2022 11:28:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCF7F10EB25
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 11:28:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6SLPQUyoyGwWfYrQto0EKSrPvOtMcrDgXHIkliokcpLaEUU45OiQM9kAEATX9wD/fgaFxtrCwbFKbfBnkqkdp2rb4uWQgKtxGo1he+i0HENasCGA51OQ0RcHTFL0GDrnmbDQPYUzyxNjfnHJwuNVKD3e5hHTu7hBK2kA8hlLP7lEhLOFnFG/RLBNVwwHsABxkvhooi/21UKTSGOmI6RScYILrXVciBovanPQwU0zTmRoBs1ToHeh38CfJJ047NTSIY3c/FZVbNFyBWqfqtHrkVhlkmylYCOxU62CpUwR6tyPFC/QsY5g/98rnGth4/nE89+byeBZrAyxESc7vo3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pywrFFszHhdGhRMmzkVX1A23Guev0egmiaXbMhBNyN0=;
 b=Sz1hluMhWTd91Xcdl4Opw6ZK8dexvs/yqkypiqYZ6ccPLTSvIBhIOr9XmMxodFEVwYfK06AX7MPZY9PCROdY5NMrmJhRMFj2uxA5CM2amWBF0V2kTHH+nEbI9RwBp9eLRc/ljQgbJoAqWLjGFID2v2IzI8vlYgp3mADD6Fh8xbSkKBrRwuDfKVzFAsR4oInwwRyi96MgDcp8byTDr0F9yF+zoihOVjoTC6bgcHKNLk3gR/ERsaDJh7UqFmvWY5v0evsx0kOVuEMbiFU9suGO3QGNI4r2SoFGzE/fakEGt9qHTMPuFhjsIoMw3UyCsSPV8nkqlg+p+U+pFW+NKowhWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pywrFFszHhdGhRMmzkVX1A23Guev0egmiaXbMhBNyN0=;
 b=kVA/Nu41WK+M4kBN/Ur18s5gwLGUuVunDjaJ4SRqrWfTuUK4bZFCEIghraYfOk5woKMaNFW32nG2SepKWAgRanYyp9HKe2ahZzM6G8+V5TwLkYpyAB6cxJNUMCMzorknEY7JCzZedirWcjORasTAGr7GYMXUwDSWEQrmHIg/52U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN7PR12MB2691.namprd12.prod.outlook.com (2603:10b6:408:26::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Thu, 17 Mar
 2022 11:28:30 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06%5]) with mapi id 15.20.5061.028; Thu, 17 Mar 2022
 11:28:30 +0000
Message-ID: <0c3cc4cc-fd94-f099-2fc9-0d55e9f0d05c@amd.com>
Date: Thu, 17 Mar 2022 16:58:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: Disable fan control if not supported
Content-Language: en-US
To: Elena Sakhnovitch <elena.sakhnovitch@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220315140805.1025021-1-elena.sakhnovitch@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220315140805.1025021-1-elena.sakhnovitch@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0100.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::16)
 To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8347e1f4-7b17-407d-b59d-08da0809432d
X-MS-TrafficTypeDiagnostic: BN7PR12MB2691:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB269161B940A99BBD2A2607D097129@BN7PR12MB2691.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lU290jX+qPaawZOA9fcVqpbBSgMyCQejhBYkkCUf/BEBMhD35Yv/u6Wv+LATQdzfu4C0Vyas1AGyNXvRjoHWIUM4Jfc8v+Ap+akLXcnRMpkLYc0dqvgpuIaqegLgP7TzT/qbko3idzVq97wk6RkG1rsQgPz9gB2BbJYwFNJFGVPwOWby4sTDBunloU0AfcuN/qS1pZ0mx36FbKOgdX1D+FFJ1N1E+qSa3AYSFqxrHoAKQ7iWd3zzs129GqTkBw961FFCXqChOb7UOeTBFPRetlmzGDTd9trcIc/m3eXUquPV/4rYZnCNbuiAopRSpTYUUDnTSdQL8NmrjvY399+LO9x44Pen/zL7kmBYJW7lKc8Koe6NaK43Ru8msbigM4CPcTIZuQZYhzhr4WP6CJ95104MqwMPZl41JHpzmvnHYfnKs0k36PWTffyA2Jah63c/qo72R5KkIqFh5zrCieZN22KBX8m5DXODQdS4uHDro2cZJBRqGLr0nlGNk8ZP/eDftbHD/cbnAZ3gXs6RkNa7r1a1/yBcfKAGKsSK2b+Rzsn1KTX/GCwwqBptlGI9hWP3LSzne3SKAfGuzDKL/praPFi11T6SfaNms2K8sI0QwRif5p3cA0Sz+jRdJdmnbA21OXvCB8QBr0F1Nh4cxP+JJMTTeMMC14xtrwc12uZGFxOOtQycG7p74J0a/SKPLAikfTq03i8TAV7tmPIoIsFAfqGH+2n2+YK6Ac94XM5AgDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(5660300002)(6486002)(508600001)(2616005)(86362001)(6512007)(31696002)(6666004)(53546011)(2906002)(38100700002)(6506007)(83380400001)(186003)(26005)(66556008)(66946007)(66476007)(316002)(31686004)(36756003)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WStWbkEwcGVsdnN0Qjd5cUN5TmJiY2ZuZUduV2xPZGd5NlVYUEtHeFMrNXA2?=
 =?utf-8?B?RVU4b0NyTThCRng5d01LcHJpY2FscitJc2ljU1cyd1R1UVQ2K3lBYk92eXI3?=
 =?utf-8?B?L0JIcTJGMDhVa3FWellGdXlhc1ZwNFNjTEFSYzRwYWJ5bjhYcWpVK1I5d2NC?=
 =?utf-8?B?a2JNSG9Ua0F5QUFFUGZraUNXM25Cam5VNlBrUlhxbjZZZVJwdVkrcTBxNitZ?=
 =?utf-8?B?cXNFRm5qSHlzQVY0dTlBTmRURjZ4NUhtS25tZW9qNmZsRWNnaVJDdlk4RXZy?=
 =?utf-8?B?Qzh0OW1LM2M0YUFPMVlEYjVzQUdHRVlyOUkwamo2clYxK0FXRGRXNlVRYVJL?=
 =?utf-8?B?eWVWWkJxY0FHdXFDZGF1eEZuMVhuMjRFYlRiQVR1NHQ5aTNZaG40bnZqNkYr?=
 =?utf-8?B?SStJOGduRS92bHhCN2NDSVBWcnNjcmZhbDJ5REdUN0pZaVZCN1lmdGkybjlu?=
 =?utf-8?B?SXNLMkJuTGRwKytuSTBRTk1sMFg0cFpUbExCZVdGcjRxRXBEbWVqQmRwVGUy?=
 =?utf-8?B?V0MwN1R2WnE2ajE5dWtLL0c4TlFwMEN2TnVTT0ErT09HZVBROTdEMktVOGhR?=
 =?utf-8?B?alVpSlM5cG1PQUpIMmx3MEVtZDMxNWlETzh1UHIvTUNiWERpZHp2a3ZqZWts?=
 =?utf-8?B?VnlicnVndVFid2xqK2QzTEcvMzN5aGhTaFNnVFJHcjh1SHFoSVhmNTB1U0or?=
 =?utf-8?B?eWtZaGlwVHZxdkQ2Yjl0KzlTUUpudkIzZGNPVGlCR3JRbUdxbm96ZUF3dm1Q?=
 =?utf-8?B?N3RnYm53NnNKYnJMUk96cnVpNFZ0R2svdFhXa1NHRXlhaVhyOFB0RU9COXkx?=
 =?utf-8?B?VlR0QytTOVMxa25NYXBXblN2QUZGaVI2YUZ2QURzQUU4blRZSFJaUjBwWTdM?=
 =?utf-8?B?dzBFYjN6UTMzN1NYdVZwMVd0ZFFqT25ldGk5WnFlWFhQSXcwbjhISm1scGFj?=
 =?utf-8?B?Ti9Qa21wY0Z0bXhmU3MzZm1abWNQRXBQQkEwRUFsY2VKdnBuWFFPSjJ3Z2ly?=
 =?utf-8?B?MVF5eWgwR1pjYjQ2U3Y5RVgzcHdPeHJwNTdVUGs5V25mME1QaHJxOWg5OC9B?=
 =?utf-8?B?ay9MTkp3NUVGVFExZnBRckJ2eC9Fc3lyUWZOZklTUlBwQkxwZ2hvOUZYYmdj?=
 =?utf-8?B?VFVvR1dDaDMyVGM1Q3BSMFllbldibWcwdXJTZDdpZ3g4VVVWQTloQ1pIT2Qw?=
 =?utf-8?B?cjJ3dzlPclFNd0NmYlQ2dmliQWVVVUdkTWxtOERjS1hHL09HL1dvMFFJenpL?=
 =?utf-8?B?aWYzZXR6UWZRN0g4VVE1UXQzcDJiOTZDbDVBUzA0MHhLR0pkWkFLNWpSdmUw?=
 =?utf-8?B?S00wK3JsS05sQW8yTUNsTG1sVXBITkhNejI1SUJHM1NkYlR1TStIRjdoYXZF?=
 =?utf-8?B?TVhlQW1MNTZQTFEwVXo0dXBpWHgzM3hkTkQrczlyZmdVcTV2ZDFQRGx0TTVo?=
 =?utf-8?B?MXFwUmxobDBBNGFGdWFnTDR1VXpFZ0lxMkhPSkpWY1BZcnJpSlpwVWtwblpN?=
 =?utf-8?B?MERvcnc5Z2hJSUREeGdGLzh2d0dESTNYMktCbEFaUmxxYU9ZbTNlMkFpZUJJ?=
 =?utf-8?B?bEtCREQ5RGovK0t2dDB5elA5T0hxenVyY2I5V3ZEV2lXOE5tWjgzZlNzeCtV?=
 =?utf-8?B?eXgxWVhJVWVieEN0V0VpcnNPdC9rWWhUbVg0RW04TGhSVnlENy9TSFdpQVVO?=
 =?utf-8?B?VE4wcDUvSnNXVHR0VXZsL0ExQjFYcDBsODMybzZDbUk2MytwWXdFcXpITnVY?=
 =?utf-8?B?MVB4NmFKY2hVekVLc2xKZENkRURKM2xVTnBSQStlWWwyZW5hZk85K3VFTmls?=
 =?utf-8?B?ZEd1UXpRVDJHS3N3dmsrZVpRWTlETmhLY3JRMWNMUUdmNHFpMkVPTy96Wlg3?=
 =?utf-8?B?WURUUVNFcitWL3NIU2U5S1R5eHZIckdEZmNEWUpUb2dobUJPUUZNdnFKTFBy?=
 =?utf-8?Q?ZTi17gC/Gg2chbxl9d8Q8kDlwf3GYasr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8347e1f4-7b17-407d-b59d-08da0809432d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 11:28:30.4424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yqz9lWvoUk4nMecNTDMNB6qETGipTF60CIBTFIBlz2pu8QBcYe5QVhQjR0gMNDCd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2691
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



On 3/15/2022 7:38 PM, Elena Sakhnovitch wrote:
> On Sienna Cichild, not all platforms use PMFW based fan control. On such
> ASICs fan control by PMFW will be disabled in PPTable. Disable hwmon
> knobs for fan control also as it is not possible to report or control
> fan speed on such platforms through driver.
> 
> Signed-off-by: Elena Sakhnovitch  <elena.sakhnovitch@amd.com>
> Change-Id: I42f9eb971a61a5ad63327607479fc7e9d9d6914d
> ---
>   .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 38f04836c82f..23abb1d1f677 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -371,6 +371,18 @@ static void sienna_cichlid_check_bxco_support(struct smu_context *smu)
>   	}
>   }
>   
> +static void sienna_cichlid_check_fan_support(struct smu_context *smu)
> +{
> +	struct smu_table_context *table_context = &smu->smu_table;
> +	PPTable_t *pptable = table_context->driver_pptable;
> +	/* No sort of fan control possible if PPTable has it disabled */
> +	smu->adev->pm.no_fan =
> +		!(pptable->FeaturesToRun[0] & FEATURE_FAN_CONTROL_MASK);

Nothing like FEATURE_FAN_CONTROL_MASK in smu11_driver_if_sienna_cichlid.h.

Also,

	#define FEATURE_FAN_CONTROL_BIT         32

and FeaturesToRun is uint32_t array.

Thanks,
Lijo

> +	if (smu->adev->pm.no_fan)
> +		dev_info_once(smu->adev->dev,
> +			      "PMFW based fan control disabled");
> +}
> +
>   static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
>   {
>   	struct smu_table_context *table_context = &smu->smu_table;
> @@ -381,6 +393,7 @@ static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
>   		smu->dc_controlled_by_gpio = true;
>   
>   	sienna_cichlid_check_bxco_support(smu);
> +	sienna_cichlid_check_fan_support(smu);
>   
>   	table_context->thermal_controller_type =
>   		powerplay_table->thermal_controller_type;
> @@ -410,7 +423,7 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
>   	GET_PPTABLE_MEMBER(I2cControllers, &table_member);
>   	memcpy(table_member, smc_dpm_table->I2cControllers,
>   			sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
> -	
> +
>   	return 0;
>   }
>   
> 
