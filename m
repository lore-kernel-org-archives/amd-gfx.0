Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DB8E95A8E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 11:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ACF810E0FA;
	Mon,  9 Oct 2023 11:58:38 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D954510E0F5
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 11:58:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5fhOCE+tdtv3LyoiSftHB/EVy03UN2JNfWalaZHAz7SCyySIc7gGg1npIcWdEvBdXQWjE7/Lnlwj4A/EHksMvx1HQSRF2JWmrJ8L9fkAIJlmOt6vo+baGJw6OmA6QekwC/modItPpQSmWlb4QGVLQoSqugpO9zUvgmczLgzRZOeT/CgGbjR14pWmQ0OLj1qghd+3sQiIOZFmdIqd46gWQourIInNQG8333Z+bY81K6CJ04PJtrl+Baf2PyI9t1kGMSDfaWTkMnifkugM+Y1aOzyYMqPXfi6TGq1qtTZxTu2x1efe4dZInFU2gPboBULN1EnkjrgrKxB1zozpKB9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iX1v0DvCuS03kpruGrvBUY1PNHK1pzEPV2BxG3cO99k=;
 b=OQz6wZsqsrKR9YqG6mjb+4N/lg8BI3jLl/rSrb+iLNNq9CaIpOH80HxvcGZ+301PB4j/LkK0G+30Xroc7iNmi7poJYHfmxcfr1s7Ms7n/jF6ymdUag4fBS2hhnHkbvTpM/YTrxPT5lOPZj5TBCZvWLhs/ZI37JRHtGCQQ2U5hQtfDe84Rn5OxF663XIhfabf5fM8MCC+b7ryYemQfBQKz/0K2C+KMOwyy2djdFpFF98MQP2vfB3eLm0btZYXpI0i8IZ/PV/6W/Hv358jPEu0RJasQK5zy/XT8iyBmL/BXv+BMs6UP5PPhGbgKLIMidJ/sslh44mKjL9PX7gc6H2Yfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iX1v0DvCuS03kpruGrvBUY1PNHK1pzEPV2BxG3cO99k=;
 b=VvfSY8uBxtYe3pQLy1Al8KoR7S3Il4qYsGufh7TU38XqurCpzgyt6M+lkz/7pblwBgyr4OLZLF0VxENcdXMyOCPKV02B5HiQZGVxa8gbvduBI8hta/KmNuJDr+OGE7nYYQoVcQTDBX9fqIPhssIX3zxUzRFQInKSo8YG/5iYN5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CY5PR12MB9053.namprd12.prod.outlook.com (2603:10b6:930:37::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 11:58:33 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab%7]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 11:58:33 +0000
Message-ID: <04f987dd-bb68-48c6-7534-d9a40942c50f@amd.com>
Date: Mon, 9 Oct 2023 17:28:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 3/3] drm/amd/pm: Use gpu_metrics_v1_4 for SMUv13.0.6
Content-Language: en-US
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231006144140.566546-1-asad.kamal@amd.com>
 <20231006144140.566546-3-asad.kamal@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231006144140.566546-3-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::23) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|CY5PR12MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d860492-6b90-463b-6eba-08dbc8bf0f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYDTN/Ymp/oLqozjIl26BhpMOjXUdh34vkpYyIrszRaZRTglSzXzWrFdrOJLN9h+A+rduq2DrGpfT1Bhh+HgNAx+wqAe1ucMFjGS/8GVerNom5JROay9aghdqqSlBo50KO5Pzl+9ZYKxbpqhWFF6SYEP8FTUyAIQmcJrYkvHjE7T8XYcOdvhYqwPEE+Or3f4nQLy+vsqOelvYRKHx7jU4+3CCRtvi57ifqIVsTdwHXztR7dvOcLr9g8a4oaoF+b1xyvfdRXE7qtbfMNEL0azUZb9R7J4gt33H++Wo/6ddDjYknXJF/eUV56VEs2RJojqEr3GhyRBSa68rkmluc1Qk9+zKrXr2jIwPmVV5MB8hY3iqCQdsVcV1laME00a1pYQrOp5blgfqeJ/ruTwgi8uCdwhimswSqrjWhPxtauag1jAjXSXXnDjxvF/dduf0GwuqZ0qrdjZCC9POIco4VgFrWN45w7NhcL0mcYPRPC71cFnwgzzJ/XKKYBPQbo+5yTdAB327tjhYwEO6M+8jzXAL6pNOMgyhpvmaM+AgUZWIMXYRkvYNgxuNH1V4mlePjsw7PQ1QYo93Rqi7whqVg359Bl1RnlZkS5J8tXiKOLv5jbThdxp+HJNNgpa41SboPeenb2U+iDwqNWrep6QPOQYxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(6506007)(53546011)(2616005)(6512007)(36756003)(31696002)(86362001)(38100700002)(26005)(83380400001)(2906002)(6486002)(6666004)(478600001)(41300700001)(8676002)(4326008)(8936002)(316002)(66476007)(5660300002)(66556008)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STVKUGdYVXNMeGxKVHVzQXA2WGJQZ1FQNlZOVEN0dmk1V1NNdzVIWGs0WXdr?=
 =?utf-8?B?ejZDUkRGQ0d2OVhqbHR0Q1duWTFCd2grc0JoT0IxWUFZK3J2RGJRaWR3NEp5?=
 =?utf-8?B?U1NwK2RYRUNNYVZpZ3B0dENDaUI1Y003K0hrTGhGNUZCZDJWdXlEc3NCamhZ?=
 =?utf-8?B?V0xuTVRpMTdhWFVvYzNvOFBlakZsMUxIeG5SRUVxVmVPMUhZT25iaEE2Uldy?=
 =?utf-8?B?MkEweGl4OFlCdEJmMjRUdmRSMTR0dCt5ai82RmxKUWJuSnhTVEc1SXo3V3Jv?=
 =?utf-8?B?bVhDZ2l5SkFkOWJTWWFTeVcxajlJZUZhQlA2VllWNmNuYkJuMEVFVnBLQTZF?=
 =?utf-8?B?MUxtcDk1cW9laTluVk5qaWRrSFV5cHJKeC90dWNYSmhzeGxQMU1CRDFCWS82?=
 =?utf-8?B?b1pkWkY5UlR0S1VuUG5IZU1ncmkySzVFSm1uRytpL054TFRtRUxzS2swUmlj?=
 =?utf-8?B?dHdHbFRGKyttdUlpSEZBS3RIaitOQWFRRzhqSms4WjUzblQxK2VFSXIxTnBz?=
 =?utf-8?B?ZThWMVkzQjFoRXZ0T01VeFgrOHFKWXZqOFdWQkgyZVBGbXpnNzdGZE1iM3JK?=
 =?utf-8?B?NTFnNWhCTFhiRzE5dWVEQ29RREI4dXMxQVFsVWxWQjhmeG00NHhDNnVkZWQz?=
 =?utf-8?B?bFFyS3dnQUFBbUFvMUZVM2k1MVRpcXJGa2hlZVBRSzM3SUE0TXBnbmpjcjFV?=
 =?utf-8?B?b2dIZGFPT24vdXVjMm4wYjhmVldlQWk1QVR3OE1aMGpJL1hyTkpvaHMxQ1BF?=
 =?utf-8?B?L2UxQWcyRmpuc0poam4yY2RQdGJtNFZ4dUtleDZhQ01zUDVMbjBCK0hUeEJx?=
 =?utf-8?B?YklDWUlqN3dPRVRGZnFWSHBFUHc3VUs4R3EyOXFTdVZXTDFKNjBCZ29ld3RI?=
 =?utf-8?B?SytaUW85amRCZEh6dHJjZkZIRW56QTlFOUpPT3ZaY05pcGYwOUJiVFJYbkpi?=
 =?utf-8?B?bXdqblRpYnc5NVJxcnlsbkx5eE9nV0xaMTlFR2RkeG1sTEFRd1RhekUwNXgv?=
 =?utf-8?B?dGtMRWhKWVJ0eXNyT21sUlIwUXVlS2pmN3djRkVrc29nWXljWXFqZ3U2S3Qv?=
 =?utf-8?B?NGRLcnRMOU9GQTFKTUN2MmFRMXg3Z3lvNEVWY1lGT2R5T0FCV0RZaER5Q3hP?=
 =?utf-8?B?ejNzRndndGt2NGZWL2JiMDUxMzVMdEhIRlFqV01HSUhZMDZXTUtjRHF0Z2hB?=
 =?utf-8?B?L0VrazQwd1cwUU1vb0Y4VjdXSlN5RjZmRFZLMjRTR3VzV0dYQ2ZjTFAwbDEr?=
 =?utf-8?B?SUJzTWZMOTJYVjFYR1czL0hVWUJoemhLU0NuV0NOZ2l5ZTZZSVpac2M1N0V2?=
 =?utf-8?B?emxacllMYk5BclE4R0V0UzlZUlo4QjJHeGNBQmhNa0Vxa25sQlBySDNOcEZX?=
 =?utf-8?B?dUh1bVBCdnYxd3k4VW9Wa05JcmRsV3lORk9vcHNxam5KNGRydTRNVmxMbVl4?=
 =?utf-8?B?dVZiUm5GbWNPQ1VyNHo1TU8vRmRNcnJ0aTNmR2x0UXVEb3NwRjA1NG9hNHJK?=
 =?utf-8?B?NzRrcnNKYnZ4V1NCOU1POTMxSUxTMmRDR3daRmhUWEkybnJXdE94VXFIVGZq?=
 =?utf-8?B?bzdCbUhZcHd1QUxXTm5zby9MdHRscm5rb0w1UG0xR2pzNnZpaWMyTWVLRGVp?=
 =?utf-8?B?eThtcXRiN0k4cjN3dFBWZXpSQS8zL1JQSWovU05DSFV0Si9Vell4d3prNlkv?=
 =?utf-8?B?ejFDNzBVRFJKZHNWbnN2RVZGMmhmdEQvWmdaZWdyMzN1cUJnbVZxSUZXVmFk?=
 =?utf-8?B?ZmZZVXJHbHovMktZcGhOL1F0RzNmOWFGMkZSZ3d2Nk4wdVljN1NtQ0xRWXI1?=
 =?utf-8?B?MEZkUzQ5blRmdGpKeHJadUVyNGYzN2hhbVhuRHRrNGxtQW1wclJVaXNCdzlq?=
 =?utf-8?B?YmprQnRmVHhHTWtQUlkvM1VoaGdoUFZVc2JyZEl4WHR4QkZKaFZ4eSt4MjJy?=
 =?utf-8?B?OUNnRVNCeUM2Y1RRSWdzMEpOVkM3K0NUaWRRMjhwWnprZ3dxckVmakFkUWpW?=
 =?utf-8?B?d3V6K3ExTW5XU1VaUGZFOFBLbkpXMUJGMmtQTnNtcldtUDEwTUhFSEVCOUl3?=
 =?utf-8?B?bmgzcUMrSFpVTVRrZVZlYjlwRXQ3dVpXQnFadGwrQ2lNNGErbWVkaDNDQUQ2?=
 =?utf-8?Q?lWpZabetFBxgGLxZ6drzHL+uG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d860492-6b90-463b-6eba-08dbc8bf0f74
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:58:33.0826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtGqxvM3SQ72VTjOgvtcCxLFRxfD2bcGxmAaKoEnVYCJuICtb+wfgZ8/TfUrN41g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9053
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
Cc: le.ma@amd.com, shiwu.zhang@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/6/2023 8:11 PM, Asad Kamal wrote:
> Use gpu_metrics_v1_4 for SMUv13.0.6 to fill
> gpu metric info
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Series is:
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 67 ++++++++++++-------
>   1 file changed, 43 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index ce971a93d28b..3a07f1c95e45 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -279,7 +279,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
>   		return -ENOMEM;
>   	smu_table->metrics_time = 0;
>   
> -	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
> +	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_4);
>   	smu_table->gpu_metrics_table =
>   		kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
>   	if (!smu_table->gpu_metrics_table) {
> @@ -1969,22 +1969,19 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
>   static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v1_3 *gpu_metrics =
> -		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v1_4 *gpu_metrics =
> +		(struct gpu_metrics_v1_4 *)smu_table->gpu_metrics_table;
>   	struct amdgpu_device *adev = smu->adev;
> -	int ret = 0, inst0, xcc0;
> +	int ret = 0, xcc_id, inst, i;
>   	MetricsTable_t *metrics;
>   	u16 link_width_level;
>   
> -	inst0 = adev->sdma.instance[0].aid_id;
> -	xcc0 = GET_INST(GC, 0);
> -
>   	metrics = kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
>   	ret = smu_v13_0_6_get_metrics_table(smu, metrics, true);
>   	if (ret)
>   		return ret;
>   
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 4);
>   
>   	gpu_metrics->temperature_hotspot =
>   		SMUQ10_ROUND(metrics->MaxSocketTemperature);
> @@ -2000,30 +1997,38 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>   	gpu_metrics->average_umc_activity =
>   		SMUQ10_ROUND(metrics->DramBandwidthUtilization);
>   
> -	gpu_metrics->average_socket_power =
> +	gpu_metrics->curr_socket_power =
>   		SMUQ10_ROUND(metrics->SocketPower);
>   	/* Energy counter reported in 15.259uJ (2^-16) units */
>   	gpu_metrics->energy_accumulator = metrics->SocketEnergyAcc;
>   
> -	gpu_metrics->current_gfxclk =
> -		SMUQ10_ROUND(metrics->GfxclkFrequency[xcc0]);
> -	gpu_metrics->current_socclk =
> -		SMUQ10_ROUND(metrics->SocclkFrequency[inst0]);
> -	gpu_metrics->current_uclk = SMUQ10_ROUND(metrics->UclkFrequency);
> -	gpu_metrics->current_vclk0 =
> -		SMUQ10_ROUND(metrics->VclkFrequency[inst0]);
> -	gpu_metrics->current_dclk0 =
> -		SMUQ10_ROUND(metrics->DclkFrequency[inst0]);
> +	for (i = 0; i < MAX_GFX_CLKS; i++) {
> +		xcc_id = GET_INST(GC, i);
> +		if (xcc_id >= 0)
> +			gpu_metrics->current_gfxclk[i] =
> +				SMUQ10_ROUND(metrics->GfxclkFrequency[xcc_id]);
> +
> +		if (i < MAX_CLKS) {
> +			gpu_metrics->current_socclk[i] =
> +				SMUQ10_ROUND(metrics->SocclkFrequency[i]);
> +			inst = GET_INST(VCN, i);
> +			if (inst >= 0) {
> +				gpu_metrics->current_vclk0[i] =
> +					SMUQ10_ROUND(metrics->VclkFrequency[inst]);
> +				gpu_metrics->current_dclk0[i] =
> +					SMUQ10_ROUND(metrics->DclkFrequency[inst]);
> +			}
> +		}
> +	}
>   
> -	gpu_metrics->average_gfxclk_frequency = gpu_metrics->current_gfxclk;
> -	gpu_metrics->average_socclk_frequency = gpu_metrics->current_socclk;
> -	gpu_metrics->average_uclk_frequency = gpu_metrics->current_uclk;
> -	gpu_metrics->average_vclk0_frequency = gpu_metrics->current_vclk0;
> -	gpu_metrics->average_dclk0_frequency = gpu_metrics->current_dclk0;
> +	gpu_metrics->current_uclk = SMUQ10_ROUND(metrics->UclkFrequency);
>   
>   	/* Throttle status is not reported through metrics now */
>   	gpu_metrics->throttle_status = 0;
>   
> +	/* Clock Lock Status. Each bit corresponds to each GFXCLK instance */
> +	gpu_metrics->gfxclk_lock_status = metrics->GfxLockXCDMak >> GET_INST(GC, 0);
> +
>   	if (!(adev->flags & AMD_IS_APU)) {
>   		link_width_level = smu_v13_0_6_get_current_pcie_link_width_level(smu);
>   		if (link_width_level > MAX_LINK_WIDTH)
> @@ -2033,6 +2038,10 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>   			DECODE_LANE_WIDTH(link_width_level);
>   		gpu_metrics->pcie_link_speed =
>   			smu_v13_0_6_get_current_pcie_link_speed(smu);
> +		gpu_metrics->pcie_bandwidth_acc =
> +				SMUQ10_ROUND(metrics->PcieBandwidthAcc[0]);
> +		gpu_metrics->pcie_bandwidth_inst =
> +				SMUQ10_ROUND(metrics->PcieBandwidth[0]);
>   	}
>   
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
> @@ -2042,12 +2051,22 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>   	gpu_metrics->mem_activity_acc =
>   		SMUQ10_ROUND(metrics->DramBandwidthUtilizationAcc);
>   
> +	for (i = 0; i < NUM_XGMI_LINKS; i++) {
> +		gpu_metrics->xgmi_read_data_acc[i] =
> +			SMUQ10_ROUND(metrics->XgmiReadDataSizeAcc[i]);
> +		gpu_metrics->xgmi_write_data_acc[i] =
> +			SMUQ10_ROUND(metrics->XgmiWriteDataSizeAcc[i]);
> +	}
> +
> +	gpu_metrics->xgmi_link_width = SMUQ10_ROUND(metrics->XgmiWidth);
> +	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(metrics->XgmiBitrate);
> +
>   	gpu_metrics->firmware_timestamp = metrics->Timestamp;
>   
>   	*table = (void *)gpu_metrics;
>   	kfree(metrics);
>   
> -	return sizeof(struct gpu_metrics_v1_3);
> +	return sizeof(*gpu_metrics);
>   }
>   
>   static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
