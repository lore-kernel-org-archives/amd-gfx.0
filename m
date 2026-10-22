Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A09B606A329
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kMvtcSWp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AE2711267F;
	Thu, 22 Oct 2026 14:08:16 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010000.outbound.protection.outlook.com [52.101.85.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7EF911267F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 14:08:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJ3qA2p9NREy0zeXtp3m9Il68AszeHX9ujW/y24Zxt5jcjkmt6fiBQOda8HrW4YJdBIDCR95EBZT5XTDPGG4w546ZbD5KyXQV4xgq66acg9dqYag35p46dh5f9fMA3UQE6Cr7JW2C2n3iEqWJV7NJKUEagT3bHNVQUd55iylvp09OzEjBLctkv3BOGnpz3onQNDiODtOl/rloXnEuG8h267IiRiZ87YqgwvR7oN05J3QW07v85FMeYdXg2nuEsUOk6y6JIPkTZD553Am1a/qoIgXnWMwI5kxR2NukgtE1Wo5rmpuzyCQW7rgyAviXu9YhYtR9FBva/ZPk1BC3hBqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3S5e8ANoZlBqZqyE8t3a5+Rsx36YBwC+zqQ89szAvaU=;
 b=aLdmqbbZ7OroxewY6De8HMvQYtE/lgt7eL4kCHMlzPy5BV2iDqE4uK2K5mH2BS/d9o7icOKTiW/ijHISz3pdsfGHbQTONV2UxvXaUQge+xVBS9W/1otHtA+AV8QtvCN5DrkEHG3b77+lo3nFvgSzp2hPpccO0ZuvCinQzvG4PtZzS3tKM9ZR2RUtcd9adWDlFK5HCfML+00UwZbIzyKfQDPKBeFT728fG8kQ+Z4DB/gEtAn5OImk0LS6rT6sG0Ab+oHy5zm97cuKKHMV4+EjgOsSych1DouEGhPNbxWQgnUr285on+QdyRK8LasU/cAgU6PcZlLtX28GwseYlmB0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3S5e8ANoZlBqZqyE8t3a5+Rsx36YBwC+zqQ89szAvaU=;
 b=kMvtcSWpeWs4lPvt5EJhTcejZTZ4gI5tQ3CdBZGpup/l0H9m9U7vB8X21hu3Q5UcaYJwaf+F5uEbmBoMdQMLDEW4j8dahg2tvKYcSH8nDnKeIHaFXexdiMbs2paNryhbXkWdSzVo5igyl+TK2rD7UIm3/fhYIJOudo2pAfzMwDU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Thu, 22 Oct
 2026 14:08:01 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 14:07:58 +0000
Message-ID: <de20d62d-8d89-4e4e-bc68-1acd14e1d4aa@amd.com>
Date: Thu, 22 Oct 2026 19:37:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Report SMU 15.0.8 XGMI bandwidth
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, Kevin.Wang@amd.com
References: <20261022123200.2222192-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261022123200.2222192-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0138.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::18) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d98e3e-671c-4348-75af-08df3045e01d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|261021121427099003|56012099006|11063799006|261009223027099003|10067099003|261021123027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iI+WnSW4wvuq4x5wQYlok72mlDmaSxosxgLDDFm2wUU+y5U+Q9pDmWOo9ZmtNkHBudl8bo7M/tcApso7kjPf5qUYqdd49g5FCLrdxnVfUjb/zQYNwpHSd5BQNs1spnSOnvpueIgwVQH5YqO1rAI3UZJPUweqLqrj+al45R49y8MUZUuORFAqAlK/0rCLii++6gLBTwMQQ6jLpxIVVHcL1Npm8ghRl8P+KCPz36Z7PQny9X7GRT8ILvFCND22a7bM2hNMWX+qAOXfOlBHhZz9l2B6uXtqLRF3gJRoi6RHDKqJl2UnRNgb5heodchijYHxhvkG7kpKZA0qqRhlJ2B6VOU6T5xLrTkf2fFQlEPcRFAY2ck2dR32ABsE2tL9pJHNU3KyOYLVBFmY5YhsBO1vGWBCVTvLGJweWAF4UpioMoa0IEvAwj5lznW9n4ihyC+B5oU6hREqWMr0QN5jF6mEZnrZq947YWlTbZ9EtLrcMQNMTWVnRVg/PN3uUL244m88jAlAn2/XRQ0jn331ZQok5hWw5oNdVibHp+h1NERLROns/0jGosptsxP31ESyVK3N2RWxA7RWJdgyP3IsvJH2Gbg8kju7VUNKgixIeFifIPuwt7BiIjUK76YFzok82zr98EefETgM6jivKzvkRSKVUMswHfOW8tPqTOLSfkyW71Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261021121427099003)(56012099006)(11063799006)(261009223027099003)(10067099003)(261021123027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHQ1ZEFidzVMYjUwRXdGT095c2NRV2VMSU9FbEorVWRZQ1M1QzlHV3U2VmI3?=
 =?utf-8?B?ak5ieGxBN3dmeUtRWTVuMndOVTVlMzNxM3JyaENEVEhmdGc0L04vUmp5bSto?=
 =?utf-8?B?OGsxc2xKay9QNFNYbUlxTDdUZnhpU1R5d1BGOEZ5WCs2a3FRR1R5R3ZiZ25M?=
 =?utf-8?B?QTl1ZlEyd0NPODdpWVdoYjlxY0JUNTBTaXlFQTJZaGRlMERkcDVQNlRDRTJz?=
 =?utf-8?B?TElZaXNWaGJVS1VsOGYyVTU1eWJ3WWZMQjdFVHlsZDJTM3JKOU1oWGhzQmk4?=
 =?utf-8?B?eVFJejBlS1Z5TkNteDZjYndrRGUyUGJNcEdmOVQ5ZnMyRWRHRWViUUx2TnVo?=
 =?utf-8?B?dzJNbWFWaEc1eGgxeVBXWFROQkpmQUlIb25XZjFhcGxJck9sd2FJUUJuWGk4?=
 =?utf-8?B?TDhOTEprTGFqWWhlY1JCbWxSSE52SldTQVNDRFlMakRRYkVsQWNpUWhDTU5v?=
 =?utf-8?B?aFlHTVdoQXNOdzhxdFE4cWtCQUJjeDFzZUEwY2V2alNwejhUUG54Q3dQK2gr?=
 =?utf-8?B?TnM3aFU5MVp0eERJNDdxbjcvbndScXRoZ3Q0eEdwWFltSVpSeUpnai90WTcx?=
 =?utf-8?B?U3UwM21acmFJM3p4TUovaXpHQlNrMEZzcXpnd0IvcGg0UXhxdWdIUFpJSDUw?=
 =?utf-8?B?cTZ0UXFxRU5wRVVYQU8zNkc2UFNZRU5FZklHREtQbDhvb2pLTzErYmh0Q0ZJ?=
 =?utf-8?B?UmZyK00rbzVRNEgrQVFJZ2tkNW1Yb1krVHdGM3o5eGZvcTEvb1V4cXI5R3h4?=
 =?utf-8?B?NVY0ckI2bXpkQXlXVFp5NnFEUnpINFhaRFlKWm40ZWVrcDRhQjhIYml0T01N?=
 =?utf-8?B?MzFHUEtHZzQxM0htSnpsTHFhcFpiUlNPYzE0WlBITHgvMm9WSnlnbWZtTDVn?=
 =?utf-8?B?M3h3bllXakdkc0V3ZUlEZ1FpbkVOTlR1M3RJbEg4d2ZtUU9PU2xCOGpEYzYy?=
 =?utf-8?B?SnFNc2dSSFJlemF3WmR4WlkxU0RlWUUxQmVDTmI5c2RsWEl4QVdqbzFkZnRi?=
 =?utf-8?B?S2JpcTErUFpTQzdJd0lOTU9LT2dtMTdhek9MeUd6V2R4WjVXUnBoS1JRRHF5?=
 =?utf-8?B?MU1Wek1ObCtnN1N5MmhiZ2lJNWEyZFVaK0V4QWtzbVJRWTBsYTdKbkVrZkZw?=
 =?utf-8?B?QXh5MU5OUi9IVVdVaVVlVThqb01kRU1nWVBoZG5MWU9GMTF0RHRLZDlOTUpv?=
 =?utf-8?B?elRRODZab2x3dUUrOEFrUERDTUwxWkVvVHNrODBndENFY1lQQzhSbUMxbzd5?=
 =?utf-8?B?QWN3ZmpMWjdrQ05nWXc5aks5Z2VacmxFRTNqWHBSa3VUWnAxQTlzbmRlNW9i?=
 =?utf-8?B?Rng1VGNmdkZtQmIvU0taQ2hWbS9nTFh6MnJMZ3EyYXJaRmg1bVZVZGQ4b2pE?=
 =?utf-8?B?d3FKc0VhM2ZPbDhlbjdTU3YxUEFyYUFDTTlGbExMSDRxK3RaY2RZbDdTemdU?=
 =?utf-8?B?M2o4bExjUjA0SWJyNmFlVVlkMFRWWFNJN1JUdlhRdG5NeFRlcE1zNlR5RVh3?=
 =?utf-8?B?dkxYQ01YTmRZa3NkOUtEWmJQekdXSlVsU3Bkek1UbG10NEZJQ3NmS2NiZHM2?=
 =?utf-8?B?U1ViN0s1c1Rtb0c1d3h4N1BSWHBkblY3clU4YUtFeURlaERNSE1EdGFyeHpt?=
 =?utf-8?B?d1pDS3F5Ky9WbkNEYUh0ckpkUkYxS1JZM243QWtuNzVwMFRPK245K0FsV3R0?=
 =?utf-8?B?cnNUOHlFR2JRZTBRZ0Z0MGVGSFMyYmZ4dHZHZ2FwclExZ1EralRSOEJsWUhB?=
 =?utf-8?B?enlzbDhXRFZFRVhZMEFxb3pGamlXT2k1aWp4NXpubzIzR3V2MUFUTmtlMEZl?=
 =?utf-8?B?QTNRL082aVpzYjh1WkNSK3QvN0p4Q0VFdzNWWWFIVHYrb05ZVEU1QzBueWFw?=
 =?utf-8?B?Z2xocUpPYVA5aGRySmlkaVdDYklxTmowSnVKUkh5bTRJNlI2MkFxT0xpU0Vj?=
 =?utf-8?B?c0wyWUhveERZa1ErSmFxd1QzZy9ycUY5S2NrUEpTdiswTUVoZTBSWktXcjFn?=
 =?utf-8?B?MmtsZmRqM0xEekJnejJvZzZBTGNlelZ6WlljeERkaW9BVGo3Y0pabjhCS3Bn?=
 =?utf-8?B?OXZpLzZJMzJvbVU5VklzV05TdC83U1ZSdVBjK09rMWU4YnNyUkxmenZZS1pk?=
 =?utf-8?B?UTZBNUU0Q09td3E0Y2NFVE01cUR3NUVVVnlXWHJNMngzZXVlcmpQV3liR2M0?=
 =?utf-8?B?allHb3E5dnc0RjExNVlXS0pYdFJCbGJQNWJ2VnVZMHZmcDY0VTliUTg3RDNh?=
 =?utf-8?B?VCt6cm1jZGdFaFFGYnNEaXB3K2ZMY3ZMQ1BaalI2WnV1citwM0dBcEE0NGpB?=
 =?utf-8?Q?VaZrh7fdxZD6WEl0zw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d98e3e-671c-4348-75af-08df3045e01d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:07:58.4836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsCsJVP5PLIhQyXcXQINwi4Qs22pz60X8qBNpzZk9HA87QX3NsrrxbIlN6X4fK3f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 22-Oct-26 6:02 PM, Asad Kamal wrote:
> SMU 15.0.8 firmware reports accumulated XGMI read and write bandwidth.
> The driver publishes those counters as transferred data, in KB.
> 
> Publish them as xgmi_read_bandwidth_acc and xgmi_write_bandwidth_acc,
> with unit GB/s.
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/include/kgd_pp_interface.h       | 2 ++
>   drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 6 ++++--
>   drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h | 8 ++++----
>   3 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index f92bccb8cb41..17f76071b514 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -685,6 +685,8 @@ enum amdgpu_metrics_attr_id {
>   	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_OAM_4_5_6_7_3V3_VR,
>   	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_IBC_HSC,
>   	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_IBC,
> +	AMDGPU_METRICS_ATTR_ID_XGMI_READ_BANDWIDTH_ACC,
> +	AMDGPU_METRICS_ATTR_ID_XGMI_WRITE_BANDWIDTH_ACC,
>   	AMDGPU_METRICS_ATTR_ID_MAX,
>   };
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> index 2254c2d414d2..bacdc1a2dd38 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> @@ -2041,8 +2041,10 @@ static ssize_t smu_v15_0_8_get_gpu_metrics(struct smu_context *smu, void **table
>   			gpu_metrics->xgmi_link_status[j] = ret;
>   	}
>   
> -	gpu_metrics->xgmi_read_data_acc = SMUQ10_ROUND(metrics->XgmiReadBandwidthAcc);
> -	gpu_metrics->xgmi_write_data_acc = SMUQ10_ROUND(metrics->XgmiWriteBandwidthAcc);
> +	gpu_metrics->xgmi_read_bandwidth_acc =
> +		SMUQ10_ROUND(metrics->XgmiReadBandwidthAcc);
> +	gpu_metrics->xgmi_write_bandwidth_acc =
> +		SMUQ10_ROUND(metrics->XgmiWriteBandwidthAcc);
>   
>   	for (i = 0; i < NUM_XCC(adev->gfx.xcc_mask); ++i) {
>   		inst = GET_INST(GC, i);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
> index c3835c81d313..8c7e808aa8eb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
> @@ -146,10 +146,10 @@ typedef struct {
>   	SMU_ARRAY(SMU_MATTR(XGMI_LINK_STATUS), SMU_MUNIT(NONE),                \
>   		  SMU_MTYPE(U16), xgmi_link_status,                            \
>   		  SMU_15_0_8_NUM_XGMI_LINKS);                                  \
> -	SMU_SCALAR(SMU_MATTR(XGMI_READ_DATA_ACC), SMU_MUNIT(DATA_1),           \
> -		   SMU_MTYPE(U64), xgmi_read_data_acc);                        \
> -	SMU_SCALAR(SMU_MATTR(XGMI_WRITE_DATA_ACC), SMU_MUNIT(DATA_1),          \
> -		   SMU_MTYPE(U64), xgmi_write_data_acc);                                  \
> +	SMU_SCALAR(SMU_MATTR(XGMI_READ_BANDWIDTH_ACC), SMU_MUNIT(BW_1),        \
> +		   SMU_MTYPE(U64), xgmi_read_bandwidth_acc);                   \
> +	SMU_SCALAR(SMU_MATTR(XGMI_WRITE_BANDWIDTH_ACC), SMU_MUNIT(BW_1),       \
> +		   SMU_MTYPE(U64), xgmi_write_bandwidth_acc);                  \
>   	SMU_SCALAR(SMU_MATTR(FIRMWARE_TIMESTAMP), SMU_MUNIT(TIME_2),           \
>   		   SMU_MTYPE(U64), firmware_timestamp);                        \
>   	SMU_ARRAY(SMU_MATTR(CURRENT_GFXCLK), SMU_MUNIT(CLOCK_1),               \

