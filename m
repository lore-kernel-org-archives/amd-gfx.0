Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797A3C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 10:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D32410F4ED;
	Tue, 10 May 2022 10:15:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 052E010F4ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 10:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZO7/Rx5HDOin68gfy2aksD5UKAsuy9EzBR7SRFidAW7Ll/yxSs4jlWTfH58Ht12Eov9X4xDBjxFYAqBlnwC7WAFF6eIW37dp/wDarWP68IXdfEzXGdu8S/+xw0Iw51ov9OHyuBtfj18VZFM03hTuw2ITxGVq7393qxHg0LKfOC6eKoKEBlX49XCOOmVZ7aNmsyVbAQ+7Uyl/SiZCiHQz0y27n3ifHy8XMGbkVViC25DCADBPqZ1JOeNGNEZJNsl0lC8gQzmpPm4g0M3Myls+5amSvLab5436rHUc4QtoTfOaT7IxQNas0loG66p5sI+FFnuMdTsXs14MgQJIMxLzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbuZNQehblIp8ArQYBIuuS1pemXRA8wPVSjZnW8xgYw=;
 b=kHJM4KRCkG/ax+VLSByz4rr2Nrpcf7k38LgxxQu7t2dqt4K/qYRBwkA4pj9sNbr8amwt9B5XIZGAiHjFQ//bqKnLQLcO91pZSqzn7oSJq7LMVrAoMXwyZi+pehSV1qCDJr+mQ3v6UKuR3213jRO91ODOQtkR4nmyVpcSxE2xWuBgPXtspYhgDO8o338PoWyGsAQ3wGV6MeAb04cXcHRpk0ZPtX/n/ibhD5YVoGyDzv/1Q7BwckJwyJgZYpbPTvKDepqkTfTmzdotbifJt3oQHJN3knzy8VNCSYmz9Ym/Pf2xomb7HDIxlW72IwGS2ss8NSboHmHdq+mrXuDR6UGyyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbuZNQehblIp8ArQYBIuuS1pemXRA8wPVSjZnW8xgYw=;
 b=Kybot7yXMX2/8c+4Q41rOt1ZQumms2Vy0I8TmQeP8JBG35d2Uh2FcWvmMzWKY88wad46L+t9jhYtCSEYaVKHOgiMzWibnMWFEzwK9qX2/uSORHSs0lAMhdeUwstWHxn6vxOA3ki6W77mQYjoTFwqKUND4zQW2RTDZRIAMGgfjtY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 10:15:07 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 10:15:05 +0000
Message-ID: <65199aec-f613-215e-4945-7442bd46e027@amd.com>
Date: Tue, 10 May 2022 15:44:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] drm/amdgpu: refine RAS poison consumption handler
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 Mohammadzafar.Ziya@amd.com, hawking.zhang@amd.com, stanley.yang@amd.com,
 YiPeng.Chai@amd.com
References: <20220510062950.11792-1-tao.zhou1@amd.com>
 <20220510062950.11792-2-tao.zhou1@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220510062950.11792-2-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::18) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b73914e-6ece-4af7-d5d5-08da326df3ca
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB63634974BF873B23F25C8C8D97C99@SJ1PR12MB6363.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHPBYPCkJsLtv6Me4ay11Zg4K+Iv2GxxMt6PC1ArQ7z/YhcuPTm/b1IcTlXXj7Do1bYiFsss0LNplA3YwxTCVRHNaEFhWT53JgSG55lPC8dCzbjN7xjU+DHG2C1Dpec+Y8WopQRGiOVm+zPHPav0VaxnnWPaO+j8vxL8B8ff928XM4Upkxi0HVdrFb6Ot7SrrCspYzv4jgpWCObEnsImfJDC3Q2dsAA1FTYfWvRQ8OIRytWTKP7dBOiW7YkjRWa17ftNCqT7gk2dYn1AmH7i5L5BLn3FMiVjgTVXAFBCVRr6pgH2z6UcylVNWY7CLOoZPpzyR6sJoekQEX+y9ap+z9u92fss+VBqYhkQhGy1wZi02O1Q6faHmt02atz5cAMZtXc5/RhJ/MHE54dDQ/22EL2TNzN7X/JUvuyKK9GsWre3dfbdFcYFUIWvMWHu9HhUNvlec57oJS1hGUzuOYz947icHkFILbUAJUQfZhoOFMdyPoYFcpDlMsFdNQUWClTNp1TaEtOmeQyoChL9jpFP56OMpopL3DCnkG/7G6jlWp780FbJc76i9YTFSKMaNQUMtV6lALrSP1hxwFCN5glGaqOU3jB5OktFhsJg5PxnExJ6N/zLXZxFKcQGu9WBasSc0XkI85esIDm+MVW54bl2XJygBXA1rgRyyRMyTFpIQJZAQKH30hU9K7znWPbXBoa3+NRpaAO6lYLQCIHalCjS+wszIMAI2Yrh7nFrttyzQ3lOr3gXbWioiOIfoTgsWWSsAwAPizqwij7Vr948HlNkWwYFRoystKgbnfohZh603fA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(36756003)(2906002)(31686004)(5660300002)(66556008)(66476007)(66946007)(8676002)(86362001)(38100700002)(6486002)(186003)(31696002)(83380400001)(6636002)(2616005)(6506007)(53546011)(26005)(316002)(6666004)(508600001)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUFOMzhwbjgzS3g3dDhsdGZibEN0STIySjNROFBnYUtXN2xVU1dJUTJ3T1dr?=
 =?utf-8?B?Z2RJa2FmN0JTYllSQ3dZRGZ4bFc0WTZVNEQyVjIraFFtQUxoV2Uxb2dxM0RW?=
 =?utf-8?B?djdYU0c1a0dFSFV2L2FZeGx5VENpTGdoTC9NYzJqZURkU29NelUwVkpKS2tZ?=
 =?utf-8?B?NDV1NnluRUcwL1hiS0dxcG95ZG1mT241d0Q4SjNOUzZDZ3dycmV3SnBQVEox?=
 =?utf-8?B?VERVelpZZ05XbThsTUE2RUJrbGJDRjMxYUswTjk3QzV1cmEvT0ppQlFWTzNl?=
 =?utf-8?B?RTFyWUtUVncyYkFuZzBpZGZwRGVVNkZGYnJ1azRtY0ZPek9DNStVWmY5aUs4?=
 =?utf-8?B?eFpzVWxsOEVraWpHSkJCek5CMWUwci9aQzIrN25TaEJweUZaLzF2SDIySFJC?=
 =?utf-8?B?Qmp1dU96QW4xVHNHSG4yc3MwRkE4Qlh5c1A0Um9QVlBKU0Y4OStjUnBpSS8z?=
 =?utf-8?B?ZHpyL1ppTDV5d1VSdzVZU3V0OHQ3YVN6MktLUStwL1ppekVLMFNvVitoVTBp?=
 =?utf-8?B?QThSNXArMTdOb05lSVZuNkVwQkdjdWNpTS9tMXJXbGRvRSs2aGNTaTFzREVU?=
 =?utf-8?B?TEZ6V1VPdXQ5aVFsUmJJL0VDdVVmN3RjVjhGUEsyRnBpRk1TMmxaY3d1VGxj?=
 =?utf-8?B?NVYwYXRFSEhWYnNyN2VuMk9GekpraEZUaEhZS0lURXNwU25jTjJVYU5TaFlv?=
 =?utf-8?B?UEF4bllxbUh4TG94Nk9NSUZZSFRabXFtK2pLeERjNGtURm93RVFDU28vOWQw?=
 =?utf-8?B?SUZqd2E3MnkrczVWemc3RGNkTHBTTnV1TFZXTEduZy90ZTUremNqeDNDN1Zn?=
 =?utf-8?B?MUpyM0lRWWNOTHRZOThha1d3TVFWQzB0czd6bnoyemVzNzduSkVLUWhvaWFu?=
 =?utf-8?B?TE55S3pvWmpvTUd6MWFzUmxCTnhzUmZDbnlhK0FZZW9LRHB6bDlTV01iRWMz?=
 =?utf-8?B?REpwcVhsQWhWd3psRHY4WktYaHdQMjhCS1JteHkzNUw5aHRFQ3A3c1g5MFNV?=
 =?utf-8?B?QkxNcEpHeXZQVGoxaysvK2RVaEtwU3oreGtrNTh5N3k4bnJJSnlhc0grWkQ2?=
 =?utf-8?B?MCtlOWZKdGZkWENMZ0NNZ2ZrMVFQZVVFY0M0SEUzSUhMY25kdTdUc3JGRHcr?=
 =?utf-8?B?ajZlZUt2WktaYUdLUUJIc1pmcXZhdElieDUxV3dPOWtiZGdrdDljenczMmxL?=
 =?utf-8?B?TTd0eWRIMXhBSExNWG16bnJWTWc0eitDYnE5Q3NNUWlaYWRkM0tGRDhGeEtN?=
 =?utf-8?B?NkhvaWdudTdJa3pvR1lUM2ZmL3ZkSUpxc1hTaDRRV1ZtM0NHamhGWGFpa1hr?=
 =?utf-8?B?clRVSTRyczhLYW9aNTA3cXZndVNGTkFMN3JNMVlDSWloNXh6aktpWCs4VVQy?=
 =?utf-8?B?VG91L2IxdnE0VGJHeTgxbHVxSHhxT2s4b2Zoeml6T0lGR2hSUDI5WGlmWmNs?=
 =?utf-8?B?a1ZkRkQxU3U0MWtOSWVBRW5ZOEVJQ2RMZTBlRCtRM1N1c1lFM1lwV0haZjQ5?=
 =?utf-8?B?RlphbU5pS3g1dFlIdWs5TG9KeXZNTmFrV1VRWUdkWEZRQ21EY1d1UFU3MWk3?=
 =?utf-8?B?ankwb05yTkYzMXpKeXhNQmRSZm41ZVpyQlZLLzBqOThqTGVEYkhLdW0rVEVO?=
 =?utf-8?B?cEc5MWZHc081N0YwRStsMzRDN1pOaWtkbkhGYWlWb0g1aXBKMUxFVms2K21o?=
 =?utf-8?B?dHIxTGExUmZBa1hZMFQyc0o0ak9uMjhmNW1NeDZhT0IyT1lPd1VFbEZnZTJV?=
 =?utf-8?B?TFIxeDVUSlRvbjVoK0JETGRhNTZSSjUydkNxR2MxSDFZeXJVbWNlbFF4V2Zl?=
 =?utf-8?B?QW5tUEh0WWZDMGNVS1F4bjFRK2dSL0JyanpBTTFOdUEwWGFPengzZ1NENnA5?=
 =?utf-8?B?WG16bTIxbEVkYU1IWDJnSytLeE5SUE41dGJhWXJMZFJkb1JKa2lzQWMxOTdm?=
 =?utf-8?B?cTN2Q1NCNWwrTXNiMmx2QmdGcFAzYVYzdXUycWhOeFB2a2hqMFVNc20vOENW?=
 =?utf-8?B?VGRhdG1wQUs0VDRHV3VLNHhwbTVrK0VIRmtiTXEycHB4UjYxeExGQVIvb1Yx?=
 =?utf-8?B?d3ArLytzT3lsMnBxMVlaZW1qQTZ4RGhtZjNubjZsTURNa1J5S2Y1b3BUYkJH?=
 =?utf-8?B?YWxUcnVZNTQydmVXd1JDY0lpUDBBVStLVURMVzg3RDBtMlduVnRJMmVmVyts?=
 =?utf-8?B?dXFaVVQ4dlUrVUJjNG5GcXg4dlF4SkV4WHlqTnA5MzlIVUs5S2hKMEhaamlZ?=
 =?utf-8?B?VjlhYzAydUtVK3o0NmxFQno3RG5iK2dBT1g2Wlp3bHFLWFYrbW5PN0tRdVdK?=
 =?utf-8?B?cGVEcWR2TDR5ZWk5dGFaMzJNb1lkZ21XRmJNNklTSjNOLzY0YlVEQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b73914e-6ece-4af7-d5d5-08da326df3ca
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 10:15:05.4014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2BgVp8Bb0JPa5xG6uOnOfBwR0oHlqOL2+zlutq9DLi3KRZ6Lh1qMVBgfTXR5iIH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363
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



On 5/10/2022 11:59 AM, Tao Zhou wrote:
> Qeury ras status before ras poison consumption handling, add more
> comment and log.
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>

Series is :
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 43 +++++++++++++++----------
>   1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 91d9e9969b4e..a653cf3b3d13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1538,33 +1538,42 @@ void amdgpu_ras_interrupt_fatal_error_handler(struct amdgpu_device *adev)
>   static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *obj,
>   				struct amdgpu_iv_entry *entry)
>   {
> -	bool poison_stat = true, need_reset = true;
> +	bool poison_stat = false;
>   	struct amdgpu_device *adev = obj->adev;
>   	struct ras_err_data err_data = {0, 0, 0, NULL};
>   	struct amdgpu_ras_block_object *block_obj =
>   		amdgpu_ras_get_ras_block(adev, obj->head.block, 0);
>   
> -	if (!adev->gmc.xgmi.connected_to_cpu)
> -		amdgpu_umc_poison_handler(adev, &err_data, false);
> -
> -	/* both query_poison_status and handle_poison_consumption are optional */
> -	if (block_obj && block_obj->hw_ops) {
> -		if (block_obj->hw_ops->query_poison_status) {
> -			poison_stat = block_obj->hw_ops->query_poison_status(adev);
> -			if (!poison_stat)
> -				dev_info(adev->dev, "No RAS poison status in %s poison IH.\n",
> -						block_obj->ras_comm.name);
> -		}
> +	if (!block_obj || !block_obj->hw_ops)
> +		return;
>   
> -		if (poison_stat && block_obj->hw_ops->handle_poison_consumption) {
> -			poison_stat = block_obj->hw_ops->handle_poison_consumption(adev);
> -			need_reset = poison_stat;
> +	/* both query_poison_status and handle_poison_consumption are optional,
> +	 * but at least one of them should be implemented if we need poison
> +	 * consumption handler
> +	 */
> +	if (block_obj->hw_ops->query_poison_status) {
> +		poison_stat = block_obj->hw_ops->query_poison_status(adev);
> +		if (!poison_stat) {
> +			/* Not poison consumption interrupt, no need to handle it */
> +			dev_info(adev->dev, "No RAS poison status in %s poison IH.\n",
> +					block_obj->ras_comm.name);
> +
> +			return;
>   		}
>   	}
>   
> -	/* gpu reset is fallback for all failed cases */
> -	if (need_reset)
> +	if (!adev->gmc.xgmi.connected_to_cpu)
> +		amdgpu_umc_poison_handler(adev, &err_data, false);
> +
> +	if (block_obj->hw_ops->handle_poison_consumption)
> +		poison_stat = block_obj->hw_ops->handle_poison_consumption(adev);
> +
> +	/* gpu reset is fallback for failed and default cases */
> +	if (poison_stat) {
> +		dev_info(adev->dev, "GPU reset for %s RAS poison consumption is issued!\n",
> +				block_obj->ras_comm.name);
>   		amdgpu_ras_reset_gpu(adev);
> +	}
>   }
>   
>   static void amdgpu_ras_interrupt_poison_creation_handler(struct ras_manager *obj,
> 
