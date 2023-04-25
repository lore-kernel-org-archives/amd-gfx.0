Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0F1C77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 12:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D2E010E25D;
	Tue, 25 Apr 2023 12:27:50 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 413F210E25D
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 12:27:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f90AIM+cn4iecdEEmnXLd26w7JW2CZV2wsOwhekBPZUmEBBSceHa62o1JCPKNvFPrADs04FfLWNlQLo8k3cOkfDvQv8RabHYKC3rbQdQIC6fTcGzezFlAO27R5vqUJtldtAYxPqOrPF9zDYGJb7gz6AvyHwVlSrZCuAITLGNW3qTHvBi7Rq8Y7N8gQ1HAgJov8AAfj/ZildZI+uuRC8LzB3XKh159N5bnTv3T3xJYg3m+nZ+AATOy7UA8m0jkusKljtomG5/IxR9B/1/WLMEEdBJPh/eq/kUjR6kjTHmQLStEw17NA7jjgCdLlO2I0hEmDRujLpAMWCW4W0MFBuZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qcs2LE7mNJwsZXjwVcjr/lRyE8vApy958vtc0ET/mo8=;
 b=F/nsQX19xCLW+QlHCrVjY8WIg7RUywTXIXt1OgfDJYRO+97+ZBnkbwmVfpoPBUSIIVe8CaT4R7U6cLFl9aHGeGqB6HRw9L3bCYV5j3h4rRGhbehNlP32lsB9EWz6r4kiRdbmNKW0AoOCSpXYuYqSIPPAqKWHzhrOPRxK9GiMWiPcpHkYRLBGWAwJ46ZPuu/XrarpG4eWMbn8Z8ZFloGvWSSg5uitmXeLiFQ1/wQfziXBZMAaaCA71pWvpheTyVd/IE9DE5HUmoqtxMD3pP5JqAqCA5qsmNxOeUdvFQl1QE90KJhFz3WgpmAb0FXkzivrjkBzLmsPOnhDEeMjrV2krQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qcs2LE7mNJwsZXjwVcjr/lRyE8vApy958vtc0ET/mo8=;
 b=kBEqnnOgHe5BEU+CxaKCXYMa0MxxUKt+XSsKSV+2RPyt0SsA4RLwkOWCPNphzRKMBDWaXzLK3CdAOkkGEqG1N063Ft7NTUmd29ZNSLRZIrIWEC/XFRiiBpW2wnGodGwCIxo1InVUIWSBXKDa+w8fw97n862rDj52cdYv5fdGBqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 12:27:46 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 12:27:46 +0000
Message-ID: <8670d699-dcf9-f8e9-a11d-e87bb40643d4@amd.com>
Date: Tue, 25 Apr 2023 14:27:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 04/10] drm/amdgpu: create GFX-gen11 MQD for userqueue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-5-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230424173836.1441-5-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 13048f2c-c002-40a1-86d5-08db4588795b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6V07oZTgSsu9ywENxkCU1kMkXABvtpkqkU/rKDewcnMPEpOVboRf4kJ1g2lzbWGZtER9qQowIt3SeWTPRSKOvY372Jmqj4oXJpFg8xQj4ztd3U6BIwAghbK+uBVK+sXkW7e1TfBM05qRcyKWGFaTsk9v58nmcyMNpgpovWA4njlPwPnYCHjdAeoDaBXSAbBcZsqrQaF7CMUoNxvXz4s7XxQDCK761G/E63Zp4R9kJhlOzpW3hdFwcuB3dCGNfepP1zNEh1tR9vMdt6kQsx0l3WBPR6exfJES5nvxnp1Z0NnnxBLmYQ/nNRsX7WUSjMMjhUGJla7sU2GhGAr3DC6ENXSA86vgGu/7CxOb2KdF+aU76LncO5bxIV54OR6zY4cpNpfp0rafj11icmZDnzoZf7p3e/Oct09vKt6XeE7WX4KTnXylRu16c2qZdd0M8P6mP+cPecLSUgbEJt1yy7XTcZWeKBgpXPaFUTnTZ5Gi4DVR08zTfMiPXmZLMNQQWizWVmmbYh8Fui8kFifTavwrM+IzEXZbz4D2pn3TqVkK1/brTTS5QWgtsPvASQs5Bo0p2vIceWIJ0N6cZyiaRHH/ndbuknP8SZL5GlwIUTReXjrQzzhn35ktsZM/zQy+o1ok9uuraO/vdkTTYfdcN3Aexg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199021)(36756003)(478600001)(4326008)(316002)(66476007)(66556008)(66946007)(41300700001)(2906002)(8936002)(8676002)(5660300002)(38100700002)(2616005)(31686004)(6512007)(6506007)(86362001)(186003)(31696002)(6666004)(83380400001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmE3M1M1NGhWb2hrZUNMK0hDZE1oYUNTQWlMeXk4b0lrTmtSazlYa0FzbXQ3?=
 =?utf-8?B?bzc4d0RLUnphZnVTRjlzMjg0V05UZHMzS0RRSW44bzlLZTU3VjNERVBIVzky?=
 =?utf-8?B?Tk9KL2xFaC9WZ2VlMHVUN2FVeTdrMDdwazdPdkZvY2habU1abG4zTEFEZU1F?=
 =?utf-8?B?VnRoWHFodFVUZ3lpdGRLdzBtaTJuSDh0QThlZExRaEdoR0o1bkJIZWZDVVky?=
 =?utf-8?B?ZERnYnlPZmlEUEtoVVU4aDNvelZEWXloK2hhTFlmK0c2WHA0N2FYeGRPSDNs?=
 =?utf-8?B?U2twSkhrQ2xBcHZTdVd3dXV0TzFhdU1zWnE4K2MzcFl4M01oZ01nL0RzcDY4?=
 =?utf-8?B?eFFkUENUUjdEemltLzFld01RREtMRHNQbUYzNFA1K25uNjFjQjBHcmZ2c01K?=
 =?utf-8?B?dWVWb0JJTmxyT3N3MEhKU1p5TEswaWlsSWtIcys2Z3FDaGoxVXpERVd1Tko0?=
 =?utf-8?B?cVBmNCtpYUdhSTFrOW9ERVd0cW5kaGdJbUNnTnl1a2pGcmxaM0tRR3c5cjFO?=
 =?utf-8?B?WVZ2ZmlFTkJPRysycGFsTGM2YTBnMitJcUZCSitUWVBUV2Q1MGFZVkwzN1RC?=
 =?utf-8?B?TzMvdFRDbzIwRHg0UHVaQzBhL2oyVENJTXVHN0QwVlZJd09maHZIclB6SlRN?=
 =?utf-8?B?dDNib3VpTnVuTDdkZGVhNXNEV0hGODNSZjBYckU4SUhoR0haaUpBTXozSmo3?=
 =?utf-8?B?Y0s2NXQzTzBGS2tLU3JQaE1hR3E4ZnRqTnlIVTRWUnUxeG1Cd0tHemxYTDM5?=
 =?utf-8?B?WGJocHY0Y05makJmWi9zeVhDQnphTkxPSmlpaFZOaE9IZ1VUUFo2dC92NXp2?=
 =?utf-8?B?ZlRKblVwQk0yZzNnbFNGZWxzdG8zZk1XREl1Z2kwY0JnaTdnaWNPTDBFZmh4?=
 =?utf-8?B?aTNVSmlvU3U0UFBrU3RFWmZucVJidDlGNENER0o3bjBha0VueWZldkNwV3dP?=
 =?utf-8?B?R0lUNUFUV0lrMEhZaFRFeVRlb0FXRnIxenN1U2o3K0VXNkxYMXpra3VRUDNx?=
 =?utf-8?B?RGhxR0lKdHBKMGJVbXhOK0tMN2l3VEJOcC9ickhuQWNGckMxUDJJTTJLckdx?=
 =?utf-8?B?cXdtTkR4N0ZGVXMvbm9MRzkvaUNCaENVVFRaUGs1eEEreDFIOE1kR0RLQS91?=
 =?utf-8?B?WExrdUI1MEZpZGJEbUVWQnErUmIwejRZNUQ3eloza0k4Z2NNb2RJeHJXZ3d0?=
 =?utf-8?B?YU1JV29lN3o3S0x1a3NGTlBvRCtTN2tiRmx5NVo0elNUZXByYzQ1aVVTUURo?=
 =?utf-8?B?WldBajI3TzZuUUFja29WbFF2ZUorS3pOMGxGcHlEd2FIeTZLdnBZVjlKTVE4?=
 =?utf-8?B?UkxKa3BQYnpVSDkzeEVrU0F6N1ZRMk1TZHd5Vm55a3hpS3NJMEUyZU50Z2sy?=
 =?utf-8?B?eFNIV01XYm5mSWhOVlNBK3JYWDBBdGZ0Wmp6QSszSjM0c25PNVFWMkRiUGh0?=
 =?utf-8?B?VVZqQXZHckVoMnFnMEJiMWRXMWJhRVkxNm50Q2owZXo2Zm0zalBQS2czSWs2?=
 =?utf-8?B?QlcwN0M0SDBpNzhHaXpLcFhSNHowcklWTE5tQ1JIKy9talVzQ0pFa2VabUhy?=
 =?utf-8?B?TDZCTmttbHNMZEVMMGttUkhoQUFaa29YNjgxRGtJSm1lWlFaenN4czFlMkNQ?=
 =?utf-8?B?alR0WHlVK1dhSkI3TTY3Z09CSHhyMmY1eGcxYUtwN0RHem9tTDlCellOeEZ0?=
 =?utf-8?B?aUpQKzI0QnJxTzZyVmJOM1JLV2x6eFBsZXlPNyt0RWJHTUpjd3p2QnFULzd4?=
 =?utf-8?B?WlA0aG9ZSWZyUzZHdHhxK2llR0thKzVLaGVhNWx5cFczYTRxNnhhNFM4d2lO?=
 =?utf-8?B?ZWVuaDYwS2F1MUF2SGQ1T0UvMmxiRmduZzNqUnBvUSs5YzNFblplclhPcEZq?=
 =?utf-8?B?eUN1YmJwZm51T1d4R204ekZEcFlUQVpJRk5XZ1F5R1ZWRWlESXlkOVQ5bksz?=
 =?utf-8?B?Tzh2Q1lkQVZEZ2xqU3NaQjZZTGc3L0h0dFN0LzlpNVNGL0RENHJJNGVGbmk1?=
 =?utf-8?B?bDA0UFM4ZTY2ZjhpR1NOdUs0bWxjcGsrOFdoQzFZV2U0RVBnb2hqYU9IQ0J2?=
 =?utf-8?B?ZisrMlhZSEdOOVVvd2dJVHV3T2Z3Yy9SekYwMlk2cW1WVjdFZmJaYVREMm54?=
 =?utf-8?B?eUFHUGRjUGthK2pBc2tBY0NHMUt3UWN2TGZ6QkxGSW9IMHk0c3ZoVzZCeHVa?=
 =?utf-8?Q?5ypTrJdZF2FJB/mH66IRnwEnhFqppI3bkwZn675TWsv1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13048f2c-c002-40a1-86d5-08db4588795b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 12:27:45.9894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V365t+ODeTkdIezFKOTI/l59CFIjVoqiKTbeRSzi6hvJEEh2IMnwci/V6wnsDxVG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, contactshashanksharma@gmail.com,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.04.23 um 19:38 schrieb Shashank Sharma:
> A Memory queue descriptor (MQD) of a userqueue defines it in
> the hw's context. As MQD format can vary between different
> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>
> This patch:
> - Introduces MQD handler functions for the usermode queues.
> - Adds new functions to create and destroy userqueue MQD for
>    GFX-GEN-11 IP
>
> V1: Worked on review comments from Alex:
>      - Make MQD functions GEN and IP specific
>
> V2: Worked on review comments from Alex:
>      - Reuse the existing adev->mqd[ip] for MQD creation
>      - Formatting and arrangement of code
>
> V3:
>      - Integration with doorbell manager
>
> V4: Review comments addressed:
>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>      - Align name of structure members (Luben)
>      - Don't break up the Cc tag list and the Sob tag list in commit
>        message (Luben)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 25 ++++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 57 +++++++++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 +++
>   3 files changed, 89 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 333f31efbe7b..e95fb35b0cb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -81,6 +81,14 @@ static int amdgpu_userqueue_create_gfx(struct drm_file *filp, union drm_amdgpu_u
>   		goto free_queue;
>   	}
>   
> +	if (uq_mgr->userq_funcs[queue->queue_type]->mqd_create) {
> +		r = uq_mgr->userq_funcs[queue->queue_type]->mqd_create(uq_mgr, queue);
> +		if (r) {
> +			DRM_ERROR("Failed to create/map userqueue MQD\n");
> +			goto free_queue;
> +		}
> +	}
> +
>   	args->out.queue_id = queue->queue_id;
>   	args->out.flags = 0;
>   	mutex_unlock(&uq_mgr->userq_mutex);
> @@ -119,6 +127,8 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>   	}
>   
>   	mutex_lock(&uq_mgr->userq_mutex);
> +	if (uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy)
> +		uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
>   	amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>   	mutex_unlock(&uq_mgr->userq_mutex);
>   	kfree(queue);
> @@ -149,6 +159,20 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   	return r;
>   }
>   
> +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
> +
> +static void
> +amdgpu_userqueue_setup_ip_funcs(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +	int maj;
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	uint32_t version = adev->ip_versions[GC_HWIP][0];
> +
> +	/* We support usermode queue only for GFX IP as of now */
> +	maj = IP_VERSION_MAJ(version);
> +	if (maj == 11)
> +		uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
> +}
>   
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>   {
> @@ -156,6 +180,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
>   	idr_init_base(&userq_mgr->userq_idr, 1);
>   	userq_mgr->adev = adev;
>   
> +	amdgpu_userqueue_setup_ip_funcs(userq_mgr);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index a56c6e106d00..9f7b14966ac8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -30,6 +30,7 @@
>   #include "amdgpu_psp.h"
>   #include "amdgpu_smu.h"
>   #include "amdgpu_atomfirmware.h"
> +#include "amdgpu_userqueue.h"
>   #include "imu_v11_0.h"
>   #include "soc21.h"
>   #include "nvd.h"
> @@ -6404,3 +6405,59 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
>   	.rev = 0,
>   	.funcs = &gfx_v11_0_ip_funcs,
>   };
> +
> +static int
> +gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
> +	struct amdgpu_mqd *gfx_v11_mqd = &adev->mqds[queue->queue_type];
> +	int size = gfx_v11_mqd->mqd_size;
> +	int r;
> +
> +	r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_GTT,
> +				    &mqd->obj,
> +				    &mqd->gpu_addr,
> +				    &mqd->cpu_ptr);
> +	if (r) {
> +		DRM_ERROR("Failed to allocate bo for userqueue (%d)", r);
> +		return r;
> +	}
> +
> +	memset(mqd->cpu_ptr, 0, size);
> +	r = amdgpu_bo_reserve(mqd->obj, false);
> +	if (unlikely(r != 0)) {
> +		DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
> +		goto free_mqd;
> +	}

This reserve/unreserve dance here doesn't seem to make much sense. Why 
do you do that?

Christian.

> +
> +	queue->userq_prop.use_doorbell = true;
> +	queue->userq_prop.mqd_gpu_addr = mqd->gpu_addr;

Are those the only two parameters needed? If yes we should probably drop 
the userq_prop structure and give them directly.

Christian.

> +	r = gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, &queue->userq_prop);
> +	amdgpu_bo_unreserve(mqd->obj);
> +	if (r) {
> +		DRM_ERROR("Failed to init MQD for queue\n");
> +		goto free_mqd;
> +	}
> +
> +	DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
> +	return 0;
> +
> +free_mqd:
> +	amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
> +	return r;
> +}
> +
> +static void
> +gfx_v11_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
> +
> +	amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
> +}
> +
> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
> +	.mqd_create = gfx_v11_userq_mqd_create,
> +	.mqd_destroy = gfx_v11_userq_mqd_destroy,
> +};
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 8d8f6b3bcda5..e7da27918bd2 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -28,6 +28,12 @@
>   #include "amdgpu.h"
>   #define AMDGPU_MAX_USERQ 512
>   
> +struct amdgpu_userq_ctx_space {
> +	uint64_t	 gpu_addr;
> +	void		 *cpu_ptr;
> +	struct amdgpu_bo *obj;
> +};
> +
>   struct amdgpu_usermode_queue {
>   	int			queue_id;
>   	int			queue_type;
> @@ -36,6 +42,7 @@ struct amdgpu_usermode_queue {
>   	struct amdgpu_mqd_prop	userq_prop;
>   	struct amdgpu_userq_mgr *userq_mgr;
>   	struct amdgpu_vm	*vm;
> +	struct amdgpu_userq_ctx_space mqd;
>   };
>   
>   struct amdgpu_userq_funcs {

