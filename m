Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B0DCD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 12:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE4F10E187;
	Tue, 19 May 2026 12:35:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H4zOthCh";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A593410E187
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 12:35:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ks1VdDOXx9Y3/7sh5nIjgdSlLwM7GscdYOlOWWdbac3LQMS8OZDilvLL1rbfF6KaKE7TGsPKwxyaWfOrFjxnBSYOgpAFaZWiXChGu7hUKDzk+4Bu2w04hpgolDfzGgZistpJukd6yLc68ZNlfQwoA+lIaNPfaVaTi1bEUQ5MKl0CC5bUcGPhl7Ggl7R+RDndWJARdTK0VNWerR1vp6jDiDAXVod5I9t/Y0o0LnLLh5/s0fwpxZZH5/XLh1rZCZ+dsgh9DWhnYwf1mcgumR6waFm83qawYXo0Xjy9AxSeKdnpvPeOYrsQux96tNgUTDifae4ZlCnT1NE06wRBd3qUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyR2IcaakCbmFpIcI9PxvBJQx46uDS7zX0k2Q3Oeb1w=;
 b=wi3+BJn/rYHXWobuynVq2goOCE1l7jVo/LUC/pZG7Tb7f4FjZLB290M3rhbBFpKKKM40MFNTlEKPOLPNyWU5YezoWSB2n4kzKtrmsMVRBdHUAbVEn93ovJzUFuG10YKYTZjddWNdsuJ1pYRkXSV0gQOisaxVv/4k7dXInifr8lNL4JtmMibDYGcFgDk3FmWBj/YtgPqMYewisihbFBoPYhpA886JM3XZU8xp07IoN4jTXcSvVnlMeJ4AMS53JZZOTbq4jJiJf8skEWhZZn0RJ3tEfkQsUIBAClVYdFlvu3Qgo7JL65lK8jTQP9XQ7iUjDOFkN3mAga14cJb3eDpd1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyR2IcaakCbmFpIcI9PxvBJQx46uDS7zX0k2Q3Oeb1w=;
 b=H4zOthChXWCLW6wAOQoh8RTDdlRXEwxeZGw90a0ue622oa1SG9xSkZhveNA0j48TJ/qRPfApTsaxli92rkG55TkYTlo/arcJZyFryST19C/OK9HY2I3/J0P0P/oseulXTPS4WdM34vOfgf0IEFPcEHQc1Rk/XwHssDH8UXcgTiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYXPR12MB9427.namprd12.prod.outlook.com (2603:10b6:930:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Tue, 19 May
 2026 12:34:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 12:34:59 +0000
Message-ID: <a342c55d-7bd5-496b-a6af-71341d253ffb@amd.com>
Date: Tue, 19 May 2026 14:34:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] drm/amdgpu/userq: Fix doorbell object cleanup of
 queue
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260519111801.1435954-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260519111801.1435954-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:207:3c::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYXPR12MB9427:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c2551a1-4af8-4d9b-3bf3-08deb5a30a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: pY3UEyrjlMGE4dIaz48LgGYjczlJXlRmnpnUi6NaJKSZh8hzZ60mD6+aaN9zmTMzDml5iFpbpTu6JXtPV44RT04sHjOjLD1XDwbCxdPBMxcexL0T6fVckvVvFexkfBsXv8Kld+OQsHs3+Zd1ZwSa6VBq5jzNZtJYpd5sBnnqti+qgswIbOKHiY42mS+N5KAgtmh4+zllAyT1asWyeegDaqGfIDUhBOpyzm4aQ29RjJE6EuXAIx9SR/vciR/VfPtpTaB9TQRnDL7/lQ3zvzBx8dED6NTfBjyU3FQ9dVM5IltaxgVNtpOVRp20IXF+NkFhG0eJmNnA+l/qpa03MnYJcwN7f5zwp6AxvDt/Vays1MClsBVSt+G0Hx5bnKeojNip9AoyDl4z6dxV25Hfvx8x4VD4Ym18sZZusmscOENxZ39RIYfEby+AUhNkAGxtnOUsQoynisqG5h/8caA6cI6xqXkr1QlesG1XWAj8zq12rQVrVv3jWYwvf0VwwSzwZpQn0Ju/o3VsPZUXjSJadK5TocwsYNNvs6MjnS8w8Kwemr0Ugj8sZMff141piVP0sGXOt85STH+soQwwM/hM1dfFiok7ImIo4S9Iek6Wsd+grnli6b5cPwN1E/3azdPvTbbnWNUzYGZH62s+WUriFn5zlQOIX0XF+Ti2xcoQRl6si+qnzzgrXtpoetjNY3HXBOix
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OStEMFFpc3BDbWp4ZGhUbzlaL1pDZDV6OGNKODFBZGs5ckdDS1VrRHV5V2Jk?=
 =?utf-8?B?bHE0MTc5b1NocHRiNWlEdURDQ0hrL1ZmajAwU1dDbGhhWVpFMWIxb2JLTWoz?=
 =?utf-8?B?VVdsVnJGTkNiTjhjU3BrNjJFRlY5cWE2amJHaWNZQXMyK3ZOSzVLZlJteVp6?=
 =?utf-8?B?SHgyZFhyS2tWVVhuczJ4VFZYeVNIWXZwbnY2bzV6dHdrSTMyVEhRODU2SEZV?=
 =?utf-8?B?Z281S3hrNnpxWklITEptVkFJQmo1c0ttNHY4YjFSaHhESW9LY1FCSmkwbm5N?=
 =?utf-8?B?dnJobm1ncXIxZzdmWkhzM3J0eFFITFVLeGdVSXV6MmNwS012YVdHS3NOZFZ4?=
 =?utf-8?B?d08wemFEWnJHK3VvSEJEVEFWekdGd3dsUFpsOHFWRWJlNWdKWm85RStjN0lD?=
 =?utf-8?B?RThMME82OWo2d3BDb3BRU0dVbDZvczRjZGFnOTlWQ0QrWDh5R1c3cnprWkor?=
 =?utf-8?B?WUdCWFJQWTBzWFJOSnhVUGNxMTFxa0JscXBReE1lS2h0cjExT25MSnR2ZGp4?=
 =?utf-8?B?SEV3cHVscTl3OVFzbGpidml4Y0VvRk9yUU9nWTZlQkxjNFZiUlB3MTloWlpq?=
 =?utf-8?B?elYvTjFVdE00QWdIQkk0aDFhOCtmenVIUHJuV0IxTGEycU5JYk9Vc3Ftc1ZG?=
 =?utf-8?B?VlQ4dGc3M1VCM1QrVEVjQ3RVc2JtQkV4cllEcXFEaXV6ZlNDbzg4VHRLNkNP?=
 =?utf-8?B?WUtSZE8yQm13VVl4WHFMRFQ1Q3lETjhXOEd4UFQxakxqbGtMenJIcjM3VERX?=
 =?utf-8?B?SVhMVUdOZ0RJbzFRcStmVG12REJRS1dzajV5Vzc2TG5BbUpvWkY0dEtaZGlH?=
 =?utf-8?B?aVlZUklVQjl3WkhXSVU3WkpIVzlZRmMyME1yeGVHOTFYelRxK1FwazB6Zklw?=
 =?utf-8?B?RFVITlZGRmtJdmU4MFFoeExibjg0amhUQWM5UjZBSGxYWUNFUjNyNmlMemp4?=
 =?utf-8?B?UnhHNE1RN21BOGdwOC8vN3ZEZ1JMTDNPMDluUmMyWWJVUTZDNnFtL0tuV0gx?=
 =?utf-8?B?UWtPV1hlOW5vSjdtam8zZWZuZDN4ajdDVnlCc1IvZ0hEZVVvbjEzblk4SFd0?=
 =?utf-8?B?UFZQdDI2a29pTDI4ZGU4MXBEWTFsdDllYmF6bjdBdG41QTBpNU45WkxPbVBN?=
 =?utf-8?B?VUJPd3BGMXhSRm1xbW11NnIyOVdrTkRFY1JhMVNHYTlwcDhmZ0tZNkM5MXlX?=
 =?utf-8?B?ME9zSGZ3TU5Td0k0ZUhuWmpmcEZYMFhYaDFHM3VWb0ZNSG1OZDdIUExqZDJF?=
 =?utf-8?B?bndmb2w2akU3N0ZsU2dkanBudlhaL3RBWjVqYUEyaWNyQTRGYXZ5Qkg2SXBx?=
 =?utf-8?B?QndEZUVxMCtMNVk1T2Nhb1g0cXh5V25GNnZyMlB4eWJ2UUZxRW1qdmtIcGY2?=
 =?utf-8?B?c1A1N2l3YjBkWDBpUHBSZFpWZzFGZ3ZXZWtFM1FOVCtTTUFiTlRRNUVuQ3dn?=
 =?utf-8?B?V3psdGtMSkNzcFhPY1N6RWRYTjVseXJRekkrOHRxUm5LdEF2SG9lSlNCRzAw?=
 =?utf-8?B?djFrdnZvelRYcEo2Q3lURWI1RVRPbVYvbm43MDI4Nm05ZzU2MDVlbHAyNUQy?=
 =?utf-8?B?TStkS010dEtjaFZyK05LUWZ1WTdGWHFyVVF0THZCSUpjVXZ0YmJLejg2aEE3?=
 =?utf-8?B?d2NNMzRUSFhLT2pDNGx3dmx2ZFBLL1F6ZENzVlpmNUU2amQydWpSVDAzalIz?=
 =?utf-8?B?a3ZQWExFazlBK3hvQThMUmRHbzVVTytLWEVFOG1qSkhZZEVyVFZWNFN3WEhj?=
 =?utf-8?B?SHZaY0Q5d3ZKeWE4ZjJlQ0VJb0tDUnB0Z3hSNWVnMXRqRUcxc2xEZVFSVzVX?=
 =?utf-8?B?VzhNRXVvMHNyUmk1Q0s2eUlkdnFFTXlwWndSSWlTemF1NzlNR1hmY01FcUor?=
 =?utf-8?B?eTZRZ0ROUTlJRFBqaXJCdi9uc2MyT2pvL0Q5UkVUNUJhNkxlSTNOdGU1L0VV?=
 =?utf-8?B?NDZVQjNPaTFzQWlFbURpRUVwb29idjdESHlyQWx2Lzh5WnhURFBXc2FXTmhl?=
 =?utf-8?B?Kys4c2xOTFhIRVJlS0pSODJuNmM0MDVINmUweGlsRTArKzFsemZZQmEzOGo4?=
 =?utf-8?B?N1RNalQ5ejJPTHc4K1gyYmFUSXJDOUdPZjRsSHA4MGZXN3ZCTnF5aDdCa1M5?=
 =?utf-8?B?RHdiSW9xTkFwZ24vS0JsZ2dONEU4LzZwMUliUHVkd0FudDc5Q05YNFZnQXpl?=
 =?utf-8?B?ZlMyYk1lWGdZNXpidW12NXRaNzR0b2RoSHQ4dmlMUVE2ampPcnJTcVdUUi9p?=
 =?utf-8?B?Y0pCamlDV0ZQeUxWNXRRNHBUSlFCaUdlaDg4MXErOFZ2WDE2dm11S041V21t?=
 =?utf-8?Q?PrJafb3Nznoo/oVLTm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2551a1-4af8-4d9b-3bf3-08deb5a30a6c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 12:34:59.4841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qep0IaXItO0cVNIXFINKkAeWifJODGyUNpv0xCTGNsw71OGx43wS7VFjsXyZQe0L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9427
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

On 5/19/26 13:17, Sunil Khatri wrote:
> Unpin and unref the door bell obj if queue creation fails before
> initialization is complete.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 154742bdd5a6..eedea84c5e0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -787,7 +787,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	r = uq_funcs->mqd_create(queue, &args->in);
>  	if (r) {
>  		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
> -		goto clean_mapping;
> +		goto clean_doorbell_bo;
>  	}
>  
>  	/* Update VM owner at userq submit-time for page-fault attribution. */
> @@ -808,7 +808,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		if (r) {
>  			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
>  			mutex_unlock(&uq_mgr->userq_mutex);
> -			goto clean_doorbell;
> +			goto erase_doorbell;
>  		}
>  	}
>  
> @@ -831,10 +831,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	args->out.queue_id = qid;
>  	return 0;
>  
> -clean_doorbell:
> +erase_doorbell:
>  	xa_erase_irq(&adev->userq_doorbell_xa, index);
>  clean_mqd:
>  	uq_funcs->mqd_destroy(queue);
> +clean_doorbell_bo:
> +	amdgpu_bo_reserve(queue->db_obj.obj, true);
> +	amdgpu_bo_unpin(queue->db_obj.obj);
> +	amdgpu_bo_unreserve(queue->db_obj.obj);
> +	amdgpu_bo_unref(&queue->db_obj.obj);
>  clean_mapping:
>  	amdgpu_bo_reserve(fpriv->vm.root.bo, true);
>  	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);

