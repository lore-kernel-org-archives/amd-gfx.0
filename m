Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AFE606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 04:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2l9Foy+p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 709B710E2F6;
	Thu, 29 Oct 2026 04:32:07 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010004.outbound.protection.outlook.com
 [52.101.193.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0349E10E2F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 04:32:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCnWnvE6qC6/pDyxf7ra0XsbCmyKO18J0xkisQanBZZ2Ee/fDO6LkpGnXFiC6tHtmzDgsRuYEg6auMkirfZBofPFDoRBxGCbWgrtV7lA7xZqkQbV/cOW44NZm82tRWSq3S5+8SoJZqamoemEIVNC/j1XvglJEuxQuqJR+T2gv+/vpu0nvtPuT3gyjsGEzZSVcLEUP88bokDhF3bew2GAyU8s5059nhyg7Vdek1HjXX5NBU02x70WVVafuyJfNsyjPRmjpEFXhuivSQ9kc/TiF+Yfib4FwHJ9Ps73EYKXb5btcAWHPwLSxz4bR+kuD1zFOwarWgvnwfF1ihVBfYrg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ql0yvYemPWjzaVp0+nTPvBKqxJDrNAT00QYJIpcMvl0=;
 b=Xz63IszMAfqn8rGQ6M/Lrj0UkfciTgcM49arZ2vd6BqOCuj4P6cGlVnNSbtTnExvHMQ4OE7pvNyjDBjS0Mim2vwuSEVSI5XUuodiIN/hZ096qp9uoRhlI4fvuofGxKWJYOwYjaKDTClBvsv14zNpHZQfQbq8UwIVgVQR0xkPX/ACQA1XzhGKh/YohT42DPA673kjmTw2aty7z8tcIVuozStO/tnAI/WhbeurKMg6x+sFOHXaIOxef9jt1Sf+LjDUM+obA0EAO6oG1ZAK87SAwFFQvA87z74tfSJaEFZxAFUKHJSjUdecf3321pS7Kct4jz44A0JhCc4lSxh9F7VoIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ql0yvYemPWjzaVp0+nTPvBKqxJDrNAT00QYJIpcMvl0=;
 b=2l9Foy+p5Zpn3uz55DTeaz28Nk/jSOeplIKR7wil6GYlx8WDoSmLS+PKdf33uOw39yD/NRmTEvZ2OyxVydN/4gkadbE+WngiiducLMrWbHmrnO9b7ZF+D6OxCO1EJpeMUS3egGCb7O9BmYCz2FJ/9Timm6eHvzZQUDNT3E7c5jE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS2PR12MB9749.namprd12.prod.outlook.com (2603:10b6:8:2b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 04:31:59 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 04:31:59 +0000
Message-ID: <c1c0d2e6-aaf0-43cb-a9de-050f16ce2089@amd.com>
Date: Thu, 29 Oct 2026 10:01:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: initialize VF2PF work before it can be
 cancelled
To: Chenglei Xie <Chenglei.Xie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Zhigang.Luo@amd.com, "Skvortsov, Victor" <victor.skvortsov@amd.com>
References: <20261022153132.211631-1-Chenglei.Xie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261022153132.211631-1-Chenglei.Xie@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0204.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::16) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS2PR12MB9749:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5c6b7f-b8dd-40b0-67b2-08df35759258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|261028144727099003|56012099006|11063799006|261009223027099003|261022075727099003|261009223327099003|261009221727099003|261009220027099003|261009221227099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|10067099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AM7UuVEJWjo9p1jZ3ZydIOWTwMjnciQgofZgf6iM5suPEYirZjSKodh0jhhKT9KjcYtHYQX9/rucv0j1zXgweM7uYyjl9T66f+HxAoX6zA7TkNSDGTw5wrNXfxSVJ6SbLUOG04a+KStt5tDJSz0+vlw/Mx69Uxa2elRPSqNrxgDUyqcUDHcmpGsxwtuGSds4InBKWKhSLKcBaywBxfZGi8TPqA40ER5hY1klHSlTF69YTV//PSNFmH++GLnCJnZC3V3RSTx7AR1mGIHrrLbT74QHFNfCRp1uZ+a3GHpV+kaLLk3gxhEgoGsfR+qSIGeSDKed4GDloWFhoKodLsulb9mnPXZreamX8YkAr7/kHdGq8jeq4yGDNdHX/O3R1VbB5ySDreDFX2kS4eFPyb8NzC1pXuHCNo4b7AlDD4xESMyaxFri5Do2NEmp49hCFLNMLLlimFxg/CquKw8uwMFuNAXgB7I0xEXD0hlhKKml5NSJR+TCkohXX/qPotYtWvbRmlvyVMljCgN083kcJLWNtZF4PrkHt1yRFzHJsUBIFBVzw//YLG713Q8DsDNyWX8csAav1LTt8tvKG1S2kFcvoXKNFVCgo+brRgn3BoTExHkxEbo28ZCwxSIKu+9CAyyD38aZ7r1DF+WW/k/QGvUJTXKecqdgDjq224sIy5BUrV8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261028144727099003)(56012099006)(11063799006)(261009223027099003)(261022075727099003)(261009223327099003)(261009221727099003)(261009220027099003)(261009221227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(10067099003)(261026121527099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlZhQXZGUWZyQmR4SXEySEtRUHpkZ0NMTEo4NWdHMkxqZExCaDVzTU9pVmFR?=
 =?utf-8?B?VDRKMkh6Q2hZajhvVE5qVGl0blBYK0k5VHc5VlpoWmdiWm94alYrblJRQWdK?=
 =?utf-8?B?TW1JQ3c5ZnYwRGhibDNPYmt6UUVHTWNTUjF3bWhjMFZ0V0tLdXVDUHZuMzRa?=
 =?utf-8?B?ZVVER3JPUzA2VUVUU2wvZmVDRGtFVEE5Zmkxd3J2R2FJUG42RmhJNFM1ckky?=
 =?utf-8?B?QldJSGFEU21qT1FpQUFLTStqTFZIcTZ2enhaOUptd0Ftb1hXOFZKOTAvZHJU?=
 =?utf-8?B?c0VCQTRaVXMwK0FrNEFhcVZGMzNLUGRZR1Z3dDBYZzZVT1FNbmJ2b0pISUs0?=
 =?utf-8?B?ZEVzL2J0YUdhNmNuc0tsc0lpVG5nWXpjQld2WkxkL3Z5V1RDU1BGWklVWjF1?=
 =?utf-8?B?ajV5bElPLzhRRlVGc01lOXlYLzhycDRJeWdPRU5TZ01VWm04SEZzbnE4WW9G?=
 =?utf-8?B?NWVJYlp3Yk5aMnpLSFNtTWVPdGg0ckNLMDdzSmc4bG5NSEhOYURxbzFOVS8w?=
 =?utf-8?B?dW5tZ1VVVWNUMDc2ZGxkcmxXUlg4Mkc1OE1SWUtpZUdmWU1nZEEwWHMvODJr?=
 =?utf-8?B?VGU0RUk3Y0dDY3JWb3NQMVhTRENRUGJ3SFlETDBWTTZ1N3grMXo1S2ZmbmxS?=
 =?utf-8?B?T0lGY1pMTHA0bEg1cVJ0eG9PSVI3NVJJTjJzVVJKZmxlNEN1RDlFUUZvTWFD?=
 =?utf-8?B?M0dwWEVteHRFdTF3UW9GYkl2Vm5PYlZBNXUzclBiK2lGNHdacTFxSTVrSUd1?=
 =?utf-8?B?ZHNHSGxBZUtPNGxvK2o0TXVjcWhweStHQk1kbjN1TVQyZXZQWjdlaW13SlYy?=
 =?utf-8?B?M3pTaFYwZCswaDRpTzZXeDBCaVIvVk9wR0kzRVZmTFFGM1NuMVhBQkliTVBH?=
 =?utf-8?B?S1ozZlMvVXdWVmpraHRjS3BQQnd4eDdvbEtyQnZSZVVqSENzbSt6V3VTQmlp?=
 =?utf-8?B?dnZJYm04NVVYQXRTOHdWM00wZ0tNcFZSblJac3FXUTZ5RXl3dFhUR3RaeVlr?=
 =?utf-8?B?L2RITzRWTHBva1poejdCeW9ZeDNzRGF5dWFzZHlVL210S2lwUVhqS1d4NmhX?=
 =?utf-8?B?bFlSTHVKVmg5MUVKZDA1TGdkeWV5NnpPOUUzSVRrRWdGR2ZDOWJ2MC9qaVh6?=
 =?utf-8?B?RmR2ZmtsZ0IxdmxQd1ZsRTcvZHREdnpJYnppTzdNMFB5RkFBRXY1T25mNnFy?=
 =?utf-8?B?SkwrbWFkYWRKYmNoUVRFbnZIT2Mwakd3SkxXUDEza09aaUcvV3k0T09JNnNX?=
 =?utf-8?B?R21pVWFXSUFCakdmR0dBYjVOdFcrVmpNZFByazR4Wlh6OEFGNll4eXEwVm0z?=
 =?utf-8?B?RkVuaFlVWmw4WDhIYXZVVnFLRWtqNWhKODc3UlFoKzhXNjlpWXZKQlFCS3Fj?=
 =?utf-8?B?QVVidG9MU3Z4cys2RzZpemNVNEZzSWUvdk82U2g1TkpvRWE4V2ZMYVEwWU9K?=
 =?utf-8?B?cmN0YkZySWRqbkhYNzU0TWJyRTZXTGNqY3pNTHpPTVNVODhvaUdyQTdzVWE0?=
 =?utf-8?B?SDBMdmVhNTM4TmpJYk1OdnVBdkNaWjdZbFFlYnVrWDJzRTFZb1EveTRUMjhX?=
 =?utf-8?B?Z1cxY3pMc09qZnRvQzE2b2ZmTkwxaThrNVdyU0hYOTFCdWxtT0pqeVNrK2p5?=
 =?utf-8?B?YUxsMjNCSW1mRHl3Y3pUNndtUWd5dVFzV0ZETC9oUktXTFE4blM4ekNiYnJR?=
 =?utf-8?B?SkNOQkRlYVFWbE9iRlhxQjl2cXVOOXRjMGxKZnhleG03N3pINWNXM1dFN0xs?=
 =?utf-8?B?eE4zNEx6S0tCdVdIZ045UzNRRk1Kc3Z3ZFFkNnc4KzNNYzhaWXA1bGE4c2g4?=
 =?utf-8?B?aFpvYjNIRytnTGRxcTJ5WlNYRW5ucXRtMDFiaFB2VTVaR25EbWx1SHZrWUxq?=
 =?utf-8?B?aDh6bk56V0JJNjNXTVEwaDFuNVRPeXdCVzlYa29ERjRVOTJodDErOHpzUTF6?=
 =?utf-8?B?WWlUYXVHM01KM1RoSUp3UkdCOExFUGMySndRNEdLSlJMZmlWWGVxRmJOck5r?=
 =?utf-8?B?aFJ3NTVBbm9SOEFvQXJWZzNZeVRSRk8xdUp5TmR0K3M3UlRJQkZ2QUpJNmMw?=
 =?utf-8?B?WDFuMk5vaHhySSt4bXBjZHg4RlI4cEhBM3FqYjZNNTNuKzNVQ2tKNjJkTXBG?=
 =?utf-8?B?eWU2bncwZEdTMXBwTzczRnVYTXRjenFYOWExUllZWXNWRllQc0VEcXVjbFpX?=
 =?utf-8?B?ek56VktnVWZ3L2VoVTJCeWFNamxRRjVnbE5sMk1sUExoY2RIMmtNVDZGcUlZ?=
 =?utf-8?B?ZE5XbFFBbUNMTExiSXdJTVZEbXZaRVR2MXFnSDRoYTM1VlBEMzBiZXIwRStL?=
 =?utf-8?Q?1a1xoE/snzDcNSeB07?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5c6b7f-b8dd-40b0-67b2-08df35759258
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 04:31:59.4458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BG3yu/Rya9JmAjRPIsr5ofSJ25iEyOfLryP/VINQD2AOBEgbQq/Y8oESsoZgd8hN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9749
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



On 22-Oct-26 9:01 PM, Chenglei Xie wrote:
> The vf2pf delayed work is only set up on the ip_init path of
> amdgpu_virt_init_data_exchange(), which also schedules it. But
> amdgpu_virt_fini_data_exchange() decides whether to cancel the work from
> vf2pf_update_interval_ms, and the early init path fills that in much
> earlier through amdgpu_virt_read_pf2vf_data(). When init fails in that
> window, teardown calls cancel_delayed_work_sync() on a work that was never
> initialized and trips the WARN in __flush_work().
> 
> Initialize the work in the early init branch of
> amdgpu_virt_init_data_exchange(), before the interval is ever written. The
> cancel is then safe on every failure path.
> 
> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 4b1b42fee6b4..c1843c3d2692 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -842,6 +842,15 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
>   		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
>   	} else if (adev->bios != NULL) {
>   		/* got through this logic in early init stage to get necessary flags, e.g. rlcg_acc related*/
> +
> +		/*
> +		 * Initialize the work before amdgpu_virt_read_pf2vf_data() sets
> +		 * vf2pf_update_interval_ms below, so a teardown after a failed
> +		 * init can cancel the work safely.
> +		 */
> +		INIT_DELAYED_WORK(&adev->virt.vf2pf_work,
> +				  amdgpu_virt_update_vf2pf_work_item);

+ Victor

You may move this to amdgpu_virt_init(). Victor refactored virt init 
sequence recently.

Victor, could you check?

Thanks,
Lijo
> +
>   		if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
>   			pfvf_data =
>   				kzalloc(adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10,

