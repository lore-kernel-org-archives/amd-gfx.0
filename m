Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7ADC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 13:34:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0245B10F5D0;
	Thu,  9 Jul 2026 13:34:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iY+Bkawo";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1394510F5D0
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 13:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dS00y99F2jqvIddVuZtNREag+Iyd+0Pq97TgWJxyj9SRxZKqGey4TSeCdDEJC+5D46tCSwOqVRmct0HOBv81NIGZdJY5/1Y4s1Mg1AVL4AWf9uKdC3sxv99iB69Cw3EnJclwZuVx1gPE+JnJ3K7pTmDJBKmXoiIYtMGgEcUEO+f986aGcFQKBL+ZLPy+WSwGwYhkd0kUl7Vnzg3c+UxngcOuMIe5+ldxdEAiAFhtOAxhFgm2BlduJgs1KIwX4T6HkyBLF8yD+EgPLFAQXp9LNhsUv82FfaBLNvwf1vwU5rvfKXW9HngyHojAteL0P1fwmZWU1KHNX+/ZSszK0mmgkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Rlk7sNZNsGWtPZH+kVjQgZQlKL2o2BvAIqheeaAOzo=;
 b=pXDs7GacztZTCa5X5akRJ3ZKNI4TdsaBrCDFvrfOKzs8+t32ediMNpWmvCS2kP9h/m7YzMIt/afTyeuPVnWzg1SUJl08oEERr6msMhQyrhjJEDn2A0qsCCCaXDrC5stsdrcbWgSyQiuZswfNrmKRTS860H5m/YMgBkKzuX/XDvy6Dek9G3uMsHryNpP+ZeW9DHTEXqOPuHN+hN9kLNXBmDUNtZpkeLMcUSyM8b7yZASUF/9QdVdvNiQ1/0RVxM9XXWhKRhwlCKR1HvQhTCP052/ozFytsbTgZjKy8kBHtjNkuEKshfgjk7LJQahORq5In79aRFiBD4bGpYQhestE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Rlk7sNZNsGWtPZH+kVjQgZQlKL2o2BvAIqheeaAOzo=;
 b=iY+Bkawoxs/YIxP9py06fXxvmUMQ+larPKMvxvupM3pXLwlCkKaKzFAq1R1T6s6UiF9uw0+0LJMHy4pZ1wmZ39oHrGi+6VN0Vdg+izn6QwE0/337FqpUQZ+FL9jEUWSE7ItYThq//6vmwFhUwtgySYhlOtdnbSPwFCnb3rAC0QU=
Received: from BN1PR14CA0004.namprd14.prod.outlook.com (2603:10b6:408:e3::9)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 13:33:52 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::54) by BN1PR14CA0004.outlook.office365.com
 (2603:10b6:408:e3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 13:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Thu, 9 Jul 2026 13:33:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 08:33:45 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 06:33:40 -0700
Received: from [10.254.93.144] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 9 Jul 2026 08:33:40 -0500
Message-ID: <39e75329-7a72-4426-9abf-6dd0ab0b3902@amd.com>
Date: Thu, 9 Jul 2026 09:33:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amd/display: Use unbound workqueues for
 deferred DM work
To: Geoffrey McRae <geoffrey.mcrae@amd.com>, <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Harry.Wentland@amd.com>
References: <20260709031835.3395558-1-geoffrey.mcrae@amd.com>
 <20260709031835.3395558-3-geoffrey.mcrae@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260709031835.3395558-3-geoffrey.mcrae@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0d1746-ce59-4744-4890-08deddbeb5e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|42112799006|376014|1800799024|82310400026|18002099003|22082099003|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: 69TP78LINjuvPZiZpC3rW2lva1xrbqFpOTJTBESCgfrt8FzovzBx+uk/9PCsJFkeZP36QEJKfaROTO1glwZfeYBY9oxVDHsb6Z8qdwBfcZuy0w98lU0/ZNadmQKll999jR7EdCPBm6G0pGS/NG9WSOAGartFgrdwxCKEjTtJw6b3QSipDtKbyzrSyfIugH5T7Iyj8l9i0pPGXWeFVN4GfcRSaAWvoI8/TJCGUS9co6hhHdZbxH0LLJlzA5V8E6ZLaXL0J9jKn3GNxyNeQNr0USt2t9e4SNJmnnKzKkstZoHoMgNLWiDdwr1PYgx7Ov59Tfqz2J6QsO0TqhX9kWzY1c+krPOHz2qEH6I3onY7AaxMRrLNp3uixQaW4TcXybhR8KBEvOcELxUqn5voXNRS3Ws8FC3GrhGaxNQ941yS2tYwSsC609wje9VL7fhpn2tNHMpXqrrNUK94QdMLmYfzl6Mqu7yUGm0fnD8hHbJMjcwiP4kM8h0Ha1opoy9ocRYq7oCyPLC4ds9x37tSan8jplooYDHRkQzkuNrcMGUR/XPqmI0K1iEvhdegSnLg+6EtxvFqbjiZXDJC8J2B927UeKcd2rmJQmO2WlOh8GEy0K0uIoy7UNyf9f3dF6//5z9QQC5cwWEFU8+UwKATolPKDPDkTZ98EyDSyoFIQHr4CyYhll2zT1txtM83Fhy6DScXyKB1isZ/ejU5PtdlJBvoLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(42112799006)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i13emhTWhvlNFG/euP2NiKXizf29PE/E6fSBWYnR45215GlSyWTMNsr6MVGHROqAG7CQEyKmGE4bet3HRzmzOcdkzM1JLKIdOXuDJleDJP7zljgKqJdA2saAGL96mD5hdLDI866bwYEgZecHMvU1QbsesM2zIbeloYMJcEF5XEhpE5ORF7xLadVXe+PVp/lxMCRRtypxzUWAhUnCSpWbxvryYxLw8Nb/lu8ZqfXczjqi9cayZw9O9QGTi6a2XppP9hWqq+u9VsVG6Fkhy5YSt0V/Q7BsqyP5OOF9kGkaG8FuBQuDdp4FEMSYPpB0D6g+qDMl976jNTWMD9542Yfs96FrgiuSMdzckFIkk3KvGEz3Id6w7s6v1pYDIkWWpmzueYGBhIzwY/IzrhyU7Alm4by1fuPnac/0BAUTwpUyTOZiTZyxei4MXdD2MlBYWfEo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:33:49.7893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0d1746-ce59-4744-4890-08deddbeb5e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342
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



On 2026-07-08 23:18, Geoffrey McRae wrote:
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

Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks!

> Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  4 +++
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 31 +++++++++++++++++--
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 909ee71d6d59..643d40dd6e20 100644
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
> @@ -563,6 +565,8 @@ struct amdgpu_display_manager {
>  	dmub_outbox_params[1];
>  
>  	spinlock_t irq_handler_list_table_lock;
> +	struct workqueue_struct *irq_wq;
> +	struct workqueue_struct *vmin_vmax_wq;
>  
>  	struct backlight_device *backlight_dev[AMDGPU_DM_MAX_NUM_EDP];
>  
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index 20fdf0578119..1df15f02615c 100644
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
> @@ -478,6 +493,16 @@ void amdgpu_dm_irq_fini(struct amdgpu_device *adev)
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
> @@ -594,7 +619,7 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
>  		goto out_unlock;
>  
>  	list_for_each_entry(handler_data, handler_list, list) {
> -		if (queue_work(system_highpri_wq, &handler_data->work)) {
> +		if (queue_work(adev->dm.irq_wq, &handler_data->work)) {
>  			work_queued = true;
>  			break;
>  		}
> @@ -622,7 +647,7 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
>  
>  		INIT_WORK(&handler_data_add->work, dm_irq_work_func);
>  
> -		if (queue_work(system_highpri_wq, &handler_data_add->work))
> +		if (queue_work(adev->dm.irq_wq, &handler_data_add->work))
>  			DRM_DEBUG("Queued work for handling interrupt from "
>  				  "display for IRQ source %d\n",
>  				  irq_source);
> @@ -1882,7 +1907,7 @@ static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
>  	offload_work->stream = stream;
>  	offload_work->adjust = adjust_copy;
>  
> -	queue_work(system_percpu_wq, &offload_work->work);
> +	queue_work(adev->dm.vmin_vmax_wq, &offload_work->work);
>  }
>  
>  static void dm_vupdate_high_irq(void *interrupt_params)

