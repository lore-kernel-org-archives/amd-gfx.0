Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71551C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 14:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F6131134B5;
	Mon, 18 Jul 2022 14:57:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B3A210E82E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 14:57:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZmcqI3xNTmDKdaFOfTHJwvsQOesPN/Z3TT8yucv1iLhl4hPg1gGKsQVAC2TqIDlxoqA5tifCU7cnwNEgJet98WLMFPSV2l9hpsV+b2Wmi1OUDTTBGiCOije4vuVe2nRo/HZ9ODxyPhrN4pXzm7LP4z5SiFm8bLVLQuwZxPrm9P5ZFO7OWU4Px7a58fpPcYRhtIVnDx+J5koWH3o9fbvLpjUhI+UQ/VJaAxXl3NCrNoaL3NFOsOXjjs8SKUyQkzX8e+zAbUIE3JlBUAhxwoW7EpvOQd7LmHCH+EtW9ALzskHeYaa7brNFDzBbqc7Q4YGBIqzci6PaRS2LPL+vj4DZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwF4cZOB1J95AxcQmmRoVcYvG92tNek4fqP/DvfxTRI=;
 b=laXiMq0NQWpVIVU0SE5GWXdm36Mz+1OuNqjXWpZ+nEe/YvIZVDCCO1ckl1uSA7DBETXk0qfoYAs2krV1/l484DEJZFoqL+PGVraBsTGayf8QNJl0X1Lxj+klq6jTpGgpwEkRPhA/gTNjL9LmKs5pYUxC1Ns4hhLW5xmrWlPGraDO4U5w6l1RWlm7nPTTAq+kKxE1HwCdi8Vqa0OeBALOs6Li9/W7skIIN+tlHzJtQPTuGII+znUHJUkQAvBlF5f6XLkZxg6LpYwBDp4l/J6kEREMR7QPTX7i20mcwgPpri5bSDWw/WG9f0bF0Aip6Vqa6ynOBHSNZD3JjCpxENXhNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwF4cZOB1J95AxcQmmRoVcYvG92tNek4fqP/DvfxTRI=;
 b=AymxX7hPQojSrkZtmd3+aAz4FI2OCOTSkqIO0K8kUaUVT6rNDoFcPaJtSkV0AFDpK7rjh/kAKtCPPJ6/aPmmhvbCP5xpRegBoL79MUIyDRKcisO6iz0N9fhKoGrm0S3IEJ7ltoYc9PdHC5jKhKXFWgSHpt/WqVoUxhzwD6Jo7Ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Mon, 18 Jul
 2022 14:57:36 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 14:57:36 +0000
Message-ID: <7f4a3a42-7b5a-92c9-653e-ebe689464cce@amd.com>
Date: Mon, 18 Jul 2022 16:56:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5] drm/amdgpu: add comment to HW_IP_VCN_ENC type
Content-Language: en-US
To: Ruijing Dong <ruijing.dong@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220718145534.49027-1-ruijing.dong@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220718145534.49027-1-ruijing.dong@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR0202CA0052.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::29) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4c817f1-19cb-4204-8331-08da68cdc4e3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5876:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ump/UBDbxTzmM4onqQ1HRqxAXTt8taQd0WUvqbXLJ4DDVAHpAnWLsMCiInZ20ZKOm+lLrrvmu9bXK8gl6CfT1wBQNj4FLuLXBdbw1ztywsYKUYM+UHrBUPsa6Rh2QtLUbzhZ5Fn6dU0Z+uCvwQpVTtcp7d3SCMSiu/yZKNVeUbYIheMsT4fvJegsmwRmAm0ixY+sxXEDi3At/2M/dGv6NE+nn045KO+XNRftOrFiC25953HNRnhrOpM39Eu0tfS1Q9AaUAN+ikzg+GRxrV1PSCXqhO5MDxxCss+L2MkDlumlzjQNKSF11Ekkr9H2meEgzIgCBr/oUyWdmMF6fV8uhDyqUvceuWO9nXB9nat9mz/IaS6LqLnvgNcrG8SQSKdklw4mT5bBsxkv2FyKlnWxeBmMzk6won4qL7lv9UhmjaFRzrnCKCC+VGC7qAEc1Y7fwT3I+trd06+8mAys9h6LCQa2A+YlzcIa1cqx+/hRA8BPcIdsArmc0ewM1PXJUJ5kUseeWDEjhaOgPu5P3R0rFeNxCerh5CGuDIzM4D61VJXdMLRNM8gKaturDMhairoulDmdtZW+dxRYE1xSGkN9z4h7gMNkSDDL73ynrXrIDOBZY7lhqF8zLyxNgLO+bD3ZX8oO53GLMxEsCNUAkma/B/xQZy5earMJAdeyyephhgq8ZvU6pAJf9a7brH5TfkfZGsHPrei0zf7DyZyEE5QKYAexR45MZTDr78d5fxGchiqAPI5fIOwQ+5QnlFPqCdmRVyBJz190DCn3jQYWfCbCvj2gH/1lpbnDRmt33amDQ64=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(5660300002)(2906002)(86362001)(6486002)(8936002)(4744005)(478600001)(83380400001)(966005)(31686004)(31696002)(316002)(66476007)(36756003)(66946007)(66556008)(8676002)(4326008)(38100700002)(2616005)(6512007)(6506007)(41300700001)(186003)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTk3amxrUkwycWpoOHYyMEluRmYzQ2txZlY5UjFEU0EveUh2c0t0cjRjWGVS?=
 =?utf-8?B?UTBwMktBZnM3WTlOaEUwNGIrbHI3UXE5K0ZHUWsxOXorV1l2Yy9xaUFEWW9Q?=
 =?utf-8?B?Q2tIZGdwNmU1aDNVWVJpaFF4WEF2amY0bXI2Uko2Q3dTQkFDb1BlbFAxUDN3?=
 =?utf-8?B?dFpxYjYxdUxGMXpxRjBMc09mR0o3YVlCeXNzRDQwb3h4czYwUWMxWFM5cEtq?=
 =?utf-8?B?dTdJWitUMjVTeTFZaTZRUGV4eC85dUk0LzBHMWR3Rkd0MWVEK2FOMUF1aUtl?=
 =?utf-8?B?SU42dHRTK1ErV0NON1ZiNnhRMmF6a3c5b1pDVTZmT0ExcFJkSmtMaHp4d2FK?=
 =?utf-8?B?Uy96NS81Mi83MTVIT3pqT3l6enVSWmZFU05lMk5JL0tNd0M1YTBXQkxreGs1?=
 =?utf-8?B?K2hzK0lYOTBGYWdZY2dQREZURThZKzcvb0JTOVZIdlBCeGt5cEEwdU9kTEdT?=
 =?utf-8?B?VEZEVnZoa0MxRkZBOTN1dnZGc1k2UUxjeFp0Y3FROXIyS3ROZ1VCbmdkczBi?=
 =?utf-8?B?RGpTVGQxV3RObTFIcmtRakxxREprS3JjM2lDTFlHUTlueGdSSXNrSTZnUnJC?=
 =?utf-8?B?ME56VWY0b2dDNlFnNzV3VW5CcTRYaCtLZkh3WTVqdlVQK20ycWVjMjNBeTIw?=
 =?utf-8?B?REFMUXFzbWZjcjZ0UEFEUVJuSGNvbHZiaWM4TFYzS0xWdzhFR2xVVll5VzQv?=
 =?utf-8?B?dGlQeHNjb1FCajRzQVlERG1wblgwdEFUbDhqdlVUTWZ1UDV2R1ZENVhKSXgy?=
 =?utf-8?B?aTNQYnlpNlluVi9NRE02dFlHQWtKMVNFeis3NVRWL1oxbUJiTWh6cWRzUzd3?=
 =?utf-8?B?ZnZIS213VHZEeHppWDJITlFmTmUwbkE0dzlYU0crcVJrNEdLa215c2lZTE5a?=
 =?utf-8?B?WDk5WHdoTFJnRkEzTE8wN2FnQlZqUUNXdWRNSk5Lc09BRzErTkJvSlhvdnFU?=
 =?utf-8?B?QjMvVm55LzJwU0xEMEY3L1hXZ1AvWGVMeFRyZ09YVHN6NWlnOVo5TVY0c29X?=
 =?utf-8?B?UWZ0STVYeThweWNmVjZVa0VEM0RCM09IZVdlZCtWZ0N0Vk4vTitQTGJDcUVZ?=
 =?utf-8?B?eTBQYSswQlBsbVpqK1k3bEtoQlQ0R2lhdmpIY0RGOFlUTVpnMytseGNVZ0pz?=
 =?utf-8?B?RFUzcHp0SGFTNGh3c0lHVktZSEtXVlBJV0x6S3NWTGNZSjQxSGxDbUFtdmdS?=
 =?utf-8?B?enQ3RmM2VU4zUUxJNkRDNllLRGVUNlE0REdydHozc29GTkdpYjhmMENvbkF1?=
 =?utf-8?B?d2ZmZEIyUXZtQzIrV3FhbVpXb3NQNGNwdUc4ZGNvMjNKeGNRa3hkcjFwNkFR?=
 =?utf-8?B?VnRsMVFDZSt4d2FsaTFvWnRBRjhGcnBWQldFYnRKUlpPVUoxS2F5eVZjdnMw?=
 =?utf-8?B?ZE9VYzRUeVFOdkxhaXE4NlYrM1FPamQzTkN6NXNQOWgvYlBhRXFVaDZmSE9G?=
 =?utf-8?B?eHVFanlkUFBvUVFxTTc3RmJldDF6TVpRZ0ZKVWczcEpKa1NEcml2LzhnS2l0?=
 =?utf-8?B?R3BXSjhZMmF3OUN3SE43OEFCQ2lManAwUGVUWjMvakluQ1ZnUmVZWWZJdXJv?=
 =?utf-8?B?dVVmQTBqZHdEelBqZ0F4cnpuSU1pZVpVdTdzMVB3TkZUajA5NVZWWS9Pb2NL?=
 =?utf-8?B?QUQ3SjdUcHk2U1AzWmVCM2VJdlVGbEsydVFjdk9SeXhubmNybllsZWR1cGdL?=
 =?utf-8?B?THViSnZCNHVPejRaTDJCQTBqazNTbGpqZHByRXNZSDhDYk94Z3Y0RCtDS1Fx?=
 =?utf-8?B?NmtKVWk0VXl0a041NlZ4eGNpUEJCOThaSDlGY3lzUnVvcllJU0pkc2kyeTZx?=
 =?utf-8?B?WDFuMC9qK2NCejFNbzBENGtoS1JiYVhvcGRMWStyWXpkZGY3VGVjblVFWDlk?=
 =?utf-8?B?bmlKVm03Z3VocTdlZkhIUmhXcGx2MkRra0RpVDhXejR2amtTSkh2TDFTL0Mv?=
 =?utf-8?B?c25YczdIM2NOa3J1Q1RWRjNBN0ZkUm0yeXFXZGxLa3Nrc3h6TzdrdkNzOWs3?=
 =?utf-8?B?aGZ3RGZ2cTNjYnFyNHhsZERQcXhQRjVkS2JRdHl4NXZSUG9Nc29QblhwWTdl?=
 =?utf-8?B?RnhwdDJxZXgydzNjMUtIYzR5eHR0VGhrelRkaHBjTEw5dFQ0VGxJYjg5MSth?=
 =?utf-8?B?b2NzRXQ4RStsZTFHYlZMRXJnanlxT0N4Uk1icjlHZ3o4K0J4NWxFczhwTGlW?=
 =?utf-8?Q?l2DqaYmQWimP0cFuaeIWmWGDkRKOIMQr88h00SrIv4Ek?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c817f1-19cb-4204-8331-08da68cdc4e3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 14:57:36.2151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pN8fqvXxctB0jSU63oBhw491Ytf7tyhcQ58zQOVsS/jG9EV7CxmQpxwTW6gRgKa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
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
Cc: alexander.deucher@amd.com, leo.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.07.22 um 16:55 schrieb Ruijing Dong:
>  From VCN4, AMDGPU_HW_IP_VCN_ENC is re-used to support
> both encoding and decoding jobs.
>
> link: https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/245/commits
>
> Reviewed-by: Leo Liu <leo.liu@amd.com>
> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   include/uapi/drm/amdgpu_drm.h | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 18d3246d636e..63de71f53110 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -559,6 +559,10 @@ struct drm_amdgpu_gem_va {
>   #define AMDGPU_HW_IP_VCE          4
>   #define AMDGPU_HW_IP_UVD_ENC      5
>   #define AMDGPU_HW_IP_VCN_DEC      6
> +/*
> + * From VCN4, AMDGPU_HW_IP_VCN_ENC is re-used to support
> + * both encoding and decoding jobs.
> + */
>   #define AMDGPU_HW_IP_VCN_ENC      7
>   #define AMDGPU_HW_IP_VCN_JPEG     8
>   #define AMDGPU_HW_IP_NUM          9

