Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020C8C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 10:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9707B10E986;
	Fri, 10 Nov 2023 10:49:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E896D10E986
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 10:49:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zq7e/uiYrKS5K+8CLPqwV5UqnpxBSRL6kOUy1uZ7JPuVay9596KOxqLY7doVp69+4A7EY22xo36S51Jrfmw+GR2ZrM6ZJIhZpgzI74I6qY+oXecelHr/yh7p/v0MoYFOI8qQh0xKDA8xuBw+lA1z+06koz2emz+wBKVMiCxoRJAyozdwWBvAPV0v6gOybGZb19PodJHV+P4O4ZN3LU9cZ1ZmD7v9xxsDzRAPHi4Kz8a0Tmw2NQbozb/h62/AcOY6ZGCvSE1qnsnrYoLZVas02b3V71RmW3DvvCIAKY3B9JmT0m5Vjm1NGgQm7v7a48OzEhV94XEYZVGXLVLVquX5Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arj6BSxh5Noxm6S5N9FcflcAqkiTcNFRzj8CLq7cFQk=;
 b=WYevMWQBeXo/MBwFjZpWNoJbm/TXDZUMtCNOkp+7bob38oDP4iEUUWq7Rb0mKsnyERtbhc0MiiNiU8RvV05QzveOrff1dSBbif3H4tum3C1RmZGQGCcIDoDv8pJeu0QDaL07R39QzW9pxVrLt7UGSRdvbbmYg0DOngoAJ/IHy+rbbJd9gutcDgYP0x6m6Df/jugGSN6P+aoCPjIduW/tIXWuJ8vSjGhzpLa61zssN15P+Mc03I/3iFtpRO4ye04HvW6/hc6pTwwKGAvulQoCfoPxq1q1YyC7ekbbm6MCuqrlpC1ntpsMKucvpcvO510EQ9S0I5AfkIpS3W51PdPYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arj6BSxh5Noxm6S5N9FcflcAqkiTcNFRzj8CLq7cFQk=;
 b=5W3RGBTgTcNhBrMpNpp+9ezieK59T8/dxJgh9Zzfup58owFAc+z9DYxEMkcgAKq39SmzATLkYu5K30K3LU8uJ4nWPTHfgapcCVyQuSG8IPRZgG0PzdJeUaiAnoHXGcnSDhtoWzwPplFc+XtHeLf7IQRdScsdH2t0ZPJ4IgCaQHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 10:49:12 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c258:1e94:a85b:1510]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c258:1e94:a85b:1510%4]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 10:49:12 +0000
Message-ID: <805b31f8-3a49-c7c6-3f7e-044ff35fbfa4@amd.com>
Date: Fri, 10 Nov 2023 16:19:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: Skip execution of pending reset jobs
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
References: <20231109073813.552664-1-lijo.lazar@amd.com>
In-Reply-To: <20231109073813.552664-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::35) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MW4PR12MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b247ec7-2e47-41e0-e272-08dbe1daacb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQ/M+F0OsDL9AA3nXF3l1H+3M80zYMmjX5y0ZVzjrlYqnlU+3TfTDokOu7Dzf8Hpv9LDJ3fa5BBkfc3Dz+tl8nQE2Waxlk+l9g2ckZhAQvH2qHKr0fmmQ9rhplTIwBbzGjWOq9yYARvtUqGJg6wt6e2e8OS0AuNXhat/2dF/NhUw/9hgg01iGtjMt2f2WBufmvjXp9v60MCzV4OO3tIcZvNkfRErOqjTtk8XwPSrp180AYNdhK3HWA5k8r6mNcIx8QFAEVy7BHrU6AYq1teqqEGrZoT7Am7TkFyOvB5lbOHepwl+qmoMvOMVq68RaVbH4Idc6WigMS0WZGSrxKvq4Calkt142MG8tinM86a3XrnRaRCxsGCYcfMY5csU3sKEN63x5AJb81yyRmFYFl45Qi7Vbbz40kRsS3JPS1sf2dy/RajNClYiT/+TBiGwxusKfenONe3ZAG6fCdlt1uHlgNAtzL7ZiZvpoVqqNBBzUmvfXQe/sKFxgGdJOLYoux6HT+AbpsP7ND+iyBahM0Cmd7gb4FjHNPqQf5jwdApnMzrdMgRSLog//H/H97wUZFLH0X82TydzD2w5I8VFthbN9Ho6l28+LSk0wjLzfLV1xUa2D5VhpQDXGOwic9QifyVPqESjRM+VoLXmqIL7b9zJNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(4326008)(8936002)(8676002)(41300700001)(5660300002)(2906002)(36756003)(86362001)(31696002)(26005)(53546011)(31686004)(6512007)(6506007)(6486002)(478600001)(6666004)(2616005)(66556008)(66476007)(83380400001)(38100700002)(66946007)(6916009)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czRmWlo5b3NXbnN2cXZJMVVOWVJyYS9xR1BKbUMvOWE2S1ViL0l3S0ZSL0s2?=
 =?utf-8?B?Q0g3V0ZsRURseVRDZDdlZzNrUm9XazNVVEVUR0ZaN20vUURwQXpHM2RFTHV4?=
 =?utf-8?B?NHp4MUxETXJZNmRNaEUwTzZXRDBwQTV5QTlLNk9nd2ZzSVJwcWcrMGRoUFZF?=
 =?utf-8?B?V3p4ZEhnWEtrdzRxMUxoRmhZcVowT0lWWjJ6c2pwd05jd0dub09HbkozM1N6?=
 =?utf-8?B?ZkNUUWsrN3F1eENhSGdwOWFaQ1RJWEdCRWhlY1pmS25wTVFIYmlJMVo1UlVK?=
 =?utf-8?B?NXFiWHFmMUVtS2hnd0tpL1h2YlA3ZEo3SzRaVXJFUnZDWGlyZ2wwS2ExVkh2?=
 =?utf-8?B?RnRaT2Q5cHlzMEtqU2pVMDlnaEVHUDF1ODFicUNTNmVjbkxaZ2gyTkZFT3pj?=
 =?utf-8?B?SDk4VVluQUQ3eGk5akgzMVdsenlONkZkdGlLUVVUZ0pwYk9pR05zOWZVQXlD?=
 =?utf-8?B?NWNLT09WdXQ4dnAwc2ozbklqUUpmdHdaNTgxRnluRUpIWnU0UVIzTU1laXRu?=
 =?utf-8?B?bnRCVCtkWEl1bDhZS0JHaDRReThTR054dUZmNmZPVThzTjRaN1grNzVCYVZR?=
 =?utf-8?B?R1pSTW5hekhBLzM3RmY3dnpBNDJBZHlaL2ZKZ2pCNUNMdVZrc2JUdmRvSjlU?=
 =?utf-8?B?a0h1YmE2VW90azZvcmNIZmp4U09NQXJWTTJvNk5zNGI4NlVwbDg0LzlUWUJQ?=
 =?utf-8?B?MXFackVnbS84b01TODAycTE4UkRxOWM2TlpPZkZIcExkN1FIN0lhRzBkODVD?=
 =?utf-8?B?V25nQzRaMEROaExCcnA0eUxhWUpTNzExTjgwZmZwTnhLMHkrWHVSbDdISDVh?=
 =?utf-8?B?dGswdldUN1V2Q2FtNEtZQng4OGJqMkhHWFNwMkI2ZXRMV2hkbjNEYkROTTF6?=
 =?utf-8?B?cVJWamhwdmJ1eUdvaVFhb1hXdzRBdStoaGZWWDZXMUtVZUxZZzFvYTlWWDRz?=
 =?utf-8?B?V2FPcUgxSVVRcXhqWGRUL1VxczR3aDZUQ3U1NnpPRVVlS09QRXdJc3Y4Mk9a?=
 =?utf-8?B?QjVXTnhBVThDL0grdG1hTjhUMEQwZlRIMFd2S0Y2aXMzdU5ZTkM1Z1lWTU5z?=
 =?utf-8?B?MzU2ZzF2NXp4akQrRzRXY3lhOXZXTFlPVW9iZ0U1bVViQUFYcHlGR3JQNWo4?=
 =?utf-8?B?WnZkczRCdzAxQ2JSME55TGZjRlAzSVFiRitkWXo4ajRxakxkcFErMnc3dXlt?=
 =?utf-8?B?WHFCUzNQVnNSWW5XV2lXaG9sRUw4OE53NzhBdExpS0QrZDVWVHVKVUJod1hE?=
 =?utf-8?B?S28wNzVuS1J1NCsvdXhSTzBwZ01KWFdqVGVDTmt3L1J0UG0zanNJb1lxcTRp?=
 =?utf-8?B?cDFVdkNYY2RpOVdabDVBVjh3MU5jWUR2bmhIMTBWZXVnWkM4emFmeFB6K0Mw?=
 =?utf-8?B?RUFkZlZiRkFrM0pxVGQ1NGRrQ1VFVEFYTFZYa0U4Smw0UTV5TUNZQ0VyVkQw?=
 =?utf-8?B?UGR3OXdlbVVEcFZENkc0MVVRcEtpWnVidUpiaUcvK2RscGd1emVabXg1Zkp5?=
 =?utf-8?B?R1hRdDZiR1VmSkE3U3R3YzArUGRRNGNRczByTTBENGVBamNQbkxWcHYrMWtn?=
 =?utf-8?B?TXNETDBxUXBCM1hNZGxlUDA4aHRKdHprRHU4V3g2TmdpdDc0NGJCam53T2Iv?=
 =?utf-8?B?dERobmZmYzBQMDNEREdPV2xqMXcxL2pFZWFDNXRYbWFtMHJQeWtYTEx2Yk1X?=
 =?utf-8?B?S1VQMGpXVlVzTkhKYXc5QUQzSWxRalpndi9VVVFQVnV2TDJpTkZVeFk4M1ls?=
 =?utf-8?B?K3Q1MDFnNC8xd1NleUpvK2JuTDdzV1YwVmdhN1F0cmR0dHFxdUpKVWpPSGdv?=
 =?utf-8?B?TE0xckVxdnRZeG5Vd1VDZ0MyVEY2VDFXd0lCV0dLTDhjRUVSNHdMazVZeHpp?=
 =?utf-8?B?UFZibGcyKzZTZEVRdW4vWDU1bEhiTVBrN2lMQU9RTUg0MThYVkd1d0tBb3dU?=
 =?utf-8?B?S2FvWWhBVEpjNnlYVmFSMHcxc3p0K2ZYeGkveGQ1S0s0QTJwcVgyN0dDejZl?=
 =?utf-8?B?WHVYN2YwbS9FOHViSHVrcC9BdGwwRkRVb3orNGdtN2RZeUVXYmQrR1FMVmpt?=
 =?utf-8?B?TWpWdU12dWdwVjBMcGczQStqRlZ0SU5FNzYzUnUwTjhvcWFVTUZLWjVqbnBI?=
 =?utf-8?Q?QtN99ZWatO3Rrz7Ia67Z0wvQK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b247ec7-2e47-41e0-e272-08dbe1daacb1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 10:49:12.3582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFh4U84ILxBfV4YfMitpo+Rm4cC7UQ93nUdscT+BfBHvuxyL3sydaZdFEQrVG/2W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6921
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<Ping>

On 11/9/2023 1:08 PM, Lijo Lazar wrote:
> cancel_work is not backported to all custom kernels. Add a workaround to
> skip execution of already queued recovery jobs, if the device is already
> reset.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  9 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 16 ++++++++++++++++
>   3 files changed, 30 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index bebc73c6822c..c66524e2a56a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5411,6 +5411,8 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>   
> +	amdgpu_reset_domain_clear_pending(adev->reset_domain);
> +
>   #if defined(CONFIG_DEBUG_FS)
>   	if (!amdgpu_sriov_vf(adev))
>   		cancel_work(&adev->reset_work);
> @@ -5452,6 +5454,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	bool audio_suspended = false;
>   	bool gpu_reset_for_dev_remove = false;
>   
> +	if (amdgpu_reset_domain_in_drain_mode(adev->reset_domain))
> +		return 0;
> +
>   	gpu_reset_for_dev_remove =
>   			test_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_context->flags) &&
>   				test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 4baa300121d8..3ece7267d6ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -120,6 +120,14 @@ void amdgpu_reset_destroy_reset_domain(struct kref *ref)
>   	kvfree(reset_domain);
>   }
>   
> +static void amdgpu_reset_domain_cancel_all_work(struct work_struct *work)
> +{
> +	struct amdgpu_reset_domain *reset_domain =
> +		container_of(work, struct amdgpu_reset_domain, clear);
> +
> +	reset_domain->drain = false;
> +}
> +
>   struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_domain_type type,
>   							     char *wq_name)
>   {
> @@ -142,6 +150,7 @@ struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
>   
>   	}
>   
> +	INIT_WORK(&reset_domain->clear, amdgpu_reset_domain_cancel_all_work);
>   	atomic_set(&reset_domain->in_gpu_reset, 0);
>   	atomic_set(&reset_domain->reset_res, 0);
>   	init_rwsem(&reset_domain->sem);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index b0335a1c5e90..70059eea7e2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -87,6 +87,8 @@ struct amdgpu_reset_domain {
>   	struct rw_semaphore sem;
>   	atomic_t in_gpu_reset;
>   	atomic_t reset_res;
> +	struct work_struct clear;
> +	bool drain;
>   };
>   
>   #ifdef CONFIG_DEV_COREDUMP
> @@ -137,6 +139,20 @@ static inline bool amdgpu_reset_domain_schedule(struct amdgpu_reset_domain *doma
>   	return queue_work(domain->wq, work);
>   }
>   
> +static inline void amdgpu_reset_domain_clear_pending(struct amdgpu_reset_domain *domain)
> +{
> +	domain->drain = true;
> +	/* queue one more work to the domain queue. Till this work is finished,
> +	 * domain is in drain mode.
> +	 */
> +	queue_work(domain->wq, &domain->clear);
> +}
> +
> +static inline bool amdgpu_reset_domain_in_drain_mode(struct amdgpu_reset_domain *domain)
> +{
> +	return domain->drain;
> +}
> +
>   void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain);
>   
>   void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain);
