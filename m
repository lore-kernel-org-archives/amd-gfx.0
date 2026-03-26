Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645AD10A88E7
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 17:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C6C610EB4A;
	Thu, 26 Mar 2026 17:31:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W/2DhcUV";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013027.outbound.protection.outlook.com
 [40.93.196.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 997FB10EB31
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 17:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGtfAznsxkcjGgSkqJ585sSLvp0YJOY93KWRDNOEYfwNyGflyUQrTzIQgLa91AhafnrkGWhfHlqfBg3n7zGDmHuTOU//JBkYdrbRZDmZuARci4dA5O9ExlZCcABHFH8zAyTot2iPIsF8Uem4/mPNdE4o0gdOmzHDFuHKx/SnE5W/L2iGCp4A9oSUitgRs9uyOaK9cOYcT45wsz6xyIGOkgZA7+mSEqCnLsMVmFTX7Juw/60riFOFJMYhGm/w0JFadPREAq9oVC8Ry9SLAe7hRAOiWS/qCD/DA5ZeOiE3OSqhxVwyjmH1PJkpGZIO7ajW3O3+K3ZnEXYx/7EtakKM2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+Xg3Bc8yeJu/A52CS5FQw4cwVvpDv/W8SOMDw5n1Qs=;
 b=NgcbVmoUN5RU005b/UAq76EaFdv2XATksH4dujNf9bTkHoT2DD3M95Of1etvhk1vvjmRqx4+4ZHJ+ZYbpcDeBG1BRf36C5WUMcldv9YIIobS5oLxnIV9KcpmZjCXVLMS6jKPSex4EUUYE3m6MHw2mqPqye6McLeV41acsY7820v0T59mxQZGAQftcwen6iLuEfBXu+/uG0+QNOK0yD67T46AKrbjRM9JOsmKxPKqQ5mE1MuVH+mifhFAwJEvoauRCdj5qpyFfJNwkuh5CpAilHMUbuC5Sh8Yexj+vOva3pZ1kt81LLNYm/W2ALrS3tZ45lE7GEg/5Y5DAr9sqbmoug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+Xg3Bc8yeJu/A52CS5FQw4cwVvpDv/W8SOMDw5n1Qs=;
 b=W/2DhcUV7P/8nw7btf5pqALvItLEodZMWjBqwY3MQO0+9cNqaah1Ms2AsNaDF82VMT74W8M1XxxqdtnnY8HEqJfkb5pNYg8B2QZvADOwhloCskSHxkIerKbKHXUzBbLzJN2r7CY6GvXJL5xebj8g9J0aavQ63NVAQmAIzQGKAxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by DS5PPF016FC81DF.namprd12.prod.outlook.com (2603:10b6:f:fc00::644)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 17:31:30 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2%4]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 17:31:30 +0000
Content-Type: multipart/alternative;
 boundary="------------nNK00Spr7K5NG7M0h0CdRbOR"
Message-ID: <c489ea76-3329-4dae-926e-f55c18cac6c4@amd.com>
Date: Thu, 26 Mar 2026 13:31:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] drm/amdkfd: Reset queue/pipe in MES
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "alexdeucher@gmail.com" <alexdeucher@gmail.com>
Cc: "Chen, Michael" <Michael.Chen@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
 <20260324175653.1325754-10-Amber.Lin@amd.com>
 <CH0PR12MB5372EC4D6256F14210FBC59DF456A@CH0PR12MB5372.namprd12.prod.outlook.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <CH0PR12MB5372EC4D6256F14210FBC59DF456A@CH0PR12MB5372.namprd12.prod.outlook.com>
X-ClientProxiedBy: YT3PR01CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::18) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|DS5PPF016FC81DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b25ad85-d48a-4b48-9dce-08de8b5d8462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: qxFJUSg1fyDGcOPJQkz6MPQyUt/u2Aczr8BhXFHf7nI7HYgm/9bThzBIAITdPAhFRWxtEjXbP7oIKk7UML9k4jFaX2yWLf0CpEch7fj1PNZ7nECHqcxSZSrQ4d2JWI/NJ4MKBXj17rwkXo1Ddpa9DFFlkcaw9lv6udI6rz5gLYue9QguVg2WsBvwQNDVJJeoJd7Z2qWdXKei7p0mxC1JfJ0QK2XnxoIYALBb4We1V2COalSA13IxCaZi0NEM0D7CVRZKX9xIKlEH7GNoj7WSGCyBtKT/UJBNyG/Pau8sYSHWR/hJLdw89J4bvshBFHj8Npgsuy3qZ/eI+5nftNa+nXKEw6knGJkwiGztr3Voxtz8OKvd+ZbXHiYWcJtiLvzK3eZXRGdQJPhES7KuOxM6pJLkJ3DgKnpwu9OhRDX+1iR2O6Ehuqm+oaRKk8+MshO4vX/eCYh5CefvACGsUNP3h6Igl0ksaIGnab/KPQ5y38lL06J3qRT4882hSrFYAIcwtHET+tZdN/zfMEVjJsunUTcKbgpWNOyqI/qVwNNNln6sCdwj11j3l0R210uIe4r5tK7l+lxExNEHjTTMIM884X+ezC6x+M0Mxq51brEeqnU0EDYvBd0LpQKJuYOwNAemtHHrWwnpHQ9EnwHl5qV8OJdCTbgw2SZe6i+5cPLRdOaLNW2Ov7ASvBxmY583dLamfR/FKO+PAxqVTUhWmjWe1jfNBZnKDcHKn7QI4Dg2kj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXM5dWYvbzFlU2U1ZWpHZ09DZHl0a1I5dzVObTlld05mUzV5bG1rVEJkVzJN?=
 =?utf-8?B?TDlGMEgxa3RGWnVpZFRGUUtZUUxLV0l4ZFd0NzE0RklId0l0SjJtaUlIUUNm?=
 =?utf-8?B?MERFVmtJOXlVRXdTaXJPVC94QjNWSjNTb29oTlJSZUcxNTVqOHQyZkhHQjY4?=
 =?utf-8?B?c0dLelVNZ0VpZ0VML1pJVGxJenRpWDUySm5NV2VqekZYeURXQ2p1Sk5BdlQ4?=
 =?utf-8?B?SlcxZmtUcXM0MFhtQ05NY1VmeUc3Y1FxZEVHSXh5TDBDbGZHS0hPbVRkNVMy?=
 =?utf-8?B?Uk9rQVVCenl1Z1lNWnh0QSt6QzRSK2tYeHRzdHNab0ZlclFjVk9sdjVYZ1lk?=
 =?utf-8?B?QlBYS0szM1VpZlhmaVF4RHN1aEJqbUxsblF2T2J0VE1oeWNBK3pweDdvREFE?=
 =?utf-8?B?M0R2bTVkWnI1SThsM2dHQlFFYUkvclVYVWxUOU1uR2NidW1MQ1R2eVZaQjlG?=
 =?utf-8?B?YlRGZGtMR1VOWStXNmtlbU5SYys0bndJSFlqa3NHL2NFMitxa0FmV2hCUmZa?=
 =?utf-8?B?RVVLU1VIWnlaaHFkSU9vaWJDUmJTQjQ2bzdxTjFrcFFpMWFwSUk2SWEvZjd4?=
 =?utf-8?B?SzZUMWtzaGpxT04zRVRLc2oxc3cwOHZpQjRRcVhHajJSck1mNmZwa3RGdjd4?=
 =?utf-8?B?RXVFWFBhUUVMeEozNDFqQ1pJTitZWlZHU3ZOZldLR3hMWnIzM2hmUTBFUFRR?=
 =?utf-8?B?bUd0aEY3UkRHOUNyTVNkY0E0dThJS0YzZWRQSTRjUjdIL3dCR0UvS3N3MUZs?=
 =?utf-8?B?aEQvK1dncUwvSzZQc1AybmNZVTBMUXlDbVl1VVRKczNFUkoyeFdrUzNFbmhn?=
 =?utf-8?B?QXJXOVhPN3hqdFZ3dmI4SHdsamkzMTUzejhwdkdTTksrQk13eHFwRGQwRTBi?=
 =?utf-8?B?NTZuMWZyV2ZiejFpdFZSc0FkNWFlaDdIT3VoRlF1QVF4TE8xdmtMZUdPTDRD?=
 =?utf-8?B?S1k1UE8zYTNsU29XUmpiZTJpMENEZkVyT01IdU5kdno2YVRWMzJGOXlIdUhh?=
 =?utf-8?B?bGdMbHBSVFh1bW5NcWxobFJxdUpGcWlTWmExbjZnNzYyN0VhaEhQZjk1Y0F3?=
 =?utf-8?B?clpBcUE4YTYrbVphMEF4aGx2eHJVaDcyRk5xYnVWNHVRdnhsSmE4aXdOd01Q?=
 =?utf-8?B?OFR0U3hTeVlkeVdmWWpCeGs0VmZQdDhxRGdOSDUyN3hrcUZuNklGd291Risr?=
 =?utf-8?B?c2FSelJPK2VZdHc2aDNKTjg5UFVvRVE1OGNIZmM1ZEZ3S0daYmFwcnh3VWM3?=
 =?utf-8?B?WnQyWVg5NHo3NzhVakxqYVBJbUtIdEVXemt0L0NVKzVjYnNBeXRIWGF5SVNB?=
 =?utf-8?B?TnZDNE50L1BPdHUyTzU1NXpBeUN5NHBYamJUOGFVUWZZdU1ISzc5dVY0Tk5P?=
 =?utf-8?B?LzN0T20vbTFrbnQ4bm5pS2MxQUdSYm8vNndVNWpEZEh2cEpWbDlKVzJ4aUZv?=
 =?utf-8?B?TFFZeG13NTJPYXNWY1JSQ2RoelZjYlVydUxnb1QrMUZZbndYaDYwRnRPaU1B?=
 =?utf-8?B?dFEyMTVwcW05SXZIdDYwbUt1Y2lkd2lUNVdnaHc3YjAwam8yYVZ6aVhZb3RS?=
 =?utf-8?B?TDdJTCtYazBwSUVTeFRmQlZLUVBoYTY3Smw0TFZ1elcwNzZDV3hHOHVicGhW?=
 =?utf-8?B?ZFRSNStSd2JQNWdWdXVIV0VkUmFoNisyTzBqQk1BVFRRdlRYcG1nM1U5cG52?=
 =?utf-8?B?SVIybzN3QzNSVGlLclhESnBtTVhjRnl3NTJUbnlUR3NsNSs1S0pzYzJjRUor?=
 =?utf-8?B?YThtaHNhNC9qRysvUWFsOHNicUhYbjBISFF5N0NZdVBIOEY4VkE3cUZwN1Ra?=
 =?utf-8?B?d1p3Ny9GR2ZRcGNmRkJMV1JQWWNKa3JkbytxOEpUdHNzSElrQTVGR29LUEYw?=
 =?utf-8?B?Q0pSK05EM0ZZTDFTMnBUdEwvMnllZGZIRElIVitnTFF5L2JCU3BiaTMxR2Nz?=
 =?utf-8?B?N0NRbXFuRnRxK2hob0Q5WWJuYUJtZEtBV3FYMm9yVlRKazlwWDhlc25SRWVN?=
 =?utf-8?B?TDFTdTI1WFozYjFkOVA0VXYxZTY1ZXNHRXlqSWxPVzEwTHdxVW5qb3NvZ1NX?=
 =?utf-8?B?cjRCelpZRTFoTnBydjkvZEtKMTduVk9rcDdwUXhwZitXV1JWUVBwT0VwWm41?=
 =?utf-8?B?OTVXNjFvbTJkRUliM0VRd1E4b1FEcnN6L2cvOGtlclBuYlh3T29JUWUvcmlx?=
 =?utf-8?B?L0sydG9iWW5hdlQvZ3JudG85VHpwQlc3dzcvT3dyUTQvb2h3M1NMYjQ1TlYv?=
 =?utf-8?B?ZFlnM0dibXFrcnBXN1ZKdWw1SWw1bkNwT2lBSURjU20xMGdnSi9FcURhc0Fl?=
 =?utf-8?Q?klG41vQ3p4YJvYyVAC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b25ad85-d48a-4b48-9dce-08de8b5d8462
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 17:31:30.4642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXyevm+P0hSLFiFxjKzL4cmzfAqWA3Df460DgZxwCXL8CVlXTaFDGkPK0PMDJuAb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF016FC81DF
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

--------------nNK00Spr7K5NG7M0h0CdRbOR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Yeah I should have made this series' cover letter more clear... This 
series only supports and enables detect-and-reset-in-MES for gfx 12.1 
for user compute queues. KCQ is not used in gfx 12.1.

Yes, KFD removes hung queues after detect-and-reset and notify the user 
by sending a reset signal. Please see my reply inline below where 
amdgpu_mes_detect_and_reset_hung_queues is called following 
remove_queue_mes_on_reset_option calls for each hung queue, and 
kfd_signal_reset_event in the end.

Regards,
Amber


On 3/26/26 12:06, Liu, Shaoyun wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Maybe  I missed something , can you explain a little bit more on how driver will do the cleanup on those hung queues in the failed list after the reset & detect call ? will driver call remove_queue on each of them and  notify user ? If the hung queue is KCQ ,will driver create a new KCQ ?
>
> Regards
> Shaoyun.liu
>
> -----Original Message-----
> From: Lin, Amber<Amber.Lin@amd.com>
> Sent: Tuesday, March 24, 2026 1:57 PM
> To:amd-gfx@lists.freedesktop.org;alexdeucher@gmail.com
> Cc: Liu, Shaoyun<Shaoyun.Liu@amd.com>; Chen, Michael<Michael.Chen@amd.com>; Zhang, Jesse(Jie)<Jesse.Zhang@amd.com>; Lin, Amber<Amber.Lin@amd.com>; Kim, Jonathan<Jonathan.Kim@amd.com>
> Subject: [PATCH v2 09/10] drm/amdkfd: Reset queue/pipe in MES
>
> When removing queues fails, KFD calls amdgpu_mes to detect and reset hung queues, then cleans up those hung queues in KFD.
>
> Suggested-by: Jonathan Kim<jonathan.kim@amd.com>
> Signed-off-by: Amber Lin<Amber.Lin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |   6 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |   1 +
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 147 +++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
>   4 files changed, 153 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index f3a4ae1fd521..7cf4b3d6fc93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -793,6 +793,12 @@ bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
>                  amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 0, 0));  }
>
> +bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device
> +*adev) {
> +       return (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0) &&
> +               (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x73); }
> +
>   /* Fix me -- node_id is used to identify the correct MES instances in the future */  static int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev,
>                                              uint32_t node_id, bool enable) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 643b4f8d757a..44fa4d73bce8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -548,6 +548,7 @@ static inline void amdgpu_mes_unlock(struct amdgpu_mes *mes)  }
>
>   bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev);
> +bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device
> +*adev);
>
>   int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev);
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index ec8d7f4be840..1c9c350bfffe 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -71,6 +71,12 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
>                                  struct queue *q, const uint32_t *restore_sdma_id);
>
>   static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool is_sdma);
> +static int resume_all_queues_mes(struct device_queue_manager *dqm);
> +static int suspend_all_queues_mes(struct device_queue_manager *dqm);
> +static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *dqm,
> +                                                  uint32_t doorbell_offset);
> +static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
> +                              struct qcm_process_device *qpd);
>
>   static inline
>   enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type) @@ -273,13 +279,19 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>          return r;
>   }
>
> -static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
> -                       struct qcm_process_device *qpd)
> +static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, struct queue *q,
> +                                           struct qcm_process_device *qpd,
> +                                           bool is_for_reset,
> +                                           bool flush_mes_queue)
>   {
>          struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
>          int r;
>          struct mes_remove_queue_input queue_input;
>
> +       /* queue was already removed during reset */
> +       if (q->properties.is_reset)
> +               return 0;
> +
>          if (!dqm->sched_running || dqm->sched_halt)
>                  return 0;
>          if (!down_read_trylock(&adev->reset_domain->sem))
> @@ -288,6 +300,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>          memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>          queue_input.doorbell_offset = q->properties.doorbell_off;
>          queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
> +       queue_input.remove_queue_after_reset = flush_mes_queue;
>          queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
>
>          amdgpu_mes_lock(&adev->mes);
> @@ -295,7 +308,13 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>          amdgpu_mes_unlock(&adev->mes);
>          up_read(&adev->reset_domain->sem);
>
> +       if (is_for_reset)
> +               return r;
> +
>          if (r) {
> +               if (!suspend_all_queues_mes(dqm))
> +                       return resume_all_queues_mes(dqm);
> +
>                  dev_err(adev->dev, "failed to remove hardware queue from MES, doorbell=0x%x\n",
>                          q->properties.doorbell_off);
>                  dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n"); @@ -305,6 +324,12 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>          return r;
>   }
>
> +static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
> +                           struct qcm_process_device *qpd)
> +{
> +       return remove_queue_mes_on_reset_option(dqm, q, qpd, false, false); }
> +
>   static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)  {
>          struct device_process_node *cur;
> @@ -359,6 +384,103 @@ static int add_all_kfd_queues_mes(struct device_queue_manager *dqm)
>          return retval;
>   }
>
> +static int reset_queues_mes(struct device_queue_manager *dqm) {
> +       struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
> +       struct amdgpu_mes_hung_queue_hqd_info *hqd_info;
> +       int hqd_info_size = adev->mes.hung_queue_hqd_info_offset;
> +       int num_hung = 0, r = 0, i, pipe, queue, queue_type;
> +       uint32_t *hung_array;
> +       struct kfd_process_device *pdd;
> +       struct queue *q;
> +
> +       if (!amdgpu_mes_queue_reset_by_mes_supported(adev)) {
> +               r = -ENOTRECOVERABLE;
> +               goto fail;
> +       }
> +
> +       /* reset should be used only in dqm locked queue reset */
> +       if (WARN_ON(dqm->detect_hang_count > 0))
> +               return 0;
> +
> +       if (!amdgpu_gpu_recovery) {
> +               r = -ENOTRECOVERABLE;
> +               goto fail;
> +       }
> +
> +       hung_array = kzalloc(adev->mes.hung_queue_db_array_size * sizeof(uint32_t), GFP_KERNEL);
> +       if (!hung_array) {
> +               r = -ENOMEM;
> +               goto fail;
> +       }
> +
> +       hqd_info = kzalloc(hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_info), GFP_KERNEL);
> +       if (!hqd_info) {
> +               r = -ENOMEM;
> +               goto free_hung_array;
> +       }
> +
> +       memset(hqd_info, 0, hqd_info_size * sizeof(struct
> +amdgpu_mes_hung_queue_hqd_info));
> +
> +       /*
> +        * AMDGPU_RING_TYPE_COMPUTE parameter does not matter if called
> +        * post suspend_all as reset & detect will return all hung queue types.
> +        *
> +        * Passed parameter is for targeting queues not scheduled by MES add_queue.
> +        */
> +       r =  amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TYPE_COMPUTE,
> +               false, &num_hung, hung_array, ffs(dqm->dev->xcc_mask) - 1);
This is where KFD calls amdgpu_mes_detect_and_reset_hung_queues with 
detect_only=flase. When MES proceeds RESET successfully, KFD looks up 
hung queues and calls remove_queue_mes_on_reset_option below
> +
> +       if (!num_hung || r) {
> +               r = -ENOTRECOVERABLE;
> +               goto free_hqd_info;
> +       }
> +
> +       /* MES reset resets queue/pipe and cleans up internally  */
> +       for (i = 0; i < num_hung; i++) {
> +               hqd_info[i].bit0_31 = hung_array[i + hqd_info_size];
> +               pipe = hqd_info[i].pipe_index;
> +               queue = hqd_info[i].queue_index;
> +               queue_type = hqd_info[i].queue_type;
> +
> +               if (queue_type != MES_QUEUE_TYPE_COMPUTE &&
> +                   queue_type != MES_QUEUE_TYPE_SDMA) {
> +                       pr_warn("Unsupported hung queue reset type: %d\n", queue_type);
> +                       hung_array[i] = AMDGPU_MES_INVALID_DB_OFFSET;
> +                       continue;
> +               }
> +
> +               q = find_queue_by_doorbell_offset(dqm, hung_array[i]);
> +               if (!q) {
> +                       r = -ENOTRECOVERABLE;
> +                       goto free_hqd_info;
> +               }
> +
> +               pdd = kfd_get_process_device_data(q->device, q->process);
> +               if (!pdd) {
> +                       r = -ENODEV;
> +                       goto free_hqd_info;
> +               }
> +
> +               pr_warn("Hang detected doorbell %x pipe %d queue %d type %d\n",
> +                               hung_array[i], pipe, queue, queue_type);
> +               /* Proceed remove_queue with reset=true */
> +               remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, false);
This is where KFD calls remove_queue_mes_on_reset_optionto clean up bad 
queues created on user compute.
> +               set_queue_as_reset(dqm, q, &pdd->qpd);
> +       }
> +
> +       dqm->detect_hang_count = num_hung;
> +       kfd_signal_reset_event(dqm->dev);
This is where KFD notifies the user process about the reset event: 
kfd_signal_reset_event
> +
> +free_hqd_info:
> +       kfree(hqd_info);
> +free_hung_array:
> +       kfree(hung_array);
> +fail:
> +       dqm->detect_hang_count = 0;
> +       return r;
> +}
> +
>   static int suspend_all_queues_mes(struct device_queue_manager *dqm)  {
>          struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev; @@ -371,6 +493,9 @@ static int suspend_all_queues_mes(struct device_queue_manager *dqm)
>          up_read(&adev->reset_domain->sem);
>
>          if (r) {
> +               if (!reset_queues_mes(dqm))
> +                       return 0;
> +
>                  dev_err(adev->dev, "failed to suspend gangs from MES\n");
>                  dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
>                  kfd_hws_hang(dqm);
> @@ -2137,6 +2262,7 @@ static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q
>                  q->properties.queue_id, pdd->process->lead_thread->pid);
>
>          pdd->has_reset_queue = true;
> +       q->properties.is_reset = true;
>          if (q->properties.is_active) {
>                  q->properties.is_active = false;
>                  decrement_queue_count(dqm, qpd, q);
> @@ -2203,6 +2329,23 @@ static struct queue *find_queue_by_address(struct device_queue_manager *dqm, uin
>          return NULL;
>   }
>
> +static struct queue *find_queue_by_doorbell_offset(struct
> +device_queue_manager *dqm, uint32_t doorbell_offset) {
> +       struct device_process_node *cur;
> +       struct qcm_process_device *qpd;
> +       struct queue *q;
> +
> +       list_for_each_entry(cur, &dqm->queues, list) {
> +               qpd = cur->qpd;
> +               list_for_each_entry(q, &qpd->queues_list, list) {
> +                       if (doorbell_offset == q->properties.doorbell_off)
> +                               return q;
> +               }
> +       }
> +
> +       return NULL;
> +}
> +
>   static int reset_hung_queues(struct device_queue_manager *dqm)  {
>          int r = 0, reset_count = 0, i;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 27e4859e4ad7..6cb33f6d71e2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -523,6 +523,7 @@ struct queue_properties {
>          uint32_t pm4_target_xcc;
>          bool is_dbg_wa;
>          bool is_user_cu_masked;
> +       bool is_reset;
>          /* Not relevant for user mode queues in cp scheduling */
>          unsigned int vmid;
>          /* Relevant only for sdma queues*/
> --
> 2.43.0
>

--------------nNK00Spr7K5NG7M0h0CdRbOR
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Yeah I should have made this series' cover letter more clear... This
    series only supports and enables detect-and-reset-in-MES for gfx
    12.1 for user compute queues. KCQ is not used in gfx 12.1.<br>
    <br>
    Yes, KFD removes hung queues after detect-and-reset and notify the
    user by sending a reset signal. Please see my reply inline below
    where amdgpu_mes_detect_and_reset_hung_queues is called following
    remove_queue_mes_on_reset_option calls for each hung queue, and&nbsp;<span style="white-space: pre-wrap">kfd_signal_reset_event in the end.</span>
    <pre class="moz-signature" cols="72">Regards,
Amber</pre>
    <br>
    <div class="moz-cite-prefix">On 3/26/26 12:06, Liu, Shaoyun wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CH0PR12MB5372EC4D6256F14210FBC59DF456A@CH0PR12MB5372.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">[AMD Official Use Only - AMD Internal Distribution Only]

Maybe  I missed something , can you explain a little bit more on how driver will do the cleanup on those hung queues in the failed list after the reset &amp; detect call ? will driver call remove_queue on each of them and  notify user ? If the hung queue is KCQ ,will driver create a new KCQ ?

Regards
Shaoyun.liu

-----Original Message-----
From: Lin, Amber <a class="moz-txt-link-rfc2396E" href="mailto:Amber.Lin@amd.com">&lt;Amber.Lin@amd.com&gt;</a>
Sent: Tuesday, March 24, 2026 1:57 PM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; <a class="moz-txt-link-abbreviated" href="mailto:alexdeucher@gmail.com">alexdeucher@gmail.com</a>
Cc: Liu, Shaoyun <a class="moz-txt-link-rfc2396E" href="mailto:Shaoyun.Liu@amd.com">&lt;Shaoyun.Liu@amd.com&gt;</a>; Chen, Michael <a class="moz-txt-link-rfc2396E" href="mailto:Michael.Chen@amd.com">&lt;Michael.Chen@amd.com&gt;</a>; Zhang, Jesse(Jie) <a class="moz-txt-link-rfc2396E" href="mailto:Jesse.Zhang@amd.com">&lt;Jesse.Zhang@amd.com&gt;</a>; Lin, Amber <a class="moz-txt-link-rfc2396E" href="mailto:Amber.Lin@amd.com">&lt;Amber.Lin@amd.com&gt;</a>; Kim, Jonathan <a class="moz-txt-link-rfc2396E" href="mailto:Jonathan.Kim@amd.com">&lt;Jonathan.Kim@amd.com&gt;</a>
Subject: [PATCH v2 09/10] drm/amdkfd: Reset queue/pipe in MES

When removing queues fails, KFD calls amdgpu_mes to detect and reset hung queues, then cleans up those hung queues in KFD.

Suggested-by: Jonathan Kim <a class="moz-txt-link-rfc2396E" href="mailto:jonathan.kim@amd.com">&lt;jonathan.kim@amd.com&gt;</a>
Signed-off-by: Amber Lin <a class="moz-txt-link-rfc2396E" href="mailto:Amber.Lin@amd.com">&lt;Amber.Lin@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |   1 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 147 +++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
 4 files changed, 153 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index f3a4ae1fd521..7cf4b3d6fc93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -793,6 +793,12 @@ bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
                amdgpu_ip_version(adev, GC_HWIP, 0) &gt;= IP_VERSION(12, 0, 0));  }

+bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device
+*adev) {
+       return (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0) &amp;&amp;
+               (adev-&gt;mes.sched_version &amp; AMDGPU_MES_VERSION_MASK) &gt;= 0x73); }
+
 /* Fix me -- node_id is used to identify the correct MES instances in the future */  static int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev,
                                            uint32_t node_id, bool enable) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 643b4f8d757a..44fa4d73bce8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -548,6 +548,7 @@ static inline void amdgpu_mes_unlock(struct amdgpu_mes *mes)  }

 bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev);
+bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device
+*adev);

 int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev);

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index ec8d7f4be840..1c9c350bfffe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -71,6 +71,12 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
                                struct queue *q, const uint32_t *restore_sdma_id);

 static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool is_sdma);
+static int resume_all_queues_mes(struct device_queue_manager *dqm);
+static int suspend_all_queues_mes(struct device_queue_manager *dqm);
+static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *dqm,
+                                                  uint32_t doorbell_offset);
+static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
+                              struct qcm_process_device *qpd);

 static inline
 enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type) @@ -273,13 +279,19 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
        return r;
 }

-static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
-                       struct qcm_process_device *qpd)
+static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, struct queue *q,
+                                           struct qcm_process_device *qpd,
+                                           bool is_for_reset,
+                                           bool flush_mes_queue)
 {
        struct amdgpu_device *adev = (struct amdgpu_device *)dqm-&gt;dev-&gt;adev;
        int r;
        struct mes_remove_queue_input queue_input;

+       /* queue was already removed during reset */
+       if (q-&gt;properties.is_reset)
+               return 0;
+
        if (!dqm-&gt;sched_running || dqm-&gt;sched_halt)
                return 0;
        if (!down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem))
@@ -288,6 +300,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
        memset(&amp;queue_input, 0x0, sizeof(struct mes_remove_queue_input));
        queue_input.doorbell_offset = q-&gt;properties.doorbell_off;
        queue_input.gang_context_addr = q-&gt;gang_ctx_gpu_addr;
+       queue_input.remove_queue_after_reset = flush_mes_queue;
        queue_input.xcc_id = ffs(dqm-&gt;dev-&gt;xcc_mask) - 1;

        amdgpu_mes_lock(&amp;adev-&gt;mes);
@@ -295,7 +308,13 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
        amdgpu_mes_unlock(&amp;adev-&gt;mes);
        up_read(&amp;adev-&gt;reset_domain-&gt;sem);

+       if (is_for_reset)
+               return r;
+
        if (r) {
+               if (!suspend_all_queues_mes(dqm))
+                       return resume_all_queues_mes(dqm);
+
                dev_err(adev-&gt;dev, &quot;failed to remove hardware queue from MES, doorbell=0x%x\n&quot;,
                        q-&gt;properties.doorbell_off);
                dev_err(adev-&gt;dev, &quot;MES might be in unrecoverable state, issue a GPU reset\n&quot;); @@ -305,6 +324,12 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
        return r;
 }

+static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
+                           struct qcm_process_device *qpd)
+{
+       return remove_queue_mes_on_reset_option(dqm, q, qpd, false, false); }
+
 static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)  {
        struct device_process_node *cur;
@@ -359,6 +384,103 @@ static int add_all_kfd_queues_mes(struct device_queue_manager *dqm)
        return retval;
 }

+static int reset_queues_mes(struct device_queue_manager *dqm) {
+       struct amdgpu_device *adev = (struct amdgpu_device *)dqm-&gt;dev-&gt;adev;
+       struct amdgpu_mes_hung_queue_hqd_info *hqd_info;
+       int hqd_info_size = adev-&gt;mes.hung_queue_hqd_info_offset;
+       int num_hung = 0, r = 0, i, pipe, queue, queue_type;
+       uint32_t *hung_array;
+       struct kfd_process_device *pdd;
+       struct queue *q;
+
+       if (!amdgpu_mes_queue_reset_by_mes_supported(adev)) {
+               r = -ENOTRECOVERABLE;
+               goto fail;
+       }
+
+       /* reset should be used only in dqm locked queue reset */
+       if (WARN_ON(dqm-&gt;detect_hang_count &gt; 0))
+               return 0;
+
+       if (!amdgpu_gpu_recovery) {
+               r = -ENOTRECOVERABLE;
+               goto fail;
+       }
+
+       hung_array = kzalloc(adev-&gt;mes.hung_queue_db_array_size * sizeof(uint32_t), GFP_KERNEL);
+       if (!hung_array) {
+               r = -ENOMEM;
+               goto fail;
+       }
+
+       hqd_info = kzalloc(hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_info), GFP_KERNEL);
+       if (!hqd_info) {
+               r = -ENOMEM;
+               goto free_hung_array;
+       }
+
+       memset(hqd_info, 0, hqd_info_size * sizeof(struct
+amdgpu_mes_hung_queue_hqd_info));
+
+       /*
+        * AMDGPU_RING_TYPE_COMPUTE parameter does not matter if called
+        * post suspend_all as reset &amp; detect will return all hung queue types.
+        *
+        * Passed parameter is for targeting queues not scheduled by MES add_queue.
+        */
+       r =  amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TYPE_COMPUTE,
+               false, &amp;num_hung, hung_array, ffs(dqm-&gt;dev-&gt;xcc_mask) - 1);</pre>
    </blockquote>
    This is where KFD calls&nbsp;<span style="white-space: pre-wrap">amdgpu_mes_detect_and_reset_hung_queues with detect_only=flase. When MES proceeds RESET successfully, KFD looks up hung queues and calls remove_queue_mes_on_reset_option below</span>
    <blockquote type="cite" cite="mid:CH0PR12MB5372EC4D6256F14210FBC59DF456A@CH0PR12MB5372.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">
+
+       if (!num_hung || r) {
+               r = -ENOTRECOVERABLE;
+               goto free_hqd_info;
+       }
+
+       /* MES reset resets queue/pipe and cleans up internally  */
+       for (i = 0; i &lt; num_hung; i++) {
+               hqd_info[i].bit0_31 = hung_array[i + hqd_info_size];
+               pipe = hqd_info[i].pipe_index;
+               queue = hqd_info[i].queue_index;
+               queue_type = hqd_info[i].queue_type;
+
+               if (queue_type != MES_QUEUE_TYPE_COMPUTE &amp;&amp;
+                   queue_type != MES_QUEUE_TYPE_SDMA) {
+                       pr_warn(&quot;Unsupported hung queue reset type: %d\n&quot;, queue_type);
+                       hung_array[i] = AMDGPU_MES_INVALID_DB_OFFSET;
+                       continue;
+               }
+
+               q = find_queue_by_doorbell_offset(dqm, hung_array[i]);
+               if (!q) {
+                       r = -ENOTRECOVERABLE;
+                       goto free_hqd_info;
+               }
+
+               pdd = kfd_get_process_device_data(q-&gt;device, q-&gt;process);
+               if (!pdd) {
+                       r = -ENODEV;
+                       goto free_hqd_info;
+               }
+
+               pr_warn(&quot;Hang detected doorbell %x pipe %d queue %d type %d\n&quot;,
+                               hung_array[i], pipe, queue, queue_type);
+               /* Proceed remove_queue with reset=true */
+               remove_queue_mes_on_reset_option(dqm, q, &amp;pdd-&gt;qpd, true, false);</pre>
    </blockquote>
    This is where KFD calls&nbsp;<span style="white-space: pre-wrap">remove_queue_mes_on_reset_option</span>to
    clean up bad queues created on user compute.
    <blockquote type="cite" cite="mid:CH0PR12MB5372EC4D6256F14210FBC59DF456A@CH0PR12MB5372.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">
+               set_queue_as_reset(dqm, q, &amp;pdd-&gt;qpd);
+       }
+
+       dqm-&gt;detect_hang_count = num_hung;
+       kfd_signal_reset_event(dqm-&gt;dev);</pre>
    </blockquote>
    This is where KFD notifies the user process about the reset event:
    kfd_signal_reset_event
    <blockquote type="cite" cite="mid:CH0PR12MB5372EC4D6256F14210FBC59DF456A@CH0PR12MB5372.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">
+
+free_hqd_info:
+       kfree(hqd_info);
+free_hung_array:
+       kfree(hung_array);
+fail:
+       dqm-&gt;detect_hang_count = 0;
+       return r;
+}
+
 static int suspend_all_queues_mes(struct device_queue_manager *dqm)  {
        struct amdgpu_device *adev = (struct amdgpu_device *)dqm-&gt;dev-&gt;adev; @@ -371,6 +493,9 @@ static int suspend_all_queues_mes(struct device_queue_manager *dqm)
        up_read(&amp;adev-&gt;reset_domain-&gt;sem);

        if (r) {
+               if (!reset_queues_mes(dqm))
+                       return 0;
+
                dev_err(adev-&gt;dev, &quot;failed to suspend gangs from MES\n&quot;);
                dev_err(adev-&gt;dev, &quot;MES might be in unrecoverable state, issue a GPU reset\n&quot;);
                kfd_hws_hang(dqm);
@@ -2137,6 +2262,7 @@ static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q
                q-&gt;properties.queue_id, pdd-&gt;process-&gt;lead_thread-&gt;pid);

        pdd-&gt;has_reset_queue = true;
+       q-&gt;properties.is_reset = true;
        if (q-&gt;properties.is_active) {
                q-&gt;properties.is_active = false;
                decrement_queue_count(dqm, qpd, q);
@@ -2203,6 +2329,23 @@ static struct queue *find_queue_by_address(struct device_queue_manager *dqm, uin
        return NULL;
 }

+static struct queue *find_queue_by_doorbell_offset(struct
+device_queue_manager *dqm, uint32_t doorbell_offset) {
+       struct device_process_node *cur;
+       struct qcm_process_device *qpd;
+       struct queue *q;
+
+       list_for_each_entry(cur, &amp;dqm-&gt;queues, list) {
+               qpd = cur-&gt;qpd;
+               list_for_each_entry(q, &amp;qpd-&gt;queues_list, list) {
+                       if (doorbell_offset == q-&gt;properties.doorbell_off)
+                               return q;
+               }
+       }
+
+       return NULL;
+}
+
 static int reset_hung_queues(struct device_queue_manager *dqm)  {
        int r = 0, reset_count = 0, i;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 27e4859e4ad7..6cb33f6d71e2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -523,6 +523,7 @@ struct queue_properties {
        uint32_t pm4_target_xcc;
        bool is_dbg_wa;
        bool is_user_cu_masked;
+       bool is_reset;
        /* Not relevant for user mode queues in cp scheduling */
        unsigned int vmid;
        /* Relevant only for sdma queues*/
--
2.43.0

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------nNK00Spr7K5NG7M0h0CdRbOR--
