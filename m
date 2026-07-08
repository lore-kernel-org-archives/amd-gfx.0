Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701ECC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 21:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E902E10F2D2;
	Wed,  8 Jul 2026 21:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sB4M3MRW";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EE5710F2D2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 21:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZWu2REUsYc3W9VneNlK4EwYo24nQGdfhslinyL524PtEOvVVqHiHlGiyZ1P7HtRvzVaj0DZwenIgYbGfWR7zAxihjnhULXVC4tX6esSCU8ieiWA2bnyaR2niuqERqLyi/jE2kFD9bW3pZjnCPyMSPULgQYdnJxwpEjnJnNdqQcCcDOpl3WAUKFyGdLo6p26EZqV9JcC9VOeqgnQJq4CkgmTaE7n7N+wa7oT5kLT/w1mOq3Xul6D+tTAW3BkrETg3bQ/JGoyDuHfSnnqm9qXFLViYQMek1Ymmw0jH/2PiQDy1rCnqGtiH/n3MHup8gNPWSSsKXJNlAsqOQmE02/k5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGo1cm8L95aYFg4hkIsWf6McK2A8CBrrIV+iZBeLOD0=;
 b=wT4x8Uhsao2pOBW0rubAdU7Fre147eywRe3e3Fm6NEeHSV+7BxKikNqVb/CG+DYNkXJmH2Kn2w4p9TDMcq9n562YmlLhzl/WvbOyrLZU72ESYZrDGdU6tqAQsBzbcJO1vI8maKVibGBZbcDNbBiVjU25ZQqWY4ME0BwHonfQbzcFkqaOIazCv94vv0DsVTvobbOyTXl08T/xEx0cNQMpycDziCEg+4hujUGdTWr4ZHiqZTu2s9k6SqW7ImNbQRdtD5CR+fHZ7Dyt7PpO1DaU9Z3yp2FyQyNSupSFlqaJdeWsOZMXPGrUvevA0n99x+pEIwxhoFrXtaztu8u9WL43lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGo1cm8L95aYFg4hkIsWf6McK2A8CBrrIV+iZBeLOD0=;
 b=sB4M3MRW3tmu2NCMi5JwqKKgCcwv66THW/lZFcu4/HPkeJHmpaXkz0Vl9MMVuas2cYf2D8/7qjTug79y/uxb9lrm1bfbYHAIp+Iu90xa79srvsHWsgkqEn7wko6xzw4P8eaKSjHCdznQE/v5OITlq4QSS/gO4WOopgbHZeW7UYk=
Received: from LV3P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::17)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 21:41:36 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:234:cafe::8c) by LV3P220CA0012.outlook.office365.com
 (2603:10b6:408:234::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 21:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 21:41:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 16:41:34 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 14:41:34 -0700
Received: from [10.254.93.144] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 8 Jul 2026 16:41:34 -0500
Message-ID: <6f0517d1-df13-4a93-bdf7-9f91ccd24a01@amd.com>
Date: Wed, 8 Jul 2026 17:41:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/display: Use unbound workqueues for deferred
 DM work
To: Geoffrey McRae <geoffrey.mcrae@amd.com>, <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>, "Harry
 Wentland" <harry.wentland@amd.com>
References: <20260629165129.5550-1-geoffrey.mcrae@amd.com>
 <20260629165129.5550-2-geoffrey.mcrae@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260629165129.5550-2-geoffrey.mcrae@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: c16fe949-2c67-45fd-13dc-08dedd39aefc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|42112799006|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: Oi6Jsnt3R063ORT8cjGWaqP5AeBe+uub/N984eAAP4k0/cvfGDM4diGTrGxxpAcKu8OGJE5FFIHOK7e7Zgjg/svJZf0PBKy8Z5XQO+qZTjeDEPRHHnQkjxB4rtel+c0xwxFNpxRVP8lSjgmtgYcibiW7kjA4xqKZYtvZTbkuCgYfxG69mcKh7YFYOQrm+zdz88+AsEcbXuL2Ai3xMZAhBkifHJnlZPvBELWc/KEcBnBzp03cPGy7z7tzkGTP3OEqMAubVrIlxkMMBbjzIi+Iw9Qm/qvKOHe/RCABkGkerhpXy9fpxYJIiM4oihshL8cfSD+sNT+Rw2HGUsYgRw4G+IArKuyL2jqvvYpdBumnwdCUGYjz+abZeFIqSKOomCmRZvCduvPnTVAHPzUz5TWFk2QK03GjnqnyOhQ7IGCeMqanUdb0sUL9YC/hrCcsZOl4DWk4Hu5khWm5IJxzAkoaYnXxV4VLmplA142qJs61mb1ful2OYTHsrpUzYv4DOHm3x4LrbmW65M4W+zdy47bVMYBE3kLVaUJThZerh3e5T83dbry09b/wcqiTe1FhMwGgRgFwxXw9izuFLKnZXj646FEl1k8fBso2wFOXqfGof+SlIAqCpnxEjW1mpMtkUyUjgh5G43t3YGhIgrWkR3FhPOHjKH1xnZWGguFfks19yloWeTWx7kTwvuK0FlJwsYYGPgwLE80gGjhuIuKykVm/gA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(42112799006)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k9YAi4giITLuCwPh24VQWtQ3mnys5GjzQ+mzvKXaxCWYmN1H0eOeDsaaxAPep/yTeHyyfgYTO22xJd9/39qDBADGOi9axgW6FeKFX2UOTmpeSPB33ztTuzqKEqWwFzCDhw+r9Maw3XkXJSSY+uDpYJqwHIVuPQ6J4SjQY98swne+AYHsfzDt+WwvUxWTa1ys4uEzd45RWPyVaEt4rP5HAa/vHigx/6LjHcQVHO1u97GOU0ftKB89V4U5g9ImT2cB5IfCMQAWknAt/dn9NUj1neFo6cEtZASVZce+y49arkW4EOLE+6yCIAXelH6f8kd5NTGo7CHH/jzKZqzFGaeDHK+HNf8cLWpCU3wvUkLL0aJh7gaNB1EFKwJ3iO/ijaOMgi5+CylrFDzDn1ARJNYUsczHPdrCzN1NMIElcCfphZFaYZAx1GI61sqIWAKsR7Zx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 21:41:35.1427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c16fe949-2c67-45fd-13dc-08dedd39aefc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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



On 2026-06-29 12:51, Geoffrey McRae wrote:
> DM currently queues some deferred display work on system workqueues.
> Low-context IRQ handlers are queued on system_highpri_wq, while deferred
> vmin/vmax updates are queued on system_percpu_wq.
> 
> Both paths can execute long-running display work. HPD and HPD RX handling
> may involve link detection, AUX transactions, connector state updates, and
> hotplug notification. The vmin/vmax update path calls into DC under
> dc_lock to adjust stream timing. These paths can therefore trigger the
> workqueue CPU hog detector when run from per-CPU workers:
> 
>   workqueue: dm_irq_work_func [amdgpu] hogged CPU for >10000us
>   workqueue: dm_handle_vmin_vmax_update [amdgpu] hogged CPU for >10000us
> 
> Move the deferred low-context IRQ work to a dedicated high-priority
> unbound workqueue, preserving the priority of the previous
> system_highpri_wq usage while avoiding long-running work on per-CPU
> workers.
> 
> Move deferred vmin/vmax updates to a separate normal-priority unbound
> workqueue.
> 
> High-context IRQ handlers remain unchanged and continue to run directly
> from the IRQ path.
> 
> Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  4 +++
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 34 +++++++++++++++++--
>  2 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 88687a7e01a5..4a7965f76acb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -324,6 +324,8 @@ struct hpd_rx_irq_offload_work {
>   * @ddev: DRM base driver structure
>   * @display_indexes_num: Max number of display streams supported
>   * @irq_handler_list_table_lock: Synchronizes access to IRQ tables
> + * @irq_wq: Dedicated high-priority unbound workqueue for deferred IRQ work
> + * @vmin_vmax_wq: Dedicated unbound workqueue for deferred vmin/vmax updates
>   * @backlight_dev: Backlight control device
>   * @backlight_link: Link on which to control backlight
>   * @backlight_caps: Capabilities of the backlight device
> @@ -565,6 +567,8 @@ struct amdgpu_display_manager {
>  	dmub_outbox_params[1];
>  
>  	spinlock_t irq_handler_list_table_lock;
> +	struct workqueue_struct *irq_wq;
> +	struct workqueue_struct *vmin_vmax_wq;
>  
>  	struct backlight_device *backlight_dev[AMDGPU_DM_MAX_NUM_EDP];
>  
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index 3a5de9364ed1..f4bfd7e42f9a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -397,6 +397,21 @@ int amdgpu_dm_irq_init(struct amdgpu_device *adev)
>  
>  	spin_lock_init(&adev->dm.irq_handler_list_table_lock);
>  
> +	adev->dm.irq_wq = alloc_workqueue("amdgpu_dm_irq",
> +		WQ_UNBOUND | WQ_HIGHPRI, 0);
> +
> +	if (!adev->dm.irq_wq)
> +		return -ENOMEM;
> +
> +	adev->dm.vmin_vmax_wq = alloc_workqueue("amdgpu_dm_vmin_vmax",
> +		WQ_UNBOUND, 0);
> +
> +	if (!adev->dm.vmin_vmax_wq) {
> +		destroy_workqueue(adev->dm.irq_wq);
> +		adev->dm.irq_wq = NULL;
> +		return -ENOMEM;
> +	}
> +
>  	for (src = 0; src < DAL_IRQ_SOURCES_NUMBER; src++) {
>  		/* low context handler list init */
>  		lh = &adev->dm.irq_handler_list_low_tab[src];
> @@ -491,6 +506,16 @@ void amdgpu_dm_irq_fini(struct amdgpu_device *adev)
>  		list_del(&handler->list);
>  		kfree(handler);
>  	}
> +
> +	if (adev->dm.vmin_vmax_wq) {
> +		destroy_workqueue(adev->dm.vmin_vmax_wq);
> +		adev->dm.vmin_vmax_wq = NULL;
> +	}
> +
> +	if (adev->dm.irq_wq) {
> +		destroy_workqueue(adev->dm.irq_wq);
> +		adev->dm.irq_wq = NULL;
> +	}
>  }
>  EXPORT_IF_KUNIT(amdgpu_dm_irq_fini);
>  
> @@ -610,11 +635,14 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
>  	if (READ_ONCE(adev->dm.irq_fini_in_progress))
>  		goto out_unlock;
>  
> +	if (!adev->dm.irq_wq)
> +		goto out_unlock;
> +

Do we need this check if amdgpu_dm_irq_init() bails when dm.irq_wq fails to init? No
handlers should be registered in that case.

Patch 2/2 LGTM otherwise.

- Leo

>  	if (list_empty(handler_list))
>  		goto out_unlock;
>  
>  	list_for_each_entry(handler_data, handler_list, list) {
> -		if (queue_work(system_highpri_wq, &handler_data->work)) {
> +		if (queue_work(adev->dm.irq_wq, &handler_data->work)) {
>  			work_queued = true;
>  			break;
>  		}
> @@ -642,7 +670,7 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
>  
>  		INIT_WORK(&handler_data_add->work, dm_irq_work_func);
>  
> -		if (queue_work(system_highpri_wq, &handler_data_add->work))
> +		if (queue_work(adev->dm.irq_wq, &handler_data_add->work))
>  			DRM_DEBUG("Queued work for handling interrupt from "
>  				  "display for IRQ source %d\n",
>  				  irq_source);
> @@ -1905,7 +1933,7 @@ static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
>  	offload_work->stream = stream;
>  	offload_work->adjust = adjust_copy;
>  
> -	queue_work(system_percpu_wq, &offload_work->work);
> +	queue_work(adev->dm.vmin_vmax_wq, &offload_work->work);
>  }
>  
>  static void dm_vupdate_high_irq(void *interrupt_params)

