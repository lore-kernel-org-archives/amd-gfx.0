Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A00CD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 12:56:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F58E10EBAF;
	Tue, 16 Jun 2026 12:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y4nsJNN4";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CE0210EBB1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 12:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJpS6Vh9uDQmZGxHOeMhgIK8i+qAPgurVox4DBjl8WsYYT3osGfQ+dwMuqOvIRh21vkbdmJa1NhR4E7Y+/h5Qh6ltzZd73XUcUfWViuNEDW38pKbsj40wEWTquaVFX3KUg0Y0mP7KD+WXg61t/iX3to5FiGcSqh8Uza5gap8SZi34tyj7PfHoI59v4RmZzf8Q5MoLm/315S9/OwoZ46mla3sUnWpmb+ruOTCIVQxPkwpvSl9bmOYlTOOakY1GghbCbKf6Bv7z22ovGuMICQx61fM45RHbqB9t7lMtHZbZ/y9UfNt+IvV57UjdFHNRlJhsqHZFNvuS3B1HSnmBYtq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/VLOhkW4VCeCORXUKiXoynGjHDAL/MTnQySpOufR7w=;
 b=MHp9CRi4FKHj9wR+USUWSo+ST+c3/nmzHnJZ0SPUKN5Tz5i+PaMiDCjSxof+/LmEWDQQdsqNil/FRuvm9z4eNWHjVIN/lnzY/YUPP1ujzLjH9gVXSiGILeBWJY2OYezeM/nGhhKVyHQUYFPvYjlsF6jn8RzsnT0IZqlY7lKiDCplUf5PwL9QCbHna9fFjIDKcgOEiXm9FEvgkOv5yjONkfWLcPBleJ9OFdRQrgevcSbFXTNkdDU2OUfbtmrcQfoAenCd3vQXA5FW47mWZT6AWTUCutDhDg06SyTvJEAL9bOpiQwu73BOmybd1NgWDXZAbhYy2NGIK/iPrPk/dSO0aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/VLOhkW4VCeCORXUKiXoynGjHDAL/MTnQySpOufR7w=;
 b=y4nsJNN4FdAgQI9OxkKKhtpiKD80WYqHH0ToAYpLZiVx+NXTGD7X62gjJkuLz8AQ0+wCjn1fctBm1uCbiPmoe3SjOXMjwBNs31Y4f53YBrPNgjNwr8fuJxVPn7g1n8BeAeZubFNz7pmeWl8Vq0L4fGYRYqoUpObYHwYkrX7Ot+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:56:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 16 Jun 2026
 12:56:19 +0000
Message-ID: <d4ee58f2-f515-4726-ac7d-4e412e622b0c@amd.com>
Date: Tue, 16 Jun 2026 14:56:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm/amdgpu: set the userq xcp_id
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Pierre-eric.Pelloux-prayer@amd.com
References: <20260612064223.196556-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260612064223.196556-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ee2cad-dbd9-450a-8efa-08decba6a8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9mDsJBNqFmmaM7TMRfXxIuqo0QtRZP4vGs5lM8ZJA8G1mIZz6QHM4I6mfGE2KeBpS6FwLbWk/eHE2yAnm9xuSL0ixWd8g6RrCwbog6yKOBiqkFmk6rJCyLYyscD96+i3D4tvNZ5hd1PsRgXvSXifZxLhedc7Q+qN8IcmRtAieZEb8a6muYTFSJcIQwA0wVXBMMp4JXm0Q5E55bhkK1ZKOo5imC6RdBPv9zut1HKslmw3QYEpiPQ1Brkd7kgkX16VGcer9szHfaLfzxmWMolG8oJxFgZ9mapQXmZVz5s2KnbgJ6GmZnE+zGobhRb25muybL6fJyiuSDT6ecAjfvLruT1Y0H6n9nmb3Tns0V9rqkoeedmTHuSFAw4X9D6xi1gejQ1GMHGil0OG3un4GR4o37W+aArlnvzmahXokIG2LtmhzfDOiVhas9M13C+c0GjASXPiJiebvM7BX8kpJgt082yBfE5MpuEnERb/wHlyuyAg+vPPlZfzPcCj+E7BCoSGFRJM4+b33Nfj+z9QagLWFCWpddhYg4X/J1ktakbp78p+lOtuo31FENtTfH3A8NLNju6iloXN8mcBQoOO7yH3kKSLsD4jwWmADvuGae/hfesFatCDtRtU54iPlzqEX+JotbOBPEzq9ToLAtyaUOMTKkyEBv7pLEFitLFISarhMFDDwM4G/HrqRvICL44T3nyv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aThhMC9xZEY1cmt1MjZhTC9zQ09IeUxVbTVxVmtyalZ5bmNad0pBT29tYWRN?=
 =?utf-8?B?ckhSSE9qUENXUTlieUhWY2Vpa1RjUGpCMFdvS05LbW5wTzFaNnZBREJuMzBx?=
 =?utf-8?B?ZVRJVzRLOVhaa2xsdmd0K2dRRWxzZXQ1am9HUExzNDRBcHd3MlI2WHp0NFg1?=
 =?utf-8?B?cUs2Y3VKRkJuMG1MeHBlS0hCSjhMK1BMWC9aeFFteHJ0THRxd3g4ZnMxb3ht?=
 =?utf-8?B?N1RzbVJWQTdqR2Z3YXQzTkVHS2FUL0ZTOGVYRit2NWkyVTgzN2d5NGtMQmlX?=
 =?utf-8?B?TG54V3NHT0t1dzNYWkp2V0JFRzkwZHhvSnhXRXRyRTlVaGc0bmtmTi8xUUNP?=
 =?utf-8?B?Mm83djErRE9udWtQaHFwU0gyb2RTbUM3UXpWaG1kWTBqTEdwYk1IRFd2Ky9n?=
 =?utf-8?B?aU4yQzRvY2FqOS90cWRub0s5amI3RFY0MEJCVTRIb1RxVSt5NVhNWENmU3dZ?=
 =?utf-8?B?VjZZaGhNUDk0a21HUlZZQU5DUytUeEJ2OUgvU1hyZVdCUHZVUjQ5UGppbGhN?=
 =?utf-8?B?ZG5jbUNaQmNkVi9hR0tOUUVFc08zWkVvNFN3cWVqZlliK2dpVFlkZkVZNDVU?=
 =?utf-8?B?cTVWRVFxeHBSTDFoU2IrVFZJTWg3TUFOOWMxSi9vRkZRaXVYdy9XSng5V3ho?=
 =?utf-8?B?SlJNbnNXOHRkVTEvZ0ZDQmFNYWZzcSt5UmFJL1ZkV0kwT2kyYnp5cUtzcCtB?=
 =?utf-8?B?WWV1akdiRS96ZDllUDc4cjJjdUpKam1TalJPcVlMZ3VZVVBaYnhGQUVhdmhS?=
 =?utf-8?B?Tk0vZ3h1Qy8xNU9EZk9relJHNnRLQ1JIaVYyUWx0aDBIMjltZlBoMm91c1R2?=
 =?utf-8?B?eTVnYVB5VzVLUlhMdTZ4cW9EM3Q2dTdxdGNVVXNsT3dnSUhaR2g3QzU2cnF0?=
 =?utf-8?B?OFc2NzZrdlBsNUhJc1ZzS3JIK1hGbHF0MUdPNVFCcDdpTlFIMEhDcnVLVU00?=
 =?utf-8?B?ZC9kQmhJVXpWejdiSSsvOTl5b25CWTFjK0h2RC9iVDhONnIwbWgvb3pZaWdI?=
 =?utf-8?B?aUExVTBzWEY1K2xNV1hpQk9meFFqMDA0Z3hhK2JNTytiK3RVOEFBZTd1UGNI?=
 =?utf-8?B?d3RBYSttUXpnL3lpWVN1WXRRZFArZTNaSDY1Zi9rTVlBT0hmNERHWlg1WkRw?=
 =?utf-8?B?Y1dtNHlYR0ZqSFZQVjlHUVVoeHZkcWR3ZHhBMzhvek9scnE1Vkh6WEJoOHhM?=
 =?utf-8?B?U0tRRzhNOCtWSCtnT1hucEwvdTM3U2phOUxhSmhWbGJzTkJqdTBhOTdRSXB3?=
 =?utf-8?B?Y25NdFdxRllLNVZob3M4TlJMc05nNE9lK0tFK20wa0s2SFROWURkNUk0NDFq?=
 =?utf-8?B?ajkzOWdBL1ZnQkxSWlFLaCtua2NTZFJQWHBHaFRjMVJZMnZKMWJjaUx2ejZo?=
 =?utf-8?B?ZHpVVENjRnVCU1duUGRlNlB1TW5lMUJMak5lK1BmWnEvZ3c0SDgydVlrbkFy?=
 =?utf-8?B?YkVmODVjejZad3JIN0IzTmNiK1ZnS0piRE9NdnR2RkRoTnR5b1hoUmx5VVpL?=
 =?utf-8?B?NVhvRWJVcGplcmVLUDJ2bjRNeGtZbXpLdSs3L2xmZlV2OTc1MnVEYUluLzRk?=
 =?utf-8?B?WEZtcy9JSTVYZDY4YTU3SEw5YjRWTmJCL3ZHWlFnSHlSRDN5S0VBNUNLN2Ru?=
 =?utf-8?B?SzdTcEl4ckx2RWFKV2F3V1FYTUpyMEN2UDRzYmlsam9jcVZHY205VEJ6Yk96?=
 =?utf-8?B?bVkxQ3p3ZkNuOGlxZjZlVFkvd21YVWpKMzBBcko2eUxBbCtXQkYydGQvSWUv?=
 =?utf-8?B?WjZ3bE5nQ3ArMjk3Mm5uNTZROENSUFZoWmVraHg0MXo4SEFqSnpGakNmUWF0?=
 =?utf-8?B?akVlMEJOdUQvMmdsTU0raXAzZjRLdlQ3ZzVKbTZ3TDlyYVhLeGZSK21VUDZF?=
 =?utf-8?B?NmhpZVFQdFpML2pvK3RkYmdlaWtkeVZyUklRZ0pxNW81Q0VITDVsTkFVMWNi?=
 =?utf-8?B?S0hES3BSdldSWjNhWTZLZGJnQ25Pc0RDWGhhNDJQOHRuZUR3a1NuODZlSjg1?=
 =?utf-8?B?S3F0eUh3YlhRaWdSZ3cxT3ozVERKVUhCR3hwMUg0Y1hKUjQweDVnSlhwVDV0?=
 =?utf-8?B?VXNrZlhnWkNCQzFjZXFkblZGaG5telc5T042eUJXcEtjd1JwWHBTeng3TjVK?=
 =?utf-8?B?L2JKckZNU1QzR0ZxZTdGV2gzUm5LVWNpckdNYkVraXpKV1RKVFBGeDRkN25I?=
 =?utf-8?B?SkJ5aXcrODhCZnZ6RDVwUmUxcFZVZUhQdHhWby9xaHkwTHIzVUJ5ZlkyaDhW?=
 =?utf-8?B?M0pnMC82MFBOUWdmU3g4Zk5LRE1JaG9sSWZ6TjRKV3F2Skhtb1lHS3ova2NH?=
 =?utf-8?Q?NLikWbIziP3wgvs9ET?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ee2cad-dbd9-450a-8efa-08decba6a8c2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:56:19.2159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtLdXY8UyHWUe4rr+5xTZ+KrLPCGEgXzr+6OKaXUmPFNlRRIOx4nojat8LQS0NNc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520
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

On 6/12/26 08:42, Prike Liang wrote:
> Initialize the userq xcp_id.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 3d6b1cfeca24..e87a3d83dd3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -629,6 +629,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	queue->queue_type = args->in.ip_type;
>  	queue->vm = &fpriv->vm;
>  	queue->priority = priority;
> +	queue->xcp_id = (fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
> +				fpriv->xcp_id : 0;
>  	queue->userq_mgr = uq_mgr;
>  	INIT_DELAYED_WORK(&queue->hang_detect_work,
>  			  amdgpu_userq_hang_detect_work);

