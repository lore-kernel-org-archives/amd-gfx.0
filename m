Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E50CA5FFF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 19:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0672110E1CF;
	Tue,  6 Oct 2026 19:32:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IQSQQqzX";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9855410E1CF
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 19:32:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeVSMui9+z3czpgxCyDqkn5T9Y7iSeh6ExptbyASJp8TFhQr8ljlGAgSUmK3dAd36aBCi2/qov7ZAkCgFavJO/0CJtW7A9EGVHqBQawcFFzKUYbhOct7RMgOwIwXxksHcg7bP5Nks6aqqnTQTCP+GaFoBgl25ZKrqM9/jVKQ4p3DTa1xt0oWbDkiCXsiDGWweVxlf9lLgR9m4OiryZQgod6bNRHUM4jwQKK6464UD8FGVGTzjCNVXfQgIs5cEXXiF9EIIb2J217nOrGP9YVCwUVKzarKFpPY/gjlok7JC2yEX8TPbZCdQP4XKICTUi9MRTY/AGMqiE9pRYZlc4leHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tq8UKuMMy7qLpCafiV+7+m5oMkQnhz/KoZeSBKEdW24=;
 b=hgC7yVyFPdY9vm2vRxmIQggPOKXm5zefj67ymU0stietz7/PZZH9RvGRaSr5FlE1lbIp1SL2DVLk2+07dTdBAspZ8mWAOB/HdRf25HQUMCYJN384WOd4CMvTgxL0WVHRjpVx4zp4ZgR9BZhGzJc3G940Kg5VfbyCNhgdoGYSsg+dhoDQdDN6DSFsPSa11hhLDai8ON0QCHo97/5f+4Pb3wGEODZ8vIWUCD0F/j/QfCHd8v61RwkXHtrBfA9WJyR1Mt5c6c8VkfxLa+VOTS5v3UH+dK9GWdxnPZu4s5xDABIsG4MPRoIS+vDlBvN0XCjzNY04Fj1+rfpxx9N1+rLOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tq8UKuMMy7qLpCafiV+7+m5oMkQnhz/KoZeSBKEdW24=;
 b=IQSQQqzX3s6KXyNAfQN56YWn6gOFjstLfKuamKhQTe0fe1SY1E6XCrCPiKeQJotrbE2zim/2LW9SY6eHVEjEdYkITq6teawX06QmiX9VukQA38KmwgQGb0N5RB1Vla1Ow6QBvYYUb0THNZFNqh7NBXUYXCmm6JSjGw+yoGDViYc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CH0PR12MB8486.namprd12.prod.outlook.com
 (2603:10b6:610:18a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 19:32:21 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 19:32:21 +0000
Message-ID: <73a76f1e-48ce-4e4f-9812-2fb79a1991c1@amd.com>
Date: Tue, 6 Oct 2026 15:32:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/amdkfd: fail fast on unplugged device in SVM
 migration paths
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Xiaogang Chen <xiaogang.chen@amd.com>
References: <20261006180242.52809-1-olivier.kaloudoff@gmail.com>
 <20261006180242.52809-4-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261006180242.52809-4-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0210.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::13) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CH0PR12MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: 3529035f-a092-46db-a7ea-08df23e08a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|18002099003|22082099003|10067099003|3023799007|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: rrpcVmz1uVUkIs1JUmXC/lPS81UlWwQmXzIqKZPOCKEsLY3P2JeA/UEiDbVNGy2+XrnFrolcc2pmXGEnZwhLACwYXSIt6Q81fPctbVGgH5l93yW5d+6lqI+mCWjsTM9Z0cXiWj2o7Q3+sBiLbUf6n6V1fHGpvMQtctZ2vCbs9UrwSgxRyM0ojJ9wCTyE7Q5gkWzwo0YYMiam8WsOvMu4XdeseOJKmJtWmVfYoacOsIqhkp5KTvVkzb3A7Y0X53L2ELu0b46gYYu0eBKvh2lvHOmNEyDx7IctQdTs6+HbCmTidE8szNV+MZ+q1MxIWr4aDmmV6ZLH3uktkgW23xJcRof+Tf127AiIhKvDpCJKXYsY0H9sM3Cunhg0ttKdb3f82IvYeuriFyrFK470jvjQ775Byih6dwMcoMMrhS5jTuvC9SzDGAdPxGOMTp+SiLa93/Dc6ltZBRBsUiegqmZhXsCXTOAd6Gw+yjj811xXu+qvzyACWP15WiBpA8cGi2B5/76H66i+KuPqDVoxFu2b3rnyJNiMkOTmQU+rWCY8qdQ7WqqstQqbnnwiIsccW3i7KmQf59xYB+mQwig7ySHKLHMYXKglYaat7cifUp+OueHApy7X7nlt3+8Imqp0MlUp5pdVwfTA6hv4AT8dCsUmOdGlZXbRKG0GRO2JZ5loYLk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3haMklPV1QzK1d2eXAvVHBpNjIxQ1dQaTlBVTJWTFhWbDViKy9pczNiTWhE?=
 =?utf-8?B?MGFJOVRad20xbTRlQnFENGt0YWFLYk8yVFJ1cDZpeXZZT2d2c0s0TVJIclY5?=
 =?utf-8?B?ZXpEZ2tVOTNXQ01na0x5emJVSlFuY3FlSWZvU1ptZmFIemhpNmdYTnlFRFp3?=
 =?utf-8?B?ZXNaVlJpOGdUUklWRTBHL1czbzRvdkY3eDVUQ1Z3V1lWOXFacjlqdG9CemE3?=
 =?utf-8?B?OFBOZVZPNndHRFFMOFRIcjFUUmlQdElDVG03eUhoZ1RTUVV3YlFtL2I5WDl1?=
 =?utf-8?B?bldvV29Ja254dVQ4dldkbzJ6a2ExMG9XMHp6b0U3SHRvTzFvMERudk5DRTBt?=
 =?utf-8?B?dTllbFo1VzBoNC9rQnNicmhjeFpMbUt6cGxWU3ZEK211cnBzRzRzcW5BVSt2?=
 =?utf-8?B?Z2xQZG1JRjNRUUpVVnVFQ1ZzNU5wblZhTHRPRUwrN3JSMzAxS0ozT2NxRmZ2?=
 =?utf-8?B?R2tkY284SFdzVzBGcFpkVGtQY1k2dWwyK09GUDEzU0xXL044TkZQOHhNQmE4?=
 =?utf-8?B?bmpaN0pNUHJrWFZXYmdVWURrUzhpTXF1azFTN0drV28vcGg2ZXo1cnFIY21D?=
 =?utf-8?B?UnF5OG1xNnZXN2FwZ0E2dk9jb1I3enhaUU5qdzNtdThNa2FQRnhVZmxpbFdD?=
 =?utf-8?B?Yms5NHpPSTRXV25Pb1pFMnpuQUVrNnEyNk41QXlMcE9DS0l3VmwzZkhWRExp?=
 =?utf-8?B?ejhhdFJsczFGaDFLVGIwYWk0SFFUV0puVytIVGJ6eklYdmswczRIMFN2T2VS?=
 =?utf-8?B?ZHFFcy9TM2RrSW51VmJjWVk2cjJ4d2VQeDRSbWw1RU1aMzJnSmJoUkxrRC93?=
 =?utf-8?B?Lzk5ckoxbnRuTVZ5KzdjeS83U2FidDBDUlhIQVFkeGhBb21hTU5WYU5zem1o?=
 =?utf-8?B?Z2FkZlN2dTEyL29IcnpjaElQa3pkZEw5LythdGZkNGhFclN2SDYyeGdNTlA2?=
 =?utf-8?B?ZWY5b1VGLy81dHg2Z1VOeVZKY29XcTcrcE9ucXNsWHl6NVo4dHcwOU9PV3h3?=
 =?utf-8?B?ODJZdHRyYnNLdWZzMDN2RGlYckVocE9RTzluem0zSjJob2c1ZWdjVW9zVnFi?=
 =?utf-8?B?RkRRcEcwQW9kM2xtQXZlRGFlWENFOHRTK1pzTWw1ZTRQc3F3dVlKMTlENjBx?=
 =?utf-8?B?UzdRSzJNdUMvZG1KWDRqbXRGS2lFYkxvRTg0TUZZRkI5K1NYbE9ldFZnN0Rn?=
 =?utf-8?B?ZGpOVGVhSGdjdW5peG01NXRGYmtNM1FTWE4zZnFjOTlHbENKcUw2K0YxYVhy?=
 =?utf-8?B?Nm5UNEM1VGNjckovanNmaXFmQ3RXd3dkeWlhUFJEVGIxQlFBVkEyVUhqc2R6?=
 =?utf-8?B?b0FlR1Q5NUtGekJCRm0xZGVHUDlsK3V2anN4cFFRL3VJOVRvVy9kYlBHQlQ4?=
 =?utf-8?B?NkowTUdHbkFtekhwSG5lVVBpbWpsMGU4SXMvN3hheGVScEYvTE4wTUt3L2p6?=
 =?utf-8?B?VHlIa0tCR2FXakFGNEVzUmk0dWF2d0ZJK240VUJybG1SbDVXNTcyeDFDU05x?=
 =?utf-8?B?dkU1RlVsN01lU0h6OUNJOGNuNjFEVExKcmNXTkVwN2U2a1dPSVh4SzZTVWQv?=
 =?utf-8?B?K1dTdElKUEpuVXhBL2JBWUZiR0VrVmhrM2h0bklmOGZrcTdsbk1tME5HMXhZ?=
 =?utf-8?B?eVpUNmttNCtwSGo4WEY1Uk9yNTF6akg5RXlpbHVQVjVqUlhRd0NvUVdiMEdK?=
 =?utf-8?B?SVNuNldOU1IyTjFnVkxkb3dxMWQ3cmdDUWoyNmR0Y2RaT0ovNjBvMWhnakN3?=
 =?utf-8?B?N21iZlNnOVpwNG1nSlZjdGsrV2ZUSzJMd01vVEVYSGZha1RzN2pidjZOTTFo?=
 =?utf-8?B?c0hoY012ajg1cFBuQWVXNUtGRytOdERWeUFuZnhZOEFGdTllR2dIOXoxNStx?=
 =?utf-8?B?bitZWmpMNi9Zdk9ndmZXbmpTWXhxUXZNTXNuV3hjMTkzUGJ4Uk1tdDJwOWtr?=
 =?utf-8?B?TWRsR0U4LzdGNGtQbk9ZUmNOdlk3SkJEZkdYdWZnTEdVenBEOFdIUjJUVUdo?=
 =?utf-8?B?VGE2bk5YQ1hUSzVLdnljOVpBQmxTcUthamN1Q29BbkhUMzZicTRlOVZuZ3Iw?=
 =?utf-8?B?NW9ERDFDdk5hQ1Y4NG45MVp1TlBSYVlEQmV1Vi9wOWMwQ0hDNDFuUHpabVp1?=
 =?utf-8?B?MVFrcnkyb3FXTFQ0eDVNVVF6VGpSMnVWdXVKbDZKdFBFdytqQXoyM0tBZGNS?=
 =?utf-8?B?d0R6TE1qWm5uRGQzQS9DVy8rQTBLZXhJSFNhaUFQYUVYc04vL1hJZEpjcklF?=
 =?utf-8?B?ZXU0VWVGWHNSVTRKemsyUnlyL2VGbEE1TFRraVd3L0NaSUhmak1hSVNTVDBQ?=
 =?utf-8?B?QkdKeW5wOUY4TXQzSlVPRmdKeFBZK2VLdzhJSkxFOUNpMjdZWjZWZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3529035f-a092-46db-a7ea-08df23e08a59
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 19:32:21.2051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcmIaX5dTE5ecXWMsx6SUvv6BpEMy1AQHLwi2uCsf4qGG/zpb1wW89lb3eucWoy5SeOv3UZUc7tfHAGqO9by9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8486
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


On 2026-10-06 14:02, Olivier Kaloudoff wrote:
> On surprise removal the killed process's own exit path can fault on
> its SVM managed ranges: SIGBUS -> coredump -> get_dump_page() ->
> __get_user_pages() -> do_swap_page() -> svm_migrate_to_ram(). Without
> an unplug check, svm_migrate_vram_to_ram() submits an SDMA copy job to
> an already-killed drm_sched entity (observed as
> "drm_sched_rq_add_entity: Trying to push to a killed entity" plus
> refcount_t saturation warnings), then svm_migrate_copy_done() waits
> uninterruptibly on a job fence that can never signal. The task dies in
> D state holding svms->lock, which wedges svm_range_restore_work() on
> the rwsem writer side, so kfd_processes_count never drains and the
> pciehp removal thread wedges for good.
>
> Fail fast instead of submitting work to a dead GPU. Check both
> drm_dev_is_unplugged() and pci_dev_is_disconnected(): the PCI flag is
> set as soon as the link drops, which can be well before
> drm_dev_unplug() runs in the removal path.
>
> - svm_migrate_vram_to_ram / svm_migrate_ram_to_vram: return -ENODEV
>    for a gone device, so the fault path turns it into VM_FAULT_SIGBUS
>    and the dying task can die
> - svm_migrate_copy_done: skip the fence wait on a gone device, and
>    bound the wait to 10s otherwise to survive unplug racing in between
>    job submit and wait
> - svm_range_restore_work: do not reschedule on -ENODEV, mirroring the
>    userptr restore worker fix
>
> Verified on MI50 behind Thunderbolt: with these checks the workload
> takes SIGBUS, coredump completes, kfd_processes_count drains in ~4s,
> pciehp removal finishes, and the device re-enumerates cleanly on slot
> re-power. Previously the same repro wedged the host.
>
> Cc: Xiaogang Chen <xiaogang.chen@amd.com>
> Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
> ---
> New in v3.
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 30 +++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  2 +-
>   2 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 253365a..3568eb2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -202,7 +202,21 @@ svm_migrate_copy_done(struct amdgpu_device *adev, struct dma_fence *mfence)
>   	int r = 0;
>   
>   	if (mfence) {
> -		r = dma_fence_wait(mfence, false);
> +		/* Job fences on a dead device never signal */
> +		if (drm_dev_is_unplugged(adev_to_drm(adev)) ||
> +		    pci_dev_is_disconnected(adev->pdev)) {
> +			r = -ENODEV;
> +		} else {
> +			long ret;
> +
> +			/* survive unplug between submit and wait */
> +			ret = dma_fence_wait_timeout(mfence, false,
> +					msecs_to_jiffies(10000));

I'd avoid arbitrary open-coded timeout values. Would 
AMDGPU_FENCE_JIFFIES_TIMEOUT work? It's currently half a second.


> +			if (!ret)
> +				r = -ETIMEDOUT;
> +			else if (ret < 0)
> +				r = ret;
> +		}
>   		dma_fence_put(mfence);
>   		pr_debug("sdma copy memory fence done\n");
>   	}
> @@ -507,6 +521,13 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   		pr_debug("failed to get kfd node by id 0x%x\n", best_loc);
>   		return -ENODEV;
>   	}
> +	/* Fail the migration on a device that is gone for good */
> +	if (drm_dev_is_unplugged(adev_to_drm(node->adev)) ||
> +	    pci_dev_is_disconnected(node->adev->pdev)) {

This seems racy. Should we use drm_dev_enter/exit instead?


> +		pr_debug("gpu 0x%x unplugged, skip migration to vram\n",
> +			 best_loc);
> +		return -ENODEV;
> +	}
>   
>   	pr_debug("svms 0x%p [0x%lx 0x%lx] in [0x%lx 0x%lx] to gpu 0x%x\n",
>   		prange->svms, start_mgr, last_mgr, prange->start, prange->last,
> @@ -841,6 +862,13 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   		pr_debug("failed to get kfd node by id 0x%x\n", prange->actual_loc);
>   		return -ENODEV;
>   	}
> +	/* Fail the migration on a device that is gone for good */
> +	if (drm_dev_is_unplugged(adev_to_drm(node->adev)) ||
> +	    pci_dev_is_disconnected(node->adev->pdev)) {

Same as above.


> +		pr_debug("gpu 0x%x unplugged, skip migration to ram\n",
> +			 prange->actual_loc);
> +		return -ENODEV;
> +	}
>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu 0x%x to ram\n",
>   		 prange->svms, prange, start_mgr, last_mgr,
>   		 prange->actual_loc);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index fa4054d..e209ed7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2014,7 +2014,7 @@ out_reschedule:
>   	mutex_unlock(&process_info->lock);
>   
>   	/* If validation failed, reschedule another attempt */
> -	if (evicted_ranges) {
> +	if (evicted_ranges && r != -ENODEV) {

I'm not convinced this is needed. cancel_delayed_work_sync in 
svm_range_list_fini should take care of terminating the worker, even if 
it rescheduled itself. It's more of an optimization to avoid 
rescheduling the worker unnecessarily when it's known to be useless.

Either way, this would make more sense in patch 2, since it's similar to 
the restore_userptr_worker change.

Regards,
   Felix


>   		pr_debug("reschedule to restore svm range\n");
>   		queue_delayed_work(system_freezable_wq, &svms->restore_work,
>   			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
