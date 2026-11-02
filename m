Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7265606A324
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 04:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=is2N8zv0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5991010E512;
	Mon,  2 Nov 2026 04:29:34 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011059.outbound.protection.outlook.com
 [40.93.194.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 258F510E562
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 04:29:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bV6V2Fga3RG+9HOpEawRpBqonRfBY3pBGAfuHt8CIOC4/5W18zMeeypE/GjwfHRuqhzAQ9QOgDysBoyuy6fnQ5s5iVszOD7GoB2H9i9ml+V6aZHkIs8g3WQE1ZY3azPYJ+EksGakayRNNIfGCllqg+fMFKFdT5TpbKXF7bKJmC+UzOdYCvctN9kFrMhI/VNLKwYnJQVWVqi1+2gZ4Ef/HLHA4vQA7vg9gqYhdwLOR36FAh+TruSk32h3T9KR3QMP/ISLlOatOvgKRx9Bz1sJgDmuecU07YlOvvSNymCINuaTWn3rm6Z2gR6OebnOf42nl/lulqag1dajy/fBqg5cUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPjLqSYEmAEGB77iMgBEdsWhv2XUJE2Fujl/f2r2ZHs=;
 b=ZnWYghaPdroPE9iEGwSOvfK5pf/pMIvVNhupxvx0Cp0GkQf/mKO/EaQ09I5sQnyVvUawo8LM+n8S/4e0NuJK7rndEyLnmoLeK9LN233chUUFTCau5z4nYsPc5PJM3a4CtaXQ0X1hmDFGe8hziMF7ucIVM+JIiHMJGQKLa5m1Vjcbi2Q69KKZwMZw3i7xOa8xSQ/y1fFaZbwkmAYqE9k52WlAQL+ZJzG5fXkwuM9DhvYB6GyB/mLm0ybFC9JzuyLMFXgGGOLXKAxd23bhefmWljNNxD+qFdMrYGoLr49tSfaZKsWkRntxYXOPV0mGVPEJrXHZo1OGcFhYjVeQzZRb3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPjLqSYEmAEGB77iMgBEdsWhv2XUJE2Fujl/f2r2ZHs=;
 b=is2N8zv0Y300hq/udi+DwtNJc4AJpn4TZFePwhzUPLjgCnlIsJsu3Sb++o0ckeK39NZE1HIz5Pc6TmJebDVuLrmaI5uRt6Ihik4BdJolswBO3JWdAkrLd2uogGt1ZJ0vrz67KasRbHJGWyN97TKCIiYgpEzMlTYxjFSGOyyo3lo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 04:29:25 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 04:29:23 +0000
Message-ID: <110d7c2b-170c-49d2-a3e5-d243a4b275d4@amd.com>
Date: Mon, 2 Nov 2026 09:59:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: initialize VF2PF work before it can be
 cancelled
To: Chenglei Xie <Chenglei.Xie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Victor.Skvortsov@amd.com, Zhigang.Luo@amd.com
References: <20261022153132.211631-1-Chenglei.Xie@amd.com>
 <20261029180652.213481-1-Chenglei.Xie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261029180652.213481-1-Chenglei.Xie@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY1PR12MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad6eab4-091c-4ee3-94e5-08df3899df1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|11063799006|4143699003|56012099006|261009223027099003|261009223327099003|261009221727099003|261009221227099003|261009220027099003|261028144727099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ipfjX2SGYK6lMgxxQdmbf50hnnDgqZRJI8Ny8FXgXLbyZoKdv8TxWXex5DmDrvsJZNyaQBW5MuKj80C1n0cCFTRXM9ImXZ0WzvlAHk7jroIHcH1tyQ/i5Nk4mp/gjAS2USOJ2pt4g2UajCTgYCxBjIGLCbCfr3KEHwmpXWyLM1hhxzHBX5ZdnIv0jcGk48yl//Rlj39LN6Cb51dm5cEIgoYJ0RWps329sr0+helGxrITj/TPIb56PdqBrj9Ye3bkd9S8NrXorBpcoozATt8TSFywBPQmwC+z6f8/FGBCLO40/+UG5waC96clGZzau0mG0XiDc3/bjVo/LmKr5p6YkWJbOzJXw9avrshM/P9ttmSrnv8AQyNJEJdvD1scKwD5JF89kGE+3FWqyEq/kalnaZAQq/Vud065TWlTHI9lntGFOItgKdKrVEpUWp5Z1TS4KIjE1fGoVwqhOZ/HjFY2Ags/ZajhVo5iYbtJGDPoW4RCoN6ZPa1UzB7xorC5uf/3iA+Q1xRHT81Bk3YQwJ4b/Ox2O4UI8xeWT/9QiadBdQV6K+sWIemj9uJrsntc1AVQhNzlPPfkGc9Q5laii2Ova8yWkEv0k3EECfInp/PnMcl+5ZR0kXPI+ssHPDn4ze7YbLQ/7PVaz9Mn+xMN+TMqiBSytCyQ20I5MTOUogiOsDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(4143699003)(56012099006)(261009223027099003)(261009223327099003)(261009221727099003)(261009221227099003)(261009220027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUNvWUszZjMvMmJKaXhXbXdWSnVFOFhrRkU0bUpESGo3dGtmU1pWYk9XZkVp?=
 =?utf-8?B?Ymowdk02K3E5UERJQ3RCRG9xeUlKcWU1NHF0QU1qWjBtajVRbjhVUDQxSEpX?=
 =?utf-8?B?dGl4UDNocG9ubTU4WGJFQ3FLOGViR01vdXJjVWMrU0NaZzAyYjNHbThYNmU1?=
 =?utf-8?B?bUNtVzV3bXMzZmZVdjR6aHBncFBpMWJSSHA2UEVGN2VISTRmcXVIUGJ6ekkx?=
 =?utf-8?B?OUVjSG55MGZxR1Y4c09rTXVVTnkxRDZqSXNzL2syVU9mNjFkMzhMenlYeHcw?=
 =?utf-8?B?NGR0QnRTQXovb0NoMFBURys5cUFjSjRvMmFqZUF2elp0MnlnUGxmdzlIZkkx?=
 =?utf-8?B?ZHhWTHFkU3dCd0tJWWZCZG1tSFg0NVhNVVdoaVp4Tk5EQmQ0YlRlb1h5SEg2?=
 =?utf-8?B?K0c5anNGcmRRQzJHSERVUW0vNGFDSVdQZDFScnRwSlZkODE1eldSclEyZzVJ?=
 =?utf-8?B?NkNJVENkSXZPeGEySUUrZWVjcjBMaWRnSzJQY2FnekRlNHo4NUFybzhUa1ZM?=
 =?utf-8?B?Tm5LcTNqckE2NUJyYW1Jb0l1MjlIODZjaUZTcGlVUnR1WXF0b3hPZ0VyTkRW?=
 =?utf-8?B?WHJjcjgzK2FjK0dpU2luSldpd2Zaci9GdVdZQitoYUlWQmltajNsUjlEcTg2?=
 =?utf-8?B?dXdnbUFoT1hDT1VVMGxTNjBweHpCM2VnVmdqQWVJeUFHZFRKSlhsclR1MGJq?=
 =?utf-8?B?OWV1c05PZ0VqUzhDREZSbGp0YTJXTWhNeUJIdFpteUtYL0xiR1poSW5BTmps?=
 =?utf-8?B?d05WUnlJc2pqenFOV04yTDJtWnYxTnl5aEZab1dSOWRtN0tpcTFxNkxaRy9V?=
 =?utf-8?B?SUNCMy9wRSthRUZBYVpFd0xPRjVEb29Zc2NRQ3Rzdms4OVR1N0hSREJ4d3lX?=
 =?utf-8?B?MTdQaE93ZmhsejYzeENLRDBRbnFnZUFheHJVWFp0eXZBbEFYaVdNQ2o1QXI5?=
 =?utf-8?B?N2I5Wlk2WG5PbzkrZlhxdUVTeVFDdmpSZmFZbmVTaHExMFB5VE1vNXNFS24y?=
 =?utf-8?B?TlVUSTM2cWZPemdyNTdzZUVRLzlyZjg3aFpPVUlMbCtGT2VMQThCVDVyOVp6?=
 =?utf-8?B?NUEyMlg3c3YrVS84eWRhZUE2eEVMc0RQalE0QS9senFUcjkvMllhTWt0eVZG?=
 =?utf-8?B?TXhGeFIxNjJqZys2Um9VeVQ2eGVXSFBxYjNUZFpDa1k1dVpZci9UbS9DbHpR?=
 =?utf-8?B?dDh5Zy9sZlkyL09yejdHQ2NVc2Z2ODNVWTU0TE55MUcxVHpHSWVtUVN4emcw?=
 =?utf-8?B?NUdPMW9ydGdEUE50dXpmTE5DaW94WVhaaHNXcUtMWURtTzBRSjNORWRJRE45?=
 =?utf-8?B?YkxrZngvUXk4TTA1Uk93SDFpOFVaWHpIZUplc0VnOWI0VVBMbFZFUlk0azBy?=
 =?utf-8?B?Z05xd1paWFlXdFU3eDVtd1ZiY3g3OVRyQXh0OGlOTjQ0NjNyREtqNE5RRTdi?=
 =?utf-8?B?UVZmQy84MzNUMjM2TGtiUnhxRkVaSEJWb0RDc1hWazQwcmw2WHNML2hjSHpj?=
 =?utf-8?B?TmZUV3VnMVhsTS91Q1BzRXVqUk9WT0VqenZiQTYrM3ByTTA5QWpkU29xV25z?=
 =?utf-8?B?MVB0YldRYlFQbncyVFFUVE5tWnhmV1B1dkFSZUE3Q2VUbGYzUis5cm1yRCtk?=
 =?utf-8?B?WFREVEhFb2RGRFJ0azFBekt2akFOdGJmcTA2NFRwMlMvRUlhN1gyeS9sbWZC?=
 =?utf-8?B?ZkFvVm1jY04vTTJQWGhQN1JQQVdqN2UzQ0k1Vy9XOUxpM1E3YkJVSFRUY0VW?=
 =?utf-8?B?d0ZHOWMvc0U3cWJSdzljejM3cC8yQ3FMbEVaNnVZeU1CMUc3WDJsZ1orZndu?=
 =?utf-8?B?RGU2TGxYN09SbGtlMmoxUnFDV1JOYm9QMWozRmJHK2diU0F1ZXRYWXBLRC9E?=
 =?utf-8?B?aENRMzFzRVZnYTl5OS9NcnRjRFgrQ1gyNzVjdXk3eGZLMkVoVzVSVUhHOGJS?=
 =?utf-8?B?NmpoblI1RStheGdzT0pDYnB3cGNyOExiaTFVZ3FGakxnSlFHdUNtRmVNWHFw?=
 =?utf-8?B?aEtCbkJXM0grbkJLRGNxVU53aHBEbUxiQ0FNZStmc2x5Z3YycC9abXdHU21r?=
 =?utf-8?B?N29Ec3owMmJYRTJUclh3cW5TUWNoNUN4dlNxM29Zd0hWQ1plVzNJWktKNTU5?=
 =?utf-8?B?dnplR0duZUpNT285RWVta05vMmJvWk5LN3c5SDNPM3ZjUkNJTTRsdzhVMW0w?=
 =?utf-8?B?MHI0ZTU2Q3gyS3ZxV0ZaME9PUFBvNFRKOTRnc2VSb2JjRFd0OTJYZkdmU24v?=
 =?utf-8?B?Qlp6YjNyaEFXaUQyS1VPV090cStsN05UZnd3clhVZitZWGgvZHV0NnFMZGpW?=
 =?utf-8?Q?GQXvnDi4tg0Ds0WmYt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad6eab4-091c-4ee3-94e5-08df3899df1f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 04:29:23.7860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOPXEOOTlG17AeYcxydjONL28novIYqkqu6ksBZPJlJSL/IWZb02g/XVnb4eKVna
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9601
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



On 29-Oct-26 11:36 PM, Chenglei Xie wrote:
> The vf2pf delayed work is only set up on the ip_init path of
> amdgpu_virt_init_data_exchange(), which also schedules it. But
> amdgpu_virt_fini_data_exchange() decides whether to cancel the work from
> vf2pf_update_interval_ms, and the early init path fills that in much
> earlier through amdgpu_virt_read_pf2vf_data(). When init fails in that
> window, teardown calls cancel_delayed_work_sync() on a work that was never
> initialized and trips the WARN in __flush_work().
> 
> Initialize the work once in amdgpu_virt_init(), which runs before early
> init fills in the interval, so the cancel is safe on every failure path.
> 
> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
> v2: Initialize the work in amdgpu_virt_init() instead of
>      amdgpu_virt_init_data_exchange(), per review.
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 4b1b42fee6b4..576a818db522 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -838,7 +838,6 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
>   		/* go through this logic in ip_init and reset to init workqueue*/
>   		amdgpu_virt_exchange_data(adev);
>   
> -		INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_item);
>   		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
>   	} else if (adev->bios != NULL) {
>   		/* got through this logic in early init stage to get necessary flags, e.g. rlcg_acc related*/
> @@ -1249,8 +1248,17 @@ void amdgpu_virt_init(struct amdgpu_device *adev)
>   
>   	is_sriov = amdgpu_virt_init_req_data(adev, reg);
>   
> -	if (is_sriov)
> +	if (is_sriov) {
>   		amdgpu_virt_init_ras(adev);
> +
> +		/*
> +		 * Initialize the vf2pf work here, before early init writes
> +		 * vf2pf_update_interval_ms, so a teardown after a failed init
> +		 * can cancel the work safely.
> +		 */
> +		INIT_DELAYED_WORK(&adev->virt.vf2pf_work,
> +				  amdgpu_virt_update_vf2pf_work_item);
> +	}
>   }
>   
>   static bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *adev)

